# Prog. Version..: '5.30.06-13.03.12(00010)'     #
#
# Pattern name...: axcr360.4gl
# Descriptions...: 成本計算前勾稽作業
# Input parameter:
# Return code....:
# Date & Author..: 98/05/31 By Aladin Chu
# Modify.........: No:8741 03/11/25 By Melody 加上勾稽項目
#                          1.單據別設定的合理性(for退料單的成會分類)
#                          2.ima131 is null
# Modify.........: No:9640 04/07/20 By Carol 在檢查單頭、單身請款金額不合時，應增加判斷檢查單身 apb29=3
#                                            時，需以負值進行加總，否則會造成判斷不正確
# Modify.........: No.MOD-4A0238 04/10/18 By Smapmin 放寬ima02
# Modify.........: No.FUN-4C0099 04/12/30 By kim 報表轉XML功能
# Modify.........: No.MOD-520066 05/02/23 By kim 中文訊息納入zaa
# Modify.........: No.MOD-530181 05/03/23 By kim Define金額單價位數改為DEC(20,6)
# Modify.........: No.MOD-530394 05/04/4 By pengu 資料未依QBE條件產生
# Modify.........: No.FUN-550025 05/05/16 By vivien 單據編號格式放大
# Modify.........: No.FUN-570240 05/07/25 By yoyo 料件編號欄位加controlp
# Modify.........: No.MOD-590014 05/09/05 By Rosayu 組sql時要串連ima_file
# Modify.........: No.FUN-620001 06/02/06 By Claire 成本單據但轉出/入倉庫非成本倉
# Modify.........: No.FUN-670098 06/07/24 By rainy 排除不納入成本計算倉庫
# Modify.........: No.FUN-680122 06/09/01 By zdyllq 類型轉換
# Modify.........: No.FUN-690125 06/10/16 By dxfwo cl_used位置調整及EXIT PROGRAM后加cl_used
# Modify.........: No.FUN-6A0146 06/10/26 By bnlent l_time轉g_time
# Modify.........: No.MOD-6C0144 06/12/26 By rainy 入庫與請款匹配檢查改為rvv87
# Modify.........: No.TQC-720032 07/03/01 By johnray 修正期別檢核方式
# Modify.........: No.MOD-720075 07/04/11 By pengu chk_sfa05 CURSOR應判斷工單成會結案日為空白或計算當月的結案日才算
# Modify.........: No.TQC-750022 07/05/10 By arman 制表日期與報表名稱所在的行數顛倒
# Modify.........: No.FUN-750115 07/06/15 By sherry 報表改由Crystal Report輸出
# Modify.........: No.FUN-760085 07/07/18 By sherry 報表增加打印條件
# Modify.........: No.TQC-7C0173 07/12/28 By xufeng 成本計算前勾稽時，已立暫估的入庫單仍顯示“入庫與請款未匹配”
# Modify.........: No.TQC-840066 08/04/28 By Mandy AXD系統欲刪,原使用 AXD 模組相關欄位的程式進行調整
# Modify.........: No.MOD-860081 08/06/09 By jamie ON IDLE問題
# Modify.........: No.MOD-840619 08/07/10 By Pengu 在算應收帳款時若有倉退金額時則資料會異常
# Modify.........: No.FUN-850109 08/07/15 By sherry 增加畫面勾選項無標准工時列印否/無產品分類列印否
# Modify.........: No.MOD-870198 08/07/16 By kim l_smyslip在使用前未給值造成程式無法使用這變數
# Modify.........: No.MOD-8B0113 08/11/14 By Pengu 檢核工單工時檔時應加判斷已作廢工單有報工資料
# Modify.........: No.MOD-8B0112 08/11/14 By Pengu 檢核有入庫/退貨單(rvu_file,rvv_file)但未匹配應排出樣品入庫
# Modify.........: No.MOD-8C0299 09/02/02 By Pengu 排除MISC料件的勾稽
# Modify.........: No.MOD-920179 09/02/13 By chenl 修正TQC-7C0173
# Modify.........: No.MOD-8C0117 09/02/23 By liuxqa 將在aapt110中立賬的入庫和倉退分開來考慮
# Modify.........: No.MOD-920305 09/02/24 By claire 檢查tlf_file,但無工單編號,應重新取料號
# Modify.........: No.CHI-910019 09/05/20 By Pengu 部份的退貨折讓成本會無法抓取到AP的金額因程式段只抓apa58=2
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.TQC-990030 09/09/08 By sherry 勾選無標准工時打印時，品名無法打印
# Modify.........: No.FUN-9C0073 10/01/12 By chenls 程序精簡
# Modify.........: No:MOD-A10056 10/01/13 By Pengu 工時的判斷應加上ccj051、ccj07及ccj071不等0
# Modify.........: No:MOD-A40069 10/04/16 By Sarah 檢核有入庫/退貨單但未匹配段,不需將apa58='3'的資料納入
# Modify.........: No:TQC-A40139 10/05/04 By Carrier 1.MOD-A40044/FUN-9A0041追单
# Modify.........: No:CHI-A10009 10/05/11 By Summer 1.在UI畫面增加"工單主件成本階數小於或等於元件是否列印"的選項
#                                                   2.當勾此選項時報表才列印出工單主件成本階數小於或等於元件的資料，反之則不列印
# Modify.........: No:MOD-A70024 10/07/06 By Sarah 若差異處理是5.沖期初開帳的暫估時,應付單頭金額除了抓apa31-apa60外需再扣掉api_file裡的api05
# Modify.........: No:MOD-A80062 10/08/09 By sabrina axcr360()CURSOR chk_c/chk_sfa05/chk_wo/chk_wosfa少串了tm.wc條件
# Modify.........: No:MOD-A10054 10/11/25 By sabrina 調整FUN-9A0041的修改
# Modify.........: No:MOD-B20067 11/02/16 By sabrina 擷取標準工時時，應用sfb02判定不應用sfb99判定
# Modify.........: No:MOD-B20099 11/02/21 By sabrina 修改MOD-A70024，只抓取開帳暫估金額，入庫暫估金額不抓取
# Modify.........: No:MOD-B30021 11/03/03 By sabrina GROUP BY 1,2會產生-201的錯
# Modify.........: No:MOD-B30042 11/03/07 By sabrina 在ale_curs裡多判斷rvv25!='Y'
# Modify.........: No:MOD-B70065 11/07/17 By Vampire apb_PREPARE 的 sql 把 apb09 <= 0 改成 apb09 < 0
# Modify.........: No:MOD-C10056 12/01/08 By Smapmin 應排除VMI單據
# Modify.........: No:MOD-C20124 12/02/14 BY ck2yaun 檢核有無報工應以入庫時間為基準
# Modify.........: No:MOD-C30843 12/03/23 By yinhy 未過濾掉已作廢工單
# Modify.........: No:TQC-C50119 12/05/15 By Elise asf_p3的SQL是用字串組成
# Modify.........: No:CHI-C80002 12/09/28 By bart 改善效能 NOT IN 改為 NOT EXISTS
# Modify.........: No:FUN-C70046 12/11/07 By bart 成本計算前勾稽加檢查有銷退換貨與換貨出貨期別不同者
# Modify.........: No:MOD-D10058 13/01/08 By bart 期別不可以直接對日期
# Modify.........: No:MOD-D10068 13/01/09 By bart 修改asf_cur1條件
# Modify.........: No:MOD-D10100 13/01/11 By wujie sql少抓无无请款资料匹配纯折让的部分
# Modify.........: No:MOD-D10107 13/01/14 By bart 加採購價差的金額

DATABASE ds

GLOBALS "../../config/top.global"

   DEFINE tm  RECORD                              # Print condition RECORD
              wc        LIKE type_file.chr1000,       #No.FUN-680122 VARCHAR(300)               # Where condition
              ccc02     LIKE ccc_file.ccc02,    # 年別
              ccc03     LIKE ccc_file.ccc03,    # 期別
              more      LIKE type_file.chr1,          #No.FUN-680122 VARCHAR(1)                # Input mORe condition(Y/N)
              a         LIKE type_file.chr1,    #No.FUN-850109
              b         LIKE type_file.chr1,    #No:FUN-850109 #CHI-A10009 add ,
              c         LIKE type_file.chr1     #CHI-A10009 add
              END RECORD,
          l_ORder array[3] of LIKE type_file.chr20,         #No.FUN-680122CHAR(20)
          l_flag  LIKE type_file.chr1,          #No.FUN-680122 VARCHAR(1)
          l_bdate LIKE type_file.dat,           #No.FUN-680122date
          l_edate LIKE type_file.dat,           #No.FUN-680122date
          t_apb01 like apb_file.apb01,
          t_apb02 LIKE apb_file.apb02,        #No.FUN-680122SMALLINT,
          t_imk02 like imk_file.imk02,
          t_imk03 like imk_file.imk03,
          t_imk04 like imk_file.imk04,
          l_tlf902 like tlf_file.tlf902,   #FUN-620001
          l_tlf905 like tlf_file.tlf905,   #FUN-620001
          l_tlf907 like tlf_file.tlf907,   #FUN-620001
          l_tlf06  like tlf_file.tlf06,    #FUN-620001
          l_jce_no LIKE type_file.num5,          #No.FUN-680122 SMALLINT,              #FUN-620001
          l_key    LIKE type_file.chr1,          #No.FUN-680122char(1)
          l_sts   LIKE oea_file.oea01,        #No.FUN-680122char(14)
          g_show      LIKE type_file.num5          #No.FUN-680122SMALLINT
DEFINE   g_cnt           LIKE type_file.num10            #No.FUN-680122 INTEGER
DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose        #No.FUN-680122 SMALLINT
DEFINE l_table        STRING,
       g_str          STRING,
       g_sql          STRING
MAIN
   OPTIONS

       INPUT NO WRAP
   DEFER INTERRUPT                # Supress DEL key functvon

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AXC")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-690125 BY dxfwo
   LET g_sql = " num5.type_file.num5,",
               " ima01.ima_file.ima01,",
               " ima02.ima_file.ima02,",
               " ima021.ima_file.ima021,",
               " chr1000.type_file.chr1000,",
               " chr1000_1.type_file.chr1000,"

   LET l_table = cl_prt_temptable('axcr360',g_sql) CLIPPED
   IF l_table = -1 THEN EXIT PROGRAM END IF
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?, ?, ?, ?, ?, ?) "
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1) EXIT PROGRAM
   END IF

   LET g_pdate       = ARG_VAL(1)         # Get arguments FROM commAND line
   LET g_towhom      = ARG_VAL(2)
   LET g_rlang       = ARG_VAL(3)
   LET g_bgjob       = ARG_VAL(4)
   LET g_prtway      = ARG_VAL(5)
   LET g_copies      = ARG_VAL(6)
   LET tm.wc         = ARG_VAL(7)
   LET tm.ccc02      = ARG_VAL(8)
   LET tm.ccc03      = ARG_VAL(9)
   LET g_rep_user = ARG_VAL(10)
   LET g_rep_clas = ARG_VAL(11)
   LET g_template = ARG_VAL(12)
   LET g_rpt_name = ARG_VAL(13)  #No.FUN-7C0078
   LET tm.a = ARG_VAL(14)     #No.FUN-850109
   LET tm.b = ARG_VAL(15)     #No.FUN-850109
   LET tm.c = ARG_VAL(16)     #CHI-A10009 add

   IF cl_null(g_bgjob) OR g_bgjob = 'N' THEN  # If background job sw is off
      CALL axcr360_tm(0,0)                 # Input print condition
   ELSE
      CALL axcr360()                       # Read data AND create out-file
   END IF
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
END MAIN

FUNCTION axcr360_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01   #No.FUN-580031
   DEFINE p_row,p_col    LIKE type_file.num5,          #No.FUN-680122 SMALLINT
          l_cmd          LIKE type_file.chr1000       #No.FUN-680122CHAR(400)

   IF p_row = 0 THEN LET p_row = 4 LET p_col = 15 END IF

   IF g_gui_type MATCHES "[13]" AND fgl_getenv('GUI_VER') = '6' THEN
      LET p_row = 4 LET p_col = 20
   ELSE LET p_row = 4 LET p_col = 15
   END IF
   OPEN WINDOW axcr360_w AT p_row,p_col
        WITH FORM "axc/42f/axcr360"
################################################################################
# START genero shell script ADD
       ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_init()

# END genero shell script ADD
################################################################################

   CALL cl_opmsg('p')

   INITIALIZE tm.* TO NULL            # Default condition
   LET tm.mORe          = 'N'
   LET g_pdate          = g_today
   LET g_rlang          = g_lang
   LET g_bgjob          = 'N'
   LET g_copies         = '1'
   LET tm.ccc02         = g_ccz.ccz01
   LET tm.ccc03         = g_ccz.ccz02
   LET tm.mORe          ='N'
   LET tm.a             ='N'    #No.FUN-850109
   LET tm.b             ='N'    #No.FUN-850109
   LET tm.c             ='N'    #CHI-A10009 add

WHILE TRUE
   CONSTRUCT BY NAME tm.wc ON ima01,ima57
         BEFORE CONSTRUCT
             CALL cl_qbe_init()

     ON ACTION locale
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         LET g_action_choice = "locale"
         EXIT CONSTRUCT

   ON IDLE g_idle_seconds
      CALL cl_on_idle()
      CONTINUE CONSTRUCT

     ON ACTION CONTROLP
        IF INFIELD(ima01) THEN
           CALL cl_init_qry_var()
           LET g_qryparam.form = "q_ima"
           LET g_qryparam.state = "c"
           CALL cl_create_qry() RETURNING g_qryparam.multiret
           DISPLAY g_qryparam.multiret TO ima01
           NEXT FIELD ima01
        END IF

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


           ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT
         ON ACTION qbe_select
            CALL cl_qbe_select()

END CONSTRUCT
LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('imauser', 'imagrup') #FUN-980030
       IF g_action_choice = "locale" THEN
          LET g_action_choice = ""
          CALL cl_dynamic_locale()
          CONTINUE WHILE
       END IF

   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW axcr360_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
      EXIT PROGRAM

   END IF
   IF tm.wc=" 1=1" THEN
      CALL cl_err('','9046',0) CONTINUE WHILE
   END IF
  #LET tm.wc=tm.wc CLIPPED," AND ima01 NOT MATCHES 'MISC*' "   #No.MOD-8C0299 add  #TQC-C50119 mark
   LET tm.wc=tm.wc CLIPPED," AND ima01 NOT LIKE 'MISC%' "      #TQC-C50119
   DISPLAY BY NAME tm.ccc02,tm.ccc03,tm.a,tm.b,tm.c,tm.mORe #No:FUN-850109 add a,b  #CHI-A10009 add c


   INPUT   BY NAME tm.ccc02,tm.ccc03,tm.a,tm.b,tm.c,tm.more #No:FUN-850109 add a,b  #CHI-A10009 add c
           WITHOUT DEFAULTS
         BEFORE INPUT
             CALL cl_qbe_display_condition(lc_qbe_sn)

      AFTER FIELD ccc02
         IF cl_null(tm.ccc02) THEN
            LET tm.ccc02 = YEAR(g_pdate)
            DISPLAY tm.ccc02 TO ccc02
         END IF

      AFTER FIELD ccc03
         IF NOT cl_null(tm.ccc03) THEN
            SELECT azm02 INTO g_azm.azm02 FROM azm_file
              WHERE azm01 = tm.ccc02
            IF g_azm.azm02 = 1 THEN
               IF tm.ccc03 > 12 OR tm.ccc03 < 1 THEN
                  CALL cl_err('','agl-020',0)
                  NEXT FIELD ccc03
               END IF
            ELSE
               IF tm.ccc03 > 13 OR tm.ccc03 < 1 THEN
                  CALL cl_err('','agl-020',0)
                  NEXT FIELD ccc03
               END IF
            END IF
         END IF
         IF tm.ccc03 IS NULL THEN
            LET tm.ccc03 = month(g_pdate)
            DISPLAY tm.ccc03 TO ccc03
         END IF

      AFTER FIELD more
         IF tm.more = 'Y' THEN
            CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                           g_bgjob,g_time,g_prtway,g_copies)
                 RETURNING g_pdate,g_towhom,g_rlang,
                           g_bgjob,g_time,g_prtway,g_copies
         END IF
################################################################################
# START genero shell script ADD
   ON ACTION CONTROLZ
      CALL cl_show_req_fields()
# END genero shell script ADD
################################################################################
      ON ACTION CONTROLG
         CALL cl_cmdask()    # CommAND execution

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT INPUT

      ON ACTION qbe_save
         CALL cl_qbe_save()

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

       ON ACTION about
          CALL cl_about()

       ON ACTION help
          CALL cl_show_help()

   END INPUT
   CALL s_azm(tm.ccc02,tm.ccc03) RETURNING l_flag,l_bdate,l_edate
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW axcr360_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
      EXIT PROGRAM

   END IF

   IF g_bgjob = 'Y' THEN
      SELECT zz08 INTO l_cmd FROM zz_file    #get exec cmd (fglgo xxxx)
             WHERE zz01='axcr360'
      IF SQLCA.SQLCODE OR l_cmd IS NULL THEN
          CALL cl_err('axcr360','9031',1)
      ELSE
         LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
         LET l_cmd = l_cmd CLIPPED,        #(at time fglgo xxxx p1 p2 p3)
                         " '",g_pdate      CLIPPED,"'",
                         " '",g_towhom     CLIPPED,"'",
                         " '",g_rlang CLIPPED,"'", #No.FUN-7C0078
                         " '",g_bgjob      CLIPPED,"'",
                         " '",g_prtway     CLIPPED,"'",
                         " '",g_copies     CLIPPED,"'",
                         " '",tm.wc        CLIPPED,"'",
                         " '",tm.ccc02     CLIPPED,"'",
                         " '",tm.ccc03     CLIPPED,"'",
                         " '",g_rep_user CLIPPED,"'",           #No.FUN-570264
                         " '",g_rep_clas CLIPPED,"'",           #No.FUN-570264
                         " '",g_template CLIPPED,"'",           #No.FUN-570264
                         " '",g_rpt_name CLIPPED,"'",            #No:FUN-7C0078  #CHI-A10009 add ,
                         " '",tm.a CLIPPED,"'",                 #CHI-A10009 add
                         " '",tm.b CLIPPED,"'",                 #CHI-A10009 add
                         " '",tm.c CLIPPED,"'"                  #CHI-A10009 add
         CALL cl_cmdat('axcr360',g_time,l_cmd)    # Execute cmd at later time
      END IF
      CLOSE WINDOW axcr360_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
      EXIT PROGRAM
   END IF
   CALL cl_wait()
   CALL axcr360()
   ERROR ""
END WHILE
   CLOSE WINDOW axcr360_w
END FUNCTION

FUNCTION axcr360()
   DEFINE l_ccj	     RECORD LIKE ccj_file.*
   DEFINE l_sfb01    LIKE sfb_file.sfb01        #No.FUN-680122CHAR(16)     #FUN-550025
   DEFINE l_sfb38    LIKE sfb_file.sfb38        #No.FUN-680122DATE
   DEFINE l_sfb87    LIKE sfb_file.sfb87        #No.MOD-8B0113 add
   DEFINE l_sfb05    LIKE sfb_file.sfb05
   DEFINE l_name     LIKE type_file.chr20,         #No.FUN-680122 VARCHAR(20)       # External(Disk) file name
          l_sql      LIKE type_file.chr1000,       #No.FUN-680122CHAR(2000)
          l_sql1     LIKE type_file.chr1000,       #No.FUN-680122CHAR(2000)
          l_za05     LIKE type_file.chr1000,       #No.FUN-680122 VARCHAR(40)
          l_sfb      RECORD LIKE sfb_file.*,
          l_tlf01    LIKE tlf_file.tlf01,
          l_tlf62    LIKE tlf_file.tlf62,
          l_ima01    LIKE ima_file.ima01,
          l_ima02    LIKE ima_file.ima02,
          l_ima08    LIKE ima_file.ima08,
          l_ima09    LIKE ima_file.ima09,
          l_ima57    LIKE ima_file.ima57,
          x_ima57    LIKE ima_file.ima57,
          x_ima02    LIKE ima_file.ima02,
          l_apa00    LIKE apa_file.apa00,      #No:9640
          l_apa01    LIKE apa_file.apa01,
          l_apasum   LIKE apa_file.apa31,
          l_apbsum   LIKE apa_file.apa31,
          l_apbsum_1 LIKE apa_file.apa31,      #No:9640
          l_apbsum_2 LIKE apa_file.apa31,      #No:9640
          l_apa56    LIKE apa_file.apa56,      #MOD-A70024 add
          l_apisum   LIKE api_file.api05,      #MOD-A70024 add
          l_apa33    LIKE apa_file.apa33,      #MOD-D10107
          l_smyslip  LIKE smy_file.smyslip,
          l_sfv09    LIKE sfv_file.sfv09,      #TQC-A40139 add
          l_sfb08    LIKE sfb_file.sfb08,      #TQC-A40139 add
          sr        RECORD
                    ima01   like ima_file.ima01,
                    ima02   like ima_file.ima02,
                    ima57   like ima_file.ima57
                  END RECORD,
          cr      RECORD
                  D_TYPE  LIKE type_file.num5,          #No.FUN-680122SMALLINT
                  ima01 like ima_file.ima01,
                  ima02 like ima_file.ima02,
                  str_err LIKE type_file.chr1000        #No.FUN-680122char(90)
                  END RECORD,
          l_qty   LIKE tlf_file.tlf10           #No.FUN-680122DEC(15,3) #TQC-840066
DEFINE    l_ima021  LIKE ima_file.ima021         #No.FUN-750115
DEFINE    l_err     LIKE type_file.chr1000       #No.FUN-750115
DEFINE    l_wc       LIKE type_file.chr1000     #No.TQC-A40139
DEFINE    l_sfa27    LIKE sfa_file.sfa27,       #No.TQC-A40139
          l_api26    LIKE api_file.api26,       #MOD-B20099 add
          l_api05    LIKE api_file.api05,       #MOD-B20099 add
          l_cnt      LIKE type_file.num5        #MOD-B20099 add
DEFINE    l_oha01    LIKE oha_file.oha01        #FUN-C70046
DEFINE    l_ohb03    LIKE ohb_file.ohb03        #FUN-C70046
DEFINE    l_ohb04    LIKE ohb_file.ohb04        #FUN-C70046
DEFINE    l_ohb12    LIKE ohb_file.ohb12        #FUN-C70046
DEFINE    l_oga01    LIKE oga_file.oga01        #FUN-C70046
DEFINE    l_ogb03    LIKE oga_file.oga03        #FUN-C70046
DEFINE    l_oga16    LIKE oga_file.oga16        #FUN-C70046
DEFINE    l_sfb36    LIKE sfb_file.sfb36        #2013110095
DEFINE    l_sfb37    LIKE sfb_file.sfb37        #2013110095
DEFINE    l_yy1      LIKE type_file.num5        #2013110095
DEFINE    l_mm1      LIKE type_file.num5        #2013110095
DEFINE    l_yy2      LIKE type_file.num5        #2013110095
DEFINE    l_mm2      LIKE type_file.num5        #2013110095
DEFINE    l_chk      LIKE type_file.num5        # add by lixwz 20171016

     SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang
     SELECT zz17,zz05 INTO g_len,g_zz05 FROM zz_file WHERE zz01 = g_prog  #No.FUN-760085
     CALL cl_del_data(l_table)

     #--------------------------------------------------------------
     #(10)成本階不在料件成本階數設定作業
     #--------------------------------------------------------------
     LET l_sql=" SELECT UNIQUE ima01,ima02,ima57 ",
               "   FROM ima_file,tlf_file,smy_file ",
               " WHERE ",tm.wc clipped,
               "   AND tlf06 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
               "   AND tlf01 = ima01 AND tlf61 = smyslip ",
               "   AND smydmy1 = 'Y' ",
               #"   AND tlf902 NOT IN (SELECT jce02 FROM jce_file)",  #FUN-670098 add #CHI-C80002
               #"   AND ima57 NOT IN ( SELECT ccd01 FROM ccd_file ) " #CHI-C80002
               "   AND NOT EXISTS(SELECT 1 FROM jce_file WHERE jce02 = tlf902)",  #CHI-C80002
               "   AND NOT EXISTS(SELECT 1 FROM ccd_file WHERE ccd01 = ima57 ) "  #CHI-C80002

     PREPARE axcr360_PREPARE1 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
       CALL cl_err('PREPARE:',SQLCA.SQLCODE,1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE axcr360_curs1 CURSOR FOR axcr360_PREPARE1

     INITIALIZE cr.* TO NULL
     FOREACH axcr360_curs1 INTO sr.*
       IF SQLCA.SQLCODE != 0 THEN
          CALL cl_err('axcr360_curs1:',SQLCA.SQLCODE,1)
          EXIT FOREACH
       END IF
       LET cr.D_TYPE = 10
       LET cr.ima01=sr.ima01
       LET cr.ima02=sr.ima02
       LET cr.str_err = sr.ima57 CLIPPED
       LET l_err = '1'
#          " 成本階不在料件成本階數設定作業(axcp012)"
       SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
       IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
       EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
     END FOREACH

     #--------------------------------------------------------------
     #(15) Check smydmy1='Y'(計算成本) AND tlf021,tlf031 不可出現於jce02
     #--------------------------------------------------------------
     LET l_sql=" SELECT UNIQUE ima01,ima02,ima57,tlf06,tlf902,tlf905,tlf907,tlf61 ", #MOD-870198 add tlf61
               "   FROM ima_file,tlf_file,smy_file ",
               " WHERE ",tm.wc clipped,
               #"   AND tlf902 NOT IN (SELECT jce02 FROM jce_file)",  #FUN-670098 add #CHI-C80002
               "   AND NOT EXISTS(SELECT 1 FROM jce_file WHERE jce02 = tlf902)",  #CHI-C80002
               "   AND tlf06 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
               "   AND tlf01 = ima01 AND tlf61 = smyslip ",
               "   AND smydmy1 = 'Y' "

     PREPARE axcr360_PREPARE2 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('PREPARE:',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE axcr360_curs2 CURSOR FOR axcr360_PREPARE2

     INITIALIZE cr.* TO NULL
      FOREACH axcr360_curs2 INTO sr.*,l_tlf06,l_tlf902,l_tlf905,l_tlf907,l_smyslip #MOD-870198 add l_smyslip
       IF SQLCA.SQLCODE != 0 THEN
          CALL cl_err('axcr360_curs2:',SQLCA.SQLCODE,1)
          EXIT FOREACH
       END IF
       IF l_tlf907 != 0  THEN
          LET l_jce_no = 0
          SELECT COUNT(*) INTO l_jce_no FROM jce_file
           WHERE jce02 = l_tlf902
          IF l_jce_no > 0  THEN
            LET cr.D_TYPE = 15
            LET cr.ima01=sr.ima01
            LET cr.ima02=sr.ima02
           LET cr.str_err = l_smyslip CLIPPED
           LET l_err = '2'
#               "該單據之單別成本入項設定為'Y',但確於 axci500設定為非成本庫"
           EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
          END IF
        END IF
     END FOREACH

     #---------------------------------------------------------------------
     #(20)有入庫/退貨單(rvu_file,rvv_file)但未匹配
     #---------------------------------------------------------------------
     LET l_sql = " SELECT rvv01,rvv02,ima01,ima02,ima57 ",
                 "   FROM rvv_file,rvu_file,ima_file ",
                 "  WHERE rvv01=rvu01 AND rvv31 = ima01 ",
                 "    AND rvu03 BETWEEN '",l_bdate,"' AND '",l_edate ,"' ",
                 "    AND (rvu00 = '1' OR rvu00 = '3') AND rvuconf ='Y' ",
                 "    AND rvv25 != 'Y' ",       #No.MOD-8B0112 add
#No.MOD-D10100 --begin
#                 "    AND (rvv23+rvv88 < rvv87 OR (rvv23 IS NULL AND rvv87 > 0 AND rvv88 < rvv87)) ",  #No.MOD-920179
                 "    AND (rvv23+rvv88 < rvv87 OR (rvv23 IS NULL AND rvv87 > 0 AND rvv88 < rvv87) ",
                 "         OR (rvu00 ='3' AND rvu116 ='3' AND NOT EXISTS (SELECT 1 FROM apb_file WHERE apb21 = rvv01 AND apb22 = rvv02))) ",
#No.MOD-D10100 --end
                 "    AND (rvv89 = 'N' OR rvv89 IS NULL) ",   #MOD-C10056
                 "    AND ",tm.wc clipped
     PREPARE rvv_PREPARE1 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('PREPARE rvv:',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE rvv_curs CURSOR FOR rvv_PREPARE1
     INITIALIZE cr.* TO NULL
     LET t_apb01 = ' ' LET t_apb02 = 0
     FOREACH rvv_curs INTO t_apb01,t_apb02,sr.*
         LET cr.D_TYPE = 20
         LET cr.ima01=sr.ima01
         LET cr.ima02=sr.ima02
         LET cr.str_err = t_apb01,t_apb02 USING '###&'
         LET l_err = '3'
#            " 入庫與請款未匹配 "
         SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
         IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
         EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
     END FOREACH

     #-->(20)有入庫/退貨單(rvu_file,rvv_file)但未匹配
     LET l_sql = " SELECT apb01,apb02,ima01,ima02,ima57 ",
                 "   FROM apb_file,apa_file,ima_file ",
                 "  WHERE apb01=apa01 AND apa41 = 'Y' ",
                 "    AND apa02 BETWEEN '",l_bdate,"' AND '",l_edate ,"' ",
                #"    AND ((apa00 = '11' AND apb29 = '1') OR (apa00= '21' AND (apa58 = '2' OR apa58 ='3'))) ", #CHI-910019 add  #MOD-A40069 mark
                 "    AND ((apa00 = '11' AND apb29 = '1') OR (apa00= '21' AND apa58 = '2')) ", #CHI-910019 add                  #MOD-A40069
                 "    AND ((apb09 > 0 AND apb08 < 0) ",   #判斷有數量而無金額
                 " OR (apb09 > 0 AND apb10 < 0) OR (apb09 > 0 AND apb23 < 0) ",
                 " OR (apb09 > 0 AND apb24 < 0) ",
                #MOD-B70065 --- modify --- start ---
                #" OR (apb09 <= 0 AND apb08 > 0) ", #判斷無數量而有金額
                #" OR (apb09 <= 0 AND apb10 >  0) ",
                #" OR (apb09 <= 0 AND apb23 >  0) ",
                #" OR (apb09 <= 0 AND apb24 >  0)) ",
                 " OR (apb09 < 0 AND apb08 > 0) ",
                 " OR (apb09 < 0 AND apb10 >  0) ",
                 " OR (apb09 < 0 AND apb23 >  0) ",
                 " OR (apb09 < 0 AND apb24 >  0)) ",
                #MOD-B70065 --- modify ---  end  ---
                 " AND apb12 = ima01 ",
                 " AND ",tm.wc clipped
     PREPARE apb_PREPARE1 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('PREPARE apb:',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE apb_curs CURSOR FOR apb_PREPARE1
     INITIALIZE cr.* TO NULL
     LET t_apb01 = ' ' LET t_apb02 = 0
     FOREACH apb_curs INTO t_apb01,t_apb02,sr.*
            LET cr.D_TYPE = 30
            LET cr.ima01=sr.ima01
            LET cr.ima02=sr.ima02
            LET cr.str_err = t_apb01,t_apb02 USING '###&'
            LET l_err = '4'
#               " 帳面單價或金額 < 0"
            SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
            IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
            EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
    END FOREACH
  #-->有倉退(rvu_file,rvv_file)但未匹配
     LET l_sql = " SELECT apb01,apb02,ima01,ima02,ima57 ",
                 "   FROM apb_file,apa_file,ima_file ",
                 "  WHERE apb01=apa01 AND apa41 = 'Y' ",
                 "    AND apa02 BETWEEN '",l_bdate,"' AND '",l_edate ,"' ",
                 "    AND (apa00 = '11'AND apb29='3') ", #No.MOD-8C0117 mod by liuxqa
                 "    AND ((apb09 > 0 AND apb08 < 0) ",   #判斷有數量而無金額
                 " OR (apb09 > 0 AND apb10 > 0) OR (apb09 > 0 AND apb23 < 0) ",
                 " OR (apb09 > 0 AND apb24 > 0) ",
                #MOD-B70065 --- modify --- start ---
                #" OR (apb09 <= 0 AND apb10 >  0) ",
                #" OR (apb09 <= 0 AND apb24 >  0)) ",
                 " OR (apb09 < 0 AND apb10 >  0) ",
                 " OR (apb09 < 0 AND apb24 >  0)) ",
                #MOD-B70065 --- modify ---  end  ---
                 " AND apb12 = ima01 ",
                 " AND ",tm.wc clipped
     PREPARE apb_PREPARE2 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('PREPARE apb:',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE apb_curs2 CURSOR FOR apb_PREPARE2
     INITIALIZE cr.* TO NULL
     LET t_apb01 = ' ' LET t_apb02 = 0
     FOREACH apb_curs2 INTO t_apb01,t_apb02,sr.*
            LET cr.D_TYPE = 30
            LET cr.ima01=sr.ima01
            LET cr.ima02=sr.ima02
            LET cr.str_err = t_apb01,t_apb02 USING '###&'
            LET l_err = '4'
#               " 帳面單價或金額 < 0"
            SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
            IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
            EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
    END FOREACH
    #-----------------------
    # check ALE_FILE
    #-----------------------
    LET l_sql = "SELECT ale01,ale02,ima01,ima02,ima57 ",
                 "  FROM ale_file,rvu_file,ima_file,rvv_file ",     #MOD-B30042 add rvv_file
                 " WHERE rvu00='1' AND rvu01 = ale16 AND rvuconf ='Y' ",
                 "   AND rvu03 BETWEEN '",l_bdate,"' AND '", l_edate,"' ",
                 "   AND (ale08 <= 0 OR ale09 <= 0 ) ",
                 "   AND ale11 = ima01 ",
                 "   AND rvu01 = rvv01 AND rvv01 = ale16 ",          #MOD-B30042 add
                 "   AND rvv02 = ale17 AND rvv25 != 'Y' ",           #MOD-B30042 add
                 "   AND ",tm.wc clipped
    PREPARE ale_PREPARE1 FROM l_sql
    IF SQLCA.SQLCODE != 0 THEN
       CALL cl_err('PREPARE ale:',SQLCA.SQLCODE,1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
       EXIT PROGRAM
    END IF
    DECLARE ale_curs CURSOR FOR ale_PREPARE1
    INITIALIZE cr.* TO NULL
    LET t_apb01 = ' ' LET t_apb02 = 0
    FOREACH ale_curs INTO t_apb01,t_apb02,sr.*
         LET cr.D_TYPE = 40
         LET cr.ima01=sr.ima01
         LET cr.ima02=sr.ima02
         LET cr.str_err = t_apb01,t_apb02 USING '###&'
         LET l_err = '5'
#            " 外購帳面單價或金額 <= 0"
         SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
         IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
         EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
    END FOREACH

     #--------------------------------------------------------------
     #(50)檢查統計檔期未庫存小於零
     #--------------------------------------------------------------
     LET l_sql = " SELECT imk02,imk03,imk04,ima01,ima02,ima57 ",
                 "   FROM imk_file,ima_file ",
                 "  WHERE imk05= ",tm.ccc02,
                 "    AND imk06= ",tm.ccc03,
                 "    AND imk09 < 0 ",
                 "    AND ima01 = imk01 ",
                 "    AND ",tm.wc clipped

     PREPARE imk_PREPARE1 FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('PREPARE imk:',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE imk_curs CURSOR FOR imk_PREPARE1
     FOREACH imk_curs INTO t_imk02,t_imk03,t_imk04,sr.*
          LET cr.D_TYPE = 50
          LET cr.ima01=sr.ima01
          LET cr.ima02=sr.ima02
          LET cr.str_err = t_imk02 CLIPPED,'|',
           t_imk03 CLIPPED,'|',t_imk04 CLIPPED,'|'
           LET l_err = '6'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
     END FOREACH

     #--------------------------------------------------------------
     #(0) Check 每日工時檔中, 有無輸入上期前就已結案的工單
     #--------------------------------------------------------------
    #MOD-A80062---modify---start---
    #DECLARE chk_c CURSOR FOR
    # SELECT UNIQUE ccj04, sfb01,sfb38,sfb05,sfb87     #No.MOD-8B0113 modify
    #   FROM cci_file,ccj_file,OUTER sfb_file
    #  WHERE YEAR(cci01)=g_ccz.ccz01 AND MONTH(cci01)=g_ccz.ccz02
    #    AND cci01=ccj01 AND cci02=ccj02 AND ccj04=sfb_file.sfb01
    #    AND (ccj05 != 0 OR ccj051 != 0 OR ccj07 != 0 OR ccj071 != 0)   #No:MOD-A10056 modify
     LET l_sql="SELECT UNIQUE ccj04, sfb01,sfb38,sfb05,sfb87 ",
               " FROM cci_file,ccj_file LEFT OUTER JOIN sfb_file ON ccj04 = sfb01 AND sfb87<>'X' ",  #MOD-C30843 add sfb87
               " ,ima_file ",
               #"WHERE YEAR(cci01)='",g_ccz.ccz01,"' AND MONTH(cci01)='",g_ccz.ccz02,"'", #MOD-D10058
               "WHERE cci01 BETWEEN '",l_bdate,"' AND '",l_edate,"'", #MOD-D10058
               " AND cci01=ccj01 AND cci02=ccj02 ",
               " AND (ccj05 != 0 OR ccj051 != 0 OR ccj07 != 0 OR ccj071 != 0) ",
               " AND sfb05 = ima01 ",
               " AND ",tm.wc CLIPPED
     PREPARE chk_c_PREPARE1 FROM l_sql
     DECLARE chk_c CURSOR FOR chk_c_PREPARE1
    #MOD-A80062---modify---end---

     FOREACH chk_c INTO l_ccj.ccj04,l_sfb01,l_sfb38,l_sfb05,l_sfb87   #No.MOD-8B0113 modify
        MESSAGE "WO:",l_ccj.ccj04
        CALL ui.Interface.refresh()
        IF l_sfb01 IS NULL THEN
           LET cr.D_TYPE = 0
           LET cr.ima01=l_sfb05
           LET cr.ima02=l_ccj.ccj04
           LET l_err = '7'
           LET cr.str_err =''
           SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
           IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
           EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
        ELSE
           IF YEAR(l_sfb38)*12+MONTH(l_sfb38) < g_ccz.ccz01*12+g_ccz.ccz02 THEN
              LET cr.D_TYPE = 0
              LET cr.ima01=l_sfb05
              LET cr.ima02=l_sfb01
              LET l_err = '8'
              LET cr.str_err = ''
              SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
              IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
              EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
           END IF
           IF l_sfb87 !='Y' THEN
              LET cr.D_TYPE = 0
              LET cr.ima01=l_sfb05
              LET cr.ima02=l_sfb01
              LET l_err = '17'
              LET cr.str_err = ''
              EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
           END IF
        END IF
     END FOREACH

     #--------------------------------------------------------------
     #(0) Check 入庫之材料是否有設標準工時
     #--------------------------------------------------------------
  IF tm.a = 'Y' THEN     #No.FUN-850109
    LET l_sql="SELECT unique sfb05 ","FROM sfb_file,ima_file ",
              " WHERE sfb81 BETWEEN '", l_bdate,"' AND '", l_edate,"' ",
             #"AND sfb05=ima01 AND  sfb99='N' AND (ima58 = 0 OR ima58 is null)",      #MOD-B20067 mark
              "AND sfb05=ima01 AND  sfb02='1' AND (ima58 = 0 OR ima58 is null)",      #MOD-B20067 add
              " AND ",tm.wc clipped
    PREPARE ima58_PREPARE1 FROM l_sql
    IF SQLCA.SQLCODE != 0 THEN
       CALL cl_err('PREPARE imk:',SQLCA.SQLCODE,1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
       EXIT PROGRAM
    END IF
    DECLARE ima58_curs CURSOR FOR ima58_PREPARE1
    FOREACH ima58_curs INTO l_sfb05
        MESSAGE "IMA58:",l_sfb05
        CALL ui.Interface.refresh()
        LET cr.D_TYPE = 0
        LET cr.ima01=l_sfb05
        LET cr.ima02=' '
        LET l_err = '9'    # " 無標準工時 ! "
        LET cr.str_err = ''
        SELECT ima02,ima021 INTO cr.ima02,l_ima021 FROM ima_file WHERE ima01=cr.ima01 #TQC-990030
        IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
        EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
     END FOREACH
   END IF    #No.FUN-850109


     #--------------------------------------------------------------
     #(0) Check 應發數量(sfa05)=0 but 已發數量(sfa06)<>0
     #--------------------------------------------------------------
    #MOD-A80062---modify---start---
    #DECLARE chk_sfa05 CURSOR FOR
    # SELECT sfa03,ima02,sfa01 FROM ima_file,sfa_file,sfb_file
    #    WHERE sfa03=ima01 AND sfa05=0 AND (sfa06<>0 or sfa062<>0)
    #      AND sfb01=sfa01
    #      AND (sfb38 >= l_bdate OR sfb38 IS NULL)
    #    ORDER BY sfa01
     LET l_sql =" SELECT sfa03,ima02,sfa01 FROM ima_file,sfa_file,sfb_file ",
                "  WHERE sfa03=ima01 AND sfa05=0 AND (sfa06<>0 or sfa062<>0) ",
                "  AND sfb01=sfa01 ",
                "  AND (sfb38 >= '",l_bdate,"' OR sfb38 IS NULL) ",
                "  AND ",tm.wc CLIPPED,
                " ORDER BY sfa01 "
     PREPARE chk_sfa05_pre FROM l_sql
     DECLARE chk_sfa05 CURSOR FOR chk_sfa05_pre
    #MOD-A80062---modify---end---

     FOREACH chk_sfa05 INTO l_ima01,l_ima02,l_sfb01
         LET cr.ima01=l_ima01
         LET cr.ima02=l_ima02
         LET cr.D_TYPE = 01
         LET cr.str_err = l_sfb01 CLIPPED
         LET l_err = '10'
         SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
         IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
         EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
     END FOREACH

     #--------------------------------------------------------------
     #(0) Check 檢查有tlf_file 但無工單編號
     #--------------------------------------------------------------
    #MOD-A80062---modify---start----
    #DECLARE chk_wo CURSOR FOR
    # SELECT unique tlf62,tlf01 FROM tlf_file   #MOD-920305 add tlf01
    #  WHERE tlf06 BETWEEN l_bdate AND l_edate
    #    AND tlf13 matches 'asf*' AND tlf907 != 0
    #    AND tlf62 NOT IN (SELECT sfb01 FROM sfb_file WHERE sfb01 IS NOT NULL)
    #    AND tlf902 NOT IN (SELECT jce02 FROM jce_file)  #FUN-670098 add
     LET l_sql=" SELECT unique tlf62,tlf01 FROM tlf_file,ima_file ",
               " WHERE tlf06 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               " AND tlf13 matches 'asf*' AND tlf907 != 0 ",
               #" AND tlf62 NOT IN (SELECT sfb01 FROM sfb_file WHERE sfb01 IS NOT NULL) ",  #CHI-C80002
               #" AND tlf902 NOT IN (SELECT jce02 FROM jce_file) ",   #CHI-C80002
               " AND NOT EXISTS(SELECT 1 FROM sfb_file WHERE sfb01 = tlf62) ",  #CHI-C80002
               " AND NOT EXISTS(SELECT 1 FROM jce_file WHERE jce02 = tlf902) ",  #CHI-C80002
               " AND tlf01 = ima01 ",
               " AND ",tm.wc CLIPPED
     PREPARE chk_wo_pre FROM l_sql
     DECLARE chk_wo CURSOR FOR chk_wo_pre
    #MOD-A80062---modify---end---

      FOREACH chk_wo INTO l_tlf62,l_tlf01   #MOD-920305 add l_tlf01
         LET cr.ima01 = l_tlf01  #MOD-920305 add
         LET cr.D_TYPE = 90
         LET cr.str_err = l_tlf62 CLIPPED
         LET l_err = '11'
         SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
         IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
         EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
      END FOREACH

     #--------------------------------------------------------------
     #(0) Check 檢查有tlf_file 但無備料檔
     #--------------------------------------------------------------
    #MOD-A80062---modify---start---
    #DECLARE chk_wosfa CURSOR FOR
    #  SELECT unique tlf01,tlf62,SUM(tlf10*tlf907) FROM tlf_file
    #   WHERE tlf06 BETWEEN l_bdate AND l_edate
    #     AND tlf13 matches 'asfi*' AND tlf907 != 0
    #     AND tlf902 NOT IN (SELECT jce02 FROM jce_file)  #FUN-670098 add
    #     GROUP BY 1,2
     LET l_sql=" SELECT unique tlf01,tlf62,SUM(tlf10*tlf907) FROM tlf_file ",   #wujie remove ima_file
               " WHERE tlf06 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               " AND tlf13 matches 'asfi*' AND tlf907 != 0 ",
               #" AND tlf902 NOT IN (SELECT jce02 FROM jce_file) ",  #CHI-C80002
               " AND NOT EXISTS(SELECT 1 FROM jce_file WHERE jce02 = tlf902) ",  #CHI-C80002
#wujie 130627 --begin
#               " AND tlf01 = ima01 ",
               " AND ",tm.wc CLIPPED ,
               " AND NOT EXISTS(SELECT 1 FROM ima_file WHERE ima01 = tlf01  ",
               "                                         AND ",tm.wc CLIPPED ,")",
#wujie 130627 --end
              #" GROUP BY 1,2 "             #MOD-B30021 mark
               " GROUP BY tlf01,tlf62 "     #MOD-B30021 add
     PREPARE chk_wosfa_pre FROM l_sql
     DECLARE chk_wosfa CURSOR FOR chk_wosfa_pre
    #MOD-A80062---modify---end---

      FOREACH chk_wosfa INTO l_tlf01,l_tlf62,l_qty
         LET cr.ima01=l_tlf01
         SELECT ima02 INTO cr.ima02 FROM ima_file
            WHERE ima01=l_tlf01
         IF STATUS=100 THEN
            LET cr.D_TYPE = 92
            LET cr.str_err = l_tlf01 CLIPPED
            LET l_err = '12'
#                 " 有異動資料(tlf_file)但料號不存在料件主檔(ima_file)"
            SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
            IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
            EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
         END IF
         LET cr.D_TYPE = 91
         SELECT COUNT(*) INTO g_cnt FROM sfa_file
            WHERE sfa01=l_tlf62 AND sfa03=l_tlf01
         IF g_cnt<1 THEN
            LET l_err = '13'
            LET cr.str_err =l_err CLIPPED,l_tlf62,   #" 工單備料檔無此料號存在 WO:"
                  " Qty=",l_qty USING "-------"
            SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
            IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
            EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
         END IF
      END FOREACH

     #--------------------------------------------------------------
     #(0) Check 檢查請款的單頭與單身不合
     #--------------------------------------------------------------
     #CHI-C80002---begin
     LET l_sql = " SELECT api26,api05 FROM api_file WHERE api01=? "
     PREPARE api26_presum FROM l_sql
     DECLARE api26_curs CURSOR FOR api26_presum
     #CHI-C80002---end
     LET l_sql = " SELECT apa00,apa01,(apa31-apa60),0,apa56,apa33 ",   #MOD-A70024 add apa56 #MOD-D10107 add apa33
                 "  FROM apa_file",
                  "  WHERE apa41 = 'Y' ",    #--No.MOD-530394  #MOD-590014
                 "    AND apa02 BETWEEN '",l_bdate,"' AND '",l_edate ,"' ",
                 "    AND (apa00 = '11' OR (apa00= '21' AND (apa58 = '2' OR apa58 = '3'))) ",   #No.CHI-910019 add
                 #"    AND apa01 in (SELECT UNIQUE apb01 FROM apb_file,ima_file", #MOD-590014 #CHI-C80002
                 #"    WHERE apb12=ima01 and ",tm.wc clipped,")"      #MOD-590014 #CHI-C80002
                 "    AND EXISTS(SELECT 1 FROM apb_file,ima_file",  #CHI-C80002
                 "    WHERE apb01 = apa01 AND apb12=ima01 and ",tm.wc clipped,")"  #CHI-C80002


     PREPARE apb_presum  FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('apb_presum :',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE apb_cursum CURSOR FOR apb_presum
     FOREACH apb_cursum INTO l_apa00,l_apa01,l_apasum,l_apbsum,l_apa56,l_apa33   #MOD-A70024 add l_apa56  #MOD-D10107 add
        SELECT SUM(apb10) INTO l_apbsum_1 FROM apb_file
         WHERE apb01=l_apa01 AND apb29='1'
        SELECT SUM(apb10) INTO l_apbsum_2 FROM apb_file
         WHERE apb01=l_apa01 AND apb29<>'1'
        IF cl_null(l_apbsum_1) THEN LET l_apbsum_1=0 END IF
        IF cl_null(l_apbsum_2) THEN LET l_apbsum_2=0 END IF
        LET l_apbsum=l_apbsum_1+l_apbsum_2
       #str MOD-A70024 add
       #若差異處理是5.沖期初開帳的暫估時,應付單頭金額除了抓apa31-apa60外需再扣掉api_file裡的api05
        IF l_apa56 = '5' THEN
           LET l_apisum = 0
          #MOD-B20099---modify---start---
          #SELECT SUM(api05) INTO l_apisum FROM api_file WHERE api01=l_apa01
          #IF cl_null(l_apisum) THEN LET l_apisum = 0 END IF
           #CHI-C80002---begin
           #DECLARE api26_curs CURSOR FOR
           # SELECT api26,api05 FROM api_file WHERE api01=l_apa01
           #FOREACH api26_curs INTO l_api26,l_api05
           #CHI-C80002---end
           FOREACH api26_curs USING l_apa01 INTO l_api26,l_api05  #CHI-C80002
             SELECT COUNT(*) INTO l_cnt FROM apb_file WHERE apb01 = l_api26
             IF l_cnt = 0 THEN
                LET l_apisum = l_apisum + l_api05
             END IF
           END FOREACH
          #MOD-B20099---modify---end---
           LET l_apasum = l_apasum - l_apisum
        END IF
       #end MOD-A70024 add
        #MOD-D10107---begin
        IF l_apa56 = '2' THEN
           LET l_apasum=l_apasum+l_apa33
        END IF
        #MOD-D10107---end
        IF l_apasum != l_apbsum THEN
           # add by lixwz 171016 s
           LET l_chk = 0
           SELECT COUNT(*) INTO l_chk FROM APA_FILE
             WHERE APA01 = l_apa01 AND NOT EXISTS(
               SELECT * FROM APB_FILE WHERE APB01 = APA01 AND APB34 != 'Y')
           IF l_chk > 0 THEN
               CONTINUE FOREACH
           END IF
           # add by lixwz 171016 e
           LET cr.D_TYPE = 93
           LET cr.ima01 = ' '
           LET cr.ima02 = ' '
           LET cr.str_err = l_apa01 CLIPPED
           LET l_err = '14'
#                " 請款單(apa_file)付款金額與單身不合(apb_file)"
           SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
           IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
           EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
        END IF
     END FOREACH
     #(0) Check 系統別+性質的合理性(for 工單退料)應='3'  No:8741
     #--------------------------------------------------------------
     LET l_sql = " SELECT smyslip FROM smy_file,ima_file,tlf_file", #MOD-590014
                 "  WHERE smysys='asf' AND smykind='4' AND smydmy2!='3' ",
                 "  AND tlf01=ima01 AND tlf61=smyslip", #MOD-590014
                 #"  AND tlf902 NOT IN (SELECT jce02 FROM jce_file)",  #FUN-670098 add #CHI-C80002
                 "  AND NOT EXISTS(SELECT 1 FROM jce_file WHERE jce02 = tlf902)",  #CHI-C80002
                 "  AND ",tm.wc clipped   #-No.MOD-530394
     PREPARE smy_presum  FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('smy_presum :',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE smy_cursum CURSOR FOR smy_presum
      FOREACH smy_cursum INTO l_smyslip
             LET cr.D_TYPE = 95
             LET cr.ima01 = ' '
             LET cr.ima02 = ' '
             LET cr.str_err = l_smyslip CLIPPED
             LET l_err = '15'
#                  " 單據別設定時(asmi300),asf系統性質'4'的退料單,其成會分類應為'3'(領)"
           SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
           IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
           EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
      END FOREACH
     #--------------------------------------------------------------
     #(0) Check ima131 is null  No:8741
     #--------------------------------------------------------------
   IF tm.b = 'Y' THEN     #No.FUN-850109
     LET l_sql = " SELECT ima01,ima02 FROM ima_file WHERE ima131 IS NULL ",
                  " AND ",tm.wc clipped    #--No.MOD-530394
     PREPARE ima_presum  FROM l_sql
     IF SQLCA.SQLCODE != 0 THEN
        CALL cl_err('ima_presum :',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
        EXIT PROGRAM
     END IF
     DECLARE ima_cursum CURSOR FOR ima_presum
      FOREACH ima_cursum INTO l_ima01,l_ima02
             LET cr.D_TYPE = 94
             LET cr.ima01 = l_ima01
             LET cr.ima02 = l_ima02
             LET cr.str_err = l_ima01 CLIPPED
             LET l_err = '16'
#                  " 此料號之'產品分類編號'(ima131)為NULL"
             SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
             IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
             EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
      END FOREACH
    END IF      #No.FUN-850109
    #No.TQC-A40139  --Begin
    #应结未结工单明累
   #LET l_sql = " SELECT sfb05,ima02,ima57,sfb01,sfb08 FROM sfb_file,ima_file",  #TQC-A40139 add sfb08
    LET l_sql = " SELECT sfb05,ima02,ima57,sfb01,sfb08,sfb36,sfb37 FROM sfb_file,ima_file",  #TQC-A40139 add sfb08 #2013110095 add sfb36,sfb37
                "  WHERE sfb05 = ima01 ",
                #"    AND sfb81 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",  #MOD-D10068
                "    AND sfb81 <= '",l_edate,"' ",  #MOD-D10068
                "    AND sfb08 = sfb09 ",                    #完工数 = 生产数
                "    AND sfb87 = 'Y'",
                "    AND (sfb28 <> '3' OR sfb28 IS NULL) ",  #未结案
                "    AND ",tm.wc CLIPPED
    PREPARE asf_p1 FROM l_sql
    DECLARE asf_cur1 CURSOR FOR asf_p1
   #FOREACH asf_cur1 INTO sr.*,l_sfb01,l_sfb08  #TQC-A40139 add l_sfb08
    FOREACH asf_cur1 INTO sr.*,l_sfb01,l_sfb08,l_sfb36,l_sfb37  #TQC-A40139 add l_sfb08  #2013110095 add l_sfb36,l_sfb37

       #TQC-A40139 add --start--
       #累计至当月的完工入库数量
       LET l_sfv09 = 0
       SELECT SUM(sfv09) INTO l_sfv09 FROM sfu_file,sfv_file
         WHERE sfv11 = l_sfb01 AND sfu01 = sfv01
           AND sfu00 = '1'     AND sfupost = 'Y' AND sfu02<= l_edate
       IF l_sfv09 IS NULL THEN LET l_sfv09 = 0 END IF
       #累计至当月的完工入库数量 = 工单数量,才做应结未结工单明细(l_err='17')的检核
       IF l_sfv09 <> l_sfb08 THEN CONTINUE FOREACH END IF
       #TQC-A40139 add --end--

       LET cr.D_TYPE = 0
       LET cr.str_err = l_sfb01 CLIPPED
       LET cr.ima01 = sr.ima01
       LET cr.ima02 = sr.ima02
       LET l_err = '17'
       SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
       #2013110095 add begin-----------------------------------------
       IF g_sma.sma72 = 'Y' THEN
          CALL s_yp(l_edate) RETURNING l_yy1,l_mm1
          IF NOT cl_null(l_sfb36) THEN
             CALL s_yp(l_sfb36) RETURNING l_yy2,l_mm2
             IF l_yy1 = l_yy2 THEN
                IF l_mm1 != l_mm2 THEN
                   LET l_err = '1701'
                END IF
             ELSE
                LET l_err = '1701'
             END IF
          END IF
          IF NOT cl_null(l_sfb37) THEN
             CALL s_yp(l_sfb37) RETURNING l_yy2,l_mm2
             IF l_yy1 = l_yy2 THEN
                IF l_mm1 != l_mm2 THEN
                   LET l_err = '1701'
                END IF
             ELSE
                LET l_err = '1701'
             END IF
          END IF
       END IF
       #2013110095 add end-------------------------------------------
       IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
       EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
    END FOREACH

    #工单已入库但未报工
    #--------------No:MOD-A10056 mark
    #此段SQL没有用所以MARK
    #SELECT UNIQUE ccj04, sfb01,sfb38,sfb05,sfb87     #No:MOD-8B0113 modify
    #  FROM cci_file,ccj_file,OUTER sfb_file
    # WHERE YEAR(cci01)=g_ccz.ccz01 AND MONTH(cci01)=g_ccz.ccz02
    #   AND cci01=ccj01 AND cci02=ccj02 AND ccj04=sfb01
    #   AND ccj05 != 0
    #--------------No:MOD-A10056 end
   #MOD-C20124 str add-----
   #LET l_sql = " SELECT sfb05,ima02,ima57,sfb01 ",
   #            "   FROM sfb_file,ima_file",
   #            "  WHERE sfb05 = ima01 ",
   #            "    AND sfb81 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
   #            "    AND sfb87 = 'Y'",
   #            "    AND sfb09 > 0     ",                    #完工数
   #            "    AND sfb01 NOT IN (",       #No:MOD-A10054 modify
   #            "    SELECT UNIQUE ccj04 FROM ccj_file WHERE ccj04 IS NOT NULL) ",
   #            "    AND ",tm.wc CLIPPED

   #當月完工入庫,檢核有無報工
    LET l_sql = " SELECT DISTINCT sfv04,ima02,ima57,sfv11 ",
                "   FROM sfv_file,ima_file,sfu_file ",
                "  WHERE sfv04 = ima01 And sfv01=sfu01 ",
                "    AND sfu02 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
                "    AND sfupost = 'Y' ",
                #"    AND sfv11 NOT IN (", #CHI-C80002
                #"    SELECT UNIQUE ccj04 FROM ccj_file WHERE ccj04 IS NOT NULL) ", #CHI-C80002
                "    AND NOT EXISTS(", #CHI-C80002
                "    SELECT 1 FROM ccj_file WHERE ccj04 = sfv11) ", #CHI-C80002
                "    AND ",tm.wc CLIPPED
   #MOD-C20124 end add-----
    PREPARE asf_p2 FROM l_sql
    DECLARE asf_cur2 CURSOR FOR asf_p2
    FOREACH asf_cur2 INTO sr.*,l_sfb01
      #str MOD-A20111 add
      #当月有完工入库时,才判断有没有报工资料
       LET g_cnt = 0
       SELECT COUNT(*) INTO g_cnt
         FROM sfu_file,sfv_file
        WHERE sfu01=sfv01 AND sfupost='Y'
          AND sfu02 BETWEEN l_bdate AND l_edate
          AND sfv11=l_sfb01
       IF g_cnt = 0 THEN CONTINUE FOREACH END IF
      #end MOD-A20111 add
       LET cr.D_TYPE = 0
       LET cr.str_err = l_sfb01 CLIPPED
       LET cr.ima01 = sr.ima01
       LET cr.ima02 = sr.ima02
       LET l_err = '18'
       SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
       IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
       EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
    END FOREACH
    #FUN-C70046---begin
    #換貨銷退未產生換貨訂單或出貨扣帳日非同一年度期別
    LET l_sql = " SELECT DISTINCT oha01,ohb03,ohb04,ohb12,ima01,ima02,ima57 ",
                "   FROM oha_file,ohb_file,ima_file ",
                "  WHERE oha01 = ohb01 ",
                "    AND ohb04 = ima01 ",
                "    AND oha09 = '2' ",
                "    AND oha02 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
                "    AND ",tm.wc CLIPPED
    PREPARE oha_p1 FROM l_sql
    DECLARE oha_cur1 CURSOR FOR oha_p1
    FOREACH oha_cur1 INTO l_oha01,l_ohb03,l_ohb04,l_ohb12,sr.*

       SELECT COUNT(*) INTO l_cnt FROM oea_file
        WHERE oea00 = '2'
          AND oea12 = l_oha01
       IF l_cnt = 0 THEN
          LET cr.D_TYPE = 0
          LET cr.str_err = l_oha01 CLIPPED,':',l_ohb03 CLIPPED
          LET cr.ima01 = sr.ima01
          LET cr.ima02 = sr.ima02
          LET l_err = '20'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
          CONTINUE FOREACH
       END IF

       SELECT COUNT(*) INTO l_cnt FROM oea_file,oeb_file
        WHERE oeb01 = oea01
          AND oea00 = '2'
          AND oea12 = l_oha01
          AND oeb04 = l_ohb04
          AND oeb24 <> l_ohb12
       IF l_cnt > 0 THEN
          LET cr.D_TYPE = 0
          LET cr.str_err = l_oha01 CLIPPED,':',l_ohb03 CLIPPED
          LET cr.ima01 = sr.ima01
          LET cr.ima02 = sr.ima02
          LET l_err = '20'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
          CONTINUE FOREACH
       END IF
       SELECT COUNT(*) INTO l_cnt FROM oea_file,oga_file
        WHERE oea00 = '2'
          AND oea12 = l_oha01
          AND oga16 = oea01
          AND oga00 = '2'
          AND oga02 BETWEEN l_bdate AND l_edate
       IF l_cnt = 0 THEN
          LET cr.D_TYPE = 0
          LET cr.str_err = l_oha01 CLIPPED,':',l_ohb03 CLIPPED
          LET cr.ima01 = sr.ima01
          LET cr.ima02 = sr.ima02
          LET l_err = '20'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
       END IF
    END FOREACH
    #換貨出貨與換貨銷退非同一年度期別
    LET l_sql = " SELECT oga01,ogb03,oga16,ima01,ima02,ima57 ",
                "   FROM oga_file,ogb_file,ima_file ",
                "  WHERE oga01 = ogb01 ",
                "    AND ogb04 = ima01 ",
                "    AND oga00 = '2' ",
                "    AND oga02 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
                "    AND ",tm.wc CLIPPED
    PREPARE oga_p1 FROM l_sql
    DECLARE oga_cur1 CURSOR FOR oga_p1
    FOREACH oga_cur1 INTO l_oga01,l_ogb03,l_oga16,sr.*
       SELECT COUNT(*) INTO l_cnt FROM oea_file,oha_file
        WHERE oea00 = '2'
          AND oea01 = l_oga16
          AND oha01 = oea12
          AND oha09 = '2'
          AND oha02 BETWEEN l_bdate AND l_edate
       IF l_cnt = 0 THEN
          LET cr.D_TYPE = 0
          LET cr.str_err = l_oga01 CLIPPED,':',l_ogb03 CLIPPED
          LET cr.ima01 = sr.ima01
          LET cr.ima02 = sr.ima02
          LET l_err = '21'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
       END IF
    END FOREACH
    #FUN-C70046---end
    IF tm.c = 'Y' THEN  #CHI-A10009 add
       IF tm.wc <> ' 1=1' AND NOT cl_null(tm.wc) THEN
          #需要一个转换
          LET l_wc = cl_replace_str(tm.wc,"ima01","A.bma01")
          LET l_wc = cl_replace_str(l_wc ,"ima57","A.bma57")
          LET l_wc = cl_replace_str(l_wc ,"bma01","ima01")
          LET l_wc = cl_replace_str(l_wc ,"bma57","ima57")
       END IF
       LET l_sql = " SELECT sfb05,A.ima02,A.ima57,sfb01,sfa27 ",
                   "   FROM sfb_file,ima_file A,ima_file B,sfa_file",
                   "  WHERE sfb05 = A.ima01 ",
                   "    AND sfb81 BETWEEN '",l_bdate,"' AND '",l_edate,"' ",
                   "    AND sfb01 = sfa01 ",
                   "    AND sfa27 = B.ima01 ",
                   "    AND sfb87 = 'Y'",
                   "    AND A.ima57 >= B.ima57 ",
                   "    AND sfb02 NOT IN ('5','8','11') ",  #/╊ンΑ
                  #"    AND sfb04 MATCHES '[45678]'",   #MOD-A40091 add  #TQC-C50119 mark
                   "    AND sfb04 IN ('4','5','6','7','8') ",        #TQC-C50119
                   "    AND ",l_wc CLIPPED
       PREPARE asf_p3 FROM l_sql
       DECLARE asf_cur3 CURSOR FOR asf_p3
       FOREACH asf_cur3 INTO sr.*,l_sfb01,l_sfa27
          LET cr.D_TYPE = 0
          LET cr.str_err = l_sfb01 CLIPPED,':',l_sfa27 CLIPPED
          LET cr.ima01 = sr.ima01
          LET cr.ima02 = sr.ima02
          LET l_err = '19'
          SELECT ima021 INTO l_ima021 FROM ima_file WHERE ima01=cr.ima01
          IF SQLCA.sqlcode THEN LET l_ima021 = NULL END IF
          EXECUTE insert_prep USING cr.D_TYPE,cr.ima01,cr.ima02,l_ima021,cr.str_err,l_err
       END FOREACH
    END IF  #CHI-A10009 add
    #No.TQC-A40139  --End

     LET l_sql = "SELECT * FROM ", g_cr_db_str CLIPPED, l_table CLIPPED
     IF g_zz05 = 'Y' THEN
        CALL cl_wcchp(tm.wc,'ima01,ima57')
          RETURNING tm.wc
        LET g_str = tm.wc
     END IF
     LET g_str = tm.wc
     CALL cl_prt_cs3('axcr360','axcr360',l_sql,g_str)
END FUNCTION
#No.FUN-9C0073 --------------------By chenls  10/01/12
