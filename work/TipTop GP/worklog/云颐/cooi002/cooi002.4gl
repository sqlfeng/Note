# Prog. Version..: '5.30.06-13.04.22(00010)'     #
#
# Pattern name...: cooi002.4gl
# Descriptions...: 客戶產品維護作業

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

#模組變數(Module Variables)
DEFINE
    g_tc_cmm003         LIKE tc_cmm_file.tc_cmm003,
    g_tc_cmm003_t       LIKE tc_cmm_file.tc_cmm003,
    g_tc_cmm004         LIKE tc_cmm_file.tc_cmm004,
    g_tc_cmm004_t       LIKE tc_cmm_file.tc_cmm004,
    g_tc_cmm001         LIKE tc_cmm_file.tc_cmm001,   #產品編號
    g_tc_cmm001_t       LIKE tc_cmm_file.tc_cmm001,   #產品編號(舊值)
    g_tc_cmm002         LIKE tc_cmm_file.tc_cmm002,
    g_tc_cmm002_t       LIKE tc_cmm_file.tc_cmm002,
    g_tc_cmm           DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
        tc_cmm002       LIKE tc_cmm_file.tc_cmm002,
        tc_cmm001       LIKE tc_cmm_file.tc_cmm001,
        gen02           LIKE gen_file.gen02,
        tc_cmm005       LIKE tc_cmm_file.tc_cmm005,
        gem02           LIKE gem_file.gem02,
        tc_cmm006       LIKE tc_cmm_file.tc_cmm006,
        tc_gmm003       LIKE tc_gmm_file.tc_gmm003,
        tc_gmmud01      LIKE tc_gmm_file.tc_gmmud01,
        tc_cmm007       LIKE tc_cmm_file.tc_cmm007,
        tc_cmm008       LIKE tc_cmm_file.tc_cmm008,
        tc_cmm009       LIKE tc_cmm_file.tc_cmm009,
        tc_cmm010       LIKE tc_cmm_file.tc_cmm010,
        tc_cmm011       LIKE tc_cmm_file.tc_cmm011,
        tc_cmm012       LIKE tc_cmm_file.tc_cmm012,
        tc_cmm013       LIKE tc_cmm_file.tc_cmm013,
        # add by lixwz 20170824 s
        tc_cmmud09       LIKE tc_cmm_file.tc_cmmud09,
        tc_cmmud10       LIKE tc_cmm_file.tc_cmmud10,
        tc_cmmud11       LIKE tc_cmm_file.tc_cmmud11,
        # add by lixwz 20170824 e
        tc_cmmuser     LIKE tc_cmm_file.tc_cmmuser,
        tc_cmmgrup     LIKE tc_cmm_file.tc_cmmgrup,
        tc_cmmmodu     LIKE tc_cmm_file.tc_cmmmodu,
        tc_cmmdate     LIKE tc_cmm_file.tc_cmmdate,
        tc_cmmacti     LIKE tc_cmm_file.tc_cmmacti
                    END RECORD,
    g_tc_cmm_t         RECORD                 #程式變數 (舊值)
        tc_cmm002       LIKE tc_cmm_file.tc_cmm002,
        tc_cmm001       LIKE tc_cmm_file.tc_cmm001,
        gen02           LIKE gen_file.gen02,
        tc_cmm005       LIKE tc_cmm_file.tc_cmm005,
        gem02           LIKE gem_file.gem02,
        tc_cmm006       LIKE tc_cmm_file.tc_cmm006,
        tc_gmm003       LIKE tc_gmm_file.tc_gmm003,
        tc_gmmud01      LIKE tc_gmm_file.tc_gmmud01,
        tc_cmm007       LIKE tc_cmm_file.tc_cmm007,
        tc_cmm008       LIKE tc_cmm_file.tc_cmm008,
        tc_cmm009       LIKE tc_cmm_file.tc_cmm009,
        tc_cmm010       LIKE tc_cmm_file.tc_cmm010,
        tc_cmm011       LIKE tc_cmm_file.tc_cmm011,
        tc_cmm012       LIKE tc_cmm_file.tc_cmm012,
        tc_cmm013       LIKE tc_cmm_file.tc_cmm013,
        # add by lixwz 20170824 s
        tc_cmmud09       LIKE tc_cmm_file.tc_cmmud09,
        tc_cmmud10       LIKE tc_cmm_file.tc_cmmud10,
        tc_cmmud11       LIKE tc_cmm_file.tc_cmmud11,
        # add by lixwz 20170824 e
        tc_cmmuser     LIKE tc_cmm_file.tc_cmmuser,
        tc_cmmgrup     LIKE tc_cmm_file.tc_cmmgrup,
        tc_cmmmodu     LIKE tc_cmm_file.tc_cmmmodu,
        tc_cmmdate     LIKE tc_cmm_file.tc_cmmdate,
        tc_cmmacti     LIKE tc_cmm_file.tc_cmmacti
                    END RECORD,
    g_ss            LIKE type_file.chr1,   #No.FUN-680137  VARCHAR(01)
     g_wc,g_sql     STRING, #No.FUN-580092 HCN
    g_rec_b         LIKE type_file.num5,   #單身筆數             #No.FUN-680137 SMALLINT
    l_ac            LIKE type_file.num5    #目前處理的ARRAY CNT  #No.FUN-680137 SMALLINT
DEFINE p_row,p_col  LIKE type_file.num5    #No.FUN-680137 SMALLINT

#主程式開始
DEFINE g_forupd_sql STRING  #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5          #No.FUN-680137 SMALLINT

DEFINE   g_cnt           LIKE type_file.num10            #No.FUN-680137 INTEGER
DEFINE   g_i             LIKE type_file.num5             #count/index for any purpose    #No.FUN-680137 SMALLINT
DEFINE   g_msg           LIKE type_file.chr1000          #No.FUN-680137 VARCHAR(72)
# 2004/02/06 by Hiko : 為了上下筆資料的控制而加的變數.
DEFINE   g_row_count    LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   g_curs_index   LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   g_jump         LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   mi_no_ask      LIKE type_file.num5          #No.FUN-680137 SMALLINT
DEFINE   l_sql          STRING                       #No.FUN-840019
DEFINE   g_str          STRING                       #No.FUN-840019
DEFINE   l_table        STRING                       #No.FUN-840019
DEFINE   l_table1       STRING                       #No.FUN-840019
DEFINE   g_flag         LIKE type_file.chr1    #FUN-D50045 add

MAIN

     OPTIONS
         INPUT NO WRAP
     DEFER INTERRUPT

    IF (NOT cl_user()) THEN
       EXIT PROGRAM
    END IF

    WHENEVER ERROR CALL cl_err_msg_log

    IF (NOT cl_setup("COO")) THEN
       EXIT PROGRAM
    END IF


      CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818 #NO.FUN-6A0094

    LET g_tc_cmm002_t = NULL                   #消除鍵值
    LET g_tc_cmm001_t = NULL
#    LET g_argv1 = ARG_VAL(1)

    LET p_row = 2 LET p_col = 12

    OPEN WINDOW i002_w AT p_row,p_col
         WITH FORM "coo/42f/cooi002"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_init()



    CALL i002_menu()

    CLOSE WINDOW i002_w                   #結束畫面
      CALL cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #NO.FUN-6A0094
         RETURNING g_time                 #NO.FUN-6A0094

END MAIN

#QBE 查詢資料
FUNCTION i002_curs()
    CLEAR FORM                            #清除畫面
    CALL g_tc_cmm.clear()
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

        CONSTRUCT g_wc ON tc_cmm003,tc_cmm004,tc_cmm002,tc_cmm001,tc_cmm005,tc_cmm006,tc_cmm007,tc_cmm008,tc_cmm009,tc_cmm010,tc_cmm011,tc_cmm012,tc_cmm013    #螢幕上取條件
            FROM tc_cmm003,tc_cmm004,s_tc_cmm[1].tc_cmm002,s_tc_cmm[1].tc_cmm001,s_tc_cmm[1].tc_cmm005,s_tc_cmm[1].tc_cmm006,s_tc_cmm[1].tc_cmm007,
                 s_tc_cmm[1].tc_cmm008,s_tc_cmm[1].tc_cmm009,s_tc_cmm[1].tc_cmm010,s_tc_cmm[1].tc_cmm011,s_tc_cmm[1].tc_cmm012,s_tc_cmm[1].tc_cmm013

              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
            ON ACTION controlp
               CASE
                  WHEN INFIELD(tc_cmm001)
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = "c"
                       LET g_qryparam.form ="q_gen"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_cmm001
                       NEXT FIELD tc_cmm001
                  WHEN INFIELD(tc_cmm005) #客戶編號
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = "c"
                       LET g_qryparam.form ="q_gem"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_cmm005
                       NEXT FIELD tc_cmm005
                  WHEN INFIELD(tc_cmm006) #幣別
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = "c"
                       LET g_qryparam.form ="cq_gmm002"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_cmm006
                       NEXT FIELD tc_cmm006
                END CASE
                ON IDLE g_idle_seconds
                   CALL cl_on_idle()
                   CONTINUE CONSTRUCT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
             END CONSTRUCT

        IF INT_FLAG THEN RETURN END IF

    LET g_sql= "SELECT UNIQUE tc_cmm003,tc_cmm004 FROM tc_cmm_file ",
               " WHERE ", g_wc CLIPPED,
               " ORDER BY tc_cmm003 "
    PREPARE i002_prepare FROM g_sql      #預備一下
    DECLARE i002_b_curs                  #宣告成可捲動的
        SCROLL CURSOR WITH HOLD FOR i002_prepare
    #因主鍵值有兩個故所抓出資料筆數有誤
    DROP TABLE x
    LET g_sql = "SELECT COUNT(DISTINCT (tc_cmm003||tc_cmm004)) FROM tc_cmm_file",
                " WHERE ",g_wc CLIPPED
    PREPARE i002_precount FROM g_sql
    DECLARE i002_count CURSOR FOR i002_precount
END FUNCTION

FUNCTION i002_menu()

   WHILE TRUE
      CALL i002_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i002_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i002_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i002_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i002_u()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i002_b()
            ELSE
               LET g_action_choice = NULL
            END IF
#         WHEN "output"
#            IF cl_chk_act_auth() THEN
#               CALL i002_out()
#            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_cmm),'','')
            END IF
         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_tc_cmm001 IS NOT NULL THEN
                 LET g_doc.column1 = "tc_cmm001"
                 LET g_doc.value1 = g_tc_cmm001
                 CALL cl_doc()
               END IF
         END IF
      END CASE
   END WHILE
END FUNCTION


FUNCTION i002_a()
    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
   CALL g_tc_cmm.clear()
    INITIALIZE g_tc_cmm001 LIKE tc_cmm_file.tc_cmm001
    INITIALIZE g_tc_cmm002 LIKE tc_cmm_file.tc_cmm002
    CLOSE i002_b_curs
    LET g_tc_cmm001_t = NULL
    LET g_tc_cmm002_t = NULL
    LET g_wc      = NULL
    CALL cl_opmsg('a')
    WHILE TRUE
        LET g_tc_cmm003 = g_sma.sma51
        LET g_tc_cmm004 = g_sma.sma52
        CALL i002_i("a")                #輸入單頭
        IF INT_FLAG THEN                   #使用者不玩了
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF

        LET g_rec_b=0                               #No.FUN-680064
        IF g_ss='N' THEN
            FOR g_cnt = 1 TO g_tc_cmm.getLength()
                INITIALIZE g_tc_cmm[g_cnt].* TO NULL
            END FOR
        ELSE
            CALL i002_b_fill(' 1=1')          #單身
        END IF

        CALL i002_b()                        #輸入單身
        IF SQLCA.sqlcode THEN
            CALL cl_err(g_tc_cmm003,SQLCA.sqlcode,0)
        END IF
        LET g_tc_cmm001_t = g_tc_cmm001
        LET g_tc_cmm002_t = g_tc_cmm002                 #保留舊值
        EXIT WHILE
    END WHILE
END FUNCTION

FUNCTION i002_u()
    DEFINE  l_buf      LIKE cob_file.cob08        #No.FUN-680137 VARCHAR(30)

    IF s_shut(0) THEN RETURN END IF
    IF g_tc_cmm003 < g_sma.sma51 OR g_tc_cmm004 < g_sma.sma52 THEN RETURN END IF
#    IF g_chkey = 'N' THEN
#       CALL cl_err(g_tc_cmm003,'aoo-085',0)
#       RETURN
#    END IF
    IF cl_null(g_tc_cmm002)  THEN
        CALL cl_err('',-400,0)
        RETURN
    END IF
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_tc_cmm003_t = g_tc_cmm003
    LET g_tc_cmm004_t = g_tc_cmm004
    BEGIN WORK
    WHILE TRUE
        CALL i002_i("u")                      #欄位更改
        IF INT_FLAG THEN
            LET g_tc_cmm003=g_tc_cmm003_t
            DISPLAY g_tc_cmm003 TO tc_cmm003               #單頭
            LET g_tc_cmm004=g_tc_cmm004_t
            DISPLAY g_tc_cmm004 TO tc_cmm004
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF
        IF g_tc_cmm003 != g_tc_cmm003_t OR g_tc_cmm004 != g_tc_cmm004_t
            THEN  UPDATE tc_cmm_file SET tc_cmm003 = g_tc_cmm003,tc_cmm004 = g_tc_cmm004 #更新DB
                WHERE tc_cmm003 = g_tc_cmm003_t AND tc_cmm004 = g_tc_cmm004_t
            IF SQLCA.sqlcode THEN
                LET l_buf = g_tc_cmm003 CLIPPED
                CALL cl_err3("upd","tc_cmm_file",g_tc_cmm003_t,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
                CONTINUE WHILE
            END IF
        END IF
        EXIT WHILE
    END WHILE
    COMMIT WORK
END FUNCTION

#處理INPUT
FUNCTION i002_i(p_cmd)
DEFINE
    p_cmd           LIKE type_file.chr1,          #a:輸入 u:更改   #No.FUN-680137 VARCHAR(1)
    l_buf           LIKE type_file.chr1000,       #No.FUN-680137 VARCHAR(60)
    l_n             LIKE type_file.num5,          #No.FUN-680137 SMALLINT
    l_occ02         LIKE occ_file.occ02           #客戶簡稱

    LET g_ss = 'Y'
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    INPUT g_tc_cmm003,g_tc_cmm004 WITHOUT DEFAULTS
        FROM tc_cmm003,tc_cmm004

#       BEFORE FIELD tc_cmm02
#           IF g_argv1 IS NOT NULL AND g_argv1 != ' ' THEN
#               LET g_tc_cmm02 = g_argv1
#               DISPLAY g_tc_cmm02 TO tc_cmm02
#               CALL i002_tc_cmm02('d')
#               NEXT FIELD tc_cmm02
#           END IF
       AFTER FIELD tc_cmm003

        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913

        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT

        ON ACTION about
           CALL cl_about()

        ON ACTION help
           CALL cl_show_help()

        ON ACTION controlg
           CALL cl_cmdask()

    END INPUT
END FUNCTION

#Query 查詢
FUNCTION i002_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_tc_cmm003 TO NULL               #No.FUN-6A0020
    INITIALIZE g_tc_cmm004 TO NULL

    CALL cl_opmsg('q')

    MESSAGE ""
    CLEAR FORM
    CALL g_tc_cmm.clear()

    CALL i002_curs()                         #取得查詢條件

    IF INT_FLAG THEN                         #使用者不玩了
        LET INT_FLAG = 0
        RETURN
    END IF

    OPEN i002_b_curs                         #從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN                    #有問題
       CALL cl_err('',SQLCA.sqlcode,0)
       INITIALIZE g_tc_cmm001 TO NULL
       INITIALIZE g_tc_cmm002 TO NULL
    ELSE
       CALL i002_fetch('F')            #讀出TEMP第一筆並顯示
       OPEN i002_count
       FETCH i002_count INTO g_row_count
       DISPLAY g_row_count TO FORMONLY.cnt
    END IF

END FUNCTION

#處理資料的讀取
FUNCTION i002_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1                  #處理方式        #No.FUN-680137 VARCHAR(1)

    MESSAGE ""
    CASE p_flag
        WHEN 'N' FETCH NEXT     i002_b_curs INTO g_tc_cmm003,g_tc_cmm004
        WHEN 'P' FETCH PREVIOUS i002_b_curs INTO g_tc_cmm003,g_tc_cmm004
        WHEN 'F' FETCH FIRST    i002_b_curs INTO g_tc_cmm003,g_tc_cmm004
        WHEN 'L' FETCH LAST     i002_b_curs INTO g_tc_cmm003,g_tc_cmm004
        WHEN '/'
            IF (NOT mi_no_ask) THEN
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
               PROMPT g_msg CLIPPED,': ' FOR g_jump
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


               END PROMPT
               IF INT_FLAG THEN LET INT_FLAG = 0 EXIT CASE END IF
            END IF
            FETCH ABSOLUTE g_jump i002_b_curs INTO g_tc_cmm003,g_tc_cmm004
            LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN                         #有麻煩
       CALL cl_err(g_tc_cmm003,SQLCA.sqlcode,0)
       INITIALIZE g_tc_cmm003 TO NULL  #TQC-6B0105
       INITIALIZE g_tc_cmm004 TO NULL
    ELSE

       CASE p_flag
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump          --改g_jump
       END CASE

       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF
    CALL i002_show()
END FUNCTION

#將資料顯示在畫面上
FUNCTION i002_show()

    DISPLAY g_tc_cmm003 TO tc_cmm003               #單頭
    DISPLAY g_tc_cmm004 TO tc_cmm004               #單頭

#    CALL i002_tc_cmm02('d')                   #單頭

    CALL i002_b_fill(g_wc)                 #單身

    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION

#取消整筆 (所有合乎單頭的資料)
FUNCTION i002_r()
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_cmm003 IS NULL THEN
       CALL cl_err("",-400,0)                 #No.FUN-6A0020
       RETURN
    END IF

    BEGIN WORK

    IF cl_delh(0,0) THEN                   #確認一下
        INITIALIZE g_doc.* TO NULL       #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "tc_cmm003"      #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_tc_cmm003       #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                #No.FUN-9B0098 10/02/24
        DELETE FROM tc_cmm_file WHERE tc_cmm003 = g_tc_cmm003 AND tc_cmm004 = g_tc_cmm004
        IF SQLCA.sqlcode THEN
            CALL cl_err3("del","tc_cmm_file",g_tc_cmm003,"",SQLCA.sqlcode,"","BODY DELETE",1)  #No.FUN-660167
        ELSE
            CLEAR FORM
            CALL g_tc_cmm.clear()
            LET g_cnt=SQLCA.SQLERRD[3]
            MESSAGE 'Remove (',g_cnt USING '####&',') Row(s)'
            OPEN i002_count
            #FUN-B50064-add-start--
            IF STATUS THEN
               CLOSE i002_b_curs
               CLOSE i002_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50064-add-end--
            FETCH i002_count INTO g_row_count
            #FUN-B50064-add-start--
            IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
               CLOSE i002_b_curs
               CLOSE i002_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50064-add-end--
            DISPLAY g_row_count TO FORMONLY.cnt
            OPEN i002_b_curs
            IF g_curs_index = g_row_count + 1 THEN
               LET g_jump = g_row_count
               CALL i002_fetch('L')
            ELSE
               LET g_jump = g_curs_index
               LET mi_no_ask = TRUE
               CALL i002_fetch('/')
            END IF
        END IF
    END IF

    COMMIT WORK

END FUNCTION

#單身
FUNCTION i002_b()
DEFINE
    l_imaacti       LIKE ima_file.imaacti, #MOD-710048 add
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT #No.FUN-680137 SMALLINT
    l_n             LIKE type_file.num5,                #檢查重複用        #No.FUN-680137 SMALLINT
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住否        #No.FUN-680137 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,                #處理狀態          #No.FUN-680137 VARCHAR(1)
    l_allow_insert  LIKE type_file.num5,                #可新增否          #No.FUN-680137 SMALLINT
    l_allow_delete  LIKE type_file.num5,                #可刪除否          #No.FUN-680137 SMALLINT
    l_tc_cmmuser       LIKE tc_cmm_file.tc_cmmuser,   #MOD-850286
    l_tc_cmmgrup       LIKE tc_cmm_file.tc_cmmgrup,   #MOD-850286
    l_tc_cmmacti       LIKE tc_cmm_file.tc_cmmacti    #MOD-850286
DEFINE l_gmm003  LIKE tc_gmm_file.tc_gmm003
DEFINE l_gmmud01 LIKE tc_gmm_file.tc_gmmud01
DEFINE l_date    LIKE tc_cmm_file.tc_cmm008
DEFINE l_date1   LIKE tc_cmm_file.tc_cmm008
DEFINE g_day,g_day1,g_day2,g_m,g_m1,g_m11,g_m2,g_h1,g_h2,g_sum_h1,g_sum_h2,l_n1    LIKE type_file.num15_3
DEFINE i,j,m,m1     STRING
DEFINE l_sme1    LIKE sme_file.sme02
DEFINE l_sme2    LIKE sme_file.sme02
DEFINE l_bdate   LIKE type_file.dat      #CHI-9A0021 add
DEFINE l_edate   LIKE type_file.dat
DEFINE l_correct     LIKE type_file.chr1
# add by lixwz 20170824 s
DEFINE l_cnt		 LIKE type_file.num5
# add by lixwz 20170824 e
DEFINE
        b_bdate    DATE,
        b_edate    DATE,
        ll_date    LIKE     type_file.chr6,  #type_file.num5,
        ll_date1   LIKE     type_file.chr6,   #type_file.num5
        ll_year    LIKE     type_file.num5,
        ll_month   LIKE     type_file.num5
    LET g_action_choice = ""
    #tianry add 151203
     SELECT YEAR(sma53) INTO ll_year FROM sma_file
         SELECT MONTH(sma53) INTO ll_month FROM sma_file
         IF g_tc_cmm003< ll_year THEN
            CALL cl_err('','coo-999',1)
            RETURN
         END IF
         IF g_tc_cmm003=ll_year THEN
            IF g_tc_cmm004<=  ll_month THEN
               CALL cl_err('','coo-999',1)
               RETURN
            END IF
         END IF
   # IF g_tc_cmm004 < g_sma.sma52 THEN RETURN END IF
    #tianry add end
    IF cl_null(g_tc_cmm003) THEN
       RETURN
    END IF

    CALL cl_opmsg('b')

    LET g_forupd_sql =
       #"SELECT tc_cmm01,'','',tc_cmm03,tc_cmm04,tc_cmm05,tc_cmm07,tc_cmm08,tc_cmm09 FROM tc_cmm_file ",  #CHI-C60013 mark
        "SELECT tc_cmm002,tc_cmm001,'',tc_cmm005,'',tc_cmm006,'','',tc_cmm007,tc_cmm008,tc_cmm009,tc_cmm010,tc_cmm011,tc_cmm012,tc_cmm013, ",               #CHI-C60013
        "       tc_cmmud09,tc_cmmud10,tc_cmmud11,", #add by lixwz 20170824
        "       tc_cmmuser,tc_cmmgrup,tc_cmmmodu,tc_cmmdate,tc_cmmacti FROM tc_cmm_file ",          #CHI-C60013
        " WHERE tc_cmm001 = ? AND tc_cmm002 = ? AND tc_cmm003 = ? AND tc_cmm004 = ? FOR UPDATE "  #No.FUN-670099
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i002_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

    LET l_ac_t = 0
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    INPUT ARRAY g_tc_cmm WITHOUT DEFAULTS FROM s_tc_cmm.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)

        BEFORE INPUT
            IF g_rec_b != 0 THEn
               CALL fgl_set_arr_curr(l_ac)
            END IF


        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()

            BEGIN WORK    #MOD-8B0180

            IF g_rec_b >= l_ac THEN

               LET p_cmd='u'
               LET g_tc_cmm_t.* = g_tc_cmm[l_ac].*  #BACKUP

               OPEN i002_bcl USING g_tc_cmm_t.tc_cmm001, g_tc_cmm_t.tc_cmm002,g_tc_cmm003,g_tc_cmm004  #No.FUN-670099
               IF STATUS THEN
                  CALL cl_err("OPEN i002_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH i002_bcl INTO g_tc_cmm_t.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err(g_tc_cmm_t.tc_cmm002,SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      LET g_tc_cmm_t.*=g_tc_cmm[l_ac].*
 #                     LET g_tc_cmm07_t=g_tc_cmm[l_ac].tc_cmm07  #FUN-910088
                  END IF
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF

        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_cmm[l_ac].* TO NULL      #900423
            LET g_tc_cmm[l_ac].tc_cmm013 = 'Y'
            LET g_tc_cmm[l_ac].tc_cmm008 = g_today
            LET g_tc_cmm[l_ac].tc_cmm010 = g_today
            LET g_tc_cmm[l_ac].tc_cmm009 = '08:00'
            LET g_tc_cmm[l_ac].tc_cmm011 = '18:00'
            LET g_tc_cmm[l_ac].tc_cmmuser = g_user
            LET g_tc_cmm[l_ac].tc_cmmgrup = g_grup
            LET g_tc_cmm[l_ac].tc_cmmdate = g_today
            LET g_tc_cmm[l_ac].tc_cmmacti = 'Y'
           #------CHI-C60013------#
            LET g_tc_cmm_t.* = g_tc_cmm[l_ac].*         #新輸入資料
#            LET g_tc_cmm07_t = NULL              #FUN-910088
            CALL cl_show_fld_cont()     #FUN-550037(smin)
            NEXT FIELD tc_cmm002

        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            INSERT INTO tc_cmm_file(tc_cmm003,tc_cmm004,tc_cmm002,tc_cmm001,tc_cmm005,tc_cmm006,tc_cmm007,
                                 tc_cmm008,tc_cmm009,tc_cmm010,tc_cmm011,tc_cmm012,tc_cmm013,
                                 tc_cmmud09,tc_cmmud10,tc_cmmud11,   # add by lixwz 20170825
                                #tc_cmmuser,tc_cmmgrup,tc_cmmacti,tc_cmmoriu,tc_cmmorig)   #MOD-850286   #CHI-C60013 mark
                                 tc_cmmoriu,tc_cmmorig,tc_cmmuser,tc_cmmgrup,tc_cmmmodu,tc_cmmdate,tc_cmmacti) #CHI-C60013
                          VALUES(g_tc_cmm003,g_tc_cmm004,
                                 g_tc_cmm[l_ac].tc_cmm002,g_tc_cmm[l_ac].tc_cmm001,
                                 g_tc_cmm[l_ac].tc_cmm005,g_tc_cmm[l_ac].tc_cmm006,
                                 g_tc_cmm[l_ac].tc_cmm007,g_tc_cmm[l_ac].tc_cmm008,
                                 g_tc_cmm[l_ac].tc_cmm009,g_tc_cmm[l_ac].tc_cmm010,
                                 g_tc_cmm[l_ac].tc_cmm011,g_tc_cmm[l_ac].tc_cmm012,g_tc_cmm[l_ac].tc_cmm013,
                                 g_tc_cmm[l_ac].tc_cmmud09,g_tc_cmm[l_ac].tc_cmmud10,g_tc_cmm[l_ac].tc_cmmud11, # add by lixwz 20170824
                                #l_tc_cmmuser,l_tc_cmmgrup,l_tc_cmmacti, g_user, g_grup)   #MOD-850286      #No.FUN-980030 10/01/04  insert columns oriu, orig  #CHI-C60013 mark
                                 g_user, g_grup,                                               #CHI-C60013
                                 g_tc_cmm[l_ac].tc_cmmuser,g_tc_cmm[l_ac].tc_cmmgrup,g_tc_cmm[l_ac].tc_cmmmodu,  #CHI-C60013
                                 g_tc_cmm[l_ac].tc_cmmdate,g_tc_cmm[l_ac].tc_cmmacti)                      #CHI-C60013
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_cmm_file",g_tc_cmm003,g_tc_cmm[l_ac].tc_cmm001,SQLCA.sqlcode,"","",1)  #No.FUN-660167
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               #DISPLAY g_rec_b TO FORMONLY.cn2    #MOD-8B0180
            END IF

        BEFORE FIELD tc_cmm002                        #default 序號
          IF g_tc_cmm[l_ac].tc_cmm002 IS NULL OR g_tc_cmm[l_ac].tc_cmm002 = 0 THEN
             SELECT max(tc_cmm002)+1
               INTO g_tc_cmm[l_ac].tc_cmm002
               FROM tc_cmm_file
              WHERE tc_cmm003 = g_tc_cmm003
               AND  tc_cmm004 = g_tc_cmm004
#               AND  tc_cmm001 = g_tc_cmm[l_ac].tc_cmm001
#               AND  tc_cmm002 = g_tc_cmm[l_ac].tc_cmm002
             IF g_tc_cmm[l_ac].tc_cmm002 IS NULL THEN
                LET g_tc_cmm[l_ac].tc_cmm002 = 1
             END IF
          END IF

       AFTER FIELD tc_cmm002                        #check 序號是否重複
          IF NOT cl_null(g_tc_cmm[l_ac].tc_cmm002) THEN
             IF g_tc_cmm[l_ac].tc_cmm002 != g_tc_cmm_t.tc_cmm002 OR
                g_tc_cmm_t.tc_cmm002 IS NULL THEN
                SELECT count(*) INTO l_n FROM tc_cmm_file
                 WHERE tc_cmm001 = g_tc_cmm[l_ac].tc_cmm001
                  AND  tc_cmm002 = g_tc_cmm[l_ac].tc_cmm002
                IF l_n > 0 THEN
                   CALL cl_err('',-239,0)
                   LET g_tc_cmm[l_ac].tc_cmm002 = g_tc_cmm_t.tc_cmm002
                   NEXT FIELD tc_cmm002
                END IF
             END IF
          END IF

        AFTER FIELD tc_cmm001
          SELECT gen02,gen03 INTO g_tc_cmm[l_ac].gen02,g_tc_cmm[l_ac].tc_cmm005 FROM gen_file
           WHERE gen01 = g_tc_cmm[l_ac].tc_cmm001
          SELECT gem02 INTO g_tc_cmm[l_ac].gem02 FROM gem_file WHERE gem01 = g_tc_cmm[l_ac].tc_cmm005
          SELECT tc_coa009 INTO g_tc_cmm[l_ac].tc_cmm006 FROM tc_coa_file WHERE tc_coa001 = g_tc_cmm[l_ac].tc_cmm001
          SELECT tc_gmm003,tc_gmmud01 INTO g_tc_cmm[l_ac].tc_gmm003,g_tc_cmm[l_ac].tc_gmmud01 FROM tc_gmm_file
           WHERE tc_gmm002 = g_tc_cmm[l_ac].tc_cmm006

        AFTER FIELD tc_cmm006
           IF NOT cl_null(g_tc_cmm[l_ac].tc_cmm006) THEN
              SELECT tc_gmm003,tc_gmmud01 INTO g_tc_cmm[l_ac].tc_gmm003,g_tc_cmm[l_ac].tc_gmmud01
               FROM tc_gmm_file WHERE tc_gmm002 = g_tc_cmm[l_ac].tc_cmm006
              NEXT FIELD  tc_cmm007
           END IF
      #tianry add 151204
       AFTER FIELD tc_cmm007
           # add by lixwz 20170824 s
          # 年假/调休假判断是否审核
          IF g_tc_cmm[l_ac].tc_cmm007="1" OR g_tc_cmm[l_ac].tc_cmm007="7" THEN
            LET l_cnt = 0
            SELECT count(*) INTO l_cnt FROM tc_cof_file
                WHERE tc_cofud06 = g_tc_cmm[l_ac].tc_cmm001
                  AND tc_cof007 = g_tc_cmm[l_ac].tc_cmm007
                  AND YEAR(tc_cof004) <= g_tc_cmm003
                  AND MONTH(tc_cof004) <= g_tc_cmm004
                  AND YEAR(tc_cof005) >= g_tc_cmm003
                  AND MONTH(tc_cof005) >= g_tc_cmm004
                  AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'

            IF l_cnt = 0 THEN
                 CALL cl_err('年假/休假单未审核，请审核再录入或选择其它类型','！',1)
                 NEXT FIELD tc_cmm007
            ELSE
            # 带出请假天数等

                SELECT SUM(tc_cof008) INTO g_tc_cmm[l_ac].tc_cmmud09 FROM tc_cof_file
                  WHERE tc_cofud06 = g_tc_cmm[l_ac].tc_cmm001
                    AND tc_cof007 = g_tc_cmm[l_ac].tc_cmm007
                    AND YEAR(tc_cof004) <= g_tc_cmm003
                    AND MONTH(tc_cof004) <= g_tc_cmm004
                    AND YEAR(tc_cof005) >= g_tc_cmm003
                    AND MONTH(tc_cof005) >= g_tc_cmm004
                    AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
                IF cl_null(g_tc_cmm[l_ac].tc_cmmud09) THEN LET g_tc_cmm[l_ac].tc_cmmud09=0 END IF
                #IF NOT cl_null(g_tc_cmm[l_ac].tc_cmm012) THEN

                     SELECT SUM(tc_cmm012) INTO g_tc_cmm[l_ac].tc_cmmud10 FROM tc_cmm_file
                      WHERE tc_cmm003 = g_tc_cmm003
                        AND tc_cmm001 = g_tc_cmm[l_ac].tc_cmm001
                        AND tc_cmm007 = g_tc_cmm[l_ac].tc_cmm007
                    #LET g_tc_cmm[l_ac].tc_cmmud10 = g_tc_cmm[l_ac].tc_cmm012
                    IF cl_null(g_tc_cmm[l_ac].tc_cmmud10) THEN LET g_tc_cmm[l_ac].tc_cmmud10=0 END IF
                    LET g_tc_cmm[l_ac].tc_cmmud11 = g_tc_cmm[l_ac].tc_cmmud09-g_tc_cmm[l_ac].tc_cmmud10
                    DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmmud09,g_tc_cmm[l_ac].tc_cmmud10,g_tc_cmm[l_ac].tc_cmmud11
              	#END IF
            END IF
          END IF
        	# add by lixwz 20170824	e
         IF NOT cl_null(g_tc_cmm[l_ac].tc_cmm007) THEN
            IF g_tc_cmm[l_ac].tc_cmm007='1' OR g_tc_cmm[l_ac].tc_cmm007='7' OR g_tc_cmm[l_ac].tc_cmm007='3' THEN
               LET g_tc_cmm[l_ac].tc_cmm013='N'
               DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm013
            ELSE
               LET g_tc_cmm[l_ac].tc_cmm013='Y'
               DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm013
            END IF
         END IF
        ON CHANGE tc_cmm007
        	# add by lixwz 20170824 s
        	# 年假/调休假判断是否审核
					#	IF g_tc_cmm[l_ac].tc_cmm007='1' OR g_tc_cmm[l_ac].tc_cmm007='7' THEN
#
          #  ELSE
#
          #  END IF
        	# add by lixwz 20170824	e

            IF g_tc_cmm[l_ac].tc_cmm007='1' OR g_tc_cmm[l_ac].tc_cmm007='7' OR g_tc_cmm[l_ac].tc_cmm007='3' THEN
               LET g_tc_cmm[l_ac].tc_cmm013='N'
               DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm013
            ELSE
               LET g_tc_cmm[l_ac].tc_cmm013='Y'
               DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm013
            END IF
      #tianry add end
        AFTER FIELD tc_cmm008
           SELECT to_date(to_char(last_day(sysdate))) INTO l_date FROM dual
           SELECT to_date(l_date,'yy/mm/dd') INTO l_date1 from dual
           IF g_tc_cmm[l_ac].tc_cmm008 < g_sma.sma53 OR g_tc_cmm[l_ac].tc_cmm008 > l_date1 THEN
              CALL cl_err('','coo-004',0)
              NEXT FIELD tc_cmm008
           END IF

        AFTER FIELD tc_cmm009
           LET i = g_tc_cmm[l_ac].tc_cmm009
           LET g_h1 = i.subString(1,2)
           LET g_m1 = i.subString(4,5)
           SELECT sme02 INTO l_sme1 FROM sme_file WHERE sme01 = g_tc_cmm[l_ac].tc_cmm008
           IF l_sme1 = 'N' THEN
              LET g_h1 = 8
           END IF

           IF cl_null(g_h1) OR cl_null(g_m1) OR g_h1>18 OR g_h1<8 OR g_m1>=60 THEN
              CALL cl_err(g_tc_cmm[l_ac].tc_cmm009,'asf-807',0)
              NEXT FIELD tc_cmm009
           END IF
           IF g_h1 = 18 THEN
              IF g_m1 > 0 THEN
                 CALL cl_err(g_tc_cmm[l_ac].tc_cmm011,'asf-807',0)
                 NEXT FIELD tc_cmm009
              END IF
#              LET g_h1 = 8
           END IF
#           LET g_sum_m1=g_h1*60+g_m1
           LET g_sum_h1 = g_h1 + g_m1/60

        AFTER FIELD tc_cmm010
          IF g_tc_cmm[l_ac].tc_cmm010 < g_tc_cmm[l_ac].tc_cmm008 THEN
             CALL cl_err('','coo-003',0)
             NEXT FIELD tc_cmm010
          END IF

        AFTER FIELD tc_cmm011
            CALL s_azm(g_tc_cmm003,g_tc_cmm004) RETURNING l_correct,l_bdate,l_edate
           IF g_tc_cmm[l_ac].tc_cmm008 = g_tc_cmm[l_ac].tc_cmm010 THEN
              IF g_tc_cmm[l_ac].tc_cmm011 <= g_tc_cmm[l_ac].tc_cmm009 THEN
                 CALL cl_err('','coo-003',0)
                 NEXT FIELD tc_cmm011
              END IF
           END IF

           LET j = g_tc_cmm[l_ac].tc_cmm011
           LET g_h2 = j.subString(1,2)
           LET g_m2 = j.subString(4,5)
           SELECT sme02 INTO l_sme1 FROM sme_file WHERE sme01 = g_tc_cmm[l_ac].tc_cmm008
           SELECT sme02 INTO l_sme2 FROM sme_file WHERE sme01 = g_tc_cmm[l_ac].tc_cmm010
           IF l_sme2 = 'N' THEN
              LET g_h2 = 8
           END IF

           IF cl_null(g_h2) OR cl_null(g_m2) OR g_h2>18 OR g_h2<8 OR g_m2>=60 THEN
              CALL cl_err(g_tc_cmm[l_ac].tc_cmm011,'asf-807',0)
              NEXT FIELD tc_cmm011
           END IF

#           LET g_sum_m2=g_h2*60+g_m2
           LET g_sum_h2 = g_h2 + g_m2/60

#         BEFORE FIELD tc_cmm012
#            LET g_day1 = g_tc_cmm[l_ac].tc_cmm010 - g_tc_cmm[l_ac].tc_cmm008
            LET m = g_tc_cmm[l_ac].tc_cmm008
            LET m1 = g_tc_cmm[l_ac].tc_cmm010
            LET g_m = m.subString(4,5)
            LET g_m11 = m1.subString(4,5)
            IF g_m = g_tc_cmm004 AND g_m11 = g_tc_cmm004 THEN
               LET g_day1 = g_tc_cmm[l_ac].tc_cmm010 - g_tc_cmm[l_ac].tc_cmm008
            END IF
            IF g_m = g_tc_cmm004 AND g_m11 != g_tc_cmm004 THEN
               LET g_day1 =  l_edate - g_tc_cmm[l_ac].tc_cmm008
            END IF
            IF g_m != g_tc_cmm004 AND g_m11 = g_tc_cmm004 THEN
               LET g_day1 =  g_tc_cmm[l_ac].tc_cmm010 - l_bdate
            END IF
#            IF g_h1 = 18 THEN
#               LET g_day2 = (g_sum_h2 - 18)/10 +1
#             ELSE
               LET g_day2 = (g_sum_h2 - g_sum_h1)/10
#            END IF
            CASE
              WHEN g_day2>0     AND g_day2<=0.25 LET g_day2 = 0.25
              WHEN g_day2>0.25   AND g_day2<=0.5  LET g_day2 = 0.5
              WHEN g_day2>0.5    AND g_day2<=0.75 LET g_day2 = 0.75
              WHEN g_day2>0.75   AND g_day2<=1    LET g_day2 = 1
              WHEN g_day2>=-1    AND g_day2<-0.75 LET g_day2 = -1
              WHEN g_day2>=-0.75 AND g_day2<-0.5  LET g_day2 = -0.75
              WHEN g_day2>=-0.5  AND g_day2<-0.25 LET g_day2 = -0.5
              WHEN g_day2>=-0.25 AND g_day2<0     LET g_day2 = -0.25
            END CASE

            SELECT sme02 INTO l_sme1 FROM sme_file WHERE sme01 = g_tc_cmm[l_ac].tc_cmm008
            SELECT sme02 INTO l_sme2 FROM sme_file WHERE sme01 = g_tc_cmm[l_ac].tc_cmm010
            IF l_sme1 = 'N' THEN
               LET g_day = g_day1 + g_day2 -1
            END IF
            IF l_sme2 = 'N' THEN
              LET g_day = g_day1 + g_day2
            END IF

            IF l_sme1 = 'Y' AND l_sme2 = 'Y' THEN
               LET g_day = g_day1 + g_day2
            END IF
            IF l_sme1 = 'N' AND l_sme2 = 'N' THEN
               LET g_day = g_day1 + g_day2 -1
            END IF

            IF g_m = g_tc_cmm004 AND g_m11 = g_tc_cmm004 THEN
               SELECT COUNT(DISTINCT(sme01)) INTO l_n1 FROM sme_file,tc_cmm_file
                WHERE (sme01 BETWEEN g_tc_cmm[l_ac].tc_cmm008 AND g_tc_cmm[l_ac].tc_cmm010) AND sme02='N'
            END IF
            IF g_m = g_tc_cmm004 AND g_m11 != g_tc_cmm004 THEN
               SELECT COUNT(DISTINCT(sme01)) INTO l_n1 FROM sme_file,tc_cmm_file
                WHERE (sme01 BETWEEN g_tc_cmm[l_ac].tc_cmm008 AND l_edate) AND sme02='N'
            END IF
            IF g_m != g_tc_cmm004 AND g_m11 = g_tc_cmm004 THEN
               SELECT COUNT(DISTINCT(sme01)) INTO l_n1 FROM sme_file,tc_cmm_file
                WHERE (sme01 BETWEEN l_bdate AND g_tc_cmm[l_ac].tc_cmm010) AND sme02='N'
            END IF
#              AND  tc_cmm001 = g_tc_cmm[l_ac].tc_cmm001 AND tc_cmm004 = g_tc_cmm004
#              AND  tc_cmm002 = g_tc_cmm[l_ac].tc_cmm002 AND tc_cmm003 = g_tc_cmm003
            LET g_tc_cmm[l_ac].tc_cmm012 = g_day - l_n1
                      #add by lidj160310
            # add by lixwz 20170824 s
            IF g_tc_cmm[l_ac].tc_cmm012 > g_tc_cmm[l_ac].tc_cmmud11 THEN
                 CALL cl_err('申请天数不得大于剩余天数','！',1)
                 NEXT FIELD tc_cmm007
                NEXT FIELD tc_cmm008
            END IF
            # 根据cooi101计算出申请天数，已休天数，剩余天数
            #IF g_tc_cmm[l_ac].tc_cmm007 = '1' OR g_tc_cmm[l_ac].tc_cmm007='7' THEN
            #		IF NOT cl_null(g_tc_cmm[l_ac].tc_cmm012) THEN
            #				LET g_tc_cmm[l_ac].tc_cmmud10 = g_tc_cmm[l_ac].tc_cmm012
						#				LET g_tc_cmm[l_ac].tc_cmmud11 = g_tc_cmm[l_ac].tc_cmmud09-g_tc_cmm[l_ac].tc_cmmud10
            #		END IF
            #		DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmmud09,g_tc_cmm[l_ac].tc_cmmud10,g_tc_cmm[l_ac].tc_cmmud11
            #END IF

            # add by lixwz 20170824 e
            DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm012

        AFTER FIELD tc_cmm012
           IF g_tc_cmm[l_ac].tc_cmm012 <= 0 OR g_tc_cmm[l_ac].tc_cmm012 > g_tc_cmm[l_ac].tc_gmmud01 THEN
              CALL cl_err('','coo-003',0)
              NEXT FIELD tc_cmm008
           END IF

        BEFORE DELETE                            #是否取消單身
            IF g_tc_cmm_t.tc_cmm001 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF

                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF

                DELETE FROM tc_cmm_file
                 WHERE tc_cmm003 = g_tc_cmm003
                   AND tc_cmm004 = g_tc_cmm004
                   AND tc_cmm001 = g_tc_cmm_t.tc_cmm001
                   AND tc_cmm002 = g_tc_cmm_t.tc_cmm002   #No.FUN-670099
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("del","tc_cmm_file",g_tc_cmm_t.tc_cmm001,g_tc_cmm003,SQLCA.sqlcode,"","",1)  #No.FUN-660167
                   ROLLBACK WORK
                   CANCEL DELETE
                END IF
                LET g_rec_b = g_rec_b -1   #MOD-780239 add
                COMMIT WORK
            END IF

        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_tc_cmm[l_ac].* = g_tc_cmm_t.*
               CLOSE i002_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_tc_cmm[l_ac].tc_cmm001,-263,1)
               LET g_tc_cmm[l_ac].* = g_tc_cmm_t.*
            ELSE
               LET g_tc_cmm[l_ac].tc_cmmmodu=g_user   #CHI-C60013
               LET g_tc_cmm[l_ac].tc_cmmdate=g_today  #CHI-C60013
               UPDATE tc_cmm_file SET tc_cmm003=g_tc_cmm003,
                                      tc_cmm004=g_tc_cmm004,
                                   tc_cmm002=g_tc_cmm[l_ac].tc_cmm002,
                                   tc_cmm001=g_tc_cmm[l_ac].tc_cmm001,
                                   tc_cmm005=g_tc_cmm[l_ac].tc_cmm005,
                                   tc_cmm006=g_tc_cmm[l_ac].tc_cmm006,
                                   tc_cmm007=g_tc_cmm[l_ac].tc_cmm007,
                                   tc_cmm008=g_tc_cmm[l_ac].tc_cmm008,
                                   tc_cmm009=g_tc_cmm[l_ac].tc_cmm009,
                                   tc_cmm010=g_tc_cmm[l_ac].tc_cmm010,
                                   tc_cmm011=g_tc_cmm[l_ac].tc_cmm011,
                                   tc_cmm012=g_tc_cmm[l_ac].tc_cmm012,
                                   tc_cmm013=g_tc_cmm[l_ac].tc_cmm013,
                                   tc_cmmmodu=g_tc_cmm[l_ac].tc_cmmmodu,   #CHI-C60013
                                   tc_cmmdate=g_tc_cmm[l_ac].tc_cmmdate,   #CHI-C60013
                                   tc_cmmacti=g_tc_cmm[l_ac].tc_cmmacti    #CHI-C60013
                WHERE tc_cmm003 = g_tc_cmm003
                  AND tc_cmm004 = g_tc_cmm004
                  AND tc_cmm001 = g_tc_cmm_t.tc_cmm001
                  AND tc_cmm002 = g_tc_cmm_t.tc_cmm002   #No.FUN-670099
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("upd","tc_cmm_file",g_tc_cmm003,g_tc_cmm_t.tc_cmm001,SQLCA.sqlcode,"","",1)  #No.FUN-660167
                 LET g_tc_cmm[l_ac].* = g_tc_cmm_t.*
                 ROLLBACK WORK
              ELSE
                 MESSAGE 'UPDATE O.K'
                 COMMIT WORK
              END IF

            END IF

        AFTER ROW
            LET l_ac = ARR_CURR()
           #LET l_ac_t = l_ac  #FUN-D30034 mark
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_tc_cmm[l_ac].* = g_tc_cmm_t.*
               #FUN-D30034--add--begin--
               ELSE
                  CALL g_tc_cmm.deleteElement(l_ac)
                  IF g_rec_b != 0 THEN
                     LET g_action_choice = "detail"
                     LET l_ac = l_ac_t
                  END IF
               #FUN-D30034--add--end----
               END IF
               CLOSE i002_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            LET l_ac_t = l_ac   #FUN-D30034 add
            CLOSE i002_bcl
            COMMIT WORK

        ON ACTION controlp
           CASE
              WHEN INFIELD(tc_cmm001)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="cq_cmm"
                   LET g_qryparam.default1 = g_tc_cmm[l_ac].tc_cmm001
                   CALL cl_create_qry() RETURNING g_tc_cmm[l_ac].tc_cmm001,g_tc_cmm[l_ac].gen02,g_tc_cmm[l_ac].tc_cmm005,
                                                  g_tc_cmm[l_ac].tc_cmm006,g_tc_cmm[l_ac].tc_gmm003
                   SELECT gem02 INTO g_tc_cmm[l_ac].gem02 FROM gem_file WHERE gem01 = g_tc_cmm[l_ac].tc_cmm005
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm001
                   DISPLAY BY NAME g_tc_cmm[l_ac].gen02
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm005
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm006
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_gmm003
                   NEXT FIELD tc_cmm001
              WHEN INFIELD(tc_cmm005) #幣別
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gem"
                   LET g_qryparam.default1 = g_tc_cmm[l_ac].tc_cmm005
                   CALL cl_create_qry() RETURNING g_tc_cmm[l_ac].tc_cmm005
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm005
                   NEXT FIELD tc_cmm005
              WHEN INFIELD(tc_cmm006) #銷售單位
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="cq_gmm002"
                   LET g_qryparam.default1 = g_tc_cmm[l_ac].tc_cmm006
                   CALL cl_create_qry() RETURNING g_tc_cmm[l_ac].tc_cmm006
                   DISPLAY BY NAME g_tc_cmm[l_ac].tc_cmm006
                   NEXT FIELD tc_cmm006
            END CASE

        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(tc_cmm002) AND l_ac > 1 THEN
               LET g_tc_cmm[l_ac].* = g_tc_cmm[l_ac-1].*
               NEXT FIELD tc_cmm002
            END IF

        ON ACTION controls                               #No.FUN-6A0092
           CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

        ON ACTION CONTROLR
           CALL cl_show_req_fields()

        ON ACTION CONTROLG
            CALL cl_cmdask()

        ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121


    END INPUT

#No.FUN-D50045 --------- add -------- begin ----------------
    IF g_flag THEN
       LET g_flag = FALSE
       CALL i002_b()
    END IF
#No.FUN-D50045 --------- add -------- end ------------------

END FUNCTION

FUNCTION i002_b_askkey()
DEFINE
    l_wc            LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)

    CONSTRUCT g_wc ON tc_cmm002,tc_cmm001,tc_cmm005,tc_cmm006,tc_cmm007,tc_cmm008,tc_cmm009,tc_cmm010,tc_cmm011,tc_cmm012,tc_cmm013     #螢幕上取條件
        FROM s_tc_cmm[1].tc_cmm002,s_tc_cmm[1].tc_cmm001,s_tc_cmm[1].tc_cmm005,s_tc_cmm[1].tc_cmm006,
             s_tc_cmm[1].tc_cmm007,s_tc_cmm[1].tc_cmm008,s_tc_cmm[1].tc_cmm009,s_tc_cmm[1].tc_cmm010,
             s_tc_cmm[1].tc_cmm011,s_tc_cmm[1].tc_cmm012,s_tc_cmm[1].tc_cmm013
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
    END CONSTRUCT
    IF INT_FLAG THEN RETURN END IF

    CALL i002_b_fill(l_wc)

END FUNCTION

FUNCTION i002_b_fill(p_wc)              #BODY FILL UP
DEFINE
    p_wc            LIKE type_file.chr1000       #No.FUN-680137   VARCHAR(200)

    LET g_sql =
               "SELECT tc_cmm002,tc_cmm001,'',tc_cmm005,'',tc_cmm006,'','',tc_cmm007,tc_cmm008,tc_cmm009,tc_cmm010,tc_cmm011,tc_cmm012,tc_cmm013, ",  #CHI-C60013 add ,
               "       tc_cmmud09,tc_cmmud10,tc_cmmud11,", # add by lixwz 20170825
               "       tc_cmmuser,tc_cmmgrup,tc_cmmmodu,tc_cmmdate,tc_cmmacti ",          #CHI-C60013
               " FROM tc_cmm_file ",
               " WHERE tc_cmm003 = '",g_tc_cmm003,
               "' AND tc_cmm004 = '",g_tc_cmm004,
               "' AND ",p_wc CLIPPED ,
               " ORDER BY tc_cmm001,tc_cmm002,tc_cmm003,tc_cmm004 "
    PREPARE i002_p2 FROM g_sql      #預備一下
    DECLARE tc_cmm_curs CURSOR FOR i002_p2

    CALL g_tc_cmm.clear()
    LET g_cnt = 1

    FOREACH tc_cmm_curs INTO g_tc_cmm[g_cnt].*   #單身 ARRAY 填充
        IF SQLCA.sqlcode THEN
            CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
        SELECT tc_gmm003,tc_gmmud01 INTO g_tc_cmm[g_cnt].tc_gmm003,g_tc_cmm[g_cnt].tc_gmmud01 FROM tc_gmm_file
         WHERE tc_gmm002 = g_tc_cmm[g_cnt].tc_cmm006
        SELECT gen02 INTO g_tc_cmm[g_cnt].gen02 FROM gen_file WHERE gen01 = g_tc_cmm[g_cnt].tc_cmm001
        SELECT gem02 INTO g_tc_cmm[g_cnt].gem02 FROM gem_file WHERE gem01 = g_tc_cmm[g_cnt].tc_cmm005
        LET g_cnt = g_cnt + 1

        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF

    END FOREACH
    CALL g_tc_cmm.deleteElement(g_cnt)

    LET g_rec_b = g_cnt - 1               #告訴I.單身筆數

END FUNCTION

FUNCTION i002_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_cmm TO s_tc_cmm.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )

      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
      ON ACTION first
         CALL i002_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION previous
         CALL i002_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION jump
         CALL i002_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION next
         CALL i002_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION last
         CALL i002_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION exporttoexcel       #FUN-4B0038
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document                #No.FUN-6A0020  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      &include "qry_string.4gl"
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION


{FUNCTION i002_out()
DEFINE
    l_i             LIKE type_file.num5,   #No.FUN-680137 SMALLINT
    sr              RECORD
        tc_cmm02       LIKE tc_cmm_file.tc_cmm02,   #客戶編號
        occ02       LIKE occ_file.occ02,   #客戶簡稱
        tc_cmm01       LIKE tc_cmm_file.tc_cmm01,   #產品編號
        ima02       LIKE ima_file.ima02,   #品名
        ima021      LIKE ima_file.ima021,  #規格
        tc_cmm03       LIKE tc_cmm_file.tc_cmm03,   #客戶的產品編號
        tc_cmm04       LIKE tc_cmm_file.tc_cmm04,   #最近訂單日
        tc_cmm05       LIKE tc_cmm_file.tc_cmm05,   #最近訂單幣別
        tc_cmm07       LIKE tc_cmm_file.tc_cmm07,   #最近訂單銷售單位
        tc_cmm08       LIKE tc_cmm_file.tc_cmm08,   #最近訂單單價
        tc_cmm09       LIKE tc_cmm_file.tc_cmm09    #最近訂單數量
                    END RECORD,
    l_name          LIKE type_file.chr20,               #External(Disk) file name        #No.FUN-680137 VARCHAR(20)
    l_za05          LIKE type_file.chr1000              #No.FUN-680137 VARCHAR(40)

  DEFINE  l_ima02a,l_ima02b LIKE ima_file.ima02
  DEFINE  l_ima021a,l_ima021b LIKE ima_file.ima021

  LET l_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
              " VALUES(?,?)"
  PREPARE insert_prep FROM l_sql
  IF STATUS THEN
     CALL cl_err('insert_prep:',STATUS,1)
     CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
     EXIT PROGRAM
  END IF

  LET l_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table1 CLIPPED,
              " VALUES(?,?,?,?,?,?,?,?,?,?, ?,?,?) "
  PREPARE insert_prep1 FROM l_sql
  IF STATUS THEN
     CALL cl_err('insert_prep1:',STATUS,1)
     CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
     EXIT PROGRAM
  END IF

  CALL cl_del_data(l_table)
  CALL cl_del_data(l_table1)

    IF not cl_null(g_argv1) THEN
        LET g_wc = " tc_cmm02 ='",g_argv1,"'" CLIPPED
    END IF
    IF g_wc IS NULL THEN
        CALL cl_err('','9057',0)
        RETURN
    END IF
    CALL cl_wait()
    SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = 'cooi002'  #No.FUN-840019
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    LET g_sql= "SELECT UNIQUE tc_cmm02 FROM tc_cmm_file ",
               " WHERE ", g_wc CLIPPED,
               " ORDER BY tc_cmm02 "
    PREPARE i002_p1 FROM g_sql                # RUNTIME 編譯
    IF SQLCA.sqlcode THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
    END IF
    DECLARE i002_co                         # CURSOR
        CURSOR FOR i002_p1

    FOREACH i002_co INTO sr.*
        IF SQLCA.sqlcode THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
            DECLARE tc_cmm02_curs CURSOR FOR
                SELECT tc_cmm01,tc_cmm03,tc_cmm04,tc_cmm05,tc_cmm07,tc_cmm08,tc_cmm09  FROM tc_cmm_file
                    WHERE tc_cmm02 = sr.tc_cmm02
            FOREACH tc_cmm02_curs INTO  sr.tc_cmm01,sr.tc_cmm03,sr.tc_cmm04,sr.tc_cmm05,sr.tc_cmm07,sr.tc_cmm08,sr.tc_cmm09
            #no.4560 依幣別取位
            SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
             WHERE azi01 = sr.tc_cmm05
            SELECT ima02,ima021 INTO l_ima02a,l_ima021a FROM ima_file
                WHERE ima01=sr.tc_cmm01
            IF SQLCA.sqlcode THEN
                LET l_ima02a = NULL
                LET l_ima021a = NULL
            END IF
            SELECT ima02,ima021 INTO l_ima02b,l_ima021b FROM ima_file
                WHERE ima01=sr.tc_cmm03
            IF SQLCA.sqlcode THEN
                LET l_ima02b = NULL
                LET l_ima021b = NULL
            END IF
            EXECUTE insert_prep1 USING
                 sr.tc_cmm02,sr.tc_cmm01,l_ima02a,l_ima021a,sr.tc_cmm03,l_ima02b,
                 l_ima021b,sr.tc_cmm04,sr.tc_cmm05,sr.tc_cmm07,sr.tc_cmm08,sr.tc_cmm09,t_azi03
            END FOREACH
       SELECT occ02 INTO sr.occ02 FROM occ_file
           WHERE occ01 = sr.tc_cmm02
       EXECUTE insert_prep USING
              sr.tc_cmm02,sr.occ02
    END FOREACH

    CLOSE i002_co
    ERROR ""

    LET l_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED,"|",
                "SELECT * FROM ",g_cr_db_str CLIPPED,l_table1 CLIPPED

    IF g_zz05 = 'Y' THEN
       CALL cl_wcchp(g_wc,'tc_cmm02,tc_cmm01,tc_cmm03,tc_cmm04,tc_cmm05,tc_cmm07,tc_cmm08,tc_cmm09')
            RETURNING g_str
    END IF

    CALL cl_prt_cs3('cooi002','cooi002',l_sql,g_str)
END FUNCTION
}
