{<section id="aglq770.description" >}
#+ Version..: T100-ERP-1.00.00(版次:1) Build-000058
#+ 
#+ Filename...: aglq770
#+ Description: 明細分類帳(核算項)查詢作業
#+ Creator....: 02599(2014/03/27)
#+ Modifier...: 02599(2014/03/29)
#+ Buildtype..: 應用 q02 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="aglq770.global" >}
#150908            2015/09/08   By 03538   carol:修改為即便所勾選的核算項無值,顯示為空白,而非不可查詢到
#151231-00004#1    2015/12/31   By 02599   期初金额算法错误，改成当破期时抓取年期金额 + 抓取起始年期第一天到起始日期前一天的凭证金额
#151204-00013#7    2016/01/12   By 02599   当未勾选‘含月结凭证’是，要排除CE凭证中科目属性为6.损益类科目和XC凭证中科目属性为5.成本类科目
#160302-00006#1    2016/03/02   By 07675   原本单身为可查询作业，增加二次筛选功能   
#160503-00025#2    2016/05/05   By 02114   查詢效能優化
#160503-00037#7    2016/05/09   By 07900   本年累计数不应含期初第0期的数据
#160511-00006#4    2016/05/11   By 02599   期初只显示余额，借方金额、贷方金额不显示；本年累计的余额=本年累计+年初余额
 
IMPORT os
IMPORT util
#add-point:增加匯入項目
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_glaq_d RECORD
       #statepic       LIKE type_t.chr1,
       sel            LIKE type_t.chr1,
       glaq002 LIKE glaq_t.glaq002, 
   glaq002_desc LIKE type_t.chr500, 
   glaq017 LIKE glaq_t.glaq017, 
   glaq017_desc LIKE type_t.chr500, 
   glaq018 LIKE glaq_t.glaq018, 
   glaq018_desc LIKE type_t.chr500, 
   glaq019 LIKE glaq_t.glaq019, 
   glaq019_desc LIKE type_t.chr500, 
   glaq020 LIKE glaq_t.glaq020, 
   glaq020_desc LIKE type_t.chr500, 
   glaq021 LIKE glaq_t.glaq021, 
   glaq021_desc LIKE type_t.chr500, 
   glaq022 LIKE glaq_t.glaq022, 
   glaq022_desc LIKE type_t.chr500, 
   glaq023 LIKE glaq_t.glaq023, 
   glaq023_desc LIKE type_t.chr500, 
   glaq024 LIKE glaq_t.glaq024, 
   glaq024_desc LIKE type_t.chr500, 
   glaq051 LIKE glaq_t.glaq051, 
   glaq052 LIKE glaq_t.glaq052,
   glaq052_desc LIKE type_t.chr500,
   glaq053 LIKE glaq_t.glaq053,
   glaq053_desc LIKE type_t.chr500,
   glaq025 LIKE glaq_t.glaq025, 
   glaq025_desc LIKE type_t.chr80,     
   glaq027 LIKE glaq_t.glaq027, 
   glaq027_desc LIKE type_t.chr80, 
   glaq028 LIKE glaq_t.glaq028, 
   glaq028_desc LIKE type_t.chr80, 
   glaq029 LIKE glaq_t.glaq029,
   glaq029_desc LIKE type_t.chr80, 
   glaq030 LIKE glaq_t.glaq030,
   glaq030_desc LIKE type_t.chr80, 
   glaq031 LIKE glaq_t.glaq031,
   glaq031_desc LIKE type_t.chr80, 
   glaq032 LIKE glaq_t.glaq032,
   glaq032_desc LIKE type_t.chr80, 
   glaq033 LIKE glaq_t.glaq033,
   glaq033_desc LIKE type_t.chr80, 
   glaq034 LIKE glaq_t.glaq034,
   glaq034_desc LIKE type_t.chr80,
   glaq035 LIKE glaq_t.glaq035,
   glaq035_desc LIKE type_t.chr80, 
   glaq036 LIKE glaq_t.glaq036,
   glaq036_desc LIKE type_t.chr80,
   glaq037 LIKE glaq_t.glaq037,
   glaq037_desc LIKE type_t.chr80, 
   glaq038 LIKE glaq_t.glaq038,
   glaq038_desc LIKE type_t.chr80,
   glaqdocno LIKE glaq_t.glaqdocno,
   glapdocdt LIKE glap_t.glapdocdt,
   glap004 LIKE glap_t.glap004,
   glaq001 LIKE glaq_t.glaq001,   
   style LIKE type_t.chr80, 
   glaq005 LIKE glaq_t.glaq005, 
   glaq006 LIKE glaq_t.glaq006, 
   glaq010d LIKE glaq_t.glaq010, 
   glaq010c LIKE glaq_t.glaq010, 
   glaq003 LIKE glaq_t.glaq003, 
   glaq004 LIKE glaq_t.glaq004, 
   glaq039 LIKE glaq_t.glaq039, 
   glaq040 LIKE glaq_t.glaq040, 
   glaq041 LIKE glaq_t.glaq041, 
   glaq042 LIKE glaq_t.glaq042, 
   glaq043 LIKE glaq_t.glaq043, 
   glaq044 LIKE glaq_t.glaq044, 
   state LIKE type_t.chr80, 
   amt LIKE glaq_t.glaq003, 
   amt1 LIKE glaq_t.glaq003, 
   amt2 LIKE glaq_t.glaq003, 
   amt3 LIKE glaq_t.glaq003 
       END RECORD
 
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glaq_d
DEFINE g_master_t                   type_g_glaq_d
DEFINE g_glaq_d          DYNAMIC ARRAY OF type_g_glaq_d
DEFINE g_glaq_d_t        type_g_glaq_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num5              
DEFINE l_ac_d               LIKE type_t.num5              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num5              #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num5
DEFINE g_detail_idx         LIKE type_t.num5
DEFINE g_detail_idx2        LIKE type_t.num5
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
 
 
#多table用wc
DEFINE g_wc_table           STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
 
#add-point:自定義模組變數(Module Variable)
#依据当前账别，抓取账别所归属的法人，使用币别，汇率参照表号，会计科目参照表号
DEFINE g_bookno        LIKE glap_t.glapld
DEFINE g_glaald        LIKE glaa_t.glaald
DEFINE g_glaald_desc   LIKE glaal_t.glaal002
DEFINE g_glaacomp      LIKE glaa_t.glaacomp
DEFINE g_glaacomp_desc LIKE ooefl_t.ooefl003
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa002       LIKE glaa_t.glaa002
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa013       LIKE glaa_t.glaa013
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa017       LIKE glaa_t.glaa017
DEFINE g_glaa018       LIKE glaa_t.glaa018
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_glaa021       LIKE glaa_t.glaa021
DEFINE g_glaa022       LIKE glaa_t.glaa022
#查询条件定义
DEFINE tm              RECORD
       sdate           LIKE glap_t.glapdocdt,  #起始日期
       syear           LIKE glap_t.glap002,    #起始年度
       speriod         LIKE glap_t.glap004,    #起始期別
       edate           LIKE glap_t.glapdocdt,  #截止日期
       eyear           LIKE glap_t.glap002,    #截止年度
       eperiod         LIKE glap_t.glap004,    #截止期別
       ctype           LIKE type_t.chr1,       #多本位幣
       curr_o          LIKE type_t.chr1, 
       curr_p          LIKE type_t.chr1, 
       acc_p           LIKE type_t.chr1, 
       show_acc        LIKE type_t.chr1, 
       glac005	       LIKE glac_t.glac005,
       stus            LIKE type_t.chr1,
       glac009	       LIKE glac_t.glac009,
       show_ad         LIKE type_t.chr1,
       show_ce         LIKE type_t.chr1,
       show_ye         LIKE type_t.chr1,
       comp            LIKE type_t.chr1,
       glad007         LIKE type_t.chr1,
       glad008         LIKE type_t.chr1,
       glad009         LIKE type_t.chr1,
       glad010         LIKE type_t.chr1,
       glad027         LIKE type_t.chr1,
       glad011         LIKE type_t.chr1,
       glad012         LIKE type_t.chr1,
       glad031         LIKE type_t.chr1,
       glad032         LIKE type_t.chr1,
       glad033         LIKE type_t.chr1,
       glad013         LIKE type_t.chr1,
       glad015         LIKE type_t.chr1,
       glad016         LIKE type_t.chr1,
       glad017         LIKE type_t.chr1,
       glad018         LIKE type_t.chr1,
       glad019         LIKE type_t.chr1,
       glad020         LIKE type_t.chr1,
       glad021         LIKE type_t.chr1,
       glad022         LIKE type_t.chr1,
       glad023         LIKE type_t.chr1,
       glad024         LIKE type_t.chr1,
       glad025         LIKE type_t.chr1,
       glad026         LIKE type_t.chr1
       END RECORD
DEFINE g_wc1           STRING
DEFINE g_glaq002       LIKE glaq_t.glaq002
DEFINE g_glaq005       LIKE glaq_t.glaq005
DEFINE g_glaq_s        DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
       glaq002         LIKE glaq_t.glaq002, 
       glaq005         LIKE glaq_t.glaq005
      END RECORD 
DEFINE g_current_row   LIKE type_t.num5 
DEFINE g_current_idx   LIKE type_t.num10     
DEFINE g_jump          LIKE type_t.num10        
DEFINE g_no_ask        LIKE type_t.num5  
DEFINE g_rec_b         LIKE type_t.num5
DEFINE g_wc_glaq002    STRING
DEFINE g_argv_flag     LIKE type_t.num5
#160503-00025#2--add--str--lujh
DEFINE g_glad0171     LIKE glad_t.glad0171
DEFINE g_glad0181     LIKE glad_t.glad0181
DEFINE g_glad0191     LIKE glad_t.glad0191
DEFINE g_glad0201     LIKE glad_t.glad0201
DEFINE g_glad0211     LIKE glad_t.glad0211
DEFINE g_glad0221     LIKE glad_t.glad0221
DEFINE g_glad0231     LIKE glad_t.glad0231
DEFINE g_glad0241     LIKE glad_t.glad0241
DEFINE g_glad0251     LIKE glad_t.glad0251
DEFINE g_glad0261     LIKE glad_t.glad0261
#160503-00025#2--add--end--lujh
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="aglq770.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
 
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agl","")
 
   #add-point:作業初始化
   
   #end add-point
   
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = ""
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE aglq770_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE ",
               " FROM ",
               " WHERE  "
   #add-point:SQL_define
   
   #end add-point
   PREPARE aglq770_master_referesh FROM g_sql
 
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call
      
      #end add-point
 
   ELSE
      
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq770 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq770_init()   
 
      #進入選單 Menu (="N")
      CALL aglq770_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq770
      
   END IF 
   
   CLOSE aglq770_cl
   
   
 
   #add-point:作業離開前
   DROP TABLE aglq770_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="aglq770.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq770_init()
   #add-point:init段define
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   
   
   
   #add-point:畫面資料初始化
   LET g_detail_idx  = 1
   CALL cl_set_combo_scc('stus','9922')
   CALL cl_set_combo_scc('state','9926')
   CALL cl_set_combo_scc('style','9927')
   #抓取傳參
   CALL aglq770_default_search()
   #获取账别
   IF cl_null(g_glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF      
   CALL aglq770_glaald_desc(g_glaald)
   IF cl_null(g_argv[01]) THEN
      LET g_argv_flag = FALSE
      CALL aglq770_set_default_value()
   ELSE
      LET g_argv_flag = TRUE
      SELECT MIN(glav004) INTO tm.sdate FROM glav_t 
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=tm.speriod
      SELECT MAX(glav004) INTO tm.edate FROM glav_t 
       WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.eyear AND glav006=tm.eperiod
   END IF
   #建立临时表
   CALL aglq770_create_temp_table()
   CALL cl_set_combo_scc('b_glaq051','6013')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aglq770.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq770_ui_dialog()
   {<Local define>}
   DEFINE li_idx   LIKE type_t.num5
   {</Local define>}
   #add-point:ui_dialog段define
   DEFINE ls_wc    STRING
   DEFINE l_string STRING
   #end add-point 
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   CALL aglq770_query()
   
   WHILE TRUE
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glaq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glaq_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac
               CALL aglq770_fetch()
               #add-point:input段before row
               DISPLAY g_current_idx TO FORMONLY.h_index
               DISPLAY g_glaq_s.getLength() TO FORMONLY.h_count
               DISPLAY g_detail_idx TO FORMONLY.idx
               DISPLAY g_glaq_d.getLength() TO FORMONLY.cnt
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段define

         #end add-point
         
         BEFORE DIALOG      
            CALL DIALOG.setSelectionMode("s_detail1", 1)
 
            #add-point:ui_dialog段before dialog
            #上下筆按鈕顯示否設置
            IF g_header_cnt=1 THEN
               CALL cl_set_act_visible("first,previous,jump,next,last",FALSE) 
            ELSE
               IF g_current_idx=1 THEN
                  CALL cl_set_act_visible("first,previous", FALSE) 
                  CALL cl_set_act_visible("jump,next,last", TRUE) 
               ELSE
                  IF g_current_idx<>g_header_cnt THEN
                     CALL cl_set_act_visible("first,previous,jump,next,last",TRUE) 
                  ELSE
                     CALL cl_set_act_visible("first,previous,jump",TRUE) 
                     CALL cl_set_act_visible("next,last", FALSE) 
                  END IF
               END IF
            END IF
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
            NEXT FIELD sel
      
         ON ACTION exchange_ld
 
            LET g_action_choice="exchange_ld"
            IF cl_auth_chk_act("exchange_ld") THEN 
               #add-point:ON ACTION exchange_ld
               CALL aglt310_01(g_glaald) RETURNING g_bookno
               IF g_glaald <> g_bookno THEN
                  CLEAR FORM
                  CALL g_glaq_s.clear()
                  CALL g_glaq_d.clear()
               END IF
               LET g_glaald = g_bookno
               #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
               CALL aglq770_glaald_desc(g_glaald)
               CALL aglq770_show()
                IF cl_null(g_wc) THEN
                   LET g_wc = '1=1'
                END IF 
                LET g_wc1 = ' 1=1'
                LET g_wc2 = ' 1=1'
               #END add-point
               EXIT DIALOG
            END IF               
 
         ON ACTION last
 
            LET g_action_choice="last"
            IF cl_auth_chk_act("last") THEN 
               #add-point:ON ACTION last
               CALL aglq770_fetch1('L')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION next
 
            LET g_action_choice="next"
            IF cl_auth_chk_act("next") THEN 
               #add-point:ON ACTION next
               CALL aglq770_fetch1('N')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION insert
 
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN 
               CALL aglq770_insert()
               #add-point:ON ACTION insert

               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION previous
 
            LET g_action_choice="previous"
            IF cl_auth_chk_act("previous") THEN 
               #add-point:ON ACTION previous
               CALL aglq770_fetch1('P')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION jump
 
            LET g_action_choice="jump"
            IF cl_auth_chk_act("jump") THEN 
               #add-point:ON ACTION jump
               CALL aglq770_fetch1('/')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION query
 
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN 
               CALL aglq770_query()
               #add-point:ON ACTION query
               EXIT DIALOG
               #END add-point
            END IF
 
 
         ON ACTION first
 
            LET g_action_choice="first"
            IF cl_auth_chk_act("first") THEN 
               #add-point:ON ACTION first
               CALL aglq770_fetch1('F')
               LET g_current_row = g_current_idx
               LET g_curr_diag = ui.DIALOG.getCurrent()
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION output
 
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN 
               #add-point:ON ACTION output
                   
               CALL aglq770_g01('aglq770_tmp',tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.curr_o,tm.curr_p,tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,tm.glad011,tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,tm.glad015,tm.glad016,tm.glad017,tm.glad018,tm.glad019,tm.glad020,tm.glad021,tm.glad022,tm.glad023,tm.glad024,tm.glad025,tm.glad026,g_glaald)  

    
               #END add-point
               EXIT DIALOG
            END IF
 
 
         ON ACTION datainfo
 
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN 
               #add-point:ON ACTION datainfo

               #END add-point
               EXIT DIALOG
            END IF
 
      
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glaq_d.getLength()
               LET g_glaq_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glaq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glaq_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL aglq770_glaald_desc(g_glaald)
            CALL aglq770_set_default_value()
            CALL aglq770_query()
            EXIT DIALOG
            
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  IF NOT cl_null(g_glaq_d[g_detail_idx].glaqdocno) THEN
                     CALL aglq770_cmdrun() #串查aglt310傳票資料    
                  END IF
               END IF
               EXIT DIALOG
            END IF 
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq770_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            CALL aglq770_b_fill()
            CALL aglq770_fetch()
            
          ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glaq_d)
 
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF            
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq770_query()
   {<Local define>}
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   {</Local define>}
   #add-point:query段define
   DEFINE l_flag           LIKE type_t.num5
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_cnt            LIKE type_t.num5
   
   #建立临时表
   CALL aglq770_create_temp_table()
   
   #從aglq750串查資料
   IF g_argv_flag = TRUE THEN 
      LET g_argv_flag = FALSE
      CALL aglq770_visible()
      CALL aglq770_show()   
      CALL cl_set_comp_visible('group3',FALSE)
      CALL aglq770_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq770_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq770_set_page()
      CALL aglq770_fetch1('F')      
      RETURN
   END IF
   
   LET l_flag=TRUE
   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glaq_d.clear()
   LET g_wc_filter = " 1=1"
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024, 
          glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,
          glaq035,glaq036,glaq037,glaq038
           FROM s_detail1[1].b_glaq017,s_detail1[1].b_glaq018,s_detail1[1].b_glaq019, 
               s_detail1[1].b_glaq020,s_detail1[1].b_glaq021,s_detail1[1].b_glaq022,s_detail1[1].b_glaq023, 
               s_detail1[1].b_glaq024,s_detail1[1].b_glaq051,s_detail1[1].b_glaq052,s_detail1[1].b_glaq053,
               s_detail1[1].b_glaq025,s_detail1[1].b_glaq027,s_detail1[1].b_glaq028,s_detail1[1].b_glaq029,
               s_detail1[1].b_glaq030,s_detail1[1].b_glaq031,s_detail1[1].b_glaq032,s_detail1[1].b_glaq033,
               s_detail1[1].b_glaq034,s_detail1[1].b_glaq035,s_detail1[1].b_glaq036,s_detail1[1].b_glaq037,
               s_detail1[1].b_glaq038
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
       #---------------------<  Detail: page1  >---------------------
 
 

 

         #----<<b_glaq017>>----
         #Ctrlp:construct.c.page1.b_glaq017
         ON ACTION controlp INFIELD b_glaq017
            #add-point:ON ACTION controlp INFIELD b_glaq017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq017  #顯示到畫面上
            NEXT FIELD b_glaq017                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq017
            #add-point:BEFORE FIELD b_glaq017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq017
            
            #add-point:AFTER FIELD b_glaq017

            #END add-point
            
 
         #----<<b_glaq018>>----
         #Ctrlp:construct.c.page1.b_glaq018
         ON ACTION controlp INFIELD b_glaq018
            #add-point:ON ACTION controlp INFIELD b_glaq018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq018  #顯示到畫面上
            NEXT FIELD b_glaq018                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq018
            #add-point:BEFORE FIELD b_glaq018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq018
            
            #add-point:AFTER FIELD b_glaq018

            #END add-point
            
 
         #----<<b_glaq019>>----
         #Ctrlp:construct.c.page1.b_glaq019
         ON ACTION controlp INFIELD b_glaq019
            #add-point:ON ACTION controlp INFIELD b_glaq019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq019  #顯示到畫面上
            NEXT FIELD b_glaq019                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq019
            #add-point:BEFORE FIELD b_glaq019

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq019
            
            #add-point:AFTER FIELD b_glaq019

            #END add-point
            
 
         #----<<b_glaq020>>----
         #Ctrlp:construct.c.page1.b_glaq020
         ON ACTION controlp INFIELD b_glaq020
            #add-point:ON ACTION controlp INFIELD b_glaq020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq020  #顯示到畫面上
            NEXT FIELD b_glaq020                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq020
            #add-point:BEFORE FIELD b_glaq020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq020
            
            #add-point:AFTER FIELD b_glaq020

            #END add-point
            
 
         #----<<b_glaq021>>----
         #Ctrlp:construct.c.page1.b_glaq021
         ON ACTION controlp INFIELD b_glaq021
            #add-point:ON ACTION controlp INFIELD b_glaq021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq021  #顯示到畫面上
            NEXT FIELD b_glaq021                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq021
            #add-point:BEFORE FIELD b_glaq021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq021
            
            #add-point:AFTER FIELD b_glaq021

            #END add-point
            
 
         #----<<b_glaq022>>----
         #Ctrlp:construct.c.page1.b_glaq022
         ON ACTION controlp INFIELD b_glaq022
            #add-point:ON ACTION controlp INFIELD b_glaq022
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq022  #顯示到畫面上
            NEXT FIELD b_glaq022                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq022
            #add-point:BEFORE FIELD b_glaq022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq022
            
            #add-point:AFTER FIELD b_glaq022

            #END add-point
            
 
         #----<<b_glaq023>>----
         #Ctrlp:construct.c.page1.b_glaq023
         ON ACTION controlp INFIELD b_glaq023
            #add-point:ON ACTION controlp INFIELD b_glaq023
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq023  #顯示到畫面上
            NEXT FIELD b_glaq023                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq023
            #add-point:BEFORE FIELD b_glaq023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq023
            
            #add-point:AFTER FIELD b_glaq023

            #END add-point
            
 
         #----<<b_glaq024>>----
         #Ctrlp:construct.c.page1.b_glaq024
         ON ACTION controlp INFIELD b_glaq024
            #add-point:ON ACTION controlp INFIELD b_glaq024
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq024  #顯示到畫面上
            NEXT FIELD b_glaq024                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq024
            #add-point:BEFORE FIELD b_glaq024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq024
            
            #add-point:AFTER FIELD b_glaq024

            #END add-point
            
 
         #----<<b_glaq025>>----
         #Ctrlp:construct.c.page1.b_glaq025
         ON ACTION controlp INFIELD b_glaq025
            #add-point:ON ACTION controlp INFIELD b_glaq025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq025  #顯示到畫面上
            NEXT FIELD b_glaq025                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq025
            #add-point:BEFORE FIELD b_glaq025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq025
            
            #add-point:AFTER FIELD b_glaq025

            #END add-point
            
 
         #----<<b_glaq052>>----
         #Ctrlp:construct.c.page1.b_glaq052
         ON ACTION controlp INFIELD b_glaq052
            #add-point:ON ACTION controlp INFIELD b_glaq052
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq052  #顯示到畫面上
            NEXT FIELD b_glaq052                     #返回原欄位
    

         ON ACTION controlp INFIELD b_glaq053
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq053  #顯示到畫面上
            NEXT FIELD b_glaq053                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq052
            #add-point:BEFORE FIELD b_glaq052

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq052
            
            #add-point:AFTER FIELD b_glaq052

            #END add-point
            
 
         #----<<b_glaq027>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq027
            #add-point:BEFORE FIELD b_glaq027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq027
            
            #add-point:AFTER FIELD b_glaq027

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glaq027
         ON ACTION controlp INFIELD b_glaq027
            #add-point:ON ACTION controlp INFIELD b_glaq027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq027     #顯示到畫面上
            NEXT FIELD b_glaq027
            #END add-point
 
         #----<<b_glaq028>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_glaq028
            #add-point:BEFORE FIELD b_glaq028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_glaq028
            
            #add-point:AFTER FIELD b_glaq028

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_glaq028
         ON ACTION controlp INFIELD b_glaq028
            #add-point:ON ACTION controlp INFIELD b_glaq028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq028  #顯示到畫面上

            NEXT FIELD b_glaq028 
            #END add-point

 

 

 

 

 

 
 
 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

       END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct
      CONSTRUCT g_wc_glaq002 ON glaq002 FROM s_detail1[1].b_glaq002
         BEFORE CONSTRUCT
         ON ACTION controlp INFIELD b_glaq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
      END CONSTRUCT
      
      CONSTRUCT g_wc1 ON glaqdocno,glapdocdt
           FROM s_detail1[1].glaqdocno,s_detail1[1].glapdocdt
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaqdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaqdocno  #顯示到畫面上
            NEXT FIELD glaqdocno                     #返回原欄位  
            
      END CONSTRUCT
      
      CONSTRUCT g_wc2 ON glaq005
           FROM s_detail1[1].glaq005
                      
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD glaq005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上
            NEXT FIELD glaq005                     #返回原欄位            
      END CONSTRUCT
      
      INPUT BY NAME tm.sdate,tm.edate,tm.ctype,tm.curr_o,tm.curr_p,tm.acc_p,
                    tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,
                    tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,
                    tm.glad011,tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,
                    tm.glad015,tm.glad016,tm.glad017,tm.glad018,tm.glad019,tm.glad020,
                    tm.glad021,tm.glad022,tm.glad023,tm.glad024,tm.glad025,tm.glad026
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
         
         AFTER FIELD sdate
            IF NOT cl_null(tm.sdate) THEN
               CALL s_get_accdate(g_glaa003,tm.sdate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD sdate
               END IF
               IF NOT cl_null(tm.edate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00116'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD sdate
                  END IF
               END IF
               LET tm.syear=l_glav002
               LET tm.speriod=l_glav006
               DISPLAY tm.syear,tm.speriod TO syear,speriod 
            END IF
         
         AFTER FIELD edate
            IF NOT cl_null(tm.edate) THEN
               CALL s_get_accdate(g_glaa003,tm.edate,'','')
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD edate
               END IF
               IF NOT cl_null(tm.sdate) THEN
                  IF tm.sdate>tm.edate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00117'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD edate
                  END IF
               END IF
               LET tm.eyear=l_glav002
               LET tm.eperiod=l_glav006
               DISPLAY tm.eyear,tm.eperiod TO eyear,eperiod 
            END IF
         
         ON CHANGE ctype
            IF tm.ctype MATCHES '[0123]' THEN
               CALL aglq770_set_curr_show()
            ELSE
               NEXT FIELD ctype
            END IF
            
         ON CHANGE curr_o 
            IF tm.curr_o MATCHES '[yYnN]' THEN
               IF tm.curr_o='Y' THEN
                  CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',TRUE)
                  CALL aglq770_set_comp_entry('curr_p',TRUE)
               ELSE
                  CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',FALSE)
                  CALL aglq770_set_comp_entry('curr_p',FALSE)
                  LET tm.curr_p='N'
                  DISPLAY tm.curr_p TO curr_p
               END IF                  
            ELSE
               NEXT FIELD curr_o
            END IF
            
         ON CHANGE acc_p
            IF tm.acc_p NOT MATCHES '[yYnN]' THEN
                NEXT FIELD curr_p
            END IF
            
         AFTER FIELD acc_p
            IF tm.acc_p NOT MATCHES '[yYnN]' THEN
               NEXT FIELD acc_p
            END IF
            
         AFTER FIELD show_acc
            IF tm.show_acc NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_acc
            END IF
         
         AFTER FIELD glac005
            IF NOT cl_ap_chk_Range(tm.glac005,"1","1","99","1","azz-00087",1) THEN
               NEXT FIELD glac005
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
            
         AFTER FIELD glac009
            IF tm.glac009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
         
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
            
         AFTER FIELD show_ce
            IF tm.show_ce NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD show_ye
            IF tm.show_ye NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
            
         ON CHANGE comp
            IF tm.comp NOT MATCHES '[yYnN]' THEN
               NEXT FIELD comp
            END IF
            IF tm.comp='Y' THEN
               CALL cl_set_comp_visible("b_glaq017,b_glaq017_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq017,b_glaq017_desc",FALSE)
            END IF
            
         ON CHANGE glad007
            IF tm.glad007 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad007
            END IF
            IF tm.glad007='Y' THEN
               CALL cl_set_comp_visible("b_glaq018,b_glaq018_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq018,b_glaq018_desc",FALSE)
            END IF
            
         ON CHANGE glad008
            IF tm.glad008 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad008
            END IF
            IF tm.glad008='Y' THEN
               CALL cl_set_comp_visible("b_glaq019,b_glaq019_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq019,b_glaq019_desc",FALSE)
            END IF
            
         ON CHANGE glad009
            IF tm.glad009 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad009
            END IF
            IF tm.glad009='Y' THEN
               CALL cl_set_comp_visible("b_glaq020,b_glaq020_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq020,b_glaq020_desc",FALSE)
            END IF
         
         ON CHANGE glad010
            IF tm.glad010 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad010
            END IF
            IF tm.glad010='Y' THEN
               CALL cl_set_comp_visible("b_glaq021,b_glaq021_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq021,b_glaq021_desc",FALSE)
            END IF
            
         ON CHANGE glad027
            IF tm.glad027 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad027
            END IF
            IF tm.glad027='Y' THEN
               CALL cl_set_comp_visible("b_glaq022,b_glaq022_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq022,b_glaq022_desc",FALSE)
            END IF
            
         ON CHANGE glad011
            IF tm.glad011 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad011
            END IF
            IF tm.glad011='Y' THEN
               CALL cl_set_comp_visible("b_glaq023,b_glaq023_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq023,b_glaq023_desc",FALSE)
            END IF
            
         ON CHANGE glad012
            IF tm.glad012 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad012
            END IF
            IF tm.glad012='Y' THEN
               CALL cl_set_comp_visible("b_glaq024,b_glaq024_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq024,b_glaq024_desc",FALSE)
            END IF
         
         #經營方式
         ON CHANGE glad031
            IF tm.glad031 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad031
            END IF
            IF tm.glad031='Y' THEN
               CALL cl_set_comp_visible("b_glaq051",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq051",FALSE)
            END IF
            
         #渠道
         ON CHANGE glad032
            IF tm.glad032 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad032
            END IF
            IF tm.glad032='Y' THEN
               CALL cl_set_comp_visible("b_glaq052,b_glaq052_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq052,b_glaq052_desc",FALSE)
            END IF
            
         #品牌
         ON CHANGE glad033
            IF tm.glad033 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad033
            END IF
            IF tm.glad033='Y' THEN
               CALL cl_set_comp_visible("b_glaq053,b_glaq053_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq053,b_glaq053_desc",FALSE)
            END IF
            
         ON CHANGE glad013
            IF tm.glad013 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad013
            END IF
            IF tm.glad013='Y' THEN
               CALL cl_set_comp_visible("b_glaq025,glaq025_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq025,glaq025_desc",FALSE)
            END IF 
         
#         ON CHANGE glad014
#            IF tm.glad014 NOT MATCHES '[yYnN]' THEN
#               NEXT FIELD glad014
#            END IF
#            IF tm.glad014='Y' THEN
#               CALL cl_set_comp_visible("b_glaq026,b_glaq026_desc",TRUE)
#            ELSE
#               CALL cl_set_comp_visible("b_glaq026,b_glaq026_desc",FALSE)
#            END IF

         ON CHANGE glad015
            IF tm.glad015 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad015
            END IF
            IF tm.glad015='Y' THEN
               CALL cl_set_comp_visible("b_glaq027,b_glaq027_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq027,b_glaq027_desc",FALSE)
            END IF
            
         ON CHANGE glad016
            IF tm.glad016 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad016
            END IF
            IF tm.glad016='Y' THEN
               CALL cl_set_comp_visible("b_glaq028,b_glaq028_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq028,b_glaq028_desc",FALSE)
            END IF
            
         ON CHANGE glad017
            IF tm.glad017 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad017
            END IF
            IF tm.glad017='Y' THEN
               CALL cl_set_comp_visible("b_glaq029,b_glaq029_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq029,b_glaq029_desc",FALSE)
            END IF
            
         ON CHANGE glad018
            IF tm.glad018 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad018
            END IF
            IF tm.glad018='Y' THEN
               CALL cl_set_comp_visible("b_glaq030,b_glaq030_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq030,b_glaq030_desc",FALSE)
            END IF
            
         ON CHANGE glad019
            IF tm.glad019 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad019
            END IF
            IF tm.glad019='Y' THEN
               CALL cl_set_comp_visible("b_glaq031,b_glaq031_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq031,b_glaq031_desc",FALSE)
            END IF
            
         ON CHANGE glad020
            IF tm.glad020 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad020
            END IF
            IF tm.glad020='Y' THEN
               CALL cl_set_comp_visible("b_glaq032,b_glaq032_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq032,b_glaq032_desc",FALSE)
            END IF
            
         ON CHANGE glad021
            IF tm.glad021 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad021
            END IF
            IF tm.glad021='Y' THEN
               CALL cl_set_comp_visible("b_glaq033,b_glaq033_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq033,b_glaq033_desc",FALSE)
            END IF
            
         ON CHANGE glad022
            IF tm.glad022 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad022
            END IF
            IF tm.glad022='Y' THEN
               CALL cl_set_comp_visible("b_glaq034,b_glaq034_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq034,b_glaq034_desc",FALSE)
            END IF
            
         ON CHANGE glad023
            IF tm.glad023 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad023
            END IF
            IF tm.glad023='Y' THEN
               CALL cl_set_comp_visible("b_glaq035,b_glaq035_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq035,b_glaq035_desc",FALSE)
            END IF
            
         ON CHANGE glad024
            IF tm.glad024 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad024
            END IF
            IF tm.glad024='Y' THEN
               CALL cl_set_comp_visible("b_glaq036,b_glaq036_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq036,b_glaq036_desc",FALSE)
            END IF
            
         ON CHANGE glad025
            IF tm.glad025 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad025
            END IF
            IF tm.glad025='Y' THEN
               CALL cl_set_comp_visible("b_glaq037,b_glaq037_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq037,b_glaq037_desc",FALSE)
            END IF
            
         ON CHANGE glad026
            IF tm.glad026 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glad026
            END IF
            IF tm.glad026='Y' THEN
               CALL cl_set_comp_visible("b_glaq038,b_glaq038_desc",TRUE)
            ELSE
               CALL cl_set_comp_visible("b_glaq038,b_glaq038_desc",FALSE)
            END IF
      END INPUT
      
      BEFORE DIALOG
        #預設
        CALL cl_set_comp_visible('group3',TRUE)
        CALL aglq770_show()
        
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         CALL aglq770_glaald_desc(g_glaald)
         CALL aglq770_set_default_value()
         CALL cl_set_comp_visible('group3',TRUE)
         CALL aglq770_show()
      #end add-point 
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET l_flag=FALSE
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct
   IF l_flag=TRUE THEN
      CALL cl_set_comp_visible('group3',FALSE)
      CALL aglq770_get_data()
      SELECT COUNT(*) INTO l_cnt FROM aglq770_tmp
      IF l_cnt=0 THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = -100
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         RETURN
      END IF
      CALL aglq770_set_page()
      CALL aglq770_fetch1('F')
   ELSE
      CALL aglq770_b_fill1()
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_glaq_s.getLength() TO FORMONLY.h_count
      DISPLAY g_detail_idx TO FORMONLY.idx
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aglq770_b_fill()
   LET l_ac = g_master_idx
   CALL aglq770_fetch()
#   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
#      CALL cl_err("",-100,1)
#   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="aglq770.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq770_b_fill()
   {<Local define>}
   DEFINE ls_wc           STRING
   {</Local define>}
   #add-point:b_fill段define

   #end add-point
 
   #add-point:b_fill段sql_before
   RETURN
   #end add-point
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   LET g_sql = "SELECT  UNIQUE glaq002,'',glaq017,'',glaq018,'',glaq019,'',glaq020,'',glaq021,'',glaq022, 
       '',glaq023,'',glaq024,'',glaq051,glaq052,'',glaq053,'',glaq025,'',glaq027,glaq028,'','','','','','','','','','', 
       '','','','','','','','','','','' FROM glaq_t",
 
 
               "",
               " WHERE glaqent= ? AND 1=1 AND ", ls_wc
    
   LET g_sql = g_sql, " ORDER BY glaq_t.glaqld,glaq_t.glaqdocno,glaq_t.glaqseq"
  
   #add-point:b_fill段sql_after
  
   #end add-point
  
   PREPARE aglq770_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq770_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glaq_d.clear()
 
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs INTO g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].glaq017, 
       g_glaq_d[l_ac].glaq017_desc,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq018_desc,g_glaq_d[l_ac].glaq019, 
       g_glaq_d[l_ac].glaq019_desc,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq020_desc,g_glaq_d[l_ac].glaq021, 
       g_glaq_d[l_ac].glaq021_desc,g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq022_desc,g_glaq_d[l_ac].glaq023, 
       g_glaq_d[l_ac].glaq023_desc,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq024_desc,g_glaq_d[l_ac].glaq051,
       g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq052_desc,g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq053_desc, 
       g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq025_desc,g_glaq_d[l_ac].glaq027, 
       g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glapdocdt,g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glap004, 
       g_glaq_d[l_ac].style,g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010d,g_glaq_d[l_ac].glaq010c, 
       g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041, 
       g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].state,g_glaq_d[l_ac].amt, 
       g_glaq_d[l_ac].amt1,g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].amt3
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET g_glaq_d[l_ac].sel = "N"
      #LET g_glaq_d[l_ac].statepic = cl_get_actipic(g_glaq_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL aglq770_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
 
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq770_pb
   
   LET l_ac = 1
   CALL aglq770_fetch()
   
      CALL aglq770_filter_show('glaq002','b_glaq002')
   CALL aglq770_filter_show('glaq017','b_glaq017')
   CALL aglq770_filter_show('glaq018','b_glaq018')
   CALL aglq770_filter_show('glaq019','b_glaq019')
   CALL aglq770_filter_show('glaq020','b_glaq020')
   CALL aglq770_filter_show('glaq021','b_glaq021')
   CALL aglq770_filter_show('glaq022','b_glaq022')
   CALL aglq770_filter_show('glaq023','b_glaq023')
   CALL aglq770_filter_show('glaq024','b_glaq024')
   CALL aglq770_filter_show('glaq051','b_glaq051')
   CALL aglq770_filter_show('glaq052','b_glaq052')
   CALL aglq770_filter_show('glaq053','b_glaq053')
   CALL aglq770_filter_show('glaq025','b_glaq025')
   CALL aglq770_filter_show('glaq027','b_glaq027')
   CALL aglq770_filter_show('glaq028','b_glaq028')
   CALL aglq770_filter_show('glaqdocno','b_glaq028')
   CALL aglq770_filter_show('glaq005','b_glaq028')
   CALL aglq770_filter_show('glaq006','b_glaq028')
   CALL aglq770_filter_show('glaq003','b_glaq028')
   CALL aglq770_filter_show('glaq004','b_glaq028')
   CALL aglq770_filter_show('glaq039','b_glaq028')
   CALL aglq770_filter_show('glaq040','b_glaq028')
   CALL aglq770_filter_show('glaq041','b_glaq028')
   CALL aglq770_filter_show('glaq042','b_glaq028')
   CALL aglq770_filter_show('glaq043','b_glaq028')
   CALL aglq770_filter_show('glaq044','b_glaq028')
 
   
END FUNCTION
 
{</section>}
 
{<section id="aglq770.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq770_fetch()
   {<Local define>}
   DEFINE li_ac           LIKE type_t.num5
   {</Local define>}
   #add-point:fetch段define
   RETURN
   #end add-point
   
 
   
   LET li_ac = l_ac 
   
 
   
   #DISPLAY g_detail_cnt TO FORMONLY.cnt
 
   #add-point:單身填充後
   
   #end add-point 
   
 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aglq770.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq770_detail_show()
   #add-point:show段define
   DEFINE l_glad0171     LIKE glad_t.glad0171
   DEFINE l_glad0181     LIKE glad_t.glad0181
   DEFINE l_glad0191     LIKE glad_t.glad0191
   DEFINE l_glad0201     LIKE glad_t.glad0201
   DEFINE l_glad0211     LIKE glad_t.glad0211
   DEFINE l_glad0221     LIKE glad_t.glad0221
   DEFINE l_glad0231     LIKE glad_t.glad0231
   DEFINE l_glad0241     LIKE glad_t.glad0241
   DEFINE l_glad0251     LIKE glad_t.glad0251
   DEFINE l_glad0261     LIKE glad_t.glad0261
   #end add-point
 
   #add-point:detail_show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值page1
   
    
 
   
   #讀入ref值
   #add-point:show段單身reference
   #160503-00025#2--mark--str--lujh
   ##科目編號
   #INITIALIZE g_ref_fields TO NULL
   #LET g_ref_fields[1] = g_glaq_d[l_ac].glaq002
   #CALL ap_ref_array2(g_ref_fields,"SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001 = '"||g_glaa004||"' AND glacl002 = ? AND glacl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #LET g_glaq_d[l_ac].glaq002_desc=g_rtn_fields[1]
   ##營運據點
   #IF tm.comp='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] =g_glaq_d[l_ac].glaq017
   #   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq017_desc=g_rtn_fields[1]
   #END IF
   ##部門
   #IF tm.glad007='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] =g_glaq_d[l_ac].glaq018
   #   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq018_desc=g_rtn_fields[1]
   #END IF
   ##成本中心
   #IF tm.glad008='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] =g_glaq_d[l_ac].glaq019
   #   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq019_desc=g_rtn_fields[1]
   #END IF
   ##區域
   #IF tm.glad009='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = '287'
   #   LET g_ref_fields[2] = g_glaq_d[l_ac].glaq020
   #   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq020_desc=g_rtn_fields[1] 
   #END IF
   ##交易客戶
   #IF tm.glad010='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_glaq_d[l_ac].glaq021
   #   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq021_desc=g_rtn_fields[1]
   #END IF
   ##帳款客戶
   #IF tm.glad027='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_glaq_d[l_ac].glaq022
   #   CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq022_desc=g_rtn_fields[1]
   #END IF
   ##客群   
   #IF tm.glad011='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = '281'
   #   LET g_ref_fields[2] = g_glaq_d[l_ac].glaq023
   #   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq023_desc=g_rtn_fields[1] 
   #END IF
   ##產品類別
   #IF tm.glad012='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_glaq_d[l_ac].glaq024
   #   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq024_desc=g_rtn_fields[1]
   #END IF
   ##人員編號
   #IF tm.glad013='Y' THEN
   #   SELECT ooag011 INTO g_glaq_d[l_ac].glaq025_desc FROM ooag_t
   #    WHERE ooagent = g_enterprise AND ooag001 = g_glaq_d[l_ac].glaq025
   #END IF
#  # #預算編號
#  # IF tm.glad014='Y' THEN
#  #    INITIALIZE g_ref_fields TO NULL
#  #    LET g_ref_fields[1] = g_glaq_d[l_ac].glaq026
#  #    CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent='"||g_enterprise||"' AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
#  #    LET g_glaq_d[l_ac].glaq026_desc=g_rtn_fields[1]
#  # END IF
   ##渠道
   #IF tm.glad032='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = g_glaq_d[l_ac].glaq052
   #   CALL ap_ref_array2(g_ref_fields,"SELECT oojdl003 FROM oojdl_t WHERE oojdlent='"||g_enterprise||"' AND oojdl001=? AND oojdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq052_desc=g_rtn_fields[1]
   #END IF
   ##品牌
   #IF tm.glad033='Y' THEN
   #   INITIALIZE g_ref_fields TO NULL
   #   LET g_ref_fields[1] = '2002'
   #   LET g_ref_fields[2] = g_glaq_d[l_ac].glaq053
   #   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   #   LET g_glaq_d[l_ac].glaq053_desc=g_rtn_fields[1] 
   #END IF
   ##專案
   #IF tm.glad015='Y' THEN
   #   CALL s_desc_get_project_desc(g_glaq_d[l_ac].glaq027) RETURNING g_glaq_d[l_ac].glaq027_desc
   #END IF
   #
   ##WBS
   #IF tm.glad016='Y' THEN
   #   CALL s_desc_get_wbs_desc(g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq028) RETURNING g_glaq_d[l_ac].glaq028_desc
   #END IF
   
   
   #自由核算項
   #SELECT glad0171,glad0181,glad0191,glad0201,glad0211,glad0221,
   #       glad0231,glad0221,glad0251,glad0261
   # INTO  l_glad0171,l_glad0181,l_glad0191,l_glad0201,l_glad0211,l_glad0221,
   #       l_glad0231,l_glad0241,l_glad0251,l_glad0261
   # FROM  glad_t
   # WHERE gladent = g_enterprise
   #   AND gladld = g_glaald
   #   AND glad001 = g_glaq_d[l_ac].glaq002
   #160503-00025#2--mark--end--lujh
   IF tm.glad017='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq029) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq029) lujh
      CALL s_voucher_free_account_desc(g_glad0171,g_glaq_d[l_ac].glaq029) RETURNING g_glaq_d[l_ac].glaq029_desc  #160503-00025#2 add change l_glad0171 to g_glad0171 lujh
   END IF
   IF tm.glad018='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq030) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq030) lujh
      CALL s_voucher_free_account_desc(g_glad0181,g_glaq_d[l_ac].glaq030) RETURNING g_glaq_d[l_ac].glaq030_desc  #160503-00025#2 add change l_glad0181 to g_glad0181 lujh
   END IF
   IF tm.glad019='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq031) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq031) lujh
      CALL s_voucher_free_account_desc(g_glad0191,g_glaq_d[l_ac].glaq031) RETURNING g_glaq_d[l_ac].glaq031_desc  #160503-00025#2 add change l_glad0191 to g_glad0191 lujh
   END IF
   IF tm.glad020='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq032) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq032) lujh
      CALL s_voucher_free_account_desc(g_glad0201,g_glaq_d[l_ac].glaq032) RETURNING g_glaq_d[l_ac].glaq032_desc  #160503-00025#2 add change l_glad0201 to g_glad0201 lujh
   END IF
   IF tm.glad021='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq033) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq033) lujh
      CALL s_voucher_free_account_desc(g_glad0211,g_glaq_d[l_ac].glaq033) RETURNING g_glaq_d[l_ac].glaq033_desc  #160503-00025#2 add change l_glad0211 to g_glad0211 lujh
   END IF
   IF tm.glad022='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq034) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq034) lujh
      CALL s_voucher_free_account_desc(g_glad0221,g_glaq_d[l_ac].glaq034) RETURNING g_glaq_d[l_ac].glaq034_desc  #160503-00025#2 add change l_glad0221 to g_glad0221 lujh
   END IF
   IF tm.glad023='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq035) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq035) lujh
      CALL s_voucher_free_account_desc(g_glad0231,g_glaq_d[l_ac].glaq035) RETURNING g_glaq_d[l_ac].glaq035_desc  #160503-00025#2 add change l_glad0231 to g_glad0231 lujh
   END IF
   IF tm.glad024='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq036) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq036) lujh
      CALL s_voucher_free_account_desc(g_glad0241,g_glaq_d[l_ac].glaq036) RETURNING g_glaq_d[l_ac].glaq036_desc  #160503-00025#2 add change l_glad0241 to g_glad0241 lujh
   END IF
   IF tm.glad025='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq037) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq037) lujh
      CALL s_voucher_free_account_desc(g_glad0251,g_glaq_d[l_ac].glaq037) RETURNING g_glaq_d[l_ac].glaq037_desc  #160503-00025#2 add change l_glad0251 to g_glad0251 lujh
   END IF
   IF tm.glad026='Y' AND NOT cl_null(g_glaq_d[l_ac].glaq038) THEN   #160503-00025#2 add AND NOT cl_null(g_glaq_d[l_ac].glaq038) lujh
      CALL s_voucher_free_account_desc(g_glad0261,g_glaq_d[l_ac].glaq038) RETURNING g_glaq_d[l_ac].glaq038_desc  #160503-00025#2 add change l_glad0261 to g_glad0261 lujh
   END IF
   #end add-point
   
 
 
   #add-point:detail_show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq770_filter()
   {<Local define>}
   {</Local define>}
   #add-point:filter段define

   #end add-point    
   
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON glaq002,glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,glaq023,glaq024, 
          glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,glaqdocno,glaq005,glaq006,glaq039,glaq040, 
          glaq041,glaq042,glaq043,glaq044,glapdocdt #160302-00006#1 add
                          FROM s_detail1[1].b_glaq002,s_detail1[1].b_glaq017,s_detail1[1].b_glaq018, 
                              s_detail1[1].b_glaq019,s_detail1[1].b_glaq020,s_detail1[1].b_glaq021,s_detail1[1].b_glaq022, 
                              s_detail1[1].b_glaq023,s_detail1[1].b_glaq024,s_detail1[1].b_glaq051,s_detail1[1].b_glaq052,
                              s_detail1[1].b_glaq053,s_detail1[1].b_glaq025, 
                              s_detail1[1].b_glaq027,s_detail1[1].b_glaq028,s_detail1[1].glaqdocno,s_detail1[1].glaq005, 
                              s_detail1[1].glaq006,s_detail1[1].glaq039, 
                              s_detail1[1].glaq040,s_detail1[1].glaq041,s_detail1[1].glaq042,s_detail1[1].glaq043, 
                              s_detail1[1].glaq044,#160302-00006#1 modify
                              s_detail1[1].glapdocdt #160302-00006#1 add
#                              s_detail1[1].b_glaq027,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028, 
#                              s_detail1[1].b_glaq028,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028, 
#                              s_detail1[1].b_glaq028,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028,s_detail1[1].b_glaq028, 
#                             s_detail1[1].b_glaq028         #原代码错误
                
       BEFORE CONSTRUCT
#saki       CALL cl_qbe_init()
       #160302-00006#1 add-- str
         ON ACTION controlp INFIELD b_glaq017
            #add-point:ON ACTION controlp INFIELD b_glaq017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq017  #顯示到畫面上
            NEXT FIELD b_glaq017                     #返回原欄位
    
       
         #----<<b_glaq018>>----
         #Ctrlp:construct.c.page1.b_glaq018
         ON ACTION controlp INFIELD b_glaq018
            #add-point:ON ACTION controlp INFIELD b_glaq018
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y'"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq018  #顯示到畫面上
            NEXT FIELD b_glaq018                     #返回原欄位
    
         #----<<b_glaq019>>----
         #Ctrlp:construct.c.page1.b_glaq019
         ON ACTION controlp INFIELD b_glaq019
            #add-point:ON ACTION controlp INFIELD b_glaq019
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq019  #顯示到畫面上
            NEXT FIELD b_glaq019                     #返回原欄位
    
            #END add-point
            
 
         #----<<b_glaq020>>----
         #Ctrlp:construct.c.page1.b_glaq020
         ON ACTION controlp INFIELD b_glaq020
            #add-point:ON ACTION controlp INFIELD b_glaq020
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_287()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq020  #顯示到畫面上
            NEXT FIELD b_glaq020                     #返回原欄位
    
            #END add-point
            
 
         #----<<b_glaq021>>----
         #Ctrlp:construct.c.page1.b_glaq021
         ON ACTION controlp INFIELD b_glaq021
            #add-point:ON ACTION controlp INFIELD b_glaq021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq021  #顯示到畫面上
            NEXT FIELD b_glaq021                     #返回原欄位
    
 
            #END add-point
            
 
         #----<<b_glaq022>>----
         #Ctrlp:construct.c.page1.b_glaq022
         ON ACTION controlp INFIELD b_glaq022
            #add-point:ON ACTION controlp INFIELD b_glaq022
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq022  #顯示到畫面上
            NEXT FIELD b_glaq022                     #返回原欄位
    
 
            #END add-point
            
 
         #----<<b_glaq023>>----
         #Ctrlp:construct.c.page1.b_glaq023
         ON ACTION controlp INFIELD b_glaq023
            #add-point:ON ACTION controlp INFIELD b_glaq023
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_281()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq023  #顯示到畫面上
            NEXT FIELD b_glaq023                     #返回原欄位
    
            #END add-point
            
 
         #----<<b_glaq024>>----
         #Ctrlp:construct.c.page1.b_glaq024
         ON ACTION controlp INFIELD b_glaq024
            #add-point:ON ACTION controlp INFIELD b_glaq024
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq024  #顯示到畫面上
            NEXT FIELD b_glaq024                     #返回原欄位
    
 
            #END add-point
            
 
         #----<<b_glaq025>>----
         #Ctrlp:construct.c.page1.b_glaq025
         ON ACTION controlp INFIELD b_glaq025
            #add-point:ON ACTION controlp INFIELD b_glaq025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq025  #顯示到畫面上
            NEXT FIELD b_glaq025                     #返回原欄位
    
 
            #END add-point
            
 
         #----<<b_glaq052>>----
         #Ctrlp:construct.c.page1.b_glaq052
         ON ACTION controlp INFIELD b_glaq052
            #add-point:ON ACTION controlp INFIELD b_glaq052
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " oojdstus='Y' "
            CALL q_oojd001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq052  #顯示到畫面上
            NEXT FIELD b_glaq052                     #返回原欄位
    
 
         ON ACTION controlp INFIELD b_glaq053
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002_2002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq053  #顯示到畫面上
            NEXT FIELD b_glaq053                     #返回原欄位
      
 
     
 
         #Ctrlp:construct.c.page1.b_glaq027
         ON ACTION controlp INFIELD b_glaq027
            #add-point:ON ACTION controlp INFIELD b_glaq027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.state = 'c'
            CALL q_pjba001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq027     #顯示到畫面上
            NEXT FIELD b_glaq027
            #END add-point
 
 
         #Ctrlp:construct.c.page1.b_glaq028
         ON ACTION controlp INFIELD b_glaq028
            #add-point:ON ACTION controlp INFIELD b_glaq028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = "pjbb012 ='1'"
            CALL q_pjbb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq028  #顯示到畫面上
 
            NEXT FIELD b_glaq028 
            
            
             ON ACTION controlp INFIELD b_glaq002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND glac006 = '1'"
            CALL aglt310_04()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glaq002  #顯示到畫面上
            NEXT FIELD b_glaq002                     #返回原欄位
   
           
         ON ACTION controlp INFIELD glaqdocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glapdocno()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaqdocno  #顯示到畫面上
            NEXT FIELD glaqdocno                     #返回原欄位  
            
         ON ACTION controlp INFIELD glaq005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO glaq005  #顯示到畫面上
            NEXT FIELD glaq005                     #返回原欄位        
                #160302-00006#1 add-- end
                
            DISPLAY aglq770_filter_parser('glaq002') TO s_detail1[1].b_glaq002
            DISPLAY aglq770_filter_parser('glaq017') TO s_detail1[1].b_glaq017
            DISPLAY aglq770_filter_parser('glaq018') TO s_detail1[1].b_glaq018
            DISPLAY aglq770_filter_parser('glaq019') TO s_detail1[1].b_glaq019
            DISPLAY aglq770_filter_parser('glaq020') TO s_detail1[1].b_glaq020
            DISPLAY aglq770_filter_parser('glaq021') TO s_detail1[1].b_glaq021
            DISPLAY aglq770_filter_parser('glaq022') TO s_detail1[1].b_glaq022
            DISPLAY aglq770_filter_parser('glaq023') TO s_detail1[1].b_glaq023
            DISPLAY aglq770_filter_parser('glaq024') TO s_detail1[1].b_glaq024
            DISPLAY aglq770_filter_parser('glaq051') TO s_detail1[1].b_glaq051
            DISPLAY aglq770_filter_parser('glaq052') TO s_detail1[1].b_glaq052
            DISPLAY aglq770_filter_parser('glaq053') TO s_detail1[1].b_glaq053
            DISPLAY aglq770_filter_parser('glaq025') TO s_detail1[1].b_glaq025
            DISPLAY aglq770_filter_parser('glaq027') TO s_detail1[1].b_glaq027
            DISPLAY aglq770_filter_parser('glaq028') TO s_detail1[1].b_glaq028
           #160302-00006#1 add --str
            DISPLAY aglq770_filter_parser('glaqdocno') TO s_detail1[1].glaqdocno
            DISPLAY aglq770_filter_parser('glaq005') TO s_detail1[1].glaq005
            DISPLAY aglq770_filter_parser('glaq006') TO s_detail1[1].glaq006
            DISPLAY aglq770_filter_parser('glaq039') TO s_detail1[1].glaq039
            DISPLAY aglq770_filter_parser('glaq040') TO s_detail1[1].glaq040
            DISPLAY aglq770_filter_parser('glaq041') TO s_detail1[1].glaq041
            DISPLAY aglq770_filter_parser('glaq042') TO s_detail1[1].glaq042
            DISPLAY aglq770_filter_parser('glaq043') TO s_detail1[1].glaq043
            DISPLAY aglq770_filter_parser('glaq044') TO s_detail1[1].glaq044
            DISPLAY aglq770_filter_parser('glapdocdt') TO s_detail1[1].glapdocdt
            #160302-00006#1add--end
#             DISPLAY aglq770_filter_parser('glaqdocno') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq005') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq006') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq003') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq004') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq039') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq040') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq041') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq042') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq043') TO s_detail1[1].b_glaq028
#            DISPLAY aglq770_filter_parser('glaq044') TO s_detail1[1].b_glaq028
 
 
      END CONSTRUCT
 
      #add-point:filter段add_cs

      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

         #end add-point  
 
      ON ACTION accept
         ACCEPT DIALOG 
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
 
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL aglq770_filter_show('glaq002','b_glaq002')
   CALL aglq770_filter_show('glaq017','b_glaq017')
   CALL aglq770_filter_show('glaq018','b_glaq018')
   CALL aglq770_filter_show('glaq019','b_glaq019')
   CALL aglq770_filter_show('glaq020','b_glaq020')
   CALL aglq770_filter_show('glaq021','b_glaq021')
   CALL aglq770_filter_show('glaq022','b_glaq022')
   CALL aglq770_filter_show('glaq023','b_glaq023')
   CALL aglq770_filter_show('glaq024','b_glaq024')
   CALL aglq770_filter_show('glaq051','b_glaq051')
   CALL aglq770_filter_show('glaq052','b_glaq052')
   CALL aglq770_filter_show('glaq053','b_glaq053')
   CALL aglq770_filter_show('glaq025','b_glaq025')
   CALL aglq770_filter_show('glaq027','b_glaq027')
   CALL aglq770_filter_show('glaq028','b_glaq028')
   #160302-00006#1 add-str
  CALL aglq770_filter_show('glaqdocno','glaqdocno')
   CALL aglq770_filter_show('glaq005','glaq005')
   CALL aglq770_filter_show('glaq006','glaq006')
   CALL aglq770_filter_show('glaq039','glaq039')
   CALL aglq770_filter_show('glaq040','glaq040')
   CALL aglq770_filter_show('glaq041','glaq041')
   CALL aglq770_filter_show('glaq042','glaq042')
   CALL aglq770_filter_show('glaq043','glaq043')
   CALL aglq770_filter_show('glaq044','glaq044')
   CALL aglq770_filter_show('glapdocdt','glapdocdt')
   #160302-00006#1 add-end
#   CALL aglq770_filter_show('glaqdocno','b_glaq028')
#   CALL aglq770_filter_show('glaq005','b_glaq028')
#   CALL aglq770_filter_show('glaq006','b_glaq028')
#   CALL aglq770_filter_show('glaq003','b_glaq028')
#   CALL aglq770_filter_show('glaq004','b_glaq028')
#   CALL aglq770_filter_show('glaq039','b_glaq028')
#   CALL aglq770_filter_show('glaq040','b_glaq028')
#   CALL aglq770_filter_show('glaq041','b_glaq028')
#   CALL aglq770_filter_show('glaq042','b_glaq028')
#   CALL aglq770_filter_show('glaq043','b_glaq028')
#   CALL aglq770_filter_show('glaq044','b_glaq028')
 
   
    
    CALL aglq770_b_fill1()
  
  
    
#   CALL aglq770_b_fill()
#   CALL aglq770_fetch()
#   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq770_filter_parser(ps_field)
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
   #add-point:filter段define
   
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
 
{<section id="aglq770.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq770_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq770_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.insert" >}
#+ insert
PRIVATE FUNCTION aglq770_insert()
   #add-point:insert段define
   
   #end add-point
 
   #add-point:insert段control
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq770.modify" >}
#+ modify
PRIVATE FUNCTION aglq770_modify()
   #add-point:modify段define
   
   #end add-point
 
   #add-point:modify段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq770_reproduce()
   #add-point:reproduce段define
   
   #end add-point
 
   #add-point:reproduce段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.delete" >}
#+ delete
PRIVATE FUNCTION aglq770_delete()
   #add-point:delete段define
   
   #end add-point
 
   #add-point:delete段control
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq770.other_function" >}

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq770_create_temp_table()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_create_temp_table()
   DROP TABLE aglq770_tmp
   CREATE TEMP TABLE aglq770_tmp(
   seq          LIKE glaq_t.glaqseq,
   glaq002      LIKE glaq_t.glaq002,
   glaq017      LIKE glaq_t.glaq017,
   glaq018      LIKE glaq_t.glaq018,
   glaq019      LIKE glaq_t.glaq019,
   glaq020      LIKE glaq_t.glaq020,
   glaq021      LIKE glaq_t.glaq021,
   glaq022      LIKE glaq_t.glaq022,
   glaq023      LIKE glaq_t.glaq023,
   glaq024      LIKE glaq_t.glaq024,
   glaq051      LIKE glaq_t.glaq051,
   glaq052      LIKE glaq_t.glaq052,
   glaq053      LIKE glaq_t.glaq053,
   glaq025      LIKE glaq_t.glaq025,
   glaq027      LIKE glaq_t.glaq027,
   glaq028      LIKE glaq_t.glaq028,
   glaq029      LIKE glaq_t.glaq029,
   glaq030      LIKE glaq_t.glaq030,
   glaq031      LIKE glaq_t.glaq031,
   glaq032      LIKE glaq_t.glaq032,
   glaq033      LIKE glaq_t.glaq033,
   glaq034      LIKE glaq_t.glaq034,
   glaq035      LIKE glaq_t.glaq035,
   glaq036      LIKE glaq_t.glaq036,
   glaq037      LIKE glaq_t.glaq037,
   glaq038      LIKE glaq_t.glaq038,
   glapdocdt    LIKE glap_t.glapdocdt,
   glaqdocno    LIKE glaq_t.glaqdocno,
   glaq001      LIKE glaq_t.glaq001,
   glap004      LIKE glap_t.glap004,
   style        LIKE type_t.chr1, 
   glaq005      LIKE glaq_t.glaq005,
   glaq006      LIKE glaq_t.glaq006,
   glaq010d     LIKE glaq_t.glaq010,
   glaq010c     LIKE glaq_t.glaq010,
   glaq003      LIKE glaq_t.glaq003, 
   glaq004      LIKE glaq_t.glaq004, 
   glaq039      LIKE glaq_t.glaq039,
   glaq040      LIKE glaq_t.glaq040, 
   glaq041      LIKE glaq_t.glaq041,
   glaq042      LIKE glaq_t.glaq042,   
   glaq043      LIKE glaq_t.glaq043, 
   glaq044      LIKE glaq_t.glaq044, 
   state        LIKE type_t.chr1, 
   amt          LIKE glaq_t.glaq003,
   amt1         LIKE glaq_t.glaq003,
   amt2         LIKE glaq_t.glaq003,
   amt3         LIKE glaq_t.glaq003)
END FUNCTION

################################################################################
# Descriptions...: 設置本位幣二、別你幣三顯示否
# Memo...........:
# Usage..........: CALL aglq770_set_curr_show()
# Date & Author..: 2014/03/13 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_set_curr_show()
   #顯示本位幣二
   IF tm.ctype='1' THEN
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,amt2",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,amt2",FALSE)
   END IF
   #顯示本位幣三
   IF tm.ctype='2' THEN
      CALL cl_set_comp_visible("glaq042,glaq043,glaq044,amt3",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaq042,glaq043,glaq044,amt3",FALSE)
   END IF
   #全部
   IF tm.ctype='3' THEN
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,amt2,amt3",TRUE)
      CALL cl_set_comp_visible("glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,amt2,amt3",TRUE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 獲取帳套相關資料
# Memo...........:
# Usage..........: CALL aglq770_glaald_desc(p_glaald)
# Input parameter: p_glaald   帳套
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_glaald_desc(p_glaald)
   DEFINE  p_glaald    LIKE glaa_t.glaald
   
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = p_glaald 
    CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_glaald_desc=g_rtn_fields[1]
    #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa002,glaa003,glaa004,glaa013,
          glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,
          glaa021,glaa022
     INTO g_glaacomp,g_glaa001,g_glaa002,g_glaa003,g_glaa004,g_glaa013,
          g_glaa015,g_glaa016,g_glaa017,g_glaa018,g_glaa019,g_glaa020,
          g_glaa021,g_glaa022
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_glaacomp_desc= g_rtn_fields[1]
  
   #本位幣二
   IF g_glaa015='Y' THEN
      CALL cl_set_comp_visible("glaa016",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa016",FALSE)
   END IF
   #本位幣三
   IF g_glaa019='Y' THEN
      CALL cl_set_comp_visible("glaa020",TRUE)
   ELSE
      CALL cl_set_comp_visible("glaa020",FALSE)
   END IF 
   #多本位幣
   CALL cl_set_comp_entry("ctype",TRUE)
   CASE
      WHEN g_glaa015<>'Y' AND g_glaa019<>'Y' 
         CALL cl_set_comp_entry("ctype",FALSE)
         CALL cl_set_combo_scc_part('ctype','9921','0')
#         LET tm.ctype=''
      WHEN g_glaa015='Y' AND g_glaa019<>'Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1')
#         LET tm.ctype='1'
      WHEN g_glaa015<>'Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,2')
#         LET tm.ctype='2'  
      WHEN g_glaa015='Y' AND g_glaa019='Y' 
         CALL cl_set_combo_scc_part('ctype','9921','0,1,2,3')
#         LET tm.ctype='3'
   END CASE
   LET tm.ctype='0'
   CALL aglq770_set_curr_show() #顯示本位幣二、本位幣三
END FUNCTION

################################################################################
# Descriptions...: 抓取數據
# Memo...........:
# Usage..........: CALL aglq770_get_data()
# Date & Author..: 2014/03/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_get_data()
   DEFINE l_pdate_s1       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e1       LIKE glav_t.glav004
   DEFINE l_pdate_s2       LIKE glav_t.glav004 #截止年度+期別對應的起始截止日期
   DEFINE l_pdate_e2       LIKE glav_t.glav004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   DEFINE l_flag           LIKE type_t.num5    #表示是否是完整期別
   DEFINE l_sql,l_sql1,l_sql2   STRING
   DEFINE l_sql3,l_sql4         STRING
   DEFINE l_wc,l_wc2            STRING 
   DEFINE l_glar001        LIKE glar_t.glar001
   DEFINE l_glar012        LIKE glar_t.glar012
   DEFINE l_glar013        LIKE glar_t.glar013
   DEFINE l_glar014        LIKE glar_t.glar014
   DEFINE l_glar015        LIKE glar_t.glar015
   DEFINE l_glar016        LIKE glar_t.glar016
   DEFINE l_glar017        LIKE glar_t.glar017
   DEFINE l_glar018        LIKE glar_t.glar018
   DEFINE l_glar019        LIKE glar_t.glar019
   DEFINE l_glar051        LIKE glar_t.glar051
   DEFINE l_glar052        LIKE glar_t.glar052
   DEFINE l_glar053        LIKE glar_t.glar053
   DEFINE l_glar020        LIKE glar_t.glar020
   DEFINE l_glar022        LIKE glar_t.glar022
   DEFINE l_glar023        LIKE glar_t.glar023
   DEFINE l_glar024        LIKE glar_t.glar024 
   DEFINE l_glar025        LIKE glar_t.glar025
   DEFINE l_glar026        LIKE glar_t.glar026
   DEFINE l_glar027        LIKE glar_t.glar027 
   DEFINE l_glar028        LIKE glar_t.glar028
   DEFINE l_glar029        LIKE glar_t.glar029
   DEFINE l_glar030        LIKE glar_t.glar030 
   DEFINE l_glar031        LIKE glar_t.glar031
   DEFINE l_glar032        LIKE glar_t.glar032
   DEFINE l_glar033        LIKE glar_t.glar033
   DEFINE l_glar002        LIKE glar_t.glar002
   DEFINE l_glar003        LIKE glar_t.glar003
   DEFINE l_glar009        LIKE glar_t.glar009
   DEFINE l_glar010        LIKE glar_t.glar010
   DEFINE l_glar011        LIKE glar_t.glar011
   DEFINE l_glar005        LIKE glar_t.glar005
   DEFINE l_glar006        LIKE glar_t.glar006
   DEFINE l_glar034        LIKE glar_t.glar034
   DEFINE l_glar035        LIKE glar_t.glar035
   DEFINE l_glar036        LIKE glar_t.glar036
   DEFINE l_glar037        LIKE glar_t.glar037
   DEFINE l_state          LIKE type_t.num5
   DEFINE l_amt            LIKE type_t.num20_6 
   DEFINE l_oamt           LIKE type_t.num20_6
   DEFINE l_oamt_d         LIKE type_t.num20_6
   DEFINE l_oamt_c         LIKE type_t.num20_6   
   DEFINE l_amt1           LIKE type_t.num20_6 
   DEFINE l_amt2           LIKE type_t.num20_6 
   DEFINE l_amt3           LIKE type_t.num20_6
   DEFINE l_amt4           LIKE type_t.num20_6 
   DEFINE l_amt5           LIKE type_t.num20_6 
   DEFINE l_amt6           LIKE type_t.num20_6   
   DEFINE l_sum            LIKE type_t.num20_6
   DEFINE l_osum           LIKE type_t.num20_6
   DEFINE l_osum_d         LIKE type_t.num20_6
   DEFINE l_osum_c         LIKE type_t.num20_6    
   DEFINE l_sum1           LIKE type_t.num20_6 
   DEFINE l_sum2           LIKE type_t.num20_6 
   DEFINE l_sum3           LIKE type_t.num20_6
   DEFINE l_sum4           LIKE type_t.num20_6 
   DEFINE l_sum5           LIKE type_t.num20_6 
   DEFINE l_sum6           LIKE type_t.num20_6   
   DEFINE l_period         LIKE glap_t.glap004
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_seq            LIKE type_t.num10
   DEFINE l_str,l_str1,l_str2      STRING
   DEFINE l_str3,l_str4,l_str5     STRING
   DEFINE l_glapdocdt      LIKE glap_t.glapdocdt
   DEFINE l_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_glaq001        LIKE glaq_t.glaq001
   DEFINE l_glaq005        LIKE glaq_t.glaq005
   DEFINE l_glaq006        LIKE glaq_t.glaq006
   DEFINE l_glaq010d       LIKE glaq_t.glaq010
   DEFINE l_glaq010c       LIKE glaq_t.glaq010
   DEFINE l_glaq003        LIKE glaq_t.glaq003
   DEFINE l_glaq004        LIKE glaq_t.glaq004
   DEFINE l_glaq039        LIKE glaq_t.glaq039
   DEFINE l_glaq040        LIKE glaq_t.glaq040
   DEFINE l_glaq041        LIKE glaq_t.glaq041
   DEFINE l_glaq042        LIKE glaq_t.glaq042
   DEFINE l_glaq043        LIKE glaq_t.glaq043
   DEFINE l_glaq044        LIKE glaq_t.glaq044
   DEFINE l_state_qc       LIKE type_t.num5
   DEFINE l_oamt_qc        LIKE type_t.num20_6 
   DEFINE l_amt1_qc        LIKE type_t.num20_6 
   DEFINE l_amt2_qc        LIKE type_t.num20_6 
   DEFINE l_amt3_qc        LIKE type_t.num20_6
   DEFINE l_glav004        LIKE glav_t.glav004
   DEFINE l_glav004_m      LIKE glav_t.glav004
   DEFINE l_glav004_e      LIKE glav_t.glav004
   DEFINE l_pdate_s3       LIKE glav_t.glav004 #年度+期別對應的起始截止日期
   DEFINE l_pdate_e3       LIKE glav_t.glav004
   DEFINE l_wc_glaq002     STRING
   DEFINE l_glar           DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位 
          glar001          LIKE glar_t.glar001,
          glar009          LIKE glar_t.glar009,
          glar012          LIKE glar_t.glar012,
          glar013          LIKE glar_t.glar013,
          glar014          LIKE glar_t.glar014,
          glar015          LIKE glar_t.glar015,
          glar016          LIKE glar_t.glar016,
          glar017          LIKE glar_t.glar017,
          glar018          LIKE glar_t.glar018,
          glar019          LIKE glar_t.glar019,
          glar051          LIKE glar_t.glar051,
          glar052          LIKE glar_t.glar052,
          glar053          LIKE glar_t.glar053,
          glar020          LIKE glar_t.glar020,
          glar022          LIKE glar_t.glar022,
          glar023          LIKE glar_t.glar023,
          glar024          LIKE glar_t.glar024, 
          glar025          LIKE glar_t.glar025,
          glar026          LIKE glar_t.glar026,
          glar027          LIKE glar_t.glar027, 
          glar028          LIKE glar_t.glar028,
          glar029          LIKE glar_t.glar029,
          glar030          LIKE glar_t.glar030, 
          glar031          LIKE glar_t.glar031,
          glar032          LIKE glar_t.glar032,
          glar033          LIKE glar_t.glar033
   END RECORD
   DEFINE l_flag_amt       LIKE type_t.num5  #表示是否有期初後者期末金額
   DEFINE l_glac002        LIKE glac_t.glac002
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_period_max     LIKE type_t.num5
   DEFINE l_glaq003_s      LIKE glaq_t.glaq003
   DEFINE l_glaq004_s      LIKE glaq_t.glaq004
   DEFINE l_glaq039_s      LIKE glaq_t.glaq039
   DEFINE l_glaq040_s      LIKE glaq_t.glaq040
   DEFINE l_glaq041_s      LIKE glaq_t.glaq041
   DEFINE l_glaq042_s      LIKE glaq_t.glaq042
   DEFINE l_glaq043_s      LIKE glaq_t.glaq043
   DEFINE l_glaq044_s      LIKE glaq_t.glaq044
   DEFINE l_glaq010d_s     LIKE glaq_t.glaq010
   DEFINE l_glaq010c_s     LIKE glaq_t.glaq010
   DEFINE l_flag_fix       LIKE type_t.num5    #表示是否勾選核算項或幣別
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_str6,l_str7    STRING
   DEFINE l_glap007        LIKE glap_t.glap007 #151204-00013#6 add
   DEFINE l_glac007        LIKE glac_t.glac007 #151204-00013#6 add
   #160503-00025#2--add--str--lujh
   DEFINE l_glaq001_1      LIKE glaq_t.glaq001
   DEFINE l_glaq001_2      LIKE glaq_t.glaq001
   DEFINE l_glaq001_3      LIKE glaq_t.glaq001
   #160503-00025#2--add--end--lujh
   #160511-00006#4--add--str--
   DEFINE l_year_osum      LIKE type_t.num20_6
   DEFINE l_year_sum1      LIKE type_t.num20_6
   DEFINE l_year_sum2      LIKE type_t.num20_6
   DEFINE l_year_sum3      LIKE type_t.num20_6
   #160511-00006#4--add--end
   
   #刪除臨時表中資料
   DELETE FROM aglq770_tmp
   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.speriod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s1,l_pdate_e1,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF

   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.eperiod) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s2,l_pdate_e2,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   #160503-00025#2--add--str--lujh
   LET l_glaq001_1 = s_desc_gzcbl004_desc('9927','1')
   LET l_glaq001_2 = s_desc_gzcbl004_desc('9927','2')
   LET l_glaq001_3 = s_desc_gzcbl004_desc('9927','3')
   #160503-00025#2--add--end--lujh

   #判斷是否是整期間查詢
   IF tm.sdate=l_pdate_s1 AND tm.edate=l_pdate_e2 THEN
      LET l_flag=TRUE
   ELSE
      LET l_flag=FALSE
   END IF
   IF cl_null(g_wc_glaq002) THEN
      LET g_wc_glaq002=" 1=1"
   END IF
   LET l_wc_glaq002=cl_replace_str(g_wc_glaq002,'glaq002','glar001')
   LET l_wc=cl_replace_str(g_wc,'glaq017','glar012')
   LET l_wc=cl_replace_str(l_wc,'glaq018','glar013')
   LET l_wc=cl_replace_str(l_wc,'glaq019','glar014')
   LET l_wc=cl_replace_str(l_wc,'glaq020','glar015')
   LET l_wc=cl_replace_str(l_wc,'glaq021','glar016')
   LET l_wc=cl_replace_str(l_wc,'glaq022','glar017')
   LET l_wc=cl_replace_str(l_wc,'glaq023','glar018')
   LET l_wc=cl_replace_str(l_wc,'glaq024','glar019')
   LET l_wc=cl_replace_str(l_wc,'glaq051','glar051')
   LET l_wc=cl_replace_str(l_wc,'glaq052','glar052')
   LET l_wc=cl_replace_str(l_wc,'glaq053','glar053')
   LET l_wc=cl_replace_str(l_wc,'glaq025','glar020')
   LET l_wc=cl_replace_str(l_wc,'glaq027','glar022')
   LET l_wc=cl_replace_str(l_wc,'glaq028','glar023')
   #自由核算項
   LET l_wc=cl_replace_str(l_wc,'glaq029','glar024')
   LET l_wc=cl_replace_str(l_wc,'glaq030','glar025')
   LET l_wc=cl_replace_str(l_wc,'glaq031','glar026')
   LET l_wc=cl_replace_str(l_wc,'glaq032','glar027')
   LET l_wc=cl_replace_str(l_wc,'glaq033','glar028')
   LET l_wc=cl_replace_str(l_wc,'glaq034','glar029')
   LET l_wc=cl_replace_str(l_wc,'glaq035','glar030')
   LET l_wc=cl_replace_str(l_wc,'glaq036','glar031')
   LET l_wc=cl_replace_str(l_wc,'glaq037','glar032')
   LET l_wc=cl_replace_str(l_wc,'glaq038','glar033')
   
   LET l_wc=l_wc_glaq002," AND ",l_wc
   
   LET l_wc2=cl_replace_str(g_wc2,'glaq005','glar009')
   
   IF cl_null(l_wc2) THEN 
      LET l_wc2 = " 1=1 "
   END IF
   IF cl_null(g_wc1) THEN
      LET g_wc1 = " 1=1 "
   END IF 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1 "
   END IF
   
   #當錄入單號、單據日期條件時抓取傳票資料
   IF g_wc1<>' 1=1' AND NOT cl_null(g_wc1) THEN
      LET l_flag=FALSE
   END IF   
   
   #顯示外幣否
   IF tm.curr_o='Y' THEN
      LET l_str=",glar009"
      LET l_str1=",glaq005"
      LET l_str2=",glaq005 glar009"
   ELSE
      LET l_str=",''"
      LET l_str1=",''"
      LET l_str2=",''"
   END IF
   
   #科目条件
   LET l_wc_glaq002=cl_replace_str(g_wc_glaq002,'glaq002','glac002')
   #顯示統制科目否
   IF tm.show_acc<>'Y' THEN
      LET l_sql1=l_sql1," AND glac003<>'1' "
   END IF
   #科目層級
   IF NOT cl_null(tm.glac005) THEN
      LET l_sql1=l_sql1," AND glac005<=",tm.glac005
   END IF
   #含內部管理科目否
   IF tm.glac009<>'Y' THEN
      LET l_sql1=l_sql1," AND glac009<>'Y'"
   END IF
#151204-00013#7--mark--str--
#   #顯示月結CE憑證否
#   IF tm.show_ce<>'Y' THEN
#      LET l_sql2=l_sql2," AND glap007<>'CE' "
#      LET l_sql3="'CE'"
#   END IF
#151204-00013#7--mark--end
   #顯示年結YE憑證否
   IF tm.show_ye<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'YE' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'YE'"
      ELSE
         LET l_sql3="'YE'" 
      END IF
   END IF
   #150827-00036#2--add--str--
   #顯示AD審計調整傳票否
   IF tm.show_ad<>'Y' THEN
      LET l_sql2=l_sql2," AND glap007<>'AD' "
      IF NOT cl_null(l_sql3) THEN
         LET l_sql3=l_sql3,",'AD'"
      ELSE
         LET l_sql3="'AD'" 
      END IF
   END IF
   #150827-00036#2--add--end
   IF NOT cl_null(l_sql3) THEN
      LET l_sql3=" AND glap007 IN (",l_sql3,")"
   END IF 
   #單據狀態
   CASE
      WHEN tm.stus='1'
         LET l_sql4=l_sql4," AND glapstus='S' "
      WHEN tm.stus='2'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y') "
      WHEN tm.stus='3'
         LET l_sql4=l_sql4," AND glapstus IN ('S','Y','N') "
   END CASE
   
   #抓出所有符合條件的會計科目
   LET g_sql="SELECT DISTINCT glac002 FROM glac_t",
             " WHERE glacent=",g_enterprise,
             "   AND glac001='",g_glaa004,"' AND ",l_wc_glaq002,l_sql1,
             " ORDER BY glac002"
   PREPARE aglq770_sel_glac_pr FROM g_sql
   DECLARE aglq770_sel_glac_cs CURSOR FOR aglq770_sel_glac_pr
   
   #核算項
   CALL aglq770_fix_acc_get_sql() RETURNING l_str3,l_str4,l_str5,l_str6,l_str7
   #整期間&含月結傳票&含年結傳票&審計調整傳票
   IF l_flag=TRUE AND tm.show_ce='Y' AND tm.show_ye='Y' AND tm.syear=tm.eyear AND tm.show_ad='Y' THEN #150827-00036#2 add 'tm.show_ad'
      LET g_sql="(SELECT DISTINCT glar001",l_str,l_str3,
                "   FROM glar_t",
                "  WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' AND glar001= ? "
#      IF tm.syear<>tm.eyear THEN
#         LET g_sql=g_sql," AND ((glar002=",tm.syear," AND glar003>=",tm.speriod,") ",
#                         "  OR (glar002=",tm.eyear," AND glar003<=",tm.eperiod," )) "
#      ELSE
         LET g_sql=g_sql," AND glar002=",tm.syear,
                         " AND glar003 <= ",tm.eperiod
#      END IF
      
     #LET g_sql=g_sql,l_str6," AND ",l_wc," AND ",l_wc2,")"   #150908 by 03538 mark 
      LET g_sql=g_sql," AND ",l_wc," AND ",l_wc2,")"          #150908 by 03538      

      #單據狀態      
      IF tm.stus MATCHES '[23]' THEN
         LET g_sql=g_sql,
                   " UNION ALL ",
                   "(SELECT DISTINCT glaq002 glar001",l_str2,l_str5,
                   "   FROM glaq_t",
                   "  INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   "  WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' AND glaq002=? ",
                   "    AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
         CASE
             WHEN tm.stus='2'
                LET g_sql=g_sql," AND glapstus='Y'"
             WHEN tm.stus='3'
                LET g_sql=g_sql," AND glapstus IN ('Y','N')"
         END CASE 
         LET g_sql=g_sql,l_sql2,l_str7," AND ",g_wc," AND ",g_wc1," AND ",g_wc2,")"
      END IF
      LET g_sql="SELECT DISTINCT glar001",l_str,l_str3,
                "  FROM (",g_sql,")",
                "  ORDER BY glar001",l_str3,l_str
   ELSE
      LET g_sql="SELECT DISTINCT glaq002",l_str1,l_str4,
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                "  LEFT OUTER JOIN glac_t ON glacent=glaqent AND glac002=glaq002 AND glac001='",g_glaa004,"'",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' AND glaq002=? ",
                "   AND glapdocdt BETWEEN '",tm.sdate,"' AND '",tm.edate,"'"
      LET g_sql=g_sql,l_sql1,l_sql2,l_sql4,l_str7," AND ",g_wc," AND ",g_wc1," AND ",g_wc2,
                " ORDER BY glaq002",l_str4,l_str1
   END IF
   PREPARE aglq770_sel_fix_pr FROM g_sql
   DECLARE aglq770_sel_fix_cr CURSOR FOR aglq770_sel_fix_pr 

   CALL cl_err_collect_init()
   LET l_success = TRUE
   LET l_seq=1
   #起始年度第一天
   SELECT MIN(glav004) INTO l_glav004 FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   #抓取上一期最後一天
   LET l_period=tm.speriod-1 #上期
   SELECT MAX(glav004) INTO l_glav004_m FROM glav_t
    WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear AND glav006=l_period
   #获取期初截止日期
   IF tm.sdate=l_pdate_s1 THEN
      LET l_glav004_e=l_glav004_m
   ELSE
      LET l_glav004_e=tm.sdate-1
   END IF
   
   IF tm.curr_o='Y' THEN
      LET l_flag_fix=TRUE
   ELSE
      LET l_num =l_str3.getIndexOf('g',1)
      IF l_num>0 THEN 
         LET l_flag_fix=TRUE #表示勾選了顯示原幣或核算項
      END IF
   END IF
   
   LET l_i=1 
   CALL l_glar.clear()
   FOREACH aglq770_sel_glac_cs INTO l_glac002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH aglq770_sel_glac_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      IF l_flag_fix=TRUE THEN
         #勾選顯示原幣及核算项等
         IF l_flag=TRUE AND tm.show_ce='Y' AND tm.show_ye='Y' AND tm.show_ad='Y'  #150827-00036#2 add 'tm.show_ad'
            AND tm.syear=tm.eyear AND tm.stus MATCHES '[23]' 
         THEN 
            OPEN aglq770_sel_fix_cr USING l_glac002,l_glac002
         ELSE
            OPEN aglq770_sel_fix_cr USING l_glac002
         END IF
         FOREACH aglq770_sel_fix_cr INTO l_glar[l_i].glar001,l_glar[l_i].glar009,l_glar[l_i].glar012,
                                         l_glar[l_i].glar013,l_glar[l_i].glar014,l_glar[l_i].glar015,
                                         l_glar[l_i].glar016,l_glar[l_i].glar017,l_glar[l_i].glar018,
                                         l_glar[l_i].glar019,l_glar[l_i].glar051,l_glar[l_i].glar052,
                                         l_glar[l_i].glar053,l_glar[l_i].glar020,l_glar[l_i].glar022,
                                         l_glar[l_i].glar023,l_glar[l_i].glar024,l_glar[l_i].glar025,
                                         l_glar[l_i].glar026,l_glar[l_i].glar027,l_glar[l_i].glar028,
                                         l_glar[l_i].glar029,l_glar[l_i].glar030,l_glar[l_i].glar031,
                                         l_glar[l_i].glar032,l_glar[l_i].glar033
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq770_sel_fix_cr'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_i=l_i+1
         END FOREACH
      ELSE
         LET l_glar[l_i].glar001 = l_glac002
         LET l_i=l_i+1
      END IF
   END FOREACH
   IF cl_null(l_glar[l_i].glar001) THEN
      LET l_i= l_i - 1
      CALL l_glar.deleteElement(l_glar.getLength())
   END IF
   
   FOR l_i=1 TO l_glar.getLength()
      LET l_flag_amt = FALSE 
      LET l_glar001=l_glar[l_i].glar001
      LET l_glar009=l_glar[l_i].glar009
      LET l_glar012=l_glar[l_i].glar012
      LET l_glar013=l_glar[l_i].glar013
      LET l_glar014=l_glar[l_i].glar014
      LET l_glar015=l_glar[l_i].glar015
      LET l_glar016=l_glar[l_i].glar016
      LET l_glar017=l_glar[l_i].glar017
      LET l_glar018=l_glar[l_i].glar018
      LET l_glar019=l_glar[l_i].glar019
      LET l_glar051=l_glar[l_i].glar051
      LET l_glar052=l_glar[l_i].glar052
      LET l_glar053=l_glar[l_i].glar053
      LET l_glar020=l_glar[l_i].glar020
      LET l_glar022=l_glar[l_i].glar022
      LET l_glar023=l_glar[l_i].glar023
      LET l_glar024=l_glar[l_i].glar024
      LET l_glar025=l_glar[l_i].glar025
      LET l_glar026=l_glar[l_i].glar026
      LET l_glar027=l_glar[l_i].glar027
      LET l_glar028=l_glar[l_i].glar028
      LET l_glar029=l_glar[l_i].glar029
      LET l_glar030=l_glar[l_i].glar030
      LET l_glar031=l_glar[l_i].glar031
      LET l_glar032=l_glar[l_i].glar032
      LET l_glar033=l_glar[l_i].glar033
      #核算项组合条件
      CALL aglq770_fix_acc_sql(l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                               l_glar018,l_glar019,l_glar020,l_glar022,l_glar023,l_glar051,l_glar052,l_glar053,
                               l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,
                               l_glar029,l_glar030,l_glar031,l_glar032,l_glar033)
      RETURNING l_str,l_str1
      
      #期初餘額（整期）
      LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=? AND glar003<=? ",l_str
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glar009=? "
      END IF
      PREPARE aglq770_sel_pr1 FROM l_sql
      #160503-00037#7 by 07900  --add-str
      #本年累計（整期）
      LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006),",
                "       SUM(glar034),SUM(glar035),SUM(glar036),SUM(glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=? AND glar003<=? AND glar003<>0 ",l_str
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glar009=? "
      END IF
      PREPARE aglq770_sel_pr01 FROM l_sql
      #160503-00037#7 by 07900  --add-end
      
      #160511-00006#4--add--str--
      #年初余额
      LET l_sql="SELECT SUM(glar010-glar011),SUM(glar005-glar006),",
                "       SUM(glar034-glar035),SUM(glar036-glar037) FROM glar_t",    
                " WHERE glarent=",g_enterprise," AND glarld='",g_glaald,"' ",
                "   AND glar001=? AND glar002=? AND glar003=0 ",l_str
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glar009=? "
      END IF
      PREPARE aglq770_year_sum_pr FROM l_sql
      #160511-00006#4--add--end
      
      #期初：抓取YE、AD憑證金額
      LET l_sql="SELECT SUM(CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),",
                "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                "   AND glaq002=? ",
                "   AND glap002=? AND glap004<=? ",l_str1,
                "   AND glapstus='S'",
                "   AND ",g_wc,l_sql3
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glaq005=? "
      END IF
      PREPARE aglq770_sel_pr2 FROM l_sql
      
      #151204-00013#7--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #期初：抓取CE、XC憑證金額
         LET l_sql="SELECT SUM(CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),",
                   "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                   "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                   "       SUM(glaq043),SUM(glaq044) ",
                   "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                   " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                   "   AND glaq002=? ",
                   "   AND glap002=? AND glap004<=? ",l_str1,
                   "   AND ",g_wc,l_sql4,
                   "   AND (",
                   "        (glap007='CE' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='6' AND glac002=? ))",
                   "         OR ",
                   "        (glap007='XC' AND glaq002 IN (SELECT glac002 FROM glac_t ",
                   "                                       WHERE glacent=",g_enterprise," AND glac001='",g_glaa004,"'",
                   "                                         AND glac007='5' AND glac002=? ))",
                   "       )"
         IF tm.curr_o='Y' THEN
            LET l_sql=l_sql," AND glaq005=? "
         END IF
         PREPARE aglq770_sel_pr2_1 FROM l_sql
      END IF
      #151204-00013#7--add--end
      
      #破期或狀態=2：含已審核、3：全部
      LET l_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END),",
                "       SUM(CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                "       SUM(glaq003),SUM(glaq004),SUM(glaq040),SUM(glaq041),",
                "       SUM(glaq043),SUM(glaq044) ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                "   AND glaq002=? ",
                "   AND glapdocdt BETWEEN ? AND ? ",l_str1,
                "   AND ",g_wc,l_sql2,l_sql4
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glaq005=? "
      END IF
      PREPARE aglq770_sel_pr3 FROM l_sql
      
      #明細傳票資料
      LET l_sql="SELECT glapdocdt,glapdocno,glap007,glaq001,glaq005,glaq006,",  #151204-00013#7 add glap007
                "       (CASE WHEN glaq003>0 THEN glaq010 ELSE 0 END),",  #zhouxm160914 mark   #radd by pulf 170516
               # "   glaq003, ",#zhouxm160914 add     #mark by pulf 170516
                "       (CASE WHEN glaq003=0 THEN glaq010 ELSE 0 END),",
                "       glaq003,glaq004,glaq039,glaq040,glaq041,glaq042,glaq043,glaq044 ",
                "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
                " WHERE glaqent=",g_enterprise," AND glaqld='",g_glaald,"' ",
                "   AND glaq002=? ",
                "   AND glapdocdt BETWEEN ? AND ? ",l_str1,
                "   AND ",g_wc," AND ",g_wc1," AND ",g_wc2,l_sql2,l_sql4
      IF tm.curr_o='Y' THEN
         LET l_sql=l_sql," AND glaq005=? "
      END IF
      LET l_sql=l_sql,"ORDER BY glapdocno,glapdocdt"
      PREPARE aglq770_sel_pr4 FROM l_sql 
      DECLARE aglq770_sel_cs4 CURSOR FOR aglq770_sel_pr4
   
      #期初餘額
      LET l_oamt_d=0
      LET l_oamt_c=0
      LET l_amt1=0
      LET l_amt2=0
      LET l_amt3=0
      LET l_amt4=0
      LET l_amt5=0
      LET l_amt6=0 
      LET l_osum_d=0
      LET l_osum_c=0
      LET l_sum1=0
      LET l_sum2=0
      LET l_sum3=0
      LET l_sum4=0
      LET l_sum5=0
      LET l_sum6=0
      LET l_state=NULL
      #整期且狀態=1：已過帳
      IF tm.sdate=l_pdate_s1 AND tm.stus='1' THEN
         LET l_period=tm.speriod-1
         IF tm.curr_o='Y' THEN
            EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=l_glar009
         ELSE
            EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=NULL
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq770_sel_pr1','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq770_sel_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
         IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
         #當不包含YE或AD傳票時，減去YE或AD傳票金額
#         IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#7 mark
         IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#7 add
            IF tm.curr_o='Y' THEN
               EXECUTE aglq770_sel_pr2 USING l_glar001,tm.syear,l_period,l_glar009 
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            ELSE
               EXECUTE aglq770_sel_pr2 USING l_glar001,tm.syear,l_period 
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq770_sel_pr2','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq770_sel_pr2'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
            IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
            IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
            IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
            IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
            IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
            IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
            LET l_oamt_d=l_oamt_d-l_osum_d
            LET l_oamt_c=l_oamt_c-l_osum_c
            LET l_amt1=l_amt1-l_sum1
            LET l_amt2=l_amt2-l_sum2
            LET l_amt3=l_amt3-l_sum3
            LET l_amt4=l_amt4-l_sum4
            LET l_amt5=l_amt5-l_sum5
            LET l_amt6=l_amt6-l_sum6
         END IF
      ELSE
         #年初余额
         LET l_period=0
         IF tm.curr_o='Y' THEN
            EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=l_glar009
         ELSE
            EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period 
                                     INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
            LET l_glaq005=NULL
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq770_sel_pr1','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq770_sel_pr1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
         IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
#         LET l_period=tm.speriod-1 #上期  #151231-00004#1 mark
#         IF l_period>0 THEN               #151231-00004#1 mark
         #抓取起始年度第一天到起始日期前一天
         IF tm.curr_o='Y' THEN
            EXECUTE aglq770_sel_pr3 USING l_glar001,l_glav004,l_glav004_e,l_glar009 
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         ELSE
            EXECUTE aglq770_sel_pr3 USING l_glar001,l_glav004,l_glav004_e 
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         END IF
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','aglq770_sel_pr3','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq770_sel_pr3'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
         IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
         IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
         IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
         IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
         IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
         LET l_oamt_d=l_oamt_d+l_osum_d
         LET l_oamt_c=l_oamt_c+l_osum_c
         LET l_amt1=l_amt1+l_sum1
         LET l_amt2=l_amt2+l_sum2
         LET l_amt3=l_amt3+l_sum3
         LET l_amt4=l_amt4+l_sum4
         LET l_amt5=l_amt5+l_sum5
         LET l_amt6=l_amt6+l_sum6
#         END IF   #151231-00004#1 mark
      END IF
      
      #151204-00013#7--add--str--
      #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
      IF tm.show_ce <> 'Y' THEN
         #期初：抓取CE、XC憑證金額
         LET l_osum_d=0
         LET l_osum_c=0
         LET l_sum1=0
         LET l_sum2=0
         LET l_sum3=0
         LET l_sum4=0
         LET l_sum5=0
         LET l_sum6=0
         IF tm.curr_o='Y' THEN
            EXECUTE aglq770_sel_pr2_1 USING l_glar001,tm.syear,l_period,l_glar001,l_glar001,l_glar009 
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         ELSE
            EXECUTE aglq770_sel_pr2_1 USING l_glar001,tm.syear,l_period,l_glar001,l_glar001
                                     INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq770_sel_pr2_1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
         IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
         IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
         IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
         IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
         IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
         LET l_oamt_d=l_oamt_d-l_osum_d
         LET l_oamt_c=l_oamt_c-l_osum_c
         LET l_amt1=l_amt1-l_sum1
         LET l_amt2=l_amt2-l_sum2
         LET l_amt3=l_amt3-l_sum3
         LET l_amt4=l_amt4-l_sum4
         LET l_amt5=l_amt5-l_sum5
         LET l_amt6=l_amt6-l_sum6
      END IF
      #151204-00013#7--add--end
      
      LET l_glaq010d= l_oamt_d
      LET l_glaq010c= l_oamt_c
      LET l_glaq003 = l_amt1
      LET l_glaq004 = l_amt2
      LET l_glaq040 = l_amt3
      LET l_glaq041 = l_amt4
      LET l_glaq043 = l_amt5
      LET l_glaq044 = l_amt6
      #余额
      LET l_oamt = l_oamt_d - l_oamt_c
      LET l_amt1 = l_amt1 - l_amt2
      LET l_amt2 = l_amt3 - l_amt4
      LET l_amt3 = l_amt5 - l_amt6
      #借貸平否
      CASE
         WHEN l_amt1>0 
            LET l_state='1'
         WHEN l_amt1<0
            LET l_state='2'
            LET l_oamt=(-1)*l_oamt
            LET l_amt1=(-1)*l_amt1
            LET l_amt2=(-1)*l_amt2
            LET l_amt3=(-1)*l_amt3
         WHEN l_amt1=0
            LET l_state='3'
      END CASE
      
      #判斷是否有期初金額，如果有標示為TRUE
      IF l_state<>'3' THEN LET l_flag_amt = TRUE END IF
      #150716-00015#1--add--str--
      #摘要栏位存储说明栏位内容，说明栏位隐藏
      #LET l_glaq001=s_desc_gzcbl004_desc('9927','1')   #160503-00025#2 mark lujh
      #150716-00015#1--add--end
      INSERT INTO aglq770_tmp(seq,glaq002,
                              glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                              glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                              glaq029,glaq030,glaq031,glaq032,glaq033,
                              glaq034,glaq035,glaq036,glaq037,glaq038,glaq001,
                              style,glaq005,glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,
                              state,amt,amt1,amt2,amt3)
      VALUES(l_seq,l_glar001,
             l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
             l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
             l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,
             l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,l_glaq001_1,           #160503-00025#2 change l_glaq001 to l_glaq001_1 lujh
             '1',l_glaq005,l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044,             
             l_state,l_oamt,l_amt1,l_amt2,l_amt3)
      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
      END IF
      LET l_seq=l_seq+1
      
      #記錄期初金額及借貸狀態
      LET l_state_qc=l_state
      LET l_oamt_qc=l_oamt
      LET l_amt1_qc=l_amt1
      LET l_amt2_qc=l_amt2
      LET l_amt3_qc=l_amt3
      
      #各期明細資料
      LET l_glar003=tm.speriod
      LET l_glar002=tm.syear
      #當查詢時間範圍不是同一年，獲取起始年度的最大期別
      IF tm.syear<>tm.eyear THEN
         SELECT MAX(glav006) INTO l_period_max FROM glav_t
          WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
      END IF
      WHILE TRUE
         #查詢期間是同一年
         IF tm.syear=tm.eyear THEN
            IF l_glar003 > tm.eperiod THEN
               EXIT WHILE
            END IF
         ELSE
            IF l_glar003 > l_period_max THEN
               EXIT WHILE
            END IF
         END IF
         #抓取該期起始、截止日期
         CALL s_get_accdate(g_glaa003,'',l_glar002,l_glar003) 
         RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                   l_glav006,l_pdate_s3,l_pdate_e3,l_glav007,l_wdate_s,l_wdate_e
         LET l_glav004_m=l_pdate_e3 #該期截止日期
         IF l_glar002=tm.syear AND l_glar003=tm.speriod THEN
            IF l_pdate_s3<>tm.sdate THEN
               LET l_pdate_s3=tm.sdate
            END IF
         END IF
         IF l_glar002=tm.eyear AND l_glar003=tm.eperiod THEN
            IF l_pdate_e3<>tm.edate THEN
               LET l_pdate_e3=tm.edate
            END IF
         END IF
         LET l_glaq010d_s= 0
         LET l_glaq010c_s= 0
         LET l_glaq003_s = 0
         LET l_glaq004_s = 0
         LET l_glaq040_s = 0
         LET l_glaq041_s = 0
         LET l_glaq043_s = 0
         LET l_glaq044_s = 0
         
         LET l_glaq010d= 0
         LET l_glaq010c= 0
         LET l_glaq003 = 0
         LET l_glaq004 = 0
         LET l_glaq040 = 0
         LET l_glaq041 = 0
         LET l_glaq043 = 0
         LET l_glaq044 = 0
         
         #160503-00037#4 add by 02599--str--
         LET l_state=l_state_qc
         LET l_oamt=l_oamt_qc
         LET l_amt1=l_amt1_qc
         LET l_amt2=l_amt2_qc
         LET l_amt3=l_amt3_qc
         #160503-00037#4 add by 02599--end
         
         IF tm.curr_o='Y' THEN
            OPEN aglq770_sel_cs4 USING l_glar001,l_pdate_s3,l_pdate_e3,l_glar009
         ELSE
            OPEN aglq770_sel_cs4 USING l_glar001,l_pdate_s3,l_pdate_e3
         END IF
         #傳票明細資料
         FOREACH aglq770_sel_cs4 INTO l_glapdocdt,l_glapdocno,l_glap007,l_glaq001,l_glaq005,l_glaq006,l_glaq010d,l_glaq010c, #151204-00013#7 add l_glap007
                                      l_glaq003,l_glaq004,l_glaq039,l_glaq040,l_glaq041,
                                      l_glaq042,l_glaq043,l_glaq044
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','FOREACH aglq770_sel_cs4','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'FOREACH aglq770_sel_cs4'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            #151204-00013#7--add--str--
            #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
            IF tm.show_ce <> 'Y' THEN
               IF l_glap007 = 'CE' OR l_glap007 = 'XC' THEN
                  SELECT glac007 INTO l_glac007 FROM glac_t
                   WHERE glacent=g_enterprise AND glac001=g_glaa004 AND glac002=l_glar001
                  IF l_glap007 = 'CE' AND l_glac007 = '6' THEN
                     CONTINUE FOREACH
                  END IF
                  IF l_glap007 = 'XC' AND l_glac007 = '5' THEN
                     CONTINUE FOREACH
                  END IF
               END IF
            END IF
            #151204-00013#7--add--end
            
            IF cl_null(l_glaq010d) THEN LET l_glaq010d=0 END IF
            IF cl_null(l_glaq010c) THEN LET l_glaq010c=0 END IF
            IF cl_null(l_glaq003) THEN LET l_glaq003=0 END IF
            IF cl_null(l_glaq004) THEN LET l_glaq004=0 END IF
            IF cl_null(l_glaq040) THEN LET l_glaq040=0 END IF
            IF cl_null(l_glaq041) THEN LET l_glaq041=0 END IF
            IF cl_null(l_glaq043) THEN LET l_glaq043=0 END IF
            IF cl_null(l_glaq044) THEN LET l_glaq044=0 END IF
            
            #本期期間異動金額匯總
            LET l_glaq010d_s=l_glaq010d_s+l_glaq010d
            LET l_glaq010c_s=l_glaq010c_s+l_glaq010c
            LET l_glaq003_s=l_glaq003_s+l_glaq003
            LET l_glaq004_s=l_glaq004_s+l_glaq004
            LET l_glaq040_s=l_glaq040_s+l_glaq040
            LET l_glaq041_s=l_glaq041_s+l_glaq041
            LET l_glaq043_s=l_glaq043_s+l_glaq043
            LET l_glaq044_s=l_glaq044_s+l_glaq044
            
            #餘額計算
            LET l_osum=l_glaq010d-l_glaq010c
            LET l_sum1=l_glaq003-l_glaq004
	         LET l_sum2=l_glaq040-l_glaq041
	         LET l_sum3=l_glaq043-l_glaq044
            #借餘
            IF l_state='1' THEN
               LET l_oamt=l_osum+l_oamt
               LET l_amt1=l_sum1+l_amt1
               LET l_amt2=l_sum2+l_amt2
               LET l_amt3=l_sum3+l_amt3
            END IF
            #貸餘
            IF l_state='2' THEN
               LET l_oamt=l_osum-l_oamt            
               LET l_amt1=l_sum1-l_amt1
               LET l_amt2=l_sum2-l_amt2
               LET l_amt3=l_sum3-l_amt3
            END IF
            #平
            IF l_state='3' THEN
               LET l_oamt=l_osum
               LET l_amt1=l_sum1
               LET l_amt2=l_sum2
               LET l_amt3=l_sum3
            END IF
            #借貸平否
            CASE
               WHEN l_amt1>0 
                  LET l_state='1'
               WHEN l_amt1<0
                  LET l_state='2'
                  LET l_oamt=(-1)*l_oamt
                  LET l_amt1=(-1)*l_amt1
                  LET l_amt2=(-1)*l_amt2
                  LET l_amt3=(-1)*l_amt3
               WHEN l_amt1=0
                  LET l_state='3'
            END CASE
            
            INSERT INTO aglq770_tmp(seq,glaq002,
                                    glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                                    glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                                    glaq029,glaq030,glaq031,glaq032,glaq033,
                                    glaq034,glaq035,glaq036,glaq037,glaq038,
                                    glapdocdt,glaqdocno,glaq001,glaq005,glaq006,
                                    glaq010d,glaq010c,glaq003,glaq004,glaq039,glaq040,glaq041,
                                    glaq042,glaq043,glaq044,state,amt,amt1,amt2,amt3)
            VALUES(l_seq,l_glar001,
                   l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                   l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                   l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,
                   l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,
                   l_glapdocdt,l_glapdocno,l_glaq001,l_glaq005,l_glaq006,l_glaq010d,l_glaq010c,
                   l_glaq003,l_glaq004,l_glaq039,l_glaq040,l_glaq041,l_glaq042,l_glaq043,l_glaq044,
                   l_state,l_oamt,l_amt1,l_amt2,l_amt3)
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            LET l_seq=l_seq+1 
            #判斷是否有明細資料
            IF l_flag_amt = FALSE THEN 
               LET l_flag_amt = TRUE 
            END IF
         END FOREACH
         CLOSE aglq770_sel_cs4
         FREE aglq770_sel_pr4
      
         #150716-00015#1--add--str--
         #摘要栏位存储说明栏位内容，说明栏位隐藏
         #LET l_glaq001=s_desc_gzcbl004_desc('9927','2')   #160503-00025#2 mark lujh
         #150716-00015#1--add--end
         #本期合計      
         INSERT INTO aglq770_tmp(seq,glaq002,
                                 glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                                 glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                                 glaq029,glaq030,glaq031,glaq032,glaq033,
                                 glaq034,glaq035,glaq036,glaq037,glaq038,glaq001,
                                 glap004,style,glaq005,glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,
                                 glaq043,glaq044,state,amt,amt1,amt2,amt3)
         VALUES(l_seq,l_glar001,
                l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,
                l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,l_glaq001_2,     #160503-00025#2 change l_glaq001 to l_glaq001_2 lujh
                l_glar003,'2',l_glaq005,l_glaq010d_s,l_glaq010c_s,
                l_glaq003_s,l_glaq004_s,l_glaq040_s,l_glaq041_s,l_glaq043_s,l_glaq044_s,
                l_state,l_oamt,l_amt1,l_amt2,l_amt3)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_seq=l_seq+1
         #160503-00037#4 add by 02599--str--
         #記錄期初金額及借貸狀態
         LET l_state_qc=l_state
         LET l_oamt_qc=l_oamt
         LET l_amt1_qc=l_amt1
         LET l_amt2_qc=l_amt2
         LET l_amt3_qc=l_amt3
         #160503-00037#4 add by 02599--end
      
         #本年累計
         #整期且狀態=1：已審核
         IF l_glav004_m=l_pdate_e3 AND tm.stus='1' THEN
            IF tm.curr_o='Y' THEN
               EXECUTE aglq770_sel_pr01 USING l_glar001,l_glar002,l_glar003,l_glar009  #160503-00037#7  by 07900 -mod  "aglq770_sel_pr1"-->"aglq770_sel_pr01"
                                        INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
               LET l_glaq005=l_glar009
            ELSE
               EXECUTE aglq770_sel_pr01 USING l_glar001,l_glar002,l_glar003    #160503-00037#7  by 07900 -mod  "aglq770_sel_pr1"-->"aglq770_sel_pr01"
                                        INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
               LET l_glaq005=NULL
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq770_sel_pr1','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq770_sel_pr01'   #160503-00037#7  by 07900 -mod  "aglq770_sel_pr1"-->"aglq770_sel_pr01"
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
            IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
            #當不包含YE或AD傳票時，減去YE或AD傳票金額
#            IF tm.show_ce<>'Y' OR tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #150827-00036#2 add 'tm.show_ad' #151204-00013#7 mark
            IF tm.show_ye<>'Y' OR tm.show_ad<>'Y' THEN #151204-00013#7 add
               IF tm.curr_o='Y' THEN
                  EXECUTE aglq770_sel_pr2 USING l_glar001,l_glar002,l_glar003,l_glar009 
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               ELSE
                  EXECUTE aglq770_sel_pr2 USING l_glar001,l_glar002,l_glar003 
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               END IF
               IF SQLCA.sqlcode THEN
#                  CALL cl_errmsg('','aglq770_sel_pr2','',SQLCA.sqlcode,1)
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq770_sel_pr2'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
               IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
               IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
               IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
               IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
               IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
               IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
               IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
               LET l_oamt_d=l_oamt_d-l_osum_d
               LET l_oamt_c=l_oamt_c-l_osum_c
               LET l_amt1=l_amt1-l_sum1
               LET l_amt2=l_amt2-l_sum2
               LET l_amt3=l_amt3-l_sum3
               LET l_amt4=l_amt4-l_sum4
               LET l_amt5=l_amt5-l_sum5
               LET l_amt6=l_amt6-l_sum6
            END IF
         ELSE
            #年初余额
            #160503-00037#6 by 07900  mark -str
        #    LET l_period=0
         #   IF tm.curr_o='Y' THEN
       #        EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period,l_glar009 
       #                                 INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
        #       LET l_glaq005=l_glar009
        #    ELSE
        #       EXECUTE aglq770_sel_pr1 USING l_glar001,tm.syear,l_period 
        #                                INTO l_oamt_d,l_oamt_c,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6
        #       LET l_glaq005=NULL
        #    END IF
        #    IF SQLCA.sqlcode THEN
#       #        CALL cl_errmsg('','aglq770_sel_pr1','',SQLCA.sqlcode,1)
        #       INITIALIZE g_errparam TO NULL
        #       LET g_errparam.code = SQLCA.sqlcode
        #       LET g_errparam.extend = 'aglq770_sel_pr1'
        #       LET g_errparam.popup = TRUE
        #       CALL cl_err()
        #       LET l_success = FALSE
        #    END IF
            #160503-00037#6 by 07900  mark -end
#160503-00037#4 mark by 02599--str--
#            IF cl_null(l_oamt_d) THEN LET l_oamt_d=0 END IF
#            IF cl_null(l_oamt_c) THEN LET l_oamt_c=0 END IF
#            IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
#            IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
#            IF cl_null(l_amt3) THEN LET l_amt3=0 END IF
#            IF cl_null(l_amt4) THEN LET l_amt4=0 END IF
#            IF cl_null(l_amt5) THEN LET l_amt5=0 END IF
#            IF cl_null(l_amt6) THEN LET l_amt6=0 END IF
#160503-00037#4 mark by 02599--end
            #破期抓取傳票檔資料
            IF tm.curr_o='Y' THEN
               EXECUTE aglq770_sel_pr3 USING l_glar001,l_glav004,l_pdate_e3,l_glar009 
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               LET l_glaq005=l_glar009 #160511-00006#4 add
            ELSE
               EXECUTE aglq770_sel_pr3 USING l_glar001,l_glav004,l_pdate_e3 
                                        INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               LET l_glaq005=NULL #160511-00006#4 add
            END IF
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('','aglq770_sel_pr3','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'aglq770_sel_pr3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
            END IF
            IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
            IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
            IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
            IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
            IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
            IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
            IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
#160503-00037#4 mark by 02599--str--
#            LET l_oamt_d=l_oamt_d+l_osum_d
#            LET l_oamt_c=l_oamt_c+l_osum_c
#            LET l_amt1=l_amt1+l_sum1
#            LET l_amt2=l_amt2+l_sum2
#            LET l_amt3=l_amt3+l_sum3
#            LET l_amt4=l_amt4+l_sum4
#            LET l_amt5=l_amt5+l_sum5
#            LET l_amt6=l_amt6+l_sum6
#160503-00037#4 mark by 02599--end
#160503-00037#4 add by 02599--str--
            LET l_oamt_d=l_osum_d
            LET l_oamt_c=l_osum_c
            LET l_amt1=l_sum1
            LET l_amt2=l_sum2
            LET l_amt3=l_sum3
            LET l_amt4=l_sum4
            LET l_amt5=l_sum5
            LET l_amt6=l_sum6
#160503-00037#4 add by 02599--str--
         END IF
         
         #151204-00013#6--add--str--
         #当未勾选含月结凭证时，要排除CE凭证中损益类科目金额和XC凭证中成本类科目金额
         IF tm.show_ce <> 'Y' THEN
            LET l_osum_d=0
            LET l_osum_c=0
            LET l_sum1=0
            LET l_sum2=0
            LET l_sum3=0
            LET l_sum4=0
            LET l_sum5=0
            LET l_sum6=0
            IF tm.curr_o='Y' THEN
                  EXECUTE aglq770_sel_pr2_1 USING l_glar001,l_glar002,l_glar003,l_glar001,l_glar001,l_glar009 
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               ELSE
                  EXECUTE aglq770_sel_pr2_1 USING l_glar001,l_glar002,l_glar003,l_glar001,l_glar001
                                           INTO l_osum_d,l_osum_c,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5,l_sum6
               END IF
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'aglq770_sel_pr2_1'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
               END IF
               IF cl_null(l_osum_d) THEN LET l_osum_d=0 END IF
               IF cl_null(l_osum_c) THEN LET l_osum_c=0 END IF
               IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
               IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
               IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
               IF cl_null(l_sum4) THEN LET l_sum4=0 END IF
               IF cl_null(l_sum5) THEN LET l_sum5=0 END IF
               IF cl_null(l_sum6) THEN LET l_sum6=0 END IF
               LET l_oamt_d=l_oamt_d-l_osum_d
               LET l_oamt_c=l_oamt_c-l_osum_c
               LET l_amt1=l_amt1-l_sum1
               LET l_amt2=l_amt2-l_sum2
               LET l_amt3=l_amt3-l_sum3
               LET l_amt4=l_amt4-l_sum4
               LET l_amt5=l_amt5-l_sum5
               LET l_amt6=l_amt6-l_sum6
         END IF
         #151204-00013#6--add--end
         
         LET l_glaq010d= l_oamt_d
         LET l_glaq010c= l_oamt_c
         LET l_glaq003 = l_amt1
         LET l_glaq004 = l_amt2
         LET l_glaq040 = l_amt3
         LET l_glaq041 = l_amt4
         LET l_glaq043 = l_amt5
         LET l_glaq044 = l_amt6
         
         #160511-00006#4--add--str--
         #本年累计的余额包括年初金额
         LET l_year_osum=0
         LET l_year_sum1=0
         LET l_year_sum2=0
         LET l_year_sum3=0
         IF tm.curr_o='Y' THEN
            EXECUTE aglq770_year_sum_pr USING l_glar001,tm.syear,l_glar009 
                                         INTO l_year_osum,l_year_sum1,l_year_sum2,l_year_sum3
         ELSE
            EXECUTE aglq770_year_sum_pr USING l_glar001,tm.syear
                                         INTO l_year_osum,l_year_sum1,l_year_sum2,l_year_sum3
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'aglq770_year_sum_pr'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         IF cl_null(l_year_osum) THEN LET l_year_osum = 0 END IF
         IF cl_null(l_year_sum1) THEN LET l_year_sum1 = 0 END IF
         IF cl_null(l_year_sum2) THEN LET l_year_sum2 = 0 END IF
         IF cl_null(l_year_sum3) THEN LET l_year_sum3 = 0 END IF
         #160511-00006#4--add--end
         
         #余额
         LET l_oamt = l_oamt_d - l_oamt_c
         LET l_amt1 = l_amt1 - l_amt2
         LET l_amt2 = l_amt3 - l_amt4
         LET l_amt3 = l_amt5 - l_amt6
         
         #160511-00006#3--add--str--
         #本年累计余额=本年累计金额+年初余额
         LET l_oamt = l_oamt + l_year_osum
         LET l_amt1 = l_amt1 + l_year_sum1 #（本币一余额）
         LET l_amt2 = l_amt2 + l_year_sum2 #（本币二余额）
         LET l_amt3 = l_amt3 + l_year_sum3 #（本币三余额）
         #160511-00006#3--add--end
         
         #借貸平否
         CASE
            WHEN l_amt1>0 
               LET l_state='1'
            WHEN l_amt1<0
               LET l_state='2'
               LET l_oamt=(-1)*l_oamt
               LET l_amt1=(-1)*l_amt1
               LET l_amt2=(-1)*l_amt2
               LET l_amt3=(-1)*l_amt3
            WHEN l_amt1=0
               LET l_state='3'
         END CASE
         #150716-00015#1--add--str--
         #摘要栏位存储说明栏位内容，说明栏位隐藏
         #LET l_glaq001=s_desc_gzcbl004_desc('9927','3')    #160503-00025#2 mark lujh
         #150716-00015#1--add--end
         INSERT INTO aglq770_tmp(seq,glaq002,
                                 glaq017,glaq018,glaq019,glaq020,glaq021,glaq022,
                                 glaq023,glaq024,glaq051,glaq052,glaq053,glaq025,glaq027,glaq028,
                                 glaq029,glaq030,glaq031,glaq032,glaq033,
                                 glaq034,glaq035,glaq036,glaq037,glaq038,glaq001,
                                 style,glaq005,glaq010d,glaq010c,glaq003,glaq004,glaq040,glaq041,glaq043,glaq044,
                                 state,amt,amt1,amt2,amt3)
         VALUES(l_seq,l_glar001,
                l_glar012,l_glar013,l_glar014,l_glar015,l_glar016,l_glar017,
                l_glar018,l_glar019,l_glar051,l_glar052,l_glar053,l_glar020,l_glar022,l_glar023,
                l_glar024,l_glar025,l_glar026,l_glar027,l_glar028,
                l_glar029,l_glar030,l_glar031,l_glar032,l_glar033,l_glaq001_3,     #160503-00025#2 change l_glaq001 to l_glaq001_3 lujh
                '3',l_glaq005,l_glaq010d,l_glaq010c,l_glaq003,l_glaq004,l_glaq040,l_glaq041,l_glaq043,l_glaq044,
                l_state,l_oamt,l_amt1,l_amt2,l_amt3)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('','insert','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
         LET l_seq=l_seq+1
         IF l_glar002<>tm.eyear AND l_glar003 = l_period_max THEN
            LET l_period_max = tm.eperiod
            LET l_glar003 = 1
            LET l_glar002 = tm.eyear
         ELSE
            LET l_glar003 = l_glar003 + 1
         END IF
      END WHILE
      #當该科目沒有期初金額和期間異動時不用查詢出來
      IF l_flag_amt = FALSE THEN
         LET l_sql="DELETE FROM aglq770_tmp ",
                   " WHERE glaq002 = '",l_glar001,"'"
         IF tm.curr_o='Y' THEN
            LET l_sql=l_sql," AND glaq005 = '",l_glar009,"' "
         END IF
         IF tm.comp='Y' THEN
            LET l_sql=l_sql," AND glaq017 = '",l_glar012,"' "
         END IF
         IF tm.glad007='Y' THEN
            LET l_sql=l_sql," AND glaq018 = '",l_glar013,"' "
         END IF
         IF tm.glad008='Y' THEN
            LET l_sql=l_sql," AND glaq019 = '",l_glar014,"' "
         END IF
         IF tm.glad009='Y' THEN
            LET l_sql=l_sql," AND glaq020 = '",l_glar015,"' "
         END IF
         IF tm.glad010='Y' THEN
            LET l_sql=l_sql," AND glaq021 = '",l_glar016,"' "
         END IF
         IF tm.glad027='Y' THEN
            LET l_sql=l_sql," AND glaq022 = '",l_glar017,"' "
         END IF
         IF tm.glad011='Y' THEN
            LET l_sql=l_sql," AND glaq023 = '",l_glar018,"' "
         END IF
         IF tm.glad012='Y' THEN
            LET l_sql=l_sql," AND glaq024 = '",l_glar019,"' "
         END IF
         IF tm.glad031='Y' THEN
            LET l_sql=l_sql," AND glaq051 = '",l_glar051,"' "
         END IF
         IF tm.glad032='Y' THEN
            LET l_sql=l_sql," AND glaq052 = '",l_glar052,"' "
         END IF
         IF tm.glad033='Y' THEN
            LET l_sql=l_sql," AND glaq053 = '",l_glar053,"' "
         END IF
         IF tm.glad013='Y' THEN
            LET l_sql=l_sql," AND glaq025 = '",l_glar020,"' "
         END IF
         IF tm.glad015='Y' THEN
            LET l_sql=l_sql," AND glaq027 = '",l_glar022,"' "
         END IF
         IF tm.glad016='Y' THEN
            LET l_sql=l_sql," AND glaq028 = '",l_glar023,"' "
         END IF
         IF tm.glad017='Y' THEN
            LET l_sql=l_sql," AND glaq029 = '",l_glar024,"' "
         END IF
         IF tm.glad018='Y' THEN
            LET l_sql=l_sql," AND glaq030 = '",l_glar025,"' "
         END IF
         IF tm.glad019='Y' THEN
            LET l_sql=l_sql," AND glaq031 = '",l_glar026,"' "
         END IF
         IF tm.glad020='Y' THEN
            LET l_sql=l_sql," AND glaq032 = '",l_glar027,"' "
         END IF
         IF tm.glad021='Y' THEN
            LET l_sql=l_sql," AND glaq033 = '",l_glar028,"' "
         END IF
         IF tm.glad022='Y' THEN
            LET l_sql=l_sql," AND glaq034 = '",l_glar029,"' "
         END IF
         IF tm.glad023='Y' THEN
            LET l_sql=l_sql," AND glaq035 = '",l_glar030,"' "
         END IF
         IF tm.glad024='Y' THEN
            LET l_sql=l_sql," AND glaq036 = '",l_glar031,"' "
         END IF
         IF tm.glad025='Y' THEN
            LET l_sql=l_sql," AND glaq037 = '",l_glar032,"' "
         END IF
         IF tm.glad026='Y' THEN
            LET l_sql=l_sql," AND glaq038 = '",l_glar033,"' "
         END IF
         PREPARE aglq770_del_temp_table FROM l_sql
         EXECUTE aglq770_del_temp_table
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'delete'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
         END IF
      END IF
   END FOR
   IF l_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq770_tmp
   ELSE
      CALL cl_err_collect_init()
      CALL cl_err_collect_show()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 显示资料
# Memo...........:
# Usage..........: CALL aglq770_show()
# Date & Author..:  2014/03/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_show()
    DISPLAY g_glaald,g_glaald_desc,g_glaacomp,g_glaacomp_desc,g_glaa001,g_glaa016,g_glaa020,
           tm.sdate,tm.syear,tm.speriod,tm.edate,tm.eyear,tm.eperiod,tm.ctype,tm.curr_o,tm.curr_p,
           tm.acc_p,tm.show_acc,tm.glac005,tm.stus,tm.glac009,tm.show_ad,tm.show_ce,tm.show_ye,
           tm.comp,tm.glad007,tm.glad008,tm.glad009,tm.glad010,tm.glad027,tm.glad011,
           tm.glad012,tm.glad031,tm.glad032,tm.glad033,tm.glad013,tm.glad015,tm.glad016,
           tm.glad017,tm.glad018,tm.glad019,tm.glad020,tm.glad021,tm.glad022,
           tm.glad023,tm.glad024,tm.glad025,tm.glad026
        TO glaald,glaald_desc,glaacomp,glaacomp_desc,glaa001,glaa016,glaa020,
           sdate,syear,speriod,edate,eyear,eperiod,ctype,curr_o,curr_p,
           acc_p,show_acc,glac005,stus,glac009,show_ad,show_ce,show_ye,
           comp,glad007,glad008,glad009,glad010,glad027,glad011,
           glad012,glad031,glad032,glad033,glad013,glad015,glad016,
           glad017,glad018,glad019,glad020,glad021,glad022,glad023,
           glad024,glad025,glad026
END FUNCTION

################################################################################
# Descriptions...: 填充单身资料
# Memo...........:
# Usage..........: CALL aglq770_b_fill1()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_b_fill1()
   DEFINE l_seq      LIKE type_t.num10
   DEFINE l_sql      STRING
   DEFINE l_glaq002  LIKE glaq_t.glaq002
   DEFINE l_glaq017  LIKE glaq_t.glaq017
   DEFINE l_glaq018  LIKE glaq_t.glaq018
   DEFINE l_glaq019  LIKE glaq_t.glaq019
   DEFINE l_glaq020  LIKE glaq_t.glaq020
   DEFINE l_glaq021  LIKE glaq_t.glaq021
   DEFINE l_glaq022  LIKE glaq_t.glaq022
   DEFINE l_glaq023  LIKE glaq_t.glaq023
   DEFINE l_glaq024  LIKE glaq_t.glaq024
   DEFINE l_glaq051  LIKE glaq_t.glaq051
   DEFINE l_glaq052  LIKE glaq_t.glaq052
   DEFINE l_glaq053  LIKE glaq_t.glaq053
   DEFINE l_glaq025  LIKE glaq_t.glaq025
   DEFINE l_glaq027  LIKE glaq_t.glaq027
   DEFINE l_glaq028  LIKE glaq_t.glaq028
   DEFINE l_glaq029  LIKE glaq_t.glaq029
   DEFINE l_glaq030  LIKE glaq_t.glaq030
   DEFINE l_glaq031  LIKE glaq_t.glaq031
   DEFINE l_glaq032  LIKE glaq_t.glaq032
   DEFINE l_glaq033  LIKE glaq_t.glaq033
   DEFINE l_glaq034  LIKE glaq_t.glaq034
   DEFINE l_glaq035  LIKE glaq_t.glaq035
   DEFINE l_glaq036  LIKE glaq_t.glaq036
   DEFINE l_glaq037  LIKE glaq_t.glaq037
   DEFINE l_glaq038  LIKE glaq_t.glaq038
   #160503-00025#2--add--str--lujh
   DEFINE l_sql1          RECORD
             glaq002_desc    STRING,
             glaq017_desc    STRING,
             glaq018_desc    STRING,
             glaq019_desc    STRING,
             glaq020_desc    STRING,
             glaq021_desc    STRING,
             glaq022_desc    STRING,
             glaq023_desc    STRING,
             glaq024_desc    STRING,
             glaq052_desc    STRING,
             glaq053_desc    STRING,
             glaq025_desc    STRING,
             glaq027_desc    STRING,
             glaq028_desc    STRING,
             glad0171        STRING,
             glad0181        STRING,
             glad0191        STRING,
             glad0201        STRING,
             glad0211        STRING,
             glad0221        STRING,
             glad0231        STRING,
             glad0241        STRING,
             glad0251        STRING,
             glad0261        STRING 
                          END RECORD

   INITIALIZE l_sql1.* TO NULL

   LET l_sql1.glaq002_desc = "(SELECT glacl004 FROM glacl_t WHERE glaclent = '",g_enterprise,"' AND glacl001 = '",g_glaa004,"' AND glacl002 = glaq002 AND glacl003 ='",g_dlang,"')"

   LET l_sql1.glaq017_desc = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq017 AND ooefl002 = '",g_dlang,"')"

   LET l_sql1.glaq018_desc = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq018 AND ooefl002 = '",g_dlang,"')"

   LET l_sql1.glaq019_desc = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = glaq019 AND ooefl002 = '",g_dlang,"')"

   LET l_sql1.glaq020_desc = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '287' AND oocql002 = glaq020 AND oocql003='",g_dlang,"')"

   LET l_sql1.glaq021_desc = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = glaq021 AND pmaal002 = '",g_dlang,"')"

   LET l_sql1.glaq022_desc = "(SELECT pmaal004 FROM pmaal_t WHERE pmaalent = '",g_enterprise,"' AND pmaal001 = glaq022 AND pmaal002 = '",g_dlang,"')"

   LET l_sql1.glaq023_desc = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '281' AND oocql002 = glaq023 AND oocql003='",g_dlang,"')"

   LET l_sql1.glaq024_desc = "(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = '",g_enterprise,"' AND rtaxl001 = glaq024 AND rtaxl002 = '",g_dlang,"')"

   LET l_sql1.glaq052_desc = "(SELECT oojdl003 FROM oojdl_t WHERE oojdlent = '",g_enterprise,"' AND oojdl001 = glaq052 AND oojdl002 = '",g_dlang,"')"

   LET l_sql1.glaq053_desc = "(SELECT oocql004 FROM oocql_t WHERE oocqlent = '",g_enterprise,"' AND oocql001 = '2002' AND oocql002 = glaq053 AND oocql003='",g_dlang,"')"

   LET l_sql1.glaq025_desc = "(SELECT ooag011 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 = glaq025 )"
   
   LET l_sql1.glaq027_desc = "(SELECT pjbal003 FROM pjbal_t WHERE pjbalent = '",g_enterprise,"' AND pjbal001 = glaq027 AND pjbal002 = '",g_dlang,"')"

   LET l_sql1.glaq028_desc = "(SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent = '",g_enterprise,"' AND pjbbl001 = glaq027 AND pjbbl002 = glaq028 AND pjbbl003 = '",g_dlang,"')"

   LET l_sql1.glad0171 = "(SELECT glad0171 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0181 = "(SELECT glad0181 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0191 = "(SELECT glad0191 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0201 = "(SELECT glad0201 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0211 = "(SELECT glad0211 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0221 = "(SELECT glad0221 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0231 = "(SELECT glad0231 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0241 = "(SELECT glad0241 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0251 = "(SELECT glad0251 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET l_sql1.glad0261 = "(SELECT glad0261 FROM glad_t WHERE gladent = '",g_enterprise,"' AND gladld = '",g_glaald,"' AND glad001 = glaq002 )"
   
   LET g_sql="SELECT UNIQUE seq,glaq002,",l_sql1.glaq002_desc,
             "                 ,glaq017,",l_sql1.glaq017_desc,
             "                 ,glaq018,",l_sql1.glaq018_desc,
             "                 ,glaq019,",l_sql1.glaq019_desc,
             "                 ,glaq020,",l_sql1.glaq020_desc,
             "                 ,glaq021,",l_sql1.glaq021_desc,
             "                 ,glaq022,",l_sql1.glaq022_desc,
             "                 ,glaq023,",l_sql1.glaq023_desc,
             "                 ,glaq024,",l_sql1.glaq024_desc,
             "         ,glaq051,glaq052,",l_sql1.glaq052_desc,
             "                 ,glaq053,",l_sql1.glaq053_desc,
             "                 ,glaq025,",l_sql1.glaq025_desc,
             "                 ,glaq027,",l_sql1.glaq027_desc,
             "                 ,glaq028,",l_sql1.glaq028_desc,
             "      ,glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,",
             "       glapdocdt,glaqdocno,glaq001,glap004,style,glaq005,glaq006,glaq010d,glaq010c,glaq003,glaq004,",
             "       glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,",
             "       state,amt,amt1,amt2,amt3, ",
                     l_sql1.glad0171,",",l_sql1.glad0181,",",l_sql1.glad0191,",",l_sql1.glad0201,",",l_sql1.glad0211,",",
                     l_sql1.glad0221,",",l_sql1.glad0231,",",l_sql1.glad0241,",",l_sql1.glad0251,",",l_sql1.glad0261,                   
             "  FROM aglq770_tmp ",
             " WHERE 1=1 " 
     
   #160503-00025#2--add--end--lujh
   
   #160503-00025#2--mark--str--lujh
   #LET g_sql="SELECT UNIQUE seq,glaq002,'',glaq017,'',glaq018,'',glaq019,'',glaq020,'',glaq021,'',glaq022,'',",
   #          "       glaq023,'',glaq024,'',glaq051,glaq052,'',glaq053,'',glaq025,'',glaq027,glaq028,",
   #          "       glaq029,glaq030,glaq031,glaq032,glaq033,glaq034,glaq035,glaq036,glaq037,glaq038,",
   #          "       glapdocdt,glaqdocno,glaq001,glap004,style,glaq005,glaq006,glaq010d,glaq010c,glaq003,glaq004,",
   #          "       glaq039,glaq040,glaq041,glaq042,glaq043,glaq044,",
   #          "       state,amt,amt1,amt2,amt3 ",
   #          "  FROM aglq770_tmp ",
   #          " WHERE 1=1 "   #160302-00006#1 ADD by 07675
   #160503-00025#2--mark--end--lujh
   #是否按照外幣分頁
   IF NOT cl_null(g_glaq005) THEN
      LET l_sql=" glaq005='",g_glaq005,"'"
   END IF
   #是否按照科目分頁
   IF NOT cl_null(g_glaq002) THEN
      IF cl_null(l_sql) THEN
         LET l_sql=" glaq002='",g_glaq002,"'"
      ELSE
         LET l_sql=l_sql," AND glaq002='",g_glaq002,"'"
      END IF
   END IF
  
   IF NOT cl_null(l_sql) THEN
      LET g_sql=g_sql,"  AND ",l_sql  #160302-00006#1 xzg change "WHERE" to "AND"
   END IF
   LET g_sql = g_sql, " AND ",g_wc_filter #160302-00006#1  ADD by 07675
   LET g_sql=g_sql," ORDER BY seq "
  
   PREPARE aglq770_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq770_pb1
   OPEN b_fill_curs1
   
   CALL g_glaq_d.clear()
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!"
   
   FOREACH b_fill_curs1 INTO l_seq,g_glaq_d[l_ac].glaq002,g_glaq_d[l_ac].glaq002_desc,g_glaq_d[l_ac].glaq017, 
       g_glaq_d[l_ac].glaq017_desc,g_glaq_d[l_ac].glaq018,g_glaq_d[l_ac].glaq018_desc,g_glaq_d[l_ac].glaq019, 
       g_glaq_d[l_ac].glaq019_desc,g_glaq_d[l_ac].glaq020,g_glaq_d[l_ac].glaq020_desc,g_glaq_d[l_ac].glaq021, 
       g_glaq_d[l_ac].glaq021_desc,g_glaq_d[l_ac].glaq022,g_glaq_d[l_ac].glaq022_desc,g_glaq_d[l_ac].glaq023, 
       g_glaq_d[l_ac].glaq023_desc,g_glaq_d[l_ac].glaq024,g_glaq_d[l_ac].glaq024_desc,g_glaq_d[l_ac].glaq051,
       g_glaq_d[l_ac].glaq052,g_glaq_d[l_ac].glaq052_desc,g_glaq_d[l_ac].glaq053,g_glaq_d[l_ac].glaq053_desc,
       g_glaq_d[l_ac].glaq025,g_glaq_d[l_ac].glaq025_desc,
       g_glaq_d[l_ac].glaq027,g_glaq_d[l_ac].glaq027_desc,g_glaq_d[l_ac].glaq028,g_glaq_d[l_ac].glaq028_desc,     #160503-00025#2 add glaq027_desc,glaq028_desc lujh
       g_glaq_d[l_ac].glaq029,g_glaq_d[l_ac].glaq030,g_glaq_d[l_ac].glaq031,g_glaq_d[l_ac].glaq032,
       g_glaq_d[l_ac].glaq033,g_glaq_d[l_ac].glaq034,g_glaq_d[l_ac].glaq035,g_glaq_d[l_ac].glaq036,
       g_glaq_d[l_ac].glaq037,g_glaq_d[l_ac].glaq038,
       g_glaq_d[l_ac].glapdocdt,g_glaq_d[l_ac].glaqdocno,g_glaq_d[l_ac].glaq001,g_glaq_d[l_ac].glap004,g_glaq_d[l_ac].style, 
       g_glaq_d[l_ac].glaq005,g_glaq_d[l_ac].glaq006,g_glaq_d[l_ac].glaq010d,g_glaq_d[l_ac].glaq010c, 
       g_glaq_d[l_ac].glaq003,g_glaq_d[l_ac].glaq004,g_glaq_d[l_ac].glaq039,g_glaq_d[l_ac].glaq040,g_glaq_d[l_ac].glaq041, 
       g_glaq_d[l_ac].glaq042,g_glaq_d[l_ac].glaq043,g_glaq_d[l_ac].glaq044,g_glaq_d[l_ac].state,g_glaq_d[l_ac].amt, 
       g_glaq_d[l_ac].amt1,g_glaq_d[l_ac].amt2,g_glaq_d[l_ac].amt3,
       #160503-00025#2--add--str-lujh
       g_glad0171,g_glad0181,g_glad0191,g_glad0201,g_glad0211,
       g_glad0221,g_glad0231,g_glad0241,g_glad0251,g_glad0261
       #160503-00025#2--add--end-lujh
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #期初
      IF g_glaq_d[l_ac].style='1' THEN
         IF l_glaq002 = g_glaq_d[l_ac].glaq002 AND 
            l_glaq017 = g_glaq_d[l_ac].glaq017 AND
            l_glaq018 = g_glaq_d[l_ac].glaq018 AND
            l_glaq019 = g_glaq_d[l_ac].glaq019 AND
            l_glaq020 = g_glaq_d[l_ac].glaq020 AND
            l_glaq021 = g_glaq_d[l_ac].glaq021 AND
            l_glaq022 = g_glaq_d[l_ac].glaq022 AND
            l_glaq023 = g_glaq_d[l_ac].glaq023 AND
            l_glaq024 = g_glaq_d[l_ac].glaq024 AND
            l_glaq051 = g_glaq_d[l_ac].glaq051 AND
            l_glaq052 = g_glaq_d[l_ac].glaq052 AND
            l_glaq053 = g_glaq_d[l_ac].glaq053 AND
            l_glaq025 = g_glaq_d[l_ac].glaq025 AND
            l_glaq027 = g_glaq_d[l_ac].glaq027 AND
            l_glaq028 = g_glaq_d[l_ac].glaq028 AND
            l_glaq029 = g_glaq_d[l_ac].glaq029 AND
            l_glaq030 = g_glaq_d[l_ac].glaq030 AND
            l_glaq031 = g_glaq_d[l_ac].glaq031 AND
            l_glaq032 = g_glaq_d[l_ac].glaq032 AND
            l_glaq033 = g_glaq_d[l_ac].glaq033 AND
            l_glaq034 = g_glaq_d[l_ac].glaq034 AND
            l_glaq035 = g_glaq_d[l_ac].glaq035 AND
            l_glaq036 = g_glaq_d[l_ac].glaq036 AND
            l_glaq037 = g_glaq_d[l_ac].glaq037 AND
            l_glaq038 = g_glaq_d[l_ac].glaq038 
            THEN
            CONTINUE FOREACH
         ELSE
            LET l_glaq002 = g_glaq_d[l_ac].glaq002
            LET l_glaq017 = g_glaq_d[l_ac].glaq017
            LET l_glaq018 = g_glaq_d[l_ac].glaq018
            LET l_glaq019 = g_glaq_d[l_ac].glaq019
            LET l_glaq020 = g_glaq_d[l_ac].glaq020
            LET l_glaq021 = g_glaq_d[l_ac].glaq021
            LET l_glaq022 = g_glaq_d[l_ac].glaq022
            LET l_glaq023 = g_glaq_d[l_ac].glaq023
            LET l_glaq024 = g_glaq_d[l_ac].glaq024
            LET l_glaq051 = g_glaq_d[l_ac].glaq051
            LET l_glaq052 = g_glaq_d[l_ac].glaq052
            LET l_glaq053 = g_glaq_d[l_ac].glaq053
            LET l_glaq025 = g_glaq_d[l_ac].glaq025
            LET l_glaq027 = g_glaq_d[l_ac].glaq027
            LET l_glaq028 = g_glaq_d[l_ac].glaq028
            LET l_glaq029 = g_glaq_d[l_ac].glaq029
            LET l_glaq030 = g_glaq_d[l_ac].glaq030
            LET l_glaq031 = g_glaq_d[l_ac].glaq031
            LET l_glaq032 = g_glaq_d[l_ac].glaq032
            LET l_glaq033 = g_glaq_d[l_ac].glaq033
            LET l_glaq034 = g_glaq_d[l_ac].glaq034
            LET l_glaq035 = g_glaq_d[l_ac].glaq035
            LET l_glaq036 = g_glaq_d[l_ac].glaq036
            LET l_glaq037 = g_glaq_d[l_ac].glaq037
            LET l_glaq038 = g_glaq_d[l_ac].glaq038
         END IF
      END IF
      
      #160511-00006#3--add--str--
      #期初：只显示余额，借贷方金额不显示
      IF g_glaq_d[l_ac].style = '1' THEN
         LET g_glaq_d[l_ac].glaq010d= NULL
         LET g_glaq_d[l_ac].glaq010c= NULL
         LET g_glaq_d[l_ac].glaq003 = NULL
         LET g_glaq_d[l_ac].glaq004 = NULL
         LET g_glaq_d[l_ac].glaq040 = NULL
         LET g_glaq_d[l_ac].glaq041 = NULL
         LET g_glaq_d[l_ac].glaq043 = NULL
         LET g_glaq_d[l_ac].glaq044 = NULL
      END IF
      #160511-00006#3--add--end
      
      CALL aglq770_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   CALL g_glaq_d.deleteElement(g_glaq_d.getLength())   
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE aglq770_pb1
   
   LET l_ac = 1
END FUNCTION

################################################################################
# Descriptions...: 設置默認值
# Memo...........:
# Usage..........: CALL aglq770_set_default_value()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.sdate=l_pdate_s  #起始日期
   LET tm.syear=l_glav002
   LET tm.speriod=l_glav006
   LET tm.edate=l_pdate_e  #截止日期
   LET tm.eyear=l_glav002
   LET tm.eperiod=l_glav006
  
   #原幣顯示設置
   LET tm.curr_o='N'
   CALL cl_set_comp_visible('glaq005,glaq006,glaq010d,glaq010c,amt',FALSE)
   LET tm.curr_p='N'
   CALL aglq770_set_comp_entry('curr_p',FALSE)
   #按科目分頁
   LET tm.acc_p='N'
   #統制科目
   LET tm.show_acc='N'
   #科目層級
   LET tm.glac005=99
   #單據狀態
   LET tm.stus='1'
   #含內部管理科目
   LET tm.glac009='Y'
   #150827-00036#2--add--str--
   #含審計調整傳票
   LET tm.show_ad='Y'
   #150827-00036#2--add--end
   #含月結傳票
   LET tm.show_ce='Y'
   #含年結傳票
   LET tm.show_ye='Y'
   #核算項
   LET tm.comp='Y'
   LET tm.glad007='N'
   LET tm.glad008='N'
   LET tm.glad009='N'
   LET tm.glad010='N'
   LET tm.glad027='N'
   LET tm.glad011='N'
   LET tm.glad012='N'
   LET tm.glad031='N'
   LET tm.glad032='N'
   LET tm.glad033='N'
   LET tm.glad013='N'
   LET tm.glad015='N'
   LET tm.glad016='N'
   LET tm.glad017='N'
   LET tm.glad018='N'
   LET tm.glad019='N'
   LET tm.glad020='N'
   LET tm.glad021='N'
   LET tm.glad022='N'
   LET tm.glad023='N'
   LET tm.glad024='N'
   LET tm.glad025='N'
   LET tm.glad026='N'
   CALL cl_set_comp_visible("b_glaq018,b_glaq018_desc,b_glaq019,b_glaq019_desc,b_glaq020,b_glaq020_desc,b_glaq021,b_glaq021_desc,b_glaq022,b_glaq022_desc",FALSE)
   CALL cl_set_comp_visible("b_glaq023,b_glaq023_desc,b_glaq024,b_glaq024_desc,b_glaq051,b_glaq052,b_glaq052_desc,b_glaq053,b_glaq053_desc,b_glaq025,glaq025_desc",FALSE)
   CALL cl_set_comp_visible("b_glaq027,b_glaq027_desc,b_glaq028,b_glaq028_desc,b_glaq029,b_glaq029_desc,b_glaq030,b_glaq030_desc,b_glaq031,b_glaq031_desc,b_glaq032,b_glaq032_desc",FALSE)
   CALL cl_set_comp_visible("b_glaq033,b_glaq033_desc,b_glaq034,b_glaq034_desc,b_glaq035,b_glaq035_desc,b_glaq036,b_glaq036_desc,b_glaq037,b_glaq037_desc,b_glaq038,b_glaq038_desc",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 抓取下一筆資料
# Memo...........:
# Usage..........: CALL aglq770_fetch1(p_flag)
# Input parameter: p_flag            
# Date & Author..: 2014/3/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_fetch1(p_flag)
   DEFINE p_flag   LIKE type_t.chr1
   DEFINE ls_msg     STRING
   
   IF g_header_cnt = 0 THEN
      RETURN
   END IF
   
   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'L' LET g_current_idx = g_header_cnt        
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_glaq_s.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         
         LET g_no_ask = FALSE  
   END CASE 
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_glaq_s.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_glaq_s.getLength() THEN
      LET g_current_idx = g_glaq_s.getLength()
   END IF
   
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_glaq002 = g_glaq_s[g_current_idx].glaq002 
   LET g_glaq005 = g_glaq_s[g_current_idx].glaq005
   CALL aglq770_b_fill1() 
END FUNCTION

################################################################################
# Descriptions...: 根據核算項勾選組SQL語句
# Memo...........:
# Usage..........: CALL aglq770_fix_acc_get_sql()
#                  RETURNING r_sql,r_sql1
# Return code....: r_sql    關於glar_t的SQL語句
#                : r_sql1   關於glaq_t的SQL語句
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_fix_acc_get_sql()
   DEFINE r_sql,r_sql1,r_sql2,r_sql3,r_sql4   STRING 
   
   LET r_sql=''
   LET r_sql1=''
   LET r_sql2=''
   LET r_sql3=''
   LET r_sql4=''
   IF tm.comp='Y' THEN
      LET r_sql =r_sql,",glar012"
      LET r_sql1=r_sql1,",glaq017"
      LET r_sql2=r_sql2,",glaq017 glar012"
      LET r_sql3=r_sql3," glar012 <> ' '"
      LET r_sql4=r_sql4," glaq017 <> ' '"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql =r_sql,",glar013"
      LET r_sql1=r_sql1,",glaq018"
      LET r_sql2=r_sql2,",glaq018 glar013"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar013 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar013 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq018 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq018 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql =r_sql,",glar014"
      LET r_sql1=r_sql1,",glaq019"
      LET r_sql2=r_sql2,",glaq019 glar014"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar014 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar014 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq019 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq019 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql =r_sql,",glar015"
      LET r_sql1=r_sql1,",glaq020"
      LET r_sql2=r_sql2,",glaq020 glar015"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar015 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar015 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq020 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq020 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql =r_sql,",glar016"
      LET r_sql1=r_sql1,",glaq021"
      LET r_sql2=r_sql2,",glaq021 glar016"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar016 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar016 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq021 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq021 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql =r_sql,",glar017"
      LET r_sql1=r_sql1,",glaq022"
      LET r_sql2=r_sql2,",glaq022 glar017"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar017 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar017 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq022 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq022 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad011='Y' THEN
      LET r_sql =r_sql,",glar018"
      LET r_sql1=r_sql1,",glaq023"
      LET r_sql2=r_sql2,",glaq023 glar018"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar018 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar018 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq023 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq023 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql =r_sql,",glar019"
      LET r_sql1=r_sql1,",glaq024"
      LET r_sql2=r_sql2,",glaq024 glar019"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar019 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar019 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq024 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq024 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql =r_sql,",glar051"
      LET r_sql1=r_sql1,",glaq051"
      LET r_sql2=r_sql2,",glaq051 glar051"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar051 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar051 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq051 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq051 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql =r_sql,",glar052"
      LET r_sql1=r_sql1,",glaq052"
      LET r_sql2=r_sql2,",glaq052 glar052"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar052 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar052 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq052 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq052 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql =r_sql,",glar053"
      LET r_sql1=r_sql1,",glaq053"
      LET r_sql2=r_sql2,",glaq053 glar053"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar053 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar053 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq053 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq053 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql =r_sql,",glar020"
      LET r_sql1=r_sql1,",glaq025"
      LET r_sql2=r_sql2,",glaq025 glar020"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar020 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar020 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq025 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq025 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
#   IF tm.glad014='Y' THEN
#      LET r_sql =r_sql,",glar021"
#      LET r_sql1=r_sql1,",glaq026"
#      LET r_sql2=r_sql2,",glaq026 glar021"
#   ELSE
#      LET r_sql =r_sql,",''"
#      LET r_sql1=r_sql1,",''"
#      LET r_sql2=r_sql2,",''"
#   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql =r_sql,",glar022"
      LET r_sql1=r_sql1,",glaq027"
      LET r_sql2=r_sql2,",glaq027 glar022"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar022 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar022 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq027 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq027 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql =r_sql,",glar023"
      LET r_sql1=r_sql1,",glaq028"
      LET r_sql2=r_sql2,",glaq028 glar023"
      IF NOT cl_null(r_sql3) THEN
         LET r_sql3=r_sql3," OR glar023 <> ' '"
      ELSE
         LET r_sql3=r_sql3," glar023 <> ' '"
      END IF
      IF NOT cl_null(r_sql4) THEN
         LET r_sql4=r_sql4," OR glaq028 <> ' '"
      ELSE
         LET r_sql4=r_sql4," glaq028 <> ' '"
      END IF
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad017='Y' THEN
      LET r_sql =r_sql,",glar024"
      LET r_sql1=r_sql1,",glaq029"
      LET r_sql2=r_sql2,",glaq029 glar024"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql =r_sql,",glar025"
      LET r_sql1=r_sql1,",glaq030"
      LET r_sql2=r_sql2,",glaq030 glar025"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql =r_sql,",glar026"
      LET r_sql1=r_sql1,",glaq031"
      LET r_sql2=r_sql2,",glaq031 glar026"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql =r_sql,",glar027"
      LET r_sql1=r_sql1,",glaq032"
      LET r_sql2=r_sql2,",glaq032 glar027"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql =r_sql,",glar028"
      LET r_sql1=r_sql1,",glaq033"
      LET r_sql2=r_sql2,",glaq033 glar028"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql =r_sql,",glar029"
      LET r_sql1=r_sql1,",glaq034"
      LET r_sql2=r_sql2,",glaq034 glar029"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql =r_sql,",glar030"
      LET r_sql1=r_sql1,",glaq035"
      LET r_sql2=r_sql2,",glaq035 glar030"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql =r_sql,",glar031"
      LET r_sql1=r_sql1,",glaq036"
      LET r_sql2=r_sql2,",glaq036 glar031"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql =r_sql,",glar032"
      LET r_sql1=r_sql1,",glaq037"
      LET r_sql2=r_sql2,",glaq037 glar032"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql =r_sql,",glar033"
      LET r_sql1=r_sql1,",glaq038"
      LET r_sql2=r_sql2,",glaq038 glar033"
   ELSE
      LET r_sql =r_sql,",''"
      LET r_sql1=r_sql1,",''"
      LET r_sql2=r_sql2,",''"
   END IF
   IF NOT cl_null(r_sql3) THEN
      LET r_sql3=" AND ( ",r_sql3," )"
   END IF
   IF NOT cl_null(r_sql4) THEN
      LET r_sql4=" AND ( ",r_sql4," )"
   END IF
   RETURN r_sql,r_sql1,r_sql2,r_sql3,r_sql4
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq770_fix_acc_sql(p_glaq017,p_glaq018,p_glaq019,p_glaq020,p_glaq021,p_glaq022,p_glaq023,p_glaq024,p_glaq025,p_glaq027,p_glaq028,p_glaq051,p_glaq052,p_glaq053)
#                  RETURNING r_sql,r_sql1
# Input parameter: p_glaq017,p_glaq018,p_glaq019,p_glaq020,p_glaq021,p_glaq022,p_glaq023,p_glaq024,p_glaq025,p_glaq027,p_glaq028,p_glaq051,p_glaq052,p_glaq053  14個固定核算項   传入参数变量说明1
# Return code....: r_sql，r_sql1 組合SQL語句
# Date & Author..: 2014/03/30 By 02599
# Modify.........: 加10個自由核算項
################################################################################
PRIVATE FUNCTION aglq770_fix_acc_sql(p_glaq017,p_glaq018,p_glaq019,p_glaq020,p_glaq021,p_glaq022,p_glaq023,p_glaq024,p_glaq025,p_glaq027,p_glaq028,p_glaq051,p_glaq052,p_glaq053,p_glaq029,p_glaq030,p_glaq031,p_glaq032,p_glaq033,p_glaq034,p_glaq035,p_glaq036,p_glaq037,p_glaq038)
   DEFINE p_glaq017            LIKE glaq_t.glaq017
   DEFINE p_glaq018            LIKE glaq_t.glaq018
   DEFINE p_glaq019            LIKE glaq_t.glaq019
   DEFINE p_glaq020            LIKE glaq_t.glaq020
   DEFINE p_glaq021            LIKE glaq_t.glaq021
   DEFINE p_glaq022            LIKE glaq_t.glaq022
   DEFINE p_glaq023            LIKE glaq_t.glaq023
   DEFINE p_glaq024            LIKE glaq_t.glaq024
   DEFINE p_glaq051            LIKE glaq_t.glaq051
   DEFINE p_glaq052            LIKE glaq_t.glaq052
   DEFINE p_glaq053            LIKE glaq_t.glaq053
   DEFINE p_glaq025            LIKE glaq_t.glaq025
   DEFINE p_glaq027            LIKE glaq_t.glaq027
   DEFINE p_glaq028            LIKE glaq_t.glaq028
   DEFINE p_glaq029            LIKE glaq_t.glaq029
   DEFINE p_glaq030            LIKE glaq_t.glaq030
   DEFINE p_glaq031            LIKE glaq_t.glaq031
   DEFINE p_glaq032            LIKE glaq_t.glaq032
   DEFINE p_glaq033            LIKE glaq_t.glaq033
   DEFINE p_glaq034            LIKE glaq_t.glaq034
   DEFINE p_glaq035            LIKE glaq_t.glaq035
   DEFINE p_glaq036            LIKE glaq_t.glaq036
   DEFINE p_glaq037            LIKE glaq_t.glaq037
   DEFINE p_glaq038            LIKE glaq_t.glaq038
   DEFINE r_sql,r_sql1         STRING
   
   LET r_sql=''
   LET r_sql1=''
   IF tm.comp='Y' THEN
      LET r_sql=r_sql," AND glar012='",p_glaq017,"'"
      LET r_sql1=r_sql1," AND glaq017='",p_glaq017,"'"
   END IF
   
   IF tm.glad007='Y' THEN
      LET r_sql=r_sql," AND glar013='",p_glaq018,"'"
      LET r_sql1=r_sql1," AND glaq018='",p_glaq018,"'"
   END IF
   
   IF tm.glad008='Y' THEN
      LET r_sql=r_sql," AND glar014='",p_glaq019,"'"
      LET r_sql1=r_sql1," AND glaq019='",p_glaq019,"'"
   END IF
   
   IF tm.glad009='Y' THEN
      LET r_sql=r_sql," AND glar015='",p_glaq020,"'"
      LET r_sql1=r_sql1," AND glaq020='",p_glaq020,"'"
   END IF
   
   IF tm.glad010='Y' THEN
      LET r_sql=r_sql," AND glar016='",p_glaq021,"'"
      LET r_sql1=r_sql1," AND glaq021='",p_glaq021,"'"
   END IF
   
   IF tm.glad027='Y' THEN
      LET r_sql=r_sql," AND glar017='",p_glaq022,"'"
      LET r_sql1=r_sql1," AND glaq022='",p_glaq022,"'"
   END IF
      
   IF tm.glad011='Y' THEN
      LET r_sql=r_sql," AND glar018='",p_glaq023,"'"
      LET r_sql1=r_sql1," AND glaq023='",p_glaq023,"'"
   END IF
   
   IF tm.glad012='Y' THEN
      LET r_sql=r_sql," AND glar019='",p_glaq024,"'"
      LET r_sql1=r_sql1," AND glaq024='",p_glaq024,"'"
   END IF
   
   #經營方式
   IF tm.glad031='Y' THEN
      LET r_sql=r_sql," AND glar051='",p_glaq051,"'"
      LET r_sql1=r_sql1," AND glaq051='",p_glaq051,"'"
   END IF
   
   #渠道
   IF tm.glad032='Y' THEN
      LET r_sql=r_sql," AND glar052='",p_glaq052,"'"
      LET r_sql1=r_sql1," AND glaq052='",p_glaq051,"'"
   END IF
   
   #品牌
   IF tm.glad033='Y' THEN
      LET r_sql=r_sql," AND glar053='",p_glaq053,"'"
      LET r_sql1=r_sql1," AND glaq053='",p_glaq053,"'"
   END IF
   
   IF tm.glad013='Y' THEN
      LET r_sql=r_sql," AND glar020='",p_glaq025,"'"
      LET r_sql1=r_sql1," AND glaq025='",p_glaq025,"'"
   END IF
   
#   IF tm.glad014='Y' THEN
#      IF p_glaq026 IS NULL THEN
#         LET r_sql=r_sql," AND glar021 IS NULL "
#         LET r_sql1=r_sql1," AND glaq026 IS NULL "
#      ELSE
#         LET r_sql=r_sql," AND glar021='",p_glaq026,"'"
#         LET r_sql1=r_sql1," AND glaq026='",p_glaq026,"'"
#      END IF
#   END IF
   
   IF tm.glad015='Y' THEN
      LET r_sql=r_sql," AND glar022='",p_glaq027,"'"
      LET r_sql1=r_sql1," AND glaq027='",p_glaq027,"'"
   END IF
   
   IF tm.glad016='Y' THEN
      LET r_sql=r_sql," AND glar023='",p_glaq028,"'"
      LET r_sql1=r_sql1," AND glaq028='",p_glaq028,"'"
   END IF
   IF tm.glad017='Y' THEN
      LET r_sql=r_sql," AND glar024='",p_glaq029,"'"
      LET r_sql1=r_sql1," AND glaq029='",p_glaq029,"'"
   END IF
   
   IF tm.glad018='Y' THEN
      LET r_sql=r_sql," AND glar025='",p_glaq030,"'"
      LET r_sql1=r_sql1," AND glaq030='",p_glaq030,"'"
   END IF
   
   IF tm.glad019='Y' THEN
      LET r_sql=r_sql," AND glar026='",p_glaq031,"'"
      LET r_sql1=r_sql1," AND glaq031='",p_glaq031,"'"
   END IF
   
   IF tm.glad020='Y' THEN
      LET r_sql=r_sql," AND glar027='",p_glaq032,"'"
      LET r_sql1=r_sql1," AND glaq032='",p_glaq032,"'"
   END IF
   
   IF tm.glad021='Y' THEN
      LET r_sql=r_sql," AND glar028='",p_glaq033,"'"
      LET r_sql1=r_sql1," AND glaq033='",p_glaq033,"'"
   END IF
   
   IF tm.glad022='Y' THEN
      LET r_sql=r_sql," AND glar029='",p_glaq034,"'"
      LET r_sql1=r_sql1," AND glaq034='",p_glaq034,"'"
   END IF
   
   IF tm.glad023='Y' THEN
      LET r_sql=r_sql," AND glar030='",p_glaq035,"'"
      LET r_sql1=r_sql1," AND glaq035='",p_glaq035,"'"
   END IF
   
   IF tm.glad024='Y' THEN
      LET r_sql=r_sql," AND glar031='",p_glaq036,"'"
      LET r_sql1=r_sql1," AND glaq036='",p_glaq036,"'"
   END IF
   
   IF tm.glad025='Y' THEN
      LET r_sql=r_sql," AND glar032='",p_glaq037,"'"
      LET r_sql1=r_sql1," AND glaq037='",p_glaq037,"'"
   END IF
   
   IF tm.glad026='Y' THEN
      LET r_sql=r_sql," AND glar033='",p_glaq038,"'"
      LET r_sql1=r_sql1," AND glaq038='",p_glaq038,"'"
   END IF
   RETURN r_sql,r_sql1
END FUNCTION

################################################################################
# Descriptions...: 设置分页
# Memo...........:
# Usage..........: CALL aglq770_set_page()
# Date & Author..: 2014/03/30 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_set_page()
   DEFINE l_sql    STRING
   DEFINE l_idx    LIKE type_t.num5
   
   CALL g_glaq_s.clear()
   IF tm.curr_p <>'Y' AND tm.acc_p<>'Y' THEN
      LET g_glaq_s[1].glaq002=''
      LET g_glaq_s[1].glaq005=''
      LET g_header_cnt = 1
      LET g_rec_b = 1
   ELSE
      CASE   
         WHEN tm.acc_p='Y' AND tm.curr_p<>'Y' 
            LET l_sql="SELECT DISTINCT glaq002,'' FROM aglq770_tmp ORDER BY glaq002 "
         WHEN tm.acc_p='Y' AND tm.curr_p='Y'
            LET l_sql="SELECT DISTINCT glaq002,glaq005 FROM aglq770_tmp ORDER BY glaq002,glaq005 "
         WHEN tm.acc_p<>'Y' AND tm.curr_p='Y'
            LET l_sql="SELECT DISTINCT '',glaq005 FROM aglq770_tmp ORDER BY glaq005 "
      END CASE
      PREPARE aglq770_sel_s_pr FROM l_sql
      DECLARE aglq770_sel_s_cr CURSOR FOR aglq770_sel_s_pr
      LET l_idx=1
      FOREACH aglq770_sel_s_cr INTO g_glaq_s[l_idx].glaq002,g_glaq_s[l_idx].glaq005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'FOREACH aglq770_sel_s_cr'
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         LET l_idx=l_idx+1
         IF l_idx > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 9035
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
      END FOREACH
      LET l_idx = l_idx - 1
      CALL g_glaq_s.deleteElement(g_glaq_s.getLength())
      LET g_header_cnt = g_glaq_s.getLength()
      LET g_rec_b = l_idx
   END IF
   DISPLAY g_header_cnt TO FORMONLY.h_count
END FUNCTION

################################################################################
# Descriptions...: 動態設定元件是否需輸入值
# Memo...........:
# Usage..........: CALL aglq770_set_comp_entry(ps_fields,pi_entry)
# Input parameter: ps_fields   欄位名稱
#                : pi_entry    是否進入欄位
# Date & Author..: 2014/04/10 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_set_comp_entry(ps_fields,pi_entry)
   DEFINE ps_fields STRING,
          pi_entry  LIKE type_t.num5           
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,        
          lnode_item    om.DomNode,
          ls_item_name  STRING
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
      RETURN
   END IF
 
   IF (ps_fields IS NULL) THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               LET ls_item_name = lnode_item.getAttribute("name")
 
               IF (ls_item_name IS NULL) THEN
                  CONTINUE FOR
               END IF
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_entry) THEN
                  CALL lnode_item.setAttribute("noEntry", "0")
                  CALL lnode_item.setAttribute("active", "1")
               ELSE
                  CALL lnode_item.setAttribute("noEntry", "1")
                  CALL lnode_item.setAttribute("active", "0")
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 接受传参
# Memo...........:
# Usage..........: CALL aglq770_default_search()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_default_search()
   #帳別
   IF NOT cl_null(g_argv[01]) THEN
      LET g_glaald = g_argv[01]
   END IF
   #年度
   IF NOT cl_null(g_argv[02]) THEN
      LET tm.syear = g_argv[02]
      LET tm.eyear = g_argv[02]
   END IF
   #起始期別
   IF NOT cl_null(g_argv[03]) THEN
      LET tm.speriod = g_argv[03]
   END IF
   #截止期別
   IF NOT cl_null(g_argv[04]) THEN
      LET tm.eperiod = g_argv[04]
   END IF
   
   #多本位幣顯示
   IF NOT cl_null(g_argv[05]) THEN
      LET tm.ctype = g_argv[05]
   END IF
   #顯示原幣
   IF NOT cl_null(g_argv[06]) THEN
      LET tm.curr_o = g_argv[06]
   END IF
   #按幣別分頁
   IF NOT cl_null(g_argv[07]) THEN
      LET tm.curr_p = g_argv[07]
   END IF
   #按科目分頁
   IF NOT cl_null(g_argv[08]) THEN
      LET tm.acc_p = g_argv[08]
   END IF
   #統制科目
   IF NOT cl_null(g_argv[09]) THEN
      LET tm.show_acc = g_argv[09]
   END IF
   #科目層級
   IF NOT cl_null(g_argv[10]) THEN
      LET tm.glac005 = g_argv[10]
   END IF
   #單據狀態
   IF NOT cl_null(g_argv[11]) THEN
      LET tm.stus = g_argv[11]
   END IF
   #含內部管理科目
   IF NOT cl_null(g_argv[12]) THEN
      LET tm.glac009 = g_argv[12]
   END IF
   #含月結傳票
   IF NOT cl_null(g_argv[13]) THEN
      LET tm.show_ce = g_argv[13]
   END IF
   #含年結傳票
   IF NOT cl_null(g_argv[14]) THEN
      LET tm.show_ye = g_argv[14]
   END IF
   #营运据点
   IF NOT cl_null(g_argv[15]) THEN
      LET tm.comp = g_argv[15]
   END IF
   #部门管理
   IF NOT cl_null(g_argv[16]) THEN
      LET tm.glad007 = g_argv[16]
   END IF
   #利润成本
   IF NOT cl_null(g_argv[17]) THEN
      LET tm.glad008 = g_argv[17]
   END IF
   #区域管理
   IF NOT cl_null(g_argv[18]) THEN
      LET tm.glad009 = g_argv[18]
   END IF
   #交易客商
   IF NOT cl_null(g_argv[19]) THEN
      LET tm.glad010 = g_argv[19]
   END IF
   #账款客商
   IF NOT cl_null(g_argv[20]) THEN
      LET tm.glad027 = g_argv[20]
   END IF
   #客群
   IF NOT cl_null(g_argv[21]) THEN
      LET tm.glad011 = g_argv[21]
   END IF
   #产品类别
   IF NOT cl_null(g_argv[22]) THEN
      LET tm.glad012 = g_argv[22]
   END IF
   #经营方式
   IF NOT cl_null(g_argv[23]) THEN
      LET tm.glad031 = g_argv[23]
   END IF
   #渠道
   IF NOT cl_null(g_argv[24]) THEN
      LET tm.glad032 = g_argv[24]
   END IF
   #品牌
   IF NOT cl_null(g_argv[25]) THEN
      LET tm.glad033 = g_argv[25]
   END IF
   #人员
   IF NOT cl_null(g_argv[26]) THEN
      LET tm.glad013 = g_argv[26]
   END IF
   #专案
   IF NOT cl_null(g_argv[27]) THEN
      LET tm.glad015 = g_argv[27]
   END IF
   #WBS
   IF NOT cl_null(g_argv[28]) THEN
      LET tm.glad016 = g_argv[28]
   END IF
   #自由核算项一
   IF NOT cl_null(g_argv[29]) THEN
      LET tm.glad017 = g_argv[29]
   END IF
   #自由核算项二
   IF NOT cl_null(g_argv[30]) THEN
      LET tm.glad018 = g_argv[30]
   END IF
   #自由核算项三
   IF NOT cl_null(g_argv[31]) THEN
      LET tm.glad019 = g_argv[31]
   END IF
   #自由核算项四
   IF NOT cl_null(g_argv[32]) THEN
      LET tm.glad020 = g_argv[32]
   END IF
   #自由核算项五
   IF NOT cl_null(g_argv[33]) THEN
      LET tm.glad021 = g_argv[33]
   END IF
   #自由核算项六
   IF NOT cl_null(g_argv[34]) THEN
      LET tm.glad022 = g_argv[34]
   END IF
   #自由核算项七
   IF NOT cl_null(g_argv[35]) THEN
      LET tm.glad023 = g_argv[35]
   END IF
   #自由核算项八
   IF NOT cl_null(g_argv[36]) THEN
      LET tm.glad024 = g_argv[36]
   END IF
   #自由核算项九
   IF NOT cl_null(g_argv[37]) THEN
      LET tm.glad025 = g_argv[37]
   END IF
   #自由核算项十
   IF NOT cl_null(g_argv[38]) THEN
      LET tm.glad026 = g_argv[38]
   END IF
   #科目
   IF NOT cl_null(g_argv[39]) THEN
      LET g_wc_glaq002 = " glaq002 = '",g_argv[39],"'"
   END IF
   #营运据点
   IF NOT cl_null(g_argv[40]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq017 = '",g_argv[40],"'"
      ELSE
         LET g_wc = g_wc," AND glaq017 = '",g_argv[40],"'"
      END IF
   END IF
   #部门管理
   IF NOT cl_null(g_argv[41]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq018 = '",g_argv[41],"'"
      ELSE
         LET g_wc = g_wc," AND glaq018 = '",g_argv[41],"'"
      END IF
   END IF
   #利润成本
   IF NOT cl_null(g_argv[42]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq019 = '",g_argv[42],"'"
      ELSE
         LET g_wc = g_wc," AND glaq019 = '",g_argv[42],"'"
      END IF
   END IF
   #区域管理
   IF NOT cl_null(g_argv[43]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq020 = '",g_argv[43],"'"
      ELSE
         LET g_wc = g_wc," AND glaq020 = '",g_argv[43],"'"
      END IF
   END IF


   #交易客商
   IF NOT cl_null(g_argv[44]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq021 = '",g_argv[44],"'"
      ELSE
         LET g_wc = g_wc," AND glaq021 = '",g_argv[44],"'"
      END IF
   END IF
   #账款客商
   IF NOT cl_null(g_argv[45]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq022 = '",g_argv[45],"'"
      ELSE
         LET g_wc = g_wc," AND glaq022 = '",g_argv[45],"'"
      END IF
   END IF
   #客群
   IF NOT cl_null(g_argv[46]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq023 = '",g_argv[46],"'"
      ELSE
         LET g_wc = g_wc," AND glaq023 = '",g_argv[46],"'"
      END IF
   END IF
   #产品类别
   IF NOT cl_null(g_argv[47]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq024 = '",g_argv[47],"'"
      ELSE
         LET g_wc = g_wc," AND glaq024 = '",g_argv[47],"'"
      END IF
   END IF
   #经营方式
   IF NOT cl_null(g_argv[48]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq051 = '",g_argv[48],"'"
      ELSE
         LET g_wc = g_wc," AND glaq051 = '",g_argv[48],"'"
      END IF
   END IF
   #渠道
   IF NOT cl_null(g_argv[49]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq052 = '",g_argv[49],"'"
      ELSE
         LET g_wc = g_wc," AND glaq052 = '",g_argv[49],"'"
      END IF
   END IF
   #品牌
   IF NOT cl_null(g_argv[50]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq053 = '",g_argv[50],"'"
      ELSE
         LET g_wc = g_wc," AND glaq053 = '",g_argv[50],"'"
      END IF
   END IF
   #人员
   IF NOT cl_null(g_argv[51]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq025 = '",g_argv[51],"'"
      ELSE
         LET g_wc = g_wc," AND glaq025 = '",g_argv[51],"'"
      END IF
   END IF
   #专案
   IF NOT cl_null(g_argv[52]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq027 = '",g_argv[52],"'"
      ELSE
         LET g_wc = g_wc," AND glaq027 = '",g_argv[52],"'"
      END IF
   END IF
   #WBS
   IF NOT cl_null(g_argv[53]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq028 = '",g_argv[53],"'"
      ELSE
         LET g_wc = g_wc," AND glaq028 = '",g_argv[53],"'"
      END IF
   END IF
   #自由核算项一
   IF NOT cl_null(g_argv[54]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq029 = '",g_argv[54],"'"
      ELSE
         LET g_wc = g_wc," AND glaq029 = '",g_argv[54],"'"
      END IF
   END IF
   #自由核算项二
   IF NOT cl_null(g_argv[55]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq030 = '",g_argv[55],"'"
      ELSE
         LET g_wc = g_wc," AND glaq030 = '",g_argv[55],"'"
      END IF
   END IF
   #自由核算项三
   IF NOT cl_null(g_argv[56]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq031 = '",g_argv[56],"'"
      ELSE
         LET g_wc = g_wc," AND glaq031 = '",g_argv[56],"'"
      END IF
   END IF
   #自由核算项四
   IF NOT cl_null(g_argv[57]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq032 = '",g_argv[57],"'"
      ELSE
         LET g_wc = g_wc," AND glaq032 = '",g_argv[57],"'"
      END IF
   END IF
   #自由核算项五
   IF NOT cl_null(g_argv[58]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq033 = '",g_argv[58],"'"
      ELSE
         LET g_wc = g_wc," AND glaq033 = '",g_argv[58],"'"
      END IF
   END IF
   #自由核算项六
   IF NOT cl_null(g_argv[59]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq034 = '",g_argv[59],"'"
      ELSE
         LET g_wc = g_wc," AND glaq034 = '",g_argv[59],"'"
      END IF
   END IF
   #自由核算项七
   IF NOT cl_null(g_argv[60]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq035 = '",g_argv[60],"'"
      ELSE
         LET g_wc = g_wc," AND glaq035 = '",g_argv[60],"'"
      END IF
   END IF
   #自由核算项八
   IF NOT cl_null(g_argv[61]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq036 = '",g_argv[61],"'"
      ELSE
         LET g_wc = g_wc," AND glaq036 = '",g_argv[61],"'"
      END IF
   END IF
   #自由核算项九
   IF NOT cl_null(g_argv[62]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq037 = '",g_argv[62],"'"
      ELSE
         LET g_wc = g_wc," AND glaq037 = '",g_argv[62],"'"
      END IF
   END IF
   #自由核算项十
   IF NOT cl_null(g_argv[63]) THEN
      IF cl_null(g_wc) THEN 
         LET g_wc = " glaq038 = '",g_argv[63],"'"
      ELSE
         LET g_wc = g_wc," AND glaq038 = '",g_argv[63],"'"
      END IF
   END IF
   #150827-00036#2--add--str--
   #含審計調整傳票否
   IF NOT cl_null(g_argv[64]) THEN
      LET tm.show_ad = g_argv[64]
   END IF
   #150827-00036#2--add--end
   IF cl_null(g_wc) THEN 
      LET g_wc = " 1=1 "
   END IF
END FUNCTION

################################################################################
# Descriptions...: 设置单身核算项栏位线是否
# Memo...........:
# Usage..........: CALL  aglq770_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_visible()
   IF tm.comp='Y' THEN
      CALL cl_set_comp_visible("b_glaq017,b_glaq017_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq017,b_glaq017_desc",FALSE)
   END IF
   IF tm.glad007='Y' THEN
      CALL cl_set_comp_visible("b_glaq018,b_glaq018_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq018,b_glaq018_desc",FALSE)
   END IF
   IF tm.glad008='Y' THEN
      CALL cl_set_comp_visible("b_glaq019,b_glaq019_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq019,b_glaq019_desc",FALSE)
   END IF
   IF tm.glad009='Y' THEN
      CALL cl_set_comp_visible("b_glaq020,b_glaq020_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq020,b_glaq020_desc",FALSE)
   END IF
   IF tm.glad010='Y' THEN
      CALL cl_set_comp_visible("b_glaq021,b_glaq021_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq021,b_glaq021_desc",FALSE)
   END IF
   IF tm.glad027='Y' THEN
      CALL cl_set_comp_visible("b_glaq022,b_glaq022_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq022,b_glaq022_desc",FALSE)
   END IF
   IF tm.glad011='Y' THEN
      CALL cl_set_comp_visible("b_glaq023,b_glaq023_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq023,b_glaq023_desc",FALSE)
   END IF
   IF tm.glad012='Y' THEN
      CALL cl_set_comp_visible("b_glaq024,b_glaq024_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq024,b_glaq024_desc",FALSE)
   END IF
   IF tm.glad031='Y' THEN
      CALL cl_set_comp_visible("b_glaq051",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq051",FALSE)
   END IF
   IF tm.glad032='Y' THEN
      CALL cl_set_comp_visible("b_glaq052,b_glaq052_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq052,b_glaq052_desc",FALSE)
   END IF
   IF tm.glad033='Y' THEN
      CALL cl_set_comp_visible("b_glaq053,b_glaq053_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq053,b_glaq053_desc",FALSE)
   END IF
   IF tm.glad013='Y' THEN
      CALL cl_set_comp_visible("b_glaq025,glaq025_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq025,glaq025_desc",FALSE)
   END IF 
   IF tm.glad015='Y' THEN
      CALL cl_set_comp_visible("b_glaq027,b_glaq027_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq027,b_glaq027_desc",FALSE)
   END IF
   IF tm.glad016='Y' THEN
      CALL cl_set_comp_visible("b_glaq028,b_glaq028_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq028,b_glaq028_desc",FALSE)
   END IF
   IF tm.glad017='Y' THEN
      CALL cl_set_comp_visible("b_glaq029,b_glaq029_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq029,b_glaq029_desc",FALSE)
   END IF
   IF tm.glad018='Y' THEN
      CALL cl_set_comp_visible("b_glaq030,b_glaq030_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq030,b_glaq030_desc",FALSE)
   END IF
   IF tm.glad019='Y' THEN
      CALL cl_set_comp_visible("b_glaq031,b_glaq031_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq031,b_glaq031_desc",FALSE)
   END IF
   IF tm.glad020='Y' THEN
      CALL cl_set_comp_visible("b_glaq032,b_glaq032_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq032,b_glaq032_desc",FALSE)
   END IF
   IF tm.glad021='Y' THEN
      CALL cl_set_comp_visible("b_glaq033,b_glaq033_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq033,b_glaq033_desc",FALSE)
   END IF
   IF tm.glad022='Y' THEN
      CALL cl_set_comp_visible("b_glaq034,b_glaq034_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq034,b_glaq034_desc",FALSE)
   END IF
   IF tm.glad023='Y' THEN
      CALL cl_set_comp_visible("b_glaq035,b_glaq035_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq035,b_glaq035_desc",FALSE)
   END IF
   IF tm.glad024='Y' THEN
      CALL cl_set_comp_visible("b_glaq036,b_glaq036_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq036,b_glaq036_desc",FALSE)
   END IF
   IF tm.glad025='Y' THEN
      CALL cl_set_comp_visible("b_glaq037,b_glaq037_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq037,b_glaq037_desc",FALSE)
   END IF
   IF tm.glad026='Y' THEN
      CALL cl_set_comp_visible("b_glaq038,b_glaq038_desc",TRUE)
   ELSE
      CALL cl_set_comp_visible("b_glaq038,b_glaq038_desc",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 串查aglt310凭证
# Memo...........:
# Usage..........: CALL aglq770_cmdrun()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq770_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   DEFINE l_glap001    LIKE glap_t.glap001
   
   SELECT glap001 INTO l_glap001 FROM glap_t 
    WHERE glapent=g_enterprise AND glapld=g_glaald AND glapdocno=g_glaq_d[g_detail_idx].glaqdocno
    
   INITIALIZE la_param.* TO NULL
   #傳票性質
   CASE l_glap001
      WHEN '1'
         LET la_param.prog = 'aglt310'
      WHEN '2'
         LET la_param.prog = 'aglt320'
      WHEN '3'
         LET la_param.prog = 'aglt330'
      WHEN '4'
         LET la_param.prog = 'aglt340'
      WHEN '5'
         LET la_param.prog = 'aglt350'
      WHEN '6'
         LET la_param.prog = 'aglt410'
   END CASE
   LET la_param.param[1] = g_glaald    #帳別
   LET la_param.param[2] = g_glaq_d[g_detail_idx].glaqdocno     #傳票單號 
   LET ls_js = util.JSON.stringify( la_param )
   CALL cl_cmdrun(ls_js)
END FUNCTION

 
{</section>}
 
