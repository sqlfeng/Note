# Prog. Version..: '5.30.18-15.05.12(00005)'     #
# Pattern name...: cxmr670.4gl
# Descriptions...: 出貨未簽收及出至境外倉尚未出貨明細表
# Date & Author..: 12/01/16 FUN-BC0022 By Sakura
# Modify.........: No:MOD-C20023 12/02/02 By Sakura 修改l_sql where條件
# Modify.........: NO:FUN-C30228 12/03/19 By Sakura 於條件選項-排序下方，增加"簽收截止日"欄位，當條件為1時
#                                                   所有簽收日期(oga02)大於截止日的資料也都要顯示
# Modify.........: No:TQC-DC0088 13/12/24 By Summer 傳接參數位置錯誤
# Modify.........: No:TQC-EB0007 14/11/13 By Hungli 將 SELECT oga011 FROM oga_file WHERE oga09 = '8' AND ogapost ='Y' 語法加上 oga011 IS NOT NULL
# Modify.........: No.0000685690_06_M024 16/03/03 By TSD.zhen 報表增加顯示6個欄位、QBE條件新增一欄位 客戶結帳日(occ38)
# Modify.........: No.0000685690_06_M029 16/07/12 By TSD.nick 報表增加顯示9個欄位
# Modify.........: No.0000685690_06_M044 16/10/26 By TSD.Chin 1.QBE查詢條件欄位增加 [簽收日期]、INPUT [報表類別]增加選項3.出貨已簽收明細表
#                                                             2.主報表增加欄位(業務姓名、訂單單號、規格、材質、參考數量/單位、幣別、對帳日、簽收單單號、帳單編號)
# Modify.........: add by lixwz 20170721 1、cxmr670查询窗口条件中添加“是否含销退”选项，勾选后将销退单也包含在对应逻辑中；
#                                                            2、cxmr670，添加出货已签收的逻辑；



DATABASE ds
GLOBALS "../../../tiptop/config/top.global"
   DEFINE tm  RECORD
              rtype  LIKE type_file.chr1, #報表類別
              wc     STRING,              #QBE
              s      LIKE type_file.chr3, #排序
              t      LIKE type_file.chr3, #跳頁
              u      LIKE type_file.chr3, #小計
              edate  LIKE type_file.dat,  #截止日 #FUN-C30228
              more   LIKE type_file.chr1  #其他特殊列印條件
             ,wc2    STRING               #M044 161026 By TSD.Chin
             ,oha     LIKE type_file.chr1 # add by lixwz 20170721
              END RECORD
DEFINE   l_table       STRING
DEFINE   l_str         STRING
DEFINE   g_sql         STRING
DEFINE   g_wc       STRING
DEFINE   g_wc2       STRING

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                # Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time

     LET g_sql =" oga02.oga_file.oga02,",
                " oga01.oga_file.oga01,",
                " oga03.oga_file.oga03,",
                " oga14.oga_file.oga14,",
                " oga15.oga_file.oga15,",
                " ogb04.ogb_file.ogb04,",
                " ogb06.ogb_file.ogb06,",
                " ima021.ima_file.ima021,",
                " ogb12.ogb_file.ogb12,",
                " ogb13.ogb_file.ogb13,",
                " ogb14t.ogb_file.ogb14t,",
                " oga24.oga_file.oga24,",
                " ogb13_1.ogb_file.ogb13,",
                " ogb14t_1.ogb_file.ogb14t,",
                " azi03.azi_file.azi03,",
                " azi04.azi_file.azi04,",
                " azi05.azi_file.azi05"
                #======0000685690_06_M024 160303 BY TSD.zhen======(S)
               #,",oga032.oga_file.oga032,",
               ,",occ18.occ_file.occ18,"    #add by nixiang 17/05/23
               ,",occ261.occ_file.occ261,"
               ,",occ271.occ_file.occ271,"
               ,",occ28.occ_file.occ28,"
               ,",oca02.oca_file.oca02,"
               ,",occ241.occ_file.occ241,"
               ,",occ231.occ_file.occ231,", #add by nixiang 17/05/24
                " ogb14.ogb_file.ogb14,",
                " ta_ogb01.ogb_file.ta_ogb01,",
                " tc_otn_str.type_file.chr1000 "
                #======0000685690_06_M024 160303 BY TSD.zhen======(E)
                #M029 160712 By TSD.nick ==========(s)
               ,",oea02.oea_file.oea02 "
               ,",azf03.azf_file.azf03 "
               ,",ta_ogb02.ogb_file.ta_ogb02 "
               ,",oeb910.oeb_file.oeb910 "
               ,",oeb912.oeb_file.oeb912 "
               ,",ogb910.ogb_file.ogb910 "
               ,",ogb912.ogb_file.ogb912 "
               ,",ogb916.ogb_file.ogb916 "
               ,",ogb917.ogb_file.ogb917 "
                #M029 160712 By TSD.nick ==========(e)
                #M044 161026 BY TSD.Chin ---add----------(S)
               ,",ogb03.ogb_file.ogb03"
               ,",gen02.gen_file.gen02"
               ,",ogb31.ogb_file.ogb31"
               ,",ta_ima01.ima_file.ta_ima01"
               ,",str2.type_file.chr50"
               ,",oga23.oga_file.oga23"
               ,",oga02a.oga_file.oga02"
               ,",oga01a.oga_file.oga01"
               ,",oga10.oga_file.oga10"
                #M044 161026 BY TSD.Chin ---add----------(E)

   LET l_table = cl_prt_temptable('cxmr670',g_sql) CLIPPED   # 產生Temp Table
   IF l_table = -1 THEN EXIT PROGRAM END IF                  # Temp Table產生
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?,?,?,?,?, ?,?,?,?,?,",
               #"        ?,?,?,?,?, ?,?)"   #0000685690_06_M024 160303 BY TSD.zhen Mark
               #"        ?,?,?,?,?, ?,?,?,?,?, ?)"   #0000685690_06_M024 160303 BY TSD.zhen Add #M029 160712 By TSD.nick mark
               #M029 160712 By TSD.nick =====(s)
               "        ?,?,?,?,?, ?,?,?,?,?,",
               "        ?,?,?,?,?, ?,?,?,?,? ",
               #"       ,?,?,?,?,?, ?,?,?,?   ",      #M044 161026 By TSD.Chin
               "       ,?,?,?,?,?, ?,?,?,?,?,",
               "       ?,?,?,?,?",
               "        )                    "
               #M029 160712 By TSD.nick =====(e)
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1) EXIT PROGRAM
   END IF

   LET g_pdate = ARG_VAL(1)        # Get arguments from command line
   LET g_towhom = ARG_VAL(2)
   LET g_rlang = ARG_VAL(3)
   LET g_bgjob = ARG_VAL(4)
   LET g_prtway =ARG_VAL(5)
   LET g_copies =ARG_VAL(6)
   LET tm.rtype =ARG_VAL(7)
   LET tm.wc = ARG_VAL(8)
  #TQC-DC0088 --start--
   LET tm.edate = ARG_VAL(9)
   LET tm.s  = ARG_VAL(10)
   LET tm.t  = ARG_VAL(11)
   LET tm.u  = ARG_VAL(12)
   LET g_rep_user = ARG_VAL(13)
   LET g_rep_clas = ARG_VAL(14)
   LET g_template = ARG_VAL(15)
   LET g_rpt_name = ARG_VAL(16)
   LET tm.wc2= ARG_VAL(17) #M044 161026 By TSD.Chin
   #M044 161028 By TSD.Tim---(S)
   LET tm.wc = cl_replace_str(tm.wc,"\\\"","'")
   LET tm.wc2 = cl_replace_str(tm.wc2,"\\\"","'")
   #M044 161028 By TSD.Tim---(E)
  #TQC-DC0088 --end--
  #TQC-DC0088 mark --start--
  #LET tm.s  = ARG_VAL(9)
  #LET tm.t  = ARG_VAL(10)
  #LET tm.u  = ARG_VAL(11)
  #LET g_rep_user = ARG_VAL(12)
  #LET g_rep_clas = ARG_VAL(13)
  #LET g_template = ARG_VAL(14)
  #LET g_rpt_name = ARG_VAL(15)
  #LET tm.edate = ARG_VAL(16) #FUN-C30228
  #TQC-DC0088 mark --end--

   IF cl_null(g_bgjob) OR g_bgjob = 'N'# If background job sw is off
      THEN CALL cxmr670_tm(0,0)        # Input print condition
      ELSE CALL cxmr670()              # Read data and create out-file
   END IF
   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION cxmr670_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01
DEFINE p_row,p_col    LIKE type_file.num5,
       l_cmd          LIKE type_file.chr1000,
       p_str            STRING

   LET p_row = 5 LET p_col = 17

   OPEN WINDOW cxmr670_w AT p_row,p_col WITH FORM "cxm/42f/cxmr670"
       ATTRIBUTE (STYLE = g_win_style CLIPPED)

    CALL cl_ui_init()

   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL # Default condition
   LET tm.rtype = '1'
   LET tm2.s1   = '1'
   LET tm2.s2   = '2'
   LET tm2.s3   = '3'
   LET tm2.u1   = 'N'
   LET tm2.u2   = 'N'
   LET tm2.u3   = 'N'
   LET tm2.t1   = 'N'
   LET tm2.t2   = 'N'
   LET tm2.t3   = 'N'
   LET tm.more  = 'N'
   LET tm.oha = "0" # add by lixwz 20170721
#FUN-C30228---add---START
   #M044 161026 BY TSD.Chin ---add----------(S)
   #IF tm.rtype = '1' THEN
   IF tm.rtype = '1' OR tm.rtype = '3' THEN
   #M044 161026 BY TSD.Chin ---add----------(E)
      LET g_pdate  = g_today
   ELSE
      CALL r670_set_no_entry()
   END IF
#FUN-C30228---add---END
   #LET g_pdate  = g_today #FUN-C30228 mark
   LET g_rlang  = g_lang
   LET g_bgjob  = 'N'
   LET g_copies = '1'
   LET tm.edate = g_today #FUN-C30228
WHILE TRUE
   INPUT BY NAME tm.rtype WITHOUT DEFAULTS

      BEFORE INPUT
         CALL cl_qbe_display_condition(lc_qbe_sn)
         CALL r670_set_entry() #FUN-C30228
         CALL r670_set_no_entry() #FUN-C30228
      BEFORE FIELD rtype #FUN-C30228
         CALL r670_set_entry() #FUN-C30228
      AFTER FIELD rtype
         IF cl_null(tm.rtype) THEN
            NEXT FIELD rtype
         END IF
         CALL r670_set_no_entry() #FUN-C30228

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      #M044 161028 By TSD.Tim---(S)
      ON ACTION controlg
         CALL cl_cmdask()
      #M044 161028 By TSD.Tim---(E)

      ON ACTION help
         CALL cl_show_help()

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT INPUT

      ON ACTION qbe_save
         CALL cl_qbe_save()

   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW cxmr670_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF

  DIALOG ATTRIBUTES(UNBUFFERED)   #M044 161026 By TSD.Chin
    CONSTRUCT BY NAME tm.wc ON oga01,oga02,oga03,oga14,oga15,occ38 #0000685690_06_M024 160303 BY TSD.zhen Add occ38

           BEFORE CONSTRUCT
               CALL cl_qbe_init()

    # M044 161026 BY TSD.Chin ---add----------(S)
   END CONSTRUCT


   CONSTRUCT BY NAME tm.wc2 ON oga02a
      BEFORE CONSTRUCT
          CALL cl_qbe_init()
   END CONSTRUCT
   #M044 161026 BY TSD.Chin ---add----------(E)


       ON ACTION CONTROLP
           CASE
              WHEN INFIELD(oga01)  #出貨單號
                CALL cl_init_qry_var()
                # mark by lixwz 20170721 s
                #LET g_qryparam.form = "q_oga8"
                #LET g_qryparam.state = 'c'
                #M044 161026 BY TSD.Chin ---add----------(S)
                #IF tm.rtype = '1' THEN
                # mark by lixwz 20170721 e
                IF tm.rtype = '1' OR tm.rtype = '3' THEN
                #M044 161026 BY TSD.Chin ---add----------(E)
                 # LET g_qryparam.where = " oga65='Y' and oga09='2' "
                   LET p_str = " oga65='Y' and oga09='2' "
                ELSE
                  #LET g_qryparam.where = " oga00='3' and oga09='2' "
                   LET p_str = " oga00='3' and oga09='2' "
                END IF
                #CALL cl_create_qry() RETURNING g_qryparam.multiret  # mark by lixwz 20170721

                CALL cq_oga01(1,1,g_plant,p_str) RETURNING g_qryparam.multiret # add by lixwz 20170721
                DISPLAY g_qryparam.multiret TO oga01
                NEXT FIELD oga01

              WHEN INFIELD(oga03)  #客戶編號
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_occ"
                LET g_qryparam.state = 'c'
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO oga03
                NEXT FIELD oga03

              WHEN INFIELD(oga14)   #業務員編號
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_gen"
                LET g_qryparam.state = 'c'
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO oga14
                NEXT FIELD oga14

              WHEN INFIELD(oga15)   #部門編號
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_gem"
                LET g_qryparam.state = 'c'
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO oga15
                NEXT FIELD oga15
           END CASE

       ON ACTION locale
         LET g_action_choice = "locale"
          CALL cl_show_fld_cont()
         #EXIT CONSTRUCT    #M044 161026 By TSD.Chin  mark
         EXIT DIALOG        #M044 161026 By TSD.Chin  add

     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        #CONTINUE CONSTRUCT  #M044 161026 By TSD.Chin  mark
        CONTINUE DIALOG      #M044 161026 By TSD.Chin  add

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION exit
         LET INT_FLAG = 1
         #EXIT CONSTRUCT   #M044 161026 By TSD.Chin  mark
         EXIT DIALOG       #M044 161026 By TSD.Chin  add

      #M044 161026 BY TSD.Chin ---add----------(S)
      ON ACTION accept
         #M044 161028 By TSD.Tim---(S)
         #EXIT DIALOG
         ACCEPT DIALOG
         #M044 161028 By TSD.Tim---(E)

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      #M044 161026 BY TSD.Chin ---add----------(E)

      ON ACTION qbe_select
         CALL cl_qbe_select()

  #END CONSTRUCT   #M044 161026 By TSD.Chin  mark
  END DIALOG       #M044 161026 By TSD.Chin  add

       IF g_action_choice = "locale" THEN
          LET g_action_choice = ""
          CALL cl_dynamic_locale()
          CONTINUE WHILE
       END IF


   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW cxmr670_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM

   END IF
   #M044 161026 BY TSD.Chin ---add----------(S)
   #IF tm.wc = ' 1=1' THEN
   IF tm.wc = ' 1=1' AND tm.wc2 = '1=1' THEN
   #M044 161026 BY TSD.Chin ---add----------(E)
      CALL cl_err('','9046',0) CONTINUE WHILE #本作業查詢條件不可空白!
   END IF
   DISPLAY BY NAME tm.more             # Condition
   #add by lixwz 20170720 s
   IF tm.rtype = '3'  THEN
      LET tm.edate = ''
   END IF
   # add by lixwz 20170720 e
   INPUT BY NAME tm.edate, #FUN-C30228
                 tm.oha,                  # add by lixwz 20170721
                 tm2.s1,tm2.s2,tm2.s3,
                 tm2.t1,tm2.t2,tm2.t3,
                 tm2.u1,tm2.u2,tm2.u3,
                 tm.more WITHOUT DEFAULTS

         BEFORE INPUT
             CALL cl_qbe_display_condition(lc_qbe_sn)

      AFTER FIELD more
         IF tm.more = 'Y'
            THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies)
                      RETURNING g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies
         END IF
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()
      ON ACTION CONTROLG CALL cl_cmdask()

      AFTER INPUT
         LET tm.s = tm2.s1[1,1],tm2.s2[1,1],tm2.s3[1,1]
         LET tm.t = tm2.t1,tm2.t2,tm2.t3
         LET tm.u = tm2.u1,tm2.u2,tm2.u3
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT INPUT

      ON ACTION qbe_save
         CALL cl_qbe_save()


   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW cxmr670_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF

   IF g_bgjob = 'Y' THEN
      SELECT zz08 INTO l_cmd FROM zz_file
             WHERE zz01='cxmr670'
      IF SQLCA.sqlcode OR l_cmd IS NULL THEN
         CALL cl_err('cxmr670','9031',1)
      ELSE
         LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
         LET tm.wc2=cl_replace_str(tm.wc2, "'", "\"")  #M044 161026 By TSD.Chin
         LET l_cmd = l_cmd CLIPPED,
                         " '",g_pdate CLIPPED,"'",
                         " '",g_towhom CLIPPED,"'",
                         " '",g_rlang CLIPPED,"'",
                         " '",g_bgjob CLIPPED,"'",
                         " '",g_prtway CLIPPED,"'",
                         " '",g_copies CLIPPED,"'",
                         " '",tm.rtype CLIPPED,"'",
                         " '",tm.wc CLIPPED,"'",
                        #" '",tm.wc2 CLIPPED,"'",      #M044 161026 By TSD.Chin #M044 161028 By TSD.Tim mark
                         " '",tm.edate CLIPPED,"'", #FUN-C30228
                         " '",tm.s CLIPPED,"'",
                         " '",tm.t CLIPPED,"'",
                         " '",tm.u CLIPPED,"'",
                         " '",g_rep_user CLIPPED,"'",
                         " '",g_rep_clas CLIPPED,"'",
                         " '",g_template CLIPPED,"'",
                         " '",g_rpt_name CLIPPED,"'"
                        ," '",tm.wc2 CLIPPED,"'"       #M044 161028 By TSD.Tim
         CALL cl_cmdat('cxmr670',g_time,l_cmd)
      END IF
      CLOSE WINDOW cxmr670_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF
   CALL cl_wait()
   CALL cxmr670()
   ERROR ""
END WHILE
   CLOSE WINDOW cxmr670_w
END FUNCTION

#FUN-C30228---add---START
FUNCTION r670_set_entry()
    CALL cl_set_comp_entry("edate",TRUE)
END FUNCTION

FUNCTION r670_set_no_entry()
   IF tm.rtype = '2' THEN
      CALL cl_set_comp_entry("edate",FALSE)
      LET tm.edate = ''
   ELSE
      LET tm.edate = g_today
   END IF
END FUNCTION
#FUN-C30228---add---END

FUNCTION cxmr670()
   DEFINE l_sql     STRING,
          sr              RECORD  oga02    LIKE oga_file.oga02,
                                  oga01    LIKE oga_file.oga01,
                                  oga03    LIKE oga_file.oga03,
                                  oga14    LIKE oga_file.oga14,
                                  oga15    LIKE oga_file.oga15,
                                  ogb04    LIKE ogb_file.ogb04,
                                  ogb06    LIKE ogb_file.ogb06,
                                  ima021   LIKE ima_file.ima021,
                                  ogb12    LIKE ogb_file.ogb12,
                                  ogb13    LIKE ogb_file.ogb13,
                                  ogb14t   LIKE ogb_file.ogb14t,
                                  oga24    LIKE oga_file.oga24,
                                  ogb13_1  LIKE ogb_file.ogb13,
                                  ogb14t_1 LIKE ogb_file.ogb14t,
                                  azi03    LIKE azi_file.azi03,
                                  azi04    LIKE azi_file.azi04,
                                  azi05    LIKE azi_file.azi05
                                  #M044 161026 BY TSD.Chin ---add----------(S)
                                 ,oga10    LIKE oga_file.oga10
                                 ,oga23    LIKE oga_file.oga23
                                 ,ogb03    LIKE ogb_file.ogb03
                                 ,ogb31    LIKE ogb_file.ogb31
                                 ,ogb05    LIKE ogb_file.ogb05
                                 ,ogb910   LIKE ogb_file.ogb910
                                 ,ogb912   LIKE ogb_file.ogb912
                                 ,ogb913   LIKE ogb_file.ogb913
                                 ,ogb915   LIKE ogb_file.ogb915
                                 ,ogb916   LIKE ogb_file.ogb916
                                  #M044 161026 BY TSD.Chin ---add----------(E)
                        END RECORD
   DEFINE l_ima021   LIKE ima_file.ima021,
          l_ogb13    LIKE ogb_file.ogb13,
          l_ogb14t   LIKE ogb_file.ogb14t,
          l_azi03    LIKE azi_file.azi03,
          l_azi04    LIKE azi_file.azi04,
          l_azi05    LIKE azi_file.azi05
   #======0000685690_06_M024 160303 BY TSD.zhen======(S)
   #DEFINE l_oga032   LIKE oga_file.oga032
   DEFINE l_occ18   LIKE occ_file.occ18   #add by nixiang 2017/05/23
   DEFINE l_occ261   LIKE occ_file.occ261
   DEFINE l_occ271   LIKE occ_file.occ271
   DEFINE l_occ28   LIKE occ_file.occ28
   DEFINE l_oca02   LIKE oca_file.oca02
   DEFINE l_occ241   LIKE occ_file.occ241
   DEFINE l_occ231   LIKE occ_file.occ231 #add by nixiang 2017/05/24

   DEFINE l_ogb14    LIKE ogb_file.ogb14
   DEFINE l_ta_ogb01 LIKE ogb_file.ta_ogb01
   DEFINE l_tc_otn04 LIKE tc_otn_file.tc_otn04
   DEFINE l_azf03    LIKE azf_file.azf03
   DEFINE l_inb01    LIKE inb_file.inb01
   DEFINE l_desc     LIKE type_file.chr1000
   #======0000685690_06_M024 160303 BY TSD.zhen======(S)
   #M029 160630 By TSD.nick =====(s)
   DEFINE l_oea02     LIKE oea_file.oea02        #訂單日期
   DEFINE l_azf03a    LIKE azf_file.azf03        #爐別
   DEFINE l_ta_ogb02  LIKE ogb_file.ta_ogb02     #備註
   DEFINE l_oeb910    LIKE oeb_file.oeb910       #銷售單位
   DEFINE l_oeb912    LIKE oeb_file.oeb912       #訂單數量
   DEFINE l_ogb910    LIKE ogb_file.ogb910       #出貨單位
   DEFINE l_ogb912    LIKE ogb_file.ogb912       #出貨數量
   DEFINE l_ogb916    LIKE ogb_file.ogb916       #計價單位
   DEFINE l_ogb917    LIKE ogb_file.ogb917       #計價數量
   DEFINE l_ogb31     LIKE ogb_file.ogb31        #訂單單號
   DEFINE l_ogb32     LIKE ogb_file.ogb32        #訂單項次
   DEFINE l_tc_cra03  LIKE tc_cra_file.tc_cra03  #爐型代碼
   DEFINE l_ta_inb01  LIKE inb_file.ta_inb01     #條件代碼
   #M029 160630 By TSD.nick =====(e)
   #M044 161026 BY TSD.Chin ---add----------(S)
   DEFINE l_gen02     LIKE gen_file.gen02,
          l_omb01     LIKE omb_file.omb01,
          l_ta_ima01  LIKE ima_file.ta_ima01,
          l_ima906    LIKE ima_file.ima906,
          l_str2      LIKE type_file.chr50,
          l_oga01a    LIKE oga_file.oga01,
          l_oga02     LIKE oga_file.oga02,
          l_oga02a    LIKE oga_file.oga02,
          l_ogb912a   STRING,
          l_ogb915    STRING,
          l_ogb12     LIKE ogb_file.ogb12,
          l_flag      LIKE type_file.chr1
   DEFINE l_ogb03a    LIKE ogb_file.ogb03  #M044 161028 By TSD.Tim
   DEFINE l_cnt       LIKE type_file.num5  #M044 161028 By TSD.Tim
   DEFINE l_wc        STRING

   LET l_flag = 'N'
   LET tm.wc2=cl_replace_str(tm.wc2, "oga02a", "oga02")
   #M044 161026 BY TSD.Chin ---add----------(E)


     CALL cl_del_data(l_table)
     SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang

     IF g_priv2='4' THEN                           #只能使用自己的資料
         LET tm.wc = tm.wc clipped," AND ogauser = '",g_user,"'"
     END IF
     IF g_priv3='4' THEN                           #只能使用相同群的資料
         LET tm.wc = tm.wc clipped," AND ogagrup MATCHES '",g_grup CLIPPED,"*'"
     END IF

     IF g_priv3 MATCHES "[5678]" THEN    #群組權限
         LET tm.wc = tm.wc clipped," AND ogagrup IN ",cl_chk_tgrup_list()
     END IF
     IF tm.rtype = '1' THEN
        LET l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    "       ogb13,ogb14t,oga24,'','',", #0000685690_06_M024 160303 BY TSD.zhen Add ,
                    "       azi03,azi04,azi05  ",
                    "      ,oga10,oga23,ogb03,ogb31                          ",   #M044 161026 By TSD.Chin
                    "      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",   #M044 161026 By TSD.Chin
                    #"      ,occ18,ogb14,ta_ogb01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
                    "      ,occ18,occ261,occ271,occ28,oca02,occ241,occ231,ogb14,ta_ogb01 ", #add by nixiang 17/05/24
                    "      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",   #M029 160712 By TSD.nick add
                    #"  FROM oga_file,ogb_file,azi_file ",  #0000685690_06_M024 160303 BY TSD.zhen Mark
                    #"  FROM oga_file,ogb_file,azi_file,occ_file ",  #0000685690_06_M024 160303 BY TSD.zhen Add
                    "  FROM oga_file,ogb_file,azi_file,occ_file,oca_file ",  #add by nixiang 17/05/24
                    " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
                    "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    "   AND oga03 = occ01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
                    "   AND occ03 = oca01 ", #add by nixiang 17/05/24
                    #M044 161026 BY TSD.Chin ---add----------(S)
                    #"   AND oga01 NOT IN (SELECT oga011 FROM oga_file WHERE oga09 = '8' AND ogapost ='Y' AND oga011 IS NOT NULL) ", #TQC-EB0007 add
                    #M044 161028 BY TSD.Tim mark---(S)
                    #"   AND oga01||ogb03 NOT IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL)",
                    #M044 161028 BY TSD.Tim mark---(E)
                    #M044 161026 BY TSD.Chin ---add----------(E)
                   #"   AND oga01 NOT IN (SELECT oga011 FROM oga_file WHERE oga09 = '8' AND ogapost ='Y') ", #MOD-C20023 add #TQC-EB0007 mark
                    #"   AND (oga01 NOT IN (SELECT oga01 FROM oga_file WHERE oga011 = oga01 AND oga09 = '8') ", #MOD-C20023 mark
                    #"     OR oga01 NOT IN (SELECT oga01 FROM oga_file WHERE oga011 = oga01 AND oga09 = '8' AND ogapost ='N' ))", #MOD-C20023 mark
                    "   AND ",tm.wc
                  #FUN-C30228---Start--add
                    #M044 161026 BY TSD.Chin ---add----------(S)
                    #IF NOT cl_null(tm.edate) THEN
#                    IF NOT cl_null(tm.edate) OR NOT cl_null(tm.wc2) THEN
#                    #M044 161026 BY TSD.Chin ---add----------(E)
#                       LET l_sql = l_sql,
#                           " UNION ",
#                           "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
#                           "       ogb13,ogb14t,oga24,'','',",  #0000685690_06_M024 160303 BY TSD.zhen Add ,
#                           "       azi03,azi04,azi05  ",
#                           "      ,oga10,oga23,ogb03,ogb31                          ",   #M044 161026 By TSD.Chin
#                           "      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",   #M044 161026 By TSD.Chin
#                           "      ,oga032,ogb14,ta_ogb01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
#                           "      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",   #M029 160712 By TSD.nick add
#                           #"  FROM oga_file,ogb_file,azi_file ",  #0000685690_06_M024 160303 BY TSD.zhen Mark
#                           "  FROM oga_file,ogb_file,azi_file,occ_file ",  #0000685690_06_M024 160303 BY TSD.zhen Add
#                           " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
#                           "   AND ogaconf ='Y' AND ogapost ='Y' ",
#                           "   AND oga03 = occ01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
#                           #"   AND oga01 IN (SELECT oga011 FROM oga_file WHERE oga09 = '8' AND oga02 > '",tm.edate,"')", #M044 161026 BY TSD.Chin mark
#                           "   AND ",tm.wc
#                           #M044 161026 BY TSD.Chin ---add----------(S)
#                           IF NOT cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
#                               LET l_sql = l_sql ," AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND oga02 > '",tm.edate,"' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL AND ",tm.wc2,")"
#                           END IF
#                           IF NOT cl_null(tm.edate) AND cl_null(tm.wc2) THEN
#                               LET l_sql = l_sql ," AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND oga02 > '",tm.edate,"' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL )"
#                           END IF
#                           IF cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
#                               LET l_sql = l_sql ," AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL AND ",tm.wc2,")"
#                           END IF
#                           #M044 161026 BY TSD.Chin ---add----------(E)
#                    END IF
                  #FUN-C30228---End---add
     #M044 161026 BY TSD.Chin ---add----------(S)
     END IF
     # add by lixwz 20170720 s
     IF tm.rtype = '3' THEN
        LET l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    "       ogb13,ogb14t,oga24,'','',",
                    "       azi03,azi04,azi05  ",
                    "      ,oga10,oga23,ogb03,ogb31                          ",
                    "      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",
                    #"      ,oga032,ogb14,ta_ogb01 ",
                    #"      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",
                    #####
                    "      ,occ18,occ261,occ271,occ28,oca02,occ241,occ231,ogb14,ta_ogb01 ", #add by nixiang 17/05/24
                    "      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",   #M029 160712 By TSD.nick add
                    "  FROM oga_file,ogb_file,azi_file,occ_file,oca_file ",
                    " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
                    "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    "   AND oga03 = occ01 ",
                    "   AND occ03 = oca01 ",
                    "   AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL"
                           IF NOT cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND oga02 > '",tm.edate,"' AND ",tm.wc2,")"
                           END IF
                           IF NOT cl_null(tm.edate) AND cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND oga02 > '",tm.edate,"')"
                           END IF
                           IF cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND ",tm.wc2,")"
                           END IF
                     LET l_sql = l_sql,
                    "   AND ",tm.wc
                    #IF NOT cl_null(tm.edate) OR NOT cl_null(tm.wc2) THEN
                    #   LET l_sql = l_sql,
                    #       " AND oga01||ogb03 IN(",
                    #       "SELECT oga01||ogb03 ",
                    #      #" UNION ",
                    #      #"SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    #      #"       ogb13,ogb14t,oga24,'','',",
                    #      #"       azi03,azi04,azi05  ",
                    #      #"      ,oga10,oga23,ogb03,ogb31                          ",
                    #      #"      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",
                    #      #"      ,oga032,ogb14,ta_ogb01 ",
                    #      #"      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",
                    #       "  FROM oga_file,ogb_file,azi_file,occ_file ",
                    #       " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
                    #       "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    #       "   AND oga03 = occ01 ",
                    #       "   AND ",tm.wc
     END IF
     # add by lixwz 20170720 e
{     IF tm.rtype = '3' THEN
        LET l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    "       ogb13,ogb14t,oga24,'','',",
                    "       azi03,azi04,azi05  ",
                    "      ,oga10,oga23,ogb03,ogb31                          ",
                    "      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",
                    "      ,oga032,ogb14,ta_ogb01 ",
                    "      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",
                    "  FROM oga_file,ogb_file,azi_file,occ_file ",
                    " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
                    "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    "   AND oga03 = occ01 ",
                    "   AND oga01||ogb03 IN (SELECT ogb66||ogb67 FROM ogb_file,oga_file WHERE oga01 = ogb01 and oga09 = '8' AND ogapost = 'Y' AND ogb66 IS NOT NULL AND ogb67 IS NOT NULL"
                           IF NOT cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND oga02 > '",tm.edate,"' AND ",tm.wc2,")"
                           END IF
                           IF NOT cl_null(tm.edate) AND cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND oga02 > '",tm.edate,"')"
                           END IF
                           IF cl_null(tm.edate) AND NOT cl_null(tm.wc2) THEN
                               LET l_sql = l_sql ," AND ",tm.wc2,")"
                           END IF
                     LET l_sql = l_sql,
                    "   AND ",tm.wc
                    #IF NOT cl_null(tm.edate) OR NOT cl_null(tm.wc2) THEN
                    #   LET l_sql = l_sql,
                    #       " AND oga01||ogb03 IN(",
                    #       "SELECT oga01||ogb03 ",
                    #      #" UNION ",
                    #      #"SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    #      #"       ogb13,ogb14t,oga24,'','',",
                    #      #"       azi03,azi04,azi05  ",
                    #      #"      ,oga10,oga23,ogb03,ogb31                          ",
                    #      #"      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",
                    #      #"      ,oga032,ogb14,ta_ogb01 ",
                    #      #"      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",
                    #       "  FROM oga_file,ogb_file,azi_file,occ_file ",
                    #       " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga65 ='Y' AND oga09 ='2' ",
                    #       "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    #       "   AND oga03 = occ01 ",
                    #       "   AND ",tm.wc
     END IF
     #M044 161026 BY TSD.Chin ---add----------(E)

     #M044 161026 BY TSD.Chin ---add----------(S)
     #ELSE
     IF tm.rtype = '2' THEN
     #M044 161026 BY TSD.Chin ---add----------(E)
        LET l_sql = "SELECT oga02,oga01,oga03,oga14,oga15,ogb04,ogb06,'',ogb12, ",
                    "       ogb13,ogb14t,oga24,'','',",  #0000685690_06_M024 160303 BY TSD.zhen Add ,
                    "       azi03,azi04,azi05  ",
                    "      ,oga10,oga23,ogb03,ogb31                          ",   #M044 161026 By TSD.Chin
                    "      ,ogb05,ogb910,ogb912,ogb913,ogb915,ogb916         ",   #M044 161026 By TSD.Chin
                    "      ,oga032,ogb14,ta_ogb01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
                    "      ,ogb31,ogb32,ogb910,ogb912,ogb916,ogb917,ta_ogb02 ",   #M029 160712 By TSD.nick add
                    #"  FROM oga_file,ogb_file,azi_file ",  #0000685690_06_M024 160303 BY TSD.zhen Mark
                    "  FROM oga_file,ogb_file,azi_file,occ_file ",  #0000685690_06_M024 160303 BY TSD.zhen Add
                    " WHERE oga01 = ogb01 AND oga23 = azi01 AND oga00 ='3' AND oga09 ='2' ",
                    "   AND ogaconf ='Y' AND ogapost ='Y' ",
                    "   AND oga03 = occ01 ", #0000685690_06_M024 160303 BY TSD.zhen Add
                   #TQC-EB0007 mark start ------
                   #"   AND (oga01 NOT IN (SELECT oea01 FROM oea_file,oga_file WHERE oea00 = '4' AND oea11 = '7' AND oea12 = oga01) ",
                   #"     OR oga01 NOT IN (SELECT oea01 FROM oea_file,oeb_file,oga_file WHERE oea01= oeb01 ",
                   #TQC-EB0007 mark   end ------
                   #TQC-EB0007 add  start ------
                    "   AND (oga01 NOT IN (SELECT oea01 FROM oea_file,oga_file WHERE oea00 = '4' AND oea11 = '7' AND oea12 = oga01 AND oea01 IS NOT NULL) ",
                    "     OR oga01 NOT IN (SELECT oea01 FROM oea_file,oeb_file,oga_file WHERE oea01= oeb01 AND oea01 IS NOT NULL",
                   #TQC-EB0007 add    end ------
                    "                      AND oea12=oga01 AND (oeb12-oeb24+oeb25-oeb26)>0 AND oeb70 <> 'Y') ",
                    "     OR ogb12<>(SELECT SUM(oeb12) FROM oea_file,oeb_file,oga_file WHERE oea00='4' AND oea11='7' AND oea12=oga01 AND oea01= oeb01))",
                    "   AND ",tm.wc
     END IF
}
     # add by lixwz 20170721 s
     IF tm.oha = '1' THEN
         LET l_wc =cl_replace_str(tm.wc,"oga","oha")

         LET l_sql=l_sql ,
                    " union SELECT oha02,oha01,oha03,oha14,oha15,ohb04,ohb06,'',ohb12,",
                    " ohb13,ohb14t,oha24,'','',",
                    " azi03,azi04,azi05,",
                    " oha10,oha23,ohb03,ohb31,",
                    " ohb05,ohb910,ohb912,ohb913,ohb915,ohb916",
                    "      ,occ18,occ261,occ271,occ28,oca02,occ241,occ231,ohb14,'' ", #add by nixiang 17/05/24
                    "      ,ohb31,ohb32,ohb910,ohb912,ohb916,ohb917,''",
                    " FROM oha_file,ohb_file,azi_file,occ_file,oca_file",
                    "  WHERE   oha01=ohb01 and oha23=azi01 and oha03=occ01  AND occ03 = oca01  AND ",l_wc
     END IF
     # add by lixwz 20170721 e

     PREPARE cxmr670_prepare1 FROM l_sql
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE cxmr670_curs1 CURSOR FOR cxmr670_prepare1

     #======0000685690_06_M024 160303 BY TSD.zhen======(S)
     LET l_sql = "SELECT tc_otn04,azf03 FROM tc_otn_file,azf_file ",
                 " WHERE tc_otn01 = ? ",
                 "   AND azf01 = tc_otn03 AND azf09 = 'R' ",
                 " ORDER BY tc_otn03 "
     PREPARE r670_tc_otn_p FROM l_sql
     DECLARE r670_tc_otn_c CURSOR FOR r670_tc_otn_p
     #======0000685690_06_M024 160303 BY TSD.zhen======(E)

     #M044 161028 By TSD.Tim---(S)
     LET l_sql = "SELECT DISTINCT oga01,oga02",
                 "  FROM oga_file,ogb_file",
                 " WHERE oga01 = ogb01 ",
                 "   AND (ogb67 = ? AND  ogb66  = ? )",
                 "   AND oga09 = '8'",
                 "   AND oga01 = ogb01",
                 "   AND ogaconf <> 'X'"
     IF tm.rtype = '1' THEN
        LET l_sql = l_sql,
                    " AND ogapost = 'N' "
        IF tm.wc2 <> ' 1=1' THEN
           LET l_sql = l_sql,
                    " AND ", tm.wc2 CLIPPED
        END IF
        IF NOT cl_null(tm.edate) THEN
          LET l_sql = l_sql ,
                      " AND oga02 > '",tm.edate,"' "
        END IF
     END IF
     IF tm.rtype = '3' THEN
        LET l_sql = l_sql,
                    " AND ogapost = 'Y' ",
                    " AND ", tm.wc2 CLIPPED
     END IF
     LET l_sql = l_sql,
                 " ORDER BY oga01"
     PREPARE r670_n_p1 FROM l_sql
     DECLARE r670_n_cur1 CURSOR FOR r670_n_p1

     LET l_sql = "SELECT ogb03 ",
                 "  FROM ogb_file,oga_file ",
                 " WHERE oga01 = ogb01 ",
                 "   AND (ogb67 = ? AND  ogb66  = ? )",
                 "   AND oga01 = ? ",
                 " ORDER BY ogb01 "
     PREPARE r670_n_p2 FROM l_sql
     DECLARE r670_n_cur2 CURSOR FOR r670_n_p2

     LET l_sql = "SELECT DISTINCT omb01",
                 "  FROM omb_file,oma_file",
                 " WHERE omb01 = oma01",
                 "   AND omb31 = ? ",
                 "   AND omb32 = ? ",  #M044 161028 By TSD.Tim
                 "   AND omavoid = 'N'"    #不可作廢
     PREPARE r670_p5 FROM l_sql
     DECLARE r670_cur5  CURSOR FOR r670_p5
     #M044 161028 By TSD.Tim---(E)

     #FOREACH cxmr670_curs1 INTO sr.*  #0000685690_06_M024 160303 BY TSD.zhen Mark
     #FOREACH cxmr670_curs1 INTO sr.*,l_occ18,l_ogb14,l_ta_ogb01  #0000685690_06_M024 160303 BY TSD.zhen Add
                               #M029 160712 By TSD.nick ======(s)
                               #  l_oga032,l_ogb14,l_ta_ogb01
       FOREACH cxmr670_curs1 INTO sr.*,l_occ18,l_occ261,l_occ271,l_occ28,l_oca02,l_occ241,l_occ231,l_ogb14,l_ta_ogb01
                                   #add by nixiang 17/05/24
                              ,l_ogb31,l_ogb32,l_ogb910,l_ogb912,l_ogb916
                                   ,l_ogb917,l_ta_ogb02
                                   #M029 160712 By TSD.nick ======(e)
         IF SQLCA.sqlcode != 0 THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF
       #M029 160712 By TSD.nick ======(s)
       LET l_oea02 = ''
       SELECT oea02
         INTO l_oea02
         FROM oea_file
        WHERE oea01 = l_ogb31   #訂單單號

       LET l_ta_inb01 = ''
       SELECT ta_inb01
         INTO l_ta_inb01
         FROM inb_file
        WHERE ta_inb04 = l_ta_ogb01   #收料單號

       LET l_tc_cra03 = ''
       SELECT tc_cra03
         INTO l_tc_cra03
         FROM tc_cra_file
        WHERE tc_cra01 = l_ta_inb01   #條件代碼

       LET l_azf03a = ''
       SELECT azf03
         INTO l_azf03a
         FROM azf_file
        WHERE azf01 = l_tc_cra03   #爐型代碼
          AND azf02 = '2'          #2:理由碼
          AND azf09 = 'L'          #L:爐型代號

       LET l_oeb910 = ''
       LET l_oeb912 = ''
       SELECT oeb910,oeb912
         INTO l_oeb910,l_oeb912
         FROM oeb_file
        WHERE oeb01 = l_ogb31   #訂單單號
          AND oeb03 = l_ogb32    #訂單項次
       IF cl_null(l_oeb912) THEN LET l_oeb912=0 END IF
       #M029 160712 By TSD.nick ======(e)

      #M044 161026 BY TSD.Chin ---add----------(S)
      #SELECT ima021 INTO l_ima021 FROM ima_file
      #M044 161028 BY TSD.Tim ---add----------(S)
      LET l_ima021 = NULL
      LET l_ima906 = NULL
      LET l_ta_ima01 = NULL
      #M044 161028 BY TSD.Tim ---add----------(E)
      SELECT ima021,ima906,ta_ima01
        INTO l_ima021,l_ima906,l_ta_ima01
        FROM ima_file
      #M044 161026 BY TSD.Chin ---add----------(E)
       WHERE ima01=sr.ogb04
      IF cl_null(sr.ogb13)  THEN LET sr.ogb13  = 0 END IF
      IF cl_null(sr.oga24)  THEN LET sr.oga24  = 0 END IF
      IF cl_null(sr.ogb14t) THEN LET sr.ogb14t = 0 END IF
      IF cl_null(sr.oga24)  THEN LET sr.oga24  = 0 END IF
      IF cl_null(l_ogb14)  THEN LET l_ogb14  = 0 END IF  #0000685690_06_M024 160303 BY TSD.zhen Add
      LET l_ogb13 = sr.ogb13 * sr.oga24
      LET l_ogb14t = sr.ogb14t * sr.oga24

      #======0000685690_06_M024 160303 BY TSD.zhen======(S)
      SELECT inb01 INTO l_inb01 FROM inb_file
       WHERE ta_inb04 = l_ta_ogb01

      LET l_azf03 = NULL
      LET l_tc_otn04 = NULL
      LET l_desc = NULL
      FOREACH r670_tc_otn_c USING l_inb01 INTO l_tc_otn04,l_azf03
         IF STATUS THEN
            EXIT FOREACH
         END IF
         IF cl_null(l_desc) THEN
            LET l_desc = l_azf03 CLIPPED," ",l_tc_otn04 CLIPPED
         ELSE
            #M044 161028 By TSD.Tim---(S)
            #LET l_desc = l_desc CLIPPED,l_azf03 CLIPPED," ",l_tc_otn04 CLIPPED
            LET l_desc = l_desc CLIPPED,ASCII(13),l_azf03 CLIPPED," ",l_tc_otn04 CLIPPED
            #M044 161028 By TSD.Tim---(E)
         END IF
      END FOREACH
      #======0000685690_06_M024 160303 BY TSD.zhen======(E)

      #M044 161026 BY TSD.Chin ---add-------(S)
      LET l_gen02 = ''
      SELECT gen02
        INTO l_gen02
        FROM gen_file
       WHERE gen01 = sr.oga14

      LET l_str2 = ""
      IF g_sma.sma115 = "Y" THEN
         CASE l_ima906
            WHEN "2"
               CALL cl_remove_zero(sr.ogb915) RETURNING l_ogb915
               LET l_str2 = l_ogb915 , sr.ogb913 CLIPPED
               IF cl_null(sr.ogb915) OR sr.ogb915 = 0 THEN
                   CALL cl_remove_zero(sr.ogb912) RETURNING l_ogb912a
                   LET l_str2 = l_ogb912a, sr.ogb910 CLIPPED
               ELSE
                  IF NOT cl_null(sr.ogb912) AND sr.ogb912 > 0 THEN
                     CALL cl_remove_zero(sr.ogb912) RETURNING l_ogb912a
                     LET l_str2 = l_str2 CLIPPED,',',l_ogb912a, sr.ogb910 CLIPPED
                  END IF
               END IF
            WHEN "3"
               IF NOT cl_null(sr.ogb915) AND sr.ogb915 > 0 THEN
                   CALL cl_remove_zero(sr.ogb915) RETURNING l_ogb915
                   LET l_str2 = l_ogb915 , sr.ogb913 CLIPPED
               END IF
            OTHERWISE EXIT CASE
         END CASE
      END IF
      IF g_sma.sma116 MATCHES '[23]' THEN
         IF sr.ogb05  <> sr.ogb916 THEN
            CALL cl_remove_zero(sr.ogb12) RETURNING l_ogb12
            LET l_str2 = l_str2 CLIPPED,"(",l_ogb12,sr.ogb05 CLIPPED,")"
         END IF
      END IF

      #M044 161028 By TSD.Tim mark---(S)
      #LET l_sql = "SELECT DISTINCT oga01,oga02",
      #            "  FROM oga_file,ogb_file",
      #            " WHERE (ogb67 = ? AND  ogb66  = ? )",
      #            "   AND oga09 = '8'",
      #            "   AND oga01 = ogb01",
      #            "   AND ogaconf <> 'X'",
      #            "   AND ", tm.wc2 CLIPPED,
      #            " ORDER BY oga01"
      #PREPARE r670_p1 FROM l_sql
      #DECLARE r670_n_cur1 CURSOR FOR r670_p1
      #LET l_sql = "SELECT DISTINCT omb01",
      #            "  FROM omb_file,oma_file",
      #            " WHERE omb01 = oma01",
      #            "   AND omb31 = ? ",
      #            "   AND omavoid = 'N'"    #不可作廢
      #PREPARE r670_p5 FROM l_sql
      #DECLARE r670_cur5  CURSOR FOR r670_p5
      #M044 161028 By TSD.Tim mark---(E)
      #M044 161028 By TSD.Tim---(S)
      LET l_flag = 'N'
      LET l_cnt = 0
      SELECT COUNT(*)
        INTO l_cnt
        FROM ogb_file,oga_file
       WHERE oga01 = ogb01
         AND oga09 = '8'
         AND ogb66 = sr.oga01
         AND ogb67 = sr.ogb03
         AND ogaconf <> 'X'
      #M044 161028 By TSD.Tim---(E)
      LET l_oga01a = NULL
      LET l_oga02a = NULL
      LET sr.oga10 = NULL
      FOREACH r670_n_cur1 USING sr.ogb03 , sr.oga01 INTO l_oga01a,l_oga02a
         LET l_flag = 'Y'
         IF SQLCA.sqlcode THEN
            CALL cl_err('foreach cxmr670_n_cur1:',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF

        #M044 161028 By TSD.Tim---(S)
        FOREACH r670_n_cur2 USING sr.ogb03,sr.oga01,l_oga01a
                             INTO l_ogb03a
         IF SQLCA.sqlcode THEN
            CALL cl_err('foreach cxmr670_n_cur2:',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF
        #M044 161028 By TSD.Tim---(E)

         #M044 161028 By TSD.Tim---(S)
         #FOREACH r670_cur5 USING l_oga01a INTO l_omb01
         FOREACH r670_cur5 USING l_oga01a,l_ogb03a
                            INTO l_omb01
         #M044 161028 By TSD.Tim---(E)
            IF SQLCA.sqlcode THEN
               CALL cl_err('foreach cxmr670_cur5:',SQLCA.sqlcode,1)
               EXIT FOREACH
            END IF
            IF cl_null(sr.oga10) THEN
               LET sr.oga10 = l_omb01
            ELSE
               LET sr.oga10 = sr.oga10,"\n",l_omb01
            END IF
         END FOREACH
       #M044 161028 By TSD.Tim---(S)
       END FOREACH
       #M044 161028 By TSD.Tim---(E)
      #M044 161026 BY TSD.Chin ---add-------(E)

      EXECUTE insert_prep USING sr.oga02 ,sr.oga01 ,sr.oga03,sr.oga14,sr.oga15,
                                sr.ogb04 ,sr.ogb06 ,l_ima021,sr.ogb12,
                                sr.ogb13 ,sr.ogb14t,sr.oga24,
                                l_ogb13  ,l_ogb14t ,
                                sr.azi03 ,sr.azi04 ,sr.azi05
                               #,l_occ18 ,l_ogb14  ,l_ta_ogb01,l_desc  #0000685690_06_M024 160303 BY TSD.zhen Add
                               #M029 160712 By TSD.nick ====(s)
                               ,l_occ18 ,l_occ261,l_occ271,l_occ28,l_oca02,l_occ241,l_occ231,l_ogb14  ,l_ta_ogb01,l_desc
                               #add by nixiang 17/05/24
                               ,l_oea02,l_azf03a,l_ta_ogb02,l_oeb910,l_oeb912
                               ,l_ogb910,l_ogb912,l_ogb916,l_ogb917
                               #M029 160712 By TSD.nick ====(e)
                               #M044 161026 By TSD.Chin ---add-------(S)
                               ,sr.ogb03,l_gen02,sr.ogb31,l_ta_ima01,l_str2,sr.oga23,l_oga02a,l_oga01a,sr.oga10
                               #M044 161026 By TSD.Chin ---add-------(E)
      #M044 161026 By TSD.Chin ---add-------(S)
      END FOREACH  #M044 161026 By TSD.Chin
      #M044 161028 By TSD.Tim---(S)
      IF l_flag = 'N' AND l_cnt > 0 AND tm.rtype = '1' THEN
         #有該出貨單+項次之簽收單資料，但沒有存在未簽收時，則不顯示
         CONTINUE FOREACH
      END IF
      #M044 161028 By TSD.Tim---(S)
      IF l_flag = 'N' THEN
         EXECUTE insert_prep USING sr.oga02 ,sr.oga01 ,sr.oga03,sr.oga14,sr.oga15,
                          sr.ogb04 ,sr.ogb06 ,l_ima021,sr.ogb12,
                          sr.ogb13 ,sr.ogb14t,sr.oga24,
                          l_ogb13  ,l_ogb14t ,
                          sr.azi03 ,sr.azi04 ,sr.azi05
                         #,l_occ18 ,l_ogb14  ,l_ta_ogb01,l_desc
                         ,l_occ18 ,l_occ261,l_occ271,l_occ28,l_oca02,l_occ241,l_occ231,l_ogb14  ,l_ta_ogb01,l_desc
                         #add by nixiang 17/05/24
                         ,l_oea02,l_azf03a,l_ta_ogb02,l_oeb910,l_oeb912
                         ,l_ogb910,l_ogb912,l_ogb916,l_ogb917
                         #M044 161028 By TSD.Tim---(S)
                         #,sr.ogb03,l_gen02,sr.ogb31,l_ta_ima01,l_str2,sr.oga23,l_oga02a,l_oga01a,sr.oga10
                         ,sr.ogb03,l_gen02,sr.ogb31,l_ta_ima01,l_str2,sr.oga23,'','',''
                         #M044 161028 By TSD.Tim---(E)
      END IF
      #M044 161026 By TSD.Chin ---add-------(E)
     END FOREACH

     SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = 'cxmr670'
     IF g_zz05 = 'Y' THEN
         CALL cl_wcchp(tm.wc,'oga01,oga02,oga03,oga14,oga15,occ38')  #0000685690_06_M024 160303 BY TSD.zhen Add occ38
              RETURNING tm.wc
     END IF

     SELECT azi04,azi05,azi03 INTO l_azi04,l_azi05,l_azi03 FROM azi_file WHERE azi01 = g_aza.aza17

     LET l_sql=" SELECT * FROM ",g_cr_db_str CLIPPED,l_table clipped
     PREPARE cxmr670_preparet FROM l_sql
     IF SQLCA.sqlcode THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     LET l_str = tm.t[1,1],";",tm.t[2,2],";",tm.t[3,3],";",
                 tm.u[1,1],";",tm.u[2,2],";",tm.u[3,3],";",
                 tm.wc CLIPPED,";",tm.s[1,1],";",tm.s[2,2],";",tm.s[3,3],";",
                 l_azi04,";",l_azi05,";",l_azi03

     CALL cl_prt_cs3('cxmr670','cxmr670',l_sql,l_str)
END FUNCTION
#FUN-BC0022
