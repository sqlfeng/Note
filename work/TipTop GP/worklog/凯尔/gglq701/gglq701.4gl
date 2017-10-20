# Prog. Version..: '5.30.07-13.05.20(00010)'     #
#
# Pattern name...: gglq701.4gl
# Descriptions...: 科目核算項余額查詢
# Date & Author..: 08/06/05 by Carrier  #No.FUN-850030
# Modify.........: No.FUN-850030 08/07/24 By dxfwo 新增程序從21區移植到31區
# Modify.........: No.FUN-910082 09/02/02 By ve007 wc,sql 定義為STRING
# Modify.........: No.TQC-930163 09/03/31 By elva 新增打印原幣金額
# Modify.........: No.MOD-940388 09/04/30 By wujie 字串連接%前要加轉義符\
# Modify.........: No.FUN-8B0106 09/06/08 By Cockroach CR段修改
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No:FUN-A40009 10/04/07 By wujie 查询界面点退出回到主画面，而不是关闭程序
#                                                  点击单据联查按钮后，光标保持在原来所在的行，而不是回到第一行
# Modify.........: No:FUN-A80034 10/08/04 By wujie 追21区FUN-A40013
# Modify.........: No:MOD-A90110 10/09/16 By Dido 增加取位
# Modify.........: No.FUN-B20010 11/02/10 By yinhy 先選擇帳套，根據帳套判斷科目開窗開哪個帳套的科目資料
# Modify.........: No.FUN-B20055 11/02/22 By destiny 輸入改為DIALOG寫法
# Modify.........: No:FUN-B30211 11/04/01 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No.TQC-B60052 11/02/10 By yinhy INSERT INTO gglq701_tmp增加取位欄位
# Modify.........: No.MOD-C50145 12/05/21 By yinhy 關係人核算項改為99
# Modify.........: No.MOD-C50182 12/05/23 By yinhy SQL語句UNION改為UNION ALL
# Modify.........: No.TQC-C50211 12/05/28 By wujie 无法显示核算项资料来源为缺省时的核算项名称
# Modify.........: No:CHI-C70031 12/10/18 By wangwei 去除CE、CA憑證資料，否則月末結轉損益後，查詢不到損益類科目
# Modify.........: No.FUN-C80102 12/10/17 By zhangweib 財務報表改善追單
# Modify.........: No.TQC-CC0122 13/01/10 By lujh agls103中顯示核算項名稱aaz119=N時，隱藏核算項名稱
# Modify.........: No:FUN-D30014 13/03/07 By lujh FUN-CB0146 追單
# Modify.........: No:FUN-D40044 13/04/24 By lujh 增加選項：是否包含結轉憑證.若=N,則扣除CE/CA（axcq310）的金額
# Modify.........: No.TQC-D60028 13/06/06 By wangrr 獲取科目名稱值
# Modify.........: No.TQC-DC0064 13/12/19 By wangrr 當'單據狀態'為'2:已過帳'時'含未審核憑證'不顯示
# Modify.........: No.MOD-E20114 14/02/24 By fengmy 加核算項查詢條件
# Modify.........: No.MOD-E30064 14/03/11 By fengmy 統制科目核算項顯示
# Modify.........: No.kuangxj    150319   By kuangxj 回收p_sser-流水号:2015030335，代码中不应出现aba19 = 1的情况

DATABASE ds

GLOBALS "../../config/top.global"  #No.FUN-850030

DEFINE tm        RECORD
		 #wc      LIKE type_file.chr1000,
		  wc         STRING ,      #NO.FUN-910082
                 yy      LIKE type_file.num5,
                 m1      LIKE type_file.num5,
                 m2      LIKE type_file.num5,
                 o       LIKE aaa_file.aaa01,
                 a       LIKE type_file.chr2,
                 b       LIKE type_file.chr1,
                 g       LIKE type_file.chr1,                    #FUN-C80102  add
                 #c       LIKE type_file.chr1, #TQC-930163       #FUN-C80102  mark
                 f       LIKE type_file.chr1,                    #FUN-C80102  add
                 #d       LIKE type_file.chr1, #No.FUN-A80034    #FUN-C80102  mark
                 e       LIKE type_file.chr1,                    #FUN-C80102  add
                 i       LIKE type_file.chr1,                    #FUN-D40044  add
 		 more    LIKE type_file.chr1
                 END RECORD,
       g_null    LIKE type_file.chr1,
       g_print   LIKE type_file.chr1

DEFINE g_i            LIKE type_file.num5
DEFINE l_table        STRING,
       g_str          STRING,
       g_sql          STRING

DEFINE   g_rec_b    LIKE type_file.num10
DEFINE   g_aed01    LIKE aed_file.aed01
DEFINE   g_aag02    LIKE aag_file.aag02
DEFINE   g_aed04    LIKE aed_file.aed04
DEFINE   g_cnt      LIKE type_file.num10
DEFINE   g_aed      DYNAMIC ARRAY OF RECORD
                    aed01      LIKE aed_file.aed01,      #FUN-C80102  add
                    aag02      LIKE aag_file.aag02,      #FUN-C80102  add
                    aed02      LIKE type_file.chr50,
                    ahe02_d    LIKE ze_file.ze03,
                    ted09      LIKE ted_file.ted09,  #TQC-930163
                    pb_dc      LIKE type_file.chr10,
                    pb_balf    LIKE aed_file.aed05, #TQC-930163
                    abb25_pb   LIKE abb_file.abb25, #TQC-930163
                    pb_bal     LIKE aed_file.aed05,
                    df         LIKE aed_file.aed05, #TQC-930163
                    abb25_d    LIKE abb_file.abb25, #TQC-930163
                    d          LIKE aed_file.aed05,
                    cf         LIKE aed_file.aed05, #TQC-930163
                    abb25_c    LIKE abb_file.abb25, #TQC-930163
                    c          LIKE aed_file.aed05,
                    dc         LIKE type_file.chr10,
                    balf       LIKE aed_file.aed05, #TQC-930163
                    abb25_bal  LIKE abb_file.abb25, #TQC-930163
                    bal        LIKE aed_file.aed05
                    END RECORD
DEFINE   g_pr       RECORD
                    aed01      LIKE aed_file.aed01,
                    aag02      LIKE aag_file.aag02,
                    aed04      LIKE aed_file.aed04,
                    aed02      LIKE type_file.chr50,
                    ahe02_d    LIKE ze_file.ze03,
                    ted09      LIKE ted_file.ted09,  #TQC-930163
                    type       LIKE type_file.chr10,
                    pb_dc      LIKE type_file.chr10,
                    pb_balf    LIKE aed_file.aed05, #TQC-930163
                    abb25_pb   LIKE abb_file.abb25, #TQC-930163
                    pb_bal     LIKE aed_file.aed05,
                    memo       LIKE abb_file.abb04,
                    df         LIKE aed_file.aed05, #TQC-930163
                    abb25_d    LIKE abb_file.abb25, #TQC-930163
                    d          LIKE aed_file.aed05,
                    cf         LIKE aed_file.aed05, #TQC-930163
                    abb25_c    LIKE abb_file.abb25, #TQC-930163
                    c          LIKE aed_file.aed05,
                    dc         LIKE type_file.chr10,
                    balf       LIKE aed_file.aed05, #TQC-930163
                    abb25_bal  LIKE abb_file.abb25, #TQC-930163
                    bal        LIKE aed_file.aed05, #MOD-A90110
                    azi04      LIKE azi_file.azi04, #MOD-A90110
                    azi05      LIKE azi_file.azi05, #MOD-A90110
                    azi07      LIKE azi_file.azi07  #MOD-A90110
                    END RECORD
DEFINE   g_msg          LIKE type_file.chr1000
DEFINE   g_row_count    LIKE type_file.num10
DEFINE   g_curs_index   LIKE type_file.num10
DEFINE   g_jump         LIKE type_file.num10
DEFINE   mi_no_ask      LIKE type_file.num5
DEFINE   l_ac           LIKE type_file.num5
DEFINE   g_aee02        LIKE aee_file.aee02   #No.TQC-C50211
DEFINE   g_comb         ui.ComboBox           #FUN-C80102 add

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("GGL")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time

   LET g_pdate=ARG_VAL(1)
   LET g_towhom=ARG_VAL(2)
   LET g_rlang=ARG_VAL(3)
   LET g_bgjob=ARG_VAL(4)
   LET g_prtway=ARG_VAL(5)
   LET g_copies=ARG_VAL(6)
   LET tm.wc = ARG_VAL(7)
   LET tm.yy = ARG_VAL(8)
   LET tm.m1 = ARG_VAL(9)
   LET tm.m2 = ARG_VAL(10)
   LET tm.o = ARG_VAL(11)
   LET tm.a = ARG_VAL(12)
   LET tm.b = ARG_VAL(13)
   LET tm.g = ARG_VAL(14)     #FUN-C80102  add
   #TQC-930163 --begin
   #LET tm.c = ARG_VAL(14)    #FUN-C80102  mark
   LET tm.f = ARG_VAL(15)     #FUN-C80102  add
   #FUN-C80102--mod--str--
   LET g_rep_user = ARG_VAL(16)
   LET g_rep_clas = ARG_VAL(17)
   LET g_template = ARG_VAL(18)
   LET g_rpt_name = ARG_VAL(19)
   #TQC-930163 --end
   #FUN-C80102--mod--end--

   CALL q701_out_1()

   OPEN WINDOW q701_w AT 5,10
        WITH FORM "ggl/42f/gglq701_1" ATTRIBUTE(STYLE = g_win_style)

   CALL cl_ui_init()

   CALL cl_set_comp_entry('f',FALSE)  #FUN-C80102  add

   IF cl_null(tm.wc) THEN
       CALL gglq701_tm(0,0)
   ELSE
       #TQC-930163 --begin
       CALL gglq701_t() #TQC-930163
       #IF tm.c ='N' THEN    #FUN-C80102  mark
       IF tm.e ='N' THEN     #FUN-C80102  add
          #CALL gglq701()    #FUN-CB0146  mark
          CALL gglq701v()    #FUN-CB0146  add
       ELSE
          #CALL gglq701_1()  #FUN-CB0146  mark
          CALL gglq701v_1()  #FUN-CB0146  add
       END IF
       #TQC-930163 --end
   END IF

   CALL q701_menu()
   DROP TABLE gglq701_tmp;
   CLOSE WINDOW q701_w

   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION q701_menu()
   DEFINE   l_cmd   LIKE type_file.chr1000

   WHILE TRUE
      CALL q701_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL gglq701_tm(0,0)
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL q701_out_2()
            END IF
         WHEN "drill_detail"
            IF cl_chk_act_auth() THEN
               CALL q701_drill_detail()
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
               (ui.Interface.getRootNode(),base.TypeInfo.create(g_aed),'','')
            END IF
         WHEN "related_document"
            IF cl_chk_act_auth() THEN
               IF g_aed01 IS NOT NULL THEN
                  LET g_doc.column1 = "aed01"
                  LET g_doc.value1 = g_aed01
                  CALL cl_doc()
               END IF
            END IF
      END CASE
   END WHILE
END FUNCTION

FUNCTION gglq701_tm(p_row,p_col)
DEFINE lc_qbe_sn         LIKE gbm_file.gbm01
   DEFINE p_row,p_col    LIKE type_file.num5,
          l_n            LIKE type_file.num5,
          l_flag         LIKE type_file.num5,
          l_cmd          LIKE type_file.chr1000
   DEFINE li_chk_bookno  LIKE type_file.num5

   CLEAR FORM #清除畫面   #FUN-C80102  add
   CALL g_aed.clear()   #FUN-C80102  add

   #FUN-C80102--mark--str---
   #LET p_row = 4 LET p_col =25

   #OPEN WINDOW gglq701_w AT p_row,p_col WITH FORM "ggl/42f/gglq701"
   #    ATTRIBUTE (STYLE = g_win_style CLIPPED)

   #CALL cl_ui_locale("gglq701")
   #FUN-C80102--mark--end---

   #FUN-C80102---add----str---
   LET g_comb = ui.ComboBox.forName("a")
   IF g_aaz.aaz88 = '0' THEN
      CALL g_comb.removeItem('1')
      CALL g_comb.removeItem('2')
      CALL g_comb.removeItem('3')
      CALL g_comb.removeItem('4')
   END IF
   IF g_aaz.aaz88 = '3' THEN
      CALL g_comb.removeItem('4')
   END IF
   IF g_aaz.aaz88 = '2' THEN
      CALL g_comb.removeItem('3')
      CALL g_comb.removeItem('4')
   END IF
   IF g_aaz.aaz88 = '1' THEN
      CALL g_comb.removeItem('2')
      CALL g_comb.removeItem('3')
      CALL g_comb.removeItem('4')
   END IF
   IF g_aaz.aaz125 = '5' THEN
      CALL g_comb.removeItem('6')
      CALL g_comb.removeItem('7')
      CALL g_comb.removeItem('8')
   END IF
   IF g_aaz.aaz125 = '6' THEN
      CALL g_comb.removeItem('7')
      CALL g_comb.removeItem('8')
   END IF
   IF g_aaz.aaz125 = '7' THEN
      CALL g_comb.removeItem('8')
   END IF
#FUN-C80102---add----end---

   #TQC-CC0122--add--str--
   IF g_aaz.aaz119 ='N' THEN
      CALL cl_set_comp_visible("aed02_d",FALSE)
   ELSE
      CALL cl_set_comp_visible("aed02_d",TRUE)
   END IF
   #TQC-CC0122--add--end--

   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL
   LET tm.yy = YEAR(g_today)
   LET tm.m1 = MONTH(g_today)
   LET tm.m2 = MONTH(g_today)
   LET tm.o  = g_aza.aza81
   LET tm.a = '1'
   #LET tm.b = 'N'  #FUN-C80102  mark
   LET tm.b = '1'   #FUN-C80102  add
   LET tm.g = 'N'   #FUN-C80102  add
   #LET tm.c = 'N'  #TQC-930163    #FUN-C80102  mark
   LET tm.f = 'N'   #FUN-C80102  add
   #LET tm.d ='N'   #No.FUN-A80034  #FUN-C80102  mark
   LET tm.e ='N'    #FUN-C80102  add
   LET tm.more = 'N'
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies= '1'
   LET tm.i ='N'    #FUN-D40044 add
WHILE TRUE
    #No.FUN-B20010  --Begin
    #FUN-B20055--begin
#    INPUT BY NAME tm.o WITHOUT DEFAULTS
#
#        BEFORE INPUT
#            CALL cl_qbe_display_condition(lc_qbe_sn)
#
#        AFTER FIELD o
#           IF cl_null(tm.o) THEN NEXT FIELD o END IF
#           CALL s_check_bookno(tm.o,g_user,g_plant)
#                RETURNING li_chk_bookno
#           IF (NOT li_chk_bookno) THEN
#                NEXT FIELD o
#           END IF
#           SELECT * FROM aaa_file WHERE aaa01 = tm.o
#           IF SQLCA.sqlcode THEN
#              CALL cl_err3("sel","aaa_file",tm.o,"","aap-229","","",0)
#              NEXT FIELD o
#           END IF
#
#        ON ACTION CONTROLP
#           CASE
#              WHEN INFIELD(o)
#                 CALL cl_init_qry_var()
#                 LET g_qryparam.form = 'q_aaa'
#                 CALL cl_create_qry() RETURNING tm.o
#                 DISPLAY BY NAME tm.o
#                 NEXT FIELD o
#           END CASE
#
#        ON ACTION CONTROLZ
#           CALL cl_show_req_fields()
#
#        ON ACTION CONTROLG
#           CALL cl_cmdask()
#
#        ON IDLE g_idle_seconds
#           CALL cl_on_idle()
#           CONTINUE INPUT
#
#        ON ACTION about
#           CALL cl_about()
#
#        ON ACTION help
#           CALL cl_show_help()
#
#        ON ACTION exit
#           LET INT_FLAG = 1
#           EXIT INPUT
#
#        ON ACTION qbe_save
#           CALL cl_qbe_save()
#
#    END INPUT
#    #No.FUN-B20010  --End
#   CONSTRUCT BY NAME tm.wc ON aag01
#
#       BEFORE CONSTRUCT
#           CALL cl_qbe_init()
#
#       ON ACTION CONTROLP
#          CASE
#             WHEN INFIELD(aag01)
#                CALL cl_init_qry_var()
#                LET g_qryparam.form = 'q_aag'
#                LET g_qryparam.state= 'c'
#                LET g_qryparam.where = " aag00 = '",tm.o CLIPPED,"'"   #FUN-B20010 add
#                CALL cl_create_qry() RETURNING g_qryparam.multiret
#                DISPLAY g_qryparam.multiret TO aag01
#                NEXT FIELD aag01
#          END CASE
#
#       ON ACTION locale
#          CALL cl_show_fld_cont()
#          LET g_action_choice = "locale"
#          EXIT CONSTRUCT
#
#       ON IDLE g_idle_seconds
#          CALL cl_on_idle()
#          CONTINUE CONSTRUCT
#
#       ON ACTION about
#          CALL cl_about()
#
#       ON ACTION help
#          CALL cl_show_help()
#
#       ON ACTION controlg
#          CALL cl_cmdask()
#
#       ON ACTION exit
#          LET INT_FLAG = 1
#          EXIT CONSTRUCT
#
#       ON ACTION qbe_select
#          CALL cl_qbe_select()
#
#    END CONSTRUCT
#    LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('aaguser', 'aaggrup') #FUN-980030
#    IF g_action_choice = "locale" THEN
#       LET g_action_choice = ""
#       CALL cl_dynamic_locale()
#       CONTINUE WHILE
#    END IF
#
#    IF INT_FLAG THEN
##No.FUN-A40009 --begin
##      LET INT_FLAG = 0 CLOSE WINDOW gglq701_w
##      CALL cl_used(g_prog,g_time,2) RETURNING g_time
##      EXIT PROGRAM
##   END IF
#    ELSE
##No.FUN-A40009 --end
#    IF tm.wc = ' 1=1' THEN
#       CALL cl_err('','9046',0) CONTINUE WHILE
#    END IF
#    #INPUT BY NAME tm.yy,tm.m1,tm.m2,tm.o,tm.a,tm.b,tm.c,tm.d,tm.more #TQC-970049   #No.FUN-A80034 #FUN-B20010 mark
#    INPUT BY NAME tm.yy,tm.m1,tm.m2,tm.a,tm.b,tm.c,tm.d,tm.more #FUN-B20010 去掉tm.o
#          WITHOUT DEFAULTS
#
#        BEFORE INPUT
#            CALL cl_qbe_display_condition(lc_qbe_sn)
#
#        AFTER FIELD yy
#           IF cl_null(tm.yy) THEN NEXT FIELD yy END IF
#
#        AFTER FIELD m1
#           IF cl_null(tm.m1) OR tm.m1 > 13 OR tm.m1 < 1 THEN
#              NEXT FIELD m1
#           END IF
#
#        AFTER FIELD m2
#           IF cl_null(tm.m2) OR tm.m2 > 13 OR tm.m2 < 1 OR tm.m2 < tm.m1 THEN
#              NEXT FIELD m2
#           END IF
#
#        AFTER FIELD a
#           IF tm.a NOT MATCHES "[123456789]" AND tm.a <> "10" AND tm.a <> "11" THEN
#              NEXT FIELD a
#           END IF
#
##No.FUN-A80034 --begin
#        BEFORE FIELD c
#           CALL cl_set_comp_entry('d',TRUE)
#        AFTER FIELD c
#           IF tm.d NOT MATCHES "[YyNn]"  THEN
#              NEXT FIELD d
#           END IF
#           IF tm.c ='N' THEN
#              LET tm.d ='N'
#              CALL cl_set_comp_entry('d',FALSE)
#           END IF
#
#        AFTER FIELD d
#           IF tm.d NOT MATCHES "[YyNn]"  THEN
#              NEXT FIELD d
#           END IF
#           IF tm.c ='N' THEN LET tm.d ='N' END IF
##No.FUN-A80034 --end
#       #No.FUN-B20010  --Begin
#       #AFTER FIELD o
#       #   IF cl_null(tm.o) THEN NEXT FIELD o END IF
#       #   CALL s_check_bookno(tm.o,g_user,g_plant)
#       #        RETURNING li_chk_bookno
#       #   IF (NOT li_chk_bookno) THEN
#       #        NEXT FIELD o
#       #   END IF
#       #   SELECT * FROM aaa_file WHERE aaa01 = tm.o
#       #   IF SQLCA.sqlcode THEN
#       #      CALL cl_err3("sel","aaa_file",tm.o,"","aap-229","","",0)
#       #      NEXT FIELD o
#       #   END IF
#       #No.FUN-B20010  --End
#
#        AFTER FIELD more
#           IF tm.more = 'Y'
#              THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
#                                  g_bgjob,g_time,g_prtway,g_copies)
#                        RETURNING g_pdate,g_towhom,g_rlang,
#                                  g_bgjob,g_time,g_prtway,g_copies
#           END IF
#
#        ON ACTION CONTROLZ
#           CALL cl_show_req_fields()
#
#        ON ACTION CONTROLG
#           CALL cl_cmdask()
#
#        ON IDLE g_idle_seconds
#           CALL cl_on_idle()
#           CONTINUE INPUT
#
#        ON ACTION about
#           CALL cl_about()
#
#        ON ACTION help
#           CALL cl_show_help()
#
#        ON ACTION exit
#           LET INT_FLAG = 1
#           EXIT INPUT
#
#        ON ACTION qbe_save
#           CALL cl_qbe_save()
#
#    END INPUT
     #FUN-C80102--mark--str---
     #DIALOG ATTRIBUTES(UNBUFFERED)

     #INPUT BY NAME tm.o ATTRIBUTE(WITHOUT DEFAULTS=TRUE)

     #   BEFORE INPUT
     #       CALL cl_qbe_display_condition(lc_qbe_sn)

     #   AFTER FIELD o
     #      IF cl_null(tm.o) THEN NEXT FIELD o END IF
     #      CALL s_check_bookno(tm.o,g_user,g_plant)
     #           RETURNING li_chk_bookno
     #      IF (NOT li_chk_bookno) THEN
     #           NEXT FIELD o
     #      END IF
     #      SELECT * FROM aaa_file WHERE aaa01 = tm.o
     #      IF SQLCA.sqlcode THEN
     #         CALL cl_err3("sel","aaa_file",tm.o,"","aap-229","","",0)
     #         NEXT FIELD o
     #      END IF

     #END INPUT

    #CONSTRUCT BY NAME tm.wc ON aag01

    #   BEFORE CONSTRUCT
    #       CALL cl_qbe_init()

    #END CONSTRUCT
    #FUN-C80102--mark--end---

    #INPUT BY NAME tm.yy,tm.m1,tm.m2,tm.a,tm.b,tm.c,tm.d,tm.more    #FUN-C80102  mark
    DIALOG ATTRIBUTES(UNBUFFERED)  #FUN-C80102  add
    INPUT BY NAME tm.o,tm.yy,tm.m1,tm.m2,tm.a,tm.b,tm.g,tm.e,tm.f,tm.i        #FUN-C80102  add  #FUN-D40044 tm.i
          ATTRIBUTE(WITHOUT DEFAULTS=TRUE)

        BEFORE INPUT
            CALL cl_qbe_display_condition(lc_qbe_sn)

        #FUN-C80102--add--str---
        AFTER FIELD o
           IF cl_null(tm.o) THEN NEXT FIELD o END IF
           CALL s_check_bookno(tm.o,g_user,g_plant)
                RETURNING li_chk_bookno
           IF (NOT li_chk_bookno) THEN
                NEXT FIELD o
           END IF
           SELECT * FROM aaa_file WHERE aaa01 = tm.o
           IF SQLCA.sqlcode THEN
              CALL cl_err3("sel","aaa_file",tm.o,"","aap-229","","",0)
              NEXT FIELD o
           END IF
        #FUN-C80102--add--end---

        AFTER FIELD yy
           IF cl_null(tm.yy) THEN NEXT FIELD yy END IF

        AFTER FIELD m1
           IF cl_null(tm.m1) OR tm.m1 > 13 OR tm.m1 < 1 THEN
              NEXT FIELD m1
           END IF

        AFTER FIELD m2
           IF cl_null(tm.m2) OR tm.m2 > 13 OR tm.m2 < 1 OR tm.m2 < tm.m1 THEN
              NEXT FIELD m2
           END IF

        AFTER FIELD a
          #IF tm.a NOT MATCHES "[123456789]" AND tm.a <> "10" AND tm.a <> "11" THEN   #MOD-C50145
           IF tm.a NOT MATCHES "[123456789]" AND tm.a <> "10" AND tm.a <> "99" THEN   #MOD-C50145
              NEXT FIELD a
           END IF
        #TQC-DC0064--add--str--
        ON CHANGE b
           IF tm.b='2' THEN
              LET tm.g='N'
              CALL cl_set_comp_visible("g",FALSE)
           ELSE
              CALL cl_set_comp_visible("g",TRUE)
           END IF
        #TQC-DC0064--add--end
        #FUN-C80102--mark--str---
        #BEFORE FIELD c
        #   CALL cl_set_comp_entry('d',TRUE)
        #AFTER FIELD c
        #   IF tm.d NOT MATCHES "[YyNn]"  THEN
        #      NEXT FIELD d
        #   END IF
        #   IF tm.c ='N' THEN
        #      LET tm.d ='N'
        #      CALL cl_set_comp_entry('d',FALSE)
        #   END IF
        #FUN-C80102--mark--end---

        #FUN-C80102--add--str---
        ON CHANGE g
           IF tm.g NOT MATCHES "[YyNn]"  THEN
              NEXT FIELD g
           END IF
        #FUN-C80102--add--end---

        #FUN-C80102--add--str---
        ON CHANGE e
           IF tm.e NOT MATCHES "[YyNn]"  THEN
              NEXT FIELD e
           END IF
           IF tm.e ='N' THEN
              LET tm.f ='N'
              CALL cl_set_comp_entry('f',FALSE)
           END IF
           IF tm.e ='Y' THEN
              CALL cl_set_comp_entry('f',TRUE)
           END IF
        #FUN-C80102--add--end---

        #FUN-C80102--mark--str---
        #AFTER FIELD d
        #   IF tm.d NOT MATCHES "[YyNn]"  THEN
        #      NEXT FIELD d
        #   END IF
        #   IF tm.c ='N' THEN LET tm.d ='N' END IF
        #FUN-C80102--mark--end---

        #FUN-C80102--add--str---
        ON CHANGE f
           IF tm.f NOT MATCHES "[YyNn]"  THEN
              NEXT FIELD f
           END IF
           IF tm.e ='N' THEN LET tm.f ='N' END IF
        #FUN-C80102--add--end---

        #FUN-D40044--add--str---
        ON CHANGE i
           IF tm.i NOT MATCHES "[YyNn]"  THEN
              NEXT FIELD i
           END IF
        #FUN-D40044--add--end---

        #FUN-C80102--mark--str---
        #AFTER FIELD more
        #   IF tm.more = 'Y'
        #      THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
        #                          g_bgjob,g_time,g_prtway,g_copies)
        #                RETURNING g_pdate,g_towhom,g_rlang,
        #                          g_bgjob,g_time,g_prtway,g_copies
        #   END IF
        #FUN-C80102--mark--end---
    #END INPUT    #FUN-C80102 mark

         ON ACTION CONTROLP
            CASE
              WHEN INFIELD(o)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = 'q_aaa'
                 CALL cl_create_qry() RETURNING tm.o
                 DISPLAY BY NAME tm.o
                 NEXT FIELD o
             #FUN-C80102--mark--str---
             #WHEN INFIELD(aag01)
             #   CALL cl_init_qry_var()
             #   LET g_qryparam.form = 'q_aag'
             #   LET g_qryparam.state= 'c'
             #   LET g_qryparam.where = " aag00 = '",tm.o CLIPPED,"'"   #FUN-B20010 add
             #   CALL cl_create_qry() RETURNING g_qryparam.multiret
             #   DISPLAY g_qryparam.multiret TO aag01
             #   NEXT FIELD aag01
             #FUN-C80102--mark--end---
            END CASE

         ON ACTION locale
            CALL cl_show_fld_cont()
            LET g_action_choice = "locale"
            EXIT DIALOG

         ON ACTION CONTROLZ
            CALL cl_show_req_fields()

         ON ACTION CONTROLG
            CALL cl_cmdask()

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG

         ON ACTION about
            CALL cl_about()

         ON ACTION help
            CALL cl_show_help()

         ON ACTION exit
            LET INT_FLAG = 1
            EXIT DIALOG

         ON ACTION accept
            EXIT DIALOG

         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG

    #END DIALOG   #FUN-C80102 mark
    END INPUT     #FUN-C80102 add
    #FUN-C80102--add--str--
    CONSTRUCT tm.wc ON aed01,aed02                    #MOD-E20114 add aed02
                  FROM s_aed[1].aed01,s_aed[1].aed02  #MOD-E20114 add aed02
      BEFORE CONSTRUCT
        CALL cl_qbe_init()

      ON ACTION CONTROLP
       CASE
          WHEN INFIELD(aed01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = 'q_aag'
               LET g_qryparam.state= 'c'
               LET g_qryparam.where = " aag00 = '",tm.o CLIPPED,"'"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO aed01
               NEXT FIELD aed01
          #MOD-E20114---begin
          WHEN INFIELD(aed02)    #查詢異動碼-1
               CALL cl_init_qry_var()
               #LET g_qryparam.form ="q_aee"   #mark by dengsy150909
               LET g_qryparam.form ="cq_aee03"   #add by dengsy150909
               LET g_qryparam.state = "c"
               LET g_qryparam.arg2 = tm.a
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO aed02
          #MOD-E20114---end
       END CASE

      ON ACTION ACCEPT
         EXIT DIALOG

      ON ACTION CANCEL
         LET INT_FLAG=1
         EXIT DIALOG

    END CONSTRUCT
    END DIALOG
    #FUN-C80102--add--end--
    IF INT_FLAG THEN
       LET INT_FLAG = 0 CLOSE WINDOW gglq701_w
       RETURN
    END IF
    LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('aaguser', 'aaggrup') #FUN-980030
    #FUN-C80102--add--str--
    #IF tm.wc = ' 1=1' THEN
    #   CALL cl_err('','9046',0) CONTINUE WHILE
    #END IF
    #FUN-C80102--add--end--
    IF g_action_choice = "locale" THEN
       LET g_action_choice = ""
       CALL cl_dynamic_locale()
       CONTINUE WHILE
    END IF

    #FUN-B20055--end
#No.FUN-A40009 --begin
#   IF INT_FLAG THEN
#      LET INT_FLAG = 0 CLOSE WINDOW gglq701_w
#      CALL cl_used(g_prog,g_time,2) RETURNING g_time
#      EXIT PROGRAM
#   END IF
#No.FUN-A40009 --end
    IF g_bgjob = 'Y' THEN
       SELECT zz08 INTO l_cmd FROM zz_file
              WHERE zz01='gglq701'
       IF SQLCA.sqlcode OR l_cmd IS NULL THEN
          CALL cl_err('gglq701','9031',1)
       ELSE
          LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
          LET l_cmd = l_cmd CLIPPED,
                          " '",g_pdate  CLIPPED,"'",
                          " '",g_towhom CLIPPED,"'",
                          " '",g_rlang CLIPPED,"'",
                          " '",g_bgjob  CLIPPED,"'",
                          " '",g_prtway CLIPPED,"'",
                          " '",g_copies CLIPPED,"'",
                          " '",tm.wc    CLIPPED,"'" ,
                          " '",tm.yy    CLIPPED,"'" ,
                          " '",tm.m1    CLIPPED,"'" ,
                          " '",tm.m2    CLIPPED,"'" ,
                          " '",tm.o     CLIPPED,"'",
                          " '",tm.a     CLIPPED,"'",
                          " '",tm.b     CLIPPED,"'",
                          " '",tm.g     CLIPPED,"'",     #FUN-C80102  add
                          " '",g_rep_user CLIPPED,"'",
                          " '",g_rep_clas CLIPPED,"'",
                          " '",g_template CLIPPED,"'",
                          " '",g_rpt_name CLIPPED,"'"
          CALL cl_cmdat('gglq701',g_time,l_cmd)
       END IF
       CLOSE WINDOW gglq701_w
       CALL cl_used(g_prog,g_time,2) RETURNING g_time
       EXIT PROGRAM
    END IF
    #END IF                  #No.FUN-A40009
    CALL cl_wait()
    #TQC-930163 --begin
    #IF tm.c = 'N' THEN   #FUN-C80102  mark
    IF tm.e = 'N' THEN    #FUN-C80102  add
       #CALL gglq701()    #FUN-CB0146  mark
       CALL gglq701v()    #FUN-CB0146  add
    ELSE
       #CALL gglq701_1()  #FUN-CB0146  mark
       CALL gglq701v_1()  #FUN-CB0146  add
    END IF
    #TQC-930163 --end
    ERROR ""
    EXIT WHILE
END WHILE
   #CLOSE WINDOW gglq701_w   #FUN-C80102  mark
#No.FUN-A40009 --begin
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
#No.FUN-A40009 --end
   CALL gglq701_t() #TQC-930163
   LET g_aed01 = NULL
   LET g_aag02 = NULL
   LET g_aed04 = NULL
   CLEAR FORM
   CALL g_aed.clear()
   CALL gglq701_cs()

END FUNCTION

#TQC-930163 --begin
#FUN-D30014----mark--str--
#FUNCTION gglq701_1()
#  DEFINE l_name             LIKE type_file.chr20,
#         #l_sql              LIKE type_file.chr1000,
#         #l_sql1             LIKE type_file.chr1000,
#         l_sql              STRING,      #NO.FUN-910082
#         l_sql1             STRING,     #NO.FUN-910082
#         l_ted              LIKE type_file.chr1000,
#         l_abb              LIKE type_file.chr1000,
#         l_i                LIKE type_file.num5,
#         qc_ted05           LIKE ted_file.ted05,  #期初
#         qc_ted06           LIKE ted_file.ted06,
#         qj_ted05           LIKE ted_file.ted05,  #期間
#         qj_ted06           LIKE ted_file.ted06,
#         qc_ted10           LIKE ted_file.ted10,  #期初
#         qc_ted11           LIKE ted_file.ted11,
#         qj_ted10           LIKE ted_file.ted10,  #期間
#         qj_ted11           LIKE ted_file.ted11,
#         l_ted05            LIKE ted_file.ted05,
#         l_ted06            LIKE ted_file.ted06,
#         l_ted10            LIKE ted_file.ted10,
#         l_ted11            LIKE ted_file.ted11,
#         l_aed02            LIKE aed_file.aed02,
#         l_ted09            LIKE ted_file.ted09, #TQC-930163
#         l_gaq01            LIKE gaq_file.gaq01,
#         l_aag01_str        LIKE type_file.chr50,
#         l_ahe02_d          LIKE ze_file.ze03,
#No.FUN-8B0106  add start
#         l_cnt                        LIKE type_file.num5,
#         t_bal                        LIKE aed_file.aed05,
#         n_bal                        LIKE aed_file.aed05,
#         n_pb_bal                     LIKE aed_file.aed05,
#         t_balf                       LIKE aed_file.aed05,
#         n_balf                       LIKE aed_file.aed05,
#         n_pb_balf                    LIKE aed_file.aed05,
#         l_abb25_pb                   LIKE abb_file.abb25,
#         l_abb25_d                    LIKE abb_file.abb25,
#         l_abb25_c                    LIKE abb_file.abb25,
#         l_abb25_bal                  LIKE abb_file.abb25,
#         l_pb_dc                      LIKE type_file.chr10,
#         l_dc                         LIKE type_file.chr10,
#No.FUN-8B0106 add end
#         #No.CHI-C70031  --Begin
#         l_aeh11                      LIKE aeh_file.aeh11,
#         l_aeh12                      LIKE aeh_file.aeh12,
#         l_aeh15                      LIKE aeh_file.aeh15,
#         l_aeh16                      LIKE aeh_file.aeh16,
#         l_aaa09                      LIKE aaa_file.aaa09,
#         l_aeh03                      LIKE aeh_file.aeh03,
#         l_aeh04                      LIKE aeh_file.aeh04,
#         l_aeh05                      LIKE aeh_file.aeh05,
#         l_aeh06                      LIKE aeh_file.aeh06,
#         l_aeh07                      LIKE aeh_file.aeh07,
#         l_aeh31                      LIKE aeh_file.aeh31,
#         l_aeh32                      LIKE aeh_file.aeh32,
#         l_aeh33                      LIKE aeh_file.aeh33,
#         l_aeh34                      LIKE aeh_file.aeh34,
#         l_aeh35                      LIKE aeh_file.aeh35,
#         l_aeh36                      LIKE aeh_file.aeh36,
#         l_aeh37                      LIKE aeh_file.aeh37,
#         #No.CHI-C70031  --End
#         sr1                RECORD
#                            aag01    LIKE aag_file.aag01,
#                            aag02    LIKE aag_file.aag02
#                            END RECORD,
#         sr                 RECORD
#                            aed01    LIKE aed_file.aed01,
#                            aag02    LIKE aag_file.aag02,
#                            aed04    LIKE aed_file.aed04,
#                            aed02    LIKE aed_file.aed02,
#                            ahe02_d  LIKE ze_file.ze03,
#                            ted05    LIKE ted_file.ted05,
#                            ted06    LIKE ted_file.ted06,
#                            qcye     LIKE ted_file.ted05,
#                            ted09    LIKE ted_file.ted09,
#                            ted10    LIKE ted_file.ted10,
#                            ted11    LIKE ted_file.ted11,
#                            qcyef    LIKE ted_file.ted05
#                            END RECORD,
#         l_field            LIKE     gaq_file.gaq01
#
#    CASE tm.a
#         WHEN '1'   LET l_field = 'abb11'
#                    LET l_gaq01 = 'aag15'
#                    LET g_aee02 ='1'        #No.TQC-C50211
#         WHEN '2'   LET l_field = 'abb12'
#                    LET l_gaq01 = 'aag16'
#                    LET g_aee02 ='2'        #No.TQC-C50211
#         WHEN '3'   LET l_field = 'abb13'
#                    LET l_gaq01 = 'aag17'
#                    LET g_aee02 ='3'        #No.TQC-C50211
#         WHEN '4'   LET l_field = 'abb14'
#                    LET l_gaq01 = 'aag18'
#                    LET g_aee02 ='4'        #No.TQC-C50211
#         WHEN '5'   LET l_field = 'abb31'
#                    LET l_gaq01 = 'aag31'
#                    LET g_aee02 ='5'        #No.TQC-C50211
#         WHEN '6'   LET l_field = 'abb32'
#                    LET l_gaq01 = 'aag32'
#                    LET g_aee02 ='6'        #No.TQC-C50211
#         WHEN '7'   LET l_field = 'abb33'
#                    LET l_gaq01 = 'aag33'
#                    LET g_aee02 ='7'        #No.TQC-C50211
#         WHEN '8'   LET l_field = 'abb34'
#                    LET l_gaq01 = 'aag34'
#                    LET g_aee02 ='8'        #No.TQC-C50211
#         WHEN '9'   LET l_field = 'abb35'
#                    LET l_gaq01 = 'aag35'
#                    LET g_aee02 ='9'        #No.TQC-C50211
#         WHEN '10'  LET l_field = 'abb36'
#                    LET l_gaq01 = 'aag36'
#                    LET g_aee02 ='10'       #No.TQC-C50211
#         #WHEN '11'  LET l_field = 'abb37'   #MOD-C50145 mark
#         WHEN '99'  LET l_field = 'abb37'    #MOD-C50145
#                    LET l_gaq01 = 'aag37'
#                    LET g_aee02 ='99'       #No.TQC-C50211
#    END CASE
#    #FUN-C80102--mark--str--
#    #IF tm.b = 'N' THEN
#    #   LET l_field = NULL
#    #END IF
#    #FUN-C80102--mark--end--
#    CALL gglq701_table()
#    SELECT zo02 INTO g_company FROM zo_file
#     WHERE zo01 = g_rlang
#
#    #科目
#    LET tm.wc = cl_replace_str(tm.wc,"aed01","aag01")      #FUN-C80102 add
#    LET l_sql = " SELECT aag01,aag02 FROM aag_file ",
#                "  WHERE aag00 = '",tm.o,"'",
#                "    AND ",tm.wc CLIPPED
#    PREPARE gglq701_pr11 FROM l_sql
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_aag01_cs1 CURSOR FOR gglq701_pr11
#
#    #核算項
#    LET l_sql1 = "SELECT UNIQUE ted02,ted09 FROM ted_file ",
#                 " WHERE ted00 = '",tm.o,"'",
#                 "   AND ted01 LIKE ? ",           #科目
#                 "   AND ted011 = '",tm.a,"'"
#    #FUN-C80102--mark--str--
#    #FUN-C80102--add--str--
#    #IF tm.g = 'Y' THEN
#    #   LET l_sql1 = l_sql1 CLIPPED,
#    #                   " UNION ",
#    #                   " SELECT ",l_field CLIPPED,",abb24 FROM aba_file,abb_file",
#    #                   "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                   "    AND aba00 = '",tm.o,"'",
#    #                   "    AND abb03 LIKE ? ",       #科目
#    #                   "    AND ",l_field CLIPPED," IS NOT NULL",
#    #                   "    AND abb24 IS NOT NULL "
#    #END IF
#    #FUN-C80102--add--end--
#    #IF tm.g = 'N' THEN    #FUN-C80102  add
#    ##IF tm.b = 'Y' THEN   #FUN-C80102  mark
#    #   IF tm.b = '1' THEN    #FUN-C80102  add
#    #      LET l_sql1 = l_sql1 CLIPPED,
#    #                   " UNION ",
#    #                   " SELECT ",l_field CLIPPED,",abb24 FROM aba_file,abb_file",
#    #                   "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                   "    AND aba00 = '",tm.o,"'",
#    #                   "    AND abb03 LIKE ? ",       #科目
#    #                   "    AND ",l_field CLIPPED," IS NOT NULL",
#    #                   "    AND abb24 IS NOT NULL ",
#    #                   #"    AND aba19 = 'Y'   AND abapost = 'N'"   #FUN-C80102  mark
#    #                   "    AND aba19 = 'Y'  "   #FUN-C80102  add
#    #   #FUN-C80102--add--str--
#    #   ELSE
#    #      LET l_sql1 = l_sql1 CLIPPED,
#    #                   " UNION ",
#    #                   " SELECT ",l_field CLIPPED,",abb24 FROM aba_file,abb_file",
#    #                   "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                   "    AND aba00 = '",tm.o,"'",
#    #                   "    AND abb03 LIKE ? ",       #科目
#    #                   "    AND ",l_field CLIPPED," IS NOT NULL",
#    #                   "    AND abb24 IS NOT NULL ",
#    #                   "    AND aba19 = 'Y'   AND abapost = 'Y'"
#    #   END IF
#    #   #FUN-C80102--add--end--
#    #END IF
#    #FUN-C80102--mark--end--

#    #FUN-C80102--add--str--
#    LET l_sql1 = l_sql1 CLIPPED,
#                       " UNION ",
#                       " SELECT ",l_field CLIPPED,",abb24 FROM aba_file,abb_file",
#                       "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#                       "    AND aba00 = '",tm.o,"'",
#                       "    AND abb03 LIKE ? ",       #科目
#                       "    AND ",l_field CLIPPED," IS NOT NULL",
#                       "    AND abb24 IS NOT NULL "
#    IF tm.g ='Y' THEN
#       IF tm.b = '1' THEN
#          LET l_sql1 = l_sql1,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
#       ELSE
#          LET l_sql1 = l_sql1,"  AND aba19 = 'N'"
#       END IF
#    END IF
#    IF tm.g ='N' THEN
#       IF tm.b = '1' THEN
#          LET l_sql1 = l_sql1," AND (aba19 ='Y' and abapost = 'N') "
#       ELSE
#          LET l_sql1 = l_sql1," AND  aba19 = 1 "
#       END IF
#    END IF
#    #FUN-C80102--add--end--
#
#    PREPARE gglq701_ted02_p FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_ted02_cs CURSOR FOR gglq701_ted02_p
#
#    #共用條件
#    LET l_ted = "SELECT SUM(ted05),SUM(ted06),SUM(ted10),SUM(ted11) FROM ted_file",
#                " WHERE ted00 = '",tm.o,"'",
#                "   AND ted01 LIKE ? ",                #科目
#                "   AND ted02 = ? ",                   #核算項
#                "   AND ted09 = ? ",
#                "   AND ted011 = '",tm.a,"'",
#                "   AND ted03 = ",tm.yy
#    #FUN-C80102--mark--str--
#    #FUN-C80102--add--str--
#    #IF tm.g = 'Y' THEN
#    #   LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                  "    AND aba00 = '",tm.o,"'",
#    #                  "    AND abb03 LIKE ?   ",             #科目
#    #                  "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #                  "    AND aba03 = ",tm.yy,
#    #                  "    AND abb24 = ?   "
#    #END IF
#    #FUN-C80102--add--end--
#    #IF tm.g = 'N' THEN   #FUN-C80102  add
#    #   IF tm.b = '1' THEN    #FUN-C80102  add
#    #      LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                  "    AND aba00 = '",tm.o,"'",
#    #                  "    AND abb03 LIKE ?   ",             #科目
#    #                  "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #                  "    AND aba03 = ",tm.yy,
#    #                  "    AND abb24 = ?   ",
#    #                  #"    AND aba19 = 'Y'   AND abapost = 'N'"  #未過帳      #FUN-C80102  mark
#    #                  "    AND aba19 = 'Y'   "     #FUN-C80102  add
#    ##FUN-C80102--add--str--
#    #   ELSE
#    #      LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                  "    AND aba00 = '",tm.o,"'",
#    #                  "    AND abb03 LIKE ?   ",             #科目
#    #                  "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #                  "    AND aba03 = ",tm.yy,
#    #                  "    AND abb24 = ?   ",
#    #                  "    AND aba19 = 'Y'   AND abapost = 'N'"  #未過帳
#    #   END IF
#    # END IF
#    #FUN-C80102--add--end--
#    #FUN-C80102--mark--end--

#    #FUN-C80102--add--str--
#    LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#                      "    AND aba00 = '",tm.o,"'",
#                      "    AND abb03 LIKE ?   ",             #科目
#                      "    AND ",l_field CLIPPED," = ? ",    #核算項值
#                      "    AND aba03 = ",tm.yy,
#                      "    AND abb24 = ?   "
#
#    IF tm.g ='Y' THEN
#       IF tm.b = '1' THEN
#          LET l_abb = l_abb,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
#       ELSE
#          LET l_abb = l_abb,"  AND aba19 = 'N'"
#       END IF
#    END IF
#    IF tm.g ='N' THEN
#       IF tm.b = '1' THEN
#          LET l_abb = l_abb," AND (aba19 ='Y' and abapost = 'N') "
#       ELSE
#          LET l_abb = l_abb," AND  aba19 = 1 "
#       END IF
#    END IF
#    #FUN-C80102--add--end--
#
#    #TQC-930163 --end
#
#    #當期異動
#    LET l_sql1 = l_ted CLIPPED, "   AND ted04 = ? "   #當期
#    #IF tm.b = 'Y' THEN   #FUN-C80102  mark
#       LET l_sql1 = l_sql1 CLIPPED,
#                    #" UNION ",       #MOD-C50182 mark
#                    " UNION ALL",     #MOD-C50182
#                    #未過帳 - 借
#                    " SELECT SUM(abb07),0,SUM(abb07f),0 FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '1' ",
#                    "    AND aba04 = ?   ",              #當期未過帳資料
#                    #" UNION ",       #MOD-C50182 mark
#                    " UNION ALL",     #MOD-C50182
#                    #未過帳 - 貸
#                    " SELECT 0,SUM(abb07),0,SUM(abb07f) FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '2' ",
#                    "    AND aba04 = ?   "               #當期未過帳資料
#    #END IF              #FUN-C80102  mark
#    PREPARE gglq701_qj_p1 FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_qj_cs1 CURSOR FOR gglq701_qj_p1
#
#    #期初余額
#    LET l_sql1 = l_ted CLIPPED, "   AND ted04 < ? "  #期初
#    #IF tm.b = 'Y' THEN   #FUN-C80102  mark
#       LET l_sql1 = l_sql1 CLIPPED,
#                    #" UNION ",       #MOD-C50182 mark
#                    " UNION ALL",     #MOD-C50182
#                    #未過帳 - 借
#                    " SELECT SUM(abb07),0,SUM(abb07f),0 FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '1' ",
#                    "    AND aba04 < ?   ",              #期初未過帳資料
#                    #" UNION ",       #MOD-C50182 mark
#                    " UNION ALL",     #MOD-C50182
#                    #未過帳 - 貸
#                    " SELECT 0,SUM(abb07),0,SUM(abb07f) FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '2' ",
#                    "    AND aba04 < ?   "               #期初未過帳資料
#    #END IF   #FUN-C80102  mark
#    PREPARE gglq701_qc_p1 FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_qc_cs1 CURSOR FOR gglq701_qc_p1
#    #TQC-930163 --begin
#   # #查找核算項值
#   # LET l_sql1 = " SELECT ",l_gaq01 CLIPPED," FROM aag_file ",
#   #              "  WHERE aag00 = '",tm.o,"'",
#   #              "    AND aag01 LIKE ? ",
#   #              "    AND aag07 IN ('2','3') ",
#   #              "    AND ",l_gaq01 CLIPPED," IS NOT NULL"
#   # PREPARE gglq701_gaq01_p1 FROM l_sql1
#   # IF SQLCA.sqlcode != 0 THEN
#   #    CALL cl_err('prepare:',SQLCA.sqlcode,1)
#   #    CALL cl_used(g_prog,g_time,2) RETURNING g_time
#   #    EXIT PROGRAM
#   # END IF
#   # DECLARE gglq701_gaq01_cs SCROLL CURSOR FOR gglq701_gaq01_p1  #只能取第一個
#    #TQC-930163 --end
#
#     LET g_pageno  = 0                                    #No.FUN-8B0106  mark
#     CALL cl_outnam('gglq701') RETURNING l_name           #No.FUN-8B0106  mark
#     START REPORT gglq701_rep1 TO l_name                  #No.FUN-8B0106  mark
#
#    #No.CHI-C70031  --Begin
#     LET  l_aeh04  =  NULL
#     LET  l_aeh05  =  NULL
#     LET  l_aeh06  =  NULL
#     LET  l_aeh07  =  NULL
#     LET  l_aeh31  =  NULL
#     LET  l_aeh32  =  NULL
#     LET  l_aeh33  =  NULL
#     LET  l_aeh34  =  NULL
#     LET  l_aeh35  =  NULL
#     LET  l_aeh36  =  NULL
#     LET  l_aeh37  =  NULL
#     #No.CHI-C70031  --End
#    FOREACH gglq701_aag01_cs1 INTO sr1.*  #科目
#      IF SQLCA.sqlcode THEN
#         CALL cl_err('gglq701_aag01_cs1 foreach:',SQLCA.sqlcode,0) EXIT FOREACH
#      END IF
#
#      #此作業也要打印統治科目的金額，但是aed/abb中都存放得是明細或是獨立科目
#      #所以要用LIKE的方式，取出統治科目對應的明細科目的金額
#      #此作業的前提，明細科目的前幾碼一定和其上屬統治相同 ruled by 蔡曉峰
#      IF cl_null(sr1.aag01) THEN CONTINUE FOREACH END IF
#      LET l_aag01_str = sr1.aag01 CLIPPED,'\%'    #No.MOD-940388

#      #FUN-C80102--mark--str--
#      #IF tm.b = 'N' THEN
#      #   FOREACH gglq701_ted02_cs USING l_aag01_str
#      #                            INTO l_aed02,l_ted09
#      #     IF SQLCA.sqlcode THEN
#      #        CALL cl_err('gglq701_ted02_cs foreach:',SQLCA.sqlcode,0)
#      #        EXIT FOREACH
#      #     END IF
#
#      #     FOR l_i = tm.m1 TO tm.m2
#      #         LET qc_ted05 = 0  #期初
#      #         LET qc_ted06 = 0
#      #         LET qj_ted05 = 0  #期間
#      #         LET qj_ted06 = 0
#      #         LET qc_ted10 = 0  #期初
#      #         LET qc_ted11 = 0
#      #         LET qj_ted10 = 0  #期間
#      #         LET qj_ted11 = 0
#      #         FOREACH gglq701_qc_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i
#      #                                INTO l_ted05,l_ted06,l_ted10,l_ted11
#      #           IF SQLCA.sqlcode THEN
#      #              CALL cl_err('gglq701_ted02_cs foreach:',SQLCA.sqlcode,0)
#      #              EXIT FOREACH
#      #           END IF
#      #           IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
#      #           IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
#      #           IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
#      #           IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
#      #           LET qc_ted05 = qc_ted05 + l_ted05
#      #           LET qc_ted06 = qc_ted06 + l_ted06
#      #           LET qc_ted10 = qc_ted10 + l_ted10
#      #           LET qc_ted11 = qc_ted11 + l_ted11
#      #         END FOREACH
#      #         #No.CHI-C70031  --Begin
#      #         SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#      #         LET l_aeh11 = 0
#      #         LET l_aeh12 = 0
#      #         LET l_aeh15 = 0
#      #         LET l_aeh16 = 0
#      #         CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#      #         l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#      #         0,       l_i-1,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
#      #         l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#      #         RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#      #         #No.CHI-C70031  --End
#      #         LET qc_ted05 = qc_ted05 - l_aeh11     #CHI-C70031
#      #         LET qc_ted06 = qc_ted06 - l_aeh12     #CHI-C70031
#      #         LET qc_ted10 = qc_ted10 - l_aeh15     #CHI-C70031
#      #         LET qc_ted11 = qc_ted11 - l_aeh16     #CHI-C70031
#      #         LET g_print = 'N'
#      #         FOREACH gglq701_qj_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i
#      #                                INTO l_ted05,l_ted06,l_ted10,l_ted11
#      #           IF SQLCA.sqlcode THEN
#      #              CALL cl_err('foreach:',SQLCA.sqlcode,0)
#      #              EXIT FOREACH
#      #           END IF
#      #           IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
#      #           IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
#      #           IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
#      #           IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
#      #           LET qj_ted05 = qj_ted05 + l_ted05
#      #           LET qj_ted06 = qj_ted06 + l_ted06
#      #           LET qj_ted10 = qj_ted10 + l_ted10
#      #           LET qj_ted11 = qj_ted11 + l_ted11
#      #           LET g_print = 'Y'
#      #         END FOREACH
#      #         #No.CHI-C70031  --Begin
#      #         SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#      #         LET l_aeh11 = 0
#      #         LET l_aeh12 = 0
#      #         LET l_aeh15 = 0
#      #         LET l_aeh16 = 0
#      #         CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#      #         l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#      #         l_i,       l_i,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
#      #         l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#      #         RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#      #         LET qj_ted05 = qj_ted05 - l_aeh11
#      #         LET qj_ted06 = qj_ted06 - l_aeh12
#      #         LET qj_ted10 = qj_ted10 - l_aeh15
#      #         LET qj_ted11 = qj_ted11 - l_aeh16
#      #         #No.CHI-C70031  --End
#      #         #無期初也沒有本期異動，則不打印
#      #         IF qc_ted05 = 0 AND qc_ted06 = 0 AND
#      #            qj_ted05 = 0 AND qj_ted06 = 0 THEN
#      #            CONTINUE FOR
#      #         END IF
#      #
#      #         #取核算項名稱
#      #         CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163
#      #              RETURNING l_ahe02_d
#      #         INITIALIZE sr.* TO NULL
#      #         LET sr.aed01  = sr1.aag01
#      #         LET sr.aag02  = sr1.aag02
#      #         LET sr.aed04  = l_i
#      #         LET sr.aed02  = l_aed02
#      #         LET sr.ahe02_d  = l_ahe02_d
#      #         LET sr.ted09 = l_ted09
#      #         LET sr.ted05 = qj_ted05
#      #         LET sr.ted06 = qj_ted06
#      #         LET sr.qcye  = qc_ted05 - qc_ted06
#      #         LET sr.ted10 = qj_ted10
#      #         LET sr.ted11 = qj_ted11
#      #         LET sr.qcyef = qc_ted10 - qc_ted11
#      #       #  OUTPUT TO REPORT gglq701_rep1(sr.*)       #No.FUN-8B0106  mark
#
#No.FUN-8B0106  add start
#      #  IF cl_null(sr.ted05) THEN LET sr.ted05 = 0 END IF
#      #  IF cl_null(sr.ted06) THEN LET sr.ted06 = 0 END IF
#      #  IF cl_null(sr.ted10) THEN LET sr.ted10 = 0 END IF
#      #  IF cl_null(sr.ted11) THEN LET sr.ted11 = 0 END IF
#      #  LET t_bal   = sr.ted05 - sr.ted06 + sr.qcye
#      #  LET t_balf  = sr.ted10 - sr.ted11 + sr.qcyef
#
#      #  IF sr.qcye > 0 THEN
#      #     LET n_pb_bal = sr.qcye
#      #     LET n_pb_balf= sr.qcyef
#      #     CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#      #  ELSE
#      #     IF sr.qcye = 0 THEN
#      #        LET n_pb_bal = sr.qcye
#      #        LET n_pb_balf= sr.qcyef
#      #        CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#      #     ELSE
#      #        LET n_pb_bal = sr.qcye * -1
#      #        LET n_pb_balf= sr.qcyef* -1
#      #        CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#      #     END IF
#      #  END IF
#      #  #-MOD-A90110-add-
#      #   SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07
#      #     FROM azi_file
#      #    WHERE azi01 = sr.ted09
#      #  #-MOD-A90110-end-
#      #  IF t_bal > 0 THEN
#      #     LET n_bal = t_bal
#      #     LET n_balf= t_balf
#      #     CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#      #  ELSE
#      #     IF t_bal = 0 THEN
#      #        LET n_bal = t_bal
#      #        LET n_balf= t_balf
#      #        CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#      #     ELSE
#      #        LET n_bal = t_bal * -1
#      #        LET n_balf= t_balf* -1
#      #        CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#      #     END IF
#      #  END IF
#      #  LET l_abb25_pb = n_pb_bal / n_pb_balf
#      #  LET l_abb25_d  = sr.ted05 / sr.ted10
#      #  LET l_abb25_c  = sr.ted06 / sr.ted11
#      #  LET l_abb25_bal = n_bal / n_balf
#
#      # INSERT INTO gglq701_tmp
#      #  VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,sr.ted09,'2',
#      #         l_pb_dc,n_pb_balf,l_abb25_pb,n_pb_bal,'',sr.ted10,l_abb25_d,
#      #         sr.ted05,sr.ted11,l_abb25_c,sr.ted06,l_dc,n_balf,l_abb25_bal,
#      #         n_bal,t_azi04,t_azi05,t_azi07)   #MOD-A90110 add azi04,azi05,azi07
#No.FUN-8B0106 add end
#      #      END FOR
#      #   END FOREACH
#      #ELSE
#      #FUN-C80102--mark--str--
#         FOREACH gglq701_ted02_cs USING l_aag01_str,l_aag01_str
#                                  INTO l_aed02,l_ted09
#           IF SQLCA.sqlcode THEN
#              CALL cl_err('gglq701_ted02_cs foreach:',SQLCA.sqlcode,0)
#              EXIT FOREACH
#           END IF
#
#           FOR l_i = tm.m1 TO tm.m2
#               LET qc_ted05 = 0  #期初
#               LET qc_ted06 = 0
#               LET qj_ted05 = 0  #期間
#               LET qj_ted06 = 0
#               LET qc_ted10 = 0  #期初
#               LET qc_ted11 = 0
#               LET qj_ted10 = 0  #期間
#               LET qj_ted11 = 0
#               FOREACH gglq701_qc_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i,
#                                            l_aag01_str,l_aed02,l_ted09,l_i,
#                                            l_aag01_str,l_aed02,l_ted09,l_i
#                                      INTO l_ted05,l_ted06,l_ted10,l_ted11
#                 IF SQLCA.sqlcode THEN
#                    CALL cl_err('gglq701_ted02_cs foreach:',SQLCA.sqlcode,0)
#                    EXIT FOREACH
#                 END IF
#                 IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
#                 IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
#                 IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
#                 IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
#                 LET qc_ted05 = qc_ted05 + l_ted05
#                 LET qc_ted06 = qc_ted06 + l_ted06
#                 LET qc_ted10 = qc_ted10 + l_ted10
#                 LET qc_ted11 = qc_ted11 + l_ted11
#               END FOREACH
#               #No.CHI-C70031  --Begin
#               SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#               LET l_aeh11 = 0
#               LET l_aeh12 = 0
#               LET l_aeh15 = 0
#               LET l_aeh16 = 0
#               CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#               l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#               0,       l_i-1,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
#               l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#               RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#               LET qc_ted05 = qc_ted05 - l_aeh11
#               LET qc_ted06 = qc_ted06 - l_aeh12
#               LET qc_ted10 = qc_ted10 - l_aeh15
#               LET qc_ted11 = qc_ted11 - l_aeh16
#               #No.CHI-C70031  --End
#               LET g_print = 'N'
#               FOREACH gglq701_qj_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i,
#                                           l_aag01_str,l_aed02,l_ted09,l_i,
#                                           l_aag01_str,l_aed02,l_ted09,l_i
#                                     INTO l_ted05,l_ted06,l_ted10,l_ted11
#                 IF SQLCA.sqlcode THEN
#                    CALL cl_err('foreach:',SQLCA.sqlcode,0)
#                    EXIT FOREACH
#                 END IF
#                 IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
#                 IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
#                 IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
#                 IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
#                 LET qj_ted05 = qj_ted05 + l_ted05
#                 LET qj_ted06 = qj_ted06 + l_ted06
#                 LET qj_ted10 = qj_ted10 + l_ted10
#                 LET qj_ted11 = qj_ted11 + l_ted11
#                 LET g_print = 'Y'
#               END FOREACH
#               #No.CHI-C70031  --Begin
#               SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#               LET l_aeh11 = 0
#               LET l_aeh12 = 0
#               LET l_aeh15 = 0
#               LET l_aeh16 = 0
#               CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#               l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#               l_i,       l_i,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
#               l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#               RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#               LET qj_ted05 = qj_ted05 + l_ted05 - l_aeh11
#               LET qj_ted06 = qj_ted06 + l_ted06 - l_aeh12
#               LET qj_ted10 = qj_ted10 + l_ted10 - l_aeh15
#               LET qj_ted11 = qj_ted11 + l_ted11 - l_aeh16
#               #No.CHI-C70031  --End
#               #無期初也沒有本期異動，則不打印
#               IF qc_ted05 = 0 AND qc_ted06 = 0 AND
#                  qj_ted05 = 0 AND qj_ted06 = 0 THEN
#                  CONTINUE FOR
#               END IF
#
#               #取核算項名稱
#               CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163 #No.TQC-C50211 mark
#               CALL gglq701_get_ahe02(sr1.aag01,l_aed02,l_gaq01) #TQC-930163   #No.TQC-C50211
#                    RETURNING l_ahe02_d
#               INITIALIZE sr.* TO NULL
#               LET sr.aed01  = sr1.aag01
#               LET sr.aag02  = sr1.aag02
#               LET sr.aed04  = l_i
#               LET sr.aed02  = l_aed02
#               LET sr.ahe02_d  = l_ahe02_d
#               LET sr.ted09 = l_ted09
#               LET sr.ted05 = qj_ted05
#               LET sr.ted06 = qj_ted06
#               LET sr.qcye  = qc_ted05 - qc_ted06
#               LET sr.ted10 = qj_ted10
#               LET sr.ted11 = qj_ted11
#               LET sr.qcyef = qc_ted10 - qc_ted11
#           #    OUTPUT TO REPORT gglq701_rep1(sr.*)      #No.FUN-8B0106  mark
#
#No.FUN-8B0106  add start
#        IF cl_null(sr.ted05) THEN LET sr.ted05 = 0 END IF
#        IF cl_null(sr.ted06) THEN LET sr.ted06 = 0 END IF
#        IF cl_null(sr.ted10) THEN LET sr.ted10 = 0 END IF
#        IF cl_null(sr.ted11) THEN LET sr.ted11 = 0 END IF
#        LET t_bal   = sr.ted05 - sr.ted06 + sr.qcye
#        LET t_balf  = sr.ted10 - sr.ted11 + sr.qcyef
#
#        IF sr.qcye > 0 THEN
#           LET n_pb_bal = sr.qcye
#           LET n_pb_balf= sr.qcyef
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#        ELSE
#           IF sr.qcye = 0 THEN
#              LET n_pb_bal = sr.qcye
#              LET n_pb_balf= sr.qcyef
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#           ELSE
#              LET n_pb_bal = sr.qcye * -1
#              LET n_pb_balf= sr.qcyef* -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#           END IF
#        END IF
#        #-MOD-A90110-add-
#         SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07
#           FROM azi_file
#          WHERE azi01 = sr.ted09
#        #-MOD-A90110-end-
#        IF t_bal > 0 THEN
#           LET n_bal = t_bal
#           LET n_balf= t_balf
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#        ELSE
#           IF t_bal = 0 THEN
#              LET n_bal = t_bal
#              LET n_balf= t_balf
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#           ELSE
#              LET n_bal = t_bal * -1
#              LET n_balf= t_balf* -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#           END IF
#        END IF
#        LET l_abb25_pb = n_pb_bal / n_pb_balf
#        LET l_abb25_d  = sr.ted05 / sr.ted10
#        LET l_abb25_c  = sr.ted06 / sr.ted11
#        LET l_abb25_bal = n_bal / n_balf
#
#        INSERT INTO gglq701_tmp
#        VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,sr.ted09,'2',
#               l_pb_dc,n_pb_balf,l_abb25_pb,n_pb_bal,'',sr.ted10,l_abb25_d,
#               sr.ted05,sr.ted11,l_abb25_c,sr.ted06,l_dc,n_balf,l_abb25_bal,
#               n_bal,t_azi04,t_azi05,t_azi07)   #MOD-A90110 add azi04,azi05,azi07
#No.FUN-8B0106 add end
#            END FOR
#         END FOREACH
#      #END IF   #FUN-C80102  mark
#    END FOREACH
##     FINISH REPORT gglq701_rep1    #FUN-8B0106 MARK
#    CALL gglq701_tmp_sum()                       #No.FUN-A80034
#END FUNCTION
#FUN-D30014----mark--end--

#FUN-D30014----add--str--
FUNCTION gglq701v_1()
   DEFINE l_name             LIKE type_file.chr20,
          #l_sql              LIKE type_file.chr1000,
          #l_sql1             LIKE type_file.chr1000,
          l_sql              STRING,      #NO.FUN-910082
          l_sql1             STRING,     #NO.FUN-910082
          l_ted              LIKE type_file.chr1000,
          l_abb              LIKE type_file.chr1000,
          l_i                LIKE type_file.num5,
          qc_ted05           LIKE ted_file.ted05,  #期初
          qc_ted06           LIKE ted_file.ted06,
          qj_ted05           LIKE ted_file.ted05,  #期間
          qj_ted06           LIKE ted_file.ted06,
          qc_ted10           LIKE ted_file.ted10,  #期初
          qc_ted11           LIKE ted_file.ted11,
          qj_ted10           LIKE ted_file.ted10,  #期間
          qj_ted11           LIKE ted_file.ted11,
          l_ted05            LIKE ted_file.ted05,
          l_ted06            LIKE ted_file.ted06,
          l_ted10            LIKE ted_file.ted10,
          l_ted11            LIKE ted_file.ted11,
          l_aed02            LIKE aed_file.aed02,
          l_ted09            LIKE ted_file.ted09, #TQC-930163
          l_gaq01            LIKE gaq_file.gaq01,
          l_aag01_str        LIKE type_file.chr50,
          l_ahe02_d          LIKE ze_file.ze03,
#No.FUN-8B0106  add start
          l_cnt                        LIKE type_file.num5,
          t_bal                        LIKE aed_file.aed05,
	  n_bal                        LIKE aed_file.aed05,
          n_pb_bal                     LIKE aed_file.aed05,
          t_balf                       LIKE aed_file.aed05,
	  n_balf                       LIKE aed_file.aed05,
          n_pb_balf                    LIKE aed_file.aed05,
          l_abb25_pb                   LIKE abb_file.abb25,
          l_abb25_d                    LIKE abb_file.abb25,
          l_abb25_c                    LIKE abb_file.abb25,
          l_abb25_bal                  LIKE abb_file.abb25,
          l_pb_dc                      LIKE type_file.chr10,
          l_dc                         LIKE type_file.chr10,
#No.FUN-8B0106 add end
          #No.CHI-C70031  --Begin
          l_aeh11                      LIKE aeh_file.aeh11,
          l_aeh12                      LIKE aeh_file.aeh12,
          l_aeh15                      LIKE aeh_file.aeh15,
          l_aeh16                      LIKE aeh_file.aeh16,
          l_aaa09                      LIKE aaa_file.aaa09,
          l_aeh03                      LIKE aeh_file.aeh03,
          l_aeh04                      LIKE aeh_file.aeh04,
          l_aeh05                      LIKE aeh_file.aeh05,
          l_aeh06                      LIKE aeh_file.aeh06,
          l_aeh07                      LIKE aeh_file.aeh07,
          l_aeh31                      LIKE aeh_file.aeh31,
          l_aeh32                      LIKE aeh_file.aeh32,
          l_aeh33                      LIKE aeh_file.aeh33,
          l_aeh34                      LIKE aeh_file.aeh34,
          l_aeh35                      LIKE aeh_file.aeh35,
          l_aeh36                      LIKE aeh_file.aeh36,
          l_aeh37                      LIKE aeh_file.aeh37,
          #No.CHI-C70031  --End
          sr1                RECORD
                             aag01    LIKE aag_file.aag01,
                             aag02    LIKE aag_file.aag02
                             END RECORD,
          sr                 RECORD
                             aed01    LIKE aed_file.aed01,
                             aag02    LIKE aag_file.aag02,
                             aed04    LIKE aed_file.aed04,
                             aed02    LIKE aed_file.aed02,
                             ahe02_d  LIKE ze_file.ze03,
                             ted05    LIKE ted_file.ted05,
                             ted06    LIKE ted_file.ted06,
                             qcye     LIKE ted_file.ted05,
                             ted09    LIKE ted_file.ted09,
                             ted10    LIKE ted_file.ted10,
                             ted11    LIKE ted_file.ted11,
                             qcyef    LIKE ted_file.ted05
                             END RECORD,
          l_field            LIKE     gaq_file.gaq01

     CASE tm.a
          WHEN '1'   LET l_field = 'abb11'
                     LET l_gaq01 = 'aag15'
          WHEN '2'   LET l_field = 'abb12'
                     LET l_gaq01 = 'aag16'
          WHEN '3'   LET l_field = 'abb13'
                     LET l_gaq01 = 'aag17'
          WHEN '4'   LET l_field = 'abb14'
                     LET l_gaq01 = 'aag18'
          WHEN '5'   LET l_field = 'abb31'
                     LET l_gaq01 = 'aag31'
          WHEN '6'   LET l_field = 'abb32'
                     LET l_gaq01 = 'aag32'
          WHEN '7'   LET l_field = 'abb33'
                     LET l_gaq01 = 'aag33'
          WHEN '8'   LET l_field = 'abb34'
                     LET l_gaq01 = 'aag34'
          WHEN '9'   LET l_field = 'abb35'
                     LET l_gaq01 = 'aag35'
          WHEN '10'  LET l_field = 'abb36'
                     LET l_gaq01 = 'aag36'
          #WHEN '11'  LET l_field = 'abb37'      #FUN-C80102  mark
          WHEN '99'  LET l_field = 'abb37'       #FUN-C80102  add
                     LET l_gaq01 = 'aag37'
     END CASE

     DISPLAY "START TIME:",TIME
     CALL gglq701_table()
     SELECT zo02 INTO g_company FROM zo_file
      WHERE zo01 = g_rlang

     #科目&&核算項
     LET tm.wc = cl_replace_str(tm.wc,"aed01","aag01")      #FUN-C80102 add
     LET tm.wc = cl_replace_str(tm.wc,"aed02","ted02")     #MOD-E20114
     LET l_sql1 = "SELECT UNIQUE aag01,aag02,ted02,ted09 FROM aag_file,ted_file ", #TQC-D60028 ''->aag02
                  " WHERE aag00 = ted00 AND ted00 = '",tm.o,"'",
                  "    AND ",tm.wc CLIPPED,
                  "   AND ted01 LIKE aag01||'%' ",           #科目
                  "   AND ted011 = '",tm.a,"'"
     LET tm.wc = cl_replace_str(tm.wc,"ted02",l_field)     #MOD-E20114
     LET l_sql1 = l_sql1 CLIPPED,
                        " UNION ",
                        " SELECT aag01,aag02,",l_field CLIPPED,",abb24 FROM aag_file,aba_file,abb_file",#TQC-D60028 ''->aag02
                        "  WHERE aag00 = aba00 AND aba00 = abb00 AND aba01 = abb01 ",
                        "    AND aba00 = '",tm.o,"'",
                        "    AND ",tm.wc CLIPPED,
                        "    AND abb03 LIKE aag01||'%' ",       #科目
                        "    AND ",l_field CLIPPED," IS NOT NULL",
                        "    AND abb24 IS NOT NULL "
     IF tm.g ='Y' THEN
        IF tm.b = '1' THEN
           LET l_sql1 = l_sql1,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
        ELSE
           LET l_sql1 = l_sql1,"  AND aba19 = 'N'"
        END IF
     END IF
     IF tm.g ='N' THEN
        IF tm.b = '1' THEN
           LET l_sql1 = l_sql1," AND (aba19 ='Y' and abapost = 'N') "
        ELSE
   #        LET l_sql1 = l_sql1," AND  aba19 = 1 "   #mark by kuangxj150319
            LET l_sql1 = l_sql1," AND  abapost = 'Y' "   #add by kuangxj150319
        END IF
     END IF

     PREPARE gglq701_ted02_p FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_ted02_cs CURSOR FOR gglq701_ted02_p

     #共用條件
     LET l_ted = "SELECT SUM(ted05),SUM(ted06),SUM(ted10),SUM(ted11) FROM ted_file",
                 " WHERE ted00 = '",tm.o,"'",
                 "   AND ted01 LIKE ? ",                #科目
                 "   AND ted02 = ? ",                   #核算項
                 "   AND ted09 = ? ",
                 "   AND ted011 = '",tm.a,"'",
                 "   AND ted03 = ",tm.yy

     #lujh 1219--add--str--
     LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
                       "    AND aba00 = '",tm.o,"'",
                       "    AND abb03 LIKE ?   ",             #科目
                       "    AND ",l_field CLIPPED," = ? ",    #核算項值
                       "    AND aba03 = ",tm.yy,
                       "    AND abb24 = ?   "

     IF tm.g ='Y' THEN
        IF tm.b = '1' THEN
           LET l_abb = l_abb,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
        ELSE
           LET l_abb = l_abb,"  AND aba19 = 'N'"
        END IF
     END IF
     IF tm.g ='N' THEN
        IF tm.b = '1' THEN
           LET l_abb = l_abb," AND (aba19 ='Y' and abapost = 'N') "
        ELSE
     #      LET l_abb = l_abb," AND  aba19 = 1 "     #mark by kuangxj150319
            LET l_abb = l_abb," AND  abapost = 'Y' "   #add by kuangxj150319
        END IF
     END IF
     #lujh 1219--add--end--
     #TQC-930163 --end

     #當期異動
     LET l_sql1 = l_ted CLIPPED, "   AND ted04 = ? "   #當期
     #IF tm.b = 'Y' THEN   #FUN-C80102  mark
        LET l_sql1 = l_sql1 CLIPPED,
                     " UNION ",
                     #未過帳 - 借
                     " SELECT SUM(abb07),0,SUM(abb07f),0 FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '1' ",
                     "    AND aba04 = ?   ",              #當期未過帳資料
                     " UNION ",
                     #未過帳 - 貸
                     " SELECT 0,SUM(abb07),0,SUM(abb07f) FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '2' ",
                     "    AND aba04 = ?   "               #當期未過帳資料
     #END IF              #FUN-C80102  mark
     PREPARE gglq701_qj_p1 FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_qj_cs1 CURSOR FOR gglq701_qj_p1

     #期初余額
     LET l_sql1 = l_ted CLIPPED, "   AND ted04 < ? "  #期初
     #IF tm.b = 'Y' THEN   #FUN-C80102  mark
        LET l_sql1 = l_sql1 CLIPPED,
                     " UNION ",
                     #未過帳 - 借
                     " SELECT SUM(abb07),0,SUM(abb07f),0 FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '1' ",
                     "    AND aba04 < ?   ",              #期初未過帳資料
                     " UNION ",
                     #未過帳 - 貸
                     " SELECT 0,SUM(abb07),0,SUM(abb07f) FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '2' ",
                     "    AND aba04 < ?   "               #期初未過帳資料
     #END IF   #FUN-C80102  mark
     PREPARE gglq701_qc_p1 FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_qc_cs1 CURSOR FOR gglq701_qc_p1

      #FUN-D40044--mark--str--
      #No.CHI-C70031  --Begin
      #LET  l_aeh04  =  NULL
      #LET  l_aeh05  =  NULL
      #LET  l_aeh06  =  NULL
      #LET  l_aeh07  =  NULL
      #LET  l_aeh31  =  NULL
      #LET  l_aeh32  =  NULL
      #LET  l_aeh33  =  NULL
      #LET  l_aeh34  =  NULL
      #LET  l_aeh35  =  NULL
      #LET  l_aeh36  =  NULL
      #LET  l_aeh37  =  NULL
      #No.CHI-C70031  --End
      #FUN-D40044--mark--end--

     FOREACH gglq701_ted02_cs INTO sr1.*,l_aed02,l_ted09  #科目
       IF SQLCA.sqlcode THEN
          CALL cl_err('gglq701_aag01_cs1 foreach:',SQLCA.sqlcode,0) EXIT FOREACH
       END IF

       #此作業也要打印統治科目的金額，但是aed/abb中都存放得是明細或是獨立科目
       #所以要用LIKE的方式，取出統治科目對應的明細科目的金額
       #此作業的前提，明細科目的前幾碼一定和其上屬統治相同 ruled by 蔡曉峰
       IF cl_null(sr1.aag01) THEN CONTINUE FOREACH END IF
       LET l_aag01_str = sr1.aag01 CLIPPED,'\%'    #No.MOD-940388

      #FUN-D40044--add--str--
      LET  l_aeh04  =  NULL
      LET  l_aeh05  =  NULL
      LET  l_aeh06  =  NULL
      LET  l_aeh07  =  NULL
      LET  l_aeh31  =  NULL
      LET  l_aeh32  =  NULL
      LET  l_aeh33  =  NULL
      LET  l_aeh34  =  NULL
      LET  l_aeh35  =  NULL
      LET  l_aeh36  =  NULL
      LET  l_aeh37  =  NULL
      CASE tm.a
           WHEN '1' LET l_aeh04 = l_aed02
           WHEN '2' LET l_aeh05 = l_aed02
           WHEN '3' LET l_aeh06 = l_aed02
           WHEN '4' LET l_aeh07 = l_aed02
           WHEN '5' LET l_aeh31 = l_aed02
           WHEN '6' LET l_aeh32 = l_aed02
           WHEN '7' LET l_aeh33 = l_aed02
           WHEN '8' LET l_aeh34 = l_aed02
           WHEN '9' LET l_aeh35 = l_aed02
           WHEN '10' LET l_aeh36 = l_aed02
           WHEN '99' LET l_aeh37 =l_aed02
       END CASE
       #FUN-D40044--add--end--

            FOR l_i = tm.m1 TO tm.m2
                LET qc_ted05 = 0  #期初
                LET qc_ted06 = 0
                LET qj_ted05 = 0  #期間
                LET qj_ted06 = 0
                LET qc_ted10 = 0  #期初
                LET qc_ted11 = 0
                LET qj_ted10 = 0  #期間
                LET qj_ted11 = 0
                FOREACH gglq701_qc_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i,
                                             l_aag01_str,l_aed02,l_ted09,l_i,
                                             l_aag01_str,l_aed02,l_ted09,l_i
                                       INTO l_ted05,l_ted06,l_ted10,l_ted11
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('gglq701_ted02_cs foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF
                  IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
                  IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
                  IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
                  IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
                  LET qc_ted05 = qc_ted05 + l_ted05
                  LET qc_ted06 = qc_ted06 + l_ted06
                  LET qc_ted10 = qc_ted10 + l_ted10
                  LET qc_ted11 = qc_ted11 + l_ted11
                END FOREACH
                #No.CHI-C70031  --Begin
                SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
                LET l_aeh11 = 0
                LET l_aeh12 = 0
                LET l_aeh15 = 0
                LET l_aeh16 = 0

                CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
                l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
                0,       l_i-1,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
                l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
                RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
                IF tm.i = 'N' THEN    #FUN-D40044 add
                   LET qc_ted05 = qc_ted05 - l_aeh11
                   LET qc_ted06 = qc_ted06 - l_aeh12
                   LET qc_ted10 = qc_ted10 - l_aeh15
                   LET qc_ted11 = qc_ted11 - l_aeh16
                END IF  #FUN-D40044 add
                #No.CHI-C70031  --End
                LET g_print = 'N'
                FOREACH gglq701_qj_cs1 USING l_aag01_str,l_aed02,l_ted09,l_i,
                                            l_aag01_str,l_aed02,l_ted09,l_i,
                                            l_aag01_str,l_aed02,l_ted09,l_i
                                      INTO l_ted05,l_ted06,l_ted10,l_ted11
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF
                  IF cl_null(l_ted05) THEN LET l_ted05 = 0 END IF
                  IF cl_null(l_ted06) THEN LET l_ted06 = 0 END IF
                  IF cl_null(l_ted10) THEN LET l_ted10 = 0 END IF
                  IF cl_null(l_ted11) THEN LET l_ted11 = 0 END IF
                  LET qj_ted05 = qj_ted05 + l_ted05
                  LET qj_ted06 = qj_ted06 + l_ted06
                  LET qj_ted10 = qj_ted10 + l_ted10
                  LET qj_ted11 = qj_ted11 + l_ted11
                  LET g_print = 'Y'
                END FOREACH
                #No.CHI-C70031  --Begin
                SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
                LET l_aeh11 = 0
                LET l_aeh12 = 0
                LET l_aeh15 = 0
                LET l_aeh16 = 0

                CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
                l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
                l_i,       l_i,       l_ted09,      l_aeh31,  l_aeh32,    l_aeh33,
                l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
                RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
                #FUN-D4004--mark--str--
                #LET qj_ted05 = qj_ted05 + l_ted05 - l_aeh11
                #LET qj_ted06 = qj_ted06 + l_ted06 - l_aeh12
                #LET qj_ted10 = qj_ted10 + l_ted10 - l_aeh15
                #LET qj_ted11 = qj_ted11 + l_ted11 - l_aeh16
                #FUN-D4004--mark--end--
                IF tm.i = 'N' THEN    #FUN-D40044 add
                   LET qj_ted05 = qj_ted05 - l_aeh11
                   LET qj_ted06 = qj_ted06 - l_aeh12
                   LET qj_ted10 = qj_ted10 - l_aeh15
                   LET qj_ted11 = qj_ted11 - l_aeh16
                END IF                #FUN-D40044 add
                #No.CHI-C70031  --End
                #無期初也沒有本期異動，則不打印
                IF qc_ted05 = 0 AND qc_ted06 = 0 AND
                   qj_ted05 = 0 AND qj_ted06 = 0 THEN
                   CONTINUE FOR
                END IF

                #取核算項名稱
               #CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163  #MOD-E30064 mark
                CALL gglq701_get_ahe02(sr1.aag01,l_aed02,l_gaq01) #TQC-930163  #MOD-E30064
                     RETURNING l_ahe02_d
                INITIALIZE sr.* TO NULL
                LET sr.aed01  = sr1.aag01
                LET sr.aag02  = sr1.aag02
                LET sr.aed04  = l_i
                LET sr.aed02  = l_aed02
                LET sr.ahe02_d  = l_ahe02_d
                LET sr.ted09 = l_ted09
                LET sr.ted05 = qj_ted05
                LET sr.ted06 = qj_ted06
                LET sr.qcye  = qc_ted05 - qc_ted06
                LET sr.ted10 = qj_ted10
                LET sr.ted11 = qj_ted11
                LET sr.qcyef = qc_ted10 - qc_ted11
            #    OUTPUT TO REPORT gglq701_rep1(sr.*)      #No.FUN-8B0106  mark

#No.FUN-8B0106  add start
         IF cl_null(sr.ted05) THEN LET sr.ted05 = 0 END IF
         IF cl_null(sr.ted06) THEN LET sr.ted06 = 0 END IF
         IF cl_null(sr.ted10) THEN LET sr.ted10 = 0 END IF
         IF cl_null(sr.ted11) THEN LET sr.ted11 = 0 END IF
         LET t_bal   = sr.ted05 - sr.ted06 + sr.qcye
         LET t_balf  = sr.ted10 - sr.ted11 + sr.qcyef

         IF sr.qcye > 0 THEN
            LET n_pb_bal = sr.qcye
            LET n_pb_balf= sr.qcyef
            CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
         ELSE
            IF sr.qcye = 0 THEN
               LET n_pb_bal = sr.qcye
               LET n_pb_balf= sr.qcyef
               CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
            ELSE
               LET n_pb_bal = sr.qcye * -1
               LET n_pb_balf= sr.qcyef* -1
               CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
            END IF
         END IF
         #-MOD-A90110-add-
          SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07
            FROM azi_file
           WHERE azi01 = sr.ted09
         #-MOD-A90110-end-
         IF t_bal > 0 THEN
            LET n_bal = t_bal
            LET n_balf= t_balf
            CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
         ELSE
            IF t_bal = 0 THEN
               LET n_bal = t_bal
               LET n_balf= t_balf
               CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
            ELSE
               LET n_bal = t_bal * -1
               LET n_balf= t_balf* -1
               CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
            END IF
         END IF
         LET l_abb25_pb = n_pb_bal / n_pb_balf
         LET l_abb25_d  = sr.ted05 / sr.ted10
         LET l_abb25_c  = sr.ted06 / sr.ted11
         LET l_abb25_bal = n_bal / n_balf

         INSERT INTO gglq701_tmp
         VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,sr.ted09,'2',
                l_pb_dc,n_pb_balf,l_abb25_pb,n_pb_bal,'',sr.ted10,l_abb25_d,
                sr.ted05,sr.ted11,l_abb25_c,sr.ted06,l_dc,n_balf,l_abb25_bal,
                n_bal,t_azi04,t_azi05,t_azi07)   #MOD-A90110 add azi04,azi05,azi07
             END FOR
     END FOREACH
     CALL gglq701_tmp_sum()                       #No.FUN-A80034
     DISPLAY "END TIME:",TIME
END FUNCTION
#FUN-D30014----add--end---

#No.FUN-8B0106 mark start
#REPORT gglq701_rep1(sr)
#  DEFINE l_last_sw LIKE type_file.chr1,
#         sr        RECORD
#                   aed01    LIKE aed_file.aed01,
#                   aag02    LIKE aag_file.aag02,
#                   aed04    LIKE aed_file.aed04,
#                   aed02    LIKE aed_file.aed02,
#                   ahe02_d  LIKE ze_file.ze03,
#                   ted05    LIKE ted_file.ted05,
#                   ted06    LIKE ted_file.ted06,
#                   qcye     LIKE ted_file.ted05,
#                   ted09    LIKE ted_file.ted09,
#                   ted10    LIKE ted_file.ted10,
#                   ted11    LIKE ted_file.ted11,
#                   qcyef    LIKE ted_file.ted05
#                   END RECORD,
#         l_cnt                        LIKE type_file.num5,
#         t_bal                        LIKE aed_file.aed05,
#         n_bal                        LIKE aed_file.aed05,
#         n_pb_bal                     LIKE aed_file.aed05,
#         t_balf                       LIKE aed_file.aed05,
#         n_balf                       LIKE aed_file.aed05,
#         n_pb_balf                    LIKE aed_file.aed05,
#         l_abb25_pb                   LIKE abb_file.abb25,
#         l_abb25_d                    LIKE abb_file.abb25,
#         l_abb25_c                    LIKE abb_file.abb25,
#         l_abb25_bal                  LIKE abb_file.abb25,
#         l_pb_dc                      LIKE type_file.chr10,
#         l_dc                         LIKE type_file.chr10

# OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
# ORDER BY sr.aed01,sr.aed04,sr.aed02
# FORMAT
#  PAGE HEADER
#     LET g_pageno = g_pageno + 1

#  ON EVERY ROW
#        IF cl_null(sr.ted05) THEN LET sr.ted05 = 0 END IF
#        IF cl_null(sr.ted06) THEN LET sr.ted06 = 0 END IF
#        IF cl_null(sr.ted10) THEN LET sr.ted10 = 0 END IF
#        IF cl_null(sr.ted11) THEN LET sr.ted11 = 0 END IF
#        LET t_bal   = sr.ted05 - sr.ted06 + sr.qcye
#        LET t_balf  = sr.ted10 - sr.ted11 + sr.qcyef

#        IF sr.qcye > 0 THEN
#           LET n_pb_bal = sr.qcye
#           LET n_pb_balf= sr.qcyef
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#        ELSE
#           IF sr.qcye = 0 THEN
#              LET n_pb_bal = sr.qcye
#              LET n_pb_balf= sr.qcyef
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#           ELSE
#              LET n_pb_bal = sr.qcye * -1
#              LET n_pb_balf= sr.qcyef* -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#           END IF
#        END IF

#        IF t_bal > 0 THEN
#           LET n_bal = t_bal
#           LET n_balf= t_balf
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#        ELSE
#           IF t_bal = 0 THEN
#              LET n_bal = t_bal
#              LET n_balf= t_balf
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#           ELSE
#              LET n_bal = t_bal * -1
#              LET n_balf= t_balf* -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#           END IF
#        END IF
#        LET l_abb25_pb = n_pb_bal / n_pb_balf
#        LET l_abb25_d  = sr.ted05 / sr.ted10
#        LET l_abb25_c  = sr.ted06 / sr.ted11
#        LET l_abb25_bal = n_bal / n_balf

#        INSERT INTO gglq701_tmp
#        VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,sr.ted09,'2',
#               l_pb_dc,n_pb_balf,l_abb25_pb,n_pb_bal,'',sr.ted10,l_abb25_d,
#               sr.ted05,sr.ted11,l_abb25_c,sr.ted06,l_dc,n_balf,l_abb25_bal,
#               n_bal)
#        PRINT

#END REPORT
#TQC-930163 --end
#No.FUN-8B0106 mark END

#No.FUN-8B0106 mark start
#REPORT gglq701_rep(sr)
#  DEFINE l_last_sw LIKE type_file.chr1,
#         sr        RECORD
#                   aed01    LIKE aed_file.aed01,
#                   aag02    LIKE aag_file.aag02,
#                   aed04    LIKE aed_file.aed04,
#                   aed02    LIKE aed_file.aed02,
#                   ahe02_d  LIKE ze_file.ze03,
#                   aed05    LIKE aed_file.aed05,
#                   aed06    LIKE aed_file.aed06,
#                   qcye     LIKE aed_file.aed05
#                   END RECORD,
#         l_cnt                        LIKE type_file.num5,
#         t_bal                        LIKE aed_file.aed05,
#         n_bal                        LIKE aed_file.aed05,
#         n_pb_bal                     LIKE aed_file.aed05,
#         l_pb_dc                      LIKE type_file.chr10,
#         l_dc                         LIKE type_file.chr10

# OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
# ORDER BY sr.aed01,sr.aed04,sr.aed02
# FORMAT
#  PAGE HEADER
#     LET g_pageno = g_pageno + 1

#  ON EVERY ROW
#        IF cl_null(sr.aed05) THEN LET sr.aed05 = 0 END IF
#        IF cl_null(sr.aed06) THEN LET sr.aed06 = 0 END IF
#        LET t_bal   = sr.aed05 - sr.aed06 + sr.qcye

#        IF sr.qcye > 0 THEN
#           LET n_pb_bal = sr.qcye
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#        ELSE
#           IF sr.qcye = 0 THEN
#              LET n_pb_bal = sr.qcye
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#           ELSE
#              LET n_pb_bal = sr.qcye * -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#           END IF
#        END IF

#        IF t_bal > 0 THEN
#           LET n_bal = t_bal
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#        ELSE
#           IF t_bal = 0 THEN
#              LET n_bal = t_bal
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#           ELSE
#              LET n_bal = t_bal * -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#           END IF
#        END IF

#        INSERT INTO gglq701_tmp
#        #TQC-930163 --begin
#      # VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'2',
#      #        l_pb_dc,n_pb_bal,'',sr.aed05,sr.aed06,l_dc,n_bal)
#        VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'','2',
#               l_pb_dc,0,0,n_pb_bal,'',0,0,sr.aed05,0,0,sr.aed06,l_dc,0,0,n_bal)
#        #TQC-930163 --end
#        PRINT

#END REPORT
#No.FUN-8B0106  mark end

FUNCTION gglq701_table()
     DROP TABLE gglq701_tmp;
     CREATE TEMP TABLE gglq701_tmp(
                    aed01       LIKE aed_file.aed01,
#                   aag02       LIKE aag_file.aag02,
                    aag02       LIKE type_file.chr1000,    #No.MOD-940388
                    aed04       LIKE type_file.num5,
                    aed02       LIKE aed_file.aed02,
                    ahe02_d     LIKE ze_file.ze03,
                    ted09       LIKE ted_file.ted09, #TQC-930163
                    type        LIKE type_file.chr1,
                    pb_dc       LIKE type_file.chr10,
                    pb_balf     LIKE aed_file.aed05, #TQC-930163
                    abb25_pb    LIKE abb_file.abb25, #TQC-930163
                    pb_bal      LIKE aed_file.aed05,
                    memo        LIKE type_file.chr50,
                    df          LIKE aed_file.aed05, #TQC-930163
                    abb25_d     LIKE abb_file.abb25, #TQC-930163
                    d           LIKE aed_file.aed05,
                    cf          LIKE aed_file.aed05, #TQC-930163
                    abb25_c     LIKE abb_file.abb25, #TQC-930163
                    c           LIKE aed_file.aed05,
                    dc          LIKE type_file.chr10,
                    balf        LIKE aed_file.aed05, #TQC-930163
                    abb25_bal   LIKE abb_file.abb25, #TQC-930163
                    bal         LIKE aed_file.aed05, #MOD-A90110
                    azi04       LIKE azi_file.azi04, #MOD-A90110
                    azi05       LIKE azi_file.azi05, #MOD-A90110
                    azi07       LIKE azi_file.azi07);#MOD-A90110
END FUNCTION

FUNCTION q701_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_aed TO s_aed.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

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

      ON ACTION drill_detail
         LET g_action_choice="drill_detail"
         EXIT DISPLAY

      ON ACTION first
         CALL gglq701_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY

      ON ACTION previous
         CALL gglq701_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY

      ON ACTION jump
         CALL gglq701_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY

      ON ACTION next
         CALL gglq701_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)
         END IF
         ACCEPT DISPLAY

      ON ACTION last
         CALL gglq701_fetch('L')
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

FUNCTION gglq701_cs()
     LET g_sql = "SELECT UNIQUE aed01,aag02,aed04 FROM gglq701_tmp ",
                 " ORDER BY aed01,aag02,aed04"
     PREPARE gglq701_ps FROM g_sql
     DECLARE gglq701_curs SCROLL CURSOR WITH HOLD FOR gglq701_ps

     LET g_sql = "SELECT UNIQUE aed01,aag02,aed04 FROM gglq701_tmp ",
                 "  INTO TEMP x "
     DROP TABLE x
     PREPARE gglq701_ps1 FROM g_sql
     EXECUTE gglq701_ps1

     LET g_sql = "SELECT COUNT(*) FROM x"
     PREPARE gglq701_ps2 FROM g_sql
     DECLARE gglq701_cnt CURSOR FOR gglq701_ps2

     OPEN gglq701_curs
     IF SQLCA.sqlcode THEN
        CALL cl_err('OPEN gglq701_curs',SQLCA.sqlcode,0)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
        EXIT PROGRAM
     ELSE
        OPEN gglq701_cnt
        FETCH gglq701_cnt INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL gglq701_fetch('F')
     END IF
END FUNCTION

FUNCTION gglq701_fetch(p_flag)
DEFINE
   p_flag          LIKE type_file.chr1,
   l_abso          LIKE type_file.num10

   CASE p_flag
      WHEN 'N' FETCH NEXT     gglq701_curs INTO g_aed01,g_aag02,g_aed04
      WHEN 'P' FETCH PREVIOUS gglq701_curs INTO g_aed01,g_aag02,g_aed04
      WHEN 'F' FETCH FIRST    gglq701_curs INTO g_aed01,g_aag02,g_aed04
      WHEN 'L' FETCH LAST     gglq701_curs INTO g_aed01,g_aag02,g_aed04
      WHEN '/'
         IF (NOT mi_no_ask) THEN
             CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
             LET INT_FLAG = 0
             PROMPT g_msg CLIPPED,': ' FOR g_jump
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

         END IF
         FETCH ABSOLUTE g_jump gglq701_curs INTO g_aed01,g_aag02,g_aed04
         LET mi_no_ask = FALSE
   END CASE

   IF SQLCA.sqlcode THEN
      CALL cl_err(g_aed01,SQLCA.sqlcode,0)
      INITIALIZE g_aed01 TO NULL
      INITIALIZE g_aag02 TO NULL
      INITIALIZE g_aed04 TO NULL
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE

      CALL cl_navigator_setting( g_curs_index, g_row_count )
   END IF

   CALL gglq701_show()
END FUNCTION

FUNCTION gglq701_show()

   #DISPLAY g_aed01 TO aed01    #FUN-C80102 mark
   #DISPLAY g_aag02 TO aag02    #FUN-C80102 mark
   DISPLAY tm.yy   TO yy
   DISPLAY g_aed04 TO mm
   DISPLAY tm.a    TO a
   #FUN-C80102--add--str---
   DISPLAY tm.o    TO o
   DISPLAY tm.m1    TO m1
   DISPLAY tm.m2    TO m2
   DISPLAY tm.b    TO b
   DISPLAY tm.g    TO g
   DISPLAY tm.f    TO f
   DISPLAY tm.e    TO e
   #FUN-C80102--add--end---
   DISPLAY tm.i    TO i   #FUN-D40044 add

   CALL gglq701_b_fill()

   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION gglq701_b_fill()
  DEFINE  l_npq06    LIKE npq_file.npq06
  DEFINE  l_type     LIKE type_file.chr1
  DEFINE  l_memo     LIKE abb_file.abb04

   #TQC-930163 --begin
   LET g_sql = "SELECT aed01,aag02,aed02,ahe02_d,ted09,pb_dc,pb_balf,abb25_pb,pb_bal,",    #FUN-C80102 add  aed01,aag02
               "       df,abb25_d,d,cf,abb25_c,c,dc,balf,abb25_bal,bal,",
               "       type,memo ",
               " FROM gglq701_tmp",
               " WHERE aed01 ='",g_aed01,"'",
               "   AND aed04 = ",g_aed04,
               " ORDER BY ted09,type,aed02,ahe02_d "   #No.FUN-A80034
   #TQC-930163 --end

   PREPARE gglq701_pb FROM g_sql
   DECLARE aed_curs  CURSOR FOR gglq701_pb

   CALL g_aed.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH aed_curs INTO g_aed[g_cnt].*,l_type,l_memo
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
     #SELECT aag02 INTO g_aed[g_cnt].aag02 FROM aag_file WHERE aag01 = g_aed[g_cnt].aed01 AND aag00 = tm.o #No.FUN-D30014 Add #TQC-D60028 mark
     #-MOD-A90110-add-
      SELECT azi04,azi05,azi07 INTO t_azi04,t_azi05,t_azi07
        FROM azi_file
       WHERE azi01 = g_aed[g_cnt].ted09
     #-MOD-A90110-end-
      LET g_aed[g_cnt].d      = cl_numfor(g_aed[g_cnt].d,20,g_azi04)
      LET g_aed[g_cnt].c      = cl_numfor(g_aed[g_cnt].c,20,g_azi04)
      LET g_aed[g_cnt].bal    = cl_numfor(g_aed[g_cnt].bal,20,g_azi04)
      LET g_aed[g_cnt].pb_bal = cl_numfor(g_aed[g_cnt].pb_bal,20,g_azi04)
      #TQC-930163 --begin
      LET g_aed[g_cnt].df     = cl_numfor(g_aed[g_cnt].df,20,t_azi04)       #MOD-A90110 g_azi04 -> t_azi04
      LET g_aed[g_cnt].cf     = cl_numfor(g_aed[g_cnt].cf,20,t_azi04)       #MOD-A90110 g_azi04 -> t_azi04
      LET g_aed[g_cnt].balf   = cl_numfor(g_aed[g_cnt].balf,20,t_azi04)     #MOD-A90110 g_azi04 -> t_azi04
      LET g_aed[g_cnt].pb_balf= cl_numfor(g_aed[g_cnt].pb_balf,20,t_azi04)  #MOD-A90110 g_azi04 -> t_azi04
      #TQC-930163 --end
      LET g_aed[g_cnt].abb25_pb = cl_numfor(g_aed[g_cnt].abb25_pb,20,t_azi07)    #MOD-A90110
      LET g_aed[g_cnt].abb25_d  = cl_numfor(g_aed[g_cnt].abb25_d,20,t_azi07)     #MOD-A90110
      LET g_aed[g_cnt].abb25_c  = cl_numfor(g_aed[g_cnt].abb25_c,20,t_azi07)     #MOD-A90110
      LET g_aed[g_cnt].abb25_bal= cl_numfor(g_aed[g_cnt].abb25_bal,20,t_azi07)   #MOD-A90110
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
   END FOREACH

   CALL g_aed.deleteElement(g_cnt)
   LET g_rec_b = g_cnt - 1

END FUNCTION

FUNCTION q701_out_1()
   LET g_prog = 'gglq701'
   LET g_sql = "aed01.aed_file.aed01,",
               "aag02.aag_file.aag02,",
               "aed04.aed_file.aed04,",
               "aed02.type_file.chr50,",
               "ahe02_d.ze_file.ze03,",
               "ted09.ted_file.ted09,",     #No.TQC-930163
               "type.type_file.chr10,",
               "pb_dc.type_file.chr10,",
               "pb_balf.aed_file.aed05,",   #No.TQC-930163
               "abb25_pb.abb_file.abb25,",  #No.TQC-930163
               "pb_bal.aed_file.aed05,",
               "memo.abb_file.abb04,",
               "df.aed_file.aed05,",        #No.TQC-930163
               "abb25_d.abb_file.abb25,",   #No.TQC-930163
               "d.aed_file.aed05,",
               "cf.aed_file.aed05,",        #No.TQC-930163
               "abb25_c.abb_file.abb25,",   #No.TQC-930163
               "c.aed_file.aed05,",
               "dc.type_file.chr10,",
               "balf.aed_file.aed05,",      #No.TQC-930163
               "abb25_bal.abb_file.abb25,", #No.TQC-930163
               "bal.aed_file.aed05,",       #MOD-A90110
               "azi04.azi_file.azi04,",     #MOD-A90110
               "azi05.azi_file.azi05,",     #MOD-A90110
               "azi07.azi_file.azi07 "      #MOD-A90110

   LET l_table = cl_prt_temptable('gglq701',g_sql) CLIPPED
   IF  l_table = -1 THEN
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
   END IF
   LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
               " VALUES(?,?,?,?,?, ?,?,?,?,?, ",
               "        ?,?,?,?,?, ?,?,?,?,?, ",   #No.TQC-930163
               "        ?,?,?,?,? )          "    #MOD-A90110 add 3?
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF

END FUNCTION

FUNCTION q701_out_2()

   LET g_prog = 'gglq701'
   CALL cl_del_data(l_table)

   DECLARE cr_curs CURSOR FOR
    SELECT * FROM gglq701_tmp
   FOREACH cr_curs INTO g_pr.*
       EXECUTE insert_prep USING g_pr.*
   END FOREACH

   LET g_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED

   IF g_zz05='Y' THEN
      CALL cl_wcchp(tm.wc,'aed01')
           RETURNING g_str
   END IF
   LET g_str=g_str CLIPPED,";",tm.yy,";",g_azi04,";",tm.a

   #IF tm.c='Y' THEN                                      #No.TQC-930163   #FUN-C80102  mark
   IF tm.e ='Y' THEN       #FUN-C80102  mark
      CALL cl_prt_cs3('gglq701','gglq701_1',g_sql,g_str)  #No.TQC-930163
   ELSE                                                   #No.TQC-930163
      CALL cl_prt_cs3('gglq701','gglq701',g_sql,g_str)
   END IF  #No.TQC-930163
END FUNCTION

FUNCTION gglq701_get_ahe02(p_aag01_str,p_aed02,p_gaq01) #TQC-930163
  DEFINE p_aag01_str     LIKE type_file.chr50
  DEFINE p_aed02         LIKE aed_file.aed02
  DEFINE p_gaq01         LIKE gaq_file.gaq01 #TQC-930163
  DEFINE l_ahe01         LIKE ahe_file.ahe01
  DEFINE l_ahe04         LIKE ahe_file.ahe04
  DEFINE l_ahe05         LIKE ahe_file.ahe05
  DEFINE l_ahe07         LIKE ahe_file.ahe07
  DEFINE #l_sql1          LIKE type_file.chr1000
         l_sql1   STRING      #NO.FUN-910082
  DEFINE l_ahe02_d       LIKE ze_file.ze03
  DEFINE l_ahe03         LIKE ahe_file.ahe03  #No.TQC-C50211
  DEFINE l_aag07         LIKE aag_file.aag07  #MOD-E30064
     #MOD-E30064--begin
     SELECT aag07 INTO l_aag07  FROM aag_file WHERE aag01 = p_aag01_str
     IF l_aag07 = '1' THEN
        LET p_aag01_str = p_aag01_str CLIPPED,'\%'
     END IF
     #MOD-E30064--end
     #TQC-930163 --begin
     #查找核算項值
     LET l_sql1 = " SELECT ",p_gaq01 CLIPPED," FROM aag_file ",
                  "  WHERE aag00 = '",tm.o,"'",
                  "    AND aag01 LIKE ? ",
                  "    AND aag07 IN ('2','3') ",
                  "    AND ",p_gaq01 CLIPPED," IS NOT NULL"
     PREPARE gglq701_gaq01_p FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_gaq01_cs SCROLL CURSOR FOR gglq701_gaq01_p  #只能取第一個
     #TQC-930163 --end
     #取核算項名稱
     LET l_ahe01 = NULL
     OPEN gglq701_gaq01_cs USING p_aag01_str
     IF SQLCA.sqlcode THEN
     #  CALL cl_err('open gglq701_gaq01_cs',SQLCA.sqlcode,1)
        CLOSE gglq701_gaq01_cs
        RETURN NULL
     END IF
    #FETCH FIRST gglq701_gaq01_cs INTO l_ahe01  #MOD-E30064 mark
     FOREACH gglq701_gaq01_cs INTO l_ahe01      #MOD-E30064
        IF SQLCA.sqlcode THEN
        #  CALL cl_err('fetch gglq701_gaq01_cs',SQLCA.sqlcode,1)
           CLOSE gglq701_gaq01_cs
           RETURN NULL
        END IF
       #CLOSE gglq701_gaq01_cs  #MOD-E30064 mark
        IF NOT cl_null(l_ahe01) THEN
   #No.TQC-C50211 --begin
           LET l_ahe03 = ''
           LET l_ahe04 = ''
           LET l_ahe05 = ''
           LET l_ahe07 = ''
   #No.TQC-C50211 --end
           SELECT ahe03,ahe04,ahe05,ahe07 INTO l_ahe03,l_ahe04,l_ahe05,l_ahe07  #No.TQC-C50211 add ahe03
             FROM ahe_file
            WHERE ahe01 = l_ahe01
           IF NOT cl_null(l_ahe04) AND NOT cl_null(l_ahe05) AND
             #NOT cl_null(l_ahe07) THEN                       #No.TQC-C50211 mark
              NOT cl_null(l_ahe07) AND l_ahe03 = '1' THEN     #No.TQC-C50211
              LET l_ahe02_d = ''                              #No.TQC-C50211
              LET l_sql1 = "SELECT UNIQUE ",l_ahe07 CLIPPED,
                           "  FROM ",l_ahe04 CLIPPED,
                           " WHERE ",l_ahe05 CLIPPED," = '",p_aed02,"'"
              PREPARE ahe_p1 FROM l_sql1
              EXECUTE ahe_p1 INTO l_ahe02_d
              #MOD-E30064--begin
              IF cl_null(l_ahe02_d) THEN
                 CONTINUE FOREACH
              ELSE
                 EXIT FOREACH
              END IF
              #MOD-E30064--end
           END IF
    #No.TQC-C50211 --begin
           IF l_ahe03 = '2' THEN
              LET l_ahe02_d = ''
              SELECT aee04 INTO l_ahe02_d
                FROM aee_file
               WHERE aee00 = tm.o
                 AND aee01 = p_aag01_str
                 AND aee02 = g_aee02
                 AND aee03 = p_aed02
           END IF
   #No.TQC-C50211 --end
        END IF
     END FOREACH #MOD-E30064 add
     CLOSE gglq701_gaq01_cs  #MOD-E30064
     RETURN l_ahe02_d
END FUNCTION

FUNCTION q701_drill_detail()
   DEFINE
          #l_wc1   LIKE type_file.chr50
          l_wc1         STRING       #NO.FUN-910082
   DEFINE
          #l_wc2   LIKE type_file.chr50
          l_wc2         STRING       #NO.FUN-910082
   DEFINE l_bdate LIKE type_file.dat
   DEFINE l_edate LIKE type_file.dat
   DEFINE l_flag3 LIKE type_file.chr1 #TQC-930163

   IF g_aed01 IS NULL THEN RETURN END IF
   IF l_ac = 0 THEN RETURN END IF
   IF cl_null(g_aed[l_ac].aed02) THEN RETURN END IF

   LET l_wc1 = 'aag01 like "',g_aed01,'%"'
   LET l_wc2 = 'ted02 = "',g_aed[l_ac].aed02,'"'

   #TQC-930163 --begin
   LET l_flag3='N'
   #IF tm.c= 'Y' THEN     #FUN-C80102  mark
   IF tm.e = 'Y' THEN     #FUN-C80102  add
      LET l_wc2 = l_wc2 CLIPPED,' AND ted09 = "',g_aed[l_ac].ted09,'"'
      LET l_flag3='Y'
   END IF
   #TQC-930163 --end
   #CALL s_azn01(tm.yy,tm.m2) RETURNING l_bdate,l_edate
   #LET l_bdate = MDY(tm.m1,1,tm.yy)
   CALL s_azn01(tm.yy,g_aed04) RETURNING l_bdate,l_edate
 # LET g_msg = "gglq702 '",tm.o,"' '' '' '",g_lang,"' 'Y' '' '' '",l_wc1 CLIPPED,"' '",l_wc2 CLIPPED,"' '",l_bdate,"' '",l_edate,"' '",tm.a,"' 'N' '",tm.b,"' '' '' '' ''" #TQC-930163
   #LET g_msg = "gglq702 '",tm.o,"' '' '' '",g_lang,"' 'Y' '' '' '",l_wc1 CLIPPED,"' '",l_wc2 CLIPPED,"' '",l_bdate,"' '",l_edate,"' '",tm.a,"' '",tm.c,"' '",tm.b,"' '",l_flag3,"' '' '' '' ''" #TQC-930163  #FUN-C80102  mark
   LET g_msg = "gglq702 '",tm.o,"' '' '' '",g_lang,"' 'Y' '' '' '",l_wc1 CLIPPED,"' '",l_wc2 CLIPPED,"' '",l_bdate,"' '",l_edate,"' '",tm.a,"' '",tm.f,"' '",tm.b,"' '",l_flag3,"' '' '' '' '' '' '",tm.g,"' '",tm.i,"'"  #FUN-C80102  add  #FUN-D40044 add tm.i
  #LET g_msg = 'gglq702 "',tm.o,'" "" "" "',g_lang,'" "Y" "" "" "',l_wc1 CLIPPED,'" "',l_wc2 CLIPPED,'" "',l_bdate,'" "',l_edate,'" "',tm.a,'" "N" "Y" "" "" "" ""'
   CALL cl_cmdrun(g_msg)

END FUNCTION

#TQC-930163 --begin
FUNCTION gglq701_t()
   #IF tm.c = 'Y' THEN   #FUN-C80102  mark
   IF tm.e = 'Y' THEN    #FUN-C80102  add
      CALL cl_set_comp_visible("ted09,pb_balf,abb25_pb,df,abb25_d,cf,abb25_c,balf,abb25_bal",TRUE)
      CALL cl_getmsg("ggl-216",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pb_balf",g_msg CLIPPED)
      CALL cl_getmsg("ggl-217",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pb_bal",g_msg CLIPPED)
      CALL cl_getmsg("ggl-201",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("df",g_msg CLIPPED)
      CALL cl_getmsg("ggl-202",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("d",g_msg CLIPPED)
      CALL cl_getmsg("ggl-203",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("cf",g_msg CLIPPED)
      CALL cl_getmsg("ggl-204",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("c",g_msg CLIPPED)
      CALL cl_getmsg("ggl-205",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("balf",g_msg CLIPPED)
      CALL cl_getmsg("ggl-206",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("bal",g_msg CLIPPED)
   ELSE
      CALL cl_set_comp_visible("ted09,pb_balf,abb25_pb,df,abb25_d,cf,abb25_c,balf,abb25_bal",FALSE)
      CALL cl_getmsg("ggl-213",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pb_bal",g_msg CLIPPED)
      CALL cl_getmsg("ggl-207",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("d",g_msg CLIPPED)
      CALL cl_getmsg("ggl-208",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("c",g_msg CLIPPED)
      CALL cl_getmsg("ggl-209",g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("bal",g_msg CLIPPED)
   END IF

END FUNCTION
#TQC-930163 --end

#FUN-D30014--mark--str--
#FUNCTION gglq701()
#  DEFINE l_name             LIKE type_file.chr20,
#         #l_sql              LIKE type_file.chr1000,
#         #l_sql1             LIKE type_file.chr1000,
#         l_sql              STRING,      #NO.FUN-910082
#         l_sql1             STRING,     #NO.FUN-910082
#         l_aed              LIKE type_file.chr1000,
#         l_abb              LIKE type_file.chr1000,
#         l_i                LIKE type_file.num5,
#         qc_aed05           LIKE aed_file.aed05,  #期初
#         qc_aed06           LIKE aed_file.aed06,
#         qj_aed05           LIKE aed_file.aed05,  #期間
#         qj_aed06           LIKE aed_file.aed06,
#         l_aed05            LIKE aed_file.aed05,
#         l_aed06            LIKE aed_file.aed06,
#         l_aed02            LIKE aed_file.aed02,
#         l_gaq01            LIKE gaq_file.gaq01,
#         l_aag01_str        LIKE type_file.chr50,
#         l_ahe02_d          LIKE ze_file.ze03,
#No.FUN-8B0106  add start
#         l_cnt                        LIKE type_file.num5,
#         t_bal                        LIKE aed_file.aed05,
#         n_bal                        LIKE aed_file.aed05,
#         n_pb_bal                     LIKE aed_file.aed05,
#         l_pb_dc                      LIKE type_file.chr10,
#         l_dc                         LIKE type_file.chr10,
#No.FUN-8B0106 add end
#         #No.CHI-C70031  --Begin
#         l_aeh11                      LIKE aeh_file.aeh11,
#         l_aeh12                      LIKE aeh_file.aeh12,
#         l_aeh15                      LIKE aeh_file.aeh15,
#         l_aeh16                      LIKE aeh_file.aeh16,
#         l_aaa09                      LIKE aaa_file.aaa09,
#         l_aeh03                      LIKE aeh_file.aeh03,
#         l_aeh04                      LIKE aeh_file.aeh04,
#         l_aeh05                      LIKE aeh_file.aeh05,
#         l_aeh06                      LIKE aeh_file.aeh06,
#         l_aeh07                      LIKE aeh_file.aeh07,
#         l_aeh31                      LIKE aeh_file.aeh31,
#         l_aeh32                      LIKE aeh_file.aeh32,
#         l_aeh33                      LIKE aeh_file.aeh33,
#         l_aeh34                      LIKE aeh_file.aeh34,
#         l_aeh35                      LIKE aeh_file.aeh35,
#         l_aeh36                      LIKE aeh_file.aeh36,
#         l_aeh37                      LIKE aeh_file.aeh37,
#         #No.CHI-C70031  --End
#         sr1                RECORD
#                            aag01    LIKE aag_file.aag01,
#                            aag02    LIKE aag_file.aag02
#                            END RECORD,
#         sr                 RECORD
#                            aed01    LIKE aed_file.aed01,
#                            aag02    LIKE aag_file.aag02,
#                            aed04    LIKE aed_file.aed04,
#                            aed02    LIKE aed_file.aed02,
#                            ahe02_d  LIKE ze_file.ze03,
#                            aed05    LIKE aed_file.aed05,
#                            aed06    LIKE aed_file.aed06,
#                            qcye     LIKE aed_file.aed05
#                            END RECORD,
#         l_field            LIKE     gaq_file.gaq01
#
#    CASE tm.a
#         WHEN '1'   LET l_field = 'abb11'
#                    LET l_gaq01 = 'aag15'
#                    LET g_aee02 ='1'        #No.TQC-C50211
#         WHEN '2'   LET l_field = 'abb12'
#                    LET l_gaq01 = 'aag16'
#                    LET g_aee02 ='2'        #No.TQC-C50211
#         WHEN '3'   LET l_field = 'abb13'
#                    LET l_gaq01 = 'aag17'
#                    LET g_aee02 ='3'        #No.TQC-C50211
#         WHEN '4'   LET l_field = 'abb14'
#                    LET l_gaq01 = 'aag18'
#                    LET g_aee02 ='4'        #No.TQC-C50211
#         WHEN '5'   LET l_field = 'abb31'
#                    LET l_gaq01 = 'aag31'
#                    LET g_aee02 ='5'        #No.TQC-C50211
#         WHEN '6'   LET l_field = 'abb32'
#                    LET l_gaq01 = 'aag32'
#                    LET g_aee02 ='6'        #No.TQC-C50211
#         WHEN '7'   LET l_field = 'abb33'
#                    LET l_gaq01 = 'aag33'
#                    LET g_aee02 ='7'        #No.TQC-C50211
#         WHEN '8'   LET l_field = 'abb34'
#                    LET l_gaq01 = 'aag34'
#                    LET g_aee02 ='8'        #No.TQC-C50211
#         WHEN '9'   LET l_field = 'abb35'
#                    LET l_gaq01 = 'aag35'
#                    LET g_aee02 ='9'        #No.TQC-C50211
#         WHEN '10'  LET l_field = 'abb36'
#                    LET l_gaq01 = 'aag36'
#                    LET g_aee02 ='10'        #No.TQC-C50211
#         #WHEN '11'  LET l_field = 'abb37'   #MOD-C50145 mark
#         WHEN '99'  LET l_field = 'abb37'    #MOD-C50145
#                    LET l_gaq01 = 'aag37'
#                    LET g_aee02 ='99'        #No.TQC-C50211
#    END CASE
#    #FUN-C80102--mark--str--
#    #IF tm.b = 'N' THEN
#    #   LET l_field = NULL
#    #END IF
#    #FUN-C80102--mark--end--
#    CALL gglq701_table()
#    SELECT zo02 INTO g_company FROM zo_file
#     WHERE zo01 = g_rlang
#
#    #科目
#    LET tm.wc = cl_replace_str(tm.wc,"aed01","aag01")      #FUN-C80102 add
#    LET l_sql = " SELECT aag01,aag02 FROM aag_file ",
#                "  WHERE aag00 = '",tm.o,"'",
#                "    AND ",tm.wc CLIPPED
#    PREPARE gglq701_pr1 FROM l_sql
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_aag01_cs CURSOR FOR gglq701_pr1
#
#    #核算項
#    LET l_sql1 = "SELECT UNIQUE aed02 FROM aed_file ",
#                 " WHERE aed00 = '",tm.o,"'",
#                 "   AND aed01 LIKE ? ",           #科目
#                 "   AND aed011 = '",tm.a,"'"
#    #FUN-C80102--mark--str--
#    #FUN-C80102--add--str--
#    #IF tm.g = 'Y' THEN
#    #   LET l_sql1 = l_sql1 CLIPPED,
#    #                " UNION ",
#    #                " SELECT ",l_field CLIPPED," FROM aba_file,abb_file",
#    #                "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                "    AND aba00 = '",tm.o,"'",
#    #                "    AND abb03 LIKE ? ",       #科目
#    #                "    AND ",l_field CLIPPED," IS NOT NULL"
#    #END IF
#    ##FUN-C80102--add--end--
#    #IF tm.g = 'N' THEN    #FUN-C80102  add
#    ##IF tm.b = 'Y' THEN   #FUN-C80102  mark
#    #   IF tm.b = '1' THEN    #FUN-C80102  add
#    #      LET l_sql1 = l_sql1 CLIPPED,
#    #                   " UNION ",
#    #                   " SELECT ",l_field CLIPPED," FROM aba_file,abb_file",
#    #                   "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                   "    AND aba00 = '",tm.o,"'",
#    #                   "    AND abb03 LIKE ? ",       #科目
#    #                   "    AND ",l_field CLIPPED," IS NOT NULL",
#    #                   #"    AND aba19 = 'Y'   AND abapost = 'N'"   #FUN-C80102   mark
#    #                   "    AND aba19 = 'Y' "       #FUN-C80102  add
#    #   #FUN-C80102--add--str--
#    #   ELSE
#    #      LET l_sql1 = l_sql1 CLIPPED,
#    #                   " UNION ",
#    #                   " SELECT ",l_field CLIPPED," FROM aba_file,abb_file",
#    #                   "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                   "    AND aba00 = '",tm.o,"'",
#    #                   "    AND abb03 LIKE ? ",       #科目
#    #                   "    AND ",l_field CLIPPED," IS NOT NULL",
#    #                   "    AND aba19 = 'Y'   AND abapost = 'Y'"
#    #   END IF
#    #   #FUN-C80102--add--end--
#    #END IF
#    #FUN-C80102--mark--end--

#    #FUN-C80102--add--str--
#    LET l_sql1 = l_sql1 CLIPPED,
#                    " UNION ",
#                    " SELECT ",l_field CLIPPED," FROM aba_file,abb_file",
#                    "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#                    "    AND aba00 = '",tm.o,"'",
#                    "    AND abb03 LIKE ? ",       #科目
#                    "    AND ",l_field CLIPPED," IS NOT NULL"
#    IF tm.g ='Y' THEN
#       IF tm.b = '1' THEN
#          LET l_sql1 = l_sql1,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
#       ELSE
#          LET l_sql1 = l_sql1,"  AND aba19 = 'N'"
#       END IF
#    END IF
#    IF tm.g ='N' THEN
#       IF tm.b = '1' THEN
#          LET l_sql1 = l_sql1," AND (aba19 ='Y' and abapost = 'N') "
#       ELSE
#          LET l_sql1 = l_sql1," AND  aba19 = 1 "
#       END IF
#    END IF
#    #FUN-C80102--add--end--
#
#    PREPARE gglq701_aed02_p FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_aed02_cs CURSOR FOR gglq701_aed02_p
#
#    #共用條件
#    LET l_aed = "SELECT SUM(aed05),SUM(aed06) FROM aed_file",
#                " WHERE aed00 = '",tm.o,"'",
#                "   AND aed01 LIKE ? ",                #科目
#                "   AND aed02 = ? ",                   #核算項
#                "   AND aed011 = '",tm.a,"'",
#                "   AND aed03 = ",tm.yy
#    #FUN-C80102--mark--str--
#    #IF tm.g = 'Y' THEN
#    #   LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #               "    AND aba00 = '",tm.o,"'",
#    #               "    AND abb03 LIKE ?   ",             #科目
#    #               "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #               "    AND aba03 = ",tm.yy
#    #END IF
#    #IF tm.g = 'N' THEN      #FUN-C80102  add
#    #   IF tm.b = '1' THEN   #FUN-C80102  add
#    #      LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                  "    AND aba00 = '",tm.o,"'",
#    #                  "    AND abb03 LIKE ?   ",             #科目
#    #                  "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #                  "    AND aba03 = ",tm.yy,
#    #                  #"    AND aba19 = 'Y'   AND abapost = 'N'"  #未過帳   #FUN-C80102  mark
#    #                  "    AND aba19 = 'Y'   "   #FUN-C80102  add
#    ##FUN-C80102--add--str--
#    #   ELSE
#    #      LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#    #                  "    AND aba00 = '",tm.o,"'",
#    #                  "    AND abb03 LIKE ?   ",             #科目
#    #                  "    AND ",l_field CLIPPED," = ? ",    #核算項值
#    #                  "    AND aba03 = ",tm.yy,
#    #                  "    AND aba19 = 'Y'   AND abapost = 'Y'"  #未過帳
#    #   END IF
#    #END IF
#    #FUN-C80102--add--end--
#    #FUN-C80102--mark--end--

#    #FUN-C80102--add--str--
#    LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
#                "    AND aba00 = '",tm.o,"'",
#                "    AND abb03 LIKE ?   ",             #科目
#                "    AND ",l_field CLIPPED," = ? ",    #核算項值
#                "    AND aba03 = ",tm.yy
#    IF tm.g ='Y' THEN
#       IF tm.b = '1' THEN
#          LET l_abb = l_abb,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
#       ELSE
#          LET l_abb = l_abb,"  AND aba19 = 'N'"
#       END IF
#    END IF
#    IF tm.g ='N' THEN
#       IF tm.b = '1' THEN
#          LET l_abb = l_abb," AND (aba19 ='Y' and abapost = 'N') "
#       ELSE
#          LET l_abb = l_abb," AND  aba19 = 1 "
#       END IF
#    END IF
#    #FUN-C80102--add--end--
#
#    #當期異動
#    LET l_sql1 = l_aed CLIPPED, "   AND aed04 = ? "  #當期
#    #IF tm.b = 'Y' THEN   #FUN-C80102  mark
#       LET l_sql1 = l_sql1 CLIPPED,
#                    " UNION ",
#                    #未過帳 - 借
#                    " SELECT SUM(abb07),0 FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '1' ",
#                    "    AND aba04 = ?   ",              #當期未過帳資料
#                    " UNION ",
#                    #未過帳 - 貸
#                    " SELECT 0,SUM(abb07) FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '2' ",
#                    "    AND aba04 = ?   "               #當期未過帳資料
#    #END IF   #FUN-C80102  mark
#    PREPARE gglq701_qj_p FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_qj_cs CURSOR FOR gglq701_qj_p
#
#    #期初余額
#    LET l_sql1 = l_aed CLIPPED, "   AND aed04 < ? "  #期初
#    #IF tm.b = 'Y' THEN   #FUN-C80102  mark
#       LET l_sql1 = l_sql1 CLIPPED,
#                    " UNION ",
#                    #未過帳 - 借
#                    " SELECT SUM(abb07),0 FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '1' ",
#                    "    AND aba04 < ?   ",              #期初未過帳資料
#                    " UNION ",
#                    #未過帳 - 貸
#                    " SELECT 0,SUM(abb07) FROM aba_file,abb_file ",l_abb CLIPPED,
#                    "    AND abb06 = '2' ",
#                    "    AND aba04 < ?   "               #期初未過帳資料
#    #END IF     #FUN-C80102  mark
#    PREPARE gglq701_qc_p FROM l_sql1
#    IF SQLCA.sqlcode != 0 THEN
#       CALL cl_err('prepare:',SQLCA.sqlcode,1)
#       CALL cl_used(g_prog,g_time,2) RETURNING g_time
#       EXIT PROGRAM
#    END IF
#    DECLARE gglq701_qc_cs CURSOR FOR gglq701_qc_p
#
#    ##TQC-930163 --begin
#   ##查找核算項值
#   # LET l_sql1 = " SELECT ",l_gaq01 CLIPPED," FROM aag_file ",
#   #              "  WHERE aag00 = '",tm.o,"'",
#   #              "    AND aag01 LIKE ? ",
#   #              "    AND aag07 IN ('2','3') ",
#   #              "    AND ",l_gaq01 CLIPPED," IS NOT NULL"
#   # PREPARE gglq701_gaq01_p FROM l_sql1
#   # IF SQLCA.sqlcode != 0 THEN
#   #    CALL cl_err('prepare:',SQLCA.sqlcode,1)
#   #    CALL cl_used(g_prog,g_time,2) RETURNING g_time
#   #    EXIT PROGRAM
#   # END IF
#   # DECLARE gglq701_gaq01_cs SCROLL CURSOR FOR gglq701_gaq01_p  #只能取第一個
#    ##TQC-930163 --end
#
#     LET g_pageno  = 0                                 #FUN-8B0106 MARK
#     CALL cl_outnam('gglq701') RETURNING l_name        #FUN-8B0106 MARK
#     START REPORT gglq701_rep TO l_name                #FUN-8B0106 MARK
#
#    FOREACH gglq701_aag01_cs INTO sr1.*  #科目
#      IF SQLCA.sqlcode THEN
#         CALL cl_err('gglq701_aag01_cs foreach:',SQLCA.sqlcode,0) EXIT FOREACH
#      END IF
#
#      #此作業也要打印統治科目的金額，但是aed/abb中都存放得是明細或是獨立科目
#      #所以要用LIKE的方式，取出統治科目對應的明細科目的金額
#      #此作業的前提，明細科目的前幾碼一定和其上屬統治相同 ruled by 蔡曉峰
#      IF cl_null(sr1.aag01) THEN CONTINUE FOREACH END IF
#      LET l_aag01_str = sr1.aag01 CLIPPED,'\%'    #No.MOD-940388

#      #FUN-C80102--mark--str--
#      #IF tm.b = 'N' THEN   #FUN-C80102  mark
#      #   FOREACH gglq701_aed02_cs USING l_aag01_str
#      #                            INTO l_aed02
#      #     IF SQLCA.sqlcode THEN
#      #        CALL cl_err('gglq701_aed02_cs foreach:',SQLCA.sqlcode,0)
#      #        EXIT FOREACH
#      #     END IF
#      #      #No.CHI-C70031  --Begin
#      #     LET  l_aeh04  =  NULL
#      #     LET  l_aeh05  =  NULL
#      #     LET  l_aeh06  =  NULL
#      #     LET  l_aeh07  =  NULL
#      #     LET  l_aeh31  =  NULL
#      #     LET  l_aeh32  =  NULL
#      #     LET  l_aeh33  =  NULL
#      #     LET  l_aeh34  =  NULL
#      #     LET  l_aeh35  =  NULL
#      #     LET  l_aeh36  =  NULL
#      #     LET  l_aeh37  =  NULL
#      #     CASE tm.a
#      #         WHEN '1' LET l_aeh04 = l_aed02
#      #         WHEN '2' LET l_aeh05 = l_aed02
#      #         WHEN '3' LET l_aeh06 = l_aed02
#      #         WHEN '4' LET l_aeh07 = l_aed02
#      #         WHEN '5' LET l_aeh31 = l_aed02
#      #         WHEN '6' LET l_aeh32 = l_aed02
#      #         WHEN '7' LET l_aeh33 = l_aed02
#      #         WHEN '8' LET l_aeh34 = l_aed02
#      #         WHEN '9' LET l_aeh35 = l_aed02
#      #         WHEN '10' LET l_aeh36 = l_aed02
#      #      WHEN '99' LET l_aeh37 =l_aed02
#      #     END CASE
#      #     #No.CHI-C70031  --End
#      #     FOR l_i = tm.m1 TO tm.m2
#      #         LET qc_aed05 = 0  #期初
#      #         LET qc_aed06 = 0
#      #         LET qj_aed05 = 0  #期間
#      #         LET qj_aed06 = 0
#      #         FOREACH gglq701_qc_cs USING l_aag01_str,l_aed02,l_i
#      #                               INTO l_aed05,l_aed06
#      #           IF SQLCA.sqlcode THEN
#      #              CALL cl_err('gglq701_aed02_cs foreach:',SQLCA.sqlcode,0)
#      #              EXIT FOREACH
#      #           END IF
#      #           IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
#      #           IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF
#      #           #No.CHI-C70031  --Begin
#      #           SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#      #           LET l_aeh11 = 0
#      #           LET l_aeh12 = 0
#      #           CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#      #           l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#      #           0,       l_i-1,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
#      #           l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#      #           RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#      #          #No.CHI-C70031  --End
#      #           LET qc_aed05 = qc_aed05 + l_aed05-l_aeh11  #CHL-C70031 add l_aeh11
#      #           LET qc_aed06 = qc_aed06 + l_aed06-l_aeh12  #CHL-C70031 add l_aeh12
#      #         END FOREACH
#      #         LET g_print = 'N'
#      #         FOREACH gglq701_qj_cs USING l_aag01_str,l_aed02,l_i
#      #                               INTO l_aed05,l_aed06
#      #           IF SQLCA.sqlcode THEN
#      #              CALL cl_err('foreach:',SQLCA.sqlcode,0)
#      #              EXIT FOREACH
#      #           END IF
#      #           IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
#      #           IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF
#      #           #No.CHI-C70031  --Begin
#      #           SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#      #           LET l_aeh11 = 0
#      #           LET l_aeh12 = 0
#      #           CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#      #           l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#      #           l_i,       l_i,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
#      #           l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#      #           RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#      #           #No.CHI-C70031  --End
#      #           LET qj_aed05 = qj_aed05 + l_aed05-l_aeh11     #CHL-C70031 add l_aeh11
#      #           LET qj_aed06 = qj_aed06 + l_aed06-l_aeh12     #CHL-C70031 add l_aeh12
#      #           LET g_print = 'Y'
#      #         END FOREACH
#      #         #無期初也沒有本期異動，則不打印
#      #         IF qc_aed05 = 0 AND qc_aed06 = 0 AND
#      #            qj_aed05 = 0 AND qj_aed06 = 0 THEN
#      #            CONTINUE FOR
#      #         END IF
#
#      #         #取核算項名稱
#      ##       CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163 #No.TQC-C50211 mark
#      #        CALL gglq701_get_ahe02(sr1.aag01,l_aed02,l_gaq01) #TQC-930163   #No.TQC-C50211
#      #              RETURNING l_ahe02_d
#      #         INITIALIZE sr.* TO NULL
#      #         LET sr.aed01  = sr1.aag01
#      #         LET sr.aag02  = sr1.aag02
#      #         LET sr.aed04  = l_i
#      #         LET sr.aed02  = l_aed02
#      #         LET sr.ahe02_d  = l_ahe02_d
#      #         LET sr.aed05 = qj_aed05
#      #         LET sr.aed06 = qj_aed06
#      #         LET sr.qcye  = qc_aed05 - qc_aed06
#              # OUTPUT TO REPORT gglq701_rep(sr.*)        #FUN-8B0106 MARK
#
#No.FUN-8B0106  add start
#      #  IF cl_null(sr.aed05) THEN LET sr.aed05 = 0 END IF
#      #  IF cl_null(sr.aed06) THEN LET sr.aed06 = 0 END IF
#      #  LET t_bal   = sr.aed05 - sr.aed06 + sr.qcye
#
#      #  IF sr.qcye > 0 THEN
#      #     LET n_pb_bal = sr.qcye
#      #     CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#      #  ELSE
#      #     IF sr.qcye = 0 THEN
#      #        LET n_pb_bal = sr.qcye
#      #        CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#      #     ELSE
#      #        LET n_pb_bal = sr.qcye * -1
#      #        CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#      #     END IF
#      #  END IF
#
#      #  IF t_bal > 0 THEN
#      #     LET n_bal = t_bal
#      #     CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#      #  ELSE
#      #     IF t_bal = 0 THEN
#      #        LET n_bal = t_bal
#      #        CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#      #     ELSE
#      #        LET n_bal = t_bal * -1
#      #        CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#      #     END IF
#      #  END IF
#
#      # INSERT INTO gglq701_tmp
#      #  #TQC-930163 --begin
#      ## VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'2',
#      ##        l_pb_dc,n_pb_bal,'',sr.aed05,sr.aed06,l_dc,n_bal)
#      #  VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'','2',
#      #         l_pb_dc,0,0,n_pb_bal,'',0,0,sr.aed05,0,0,sr.aed06,l_dc,0,0,n_bal,
#      #         '','','') #No.TQC-B60052
#      #  #TQC-930163 --end
#No.FUN-8B0106 add end
#      #      END FOR
#      #   END FOREACH
#      #ELSE
#      #FUN-C80102--mark--str--
#         FOREACH gglq701_aed02_cs USING l_aag01_str,l_aag01_str
#                                  INTO l_aed02
#           IF SQLCA.sqlcode THEN
#              CALL cl_err('gglq701_aed02_cs foreach:',SQLCA.sqlcode,0)
#              EXIT FOREACH
#           END IF
#           #No.CHI-C70031  --Begin
#           LET  l_aeh04  =  NULL
#           LET  l_aeh05  =  NULL
#           LET  l_aeh06  =  NULL
#           LET  l_aeh07  =  NULL
#           LET  l_aeh31  =  NULL
#           LET  l_aeh32  =  NULL
#           LET  l_aeh33  =  NULL
#           LET  l_aeh34  =  NULL
#           LET  l_aeh35  =  NULL
#           LET  l_aeh36  =  NULL
#           LET  l_aeh37  =  NULL
#           CASE tm.a
#               WHEN '1' LET l_aeh04 = l_aed02
#               WHEN '2' LET l_aeh05 = l_aed02
#               WHEN '3' LET l_aeh06 = l_aed02
#               WHEN '4' LET l_aeh07 = l_aed02
#               WHEN '5' LET l_aeh31 = l_aed02
#               WHEN '6' LET l_aeh32 = l_aed02
#               WHEN '7' LET l_aeh33 = l_aed02
#               WHEN '8' LET l_aeh34 = l_aed02
#               WHEN '9' LET l_aeh35 = l_aed02
#               WHEN '10' LET l_aeh36 = l_aed02
#            WHEN '99' LET l_aeh37 =l_aed02
#           END CASE
#           #No.CHI-C70031  --End
#           FOR l_i = tm.m1 TO tm.m2
#               LET qc_aed05 = 0  #期初
#               LET qc_aed06 = 0
#               LET qj_aed05 = 0  #期間
#               LET qj_aed06 = 0
#               FOREACH gglq701_qc_cs USING l_aag01_str,l_aed02,l_i,
#                                           l_aag01_str,l_aed02,l_i,
#                                           l_aag01_str,l_aed02,l_i
#                                     INTO l_aed05,l_aed06
#                 IF SQLCA.sqlcode THEN
#                    CALL cl_err('gglq701_aed02_cs foreach:',SQLCA.sqlcode,0)
#                    EXIT FOREACH
#                 END IF
#                 #No.CHI-C70031  --Begin
#                 SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#                 LET l_aeh11 = 0
#                 LET l_aeh12 = 0
#                 CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#                 l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#                 0,       l_i-1,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
#                 l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#                 RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#                 #No.CHI-C70031  --End
#                 IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
#                 IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF
#                 LET qc_aed05 = qc_aed05 + l_aed05-l_aeh11     #CHL-C70031 add l_aeh11
#                 LET qc_aed06 = qc_aed06 + l_aed06-l_aeh12     #CHL-C70031 add l_aeh12
#               END FOREACH
#               LET g_print = 'N'
#               FOREACH gglq701_qj_cs USING l_aag01_str,l_aed02,l_i,
#                                           l_aag01_str,l_aed02,l_i,
#                                           l_aag01_str,l_aed02,l_i
#                                     INTO l_aed05,l_aed06
#                 IF SQLCA.sqlcode THEN
#                    CALL cl_err('foreach:',SQLCA.sqlcode,0)
#                    EXIT FOREACH
#                 END IF
#                 #No.CHI-C70031  --Begin
#                 SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
#                 LET l_aeh11 = 0
#                 LET l_aeh12 = 0
#                 CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
#                 l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
#                 l_i,       l_i,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
#                 l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
#                 RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
#                 #No.CHI-C70031  --End
#                 IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
#                 IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF
#                 LET qj_aed05 = qj_aed05 + l_aed05-l_aeh11   #CHL-C70031 add l_aeh11
#                 LET qj_aed06 = qj_aed06 + l_aed06-l_aeh12   #CHL-C70031 add l_aeh12
#                 LET g_print = 'Y'
#               END FOREACH
#               #無期初也沒有本期異動，則不打印
#               IF qc_aed05 = 0 AND qc_aed06 = 0 AND
#                  qj_aed05 = 0 AND qj_aed06 = 0 THEN
#                  CONTINUE FOR
#               END IF
#
#               #取核算項名稱
#               CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163 #No.TQC-C50211 mark
#               CALL gglq701_get_ahe02(sr1.aag01,l_aed02,l_gaq01) #TQC-930163   #No.TQC-C50211
#                    RETURNING l_ahe02_d
#               INITIALIZE sr.* TO NULL
#               LET sr.aed01  = sr1.aag01
#               LET sr.aag02  = sr1.aag02
#               LET sr.aed04  = l_i
#               LET sr.aed02  = l_aed02
#               LET sr.ahe02_d  = l_ahe02_d
#               LET sr.aed05 = qj_aed05
#               LET sr.aed06 = qj_aed06
#               LET sr.qcye  = qc_aed05 - qc_aed06
#              # OUTPUT TO REPORT gglq701_rep(sr.*)    #FUN-8B0106 MARK
#
#No.FUN-8B0106  add start
#        IF cl_null(sr.aed05) THEN LET sr.aed05 = 0 END IF
#        IF cl_null(sr.aed06) THEN LET sr.aed06 = 0 END IF
#        LET t_bal   = sr.aed05 - sr.aed06 + sr.qcye
#
#        IF sr.qcye > 0 THEN
#           LET n_pb_bal = sr.qcye
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
#        ELSE
#           IF sr.qcye = 0 THEN
#              LET n_pb_bal = sr.qcye
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
#           ELSE
#              LET n_pb_bal = sr.qcye * -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
#           END IF
#        END IF
#
#        IF t_bal > 0 THEN
#           LET n_bal = t_bal
#           CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
#        ELSE
#           IF t_bal = 0 THEN
#              LET n_bal = t_bal
#              CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
#           ELSE
#              LET n_bal = t_bal * -1
#              CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
#           END IF
#        END IF
#
#        INSERT INTO gglq701_tmp
#        #TQC-930163 --begin
#      # VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'2',
#      #        l_pb_dc,n_pb_bal,'',sr.aed05,sr.aed06,l_dc,n_bal)
#        VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'','2',
#               l_pb_dc,0,0,n_pb_bal,'',0,0,sr.aed05,0,0,sr.aed06,l_dc,0,0,n_bal,
#               '','','') #No.TQC-B60052
#        #TQC-930163 --end
#No.FUN-8B0106   add end
#            END FOR
#         END FOREACH
#      #END IF  #FUN-C80102  mark
#    END FOREACH
#     FINISH REPORT gglq701_rep                   #FUN-8B0106 MARK
#    CALL gglq701_tmp_sum()                       #No.FUN-A80034
#END FUNCTION
#FUN-D30014--mark--end--

#FUN-D30014----add--str--
FUNCTION gglq701v()
   DEFINE l_name             LIKE type_file.chr20,
          #l_sql              LIKE type_file.chr1000,
          #l_sql1             LIKE type_file.chr1000,
          l_sql              STRING,      #NO.FUN-910082
          l_sql1             STRING,     #NO.FUN-910082
          l_aed              LIKE type_file.chr1000,
          l_abb              LIKE type_file.chr1000,
          l_i                LIKE type_file.num5,
          qc_aed05           LIKE aed_file.aed05,  #期初
          qc_aed06           LIKE aed_file.aed06,
          qj_aed05           LIKE aed_file.aed05,  #期間
          qj_aed06           LIKE aed_file.aed06,
          l_aed05            LIKE aed_file.aed05,
          l_aed06            LIKE aed_file.aed06,
          l_aed02            LIKE aed_file.aed02,
          l_gaq01            LIKE gaq_file.gaq01,
          l_aag01_str        LIKE type_file.chr50,
          l_ahe02_d          LIKE ze_file.ze03,
#No.FUN-8B0106  add start
          l_cnt                        LIKE type_file.num5,
          t_bal                        LIKE aed_file.aed05,
	  n_bal                        LIKE aed_file.aed05,
          n_pb_bal                     LIKE aed_file.aed05,
          l_pb_dc                      LIKE type_file.chr10,
          l_dc                         LIKE type_file.chr10,
#No.FUN-8B0106 add end
          #No.CHI-C70031  --Begin
          l_aeh11                      LIKE aeh_file.aeh11,
          l_aeh12                      LIKE aeh_file.aeh12,
          l_aeh15                      LIKE aeh_file.aeh15,
          l_aeh16                      LIKE aeh_file.aeh16,
          l_aaa09                      LIKE aaa_file.aaa09,
          l_aeh03                      LIKE aeh_file.aeh03,
          l_aeh04                      LIKE aeh_file.aeh04,
          l_aeh05                      LIKE aeh_file.aeh05,
          l_aeh06                      LIKE aeh_file.aeh06,
          l_aeh07                      LIKE aeh_file.aeh07,
          l_aeh31                      LIKE aeh_file.aeh31,
          l_aeh32                      LIKE aeh_file.aeh32,
          l_aeh33                      LIKE aeh_file.aeh33,
          l_aeh34                      LIKE aeh_file.aeh34,
          l_aeh35                      LIKE aeh_file.aeh35,
          l_aeh36                      LIKE aeh_file.aeh36,
          l_aeh37                      LIKE aeh_file.aeh37,
          #No.CHI-C70031  --End
          sr1                RECORD
                             aag01    LIKE aag_file.aag01,
                             aag02    LIKE aag_file.aag02
                             END RECORD,
          sr                 RECORD
                             aed01    LIKE aed_file.aed01,
                             aag02    LIKE aag_file.aag02,
                             aed04    LIKE aed_file.aed04,
                             aed02    LIKE aed_file.aed02,
                             ahe02_d  LIKE ze_file.ze03,
                             aed05    LIKE aed_file.aed05,
                             aed06    LIKE aed_file.aed06,
                             qcye     LIKE aed_file.aed05
                             END RECORD,
          l_field            LIKE     gaq_file.gaq01

     CASE tm.a
          WHEN '1'   LET l_field = 'abb11'
                     LET l_gaq01 = 'aag15'
          WHEN '2'   LET l_field = 'abb12'
                     LET l_gaq01 = 'aag16'
          WHEN '3'   LET l_field = 'abb13'
                     LET l_gaq01 = 'aag17'
          WHEN '4'   LET l_field = 'abb14'
                     LET l_gaq01 = 'aag18'
          WHEN '5'   LET l_field = 'abb31'
                     LET l_gaq01 = 'aag31'
          WHEN '6'   LET l_field = 'abb32'
                     LET l_gaq01 = 'aag32'
          WHEN '7'   LET l_field = 'abb33'
                     LET l_gaq01 = 'aag33'
          WHEN '8'   LET l_field = 'abb34'
                     LET l_gaq01 = 'aag34'
          WHEN '9'   LET l_field = 'abb35'
                     LET l_gaq01 = 'aag35'
          WHEN '10'  LET l_field = 'abb36'
                     LET l_gaq01 = 'aag36'
          #WHEN '11'  LET l_field = 'abb37'    #FUN-C80102 mark
          WHEN '99'  LET l_field = 'abb37'     #FUN-C80102 add
                     LET l_gaq01 = 'aag37'
     END CASE

     DISPLAY "START TIME:",TIME
     CALL gglq701_table()
     SELECT zo02 INTO g_company FROM zo_file
      WHERE zo01 = g_rlang

     #科目和核算項
     LET tm.wc = cl_replace_str(tm.wc,"aed01","aag01")      #yangtt 130217
     LET l_sql1 = "SELECT UNIQUE aag01,aag02,aed02 FROM aag_file,aed_file ", #TQC-D60028 ''->aag02
                  " WHERE aag00 = aed00 AND aed00 = '",tm.o,"'",
                  "    AND ",tm.wc CLIPPED,
                  "   AND aed01 LIKE aag01||'%' ",           #科目
                  "   AND aed011 = '",tm.a,"'"
     LET tm.wc = cl_replace_str(tm.wc,"aed02",l_field)     #MOD-E20114
     LET l_sql1 = l_sql1 CLIPPED,
                     " UNION ",
                     " SELECT aag01,aag02,",l_field CLIPPED," FROM aag_file,aba_file,abb_file",#TQC-D60028 ''->aag02
                     "  WHERE aag00 = aba00 AND aba00 = abb00 AND aba01 = abb01 ",
                     "    AND ",tm.wc CLIPPED,
                     "    AND aba00 = '",tm.o,"'",
                     "    AND abb03 LIKE aag01||'%' ",       #科目
                     "    AND ",l_field CLIPPED," IS NOT NULL"
     IF tm.g ='Y' THEN
        IF tm.b = '1' THEN
           LET l_sql1 = l_sql1,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
        ELSE
           LET l_sql1 = l_sql1,"  AND aba19 = 'N'"
        END IF
     END IF
     IF tm.g ='N' THEN
        IF tm.b = '1' THEN
           LET l_sql1 = l_sql1," AND (aba19 ='Y' and abapost = 'N') "
        ELSE
     #      LET l_sql1 = l_sql1," AND  aba19 = 1 "  #mark by kuangxj150319
            LET l_sql1 = l_sql1," AND  abapost = 'Y' "  #add by kuangxj150319
        END IF
     END IF
     #lujh 1219--add--end--

     PREPARE gglq701_aed02_p FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_aed02_cs CURSOR FOR gglq701_aed02_p

     #共用條件
     LET l_aed = "SELECT SUM(aed05),SUM(aed06) FROM aed_file",
                 " WHERE aed00 = '",tm.o,"'",
                 "   AND aed01 LIKE ? ",                #科目
                 "   AND aed02 = ? ",                   #核算項
                 "   AND aed011 = '",tm.a,"'",
                 "   AND aed03 = ",tm.yy

     #lujh 1219--add--str--
     LET l_abb = "  WHERE aba00 = abb00 AND aba01 = abb01 ",
                 "    AND aba00 = '",tm.o,"'",
                 "    AND abb03 LIKE ?   ",             #科目
                 "    AND ",l_field CLIPPED," = ? ",    #核算項值
                 "    AND aba03 = ",tm.yy
     IF tm.g ='Y' THEN
        IF tm.b = '1' THEN
           LET l_abb = l_abb,"  AND (aba19 = 'N' OR ( aba19 ='Y' and abapost = 'N'))"
        ELSE
           LET l_abb = l_abb,"  AND aba19 = 'N'"
        END IF
     END IF
     IF tm.g ='N' THEN
        IF tm.b = '1' THEN
           LET l_abb = l_abb," AND (aba19 ='Y' and abapost = 'N') "
        ELSE
      #     LET l_abb = l_abb," AND  aba19 = 1 "  #mark by kuangxj150319
           LET l_abb = l_abb," AND  abapost =  'Y' "  #add by kuangxj150319
        END IF
     END IF
     #lujh 1219--add--end--

     #當期異動
     LET l_sql1 = l_aed CLIPPED, "   AND aed04 = ? "  #當期
     #IF tm.b = 'Y' THEN   #FUN-C80102  mark
        LET l_sql1 = l_sql1 CLIPPED,
                     " UNION ",
                     #未過帳 - 借
                     " SELECT SUM(abb07),0 FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '1' ",
                     "    AND aba04 = ?   ",              #當期未過帳資料
                     " UNION ",
                     #未過帳 - 貸
                     " SELECT 0,SUM(abb07) FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '2' ",
                     "    AND aba04 = ?   "               #當期未過帳資料
     #END IF   #FUN-C80102  mark
     PREPARE gglq701_qj_p FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_qj_cs CURSOR FOR gglq701_qj_p

     #期初余額
     LET l_sql1 = l_aed CLIPPED, "   AND aed04 < ? "  #期初
     #IF tm.b = 'Y' THEN   #FUN-C80102  mark
        LET l_sql1 = l_sql1 CLIPPED,
                     " UNION ",
                     #未過帳 - 借
                     " SELECT SUM(abb07),0 FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '1' ",
                     "    AND aba04 < ?   ",              #期初未過帳資料
                     " UNION ",
                     #未過帳 - 貸
                     " SELECT 0,SUM(abb07) FROM aba_file,abb_file ",l_abb CLIPPED,
                     "    AND abb06 = '2' ",
                     "    AND aba04 < ?   "               #期初未過帳資料
     #END IF     #FUN-C80102  mark
     PREPARE gglq701_qc_p FROM l_sql1
     IF SQLCA.sqlcode != 0 THEN
        CALL cl_err('prepare:',SQLCA.sqlcode,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
     END IF
     DECLARE gglq701_qc_cs CURSOR FOR gglq701_qc_p

     FOREACH gglq701_aed02_cs INTO sr1.*,l_aed02  #科目
       IF SQLCA.sqlcode THEN
          CALL cl_err('gglq701_aag01_cs foreach:',SQLCA.sqlcode,0) EXIT FOREACH
       END IF

       #此作業也要打印統治科目的金額，但是aed/abb中都存放得是明細或是獨立科目
       #所以要用LIKE的方式，取出統治科目對應的明細科目的金額
       #此作業的前提，明細科目的前幾碼一定和其上屬統治相同 ruled by 蔡曉峰
       IF cl_null(sr1.aag01) THEN CONTINUE FOREACH END IF
       LET l_aag01_str = sr1.aag01 CLIPPED,'\%'    #No.MOD-940388

       #No.CHI-C70031  --Begin
       LET  l_aeh04  =  NULL
       LET  l_aeh05  =  NULL
       LET  l_aeh06  =  NULL
       LET  l_aeh07  =  NULL
       LET  l_aeh31  =  NULL
       LET  l_aeh32  =  NULL
       LET  l_aeh33  =  NULL
       LET  l_aeh34  =  NULL
       LET  l_aeh35  =  NULL
       LET  l_aeh36  =  NULL
       LET  l_aeh37  =  NULL
       CASE tm.a
           WHEN '1' LET l_aeh04 = l_aed02
           WHEN '2' LET l_aeh05 = l_aed02
           WHEN '3' LET l_aeh06 = l_aed02
           WHEN '4' LET l_aeh07 = l_aed02
           WHEN '5' LET l_aeh31 = l_aed02
           WHEN '6' LET l_aeh32 = l_aed02
           WHEN '7' LET l_aeh33 = l_aed02
           WHEN '8' LET l_aeh34 = l_aed02
           WHEN '9' LET l_aeh35 = l_aed02
           WHEN '10' LET l_aeh36 = l_aed02
           WHEN '99' LET l_aeh37 =l_aed02
        END CASE
        #No.CHI-C70031  --End
            FOR l_i = tm.m1 TO tm.m2
                LET qc_aed05 = 0  #期初
                LET qc_aed06 = 0
                LET qj_aed05 = 0  #期間
                LET qj_aed06 = 0
                #No.CHI-C70031  --Begin
                SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
                LET l_aeh11 = 0
                LET l_aeh12 = 0
                CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
                l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
                0,       l_i-1,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
                l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
                RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
                #No.CHI-C70031  --End
                FOREACH gglq701_qc_cs USING l_aag01_str,l_aed02,l_i,
                                            l_aag01_str,l_aed02,l_i,
                                            l_aag01_str,l_aed02,l_i
                                      INTO l_aed05,l_aed06
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('gglq701_aed02_cs foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF
                  IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
                  IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF

                  #LET qc_aed05 = qc_aed05 + l_aed05-l_aeh11     #CHL-C70031 add l_aeh11   #FUN-D40044 mark
                  #LET qc_aed06 = qc_aed06 + l_aed06-l_aeh12     #CHL-C70031 add l_aeh12   #FUN-D40044 mark
                  LET qc_aed05 = qc_aed05 + l_aed05    #FUN-D40044 add
                  LET qc_aed06 = qc_aed06 + l_aed06    #FUN-D40044 add

                END FOREACH

                #FUN-D40044--add--str--
                IF tm.i = 'N' THEN
                   LET qc_aed05 = qc_aed05-l_aeh11
                   LET qc_aed06 = qc_aed06-l_aeh12
                END IF
                #FUN-D40044--add--end--

                LET g_print = 'N'
                #No.CHI-C70031  --Begin
                SELECT aaa09 INTO l_aaa09 FROM aaa_file WHERE aaa01=tm.o
                LET l_aeh11 = 0
                LET l_aeh12 = 0
                CALL s_minus_ce(tm.o, l_aag01_str, l_aag01_str, NULL,NULL,NULL,
                l_aeh04,  l_aeh05,    l_aeh06,      l_aeh07,     NULL,    tm.yy,
                l_i,       l_i,       NULL,      l_aeh31,  l_aeh32,    l_aeh33,
                l_aeh34,  l_aeh35,      l_aeh36,    l_aeh37,     g_plant,  l_aaa09,'1')
                RETURNING  l_aeh11,l_aeh12,l_aeh15,l_aeh16
                #No.CHI-C70031  --End
                FOREACH gglq701_qj_cs USING l_aag01_str,l_aed02,l_i,
                                            l_aag01_str,l_aed02,l_i,
                                            l_aag01_str,l_aed02,l_i
                                      INTO l_aed05,l_aed06
                  IF SQLCA.sqlcode THEN
                     CALL cl_err('foreach:',SQLCA.sqlcode,0)
                     EXIT FOREACH
                  END IF
                  IF cl_null(l_aed05) THEN LET l_aed05 = 0 END IF
                  IF cl_null(l_aed06) THEN LET l_aed06 = 0 END IF

                  #LET qj_aed05 = qj_aed05 + l_aed05-l_aeh11   #CHL-C70031 add l_aeh11  #FUN-D40044 mark
                  #LET qj_aed06 = qj_aed06 + l_aed06-l_aeh12   #CHL-C70031 add l_aeh12  #FUN-D40044

                  LET qj_aed05 = qj_aed05 + l_aed05   #FUN-D40044 add
                  LET qj_aed06 = qj_aed06 + l_aed06   #FUN-D40044 add

                  LET g_print = 'Y'
                END FOREACH

                #FUN-D40044--add--str--
                IF tm.i = 'N' THEN
                   LET qj_aed05 = qj_aed05-l_aeh11
                   LET qj_aed06 = qj_aed06-l_aeh12
                END IF
                #FUN-D40044--add--end--

                #無期初也沒有本期異動，則不打印
                IF qc_aed05 = 0 AND qc_aed06 = 0 AND
                   qj_aed05 = 0 AND qj_aed06 = 0 THEN
                   CONTINUE FOR
                END IF

                #取核算項名稱
               #CALL gglq701_get_ahe02(l_aag01_str,l_aed02,l_gaq01) #TQC-930163 #MOD-E30064 mark
                CALL gglq701_get_ahe02(sr1.aag01,l_aed02,l_gaq01) #TQC-930163 #MOD-E30064
                     RETURNING l_ahe02_d
                INITIALIZE sr.* TO NULL
                LET sr.aed01  = sr1.aag01
                LET sr.aag02  = sr1.aag02
                LET sr.aed04  = l_i
                LET sr.aed02  = l_aed02
                LET sr.ahe02_d  = l_ahe02_d
                LET sr.aed05 = qj_aed05
                LET sr.aed06 = qj_aed06
                LET sr.qcye  = qc_aed05 - qc_aed06

         IF cl_null(sr.aed05) THEN LET sr.aed05 = 0 END IF
         IF cl_null(sr.aed06) THEN LET sr.aed06 = 0 END IF
         LET t_bal   = sr.aed05 - sr.aed06 + sr.qcye

         IF sr.qcye > 0 THEN
            LET n_pb_bal = sr.qcye
            CALL cl_getmsg('ggl-211',g_lang) RETURNING l_pb_dc
         ELSE
            IF sr.qcye = 0 THEN
               LET n_pb_bal = sr.qcye
               CALL cl_getmsg('ggl-210',g_lang) RETURNING l_pb_dc
            ELSE
               LET n_pb_bal = sr.qcye * -1
               CALL cl_getmsg('ggl-212',g_lang) RETURNING l_pb_dc
            END IF
         END IF

         IF t_bal > 0 THEN
            LET n_bal = t_bal
            CALL cl_getmsg('ggl-211',g_lang) RETURNING l_dc
         ELSE
            IF t_bal = 0 THEN
               LET n_bal = t_bal
               CALL cl_getmsg('ggl-210',g_lang) RETURNING l_dc
            ELSE
               LET n_bal = t_bal * -1
               CALL cl_getmsg('ggl-212',g_lang) RETURNING l_dc
            END IF
         END IF

         INSERT INTO gglq701_tmp
         VALUES(sr.aed01,sr.aag02,sr.aed04,sr.aed02,sr.ahe02_d,'','2',
                l_pb_dc,0,0,n_pb_bal,'',0,0,sr.aed05,0,0,sr.aed06,l_dc,0,0,n_bal,
                '','','')
             END FOR
     END FOREACH
     CALL gglq701_tmp_sum()                       #No.FUN-A80034
     DISPLAY "END TIME:",TIME
END FUNCTION
#FUN-D30014----add---end---

#No.FUN-A80034 --begin
FUNCTION gglq701_tmp_sum()
DEFINE l_aed01    LIKE aed_file.aed01
DEFINE l_aed04    LIKE aed_file.aed04
DEFINE l_aag02    LIKE aag_file.aag02
DEFINE l_df       LIKE ted_file.ted05
DEFINE l_cf       LIKE ted_file.ted05
DEFINE l_d        LIKE ted_file.ted05
DEFINE l_c        LIKE ted_file.ted05
DEFINE l_ted09    LIKE ted_file.ted09
DEFINE l_sqlc     STRING
DEFINE l_sqld     STRING
DEFINE l_abb07cf  LIKE abb_file.abb07f
DEFINE l_abb07df  LIKE abb_file.abb07f
DEFINE l_abb07c   LIKE abb_file.abb07
DEFINE l_abb07d   LIKE abb_file.abb07
DEFINE l_abb      LIKE type_file.chr1000
DEFINE l_msg      LIKE type_file.chr1000
DEFINE l_i        LIKE type_file.num5
DEFINE z_pb_bal   LIKE abb_file.abb07f #zhouxm170926 add
DEFINE z_bal      LIKE abb_file.abb07f #zhouxm170926 add

   #IF tm.c = 'N' THEN   #FUN-C80102  mark
   IF tm.e = 'N' THEN    #FUN-C80102  add
      LET g_sql = #"SELECT aed01,aag02,aed04,'',SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ",  #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                  "SELECT aed01,aag02,aed04,'',SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ",  #zhouxm170926 add ,SUM(pb_bal),SUM(bal)

                  "  FROM gglq701_tmp",
                  " GROUP BY aed01,aag02,aed04 ",
                  " ORDER BY aed01,aag02,aed04 "
   ELSE
      #IF tm.d ='Y' THEN    #FUN-C80102  mark
      IF tm.f ='Y' THEN     #FUN-C80102  add
         LET g_sql = #"SELECT aed01,aag02,aed04,ted09,SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                     "SELECT aed01,aag02,aed04,ted09,SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                     "  FROM gglq701_tmp",
                     " GROUP BY aed01,aag02,aed04,ted09 ",
                     " ORDER BY aed01,aag02,aed04,ted09 "
      ELSE
         LET g_sql = #"SELECT aed01,aag02,aed04,'',0,0,SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                     "SELECT aed01,aag02,aed04,'',0,0,SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                     "  FROM gglq701_tmp",
                     " GROUP BY aed01,aag02,aed04 ",
                     " ORDER BY aed01,aag02,aed04 "
      END IF
   END IF

   PREPARE gglq701_sum_mp FROM g_sql
   DECLARE gglq701_sum_m  CURSOR FOR gglq701_sum_mp
   CALL cl_getmsg('ggl-214',g_lang) RETURNING l_msg
   FOREACH gglq701_sum_m INTO l_aed01,l_aag02,l_aed04,l_ted09,l_df,l_cf,l_d,l_c,z_pb_bal,z_bal  #zhouxm170926 add ,z_pb_bal,z_bal
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      IF cl_null(l_c) THEN LET l_c =0 END IF
      IF cl_null(l_cf) THEN LET l_cf =0 END IF
      IF cl_null(l_d) THEN LET l_d =0 END IF
      IF cl_null(l_df) THEN LET l_cf =0 END IF
      IF cl_null(z_pb_bal) THEN LET z_pb_bal = 0 END IF  #zhouxm170926 add
      IF cl_null(z_bal) THEN LET z_bal = 0 END IF  #zhouxm170926 add
      #IF tm.d ='N' THEN     #FUN-C80102  mark
      IF tm.f ='N' THEN      #FUN-C80102  add
         LET l_cf = NULL
         LET l_df = NULL
      END IF
      INSERT INTO gglq701_tmp
      VALUES(l_aed01,l_aag02,l_aed04,l_msg,'',l_ted09,'3',
           #  '','','','','',l_df,'',l_d,l_cf,'',l_c,'','','','',  #zhouxm170926 mark
             '','','',z_pb_bal,'',l_df,'',l_d,l_cf,'',l_c,'','','',z_bal,  #zhouxm170926 add
             '','','') #No.TQC-B60052
   END FOREACH

   FOR l_i = tm.m1 TO tm.m2
       #IF tm.c = 'N' THEN     #FUN-C80102  mark
       IF tm.e = 'N' THEN      #FUN-C80102  add
          LET g_sql = #"SELECT aed01,aag02,'','',SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                      "SELECT aed01,aag02,'','',SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                      "  FROM gglq701_tmp",
                      " WHERE aed04 <= '",l_i,"'",
                      "   AND type <> '3' ",
                      "   AND type <> '4' ",
                      " GROUP BY aed01,aag02 ",
                      " ORDER BY aed01,aag02 "
       ELSE
       	  #IF tm.d ='Y' THEN    #FUN-C80102  mark
          IF tm.f ='Y' THEN     #FUN-C80102  add
             LET g_sql = #"SELECT aed01,aag02,'',ted09,SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                         "SELECT aed01,aag02,'',ted09,SUM(df),SUM(cf),SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                         "  FROM gglq701_tmp",
                         " WHERE aed04 <= '",l_i,"'",
                         "   AND type <> '3' ",
                         "   AND type <> '4' ",
                         " GROUP BY aed01,aag02,ted09 ",
                         " ORDER BY aed01,aag02,ted09 "
          ELSE
             LET g_sql = #"SELECT aed01,aag02,'','',0,0,SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when pb_dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                         "SELECT aed01,aag02,'','',0,0,SUM(d),SUM(c),SUM(case when pb_dc='借' then pb_bal else -pb_bal end),SUM(case when dc='借' then bal else -bal end) ", #zhouxm170926 add ,SUM(pb_bal),SUM(bal)
                         "  FROM gglq701_tmp",
                         " WHERE aed04 <= '",l_i,"'",
                         "   AND type <> '3' ",
                         "   AND type <> '4' ",
                         " GROUP BY aed01,aag02 ",
                         " ORDER BY aed01,aag02 "
          END IF
       END IF
       PREPARE gglq701_sum_yp FROM g_sql
       DECLARE gglq701_sum_y  CURSOR FOR gglq701_sum_yp
       CALL cl_getmsg('ggl-215',g_lang) RETURNING l_msg

       FOREACH gglq701_sum_y INTO l_aed01,l_aag02,l_aed04,l_ted09,l_df,l_cf,l_d,l_c,z_pb_bal,z_bal  #zhouxm170926 add ,z_pb_bal,z_bal
          IF SQLCA.sqlcode THEN
             CALL cl_err('foreach:',SQLCA.sqlcode,1)
             EXIT FOREACH
          END IF
          IF cl_null(l_c) THEN LET l_c =0 END IF
          IF cl_null(l_cf) THEN LET l_cf =0 END IF
          IF cl_null(l_d) THEN LET l_d =0 END IF
          IF cl_null(l_df) THEN LET l_cf =0 END IF
          IF cl_null(z_pb_bal) THEN LET z_pb_bal = 0 END IF  #zhouxm170926 add
          IF cl_null(z_bal) THEN LET z_bal = 0 END IF  #zhouxm170926 add
          #IF tm.d ='N' THEN    #FUN-C80102  mark
          IF tm.f ='N' THEN     #FUN-C80102  add
             LET l_cf = NULL
             LET l_df = NULL
          END IF
          LET l_aed04 = l_i
          INSERT INTO gglq701_tmp
          VALUES(l_aed01,l_aag02,l_aed04,l_msg,'',l_ted09,'4',
                # '','','','','',l_df,'',l_d,l_cf,'',l_c,'','','','', #zhouxm170926 mark
             '','','',z_pb_bal,'',l_df,'',l_d,l_cf,'',l_c,'','','',z_bal,  #zhouxm170926 add
                 '','','') #No.TQC-B60052
	     END FOREACH
	 END FOR
END FUNCTION
#No.FUN-A80034 --end
