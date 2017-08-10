#該程式未解開Section, 採用最新樣板產出!
{<section id="asft310_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0047(2017-01-03 16:42:40), PR版次:0047(2017-07-06 13:50:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000536
#+ Filename...: asft310_01
#+ Description: 發料需求產生
#+ Creator....: 00768(2013-12-26 10:27:53)
#+ Modifier...: 00768 -SD/PR- 04441
 
{</section>}
 
{<section id="asft310_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#141203 當工單未指定特徵時，自動產生發料需求自動帶出有庫存的特徵資料
#       退料单要也要卡控特征对应已发的数量，不能超过已发数量
#141211 asft310_01原沒有庫位的就不會產生到單身
#       改成
#       沒有庫位資料的也產生到單身去，只是實際數量為0，然後要可以確認、過帳
#       （实务说明：申請的人輸入單據，確認；到倉庫那確實沒有庫存，那實際量就0，其他的有庫存還是要發）
#141219-00017需求
#       產生發料申請資料，選依1 or 2時，沒庫存的帶出來資料，庫位、儲位、批號給空白
#141226 欠料補料輸入工單時，如果無欠料資訊請提出警示，並不允許輸入，如輸入後在自動產生申請資料時，如果找不到資料也給提示
#150101 单位转换率改写
#150107 补足仓储批开窗管控，工单指定的开窗筛选，不可直接为空格
#150115 对数量做单位取位
#150309 在申请数量处增加欠料补料的检查
#151204 資料異動時異動條碼資料(bcae_t,bcaf_t)
#151224-00025#4   2015/12/28   By yihsuan    手動輸入特徵碼同步新增inam_t[料件產品特徵明細檔]
#160128-00004#1   2016/03/10   By dorislai   修正校驗指定庫位(sfdc012)與開窗值不一致問題。問題：少了開窗多加的where條件
#160309-00006#1   2016/03/11   By Ann_Huang  1.修正分站投料時，沒有加上調整數量，導致發料量錯誤(#160127)
#                                            2.已過帳工单发料套数扣除退料套数，若与生产数量相等时，须加上应发数量，否则不用。
#160314-00009#16  2016/03/28   By xujing     产品特征自动开窗增加参数判断
#160408-00035#6   2016/04/15   By Sarah      如果工單有做硬備置，那麼發料單產生單身資料的時候，要自動帶出備置的庫儲批與數量
#160318-00025#21  2016/04/20   BY 07900      校验代码重复错误讯息的修改
#160512-00004#2   2016/06/21   By dorislai   依aimm212撿貨策略(imaf059)預帶庫儲批
#160706-00027#1   2016/07/21   By dorislai   修正同張工單，發第一筆備料的發料，尚未過帳，發第二筆備料的發料，會無法產生第二筆備料資料的問題
#                                            1.取S-MFG-0055的設定，為Y的話，照原本程式裡寫的
#                                                                 為N的話，應發總數量-已發數量-此張發料單已發數量，需多扣除其他單上的實際數量(sfdc008)
#160927-00030#1   2016/10/11   By Whitney    由備置資料帶庫存管理特徵
#161109-00085#30  2016/11/11   By lienjunqi  整批調整系統星號寫法
#161115-00034#1   2016/11/17   By ouhz       调整asft311通过发料需求产生功能修改申请数量后，会清空仓储信息
#161118-00033#1   2016/11/18   By Whitney    修正#160927-00030#1 into g_sfba.*
#161109-00085#62  2016/11/28   By 08171      整批調整系統星號寫法
#160824-00007#251 2016/12/19   By sakura     新舊值備份處理
#170103-00017#1   2017/01/03   By 00768      增加整批删除单身功能
#170104-00066#2   2017/01/06   By Rainy      筆數相關變數由num5放大至num10
#170110-00005#1   2017/01/10   By liuym      退料选择库位、储位时，不许过滤库位是否有inag库存记录
#170112-00063#1   2017/01/23   By Whitney    發料需求產生，產生方式選3:依庫存量發料(QBE)，須依aini001的[inaa006撿料優先順序]欄位做排序
#170118-00020#1   2017/01/23   By Whitney    asft310_01_gen()退料同發料，库位为空的产生到需求页签
#170207-00039#1   2017/02/07   By Whitney    庫存出庫的單子沒庫存要先打都要可以先打，並修正170112-00063
#161205-00025#6   2017/02/09   By Whitney    效能优化
#160726-00001#6   2017/02/14   By Whitney    增加工單群組替代功能
#170309-00013#1   2017/03/30   By catmoon47  當生產方式為自行指定庫儲批時，有填入庫位則儲位開窗增加庫位條件
#170330-00003#1   2017/04/05   By fionchen   有取替代時,計算成套應發數量錯誤
#170324-00073#1   2017/04/10   By xujing     管控不使用批号和储位的时候,不可输入
#170324-00112#1   2017/04/11   By xujing     发料需求产生方式2,3增加捡货策略逻辑
#170411-00020#1   2017/04/12   By xujing     修改取工单单别D-MFG-0070改为去D-BAS-0070
#170329-00100#1   2017/04/14   By fionchen   修改若有群組替代時,手動新增發料項次時,申請量有誤
#170427-00058#1   2017/05/03   By xujing     根据库存展发料明细的时候捡货策略,库位优先级做排序
#170512-00023#1   2017/05/17   By Whitney    沒有維護庫位也要根據參數做在揀數量的檢核
#170516-00063#1   2017/05/24   By Whitney    1.生成方式選擇1或2且庫存不足仍產生則將指定庫儲帶入
#                                            2.單別參數設定D-BAS-0070出库单据考虑在拣量=N則發料需求產生的子畫面的單身欄位不做庫存量檢查
#170602-00036#1   2017/06/15   By fionchen   產生發料明細時,執行取庫儲批時,傳入單據編號改為發料單號
#170614-00004#1   2017/06/15   By 08992      修正ACTION controlp INFIELD sfdc013 儲位開窗段,若已有輸入庫位資料,則不管庫儲是否可修改,開窗條件皆須加上庫位資料
#170704-00048#1   2017/07/06   By Whitney    修正170516-00063
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util  #160726-00001#6
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="asft310_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
DEFINE g_sfdadocno  LIKE sfda_t.sfdadocno
DEFINE g_success    LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_success_tot  LIKE type_t.num5
DEFINE g_para         LIKE type_t.chr80 #单别参数
DEFINE g_ref_unit     LIKE type_t.chr1  #是否启用参考单位
DEFINE g_ooba002      LIKE ooba_t.ooba002  #单别
DEFINE g_count        LIKE type_t.num5  #此次单身产生笔数 #add 141226

DEFINE g_choice       LIKE type_t.chr1

#單頭 type 宣告
DEFINE tm           RECORD
                    wc          STRING,                #QBE
                    issue_type  LIKE type_t.chr1,      #产生方式
                    less        LIKE type_t.chr1,      #库存不足仍产生
                    expand      LIKE type_t.chr1,      #自动展至仓储批
                    return      LIKE type_t.chr1,      #依发料批号退料
                    reason      LIKE oocq_t.oocq002,   #预设理由码
                    reason_desc LIKE oocql_t.oocql004  #预设理由码说明
                    END RECORD
DEFINE tm2          RECORD
                    wc          STRING,                   #QBE
                    inag004_i   LIKE inag_t.inag004,      #库位
                    inag005_i   LIKE inag_t.inag005,      #储位
                    inag006_i   LIKE inag_t.inag006,      #批号
                    inag003_i   LIKE inag_t.inag003       #库存管理特征
                    END RECORD
#單身 type 宣告
 TYPE type_g_sfdc_d        RECORD
   sfdcseq LIKE sfdc_t.sfdcseq,
   sfdc001 LIKE sfdc_t.sfdc001,
   sfdc002 LIKE sfdc_t.sfdc002,
   sfdc003 LIKE sfdc_t.sfdc003,
   sfba002 LIKE type_t.chr80, 
   sfba002_desc LIKE type_t.chr80, 
   sfba003 LIKE type_t.chr80, 
   sfba003_desc LIKE type_t.chr80, 
   sfba004 LIKE type_t.chr80, 
   sfdc004 LIKE sfdc_t.sfdc004,
   sfdc004_desc LIKE type_t.chr500,
   sfdc004_desc2 LIKE type_t.chr80, 
   sfdc005 LIKE sfdc_t.sfdc005,
   sfdc005_desc LIKE type_t.chr500,
   sfba028 LIKE type_t.chr80,  
   imae092 LIKE type_t.chr80, 
   imaf034 LIKE type_t.chr80,
   sfdc006 LIKE sfdc_t.sfdc006,
   sfdc006_desc LIKE type_t.chr500,
   sfba013 LIKE type_t.chr80, 
   sfba016 LIKE type_t.chr80, 
   sfdc007 LIKE sfdc_t.sfdc007,
   sfdc009 LIKE sfdc_t.sfdc009,
   sfdc009_desc LIKE type_t.chr500,
   sfdc010 LIKE sfdc_t.sfdc010,
   sfdc012 LIKE sfdc_t.sfdc012,
   sfdc012_desc LIKE type_t.chr500,
   sfdc013 LIKE sfdc_t.sfdc013,
   sfdc013_desc LIKE type_t.chr500,
   sfdc014 LIKE sfdc_t.sfdc014,
   sfdc016 LIKE sfdc_t.sfdc016,
   sfdc015 LIKE sfdc_t.sfdc015,
   sfdc015_desc LIKE type_t.chr500
       END RECORD



#模組變數(Module Variables)

DEFINE g_sfdc_d          DYNAMIC ARRAY OF type_g_sfdc_d
DEFINE g_sfdc_d_t        type_g_sfdc_d
DEFINE g_sfdc_d_o        type_g_sfdc_d   #160824-00007#251 by sakura add

DEFINE g_sql                 STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_rec_b               LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_ac                  LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 

DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數   #170104-00066#2 num5->num10  17/01/06 mod by rainy 

DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_sfdc012_switch      LIKE type_t.chr1   #庫位        可输入性 Y可输入 N不可输入
DEFINE g_sfdc013_switch      LIKE type_t.chr1   #儲位        可输入性 Y可输入 N不可输入
DEFINE g_sfdc014_switch      LIKE type_t.chr1   #批號        可输入性 Y可输入 N不可输入
DEFINE g_sfdc016_switch      LIKE type_t.chr1   #庫存管理特徵 可输入性 Y可输入 N不可输入

DEFINE g_bas_0043            LIKE type_t.chr80             #S-BAS-0043(VMI存貨庫位Tag)
DEFINE g_bas_0070            LIKE type_t.chr1              #170516-00063#1

#end add-point
 
{</section>}
 
{<section id="asft310_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
#161109-00085#30-s
#DEFINE g_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE g_sfba       RECORD LIKE sfba_t.*   #工单备料单身
#DEFINE g_sfda       RECORD LIKE sfda_t.*   #发退料单头
DEFINE g_sfba RECORD  #工單備料單身檔
       sfbaent LIKE sfba_t.sfbaent, #企業編號
       sfbasite LIKE sfba_t.sfbasite, #營運據點
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba001 LIKE sfba_t.sfba001, #上階料號
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba005 LIKE sfba_t.sfba005, #BOM料號
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba007 LIKE sfba_t.sfba007, #投料時距
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba009 LIKE sfba_t.sfba009, #倒扣料
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba012 LIKE sfba_t.sfba012, #允許誤差率
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba018 LIKE sfba_t.sfba018, #盤虧數量
       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
       sfba021 LIKE sfba_t.sfba021, #產品特徵
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba024 LIKE sfba_t.sfba024, #調整應發數量
       sfba025 LIKE sfba_t.sfba025, #超領數量
       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
       sfba027 LIKE sfba_t.sfba027, #SET替代群組
       sfba028 LIKE sfba_t.sfba028, #客供料
       sfba029 LIKE sfba_t.sfba029, #指定發料批號
       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
       sfba031 LIKE sfba_t.sfba031, #備置量
       sfba032 LIKE sfba_t.sfba032, #備置理由碼
       sfba033 LIKE sfba_t.sfba033, #保稅否
       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
       sfba035 LIKE sfba_t.sfba035  #SET替代套數
      ,sfba036 LIKE sfba_t.sfba036  #SET已替代套數  #160726-00001#6
END RECORD
DEFINE g_sfda RECORD  #發退料單頭檔
       sfda002 LIKE sfda_t.sfda002, #發退料類別
       sfdastus LIKE sfda_t.sfdastus #狀態碼
END RECORD
#161109-00085#30-e
DEFINE issue_qty    LIKE sfdc_t.sfdc007    #发料单的(发料套数对应的)应发数量
DEFINE issue_qty1   LIKE sfdc_t.sfdc007    #剩余应发数量
DEFINE issue_qty2   LIKE sfdc_t.sfdc007    #当笔需插入单身的应发量
DEFINE g_imaf091    LIKE imaf_t.imaf091    #料件预设库位
DEFINE g_imaf092    LIKE imaf_t.imaf092    #料件预设储位
DEFINE g_imae101    LIKE imae_t.imae101    #在制发料库位
DEFINE g_imae102    LIKE imae_t.imae102    #在制发料储位
DEFINE g_imae103    LIKE imae_t.imae103    #在制退料库位
DEFINE g_imae104    LIKE imae_t.imae104    #在制退料储位
DEFINE g_imae092    LIKE imae_t.imae092    #发料前调拨
DEFINE g_imaa005    LIKE imaa_t.imaa005    #产品特征
DEFINE g_qty_t      LIKE sfdc_t.sfdc007    #add 150101数量 中间变量
DEFINE g_ooca002    LIKE ooca_t.ooca002    #小數位數  #add 150115
DEFINE g_ooca004    LIKE ooca_t.ooca004    #捨入類型  #add 150115
DEFINE g_sfbb_cnt   LIKE type_t.num10       #160408-00035#6 add   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE g_sfbb_qty   LIKE sfbb_t.sfbb008    #160408-00035#6 add
DEFINE g_qty        LIKE sfbb_t.sfbb008    #160408-00035#6 add
DEFINE g_diff_qty   LIKE sfbb_t.sfbb008    #160408-00035#6 add
DEFINE g_para1      LIKE type_t.chr1       #160706-00027#1-add
#160726-00001#6-s
PRIVATE TYPE type_sfba_parameter RECORD
    sfbadocno  LIKE sfba_t.sfbadocno,  #單號
    sfbaseq    LIKE sfba_t.sfbaseq,    #項次
    sfbaseq1   LIKE sfba_t.sfbaseq1,   #項序
    sfba006    LIKE sfba_t.sfba006,    #發料料號
    sfba013    LIKE sfba_t.sfba013,    #應發數量
    sfba014    LIKE sfba_t.sfba014,    #單位
    sfba016    LIKE sfba_t.sfba016,    #已發數量
    sfba021    LIKE sfba_t.sfba021,    #產品特徵
    sfba029    LIKE sfba_t.sfba029,    #指定發料批號
    sfba030    LIKE sfba_t.sfba030     #指定庫存管理特徵
                END RECORD
#160726-00001#6-e
#end add-point
 
{</section>}
 
{<section id="asft310_01.other_dialog" >}

 
{</section>}
 
{<section id="asft310_01.other_function" readonly="Y" >}

PRIVATE FUNCTION asft310_01_init()
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_error_show = 1


   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   #add-point:畫面資料初始化
   CALL cl_set_combo_scc_part('sfba008','1101','1,2,3')  #4參考材料不發料
   CALL cl_set_comp_visible("group_ware_input,group_ware_qbe",FALSE)
   IF g_prog[1,6]='asft31' THEN
      CALL cl_set_comp_visible("return",FALSE)
      CALL cl_set_combo_scc('issue_type','4014')
   END IF
   IF g_prog[1,6]='asft32' THEN
      CALL cl_set_comp_visible("less,expand",FALSE)
      CALL cl_set_combo_scc('issue_type','4017')
   END IF
   #當整體參數有使用參考單位時才顯示
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_visible("sfdc009,sfdc009_desc,sfdc010",FALSE) #參考單位
   END IF
   #由發料單別參數"發料理由碼不可空白"控制理由碼是不是一定要輸入
   #参数D-MFG-0032：發料理由碼是否可空白
   #IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0032') THEN
   CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0032') RETURNING g_para
   IF g_para = 'N' THEN  #不可空白
      CALL cl_set_comp_required("reason",TRUE)
      CALL cl_set_comp_required("sfdc015",TRUE)
   END IF
   #150810-00003#1-s
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036')  = 'N' THEN  
      CALL cl_set_comp_visible("sfdc005,sfdc005_desc",FALSE)
   END IF
   #150810-00003#1-e
   
   #160706-00027#1-s
   LET g_para1 = cl_get_para(g_enterprise,g_site,'S-MFG-0055') #發料控管套數否
   #160706-00027#1-e
   #end add-point

END FUNCTION

PRIVATE FUNCTION asft310_01_ui_dialog()
   CALL cl_set_act_visible("accept,cancel", FALSE)

   WHILE TRUE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         DISPLAY ARRAY g_sfdc_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1

            BEFORE ROW
               CALL asft310_01_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL asft310_01_idx_chk()

         END DISPLAY

         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()

            #有資料才進行fetch
            CALL asft310_01_ui_detailshow() #Setting the current row

            #筆數顯示
            CALL asft310_01_idx_chk()

         ON ACTION modify
            CALL asft310_01_input()
            CALL asft310_01_show()
         
         #产生到asft310主作业单身中去
         ON ACTION gen_b
            IF cl_ask_confirm('sub-00405') THEN
               CALL asft310_01_gen()
               LET g_action_choice = "exit"
               EXIT DIALOG
            END IF
   
         ON ACTION close
            LET INT_FLAG=FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG

         ON ACTION mainhidden       #主頁摺疊
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF

         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("worksheet_detail",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("worksheet_detail",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden
            END IF

         ON ACTION controlo
            DISPLAY "Controlo"



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

PRIVATE FUNCTION asft310_01_ui_detailshow()
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)

   END IF


END FUNCTION

PRIVATE FUNCTION asft310_01_show()
DEFINE l_ac_t    LIKE type_t.num10  #170104-00066#2 num5->num10  17/01/06 mod by rainy 

   IF g_bfill = "Y" THEN
      CALL asft310_01_b_fill() #單身填充
   END IF

   LET l_ac_t = l_ac

   #讀入ref值(單頭)

   #讀入ref值(單身)
   FOR l_ac = 1 TO g_sfdc_d.getLength()

      #add-point:show段單身reference
      #161205-00025#6-s
      ##单位
      #CALL s_desc_get_unit_desc(g_sfdc_d[l_ac].sfdc006) RETURNING g_sfdc_d[l_ac].sfdc006_desc
      ##参考单位
      #CALL s_desc_get_unit_desc(g_sfdc_d[l_ac].sfdc009) RETURNING g_sfdc_d[l_ac].sfdc009_desc
      ##理由码
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_sfdc_d[l_ac].sfdc015
      #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='226' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_sfdc_d[l_ac].sfdc015_desc = '', g_rtn_fields[1] , ''
      ##需求料号品名规格
      #CALL s_desc_get_item_desc(g_sfdc_d[l_ac].sfdc004) RETURNING g_sfdc_d[l_ac].sfdc004_desc,g_sfdc_d[l_ac].sfdc004_desc2
      ##显示产品特征说明
      #CALL s_feature_description(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005)
      #   RETURNING l_success,g_sfdc_d[l_ac].sfdc005_desc
      #IF NOT l_success THEN
      #   LET g_sfdc_d[l_ac].sfdc005_desc = ''
      #END IF
      ##保税料
      #SELECT imaf034
      #  INTO g_sfdc_d[l_ac].imaf034
      #  FROM imaf_t
      # WHERE imafent = g_enterprise
      #   AND imafsite= g_site
      #   AND imaf001 = g_sfdc_d[l_ac].sfdc004
      ##发料前调拨
      #SELECT imae092 INTO g_sfdc_d[l_ac].imae092 FROM imae_t
      # WHERE imaeent = g_enterprise
      #   AND imaesite= g_site
      #   AND imae001 = g_sfdc_d[l_ac].sfdc004
      ##库位名称
      #CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
      ##储位名称
      #IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
      #   CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
      #END IF
      ##工单信息-部位、作业、作业序、客供料、应发料、已发量
      #SELECT sfba002,sfba003,sfba004,sfba028,sfba013,sfba016
      #  INTO g_sfdc_d[l_ac].sfba002,g_sfdc_d[l_ac].sfba003,g_sfdc_d[l_ac].sfba004,g_sfdc_d[l_ac].sfba028,
      #       g_sfdc_d[l_ac].sfba013,g_sfdc_d[l_ac].sfba016
      #  FROM sfba_t,sfaa_t
      # WHERE sfbaent = sfaaent
      #   AND sfbadocno=sfaadocno
      #   AND sfbaent = g_enterprise
      #   AND sfbadocno=g_sfdc_d[l_ac].sfdc001
      #   AND sfbaseq = g_sfdc_d[l_ac].sfdc002
      #   AND sfbaseq1= g_sfdc_d[l_ac].sfdc003
      ##部位说明
      #INITIALIZE g_chkparam.* TO NULL
      #LET g_chkparam.arg1 = '215'
      #LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfba002
      #CALL cl_ref_val("v_oocql002")
      #LET g_sfdc_d[l_ac].sfba002_desc = g_chkparam.return1
      ##作业说明
      #INITIALIZE g_chkparam.* TO NULL
      #LET g_chkparam.arg1 = '221'
      #LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfba003
      #CALL cl_ref_val("v_oocql002")
      #LET g_sfdc_d[l_ac].sfba003_desc = g_chkparam.return1
      #161205-00025#6-e
      #end add-point
   END FOR

   LET l_ac = l_ac_t

   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()

END FUNCTION

PRIVATE FUNCTION asft310_01_b_fill()
DEFINE l_imaf055    LIKE imaf_t.imaf055  #160519-00008#18

   CALL g_sfdc_d.clear()    #g_sfdc_d 單頭及單身

   #161205-00025#6-s
   #LET g_sql = "SELECT UNIQUE sfdcseq,sfdc001,sfdc002,sfdc003,'','','','','',sfdc004,'','',sfdc005,'','','','',sfdc006,'','','',sfdc007,sfdc009,'',sfdc010,sfdc012,'',sfdc013,'',sfdc014,sfdc016,sfdc015,'' ",
   #            "  FROM asft310_01_sfdc_t"
   LET g_sql = " SELECT UNIQUE sfdcseq,sfdc001,sfdc002,sfdc003,sfba002, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=",g_enterprise," AND oocql001='215' AND oocql002=sfba002 AND oocql003='",g_dlang,"'), ",
               "        sfba003, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=",g_enterprise," AND oocql001='221' AND oocql002=sfba003 AND oocql003='",g_dlang,"'), ",
               "        sfba004,sfdc004,imaal003,imaal004,sfdc005, ",
               "(SELECT inaml004 FROM inaml_t WHERE inamlent=",g_enterprise," AND inaml001=sfdc004 AND inaml002=sfdc005 AND inaml003='",g_dlang,"'), ",
               "        sfba028, ",
               "(SELECT imae092 FROM imae_t WHERE imaeent=",g_enterprise," AND imaesite='",g_site,"' AND imae001=sfdc004), ",
               "(SELECT imaf034 FROM imaf_t WHERE imafent=",g_enterprise," AND imafsite='",g_site,"' AND imaf001=sfdc004), ",
               "        sfdc006, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=sfdc006 AND oocal002='",g_dlang,"'), ",
               "        sfba013,sfba016,sfdc007,sfdc009, ",
               "(SELECT oocal003 FROM oocal_t WHERE oocalent=",g_enterprise," AND oocal001=sfdc009 AND oocal002='",g_dlang,"'), ",
               "        sfdc010,sfdc012, ",
               "(SELECT inayl003 FROM inayl_t WHERE inaylent=",g_enterprise," AND inayl001=sfdc012 AND inayl002='",g_dlang,"'), ",
               "        sfdc013, ",
               "(SELECT inab003 FROM inab_t WHERE inabent=",g_enterprise," AND inabsite='",g_site,"' AND inab001=sfdc012 AND inab002=sfdc013 ), ",
               "        sfdc014,sfdc016,sfdc015, ",
               "(SELECT oocql004 FROM oocql_t WHERE oocqlent=",g_enterprise," AND oocql001='226' AND oocql002=sfdc015 AND oocql003='",g_dlang,"') ",
               "   FROM asft310_01_sfdc_t ",
               "   LEFT JOIN sfba_t ON sfbaent=",g_enterprise," AND sfbadocno=sfdc001 AND sfbaseq=sfdc002 AND sfbaseq1=sfdc003 ",
               "   LEFT JOIN imaal_t ON imaalent=",g_enterprise," AND imaal001=sfdc004 AND imaal002='",g_dlang,"' "
   #161205-00025#6-e
   LET g_sql = g_sql, " ORDER BY sfdc001,sfdc002,sfdc003"
   PREPARE asft310_01_pb FROM g_sql
   DECLARE asft310_01_cs CURSOR FOR asft310_01_pb
   LET g_cnt = l_ac
   LET l_ac = 1

   #161205-00025#6-s
   #FOREACH asft310_01_cs INTO g_sfdc_d[l_ac].sfdcseq,g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002,g_sfdc_d[l_ac].sfdc003,g_sfdc_d[l_ac].sfba002,g_sfdc_d[l_ac].sfba002_desc,g_sfdc_d[l_ac].sfba003,g_sfdc_d[l_ac].sfba003_desc,g_sfdc_d[l_ac].sfba004,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc004_desc,g_sfdc_d[l_ac].sfdc004_desc2,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc005_desc,g_sfdc_d[l_ac].sfba028,g_sfdc_d[l_ac].imae092,g_sfdc_d[l_ac].imaf034,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc006_desc,g_sfdc_d[l_ac].sfba013,g_sfdc_d[l_ac].sfba016,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc009_desc,g_sfdc_d[l_ac].sfdc010,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc012_desc,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc013_desc,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016,g_sfdc_d[l_ac].sfdc015,g_sfdc_d[l_ac].sfdc015_desc
   FOREACH asft310_01_cs
      INTO g_sfdc_d[l_ac].sfdcseq,g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002,g_sfdc_d[l_ac].sfdc003,g_sfdc_d[l_ac].sfba002,
           g_sfdc_d[l_ac].sfba002_desc,g_sfdc_d[l_ac].sfba003,g_sfdc_d[l_ac].sfba003_desc,g_sfdc_d[l_ac].sfba004,g_sfdc_d[l_ac].sfdc004,
           g_sfdc_d[l_ac].sfdc004_desc,g_sfdc_d[l_ac].sfdc004_desc2,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc005_desc,g_sfdc_d[l_ac].sfba028,
           g_sfdc_d[l_ac].imae092,g_sfdc_d[l_ac].imaf034,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc006_desc,g_sfdc_d[l_ac].sfba013,
           g_sfdc_d[l_ac].sfba016,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc009_desc,g_sfdc_d[l_ac].sfdc010,
           g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc012_desc,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc013_desc,g_sfdc_d[l_ac].sfdc014,
           g_sfdc_d[l_ac].sfdc016,g_sfdc_d[l_ac].sfdc015,g_sfdc_d[l_ac].sfdc015_desc
   #161205-00025#6-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #161205-00025#6-s
      ##160519-00008#18-s
      #IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
      #   SELECT imaf055 INTO l_imaf055
      #     FROM imaf_t
      #    WHERE imafent = g_enterprise
      #      AND imafsite = g_site
      #      AND imaf001 = g_sfdc_d[l_ac].sfdc004
      #   IF l_imaf055 = '1' THEN
      #      LET g_sfdc_d[l_ac].sfdc016= ''
      #   END IF
      #END IF
      ##160519-00008#18-e
      #161205-00025#6-e
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec AND g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   END FOREACH
   LET g_error_show = 0
   CALL g_sfdc_d.deleteElement(g_sfdc_d.getLength())
   LET l_ac = g_cnt
   LET g_cnt = 0
   FREE asft310_01_pb
END FUNCTION
################################################################################
# Descriptions...: 发退料需求产生
# Memo...........: 
# Usage..........: CALL asft310_01(p_sfdadocno)
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      TRUE/FALSE产生成功否
# Date & Author..: 2014/01/07 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION asft310_01(p_sfdadocno)
DEFINE p_sfdadocno  LIKE sfda_t.sfdadocno
DEFINE r_success    LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num10     #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_sql        STRING
#DEFINE l_sfdc       RECORD LIKE sfdc_t.* #161109-00085#62 mark
#161109-00085#62 --s add
DEFINE l_sfdc RECORD  #發退料需求檔
       sfdcent LIKE sfdc_t.sfdcent, #企業編號
       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
       sfdcseq LIKE sfdc_t.sfdcseq, #項次
       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
       sfdc006 LIKE sfdc_t.sfdc006, #單位
       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
       sfdc017 LIKE sfdc_t.sfdc017, #正負
       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
END RECORD
#161109-00085#62 --e add
DEFINE l_success    LIKE type_t.num5
#DEFINE l_count      LIKE type_t.num10  #套数单身笔数  #170104-00066#2 num5->num10  17/01/06 mod by rainy  #161205-00025#6

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   LET g_success = TRUE
   LET r_success = TRUE

   #161205-00025#6-s 下方有相同的檢查所以把這段mark
   ##检查套数单身是否有维护数据,没有维护套数单身,不需执行此功能
   #SELECT COUNT(1) INTO l_count FROM sfdb_t
   # WHERE sfdbent  = g_enterprise
   #   AND sfdbdocno= p_sfdadocno
   #IF l_count = 0 THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161205-00025#6-e

   #检查事务中
   IF NOT s_transaction_chk('Y',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #检查参数
   IF cl_null(p_sfdadocno) THEN
      #传入值为空;请检查字段值是否录入
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = 'asft310_01'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0043') RETURNING g_bas_0043  #VMI存貨庫位Tag  #161205-00025#6
   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0028') RETURNING g_ref_unit  #是否启用参考单位
   CALL s_aooi200_get_slip(p_sfdadocno) RETURNING l_success,g_ooba002
   CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-BAS-0070') RETURNING g_bas_0070    #170516-00063#1

   #发退料单头讯息
   LET g_sfdadocno= p_sfdadocno
   
   #161109-00085#30-s
   #SELECT * INTO g_sfda.* FROM sfda_t
   SELECT sfdastus,sfda002 INTO g_sfda.sfdastus,g_sfda.sfda002
     FROM sfda_t
   #161109-00085#30-e
    WHERE sfdaent = g_enterprise
      AND sfdadocno= g_sfdadocno
   
   #不是未确认状态，不可执行
   IF g_sfda.sfdastus != 'N' THEN
      #本单据状态不为未确认,不可执行
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = g_sfdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   IF  g_sfda.sfda002 != '11' AND g_sfda.sfda002 != '13' AND g_sfda.sfda002 != '21'
   AND g_sfda.sfda002 != '12' AND g_sfda.sfda002 != '22' THEN
      #只有11.成套发料、12.超领发料、13.欠料补料、21.成套退料、22超领退料才能执行本功能
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00169'
      LET g_errparam.extend = g_sfda.sfda002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   SELECT COUNT(1) INTO l_cnt FROM sfdb_t
    WHERE sfdbent  = g_enterprise
      AND sfdbdocno= g_sfdadocno  #161109-00085#30
   IF l_cnt = 0 THEN
      #套数单身缺少资料，不可执行此功能
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00170'
      LET g_errparam.extend = g_sfdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
            
   #检查需求页签是否已存在资料
   SELECT COUNT(1) INTO l_cnt FROM sfdc_t
    WHERE sfdcent  = g_enterprise
      AND sfdcdocno= g_sfdadocno
   IF l_cnt > 0 THEN
      #已存在需求资料，请选择处理方式
      #1.全部删除:将发退料需求明细全部都删掉
      #2.删除未指定库位数据:将库位为空白的资料删掉
      #3.不删除
      CALL asft310_01_choice() RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      CASE g_choice
         WHEN "1" #全部删除:将发退料需求明细全部都删掉
              DELETE FROM sfdc_t WHERE sfdcent = g_enterprise AND sfdcdocno=p_sfdadocno
              DELETE FROM sfdd_t WHERE sfddent = g_enterprise AND sfdddocno=p_sfdadocno
              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno=p_sfdadocno
              DELETE FROM sfde_t WHERE sfdeent = g_enterprise AND sfdedocno=p_sfdadocno
              DELETE FROM sfdf_t WHERE sfdfent = g_enterprise AND sfdfdocno=p_sfdadocno
         WHEN "2" #删除未指定库位数据:将库位为空白的资料删掉
              #先根据sfdc、sfdd删除sfde、sfdf
              #LET l_sql = " SELECT sfdc_t.* FROM sfdc_t ", #161109-00085#62 mark
              #161109-00085#62 --s add
              LET l_sql = " SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001, sfdc002,sfdc003,sfdc004,sfdc005,sfdc006, ",
                          "        sfdc007,sfdc008,sfdc009,sfdc010,sfdc011, sfdc012,sfdc013,sfdc014,sfdc015,sfdc016, ",
                          "        sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004, sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009, ",
                          "        sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014, sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019, ",
                          "        sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024, sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029, ",
                          "        sfdcud030 ",
                          "   FROM sfdc_t ",
              #161109-00085#62 --e add
                          "  WHERE sfdcent  = ",g_enterprise,
                          "    AND sfdcdocno= '",p_sfdadocno,"' ",
                          "    AND (sfdc012  = ' ' OR sfdc012 IS null)"
              PREPARE asft310_01_p FROM l_sql
              DECLARE asft310_01_c CURSOR FOR asft310_01_p
             #FOREACH asft310_01_c INTO l_sfdc.* #161109-00085#62 mark
              #161109-00085#62 --s add
              FOREACH asft310_01_c INTO l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
                                        l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
                                        l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
                                        l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
                                        l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
                                        l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
                                        l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
                                        l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
                                        l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
                                        l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
                                        l_sfdc.sfdcud030
              #161109-00085#62 --e add
                  CALL s_asft310_chg_sfde_f_sfdc_del(l_sfdc.*) RETURNING l_success
                  IF NOT l_success THEN
                     LET l_success_tot = FALSE
                  END IF
              END FOREACH
              #再删除sfdd、sfdc
              DELETE FROM sfdd_t WHERE sfddent = g_enterprise AND sfdddocno=p_sfdadocno
                 AND sfddseq IN ( SELECT sfdcseq FROM sfdc_t
                                   WHERE sfdcent = g_enterprise AND sfdcdocno=p_sfdadocno
                                     AND (sfdc012  = ' ' OR sfdc012 IS null) )
              DELETE FROM inao_t WHERE inaoent = g_enterprise AND inaosite = g_site AND inaodocno=p_sfdadocno
                 AND inaoseq IN ( SELECT sfdcseq FROM sfdc_t
                                   WHERE sfdcent = g_enterprise AND sfdcdocno=p_sfdadocno
                                     AND (sfdc012  = ' ' OR sfdc012 IS null) )
              DELETE FROM sfdc_t WHERE sfdcent = g_enterprise AND sfdcdocno = p_sfdadocno AND sfdc012 = ' ' 
      END CASE
   END IF
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_asft310_01 WITH FORM cl_ap_formpath("asf","asft310_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL asft310_01_init()

   #進入選單 Menu (="N")
   CALL asft310_01_input()
   CALL asft310_01_show()
   CALL asft310_01_ui_dialog()

   #畫面關閉
   CLOSE WINDOW w_asft310_01

   LET g_action_choice = ""

   LET r_success = g_success
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION asft310_01_set_entry_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1

   CALL cl_set_comp_entry("sfdc005",TRUE)  #产品特征
   CALL cl_set_comp_entry("sfdc016",TRUE)
   CALL cl_set_comp_entry("sfdc010",TRUE)  #参考单位申请数量
   CALL cl_set_comp_entry("sfdc012,sfdc013,sfdc014,sfdc016",TRUE)  #库位 储位 批号 库存管理特征
   LET g_sfdc012_switch = 'Y'   #庫位        可输入性 Y可输入 N不可输入
   LET g_sfdc013_switch = 'Y'   #儲位        可输入性 Y可输入 N不可输入
   LET g_sfdc014_switch = 'Y'   #批號        可输入性 Y可输入 N不可输入
   LET g_sfdc016_switch = 'Y'   #庫存管理特徵 可输入性 Y可输入 N不可输入

  #CALL cl_set_comp_required("sfdc016",FALSE)      #160519-00008#18 mark
   CALL cl_set_comp_required("sfdc016",TRUE)       #160519-00008#18
END FUNCTION

PRIVATE FUNCTION asft310_01_set_no_entry_b(p_cmd)
DEFINE p_cmd   LIKE type_t.chr1
DEFINE l_imaf055        LIKE imaf_t.imaf055  #库存管理特征
DEFINE l_imaa005  LIKE imaa_t.imaa005  #特征类别
DEFINE l_success  LIKE type_t.num5
DEFINE l_sfba019  LIKE sfba_t.sfba019  #指定库位
DEFINE l_sfba020  LIKE sfba_t.sfba020  #指定储位
DEFINE l_sfba029  LIKE sfba_t.sfba029  #指定批号
DEFINE l_sfba030  LIKE sfba_t.sfba030  #指定库存管理特征
DEFINE l_sfba021  LIKE sfba_t.sfba021
#170324-00073#1 add(s)
DEFINE l_imaf061  LIKE imaf_t.imaf061  
DEFINE l_inaa007  LIKE inaa_t.inaa007  
#170324-00073#1 add(e)
   #料件有使用庫存管理特徵时才可輸入库存管理特征栏位sfdc016
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc004) THEN
      SELECT imaf055 INTO l_imaf055
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_sfdc_d[l_ac].sfdc004
      #160519-00008#18--(S)
      IF l_imaf055 <> '1' THEN
         CALL cl_set_comp_required("sfdc016",FALSE)
      END IF
      #160519-00008#18--(E)
      IF l_imaf055 = '2' THEN  #不可有库存管理特征
         CALL cl_set_comp_required("sfdc016",FALSE)   #160519-00008#18
         CALL cl_set_comp_entry("sfdc016",FALSE)
         LET g_sfdc016_switch = 'N'   #可输入性 Y可输入 N不可输入
      END IF
      IF l_imaf055 = '1' THEN  #必须有库存管理特征
         CALL cl_set_comp_required("sfdc016",TRUE)
         #160519-00008#18--(S)
         IF g_sfdc_d[l_ac].sfdc016 = ' ' THEN
            LET g_sfdc_d[l_ac].sfdc016 = ''
         END IF      
         #160519-00008#18--(E)
      END IF
   END IF
   #當料號有使用參考單位時，才允許輸入sfdc010参考单位申请数量
   IF g_ref_unit = 'N' THEN
      CALL cl_set_comp_entry("sfdc010",FALSE)  #参考单位申请数量
   ELSE
      IF cl_null(g_sfdc_d[l_ac].sfdc009) THEN
         CALL cl_set_comp_entry("sfdc010",FALSE)  #参考单位申请数量
      END IF
   END IF
   
   #发料单需要卡控工单有指定的，不可修改 add 150116 g_prog[1,6]='asft31'
   #工单、项次、项序不为空
   IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc001) AND NOT cl_null(g_sfdc_d[l_ac].sfdc002) AND NOT cl_null(g_sfdc_d[l_ac].sfdc003) AND g_prog[1,6]='asft31' THEN
      #工單指定發料庫儲，發料時允許修改
      CALL s_aooi200_get_slip(g_sfdc_d[l_ac].sfdc001) RETURNING l_success,g_ooba002
      IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050') = 'N' THEN
         SELECT sfba019,sfba020,sfba029,sfba030
           INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
           FROM sfba_t
          WHERE sfbaent  = g_enterprise
            AND sfbadocno= g_sfdc_d[l_ac].sfdc001
            AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
            AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
         IF NOT cl_null(l_sfba019) THEN
            CALL cl_set_comp_entry("sfdc012",FALSE)  #库位
            LET g_sfdc012_switch = 'N'   #可输入性 Y可输入 N不可输入
         END IF
         IF NOT cl_null(l_sfba020) THEN
            CALL cl_set_comp_entry("sfdc013",FALSE)  #储位
            LET g_sfdc013_switch = 'N'   #可输入性 Y可输入 N不可输入
         END IF
         IF NOT cl_null(l_sfba029) THEN
            CALL cl_set_comp_entry("sfdc014",FALSE)  #批号
            LET g_sfdc014_switch = 'N'   #可输入性 Y可输入 N不可输入
         END IF
         IF NOT cl_null(l_sfba030) THEN
            CALL cl_set_comp_entry("sfdc016",FALSE)  #库存管理特征
            LET g_sfdc016_switch = 'N'   #可输入性 Y可输入 N不可输入
         END IF
      END IF
   END IF
   
   #产品特征控制
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) AND NOT cl_null(g_sfdc_d[l_ac].sfdc002) AND NOT cl_null(g_sfdc_d[l_ac].sfdc003) THEN
      SELECT sfba021 INTO l_sfba021
        FROM sfba_t
       WHERE sfbaent  = g_enterprise
         AND sfbadocno= g_sfdc_d[l_ac].sfdc001
         AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
         AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
      #工单有指定产品特征，不可修改
      IF NOT cl_null(l_sfba021) THEN
         CALL cl_set_comp_entry("sfdc005",FALSE)  #产品特征
      END IF
   END IF
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc004) THEN
      SELECT imaa005 INTO l_imaa005  #特征类别
        FROM imaa_t
       WHERE imaaent  = g_enterprise
         AND imaa001  = g_sfdc_d[l_ac].sfdc004
      IF cl_null(l_imaa005) THEN
         CALL cl_set_comp_entry("sfdc005",FALSE)  #产品特征
      END IF
   END IF
  
   #170324-00073#1 add(s)
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc004) THEN
      SELECT imaf061 INTO l_imaf061
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite = g_site
         AND imaf001 = g_sfdc_d[l_ac].sfdc004
      #不可有批号
      IF l_imaf055 = '2' THEN
         CALL cl_set_comp_entry("sfdc014",FALSE)
      END IF
   END IF
   
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN
      SELECT inaa007 INTO l_inaa007
        FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaa001 = g_sfdc_d[l_ac].sfdc012
         AND inaasite = g_site
      #不可有储位
      IF l_inaa007 = '5' THEN
         CALL cl_set_comp_entry("sfdc013",FALSE)
      END IF
   END IF
   #170324-00073#1 add(e)
  
END FUNCTION
################################################################################
# Descriptions...: 删除临时表
# Memo...........: 必须用于事务外
#                  与asft310_01_cre_tmp_table对应
# Usage..........: CALL asft310_01_drop_tmp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/01/07 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION asft310_01_drop_tmp_table()
   WHENEVER ERROR CONTINUE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN 
   END IF
   
   #刪除TEMP TABLE
   DROP TABLE asft310_01_sfdc_t
   
END FUNCTION
################################################################################
# Descriptions...: 建立临时表
# Memo...........: 必须用于事务外
# Usage..........: CALL asft310_01_cre_tmp_table()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success      临时表建立成功否
# Date & Author..: 2014/01/07 By zhangllc
# Modify.........:
################################################################################
PUBLIC FUNCTION asft310_01_cre_tmp_table()
DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF
   
   DROP TABLE asft310_01_sfdc_t;
   #按sfdc表建立临时表
   #SELECT * FROM sfdc_t #161109-00085#62 mark
    #161109-00085#62 --s add
    SELECT  sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001, sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
            sfdc007,sfdc008,sfdc009,sfdc010,sfdc011, sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
            sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004, sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
            sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014, sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
            sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024, sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
            sfdcud030 
      FROM sfdc_t
    #161109-00085#62 --e add
    WHERE sfdcent=0 AND sfdcsite='aa' AND sfdcdocno='aa' AND sfdcseq=0
      AND 0=1
     INTO TEMP asft310_01_sfdc_t
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'asft310_01_cre_tmp_table'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_success
   END IF                                                           
   #CREATE UNIQUE INDEX asft310_01_sfdc_01 on asft310_01_sfdc_t (sfdcent,sfdcsite,sfdcdocno,sfdcseq)
   #IF SQLCA.sqlcode THEN
   #   #CALL cl_err('create index',SQLCA.sqlcode,1)
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = SQLCA.sqlcode
   #   LET g_errparam.extend = 'create index'
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   RETURN r_success
   #END IF
   
   #161205-00025#6-s
   
   CREATE UNIQUE INDEX tmp_index_01 ON asft310_01_sfdc_t (sfdcent,sfdcdocno,sfdc001,sfdc002,sfdc003,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016)
   
   LET g_sql = " INSERT INTO asft310_01_sfdc_t ",
               " (sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006, ",
               "  sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016, ",
               "  sfdc017) ",
               " VALUES (?,?,?,?,?, ?,?,?,?,?, ",
                       " ?,?,?,?,?, ?,?,?,?,?, ",
                       " ?) "
   PREPARE ins_asft310_01_sfdc_t_p FROM g_sql
   
   LET g_sql = " INSERT INTO sfdc_t ",
               " (sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006, ",
               "  sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016, ",
               "  sfdc017) ",
               " VALUES (?,?,?,?,?, ?,?,?,?,?, ",
                       " ?,?,?,?,?, ?,?,?,?,?, ",
                       " ?) "
   PREPARE ins_sfdc_t_p FROM g_sql
   
   #161205-00025#6-e
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
#显示单身光标所在位置
PRIVATE FUNCTION asft310_01_idx_chk()

   LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
   IF g_detail_idx > g_sfdc_d.getLength() THEN
      LET g_detail_idx = g_sfdc_d.getLength()
   END IF
   IF g_detail_idx = 0 AND g_sfdc_d.getLength() <> 0 THEN
      LET g_detail_idx = 1
   END IF
   DISPLAY g_detail_idx TO FORMONLY.idx
   DISPLAY g_sfdc_d.getLength() TO FORMONLY.cnt

END FUNCTION

PRIVATE FUNCTION asft310_01_input()
   {<Local define>}
   DEFINE l_cmd           LIKE type_t.chr1
   DEFINE l_n             LIKE type_t.num5                #檢查重複用
   DEFINE l_cnt           LIKE type_t.num10                #檢查重複用   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE l_allow_insert  LIKE type_t.num5                #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5                #可刪除否
   DEFINE l_count         LIKE type_t.num10     #170104-00066#2 num5->num10  17/01/06 mod by rainy 
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_insert        BOOLEAN
   DEFINE lc_qbe_sn       LIKE type_t.num10
   DEFINE l_rate          LIKE inaj_t.inaj014  #单位换算率
   DEFINE l_inaa015       LIKE inaa_t.inaa015  #保税仓否
   DEFINE l_inaa010       LIKE inaa_t.inaa010  #成本库否
   DEFINE l_sfaa010       LIKE sfaa_t.sfaa010  #生产料号
   DEFINE l_imaf034       LIKE imaf_t.imaf034  #保税料
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_column        LIKE type_t.chr10
   DEFINE l_where         STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag2         LIKE type_t.num5   #s_control使用
   #add 150107             
   DEFINE l_sfba019       LIKE sfba_t.sfba019  #指定库位
   DEFINE l_sfba020       LIKE sfba_t.sfba020  #指定储位
   DEFINE l_sfba029       LIKE sfba_t.sfba029  #指定批号
   DEFINE l_sfba030       LIKE sfba_t.sfba030  #指定库存管理特征
   #add 150107 end         
   DEFINE l_sfaa005       LIKE sfaa_t.sfaa005  #add by lixh 20151109
   DEFINE l_imaf055       LIKE imaf_t.imaf055  #160519-00008#18
   DEFINE lc_param        type_sfba_parameter  #160726-00001#6
   DEFINE ls_js           STRING               #160726-00001#6
   DEFINE l_prog          STRING               #170602-00036#1 add
   {</Local define>}

   CALL cl_set_head_visible("","YES")
   
   #清除畫面
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   INITIALIZE tm2.* TO NULL
   CALL g_sfdc_d.clear()
   CALL asft310_01_b_fill()  #單身填充
   
   LET l_insert = FALSE
   LET g_action_choice = ""

   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")

   IF g_prog[1,6] = 'asft31' THEN
      LET tm.issue_type = cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0053')    #产生方式:由發料單別參數"發料需求產生方式預設"
      LET tm.less = cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0054')   #库存不足仍产生:依發料單別參數設定"依發料套數產生庫存不足仍產生預設"
      LET tm.expand = cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0055')    #自动展至仓储批：依發料單別參數預設"依發料套數產生自動展至庫儲批預設"
   END IF
   IF g_prog[1,6] = 'asft32' THEN
      LET tm.issue_type = cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0057')    #产生方式:依套數產生退料需求預設方式
      LET tm.return ='Y'    #依发料批号退料:預設勾選
   END IF
   IF cl_null(tm.issue_type) THEN LET tm.issue_type='1' END IF
   IF cl_null(tm.less) THEN LET tm.less = 'N' END IF
   IF cl_null(tm.expand) THEN LET tm.expand = 'N' END IF
   IF cl_null(tm.return) THEN LET tm.return = 'N' END IF
   
   CALL cl_set_comp_visible("group_ware_input,group_ware_qbe",FALSE)
   #INPUT
   IF (g_prog[1,6]='asft31' AND tm.issue_type = '2') OR (g_prog[1,6]='asft32' AND tm.issue_type='3') THEN
       CALL cl_set_comp_visible("group_ware_input",TRUE)
   END IF
   #CONSTRUCT
   IF (g_prog[1,6]='asft31' AND tm.issue_type = '3') THEN
       CALL cl_set_comp_visible("group_ware_qbe",TRUE)
   END IF
   
   IF (g_prog[1,6] = 'asft31' AND tm.issue_type = '2') OR (g_prog[1,6] = 'asft32' AND tm.issue_type = '3') THEN  #自行制定库位储位批号
       CALL cl_set_comp_required("inag004_i",TRUE) #仓库必输
   END IF

   DISPLAY tm.issue_type TO FORMONLY.issue_type
   DISPLAY tm.less TO FORMONLY.less
   DISPLAY tm.expand TO FORMONLY.expand
   DISPLAY tm.return TO FORMONLY.return

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #單頭
      CONSTRUCT BY NAME tm.wc ON imaa001,imaf051,imaa003,imaa009,imaf091,imaf092,sfba008,imae092,imaf034,sfba028

         BEFORE CONSTRUCT
            #CALL cl_qbe_init()

         ON ACTION controlp INFIELD imaa001  #料号范围
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_imaa001_13()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位

         ON ACTION controlp INFIELD imaf051  #库存分群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imccsite ='",g_site,"' "
            CALL q_imcc051_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf051  #顯示到畫面上
            NEXT FIELD imaf051                     #返回原欄位

         ON ACTION controlp INFIELD imaa003  #主分群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
            NEXT FIELD imaa003                     #返回原欄位

         ON ACTION controlp INFIELD imaa009  #产品分类
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
            
         ON ACTION controlp INFIELD imaf091  #料件预设库位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inaasite ='",g_site,"' "
            CALL q_inaa001_5()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf091  #顯示到畫面上
            NEXT FIELD imaf091                     #返回原欄位

         ON ACTION controlp INFIELD imaf092  #料件预设储位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_2()                     #呼叫開窗  
            DISPLAY g_qryparam.return1 TO imaf092  #顯示到畫面上
            NEXT FIELD imaf092                     #返回原欄位

         #产生子画面单身
         ON ACTION gen_b_01
            CALL asft310_01_generate_chk() RETURNING l_column
            CASE l_column
                WHEN 'inag004_i'
                     NEXT FIELD inag004_i
                WHEN 'inag005_i'
                     NEXT FIELD inag005_i
                WHEN 'reason'
                     NEXT FIELD reason
                OTHERWISE
                     CALL asft310_01_generate()
                     CALL asft310_01_show()
            END CASE
         
         #170103-00017#1 add--s
         #清除单身
         ON ACTION del_b_01
            IF cl_ask_confirm('asf-00667') THEN
               DELETE FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
               CALL asft310_01_show()
            END IF
         #170103-00017#1 add--e
      END CONSTRUCT
      
      #單頭段
      INPUT BY NAME tm.issue_type,tm.less,tm.expand,tm.return,tm.reason
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT

         ON CHANGE issue_type
            #add 141204
            INITIALIZE tm2.wc TO NULL
            LET tm2.inag004_i = ''
            LET tm2.inag005_i = ''
            LET tm2.inag006_i = ''
            LET tm2.inag003_i = ''
            DISPLAY '' TO FORMONLY.inag004
            DISPLAY '' TO FORMONLY.inag005
            DISPLAY '' TO FORMONLY.inag006
            DISPLAY '' TO FORMONLY.inag003
            DISPLAY '' TO FORMONLY.inac003
            DISPLAY '' TO FORMONLY.inaa015
            DISPLAY '' TO FORMONLY.inaa010
            #add 141204 end
            
            CALL cl_set_comp_visible("group_ware_input,group_ware_qbe",FALSE)
            #INPUT
            IF (g_prog[1,6]='asft31' AND tm.issue_type = '2') OR (g_prog[1,6]='asft32' AND tm.issue_type='3') THEN
                CALL cl_set_comp_visible("group_ware_input",TRUE)
            END IF
            #CONSTRUCT
            IF (g_prog[1,6]='asft31' AND tm.issue_type = '3') THEN
                CALL cl_set_comp_visible("group_ware_qbe",TRUE)
            END IF
            
            #自動展開至倉儲批的選項如果在產生方式=3.依庫存量發料時，預設為Y，不可改
            CALL cl_set_comp_entry("expand",TRUE)
            IF (g_prog[1,6]='asft31' AND tm.issue_type = '3') THEN  #依库存量发料(QBE)
               LET tm.expand = 'Y'
               DISPLAY tm.expand TO FORMONLY.expand
               CALL cl_set_comp_entry("expand",FALSE)
            END IF
            
         AFTER FIELD reason
            #理由码
            IF NOT cl_null(tm.reason) THEN
               CALL s_azzi650_chk_exist_and_desc('226',tm.reason) RETURNING l_success,tm.reason_desc
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME tm.reason_desc
               #控制组检查
               CALL s_control_chk_doc('8',g_sfdadocno,tm.reason,'','','','')
                  RETURNING l_success,l_flag2
               IF NOT l_success OR NOT l_flag2 THEN
                  #控制组检查错误,请检查单别设定的相关内容
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00122'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  NEXT FIELD CURRENT
               END IF
               
            END IF
            
         ON ACTION controlp INFIELD reason
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.reason
            LET g_qryparam.arg1 = '226'
            #关于控制组
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_doc_sql("oocq002",g_sfdadocno,'8')
               RETURNING l_success,l_where    #num5和STRING类型
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",l_where
            END IF
            #关于控制组--end
            CALL q_oocq002_5()
            LET tm.reason = g_qryparam.return1     #將開窗取得的值>
            CALL s_desc_get_acc_desc('226',tm.reason) RETURNING tm.reason_desc
            DISPLAY BY NAME tm.reason_desc
            NEXT FIELD reason

         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF

            CALL cl_showmsg()      #錯誤訊息統整顯示
            DISPLAY BY NAME tm.issue_type,tm.less,tm.expand,tm.return,tm.reason,tm.reason_desc

         #产生子画面单身
         ON ACTION gen_b_01
            CALL asft310_01_generate_chk() RETURNING l_column
            CASE l_column
                WHEN 'inag004_i'
                     NEXT FIELD inag004_i
                WHEN 'inag005_i'
                     NEXT FIELD inag005_i
                WHEN 'reason'
                     NEXT FIELD reason
                OTHERWISE
                     CALL asft310_01_generate()
                     CALL asft310_01_show()
            END CASE
         
         #170103-00017#1 add--s
         #清除单身
         ON ACTION del_b_01
            IF cl_ask_confirm('asf-00667') THEN
               DELETE FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
               CALL asft310_01_show()
            END IF
         #170103-00017#1 add--e

      END INPUT

      #指定库位条件
      INPUT BY NAME tm2.inag004_i,tm2.inag005_i,tm2.inag006_i,tm2.inag003_i
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            INITIALIZE tm2.wc TO NULL
            #CALL asft310_01_set_entry()
            #CALL asft310_01_set_no_entry()
            
         AFTER FIELD inag004_i
            #库位
            IF NOT cl_null(tm2.inag004_i) THEN
               #检查是否存在于库存资料档中
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = tm2.inag004_i
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
               #160318-00025#21  by 07900 --add-end
               IF NOT cl_chk_exist("v_inaa001_2") THEN
                  NEXT FIELD CURRENT
               END IF

               #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
               CALL s_control_chk_doc('6',g_sfdadocno,tm2.inag004_i,'','','','') 
                  RETURNING l_success,l_flag2
               IF NOT l_success OR NOT l_flag2 THEN
                  #控制组检查错误,请检查单别设定的相关内容
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00122'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  NEXT FIELD CURRENT
               END IF
      
               IF NOT cl_null(tm2.inag005_i) THEN
                  #需存在庫儲位資料
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = tm2.inag004_i
                  LET g_chkparam.arg3 = tm2.inag005_i
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     NEXT FIELD inag005_i
                  END IF
               END IF
            #ELSE
            #   LET tm2.inag005_i = ' '
            #   LET tm2.inag006_i = ' '
            #   DISPLAY tm2.inag005_i TO inag005_i
            #   DISPLAY tm2.inag006_i TO inag006_i
            END IF
            #CALL asft310_01_set_entry()
            #CALL asft310_01_set_no_entry()

         #BEFORE FIELD inag005_i
         #   #储位
         #   CALL asft310_01_set_entry()
            
         AFTER FIELD inag005_i
            #储位
            IF NOT cl_null(tm2.inag005_i) THEN
               #需存在庫儲位資料
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_site
               LET g_chkparam.arg2 = tm2.inag005_i
               IF NOT cl_chk_exist("v_inab002_3") THEN
                  NEXT FIELD CURRENT
               END IF
               
               IF NOT cl_null(tm2.inag004_i) THEN
                  #需存在庫儲位資料
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = tm2.inag004_i
                  LET g_chkparam.arg3 = tm2.inag005_i
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end
                  IF NOT cl_chk_exist("v_inab002") THEN
                     NEXT FIELD CURRENT
                  END IF
               
                  #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
                  CALL s_control_chk_doc('6',g_sfdadocno,tm2.inag004_i,tm2.inag005_i,'','','')
                     RETURNING l_success,l_flag2
                  IF NOT l_success OR NOT l_flag2 THEN
                     #控制组检查错误,请检查单别设定的相关内容
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00122'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     NEXT FIELD CURRENT
                  END IF
               END IF
            #ELSE
            #   LET tm2.inag006_i = ' '
            #   DISPLAY tm2.inag006_i TO inag006_i
            END IF
            #CALL asft310_01_set_entry()
            #CALL asft310_01_set_no_entry()
           
         #BEFORE FIELD inag006_i
         #   #批号
         #   CALL asft310_01_set_entry()
   
         ON ACTION controlp INFIELD inag004_i
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm2.inag004_i

            #关于控制组
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_doc_sql("inaa001",g_sfdadocno,'6')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_inaa001_2()
            LET tm2.inag004_i = g_qryparam.return1     #將開窗取得的值>
            NEXT FIELD inag004_i
   
         ON ACTION controlp INFIELD inag005_i
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm2.inag005_i
            IF cl_null(tm2.inag004_i) THEN  #170309-00013#1 add
               LET g_qryparam.arg1 = '226'
               CALL q_inab002_2()
            #170309-00013#1--add--start---
            ELSE
               LET g_qryparam.arg1 = tm2.inag004_i
               CALL q_inab002_5()
            END IF            
            #170309-00013#1--add--end-----
            LET tm2.inag005_i = g_qryparam.return1     #將開窗取得的值>
            NEXT FIELD inag005_i
   
         ON ACTION controlp INFIELD inag006_i
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm2.inag006_i
            LET g_qryparam.arg1 = '226'
            CALL q_inag006()
            LET tm2.inag006_i = g_qryparam.return1     #將開窗取得的值>
            NEXT FIELD inag006_i
   
         ON ACTION controlp INFIELD inag003_i
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm2.inag003_i
            LET g_qryparam.arg1 = '226'
            CALL q_inag003()
            LET tm2.inag003_i = g_qryparam.return1     #將開窗取得的值>
            NEXT FIELD inag003_i
   
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
   
            CALL cl_showmsg()      #錯誤訊息統整顯示
            #DISPLAY BY NAME tm2.inag004_i,tm2.inag005_i,tm2.inag006_i,tm2.inag003_i
   
         #产生子画面单身
         ON ACTION gen_b_01
            CALL asft310_01_generate_chk() RETURNING l_column
            CASE l_column
                WHEN 'inag004_i'
                     NEXT FIELD inag004_i
                WHEN 'inag005_i'
                     NEXT FIELD inag005_i
                WHEN 'reason'
                     NEXT FIELD reason
                OTHERWISE
                     CALL asft310_01_generate()
                     CALL asft310_01_show()
            END CASE
         
         #170103-00017#1 add--s
         #清除单身
         ON ACTION del_b_01
            IF cl_ask_confirm('asf-00667') THEN
               DELETE FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
               CALL asft310_01_show()
            END IF
         #170103-00017#1 add--e
   
      END INPUT

      #指定库位条件
      CONSTRUCT BY NAME tm2.wc ON inag004,inag005,inag006,inag003,inac003,inaa015,inaa010,inaa008  #160628-00017 by whitney add ,inaa008
   
         BEFORE CONSTRUCT
            LET tm2.inag004_i = ''
            LET tm2.inag005_i = ''
            LET tm2.inag006_i = ''
            LET tm2.inag003_i = ''
            #CALL cl_qbe_init()
   
         ON ACTION controlp INFIELD inag004   #库位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            #关于控制组
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_doc_sql("inaa001",g_sfdadocno,'6')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            
            CALL q_inaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag004  #顯示到畫面上
            NEXT FIELD inag004                     #返回原欄位
   
         ON ACTION controlp INFIELD inag005   #储位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inabsite ='",g_site,"' "
            CALL q_inab002_2()                           #呼叫開窗 
            DISPLAY g_qryparam.return1 TO inag005  #顯示到畫面上
            NEXT FIELD inag005                     #返回原欄位
   
         ON ACTION controlp INFIELD inag006   #批号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag006  #顯示到畫面上
            NEXT FIELD inag006                     #返回原欄位
   
         ON ACTION controlp INFIELD inag003   #库存管理特征
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inag003  #顯示到畫面上
            NEXT FIELD inag003                     #返回原欄位
            
         ON ACTION controlp INFIELD inac003   #标签
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '220'
            CALL q_oocq002_5()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO inac003  #顯示到畫面上
            NEXT FIELD inac003                    #返回原欄位
   
         #产生子画面单身
         ON ACTION gen_b_01
            CALL asft310_01_generate_chk() RETURNING l_column
            CASE l_column
                WHEN 'inag004_i'
                     NEXT FIELD inag004_i
                WHEN 'inag005_i'
                     NEXT FIELD inag005_i
                WHEN 'reason'
                     NEXT FIELD reason
                OTHERWISE
                     CALL asft310_01_generate()
                     CALL asft310_01_show()
            END CASE
         
         #170103-00017#1 add--s
         #清除单身
         ON ACTION del_b_01
            IF cl_ask_confirm('asf-00667') THEN
               DELETE FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
               CALL asft310_01_show()
            END IF
         #170103-00017#1 add--e
   
      END CONSTRUCT

      #Page1 預設值產生於此處
      INPUT ARRAY g_sfdc_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)

         #自訂ACTION(detail_input,page_1)


         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
              CALL FGL_SET_ARR_CURR(g_sfdc_d.getLength()+1)
              LET g_insert = 'N'
           END IF

            CALL asft310_01_b_fill()
            LET g_rec_b = g_sfdc_d.getLength()

         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac

            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx

            LET g_rec_b = g_sfdc_d.getLength()

            IF g_rec_b >= l_ac AND g_sfdc_d[l_ac].sfdcseq IS NOT NULL THEN
               LET l_cmd='u'
               LET g_bfill = "N"
               CALL asft310_01_show()
               LET g_bfill = "Y"
               LET g_sfdc_d_t.* = g_sfdc_d[l_ac].*  #BACKUP
               LET g_sfdc_d_o.* = g_sfdc_d[l_ac].*  #BACKUP   #160824-00007#251 by sakura add
               CALL asft310_01_set_entry_b(l_cmd)
               CALL asft310_01_set_no_entry_b(l_cmd)
            ELSE
               LET l_cmd='a'
            END IF
            #其他table資料備份(確定是否更改用)

            #其他table進行lock


         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sfdc_d[l_ac].* TO NULL
            LET g_sfdc_d_t.* = g_sfdc_d[l_ac].*     #新輸入資料
            LET g_sfdc_d_o.* = g_sfdc_d[l_ac].*     #新輸入資料   #160824-00007#251 by sakura add
            CALL cl_show_fld_cont()
            CALL asft310_01_set_entry_b(l_cmd)
            CALL asft310_01_set_no_entry_b(l_cmd)
            #预设项次，此项次最后不会写入到实体的sfdc_t,只是为了便于在本方面中进行单身的编辑保存等处理
            SELECT MAX(sfdcseq) INTO g_sfdc_d[l_ac].sfdcseq
              FROM asft310_01_sfdc_t
             WHERE sfdcent = g_enterprise
               AND sfdcdocno=g_sfdadocno
            IF g_sfdc_d[l_ac].sfdcseq IS NULL THEN
               LET g_sfdc_d[l_ac].sfdcseq = 0
            END IF
            LET g_sfdc_d[l_ac].sfdcseq = g_sfdc_d[l_ac].sfdcseq + 1
            IF NOT cl_null(tm.reason) THEN
               LET g_sfdc_d[l_ac].sfdc015 = tm.reason  #理由码
            END IF

         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            #单身画面能编辑的，不能合并的栏位：工单+项次+项序+参考单位+库位+储位+批号+库存管理特征+理由码 最后需合并的
            LET l_count = 1
            IF g_sfdc_d[l_ac].sfdc009 IS NULL THEN
               SELECT COUNT(1) INTO l_count FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
                  #AND sfdcseq = g_sfdc_d[l_ac].sfdcseq
                  AND sfdc001 = g_sfdc_d[l_ac].sfdc001
                  AND sfdc002 = g_sfdc_d[l_ac].sfdc002
                  AND sfdc003 = g_sfdc_d[l_ac].sfdc003
                  AND sfdc009 IS NULL  #参考单位
                  AND sfdc012 = g_sfdc_d[l_ac].sfdc012  #库位
                  AND sfdc013 = g_sfdc_d[l_ac].sfdc013  #储位
                  AND sfdc014 = g_sfdc_d[l_ac].sfdc014  #批号
                  AND sfdc016 = g_sfdc_d[l_ac].sfdc016  #库存管理特征
                  AND sfdc015 = g_sfdc_d[l_ac].sfdc015  #理由码
            ELSE
               SELECT COUNT(1) INTO l_count FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno
                  #AND sfdcseq = g_sfdc_d[l_ac].sfdcseq
                  AND sfdc001 = g_sfdc_d[l_ac].sfdc001
                  AND sfdc002 = g_sfdc_d[l_ac].sfdc002
                  AND sfdc003 = g_sfdc_d[l_ac].sfdc003
                  AND sfdc009 = g_sfdc_d[l_ac].sfdc009  #参考单位
                  AND sfdc012 = g_sfdc_d[l_ac].sfdc012  #库位
                  AND sfdc013 = g_sfdc_d[l_ac].sfdc013  #储位
                  AND sfdc014 = g_sfdc_d[l_ac].sfdc014  #批号
                  AND sfdc016 = g_sfdc_d[l_ac].sfdc016  #库存管理特征
                  AND sfdc015 = g_sfdc_d[l_ac].sfdc015  #理由码
            END IF
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               IF cl_null(g_sfdc_d[g_detail_idx].sfdc012) THEN LET g_sfdc_d[g_detail_idx].sfdc012 = ' ' END IF
               IF cl_null(g_sfdc_d[g_detail_idx].sfdc013) THEN LET g_sfdc_d[g_detail_idx].sfdc013 = ' ' END IF
               IF cl_null(g_sfdc_d[g_detail_idx].sfdc014) THEN LET g_sfdc_d[g_detail_idx].sfdc014 = ' ' END IF
              #IF cl_null(g_sfdc_d[g_detail_idx].sfdc016) THEN LET g_sfdc_d[g_detail_idx].sfdc016 = ' ' END IF    #160519-00008#18 mark
               #160519-00008#18--(S)
               IF cl_null(g_sfdc_d[g_detail_idx].sfdc016) THEN
                  SELECT imaf055 INTO l_imaf055
                    FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_sfdc_d[l_ac].sfdc004
                  IF l_imaf055 = '1' THEN
                     LET g_sfdc_d[g_detail_idx].sfdc016 = ''
                  ELSE
                     LET g_sfdc_d[g_detail_idx].sfdc016 = ' '
                  END IF
               END IF
               #160519-00008#18--(E)                  
               IF cl_null(g_sfdc_d[g_detail_idx].sfdc010) THEN LET g_sfdc_d[g_detail_idx].sfdc010 = 0 END IF #参考单位需求数量
               #150115 add 单位取位
               CALL s_aooi250_get_msg(g_sfdc_d[g_detail_idx].sfdc006) RETURNING l_success,g_ooca002,g_ooca004
               IF l_success THEN
                  CALL s_num_round('4',g_sfdc_d[g_detail_idx].sfdc007,g_ooca002) RETURNING g_sfdc_d[g_detail_idx].sfdc007  #151118-00016 by whitney modify g_ooca004-->'4'
               END IF
               IF NOT cl_null(g_sfdc_d[g_detail_idx].sfdc009) THEN
                  CALL s_aooi250_get_msg(g_sfdc_d[g_detail_idx].sfdc009) RETURNING l_success,g_ooca002,g_ooca004
                  IF l_success THEN
                     CALL s_num_round('4',g_sfdc_d[g_detail_idx].sfdc010,g_ooca002) RETURNING g_sfdc_d[g_detail_idx].sfdc010  #151118-00016 by whitney modify g_ooca004-->'4'
                  END IF
               END IF
               #150115 add end
               INSERT INTO asft310_01_sfdc_t
                           (sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
                            sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016)
                     VALUES(g_enterprise,g_site,g_sfdadocno,g_sfdc_d[g_detail_idx].sfdcseq,
                            g_sfdc_d[g_detail_idx].sfdc001,g_sfdc_d[g_detail_idx].sfdc002,g_sfdc_d[g_detail_idx].sfdc003,g_sfdc_d[g_detail_idx].sfdc004,g_sfdc_d[g_detail_idx].sfdc005,g_sfdc_d[g_detail_idx].sfdc006,g_sfdc_d[g_detail_idx].sfdc007,0,g_sfdc_d[g_detail_idx].sfdc009,g_sfdc_d[g_detail_idx].sfdc010,0,g_sfdc_d[g_detail_idx].sfdc012,g_sfdc_d[g_detail_idx].sfdc013,g_sfdc_d[g_detail_idx].sfdc014,g_sfdc_d[g_detail_idx].sfdc015,g_sfdc_d[g_detail_idx].sfdc016)
               IF SQLCA.SQLcode  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "asft310_01_sfdc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL INSERT
               ELSE
                  #ERROR 'INSERT O.K'
                  LET g_rec_b = g_rec_b + 1
               END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_sfdc_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF


         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_sfdc_d.deleteElement(l_ac)
               NEXT FIELD sfdcseq
            END IF

            IF g_sfdc_d[l_ac].sfdcseq IS NOT NULL THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF

               DELETE FROM asft310_01_sfdc_t
                WHERE sfdcent = g_enterprise
                  AND sfdcdocno = g_sfdadocno AND sfdcseq = g_sfdc_d_t.sfdcseq
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "asft310_01_sfdc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL DELETE
               ELSE
                  LET g_rec_b = g_rec_b-1
               END IF
            END IF

         AFTER DELETE

         BEFORE FIELD sfdc001
            CALL asft310_01_set_entry_b(l_cmd)

         AFTER FIELD sfdc001
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) THEN
               IF g_sfda.sfda002='11' OR g_sfda.sfda002='13' OR g_sfda.sfda002='21' THEN
                  #检查工单需存在发料套数单身
                  SELECT COUNT(1) INTO l_cnt FROM sfdb_t
                   WHERE sfdbent = g_enterprise
                     AND sfdbdocno=g_sfdadocno
                     AND sfdb001 = g_sfdc_d[l_ac].sfdc001
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00043'
                     LET g_errparam.extend = g_sfdc_d[l_ac].sfdc001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #检查是否存在工单中，且为发放状态
                  IF NOT s_asft300_chk_stus(g_sfdc_d[l_ac].sfdc001,'F') THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc002) AND NOT cl_null(g_sfdc_d[l_ac].sfdc003) THEN
                 #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfdc_d[l_ac].sfdc001 != g_sfdc_d_t.sfdc001)) THEN   #160824-00007#251 by sakura mark
                  IF g_sfdc_d[l_ac].sfdc001 != g_sfdc_d_o.sfdc001 OR cl_null(g_sfdc_d_o.sfdc001) THEN        #160824-00007#251 by sakura add
                     CALL asft310_01_sfdc003_reference(l_cmd) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_sfdc_d[l_ac].sfdc001 = g_sfdc_d_o.sfdc001   #160824-00007#251 by sakura add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_sfdc_d_o.* = g_sfdc_d[l_ac].*   #160824-00007#251 by sakura add
            
            CALL asft310_01_set_no_entry_b(l_cmd)

         ON CHANGE sfdc001


         BEFORE FIELD sfdc002
            CALL asft310_01_set_entry_b(l_cmd)


         AFTER FIELD sfdc002
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc002) THEN
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) THEN
                  #工单号号+项次需存在工单项次中
                  SELECT COUNT(1) INTO l_cnt FROM sfba_t
                   WHERE sfbaent = g_enterprise
                     AND sfbadocno=g_sfdc_d[l_ac].sfdc001
                     AND sfbaseq = g_sfdc_d[l_ac].sfdc002
                  #LET l_cnt_t = l_cnt
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00044'
                     LET g_errparam.extend = g_sfdc_d[l_ac].sfdc001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) AND NOT cl_null(g_sfdc_d[l_ac].sfdc003) THEN
                 #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfdc_d[l_ac].sfdc002 != g_sfdc_d_t.sfdc002)) THEN   #160824-00007#251 by sakura mark
                  IF g_sfdc_d[l_ac].sfdc002 != g_sfdc_d_o.sfdc002 OR cl_null(g_sfdc_d_o.sfdc002) THEN        #160824-00007#251 by sakura add
                     CALL asft310_01_sfdc003_reference(l_cmd) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_sfdc_d[l_ac].sfdc002 = g_sfdc_d_o.sfdc002   #160824-00007#251 by sakura add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_sfdc_d_o.* = g_sfdc_d[l_ac].*   #160824-00007#251 by sakura add
            
            CALL asft310_01_set_no_entry_b(l_cmd)

         ON CHANGE sfdc002


         BEFORE FIELD sfdc003  #工单项序
            #工单单号+项次若只有一个项序时，自动带出
            IF cl_null(g_sfdc_d[l_ac].sfdc003) THEN
               SELECT COUNT(1) INTO l_cnt FROM sfba_t
                WHERE sfbaent = g_enterprise
                  AND sfbadocno=g_sfdc_d[l_ac].sfdc001
                  AND sfbaseq = g_sfdc_d[l_ac].sfdc002
               IF l_cnt = 1 THEN
                  SELECT sfbaseq1 INTO g_sfdc_d[l_ac].sfdc003 FROM sfba_t
                      WHERE sfbaent = g_enterprise
                        AND sfbadocno=g_sfdc_d[l_ac].sfdc001
                        AND sfbaseq = g_sfdc_d[l_ac].sfdc002
               END IF
            END IF

            CALL asft310_01_set_entry_b(l_cmd)

         AFTER FIELD sfdc003
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc003) THEN
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) AND NOT cl_null(g_sfdc_d[l_ac].sfdc002) THEN
                 #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfdc_d[l_ac].sfdc003 != g_sfdc_d_t.sfdc003)) THEN   #160824-00007#251 by sakura mark
                  IF g_sfdc_d[l_ac].sfdc003 != g_sfdc_d_o.sfdc003 OR cl_null(g_sfdc_d_o.sfdc003) THEN        #160824-00007#251 by sakura add
                     CALL asft310_01_sfdc003_reference(l_cmd) RETURNING l_success
                     IF NOT l_success THEN
                        LET g_sfdc_d[l_ac].sfdc003 = g_sfdc_d_o.sfdc003   #160824-00007#251 by sakura add
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_sfdc_d_o.* = g_sfdc_d[l_ac].*   #160824-00007#251 by sakura add

            CALL asft310_01_set_no_entry_b(l_cmd)

         ON CHANGE sfdc003


         BEFORE FIELD sfdc005
            IF cl_null(g_sfdc_d[l_ac].sfdc001) OR cl_null(g_sfdc_d[l_ac].sfdc002) OR cl_null(g_sfdc_d[l_ac].sfdc003) THEN
               #请先选择工单资料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00391'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD sfdc001
            END IF
            
            #160314-00009#16 add(s)
            IF s_feature_auto_chk(g_sfdc_d[l_ac].sfdc004) AND cl_null(g_sfdc_d[l_ac].sfdc005) THEN
                CALL s_feature_single(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_site,'')
                   RETURNING l_success,g_sfdc_d[l_ac].sfdc005
                IF NOT l_success THEN
                   LET g_sfdc_d[l_ac].sfdc005 = ' '
                END IF
                CALL s_feature_description(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005)
                  RETURNING l_success,g_sfdc_d[l_ac].sfdc005_desc
                IF NOT l_success THEN
                   LET g_sfdc_d[l_ac].sfdc005_desc = ''
                END IF
                DISPLAY g_sfdc_d[l_ac].sfdc005 TO sfdc005              #顯示到畫面上
            END IF
            #160314-00009#16 add(e)

         AFTER FIELD sfdc005
            LET g_sfdc_d[l_ac].sfdc005_desc = ''
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc005) AND NOT cl_null(g_sfdc_d[l_ac].sfdc004) THEN
               #检查产品特征
               IF NOT s_feature_check(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005) THEN
                  LET g_sfdc_d[l_ac].sfdc005 = g_sfdc_d_t.sfdc005
                  CALL s_feature_description(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005)
                     RETURNING l_success,g_sfdc_d[l_ac].sfdc005_desc
                  IF l_success THEN
                     DISPLAY BY NAME g_sfdc_d[l_ac].sfdc005_desc
                  END IF
                  NEXT FIELD sfdc005
               END IF
               #--151224-00025#4 add start--
               IF NOT s_feature_direct_input(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d_t.sfdc005,g_sfdadocno,g_site) THEN
                  NEXT FIELD CURRENT
               END IF
               #--151224-00025#4 add end--
               
               #add 141209 退料单检查
               IF g_prog[1,6]='asft32' THEN
                  #做产品特征管理的料件检查该特征的退料量不可超过已发量
                  CALL asft310_01_chk_feature2() RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #add 141209 end
               
               #显示产品特征说明
               CALL s_feature_description(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005)
                  RETURNING l_success,g_sfdc_d[l_ac].sfdc005_desc
               IF NOT l_success THEN
                  LET g_sfdc_d[l_ac].sfdc005_desc = ''
               END IF
            END IF
            DISPLAY BY NAME g_sfdc_d[l_ac].sfdc005_desc

         ON CHANGE sfdc005


         AFTER FIELD sfdc006
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfdc_d[l_ac].sfdc006
            CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfdc_d[l_ac].sfdc006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfdc_d[l_ac].sfdc006_desc
            
         BEFORE FIELD sfdc006


         ON CHANGE sfdc006


         BEFORE FIELD sfdc007


         AFTER FIELD sfdc007
            #申请数量
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc007) THEN
               #不可小于等于0
               IF g_sfdc_d[l_ac].sfdc007 <= 0 THEN
                  #资料不可小于等于0,请检查！请录入大于0的资料
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00025'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #检查是否可超过 可发/退数量——对工单可发可退数量的检查
               IF NOT asft310_01_chk_sfdc007(l_cmd) THEN
                  NEXT FIELD CURRENT
               END IF
               #mark reason，产生的需求资料可以不考虑库存足量，因为只是需求，还没到具体发的料
               ##检查是否可超过 可发数量——对库存足量否的检查
               #IF NOT asft310_01_chk_sfdc007_2(l_cmd,g_sfdc_d_t.sfdcseq,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016) THEN
               #   NEXT FIELD CURRENT
               #END IF
               
               #add 150115 单位取位
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc006) THEN
                  CALL s_aooi250_get_msg(g_sfdc_d[l_ac].sfdc006) RETURNING l_success,g_ooca002,g_ooca004
                  IF l_success THEN
                     CALL s_num_round('4',g_sfdc_d[l_ac].sfdc007,g_ooca002) RETURNING g_sfdc_d[l_ac].sfdc007  #151118-00016 by whitney modify g_ooca004-->'4'
                     DISPLAY BY NAME g_sfdc_d[l_ac].sfdc007
                  END IF
               END IF
               #add 150115 end
               
               #160512-00004#2-add-(S)
               #預帶庫儲批
              #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) THEN                                           #161115-00034#1  mark
               IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007)  AND  cl_null(g_sfdc_d[l_ac].sfdc012)THEN      #161115-00034#1  add
                  #160726-00001#6-s
                  #CALL asft310_01_inag_default() RETURNING g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016 
                  LET lc_param.sfbadocno = g_sfba.sfbadocno   
                  LET lc_param.sfbaseq   = g_sfba.sfbaseq
                  LET lc_param.sfbaseq1  = g_sfba.sfbaseq1
                  LET lc_param.sfba006   = g_sfba.sfba006
                  LET lc_param.sfba013   = issue_qty
                  LET lc_param.sfba014   = g_sfba.sfba014
                  LET lc_param.sfba016   = 0
                  LET lc_param.sfba021   = g_sfba.sfba021
                  LET lc_param.sfba029   = g_sfba.sfba029
                  LET lc_param.sfba030   = g_sfba.sfba030
                  LET ls_js = util.JSON.stringify(lc_param)
                  #170602-00036#1 add --(S)--
                  LET l_prog = g_prog
                  IF g_prog[1,7] = 'asft311' THEN
                     LET g_prog = 'asft310_01'
                  END IF   
                  #170602-00036#1 add --(E)--
                  CALL s_asft310_inag_default(ls_js) RETURNING g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016 
                  #160726-00001#6-e
                  LET g_prog = l_prog   #170602-00036#1 add
                  #库位名称
                  CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
                  #储位名称
                  CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
               END IF
               #160512-00004#2-add-(E)
               
               #发料单做在捡量的检查
               #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN  #在捡数量 库位  #170512-00023#1 mark
               #IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN LET g_sfdc_d[l_ac].sfdc016= ' ' END IF  #库存管理特征     #160519-00008#18 mark
               #160519-00008#18--(S)
               IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                  SELECT imaf055 INTO l_imaf055
                    FROM imaf_t
                   WHERE imafent = g_enterprise
                     AND imafsite = g_site
                     AND imaf001 = g_sfdc_d[l_ac].sfdc004
                  IF l_imaf055 = '1' THEN
                     LET g_sfdc_d[l_ac].sfdc016= ''
                  ELSE
                     LET g_sfdc_d[l_ac].sfdc016= ' '
                  END IF
               END IF
               #160519-00008#18--(E)
               IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013= ' ' END IF  #储位
               IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014= ' ' END IF  #批号
               #170516-00063#1-s
               ##170512-00023#1-s
               #CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
               #CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-BAS-0070') RETURNING g_para
               #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_para = 'Y' THEN
               ##170512-00023#1-e
               IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_bas_0070 = 'Y' THEN
               #170516-00063#1-e
                  #指定庫位、儲位、批號時，判斷參數是否檢查在檢量，如需檢查在檢量，在庫存數-在檢數不足申請數量時不允許輸入
                  #                           据点   料件编号                产品特征                库存管理特征
                  CALL s_inventory_check_inan(g_site,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc016,
                  #                           库位                   储位                    批号
                                              g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,
                  #                           交易单位                在捡数量
                                              g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,
                  #                           单据编号     项次                   项序              工單單號               工單項次
                                              g_sfdadocno,g_sfdc_d[l_ac].sfdcseq,'0',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002)  #160408-00035#9-add-g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002
                       RETURNING l_success,l_flag
                  IF NOT l_flag THEN
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               
               #add 141209 退料单检查
               IF g_prog[1,6]='asft32' THEN
                  #做产品特征管理的料件检查该特征的退料量不可超过已发量
                  CALL asft310_01_chk_feature2() RETURNING l_success
                  IF NOT l_success THEN
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #add 141209 end
               
               #更新相关栏位-参考单位申请数量
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc009) THEN
                  #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
                  #mark 150101
                  #CALL s_aimi190_get_convert(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009) RETURNING l_success,l_rate
                  #IF NOT l_success THEN
                  #   LET l_rate = 1
                  #END IF
                  #LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007 * l_rate
                  #mark 150101 end
                  #add 150101
                  CALL s_aooi250_convert_qty(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc007)
                     RETURNING l_success,g_sfdc_d[l_ac].sfdc010
                  IF NOT l_success THEN
                     LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007
                  END IF
                  #add 150101 end
               ELSE
                  LET g_sfdc_d[l_ac].sfdc010 = 0
               END IF
            END IF

         ON CHANGE sfdc007


         BEFORE FIELD sfdc008


         AFTER FIELD sfdc008



         ON CHANGE sfdc008


         AFTER FIELD sfdc009
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc009) THEN
               #校验带值说明
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_sfdc_d[l_ac].sfdc009
               #160318-00025#21  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00005:sub-01302|aooi250|",cl_get_progname("aooi250",g_lang,"2"),"|:EXEPROGaooi250"
               #160318-00025#21  by 07900 --add-end  
               IF cl_chk_exist_and_ref_val("v_ooca001_1") THEN
                  #檢查成功時後續處理
                  LET g_sfdc_d[l_ac].sfdc009_desc = g_chkparam.return1
                  DISPLAY BY NAME g_sfdc_d[l_ac].sfdc009_desc
               ELSE
                  #檢查失敗時後續處理
                  LET g_sfdc_d[l_ac].sfdc009 = g_sfdc_d_t.sfdc009
                  NEXT FIELD CURRENT
               END IF

               #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
               #mark 150101
               #CALL s_aimi190_get_convert(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009) RETURNING l_success,l_rate
               #IF NOT l_success THEN
               #   LET l_rate = 1
               #END IF
               #LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007 * l_rate
               #mark 150101 end
               #add 150101
               CALL s_aooi250_convert_qty(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc007)
                  RETURNING l_success,g_sfdc_d[l_ac].sfdc010
               IF NOT l_success THEN
                  LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007
               END IF
               #add 150101 end
            ELSE
               LET g_sfdc_d[l_ac].sfdc010 = 0
            END IF


         BEFORE FIELD sfdc009

         ON CHANGE sfdc009

         AFTER FIELD sfdc010
            #参考单位申请数量
            IF g_ref_unit='Y' AND NOT cl_null(g_sfdc_d[l_ac].sfdc009) AND cl_null(g_sfdc_d[l_ac].sfdc010) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'aoo-00052'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD CURRENT
            END IF

            IF NOT cl_null(g_sfdc_d[l_ac].sfdc010) THEN 
               #不可小于0
               IF g_sfdc_d[l_ac].sfdc010 < 0 THEN
                  #资料不可小于0,请检查！,请录入大于等于0的资料
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axc-00024'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF 

         BEFORE FIELD sfdc010


         ON CHANGE sfdc010


         BEFORE FIELD sfdc011


         AFTER FIELD sfdc011



         ON CHANGE sfdc011


         AFTER FIELD sfdc012
            #仓库
            IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN
               LET g_sfdc_d[l_ac].sfdc012_desc = ''
               DISPLAY BY NAME g_sfdc_d[l_ac].sfdc012_desc
            END IF
            
            #不可输入的栏位不做检查，以防死循环（工單指定的時候庫存不一定有了，可能是還在在製的東西，等庫存有了就能發了）
            IF g_sfdc012_switch = 'Y' THEN
               #add by lixh 20151109
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) THEN
                  SELECT sfaa005,sfaa010 INTO l_sfaa005,l_sfaa010 FROM sfaa_t
                   WHERE sfaaent = g_enterprise
                     AND sfaadocno = g_sfdc_d[l_ac].sfdc001
                  IF l_sfaa005 = '5' AND l_sfaa010 = g_sfdc_d[l_ac].sfdc004 THEN
                     #檢查倉庫是否未非成本倉
                     LET l_inaa010 = ''
                     SELECT inaa010 INTO l_inaa010 FROM inaa_t
                      WHERE inaaent = g_enterprise
                        AND inaasite = g_site
                        AND inaa001 = g_sfdc_d[l_ac].sfdc012
                     IF l_inaa010 <> 'N' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'arm-00011'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        NEXT FIELD sfdc012
                     END IF                     
                  END IF
               END IF   
               #add by lixh 20151109           
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc012) AND (g_sfdc_d[l_ac].sfdc012 != g_sfdc_d_t.sfdc012 OR g_sfdc_d_t.sfdc012 IS NULL) THEN
                  #校验带值说明，保税否，成本仓否
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sfdc_d[l_ac].sfdc012
                   #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
                  #160318-00025#21  by 07900 --add-end
                  IF cl_chk_exist_and_ref_val("v_inaa002_2") THEN
                     #檢查成功時後續處理
                     LET g_sfdc_d[l_ac].sfdc012_desc = g_chkparam.return1
                     LET l_inaa015 = g_chkparam.return2
                     LET l_inaa010 = g_chkparam.return3
                     IF cl_null(l_inaa015) THEN LET l_inaa015='N' END IF
                     IF cl_null(l_inaa010) THEN LET l_inaa010='N' END IF
                     DISPLAY BY NAME g_sfdc_d[l_ac].sfdc012_desc
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sfdc_d[l_ac].sfdc012 = g_sfdc_d_t.sfdc012
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160128-00004#1-add-(S)
                  #庫位檢查 
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sfdc_d[l_ac].sfdc004
                  IF cl_null(g_sfdc_d[l_ac].sfdc005) THEN
                     LET g_chkparam.arg2 = ' '
                  ELSE
                     LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfdc005
                  END IF
                  LET g_chkparam.arg3 = g_sfdc_d[l_ac].sfdc012
                  #已有指定不可输入
                  LET g_chkparam.where = "1=1 "
                  LET l_sfba019=''
                  LET l_sfba020=''
                  LET l_sfba029=''
                  LET l_sfba030=''
                  SELECT sfba019,sfba020,sfba029,sfba030
                    INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
                    FROM sfba_t
                   WHERE sfbaent  = g_enterprise
                     AND sfbadocno= g_sfdc_d[l_ac].sfdc001
                     AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
                     AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
                  IF g_sfdc013_switch = 'N' THEN
                     IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                        IF NOT cl_null(l_sfba020) THEN
                           LET g_chkparam.where = g_chkparam.where ," AND inag005 = '",l_sfba020,"' "
                        ELSE
                           LET g_chkparam.where = g_chkparam.where ," AND inag005 = ' ' "
                        END IF
                        #mod 150107 end
                     ELSE
                        LET g_chkparam.where = g_chkparam.where ," AND inag005 = '",g_sfdc_d[l_ac].sfdc013,"' "
                     END IF
                  END IF
                  IF g_sfdc014_switch = 'N' THEN
                     IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN
                        IF NOT cl_null(l_sfba029) THEN
                           LET g_chkparam.where = g_chkparam.where ," AND inag006 = '",l_sfba029,"' "
                        ELSE
                           LET g_chkparam.where = g_chkparam.where ," AND inag006 = ' ' "
                        END IF
                     ELSE
                        LET g_chkparam.where = g_chkparam.where ," AND inag006 = '",g_sfdc_d[l_ac].sfdc014,"' "
                     END IF
                  END IF
                  IF g_sfdc016_switch = 'N' THEN
                     IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                        IF NOT cl_null(l_sfba030) THEN
                           LET g_chkparam.where = g_chkparam.where ," AND inag003 = '",l_sfba030,"' "
                        ELSE
                           LET g_chkparam.where = g_chkparam.where ," AND inag003 = ' ' "
                        END IF
                     ELSE
                        LET g_chkparam.where = g_chkparam.where ," AND inag003 = '",g_sfdc_d[l_ac].sfdc016,"' "
                     END IF
                  END IF
                  
                  #控制組
                  CALL s_control_get_doc_sql("inag004",g_sfdadocno,'6')
                       RETURNING l_success,l_where
                  IF l_success THEN
                     LET g_chkparam.where = g_chkparam.where ," AND ",l_where
                  END IF
                  #sfdc012開窗有依「g_sfda.sfda002[1,1]='1'」判斷要開哪個窗，其差別在於這個條件→「inag008 > 0」
                  IF g_sfda.sfda002[1,1]='1' THEN #發料單 庫存>0
                     #LET g_chkparam.where = g_chkparam.where," AND inag008 > 0"  #170207-00039#1
                  #END IF     #170110-00005#1 mark
                     IF NOT cl_chk_exist("v_inag004_6") THEN
                        #檢查失敗時後續處理
                        LET g_sfdc_d[l_ac].sfdc012 = g_sfdc_d_t.sfdc012
                        LET g_sfdc_d[l_ac].sfdc012_desc = ''
                        LET l_inaa015 = 'N'
                        LET l_inaa010 = 'N'
                        DISPLAY BY NAME g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc012_desc
                        NEXT FIELD CURRENT
                     END IF
                     #160128-00004#1-add-(E)    

                  END IF     #170110-00005#1 add-
                  
                  #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
                  CALL s_control_chk_doc('6',g_sfdadocno,g_sfdc_d[l_ac].sfdc012,'','','','') 
                     RETURNING l_success,l_flag2
                  IF NOT l_success OR NOT l_flag2 THEN
                     #控制组检查错误,请检查单别设定的相关内容
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00122'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_sfdc_d[l_ac].sfdc012 = g_sfdc_d_t.sfdc012
                     NEXT FIELD CURRENT
                  END IF
               
                  #如果储位已有，检查储位
                  IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                     #校验带值说明
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_sfdc_d[l_ac].sfdc012
                     LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfdc013
                     #160318-00025#21  by 07900 --add-str
                     LET g_errshow = TRUE #是否開窗                   
                     LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                     #160318-00025#21  by 07900 --add-end
                     IF cl_chk_exist_and_ref_val("v_inab003_2") THEN
                        #檢查成功時後續處理
                        LET g_sfdc_d[l_ac].sfdc013_desc = g_chkparam.return1
                     ELSE
                        LET g_sfdc_d[l_ac].sfdc012 = g_sfdc_d_t.sfdc012
                        NEXT FIELD CURRENT
                     END IF
                     DISPLAY BY NAME g_sfdc_d[l_ac].sfdc013_desc
                  END IF
               
                  IF g_prog[1,6] = 'asft31' THEN
                     #参数：生產非保稅料號，可由保稅倉發料
                     #画面上的保税料栏位对应的是需求料号
                     #这里的控制是对于生产料号是否保税料
                     CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0031') RETURNING g_para
                     SELECT sfaa010,imaf034 INTO l_sfaa010,l_imaf034 
                       FROM sfaa_t,imaf_t
                      WHERE sfaaent = imafent
                        AND sfaasite= imafsite
                        AND sfaa010 = imaf001
                        AND sfaaent   = g_enterprise
                        AND sfaasite  = g_site
                        AND sfaadocno = g_sfdc_d[l_ac].sfdc001
                     #當工單的生產料號=非保稅料，不可由保稅倉發料。
                     IF l_imaf034='N' AND (g_para = '1' OR g_para = '2') THEN  #拒绝或警告
                        CASE
                           WHEN l_inaa015='Y' AND g_para = '1'
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = 'asr-00008'
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                                NEXT FIELD CURRENT
                           WHEN l_inaa015='Y' AND g_para = '2'
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = 'asr-00008'
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                        END CASE
                     END IF
                     
                     #參數：客供料可由成本倉料領料
                     CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0052') RETURNING g_para
                     #1.拒絕時，只可輸入非成本倉。(2為警告)
                     IF g_sfdc_d[l_ac].sfba028='Y' AND (g_para = '1' OR g_para = '2') THEN  
                        CASE
                           WHEN l_inaa010='Y' AND g_para = '1' #拒绝
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = 'asf-00048'
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                                NEXT FIELD CURRENT
                           WHEN l_inaa010='Y' AND g_para = '2' #警告
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.code = 'asf-00048'
                                LET g_errparam.extend = ''
                                LET g_errparam.popup = TRUE
                                CALL cl_err()
                        END CASE
                     END IF
                  END IF
                  
                  #mark reason，产生的需求资料可以不考虑库存足量，因为只是需求，还没到具体发的料
                  ##检查数量是否可超过 可发数量——对库存足量否的检查
                  #IF NOT asft310_01_chk_sfdc007_2(l_cmd,g_sfdc_d_t.sfdcseq,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016) THEN
                  #   NEXT FIELD sfdc012
                  #END IF
                  #在捡量根据参数设置要做检查
                  #发料单做在捡量的检查
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN  #在捡数量 库位  #170512-00023#1 mark
                  #IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN LET g_sfdc_d[l_ac].sfdc016= ' ' END IF  #库存管理特征
                  #160519-00008#18--(S)
                  IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN 
                     SELECT imaf055 INTO l_imaf055
                       FROM imaf_t
                      WHERE imafent = g_enterprise
                        AND imafsite = g_site
                        AND imaf001 = g_sfdc_d[l_ac].sfdc004
                     IF l_imaf055 = '1' THEN
                        LET g_sfdc_d[l_ac].sfdc016= '' 
                     ELSE
                        LET g_sfdc_d[l_ac].sfdc016= ' ' 
                     END IF
                  END IF
                  #160519-00008#18--(E)                     
                  IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013= ' ' END IF  #储位
                  IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014= ' ' END IF  #批号
                  #170516-00063#1-s
                  ##170512-00023#1-s
                  #CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
                  #CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-BAS-0070') RETURNING g_para
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_para = 'Y' THEN
                  ##170512-00023#1-e
                  IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_bas_0070 = 'Y' THEN
                  #170516-00063#1-e
                     #指定庫位、儲位、批號時，判斷參數是否檢查在檢量，如需檢查在檢量，在庫存數-在檢數不足申請數量時不允許輸入
                     #                           据点   料件编号                产品特征                库存管理特征
                     CALL s_inventory_check_inan(g_site,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc016,
                     #                           库位                   储位                    批号
                                                 g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,
                     #                           交易单位                在捡数量
                                                 g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,
                     #                           单据编号     项次                   项序              工單單號                工單項次
                                                 g_sfdadocno,g_sfdc_d[l_ac].sfdcseq,'0',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002)  #160408-00035#9-add-g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002
                          RETURNING l_success,l_flag
                     IF NOT l_flag THEN
                        LET g_sfdc_d[l_ac].sfdc012 = g_sfdc_d_t.sfdc012
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

         BEFORE FIELD sfdc012
            IF cl_null(g_sfdc_d[l_ac].sfdc001) OR cl_null(g_sfdc_d[l_ac].sfdc002) OR cl_null(g_sfdc_d[l_ac].sfdc003) THEN
               #请先选择工单资料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00391'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD sfdc001
            END IF

         ON CHANGE sfdc012

         AFTER FIELD sfdc013
            #储位
            IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN
               LET g_sfdc_d[l_ac].sfdc013_desc = ''
               DISPLAY BY NAME g_sfdc_d[l_ac].sfdc013_desc
            END IF
            
            #不可输入的栏位不做检查，以防死循环（工單指定的時候庫存不一定有了，可能是還在在製的東西，等庫存有了就能發了）
            IF g_sfdc013_switch = 'Y' THEN
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) AND NOT cl_null(g_sfdc_d[l_ac].sfdc012)
               AND (g_sfdc_d[l_ac].sfdc013 != g_sfdc_d_t.sfdc013 OR g_sfdc_d_t.sfdc013 IS NULL) THEN
                  #校验带值说明
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sfdc_d[l_ac].sfdc012
                  LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfdc013
                  #160318-00025#21  by 07900 --add-str
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
                  #160318-00025#21  by 07900 --add-end
                  IF cl_chk_exist_and_ref_val("v_inab003_2") THEN
                     #檢查成功時後續處理
                     LET g_sfdc_d[l_ac].sfdc013_desc = g_chkparam.return1
                  ELSE
                     LET g_sfdc_d[l_ac].sfdc013 = g_sfdc_d_t.sfdc013
                     NEXT FIELD CURRENT
                  END IF
                  DISPLAY BY NAME g_sfdc_d[l_ac].sfdc013_desc
                  
                  #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
                  CALL s_control_chk_doc('6',g_sfdadocno,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,'','','')
                     RETURNING l_success,l_flag2
                  IF NOT l_success OR NOT l_flag2 THEN
                     #控制组检查错误,请检查单别设定的相关内容
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00122'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_sfdc_d[l_ac].sfdc013 = g_sfdc_d_t.sfdc013
                     NEXT FIELD CURRENT
                  END IF
               
                  #在捡量根据参数设置要做检查
                  #发料单做在捡量的检查
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN  #在捡数量 库位  #170512-00023#1 mark
                  #IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN LET g_sfdc_d[l_ac].sfdc016= ' ' END IF  #库存管理特征   #160519-00008#18
                  #160519-00008#18--(S)
                  IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN 
                     SELECT imaf055 INTO l_imaf055
                       FROM imaf_t
                      WHERE imafent = g_enterprise
                        AND imafsite = g_site
                        AND imaf001 = g_sfdc_d[l_ac].sfdc004
                     IF l_imaf055 = '1' THEN
                        LET g_sfdc_d[l_ac].sfdc016= '' 
                     ELSE
                        LET g_sfdc_d[l_ac].sfdc016= ' ' 
                     END IF
                  END IF
                  #160519-00008#18--(E)  
                  IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013= ' ' END IF  #储位
                  IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014= ' ' END IF  #批号
                  #170516-00063#1-s
                  ##170512-00023#1-s
                  #CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
                  #CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-BAS-0070') RETURNING g_para
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_para = 'Y' THEN
                  ##170512-00023#1-e
                  IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_bas_0070 = 'Y' THEN
                  #170516-00063#1-e
                     #指定庫位、儲位、批號時，判斷參數是否檢查在檢量，如需檢查在檢量，在庫存數-在檢數不足申請數量時不允許輸入
                     #                           据点   料件编号                产品特征                库存管理特征
                     CALL s_inventory_check_inan(g_site,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc016,
                     #                           库位                   储位                    批号
                                                 g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,
                     #                           交易单位                在捡数量
                                                 g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,
                     #                           单据编号     项次                   项序              工單單號               工單項次
                                                 g_sfdadocno,g_sfdc_d[l_ac].sfdcseq,'0',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002)  #160408-00035#9-add-g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002
                          RETURNING l_success,l_flag
                     IF NOT l_flag THEN
                        LET g_sfdc_d[l_ac].sfdc013 = g_sfdc_d_t.sfdc013
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
                  
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                  IF cl_null(g_sfdc_d_t.sfdc013) OR (g_sfdc_d[l_ac].sfdc013!=g_sfdc_d_t.sfdc013) THEN
                     #mark reason，产生的需求资料可以不考虑库存足量，因为只是需求，还没到具体发的料
                     ##检查数量是否可超过 可发数量——对库存足量否的检查
                     #IF NOT asft310_01_chk_sfdc007_2(l_cmd,g_sfdc_d_t.sfdcseq,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016) THEN
                     #   LET g_sfdc_d[l_ac].sfdc013 = g_sfdc_d_t.sfdc013
                     #   NEXT FIELD sfdc012
                     #END IF
                  END IF
               END IF
            END IF
            

         BEFORE FIELD sfdc013
            IF cl_null(g_sfdc_d[l_ac].sfdc001) OR cl_null(g_sfdc_d[l_ac].sfdc002) OR cl_null(g_sfdc_d[l_ac].sfdc003) THEN
               #请先选择工单资料
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00391'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD sfdc001
            END IF

         ON CHANGE sfdc013

         BEFORE FIELD sfdc014

         AFTER FIELD sfdc014
            #批号
            #不可输入的栏位不做检查，以防死循环（工單指定的時候庫存不一定有了，可能是還在在製的東西，等庫存有了就能發了）
            IF g_sfdc014_switch = 'Y' THEN
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc014) THEN
                  IF cl_null(g_sfdc_d_t.sfdc014) OR (g_sfdc_d[l_ac].sfdc014!=g_sfdc_d_t.sfdc014) THEN
                     #mark reason，产生的需求资料可以不考虑库存足量，因为只是需求，还没到具体发的料
                     ##检查数量是否可超过 可发数量——对库存足量否的检查
                     #IF NOT asft310_01_chk_sfdc007_2(l_cmd,g_sfdc_d_t.sfdcseq,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016) THEN
                     #   LET g_sfdc_d[l_ac].sfdc014 = g_sfdc_d_t.sfdc014
                     #   NEXT FIELD sfdc012
                     #END IF
                  END IF
                  
                  #在捡量根据参数设置要做检查
                  #发料单做在捡量的检查
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN  #在捡数量 库位  #170512-00023#1 mark
                  IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN LET g_sfdc_d[l_ac].sfdc016= ' ' END IF  #库存管理特征
                  IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013= ' ' END IF  #储位
                  IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014= ' ' END IF  #批号
                  #170516-00063#1-s
                  ##170512-00023#1-s
                  #CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
                  #CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-BAS-0070') RETURNING g_para
                  #IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_para = 'Y' THEN
                  ##170512-00023#1-e
                  IF g_prog[1,6]='asft31' AND NOT cl_null(g_sfdc_d[l_ac].sfdc007) AND g_bas_0070 = 'Y' THEN
                  #170516-00063#1-e
                     #指定庫位、儲位、批號時，判斷參數是否檢查在檢量，如需檢查在檢量，在庫存數-在檢數不足申請數量時不允許輸入
                     #                           据点   料件编号                产品特征                库存管理特征
                     CALL s_inventory_check_inan(g_site,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc016,
                     #                           库位                   储位                    批号
                                                 g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,
                     #                           交易单位                在捡数量
                                                 g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,
                     #                           单据编号     项次                   项序              工單單號               工單項次
                                                 g_sfdadocno,g_sfdc_d[l_ac].sfdcseq,'0',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002)  #160408-00035#9-add-g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002
                          RETURNING l_success,l_flag
                     IF NOT l_flag THEN
                        LET g_sfdc_d[l_ac].sfdc014 = g_sfdc_d_t.sfdc014
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

         ON CHANGE sfdc014


         AFTER FIELD sfdc015
            #理由码
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc015) THEN
               CALL s_azzi650_chk_exist_and_desc('226',g_sfdc_d[l_ac].sfdc015) RETURNING l_success,g_sfdc_d[l_ac].sfdc015_desc
               IF NOT l_success THEN
                  LET g_sfdc_d[l_ac].sfdc015 = g_sfdc_d_t.sfdc015
                  NEXT FIELD CURRENT
               END IF
               DISPLAY BY NAME g_sfdc_d[l_ac].sfdc015_desc
               #控制组检查
               CALL s_control_chk_doc('8',g_sfdadocno,g_sfdc_d[l_ac].sfdc015,'','','','')
                  RETURNING l_success,l_flag2
               IF NOT l_success OR NOT l_flag2 THEN
                  #控制组检查错误,请检查单别设定的相关内容
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00122'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  NEXT FIELD CURRENT
               END IF
               
            END IF

         BEFORE FIELD sfdc015

         ON CHANGE sfdc015

         BEFORE FIELD sfdc016

         AFTER FIELD sfdc016
            #库存管理特征
            #不可输入的栏位不做检查，以防死循环（工單指定的時候庫存不一定有了，可能是還在在製的東西，等庫存有了就能發了）
            IF g_sfdc016_switch = 'Y' THEN
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                  IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN LET g_sfdc_d[l_ac].sfdc012=' ' END IF
                  IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013=' ' END IF
                  IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014=' ' END IF
                  #mark 150119 reason：需求时，库存资料也可以不存在
                  #SELECT COUNT(1) INTO l_cnt FROM inag_t
                  # WHERE inagent = g_enterprise
                  #   AND inagsite= g_site
                  #   AND inag001 = g_sfdc_d[l_ac].sfdc001
                  #   AND inag003 = g_sfdc_d[l_ac].sfdc016
                  #   AND inag004 = g_sfdc_d[l_ac].sfdc012
                  #   AND inag005 = g_sfdc_d[l_ac].sfdc013
                  #   AND inag006 = g_sfdc_d[l_ac].sfdc014
                  #IF l_cnt = 0 THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'asf-00071'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_sfdc_d[l_ac].sfdc016 = g_sfdc_d_t.sfdc016
                  #   NEXT FIELD sfdc012
                  #END IF
                  #mark 150119 end
                  
                  IF cl_null(g_sfdc_d_t.sfdc016) OR (g_sfdc_d[l_ac].sfdc016!=g_sfdc_d_t.sfdc016) THEN
                     #mark reason，产生的需求资料可以不考虑库存足量，因为只是需求，还没到具体发的料
                     #检查数量是否可超过 可发数量——对库存足量否的检查
                     #IF NOT asft310_01_chk_sfdc007_2(l_cmd,g_sfdc_d_t.sfdcseq,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc016) THEN
                     #   LET g_sfdc_d[l_ac].sfdc016 = g_sfdc_d_t.sfdc016
                     #   NEXT FIELD sfdc012
                     #END IF
                  END IF
               END IF
            END IF

         ON CHANGE sfdc016

         ON ACTION controlp INFIELD sfdc001
            #工单单号
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc001
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc002
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc003
            LET g_qryparam.where = " sfbasite ='",g_site,"'"
            #IF g_sfda.sfda002='11' OR g_sfda.sfda002='13' OR g_sfda.sfda002='21' THEN
            SELECT COUNT(1) INTO l_cnt FROM sfdb_t
             WHERE sfdbent   = g_enterprise
               AND sfdbdocno = g_sfdadocno  #161109-00085#30
            IF l_cnt > 0 THEN
               #找套数页签中有的工单
               #增加条件:需同时存在与sfdb档中
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbadocno in (",
                                                               " select unique sfdb001 from sfdb_t",
                                                               "  where sfdbent = ",g_enterprise,
                                                               "    and sfdbdocno='",g_sfdadocno,"'",  #161109-00085#30
                                                               ")"
            END IF
            IF g_sfda.sfda002='22' THEN   #超领退料只开有超领量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba025 > 0 "
            END IF
            #IF g_sfda.sfda002='23' THEN   #一般退料只开有已发量的
            IF g_sfda.sfda002='21' OR g_sfda.sfda002='23' OR g_sfda.sfda002='24' OR g_sfda.sfda002='25' THEN   #一般退料只开有已发量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba016 > 0 "
            END IF
            CALL q_sfba001_1()
            LET g_sfdc_d[l_ac].sfdc001 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc002 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc003 = g_qryparam.return3
            DISPLAY g_sfdc_d[l_ac].sfdc001 TO sfdc001
            DISPLAY g_sfdc_d[l_ac].sfdc002 TO sfdc002
            DISPLAY g_sfdc_d[l_ac].sfdc003 TO sfdc003

         ON ACTION controlp INFIELD sfdc002
            #项次
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc001
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc002
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc003
            LET g_qryparam.where = " sfbasite ='",g_site,"'"

            SELECT COUNT(1) INTO l_cnt FROM sfdb_t
             WHERE sfdbent   = g_enterprise
               AND sfdbdocno = g_sfdadocno  #161109-00085#30
            IF l_cnt > 0 THEN
               #找套数页签中有的工单
               #增加条件:需同时存在与sfdb档中
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbadocno in (",
                                                               " select unique sfdb001 from sfdb_t",
                                                               "  where sfdbent = ",g_enterprise,
                                                               "    and sfdbdocno='",g_sfdadocno,"'",  #161109-00085#30
                                                               ")"
            END IF
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbadocno = '",g_sfdc_d[l_ac].sfdc001,"' "
            END IF
            IF g_sfda.sfda002='22' THEN   #超领退料只开有超领量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba025 > 0 "
            END IF
            #IF g_sfda.sfda002='23' THEN   #一般退料只开有已发量的
            IF g_sfda.sfda002='21' OR g_sfda.sfda002='23' OR g_sfda.sfda002='24' OR g_sfda.sfda002='25' THEN   #一般退料只开有已发量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba016 > 0 "
            END IF
            CALL q_sfba001_1()
            LET g_sfdc_d[l_ac].sfdc001 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc002 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc003 = g_qryparam.return3
            DISPLAY g_sfdc_d[l_ac].sfdc001 TO sfdc001
            DISPLAY g_sfdc_d[l_ac].sfdc002 TO sfdc002
            DISPLAY g_sfdc_d[l_ac].sfdc003 TO sfdc003

         ON ACTION controlp INFIELD sfdc003
            #项序
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc001
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc002
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc003
            LET g_qryparam.where = " sfbasite ='",g_site,"'"

            SELECT COUNT(1) INTO l_cnt FROM sfdb_t
             WHERE sfdbent   = g_enterprise
               AND sfdbdocno = g_sfdadocno  #161109-00085#30
            IF l_cnt > 0 THEN
               #找套数页签中有的工单
               #增加条件:需同时存在与sfdb档中
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbadocno in (",
                                                               " select unique sfdb001 from sfdb_t",
                                                               "  where sfdbent = ",g_enterprise,
                                                               "    and sfdbdocno='",g_sfdadocno,"'",  #161109-00085#30
                                                               ")"
            END IF
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc001) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbadocno = '",g_sfdc_d[l_ac].sfdc001,"' "
            END IF
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc002) THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfbaseq = ",g_sfdc_d[l_ac].sfdc002
            END IF
            IF g_sfda.sfda002='22' THEN   #超领退料只开有超领量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba025 > 0 "
            END IF
            #IF g_sfda.sfda002='23' THEN   #一般退料只开有已发量的
            IF g_sfda.sfda002='21' OR g_sfda.sfda002='23' OR g_sfda.sfda002='24' OR g_sfda.sfda002='25' THEN   #一般退料只开有已发量的
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND sfba016 > 0 "
            END IF
            CALL q_sfba001_1()
            LET g_sfdc_d[l_ac].sfdc001 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc002 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc003 = g_qryparam.return3
            DISPLAY g_sfdc_d[l_ac].sfdc001 TO sfdc001
            DISPLAY g_sfdc_d[l_ac].sfdc002 TO sfdc002
            DISPLAY g_sfdc_d[l_ac].sfdc003 TO sfdc003
            
         ON ACTION controlp INFIELD sfdc005
            CALL s_feature_single(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_site,'')
               RETURNING l_success,g_sfdc_d[l_ac].sfdc005
            IF NOT l_success THEN
               LET g_sfdc_d[l_ac].sfdc005 = ' '
            END IF
            DISPLAY g_sfdc_d[l_ac].sfdc005 TO sfdc005              #顯示到畫面上
            NEXT FIELD sfdc005 
            
         ON ACTION controlp INFIELD sfdc009
            #参考单位
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc009
            CALL q_ooca001_1()
            LET g_sfdc_d[l_ac].sfdc009 = g_qryparam.return1
            DISPLAY g_sfdc_d[l_ac].sfdc009 TO sfdc009

         ON ACTION controlp INFIELD sfdc012
            #仓库
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc012
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc013
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc014
            LET g_qryparam.default4 = g_sfdc_d[l_ac].sfdc016
            #mod 141118 q_inag004_13修改成传参方式
            #LET g_qryparam.where = " inag001 ='",g_sfdc_d[l_ac].sfdc004,"'"
            LET g_qryparam.arg1 = g_sfdc_d[l_ac].sfdc004
            IF cl_null(g_sfdc_d[l_ac].sfdc005) THEN
               LET g_qryparam.arg2 = ' '
            ELSE
               LET g_qryparam.arg2 = g_sfdc_d[l_ac].sfdc005
            END IF
            #已有指定不可输入
            LET g_qryparam.where = "1=1 "
            #add 150107
            LET l_sfba019=''
            LET l_sfba020=''
            LET l_sfba029=''
            LET l_sfba030=''
            SELECT sfba019,sfba020,sfba029,sfba030
              INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
              FROM sfba_t
             WHERE sfbaent  = g_enterprise
               AND sfbadocno= g_sfdc_d[l_ac].sfdc001
               AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
               AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
            #add 150107 end
            IF g_sfdc013_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  IF NOT cl_null(l_sfba020) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",l_sfba020,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",g_sfdc_d[l_ac].sfdc013,"' "
               END IF
            END IF
            IF g_sfdc014_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  IF NOT cl_null(l_sfba029) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",l_sfba029,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",g_sfdc_d[l_ac].sfdc014,"' "
               END IF
            END IF
            IF g_sfdc016_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  IF NOT cl_null(l_sfba030) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",l_sfba030,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",g_sfdc_d[l_ac].sfdc016,"' "
               END IF
            END IF
            #mod 141118 --end
            #关于控制组
            CALL s_control_get_doc_sql("inag004",g_sfdadocno,'6')
                 RETURNING l_success,l_where
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_where
            END IF
            #关于控制组--end
            #170516-00063#1-s
            #IF g_sfda.sfda002[1,1]='1' THEN #發料單 庫存>0
            #   CALL q_inag004_13()  #库位、储位、批号、库存管理特征
            #ELSE #退料單 不卡控库存
            #   #CALL q_inag004_16()  #库位、储位、批号、库存管理特征 #170110-00005#1 mark
            #   CALL q_inag004_21()                                #170110-00005#1 add
            #END IF
            #CALL q_inag004_16()  #170704-00048#1 mark
            #170516-00063#1-e
            #170704-00048#1-s
            IF g_sfda.sfda002[1,1]='1' THEN  #發料單
               CALL q_inag004_16()
            ELSE                               #退料單
               CALL q_inag004_21()
            END IF
            #170704-00048#1-e
            LET g_sfdc_d[l_ac].sfdc012 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc013 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc014 = g_qryparam.return3
            LET g_sfdc_d[l_ac].sfdc016 = g_qryparam.return4
            DISPLAY g_sfdc_d[l_ac].sfdc012 TO sfdc012
            DISPLAY g_sfdc_d[l_ac].sfdc013 TO sfdc013
            DISPLAY g_sfdc_d[l_ac].sfdc014 TO sfdc014 
            DISPLAY g_sfdc_d[l_ac].sfdc016 TO sfdc016 
            #栏位说明
            CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
               CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
            END IF
            DISPLAY g_sfdc_d[l_ac].sfdc012_desc TO sfdc012_desc
            DISPLAY g_sfdc_d[l_ac].sfdc013_desc TO sfdc013_desc
            NEXT FIELD sfdc012


         ON ACTION controlp INFIELD sfdc013
            #储位
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc012
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc013
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc014
            LET g_qryparam.default4 = g_sfdc_d[l_ac].sfdc016
            #mod 141118 q_inag004_13修改成传参方式
            #LET g_qryparam.where = " inag001 ='",g_sfdc_d[l_ac].sfdc004,"'"
            LET g_qryparam.arg1 = g_sfdc_d[l_ac].sfdc004
            IF cl_null(g_sfdc_d[l_ac].sfdc005) THEN
               LET g_qryparam.arg2 = ' '
            ELSE
               LET g_qryparam.arg2 = g_sfdc_d[l_ac].sfdc005
            END IF
            #已有指定不可输入
            LET g_qryparam.where = "1=1 "
            #add 150107
            LET l_sfba019=''
            LET l_sfba020=''
            LET l_sfba029=''
            LET l_sfba030=''
            SELECT sfba019,sfba020,sfba029,sfba030
              INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
              FROM sfba_t
             WHERE sfbaent  = g_enterprise
               AND sfbadocno= g_sfdc_d[l_ac].sfdc001
               AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
               AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
            #add 150107 end
            IF g_sfdc012_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  IF NOT cl_null(l_sfba019) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",l_sfba019,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",g_sfdc_d[l_ac].sfdc012,"' "
               END IF
            #170614-00004#1-s   
            ELSE
               IF NOT cl_null(g_sfdc_d[l_ac].sfdc012) THEN
                  LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",g_sfdc_d[l_ac].sfdc012,"' "
               END IF
            #170614-00004#1-e   
            END IF
            IF g_sfdc014_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  IF NOT cl_null(l_sfba029) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",l_sfba029,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",g_sfdc_d[l_ac].sfdc014,"' "
               END IF
            END IF
            IF g_sfdc016_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  IF NOT cl_null(l_sfba030) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",l_sfba030,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",g_sfdc_d[l_ac].sfdc016,"' "
               END IF
            END IF
            #mod 141118 --end
            #170516-00063#1-s
            #IF g_sfda.sfda002[1,1]='1' THEN #發料單 庫存>0
            #   CALL q_inag004_13()  #库位、储位、批号、库存管理特征
            #ELSE #退料單 不卡控库存
            #   #CALL q_inag004_16()  #库位、储位、批号、库存管理特征 #170110-00005#1 mark
            #   CALL q_inag004_21()                                #170110-00005#1 add
            #END IF
            #CALL q_inag004_21()  #170704-00048#1 mark
            #170516-00063#1-e
            #170704-00048#1-s
            IF g_sfda.sfda002[1,1]='1' THEN  #發料單
               CALL q_inag004_16()
            ELSE                               #退料單
               CALL q_inag004_21()
            END IF
            #170704-00048#1-e
            LET g_sfdc_d[l_ac].sfdc012 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc013 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc014 = g_qryparam.return3
            LET g_sfdc_d[l_ac].sfdc016 = g_qryparam.return4
            DISPLAY g_sfdc_d[l_ac].sfdc012 TO sfdc012
            DISPLAY g_sfdc_d[l_ac].sfdc013 TO sfdc013
            DISPLAY g_sfdc_d[l_ac].sfdc014 TO sfdc014 
            DISPLAY g_sfdc_d[l_ac].sfdc016 TO sfdc016 
            #栏位说明
            CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
               CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
            END IF
            DISPLAY g_sfdc_d[l_ac].sfdc012_desc TO sfdc012_desc
            DISPLAY g_sfdc_d[l_ac].sfdc013_desc TO sfdc013_desc
            NEXT FIELD sfdc013

         ON ACTION controlp INFIELD sfdc014
            #批号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc012
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc013
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc014
            LET g_qryparam.default4 = g_sfdc_d[l_ac].sfdc016
            #mod 141118 q_inag004_13修改成传参方式
            #LET g_qryparam.where = " inag001 ='",g_sfdc_d[l_ac].sfdc004,"'"
            LET g_qryparam.arg1 = g_sfdc_d[l_ac].sfdc004
            IF cl_null(g_sfdc_d[l_ac].sfdc005) THEN
               LET g_qryparam.arg2 = ' '
            ELSE
               LET g_qryparam.arg2 = g_sfdc_d[l_ac].sfdc005
            END IF
            #已有指定不可输入
            LET g_qryparam.where = "1=1 "
            #add 150107
            LET l_sfba019=''
            LET l_sfba020=''
            LET l_sfba029=''
            LET l_sfba030=''
            SELECT sfba019,sfba020,sfba029,sfba030
              INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
              FROM sfba_t
             WHERE sfbaent  = g_enterprise
               AND sfbadocno= g_sfdc_d[l_ac].sfdc001
               AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
               AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
            #add 150107 end
            IF g_sfdc012_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  IF NOT cl_null(l_sfba019) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",l_sfba019,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",g_sfdc_d[l_ac].sfdc012,"' "
               END IF
            END IF
            IF g_sfdc013_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  IF NOT cl_null(l_sfba020) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",l_sfba020,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",g_sfdc_d[l_ac].sfdc013,"' "
               END IF
            END IF
            IF g_sfdc016_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  IF NOT cl_null(l_sfba030) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",l_sfba030,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag003 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag003 = '",g_sfdc_d[l_ac].sfdc016,"' "
               END IF
            END IF
            #mod 141118 --end
            #170516-00063#1-s
            #IF g_sfda.sfda002[1,1]='1' THEN #發料單 庫存>0
            #   CALL q_inag004_13()  #库位、储位、批号、库存管理特征
            #ELSE #退料單 不卡控库存
            #   #CALL q_inag004_16()  #库位、储位、批号、库存管理特征 #170110-00005#1 mark
            #   CALL q_inag004_21()                                #170110-00005#1 add
            #END IF
            #CALL q_inag004_21()  #170704-00048# mark
            #170516-00063#1-e
            #170704-00048#1-s
            IF g_sfda.sfda002[1,1]='1' THEN  #發料單
               CALL q_inag004_16()
            ELSE                               #退料單
               CALL q_inag004_21()
            END IF
            #170704-00048#1-e
            LET g_sfdc_d[l_ac].sfdc012 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc013 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc014 = g_qryparam.return3
            LET g_sfdc_d[l_ac].sfdc016 = g_qryparam.return4
            DISPLAY g_sfdc_d[l_ac].sfdc012 TO sfdc012
            DISPLAY g_sfdc_d[l_ac].sfdc013 TO sfdc013
            DISPLAY g_sfdc_d[l_ac].sfdc014 TO sfdc014 
            DISPLAY g_sfdc_d[l_ac].sfdc016 TO sfdc016 
            #栏位说明
            CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
               CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
            END IF
            DISPLAY g_sfdc_d[l_ac].sfdc012_desc TO sfdc012_desc
            DISPLAY g_sfdc_d[l_ac].sfdc013_desc TO sfdc013_desc
            NEXT FIELD sfdc014


         ON ACTION controlp INFIELD sfdc015
            #理由码
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc015
            LET g_qryparam.arg1 = '226'
            #关于控制组
            LET g_qryparam.where = "1=1 "
            CALL s_control_get_doc_sql("oocq002",g_sfdadocno,'8')
               RETURNING l_success,l_where    #num5和STRING类型
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ",l_where
            END IF
            #关于控制组--end
            CALL q_oocq002_5()
            LET g_sfdc_d[l_ac].sfdc015 = g_qryparam.return1     #將開窗取得的值回傳到變數
            DISPLAY g_sfdc_d[l_ac].sfdc015 TO sfdc015
            NEXT FIELD sfdc015  

         ON ACTION controlp INFIELD sfdc016
            #库存管理特征
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sfdc_d[l_ac].sfdc012
            LET g_qryparam.default2 = g_sfdc_d[l_ac].sfdc013
            LET g_qryparam.default3 = g_sfdc_d[l_ac].sfdc014
            LET g_qryparam.default4 = g_sfdc_d[l_ac].sfdc016
            #mod 141118 q_inag004_13修改成传参方式
            #LET g_qryparam.where = " inag001 ='",g_sfdc_d[l_ac].sfdc004,"'"
            LET g_qryparam.arg1 = g_sfdc_d[l_ac].sfdc004
            IF cl_null(g_sfdc_d[l_ac].sfdc005) THEN
               LET g_qryparam.arg2 = ' '
            ELSE
               LET g_qryparam.arg2 = g_sfdc_d[l_ac].sfdc005
            END IF
            #已有指定不可输入
            LET g_qryparam.where = "1=1 "
            #add 150107
            LET l_sfba019=''
            LET l_sfba020=''
            LET l_sfba029=''
            LET l_sfba030=''
            SELECT sfba019,sfba020,sfba029,sfba030
              INTO l_sfba019,l_sfba020,l_sfba029,l_sfba030
              FROM sfba_t
             WHERE sfbaent  = g_enterprise
               AND sfbadocno= g_sfdc_d[l_ac].sfdc001
               AND sfbaseq  = g_sfdc_d[l_ac].sfdc002
               AND sfbaseq1 = g_sfdc_d[l_ac].sfdc003
            #add 150107 end
            IF g_sfdc012_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  IF NOT cl_null(l_sfba019) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",l_sfba019,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag004 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag004 = '",g_sfdc_d[l_ac].sfdc012,"' "
               END IF
            END IF
            IF g_sfdc013_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  IF NOT cl_null(l_sfba020) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",l_sfba020,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag005 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag005 = '",g_sfdc_d[l_ac].sfdc013,"' "
               END IF
            END IF
            IF g_sfdc014_switch = 'N' THEN
               IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN
                  #mod 150107
                  #LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  IF NOT cl_null(l_sfba029) THEN
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",l_sfba029,"' "
                  ELSE
                     LET g_qryparam.where = g_qryparam.where ," AND inag006 = ' ' "
                  END IF
                  #mod 150107 end
               ELSE
                  LET g_qryparam.where = g_qryparam.where ," AND inag006 = '",g_sfdc_d[l_ac].sfdc014,"' "
               END IF
            END IF
            #mod 141118 --end
            #170516-00063#1-s
            #IF g_sfda.sfda002[1,1]='1' THEN #發料單 庫存>0
            #   CALL q_inag004_13()  #库位、储位、批号、库存管理特征
            #ELSE #退料單 不卡控库存
            #   #CALL q_inag004_16()  #库位、储位、批号、库存管理特征 #170110-00005#1 mark
            #   CALL q_inag004_21()                                #170110-00005#1 add
            #END IF
            #CALL q_inag004_21()  #170704-00048#1 mark
            #170516-00063#1-e
            #170704-00048#1-s
            IF g_sfda.sfda002[1,1]='1' THEN  #發料單
               CALL q_inag004_16()
            ELSE                               #退料單
               CALL q_inag004_21()
            END IF
            #170704-00048#1-e
            LET g_sfdc_d[l_ac].sfdc012 = g_qryparam.return1
            LET g_sfdc_d[l_ac].sfdc013 = g_qryparam.return2
            LET g_sfdc_d[l_ac].sfdc014 = g_qryparam.return3
            LET g_sfdc_d[l_ac].sfdc016 = g_qryparam.return4
            DISPLAY g_sfdc_d[l_ac].sfdc012 TO sfdc012
            DISPLAY g_sfdc_d[l_ac].sfdc013 TO sfdc013
            DISPLAY g_sfdc_d[l_ac].sfdc014 TO sfdc014 
            DISPLAY g_sfdc_d[l_ac].sfdc016 TO sfdc016 
            #栏位说明
            CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc013) THEN
               CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc
            END IF
            DISPLAY g_sfdc_d[l_ac].sfdc012_desc TO sfdc012_desc
            DISPLAY g_sfdc_d[l_ac].sfdc013_desc TO sfdc013_desc
            NEXT FIELD sfdc016


         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_sfdc_d[l_ac].* = g_sfdc_d_t.*
               NEXT FIELD imaa001
            END IF

            #寫入修改者/修改日期資訊(單身)
            IF cl_null(g_sfdc_d[l_ac].sfdc012) THEN LET g_sfdc_d[l_ac].sfdc012 = ' ' END IF
            IF cl_null(g_sfdc_d[l_ac].sfdc013) THEN LET g_sfdc_d[l_ac].sfdc013 = ' ' END IF
            IF cl_null(g_sfdc_d[l_ac].sfdc014) THEN LET g_sfdc_d[l_ac].sfdc014 = ' ' END IF
            IF cl_null(g_sfdc_d[l_ac].sfdc016) THEN LET g_sfdc_d[l_ac].sfdc016 = ' ' END IF
            IF cl_null(g_sfdc_d[l_ac].sfdc010) THEN LET g_sfdc_d[l_ac].sfdc010 = 0 END IF #参考单位需求数量
            #150115 add 单位取位
            CALL s_aooi250_get_msg(g_sfdc_d[l_ac].sfdc006) RETURNING l_success,g_ooca002,g_ooca004
            IF l_success THEN
               CALL s_num_round('4',g_sfdc_d[l_ac].sfdc007,g_ooca002) RETURNING g_sfdc_d[l_ac].sfdc007  #151118-00016 by whitney modify g_ooca004-->'4'
            END IF
            IF NOT cl_null(g_sfdc_d[l_ac].sfdc009) THEN
               CALL s_aooi250_get_msg(g_sfdc_d[l_ac].sfdc009) RETURNING l_success,g_ooca002,g_ooca004
               IF l_success THEN
                  CALL s_num_round('4',g_sfdc_d[l_ac].sfdc010,g_ooca002) RETURNING g_sfdc_d[l_ac].sfdc010  #151118-00016 by whitney modify g_ooca004-->'4'
               END IF
            END IF
            #150115 add end
            UPDATE asft310_01_sfdc_t SET (sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,sfdc007,sfdc009,sfdc010,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016)
                                       = (g_sfdc_d[l_ac].sfdcseq,g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002,g_sfdc_d[l_ac].sfdc003,g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc007,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc010,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,g_sfdc_d[l_ac].sfdc015,g_sfdc_d[l_ac].sfdc016)
             WHERE sfdcent = g_enterprise
               AND sfdcdocno = g_sfdadocno
               AND sfdcseq = g_sfdc_d_t.sfdcseq #項次
            CASE
               WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "std-00009"
                  LET g_errparam.extend = "asft310_01_sfdc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfdc_d[l_ac].* = g_sfdc_d_t.*
               WHEN SQLCA.sqlcode #其他錯誤
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "asft310_01_sfdc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_sfdc_d[l_ac].* = g_sfdc_d_t.*
               OTHERWISE

            END CASE


         AFTER ROW


         AFTER INPUT


      END INPUT

      BEFORE DIALOG
         NEXT FIELD imaa001

      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION qbe_select     #條件查詢
         #CALL cl_qbe_list() RETURNING lc_qbe_sn
         #CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION qbe_save       #條件儲存
         #CALL cl_qbe_save()
         
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG

   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
END FUNCTION

PRIVATE FUNCTION asft310_01_set_entry()
   CALL cl_set_comp_entry("inag005_i,inag006_i",TRUE)
END FUNCTION
#预设sfdc007申请数量
#即最大可发料数量
PRIVATE FUNCTION asft310_01_def_sfdc007(p_cmd)
DEFINE p_cmd         LIKE type_t.chr1
DEFINE r_sfdc007     LIKE sfdc_t.sfdc007   #最大可发料数量
DEFINE l_sfaa012     LIKE sfaa_t.sfaa012   #生产数量
DEFINE l_sfaa049     LIKE sfaa_t.sfaa049   #已发套数
DEFINE l_sfdb006     LIKE sfdb_t.sfdb006   #工单+部位+作业+作业序 预计发料套数
DEFINE l_sfdc007     LIKE sfdc_t.sfdc007   #本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
DEFINE l_sfba010     LIKE sfba_t.sfba010   #标准QPA分子
DEFINE l_sfba011     LIKE sfba_t.sfba011   #标准QPA分母
DEFINE l_sfba002     LIKE sfba_t.sfba002   #部位
DEFINE l_sfba003     LIKE sfba_t.sfba003   #作业
DEFINE l_sfba004     LIKE sfba_t.sfba004   #作业序
DEFINE l_sfba013     LIKE sfba_t.sfba013   #应发总数量
DEFINE l_sfba016     LIKE sfba_t.sfba016   #已发数量
#160726-00001#6-s
DEFINE l_sfba026    LIKE sfba_t.sfba026    #SET替代狀態
DEFINE l_sfba035    LIKE sfba_t.sfba035    #SET替代套數
DEFINE l_sfba036    LIKE sfba_t.sfba036    #SET已替代套數
#160726-00001#6-e
#170329-00100#1 add --(S)--
DEFINE l_sfba027    LIKE sfba_t.sfba027    #SET替代群組    
DEFINE l_sfba034    LIKE sfba_t.sfba034    #SET被替代群組   
DEFINE l_sets       LIKE sfaa_t.sfaa049
#170329-00100#1 add --(E)--

   LET r_sfdc007 = 0
   
   IF g_sfda.sfda002 ='11' OR g_sfda.sfda002 ='13' THEN 
      #生产数量、已发套数、标准QPA分子、标准QPA分母
      #部位、作业、作业序
      SELECT sfaa012,sfaa049,sfba010,sfba011,sfba002,
             sfba003,sfba004,sfba013,sfba016
            ,sfba026,sfba035,sfba036,sfba027,sfba034  #160726-00001#6  #170329-00100#1 add sfba027,sfba034
        INTO l_sfaa012,l_sfaa049,l_sfba010,l_sfba011,l_sfba002,
             l_sfba003,l_sfba004,l_sfba013,l_sfba016
            ,l_sfba026,l_sfba035,l_sfba036,l_sfba027,l_sfba034  #160726-00001#6  #170329-00100#1 add sfba027,sfba034
        FROM sfba_t,sfaa_t
       WHERE sfbaent = sfaaent
         AND sfbadocno=sfaadocno
         AND sfbaent = g_enterprise
         AND sfbadocno=g_sfdc_d[l_ac].sfdc001
         AND sfbaseq = g_sfdc_d[l_ac].sfdc002
         AND sfbaseq1= g_sfdc_d[l_ac].sfdc003
      IF cl_null(l_sfaa012) THEN LET l_sfaa012 = 0 END IF
      IF cl_null(l_sfaa049) THEN LET l_sfaa049 = 0 END IF
      IF cl_null(l_sfba002) THEN LET l_sfba002 = ' ' END IF   #部位
      IF cl_null(l_sfba003) THEN LET l_sfba003 = ' ' END IF   #作业
      
      #本发料单据其他项次的:本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
      CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007
      
      IF g_sfda.sfda002 ='11' THEN
         #預計發料套數
         SELECT SUM(sfdb006) INTO l_sfdb006 FROM sfdb_t
          WHERE sfdbent  = g_enterprise
            AND sfdbdocno= g_sfdadocno       #发料单单号
            AND sfdb001  = g_sfdc_d[l_ac].sfdc001  #工单单号
            AND sfdb003  = l_sfba002  #部位
            AND sfdb004  = l_sfba003  #作业
            AND sfdb005  = l_sfba004  #作业序
            #AND sfdb002  = #run card 
         IF cl_null(l_sfdb006) THEN LET l_sfdb006=0 END IF
      END IF
   END IF
   
   #160726-00001#6-s
   IF l_sfba026 <> '1' THEN
      LET l_sfaa012 = l_sfba035
      LET l_sfaa049 = l_sfba036
      #170329-00100#1 add --(S)--
      #計算本群組已發套數
      LET l_sets = 0
      SELECT SUM(MIN(sfba035-COALESCE(sfba036,0))) INTO l_sets
        FROM sfba_t
       WHERE sfbaent = g_enterprise AND sfbadocno = g_sfdc_d[l_ac].sfdc001
         AND sfbaseq < g_sfdc_d[l_ac].sfdc002 AND sfba034 = l_sfba034
         AND sfba027 <> l_sfba027 GROUP BY sfba027
      IF cl_null(l_sets) THEN LET l_sets = 0 END IF
      IF l_sfdb006 - l_sets > l_sfba035 - l_sfba036 THEN
         LET l_sfdb006 = l_sfba035 - l_sfba036
      ELSE
         LET l_sfdb006 = l_sfdb006 - l_sets      
      END IF
      #170329-00100#1 add --(E)--
     #170329-00100#1 mark --(S)--
     #IF l_sfdb006 > l_sfba035 THEN
     #   LET l_sfdb006 = l_sfba035
     #END IF
     #170329-00100#1 mark --(E)--
   END IF
   #160726-00001#6-e
   CASE
      WHEN g_sfda.sfda002 ='11'   #成套发料
           IF l_sfdb006 = l_sfaa012 - l_sfaa049 THEN  #預計發料套數=生產數量-已發套數  要把调整的应发数量都算进去
              #應發總數量-已發數量-本发料单据其他项次的发料数量  
              LET r_sfdc007 = l_sfba013 - l_sfba016 - l_sfdc007
           ELSE
              #預計發料套數*標準QPA分子/標準QPA分母-本发料单据其他项次的发料数量
              LET r_sfdc007 = l_sfdb006 * l_sfba010 / l_sfba011 - l_sfdc007
           END IF
      WHEN g_sfda.sfda002 ='13'   #欠料补料
           IF l_sfaa012 = l_sfaa049 THEN   #生產數量=已發套數
              #應發總數量-已發數量-本发料单据其他项次的发料数量  要把调整的应发数量都算进去
              LET r_sfdc007 = l_sfba013 - l_sfba016 - l_sfdc007
           ELSE
              #(已發料套數*標準QPA分子/標準QPA分母)-已發數量-本发料单据其他项次的发料数量
              LET r_sfdc007 = l_sfaa049 * l_sfba010 / l_sfba011 - l_sfba016 - l_sfdc007
           END IF
      WHEN g_sfda.sfda002 = '21'  #成套退
           IF l_sfdb006 = l_sfaa049 THEN  #預計退料套數=已發套數  全退
              #已發數量-本发料单据其他项次的发料数量  
              LET r_sfdc007 = l_sfba016 - l_sfdc007
           ELSE
              #預計退料套數*標準QPA分子/標準QPA分母-本发料单据其他项次的发料数量
              LET r_sfdc007 = l_sfdb006 * l_sfba010 / l_sfba011 - l_sfdc007
              #不可超过工单的已发数量
              IF r_sfdc007 > l_sfba016 - l_sfdc007 THEN
                 LET r_sfdc007 = l_sfba016 - l_sfdc007
              END IF
           END IF
      OTHERWISE
           LET r_sfdc007 = 0
   END CASE
   IF r_sfdc007 < 0 THEN
      LET r_sfdc007 = 0
   END IF
   
   #add 150115 单位取位
   IF NOT cl_null(g_sfdc_d[l_ac].sfdc006) THEN
      CALL s_aooi250_get_msg(g_sfdc_d[l_ac].sfdc006) RETURNING l_success,g_ooca002,g_ooca004
      IF l_success THEN
         CALL s_num_round('4',r_sfdc007,g_ooca002) RETURNING r_sfdc007  #151118-00016 by whitney modify g_ooca004-->'4'
      END IF
   END IF
   #add 150115 end
   RETURN r_sfdc007
END FUNCTION

PRIVATE FUNCTION asft310_01_set_no_entry()
   
   IF cl_null(tm2.inag004_i) THEN
      CALL cl_set_comp_entry("inag005_i,inag006_i",FALSE)
   END IF
   IF cl_null(tm2.inag005_i) THEN
      CALL cl_set_comp_entry("inag006_i",FALSE)
   END IF

END FUNCTION
################################################################################
# Descriptions...: 检查申请数量——对工单可发可退数量的检查
# Memo...........:
# Usage..........: CALL asft310_01_chk_sfdc007(p_cmd)
#                  RETURNING r_success
# Input parameter: p_cmd       a:新增  u:修改
# Return code....: r_success   检查状态TRUE/FALSE
# Date & Author..: 2013/12/19 By zhangllc
# Modify.........: 150309 增加欠料补料的检查，逻辑需与自动产生同步，以防自动产生的资料还过不去
################################################################################
PRIVATE FUNCTION asft310_01_chk_sfdc007(p_cmd)
DEFINE p_cmd            LIKE type_t.chr1
DEFINE r_success        LIKE type_t.num5
DEFINE l_sfdc007        LIKE sfdc_t.sfdc007   #本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
DEFINE l_sfdc007_1      LIKE sfdc_t.sfdc007 
DEFINE l_sfdc007_2      LIKE sfdc_t.sfdc007 
DEFINE l_success        LIKE type_t.num5
#161109-00085#30-s
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
#DEFINE l_sfba_0     RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq LIKE sfba_t.sfbaseq, #項次
       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
       sfba002 LIKE sfba_t.sfba002, #部位
       sfba003 LIKE sfba_t.sfba003, #作業編號
       sfba004 LIKE sfba_t.sfba004, #作業序
       sfba006 LIKE sfba_t.sfba006, #發料料號
       sfba008 LIKE sfba_t.sfba008, #必要特性
       sfba013 LIKE sfba_t.sfba013, #應發數量
       sfba014 LIKE sfba_t.sfba014, #單位
       sfba015 LIKE sfba_t.sfba015, #委外代買數量
       sfba016 LIKE sfba_t.sfba016, #已發數量
       sfba017 LIKE sfba_t.sfba017, #報廢數量
       sfba022 LIKE sfba_t.sfba022, #替代率
       sfba023 LIKE sfba_t.sfba023, #標準應發數量
       sfba025 LIKE sfba_t.sfba025  #超領數量
END RECORD
DEFINE l_sfba_0 RECORD  #工單備料單身檔
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
       sfba024 LIKE sfba_t.sfba024  #調整應發數量
END RECORD
#161109-00085#30-e

DEFINE l_sfba016        LIKE sfba_t.sfba016    #已发数量
DEFINE l_sfaa049         LIKE sfaa_t.sfaa049   #已发套数 add 150309
DEFINE l_sfaa012         LIKE sfaa_t.sfaa012   #生产数量 add 150309
DEFINE l_sets            LIKE sfaa_t.sfaa049   #add 150309
DEFINE l_sfba022         LIKE sfba_t.sfba022   #旧值的  替代率
DEFINE l_sfdb006         LIKE sfdb_t.sfdb006   #预计套数
DEFINE l_sfdb001         LIKE sfdb_t.sfdb001   #160309-00006#1 add  工單單號
DEFINE l_sfdb006_1       LIKE sfdb_t.sfdb006   #160309-00006#1 add  预计套数
DEFINE l_sfaa012_1       LIKE sfaa_t.sfaa012   #160309-00006#1 add

   LET r_success = TRUE

   #161109-00085#30-s
   #SELECT * INTO l_sfba.*
   SELECT sfbadocno,sfbaseq,sfbaseq1,sfba002,sfba003,sfba004,sfba006,sfba008,sfba013,sfba014,
          sfba015,sfba016,sfba017,sfba022,sfba023,sfba025
     INTO l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba002,l_sfba.sfba003,
          l_sfba.sfba004,l_sfba.sfba006,l_sfba.sfba008,l_sfba.sfba013,l_sfba.sfba014,
          l_sfba.sfba015,l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba022,l_sfba.sfba023,
          l_sfba.sfba025
   #161109-00085#30-e
     FROM sfba_t
    WHERE sfbaent = g_enterprise
      AND sfbasite= g_site
      AND sfbadocno=g_sfdc_d[l_ac].sfdc001
      AND sfbaseq = g_sfdc_d[l_ac].sfdc002
      AND sfbaseq1= g_sfdc_d[l_ac].sfdc003
   #间接材料,发料时可直接超领，过账时分配，所以不需要控管是否超过工单的未发数量
   #IF l_sfba.sfba008 = '3' THEN  #必要特性
   IF l_sfba.sfba008 = '3' AND g_sfda.sfda002 = '12' THEN #mod 150309
      RETURN r_success
   END IF
   
   CASE 
      WHEN g_sfda.sfda002 = '11' OR g_sfda.sfda002 = '13'   #发料类型=成套发料 or 欠料补料
           #不可超過工單的未發數量
           
           #本发料单据其他项次的:本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
           CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007
           
           #其他单据发料未过账申请数
           SELECT SUM(sfdc007) INTO l_sfdc007_1
             FROM sfdc_t,sfda_t
            WHERE sfdcent   = sfdaent
              AND sfdcdocno = sfdadocno
              AND sfdcent   = g_enterprise
              AND sfdcdocno!= g_sfdadocno
              AND sfdc001   = g_sfdc_d[l_ac].sfdc001  #工单
              AND sfdc002   = g_sfdc_d[l_ac].sfdc002  #工单项次
              AND sfdc003   = g_sfdc_d[l_ac].sfdc003  #工单项序
              AND sfda002 IN ('11','13','14') #发料
              AND sfdastus != 'S' AND sfdastus != 'X'
           IF cl_null(l_sfdc007_1) THEN LET l_sfdc007_1 = 0 END IF

           ##其他单据退料未过账申请数
           #SELECT SUM(sfdc007) INTO l_sfdc007_2
           #  FROM sfdc_t,sfda_t
           # WHERE sfdcent   = sfdaent
           #   AND sfdcdocno = sfdadocno
           #   AND sfdcent   = g_enterprise
           #   AND sfdcdocno!= g_sfdadocno
           #   AND sfdc001   = g_sfdc_d[l_ac].sfdc001  #工单
           #   AND sfdc002   = g_sfdc_d[l_ac].sfdc002  #工单项次
           #   AND sfdc003   = g_sfdc_d[l_ac].sfdc003  #工单项序
           #   AND sfda002 IN ('21','23','24') #退料
           #   AND sfdastus != 'S' AND sfdastus != 'X'
           #IF cl_null(l_sfdc007_2) THEN LET l_sfdc007_2 = 0 END IF
           #mark 退料不算，一退料未过账不应算，二若退料删除，这边就多了
 
           #可发数量
           LET l_sfdc007 = l_sfba.sfba013 - l_sfba.sfba015 - l_sfba.sfba016 - l_sfdc007 - l_sfdc007_1 #+ l_sfdc007_2
           IF g_sfdc_d[l_ac].sfdc007  > l_sfdc007 THEN
              #不可超过工单的未发数量1%,请重新输入！
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00047'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_sfdc007
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #150309 add 同自动产生的逻辑
           #替代料,抓出原件资料
           #161109-00085#30-s
           #SELECT * INTO l_sfba_0.* FROM sfba_t
           SELECT sfba010,sfba011,sfba024 INTO l_sfba_0.sfba010,l_sfba_0.sfba011,l_sfba_0.sfba024
             FROM sfba_t
           #161109-00085#30-e
            WHERE sfbaent = g_enterprise
              AND sfbasite= g_site
              AND sfbadocno=g_sfdc_d[l_ac].sfdc001
              AND sfbaseq = g_sfdc_d[l_ac].sfdc002
              AND sfbaseq1= 0
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = FALSE
              RETURN r_success
           END IF
           #计算套数
           CALL s_asft310_get_sfdb006_2(g_sfdadocno,l_sfba.sfbadocno,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004)
              RETURNING l_success,l_sfdb006
           IF NOT l_success THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           #已发套数，生产数量
           SELECT sfaa049,sfaa012 INTO l_sfaa049,l_sfaa012
             FROM sfaa_t
            WHERE sfaaent  = g_enterprise
              AND sfaadocno= g_sfdc_d[l_ac].sfdc001
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET g_success = FALSE
              RETURN r_success
           END IF
           #欠料补料只可发不足套的量
           IF g_sfda.sfda002 = '13' OR (g_sfda.sfda002 = '11' AND l_sfdb006 = 0) THEN
              #同自动产生的逻辑，计算欠料量issue_qty
              #工单单身某笔总共应发=应发-扣除委外代買量
              LET l_sfba.sfba013=l_sfba.sfba013-l_sfba.sfba015
              #欠料补料把已发套数中不足的部分补发出去
#              IF l_sfaa049 = l_sfaa012 THEN  #已發套數=生產數量,即要把剩余                 #160706-00027#1-mod-(S)
              IF l_sfaa049 = l_sfaa012 OR g_para1 = 'N' THEN  #已發套數=生產數量,即要把剩余 #160706-00027#1-mod-(E)
                 #计算发料单上已产生的发料数量
                 CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007
                 #计算剩下的应发量=應發總數量-已發數量-本发料单上已产生的发料量
                 LET issue_qty = l_sfba.sfba013 - l_sfba.sfba016 - l_sfdc007
              ELSE
                 #LET issue_qty = l_sfaa049 * l_sfba.sfba010 / l_sfba.sfba011 - l_sfba.sfba016
                 #考虑可能有取替代料的情况
                 #计算备料+本单据上所有已发量(包含元件+所有替代料的已发量),折算成元件的已发量
                 CALL asft310_01_get_sfba016('2',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002) RETURNING l_sfba016
                 IF p_cmd='u' AND g_sfdc_d[l_ac].sfdc001=g_sfdc_d_t.sfdc001 AND g_sfdc_d[l_ac].sfdc002=g_sfdc_d_t.sfdc002 THEN
                    IF g_sfdc_d_t.sfdc003 = 0 THEN  #项序
                       LET l_sfba016 = l_sfba016 - g_sfdc_d_t.sfdc007
                    ELSE
                       SELECT sfba022 INTO l_sfba022 FROM sfba_t
                        WHERE sfbaent   = g_enterprise
                          AND sfbasite  = g_site
                          AND sfbadocno = g_sfdc_d_t.sfdc001
                          AND sfbaseq   = g_sfdc_d_t.sfdc002
                          AND sfbaseq1  = g_sfdc_d_t.sfdc003
                       LET l_sfba016 = l_sfba016 - g_sfdc_d_t.sfdc007/l_sfba022
                    END IF
                 END IF
                 #根据已发量计算该料已发套数
                 LET l_sets = l_sfba016 * l_sfba_0.sfba011 / l_sfba_0.sfba010
                 
                 IF l_sfba.sfbaseq1 = 0 THEN  #非替代料 不足套数*QPA分子/QPA分母
                    LET issue_qty = (l_sfaa049 - l_sets) * l_sfba_0.sfba010 / l_sfba_0.sfba011
                 ELSE  #替代料  不足套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
                    LET issue_qty = ((l_sfaa049 - l_sets) * l_sfba_0.sfba010 / l_sfba_0.sfba011)*l_sfba.sfba022
                 END IF
              END IF  

              IF issue_qty < 0 THEN
                 LET issue_qty = 0
              END IF
              
              #单位取位
              CALL s_aooi250_get_msg(l_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
              IF l_success THEN
                 CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
              END IF
              
              #发料时的應發量 > 应发 - 已发
              IF issue_qty>(l_sfba.sfba013-l_sfba.sfba016) THEN
                 LET issue_qty=(l_sfba.sfba013-l_sfba.sfba016)
              END IF
              
              IF g_sfdc_d[l_ac].sfdc007  > issue_qty THEN
                 #不可超过欠料量%1
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00676'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = issue_qty
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF  #欠料补料
           
           #成套只可发套数的量
           #161205-00025#6-s
           #LET g_para = cl_get_para(g_enterprise,g_site,'S-MFG-0055') #发料控管套数否
           #IF g_sfda.sfda002 = '11' AND l_sfdb006 > 0 AND g_para='Y' THEN  #成套发&发料控管套数否='Y'
           IF g_sfda.sfda002 = '11' AND l_sfdb006 > 0 AND g_para1='Y' THEN
           #161205-00025#6-e
              #工单单身某笔总共应发=应发-扣除委外代買量
              LET l_sfba.sfba013=l_sfba.sfba013-l_sfba.sfba015
              #欠料补料把已发套数中不足的部分补发出去
              IF l_sfdb006 = l_sfaa012 - l_sfaa049 THEN  #預計發料套數=生產數量-已發套數,即要把剩余 
                 #计算发料单上已产生的发料数量
                 CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007
                 #计算剩下的应发量=應發總數量-已發數量-本发料单上已产生的发料量
                 LET issue_qty = l_sfba.sfba013 - l_sfba.sfba016 - l_sfdc007
              ELSE
                 #LET issue_qty = l_sfaa049 * l_sfba.sfba010 / l_sfba.sfba011 - l_sfba.sfba016
                 #考虑可能有取替代料的情况
                 #计算本单据上已发量(包含元件+所有替代料的已发量)(不包括备料档),折算成元件的已发量
                 CALL asft310_01_get_sfba016('1',g_sfdc_d[l_ac].sfdc001,g_sfdc_d[l_ac].sfdc002) RETURNING l_sfba016
                 IF p_cmd='u' AND g_sfdc_d[l_ac].sfdc001=g_sfdc_d_t.sfdc001 AND g_sfdc_d[l_ac].sfdc002=g_sfdc_d_t.sfdc002 THEN
                    IF g_sfdc_d_t.sfdc003 = 0 THEN  #项序
                       LET l_sfba016 = l_sfba016 - g_sfdc_d_t.sfdc007
                    ELSE
                       SELECT sfba022 INTO l_sfba022 FROM sfba_t
                        WHERE sfbaent   = g_enterprise
                          AND sfbasite  = g_site
                          AND sfbadocno = g_sfdc_d_t.sfdc001
                          AND sfbaseq   = g_sfdc_d_t.sfdc002
                          AND sfbaseq1  = g_sfdc_d_t.sfdc003
                       LET l_sfba016 = l_sfba016 - g_sfdc_d_t.sfdc007/l_sfba022
                    END IF
                 END IF
                 #根据已发量计算该料已发套数
                 LET l_sets = l_sfba016 * l_sfba_0.sfba011 / l_sfba_0.sfba010
                 
                 IF l_sfba.sfbaseq1 = 0 THEN  #非替代料 不足套数*QPA分子/QPA分母
                    LET issue_qty = (l_sfdb006 - l_sets) * l_sfba_0.sfba010 / l_sfba_0.sfba011
                    #160309-00006#1  By Ann_Huang  --- add Start ---
                    IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN
                        LET issue_qty = issue_qty + l_sfba_0.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
                    END IF
                    #160309-00006#1  By Ann_Huang  --- add End ---
                 ELSE  #替代料  不足套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
                    LET issue_qty = ((l_sfdb006 - l_sets) * l_sfba_0.sfba010 / l_sfba_0.sfba011)*l_sfba.sfba022
                    #160309-00006#1  By Ann_Huang  --- add Start ---
                    IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN
                        LET issue_qty = issue_qty + l_sfba_0.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
                    END IF
                    #160309-00006#1  By Ann_Huang  --- add End ---
                 END IF
              END IF  
           
              IF issue_qty < 0 THEN
                 LET issue_qty = 0
              END IF
              
              #单位取位
              CALL s_aooi250_get_msg(l_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
              IF l_success THEN
                 CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
              END IF
              
              #发料时的應發量 > 应发 - 已发
              IF issue_qty>(l_sfba.sfba013-l_sfba.sfba016) THEN
                 LET issue_qty=(l_sfba.sfba013-l_sfba.sfba016)
              END IF
              
              IF g_sfdc_d[l_ac].sfdc007  > issue_qty THEN
                 #不可超过欠料量%1
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00676'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = issue_qty
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           #150309 add end
      WHEN g_sfda.sfda002 = '12'  #发料类型=超领
           #依發料單別參數"超領數量與下階料報廢數量勾稽"，
           #當此參數=Y時，申請數量需判斷數量不可超過(下階料報廢數量-已存在超領數量+超領退料數量)
           CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
           IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0056') = 'Y' THEN
              IF cl_null(l_sfba.sfba017) THEN LET l_sfba.sfba017=0 END IF #下阶报废数量
              IF cl_null(l_sfba.sfba025) THEN LET l_sfba.sfba025=0 END IF #超领数量
              
              #本发料单据其他项次的
              CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007

              #其他单据发料未过账申请数
              SELECT SUM(sfdc007) INTO l_sfdc007_1
                FROM sfdc_t,sfda_t
               WHERE sfdcent   = sfdaent
                 AND sfdcdocno = sfdadocno
                 AND sfdcent   = g_enterprise
                 AND sfdcdocno!=g_sfdadocno
                 AND sfdc001   = g_sfdc_d[l_ac].sfdc001  #工单
                 AND sfdc002   = g_sfdc_d[l_ac].sfdc002  #工单项次
                 AND sfdc003   = g_sfdc_d[l_ac].sfdc003  #工单项序
                 AND sfda002 = '12'  #发料
                 AND sfdastus != 'S' AND sfdastus != 'X'
              IF cl_null(l_sfdc007_1) THEN LET l_sfdc007_1 = 0 END IF

              ##其他单据退料未过账申请数
              #SELECT SUM(sfdc007) INTO l_sfdc007_2
              #  FROM sfdc_t,sfda_t
              # WHERE sfdcent   = sfdaent
              #   AND sfdcdocno = sfdadocno
              #   AND sfdcent   = g_enterprise
              #   AND sfdcdocno!=g_sfdadocno
              #   AND sfdc001   = g_sfdc_d[l_ac].sfdc001  #工单
              #   AND sfdc002   = g_sfdc_d[l_ac].sfdc002  #工单项次
              #   AND sfdc003   = g_sfdc_d[l_ac].sfdc003  #工单项序
              #   AND sfda002 = '22'  #退料
              #   AND sfdastus != 'S' AND sfdastus != 'X'
              #IF cl_null(l_sfdc007_2) THEN LET l_sfdc007_2 = 0 END IF

              #可发料的量
              #LET l_sfdc007 = l_sfba.sfba017-l_sfba.sfba025-l_sfdc007-l_sfdc007_1+l_sfdc007_2  #相当于=下階料報廢數量-已存在超領數量+超領退料數量
              #mark 退料不算，一退料未过账不应算，二若退料删除，这边就多了
              LET l_sfdc007 = l_sfba.sfba017-l_sfba.sfba025-l_sfdc007-l_sfdc007_1  #相当于=下階料報廢數量-已存在超領數量
              IF g_sfdc_d[l_ac].sfdc007  > l_sfdc007 THEN  
                 #不可超过工单的下阶料报废数量1%；请重新输入！
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00138'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 LET g_errparam.replace[1] = l_sfdc007
                 CALL cl_err()
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
      WHEN g_sfda.sfda002 = '21'    #成套退
           #不可超過工單的已發數量l_sfba.sfba016
           
           #本发料单据其他项次的:本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
           CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007
           
           #可退数量
           LET l_sfdc007 = l_sfba.sfba016 - l_sfdc007
           IF g_sfdc_d[l_ac].sfdc007  > l_sfdc007 THEN  
              #不可超过工单的已發数量1%,请重新输入！
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00065'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_sfdc007
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN g_sfda.sfda002 = '22'  #发料类型=超领
           #不可超過工單的超領數量l_sfba.sfba025
           IF cl_null(l_sfba.sfba025) THEN LET l_sfba.sfba025=0 END IF
           #本发料单据其他项次的
           CALL asft310_01_get_sfdc007(p_cmd) RETURNING l_sfdc007

           #可超退数量
           LET l_sfdc007 = l_sfba.sfba025 - l_sfdc007
           IF g_sfdc_d[l_ac].sfdc007  > l_sfdc007 THEN  
              #不可超过工单的超领数量1%,请重新输入！
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'asf-00066'
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              LET g_errparam.replace[1] = l_sfdc007
              CALL cl_err()
              LET r_success = FALSE
              RETURN r_success
           END IF
   END CASE
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 获取本单据中工单+项次+项序在其他项次的需求申请数量
# Memo...........: 本发料单据其他项次的:本画面其他项次的发料数量asft310_01_sfdc_t+本发料单据上的发料数量sfdc_t
# Usage..........: CALL asft310_01_get_sfdc007(p_cmd)
#                  RETURNING r_sfdc007
# Input parameter: p_cmd       a:新增  u:修改
# Return code....: r_sfdc007   需求申请数量
# Date & Author..: 2013/12/19 By zhangllc
# Modify.........:
################################################################################
PRIVATE FUNCTION asft310_01_get_sfdc007(p_cmd)
DEFINE p_cmd       LIKE type_t.chr1     #a:新增 u:修改
DEFINE l_sfdc007   LIKE sfdc_t.sfdc007  #需求申请数量
DEFINE r_sfdc007   LIKE sfdc_t.sfdc007  #需求申请数量

   LET r_sfdc007 = 0
   
   #本画面其他项次的发料数量asft310_01_sfdc_t
   IF p_cmd = 'u' THEN
      SELECT SUM(sfdc007) INTO l_sfdc007 FROM asft310_01_sfdc_t
       WHERE sfdcent = g_enterprise
         AND sfdcdocno=g_sfdadocno       #发料单单号
         AND sfdcseq != g_sfdc_d_t.sfdcseq
         AND sfdc001 = g_sfdc_d[l_ac].sfdc001  #工单
         AND sfdc002 = g_sfdc_d[l_ac].sfdc002  #工单项次
         AND sfdc003 = g_sfdc_d[l_ac].sfdc003  #工单项序
   ELSE
      SELECT SUM(sfdc007) INTO l_sfdc007 FROM asft310_01_sfdc_t
       WHERE sfdcent = g_enterprise
         AND sfdcdocno=g_sfdadocno       #发料单单号
         AND sfdc001 = g_sfdc_d[l_ac].sfdc001  #工单
         AND sfdc002 = g_sfdc_d[l_ac].sfdc002  #工单项次
         AND sfdc003 = g_sfdc_d[l_ac].sfdc003  #工单项序
   END IF
   IF cl_null(l_sfdc007) THEN LET l_sfdc007 = 0 END IF
   LET r_sfdc007 = r_sfdc007 + l_sfdc007
   
   #本发料单据上的发料数量sfdc_t
   SELECT SUM(sfdc007) INTO l_sfdc007 FROM sfdc_t
    WHERE sfdcent = g_enterprise
      AND sfdcdocno=g_sfdadocno       #发料单单号
      AND sfdc001 = g_sfdc_d[l_ac].sfdc001  #工单
      AND sfdc002 = g_sfdc_d[l_ac].sfdc002  #工单项次
      AND sfdc003 = g_sfdc_d[l_ac].sfdc003  #工单项序
   IF cl_null(l_sfdc007) THEN LET l_sfdc007 = 0 END IF
   LET r_sfdc007 = r_sfdc007 + l_sfdc007
   
   RETURN r_sfdc007
END FUNCTION
#根据工单+项次+项序预设资料
PRIVATE FUNCTION asft310_01_sfdc003_reference(p_cmd)
DEFINE p_cmd            LIKE type_t.chr1     #a:新增 u:修改
DEFINE r_success        LIKE type_t.num5
#DEFINE l_sfaa010        LIKE sfaa_t.sfaa010  #生产料号
DEFINE l_success        LIKE type_t.num5
DEFINE l_rate           LIKE inaj_t.inaj014  #单位换算率
DEFINE l_sfba008        LIKE sfba_t.sfba008  #必要性
DEFINE l_sfba025        LIKE sfba_t.sfba025  #超领量
DEFINE l_where          STRING
DEFINE l_flag2          LIKE type_t.num5   #s_control使用
DEFINE l_imaa005        LIKE imaa_t.imaa005  #产品特征
#DEFINE l_imae101        LIKE imae_t.imae101  #预设发料库位
#DEFINE l_imae102        LIKE imae_t.imae102  #预设发料储位
#DEFINE l_imae103        LIKE imae_t.imae103  #预设退料库位
#DEFINE l_imae104        LIKE imae_t.imae104  #预设退料储位
#mark 给发料前调拨使用的
DEFINE l_imaf091        LIKE imaf_t.imaf091
DEFINE l_imaf092        LIKE imaf_t.imaf092
DEFINE l_imaf055        LIKE imaf_t.imaf055    #160519-00008#18

   LET r_success = TRUE
   
   LET g_sfdc_d[l_ac].sfba002 = ''   #部位
   LET g_sfdc_d[l_ac].sfba002_desc = ''
   LET g_sfdc_d[l_ac].sfba003 = ''   #作业
   LET g_sfdc_d[l_ac].sfba003_desc = ''
   LET g_sfdc_d[l_ac].sfba004 = ''   #作业序
   LET g_sfdc_d[l_ac].sfdc004 = ''   #需求料号
   LET g_sfdc_d[l_ac].sfdc005 = ''   #特征
   LET g_sfdc_d[l_ac].sfba028 = ''   #客供料
   LET g_sfdc_d[l_ac].sfdc006 = ''   #单位
   LET g_sfdc_d[l_ac].sfba013 = 0    #应发料
   LET g_sfdc_d[l_ac].sfba016 = 0    #已发量
   LET g_sfdc_d[l_ac].sfdc012 = ''   #指定库位
   LET g_sfdc_d[l_ac].sfdc013 = ''   #指定储位
   LET g_sfdc_d[l_ac].sfdc014 = ''   #指定批号
   LET g_sfdc_d[l_ac].sfdc016 = ''   #指定库存管理特征
   SELECT sfba002,sfba003,sfba004,sfba006,sfba021,sfba028,sfba014,sfba013,
          sfba016,sfba019,sfba020,sfba029,sfba030,sfba008,sfba025
     INTO g_sfdc_d[l_ac].sfba002,g_sfdc_d[l_ac].sfba003,g_sfdc_d[l_ac].sfba004,g_sfdc_d[l_ac].sfdc004,
          g_sfdc_d[l_ac].sfdc005,g_sfdc_d[l_ac].sfba028,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfba013,
          g_sfdc_d[l_ac].sfba016,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013,g_sfdc_d[l_ac].sfdc014,
          g_sfdc_d[l_ac].sfdc016,l_sfba008,l_sfba025
     FROM sfba_t,sfaa_t
    WHERE sfbaent = sfaaent
      AND sfbadocno=sfaadocno
      AND sfbaent = g_enterprise
      AND sfbadocno=g_sfdc_d[l_ac].sfdc001
      AND sfbaseq = g_sfdc_d[l_ac].sfdc002
      AND sfbaseq1= g_sfdc_d[l_ac].sfdc003
   IF SQLCA.sqlcode THEN
      #工单+项次+项序不存在工单单身档中,请检查工单维护作业asft300中的资料！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00044'
      LET g_errparam.extend = g_sfdc_d[l_ac].sfdc001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #160519-00008#18--(S)
   SELECT imaf055 INTO l_imaf055
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = g_sfdc_d[l_ac].sfdc004
   IF l_imaf055 = '1' AND cl_null(g_sfdc_d[l_ac].sfdc016) THEN
      LET g_sfdc_d[l_ac].sfdc016 = ''
   END IF
   #160519-00008#18--(E)
   IF cl_null(g_sfdc_d[l_ac].sfdc012) AND cl_null(g_sfdc_d[l_ac].sfdc013)THEN  #工单未指定仓储
      #依料號設定的主要倉、儲
      #SELECT imae101,imae102,imae103,imae104
      #  INTO l_imae101,l_imae102,l_imae103,l_imae104
      #  FROM imae_t
      # WHERE imaeent = g_enterprise
      #   AND imaesite= g_site
      #   AND imae001 = g_sfdc_d[l_ac].sfdc004
      #IF g_prog[1,6] = 'asft31' THEN #发料
      #   LET g_sfdc_d[l_ac].sfdc012 = l_imae101
      #   LET g_sfdc_d[l_ac].sfdc013 = l_imae102
      #END IF
      #IF g_prog[1,6] = 'asft32' THEN #退料
      #   LET g_sfdc_d[l_ac].sfdc012 = l_imae103
      #   LET g_sfdc_d[l_ac].sfdc013 = l_imae104
      #END IF
      #mark 给发料前调拨使用的
      SELECT imaf091,imaf092
        INTO l_imaf091,l_imaf092
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite= g_site
         AND imaf001 = g_sfdc_d[l_ac].sfdc004
      LET g_sfdc_d[l_ac].sfdc012 = l_imaf091
      LET g_sfdc_d[l_ac].sfdc013 = l_imaf092
   END IF

   IF l_sfba008 = '4' THEN  #参考材料
      #参考材料不需要发料，请确认！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00310'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #檢核輸入的料件的生命週期是否在單據別限制範圍內
   CALL s_control_chk_doc('4',g_sfdadocno,g_sfdc_d[l_ac].sfdc004,'','','','')
      RETURNING l_success,l_flag2    #处理状态否 存在否     都是num5类型
   IF NOT l_success OR NOT l_flag2 THEN
      #控制组检查错误,请检查单别设定的相关内容
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00122'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #檢核輸入的料件的產品分類是否在單據別限制範圍內
   CALL s_control_chk_doc('5',g_sfdadocno,g_sfdc_d[l_ac].sfdc004,'','','','')
      RETURNING l_success,l_flag2    #处理状态否 存在否     都是num5类型
   IF NOT l_success OR NOT l_flag2 THEN
      #控制组检查错误,请检查单别设定的相关内容
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00122'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF

   #超领退料检查超领量需要大于0的
   IF g_sfda.sfda002='22' AND l_sfba025 = 0 THEN
      #超领数量为0，不可退料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00386'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   #一般退料检查已发数量需要大于0的
   IF g_sfda.sfda002='23' AND g_sfdc_d[l_ac].sfba016 = 0 THEN
      #已发数量为0，不可退料
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00385'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #部位说明
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = '215'
   LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfba002
   CALL cl_ref_val("v_oocql002")
   LET g_sfdc_d[l_ac].sfba002_desc = g_chkparam.return1
   DISPLAY BY NAME g_sfdc_d[l_ac].sfba002_desc

   #作业说明
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = '221'
   LET g_chkparam.arg2 = g_sfdc_d[l_ac].sfba003
   CALL cl_ref_val("v_oocql002")
   LET g_sfdc_d[l_ac].sfba003_desc = g_chkparam.return1
   DISPLAY BY NAME g_sfdc_d[l_ac].sfba003_desc
   
   #需求料号品名规格
   CALL s_desc_get_item_desc(g_sfdc_d[l_ac].sfdc004) RETURNING g_sfdc_d[l_ac].sfdc004_desc,g_sfdc_d[l_ac].sfdc004_desc2
   DISPLAY BY NAME g_sfdc_d[l_ac].sfdc004_desc
   DISPLAY BY NAME g_sfdc_d[l_ac].sfdc004_desc2
   
   ##产品特征
   #SELECT imaa005 INTO l_imaa005 FROM imaa_t
   # WHERE imaaent = g_enterprise
   #   AND imaa001 = g_sfdc_d[l_ac].sfdc004
   #IF cl_null(l_imaa005) THEN  #不做产品特征管理
   #   LET g_sfdc_d[l_ac].sfdc005 = ' '
   #END IF
   #mark 不需要 资料肯定会自动变的，只要工单维护的时候卡控住就好了
   #显示产品特征说明
   CALL s_feature_description(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc005)
      RETURNING l_success,g_sfdc_d[l_ac].sfdc005_desc
   IF NOT l_success THEN
      LET g_sfdc_d[l_ac].sfdc005_desc = ''
   END IF
   DISPLAY BY NAME g_sfdc_d[l_ac].sfdc005_desc

   #单位
   CALL s_desc_get_unit_desc(g_sfdc_d[l_ac].sfdc006) RETURNING g_sfdc_d[l_ac].sfdc006_desc
   DISPLAY BY NAME g_sfdc_d[l_ac].sfdc006_desc
   
   #保税料,参考单位
   SELECT imaf034,imaf015
     INTO g_sfdc_d[l_ac].imaf034,g_sfdc_d[l_ac].sfdc009
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite= g_site
      AND imaf001 = g_sfdc_d[l_ac].sfdc004
   DISPLAY BY NAME g_sfdc_d[l_ac].imaf034
   CALL s_desc_get_unit_desc(g_sfdc_d[l_ac].sfdc009) RETURNING g_sfdc_d[l_ac].sfdc009_desc

   #发料前调拨
   SELECT imae092 INTO g_sfdc_d[l_ac].imae092 FROM imae_t
    WHERE imaeent = g_enterprise
      AND imaesite= g_site
      AND imae001 = g_sfdc_d[l_ac].sfdc004
   DISPLAY BY NAME g_sfdc_d[l_ac].imae092
   
   CALL asft310_01_def_sfdc007(p_cmd) RETURNING g_sfdc_d[l_ac].sfdc007    #sfdc007申请数量
   #LET g_sfdc_d[l_ac].sfdc008 = 0        #实际数量
   #LET g_sfdc_d[l_ac].diff = g_sfdc_d[l_ac].sfdc007 - g_sfdc_d[l_ac].sfdc008  #差异数量
   
   IF cl_null(g_sfdc_d[l_ac].sfdc009) THEN
      LET g_sfdc_d[l_ac].sfdc010 = 0
   ELSE
      #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
      #mark 150101
      #CALL s_aimi190_get_convert(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009) RETURNING l_success,l_rate
      #IF NOT l_success THEN
      #   LET l_rate = 1
      #END IF
      #LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007 * l_rate
      #mark 150101 end
      #add 150101
      CALL s_aooi250_convert_qty(g_sfdc_d[l_ac].sfdc004,g_sfdc_d[l_ac].sfdc006,g_sfdc_d[l_ac].sfdc009,g_sfdc_d[l_ac].sfdc007)
         RETURNING l_success,g_sfdc_d[l_ac].sfdc010
      IF NOT l_success THEN
         LET g_sfdc_d[l_ac].sfdc010 = g_sfdc_d[l_ac].sfdc007
      END IF
      #add 150101 end
      #LET g_sfdc_d[l_ac].sfdc011 = 0        #参考单位实际数量
      #LET g_sfdc_d[l_ac].diff2 = g_sfdc_d[l_ac].sfdc010  - g_sfdc_d[l_ac].sfdc011  #参考单位差异数量
   END IF
   
   CALL s_desc_get_stock_desc(g_site,g_sfdc_d[l_ac].sfdc012) RETURNING g_sfdc_d[l_ac].sfdc012_desc    #库位名称
   CALL s_desc_get_locator_desc(g_site,g_sfdc_d[l_ac].sfdc012,g_sfdc_d[l_ac].sfdc013) RETURNING g_sfdc_d[l_ac].sfdc013_desc  #储位名称
   
   RETURN r_success
END FUNCTION

#當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料
#找出有库存的特征料件发料，同时减少剩余应发量issue_qty
#此FUNCTION用于发料
#141203 add
PRIVATE FUNCTION asft310_01_issue_feature1()
DEFINE l_inag002   LIKE inag_t.inag002   #产品特征
DEFINE l_inag004   LIKE inag_t.inag004   #仓
DEFINE l_inag005   LIKE inag_t.inag005   #储
DEFINE l_inag006   LIKE inag_t.inag006   #批
DEFINE l_inag003   LIKE inag_t.inag003   #库存管理特征
DEFINE l_success   LIKE type_t.num5
DEFINE l_place     LIKE type_t.num5
DEFINE l_qty       LIKE sfdc_t.sfdc007
DEFINE l_where     STRING
DEFINE l_flag2     LIKE type_t.num5   #s_control使用
DEFINE l_inaa006   LIKE inaa_t.inaa006  #170207-00039#1


   LET issue_qty1 = issue_qty   #预设：剩余应发数量 = 应发数量
   
   #有指定仓储批的按指定仓储批, 另tm.issue_type = '3'的用tm2.wc
   IF tm.issue_type = '2' THEN  #自行指定库储批 同_issue()中的仓储批默认写法，未来考虑function化
      LET l_inag004 = tm2.inag004_i  #库位
      LET l_inag005 = tm2.inag005_i  #储位
      LET l_inag006 = tm2.inag006_i  #批号
      LET l_inag003 = tm2.inag003_i  #库存管理特征
      #控制组检查已经在录入tm2.*是控制住了
      
      #工單指定發料庫儲，發料時允許修改
      CALL s_aooi200_get_slip(g_sfba.sfbadocno) RETURNING l_success,g_ooba002
      IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050') = 'N' THEN
         IF NOT cl_null(g_sfba.sfba019) THEN   #库位
            LET l_inag004 = g_sfba.sfba019 
         END IF
         IF NOT cl_null(g_sfba.sfba020) THEN  #储位
            LET l_inag005 = g_sfba.sfba020 
         END IF
         IF NOT cl_null(g_sfba.sfba029) THEN   #批号
            LET l_inag006 = g_sfba.sfba029 
         END IF
         IF NOT cl_null(g_sfba.sfba030) THEN  #库存管理特征
            LET l_inag003 = g_sfba.sfba030 
         END IF
      END IF
   END IF
   
   #LET g_sql = "SELECT unique inag002,inag004,inag005,inag008 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量
   #LET g_sql = "SELECT unique inag002,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量  #170207-00039#1
   LET g_sql = "SELECT unique inaa006,inag002,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量  #170207-00039#1
               " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
               "   AND inagent = ",g_enterprise,
               "   AND inagsite= '",g_site,"' ",
               "   AND inag001 = '",g_sfba.sfba006,"' ",
               "   AND inag002 != ' ' "
   IF NOT cl_null(l_inag004) THEN  #库位
      LET g_sql = g_sql CLIPPED," AND inag004 = '",l_inag004,"' "
   END IF
   IF NOT cl_null(l_inag005) THEN  #储位
      LET g_sql = g_sql CLIPPED," AND inag005 = '",l_inag005,"' "
   END IF
   IF NOT cl_null(l_inag006) THEN  #批号
      LET g_sql = g_sql CLIPPED," AND inag006 = '",l_inag006,"' "
   END IF
   IF NOT cl_null(l_inag003) THEN  #库存管理特征
      LET g_sql = g_sql CLIPPED," AND inag003 = '",l_inag003,"' "
   END IF
   #IF tm.issue_type = '3' THEN  #依库存量发料(QBE)
   IF NOT cl_null(tm2.wc) THEN  #和上面一句结果是一样的，1=1不影响结果
      #检查tm2.wc中有没有下inac003的条件
      LET l_place = tm2.wc.getIndexOf("inac003",1)
      IF l_place = 0 THEN
         LET g_sql = g_sql CLIPPED," AND ",tm2.wc CLIPPED
      ELSE
         #LET g_sql = "SELECT unique inag002,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inac_t ",  #库储批+库存管理特征  #170207-00039#1
         LET g_sql = "SELECT unique inaa006,inag002,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inac_t ",  #库储批+库存管理特征  #170207-00039#1
                     " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
                     "   AND inagent = inacent AND inagsite = inacsite AND inag004 = inac001 AND inag005 = inac002 ",
                     "   AND inagent = ",g_enterprise,
                     "   AND inagsite='",g_site,"'",
                     "   AND inag001 = '",g_sfba.sfba006,"' ",
                     "   AND inag002 != ' ' ",
                     "   AND ",tm2.wc CLIPPED
      END IF
      ##库存管理特征处理 #mark reason若料件库存中仓储批管理特征都管理了，自动展至仓储批时，批、特征等资料没产生出来   原增加此段原因不确定，故先mark
      #LET l_place = tm2.wc.getIndexOf("inag003",1)
      #IF l_place = 0 THEN
      #   LET g_sql = g_sql CLIPPED," AND inag003 = ' ' "
      #END IF
   ELSE
      ##库存管理特征处理 #mark reason若料件库存中仓储批管理特征都管理了，自动展至仓储批时，批、特征等资料没产生出来   原增加此段原因不确定，故先mark
      #IF cl_null(l_inag003) THEN
      #   LET g_sql = g_sql CLIPPED," AND inag003 = ' ' "
      #END IF
   END IF
   
   #关于控制组
   CALL s_control_get_doc_sql("inag004",g_sfdadocno,'6')
        RETURNING l_success,l_where
   IF l_success THEN
      LET g_sql = g_sql CLIPPED," AND ",l_where
   END IF
   #关于控制组--end
   
   #LET g_sql = g_sql CLIPPED," ORDER BY 优先顺序 "
   LET g_sql = g_sql CLIPPED," ORDER BY inaa006 "  #170112-00063#1
   PREPARE asft310_01_issue_feature_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asft310_01_issue_feature_p1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_issue_feature_p1
      RETURN
   END IF
   DECLARE asft310_01_issue_feature_c1 CURSOR FOR asft310_01_issue_feature_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_issue_feature_c1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_issue_feature_p1
      RETURN
   END IF
   #FOREACH asft310_01_issue_feature_c1 INTO l_inag002,l_inag004,l_inag005,l_inag006,l_inag003  #170207-00039#1
   FOREACH asft310_01_issue_feature_c1 INTO l_inaa006,l_inag002,l_inag004,l_inag005,l_inag006,l_inag003  #170207-00039#1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_issue_feature_c1 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #控制组检查
      IF NOT cl_null(l_inag004) THEN
         #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
         CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
            RETURNING l_success,l_flag2
         IF NOT l_success OR NOT l_flag2 THEN
            #控制组检查错误,请检查单别设定的相关内容
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00122'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            CONTINUE FOREACH
         END IF
      END IF
      IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
         #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
         CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
            RETURNING l_success,l_flag2
         IF NOT l_success OR NOT l_flag2 THEN
            #控制组检查错误,请检查单别设定的相关内容
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00122'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            CONTINUE FOREACH
         END IF
      END IF
      #控制组检查--end
      
      #库存可用量
      CALL asft310_01_get_available_qty('a',0,g_sfba.sfba006,l_inag002,g_sfba.sfba014,l_inag004,l_inag005,l_inag006,l_inag003)
         RETURNING l_qty
         
      IF issue_qty1 <= l_qty THEN
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,l_inag002)   #有足量供给需求，产生发料需求明细 库位\储位\批号\数量
         LET issue_qty1 = 0
         EXIT FOREACH
      ELSE
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,l_inag002)   #非足量供给需求，有库存的 产生发料需求明细 库位\储位\批号\数量
         LET issue_qty1 = issue_qty1 - l_qty
      END IF
   END FOREACH
   FREE asft310_01_issue_feature_p1
   
   
   LET issue_qty = issue_qty1   #刷新剩余应发数量 供后续asft310_01_issue1()调用
   
END FUNCTION

#定义cursor
PRIVATE FUNCTION asft310_01_issue_feature2_cursor()
   DEFINE l_sql STRING
   
   #1.找出该笔备料中，已发的哪些料+特征
   LET l_sql = "SELECT sfdd001,sfdd013 ",
               "  FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdd001   = '",g_sfba.sfba006,"' ",   #料号  #若发料中有做取替代，则退料时已生成对应备料资料了，所以此处无需考虑不同料号
               "   AND sfdd012   = -1 ",   #发料
               "   AND sfdastus  = 'S' "   #已扣帐的
   PREPARE asft310_01_issue_feature2_p1 FROM l_sql
   DECLARE asft310_01_issue_feature2_c1 CURSOR FOR asft310_01_issue_feature2_p1
   
   #2.料+特征对应的已退数量
   #  2.1其他退料单的
   LET l_sql = "SELECT sfdd006,SUM(sfdd007) ",
               " FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdcdocno != '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdd001   = ? ", #料号
               "   AND sfdd013   = ? ", #特征
               "   AND sfdd012   = 1 ",   #退料
               "   AND sfdastus != 'X' ", #作废
               " GROUP BY sfdd006 ",
               " UNION ",
   #  2.2本张退料单实体表中的
               "SELECT sfdc006,SUM(sfdc007) ",
               " FROM sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdcdocno = '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdc004   = ? ",  #料号
               "   AND sfdc005   = ? ",  #特征
               " GROUP BY sfdc006 ",
               " UNION ",
   #  2.3本章退料单已生成于临时表中的
               "SELECT sfdc006,SUM(sfdc007) ",
               " FROM asft310_01_sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdc004   = ? ", #料号
               "   AND sfdc005   = ? ", #特征
               " GROUP BY sfdc006 "
   PREPARE asft310_01_issue_feature2_p2 FROM l_sql
   DECLARE asft310_01_issue_feature2_c2 CURSOR FOR asft310_01_issue_feature2_p2
   
   #3.料+特征对应的已发数量
   LET l_sql = "SELECT sfdd006,SUM(sfdd007) ",
               "  FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdd001   = ? ",
               "   AND sfdd013   = ? ",
               "   AND sfdd012   = -1 ",   #发料
               "   AND sfdastus  = 'S' ",  #已扣帐的
               " GROUP BY sfdd006 "
   PREPARE asft310_01_issue_feature2_p3 FROM l_sql
   DECLARE asft310_01_issue_feature2_c3 CURSOR FOR asft310_01_issue_feature2_p3
   
   #4.找出发料中所发料件的特征，其已退料的单据，用于计算该特征剩余可退料的量 之 cursor
   #  4.1其他退料单的
   #LET l_sql = "SELECT sfdd001,sfdd013,sfdd006,sfdd007 ",
   LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdd001,sfdd013, ",
               "       sfdd003,sfdd004,sfdd005,sfdd010,sfdd006,sfdd007 ",
               " FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdcdocno != '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdd001   = ? ", #料号
               "   AND sfdd013   = ? ", #特征
               "   AND sfdd012   = 1 ",   #退料
               "   AND sfdastus != 'X' ", #作废
               " UNION ",
   #  4.2本张退料单实体表中的
               #"SELECT sfdc004,sfdc005,sfdc006,sfdc007 ",
               "SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfdc005, ",
               "       sfdc012,sfdc013,sfdc014,sfdc016,sfdc006,sfdc007 ",
               " FROM sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdcdocno = '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdc004   = ? ",  #料号
               "   AND sfdc005   = ? ",  #特征
               " UNION ",
   #  4.3本章退料单已生成于临时表中的
               #"SELECT sfdc004,sfdc005,sfdc006,sfdc007 ",
               "SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfdc005, ",
               "       sfdc012,sfdc013,sfdc014,sfdc016,sfdc006,sfdc007 ",
               " FROM asft310_01_sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
               "   AND sfdc004   = ? ", #料号
               "   AND sfdc005   = ? "  #特征
   PREPARE asft310_01_issue_feature2_p4 FROM l_sql
   DECLARE asft310_01_issue_feature2_c4 CURSOR FOR asft310_01_issue_feature2_p4
   
   #5.料+特征的不同库存的 已发数量
   LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdd001,sfdd013, ",
               "       sfdd003,sfdd004,sfdd005,sfdd010,sfdd006,sfdd007 ",
               "  FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
               "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
               "   AND sfdd001   = ? ",
               "   AND sfdd013   = ? ",
               "   AND sfdd012   = -1 ",   #发料
               "   AND sfdastus  = 'S' "   #已扣帐的
   PREPARE asft310_01_issue_feature2_p5 FROM l_sql
   DECLARE asft310_01_issue_feature2_c5 CURSOR FOR asft310_01_issue_feature2_p5  #12
   
END FUNCTION

#找出有库存特征的发料及退料，计算该特征可退的量
#此FUNCTION用于退料
#141208 add
PRIVATE FUNCTION asft310_01_issue_feature2()
DEFINE l_sfdd001  LIKE sfdd_t.sfdd001  #发料料号
DEFINE l_sfdd013  LIKE sfdd_t.sfdd013  #特征
DEFINE l_sfdd006  LIKE sfdd_t.sfdd006  #退料单位
DEFINE l_sfdd007  LIKE sfdd_t.sfdd007  #发料数量 （最后转化为备料单位）
DEFINE l_inag004  LIKE inag_t.inag004  #库位
DEFINE l_inag005  LIKE inag_t.inag005  #储位
DEFINE l_inag006  LIKE inag_t.inag006  #批号
DEFINE l_inag003  LIKE inag_t.inag003  #库存管理特征
DEFINE l_qty      LIKE sfdc_t.sfdc007  #此特征可退量
DEFINE l_qty1     LIKE sfdc_t.sfdc007  #已发量
DEFINE l_qty2     LIKE sfdc_t.sfdc007  #已退量
DEFINE l_sql      STRING
DEFINE l_success  LIKE type_t.num5
DEFINE l_rate     LIKE inaj_t.inaj014  #单位换算率
DEFINE l_sfdd     RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_rec_b    LIKE type_t.num10  #退料数组笔数   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_idx      LIKE type_t.num10                 #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_arr_r    DYNAMIC ARRAY OF RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_where          STRING
DEFINE l_flag2          LIKE type_t.num5   #s_control使用
   
   LET issue_qty1 = issue_qty   #预设：剩余应发数量 = 应发数量

   CASE tm.issue_type
      WHEN '1'   #依工單發料倉儲批
           #找出工單發料的倉儲批，且未退完料的(可能會找到多筆，找到數量滿足為止)
           #此处无需l_inag*
      WHEN '2'   #依料件預設庫位/儲位(發料前調撥料件使用預設在製庫位/儲位)
           #退料的倉儲預設為:退料料件的预设库位、储位(发料前调拨料件使用预设在制库位/储位)
           #如果工单指定的库位不为空白，则该笔数据改以工单指定的库、储位做为条件
           IF NOT cl_null(g_sfba.sfba019) THEN
              LET l_inag004 = g_sfba.sfba019  #库位
              LET l_inag005 = g_sfba.sfba020  #储位
              LET l_inag006 = g_sfba.sfba029  #批号
              LET l_inag003 = g_sfba.sfba030  #库存管理特征
           ELSE  
              IF g_imae092 ='Y' THEN  #发料前调拨
                 LET l_inag004 = g_imae101  #在制发料库位
                 LET l_inag005 = g_imae102  #在制发料储位
              ELSE
                 LET l_inag004 = g_imaf091  #料件预设库位
                 LET l_inag005 = g_imaf092  #料件预设储位
              END IF
              LET l_inag006 = ' '  #批号
              LET l_inag003 = ' '  #库存管理特征
           END IF
           #控制组检查
           IF NOT cl_null(l_inag004) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           #控制组检查--end
      WHEN '3'   #自行指定庫位/儲位/批號(INPUT)
           LET l_inag004 = tm2.inag004_i  #库位
           LET l_inag005 = tm2.inag005_i  #储位
           LET l_inag006 = tm2.inag006_i  #批号
           LET l_inag003 = tm2.inag003_i  #库存管理特征
           #控制组检查已经在录入tm2.*是控制住了
   END CASE
   
   CALL asft310_01_issue_feature2_cursor()
   
   #1.找出该笔备料中，已发的哪些料+特征
   FOREACH asft310_01_issue_feature2_c1 INTO l_sfdd001,l_sfdd013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_issue_feature2_c1 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
   
      #先计算工单中该料+特征的可退量
      #2.料+特征对应的已退数量,计算成备料单位的量l_qty2
      LET l_qty2 = 0
      FOREACH asft310_01_issue_feature2_c2 USING l_sfdd001,l_sfdd013,l_sfdd001,l_sfdd013,l_sfdd001,l_sfdd013 INTO l_sfdd006,l_sfdd007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_feature2_c2 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF

         #计算针对这笔发料，有没有已退的量，扣掉后再产生
         #统一折算成工单的单位进行计算
         IF l_sfdd006 != g_sfba.sfba014 THEN   #发料单位，工单单位
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd001,l_sfdd006,g_sfba.sfba014)
            #  RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_sfdd007 = l_sfdd007 * l_rate  #发料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd001,l_sfdd006,g_sfba.sfba014,l_sfdd007)
              RETURNING l_success,g_qty_t
            IF l_success THEN
               LET l_sfdd007 = g_qty_t  #发料数量
            END IF
            #add 150101 end
         END IF
         
         LET l_qty2 = l_qty2 + l_sfdd007
      END FOREACH
      
      #3.料+特征对应的已发数量,计算成备料单位的量l_qty1
      LET l_qty1 = 0
      FOREACH asft310_01_issue_feature2_c3 USING l_sfdd001,l_sfdd013 INTO l_sfdd006,l_sfdd007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_feature2_c3 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF

         #计算针对这笔发料，有没有已退的量，扣掉后再产生
         #统一折算成工单的单位进行计算
         IF l_sfdd006 != g_sfba.sfba014 THEN   #发料单位，工单单位
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd001,l_sfdd006,g_sfba.sfba014)
            #  RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_sfdd007 = l_sfdd007 * l_rate  #发料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd001,l_sfdd006,g_sfba.sfba014,l_sfdd007)
              RETURNING l_success,g_qty_t
            IF l_success THEN
               LET l_sfdd007 = g_qty_t  #发料数量
            END IF
            #add 150101 end
         END IF
         
         LET l_qty1 = l_qty1 + l_sfdd007
      END FOREACH
      LET l_qty = l_qty1-l_qty2  #已发-已退=此特征可退量l_qty
      IF l_qty <= 0 THEN
         CONTINUE FOREACH  #继续找下一个特征
      END IF
      
      IF tm.issue_type='1' OR (tm.issue_type MATCHES '[23]' AND tm.return='Y') THEN
      #若需关联的发料单的,先将相关退料单的都抓出来,再将发料的抓出来,做匹配
         #------退料------
         #4.找出该特征已退料的单据，用于计算该特征剩余可退料的量
         #  4.1其他退料单的+4.2本张退料单实体表中的+4.3本章退料单已生成于临时表中的（换算到本张工单的发料单位g_sfba.sfba014）
         LET l_rec_b = 0
         FOREACH asft310_01_issue_feature2_c4 USING l_sfdd001,l_sfdd013,l_sfdd001,l_sfdd013,l_sfdd001,l_sfdd013 INTO l_sfdd.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'foreach asft310_01_issue_feature2_c4 err'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            
            LET l_rec_b = l_rec_b + 1
            LET l_arr_r[l_rec_b].sfdc001  = l_sfdd.sfdc001  #工单
            LET l_arr_r[l_rec_b].sfdc002  = l_sfdd.sfdc002  #工单项次
            LET l_arr_r[l_rec_b].sfdc003  = l_sfdd.sfdc003  #工单项序
            LET l_arr_r[l_rec_b].sfdd001  = l_sfdd.sfdd001  #退料料号
            LET l_arr_r[l_rec_b].sfdd013  = l_sfdd.sfdd013  #特征
            LET l_arr_r[l_rec_b].sfdd003  = l_sfdd.sfdd003  #库位
            LET l_arr_r[l_rec_b].sfdd004  = l_sfdd.sfdd004  #储位
            LET l_arr_r[l_rec_b].sfdd005  = l_sfdd.sfdd005  #批号
            LET l_arr_r[l_rec_b].sfdd010  = l_sfdd.sfdd010  #库存管理特征
            LET l_arr_r[l_rec_b].sfdd006  = l_sfdd.sfdd006  #退料单位
            IF l_arr_r[l_rec_b].sfdd006 = g_sfba.sfba014 THEN
               LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007   #退料数量
            ELSE
               #mark 150101
               #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
               #   RETURNING l_success,l_rate
               #IF NOT l_success THEN
               #   LET l_rate = 1
               #END IF
               #LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007 * l_rate  #退料数量
               #mark 150101 end
               #add 150101
               CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
                  RETURNING l_success,l_arr_r[l_rec_b].sfdd007
               IF NOT l_success THEN
                  LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007
               END IF
               #add 150101 end
            END IF
         END FOREACH #已退的料
         
         #------发料------
         #5.料+特征的不同库存的 已发数量
         #tm.issue_type = '1'依工单发料仓储批 找出工單發料的倉儲批，且未退完料的(可能會找到多筆，找到數量滿足為止)
         #默认工单发料的所有仓储批 排除库位不满足单据别限制范围内的
         FOREACH asft310_01_issue_feature2_c5 USING l_sfdd001,l_sfdd013 INTO l_sfdd.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'foreach asft310_01_issue_feature2_c5 err'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF

            #计算针对这笔发料，有没有已退的量，扣掉后再产生
            #统一折算成工单的单位进行计算
            IF l_sfdd.sfdd006 != g_sfba.sfba014 THEN   #发料单位，工单单位
               #mark 150101
               #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
               #   RETURNING l_success,l_rate
               #IF NOT l_success THEN
               #   LET l_rate = 1
               #END IF
               #LET l_sfdd.sfdd007 = l_sfdd.sfdd007 * l_rate  #发料数量
               #mark 150101 end
               #add 150101
               CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
                  RETURNING l_success,g_qty_t
               IF l_success THEN
                  LET l_sfdd.sfdd007 = g_qty_t  #发料数量
               END IF
               #add 150101 end
            END IF
            
            #先从发料量中扣除退料量
            IF l_rec_b >= 1 THEN
               FOR l_idx = 1 TO l_rec_b
                   IF l_arr_r[l_idx].sfdd007 = 0 THEN  #退料数量
                      CONTINUE FOR
                   END IF
                   
                   IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
                      IF  l_arr_r[l_idx].sfdc001  = l_sfdd.sfdc001    #工单
                      AND l_arr_r[l_idx].sfdc002  = l_sfdd.sfdc002    #工单项次
                      #AND l_arr_r[l_idx].sfdc003  = l_sfdd.sfdc003    #工单项序  mark发料中做取替代会有问题
                      AND l_arr_r[l_idx].sfdd001  = l_sfdd.sfdd001    #退料料号
                      AND l_arr_r[l_idx].sfdd013  = l_sfdd.sfdd013    #特征
                      AND l_arr_r[l_idx].sfdd005  = l_sfdd.sfdd005    #批号
                      THEN
                         #计算发料中未退数量l_sfdd.sfdd007，即本次可退量
                         IF l_arr_r[l_idx].sfdd007  >= l_sfdd.sfdd007 THEN
                            #退料数量>本笔发料量
                            LET l_arr_r[l_idx].sfdd007 = l_arr_r[l_idx].sfdd007 - l_sfdd.sfdd007 #剩余待抵退料量
                            LET l_sfdd.sfdd007 = 0  #发料中未退量
                            EXIT FOR
                         ELSE
                            LET l_sfdd.sfdd007 = l_sfdd.sfdd007 - l_arr_r[l_idx].sfdd007  #发料中未退量
                            LET l_arr_r[l_idx].sfdd007 = 0 #剩余待抵退料量
                         END IF
                      END IF  #按发料的批号(tm.issue_type MATCHES '[23]' AND tm.return='Y')
                   ELSE
                      IF  l_arr_r[l_idx].sfdc001  = l_sfdd.sfdc001    #工单
                      AND l_arr_r[l_idx].sfdc002  = l_sfdd.sfdc002    #工单项次
                      #AND l_arr_r[l_idx].sfdc003  = l_sfdd.sfdc003    #工单项序  mark发料中做取替代会有问题
                      AND l_arr_r[l_idx].sfdd001  = l_sfdd.sfdd001    #退料料号
                      AND l_arr_r[l_idx].sfdd013  = l_sfdd.sfdd013    #特征
                      AND l_arr_r[l_idx].sfdd003  = l_sfdd.sfdd003    #库位
                      AND l_arr_r[l_idx].sfdd004  = l_sfdd.sfdd004    #储位
                      AND l_arr_r[l_idx].sfdd005  = l_sfdd.sfdd005    #批号
                      AND l_arr_r[l_idx].sfdd010  = l_sfdd.sfdd010    #库存管理特征
                      THEN
                         #计算发料中未退数量l_sfdd.sfdd007，即本次可退量
                         IF l_arr_r[l_idx].sfdd007  >= l_sfdd.sfdd007 THEN
                            #退料数量>本笔发料量
                            LET l_arr_r[l_idx].sfdd007 = l_arr_r[l_idx].sfdd007 - l_sfdd.sfdd007 #剩余待抵退料量
                            LET l_sfdd.sfdd007 = 0  #发料中未退量
                            EXIT FOR
                         ELSE
                            LET l_sfdd.sfdd007 = l_sfdd.sfdd007 - l_arr_r[l_idx].sfdd007  #发料中未退量
                            LET l_arr_r[l_idx].sfdd007 = 0 #剩余待抵退料量
                         END IF
                      END IF  #按tm.issue_type='1'发料的仓储批
                   END IF  #是哪种退料方式
               END FOR #发退量互相扣减
            END IF #有已退料的情况
            
            #发料中未退量=0 代表此笔发料资料无料可退
            IF l_sfdd.sfdd007 = 0 THEN
               CONTINUE FOREACH
            END IF
            #发料中未退量>此特征可退的量
            IF l_sfdd.sfdd007 > l_qty THEN
               LET l_sfdd.sfdd007 = l_qty
            END IF
            
            #扣掉全部退料数量后仍有发料量，则产生到单身临时表中
            IF issue_qty1 <= l_sfdd.sfdd007 THEN
               IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
                  CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_sfdd.sfdd005,l_inag003,tm.reason,issue_qty1,l_sfdd013)
               ELSE
                  CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,tm.reason,issue_qty1,l_sfdd013)
               END IF
               LET l_qty = l_qty - issue_qty1  #扣减此特征可退量
               LET issue_qty1 = 0     #剩余退料量
               RETURN
            ELSE
               IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
                  CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_sfdd.sfdd005,l_inag003,tm.reason,l_sfdd.sfdd007,l_sfdd013)
               ELSE
                  CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,tm.reason,l_sfdd.sfdd007,l_sfdd013)
               END IF
               LET l_qty = l_qty - l_sfdd.sfdd007  #扣减此特征可退量
               LET issue_qty1 = issue_qty1 - l_sfdd.sfdd007  #剩余退料量
            END IF
         END FOREACH #已发的料
      END IF
      
      IF tm.issue_type MATCHES '[23]' AND tm.return='N' THEN
         IF issue_qty1 > l_qty THEN
            CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,l_sfdd013)
            LET issue_qty1 = issue_qty1 - l_qty
         ELSE
            CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,l_sfdd013)
            LET issue_qty1 = 0
            RETURN
         END IF
      END IF
   END FOREACH #哪个特征
END FUNCTION

#依不同发料方式自动产生单身资料
#此FUNCTION用于发料
PRIVATE FUNCTION asft310_01_issue1()
DEFINE l_inag004  LIKE inag_t.inag004  #库位
DEFINE l_inag005  LIKE inag_t.inag005  #储位
DEFINE l_inag006  LIKE inag_t.inag006  #批号
DEFINE l_inag003  LIKE inag_t.inag003  #库存管理特征
DEFINE l_qty      LIKE sfdc_t.sfdc007  #库存可发量
DEFINE l_sql      STRING
DEFINE l_success  LIKE type_t.num5
DEFINE l_rate     LIKE inaj_t.inaj014  #单位换算率
DEFINE l_sfdd     RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_rec_b    LIKE type_t.num10  #退料数组笔数    #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_idx      LIKE type_t.num10                  #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_arr_r    DYNAMIC ARRAY OF RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_where         STRING
DEFINE l_flag2         LIKE type_t.num5     #s_control使用
DEFINE lc_param        type_sfba_parameter  #160726-00001#6
DEFINE ls_js           STRING               #160726-00001#6
DEFINE l_prog          STRING               #170602-00036#1 add

   
   LET issue_qty1 = issue_qty   #预设：剩余应发数量 = 应发数量

   CASE tm.issue_type
      WHEN '1'   #依料件预设库位/储位(发料前调拨料件使用预设在制库位/储位):
           #依发料料号找料件基本数据的默认库位、预设储位(发料前调拨料件使用预设在制库位/储位)
           #如果工单指定的库位不为空白，则该笔数据改以工单指定的库、储位做为条件
           IF NOT cl_null(g_sfba.sfba019) THEN
              LET l_inag004 = g_sfba.sfba019  #库位
              LET l_inag005 = g_sfba.sfba020  #储位
              LET l_inag006 = g_sfba.sfba029  #批号
              LET l_inag003 = g_sfba.sfba030  #库存管理特征
           ELSE
              #160512-00004#2-mod-(S)                   
#              IF g_imae092 ='Y' THEN  #发料前调拨
#                 LET l_inag004 = g_imae101  #在制发料库位
#                 LET l_inag005 = g_imae102  #在制发料储位
#              ELSE
#                 LET l_inag004 = g_imaf091  #料件预设库位
#                 LET l_inag005 = g_imaf092  #料件预设储位
#              END IF
#              LET l_inag006 = ' '  #批号
#              LET l_inag003 = ' '  #库存管理特征
               #160726-00001#6-s
               #CALL asft310_01_inag_default() RETURNING l_inag004,l_inag005,l_inag006,l_inag003
               LET lc_param.sfbadocno = g_sfba.sfbadocno   
               LET lc_param.sfbaseq   = g_sfba.sfbaseq
               LET lc_param.sfbaseq1  = g_sfba.sfbaseq1
               LET lc_param.sfba006   = g_sfba.sfba006
               LET lc_param.sfba013   = issue_qty
               LET lc_param.sfba014   = g_sfba.sfba014
               LET lc_param.sfba016   = 0
               LET lc_param.sfba021   = g_sfba.sfba021
               LET lc_param.sfba029   = g_sfba.sfba029
               LET lc_param.sfba030   = g_sfba.sfba030
               LET ls_js = util.JSON.stringify(lc_param)
               #170602-00036#1 add --(S)--
               LET l_prog = g_prog
               IF g_prog[1,7] = 'asft311' THEN
                  LET g_prog = 'asft310_01'
               END IF   
               #170602-00036#1 add --(E)--
               CALL s_asft310_inag_default(ls_js) RETURNING l_inag004,l_inag005,l_inag006,l_inag003  
               #160726-00001#6-e
               LET g_prog = l_prog  #170602-00036#1 add 
              #160512-00004#2-mod-(E)
           END IF
           
           #工單指定發料庫儲，發料時允許修改
           CALL s_aooi200_get_slip(g_sfba.sfbadocno) RETURNING l_success,g_ooba002
           IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050') = 'N' THEN
              IF NOT cl_null(g_sfba.sfba019) THEN   #库位
                 LET l_inag004 = g_sfba.sfba019 
              END IF
              IF NOT cl_null(g_sfba.sfba020) THEN  #储位
                 LET l_inag005 = g_sfba.sfba020 
              END IF
              IF NOT cl_null(g_sfba.sfba029) THEN   #批号
                 LET l_inag006 = g_sfba.sfba029 
              END IF
              IF NOT cl_null(g_sfba.sfba030) THEN  #库存管理特征
                 LET l_inag003 = g_sfba.sfba030 
              END IF
           END IF
           
           #控制组检查
           IF NOT cl_null(l_inag004) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           #控制组检查--end
           
           IF cl_null(l_inag004) THEN  #没有预设库位
              IF tm.less = 'Y' THEN  #库存不足乃产生     ELSE则不产生
                 CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',' ',' ',' ',' ',tm.reason,issue_qty1,'')   #产生到发料需求的库、储、批、库存管理特征都为空白
                 LET issue_qty1 = 0
              END IF
           ELSE     #有预设库位
　　 　　　 　  IF tm.expand = 'N' THEN  #自动展至库储批
                 #库存可用量
                 CALL asft310_01_get_available_qty('a',0,g_sfba.sfba006,g_sfba.sfba021,g_sfba.sfba014,l_inag004,l_inag005,l_inag006,l_inag003)
                    RETURNING l_qty
                 #IF issue_qty1 <= l_qty THEN  #170516-00063#1 mark
                 IF issue_qty1 <= l_qty OR tm.less = 'Y' THEN  #170516-00063#1
                    CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')   #有足量供给需求，产生发料需求明细 库位\储位\批号\数量
                    LET issue_qty1 = 0
                 ELSE
                    CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,'')   #非足量供给需求，有库存的 产生发料需求明细 库位\储位\批号\数量
                    LET issue_qty1 = issue_qty1 - l_qty
                    #170516-00063#1-s mark
                    #IF tm.less = 'Y' THEN   #库存不足乃产生
                    #   CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',' ',' ',' ',' ',tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量 141219-00017需求
                    #   #CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量 
                    #   LET issue_qty1 = 0
                    #END IF
                    #170516-00063#1-e mark
                 END IF
              ELSE #自动展至库储批expand='Y'
                 CALL asft310_01_get_inag(g_sfba.sfba006,g_sfba.sfba021,l_inag004,l_inag005,l_inag006,l_inag003,g_sfba.sfba014)
              END IF  #是否自动展至库储批
           END IF  #是否有预设库位
      WHEN '2'   #自行指定库存条件(INPUT):处理逻辑同1.依料件预设库位/储位，只是改为用画面上的指定库位、指位储位、指定批号
           LET l_inag004 = tm2.inag004_i  #库位
           LET l_inag005 = tm2.inag005_i  #储位
           LET l_inag006 = tm2.inag006_i  #批号
           LET l_inag003 = tm2.inag003_i  #库存管理特征
           #控制组检查已经在录入tm2.*是控制住了
   
           #工單指定發料庫儲，發料時允許修改
           CALL s_aooi200_get_slip(g_sfba.sfbadocno) RETURNING l_success,g_ooba002
           IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050') = 'N' THEN
              IF NOT cl_null(g_sfba.sfba019) THEN   #库位
                 LET l_inag004 = g_sfba.sfba019 
              END IF
              IF NOT cl_null(g_sfba.sfba020) THEN  #储位
                 LET l_inag005 = g_sfba.sfba020 
              END IF
              IF NOT cl_null(g_sfba.sfba029) THEN   #批号
                 LET l_inag006 = g_sfba.sfba029 
              END IF
              IF NOT cl_null(g_sfba.sfba030) THEN  #库存管理特征
                 LET l_inag003 = g_sfba.sfba030 
              END IF
           END IF
   
           #下面的同产生方式1一样的 可以考虑做成函数
           IF cl_null(l_inag004) THEN  #库位空白    ELSE 不产生
              IF tm.less = 'Y' THEN  #库存不足乃产生
                CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',' ',' ',' ',' ',tm.reason,issue_qty1,'')   #产生到发料需求的库、储、批、库存管理特征都为空白
                LET issue_qty1 = 0
              END IF
           ELSE     #有库位
　　 　　　 　  IF tm.expand = 'N' THEN  #自动展至库储批
                 #库存可用量
                 CALL asft310_01_get_available_qty('a',0,g_sfba.sfba006,g_sfba.sfba021,g_sfba.sfba014,l_inag004,l_inag005,l_inag006,l_inag003)
                    RETURNING l_qty
                 #IF issue_qty1 <= l_qty THEN  #应发量 <= 可发量  #170516-00063#1 mark
                 IF issue_qty1 <= l_qty OR tm.less = 'Y' THEN    #170516-00063#1
                    CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')   #有足量供给需求，产生发料需求明细 库位\储位\批号\数量
                    LET issue_qty1 = 0
                 ELSE
                    CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,'')   #非足量供给需求，有库存的 产生发料需求明细 库位\储位\批号\数量
                    LET issue_qty1 = issue_qty1 - l_qty
                    #170516-00063#1-s mark
                    #IF tm.less = 'Y' THEN   #库存不足乃产生
                    #   CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',' ',' ',' ',' ',tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量 141219-00017需求
                    #   #CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量
                    #   LET issue_qty1 = 0
                    #END IF
                    #170516-00063#1-e mark
                 END IF
              ELSE #自动展至库储批expand='Y'
                 CALL asft310_01_get_inag(g_sfba.sfba006,g_sfba.sfba021,l_inag004,l_inag005,l_inag006,l_inag003,g_sfba.sfba014)
              END IF  #是否自动展至库储批
           END IF  #是否有预设库位
      WHEN '3'   #依库存量发料(QBE):可輸入指定庫位inag004、指定儲位inag005、指定批號inag006、標籤inac003、保稅inaa015、成本倉inaa010
           
           #控制组检查
           IF NOT cl_null(l_inag004) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           #控制组检查--end
           
           #工單指定發料庫儲，發料時允許修改
           CALL s_aooi200_get_slip(g_sfba.sfbadocno) RETURNING l_success,g_ooba002
           IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0050') = 'N' THEN
              IF NOT cl_null(g_sfba.sfba019) THEN   #库位
                 LET l_inag004 = g_sfba.sfba019 
              END IF
              IF NOT cl_null(g_sfba.sfba020) THEN  #储位
                 LET l_inag005 = g_sfba.sfba020 
              END IF
              IF NOT cl_null(g_sfba.sfba029) THEN   #批号
                 LET l_inag006 = g_sfba.sfba029 
              END IF
              IF NOT cl_null(g_sfba.sfba030) THEN  #库存管理特征
                 LET l_inag003 = g_sfba.sfba030 
              END IF
           END IF
                                   #发料料号        特征           库        储        批         库存管理特征  单位
           CALL asft310_01_get_inag(g_sfba.sfba006,g_sfba.sfba021,l_inag004,l_inag005,l_inag006,l_inag003,g_sfba.sfba014)
   END CASE

END FUNCTION

#依不同发料方式自动产生单身资料
#此FUNCTION用于退料
PRIVATE FUNCTION asft310_01_issue2()
DEFINE l_inag004  LIKE inag_t.inag004  #库位
DEFINE l_inag005  LIKE inag_t.inag005  #储位
DEFINE l_inag006  LIKE inag_t.inag006  #批号
DEFINE l_inag003  LIKE inag_t.inag003  #库存管理特征
DEFINE l_qty      LIKE sfdc_t.sfdc007  #库存可发量
DEFINE l_sql      STRING
DEFINE l_success  LIKE type_t.num5
DEFINE l_rate     LIKE inaj_t.inaj014  #单位换算率
DEFINE l_sfdd     RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_rec_b    LIKE type_t.num10  #退料数组笔数   #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_idx      LIKE type_t.num10                 #170104-00066#2 num5->num10  17/01/06 mod by rainy 
DEFINE l_arr_r    DYNAMIC ARRAY OF RECORD
                  sfdc001   LIKE sfdc_t.sfdc001,  #工单
                  sfdc002   LIKE sfdc_t.sfdc002,  #工单项次
                  sfdc003   LIKE sfdc_t.sfdc003,  #工单项序
                  sfdd001   LIKE sfdd_t.sfdd001,  #退料料号
                  sfdd013   LIKE sfdd_t.sfdd013,  #特征
                  sfdd003   LIKE sfdd_t.sfdd003,  #库位
                  sfdd004   LIKE sfdd_t.sfdd004,  #储位
                  sfdd005   LIKE sfdd_t.sfdd005,  #批号
                  sfdd010   LIKE sfdd_t.sfdd010,  #库存管理特征
                  sfdd006   LIKE sfdd_t.sfdd006,  #退料单位
                  sfdd007   LIKE sfdd_t.sfdd007   #退料数量
                  END RECORD
DEFINE l_where          STRING
DEFINE l_flag2          LIKE type_t.num5   #s_control使用
   
   LET issue_qty1 = issue_qty   #预设：剩余应发数量 = 应发数量

   CASE tm.issue_type
      WHEN '1'   #依工單發料倉儲批
           #找出工單發料的倉儲批，且未退完料的(可能會找到多筆，找到數量滿足為止)
           #此处无需l_inag*
      WHEN '2'   #依料件預設庫位/儲位(發料前調撥料件使用預設在製庫位/儲位)
           #退料的倉儲預設為:退料料件的预设库位、储位(发料前调拨料件使用预设在制库位/储位)
           #如果工单指定的库位不为空白，则该笔数据改以工单指定的库、储位做为条件
           IF NOT cl_null(g_sfba.sfba019) THEN
              LET l_inag004 = g_sfba.sfba019  #库位
              LET l_inag005 = g_sfba.sfba020  #储位
              LET l_inag006 = g_sfba.sfba029  #批号
              LET l_inag003 = g_sfba.sfba030  #库存管理特征
           ELSE  
              IF g_imae092 ='Y' THEN  #发料前调拨
                 LET l_inag004 = g_imae101  #在制发料库位
                 LET l_inag005 = g_imae102  #在制发料储位
              ELSE
                 LET l_inag004 = g_imaf091  #料件预设库位
                 LET l_inag005 = g_imaf092  #料件预设储位
              END IF
              LET l_inag006 = ' '  #批号
              LET l_inag003 = ' '  #库存管理特征
           END IF
           #控制组检查
           IF NOT cl_null(l_inag004) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
              #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
              CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
                 RETURNING l_success,l_flag2
              IF NOT l_success OR NOT l_flag2 THEN
                 #控制组检查错误,请检查单别设定的相关内容
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = 'asf-00122'
                 LET g_errparam.extend = ''
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 LET l_inag004 = ' '
                 LET l_inag005 = ' '
              END IF
           END IF
           #控制组检查--end
           
      WHEN '3'   #自行指定庫位/儲位/批號(INPUT)
           LET l_inag004 = tm2.inag004_i  #库位
           LET l_inag005 = tm2.inag005_i  #储位
           LET l_inag006 = tm2.inag006_i  #批号
           LET l_inag003 = tm2.inag003_i  #库存管理特征
           #控制组检查已经在录入tm2.*是控制住了
   END CASE

   IF tm.issue_type='1' OR (tm.issue_type MATCHES '[23]' AND tm.return='Y') THEN
   #若需关联的发料单的,先将相关退料单的都抓出来,再将发料的抓出来,做匹配
      #------退料------
      #---取其他退料资料, 换算到本张工单的发料单位g_sfba.sfba014
      #其他退料单的
      LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdd001,sfdd013, ",
                  "       sfdd003,sfdd004,sfdd005,sfdd010,sfdd006,sfdd007 ",
                  " FROM sfdd_t,sfdc_t,sfda_t ",
                  " WHERE sfddent   = sfdcent ",
                  "   AND sfdddocno = sfdcdocno ",
                  "   AND sfddseq   = sfdcseq ",
                  "   AND sfddent   = sfdaent ",
                  "   AND sfdddocno = sfdadocno ",
                  "   AND sfdcent   = ",g_enterprise,
                  "   AND sfdcdocno!= '",g_sfdadocno,"' ",  #退料单号#161109-00085#30
                  "   AND sfdc001   = '",g_sfba.sfbadocno,"' ",  #工单
                  "   AND sfdc002   = ",g_sfba.sfbaseq,          #项次
                  "   AND sfdc003   = ",g_sfba.sfbaseq1,         #项序
                  "   AND sfdd001   = '",g_sfba.sfba006,"' ",    #料号
                  "   AND sfdd013   = '",g_sfba.sfba021,"' ",    #特征
                  "   AND sfdd012   = 1 ",                       #退料
                  "   AND sfdastus != 'X' "                      #作废
      PREPARE asft310_01_issue_p20 FROM l_sql
      DECLARE asft310_01_issue_c20 CURSOR FOR asft310_01_issue_p20
      LET l_rec_b = 0
      #FOREACH asft310_01_issue_c20 INTO l_sfdd.* #161109-00085#62 mark
      #161109-00085#62 --s add
      FOREACH asft310_01_issue_c20 INTO l_sfdd.sfdc001,l_sfdd.sfdc002,l_sfdd.sfdc003,l_sfdd.sfdd001,l_sfdd.sfdd013,
                                        l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,l_sfdd.sfdd006,
                                        l_sfdd.sfdd007
      #161109-00085#62 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_c20 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         LET l_rec_b = l_rec_b + 1
         LET l_arr_r[l_rec_b].sfdc001  = l_sfdd.sfdc001      #工单
         LET l_arr_r[l_rec_b].sfdc002  = l_sfdd.sfdc002      #工单项次
         LET l_arr_r[l_rec_b].sfdc003  = l_sfdd.sfdc003      #工单项序
         LET l_arr_r[l_rec_b].sfdd001  = l_sfdd.sfdd001      #退料料号
         LET l_arr_r[l_rec_b].sfdd013  = l_sfdd.sfdd013      #特征
         LET l_arr_r[l_rec_b].sfdd003  = l_sfdd.sfdd003      #库位
         LET l_arr_r[l_rec_b].sfdd004  = l_sfdd.sfdd004      #储位
         LET l_arr_r[l_rec_b].sfdd005  = l_sfdd.sfdd005      #批号
         LET l_arr_r[l_rec_b].sfdd010  = l_sfdd.sfdd010      #库存管理特征
         LET l_arr_r[l_rec_b].sfdd006  = l_sfdd.sfdd006      #退料单位
         IF l_arr_r[l_rec_b].sfdd006 = g_sfba.sfba014 THEN
            LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007   #退料数量
         ELSE
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
            #   RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007 * l_rate  #退料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
               RETURNING l_success,l_arr_r[l_rec_b].sfdd007
            IF NOT l_success THEN
               LET l_arr_r[l_rec_b].sfdd007 = l_sfdd.sfdd007
            END IF
            #add 150101 end
         END IF
      END FOREACH
      #本张退料单实体表中的
      LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfdc005, ",
                  "       sfdc012,sfdc013,sfdc014,sfdc016,sfdc006,sfdc007 ",
                  " FROM sfdc_t ",
                  " WHERE sfdcent   = ",g_enterprise,
                  "   AND sfdcdocno = '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
                  "   AND sfdc001   = '",g_sfba.sfbadocno,"' ",  #工单
                  "   AND sfdc002   = ",g_sfba.sfbaseq,          #项次
                  "   AND sfdc003   = ",g_sfba.sfbaseq1,         #项序
                  "   AND sfdc004   = '",g_sfba.sfba006,"' ",    #料号
                  "   AND sfdc005   = '",g_sfba.sfba021,"' "     #特征
      PREPARE asft310_01_issue_p21 FROM l_sql
      DECLARE asft310_01_issue_c21 CURSOR FOR asft310_01_issue_p21
      #FOREACH asft310_01_issue_c21 INTO l_sfdd.* #161109-00085#62 mark
      #161109-00085#62 --s add
      FOREACH asft310_01_issue_c21 INTO l_sfdd.sfdc001,l_sfdd.sfdc002,l_sfdd.sfdc003,l_sfdd.sfdd001,l_sfdd.sfdd013,
                                        l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,l_sfdd.sfdd006,
                                        l_sfdd.sfdd007
      #161109-00085#62 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_c21 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         LET l_rec_b = l_rec_b + 1
         LET l_arr_r[l_rec_b].sfdc001  = l_sfdd.sfdc001      #工单
         LET l_arr_r[l_rec_b].sfdc002  = l_sfdd.sfdc002      #工单项次
         LET l_arr_r[l_rec_b].sfdc003  = l_sfdd.sfdc003      #工单项序
         LET l_arr_r[l_rec_b].sfdd001  = l_sfdd.sfdd001      #退料料号
         LET l_arr_r[l_rec_b].sfdd013  = l_sfdd.sfdd013      #特征
         LET l_arr_r[l_rec_b].sfdd003  = l_sfdd.sfdd003      #库位
         LET l_arr_r[l_rec_b].sfdd004  = l_sfdd.sfdd004      #储位
         LET l_arr_r[l_rec_b].sfdd005  = l_sfdd.sfdd005      #批号
         LET l_arr_r[l_rec_b].sfdd010  = l_sfdd.sfdd010      #库存管理特征
         LET l_arr_r[l_rec_b].sfdd006  = l_sfdd.sfdd006      #退料单位
         IF l_arr_r[l_rec_b].sfdd006 = g_sfba.sfba014 THEN
            LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007   #退料数量
         ELSE
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
            #   RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007 * l_rate  #退料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
               RETURNING l_success,l_arr_r[l_rec_b].sfdd007
            IF NOT l_success THEN
               LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007
            END IF
            #add 150101 end
         END IF
      END FOREACH
      #本章退料单已生成于临时表中的
      LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfdc005, ",
                  "       sfdc012,sfdc013,sfdc014,sfdc016,sfdc006,sfdc007 ",
                  " FROM asft310_01_sfdc_t ",
                  " WHERE sfdcent   = ",g_enterprise,
                  "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
                  "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
                  "   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序
                  "   AND sfdc004   = '",g_sfba.sfba006,"' ",   #料号
                  "   AND sfdc005   = '",g_sfba.sfba021,"' "    #特征
      PREPARE asft310_01_issue_p22 FROM l_sql
      DECLARE asft310_01_issue_c22 CURSOR FOR asft310_01_issue_p22
      #FOREACH asft310_01_issue_c22 INTO l_sfdd.* #161109-00085#62 mark
      #161109-00085#62 --s add
      FOREACH asft310_01_issue_c22 INTO l_sfdd.sfdc001,l_sfdd.sfdc002,l_sfdd.sfdc003,l_sfdd.sfdd001,l_sfdd.sfdd013,
                                        l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,l_sfdd.sfdd006,
                                        l_sfdd.sfdd007
      #161109-00085#62 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_c22 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         LET l_rec_b = l_rec_b + 1
         LET l_arr_r[l_rec_b].sfdc001  = l_sfdd.sfdc001      #工单
         LET l_arr_r[l_rec_b].sfdc002  = l_sfdd.sfdc002      #工单项次
         LET l_arr_r[l_rec_b].sfdc003  = l_sfdd.sfdc003      #工单项序
         LET l_arr_r[l_rec_b].sfdd001  = l_sfdd.sfdd001      #退料料号
         LET l_arr_r[l_rec_b].sfdd013  = l_sfdd.sfdd013      #特征
         LET l_arr_r[l_rec_b].sfdd003  = l_sfdd.sfdd003      #库位
         LET l_arr_r[l_rec_b].sfdd004  = l_sfdd.sfdd004      #储位
         LET l_arr_r[l_rec_b].sfdd005  = l_sfdd.sfdd005      #批号
         LET l_arr_r[l_rec_b].sfdd010  = l_sfdd.sfdd010      #库存管理特征
         LET l_arr_r[l_rec_b].sfdd006  = l_sfdd.sfdd006      #退料单位
         IF l_arr_r[l_rec_b].sfdd006 = g_sfba.sfba014 THEN
            LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007   #退料数量
         ELSE
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
            #   RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007 * l_rate  #退料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
               RETURNING l_success,l_arr_r[l_rec_b].sfdd007
            IF NOT l_success THEN
               LET l_arr_r[l_rec_b].sfdd007  = l_sfdd.sfdd007
            END IF
            #add 150101 end
         END IF
      END FOREACH
      
      #------发料------
      #tm.issue_type = '1'依工单发料仓储批 找出工單發料的倉儲批，且未退完料的(可能會找到多筆，找到數量滿足為止)
      #以下sql默认工单发料的所有仓储批 排除库位不满足单据别限制范围内的
      LET l_sql = "SELECT sfdc001,sfdc002,sfdc003,sfdd001,sfdd013, ",
                  "       sfdd003,sfdd004,sfdd005,sfdd010,sfdd006,sfdd007 ",
                  "  FROM sfdd_t,sfdc_t,sfda_t ",
                  " WHERE sfddent   = sfdcent ",
                  "   AND sfdddocno = sfdcdocno ",
                  "   AND sfddseq   = sfdcseq ",
                  "   AND sfddent   = sfdaent ",
                  "   AND sfdddocno = sfdadocno ",
                  "   AND sfdcent   = ",g_enterprise,
                  "   AND sfdc001   = '",g_sfba.sfbadocno,"' ", #工单
                  "   AND sfdc002   = ",g_sfba.sfbaseq,         #项次
                  #"   AND sfdc003   = ",g_sfba.sfbaseq1,        #项序  mark发料中做取替代会有问题
                  "   AND sfdd001   = '",g_sfba.sfba006,"' ",   #料号
                  "   AND sfdd013   = '",g_sfba.sfba021,"' ",   #特征
                  "   AND sfdd012   = -1 ",                     #发料
                  "   AND sfdastus  = 'S' "                     #已扣帐的
      #IF tm.issue_type = '2' THEN #依料件預設庫位/儲位(發料前調撥料件使用預設在製庫位/儲位)
      #   #退料的倉儲預設為:退料料件的预设库位、储位(发料前调拨料件使用预设在制库位/储位)
      #   #如果工单指定的库位不为空白，则该笔数据改以工单指定的库、储位做为条件
      #   LET l_sql = l_sql CLIPPED," AND sfdd003='",l_inag004,"' AND sfdd004='",l_inag005,"' "
      #END IF
      #IF tm.issue_type = '3' THEN #自行指定庫位/儲位/批號(INPUT)
      #   LET l_sql = l_sql CLIPPED," AND sfdd003='",l_inag004,"' AND sfdd004='",l_inag005,"' ",
      #                             " AND sfdd005='",l_inag006,"' AND sfdd010='",l_inag003,"' "
      #END IF

      #关于控制组
      CALL s_control_get_doc_sql("sfdd003",g_sfdadocno,'6')
           RETURNING l_success,l_where
      IF l_success THEN
         LET l_sql = l_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end
   
      PREPARE asft310_01_issue_p1 FROM l_sql
      DECLARE asft310_01_issue_c1 CURSOR FOR asft310_01_issue_p1
      #FOREACH asft310_01_issue_c1 INTO l_sfdd.* #161109-00085#62 mark
      #161109-00085#62 --s add
      FOREACH asft310_01_issue_c1 INTO  l_sfdd.sfdc001,l_sfdd.sfdc002,l_sfdd.sfdc003,l_sfdd.sfdd001,l_sfdd.sfdd013,
                                        l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,l_sfdd.sfdd006,
                                        l_sfdd.sfdd007
      #161109-00085#62 --e add
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_issue_c1 err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         #计算针对这笔发料，有没有已退的量，扣掉后再产生
         #统一折算成工单的单位进行计算
         IF l_sfdd.sfdd006 != g_sfba.sfba014 THEN   #发料单位，工单单位
            #mark 150101
            #CALL s_aimi190_get_convert(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014)
            #  RETURNING l_success,l_rate
            #IF NOT l_success THEN
            #   LET l_rate = 1
            #END IF
            #LET l_sfdd.sfdd007 = l_sfdd.sfdd007 * l_rate  #发料数量
            #mark 150101 end
            #add 150101
            CALL s_aooi250_convert_qty(l_sfdd.sfdd001,l_sfdd.sfdd006,g_sfba.sfba014,l_sfdd.sfdd007)
              RETURNING l_success,g_qty_t
            IF l_success THEN
               LET l_sfdd.sfdd007 = g_qty_t  #发料数量
            END IF
            #add 150101 end
         END IF
         
         #先从发料量中扣除退料量
         IF l_rec_b >= 1 THEN
            FOR l_idx = 1 TO l_rec_b
                IF l_arr_r[l_idx].sfdd007 = 0 THEN  #退料数量
                   CONTINUE FOR
                END IF
                
                IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
                   IF  l_arr_r[l_idx].sfdc001  = l_sfdd.sfdc001    #工单
                   AND l_arr_r[l_idx].sfdc002  = l_sfdd.sfdc002    #工单项次
                   #AND l_arr_r[l_idx].sfdc003  = l_sfdd.sfdc003    #工单项序  mark发料中做取替代会有问题
                   AND l_arr_r[l_idx].sfdd001  = l_sfdd.sfdd001    #退料料号
                   AND l_arr_r[l_idx].sfdd013  = l_sfdd.sfdd013    #特征
                   AND l_arr_r[l_idx].sfdd005  = l_sfdd.sfdd005    #批号
                   THEN
                      #计算发料中未退数量l_sfdd.sfdd007，即本次可退量
                      IF l_arr_r[l_idx].sfdd007  >= l_sfdd.sfdd007 THEN
                         #退料数量>本笔发料量
                         LET l_arr_r[l_idx].sfdd007 = l_arr_r[l_idx].sfdd007 - l_sfdd.sfdd007 #剩余待抵退料量
                         LET l_sfdd.sfdd007 = 0  #发料中未退量
                         EXIT FOR
                      ELSE
                         LET l_sfdd.sfdd007 = l_sfdd.sfdd007 - l_arr_r[l_idx].sfdd007  #发料中未退量
                         LET l_arr_r[l_idx].sfdd007 = 0 #剩余待抵退料量
                      END IF
                   END IF  #按发料的批号(tm.issue_type MATCHES '[23]' AND tm.return='Y')
                ELSE
                   IF  l_arr_r[l_idx].sfdc001  = l_sfdd.sfdc001    #工单
                   AND l_arr_r[l_idx].sfdc002  = l_sfdd.sfdc002    #工单项次
                   #AND l_arr_r[l_idx].sfdc003  = l_sfdd.sfdc003    #工单项序  mark发料中做取替代会有问题
                   AND l_arr_r[l_idx].sfdd001  = l_sfdd.sfdd001    #退料料号
                   AND l_arr_r[l_idx].sfdd013  = l_sfdd.sfdd013    #特征
                   AND l_arr_r[l_idx].sfdd003  = l_sfdd.sfdd003    #库位
                   AND l_arr_r[l_idx].sfdd004  = l_sfdd.sfdd004    #储位
                   AND l_arr_r[l_idx].sfdd005  = l_sfdd.sfdd005    #批号
                   AND l_arr_r[l_idx].sfdd010  = l_sfdd.sfdd010    #库存管理特征
                   THEN
                      #计算发料中未退数量l_sfdd.sfdd007，即本次可退量
                      IF l_arr_r[l_idx].sfdd007  >= l_sfdd.sfdd007 THEN
                         #退料数量>本笔发料量
                         LET l_arr_r[l_idx].sfdd007 = l_arr_r[l_idx].sfdd007 - l_sfdd.sfdd007 #剩余待抵退料量
                         LET l_sfdd.sfdd007 = 0  #发料中未退量
                         EXIT FOR
                      ELSE
                         LET l_sfdd.sfdd007 = l_sfdd.sfdd007 - l_arr_r[l_idx].sfdd007  #发料中未退量
                         LET l_arr_r[l_idx].sfdd007 = 0 #剩余待抵退料量
                      END IF
                   END IF  #按tm.issue_type='1'发料的仓储批
                END IF  #是哪种退料方式
            END FOR #发退量互相扣减
         END IF #有已退料的情况
         
         #发料中未退量=0 代表此笔发料资料无料可退
         IF l_sfdd.sfdd007 = 0 THEN
            CONTINUE FOREACH
         END IF
         
         #扣掉全部退料数量后仍有发料量，则产生到单身临时表中
         IF issue_qty1 <= l_sfdd.sfdd007 THEN
            LET l_qty = issue_qty1 #本笔退料量
            LET issue_qty1 = 0     #剩余退料量
            IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
               CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_sfdd.sfdd005,l_inag003,tm.reason,l_qty,'')
            ELSE
               CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,tm.reason,l_qty,'')
            END IF
            RETURN
         ELSE
            LET l_qty = l_sfdd.sfdd007           #本笔退料量
            LET issue_qty1 = issue_qty1 - l_qty  #剩余退料量
            IF tm.issue_type MATCHES '[23]' AND tm.return='Y' THEN
               CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_sfdd.sfdd005,l_inag003,tm.reason,l_qty,'')
            ELSE
               CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_sfdd.sfdd003,l_sfdd.sfdd004,l_sfdd.sfdd005,l_sfdd.sfdd010,tm.reason,l_qty,'')
            END IF
         END IF
      END FOREACH
  
   END IF
   
   IF tm.issue_type MATCHES '[23]' AND tm.return='N' THEN
      CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')
      RETURN
   END IF
      
END FUNCTION

#自动展至库储批
#逐笔找到料号+库位内(或料号+库位+储位内或QBE库存条件)的所有料、库、储、批数据，检查现有库存-在捡量还有余量的
#找到满足工单的需求数为止，
#如果数量不足时，且库存不足乃产生less=Y，则再产生一笔库位、储位、批号都为空白的资料
PRIVATE FUNCTION asft310_01_get_inag(p_inag001,p_inag002,p_inag004,p_inag005,p_inag006,p_inag003,p_inag007)
DEFINE p_inag001   LIKE inag_t.inag001   #料
DEFINE p_inag002   LIKE inag_t.inag002   #产品特征
DEFINE p_inag004   LIKE inag_t.inag004   #仓
DEFINE p_inag005   LIKE inag_t.inag005   #储
DEFINE p_inag006   LIKE inag_t.inag006   #批
DEFINE p_inag003   LIKE inag_t.inag003   #库存管理特征
DEFINE p_inag007   LIKE inag_t.inag007   #目的单位
DEFINE l_inag004   LIKE inag_t.inag004   #仓
DEFINE l_inag005   LIKE inag_t.inag005   #储
DEFINE l_inag006   LIKE inag_t.inag006   #批
DEFINE l_inag003   LIKE inag_t.inag003   #库存管理特征
DEFINE l_place     LIKE type_t.num5
DEFINE l_qty       LIKE sfdc_t.sfdc007
DEFINE l_success   LIKE type_t.num5
DEFINE l_where     STRING
DEFINE l_flag2     LIKE type_t.num5   #s_control使用
DEFINE l_sfaa005   LIKE sfaa_t.sfaa005
DEFINE l_sfaa010   LIKE sfaa_t.sfaa010
DEFINE l_inaa010   LIKE inaa_t.inaa010
DEFINE l_inaa006   LIKE inaa_t.inaa006  #170207-00039#1
DEFINE l_imaf059   LIKE imaf_t.imaf059  #170324-00112#1 add
   IF cl_null(p_inag002) THEN LET p_inag002 = ' ' END IF
   IF cl_null(p_inag004) THEN LET p_inag004 = ' ' END IF
   IF cl_null(p_inag005) THEN LET p_inag005 = ' ' END IF
   IF cl_null(p_inag006) THEN LET p_inag006 = ' ' END IF
   IF cl_null(p_inag003) THEN LET p_inag003 = ' ' END IF
   #170324-00112#1 add(s)
   SELECT imaf059 INTO l_imaf059
     FROM imaf_t
    WHERE imafent = g_enterprise
      AND imafsite = g_site
      AND imaf001 = p_inag001
   IF NOT cl_null(l_imaf059) AND l_imaf059 MATCHES '[123]' THEN
      #抓取aimm212的撿貨策略
      #---1:先進先出(依製造日期) 2:先進先出(依有效日期) 3:後進先出(依製造日期) 4:人工決定
#      LET g_sql = "SELECT inaa006,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inad_t ",  #庫存單位,帳面庫存數量  #170207-00039#1    #170427-00058#1 mark
       #170427-00058#1 add(s)
       LET g_sql = "SELECT inaa006,inag004,inag005,inag006,inag003 ",
                   "  FROM inag_t LEFT JOIN inad_t ON inag004 IS NOT NULL AND inag006 = inad003 ",
                   "              AND inadent = inagent AND inadsite = inagsite ",
                   "              AND inad001 = inag001 AND inad002 = inag002,inaa_t",
       #170427-00058#1 add(e)
                  " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
                  "   AND inagent = ",g_enterprise,
                  "   AND inagsite= '",g_site,"' ",
                  "   AND inag001 = '",p_inag001,"' ",
                  "   AND inag002 = '",p_inag002,"' "
       #170427-00058#1 mark(s)
#                  "   AND inag004 IS NOT NULL AND inag006 = inad003 ",
#                  "   AND inadent = inagent AND inadsite = inagsite ",
#                  "   AND inad001 = inag001 AND inad002 = inag002 "
       #170427-00058#1 mark(e)
   ELSE
   #170324-00112#1 add(e)
   #LET g_sql = "SELECT unique inag004,inag005,inag008 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量
   #LET g_sql = "SELECT unique inag004,inag005,inag006,inag003 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量  #170207-00039#1
      LET g_sql = "SELECT unique inaa006,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t ",  #庫存單位,帳面庫存數量  #170207-00039#1
                  " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
                  "   AND inagent = ",g_enterprise,
                  "   AND inagsite= '",g_site,"' ",
                  "   AND inag001 = '",p_inag001,"' ",
                  "   AND inag002 = '",p_inag002,"' " 
   END IF       #170324-00112#1 add
   IF NOT cl_null(p_inag004) THEN  #库位
      LET g_sql = g_sql CLIPPED," AND inag004 = '",p_inag004,"' "
   END IF
   IF NOT cl_null(p_inag005) THEN  #储位
      LET g_sql = g_sql CLIPPED," AND inag005 = '",p_inag005,"' "
   END IF
   IF NOT cl_null(p_inag006) THEN  #批号
      LET g_sql = g_sql CLIPPED," AND inag006 = '",p_inag006,"' "
   END IF
   IF NOT cl_null(p_inag003) THEN  #库存管理特征
      LET g_sql = g_sql CLIPPED," AND inag003 = '",p_inag003,"' "
   END IF
   #IF tm.issue_type = '3' THEN  #依库存量发料(QBE)
   IF NOT cl_null(tm2.wc) THEN  #和上面一句结果是一样的，1=1不影响结果
      #检查tm2.wc中有没有下inac003的条件
      LET l_place = tm2.wc.getIndexOf("inac003",1)
      IF l_place = 0 THEN
         LET g_sql = g_sql CLIPPED," AND ",tm2.wc CLIPPED
      ELSE
         #170324-00112#1 add(s)
         IF NOT cl_null(l_imaf059) AND l_imaf059 MATCHES '[123]' THEN
#             LET g_sql = "SELECT inaa006,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inac_t,inad_t ",  #库储批+库存管理特征  #170207-00039#1  #170427-00058#1 mark
              #170427-00058#1 add(s)
              LET g_sql = "SELECT inaa006,inag004,inag005,inag006,inag003 ",
                          "  FROM inag_t LEFT JOIN inad_t ON inag004 IS NOT NULL AND inag006 = inad003 ",
                          "              AND inadent = inagent AND inadsite = inagsite ",
                          "              AND inad001 = inag001 AND inad002 = inag002,inaa_t,inac_t ",
              #170427-00058#1 add(e)
                        " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
                        "   AND inagent = inacent AND inagsite = inacsite AND inag004 = inac001 AND inag005 = inac002 ",
                        "   AND inagent = ",g_enterprise,
                        "   AND inagsite='",g_site,"'",
                        "   AND inag001 = '",p_inag001,"' ",
                        "   AND inag002 = '",p_inag002,"' ",
              #170427-00058#1 mark(s)
#                        "   AND inag004 IS NOT NULL AND inag006 = inad003 ",
#                        "   AND inadent = inagent AND inadsite = inagsite ",
#                        "   AND inad001 = inag001 AND inad002 = inag002 ",
              #170427-00058#1 mark(e)
                        "   AND ",tm2.wc CLIPPED
         ELSE
         #170324-00112#1 add(e)
            #LET g_sql = "SELECT unique inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inac_t ",  #库储批+库存管理特征  #170207-00039#1
            LET g_sql = "SELECT unique inaa006,inag004,inag005,inag006,inag003 FROM inag_t,inaa_t,inac_t ",  #库储批+库存管理特征  #170207-00039#1
                        " WHERE inagent = inaaent AND inagsite = inaasite AND inag004 = inaa001",
                        "   AND inagent = inacent AND inagsite = inacsite AND inag004 = inac001 AND inag005 = inac002 ",
                        "   AND inagent = ",g_enterprise,
                        "   AND inagsite='",g_site,"'",
                        "   AND inag001 = '",p_inag001,"' ",
                        "   AND inag002 = '",p_inag002,"' ",
                        "   AND ",tm2.wc CLIPPED
          END IF   #170324-00112#1 add
      END IF
      ##库存管理特征处理 #mark reason若料件库存中仓储批管理特征都管理了，自动展至仓储批时，批、特征等资料没产生出来   原增加此段原因不确定，故先mark
      #LET l_place = tm2.wc.getIndexOf("inag003",1)
      #IF l_place = 0 THEN
      #   LET g_sql = g_sql CLIPPED," AND inag003 = ' ' "
      #END IF
   ELSE
      ##库存管理特征处理 #mark reason若料件库存中仓储批管理特征都管理了，自动展至仓储批时，批、特征等资料没产生出来   原增加此段原因不确定，故先mark
      #IF cl_null(p_inag003) THEN
      #   LET g_sql = g_sql CLIPPED," AND inag003 = ' ' "
      #END IF
   END IF
   
   #关于控制组
   CALL s_control_get_doc_sql("inag004",g_sfdadocno,'6')
        RETURNING l_success,l_where
   IF l_success THEN
      LET g_sql = g_sql CLIPPED," AND ",l_where
   END IF
   #关于控制组--end
   
   #LET g_sql = g_sql CLIPPED," ORDER BY 优先顺序 "
   #170324-00112#1 add(s)
   IF NOT cl_null(l_imaf059) AND l_imaf059 MATCHES '[123]' THEN
      CASE l_imaf059
        WHEN '1' #先進先出(依製造日期)
           LET g_sql = g_sql CLIPPED," ORDER BY inad014,inaa006 "  #170427-00058#1 add inaa006
        WHEN '2' #先進先出(依有效日期)
           LET g_sql = g_sql CLIPPED," ORDER BY inad011,inaa006 "  #170427-00058#1 add inaa006
        WHEN '3' #後進先出(依製造日期)
           LET g_sql = g_sql CLIPPED," ORDER BY inad014 DESC,inaa006 "  #170427-00058#1 add inaa006
      END CASE
   ELSE
   #170324-00112#1 add(e)
      LET g_sql = g_sql CLIPPED," ORDER BY inaa006 "  #170112-00063#1
   END IF  #170324-00112#1 add
   PREPARE asft310_01_get_inag_p FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asft310_01_get_inag_p err'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = FALSE
      FREE asft310_01_get_inag_p
      RETURN
   END IF
   DECLARE asft310_01_get_inag_c CURSOR FOR asft310_01_get_inag_p
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_get_inag_c err'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET g_success = FALSE
      FREE asft310_01_get_inag_p
      RETURN
   END IF
   #FOREACH asft310_01_get_inag_c INTO l_inag004,l_inag005,l_inag006,l_inag003  #170207-00039#1
   FOREACH asft310_01_get_inag_c INTO l_inaa006,l_inag004,l_inag005,l_inag006,l_inag003  #170207-00039#1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_get_inag_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #控制组检查
      IF NOT cl_null(l_inag004) THEN
         #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
         CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,'','','','')
            RETURNING l_success,l_flag2
         IF NOT l_success OR NOT l_flag2 THEN
            #控制组检查错误,请检查单别设定的相关内容
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00122'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            CONTINUE FOREACH
         END IF
      END IF
      IF NOT cl_null(l_inag004) AND NOT cl_null(l_inag005) THEN
         #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
         CALL s_control_chk_doc('6',g_sfdadocno,l_inag004,l_inag005,'','','')
            RETURNING l_success,l_flag2
         IF NOT l_success OR NOT l_flag2 THEN
            #控制组检查错误,请检查单别设定的相关内容
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00122'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            CONTINUE FOREACH
         END IF
      END IF
      #控制组检查--end
      #add by lixh 20151109
      SELECT sfaa005,sfaa010 INTO l_sfaa005,l_sfaa010 FROM sfaa_t
       WHERE sfaaent = g_enterprise
         AND sfaadocno = g_sfba.sfbadocno
      IF l_sfaa005 = '5' AND l_sfaa010 = p_inag001 THEN
         #檢查倉庫是否未非成本倉
         LET l_inaa010 = ''
         SELECT inaa010 INTO l_inaa010 FROM inaa_t
          WHERE inaaent = g_enterprise
            AND inaasite = g_site
            AND inaa001 = l_inag004
         IF l_inaa010 <> 'N' THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'arm-00011'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
            CONTINUE FOREACH
         END IF                     
      END IF      
      #add by lixh 20151109
      #库存可用量
      CALL asft310_01_get_available_qty('a',0,p_inag001,p_inag002,p_inag007,l_inag004,l_inag005,l_inag006,l_inag003)
         RETURNING l_qty
         
      IF issue_qty1 <= l_qty THEN
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,issue_qty1,'')   #有足量供给需求，产生发料需求明细 库位\储位\批号\数量
         LET issue_qty1 = 0
         EXIT FOREACH
      ELSE
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,'')   #非足量供给需求，有库存的 产生发料需求明细 库位\储位\批号\数量
         LET issue_qty1 = issue_qty1 - l_qty
      END IF
   END FOREACH
   FREE asft310_01_get_inag_p
   
   IF issue_qty1>0 AND tm.less = 'Y' THEN   #库存不足乃产生
      #170516-00063#1-s
      ##IF tm.issue_type = '3' THEN  #依库存量发料(QBE)--不足部分产生仓储批为空白的资料  # 141219-00017需求
      #   CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',' ',' ',' ',' ',tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量
      ##ELSE  #依预设或指定的仓储批发料--不足部分产生仓储批为预设或指定的仓储批 # 141219-00017需求
      ##   CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',p_inag004,p_inag005,p_inag006,p_inag003,tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量  #141219-00017需求
      ##END IF  #141219-00017需求
      CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',p_inag004,p_inag005,p_inag006,p_inag003,tm.reason,issue_qty1,'')   #非足量供给需求，不够部分 产生发料需求明细 库位\储位\批号\数量  #141219-00017需求
      #170516-00063#1-e
      LET issue_qty1 = 0
   END IF
END FUNCTION
################################################################################
# Descriptions...: 检查申请数量——对库存足量否的检查
################################################################################
PRIVATE FUNCTION asft310_01_chk_sfdc007_2(p_cmd,p_sfdcseq,p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc007,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016)
DEFINE p_cmd            LIKE type_t.chr1
DEFINE p_sfdcseq        LIKE sfdc_t.sfdcseq  #项次
DEFINE p_sfdc004        LIKE sfdc_t.sfdc004  #料
DEFINE p_sfdc005        LIKE sfdc_t.sfdc005  #特徵
DEFINE p_sfdc006        LIKE sfdc_t.sfdc006  #单位
DEFINE p_sfdc007        LIKE sfdc_t.sfdc007  #数量
DEFINE p_sfdc012        LIKE sfdc_t.sfdc012  #仓
DEFINE p_sfdc013        LIKE sfdc_t.sfdc013  #储
DEFINE p_sfdc014        LIKE sfdc_t.sfdc014  #批
DEFINE p_sfdc016        LIKE sfdc_t.sfdc016  #库存管理特征
DEFINE r_success   LIKE type_t.num5
DEFINE l_qty            LIKE sfdc_t.sfdc007  #可发量

   LET r_success = TRUE 
   
   #料，仓库，数量为空不检查
   IF cl_null(p_sfdc004) OR cl_null(p_sfdc012) OR cl_null(p_sfdc007) OR p_sfdc007=0 THEN
      RETURN r_success
   END IF

   #退料不需检查库存足量
   IF g_prog[1,6]='asft32' THEN
      RETURN r_success
   END IF

   #库存可用数量
   CALL asft310_01_get_available_qty(p_cmd,p_sfdcseq,p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016)
       RETURNING l_qty
       
   IF p_sfdc007  > l_qty THEN  
      #不可超过库存可发数量1%,请重新输入！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00083'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_qty
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# 插入需求单身sfdc_t 或 临时表单身asft310_01_sfdc_t
################################################################################
PRIVATE FUNCTION asft310_01_ins_sfdc(p_table,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016,p_sfdc015,p_sfdc007,p_inag002)
DEFINE p_table       LIKE type_t.chr20     #目的表sfdc_t 或 asft310_01_sfdc_t
DEFINE p_sfdc012     LIKE sfdc_t.sfdc012   #库位
DEFINE p_sfdc013     LIKE sfdc_t.sfdc013   #储位
DEFINE p_sfdc014     LIKE sfdc_t.sfdc014   #批号
DEFINE p_sfdc016     LIKE sfdc_t.sfdc016   #库存管理特征
DEFINE p_sfdc015     LIKE sfdc_t.sfdc015   #理由码
DEFINE p_sfdc007     LIKE sfdc_t.sfdc007   #申请数量
DEFINE p_inag002     LIKE inag_t.inag002   #产品特征 141203 add在特征管理料件工单备料没指定特征时使用
#161205-00025#6-s
##161109-00085#30-s
##DEFINE l_sfdc       RECORD LIKE sfdc_t.*
##DEFINE l_sfdc_t     RECORD LIKE sfdc_t.*
#DEFINE l_sfdc RECORD  #發退料需求檔
#       sfdcent LIKE sfdc_t.sfdcent, #企業編號
#       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
#       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
#       sfdcseq LIKE sfdc_t.sfdcseq, #項次
#       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
#       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
#       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
#       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
#       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
#       sfdc006 LIKE sfdc_t.sfdc006, #單位
#       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
#       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
#       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
#       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
#       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
#       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
#       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
#       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
#       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
#       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
#      #sfdc017 LIKE sfdc_t.sfdc017, #正負 #161109-00085#62 mark
#       #161109-00085#62 --s add
#       sfdc017 LIKE sfdc_t.sfdc017, #正負
#       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
#       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
#       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
#       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
#       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
#       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
#       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
#       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
#       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
#       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
#       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
#       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
#       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
#       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
#       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
#       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
#       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
#       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
#       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
#       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
#       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
#       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
#       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
#       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
#       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
#       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
#       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
#       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
#       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
#       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
#       #161109-00085#62 --e add
#END RECORD
#DEFINE l_sfdc_t RECORD  #發退料需求檔
#       sfdcent LIKE sfdc_t.sfdcent, #企業編號
#       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
#       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
#       sfdcseq LIKE sfdc_t.sfdcseq, #項次
#       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
#       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
#       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
#       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
#       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
#       sfdc006 LIKE sfdc_t.sfdc006, #單位
#       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
#       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
#       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
#       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
#       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
#       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
#       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
#       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
#       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
#       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
#      #sfdc017 LIKE sfdc_t.sfdc017, #正負 #161109-00085#62 mark
#       #161109-00085#62 --s add
#       sfdc017 LIKE sfdc_t.sfdc017, #正負
#       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
#       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
#       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
#       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
#       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
#       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
#       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
#       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
#       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
#       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
#       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
#       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
#       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
#       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
#       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
#       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
#       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
#       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
#       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
#       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
#       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
#       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
#       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
#       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
#       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
#       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
#       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
#       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
#       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
#       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
#       #161109-00085#62 --e add
#END RECORD
##161109-00085#30-e
DEFINE l_sfdc RECORD  #發退料需求檔
    sfdcent    LIKE sfdc_t.sfdcent,    #企業編號
    sfdcsite   LIKE sfdc_t.sfdcsite,   #營運據點
    sfdcdocno  LIKE sfdc_t.sfdcdocno,  #發退料單號
    sfdcseq    LIKE sfdc_t.sfdcseq,    #項次
    sfdc001    LIKE sfdc_t.sfdc001,    #工單單號
    sfdc002    LIKE sfdc_t.sfdc002,    #工單項次
    sfdc003    LIKE sfdc_t.sfdc003,    #工單項序
    sfdc004    LIKE sfdc_t.sfdc004,    #需求料號
    sfdc005    LIKE sfdc_t.sfdc005,    #產品特徵
    sfdc006    LIKE sfdc_t.sfdc006,    #單位
    sfdc007    LIKE sfdc_t.sfdc007,    #申請數量
    sfdc008    LIKE sfdc_t.sfdc008,    #實際數量
    sfdc009    LIKE sfdc_t.sfdc009,    #參考單位
    sfdc010    LIKE sfdc_t.sfdc010,    #參考單位需求數量
    sfdc011    LIKE sfdc_t.sfdc011,    #參考單位實際數量
    sfdc012    LIKE sfdc_t.sfdc012,    #指定庫位
    sfdc013    LIKE sfdc_t.sfdc013,    #指定儲位
    sfdc014    LIKE sfdc_t.sfdc014,    #指定批號
    sfdc015    LIKE sfdc_t.sfdc015,    #理由碼
    sfdc016    LIKE sfdc_t.sfdc016,    #庫存管理特徴
    sfdc017    LIKE sfdc_t.sfdc017     #正負
END RECORD
#161205-00025#6-e
DEFINE l_sfdcseq     LIKE sfdc_t.sfdcseq   #临时表key值
DEFINE l_cnt         LIKE type_t.num5
DEFINE l_rate        LIKE inaj_t.inaj014   #单位换算率
DEFINE l_sfdc004     LIKE sfdc_t.sfdc004   #需求料号
DEFINE l_sfdc005     LIKE sfdc_t.sfdc005   #特征
DEFINE l_sfdc006     LIKE sfdc_t.sfdc006   #单位
DEFINE l_sfdc009     LIKE sfdc_t.sfdc009   #参考单位
DEFINE l_sfdc010     LIKE sfdc_t.sfdc010   #参考单位数量
#add by lixh 20151109
DEFINE l_sfaa005     LIKE sfaa_t.sfaa005
DEFINE l_sfaa010     LIKE sfaa_t.sfaa010
DEFINE l_inaa010     LIKE inaa_t.inaa010
DEFINE l_sfdc001     LIKE sfdc_t.sfdc001
#add by lixh 20151109

   IF cl_null(p_sfdc007) OR p_sfdc007 = 0 THEN
      RETURN
   END IF
   IF cl_null(p_sfdc012) THEN LET p_sfdc012 = ' ' END IF
   IF cl_null(p_sfdc013) THEN LET p_sfdc013 = ' ' END IF
   IF cl_null(p_sfdc014) THEN LET p_sfdc014 = ' ' END IF
   IF cl_null(p_sfdc016) THEN LET p_sfdc016 = ' ' END IF
   
   #检查单身是否已存在相同发料资料，若有则叠加，若无则新增
   #LET g_sql = "SELECT sfdcseq,sfdc004,sfdc005,sfdc006,sfdc009 ",
   LET g_sql = "SELECT sfdcseq,sfdc001,sfdc004,sfdc005,sfdc006,sfdc009 ",    #add by lixh 20151109
               "  FROM ",p_table,  #asft310_01_sfdc_t
               " WHERE sfdcent  = ",g_enterprise,
               "   AND sfdcdocno= '",g_sfdadocno,"' ",
               "   AND sfdc001  = '",g_sfba.sfbadocno,"' ",   #工单单号
               "   AND sfdc002  = ",g_sfba.sfbaseq,           #工单项次
               "   AND sfdc003  = ",g_sfba.sfbaseq1,          #工单项序
               "   AND sfdc012  = '",p_sfdc012,"' ",    #指定库位
               "   AND sfdc013  = '",p_sfdc013,"' ",    #指定储位
               "   AND sfdc014  = '",p_sfdc014,"' ",    #指定批号
               "   AND sfdc016  = '",p_sfdc016,"' "     #库存管理特征
   IF NOT cl_null(p_inag002) THEN
      LET g_sql = g_sql CLIPPED," AND sfdc005  = '",p_inag002,"' "  #产品特征 add 141208 若工单不指定在发料单指定时需要判别
   END IF
   IF cl_null(p_sfdc015) THEN
      LET g_sql = g_sql CLIPPED," AND sfdc015 IS NULL "     #理由码
   ELSE
      LET g_sql = g_sql CLIPPED," AND sfdc015  = '",p_sfdc015,"' "     #理由码
   END IF
   DECLARE asft310_01_ins_sfdc_c1 SCROLL CURSOR FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_ins_sfdc_c1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      RETURN
   END IF
   OPEN asft310_01_ins_sfdc_c1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'open asft310_01_ins_sfdc_c1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      RETURN
   END IF
   FETCH FIRST asft310_01_ins_sfdc_c1 INTO l_sfdcseq,l_sfdc001,l_sfdc004,l_sfdc005,l_sfdc006,l_sfdc009   #add by lixh 20151109
   CLOSE asft310_01_ins_sfdc_c1
   
   #add by lixh 20151109
   #是否可以為非成本倉
   SELECT sfaa005,sfaa010 INTO l_sfaa005,l_sfaa010 FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno = g_sfba.sfbadocno
   IF l_sfaa005 = '5' AND l_sfaa010 = l_sfdc004 THEN
      #檢查倉庫是否未非成本倉
      LET l_inaa010 = ''
      SELECT inaa010 INTO l_inaa010 FROM inaa_t
       WHERE inaaent = g_enterprise
         AND inaasite = g_site
         AND inaa001 = p_sfdc012
      IF l_inaa010 <> 'N' THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = 'arm-00011'
#         LET g_errparam.extend = ''
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET g_success = FALSE
#         RETURN
         LET p_sfdc012 = ' '
         LET p_sfdc013 = ' '
         LET p_sfdc014 = ' '
      END IF                     
   END IF
   #add by lixh 20151109
   IF NOT cl_null(l_sfdcseq) AND l_sfdcseq > 0 THEN
      IF NOT cl_null(l_sfdc009) THEN
         #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
         #mark 150101
         #CALL s_aimi190_get_convert(l_sfdc004,l_sfdc006,l_sfdc009) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdc010 = p_sfdc007 * l_rate
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(l_sfdc004,l_sfdc006,l_sfdc009,p_sfdc007) RETURNING l_success,l_sfdc010
         IF NOT l_success THEN
            LET l_sfdc010 = p_sfdc007
         END IF
         #add 150101 end
      ELSE
         LET l_sfdc010 = 0
      END IF

      LET g_sql = "UPDATE ",p_table,  #asft310_01_sfdc_t,sfdc_t
                  "   SET sfdc007 = sfdc007 + ",p_sfdc007,",",  #申请数量
                  "       sfdc008 = sfdc008 + ",p_sfdc007,",",  #實際數量  #160408-00035#6 add
                  "       sfdc010 = sfdc010 + ",l_sfdc010,      #参考单位需求数量
                  " WHERE sfdcent  = ",g_enterprise,
                  "   AND sfdcdocno= '",g_sfdadocno,"' ",
                  "   AND sfdcseq  = ",l_sfdcseq
      PREPARE asft310_01_ins_sfdc_p3 FROM g_sql
      EXECUTE asft310_01_ins_sfdc_p3
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'update sfdc'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         RETURN
      END IF
      FREE asft310_01_ins_sfdc_p3
      LET g_count = g_count + 1  #add 141226
      
      #如果是实体表的需同步sfde。另因sfdc只更新了需求申请数量，不涉及实际发料数量的变化，故sfdd、sfdf不做变化
      IF p_table = 'sfdc_t' THEN
         #发料单：将发料需求单身相同的需求料号+特征+单位+参考单位+客供料汇总到同一笔资料
         #退料单：将退料需求单身相同的需求料号+特征+单位+参考单位汇总到同一笔数据
         LET g_sql = " UPDATE sfde_t SET sfde004 = sfde004 + ",p_sfdc007,",",  #申請數量
                     "                   sfde005 = sfde005 + ",p_sfdc007,",",  #實際數量  #160408-00035#6 add
                     "                   sfde007 = sfde007 + ",l_sfdc010,      #參考單位申請數量
                     " WHERE sfdeent  = ",g_enterprise,
                     "   AND sfdedocno= '",g_sfdadocno,"' ",
                     "   AND sfde001  = '",l_sfdc004,"' ",  #需求料号
                     "   AND sfde002  = '",l_sfdc005,"' ",  #特征
                     "   AND sfde003  = '",l_sfdc006,"' "   #单位
                     #"   AND sfde006  = '",l_sfdc009,"' "   #参考单位

         IF l_sfdc009 IS NULL THEN
            LET g_sql = g_sql CLIPPED," AND sfde006 IS NULL "
         ELSE
            LET g_sql = g_sql CLIPPED," AND sfde006 = '",l_sfdc009,"' "
         END IF 
         IF g_prog[1,6] = 'asft31' THEN  #退料不记录客供料
            #LET g_sql = g_sql CLIPPED," AND sfde009  = '",g_sfba.sfba028,"' "  #客供料
            IF g_sfba.sfba028 IS NULL THEN
               LET g_sql = g_sql CLIPPED," AND sfde009 IS NULL "
            ELSE
               LET g_sql = g_sql CLIPPED," AND sfde009  = '",g_sfba.sfba028,"' "  #客供料
            END IF
         END IF
         PREPARE asft310_01_ins_sfdc_p4 FROM g_sql
         EXECUTE asft310_01_ins_sfdc_p4
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'update sfde'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET g_success = FALSE
            RETURN
         END IF
         FREE asft310_01_ins_sfdc_p4
         
#160408-00035#6 add str
         LET g_sql = " UPDATE sfdf_t SET sfdf007 = sfdf007 + ",p_sfdc007,", ",
                     "                   sfdf009 = sfdf009 + ",l_sfdc010,
                     "  WHERE sfdfent  = ",g_enterprise,
                     "    AND sfdfdocno= '",g_sfdadocno,"' ",  #發退料單號
                     "    AND sfdfseq  = ",l_sfdcseq,          #項次
                     "    AND sfdf003  = '",p_sfdc012,"' ",    #庫位
                     "    AND sfdf004  = '",p_sfdc013,"' ",    #儲位
                     "    AND sfdf005  = '",p_sfdc014,"' ",    #批號
                     "    AND sfdf010  = '",p_sfdc016,"' ",    #库存管理特征
                     "    AND sfdf001  = '",l_sfdc004,"' ",    #发料料号
                     "    AND sfdf013  = '",l_sfdc005,"' ",    #产品特征
                     "    AND sfdf006  = '",l_sfdc006,"' "     #单位                     
         IF l_sfdc009 IS NULL THEN
            LET g_sql = g_sql CLIPPED," AND sfdf008 IS NULL "
         ELSE
            LET g_sql = g_sql CLIPPED," AND sfdf008 = '",l_sfdc009,"' "
         END IF
         PREPARE asft310_01_ins_sfdc_p5 FROM g_sql
         EXECUTE asft310_01_ins_sfdc_p5
         IF SQLCA.sqlcode THEN
            #自动更新發退料倉儲批匯總檔(sfdf_t)失败，请检查是否有重复数据
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00124'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            LET g_success = FALSE
            RETURN
         END IF
         FREE asft310_01_ins_sfdc_p5
         
         LET g_sql = " UPDATE sfdd_t SET sfdd007 = sfdd007 + ",p_sfdc007,", ",
                     "                   sfdd009 = sfdd009 + ",l_sfdc010,
                     "  WHERE sfddent  = ",g_enterprise,
                     "    AND sfdddocno= '",g_sfdadocno,"' ",  #發退料單號
                     "    AND sfddseq  = ",l_sfdcseq,          #項次
                     "    AND sfdd003  = '",p_sfdc012,"' ",    #庫位
                     "    AND sfdd004  = '",p_sfdc013,"' ",    #儲位
                     "    AND sfdd005  = '",p_sfdc014,"' ",    #批號
                     "    AND sfdd010  = '",p_sfdc016,"' ",    #库存管理特征
                     "    AND sfdd001  = '",l_sfdc004,"' ",    #发料料号
                     "    AND sfdd013  = '",l_sfdc005,"' ",    #产品特征
                     "    AND sfdd006  = '",l_sfdc006,"' "     #单位                     
         IF l_sfdc009 IS NULL THEN
            LET g_sql = g_sql CLIPPED," AND sfdd008 IS NULL "
         ELSE
            LET g_sql = g_sql CLIPPED," AND sfdd008 = '",l_sfdc009,"' "
         END IF
         PREPARE asft310_01_ins_sfdc_p6 FROM g_sql
         EXECUTE asft310_01_ins_sfdc_p6
         IF SQLCA.sqlcode THEN
            #自动更新發退料倉儲批匯總檔(sfdf_t)失败，请检查是否有重复数据
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'update sfdd'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
      
            LET g_success = FALSE
            RETURN
         END IF
         FREE asft310_01_ins_sfdc_p6
#160408-00035#6 add end         
      END IF
   ELSE
      LET l_sfdc.sfdcent   = g_enterprise
      LET l_sfdc.sfdcsite  = g_site
      LET l_sfdc.sfdcdocno = g_sfdadocno    #发料单号
      
      LET g_sql = "SELECT MAX(sfdcseq)+1 ",  #临时表项次
                  "  FROM ",p_table,  #asft310_01_sfdc_t
                  " WHERE sfdcent  = ",g_enterprise,
                  "   AND sfdcdocno= '",g_sfdadocno,"' "
      PREPARE asft310_01_ins_sfdc_p2 FROM g_sql
      EXECUTE asft310_01_ins_sfdc_p2 INTO l_sfdc.sfdcseq
      IF cl_null(l_sfdc.sfdcseq) THEN LET l_sfdc.sfdcseq = 1 END IF
      FREE asft310_01_ins_sfdc_p2
      
      LET l_sfdc.sfdc001 = g_sfba.sfbadocno  #工单单号
      LET l_sfdc.sfdc002 = g_sfba.sfbaseq    #工单项次
      LET l_sfdc.sfdc003 = g_sfba.sfbaseq1   #工单项序
      LET l_sfdc.sfdc004 = g_sfba.sfba006    #需求料号
      IF NOT cl_null(p_inag002) THEN
         LET l_sfdc.sfdc005 = p_inag002    #特征
      ELSE
         LET l_sfdc.sfdc005 = g_sfba.sfba021    #特征
      END IF
      IF cl_null(l_sfdc.sfdc005) THEN LET l_sfdc.sfdc005 = ' ' END IF
      LET l_sfdc.sfdc006 = g_sfba.sfba014    #单位
      LET l_sfdc.sfdc007 = p_sfdc007          #申请数量
      LET l_sfdc.sfdc008 = l_sfdc.sfdc007     #实际数量
      SELECT imaf015 INTO l_sfdc.sfdc009      #参考单位
        FROM imaf_t
       WHERE imafent = g_enterprise
         AND imafsite= g_site
         AND imaf001 = l_sfdc.sfdc004
      IF cl_null(l_sfdc.sfdc009) THEN
         LET l_sfdc.sfdc010 = 0       #参考单位需求数量
         LET l_sfdc.sfdc011 = 0       #参考单位实际数量
      ELSE
         #参考单位申请数量=申请数量经过转换率换算为参考单位的数量
         #mark 150101
         #CALL s_aimi190_get_convert(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdc.sfdc010 = l_sfdc.sfdc007 * l_rate
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(l_sfdc.sfdc004,l_sfdc.sfdc006,l_sfdc.sfdc009,l_sfdc.sfdc007)
            RETURNING l_success,l_sfdc.sfdc010
         IF NOT l_success THEN
            LET l_sfdc.sfdc010 = l_sfdc.sfdc007
         END IF
         #add 150101 end
         LET l_sfdc.sfdc008 = l_sfdc.sfdc007       #实际数量  #160408-00035#6 add
         LET l_sfdc.sfdc011 = l_sfdc.sfdc010       #参考单位实际数量
      END IF
      LET l_sfdc.sfdc012 = p_sfdc012         #指定库位
      LET l_sfdc.sfdc013 = p_sfdc013         #指定储位
      LET l_sfdc.sfdc014 = p_sfdc014         #指定批号
      LET l_sfdc.sfdc015 = p_sfdc015         #理由码
      LET l_sfdc.sfdc016 = p_sfdc016         #库存管理特征
      IF g_prog[1,6]='asft31' THEN
         LET l_sfdc.sfdc017 = -1                #正负 发料为-1
      END IF
      IF g_prog[1,6]='asft32' THEN
         LET l_sfdc.sfdc017 =  1                #正负 退料为1
      END IF
      #add 141211 发料单若没有库位，则产生到申请页签时实际数量为0
      IF p_table = 'sfdc_t' AND cl_null(p_sfdc012) AND g_sfda.sfda002[1,1]='1' THEN
         LET l_sfdc.sfdc008 = 0
         LET l_sfdc.sfdc011 = 0
      END IF
      #add 141211 end
      #150115 add  单位取位
      CALL s_aooi250_get_msg(l_sfdc.sfdc006) RETURNING l_success,g_ooca002,g_ooca004
      IF l_success THEN
         #151118-00016 by whitney modify start g_ooca004-->'4'
         CALL s_num_round('4',l_sfdc.sfdc007,g_ooca002) RETURNING l_sfdc.sfdc007
         CALL s_num_round('4',l_sfdc.sfdc008,g_ooca002) RETURNING l_sfdc.sfdc008
         #151118-00016 by whitney modify end
      END IF
      IF NOT cl_null(l_sfdc.sfdc009) THEN
         CALL s_aooi250_get_msg(l_sfdc.sfdc009) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            #151118-00016 by whitney modify start g_ooca004-->'4'
            CALL s_num_round('4',l_sfdc.sfdc010,g_ooca002) RETURNING l_sfdc.sfdc010
            CALL s_num_round('4',l_sfdc.sfdc011,g_ooca002) RETURNING l_sfdc.sfdc011
            #151118-00016 by whitney modify end
         END IF
      END IF
      #150115 add end

      CASE p_table
         WHEN 'asft310_01_sfdc_t'
              #161205-00025#6-s
              ##161109-00085#30-s    
              ##INSERT INTO asft310_01_sfdc_t VALUES (l_sfdc.*)
              ##161109-00085#62 --s mark
              ##INSERT INTO asft310_01_sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
              ##                              sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
              ##                              sfdc017) 
              ##VALUES (l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
              ##        l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
              ##        l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
              ##        l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
              ##        l_sfdc.sfdc017)
              ##161109-00085#62 --e mark
              ##161109-00085#30-e
              ##161109-00085#62 --s add
              #INSERT INTO asft310_01_sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
              #                              sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
              #                              sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
              #                              sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
              #                              sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
              #                              sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
              #                              sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
              #                              sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
              #                              sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
              #                              sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
              #                              sfdcud030) 
              #VALUES (l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
              #        l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
              #        l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
              #        l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
              #        l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
              #        l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
              #        l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
              #        l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
              #        l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
              #        l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
              #        l_sfdc.sfdcud030)
              ##161109-00085#62 --e add
              EXECUTE ins_asft310_01_sfdc_t_p
                USING l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
                      l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
                      l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
                      l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
                      l_sfdc.sfdc017
              #161205-00025#6-e
              IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'update'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_success = FALSE
                 RETURN
              END IF
              LET g_count = g_count + 1  #add 141226
         WHEN 'sfdc_t'
              #161205-00025#6-s
              ##161109-00085#30-s
              ##INSERT INTO sfdc_t VALUES (l_sfdc.*)
              ##161109-00085#62 --s mark
              ##INSERT INTO sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
              ##                   sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
              ##                   sfdc017) 
              ##VALUES (l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
              ##        l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
              ##        l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
              ##        l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
              ##        l_sfdc.sfdc017)
              ##161109-00085#62 --e mark
              ##161109-00085#62 --s add
              #INSERT INTO sfdc_t(sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,
              #                   sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,
              #                   sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,
              #                   sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,
              #                   sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,
              #                   sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009,
              #                   sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014,
              #                   sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019,
              #                   sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024,
              #                   sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029,
              #                   sfdcud030)
              #VALUES (l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
              #        l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
              #        l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
              #        l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
              #        l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
              #        l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
              #        l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
              #        l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
              #        l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
              #        l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
              #        l_sfdc.sfdcud030)
              ##161109-00085#62 --e add
              ##161109-00085#30-e
              EXECUTE ins_sfdc_t_p
                USING l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
                      l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
                      l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
                      l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
                      l_sfdc.sfdc017
              #161205-00025#6-e
              IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'update'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_success = FALSE
                 RETURN
              END IF
              #同步新增sfdd
              CALL s_asft310_chg_sfdd_f_sfdc_ins(l_sfdc.sfdcdocno,l_sfdc.sfdcseq) RETURNING l_success
              IF NOT l_success THEN
                 LET g_success = FALSE
                 RETURN
              END IF
              #新增或更新sfde('Y'代表新增或更新sfdf) 
              CALL s_asft310_chg_sfde_f_sfdc_ins(l_sfdc.sfdcdocno,l_sfdc.sfdcseq,'Y') RETURNING l_success
              IF NOT l_success THEN
                 LET g_success = FALSE
                 RETURN
              END IF
      END CASE
   END IF
END FUNCTION
#由临时表产生至发料需求档sfdc_t
PRIVATE FUNCTION asft310_01_gen()
#161205-00025#6-s
##DEFINE l_sfdc       RECORD LIKE sfdc_t.* #161109-00085#62 mark
##161109-00085#62 --s add
#DEFINE l_sfdc RECORD  #發退料需求檔
#       sfdcent LIKE sfdc_t.sfdcent, #企業編號
#       sfdcsite LIKE sfdc_t.sfdcsite, #營運據點
#       sfdcdocno LIKE sfdc_t.sfdcdocno, #發退料單號
#       sfdcseq LIKE sfdc_t.sfdcseq, #項次
#       sfdc001 LIKE sfdc_t.sfdc001, #工單單號
#       sfdc002 LIKE sfdc_t.sfdc002, #工單項次
#       sfdc003 LIKE sfdc_t.sfdc003, #工單項序
#       sfdc004 LIKE sfdc_t.sfdc004, #需求料號
#       sfdc005 LIKE sfdc_t.sfdc005, #產品特徵
#       sfdc006 LIKE sfdc_t.sfdc006, #單位
#       sfdc007 LIKE sfdc_t.sfdc007, #申請數量
#       sfdc008 LIKE sfdc_t.sfdc008, #實際數量
#       sfdc009 LIKE sfdc_t.sfdc009, #參考單位
#       sfdc010 LIKE sfdc_t.sfdc010, #參考單位需求數量
#       sfdc011 LIKE sfdc_t.sfdc011, #參考單位實際數量
#       sfdc012 LIKE sfdc_t.sfdc012, #指定庫位
#       sfdc013 LIKE sfdc_t.sfdc013, #指定儲位
#       sfdc014 LIKE sfdc_t.sfdc014, #指定批號
#       sfdc015 LIKE sfdc_t.sfdc015, #理由碼
#       sfdc016 LIKE sfdc_t.sfdc016, #庫存管理特徴
#       sfdc017 LIKE sfdc_t.sfdc017, #正負
#       sfdcud001 LIKE sfdc_t.sfdcud001, #自定義欄位(文字)001
#       sfdcud002 LIKE sfdc_t.sfdcud002, #自定義欄位(文字)002
#       sfdcud003 LIKE sfdc_t.sfdcud003, #自定義欄位(文字)003
#       sfdcud004 LIKE sfdc_t.sfdcud004, #自定義欄位(文字)004
#       sfdcud005 LIKE sfdc_t.sfdcud005, #自定義欄位(文字)005
#       sfdcud006 LIKE sfdc_t.sfdcud006, #自定義欄位(文字)006
#       sfdcud007 LIKE sfdc_t.sfdcud007, #自定義欄位(文字)007
#       sfdcud008 LIKE sfdc_t.sfdcud008, #自定義欄位(文字)008
#       sfdcud009 LIKE sfdc_t.sfdcud009, #自定義欄位(文字)009
#       sfdcud010 LIKE sfdc_t.sfdcud010, #自定義欄位(文字)010
#       sfdcud011 LIKE sfdc_t.sfdcud011, #自定義欄位(數字)011
#       sfdcud012 LIKE sfdc_t.sfdcud012, #自定義欄位(數字)012
#       sfdcud013 LIKE sfdc_t.sfdcud013, #自定義欄位(數字)013
#       sfdcud014 LIKE sfdc_t.sfdcud014, #自定義欄位(數字)014
#       sfdcud015 LIKE sfdc_t.sfdcud015, #自定義欄位(數字)015
#       sfdcud016 LIKE sfdc_t.sfdcud016, #自定義欄位(數字)016
#       sfdcud017 LIKE sfdc_t.sfdcud017, #自定義欄位(數字)017
#       sfdcud018 LIKE sfdc_t.sfdcud018, #自定義欄位(數字)018
#       sfdcud019 LIKE sfdc_t.sfdcud019, #自定義欄位(數字)019
#       sfdcud020 LIKE sfdc_t.sfdcud020, #自定義欄位(數字)020
#       sfdcud021 LIKE sfdc_t.sfdcud021, #自定義欄位(日期時間)021
#       sfdcud022 LIKE sfdc_t.sfdcud022, #自定義欄位(日期時間)022
#       sfdcud023 LIKE sfdc_t.sfdcud023, #自定義欄位(日期時間)023
#       sfdcud024 LIKE sfdc_t.sfdcud024, #自定義欄位(日期時間)024
#       sfdcud025 LIKE sfdc_t.sfdcud025, #自定義欄位(日期時間)025
#       sfdcud026 LIKE sfdc_t.sfdcud026, #自定義欄位(日期時間)026
#       sfdcud027 LIKE sfdc_t.sfdcud027, #自定義欄位(日期時間)027
#       sfdcud028 LIKE sfdc_t.sfdcud028, #自定義欄位(日期時間)028
#       sfdcud029 LIKE sfdc_t.sfdcud029, #自定義欄位(日期時間)029
#       sfdcud030 LIKE sfdc_t.sfdcud030  #自定義欄位(日期時間)030
#END RECORD
##161109-00085#62 --e add
DEFINE l_sfdc  RECORD  #發退料需求檔
    sfdc001    LIKE sfdc_t.sfdc001,  #工單單號
    sfdc002    LIKE sfdc_t.sfdc002,  #工單項次
    sfdc003    LIKE sfdc_t.sfdc003,  #工單項序
    sfdc004    LIKE sfdc_t.sfdc004,  #需求料號
    sfdc005    LIKE sfdc_t.sfdc005,  #產品特徵
    sfdc007    LIKE sfdc_t.sfdc007,  #申請數量
    sfdc012    LIKE sfdc_t.sfdc012,  #指定庫位
    sfdc013    LIKE sfdc_t.sfdc013,  #指定儲位
    sfdc014    LIKE sfdc_t.sfdc014,  #指定批號
    sfdc015    LIKE sfdc_t.sfdc015,  #理由碼
    sfdc016    LIKE sfdc_t.sfdc016   #庫存管理特徴
END RECORD
#161205-00025#6-e
#add by lixh 20151109
DEFINE l_sfaa005     LIKE sfaa_t.sfaa005   
DEFINE l_sfaa010     LIKE sfaa_t.sfaa010  
DEFINE l_inaa010     LIKE inaa_t.inaa010
#add by lixh 20151109   

   #将有指定库位的资料产生到需求页签
   #161205-00025#6-s
   ##mod 141211
   ##LET g_sql = "SELECT * FROM asft310_01_sfdc_t WHERE sfdc012 IS NOT NULL AND sfdc012 != ' ' "
   #IF g_sfda.sfda002[1,1]='1' THEN #發料單
   #   #LET g_sql = "SELECT * FROM asft310_01_sfdc_t ORDER BY sfdc001,sfdc002,sfdc003" #库位为空的产生出来  #20151109 DSC.liquor add ORDER BY sfdc001,sfdc002,sfdc003 #161109-00085#62 mark
   #   #161109-00085#62 --s add
   #   LET g_sql = " SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,        ",
   #               "        sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,           ",
   #               "        sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,           ",
   #               "        sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,           ",
   #               "        sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,   ",
   #               "        sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009, ",
   #               "        sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014, ",
   #               "        sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019, ",
   #               "        sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024, ",
   #               "        sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029, ",
   #               "        sfdcud030  ",
   #               " FROM asft310_01_sfdc_t ORDER BY sfdc001,sfdc002,sfdc003" 
   #   #161109-00085#62 --e add
   #ELSE
   #   #LET g_sql = "SELECT * FROM asft310_01_sfdc_t WHERE sfdc012 IS NOT NULL AND sfdc012 != ' ' ORDER BY sfdc001,sfdc002,sfdc003"  #库位为空的不产生出来  #20151109 DSC.liquor add ORDER BY sfdc001,sfdc002,sfdc003 #161109-00085#62 mark
   #   #161109-00085#62 --s add
   #   LET g_sql = " SELECT sfdcent,sfdcsite,sfdcdocno,sfdcseq,sfdc001,        ",
   #               "        sfdc002,sfdc003,sfdc004,sfdc005,sfdc006,           ",
   #               "        sfdc007,sfdc008,sfdc009,sfdc010,sfdc011,           ",
   #               "        sfdc012,sfdc013,sfdc014,sfdc015,sfdc016,           ",
   #               "        sfdc017,sfdcud001,sfdcud002,sfdcud003,sfdcud004,   ",
   #               "        sfdcud005,sfdcud006,sfdcud007,sfdcud008,sfdcud009, ",
   #               "        sfdcud010,sfdcud011,sfdcud012,sfdcud013,sfdcud014, ",
   #               "        sfdcud015,sfdcud016,sfdcud017,sfdcud018,sfdcud019, ",
   #               "        sfdcud020,sfdcud021,sfdcud022,sfdcud023,sfdcud024, ",
   #               "        sfdcud025,sfdcud026,sfdcud027,sfdcud028,sfdcud029, ",
   #               "        sfdcud030  ",
   #              #170118-00020#1-s
   #              #"   FROM asft310_01_sfdc_t WHERE sfdc012 IS NOT NULL AND sfdc012 != ' ' ORDER BY sfdc001,sfdc002,sfdc003"
   #               "   FROM asft310_01_sfdc_t ORDER BY sfdc001,sfdc002,sfdc003"
   #              #170118-00020#1-e
   #   #161109-00085#62 --e add
   #END IF
   ##mod 141211 end
   LET g_sql = " SELECT sfdc001,sfdc002,sfdc003,sfdc004,sfdc005,sfdc007, ",
               "        sfdc012,sfdc013,sfdc014,sfdc015,sfdc016 ",
               "   FROM asft310_01_sfdc_t ",
#               "  ORDER BY sfdc001,sfdc002,sfdc003"      #170427-00058#1 mark
               "  ORDER BY sfdcseq"   #170427-00058#1 add
   #161205-00025#6-e
   PREPARE asft310_01_gen_p FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asft310_01_gen_c err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_gen_p
      RETURN
   END IF
   DECLARE asft310_01_gen_c CURSOR FOR asft310_01_gen_p
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_gen_c err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_gen_p
      RETURN
   END IF
   #161205-00025#6-s
   ##FOREACH asft310_01_gen_c INTO l_sfdc.* #161109-00085#62 mark
   ##161109-00085#62 --s add
   # FOREACH asft310_01_gen_c INTO l_sfdc.sfdcent,l_sfdc.sfdcsite,l_sfdc.sfdcdocno,l_sfdc.sfdcseq,l_sfdc.sfdc001,
   #                               l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,l_sfdc.sfdc006,
   #                               l_sfdc.sfdc007,l_sfdc.sfdc008,l_sfdc.sfdc009,l_sfdc.sfdc010,l_sfdc.sfdc011,
   #                               l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016,
   #                               l_sfdc.sfdc017,l_sfdc.sfdcud001,l_sfdc.sfdcud002,l_sfdc.sfdcud003,l_sfdc.sfdcud004,
   #                               l_sfdc.sfdcud005,l_sfdc.sfdcud006,l_sfdc.sfdcud007,l_sfdc.sfdcud008,l_sfdc.sfdcud009,
   #                               l_sfdc.sfdcud010,l_sfdc.sfdcud011,l_sfdc.sfdcud012,l_sfdc.sfdcud013,l_sfdc.sfdcud014,
   #                               l_sfdc.sfdcud015,l_sfdc.sfdcud016,l_sfdc.sfdcud017,l_sfdc.sfdcud018,l_sfdc.sfdcud019,
   #                               l_sfdc.sfdcud020,l_sfdc.sfdcud021,l_sfdc.sfdcud022,l_sfdc.sfdcud023,l_sfdc.sfdcud024,
   #                               l_sfdc.sfdcud025,l_sfdc.sfdcud026,l_sfdc.sfdcud027,l_sfdc.sfdcud028,l_sfdc.sfdcud029,
   #                               l_sfdc.sfdcud030 
   ##161109-00085#62 --e add
   FOREACH asft310_01_gen_c INTO l_sfdc.sfdc001,l_sfdc.sfdc002,l_sfdc.sfdc003,l_sfdc.sfdc004,l_sfdc.sfdc005,
                                 l_sfdc.sfdc007,
                                 l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc015,l_sfdc.sfdc016
   #161205-00025#6-e
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'foreach asft310_01_gen_c err'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET g_success = FALSE
          EXIT FOREACH
       END IF

       INITIALIZE g_sfba.* TO NULL
       #161109-00085#30-s
       #SELECT * INTO g_sfba.* FROM sfba_t
       SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005,
              sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015,
              sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025,
              sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035
             ,sfba036  #160726-00001#6
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035
             ,g_sfba.sfba036  #160726-00001#6
         FROM sfba_t
       #161109-00085#30-e  
       #161205-00025#6-s
       #WHERE sfbaent  = l_sfdc.sfdcent
       #  AND sfbasite = l_sfdc.sfdcsite
        WHERE sfbaent  = g_enterprise
          AND sfbasite = g_site
       #161205-00025#6-e
          AND sfbadocno= l_sfdc.sfdc001
          AND sfbaseq  = l_sfdc.sfdc002
          AND sfbaseq1 = l_sfdc.sfdc003
       #add by lixh 20151109
       #是否可以為非成本倉
       SELECT sfaa005,sfaa010 INTO l_sfaa005,l_sfaa010 FROM sfaa_t
        WHERE sfaaent = g_enterprise
          AND sfaadocno = l_sfdc.sfdc001
       IF l_sfaa005 = '5' AND l_sfaa010 = l_sfdc.sfdc004 THEN
          #檢查倉庫是否未非成本倉
          LET l_inaa010 = ''
          SELECT inaa010 INTO l_inaa010 FROM inaa_t
           WHERE inaaent = g_enterprise
             AND inaasite = g_site
             AND inaa001 = l_sfdc.sfdc012
          IF l_inaa010 <> 'N' THEN
#             INITIALIZE g_errparam TO NULL
#             LET g_errparam.code = 'arm-00011'
#             LET g_errparam.extend = ''
#             LET g_errparam.popup = TRUE
#             CALL cl_err()
#             LET g_success = FALSE
#             CONTINUE FOREACH
             LET l_sfdc.sfdc012 = ' '
             LET l_sfdc.sfdc013 = ' '
             LET l_sfdc.sfdc014 = ' '
          END IF                     
       END IF       
       #add by lixh 20151109
       CALL asft310_01_ins_sfdc('sfdc_t',l_sfdc.sfdc012,l_sfdc.sfdc013,l_sfdc.sfdc014,l_sfdc.sfdc016,l_sfdc.sfdc015,l_sfdc.sfdc007,l_sfdc.sfdc005)
   END FOREACH
   FREE asft310_01_gen_p
   
END FUNCTION
################################################################################
# 获取库存可用数量=库存量-在捡量-已存入本单据sfdc_t占用掉的量-已在本单据临时表asft310_01_sfdc_t其他项次占用掉的量
################################################################################
PRIVATE FUNCTION asft310_01_get_available_qty(p_cmd,p_sfdcseq,p_sfdc004,p_sfdc005,p_sfdc006,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016)
DEFINE p_cmd            LIKE type_t.chr1
DEFINE p_sfdcseq        LIKE sfdc_t.sfdcseq  #项次
DEFINE p_sfdc004        LIKE sfdc_t.sfdc004  #料
DEFINE p_sfdc005        LIKE sfdc_t.sfdc005  #特徵
DEFINE p_sfdc006        LIKE sfdc_t.sfdc006  #单位
DEFINE p_sfdc012        LIKE sfdc_t.sfdc012  #仓
DEFINE p_sfdc013        LIKE sfdc_t.sfdc013  #储
DEFINE p_sfdc014        LIKE sfdc_t.sfdc014  #批
DEFINE p_sfdc016        LIKE sfdc_t.sfdc016  #库存管理特征
DEFINE r_qty            LIKE sfdc_t.sfdc007  #剩余库存可用数量
DEFINE l_store_qty      LIKE sfdc_t.sfdc007  #库存量
DEFINE l_wip_qty        LIKE sfdc_t.sfdc007  #在捡量
DEFINE l_sfdc007_sum    LIKE sfdc_t.sfdc007  #本发料单据其他项次的数量
DEFINE l_imaf053     LIKE imaf_t.imaf053  #库存单位
DEFINE l_imaf054     LIKE imaf_t.imaf054  #库存多单位否
DEFINE l_sfdc006     LIKE sfdc_t.sfdc006  #需出库的库存单位
DEFINE l_sfdc007     LIKE sfdc_t.sfdc007  #本发料单据其他项次的数量
DEFINE l_sql         STRING
DEFINE l_rate        LIKE inaj_t.inaj014  #单位换算率
DEFINE l_success     LIKE type_t.num5
DEFINE l_ooba002     LIKE ooba_t.ooba002   #170411-00020#1 add
      
   LET r_qty = 0
   
   IF cl_null(p_sfdc005) THEN LET p_sfdc005 = ' ' END IF #产品特征
   IF cl_null(p_sfdc013) THEN LET p_sfdc013 = ' ' END IF #储位
   IF cl_null(p_sfdc014) THEN LET p_sfdc014 = ' ' END IF #批号
   IF cl_null(p_sfdc016) THEN LET p_sfdc016 = ' ' END IF #库存管理特征
   
   #-------->库存量
   CALL s_inventory_get_inag008_3(g_site,p_sfdc004,p_sfdc005,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016,p_sfdc006) RETURNING l_success,l_store_qty
   
   #-------->在捡量
   LET l_wip_qty = 0
   #170516-00063#1-s
   ##IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0070')='Y' THEN  #参数考虑在捡量 #170411-00020#1 mark
   ##170411-00020#1 add(s)
   #CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,l_ooba002
   #IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0070')='Y' THEN 
   ##170411-00020#1 add(e)
   IF g_bas_0070 = 'Y' THEN
   #170516-00063#1-e
      CALL s_inventory_get_inan010_3(g_site,p_sfdc004,p_sfdc005,p_sfdc012,p_sfdc013,p_sfdc014,p_sfdc016,p_sfdc006) RETURNING l_success,l_wip_qty    #料号+库位的所有在捡量
   END IF
   
   #可发量
   LET r_qty = l_store_qty - l_wip_qty  #库存量-在捡量
   IF r_qty <= 0 THEN
      LET r_qty = 0
      RETURN r_qty
   END IF
   
   
   #######以下缘于库存档中单位的管理#######
   #若料件使用多单位，则只能从存储为指定库存单位的库存量中出库
   #若料件使用单一单位，则只能从存储为库存单位的库存量中出库
   #检查料件是否使用多单位，及库存单位
   SELECT imaf053,imaf054 INTO l_imaf053,l_imaf054
     FROM imaf_t
    WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_sfdc004
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel imaf'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      LET r_qty = 0
      RETURN r_qty
   END IF
   IF l_imaf054='N' AND cl_null(l_imaf053) THEN
      #缺少库存单位,请查询[集团预设料件据点库存资料维护作业aimm202]！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aim-00203'
      LET g_errparam.extend = p_sfdc004
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_qty = 0
      RETURN r_qty
   END IF
   #-------->已存入本单据sfdc_t占用掉的量
   LET l_sql = "SELECT sfdc006,SUM(sfdc007) FROM sfdc_t ",
               " WHERE sfdcent  = ",g_enterprise,
               "   AND sfdcdocno= '",g_sfdadocno,"' ",       #发料单单号
               "   AND sfdc004  = '",p_sfdc004,"' ", #料
               "   AND sfdc005  = '",p_sfdc005,"' ", #特征
               "   AND sfdc012  = '",p_sfdc012,"' ", #仓
               "   AND sfdc013  = '",p_sfdc013,"' ", #储
               "   AND sfdc014  = '",p_sfdc014,"' ", #批
               "   AND sfdc016  = '",p_sfdc016,"' "  #库存管理特征
   IF l_imaf054 = 'Y' THEN   #库存使用多单位
      #发料只能用inag007=指定发料单位的库存资料 发料单位若不存在与库存档中视为无库存
      LET l_sql = l_sql CLIPPED," AND sfdc006 ='",p_sfdc006,"' "   #单位=发料指定单位
   ELSE  #库存使用单一单位
      #发料只能用inag007=库存单位的库存资料 发料单位与库存单位不一致则将库存单位折算成发料单位来发料
      #所以，其他项次的任意单位都算已占用,因此此处无需增加where条件
   END IF
   LET l_sql = l_sql CLIPPED," GROUP BY sfdc006 "
   PREPARE asft310_01_chk_sfdc007_2_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asft310_01_chk_sfdc007_2_p1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_chk_sfdc007_2_p1
      RETURN r_qty
   END IF
   DECLARE asft310_01_chk_sfdc007_2_c1 CURSOR FOR asft310_01_chk_sfdc007_2_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_chk_sfdc007_2_p1 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_chk_sfdc007_2_p1
      RETURN r_qty
   END IF
   LET l_sfdc007_sum = 0
   FOREACH asft310_01_chk_sfdc007_2_c1 INTO l_sfdc006,l_sfdc007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_chk_sfdc007_2_p1 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF 
      
      IF cl_null(l_sfdc007) THEN LET l_sfdc007 = 0 END IF
      IF p_sfdc006 = l_sfdc006 THEN
         LET l_sfdc007_sum = l_sfdc007_sum + l_sfdc007
      ELSE
         #mark 150101
         #CALL s_aimi190_get_convert(p_sfdc004,l_sfdc006,p_sfdc006) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdc007_sum = l_sfdc007_sum + l_sfdc007 * l_rate
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(p_sfdc004,l_sfdc006,p_sfdc006,l_sfdc007) RETURNING l_success,g_qty_t
         IF NOT l_success THEN
            LET g_qty_t = l_sfdc007
         END IF
         LET l_sfdc007_sum = l_sfdc007_sum + g_qty_t
         #add 150101 end
      END IF
   END FOREACH
   FREE asft310_01_chk_sfdc007_2_p1
   
   #可发数量
   LET r_qty = r_qty - l_sfdc007_sum  #库存量-在捡量-"已存入本单据sfdc_t占用掉的量"
   IF r_qty <= 0 THEN
      LET r_qty = 0
      RETURN r_qty
   END IF

   #-------->已在本单据临时表asft310_01_sfdc_t其他项次占用掉的量
   #本发料单据中料+特征+仓储批+库存管理特征在其他项次已填入的数量
   IF p_cmd = 'u' THEN
      LET l_sql = "SELECT sfdc006,SUM(sfdc007) FROM asft310_01_sfdc_t ",
                  " WHERE sfdcent  = ",g_enterprise,
                  "   AND sfdcdocno= '",g_sfdadocno,"' ",       #发料单单号
                  "   AND sfdcseq != ",p_sfdcseq,
                  "   AND sfdc004  = '",p_sfdc004,"' ", #料
                  "   AND sfdc005  = '",p_sfdc005,"' ", #特征
                  "   AND sfdc012  = '",p_sfdc012,"' ", #仓
                  "   AND sfdc013  = '",p_sfdc013,"' ", #储
                  "   AND sfdc014  = '",p_sfdc014,"' ", #批
                  "   AND sfdc016  = '",p_sfdc016,"' "  #库存管理特征
   ELSE
      LET l_sql = "SELECT sfdc006,SUM(sfdc007) FROM asft310_01_sfdc_t ",
                  " WHERE sfdcent  = ",g_enterprise,
                  "   AND sfdcdocno= '",g_sfdadocno,"' ",       #发料单单号
                  "   AND sfdc004  = '",p_sfdc004,"' ", #料
                  "   AND sfdc005  = '",p_sfdc005,"' ", #特征
                  "   AND sfdc012  = '",p_sfdc012,"' ", #仓
                  "   AND sfdc013  = '",p_sfdc013,"' ", #储
                  "   AND sfdc014  = '",p_sfdc014,"' ", #批
                  "   AND sfdc016  = '",p_sfdc016,"' "  #库存管理特征
   END IF
   IF l_imaf054 = 'Y' THEN   #库存使用多单位
      LET l_sql = l_sql CLIPPED," AND sfdc006 ='",p_sfdc006,"' "   #单位=发料指定单位
   ELSE  #库存使用单一单位
      #其他项次的任意单位都算已占用,因此此处无需增加where条件
   END IF
   LET l_sql = l_sql CLIPPED," GROUP BY sfdc006 "
   PREPARE asft310_01_chk_sfdc007_2_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare asft310_01_chk_sfdc007_2_p2 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_chk_sfdc007_2_p2
      RETURN r_qty
   END IF
   DECLARE asft310_01_chk_sfdc007_2_c2 CURSOR FOR asft310_01_chk_sfdc007_2_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare asft310_01_chk_sfdc007_2_p2 err'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
      FREE asft310_01_chk_sfdc007_2_p2
      RETURN r_qty
   END IF
   LET l_sfdc007_sum = 0
   FOREACH asft310_01_chk_sfdc007_2_c2 INTO l_sfdc006,l_sfdc007 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_chk_sfdc007_2_p2 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      IF cl_null(l_sfdc007) THEN LET l_sfdc007 = 0 END IF
      IF p_sfdc006 = l_sfdc006 THEN
         LET l_sfdc007_sum = l_sfdc007_sum + l_sfdc007
      ELSE
         #mark 150101
         #CALL s_aimi190_get_convert(p_sfdc004,l_sfdc006,p_sfdc006) RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdc007_sum = l_sfdc007_sum + l_sfdc007 * l_rate
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(p_sfdc004,l_sfdc006,p_sfdc006,l_sfdc007) RETURNING l_success,g_qty_t
         IF NOT l_success THEN
            LET g_qty_t = l_sfdc007
         END IF
         LET l_sfdc007_sum = l_sfdc007_sum + g_qty_t
         #add 150101 end
      END IF
   END FOREACH
   FREE asft310_01_chk_sfdc007_2_p2
              
   #可发数量
   LET r_qty = r_qty - l_sfdc007_sum  #库存量-在捡量-已存入本单据sfdc_t占用掉的量-"已在本单据临时表asft310_01_sfdc_t其他项次占用掉的量"
   IF r_qty <= 0 THEN
      LET r_qty = 0
      RETURN r_qty
   END IF
   RETURN r_qty
END FUNCTION
#选择处理方式
PRIVATE FUNCTION asft310_01_choice()
   DEFINE r_success   LIKE type_t.num5
   DEFINE ls_msg      STRING
   
   LET r_success = TRUE
   
   LET ls_msg=cl_getmsg('asf-00184',g_lang) 
   LET g_choice = cl_ask_choice(ls_msg)
   IF cl_null(g_choice) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   IF g_choice NOT MATCHES '[123]' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00417'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
      #CALL asft310_01_choice() RETURNING l_success
   END IF
   
   RETURN r_success
END FUNCTION
#根据条件产生单身数据
PRIVATE FUNCTION asft310_01_generate()
   
   IF cl_null(tm.wc) THEN
      LET tm.wc = " 1=1"
   END IF
   IF cl_null(tm2.wc) THEN
      LET tm2.wc = " 1=1"
   END IF
   
   #161205-00025#6-s
   ##VMI存貨庫位Tag
   #CALL cl_get_para(g_enterprise,g_site,'S-BAS-0043') RETURNING g_bas_0043
   #161205-00025#6-e
   
   LET g_count = 0   #add 141226
   CASE g_sfda.sfda002
      WHEN '11'   #成套发料
           CALL asft310_01_g_b11()
      WHEN '12'   #超领发
           CALL asft310_01_g_b12()
      WHEN '13'   #欠料补料
           CALL asft310_01_g_b13()
      WHEN '21'   #成套退料
           CALL asft310_01_g_b21()
      WHEN '22'   #超领退
           CALL asft310_01_g_b22()
      OTHERWISE

   END CASE
END FUNCTION
#成套发料
PRIVATE FUNCTION asft310_01_g_b11()
#161109-00085#30-s
#DEFINE l_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE l_sfdb       RECORD LIKE sfdb_t.*   #发退料 套数单身
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa049 LIKE sfaa_t.sfaa049  #已發料套數
END RECORD
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdb001 LIKE sfdb_t.sfdb001, #工單單號
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作業
       sfdb005 LIKE sfdb_t.sfdb005, #作業序
       sfdb006 LIKE sfdb_t.sfdb006  #預計套數
END RECORD
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq   LIKE sfba_t.sfbaseq,   #項次
       sfbaseq1  LIKE sfba_t.sfbaseq1,  #項序
       sfba006   LIKE sfba_t.sfba006,   #發料料號
       sfba010   LIKE sfba_t.sfba010,   #標準QPA分子
       sfba011   LIKE sfba_t.sfba011,   #標準QPA分母
       sfba023   LIKE sfba_t.sfba023,   #標準應發數量
       sfba024   LIKE sfba_t.sfba024    #調整應發數量
END RECORD
#161109-00085#30-e
DEFINE l_qty          LIKE sfdb_t.sfdb006   #发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
DEFINE l_qty2         LIKE sfdb_t.sfdb006   #有替代料的情况：原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
DEFINE l_issue_qty    LIKE sfdc_t.sfdc007   #在捡量
DEFINE l_sfba016      LIKE sfba_t.sfba016   #计算已发量(包含元件+所有替代料的已发量)
DEFINE l_sets         LIKE sfdb_t.sfdb006   #已发量(包含元件+所有替代料的已发量) 计算出的套数
DEFINE l_success      LIKE type_t.num5
DEFINE l_where        STRING
DEFINE l_flag2        LIKE type_t.num5      #s_control使用
#DEFINE l_count        LIKE type_t.num10      #add 141226    #170104-00066#2 num5->num10  17/01/06 mod by rainy   #160726-00001#6 mark
DEFINE l_sfdc008      LIKE sfdc_t.sfdc008   #160706-00027#1-add

   #LET l_count = 0  #Add 141226  #160726-00001#6 mark
   DECLARE asft310_01_g_b11_sfdb_c CURSOR FOR
   #161109-00085#30-s
      #SELECT * FROM sfdb_t WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
      SELECT sfdb001,sfdb003,sfdb004,sfdb005,sfdb006
        FROM sfdb_t
       WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
   #FOREACH asft310_01_g_b11_sfdb_c INTO l_sfdb.* #发退料 套数单身
   FOREACH asft310_01_g_b11_sfdb_c INTO l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006
   #161109-00085#30-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_g_b11_sfdb_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #161109-00085#30-s
      #SELECT * INTO l_sfaa.*  #工单单头
      SELECT sfaa012,sfaa049 INTO l_sfaa.sfaa012,l_sfaa.sfaa049
      #161109-00085#30-e
        FROM sfaa_t
       WHERE sfaaent = g_enterprise AND sfaadocno = l_sfdb.sfdb001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel sfaa'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF

      #161118-00033#1-s  #161109-00085#30-s
      #LET g_sql = "SELECT sfba_t.*,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      LET g_sql = "SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005, ",
                  "       sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015, ",
                  "       sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025, ",
                  "       sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035, ",
                  "       sfba036, ",  #160726-00001#6
                  "       imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      #161118-00033#1-e  #161109-00085#30-e
                 #160408-00035#6 add str  #查看有沒有硬備置的資料
                  "      ,(SELECT COUNT(1) FROM sfbb_t ",
                  "         WHERE sfbbent=sfbaent AND sfbbsite=sfbasite AND sfbbdocno=sfbadocno",
                  "           AND sfbbseq=sfbaseq AND sfbbseq1=sfbaseq1",
                  "           AND sfbb004 IS NOT NULL AND sfbb004 <> ' ') sfbb_cnt",
                 #160408-00035#6 add end
                  "  FROM sfba_t,imaa_t,imaf_t,imae_t ",
                  " WHERE sfbaent = imaaent AND sfba006 = imaa001 ",
                  "   AND sfbaent = imafent AND sfbasite = imafsite AND sfba006 = imaf001 ",
                  "   AND sfbaent = imaeent AND sfbasite = imaesite AND sfba006 = imae001 ",
                  "   AND sfbaent = ",g_enterprise,
                  "   AND sfbasite= '",g_site,"' ",
                  "   AND sfbadocno= '",l_sfdb.sfdb001,"' ",   #工单单号
                  "   AND sfba009  = 'N' ",          #倒扣料
                  "   AND (sfba013 - sfba015) >0 ",  #应发-委外代买量>0
                  "   AND sfba008 != '4' ",          #非参考材料
                  "   AND ",tm.wc CLIPPED            #画面QBE条件
      IF NOT cl_null(l_sfdb.sfdb003) THEN  #部位
         LET g_sql = g_sql CLIPPED,"  AND sfba002 = '",l_sfdb.sfdb003,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb004) THEN  #作业编号
         LET g_sql = g_sql CLIPPED,"  AND sfba003 = '",l_sfdb.sfdb004,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb005) THEN  #作业序
         LET g_sql = g_sql CLIPPED,"  AND sfba004 = '",l_sfdb.sfdb005,"'"
      END IF
      
      #非制程委外发料 这里不考虑 sfdb002
      
      #关于控制组
      CALL s_control_get_doc_sql("imaf016",g_sfdadocno,'4')   #下面开窗中的据点生命周期、需限制的单据、4代表产品生命周期检核
         RETURNING l_success,l_where     #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      CALL s_control_get_doc_sql("imaa009",g_sfdadocno,'5')
         RETURNING l_success,l_where      #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end

      LET g_sql = g_sql CLIPPED," ORDER BY sfbaseq,sfbaseq1"
      PREPARE asft310_01_g_b11_sfba_p FROM g_sql
      DECLARE asft310_01_g_b11_sfba_c CURSOR FOR asft310_01_g_b11_sfba_p
      #161118-00033#1-s  #161109-00085#30-s
      #FOREACH asft310_01_g_b11_sfba_c INTO g_sfba.*,g_imaf091,g_imaf092,g_imae101,g_imae102,
      #                                     g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      #                                    ,g_sfbb_cnt  #160408-00035#6 add
      FOREACH asft310_01_g_b11_sfba_c
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035,
              g_sfba.sfba036,  #160726-00001#6
              g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005,g_sfbb_cnt
      #161118-00033#1-e  #161109-00085#30-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_g_b11_sfba_c err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF

         #IF g_sfba.sfbaseq1 > 0 THEN  #替代料
         #160726-00001#6-s
         IF g_sfba.sfbaseq1 = 0 THEN
            LET l_sfba.sfbadocno = g_sfba.sfbadocno
            LET l_sfba.sfbaseq   = g_sfba.sfbaseq
            LET l_sfba.sfbaseq1  = g_sfba.sfbaseq1
            LET l_sfba.sfba006   = g_sfba.sfba006
            LET l_sfba.sfba010   = g_sfba.sfba010
            LET l_sfba.sfba011   = g_sfba.sfba011
            LET l_sfba.sfba023   = g_sfba.sfba023
            LET l_sfba.sfba024   = g_sfba.sfba024
         ELSE  #替代料
         #160726-00001#6-e
            #抓出原件资料
            #161109-00085#30-s
            #SELECT * INTO l_sfba.* FROM sfba_t
            SELECT sfbadocno,sfbaseq,sfbaseq1,sfba006,sfba010,sfba011,sfba023,sfba024
              INTO l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba010,
                   l_sfba.sfba011,l_sfba.sfba023,l_sfba.sfba024
              FROM sfba_t
            #161109-00085#30-e
             WHERE sfbaent   = g_sfba.sfbaent
               AND sfbadocno = g_sfba.sfbadocno
               AND sfbaseq   = g_sfba.sfbaseq
               AND sfbaseq1  = 0
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
         END IF  #160726-00001#6 remark

         #指定仓库储位
         IF cl_null(g_sfba.sfba019) THEN LET g_sfba.sfba019 = ' '  END IF
         IF cl_null(g_sfba.sfba020) THEN LET g_sfba.sfba020 = ' '  END IF
         IF cl_null(g_sfba.sfba029) THEN LET g_sfba.sfba029 = ' '  END IF
         IF cl_null(g_sfba.sfba030) THEN LET g_sfba.sfba030 = ' '  END IF
         #预设仓库储位
         IF cl_null(g_imaf091) THEN LET g_imaf091 = ' ' END IF
         IF cl_null(g_imaf092) THEN LET g_imaf092 = ' ' END IF
         #预设发料/退料库位储位
         IF cl_null(g_imae101) THEN LET g_imae101 = ' ' END IF
         IF cl_null(g_imae102) THEN LET g_imae102 = ' ' END IF
         IF cl_null(g_imae103) THEN LET g_imae103 = ' ' END IF
         IF cl_null(g_imae104) THEN LET g_imae104 = ' ' END IF

         #工单单身某笔总共应发=应发-扣除委外代買量
         LET g_sfba.sfba013=g_sfba.sfba013-g_sfba.sfba015
         
         #发料时的應發量
         IF l_sfdb.sfdb006 > 0 THEN
            IF l_sfdb.sfdb006 = l_sfaa.sfaa012 - l_sfaa.sfaa049 THEN  #預計發料套數=生產數量-已發套數,即要把剩余
               #應發總數量-已發數量
               LET issue_qty = g_sfba.sfba013 - g_sfba.sfba016
               
               #计算发料单上已产生的发料数量
               CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
               #计算剩下的应发量
               LET issue_qty = issue_qty - l_qty
            ELSE
               #160726-00001#6-s
               ###发料套数*QPA分子/QPA分母
               ##LET issue_qty  =l_sfdb.sfdb006 * g_sfba.sfba010 / g_sfba.sfba011
               ##考虑可能有取替代料的情况
               ##计算本单据上已发量(包含元件+所有替代料的已发量)(不包括备料档),折算成元件的已发量
               #CALL asft310_01_get_sfba016('1',g_sfba.sfbadocno,g_sfba.sfbaseq) RETURNING l_sfba016
               ##根据已发量计算该料已发套数
               #LET l_sets = l_sfba016 * l_sfba.sfba011 / l_sfba.sfba010
               #IF l_sets >= l_sfdb.sfdb006 THEN #已发套数 >= 需求套数
               #   CONTINUE FOREACH
               #END IF
               #IF g_sfba.sfbaseq1 = 0 THEN  #非替代料 未发套数*QPA分子/QPA分母
               #   LET issue_qty = (l_sfdb.sfdb006 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011
               #   #160309-00006#1  By Ann_Huang  --- add Start ---
               #   IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN
               #      LET issue_qty = issue_qty + l_sfba.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
               #   END IF
               #   #160309-00006#1  By Ann_Huang  --- add End ---
               #ELSE  #替代料  未发套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
               #   LET issue_qty = ((l_sfdb.sfdb006 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022
               #   #160309-00006#1  By Ann_Huang  --- add Start ---
               #   IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN    
               #      LET issue_qty = issue_qty + l_sfba.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
               #   END IF    
               #   #160309-00006#1  By Ann_Huang  --- add End ---
               #END IF
               IF g_sfba.sfba026 = '1' THEN  #非SET替代
                  #计算本单据上已发量(包含元件+所有替代料的已发量)(不包括备料档),折算成元件的已发量
                  CALL asft310_01_get_sfba016('1',g_sfba.sfbadocno,g_sfba.sfbaseq) RETURNING l_sfba016
                  #根据已发量计算该料已发套数
                  LET l_sets = l_sfba016 * l_sfba.sfba011 / l_sfba.sfba010
                  #生產數量-已发套数 < 需求套数
                  IF l_sfaa.sfaa012 - l_sets < l_sfdb.sfdb006 THEN
                     LET l_sets = l_sfaa.sfaa012 - l_sets
                  ELSE
                     #170330-00003#1 add --(S)--
                     #前面項次已符合需求故離開
                     IF l_sfdb.sfdb006 - l_sets <= 0 THEN
                        CONTINUE FOREACH
                     ELSE
                        LET l_sets = l_sfdb.sfdb006 - l_sets
                     END IF
                     #170330-00003#1 add --(E)--
                    #LET l_sets = l_sfdb.sfdb006  #170330-00003#1 mark
                  END IF
               ELSE  #SET替代
                  #抓取替代同一群組未替代套數
                  LET l_sets = 0
                  SELECT SUM(MIN(sfba035-COALESCE(sfba036,0))) INTO l_sets
                    FROM sfba_t
                   WHERE sfbaent = g_sfba.sfbaent AND sfbadocno = g_sfba.sfbadocno
                     AND sfbaseq < g_sfba.sfbaseq AND sfba034 = g_sfba.sfba034
                     AND sfba027 <> g_sfba.sfba027 GROUP BY sfba027
                  IF cl_null(l_sets) THEN LET l_sets = 0 END IF
                  #前面項次已符合需求故離開
                  IF l_sfdb.sfdb006 <= l_sets THEN
                     CONTINUE FOREACH
                  END IF
                  #本群組已發套數
                  IF cl_null(g_sfba.sfba036) THEN LET g_sfba.sfba036 = 0 END IF
                  IF g_sfba.sfba035 - g_sfba.sfba036 < l_sfdb.sfdb006 - l_sets THEN
                     LET l_sets = g_sfba.sfba035 - g_sfba.sfba036
                  ELSE
                     LET l_sets = l_sfdb.sfdb006 - l_sets
                  END IF
               END IF
               IF g_sfba.sfbaseq1 = 0 THEN  #非替代料 未发套数*QPA分子/QPA分母
                  LET issue_qty = l_sets * l_sfba.sfba010 / l_sfba.sfba011
                  IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN
                     LET issue_qty = issue_qty + l_sfba.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
                  END IF
               ELSE  #替代料  未发套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
                  LET issue_qty = (l_sets * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022
                  IF asft310_01_get_all_sfdc007(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba006,l_sfba.sfba023,issue_qty) THEN    
                     LET issue_qty = issue_qty + l_sfba.sfba024 #160127 add 算完標準應發量，應再多加上調整數量
                  END IF    
               END IF
               #160726-00001#6-e
            END IF
         ELSE  #=0代表欠料补料 把已发套数中不足的部分补发出去
            IF g_para1 = 'Y' THEN   #160706-00027#1-add
               IF l_sfaa.sfaa049 = l_sfaa.sfaa012 THEN  #已發套數=生產數量,即要把剩余
                  #應發總數量-已發數量
                  LET issue_qty = g_sfba.sfba013 - g_sfba.sfba016
                  
                  #计算发料单上已产生的发料数量
                  CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
                  #计算剩下的应发量
                  LET issue_qty = issue_qty - l_qty
               ELSE
                  ##发料套数*QPA分子/QPA分母 - 已发
                  #LET issue_qty = l_sfaa.sfaa049 * g_sfba.sfba010 / g_sfba.sfba011 - g_sfba.sfba016
                  #考虑可能有取替代料的情况
                  #计算备料+本单据上所有已发量(包含元件+所有替代料的已发量),折算成元件的已发量
                  CALL asft310_01_get_sfba016('2',g_sfba.sfbadocno,g_sfba.sfbaseq) RETURNING l_sfba016
                  #根据已发量计算该料已发套数
                  LET l_sets = l_sfba016 * l_sfba.sfba011 / l_sfba.sfba010
                  IF l_sets >= l_sfaa.sfaa049 THEN #此元件已发套数 >= 工单已发套数 不需欠料补料
                     CONTINUE FOREACH
                  END IF
                  
                  IF g_sfba.sfbaseq1 = 0 THEN  #非替代料 不足套数*QPA分子/QPA分母
                     LET issue_qty = (l_sfaa.sfaa049 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011                  
                  ELSE  #替代料  不足套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
                     LET issue_qty = ((l_sfaa.sfaa049 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022
                  END IF
               END IF
            #160706-00027#1-add-(S)
            ELSE
               SELECT SUM(sfdc008) INTO l_sfdc008
                 FROM sfdc_t,sfda_t
                WHERE sfdcent = sfdaent AND sfdcsite=sfdasite
                  AND sfdcdocno = sfdadocno
                  AND sfdcent = g_enterprise AND sfdcsite = g_site
                  AND sfdc001 = g_sfba.sfbadocno
                  AND sfdc002 = g_sfba.sfbaseq
                  AND sfdc003 = g_sfba.sfbaseq1
                  AND sfdastus <> 'S'
               IF cl_null(l_sfdc008) THEN LET l_sfdc008 = 0 END IF 
               #應發總數量-已發數量
               LET issue_qty = g_sfba.sfba013 - g_sfba.sfba016 - l_sfdc008

               #计算发料单上已产生的发料数量
               CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
               #计算剩下的应发量
               LET issue_qty = issue_qty - l_qty          
            END IF 
            #160706-00027#1-add-(E)
         END IF
         
         #add 150115  单位取位
         CALL s_aooi250_get_msg(g_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
         END IF
         #add 150115 end
         
         #发料时的應發量 > 应发 - 已发
         IF issue_qty>(g_sfba.sfba013-g_sfba.sfba016) THEN
            LET issue_qty=(g_sfba.sfba013-g_sfba.sfba016)
         END IF
         
         ##计算发料单上已产生的发料数量
         #CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
         ##计算剩下的应发量
         #LET issue_qty = issue_qty - l_qty
         ##移到上面去 因asft310_01_get_sfba016中包含了此值
         
         IF issue_qty <= 0 THEN 
            CONTINUE FOREACH
         END IF

         #LET l_count = l_count + 1  #add 141226  #160726-00001#6 mark
         
         #當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料 141203 add
         IF NOT cl_null(g_imaa005) AND (g_sfba.sfba021 IS NULL OR g_sfba.sfba021=' ') THEN 
            CALL asft310_01_issue_feature1() #找出有库存的特征料件发料，同时减少剩余应发量issue_qty
            IF issue_qty <= 0 THEN 
               CONTINUE FOREACH
            END IF
         END IF

        #160408-00035#6 add str
         IF g_sfbb_cnt > 0 THEN  #表示工單有硬備置的資料
            CALL asft310_01_default_from_sfbb()
            IF issue_qty = 0 THEN
               CONTINUE FOREACH
            END IF
         END IF
        #160408-00035#6 add end

         CALL asft310_01_issue1()  #按不同发料方式发料

      END FOREACH  #工单备料单身
      FREE asft310_01_g_b11_sfba_p
   END FOREACH  #发退料 套数单身
   FREE asft310_01_g_b11_sfdb_c

   #add 141226
   #IF l_count = 0 THEN
   #   #无可产生的资料
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'asf-00242'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = FALSE
   #   CALL cl_err()
   #ELSE
      IF g_count = 0 THEN
         #无资料产生！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   #add 141226 end
END FUNCTION
#超领发料
PRIVATE FUNCTION asft310_01_g_b12()
#161109-00085#30-s
#DEFINE l_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE l_sfdb       RECORD LIKE sfdb_t.*   #发退料 套数单身
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdb001 LIKE sfdb_t.sfdb001, #工單單號
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作業
       sfdb005 LIKE sfdb_t.sfdb005, #作業序
       sfdb006 LIKE sfdb_t.sfdb006  #預計套數
END RECORD
#161109-00085#30-e

DEFINE l_qty          LIKE sfdb_t.sfdb006   #发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
DEFINE l_qty2         LIKE sfdb_t.sfdb006   #有替代料的情况：原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
DEFINE l_issue_qty    LIKE sfdc_t.sfdc007   #在捡量
DEFINE l_success      LIKE type_t.num5
DEFINE l_where        STRING
DEFINE l_flag2        LIKE type_t.num5      #s_control使用
DEFINE l_sfdc007_1    LIKE sfdc_t.sfdc007
DEFINE l_count        LIKE type_t.num10      #add 141226   #170104-00066#2 num5->num10  17/01/06 mod by rainy 

   LET l_count = 0  #Add 141226
   DECLARE asft310_01_g_b12_sfdb_c CURSOR FOR
   #161109-00085#30-s
      #SELECT * FROM sfdb_t WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
      SELECT sfdb001,sfdb003,sfdb004,sfdb005,sfdb006
        FROM sfdb_t
       WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
   #FOREACH asft310_01_g_b12_sfdb_c INTO l_sfdb.* #发退料 套数单身
   FOREACH asft310_01_g_b12_sfdb_c INTO l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005,l_sfdb.sfdb006
   #161109-00085#30-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_g_b12_sfdb_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #161109-00085#30-s
      #SELECT * INTO l_sfaa.*  #工单单头
      #  FROM sfaa_t
      # WHERE sfaaent = g_enterprise AND sfaadocno = l_sfdb.sfdb001
      #IF SQLCA.sqlcode THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = SQLCA.sqlcode
      #   LET g_errparam.extend = 'sel sfaa'
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #   LET g_success = FALSE
      #   EXIT FOREACH
      #END IF
      #161109-00085#30-e
     
      #161118-00033#1-s  #161109-00085#30-s
      #LET g_sql = "SELECT sfba_t.*,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      LET g_sql = "SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005, ",
                  "       sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015, ",
                  "       sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025, ",
                  "       sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035, ",
                  "       sfba036, ",  #160726-00001#6
                  "       imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      #161118-00033#1-e  #161109-00085#30-e
                  "  FROM sfba_t,imaa_t,imaf_t,imae_t ",
                  " WHERE sfbaent = imaaent AND sfba006 = imaa001 ",
                  "   AND sfbaent = imafent AND sfbasite = imafsite AND sfba006 = imaf001 ",
                  "   AND sfbaent = imaeent AND sfbasite = imaesite AND sfba006 = imae001 ",
                  "   AND sfbaent = ",g_enterprise,
                  "   AND sfbasite= '",g_site,"' ",
                  "   AND sfbadocno= '",l_sfdb.sfdb001,"' ",   #工单单号
                  "   AND sfbaseq1 = 0 ",  #项序=0
                  "   AND sfba009  = 'N' ",          #倒扣料
                  #"   AND (sfba013 - sfba015) >0 ",  #应发-委外代买量>0
                  "   AND sfba008 != '4' ",          #非参考材料
                  "   AND ",tm.wc CLIPPED            #画面QBE条件
      IF NOT cl_null(l_sfdb.sfdb003) THEN  #部位
         LET g_sql = g_sql CLIPPED,"  AND sfba002 = '",l_sfdb.sfdb003,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb004) THEN  #作业编号
         LET g_sql = g_sql CLIPPED,"  AND sfba003 = '",l_sfdb.sfdb004,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb005) THEN  #作业序
         LET g_sql = g_sql CLIPPED,"  AND sfba004 = '",l_sfdb.sfdb005,"'"
      END IF
      
      #非制程委外发料 这里不考虑 sfdb002
      
      #关于控制组
      CALL s_control_get_doc_sql("imaf016",g_sfdadocno,'4')   #下面开窗中的据点生命周期、需限制的单据、4代表产品生命周期检核
         RETURNING l_success,l_where     #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      CALL s_control_get_doc_sql("imaa009",g_sfdadocno,'5')
         RETURNING l_success,l_where      #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end

      LET g_sql = g_sql CLIPPED," ORDER BY sfbaseq,sfbaseq1"
      PREPARE asft310_01_g_b12_sfba_p FROM g_sql
      DECLARE asft310_01_g_b12_sfba_c CURSOR FOR asft310_01_g_b12_sfba_p
      #161118-00033#1-s  #161109-00085#30-s
      #FOREACH asft310_01_g_b12_sfba_c INTO g_sfba.*,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      FOREACH asft310_01_g_b12_sfba_c
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035,
              g_sfba.sfba036,  #160726-00001#6
              g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      #161118-00033#1-e  #161109-00085#30-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_g_b12_sfba_c err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         #IF g_sfba.sfbaseq1 > 0 THEN  #替代料
            #161109-00085#30-s
            ##抓出原件资料
            #SELECT * INTO l_sfba.* FROM sfba_t
            # WHERE sfbaent   = g_sfba.sfbaent
            #   AND sfbadocno = g_sfba.sfbadocno
            #   AND sfbaseq   = g_sfba.sfbaseq
            #   AND sfbaseq1  = 0
            #IF SQLCA.sqlcode THEN
            #   INITIALIZE g_errparam TO NULL
            #   LET g_errparam.code = SQLCA.sqlcode
            #   LET g_errparam.extend = ''
            #   LET g_errparam.popup = TRUE
            #   CALL cl_err()
            #   LET g_success = FALSE
            #   EXIT FOREACH
            #END IF
            #161109-00085#30-s
         #END IF

         #指定仓库储位
         IF cl_null(g_sfba.sfba019) THEN LET g_sfba.sfba019 = ' '  END IF
         IF cl_null(g_sfba.sfba020) THEN LET g_sfba.sfba020 = ' '  END IF
         IF cl_null(g_sfba.sfba029) THEN LET g_sfba.sfba029 = ' '  END IF
         IF cl_null(g_sfba.sfba030) THEN LET g_sfba.sfba030 = ' '  END IF
         #预设仓库储位
         IF cl_null(g_imaf091) THEN LET g_imaf091 = ' ' END IF
         IF cl_null(g_imaf092) THEN LET g_imaf092 = ' ' END IF
         #预设发料/退料库位储位
         IF cl_null(g_imae101) THEN LET g_imae101 = ' ' END IF
         IF cl_null(g_imae102) THEN LET g_imae102 = ' ' END IF
         IF cl_null(g_imae103) THEN LET g_imae103 = ' ' END IF
         IF cl_null(g_imae104) THEN LET g_imae104 = ' ' END IF

         #超领
         #发料套数*QPA分子/QPA分母
         LET issue_qty  =l_sfdb.sfdb006 * g_sfba.sfba010 / g_sfba.sfba011
         
         #add 150115  单位取位
         CALL s_aooi250_get_msg(g_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
         END IF
         #add 150115 end
         
         #计算发料单上已产生的发料数量
         CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
         
         #计算剩下的应发量
         #LET issue_qty = issue_qty - l_sfdc007 - l_sfdc007_tmp
         LET issue_qty = issue_qty - l_qty
         IF issue_qty <= 0 THEN 
            CONTINUE FOREACH
         END IF
         
         #依發料單別參數"超領數量與下階料報廢數量勾稽"，
         #當此參數=Y時，申請數量需判斷數量不可超過(下階料報廢數量-已存在超領數量+超領退料數量)
         CALL s_aooi200_get_slip(g_sfdadocno) RETURNING l_success,g_ooba002
         IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0056') = 'Y' THEN
            #其他单据发料未过账申请数
            SELECT SUM(sfdc007) INTO l_sfdc007_1
              FROM sfdc_t,sfda_t
             WHERE sfdcent   = sfdaent
               AND sfdcdocno = sfdadocno
               AND sfdcent   = g_enterprise
               AND sfdcdocno!=g_sfdadocno
               AND sfdc001   = g_sfba.sfbadocno  #工单
               AND sfdc002   = g_sfba.sfbaseq    #工单项次
               AND sfdc003   = g_sfba.sfbaseq1   #工单项序
               AND sfda002 = '12'  #发料
               AND sfdastus != 'S' AND sfdastus != 'X'
            IF cl_null(l_sfdc007_1) THEN LET l_sfdc007_1 = 0 END IF

            #下階料報廢數量-已存在超領數量 < 套数对应数量
            IF g_sfba.sfba017-g_sfba.sfba025-l_qty-l_sfdc007_1 < issue_qty THEN
               #可发料的量
               LET issue_qty  = g_sfba.sfba017-g_sfba.sfba025-l_qty-l_sfdc007_1
            END IF
         END IF
         
         LET l_count = l_count + 1  #add 141226
         
         #當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料 141203 add
         IF NOT cl_null(g_imaa005) AND (g_sfba.sfba021 IS NULL OR g_sfba.sfba021=' ') THEN 
            CALL asft310_01_issue_feature1() #找出有库存的特征料件发料，同时减少剩余应发量issue_qty
            IF issue_qty <= 0 THEN 
               CONTINUE FOREACH
            END IF
         END IF
         
         CALL asft310_01_issue1()  #按不同发料方式发料

      END FOREACH  #工单备料单身
      FREE asft310_01_g_b12_sfba_p
   END FOREACH  #发退料 套数单身
   FREE asft310_01_g_b12_sfdb_c

   #add 141226
   #IF l_count = 0 THEN
   #   #无可产生的资料
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'asf-00242'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #ELSE
      IF g_count = 0 THEN
         #无资料产生！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   #add 141226 end

END FUNCTION
#欠料补料
PRIVATE FUNCTION asft310_01_g_b13()
#161109-00085#30-s
#DEFINE l_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE l_sfdb       RECORD LIKE sfdb_t.*   #发退料 套数单身
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaa012 LIKE sfaa_t.sfaa012, #生產數量
       sfaa049 LIKE sfaa_t.sfaa049  #已發料套數
END RECORD
DEFINE l_sfdb RECORD  #發退料套數檔
       sfdb001 LIKE sfdb_t.sfdb001, #工單單號
       sfdb003 LIKE sfdb_t.sfdb003, #部位
       sfdb004 LIKE sfdb_t.sfdb004, #作業
       sfdb005 LIKE sfdb_t.sfdb005  #作業序
END RECORD
DEFINE l_sfba RECORD  #工單備料單身檔
       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
       sfba011 LIKE sfba_t.sfba011  #標準QPA分母
END RECORD
#161109-00085#30-e
DEFINE l_qty          LIKE sfdb_t.sfdb006   #发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
DEFINE l_qty2         LIKE sfdb_t.sfdb006   #有替代料的情况：原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
DEFINE l_sfba016      LIKE sfba_t.sfba016   #计算已发量(包含元件+所有替代料的已发量)
DEFINE l_sets         LIKE sfdb_t.sfdb006   #已发量(包含元件+所有替代料的已发量) 计算出的套数
DEFINE l_success      LIKE type_t.num5
DEFINE l_where        STRING
DEFINE l_flag2        LIKE type_t.num5   #s_control使用
#DEFINE l_count        LIKE type_t.num10     #add 141226   #170104-00066#2 num5->num10  17/01/06 mod by rainy  #160726-00001#6 mark

   #LET l_count = 0  #Add 141226  #160726-00001#6 mark
   DECLARE asft310_01_g_b13_sfdb_c CURSOR FOR
   #161109-00085#30-s
      #SELECT * FROM sfdb_t WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
      SELECT sfdb001,sfdb003,sfdb004,sfdb005
        FROM sfdb_t
       WHERE sfdbent=g_enterprise AND sfdbdocno=g_sfdadocno
   #FOREACH asft310_01_g_b13_sfdb_c INTO l_sfdb.* #发退料 套数单身
   FOREACH asft310_01_g_b13_sfdb_c INTO l_sfdb.sfdb001,l_sfdb.sfdb003,l_sfdb.sfdb004,l_sfdb.sfdb005
   #161109-00085#30-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_g_b13_sfdb_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #161109-00085#30-s
      #SELECT * INTO l_sfaa.*  #工单单头
      SELECT sfaa012,sfaa049 INTO l_sfaa.sfaa012,l_sfaa.sfaa049
      #161109-00085#30-e
        FROM sfaa_t
       WHERE sfaaent = g_enterprise AND sfaadocno = l_sfdb.sfdb001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel sfaa'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET g_success = FALSE
         EXIT FOREACH
      END IF
      
      #161118-00033#1-s  #161109-00085#30-s
      #LET g_sql = "SELECT sfba_t.*,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      LET g_sql = "SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005, ",
                  "       sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015, ",
                  "       sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025, ",
                  "       sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035, ",
                  "       sfba036, ",  #160726-00001#6
                  "       imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      #161118-00033#1-e  #161109-00085#30-e
                  "  FROM sfba_t,imaa_t,imaf_t,imae_t ",
                  " WHERE sfbaent = imaaent AND sfba006 = imaa001 ",
                  "   AND sfbaent = imafent AND sfbasite = imafsite AND sfba006 = imaf001 ",
                  "   AND sfbaent = imaeent AND sfbasite = imaesite AND sfba006 = imae001 ",
                  "   AND sfbaent = ",g_enterprise,
                  "   AND sfbasite= '",g_site,"' ",
                  "   AND sfbadocno= '",l_sfdb.sfdb001,"' ",   #工单单号
                  "   AND sfba009  = 'N' ",          #倒扣料
                  "   AND (sfba013 - sfba015) >0 ",  #应发-委外代买量>0
                  "   AND sfba008 != '4' ",          #非参考材料
                  "   AND ",tm.wc CLIPPED      #画面QBE条件
      IF NOT cl_null(l_sfdb.sfdb003) THEN  #部位
         LET g_sql = g_sql CLIPPED,"  AND sfba002 = '",l_sfdb.sfdb003,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb004) THEN  #作业编号
         LET g_sql = g_sql CLIPPED,"  AND sfba003 = '",l_sfdb.sfdb004,"'"
      END IF
    
      IF NOT cl_null(l_sfdb.sfdb005) THEN  #作业序
         LET g_sql = g_sql CLIPPED,"  AND sfba004 = '",l_sfdb.sfdb005,"'"
      END IF
      
      #非制程委外发料 这里不考虑 sfdb002
            
      #关于控制组
      CALL s_control_get_doc_sql("imaf016",g_sfdadocno,'4')   #下面开窗中的据点生命周期、需限制的单据、4代表产品生命周期检核
         RETURNING l_success,l_where     #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      CALL s_control_get_doc_sql("imaa009",g_sfdadocno,'5')
         RETURNING l_success,l_where      #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end
         
      LET g_sql = g_sql CLIPPED," ORDER BY sfbaseq,sfbaseq1"
      PREPARE asft310_01_g_b13_sfba_p FROM g_sql
      DECLARE asft310_01_g_b13_sfba_c CURSOR FOR asft310_01_g_b13_sfba_p
      #161118-00033#1-s  #161109-00085#30-s
      #FOREACH asft310_01_g_b13_sfba_c INTO g_sfba.*,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      FOREACH asft310_01_g_b13_sfba_c
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035,
              g_sfba.sfba036,  #160726-00001#6
              g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      #161118-00033#1-e  #161109-00085#30-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_g_b13_sfba_c err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         #IF g_sfba.sfbaseq1 > 0 THEN  #替代料
            #抓出原件资料
            #161109-00085#30-s
            #SELECT * INTO l_sfba.* FROM sfba_t
            SELECT sfba010,sfba011 INTO l_sfba.sfba010,l_sfba.sfba011
              FROM sfba_t
            #161109-00085#30-s
             WHERE sfbaent   = g_sfba.sfbaent
               AND sfbadocno = g_sfba.sfbadocno
               AND sfbaseq   = g_sfba.sfbaseq
               AND sfbaseq1  = 0
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
         #END IF

         #指定仓库储位
         IF cl_null(g_sfba.sfba019) THEN LET g_sfba.sfba019 = ' '  END IF
         IF cl_null(g_sfba.sfba020) THEN LET g_sfba.sfba020 = ' '  END IF
         IF cl_null(g_sfba.sfba029) THEN LET g_sfba.sfba029 = ' '  END IF
         IF cl_null(g_sfba.sfba030) THEN LET g_sfba.sfba030 = ' '  END IF
         #预设仓库储位
         IF cl_null(g_imaf091) THEN LET g_imaf091 = ' ' END IF
         IF cl_null(g_imaf092) THEN LET g_imaf092 = ' ' END IF
         #预设发料/退料库位储位
         IF cl_null(g_imae101) THEN LET g_imae101 = ' ' END IF
         IF cl_null(g_imae102) THEN LET g_imae102 = ' ' END IF
         IF cl_null(g_imae103) THEN LET g_imae103 = ' ' END IF
         IF cl_null(g_imae104) THEN LET g_imae104 = ' ' END IF

         #工单单身某笔总共应发=应发-扣除委外代買量
         LET g_sfba.sfba013=g_sfba.sfba013-g_sfba.sfba015

         #欠料补料把已发套数中不足的部分补发出去
         IF l_sfaa.sfaa049 = l_sfaa.sfaa012 THEN  #已發套數=生產數量,即要把剩余
            #應發總數量-已發數量
            LET issue_qty = g_sfba.sfba013 - g_sfba.sfba016
            
            #计算发料单上已产生的发料数量
            CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
            #计算剩下的应发量
            LET issue_qty = issue_qty - l_qty
         ELSE
            #160726-00001#6-s
            ##LET issue_qty = l_sfaa.sfaa049 * g_sfba.sfba010 / g_sfba.sfba011 - g_sfba.sfba016
            ##考虑可能有取替代料的情况
            ##计算备料+本单据上所有已发量(包含元件+所有替代料的已发量),折算成元件的已发量
            #CALL asft310_01_get_sfba016('2',g_sfba.sfbadocno,g_sfba.sfbaseq) RETURNING l_sfba016
            ##根据已发量计算该料已发套数
            #LET l_sets = l_sfba016 * l_sfba.sfba011 / l_sfba.sfba010
            #IF l_sets >= l_sfaa.sfaa049 THEN #此元件已发套数 >= 工单已发套数 不需欠料补料
            #   CONTINUE FOREACH
            #END IF
            #IF g_sfba.sfbaseq1 = 0 THEN  #非替代料 不足套数*QPA分子/QPA分母
            #   LET issue_qty = (l_sfaa.sfaa049 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011
            #ELSE  #替代料  不足套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
            #   LET issue_qty = ((l_sfaa.sfaa049 - l_sets) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022
            #END IF
            #计算备料+本单据上所有已发量(包含元件+所有替代料的已发量),折算成元件的已发量
            CALL asft310_01_get_sfba016('2',g_sfba.sfbadocno,g_sfba.sfbaseq) RETURNING l_sfba016
            #根据已发量计算该料已发套数
            LET l_sets = l_sfba016 * l_sfba.sfba011 / l_sfba.sfba010
            IF g_sfba.sfba026 = '1' THEN  #非SET替代
               #此元件已发套数 >= 工单已发套数 不需欠料补料
               IF l_sets >= l_sfaa.sfaa049 THEN
                  CONTINUE FOREACH
               END IF
               LET l_sets = l_sfaa.sfaa049 - l_sets
            ELSE  #SET替代
               #此元件已发套数 >= SET已發數量 不需欠料补料
               IF l_sets >= g_sfba.sfba036 THEN
                  CONTINUE FOREACH
               END IF
               LET l_sets = g_sfba.sfba036 - l_sets
            END IF
            IF g_sfba.sfbaseq1 = 0 THEN  #非替代料 不足套数*QPA分子/QPA分母
               LET issue_qty = l_sets * l_sfba.sfba010 / l_sfba.sfba011
            ELSE  #替代料  不足套数*(QPA分子/QPA分母)*替代率=元件应发量*替代率=替代料的应发量
               LET issue_qty = (l_sets * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022
            END IF
            #160726-00001#6-e
         END IF
         
         #add 150115  单位取位
         CALL s_aooi250_get_msg(g_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
         END IF
         #add 150115 end
         
         #发料时的應發量 > 应发 - 已发
         IF issue_qty>(g_sfba.sfba013-g_sfba.sfba016) THEN
            LET issue_qty=(g_sfba.sfba013-g_sfba.sfba016)
         END IF

         ##计算发料单上已产生的发料数量
         #CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
         ##计算剩下的应发量
         #LET issue_qty = issue_qty - l_qty
         #移到上面去 因asft310_01_get_sfba016中包含了此值
         
         IF issue_qty <= 0 THEN 
            CONTINUE FOREACH
         END IF
         
         #LET l_count = l_count + 1  #add 141226    #160726-00001#6 mark
         
         #當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料 141203 add
         IF NOT cl_null(g_imaa005) AND (g_sfba.sfba021 IS NULL OR g_sfba.sfba021=' ') THEN 
            CALL asft310_01_issue_feature1() #找出有库存的特征料件发料，同时减少剩余应发量issue_qty
            IF issue_qty <= 0 THEN 
               CONTINUE FOREACH
            END IF
         END IF
         
         CALL asft310_01_issue1()  #按不同发料方式发料

      END FOREACH  #工单备料单身
      FREE asft310_01_g_b13_sfba_p
   END FOREACH  #发退料 套数单身
   FREE asft310_01_g_b13_sfdb_c

   #add 141226
   #IF l_count = 0 THEN
   #   #无可产生的资料
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'asf-00242'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #ELSE
      IF g_count = 0 THEN
         #无资料产生！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   #add 141226 end
END FUNCTION
#成套退料
PRIVATE FUNCTION asft310_01_g_b21()
#161109-00085#30-s
#DEFINE l_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE l_sfdb       RECORD LIKE sfdb_t.*   #发退料 套数单身
DEFINE l_sfaa049    LIKE sfaa_t.sfaa049    #已發料套數
DEFINE l_sfdb006    LIKE sfdb_t.sfdb006    #預計套數
#161109-00085#30-e
#161205-00025#6-s
##DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身 #161109-00085#62 mark
##161109-00085#62 --s add
#DEFINE l_sfba RECORD  #工單備料單身檔
#       sfbaent LIKE sfba_t.sfbaent, #企業編號
#       sfbasite LIKE sfba_t.sfbasite, #營運據點
#       sfbadocno LIKE sfba_t.sfbadocno, #單號
#       sfbaseq LIKE sfba_t.sfbaseq, #項次
#       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
#       sfba001 LIKE sfba_t.sfba001, #上階料號
#       sfba002 LIKE sfba_t.sfba002, #部位
#       sfba003 LIKE sfba_t.sfba003, #作業編號
#       sfba004 LIKE sfba_t.sfba004, #作業序
#       sfba005 LIKE sfba_t.sfba005, #BOM料號
#       sfba006 LIKE sfba_t.sfba006, #發料料號
#       sfba007 LIKE sfba_t.sfba007, #投料時距
#       sfba008 LIKE sfba_t.sfba008, #必要特性
#       sfba009 LIKE sfba_t.sfba009, #倒扣料
#       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
#       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
#       sfba012 LIKE sfba_t.sfba012, #允許誤差率
#       sfba013 LIKE sfba_t.sfba013, #應發數量
#       sfba014 LIKE sfba_t.sfba014, #單位
#       sfba015 LIKE sfba_t.sfba015, #委外代買數量
#       sfba016 LIKE sfba_t.sfba016, #已發數量
#       sfba017 LIKE sfba_t.sfba017, #報廢數量
#       sfba018 LIKE sfba_t.sfba018, #盤虧數量
#       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
#       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
#       sfba021 LIKE sfba_t.sfba021, #產品特徵
#       sfba022 LIKE sfba_t.sfba022, #替代率
#       sfba023 LIKE sfba_t.sfba023, #標準應發數量
#       sfba024 LIKE sfba_t.sfba024, #調整應發數量
#       sfba025 LIKE sfba_t.sfba025, #超領數量
#       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
#       sfba027 LIKE sfba_t.sfba027, #SET替代群組
#       sfba028 LIKE sfba_t.sfba028, #客供料
#       sfba029 LIKE sfba_t.sfba029, #指定發料批號
#       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
#       sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
#       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
#       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
#       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
#       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
#       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
#       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
#       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
#       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
#       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
#       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
#       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
#       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
#       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
#       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
#       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
#       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
#       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
#       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
#       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
#       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
#       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
#       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
#       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
#       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
#       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
#       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
#       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
#       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
#       sfbaud030 LIKE sfba_t.sfbaud030, #自定義欄位(日期時間)030
#       sfba031 LIKE sfba_t.sfba031, #備置量
#       sfba032 LIKE sfba_t.sfba032, #備置理由碼
#       sfba033 LIKE sfba_t.sfba033, #保稅否
#       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
#       sfba035 LIKE sfba_t.sfba035  #SET替代套數
#END RECORD
##161109-00085#62 --e add
DEFINE l_sfba  RECORD  #工單備料單身檔
    sfba010    LIKE sfba_t.sfba010,  #標準QPA分子
    sfba011    LIKE sfba_t.sfba011   #標準QPA分母
END RECORD
#161205-00025#6-e
DEFINE l_qty        LIKE sfdb_t.sfdb006    #发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
DEFINE l_qty2       LIKE sfdb_t.sfdb006    #有替代料的情况：原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
DEFINE l_sets       LIKE sfdb_t.sfdb006    #160726-00001#6
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_flag2      LIKE type_t.num5       #s_control使用
#DEFINE l_count      LIKE type_t.num10       #add 141226    #170104-00066#2 num5->num10  17/01/06 mod by rainy  #160726-00001#6 mark

      #LET l_count = 0  #Add 141226  #160726-00001#6 mark
      #161118-00033#1-s  #161109-00085#30-s
      #LET g_sql = "SELECT sfba_t.*,sfdb_t.*,sfaa_t.*,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      LET g_sql = "SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005, ",
                  "       sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015, ",
                  "       sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025, ",
                  "       sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035, ",
                  "       sfba036, ",  #160726-00001#6
                  "       sfdb006,sfaa049,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      #161118-00033#1-e  #161109-00085#30-e
                  "  FROM sfba_t,imaa_t,imaf_t,imae_t,sfdb_t,sfaa_t ",
                  " WHERE sfbaent = imaaent AND sfba006 = imaa001 ",
                  "   AND sfbaent = imafent AND sfbasite = imafsite AND sfba006 = imaf001 ",
                  "   AND sfbaent = imaeent AND sfbasite = imaesite AND sfba006 = imae001 ",
                  "   AND sfbaent = sfdbent AND sfbadocno= sfdb001 ",
                  "   AND sfbaent = sfaaent AND sfbadocno=sfaadocno ",
                  "   AND sfbaent = ",g_enterprise,
                  "   AND sfdbdocno='",g_sfdadocno,"' ",
                  #"   AND sfbadocno= '",l_sfdb.sfdb001,"' ",   #工单单号
                  "   AND sfba009  = 'N' ",          #倒扣料
                  "   AND sfba016  > 0 ",            #已发>0
                  "   AND sfba008 != '4' ",          #非参考材料
                  "   AND ",tm.wc CLIPPED      #画面QBE条件
            
      #关于控制组
      CALL s_control_get_doc_sql("imaf016",g_sfdadocno,'4')   #下面开窗中的据点生命周期、需限制的单据、4代表产品生命周期检核
         RETURNING l_success,l_where     #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      CALL s_control_get_doc_sql("imaa009",g_sfdadocno,'5')
         RETURNING l_success,l_where      #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end

      LET g_sql = g_sql CLIPPED," ORDER BY sfbaseq,sfbaseq1"
      PREPARE asft310_01_g_b21_sfba_p FROM g_sql
      DECLARE asft310_01_g_b21_sfba_c CURSOR FOR asft310_01_g_b21_sfba_p
      #161118-00033#1-s  #161109-00085#30-s
      #FOREACH asft310_01_g_b21_sfba_c INTO g_sfba.*,l_sfdb.*,l_sfaa.*,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      FOREACH asft310_01_g_b21_sfba_c
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035,
              g_sfba.sfba036,  #160726-00001#6
              l_sfdb006,l_sfaa049,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      #161118-00033#1-e  #161109-00085#30-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_g_b21_sfba_c err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         #IF g_sfba.sfbaseq1 > 0 THEN  #替代料
            #抓出原件资料
            #161205-00025#6-s
            ##SELECT * INTO l_sfba.* FROM sfba_t #161109-00085#62 mark
            ##161109-00085#62 --s add
            #SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
            #       sfba001,sfba002,sfba003,sfba004,sfba005,
            #       sfba006,sfba007,sfba008,sfba009,sfba010,
            #       sfba011,sfba012,sfba013,sfba014,sfba015,
            #       sfba016,sfba017,sfba018,sfba019,sfba020,
            #       sfba021,sfba022,sfba023,sfba024,sfba025,
            #       sfba026,sfba027,sfba028,sfba029,sfba030,
            #       sfbaud001,sfbaud002,sfbaud003,sfbaud004,sfbaud005,
            #       sfbaud006,sfbaud007,sfbaud008,sfbaud009,sfbaud010,
            #       sfbaud011,sfbaud012,sfbaud013,sfbaud014,sfbaud015,
            #       sfbaud016,sfbaud017,sfbaud018,sfbaud019,sfbaud020,
            #       sfbaud021,sfbaud022,sfbaud023,sfbaud024,sfbaud025,
            #       sfbaud026,sfbaud027,sfbaud028,sfbaud029,sfbaud030,
            #       sfba031,sfba032,sfba033,sfba034,sfba035
            #  INTO l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
            #       l_sfba.sfba001,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,
            #       l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,l_sfba.sfba010,
            #       l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,
            #       l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
            #       l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,l_sfba.sfba024,l_sfba.sfba025,
            #       l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
            #       l_sfba.sfbaud001,l_sfba.sfbaud002,l_sfba.sfbaud003,l_sfba.sfbaud004,l_sfba.sfbaud005,
            #       l_sfba.sfbaud006,l_sfba.sfbaud007,l_sfba.sfbaud008,l_sfba.sfbaud009,l_sfba.sfbaud010,
            #       l_sfba.sfbaud011,l_sfba.sfbaud012,l_sfba.sfbaud013,l_sfba.sfbaud014,l_sfba.sfbaud015,
            #       l_sfba.sfbaud016,l_sfba.sfbaud017,l_sfba.sfbaud018,l_sfba.sfbaud019,l_sfba.sfbaud020,
            #       l_sfba.sfbaud021,l_sfba.sfbaud022,l_sfba.sfbaud023,l_sfba.sfbaud024,l_sfba.sfbaud025,
            #       l_sfba.sfbaud026,l_sfba.sfbaud027,l_sfba.sfbaud028,l_sfba.sfbaud029,l_sfba.sfbaud030,
            #       l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035
            #  FROM sfba_t
            ##161109-00085#62 --e add
            SELECT sfba010,sfba011
              INTO l_sfba.sfba010,l_sfba.sfba011
              FROM sfba_t
            #161205-00025#6-e
             WHERE sfbaent   = g_sfba.sfbaent
               AND sfbadocno = g_sfba.sfbadocno
               AND sfbaseq   = g_sfba.sfbaseq
               AND sfbaseq1  = 0
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
         #END IF
         
         #指定仓库储位
         IF cl_null(g_sfba.sfba019) THEN LET g_sfba.sfba019 = ' '  END IF
         IF cl_null(g_sfba.sfba020) THEN LET g_sfba.sfba020 = ' '  END IF
         IF cl_null(g_sfba.sfba029) THEN LET g_sfba.sfba029 = ' '  END IF
         IF cl_null(g_sfba.sfba030) THEN LET g_sfba.sfba030 = ' '  END IF
         #预设仓库储位
         IF cl_null(g_imaf091) THEN LET g_imaf091 = ' ' END IF
         IF cl_null(g_imaf092) THEN LET g_imaf092 = ' ' END IF
         #预设发料/退料库位储位
         IF cl_null(g_imae101) THEN LET g_imae101 = ' ' END IF
         IF cl_null(g_imae102) THEN LET g_imae102 = ' ' END IF
         IF cl_null(g_imae103) THEN LET g_imae103 = ' ' END IF
         IF cl_null(g_imae104) THEN LET g_imae104 = ' ' END IF
         
         #退料时的應退量
         IF l_sfdb006 = l_sfaa049 THEN  #預計退料套數=已發套數  全退  #161109-00085#30
            #已發數量 
            LET issue_qty = g_sfba.sfba016
         ELSE
            #160726-00001#6-s
            IF g_sfba.sfba026 = '1' THEN  #非SET替代
               LET l_sets = l_sfdb006
            ELSE  #SET替代
               LET l_sets = 0
               #抓取替代同一群組已替代套數
               SELECT SUM(MAX(sfba036)) INTO l_sets FROM sfba_t
                WHERE sfbaent = g_sfba.sfbaent AND sfbadocno = g_sfba.sfbadocno
                  AND sfbaseq > g_sfba.sfbaseq AND sfba034 = g_sfba.sfba034
                  AND sfba027 <> g_sfba.sfba027 GROUP BY sfba027
               IF cl_null(l_sets) THEN LET l_sets = 0 END IF
               #後面項次已符合需求故離開
               IF l_sfdb006 <= l_sets THEN
                  CONTINUE FOREACH
               END IF
               #本群組已發套數
               IF g_sfba.sfba036 < l_sfdb006 - l_sets THEN
                  LET l_sets = g_sfba.sfba036
               ELSE
                  LET l_sets = l_sfdb006 - l_sets
               END IF
            END IF
            #預計退料套數*標準QPA分子/標準QPA分母
            IF g_sfba.sfbaseq1 = 0 THEN  #非替代料
               LET issue_qty = l_sets * g_sfba.sfba010 / g_sfba.sfba011  #161109-00085#30
            ELSE  #替代料
               #原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
               CALL asft310_01_get_qty2(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,l_sfba.sfba010,l_sfba.sfba011) RETURNING l_qty2
               #(预计退料套数 - 已产生过的套数) * 原件的QPA * 替代率 =未产生的套数*元件QPA*替代率=元件应发量*替代率=替代料的应发量
               LET issue_qty = ((l_sets - l_qty2) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022  #161109-00085#30
            END IF
            ##預計退料套數*標準QPA分子/標準QPA分母
            #IF g_sfba.sfbaseq1 = 0 THEN  #非替代料
            #   LET issue_qty = l_sfdb006 * g_sfba.sfba010 / g_sfba.sfba011  #161109-00085#30
            #ELSE  #替代料
            #   #原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
            #   #161205-00025#6-s
            #   #CALL asft310_01_get_qty2(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,l_sfba.*) RETURNING l_qty2
            #   CALL asft310_01_get_qty2(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,l_sfba.sfba010,l_sfba.sfba011) RETURNING l_qty2
            #   #161205-00025#6-e
            #   #(预计退料套数 - 已产生过的套数) * 原件的QPA * 替代率 =未产生的套数*元件QPA*替代率=元件应发量*替代率=替代料的应发量
            #   LET issue_qty = ((l_sfdb006 - l_qty2) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022  #161109-00085#30
            #END IF
            #160726-00001#6-e
         END IF

         #add 150115  单位取位
         CALL s_aooi250_get_msg(g_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
         END IF
         #add 150115 end
         
         #应退>已发
         IF issue_qty>g_sfba.sfba016 THEN
            LET issue_qty=g_sfba.sfba016
         END IF

         #计算发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
         CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
         #计算剩下的应退量
         LET issue_qty = issue_qty - l_qty
         #不用移到上面去 asft310_01_get_qty2中并未包含此值，有控制项序小于当前项序的，所以本项序没算到
         
         IF issue_qty <= 0 THEN 
            CONTINUE FOREACH
         END IF
         
         #LET l_count = l_count + 1  #add 141226  #160726-00001#6 mark
         
         #當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料 141208 add
         IF NOT cl_null(g_imaa005) AND (g_sfba.sfba021 IS NULL OR g_sfba.sfba021=' ') THEN 
            CALL asft310_01_issue_feature2() #找出有库存特征的发料及退料，计算该特征可退的量,再按不同退料方式退料
         ELSE
            CALL asft310_01_issue2()  #按不同退料方式退料
         END IF
         
      END FOREACH  #工单备料单身
      FREE asft310_01_g_b21_sfba_p

   #add 141226
   #IF l_count = 0 THEN
   #   #无可产生的资料
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'asf-00242'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #ELSE
      IF g_count = 0 THEN
         #无资料产生！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   #add 141226 end
END FUNCTION
#超领退料
PRIVATE FUNCTION asft310_01_g_b22()
#161109-00085#30-s
#DEFINE l_sfaa       RECORD LIKE sfaa_t.*   #工单单头
#DEFINE l_sfdb       RECORD LIKE sfdb_t.*   #发退料 套数单身
DEFINE l_sfdb006    LIKE sfdb_t.sfdb006    #預計套數
#161109-00085#30-e
#161205-00025#6-s
##DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身 #161109-00085#62 mark
##161109-00085#62 --s add
#DEFINE l_sfba RECORD  #工單備料單身檔
#       sfbaent LIKE sfba_t.sfbaent, #企業編號
#       sfbasite LIKE sfba_t.sfbasite, #營運據點
#       sfbadocno LIKE sfba_t.sfbadocno, #單號
#       sfbaseq LIKE sfba_t.sfbaseq, #項次
#       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
#       sfba001 LIKE sfba_t.sfba001, #上階料號
#       sfba002 LIKE sfba_t.sfba002, #部位
#       sfba003 LIKE sfba_t.sfba003, #作業編號
#       sfba004 LIKE sfba_t.sfba004, #作業序
#       sfba005 LIKE sfba_t.sfba005, #BOM料號
#       sfba006 LIKE sfba_t.sfba006, #發料料號
#       sfba007 LIKE sfba_t.sfba007, #投料時距
#       sfba008 LIKE sfba_t.sfba008, #必要特性
#       sfba009 LIKE sfba_t.sfba009, #倒扣料
#       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
#       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
#       sfba012 LIKE sfba_t.sfba012, #允許誤差率
#       sfba013 LIKE sfba_t.sfba013, #應發數量
#       sfba014 LIKE sfba_t.sfba014, #單位
#       sfba015 LIKE sfba_t.sfba015, #委外代買數量
#       sfba016 LIKE sfba_t.sfba016, #已發數量
#       sfba017 LIKE sfba_t.sfba017, #報廢數量
#       sfba018 LIKE sfba_t.sfba018, #盤虧數量
#       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
#       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
#       sfba021 LIKE sfba_t.sfba021, #產品特徵
#       sfba022 LIKE sfba_t.sfba022, #替代率
#       sfba023 LIKE sfba_t.sfba023, #標準應發數量
#       sfba024 LIKE sfba_t.sfba024, #調整應發數量
#       sfba025 LIKE sfba_t.sfba025, #超領數量
#       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
#       sfba027 LIKE sfba_t.sfba027, #SET替代群組
#       sfba028 LIKE sfba_t.sfba028, #客供料
#       sfba029 LIKE sfba_t.sfba029, #指定發料批號
#       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
#       sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
#       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
#       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
#       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
#       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
#       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
#       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
#       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
#       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
#       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
#       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
#       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
#       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
#       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
#       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
#       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
#       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
#       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
#       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
#       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
#       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
#       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
#       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
#       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
#       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
#       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
#       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
#       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
#       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
#       sfbaud030 LIKE sfba_t.sfbaud030, #自定義欄位(日期時間)030
#       sfba031 LIKE sfba_t.sfba031, #備置量
#       sfba032 LIKE sfba_t.sfba032, #備置理由碼
#       sfba033 LIKE sfba_t.sfba033, #保稅否
#       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
#       sfba035 LIKE sfba_t.sfba035  #SET替代套數
#END RECORD
##161109-00085#62 --e add
DEFINE l_sfba  RECORD  #工單備料單身檔
    sfba010    LIKE sfba_t.sfba010,  #標準QPA分子
    sfba011    LIKE sfba_t.sfba011   #標準QPA分母
END RECORD
#161205-00025#6-e
DEFINE l_qty        LIKE sfdb_t.sfdb006    #发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
DEFINE l_qty2       LIKE sfdb_t.sfdb006    #有替代料的情况：原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
DEFINE l_success    LIKE type_t.num5
DEFINE l_where      STRING
DEFINE l_flag2      LIKE type_t.num5       #s_control使用
DEFINE l_count      LIKE type_t.num10       #add 141226     #170104-00066#2 num5->num10  17/01/06 mod by rainy 

      LET l_count = 0  #Add 141226
      #161118-00033#1-s  #161109-00085#30-s
      #LET g_sql = "SELECT sfba_t.*,sfdb_t.*,sfaa_t.*,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      LET g_sql = "SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,sfba001,sfba002,sfba003,sfba004,sfba005, ",
                  "       sfba006,sfba007,sfba008,sfba009,sfba010,sfba011,sfba012,sfba013,sfba014,sfba015, ",
                  "       sfba016,sfba017,sfba018,sfba019,sfba020,sfba021,sfba022,sfba023,sfba024,sfba025, ",
                  "       sfba026,sfba027,sfba028,sfba029,sfba030,sfba031,sfba032,sfba033,sfba034,sfba035, ",
                  "       sfba036, ",  #160726-00001#6
                  "       sfdb006,imaf091,imaf092,imae101,imae102,imae103,imae104,imae092,imaa005 ",
      #161118-00033#1-e  #161109-00085#30-e
                  "  FROM sfba_t,imaa_t,imaf_t,imae_t,sfdb_t,sfaa_t ",
                  " WHERE sfbaent = imaaent AND sfba006 = imaa001 ",
                  "   AND sfbaent = imafent AND sfbasite = imafsite AND sfba006 = imaf001 ",
                  "   AND sfbaent = imaeent AND sfbasite = imaesite AND sfba006 = imae001 ",
                  "   AND sfbaent = sfdbent AND sfbadocno= sfdb001 ",
                  "   AND sfbaent = sfaaent AND sfbadocno=sfaadocno ",
                  "   AND sfbaent = ",g_enterprise,
                  "   AND sfdbdocno='",g_sfdadocno,"' ",
                  #"   AND sfbadocno= '",l_sfdb.sfdb001,"' ",   #工单单号
                  "   AND sfba009  = 'N' ",          #倒扣料
                  "   AND sfba025  > 0 ",            #超领>0
                  "   AND sfba008 != '4' ",          #非参考材料
                  "   AND ",tm.wc CLIPPED      #画面QBE条件
            
      #关于控制组
      CALL s_control_get_doc_sql("imaf016",g_sfdadocno,'4')   #下面开窗中的据点生命周期、需限制的单据、4代表产品生命周期检核
         RETURNING l_success,l_where     #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      CALL s_control_get_doc_sql("imaa009",g_sfdadocno,'5')
         RETURNING l_success,l_where      #num5和STRING类型
      IF l_success THEN
         LET g_sql = g_sql CLIPPED," AND ",l_where
      END IF
      #关于控制组--end
         
      LET g_sql = g_sql CLIPPED," ORDER BY sfbaseq,sfbaseq1"
      PREPARE asft310_01_g_b22_sfba_p FROM g_sql
      DECLARE asft310_01_g_b22_sfba_c CURSOR FOR asft310_01_g_b22_sfba_p
      #161118-00033#1-s  #161109-00085#30-s
      #FOREACH asft310_01_g_b22_sfba_c INTO g_sfba.*,l_sfdb.*,l_sfaa.*,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      FOREACH asft310_01_g_b22_sfba_c
         INTO g_sfba.sfbaent,g_sfba.sfbasite,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,
              g_sfba.sfba001,g_sfba.sfba002,g_sfba.sfba003,g_sfba.sfba004,g_sfba.sfba005,
              g_sfba.sfba006,g_sfba.sfba007,g_sfba.sfba008,g_sfba.sfba009,g_sfba.sfba010,
              g_sfba.sfba011,g_sfba.sfba012,g_sfba.sfba013,g_sfba.sfba014,g_sfba.sfba015,
              g_sfba.sfba016,g_sfba.sfba017,g_sfba.sfba018,g_sfba.sfba019,g_sfba.sfba020,
              g_sfba.sfba021,g_sfba.sfba022,g_sfba.sfba023,g_sfba.sfba024,g_sfba.sfba025,
              g_sfba.sfba026,g_sfba.sfba027,g_sfba.sfba028,g_sfba.sfba029,g_sfba.sfba030,
              g_sfba.sfba031,g_sfba.sfba032,g_sfba.sfba033,g_sfba.sfba034,g_sfba.sfba035,
              g_sfba.sfba036,  #160726-00001#6
              l_sfdb006,g_imaf091,g_imaf092,g_imae101,g_imae102,g_imae103,g_imae104,g_imae092,g_imaa005  #工单备料单身
      #161118-00033#1-e  #161109-00085#30-e
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'foreach asft310_01_g_b22_sfba_c err'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         
         #IF g_sfba.sfbaseq1 > 0 THEN  #替代料
            #抓出原件资料
            #161205-00025#6-s
            ##SELECT * INTO l_sfba.* FROM sfba_t #161109-00085#62 mark
            ##161109-00085#62 --s add
            #SELECT sfbaent,sfbasite,sfbadocno,sfbaseq,sfbaseq1,
            #       sfba001,sfba002,sfba003,sfba004,sfba005,
            #       sfba006,sfba007,sfba008,sfba009,sfba010,
            #       sfba011,sfba012,sfba013,sfba014,sfba015,
            #       sfba016,sfba017,sfba018,sfba019,sfba020,
            #       sfba021,sfba022,sfba023,sfba024,sfba025,
            #       sfba026,sfba027,sfba028,sfba029,sfba030,
            #       sfba031,sfba032,sfba033,sfba034,sfba035
            #  INTO l_sfba.sfbaent,l_sfba.sfbasite,l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,
            #       l_sfba.sfba001,l_sfba.sfba002,l_sfba.sfba003,l_sfba.sfba004,l_sfba.sfba005,
            #       l_sfba.sfba006,l_sfba.sfba007,l_sfba.sfba008,l_sfba.sfba009,l_sfba.sfba010,
            #       l_sfba.sfba011,l_sfba.sfba012,l_sfba.sfba013,l_sfba.sfba014,l_sfba.sfba015,
            #       l_sfba.sfba016,l_sfba.sfba017,l_sfba.sfba018,l_sfba.sfba019,l_sfba.sfba020,
            #       l_sfba.sfba021,l_sfba.sfba022,l_sfba.sfba023,l_sfba.sfba024,l_sfba.sfba025,
            #       l_sfba.sfba026,l_sfba.sfba027,l_sfba.sfba028,l_sfba.sfba029,l_sfba.sfba030,
            #       l_sfba.sfba031,l_sfba.sfba032,l_sfba.sfba033,l_sfba.sfba034,l_sfba.sfba035
            #  FROM sfba_t
            ##161109-00085#62 --e add
            SELECT sfba010,sfba011
              INTO l_sfba.sfba010,l_sfba.sfba011
              FROM sfba_t
            #161205-00025#6-e
             WHERE sfbaent   = g_sfba.sfbaent
               AND sfbadocno = g_sfba.sfbadocno
               AND sfbaseq   = g_sfba.sfbaseq
               AND sfbaseq1  = 0
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
         #END IF

         #指定仓库储位
         IF cl_null(g_sfba.sfba019) THEN LET g_sfba.sfba019 = ' '  END IF
         IF cl_null(g_sfba.sfba020) THEN LET g_sfba.sfba020 = ' '  END IF
         IF cl_null(g_sfba.sfba029) THEN LET g_sfba.sfba029 = ' '  END IF
         IF cl_null(g_sfba.sfba030) THEN LET g_sfba.sfba030 = ' '  END IF
         #预设仓库储位
         IF cl_null(g_imaf091) THEN LET g_imaf091 = ' ' END IF
         IF cl_null(g_imaf092) THEN LET g_imaf092 = ' ' END IF
         #预设发料/退料库位储位
         IF cl_null(g_imae101) THEN LET g_imae101 = ' ' END IF
         IF cl_null(g_imae102) THEN LET g_imae102 = ' ' END IF
         IF cl_null(g_imae103) THEN LET g_imae103 = ' ' END IF
         IF cl_null(g_imae104) THEN LET g_imae104 = ' ' END IF
         
         #退料时的應退量
         #預計退料套數*標準QPA分子/標準QPA分母
         IF g_sfba.sfbaseq1 = 0 THEN  #非替代料
            LET issue_qty = l_sfdb006 * g_sfba.sfba010 / g_sfba.sfba011  #161109-00085#30
         ELSE  #替代料
            #原件，及其他替代料已产生到本画面上单身处已产生的sfdc007对应套数
            #161205-00025#6-s
            #CALL asft310_01_get_qty2(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,l_sfba.*) RETURNING l_qty2
            CALL asft310_01_get_qty2(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,l_sfba.sfba010,l_sfba.sfba011) RETURNING l_qty2
            #161205-00025#6-e
            #(预计退料套数 - 已产生过的套数) * 原件的QPA * 替代率 =未产生的套数*元件QPA*替代率=元件应发量*替代率=替代料的应发量
            LET issue_qty = ((l_sfdb006 - l_qty2) * l_sfba.sfba010 / l_sfba.sfba011)*g_sfba.sfba022  #161109-00085#30
         END IF

         #add 150115  单位取位
         CALL s_aooi250_get_msg(g_sfba.sfba014) RETURNING l_success,g_ooca002,g_ooca004
         IF l_success THEN
            CALL s_num_round('4',issue_qty,g_ooca002) RETURNING issue_qty  #151118-00016 by whitney modify g_ooca004-->'4'
         END IF
         #add 150115 end
         

         #应退量>已超领
         IF issue_qty>g_sfba.sfba025 THEN
            LET issue_qty=g_sfba.sfba025
         END IF

         #计算发料单上已产生的发料数量
         CALL asft310_01_get_qty(g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1) RETURNING l_qty
         #计算剩下的应退量
         LET issue_qty = issue_qty - l_qty
         #不用移到上面去 asft310_01_get_qty2中并未包含此值，有控制项序小于当前项序的，所以本项序没算到
         
         IF issue_qty <= 0 THEN 
            CONTINUE FOREACH
         END IF
         
         LET l_count = l_count + 1  #add 141226
         
         #當工單的特征料件未指定特徵時，先自動帶出有庫存的特徵資料 141208 add
         IF NOT cl_null(g_imaa005) AND (g_sfba.sfba021 IS NULL OR g_sfba.sfba021=' ') THEN 
            CALL asft310_01_issue_feature2() #找出有库存特征的发料及退料，计算该特征可退的量,再按不同退料方式退料
         ELSE
            CALL asft310_01_issue2()  #按不同退料方式退料
         END IF

      END FOREACH  #工单备料单身
      FREE asft310_01_g_b22_sfba_p

   #add 141226
   #IF l_count = 0 THEN
   #   #无可产生的资料
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'asf-00242'
   #   LET g_errparam.extend = ''
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #ELSE
      IF g_count = 0 THEN
         #无资料产生！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00530'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   #END IF
   #add 141226 end
END FUNCTION
#产生单身前的检查
PRIVATE FUNCTION asft310_01_generate_chk()
DEFINE r_column         LIKE type_t.chr10
DEFINE l_success        LIKE type_t.num5
DEFINE l_where          STRING
DEFINE l_flag2          LIKE type_t.num5   #s_control使用

   LET r_column = ''
   
   ##--inag004_i--仓库检查
   IF (g_prog[1,6] = 'asft31' AND tm.issue_type = '2') OR (g_prog[1,6] = 'asft32' AND tm.issue_type = '3') THEN  #自行制定库位储位批号
       IF cl_null(tm2.inag004_i) THEN
          #自行指定仓储批时，仓库一定要输入;请输入仓库！
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'asf-00340'
          LET g_errparam.extend = ''
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_column = 'inag004_i'
          RETURN r_column
       END IF
   END IF
   IF NOT cl_null(tm2.inag004_i) THEN
      #检查库存基础档
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = tm2.inag004_i
      #160318-00025#21  by 07900 --add-str
      LET g_errshow = TRUE #是否開窗                   
      LET g_chkparam.err_str[1] ="aim-00065:sub-01302|aini001|",cl_get_progname("aini001",g_lang,"2"),"|:EXEPROGaini001"
      #160318-00025#21  by 07900 --add-end
      IF NOT cl_chk_exist("v_inaa001_2") THEN
         LET r_column = 'inag004_i'
         RETURN r_column
      END IF
      
      #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
      CALL s_control_chk_doc('6',g_sfdadocno,tm2.inag004_i,'','','','') 
         RETURNING l_success,l_flag2
      IF NOT l_success OR NOT l_flag2 THEN
         #控制组检查错误,请检查单别设定的相关内容
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00122'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_column = 'inag004_i'
         RETURN r_column
      END IF
      
   END IF
   
   ##--inag005_i--储位检查
   IF NOT cl_null(tm2.inag005_i) THEN
      #需存在庫儲位資料
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = tm2.inag005_i
      IF NOT cl_chk_exist("v_inab002_3") THEN
         LET r_column = 'inag005_i'
         RETURN r_column
      END IF
               
      IF NOT cl_null(tm2.inag004_i) THEN
         #需存在庫儲位資料
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = g_site
         LET g_chkparam.arg2 = tm2.inag004_i
         LET g_chkparam.arg3 = tm2.inag005_i
         #160318-00025#21  by 07900 --add-str
         LET g_errshow = TRUE #是否開窗                   
         LET g_chkparam.err_str[1] ="aim-00063:sub-01302|aini002|",cl_get_progname("aini002",g_lang,"2"),"|:EXEPROGaini002"
         #160318-00025#21  by 07900 --add-end
         IF NOT cl_chk_exist("v_inab002") THEN
            LET r_column = 'inag005_i'
            RETURN r_column
         END IF
      
         #檢核輸入的庫位是否在單據別限制範圍內，若不在限制內則不允許使用此庫位
         CALL s_control_chk_doc('6',g_sfdadocno,tm2.inag004_i,tm2.inag005_i,'','','')
            RETURNING l_success,l_flag2
         IF NOT l_success OR NOT l_flag2 THEN
            #控制组检查错误,请检查单别设定的相关内容
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00122'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            LET r_column = 'inag005_i'
            RETURN r_column
         END IF
      END IF
   END IF
   
   ##--reason--理由码检查
   #由發料單別參數"發料理由碼不可空白"控制理由碼是不是一定要輸入
   #参数D-MFG-0032：發料理由碼是否可空白
   #IF cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0032') THEN
   CALL cl_get_doc_para(g_enterprise,g_site,g_ooba002,'D-MFG-0032') RETURNING g_para
   IF g_para = 'N' AND cl_null(tm.reason) THEN  #不可空白
      #单据别参数“D-MFG-0032：發料理由碼是否可空白”设置为必需输入理由码;请输入理由码！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00343'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_column = 'reason'
      RETURN r_column
   END IF
   IF NOT cl_null(tm.reason) THEN
      CALL s_azzi650_chk_exist_and_desc('226',tm.reason) RETURNING l_success,tm.reason_desc
      IF NOT l_success THEN
         LET r_column = 'reason'
         RETURN r_column
      END IF
      #控制组检查
      CALL s_control_chk_doc('8',g_sfdadocno,tm.reason,'','','','')
         RETURNING l_success,l_flag2
      IF NOT l_success OR NOT l_flag2 THEN
         #控制组检查错误,请检查单别设定的相关内容
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00122'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_column = 'reason'
         RETURN r_column
      END IF
   END IF
   
   RETURN r_column
END FUNCTION
#计算元件及其他替代料已产生到本画面单身上的sfdc007对应的套数
PRIVATE FUNCTION asft310_01_get_qty2(p_sfbadocno,p_sfbaseq,p_sfbaseq1,p_sfba_o)
DEFINE p_flag         LIKE type_t.chr1      #是否只算项序小于当笔的
DEFINE p_sfbadocno    LIKE sfba_t.sfbadocno #工单
DEFINE p_sfbaseq      LIKE sfba_t.sfbaseq   #项次
DEFINE p_sfbaseq1     LIKE sfba_t.sfbaseq1  #替代料所在项序
#161205-00025#6-s
##DEFINE p_sfba_o       RECORD LIKE sfba_t.*   #工单备料单身 #161109-00085#62 mark
##161109-00085#62 --s add
#DEFINE p_sfba_o RECORD  #工單備料單身檔
#       sfbaent LIKE sfba_t.sfbaent, #企業編號
#       sfbasite LIKE sfba_t.sfbasite, #營運據點
#       sfbadocno LIKE sfba_t.sfbadocno, #單號
#       sfbaseq LIKE sfba_t.sfbaseq, #項次
#       sfbaseq1 LIKE sfba_t.sfbaseq1, #項序
#       sfba001 LIKE sfba_t.sfba001, #上階料號
#       sfba002 LIKE sfba_t.sfba002, #部位
#       sfba003 LIKE sfba_t.sfba003, #作業編號
#       sfba004 LIKE sfba_t.sfba004, #作業序
#       sfba005 LIKE sfba_t.sfba005, #BOM料號
#       sfba006 LIKE sfba_t.sfba006, #發料料號
#       sfba007 LIKE sfba_t.sfba007, #投料時距
#       sfba008 LIKE sfba_t.sfba008, #必要特性
#       sfba009 LIKE sfba_t.sfba009, #倒扣料
#       sfba010 LIKE sfba_t.sfba010, #標準QPA分子
#       sfba011 LIKE sfba_t.sfba011, #標準QPA分母
#       sfba012 LIKE sfba_t.sfba012, #允許誤差率
#       sfba013 LIKE sfba_t.sfba013, #應發數量
#       sfba014 LIKE sfba_t.sfba014, #單位
#       sfba015 LIKE sfba_t.sfba015, #委外代買數量
#       sfba016 LIKE sfba_t.sfba016, #已發數量
#       sfba017 LIKE sfba_t.sfba017, #報廢數量
#       sfba018 LIKE sfba_t.sfba018, #盤虧數量
#       sfba019 LIKE sfba_t.sfba019, #指定發料倉庫
#       sfba020 LIKE sfba_t.sfba020, #指定發料儲位
#       sfba021 LIKE sfba_t.sfba021, #產品特徵
#       sfba022 LIKE sfba_t.sfba022, #替代率
#       sfba023 LIKE sfba_t.sfba023, #標準應發數量
#       sfba024 LIKE sfba_t.sfba024, #調整應發數量
#       sfba025 LIKE sfba_t.sfba025, #超領數量
#       sfba026 LIKE sfba_t.sfba026, #SET替代狀態
#       sfba027 LIKE sfba_t.sfba027, #SET替代群組
#       sfba028 LIKE sfba_t.sfba028, #客供料
#       sfba029 LIKE sfba_t.sfba029, #指定發料批號
#       sfba030 LIKE sfba_t.sfba030, #指定庫存管理特徵
#              sfbaud001 LIKE sfba_t.sfbaud001, #自定義欄位(文字)001
#       sfbaud002 LIKE sfba_t.sfbaud002, #自定義欄位(文字)002
#       sfbaud003 LIKE sfba_t.sfbaud003, #自定義欄位(文字)003
#       sfbaud004 LIKE sfba_t.sfbaud004, #自定義欄位(文字)004
#       sfbaud005 LIKE sfba_t.sfbaud005, #自定義欄位(文字)005
#       sfbaud006 LIKE sfba_t.sfbaud006, #自定義欄位(文字)006
#       sfbaud007 LIKE sfba_t.sfbaud007, #自定義欄位(文字)007
#       sfbaud008 LIKE sfba_t.sfbaud008, #自定義欄位(文字)008
#       sfbaud009 LIKE sfba_t.sfbaud009, #自定義欄位(文字)009
#       sfbaud010 LIKE sfba_t.sfbaud010, #自定義欄位(文字)010
#       sfbaud011 LIKE sfba_t.sfbaud011, #自定義欄位(數字)011
#       sfbaud012 LIKE sfba_t.sfbaud012, #自定義欄位(數字)012
#       sfbaud013 LIKE sfba_t.sfbaud013, #自定義欄位(數字)013
#       sfbaud014 LIKE sfba_t.sfbaud014, #自定義欄位(數字)014
#       sfbaud015 LIKE sfba_t.sfbaud015, #自定義欄位(數字)015
#       sfbaud016 LIKE sfba_t.sfbaud016, #自定義欄位(數字)016
#       sfbaud017 LIKE sfba_t.sfbaud017, #自定義欄位(數字)017
#       sfbaud018 LIKE sfba_t.sfbaud018, #自定義欄位(數字)018
#       sfbaud019 LIKE sfba_t.sfbaud019, #自定義欄位(數字)019
#       sfbaud020 LIKE sfba_t.sfbaud020, #自定義欄位(數字)020
#       sfbaud021 LIKE sfba_t.sfbaud021, #自定義欄位(日期時間)021
#       sfbaud022 LIKE sfba_t.sfbaud022, #自定義欄位(日期時間)022
#       sfbaud023 LIKE sfba_t.sfbaud023, #自定義欄位(日期時間)023
#       sfbaud024 LIKE sfba_t.sfbaud024, #自定義欄位(日期時間)024
#       sfbaud025 LIKE sfba_t.sfbaud025, #自定義欄位(日期時間)025
#       sfbaud026 LIKE sfba_t.sfbaud026, #自定義欄位(日期時間)026
#       sfbaud027 LIKE sfba_t.sfbaud027, #自定義欄位(日期時間)027
#       sfbaud028 LIKE sfba_t.sfbaud028, #自定義欄位(日期時間)028
#       sfbaud029 LIKE sfba_t.sfbaud029, #自定義欄位(日期時間)029
#       sfbaud030 LIKE sfba_t.sfbaud030, #自定義欄位(日期時間)030
#       sfba031 LIKE sfba_t.sfba031, #備置量
#       sfba032 LIKE sfba_t.sfba032, #備置理由碼
#       sfba033 LIKE sfba_t.sfba033, #保稅否
#       sfba034 LIKE sfba_t.sfba034, #SET被替代群組
#       sfba035 LIKE sfba_t.sfba035  #SET替代套數
#END RECORD
##161109-00085#62 --e add
DEFINE p_sfba_o  RECORD  #工單備料單身檔
    sfba010    LIKE sfba_t.sfba010,  #標準QPA分子
    sfba011    LIKE sfba_t.sfba011   #標準QPA分母
END RECORD
#161205-00025#6-e
DEFINE r_qty          LIKE sfdb_t.sfdb006   #备料已产生本张单据的套数
DEFINE l_qty          LIKE sfdc_t.sfdc007   #发退料量
DEFINE l_sql          STRING
#161109-00085#30-s
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq   LIKE sfba_t.sfbaseq,   #項次
       sfbaseq1  LIKE sfba_t.sfbaseq1,  #項序
       sfba022   LIKE sfba_t.sfba022    #替代率
END RECORD
#161109-00085#30-e

   LET r_qty = 0
   
   #161109-00085#30-s
   #LET l_sql = " SELECT * FROM sfba_t ",
   LET l_sql = " SELECT sfbadocno,sfbaseq,sfbaseq1,sfba022 ",
               "   FROM sfba_t ",
   #161109-00085#30-e
               "  WHERE sfbaent   = ",g_enterprise,
               "    AND sfbadocno = '",p_sfbadocno,"' ",
               "    AND sfbaseq   = ",p_sfbaseq
   #IF p_flag = 'Y' THEN
      LET l_sql = l_sql CLIPPED," AND sfbaseq1  < ",p_sfbaseq1
   #END IF
   LET l_sql = l_sql CLIPPED," ORDER BY sfbaseq1 "
   PREPARE asft310_01_get_qty2_p FROM l_sql
   DECLARE asft310_01_get_qty2_c CURSOR FOR asft310_01_get_qty2_p
   #161109-00085#30-s
   #FOREACH asft310_01_get_qty2_c INTO l_sfba.* #工单备料单身
   FOREACH asft310_01_get_qty2_c INTO l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba022
   #161109-00085#30-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_get_qty2_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      #计算发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
      CALL asft310_01_get_qty(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1) RETURNING l_qty
      IF l_sfba.sfbaseq1 = 0 THEN #原料
         LET r_qty = r_qty + l_qty * p_sfba_o.sfba011 / p_sfba_o.sfba010
      ELSE  #替代料,先换算成原料
         LET r_qty = r_qty + (l_qty / l_sfba.sfba022) * p_sfba_o.sfba011 / p_sfba_o.sfba010
      END IF
   END FOREACH
   
   RETURN r_qty
END FUNCTION
#计算发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
PRIVATE FUNCTION asft310_01_get_qty(p_sfbadocno,p_sfbaseq,p_sfbaseq1)
DEFINE p_sfbadocno    LIKE sfba_t.sfbadocno #工单
DEFINE p_sfbaseq      LIKE sfba_t.sfbaseq   #项次
DEFINE p_sfbaseq1     LIKE sfba_t.sfbaseq1  #替代料所在项序
DEFINE r_qty          LIKE sfdb_t.sfdb006
DEFINE l_sfdc007      LIKE sfdc_t.sfdc007 
DEFINE l_sfdc007_tmp  LIKE sfdc_t.sfdc007

   LET r_qty = 0

   #不用考虑不同单位、取替代,因为sfdc上的单位默认带出工单单位不能修改，sfdc上也不能增加取替代，在sfdd上才有这个功能
   SELECT SUM(sfdc007) INTO l_sfdc007 FROM sfdc_t
    WHERE sfdcent = g_enterprise
      AND sfdcdocno=g_sfdadocno  #当前发退料单 已经包含了发料类型的概念，不能随意mark，否则发退料都sum起来的值不具有意义
      AND sfdc001 = p_sfbadocno  #工单单号
      AND sfdc002 = p_sfbaseq    #工单项次
      AND sfdc003 = p_sfbaseq1   #工单项序
   IF cl_null(l_sfdc007) THEN LET l_sfdc007 = 0 END IF
 
   #计算本画面上单身处已产生的sfdc007
   SELECT SUM(sfdc007) INTO l_sfdc007_tmp FROM asft310_01_sfdc_t
    WHERE sfdcent = g_enterprise
      AND sfdcdocno=g_sfdadocno
      AND sfdc001 = p_sfbadocno  #工单单号
      AND sfdc002 = p_sfbaseq    #工单项次
      AND sfdc003 = p_sfbaseq1   #工单项序
   IF cl_null(l_sfdc007_tmp) THEN LET l_sfdc007_tmp = 0 END IF
   
   LET r_qty = l_sfdc007 + l_sfdc007_tmp
   RETURN r_qty
END FUNCTION

#p_flag1='1':计算本单据上所有已发量(包含元件+所有替代料的已发量)(不包括备料档中的资料)，折算成元件的已发量
#p_flag1='2':计算备料+本单据上所有已发量(包含元件+所有替代料的已发量)，折算成元件的已发量
PRIVATE FUNCTION asft310_01_get_sfba016(p_flag1,p_sfbadocno,p_sfbaseq)
DEFINE p_flag1        LIKE type_t.chr1      #注记1 1:仅本单据上，不包括备料档中的资料  2:备料+本单据上
DEFINE p_sfbadocno    LIKE sfba_t.sfbadocno #工单
DEFINE p_sfbaseq      LIKE sfba_t.sfbaseq   #项次
DEFINE r_sfba016      LIKE sfba_t.sfba016
DEFINE l_qty          LIKE sfdc_t.sfdc007   #发退料量
DEFINE l_sql          STRING
#161109-00085#30-s
#DEFINE l_sfba       RECORD LIKE sfba_t.*   #工单备料单身
DEFINE l_sfba RECORD  #工單備料單身檔
       sfbadocno LIKE sfba_t.sfbadocno, #單號
       sfbaseq   LIKE sfba_t.sfbaseq,   #項次
       sfbaseq1  LIKE sfba_t.sfbaseq1,  #項序
       sfba016   LIKE sfba_t.sfba016,   #已發數量
       sfba022   LIKE sfba_t.sfba022    #替代率
END RECORD
#161109-00085#30-e

   LET r_sfba016 = 0
   
   #161109-00085#30-s
   #LET l_sql = " SELECT * FROM sfba_t ",
   LET l_sql = " SELECT sfbadocno,sfbaseq,sfbaseq1,sfba016,sfba022 ",
               "   FROM sfba_t ",
   #161109-00085#30-e
               "  WHERE sfbaent   = ",g_enterprise,
               "    AND sfbadocno = '",p_sfbadocno,"' ",
               "    AND sfbaseq   = ",p_sfbaseq,
               " ORDER BY sfbaseq1 "
   PREPARE asft310_01_get_sfba016_p FROM l_sql
   DECLARE asft310_01_get_sfba016_c CURSOR FOR asft310_01_get_sfba016_p
   #161109-00085#30-s
   #FOREACH asft310_01_get_sfba016_c INTO l_sfba.* #工单备料单身
   FOREACH asft310_01_get_sfba016_c INTO l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1,l_sfba.sfba016,l_sfba.sfba022
   #161109-00085#30-e
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_get_sfba016_c err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #计算发料单上已产生的发料数量 --实体sfdc中的和本画面上临时sfdc中的
      CALL asft310_01_get_qty(l_sfba.sfbadocno,l_sfba.sfbaseq,l_sfba.sfbaseq1) RETURNING l_qty
      
      CASE p_flag1
         WHEN '1' #仅本单据上，不包括备料档中的资料
              IF l_sfba.sfbaseq1 = 0 THEN #原料
                 LET r_sfba016 = r_sfba016 + l_qty
              ELSE  #替代料,先换算成原料
                 LET r_sfba016 = r_sfba016 + l_qty / l_sfba.sfba022
              END IF
         WHEN '2' #备料+本单据上
              IF l_sfba.sfbaseq1 = 0 THEN #原料
                 LET r_sfba016 = r_sfba016 + l_sfba.sfba016 + l_qty
              ELSE  #替代料,先换算成原料
                 LET r_sfba016 = r_sfba016 + (l_sfba.sfba016 + l_qty) / l_sfba.sfba022
              END IF
      END CASE
   END FOREACH
   
   RETURN r_sfba016
END FUNCTION

#检查传入特征可退数量（已发-已退-待退）
#add 141209
PRIVATE FUNCTION asft310_01_chk_feature2()
   DEFINE r_success  LIKE type_t.num5
   DEFINE l_imaa005  LIKE imaa_t.imaa005
   DEFINE l_sql      STRING
   DEFINE l_sfdd006  LIKE sfdd_t.sfdd006  #退料单位
   DEFINE l_sfdd007  LIKE sfdd_t.sfdd007  #发料数量
   DEFINE l_qty      LIKE sfdc_t.sfdc007  #此特征可退量
   DEFINE l_qty1     LIKE sfdc_t.sfdc007  #已发量
   DEFINE l_qty2     LIKE sfdc_t.sfdc007  #已退量
   DEFINE l_rate     LIKE inaj_t.inaj014  #单位换算率
   
   LET r_success = TRUE
   #做产品特征管理的料件检查该特征的退料量不可超过已发量
   IF cl_null(g_sfdc_d[l_ac].sfdc001) OR cl_null(g_sfdc_d[l_ac].sfdc002) OR cl_null(g_sfdc_d[l_ac].sfdc003)
   OR cl_null(g_sfdc_d[l_ac].sfdc004) OR cl_null(g_sfdc_d[l_ac].sfdc005) 
   OR cl_null(g_sfdc_d[l_ac].sfdc006)   #单位
   OR cl_null(g_sfdc_d[l_ac].sfdc007) OR g_sfdc_d[l_ac].sfdc007=0 THEN
      RETURN r_success
   END IF
   
   SELECT imaa005 INTO l_imaa005 FROM imaa_t 
    WHERE imaaent = g_enterprise
      AND imaa001 = g_sfdc_d[l_ac].sfdc004
   IF cl_null(l_imaa005) THEN
      RETURN r_success  #不做特征管理的不需要检查
   END IF
   
   #计算已发量，折算成此次退料的量
   LET l_sql = "SELECT sfdd006,SUM(sfdd007) ",
               "  FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfdc_d[l_ac].sfdc001,"' ", #工单
               "   AND sfdc002   = ",g_sfdc_d[l_ac].sfdc002,         #项次
               "   AND sfdd001   = '",g_sfdc_d[l_ac].sfdc004,"' ",
               "   AND sfdd013   = '",g_sfdc_d[l_ac].sfdc005,"' ",
               "   AND sfdd012   = -1 ",   #发料
               "   AND sfdastus  = 'S' ",  #已扣帐的
               " GROUP BY sfdd006 "
   PREPARE asft310_01_chk_feature2_qty_p1 FROM l_sql
   DECLARE asft310_01_chk_feature2_qty_c1 CURSOR FOR asft310_01_chk_feature2_qty_p1
   LET l_qty1 = 0
   FOREACH asft310_01_chk_feature2_qty_c1 INTO l_sfdd006,l_sfdd007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_chk_feature2_qty_c1 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF

      #统一折算成此次退料的单位进行计算
      IF l_sfdd006 != g_sfdc_d[l_ac].sfdc006 THEN   #发料单位，工单单位
         #mark 150101
         #CALL s_aimi190_get_convert(g_sfdc_d[l_ac].sfdc004,l_sfdd006,g_sfdc_d[l_ac].sfdc006)
         #  RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdd007 = l_sfdd007 * l_rate  #发料数量
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(g_sfdc_d[l_ac].sfdc004,l_sfdd006,g_sfdc_d[l_ac].sfdc006,l_sfdd007)
           RETURNING l_success,g_qty_t
         IF l_success THEN
            LET l_sfdd007 = g_qty_t
         END IF
         #add 150101 end
      END IF
      
      LET l_qty1 = l_qty1 + l_sfdd007
   END FOREACH
   
   #计算已退量，折算成此次退料的量
   #  2.1其他退料单的
   LET l_sql = "SELECT sfdd006,SUM(sfdd007) ",
               " FROM sfdd_t,sfdc_t,sfda_t ",
               " WHERE sfddent   = sfdcent ",
               "   AND sfdddocno = sfdcdocno ",
               "   AND sfddseq   = sfdcseq ",
               "   AND sfddent   = sfdaent ",
               "   AND sfdddocno = sfdadocno ",
               "   AND sfdcent   = ",g_enterprise,
               "   AND sfdcdocno != '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfdc_d[l_ac].sfdc001,"' ", #工单
               "   AND sfdc002   = ",g_sfdc_d[l_ac].sfdc002,         #项次
               "   AND sfdc003   = ",g_sfdc_d[l_ac].sfdc003,        #项序
               "   AND sfdd001   = '",g_sfdc_d[l_ac].sfdc004,"' ", #料号
               "   AND sfdd013   = '",g_sfdc_d[l_ac].sfdc005,"' ", #特征
               "   AND sfdd012   = 1 ",   #退料
               "   AND sfdastus != 'X' ", #作废
               " GROUP BY sfdd006 ",
               " UNION ",
   #  2.2本张退料单实体表中的
               "SELECT sfdc006,SUM(sfdc007) ",
               " FROM sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdcdocno = '",g_sfdadocno,"' ",  #退料单号  #161109-00085#30
               "   AND sfdc001   = '",g_sfdc_d[l_ac].sfdc001,"' ", #工单
               "   AND sfdc002   = ",g_sfdc_d[l_ac].sfdc002,         #项次
               "   AND sfdc003   = ",g_sfdc_d[l_ac].sfdc003,        #项序
               "   AND sfdc004   = '",g_sfdc_d[l_ac].sfdc004,"' ",  #料号
               "   AND sfdc005   = '",g_sfdc_d[l_ac].sfdc005,"' ",  #特征
               " GROUP BY sfdc006 ",
               " UNION ",
   #  2.3本张退料单已生成于临时表中的
               "SELECT sfdc006,SUM(sfdc007) ",
               " FROM asft310_01_sfdc_t ",
               " WHERE sfdcent   = ",g_enterprise,
               "   AND sfdc001   = '",g_sfdc_d[l_ac].sfdc001,"' ", #工单
               "   AND sfdc002   = ",g_sfdc_d[l_ac].sfdc002,         #项次
               "   AND sfdc003   = ",g_sfdc_d[l_ac].sfdc003,        #项序
               "   AND sfdc004   = '",g_sfdc_d[l_ac].sfdc004,"' ",  #料号
               "   AND sfdc005   = '",g_sfdc_d[l_ac].sfdc005,"' "   #特征
               IF NOT cl_null(g_sfdc_d_t.sfdcseq) AND g_sfdc_d_t.sfdcseq != 0 THEN  #排除当前笔
                  LET l_sql = l_sql CLIPPED," AND sfdcseq  != ",g_sfdc_d_t.sfdcseq
               END IF
               LET l_sql = l_sql CLIPPED," GROUP BY sfdc006 "
   PREPARE asft310_01_chk_feature2_qty_p2 FROM l_sql
   DECLARE asft310_01_chk_feature2_qty_c2 CURSOR FOR asft310_01_chk_feature2_qty_p2
   LET l_qty2 = 0
   FOREACH asft310_01_chk_feature2_qty_c2 INTO l_sfdd006,l_sfdd007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach asft310_01_chk_feature2_qty_c2 err'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #统一折算成此次退料的单位进行计算
      IF l_sfdd006 != g_sfdc_d[l_ac].sfdc006 THEN   #发料单位，工单单位
         #mark 150101
         #CALL s_aimi190_get_convert(g_sfdc_d[l_ac].sfdc004,l_sfdd006,g_sfdc_d[l_ac].sfdc006)
         #  RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_sfdd007 = l_sfdd007 * l_rate  #发料数量
         #mark 150101 end
         #add 150101
         CALL s_aooi250_convert_qty(g_sfdc_d[l_ac].sfdc004,l_sfdd006,g_sfdc_d[l_ac].sfdc006,l_sfdd007)
           RETURNING l_success,g_qty_t
         IF NOT l_success THEN
            LET l_sfdd007 = g_qty_t
         END IF
         #add 150101 end
      END IF
      
      LET l_qty2 = l_qty2 + l_sfdd007
   END FOREACH
   
   LET l_qty = l_qty1-l_qty2  #已发-已退=此特征可退量l_qty
   IF l_qty < g_sfdc_d[l_ac].sfdc007 THEN
      #此特征总退料量不可大于已发料数量，最多可退量为%1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00648'
      LET g_errparam.extend = g_sfdc_d[l_ac].sfdc005
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_qty
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得發料套數與退料套數總合
# Memo...........: #160309-00006#1
# Usage..........: CALL asft310_01_get_all_sfdc007(p_sfbadocno,p_sfbaseq,p_sfbaseq1,p_sfba006,p_sfba023,p_qty)
#                  RETURNING TRUE/FALSE
# Input parameter: 
# Return code....: TRUE / FALSE
# Date & Author..: 2016/03/11 By Ann_Huang
# Modify.........:
################################################################################
PRIVATE FUNCTION asft310_01_get_all_sfdc007(p_sfbadocno,p_sfbaseq,p_sfbaseq1,p_sfba006,p_sfba023,p_qty)
DEFINE p_sfbadocno       LIKE sfba_t.sfbadocno  #工單單號
DEFINE p_sfbaseq         LIKE sfba_t.sfbaseq    #项次
DEFINE p_sfbaseq1        LIKE sfba_t.sfbaseq1   #项序
DEFINE p_sfba006         LIKE sfba_t.sfba006    #项序
DEFINE p_sfba023         LIKE sfba_t.sfba023    #標準應發量
DEFINE p_qty             LIKE sfdc_t.sfdc007    #預帶量
DEFINE l_sfdc007_1       LIKE sfdc_t.sfdc007    #發料:申請數量
DEFINE l_sfdc007_2       LIKE sfdc_t.sfdc007    #退料:申請數量
DEFINE l_sfdc007_tot     LIKE sfdc_t.sfdc007    #已過帳的總申請數量 (l_sfdc007_1 - l_sfdc007_2)
   
   SELECT SUM(sfdc007) INTO l_sfdc007_1
     FROM sfdc_t
   LEFT OUTER JOIN sfda_t
                ON sfdaent = sfdcent
               AND sfdasite = sfdcsite
               AND sfdadocno = sfdcdocno
    WHERE sfdcent = g_enterprise
      AND sfdcsite = g_site
      AND sfdc001 = p_sfbadocno
      AND sfdc002 = p_sfbaseq
      AND sfdc003 = p_sfbaseq1
      AND sfdc004 = p_sfba006
      AND sfdastus = 'S'
      AND sfda002 = '11'
   IF cl_null(l_sfdc007_1) THEN LET l_sfdc007_1 = 0 END IF
    
   SELECT SUM(sfdc007) INTO l_sfdc007_2
     FROM sfdc_t
   LEFT OUTER JOIN sfda_t
                ON sfdaent = sfdcent
               AND sfdasite = sfdcsite
               AND sfdadocno = sfdcdocno
    WHERE sfdcent = g_enterprise
      AND sfdcsite = g_site
      AND sfdc001 = p_sfbadocno
      AND sfdc002 = p_sfbaseq
      AND sfdc003 = p_sfbaseq1
      AND sfdc004 = p_sfba006
      AND sfdastus = 'S'
      AND sfda002 = '21'
   IF cl_null(l_sfdc007_2) THEN LET l_sfdc007_2 = 0 END IF
    
   LET l_sfdc007_tot = 0
   LET l_sfdc007_tot = l_sfdc007_1 - l_sfdc007_2
   LET p_qty = p_qty USING '---,---,---.&&&'
   #LET p_qty = s_num_round('1',p_qty,3)
   
   IF p_sfba023 = l_sfdc007_tot + p_qty THEN
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF
END FUNCTION

################################################################################
# Descriptions...: 依照工單映備置資料產生發料單的倉儲批
# Memo...........:
# Usage..........: CALL asft310_01_sfbb()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 16/04/15 By Sarah (160408-00035#6)
# Modify.........:
################################################################################
PRIVATE FUNCTION asft310_01_default_from_sfbb()
DEFINE l_inag004  LIKE inag_t.inag004  #庫位
DEFINE l_inag005  LIKE inag_t.inag005  #儲位
DEFINE l_inag006  LIKE inag_t.inag006  #批號
#160927-00030#1-s
DEFINE l_inag003  LIKE inag_t.inag003  #庫存管理特徵
DEFINE l_inag002  LIKE inag_t.inag003  #產品特徵
#160927-00030#1-e
DEFINE l_sum_qty  LIKE sfbb_t.sfbb008  #累計數量
DEFINE l_qty      LIKE sfbb_t.sfbb008  #寫入發料的數量

#假若工單應發數量(issue_qty)=100 , 硬備置 A倉庫 數量(issue_qty1)=30 , B倉庫 數量(issue_qty1)=20
#則產生發料A倉庫 數量=30 , B倉庫 數量=20 , 剩下的數量50按照原本的發料預設倉儲批方式來產生
#假若工單應發數量(issue_qty)=40 , 硬備置 A倉庫 數量(issue_qty1)=30 , B倉庫 數量(issue_qty1)=20
#則產生發料A倉庫 數量=30 , B倉庫 數量=10
#假若工單應發數量(issue_qty)=20 , 硬備置 A倉庫 數量(issue_qty1)=30 , B倉庫 數量(issue_qty1)=20
#則產生發料A倉庫 數量=20

   LET l_qty = 0
   LET l_sum_qty = 0
   LET issue_qty1 = 0
   
   #工單備置明細檔   
   DECLARE asft310_01_sel_sfbb_cur CURSOR FOR
      #160927-00030#1-s
      #SELECT sfbb004,sfbb005,sfbb006,sfbb002,(sfbb008-sfbb009)
      SELECT sfbb002,sfbb003,sfbb004,sfbb005,sfbb006,(sfbb008-sfbb009)
      #160927-00030#1-e
        FROM sfbb_t
       WHERE sfbbent = g_enterprise
         AND sfbbdocno = g_sfba.sfbadocno
         AND sfbbseq = g_sfba.sfbaseq
         AND sfbbseq1 = g_sfba.sfbaseq1
   #160927-00030#1-s
   #FOREACH asft310_01_sel_sfbb_cur INTO l_inag004,l_inag005,l_inag006,l_inag003,issue_qty1
   FOREACH asft310_01_sel_sfbb_cur INTO l_inag002,l_inag003,l_inag004,l_inag005,l_inag006,issue_qty1
   #160927-00030#1-e
      LET l_sum_qty = l_sum_qty + issue_qty1
            
      IF issue_qty >= issue_qty1 THEN
         IF issue_qty >= l_sum_qty THEN
            LET l_qty = issue_qty1
         ELSE
            LET l_qty = issue_qty1 - (l_sum_qty - issue_qty)
         END IF
         #160927-00030#1-s
         #CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,'')
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,l_inag002)
         #160927-00030#1-e
      ELSE
         LET l_qty = issue_qty         
         #160927-00030#1-s
         #CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,'')
         CALL asft310_01_ins_sfdc('asft310_01_sfdc_t',l_inag004,l_inag005,l_inag006,l_inag003,tm.reason,l_qty,l_inag002)
         #160927-00030#1-e
         EXIT FOREACH
      END IF      
      
   END FOREACH
   
   LET issue_qty = issue_qty - l_sum_qty   #若發料數量>硬備置數量,則剩餘數量用原本的發料預設倉儲批方式來產生
   IF issue_qty < 0 THEN
      LET issue_qty = 0
   END IF

END FUNCTION

################################################################################
# Descriptions...: 取得庫位、儲位、批號、庫存管理特徵
# Memo...........:
# Usage..........: CALL asft310_01_inag_default()
#                  RETURNING l_inag004,l_inag005,l_inag006,l_inag003
# Input parameter: 
# Return code....: r_inag004      庫位編號
#                : r_inag005      儲位編號
#                : r_inag006      批號
#                : r_inag003      庫存管理特徵
# Date & Author..: 2016/06/21 By dorislai(#160512-00004#2)
# Modify.........: #160726-00001#6 共用s_asft310_inag_default()
################################################################################
PRIVATE FUNCTION asft310_01_inag_default()
#160726-00001#6-s
#   DEFINE l_imaf059    LIKE imaf_t.imaf059  
#   DEFINE l_flag       LIKE type_t.num5     
#   DEFINE l_success    LIKE type_t.num5
#   DEFINE l_sql        STRING
#   DEFINE l_inag003    LIKE inag_t.inag003
#   DEFINE l_inag004    LIKE inag_t.inag004
#   DEFINE l_inag005    LIKE inag_t.inag005
#   DEFINE l_inag006    LIKE inag_t.inag006
#   DEFINE r_inag004    LIKE inag_t.inag004
#   DEFINE r_inag005    LIKE inag_t.inag005
#   DEFINE r_inag006    LIKE inag_t.inag006
#   DEFINE r_inag003    LIKE inag_t.inag003
#   
#   #抓取aimm212的撿貨策略
#  #---1:先進先出(依製造日期) 2:先進先出(依有效日期) 3:後進先出(依製造日期) 4:人工決定
#  SELECT imaf059 INTO l_imaf059
#    FROM imaf_t
#   WHERE imafent = g_enterprise
#     AND imafsite = g_site
#     AND imaf001 = g_sfba.sfba006
#  IF l_imaf059 = '4' OR cl_null(l_imaf059) THEN
#     IF g_imae092 ='Y' THEN  #发料前调拨
#        LET l_inag004 = g_imae101  #在制发料库位
#        LET l_inag005 = g_imae102  #在制发料储位
#     ELSE
#        LET l_inag004 = g_imaf091  #料件预设库位
#        LET l_inag005 = g_imaf092  #料件预设储位
#     END IF
#     LET l_inag006 = ' '  #批号
#     LET l_inag003 = ' '  #库存管理特征
#  ELSE
#     #先依aimm212撿貨策略抓出料號、產品特徵、批號
#     LET l_sql = "SELECT inad003 FROM inad_t",
#                 " WHERE inadent = ",g_enterprise," AND inadsite = '",g_site,"'",
#                 "   AND inad001 = '",g_sfba.sfba006,"' AND inad002 = '",g_sfba.sfba021,"'"
#     
#     CASE l_imaf059
#       WHEN '1' #先進先出(依製造日期)
#          LET l_sql = l_sql CLIPPED," AND inad014=(SELECT MIN(inad014) FROM inad_t ",
#                                    "               WHERE inadent = ",g_enterprise," AND inadsite = '",g_site,"'",
#                                    "                 AND inad001 = '",g_sfba.sfba006,"' AND inad002 = '",g_sfba.sfba021,"' "
#                                    
#       WHEN '2' #先進先出(依有效日期)
#          LET l_sql = l_sql CLIPPED," AND inad011=(SELECT MIN(inad011) FROM inad_t ",
#                                    "               WHERE inadent = ",g_enterprise," AND inadsite = '",g_site,"'",
#                                    "                 AND inad001 = '",g_sfba.sfba006,"' AND inad002 = '",g_sfba.sfba021,"' "
#       WHEN '3' #後進先出(依製造日期)
#          LET l_sql = l_sql CLIPPED," AND inad014=(SELECT MAX(inad014) FROM inad_t ",
#                                    "               WHERE inadent = ",g_enterprise," AND inadsite = '",g_site,"'",
#                                    "                 AND inad001 = '",g_sfba.sfba006,"' AND inad002 = '",g_sfba.sfba021,"' "
#          
#     END CASE
#     #---若批號有值，要組進去l_sql中            
#     IF cl_null(g_sfba.sfba029) THEN
#        LET l_sqL = l_sql CLIPPED,") "
#     ELSE
#        LET l_sql = l_sql CLIPPED," AND inad003 = '",g_sfba.sfba029,"') "
#     END IF
#     LET l_sql = "SELECT inag003,inag004,inag005,inag006 FROM inag_t ",
#                 " WHERE inagent = '",g_enterprise,"' AND inagsite = '",g_site,"'",
#                 "   AND inag001 = '",g_sfba.sfba006,"' AND inag002 = '",g_sfba.sfba021,"'",
#                 "   AND inag004 IS NOT NULL ",
#                 "   AND inag008 >= ",issue_qty," AND inag006 IN (",l_sql,") ",
#                 " ORDER BY inag004,inag005,inag006 "
#     PREPARE asft310_01_pre_1 FROM l_sql
#     DECLARE asft310_01_cs_1  CURSOR FOR asft310_01_pre_1
#     FOREACH asft310_01_cs_1 INTO l_inag004,l_inag005,l_inag006
#         #檢查庫存是否足夠
#                                      #  ,料件編號     ,   產品特徵     ,庫存管理特徵, 庫位     ,  儲位   ,  批號   ,
#         CALL s_inventory_check_inag008(1,g_sfba.sfba006,g_sfba.sfba021,l_inag003,l_inag004,l_inag005,l_inag006,
#                                        # 異動數量     ,   單據         ,   項次        ,  項序         ,     單位         ,營運據點
#                                        issue_qty     ,g_sfba.sfbadocno,g_sfba.sfbaseq,g_sfba.sfbaseq1,g_sfba.sfba014,g_site)
#              RETURNING l_success,l_flag
#         #庫存量足夠 ; 不足，需將庫儲批拿掉
#         IF l_success AND l_flag = '1'THEN
#            EXIT FOREACH   #因可能會多筆適合的，但僅需一筆，固有抓到就可以不用在跑FOREACH
#         ELSE
#            LET l_inag004 = ' '
#            LET l_inag005 = ' '
#            LET l_inag006 = ' '
#         END IF
#     END FOREACH
#  
#     IF l_inag004 IS NULL THEN LET l_inag004 = ' ' END IF
#     IF l_inag005 IS NULL THEN LET l_inag005 = ' ' END IF
#     IF l_inag006 IS NULL THEN LET l_inag006 = ' ' END IF
#     LET l_inag003 = ' '  #库存管理特征                 
#  END IF
#   
#   
#   
#   LET r_inag004 = l_inag004
#   LET r_inag005 = l_inag005
#   LET r_inag006 = l_inag006
#   LET r_inag003 = l_inag003
#   FREE asft310_01_pre_1
#   
#   RETURN r_inag004,r_inag005,r_inag006,r_inag003
#160726-00001#6-e
END FUNCTION

 
{</section>}
 
