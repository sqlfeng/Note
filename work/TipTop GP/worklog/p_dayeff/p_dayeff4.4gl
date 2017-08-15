# Prog. Version..: ''     
# Pattern name...: p_dayeff2.4gl
# Descriptions...: TSC 每日问题处理效率-客户
# Date & Author..: 111021 by leo
# mod dayeff2->dayeff4  tc_ser01->tc_cust01

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

   DEFINE tm  RECORD				# Print condition RECORD
	        wc   VARCHAR(500),		# Where condition
                s     VARCHAR(3),		# Order Sequence
   	      more VARCHAR(1) 		# Input more condition(Y/N)
              END RECORD

DEFINE        tc_ser06_b  LIKE tc_ser_file.tc_ser06
DEFINE        tc_ser06_e  LIKE tc_ser_file.tc_ser06
DEFINE   g_orderA        ARRAY[3] OF VARCHAR(10)
DEFINE   g_i             SMALLINT   #count/index for any purpose
DEFINE   g_gth13         VARCHAR(50)
DEFINE   g_gth10         VARCHAR(50)

MAIN
   OPTIONS
       FORM LINE     FIRST + 2,
       MESSAGE LINE  LAST,
       PROMPT LINE   LAST,
       INPUT NO WRAP
   DEFER INTERRUPT				# Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("CZZ")) THEN
      EXIT PROGRAM
   END IF


   LET g_pdate = ARG_VAL(1)		# Get arguments from command line
   LET g_towhom= ARG_VAL(2)
   LET g_rlang = ARG_VAL(3)
   LET g_bgjob = ARG_VAL(4)
   LET g_prtway= ARG_VAL(5)
   LET g_copies= ARG_VAL(6)
   LET tm.wc = ARG_VAL(7)
   LET tm.s  = ARG_VAL(8)
   #No:FUN-570264 --start--
   LET g_rep_user = ARG_VAL(9)
   LET g_rep_clas = ARG_VAL(10)
   LET g_template = ARG_VAL(11)
   #No:FUN-570264 ---end---
   IF cl_null(g_bgjob) OR g_bgjob = 'N'		# If background job sw is off
      THEN CALL gath_tm()	        	# Input print condition
      ELSE CALL p_dayeff4()			# Read data and create out-file
   END IF
END MAIN

FUNCTION gath_tm()
   DEFINE l_cmd	 VARCHAR(1000),
          l_month,l_year  SMALLINT,
          l_mm     VARCHAR(2),
          l_yy     VARCHAR(4),
          p_row,p_col   SMALLINT

   LET p_row = 5 LET p_col = 18 

   OPEN WINDOW gath_w AT p_row,p_col WITH FORM "czz/42f/p_dayeff4" 
      ATTRIBUTE (STYLE = g_win_style)
    
    CALL cl_ui_init()


   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL			# Default condition
   LET tm.s    = '000'
   LET tm.more = 'N'
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies = '1'
 #  LET tc_ser06_b=g_today
   #Modify by zm 070125  起始日期默认为上月的26号
   LET tc_ser06_b=s_first(g_today)   #Modify by zm 070327
   LET tc_ser06_e=s_last(g_today)    #Modify by zm 070327
{   LET l_month=MONTH(g_today)-1
   LET l_year=YEAR(g_today)
   IF l_month=0 THEN 
      LET l_year=l_year-1
      LET l_month=12
   END IF
   LET l_yy=l_year  LET l_mm=l_month
   IF LENGTH(l_yy)=1 THEN 
      LET l_yy='0'||l_yy
   END IF
   IF LENGTH(l_mm)=1 THEN 
      LET l_mm='0'||l_mm
   END IF
   LET tc_ser06_b=l_yy||l_mm||'26' 
}
   #End by zm 070125
 #  LET tc_ser06_e=g_today
   #genero版本default 排序,跳页,合计值
WHILE TRUE
   CONSTRUCT BY NAME tm.wc ON
      tc_cust01

   ON ACTION CONTROLP
      CASE
          WHEN INFIELD(tc_cust01)
            CALL cl_init_qry_var()
            LET g_qryparam.state = 'c'
            LET g_qryparam.form = "q_cust"
            CALL cl_create_qry() RETURNING g_qryparam.multiret
            DISPLAY g_qryparam.multiret TO tc_cust01
            NEXT FIELD tc_cust01
      END CASE
   ON ACTION locale
         #CALL cl_dynamic_locale()
         LET g_action_choice = "locale"
         EXIT CONSTRUCT

   ON IDLE g_idle_seconds
      CALL cl_on_idle()
      CONTINUE CONSTRUCT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

           ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT
END CONSTRUCT
       IF g_action_choice = "locale" THEN
          LET g_action_choice = ""
          CALL cl_dynamic_locale()
          CONTINUE WHILE
       END IF


   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW gath_w EXIT PROGRAM
   END IF
   IF tm.wc = " 1=1" THEN
      CALL cl_err('','9046',0)
      CONTINUE WHILE
   END IF



   INPUT BY NAME tc_ser06_b,tc_ser06_e,tm.more WITHOUT DEFAULTS 
  
      AFTER FIELD more
         IF tm.more = 'Y'
            THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies)
                      RETURNING g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies
         END IF

      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLG
         CALL cl_cmdask()	# Command execution


      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
   
          ON ACTION exit
          LET INT_FLAG = 1
          EXIT INPUT
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW gath_w EXIT PROGRAM
   END IF
   IF g_bgjob = 'Y' THEN
      SELECT zz08 INTO l_cmd FROM zz_file	#get exec cmd (fglgo xxxx)
             WHERE zz01='p_dayeff4'
      IF SQLCA.sqlcode OR l_cmd IS NULL THEN
         CALL cl_err('p_dayeff4','9031',1)
      ELSE
         LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
         LET l_cmd = l_cmd CLIPPED,		#(at time fglgo xxxx p1 p2 p3)
                         " '",g_pdate CLIPPED,"'",
                         " '",g_towhom CLIPPED,"'",
                         " '",g_lang CLIPPED,"'",
                         " '",g_bgjob CLIPPED,"'",
                         " '",g_prtway CLIPPED,"'",
                         " '",g_copies CLIPPED,"'",
                         " '",tm.wc CLIPPED,"'",
                         " '",tm.s CLIPPED,"'",
                         " '",g_rep_user CLIPPED,"'",           #No:FUN-570264
                         " '",g_rep_clas CLIPPED,"'",           #No:FUN-570264
                         " '",g_template CLIPPED,"'"            #No:FUN-570264
         CALL cl_cmdat('p_dayeff4',g_time,l_cmd)	# Execute cmd at later time
      END IF
      CLOSE WINDOW gath_w
      EXIT PROGRAM
   END IF
   CALL cl_wait()
   CALL p_dayeff4()
   ERROR ""
END WHILE
   CLOSE WINDOW gath_w
END FUNCTION

FUNCTION p_dayeff4()
   DEFINE l_name VARCHAR(20),		# External(Disk) file name
          l_time VARCHAR(8),		# Used time for running the job
          l_sql  VARCHAR(1000),		# RDSQL STATEMENT
          l_chr	 VARCHAR(1),
          l_za05 VARCHAR(40),
          l_order	ARRAY[3] OF VARCHAR(15),
          sr               RECORD order1 VARCHAR(20),
                                  order2 VARCHAR(20),
                                  order3 VARCHAR(20),
                                  tc_cust01    LIKE tc_cust_file.tc_cust01,
                                  year        INTEGER,
                                  month       INTEGER,
                                  tc_ser16    LIKE tc_ser_file.tc_ser16,
                                  tc_ser16_1  LIKE tc_ser_file.tc_ser16,
                                  tc_ser16_3  LIKE tc_ser_file.tc_ser16     #add by leo 110901
                           END RECORD 
   DEFINE l_cust02  LIKE tc_cust_file.tc_cust02
   DEFINE l_ser53_1 INTEGER
   DEFINE l_ser53_2 INTEGER
   DEFINE l_ser53_3 INTEGER
   DEFINE l_ser53_4 INTEGER

  

       CALL cl_used(g_prog,l_time,1) RETURNING l_time #No:MOD-580088  HCN 20050818
     SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang

#     LET l_sql = "SELECT DISTINCT '','','',",
#                 " tc_cust01,Year(tc_ser06),MONTH(tc_ser06),count(*),0,0",             #add by leo 110901
#                 " FROM tc_ser_file",
#                 "left  outer join  tc_cust_file on tc_ser01 = tc_cust01 ",
#                 #" WHERE (tc_ser13='0' OR tc_ser13='W') AND ",
#                 " WHERE tc_ser13 NOT in('3','4','5','6','7','8','G') AND ",
#                 " tc_ser06 >= '", tc_ser06_b,
#                 "' AND tc_ser06 <= '", tc_ser06_e,"'",
#                 " AND ",tm.wc CLIPPED,
#                 " AND tc_seracti='Y' ",#add by mb 070807
#                " GROUP BY tc_cust01,Year(tc_ser06),Month(tc_ser06) "
     LET l_sql = "SELECT DISTINCT '','','',",
                 " tc_cust01,Year(tc_ser06),MONTH(tc_ser06),count(*),0,0",             #add by leo 110901
                 " FROM tc_cust_file",
                 " left  outer join  tc_ser_file on tc_cust01 = tc_ser01 ",
                 #" WHERE (tc_ser13='0' OR tc_ser13='W') AND ",
                 " WHERE tc_ser13 NOT in('3','4','5','6','7','8','G') AND ",
                 " tc_ser06 >= '", tc_ser06_b,
                 "' AND tc_ser06 <= '", tc_ser06_e,"'",
                 " AND ",tm.wc CLIPPED,
                 " AND tc_seracti='Y' ",#add by mb 070807
                 " GROUP BY tc_cust01,Year(tc_ser06),Month(tc_ser06) "
     PREPARE gath_p1 FROM l_sql
     IF SQLCA.sqlcode != 0 THEN 
        CALL cl_err('prepare:',SQLCA.sqlcode,1) EXIT PROGRAM 
     END IF
     DECLARE gath_c1 CURSOR FOR gath_p1

     CALL cl_outnam('p_dayeff4') RETURNING l_name

     START REPORT gath_rep TO l_name

     FOREACH gath_c1 INTO sr.*
       IF SQLCA.sqlcode != 0 THEN 
           CALL cl_err('foreach:',SQLCA.sqlcode,1) 
           EXIT FOREACH 
       END IF
       #抓取满意度值
       SELECT count(*) INTO l_ser53_1 FROM tc_ser_file
        WHERE tc_ser01=sr.tc_cust01
          AND Year(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND tc_seracti ='Y'
          AND tc_ser53 = '1'                 #非常满意
       SELECT count(*) INTO l_ser53_2 FROM tc_ser_file
        WHERE tc_ser01=sr.tc_cust01
          AND Year(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND tc_seracti ='Y'
          AND tc_ser53 = '2'                 #一般满意
       SELECT count(*) INTO l_ser53_3 FROM tc_ser_file
        WHERE tc_ser01=sr.tc_cust01
          AND Year(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND tc_seracti ='Y'
          AND tc_ser53 = '3'                 #不太满意
       SELECT count(*) INTO l_ser53_4 FROM tc_ser_file
        WHERE tc_ser01=sr.tc_cust01
          AND Year(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month
          #AND (tc_ser13='0' OR tc_ser13='W')
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND tc_seracti ='Y'
          AND tc_ser53 = '4'                 #很不满意
       SELECT tc_cust02 INTO l_cust02 FROM tc_cust_file
        WHERE tc_cust01 = sr.tc_cust01
       SELECT count(*) INTO sr.tc_ser16_1 FROM tc_ser_file 
        WHERE tc_ser01=sr.tc_cust01
          AND tc_seracti='Y'
          AND tc_ser15=tc_ser06
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND YEAR(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month
          #AND tc_ser06 BETWEEN tc_ser06_b AND tc_ser06_e

       SELECT count(*) INTO sr.tc_ser16_3 FROM tc_ser_file 
        WHERE tc_ser01=sr.tc_cust01
          AND tc_seracti='Y'
           AND (((tc_ser15-tc_ser06-(select count(*) from sme_file where sme01 between tc_ser06 and tc_ser15 and sme02='N')) <= 2) AND (tc_ser15 >=tc_ser06))  
          AND tc_ser13 NOT in('3','4','5','6','7','8','G')
          AND YEAR(tc_ser06) = sr.year
          AND MONTH(tc_ser06) =sr.month

       IF cl_null(sr.tc_ser16) THEN LET sr.tc_ser16=0 END IF
       IF cl_null(sr.tc_ser16_1) THEN LET sr.tc_ser16_1=0 END IF
       IF cl_null(sr.tc_ser16_3) THEN LET sr.tc_ser16_3=0 END IF
       OUTPUT TO REPORT gath_rep(sr.*,l_cust02,l_ser53_1,l_ser53_2,l_ser53_3,l_ser53_4)

     END FOREACH

     FINISH REPORT gath_rep

     CALL cl_prt(l_name,g_prtway,g_copies,g_len)
       CALL cl_used(g_prog,l_time,2) RETURNING l_time #No:MOD-580088  HCN 20050818
END FUNCTION

REPORT gath_rep(sr)
   DEFINE l_last_sw VARCHAR(1),
          sr               RECORD order1 VARCHAR(20),
                                  order2 VARCHAR(20),
                                  order3 VARCHAR(20),
                                  tc_cust01    LIKE tc_cust_file.tc_cust01,
                                  year        INTEGER,
                                  month       INTEGER,
                                  tc_ser16    LIKE tc_ser_file.tc_ser16,
                                  tc_ser16_1  LIKE tc_ser_file.tc_ser16,
                                  tc_ser16_3  LIKE tc_ser_file.tc_ser16,
                                  tc_cust02   VARCHAR(20),
                                  tc_ser53_1  INTEGER,
                                  tc_ser53_2  INTEGER,
                                  tc_ser53_3  INTEGER,
                                  tc_ser53_4  INTEGER
                           END RECORD,
      l_chr	 VARCHAR(1),
      l_gen02    LIKE gen_file.gen02
   DEFINE l_ser53_0 LIKE tc_ser_file.tc_ser53

  OUTPUT TOP MARGIN 0
         LEFT MARGIN 0
         BOTTOM MARGIN 5
         PAGE LENGTH g_page_line
#  ORDER BY sr.tc_ser06,sr.order1,sr.order2,sr.order3
  ORDER BY sr.tc_cust01,sr.year,sr.month
  FORMAT
   PAGE HEADER
      PRINT COLUMN ((g_len-FGL_WIDTH(g_company))/2)+1 , g_company
      PRINT COLUMN ((g_len-FGL_WIDTH(g_x[1]))/2)+1 ,g_x[1]
      LET g_pageno = g_pageno + 1
      LET pageno_total = PAGENO USING '<<<',"/pageno" 
      PRINT g_head CLIPPED,pageno_total     
      PRINT 
      PRINT g_dash
      PRINT g_x[31],g_x[37],g_x[38],g_x[39],g_x[32],g_x[33],g_x[34],g_x[35],g_x[36],g_x[40],g_x[42],g_x[44]
      PRINT g_dash1 
      LET l_last_sw = 'n'

   ON EVERY ROW

      PRINT COLUMN g_c[31],sr.tc_cust01 CLIPPED,
            COLUMN g_c[37],sr.tc_cust02 CLIPPED,
            COLUMN g_c[38],sr.year CLIPPED,
            COLUMN g_c[39],sr.month CLIPPED,
            COLUMN g_c[32],sr.tc_ser16 CLIPPED,    
            COLUMN g_c[33],sr.tc_ser16_1 CLIPPED,    
            COLUMN g_c[34],cl_numfor(100*sr.tc_ser16_1/sr.tc_ser16,34,2) USING '###&.##',
            COLUMN g_c[35],sr.tc_ser16_3 CLIPPED,    
            COLUMN g_c[36],cl_numfor(100*sr.tc_ser16_3/sr.tc_ser16,34,2) USING '###&.##',
            COLUMN g_c[40],sr.tc_ser53_1+sr.tc_ser53_2,
            #COLUMN g_c[41],sr.tc_ser53_2 CLIPPED,
            COLUMN g_c[42],sr.tc_ser53_3+sr.tc_ser53_4,
            #COLUMN g_c[43],sr.tc_ser53_4 CLIPPED,
            COLUMN g_c[44],(sr.tc_ser16-sr.tc_ser53_1-sr.tc_ser53_2-sr.tc_ser53_3-sr.tc_ser53_4)

   ON LAST ROW
      PRINT g_dash #No.TQC-5C0005
      PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[7] CLIPPED #No.TQC-5C0005
      LET l_last_sw = 'y'

   PAGE TRAILER
      IF l_last_sw = 'n'
         THEN PRINT g_dash2
              PRINT g_x[4],g_x[5] CLIPPED, COLUMN (g_len-9), g_x[6] CLIPPED #No.TQC-5C0005
         ELSE SKIP 2 LINE
      END IF
END REPORT
