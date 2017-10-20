# Prog. Version..: '5.25.08-12.05.10(00010)'     #
#
# Pattern name...: csfr011.4gl
# Descriptions...: 在製材料狀況表
# Date & Author..: 2016/11/07 By zl
# Modify by shijl 170320  库龄的计算日期按照供需的成本关账的上月末计算，而且，数量也是用上月末库存数量来计算;sta03->ta_sta03的错误
# Modify by shijl 170321  按料号左连接查询出来的数据，方便asdr300对照
# Modify by shijl 170328  添加 最小采购量和订货周期

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

   DEFINE tm  RECORD                    # Print condition RECORD
              wc      STRING,
              wc2     STRING,
              sfb01   LIKE sfb_file.sfb01,        # Where condition    #TQC-630166
              sfa03   LIKE sfa_file.sfa03,
              imk02   LIKE imk_file.imk02,
              ima12   LIKE ima_file.ima12,  #xuyeh170303 add--
              ima06   LIKE ima_file.ima06,  #xuyeh170303 add--
              bdate   LIKE type_file.dat,   #xuyeh170303 add--
              i10     LIKE type_file.num5,	#xuyeh170303 add--
              i11     LIKE type_file.num5,	#xuyeh170303 add--
              i20     LIKE type_file.num5,	#xuyeh170303 add--
              i21     LIKE type_file.num5,	#xuyeh170303 add--
              i30     LIKE type_file.num5,	#xuyeh170303 add--
              i31     LIKE type_file.num5,	#xuyeh170303 add--
              more    LIKE type_file.chr1        #No.FUN-680121 VARCHAR(1)# 是否輸入其它特殊列印條件?
              END RECORD,
              g_cmz    RECORD LIKE cmz_file.*	 #xueyh170303 add

DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose        #No.FUN-680121 SMALLINT
DEFINE l_table     STRING                       ### FUN-720005 add ###
DEFINE g_sql       STRING                       ### FUN-720005 add ###
DEFINE g_str       STRING                       ### FUN-720005 add ###
#xueyh170303 add-------start-----
DEFINE  g_yy     SMALLINT,           #基准日之年度
        g_mm     SMALLINT            #基准日之月份
DEFINE  g_cnt    DECIMAL(8,0)
DEFINE  g_ii     SMALLINT
DEFINE  g_qty    ARRAY[10] OF DECIMAL(20,6)
DEFINE  g_amt    ARRAY[10] OF DECIMAL(20,6)
DEFINE  g_headx  CHAR(15)  ## 081013 HSIUO
#xueyh170303 add---------end-----

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                    # Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CSF")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-690123

   #str FUN-720005 add
   ## *** 與 Crystal Reports 串聯段 - <<<< 產生Temp Table >>>> FUN-720005 *** ##
   LET g_sql =  "sfa03.sfa_file.sfa03,",
                "ima02.ima_file.ima02,",
                "ima021.ima_file.ima021,",
                "ima08.ima_file.ima08,",
                "ima46.ima_file.ima46,", #add by shijl 2017/3/28 18:22
                "ima49.ima_file.ima49,", #add by shijl 2017/3/28 18:22   50+48+49+491
                "sma51.sma_file.sma51,",   #年度
                "sma52.sma_file.sma52,",
                "mss_v.mss_file.mss_v,",  # add by lixwz 20170728
                # "imk02.imk_file.imk02,",   #仓库编号  mark by lixwz 170728
                "imk09.imk_file.imk09,",   #上期期末库存
                "ima25.ima_file.ima25,",   #库存单位
                "d1.sfb_file.sfb13,",    #查询日期
                "d2.sfb_file.sfb13,",    #最后一次发料日期
                "s1.sfa_file.sfa05,",
                "s2.sfa_file.sfa05,",
                "s3.sfa_file.sfa05,",
                "s4.sfa_file.sfa05,",
                "s5.sfa_file.sfa05,",
                "s6.sfa_file.sfa05,",
                "s7.sfa_file.sfa05,",
                "s8.sfa_file.sfa05,",
                "s9.sfa_file.sfa05,",
                "s10.sfa_file.sfa05,",
                "s11.sfa_file.sfa05,",
                "s12.sfa_file.sfa05,",
                "s13.sfa_file.sfa05,",
                "s14.sfa_file.sfa05,",
                "s15.sfa_file.sfa05,",
                "s16.sfa_file.sfa05,",
                "s17.sfa_file.sfa05,",
                "s18.sfa_file.sfa05,",
                "s19.sfa_file.sfa05,",
                "s20.sfa_file.sfa05,",
                "s21.sfa_file.sfa05,",
                "s22.sfa_file.sfa05,",
                "s23.sfa_file.sfa05,",
                "s24.sfa_file.sfa05,",
              #xueyh170303 add-------start----------------
                # add by lixwz 20170905 s
                "a1.sfa_file.sfa05,",
                "a2.sfa_file.sfa05,",
                "a3.sfa_file.sfa05,",
                "a4.sfa_file.sfa05,",
                "a5.sfa_file.sfa05,",
                "a6.sfa_file.sfa05,",
                "a7.sfa_file.sfa05,",
                "a8.sfa_file.sfa05,",
                "a9.sfa_file.sfa05,",
                "a10.sfa_file.sfa05,",
                "a11.sfa_file.sfa05,",
                "a12.sfa_file.sfa05,",
                # add by lixwz 20170905 e
               "ima06.ima_file.ima06,",
               "ima131.ima_file.ima131,",
               "ima27.ima_file.ima27,",
               "ima54.ima_file.ima54,",
               "pmc03.pmc_file.pmc03,",
               "l_qty01.cma_file.cma15,",
               "l_qty02.cma_file.cma15,",
               "l_qty03.cma_file.cma15,",
               "l_qty10.cma_file.cma15,",
               "l_amt01.oeb_file.oeb13,",
               "l_amt02.oeb_file.oeb13,",
               "l_amt03.oeb_file.oeb13,",
               "l_amt10.oeb_file.oeb13,",
               "ima12.ima_file.ima12,",
               "ima902.ima_file.ima902,",
                "ccc23.ccc_file.ccc23"
              #xueyh170303 add---------end----------------

   LET l_table = cl_prt_temptable('csfr011',g_sql) CLIPPED   # 產生Temp Table
   IF l_table = -1 THEN EXIT PROGRAM END IF                  # Temp Table產生
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?)"   #xueyh170303 add 15? #FUN-A60027 add 2? #ADD 2? shijl 2017/3/29 13:08
                                                                                        # mod by lixwz 20170905 add 12 '?'
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1) EXIT PROGRAM
   END IF
   #------------------------------ CR (1) ------------------------------#
   #end FUN-720005 add

   LET g_pdate = ARG_VAL(1)           # Get arguments from command line
   LET g_towhom = ARG_VAL(2)
   LET g_rlang = ARG_VAL(3)
   LET g_bgjob = ARG_VAL(4)
   LET g_prtway = ARG_VAL(5)
   LET g_copies = ARG_VAL(6)
   LET tm.wc = ARG_VAL(7)
   #TQC-610080-begin
   LET g_rep_user = ARG_VAL(8)
   LET g_rep_clas = ARG_VAL(9)
   LET g_template = ARG_VAL(10)
   #LET tm.more  = ARG_VAL(8)
   ##No.FUN-570264 --start--
   #LET g_rep_user = ARG_VAL(9)
   #LET g_rep_clas = ARG_VAL(10)
   #LET g_template = ARG_VAL(11)
   LET g_rpt_name = ARG_VAL(12)  #No.FUN-7C0078
   ##No.FUN-570264 ---end---
   #TQC-610080-end
   IF cl_null(g_bgjob) OR g_bgjob = 'N'   # If background job sw is off
      THEN CALL csfr011_tm()        # Input print condition
      ELSE CALL csfr011()              # Read data and create out-file
   END IF
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690123
END MAIN

FUNCTION csfr011_tm()
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01   #No.FUN-580031
   DEFINE p_row,p_col    LIKE type_file.num5,         #No.FUN-680121 SMALLINT
          l_cmd          LIKE type_file.chr1000       #No.FUN-680121 VARCHAR(700)
    DEFINE l_mss  RECORD                    # Print condition RECORD
                 mss01            LIKE mss_file.mss01,
                 mss_v             LIKE mss_file.mss_v
              END RECORD
   LET p_row = 5 LET p_col = 20

   OPEN WINDOW csfr011_w AT p_row,p_col WITH FORM "csf/42f/csfr011"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

   CALL cl_ui_init()

   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL            # Default condition
   LET tm.more = 'N'
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies= '1'
#   LET tm.bdate=g_today #xueyh170303 add #marked by shijl 170320
   #add by shijl 170320--str--
   SELECT sma53 INTO tm.bdate FROM sma_file
   IF cl_null(tm.bdate) THEN LET tm.bdate = g_today END IF
   #add by shijl 170320 --end--
   LET tm.i10=1
   LET tm.i11=360
   LET tm.i20=361
   LET tm.i21=720
   LET tm.i30=721
   LET tm.i31=9999
   WHILE TRUE
#-----------No.MOD-770037 add
   DROP TABLE sub_tmp
   CREATE TEMP TABLE sub_tmp
   (a         LIKE sfb_file.sfb01,
    b         LIKE sfb_file.sfb05,
    c         LIKE sfb_file.sfb08);
#-----------No.MOD-770037 end

      # add by lixwz 20170728 s

      CONSTRUCT BY NAME tm.wc ON mss01,mss_v

        BEFORE CONSTRUCT
           LET l_mss.mss_v = 'HDF'
           DISPLAY BY NAME l_mss.mss_v

           CALL cl_qbe_init()

        ON ACTION controlp
           IF INFIELD(mss01) THEN
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_ima"
              LET g_qryparam.state = "c"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO mss01
              NEXT FIELD mss01
           END IF

        ON ACTION locale
           LET g_action_choice = "locale"
           CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           EXIT CONSTRUCT

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE CONSTRUCT

         ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT

         ON ACTION qbe_select
           CALL cl_qbe_select()

     END CONSTRUCT
     IF tm.wc=" 1=1 " THEN # add by lixwz 20170728
        CALL cl_err(' ','9046',0)
        CONTINUE WHILE
     END IF
      # add by lixwz 20170728 e
      #  CONSTRUCT BY NAME tm.wc ON sfb01,sfa03,imk02,ima12,ima06   #xueyh170303 add ima12,ima06 #marked By shijl 170321
      {  CONSTRUCT BY NAME tm.wc ON sfb01   #xueyh170303 add ima12,ima06 #add by shijl 170321
#No.FUN-570240 --start--
        #No.FUN-580031 --start--
        BEFORE CONSTRUCT
           CALL cl_qbe_init()
        #No.FUN-580031 ---end---

        ON ACTION controlp

          #FUN-7B0096---add---str---
           IF INFIELD(sfb01) THEN   #工單編號"
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_sfb3"     #No:TQC-A50156 modify
              LET g_qryparam.state    = "c"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO sfb01
              NEXT FIELD sfb01
           END IF
          #FUN-7B0096---add---end---

           IF INFIELD(sfa03) THEN
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_ima"
              LET g_qryparam.state = "c"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO sfa03
              NEXT FIELD sfa03
           END IF
#No.FUN-570240 --end--
        ON ACTION locale
           LET g_action_choice = "locale"
           CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           EXIT CONSTRUCT

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE CONSTRUCT

        ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT

        #No.FUN-580031 --start--
        ON ACTION qbe_select
           CALL cl_qbe_select()
        #No.FUN-580031 ---end---

     END CONSTRUCT}
#add by shijl 2017/3/29 13:18--str--
     IF g_action_choice = "locale" THEN
        LET g_action_choice = ""
        CALL cl_dynamic_locale()
        CONTINUE WHILE
     END IF

     IF INT_FLAG THEN
        LET INT_FLAG = 0
        EXIT WHILE
     END IF
#add by shijl 2017/3/29 13:18--end--
#cancel marked by shijl 170321--str--
     #CONSTRUCT BY NAME tm.wc2 ON imk02  #marked by shijl 2017/3/21 14:29
   {  CONSTRUCT BY NAME tm.wc2 ON sfa03,imk02,ima12,ima06 #add by shijl 2017/3/21 14:29

        BEFORE CONSTRUCT
           CALL cl_qbe_init()
        #No.FUN-580031 ---end---

        ON ACTION controlp
           IF INFIELD(sfa03) THEN
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_ima"
              LET g_qryparam.state = "c"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO sfa03
              NEXT FIELD sfa03
           END IF
        ON ACTION locale
           LET g_action_choice = "locale"
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           EXIT CONSTRUCT

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE CONSTRUCT

        ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT

        #No.FUN-580031 --start--
        ON ACTION qbe_select
           CALL cl_qbe_select()
        #No.FUN-580031 ---end---

     END CONSTRUCT}
#cancel marked by shijl 170321--end--
     IF g_action_choice = "locale" THEN
        LET g_action_choice = ""
        CALL cl_dynamic_locale()
        CONTINUE WHILE
     END IF

     IF INT_FLAG THEN
        LET INT_FLAG = 0
        EXIT WHILE
     END IF

#****
     # IF tm.wc=" 1=1 " AND tm.wc2=" 1=1 " THEN #add tm.wc2 by shijl 170321 # mark by lixwz 20170728
      IF tm.wc=" 1=1 " THEN # add by lixwz 20170728
        CALL cl_err(' ','9046',0)
        CONTINUE WHILE
     END IF

     #add by shijl 2017/3/21 14:42 --str--
     IF NOT cl_null(tm.wc2) THEN
       LET tm.wc =tm.wc  CLIPPED ," AND ",tm.wc2 CLIPPED
     END IF
     #add by shijl 2017/3/21 14:42 --end--

#     DISPLAY BY NAME tm.bdate,tm.more     #xueyh170303 add tm.bdate # Condition #marked by shijl 170320
     DISPLAY BY NAME tm.more     #xueyh170303 add tm.bdate # Condition  #add by shijl 170320

#     INPUT BY NAME tm.bdate,tm.more WITHOUT DEFAULTS #xueyh170303 add tm.bdate #marked by shijl 170320
     INPUT BY NAME tm.more WITHOUT DEFAULTS #xueyh170303 add tm.bdate

        #No.FUN-580031 --start--
        BEFORE INPUT
            CALL cl_qbe_display_condition(lc_qbe_sn)
        #No.FUN-580031 ---end---

        AFTER FIELD more
           IF tm.more NOT MATCHES "[YN]" OR tm.more IS NULL
              THEN NEXT FIELD more
           END IF
#marked by shijl 170320--str--
#        #xueyh170303 add_------------start-----------
#        AFTER FIELD bdate
#           IF cl_null(tm.bdate) THEN
#              NEXT FIELD bdate
#           ELSE
#              LET g_yy=year(tm.bdate)
#              LET g_mm=month(tm.bdate)
#           END IF
#        #xueyh170303 add_--------------end-----------
#marked by shijl 170320--end--

        ON ACTION CONTROLZ
           CALL cl_show_req_fields()

        ON ACTION CONTROLG
           CALL cl_cmdask()    # Command execution

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT

        ON ACTION exit
           LET INT_FLAG = 1
           EXIT INPUT

        #No.FUN-580031 --start--
        ON ACTION qbe_save
           CALL cl_qbe_save()
        #No.FUN-580031 ---end---

     END INPUT

     IF INT_FLAG THEN
        LET INT_FLAG = 0
        EXIT WHILE
     END IF

     IF g_bgjob = 'Y' THEN
        SELECT zz08 INTO l_cmd FROM zz_file    #get exec cmd (fglgo xxxx)
               WHERE zz01='csfr011'
        IF SQLCA.sqlcode OR l_cmd IS NULL THEN
           CALL cl_err('csfr011','9031',1)
        ELSE
           LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
           LET l_cmd = l_cmd CLIPPED,        #(at time fglgo xxxx p1 p2 p3)
                           " '",g_pdate CLIPPED,"'",
                           " '",g_towhom CLIPPED,"'",
                           #" '",g_lang CLIPPED,"'", #No.FUN-7C0078
                           " '",g_rlang CLIPPED,"'", #No.FUN-7C0078
                           " '",g_bgjob CLIPPED,"'",
                           " '",g_prtway CLIPPED,"'",
                           " '",g_copies CLIPPED,"'",
                           " '",tm.wc CLIPPED,"'",
                           #xueyh170303 add----------start-------------
                           " '",tm.bdate CLIPPED,"'" ,
                           " '",tm.i10 CLIPPED,"'" ,
                           " '",tm.i11 CLIPPED,"'" ,
                           " '",tm.i20 CLIPPED,"'" ,
                           " '",tm.i21 CLIPPED,"'" ,
                           " '",tm.i30 CLIPPED,"'" ,
                           " '",tm.i31 CLIPPED,"'" ,
                           #xueyh170303 add-----------end--------------
                          #" '",tm.more CLIPPED,"'",           #TQC-610080
                           " '",g_rep_user CLIPPED,"'",        #No.FUN-570264
                           " '",g_rep_clas CLIPPED,"'",        #No.FUN-570264
                           " '",g_template CLIPPED,"'",        #No.FUN-570264
                           " '",g_rpt_name CLIPPED,"'"         #No.FUN-7C0078

           CALL cl_cmdat('csfr011',g_time,l_cmd)    # Execute cmd at later time
        END IF
        CLOSE WINDOW csfr011_w
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690123
        EXIT PROGRAM
     END IF
     CALL cl_wait()
     CALL csfr011()
     ERROR ""
   END WHILE
   CLOSE WINDOW csfr011_w
END FUNCTION

FUNCTION csfr011()
   DEFINE l_name     LIKE type_file.chr20,         #No.FUN-680121 VARCHAR(20)# External(Disk) file name
          l_sql      STRING,                       # RDSQL STATEMENT  TQC-630166
          l_chr      LIKE type_file.chr1,          #No.FUN-680121 VARCHAR(1)
#         l_qty      LIKE ima_file.ima26,          #No.FUN-680121 DEC(13,3)
#         l_wip      LIKE ima_file.ima26,          #No.FUN-680121 DEC(13,3)
#         l_wip_c    LIKE ima_file.ima26,          #No.FUN-680121 DEC(13,3)
#         l_s_wip    LIKE ima_file.ima26,          #No.FUN-680121 DEC(13,3)
#         l_s_wip_c  LIKE ima_file.ima26,          #No.FUN-680121 DEC(13,3)
          l_qty      LIKE type_file.num15_3,       ###GP5.2  #NO.FUN-A20044
          l_wip      LIKE type_file.num15_3,       ###GP5.2  #NO.FUN-A20044
          l_wip_c    LIKE type_file.num15_3,       ###GP5.2  #NO.FUN-A20044
          l_s_wip    LIKE type_file.num15_3,       ###GP5.2  #NO.FUN-A20044
          l_s_wip_c  LIKE type_file.num15_3,       ###GP5.2  #NO.FUN-A20044
          l_tmp_wip  LIKE sfb_file.sfb08,     #No.MOD-770037 add
          l_sfa03    LIKE sfa_file.sfa03,     #No.MOD-770037 add
          l_sfa28    LIKE sfa_file.sfa28,     #No.MOD-770037 add
          l_za05     LIKE type_file.chr1000,       #No.FUN-680121 VARCHAR(40)
          l_order   ARRAY[5] OF LIKE apm_file.apm08,        #No.FUN-680121 VARCHAR(10)
          l_sma51    LIKE sma_file.sma51,
          l_sma52    LIKE sma_file.sma52,
          i          LIKE type_file.num5,
          l_begin    LIKE type_file.dat,
          l_end      LIKE type_file.dat,
          sr  RECORD
              sfa03  LIKE sfa_file.sfa03,
              ima02  LIKE ima_file.ima02,
              ima021 LIKE ima_file.ima021,
              ima08  LIKE ima_file.ima08,
              ima46  LIKE ima_file.ima46, #add by shijl 2017/3/28 18:25
              ima49  LIKE ima_file.ima49, #add by shijl 2017/3/28 18:25
              sma51  LIKE sma_file.sma51,   #年度
              sma52  LIKE sma_file.sma52,
              mss_v   LIKE mss_file.mss_v,    # add by lixwz 20170728
              #imk02  LIKE imk_file.imk02,   # mark by lixwz 20170728
              imk09  LIKE imk_file.imk09,   #上期期末库存
              ima25  LIKE ima_file.ima25,   #库存单位
              d1     LIKE sfb_file.sfb13,   #查询日期
              d2     LIKE sfb_file.sfb13,   #最后一次发料日期
              s1     LIKE sfa_file.sfa05,
              s2     LIKE sfa_file.sfa05,
              s3     LIKE sfa_file.sfa05,
              s4     LIKE sfa_file.sfa05,
              s5     LIKE sfa_file.sfa05,
              s6     LIKE sfa_file.sfa05,
              s7     LIKE sfa_file.sfa05,
              s8     LIKE sfa_file.sfa05,
              s9     LIKE sfa_file.sfa05,
              s10    LIKE sfa_file.sfa05,
              s11    LIKE sfa_file.sfa05,
              s12    LIKE sfa_file.sfa05,
              s13    LIKE sfa_file.sfa05,
              s14    LIKE sfa_file.sfa05,
              s15    LIKE sfa_file.sfa05,
              s16    LIKE sfa_file.sfa05,
              s17    LIKE sfa_file.sfa05,
              s18    LIKE sfa_file.sfa05,
              s19    LIKE sfa_file.sfa05,
              s20    LIKE sfa_file.sfa05,
              s21    LIKE sfa_file.sfa05,
              s22    LIKE sfa_file.sfa05,
              s23    LIKE sfa_file.sfa05,
              s24    LIKE sfa_file.sfa05,
              #xueyh170303 add-----------start--------
              # add by lixwz 20170905 s
              a1     LIKE sfa_file.sfa05,
              a2     LIKE sfa_file.sfa05,
              a3     LIKE sfa_file.sfa05,
              a4     LIKE sfa_file.sfa05,
              a5     LIKE sfa_file.sfa05,
              a6     LIKE sfa_file.sfa05,
              a7     LIKE sfa_file.sfa05,
              a8     LIKE sfa_file.sfa05,
              a9     LIKE sfa_file.sfa05,
              a10    LIKE sfa_file.sfa05,
              a11    LIKE sfa_file.sfa05,
              a12    LIKE sfa_file.sfa05,
              # add by lixwz 20170905 e
              ima06         LIKE ima_file.ima06,
              ima131        LIKE ima_file.ima131,
              ima27         LIKE ima_file.ima27,
              ima54         LIKE ima_file.ima54,
              pmc03         LIKE pmc_file.pmc03,
              ima12         LIKE ima_file.ima12,
              ima902        LIKE ima_file.ima902,
              ccc23         LIKE sta_file.sta04,
              ccc91         LIKE ccc_file.ccc91,
              ccc92         LIKE ccc_file.ccc92,
              imk09_s         LIKE imk_file.imk09,
              amt10         LIKE type_file.num20_6,
              qty10_s       LIKE type_file.num20_6,
              amt10_s       LIKE type_file.num20_6,
              amt01         LIKE type_file.num20_6,
              amt02         LIKE type_file.num20_6,
              amt03         LIKE type_file.num20_6,
              qty01         LIKE type_file.num20_6,
              qty02         LIKE type_file.num20_6,
              qty03         LIKE type_file.num20_6
            #xueyh170303 add-------------end-----------
              END RECORD
              #xueyh170303 add--------start-------------
   DEFINE l_sfa12    LIKE sfa_file.sfa12 #Add No:MOD-B30479  #替代料时原料的单位
   DEFINE l_cnt      LIKE type_file.num5 #Add No:MOD-B30479
  DEFINE l_ss0 CHAR(600),
         l_ss1 CHAR(600),  ## 081013 HSIUO
         l_ima902      LIKE ima_file.ima902,
         l_mm          CHAR(02)
  DEFINE l_tlf         RECORD LIKE tlf_file.*
  DEFINE p_qty         LIKE tlf_file.tlf10
  DEFINE l_check       CHAR(1)
  DEFINE l_str          STRING  # add by lixwz 201709
  DEFINE l_str1          STRING  # add by lixwz 201709
  DEFINE l_sma51_1       LIKE sma_file.sma51 # add by lixwz 20170919
  DEFINE l_sma52_1       LIKE sma_file.sma52 # add by lixwz 20170919
  #xueyh170303 add------------end---------------
   #str FUN-720005 add
   ## *** 與 Crystal Reports 串聯段 - <<<< 清除暫存資料 >>>> FUN-720005 *** ##
   CALL cl_del_data(l_table)
   #------------------------------ CR (2) ------------------------------#
   #end FUN-720005 add

   #add by shijl 170321--str--
   CALL csfr011_tmp()
   IF SQLCA.sqlcode THEN
      CALL cl_err('create temp table ',SQLCA.sqlcode,0)
      RETURN
   END IF
   #add by shijl 170321--end--

   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang
   SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = g_prog   ### FUN-720005 add ###

   #Begin:FUN-980030
   #   IF g_priv2='4' THEN                           #只能使用自己的資料
   #       LET tm.wc = tm.wc clipped," AND sfbuser = '",g_user,"'"
   #   END IF
   #   IF g_priv3='4' THEN                           #只能使用相同群的資料
   #       LET tm.wc = tm.wc clipped," AND sfbgrup MATCHES '",g_grup CLIPPED,"*'"
   #   END IF
   #   IF g_priv3 MATCHES "[5678]" THEN    #TQC-5C0134群組權限
   #       LET tm.wc = tm.wc clipped," AND sfbgrup IN ",cl_chk_tgrup_list()
   #   END IF
   LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('sfbuser', 'sfbgrup')
   #End:FUN-980030
   SELECT sma51,sma52 INTO l_sma51,l_sma52 FROM sma_file
   CALL s_lsperiod(l_sma51,l_sma52) RETURNING l_sma51, l_sma52
   LET l_str  ="'" ,l_sma51 ,"'"
   LET l_str1="'" ,l_sma52 ,"'"
   LET l_str  =cl_replace_str(l_str, " ", "")
   LET l_str1=cl_replace_str(l_str1, " ", "")
   #bugno:6203 add sfb02
#marked by shijl 170321--str--库龄的逻辑放到后面
#   LET l_sql = " SELECT distinct sfa03,ima02,ima021,ima08,'','',imk02,'',ima25,'','',",
#               " '','','','','', '','','','','', '','','','','', '','','','','', '','','','', ",
#              # " ima06,ima131,ima27,ima54,pmc03,ima12,ima902,sta04+sta03 ", #xueyh170303 add #marked by shijl 170320
#               " ima06,ima131,ima27,ima54,pmc03,ima12,ima902,sta04+ta_sta03 ", #xueyh170303 add #add by shijl 170320
#             #  "   FROM sfb_file,imk_file,sfa_file, OUTER ima_file ", #Ora #xueyh170303 mark
#               "   FROM sfb_file,imk_file,sfa_file ", #xueyh170303 add
#                " LEFT JOIN ima_file on sfa03=ima01  ", #xueyh170303 add
#                " LEFT JOIN sta_file on sta01=ima01  ", #xueyh170303 add
#                 " LEFT JOIN stb_file on stb01=ima01  ", #xueyh170303 add
#                 " LEFT JOIN pmc_file on pmc01=ima54  ", #xueyh170303 add
#               "  WHERE sfa01 = sfb01 AND sfa03 = imk01 ",
#               "  AND imk05 = '",l_sma51,"' AND imk06 = '",l_sma52,"' ",
#               #"    AND  ima_file.ima01 = sfa_file.sfa03  ",    #xueyh170303 mark                  #Ora
#            #   "    AND sfb04 IN ('2','3','4','5','6','7') ",          #Ora
##               " and stb02= ",g_yy," ",		 #xueyh170303 add #marked by shijl 2017/3/20 15:24
##               " AND stb03= ",g_mm," ",	 #xueyh170303 add	#marked by shijl 2017/3/20 15:25
#                " and stb02= ",l_sma51," ",#add by shijl 170320
#                " AND stb03= ",l_sma52," ", #add by shijl 170320
#               "    AND ",tm.wc CLIPPED
#marked by shijl 170321--end--
#add by shijl 170321--str--
  # mark by lixwz 20170728 s
  # LET l_sql = " SELECT distinct sfa03,ima02,ima021,ima08,ima46,(nvl(ima50,0)+nvl(ima48,0)+nvl(ima49,0)+nvl(ima491,0)),", #add ima46 ima48~50
  #             " '','',imk02,'',ima25,'','',",
  #             " '','','','','', '','','','','', '','','','','', '','','','','', '','','','', ",
  #             " '','','','','','','','' ",
  #             "   FROM sfb_file,imk_file,sfa_file,  ima_file ", #Ora
  #             "  WHERE sfa01 = sfb01 AND sfa03 = imk01 ",
  #             "  AND imk05=",l_str,#" AND imk06=",l_str1,
  #             "    AND  ima_file.ima01 = sfa_file.sfa03  ",     #Ora
  #         #   "    AND sfb04 IN ('2','3','4','5','6','7') ",          #Ora
  #             "    AND ",tm.wc CLIPPED
    # mark by lixwz 20170728 s
    LET l_sql = " SELECT distinct ima01,ima02,ima021,ima08,ima46,(nvl(ima50,0)+nvl(ima48,0)+nvl(ima49,0)+nvl(ima491,0)),",
                " '','',mss_v,'',ima25,'','',",
                " '','','','','', '','','','','', '','','','','', '','','','','', '','','','', ",
                " '','','','','', '','','', ",
                " '','','','','','','','','','','',''", # add by lixwz 20170905
                "   FROM mss_file,ima_file,imk_file",
                "   WHERE ima01 = mss01  AND  imk01 = mss01 ",
                "   AND imk05=",l_str,#" AND imk06=",l_str1,
                "   AND ",tm.wc CLIPPED
    # add by lixwz 20170728 s

    # add by lixwz 20170728 e
#add by shijl 170321--end--
   PREPARE csfr011_prepare1 FROM l_sql
   IF SQLCA.sqlcode != 0 THEN
       CALL cl_err('prepare:',SQLCA.sqlcode,1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690123
       EXIT PROGRAM
   END IF
   DECLARE csfr011_curs1 CURSOR FOR csfr011_prepare1

  #LET l_sql = " SELECT SUM(sfa05) ",
  #           " FROM sfa_file,sfb_file ",
  #           " WHERE sfa03 = ? AND sfa01=sfb01  AND sfb13 BETWEEN ? AND ? ",
  #           " AND sfb87 <> 'X' "
  LET l_sql = " SELECT SUM(mst08) ",
             " FROM mst_file ",
             " WHERE mst01 = ? AND mst_v=?  AND mst03 BETWEEN ? AND ? ",
             "   AND mst05 like '4%'  "  #add by pane 170802
   IF tm.more = 'Y' THEN
     # LET l_sql=l_sql CLIPPED," AND SUBSTR(sfb01,1,1) <> '5'  " mark by lixwz 20170801
   END IF
   PREPARE csfr011_s1 FROM l_sql
   IF SQLCA.sqlcode != 0 THEN
      CALL cl_err('p1:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690123
      EXIT PROGRAM
   END IF
   DECLARE csfr011_curs2 CURSOR FOR csfr011_s1
{
   LET l_sql = " SELECT SUM(imk09) ",
               " FROM imk_file  ",
               " WHERE imk01 = ? AND imk05 = ?  AND imk06 = ? ",
               " AND ",tm.wc2 CLIPPED
   PREPARE csfr011_s2 FROM l_sql
   IF SQLCA.sqlcode != 0 THEN
      CALL cl_err('p1:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690123
      EXIT PROGRAM
   END IF
   DECLARE csfr011_curs3 CURSOR FOR csfr011_s2
}
   LET g_pageno = 0
   FOREACH csfr011_curs1 INTO sr.*
      IF SQLCA.sqlcode != 0  THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET sr.d1 = g_today
      SELECT MAX(sfe04) INTO sr.d2 FROM sfe_file WHERE sfe07 = sr.sfa03
    #mark by pane 170815 begin#
    # SELECT sma51,sma52 INTO sr.sma51,sr.sma52 FROM sma_file
    # IF sr.sma52 = 1 THEN
    #    LET l_sma51 = sr.sma51 - 1
    #    LET l_sma52 = 12
    # ELSE
    #    LET l_sma51 = sr.sma51
    #    LET l_sma52 = sr.sma52 - 1
    # END IF
    #mark by pane 170815 end#
      LET l_sma51 = YEAR(sr.d1) #add by pane170815
      LET l_sma52 = MONTH(sr.d1) #add by pane 170815
      # 期末库存数量 #*****
      SELECT SUM(imk09) INTO sr.imk09
            FROM imk_file
            WHERE imk02 in (SELECT UNIQUE msp03 FROM msp_file WHERE msp01=sr.mss_v) AND   imk01=sr.sfa03
            AND imk05 = l_sma51 AND imk06 = l_sma52 AND imkplant = g_plant

      # mark by lixwz 20170728 s
      # SELECT SUM(imk09) INTO sr.imk09 FROM imk_file WHERE imk01 = sr.sfa03
      #                   AND imk05 = l_sma51 AND imk06 = l_sma52 AND imkplant = g_plant
      #                   AND imk02 = sr.imk02
      # mark by lixwz 20170728 e
  #    OPEN csfr011_curs3 USING sr.sfa03,l_sma51,l_sma52
  #               FETCH csfr011_curs3 INTO sr.imk09
  #               IF SQLCA.SQLCODE THEN
  #                   CALL cl_err("", SQLCA.SQLCODE, 0)
  #                    CLOSE csfr011_curs3
  #
  #               END IF
  #               CLOSE csfr011_curs3
                 IF cl_null(sr.imk09) THEN LET sr.imk09 = 0 END IF
      #add by shijl 170321--str--
     #IF sr.imk09 <=0 THEN
     #   CONTINUE FOREACH
     #END IF
      #add by shijl 170321--end--
      #开始计算每个月的需求量
     #mark by pane 170815 begin#
     #LET l_sma51=sr.sma51   #当前年度月份
     #LET l_sma52=sr.sma52
     #mark by pane 170815 end#
      #开始计算12个月之前的年度月份
     # mark by lixwz 20170731
     # FOR i = 1 TO 11
     #     CALL s_lsperiod(l_sma51,l_sma52) RETURNING l_sma51, l_sma52
     # END FOR
     # mark by lixwz 20170731
   #   CALL s_azn01(l_sma51,l_sma52) RETURNING l_begin,l_end
   #   LET sr.d1=l_begin

   # 24 个月的数据
      FOR i = 1 TO 24
           CALL s_azn01(l_sma51,l_sma52) RETURNING l_begin,l_end
           CASE i
                WHEN 1
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s1
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s1) THEN LET sr.s1 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a1 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a1 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a1) THEN LET sr.a1 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 2
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s2
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s2) THEN LET sr.s2 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a2 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a2 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a2) THEN LET sr.a2 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 3
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s3
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s3) THEN LET sr.s3 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a3 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a3 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a3) THEN LET sr.a3 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 4
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s4
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s4) THEN LET sr.s4 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a4 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a4 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a4) THEN LET sr.a4 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 5
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s5
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s5) THEN LET sr.s5 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a5 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a5 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a5) THEN LET sr.a5 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 6
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s6
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s6) THEN LET sr.s6 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a6 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a6 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a6) THEN LET sr.a6 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 7
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s7
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s7) THEN LET sr.s7 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a7 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a7 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a7) THEN LET sr.a7 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 8
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s8
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s8) THEN LET sr.s8 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a8 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a8 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a8) THEN LET sr.a8 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 9
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s9
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s9) THEN LET sr.s9 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a9 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a9 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a9) THEN LET sr.a9 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 10
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s10
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s10) THEN LET sr.s10 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a10 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a10 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a10) THEN LET sr.a10 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 11
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s11
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s11) THEN LET sr.s11 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a11 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a11 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a11) THEN LET sr.a11 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 12
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s12
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s12) THEN LET sr.s12 = 0 END IF
                 # add by lixwz 20170905 s
                 IF sr.mss_v = 'HDF' THEN
                    SELECT SUM(SFA05) INTO sr.a12 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '331%'
                            OR  sfa01   LIKE    '431%'
                            OR  sfa01   LIKE    '433%'
                            OR  sfa01   LIKE    '631%'
                            OR  sfa01   LIKE    '731%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF sr.mss_v = 'HDP' THEN
                    SELECT SUM(SFA05) INTO sr.a12 FROM sfa_file,sfb_file
                        WHERE sfa01=sfb01
                        AND (   sfa01   LIKE    '531%'
                            OR  sfa01   LIKE    '831%')
                        AND YEAR(sfb13)     =   l_sma51 - 1  # mod by lixwz 20170920
                        AND MONTH(sfb13)    =   l_sma52
                        AND sfb87 ='Y'
                        AND sfa03 = sr.sfa03
                 END IF
                 IF cl_null(sr.a12) THEN LET sr.a12 = 0 END IF
                 # add by lixwz 20170905 e

                WHEN 13
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s13
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s13) THEN LET sr.s13 = 0 END IF

                WHEN 14
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s14
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s14) THEN LET sr.s14 = 0 END IF

                WHEN 15
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s15
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s15) THEN LET sr.s15 = 0 END IF

                WHEN 16
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s16
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s16) THEN LET sr.s16 = 0 END IF

                WHEN 17
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s17
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s17) THEN LET sr.s17 = 0 END IF

                WHEN 18
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s18
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s18) THEN LET sr.s18 = 0 END IF

                WHEN 19
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s19
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s19) THEN LET sr.s19 = 0 END IF

                WHEN 20
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s20
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s20) THEN LET sr.s20 = 0 END IF

                WHEN 21
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s21
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s21) THEN LET sr.s21 = 0 END IF

                WHEN 22
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s22
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s22) THEN LET sr.s22 = 0 END IF

                WHEN 23
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s23
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s23) THEN LET sr.s23 = 0 END IF

                WHEN 24
                 OPEN csfr011_curs2 USING sr.sfa03,sr.mss_v,l_begin,l_end
                 FETCH csfr011_curs2 INTO sr.s24
                 IF SQLCA.SQLCODE THEN
                     CALL cl_err("", SQLCA.SQLCODE, 0)
                      CLOSE csfr011_curs2
                     EXIT FOR
                 END IF
                 CLOSE csfr011_curs2
                 IF cl_null(sr.s24) THEN LET sr.s24 = 0 END IF

            END CASE

            IF l_sma52 = 12 THEN
               LET l_sma52 = 1
               LET l_sma51 = l_sma51 + 1
            ELSE
            	 LET l_sma52 = l_sma52 + 1
            END IF

      END FOR
      INSERT INTO csfr011_tmp (sfa03,ima02,
        ima021,ima08,ima46,ima49,sma51,sma52,mss_v,imk09,ima25,d1,d2, # mod by lixwz 20170728 imk02 -> mss_v
        s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,
        s11,s12,s13,s14,s15,s16,s17,s18,s19,s20,
        s21,s22,s23,s24,
        a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,  # add by lixwz 20170905
        ima06,ima131,ima27,ima54,pmc03,qty01,qty02,qty03,qty10_s,amt01,
        amt02,amt03,amt10_s,ima12,ima902,ccc23)
                        	VALUES(sr.sfa03,sr.ima02,
         sr.ima021,sr.ima08,sr.ima46,sr.ima49,sr.sma51,sr.sma52,sr.mss_v,sr.imk09,sr.ima25,sr.d1,sr.d2, #add sr.ima49,sr.ima50  by shijl 2017/3/29 10:05    # mod by lixwz 20170728 imk02 -> mss_v
         sr.s1,sr.s2,sr.s3,sr.s4,sr.s5,sr.s6,sr.s7,sr.s8,sr.s9,sr.s10,
         sr.s11,sr.s12,sr.s13,sr.s14,sr.s15,sr.s16,sr.s17,sr.s18,sr.s19,sr.s20,
         sr.s21,sr.s22,sr.s23,sr.s24
        ,sr.a1,sr.a2,sr.a3,sr.a4,sr.a5,sr.a6,sr.a7,sr.a8,sr.a9,sr.a10,sr.a11,sr.a12 # add by lixwz 20170905
        ,sr.ima06,sr.ima131,sr.ima27,sr.ima54,sr.pmc03,sr.qty01,sr.qty02,sr.qty03,sr.qty10_s,sr.amt01,
         sr.amt02,sr.amt03,sr.amt10_s,sr.ima12,sr.ima902,sr.ccc23)
           IF SQLCA.SQLCODE <> 0 THEN
              CALL cl_err('INSERT tmp_1:',SQLCA.SQLCODE,0)
           END IF
#add by shijl 170321--end--

      #------------------------------ CR (3) ------------------------------#
      #end FUN-720005 add
   END FOREACH

#add by shijl 170321--str--
      LET tm.wc2=cl_replace_str(tm.wc2, "sfa03", "a.ima01")
      LET tm.wc2=cl_replace_str(tm.wc2, "imk02", "b.imk02")  #****
      LET tm.wc2=cl_replace_str(tm.wc2, "ima12", "a.ima12")
      LET tm.wc2=cl_replace_str(tm.wc2, "ima06", "a.ima06")

      SELECT sma51,sma52 INTO l_sma51,l_sma52 FROM sma_file
      CALL s_lsperiod(l_sma51,l_sma52) RETURNING l_sma51, l_sma52
      LET l_str  ="'" ,l_sma51 ,"'"
      LET l_str1="'" ,l_sma52 ,"'"
      LET l_str  =cl_replace_str(l_str, " ", "")
      LET l_str1=cl_replace_str(l_str1, " ", "")

      INITIALIZE sr.* TO NULL

      select *  into sr.* from csfr011_tmp

      #******
      #LET l_sql=" SELECT distinct a.ima01,a.ima02,a.ima021,a.ima08,a.ima46,(nvl(a.ima48,0)+nvl(a.ima49,0)+nvl(a.ima491,0)+nvl(a.ima50,0)), ",
      #          " '','',c.mss_v,c.imk09,a.ima25,c.d1,c.d2, ", #add c.ima46,c.ima49, shijl 2017/3/29 10:08   # mod by lixwz 20170728 b.imk02->c.mss_v
      #          " c.s1,c.s2,c.s3,c.s4,c.s5,c.s6,c.s7,c.s8,c.s9,c.s10,c.s11,c.s12,c.s13,c.s14,c.s15,c.s16,c.s17,c.s18, ",
      #          " c.s19,c.s20,c.s21,c.s22,c.s23,c.s24, ",
      #          " a.ima06,a.ima131,a.ima27,a.ima54,d.pmc03,a.ima12,a.ima902,sta04+ta_sta03 ",
      #          " FROM ima_file a ",
      #          " LEFT JOIN sta_file on sta01=a.ima01  ",
      #          " LEFT JOIN stb_file on stb01=a.ima01  ",
      #          " LEFT JOIN pmc_file d on d.pmc01=a.ima54  ",
      #          " ,imk_file b ",
      #          " LEFT JOIN csfr011_tmp c ON c.sfa03=b.imk01 AND b.imk02=c.imk02 ",
      #          "  AND b.imk05=",l_str,#" AND b.imk06=",l_str1,
      #          "  AND b.imk01=a.ima01",
      #          "  AND stb02= ",l_str,
      #          "  AND stb03= ",l_sma52#,
      #          #"  AND ",tm.wc2 CLIPPED
      # mark by lixwz 20170728
                # *************
      LET l_sql = "SELECT distinct c.sfa03,c.ima02,c.ima021,c.ima08,c.ima46,c.ima49, ",
                "c.sma51,c.sma52,c.mss_v,c.imk09,c.ima25,c.d1,c.d2,",
                " c.s1,c.s2,c.s3,c.s4,c.s5,c.s6,c.s7,c.s8,c.s9,c.s10,c.s11,c.s12,c.s13,c.s14,c.s15,c.s16,c.s17,c.s18, ",
                " c.s19,c.s20,c.s21,c.s22,c.s23,c.s24, ",
                " c.a1,c.a2,c.a3,c.a4,c.a5,c.a6,c.a7,c.a8,c.a9,c.a10,c.a11,c.a12,",   # add by lixwz 20170905
                " a.ima06,a.ima131,a.ima27,a.ima54,d.pmc03,a.ima12,a.ima902,sta04+ta_sta03 ",
                " FROM csfr011_tmp c",
                " LEFT JOIN ima_file a ON a.ima01 = c.sfa03",
                " LEFT JOIN pmc_file d ON d.pmc01=a.ima54",
                " LEFT JOIN sta_file ON sta01=a.ima01  "

     PREPARE cxcr611_prepare1 FROM l_sql
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        EXIT PROGRAM
     END IF
     DECLARE cxcr611_curs1 CURSOR FOR cxcr611_prepare1
     FOREACH cxcr611_curs1 INTO sr.*
        SELECT sma51,sma52 INTO sr.sma51,sr.sma52 FROM sma_file
        IF sr.sma52 = 1 THEN
           LET l_sma51 = sr.sma51 - 1
           LET l_sma52 = 12
        ELSE
           LET l_sma51 = sr.sma51
           LET l_sma52 = sr.sma52 - 1
        END IF
        LET sr.d1 = g_today
        SELECT MAX(sfe04) INTO sr.d2 FROM sfe_file WHERE sfe07 = sr.sfa03
       # add by lixwz 20170728 s
       SELECT SUM(imk09) INTO sr.imk09
            FROM imk_file
            WHERE imk02 in (SELECT UNIQUE msp03 FROM msp_file WHERE msp01=sr.mss_v) AND   imk01=sr.sfa03
              AND imk05 = l_sma51 AND imk06 = l_sma52 AND imkplant = g_plant  #add by pane 170802
      # add by lixwz 20170728 e

      # mark by lixwz 20170728 s
      # SELECT SUM(imk09) INTO sr.imk09 FROM imk_file WHERE imk01 = sr.sfa03
      #                   AND imk05 = l_sma51 AND imk06 = l_sma52 AND imkplant = g_plant
      #                   AND imk02 = sr.imk02
      # mark by lixwz 20170728 e
        #add by shijl 170321--str--
       #mark by pane 170802 begin#
       #IF sr.imk09 <=0 THEN
       #   CONTINUE FOREACH
       #END IF
       #mark by pane 170802 end#
        #add by shijl 170321--end--
        LET sr.ccc91=sr.imk09 #用上期期末库存作为计算库龄标准

         if sr.ccc91 is null then let  sr.ccc91 =0 end if
        LET sr.ccc92=sr.ccc91 *sr.ccc23
         LET p_qty = 0
         LET l_check = "N"
         LET sr.amt01=0
         LET sr.amt02=0
         LET sr.amt03=0
         LET sr.qty01=0
         LET sr.qty02=0
         LET sr.qty03=0
         LET sr.amt10_s=0
         LET sr.qty10_s=0
         #*****
         LET g_sql = "SELECT * FROM ( ",
                     "SELECT * FROM tlf_file,smy_file ",
                     " WHERE tlf01 = '",sr.sfa03,"' ",
                     "   AND tlf06 <='",tm.bdate,"' ",
                     "   AND tlf907 = '1' ",
                     "   AND tlf10 > 0 ",
                     "   AND tlf902 NOT IN (SELECT jce02 FROM jce_file) ",
                    # "   AND tlf902 ='",sr.imk02,"' ", #xuyeh170306 add  #***** lixwz
                     "   AND substr(tlf905,1,3) = smyslip ",
                     "   AND smydmy1 = 'Y' ",
                     "   AND smydmy2 != 'X' ",
                     "   AND smy56 = 'Y' ",
                     " UNION ALL ",
                     "SELECT * FROM tlfo_file,smy_file ",
                     " WHERE tlf01 = '",sr.sfa03,"' ",
                     "   AND tlf06 <='",tm.bdate,"' ",
                     "   AND tlf907 = '1' ",
                     "   AND tlf10 > 0 ",
                     "   AND tlf902 NOT IN (SELECT jce02 FROM jce_file) ",
                     # "   AND tlf902 ='",sr.imk02,"' ", #xuyeh170306 add  #***** lixwz
                     "   AND substr(tlf905,1,3) = smyslip ",
                     "   AND smydmy1 = 'Y' ",
                     "   AND smydmy2 != 'X' ",
                     "   AND smy56 = 'Y' ) ",
                     " ORDER BY tlf06 DESC "
         PREPARE p_cxcr611_tlf FROM g_sql
         DECLARE cxcr611_tlf CURSOR FOR p_cxcr611_tlf

         FOREACH cxcr611_tlf INTO l_tlf.*
            IF STATUS = NOTFOUND THEN
               EXIT FOREACH
            END IF

            IF l_tlf.tlf12 <> 1 THEN   ##080605 Jane
               LET l_tlf.tlf10 = l_tlf.tlf10 * l_tlf.tlf12
            END IF

            IF sr.ccc91 - p_qty - l_tlf.tlf10 > 0 THEN
               LET sr.imk09_s = l_tlf.tlf10
               LET p_qty = p_qty + l_tlf.tlf10
            ELSE
               LET sr.imk09_s = sr.ccc91 - p_qty
               LET l_check = "Y"
            END IF
            CALL csfr011_month(l_tlf.tlf06) RETURNING l_mm

            LET sr.amt10 = sr.ccc23 * sr.imk09_s
            IF l_mm='01' THEN
               LET sr.amt01=sr.amt01+sr.amt10
               LET sr.qty01=sr.qty01+sr.imk09_s
            ELSE
              IF l_mm='02' THEN
                LET sr.amt02=sr.amt02+sr.amt10
                LET sr.qty02=sr.qty02+sr.imk09_s
              ELSE
                LET sr.amt03=sr.amt03+sr.amt10
                LET sr.qty03=sr.qty03+sr.imk09_s
              END IF
            END IF
            LET sr.amt10_s=sr.amt10_s+sr.amt10
            LET sr.qty10_s=sr.qty10_s+sr.imk09_s
            IF l_check = "Y" THEN
               EXIT FOREACH
            END IF
         END FOREACH

         IF sr.ccc91 - p_qty > 0 THEN    ##如果有余数未分配到落点时
            LET sr.imk09_s = sr.ccc91 - p_qty
            LET sr.ccc91 = sr.imk09_s
            LET sr.ima902 = '09/01/01'   ##开帐日  090818 Jane
         END IF
         IF (l_check = 'N' AND sr.ccc91 > 0) THEN ##完全没有库存进料时,直接取呆滞日
            CALL csfr011_month(sr.ima902) RETURNING l_mm
            LET sr.imk09_s = sr.ccc91
            LET sr.amt10 = sr.ccc23 * sr.ccc91
            IF l_mm='01' THEN
               LET sr.amt01=sr.amt01+sr.amt10
               LET sr.qty01=sr.qty01+sr.imk09_s
            ELSE
              IF l_mm='02' THEN
                LET sr.amt02=sr.amt02+sr.amt10
                LET sr.qty02=sr.qty02+sr.imk09_s
              ELSE
                LET sr.amt03=sr.amt03+sr.amt10
                LET sr.qty03=sr.qty03+sr.imk09_s
              END IF
            END IF
            LET sr.amt10_s=sr.amt10_s+sr.amt10
            LET sr.qty10_s=sr.qty10_s+sr.imk09_s
         END IF

         #add by shijl 170323--str--
         IF cl_null(sr.s1) THEN LET sr.s1 = 0 END IF
         IF cl_null(sr.s2) THEN LET sr.s2 = 0 END IF
         IF cl_null(sr.s3) THEN LET sr.s3 = 0 END IF
         IF cl_null(sr.s4) THEN LET sr.s4 = 0 END IF
         IF cl_null(sr.s5) THEN LET sr.s5 = 0 END IF
         IF cl_null(sr.s6) THEN LET sr.s6 = 0 END IF
         IF cl_null(sr.s7) THEN LET sr.s7 = 0 END IF
         IF cl_null(sr.s8) THEN LET sr.s8 = 0 END IF
         IF cl_null(sr.s9) THEN LET sr.s9 = 0 END IF
         IF cl_null(sr.s10) THEN LET sr.s10 = 0 END IF
         IF cl_null(sr.s11) THEN LET sr.s11 = 0 END IF
         IF cl_null(sr.s12) THEN LET sr.s12 = 0 END IF
         IF cl_null(sr.s13) THEN LET sr.s13 = 0 END IF
         IF cl_null(sr.s14) THEN LET sr.s14 = 0 END IF
         IF cl_null(sr.s15) THEN LET sr.s15 = 0 END IF
         IF cl_null(sr.s16) THEN LET sr.s16 = 0 END IF
         IF cl_null(sr.s17) THEN LET sr.s17 = 0 END IF
         IF cl_null(sr.s18) THEN LET sr.s18 = 0 END IF
         IF cl_null(sr.s19) THEN LET sr.s19 = 0 END IF
         IF cl_null(sr.s20) THEN LET sr.s20 = 0 END IF
         IF cl_null(sr.s21) THEN LET sr.s21 = 0 END IF
         IF cl_null(sr.s22) THEN LET sr.s22 = 0 END IF
         IF cl_null(sr.s23) THEN LET sr.s23 = 0 END IF
         IF cl_null(sr.s24) THEN LET sr.s24 = 0 END IF
         #add by shijl 170323--end--

         #add by pane 170810 begin#
         IF sr.imk09 <=0 AND sr.s1<=0 AND sr.s2<=0 AND sr.s3<=0 AND sr.s4<=0 AND sr.s5<=0 AND
            sr.s6<=0 AND sr.s7<=0 AND sr.s8<=0 AND sr.s9<=0 AND sr.s10<=0 AND sr.s11<=0 AND sr.s12<=0 AND
            sr.s13<=0 AND sr.s14<=0 AND sr.s15<=0 AND sr.s16<=0 AND sr.s17<=0 AND sr.s18<=0 AND sr.s19<=0 AND
            sr.s20<=0 AND sr.s21<=0 AND sr.s22<=0 AND sr.s23<=0 AND sr.s24<= 0 THEN
            CONTINUE FOREACH
         END IF
         #add by pane 170810 end#

      EXECUTE insert_prep USING
         sr.sfa03,sr.ima02,
         sr.ima021,sr.ima08,sr.ima46,sr.ima49,sr.sma51,sr.sma52,sr.mss_v,sr.imk09,sr.ima25,sr.d1,sr.d2, #add sr.ima46,sr.ima49  shijl 2017/3/29 10:09 # mod by lixwz 20170728 imk02 -> mss_v
         sr.s1,sr.s2,sr.s3,sr.s4,sr.s5,sr.s6,sr.s7,sr.s8,sr.s9,sr.s10,
         sr.s11,sr.s12,sr.s13,sr.s14,sr.s15,sr.s16,sr.s17,sr.s18,sr.s19,sr.s20,
         sr.s21,sr.s22,sr.s23,sr.s24
         ,sr.a1,sr.a2,sr.a3,sr.a4,sr.a5,sr.a6,sr.a7,sr.a8,sr.a9,sr.a10,sr.a11,sr.a12   # add by lixwz 20170905
         ,sr.ima06,sr.ima131,sr.ima27,sr.ima54,sr.pmc03,sr.qty01,sr.qty02,sr.qty03,sr.qty10_s,sr.amt01,
         sr.amt02,sr.amt03,sr.amt10_s,sr.ima12,sr.ima902,sr.ccc23
     END FOREACH
#add by shijl 170321--end--

   #str FUN-720005 add
   ## **** 與 Crystal Reports 串聯段 - <<<< CALL cs3() >>>> FUN-720005 **** ##
   LET l_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED   #FUN-710080 modify
   #是否列印選擇條件
   IF g_zz05 = 'Y' THEN
      CALL cl_wcchp(tm.wc,'sfb01,sfb05,sfa03,ima12,ima06') #xueyh170303 add ima12,ima06
           RETURNING tm.wc
      LET g_str = tm.wc
   END IF
  CALL cl_prt_cs3('csfr011','csfr011',l_sql,g_str)   #FUN-710080 modify


  CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818
END FUNCTION
#xueyh170303 add-----------start-------------
 FUNCTION csfr011_month(l_date)     ## 月份区间之落点
#-----------------------------------------------------------------------------#
    DEFINE p_yy,p_mm    SMALLINT
    DEFINE l_yy1,l_yy2  CHAR(04)
    DEFINE l_yy3        CHAR(04)
    DEFINE l_mm,s_mm    CHAR(2)
    DEFINE l_char10     CHAR(10)
    DEFINE l_date       DATE
    DEFINE ii,jj,kk     SMALLINT

     LET ii = tm.bdate - l_date
     CASE
        WHEN ii>=tm.i10 AND ii<=tm.i11
             LET l_mm = "01"
        WHEN ii>=tm.i20 AND ii<=tm.i21
             LET l_mm = "02"
        WHEN ii>=tm.i30
             LET l_mm = "03"
        OTHERWISE
             LET l_mm = "01"
     END CASE
     RETURN l_mm
END FUNCTION
#xueyh170303 add-----------end--------------

#add by shijl 170321--str--
FUNCTION csfr011_tmp()
  DROP TABLE csfr011_tmp
  #add ima46 ima50 shijl 2017/3/29 10:04

             # imk02  LIKE imk_file.imk02,  mark by lixwz 20170728
  CREATE TEMP TABLE csfr011_tmp(
              sfa03  LIKE sfa_file.sfa03,
              ima02  LIKE ima_file.ima02,
              ima021 LIKE ima_file.ima021,
              ima08  LIKE ima_file.ima08,
              ima46  LIKE ima_file.ima46,
              ima49  LIKE ima_file.ima49,
              sma51  LIKE sma_file.sma51,
              sma52  LIKE sma_file.sma52,
              mss_v   LIKE mss_file.mss_v,
              imk09  LIKE imk_file.imk09,
              ima25  LIKE ima_file.ima25,
              d1     LIKE sfb_file.sfb13,
              d2     LIKE sfb_file.sfb13,
              s1     LIKE sfa_file.sfa05,
              s2     LIKE sfa_file.sfa05,
              s3     LIKE sfa_file.sfa05,
              s4     LIKE sfa_file.sfa05,
              s5     LIKE sfa_file.sfa05,
              s6     LIKE sfa_file.sfa05,
              s7     LIKE sfa_file.sfa05,
              s8     LIKE sfa_file.sfa05,
              s9     LIKE sfa_file.sfa05,
              s10    LIKE sfa_file.sfa05,
              s11    LIKE sfa_file.sfa05,
              s12    LIKE sfa_file.sfa05,
              s13    LIKE sfa_file.sfa05,
              s14    LIKE sfa_file.sfa05,
              s15    LIKE sfa_file.sfa05,
              s16    LIKE sfa_file.sfa05,
              s17    LIKE sfa_file.sfa05,
              s18    LIKE sfa_file.sfa05,
              s19    LIKE sfa_file.sfa05,
              s20    LIKE sfa_file.sfa05,
              s21    LIKE sfa_file.sfa05,
              s22    LIKE sfa_file.sfa05,
              s23    LIKE sfa_file.sfa05,
              s24    LIKE sfa_file.sfa05,
              a1     LIKE sfa_file.sfa05,
              a2     LIKE sfa_file.sfa05,
              a3     LIKE sfa_file.sfa05,
              a4     LIKE sfa_file.sfa05,
              a5     LIKE sfa_file.sfa05,
              a6     LIKE sfa_file.sfa05,
              a7     LIKE sfa_file.sfa05,
              a8     LIKE sfa_file.sfa05,
              a9     LIKE sfa_file.sfa05,
              a10    LIKE sfa_file.sfa05,
              a11    LIKE sfa_file.sfa05,
              a12    LIKE sfa_file.sfa05,
              ima06   LIKE ima_file.ima06,
              ima131  LIKE ima_file.ima131,
              ima27   LIKE ima_file.ima27,
              ima54   LIKE ima_file.ima54,
              pmc03   LIKE pmc_file.pmc03,
              ima12   LIKE ima_file.ima12,
              ima902  LIKE ima_file.ima902,
              ccc23   LIKE sta_file.sta04,
              ccc91   LIKE ccc_file.ccc91,
              ccc92   LIKE ccc_file.ccc92,
              imk09_s LIKE imk_file.imk09,
              amt10   LIKE type_file.num20_6,
              qty10_s LIKE type_file.num20_6,
              amt10_s LIKE type_file.num20_6,
              amt01   LIKE type_file.num20_6,
              amt02   LIKE type_file.num20_6,
              amt03   LIKE type_file.num20_6,
              qty01   LIKE type_file.num20_6,
              qty02   LIKE type_file.num20_6,
              qty03   LIKE type_file.num20_6);
END FUNCTION
#add by shijl 170321--end--
