
# Pattern name...: cxmq111.4gl
# Descriptions...: 客戶总账及出货明细帐表
# Date & Author..: 17/02/03  shijl
# Modify by shijl 170713 订单靠前排

DATABASE ds  #MOD-990260

GLOBALS "../../../tiptop/config/top.global"  #No.FUN-A30013

DEFINE tm             RECORD               
          wc      STRING,	
		      bdate   LIKE type_file.dat, 
		      edate   LIKE type_file.dat, 
          b       LIKE type_file.chr1,
          curr    LIKE azi_file.azi01, 
          c       LIKE type_file.chr1,
		      more    LIKE type_file.chr1  # Input more condition(Y/N)
                      END RECORD
DEFINE g_d            LIKE type_file.chr1
DEFINE g_print        LIKE type_file.num5
DEFINE g_str          STRING
DEFINE l_table        STRING
DEFINE g_sql          STRING
DEFINE g_rec_b        LIKE type_file.num10
DEFINE g_oea03        LIKE oea_file.oea03
DEFINE g_oea032        LIKE oea_file.oea032
DEFINE g_oea23        LIKE oea_file.oea23 
DEFINE g_mm           LIKE type_file.num5
DEFINE mm1,nn1        LIKE type_file.num10
DEFINE yy             LIKE type_file.num10
DEFINE g_cnt          LIKE type_file.num10
DEFINE g_seq          LIKE type_file.num10
DEFINE g_oea          DYNAMIC ARRAY OF RECORD
                      vdate      LIKE npp_file.npp02,   #日期
                      oea01      LIKE oea_file.oea01,   #订单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      a          LIKE npq_file.npq07,   #本币订单金额
                      af          LIKE npq_file.npq07,   #原币订单金额
                      b          LIKE npq_file.npq07,   #出货金额
                      bf          LIKE npq_file.npq07,   #出货金额
                      c          LIKE npq_file.npq07,   #开票金额
                      cf          LIKE npq_file.npq07,   #开票金额
                      d          LIKE npq_file.npq07,   #回款金额
                      df          LIKE npq_file.npq07,   #回款金额
                      h          LIKE npq_file.npq07,   #订单应收余额            
                      hf          LIKE npq_file.npq07,   #订单应收余额            
                      i          LIKE npq_file.npq07,   #出货未开票金额
                      iff          LIKE npq_file.npq07,   #出货未开票金额
                      j          LIKE npq_file.npq07,   #下单未发货金额     
                      jf          LIKE npq_file.npq07,   #下单未发货金额     
                      k          LIKE npq_file.npq07,   #开票应收余额
                      kf          LIKE npq_file.npq07,   #开票应收余额
                      exp         LIKE type_file.chr300   #说明
                      END RECORD
DEFINE g_pr           RECORD
                      oea03      LIKE oea_file.oea03,
                      oea032      LIKE oea_file.oea032,
                      oea23      LIKE oea_file.oea23,
                      mm         LIKE type_file.num5,
                      vdate      LIKE npp_file.npp02,   #日期
                      oea01      LIKE oea_file.oea01,   #订单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      a          LIKE npq_file.npq07,   #本币订单金额
                      af          LIKE npq_file.npq07,   #原币订单金额
                      b          LIKE npq_file.npq07,   #出货金额
                      bf          LIKE npq_file.npq07,   #出货金额
                      c          LIKE npq_file.npq07,   #开票金额
                      cf          LIKE npq_file.npq07,   #开票金额
                      d          LIKE npq_file.npq07,   #回款金额
                      df          LIKE npq_file.npq07,   #回款金额
                      h          LIKE npq_file.npq07,   #订单应收余额            
                      hf          LIKE npq_file.npq07,   #订单应收余额            
                      i          LIKE npq_file.npq07,   #出货未开票金额
                      iff          LIKE npq_file.npq07,   #出货未开票金额
                      j          LIKE npq_file.npq07,   #下单未发货金额     
                      jf          LIKE npq_file.npq07,   #下单未发货金额     
                      k          LIKE npq_file.npq07,   #开票应收余额
                      kf          LIKE npq_file.npq07,   #开票应收余额   
                      exp         LIKE type_file.chr300,   #说明
                      pagenum    LIKE type_file.num5,
                      seq    LIKE type_file.num5,
                      azi04      LIKE azi_file.azi04,
                      azi05      LIKE azi_file.azi05,
                      azi07      LIKE azi_file.azi07
                      END RECORD
DEFINE g_msg          LIKE type_file.chr1000
DEFINE g_row_count    LIKE type_file.num10  
DEFINE g_curs_index   LIKE type_file.num10  
DEFINE g_jump         LIKE type_file.num10  
DEFINE mi_no_ask      LIKE type_file.num5   
DEFINE l_ac           LIKE type_file.num5           #目前處理的ARRAY CNT        

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                        # Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF

   INITIALIZE tm.* TO NULL                # Default condition

   #-->使用預設帳別之幣別
   #-----TQC-610053---------
   LET g_pdate  = ARG_VAL(1)
   LET g_towhom = ARG_VAL(2)
   LET g_rlang  = ARG_VAL(3)
   LET g_bgjob  = ARG_VAL(4)
   LET g_prtway = ARG_VAL(5)
   LET g_copies = ARG_VAL(6)
   LET tm.wc    = ARG_VAL(7)
   LET tm.bdate = ARG_VAL(8)
   LET tm.edate = ARG_VAL(9)
   LET tm.b     = ARG_VAL(10)
   LET tm.curr  = ARG_VAL(11)  
   LET tm.c     = ARG_VAL(12)
   LET g_rep_user = ARG_VAL(16)
   LET g_rep_clas = ARG_VAL(17)
   LET g_template = ARG_VAL(18)
   LET g_rpt_name = ARG_VAL(19)
   #-----END TQC-610053----

   CALL q111_out_1()
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-B30211

   OPEN WINDOW q111_w AT 5,10
        WITH FORM "cxm/42f/cxmq111_1" ATTRIBUTE(STYLE = g_win_style)

   CALL cl_ui_init()

   IF cl_null(tm.wc) THEN
      CALL cxmq111_tm(0,0)             # Input print condition
   ELSE
      CALL cxmq111() 
      CALL cxmq111_t()
   END IF

   CALL q111_menu()
   DROP TABLE cxmq111_tmp;
   CLOSE WINDOW q111_w
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
END MAIN

FUNCTION q111_menu()
   DEFINE   l_cmd   LIKE type_file.chr1000       
 
   WHILE TRUE
      CALL q111_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL cxmq111_tm(0,0)
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL q111_out_2()
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"
            IF cl_chk_act_auth() THEN
               CALL cl_export_to_excel
               (ui.Interface.getRootNode(),base.TypeInfo.create(g_oea),'','')
            END IF
      END CASE
   END WHILE
END FUNCTION

FUNCTION cxmq111_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01      
DEFINE li_chk_bookno  LIKE type_file.num5      
DEFINE p_row,p_col    LIKE type_file.num5,     
       l_n            LIKE type_file.num5,     
       l_flag         LIKE type_file.num5,     
       l_cmd          LIKE type_file.chr1000   

   LET p_row = 3 LET p_col =20

   OPEN WINDOW cxmq111_w AT p_row,p_col WITH FORM "cxm/42f/cxmq111"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)
 
   CALL cl_ui_locale("cxmq111")

   CALL cl_opmsg('p')
   LET tm.bdate = g_today
   LET tm.edate = g_today
   LET tm.b = 'N'
   LET tm.curr = NULL   #No.FUN-A30009
   LET tm.c = 'N'       
   LET tm.more = 'N'
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies = '1'

   DISPLAY BY NAME tm.bdate,tm.edate,tm.b,tm.curr,tm.c,tm.more  #No.FUN-A30009
 
 WHILE TRUE
   CONSTRUCT BY NAME tm.wc ON oea03,oea01

       BEFORE CONSTRUCT
          CALL cl_qbe_init()

       ON ACTION CONTROLP
          CASE 
               WHEN INFIELD(oea03)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state= 'c'
                  LET g_qryparam.form = 'q_occ'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oea03
                  NEXT FIELD oea03

               WHEN INFIELD(oea01)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state= 'c'
                  LET g_qryparam.form = 'q_oea2_2'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oea01
                  NEXT FIELD oea01
          END CASE

       ON ACTION locale
          CALL cl_show_fld_cont()                   
          LET g_action_choice = "locale"
          EXIT CONSTRUCT

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
       ON ACTION about         
          CALL cl_about()      
 
       ON ACTION help          
          CALL cl_show_help()  
 
       ON ACTION controlg      
          CALL cl_cmdask()     
 
       ON ACTION exit
          LET INT_FLAG = 1
          EXIT CONSTRUCT
       
       ON ACTION qbe_select
          CALL cl_qbe_select()
       
    END CONSTRUCT
    IF g_action_choice = "locale" THEN
       LET g_action_choice = ""
       CALL cl_dynamic_locale()
       CONTINUE WHILE
    END IF

    IF INT_FLAG THEN
        LET tm.wc = ' 1=2'
    ELSE

    IF tm.wc = ' 1=1' THEN
       CALL cl_err('','9046',0) CONTINUE WHILE
    END IF
    INPUT BY NAME tm.bdate,tm.edate,tm.b,tm.curr,tm.c,tm.more  #No.FUN-A30009
                  WITHOUT DEFAULTS
        
        BEFORE INPUT
            CALL cl_qbe_display_condition(lc_qbe_sn)
            #No.FUN-A30009  --Begin WO
            CALL q111_set_entry()
            CALL q111_set_no_entry()
            #No.FUN-A30009  --End  

        
        AFTER FIELD bdate
          IF cl_null(tm.bdate) THEN
             CALL cl_err('','mfg3018',0)
             NEXT FIELD bdate
          END IF

        AFTER FIELD edate
          IF cl_null(tm.edate) THEN
             CALL cl_err('','mfg3018',0)
             NEXT FIELD edate
          END IF
          IF YEAR(tm.bdate) <> YEAR(tm.edate) THEN
             CALL cl_err('','gxr-001',0)
             NEXT FIELD bdate
          END IF
          IF tm.bdate > tm.edate THEN
             CALL cl_err('','aap-100',0)
             NEXT FIELD bdate
          END IF

 
        #No.FUN-A30009  --Begin
        BEFORE FIELD b
          CALL q111_set_entry()

        AFTER FIELD b
          IF cl_null(tm.b) OR tm.b NOT MATCHES'[YN]' THEN NEXT FIELD b END IF
          CALL q111_set_no_entry()

        ON CHANGE b
          IF tm.b = 'Y' THEN
             LET tm.c = 'Y'
             DISPLAY BY NAME tm.c      
          END IF
          CALL q111_set_entry()
          CALL q111_set_no_entry()
                    
        AFTER FIELD curr
          IF NOT cl_null(tm.curr) THEN
             SELECT * FROM azi_file WHERE azi01=tm.curr
             IF SQLCA.sqlcode THEN
                CALL cl_err3('sel','azi_file',tm.curr,'',SQLCA.sqlcode,'','','0')
                NEXT FIELD curr
             END IF
          END IF
        #No.FUN-A30009  --End  

        AFTER FIELD c
          IF cl_null(tm.c) OR tm.c NOT MATCHES '[YN]' THEN
             NEXT FIELD c
          END IF         
 
        AFTER FIELD more
           IF tm.more = 'Y'
              THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                                  g_bgjob,g_time,g_prtway,g_copies)
                        RETURNING g_pdate,g_towhom,g_rlang,
                                  g_bgjob,g_time,g_prtway,g_copies
           END IF

        #No.FUN-A30009  --Begin
        ON ACTION CONTROLP
           CASE
            # WHEN INFIELD(tm.curr)           #No.FUN-A40020                    
              WHEN INFIELD(curr)              #No.FUN-A40020
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = 'q_azi'
                 LET g_qryparam.default1 =tm.curr
                 CALL cl_create_qry() RETURNING tm.curr
                 DISPLAY BY NAME tm.curr
                 NEXT FIELD curr
           END CASE
        #No.FUN-A30009  --End  

        ON ACTION CONTROLZ
           CALL cl_show_req_fields()

        ON ACTION CONTROLG CALL cl_cmdask()    # Command execution

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT
 
        ON ACTION about         
           CALL cl_about()      
 
        ON ACTION HELP          
           CALL cl_show_help()  
 
        ON ACTION exit
           LET INT_FLAG = 1
           EXIT INPUT

        ON ACTION qbe_save
           CALL cl_qbe_save()
        
    END INPUT
    IF INT_FLAG THEN
        LET tm.wc = ' 1=2'
    END IF 
    IF g_bgjob = 'Y' THEN
       SELECT zz08 INTO l_cmd FROM zz_file    #get exec cmd (fglgo xxxx)
              WHERE zz01='cxmq111'
       IF SQLCA.sqlcode OR l_cmd IS NULL THEN
          CALL cl_err('cxmq111','9031',1)
       ELSE
          LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
          LET l_cmd = l_cmd CLIPPED,        #(at time fglgo xxxx p1 p2 p3)
                          " '",g_pdate   CLIPPED,"'",
                          " '",g_towhom  CLIPPED,"'",
                          " '",g_lang    CLIPPED,"'",
                          " '",g_bgjob   CLIPPED,"'",
                          " '",g_prtway  CLIPPED,"'",
                          " '",g_copies  CLIPPED,"'",
                          " '",tm.wc     CLIPPED,"'",
                          " '",tm.bdate  CLIPPED,"'",
                          " '",tm.edate  CLIPPED,"'",
                          " '",tm.b      CLIPPED,"'",
                          " '",tm.curr   CLIPPED,"'",  #No.FUN-A30009
                          " '",tm.c      CLIPPED,"'",            
                          " '",g_rep_user CLIPPED,"'",           
                          " '",g_rep_clas CLIPPED,"'",           
                          " '",g_template CLIPPED,"'"            
          CALL cl_cmdat('cxmq111',g_time,l_cmd)    # Execute cmd at later time
       END IF
       CLOSE WINDOW cxmq111_w
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
    END IF
    END IF                        #No.FUN-A40009
    CALL cl_wait()
    CALL cxmq111()
    ERROR ""
    EXIT WHILE   
END WHILE
   CLOSE WINDOW cxmq111_w
#No.FUN-A40009 --begin  
   IF INT_FLAG THEN    
      LET INT_FLAG = 0
      RETURN         
   END IF           
#No.FUN-A40009 --end 
  
   CALL cxmq111_t()
END FUNCTION

FUNCTION cxmq111()
   DEFINE l_name    LIKE type_file.chr20,    
          l_sql     STRING,             
          l_sql1    STRING,             
          l_flag    LIKE type_file.chr1,     
          l_i       LIKE type_file.num5,     
          l_term    LIKE type_file.chr1000,            
          sr1       RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23 
                    END RECORD,
          sr        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    oea01      LIKE oea_file.oea01,   #订单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    a          LIKE npq_file.npq07,   #本币订单金额
                    af          LIKE npq_file.npq07,   #原币订单金额
                    b          LIKE npq_file.npq07,   #出货金额
                    bf          LIKE npq_file.npq07,   #出货金额
                    c          LIKE npq_file.npq07,   #开票金额
                    cf          LIKE npq_file.npq07,   #开票金额
                    d          LIKE npq_file.npq07,   #回款金额
                    df          LIKE npq_file.npq07,   #回款金额
                    h          LIKE npq_file.npq07,   #订单应收余额            
                    hf          LIKE npq_file.npq07,   #订单应收余额            
                    i          LIKE npq_file.npq07,   #出货未开票金额
                    iff          LIKE npq_file.npq07,   #出货未开票金额
                    j          LIKE npq_file.npq07,   #下单未发货金额     
                    jf          LIKE npq_file.npq07,   #下单未发货金额     
                    k          LIKE npq_file.npq07,   #开票应收余额
                    kf          LIKE npq_file.npq07,   #开票应收余额                                
                    exp        LIKE npq_file.npq07    #说明 
                    END RECORD 
  
    DEFINE  lf_d  LIKE   npq_file.npq07     
    DEFINE  l_d   LIKE   npq_file.npq07     
    DEFINE  lf_c  LIKE   npq_file.npq07      
    DEFINE  l_c   LIKE   npq_file.npq07      
    
    #LET g_prog = 'gapr910'
    CALL cxmq111_table()
     
    SELECT zo02 INTO g_company FROM zo_file
     WHERE zo01 = g_rlangf

     LET mm1 = MONTH(tm.bdate)
     LET nn1 = MONTH(tm.edate)
     LET yy  = YEAR(tm.bdate)

     LET l_term = " ",tm.wc CLIPPED
     IF NOT cl_null(tm.curr) THEN 
         LET l_term =" ",tm.wc CLIPPED," AND oea23='",tm.curr,"' "
     END IF      
     IF tm.c = 'Y' THEN                                                    
         LET l_sql = " SELECT UNIQUE oea03,oea032,oea23 ",            
                     "   FROM oea_file WHERE",l_term CLIPPED           
     ELSE                                                                  
         LET l_sql = " SELECT UNIQUE oea03,oea032,'' ",               
                     "   FROM oea_file WHERE",l_term CLIPPED
     END IF                                                                
     PREPARE cxmq111_pr1 FROM l_sql
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_curs1 CURSOR FOR cxmq111_pr1
     
     #type                  REPORT之前抓取赋值
     # 0 年初余额                
     # 1 订单                    Y   
     # 2 回款作业单              Y   
     # 3 发货作业单              Y   
     # 4 开票作业单              Y  
     # 5 订单小计               
     # 6 MISC开票小计            
     # 7 收支作业单              
     # 8 未维护收支单小计         
     # 9 本期合计                     
     #10 累计额                  
     #11 销退作业单              Y    
     
     IF tm.c = 'Y' THEN                                                     
        LET l_sql1="SELECT DISTINCT oea03,oea032,oea23,0,oea02,oea01,1,oea01,",
                   " oea1008,oea1008*oea24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'' ",                   
                   "  FROM oea_file ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND oea23 = ? ", #币别
                   "   AND oea02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND MONTH(oea02) = ? " #月份
     ELSE
        LET l_sql1="SELECT DISTINCT oea03,oea032,oea23,0,oea02,oea01,1,oea01,",
                   " oea1008,oea1008*oea24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,'' ",                   
                   "  FROM oea_file ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND oea02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND MONTH(oea02) = ? " #月份
     END IF                                                                     
  
     PREPARE cxmq111_prepare0 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare0:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb0 CURSOR FOR cxmq111_prepare0

     #按月抓明细
     #回款作业
     IF tm.c = 'Y' THEN                                                     
        LET l_sql1=" SELECT DISTINCT oea03,oea032,oea23,0,tc_nmgdate,oea01,2,tc_nmg01,",
                   " 0,0,0,0,0,0,NVL(tc_nme05,0),NVL(tc_nme13,0),0,0,0,0,0,0,0,0,'' ",                     
                   "  FROM tc_nmg_file,tc_nme_file ",
                   "  LEFT JOIN oea_file ON tc_nme03 = oea01 ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND tc_nme01 = tc_nmg01  AND tc_nmg09 ='A' ", #收支类型是'A'
                   "   AND tc_nme14 = ? ", #币别
                   "   AND tc_nmgdate BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND MONTH(tc_nmgdate) = ? " #月份 
     ELSE
        LET l_sql1=" SELECT DISTINCT oea03,oea032,oea23,0,tc_nmgdate,oea01,2,tc_nmg01,",
                   " 0,0,0,0,0,0,NVL(tc_nme05,0),NVL(tc_nme13,0),0,0,0,0,0,0,0,0,'' ",                     
                   "  FROM tc_nmg_file,tc_nme_file ",
                   "  LEFT JOIN oea_file ON tc_nme03 = oea01 ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND tc_nme01 = tc_nmg01  AND tc_nmg09 ='A' ", #收支类型是'A'
                   "   AND tc_nmgdate BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND MONTH(tc_nmgdate) = ? " #月份
     END IF                                                                     
  
     PREPARE cxmq111_prepare1 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb1 CURSOR FOR cxmq111_prepare1
     
     #开票作业
     IF tm.c = 'Y' THEN       #按币种分页                                              
        LET l_sql1=" SELECT DISTINCT omf05,omf051,omf07,0,omf03,ogb31,4,omf00,0,0,0,0, ",
                   " (case when substr(oma00,1,1)='2' and sum(omb16t)>0 then sum(omb16t)*-1 else sum(omb16t) end),",                   
                   " (case when substr(oma00,1,1)='2' and sum(omb14t)>0 then sum(omb14t)*-1 else sum(omb14t) end),",
                   " 0,0,0,0,0,0,0,0,0,0,'' ",  
                   " from oma_file,omb_file,ogb_file,omf_file,oea_file  ",
                   " where oma01=omb01 and omb31=omf11 and omb32=omf12  ",
                   " and oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   " and ogb01=omb31 and ogb03=omb32  ",
                   "   AND oea03 = ? AND oea032 = ? ",
                   " and oea01=ogb31  and oma23=? ",
                   "  AND MONTH(omf03) = ? ", #月份 
                   "  AND ",l_term CLIPPED,  
                   " GROUP BY omf05,omf051,omf07,0,omf03,ogb31,omf00,oma00,oma33  "

     ELSE
        LET l_sql1=" SELECT DISTINCT omf05,omf051,omf07,0,omf03,ogb31,4,omf00,0,0,0,0, ",
                   " (case when substr(oma00,1,1)='2' and sum(omb16t)>0 then sum(omb16t)*-1 else sum(omb16t) end),",                   
                   " (case when substr(oma00,1,1)='2' and sum(omb14t)>0 then sum(omb14t)*-1 else sum(omb14t) end),",
                   " 0,0,0,0,0,0,0,0,0,0,'' ",
                   " from oma_file,omb_file,ogb_file,omf_file,oea_file  ",
                   " where oma01=omb01 and omb31=omf11 and omb32=omf12  ",
                   " and oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   " and ogb01=omb31 and ogb03=omb32  ",
                   "   AND oea03 = ? AND oea032 = ? ",
                   " and oea01=ogb31   ",
                   "  AND MONTH(omf03) = ? ", #月份 
                   "  AND ",l_term CLIPPED,     
                   " GROUP BY omf05,omf051,omf07,0,omf03,ogb31,omf00,oma00,oma33  "
     END IF                                                                       
  
     PREPARE cxmq111_prepare2 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb2 CURSOR FOR cxmq111_prepare2     
      
     #出货/销退作业
     IF tm.c = 'Y' THEN       #按币种分页                                              
        LET l_sql1=" SELECT DISTINCT oga03,oga032,oga23,0,oga02,oga16,3,oga01,0,0, ",
                   " SUM(ogb14t)*oga24,SUM(ogb14t),",
                   " 0,0,0,0,0,0,0,0,0,0,0,0,'' ",
                   " FROM oga_file,oea_file,ogb_file  ",
                   " WHERE oga01=ogb01 and oga02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oga16=oea01 AND ",l_term CLIPPED,  
                   "   AND oga03 = ? AND oga032 = ? AND oga23=?  AND oga09 IN ('2','4','6')  AND ogaconf != 'X' ",
                   "   AND MONTH(oga02) = ? ", #月份   
                   "   and ogapost='Y' and ogaconf='Y' ",                    
                   "   AND NOT EXISTS (SELECT * FROM oma_file,omb_file WHERE oma01=omb01 AND omavoid='N' AND omb31=oga01 ) ",
                   " group by oga03,oga032,oga23,oga24,0,oga02,oga16,oga01,oga51,oga511  " ,
                   " union ",
                   " SELECT DISTINCT oha03,oha032,oha23,0,oha02,oga16,11,oha01,0,0, ",
                   " nvl(sum(ohb14t),0)*-1,nvl(sum(ohb14t),0)*-1*oha24, ",
                   " 0,0,0,0,0,0,0,0,0,0,0,0,'' ",
                   " from oha_file,oga_file,oea_file,ohb_file ",
                   " WHERE oha01=ohb01 and oha02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oga16=oea01 AND ",l_term CLIPPED,  
                   "   AND oha03 = ? AND oha032 = ? AND oha23=? ",
                   "   AND MONTH(oha02) = ? ", #月份  
                   "   AND ohaconf='Y' AND ohapost='Y' ",
                   "   AND NOT EXISTS (SELECT * FROM oma_file,omb_file WHERE oma01=omb01 AND omavoid='N' AND omb31=oha01 ) ",                     
                   "   AND  oha16=oga01 and ohaconf<>'X' ",
                   " GROUP BY oha03,oha032,oha23,oha24,0,oha02,oga16,oha01  "

     ELSE
        LET l_sql1=" SELECT DISTINCT oga03,oga032,oga23,0,oga02,oga16,3,oga01,0,0, ",
                   " SUM(ogb14t)*oga24,SUM(ogb14t),",
                   " 0,0,0,0,0,0,0,0,0,0,0,0,'' ",
                   " FROM oga_file,oea_file,ogb_file ",
                   " WHERE oga01=ogb01 and oga02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oga16=oea01 AND ",l_term CLIPPED,  
                   "   AND oga03 = ? AND oga032 = ?  AND oga09 IN ('2','4','6')  AND ogaconf != 'X' ",
                   "   AND MONTH(oga02) = ? ", #月份   
                   "   and ogapost='Y' and ogaconf='Y' ", 
                   "   AND NOT EXISTS (SELECT * FROM oma_file,omb_file WHERE oma01=omb01 AND omavoid='N' AND omb31=oga01 ) ",
                   " group by oga03,oga032,oga23,oga24,0,oga02,oga16,oga01,oga51,oga511  " ,
                   " union ",
                   " SELECT DISTINCT oha03,oha032,oha23,0,oha02,oga16,11,oha01,0,0, ",
                   " nvl(sum(ohb14t),0)*-1,nvl(sum(ohb14t),0)*-1*oha24, ",
                   " 0,0,0,0,0,0,0,0,0,0,0,0,'' ",
                   " from oha_file,oga_file,oea_file,ohb_file ",
                   " WHERE oha01=ohb01 and  oha02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oga16=oea01 AND ",l_term CLIPPED,
                   "   AND oha03 = ? AND oha032 = ? ",
                   "   AND MONTH(oha02) = ? ", #月份  
                   "   AND ohaconf='Y' AND ohapost='Y' ",
                   "   AND NOT EXISTS (SELECT * FROM oma_file,omb_file WHERE oma01=omb01 AND omavoid='N' AND omb31=oha01 ) ",                     
                   "   AND  oha16=oga01 and ohaconf<>'X' ",
                   " GROUP BY oha03,oha032,oha23,oha24,0,oha02,oga16,oha01"
                   
     END IF                          
  
     PREPARE cxmq111_prepare3 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare3:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb3 CURSOR FOR cxmq111_prepare3         
               
     #期初
     IF tm.c = 'Y' THEN 
         LET l_sql1=" SELECT sum(tc_khy09),sum(tc_khy11), ", #期初开票原币,期初回款原币 
                    "        sum(tc_khy10),sum(tc_khy12), ", #期初开票本币,期初回款本币 
                    "        sum(tc_khy05),sum(tc_khy07), ", #期初订单原币,期初出货原币  
                    "        sum(tc_khy06),sum(tc_khy08)  ", #期初订单本币,期初出货本币  
                    "   FROM tc_khy_file   ",
                    "  WHERE tc_khy01 ",YEAR(tm.bdate),                       
                    "    AND tc_khy02 <= ",MONTH(tm.bdate),                       
                    "    AND tc_khy03 = ? ",
                    "    AND tc_khy04 = ? "
                    
     ELSE
         LET l_sql1=" SELECT sum(tc_khy09),sum(tc_khy11), ", #期初开票原币,期初回款原币 
                    "        sum(tc_khy10),sum(tc_khy12), ", #期初开票本币,期初回款本币 
                    "        sum(tc_khy05),sum(tc_khy07), ", #期初订单原币,期初出货原币  
                    "        sum(tc_khy06),sum(tc_khy08)  ", #期初订单本币,期初出货本币 
                    "   FROM tc_khy_file   ",
                    "  WHERE tc_khy01 = ",YEAR(tm.bdate),                       
                    "    AND tc_khy02 <= ",MONTH(tm.bdate),                       
                    "    AND tc_khy03 = ? ",
                    "    AND tc_khy04 = 'RMB' "
     END IF                                                                       
               
     PREPARE cxmq111_prepare4 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_curd CURSOR FOR cxmq111_prepare4    


     #杂项/待抵 MISC开票作业单
     IF tm.c = 'Y' THEN       #按币种分页                                             
        LET l_sql1=" SELECT DISTINCT oma03,oma032,oma23,0,oma02,'',4,omf00,0,0,0,0, ",
                   " (case when substr(oma00,1,1)='2' and oma54t>0 then oma54t*-1 else oma54t end),",
                   " (case when substr(oma00,1,1)='2' and oma56t>0 then oma56t*-1 else oma56t end),",
                   " 0,0,0,0,0,0,0,0,0,0,'' ",    
                   " from oma_file ",
                   " where oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oma03 = ? AND oma032 = ? ",
                   "   AND oma23=? ",
                   "   AND MONTH(oma02) = ? ",
                   "   AND (oma00='14' or oma00 ='22') "
     ELSE
        LET l_sql1=" SELECT DISTINCT oma03,oma032,oma23,0,oma02,'',4,omf00,0,0,0,0, ",
                   " (case when substr(oma00,1,1)='2' and oma54t>0 then oma54t*-1 else oma54t end),",
                   " (case when substr(oma00,1,1)='2' and oma56t>0 then oma56t*-1 else oma56t end),",
                   " 0,0,0,0,0,0,0,0,0,0,'' ",    
                   " from oma_file ",
                   " where oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND oma03 = ? AND oma032 = ? ",
                   "   AND MONTH(oma02) = ? ",
                   "   AND (oma00='14' or oma00 ='22') "
     END IF       
     PREPARE cxmq111_prepare5 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare5:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time 
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb5 CURSOR FOR cxmq111_prepare5 
     
     #未维护收支单 MISC收支作业单
     IF tm.c = 'Y' THEN       #按币种分页                                                 
        LET l_sql1=" SELECT DISTINCT nmh11,nmh30,nmh03,0,nmh04,'',2,nmh01, ",
                   " 0,0,0,0,0,0,(SELECT oma54t FROM oma_file WHERE oma01=nmh01 ),(SELECT oma56t FROM oma_file WHERE oma01=nmh01),0,0,0,0,0,0,0,0,'' ",
                   " from nmh_file ",
                   " where nmh04 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmh11 = ? AND nmh30 = ? ",
                   "   AND nmh03=? ",
                   "   AND MONTH(nmh04) = ? ",
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmh01 ) ",
                   " UNION ",
                   " SELECT DISTINCT nmg18,nmg19,nmg22,0,nmg01,'',2,nmg00, ",
                   " 0,0,0,0,0,0,nmg04,nmg05,0,0,0,0,0,0,0,0,'' ",
                   " from nmg_file ",
                   " where nmg01 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmg18 = ? AND nmg19 = ? ",
                   "   AND nmg22=? ",
                   "   AND MONTH(nmg01) = ? ",
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmg00 ) "
     ELSE
        LET l_sql1=" SELECT DISTINCT nmh11,nmh30,nmh03,0,nmh04,'',2,nmh01, ",
                   " 0,0,0,0,0,0,(SELECT oma54t FROM oma_file WHERE oma01=nmh01 ),(SELECT oma56t FROM oma_file WHERE oma01=nmh01),0,0,0,0,0,0,0,0,'' ",
                   " from nmh_file ",
                   " where nmh04 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmh11 = ? AND nmh30 = ? ",
                   "   AND MONTH(nmh04) = ? ",
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmh01 ) ",
                   " UNION ",
                   " SELECT DISTINCT nmg18,nmg19,nmg22,0,nmg01,'',2,nmg00, ",
                   " 0,0,0,0,0,0,(SELECT oma54t FROM oma_file WHERE oma01=nmg00 ),(SELECT oma56t FROM oma_file WHERE oma01=nmg00),0,0,0,0,0,0,0,0,'' ",
                   " from nmg_file ",
                   " where nmg01 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmg18 = ? AND nmg19 = ? ",
                   "   AND MONTH(nmg01) = ? ",
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmg00 ) "
     END IF       
     PREPARE cxmq111_prepare6 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare6:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time 
        EXIT PROGRAM
     END IF
     DECLARE cxmq111_cursb6 CURSOR FOR cxmq111_prepare6  
     
     CALL cl_outnam('cxmq111')  RETURNING l_name
     IF tm.c = 'Y' THEN                          
 
        START REPORT cxmq111_rep1 TO l_name      
     ELSE 
     
        START REPORT cxmq111_rep TO l_name
     END IF 
     
     LET g_pageno = 0

     FOREACH cxmq111_curs1 INTO sr1.*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,0) EXIT FOREACH
        END IF                                                                    
                 
        FOR l_i = mm1 TO nn1
            LET g_print = 0
            IF tm.c = 'Y' THEN  
               #订单                                                     
               FOREACH cxmq111_cursb0 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                     INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach0:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               
                 
                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep1(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH 
               #回款作业                                                      
               FOREACH cxmq111_cursb1 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                     INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               
                 
                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep1(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH                               
                #开票作业
               FOREACH cxmq111_cursb2 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i 
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep1(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH    
               #出货作业                                    
               FOREACH cxmq111_cursb3 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i,sr1.oea03,sr1.oea032,sr1.oea23,l_i 
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep1(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH                                              
            ELSE
               #订单                                                     
               FOREACH cxmq111_cursb0 USING sr1.oea03,sr1.oea032,l_i
                                     INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach0:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               
                 
                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH 
               #回款作业           	
               FOREACH cxmq111_cursb1 USING sr1.oea03,sr1.oea032,l_i      
                                     INTO sr.*                                          
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF

                  LET sr.mm   = l_i                                                 

                  OUTPUT TO REPORT cxmq111_rep(sr.*)                                 
                  LET g_print = g_print + 1
               END FOREACH
                #开票作业
               FOREACH cxmq111_cursb2 USING sr1.oea03,sr1.oea032,l_i 
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH       
               #出货作业                                    
               FOREACH cxmq111_cursb3 USING sr1.oea03,sr1.oea032,l_i,sr1.oea03,sr1.oea032,l_i 
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq111_rep(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH                                   
            END IF                                                                    

        END FOR
     END FOREACH
 
     IF tm.c = 'Y' THEN                          
        FINISH REPORT cxmq111_rep1               
     ELSE                                        
        FINISH REPORT cxmq111_rep
     END IF                                      
     LET g_prog = 'cxmq111'

END FUNCTION

REPORT cxmq111_rep(sr)
   DEFINE l_last_sw LIKE type_file.chr1,          
          sr        RECORD
                      oea03      LIKE oea_file.oea03,
                      oea032      LIKE oea_file.oea032,
                      oea23      LIKE oea_file.oea23,
                      mm         LIKE type_file.num5,
                      vdate      LIKE npp_file.npp02,   #日期
                      oea01      LIKE oea_file.oea01,   #订单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      a          LIKE npq_file.npq07,   #本币订单金额
                      af          LIKE npq_file.npq07,   #原币订单金额
                      b          LIKE npq_file.npq07,   #出货金额
                      bf          LIKE npq_file.npq07,   #出货金额
                      c          LIKE npq_file.npq07,   #开票金额
                      cf          LIKE npq_file.npq07,   #开票金额
                      d          LIKE npq_file.npq07,   #回款金额
                      df          LIKE npq_file.npq07,   #回款金额
                      h          LIKE npq_file.npq07,   #订单应收余额            
                      hf          LIKE npq_file.npq07,   #订单应收余额            
                      i          LIKE npq_file.npq07,   #出货未开票金额
                      iff          LIKE npq_file.npq07,   #出货未开票金额
                      j          LIKE npq_file.npq07,   #下单未发货金额     
                      jf          LIKE npq_file.npq07,   #下单未发货金额     
                      k          LIKE npq_file.npq07,   #开票应收余额
                      kf          LIKE npq_file.npq07,   #开票应收余额      
                      exp        LIKE npq_file.npq07
                    END RECORD ,
          l_date                       LIKE type_file.dat,     
          l_date1                      LIKE type_file.dat,     
          l_date2                      LIKE type_file.dat,     
          l_dc                         LIKE type_file.chr10,
          l_year                       LIKE type_file.num10,
          l_month                      LIKE type_file.num10
DEFINE l_tc_khy05,l_tc_khy06,l_tc_khy07,l_tc_khy08,l_tc_khy09,l_tc_khy10,l_tc_khy11,l_tc_khy12 LIKE  npq_file.npq07   
DEFINE l_h,l_ii,l_j,l_k      LIKE type_file.num20_6   #用于本期累计
DEFINE lf_h,lf_ii,lf_j,lf_k  LIKE type_file.num20_6   #用于本期累计
DEFINE l_h2,l_ii2,l_j2,l_k2  LIKE type_file.num20_6   #用于按月累计
DEFINE lf_h2,lf_ii2,lf_j2,lf_k2 LIKE type_file.num20_6   #用于按月累计
DEFINE l_a,l_b,l_c,l_d LIKE type_file.num20_6
DEFINE lf_a,lf_b,lf_c,lf_d LIKE type_file.num20_6

  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER BY sr.oea03,sr.oea032,sr.mm,sr.oea01,sr.vdate
  FORMAT
   PAGE HEADER
      LET g_pageno = g_pageno + 1

   BEFORE GROUP OF sr.oea03 
    
   BEFORE GROUP OF sr.oea032
      LET g_seq = 1
      IF sr.mm = MONTH(tm.bdate) THEN
         LET l_date2 = tm.bdate
      ELSE
         LET l_date2 = MDY(sr.mm,1,yy)
      END IF

      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07 FROM azi_file     
       WHERE azi01 = sr.oea23
      
      #抓期初数据  
        IF tm.c = 'Y' THEN    
                                                             
             EXECUTE cxmq111_curd USING sr.oea03,sr.oea23  
               INTO l_tc_khy09,l_tc_khy11,l_tc_khy10,l_tc_khy12,              
                   #期初开票原币 回款原币 开票本币  回款本币    
                   l_tc_khy05,l_tc_khy07,l_tc_khy06,l_tc_khy08  
                   #期初订单原币 出货原币 订单本币  出货本币    
        ELSE
             EXECUTE cxmq111_curd USING sr.oea03  
               INTO l_tc_khy09,l_tc_khy11,l_tc_khy10,l_tc_khy12,
                    l_tc_khy05,l_tc_khy07,l_tc_khy06,l_tc_khy08 
                        
        END IF                 
        IF cl_null(l_tc_khy05) THEN LET l_tc_khy05 = 0 END IF   
        IF cl_null(l_tc_khy06) THEN LET l_tc_khy06 = 0 END IF   
        IF cl_null(l_tc_khy07) THEN LET l_tc_khy07 = 0 END IF   
        IF cl_null(l_tc_khy08) THEN LET l_tc_khy08 = 0 END IF   
        IF cl_null(l_tc_khy09) THEN LET l_tc_khy09 = 0 END IF     
        IF cl_null(l_tc_khy10) THEN LET l_tc_khy10 = 0 END IF          
        IF cl_null(l_tc_khy11) THEN LET l_tc_khy11 = 0 END IF        
        IF cl_null(l_tc_khy12) THEN LET l_tc_khy12 = 0 END IF                   
                  
      #期初金额
         LET l_h2 = l_tc_khy06-l_tc_khy12  #订单-回款 #订单应收余额 A-D
         LET lf_h2 = l_tc_khy05-l_tc_khy11
          
         LET l_ii2 = l_tc_khy08-l_tc_khy10  #出货-开票 #出货未开票金额 B-C
         LET lf_ii2 = l_tc_khy07-l_tc_khy09 
         
         LET l_j2 = l_tc_khy06-l_tc_khy08  # 订单-出货 #下单未发货金额 A-B
         LET lf_j2 = l_tc_khy05-l_tc_khy07  
         
         LET l_k2 = l_tc_khy10-l_tc_khy12  #开票-回款  #开票应收余额 C-D
         LET lf_k2 = l_tc_khy09-l_tc_khy11 

         IF cl_null(l_h2) THEN LET l_h2 = 0 END IF 
         IF cl_null(lf_h2) THEN LET lf_h2 = 0 END IF 
         IF cl_null(l_k2) THEN LET l_k2 = 0 END IF 
         IF cl_null(lf_k2) THEN LET lf_k2 = 0 END IF 

         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','0','',
                l_tc_khy06,l_tc_khy05,l_tc_khy08,l_tc_khy07,l_tc_khy10,l_tc_khy09,l_tc_khy12,l_tc_khy11,
                l_h2,lf_h2,l_ii2,lf_ii2,l_j2,lf_j2,l_k2,lf_k2,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
         LET g_seq=g_seq+1
   
   BEFORE GROUP OF sr.oea01 
      #本期小计前清值
      LET  l_h = 0  
      LET  l_ii = 0  
      LET  l_j = 0  
      LET  l_k = 0 
      LET  lf_h = 0  
      LET  lf_ii = 0  
      LET  lf_j = 0  
      LET  lf_k = 0       
      
      LET lf_a = 0 
      LET l_a = 0  
      LET lf_b = 0 
      LET l_b = 0  
      LET lf_c = 0 
      LET l_c = 0  
      LET lf_d = 0 
      LET l_d = 0  
   
   BEFORE GROUP OF sr.type  #订单最靠前 170713 shijl    
   
   ON EVERY ROW
     
      IF cl_null(sr.af) THEN LET sr.af = 0 END IF 
      IF cl_null(sr.a) THEN LET sr.a = 0 END IF  
      IF cl_null(sr.bf) THEN LET sr.bf = 0 END IF  
      IF cl_null(sr.b) THEN LET sr.b = 0 END IF
      IF cl_null(sr.cf) THEN LET sr.cf = 0 END IF 
      IF cl_null(sr.c) THEN LET sr.c = 0 END IF  
      IF cl_null(sr.df) THEN LET sr.df = 0 END IF  
      IF cl_null(sr.d) THEN LET sr.d = 0 END IF
           
      LET l_h  = sr.a-sr.d
      LET lf_h = sr.af-sr.df
      LET l_ii  = sr.b-sr.c
      LET lf_ii = sr.bf-sr.cf
      LET l_j  = sr.a-sr.b
      LET lf_j = sr.af-sr.bf
      LET l_k  = sr.c-sr.d
      LET lf_k = sr.cf-sr.df
              
         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,sr.oea01,sr.type,sr.tc_nmg01,
                sr.a,sr.af,sr.b,sr.bf,sr.c,sr.cf,sr.d,sr.df,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
                
      LET g_seq=g_seq+1 
      
   AFTER GROUP OF sr.oea01 
       #订单小计
      LET l_a = GROUP SUM(sr.a)   
      LET lf_a= GROUP SUM(sr.af)  
      LET l_b = GROUP SUM(sr.b)   
      LET lf_b= GROUP SUM(sr.bf)
      LET l_c = GROUP SUM(sr.c)   
      LET lf_c= GROUP SUM(sr.cf)       
      LET l_d = GROUP SUM(sr.d)   
      LET lf_d= GROUP SUM(sr.df)  
#add by shijl 170629--str--
      LET l_h  = l_a-l_d
      LET lf_h = lf_a-lf_d
      LET l_ii  = l_b-l_c
      LET lf_ii = lf_b-lf_c
      LET l_j  = l_a-l_b
      LET lf_j = lf_a-lf_b
      LET l_k  = l_c-l_d
      LET lf_k = lf_c-lf_d 
#add by shijl 170629--end--                   
      #用于累计
      LET l_h2 = l_h2 + l_h
      LET l_ii2 = l_ii2 + l_ii  
      LET l_j2 = l_j2 + l_j 
      LET l_k2 = l_k2 + l_k       
      LET lf_h2 = lf_h2 + lf_h
      LET lf_ii2 = lf_ii2 + lf_ii  
      LET lf_j2 = lf_j2 + lf_j 
      LET lf_k2 = lf_k2 + lf_k  
        
         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','5','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
      LET g_seq=g_seq+1
                 
   AFTER GROUP OF sr.mm
   
      #MISC
#        FOREACH cxmq110_cursb6 USING sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*
#           IF SQLCA.sqlcode THEN
#              CALL cl_err('foreach6:',SQLCA.sqlcode,0) EXIT FOREACH
#           END IF            
#           INSERT INTO cxmq110_tmp
#             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
#             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
#             '','',sr2.yb,sr2.bb,
#             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
#           LET g_seq=g_seq+1 
#           LET g_print = g_print + 1  
#           
#           LET l_yb9=l_yb9+sr2.yb  
#           LET l_bb9=l_bb9+sr2.bb                                                              
#        END FOREACH          
   
      #本期合计
   
      #type = '5' 本期合計打印
      LET l_a = GROUP SUM(sr.a)   
      LET lf_a= GROUP SUM(sr.af)  
      LET l_b = GROUP SUM(sr.b)   
      LET lf_b= GROUP SUM(sr.bf)
      LET l_c = GROUP SUM(sr.c)   
      LET lf_c= GROUP SUM(sr.cf)       
      LET l_d = GROUP SUM(sr.d)   
      LET lf_d= GROUP SUM(sr.df) 

      LET l_h  = sr.a-sr.d
      LET lf_h = sr.af-sr.df
      LET l_ii  = sr.b-sr.c
      LET lf_ii = sr.bf-sr.cf
      LET l_j  = sr.a-sr.b
      LET lf_j = sr.af-sr.bf
      LET l_k  = sr.c-sr.d
      LET lf_k = sr.cf-sr.df
            
      INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','9','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07)    
      LET g_seq=g_seq+1

      #累计额
      LET l_a   = l_a + l_tc_khy06                                                
      LET lf_a  = lf_a+ l_tc_khy05                                                    
      LET l_b   = l_b + l_tc_khy08
      LET lf_b  = lf_b+ l_tc_khy07 
      LET l_c   = l_c + l_tc_khy10
      LET lf_c  = lf_c+ l_tc_khy09
      LET l_d   = l_d + l_tc_khy12
      LET lf_d  = lf_d+ l_tc_khy11
                  
      
      INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','10','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h2,lf_h2,l_ii2,lf_ii2,l_j2,lf_j2,l_k2,lf_k2,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
      LET g_seq=g_seq+1 
       

      
END REPORT

REPORT cxmq111_rep1(sr)
   DEFINE l_last_sw LIKE type_file.chr1,          
          sr        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    oea01      LIKE oea_file.oea01,   #订单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    a          LIKE npq_file.npq07,   #本币订单金额
                    af          LIKE npq_file.npq07,   #原币订单金额
                    b          LIKE npq_file.npq07,   #出货金额
                    bf          LIKE npq_file.npq07,   #出货金额
                    c          LIKE npq_file.npq07,   #开票金额
                    cf          LIKE npq_file.npq07,   #开票金额
                    d          LIKE npq_file.npq07,   #回款金额
                    df          LIKE npq_file.npq07,   #回款金额
                    h          LIKE npq_file.npq07,   #订单应收余额            
                    hf          LIKE npq_file.npq07,   #订单应收余额            
                    i          LIKE npq_file.npq07,   #出货未开票金额
                    iff          LIKE npq_file.npq07,   #出货未开票金额
                    j          LIKE npq_file.npq07,   #下单未发货金额     
                    jf          LIKE npq_file.npq07,   #下单未发货金额     
                    k          LIKE npq_file.npq07,   #开票应收余额
                    kf          LIKE npq_file.npq07,   #开票应收余额                                
                    exp        LIKE npq_file.npq07    #说明 
                    END RECORD ,                     
          l_date                       LIKE type_file.dat,     
          l_date1                      LIKE type_file.dat,     
          l_date2                      LIKE type_file.dat,     
          l_dc                         LIKE type_file.chr10,
          l_year                       LIKE type_file.num10,
          l_month                      LIKE type_file.num10
DEFINE l_tc_khy05,l_tc_khy06,l_tc_khy07,l_tc_khy08,l_tc_khy09,l_tc_khy10,l_tc_khy11,l_tc_khy12 LIKE  npq_file.npq07   
DEFINE l_h,l_ii,l_j,l_k      LIKE type_file.num20_6   #用于本期累计
DEFINE lf_h,lf_ii,lf_j,lf_k  LIKE type_file.num20_6   #用于本期累计
DEFINE l_h2,l_ii2,l_j2,l_k2  LIKE type_file.num20_6   #用于按月累计
DEFINE lf_h2,lf_ii2,lf_j2,lf_k2 LIKE type_file.num20_6   #用于按月累计
DEFINE l_a,l_b,l_c,l_d LIKE type_file.num20_6
DEFINE lf_a,lf_b,lf_c,lf_d LIKE type_file.num20_6

  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER BY sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.oea01,sr.vdate
  FORMAT
   PAGE HEADER
      LET g_pageno = g_pageno + 1

   BEFORE GROUP OF sr.oea03 
    
   BEFORE GROUP OF sr.oea032
      LET g_seq = 1
      IF sr.mm = MONTH(tm.bdate) THEN
         LET l_date2 = tm.bdate
      ELSE
         LET l_date2 = MDY(sr.mm,1,yy)
      END IF

      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07 FROM azi_file     
       WHERE azi01 = sr.oea23
      
      #抓期初数据  
        IF tm.c = 'Y' THEN    
                                                             
             EXECUTE cxmq111_curd USING sr.oea03,sr.oea23  
               INTO l_tc_khy09,l_tc_khy11,l_tc_khy10,l_tc_khy12,              
                   #期初开票原币 回款原币 开票本币  回款本币    
                   l_tc_khy05,l_tc_khy07,l_tc_khy06,l_tc_khy08  
                   #期初订单原币 出货原币 订单本币  出货本币    
        ELSE
             EXECUTE cxmq111_curd USING sr.oea03  
               INTO l_tc_khy09,l_tc_khy11,l_tc_khy10,l_tc_khy12,
                    l_tc_khy05,l_tc_khy07,l_tc_khy06,l_tc_khy08 
                        
        END IF                 
        IF cl_null(l_tc_khy05) THEN LET l_tc_khy05 = 0 END IF   
        IF cl_null(l_tc_khy06) THEN LET l_tc_khy06 = 0 END IF   
        IF cl_null(l_tc_khy07) THEN LET l_tc_khy07 = 0 END IF   
        IF cl_null(l_tc_khy08) THEN LET l_tc_khy08 = 0 END IF   
        IF cl_null(l_tc_khy09) THEN LET l_tc_khy09 = 0 END IF     
        IF cl_null(l_tc_khy10) THEN LET l_tc_khy10 = 0 END IF          
        IF cl_null(l_tc_khy11) THEN LET l_tc_khy11 = 0 END IF        
        IF cl_null(l_tc_khy12) THEN LET l_tc_khy12 = 0 END IF                   
                  
      #期初金额
         LET l_h2 = l_tc_khy06-l_tc_khy12  #订单-回款 #订单应收余额 A-D
         LET lf_h2 = l_tc_khy05-l_tc_khy11
          
         LET l_ii2 = l_tc_khy08-l_tc_khy10  #出货-开票 #出货未开票金额 B-C
         LET lf_ii2 = l_tc_khy07-l_tc_khy09 
         
         LET l_j2 = l_tc_khy06-l_tc_khy08  # 订单-出货 #下单未发货金额 A-B
         LET lf_j2 = l_tc_khy05-l_tc_khy07  
         
         LET l_k2 = l_tc_khy10-l_tc_khy12  #开票-回款  #开票应收余额 C-D
         LET lf_k2 = l_tc_khy09-l_tc_khy11 

         IF cl_null(l_h2) THEN LET l_h2 = 0 END IF 
         IF cl_null(lf_h2) THEN LET lf_h2 = 0 END IF 
         IF cl_null(l_k2) THEN LET l_k2 = 0 END IF 
         IF cl_null(lf_k2) THEN LET lf_k2 = 0 END IF 
         
         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','0','',
                l_tc_khy06,l_tc_khy05,l_tc_khy08,l_tc_khy07,l_tc_khy10,l_tc_khy09,l_tc_khy12,l_tc_khy11,
                l_h2,lf_h2,l_ii2,lf_ii2,l_j2,lf_j2,l_k2,lf_k2,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
         LET g_seq=g_seq+1 
         
   BEFORE GROUP OF sr.oea23 
      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07 FROM azi_file     
       WHERE azi01 = sr.oea23   
       
   BEFORE GROUP OF sr.oea01 
      #本期小计前清值
      LET  l_h = 0  
      LET  l_ii = 0  
      LET  l_j = 0  
      LET  l_k = 0 
      LET  lf_h = 0  
      LET  lf_ii = 0  
      LET  lf_j = 0  
      LET  lf_k = 0       
      
      LET lf_a = 0 
      LET l_a = 0  
      LET lf_b = 0 
      LET l_b = 0  
      LET lf_c = 0 
      LET l_c = 0  
      LET lf_d = 0 
      LET l_d = 0  
      
   BEFORE GROUP OF sr.type  #订单最靠前 170713 shijl
       
   ON EVERY ROW
    
     
      IF cl_null(sr.af) THEN LET sr.af = 0 END IF 
      IF cl_null(sr.a) THEN LET sr.a = 0 END IF  
      IF cl_null(sr.bf) THEN LET sr.bf = 0 END IF  
      IF cl_null(sr.b) THEN LET sr.b = 0 END IF
      IF cl_null(sr.cf) THEN LET sr.cf = 0 END IF 
      IF cl_null(sr.c) THEN LET sr.c = 0 END IF  
      IF cl_null(sr.df) THEN LET sr.df = 0 END IF  
      IF cl_null(sr.d) THEN LET sr.d = 0 END IF
           
      LET l_h  = sr.a-sr.d
      LET lf_h = sr.af-sr.df
      LET l_ii  = sr.b-sr.c
      LET lf_ii = sr.bf-sr.cf
      LET l_j  = sr.a-sr.b
      LET lf_j = sr.af-sr.bf
      LET l_k  = sr.c-sr.d
      LET lf_k = sr.cf-sr.df
              
         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,sr.oea01,sr.type,sr.tc_nmg01,
                sr.a,sr.af,sr.b,sr.bf,sr.c,sr.cf,sr.d,sr.df,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
                
      LET g_seq=g_seq+1 
      
   AFTER GROUP OF sr.oea01 
       #订单小计
      LET l_a = GROUP SUM(sr.a)   
      LET lf_a= GROUP SUM(sr.af)  
      LET l_b = GROUP SUM(sr.b)   
      LET lf_b= GROUP SUM(sr.bf)
      LET l_c = GROUP SUM(sr.c)   
      LET lf_c= GROUP SUM(sr.cf)       
      LET l_d = GROUP SUM(sr.d)   
      LET lf_d= GROUP SUM(sr.df)  
#add by shijl 170629--str--
      LET l_h  = l_a-l_d
      LET lf_h = lf_a-lf_d
      LET l_ii  = l_b-l_c
      LET lf_ii = lf_b-lf_c
      LET l_j  = l_a-l_b
      LET lf_j = lf_a-lf_b
      LET l_k  = l_c-l_d
      LET lf_k = lf_c-lf_d 
#add by shijl 170629--end--      
      #用于累计
      LET l_h2 = l_h2 + l_h
      LET l_ii2 = l_ii2 + l_ii  
      LET l_j2 = l_j2 + l_j 
      LET l_k2 = l_k2 + l_k       
      LET lf_h2 = lf_h2 + lf_h
      LET lf_ii2 = lf_ii2 + lf_ii  
      LET lf_j2 = lf_j2 + lf_j 
      LET lf_k2 = lf_k2 + lf_k  
        
         INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','5','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
      LET g_seq=g_seq+1
                 
   AFTER GROUP OF sr.mm
      #本期合计
   
      #type = '5' 本期合計打印
      LET l_a = GROUP SUM(sr.a)   
      LET lf_a= GROUP SUM(sr.af)  
      LET l_b = GROUP SUM(sr.b)   
      LET lf_b= GROUP SUM(sr.bf)
      LET l_c = GROUP SUM(sr.c)   
      LET lf_c= GROUP SUM(sr.cf)       
      LET l_d = GROUP SUM(sr.d)   
      LET lf_d= GROUP SUM(sr.df) 

      LET l_h  = sr.a-sr.d
      LET lf_h = sr.af-sr.df
      LET l_ii  = sr.b-sr.c
      LET lf_ii = sr.bf-sr.cf
      LET l_j  = sr.a-sr.b
      LET lf_j = sr.af-sr.bf
      LET l_k  = sr.c-sr.d
      LET lf_k = sr.cf-sr.df
            
      INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','9','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h,lf_h,l_ii,lf_ii,l_j,lf_j,l_k,lf_k,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07)    
      LET g_seq=g_seq+1

      #累计额
      LET l_a   = l_a + l_tc_khy06                                                
      LET lf_a  = lf_a+ l_tc_khy05                                                    
      LET l_b   = l_b + l_tc_khy08
      LET lf_b  = lf_b+ l_tc_khy07 
      LET l_c   = l_c + l_tc_khy10
      LET lf_c  = lf_c+ l_tc_khy09
      LET l_d   = l_d + l_tc_khy12
      LET lf_d  = lf_d+ l_tc_khy11

      
      INSERT INTO cxmq111_tmp
         VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','','10','',
                l_a,lf_a,l_b,lf_b,l_c,lf_c,l_d,lf_d,
                l_h2,lf_h2,l_ii2,lf_ii2,l_j2,lf_j2,l_k2,lf_k2,
                '',g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 

      LET g_seq=g_seq+1   
       
      #MISC

      
END REPORT

FUNCTION q111_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_oea TO s_oea.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
#No.FUN-A40009 --begin
         IF g_rec_b != 0 AND l_ac != 0 THEN  
            CALL fgl_set_arr_curr(l_ac)     
         END IF                            
#No.FUN-A40009 --end

      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                   

      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY

      ON ACTION first
         CALL cxmq111_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  
 
      ON ACTION previous
         CALL cxmq111_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  

      ON ACTION jump
         CALL cxmq111_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  
 
      ON ACTION next
         CALL cxmq111_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  

      ON ACTION last
         CALL cxmq111_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         
         CALL cl_about()      
 
      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document 
         LET g_action_choice="related_document"          
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      ON ACTION controls                    
         CALL cl_set_head_visible("","AUTO")

   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION



FUNCTION cxmq111_cs()
   
   #No.FUN-A30009  --Begin
   IF tm.c = 'Y' THEN     
     LET g_sql = "SELECT UNIQUE oea03,oea032,oea23 FROM cxmq111_tmp ",
                 " ORDER BY oea03,oea032,oea23 "
   ELSE
   
     LET g_sql = "SELECT UNIQUE oea03,oea032 FROM cxmq111_tmp ",
                 " ORDER BY oea03,oea032"   
   END IF	                                               
   
     PREPARE cxmq111_ps FROM g_sql
     DECLARE cxmq111_curs SCROLL CURSOR WITH HOLD FOR cxmq111_ps
     
   
   IF tm.c = 'Y' THEN     
     LET g_sql = "SELECT UNIQUE oea03,oea032,oea23 FROM cxmq111_tmp ",
                 "  INTO TEMP x "
   ELSE
   
     LET g_sql = "SELECT UNIQUE oea03,oea032 FROM cxmq111_tmp ",
                 "  INTO TEMP x " 
   END IF	                                               
   #No.FUN-A30009  --End  

     DROP TABLE x
     PREPARE cxmq111_ps1 FROM g_sql
     EXECUTE cxmq111_ps1

     LET g_sql = "SELECT COUNT(*) FROM x"
     PREPARE cxmq111_ps2 FROM g_sql
     DECLARE cxmq111_cnt CURSOR FOR cxmq111_ps2

     OPEN cxmq111_curs
     IF SQLCA.sqlcode THEN
        CALL cl_err('OPEN cxmq111_curs',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     ELSE
        OPEN cxmq111_cnt 
        FETCH cxmq111_cnt INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL cxmq111_fetch('F')
     END IF
END FUNCTION

FUNCTION cxmq111_fetch(p_flag)
DEFINE
   p_flag          LIKE type_file.chr1,                 #處理方式        
   l_abso          LIKE type_file.num10                 #絕對的筆數      

   
   IF tm.c = 'Y' THEN
   CASE p_flag
      WHEN 'N' FETCH NEXT     cxmq111_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'P' FETCH PREVIOUS cxmq111_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'F' FETCH FIRST    cxmq111_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'L' FETCH LAST     cxmq111_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN '/'
         IF (NOT mi_no_ask) THEN
             CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
             LET INT_FLAG = 0
             PROMPT g_msg CLIPPED,': ' FOR g_jump #CKP3
                ON IDLE g_idle_seconds
                   CALL cl_on_idle()
 
                ON ACTION about         
                   CALL cl_about()      
 
                ON ACTION help          
                   CALL cl_show_help()  
 
                ON ACTION controlg      
                   CALL cl_cmdask()     
 
             END PROMPT
             IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
             END IF
         #CKP3
         END IF
         FETCH ABSOLUTE g_jump cxmq111_curs INTO g_oea03,g_oea032,g_oea23   #No.FUN-A30009
         LET mi_no_ask = FALSE
   END CASE
   ELSE
   
   CASE p_flag
      WHEN 'N' FETCH NEXT     cxmq111_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'P' FETCH PREVIOUS cxmq111_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'F' FETCH FIRST    cxmq111_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'L' FETCH LAST     cxmq111_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN '/'
         IF (NOT mi_no_ask) THEN
             CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
             LET INT_FLAG = 0
             PROMPT g_msg CLIPPED,': ' FOR g_jump #CKP3
                ON IDLE g_idle_seconds
                   CALL cl_on_idle()
 
                ON ACTION about         
                   CALL cl_about()      
 
                ON ACTION help          
                   CALL cl_show_help()  
 
                ON ACTION controlg      
                   CALL cl_cmdask()     
 
             END PROMPT
             IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
             END IF
         #CKP3
         END IF
         FETCH ABSOLUTE g_jump cxmq111_curs INTO g_oea03,g_oea032   #No.FUN-A30009
         LET mi_no_ask = FALSE
   END CASE   
   END IF	                                               
      
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oea03,SQLCA.sqlcode,0)
      INITIALIZE g_oea03 TO NULL
      INITIALIZE g_oea032 TO NULL
      INITIALIZE g_oea23 TO NULL                  
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump #CKP3
      END CASE
 
      CALL cl_navigator_setting( g_curs_index, g_row_count )
   END IF

   CALL cxmq111_show()
END FUNCTION

FUNCTION cxmq111_show()
 
   DISPLAY g_oea03  TO oea03
   DISPLAY g_oea032 TO oea032
   DISPLAY g_oea23  TO oea23                           
   DISPLAY yy   TO yy
#  DISPLAY g_mm TO mm  #No.FUN-A30009

   CALL cxmq111_b_fill()

   CALL cl_show_fld_cont() 
END FUNCTION
 
FUNCTION cxmq111_b_fill()                     #BODY FILL UP
  DEFINE  l_npq06    LIKE npq_file.npq06
  DEFINE  l_type     LIKE type_file.chr1
                    
   IF tm.c = 'Y' THEN
      LET g_sql = "SELECT vdate,oea01,type,tc_nmg01,a,af,b,bf,c,cf,d,df,h,hf,i,iff,j,jf,k,kf,exp,azi04,azi05,azi07 ",
                  " FROM cxmq111_tmp ",
                  " WHERE oea03 ='",g_oea03,"'",
                  "   AND oea032 ='",g_oea032,"'",
                  "   AND oea23 ='",g_oea23,"' "," order by seq "
   ELSE 
      LET g_sql = "SELECT vdate,oea01,type,tc_nmg01,a,af,b,bf,c,cf,d,df,h,hf,i,iff,j,jf,k,kf,exp,azi04,azi05,azi07 ",
                  " FROM cxmq111_tmp",
                  " WHERE oea03 ='",g_oea03,"'",
                  "   AND oea032 ='",g_oea032,"' "," order by seq "
   END IF 
   
   PREPARE cxmq111_pb FROM g_sql
   DECLARE npq_curs  CURSOR FOR cxmq111_pb        #CURSOR

   CALL g_oea.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH npq_curs INTO g_oea[g_cnt].*,t_azi04,t_azi05,t_azi07
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_oea[g_cnt].a   = cl_numfor(g_oea[g_cnt].a,20,g_azi04)
      LET g_oea[g_cnt].af   = cl_numfor(g_oea[g_cnt].af,20,g_azi04)
      LET g_oea[g_cnt].b  = cl_numfor(g_oea[g_cnt].b,20,t_azi04)
      LET g_oea[g_cnt].bf  = cl_numfor(g_oea[g_cnt].bf,20,t_azi04)
      LET g_oea[g_cnt].c  = cl_numfor(g_oea[g_cnt].c,20,t_azi04)
      LET g_oea[g_cnt].cf = cl_numfor(g_oea[g_cnt].cf,20,t_azi04)      
      LET g_oea[g_cnt].d   = cl_numfor(g_oea[g_cnt].d,20,g_azi04)
      LET g_oea[g_cnt].df   = cl_numfor(g_oea[g_cnt].df,20,g_azi04)
      LET g_oea[g_cnt].h  = cl_numfor(g_oea[g_cnt].h,20,t_azi04)
      LET g_oea[g_cnt].hf  = cl_numfor(g_oea[g_cnt].hf,20,t_azi04)      
      LET g_oea[g_cnt].i  = cl_numfor(g_oea[g_cnt].i,20,t_azi04)
      LET g_oea[g_cnt].iff  = cl_numfor(g_oea[g_cnt].iff,20,t_azi04)
      LET g_oea[g_cnt].j= cl_numfor(g_oea[g_cnt].j,20,t_azi04)
      LET g_oea[g_cnt].jf= cl_numfor(g_oea[g_cnt].jf,20,t_azi04)
      LET g_oea[g_cnt].k  = cl_numfor(g_oea[g_cnt].k,20,t_azi04)
      LET g_oea[g_cnt].kf  = cl_numfor(g_oea[g_cnt].kf,20,t_azi04)
       
      #外幣時,外幣匯總沒有意義
      
      IF g_oea[g_cnt].type = '1' THEN  #订单                                                   
         LET g_oea[g_cnt].b         = NULL                                      
         LET g_oea[g_cnt].bf        = NULL                                      
         LET g_oea[g_cnt].c         = NULL                                      
         LET g_oea[g_cnt].cf        = NULL    
         LET g_oea[g_cnt].d         = NULL                                      
         LET g_oea[g_cnt].df        = NULL                                                                  
      END IF  
      IF g_oea[g_cnt].type = '2'  THEN  #回款     
         LET g_oea[g_cnt].a         = NULL                                      
         LET g_oea[g_cnt].af        = NULL                                                 
         LET g_oea[g_cnt].b         = NULL                                      
         LET g_oea[g_cnt].bf        = NULL                                      
         LET g_oea[g_cnt].c         = NULL                                      
         LET g_oea[g_cnt].cf        = NULL                                                                  
      END IF      
      IF g_oea[g_cnt].type = '3' THEN  #发货  
         LET g_oea[g_cnt].a         = NULL                                      
         LET g_oea[g_cnt].af        = NULL                                                                                            
         LET g_oea[g_cnt].c         = NULL                                      
         LET g_oea[g_cnt].cf        = NULL    
         LET g_oea[g_cnt].d         = NULL                                      
         LET g_oea[g_cnt].df        = NULL                                                                      
      END IF                           
      IF g_oea[g_cnt].type = '4' THEN  #开票    
         LET g_oea[g_cnt].a         = NULL                                      
         LET g_oea[g_cnt].af        = NULL                                                    
         LET g_oea[g_cnt].b         = NULL                                      
         LET g_oea[g_cnt].bf        = NULL                                      
         LET g_oea[g_cnt].d         = NULL                                      
         LET g_oea[g_cnt].df        = NULL                                                                      
      END IF   

            
      LET g_cnt = g_cnt + 1

   END FOREACH

   CALL g_oea.deleteElement(g_cnt)
   LET g_rec_b = g_cnt - 1

END FUNCTION

FUNCTION cxmq111_table()
     DROP TABLE cxmq111_tmp;
     CREATE TEMP TABLE cxmq111_tmp(
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    oea01      LIKE oea_file.oea01,   #订单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    a          LIKE npq_file.npq07,   #本币订单金额
                    af          LIKE npq_file.npq07,   #原币订单金额
                    b          LIKE npq_file.npq07,   #出货金额
                    bf          LIKE npq_file.npq07,   #出货金额
                    c          LIKE npq_file.npq07,   #开票金额
                    cf          LIKE npq_file.npq07,   #开票金额
                    d          LIKE npq_file.npq07,   #回款金额
                    df          LIKE npq_file.npq07,   #回款金额
                    h          LIKE npq_file.npq07,   #订单应收余额            
                    hf          LIKE npq_file.npq07,   #订单应收余额            
                    i          LIKE npq_file.npq07,   #出货未开票金额
                    iff          LIKE npq_file.npq07,   #出货未开票金额
                    j          LIKE npq_file.npq07,   #下单未发货金额     
                    jf          LIKE npq_file.npq07,   #下单未发货金额     
                    k          LIKE npq_file.npq07,   #开票应收余额
                    kf          LIKE npq_file.npq07,   #开票应收余额                     
                    exp        LIKE type_file.chr300,   #说明
                    pagenum     LIKE type_file.num5,
                    seq     LIKE type_file.num5,
                    azi04       LIKE azi_file.azi04,
                    azi05       LIKE azi_file.azi04,
                    azi07       LIKE azi_file.azi07);
END FUNCTION

FUNCTION q111_out_1()
#  LET g_prog = 'gapq910'
   LET g_sql = "oea03.oea_file.oea03,",
               "oea032.oea_file.oea032,",
               "oea23.oea_file.oea23,", 
               "mm.type_file.num5,",
               "vdate.npp_file.npp02,",               
               "oea01.oea_file.oea01,", 
               "type.type_file.chr1,",
               "tc_nmg01.tc_nmg_file.tc_nmg01,",  
               "a.npq_file.npq07,",                                                   
               "af.npq_file.npq07,",                                                   
               "b.npq_file.npq07,",                                                   
               "bf.npq_file.npq07,",                                                   
               "c.npq_file.npq07,",                                                   
               "cf.npq_file.npq07,",                                                   
               "d.npq_file.npq07,",                                                   
               "df.npq_file.npq07,",                                                   
               "h.npq_file.npq07,",                                                   
               "hf.npq_file.npq07,",                                                   
               "i.npq_file.npq07,",                                                   
               "iff.npq_file.npq07,",                                                   
               "j.npq_file.npq07,",                                                   
               "jf.npq_file.npq07,",                                                   
               "k.npq_file.npq07,",                                                   
               "kf.npq_file.npq07,",                                                                                                     
               "exp.type_file.chr300,",                         
               "pagenum.type_file.num5,",
               "seq.type_file.num5,",
               "azi04.azi_file.azi04,",
               "azi05.azi_file.azi05,",
               "azi07.azi_file.azi07 "
   LET l_table = cl_prt_temptable('cxmq111',g_sql) CLIPPED
   IF  l_table = -1 THEN 
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
   END IF
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ",
                "       ? ) "
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN 
      CALL cl_err('insert_prep:',status,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF

#   LET g_prog = 'cxmq111'
END FUNCTION
#
FUNCTION q111_out_2()
   DEFINE l_name             LIKE type_file.chr20  
 
   CALL cl_del_data(l_table)                       

   DECLARE cr_curs CURSOR FOR 
    SELECT oea03, oea032, oea23, mm, vdate,
           oea01, type, tc_nmg01,a,af, b,bf,c,cf,d,df,h,hf,i,iff,j,jf,k,kf,exp,
           pagenum,seq, azi04, azi05, azi07
     FROM cxmq111_tmp ORDER BY seq
     
   FOREACH cr_curs INTO g_pr.*
       EXECUTE insert_prep USING g_pr.*
   END FOREACH

   LET g_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED

   IF g_zz05='Y' THEN 
      CALL cl_wcchp(tm.wc,'oea03,oea01')
           RETURNING g_str 
   END IF
   LET g_str=g_str CLIPPED,";",tm.b,";",tm.c
   
   LET g_prog = 'cxmq111'
   
#   IF tm.b = 'N' THEN
       LET l_name = 'cxmq111'
#   ELSE
#       IF tm.c = 'Y' THEN           
#          LET l_name = 'cxmq111_2'  
#       ELSE                               
#          LET l_name = 'cxmq111_1'
#       END IF    
#   END IF
   CALL cl_prt_cs3('cxmq111',l_name,g_sql,g_str)   
   
   LET g_prog = 'cxmq111'
   
END FUNCTION


FUNCTION cxmq111_t()
   IF tm.b = 'Y' THEN
      CALL cl_set_comp_visible("a,af,b,bf,df,d,cf,c,i,iff,j,jf,h,hf,k,kf",TRUE)

      CALL cl_set_comp_att_text("a","本币订单金额")
      CALL cl_set_comp_att_text("af","原币订单金额")
      CALL cl_set_comp_att_text("b","本币出货金额")   
      CALL cl_set_comp_att_text("bf","原币出货金额")   
      CALL cl_set_comp_att_text("c","本币开票金额")   
      CALL cl_set_comp_att_text("cf","原币开票金额")   
      CALL cl_set_comp_att_text("d","本币回款金额")   
      CALL cl_set_comp_att_text("df","原币回款金额")   
      CALL cl_set_comp_att_text("h","订单应收本币余额")   
      CALL cl_set_comp_att_text("hf","订单应收原币余额")   
      CALL cl_set_comp_att_text("i","出货未开票本币金额")   
      CALL cl_set_comp_att_text("iff","出货未开票原币金额")   
      CALL cl_set_comp_att_text("j","下单未发货本币金额")   
      CALL cl_set_comp_att_text("jf","下单未发货原币金额")   
      CALL cl_set_comp_att_text("k","开票应收本币余额")
      CALL cl_set_comp_att_text("kf","开票应收原币余额")   
   ELSE
      CALL cl_set_comp_visible("af,bf,df,cf,iff,jf,hf,kf",FALSE) 
      
      CALL cl_set_comp_att_text("a","订单金额")
      CALL cl_set_comp_att_text("b","出货金额")     
      CALL cl_set_comp_att_text("c","开票金额")      
      CALL cl_set_comp_att_text("d","回款金额")     
      CALL cl_set_comp_att_text("h","订单应收余额")    
      CALL cl_set_comp_att_text("i","出货未开票金额")     
      CALL cl_set_comp_att_text("j","下单未发货金额")     
      CALL cl_set_comp_att_text("k","开票应收余额") 
   END IF
   
   IF tm.c = 'Y' THEN
      CALL cl_set_comp_visible("oea23",TRUE)                                                                                       
   ELSE
      CALL cl_set_comp_visible("oea23",FALSE)
   END IF
   
   LET g_oea03 = NULL
   LET g_oea032 = NULL
   LET g_oea23 = NULL         
   CLEAR FORM
   CALL g_oea.clear()
   CALL cxmq111_cs()
END FUNCTION

FUNCTION q111_set_entry()

   CALL cl_set_comp_entry("c,curr",TRUE)

END FUNCTION

FUNCTION q111_set_no_entry()

   IF tm.b = 'N' THEN
      LET tm.c = 'N'
      LET tm.curr = NULL
      DISPLAY BY NAME tm.c,tm.curr
      CALL cl_set_comp_entry("c,curr",FALSE)
   END IF

END FUNCTION


