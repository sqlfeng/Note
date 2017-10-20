# Prog. Version..: '5.30.02-12.08.01(00001)'     #
#
# Pattern name...: axcq802.4gl
# Descriptions...:客戶開票明細表
# Date & Author..: FUN-C60033 12/06/11 By minpp
# Modify.........: FUN-C60033 12/07/23 By xuxz 判斷料件是否為MISC
# Modify.........: FUN-CA0084 12/10/10 By minpp 输入qbe后点击【退出】应只退出查询界面
# Modify.........: MOD-CB0240 12/11/26 By wujie 不打印明细时，若下料号条件，按客户汇总时，也应该排除不在客户-料号组合内的资料
# Modify.........: TQC-D20046 13/02/25 By chenjing 修改商品發出bug
# Modify.........: FUN-D70058 13/07/11 By wangrr 更改4fd,根據調整後的cfc_file顯示明細和匯總信息

DATABASE ds

GLOBALS "../../config/top.global"
DEFINE tm RECORD
         #wc     LIKE type_file.chr1000, #FUN-D70058 mark
         wc     STRING,                  #FUN-D70058
         yy     LIKE type_file.chr4,
         mm     LIKE type_file.chr2,
         #ccc07  LIKE ccc_file.ccc07, #FUN-D70058 mark
         #ccc08  LIKE ccc_file.ccc08, #FUN-D70058 mark
         #flag   LIKE type_file.chr1, #FUN-D70058 mark
         #MORE    LIKE type_file.chr1 #FUN-D70058 mark
         s      LIKE type_file.chr1,  #FUN-D70058
         type   LIKE type_file.chr1   #FUN-D70058
         END  RECORD

#FUN-D70058--mark--str--
#DEFINE    g_cfc   DYNAMIC ARRAY OF RECORD
#                cfc07   LIKE cfc_file.cfc07,
#                cfc08   LIKE cfc_file.cfc08,
#                cfc11   LIKE cfc_file.cfc11,
#                cfc13   LIKE cfc_file.cfc13,      #TQC-D20046 cj add
#                cfc15   LIKE cfc_file.cfc15,
#               tot     LIKE type_file.num20_6,
#                sum1    LIKE cfc_file.cfc15,
#                tot1    LIKE type_file.num20_6,
#                sum2    LIKE cfc_file.cfc15,
#                tot2    LIKE type_file.num20_6,
#                sum3    LIKE cfc_file.cfc15,
#                tot3    LIKE type_file.num20_6,
#                sum4    LIKE cfc_file.cfc15,
#                tot4    LIKE type_file.num20_6,
#                sum5    LIKE cfc_file.cfc15,
#                tot5    LIKE type_file.num20_6,
#                ima021  LIKE ima_file.ima021      #TQC-D20046 cj add
#                END RECORD
#FUN-D70058--mark--end
#FUN-D70058--add--str--
DEFINE g_cfb  DYNAMIC ARRAY OF RECORD
       cfb00  LIKE cfb_file.cfb00,
       cfb01  LIKE cfb_file.cfb01,
       cfb02  LIKE cfb_file.cfb02,
       cfb16  LIKE cfb_file.cfb16,
       cfb03  LIKE cfb_file.cfb03,
       cfb04  LIKE cfb_file.cfb04,
       cfb05  LIKE cfb_file.cfb05,
       cfb06  LIKE cfb_file.cfb06,
       cfb061 LIKE cfb_file.cfb061,
       cfb07  LIKE cfb_file.cfb07,
       cfb08  LIKE cfb_file.cfb08,
       cfb09  LIKE cfb_file.cfb09,
       cfb10  LIKE cfb_file.cfb10,
       cfb11  LIKE cfb_file.cfb11,
       cfb13  LIKE cfb_file.cfb13,
       cfb12  LIKE cfb_file.cfb12,
       cfb14  LIKE cfb_file.cfb14,
       cfb141 LIKE cfb_file.cfb141,
       cfb142 LIKE cfb_file.cfb142,
       cfb15  LIKE cfb_file.cfb15,
       cfb17  LIKE cfb_file.cfb17,
       cfb18  LIKE cfb_file.cfb18,
       cfb19  LIKE cfb_file.cfb19,
       cfb20  LIKE cfb_file.cfb20
       END RECORD,
       g_cfc  DYNAMIC ARRAY OF RECORD
       cfc07  LIKE cfc_file.cfc07,
       cfc08  LIKE cfc_file.cfc08,
       cfc11  LIKE cfc_file.cfc11,
       cfc13  LIKE cfc_file.cfc13,
       cfc19  LIKE cfc_file.cfc19,
       aag02  LIKE aag_file.aag02,
       cfc17  LIKE cfc_file.cfc17,
       sum_qc LIKE cfc_file.cfc15,
       amt_qc LIKE type_file.num20_6,
       sum_ch LIKE cfc_file.cfc15,
       amt_ch LIKE type_file.num20_6,
       sum_kp LIKE cfc_file.cfc15,
       amt_kp LIKE type_file.num20_6,
       sum_qm LIKE cfc_file.cfc15,
       amt_qm LIKE type_file.num20_6
       END RECORD
DEFINE   g_action_flag  LIKE type_file.chr100
DEFINE   f    ui.Form
DEFINE   page om.DomNode
DEFINE   w    ui.Window
DEFINE   g_flag1        LIKE type_file.chr1
DEFINE   l_ac           LIKE type_file.num5
DEFINE   l_ac1          LIKE type_file.num5
DEFINE   g_rec_b2        LIKE type_file.num10      #單身筆數
#FUN-D70058--add--end
DEFINE   g_sql           STRING
DEFINE   g_str           STRING
DEFINE   g_cnt    LIKE type_file.num10
DEFINE   g_rec_b  LIKE type_file.num10
DEFINE   g_change_lang    LIKE type_file.chr1
MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                 # Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("axc")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time

   #判讀oaz93是否為N，為N才運行，不為N則報錯：系統參數做發出商品管理，才可執行本作業！
   #FUN-D70058--mark--str--
   #SELECT oaz93 INTO g_oaz.oaz93 FROM oaz_file WHERE oaz00='0'
   #IF g_oaz.oaz93 = 'Y' THEN
   #   CALL cl_err('','axc-127',1)
   #   EXIT PROGRAM
   #END IF
	 #FUN-D70058--mark--end

   INITIALIZE tm.* TO NULL

   #LET tm.flag='N' #FUN-D70058 mark
   #LET tm.more='N' #FUN-D70058 mark
   LET g_bgjob  = 'N'
   LET g_pdate  = g_today
   LET g_rlang  = g_lang
   LET g_copies = '1'

   OPEN WINDOW q802_w AT 5,10
            #WITH FORM "axc/42f/axcq802" ATTRIBUTE(STYLE = g_win_style)  #FUN-D70058 mark
          WITH FORM "axc/42f/axcq802_1" ATTRIBUTE(STYLE = g_win_style) #FUN-D70058
      CALL cl_ui_init()
			 CALL cl_set_comp_visible('cfb20',FALSE) #FUN-D70058
			  CALL q802_temp_table()  #FUN-D70058
      IF cl_null(g_bgjob) OR g_bgjob = 'N'        # If background job sw is off
         THEN CALL q802_tm()                      # Input print condition
         ELSE #CALL q802()  #FUN-D70058 mark                         # Read data and create out-file
         CALL q802_t('q') #FUN-D70058
      END IF

      CALL q802_menu()
      CLOSE WINDOW q802_w

   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690114

END MAIN

FUNCTION q802_menu()
   WHILE TRUE
   #FUN-D70058--add--str--
      IF cl_null(g_action_choice) THEN
         IF g_action_flag = "page1" THEN
            CALL q802_bp("G")
         END IF
         IF g_action_flag = "page2" THEN
            CALL q802_bp2()
         END IF
         IF cl_null(g_action_flag) THEN
            CALL q802_bp("G")
         END IF
      END IF
      #FUN-D70058--add--end
      #CALL q802_bp("G")  #FUN-D70058 mark
      CASE g_action_choice
      #FUN-D70058--add--str--
         WHEN "page1"
            CALL q802_bp("G")

         WHEN "page2"
            CALL q802_bp2()
       #FUN-D70058--add--end
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL q802_tm()
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL q802_out()
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
            LET g_action_choice = " " #FUN-D70058
         WHEN "exporttoexcel"
            #FUN-D70058--MOD--str--
            #IF cl_chk_act_auth() THEN
            #  CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_cfc),'','')
            #END IF
            LET w = ui.Window.getCurrent()
            LET f = w.getForm()
            IF g_action_flag = "page1" THEN
               IF cl_chk_act_auth() THEN
                  LET page = f.FindNode("Page","page1")
                  CALL cl_export_to_excel(page,base.TypeInfo.create(g_cfb),'','')
               END IF
            END IF
            IF g_action_flag = "page2" THEN
               IF cl_chk_act_auth() THEN
                  LET page = f.FindNode("Page","page2")
                  CALL cl_export_to_excel(page,base.TypeInfo.create(g_cfc),'','')
               END IF
            END IF
            LET g_action_choice = " "
            #FUN-D70058--MOD--end
      END CASE
   END WHILE
END FUNCTION

FUNCTION q802_bp(p_ud)
DEFINE
    p_ud   LIKE type_file.chr1

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
	 #FUN-D70058--add--str--
   LET g_action_flag = 'page1'
   DISPLAY g_rec_b TO FORMONLY.cn2
   IF g_action_choice = "page1" AND g_flag1 != '1' THEN
      CALL q802_b_fill_1()
   END IF
   LET g_flag1 = ' '
   #FUN-D70058--add--end
   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   #FUN-D70058--add--str--
   DISPLAY BY NAME tm.s
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT tm.s FROM s ATTRIBUTE(WITHOUT DEFAULTS)
         ON CHANGE s
            IF NOT cl_null(tm.s)  THEN
               CALL q802_t('s')
               CALL q802_b_fill_2()
               CALL q802_set_visible()
               CALL cl_set_comp_visible("page1", FALSE)
               CALL ui.interface.refresh()
               CALL cl_set_comp_visible("page1", TRUE)
               LET g_action_choice = "page2"
            ELSE
               CALL q802_b_fill_1()
               CALL g_cfc.clear()
               LET g_rec_b2=0
            END IF
            DISPLAY BY NAME tm.s
            EXIT DIALOG
      END INPUT
   #FUN-D70058--add--end
    #DISPLAY ARRAY g_cfc TO s_cfc.* ATTRIBUTE(COUNT=g_rec_b)   #FUN-D70058 mark
      DISPLAY ARRAY g_cfb TO s_cfb.* ATTRIBUTE(COUNT=g_rec_b) #FUN-D70058

      BEFORE ROW
       LET l_ac = ARR_CURR()  #FUN-D70058
         CALL cl_show_fld_cont()
			END DISPLAY   #FUN-D70058
			 #FUN-D70058--add--str--
      ON ACTION page2
         LET g_action_choice = 'page2'
         EXIT DIALOG
      #FUN-D70058--add--end
      ON ACTION query
         LET g_action_choice="query"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION output
         LET g_action_choice="output"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION help
         LET g_action_choice="help"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()

      ON ACTION exit
         LET g_action_choice="exit"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION controlg
         LET g_action_choice="controlg"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION close
      LET g_action_choice="exit"
       #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
          #EXIT DISPLAY #FUN-D70058 mark
         EXIT DIALOG   #FUN-D70058

      #AFTER DISPLAY       #FUN-D70058 mark
      #   CONTINUE DISPLAY #FUN-D70058 mark

   #END DISPLAY #FUN-D70058 mark
   END DIALOG  #FUN-D70058
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION q802_tm()
   DEFINE p_row,p_col    LIKE type_file.num5
   DEFINE l_n            LIKE type_file.num5
   DEFINE lc_qbe_sn      LIKE gbm_file.gbm01
   DEFINE l_pja01        LIKE pja_file.pja01
   DEFINE l_imd09        LIKE imd_file.imd09

   #OPEN WINDOW q802_w1 AT p_row,p_col          #FUN-D70058 mark
   #     WITH FORM "axc/42f/axcr802"            #FUN-D70058 mark
   #     ATTRIBUTE (STYLE = g_win_style CLIPPED)#FUN-D70058 mark

   #CALL cl_ui_init() #FUN-D70058 mark
   #CALL cl_set_comp_entry('ccc08',FALSE)#TQC-D20046 add #FUN-D70058 mark
   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL
   # add by lixwz 20171013 s
   CLEAR FORM   #清除畫面
   CALL g_cfb.clear()
   # add by lixwz 20171013 e
    #LET tm.flag= 'N'  #FUN-D70058 mark
   LET g_pdate  = g_today
   LET g_bgjob  = 'N'
   LET g_copies = '1'
   #LET tm.more = 'N' #FUN-D70058 mark
   #DISPLAY BY NAME tm.flag,tm.more #FUN-D70058 mark
    #FUN-D70058--add--str--
   LET tm.s='3'
   LET tm.type=g_ccz.ccz28
   LET tm.yy=g_ccz.ccz01
   LET tm.mm=g_ccz.ccz02
   DISPLAY BY NAME tm.s,tm.type,tm.yy,tm.mm
   #FUN-D70058--add--end
#WHILE TRUE #FUN-D70058 mark
   DIALOG ATTRIBUTE(unbuffered)
    #FUN-D70058--mark--str--
   #CONSTRUCT BY NAME tm.wc ON cfc07,cfc11
   #BEFORE CONSTRUCT
   #    #TQC-D60036---add---str--
   #    LET tm.yy = g_ccz.ccz01
   #    LET tm.mm = g_ccz.ccz02
   #    LET tm.ccc07 = g_ccz.ccz28
   #    DISPLAY BY NAME tm.yy,tm.mm,tm.ccc07
   #    #TQC-D60036---add---end--
   #    LET tm.flag = 'N'
   #    LET tm.more = 'N'
   #    LET tm.ccc08=' '
   # END CONSTRUCT

   #INPUT BY NAME tm.yy,tm.mm,tm.ccc07,tm.ccc08,tm.flag,tm.more
   # BEFORE INPUT
   #   LET tm.flag='N'
   #   LET tm.more = 'N'
   #   DISPLAY tm.flag TO flag
   #   DISPLAY tm.more TO more
   #TQC-D20046--cj--add--
   #   LET tm.yy = g_ccz.ccz01
   #   LET tm.mm = g_ccz.ccz02
   #   LET tm.ccc07 = g_ccz.ccz28
   #   DISPLAY BY NAME tm.yy,tm.mm,tm.ccc07
   ##TQC-D20046--cj--end--
   #
   #    AFTER FIELD yy
   #      IF NOT cl_null(tm.yy) THEN
   #         IF tm.yy > 9999 OR tm.yy < 1000 THEN
   #           CALL cl_err('','ask-003',0)
   #           NEXT FIELD yy
   #         END IF
   #      END IF

   #     AFTER FIELD mm
   #      IF NOT cl_null(tm.mm) THEN
   #        IF tm.mm >13 OR tm.mm < 1 THEN
   #           CALL cl_err('','agl-013',0)
   #           NEXT FIELD mm
   #         END IF
   #       END IF

   #      ON CHANGE ccc07
   #         IF NOT cl_null(tm.ccc07) THEN
   #             IF tm.ccc07 MATCHES '[345]' THEN
   #               CALL cl_set_comp_entry("ccc08",TRUE)
   #             ELSE
   #                CALL cl_set_comp_entry("ccc08",FALSE)
   #             END IF
   #          END IF

   #      AFTER FIELD ccc08
   #         IF NOT cl_null(tm.ccc08) OR tm.ccc08 != ' '  THEN
   #            IF tm.ccc07='4'THEN
   #               SELECT pja01 INTO l_pja01 FROM pja_file WHERE pja01=tm.ccc08
   #                                          AND pjaclose='N'
   #               IF STATUS THEN
   #                  CALL cl_err3("sel","pja_file",tm.ccc08,"",STATUS,"","sel pja:",1)
   #                  NEXT FIELD ccc07
   #               END IF
   #            END IF
   #            IF tm.ccc07='5'THEN
   #               SELECT UNIQUE imd09 INTO l_imd09 FROM imd_file WHERE imd09=tm.ccc08
   #               IF STATUS THEN
   #                  CALL cl_err3("sel","imd_file",tm.ccc08,"",STATUS,"","sel imd:",1)
   #                  NEXT FIELD ccc07
   #               END IF
   #            END IF
   #         ELSE
   #            LET tm.ccc08 = ' '
   #         END IF

   #      AFTER FIELD more
   #         IF tm.more NOT MATCHES "[YN]" OR tm.more IS NULL THEN
   #            NEXT FIELD more
   #         END IF
   #
   #         IF tm.more = 'Y' THEN
   #            CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
   #                           g_bgjob,g_time,g_prtway,g_copies)
   #                 RETURNING g_pdate,g_towhom,g_rlang,
   #                           g_bgjob,g_time,g_prtway,g_copies
   #         END IF
   #      END INPUT
   #      ON ACTION controlp
   #      CASE
   #        WHEN INFIELD(cfc07)
   #         CALL cl_init_qry_var()
   #         LET g_qryparam.form = "q_cfc07"
   #         LET g_qryparam.state = "c"
   #         CALL cl_create_qry() RETURNING g_qryparam.multiret
   #         DISPLAY g_qryparam.multiret TO cfc07
   #         NEXT FIELD cfc07
   #
   #        WHEN INFIELD(cfc11)
   #         CALL cl_init_qry_var()
   #         LET g_qryparam.form = "q_cfc11"
   #         LET g_qryparam.state = "c"
   #         CALL cl_create_qry() RETURNING g_qryparam.multiret
   #         DISPLAY g_qryparam.multiret TO cfc11
   #         NEXT FIELD cfc11
   #
   #       WHEN INFIELD(ccc08)
   #         IF tm.ccc07 MATCHES '[45]' THEN
   #             CALL cl_init_qry_var()
   #             CASE tm.ccc07
   #             WHEN '4'
   #                LET g_qryparam.form = "q_pja"
   #             WHEN '5'
   #                LET g_qryparam.form = "q_gem4"
   #              OTHERWISE EXIT CASE
   #              END CASE
   #              LET g_qryparam.default1 = tm.ccc08
   #              CALL cl_create_qry() RETURNING tm.ccc08
   #              DISPLAY BY NAME  tm.ccc08
   #              NEXT FIELD ccc08
   #           END IF
   #     END CASE
   #FUN-D70058--mark--end
 INPUT BY NAME tm.s,tm.type,tm.yy,tm.mm
         ATTRIBUTES (WITHOUT DEFAULTS)
         BEFORE INPUT
            LET tm.s='3'
            LET tm.type=g_ccz.ccz28
            LET tm.yy=g_ccz.ccz01
            LET tm.mm=g_ccz.ccz02
            DISPLAY BY NAME tm.s,tm.type,tm.yy,tm.mm

         ON CHANGE s
            IF cl_null(tm.s) THEN NEXT FIELD s END IF
            CALL q802_set_visible()

         AFTER FIELD type
            IF cl_null(tm.type) THEN
               IF tm.type NOT MATCHES '[12345]' THEN
                  NEXT FIELD type
               END IF
            END IF

         AFTER FIELD yy
            IF NOT cl_null(tm.yy) THEN
               IF tm.yy > 9999 OR tm.yy < 1000 THEN
                  CALL cl_err('','ask-003',0)
                  NEXT FIELD yy
               END IF
            END IF

         AFTER FIELD mm
            IF NOT cl_null(tm.mm) THEN
               IF tm.mm >13 OR tm.mm < 1 THEN
                  CALL cl_err('','agl-013',0)
                  NEXT FIELD mm
               END IF
            END IF
      END INPUT
      CONSTRUCT tm.wc ON cfb00,cfb01,cfb02,cfb16,cfb03,cfb04,cfb05,cfb06,cfb061,
                         cfb07,cfb08,cfb09,cfb10,cfb11,cfb13,cfb12,cfb14,cfb141,
                         cfb142,cfb15,cfb17,cfb18,cfb19,cfb20
                    FROM s_cfb[1].cfb00, s_cfb[1].cfb01, s_cfb[1].cfb02, s_cfb[1].cfb16,
                         s_cfb[1].cfb03, s_cfb[1].cfb04, s_cfb[1].cfb05, s_cfb[1].cfb06,
                         s_cfb[1].cfb061,s_cfb[1].cfb07, s_cfb[1].cfb08, s_cfb[1].cfb09,
                         s_cfb[1].cfb10, s_cfb[1].cfb11, s_cfb[1].cfb13, s_cfb[1].cfb12,
                         s_cfb[1].cfb14, s_cfb[1].cfb141,s_cfb[1].cfb142,s_cfb[1].cfb15,
                         s_cfb[1].cfb17, s_cfb[1].cfb18, s_cfb[1].cfb19, s_cfb[1].cfb20
        BEFORE CONSTRUCT
           CALL cl_qbe_init()

      END CONSTRUCT
      ON ACTION controlp
         CASE
            WHEN INFIELD(cfb16)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb16"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb16
               NEXT FIELD cfb16
            WHEN INFIELD(cfb03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb03"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb03
               NEXT FIELD cfb03
            WHEN INFIELD(cfb04)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb04"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb04
               NEXT FIELD cfb04
            WHEN INFIELD(cfb07)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb07"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb07
               NEXT FIELD cfb07
            WHEN INFIELD(cfb09)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb09"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb09
               NEXT FIELD cfb09
            WHEN INFIELD(cfb11)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb11"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb11
               NEXT FIELD cfb11
            WHEN INFIELD(cfb12)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb12"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb12
               NEXT FIELD cfb12
            WHEN INFIELD(cfb14)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb14"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb14
               NEXT FIELD cfb14
            WHEN INFIELD(cfb17)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb17"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb17
               NEXT FIELD cfb17
            WHEN INFIELD(cfb19)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_cfb19"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO cfb19
               NEXT FIELD cfb19
         END CASE
      #FUN-D70058--add--end
     ON ACTION locale
         LET g_change_lang = TRUE
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
   #     EXIT DIALOG    #TQC-D20046

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION CONTROLR
         CALL cl_show_req_fields()

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION qbe_select
         CALL cl_qbe_select()

      ON ACTION accept
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG=1
         EXIT DIALOG
    END DIALOG
    IF g_action_choice = "locale" THEN
         LET g_action_choice = ""
         CALL cl_dynamic_locale()
			#CONTINUE WHILE #FUN-D70058 mark
      END IF

   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW q802_w1
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
    # EXIT PROGRAM                                   #FUN-CA0084
      CLOSE WINDOW q802_w1                           #FUN-CA0084
      RETURN                                         #FUN-CA0084
   END IF
	  IF cl_null(tm.wc) THEN LET tm.wc='1=1' END IF #FUN-D70058
   CALL cl_wait()
   #CALL q802()  #FUN-D70058 mark
   CALL q802_t('q') #FUN-D70058
   CALL q802_show() #FUN-D70058
   ERROR ""
    #EXIT WHILE #FUN-D70058 mark
#END WHILE     #FUN-D70058 mark
   #CLOSE WINDOW q802_w1  #FUN-D70058 mark
   #FUN-D70058--mark--str--
   #IF tm.flag='Y' THEN
   #   CALL cl_set_comp_visible("cfc11,cfc13,cfc15,sum1,sum2,sum3,sum4,sum5,ima021",TRUE)
   #ELSE
   #   CALL cl_set_comp_visible("cfc11,cfc13,cfc15,sum1,sum2,sum3,sum4,sum5,ima021",FALSE) ##TQC-D20046 cj add cfc13 ima021
   #END IF
   #FUN-D70058--mark--end
   DISPLAY g_rec_b TO cn2
END FUNCTION

#FUN-D70058--mark--str--
#FUNCTION q802()
#DEFINE l_c1,l_c2  LIKE type_file.num5
#DEFINE l_s1,l_s2  LIKE type_file.num20_6
#  DEFINE temp_cfc11 STRING #FUN-C60033 add by xuxz

#  CALL g_cfc.clear()
#  LET g_cnt = 1
#   IF tm.flag='N' THEN
##No.MOD-CB0240 --begin
#      DROP TABLE x
#      CREATE TEMP TABLE x (
#      cfc07x     LIKE cfc_file.cfc07,
#      cfc11x     LIKE cfc_file.cfc11)
#
#      LET g_sql=" INSERT INTO x SELECT  DISTINCT cfc07,cfc11  ",
#                " FROM cfc_file,occ_file ",
#                " WHERE occ01= cfc07 AND occacti='Y' ",
#                "   AND ",tm.wc CLIPPED
#      PREPARE sel_cfc_pre_tmpx FROM g_sql
#      DECLARE sel_cfc_cs_tmpx CURSOR FOR sel_cfc_pre_tmpx
#      EXECUTE sel_cfc_pre_tmpx
#      IF STATUS THEN CALL cl_err('insert tmp x.',STATUS,1) END IF
##No.MOD-CB0240 --end
#      LET g_sql=" SELECT  DISTINCT cfc07,cfc08,'','','','','','','','', ",
#                " '','','','','','','' ",     #TQC-D20046 cj add 2''
#                " FROM cfc_file,occ_file ",
#                " WHERE occ01= cfc07 AND occacti='Y' ",
#                "   AND ",tm.wc CLIPPED
#      PREPARE sel_cfc_pre FROM g_sql
#      DECLARE sel_cfc_cs CURSOR FOR sel_cfc_pre
#      FOREACH sel_cfc_cs INTO g_cfc[g_cnt].*
#      IF STATUS THEN CALL cl_err('foreach.',STATUS,1) EXIT FOREACH END IF
#
#       #期初金额
#       LET l_s1=0
#       LET l_s2=0
#       SELECT SUM(cfc15*ccc23) INTO l_s1 FROM cfc_file,ccc_file,x WHERE cfc11=ccc01 AND cfc05=ccc02       #No.MOD-CB0240 add x
#                                                                  AND cfc06=ccc03 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm))
#                                                                  AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#                                                                  AND cfc11 = cff11x AND cfc07 = cfc07x   #No.MOD-CB0240 add
#                                                                  AND ccc07=tm.ccc07 AND cfc01=1 AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07
#       SELECT SUM(cfc15*ccc23) INTO l_s2 FROM cfc_file,ccc_file,x WHERE cfc11=ccc01 AND cfc05=ccc02       #No.MOD-CB0240 add x
#                                                                  AND cfc06=ccc03 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm))
#                                                                  AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#                                                                  AND cfc11 = cff11x AND cfc07 = cfc07x   #No.MOD-CB0240 add
#                                                                  AND ccc07=tm.ccc07  AND cfc01=-1  AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07
#      IF cl_null(l_s1) THEN LET l_s1 = 0 END IF
#      IF cl_null(l_s2) THEN LET l_s2 = 0 END IF
#
#      LET g_cfc[g_cnt].tot=l_s1-l_s2
#      IF cl_null(g_cfc[g_cnt].tot) THEN let g_cfc[g_cnt].tot=0 END IF
#      #本月出货转入金额
#      LET g_cfc[g_cnt].tot1=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot1 FROM cfc_file,ccc_file,x           #No.MOD-CB0240 add x
#       WHERE cfc11=ccc01 AND cfc05=ccc02 AND cfc06=ccc03 AND cfc00 IN ('1','2')
#         AND cfc01=1 AND ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND ccc02=tm.yy
#         AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#         AND cfc11 = cff11x AND cfc07 = cfc07x                                          #No.MOD-CB0240 add
#         AND ccc03=tm.mm AND cfc07=g_cfc[g_cnt].cfc07  GROUP BY cfc07
#        IF cl_null(g_cfc[g_cnt].tot1) THEN let g_cfc[g_cnt].tot1=0 END IF
#      #本月出货转出金额
#      LET g_cfc[g_cnt].tot2=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot2 FROM cfc_file,ccc_file,x           #No.MOD-CB0240 add x
#        WHERE cfc11=ccc01 AND cfc05=ccc02 AND  cfc06=ccc03  AND cfc00 IN ('1','2')
#         AND  cfc01=-1 AND ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND ccc02=tm.yy AND ccc03=tm.mm
#         AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#         AND cfc11 = cff11x AND cfc07 = cfc07x                                          #No.MOD-CB0240 add
#         AND cfc07=g_cfc[g_cnt].cfc07   GROUP BY cfc07
#       IF cl_null(g_cfc[g_cnt].tot2) THEN let g_cfc[g_cnt].tot2=0 END IF
#      #本月销退转入金额
#      LET g_cfc[g_cnt].tot3=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot3 FROM cfc_file,ccc_file,x           #No.MOD-CB0240 add x
#       WHERE cfc11=ccc01 AND cfc05=ccc02 AND cfc06=ccc03 AND  cfc00='3' AND cfc01=1
#        AND  ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND  ccc02=tm.yy AND ccc03=tm.mm
#        AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#        AND cfc11 = cff11x AND cfc07 = cfc07x                                          #No.MOD-CB0240 add
#        AND cfc07=g_cfc[g_cnt].cfc07   GROUP BY cfc07
#       IF cl_null(g_cfc[g_cnt].tot3) THEN let g_cfc[g_cnt].tot3=0 END IF
#      #本月销退转出金额
#      LET g_cfc[g_cnt].tot4=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot4 FROM cfc_file,ccc_file,x           #No.MOD-CB0240 add x
#       WHERE  cfc11=ccc01 AND cfc05=ccc02 AND  cfc06=ccc03  AND  cfc00='3'
#         AND  cfc01=-1 AND ccc07=tm.ccc07 AND  ccc08 = tm.ccc08 AND  ccc02=tm.yy
#         AND ccc01 NOT LIKE 'MISC%' #FUN-C60033 add bu xuxz
#         AND cfc11 = cff11x AND cfc07 = cfc07x                                          #No.MOD-CB0240 add
#         AND  ccc03=tm.mm AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07
#        IF cl_null(g_cfc[g_cnt].tot4) THEN let g_cfc[g_cnt].tot4=0 END IF
#      #期末金额
#      LET g_cfc[g_cnt].tot5=0
#      LET g_cfc[g_cnt].tot5 =g_cfc[g_cnt].tot +g_cfc[g_cnt].tot1 -g_cfc[g_cnt].tot2
#                              +g_cfc[g_cnt].tot3 - g_cfc[g_cnt].tot4
#    #TQC-D20046--cj--add--
#      SELECT ima021 INTO g_cfc[g_cnt].ima021 FROM ima_file
#       WHERE ima01 = g_cfc[g_cnt].cfc11
#    #TQC-D20046--cj--add--
#      LET g_cnt = g_cnt + 1
#      IF g_cnt > g_max_rec THEN
#         CALL cl_err( '', 9035, 0 )
#         EXIT FOREACH
#      END IF
#      END FOREACH
#    ELSE
#       #期初数量
#       LET g_sql=" SELECT  DISTINCT cfc07,cfc08,cfc11,cfc13,'','','','','','','', ",
#                " '','','','','','' ",   #TQC-D20046 cj add cfc13 ''
#                " FROM cfc_file,occ_file ",
#                " WHERE occ01= cfc07 AND occacti='Y' ",
#                "   AND ",tm.wc CLIPPED
#      PREPARE sel_cfc_pre1 FROM g_sql
#      DECLARE sel_cfc_cs1 CURSOR FOR sel_cfc_pre1
#      FOREACH sel_cfc_cs1 INTO g_cfc[g_cnt].*
#      IF STATUS THEN CALL cl_err('foreach.',STATUS,1) EXIT FOREACH END IF
#       LET l_c1=0
#       LET l_c2=0
#       LET g_cfc[g_cnt].cfc15=0
#       SELECT SUM(cfc15) INTO l_c1 FROM cfc_file WHERE cfc01=1 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm)) AND cfc11=g_cfc[g_cnt].cfc11
#       AND cfc07=g_cfc[g_cnt].cfc07  GROUP BY cfc07,cfc11
#       SELECT SUM(cfc15) INTO l_c2 FROM cfc_file WHERE cfc01=-1 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm)) AND cfc11=g_cfc[g_cnt].cfc11
#       AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#       IF cl_null(l_c1) THEN LET l_c1 = 0 END IF
#       IF cl_null(l_c2) THEN LET l_c2 = 0 END IF
#       LET g_cfc[g_cnt].cfc15=l_c1-l_c2
#       IF cl_null(g_cfc[g_cnt].cfc15) THEN  LET g_cfc[g_cnt].cfc15=0 END IF
#
#       #期初金额
#       LET l_s1=0
#       LET l_s2=0
#       LET g_cfc[g_cnt].tot=0
#       SELECT SUM(cfc15*ccc23) INTO l_s1 FROM cfc_file,ccc_file WHERE cfc11=ccc01 AND cfc05=ccc02
#                                                                  AND cfc06=ccc03 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm))
#                                                                  AND ccc07=tm.ccc07 AND cfc01=1 AND cfc11=g_cfc[g_cnt].cfc11
#                                                                  AND cfc07=g_cfc[g_cnt].cfc07  GROUP BY cfc07,cfc11
#       SELECT SUM(cfc15*ccc23) INTO l_s2 FROM cfc_file,ccc_file WHERE cfc11=ccc01 AND cfc05=ccc02
#                                                                  AND cfc06=ccc03 AND (cfc05<tm.yy OR (cfc05=tm.yy AND cfc06<tm.mm))
#                                                                  AND ccc07=tm.ccc07  AND cfc01=-1  AND cfc11=g_cfc[g_cnt].cfc11
#                                                                  AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(l_s1) THEN LET l_s1 = 0 END IF
#      IF cl_null(l_s2) THEN LET l_s2 = 0 END IF
#      LET g_cfc[g_cnt].tot=l_s1-l_s2
#      IF cl_null(g_cfc[g_cnt].tot) THEN  LET g_cfc[g_cnt].tot =0 END IF
#      #本月出货转入数量
#      LET g_cfc[g_cnt].sum1=0
#      SELECT SUM(cfc15) INTO g_cfc[g_cnt].sum1
#        FROM cfc_file WHERE cfc00 IN ('1','2') AND cfc01=1
#                        AND cfc05=tm.yy AND cfc06=tm.mm AND cfc11=g_cfc[g_cnt].cfc11
#                        AND cfc07=g_cfc[g_cnt].cfc07  GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].sum1) THEN  LET g_cfc[g_cnt].sum1=0 END IF
#      #本月出货转入金额
#      LET g_cfc[g_cnt].tot1=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot1 FROM cfc_file,ccc_file
#       WHERE cfc11=ccc01 AND cfc05=ccc02 AND cfc06=ccc03 AND cfc00 IN ('1','2')
#         AND cfc01=1 AND ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND ccc02=tm.yy
#         AND ccc03=tm.mm AND cfc11=g_cfc[g_cnt].cfc11 AND cfc07=g_cfc[g_cnt].cfc07  GROUP BY cfc07,cfc11
#        IF cl_null(g_cfc[g_cnt].tot1) THEN  LET g_cfc[g_cnt].tot1 =0 END IF
#      #本月出货转出数量
#      LET g_cfc[g_cnt].sum2=0
#      SELECT SUM(cfc15) INTO g_cfc[g_cnt].sum2
#        FROM  cfc_file WHERE cfc00 IN ('1','2')
#                        AND  cfc01=-1 AND cfc05=tm.yy
#                        AND cfc06=tm.mm AND cfc11=g_cfc[g_cnt].cfc11
#                        AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].sum2) THEN  LET g_cfc[g_cnt].sum2 =0 END IF
#      #本月出货转出金额
#      LET g_cfc[g_cnt].tot2=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot2 FROM cfc_file,ccc_file
#        WHERE cfc11=ccc01 AND cfc05=ccc02 AND  cfc06=ccc03  AND cfc00 IN ('1','2')
#         AND  cfc01=-1 AND ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND ccc02=tm.yy AND ccc03=tm.mm
#         AND cfc11=g_cfc[g_cnt].cfc11  AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].tot2) THEN  LET g_cfc[g_cnt].tot2 =0 END IF
#
#     #本月销退转入数量
#      LET g_cfc[g_cnt].sum3=0
#      SELECT SUM(cfc15) INTO g_cfc[g_cnt].sum3 FROM  cfc_file
#       WHERE cfc00='3' AND  cfc01=1 AND  cfc05=tm.yy AND  cfc06=tm.mm
#         AND cfc11=g_cfc[g_cnt].cfc11  AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].sum3) THEN  LET g_cfc[g_cnt].sum3 =0 END IF
#      #本月销退转入金额
#      LET g_cfc[g_cnt].tot3=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot3 FROM cfc_file,ccc_file
#       WHERE cfc11=ccc01 AND cfc05=ccc02 AND cfc06=ccc03 AND  cfc00='3' AND cfc01=1
#        AND  ccc07=tm.ccc07 AND ccc08 = tm.ccc08 AND  ccc02=tm.yy AND ccc03=tm.mm
#        AND cfc11=g_cfc[g_cnt].cfc11  AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].tot3) THEN  LET g_cfc[g_cnt].tot3 =0 END IF
#      #本月销退转出数量
#      LET g_cfc[g_cnt].sum4=0
#      SELECT SUM(cfc15) INTO g_cfc[g_cnt].sum4  FROM  cfc_file
#       WHERE cfc00='3' AND  cfc01=-1 AND  cfc05=tm.yy AND  cfc06=tm.mm
#        AND cfc11=g_cfc[g_cnt].cfc11 AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#      IF cl_null(g_cfc[g_cnt].sum4) THEN  LET g_cfc[g_cnt].sum4 =0 END IF
#      #本月销退转出金额
#      LET g_cfc[g_cnt].tot4=0
#      SELECT SUM(cfc15*ccc23) INTO g_cfc[g_cnt].tot4 FROM cfc_file,ccc_file
#       WHERE  cfc11=ccc01 AND cfc05=ccc02 AND  cfc06=ccc03  AND  cfc00='3'
#         AND  cfc01=-1 AND ccc07=tm.ccc07 AND  ccc08 = tm.ccc08 AND  ccc02=tm.yy
#         AND  ccc03=tm.mm AND cfc11=g_cfc[g_cnt].cfc11 AND cfc07=g_cfc[g_cnt].cfc07 GROUP BY cfc07,cfc11
#       IF cl_null(g_cfc[g_cnt].tot4) THEN  LET g_cfc[g_cnt].tot4 =0 END IF
#      #期末数量
#      LET g_cfc[g_cnt].sum5=0
#      LET g_cfc[g_cnt].sum5 = g_cfc[g_cnt].cfc15+g_cfc[g_cnt].sum1-g_cfc[g_cnt].sum2
#                              +g_cfc[g_cnt].sum3 - g_cfc[g_cnt].sum4
#
#      LET temp_cfc11 = g_cfc[g_cnt].cfc11
#      IF temp_cfc11.substring(1,4) = 'MISC' THEN
#         LET g_cfc[g_cnt].tot = 0
#         LET g_cfc[g_cnt].tot1 = 0
#         LET g_cfc[g_cnt].tot2 = 0
#         LET g_cfc[g_cnt].tot3 = 0
#         LET g_cfc[g_cnt].tot4 = 0
#      END IF
#      #期末金额
#      LET g_cfc[g_cnt].tot5=0
#      LET g_cfc[g_cnt].tot5 =g_cfc[g_cnt].tot +g_cfc[g_cnt].tot1-g_cfc[g_cnt].tot2
#                              +g_cfc[g_cnt].tot3 - g_cfc[g_cnt].tot4
#    #TQC-D20046--cj--add--
#      SELECT ima021 INTO g_cfc[g_cnt].ima021 FROM ima_file
#       WHERE ima01 = g_cfc[g_cnt].cfc11
#    #TQC-D20046--cj--add--
#      LET g_cnt = g_cnt + 1
#      IF g_cnt > g_max_rec THEN
#         CALL cl_err( '', 9035, 0 )
#         EXIT FOREACH
#      END IF
#      END FOREACH
#    END IF
#      CALL g_cfc.deleteElement(g_cnt)
#      LET g_rec_b = g_cnt-1
#
#      IF tm.flag='Y' THEN
#         CALL cl_set_comp_visible("cfc11,cfc13,cfc15,sum1,sum2,sum3,sum4,sum5,ima021",TRUE)
#      ELSE
#         CALL cl_set_comp_visible("cfc11,cfc13,cfc15,sum1,sum2,sum3,sum4,sum5,ima021",FALSE) #TQC-D20046 cj add cfc13 ima021
#      END IF
#END FUNCTION
#FUN-D70058


FUNCTION q802_out()
   DEFINE l_table STRING
   DEFINE l_i LIKE type_file.num10
   LET g_sql = "cfc07.cfc_file.cfc07,",
               "cfc08.cfc_file.cfc08,",
               "cfc11.cfc_file.cfc11,",
               "cfc13.cfc_file.cfc13,",     #TQC-D20046 cj add
               "cfc15.cfc_file.cfc15,",
               "tot.type_file.num20_6,",
               "sum1.cfc_file.cfc15,",
               "tot1.type_file.num20_6,",
               "sum2.cfc_file.cfc15,",
               "tot2.type_file.num20_6,",
               "sum3.cfc_file.cfc15,",
               "tot3.type_file.num20_6,",
               "sum4.cfc_file.cfc15,",
               "tot4.type_file.num20_6,",
               "sum5.cfc_file.cfc15,",
               "tot5.type_file.num20_6,",
               "ima021.ima_file.ima021"      #TQC-D20046 cj add
   LET l_table = cl_prt_temptable('axcr802',g_sql) CLIPPED
   IF l_table = -1 THEN
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF

   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?,?,?)"    #TQC-D20046 cj add 2?
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF
   FOR l_i=1 TO g_rec_b
      EXECUTE insert_prep USING g_cfc[l_i].*
   END FOR
   LET g_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED," ORDER BY cfc07"
   LET g_str = ''
   LET g_str = tm.wc
   CALL cl_wcchp(g_str,'cfc07,cfc11')
              RETURNING g_str
   #FUN-D70058--mark--str--
   #LET g_str = g_str,";",tm.flag

   #IF tm.flag= 'N' THEN
      CALL cl_prt_cs3('axcq802','axcq802',g_sql,g_str)
   #ELSE
   #   CALL cl_prt_cs3('axcq802','axcq802_1',g_sql,g_str)
   #END IF
   #FUN-D70058--mark--end
END FUNCTION
#FUN-C60033

#FUN-D70058--add--str--
FUNCTION q802_set_visible()
   CASE
      WHEN tm.s='1'
         CALL cl_set_comp_visible("cfc07,cfc08",TRUE)
         CALL cl_set_comp_visible("cfc11,cfc13,cfc19,aag02",FALSE)
      WHEN tm.s='2'
         CALL cl_set_comp_visible("cfc11,cfc13",TRUE)
         CALL cl_set_comp_visible("cfc07,cfc08,cfc19,aag02",FALSE)
      WHEN tm.s='3'
         CALL cl_set_comp_visible("cfc07,cfc08,cfc11,cfc13",TRUE)
         CALL cl_set_comp_visible("cfc19,aag02",TRUE)
      WHEN tm.s='4'
         CALL cl_set_comp_visible("cfc19,aag02",TRUE)
         CALL cl_set_comp_visible("cfc07,cfc08,cfc11,cfc13",FALSE)
      OTHERWISE EXIT CASE
         CALL cl_set_comp_visible("cfc07,cfc08,cfc11,cfc13,cfc19,aag02",TRUE)
   END CASE
END FUNCTION

FUNCTION q802_temp_table()
   DROP TABLE q802_cfb_tmp
   CREATE TEMP TABLE q802_cfb_tmp(
       cfb00  LIKE cfb_file.cfb00,
       cfb01  LIKE cfb_file.cfb01,
       cfb02  LIKE cfb_file.cfb02,
       cfb16  LIKE cfb_file.cfb16,
       cfb03  LIKE cfb_file.cfb03,
       cfb04  LIKE cfb_file.cfb04,
       cfb05  LIKE cfb_file.cfb05,
       cfb06  LIKE cfb_file.cfb06,
       cfb061 LIKE cfb_file.cfb061,
       cfb07  LIKE cfb_file.cfb07,
       cfb08  LIKE cfb_file.cfb08,
       cfb09  LIKE cfb_file.cfb09,
       cfb10  LIKE cfb_file.cfb10,
       cfb11  LIKE cfb_file.cfb11,
       cfb13  LIKE cfb_file.cfb13,
       cfb12  LIKE cfb_file.cfb12,
       cfb14  LIKE cfb_file.cfb14,
       cfb141 LIKE cfb_file.cfb141,
       cfb142 LIKE cfb_file.cfb142,
       cfb15  LIKE cfb_file.cfb15,
       cfb17  LIKE cfb_file.cfb17,
       cfb18  LIKE cfb_file.cfb18,
       cfb19  LIKE cfb_file.cfb19,
       cfb20  LIKE cfb_file.cfb20);

   DROP TABLE q802_cfc_tmp
   CREATE TEMP TABLE q802_cfc_tmp(
       cfc07  LIKE cfc_file.cfc07,
       cfc08  LIKE cfc_file.cfc08,
       cfc11  LIKE cfc_file.cfc11,
       cfc13  LIKE cfc_file.cfc13,
       cfc19  LIKE cfc_file.cfc19,
       aag02  LIKE aag_file.aag02,
       cfc17  LIKE cfc_file.cfc17,
       sum_qc LIKE cfc_file.cfc15,
       amt_qc LIKE type_file.num20_6,
       sum_ch LIKE cfc_file.cfc15,
       amt_ch LIKE type_file.num20_6,
       sum_kp LIKE cfc_file.cfc15,
       amt_kp LIKE type_file.num20_6,
       sum_qm LIKE cfc_file.cfc15,
       amt_qm LIKE type_file.num20_6);
END FUNCTION
#p_cmd='q'查詢操作；p_cmd='s'匯總操作
FUNCTION q802_t(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_wc  STRING
   DEFINE l_wc1 STRING
   DEFINE bst base.StringTokenizer
   DEFINE l_next LIKE type_file.chr1000
   DEFINE l_n    LIKE type_file.num5
   DEFINE l_sql  STRING

   DELETE FROM q802_cfc_tmp
   #明細資料
   IF p_cmd='q' THEN
      DELETE FROM q802_cfb_tmp
      LET g_sql="INSERT INTO q802_cfb_tmp ",
                "SELECT cfb00,cfb01,cfb02,cfb16,cfb03,cfb04,cfb05,cfb06,cfb061,",
                "       cfb07,cfb08,cfb09,cfb10,cfb11,cfb13,cfb12,cfb14,cfb141,",
                "       cfb142,cfb15,cfb17,cfb18,cfb19,cfb20 ",
                "  FROM cfb_file ",
                " WHERE YEAR(cfb06)=",tm.yy," AND MONTH(cfb06)=",tm.mm,
                "   AND cfb11 NOT LIKE 'MISC%' ",   #AND cfb20='N'", #150705wudj mark
                "   AND ",tm.wc
      PREPARE q802_ins_cfb_tmp FROM g_sql
      EXECUTE q802_ins_cfb_tmp
      IF SQLCA.sqlcode THEN
         CALL cl_err('q802_ins_cfb_tmp',SQLCA.sqlcode,1)
         RETURN
      END IF
   END IF

   #匯總資料
   IF cl_null(tm.s) THEN RETURN END IF
   LET l_wc=cl_replace_str(tm.wc,'cfb','cfc')
   LET l_wc=cl_replace_str(l_wc,' and ','|')
   LET bst= base.StringTokenizer.create(l_wc,'|')
   LET l_n=1
   WHILE bst.hasMoreTokens()
      LET l_next=bst.nextToken()
      IF l_next[1,5]<>'cfc02' AND  l_next[1,5]<>'cfc06'
         AND l_next[1,5]<>'cfc16' AND l_next[1,5]<>'cfc04'
         AND l_next[1,5]<>'cfc05'  AND l_next[1,5]<>'cfc15' THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1=l_next
         ELSE
            LET l_wc1=l_wc1," AND ",l_next
         END IF
      END IF
   END WHILE
   CASE tm.s
      WHEN '1' #客戶
         LET g_sql="INSERT INTO q802_cfc_tmp ",
                   "SELECT DISTINCT cfc07,'' cfc08,'' cfc11,'' cfc13,",
                   "       '' cfc19,'' aag02,cfc17,",
                   "       0 sum_qc,0 amt_qc,0 sum_ch,0 amt_ch,0 sum_kp,0 amt_kp,",
                   "       0 sum_qm,0 amt_qm "
         LET l_sql=" AND c1.cfc07=o.cfc07 AND c1.cfc17=o.cfc17 "
      WHEN '2' #料號
         LET g_sql="INSERT INTO q802_cfc_tmp ",
                   "SELECT DISTINCT '' cfc07,'' cfc08,cfc11,'' cfc13,",
                   "       '' cfc19,'' aag02,cfc17,",
                   "       0 sum_qc,0 amt_qc,0 sum_ch,0 amt_ch,0 sum_kp,0 amt_kp,",
                   "       0 sum_qm,0 amt_qm "
         LET l_sql=" AND c1.cfc11=o.cfc11 AND c1.cfc17=o.cfc17 "
      WHEN '3' #客戶+料號
         LET g_sql="INSERT INTO q802_cfc_tmp ",
                   "SELECT DISTINCT cfc07,'' cfc08,cfc11,'' cfc13,",
                   "       '' cfc19,'' aag02,cfc17,",
                   "       0 sum_qc,0 amt_qc,0 sum_ch,0 amt_ch,0 sum_kp,0 amt_kp,",
                   "       0 sum_qm,0 amt_qm "
         LET l_sql=" AND c1.cfc07=o.cfc07  AND c1.cfc11=o.cfc11 AND c1.cfc17=o.cfc17 "
      WHEN '4' #科目
         LET g_sql="INSERT INTO q802_cfc_tmp ",
                   "SELECT DISTINCT '' cfc07,'' cfc08,'' cfc11,'' cfc13,",
                   "       cfc19,'' aag02,cfc17,",
                   "       0 sum_qc,0 amt_qc,0 sum_ch,0 amt_ch,0 sum_kp,0 amt_kp,",
                   "       0 sum_qm,0 amt_qm "
         LET l_sql=" AND c1.cfc19=o.cfc19 AND c1.cfc17=o.cfc17 "
   END CASE

   LET g_sql=g_sql,"  FROM cfc_file ",
                 # " WHERE cfc05=",tm.yy," AND cfc06=",tm.mm,
                   " WHERE(cfc21<",tm.yy," OR (cfc21=",tm.yy," AND cfc22<",tm.mm,"))",
                   "   AND cfc11 NOT LIKE 'MISC%' ",  #AND cfc20='N' ", #150705wudj mark cfc20
                   "   AND ",l_wc1

   PREPARE q802_ins_cfc_tmp FROM g_sql
   EXECUTE q802_ins_cfc_tmp
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_ins_cfc_tmp',SQLCA.sqlcode,1)
      RETURN
   END IF
   #客户名称,品名,科目名称
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "    SET o.cfc08=(SELECT DISTINCT cfc08 FROM cfc_file n ",
             "                 WHERE n.cfc07=o.cfc07 ",
         #   "                   AND n.cfc05=",tm.yy," AND n.cfc06=",tm.mm,  #mark by pane 170824
             "                   AND rownum<=1) ,",
             "        o.cfc13=(SELECT DISTINCT cfc13 FROM cfc_file m ",
             "                  WHERE m.cfc11=o.cfc11 ",
         #   "                    AND m.cfc05=",tm.yy," AND m.cfc06=",tm.mm,  #mark by pane 170824
             "                    AND rownum<=1) ,",
             "        o.aag02=(SELECT DISTINCT aag02 FROM aag_file WHERE aag01=o.cfc19 AND rownum<=1)"
   PREPARE q802_upd_tmp FROM g_sql
   EXECUTE q802_upd_tmp
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_tmp',SQLCA.sqlcode,1)
      RETURN
   END IF
   #期初數量
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.sum_qc= (",
             "      SELECT NVL(SUM(cfc15*cfc18),0) FROM cfc_file c1 ",       #轉入數量
             "       WHERE(c1.cfc05<",tm.yy," OR (c1.cfc05=",tm.yy," AND c1.cfc06<",tm.mm,"))",
             "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1 ",l_sql," )"
   PREPARE q802_upd_sum_qc FROM g_sql
   EXECUTE q802_upd_sum_qc
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_sum_qc',SQLCA.sqlcode,1)
      RETURN
   END IF
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.sum_qc=o.sum_qc- (",
             "      SELECT NVL(SUM(cfc15*cfc18),0) FROM cfc_file c1 ",    #轉出數量
             "       WHERE(c1.cfc21<",tm.yy," OR (c1.cfc21=",tm.yy," AND c1.cfc22<",tm.mm,"))",
             "         AND c1.cfc01=-1",l_sql," )"
   PREPARE q802_upd_sum_qc1 FROM g_sql
   EXECUTE q802_upd_sum_qc1
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_sum_qc1',SQLCA.sqlcode,1)
      RETURN
   END IF
   #期初金額
   #LET g_sql="UPDATE q802_cfc_tmp o ",
   #          "   SET o.amt_qc= (",
   #          "      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1,ccc_file n1 ",#轉入金額
   #          "       WHERE(c1.cfc05<",tm.yy," OR (c1.cfc05=",tm.yy," AND c1.cfc06<",tm.mm,"))",
   #          "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1",
   #          "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
   #          "         AND c1.cfc06=n1.ccc03 ",
   #          "         AND n1.ccc07='",tm.type,"'",
   #          "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add start
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.amt_qc= (",
             "      SELECT NVL(SUM(cfc15*cfc18*(case when cca23 is not null then cca23 else ccc23 end)),0) FROM cfc_file c1 ", #mark muping171012
             #"      SELECT NVL(SUM(cfc15*cfc18*(case when (cca23 is not null AND ",tm.yy," * 12 + ",tm.mm," <= (2017 * 12 + 6)) then cca23 else ccc23 end)),0) FROM cfc_file c1 ", #add muping171012
             "  LEFT OUTER JOIN cca_file ON cca01=cfc11 and cca02=cfc05 and cca03=cfc06 ",
             "     ,ccc_file n1 ",#轉入金額
             "       WHERE(c1.cfc05<",tm.yy," OR (c1.cfc05=",tm.yy," AND c1.cfc06<",tm.mm,"))",
             "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1",
             "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
             "         AND c1.cfc06=n1.ccc03 ",
             "         AND n1.ccc07='",tm.type,"'",
             "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add end
   PREPARE q802_upd_amt_qc FROM g_sql
   EXECUTE q802_upd_amt_qc
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_amt_qc',SQLCA.sqlcode,1)
      RETURN
   END IF

   #LET g_sql="UPDATE q802_cfc_tmp o ",
   #          "   SET o.amt_qc= o.amt_qc-(",
   #          "      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1,ccc_file n1 ",#轉出金額
   #          "       WHERE(c1.cfc21<",tm.yy," OR (c1.cfc21=",tm.yy," AND c1.cfc22<",tm.mm,"))",
   #          "         AND c1.cfc01=-1",
   #          "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",  #c1.cfc21=n1.ccc02 被我改成 c1.cfc05=n1.ccc02
   #          "         AND c1.cfc06=n1.ccc03 ", #c1.cfc22=n1.ccc02 被我改成 c1.cfc06=n1.ccc02
   #          "         AND n1.ccc07='",tm.type,"'",
   #          "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add start
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.amt_qc= o.amt_qc-(",
             #"       SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1 ",
             "      SELECT NVL(SUM(cfc15*cfc18*(case when cca23 is not null then cca23 else ccc23 end)),0) FROM cfc_file c1 ", #mark muping171012
             #"      SELECT NVL(SUM(cfc15*cfc18*(case when (cca23 is not null AND ",tm.yy," * 12 + ",tm.mm," <= (2017 * 12 + 6)) then cca23 else ccc23 end)),0) FROM cfc_file c1 ", #add muping171012
             "  LEFT OUTER JOIN cca_file ON cca01=cfc11 and cca02=cfc05 and cca03=cfc06 ",
             "      ,ccc_file n1 ",#轉出金額
             "       WHERE(c1.cfc21<",tm.yy," OR (c1.cfc21=",tm.yy," AND c1.cfc22<",tm.mm,"))",
             "         AND c1.cfc01=-1",
             "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",  #c1.cfc21=n1.ccc02 被我改成 c1.cfc05=n1.ccc02
             "         AND c1.cfc06=n1.ccc03 ", #c1.cfc22=n1.ccc02 被我改成 c1.cfc06=n1.ccc02
             "         AND n1.ccc07='",tm.type,"'",
             "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add end
   PREPARE q802_upd_amt_qc1 FROM g_sql
   EXECUTE q802_upd_amt_qc1
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_amt_qc1',SQLCA.sqlcode,1)
      RETURN
   END IF
   #本月出貨數量
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.sum_ch= (",
             "      SELECT NVL(SUM(cfc15*cfc18),0) FROM cfc_file c1 ",       #出貨數量
             "       WHERE c1.cfc05=",tm.yy," AND c1.cfc06=",tm.mm,
             "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1",
             "         AND c1.cfc00 IN ('1','2','3') ",l_sql," )"
   PREPARE q802_upd_sum_ch FROM g_sql
   EXECUTE q802_upd_sum_ch
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_sum_ch',SQLCA.sqlcode,1)
      RETURN
   END IF
  #本月出貨金額
  #LET g_sql="UPDATE q802_cfc_tmp o ",
  #           "   SET o.amt_ch= (",
  #           "      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1,ccc_file n1 ",
  #           "       WHERE c1.cfc05=",tm.yy," AND c1.cfc06=",tm.mm,
  #           "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1",
  #           "         AND c1.cfc00 IN ('1','2','3') ",
  #           "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
  #           "         AND c1.cfc06=n1.ccc03 ",
  #           "         AND n1.ccc07='",tm.type,"'",
  #           "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add start
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.amt_ch= (",
             "      SELECT NVL(SUM(cfc15*cfc18*(case when cca23 is not null then cca23 else ccc23 end)),0) FROM cfc_file c1 ", #mark muping171012
             #"      SELECT NVL(SUM(cfc15*cfc18*(case when (cca23 is not null AND ",tm.yy," * 12 + ",tm.mm," <= (2017 * 12 + 6)) then cca23 else ccc23 end)),0) FROM cfc_file c1 ",  #add muping171012
             "  LEFT OUTER JOIN cca_file ON cca01=cfc11 and cca02=cfc05 and cca03=cfc06 ",
             "      ,ccc_file n1 ",
             "       WHERE c1.cfc05=",tm.yy," AND c1.cfc06=",tm.mm,
             "         AND c1.cfc21=0 AND c1.cfc22 =0 AND c1.cfc01=1",
             "         AND c1.cfc00 IN ('1','2','3') ",
             "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
             "         AND c1.cfc06=n1.ccc03 ",
             "         AND n1.ccc07='",tm.type,"'",
             "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
   #zhouxm170815 add end
   PREPARE q802_upd_amt_ch FROM g_sql
   EXECUTE q802_upd_amt_ch
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_amt_ch',SQLCA.sqlcode,1)
      RETURN
   END IF
   #本月開票數量
   LET g_sql="UPDATE q802_cfc_tmp o ",
             "   SET o.sum_kp= (",
             "      SELECT NVL(SUM(cfc15*cfc18),0) FROM cfc_file c1 ",
             "       WHERE c1.cfc21=",tm.yy," AND c1.cfc22=",tm.mm,
             "         AND c1.cfc01=-1",
             "         AND c1.cfc00 IN ('1','2','3') ",l_sql," )"
   PREPARE q802_upd_sum_kp FROM g_sql
   EXECUTE q802_upd_sum_kp
   IF SQLCA.sqlcode THEN
      CALL cl_err('q802_upd_sum_kp',SQLCA.sqlcode,1)
      RETURN
   END IF
   #本月開票金額

   IF g_oaz.oaz93='Y' THEN
      #納入成本計算,取開票月成本單價
      LET g_sql="UPDATE q802_cfc_tmp o ",
                "   SET o.amt_kp= (",
                "      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1,ccc_file n1 ",#轉入金額
                "       WHERE c1.cfc21=",tm.yy," AND c1.cfc22=",tm.mm,
                "         AND c1.cfc01=-1",
                "         AND c1.cfc00 IN ('1','2','3') ",
                "         AND c1.cfc11=n1.ccc01 AND c1.cfc21=n1.ccc02 ",
                "         AND c1.cfc22=n1.ccc03 ",
                "         AND n1.ccc07='",tm.type,"'",
                "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
      PREPARE q802_upd_amt_kp FROM g_sql
      EXECUTE q802_upd_amt_kp
      IF SQLCA.sqlcode THEN
         CALL cl_err('q802_upd_amt_kp',SQLCA.sqlcode,1)
         RETURN
      END IF
   ELSE
      #不納入成本計算,取出貨月成本單價
      #LET g_sql="UPDATE q802_cfc_tmp o ",
      #          "   SET o.amt_kp= (",
      #          "      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1,ccc_file n1 ",#轉入金額
      #          "       WHERE c1.cfc21=",tm.yy," AND c1.cfc22=",tm.mm,
      #          "         AND c1.cfc01=-1",
      #          "         AND c1.cfc00 IN ('1','2','3') ",
      #          "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
      #          "         AND c1.cfc06=n1.ccc03 ",
      #          "         AND n1.ccc07='",tm.type,"'",
      #          "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
      #zhouxm170815 add start
      LET g_sql="UPDATE q802_cfc_tmp o ",
                "   SET o.amt_kp= (",
                #"      SELECT NVL(SUM(cfc15*cfc18*ccc23),0) FROM cfc_file c1",
                "      SELECT NVL(SUM(cfc15*cfc18*(case when cca23 is not null then cca23 else ccc23 end)),0) FROM cfc_file c1",#mark muping171012
                #"      SELECT NVL(SUM(cfc15*cfc18*(case when (cca23 is not null AND ",tm.yy," * 12 + ",tm.mm," <= (2017 * 12 + 6)) then cca23 else ccc23 end)),0) FROM cfc_file c1", #add muping171012
                "  LEFT OUTER JOIN cca_file ON cca01=cfc11 and cca02=cfc05 and cca03=cfc06 ",
                "     ,ccc_file n1 ",#轉入金額
                "       WHERE c1.cfc21=",tm.yy," AND c1.cfc22=",tm.mm,
                "         AND c1.cfc01=-1",
                "         AND c1.cfc00 IN ('1','2','3') ",
                "         AND c1.cfc11=n1.ccc01 AND c1.cfc05=n1.ccc02 ",
                "         AND c1.cfc06=n1.ccc03 ",
                "         AND n1.ccc07='",tm.type,"'",
                "         AND n1.ccc01 NOT LIKE 'MISC%'",l_sql," )"
      #zhouxm170815 add end
      PREPARE q802_upd_amt_kp_1 FROM g_sql
      EXECUTE q802_upd_amt_kp_1
      IF SQLCA.sqlcode THEN
         CALL cl_err('q802_upd_amt_kp_1',SQLCA.sqlcode,1)
         RETURN
      END IF
   END IF
   UPDATE q802_cfc_tmp
     SET sum_qc=NVL(sum_qc,0),sum_ch=NVL(sum_ch,0),sum_kp=NVL(sum_kp,0),
         amt_qc=NVL(amt_qc,0),amt_ch=NVL(amt_ch,0),amt_kp=NVL(amt_kp,0)

   #期末數量和金額
   UPDATE q802_cfc_tmp
      SET sum_qm=sum_qc+sum_ch-sum_kp,
          amt_qm=amt_qc+amt_ch-amt_kp
   IF SQLCA.sqlcode THEN
      CALL cl_err('upd sum_qm amt_qm',SQLCA.sqlcode,1)
      RETURN
   END IF
END FUNCTION

FUNCTION q802_bp2()
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY tm.s TO s
   DISPLAY g_rec_b2 TO FORMONLY.cn2
   IF cl_null(tm.s) OR (NOT cl_null(tm.s) AND g_action_flag = 'page1') THEN
      LET g_action_flag = 'page2'
      CALL q802_b_fill_2()
   END IF
   LET g_flag1 = ' '
   LET g_action_flag = 'page2'
   LET g_action_choice = " "
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT tm.s FROM s ATTRIBUTE(WITHOUT DEFAULTS)
         ON CHANGE s
            IF NOT cl_null(tm.s)  THEN
               CALL q802_t('s')
               CALL q802_b_fill_2()
               CALL q802_set_visible()
               LET g_action_choice = "page2"
            ELSE
               CALL q802_b_fill_1()
               CALL cl_set_comp_visible("page2", FALSE)
               CALL ui.interface.refresh()
               CALL cl_set_comp_visible("page2", TRUE)
               LET g_action_choice = "page1"
               CALL g_cfc.clear()
               LET g_rec_b2=0
            END IF
            DISPLAY tm.s TO s
            EXIT DIALOG
      END INPUT

      DISPLAY ARRAY g_cfc TO s_cfc.* ATTRIBUTE(COUNT=g_rec_b2)
         BEFORE ROW
            LET l_ac1 = ARR_CURR()
            CALL cl_show_fld_cont()
      END DISPLAY

      ON ACTION page1
         LET g_action_choice="page1"
         LET g_flag1='2'
         EXIT DIALOG

      ON ACTION accept
         LET l_ac1 = ARR_CURR()
         IF l_ac1 > 0  THEN
            CALL q802_detail_fill(l_ac1)
            CALL cl_set_comp_visible("page2", FALSE)
            CALL ui.interface.refresh()
            CALL cl_set_comp_visible("page2", TRUE)
            LET g_action_choice= "page1"
            LET g_flag1 = '1'
            EXIT DIALOG
         END IF

      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG


      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DIALOG

      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about
         CALL cl_about()


      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

   END DIALOG
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION q802_show()
   DISPLAY tm.s,tm.type,tm.yy,tm.mm TO s,type,yy,mm

   CALL q802_b_fill_1()
   CALL q802_b_fill_2()
   IF cl_null(tm.s)  THEN
      LET g_action_choice = "page1"
      CALL cl_set_comp_visible("page2", FALSE)
      CALL ui.interface.refresh()
      CALL cl_set_comp_visible("page2", TRUE)
   ELSE
      LET g_action_choice = "page2"
      CALL cl_set_comp_visible("page1", FALSE)
      CALL ui.interface.refresh()
      CALL cl_set_comp_visible("page1", TRUE)
   END IF
   CALL q802_set_visible()
   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION q802_b_fill_1()

   LET g_sql = "SELECT * FROM q802_cfb_tmp ",
               " ORDER BY cfb00,cfb01,cfb02,cfb03,cfb04,cfb06,cfb07,cfb11,",
               "          cfb12,cfb17,cfb19,cfb061"
   PREPARE axrq802_pb1 FROM g_sql
   DECLARE cfb_cs1  CURSOR FOR axrq802_pb1        #CURSOR

   CALL g_cfb.clear()
   LET g_cnt = 1
   LET g_rec_b = 0
   FOREACH cfb_cs1 INTO g_cfb[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACh
      END IF
   END FOREACH
   CALL g_cfb.deleteElement(g_cnt)
   LET g_rec_b = g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
END FUNCTION

FUNCTION q802_b_fill_2()
DEFINE sum_qc LIKE cfc_file.cfc15,
       amt_qc LIKE type_file.num20_6,
       sum_ch LIKE cfc_file.cfc15,
       amt_ch LIKE type_file.num20_6,
       sum_kp LIKE cfc_file.cfc15,
       amt_kp LIKE type_file.num20_6,
       sum_qm LIKE cfc_file.cfc15,
       amt_qm LIKE type_file.num20_6

       LET sum_qc =0
       LET amt_qc =0
       LET sum_ch =0
       LET amt_ch =0
       LET sum_kp =0
       LET amt_kp =0
       LET sum_qm =0
       LET amt_qm =0
   CALL g_cfc.clear()
   LET g_rec_b2 = 0
   LET g_cnt = 1
   LET g_sql = "SELECT * FROM q802_cfc_tmp ",
               " ORDER BY cfc07,cfc11,cfc19,cfc17"
   PREPARE q802_sel_pr1 FROM g_sql
   DECLARE q802_sel_cs1 CURSOR FOR q802_sel_pr1
   FOREACH q802_sel_cs1 INTO g_cfc[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF

       # add karl
        SELECT ima163 INTO g_cfc[g_cnt]. cfc19 FROM ima_file
         WHERE ima01=g_cfc[g_cnt]. cfc11
          SELECT aag02 INTO g_cfc[g_cnt]. aag02 FROM aag_file
           WHERE aag01=g_cfc[g_cnt]. cfc19
            #end karl
       if g_cfc[g_cnt].sum_qc is not null then
       LET sum_qc =g_cfc[g_cnt].sum_qc +sum_qc
       end if
       if g_cfc[g_cnt].amt_qc  is not null then
       LET amt_qc =g_cfc[g_cnt].amt_qc +amt_qc
       end if
       if g_cfc[g_cnt].sum_ch  is not null then
       LET sum_ch =g_cfc[g_cnt].sum_ch +sum_ch
       end if
       if g_cfc[g_cnt].amt_ch  is not null then
       LET amt_ch =g_cfc[g_cnt].amt_ch +amt_ch
       end if
       if g_cfc[g_cnt].sum_kp  is not null then
       LET sum_kp =g_cfc[g_cnt].sum_kp +sum_kp
       end if
       if g_cfc[g_cnt].amt_kp  is not null then
       LET amt_kp =g_cfc[g_cnt].amt_kp +amt_kp
       end if
       if sum_qm =g_cfc[g_cnt].sum_qm  is not null then
       LET sum_qm =g_cfc[g_cnt].sum_qm +sum_qm
       end if
       if  amt_qm =g_cfc[g_cnt].amt_qm  is not null then
       LET amt_qm =g_cfc[g_cnt].amt_qm +amt_qm
       end if









      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF





   END FOREACH
#   CALL g_cfb.deleteElement(g_cnt)
       LET g_cfc[g_cnt].cfc13='合计'
       LET g_cfc[g_cnt].sum_qc =sum_qc
       LET g_cfc[g_cnt].amt_qc =amt_qc
       LET g_cfc[g_cnt].sum_ch =sum_ch
       LET g_cfc[g_cnt].amt_ch =amt_ch
       LET g_cfc[g_cnt].sum_kp =sum_kp
       LET g_cfc[g_cnt].amt_kp =amt_kp
       LET g_cfc[g_cnt].sum_qm =sum_qm
       LET g_cfc[g_cnt].amt_qm =amt_qm

   LET g_cnt=g_cnt-1
   DISPLAY ARRAY g_cfc TO s_cfc.* ATTRIBUTE(COUNT=g_cnt)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   LET g_rec_b2=g_cnt
   DISPLAY g_rec_b2 TO FORMONLY.cn2
END FUNCTION

FUNCTION q802_detail_fill(p_ac)
DEFINE p_ac   LIKE type_file.num5
DEFINE l_sql  STRING
   IF cl_null(g_cfc[p_ac].cfc17) THEN
      LET l_sql=" AND (cfb17=' ' OR cfb17 IS NULL )"
   ELSE
      LET l_sql=" AND cfb17='",g_cfc[p_ac].cfc17,"'"
   END IF
   LET g_sql="SELECT * FROM q802_cfb_tmp "
   CASE tm.s
      WHEN '1' #客戶
         IF cl_null(g_cfc[p_ac].cfc07) THEN
            LET g_sql=g_sql," WHERE (cfb07=' ' OR cfb07 IS NULL )"
         ELSE
            LET g_sql=g_sql," WHERE cfb07='",g_cfc[p_ac].cfc07,"'"
         END IF
         LET g_sql=g_sql,l_sql," ORDER BY cfb00,cfb01,cfb07,cfb17 "
      WHEN '2' #料件
         IF cl_null(g_cfc[p_ac].cfc11) THEN
            LET g_sql=g_sql," WHERE (cfb11=' ' OR cfb11 IS NULL )"
         ELSE
            LET g_sql=g_sql," WHERE cfb11='",g_cfc[p_ac].cfc11,"'"
         END IF
         LET g_sql=g_sql,l_sql," ORDER BY cfb00,cfb01,cfb11,cfb17 "
      WHEN '3' #客戶+料件
         IF cl_null(g_cfc[p_ac].cfc07) THEN
            LET g_sql=g_sql," WHERE (cfb07=' ' OR cfb07 IS NULL )"
         ELSE
            LET g_sql=g_sql," WHERE cfb07='",g_cfc[p_ac].cfc07,"'"
         END IF
         IF cl_null(g_cfc[p_ac].cfc11) THEN
            LET g_sql=g_sql," AND (cfb11=' ' OR cfb11 IS NULL )"
         ELSE
            LET g_sql=g_sql," AND cfb11='",g_cfc[p_ac].cfc11,"'"
         END IF
         LET g_sql=g_sql,l_sql," ORDER BY cfb00,cfb01,cfb07,cfb11,cfb17 "
      WHEN '4' #科目
         IF cl_null(g_cfc[p_ac].cfc19) THEN
            LET g_sql=g_sql," WHERE (cfb19=' ' OR cfb19 IS NULL )"
         ELSE
            LET g_sql=g_sql," WHERE cfb19='",g_cfc[p_ac].cfc11,"'"
         END IF
         LET g_sql=g_sql,l_sql," ORDER BY cfb00,cfb01,cfb19,cfb17 "
   END CASE
   PREPARE q802_sel_pr2 FROM g_sql
   DECLARE q802_sel_cs2  CURSOR FOR q802_sel_pr2        #CURSOR
   CALL g_cfb.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH q802_sel_cs2 INTO g_cfb[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_cfb.deleteElement(g_cnt)
   LET g_rec_b = g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
END FUNCTION
#FUN-D70058--add--end
