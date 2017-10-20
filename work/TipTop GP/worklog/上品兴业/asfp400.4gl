#該程式未解開Section, 採用最新樣板產出!
{<section id="asfp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0022(2017-05-11 11:23:03), PR版次:0022(2017-07-05 09:54:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000257
#+ Filename...: asfp400
#+ Description: 工單轉委外批次作業
#+ Creator....: 00378(2014-04-10 16:29:55)
#+ Modifier...: 01258 -SD/PR- 08992

{</section>}

{<section id="asfp400.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160706-00023#1   2016/07/20  By dorislai   拿掉判斷是否為製程的部分，已詢問過SA，這部分判斷能拿掉，而實際上，製程是不考慮產品特徵的
#160727-00019#18  2016/08/04  By 08734      临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
#160920-00028#1   2016/09/21  By Sarah      判斷製程委外且工單類型='1' 或者 工單類型='2' 的資料都可以拋轉委外採購單
#161109-00085#41  2016/11/17  By lienjunqi  整批調整系統星號寫法
#151118-00011#1   2016/11/29  By Sarah      b_fill段計算可委外數時移除委外完工量(sfcb042)
#170117-00017#1   2017/01/17  By liuym      工单状态为发放时才可以转委外
#170223-00052#1   2017/03/06  By xujing     修改可委外数量如果大于单头生产数量则=单头生产数量
#170221-00009#1   2017/03/09  By shiun      修改產生完單據自動開啟程式(apmt501)沒有直接查詢該單號的問題
#170322-00074#1   2017/03/24  By xujing     当有产品特征页签资料的时候如果与第一页签数量不一致,则给出提示
#170330-00002#1   2017/03/31  By xujing     修改委外供应商开窗为只开当前据点的
#170508-00084#1   2017/05/11  By wuxja      多委外站点时，写入特征页签资料需对应到项次，防止同工单多委外站时数量问题
#170609-00027#1   2017/06/12  By liuym      可转委外数量考虑生产超交率
#170703-00026#1   2017/07/04  By 08992      修正asfp400_chk_tot_qty若傳入參數為0時,離開不需執行
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point

IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point

#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10
DEFINE l_ac                 LIKE type_t.num10
DEFINE l_ac_d               LIKE type_t.num10             #單身idx
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10

TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"

   #end add-point
        wc               STRING
                     END RECORD

TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
                       sel            LIKE type_t.chr1,
                       b_sfcbdocno      LIKE sfcb_t.sfcbdocno,
                       b_sfcb001        LIKE sfcb_t.sfcb001,
                       b_sfcb002        LIKE sfcb_t.sfcb002,
                       b_sfaa003        LIKE sfaa_t.sfaa003,
                       b_sfaa002        LIKE sfaa_t.sfaa002,
                       b_sfaa002_desc   LIKE type_t.chr500,
                       b_sfaa010        LIKE sfaa_t.sfaa010,
                       b_sfaa010_desc1  LIKE imaal_t.imaal003,
                       b_sfaa010_desc2  LIKE imaal_t.imaal004,
                       b_sfcb003        LIKE sfcb_t.sfcb003,
                       b_sfcb003_desc   LIKE type_t.chr500,
                       b_sfcb004        LIKE sfcb_t.sfcb004,
                       b_sfcb020        LIKE sfcb_t.sfcb020,
                       b_sfcb020_desc   LIKE type_t.chr500,
                       b_tot_qty        LIKE sfaa_t.sfaa012,
                       b_carry_qty      LIKE sfaa_t.sfaa012,
                       b_sfcb013        LIKE sfcb_t.sfcb013,
                       b_sfcb013_desc   LIKE type_t.chr500,
                       b_sfcb044        LIKE sfcb_t.sfcb044,
                       b_sfcb045        LIKE sfcb_t.sfcb045,
                       b_pmdl017        LIKE pmdl_t.pmdl017,
                       b_pmdl017_desc   LIKE type_t.chr500,
                       b_pmdl015        LIKE pmdl_t.pmdl015,
                       b_pmdl015_desc   LIKE type_t.chr500,
                       b_exrate         LIKE ooan_t.ooan005,
                       b_pmdl011        LIKE pmdl_t.pmdl011,
                       b_pmdl011_desc   LIKE type_t.chr500,
                       b_price          LIKE pmdn_t.pmdn015
                       END RECORD
TYPE type_g_sfac_d     RECORD
                       b_sfac006        LIKE sfac_t.sfac006,
                       b_sfac003        LIKE sfac_t.sfac003,
                       b_qty1           LIKE sfaa_t.sfaa012,
                       b_qty2           LIKE sfaa_t.sfaa012,
                       b_qty3           LIKE sfaa_t.sfaa012
                       END RECORD

DEFINE g_sfac_d        DYNAMIC ARRAY OF type_g_sfac_d
DEFINE g_rec_b1        LIKE type_t.num10
DEFINE g_rec_b2        LIKE type_t.num10
DEFINE g_param         type_parameter
DEFINE l_ac1           LIKE type_t.num10

TYPE type_g_arr1       RECORD
                       sfcbdocno      LIKE sfcb_t.sfcbdocno,
                       sfaa010        LIKE sfaa_t.sfaa010,
                       sfcb001        LIKE sfcb_t.sfcb001,
                       sfcb002        LIKE sfcb_t.sfcb002,
                       sfcb003        LIKE sfcb_t.sfcb003,
                       sfcb004        LIKE sfcb_t.sfcb004,
                       sfcb020        LIKE sfcb_t.sfcb020,
                       carry_qty      LIKE sfaa_t.sfaa012,
                       sfcb013        LIKE sfcb_t.sfcb013,
                       sfcb044        LIKE sfcb_t.sfcb044,
                       sfcb045        LIKE sfcb_t.sfcb045,
                       pmdl017        LIKE pmdl_t.pmdl017,
                       pmdl015        LIKE pmdl_t.pmdl015,
                       exrate         LIKE ooan_t.ooan005,
                       pmdl011        LIKE pmdl_t.pmdl011,
                       price          LIKE pmdn_t.pmdn015
                       END RECORD

TYPE type_g_arr2       RECORD
                       sfacdocno      LIKE sfac_t.sfacdocno,
                       sfac006        LIKE sfac_t.sfac006,
                       carry_qty      LIKE sfac_t.sfac003
                       END RECORD
DEFINE g_arr1          DYNAMIC ARRAY OF type_g_arr1
DEFINE g_arr2          DYNAMIC ARRAY OF type_g_arr2
DEFINE g_pmal          DYNAMIC ARRAY OF RECORD
                       b_sfcb013     LIKE pmdl_t.pmdl004,
                       pmal002       LIKE pmal_t.pmal002
                       END RECORD
#end add-point

#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d

#add-point:傳入參數說明 name="global.argv"

#end add-point

{</section>}

{<section id="asfp400.main" >}
#+ 作業開始
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"

   #end add-point
   DEFINE ls_js  STRING
   #add-point:main段define name="main.define"
   DEFINE l_success     LIKE type_t.num10
   #end add-point

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #add-point:初始化前定義 name="main.before_ap_init"

   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asf","")

   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL asfp400_def_cursor('2')
   #end add-point

   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"

      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfp400 WITH FORM cl_ap_formpath("asf",g_code)

      #瀏覽頁簽資料初始化
      CALL cl_ui_init()

      #程式初始化
      CALL asfp400_init()

      #進入選單 Menu (="N")
      CALL asfp400_ui_dialog()

      #add-point:畫面關閉前 name="main.before_close"
      CALL asfp400_drop_tmp_table()
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_asfp400
   END IF

   #add-point:作業離開前 name="main.exit"

   #end add-point

   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN

{</section>}

{<section id="asfp400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfp400_init()
   #add-point:init段define(客製用) name="init.define_customerization"

   #end add-point
   #add-point:init段define name="init.define"
   DEFINE lwin_curr      ui.Window
   DEFINE lfrm_curr      ui.Form
   DEFINE ls_path        STRING
   DEFINE l_success      LIKE type_t.num5
   #end add-point

   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"

   #add-point:畫面資料初始化 name="init.init"

   #载入query按键
#   LET lwin_curr = ui.Window.getCurrent()
#   LET lfrm_curr = lwin_curr.getForm()
#   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
#   LET ls_path = os.Path.join(ls_path,"toolbar_q.4tb")
#   CALL lfrm_curr.loadToolBar(ls_path)

   #工单状态
   CALL cl_set_combo_scc('b_sfaa003','4007')
   CALL cl_set_combo_scc('sfaa003','4007')

   #创建临时表
   CALL asfp400_cre_tmp_table()
        RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF
   #end add-point

END FUNCTION

{</section>}

{<section id="asfp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfp400_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"

   #end add-point
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_sfcb_t         type_g_detail_d
   DEFINE l_sfac_t         type_g_sfac_d
   DEFINE l_success        LIKE type_t.num5
   #161109-00085#41-s
   #DEFINE l_sfcb           RECORD LIKE sfcb_t.*
   DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
   END RECORD
   #161109-00085#41-e
   DEFINE l_sql            STRING
   DEFINE l_sql1           STRING

   LET g_param.wc = ' 1=1'
   CALL asfp400_query()
   #end add-point

   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)

   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"

   #end add-point

   WHILE TRUE

      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asfp400_init()
      END IF

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"

         CONSTRUCT BY NAME g_param.wc ON sfcbdocno, sfcb001, sfaa003, sfaa002, sfaa010, sfcb003, sfcb004, sfcb020

            #工单单号
            ON ACTION controlp INFIELD sfcbdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfcbdocno_3()
               DISPLAY g_qryparam.return1 TO sfcbdocno
               NEXT FIELD sfcbdocno

            #人员编号
            ON ACTION controlp INFIELD sfaa002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO sfaa002
               NEXT FIELD sfaa002

            #生产料号
            ON ACTION controlp INFIELD sfaa010
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()
               DISPLAY g_qryparam.return1 TO sfaa010
               NEXT FIELD sfaa010

            #作业编号
            ON ACTION controlp INFIELD sfcb003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '221'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO sfcb003
               NEXT FIELD sfcb003

            #单位
            ON ACTION controlp INFIELD sfcb020
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooca001()
               DISPLAY g_qryparam.return1 TO sfcb020
               NEXT FIELD sfcb020

         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"

         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)

            BEFORE ROW
               LET l_ac = ARR_CURR()
               CALL asfp400_b2_fill()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL cl_set_comp_entry('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',TRUE)
               ELSE
                  CALL cl_set_comp_entry('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',FALSE)
               END IF

               INITIALIZE l_sfcb.* TO NULL
               IF NOT cl_null(g_detail_d[l_ac].b_sfcbdocno) AND NOT cl_null(g_detail_d[l_ac].b_sfcb001) AND
                  NOT cl_null(g_detail_d[l_ac].b_sfcb002) THEN
                  #161109-00085#41-s
                  #SELECT * INTO l_sfcb.* FROM sfcb_t
                  SELECT sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
                         sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
                         sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
                         sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
                         sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
                         sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
                         sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
                         sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
                         sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
                         sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
                         sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
                         sfcb053,sfcb054,sfcb055
                  INTO l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
                       l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
                       l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
                       l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
                       l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
                       l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
                       l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
                       l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
                       l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
                       l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
                       l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
                       l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
                  FROM sfcb_t
                  #161109-00085#41-e
                   WHERE sfcbent   = g_enterprise
                     AND sfcbdocno = g_detail_d[l_ac].b_sfcbdocno
                     AND sfcb001   = g_detail_d[l_ac].b_sfcb001
                     AND sfcb002   = g_detail_d[l_ac].b_sfcb002
               END IF
               LET l_sfcb_t.* = g_detail_d[l_ac].*

            BEFORE FIELD b_sel
               CALL cl_set_comp_entry('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',TRUE)
               CALL cl_set_comp_required('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',FALSE)

            AFTER FIELD b_sel
               IF g_detail_d[l_ac].sel NOT MATCHES '[YN]' THEN
                  NEXT FIELD b_sel
               END IF
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL cl_set_comp_required('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',TRUE)
                  #本次委外数
                  IF cl_null(g_detail_d[l_ac].b_carry_qty) OR g_detail_d[l_ac].b_carry_qty = 0 THEN
                     LET g_detail_d[l_ac].b_carry_qty = g_detail_d[l_ac].b_tot_qty
                  END IF
                  #委外厂商
                  IF cl_null(g_detail_d[l_ac].b_sfcb013) THEN
                     LET g_detail_d[l_ac].b_sfcb013 = l_sfcb.sfcb013
                     CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].b_sfcb013)
                          RETURNING g_detail_d[l_ac].b_sfcb013_desc
                     #取价方式/币种/税种的DEFAULT
                     CALL asfp400_b_sfcb013_reference(l_ac)
                  END IF
                  #预计交期
                  IF cl_null(g_detail_d[l_ac].b_sfcb045) THEN
                     LET g_detail_d[l_ac].b_sfcb045 = l_sfcb.sfcb045
                  END IF
               ELSE
                  CALL cl_set_comp_entry('b_carry_qty,b_sfcb013,b_sfcb045,b_pmdl017,b_pmdl015,b_pmdl011',FALSE)
               END IF

            AFTER FIELD b_carry_qty
               IF NOT cl_null(g_detail_d[l_ac].b_carry_qty) THEN
                  CALL s_asfp400_chk_carry_qty(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_sfcb001,
                                               g_detail_d[l_ac].b_sfcb002,g_detail_d[l_ac].b_carry_qty)
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_detail_d[l_ac].b_carry_qty = l_sfcb_t.b_carry_qty
                     NEXT FIELD b_carry_qty
                  END IF
                  #170322-00074#1 add(s)
                  IF NOT asfp400_chk_tot_qty(l_ac) THEN

                  END IF
                  #170322-00074#1 add(e)
               END IF

            AFTER FIELD b_sfcb013
               IF NOT cl_null(g_detail_d[l_ac].b_sfcb013) THEN
                  IF cl_null(l_sfcb_t.b_sfcb013) OR l_sfcb_t.b_sfcb013 <> g_detail_d[l_ac].b_sfcb013 THEN
                     CALL s_asfp400_chk_sfcb013(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_sfcb013,NULL)
                          RETURNING l_success
                     IF NOT l_success THEN
                        LET g_detail_d[l_ac].b_sfcb013 = l_sfcb_t.b_sfcb013
                        CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].b_sfcb013)
                             RETURNING g_detail_d[l_ac].b_sfcb013_desc
                        NEXT FIELD b_sfcb013
                     END IF
                     CALL asfp400_b_sfcb013_reference(l_ac)
                  END IF
                  CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].b_sfcb013)
                       RETURNING g_detail_d[l_ac].b_sfcb013_desc
               ELSE
                  LET g_detail_d[l_ac].b_sfcb013_desc = NULL
               END IF


            AFTER FIELD b_sfcb045
               IF NOT cl_null(g_detail_d[l_ac].b_sfcb045) THEN
                  CALL s_asfp400_chk_sfcb045(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_sfcb044,g_detail_d[l_ac].b_sfcb045,NULL)
                       RETURNING l_success
                  IF NOT l_success THEN
                     LET g_detail_d[l_ac].b_sfcb045 = l_sfcb_t.b_sfcb045
                     NEXT FIELD b_sfcb045
                  END IF
               END IF

            AFTER FIELD b_pmdl017
               IF NOT cl_null(g_detail_d[l_ac].b_pmdl017) THEN
                  IF cl_null(l_sfcb_t.b_pmdl017) OR l_sfcb_t.b_pmdl017 <> g_detail_d[l_ac].b_pmdl017 THEN
                     CALL s_asfp400_chk_pmdl017(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_pmdl017)
                          RETURNING l_success
                     IF NOT l_success THEN
                        LET g_detail_d[l_ac].b_pmdl017 = l_sfcb_t.b_pmdl017
                        CALL s_desc_get_price_type_desc(g_detail_d[l_ac].b_pmdl017)
                             RETURNING g_detail_d[l_ac].b_pmdl017_desc
                        NEXT FIELD b_pmdl017
                     END IF
                  END IF
                  CALL s_desc_get_price_type_desc(g_detail_d[l_ac].b_pmdl017)
                       RETURNING g_detail_d[l_ac].b_pmdl017_desc
               ELSE
                  LET g_detail_d[l_ac].b_pmdl017_desc = NULL
               END IF

            AFTER FIELD b_pmdl015
               IF NOT cl_null(g_detail_d[l_ac].b_pmdl015) THEN
                  IF cl_null(l_sfcb_t.b_pmdl015) OR l_sfcb_t.b_pmdl015 <> g_detail_d[l_ac].b_pmdl015 THEN
                     CALL s_asfp400_chk_pmdl015(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_pmdl015)
                          RETURNING l_success
                     IF NOT l_success THEN
                        LET g_detail_d[l_ac].b_pmdl015 = l_sfcb_t.b_pmdl015
                        CALL s_desc_get_currency_desc(g_detail_d[l_ac].b_pmdl015)
                             RETURNING g_detail_d[l_ac].b_pmdl015_desc
                        NEXT FIELD b_pmdl015
                     END IF
                  END IF
                  CALL s_desc_get_currency_desc(g_detail_d[l_ac].b_pmdl015)
                       RETURNING g_detail_d[l_ac].b_pmdl015_desc
                  CALL asfp400_get_b_exrate(g_detail_d[l_ac].b_pmdl015)
                       RETURNING g_detail_d[l_ac].b_exrate
               ELSE
                  LET g_detail_d[l_ac].b_pmdl015_desc = NULL
                  LET g_detail_d[l_ac].b_exrate = NULL
               END IF

            AFTER FIELD b_pmdl011
               IF NOT cl_null(g_detail_d[l_ac].b_pmdl011) THEN
                  IF cl_null(l_sfcb_t.b_pmdl011) OR l_sfcb_t.b_pmdl011 <> g_detail_d[l_ac].b_pmdl011 THEN
                     CALL s_asfp400_chk_pmdl011(g_detail_d[l_ac].b_sfcbdocno,g_detail_d[l_ac].b_pmdl011)
                          RETURNING l_success
                     IF NOT l_success THEN
                        LET g_detail_d[l_ac].b_pmdl011 = l_sfcb_t.b_pmdl011
                        CALL s_desc_get_tax_desc1(g_site,g_detail_d[l_ac].b_pmdl011)
                             RETURNING g_detail_d[l_ac].b_pmdl011_desc
                        NEXT FIELD b_pmdl011
                     END IF
                  END IF
                  CALL s_desc_get_tax_desc1(g_site,g_detail_d[l_ac].b_pmdl011)
                       RETURNING g_detail_d[l_ac].b_pmdl011_desc
               ELSE
                  LET g_detail_d[l_ac].b_pmdl011_desc = NULL
               END IF


            ON ACTION controlp INFIELD b_sfcb013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].b_sfcb013
               LET g_qryparam.where = "1=1 "
               LET l_sql = ''
               CALL s_control_get_sql("pmaa080",'3','4',g_user,g_dept) RETURNING l_success,l_sql
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
               END IF
               LET l_sql1 = ''
               CALL s_control_get_sql("pmaa001",'4','4',g_user,g_dept) RETURNING l_success,l_sql1
               IF l_success THEN
                  LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
               END IF
#               CALL q_pmaa001_3()     #170330-00002#1 mark
               LET g_qryparam.arg1 = g_site #170330-00002#1 add
               CALL q_pmaa001_28()          #170330-00002#1 add
               LET g_detail_d[l_ac].b_sfcb013 = g_qryparam.return1
               NEXT FIELD b_sfcb013

            ON ACTION controlp INFIELD b_pmdl017
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].b_pmdl017
               CALL q_pmam001()
               LET g_detail_d[l_ac].b_pmdl017 = g_qryparam.return1
               NEXT FIELD b_pmdl017

            ON ACTION controlp INFIELD b_pmdl015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].b_pmdl015
               LET g_qryparam.arg1 = g_site
               CALL q_ooaj002_1()
               LET g_detail_d[l_ac].b_pmdl015 = g_qryparam.return1
               NEXT FIELD b_pmdl015

            ON ACTION controlp INFIELD b_pmdl011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_detail_d[l_ac].b_pmdl011
               CALL q_oodb002_2()
               LET g_detail_d[l_ac].b_pmdl011 = g_qryparam.return1
               NEXT FIELD b_pmdl011

            ON ACTION cancel
               LET INT_FLAG = 1
               EXIT DIALOG

         END INPUT


         INPUT ARRAY g_sfac_d FROM s_detail2.*
             ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = FALSE,
                     DELETE ROW = FALSE,
                     APPEND ROW = FALSE)

            BEFORE ROW
               IF g_rec_b2 <=0 THEN
                  CONTINUE DIALOG
               END IF
               LET l_ac1 = ARR_CURR()
               LET l_sfac_t.* = g_sfac_d[l_ac1].*


            AFTER FIELD b_qty3
               CALL asfp400_chk_b_qty3(l_ac1)
                    RETURNING l_success
               IF NOT l_success THEN
                  LET g_sfac_d[l_ac1].b_qty3 = l_sfac_t.b_qty3
                  NEXT FIELD b_qty3
               END IF

            ON ROW CHANGE
               IF l_sfac_t.b_qty3 <> g_sfac_d[l_ac1].b_qty3 THEN
                  CALL s_transaction_begin()
                  UPDATE asfp400_tmp01 SET qty3 = g_sfac_d[l_ac1].b_qty3  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
                   WHERE sfacdocno = g_detail_d[l_ac].b_sfcbdocno
                     AND sfac006   = g_sfac_d[l_ac1].b_sfac006
                     AND sfcb001   = g_detail_d[l_ac].b_sfcb001   #170508-00084#1 add
                     AND sfcb002   = g_detail_d[l_ac].b_sfcb002   #170508-00084#1 add
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update asfp400_tmp01'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  #  CANCEL UPDATE
                     CALL s_transaction_end('N',1)
                  ELSE
                     CALL s_transaction_end('Y',0)
                  END IF
               END IF

            AFTER INPUT
               CALL asfp400_chk_tot_qty(l_ac)
                    RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD b_qty3
               END IF

            ON ACTION cancel
               LET INT_FLAG = 1
               EXIT DIALOG

         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point

         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"

            #end add-point

         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"

            #end add-point
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"

            #end add-point

         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"

               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"

            #end add-point

         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"

            #end add-point

         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"

            #end add-point

         ON ACTION filter
            LET g_action_choice="filter"
            CALL asfp400_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG

         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG

         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"

            #end add-point
            CALL asfp400_query()

         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"

            #end add-point

         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"

            #end add-point
            CALL asfp400_b_fill()

         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            #170322-00074#1 add(S)
            #如果光标最后停在第二个页签,并且直接点击执行,则最最后一次更新第二页签的数量
            IF l_ac1 > 0  AND l_ac> 0 THEN
               IF l_sfac_t.b_qty3 <> g_sfac_d[l_ac1].b_qty3 THEN
                  CALL s_transaction_begin()
                  UPDATE asfp400_tmp01 SET qty3 = g_sfac_d[l_ac1].b_qty3  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
                   WHERE sfacdocno = g_detail_d[l_ac].b_sfcbdocno
                     AND sfac006   = g_sfac_d[l_ac1].b_sfac006
                     AND sfcb001   = g_detail_d[l_ac].b_sfcb001   #170508-00084#1 add
                     AND sfcb002   = g_detail_d[l_ac].b_sfcb002   #170508-00084#1 add
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'update asfp400_tmp01'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                  #  CANCEL UPDATE
                     CALL s_transaction_end('N',1)
                  ELSE
                     CALL s_transaction_end('Y',0)
                  END IF
               END IF
            END IF
            #170322-00074#1 add(e)
            CALL asfp400_carry_po()
                 RETURNING l_success
            IF l_success THEN      #170322-00074#1 add
               CALL asfp400_b_fill()
            END IF
            IF l_ac > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1",l_ac)
               LET l_sfcb_t.* = g_detail_d[l_ac].*
            END IF
         #end add-point

         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG

      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"

      #end add-point
      #(ver:22) --- end ---

      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"

         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF

   END WHILE

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

{</section>}

{<section id="asfp400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfp400_query()
   #add-point:query段define(客製用) name="query.define_customerization"

   #end add-point
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING
   #add-point:query段define name="query.define"

   #end add-point

   #add-point:cs段after_construct name="query.after_construct"
   LET g_master_idx = l_ac
   #end add-point

   LET g_error_show = 1
   CALL asfp400_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = -100
      LET g_errparam.popup  = TRUE
      CALL cl_err()

   END IF

   #add-point:cs段after_query name="query.cs_after_query"

   #end add-point

END FUNCTION

{</section>}

{<section id="asfp400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfp400_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"

   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   #161109-00085#41-s
   #DEFINE l_sfaa         RECORD LIKE sfaa_t.*
   DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企業編號
       sfaaownid LIKE sfaa_t.sfaaownid, #資料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #資料所有部門
       sfaacrtid LIKE sfaa_t.sfaacrtid, #資料建立者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #資料建立部門
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #資料創建日
       sfaamodid LIKE sfaa_t.sfaamodid, #資料修改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近修改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #資料確認者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #資料確認日
       sfaapstid LIKE sfaa_t.sfaapstid, #資料過帳者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #資料過帳日
       sfaastus LIKE sfaa_t.sfaastus, #狀態碼
       sfaasite LIKE sfaa_t.sfaasite, #營運據點
       sfaadocno LIKE sfaa_t.sfaadocno, #單號
       sfaadocdt LIKE sfaa_t.sfaadocdt, #單據日期
       sfaa001 LIKE sfaa_t.sfaa001, #變更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人員
       sfaa003 LIKE sfaa_t.sfaa003, #工單類型
       sfaa004 LIKE sfaa_t.sfaa004, #發料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工單來源
       sfaa006 LIKE sfaa_t.sfaa006, #來源單號
       sfaa007 LIKE sfaa_t.sfaa007, #來源項次
       sfaa008 LIKE sfaa_t.sfaa008, #來源項序
       sfaa009 LIKE sfaa_t.sfaa009, #參考客戶
       sfaa010 LIKE sfaa_t.sfaa010, #生產料號
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa013 LIKE sfaa_t.sfaa013, #生產單位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #製程編號
       sfaa017 LIKE sfaa_t.sfaa017, #部門供應商
       sfaa018 LIKE sfaa_t.sfaa018, #協作據點
       sfaa019 LIKE sfaa_t.sfaa019, #預計開工日
       sfaa020 LIKE sfaa_t.sfaa020, #預計完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工單單號
       sfaa022 LIKE sfaa_t.sfaa022, #參考原始單號
       sfaa023 LIKE sfaa_t.sfaa023, #參考原始項次
       sfaa024 LIKE sfaa_t.sfaa024, #參考原始項序
       sfaa025 LIKE sfaa_t.sfaa025, #前工單單號
       sfaa026 LIKE sfaa_t.sfaa026, #料表批號(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #專案編號
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活動
       sfaa031 LIKE sfaa_t.sfaa031, #理由碼
       sfaa032 LIKE sfaa_t.sfaa032, #緊急比率
       sfaa033 LIKE sfaa_t.sfaa033, #優先順序
       sfaa034 LIKE sfaa_t.sfaa034, #預計入庫庫位
       sfaa035 LIKE sfaa_t.sfaa035, #預計入庫儲位
       sfaa036 LIKE sfaa_t.sfaa036, #手冊編號
       sfaa037 LIKE sfaa_t.sfaa037, #保稅核准文號
       sfaa038 LIKE sfaa_t.sfaa038, #保稅核銷
       sfaa039 LIKE sfaa_t.sfaa039, #備料已產生
       sfaa040 LIKE sfaa_t.sfaa040, #生產途程已確認
       sfaa041 LIKE sfaa_t.sfaa041, #凍結
       sfaa042 LIKE sfaa_t.sfaa042, #重工
       sfaa043 LIKE sfaa_t.sfaa043, #備置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #實際開始發料日
       sfaa046 LIKE sfaa_t.sfaa046, #最後入庫日
       sfaa047 LIKE sfaa_t.sfaa047, #生管結案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本結案日
       sfaa049 LIKE sfaa_t.sfaa049, #已發料套數
       sfaa050 LIKE sfaa_t.sfaa050, #已入庫合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入庫不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工單轉入數量
       sfaa054 LIKE sfaa_t.sfaa054, #工單轉出數量
       sfaa055 LIKE sfaa_t.sfaa055, #下線數量
       sfaa056 LIKE sfaa_t.sfaa056, #報廢數量
       sfaa057 LIKE sfaa_t.sfaa057, #委外類型
       sfaa058 LIKE sfaa_t.sfaa058, #參考數量
       sfaa059 LIKE sfaa_t.sfaa059, #預計入庫批號
       sfaa060 LIKE sfaa_t.sfaa060, #參考單位
       sfaa061 LIKE sfaa_t.sfaa061, #製程
       sfaa062 LIKE sfaa_t.sfaa062, #納入APS計算
       sfaa063 LIKE sfaa_t.sfaa063, #來源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #參考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管結案狀態
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程編號
       sfaa067 LIKE sfaa_t.sfaa067, #多角流程式號
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供給量
       sfaa070 LIKE sfaa_t.sfaa070, #原始預計完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齊料套數
       sfaa072 LIKE sfaa_t.sfaa072  #保稅否
   END RECORD
   #161109-00085#41-e
   #161109-00085#41-s
   #DEFINE l_sfcb           RECORD LIKE sfcb_t.*
   DEFINE l_sfcb RECORD  #工單製程單身檔
       sfcbent LIKE sfcb_t.sfcbent, #企業編號
       sfcbsite LIKE sfcb_t.sfcbsite, #營運據點
       sfcbdocno LIKE sfcb_t.sfcbdocno, #單號
       sfcb001 LIKE sfcb_t.sfcb001, #RUN CARD
       sfcb002 LIKE sfcb_t.sfcb002, #項次
       sfcb003 LIKE sfcb_t.sfcb003, #本站作業
       sfcb004 LIKE sfcb_t.sfcb004, #作業序
       sfcb005 LIKE sfcb_t.sfcb005, #群組性質
       sfcb006 LIKE sfcb_t.sfcb006, #群組
       sfcb007 LIKE sfcb_t.sfcb007, #上站作業
       sfcb008 LIKE sfcb_t.sfcb008, #上站作業序
       sfcb009 LIKE sfcb_t.sfcb009, #下站作業
       sfcb010 LIKE sfcb_t.sfcb010, #下站作業序
       sfcb011 LIKE sfcb_t.sfcb011, #工作站
       sfcb012 LIKE sfcb_t.sfcb012, #允許委外
       sfcb013 LIKE sfcb_t.sfcb013, #主要加工廠
       sfcb014 LIKE sfcb_t.sfcb014, #Move in
       sfcb015 LIKE sfcb_t.sfcb015, #Check in
       sfcb016 LIKE sfcb_t.sfcb016, #報工站
       sfcb017 LIKE sfcb_t.sfcb017, #PQC
       sfcb018 LIKE sfcb_t.sfcb018, #Check out
       sfcb019 LIKE sfcb_t.sfcb019, #Move out
       sfcb020 LIKE sfcb_t.sfcb020, #轉出單位
       sfcb021 LIKE sfcb_t.sfcb021, #單位轉換率分子
       sfcb022 LIKE sfcb_t.sfcb022, #單位轉換率分母
       sfcb023 LIKE sfcb_t.sfcb023, #固定工時
       sfcb024 LIKE sfcb_t.sfcb024, #標準工時
       sfcb025 LIKE sfcb_t.sfcb025, #固定機時
       sfcb026 LIKE sfcb_t.sfcb026, #標準機時
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
       sfcb028 LIKE sfcb_t.sfcb028, #良品轉入
       sfcb029 LIKE sfcb_t.sfcb029, #重工轉入
       sfcb030 LIKE sfcb_t.sfcb030, #回收轉入
       sfcb031 LIKE sfcb_t.sfcb031, #分割轉入
       sfcb032 LIKE sfcb_t.sfcb032, #合併轉入
       sfcb033 LIKE sfcb_t.sfcb033, #良品轉出
       sfcb034 LIKE sfcb_t.sfcb034, #重工轉出
       sfcb035 LIKE sfcb_t.sfcb035, #回收轉出
       sfcb036 LIKE sfcb_t.sfcb036, #當站報廢
       sfcb037 LIKE sfcb_t.sfcb037, #當站下線
       sfcb038 LIKE sfcb_t.sfcb038, #分割轉出
       sfcb039 LIKE sfcb_t.sfcb039, #合併轉出
       sfcb040 LIKE sfcb_t.sfcb040, #Bonus
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042, #委外完工數
       sfcb043 LIKE sfcb_t.sfcb043, #盤點數
       sfcb044 LIKE sfcb_t.sfcb044, #預計開工日
       sfcb045 LIKE sfcb_t.sfcb045, #預計完工日
       sfcb046 LIKE sfcb_t.sfcb046, #待Move in數
       sfcb047 LIKE sfcb_t.sfcb047, #待Check in數
       sfcb048 LIKE sfcb_t.sfcb048, #待Check out數
       sfcb049 LIKE sfcb_t.sfcb049, #待Move out數
       sfcb050 LIKE sfcb_t.sfcb050, #在製數
       sfcb051 LIKE sfcb_t.sfcb051, #待PQC數
       sfcb052 LIKE sfcb_t.sfcb052, #轉入單位
       sfcb053 LIKE sfcb_t.sfcb053, #轉入單位轉換率分子
       sfcb054 LIKE sfcb_t.sfcb054, #轉入單位轉換率分母
       sfcb055 LIKE sfcb_t.sfcb055  #回收站
   END RECORD
   #161109-00085#41-e
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_unfinish_rt  LIKE type_t.num26_10
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num10
   DEFINE l_sfca003      LIKE sfca_t.sfca003  #170223-00052#1 add
   DEFINE l_imae020      LIKE imae_t.imae020  #170609-00027#1 add
   #end add-point

   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()

   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #可委外數=標準產出數量(sfcb027)+重工轉入(sfcb029)+工單轉入(sfcb030)+分割轉入(sfcb031)+合併轉入(sfcb032)
   #        -良品轉出(sfcb033)-重工轉出(sfcb034)-工單轉出(sfcb035)-當站報廢(sfcb036)-當站下線(sfcb037)
   #        -分割轉出(sfcb038)-合併轉出(sfcb039)-委外數量(sfcb041)
#  #        +委外完工數量(sfcb042)   #151118-00011#1 mark 計算時移除委外完工量(sfcb042)

   DELETE FROM asfp400_tmp01;  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
   #161109-00085#41-s
   #LET g_sql = " SELECT sfaa_t.*,sfcb_t.* ",
   LET g_sql =
              " SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,
                       sfaacrtdt,sfaamodid,sfaamoddt,sfaacnfid,sfaacnfdt,
                       sfaapstid,sfaapstdt,sfaastus,sfaasite,sfaadocno,
                       sfaadocdt,sfaa001,sfaa002,sfaa003,sfaa004,
                       sfaa005,sfaa006,sfaa007,sfaa008,sfaa009,
                       sfaa010,sfaa011,sfaa012,sfaa013,sfaa014,
                       sfaa015,sfaa016,sfaa017,sfaa018,sfaa019,
                       sfaa020,sfaa021,sfaa022,sfaa023,sfaa024,
                       sfaa025,sfaa026,sfaa027,sfaa028,sfaa029,
                       sfaa030,sfaa031,sfaa032,sfaa033,sfaa034,
                       sfaa035,sfaa036,sfaa037,sfaa038,sfaa039,
                       sfaa040,sfaa041,sfaa042,sfaa043,sfaa044,
                       sfaa045,sfaa046,sfaa047,sfaa048,sfaa049,
                       sfaa050,sfaa051,sfaa052,sfaa053,sfaa054,
                       sfaa055,sfaa056,sfaa057,sfaa058,sfaa059,
                       sfaa060,sfaa061,sfaa062,sfaa063,sfaa064,
                       sfaa065,sfaa066,sfaa067,sfaa068,sfaa069,
                       sfaa070,sfaa071,sfaa072,
                       sfcbent,sfcbsite,sfcbdocno,sfcb001,sfcb002,
                       sfcb003,sfcb004,sfcb005,sfcb006,sfcb007,
                       sfcb008,sfcb009,sfcb010,sfcb011,sfcb012,
                       sfcb013,sfcb014,sfcb015,sfcb016,sfcb017,
                       sfcb018,sfcb019,sfcb020,sfcb021,sfcb022,
                       sfcb023,sfcb024,sfcb025,sfcb026,sfcb027,
                       sfcb028,sfcb029,sfcb030,sfcb031,sfcb032,
                       sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
                       sfcb038,sfcb039,sfcb040,sfcb041,sfcb042,
                       sfcb043,sfcb044,sfcb045,sfcb046,sfcb047,
                       sfcb048,sfcb049,sfcb050,sfcb051,sfcb052,
                       sfcb053,sfcb054,sfcb055",
   #161109-00085#41-e
               "  FROM sfcb_t,sfaa_t ",
               " WHERE sfcbent   = sfaaent AND sfcbent = ? ",
               "   AND sfaasite  = '",g_site,"'",
               "   AND sfcbdocno = sfaadocno ",
              # "   AND sfaastus IN ('F','Y') ",         #170117-00017#1 mark
              "     AND sfaastus ='F'    ",               #170117-00017#1 add
#160920-00028#1-s mod
#              "   AND (sfcb012  = 'Y' OR sfaa057 = '2')",
               "   AND ((sfcb012  = 'Y' AND sfaa057 = '1') OR sfaa057 = '2')",
#160920-00028#1-e mod
               "   AND (sfcb027 + sfcb029 + sfcb030 + sfcb031 + sfcb032 ",
               "      - sfcb033 - sfcb034 - sfcb035 - sfcb036 - sfcb037 ",
              #"      - sfcb038 - sfcb039 - sfcb041 + sfcb042) > 0 ",  #151118-00011#1 mark
               "      - sfcb038 - sfcb039 - sfcb041) > 0 ",            #151118-00011#1 mod
               "   AND ",g_param.wc,
               " ORDER BY sfcbdocno,sfcb002"
   #end add-point

   PREPARE asfp400_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfp400_sel

   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL g_pmal.clear()
   #end add-point

   LET g_cnt = l_ac
   LET l_ac = 1
   ERROR "Searching!"

   FOREACH b_fill_curs USING g_enterprise INTO
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   #161109-00085#41-s
   #l_sfaa.*,l_sfcb.*
    l_sfaa.sfaaent,l_sfaa.sfaaownid,l_sfaa.sfaaowndp,l_sfaa.sfaacrtid,l_sfaa.sfaacrtdp,
    l_sfaa.sfaacrtdt,l_sfaa.sfaamodid,l_sfaa.sfaamoddt,l_sfaa.sfaacnfid,l_sfaa.sfaacnfdt,
    l_sfaa.sfaapstid,l_sfaa.sfaapstdt,l_sfaa.sfaastus,l_sfaa.sfaasite,l_sfaa.sfaadocno,
    l_sfaa.sfaadocdt,l_sfaa.sfaa001,l_sfaa.sfaa002,l_sfaa.sfaa003,l_sfaa.sfaa004,
    l_sfaa.sfaa005,l_sfaa.sfaa006,l_sfaa.sfaa007,l_sfaa.sfaa008,l_sfaa.sfaa009,
    l_sfaa.sfaa010,l_sfaa.sfaa011,l_sfaa.sfaa012,l_sfaa.sfaa013,l_sfaa.sfaa014,
    l_sfaa.sfaa015,l_sfaa.sfaa016,l_sfaa.sfaa017,l_sfaa.sfaa018,l_sfaa.sfaa019,
    l_sfaa.sfaa020,l_sfaa.sfaa021,l_sfaa.sfaa022,l_sfaa.sfaa023,l_sfaa.sfaa024,
    l_sfaa.sfaa025,l_sfaa.sfaa026,l_sfaa.sfaa027,l_sfaa.sfaa028,l_sfaa.sfaa029,
    l_sfaa.sfaa030,l_sfaa.sfaa031,l_sfaa.sfaa032,l_sfaa.sfaa033,l_sfaa.sfaa034,
    l_sfaa.sfaa035,l_sfaa.sfaa036,l_sfaa.sfaa037,l_sfaa.sfaa038,l_sfaa.sfaa039,
    l_sfaa.sfaa040,l_sfaa.sfaa041,l_sfaa.sfaa042,l_sfaa.sfaa043,l_sfaa.sfaa044,
    l_sfaa.sfaa045,l_sfaa.sfaa046,l_sfaa.sfaa047,l_sfaa.sfaa048,l_sfaa.sfaa049,
    l_sfaa.sfaa050,l_sfaa.sfaa051,l_sfaa.sfaa052,l_sfaa.sfaa053,l_sfaa.sfaa054,
    l_sfaa.sfaa055,l_sfaa.sfaa056,l_sfaa.sfaa057,l_sfaa.sfaa058,l_sfaa.sfaa059,
    l_sfaa.sfaa060,l_sfaa.sfaa061,l_sfaa.sfaa062,l_sfaa.sfaa063,l_sfaa.sfaa064,
    l_sfaa.sfaa065,l_sfaa.sfaa066,l_sfaa.sfaa067,l_sfaa.sfaa068,l_sfaa.sfaa069,
    l_sfaa.sfaa070,l_sfaa.sfaa071,l_sfaa.sfaa072,
    l_sfcb.sfcbent,l_sfcb.sfcbsite,l_sfcb.sfcbdocno,l_sfcb.sfcb001,l_sfcb.sfcb002,
    l_sfcb.sfcb003,l_sfcb.sfcb004,l_sfcb.sfcb005,l_sfcb.sfcb006,l_sfcb.sfcb007,
    l_sfcb.sfcb008,l_sfcb.sfcb009,l_sfcb.sfcb010,l_sfcb.sfcb011,l_sfcb.sfcb012,
    l_sfcb.sfcb013,l_sfcb.sfcb014,l_sfcb.sfcb015,l_sfcb.sfcb016,l_sfcb.sfcb017,
    l_sfcb.sfcb018,l_sfcb.sfcb019,l_sfcb.sfcb020,l_sfcb.sfcb021,l_sfcb.sfcb022,
    l_sfcb.sfcb023,l_sfcb.sfcb024,l_sfcb.sfcb025,l_sfcb.sfcb026,l_sfcb.sfcb027,
    l_sfcb.sfcb028,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
    l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
    l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb040,l_sfcb.sfcb041,l_sfcb.sfcb042,
    l_sfcb.sfcb043,l_sfcb.sfcb044,l_sfcb.sfcb045,l_sfcb.sfcb046,l_sfcb.sfcb047,
    l_sfcb.sfcb048,l_sfcb.sfcb049,l_sfcb.sfcb050,l_sfcb.sfcb051,l_sfcb.sfcb052,
    l_sfcb.sfcb053,l_sfcb.sfcb054,l_sfcb.sfcb055
   #161109-00085#41-e
   #end add-point

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      INITIALIZE g_detail_d[l_ac].* TO NULL
      LET g_detail_d[l_ac].sel          = 'N'
      LET g_detail_d[l_ac].b_sfcbdocno  = l_sfcb.sfcbdocno
      LET g_detail_d[l_ac].b_sfcb001    = l_sfcb.sfcb001
      LET g_detail_d[l_ac].b_sfcb002    = l_sfcb.sfcb002
      LET g_detail_d[l_ac].b_sfaa003    = l_sfaa.sfaa003
      LET g_detail_d[l_ac].b_sfaa002    = l_sfaa.sfaa002
      LET g_detail_d[l_ac].b_sfaa010    = l_sfaa.sfaa010
      LET g_detail_d[l_ac].b_sfcb003    = l_sfcb.sfcb003
      LET g_detail_d[l_ac].b_sfcb004    = l_sfcb.sfcb004
      LET g_detail_d[l_ac].b_sfcb020    = l_sfcb.sfcb020

      IF cl_null(l_sfcb.sfcb027) THEN LET l_sfcb.sfcb027 = 0 END IF
      IF cl_null(l_sfcb.sfcb029) THEN LET l_sfcb.sfcb029 = 0 END IF
      IF cl_null(l_sfcb.sfcb030) THEN LET l_sfcb.sfcb030 = 0 END IF
      IF cl_null(l_sfcb.sfcb031) THEN LET l_sfcb.sfcb031 = 0 END IF
      IF cl_null(l_sfcb.sfcb032) THEN LET l_sfcb.sfcb032 = 0 END IF
      IF cl_null(l_sfcb.sfcb033) THEN LET l_sfcb.sfcb033 = 0 END IF
      IF cl_null(l_sfcb.sfcb034) THEN LET l_sfcb.sfcb034 = 0 END IF
      IF cl_null(l_sfcb.sfcb035) THEN LET l_sfcb.sfcb035 = 0 END IF
      IF cl_null(l_sfcb.sfcb036) THEN LET l_sfcb.sfcb036 = 0 END IF
      IF cl_null(l_sfcb.sfcb037) THEN LET l_sfcb.sfcb037 = 0 END IF
      IF cl_null(l_sfcb.sfcb038) THEN LET l_sfcb.sfcb038 = 0 END IF
      IF cl_null(l_sfcb.sfcb039) THEN LET l_sfcb.sfcb039 = 0 END IF
      IF cl_null(l_sfcb.sfcb041) THEN LET l_sfcb.sfcb041 = 0 END IF
      IF cl_null(l_sfcb.sfcb042) THEN LET l_sfcb.sfcb042 = 0 END IF
      #170609-00027#1 add-------s--------
      #料件超交率
      SELECT imae020 INTO l_imae020 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site AND imae001=l_sfaa.sfaa010
      LET l_sfcb.sfcb027=l_sfcb.sfcb027*(1+l_imae020/100)
      #170609-00027#1 add--------e-------
      LET g_detail_d[l_ac].b_tot_qty    = l_sfcb.sfcb027 + l_sfcb.sfcb029 + l_sfcb.sfcb030 + l_sfcb.sfcb031 + l_sfcb.sfcb032
                                        - l_sfcb.sfcb033 - l_sfcb.sfcb034 - l_sfcb.sfcb035 - l_sfcb.sfcb036 - l_sfcb.sfcb037
#                                       - l_sfcb.sfcb038 - l_sfcb.sfcb039 - l_sfcb.sfcb041 + l_sfcb.sfcb042  #151118-00011#1 mark
                                        - l_sfcb.sfcb038 - l_sfcb.sfcb039 - l_sfcb.sfcb041                   #151118-00011#1 mod
      #170223-00052#1 add(s)
      SELECT sfca003 INTO l_sfca003 FROM sfca_t
       WHERE sfcaent = g_enterprise
         AND sfcadocno = l_sfcb.sfcbdocno
         AND sfca001 = l_sfcb.sfcb001
      IF NOT cl_null(l_sfca003) THEN
         #IF g_detail_d[l_ac].b_tot_qty > l_sfca003 THEN  #170609-00027#1 mark
         IF g_detail_d[l_ac].b_tot_qty > l_sfca003*(1+l_imae020/100) THEN  #170609-00027#1 add
            LET g_detail_d[l_ac].b_tot_qty = l_sfca003
         END IF
      END IF
      #170223-00052#1 add(e)
      LET g_detail_d[l_ac].b_carry_qty  = g_detail_d[l_ac].b_tot_qty
      LET g_detail_d[l_ac].b_sfcb013    = l_sfcb.sfcb013
      IF cl_null(g_detail_d[l_ac].b_sfcb013) THEN
         LET g_detail_d[l_ac].b_sfcb013 = l_sfaa.sfaa017
      END IF
      LET g_detail_d[l_ac].b_sfcb044    = l_sfcb.sfcb044
      LET g_detail_d[l_ac].b_sfcb045    = l_sfcb.sfcb045
      CALL asfp400_b_sfcb013_reference(l_ac)
      LET g_detail_d[l_ac].b_exrate     = asfp400_get_b_exrate(g_detail_d[l_ac].b_pmdl015)
      LET g_detail_d[l_ac].b_price      = 0

      #取各字段说明
      CALL asfp400_set_desc(l_ac)

      #整单委外时处理特征页签，工艺委外不处理
#      IF cl_null(l_sfcb.sfcb003) AND cl_null(l_sfcb.sfcb004) THEN  #160706-00023#1-mark
         CALL asfp400_ins_tmp_table(g_detail_d[l_ac].b_sfcbdocno,l_ac)
              RETURNING l_success
         IF NOT l_success THEN
            CONTINUE FOREACH
         END IF
#      END IF  #160706-00023#1-mark

      #end add-point

      CALL asfp400_detail_show()

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend =  ""
            LET g_errparam.code   =  9035
            LET g_errparam.popup  = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF

   END FOREACH
   LET g_error_show = 0

   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   #选项清空
   CALL g_pmal.clear()
   #end add-point

   LET g_detail_cnt = l_ac - 1
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0

   CLOSE b_fill_curs
   FREE asfp400_sel

   LET l_ac = 1
   CALL asfp400_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL asfp400_b2_fill()
   #end add-point

END FUNCTION

{</section>}

{<section id="asfp400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfp400_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"

   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"

   #end add-point

   LET li_ac = l_ac

   #add-point:單身填充後 name="fetch.after_fill"

   #end add-point

   LET l_ac = li_ac

END FUNCTION

{</section>}

{<section id="asfp400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfp400_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"

   #end add-point
   #add-point:show段define name="detail_show.define"

   #end add-point

   #add-point:detail_show段 name="detail_show.detail_show"

   #end add-point

END FUNCTION

{</section>}

{<section id="asfp400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfp400_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"

   #end add-point
   #add-point:filter段define name="filter.define"

   #end add-point

   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE

   END DISPLAY

   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"

   #end add-point

   LET INT_FLAG = 0

   LET g_qryparam.state = 'c'

   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc

   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

   CALL asfp400_b_fill()

END FUNCTION

{</section>}

{<section id="asfp400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfp400_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"

   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"

   #end add-point

   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF

   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF

   RETURN ls_var

END FUNCTION

{</section>}

{<section id="asfp400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfp400_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING

   LET ls_name = "formonly.", ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = asfp400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)

END FUNCTION

{</section>}

{<section id="asfp400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 定义取已委外数量的CURSOR
# Memo...........:
# Usage..........: CALL asfp400_def_cursor(p_type)
#                  RETURNING r_success
# Input parameter: p_type      '1' 按工单+RUN CARD+作业编号+作业序
#                :             '2' 按工单+RUN CARD+作业编号+作业序+特征
# Return code....: r_success   成功否标识符
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_def_cursor(p_type)
   DEFINE p_type         LIKE type_t.chr1
   DEFINE l_sql          STRING
   DEFINE r_success      LIKE type_t.num5

   LET r_success = FALSE


   LET l_sql = "SELECT pmdp022,SUM(pmdp023) FROM pmdp_t,pmdl_t",
               " WHERE pmdpent   = pmdlent AND pmdpent = ",g_enterprise,
               "   AND pmdpdocno = pmdldocno ",
               "   AND pmdp003   = ? ",                    #工单单号
               "   AND pmdp004   = ? "                     #RUN CARD
   #按特征
   IF p_type = '2' THEN
      LET l_sql = l_sql CLIPPED,"   AND pmdp008   = ? "    #特征
   END IF
   LET l_sql = l_sql CLIPPED,
               "   AND pmdp009   = ? ",                    #作业编号
               "   AND pmdp010   = ? ",                    #作业序
               "   AND pmdlstus <> 'X' ",
               " GROUP BY pmdp022 "
   PREPARE asfp400_def_cursor_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asfp400_def_cursor_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   DECLARE asfp400_cs1 CURSOR FOR asfp400_def_cursor_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp400_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

END FUNCTION

################################################################################
# Descriptions...: 各说明字段的FILL
# Memo...........:
# Usage..........: CALL asfp400_set_desc(p_i)
#                  RETURNING NULL
# Input parameter: p_i       当前行号
# Return code....: NULL
# Date & Author..: 2014-04-12 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_set_desc(p_i)
   DEFINE p_i            LIKE type_t.num10

   IF p_i <= 0 OR cl_null(p_i) THEN
      RETURN
   END IF

   #生管人员
   IF NOT cl_null(g_detail_d[p_i].b_sfaa002) THEN
      CALL s_desc_get_person_desc(g_detail_d[p_i].b_sfaa002)
           RETURNING g_detail_d[p_i].b_sfaa002_desc
   END IF

   #品名/规格
   IF NOT cl_null(g_detail_d[p_i].b_sfaa010) THEN
      CALL s_desc_get_item_desc(g_detail_d[p_i].b_sfaa010)
           RETURNING g_detail_d[p_i].b_sfaa010_desc1,g_detail_d[p_i].b_sfaa010_desc2
   END IF

   #作业编号
   IF NOT cl_null(g_detail_d[p_i].b_sfcb003) THEN
      CALL s_desc_get_acc_desc('221',g_detail_d[p_i].b_sfcb003)
           RETURNING g_detail_d[p_i].b_sfcb003_desc
   END IF

   #单位
   IF NOT cl_null(g_detail_d[p_i].b_sfcb020) THEN
      CALL s_desc_get_unit_desc(g_detail_d[p_i].b_sfcb020)
           RETURNING g_detail_d[p_i].b_sfcb020_desc
   END IF

   #厂商说明
   IF NOT cl_null(g_detail_d[p_i].b_sfcb013) THEN
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[p_i].b_sfcb013)
           RETURNING g_detail_d[p_i].b_sfcb013_desc
   END IF

   #取价说明
   IF NOT cl_null(g_detail_d[p_i].b_pmdl017) THEN
      CALL s_desc_get_price_type_desc(g_detail_d[p_i].b_pmdl017)
           RETURNING g_detail_d[p_i].b_pmdl017_desc
   END IF

   #币种
   IF NOT cl_null(g_detail_d[p_i].b_pmdl015) THEN
      CALL s_desc_get_currency_desc(g_detail_d[p_i].b_pmdl015)
           RETURNING g_detail_d[p_i].b_pmdl015_desc
   END IF

   #税种
   IF NOT cl_null(g_detail_d[p_i].b_pmdl011) THEN
      CALL s_desc_get_tax_desc1(g_site,g_detail_d[p_i].b_pmdl011)
           RETURNING g_detail_d[p_i].b_pmdl011_desc
   END IF


END FUNCTION

################################################################################
# Descriptions...: 厂商相关字段的DEFAULT
# Memo...........:
# Usage..........: CALL asfp400_b_sfcb013_reference(p_i)
#                  RETURNING NULL
# Input parameter: p_i       行号
# Return code....: NULL
# Date & Author..: 2014-04-12 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_b_sfcb013_reference(p_i)
   DEFINE p_i            LIKE type_t.num10
   #161109-00085#41-s
   #DEFINE l_pmal         RECORD LIKE pmal_t.*
   DEFINE l_pmal RECORD  #採購控制組供應商預設條件檔
       pmalent LIKE pmal_t.pmalent, #企業編號
       pmal001 LIKE pmal_t.pmal001, #交易對象編號
       pmal002 LIKE pmal_t.pmal002, #控制組編號
       pmal003 LIKE pmal_t.pmal003, #慣用交易幣別
       pmal004 LIKE pmal_t.pmal004, #慣用稅務規則
       pmal005 LIKE pmal_t.pmal005, #慣用發票開立方式
       pmal006 LIKE pmal_t.pmal006, #慣用付款條件
       pmal008 LIKE pmal_t.pmal008, #慣用採購通路
       pmal009 LIKE pmal_t.pmal009, #慣用採購分類
       pmal010 LIKE pmal_t.pmal010, #慣用報表語言
       pmal011 LIKE pmal_t.pmal011, #慣用交運方式
       pmal012 LIKE pmal_t.pmal012, #慣用交運起點
       pmal013 LIKE pmal_t.pmal013, #慣用交運終點
       pmal014 LIKE pmal_t.pmal014, #慣用卸貨港
       pmal015 LIKE pmal_t.pmal015, #慣用佣金率
       pmal016 LIKE pmal_t.pmal016, #折扣率
       pmal017 LIKE pmal_t.pmal017, #慣用ForWarder
       pmal018 LIKE pmal_t.pmal018, #慣用Notify
       pmal019 LIKE pmal_t.pmal019, #負責採購人員
       pmal020 LIKE pmal_t.pmal020, #慣用交易條件
       pmal021 LIKE pmal_t.pmal021, #慣用取價方式
       pmal022 LIKE pmal_t.pmal022, #慣用票類型
       pmal023 LIKE pmal_t.pmal023, #慣用內外購
       pmal024 LIKE pmal_t.pmal024, #慣用匯率計算基準
       pmalownid LIKE pmal_t.pmalownid, #資料所有者
       pmalowndp LIKE pmal_t.pmalowndp, #資料所屬部門
       pmalcrtid LIKE pmal_t.pmalcrtid, #資料建立者
       pmalcrtdp LIKE pmal_t.pmalcrtdp, #資料建立部門
       pmalcrtdt LIKE pmal_t.pmalcrtdt, #資料創建日
       pmalmodid LIKE pmal_t.pmalmodid, #資料修改者
       pmalmoddt LIKE pmal_t.pmalmoddt, #最近修改日
       pmalstus LIKE pmal_t.pmalstus, #狀態碼
       pmal025 LIKE pmal_t.pmal025  #負責採購部門
   END RECORD
   #161109-00085#41-e
   #161109-00085#41-s
   #DEFINE l_pmab         RECORD LIKE pmab_t.*
   DEFINE l_pmab RECORD  #交易對象據點檔
       pmabent LIKE pmab_t.pmabent, #企業編號
       pmabsite LIKE pmab_t.pmabsite, #營運據點
       pmab001 LIKE pmab_t.pmab001, #交易對象編號
       pmab002 LIKE pmab_t.pmab002, #信用額度查核
       pmab003 LIKE pmab_t.pmab003, #額度交易對象
       pmab004 LIKE pmab_t.pmab004, #信用評核等級
       pmab005 LIKE pmab_t.pmab005, #額度計算幣別
       pmab006 LIKE pmab_t.pmab006, #企業額度
       pmab007 LIKE pmab_t.pmab007, #可超出率
       pmab008 LIKE pmab_t.pmab008, #有效期限
       pmab009 LIKE pmab_t.pmab009, #逾期帳款寬限天數
       pmab010 LIKE pmab_t.pmab010, #允許除外額度
       pmab011 LIKE pmab_t.pmab011, #額度警示水準一
       pmab012 LIKE pmab_t.pmab012, #水準一通知層
       pmab013 LIKE pmab_t.pmab013, #額度警示水準二
       pmab014 LIKE pmab_t.pmab014, #水準二通知層
       pmab015 LIKE pmab_t.pmab015, #額度警示水準三
       pmab016 LIKE pmab_t.pmab016, #水準三通知層
       pmab017 LIKE pmab_t.pmab017, #啟動預期應收通知
       pmab018 LIKE pmab_t.pmab018, #預期應收通知層
       pmab030 LIKE pmab_t.pmab030, #供應商ABC分類
       pmab031 LIKE pmab_t.pmab031, #負責採購人員
       pmab032 LIKE pmab_t.pmab032, #供應商慣用報表語言
       pmab033 LIKE pmab_t.pmab033, #供應商慣用交易幣別
       pmab034 LIKE pmab_t.pmab034, #供應商慣用交易稅別
       pmab035 LIKE pmab_t.pmab035, #供應商慣用發票開立方式
       pmab036 LIKE pmab_t.pmab036, #供應商慣用立帳方式
       pmab037 LIKE pmab_t.pmab037, #供應商慣用付款條件
       pmab038 LIKE pmab_t.pmab038, #供應商慣用採購通路
       pmab039 LIKE pmab_t.pmab039, #供應商慣用採購分類
       pmab040 LIKE pmab_t.pmab040, #供應商慣用交運方式
       pmab041 LIKE pmab_t.pmab041, #供應商慣用交運起點
       pmab042 LIKE pmab_t.pmab042, #供應商慣用交運終點
       pmab043 LIKE pmab_t.pmab043, #供應商慣用卸貨港
       pmab044 LIKE pmab_t.pmab044, #供應商慣用其他條件
       pmab045 LIKE pmab_t.pmab045, #供應商慣用佣金率
       pmab046 LIKE pmab_t.pmab046, #供應商折扣率
       pmab047 LIKE pmab_t.pmab047, #供應商慣用Forwarder
       pmab048 LIKE pmab_t.pmab048, #供應商慣用 Notify
       pmab049 LIKE pmab_t.pmab049, #預設允許分批收貨
       pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
       pmab051 LIKE pmab_t.pmab051, #預設允許提前收貨
       pmab052 LIKE pmab_t.pmab052, #可提前收貨天數
       pmab053 LIKE pmab_t.pmab053, #慣用交易條件
       pmab054 LIKE pmab_t.pmab054, #慣用取價方式
       pmab055 LIKE pmab_t.pmab055, #應付帳款類別
       pmab056 LIKE pmab_t.pmab056, #供應商慣用發票類型
       pmab057 LIKE pmab_t.pmab057, #供應商慣用內外購
       pmab058 LIKE pmab_t.pmab058, #供應商慣用匯率計算基準
       pmab060 LIKE pmab_t.pmab060, #供應商評鑑計算分類
       pmab061 LIKE pmab_t.pmab061, #價格評分
       pmab062 LIKE pmab_t.pmab062, #達交率評分
       pmab063 LIKE pmab_t.pmab063, #品質評分
       pmab064 LIKE pmab_t.pmab064, #配合度評分
       pmab065 LIKE pmab_t.pmab065, #調整加減分
       pmab066 LIKE pmab_t.pmab066, #定性評分一
       pmab067 LIKE pmab_t.pmab067, #定性評分二
       pmab068 LIKE pmab_t.pmab068, #定性評分三
       pmab069 LIKE pmab_t.pmab069, #定性評分四
       pmab070 LIKE pmab_t.pmab070, #定性評分五
       pmab071 LIKE pmab_t.pmab071, #檢驗程度
       pmab072 LIKE pmab_t.pmab072, #檢驗水準
       pmab073 LIKE pmab_t.pmab073, #檢驗級數
       pmab080 LIKE pmab_t.pmab080, #客戶ABC分類
       pmab081 LIKE pmab_t.pmab081, #負責業務人員
       pmab082 LIKE pmab_t.pmab082, #客戶慣用報表語言
       pmab083 LIKE pmab_t.pmab083, #客戶慣用交易幣別
       pmab084 LIKE pmab_t.pmab084, #客戶慣用交易稅別
       pmab085 LIKE pmab_t.pmab085, #客戶慣用發票開立方式
       pmab086 LIKE pmab_t.pmab086, #客戶慣用立帳方式
       pmab087 LIKE pmab_t.pmab087, #客戶慣用收款條件
       pmab088 LIKE pmab_t.pmab088, #客戶慣用銷售通路
       pmab089 LIKE pmab_t.pmab089, #客戶慣用銷售分類
       pmab090 LIKE pmab_t.pmab090, #客戶慣用交運方式
       pmab091 LIKE pmab_t.pmab091, #客戶慣用交運起點
       pmab092 LIKE pmab_t.pmab092, #客戶慣用交運終點
       pmab093 LIKE pmab_t.pmab093, #客戶慣用卸貨港
       pmab094 LIKE pmab_t.pmab094, #客戶慣用其他條件
       pmab095 LIKE pmab_t.pmab095, #客戶慣用佣金率
       pmab096 LIKE pmab_t.pmab096, #客戶折扣率
       pmab097 LIKE pmab_t.pmab097, #客戶慣用Forwarder
       pmab098 LIKE pmab_t.pmab098, #客戶慣用 Notify
       pmab099 LIKE pmab_t.pmab099, #預設允許分批交貨
       pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
       pmab101 LIKE pmab_t.pmab101, #預設允許提前交貨
       pmab102 LIKE pmab_t.pmab102, #可提前交貨天數
       pmab103 LIKE pmab_t.pmab103, #慣用交易條件
       pmab104 LIKE pmab_t.pmab104, #慣用取價方式
       pmab105 LIKE pmab_t.pmab105, #應收帳款類別
       pmab106 LIKE pmab_t.pmab106, #客戶慣用發票類型
       pmab107 LIKE pmab_t.pmab107, #客戶慣用內外銷
       pmab108 LIKE pmab_t.pmab108, #客戶慣用匯率計算基準
       pmabownid LIKE pmab_t.pmabownid, #資料所有者
       pmabowndp LIKE pmab_t.pmabowndp, #資料所有部門
       pmabcrtid LIKE pmab_t.pmabcrtid, #資料建立者
       pmabcrtdp LIKE pmab_t.pmabcrtdp, #資料建立部門
       pmabcrtdt LIKE pmab_t.pmabcrtdt, #資料創建日
       pmabmodid LIKE pmab_t.pmabmodid, #資料修改者
       pmabmoddt LIKE pmab_t.pmabmoddt, #最近修改日
       pmabcnfid LIKE pmab_t.pmabcnfid, #資料確認者
       pmabcnfdt LIKE pmab_t.pmabcnfdt, #資料確認日
       pmabstus LIKE pmab_t.pmabstus, #狀態碼
       pmab059 LIKE pmab_t.pmab059, #負責採購部門
       pmab109 LIKE pmab_t.pmab109, #負責業務部門
       pmab110 LIKE pmab_t.pmab110, #供應商條碼包裝數量
       pmab111 LIKE pmab_t.pmab111, #客戶條碼包裝數量
       pmab019 LIKE pmab_t.pmab019, #逾期帳款寬限額度
       pmab020 LIKE pmab_t.pmab020, #除外額有效日期
       pmab112 LIKE pmab_t.pmab112  #是否使用EC
   END RECORD
   #161109-00085#41-e
   DEFINE l_pmal002      LIKE pmal_t.pmal002   #控制组
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5

   IF p_i <= 0 THEN
      RETURN
   END IF

   IF cl_null(g_detail_d[p_i].b_sfcb013) THEN
      RETURN
   END IF
   #相同的供应商时,仅提供一次取pmal002的机会,否则可能同一个供应商,有几十笔资料时,跳几十次选择的情形
   LET l_pmal002 = ''
   FOR l_i = 1 TO g_pmal.getLength()
       IF g_pmal[l_i].b_sfcb013 = g_detail_d[p_i].b_sfcb013 AND NOT cl_null(g_pmal[l_i].pmal002) THEN
          LET l_pmal002 = g_pmal[l_i].pmal002
          EXIT FOR
       END IF
   END FOR

   IF cl_null(l_pmal002) THEN
      CALL s_control_get_pmal002('4',g_user,g_dept,g_detail_d[p_i].b_sfcb013)
           RETURNING l_success,l_pmal002
      IF NOT l_success THEN
         LET l_pmal002 = NULL
      END IF
      IF NOT cl_null(l_pmal002) THEN
         CALL g_pmal.insertElement(1)
         LET g_pmal[1].b_sfcb013 = g_detail_d[p_i].b_sfcb013
         LET g_pmal[1].pmal002 = l_pmal002
      END IF
   END IF

   #取供应商的控制组预设条件
   #161109-00085#41-s
   #SELECT * INTO l_pmal.* FROM pmal_t
   SELECT pmalent,pmal001,pmal002,pmal003,pmal004,
          pmal005,pmal006,pmal008,pmal009,pmal010,
          pmal011,pmal012,pmal013,pmal014,pmal015,
          pmal016,pmal017,pmal018,pmal019,pmal020,
          pmal021,pmal022,pmal023,pmal024,pmalownid,
          pmalowndp,pmalcrtid,pmalcrtdp,pmalcrtdt,pmalmodid,
          pmalmoddt,pmalstus,pmal025
    INTO l_pmal.pmalent,l_pmal.pmal001,l_pmal.pmal002,l_pmal.pmal003,l_pmal.pmal004,
         l_pmal.pmal005,l_pmal.pmal006,l_pmal.pmal008,l_pmal.pmal009,l_pmal.pmal010,
         l_pmal.pmal011,l_pmal.pmal012,l_pmal.pmal013,l_pmal.pmal014,l_pmal.pmal015,
         l_pmal.pmal016,l_pmal.pmal017,l_pmal.pmal018,l_pmal.pmal019,l_pmal.pmal020,
         l_pmal.pmal021,l_pmal.pmal022,l_pmal.pmal023,l_pmal.pmal024,l_pmal.pmalownid,
         l_pmal.pmalowndp,l_pmal.pmalcrtid,l_pmal.pmalcrtdp,l_pmal.pmalcrtdt,l_pmal.pmalmodid,
         l_pmal.pmalmoddt,l_pmal.pmalstus,l_pmal.pmal025
    FROM pmal_t
   #161109-00085#41-e
    WHERE pmalent = g_enterprise
      AND pmal001 = g_detail_d[p_i].b_sfcb013
      AND pmal002 = l_pmal002
   #161109-00085#41-s
   #SELECT * INTO l_pmab.* FROM pmab_t
   SELECT pmabent,pmabsite,pmab001,pmab002,pmab003,
          pmab004,pmab005,pmab006,pmab007,pmab008,
          pmab009,pmab010,pmab011,pmab012,pmab013,
          pmab014,pmab015,pmab016,pmab017,pmab018,
          pmab030,pmab031,pmab032,pmab033,pmab034,
          pmab035,pmab036,pmab037,pmab038,pmab039,
          pmab040,pmab041,pmab042,pmab043,pmab044,
          pmab045,pmab046,pmab047,pmab048,pmab049,
          pmab050,pmab051,pmab052,pmab053,pmab054,
          pmab055,pmab056,pmab057,pmab058,pmab060,
          pmab061,pmab062,pmab063,pmab064,pmab065,
          pmab066,pmab067,pmab068,pmab069,pmab070,
          pmab071,pmab072,pmab073,pmab080,pmab081,
          pmab082,pmab083,pmab084,pmab085,pmab086,
          pmab087,pmab088,pmab089,pmab090,pmab091,
          pmab092,pmab093,pmab094,pmab095,pmab096,
          pmab097,pmab098,pmab099,pmab100,pmab101,
          pmab102,pmab103,pmab104,pmab105,pmab106,
          pmab107,pmab108,pmabownid,pmabowndp,pmabcrtid,
          pmabcrtdp,pmabcrtdt,pmabmodid,pmabmoddt,pmabcnfid,
          pmabcnfdt,pmabstus,pmab059,pmab109,pmab110,
          pmab111,pmab019,pmab020,pmab112
     INTO l_pmab.pmabent,l_pmab.pmabsite,l_pmab.pmab001,l_pmab.pmab002,l_pmab.pmab003,
          l_pmab.pmab004,l_pmab.pmab005,l_pmab.pmab006,l_pmab.pmab007,l_pmab.pmab008,
          l_pmab.pmab009,l_pmab.pmab010,l_pmab.pmab011,l_pmab.pmab012,l_pmab.pmab013,
          l_pmab.pmab014,l_pmab.pmab015,l_pmab.pmab016,l_pmab.pmab017,l_pmab.pmab018,
          l_pmab.pmab030,l_pmab.pmab031,l_pmab.pmab032,l_pmab.pmab033,l_pmab.pmab034,
          l_pmab.pmab035,l_pmab.pmab036,l_pmab.pmab037,l_pmab.pmab038,l_pmab.pmab039,
          l_pmab.pmab040,l_pmab.pmab041,l_pmab.pmab042,l_pmab.pmab043,l_pmab.pmab044,
          l_pmab.pmab045,l_pmab.pmab046,l_pmab.pmab047,l_pmab.pmab048,l_pmab.pmab049,
          l_pmab.pmab050,l_pmab.pmab051,l_pmab.pmab052,l_pmab.pmab053,l_pmab.pmab054,
          l_pmab.pmab055,l_pmab.pmab056,l_pmab.pmab057,l_pmab.pmab058,l_pmab.pmab060,
          l_pmab.pmab061,l_pmab.pmab062,l_pmab.pmab063,l_pmab.pmab064,l_pmab.pmab065,
          l_pmab.pmab066,l_pmab.pmab067,l_pmab.pmab068,l_pmab.pmab069,l_pmab.pmab070,
          l_pmab.pmab071,l_pmab.pmab072,l_pmab.pmab073,l_pmab.pmab080,l_pmab.pmab081,
          l_pmab.pmab082,l_pmab.pmab083,l_pmab.pmab084,l_pmab.pmab085,l_pmab.pmab086,
          l_pmab.pmab087,l_pmab.pmab088,l_pmab.pmab089,l_pmab.pmab090,l_pmab.pmab091,
          l_pmab.pmab092,l_pmab.pmab093,l_pmab.pmab094,l_pmab.pmab095,l_pmab.pmab096,
          l_pmab.pmab097,l_pmab.pmab098,l_pmab.pmab099,l_pmab.pmab100,l_pmab.pmab101,
          l_pmab.pmab102,l_pmab.pmab103,l_pmab.pmab104,l_pmab.pmab105,l_pmab.pmab106,
          l_pmab.pmab107,l_pmab.pmab108,l_pmab.pmabownid,l_pmab.pmabowndp,l_pmab.pmabcrtid,
          l_pmab.pmabcrtdp,l_pmab.pmabcrtdt,l_pmab.pmabmodid,l_pmab.pmabmoddt,l_pmab.pmabcnfid,
          l_pmab.pmabcnfdt,l_pmab.pmabstus,l_pmab.pmab059,l_pmab.pmab109,l_pmab.pmab110,
          l_pmab.pmab111,l_pmab.pmab019,l_pmab.pmab020,l_pmab.pmab112
     FROM pmab_t
   #161109-00085#41-e
    WHERE pmabent  = g_enterprise
      AND pmabsite = g_site
      AND pmab001  = g_detail_d[p_i].b_sfcb013

   #取价方式
   LET g_detail_d[p_i].b_pmdl017 = l_pmal.pmal021
   IF cl_null(g_detail_d[p_i].b_pmdl017) THEN
      LET g_detail_d[p_i].b_pmdl017 = l_pmab.pmab054
   END IF
   CALL s_desc_get_price_type_desc(g_detail_d[p_i].b_pmdl017)
        RETURNING g_detail_d[p_i].b_pmdl017_desc

   #币种
   LET g_detail_d[p_i].b_pmdl015 = l_pmal.pmal003
   IF cl_null(g_detail_d[p_i].b_pmdl015) THEN
      LET g_detail_d[p_i].b_pmdl015 = l_pmab.pmab033
   END IF
   CALL s_desc_get_currency_desc(g_detail_d[p_i].b_pmdl015)
        RETURNING g_detail_d[p_i].b_pmdl015_desc

   #税别
   LET g_detail_d[p_i].b_pmdl011 = l_pmal.pmal004
   IF cl_null(g_detail_d[p_i].b_pmdl011) THEN
      LET g_detail_d[p_i].b_pmdl011 = l_pmab.pmab034
   END IF
   CALL s_desc_get_tax_desc1(g_site,g_detail_d[p_i].b_pmdl011)
        RETURNING g_detail_d[p_i].b_pmdl011_desc


END FUNCTION

################################################################################
# Descriptions...: 取汇率
# Memo...........:
# Usage..........: CALL asfp400_get_b_exrate(p_b_pmdl015)
#                  RETURNING r_b_exrate
# Input parameter: p_b_pmdl015    币种
# Return code....: r_b_exrate     汇率
# Date & Author..: 2014-04-13 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_get_b_exrate(p_b_pmdl015)
   DEFINE p_b_pmdl015        LIKE pmdl_t.pmdl015
   DEFINE r_b_exrate         LIKE ooan_t.ooan005
   DEFINE l_date             LIKE type_t.dat
   DEFINE l_ooef016          LIKE ooef_t.ooef016
   DEFINE l_acc40            LIKE type_t.chr80
   DEFINE l_pmal002          LIKE pmal_t.pmal002   #20151029 by stellar add
   DEFINE l_pmal023          LIKE pmal_t.pmal023   #20151029 by stellar add
   DEFINE l_success          LIKE type_t.num5      #20151029 by stellar add

   LET r_b_exrate = 1
   IF cl_null(p_b_pmdl015) THEN
      RETURN r_b_exrate
   END IF

   LET l_date = cl_get_today()
   SELECT ooef016 INTO l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #20151029 by stellar modify ----- (S)
#   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0010') RETURNING l_acc40

   #按g_user/g_dept/供應商值選出可預設的控制組代號
   CALL s_control_get_pmal002('4',g_user,g_dept,g_detail_d[l_ac].b_sfcb013)
        RETURNING l_success,l_pmal002
   IF NOT l_success THEN
      LET l_pmal002 = NULL
   END IF

   #取供應商的內外購
   SELECT pmal023 INTO l_pmal023 FROM pmal_t
    WHERE pmalent = g_enterprise
      AND pmal001 = g_detail_d[l_ac].b_sfcb013
      AND pmal002 = l_pmal002
   IF cl_null(l_pmal023) THEN
      #取供應商主檔的內外購
      SELECT pmab057 INTO l_pmal023 FROM pmab_t
       WHERE pmabent  = g_enterprise
         AND pmabsite = g_site
         AND pmab001  = g_detail_d[l_ac].b_sfcb013
   END IF

   IF cl_null(l_pmal023) THEN
      LET l_pmal023 = '1'
   END IF

   IF l_pmal023 = '1' THEN
      LET l_acc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
   ELSE
      LET l_acc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0015')
   END IF
   #20151029 by stellar modify ----- (E)

   CALL s_aooi160_get_exrate('1',g_site,l_date,p_b_pmdl015,l_ooef016,0,l_acc40)
        RETURNING r_b_exrate

   RETURN r_b_exrate

END FUNCTION

################################################################################
# Descriptions...: 特征-本次委外数量检查
# Memo...........:
# Usage..........: CALL asfp400_chk_b_qty3(p_i)
#                       RETURNING r_success
# Input parameter: p_i            行号
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-18 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_chk_b_qty3(p_i)
   DEFINE p_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5

   IF p_i <= 0 THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

   LET r_success = FALSE

   IF cl_null(g_sfac_d[p_i].b_qty3) THEN
      #本次委外数量不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00224'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   IF g_sfac_d[p_i].b_qty3 < 0 THEN
      #数量不可小于等于0
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00016'
      LET g_errparam.extend = g_sfac_d[p_i].b_qty3
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF


   IF g_sfac_d[p_i].b_qty3 > g_sfac_d[p_i].b_qty2 THEN
      #最大可委外数量为 %1，本次委外数量不可超过此数值
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00220'
      LET g_errparam.extend = g_sfac_d[p_i].b_qty3
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_sfac_d[p_i].b_qty2
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查工单页签的本次委外数量和特征页签的本次委外数量合计量是否相等
# Memo...........:
# Usage..........: CALL asfp400_chk_tot_qty(p_i)
#                       RETURNING r_success
# Input parameter: p_i            行号
# Return code....: r_success      相等否标识符
# Date & Author..: 2014-04-18 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_chk_tot_qty(p_i)
   DEFINE p_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_tot_qty      LIKE sfac_t.sfac003
   DEFINE l_cnt          LIKE type_t.num10

   LET r_success = FALSE
   #170703-00026#1-s
   IF p_i = 0 THEN
      LET r_success = TRUE
      RETURN r_success
   END IF
   #170703-00026#1-e
   #检查工单是否有特征值,若没有时,则不需要检查
   SELECT COUNT(*) INTO l_cnt FROM asfp400_tmp01  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
    WHERE sfacdocno = g_detail_d[p_i].b_sfcbdocno
      AND sfcb001   = g_detail_d[p_i].b_sfcb001   #170508-00084#1 add
      AND sfcb002   = g_detail_d[p_i].b_sfcb002   #170508-00084#1 add
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      LET r_success = TRUE
      RETURN r_success
   END IF

   SELECT SUM(qty3) INTO l_tot_qty FROM asfp400_tmp01  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
    WHERE sfacdocno = g_detail_d[p_i].b_sfcbdocno
      AND sfcb001   = g_detail_d[p_i].b_sfcb001   #170508-00084#1 add
      AND sfcb002   = g_detail_d[p_i].b_sfcb002   #170508-00084#1 add
   IF cl_null(l_tot_qty) THEN LET l_tot_qty = 0 END IF
   IF l_tot_qty <> g_detail_d[p_i].b_carry_qty THEN
      #工单各特征的本次委外数量合计 %1 不等于工单的本次委外数量 %2 !
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00239'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_tot_qty
      LET g_errparam.replace[2] =  g_detail_d[p_i].b_carry_qty
      LET g_errparam.replace[3] =  g_detail_d[p_i].b_sfcbdocno  #170322-00074#1 add
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 从采购单取已经委外的数量-BY特征
# Memo...........:
# Usage..........: CALL asfp400_get_qty1(p_pmdp003,p_pmdp004,p_pmdp007,p_pmdp008,pmdp009,p_pmdp010,p_sfcb020)
#                       RETURNING r_qty1
# Input parameter: p_pmdp003      工单单号
#                : p_pmdp004      RUN CARD
#                : p_pmdp007      料号
#                : p_pmdp008      特征
#                : p_pmdp009      作业编号
#                : p_pmdp010      作业序
#                : p_sfcb020      制程站的转出单位
# Return code....: r_qty1         已委外数量
# Date & Author..: 2014-04-17 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_get_qty1(p_pmdp003,p_pmdp004,p_pmdp007,p_pmdp008,p_pmdp009,p_pmdp010,p_sfcb020)
   DEFINE p_pmdp003      LIKE pmdp_t.pmdp003
   DEFINE p_pmdp004      LIKE pmdp_t.pmdp004
   DEFINE p_pmdp007      LIKE pmdp_t.pmdp007
   DEFINE p_pmdp008      LIKE pmdp_t.pmdp008
   DEFINE p_pmdp009      LIKE pmdp_t.pmdp009
   DEFINE p_pmdp010      LIKE pmdp_t.pmdp010
   DEFINE p_sfcb020      LIKE sfcb_t.sfcb020
   DEFINE r_qty          LIKE pmdp_t.pmdp023
   DEFINE l_unit         LIKE pmdp_t.pmdp022
   DEFINE l_qty          LIKE pmdp_t.pmdp023
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   DEFINE l_tot          LIKE pmdp_t.pmdp023
   DEFINE l_qty1         LIKE pmdp_t.pmdp023

   LET r_qty = 0
   LET l_tot = 0

   FOREACH asfp400_cs1 USING p_pmdp003,p_pmdp004,p_pmdp008,p_pmdp009,p_pmdp010
                       INTO l_unit,l_qty
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asfp400_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_qty
      END IF

      LET l_qty1 = l_qty

      LET l_rate = 1
      IF l_unit <> p_sfcb020 THEN
#         CALL s_aimi190_get_convert(p_pmdp007,l_unit,p_sfcb020)
#              RETURNING l_success,l_rate
#         IF NOT l_success THEN
#            RETURN r_qty
#         END IF
         CALL s_aooi250_convert_qty(p_pmdp007,l_unit,p_sfcb020,l_qty)
              RETURNING l_success,l_qty1
         IF NOT l_success THEN
            RETURN r_qty
         END IF
      END IF

      LET l_tot = l_tot + l_qty1
   END FOREACH

   LET r_qty = l_tot
   RETURN r_qty
END FUNCTION

################################################################################
# Descriptions...: 抛转采购单前的整体检查
# Memo...........:
# Usage..........: CALL asfp400_chk_before_carry()
#                  RETURNING r_success
# Input parameter: NULL
# Return code....: r_success   检查通过否
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_chk_before_carry()
   DEFINE l_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.chr1

   LET r_success = TRUE
   LET l_flag = 'N'

   FOR l_i = 1 TO g_detail_cnt
       IF g_detail_d[l_i].sel = 'N' THEN
          CONTINUE FOR
       END IF

       #本次委外数
       CALL s_asfp400_chk_carry_qty(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_sfcb001,
                                    g_detail_d[l_i].b_sfcb002,g_detail_d[l_i].b_carry_qty)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #工单的委外数与特征委外合计数是否相等
       CALL asfp400_chk_tot_qty(l_i)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #委外厂商
       CALL s_asfp400_chk_sfcb013(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_sfcb013,NULL)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #预计交期
       CALL s_asfp400_chk_sfcb045(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_sfcb044,g_detail_d[l_i].b_sfcb045,NULL)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #取价方式
       CALL s_asfp400_chk_pmdl017(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_pmdl017)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #币种
       CALL s_asfp400_chk_pmdl015(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_pmdl015)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF

       #税种
       CALL s_asfp400_chk_pmdl011(g_detail_d[l_i].b_sfcbdocno,g_detail_d[l_i].b_pmdl011)
            RETURNING l_success
       IF NOT l_success THEN
          LET r_success = FALSE
       END IF
       LET l_flag = 'Y'
   END FOR

   IF l_flag = 'N' THEN
      #无资料处理!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 特征单身fill
# Memo...........:
# Usage..........: CALL asfp400_b2_fill()
#                  RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_b2_fill()
   DEFINE l_i            LIKE type_t.num5

   CALL g_sfac_d.clear()

   IF l_ac <=0 THEN
      RETURN
   END IF

   LET g_sql = " SELECT sfac006, sfac003, qty1, qty2, qty3 ",
               "   FROM asfp400_tmp01 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
               "  WHERE sfacdocno = '",g_detail_d[l_ac].b_sfcbdocno,"'",
               "    AND sfcb001   =  ",g_detail_d[l_ac].b_sfcb001,   #170508-00084#1 add
               "    AND sfcb002   =  ",g_detail_d[l_ac].b_sfcb002,   #170508-00084#1 add
               "  ORDER BY sfac006 "

   PREPARE asfp400_b2_fill_p1 FROM g_sql
   DECLARE asfp400_b2_fill_cs1 CURSOR FOR asfp400_b2_fill_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp400_b2_fill_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF

   LET l_i = 1
   FOREACH asfp400_b2_fill_cs1 INTO g_sfac_d[l_i].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_i = l_i + 1

   END FOREACH
   LET g_rec_b2 = l_i - 1
   CALL g_sfac_d.deleteElement(l_i)
END FUNCTION

################################################################################
# Descriptions...: 插入特征临时表
# Memo...........:
# Usage..........: CALL asfp400_ins_tmp_table(p_sfacdocno,p_i)
#                       RETURNING r_success
# Input parameter: p_sfacdocno    工单单号
#                : p_i            行号
# Return code....: r_success      插入成功否标识符
# Date & Author..: 2014-04-18 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_ins_tmp_table(p_sfacdocno,p_i)
   DEFINE p_sfacdocno    LIKE sfac_t.sfacdocno
   DEFINE p_i            LIKE type_t.num10
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_sfaa013      LIKE sfaa_t.sfaa013
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   DEFINE l_sfac         RECORD
                         sfacdocno      LIKE sfac_t.sfacdocno,
                         sfac006        LIKE sfac_t.sfac006,
                         sfac003        LIKE sfac_t.sfac003,
                         qty1           LIKE sfaa_t.sfaa012,
                         qty2           LIKE sfaa_t.sfaa012,
                         qty3           LIKE sfaa_t.sfaa012
                         END RECORD
   DEFINE l_qty          LIKE sfac_t.sfac003

   LET r_success = FALSE

   LET g_sql = " SELECT sfacdocno, sfac006, sfac003, 0, 0, 0, sfaa013     ",
               "   FROM sfac_t,sfaa_t ",
               "  WHERE sfacent   = sfaaent   AND sfacent   =  ",g_enterprise,
               "    AND sfacdocno = sfaadocno AND sfacdocno = '",p_sfacdocno,"'",
               "    AND sfac002 IN ('1','2') ",         #一般/联产品
               "    AND sfac006 IS NOT NULL AND sfac006 <> ' ' ",
               "    AND sfac003 > 0 ",
               "  ORDER BY sfac006 "

   PREPARE asfp400_ins_tmp_tab1_p1 FROM g_sql
   DECLARE asfp400_ins_tmp_tab1_cs1 CURSOR FOR asfp400_ins_tmp_tab1_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asfp400_ins_tmp_tab1_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

      #161109-00085#41-s
      #FOREACH asfp400_ins_tmp_tab1_cs1 INTO l_sfac.*,l_sfaa013
      FOREACH asfp400_ins_tmp_tab1_cs1
         INTO l_sfac.sfacdocno,l_sfac.sfac006,l_sfac.sfac003,l_sfac.qty1,l_sfac.qty2,l_sfac.qty3,l_sfaa013
      #161109-00085#41-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_qty = l_sfac.sfac003
      #生产数量
      LET l_rate = 1
      IF l_sfaa013 <> g_detail_d[p_i].b_sfcb020 THEN
#         CALL s_aimi190_get_convert(g_detail_d[p_i].b_sfaa010,l_sfaa013,g_detail_d[p_i].b_sfcb020)
#              RETURNING l_success,l_rate
#         IF NOT l_success THEN
#            EXIT FOREACH
#         END IF
         CALL s_aooi250_convert_qty(g_detail_d[p_i].b_sfaa010,l_sfaa013,g_detail_d[p_i].b_sfcb020,l_sfac.sfac003)
              RETURNING l_success,l_qty
         IF NOT l_success THEN
            EXIT FOREACH
         END IF
      END IF
#      LET l_sfac.sfac003 = l_sfac.sfac003 * l_rate
      LET l_sfac.sfac003 = l_qty

      #已委外数量
      CALL asfp400_get_qty1(p_sfacdocno,g_detail_d[p_i].b_sfcb001,
                            g_detail_d[p_i].b_sfaa010,l_sfac.sfac006,
                            g_detail_d[p_i].b_sfcb003,g_detail_d[p_i].b_sfcb004,
                            g_detail_d[p_i].b_sfcb020)
           RETURNING l_sfac.qty1

      #可委外数量
      LET l_sfac.qty2 = l_sfac.sfac003 - l_sfac.qty1

      #本次转委外数量
      LET l_sfac.qty3 = l_sfac.qty2

      #161109-00085#41-s
      #INSERT INTO asfp400_tmp01 VALUES(l_sfac.*)  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
      INSERT INTO asfp400_tmp01 (sfacdocno,sfcb001,sfcb002,sfac006,sfac003,qty1,qty2,qty3)    #170508-00084#1 add  sfcb001,sfcb002
      VALUES(l_sfac.sfacdocno,g_detail_d[p_i].b_sfcb001,g_detail_d[p_i].b_sfcb002,l_sfac.sfac006,l_sfac.sfac003,l_sfac.qty1,l_sfac.qty2,l_sfac.qty3)  #170508-00084#1 add  sfcb001,sfcb002
      #161109-00085#41-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert asfp400_tmp01'  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF

   END FOREACH

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 特征页签使用的临时表
# Memo...........:
# Usage..........: CALL asfp400_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: NULL
# Return code....: r_success  临时表建立成功否的标识符
# Date & Author..: 2014-04-18 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_cre_tmp_table()
   DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF

   DROP TABLE asfp400_tmp01;  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
   CREATE TEMP TABLE asfp400_tmp01(  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
   sfacdocno      LIKE sfac_t.sfacdocno,
   sfcb001        LIKE sfcb_t.sfcb001,    #170508-00084#1 add
   sfcb002        LIKE sfcb_t.sfcb002,    #170508-00084#1 add
   sfac006        LIKE sfac_t.sfac006,
   sfac003        LIKE sfac_t.sfac003,
   qty1           LIKE sfac_t.sfac003,
   qty2           LIKE sfac_t.sfac003,
   qty3           LIKE sfac_t.sfac003
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asfp400_drop_tmp_table()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-04-18 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_drop_tmp_table()
   WHENEVER ERROR CONTINUE

   DROP TABLE asfp400_tmp01;  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
END FUNCTION

################################################################################
# Descriptions...: 抛转采购单
# Memo...........:
# Usage..........: CALL asfp400_carry_po()
#                       RETURNING r_success
# Input parameter: NULL
# Return code....: r_success    成功否标识符
# Date & Author..: 2014-04-29 By Carrier
# Modify.........:
################################################################################
PRIVATE FUNCTION asfp400_carry_po()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_doc_type       LIKE ooba_t.ooba002
   DEFINE l_date           LIKE type_t.dat
   DEFINE l_combine        LIKE type_t.chr1
   DEFINE l_begin_no       LIKE pmdl_t.pmdldocno
   DEFINE l_end_no         LIKE pmdl_t.pmdldocno
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_i              LIKE type_t.num10
   DEFINE l_j              LIKE type_t.num10
   DEFINE l_k              LIKE type_t.num10
   DEFINE l_choice         LIKE type_t.num5
   DEFINE la_param         RECORD
                           prog   STRING,
                           param  DYNAMIC ARRAY OF STRING
                           END RECORD
   DEFINE ls_js            STRING

   LET r_success = FALSE

   CALL cl_err_collect_init()

   CALL asfp400_chk_before_carry()
        RETURNING l_success
   IF NOT l_success THEN
      CALL cl_err_collect_show()
      RETURN r_success
   END IF


   CALL asfp400_01(g_detail_d)
        RETURNING l_success,l_doc_type,l_date,l_combine
   IF NOT l_success THEN
      RETURN r_success
   END IF
   LET g_sql = "SELECT sfacdocno,sfac006,qty3 FROM asfp400_tmp01 ",  #160727-00019#18   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 asfp400_tmp_tab1 ——> asfp400_tmp01
               " WHERE sfacdocno = ?   ",
               "   AND sfcb001 = ? ",   #170508-00084#1 add
               "   AND sfcb002 = ? ",   #170508-00084#1 add
               "   AND qty3 > 0 ",
               " ORDER BY sfac006 "
   PREPARE asfp400_arr2_p1 FROM g_sql
   DECLARE asfp400_arr2_cs1 CURSOR FOR asfp400_arr2_p1

   CALL g_arr1.clear()
   CALL g_arr2.clear()
   LET l_j = 1
   LET l_k = 1
   FOR l_i = 1 TO g_detail_d.getLength()
       IF g_detail_d[l_i].sel = 'Y' THEN
          LET g_arr1[l_j].sfcbdocno = g_detail_d[l_i].b_sfcbdocno
          LET g_arr1[l_j].sfaa010   = g_detail_d[l_i].b_sfaa010
          LET g_arr1[l_j].sfcb001   = g_detail_d[l_i].b_sfcb001
          LET g_arr1[l_j].sfcb002   = g_detail_d[l_i].b_sfcb002
          LET g_arr1[l_j].sfcb003   = g_detail_d[l_i].b_sfcb003
          LET g_arr1[l_j].sfcb004   = g_detail_d[l_i].b_sfcb004
          LET g_arr1[l_j].sfcb020   = g_detail_d[l_i].b_sfcb020
          LET g_arr1[l_j].carry_qty = g_detail_d[l_i].b_carry_qty
          LET g_arr1[l_j].sfcb013   = g_detail_d[l_i].b_sfcb013
          LET g_arr1[l_j].sfcb044   = g_detail_d[l_i].b_sfcb044
          LET g_arr1[l_j].sfcb045   = g_detail_d[l_i].b_sfcb045
          LET g_arr1[l_j].pmdl017   = g_detail_d[l_i].b_pmdl017
          LET g_arr1[l_j].pmdl015   = g_detail_d[l_i].b_pmdl015
          LET g_arr1[l_j].exrate    = g_detail_d[l_i].b_exrate
          LET g_arr1[l_j].pmdl011   = g_detail_d[l_i].b_pmdl011
          LET g_arr1[l_j].price     = g_detail_d[l_i].b_price


          FOREACH asfp400_arr2_cs1 USING g_arr1[l_j].sfcbdocno,g_arr1[l_j].sfcb001,g_arr1[l_j].sfcb002 #170508-00084#1 add sfcb001,sfcb002
                                   INTO g_arr2[l_k].*
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'foreach asfp400_arr2_cs1'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()

              END IF
              LET l_k = l_k + 1
          END FOREACH

          LET l_j = l_j + 1
       END IF
   END FOR

   CALL s_asfp400_cre_tmp_table(l_doc_type,l_date,g_arr1,g_arr2)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   CALL s_transaction_begin()
   CALL s_asfp400_carry_po(l_doc_type,l_date,l_combine,g_arr1,g_arr2)
        RETURNING l_success,l_begin_no,l_end_no
   IF l_success THEN
      CALL s_transaction_end('Y',0)
      #成功产生单据，单据范围：%1 ~ %2
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_begin_no
      LET g_errparam.replace[2] = l_end_no
      CALL cl_err()

   ELSE
      CALL s_transaction_end('N',1)
   END IF

   CALL s_asfp400_drop_tmp_table()

   IF l_success AND NOT cl_null(l_begin_no) THEN
      #是否要运行apmt501查看生成的采购单信息[Y/N]?
      LET l_choice = cl_ask_promp('asf-00261')
      IF l_choice = TRUE THEN
          LET la_param.prog     = "apmt501"
          #LET la_param.param[1] = l_begin_no
          #LET la_param.param[1] = '1'
          LET la_param.param[1] = ''
          #170221-00009#1-s-mod
#          LET la_param.param[2] = " AND pmdldocno BETWEEN '",l_begin_no,"' AND '",l_end_no,"'"
          LET la_param.param[2] = " pmdldocno BETWEEN '",l_begin_no,"' AND '",l_end_no,"'"
          #170221-00009#1-e-mod
          LET ls_js = util.JSON.stringify( la_param )
          CALL cl_cmdrun(ls_js)
      END IF
   END IF

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

#end add-point

{</section>}

