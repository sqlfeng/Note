DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

#模組變數(Module Variables)
DEFINE
    g_tc_gxa01         LIKE tc_gxa_file.tc_gxa01,   #客戶編號 (假單頭)
    g_tc_gxa01_t       LIKE tc_gxa_file.tc_gxa01,   #客戶編號 (假單頭)
    g_tc_gxa02         LIKE tc_gxa_file.tc_gxa02,   #客戶編號 (假單頭)
    g_tc_gxa02_t       LIKE tc_gxa_file.tc_gxa02,   #客戶編號 (假單頭)
    g_tc_gxa03         LIKE tc_gxa_file.tc_gxa03,   #客戶編號 (假單頭)
    g_tc_gxa03_t       LIKE tc_gxa_file.tc_gxa03,   #客戶編號 (假單頭)
    g_gen02            LIKE gen_file.gen02,
    g_gem02            LIKE gem_file.gem02,
    g_tc_coa013        LIKE tc_coa_file.tc_coa013,
    g_tc_gxa07         LIKE tc_gxa_file.tc_gxa07,
    g_tc_gxa07_t       LIKE tc_gxa_file.tc_gxa07,
    g_tc_gxa11         LIKE tc_gxa_file.tc_gxa11,
    g_tc_gxa11_t       LIKE tc_gxa_file.tc_gxa11
DEFINE   g_tc_gxa         DYNAMIC ARRAY OF RECORD
            tc_gxa07         LIKE tc_gxa_file.tc_gxa07,
            tc_gxa10         LIKE tc_gxa_file.tc_gxa10,
            tc_gxa08         LIKE tc_gxa_file.tc_gxa08,
            ima02            LIKE ima_file.ima02,
            ima021           LIKE ima_file.ima021,
            tc_gxa09         LIKE tc_gxa_file.tc_gxa09,
            tc_gxa11         LIKE tc_gxa_file.tc_gxa11,
            ecb06            LIKE ecb_file.ecb06,
            ecd02            LIKE ecd_file.ecd02,
            tc_gxa13         LIKE tc_gxa_file.tc_gxa13,
            tc_ecb01         LIKE ecb_file.tc_ecb01,
            ta_eczud01       LIKE ecz_file.ta_eczud01,
            tc_gxa15         LIKE tc_gxa_file.tc_gxa15,
            tc_gxa14         LIKE tc_gxa_file.tc_gxa14,
            tc_gxa17         LIKE tc_gxa_file.tc_gxa17,
            tc_gxa18         LIKE tc_gxa_file.tc_gxa18,
            tc_gxa16         LIKE tc_gxa_file.tc_gxa16,
            tc_gxa19         LIKE tc_gxa_file.tc_gxa19,
            tc_gxaoriu       LIKE tc_gxa_file.tc_gxaoriu,
            tc_gxaorig       LIKE tc_gxa_file.tc_gxaorig,
            tc_gxauser       LIKE tc_gxa_file.tc_gxauser,
            tc_gxagrup       LIKE tc_gxa_file.tc_gxagrup,
            tc_gxamodu       LIKE tc_gxa_file.tc_gxamodu,
            tc_gxadate       LIKE tc_gxa_file.tc_gxadate,
            tc_gxaacti       LIKE tc_gxa_file.tc_gxaacti
                        END RECORD,
         g_tc_gxa_t          RECORD
            tc_gxa07         LIKE tc_gxa_file.tc_gxa07,
            tc_gxa10         LIKE tc_gxa_file.tc_gxa10,
            tc_gxa08         LIKE tc_gxa_file.tc_gxa08,
            ima02            LIKE ima_file.ima02,
            ima021           LIKE ima_file.ima021,
            tc_gxa09         LIKE tc_gxa_file.tc_gxa09,
            tc_gxa11         LIKE tc_gxa_file.tc_gxa11,
            ecb06            LIKE ecb_file.ecb06,
            ecd02            LIKE ecd_file.ecd02,
            tc_gxa13         LIKE tc_gxa_file.tc_gxa13,
            tc_ecb01         LIKE ecb_file.tc_ecb01,
            ta_eczud01       LIKE ecz_file.ta_eczud01,
            tc_gxa15         LIKE tc_gxa_file.tc_gxa15,
            tc_gxa14         LIKE tc_gxa_file.tc_gxa14,
            tc_gxa17         LIKE tc_gxa_file.tc_gxa17,
            tc_gxa18         LIKE tc_gxa_file.tc_gxa18,
            tc_gxa16         LIKE tc_gxa_file.tc_gxa16,
            tc_gxa19         LIKE tc_gxa_file.tc_gxa19,
            tc_gxaoriu       LIKE tc_gxa_file.tc_gxaoriu,
            tc_gxaorig       LIKE tc_gxa_file.tc_gxaorig,
            tc_gxauser       LIKE tc_gxa_file.tc_gxauser,
            tc_gxagrup       LIKE tc_gxa_file.tc_gxagrup,
            tc_gxamodu       LIKE tc_gxa_file.tc_gxamodu,
            tc_gxadate       LIKE tc_gxa_file.tc_gxadate,
            tc_gxaacti       LIKE tc_gxa_file.tc_gxaacti
                        END RECORD,
    g_argv1         LIKE obk_file.obk02,
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
DEFINE   g_obk07_t      LIKE obk_file.obk07          #NO.FUN-910088
DEFINE   g_flag         LIKE type_file.chr1    #FUN-D50045 add
DEFINE   l_cc           LIKE type_file.num5
DEFINE   g_gxa04        LIKE tc_gxa_file.tc_gxa04
DEFINE   g_type         LIKE type_file.chr1    #add by sunar160516
DEFINE   g_t  LIKE type_file.num5

DEFINE   g_t2  LIKE type_file.num5
DEFINE   g_success_wx LIKE type_file.chr1


MAIN

     OPTIONS
         INPUT NO WRAP
     DEFER INTERRUPT


    IF (NOT cl_user()) THEN
       EXIT PROGRAM
    END IF

    WHENEVER ERROR CALL cl_err_msg_log

    IF (NOT cl_setup("CSF")) THEN
       EXIT PROGRAM
    END IF
    LET g_t = YEAR(g_today)

      CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818 #NO.FUN-6A0094

    LET g_tc_gxa01_t = NULL                   #消除鍵值
    LET g_tc_gxa03_t = NULL
    LET g_tc_gxa07_t = NULL
    LET g_tc_gxa11_t = NULL

    LET p_row = 2 LET p_col = 12

    OPEN WINDOW t001_w AT p_row,p_col
         WITH FORM "csf/42f/csft001"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_init()


    SELECT aaa04,aaa05 INTO g_t,g_t2 FROM aaa_file #add by wangxu161103

    CALL t001_menu()

    CLOSE WINDOW t001_w                   #結束畫面
      CALL cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #NO.FUN-6A0094
         RETURNING g_time                 #NO.FUN-6A0094

END MAIN

#QBE 查詢資料
FUNCTION t001_curs()
    CLEAR FORM                            #清除畫面
    CALL g_tc_gxa.clear()
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

        CONSTRUCT g_wc ON tc_gxa01,tc_gxa02,tc_gxa03,tc_gxa07,tc_gxa10,tc_gxa08,ecb06,tc_gxa17,tc_gxa19,tc_gxaacti    #螢幕上取條件
            FROM tc_gxa01,tc_gxa02,tc_gxa03,s_tc_gxa[1].tc_gxa07,s_tc_gxa[1].tc_gxa10,
            s_tc_gxa[1].tc_gxa08,s_tc_gxa[1].ecb06,s_tc_gxa[1].tc_gxa17,s_tc_gxa[1].tc_gxa19,s_tc_gxa[1].tc_gxaacti

              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
            ON ACTION controlp
               CASE
                  WHEN INFIELD(tc_gxa02)
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = "c"
                       LET g_qryparam.form = "q_gem"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_gxa02
                       NEXT FIELD tc_gxa02
                  WHEN INFIELD(tc_gxa03)
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = "c"
                       LET g_qryparam.form = "q_gen"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_gxa03
                       NEXT FIELD tc_gxa03
                  WHEN INFIELD(tc_gxa07)
                       CALL cl_init_qry_var()
                       LET g_qryparam.state = 'c'
                       LET g_qryparam.form = "q_sfb002"
                       CALL cl_create_qry() RETURNING g_qryparam.multiret
                       DISPLAY g_qryparam.multiret TO tc_gxa07
                       NEXT FIELD tc_gxa07
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

    LET g_sql= "SELECT UNIQUE tc_gxa01,tc_gxa02,tc_gxa03 FROM tc_gxa_file ",
               " WHERE ", g_wc CLIPPED,
               " ORDER BY tc_gxa01,tc_gxa02,tc_gxa03 "
    PREPARE t001_prepare FROM g_sql      #預備一下
    DECLARE t001_b_curs                  #宣告成可捲動的
        SCROLL CURSOR WITH HOLD FOR t001_prepare
    #因主鍵值有兩個故所抓出資料筆數有誤
    DROP TABLE x
    LET g_sql = "SELECT COUNT(DISTINCT (tc_gxa01||tc_gxa02||tc_gxa03)) FROM tc_gxa_file",
                " WHERE ",g_wc CLIPPED
    PREPARE t001_precount FROM g_sql
    DECLARE t001_count CURSOR FOR t001_precount
END FUNCTION

FUNCTION t001_menu()
   #CALL cl_set_comp_visible("tc_gxaoriu,tc_gxaorig,tc_gxauser,tc_gxagrup,tc_gxamodu,tc_gxadate,tc_gxaacti",FALSE)
   WHILE TRUE
      CALL t001_bp("G")
      LET g_success_wx = NULL
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t001_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t001_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t001_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t001_u()
            END IF
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL t001_copy()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t001_b()
            ELSE
               LET g_action_choice = NULL
            END IF

         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
{         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_obk),'','')
            END IF
         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_obk02 IS NOT NULL THEN
                 LET g_doc.column1 = "obk02"
                 LET g_doc.value1 = g_obk02
                 CALL cl_doc()
               END IF
         END IF}
      END CASE
   END WHILE
END FUNCTION


FUNCTION t001_a()
    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
    CALL g_tc_gxa.clear()
    INITIALIZE g_tc_gxa01 LIKE tc_gxa_file.tc_gxa01
    INITIALIZE g_tc_gxa02 LIKE tc_gxa_file.tc_gxa02
    INITIALIZE g_tc_gxa03 LIKE tc_gxa_file.tc_gxa03
    INITIALIZE g_tc_gxa07 LIKE tc_gxa_file.tc_gxa07
    INITIALIZE g_tc_gxa11 LIKE tc_gxa_file.tc_gxa11
    CLOSE t001_b_curs
    LET g_tc_gxa01_t = NULL
    LET g_tc_gxa02_t = NULL
    LET g_tc_gxa03_t = NULL
    LET g_tc_gxa07_t = NULL
    LET g_tc_gxa11_t = NULL
    LET g_wc      = NULL
    CALL cl_opmsg('a')
    WHILE TRUE
        LET g_tc_gxa01 = g_today - 1    #add by lidj151101
        CALL t001_i("a")                #輸入單頭
        IF g_success_wx = 'N' THEN
            CALL cl_err('',9001,0)
            RETURN
        END IF
        #IF INT_FLAG THEN                   #使用者不玩了   #mark by sunar160516
        IF INT_FLAG OR g_type = 'N' THEN    #modify by sunar160516
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF

        LET g_rec_b=0                               #No.FUN-680064
        IF g_ss='N' THEN
            FOR g_cnt = 1 TO g_tc_gxa.getLength()
                INITIALIZE g_tc_gxa[g_cnt].* TO NULL
            END FOR
        ELSE
            CALL t001_b_fill(' 1=1')          #單身
        END IF

        CALL t001_b()                        #輸入單身
        IF SQLCA.sqlcode THEN
            CALL cl_err(g_tc_gxa07,SQLCA.sqlcode,0)
        END IF
        LET g_tc_gxa01_t = g_tc_gxa01                 #保留舊值
        LET g_tc_gxa02_t = g_tc_gxa02
        LET g_tc_gxa03_t = g_tc_gxa03
        EXIT WHILE
    END WHILE
END FUNCTION

FUNCTION t001_u()
    DEFINE  l_buf      LIKE cob_file.cob08        #No.FUN-680137 VARCHAR(30)

    IF s_shut(0) THEN RETURN END IF
    IF g_chkey = 'N' THEN
       CALL cl_err(g_tc_gxa01,'aoo-085',0)
       RETURN
    END IF
    IF cl_null(g_tc_gxa01) OR cl_null(g_tc_gxa03) THEN
        CALL cl_err('',-400,0)
        RETURN
    END IF
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_tc_gxa01_t = g_tc_gxa01
    LET g_tc_gxa02_t = g_tc_gxa02
    LET g_tc_gxa03_t = g_tc_gxa03
    BEGIN WORK
    WHILE TRUE
        CALL t001_i("u")         #欄位更改
        IF g_success_wx = 'N' THEN
            CALL cl_err('',9001,0)
            RETURN
        END IF
        IF INT_FLAG THEN
            LET g_tc_gxa01 = g_tc_gxa01_t
            LET g_tc_gxa02 = g_tc_gxa02_t
            LET g_tc_gxa03 = g_tc_gxa03_t
            DISPLAY g_tc_gxa01 TO tc_gxa01               #單頭
            DISPLAY g_tc_gxa02 TO tc_gxa02
            DISPLAY g_tc_gxa03 TO tc_gxa03
            LET INT_FLAG = 0
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF
        IF g_tc_gxa01 != g_tc_gxa01_t OR g_tc_gxa02 != g_tc_gxa02_t OR g_tc_gxa03 != g_tc_gxa03_t
            THEN  UPDATE tc_gxa_file SET tc_gxa01 = g_tc_gxa01,tc_gxa02 = g_tc_gxa02,tc_gxa03 = g_tc_gxa03 #更新DB
                WHERE tc_gxa01 = g_tc_gxa01_t AND tc_gxa02 = g_tc_gxa02_t AND tc_gxa03 = g_tc_gxa03_t
            IF SQLCA.sqlcode THEN
                LET l_buf = g_tc_gxa03 clipped
                CALL cl_err3("upd","tc_gxa_file",g_tc_gxa03_t,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
                CONTINUE WHILE
            END IF
        END IF
        EXIT WHILE
    END WHILE
    COMMIT WORK
END FUNCTION

#處理INPUT
FUNCTION t001_i(p_cmd)
DEFINE
    p_cmd           LIKE type_file.chr1,          #a:輸入 u:更改   #No.FUN-680137 VARCHAR(1)
    l_buf           LIKE type_file.chr1000,       #No.FUN-680137 VARCHAR(60)
    l_n             LIKE type_file.num5,          #No.FUN-680137 SMALLINT
    l_occ02         LIKE occ_file.occ02           #客戶簡稱
DEFINE l_yy,l_mm    LIKE type_file.num5

    LET g_ss = 'Y'
    LET g_type='Y'       #add by sunar160516
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    INPUT g_tc_gxa01,g_tc_gxa02,g_tc_gxa03 WITHOUT DEFAULTS
        FROM tc_gxa01,tc_gxa02,tc_gxa03

       AFTER FIELD tc_gxa01
          #mark by xujw170105--begin--
          #  #add by wangxu 不可录入非会计期间的数据
          # CALL s_yp(g_tc_gxa01) RETURNING l_yy,l_mm
          # SELECT aaa04,aaa05 INTO g_t,g_t2 FROM aaa_file
          # IF l_yy!= g_t OR l_mm < g_t2 THEN
          #      CALL cl_err('','csft_98',1)
          #      LET g_success_wx = 'N'
          #      RETURN
          # END IF
          # #add end wangxu
          #mark by xujw170105--end--
          #add by xujw170105--begin--
           IF NOT cl_null(g_tc_gxa01) THEN
               IF g_sma.sma53 IS NOT NULL AND g_tc_gxa01 <= g_sma.sma53 THEN
                  CALL cl_err('','mfg9999',0) NEXT FIELD tc_gxa01
               END IF
               CALL s_yp(g_tc_gxa01) RETURNING l_yy,l_mm
               IF (l_yy*12+l_mm) > (g_sma.sma51*12+g_sma.sma52) THEN
                  CALL cl_err(l_yy,'mfg6090',0) NEXT FIELD tc_gxa01
               END IF
           END IF
          #add by xujw170105--end--
           IF g_tc_gxa01 IS NULL THEN
               NEXT FIELD tc_gxa01
           END IF

       AFTER FIELD tc_gxa02
           IF cl_null(g_tc_gxa02) THEN
              CALL cl_err(g_tc_gxa02,'t001-22',0)
              NEXT FIELD tc_gxa02
           END IF
           IF NOT cl_null(g_tc_gxa02) THEN
                SELECT gem02 INTO g_gem02 FROM gem_file WHERE gem01 = g_tc_gxa02
                DISPLAY  g_gem02 TO gem02
                IF NOT cl_null(g_tc_gxa03) THEN
                    SELECT COUNT(*) INTO l_cc FROM gen_file WHERE gen01 = g_tc_gxa03 AND gen03 = g_tc_gxa02
                    IF l_cc=0 THEN NEXT FIELD tc_gxa02 END IF
                END IF
           END IF

       AFTER FIELD tc_gxa03
           IF NOT cl_null(g_tc_gxa03) THEN
                SELECT gen02 INTO g_gen02 FROM gen_file WHERE gen01 = g_tc_gxa03
                SELECT tc_coa013 INTO g_tc_coa013 FROM tc_coa_file WHERE tc_coa001 = g_tc_gxa03
                #add by sunar160516----------begin-----------
                IF g_tc_coa013 !='2' THEN
                   CALL cl_err('工资类别不符，请修改后再录入','！',1)
                   LET g_type = 'N'
                END IF
                #add by sunar160516----------end-------------
                DISPLAY g_gen02 TO gen02
                DISPLAY g_tc_coa013 TO tc_coa013
                IF NOT cl_null(g_tc_gxa02) THEN
                    SELECT COUNT(*) INTO l_cc FROM gen_file WHERE gen01 = g_tc_gxa03 AND gen03 = g_tc_gxa02
                    IF l_cc=0 THEN NEXT FIELD tc_gxa02 END IF
                END IF
           ELSE
                NEXT FIELD tc_gxa03
           END IF

        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913


        ON ACTION controlp
         CASE
            WHEN INFIELD(tc_gxa02)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_gem"
              LET g_qryparam.default1 = g_tc_gxa02
              CALL cl_create_qry() RETURNING g_tc_gxa02
              DISPLAY g_tc_gxa02 TO tc_gxa02
              NEXT FIELD tc_gxa02
            WHEN INFIELD(tc_gxa03)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_gen"
              LET g_qryparam.default1 = g_tc_gxa03
              IF NOT cl_null(g_tc_gxa02) THEN
                    LET g_qryparam.where = "gen03 = '",g_tc_gxa02,"'"
              END IF
              CALL cl_create_qry() RETURNING g_tc_gxa03
              DISPLAY g_tc_gxa03 TO tc_gxa03
              NEXT FIELD tc_gxa03
           OTHERWISE EXIT CASE
         END CASE

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
FUNCTION t001_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_tc_gxa01 TO NULL               #No.FUN-6A0020
    INITIALIZE g_tc_gxa02 TO NULL
    INITIALIZE g_tc_gxa03 TO NULL

    CALL cl_opmsg('q')

    MESSAGE ""
    CLEAR FORM
    CALL g_tc_gxa.clear()

    CALL t001_curs()                         #取得查詢條件

    IF INT_FLAG THEN                         #使用者不玩了
        LET INT_FLAG = 0
        RETURN
    END IF

    OPEN t001_b_curs                         #從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN                    #有問題
       CALL cl_err('',SQLCA.sqlcode,0)
       INITIALIZE g_tc_gxa01 TO NULL
       INITIALIZE g_tc_gxa02 TO NULL
       INITIALIZE g_tc_gxa03 TO NULL
       INITIALIZE g_tc_gxa07 TO NULL
       INITIALIZE g_tc_gxa11 TO NULL
    ELSE
       CALL t001_fetch('F')            #讀出TEMP第一筆並顯示
       OPEN t001_count
       FETCH t001_count INTO g_row_count
       DISPLAY g_row_count TO FORMONLY.cnt
    END IF

END FUNCTION

#處理資料的讀取
FUNCTION t001_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1                  #處理方式        #No.FUN-680137 VARCHAR(1)

    MESSAGE ""
    CASE p_flag
        WHEN 'N' FETCH NEXT     t001_b_curs INTO g_tc_gxa01,g_tc_gxa02,g_tc_gxa03
        WHEN 'P' FETCH PREVIOUS t001_b_curs INTO g_tc_gxa01,g_tc_gxa02,g_tc_gxa03
        WHEN 'F' FETCH FIRST    t001_b_curs INTO g_tc_gxa01,g_tc_gxa02,g_tc_gxa03
        WHEN 'L' FETCH LAST     t001_b_curs INTO g_tc_gxa01,g_tc_gxa02,g_tc_gxa03
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
            FETCH ABSOLUTE g_jump t001_b_curs INTO g_tc_gxa01,g_tc_gxa02,g_tc_gxa03
            LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN                         #有麻煩
       CALL cl_err(g_tc_gxa03,SQLCA.sqlcode,0)
       INITIALIZE g_tc_gxa01 TO NULL  #TQC-6B0105
       INITIALIZE g_tc_gxa02 TO NULL
       INITIALIZE g_tc_gxa03 TO NULL
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
    CALL t001_show()
END FUNCTION

#將資料顯示在畫面上
FUNCTION t001_show()
 DEFINE  l_n LIKE type_file.num5
    SELECT COUNT(*) INTO l_n FROM tc_gxa_file WHERE tc_gxa01=g_tc_gxa01 AND tc_gxa03=g_tc_gxa03

    IF l_n = 0 THEN
        LET g_tc_gxa01=''
        LET g_tc_gxa03=''
    END IF
    DISPLAY g_tc_gxa01 TO tc_gxa01               #單頭
    DISPLAY g_tc_gxa02 TO tc_gxa02
    DISPLAY g_tc_gxa03 TO tc_gxa03
    SELECT gem02 INTO g_gem02 FROM gem_file WHERE gem01 = g_tc_gxa02
    SELECT gen02 INTO g_gen02 FROM gen_file WHERE gen01 = g_tc_gxa03
    SELECT tc_coa013 INTO g_tc_coa013 FROM tc_coa_file WHERE tc_coa001 = g_tc_gxa03
    DISPLAY g_gem02 TO gem02
    DISPLAY g_gen02 TO gen02
    DISPLAY g_tc_coa013 TO tc_coa013


    CALL t001_b_fill(g_wc)                 #單身

    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION

#取消整筆 (所有合乎單頭的資料)
FUNCTION t001_r()
    IF s_shut(0) THEN RETURN END IF
    IF g_tc_gxa01 IS NULL OR g_tc_gxa03 IS NULL THEN
       CALL cl_err("",-400,0)                 #No.FUN-6A0020
       RETURN
    END IF

    BEGIN WORK

    IF cl_delh(0,0) THEN                   #確認一下
        IF cl_null(g_tc_gxa02) THEN LET g_tc_gxa02=' ' END IF
        IF cl_null(g_tc_gxa03) THEN LET g_tc_gxa03=' ' END IF
        DELETE FROM tc_gxa_file WHERE tc_gxa01 = g_tc_gxa01 AND tc_gxa02 = g_tc_gxa02 AND tc_gxa03 = g_tc_gxa03
        IF SQLCA.sqlcode THEN
            CALL cl_err3("del","tc_gxa_file",g_tc_gxa03,"",SQLCA.sqlcode,"","BODY DELETE",1)  #No.FUN-660167
        ELSE
            CLEAR FORM
            CALL g_tc_gxa.clear()
            LET g_cnt=SQLCA.SQLERRD[3]
            MESSAGE 'Remove (',g_cnt USING '####&',') Row(s)'
            OPEN t001_count
            #FUN-B50064-add-start--
            IF STATUS THEN
               CLOSE t001_b_curs
               CLOSE t001_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50064-add-end--
            FETCH t001_count INTO g_row_count
            #FUN-B50064-add-start--
            IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
               CLOSE t001_b_curs
               CLOSE t001_count
               COMMIT WORK
               RETURN
            END IF
            #FUN-B50064-add-end--
            DISPLAY g_row_count TO FORMONLY.cnt
            OPEN t001_b_curs
            IF g_curs_index = g_row_count + 1 THEN
               LET g_jump = g_row_count
               CALL t001_fetch('L')
            ELSE
               LET g_jump = g_curs_index
               LET mi_no_ask = TRUE
               CALL t001_fetch('/')
            END IF
        END IF
    END IF

    COMMIT WORK

END FUNCTION

#單身
FUNCTION t001_b()
DEFINE
    l_imaacti       LIKE ima_file.imaacti, #MOD-710048 add
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT #No.FUN-680137 SMALLINT
    l_n             LIKE type_file.num5,                #檢查重複用        #No.FUN-680137 SMALLINT
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住否        #No.FUN-680137 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,                #處理狀態          #No.FUN-680137 VARCHAR(1)
    l_allow_insert  LIKE type_file.num5,                #可新增否          #No.FUN-680137 SMALLINT
    l_allow_delete  LIKE type_file.num5,                #可刪除否          #No.FUN-680137 SMALLINT
    l_i             LIKE type_file.num5,
    l_sum           LIKE sfs_file.sfs05,
    l_sum1          LIKE sfs_file.sfs05,
    l_sfb39         LIKE sfb_file.sfb39,
    l_sfb081        LIKE sfb_file.sfb081,
    l_sfb09         LIKE sfb_file.sfb09,
    l_ima153        LIKE ima_file.ima153,
    l_cnt           LIKE type_file.num5,
    l_yy,l_mm       LIKE type_file.num5     #add by wangxu
DEFINE l_chk        LIKE type_file.num5     # add by lixwz 20170825
    LET g_action_choice = ""


    IF cl_null(g_tc_gxa01) OR cl_null(g_tc_gxa03) THEN
       RETURN
    END IF

    CALL cl_opmsg('b')

    LET g_forupd_sql =
       #"SELECT obk01,'','',obk03,obk04,obk05,obk07,obk08,obk09 FROM obk_file ",  #CHI-C60013 mark
        "SELECT tc_gxa07,tc_gxa10,tc_gxa08,'','',tc_gxa09,tc_gxa11,'','',tc_gxa13,'','',tc_gxa15,tc_gxa14, ",               #CHI-C60013
        "tc_gxa17,tc_gxa18,tc_gxa16,tc_gxa19,tc_gxaoriu,tc_gxaorig,tc_gxauser,tc_gxagrup, ",
        "tc_gxamodu,tc_gxadate,tc_gxaacti ",
        "        FROM tc_gxa_file ",          #CHI-C60013
        " WHERE  tc_gxa01 = ? AND tc_gxa02 = ? and tc_gxa03 = ? and tc_gxa07 = ? and tc_gxa11 = ?  FOR UPDATE "  #No.FUN-670099
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t001_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

    LET l_ac_t = 0
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
   #mark by xujw170105--begin--
   ##add by wangxu   非本月数据不可异动
   # CALL s_yp(g_tc_gxa01) RETURNING l_yy,l_mm
   # IF l_yy!= g_t OR l_mm < g_t2 THEN
   #     CALL cl_err('','csft_99',1)
   #     LET g_success_wx = 'N'
   #     RETURN
   # END IF
   #mark by xujw170105--end--

    INPUT ARRAY g_tc_gxa WITHOUT DEFAULTS FROM s_tc_gxa.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)

        BEFORE INPUT
            IF g_rec_b != 0 THEN
                CALL fgl_set_arr_curr(l_ac)
            END IF
            CALL cl_set_comp_entry("tc_gxa07,tc_gxa15,tc_gxa17,tc_gxa18,tc_gxaacti",TRUE)
            CALL cl_set_comp_entry("tc_gxa08,tc_gxa09,tc_gxa10,tc_gxa11,tc_gxa12,tc_gxa13,tc_gxa14,tc_gxa16,tc_gxa19,ecb06,tc_ecb01,tc_gxaoriu,tc_gxaorig,tc_gxauser,tc_gxagrup,tc_gxamodu,tc_gxadate,ima02,ima021,ecd02,ta_eczud01",FALSE)
            # add by lixwz 20170825 s
            # 未审核不能输入天数
            LET l_chk = 0
            SELECT COUNT(*) INTO l_chk FROM tc_cof_file
              WHERE tc_cofud06 = g_tc_gxa03
                AND tc_cof007 = "2"
                AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
            IF l_chk > 0 THEN
                CALL cl_set_comp_entry("tc_gxa18",TRUE)
                CALL cl_set_comp_required("tc_gxa18",TRUE)
                #INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                #INITIALIZE g_tc_gxa[l_ac].tc_gxa16 TO NULL
            ELSE
                CALL cl_set_comp_entry("tc_gxa18",FALSE)
                CALL cl_set_comp_required("tc_gxa18",FALSE)
            END IF
            # add by lixwz 20170825 e

        AFTER FIELD tc_gxa07
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa07) THEN
               SELECT COUNT(*) INTO l_i FROM sfb_file WHERE sfb01=g_tc_gxa[l_ac].tc_gxa07
               IF l_i=0 THEN
                  CALL cl_err('','csf-005',1)
                  NEXT FIELD tc_gxa07
               END IF
                SELECT sfb05,sfb08,oeb01,sfb98 INTO g_tc_gxa[l_ac].tc_gxa08,
                g_tc_gxa[l_ac].tc_gxa09,g_tc_gxa[l_ac].tc_gxa10,g_tc_gxa[l_ac].tc_gxa19 FROM sfb_file
                LEFT JOIN oeb_file ON sfb919 = oeb919 AND sfb05 = oeb04
                WHERE sfb02 IN('1','5','11','13') AND sfb04 IN('4','5','6','7') AND sfb01 = g_tc_gxa[l_ac].tc_gxa07  #add 5 in sfb02 by shids 151125
                SELECT ima02,ima021 INTO g_tc_gxa[l_ac].ima02,g_tc_gxa[l_ac].ima021 FROM ima_file
                WHERE ima01= g_tc_gxa[l_ac].tc_gxa08
            END IF
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                CALL cl_set_comp_entry("ecb06",TRUE)
            END IF
            SELECT COUNT(*) INTO l_i FROM sfb_file WHERE sfb01 = g_tc_gxa[l_ac].tc_gxa07 AND sfb28 = '3'
            IF l_i>0 THEN
                NEXT FIELD tc_gxa07
            END IF

        ON CHANGE tc_gxa07
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa07) THEN
                SELECT sfb05,sfb08,oeb01,sfb98 INTO g_tc_gxa[l_ac].tc_gxa08,
                g_tc_gxa[l_ac].tc_gxa09,g_tc_gxa[l_ac].tc_gxa10,g_tc_gxa[l_ac].tc_gxa19 FROM sfb_file
                LEFT JOIN oeb_file ON sfb919 = oeb919 AND sfb05 = oeb04
                WHERE sfb02 IN('1','5','11','13') AND sfb04 IN('4','5','6','7') AND sfb01 = g_tc_gxa[l_ac].tc_gxa07   #add 5 in sfb02 by shids 151125
                SELECT ima02,ima021 INTO g_tc_gxa[l_ac].ima02,g_tc_gxa[l_ac].ima021 FROM ima_file
                WHERE ima01= g_tc_gxa[l_ac].tc_gxa08
            END IF
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                CALL cl_set_comp_entry("ecb06",TRUE)
            END IF
        AFTER FIELD tc_gxa11
            #IF cl_null(g_tc_gxa[l_ac].tc_gxa11) THEN
            #    NEXT FIELD tc_gxa11
            #END IF
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa11) AND NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                SELECT ecb06,tc_ecb01,tc_ecz02,ecb38,ecd02,ta_eczud01 INTO g_tc_gxa[l_ac].ecb06,
                g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13,g_tc_gxa[l_ac].ecd02,
                g_tc_gxa[l_ac].ta_eczud01 FROM ecb_file LEFT JOIN ecz_file ON ecz01=ecb06 AND tc_ecz01=tc_ecb01
                LEFT JOIN ecd_file ON ecd01=ecb06
                WHERE ecb01=g_tc_gxa[l_ac].tc_gxa08 AND ecb03 = g_tc_gxa[l_ac].tc_gxa11
            END IF
        AFTER FIELD ecb06
            IF cl_null(g_tc_gxa[l_ac].ecb06) THEN
                NEXT FIELD ecb06
            #tianry add 151204
            ELSE
               SELECT COUNT(*) INTO l_cnt FROM ecu_file WHERE ecu01=g_tc_gxa[l_ac].tc_gxa08 AND ecu10='N'
               IF l_cnt>0 THEN
                  CALL cl_err('','ece-001',1)
                  NEXT FIELD ecb06
               END IF
            END IF

        ON CHANGE ecb06
            IF NOT cl_null(g_tc_gxa[l_ac].ecb06) AND NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                SELECT ecb03,tc_ecb01,tc_ecz02,ecb38,ecd02,ta_eczud01 INTO g_tc_gxa[l_ac].tc_gxa11,
                g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13,g_tc_gxa[l_ac].ecd02,
                g_tc_gxa[l_ac].ta_eczud01 FROM ecb_file LEFT JOIN ecz_file ON ecz01=ecb06 AND tc_ecz01=tc_ecb01
                LEFT JOIN ecd_file ON ecd01=ecb06
                WHERE ecb01=g_tc_gxa[l_ac].tc_gxa08 AND ecb06 = g_tc_gxa[l_ac].ecb06
            END IF
        AFTER FIELD tc_gxa17
        IF g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
                INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
               #CALL cl_set_comp_entry("tc_gxa18",FALSE)
               #CALL cl_set_comp_required("tc_gxa18",FALSE)
                IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa15) AND NOT cl_null(g_tc_gxa[l_ac].tc_gxa14) AND g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
                    LET g_tc_gxa[l_ac].tc_gxa16 = g_tc_gxa[l_ac].tc_gxa15*g_tc_gxa[l_ac].tc_gxa14
                END IF
            ELSE
                # add by lixwz 20170825 s
                # 未审核不能输入天数
                #LET l_chk = 0
                #SELECT COUNT(*) INTO l_chk FROM tc_cof_file
                #  WHERE tc_cofud06 = g_tc_gxa03
                #    AND tc_cof007 = "2"
                #    AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                #    AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
                #IF l_chk > 0 THEN
                #    CALL cl_set_comp_entry("tc_gxa18",TRUE)
                #    CALL cl_set_comp_required("tc_gxa18",TRUE)
                #    INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                #    INITIALIZE g_tc_gxa[l_ac].tc_gxa16 TO NULL
                #ELSE
                #    CALL  cl_err('计时单未审核，请审核再录入或选择其它类型','！',1)
                #    LET g_tc_gxa[l_ac].tc_gxa16 ='Y'
                #    DISPLAY BY NAME g_tc_gxa[l_ac].tc_gxa16
                #    NEXT FIELD tc_gxa17
                #END IF
                # add by lixwz 20170825 e

            END IF
            LET g_gxa04 =0
                FOR l_i = 1 TO g_tc_gxa.getLength()
                    IF cl_null(g_tc_gxa[l_i].tc_gxa16) THEN
                        LET g_tc_gxa[l_i].tc_gxa16 = 0
                    END IF
                    IF g_tc_gxa[l_i].tc_gxa17 = 'Y' THEN
                        LET g_gxa04 = g_gxa04 + g_tc_gxa[l_i].tc_gxa16
                    END IF
                END FOR
            DISPLAY g_gxa04 TO gxa04

        ON CHANGE  tc_gxa17
            IF g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
                INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                #CALL cl_set_comp_entry("tc_gxa18",FALSE)
                #CALL cl_set_comp_required("tc_gxa18",FALSE)
                IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa15) AND NOT cl_null(g_tc_gxa[l_ac].tc_gxa14) AND g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
                    LET g_tc_gxa[l_ac].tc_gxa16 = g_tc_gxa[l_ac].tc_gxa15*g_tc_gxa[l_ac].tc_gxa14
                END IF
            ELSE
                ## add by lixwz 20170825 s
                ## 未审核不能输入天数
                #LET l_chk = 0
                #SELECT COUNT(*) INTO l_chk FROM tc_cof_file
                #  WHERE tc_cofud06 = g_tc_gxa03
                #    AND tc_cof007 = "2"
                #    AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                #    AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
                #IF l_chk > 0 THEN
                #    CALL cl_set_comp_entry("tc_gxa18",TRUE)
                #    CALL cl_set_comp_required("tc_gxa18",TRUE)
                #    INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                #    INITIALIZE g_tc_gxa[l_ac].tc_gxa16 TO NULL
                #ELSE
                #    CALL  cl_err('计时单未审核，请审核再录入或选择其它类型','！',1)
                #    LET g_tc_gxa[l_ac].tc_gxa16 ='Y'
                #    DISPLAY BY NAME g_tc_gxa[l_ac].tc_gxa16
                #    NEXT FIELD tc_gxa17
                #END IF
                ## add by lixwz 20170825 e

            END IF
            LET g_gxa04 =0
                FOR l_i = 1 TO g_tc_gxa.getLength()
                    IF cl_null(g_tc_gxa[l_i].tc_gxa16) THEN
                        LET g_tc_gxa[l_i].tc_gxa16 = 0
                    END IF
                    IF g_tc_gxa[l_i].tc_gxa17 = 'Y' THEN
                        LET g_gxa04 = g_gxa04 + g_tc_gxa[l_i].tc_gxa16
                    END IF
                END FOR
            DISPLAY g_gxa04 TO gxa04

        AFTER FIELD tc_gxa15
            IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa15) AND NOT cl_null(g_tc_gxa[l_ac].tc_gxa14) AND g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
                LET g_tc_gxa[l_ac].tc_gxa16 = g_tc_gxa[l_ac].tc_gxa15*g_tc_gxa[l_ac].tc_gxa14
            END IF
            LET g_gxa04 =0
            FOR l_i = 1 TO g_tc_gxa.getLength()
                IF cl_null(g_tc_gxa[l_i].tc_gxa16) THEN
                    LET g_tc_gxa[l_i].tc_gxa16 = 0
                END IF
                LET g_gxa04 = g_gxa04 + g_tc_gxa[l_i].tc_gxa16
            END FOR
            DISPLAY g_gxa04 TO gxa04
            SELECT SUM(tc_gxa15) INTO l_sum FROM tc_gxa_file WHERE tc_gxa07=g_tc_gxa[l_ac].tc_gxa07 AND
            tc_gxa11 = g_tc_gxa[l_ac].tc_gxa11 AND (tc_gxa01<>g_tc_gxa01 OR tc_gxa03<>g_tc_gxa03)
            SELECT sfb39,sfb081,sfb09 INTO l_sfb39,l_sfb081,l_sfb09 FROM sfb_file
                WHERE sfb01 = g_tc_gxa[l_ac].tc_gxa07
            SELECT ima153 INTO l_ima153 FROM ima_file WHERE ima01 = g_tc_gxa[l_ac].tc_gxa08
            IF cl_null(l_ima153) THEN LET l_ima153 = 0 END IF
            IF l_sfb39 = '1' THEN
                LET l_sum1 = l_sfb081*(1 + l_ima153/100)
            ELSE
                IF l_sfb39 = '2' THEN
                    LET l_sum1 = l_sfb09*(1 + l_ima153/100)
                END IF
            END IF
            IF cl_null(l_sum) THEN LET l_sum=0 END IF
            IF cl_null(g_tc_gxa[l_ac].tc_gxa13) THEN LET l_sum=0 END IF
            IF l_sum+g_tc_gxa[l_ac].tc_gxa15>l_sum1*g_tc_gxa[l_ac].tc_gxa13 THEN
                CALL cl_err('','csf-010',1)
                NEXT FIELD tc_gxa15
            END IF
        AFTER FIELD tc_gxa18      #add by shids 151105 # 天数
            # add by lixwz 20170825 s
            # 判断计时数 在指定范围内
            LET l_chk = 0
            SELECT SUM(tc_cof008) INTO l_chk FROM tc_cof_file
                  WHERE tc_cofud06 = g_tc_gxa03
                    AND tc_cof007 = "2"
                    AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                    AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
            IF cl_null(l_chk) THEN LET l_chk = 0 END IF

            IF g_tc_gxa[l_ac].tc_gxa18 > l_chk THEN
                CALL cl_err('不得大于申请的天数','!',1)
                NEXT FIELD tc_gxa18
            END IF

            # add by lixwz 20170825 e
            LET l_sum=0
            SELECT SUM(tc_gxa18) INTO l_sum FROM tc_gxa_file WHERE tc_gxa01 = g_tc_gxa01 AND tc_gxa03 = g_tc_gxa03
                AND (tc_gxa07<>g_tc_gxa[l_ac].tc_gxa07 OR tc_gxa11 <> g_tc_gxa[l_ac].tc_gxa11) AND tc_gxa18 IS NOT NULL
            IF cl_null(l_sum) THEN LET l_sum=0 END IF
            IF cl_null(g_tc_gxa[l_ac].tc_gxa18) THEN LET g_tc_gxa[l_ac].tc_gxa18=0 END IF
            IF l_sum+g_tc_gxa[l_ac].tc_gxa18>1 AND l_sum<=1 THEN
                NEXT FIELD tc_gxa18
            END IF

        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()

            BEGIN WORK    #MOD-8B0180

            IF g_rec_b >= l_ac THEN

               LET p_cmd='u'
               IF cl_null(g_tc_gxa[l_ac].tc_gxa17) THEN
                   LET g_tc_gxa[l_ac].tc_gxa17 = 'Y'
                   DISPLAY g_tc_gxa[l_ac].tc_gxa17 TO tc_gxa17
               END IF
               # add by lixwz 20170825 s
              # 未审核不能输入天数
              LET l_chk = 0
              SELECT COUNT(*) INTO l_chk FROM tc_cof_file
                WHERE tc_cofud06 = g_tc_gxa03
                  AND tc_cof007 = "2"
                  AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                  AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
              IF l_chk > 0 THEN
                  CALL cl_set_comp_entry("tc_gxa18",TRUE)
                  CALL cl_set_comp_required("tc_gxa18",TRUE)
                  #INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                  #INITIALIZE g_tc_gxa[l_ac].tc_gxa16 TO NULL
              ELSE
                  CALL cl_set_comp_entry("tc_gxa18",FALSE)
                  CALL cl_set_comp_required("tc_gxa18",FALSE)
              END IF
              # add by lixwz 20170825 e
               #IF g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
               #    CALL cl_set_comp_entry("tc_gxa18",FALSE)
               #ELSE
               #    CALL cl_set_comp_entry("tc_gxa18",TRUE)
               #END IF
               LET g_tc_gxa_t.* = g_tc_gxa[l_ac].*  #BACKUP

               OPEN t001_bcl USING g_tc_gxa01,g_tc_gxa02,g_tc_gxa03,g_tc_gxa_t.tc_gxa07,g_tc_gxa_t.tc_gxa11   #No.FUN-670099
               IF STATUS THEN
                  CALL cl_err("OPEN t001_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t001_bcl INTO g_tc_gxa_t.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err(g_tc_gxa_t.tc_gxa07,SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      LET g_tc_gxa_t.*=g_tc_gxa[l_ac].*
#                      LET g_obk07_t=g_obk[l_ac].obk07  #FUN-910088
                  END IF
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF

        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_tc_gxa[l_ac].* TO NULL      #900423
           #------CHI-C60013---mark--S--#
           #LET l_obkuser = g_user
           #LET l_obkgrup = g_grup
           #LET l_obkacti = 'Y'
           #------CHI-C60013---mark--E--#
           #------CHI-C60013------#
            LET g_tc_gxa[l_ac].tc_gxauser = g_user
            LET g_tc_gxa[l_ac].tc_gxagrup = g_grup
            LET g_tc_gxa[l_ac].tc_gxadate = g_today
            LET g_tc_gxa[l_ac].tc_gxaacti = 'Y'
            LET g_tc_gxa[l_ac].tc_gxa17 = 'Y'
            # add by lixwz 20170825 s
            # 未审核不能输入天数
            LET l_chk = 0
            SELECT COUNT(*) INTO l_chk FROM tc_cof_file
              WHERE tc_cofud06 = g_tc_gxa03
                AND tc_cof007 = "2"
                AND tc_cof004 <= g_tc_gxa01 AND tc_cof005 >= g_tc_gxa01
                AND tc_cofconf1 = 'Y' AND tc_cofconf2='Y'
            IF l_chk > 0 THEN
                CALL cl_set_comp_entry("tc_gxa18",TRUE)
                CALL cl_set_comp_required("tc_gxa18",TRUE)
                #INITIALIZE g_tc_gxa[l_ac].tc_gxa18 TO NULL
                #INITIALIZE g_tc_gxa[l_ac].tc_gxa16 TO NULL
            ELSE
                CALL cl_set_comp_entry("tc_gxa18",FALSE)
                CALL cl_set_comp_required("tc_gxa18",FALSE)
            END IF
            # add by lixwz 20170825 e
            #IF g_tc_gxa[l_ac].tc_gxa17 = 'Y' THEN
            #    CALL cl_set_comp_entry("tc_gxa18",FALSE)
            #ELSE
            #    CALL cl_set_comp_entry("tc_gxa18",TRUE)
            #   END IF
           #------CHI-C60013------#
            LET g_tc_gxa_t.* = g_tc_gxa[l_ac].*         #新輸入資料
            CALL cl_show_fld_cont()     #FUN-550037(smin)
            NEXT FIELD tc_gxa07

        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF

       #IF cl_null(g_tc_gxa[l_ac].tc_gxa07) THEN LET g_tc_gxa[l_ac].tc_gxa07=' ' END IF
       #IF cl_null(g_tc_gxa01) THEN LET  g_tc_gxa01=' ' END IF
       #IF cl_null(g_tc_gxa03) THEN LET  g_tc_gxa03=' ' END IF
       #IF cl_null(g_tc_gxa[l_ac].tc_gxa11) THEN LET g_tc_gxa[l_ac].tc_gxa11=' ' END IF
            INSERT INTO tc_gxa_file(tc_gxa01,tc_gxa02,tc_gxa03,tc_gxa04,tc_gxa05,tc_gxa06,tc_gxa07,tc_gxa08,
                                 tc_gxa09,tc_gxa10,tc_gxa11,tc_gxa12,tc_gxa13,tc_gxa14,tc_gxa15,tc_gxa16,tc_gxa17,tc_gxa18,
                                 tc_gxa19,  #TQC-6A0045 add
                                #obkuser,obkgrup,obkacti,obkoriu,obkorig)   #MOD-850286   #CHI-C60013 mark
                                 tc_gxaoriu,tc_gxaorig,tc_gxauser,tc_gxagrup,tc_gxamodu,tc_gxadate,tc_gxaacti) #CHI-C60013
                          VALUES(g_tc_gxa01,
                                 g_tc_gxa02,g_tc_gxa03,
                                 '',
                                 '',
                                 '',g_tc_gxa[l_ac].tc_gxa07,
                                 g_tc_gxa[l_ac].tc_gxa08,g_tc_gxa[l_ac].tc_gxa09,
                                 g_tc_gxa[l_ac].tc_gxa10,g_tc_gxa[l_ac].tc_gxa11,
                                 '',g_tc_gxa[l_ac].tc_gxa13,
                                 g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa15,
                                 g_tc_gxa[l_ac].tc_gxa16,g_tc_gxa[l_ac].tc_gxa17,
                                 g_tc_gxa[l_ac].tc_gxa18,g_tc_gxa[l_ac].tc_gxa19,
                                 g_user, g_grup,                                               #CHI-C60013
                                 g_tc_gxa[l_ac].tc_gxauser,g_tc_gxa[l_ac].tc_gxagrup,g_tc_gxa[l_ac].tc_gxamodu,  #CHI-C60013
                                 g_tc_gxa[l_ac].tc_gxadate,g_tc_gxa[l_ac].tc_gxaacti)                      #CHI-C60013
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","tc_gxa_file",g_tc_gxa03,g_tc_gxa[l_ac].tc_gxa07,SQLCA.sqlcode,"","",1)  #No.FUN-660167
               CANCEL INSERT
            ELSE
               MESSAGE 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cn2    #MOD-8B0180
            END IF


        BEFORE DELETE                            #是否取消單身
            IF g_tc_gxa_t.tc_gxa07 IS NOT NULL AND g_tc_gxa_t.tc_gxa11 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF

                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF

                DELETE FROM tc_gxa_file
                 WHERE tc_gxa01 = g_tc_gxa01 AND tc_gxa03 = g_tc_gxa03 AND tc_gxa07 = g_tc_gxa_t.tc_gxa07
                   AND tc_gxa11 = g_tc_gxa_t.tc_gxa11   #No.FUN-670099
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("del","tc_gxa_file",g_tc_gxa_t.tc_gxa07,g_tc_gxa03,SQLCA.sqlcode,"","",1)  #No.FUN-660167
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
               LET g_tc_gxa[l_ac].* = g_tc_gxa_t.*
               CLOSE t001_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_tc_gxa[l_ac].tc_gxa07,-263,1)
               LET g_tc_gxa[l_ac].* = g_tc_gxa_t.*
            ELSE
               LET g_gxa04 =0
               FOR l_i = 1 TO g_tc_gxa.getLength()
                    IF cl_null(g_tc_gxa[l_i].tc_gxa16) THEN
                        LET g_tc_gxa[l_i].tc_gxa16 = 0
                    END IF
                    IF g_tc_gxa[l_i].tc_gxa17 THEN
                        LET g_gxa04 = g_gxa04 + g_tc_gxa[l_i].tc_gxa16
                    END IF
               END FOR
               DISPLAY g_gxa04 TO gxa04
               LET g_tc_gxa[l_ac].tc_gxamodu=g_user   #CHI-C60013
               LET g_tc_gxa[l_ac].tc_gxadate=g_today  #CHI-C60013
               UPDATE tc_gxa_file SET tc_gxa01=g_tc_gxa01,
                                   tc_gxa02=g_tc_gxa02,
                                   tc_gxa03=g_tc_gxa03,
#                                  tc_gxa04=g_tc_gxa[l_ac].tc_gxa04,
#                                  tc_gxa05=g_tc_gxa[l_ac].tc_gxa05,
#                                  tc_gxa06=g_tc_gxa[l_ac].tc_gxa06,
                                   tc_gxa07=g_tc_gxa[l_ac].tc_gxa07,
                                   tc_gxa08=g_tc_gxa[l_ac].tc_gxa08,
                                   tc_gxa09=g_tc_gxa[l_ac].tc_gxa09,
                                   tc_gxa10=g_tc_gxa[l_ac].tc_gxa10,
                                   tc_gxa11=g_tc_gxa[l_ac].tc_gxa11,
#                                  tc_gxa12=g_tc_gxa[l_ac].tc_gxa12,
                                   tc_gxa13=g_tc_gxa[l_ac].tc_gxa13,
                                   tc_gxa14=g_tc_gxa[l_ac].tc_gxa14,
                                   tc_gxa15=g_tc_gxa[l_ac].tc_gxa15,
                                   tc_gxa16=g_tc_gxa[l_ac].tc_gxa16,
                                   tc_gxa17=g_tc_gxa[l_ac].tc_gxa17,
                                   tc_gxa18=g_tc_gxa[l_ac].tc_gxa18,
                                   tc_gxa19=g_tc_gxa[l_ac].tc_gxa19,
                                   tc_gxamodu=g_tc_gxa[l_ac].tc_gxamodu,
                                   tc_gxadate=g_tc_gxa[l_ac].tc_gxadate,
                                   tc_gxaacti=g_tc_gxa[l_ac].tc_gxaacti
                WHERE tc_gxa01 = g_tc_gxa01  AND tc_gxa02 = g_tc_gxa02 AND tc_gxa03 = g_tc_gxa03
                  AND tc_gxa07=g_tc_gxa[l_ac].tc_gxa07
                  AND tc_gxa11=g_tc_gxa[l_ac].tc_gxa11   #No.FUN-670099
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("upd","tc_gxa_file",g_tc_gxa03,g_tc_gxa_t.tc_gxa07,SQLCA.sqlcode,"","",1)  #No.FUN-660167
                 LET g_tc_gxa[l_ac].* = g_tc_gxa_t.*
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
                  LET g_tc_gxa[l_ac].* = g_tc_gxa_t.*
               #FUN-D30034--add--begin--
               ELSE
                  CALL g_tc_gxa.deleteElement(l_ac)
                  IF g_rec_b != 0 THEN
                     LET g_action_choice = "detail"
                     LET l_ac = l_ac_t
                  END IF
               #FUN-D30034--add--end----
               END IF
               CLOSE t001_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            LET l_ac_t = l_ac   #FUN-D30034 add
            CLOSE t001_bcl
            COMMIT WORK

        ON ACTION controlp
         CASE
            WHEN INFIELD(tc_gxa07)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_sfb002"
              #LET g_qryparam.where = "ecb_file.ecb01 = sfb05 and ecb_file.ecb03 = '",g_tc_gxa[l_ac].tc_gxa11,"'"
              LET g_qryparam.default1 = g_tc_gxa[l_ac].tc_gxa07
              CALL cl_create_qry() RETURNING g_tc_gxa[l_ac].tc_gxa07,g_tc_gxa[l_ac].tc_gxa08,g_tc_gxa[l_ac].tc_gxa09,g_tc_gxa[l_ac].tc_gxa10,g_tc_gxa[l_ac].tc_gxa19
              DISPLAY BY NAME g_tc_gxa[l_ac].tc_gxa07,g_tc_gxa[l_ac].tc_gxa08,g_tc_gxa[l_ac].tc_gxa09,g_tc_gxa[l_ac].tc_gxa10,g_tc_gxa[l_ac].tc_gxa19
              NEXT FIELD tc_gxa07
            {WHEN INFIELD(tc_gxa11)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_ecb001"
              IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                LET g_qryparam.where = "ecb01 = '",g_tc_gxa[l_ac].tc_gxa08,"'"
              END IF
              LET g_qryparam.default1 = g_tc_gxa[l_ac].tc_gxa11
              CALL cl_create_qry() RETURNING g_tc_gxa[l_ac].tc_gxa11,g_tc_gxa[l_ac].ecb06,g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13
              DISPLAY BY NAME g_tc_gxa[l_ac].tc_gxa11,g_tc_gxa[l_ac].ecb06,g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13
              SELECT ecd02 INTO g_tc_gxa[l_ac].ecd02 FROM ecd_file WHERE ecd01 = g_tc_gxa[l_ac].ecb06
              SELECT ecd02 INTO g_tc_gxa[l_ac].ecd02 FROM ecd_file WHERE ecd01 = g_tc_gxa[l_ac].ecb06
              NEXT FIELD tc_gxa11}
            WHEN INFIELD(ecb06)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_ecb001"
              IF NOT cl_null(g_tc_gxa[l_ac].tc_gxa08) THEN
                LET g_qryparam.where = "ecb01 = '",g_tc_gxa[l_ac].tc_gxa08,"'"
              END IF
              LET g_qryparam.default1 = g_tc_gxa[l_ac].ecb06
              CALL cl_create_qry() RETURNING g_tc_gxa[l_ac].tc_gxa11,g_tc_gxa[l_ac].ecb06,g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13
              DISPLAY BY NAME g_tc_gxa[l_ac].tc_gxa11,g_tc_gxa[l_ac].ecb06,g_tc_gxa[l_ac].tc_ecb01,g_tc_gxa[l_ac].tc_gxa14,g_tc_gxa[l_ac].tc_gxa13
              SELECT ecd02 INTO g_tc_gxa[l_ac].ecd02 FROM ecd_file WHERE ecd01 = g_tc_gxa[l_ac].ecb06
              SELECT ecd02 INTO g_tc_gxa[l_ac].ecd02 FROM ecd_file WHERE ecd01 = g_tc_gxa[l_ac].ecb06
              NEXT FIELD ecb06
           OTHERWISE EXIT CASE
         END CASE

        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(tc_gxa07) AND l_ac > 1 THEN
               LET g_tc_gxa[l_ac].* = g_tc_gxa[l_ac-1].*
               NEXT FIELD tc_gxa07
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
       CALL t001_b()
    END IF
#No.FUN-D50045 --------- add -------- end ------------------

END FUNCTION

{FUNCTION t001_b_askkey()
DEFINE
    l_wc            LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)

    CONSTRUCT g_wc ON tc_gxa07,tc_gxa10,tc_gxa08,tc_gxa11,tc_gxa19    #螢幕上取條件
        FROM s_tc_gxa[1].tc_gxa07,s_tc_gxa[1].tc_gxa10,s_tc_gxa[1].tc_gxa08,s_tc_gxa[1].tc_gxa11,
             s_tc_gxa[1].tc_gxa19
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

    CALL t001_b_fill(l_wc)

END FUNCTION}

FUNCTION t001_b_fill(p_wc)              #BODY FILL UP
DEFINE
    p_wc            LIKE type_file.chr1000       #No.FUN-680137   VARCHAR(200)

    IF NOT cl_null(g_tc_gxa01) THEN LET p_wc=p_wc," and tc_gxa01 = '",g_tc_gxa01,"' "  END IF
    IF NOT cl_null(g_tc_gxa03) THEN LET p_wc=p_wc," and tc_gxa03 = '",g_tc_gxa03,"' "  END IF
    LET g_sql =
               "SELECT tc_gxa07,tc_gxa10,tc_gxa08,'','',tc_gxa09,tc_gxa11,'','',tc_gxa13,'','',tc_gxa15,tc_gxa14,tc_gxa17,tc_gxa18,tc_gxa16,tc_gxa19,",  #CHI-C60013 add ,
               "tc_gxaoriu,tc_gxaorig,tc_gxauser,tc_gxagrup,tc_gxamodu,tc_gxadate,tc_gxaacti ",          #CHI-C60013
               " FROM tc_gxa_file ",
#               " WHERE tc_gxa01 = '",g_tc_gxa01,
#               "' AND tc_gxa03 = '",g_tc_gxa03,"'",p_wc CLIPPED ,
               "where ",p_wc CLIPPED ,
               " ORDER BY tc_gxa11,tc_gxa07 "
    PREPARE t001_p2 FROM g_sql      #預備一下
    DECLARE obk_curs CURSOR FOR t001_p2

    CALL g_tc_gxa.clear()
    LET g_cnt = 1
    LET g_gxa04 =0
    FOREACH obk_curs INTO g_tc_gxa[g_cnt].*   #單身 ARRAY 填充
        IF SQLCA.sqlcode THEN
            CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
        IF cl_null(g_tc_gxa[g_cnt].tc_gxa16) THEN
            LET g_tc_gxa[g_cnt].tc_gxa16 = 0
        END IF
        LET g_gxa04 = g_gxa04 + g_tc_gxa[g_cnt].tc_gxa16

        SELECT ima02,ima021 INTO g_tc_gxa[g_cnt].ima02,g_tc_gxa[g_cnt].ima021 FROM ima_file
            WHERE ima01 = g_tc_gxa[g_cnt].tc_gxa08
        SELECT ecb06,tc_ecb01 INTO g_tc_gxa[g_cnt].ecb06,g_tc_gxa[g_cnt].tc_ecb01 FROM ecb_file
            WHERE ecb01 = g_tc_gxa[g_cnt].tc_gxa08 AND ecb03 = g_tc_gxa[g_cnt].tc_gxa11
        SELECT ecd02 INTO g_tc_gxa[g_cnt].ecd02 FROM ecd_file WHERE ecd01 = g_tc_gxa[g_cnt].ecb06
        SELECT ta_eczud01 INTO g_tc_gxa[g_cnt].ta_eczud01 FROM ecz_file
            WHERE ecz01 = g_tc_gxa[g_cnt].ecb06 AND tc_ecz01 = g_tc_gxa[g_cnt].tc_ecb01
        LET g_cnt = g_cnt + 1

        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF

    END FOREACH
    DISPLAY g_gxa04 TO gxa04
    CALL g_tc_gxa.deleteElement(g_cnt)

    LET g_rec_b = g_cnt - 1               #告訴I.單身筆數
    DISPLAY g_rec_b TO FORMONLY.cn2
END FUNCTION

FUNCTION t001_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
   DEFINE   l_n    LIKE type_file.num5


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)

   SELECT COUNT(*) INTO l_n FROM tc_gxa_file WHERE tc_gxa01=g_tc_gxa01 AND tc_gxa03 = g_tc_gxa03
   IF l_n=0 THEN
        INITIALIZE g_tc_gxa01 TO NULL
        INITIALIZE g_tc_gxa02 TO NULL
        INITIALIZE g_tc_gxa03 TO NULL
        INITIALIZE g_gem02 TO NULL
        INITIALIZE g_gen02 TO NULL
        INITIALIZE g_tc_coa013 TO NUll
        INITIALIZE g_gxa04 TO NUll
   END IF
   DISPLAY g_tc_gxa01 TO tc_gxa01               #單頭
   DISPLAY g_tc_gxa02 TO tc_gxa02
   DISPLAY g_tc_gxa03 TO tc_gxa03
   DISPLAY g_gem02 TO gem02
   DISPLAY g_gen02 TO gen02
   DISPLAY g_tc_coa013 TO tc_coa013
   DISPLAY g_gxa04 TO gxa04
   DISPLAY ARRAY g_tc_gxa TO s_tc_gxa.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

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
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
      ON ACTION first
         CALL t001_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION previous
         CALL t001_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION jump
         CALL t001_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION next
         CALL t001_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION last
         CALL t001_fetch('L')
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



FUNCTION t001_copy()
DEFINE l_tc_gxa03,l_tc_gxa03_t  LIKE tc_gxa_file.tc_gxa03,
       l_tc_gxa02,l_tc_gxa02_t  LIKE tc_gxa_file.tc_gxa02,
       l_tc_gxa01,l_tc_gxa01_t  LIKE tc_gxa_file.tc_gxa01,
       l_n               LIKE type_file.num5,    #No.FUN-680136 SMALLINT
       l_i               LIKE type_file.num5,
       l_tc_coa013       LIKE tc_coa_file.tc_coa013,
       l_gen02           LIKE gen_file.gen02,
       l_gem02           LIKE gem_file.gem02
DEFINE l_x               RECORD LIKE tc_gxa_file.*  #FUN-9A0056 add
DEFINE g_success         LIKE type_file.chr1

    IF s_shut(0) THEN RETURN END IF
    IF g_tc_gxa01 IS NULL
       THEN CALL cl_err('',-400,0)
            RETURN
    END IF
    DISPLAY ' ' TO tc_gxa03
    CALL cl_set_head_visible("","YES")           #No.FUN-6B0032
    INPUT l_tc_gxa03 FROM tc_gxa03


        AFTER FIELD tc_gxa03
            IF l_tc_gxa03 IS NULL THEN
                 NEXT FIELD tc_gxa03
            ELSE
                IF NOT cl_null(g_tc_gxa01) THEN
                    FOR l_i=1 TO g_tc_gxa.getLength()
                        SELECT count(*) INTO l_n FROM tc_gxa_file
                        WHERE tc_gxa01 = g_tc_gxa01
                        AND tc_gxa03 = l_tc_gxa03
                        AND tc_gxa07 = g_tc_gxa[l_i].tc_gxa07                                         #CHI-910021
                        AND tc_gxa11 = g_tc_gxa[l_i].tc_gxa11
                        IF l_n > 0 THEN
                            CALL cl_err('',-239,0)
                            NEXT FIELD tc_gxa03
                            EXIT FOR
                        END IF
                    END FOR
                END IF
            END IF
            IF NOT cl_null(l_tc_gxa02) THEN
                SELECT COUNT(*) INTO l_n FROM gen_file WHERE gen01 = l_tc_gxa03 AND gen03 = g_tc_gxa02
                IF l_n=0 THEN NEXT FIELD tc_gxa03 END IF
            END IF
            #SELECT gen INTO l_gen02 FROM gen_file     #mark by xujw170607
            SELECT gen02  INTO l_gen02 FROM gen_file   #add by xujw170607
                            WHERE gen01 = l_tc_gxa03
                             AND genacti = 'Y'
            SELECT tc_coa013 INTO l_tc_coa013 FROM tc_coa_file WHERE tc_coa001 = l_tc_gxa03
            IF SQLCA.sqlcode THEN
                 CALL cl_err3("sel","gen_file",l_tc_gxa03,"","mfg0002","","",1)  #No.FUN-660129
                 NEXT FIELD tc_gxa03
            ELSE
                 DISPLAY l_gen02 TO FORMONLY.gen02
                 DISPLAY l_tc_coa013 TO FORMONLY.tc_coa013
            END IF

        ON ACTION controlp
           CASE
            WHEN INFIELD(tc_gxa03)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_gen"
              LET g_qryparam.default1 = l_tc_gxa03
              IF NOT cl_null(l_tc_gxa02) THEN
                    LET g_qryparam.where = "gen03 = '",l_tc_gxa02,"'"
              END IF
              CALL cl_create_qry() RETURNING l_tc_gxa03
              DISPLAY l_tc_gxa03 TO tc_gxa03
              NEXT FIELD tc_gxa03
            END CASE

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


    END INPUT
    IF INT_FLAG
       THEN LET INT_FLAG = 0
            DISPLAY  g_gen02 TO gen02
            DISPLAY  g_tc_gxa03 TO tc_gxa03
            DISPLAY  g_tc_coa013 TO tc_coa013
            RETURN
    END IF

    DROP TABLE x
    {SELECT * FROM tc_gxa_file         #單身複製
        WHERE tc_gxa01 = g_tc_gxa01
          AND tc_gxa11 = g_tc_gxa11                                           #CHI-910021
          AND tc_gxa03 = g_tc_gxa03                                      #TQC-C90108 add
          AND tc_gxa07 = g_tc_gxa07
        INTO TEMP x}
    FOR l_i=1 TO g_tc_gxa.getLength()
        SELECT * FROM tc_gxa_file         #單身複製
        WHERE tc_gxa01 = g_tc_gxa01
          AND tc_gxa11 = g_tc_gxa[l_i].tc_gxa11                                           #CHI-910021
          AND tc_gxa03 = g_tc_gxa03                                    #TQC-C90108 add
          AND tc_gxa07 = g_tc_gxa[l_i].tc_gxa07
        INTO TEMP x
    END FOR
    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","tc_gxa_file","","",SQLCA.sqlcode,"","",1)  #No.FUN-660129
       RETURN
    END IF
    UPDATE x
        SET tc_gxa03 = l_tc_gxa03

    BEGIN WORK                                                     #FUN-9A0056 add
    LET g_success = 'Y'                                            #FUN-9A0056 add
    INSERT INTO tc_gxa_file
        SELECT * FROM x
    IF SQLCA.sqlcode THEN
       CALL cl_err3("ins","tc_gxa_file","","",SQLCA.sqlcode,"","",1)  #No.FUN-660129
       LET g_success = 'N'                                         #FUN-9A0056 add
    END IF

   #FUN-9A0056 add str-----
    IF g_success = 'N' THEN
      ROLLBACK WORK
      RETURN
    ELSE
      COMMIT WORK
    END IF
   #FUN-9A0056 add end-----

    LET g_cnt=SQLCA.SQLERRD[3]
    MESSAGE '(',g_cnt USING '##&',') ROW of (',l_tc_gxa03,') O.K'

     LET l_tc_gxa03_t= g_tc_gxa03
     LET g_tc_gxa03=l_tc_gxa03
     CALL t001_b()
     #LET g_pmh01=l_oldno1  #FUN-C80046
     #CALL t001_show()      #FUN-C80046
END FUNCTION
