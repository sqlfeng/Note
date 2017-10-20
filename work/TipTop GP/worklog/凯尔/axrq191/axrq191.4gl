# Prog. Version..: '5.30.06-13.03.12(00010)'     #
#
# Pattern name...: axrq191
# Descriptions...: 客戶應收帳齡分析查詢
# Date & Author..: No.FUN-B60071 2011/06/21 By lixia
# Modify.........: No.FUN-B60129 2011/06/24 By lixia 增加按鈕串查明細
# Modify.........: No.FUN-BB0038 11/11/14 By elva 简称由单据抓取
# Modify.........: No.TQC-C30324 12/03/29 By zhangll 起始運行時變動欄位為英文狀態，隱藏
# Modify.........: No.TQC-C30330 12/03/29 By zhangll 修改簡稱顯示不全問題
# Modify.........: No.TQC-C30333 12/03/30 By zhangll 日期默認帶出月底日期
# Modify.........: No.TQC-C30349 12/04/06 By lujh 增加幣別欄位
# Modify.........: No.TQC-C70036 12/07/04 By lujh 重新查詢時如點選退出，應只退出當前查詢窗口，而不是整支程序
# Modify.........: No.TQC-C40048 12/09/26 By wangwei "相關文件"按鈕
# Modify.........: No.FUN-C80102 12/12/11 By zhangweib 報表改善追單
# Modify.........: No.FUN-CB0146 13/01/07 By zhangweib 程序優化
# Modify.........: No.MOD-D50090 13/05/13 By yinhy 應收賬款日應判斷<=應收賬款截止日期
# Modify.........: No.MOD-D50237 13/05/28 By yinhy 抓取SUM(oox10)時加上日期的判斷
# Modify.........: No.yinhy140604 14/06/04 By yinhy 勾选原币时，l_alz07赋值
# Modify.........: No.2015030339  140323  By kuangxj 回收p_sser-流水号:2015030339 ，部分数据账龄统计不正确
# Modify.........: No.2015040184  150414  By kuangxj 回收p_sser-流水号: 2015040184
# Modify.........: No.2015040230  150519  By kuangxj 回收p_sser-流水号:2015040230
# Modify.........: No.TQC-G10002 17/08/23 By doris alz07 < edate 修改為 alz07 <= edate
DATABASE ds

GLOBALS "../../config/top.global"

DEFINE  g_oma  DYNAMIC ARRAY OF RECORD
                     oma03      LIKE oma_file.oma03,
                     oma032     LIKE oma_file.oma032,
                     oma00      LIKE oma_file.oma00,   #FUN-C80102
                     oma01      LIKE oma_file.oma01,
                     oma02      LIKE oma_file.oma02,
                     alz12      LIKE alz_file.alz12,   #FUN-C80102
                    #oma11      LIKE oma_file.oma11,   #FUN-C80102
                     alz07      LIKE alz_file.alz07,   #FUN-C80102
                     oma18      LIKE oma_file.oma18,   #FUN-C80102
                     aag02      LIKE aag_file.aag02,   #FUN-C80102
                     oma54t     LIKE oma_file.oma54t,  #FUN-C80102
                     oma55      LIKE oma_file.oma55,   #FUN-C80102
                     oma54t_oma55  LIKE oma_file.oma54t,   #FUN-C80102
                     sum_1      LIKE alz_file.alz09,  #FUN-C80102
                     sum_3      LIKE alz_file.alz09,  #FUN-C80102
                     oma56t     LIKE oma_file.oma56t,  #FUN-C80102
                     net        LIKE oox_file.oox10,   #FUN-C80102
                     oma57      LIKE oma_file.oma57,   #FUN-C80102
                     oma56t_oma57  LIKE oma_file.oma56t,   #FUN-C80102
                     sum_2      LIKE alz_file.alz09,  #FUN-C80102
                     sum_4      LIKE alz_file.alz09,  #FUN-C80102
                     sum_5      LIKE alz_file.alz09,  #FUN-C80102
                     sum01      LIKE alz_file.alz09,
                     sum1       LIKE alz_file.alz09,
                     sum02      LIKE alz_file.alz09,
                     sum2       LIKE alz_file.alz09,
                     sum03      LIKE alz_file.alz09,
                     sum3       LIKE alz_file.alz09,
                     sum04      LIKE alz_file.alz09,
                     sum4       LIKE alz_file.alz09,
                     sum05      LIKE alz_file.alz09,
                     sum5       LIKE alz_file.alz09,
                     sum06      LIKE alz_file.alz09,
                     sum6       LIKE alz_file.alz09,
                     sum07      LIKE alz_file.alz09,
                     sum7       LIKE alz_file.alz09,
                     sum08      LIKE alz_file.alz09,
                     sum8       LIKE alz_file.alz09,
                     sum09      LIKE alz_file.alz09,
                     sum9       LIKE alz_file.alz09,
                     sum010     LIKE alz_file.alz09,
                     sum10      LIKE alz_file.alz09,
                     sum011     LIKE alz_file.alz09,
                     sum11      LIKE alz_file.alz09,
                     sum012     LIKE alz_file.alz09,
                     sum12      LIKE alz_file.alz09,
                     sum013     LIKE alz_file.alz09,
                     sum13      LIKE alz_file.alz09,
                     sum014     LIKE alz_file.alz09,
                     sum14      LIKE alz_file.alz09,
                     sum015     LIKE alz_file.alz09,
                     sum15      LIKE alz_file.alz09,
                     sum016     LIKE alz_file.alz09,
                     sum16      LIKE alz_file.alz09,
                     sum017     LIKE alz_file.alz09,
                     sum17      LIKE alz_file.alz09,
                     oma10      LIKE oma_file.oma10,   #FUN-C80102
                     oma67      LIKE oma_file.oma67,   #FUN-C80102
                     oma33      LIKE oma_file.oma33,   #FUN-C80102
                     oma23      LIKE oma_file.oma23,   #TQC-C30349 add #用oma01的字段類型，方便單身"統計"2個字的正常顯示
                     azj041_1   LIKE azj_file.azj041,  #FUN-C80102
                     azj041     LIKE azj_file.azj041,  #FUN-C80102
                     oma15      LIKE oma_file.oma15,   #FUN-C80102
                     oma15_desc LIKE gem_file.gem01,   #FUN-C80102
                     oma14      LIKE oma_file.oma14,   #FUN-C80102
                     oma14_desc LIKE gen_file.gen01,   #FUN-C80102
                    #oma67      LIKE oma_file.oma67,   #FUN-C10057  #FUN-C80102 mark
                     oma68      LIKE oma_file.oma68,   #FUN-C80102
                     occ18      LIKE occ_file.occ18,   #FUN-C80102
                     occ03      LIKE occ_file.occ03,   #FUN-C80102
                     occ03_desc LIKE oca_file.oca02,   #FUN-C80102
                     oma08      LIKE oma_file.oma08,   #FUN-C80102
                     oma25      LIKE oma_file.oma25,   #FUN-C80102
                     oma26      LIKE oma_file.oma26,   #FUN-C80102
                     azp01      LIKE azp_file.azp01    #FUN-C80102
                    #sum        LIKE alz_file.alz09  #FUN-C80102 mark
               END RECORD
#FUN-C80102--add---str--
DEFINE  g_oma_1  DYNAMIC ARRAY OF RECORD
                     oma18      LIKE oma_file.oma18,
                     aag02      LIKE aag_file.aag02,
                     oma03      LIKE oma_file.oma03,
                     oma032     LIKE oma_file.oma032,
                     oma68      LIKE oma_file.oma68,
                     occ18      LIKE occ_file.occ18,
                     occ45      LIKE oag_file.oag02,
                     oma15      LIKE oma_file.oma15,
                     oma15_desc LIKE gem_file.gem01,
                     oma14      LIKE oma_file.oma14,
                     oma14_desc LIKE gen_file.gen01,
                     oma23      LIKE oma_file.oma25,
                     oma54t     LIKE oma_file.oma54t,
                     oma55      LIKE oma_file.oma55,
                     oma54t_oma55  LIKE oma_file.oma54t,
                     sum_1      LIKE alz_file.alz09,
                     sum_3      LIKE alz_file.alz09,
                     oma56t     LIKE oma_file.oma56t,
                     net        LIKE oox_file.oox10,
                     oma57      LIKE oma_file.oma57,
                     oma56t_oma57  LIKE oma_file.oma56t,
                     sum_2      LIKE alz_file.alz09,
                     sum_4      LIKE alz_file.alz09,
                     sum_5      LIKE alz_file.alz09,
                     sum01      LIKE alz_file.alz09,
                     sum1       LIKE alz_file.alz09,
                     sum02      LIKE alz_file.alz09,
                     sum2       LIKE alz_file.alz09,
                     sum03      LIKE alz_file.alz09,
                     sum3       LIKE alz_file.alz09,
                     sum04      LIKE alz_file.alz09,
                     sum4       LIKE alz_file.alz09,
                     sum05      LIKE alz_file.alz09,
                     sum5       LIKE alz_file.alz09,
                     sum06      LIKE alz_file.alz09,
                     sum6       LIKE alz_file.alz09,
                     sum07      LIKE alz_file.alz09,
                     sum7       LIKE alz_file.alz09,
                     sum08      LIKE alz_file.alz09,
                     sum8       LIKE alz_file.alz09,
                     sum09      LIKE alz_file.alz09,
                     sum9       LIKE alz_file.alz09,
                     sum010     LIKE alz_file.alz09,
                     sum10      LIKE alz_file.alz09,
                     sum011     LIKE alz_file.alz09,
                     sum11      LIKE alz_file.alz09,
                     sum012     LIKE alz_file.alz09,
                     sum12      LIKE alz_file.alz09,
                     sum013     LIKE alz_file.alz09,
                     sum13      LIKE alz_file.alz09,
                     sum014     LIKE alz_file.alz09,
                     sum14      LIKE alz_file.alz09,
                     sum015     LIKE alz_file.alz09,
                     sum15      LIKE alz_file.alz09,
                     sum016     LIKE alz_file.alz09,
                     sum16      LIKE alz_file.alz09,
                     sum017     LIKE alz_file.alz09,
                     sum17      LIKE alz_file.alz09
               END RECORD
#FUN-C80102--add---end--
DEFINE tm      RECORD
               #wc     LIKE type_file.chr1000,
               wc        STRING,                    #TQC-G10002 add
               aly01  LIKE aly_file.aly01,
               a      LIKE type_file.chr1,
               d      LIKE type_file.chr1,  #FUN-C80102
               u      LIKE type_file.chr1,  #FUN-C80102 add
               edate  LIKE type_file.dat,
               detail LIKE type_file.chr1,
               zr     LIKE type_file.chr1,
               org    LIKE type_file.chr1,        #TQC-C30349  add
               more   LIKE type_file.chr1
               END RECORD
DEFINE   g_field        STRING,
         g_sql          STRING
DEFINE   g_row_count    LIKE type_file.num10
DEFINE   g_curs_index   LIKE type_file.num10
DEFINE   g_jump         LIKE type_file.num10
DEFINE   l_ac           LIKE type_file.num5
DEFINE   l_ac1          LIKE type_file.num5    #No.FUN-C80102  Add
DEFINE   mi_no_ask      LIKE type_file.num5
DEFINE   g_msg          LIKE type_file.chr1000
DEFINE   g_rec_b        LIKE type_file.num10
DEFINE   g_rec_b2       LIKE type_file.num10   #FUN-C80102 add
DEFINE   g_cnt          LIKE type_file.num10
DEFINE   g_aly   DYNAMIC ARRAY OF RECORD LIKE aly_file.*
DEFINE   g_oma03        LIKE oma_file.oma03  #FUN-B60129
DEFINE   g_comb          ui.ComboBox    #TQC-C30349  add
DEFINE   g_flag         LIKE type_file.chr1  #FUN-C80102
DEFINE   g_action_flag  LIKE type_file.chr100  #FUN-C80102
DEFINE   g_filter_wc    STRING  #FUN-C80102
#FUN-C80102---add--str--
DEFINE   f    ui.Form
DEFINE   page om.DomNode
DEFINE   w    ui.Window
#FUN-C80102---add--end--

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AXR")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time

   #FUN-B60129--add--str--
   INITIALIZE tm.* TO NULL
   LET tm.wc = ARG_VAL(1)
   LET tm.aly01 = ARG_VAL(2)
   LET tm.a = ARG_VAL(3)
   LET tm.edate = ARG_VAL(4)
   LET tm.detail = ARG_VAL(5)
   LET tm.zr = ARG_VAL(6)
   #FUN-B60129--add--str--
   LET tm.org = ARG_VAL(7)   #TQC-C30349  add

   OPEN WINDOW q191_w AT 5,10
   WITH FORM "axr/42f/axrq191" ATTRIBUTE(STYLE = g_win_style)

   CALL cl_ui_init()
  #No.FUN-C80102 ---start--- Add
   #CALL cl_set_comp_visible("oma54t,oma56t,oma55,oma57,sum_1,sum_2",FALSE)
   CALL cl_set_comp_visible("oma54t,oma56t,oma55,oma57",FALSE)
   CALL cl_set_comp_visible("oma54t_1,oma56t_1,oma55_1,oma57_1",FALSE)
   CALL cl_set_comp_visible("oma56t_tot,oma56t_tot1,oma57_tot,oma57_tot1,sum_2_tot1,sum_2_tot",FALSE)

   CALL cl_set_comp_visible("sum3_1,sum4_1,sum5_1,sum6_1,sum7_1,sum8_1,sum9_1,sum10_1",FALSE)
   CALL cl_set_comp_visible("sum11_1,sum12_1,sum13_1,sum14_1,sum15_1,sum16_1,sum17_1",FALSE)
  #No.FUN-C80102 ---end  --- Add

   #TQC-C30324 add
   #CALL cl_set_comp_visible("sum1,sum2,sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10",FALSE) mark by lixwz 20171013
   CALL cl_set_comp_visible("sum3,sum4,sum5,sum6,sum7,sum8,sum9,sum10",FALSE)
                                                   # add by lixwz 20171013 未逾期金额
   CALL cl_set_comp_visible("sum11,sum12,sum13,sum14,sum15,sum16,sum17",FALSE)
   CALL cl_set_comp_visible("sum01,sum02,sum03,sum04,sum05,sum06,sum07,sum08,sum09,sum010",FALSE)
   CALL cl_set_comp_visible("sum011,sum012,sum013,sum014,sum015,sum016,sum017",FALSE)
   #TQC-C30324 add--end
   LET g_comb = ui.ComboBox.forName("u")  #FUN-C80102
   CALL g_comb.removeItem('4')            #FUN-C80102

#FUN-C80102--mark--str---
#  IF cl_null(tm.wc) THEN
#     CALL q191_tm()
#  ELSE
#     CALL q191()
#     CALL axrq191_t()  #FUN-B60129
#  END IF
#FUN-C80102--mark--end---

#No.FUN-C80102 ---start--- Add
   CALL cl_set_comp_entry("d",FALSE)
   CALL cl_set_comp_visible("azp01",FALSE)
   CALL cl_set_act_visible("revert_filter",FALSE)
   INITIALIZE tm.* TO NULL            # Default condition
   LET tm.a    = '2'
   LET tm.u    = ' '
   LET tm.edate = s_last(g_today)  #TQC-C30333 mod
   LET tm.org = 'N'                #TQC-C30349  add
   LET tm.d = 'N'
   LET g_flag = ' '
   CALL q191_table2()   #FUN-CB0146 add
   CALL q191_tm()
#No.FUN-C80102 ---end  --- Add
   CALL q191_menu()
   DROP TABLE axrq191_tmp;
   DROP TABLE axrq191_tmp1; #FUN-CB0146 add
   CLOSE WINDOW q191_w
   CALL cl_used(g_prog,g_time,2) RETURNING g_time

END MAIN

FUNCTION q191_menu()
   DEFINE   l_cmd   LIKE type_file.chr1000

   WHILE TRUE
     #CALL q191_bp("G")   #No.FUN-C80102 Mark

#FUN-C80102--add--str--
      IF cl_null(g_action_choice) THEN
         IF g_action_flag = "page1" THEN
            CALL q191_bp("G")
         END IF
         IF g_action_flag = "page2" THEN
            CALL q191_bp2()
         END IF
      END IF
#FUN-C80102--add--end--
      CASE g_action_choice
#FUN-C80102--add--str--
      WHEN "page1"
            CALL q191_bp("G")

      WHEN "page2"
            CALL q191_bp2()

      WHEN "data_filter"
            IF cl_chk_act_auth() THEN
               CALL q191_filter_askkey()
               CALL q191_show()
            ELSE                                 #FUN-C80102
               LET g_action_choice = " "         #FUN-C80102
            END IF

      WHEN "revert_filter"
            IF cl_chk_act_auth() THEN
               LET g_filter_wc = ''
               CALL cl_set_act_visible("revert_filter",FALSE)
               CALL q191_show()
            ELSE                                 #FUN-C80102
               LET g_action_choice = " "         #FUN-C80102
            END IF

#FUN-C80102--add--end--
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL q191_tm()
            ELSE                                 #FUN-C80102
               LET g_action_choice = " "         #FUN-C80102
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL q191_out()
            END IF
            LET g_action_choice = " "  #FUN-C80102
#FUN-C80102--mark--str--
#        #FUN-B60129--add--srt--
#        WHEN "find_detail"
#           IF cl_chk_act_auth() THEN
#              CALL q191_detail()
#           END IF
#        #FUN-B60129--add--end--
#FUN-C80102--mark--end--

         WHEN "help"
            CALL cl_show_help()
            LET g_action_choice = " "  #FUN-C80102
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
            LET g_action_choice = " "  #FUN-C80102
         WHEN "exporttoexcel"
#FUN-C80120--add--str--
             LET w = ui.Window.getCurrent()
             LET f = w.getForm()
             IF g_action_flag = "page1" THEN
#FUN-C80120--add--end--
               IF cl_chk_act_auth() THEN
                  CALL cl_export_to_excel
                  (ui.Interface.getRootNode(),base.TypeInfo.create(g_oma),'','')
               END IF
#FUN-C80120--add--str--
            END IF
             IF g_action_flag = "page2" THEN
                IF cl_chk_act_auth() THEN
                   LET page = f.FindNode("Page","page2")
                   CALL cl_export_to_excel(page,base.TypeInfo.create(g_oma_1),'','')
                END IF
             END IF
             LET g_action_choice = " "  #FUN-C80102
#FUN-C80120--add--end--

          WHEN "related_document"  #TQC-C40048
            #No.FUN-C80102 ---start--- Add
             IF cl_chk_act_auth() AND l_ac != 0 THEN
                IF g_oma[l_ac].oma03 IS NOT NULL THEN
                   LET g_doc.column1 = "oma03"
                   LET g_doc.value1 = g_oma[l_ac].oma03
                   CALL cl_doc()
                END IF
             END IF
             LET g_action_choice = " "
            #No.FUN-C80102 ---end  --- Add

      END CASE
   END WHILE
END FUNCTION

FUNCTION q191_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
   LET g_action_flag = 'page1'  #FUN-C80102
  #FUN-C80102--add--str---  #匯總條件不為空時，點擊明細頁簽時顯示input條件下的資料
   IF g_action_choice = "page1"  AND NOT cl_null(tm.u) AND g_flag != '1' THEN
      CALL q191_b_fill()
   END IF
  #FUN-C80102--add--end---

   LET g_action_choice = " "
   LET g_flag = ' '   #FUN-C80102

   CALL cl_set_act_visible("accept,cancel", FALSE)

   #FUN-C80102--add--str--
   DISPLAY BY NAME tm.u
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT tm.u,tm.org,tm.d FROM u,org,d ATTRIBUTE(WITHOUT DEFAULTS)
         ON CHANGE u
            IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
               CALL cl_set_comp_entry("d",TRUE)
            ELSE
               CALL cl_set_comp_entry("d",FALSE)
            END IF

            IF NOT cl_null(tm.u)  THEN
               CALL q191_b_fill_2()
               CALL q191_set_visible()
               CALL cl_set_comp_visible("page1", FALSE)
               CALL ui.interface.refresh()
               CALL cl_set_comp_visible("page1", TRUE)
               LET g_action_choice = "page2"
            ELSE
               CALL q191_b_fill()
               CALL g_oma_1.clear()
               DISPLAY 0  TO FORMONLY.cnt1
               DISPLAY 0  TO FORMONLY.oma56t_tot
               DISPLAY 0  TO FORMONLY.oma57_tot
               DISPLAY 0  TO FORMONLY.oma56t_oma57_tot
               DISPLAY 0  TO FORMONLY.sum_2_tot
               DISPLAY 0  TO FORMONLY.sum_4_tot
            END IF
            DISPLAY BY NAME tm.u
            EXIT DIALOG

          ON CHANGE org
             IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
                CALL cl_set_comp_entry("d",TRUE)
             ELSE
                CALL cl_set_comp_entry("d",FALSE)
             END IF
            #CALL q191()        #FUN-CB0146 mark
             CALL q191_get_tmp() #FUN-CB0146
             CALL axrq191_t()
             EXIT DIALOG

          ON CHANGE d
             CALL  q191_b_fill_2()
             CALL q191_set_visible()
             CALL cl_set_comp_visible("page1", FALSE)
             CALL ui.interface.refresh()
             CALL cl_set_comp_visible("page1", TRUE)
             LET g_action_choice = "page2"

      END INPUT
   #FUN-C80102--add--end--
  #No.FUN-C80102 ---start--- Mark
  #DISPLAY ARRAY g_oma TO s_oma.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

  #   BEFORE DISPLAY
  #      CALL cl_navigator_setting( g_curs_index, g_row_count )
  #      IF g_rec_b != 0 AND l_ac != 0 THEN
  #         CALL fgl_set_arr_curr(l_ac)
  #      END IF
  #No.FUN-C80102 ---end  --- Mark

   DISPLAY ARRAY g_oma TO s_oma.* ATTRIBUTE(COUNT=g_rec_b)   #No.FUN-C80102 Add

      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()
         END DISPLAY    #FUN-C80102 add

#FUN-C80102--add--str--
      ON ACTION page2
         LET g_action_choice = 'page2'
         EXIT DIALOG

      ON ACTION refresh_detail
         CALL q191_b_fill()
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page2", TRUE)
         LET g_action_choice = 'page1'
         EXIT DIALOG

      ON ACTION data_filter
         LET g_action_choice="data_filter"
         EXIT DIALOG

      ON ACTION revert_filter
         LET g_action_choice="revert_filter"
         EXIT DIALOG
#FUN-C80102--add--end--

      ON ACTION query
         LET g_action_choice="query"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      ON ACTION output
         LET g_action_choice="output"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

     #No.FUN-C80102 ---start--- Mark
     ##FUN-B60129--add--str--
     #ON ACTION find_detail
     #   LET g_action_choice="find_detail"
     #   EXIT DISPLAY
     ##FUN-B60129--add--end--
     #No.FUN-C80102 ---end  --- Mark

      ON ACTION help
         LET g_action_choice="help"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()

      ON ACTION exit
         LET g_action_choice="exit"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      ON ACTION controlg
         LET g_action_choice="controlg"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG   #FUN-C80102 add
        #CONTINUE DISPLAY  #FUN-C80102 mark

      ON ACTION about
         CALL cl_about()

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add

      #No.TQC-C40048  --Begin
      ON ACTION related_document
         LET g_action_choice="related_document"
        #EXIT DISPLAY  #FUN-C80102 mark
         EXIT DIALOG   #FUN-C80102 add
      #No.TQC-C40048  --End

     #No.FUN-C80102 ---start--- Mark
     #AFTER DISPLAY
     #   CONTINUE DISPLAY
     #No.FUN-C80102 ---start--- Mark

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

  #END DISPLAY  #FUN-C80102 mark
   END DIALOG   #FUN-C80102 add
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#FUN-C80102--add--str---
FUNCTION q191_detail_fill(p_ac)
DEFINE p_ac   LIKE type_file.num5
DEFINE l_tot11   LIKE oma_file.oma56t
DEFINE l_tot21   LIKE oma_file.oma56t
DEFINE l_tot31   LIKE oma_file.oma56t
DEFINE l_tot41   LIKE oma_file.oma56t
DEFINE l_tot51   LIKE oma_file.oma56t

   LET l_tot11 = 0
   LET l_tot21 = 0
   LET l_tot31 = 0
   LET l_tot41 = 0
   LET l_tot51 = 0
  #FUN-CB0146--add--str--
   IF cl_null(g_filter_wc) THEN LET g_filter_wc = " 1=1" END IF
   LET g_sql="SELECT oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,aag02,",
             "       oma54t,oma55,oma54t_oma55,sum_1,sum_3,oma56t,net,oma57,",
             "       oma56t_oma57,sum_2,sum_4,sum_5,",
             "       num01,num1,num02,num2,num03,num3,num04,num4,num05,num5,",
             "       num06,num6,num07,num7,num08,num8,num09,num9,num010,num10,",
             "       num011,num11,num012,num12,num013,num13,num014,num14,",
             "       num015,num15,num016,num16,num017,num17,",
             "       oma10,oma67,oma33,oma23,azj041_1,azj041,oma15,oma15_desc,",
             "       oma14,oma14_desc,oma68,occ18,occ03,occ03_desc,oma08,oma25,",
             "       oma26,azp01 ",
             "  FROM axrq191_tmp1"
  #FUN-CB0146--add--end
   CASE tm.u
      WHEN '1'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma03 = '",g_oma_1[p_ac].oma03,"'"
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma03,oma032,oma01,oma02 "

        PREPARE axrq191_pb_detail1 FROM g_sql
        DECLARE oma_curs_detail1  CURSOR FOR axrq191_pb_detail1        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail1 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN '2'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma15 = '",g_oma_1[p_ac].oma15,"'"
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma15,oma23,oma03,oma01 "

        PREPARE axrq191_pb_detail2 FROM g_sql
        DECLARE oma_curs_detail2  CURSOR FOR axrq191_pb_detail2        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail2 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN '3'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma15 = '",g_oma_1[p_ac].oma15,"'",
                     "   AND oma14 = '",g_oma_1[p_ac].oma14,"'"
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma14,oma23,oma03,oma01 "

        PREPARE axrq191_pb_detail3 FROM g_sql
        DECLARE oma_curs_detail3  CURSOR FOR axrq191_pb_detail3        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail3 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN '4'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma03 = '",g_oma_1[p_ac].oma03,"'"
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma03,oma032,oma01,oma02 "

        PREPARE axrq191_pb_detail4 FROM g_sql
        DECLARE oma_curs_detail4  CURSOR FOR axrq191_pb_detail4        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail4 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

    WHEN '5'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma03 = '",g_oma_1[p_ac].oma03,"' ",
                     "   AND oma18 = '",g_oma_1[p_ac].oma18,"' "
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma18,oma03,oma032,oma01,oma02 "

        PREPARE axrq191_pb_detail5 FROM g_sql
        DECLARE oma_curs_detail5  CURSOR FOR axrq191_pb_detail5        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail5 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

      WHEN '6'
        #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
         LET g_sql = g_sql,   #FUN-CB0146
                     " WHERE oma68 = '",g_oma_1[p_ac].oma68,"'"
         IF tm.org = 'Y' THEN
            LET g_sql = g_sql CLIPPED," AND oma23 = '",g_oma_1[p_ac].oma23,"'"
         END IF
         LET g_sql = g_sql CLIPPED,
                     " ORDER BY oma68,occ18,oma01,oma02 "

        PREPARE axrq191_pb_detail6 FROM g_sql
        DECLARE oma_curs_detail6  CURSOR FOR axrq191_pb_detail6        #CURSOR
        CALL g_oma.clear()
        LET g_cnt = 1
        LET g_rec_b = 0

        FOREACH oma_curs_detail6 INTO g_oma[g_cnt].*
           IF SQLCA.sqlcode THEN
              CALL cl_err('foreach:',SQLCA.sqlcode,1)
              EXIT FOREACH
           END IF
           LET l_tot11 = l_tot11 + g_oma[g_cnt].oma56t
           LET l_tot21 = l_tot21 + g_oma[g_cnt].oma57
           LET l_tot31 = l_tot31 + g_oma[g_cnt].oma56t_oma57
           LET l_tot41 = l_tot41 + g_oma[g_cnt].sum_2
           LET l_tot51 = l_tot51 + g_oma[g_cnt].sum_4
           LET g_cnt = g_cnt + 1
        END FOREACH

   END CASE
   DISPLAY l_tot11 TO FORMONLY.oma56t_tot1
   DISPLAY l_tot21 TO FORMONLY.oma57_tot1
   DISPLAY l_tot31 TO FORMONLY.oma56t_oma57_tot1
   DISPLAY l_tot41 TO FORMONLY.sum_2_tot1
   DISPLAY l_tot51 TO FORMONLY.sum_4_tot1
   CALL g_oma.deleteElement(g_cnt)
   LET g_rec_b = g_cnt -1
   DISPLAY g_rec_b TO FORMONLY.cnt
END FUNCTION

FUNCTION q191_bp2()
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY tm.u TO u
   LET g_flag = ' ' #FUN-C80102
   LET g_action_flag = 'page2'  #FUN-C80102
   LET g_action_choice = " "    #FUN-C80102
   DIALOG ATTRIBUTES(UNBUFFERED)
      INPUT tm.u,tm.org,tm.d FROM u,org,d ATTRIBUTE(WITHOUT DEFAULTS)
         ON CHANGE u
            IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
               CALL cl_set_comp_entry("d",TRUE)
            ELSE
               CALL cl_set_comp_entry("d",FALSE)
            END IF
            IF NOT cl_null(tm.u)  THEN
               CALL q191_b_fill_2()
               CALL q191_set_visible()
               LET g_action_choice = "page2"
            ELSE
               CALL q191_b_fill()
               CALL cl_set_comp_visible("page2", FALSE)
               CALL ui.interface.refresh()
               CALL cl_set_comp_visible("page2", TRUE)
               LET g_action_choice = "page1"
               CALL g_oma_1.clear()
               DISPLAY 0  TO FORMONLY.cnt1
               DISPLAY 0  TO FORMONLY.oma56t_tot
               DISPLAY 0  TO FORMONLY.oma57_tot
               DISPLAY 0  TO FORMONLY.oma56t_oma57_tot
               DISPLAY 0  TO FORMONLY.sum_2_tot
               DISPLAY 0  TO FORMONLY.sum_4_tot
            END IF
            DISPLAY tm.u TO u
            EXIT DIALOG

          ON CHANGE org
             IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
               CALL cl_set_comp_entry("d",TRUE)
             ELSE
               CALL cl_set_comp_entry("d",FALSE)
             END IF
            #CALL q191()  #FUN-CB0146 mark
             CALL q191_get_tmp() #FUN-CB0146
             CALL axrq191_t()
             EXIT DIALOG

          ON CHANGE d
             CALL  q191_b_fill_2()
             CALL q191_set_visible()
             LET g_action_choice = "page2"

      END INPUT

      DISPLAY ARRAY g_oma_1 TO s_oma_1.* ATTRIBUTE(COUNT=g_rec_b2)
         BEFORE ROW
            LET l_ac1 = ARR_CURR()
            CALL cl_show_fld_cont()
      END DISPLAY

      ON ACTION page1
         LET g_action_choice="page1"
         EXIT DIALOG

      ON ACTION data_filter
         LET g_action_choice="data_filter"
         EXIT DIALOG

      ON ACTION revert_filter
         LET g_action_choice="revert_filter"
         EXIT DIALOG

      ON ACTION accept
         LET l_ac1 = ARR_CURR()
         IF l_ac1 > 0  THEN
            CALL q191_detail_fill(l_ac1)
            CALL cl_set_comp_visible("page2", FALSE)
            CALL ui.interface.refresh()
            CALL cl_set_comp_visible("page2", TRUE)
            LET g_action_choice= "page1"
            LET g_flag = '1'
            EXIT DIALOG
         END IF


      ON ACTION refresh_detail
         CALL q191_b_fill()
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page2", TRUE)
         LET g_action_choice = "page1"
         EXIT DIALOG

      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG

      ON ACTION output
         LET g_action_choice="output"
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

FUNCTION q191_show()
   DISPLAY tm.u TO u
   DISPLAY tm.a TO a
   DISPLAY tm.aly01 TO aly01
   DISPLAY tm.org TO org
   DISPLAY tm.d TO d
   DISPLAY tm.edate TO edate

   CALL q191_b_fill()
   CALL q191_b_fill_2()
   IF cl_null(tm.u)  THEN
      LET g_action_choice = "page1"
      CALL cl_set_comp_visible("page2", FALSE)
      CALL ui.interface.refresh()
      CALL cl_set_comp_visible("page2", TRUE)
      LET g_action_flag = "page1"
   ELSE
      LET g_action_choice = "page2"
      CALL cl_set_comp_visible("page1", FALSE)
      CALL ui.interface.refresh()
      CALL cl_set_comp_visible("page1", TRUE)
   END IF

   CALL q191_set_visible()
   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION q191_set_visible()

  CALL cl_set_comp_visible("oma18_1,aag02_1,oma03_1,occ18_1,occ45,oma032_1",TRUE)
  CALL cl_set_comp_visible("oma15_1,oma15_desc_1,oma14_1,oma14_desc_1",TRUE)
  CALL cl_set_comp_visible("oma03_1,occ18_1,oma032_1,oma68_1",TRUE)
  CALL cl_set_comp_visible("oma15_1,oma15_desc_1,oma14_1,oma14_desc_1",TRUE)
  CALL cl_set_comp_visible("oma15_1,oma15_desc_1,oma14_1,oma14_desc_1",TRUE)
 #CALL cl_set_comp_visible("sum1_1,sum2_1,sum3_1,sum4_1,sum5_1,sum6_1,sum7_1,sum8_1,sum9_1,sum10_1",TRUE)   #No.FUN-C80102   Mark
 #CALL cl_set_comp_visible("sum11_1,sum12_1,sum13_1,sum14_1,sum15_1,sum16_1,sum17_1",TRUE)                  #No.FUN-C80102   Mark
  CALL cl_set_comp_visible("sum01_1,sum02_1,sum03_1,sum04_1,sum05_1,sum06_1,sum07_1,sum08_1,sum09_1,sum010_1",TRUE)
  CALL cl_set_comp_visible("sum011_1,sum012_1,sum013_1,sum014_1,sum015_1,sum016_1,sum017_1",TRUE)
  CASE tm.u
    WHEN '1' CALL cl_set_comp_visible("oma68_1,occ18_1,oma18_1,aag02_1,oma15_1,oma15_desc_1,oma14_1,oma14_desc_1,sum_5_1",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL q191_set_title_1()

    WHEN '2' CALL cl_set_comp_visible("oma68_1,occ18_1,oma18_1,aag02_1,oma03_1,occ18_1,oma032_1,oma14_1,oma14_desc_1,sum_5_1,occ45",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL q191_set_title_1()

    WHEN '3' CALL cl_set_comp_visible("oma68_1,occ18_1,oma18_1,aag02_1,oma03_1,occ18_1,oma032_1,sum_5_1,occ45",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL q191_set_title_1()

    WHEN '4' CALL cl_set_comp_visible("oma68_1,occ18_1,oma18_1,aag02_1,oma15_1,oma15_desc_1,oma14_1,oma14_desc_1",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL cl_set_comp_visible("sum1_1,sum2_1,sum3_1,sum4_1,sum5_1,sum6_1,sum7_1,sum8_1,sum9_1,sum10_1",FALSE)
             CALL cl_set_comp_visible("sum11_1,sum12_1,sum13_1,sum14_1,sum15_1,sum16_1,sum17_1",FALSE)
             CALL cl_set_comp_visible("sum01_1,sum02_1,sum03_1,sum04_1,sum05_1,sum06_1,sum07_1,sum08_1,sum09_1,sum010_1",FALSE)
             CALL cl_set_comp_visible("sum011_1,sum012_1,sum013_1,sum014_1,sum015_1,sum016_1,sum017_1",FALSE)

    WHEN '5' CALL cl_set_comp_visible("oma68_1,occ18_1,oma15_1,oma15_desc_1,oma14_1,oma14_desc_1,occ45,sum_5_1",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL q191_set_title_1()

    WHEN '6' CALL cl_set_comp_visible("oma03_1,oma032_1,oma18_1,aag02_1,oma15_1,oma15_desc_1,oma14_1,oma14_desc_1,sum_5_1",FALSE)
             CALL cl_set_comp_visible("oma54t_1,oma55_1,oma56t_1,oma57_1,oma54t_tot,oma55_tot,oma56t_tot,oma57_tot,",FALSE)
             CALL q191_set_title_1()
  END CASE

END FUNCTION

FUNCTION q191_filter_askkey()
DEFINE l_wc   STRING
   CLEAR FORM
   CALL g_oma.clear()
  #CALL cl_set_comp_visible("oma23,oma23_1,oma54t,oma55,oma54t_oma55,sum_1,sum_3,sum_1_1,sum_3_1,oma54t_1,oma55_1,oma54t_oma55_1 ",TRUE) #NO.FUN-C80102   Mark
   CALL cl_set_comp_visible("oma23,oma23_1,oma54t_oma55,sum_3,sum_3_1,oma54t_oma55_1 ",TRUE)   #FUN-C80102   Add
   DISPLAY BY NAME tm.u,tm.aly01,tm.a,tm.edate,tm.org,tm.d
   CONSTRUCT l_wc ON  oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,  #FUN-C80102 oma11->alz07
                      oma54t,oma55,oma54t_oma55,oma56t,oma57,oma56t_oma57,
                      oma10,oma67,oma33,oma23,oma15,oma14,
                      oma68,occ18,occ03,
                      oma08,oma25,oma26
                 FROM s_oma[1].oma03,s_oma[1].oma032,s_oma[1].oma00,s_oma[1].oma01,s_oma[1].oma02,
                      s_oma[1].alz12,s_oma[1].alz07,s_oma[1].oma18,s_oma[1].oma54t,s_oma[1].oma55,s_oma[1].oma54t_oma55,  #FUN-C80102 oma11->alz07
                      s_oma[1].oma56t,s_oma[1].oma57,s_oma[1].oma56t_oma57,
                      s_oma[1].oma10,s_oma[1].oma67,s_oma[1].oma33,s_oma[1].oma23,s_oma[1].oma15,s_oma[1].oma14,
                      s_oma[1].oma68,s_oma[1].occ18,s_oma[1].occ03,
                      s_oma[1].oma08,s_oma[1].oma25,s_oma[1].oma26


      BEFORE CONSTRUCT
         CALL cl_qbe_init()

      AFTER CONSTRUCT
         IF tm.org = 'N' THEN
            CALL cl_set_comp_visible("oma23,oma23_1,oma54t,oma55,oma54t_oma55,sum_1,sum_3,sum_1_1,sum_3_1,oma54t_1,oma55_1,oma54t_oma55_1 ",FALSE)
         ELSE
            CALL cl_set_comp_visible("oma23,oma23_1,oma54t_oma55,sum_3,sum_3_1,oma54t_oma55_1 ",TRUE)
         END IF

      ON ACTION CONTROLP
       CASE
          WHEN INFIELD(oma03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma03
               NEXT FIELD oma03

          WHEN INFIELD(oma032)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_1"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma032
               NEXT FIELD oma032

          WHEN INFIELD(oma68)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma68
               NEXT FIELD oma68


          WHEN INFIELD(occ18)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_3"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ18
               NEXT FIELD occ18

          WHEN INFIELD(occ03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oca"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ03
               NEXT FIELD occ03

          WHEN INFIELD(oma15)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gem3"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma15
               NEXT FIELD oma15

          WHEN INFIELD(oma14)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gen5"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma14
               NEXT FIELD oma14


          WHEN INFIELD(oma01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma01
               NEXT FIELD oma01

          WHEN INFIELD(oma08)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma08"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma08
               NEXT FIELD oma08

          WHEN INFIELD(oma25)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma25"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma25
               NEXT FIELD oma25

          WHEN INFIELD(oma26)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma26"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma26
               NEXT FIELD oma26

          WHEN INFIELD(oma10)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma2"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma10
               NEXT FIELD oma10

          WHEN INFIELD(oma67)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma67"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma67
               NEXT FIELD oma67

          WHEN INFIELD(oma33)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma33"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma33
               NEXT FIELD oma33

          WHEN INFIELD(oma23)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_azi"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma23
               NEXT FIELD oma23
      END CASE

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

      ON ACTION about
         CALL cl_about()

      ON ACTION HELP
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION qbe_select
    	 CALL cl_qbe_select()

      ON ACTION qbe_save
         CALL cl_qbe_save()

   END CONSTRUCT

   IF INT_FLAG THEN
      LET g_filter_wc = ''
      CALL cl_set_act_visible("revert_filter",FALSE)
      LET INT_FLAG = 0
      RETURN
   END IF
   LET l_wc =cl_replace_str(l_wc, "oma54t_oma55", "oma54t-oma55")
   LET l_wc =cl_replace_str(l_wc, "oma56t_oma57", "oma56t-oma57")
   IF l_wc !=" 1=1" THEN
      CALL cl_set_act_visible("revert_filter",TRUE)
   END IF

   IF cl_null(g_filter_wc) THEN LET g_filter_wc = " 1=1" END IF
   LET g_filter_wc = g_filter_wc CLIPPED," AND ",l_wc CLIPPED
END FUNCTION

#FUN-C80102--add--end---

FUNCTION q191_tm()
   DEFINE p_row,p_col     LIKE type_file.num5,
          l_i             LIKE type_file.num5,
          l_cmd           LIKE type_file.chr1000
   DEFINE lc_qbe_sn       LIKE gbm_file.gbm01

#FUN-C80102--mark--str--
#  LET p_row = 4 LET p_col = 12
#  OPEN WINDOW axrr191_w AT p_row,p_col WITH FORM "axr/42f/axrr191"
#  ATTRIBUTE (STYLE = g_win_style CLIPPED)

#  CALL cl_ui_locale("axrr191")
#FUN-C80102--mark--end--
   CLEAR FORM   #FUN-C80102 add
   CALL g_oma.clear()  #FUN-C80102 add
   CALL cl_set_comp_visible("oma23,oma23_1,oma54t_oma55,sum_3,sum_3_1,oma54t_oma55_1 ",TRUE)
   CALL cl_set_comp_entry("d",FALSE)  #FUN-C80102 add]
   CALL cl_set_comp_visible("sum_5,sum_5_1",FALSE)  #yinhy130618 #2013060119

   CALL cl_opmsg('p')

#FUN-C80102--mark--str--
#  #--TQC-C30349--add--str--
#  IF g_azw.azw04 <> '2' THEN
#     LET g_comb = ui.ComboBox.forName("oma00")
#     CALL g_comb.removeItem('15')
#     CALL g_comb.removeItem('16')
#     CALL g_comb.removeItem('17')
#     CALL g_comb.removeItem('18')
#     CALL g_comb.removeItem('19')
#     CALL g_comb.removeItem('26')
#     CALL g_comb.removeItem('27')
#     CALL g_comb.removeItem('28')
#  END IF
#  #--TQC-C30349--add--end--
#  INITIALIZE tm.* TO NULL            # Default condition
#  LET tm.a    = '1'
#  LET tm.more = 'N'
# #LET tm.edate = g_today
#  LET tm.edate = s_last(g_today)  #TQC-C30333 mod
#  LET tm.detail = 'N'
#  LET tm.zr = 'N'
#  LET tm.org = 'N'                #TQC-C30349  add
#FUN-C80102--mark--end--
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies = '1'
   SELECT MIN(aly01) INTO tm.aly01 FROM aly_file
#FUN-C80102--mark---str---
#  DISPLAY tm.aly01,tm.a,tm.edate,tm.detail,tm.zr,tm.org,tm.more    #TQC-C30349  add  tm.org
#       TO tm.aly01,tm.a,tm.edate,tm.detail,tm.zr,tm.org,tm.more    #TQC-C30349  add  tm.org
#  DIALOG ATTRIBUTE(UNBUFFERED)
#  CONSTRUCT BY NAME tm.wc ON oma15,oma14,occ03,oma03,oma00   #TQC-C30349  add  oma00

#     BEFORE CONSTRUCT
#        CALL cl_qbe_init()
#
#     ON ACTION CONTROLP
#        CASE
#           WHEN INFIELD(oma15)
#              CALL cl_init_qry_var()
#              LET g_qryparam.form = "q_gem3"
#              LET g_qryparam.plant = g_plant
#              LET g_qryparam.state = "c"
#              CALL cl_create_qry() RETURNING g_qryparam.multiret
#              DISPLAY g_qryparam.multiret TO oma15
#              NEXT FIELD oma15
#           WHEN INFIELD(oma14)
#              CALL cl_init_qry_var()
#              LET g_qryparam.form = "q_gen5"
#              LET g_qryparam.plant = g_plant
#              LET g_qryparam.state = "c"
#              CALL cl_create_qry() RETURNING g_qryparam.multiret
#              DISPLAY g_qryparam.multiret TO oma14
#              NEXT FIELD oma14
#           WHEN INFIELD(occ03)
#              CALL cl_init_qry_var()
#              LET g_qryparam.form = "q_oca"
#              LET g_qryparam.state = "c"
#              CALL cl_create_qry() RETURNING g_qryparam.multiret
#              DISPLAY g_qryparam.multiret TO occ03
#              NEXT FIELD occ03
#           WHEN INFIELD(oma03)
#              CALL cl_init_qry_var()
#              LET g_qryparam.form = "q_occ02"
#              LET g_qryparam.state = "c"
#              CALL cl_create_qry() RETURNING g_qryparam.multiret
#              DISPLAY g_qryparam.multiret TO oma03
#              NEXT FIELD oma03
#
#        END CASE
#     END CONSTRUCT
#FUN-C80102--mark---end---

     #No.FUN-C80102 ---start--- mark
     #INPUT BY NAME tm.aly01,tm.a,tm.edate,tm.detail,tm.zr,tm.org,tm.more    #TQC-C30349  add  tm.org
     #ATTRIBUTES (WITHOUT DEFAULTS)
     #No.FUN-C80102 ---start--- mark
  #No.FUN-C80102 ---start--- Add
   DISPLAY BY NAME tm.aly01,tm.a,tm.edate,tm.u,tm.org,tm.d
   DIALOG ATTRIBUTE(UNBUFFERED)
      INPUT BY NAME tm.aly01,tm.a,tm.edate,tm.u,tm.org,tm.d
         ATTRIBUTES (WITHOUT DEFAULTS=TRUE)
  #No.FUN-C80102 ---end --- Add
         BEFORE INPUT
            CALL cl_qbe_display_condition(lc_qbe_sn)

         AFTER FIELD edate
            IF tm.edate IS NULL THEN
               CALL cl_err('','aap1000',0)
               NEXT FIELD edate
            END IF
            IF MONTH(tm.edate) = MONTH(tm.edate+1) THEN
               CALL cl_err('','aap-993',1)
               NEXT FIELD edate
            END IF

#FUN-C80102--add--str--
          AFTER FIELD org
             IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
                CALL cl_set_comp_entry("d",TRUE)
             ELSE
                CALL cl_set_comp_entry("d",FALSE)
             END IF

          AFTER FIELD u
             IF NOT cl_null(tm.u) AND tm.org = 'Y' THEN
                CALL cl_set_comp_entry("d",TRUE)
             ELSE
                CALL cl_set_comp_entry("d",FALSE)
             END IF
#FUN-C80102--add--end--
#FUN-C80102--mark--str--
#         AFTER FIELD MORE
#            IF tm.more = 'Y' THEN
#               CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
#                              g_bgjob,g_time,g_prtway,g_copies)
#               RETURNING g_pdate,g_towhom,g_rlang,
#                         g_bgjob,g_time,g_prtway,g_copies
#            END IF

#         ON ACTION CONTROLP
#            CASE
#               WHEN INFIELD(aly01)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form = 'q_aly01'
#                  LET g_qryparam.default1 = tm.aly01
#                  CALL cl_create_qry() RETURNING tm.aly01
#                  DISPLAY BY NAME tm.aly01
#                  NEXT FIELD aly01
#            END CASE
#FUN-C80102--mark--end--
      END INPUT


     #No.FUN-C80102 ---start--- Add
      CONSTRUCT tm.wc ON oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18, #FUN-C80102  oma11 -> alz07
                      oma54t,oma55,oma54t_oma55,oma56t,oma57,oma56t_oma57,
                      oma10,oma67,oma33,oma23,oma15,oma14,
                      oma68,occ18,occ03,
                      oma08,oma25,oma26
                 FROM s_oma[1].oma03,s_oma[1].oma032,s_oma[1].oma00,s_oma[1].oma01,s_oma[1].oma02,
                      s_oma[1].alz12,s_oma[1].alz07,s_oma[1].oma18,s_oma[1].oma54t,s_oma[1].oma55,s_oma[1].oma54t_oma55,  #FUN-C80102  oma11 -> alz07
                      s_oma[1].oma56t,s_oma[1].oma57,s_oma[1].oma56t_oma57,
                      s_oma[1].oma10,s_oma[1].oma67,s_oma[1].oma33,s_oma[1].oma23,s_oma[1].oma15,s_oma[1].oma14,
                      s_oma[1].oma68,s_oma[1].occ18,s_oma[1].occ03,
                      s_oma[1].oma08,s_oma[1].oma25,s_oma[1].oma26
      BEFORE CONSTRUCT
         CALL cl_qbe_init()
      END CONSTRUCT

      ON ACTION CONTROLP
         CASE
           WHEN INFIELD(aly01)
                CALL cl_init_qry_var()
                LET g_qryparam.form = 'q_aly01'
                LET g_qryparam.default1 = tm.aly01
                CALL cl_create_qry() RETURNING tm.aly01
                DISPLAY BY NAME tm.aly01
                NEXT FIELD aly01

           WHEN INFIELD(oma03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma03
               NEXT FIELD oma03

          WHEN INFIELD(oma18)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_aag11"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma18
               NEXT FIELD oma18


          WHEN INFIELD(oma032)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_1"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma032
               NEXT FIELD oma032

          WHEN INFIELD(oma68)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma68
               NEXT FIELD oma68
          WHEN INFIELD(occ18)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_3"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ18
               NEXT FIELD occ18

          WHEN INFIELD(occ03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oca"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ03
               NEXT FIELD occ03

          WHEN INFIELD(oma15)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gem3"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma15
               NEXT FIELD oma15

          WHEN INFIELD(oma14)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gen5"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma14
               NEXT FIELD oma14

          WHEN INFIELD(oma01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma01
               NEXT FIELD oma01

          WHEN INFIELD(oma08)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma08"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma08
               NEXT FIELD oma08

          WHEN INFIELD(oma25)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma25"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma25
               NEXT FIELD oma25

          WHEN INFIELD(oma26)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma26"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma26
               NEXT FIELD oma26

          WHEN INFIELD(oma10)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma2"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma10
               NEXT FIELD oma10

          WHEN INFIELD(oma67)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma67"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma67
               NEXT FIELD oma67

          WHEN INFIELD(oma33)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma33"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma33
               NEXT FIELD oma33

          WHEN INFIELD(oma23)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_azi"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma23
               NEXT FIELD oma23
      END CASE
     #No.FUN-C80102 ---end  --- Add

      ON ACTION locale
         LET g_action_choice = "locale"
         CALL cl_show_fld_cont()
         CALL cl_dynamic_locale()
         CONTINUE DIALOG

      ON ACTION ACCEPT
         LET INT_FLAG = 0
         ACCEPT DIALOG

      ON ACTION CANCEL
         LET INT_FLAG = 1
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about
         CALL cl_about()
         CONTINUE DIALOG

      ON ACTION help
         CALL cl_show_help()
         CONTINUE DIALOG

      ON ACTION controlg
         CALL cl_cmdask()
         CONTINUE DIALOG

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION qbe_select
         CALL cl_qbe_select()

      AFTER DIALOG
         IF tm.org = 'N' THEN
            CALL cl_set_comp_visible("oma23,oma23_1,oma54t,oma55,oma54t_oma55,sum_1,sum_3,sum_1_1,sum_3_1,oma54t_1,oma55_1,oma54t_oma55_1 ",FALSE)
         ELSE
            CALL cl_set_comp_visible("oma23,oma23_1,oma54t_oma55,sum_3,sum_3_1,oma54t_oma55_1 ",TRUE)
         END IF
         IF NOT q191_chk_datas() THEN
            IF g_field = "edate" THEN
               NEXT FIELD edate
            END IF
            IF g_field = "aly01" THEN
               NEXT FIELD aly01
            END IF
#FUN-C80102--mark--str--
#           IF g_field = "oma15" THEN
#              NEXT FIELD oma15
#           END IF
#FUN-C80102--mark--end--
            LET g_field = ''
         END IF
   END DIALOG

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CALL  cl_used(g_prog,g_time,2) RETURNING g_time
      #EXIT PROGRAM     #TQC-C70036   mark
      CLOSE WINDOW axrr191_w    #TQC-C70036   add
   END IF
#  CLOSE WINDOW axrr191_w   #FUN-C80102 mark
#  CALL q191_b_askkey()     #FUN-C80102 add
   LET tm.wc =cl_replace_str(tm.wc, "oma54t_oma55", "oma54t-oma55")  #FUN-C80102
   LET tm.wc =cl_replace_str(tm.wc, "oma56t_oma57", "oma56t-oma57")  #FUN-C80102
  #CALL q191()        #FUN-CB0146 mark
   CALL q191_get_tmp() #FUN-CB0146
   CALL axrq191_t()
END FUNCTION

#FUN-C80102--add--str---
FUNCTION q191_b_askkey()

   CONSTRUCT tm.wc ON oma03,oma032,oma68,occ18,occ03,oma15,oma14,oma00,oma01,oma02,oma11,
                      oma08,oma25,oma26,oma10,oma67,oma33,oma23,
                      oma54t,oma55,oma54t_oma55,oma56t,oma57,oma56t_oma57
                 FROM s_oma[1].oma03,s_oma[1].oma032,s_oma[1].oma68,s_oma[1].occ18,s_oma[1].occ03,
                      s_oma[1].oma15,s_oma[1].oma14,s_oma[1].oma00,s_oma[1].oma01,s_oma[1].oma02,s_oma[1].oma11,
                      s_oma[1].oma08,s_oma[1].oma25,s_oma[1].oma26,s_oma[1].oma10,s_oma[1].oma67,s_oma[1].oma33,
                      s_oma[1].oma23,
                      s_oma[1].oma54t,s_oma[1].oma55,s_oma[1].oma54t_oma55,s_oma[1].oma56t,s_oma[1].oma57,
                      s_oma[1].oma56t_oma57

   BEFORE CONSTRUCT
      CALL cl_qbe_init()


      ON ACTION CONTROLP
       CASE
          WHEN INFIELD(oma03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma03
               NEXT FIELD oma03

          WHEN INFIELD(oma032)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_1"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma032
               NEXT FIELD oma032

          WHEN INFIELD(oma18)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_aag11"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma18
               NEXT FIELD oma18

          WHEN INFIELD(oma68)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma68
               NEXT FIELD oma68

          WHEN INFIELD(occ18)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_occ02_3"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ18
               NEXT FIELD occ18

          WHEN INFIELD(occ03)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oca"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ03
               NEXT FIELD occ03

          WHEN INFIELD(oma15)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gem3"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma15
               NEXT FIELD oma15

          WHEN INFIELD(oma14)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gen5"
               LET g_qryparam.plant = g_plant
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma14
               NEXT FIELD oma14

          WHEN INFIELD(oma01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma02"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma01
               NEXT FIELD oma01

          WHEN INFIELD(oma08)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma08"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma08
               NEXT FIELD oma08

          WHEN INFIELD(oma25)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma25"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma25
               NEXT FIELD oma25

          WHEN INFIELD(oma26)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma26"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma26
               NEXT FIELD oma26

          WHEN INFIELD(oma10)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma2"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma10
               NEXT FIELD oma10

          WHEN INFIELD(oma67)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma67"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma67
               NEXT FIELD oma67

          WHEN INFIELD(oma33)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_oma33"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma33
               NEXT FIELD oma33

          WHEN INFIELD(oma23)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_azi"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO oma23
               NEXT FIELD oma23
      END CASE
    END CONSTRUCT
END FUNCTION

#FUN-C80102--add--end---

#栏位输入管控
FUNCTION q191_chk_datas()
#FUN-C80102--mark--str--
#  IF tm.wc = " 1=1" THEN
#     CALL cl_err('','9046',0)
#     LET g_field = "oma15"
#     RETURN FALSE
#  END IF
#FUN-C80102--mark--end--
   IF tm.aly01 IS NULL THEN
      CALL cl_err('','aap1001',0)
      LET g_field = "aly01"
      RETURN FALSE
   END IF
   IF tm.edate IS NULL THEN
      CALL cl_err('','aap1000',0)
      LET g_field = "edate"
      RETURN FALSE
   END IF
   IF MONTH(tm.edate) = MONTH(tm.edate+1) THEN
      CALL cl_err('','aap-993',1)
      LET g_field = "edate"
      RETURN FALSE
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION q191()
   DEFINE l_sql     STRING,
          l_alz09  LIKE alz_file.alz09,   #金额
          l_alz09f LIKE alz_file.alz09f,  #原幣金额   #TQC-C30349
          l_alz06  LIKE alz_file.alz06,   #立账日期
          l_alz07  LIKE alz_file.alz07,   #付款日期
          l_date   LIKE type_file.dat,
          l_bucket LIKE type_file.num5
   DEFINE sr RECORD
             oma03  LIKE oma_file.oma03,  #客戶
            #oma032 LIKE oma_file.oma03,  #簡稱
             oma032 LIKE oma_file.oma032,  #簡稱  #TQC-C30330 mod
             oma00  LIKE oma_file.oma00,   #FUN-C80102
             oma01  LIKE oma_file.oma01,   #FUN-C80102
             oma02  LIKE oma_file.oma02,  #Date
             alz12  LIKE alz_file.alz12,   #FUN-C80102
            #oma11  LIKE oma_file.oma11,   #FUN-C80102
             alz07  LIKE alz_file.alz07,   #FUN-C80102
             oma18  LIKE oma_file.oma18,   #FUN-C80102
             aag02  LIKE aag_file.aag02,   #FUN-C80102
             oma54t LIKE oma_file.oma54t,  #FUN-C80102
             oma55  LIKE oma_file.oma55,   #FUN-C80102
             oma54t_oma55  LIKE oma_file.oma54t,   #FUN-C80102
             sum_1      LIKE type_file.num20_6,  #FUN-C80102
             sum_3      LIKE type_file.num20_6,  #FUN-C80102
             oma56t LIKE oma_file.oma56t,  #FUN-C80102
             net    LIKE oox_file.oox10,   #FUN-C80102
             oma57  LIKE oma_file.oma57,   #FUN-C80102
             oma56t_oma57  LIKE oma_file.oma56t,   #FUN-C80102
             sum_2      LIKE type_file.num20_6,  #FUN-C80102
             sum_4      LIKE type_file.num20_6,  #FUN-C80102
             sum_5      LIKE type_file.num20_6,  #FUN-C80102
             num01  LIKE alz_file.alz09,
             num1   LIKE alz_file.alz09,
             num02  LIKE alz_file.alz09,
             num2   LIKE alz_file.alz09,
             num03  LIKE alz_file.alz09,
             num3   LIKE alz_file.alz09,
             num04  LIKE alz_file.alz09,
             num4   LIKE alz_file.alz09,
             num05  LIKE alz_file.alz09,
             num5   LIKE alz_file.alz09,
             num06  LIKE alz_file.alz09,
             num6   LIKE alz_file.alz09,
             num07  LIKE alz_file.alz09,
             num7   LIKE alz_file.alz09,
             num08  LIKE alz_file.alz09,
             num8   LIKE alz_file.alz09,
             num09  LIKE alz_file.alz09,
             num9   LIKE alz_file.alz09,
             num010 LIKE alz_file.alz09,
             num10  LIKE alz_file.alz09,
             num011 LIKE alz_file.alz09,
             num11  LIKE alz_file.alz09,
             num012 LIKE alz_file.alz09,
             num12  LIKE alz_file.alz09,
             num013 LIKE alz_file.alz09,
             num13  LIKE alz_file.alz09,
             num014 LIKE alz_file.alz09,
             num14  LIKE alz_file.alz09,
             num015 LIKE alz_file.alz09,
             num15  LIKE alz_file.alz09,
             num016 LIKE alz_file.alz09,
             num16  LIKE alz_file.alz09,
             num017 LIKE alz_file.alz09,
             num17  LIKE alz_file.alz09,
             oma10  LIKE oma_file.oma10,   #FUN-C80102
             oma67  LIKE oma_file.oma67,   #FUN-C80102
             oma33  LIKE oma_file.oma33,   #FUN-C80102
             oma23  LIKE oma_file.oma23,   #TQC-C30349  add
             azj041_1 LIKE azj_file.azj041,  #FUN-C80102
             azj041   LIKE azj_file.azj041,  #FUN-C80102
             oma15  LIKE oma_file.oma15,   #FUN-C80102
             oma15_desc LIKE gem_file.gem01,   #FUN-C80102
             oma14  LIKE oma_file.oma14,   #FUN-C80102
             oma14_desc LIKE gen_file.gen01,   #FUN-C80102
             oma68  LIKE oma_file.oma68,   #FUN-C80102
             occ18  LIKE occ_file.occ18,   #FUN-C80102
             occ03  LIKE occ_file.occ03,   #FUN-C80102
             occ03_desc LIKE oca_file.oca02,   #FUN-C80102
            #oma01  LIKE oma_file.oma01,   #FUN-C80102 mark
             oma08  LIKE oma_file.oma08,   #FUN-C80102
             oma25  LIKE oma_file.oma25,
             oma26  LIKE oma_file.oma26,   #FUN-C80102
             azp01  LIKE azp_file.azp01   #FUN-C80102
            #num    LIKE alz_file.alz09  #FUN-C80102 mark
             END RECORD
   DEFINE l_aly RECORD LIKE aly_file.*
   DEFINE l_i   LIKE type_file.num5
   DEFINE l_zl  LIKE type_file.chr20     #賬齡分段
  #No.FUN-C80102 ---start--- Add
   DEFINE l_oma12 LIKE oma_file.oma12
   DEFINE l_azi07 LIKE azi_file.azi07
   DEFINE l_azi04 LIKE azi_file.azi04
   DEFINE l_num01 LIKE alz_file.alz09
   DEFINE l_num02 LIKE alz_file.alz09
   DEFINE l_num03 LIKE alz_file.alz09
   DEFINE l_num04 LIKE alz_file.alz09
   DEFINE l_num05 LIKE alz_file.alz09
   DEFINE l_num06 LIKE alz_file.alz09
   DEFINE l_num07 LIKE alz_file.alz09
   DEFINE l_num08 LIKE alz_file.alz09
   DEFINE l_num09 LIKE alz_file.alz09
   DEFINE l_num010 LIKE alz_file.alz09
   DEFINE l_num011 LIKE alz_file.alz09
   DEFINE l_num012 LIKE alz_file.alz09
   DEFINE l_num013 LIKE alz_file.alz09
   DEFINE l_num014 LIKE alz_file.alz09
   DEFINE l_num015 LIKE alz_file.alz09
   DEFINE l_num016 LIKE alz_file.alz09
   DEFINE l_num017 LIKE alz_file.alz09
   DEFINE l_num1 LIKE alz_file.alz09
   DEFINE l_num2 LIKE alz_file.alz09
   DEFINE l_num3 LIKE alz_file.alz09
   DEFINE l_num4 LIKE alz_file.alz09
   DEFINE l_num5 LIKE alz_file.alz09
   DEFINE l_num6 LIKE alz_file.alz09
   DEFINE l_num7 LIKE alz_file.alz09
   DEFINE l_num8 LIKE alz_file.alz09
   DEFINE l_num9 LIKE alz_file.alz09
   DEFINE l_num10 LIKE alz_file.alz09
   DEFINE l_num11 LIKE alz_file.alz09
   DEFINE l_num12 LIKE alz_file.alz09
   DEFINE l_num13 LIKE alz_file.alz09
   DEFINE l_num14 LIKE alz_file.alz09
   DEFINE l_num15 LIKE alz_file.alz09
   DEFINE l_num16 LIKE alz_file.alz09
   DEFINE l_num17 LIKE alz_file.alz09
  #No.FUN-C80102 ---end  --- Add
   DEFINE l_year  LIKE oox_file.oox01   #MOD-D50237
   DEFINE l_month LIKE oox_file.oox02   #MOD-D50237

   #FUN-C80102-add--str--
   LET l_num01 = 0
   LET l_num02 = 0
   LET l_num03 = 0
   LET l_num04 = 0
   LET l_num05 = 0
   LET l_num06 = 0
   LET l_num07 = 0
   LET l_num08 = 0
   LET l_num09 = 0
   LET l_num010 = 0
   LET l_num011 = 0
   LET l_num012 = 0
   LET l_num013 = 0
   LET l_num014 = 0
   LET l_num015 = 0
   LET l_num016 = 0
   LET l_num017 = 0
   LET l_num1 = 0
   LET l_num2 = 0
   LET l_num3 = 0
   LET l_num4 = 0
   LET l_num5 = 0
   LET l_num6 = 0
   LET l_num7 = 0
   LET l_num8 = 0
   LET l_num9 = 0
   LET l_num10 = 0
   LET l_num11 = 0
   LET l_num12 = 0
   LET l_num13 = 0
   LET l_num14 = 0
   LET l_num15 = 0
   LET l_num16 = 0
   LET l_num17 = 0
   #FUN-C80102-add--end--

   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang
   LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('omauser', 'omagrup')
   CALL q191_table()
   CALL q191_get_datas()
   LET g_sql = "INSERT INTO axrq191_tmp",
               " VALUES(?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
              #No.FUN-CB0102 ---start--- Add  33 ?
               "        ?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
               "        ?, ?, ?, ?, ?,    ?, ?, ?, ?, ?, ",
               "        ?, ?, ?,                         ",
              #No.FUN-CB0102 ---end  --- Add
               "        ?, ?, ?, ?, ?,  ",
               "        ?, ?, ?, ?, ? )"       #TQC-C30349  add ?
   PREPARE insert_prep FROM g_sql
   IF STATUS THEN
      CALL cl_err('insert_prep:',status,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF

   #抓報表列印資料
   #--TQC-C30349--add--str--
   IF tm.org = 'Y' THEN
     #No.FUN-C80102 ---start--- Mark
     #LET l_sql = "SELECT oma03, oma032,oma02, oma01,oma23,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,",      #TQC-C30349  add  oma23
     #            "       0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0, alz09f,alz06,alz07 ",
     #No.FUN-C80102 ---end  --- Mark
     #No.FUN-C80102 ---start--- Add
      LET l_sql = "SELECT oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,'',",
                 #"       oma54t,oma55,0,0,0,oma56t,oma57,0,0,0,",
                  "       oma54t,oma55,0,0,0,oma56t,0,oma57,0,0,0,",
                  "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,",
                  "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,oma10,oma67,oma33,oma23,'','',oma15,'',oma14,'',",
                  "       oma68,occ18,occ03,'',oma08,oma25,oma26,'',",
                  "       alz09,alz09f,alz06 ",
     #No.FUN-C80102 ---end  --- Add
                  "  FROM omc_file,oma_file,alz_file,occ_file ",
                  "  LEFT OUTER JOIN oca_file ON(occ_file.occ03=oca_file.oca01)",
                  " WHERE ",tm.wc CLIPPED," AND oma03 = occ01 AND oma01 = omc01 ",
                  "   AND oma03 = alz01 AND alz00 = '2' AND alz02 = ",YEAR(tm.edate),
                  "   AND alz03 = ",MONTH(tm.edate)," AND alz04 = oma01 ",
                  "   AND alz05 = omc02",
                  "   AND alz09 <> 0 "   #FUN-C80102

      #選擇扣除折讓資料
#     IF tm.zr = 'Y' THEN LET l_sql=l_sql CLIPPED," AND alz09f>0" END IF  #FUN-C80102 mark
      #IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 < '",tm.edate,"'"  END IF
      #IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 <= '",tm.edate,"'"  END IF   #MOD-D50090
       IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 <= '",tm.edate,"'"  END IF               #TQC-G10002 add
      PREPARE q191_prepare_01 FROM l_sql
      IF SQLCA.sqlcode != 0 THEN
         CALL cl_err('q191_prepare_01:',SQLCA.sqlcode,1)
         CALL cl_used(g_prog,g_time,2) RETURNING g_time
         EXIT PROGRAM
      END IF
      DECLARE q191_curs_01 CURSOR FOR q191_prepare_01
     #FOREACH q191_curs_01 INTO sr.*,l_alz09f,l_alz06,l_alz07      #FUN-C80102 Mark
      FOREACH q191_curs_01 INTO sr.*,l_alz09,l_alz09f,l_alz06      #FUN-C80102 Add
         IF SQLCA.sqlcode != 0 THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF

       #FUN-C80102--add--str----
        SELECT occ18 INTO sr.occ18 FROM occ_file WHERE occ01 = sr.oma68
        SELECT unique oca02 INTO sr.occ03_desc FROM oca_file WHERE oca01 = sr.occ03
        SELECT gem02 INTO sr.oma15_desc FROM gem_file WHERE gem01 = sr.oma15
        SELECT gen02 INTO sr.oma14_desc FROM gen_file WHERE gen01 = sr.oma14
        SELECT aag02 INTO sr.aag02 FROM aag_file WHERE aag01 = sr.oma18
        SELECT oag02 INTO sr.alz12 FROM oag_file WHERE oag01 = sr.alz12
        IF sr.oma00 matches '2*' THEN
           LET sr.oma54t=sr.oma54t*(-1)
           LET sr.oma55=sr.oma55*(-1)
           LET sr.oma56t=sr.oma56t*(-1)
           LET sr.oma57=sr.oma57*(-1)
        END IF
        #LET sr.oma54t_oma55 = sr.oma54t - sr.oma55
        LET sr.oma54t_oma55 = l_alz09f                 #yinhy130510
        #No.MOD-D50237  --Begin
        #CALL s_ar_oox03(sr.oma01) RETURNING sr.net
        LET sr.net = 0
        LET l_year = YEAR(tm.edate)
        LET l_month = MONTH(tm.edate)
        IF g_ooz.ooz07 = 'Y' THEN
            LET l_sql = "SELECT SUM(oox10) FROM oox_file",
                        " WHERE oox00 ='AR' AND oox03 ='",sr.oma01,"'",
                        "   AND (oox01 < '",l_year,"'",
                        "   OR (oox01 = '",l_year,"'"," AND oox02 <= '",l_month,"'))"
            PREPARE sel_oox FROM l_sql
            EXECUTE sel_oox INTO sr.net
        END IF
        #No.MOD-D50237  --End
        #LET sr.oma56t_oma57 = sr.oma56t + sr.net - sr.oma57
        LET sr.oma56t_oma57 = l_alz09                  #yinhy130510

        IF tm.a = '1' THEN
           CALL s_curr3(sr.oma23,sr.oma02,'M') RETURNING sr.azj041_1
        ELSE
           CALL s_curr3(sr.oma23,sr.alz07,'M') RETURNING sr.azj041_1
        END IF

        SELECT oma12 INTO l_oma12 FROM oma_file WHERE oma01 = sr.oma01
        CALL s_curr3(sr.oma23,l_oma12,'M') RETURNING sr.azj041

        SELECT azi04,azi07 INTO l_azi04,l_azi07 FROM azi_file WHERE azi01 = sr.oma23
        LET sr.azj041_1 = cl_digcut(sr.azj041_1,l_azi07)
        LET sr.azj041 = cl_digcut(sr.azj041,l_azi07)
        LET sr.oma54t = cl_digcut(sr.oma54t,l_azi04)
        LET sr.oma56t = cl_digcut(sr.oma56t,l_azi04)
        LET sr.oma55  = cl_digcut(sr.oma55,l_azi04)
        LET sr.oma57  = cl_digcut(sr.oma57,l_azi04)
        LET sr.oma54t_oma55  = cl_digcut(sr.oma54t_oma55,l_azi04)
        LET sr.oma56t_oma57  = cl_digcut(sr.oma56t_oma57,l_azi04)
       #FUN-C80102--add--end--


         #判斷應付賬款基準日期
         IF tm.a = '2' THEN
           #LET l_date = l_alz07   #FUN-C80102
            LET l_date = sr.alz07  #FUN-C80102
         ELSE
            LET l_date = l_alz06
         END IF
         #LET sr.oma02 = l_date
         LET l_bucket = tm.edate-l_date
   #FUN-C80102-add--str--
   LET l_num01 = 0
   LET l_num02 = 0
   LET l_num03 = 0
   LET l_num04 = 0
   LET l_num05 = 0
   LET l_num06 = 0
   LET l_num07 = 0
   LET l_num08 = 0
   LET l_num09 = 0
   LET l_num010 = 0
   LET l_num011 = 0
   LET l_num012 = 0
   LET l_num013 = 0
   LET l_num014 = 0
   LET l_num015 = 0
   LET l_num016 = 0
   LET l_num017 = 0
   LET l_num1 = 0
   LET l_num2 = 0
   LET l_num3 = 0
   LET l_num4 = 0
   LET l_num5 = 0
   LET l_num6 = 0
   LET l_num7 = 0
   LET l_num8 = 0
   LET l_num9 = 0
   LET l_num10 = 0
   LET l_num11 = 0
   LET l_num12 = 0
   LET l_num13 = 0
   LET l_num14 = 0
   LET l_num15 = 0
   LET l_num16 = 0
   LET l_num17 = 0
   #FUN-C80102-add--end--
         CASE WHEN l_bucket<=g_aly[1].aly04  LET sr.num01=l_alz09f  LET sr.num1=l_alz09f * g_aly[1].aly05/100
                                            LET l_num01=l_alz09    LET l_num1=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[2].aly04  LET sr.num02=l_alz09f  LET sr.num2=l_alz09f * g_aly[2].aly05/100
                                            LET l_num02=l_alz09    LET l_num2=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[3].aly04  LET sr.num03=l_alz09f  LET sr.num3=l_alz09f * g_aly[3].aly05/100
                                            LET l_num03=l_alz09    LET l_num3=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[4].aly04  LET sr.num04=l_alz09f  LET sr.num4=l_alz09f * g_aly[4].aly05/100
                                            LET l_num04=l_alz09    LET l_num4=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[5].aly04  LET sr.num05=l_alz09f  LET sr.num5=l_alz09f * g_aly[5].aly05/100
                                            LET l_num05=l_alz09    LET l_num5=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[6].aly04  LET sr.num06=l_alz09f  LET sr.num6=l_alz09f * g_aly[6].aly05/100
                                            LET l_num06=l_alz09    LET l_num6=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[7].aly04  LET sr.num07=l_alz09f  LET sr.num7=l_alz09f * g_aly[7].aly05/100
                                            LET l_num07=l_alz09    LET l_num7=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[8].aly04  LET sr.num08=l_alz09f  LET sr.num8=l_alz09f * g_aly[8].aly05/100
                                            LET l_num08=l_alz09    LET l_num8=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[9].aly04  LET sr.num09=l_alz09f  LET sr.num9=l_alz09f * g_aly[9].aly05/100
                                            LET l_num09=l_alz09    LET l_num9=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[10].aly04 LET sr.num010=l_alz09f LET sr.num10=l_alz09f * g_aly[10].aly05/100
                                            LET l_num010=l_alz09    LET l_num10=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[11].aly04 LET sr.num011=l_alz09f LET sr.num11=l_alz09f * g_aly[11].aly05/100
                                            LET l_num011=l_alz09    LET l_num11=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[12].aly04 LET sr.num012=l_alz09f LET sr.num12=l_alz09f * g_aly[12].aly05/100
                                            LET l_num012=l_alz09    LET l_num12=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[13].aly04 LET sr.num013=l_alz09f LET sr.num13=l_alz09f * g_aly[13].aly05/100
                                            LET l_num013=l_alz09    LET l_num13=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[14].aly04 LET sr.num014=l_alz09f LET sr.num14=l_alz09f * g_aly[14].aly05/100
                                            LET l_num014=l_alz09    LET l_num14=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[15].aly04 LET sr.num015=l_alz09f LET sr.num15=l_alz09f * g_aly[15].aly05/100
                                            LET l_num015=l_alz09    LET l_num15=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             WHEN l_bucket<=g_aly[16].aly04 LET sr.num016=l_alz09f LET sr.num16=l_alz09f * g_aly[16].aly05/100
                                            LET l_num016=l_alz09    LET l_num16=l_alz09 * g_aly[1].aly05/100  #FUN-C80102 add
             OTHERWISE     LET sr.num017=l_alz09f LET sr.num17=l_alz09f
                           LET l_num017=l_alz09 LET l_num17=l_alz09  #FUN-C80102 add

         END CASE

#FUN-C80102--add--str--
        LET sr.sum_3 = sr.num01+sr.num02+sr.num03+sr.num04+sr.num05+sr.num06+sr.num07+sr.num08+sr.num09+sr.num010+
                       sr.num011+sr.num012+sr.num013+sr.num014+sr.num015+sr.num016+sr.num017   #原幣逾期金額= sum(原幣賬款金額)
        LET sr.sum_4 = l_num01+l_num02+l_num03+l_num04+l_num05+l_num06+l_num07+l_num08+l_num09+l_num010+
                       l_num011+l_num012+l_num013+l_num014+l_num015+l_num016+l_num017          #本幣逾期金額= sum(本幣賬款金額)
        LET sr.sum_2 = sr.oma56t + sr.net - sr.sum_4        #本幣未逾期金額
        LET sr.sum_1 = sr.oma54t - sr.sum_3                 #原幣未逾期金額
        LET sr.sum_5 = (sr.azj041 - sr.azj041_1) * sr.sum_3
        LET sr.sum_1  = cl_digcut(sr.sum_1,l_azi04)
        LET sr.sum_2  = cl_digcut(sr.sum_2,l_azi04)
        LET sr.sum_3  = cl_digcut(sr.sum_3,l_azi04)
        LET sr.sum_4  = cl_digcut(sr.sum_4,l_azi04)
        LET sr.sum_5  = cl_digcut(sr.sum_5,l_azi04)
        LET sr.num1  = cl_digcut(sr.num1,l_azi04)
        LET sr.num2  = cl_digcut(sr.num2,l_azi04)
        LET sr.num3  = cl_digcut(sr.num3,l_azi04)
        LET sr.num4  = cl_digcut(sr.num4,l_azi04)
        LET sr.num5  = cl_digcut(sr.num5,l_azi04)
        LET sr.num6  = cl_digcut(sr.num6,l_azi04)
        LET sr.num7  = cl_digcut(sr.num7,l_azi04)
        LET sr.num8  = cl_digcut(sr.num8,l_azi04)
        LET sr.num9  = cl_digcut(sr.num9,l_azi04)
        LET sr.num10 = cl_digcut(sr.num10,l_azi04)
        LET sr.num11 = cl_digcut(sr.num11,l_azi04)
        LET sr.num12 = cl_digcut(sr.num12,l_azi04)
        LET sr.num13 = cl_digcut(sr.num13,l_azi04)
        LET sr.num14 = cl_digcut(sr.num14,l_azi04)
        LET sr.num15 = cl_digcut(sr.num15,l_azi04)
        LET sr.num16 = cl_digcut(sr.num16,l_azi04)
        LET sr.num17 = cl_digcut(sr.num17,l_azi04)
        LET sr.num01  = cl_digcut(sr.num01,l_azi04)
        LET sr.num02  = cl_digcut(sr.num02,l_azi04)
        LET sr.num03  = cl_digcut(sr.num03,l_azi04)
        LET sr.num04  = cl_digcut(sr.num04,l_azi04)
        LET sr.num05  = cl_digcut(sr.num05,l_azi04)
        LET sr.num06  = cl_digcut(sr.num06,l_azi04)
        LET sr.num07  = cl_digcut(sr.num07,l_azi04)
        LET sr.num08  = cl_digcut(sr.num08,l_azi04)
        LET sr.num09  = cl_digcut(sr.num09,l_azi04)
        LET sr.num010 = cl_digcut(sr.num010,l_azi04)
        LET sr.num011 = cl_digcut(sr.num011,l_azi04)
        LET sr.num012 = cl_digcut(sr.num012,l_azi04)
        LET sr.num013 = cl_digcut(sr.num013,l_azi04)
        LET sr.num014 = cl_digcut(sr.num014,l_azi04)
        LET sr.num015 = cl_digcut(sr.num015,l_azi04)
        LET sr.num016 = cl_digcut(sr.num016,l_azi04)
        LET sr.num017 = cl_digcut(sr.num017,l_azi04)
        #FUN-C80102--add--end---

         EXECUTE insert_prep USING sr.*
      END FOREACH
   ELSE
   #--TQC-C30349--add--end--
     #LET l_sql = "SELECT oma03, occ02,oma02, oma01,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,",  #FUN-BB0038
     #No.FUN-C80102 ---start--- Mark
     #LET l_sql = "SELECT oma03, oma032,oma02, oma01,oma23,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,",  #FUN-BB0038    #TQC-C30349  add oma23
     #            "       0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0, alz09,alz06,alz07 ",
     #No.FUN-C80102 ---end  --- Mark
     #No.FUN-C80102 ---start--- Add
      LET l_sql = "SELECT oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,'',",
                  "       oma54t,oma55,0,0,0,oma56t,0,oma57,0,0,0,",
                  "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,",
                  "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0, oma10,oma67,oma33,oma23,'','',oma15,'',oma14,'',",
                  "       oma68,occ18,occ03,'',oma08,oma25,oma26,'',",
                  "       alz09,alz09f,alz06 ",
     #No.FUN-C80102 ---end  --- Add
                  "  FROM omc_file,oma_file,alz_file,occ_file ",
                  "  LEFT OUTER JOIN oca_file ON(occ_file.occ03=oca_file.oca01)",
                  " WHERE ",tm.wc CLIPPED," AND oma03 = occ01 AND oma01 = omc01 ",
                  "   AND oma03 = alz01 AND alz00 = '2' AND alz02 = ",YEAR(tm.edate),
                  "   AND alz03 = ",MONTH(tm.edate)," AND alz04 = oma01 ",
                  "   AND alz05 = omc02",
                  "   AND alz09 <> 0 "   #FUN-C80102

      #選擇扣除折讓資料
     #IF tm.zr = 'Y' THEN LET l_sql=l_sql CLIPPED," AND alz09>0" END IF   #FUN-C80102 mark
      #IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 < '",tm.edate,"'"  END IF
      #IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 <= '",tm.edate,"'"  END IF   #MOD-D50090
      IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 <= '",tm.edate,"'"  END IF                #TQC-G10002 ad:
     #PREPARE q191_prepare1 FROM l_sql     #FUN-C80102 Mark
      PREPARE q191_prepare_02 FROM l_sql   #FUN-C80102 Add
      IF SQLCA.sqlcode != 0 THEN
         CALL cl_err('q191_prepare1:',SQLCA.sqlcode,1)
         CALL cl_used(g_prog,g_time,2) RETURNING g_time
         EXIT PROGRAM
      END IF
     #DECLARE q191_curs1 CURSOR FOR q191_prepare1                      #FUN-C80102 Mark
     #FOREACH q191_curs1 INTO sr.*,l_alz09,l_alz06,l_alz07             #FUN-C80102 Mark
      DECLARE q191_curs_02 CURSOR FOR q191_prepare_02                  #FUN-C80102 Add
      FOREACH q191_curs_02 INTO sr.*,l_alz09,l_alz09f,l_alz06          #FUN-C80102 Add
         IF SQLCA.sqlcode != 0 THEN
            CALL cl_err('foreach:',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF

        #FUN-C80102--add--str----
        SELECT occ18 INTO sr.occ18 FROM occ_file WHERE occ01 = sr.oma68
        SELECT unique aag02 INTO sr.aag02 FROM aag_file WHERE aag01 = sr.oma18
        SELECT unique oca02 INTO sr.occ03_desc FROM oca_file WHERE oca01 = sr.occ03
        SELECT gem02 INTO sr.oma15_desc FROM gem_file WHERE gem01 = sr.oma15
        SELECT gen02 INTO sr.oma14_desc FROM gen_file WHERE gen01 = sr.oma14
        SELECT oag02 INTO sr.alz12 FROM oag_file WHERE oag01 = sr.alz12
        IF sr.oma00 matches '2*' THEN
           LET sr.oma54t=sr.oma54t*(-1)
           LET sr.oma55=sr.oma55*(-1)
           LET sr.oma56t=sr.oma56t*(-1)
           LET sr.oma57=sr.oma57*(-1)
        END IF
        #LET sr.oma54t_oma55 = sr.oma54t - sr.oma55
        LET sr.oma54t_oma55 = l_alz09f             #yinhy130510
        #No.MOD-D50237  --Begin
        #CALL s_ar_oox03(sr.oma01) RETURNING sr.net
        LET sr.net = 0
        LET l_year = YEAR(tm.edate)
        LET l_month = MONTH(tm.edate)
        IF g_ooz.ooz07 = 'Y' THEN
            LET l_sql = "SELECT SUM(oox10) FROM oox_file",
                        " WHERE oox00 ='AR' AND oox03 ='",sr.oma01,"'",
                        "   AND (oox01 < '",l_year,"'",
                        "   OR (oox01 = '",l_year,"'"," AND oox02 <= '",l_month,"'))"
            PREPARE sel_oox1 FROM l_sql
            EXECUTE sel_oox1 INTO sr.net
        END IF
        #No.MOD-D50237  --End
        #LET sr.oma56t_oma57 = sr.oma56t + sr.net - sr.oma57
        LET sr.oma56t_oma57 = l_alz09         #yinhy130510
        IF tm.a = '1' THEN
           CALL s_curr3(sr.oma23,sr.oma02,'M') RETURNING sr.azj041_1
        ELSE
           CALL s_curr3(sr.oma23,sr.alz07,'M') RETURNING sr.azj041_1
        END IF

        SELECT oma12 INTO l_oma12 FROM oma_file WHERE oma01 = sr.oma01
        CALL s_curr3(sr.oma23,l_oma12,'M') RETURNING sr.azj041

        SELECT azi04,azi07 INTO l_azi04,l_azi07 FROM azi_file WHERE azi01 = sr.oma23
        LET sr.azj041_1 = cl_digcut(sr.azj041_1,l_azi07)
        LET sr.azj041 = cl_digcut(sr.azj041,l_azi07)
        LET sr.oma54t = cl_digcut(500.1312,l_azi04)
        LET sr.oma56t = cl_digcut(sr.oma56t,l_azi04)
        LET sr.oma55  = cl_digcut(sr.oma55,l_azi04)
        LET sr.oma57  = cl_digcut(sr.oma57,l_azi04)
        LET sr.oma54t_oma55  = cl_digcut(sr.oma54t_oma55,l_azi04)
        LET sr.oma56t_oma57  = cl_digcut(sr.oma56t_oma57,l_azi04)
        #FUN-C80102--add--end--

         #判斷應付賬款基準日期
         IF tm.a = '2' THEN
           #LET l_date = l_alz07   #FUN-C80102
            LET l_date = sr.alz07  #FUN-C80102
         ELSE
            LET l_date = l_alz06
         END IF
         #LET sr.oma02 = l_date
         LET l_bucket = tm.edate-l_date
   #FUN-C80102-add--str--
   LET l_num01 = 0
   LET l_num02 = 0
   LET l_num03 = 0
   LET l_num04 = 0
   LET l_num05 = 0
   LET l_num06 = 0
   LET l_num07 = 0
   LET l_num08 = 0
   LET l_num09 = 0
   LET l_num010 = 0
   LET l_num011 = 0
   LET l_num012 = 0
   LET l_num013 = 0
   LET l_num014 = 0
   LET l_num015 = 0
   LET l_num016 = 0
   LET l_num017 = 0
   LET l_num1 = 0
   LET l_num2 = 0
   LET l_num3 = 0
   LET l_num4 = 0
   LET l_num5 = 0
   LET l_num6 = 0
   LET l_num7 = 0
   LET l_num8 = 0
   LET l_num9 = 0
   LET l_num10 = 0
   LET l_num11 = 0
   LET l_num12 = 0
   LET l_num13 = 0
   LET l_num14 = 0
   LET l_num15 = 0
   LET l_num16 = 0
   LET l_num17 = 0
   #FUN-C80102-add--end--
         CASE WHEN l_bucket<=g_aly[1].aly04  LET sr.num01=l_alz09  LET sr.num1=l_alz09 * g_aly[1].aly05/100
                                             LET l_num01=l_alz09f    LET l_num1=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[2].aly04  LET sr.num02=l_alz09  LET sr.num2=l_alz09 * g_aly[2].aly05/100
                                             LET l_num02=l_alz09f    LET l_num2=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[3].aly04  LET sr.num03=l_alz09  LET sr.num3=l_alz09 * g_aly[3].aly05/100
                                             LET l_num03=l_alz09f    LET l_num3=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[4].aly04  LET sr.num04=l_alz09  LET sr.num4=l_alz09 * g_aly[4].aly05/100
                                             LET l_num04=l_alz09f    LET l_num4=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[5].aly04  LET sr.num05=l_alz09  LET sr.num5=l_alz09 * g_aly[5].aly05/100
                                             LET l_num05=l_alz09f    LET l_num5=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[6].aly04  LET sr.num06=l_alz09  LET sr.num6=l_alz09 * g_aly[6].aly05/100
                                             LET l_num06=l_alz09f    LET l_num6=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[7].aly04  LET sr.num07=l_alz09  LET sr.num7=l_alz09 * g_aly[7].aly05/100
                                             LET l_num07=l_alz09f    LET l_num7=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[8].aly04  LET sr.num08=l_alz09  LET sr.num8=l_alz09 * g_aly[8].aly05/100
                                             LET l_num08=l_alz09f    LET l_num8=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[9].aly04  LET sr.num09=l_alz09  LET sr.num9=l_alz09 * g_aly[9].aly05/100
                                             LET l_num09=l_alz09f    LET l_num9=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[10].aly04 LET sr.num010=l_alz09 LET sr.num10=l_alz09 * g_aly[10].aly05/100
                                             LET l_num010=l_alz09f    LET l_num10=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[11].aly04 LET sr.num011=l_alz09 LET sr.num11=l_alz09 * g_aly[11].aly05/100
                                             LET l_num011=l_alz09f    LET l_num11=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[12].aly04 LET sr.num012=l_alz09 LET sr.num12=l_alz09 * g_aly[12].aly05/100
                                             LET l_num012=l_alz09f    LET l_num12=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[13].aly04 LET sr.num013=l_alz09 LET sr.num13=l_alz09 * g_aly[13].aly05/100
                                             LET l_num013=l_alz09f    LET l_num13=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[14].aly04 LET sr.num014=l_alz09 LET sr.num14=l_alz09 * g_aly[14].aly05/100
                                             LET l_num014=l_alz09f    LET l_num14=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[15].aly04 LET sr.num015=l_alz09 LET sr.num15=l_alz09 * g_aly[15].aly05/100
                                             LET l_num015=l_alz09f    LET l_num15=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              WHEN l_bucket<=g_aly[16].aly04 LET sr.num016=l_alz09 LET sr.num16=l_alz09 * g_aly[16].aly05/100
                                             LET l_num016=l_alz09f    LET l_num16=l_alz09f * g_aly[1].aly05/100  #FUN-C80102 add
              OTHERWISE     LET sr.num017=l_alz09 LET sr.num17=l_alz09
                            LET l_num017=l_alz09f LET l_num17=l_alz09f  #FUN-C80102 add
         END CASE
        #FUN-C80102--add--str---
        LET sr.sum_3 = l_num01+l_num02+l_num03+l_num04+l_num05+l_num06+l_num07+l_num08+l_num09+l_num010+
                       l_num011+l_num012+l_num013+l_num014+l_num015+l_num016+l_num017          #原幣逾期金額= sum(原幣賬款金額)
        LET sr.sum_4 = sr.num01+sr.num02+sr.num03+sr.num04+sr.num05+sr.num06+sr.num07+sr.num08+sr.num09+sr.num010+
                       sr.num011+sr.num012+sr.num013+sr.num014+sr.num015+sr.num016+sr.num017   #本幣逾期金額= sum(本幣賬款金額)
        LET sr.sum_2 = sr.oma56t + sr.net - sr.sum_4        #本幣未逾期金額
        LET sr.sum_1 = sr.oma54t - sr.sum_3                 #原幣未逾期金額
        LET sr.sum_5 = (sr.azj041 - sr.azj041_1) * sr.sum_3
        LET sr.sum_5 = 0
        LET sr.sum_1  = cl_digcut(sr.sum_1,l_azi04)
        LET sr.sum_2  = cl_digcut(sr.sum_2,l_azi04)
        LET sr.sum_3  = cl_digcut(sr.sum_3,l_azi04)
        LET sr.sum_4  = cl_digcut(sr.sum_4,l_azi04)
        LET sr.sum_5  = cl_digcut(sr.sum_5,l_azi04)
        LET sr.num1  = cl_digcut(sr.num1,l_azi04)
        LET sr.num2  = cl_digcut(sr.num2,l_azi04)
        LET sr.num3  = cl_digcut(sr.num3,l_azi04)
        LET sr.num4  = cl_digcut(sr.num4,l_azi04)
        LET sr.num5  = cl_digcut(sr.num5,l_azi04)
        LET sr.num6  = cl_digcut(sr.num6,l_azi04)
        LET sr.num7  = cl_digcut(sr.num7,l_azi04)
        LET sr.num8  = cl_digcut(sr.num8,l_azi04)
        LET sr.num9  = cl_digcut(sr.num9,l_azi04)
        LET sr.num10 = cl_digcut(sr.num10,l_azi04)
        LET sr.num11 = cl_digcut(sr.num11,l_azi04)
        LET sr.num12 = cl_digcut(sr.num12,l_azi04)
        LET sr.num13 = cl_digcut(sr.num13,l_azi04)
        LET sr.num14 = cl_digcut(sr.num14,l_azi04)
        LET sr.num15 = cl_digcut(sr.num15,l_azi04)
        LET sr.num16 = cl_digcut(sr.num16,l_azi04)
        LET sr.num17 = cl_digcut(sr.num17,l_azi04)
        LET sr.num01  = cl_digcut(sr.num01,l_azi04)
        LET sr.num02  = cl_digcut(sr.num02,l_azi04)
        LET sr.num03  = cl_digcut(sr.num03,l_azi04)
        LET sr.num04  = cl_digcut(sr.num04,l_azi04)
        LET sr.num05  = cl_digcut(sr.num05,l_azi04)
        LET sr.num06  = cl_digcut(sr.num06,l_azi04)
        LET sr.num07  = cl_digcut(sr.num07,l_azi04)
        LET sr.num08  = cl_digcut(sr.num08,l_azi04)
        LET sr.num09  = cl_digcut(sr.num09,l_azi04)
        LET sr.num010 = cl_digcut(sr.num010,l_azi04)
        LET sr.num011 = cl_digcut(sr.num011,l_azi04)
        LET sr.num012 = cl_digcut(sr.num012,l_azi04)
        LET sr.num013 = cl_digcut(sr.num013,l_azi04)
        LET sr.num014 = cl_digcut(sr.num014,l_azi04)
        LET sr.num015 = cl_digcut(sr.num015,l_azi04)
        LET sr.num016 = cl_digcut(sr.num016,l_azi04)
        LET sr.num017 = cl_digcut(sr.num017,l_azi04)

        #FUN-C80102--add--end---
         EXECUTE insert_prep USING sr.*
      END FOREACH
   #--TQC-C30349--add--str--
   END IF
   #--TQC-C30349--add--end--
END FUNCTION

FUNCTION axrq191_t()
#FUN-C80102--mark--str--
#
#  IF tm.detail = 'Y' THEN
#     CALL cl_set_comp_visible("oma01,oma02",TRUE)
#     CALL cl_set_act_visible('find_detail',FALSE)
#  ELSE
#     CALL cl_set_comp_visible("oma01,oma02",FALSE)
#     CALL cl_set_act_visible('find_detail',TRUE)
#  END IF
#FUN-C80102--mark--end--
   #--TQC-C30349--add--str--
   IF tm.org = 'Y' THEN
      CALL cl_set_comp_visible("oma23,oma23_1,oma54t_oma55,oma54t_oma55_1,sum_3,sum_3_1 ",TRUE)   #No.FUN-C80102   Add
#     CALL cl_set_comp_visible("oma23",TRUE)        #FUN-C80102 mark
#     CALL cl_set_act_visible('find_detail',FALSE)  #FUN-C80102 mark
   ELSE
      CALL cl_set_comp_visible("oma23,oma23_1,oma54t,oma55,oma54t_oma55,sum_1,sum_3,sum_1_1,sum_3_1,oma54t_1,oma55_1,oma54t_oma55_1 ",FALSE)  #FUN-C80102 add
#     CALL cl_set_comp_visible("oma23",FALSE)       #FUN-C80102 mark
#     CALL cl_set_act_visible('find_detail',TRUE)   #FUN-C80102 mark
   END  IF
   #--TQC-C30349--add--end--
   CLEAR FORM
   CALL g_oma.clear()
   DISPLAY tm.a      TO TYPE
   DISPLAY tm.edate  TO edate
  #CALL q191_b_fill()  #FUN-C80102 mark
   CALL q191_show()  #FUN-C80102 add
   CALL q191_set_title()
   CALL q191_set_title_1()  #FUN-C80102
   CALL cl_show_fld_cont()
END FUNCTION

#FUN-C80102--add--str---
FUNCTION q191_b_fill()
DEFINE l_oma03   LIKE oma_file.oma03
DEFINE g_tot11   LIKE oma_file.oma56t
DEFINE g_tot21   LIKE oma_file.oma56t
DEFINE g_tot31   LIKE oma_file.oma56t
DEFINE g_tot41   LIKE oma_file.oma56t
DEFINE g_tot51   LIKE oma_file.oma56t
DEFINE l_azi07   LIKE azi_file.azi07        #yinhy130619
DEFINE l_azi04   LIKE azi_file.azi04        #yinhy130619

   IF cl_null(g_filter_wc) THEN LET g_filter_wc=" 1=1" END IF
  #LET g_sql = "SELECT * FROM axrq191_tmp ", #FUN-CB0146 mark
  #FUN-CB0146--add--str--
  LET g_sql="SELECT oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,aag02,",
            "       oma54t,oma55,oma54t_oma55,sum_1,sum_3,oma56t,net,oma57,",
            "       oma56t_oma57,sum_2,sum_4,sum_5,",
            "       num01,num1,num02,num2,num03,num3,num04,num4,num05,num5,",
            "       num06,num6,num07,num7,num08,num8,num09,num9,num010,num10,",
            "       num011,num11,num012,num12,num013,num13,num014,num14,",
            "       num015,num15,num016,num16,num017,num17,",
            "       oma10,oma67,oma33,oma23,azj041_1,azj041,oma15,oma15_desc,",
            "       oma14,oma14_desc,oma68,occ18,occ03,occ03_desc,oma08,oma25,",
            "       oma26,azp01 ",
            "  FROM axrq191_tmp1 ",
  #FUN-CB0146--add--end
               " WHERE ",g_filter_wc CLIPPED,
               " ORDER BY oma03,oma032,oma01,oma02 "

   PREPARE axrq191_pb FROM g_sql
   DECLARE oma_curs  CURSOR FOR axrq191_pb        #CURSOR

   CALL g_oma.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   LET g_tot11 = 0
   LET g_tot21 = 0
   LET g_tot31 = 0
   LET g_tot41 = 0
   LET g_tot51 = 0
   FOREACH oma_curs INTO g_oma[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      #No.yinhy130619  --Begin
      #130619--wangrr--mark--str--
      #SELECT azi04,azi07 INTO l_azi04,l_azi07 FROM azi_file WHERE azi01 = g_oma[g_cnt].oma23
      #LET g_oma[g_cnt].azj041_1 = cl_digcut(g_oma[g_cnt].azj041_1,l_azi07)
      #LET g_oma[g_cnt].azj041 = cl_digcut(g_oma[g_cnt].azj041,l_azi07)
      #LET g_oma[g_cnt].oma54t = cl_digcut(g_oma[g_cnt].oma54t,l_azi04)
      #LET g_oma[g_cnt].oma55  = cl_digcut(g_oma[g_cnt].oma55,l_azi04)
      #LET g_oma[g_cnt].oma54t_oma55  = cl_digcut(g_oma[g_cnt].oma54t_oma55,l_azi04)
      #LET g_oma[g_cnt].sum_1  = cl_digcut(g_oma[g_cnt].sum_1,l_azi04)
      #LET g_oma[g_cnt].sum_3  = cl_digcut(g_oma[g_cnt].sum_3,l_azi04)
      #LET g_oma[g_cnt].oma56t = cl_digcut(g_oma[g_cnt].oma56t,l_azi04)
      #LET g_oma[g_cnt].net = cl_digcut(g_oma[g_cnt].oma56t,l_azi04)
      #LET g_oma[g_cnt].oma57  = cl_digcut(g_oma[g_cnt].oma57,l_azi04)
      #LET g_oma[g_cnt].oma56t_oma57  = cl_digcut(g_oma[g_cnt].oma56t_oma57,l_azi04)
      #LET g_oma[g_cnt].sum_2  = cl_digcut(g_oma[g_cnt].sum_2,l_azi04)
      #LET g_oma[g_cnt].sum_4  = cl_digcut(g_oma[g_cnt].sum_4,l_azi04)
      #LET g_oma[g_cnt].sum_5  = cl_digcut(g_oma[g_cnt].sum_5,l_azi04)
      #LET g_oma[g_cnt].sum1  = cl_digcut(g_oma[g_cnt].sum1,l_azi04)
      #LET g_oma[g_cnt].sum2  = cl_digcut(g_oma[g_cnt].sum2,l_azi04)
      #LET g_oma[g_cnt].sum3  = cl_digcut(g_oma[g_cnt].sum3,l_azi04)
      #LET g_oma[g_cnt].sum4  = cl_digcut(g_oma[g_cnt].sum4,l_azi04)
      #LET g_oma[g_cnt].sum5  = cl_digcut(g_oma[g_cnt].sum5,l_azi04)
      #LET g_oma[g_cnt].sum6  = cl_digcut(g_oma[g_cnt].sum6,l_azi04)
      #LET g_oma[g_cnt].sum7  = cl_digcut(g_oma[g_cnt].sum7,l_azi04)
      #LET g_oma[g_cnt].sum8  = cl_digcut(g_oma[g_cnt].sum8,l_azi04)
      #LET g_oma[g_cnt].sum9  = cl_digcut(g_oma[g_cnt].sum9,l_azi04)
      #LET g_oma[g_cnt].sum10 = cl_digcut(g_oma[g_cnt].sum10,l_azi04)
      #LET g_oma[g_cnt].sum11 = cl_digcut(g_oma[g_cnt].sum11,l_azi04)
      #LET g_oma[g_cnt].sum12 = cl_digcut(g_oma[g_cnt].sum12,l_azi04)
      #LET g_oma[g_cnt].sum13 = cl_digcut(g_oma[g_cnt].sum13,l_azi04)
      #LET g_oma[g_cnt].sum14 = cl_digcut(g_oma[g_cnt].sum14,l_azi04)
      #LET g_oma[g_cnt].sum15 = cl_digcut(g_oma[g_cnt].sum15,l_azi04)
      #LET g_oma[g_cnt].sum16 = cl_digcut(g_oma[g_cnt].sum16,l_azi04)
      #LET g_oma[g_cnt].sum17 = cl_digcut(g_oma[g_cnt].sum17,l_azi04)
      #LET g_oma[g_cnt].sum01  = cl_digcut(g_oma[g_cnt].sum01,l_azi04)
      #LET g_oma[g_cnt].sum02  = cl_digcut(g_oma[g_cnt].sum02,l_azi04)
      #LET g_oma[g_cnt].sum03  = cl_digcut(g_oma[g_cnt].sum03,l_azi04)
      #LET g_oma[g_cnt].sum04  = cl_digcut(g_oma[g_cnt].sum04,l_azi04)
      #LET g_oma[g_cnt].sum05  = cl_digcut(g_oma[g_cnt].sum05,l_azi04)
      #LET g_oma[g_cnt].sum06  = cl_digcut(g_oma[g_cnt].sum06,l_azi04)
      #LET g_oma[g_cnt].sum07  = cl_digcut(g_oma[g_cnt].sum07,l_azi04)
      #LET g_oma[g_cnt].sum08  = cl_digcut(g_oma[g_cnt].sum08,l_azi04)
      #LET g_oma[g_cnt].sum09  = cl_digcut(g_oma[g_cnt].sum09,l_azi04)
      #LET g_oma[g_cnt].sum010 = cl_numfor(g_oma[g_cnt].sum010,l_azi04)
      #LET g_oma[g_cnt].sum011 = cl_digcut(g_oma[g_cnt].sum011,l_azi04)
      #LET g_oma[g_cnt].sum012 = cl_digcut(g_oma[g_cnt].sum012,l_azi04)
      #LET g_oma[g_cnt].sum013 = cl_digcut(g_oma[g_cnt].sum013,l_azi04)
      #LET g_oma[g_cnt].sum014 = cl_digcut(g_oma[g_cnt].sum014,l_azi04)
      #LET g_oma[g_cnt].sum015 = cl_digcut(g_oma[g_cnt].sum015,l_azi04)
      #LET g_oma[g_cnt].sum016 = cl_digcut(g_oma[g_cnt].sum016,l_azi04)
      #LET g_oma[g_cnt].sum017 = cl_digcut(g_oma[g_cnt].sum017,l_azi04)
      #130619--wangrr--mark--end
      #No.yinhy130619  --End
      LET g_tot11 = g_tot11 + g_oma[g_cnt].oma56t
      LET g_tot21 = g_tot21 + g_oma[g_cnt].oma57
      LET g_tot31 = g_tot31 + g_oma[g_cnt].oma56t_oma57
      LET g_tot41 = g_tot41 + g_oma[g_cnt].sum_2
      LET g_tot51 = g_tot51 + g_oma[g_cnt].sum_4
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   #No.yinhy130619  --Begin
   LET g_tot11 = cl_digcut(g_tot11,g_azi04)
   LET g_tot21 = cl_digcut(g_tot21,g_azi04)
   LET g_tot31 = cl_digcut(g_tot31,g_azi04)
   LET g_tot41 = cl_digcut(g_tot41,g_azi04)
  #LET g_tot51 = cl_digcut(g_tot41,g_azi04) #zhouxm150915 mark
   LET g_tot51 = cl_digcut(g_tot51,g_azi04) #zhouxm150915 add
   #No.yinhy130619  --End
   DISPLAY g_tot11 TO FORMONLY.oma56t_tot1
   DISPLAY g_tot21 TO FORMONLY.oma57_tot1
   DISPLAY g_tot31 TO FORMONLY.oma56t_oma57_tot1
   DISPLAY g_tot41 TO FORMONLY.sum_2_tot1
   DISPLAY g_tot51 TO FORMONLY.sum_4_tot1
   CALL g_oma.deleteElement(g_cnt)
   LET g_rec_b = g_cnt - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
END FUNCTION

FUNCTION q191_b_fill_2()
DEFINE l_oma23  LIKE oma_file.oma23
DEFINE g_tot1   LIKE oma_file.oma56t
DEFINE g_tot2   LIKE oma_file.oma56t
DEFINE g_tot3   LIKE oma_file.oma56t
DEFINE g_tot4   LIKE oma_file.oma56t
DEFINE g_tot5   LIKE oma_file.oma56t

   CALL q191_set_title_1()
   CALL g_oma_1.clear()

   LET g_rec_b2 = 0
   LET g_cnt = 1

   LET g_tot1 = 0
   LET g_tot2 = 0
   LET g_tot3 = 0
   LET g_tot4 = 0
   LET g_tot5 = 0
   IF tm.d = 'Y' THEN
     #LET g_sql = " SELECT distinct oma23 FROM axrq191_tmp ORDER BY oma23" #FUN-CB0146 mark
      LET g_sql = " SELECT distinct oma23 FROM axrq191_tmp1 ORDER BY oma23" #FUN-CB0146

      PREPARE q191_bp_d FROM g_sql
      DECLARE q191_curs_d CURSOR FOR q191_bp_d
      FOREACH q191_curs_d INTO l_oma23
         CALL q191_get_sum(l_oma23)
         LET g_tot1 = g_tot1 + g_oma_1[g_cnt].oma56t
         LET g_tot2 = g_tot2 + g_oma_1[g_cnt].oma57
         LET g_tot3 = g_tot3 + g_oma_1[g_cnt].oma56t_oma57
         LET g_tot4 = g_tot4 + g_oma_1[g_cnt].sum_2
         LET g_tot5 = g_tot5 + g_oma_1[g_cnt].sum_4
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
         END IF
      END FOREACH
      DISPLAY g_tot1 TO FORMONLY.oma56t_tot
      DISPLAY g_tot2 TO FORMONLY.oma57_tot
      DISPLAY g_tot3 TO FORMONLY.oma56t_oma57_tot
      DISPLAY g_tot4 TO FORMONLY.sum_2_tot
      DISPLAY g_tot5 TO FORMONLY.sum_4_tot
   ELSE
      CALL q191_get_sum('')
   END IF
END FUNCTION

FUNCTION q191_get_sum(p_oma23)
DEFINE p_oma23 LIKE oma_file.oma23
DEFINE l_tot1 LIKE oma_file.oma56t
DEFINE l_tot2 LIKE oma_file.oma56t
DEFINE l_tot3 LIKE oma_file.oma56t
DEFINE l_tot4 LIKE oma_file.oma56t
DEFINE l_tot5 LIKE oma_file.oma56t
DEFINE l_tot6 LIKE oma_file.oma56t
DEFINE l_tot7 LIKE oma_file.oma56t
DEFINE l_tot8 LIKE oma_file.oma56t
DEFINE l_tot9 LIKE oma_file.oma56t
DEFINE l_tot10 LIKE oma_file.oma56t
DEFINE l_tot11 LIKE oma_file.oma56t
DEFINE l_tot12 LIKE oma_file.oma56t
DEFINE l_tot13 LIKE oma_file.oma56t
DEFINE l_tot14 LIKE oma_file.oma56t
DEFINE l_tot15 LIKE oma_file.oma56t
DEFINE l_tot16 LIKE oma_file.oma56t
DEFINE l_tot17 LIKE oma_file.oma56t
DEFINE l_tot18 LIKE oma_file.oma56t
DEFINE l_tot19 LIKE oma_file.oma56t
DEFINE l_tot20 LIKE oma_file.oma56t
DEFINE l_tot21 LIKE oma_file.oma56t
DEFINE l_tot22 LIKE oma_file.oma56t
DEFINE l_tot23 LIKE oma_file.oma56t
DEFINE l_tot24 LIKE oma_file.oma56t
DEFINE l_tot25 LIKE oma_file.oma56t
DEFINE l_tot26 LIKE oma_file.oma56t
DEFINE l_tot27 LIKE oma_file.oma56t
DEFINE l_tot28 LIKE oma_file.oma56t
DEFINE l_tot12_1 LIKE oma_file.oma56t
DEFINE l_tot13_1 LIKE oma_file.oma56t
DEFINE l_tot14_1 LIKE oma_file.oma56t
DEFINE l_tot15_1 LIKE oma_file.oma56t
DEFINE l_tot16_1 LIKE oma_file.oma56t
DEFINE l_tot17_1 LIKE oma_file.oma56t
DEFINE l_tot18_1 LIKE oma_file.oma56t
DEFINE l_tot19_1 LIKE oma_file.oma56t
DEFINE l_tot20_1 LIKE oma_file.oma56t
DEFINE l_tot21_1 LIKE oma_file.oma56t
DEFINE l_tot22_1 LIKE oma_file.oma56t
DEFINE l_tot23_1 LIKE oma_file.oma56t
DEFINE l_tot24_1 LIKE oma_file.oma56t
DEFINE l_tot25_1 LIKE oma_file.oma56t
DEFINE l_tot26_1 LIKE oma_file.oma56t
DEFINE l_tot27_1 LIKE oma_file.oma56t
DEFINE l_tot28_1 LIKE oma_file.oma56t
DEFINE l_occ45   LIKE occ_file.occ45

LET l_tot1 = 0   LET l_tot2 = 0
LET l_tot3 = 0   LET l_tot4 = 0
LET l_tot5 = 0   LET l_tot6 = 0
LET l_tot7 = 0   LET l_tot8 = 0
LET l_tot9 = 0   LET l_tot10 = 0 LET l_tot11 = 0
LET l_tot12 = 0  LET l_tot12_1 = 0
LET l_tot13 = 0  LET l_tot13_1 = 0
LET l_tot14 = 0  LET l_tot14_1 = 0
LET l_tot15 = 0  LET l_tot15_1 = 0
LET l_tot16 = 0  LET l_tot16_1 = 0
LET l_tot17 = 0  LET l_tot17_1 = 0
LET l_tot18 = 0  LET l_tot18_1 = 0
LET l_tot19 = 0  LET l_tot19_1 = 0
LET l_tot20 = 0  LET l_tot20_1 = 0
LET l_tot21 = 0  LET l_tot21_1 = 0
LET l_tot22 = 0  LET l_tot22_1 = 0
LET l_tot23 = 0  LET l_tot23_1 = 0
LET l_tot24 = 0  LET l_tot24_1 = 0
LET l_tot25 = 0  LET l_tot25_1 = 0
LET l_tot26 = 0  LET l_tot26_1 = 0
LET l_tot27 = 0  LET l_tot27_1 = 0
LET l_tot28 = 0  LET l_tot28_1 = 0
   CASE tm.u
     WHEN '1'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT '','',oma03,'','','','','','','','',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT '','',oma03,'','','','','','','','','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),'',SUM(num01),SUM(num1),SUM(num02),SUM(num2), ",
                    "       SUM(num03),SUM(num3),SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07), ",
                    "       SUM(num7),SUM(num08),SUM(num8),SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),",
                    "       SUM(num012),SUM(num12),SUM(num013),SUM(num13),SUM(num014),SUM(num14),SUM(num015),SUM(num15), ",
                    "       SUM(num016),SUM(num16),SUM(num017),SUM(num17) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND  oma23 = '",p_oma23,"' " END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03,oma23 ",
                    " ORDER BY oma03,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03 ",
                    " ORDER BY oma03 "
     END IF

        PREPARE q191_pb1 FROM g_sql
        DECLARE q191_curs1 CURSOR FOR q191_pb1
        FOREACH q191_curs1 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
       #SELECT occ18 INTO g_oma_1[g_cnt].occ18 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma68
        SELECT oma032 INTO g_oma_1[g_cnt].oma032 FROM oma_file WHERE oma03 = g_oma_1[g_cnt].oma03
        SELECT occ45 INTO l_occ45 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma03
        SELECT oag02 INTO g_oma_1[g_cnt].occ45 FROM oag_file WHERE oag01 = l_occ45
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot12 = l_tot12 + g_oma_1[g_cnt].sum01
           LET l_tot13 = l_tot13 + g_oma_1[g_cnt].sum02
           LET l_tot14 = l_tot14 + g_oma_1[g_cnt].sum03
           LET l_tot15 = l_tot15 + g_oma_1[g_cnt].sum04
           LET l_tot16 = l_tot16 + g_oma_1[g_cnt].sum05
           LET l_tot17 = l_tot17 + g_oma_1[g_cnt].sum06
           LET l_tot18 = l_tot18 + g_oma_1[g_cnt].sum07
           LET l_tot19 = l_tot19 + g_oma_1[g_cnt].sum08
           LET l_tot20 = l_tot20 + g_oma_1[g_cnt].sum09
           LET l_tot21 = l_tot21 + g_oma_1[g_cnt].sum010
           LET l_tot22 = l_tot22 + g_oma_1[g_cnt].sum011
           LET l_tot23 = l_tot23 + g_oma_1[g_cnt].sum012
           LET l_tot24 = l_tot24 + g_oma_1[g_cnt].sum013
           LET l_tot25 = l_tot25 + g_oma_1[g_cnt].sum014
           LET l_tot26 = l_tot26 + g_oma_1[g_cnt].sum015
           LET l_tot27 = l_tot27 + g_oma_1[g_cnt].sum016
           LET l_tot28 = l_tot28 + g_oma_1[g_cnt].sum017
           LET l_tot12_1 = l_tot12_1 + g_oma_1[g_cnt].sum1
           LET l_tot13_1 = l_tot13_1 + g_oma_1[g_cnt].sum2
           LET l_tot14_1 = l_tot14_1 + g_oma_1[g_cnt].sum3
           LET l_tot15_1 = l_tot15_1 + g_oma_1[g_cnt].sum4
           LET l_tot16_1 = l_tot16_1 + g_oma_1[g_cnt].sum5
           LET l_tot17_1 = l_tot17_1 + g_oma_1[g_cnt].sum6
           LET l_tot18_1 = l_tot18_1 + g_oma_1[g_cnt].sum7
           LET l_tot19_1 = l_tot19_1 + g_oma_1[g_cnt].sum8
           LET l_tot20_1 = l_tot20_1 + g_oma_1[g_cnt].sum9
           LET l_tot21_1 = l_tot21_1 + g_oma_1[g_cnt].sum10
           LET l_tot22_1 = l_tot22_1 + g_oma_1[g_cnt].sum11
           LET l_tot23_1 = l_tot23_1 + g_oma_1[g_cnt].sum12
           LET l_tot24_1 = l_tot24_1 + g_oma_1[g_cnt].sum13
           LET l_tot25_1 = l_tot25_1 + g_oma_1[g_cnt].sum14
           LET l_tot26_1 = l_tot26_1 + g_oma_1[g_cnt].sum15
           LET l_tot27_1 = l_tot27_1 + g_oma_1[g_cnt].sum16
           LET l_tot28_1 = l_tot28_1 + g_oma_1[g_cnt].sum17
        END IF
        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

     WHEN '2'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT '','','','','','','',oma15,'','','',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT '','','','','','','',oma15,'','','','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),'',SUM(num01),SUM(num1),SUM(num02),SUM(num2), ",
                    "       SUM(num03),SUM(num3),SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07), ",
                    "       SUM(num7),SUM(num08),SUM(num8),SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),",
                    "       SUM(num012),SUM(num12),SUM(num013),SUM(num13),SUM(num014),SUM(num14),SUM(num015),SUM(num15), ",
                    "       SUM(num016),SUM(num16),SUM(num017),SUM(num17) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND oma23 = '",p_oma23,"' "  END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma15,oma23 ",
                    " ORDER BY oma15,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma15 ",
                    " ORDER BY oma15 "
     END IF

        PREPARE q191_pb2 FROM g_sql
        DECLARE q191_curs2 CURSOR FOR q191_pb2
        FOREACH q191_curs2 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
        SELECT gem02 INTO g_oma_1[g_cnt].oma15_desc FROM gem_file WHERE gem01 = g_oma_1[g_cnt].oma15
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot12 = l_tot12 + g_oma_1[g_cnt].sum01
           LET l_tot13 = l_tot13 + g_oma_1[g_cnt].sum02
           LET l_tot14 = l_tot14 + g_oma_1[g_cnt].sum03
           LET l_tot15 = l_tot15 + g_oma_1[g_cnt].sum04
           LET l_tot16 = l_tot16 + g_oma_1[g_cnt].sum05
           LET l_tot17 = l_tot17 + g_oma_1[g_cnt].sum06
           LET l_tot18 = l_tot18 + g_oma_1[g_cnt].sum07
           LET l_tot19 = l_tot19 + g_oma_1[g_cnt].sum08
           LET l_tot20 = l_tot20 + g_oma_1[g_cnt].sum09
           LET l_tot21 = l_tot21 + g_oma_1[g_cnt].sum010
           LET l_tot22 = l_tot22 + g_oma_1[g_cnt].sum011
           LET l_tot23 = l_tot23 + g_oma_1[g_cnt].sum012
           LET l_tot24 = l_tot24 + g_oma_1[g_cnt].sum013
           LET l_tot25 = l_tot25 + g_oma_1[g_cnt].sum014
           LET l_tot26 = l_tot26 + g_oma_1[g_cnt].sum015
           LET l_tot27 = l_tot27 + g_oma_1[g_cnt].sum016
           LET l_tot28 = l_tot28 + g_oma_1[g_cnt].sum017
           LET l_tot12_1 = l_tot12_1 + g_oma_1[g_cnt].sum1
           LET l_tot13_1 = l_tot13_1 + g_oma_1[g_cnt].sum2
           LET l_tot14_1 = l_tot14_1 + g_oma_1[g_cnt].sum3
           LET l_tot15_1 = l_tot15_1 + g_oma_1[g_cnt].sum4
           LET l_tot16_1 = l_tot16_1 + g_oma_1[g_cnt].sum5
           LET l_tot17_1 = l_tot17_1 + g_oma_1[g_cnt].sum6
           LET l_tot18_1 = l_tot18_1 + g_oma_1[g_cnt].sum7
           LET l_tot19_1 = l_tot19_1 + g_oma_1[g_cnt].sum8
           LET l_tot20_1 = l_tot20_1 + g_oma_1[g_cnt].sum9
           LET l_tot21_1 = l_tot21_1 + g_oma_1[g_cnt].sum10
           LET l_tot22_1 = l_tot22_1 + g_oma_1[g_cnt].sum11
           LET l_tot23_1 = l_tot23_1 + g_oma_1[g_cnt].sum12
           LET l_tot24_1 = l_tot24_1 + g_oma_1[g_cnt].sum13
           LET l_tot25_1 = l_tot25_1 + g_oma_1[g_cnt].sum14
           LET l_tot26_1 = l_tot26_1 + g_oma_1[g_cnt].sum15
           LET l_tot27_1 = l_tot27_1 + g_oma_1[g_cnt].sum16
           LET l_tot28_1 = l_tot28_1 + g_oma_1[g_cnt].sum17
        END IF

        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

     WHEN '3'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT '','','','','','','',oma15,'',oma14,'',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "    #FUN-C80102 add sum(net)   #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT '','','','','','','',oma15,'',oma14,'','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "    #FUN-C80102 add sum(net)   #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),'',SUM(num01),SUM(num1),SUM(num02),SUM(num2), ",
                    "       SUM(num03),SUM(num3),SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07), ",
                    "       SUM(num7),SUM(num08),SUM(num8),SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),",
                    "       SUM(num012),SUM(num12),SUM(num013),SUM(num13),SUM(num014),SUM(num14),SUM(num015),SUM(num15), ",
                    "       SUM(num016),SUM(num16),SUM(num017),SUM(num17) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND oma23 = '",p_oma23,"' "  END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma14,oma15,oma23 ",
                    " ORDER BY oma14,oma15,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma14,oma15 ",
                    " ORDER BY oma14,oma15 "
     END IF

        PREPARE q191_pb3 FROM g_sql
        DECLARE q191_curs3 CURSOR FOR q191_pb3
        FOREACH q191_curs3 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
        SELECT gem02 INTO g_oma_1[g_cnt].oma15_desc FROM gem_file WHERE gem01 = g_oma_1[g_cnt].oma15
        SELECT gen02 INTO g_oma_1[g_cnt].oma14_desc FROM gen_file WHERE gen01 = g_oma_1[g_cnt].oma14
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot12 = l_tot12 + g_oma_1[g_cnt].sum01
           LET l_tot13 = l_tot13 + g_oma_1[g_cnt].sum02
           LET l_tot14 = l_tot14 + g_oma_1[g_cnt].sum03
           LET l_tot15 = l_tot15 + g_oma_1[g_cnt].sum04
           LET l_tot16 = l_tot16 + g_oma_1[g_cnt].sum05
           LET l_tot17 = l_tot17 + g_oma_1[g_cnt].sum06
           LET l_tot18 = l_tot18 + g_oma_1[g_cnt].sum07
           LET l_tot19 = l_tot19 + g_oma_1[g_cnt].sum08
           LET l_tot20 = l_tot20 + g_oma_1[g_cnt].sum09
           LET l_tot21 = l_tot21 + g_oma_1[g_cnt].sum010
           LET l_tot22 = l_tot22 + g_oma_1[g_cnt].sum011
           LET l_tot23 = l_tot23 + g_oma_1[g_cnt].sum012
           LET l_tot24 = l_tot24 + g_oma_1[g_cnt].sum013
           LET l_tot25 = l_tot25 + g_oma_1[g_cnt].sum014
           LET l_tot26 = l_tot26 + g_oma_1[g_cnt].sum015
           LET l_tot27 = l_tot27 + g_oma_1[g_cnt].sum016
           LET l_tot28 = l_tot28 + g_oma_1[g_cnt].sum017
           LET l_tot12_1 = l_tot12_1 + g_oma_1[g_cnt].sum1
           LET l_tot13_1 = l_tot13_1 + g_oma_1[g_cnt].sum2
           LET l_tot14_1 = l_tot14_1 + g_oma_1[g_cnt].sum3
           LET l_tot15_1 = l_tot15_1 + g_oma_1[g_cnt].sum4
           LET l_tot16_1 = l_tot16_1 + g_oma_1[g_cnt].sum5
           LET l_tot17_1 = l_tot17_1 + g_oma_1[g_cnt].sum6
           LET l_tot18_1 = l_tot18_1 + g_oma_1[g_cnt].sum7
           LET l_tot19_1 = l_tot19_1 + g_oma_1[g_cnt].sum8
           LET l_tot20_1 = l_tot20_1 + g_oma_1[g_cnt].sum9
           LET l_tot21_1 = l_tot21_1 + g_oma_1[g_cnt].sum10
           LET l_tot22_1 = l_tot22_1 + g_oma_1[g_cnt].sum11
           LET l_tot23_1 = l_tot23_1 + g_oma_1[g_cnt].sum12
           LET l_tot24_1 = l_tot24_1 + g_oma_1[g_cnt].sum13
           LET l_tot25_1 = l_tot25_1 + g_oma_1[g_cnt].sum14
           LET l_tot26_1 = l_tot26_1 + g_oma_1[g_cnt].sum15
           LET l_tot27_1 = l_tot27_1 + g_oma_1[g_cnt].sum16
           LET l_tot28_1 = l_tot28_1 + g_oma_1[g_cnt].sum17
        END IF

        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

     WHEN '4'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT '','',oma03,'','','','','','','','',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "     #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT '','',oma03,'','','','','','','','','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "     #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),SUM(sum_5) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND  oma23 = '",p_oma23,"' " END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03,oma23 ",
                    " ORDER BY oma03,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03 ",
                    " ORDER BY oma03 "
     END IF

        PREPARE q191_pb4 FROM g_sql
        DECLARE q191_curs4 CURSOR FOR q191_pb4
        FOREACH q191_curs4 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
       #SELECT occ18 INTO g_oma_1[g_cnt].occ18 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma68
        SELECT oma032 INTO g_oma_1[g_cnt].oma032 FROM oma_file WHERE oma03 = g_oma_1[g_cnt].oma03
        SELECT occ45 INTO l_occ45 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma03
        SELECT oag02 INTO g_oma_1[g_cnt].occ45 FROM oag_file WHERE oag01 = l_occ45
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot11 = l_tot11 + g_oma_1[g_cnt].sum_5
        END IF


        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

      WHEN '5'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT oma18,'',oma03,'','','','','','','','',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "    #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT oma18,'',oma03,'','','','','','','','','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "    #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),'',SUM(num01),SUM(num1),SUM(num02),SUM(num2), ",
                    "       SUM(num03),SUM(num3),SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07), ",
                    "       SUM(num7),SUM(num08),SUM(num8),SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),",
                    "       SUM(num012),SUM(num12),SUM(num013),SUM(num13),SUM(num014),SUM(num14),SUM(num015),SUM(num15), ",
                    "       SUM(num016),SUM(num16),SUM(num017),SUM(num17) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND  oma23 = '",p_oma23,"' " END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma18,oma03,oma23 ",
                    " ORDER BY oma18,oma03,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma18,oma03 ",
                    " ORDER BY oma18,oma03 "
     END IF

        PREPARE q191_pb5 FROM g_sql
        DECLARE q191_curs5 CURSOR FOR q191_pb5
        FOREACH q191_curs5 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
        SELECT aag02 INTO g_oma_1[g_cnt].aag02 FROM aag_file WHERE aag01 = g_oma_1[g_cnt].oma18
       #SELECT occ18 INTO g_oma_1[g_cnt].occ18 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma68
        SELECT oma032 INTO g_oma_1[g_cnt].oma032 FROM oma_file WHERE oma03 = g_oma_1[g_cnt].oma03
        SELECT occ45 INTO l_occ45 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma03
        SELECT oag02 INTO g_oma_1[g_cnt].occ45 FROM oag_file WHERE oag01 = l_occ45
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot12 = l_tot12 + g_oma_1[g_cnt].sum01
           LET l_tot13 = l_tot13 + g_oma_1[g_cnt].sum02
           LET l_tot14 = l_tot14 + g_oma_1[g_cnt].sum03
           LET l_tot15 = l_tot15 + g_oma_1[g_cnt].sum04
           LET l_tot16 = l_tot16 + g_oma_1[g_cnt].sum05
           LET l_tot17 = l_tot17 + g_oma_1[g_cnt].sum06
           LET l_tot18 = l_tot18 + g_oma_1[g_cnt].sum07
           LET l_tot19 = l_tot19 + g_oma_1[g_cnt].sum08
           LET l_tot20 = l_tot20 + g_oma_1[g_cnt].sum09
           LET l_tot21 = l_tot21 + g_oma_1[g_cnt].sum010
           LET l_tot22 = l_tot22 + g_oma_1[g_cnt].sum011
           LET l_tot23 = l_tot23 + g_oma_1[g_cnt].sum012
           LET l_tot24 = l_tot24 + g_oma_1[g_cnt].sum013
           LET l_tot25 = l_tot25 + g_oma_1[g_cnt].sum014
           LET l_tot26 = l_tot26 + g_oma_1[g_cnt].sum015
           LET l_tot27 = l_tot27 + g_oma_1[g_cnt].sum016
           LET l_tot28 = l_tot28 + g_oma_1[g_cnt].sum017
           LET l_tot12_1 = l_tot12_1 + g_oma_1[g_cnt].sum1
           LET l_tot13_1 = l_tot13_1 + g_oma_1[g_cnt].sum2
           LET l_tot14_1 = l_tot14_1 + g_oma_1[g_cnt].sum3
           LET l_tot15_1 = l_tot15_1 + g_oma_1[g_cnt].sum4
           LET l_tot16_1 = l_tot16_1 + g_oma_1[g_cnt].sum5
           LET l_tot17_1 = l_tot17_1 + g_oma_1[g_cnt].sum6
           LET l_tot18_1 = l_tot18_1 + g_oma_1[g_cnt].sum7
           LET l_tot19_1 = l_tot19_1 + g_oma_1[g_cnt].sum8
           LET l_tot20_1 = l_tot20_1 + g_oma_1[g_cnt].sum9
           LET l_tot21_1 = l_tot21_1 + g_oma_1[g_cnt].sum10
           LET l_tot22_1 = l_tot22_1 + g_oma_1[g_cnt].sum11
           LET l_tot23_1 = l_tot23_1 + g_oma_1[g_cnt].sum12
           LET l_tot24_1 = l_tot24_1 + g_oma_1[g_cnt].sum13
           LET l_tot25_1 = l_tot25_1 + g_oma_1[g_cnt].sum14
           LET l_tot26_1 = l_tot26_1 + g_oma_1[g_cnt].sum15
           LET l_tot27_1 = l_tot27_1 + g_oma_1[g_cnt].sum16
           LET l_tot28_1 = l_tot28_1 + g_oma_1[g_cnt].sum17
        END IF


        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

#FUN-C80102--add--str---
     WHEN '6'
     IF tm.org = "Y" THEN
        LET g_sql = "SELECT '','',oma03,'',oma68,'','','','','','',oma23,SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     ELSE
        LET g_sql = "SELECT '','',oma03,'',oma68,'','','','','','','',SUM(oma54t),SUM(oma55),SUM(oma54t_oma55),SUM(sum_1),SUM(sum_3),SUM(oma56t),SUM(net),SUM(oma57), "   #FUN-C80102 add sum(net)  #FUN-C80102 add ''
     END IF
        LET g_sql = g_sql CLIPPED,
                    "       SUM(oma56t_oma57), ",
                    "       SUM(sum_2),SUM(sum_4),'',SUM(num01),SUM(num1),SUM(num02),SUM(num2), ",
                    "       SUM(num03),SUM(num3),SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07), ",
                    "       SUM(num7),SUM(num08),SUM(num8),SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),",
                    "       SUM(num012),SUM(num12),SUM(num013),SUM(num13),SUM(num014),SUM(num14),SUM(num015),SUM(num15), ",
                    "       SUM(num016),SUM(num16),SUM(num017),SUM(num17) ",
                   #"  FROM axrq191_tmp ",  #FUN-CB0146 mark
                    "  FROM axrq191_tmp1 ", #FUN-CB0146
                    "  WHERE ",g_filter_wc CLIPPED
        IF tm.d = 'Y' THEN LET g_sql = g_sql CLIPPED," AND  oma23 = '",p_oma23,"' " END IF
     IF tm.org = "Y" THEN
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03,oma68,oma23 ",
                    " ORDER BY oma03,oma68,oma23 "
     ELSE
        LET g_sql = g_sql CLIPPED,
                    " GROUP BY oma03,oma68 ",
                    " ORDER BY oma03,oma68 "
     END IF

        PREPARE q191_pb6 FROM g_sql
        DECLARE q191_curs6 CURSOR FOR q191_pb6
        FOREACH q191_curs6 INTO g_oma_1[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
        SELECT occ18 INTO g_oma_1[g_cnt].occ18 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma68
       #SELECT oma032 INTO g_oma_1[g_cnt].oma032 FROM oma_file WHERE oma03 = g_oma_1[g_cnt].oma03
        SELECT occ45 INTO l_occ45 FROM occ_file WHERE occ01 = g_oma_1[g_cnt].oma03
        SELECT oag02 INTO g_oma_1[g_cnt].occ45 FROM oag_file WHERE oag01 = l_occ45
        IF tm.d = 'N' THEN
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
        END IF
        IF tm.d = 'Y' THEN
           LET l_tot1 = l_tot1 + g_oma_1[g_cnt].oma54t
           LET l_tot2 = l_tot2 + g_oma_1[g_cnt].oma56t
           LET l_tot3 = l_tot3 + g_oma_1[g_cnt].oma55
           LET l_tot4 = l_tot4 + g_oma_1[g_cnt].oma57
           LET l_tot5 = l_tot5 + g_oma_1[g_cnt].oma54t_oma55
           LET l_tot6 = l_tot6 + g_oma_1[g_cnt].oma56t_oma57
           LET l_tot7 = l_tot7 + g_oma_1[g_cnt].sum_1
           LET l_tot8 = l_tot8 + g_oma_1[g_cnt].sum_2
           LET l_tot9 = l_tot9 + g_oma_1[g_cnt].sum_3
           LET l_tot10 = l_tot10 + g_oma_1[g_cnt].sum_4
           LET l_tot12 = l_tot12 + g_oma_1[g_cnt].sum01
           LET l_tot13 = l_tot13 + g_oma_1[g_cnt].sum02
           LET l_tot14 = l_tot14 + g_oma_1[g_cnt].sum03
           LET l_tot15 = l_tot15 + g_oma_1[g_cnt].sum04
           LET l_tot16 = l_tot16 + g_oma_1[g_cnt].sum05
           LET l_tot17 = l_tot17 + g_oma_1[g_cnt].sum06
           LET l_tot18 = l_tot18 + g_oma_1[g_cnt].sum07
           LET l_tot19 = l_tot19 + g_oma_1[g_cnt].sum08
           LET l_tot20 = l_tot20 + g_oma_1[g_cnt].sum09
           LET l_tot21 = l_tot21 + g_oma_1[g_cnt].sum010
           LET l_tot22 = l_tot22 + g_oma_1[g_cnt].sum011
           LET l_tot23 = l_tot23 + g_oma_1[g_cnt].sum012
           LET l_tot24 = l_tot24 + g_oma_1[g_cnt].sum013
           LET l_tot25 = l_tot25 + g_oma_1[g_cnt].sum014
           LET l_tot26 = l_tot26 + g_oma_1[g_cnt].sum015
           LET l_tot27 = l_tot27 + g_oma_1[g_cnt].sum016
           LET l_tot28 = l_tot28 + g_oma_1[g_cnt].sum017
           LET l_tot12_1 = l_tot12_1 + g_oma_1[g_cnt].sum1
           LET l_tot13_1 = l_tot13_1 + g_oma_1[g_cnt].sum2
           LET l_tot14_1 = l_tot14_1 + g_oma_1[g_cnt].sum3
           LET l_tot15_1 = l_tot15_1 + g_oma_1[g_cnt].sum4
           LET l_tot16_1 = l_tot16_1 + g_oma_1[g_cnt].sum5
           LET l_tot17_1 = l_tot17_1 + g_oma_1[g_cnt].sum6
           LET l_tot18_1 = l_tot18_1 + g_oma_1[g_cnt].sum7
           LET l_tot19_1 = l_tot19_1 + g_oma_1[g_cnt].sum8
           LET l_tot20_1 = l_tot20_1 + g_oma_1[g_cnt].sum9
           LET l_tot21_1 = l_tot21_1 + g_oma_1[g_cnt].sum10
           LET l_tot22_1 = l_tot22_1 + g_oma_1[g_cnt].sum11
           LET l_tot23_1 = l_tot23_1 + g_oma_1[g_cnt].sum12
           LET l_tot24_1 = l_tot24_1 + g_oma_1[g_cnt].sum13
           LET l_tot25_1 = l_tot25_1 + g_oma_1[g_cnt].sum14
           LET l_tot26_1 = l_tot26_1 + g_oma_1[g_cnt].sum15
           LET l_tot27_1 = l_tot27_1 + g_oma_1[g_cnt].sum16
           LET l_tot28_1 = l_tot28_1 + g_oma_1[g_cnt].sum17
        END IF
        LET g_cnt = g_cnt + 1
            IF g_cnt > g_max_rec THEN
            CALL cl_err( '', 9035, 0 )
            EXIT FOREACH
        END IF
        END FOREACH

#FUN-C80102--add--end---
    END CASE

    IF tm.d = 'N' THEN
      DISPLAY l_tot2 TO FORMONLY.oma56t_tot
      DISPLAY l_tot4 TO FORMONLY.oma57_tot
      DISPLAY l_tot6 TO FORMONLY.oma56t_oma57_tot
      DISPLAY l_tot8 TO FORMONLY.sum_2_tot
      DISPLAY l_tot10 TO FORMONLY.sum_4_tot
    END IF
    IF tm.d = 'Y' THEN
       LET g_oma_1[g_cnt].oma23 = cl_getmsg('amr-003',g_lang)
        IF tm.d = 'Y' THEN
           LET g_oma_1[g_cnt].oma54t = l_tot1
           LET g_oma_1[g_cnt].oma56t = l_tot2
           LET g_oma_1[g_cnt].oma55 = l_tot3
           LET g_oma_1[g_cnt].oma57 = l_tot4
           LET g_oma_1[g_cnt].oma54t_oma55 = l_tot5
           LET g_oma_1[g_cnt].oma56t_oma57 = l_tot6
           LET g_oma_1[g_cnt].sum_1 = l_tot7
           LET g_oma_1[g_cnt].sum_2 = l_tot8
           LET g_oma_1[g_cnt].sum_3 = l_tot9
           LET g_oma_1[g_cnt].sum_4 = l_tot10
           LET g_oma_1[g_cnt].sum_5 = l_tot11
           LET g_oma_1[g_cnt].sum01 = l_tot12
           LET g_oma_1[g_cnt].sum02 = l_tot13
           LET g_oma_1[g_cnt].sum03 = l_tot14
           LET g_oma_1[g_cnt].sum04 = l_tot15
           LET g_oma_1[g_cnt].sum05 = l_tot16
           LET g_oma_1[g_cnt].sum06 = l_tot17
           LET g_oma_1[g_cnt].sum07 = l_tot18
           LET g_oma_1[g_cnt].sum08 = l_tot19
           LET g_oma_1[g_cnt].sum09 = l_tot20
           LET g_oma_1[g_cnt].sum010 = l_tot21
           LET g_oma_1[g_cnt].sum011 = l_tot22
           LET g_oma_1[g_cnt].sum012 = l_tot23
           LET g_oma_1[g_cnt].sum013 = l_tot24
           LET g_oma_1[g_cnt].sum014 = l_tot25
           LET g_oma_1[g_cnt].sum015 = l_tot26
           LET g_oma_1[g_cnt].sum016 = l_tot27
           LET g_oma_1[g_cnt].sum017 = l_tot28
           LET g_oma_1[g_cnt].sum1 = l_tot12
           LET g_oma_1[g_cnt].sum2 = l_tot13
           LET g_oma_1[g_cnt].sum3 = l_tot14
           LET g_oma_1[g_cnt].sum4 = l_tot15
           LET g_oma_1[g_cnt].sum5 = l_tot16
           LET g_oma_1[g_cnt].sum6 = l_tot17
           LET g_oma_1[g_cnt].sum7 = l_tot18
           LET g_oma_1[g_cnt].sum8 = l_tot19
           LET g_oma_1[g_cnt].sum9 = l_tot20
           LET g_oma_1[g_cnt].sum10 = l_tot21
           LET g_oma_1[g_cnt].sum11 = l_tot22
           LET g_oma_1[g_cnt].sum12 = l_tot23
           LET g_oma_1[g_cnt].sum13 = l_tot24
           LET g_oma_1[g_cnt].sum14 = l_tot25
           LET g_oma_1[g_cnt].sum15 = l_tot26
           LET g_oma_1[g_cnt].sum16 = l_tot27
           LET g_oma_1[g_cnt].sum17 = l_tot28
        END IF
    END IF
    DISPLAY ARRAY g_oma_1 TO s_oma_1.* ATTRIBUTE(COUNT=g_cnt)
      BEFORE DISPLAY
         EXIT DISPLAY
      END DISPLAY
    IF tm.d != 'Y' THEN
       CALL g_oma_1.deleteElement(g_cnt)
       LET g_rec_b2 = g_cnt - 1
    ELSE
       LET g_rec_b2 = g_cnt
    END IF
    DISPLAY g_rec_b2 TO FORMONLY.cnt1
END FUNCTION
#FUN-C80102--add--end---

#No.FUN-C80102 ---start--- Mark
#FUNCTION q191_b_fill()                     #BODY FILL UP
#  DEFINE   l_i1       LIKE type_file.num5
#  DEFINE   l_msg      STRING
#  DEFINE   l_totle    LIKE alz_file.alz09
#  DEFINE   l_oma03    LIKE oma_file.oma03
#  #--TQC-C30349--mod--str--  #增加按原幣列印的判斷
#  IF tm.detail = 'Y' THEN
#     LET g_sql = "SELECT * FROM axrq191_tmp ",
#                 " ORDER BY oma03,oma032,oma01,oma02,oma23 "  #TQC-C30349  add  oma23
#  ELSE
#     IF tm.org = 'Y' THEN
#        LET g_sql = "SELECT oma03,oma032,'','',oma23,SUM(num01),SUM(num1),SUM(num02),SUM(num2),SUM(num03),SUM(num3),",   #TQC-C30349  add ''
#                    "SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07),SUM(num7),SUM(num08),SUM(num8),",
#                    "SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),SUM(num012),SUM(num12),SUM(num013),SUM(num13),",
#                    "SUM(num014),SUM(num14),SUM(num015),SUM(num15),SUM(num016),SUM(num16),SUM(num017),SUM(num17),0",
#                    "  FROM axrq191_tmp",
#                    " GROUP BY oma03,oma032,oma23 ",
#                    " ORDER BY oma03,oma032,oma23 "
#     ELSE
#        LET g_sql = "SELECT oma03,oma032,'','','',SUM(num01),SUM(num1),SUM(num02),SUM(num2),SUM(num03),SUM(num3),",   #TQC-C30349  add ''
#                    "SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07),SUM(num7),SUM(num08),SUM(num8),",
#                    "SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),SUM(num012),SUM(num12),SUM(num013),SUM(num13),",
#                    "SUM(num014),SUM(num14),SUM(num015),SUM(num15),SUM(num016),SUM(num16),SUM(num017),SUM(num17),0",
#                    "  FROM axrq191_tmp",
#                    " GROUP BY oma03,oma032 ",
#                    " ORDER BY oma03,oma032 "
#     END IF
#  END IF
#  #--TQC-C30349--mod--end--
#  PREPARE axrq191_pb FROM g_sql
#  DECLARE oma_curs  CURSOR FOR axrq191_pb        #CURSOR
#
#  CALL g_oma.clear()
#  LET l_totle = 0
#  LET g_cnt = 1
#  LET g_rec_b = 0
#
#  FOREACH oma_curs INTO g_oma[g_cnt].*
#     IF SQLCA.sqlcode THEN
#        CALL cl_err('foreach:',SQLCA.sqlcode,1)
#        EXIT FOREACH
#     END IF
#     IF tm.detail = 'Y' AND g_cnt = 1 THEN
#        LET  l_oma03 = g_oma[g_cnt].oma03
#     END IF
#     IF tm.detail = 'Y' AND g_cnt > 1 THEN
#        IF g_oma[g_cnt].oma03 = l_oma03 THEN
#           LET  l_oma03 = g_oma[g_cnt].oma03
#           LET  g_oma[g_cnt].oma03 = ' '
#           LET  g_oma[g_cnt].oma032 = ' '
#        ELSE
#           LET  l_oma03 = g_oma[g_cnt].oma03
#        END IF
#     END IF
#     LET g_oma[g_cnt].sum = 0
#     LET g_oma[g_cnt].sum = g_oma[g_cnt].sum01+g_oma[g_cnt].sum02+g_oma[g_cnt].sum03+g_oma[g_cnt].sum04+g_oma[g_cnt].sum05
#                           +g_oma[g_cnt].sum06+g_oma[g_cnt].sum07+g_oma[g_cnt].sum08+g_oma[g_cnt].sum09+g_oma[g_cnt].sum010
#                           +g_oma[g_cnt].sum011+g_oma[g_cnt].sum012+g_oma[g_cnt].sum013+g_oma[g_cnt].sum014+g_oma[g_cnt].sum015
#                           +g_oma[g_cnt].sum016+g_oma[g_cnt].sum017
#     LET l_totle = l_totle + g_oma[g_cnt].sum
#     LET g_cnt = g_cnt + 1
#     IF g_cnt > g_max_rec THEN
#        CALL cl_err( '', 9035, 0 )
#            EXIT FOREACH
#     END IF
#  END FOREACH
#  IF g_cnt - 1 > 0 THEN
#     SELECT '','','','','',SUM(num01),SUM(num1),SUM(num02),SUM(num2),SUM(num03),SUM(num3),       #TQC-C30349  add ''
#            SUM(num04),SUM(num4),SUM(num05),SUM(num5),SUM(num06),SUM(num6),SUM(num07),SUM(num7),SUM(num08),SUM(num8),
#            SUM(num09),SUM(num9),SUM(num010),SUM(num10),SUM(num011),SUM(num11),SUM(num012),SUM(num12),SUM(num013),SUM(num13),
#            SUM(num014),SUM(num14),SUM(num015),SUM(num15),SUM(num016),SUM(num16),SUM(num017),SUM(num17),SUM(num)
#       INTO g_oma[g_cnt].*
#       FROM axrq191_tmp
#     LET g_oma[g_cnt].sum = l_totle
#     #--TQC-C30349--mod--str--  #增加按原幣列印的判斷
#     IF tm.detail = 'Y' THEN
#        IF tm.org = 'Y' THEN
#           LET g_oma[g_cnt].oma23 = cl_getmsg('axr107',g_lang)
#        ELSE
#           LET g_oma[g_cnt].oma01 = cl_getmsg('axr107',g_lang)
#        END IF
#     ELSE
#        IF tm.org = 'Y' THEN
#           LET g_oma[g_cnt].oma23 = cl_getmsg('axr107',g_lang)
#        ELSE
#           LET g_oma[g_cnt].oma032 = cl_getmsg('axr107',g_lang)
#        END IF
#     END IF
#     #--TQC-C30349--mod--end--
#  END IF
#  LET g_rec_b = g_cnt
#  DISPLAY g_rec_b TO FORMONLY.cnt
#
#END FUNCTION
#No.FUN-C80102 ---end  --- Mark

FUNCTION q191_table()
   DROP TABLE axrq191_tmp;
   CREATE TEMP TABLE axrq191_tmp(
             oma03         LIKE oma_file.oma03,
             oma032        LIKE oma_file.oma032,
             oma00         LIKE oma_file.oma00,   #FUN-C80102
             oma01         LIKE oma_file.oma01,   #FUN-C80102
             oma02         LIKE oma_file.oma02,
             alz12         LIKE alz_file.alz12,   #FUN-C80102
             alz07         LIKE alz_file.alz07,   #FUN-C80102
             oma18         LIKE oma_file.oma18,   #FUN-C80102
             aag02         LIKE aag_file.aag02,   #FUN-C80102
             oma54t        LIKE oma_file.oma54t,  #FUN-C80102
             oma55         LIKE oma_file.oma55,   #FUN-C80102
             oma54t_oma55  LIKE oma_file.oma54t,   #FUN-C80102
             sum_1         LIKE type_file.num20_6,  #FUN-C80102
             sum_3         LIKE type_file.num20_6,  #FUN-C80102
             oma56t        LIKE oma_file.oma56t,  #FUN-C80102
             net           LIKE oox_file.oox10,   #FUN-C80102
             oma57         LIKE oma_file.oma57,   #FUN-C80102
             oma56t_oma57  LIKE oma_file.oma56t,   #FUN-C80102
             sum_2         LIKE type_file.num20_6,  #FUN-C80102
             sum_4         LIKE type_file.num20_6,  #FUN-C80102
             sum_5         LIKE type_file.num20_6,  #FUN-C80102
             num01  LIKE alz_file.alz09,
             num1   LIKE alz_file.alz09,
             num02  LIKE alz_file.alz09,
             num2   LIKE alz_file.alz09,
             num03  LIKE alz_file.alz09,
             num3   LIKE alz_file.alz09,
             num04  LIKE alz_file.alz09,
             num4   LIKE alz_file.alz09,
             num05  LIKE alz_file.alz09,
             num5   LIKE alz_file.alz09,
             num06  LIKE alz_file.alz09,
             num6   LIKE alz_file.alz09,
             num07  LIKE alz_file.alz09,
             num7   LIKE alz_file.alz09,
             num08  LIKE alz_file.alz09,
             num8   LIKE alz_file.alz09,
             num09  LIKE alz_file.alz09,
             num9   LIKE alz_file.alz09,
             num010 LIKE alz_file.alz09,
             num10  LIKE alz_file.alz09,
             num011 LIKE alz_file.alz09,
             num11  LIKE alz_file.alz09,
             num012 LIKE alz_file.alz09,
             num12  LIKE alz_file.alz09,
             num013 LIKE alz_file.alz09,
             num13  LIKE alz_file.alz09,
             num014 LIKE alz_file.alz09,
             num14  LIKE alz_file.alz09,
             num015 LIKE alz_file.alz09,
             num15  LIKE alz_file.alz09,
             num016 LIKE alz_file.alz09,
             num16  LIKE alz_file.alz09,
             num017 LIKE alz_file.alz09,
             num17  LIKE alz_file.alz09,
             oma10      LIKE oma_file.oma10,   #FUN-C80102
             oma67      LIKE oma_file.oma67,   #FUN-C80102
             oma33      LIKE oma_file.oma33,   #FUN-C80102
             oma23      LIKE oma_file.oma23,    #TQC-C30349  add
             azj041_1   LIKE azj_file.azj041,#FUN-C80102
             azj041     LIKE azj_file.azj041,  #FUN-C80102
             oma15      LIKE oma_file.oma15,   #FUN-C80102
             oma15_desc LIKE gem_file.gem01,   #FUN-C80102
             oma14      LIKE oma_file.oma14,   #FUN-C80102
             oma14_desc LIKE gen_file.gen01,   #FUN-C80102
             oma68      LIKE oma_file.oma68,   #FUN-C80102
             occ18      LIKE occ_file.occ18,   #FUN-C80102
             occ03      LIKE occ_file.occ03,   #FUN-C80102
             occ03_desc LIKE oca_file.oca02,   #FUN-C80102
             oma08      LIKE oma_file.oma08,   #FUN-C80102
             oma25      LIKE oma_file.oma25,   #FUN-C80102
             oma26      LIKE oma_file.oma26,   #FUN-C80102
             azp01      LIKE azp_file.azp01)   #FUN-C80102
END FUNCTION

FUNCTION q191_out()
   DEFINE l_cmd        LIKE type_file.chr1000,
          l_wc         LIKE type_file.chr1000

   CALL cl_wait()
   IF tm.wc IS NULL THEN CALL cl_err('','9057',0) END IF
   LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
   LET l_cmd = "axrr191",
               " '",g_today CLIPPED,"' ''",
               " '",g_lang CLIPPED,"' 'Y' '' '1' ",
               " '",tm.wc CLIPPED,"'",
               " '",tm.aly01 CLIPPED,"'",
               " '",tm.a CLIPPED,"'",
               " '",tm.edate CLIPPED,"'",
               " '",tm.detail CLIPPED,"'",
               " '",tm.zr CLIPPED,"'",
               " '",tm.org CLIPPED,"'"    #TQC-C30349  add
   CALL cl_cmdrun(l_cmd)
   ERROR ' '
END FUNCTION

FUNCTION q191_get_datas()
   DEFINE l_i      LIKE type_file.num5
   #根據賬齡類型抓取賬齡資料
   LET l_i = 1
   LET g_sql = "SELECT * FROM aly_file WHERE aly01='",tm.aly01,"' ORDER BY aly02"
   PREPARE aly_prepare FROM g_sql
   IF SQLCA.sqlcode != 0 THEN
      CALL cl_err('aly_prepare:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF
   CALL g_aly.clear()
   DECLARE aly_curs1 CURSOR FOR aly_prepare
   FOREACH aly_curs1 INTO g_aly[l_i].*
      IF SQLCA.sqlcode != 0 THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      IF g_aly[l_i].aly05 IS NULL THEN
         LET g_aly[l_i].aly05 = 100
      END IF
      LET l_i = l_i+1
   END FOREACH
END FUNCTION

#FUN-C80102--add--str--
FUNCTION q191_set_title_1()
   DEFINE   l_i2,i         LIKE type_file.num5
   DEFINE   l_aly          RECORD LIKE aly_file.*
   DEFINE   l_sql          STRING
   DEFINE   l_msg,l_msg1   STRING
   DEFINE   l_zl,l_zl1     STRING
   DEFINE   l_til,l_til1   STRING

   LET l_i2 = 1
   LET l_msg  = cl_getmsg('axr123',g_lang)
   LET l_msg1 = cl_getmsg('axr109',g_lang)
   LET l_sql = "SELECT * FROM aly_file WHERE aly01 = '",tm.aly01,"'",
               " ORDER BY aly02"
   PREPARE q191_prepare_11 FROM l_sql
   DECLARE q191_curs_11 CURSOR FOR q191_prepare_11
   FOREACH q191_curs_11 INTO l_aly.*
      LET l_zl  = l_aly.aly03 USING '<<<<&','-',l_aly.aly04 USING '<<<<<',l_msg1
      LET l_zl1 = l_aly.aly03 USING '<<<<&','-',l_aly.aly04 USING '<<<<<',l_msg
      LET l_til= "sum",l_i2 USING "<<<<<<<<<<<<","_1"
      LET l_til1= "sum0",l_i2 USING "<<<<<<<<<<<<","_1"
      CALL cl_set_comp_visible(l_til1,TRUE)
      CALL cl_set_comp_att_text(l_til,l_zl CLIPPED)
      CALL cl_set_comp_att_text(l_til1,l_zl1 CLIPPED)
      LET l_i2 = l_i2 + 1
   END FOREACH
   IF l_i2 > 1 THEN
      LET l_zl  = '>',l_aly.aly04 USING '<<<<<',l_msg1
      LET l_zl1 = '>',l_aly.aly04 USING '<<<<<',l_msg
      LET l_til= "sum17_1"
      LET l_til1= "sum017_1"
      CALL cl_set_comp_visible(l_til1,TRUE)
      CALL cl_set_comp_att_text(l_til,l_zl CLIPPED)
      CALL cl_set_comp_att_text(l_til1,l_zl1 CLIPPED)
      IF l_i2 < 17 THEN
         FOR i = l_i2 TO 16
            LET l_til= "sum",i USING "<<<<<<<<<<<<","_1"
            LET l_til1= "sum0",i USING "<<<<<<<<<<<<","_1"
            CALL cl_set_comp_visible(l_til,FALSE)
            CALL cl_set_comp_visible(l_til1,FALSE)
         END FOR
      END IF
   END IF
END FUNCTION
#FUN-C80102--add--end--

FUNCTION q191_set_title()
   DEFINE   l_i2,i         LIKE type_file.num5
   DEFINE   l_aly          RECORD LIKE aly_file.*
   DEFINE   l_sql          STRING
   DEFINE   l_msg,l_msg1   STRING
   DEFINE   l_zl,l_zl1     STRING
   DEFINE   l_til,l_til1   STRING

   LET l_i2 = 1
   LET l_msg  = cl_getmsg('axr123',g_lang)
   LET l_msg1 = cl_getmsg('axr109',g_lang)
   LET l_sql = "SELECT * FROM aly_file WHERE aly01 = '",tm.aly01,"'",
               " ORDER BY aly02"
   PREPARE q191_prepare FROM l_sql
   DECLARE q191_curs CURSOR FOR q191_prepare
   FOREACH q191_curs INTO l_aly.*
      LET l_zl  = l_aly.aly03 USING '<<<<&','-',l_aly.aly04 USING '<<<<<',l_msg1
      LET l_zl1 = l_aly.aly03 USING '<<<<&','-',l_aly.aly04 USING '<<<<<',l_msg
      LET l_til= "sum",l_i2 USING "<<<<<<<<<<<<"
      LET l_til1= "sum0",l_i2 USING "<<<<<<<<<<<<"
      CALL cl_set_comp_visible(l_til1,TRUE)
      CALL cl_set_comp_att_text(l_til,l_zl CLIPPED)
      CALL cl_set_comp_att_text(l_til1,l_zl1 CLIPPED)
      LET l_i2 = l_i2 + 1
   END FOREACH
   IF l_i2 > 1 THEN
      LET l_zl  = '>',l_aly.aly04 USING '<<<<<',l_msg1
      LET l_zl1 = '>',l_aly.aly04 USING '<<<<<',l_msg
      LET l_til= "sum17"
      LET l_til1= "sum017"
      CALL cl_set_comp_visible(l_til1,TRUE)
      CALL cl_set_comp_att_text(l_til,l_zl CLIPPED)
      CALL cl_set_comp_att_text(l_til1,l_zl1 CLIPPED)
      IF l_i2 < 17 THEN
         FOR i = l_i2 TO 16
            LET l_til= "sum",i USING "<<<<<<<<<<<<"
            LET l_til1= "sum0",i USING "<<<<<<<<<<<<"
            CALL cl_set_comp_visible(l_til,FALSE)
            CALL cl_set_comp_visible(l_til1,FALSE)
         END FOR
      END IF
   END IF
END FUNCTION
#FUN-B60071

#No.FUN-C80102 ---statr--- Mark
#FUN-B60129--add--str--
#FUNCTION q191_detail()
#  DEFINE   l_oma03    LIKE oma_file.oma03
#  DEFINE   l_ac1      LIKE type_file.num5
#  DEFINE   l_cmd      LIKE type_file.chr1000,
#           l_wc       STRING

#  CALL cl_wait()
#  IF tm.wc IS NULL THEN CALL cl_err('','9057',0) END IF
#  LET l_ac1 = 0
#  LET l_ac1 = ARR_CURR()
#  IF l_ac1 < 1 THEN
#     RETURN
#  ELSE
#     IF cl_null(g_oma[l_ac1].oma03) THEN
#        RETURN
#     END IF
#     LET l_wc = tm.wc, " AND oma03 = '",g_oma[l_ac1].oma03,"'"
#     LET l_wc = cl_replace_str(l_wc, "'", "\"")
#     LET l_cmd = "axrq191",
#                 " '",l_wc CLIPPED,"'",
#                 " '",tm.aly01 CLIPPED,"'",
#                 " '",tm.a CLIPPED,"'",
#                 " '",tm.edate CLIPPED,"'",
#                 " 'Y'",
#                 " '",tm.zr CLIPPED,"'"
#     CALL cl_cmdrun(l_cmd)
#  END IF
#END FUNCTION
#FUN-B60129--add--end--
#No.FUN-C80108 ---end  --- Mark

#FUN-CB0146--add--str--
FUNCTION q191_get_tmp()
   DEFINE l_sql     STRING
   DEFINE l_aly     RECORD LIKE aly_file.*
   DEFINE i         LIKE type_file.num5
   DEFINE l_alz07   LIKE alz_file.alz07
   DEFINE l_year LIKE oox_file.oox01    #MOD-D50237
   DEFINE l_MONTH LIKE oox_file.oox02   #MOD-D50237
   DEFINE l_azi04   LIKE azi_file.azi04,#130619 wangrr add
          l_azi07   LIKE azi_file.azi07 #130619 wangrr add

   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang
   LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('omauser', 'omagrup')
   CALL q191_get_datas()
   DELETE FROM axrq191_tmp1;
   DISPLAY g_time

    LET l_sql = "SELECT oma03,oma032,oma00,oma01,oma02,alz12,alz07,oma18,'',",
                "       oma54t,oma55,0,0,0,oma56t,0,oma57,0,0,0,0,",
                "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0,",
                "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,",
                "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,0,",
                "       0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,",
                "       oma10,oma67,oma33,oma23,1,1,oma15,gem02,oma14,gen02,",
                "       oma68,occ18,occ03,'',oma08,oma25,oma26,'',",
                "       alz09,alz09f,alz06,'0' ",
                "  FROM omc_file,alz_file, ",
                "       oma_file LEFT OUTER JOIN gem_file ON (gem01=oma15)",
                "                LEFT OUTER JOIN gen_file ON (gen01=oma14),",
                "       occ_file LEFT OUTER JOIN oca_file ON(occ_file.occ03=oca_file.oca01)",
                " WHERE ",tm.wc CLIPPED," AND oma03 = occ01 AND oma01 = omc01 ",
                "   AND oma03 = alz01 AND alz00 = '2' AND alz02 = ",YEAR(tm.edate),
                "   AND alz03 = ",MONTH(tm.edate)," AND alz04 = oma01 ",
                "   AND alz05 = omc02 ",
                "   AND alz09 <> 0 " ,
                "   and alz06<= '",tm.edate,"'"
#   #IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 < '",tm.edate,"'"  END IF
#   IF tm.a = '2' THEN LET l_sql=l_sql CLIPPED,"  AND alz07 <= '",tm.edate,"'"  END IF   #MOD-D50090   make quan
   LET l_sql = " INSERT INTO axrq191_tmp1 ",l_sql CLIPPED
   PREPARE q191_ins FROM l_sql
   EXECUTE q191_ins
   IF STATUS THEN
      CALL cl_err('',STATUS,0)
   END IF
   LET l_sql=" UPDATE axrq191_tmp1 o",
             "    SET occ18=(SELECT occ18 FROM occ_file n",
             "                WHERE n.occ01=o.oma68 )"
   PREPARE upd_pr1 FROM l_sql
   EXECUTE upd_pr1

   LET l_sql=" UPDATE axrq191_tmp1 o",
             "    SET occ03_desc=(SELECT UNIQUE oca02 FROM oca_file n",
             "                     WHERE n.oca01=o.occ03 )"
   PREPARE upd_pr2 FROM l_sql
   EXECUTE upd_pr2

   LET l_sql=" UPDATE axrq191_tmp1 o",
             "    SET aag02=(SELECT UNIQUE aag02 FROM aag_file  n",
             "                     WHERE n.aag01 = o.oma18 )"
   PREPARE upd_pr3 FROM l_sql
   EXECUTE upd_pr3

   LET l_sql=" UPDATE axrq191_tmp1 o",
             "    SET alz12=(SELECT oag02 FROM oag_file n",
             "                     WHERE n.oag01 = o.alz12 )"
   PREPARE upd_pr4 FROM l_sql
   EXECUTE upd_pr4

   UPDATE axrq191_tmp1
      SET oma54t=-1*oma54t,oma55=-1*oma55,
          oma56t=-1*oma56t,oma57=-1*oma57
    WHERE oma00[1,1]='2'
   LET l_year = YEAR(tm.edate)     #MOD-D50237
   LET l_month = MONTH(tm.edate)   #MOD-D50237
   IF g_ooz.ooz07 = 'Y' THEN
      LET l_sql="UPDATE axrq191_tmp1 o",
               "    SET net=( ",
               "             SELECT SUM(oox10) FROM oox_file ",
               "              WHERE oox00 = 'AR' AND oox03 = o.oma01 ",
               "                AND (oox01<'",l_year,"'",                                      #MOD-D50237
               "                 OR (oox01 = '",l_year,"'"," AND oox02 <= '",l_month,"')))"     #MOD-D50237   #add ) by kuangxj150414 2015040184

      PREPARE upd_pr5 FROM l_sql
      EXECUTE upd_pr5
   END IF
#   UPDATE axrq191_tmp1 SET net=0 WHERE net IS NULL OR net=' '    #mark by kuangxj150414 2015040184
   UPDATE axrq191_tmp1 SET net=0 WHERE net IS NULL OR net='' #zhouxm150923 add
   UPDATE axrq191_tmp1 SET net=-1* net WHERE oma00[1,1]='2'
   #add by cjy 20170824
   # LET l_sql=" UPDATE axrq191_tmp1 o",
   #           "    SET oma57 =( ",
   #           "               SELECT alz09f FROM alz_file ",
   #           "                WHERE alz04 = o.oma01 AND alz02 = '",l_year,"'"," AND alz03 = '",l_month,"')"
   # PREPARE upd_proma57 FROM l_sql
   # EXECUTE upd_proma57
   #
   # LET l_sql=" UPDATE axrq191_tmp1 o",
   #           "    SET oma55 =( ",
   #           "               SELECT alz09 FROM alz_file ",
   #           "                WHERE alz04 = o.oma01 AND alz02 = '",l_year,"'"," AND alz03 = '",l_month,"')"
   # PREPARE upd_proma55 FROM l_sql
   # EXECUTE upd_proma55
   #end add by cjy 20170824


  #mod by cjy 20170824
  # UPDATE axrq191_tmp1
  #    SET oma54t_oma55=oma54t-oma55,
  #        oma56t_oma57=oma56t+net-oma57
   UPDATE axrq191_tmp1
      SET oma54t_oma55=alz09f,
          oma56t_oma57=alz09
  #end mod by cjy 20170824

   #應付款日匯率
   SELECT * INTO g_aza.* FROM aza_file WHERE aza01 = '0'
   CASE
      WHEN g_aza.aza19 = '1'            #取每月匯率
         #azj041_1
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041_1=(",
                   "              SELECT azj041 FROM azj_file n",
                   "               WHERE n.azj01 = o.oma23 "
         IF tm.a='1' THEN
      #      LET l_sql=l_sql," AND n.azj02= YEAR(o.oma02)||MONTH(o.oma02) )"      #mark by 2015040230
             LET l_sql=l_sql," AND (n.azj02= YEAR(o.oma02)||MONTH(o.oma02) or n.azj02= YEAR(o.oma02)||'0'||MONTH(o.oma02)))"  #add by 2015040230
         ELSE
      #      LET l_sql=l_sql," AND n.azj02= YEAR(o.alz07)||MONTH(o.alz07) )"      #mark by 2015040230
             LET l_sql=l_sql," AND (n.azj02= YEAR(o.oma02)||MONTH(o.oma02) or n.azj02= YEAR(o.oma02)||'0'||MONTH(o.oma02)))"  #add by 2015040230
         END IF
         LET l_sql=l_sql," WHERE o.oma23 <> '",g_aza.aza17,"'"
         PREPARE q191_pr1 FROM l_sql
         EXECUTE q191_pr1
         #取不到時, 取最近匯率
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041_1=(",
                   "              SELECT azj041 FROM azj_file ",
                   "              WHERE azj01 = o.oma23",
                   "                AND azj02 = (SELECT MAX(azj02) FROM azj_file ",
                   "                              WHERE azj01 =o.oma23 "
         IF tm.a='1' THEN
            LET l_sql=l_sql," AND azj02<= YEAR(o.oma02)||MONTH(o.oma02) )"
         ELSE
            LET l_sql=l_sql," AND azj02<= YEAR(o.alz07)||MONTH(o.alz07) )"
         END IF
         LET l_sql=l_sql,"  )",
                         " WHERE o.oma23<>'",g_aza.aza17,"'"
         PREPARE q191_pr2 FROM l_sql
         EXECUTE q191_pr2

         #net2
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041=(",
                   "              SELECT azj041 FROM azj_file n,oma_file a",
                   "               WHERE n.azj01 = o.oma23 AND o.oma01=a.oma01 ",
                   "                 AND n.azj02= YEAR(a.oma12)||MONTH(a.oma12) )",
                   " WHERE o.oma23 <> '",g_aza.aza17,"'"
         PREPARE q191_pr3 FROM l_sql
         EXECUTE q191_pr3
         #取不到時, 取最近匯率
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041=(",
                   "              SELECT azj041 FROM azj_file",
                   "              WHERE azj01 = o.oma23",
                   "                AND azj02 = (SELECT MAX(azj02) FROM azj_file,oma_file a ",
                   "                              WHERE azj01 =o.oma23 AND o.oma01=a.oma01 ",
                   "                                AND azj02<= YEAR(a.oma12)||MONTH(a.oma12) )",
                   "              )",
                   " WHERE o.oma23<>'",g_aza.aza17,"'"
         PREPARE q191_pr4 FROM l_sql
         EXECUTE q191_pr4

      WHEN g_aza.aza19 = '2'            #取每日匯率
         #net1
         LET l_sql="UPDATE axrq191_tmp1 o ",
                   "   SET o.azj041_1=( ",
                   "              SELECT azk041 FROM azk_file n ",
                   "               WHERE n.azk01 = o.oma23 "
         IF tm.a='1' THEN
            LET l_sql=l_sql," AND n.azk02= o.oma02 )"
         ELSE
            LET l_sql=l_sql," AND n.azk02= o.alz07 )"
         END IF
         LET l_sql=l_sql," WHERE o.oma23 <> '",g_aza.aza17,"'"
         PREPARE q191_pr5 FROM l_sql
         EXECUTE q191_pr5
         #每日取不到時, 取最近匯率
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041_1=(",
                   "              SELECT azk041 FROM azk_file",
                   "              WHERE azk01 = o.oma23",
                   "                AND azk02 = (SELECT MAX(azk02) FROM azj_file ",
                   "                              WHERE azk01 =o.oma23 "
         IF tm.a='1' THEN
            LET l_sql=l_sql," AND azk02<= o.oma02 )"
         ELSE
            LET l_sql=l_sql," AND azk02<= o.alz07 )"
         END IF
         LET l_sql=l_sql,"  )",
                         " WHERE o.oma23<>'",g_aza.aza17,"'",
                         "   AND o.net1=0 "
         PREPARE q191_pr6 FROM l_sql
         EXECUTE q191_pr6

         #net2
         LET l_sql="UPDATE axrq191_tmp1 o ",
                   "   SET o.azj041=( ",
                   "              SELECT azk041 FROM azk_file n ,oma_file a",
                   "               WHERE n.azk01 = o.oma23 AND o.oma01=a.oma01",
                   "                 AND n.azk02= a.oma12 )",
                   " WHERE o.oma23 <> '",g_aza.aza17,"'"
         PREPARE q191_pr7 FROM l_sql
         EXECUTE q191_pr7
         #每日取不到時, 取最近匯率
         LET l_sql="UPDATE axrq191_tmp1 o",
                   "   SET o.azj041=(",
                   "              SELECT azk041 FROM azk_file",
                   "              WHERE azk01 = o.oma23",
                   "                AND azk02 = (SELECT MAX(azk02) FROM azj_file,oma_file a ",
                   "                              WHERE azk01 =o.oma23 AND o.oma01=a.oma01",
                   "                                AND azk02<= a.oma12 )",
                   "              )",
                   " WHERE o.oma23<>'",g_aza.aza17,"'"
         PREPARE q191_pr8 FROM l_sql
         EXECUTE q191_pr8
   END CASE
   #130619--wangrr--MOD--str--
   SELECT azi04,azi07 INTO l_azi04,l_azi07 FROM azi_file WHERE azi01=g_aza.aza17

   LET l_sql = " MERGE INTO axrq191_tmp1 o ",
               "      USING (SELECT azi01,azi04,azi07 FROM azi_file ",
               "              ) n ",
               "         ON (o.oma23 = n.azi01) ",
               " WHEN MATCHED ",
               " THEN ",
               "    UPDATE ",
               "       SET ", #130619 wangrr add
              #"       SET o.azj041_1 = ROUND(o.azj041_1,n.azi07),", #130619 wangrr mark
              #"           o.azj041 = ROUND(o.azj041,n.azi07), ",    #130619 wangrr mark
               "           o.oma54t = ROUND(o.oma54t,n.azi04),",
              #"           o.oma56t = ROUND(o.oma56t,n.azi04),",     #130619 wangrr mark
               "           o.oma55 = ROUND(o.oma55,n.azi04),",
              #"           o.oma57 = ROUND(o.oma57,n.azi04),",       #130619 wangrr mark
               "           o.oma54t_oma55 = ROUND(o.oma54t_oma55,n.azi04) "
              #"           o.oma56t_oma57 = ROUND(o.oma56t_oma57,n.azi04) " #130619 wangrr mark

   PREPARE upq_tmp_pr FROM l_sql
   EXECUTE upq_tmp_pr

   LET l_sql ="UPDATE axrq191_tmp1 o ",
              "   SET o.azj041_1 = ROUND(o.azj041_1,",l_azi07,"),",
              "       o.azj041 = ROUND(o.azj041,",l_azi07,"), ",
              "       o.oma56t = ROUND(o.oma56t,",l_azi04,"),",
              "       o.oma57 = ROUND(o.oma57,",l_azi04,"),",
              "       o.oma56t_oma57 = ROUND(o.oma56t_oma57,",l_azi04,") "
   #130619--wangrr--MOD--end
   PREPARE upq_pr5 FROM l_sql
   EXECUTE upq_pr5

   LET i=1
   IF tm.org = 'Y' THEN
      WHILE NOT cl_null(g_aly[i].aly04)
         LET l_alz07 = tm.edate - g_aly[i].aly04       #yinhy140604
         LET l_sql="UPDATE axrq191_tmp1 SET num0",i USING "<<<<","=alz09f ,",
                   "                    num", i USING "<<<<","=alz09f*",g_aly[i].aly05/100,",",
                   "                    l_num0",i USING "<<<<","=alz09 ,",
                   "                    l_num", i USING "<<<<","=alz09*",g_aly[i].aly05/100,",",
                   "                    flag='1' "
        IF tm.a = '2' THEN
         #  LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) <= alz07"
           LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) "#150917wudj add =
        ELSE
         #  LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) <= alz06"
           LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) "#150917wudj add =
        END IF
        LET l_sql=l_sql,"   AND flag='0' "
         PREPARE q191_amt_pr1 FROM l_sql
         EXECUTE q191_amt_pr1
         LET i=i+1
      END WHILE
      LET i=i-1
      LET l_sql="UPDATE axrq191_tmp1 SET num0",i USING "<<","=alz09f ,",
                "                    num", i USING "<<","=alz09f ,",
                "                    l_num0",i USING "<<","=alz09,",
                "                    l_num", i USING "<<","=alz09, ",
                "                    flag='1' "
      IF tm.a = '2' THEN
        # LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) > alz07"
          LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) "#150917wudj add =
      ELSE
        # LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) > alz06"
          LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) "#150917wudj add =
      END IF
      LET l_sql=l_sql,"   AND flag='0' "
      PREPARE q191_amt_pr2 FROM l_sql
      EXECUTE q191_amt_pr2
      UPDATE axrq191_tmp1 SET sum_3=num01 + num02 + num03 + num04 + num05 + num06
                               +num07 + num08 + num09 + num010+ num011+ num012
                               +num013+ num014+ num015+ num016+ num017

      UPDATE axrq191_tmp1 SET sum_4=l_num01 + l_num02 + l_num03 + l_num04 + l_num05
                               +l_num06 + l_num07 + l_num08 + l_num09 + l_num010
                               +l_num011+ l_num012+ l_num013+ l_num014+ l_num015
                               +l_num016+ l_num017
      UPDATE axrq191_tmp1 SET sum_2 = oma56t + net - sum_4        #本幣未逾期金額
      UPDATE axrq191_tmp1 SET sum_1 = oma54t - sum_3              #原幣未逾期金額
      UPDATE axrq191_tmp1 SET sum_5 = (azj041 - azj041_1) * sum_3
   ELSE
      WHILE NOT cl_null(g_aly[i].aly04)
        # LET l_alz07 = tm.edate - g_aly[i].aly04
         LET l_sql="UPDATE axrq191_tmp1 SET num0",i USING "<<<<","=alz09,",
                   "                    num", i USING "<<<<","=alz09*",g_aly[i].aly05/100,",",
                   "                    l_num0",i USING "<<<<","=alz09f,",
                   "                    l_num", i USING "<<<<","=alz09f*",g_aly[i].aly05/100,",",
                   "                    flag='1' "
         IF tm.a = '2' THEN
           # LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) <= alz07"                                #quan
            LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) " #150917wudj add =
         ELSE
            #LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) <= alz06"                                 #quan
            #LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>=0 ) "#150917wudj add =
            LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz06 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz06 AS DATE)>=0 ) "#mod by cjy 20170830
         END IF
         LET l_sql=l_sql,"   AND flag='0' "
         PREPARE q191_amt_pr3 FROM l_sql
         EXECUTE q191_amt_pr3
         LET i=i+1
      END WHILE
      LET i=i-1
      LET l_alz07 = tm.edate - g_aly[i].aly04
      LET i =17                  #add by kuangxj150323 2015030339
      LET l_sql="UPDATE axrq191_tmp1 SET num0",i USING "<<<<","=alz09 ,",
                "                    num", i USING "<<<<","=alz09 ,",
                "                    l_num0",i USING "<<<<","=alz09f ,",
                "                    l_num", i USING "<<<<","=alz09f ,",
                "                    flag='1' "
      IF tm.a = '2' THEN
        # LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) > alz07"
         LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>0 ) "
      ELSE
        # LET l_sql=l_sql, " WHERE CAST('",l_alz07,"' AS DATE) > alz06"
          LET l_sql=l_sql," WHERE ( CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)<=",g_aly[i].aly04," AND CAST('",tm.edate,"' AS DATE)-CAST(alz07 AS DATE)>0 ) "
      END IF
      LET l_sql=l_sql,"   AND flag='0' "
      PREPARE q191_amt_pr4 FROM l_sql
      EXECUTE q191_amt_pr4

      UPDATE axrq191_tmp1 SET sum_3=l_num01 + l_num02 + l_num03 + l_num04 + l_num05
                               +l_num06 + l_num07 + l_num08 + l_num09 + l_num010
                               +l_num011+ l_num012+ l_num013+ l_num014+ l_num015
                               +l_num016+ l_num017

      UPDATE axrq191_tmp1 SET sum_4=num01 + num02 + num03 + num04 + num05 + num06
                               +num07 + num08 + num09 + num010+ num011+ num012
                               +num013+ num014+ num015+ num016+ num017
      UPDATE axrq191_tmp1 SET sum_2 = oma56t + net - sum_4        #本幣未逾期金額
      UPDATE axrq191_tmp1 SET sum_1 = oma54t - sum_3              #原幣未逾期金額
      UPDATE axrq191_tmp1 SET sum_5 = 0
   END IF
   #130619--wangrr--MOD--str--
   #LET l_sql = " MERGE INTO axrq191_tmp1 o ",
   #            "      USING (SELECT azi01,azi04 FROM azi_file ",
   #            "              ) n ",
   #            "         ON (o.oma23 = n.azi01) ",
   #            " WHEN MATCHED ",
   #            " THEN ",
   #            "    UPDATE ",
   #            "       SET o.sum_1 = ROUND(o.sum_1,n.azi04),",
   #            "           o.sum_2 = ROUND(o.sum_2,n.azi04),",
   #            "           o.sum_3 = ROUND(o.sum_3,n.azi04),",
   #            "           o.sum_4 = ROUND(o.sum_4,n.azi04),",
   #            "           o.sum_5 = ROUND(o.sum_5,n.azi04),",
   #            "           o.num01 = ROUND(o.num01,n.azi04),",
   #            "           o.num02 = ROUND(o.num02,n.azi04),",
   #            "           o.num03 = ROUND(o.num03,n.azi04),",
   #            "           o.num04 = ROUND(o.num04,n.azi04),",
   #            "           o.num05 = ROUND(o.num05,n.azi04),",
   #            "           o.num06 = ROUND(o.num06,n.azi04),",
   #            "           o.num07 = ROUND(o.num07,n.azi04),",
   #            "           o.num08 = ROUND(o.num08,n.azi04),",
   #            "           o.num09 = ROUND(o.num09,n.azi04),",
   #            "           o.num010 = ROUND(o.num010,n.azi04),",
   #            "           o.num011 = ROUND(o.num011,n.azi04),",
   #            "           o.num012 = ROUND(o.num012,n.azi04),",
   #            "           o.num013 = ROUND(o.num013,n.azi04),",
   #            "           o.num014 = ROUND(o.num014,n.azi04),",
   #            "           o.num015 = ROUND(o.num015,n.azi04),",
   #            "           o.num016 = ROUND(o.num016,n.azi04),",
   #            "           o.num017 = ROUND(o.num017,n.azi04),",
   #            "           o.num1 = ROUND(o.num1,n.azi04),",
   #            "           o.num2 = ROUND(o.num2,n.azi04),",
   #            "           o.num3 = ROUND(o.num3,n.azi04),",
   #            "           o.num4 = ROUND(o.num4,n.azi04),",
   #            "           o.num5 = ROUND(o.num5,n.azi04),",
   #            "           o.num6 = ROUND(o.num6,n.azi04),",
   #            "           o.num7 = ROUND(o.num7,n.azi04),",
   #            "           o.num8 = ROUND(o.num8,n.azi04),",
   #            "           o.num9 = ROUND(o.num9,n.azi04),",
   #            "           o.num10 = ROUND(o.num10,n.azi04),",
   #            "           o.num11 = ROUND(o.num11,n.azi04),",
   #            "           o.num12 = ROUND(o.num12,n.azi04),",
   #            "           o.num13 = ROUND(o.num13,n.azi04),",
   #            "           o.num14 = ROUND(o.num14,n.azi04),",
   #            "           o.num15 = ROUND(o.num15,n.azi04),",
   #            "           o.num16 = ROUND(o.num16,n.azi04),",
   #            "           o.num17 = ROUND(o.num17,n.azi04) "
   LET l_sql = "UPDATE axrq191_tmp1 o ",
               "       SET o.sum_1 = ROUND(o.sum_1,",l_azi04,"),",
               "           o.sum_2 = ROUND(o.sum_2,",l_azi04,"),",
               "           o.sum_3 = ROUND(o.sum_3,",l_azi04,"),",
               "           o.sum_4 = ROUND(o.sum_4,",l_azi04,"),",
               "           o.sum_5 = ROUND(o.sum_5,",l_azi04,"),",
               "           o.num01 = ROUND(o.num01,",l_azi04,"),",
               "           o.num02 = ROUND(o.num02,",l_azi04,"),",
               "           o.num03 = ROUND(o.num03,",l_azi04,"),",
               "           o.num04 = ROUND(o.num04,",l_azi04,"),",
               "           o.num05 = ROUND(o.num05,",l_azi04,"),",
               "           o.num06 = ROUND(o.num06,",l_azi04,"),",
               "           o.num07 = ROUND(o.num07,",l_azi04,"),",
               "           o.num08 = ROUND(o.num08,",l_azi04,"),",
               "           o.num09 = ROUND(o.num09,",l_azi04,"),",
               "           o.num010 = ROUND(o.num010,",l_azi04,"),",
               "           o.num011 = ROUND(o.num011,",l_azi04,"),",
               "           o.num012 = ROUND(o.num012,",l_azi04,"),",
               "           o.num013 = ROUND(o.num013,",l_azi04,"),",
               "           o.num014 = ROUND(o.num014,",l_azi04,"),",
               "           o.num015 = ROUND(o.num015,",l_azi04,"),",
               "           o.num016 = ROUND(o.num016,",l_azi04,"),",
               "           o.num017 = ROUND(o.num017,",l_azi04,"),",
               "           o.num1 = ROUND(o.num1,",l_azi04,"),",
               "           o.num2 = ROUND(o.num2,",l_azi04,"),",
               "           o.num3 = ROUND(o.num3,",l_azi04,"),",
               "           o.num4 = ROUND(o.num4,",l_azi04,"),",
               "           o.num5 = ROUND(o.num5,",l_azi04,"),",
               "           o.num6 = ROUND(o.num6,",l_azi04,"),",
               "           o.num7 = ROUND(o.num7,",l_azi04,"),",
               "           o.num8 = ROUND(o.num8,",l_azi04,"),",
               "           o.num9 = ROUND(o.num9,",l_azi04,"),",
               "           o.num10 = ROUND(o.num10,",l_azi04,"),",
               "           o.num11 = ROUND(o.num11,",l_azi04,"),",
               "           o.num12 = ROUND(o.num12,",l_azi04,"),",
               "           o.num13 = ROUND(o.num13,",l_azi04,"),",
               "           o.num14 = ROUND(o.num14,",l_azi04,"),",
               "           o.num15 = ROUND(o.num15,",l_azi04,"),",
               "           o.num16 = ROUND(o.num16,",l_azi04,"),",
               "           o.num17 = ROUND(o.num17,",l_azi04,") "
   #130619--wangrr--MOD--end
   PREPARE q191_amt_pr5 FROM l_sql
   EXECUTE q191_amt_pr5
END FUNCTION

FUNCTION q191_table2()
   DROP TABLE axrq191_tmp1;
   CREATE TEMP TABLE axrq191_tmp1(
      oma03      LIKE oma_file.oma03,
      oma032     LIKE oma_file.oma032,
      oma00      LIKE oma_file.oma00,
      oma01      LIKE oma_file.oma01,
      oma02      LIKE oma_file.oma02,
      alz12      LIKE alz_file.alz12,
      alz07      LIKE alz_file.alz07,
      oma18      LIKE oma_file.oma18,
      aag02      LIKE aag_file.aag02,
      oma54t     LIKE oma_file.oma54t,
      oma55      LIKE oma_file.oma55,
      oma54t_oma55  LIKE oma_file.oma54t,
      sum_1      LIKE type_file.num20_6,
      sum_3      LIKE type_file.num20_6,
      oma56t     LIKE oma_file.oma56t,
      net        LIKE oox_file.oox10,
      oma57      LIKE oma_file.oma57,
      oma56t_oma57  LIKE oma_file.oma56t,
      sum_2      LIKE type_file.num20_6,
      sum_4      LIKE type_file.num20_6,
      sum_5      LIKE type_file.num20_6,
      num01  LIKE alz_file.alz09,
      num1   LIKE alz_file.alz09,
      num02  LIKE alz_file.alz09,
      num2   LIKE alz_file.alz09,
      num03  LIKE alz_file.alz09,
      num3   LIKE alz_file.alz09,
      num04  LIKE alz_file.alz09,
      num4   LIKE alz_file.alz09,
      num05  LIKE alz_file.alz09,
      num5   LIKE alz_file.alz09,
      num06  LIKE alz_file.alz09,
      num6   LIKE alz_file.alz09,
      num07  LIKE alz_file.alz09,
      num7   LIKE alz_file.alz09,
      num08  LIKE alz_file.alz09,
      num8   LIKE alz_file.alz09,
      num09  LIKE alz_file.alz09,
      num9   LIKE alz_file.alz09,
      num010 LIKE alz_file.alz09,
      num10  LIKE alz_file.alz09,
      num011 LIKE alz_file.alz09,
      num11  LIKE alz_file.alz09,
      num012 LIKE alz_file.alz09,
      num12  LIKE alz_file.alz09,
      num013 LIKE alz_file.alz09,
      num13  LIKE alz_file.alz09,
      num014 LIKE alz_file.alz09,
      num14  LIKE alz_file.alz09,
      num015 LIKE alz_file.alz09,
      num15  LIKE alz_file.alz09,
      num016 LIKE alz_file.alz09,
      num16  LIKE alz_file.alz09,
      num017 LIKE alz_file.alz09,
      num17  LIKE alz_file.alz09,
      l_num01  LIKE alz_file.alz09,
      l_num1   LIKE alz_file.alz09,
      l_num02  LIKE alz_file.alz09,
      l_num2   LIKE alz_file.alz09,
      l_num03  LIKE alz_file.alz09,
      l_num3   LIKE alz_file.alz09,
      l_num04  LIKE alz_file.alz09,
      l_num4   LIKE alz_file.alz09,
      l_num05  LIKE alz_file.alz09,
      l_num5   LIKE alz_file.alz09,
      l_num06  LIKE alz_file.alz09,
      l_num6   LIKE alz_file.alz09,
      l_num07  LIKE alz_file.alz09,
      l_num7   LIKE alz_file.alz09,
      l_num08  LIKE alz_file.alz09,
      l_num8   LIKE alz_file.alz09,
      l_num09  LIKE alz_file.alz09,
      l_num9   LIKE alz_file.alz09,
      l_num010 LIKE alz_file.alz09,
      l_num10  LIKE alz_file.alz09,
      l_num011 LIKE alz_file.alz09,
      l_num11  LIKE alz_file.alz09,
      l_num012 LIKE alz_file.alz09,
      l_num12  LIKE alz_file.alz09,
      l_num013 LIKE alz_file.alz09,
      l_num13  LIKE alz_file.alz09,
      l_num014 LIKE alz_file.alz09,
      l_num14  LIKE alz_file.alz09,
      l_num015 LIKE alz_file.alz09,
      l_num15  LIKE alz_file.alz09,
      l_num016 LIKE alz_file.alz09,
      l_num16  LIKE alz_file.alz09,
      l_num017 LIKE alz_file.alz09,
      l_num17  LIKE alz_file.alz09,
      oma10      LIKE oma_file.oma10,
      oma67      LIKE oma_file.oma67,
      oma33      LIKE oma_file.oma33,
      oma23      LIKE oma_file.oma23,
      azj041_1   LIKE azj_file.azj041,
      azj041     LIKE azj_file.azj041,
      oma15      LIKE oma_file.oma15,
      oma15_desc LIKE gem_file.gem02,
      oma14      LIKE oma_file.oma14,
      oma14_desc LIKE gen_file.gen02,
      oma68      LIKE oma_file.oma68,
      occ18      LIKE occ_file.occ18,
      occ03      LIKE occ_file.occ03,
      occ03_desc LIKE oca_file.oca02,
      oma08      LIKE oma_file.oma08,
      oma25      LIKE oma_file.oma25,
      oma26      LIKE oma_file.oma26,
      azp01      LIKE azp_file.azp01,
      alz09      LIKE alz_file.alz09,
      alz09f     LIKE alz_file.alz09f,
      alz06      LIKE alz_file.alz06,
      flag       LIKE type_file.chr1);
END FUNCTION
#FUN-CB0146--add--end
