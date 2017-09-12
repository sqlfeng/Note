
# Pattern name...: cxmq115.4gl
# Descriptions...: 客戶总账及出货明细帐表
# Date & Author..: 17/02/03  shijl
# Modify by shijl 170713 如果没有回款、开票、出货、销退，也要显示MISC数据;未维护收支单金额抓取修改;效能

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
DEFINE g_oea23        LIKE npq_file.npq24 
DEFINE g_mm           LIKE type_file.num5
DEFINE mm1,nn1        LIKE type_file.num10
DEFINE yy             LIKE type_file.num10
DEFINE g_cnt          LIKE type_file.num10
DEFINE g_seq          LIKE type_file.num10
DEFINE g_oea          DYNAMIC ARRAY OF RECORD
                      vdate      LIKE npp_file.npp02,   #日期
                      nmg00      LIKE nmg_file.nmg00,   #收支单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      nmg30      LIKE nmg_file.nmg00,   #客户编号
                      occ18      LIKE occ_file.occ18,   #客户名称
                      a          LIKE npq_file.npq07,   #收款金额
                      b          LIKE npq_file.npq07,   #回款金额
                      c          LIKE npq_file.npq07    #未维护金额
                      END RECORD
DEFINE g_table_attr DYNAMIC ARRAY OF RECORD  #属性数组，名称与单身数组一致，类型定义为string
                            vdate      LIKE npp_file.npp02,   #日期
                      nmg00      LIKE nmg_file.nmg00,   #收支单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      nmg30      LIKE nmg_file.nmg00,   #客户编号
                      occ18      LIKE occ_file.occ18,   #客户名称
                      a          LIKE npq_file.npq07,   #收款金额
                      b          LIKE npq_file.npq07,   #回款金额
                      c          LIKE npq_file.npq07    #未维护金额
           END RECORD                      
DEFINE g_pr           RECORD
                      oea03      LIKE oea_file.oea03,
                      oea032      LIKE oea_file.oea032,
                      oea23      LIKE oea_file.oea23,
                      mm         LIKE type_file.num5,
                      vdate      LIKE npp_file.npp02,   #日期
                      vno        LIKE npp_file.npp01,   #凭证号
                      oea01      LIKE oea_file.oea01,   #订单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      df         LIKE npq_file.npq07,  #原币借方
                      d          LIKE npq_file.npq07,  #本币借方
                      cf         LIKE npq_file.npq07,  #原币贷方
                      c          LIKE npq_file.npq07,  #本币贷方
                      zzysye     LIKE npq_file.npq07,  #总账应收余额
                      chysye     LIKE npq_file.npq07,  #出货应收余额           
                      exp        LIKE type_file.chr300,  #说明
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

   CALL q115_out_1()
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-B30211

   OPEN WINDOW q115_w AT 5,10
        WITH FORM "cxm/42f/cxmq115_1" ATTRIBUTE(STYLE = g_win_style)

   CALL cl_ui_init()

   IF cl_null(tm.wc) THEN
      CALL cxmq115_tm(0,0)             # Input print condition
   ELSE
      CALL cxmq115() 
      CALL cxmq115_t()
   END IF

   CALL q115_menu()
   DROP TABLE cxmq115_tmp;
   CLOSE WINDOW q115_w
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
END MAIN

FUNCTION q115_menu()
   DEFINE   l_cmd   LIKE type_file.chr1000       
 
   WHILE TRUE
      CALL q115_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL cxmq115_tm(0,0)
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL q115_out_2()
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
         WHEN "related_document"  #相關文件
            IF cl_chk_act_auth() THEN
               IF g_oea03 IS NOT NULL THEN
                  LET g_doc.column1 = "oea03"
                  LET g_doc.value1 = g_oea03
                  CALL cl_doc()
               END IF
            END IF
      END CASE
   END WHILE
END FUNCTION

FUNCTION cxmq115_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01      
DEFINE li_chk_bookno  LIKE type_file.num5      
DEFINE p_row,p_col    LIKE type_file.num5,     
       l_n            LIKE type_file.num5,     
       l_flag         LIKE type_file.num5,     
       l_cmd          LIKE type_file.chr1000   

   LET p_row = 3 LET p_col =20

   OPEN WINDOW cxmq115_w AT p_row,p_col WITH FORM "cxm/42f/cxmq115"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)
 
   CALL cl_ui_locale("cxmq115")

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
       LET tm.wc  =' 1=2'
    ELSE

    IF tm.wc = ' 1=1' THEN
       CALL cl_err('','9046',0) CONTINUE WHILE
    END IF
    INPUT BY NAME tm.bdate,tm.edate,tm.b,tm.curr,tm.c,tm.more  #No.FUN-A30009
                  WITHOUT DEFAULTS
        
        BEFORE INPUT
            CALL cl_qbe_display_condition(lc_qbe_sn)
            #No.FUN-A30009  --Begin WO
            CALL q115_set_entry()
            CALL q115_set_no_entry()
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
          CALL q115_set_entry()

        AFTER FIELD b
          IF cl_null(tm.b) OR tm.b NOT MATCHES'[YN]' THEN NEXT FIELD b END IF
          CALL q115_set_no_entry()

        ON CHANGE b
          IF tm.b = 'Y' THEN
             LET tm.c = 'Y'
             DISPLAY BY NAME tm.c      
          END IF
          CALL q115_set_entry()
          CALL q115_set_no_entry()
                    
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
              WHERE zz01='cxmq115'
       IF SQLCA.sqlcode OR l_cmd IS NULL THEN
          CALL cl_err('cxmq115','9031',1)
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
          CALL cl_cmdat('cxmq115',g_time,l_cmd)    # Execute cmd at later time
       END IF
       CLOSE WINDOW cxmq115_w
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
    END IF
    END IF                        #No.FUN-A40009
    CALL cl_wait()
    CALL cxmq115()
    ERROR ""
    EXIT WHILE   
END WHILE
   CLOSE WINDOW cxmq115_w
#No.FUN-A40009 --begin  
   IF INT_FLAG THEN    
      LET INT_FLAG = 0
      RETURN         
   END IF           
#No.FUN-A40009 --end 
  
   CALL cxmq115_t()
END FUNCTION

FUNCTION cxmq115()
   DEFINE l_name    LIKE type_file.chr20,    
          l_sql     STRING,             
          l_sql1    STRING,             
          l_flag    LIKE type_file.chr1,     
          l_i       LIKE type_file.num5,     
          l_term    STRING,            
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
                      nmg00      LIKE nmg_file.nmg00,   #收支单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      nmg30      LIKE nmg_file.nmg00,   #客户编号
                      occ18      LIKE occ_file.occ18,   #客户名称
                      a          LIKE npq_file.npq07,   #收款金额
                      b          LIKE npq_file.npq07,   #回款金额
                      c          LIKE npq_file.npq07    #未维护金额
                    END RECORD,
          sr2        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                      vdate      LIKE npp_file.npp02,   #日期
                      nmg00      LIKE nmg_file.nmg00,   #收支单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      nmg30      LIKE nmg_file.nmg00,   #客户编号
                      occ18      LIKE occ_file.occ18,   #客户名称
                      a          LIKE npq_file.npq07,   #收款金额
                      b          LIKE npq_file.npq07,   #回款金额
                      c          LIKE npq_file.npq07    #未维护金额
                    END RECORD                     
                    
  
    DEFINE  l_df  LIKE   npq_file.npq07     
    DEFINE  l_d   LIKE   npq_file.npq07     
    DEFINE  l_cf  LIKE   npq_file.npq07      
    DEFINE  l_c   LIKE   npq_file.npq07      
    #add by shijl 170713--str--
    DEFINE l_date_b  LIKE type_file.dat
    DEFINE l_date_e  LIKE type_file.dat    
    DEFINE l_date_chr  LIKE type_file.chr30
    #add by shijl 170713--end--
    
    #LET g_prog = 'gapr910'
    CALL cxmq115_table()
     
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
     PREPARE cxmq115_pr1 FROM l_sql
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq115_curs1 CURSOR FOR cxmq115_pr1

     #type                  REPORT之前抓取赋值
     # 0 期初余额                
     # 1 回款作业单              Y   
     # 2 收支作业单              Y   
     # 3 开票作业单              Y   
     # 4 订单小计                   
     # 5 本期合计               
     # 6 累计额            
     # 7 收支作业单              
     # 8 MISC         
     # 9 杂项/待抵                     
     #10 未维护收支单                  
     #11 退款                       
     #12 应收调整
     #13 杂项/待抵小计
     #14 未维护收支单小计
     #15 退款小计
     #16 应收调整小计
     #17 销退作业单              Y
     # M 跳过

     #按月抓明细
     #回款作业

                    
     IF tm.c = 'Y' THEN       #按币种分页                                              
        LET l_sql1="SELECT DISTINCT oea03,oea032,oea23,0,tc_nmgdate,tc_nmg06,1,tc_nmg01,tc_nmg02,'',0,NVL(tc_nme05,0),0 ",
                   "  FROM tc_nmg_file,tc_nme_file ",
                   "  LEFT JOIN oea_file ON tc_nme03 = oea01 ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND tc_nme01 = tc_nmg01  AND tc_nmg09 ='A' ", #收支类型是'A'
                   "   AND tc_nme14 = ? ", #币别
                   "   AND tc_nmgdate BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   #"   AND MONTH(tc_nmgdate) = ? " #月份 #marked by shijl 170713
                   "   AND tc_nmgdate BETWEEN ? AND ? " #月份 #add by shijl 170713
                   
     ELSE
        LET l_sql1="SELECT DISTINCT oea03,oea032,oea23,0,tc_nmgdate,tc_nmg06,1,tc_nmg01,tc_nmg02,'',0,NVL(tc_nme05,0),0 ",
                   "  FROM tc_nmg_file,tc_nme_file ",
                   "  LEFT JOIN oea_file ON tc_nme03 = oea01 ",
                   "  WHERE ", l_term CLIPPED, 
                   "   AND oea03 = ? AND oea032 = ? ",
                   "   AND tc_nme01 = tc_nmg01  AND tc_nmg09 ='A' ", #收支类型是'A'
                   "   AND tc_nmgdate BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   #"   AND MONTH(tc_nmgdate) = ? " #月份 #marked by shijl 170713
                   "   AND tc_nmgdate BETWEEN ? AND ? " #月份 #add by shijl 170713
     END IF                                                                       
     
     PREPARE cxmq115_prepare1 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare1:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq115_cursb1 CURSOR FOR cxmq115_prepare1
                    
     #期初
     IF tm.c = 'Y' THEN 
         #期初开票原币,期初退款原币,期初应收调整原币,期初回款原币,期初未回款原币,期初待抵调整原币
         LET l_sql1=" SELECT tc_khy09,tc_khy15,tc_khy17,tc_khy11,tc_khy13,tc_khy19,  ",
         #期初开票本币,期初退款本币,期初应收调整本币,期初回款本币,期初未回款本币,期初待抵调整本币
                    "        tc_khy10,tc_khy16,tc_khy18,tc_khy12,tc_khy14,tc_khy20, ",
                    "        tc_khy07,tc_khy08 ",
                    "   FROM tc_khy_file   ",
                    "  WHERE tc_khy01 = ",YEAR(tm.bdate),                       
                    "    AND tc_khy02 = ",MONTH(tm.bdate),                       
                    "    AND tc_khy03 = ? ",
                    "    AND tc_khy04 = ? "
                    
     ELSE
         #期初开票原币,期初退款原币,期初应收调整原币,期初回款原币,期初未回款原币,期初待抵调整原币
         LET l_sql1=" SELECT tc_khy09,tc_khy15,tc_khy17,tc_khy11,tc_khy13,tc_khy19,  ",
         #期初开票本币,期初退款本币,期初应收调整本币,期初回款本币,期初未回款本币,期初待抵调整本币
                    "        tc_khy10,tc_khy16,tc_khy18,tc_khy12,tc_khy14,tc_khy20, ",         
                    "        tc_khy07,tc_khy08 ",
                    "   FROM tc_khy_file   ",
                    "  WHERE tc_khy01 = ",YEAR(tm.bdate),                       
                    "    AND tc_khy02 = ",MONTH(tm.bdate),                       
                    "    AND tc_khy03 = ? ",
                    "    AND tc_khy04 = 'RMB' "
     END IF                                                                       
               
     PREPARE cxmq115_prepare4 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare4:',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     END IF
     DECLARE cxmq115_curd CURSOR FOR cxmq115_prepare4    
                    
     #未维护收支单
     #anmt200和anmt302单号直接关联axrt300取axrt300中的原币oma54t 本币oma56t
     IF tm.c = 'Y' THEN       #按币种分页                                            
        LET l_sql1=" SELECT DISTINCT nmh11,nmh30,nmh03,0,nmh04,nmh33,'',10,nmh01,'', ",
                   #" nmh02,",
                   #" nmh32 ",
                   " (SELECT oma54t FROM oma_file WHERE oma01=nmh01 ),", #shijl 170713
                   " (SELECT oma56t FROM oma_file WHERE oma01=nmh01) ",  #shijl 170713
                   " from nmh_file ",
                   " where nmh04 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmh11 = ? AND nmh30 = ? ",
                   "   AND nmh03=? ",
                   "   AND MONTH(nmh04) = ? ",  
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmh01 ) ",
                   " UNION ",
                   " SELECT DISTINCT nmg18,nmg19,nmg22,0,nmg01,nmg13,'',10,nmg00,'', ",
                   #" nmg04,",
                   #" nmg05 ",
                   " (SELECT oma54t FROM oma_file WHERE oma01=nmg00 ),", #shijl 170713
                   " (SELECT oma56t FROM oma_file WHERE oma01=nmg00) ",  #shijl 170713                   
                   " from nmg_file ",
                   " where nmg01 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmg18 = ? AND nmg19 = ? ",
                   "   AND nmg22=? ",
                   "   AND MONTH(nmg01) = ? ", 
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmg00 ) "
     ELSE
        LET l_sql1= {" SELECT DISTINCT nmh11,nmh30,nmh03,0,nmh04,nmh33,'',10,nmh01,'', ",
                   #" nmh02,",
                   #" nmh32 ",
                   " (SELECT oma54t FROM oma_file WHERE oma01=nmh01 ),", #shijl 170713
                   " (SELECT oma56t FROM oma_file WHERE oma01=nmh01) ",  #shijl 170713                   
                   " from nmh_file ",
                   " where nmh04 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmh11 = ? AND nmh30 = ? ",
                   "   AND MONTH(nmh04) = ? ", 
                   "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmh01 ) ",
                   " UNION ",}
                   " SELECT DISTINCT nmg18,nmg19,nmg22,0,nmg01,nmg00,2,nmg00,nmg18,nmg19, nmg23,0,0 ",              
                   " from nmg_file ",
                   " where nmg01 BETWEEN '",tm.bdate,"' AND '",tm.edate,"'",
                   "   AND nmg18 = ? AND nmg19 = ? ",
                   "   AND MONTH(nmg01) = ? " --, 
                 --  "   AND NOT EXISTS (select * from tc_nmg_file where tc_nmg06 =nmg00 ) "
     END IF       
     PREPARE cxmq115_prepare6 FROM l_sql1
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare6:',SQLCA.sqlcode,0) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time 
        EXIT PROGRAM
     END IF
     DECLARE cxmq115_cursb6 CURSOR FOR cxmq115_prepare6 

#     CALL cl_outnam('gapr910') RETURNING l_name
     CALL cl_outnam('cxmq115')  RETURNING l_name


 --- START REPORT
 --- 语法：START REPORT rep_name [TO { SCREEN |FILE filename | PRINTER } 
 --- 说明：
 --- 1. 这个指令是在驱动REPORT DRIVER。
 --- 2. TO SCREEN：为系统DEFAULT 可不写。
 --- 3. TO FILE filenme：将REPORT 的结果送到一个档案中(档名自订)。
 --- 4. TO PRINTER：将REPORT 结果送到打印机(系统打印机)。
 --- 5. 若(2)、(3)都不写，则系统会将结果自动送到屏幕输出。
  
     IF tm.c = 'Y' THEN                          
        START REPORT cxmq115_rep1 TO l_name      
     ELSE 
        START REPORT cxmq115_rep TO l_name
     END IF 
     
     LET g_pageno = 0

     FOREACH cxmq115_curs1 INTO sr1.*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,0) EXIT FOREACH
        END IF                                                                    
                 
        FOR l_i = mm1 TO nn1
            INITIALIZE sr.* TO NULL
            LET g_print = 0 
            LET l_date_chr = yy USING "<<<<",l_i USING "&#",'01'
            LET l_date_b = l_date_chr 
            LET l_date_e = s_last(l_date_b)

            IF tm.c = 'Y' THEN 
            
               #回款作业                                                      
               FOREACH cxmq115_cursb1 USING sr1.oea03,sr1.oea032,sr1.oea23,l_date_b ,l_date_e
               #FOREACH cxmq115_cursb1 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                     INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               
                  
                  SELECT nmg13 INTO sr.vno FROM nmg_file,tc_nmg_file
                   WHERE nmg00= tc_nmg06 AND tc_nmg01=sr.tc_nmg01
                  IF cl_null(sr.vno) THEN 
                     SELECT nmh33 INTO sr.vno FROM nmh_file WHERE nmh01 = sr.tc_nmg01
                  END IF 

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq115_rep1(sr.*)	   
   
                  LET g_print = g_print + 1
               END FOREACH    
               
               #收支作业
               FOREACH cxmq115_cursb6 USING sr1.oea03,sr1.oea032,sr1.oea23,l_date_b,l_date_e
               #FOREACH cxmq115_cursb2 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq115_rep1(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH    
                     
               
            ELSE

-- 语法：OUTPUT TO REPORT rep_name(expr_list)
-- 说明：该功能类似CALL function，并传递参数，将数据送到REPORT FUNCTION。
 #回款作业                                                      
               FOREACH cxmq115_cursb1 USING sr1.oea03,sr1.oea032,sr1.oea23,l_date_b ,l_date_e
               #FOREACH cxmq115_cursb1 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                     INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               
                  
                  SELECT nmg13 INTO sr.vno FROM nmg_file,tc_nmg_file
                   WHERE nmg00= tc_nmg06 AND tc_nmg01=sr.tc_nmg01
                  IF cl_null(sr.vno) THEN 
                     SELECT nmh33 INTO sr.vno FROM nmh_file WHERE nmh01 = sr.tc_nmg01
                  END IF 

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq115_rep(sr.*)	   
   
                  LET g_print = g_print + 1
               END FOREACH    
               
               #收支作业
               FOREACH cxmq115_cursb6 USING sr1.oea03,sr1.oea032,sr1.oea23,l_date_b,l_date_e
               #FOREACH cxmq115_cursb2 USING sr1.oea03,sr1.oea032,sr1.oea23,l_i
                                         INTO sr.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF               

                  LET sr.mm   = l_i                                                              
                  OUTPUT TO REPORT cxmq115_rep(sr.*)	                
                  LET g_print = g_print + 1
               END FOREACH    
               
            END IF
                                                                               
            
            IF g_print = 0 THEN   #沒有打印過

               LET sr.oea03   = sr1.oea03
               LET sr.oea032  = sr1.oea032
               LET sr.oea23   = sr1.oea23   
               LET sr.type =  'M'

               LET sr.mm   = l_i                                                

               IF tm.c = 'Y' THEN
                  OUTPUT TO REPORT cxmq115_rep1(sr.*)
               ELSE
                  OUTPUT TO REPORT cxmq115_rep(sr.*)
               END IF	    
            END IF
        END FOR
     END FOREACH
     
     IF tm.c = 'Y' THEN                          
        FINISH REPORT cxmq115_rep1               
     ELSE                                        
        FINISH REPORT cxmq115_rep
     END IF                                      
     LET g_prog = 'cxmq115'

END FUNCTION

REPORT cxmq115_rep(sr)
   DEFINE l_last_sw LIKE type_file.chr1,          
          sr        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    nmg00      LIKE nmg_file.nmg00,   #收支单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    nmg30      LIKE nmg_file.nmg00,   #客户编号
                    occ18      LIKE occ_file.occ18,   #客户名称
                    a          LIKE npq_file.npq07,   #收款金额
                    b          LIKE npq_file.npq07,   #回款金额
                    c          LIKE npq_file.npq07    #未维护金额
                    END RECORD ,
          sr2        RECORD
                                  oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    nmg00      LIKE nmg_file.nmg00,   #收支单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    nmg30      LIKE nmg_file.nmg00,   #客户编号
                    occ18      LIKE occ_file.occ18,   #客户名称
                    a          LIKE npq_file.npq07,   #收款金额
                    b          LIKE npq_file.npq07,   #回款金额
                    c          LIKE npq_file.npq07    #未维护金额
                    END RECORD ,
          l_ooa00                      LIKE ooa_file.ooa00,    
          l_date                       LIKE type_file.dat,     
          l_date1                      LIKE type_file.dat,     
          l_date2                      LIKE type_file.dat,     
          l_dc                         LIKE type_file.chr10,
          l_year                       LIKE type_file.num10,
          l_month                      LIKE type_file.num10,
          l_yb9 LIKE npq_file.npq07,  
          l_bb9 LIKE npq_file.npq07,  
          l_yb9_c LIKE npq_file.npq07,  
          l_bb9_c LIKE npq_file.npq07,
          l_yb9_d LIKE npq_file.npq07,  
          l_bb9_d LIKE npq_file.npq07                    
DEFINE l_zzysye ,l_chysye  LIKE type_file.num20_6   #用于本期累计
DEFINE l_zzysye2,l_chysye2 LIKE type_file.num20_6   #用于按月累计
DEFINE l_d,l_df,l_c,l_cf   LIKE npq_file.npq07 #本期累计
DEFINE qc_d,qc_df,qc_c,qc_cf   LIKE npq_file.npq07 #期初 借贷方
    DEFINE  lf_qckp    LIKE   tc_khy_file.tc_khy09 #原币期初开票
    DEFINE  lf_qctk    LIKE   tc_khy_file.tc_khy15 #原币期初退款
    DEFINE  lf_qcystz  LIKE   tc_khy_file.tc_khy17 #原币期初应收调整
    DEFINE  lf_qchk    LIKE   tc_khy_file.tc_khy11 #原币期初回款
    DEFINE  lf_qcwhk   LIKE   tc_khy_file.tc_khy13 #原币期初未回款
    DEFINE  lf_qcddtz  LIKE   tc_khy_file.tc_khy19 #原币期初待抵调整
    DEFINE  lf_qcch    LIKE   tc_khy_file.tc_khy07 #原币期初出货
    DEFINE  l_qckp     LIKE   tc_khy_file.tc_khy09 #本币期初开票
    DEFINE  l_qctk     LIKE   tc_khy_file.tc_khy15 #本币期初退款
    DEFINE  l_qcystz   LIKE   tc_khy_file.tc_khy17 #本币期初应收调整
    DEFINE  l_qchk     LIKE   tc_khy_file.tc_khy11 #本币期初回款
    DEFINE  l_qcwhk    LIKE   tc_khy_file.tc_khy13 #本币期初未回款
    DEFINE  l_qcddtz   LIKE   tc_khy_file.tc_khy19 #本币期初待抵调整    
    DEFINE  l_qcch     LIKE   tc_khy_file.tc_khy08 #原币期初出货     
    DEFINE  l_qcyef_z  LIKE   npq_file.npq07 
    DEFINE  l_qcye_z   LIKE   npq_file.npq07 
    DEFINE  l_qcyef_c  LIKE   npq_file.npq07 
    DEFINE  l_qcye_c   LIKE   npq_file.npq07  
    DEFINE  l_qcdf     LIKE   npq_file.npq07 
    DEFINE  l_qcd      LIKE   npq_file.npq07 
    DEFINE  l_qccf     LIKE   npq_file.npq07 
    DEFINE  l_qcc      LIKE   npq_file.npq07   
    DEFINE  l_a        LIKE   npq_file.npq07 
    DEFINE  l_b        LIKE   npq_file.npq07 
    DEFINE  l_c        LIKE   npq_file.npq07    

  -- OUTPUT 此叙述为定义报表的边界，报表长度
  -- 1. ORDER BY 区间，主要是作排序字段用，以逗号分开，摆在最前面的字段为主键，
  -- 同时只能用所接收的参数内的字段来排序。
  -- 2. ORDER BY 会先将数据排序过并存在暂存盘中，配合BEFORE GROUP OF 或
  -- AFTER GROUP OF 区段排序后再由暂存档印出。
  -- 3. 加上EXTERNAL 即表示传入的数据已经经过外部（START REPORT 时）的排序，
  -- 因此此处仅为注标，系统不会重复的运行工作。
  -- 4. 若后续于FORMAT 中有使用GROUP 的分群输出功能，则一定要有ORDER BY 宣告，
  -- 必要时可搭配上述EXTRRNAL 功能。
  --  FIRST PAGE HEADER ：报表第一页的表头控制段。
  --  PAGE HEADER ：报表每一页的表头控制段。
  --  BEFORE GROUP OF ：设置在一组数据的开始之前所必须运行的叙述。
  --  ON EVERY ROW ：指定每一笔记录的输出格式。
  --  AFTER GROUP OF ：在控制区段设置一组数据之后必须运行的叙述。
  --  PAGE TRAILER ：每一页报表页尾的控制段。
  --  ON LAST ROW ：所有数据印完后要做的动作，例如”总计”。

  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER BY sr.oea03,sr.oea032,sr.mm,sr.nmg00,sr.vdate
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
                                                             
             EXECUTE cxmq115_curd USING sr.oea03,sr.oea23  
               INTO lf_qckp,lf_qctk,lf_qcystz,lf_qchk,lf_qcwhk,lf_qcddtz,
                    l_qckp,l_qctk,l_qcystz,l_qchk,l_qcwhk,l_qcddtz,lf_qcch,l_qcch                  
        ELSE
             EXECUTE cxmq115_curd USING sr.oea03  
               INTO lf_qckp,lf_qctk,lf_qcystz,lf_qchk,lf_qcwhk,lf_qcddtz,
                    l_qckp,l_qctk,l_qcystz,l_qchk,l_qcwhk,l_qcddtz,lf_qcch,l_qcch
                        
        END IF       
        
        IF cl_null(lf_qckp) THEN LET lf_qckp = 0 END IF   
        IF cl_null(lf_qctk) THEN LET lf_qctk = 0 END IF     
        IF cl_null(lf_qcystz) THEN LET lf_qcystz = 0 END IF     
        IF cl_null(lf_qchk) THEN LET lf_qchk = 0 END IF     
        IF cl_null(lf_qcwhk) THEN LET lf_qcwhk = 0 END IF     
        IF cl_null(lf_qcddtz) THEN LET lf_qcddtz = 0 END IF     
        IF cl_null(l_qckp) THEN LET l_qckp = 0 END IF     
        IF cl_null(l_qctk) THEN LET l_qctk = 0 END IF     
        IF cl_null(l_qcystz) THEN LET l_qcystz = 0 END IF     
        IF cl_null(l_qchk) THEN LET l_qchk = 0 END IF     
        IF cl_null(l_qcwhk) THEN LET l_qcwhk = 0 END IF     
        IF cl_null(l_qcddtz) THEN LET l_qcddtz = 0 END IF     
        IF cl_null(lf_qcch) THEN LET lf_qcch = 0 END IF
        IF cl_null(l_qcch) THEN LET l_qcch = 0 END IF  
                      
        LET l_df = lf_qckp +lf_qctk +lf_qcystz
        LET l_cf = lf_qchk  +lf_qcwhk  +lf_qcddtz  
        LET l_d = l_qckp +l_qctk + l_qcystz
        LET l_c = l_qchk +l_qcwhk  +l_qcddtz 
         
        LET l_qcyef_z = l_df - l_cf
        LET l_qcye_z  = l_d  - l_c
        LET qc_df = l_df
        LET qc_d  = l_d 
        LET qc_cf = l_cf
        LET qc_c  = l_c            

       #期初出货原币/本币金额+期初退款原币/本币金额+期初应收调整原币/本币金额-期初回款原币/本币金额的合计-期初回款未收款原币/本币金额的合计-期初待抵调整原币/本币金额
               
        LET l_qcyef_c = lf_qcch + lf_qctk + lf_qcystz - lf_qchk - lf_qcwhk - lf_qcddtz
        LET l_qcye_c =  l_qcch + l_qctk + l_qcystz - l_qchk - l_qcwhk - l_qcddtz      
                  
      #期初金额
      IF tm.b = 'Y' THEN  #打印原币
         LET l_zzysye2 = qc_df - qc_cf 
         LET l_zzysye2 = l_qcyef_z
         LET l_chysye2 = l_qcyef_c
      ELSE 
       	 LET l_zzysye2 = qc_d - qc_c 
       	 LET l_zzysye2 = l_qcye_z
       	 LET l_chysye2 = l_qcye_c
      END IF 

      IF cl_null(l_zzysye2) THEN LET l_zzysye2 = 0 END IF 
      IF cl_null(l_chysye2) THEN LET l_chysye2 = 0 END IF 
      
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             '','0','','','',l_qchk,l_qchk,l_qcwhk )
      LET g_seq=g_seq+1

                      
   BEFORE GROUP OF sr.nmg00 
      #本期小计前清值
      LET l_a = 0   
      LET l_b = 0   
      LET l_c = 0     

       
   ON EVERY ROW
     
                      
      IF cl_null(sr.a) THEN LET sr.a = 0 END IF 
      IF cl_null(sr.b) THEN LET sr.b = 0 END IF  
      IF cl_null(sr.f) THEN LET sr.c = 0 END IF  
     
           
      #出货应收余额按订单累计
      IF sr.type='1' OR sr.type='2' THEN  #回款单作业(1)或发货单作业(2)
          IF tm.b = 'Y' THEN  #打印原币
            LET l_chysye  = l_chysye + sr.df - sr.cf 
          ELSE  
            LET l_chysye  = l_chysye + sr.d - sr.c            	
          END IF
      END IF 
      #总账应收余额按订单累计
      IF tm.b = 'Y'  THEN #打印原币
            LET l_zzysye  = l_zzysye + sr.df - sr.cf 
      ELSE
            LET l_zzysye  = l_zzysye + sr.d - sr.c  	      
      END IF 
              
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,--sr.vno,
             sr.nmg00,sr.type,sr.tc_nmg01,sr.nmg00,sr.occ18, 
             sr.a,sr.b,sr.c ) 
      LET g_seq=g_seq+1 

 
                    
   AFTER GROUP OF sr.nmg00 
       #订单小计
      LET l_d = GROUP SUM(sr.a)   
      LET l_df= GROUP SUM(sr.b)  
      LET l_c = GROUP SUM(sr.c)   
      
              
      #用于累计
      LET l_chysye2 = l_chysye2 + l_chysye 
    
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,--sr.vno,
             sr.nmg00,sr.type,sr.tc_nmg01,sr.nmg00,sr.occ18, 
             sr.a,sr.b,sr.c ) 
      LET g_seq=g_seq+1
                 
   AFTER GROUP OF sr.mm
      #本期合计
   
      #type = '5' 本期合計打印
      LET l_d = GROUP SUM(sr.d)   
      LET l_df= GROUP SUM(sr.df)  
      LET l_c = GROUP SUM(sr.c)   
      LET l_cf= GROUP SUM(sr.cf)
      
      IF tm.b = 'Y' THEN  #打印原币
            LET l_zzysye  = l_df - l_cf 
      ELSE
            LET l_zzysye  = l_d - l_c  	      
      END IF 
      LET l_chysye = l_chysye2 - l_qcye_c
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,--sr.vno,
             sr.nmg00,sr.type,sr.tc_nmg01,sr.nmg00,sr.occ18, 
             sr.a,sr.b,sr.c ) 
      LET g_seq=g_seq+1 

      #累计额
      LET l_d   = l_d + qc_df                                                  
      LET l_df  = l_df+ qc_d                                                    
      LET l_c   = l_c + qc_cf                                                  
      LET l_cf  = l_cf+ qc_c 
      IF tm.b = 'Y' THEN  #打印原币
            LET l_zzysye2  = l_df - l_cf 
      ELSE
            LET l_zzysye2  = l_d - l_c  	      
      END IF 
      
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             '','6','','',l_zzysye2,l_chysye2,
             l_df,l_d,l_cf,l_c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
      LET g_seq=g_seq+1 
    
     #MISC --str--
     
#     INSERT INTO cxmq115_tmp
#      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
#        '','8','','','','',
#        '','','','',
#        g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
#     LET g_seq=g_seq+1 
     
     
   
     IF tm.b = 'Y' THEN  #打印原币

        #未维护收支单
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        
        FOREACH cxmq115_cursb6 USING sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach6:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             '','',sr2.yb,sr2.bb,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',14,'',sr2.exp,'','',
                '','',l_yb9,l_bb9,
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF
                
                
     ELSE 
       
        
        #未维护收支单
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        FOREACH cxmq115_cursb6 USING sr.oea03,sr.oea032,sr.mm,sr.oea03,sr.oea032,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach6:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
            VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,--sr.vno,
             sr.nmg00,sr.type,sr.tc_nmg01,sr.nmg00,sr.occ18, 
             sr.a,sr.b,sr.c ) 
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,--sr.vno,
             sr.nmg00,sr.type,sr.tc_nmg01,sr.nmg00,sr.occ18, 
             sr.a,sr.b,sr.c ) 
        END IF
        

     END IF  
     
     #MISC --end--
      
    
END REPORT

REPORT cxmq115_rep1(sr)
   DEFINE l_last_sw LIKE type_file.chr1,          
          sr        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    vno        LIKE npp_file.npp01,   #凭证号
                    oea01      LIKE oea_file.oea01,   #订单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    exp        LIKE type_file.chr300,   #说明
                    zzysye     LIKE npq_file.npq07,     #总账应收余额
                    chysye    LIKE npq_file.npq07,     #出货应收余额                                
                    df     LIKE npq_file.npq07,  
                    d      LIKE npq_file.npq07,
                    cf     LIKE npq_file.npq07,
                    c      LIKE npq_file.npq07
                    END RECORD ,
          sr2        RECORD
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                    vdate      LIKE npp_file.npp02,   #日期
                    vno        LIKE npp_file.npp01,   #凭证号
                    oea01      LIKE oea_file.oea01,   #订单号
                    type       LIKE npp_file.nppsys,  #单据类型
                    tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                    exp        LIKE type_file.chr300,   #说明
                    yb     LIKE npq_file.npq07,     
                    bb     LIKE npq_file.npq07
                    END RECORD ,
          l_ooa00                      LIKE ooa_file.ooa00,                    
          l_date                       LIKE type_file.dat,     
          l_date1                      LIKE type_file.dat,     
          l_date2                      LIKE type_file.dat,     
          l_dc                         LIKE type_file.chr10,
          l_year                       LIKE type_file.num10,
          l_month                      LIKE type_file.num10,
          l_yb9 LIKE npq_file.npq07,  
          l_bb9 LIKE npq_file.npq07,  
          l_yb9_c LIKE npq_file.npq07,  
          l_bb9_c LIKE npq_file.npq07,
          l_yb9_d LIKE npq_file.npq07,  
          l_bb9_d LIKE npq_file.npq07          
DEFINE l_zzysye ,l_chysye  LIKE type_file.num20_6   #用于本期累计
DEFINE l_zzysye2,l_chysye2 LIKE type_file.num20_6   #用于按月累计
DEFINE l_d,l_df,l_c,l_cf   LIKE npq_file.npq07 #本期累计
DEFINE qc_d,qc_df,qc_c,qc_cf   LIKE npq_file.npq07 #期初 借贷方
    DEFINE  lf_qckp    LIKE   tc_khy_file.tc_khy09 #原币期初开票
    DEFINE  lf_qctk    LIKE   tc_khy_file.tc_khy15 #原币期初退款
    DEFINE  lf_qcystz  LIKE   tc_khy_file.tc_khy17 #原币期初应收调整
    DEFINE  lf_qchk    LIKE   tc_khy_file.tc_khy11 #原币期初回款
    DEFINE  lf_qcwhk   LIKE   tc_khy_file.tc_khy13 #原币期初未回款
    DEFINE  lf_qcddtz  LIKE   tc_khy_file.tc_khy19 #原币期初待抵调整
    DEFINE  lf_qcch    LIKE   tc_khy_file.tc_khy07 #原币期初出货
    DEFINE  l_qckp    LIKE   tc_khy_file.tc_khy09 #本币期初开票
    DEFINE  l_qctk    LIKE   tc_khy_file.tc_khy15 #本币期初退款
    DEFINE  l_qcystz  LIKE   tc_khy_file.tc_khy17 #本币期初应收调整
    DEFINE  l_qchk    LIKE   tc_khy_file.tc_khy11 #本币期初回款
    DEFINE  l_qcwhk   LIKE   tc_khy_file.tc_khy13 #本币期初未回款
    DEFINE  l_qcddtz  LIKE   tc_khy_file.tc_khy19 #本币期初待抵调整    
    DEFINE  l_qcch    LIKE   tc_khy_file.tc_khy08 #原币期初出货     
    DEFINE  l_qcyef_z  LIKE   npq_file.npq07 
    DEFINE  l_qcye_z   LIKE   npq_file.npq07 
    DEFINE  l_qcyef_c  LIKE   npq_file.npq07 
    DEFINE  l_qcye_c   LIKE   npq_file.npq07  
    DEFINE  l_qcdf  LIKE   npq_file.npq07 
    DEFINE  l_qcd   LIKE   npq_file.npq07 
    DEFINE  l_qccf  LIKE   npq_file.npq07 
    DEFINE  l_qcc   LIKE   npq_file.npq07 

  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER BY sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.oea01,sr.vdate
  FORMAT
   PAGE HEADER
      LET g_pageno = g_pageno + 1

   BEFORE GROUP OF sr.oea03 
    
   BEFORE GROUP OF sr.oea032
      IF sr.mm = MONTH(tm.bdate) THEN
         LET l_date2 = tm.bdate
      ELSE
         LET l_date2 = MDY(sr.mm,1,yy)
      END IF

      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07 FROM azi_file     
       WHERE azi01 = sr.oea23
      
      #抓期初数据   
        IF tm.c = 'Y' THEN    
                                                             
             EXECUTE cxmq115_curd USING sr.oea03,sr.oea23  
               INTO lf_qckp,lf_qctk,lf_qcystz,lf_qchk,lf_qcwhk,lf_qcddtz,
                    l_qckp,l_qctk,l_qcystz,l_qchk,l_qcwhk,l_qcddtz,lf_qcch,l_qcch                  
                         
        ELSE
             EXECUTE cxmq115_curd USING sr.oea03  
               INTO lf_qckp,lf_qctk,lf_qcystz,lf_qchk,lf_qcwhk,lf_qcddtz,
                    l_qckp,l_qctk,l_qcystz,l_qchk,l_qcwhk,l_qcddtz,lf_qcch,l_qcch
                        
        END IF                 
        IF cl_null(lf_qckp) THEN LET lf_qckp = 0 END IF   
        IF cl_null(lf_qctk) THEN LET lf_qctk = 0 END IF     
        IF cl_null(lf_qcystz) THEN LET lf_qcystz = 0 END IF     
        IF cl_null(lf_qchk) THEN LET lf_qchk = 0 END IF     
        IF cl_null(lf_qcwhk) THEN LET lf_qcwhk = 0 END IF     
        IF cl_null(lf_qcddtz) THEN LET lf_qcddtz = 0 END IF     
        IF cl_null(l_qckp) THEN LET l_qckp = 0 END IF     
        IF cl_null(l_qctk) THEN LET l_qctk = 0 END IF     
        IF cl_null(l_qcystz) THEN LET l_qcystz = 0 END IF     
        IF cl_null(l_qchk) THEN LET l_qchk = 0 END IF     
        IF cl_null(l_qcwhk) THEN LET l_qcwhk = 0 END IF     
        IF cl_null(l_qcddtz) THEN LET l_qcddtz = 0 END IF     
        IF cl_null(lf_qcch) THEN LET lf_qcch = 0 END IF
        IF cl_null(l_qcch) THEN LET l_qcch = 0 END IF
                                                               
        LET l_df = lf_qckp +lf_qctk +lf_qcystz
        LET l_cf = lf_qchk  +lf_qcwhk  +lf_qcddtz  
        LET l_d = l_qckp +l_qctk + l_qcystz
        LET l_c = l_qchk +l_qcwhk  +l_qcddtz 
         
        LET l_qcyef_z = l_df - l_cf
        LET l_qcye_z  = l_d  - l_c
        LET qc_df = l_df
        LET qc_d  = l_d 
        LET qc_cf = l_cf
        LET qc_c  = l_c            
          
        LET l_qcyef_c = lf_qcch + lf_qctk + lf_qcystz - lf_qchk - lf_qcwhk - lf_qcddtz
        LET l_qcye_c =  l_qcch + l_qctk + l_qcystz - l_qchk - l_qcwhk - l_qcddtz            
             
                  
      #期初金额
      IF tm.b = 'Y' THEN  #打印原币
         LET l_zzysye2 = qc_df - qc_cf 
         LET l_zzysye2 = l_qcyef_z
         LET l_chysye2 = l_qcyef_c
      ELSE 
       	 LET l_zzysye2 = qc_d - qc_c 
       	 LET l_zzysye2 = l_qcye_z
       	 LET l_chysye2 = l_qcye_c
      END IF 
            
      IF cl_null(l_zzysye2) THEN LET l_zzysye2 = 0 END IF 
      IF cl_null(l_chysye2) THEN LET l_chysye2 = 0 END IF 
      
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             '','0','','',l_zzysye2,l_chysye2,
             qc_df,qc_d,qc_cf,qc_c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
      LET g_seq=g_seq+1        
              
   BEFORE GROUP OF sr.oea23 
      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07 FROM azi_file     
       WHERE azi01 = sr.oea23
        
        
   BEFORE GROUP OF sr.oea01 
      #本期小计前清值
      LET  l_zzysye = 0   #本期总账应收余额累计
      LET  l_chysye = 0   #本期出货应收余额累计   
      
      LET l_d = 0   
      LET l_df = 0   
      LET l_c = 0     
      LET l_cf = 0   
       
   ON EVERY ROW
     
      IF cl_null(sr.df) THEN LET sr.df = 0 END IF 
      IF cl_null(sr.d) THEN LET sr.d = 0 END IF  
      IF cl_null(sr.cf) THEN LET sr.cf = 0 END IF  
      IF cl_null(sr.c) THEN LET sr.c = 0 END IF
           
      #出货应收余额按订单累计
      IF sr.type='1' OR sr.type='2' THEN  #回款单作业(1)或发货单作业(2)
          IF tm.b = 'Y' THEN  #打印原币
            LET l_chysye  = l_chysye + sr.df - sr.cf 
          ELSE  
            LET l_chysye  = l_chysye + sr.d - sr.c            	
          END IF
      END IF 
      #总账应收余额按订单累计
      IF tm.b = 'Y'  THEN #打印原币
            LET l_zzysye  = l_zzysye + sr.df - sr.cf 
      ELSE
            LET l_zzysye  = l_zzysye + sr.d - sr.c  	      
      END IF 
              
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.vdate,sr.vno,
             sr.oea01,sr.type,sr.tc_nmg01,sr.exp,l_zzysye,l_chysye,
             sr.df,sr.d,sr.cf,sr.c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
      LET g_seq=g_seq+1
      
   AFTER GROUP OF sr.oea01 
       #订单小计
      LET l_d = GROUP SUM(sr.d)   
      LET l_df= GROUP SUM(sr.df)  
      LET l_c = GROUP SUM(sr.c)   
      LET l_cf= GROUP SUM(sr.cf)
              
      #用于累计
      LET l_chysye2 = l_chysye2 + l_chysye 
    
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             sr.oea01,'4','','',l_zzysye,l_chysye,
             l_df,l_d,l_cf,l_c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
      LET g_seq=g_seq+1          
      
   AFTER GROUP OF sr.mm
      #本期合计
   
      #type = '5' 本期合計打印
      LET l_d = GROUP SUM(sr.d)   
      LET l_df= GROUP SUM(sr.df)  
      LET l_c = GROUP SUM(sr.c)   
      LET l_cf= GROUP SUM(sr.cf)
      
      IF tm.b = 'Y' THEN  #打印原币
            LET l_zzysye  = l_df - l_cf 
      ELSE
            LET l_zzysye  = l_d - l_c  	      
      END IF 
      
      LET l_chysye = l_chysye2 - l_qcye_c
      
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             '','5','','',l_zzysye,l_chysye,
             l_df,l_d,l_cf,l_c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)             
      LET g_seq=g_seq+1

      #累计额
      LET l_d   = l_d + qc_df                                                  
      LET l_df  = l_df+ qc_d                                                    
      LET l_c   = l_c + qc_cf                                                  
      LET l_cf  = l_cf+ qc_c 
      IF tm.b = 'Y' THEN  #打印原币
            LET l_zzysye2  = l_df - l_cf 
      ELSE
            LET l_zzysye2  = l_d - l_c  	      
      END IF 
      
      INSERT INTO cxmq115_tmp
      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
             '','6','','',l_zzysye2,l_chysye2,
             l_df,l_d,l_cf,l_c,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)
      LET g_seq=g_seq+1  

     #MISC --str--
     
#     INSERT INTO cxmq115_tmp
#      VALUES(sr.oea03,sr.oea032,sr.oea23,sr.mm,'','',
#        '','8','','','','',
#        '','','','',
#        g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
#     LET g_seq=g_seq+1 
     
     
   
     IF tm.b = 'Y' THEN  #打印原币
        #杂项/待抵
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0                  
        FOREACH cxmq115_cursb5 USING sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach5:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',13,'',sr2.exp,'','',
                l_yb9,l_bb9,'','',
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF         
        
        #未维护收支单
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        FOREACH cxmq115_cursb6 USING sr.oea03,sr.oea032,sr.oea23,sr.mm,sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach6:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             '','',sr2.yb,sr2.bb,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',14,'',sr2.exp,'','',
                '','',l_yb9,l_bb9,
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF
                 
        #退款
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        FOREACH cxmq115_cursb7 USING sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach7:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',15,'',sr2.exp,'','',
                l_yb9,l_bb9,'','',
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF         
        
        #应收调整
        LET g_print  =0
        LET l_yb9_c =0
        LET l_yb9_d =0        
        LET l_bb9_c =0
        LET l_bb9_d =0        
        FOREACH cxmq115_cursb8 USING sr.oea03,sr.oea032,sr.oea23,sr.mm INTO sr2.*,l_ooa00
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach8:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF     
           IF l_ooa00 ='1' THEN 
             INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
             LET l_yb9_d=l_yb9_d+sr2.yb 
             LET l_bb9_d=l_bb9_d+sr2.bb  
           ELSE
             INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             '','',sr2.yb,sr2.bb,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)   
             LET l_yb9_c=l_yb9_c+sr2.yb 
             LET l_bb9_c=l_bb9_c+sr2.bb                         
           END IF 
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',16,'',sr2.exp,'','',
                l_yb9_d,l_bb9_d,l_yb9_c,l_bb9_c,
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF         
                
     ELSE 
        #杂项/待抵
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0                  
        FOREACH cxmq115_cursb5 USING sr.oea03,sr.oea032,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach5:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',13,'',sr2.exp,'','',
                l_yb9,l_bb9,'','',
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF         
        
        #未维护收支单
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        FOREACH cxmq115_cursb6 USING sr.oea03,sr.oea032,sr.mm,sr.oea03,sr.oea032,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach6:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             '','',sr2.yb,sr2.bb,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',14,'',sr2.exp,'','',
                '','',l_yb9,l_bb9,
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF
                 
        #退款
        LET g_print  =0
        LET l_yb9 =0
        LET l_bb9 =0
        FOREACH cxmq115_cursb7 USING sr.oea03,sr.oea032,sr.mm INTO sr2.*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach7:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF            
           INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)  
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1  
           
           LET l_yb9=l_yb9+sr2.yb  
           LET l_bb9=l_bb9+sr2.bb                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',15,'',sr2.exp,'','',
                l_yb9,l_bb9,'','',
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF         
        
        #应收调整
        LET g_print  =0
        LET l_yb9_c =0
        LET l_yb9_d =0        
        LET l_bb9_c =0
        LET l_bb9_d =0        
        FOREACH cxmq115_cursb8 USING sr.oea03,sr.oea032,sr.mm INTO sr2.*,l_ooa00
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach8:',SQLCA.sqlcode,0) EXIT FOREACH
           END IF     
           IF l_ooa00 ='1' THEN 
             INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             sr2.yb,sr2.bb,'','',
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07) 
             LET l_yb9_d=l_yb9_d+sr2.yb 
             LET l_bb9_d=l_bb9_d+sr2.bb  
           ELSE
             INSERT INTO cxmq115_tmp
             VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,sr2.vno,
             '',sr.type,sr2.tc_nmg01,sr2.exp,'','',
             '','',sr2.yb,sr2.bb,
             g_pageno,g_seq,t_azi04,t_azi05,t_azi07)   
             LET l_yb9_c=l_yb9_c+sr2.yb 
             LET l_bb9_c=l_bb9_c+sr2.bb                         
           END IF 
           LET g_seq=g_seq+1 
           LET g_print = g_print + 1                                                              
        END FOREACH 
        #小计
        IF g_print >0  THEN 
              INSERT INTO cxmq115_tmp
                VALUES(sr2.oea03,sr2.oea032,sr2.oea23,sr.mm,sr2.vdate,'',
                '',16,'',sr2.exp,'','',
                l_yb9_d,l_bb9_d,l_yb9_c,l_bb9_c,
                g_pageno,g_seq,t_azi04,t_azi05,t_azi07)       
        END IF   
        
                                      
     END IF  
     
     #MISC --end--     
END REPORT

FUNCTION q115_bp(p_ud)
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
         CALL cxmq115_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  
 
      ON ACTION previous
         CALL cxmq115_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  

      ON ACTION jump
         CALL cxmq115_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  
 
      ON ACTION next
         CALL cxmq115_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY  

      ON ACTION last
         CALL cxmq115_fetch('L')
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



FUNCTION cxmq115_cs()
   
   #No.FUN-A30009  --Begin
   IF tm.c = 'Y' THEN     
     LET g_sql = "SELECT UNIQUE oea03,oea032,oea23 FROM cxmq115_tmp ",
                 " ORDER BY oea03,oea032,oea23 "
   ELSE
   
     LET g_sql = "SELECT UNIQUE oea03,oea032 FROM cxmq115_tmp ",
                 " ORDER BY oea03,oea032"   
   END IF	                                               
   
     PREPARE cxmq115_ps FROM g_sql
     DECLARE cxmq115_curs SCROLL CURSOR WITH HOLD FOR cxmq115_ps
     
   
   IF tm.c = 'Y' THEN     
     LET g_sql = "SELECT UNIQUE oea03,oea032,oea23 FROM cxmq115_tmp ",
                 "  INTO TEMP x "
   ELSE
   
     LET g_sql = "SELECT UNIQUE oea03,oea032 FROM cxmq115_tmp ",
                 "  INTO TEMP x " 
   END IF	                                               
   #No.FUN-A30009  --End  

     DROP TABLE x
     PREPARE cxmq115_ps1 FROM g_sql
     EXECUTE cxmq115_ps1

     LET g_sql = "SELECT COUNT(*) FROM x"
     PREPARE cxmq115_ps2 FROM g_sql
     DECLARE cxmq115_cnt CURSOR FOR cxmq115_ps2

     OPEN cxmq115_curs
     IF SQLCA.sqlcode THEN
        CALL cl_err('OPEN cxmq115_curs',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     ELSE
        OPEN cxmq115_cnt 
        FETCH cxmq115_cnt INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL cxmq115_fetch('F')
     END IF
END FUNCTION

FUNCTION cxmq115_fetch(p_flag)
DEFINE
   p_flag          LIKE type_file.chr1,                 #處理方式        
   l_abso          LIKE type_file.num10                 #絕對的筆數      

   
   IF tm.c = 'Y' THEN
   CASE p_flag
      WHEN 'N' FETCH NEXT     cxmq115_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'P' FETCH PREVIOUS cxmq115_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'F' FETCH FIRST    cxmq115_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
      WHEN 'L' FETCH LAST     cxmq115_curs INTO g_oea03,g_oea032,g_oea23 #No.FUN-A30009 
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
         FETCH ABSOLUTE g_jump cxmq115_curs INTO g_oea03,g_oea032,g_oea23   #No.FUN-A30009
         LET mi_no_ask = FALSE
   END CASE
   ELSE
   
   CASE p_flag
      WHEN 'N' FETCH NEXT     cxmq115_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'P' FETCH PREVIOUS cxmq115_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'F' FETCH FIRST    cxmq115_curs INTO g_oea03,g_oea032   #No.FUN-A30009
      WHEN 'L' FETCH LAST     cxmq115_curs INTO g_oea03,g_oea032   #No.FUN-A30009
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
         FETCH ABSOLUTE g_jump cxmq115_curs INTO g_oea03,g_oea032   #No.FUN-A30009
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

   CALL cxmq115_show()
END FUNCTION

FUNCTION cxmq115_show()
 
   DISPLAY g_oea03  TO oea03
   DISPLAY g_oea032 TO oea032
   DISPLAY g_oea23  TO oea23                           
   DISPLAY yy   TO yy
#  DISPLAY g_mm TO mm  #No.FUN-A30009

   CALL cxmq115_b_fill()

   CALL cl_show_fld_cont() 
   
END FUNCTION



                    
FUNCTION cxmq115_b_fill()                     #BODY FILL UP
  DEFINE  l_npq06    LIKE npq_file.npq06
  DEFINE  l_type     LIKE type_file.chr1
                    
   IF tm.c = 'Y' THEN
      LET g_sql = " SELECT vdate,vno,type,tc_nmg01,nmg30,occ18,a,b,c ",
                  " FROM cxmq115_tmp ",
                  " WHERE oea03 ='",g_oea03,"'",
                  "   AND oea032 ='",g_oea032,"' ",
                  "   AND oea23 ='",g_oea23,"'",
                  "  order by seq "
   ELSE 
      LET g_sql = "SELECT vdate,vno,type,tc_nmg01,nmg30,occ18,a,b,c ",
                  " FROM cxmq115_tmp",
                  " WHERE oea03 ='",g_oea03,"'",
                  "   AND oea032 ='",g_oea032,"' ",
                  "  order by seq "
   END IF 
   
   PREPARE cxmq115_pb FROM g_sql
   DECLARE npq_curs  CURSOR FOR cxmq115_pb        #CURSOR

   CALL g_oea.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH npq_curs INTO g_oea[g_cnt].*--,t_azi04,t_azi05,t_azi07
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF 

       {
      IF g_oea[g_cnt].TYPE THEN 
          
      END IF 
              
      LET g_oea[g_cnt].d   = cl_numfor(g_oea[g_cnt].d,20,g_azi04)
      LET g_oea[g_cnt].c   = cl_numfor(g_oea[g_cnt].c,20,g_azi04)
      LET g_oea[g_cnt].df  = cl_numfor(g_oea[g_cnt].df,20,t_azi04)
      LET g_oea[g_cnt].cf  = cl_numfor(g_oea[g_cnt].cf,20,t_azi04)
      LET g_oea[g_cnt].zzysye= cl_numfor(g_oea[g_cnt].zzysye,20,t_azi04)
      LET g_oea[g_cnt].chysye= cl_numfor(g_oea[g_cnt].chysye,20,t_azi04)
      #外幣時,外幣匯總沒有意義
      
      IF g_oea[g_cnt].type = '1' THEN  #回款作业单  贷方                                                    
         LET g_oea[g_cnt].d         = NULL                                      
         LET g_oea[g_cnt].df        = NULL                                                               
      END IF  
      IF g_oea[g_cnt].type = '2' OR g_oea[g_cnt].type = '3' OR g_oea[g_cnt].type = '17' THEN  #出货作业单|| 开票作业 借方                                                    
         LET g_oea[g_cnt].c         = NULL                                      
         LET g_oea[g_cnt].cf        = NULL                                                               
      END IF      
      IF g_oea[g_cnt].type = '7' THEN  #收支作业单  借方                                                    
         LET g_oea[g_cnt].c         = NULL                                      
         LET g_oea[g_cnt].cf        = NULL    
         LET g_oea[g_cnt].d         = NULL                                      
         LET g_oea[g_cnt].df        = NULL                                                                    
      END IF                           
}
      LET g_cnt = g_cnt + 1

   END FOREACH

   CALL g_oea.deleteElement(g_cnt)
   LET g_rec_b = g_cnt - 1

END FUNCTION

                      
FUNCTION cxmq115_table()
     DROP TABLE cxmq115_tmp;
     CREATE TEMP TABLE cxmq115_tmp(
                    oea03    LIKE oea_file.oea03,
                    oea032   LIKE oea_file.oea032,
                    oea23    LIKE oea_file.oea23, 
                    mm       LIKE type_file.num5,
                      vdate      LIKE npp_file.npp02,   #日期
                      nmg00      LIKE nmg_file.nmg00,   #收支单号
                      type       LIKE npp_file.nppsys,  #单据类型
                      tc_nmg01   LIKE tc_nmg_file.tc_nmg01,  #单据号
                      nmg30      LIKE nmg_file.nmg00,   #客户编号
                      occ18      LIKE occ_file.occ18,   #客户名称
                      a          LIKE npq_file.npq07,   #收款金额
                      b          LIKE npq_file.npq07,   #回款金额
                      c          LIKE npq_file.npq07    );
END FUNCTION

FUNCTION q115_out_1()
#  LET g_prog = 'gapq910'
   LET g_sql = "oea03.oea_file.oea03,",
               "oea032.oea_file.oea032,",
               "oea23.oea_file.oea23,", 
               "mm.type_file.num5,",
               "vdate.npp_file.npp02,",               
               "vno.npp_file.npp01,",
             --  "nmg00.nmg_file.nmg00,", 
               "type.type_file.chr1,",
               "tc_nmg01.tc_nmg_file.tc_nmg01,",                                                       
               "tc_nmg30.tc_nmg_file.tc_nmg30,",    
               "occ18.occ_file.occ18,",  
               "a.npq_file.npq07,",    
               "b.npq_file.npq07,",
               "c.npq_file.npq07"
   LET l_table = cl_prt_temptable('cxmq115',g_sql) CLIPPED
   IF  l_table = -1 THEN 
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
   END IF
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ",
               "        ?, ?, ?      ) "
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN 
      CALL cl_err('insert_prep:',status,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF

#   LET g_prog = 'cxmq115'
END FUNCTION

FUNCTION q115_out_2()
   DEFINE l_name             LIKE type_file.chr20  
 
   CALL cl_del_data(l_table)                       

   DECLARE cr_curs CURSOR FOR 
    SELECT oea03, oea032, oea23, mm, vdate, vno,
           oea01, type, tc_nmg01,exp, zzysye,chysye,df,d,cf,c,
           pagenum,seq, azi04, azi05, azi07
     FROM cxmq115_tmp ORDER BY seq
     
   FOREACH cr_curs INTO g_pr.*
       EXECUTE insert_prep USING g_pr.*
   END FOREACH

   LET g_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED

   IF g_zz05='Y' THEN 
      CALL cl_wcchp(tm.wc,'oea03,oea01')
           RETURNING g_str 
   END IF
   LET g_str=g_str CLIPPED,";",tm.b,";",tm.c
   
   LET g_prog = 'cxmq115'
   
#   IF tm.b = 'N' THEN
       LET l_name = 'cxmq115'
#   ELSE
#       IF tm.c = 'Y' THEN           
#          LET l_name = 'cxmq115_2'  
#       ELSE                               
#          LET l_name = 'cxmq115_1'
#       END IF    
#   END IF
   CALL cl_prt_cs3('cxmq115',l_name,g_sql,g_str)   
   
   LET g_prog = 'cxmq115'
   
END FUNCTION


FUNCTION cxmq115_t()
   IF tm.b = 'Y' THEN
      CALL cl_set_comp_visible("df,d,cf,c",TRUE)
      CALL cl_getmsg("ggl-201",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("df",g_msg CLIPPED)
      CALL cl_getmsg("ggl-202",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("d",g_msg CLIPPED)
      CALL cl_getmsg("ggl-203",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("cf",g_msg CLIPPED)
      CALL cl_getmsg("ggl-204",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("c",g_msg CLIPPED)   
   ELSE
      CALL cl_set_comp_visible("df,cf",FALSE)
      CALL cl_getmsg("ggl-207",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("d",g_msg CLIPPED)
      CALL cl_getmsg("ggl-208",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("c",g_msg CLIPPED)     
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
   CALL cxmq115_cs()
END FUNCTION

FUNCTION q115_set_entry()

   CALL cl_set_comp_entry("c,curr",TRUE)

END FUNCTION

FUNCTION q115_set_no_entry()

   IF tm.b = 'N' THEN
      LET tm.c = 'N'
      LET tm.curr = NULL
      DISPLAY BY NAME tm.c,tm.curr
      CALL cl_set_comp_entry("c,curr",FALSE)
   END IF

END FUNCTION


