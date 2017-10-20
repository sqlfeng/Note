#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt500_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0038(2016-12-26 14:30:17), PR版次:0038(2017-04-27 16:07:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000405
#+ Filename...: apmt500_01
#+ Description: 整批產生採購單身子作業
#+ Creator....: 02294(2013-12-23 11:26:13)
#+ Modifier...: 01258 -SD/PR- topstd
 
{</section>}
 
{<section id="apmt500_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#151224-00025#3   2015/12/24  By fionchen 產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160222-00020#1   2016/2/24   By lixiang  若是料件未設置預設前置時間，則抓取aoo020上設置的資料
#160310-00004#1   2016/03/10  By Sarah    增加aooi210，限制前後單別
#160314-00009#9   2016/03/21  By zhujing  各程式增加产品特征是否需要自动开窗的程式段处理
# Modify......: NO.160318-00005#40   2016/03/31   By 07900    重复错误讯息修改
#160801-00004#1   2016/08/01  By lixiang  庫存管理特微有值時，需帶入到採購單上，且有值時，請購資料不合併
#160905-00007#11  2016/09/05  By 01727     调整系统中无ENT的SQL条件增加ent
#160531-00023#1   2016/09/21  By lixiang  增加请购单的资料锁，避免多人同时操作时，重复产生资料
#161109-00014#1   2016/11/09  By lixh     apmt500_01执行成功之后点击是，然后再点击否，会重复产生资料
#161108-00012#3   2016/11/09  By 08734    g_browser_cnt 由num5改為num10
#161109-00059#1   2016/11/10  By lixh     apmt500_01执行成功之后点击是，然后再点击否,没有回到主画面\
#161216-00032#1   2016/12/20  By lixiang  整批产生子作业中的临时表定义，不能用参考字段的方式，改成对应的数据类型
#161124-00048#9   2016/12/19  By zhujing  .*整批调整
#161205-00025#2   2016/12/22  By lixiang  效能优化
#161222-00027#1   2016/12/26  By wuxja    新增备注栏位，（主要杂项请购的费用性料号都是维护再备注里的，方便选择）
#161221-00064#5   2017/01/10  By zhujing  增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#161031-00025#5   2017/02/16  By lixiang  有來源時，同原單身備註，依單別參數帶入來源單據長備註
#170222-00027#1   2017/02/23  By lixiang 稅別如為"依料件設置"輸入完料號後，應該依料件設定帶入稅別資料，無設定以單頭資料為主，可修改不可空白
#170302-00010#1   2017/03/03  By ywtsai   修改組SQL字串時，pmdn050給值改為?傳參數，因備註欄位遇費用類科目會有可能實際品名有特殊符號輸入
#170313-00049#1   2017/03/3   By lixiang  修正#170302-00010#1调整后，若pmdn050为空时，导致pmdp资料未写入的情况
#170324-00034#1   2017/03/28  By earl     修正pmdp與pmdq對應到pmdn的group
#170328-00119#1   2017/03/29  By lixiang  因请购抛转采购时，若请购有维护库位储位资料时，抛转到采购一律不合并，所以在判断是否存在多交期资料时，应加上库位储位的条件
#170329-00070#1   2017/03/30  By lixiang  勾选依请购单拆分时，产生pmdp的sql中，需要同步加上？，否则foreach出错
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="apmt500_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}

#單身 type 宣告
TYPE type_g_pmdb_d        RECORD
   check     LIKE type_t.chr1,
   pmdbdocno LIKE pmdb_t.pmdbdocno,
   pmdbseq   LIKE pmdb_t.pmdbseq,
   pmdb004   LIKE pmdb_t.pmdb004,
   imaal003  LIKE imaal_t.imaal003,
   imaal004  LIKE imaal_t.imaal004,
   pmdb005   LIKE pmdb_t.pmdb005,
   pmdb005_desc LIKE type_t.chr80,
   pmdb007   LIKE pmdb_t.pmdb007,
   pmdb006   LIKE pmdb_t.pmdb006,
   pmdb006_1 LIKE pmdb_t.pmdb006,
   pmdb030   LIKE pmdb_t.pmdb030,
   pmdb033   LIKE pmdb_t.pmdb033,
   pmdb050   LIKE pmdb_t.pmdb050,   #161222-00027#1 add
   pmda002   LIKE pmda_t.pmda002,
   oofa011   LIKE oofa_t.oofa011,
   pmda003   LIKE pmda_t.pmda003,
   ooefl003  LIKE ooefl_t.ooefl003
       END RECORD
TYPE type_g_pmdb2_d        RECORD
   pmdbdocno LIKE pmdb_t.pmdbdocno,
   pmdbseq   LIKE pmdb_t.pmdbseq,
   pmdb004   LIKE pmdb_t.pmdb004,
   imaal003  LIKE imaal_t.imaal003,
   imaal004  LIKE imaal_t.imaal004,
   pmdb005   LIKE pmdb_t.pmdb005,
   pmdb005_desc LIKE type_t.chr80,
   pmdb007   LIKE pmdb_t.pmdb007,
   pmdb006   LIKE pmdb_t.pmdb006,
   pmdb030   LIKE pmdb_t.pmdb030,
   pmdb050   LIKE pmdb_t.pmdb050,   #161222-00027#1 add pmdb050
   pmdp021   LIKE pmdp_t.pmdp021,
   pmdp001   LIKE pmdp_t.pmdp001,
   imaal003_2 LIKE imaal_t.imaal003,
   imaal004_2 LIKE imaal_t.imaal004,
   pmdp002   LIKE pmdp_t.pmdp002,
   pmdp002_desc LIKE type_t.chr80,
   pmdp022   LIKE pmdp_t.pmdp022,
   pmdp023   LIKE pmdp_t.pmdp023,
   pmdn010   LIKE pmdn_t.pmdn010,
   pmdn011   LIKE pmdn_t.pmdn011
       END RECORD
DEFINE g_pmdb_d          DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t        type_g_pmdb_d
DEFINE g_pmdb2_d         DYNAMIC ARRAY OF type_g_pmdb2_d
DEFINE g_pmdb2_d_t       type_g_pmdb2_d
DEFINE g_pmdb2_d_o       type_g_pmdb2_d
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num10   #161108-00012#3 num5==》num10
DEFINE l_ac                  LIKE type_t.num10   #161108-00012#3 num5==》num10
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_state               STRING

DEFINE g_detail_cnt          LIKE type_t.num10              #單身總筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx          LIKE type_t.num10              #單身目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_detail_idx2         LIKE type_t.num10              #單身2目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_browser_cnt         LIKE type_t.num10              #Browser總筆數    #161108-00012#3 num5==》num10 
DEFINE g_browser_idx         LIKE type_t.num10              #Browser目前所在筆數  #161108-00012#3 num5==》num10
DEFINE g_temp_idx            LIKE type_t.num10              #Browser目前所在筆數(暫存用)  #161108-00012#3 num5==》num10

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num10              #Browser所在筆數  #161108-00012#3 num5==》num10
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10              #目前所在頁數  #161108-00012#3 num5==》num10
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5

DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_pmdn028_t           LIKE pmdn_t.pmdn028           #160801-00004#1
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="apmt500_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE tm   RECORD
       a    LIKE type_t.chr1,
       b    LIKE type_t.chr1,
       c    LIKE type_t.chr1,
       d    LIKE type_t.chr1, 
       e    LIKE type_t.chr1     #ming 20151113 add 
         END RECORD
         
DEFINE g_rec_b2     LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE l_ac2        LIKE type_t.num10  #161108-00012#3 num5==》num10
DEFINE g_imaa009    STRING
DEFINE g_imce141    STRING
DEFINE g_pmdldocno  LIKE pmdl_t.pmdldocno
DEFINE g_success    LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE g_pmdn       RECORD LIKE pmdn_t.*
DEFINE g_pmdn RECORD  #採購單身明細檔
       pmdnent LIKE pmdn_t.pmdnent, #企业编号
       pmdnsite LIKE pmdn_t.pmdnsite, #营运据点
       pmdnunit LIKE pmdn_t.pmdnunit, #应用组织
       pmdndocno LIKE pmdn_t.pmdndocno, #采购单号
       pmdnseq LIKE pmdn_t.pmdnseq, #项次
       pmdn001 LIKE pmdn_t.pmdn001, #料件编号
       pmdn002 LIKE pmdn_t.pmdn002, #产品特征
       pmdn003 LIKE pmdn_t.pmdn003, #包装容器
       pmdn004 LIKE pmdn_t.pmdn004, #作业编号
       pmdn005 LIKE pmdn_t.pmdn005, #作业序
       pmdn006 LIKE pmdn_t.pmdn006, #采购单位
       pmdn007 LIKE pmdn_t.pmdn007, #采购数量
       pmdn008 LIKE pmdn_t.pmdn008, #参考单位
       pmdn009 LIKE pmdn_t.pmdn009, #参考数量
       pmdn010 LIKE pmdn_t.pmdn010, #计价单位
       pmdn011 LIKE pmdn_t.pmdn011, #计价数量
       pmdn012 LIKE pmdn_t.pmdn012, #出货日期
       pmdn013 LIKE pmdn_t.pmdn013, #到厂日期
       pmdn014 LIKE pmdn_t.pmdn014, #到库日期
       pmdn015 LIKE pmdn_t.pmdn015, #单价
       pmdn016 LIKE pmdn_t.pmdn016, #税种
       pmdn017 LIKE pmdn_t.pmdn017, #税率
       pmdn019 LIKE pmdn_t.pmdn019, #子件特性
       pmdn020 LIKE pmdn_t.pmdn020, #紧急度
       pmdn021 LIKE pmdn_t.pmdn021, #保税
       pmdn022 LIKE pmdn_t.pmdn022, #部分交货
       pmdnorga LIKE pmdn_t.pmdnorga, #付款据点
       pmdn023 LIKE pmdn_t.pmdn023, #送货供应商
       pmdn024 LIKE pmdn_t.pmdn024, #多交期
       pmdn025 LIKE pmdn_t.pmdn025, #收货地址编号
       pmdn026 LIKE pmdn_t.pmdn026, #账款地址编号
       pmdn027 LIKE pmdn_t.pmdn027, #供应商料号
       pmdn028 LIKE pmdn_t.pmdn028, #收货库位
       pmdn029 LIKE pmdn_t.pmdn029, #收货储位
       pmdn030 LIKE pmdn_t.pmdn030, #收货批号
       pmdn031 LIKE pmdn_t.pmdn031, #运输方式
       pmdn032 LIKE pmdn_t.pmdn032, #取货模式
       pmdn033 LIKE pmdn_t.pmdn033, #备品率
       pmdn034 LIKE pmdn_t.pmdn034, #no use
       pmdn035 LIKE pmdn_t.pmdn035, #价格核决
       pmdn036 LIKE pmdn_t.pmdn036, #项目编号
       pmdn037 LIKE pmdn_t.pmdn037, #WBS编号
       pmdn038 LIKE pmdn_t.pmdn038, #活动编号
       pmdn039 LIKE pmdn_t.pmdn039, #费用原因
       pmdn040 LIKE pmdn_t.pmdn040, #取价来源
       pmdn041 LIKE pmdn_t.pmdn041, #价格参考单号
       pmdn042 LIKE pmdn_t.pmdn042, #价格参考项次
       pmdn043 LIKE pmdn_t.pmdn043, #取出价格
       pmdn044 LIKE pmdn_t.pmdn044, #价差比
       pmdn045 LIKE pmdn_t.pmdn045, #行状态
       pmdn046 LIKE pmdn_t.pmdn046, #税前金额
       pmdn047 LIKE pmdn_t.pmdn047, #含税金额
       pmdn048 LIKE pmdn_t.pmdn048, #税额
       pmdn049 LIKE pmdn_t.pmdn049, #理由码
       pmdn050 LIKE pmdn_t.pmdn050, #备注
       pmdn051 LIKE pmdn_t.pmdn051, #留置/结案理由码
       pmdn052 LIKE pmdn_t.pmdn052, #检验否
       pmdn053 LIKE pmdn_t.pmdn053, #库存管理特征
       pmdn200 LIKE pmdn_t.pmdn200, #商品条码
       pmdn201 LIKE pmdn_t.pmdn201, #包装单位
       pmdn202 LIKE pmdn_t.pmdn202, #包装数量
       pmdn203 LIKE pmdn_t.pmdn203, #收货部门
       pmdn204 LIKE pmdn_t.pmdn204, #No Use
       pmdn205 LIKE pmdn_t.pmdn205, #要货组织
       pmdn206 LIKE pmdn_t.pmdn206, #库存量
       pmdn207 LIKE pmdn_t.pmdn207, #采购在途量
       pmdn208 LIKE pmdn_t.pmdn208, #前日销售量
       pmdn209 LIKE pmdn_t.pmdn209, #上月销量
       pmdn210 LIKE pmdn_t.pmdn210, #第一周销量
       pmdn211 LIKE pmdn_t.pmdn211, #第二周销量
       pmdn212 LIKE pmdn_t.pmdn212, #第三周销量
       pmdn213 LIKE pmdn_t.pmdn213, #第四周销量
       pmdn214 LIKE pmdn_t.pmdn214, #采购渠道
       pmdn215 LIKE pmdn_t.pmdn215, #渠道性质
       pmdn216 LIKE pmdn_t.pmdn216, #经营方式
       pmdn217 LIKE pmdn_t.pmdn217, #结算方式
       pmdn218 LIKE pmdn_t.pmdn218, #合同编号
       pmdn219 LIKE pmdn_t.pmdn219, #协议编号
       pmdn220 LIKE pmdn_t.pmdn220, #采购人员
       pmdn221 LIKE pmdn_t.pmdn221, #采购部门
       pmdn222 LIKE pmdn_t.pmdn222, #采购中心
       pmdn223 LIKE pmdn_t.pmdn223, #配送中心
       pmdn224 LIKE pmdn_t.pmdn224, #采购失效日
       pmdn900 LIKE pmdn_t.pmdn900, #保留字段str
       pmdn999 LIKE pmdn_t.pmdn999, #保留字段end
       pmdn225 LIKE pmdn_t.pmdn225, #最终收货组织
       pmdn054 LIKE pmdn_t.pmdn054, #还料数量
       pmdn055 LIKE pmdn_t.pmdn055, #还量参考数量
       pmdn056 LIKE pmdn_t.pmdn056, #还价数量
       pmdn057 LIKE pmdn_t.pmdn057, #还价参考数量
       pmdn226 LIKE pmdn_t.pmdn226, #长效期每次送货量
       pmdn227 LIKE pmdn_t.pmdn227, #补货规格说明
       pmdn058 LIKE pmdn_t.pmdn058, #预算科目
       pmdn228 LIKE pmdn_t.pmdn228  #商品品类
END RECORD
#161124-00048#9 mod-E
DEFINE g_flag       LIKE type_t.chr1  #161109-00059#1

#end add-point
 
{</section>}
 
{<section id="apmt500_01.other_dialog" >}

 
{</section>}
 
{<section id="apmt500_01.other_function" readonly="Y" >}

PUBLIC FUNCTION apmt500_01(--)
   #add-point:main段變數傳入
   p_pmdldocno
   #end add-point
   )
   #add-point:main段define
   DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
   #end add-point

   IF cl_null(p_pmdldocno) THEN
      RETURN
   END IF

   #CREATE TEMP TABLE apmt500_01_tmp
   #(
   #pmda004   VARCHAR(1),   #用於標記是否勾選
   #pmdbdocno VARCHAR(20),
   #pmdbseq   DECIMAL(10,0),
   #pmdb004   VARCHAR(40),
   #pmdb005   VARCHAR(256),
   #pmdb007   VARCHAR(10),
   #pmdb006   DECIMAL(20,6),
   #pmdb006_1 DECIMAL(20,6),
   #pmdb030   DATE,
   #pmdb033   VARCHAR(10),
   #pmda002   VARCHAR(10),
   #pmda003   VARCHAR(10)
   # );  

#151224-00025#3 mark start --------------------------------
#   CREATE TEMP TABLE apmt500_01_tmp(
#   pmda004    LIKE pmda_t.pmda004,   #用於標記是否勾選
#   pmdbdocno  LIKE pmdb_t.pmdbdocno,
#   pmdbseq    LIKE pmdb_t.pmdbseq,
#   pmdb004    LIKE pmdb_t.pmdb004,
#   pmdb005    LIKE pmdb_t.pmdb005,
#   pmdb007    LIKE pmdb_t.pmdb007,
#   pmdb006    LIKE pmdb_t.pmdb006,
#   pmdb006_1  LIKE pmdb_t.pmdb006,
#   pmdb030    LIKE pmdb_t.pmdb030,
#   pmdb033    LIKE pmdb_t.pmdb033,
#   pmda002    LIKE pmda_t.pmda002,
#   pmda003    LIKE pmda_t.pmda003
#    );
#   
#   CREATE TEMP TABLE apmt500_01_tmp2
#   (
#   pmdbdocno   VARCHAR(20),
#   pmdbseq     DECIMAL(10,0),
#   pmdb004     VARCHAR(40),
#   pmdb005     VARCHAR(256),
#   pmdb007     VARCHAR(10),
#   pmdb006     DECIMAL(20,6),
#   pmdb006_1   DECIMAL(20,6),
#   pmdb030     DATE,
#   pmdp021     DECIMAL(10,0),
#   pmdp001     VARCHAR(40),
#   pmdp002     VARCHAR(256),
#   pmdp022     VARCHAR(10),
#   pmdp023     DECIMAL(20,6),
#   pmdn010     VARCHAR(10),
#   pmdn011     DECIMAL(20,6),
#   pmdn036     VARCHAR(20),  #专案编号  #add by lixiang 2015/10/15
#   pmdn037     VARCHAR(30),  #WBS      #add by lixiang 2015/10/15
#   pmdn038     VARCHAR(30),  #活动编号  #add by lixiang 2015/10/15
#   pmdn050     VARCHAR(256),    #備註  
#   pmdn058     VARCHAR(10)     #科目預算 #ming 20151225 add 
#   );
#151224-00025#3 mark end   --------------------------------   

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CONTINUE
   WHENEVER ERROR CALL cl_err_msg_log

   OPEN WINDOW w_apmt500_01 WITH FORM cl_ap_formpath("apm","apmt500_01")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   #程式初始化
   CALL apmt500_01_init()
   LET g_pmdldocno = p_pmdldocno
   
   LET g_forupd_sql = "SELECT pmdldocno FROM pmdl_t WHERE pmdlent= ? AND pmdldocno=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   DECLARE apmt500_01_cl CURSOR FROM g_forupd_sql

   OPEN apmt500_01_cl USING g_enterprise,p_pmdldocno
   
   LET g_success = TRUE
   
   DELETE FROM apmt500_01_tmp
   DELETE FROM apmt500_01_tmp2
   
   #進入選單 Menu (="N")
   LET g_flag = 'N'  #161109-00059#1
   CALL apmt500_01_input()

   #畫面關閉
   CLOSE WINDOW w_apmt500_01

   CLOSE apmt500_01_cl



   #add-point:離開前
   #151224-00025#3 mark start --------------------------------
#   DROP TABLE apmt500_01_tmp
#   DROP TABLE apmt500_01_tmp2
   #151224-00025#3 mark end   --------------------------------
   
   LET INT_FLAG = FALSE
   RETURN g_success
   #end add-point

END FUNCTION
#畫面初始化
PRIVATE FUNCTION apmt500_01_init()
   CALL cl_set_combo_scc('c','2022')
   CALL cl_set_combo_scc('d','2059')
   CALL cl_set_combo_scc('pmdb033','2036')
   CALL g_pmdb2_d.clear()

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()
   
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("pmdb005,pmdb005_desc,pmdb005_2,pmdb005_2_desc,pmdp002,pmdp002_desc",FALSE)
   END IF
   
   #整體參數未使用採購計價單位
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN  
      CALL cl_set_comp_visible("pmdn011,pmdn010",FALSE)
   END IF
  
END FUNCTION
#根据查询条件，产生请购明细资料
PRIVATE FUNCTION apmt500_01_gen_pmdl()
DEFINE l_sql             STRING
DEFINE l_pmdadocno       LIKE pmda_t.pmdadocno
DEFINE l_pmdbseq         LIKE pmdb_t.pmdbseq
DEFINE l_pmdl002         LIKE pmdl_t.pmdl002
DEFINE l_pmdl004         LIKE pmdl_t.pmdl004
DEFINE l_pmdl025         LIKE pmdl_t.pmdl025  #送貨地址
DEFINE l_pmdl026         LIKE pmdl_t.pmdl026  #帳款地址
DEFINE l_wc              STRING
DEFINE l_success         LIKE type_t.num5  #160310-00004#1 add
DEFINE l_where           STRING            #160310-00004#1 add
DEFINE l_docno           LIKE pmdb_t.pmdbdocno #160531-00023#1   
DEFINE l_seq             LIKE pmdb_t.pmdbseq   #160531-00023#1
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF NOT cl_null(g_imaa009) THEN     #产品分类下条件
      IF NOT cl_null(g_imce141) THEN  #采购分群
         LET l_sql = "SELECT DISTINCT pmdadocno,pmdbseq FROM pmda_t,pmdb_t,imaa_t,imce_t ",
                     " WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno ",
                     "   AND pmdbent = imaaent AND pmdb004 = imaa001 ",
                     "   AND pmdaent = imceent AND pmdasite = imcesite ",
                     "   AND pmdaent = '",g_enterprise,"' ",
                     "   AND pmdasite = '",g_site,"' "
      ELSE
         LET l_sql = "SELECT DISTINCT pmdadocno,pmdbseq FROM pmda_t,pmdb_t,imaa_t ",
                     " WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno ",
                     "   AND pmdbent = imaaent AND pmdb004 = imaa001 ",
                     "   AND pmdaent = '",g_enterprise,"' ",
                     "   AND pmdasite = '",g_site,"' "
      END IF
   ELSE
      IF NOT cl_null(g_imce141) THEN  #采购分群
         LET l_sql = "SELECT DISTINCT pmdadocno,pmdbseq FROM pmda_t,pmdb_t,imce_t ",
                     " WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno ",
                     "   AND pmdaent = imceent AND pmdasite = imcesite ",
                     "   AND pmdaent = '",g_enterprise,"' ",
                     "   AND pmdasite = '",g_site,"' "
      ELSE
         LET l_sql = "SELECT DISTINCT pmdadocno,pmdbseq FROM pmda_t,pmdb_t ",
                     " WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno ",
                     "   AND pmdaent = '",g_enterprise,"' ",
                     "   AND pmdasite = '",g_site,"' "
      END IF
   END IF
   
   LET l_sql = l_sql ," AND ",g_wc
   
   #加上限定的條件
   #已經確認且未結案的請購單
   #已轉採購量<請購量*超交率的請購資料
   #需排除請購明細有指定供應商，且指定的供應商與本採購供應商不一樣的請購資料
   LET l_pmdl004 = ''
   LET l_pmdl025 = ''
	LET l_pmdl026 = ''
   SELECT pmdl004,pmdl025,pmdl026 INTO l_pmdl004,l_pmdl025,l_pmdl026 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno

   LET l_sql = l_sql ," AND pmdastus = 'Y' AND pmdb049 < pmdb006 ",
                      " AND ((pmdb014 = '3' AND pmdb015 = '",l_pmdl004,"') OR pmdb014 <> '3')",
                      " AND pmdb032 = '1' "    #行狀態 未結案的
   
   IF NOT cl_null(l_pmdl025) THEN     
      LET l_sql = l_sql , " AND (pmda024 = '",l_pmdl025,"' OR pmda024 IS NULL) "
   END IF
   IF NOT cl_null(l_pmdl026) THEN
      LET l_sql = l_sql , " AND (pmda025 = '",l_pmdl026,"' OR pmda025 IS NULL) "
   END IF
   
   #160310-00004#1 add str
   #組合過濾前後置單據資料SQL
   CALL s_aooi210_get_check_sql(g_site,'',g_pmdldocno,'4','','pmdadocno')
        RETURNING l_success,l_where
   IF cl_null(l_where) THEN
      LET l_where = " 1=1 "
   END IF
   LET l_sql = l_sql ," AND ",l_where
   #160310-00004#1 add end
            
   LET l_wc = " AND pmdb004 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' "
   IF tm.a = 'Y' THEN  #需過慮請購料號設定的'負責採購員'與本張採購單的採購員一樣才可
      LET l_pmdl002 = ''
      SELECT pmdl002 INTO l_pmdl002 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
      
     #LET l_sql = l_sql ," AND pmdb004 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf142 = '",l_pmdl002,"' ) "
      LET l_wc = l_wc ," AND imaf142 = '",l_pmdl002,"' "
   END IF
   
   IF tm.b = 'Y' THEN  #需過慮請購料號設定的'主要供應商'與本張採購單的採購供應商一樣才可
     #LET l_sql = l_sql ," AND pmdb004 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf153 = '",l_pmdl004,"' ) "
      LET l_wc = l_wc ," AND imaf153 = '",l_pmdl004,"' "
   END IF
   
   IF NOT cl_null(tm.c) THEN  #需過慮請購料號所設定的'補貨策略'與此欄位值一樣才可
     #LET l_sql = l_sql ," AND pmdb004 IN (SELECT imaf001 FROM imaf_t WHERE imafent = '",g_enterprise,"' AND imafsite = '",g_site,"' AND imaf013 = '",tm.c,"' ) "
      LET l_wc = l_wc ," AND imaf013 = '",tm.c,"' "
   END IF
   
   LET l_wc = l_wc ," ) "
   
   IF tm.a = 'Y' OR tm.b = 'Y' OR (NOT cl_null(tm.c)) THEN
      LET l_sql = l_sql,l_wc
   END IF
      
   
   
   LET l_sql = l_sql ," ORDER BY pmdadocno,pmdbseq "
   
   PREPARE apmt500_01_pre FROM l_sql
   DECLARE apmt500_01_cur CURSOR FOR apmt500_01_pre
   
   DELETE FROM apmt500_01_tmp
   
   FOREACH apmt500_01_cur INTO l_pmdadocno,l_pmdbseq
       CALL apmt500_01_insert_tmp(l_pmdadocno,l_pmdbseq)         
   END FOREACH
   
   CALL apmt500_01_b1_fill()
   
   LET g_rec_b = g_pmdb_d.getLength()
   IF g_rec_b = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01321'  #apm-00294  #160318-00005#36   By 07900 --mod
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   
END FUNCTION
#
PRIVATE FUNCTION apmt500_01_input()
DEFINE l_n        LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5
DEFINE l_flag1    LIKE type_t.num5
DEFINE l_flag2    LIKE type_t.num5
DEFINE l_flag3    LIKE type_t.num5
DEFINE l_flag4    LIKE type_t.num5
DEFINE l_flag5    LIKE type_t.num5
DEFINE l_flag6    LIKE type_t.num5
DEFINE l_success  LIKE type_t.num5
DEFINE l_ooba002  LIKE ooba_t.ooba002
DEFINE l_sql      STRING
DEFINE l_sql1     STRING
DEFINE l_sql2     STRING
DEFINE l_imaa005  LIKE imaa_t.imaa005
DEFINE l_pmdl004  LIKE pmdl_t.pmdl004
DEFINE l_pmdl025  LIKE pmdl_t.pmdl025  #送貨地址
DEFINE l_pmdl026  LIKE pmdl_t.pmdl026  #帳款地址 
#ming 20151225 add -----(S) 
DEFINE l_slip     LIKE oobx_t.oobx001 
#ming 20151225 add -----(E) 
DEFINE l_where    STRING   #160310-00004#1 add

#160531-00023#1---s
DEFINE l_pmdbdocno  LIKE pmdb_t.pmdbdocno 
DEFINE l_pmdbseq    LIKE pmdb_t.pmdbseq 
#160531-00023#1---e

   
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   CALL g_pmdb_d.clear()

   INITIALIZE g_wc TO NULL

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #單頭
      #ming 20151113 modify -----(S) 
      #INPUT tm.a,tm.b,tm.c,tm.d FROM a,b,c,d ATTRIBUTE(WITHOUT DEFAULTS)
      #   BEFORE INPUT
      #      LET tm.a = 'N'
      #      LET tm.b = 'N'
      #      LET tm.d = '1'
      #   
      #END INPUT
      INPUT tm.a,tm.b,tm.c,tm.d,tm.e FROM a,b,c,d,e ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            LET tm.a = 'N'
            LET tm.b = 'N'
            LET tm.d = '1' 
            LET tm.e = 'N' 
            
         ON CHANGE e
            CALL apmt500_01_set_entry()
            CALL apmt500_01_set_no_entry()
         
      END INPUT
      #ming 20151113 modify -----(E) 
      
      CONSTRUCT BY NAME g_wc ON pmdadocno,pmdadocdt,pmdb004,pmda002,pmda003,pmdb030,imaa009,imce141

         BEFORE CONSTRUCT
            #CALL cl_qbe_init()
 
         AFTER FIELD imaa009
             LET g_imaa009 = GET_FLDBUF(imaa009)   
             
         AFTER FIELD imce141
             LET g_imce141 = GET_FLDBUF(imce141)
             
             
         #一般欄位開窗相關處理
         #---------------------------<  Master  >---------------------------
         #----<<pmdadocno>>----
         #Ctrlp:construct.c.pmdadocno
         ON ACTION controlp INFIELD pmdadocno
            #add-point:ON ACTION controlp INFIELD pmdadocno
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   
			   LET l_pmdl025 = ''
			   LET l_pmdl026 = ''
			   SELECT pmdl025,pmdl026 INTO l_pmdl025,l_pmdl026 FROM pmdl_t
 			    WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
			   LET g_qryparam.where = " pmdastus = 'Y' AND pmdadocno IN (SELECT DISTINCT pmdadocno FROM pmda_t,pmdb_t ",
			                          "  WHERE pmdaent = pmdbent AND pmdadocno = pmdbdocno "
			   IF NOT cl_null(l_pmdl025) THEN     
               LET g_qryparam.where = g_qryparam.where , " AND (pmda024 = '",l_pmdl025,"' OR pmda024 IS NULL) "
            END IF
            IF NOT cl_null(l_pmdl026) THEN
               LET g_qryparam.where = g_qryparam.where , " AND (pmda025 = '",l_pmdl026,"' OR pmda025 IS NULL) "
            END IF
            
            #ming 20151225 add -----(S) 
            #如果單別是不走預算科目的 
            #就不需要開出有預算科目的資料 
            CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_slip 
            IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN 
               LET g_qryparam.where = g_qryparam.where, 
                                      " AND pmdb053 IS NULL " 
            END IF
            #ming 20151225 add -----(E) 
            
            #160310-00004#1 add str
            #組合過濾前後置單據資料SQL
            CALL s_aooi210_get_check_sql(g_site,'',g_pmdldocno,'4','','pmdadocno')
                 RETURNING l_success,l_where
            IF cl_null(l_where) THEN
               LET l_where = " 1=1 "
            END IF
            LET g_qryparam.where = g_qryparam.where," AND ",l_where
            #160310-00004#1 add end
         
			   LET g_qryparam.where = g_qryparam.where , " AND pmdbent = '",g_enterprise,"' AND pmdbsite = '",g_site,"' ",
			                                             " AND pmdb006 > pmdb049 AND pmdb032 = '1' ) "
			                                                                            
            CALL q_pmdadocno()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO pmdadocno  #顯示到畫面上

            NEXT FIELD pmdadocno                     #返回原欄位

         ON ACTION controlp INFIELD pmdb004
            #add-point:ON ACTION controlp INFIELD pmdb004
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " imaastus = 'Y' "
            CALL q_imaf001_15()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO pmdb004  #顯示到畫面上

            NEXT FIELD pmdb004                     #返回原欄位
            
         #----<<pmda002>>----
         #Ctrlp:construct.c.pmda002
         ON ACTION controlp INFIELD pmda002
            #add-point:ON ACTION controlp INFIELD pmda002
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda002  #顯示到畫面上

            NEXT FIELD pmda002                     #返回原欄位


         #----<<pmda003>>----
         #Ctrlp:construct.c.pmda003
         ON ACTION controlp INFIELD pmda003
            #add-point:ON ACTION controlp INFIELD pmda003
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmda003  #顯示到畫面上

            NEXT FIELD pmda003                     #返回原欄位

         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " imaastus = 'Y' "
            CALL q_imaa009()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009                     #返回原欄位
            
         ON ACTION controlp INFIELD imce141
            #add-point:ON ACTION controlp INFIELD imce141
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.where = " imcestus = 'Y' "
            CALL q_imce141()                           #呼叫開窗
            LET g_qryparam.where = " "
            DISPLAY g_qryparam.return1 TO imce141  #顯示到畫面上

            NEXT FIELD imce141 
            
      END CONSTRUCT
      
      INPUT ARRAY g_pmdb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL apmt500_01_b1_fill()
            LET g_rec_b = g_pmdb_d.getLength()
            
         BEFORE ROW
            LET l_ac = ARR_CURR()
            
         ON CHANGE check
            UPDATE apmt500_01_tmp SET pmda004 = g_pmdb_d[l_ac].check
              WHERE pmdbdocno = g_pmdb_d[l_ac].pmdbdocno AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
            DISPLAY BY NAME g_pmdb_d[l_ac].check

      END INPUT
      
      INPUT ARRAY g_pmdb2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b2,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE, 
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
         
         BEFORE INPUT
            CALL apmt500_01_b2_fill()
            LET g_rec_b2 = g_pmdb2_d.getLength()
            
         BEFORE ROW
            LET l_ac2 = ARR_CURR()
            LET g_pmdb2_d_t.* =g_pmdb2_d[l_ac2].*
            LET g_pmdb2_d_o.* =g_pmdb2_d[l_ac2].*
            CALL apmt500_01_set_entry_b()
            CALL apmt500_01_set_no_entry_b()
            
         AFTER FIELD pmdp021
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp021) THEN
               IF g_pmdb2_d[l_ac2].pmdp021 != g_pmdb2_d_t.pmdp021 OR cl_null(g_pmdb2_d_t.pmdp021) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM apmt500_01_tmp2 
                     WHERE pmdp001 = g_pmdb2_d[l_ac2].pmdp001 AND pmdp002 = g_pmdb2_d[l_ac2].pmdp002 
                       AND pmdp022 = g_pmdb2_d[l_ac2].pmdp022 AND pmdn010 = g_pmdb2_d[l_ac2].pmdn010
                       AND pmdp021 = g_pmdb2_d[l_ac2].pmdp021
                  IF l_n > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00333'
                     LET g_errparam.extend = g_pmdb2_d[l_ac2].pmdp021
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdb2_d[l_ac2].pmdp021 = g_pmdb2_d_t.pmdp021
                     NEXT FIELD pmdp021
                  END IF
               END IF
            END IF
         
         AFTER FIELD pmdp001
            CALL apmt500_01_pmdb004_ref(g_pmdb2_d[l_ac2].pmdp001) RETURNING g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
            DISPLAY BY NAME g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp001) THEN
               IF g_pmdb2_d[l_ac2].pmdp001 != g_pmdb2_d_t.pmdp001 OR cl_null(g_pmdb2_d_t.pmdp001) THEN
                  IF NOT apmt500_01_pmdp001_chk(g_pmdb2_d[l_ac2].pmdp001) THEN
                     LET g_pmdb2_d[l_ac2].pmdp001 = g_pmdb2_d_t.pmdp001
                     CALL apmt500_01_pmdb004_ref(g_pmdb2_d[l_ac2].pmdp001) RETURNING g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
                     DISPLAY BY NAME g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
                     NEXT FIELD pmdp001
                  END IF
               END IF
            END IF
            CALL apmt500_01_set_entry_b()
            CALL apmt500_01_set_no_entry_b()
            
         AFTER FIELD pmdp002
            CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
            DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp002) THEN
               IF g_pmdb2_d[l_ac2].pmdp002 != g_pmdb2_d_t.pmdp002 OR cl_null(g_pmdb2_d_t.pmdp002) THEN
                  IF NOT s_feature_check(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) THEN
                     LET g_pmdb2_d[l_ac2].pmdp002 = g_pmdb2_d_t.pmdp002
                     CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
                     DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add start ------------------------
                  IF NOT s_feature_direct_input(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002,g_pmdb2_d_t.pmdp002,g_pmdldocno,g_site) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #151224-00025#3 add end   ------------------------
                  #獲取採購供應商編號
                  LET l_pmdl004 = ''
                  SELECT pmdl004 INTO l_pmdl004 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
                  
                  #請採購替代是否依據BOM替代資料
                  #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
                  #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
                  CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_ooba002
                  IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0096') = "Y" THEN
                     IF NOT s_apmt500_chk_bom_replace(g_pmdb2_d[l_ac2].pmdb004,g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) THEN
                        LET g_pmdb2_d[l_ac2].pmdp002 = g_pmdb2_d_t.pmdp002
                        CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
                        DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
                        NEXT FIELD pmdp002
                     END IF
                  ELSE         
                     IF NOT s_pmaq_chk_replacement(l_pmdl004,g_pmdb2_d[l_ac2].pmdb004,g_pmdb2_d[l_ac2].pmdp001,'2',g_pmdb2_d[l_ac2].pmdb005,g_pmdb2_d[l_ac2].pmdp002) THEN
                        LET g_pmdb2_d[l_ac2].pmdp002 = g_pmdb2_d_t.pmdp002
                        CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
                        DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
                        NEXT FIELD pmdp002
                     END IF
                  END IF
               END IF
            END IF
         
         #160314-00009#9 add by zhujing 2016-3-22-----(S)
#         BEFORE FIELD pmdp002
#            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp001) THEN
#               IF s_feature_auto_chk(g_pmdb2_d[l_ac2].pmdp001) AND cl_null(g_pmdb2_d[l_ac2].pmdp002) THEN
#                  CALL s_feature_single(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002,g_site,g_pmdldocno)
#                      RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002
#                  CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
#                  DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
#                  DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002
#               END IF
#            END IF
         #160314-00009#9 add by zhujing 2016-3-22-----(E)
         
         AFTER FIELD pmdp022
         #ON CHANGE pmdp022
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp022) THEN
               IF g_pmdb2_d[l_ac2].pmdp022 != g_pmdb2_d_o.pmdp022 OR cl_null(g_pmdb2_d_o.pmdp022) THEN
                  IF NOT apmt500_01_pmdp022_chk(g_pmdb2_d[l_ac2].pmdp022) THEN
                     LET g_pmdb2_d[l_ac2].pmdp022 = g_pmdb2_d_t.pmdp022
                     NEXT FIELD pmdp022
                  END IF
                  
                  IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdb007)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp001)) THEN  #體參數使用採購計價單位
                     CALL s_aooi250_convert_qty(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdb007,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdb006)
                       RETURNING l_success,g_pmdb2_d[l_ac2].pmdp023
                     #數量取位
                     CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdp023)
                       RETURNING l_success,g_pmdb2_d[l_ac2].pmdp023                  
                  END IF
                     
                  IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp023) THEN
                     CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdp023)
                        RETURNING l_success,g_pmdb2_d[l_ac2].pmdp023
                     
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdn010)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp001)) THEN  #體參數使用採購計價單位
                        CALL s_aooi250_convert_qty(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdp023)
                          RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011
                        #數量取位
                        CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011)
                          RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011                  
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdb2_d_o.pmdp022 = g_pmdb2_d[l_ac2].pmdp022
         
         #AFTER FIELD pmdp023
         ON CHANGE pmdp023
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp023) THEN
               IF g_pmdb2_d[l_ac2].pmdp023 != g_pmdb2_d_o.pmdp023 OR cl_null(g_pmdb2_d_o.pmdp023) THEN
                  IF NOT cl_ap_chk_Range(g_pmdb2_d[l_ac2].pmdp023,"0.000","0","","","azz-00079",1) THEN
                     NEXT FIELD pmdp023
                  END IF
                  IF g_pmdb2_d[l_ac2].pmdp023 > g_pmdb2_d[l_ac2].pmdb006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'apm-00585'
                     LET g_errparam.extend = g_pmdb2_d[l_ac2].pmdp023
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_pmdb2_d[l_ac2].pmdp023 = g_pmdb2_d_t.pmdp023
                     NEXT FIELD pmdp023
                  END IF
                  
                  IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp022) THEN
                     CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdp023)
                        RETURNING l_success,g_pmdb2_d[l_ac2].pmdp023
                     
                     #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                     IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdn010)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp001))  THEN  #體參數使用採購計價單位
                        CALL s_aooi250_convert_qty(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdp023)
                          RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011
                        #數量取位
                        CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011)
                          RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011                  
                     END IF
                  END IF
               END IF
            END IF
            LET g_pmdb2_d_o.pmdp023 = g_pmdb2_d[l_ac2].pmdp023
          
         
         AFTER FIELD pmdn010
         #ON CHANGE pmdn010
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdn010) THEN
               IF g_pmdb2_d[l_ac2].pmdn010 != g_pmdb2_d_o.pmdn010 OR cl_null(g_pmdb2_d_o.pmdn010) THEN
                  IF NOT apmt500_01_pmdp022_chk(g_pmdb2_d[l_ac2].pmdn010) THEN
                     LET g_pmdb2_d[l_ac2].pmdn010 = g_pmdb2_d_t.pmdn010
                     NEXT FIELD pmdn010
                  END IF
                   
                  #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
                  IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdp023)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp001)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp022)) THEN  #體參數使用採購計價單位
                     CALL s_aooi250_convert_qty(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdp023)
                       RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011
                     #數量取位
                     CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011)
                       RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011                  
                  END IF
               END IF
            END IF
            LET g_pmdb2_d_o.pmdn010 = g_pmdb2_d[l_ac2].pmdn010
         
         AFTER FIELD pmdn011
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdn011) THEN
               IF g_pmdb2_d[l_ac2].pmdn011 != g_pmdb2_d_t.pmdn011 OR cl_null(g_pmdb2_d_t.pmdn011) THEN
                  IF NOT cl_ap_chk_Range(g_pmdb2_d[l_ac2].pmdn011,"0.000","0","","","azz-00079",1) THEN
                     NEXT FIELD pmdn011
                  END IF
                  IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdn010)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdn011)) THEN  #體參數使用採購計價單位
                     CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011)
                       RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011                  
                  END IF
               END IF
            END IF               
            
         ON ROW CHANGE
            UPDATE apmt500_01_tmp2 
               SET pmdp021 = g_pmdb2_d[l_ac2].pmdp021, 
                   pmdp001 = g_pmdb2_d[l_ac2].pmdp001,
                   pmdp002 = g_pmdb2_d[l_ac2].pmdp002,
                   pmdp022 = g_pmdb2_d[l_ac2].pmdp022,
                   pmdp023 = g_pmdb2_d[l_ac2].pmdp023,
                   pmdn010 = g_pmdb2_d[l_ac2].pmdn010,
                   pmdn011 = g_pmdb2_d[l_ac2].pmdn011
             WHERE pmdbdocno = g_pmdb2_d[l_ac2].pmdbdocno
               AND pmdbseq = g_pmdb2_d[l_ac2].pmdbseq


         ON ACTION controlp INFIELD pmdp001
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac2].pmdp001           #給予default值

            LET g_qryparam.where = "1=1 "
            
            LET l_sql = ''
            CALL s_control_get_sql("imaa001",'6','4',g_user,g_dept) RETURNING l_success,l_sql
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql
            END IF
            
            
            LET l_sql1 = ''
            CALL s_control_get_doc_sql("imaf016",g_pmdldocno,'4') RETURNING l_success,l_sql1
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql1
            END IF
            
            LET l_sql2 = ''
            CALL s_control_get_doc_sql("imaa009",g_pmdldocno,'5') RETURNING l_success,l_sql2
            IF l_success THEN
               LET g_qryparam.where = g_qryparam.where ," AND ",l_sql2
            END IF

            CALL q_imaf001_15()                                #呼叫開窗

            LET g_pmdb2_d[l_ac2].pmdp001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmdb2_d[l_ac2].pmdp001 TO pmdp001              #顯示到畫面上

            NEXT FIELD pmdp001                          #返回原欄位
         
          ON ACTION controlp INFIELD pmdp002
             LET l_imaa005 = ''
             CALL apmt500_01_get_imaa005(g_enterprise,g_pmdb2_d[l_ac2].pmdp001) RETURNING l_imaa005
             IF NOT cl_null(l_imaa005) THEN
                CALL s_feature_single(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002,g_site,g_pmdldocno)
                      RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002
                CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
                DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
                DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002
                
             END IF

         ON ACTION controlp INFIELD pmdp022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac2].pmdp022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac2].pmdp001
            CALL q_imao002()                                #呼叫開窗
            LET g_pmdb2_d[l_ac2].pmdp022 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdb2_d[l_ac2].pmdp022 TO pmdp022              #顯示到畫面上
            NEXT FIELD pmdp022      

         ON ACTION controlp INFIELD pmdn010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmdb2_d[l_ac2].pmdn010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_pmdb2_d[l_ac2].pmdp001
            CALL q_imao002()                             #呼叫開窗
            LET g_pmdb2_d[l_ac2].pmdn010 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_pmdb2_d[l_ac2].pmdn010 TO pmdn010              #顯示到畫面上
            NEXT FIELD pmdn010      


      END INPUT
      
      ON ACTION ok
         #产生请购明细单身
         CALL apmt500_01_gen_pmdl()
         
      ON ACTION check_all
         #请购明细单身全选
         CALL apmt500_01_check_all() 

      ON ACTION check_no_all
         #请购明细单身全不选
         CALL apmt500_01_check_no_all()
         
      ON ACTION gen_pmdn_draft
         #产生采购底稿
         #161109-00059#1-S
         LET g_pmdb_d[l_ac].check = GET_FLDBUF(check)  
         UPDATE apmt500_01_tmp SET pmda004 = g_pmdb_d[l_ac].check
           WHERE pmdbdocno = g_pmdb_d[l_ac].pmdbdocno AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
         #161109-00059#1-E        
         CALL apmt500_01_gen_pmdn_draft()

      ON ACTION gen_pmdn
         #产生采购明细单身
         IF l_ac2 IS NULL OR l_ac2 = 0 THEN CONTINUE DIALOG END IF
         #修改了需求數量，直接點產生採購明細ACTION，不會觸發ON CHANGE 或 AFTER FIELD 數量欄位，重新計算計價數量，所以這邊再重新計算一次
         #IF g_pmdb2_d[l_ac2].pmdp023 != g_pmdb2_d_t.pmdp023 AND g_pmdb2_d[l_ac2].pmdn011 = g_pmdb2_d_t.pmdn011 THEN
         
            IF NOT cl_null(g_pmdb2_d[l_ac2].pmdp022) THEN
               CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdp023)
                  RETURNING l_success,g_pmdb2_d[l_ac2].pmdp023
               
               #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
               IF (NOT cl_null(g_pmdb2_d[l_ac2].pmdn010)) AND (NOT cl_null(g_pmdb2_d[l_ac2].pmdp001))  THEN  #體參數使用採購計價單位
                  CALL s_aooi250_convert_qty(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdp023)
                    RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011
                  #數量取位
                  CALL s_aooi250_take_decimals(g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011)
                    RETURNING l_success,g_pmdb2_d[l_ac2].pmdn011                  
               END IF
               DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdn011
            END IF
         #END IF         
         UPDATE apmt500_01_tmp2 
               SET pmdp021 = g_pmdb2_d[l_ac2].pmdp021, 
                   pmdp001 = g_pmdb2_d[l_ac2].pmdp001,
                   pmdp002 = g_pmdb2_d[l_ac2].pmdp002,
                   pmdp022 = g_pmdb2_d[l_ac2].pmdp022,
                   pmdp023 = g_pmdb2_d[l_ac2].pmdp023,
                   pmdn010 = g_pmdb2_d[l_ac2].pmdn010,
                   pmdn011 = g_pmdb2_d[l_ac2].pmdn011
               WHERE pmdbdocno = g_pmdb2_d[l_ac2].pmdbdocno AND pmdbseq = g_pmdb2_d[l_ac2].pmdbseq

         #檢查單身的必輸欄位不可為空
         CALL apmt500_01_b2_fill()
         LET g_rec_b2 = g_pmdb2_d.getLength()
         
         IF g_rec_b2 > 0 THEN
            LET l_flag = 0
            LET l_flag1 = 0   #防止重複報錯
            LET l_flag2 = 0
            LET l_flag3 = 0
            LET l_flag4 = 0
            LET l_flag5 = 0
            LET l_flag6 = 0
            CALL cl_showmsg_init()
            FOR l_n = 1 TO g_rec_b2
                IF cl_null(g_pmdb2_d[l_n].pmdp021) AND l_flag1 = 0 THEN
                   CALL cl_errmsg('','pmdp021','','apm-00286',1) #採購底稿中的沖銷順序欄位不可為空！
                   LET l_flag = 1
                   LET l_flag1 = 1
                END IF
                IF cl_null(g_pmdb2_d[l_n].pmdp001) AND l_flag2 = 0 THEN
                   CALL cl_errmsg('','pmdp001','','apm-00287',1)  #採購底稿中的採購料號欄位不可為空！
                   LET l_flag = 1
                   LET l_flag2 = 1
                #150528 by whitney add start
                ELSE
                   #料件有使用產品特徴則不可空白
                   LET l_imaa005 = ''
                   CALL apmt500_01_get_imaa005(g_enterprise,g_pmdb2_d[l_n].pmdp001) RETURNING l_imaa005
                   IF NOT cl_null(l_imaa005) THEN
                      IF cl_null(g_pmdb2_d[l_n].pmdp002) THEN
                         LET g_pmdb2_d[l_n].pmdp002 = ' '
                      END IF         
                   END IF
                   UPDATE apmt500_01_tmp2 
                      SET pmdp002 = g_pmdb2_d[l_n].pmdp002
                    WHERE pmdbdocno = g_pmdb2_d[l_n].pmdbdocno
                      AND pmdbseq = g_pmdb2_d[l_n].pmdbseq
                #150528 by whitney add end
                END IF
                IF cl_null(g_pmdb2_d[l_n].pmdp022) AND l_flag3 = 0 THEN
                   CALL cl_errmsg('','pmdp022','','apm-00288',1)  #採購底稿中的採購單位欄位不可為空！
                   LET l_flag = 1
                   LET l_flag3 = 1
                END IF
                IF (cl_null(g_pmdb2_d[l_n].pmdp023) OR g_pmdb2_d[l_n].pmdp023 = 0) AND l_flag4 = 0 THEN
                   CALL cl_errmsg('','pmdp023','','apm-00289',1)  #採購底稿中的採購數量欄位不可為空且不能為零！
                   LET l_flag = 1
                   LET l_flag4 = 1
                END IF
                #整體參數未使用採購計價單位
                IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN   #161205-00025#2
                   IF cl_null(g_pmdb2_d[l_n].pmdn010) AND l_flag5 = 0 THEN
                      CALL cl_errmsg('','pmdn010','','apm-00290',1)  #採購底稿中的計價單位欄位不可為空！
                      LET l_flag = 1
                      LET l_flag5 = 1
                   END IF
                END IF #161205-00025#2
                IF cl_null(g_pmdb2_d[l_n].pmdn011) AND l_flag6 = 0 THEN
                   CALL cl_errmsg('','pmdn011','','apm-00291',1)  #採購底稿中的計價數量欄位不可為空！
                   LET l_flag = 1
                   LET l_flag6 = 1
                END IF
            END FOR
            CALL cl_err_showmsg()
            IF l_flag = 0 THEN  #沒有欄位值為空
               LET g_success = TRUE
               IF NOT apmt500_01_gen_pmdn() THEN
                  IF NOT cl_ask_confirm('apm-00284') THEN #產生失敗，是否繼續
                     LET g_success = FALSE                 
                     RETURN
                  END IF
               ELSE
                  IF cl_ask_confirm('apm-00285') THEN #產生成功，是否繼續
                     #清空單身欄位及臨時表中的值
                     LET l_ac = 0   #161109-00059#1 add
                     CLEAR FORM     #170426-00081#1 add 
                     INITIALIZE g_wc TO NULL  #170426-00081#1 add
                     CALL g_pmdb2_d.clear()
                     CALL g_pmdb_d.clear()                     
                     DELETE FROM apmt500_01_tmp
                     DELETE FROM apmt500_01_tmp2
                     CALL s_transaction_end('Y','0')  #160531-00023#1  mark
                     LET g_flag = 'Y'           #161109-00059#1
                     #CALL apmt500_01_input()   #161109-00059#1  mark
                     NEXT FIELD pmdadocno       #161109-00059#1  add                   
#                     #161109-00059#1-S
#                     IF g_flag = 'Y' THEN
#                        EXIT DIALOG 
#                     END IF
#                     #161109-00059#1-E
                  ELSE
                     LET INT_FLAG = TRUE 
                     #161109-00014#1-S   
                     #清空單身欄位及臨時表中的值
                     CALL g_pmdb2_d.clear()
                     CALL g_pmdb_d.clear()
                     DELETE FROM apmt500_01_tmp
                     DELETE FROM apmt500_01_tmp2                     
                     #161109-00014#1-E
                     #CALL s_transaction_end('N','0')  #160531-00023#1  #161109-00014 mark
                     CALL s_transaction_end('Y','0')   #161109-00014#1 
                     EXIT DIALOG
                  END IF
               END IF
            END IF
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00292'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
          
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
   
   
   
   IF INT_FLAG THEN
      CALL s_transaction_end('N','0')  #160531-00023#1
      RETURN
   ELSE   #160531-00023#1
      CALL s_transaction_end('Y','0')  #160531-00023#1
   END IF
END FUNCTION
#请购明细单身全选
PRIVATE FUNCTION apmt500_01_check_all()
DEFINE l_n          LIKE type_t.num5

   UPDATE apmt500_01_tmp SET pmda004 = 'Y'
   
   CALL apmt500_01_b1_fill()
   
END FUNCTION
#请购明细单身全不选
PRIVATE FUNCTION apmt500_01_check_no_all()
DEFINE l_n    LIKE type_t.num5

   UPDATE apmt500_01_tmp SET pmda004 = 'N'
   
   CALL apmt500_01_b1_fill()
   
END FUNCTION
#請購明細單身填充
PRIVATE FUNCTION apmt500_01_b1_fill()
DEFINE l_sql          STRING
DEFINE l_pmdb049      LIKE pmdb_t.pmdb049
DEFINE l_success      LIKE type_t.num5

       CALL g_pmdb_d.clear()
       LET g_cnt = l_ac  #161109-00059#1
       LET l_ac = 1
       
       #LET l_sql = " SELECT pmda004,pmdbdocno,pmdbseq,pmdb004,'','',pmdb005,pmdb007,pmdb006,pmdb006_1,pmdb030,pmdb033,pmda002,'',pmda003,'', ", #161205-00025#2 
       LET l_sql = " SELECT pmda004,pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,pmdb006_1,pmdb030,pmdb033,pmdb050,pmda002,pmda003, ", #161205-00025#2 #161222-00027#1 add pmdb050
                   "       t1.imaal003,t2.imaal004,t3.inaml004,t4.ooag011,t5.ooefl003 ", #161205-00025#2 
                   " FROM apmt500_01_tmp ",
                   #161205-00025#2--s
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=pmdb004 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN inaml_t t3 ON t3.inamlent="||g_enterprise||" AND t3.inaml001=pmdb004 AND t3.inaml002=pmdb005 AND t3.inaml003='"||g_dlang||"' ",
                   "   LEFT JOIN ooag_t t4 ON t4.ooagent="||g_enterprise||" AND t4.ooag001=pmda002  ",
                   "   LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=pmda003 AND t5.ooefl002='"||g_dlang||"' ",
                   #161205-00025#2--e
                   " ORDER BY pmdbdocno,pmdbseq "
                   
       PREPARE apmt500_01_pmdb_pb FROM l_sql
       DECLARE apmt500_01_pmdb_cs CURSOR FOR apmt500_01_pmdb_pb

       FOREACH apmt500_01_pmdb_cs INTO g_pmdb_d[l_ac].check,g_pmdb_d[l_ac].pmdbdocno,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb004,#g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004, #161205-00025#2 
                                       g_pmdb_d[l_ac].pmdb005,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb006_1,
                                       g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb033,g_pmdb_d[l_ac].pmdb050,g_pmdb_d[l_ac].pmda002,#g_pmdb_d[l_ac].oofa011, #161205-00025#2  #161222-00027#1 add pmdb050
                                       g_pmdb_d[l_ac].pmda003,#g_pmdb_d[l_ac].ooefl003  #161205-00025#2 
                                       #161205-00025#2--s
                                       g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004,g_pmdb_d[l_ac].pmdb005_desc,
                                       g_pmdb_d[l_ac].oofa011,g_pmdb_d[l_ac].ooefl003
                                       #161205-00025#2--e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF
          
          #161205-00025#2--s
          #CALL apmt500_01_pmdb004_ref(g_pmdb_d[l_ac].pmdb004) RETURNING g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004
          #DISPLAY BY NAME g_pmdb_d[l_ac].imaal003,g_pmdb_d[l_ac].imaal004
          #
          #CALL s_feature_description(g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb005) RETURNING l_success,g_pmdb_d[l_ac].pmdb005_desc
          #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb005_desc
          #161205-00025#2--e
          
          ##未轉採購量
          #LET l_pmdb049 = 0
          #SELECT pmdb049 INTO l_pmdb049 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = g_pmdb_d[l_ac].pmdbdocno AND pmdbseq = g_pmdb_d[l_ac].pmdbseq
          #IF cl_null(l_pmdb049) THEN
          #   LET l_pmdb049 = 0
          #END IF
          #
          #LET g_pmdb_d[l_ac].pmdb006_1 = g_pmdb_d[l_ac].pmdb006 - l_pmdb049
          
          #161205-00025#2--s
          #CALL apmt500_01_pmda002_ref(g_pmdb_d[l_ac].pmda002) RETURNING g_pmdb_d[l_ac].oofa011
          #DISPLAY BY NAME g_pmdb_d[l_ac].oofa011
          #
          #CALL apmt500_01_pmda003_ref(g_pmdb_d[l_ac].pmda003) RETURNING g_pmdb_d[l_ac].ooefl003
          #DISPLAY BY NAME g_pmdb_d[l_ac].ooefl003
          #161205-00025#2--e
          
          
          LET l_ac = l_ac + 1
          IF l_ac > g_max_rec AND g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  9035
             LET g_errparam.extend =  ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF
         
       END FOREACH
       
       #161109-00059#1-S
       LET l_ac = l_ac - 1
       IF l_ac >= g_cnt THEN
          LET l_ac = g_cnt
       END IF
       IF l_ac = 0 THEN
          LET l_ac = 1
       END IF
       #161109-00059#1-E
       CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())
        
       
END FUNCTION
#产生采购明细单身
PRIVATE FUNCTION apmt500_01_gen_pmdn()
   DEFINE l_sql       STRING
   DEFINE l_pmdb030   LIKE pmdb_t.pmdb030
   DEFINE l_pmdl022   LIKE pmdl_t.pmdl022
   DEFINE l_pmdl020   LIKE pmdl_t.pmdl020
   DEFINE l_pmdl025   LIKE pmdl_t.pmdl025
   DEFINE l_pmdl026   LIKE pmdl_t.pmdl026
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_rate      LIKE inaj_t.inaj014
   DEFINE l_imaf158   LIKE imaf_t.imaf158
   DEFINE l_pmdl011   LIKE pmdl_t.pmdl011
   DEFINE l_pmdl012   LIKE pmdl_t.pmdl012
   DEFINE l_pmdl004   LIKE pmdl_t.pmdl004
   DEFINE l_n         LIKE type_t.num5
   DEFINE l_controlno LIKE ooha_t.ooha001
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_pmdl015   LIKE pmdl_t.pmdl015
   DEFINE l_xrcd113   LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114   LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115   LIKE xrcd_t.xrcd115
   DEFINE l_pmdl040   LIKE pmdl_t.pmdl040
   DEFINE l_pmdl041   LIKE pmdl_t.pmdl041
   DEFINE l_pmdl042   LIKE pmdl_t.pmdl042
   DEFINE l_pmdb030_1 LIKE pmdb_t.pmdb030
   DEFINE l_oodbl004  LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005   LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006   LIKE oodb_t.oodb006    #稅率 
   DEFINE l_oodb011   LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定   
   DEFINE l_pmdl024   LIKE pmdl_t.pmdl024
   DEFINE l_pmdl017   LIKE pmdl_t.pmdl017
   DEFINE l_pmdl009   LIKE pmdl_t.pmdl009
   DEFINE l_pmdl010   LIKE pmdl_t.pmdl010
   DEFINE l_pmdl023   LIKE pmdl_t.pmdl023
   DEFINE l_pmdldocdt LIKE pmdl_t.pmdldocdt
   DEFINE l_pmdl054   LIKE pmdl_t.pmdl054
   DEFINE l_type      LIKE type_t.chr1
   DEFINE l_imaa005   LIKE imaa_t.imaa005
   DEFINE l_pmdb006   LIKE pmdb_t.pmdb006   #總未轉請購量
   DEFINE l_pmdb006_1 LIKE pmdb_t.pmdb006   #總請購量
   DEFINE l_pmdn007   LIKE pmdn_t.pmdn007
   DEFINE l_pmdl005   LIKE pmdl_t.pmdl005
   DEFINE l_imaa004   LIKE imaa_t.imaa004
   DEFINE l_pmdbdocno LIKE pmdb_t.pmdbdocno
   DEFINE l_pmdbseq   LIKE pmdb_t.pmdbseq
   DEFINE l_pmdn050   LIKE pmdn_t.pmdn050
   #ming 20151111 add -----(S) 
   DEFINE l_code_d_bas_0098 LIKE type_t.chr80
   DEFINE l_slip            LIKE oobal_t.oobal002
   #ming 20151111 add -----(E) 
   #161205-00025#2--s 
   DEFINE l_mfg_0076  LIKE type_t.chr80
   DEFINE l_pmdn004   LIKE pmdn_t.pmdn004
   DEFINE l_pmdn005   LIKE pmdn_t.pmdn005  
   #161205-00025#2--e
   DEFINE l_ooff013   LIKE ooff_t.ooff013   #161031-00025#5
   
   LET r_success = TRUE
   
   #ming 20151111 add -----(S) 
   #取得單別 
   CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_slip

   #取得單別參數 
   CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0098')
        RETURNING l_code_d_bas_0098
   #ming 20151111 add -----(E) 

   #將採購底稿清單資料匯總產生成採購明細資料
   #1.若限定條件中的採構匯總策略選擇"1:不同交期匯總取價"的話則將採購底稿資料依據
   #  採購料號、採購產品特徵、採購單位、計價單位做Group匯總產生採購項次明細資料
   #2.若限定條件中的採構匯總策略選擇"2:不同交期拆解"的話則將採購底稿資料依據
   #  採購料號、採購產品特徵、採購單位、計價單位、需求日期做Group匯總產生採購項次明細資料
      
   #請購轉採購時，所有的費用料號（imaa004 = 'E'）都不合併，那算雜項料件會打資料在備註

   CASE tm.d 
      WHEN '1' 
         #151225-00002#1 20151225 modify by ming -----(S) 
         #修改為備註一樣要匯總，然後依參數決定備註是否保留 
         #LET l_sql = " SELECT '',0,pmdp001,pmdp002,pmdp022,SUM(pmdp023),pmdn010,SUM(pmdn011),'',SUM(pmdb006),SUM(pmdb006_1),'', ", #add by lixiang
         #            "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  ",   #add by lixiang 2015/10/15
         #            " FROM apmt500_01_tmp2 ",
         #            "  WHERE pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 <> 'E' ) ",
         #            "    AND pmdn050 IS NULL ",
         #            " GROUP BY '',0,pmdp001,pmdp002,pmdp022,pmdn010,'','',", #add by lixiang 
         #            "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  ",   #add by lixiang 2015/10/15
         #            #"  ORDER BY pmdp001,pmdp002 " ,
         #                
         #            " UNION ",
         #                 
         #            " SELECT pmdbdocno,pmdbseq,pmdp001,pmdp002,pmdp022,pmdp023,pmdn010,pmdn011,'',pmdb006,pmdb006_1,pmdn050,pmdn036,pmdn037,pmdn038 ", #add by lixiang #add by lixiang 2015/10/15
         #            " FROM apmt500_01_tmp2 ",
         #            " WHERE (pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 = 'E' ) ",
         #            "        OR pmdn050 IS NOT NULL )",
         #            "  ORDER BY pmdp001,pmdp002 "             
         LET l_sql = " SELECT '',0,pmdp001,pmdp002,pmdp022,SUM(pmdp023),pmdn010,SUM(pmdn011),'',SUM(pmdb006),SUM(pmdb006_1), ", 
                     "        pmdn050,pmdn058, ",
                     #160801-00004#1---s
                     #"        pmdn028,pmdn029, ",  #150819-00010 by whitney add
                     "        CASE WHEN pmdn028 IS NULL THEN '' ELSE pmdn028 END , ",
                     "        CASE WHEN pmdn029 IS NULL THEN '' ELSE pmdn029 END , ",
                     "        CASE WHEN pmdn053 IS NULL THEN '' ELSE pmdn053 END , ",
                     #160801-00004#1---e
                     "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",
                     "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",
                     "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END   ",
                     "   FROM apmt500_01_tmp2 ",
                     "  GROUP BY '',0,pmdp001,pmdp002,pmdp022,pmdn010,'','',",
                     "        pmdn050,pmdn058, ",
                     #160801-00004#1---s
                     #"        pmdn028,pmdn029, ",  #150819-00010 by whitney add
                     "        CASE WHEN pmdn028 IS NULL THEN '' ELSE pmdn028 END , ",
                     "        CASE WHEN pmdn029 IS NULL THEN '' ELSE pmdn029 END , ",
                     "        CASE WHEN pmdn053 IS NULL THEN '' ELSE pmdn053 END , ",
                     #160801-00004#1---e
                     "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",
                     "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",
                     "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  "
         #151225-00002#1 20151225 modify by ming -----(E) 
      WHEN '2'
         #151225-00002#1 20151225 modify by ming -----(S) 
         #LET l_sql = " SELECT '',0,pmdp001,pmdp002,pmdp022,SUM(pmdp023),pmdn010,SUM(pmdn011),pmdb030,SUM(pmdb006),SUM(pmdb006_1),'', ",  #add by lixiang
         #            "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  ",   #add by lixiang 2015/10/15
         #            " FROM apmt500_01_tmp2 ",
         #            "  WHERE pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 <> 'E' ) ",
         #            "    AND pmdn050 IS NULL ",
         #            " GROUP BY '',0,pmdp001,pmdp002,pmdp022,pmdn010,pmdb030,'', ",  #add by lixiang
         #            "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",  #add by lixiang 2015/10/15
         #            "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  ",   #add by lixiang 2015/10/15
         #            #"  ORDER BY pmdp001,pmdp002 " ,
         #                 
         #            " UNION ",
         #               
         #            " SELECT pmdbdocno,pmdbseq,pmdp001,pmdp002,pmdp022,pmdp023,pmdn010,pmdn011,pmdb030,pmdb006,pmdb006_1,pmdn050,pmdn036,pmdn037,pmdn038 ", #add by lixiang #add by lixiang 2015/10/15
         #            " FROM apmt500_01_tmp2 ",
         #            " WHERE (pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 = 'E' ) ",
         #            "        OR pmdn050 IS NOT NULL )",
         #            "  ORDER BY pmdp001,pmdp002 "    
         LET l_sql = " SELECT '',0,pmdp001,pmdp002,pmdp022,SUM(pmdp023),pmdn010,SUM(pmdn011), ", 
                     "        pmdb030,SUM(pmdb006),SUM(pmdb006_1),pmdn050,pmdn058, ",  
                     #160801-00004#1---s
                     #"        pmdn028,pmdn029, ",  #150819-00010 by whitney add
                     "        CASE WHEN pmdn028 IS NULL THEN '' ELSE pmdn028 END , ",
                     "        CASE WHEN pmdn029 IS NULL THEN '' ELSE pmdn029 END , ",
                     "        CASE WHEN pmdn053 IS NULL THEN '' ELSE pmdn053 END , ",
                     #160801-00004#1---e
                     "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",
                     "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",
                     "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  ",
                     "   FROM apmt500_01_tmp2 ",
                     "  GROUP BY '',0,pmdp001,pmdp002,pmdp022,pmdn010,pmdb030,'', ",
                     "        pmdn050,pmdn058, ",
                     #160801-00004#1---s
                     #"        pmdn028,pmdn029, ",  #150819-00010 by whitney add
                     "        CASE WHEN pmdn028 IS NULL THEN '' ELSE pmdn028 END , ",
                     "        CASE WHEN pmdn029 IS NULL THEN '' ELSE pmdn029 END , ",
                     "        CASE WHEN pmdn053 IS NULL THEN '' ELSE pmdn053 END , ",
                     #160801-00004#1---e
                     "        CASE WHEN pmdn036 IS NULL THEN '' ELSE pmdn036 END , ",
                     "        CASE WHEN pmdn037 IS NULL THEN '' ELSE pmdn037 END , ",
                     "        CASE WHEN pmdn038 IS NULL THEN '' ELSE pmdn038 END  "
         #151225-00002#1 20151225 modify by ming -----(E) 
   END CASE
        
   PREPARE ins_pmdn_pre FROM l_sql
   DECLARE ins_pmdn_cs CURSOR FOR ins_pmdn_pre
   
   CALL cl_err_collect_init()
        
   LET l_pmdbdocno = ''
   LET l_pmdbseq = ''
   
   #161205-00025#2--s         
   LET l_pmdl011 = ''
   LET l_pmdl012 = ''
   LET l_pmdl022 = ''
   LET l_pmdl020 = ''
   LET l_pmdl025 = ''
   LET l_pmdl026 = ''
   LET l_pmdl015 = ''
   LET l_pmdl024 = ''
   LET l_pmdl005 = ''
   LET l_pmdl004 = ''
   LET l_pmdl017 = ''
   LET l_pmdl009 = ''
   LET l_pmdl010 = ''
   LET l_pmdl023 = ''
   LET l_pmdldocdt = ''
   LET l_pmdl054 = ''
   SELECT pmdl004,pmdl005,pmdl011,pmdl012,pmdl022,pmdl020,pmdl025,pmdl026,pmdl015,pmdl024,
          pmdl017,pmdl009,pmdl010,pmdl023,pmdldocdt,pmdl054    
     INTO l_pmdl004,l_pmdl005,l_pmdl011,l_pmdl012,l_pmdl022,l_pmdl020,l_pmdl025,l_pmdl026,l_pmdl015,l_pmdl024,
          l_pmdl017,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdldocdt,l_pmdl054
     FROM pmdl_t 
    WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
  
   #取得稅別類型
   CALL s_tax_chk(g_site,l_pmdl011)
        RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011   
  
   #先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
   LET l_controlno = ''
   CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno   
   
   LET l_mfg_0076 = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076')
   
   LET l_sql = " SELECT qcap006 FROM qcap_t ",
               " WHERE qcapent = '",g_enterprise,"' ",
               "  AND qcapsite = '",g_site,"' ",
               "  AND qcap001 = ? ",
               "  AND qcap002 = '",l_pmdl004,"' ",
               "  AND ((CASE WHEN qcap005 IS NULL THEN ' ' ELSE qcap005 END) = ? OR qcap005 = 'ALL' ) ",
               "  AND ((CASE WHEN qcap003 IS NULL THEN ' ' ELSE qcap003 END) = ? OR qcap003 = 'ALL' ) ",
               "  AND ((CASE WHEN qcap004 IS NULL THEN ' ' ELSE qcap004 END) = ? ) "
   PREPARE get_qcap FROM l_sql
   #161205-00025#2--e
   
   #161031-00025#5 add-S
   #有來源時，同原單身備註，依單別參數帶入來源單據長備註
   LET l_sql = " SELECT pmdp003,pmdp004 FROM pmdp_t ",
               "       WHERE pmdpent = ",g_enterprise,
               "         AND pmdpdocno = ? AND pmdpseq = ? "
   PREPARE pmdp_pre FROM l_sql
   DECLARE pmdp_cs CURSOR FOR pmdp_pre             
   #161031-00025#5 add-E
        
   IF tm.e = 'N' THEN 
      FOREACH ins_pmdn_cs INTO l_pmdbdocno,l_pmdbseq,g_pmdn.pmdn001,g_pmdn.pmdn002,g_pmdn.pmdn006,g_pmdn.pmdn007,g_pmdn.pmdn010,
                               g_pmdn.pmdn011,l_pmdb030,l_pmdb006,l_pmdb006_1,
                               g_pmdn.pmdn050,   #add by lixiang 
                               g_pmdn.pmdn058,   #ming 20151225 add 
                               g_pmdn.pmdn028,g_pmdn.pmdn029,  #150819-00010 by whitney add
                               g_pmdn.pmdn053,   #160801-00004#1
                               g_pmdn.pmdn036,g_pmdn.pmdn037,g_pmdn.pmdn038 #add by lixiang 2015/10/15
                                 
                                   
                       
         #150528 by whitney mark start
         ##料件有使用產品特徴則不可空白
         #LET l_imaa005 = ''
         #CALL apmt500_01_get_imaa005(g_enterprise,g_pmdn.pmdn001) RETURNING l_imaa005
         #IF NOT cl_null(l_imaa005) THEN
         #   IF cl_null(g_pmdn.pmdn002) THEN
         #      INITIALIZE g_errparam TO NULL
         #      LET g_errparam.code = 'sub-00280'
         #      LET g_errparam.extend = g_pmdn.pmdn001
         #      LET g_errparam.popup = TRUE
         #      CALL cl_err()
         #      LET r_success = FALSE                 
         #      #RETURN r_success         
         #   END IF         
         #END IF
         #150528 by whitney mark end

         ##採購單有關聯單據時，檢查採購量,單位批量，最小採購量，請采容差率
         CALL apmt500_01_pmdn007_chk(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn007,l_pmdb006,l_pmdb006_1)
              RETURNING l_success,l_pmdn007
         IF NOT l_success THEN
            LET r_success = FALSE                 
            RETURN r_success         
         END IF         
         #若數量有改變，則重新計算計價數量
         IF l_pmdn007<> g_pmdn.pmdn007 THEN
            IF (NOT cl_null(g_pmdn.pmdn010)) AND (NOT cl_null(g_pmdn.pmdn006)) THEN  #體參數使用採購計價單位
               CALL s_aooi250_convert_qty(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn010,l_pmdn007)
                    RETURNING l_success,g_pmdn.pmdn011
               #數量取位
               CALL s_aooi250_take_decimals(g_pmdn.pmdn010,g_pmdn.pmdn011)
                    RETURNING l_success,g_pmdn.pmdn011                  
            END IF
            LET g_pmdn.pmdn007 = l_pmdn007
         END IF
           
         LET g_pmdn.pmdnsite = g_site 
         LET g_pmdn.pmdndocno = g_pmdldocno
              
         #項次加1
         SELECT MAX(pmdnseq)+1 INTO g_pmdn.pmdnseq FROM pmdn_t
          WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdldocno
         IF cl_null(g_pmdn.pmdnseq) OR g_pmdn.pmdnseq = 0 THEN
            LET g_pmdn.pmdnseq = 1
         END IF
           
         #計算交貨、到廠、到庫日期
         #採構匯總策略選擇"1:不同交期匯總取價"時，則取匯總資料中需求日期最早的那一筆，
         #若採構匯總策略選擇"2:不同交期拆解"，則等於匯總的需求日期
           
         LET g_pmdn.pmdn014 = l_pmdb030   #到庫日期
         IF tm.d = '1' THEN
            IF NOT cl_null(g_pmdn.pmdn002) THEN
               SELECT MIN(pmdb030) INTO g_pmdn.pmdn014 FROM apmt500_01_tmp2 
                WHERE pmdp001 = g_pmdn.pmdn001 AND pmdp002 = g_pmdn.pmdn002 AND pmdp022 = g_pmdn.pmdn006 AND pmdn010 = g_pmdn.pmdn010
            ELSE
               SELECT MIN(pmdb030) INTO g_pmdn.pmdn014 FROM apmt500_01_tmp2 
                WHERE pmdp001 = g_pmdn.pmdn001 AND pmdp022 = g_pmdn.pmdn006 AND pmdn010 = g_pmdn.pmdn010
            END IF
            
         END IF
           
         #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
         #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
         CALL apmt500_01_date_count(g_pmdn.pmdn014) RETURNING g_pmdn.pmdn013,g_pmdn.pmdn012
           
         LET g_pmdn.pmdn020 = "1"
         CALL apmt500_01_pmdn014_to_pmdn020(g_pmdn.pmdn014) RETURNING g_pmdn.pmdn020
                       
                  
         #採購欄位賦初始值
         LET g_pmdn.pmdn019 = "1"  #料件子特性
         #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
         #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
         #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
         #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
         LET g_pmdn.pmdn008 = ''
         LET g_pmdn.pmdn009 = 0
         LET g_pmdn.pmdn033 = ''
         LET l_imaf158 = ''
         SELECT imaf158,imaf165,imaf015 INTO l_imaf158,g_pmdn.pmdn033,g_pmdn.pmdn008 FROM imaf_t
          WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdn.pmdn001
           
         LET l_rate = 1
         IF NOT cl_null(g_pmdn.pmdn008) THEN
            #CALL s_aimi190_get_convert(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn008) RETURNING l_success,l_rate
            #LET g_pmdn.pmdn009 = g_pmdn.pmdn007 * l_rate
            CALL s_aooi250_convert_qty(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn008,g_pmdn.pmdn007)
                 RETURNING l_success,g_pmdn.pmdn009
         END IF
           
           
         IF l_imaf158 = '1' THEN
            LET g_pmdn.pmdn019 = '2'
         END IF
         IF l_imaf158 = '2' THEN
            LET g_pmdn.pmdn019 = '3'
         END IF
           
           
         LET g_pmdn.pmdn021 = "N"
         LET g_pmdn.pmdn022 = "Y"
         LET g_pmdn.pmdn024 = "N"  #多交期否
         IF tm.d = '1' THEN
            #當一個採購明細有對應的多筆來源，且來源的交期不一樣時，多交期為'Y'
            LET l_n = 0
            #151225-00002#1 20151225 modify by ming -----(S) 
            #1.分群條件已經增加到pmdn036,pmdn037,pmdn038,pmdn050，不應只有簡單的幾個欄位判斷是否有多筆交期資料 
            #2.以下兩個的where條件根本一樣 
            #IF NOT cl_null(g_pmdn.pmdn002) THEN
            #   SELECT COUNT(DISTINCT pmdb030) INTO l_n FROM apmt500_01_tmp2 
            #    WHERE pmdp001 = g_pmdn.pmdn001 AND pmdp002 = g_pmdn.pmdn002 AND pmdp022 = g_pmdn.pmdn006 #AND pmdn010 = g_pmdn.pmdn007
            #       
            #ELSE
            #   SELECT COUNT(DISTINCT pmdb030) INTO l_n FROM apmt500_01_tmp2 
            #    WHERE pmdp001 = g_pmdn.pmdn001 AND pmdp002 = g_pmdn.pmdn002 AND pmdp022 = g_pmdn.pmdn006 #AND pmdn010 = g_pmdn.pmdn007
            #        
            #END IF
            IF NOT cl_null(g_pmdn.pmdn002) THEN 
               SELECT COUNT(DISTINCT pmdb030) INTO l_n
                 FROM apmt500_01_tmp2
                WHERE pmdp001 = g_pmdn.pmdn001
                  AND pmdp002 = g_pmdn.pmdn002
                  AND pmdp022 = g_pmdn.pmdn006
                  AND COALESCE(pmdn036,' ') = COALESCE(g_pmdn.pmdn036,' ')
                  AND COALESCE(pmdn037,' ') = COALESCE(g_pmdn.pmdn037,' ')
                  AND COALESCE(pmdn038,' ') = COALESCE(g_pmdn.pmdn038,' ')
                  AND COALESCE(pmdn050,' ') = COALESCE(g_pmdn.pmdn050,' ') 
                  AND COALESCE(pmdn058,' ') = COALESCE(g_pmdn.pmdn058,' ')
                  #170328-00119#1----s
                  AND COALESCE(pmdn028,' ') = COALESCE(g_pmdn.pmdn028,' ') 
                  AND COALESCE(pmdn029,' ') = COALESCE(g_pmdn.pmdn029,' ') 
                  AND COALESCE(pmdn053,' ') = COALESCE(g_pmdn.pmdn053,' ') 
                  #170328-00119#1----e                     
            ELSE 
               SELECT COUNT(DISTINCT pmdb030) INTO l_n
                 FROM apmt500_01_tmp2
                WHERE pmdp001 = g_pmdn.pmdn001
                  AND pmdp022 = g_pmdn.pmdn006
                  AND COALESCE(pmdn036,' ') = COALESCE(g_pmdn.pmdn036,' ')
                  AND COALESCE(pmdn037,' ') = COALESCE(g_pmdn.pmdn037,' ')
                  AND COALESCE(pmdn038,' ') = COALESCE(g_pmdn.pmdn038,' ')
                  AND COALESCE(pmdn050,' ') = COALESCE(g_pmdn.pmdn050,' ') 
                  AND COALESCE(pmdn058,' ') = COALESCE(g_pmdn.pmdn058,' ') 
                  #170328-00119#1----s
                  AND COALESCE(pmdn028,' ') = COALESCE(g_pmdn.pmdn028,' ') 
                  AND COALESCE(pmdn029,' ') = COALESCE(g_pmdn.pmdn029,' ') 
                  AND COALESCE(pmdn053,' ') = COALESCE(g_pmdn.pmdn053,' ') 
                  #170328-00119#1----e             
            END IF 
            #151225-00002#1 20151225 modify by ming -----(E) 
            IF l_n > 1 THEN
               LET g_pmdn.pmdn024 = "Y"
            END IF
         END IF 
      
         #151225-00002#1 20151225 mark by ming -----(S) 
         #藉此機會，調整架構，備註是否要保留，應該在寫入資料前就決定好  
         ##ming 20151111 add -----(S) 
         ##如果單別參數設定不保留備註時，非費用料的就要清空 
         #LET l_imaa004 = ''
         #SELECT imaa004 INTO l_imaa004
         #  FROM imaa_t
         # WHERE imaaent = g_enterprise
         #   AND imaa001 = g_pmdn.pmdn001
         #
         #IF l_imaa004 != 'E' THEN
         #   IF l_code_d_bas_0098 != 'Y' OR cl_null(l_code_d_bas_0098) THEN
         #      LET g_pmdn.pmdn050 = ''
         #   END IF
         #END IF
         ##ming 20151111 add -----(E) 
         #151225-00002#1 20151225 mark by ming -----(E) 
           
         #請購轉採購時，有備註的都不合併，都是一對一，不會有多交期
         #費用料號帶入請購單的備註 
         #add by lixiang 
         IF NOT cl_null(g_pmdn.pmdn050) THEN
            LET g_pmdn.pmdn024 = 'N'
         END IF
           
         LET g_pmdn.pmdnunit = g_site
         LET g_pmdn.pmdnorga = g_site
         
         #161205-00025#2--s         
         #LET l_pmdl011 = ''
         #LET l_pmdl012 = ''
         #LET l_pmdl022 = ''
         #LET l_pmdl020 = ''
         #LET l_pmdl025 = ''
         #LET l_pmdl026 = ''
         #LET l_pmdl015 = ''
         #LET l_pmdl024 = ''
         #LET l_pmdl005 = ''
         #SELECT pmdl004,pmdl005,pmdl011,pmdl012,pmdl022,pmdl020,pmdl025,pmdl026,pmdl015,pmdl024 
         #  INTO l_pmdl004,l_pmdl005,l_pmdl011,l_pmdl012,l_pmdl022,l_pmdl020,l_pmdl025,l_pmdl026,l_pmdl015,l_pmdl024
         #  FROM pmdl_t 
         # WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
         #161205-00025#2--e
         
         LET g_pmdn.pmdn016 = l_pmdl011
         LET g_pmdn.pmdn017 = l_pmdl012
         
         #161205-00025#2--s   
         ##取得稅別類型
         #CALL s_tax_chk(g_site,l_pmdl011)
         #     RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         #161205-00025#2--e      
         IF l_oodb011 = '2' AND NOT cl_null(g_pmdn.pmdn001) AND NOT cl_null(l_pmdl024) THEN
            #依料件設定
            #170222-00027#1---s
            #CALL s_tax_chktype(g_site,l_pmdl004,g_pmdn.pmdn001,'2',l_pmdl024)
            #     RETURNING l_success,g_pmdn.pmdn016,g_pmdn.pmdn017
            CALL s_tax_by_item(g_site,l_pmdl011,l_pmdl004,g_pmdn.pmdn001,'2',l_pmdl024)
               RETURNING l_success,g_pmdn.pmdn016,g_pmdn.pmdn017
            #170222-00027#1---e
            IF NOT l_success THEN
               #稅別檢查失敗，將稅別、稅率清空
               LET g_pmdn.pmdn016 = ''
               LET g_pmdn.pmdn017 = ''
            END IF                   
         END IF
         IF cl_null(g_pmdn.pmdn016) OR cl_null(g_pmdn.pmdn017) THEN
            #依正常稅率
            LET g_pmdn.pmdn016 = l_pmdl011
            LET g_pmdn.pmdn017 = l_pmdl012
         END IF 
           
         LET g_pmdn.pmdn023 = l_pmdl022
         LET g_pmdn.pmdn025 = l_pmdl025    
         LET g_pmdn.pmdn026 = l_pmdl026
         LET g_pmdn.pmdn031 = l_pmdl020
         LET g_pmdn.pmdn032 = "1"
         LET g_pmdn.pmdn035 = "1"
         LET g_pmdn.pmdn040 = "1"
         LET g_pmdn.pmdn045 = "1"
#150819-00010 by whitney mark start
#         LET g_pmdn.pmdn028 = ''
#         LET g_pmdn.pmdn029 = ''
#150819-00010 by whitney mark end
         LET g_pmdn.pmdn003 = ''
      
         #161205-00025#2--s
         ##先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
         #LET l_controlno = ''
         #CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
         #161205-00025#2--e
         
         IF NOT cl_null(l_controlno) THEN
            #161205-00025#2--s
            #LET l_pmdl004 = ''
            #SELECT pmdl004 INTO l_pmdl004 FROM pmdl_t 
            # WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
            #161205-00025#2--e
            SELECT COUNT(*) INTO l_n FROM pmap_t 
             WHERE pmapent = g_enterprise AND pmapsite = g_site AND pmap001 = l_pmdl004
               AND pmap002 = l_controlno AND pmap003 = g_pmdn.pmdn001 AND pmap004 = g_pmdn.pmdn002
            #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
            IF l_n > 0 THEN
               #SELECT pmap009,pmap010,pmap011,pmap012,pmap014,pmap005
               #  INTO g_pmdn.pmdnunit,g_pmdn.pmdn028,g_pmdn.pmdn029,g_pmdn.pmdn025,g_pmdn.pmdn031,g_pmdn.pmdn003
               SELECT pmap009,pmap012,pmap014,pmap005
                 INTO g_pmdn.pmdnunit,g_pmdn.pmdn025,g_pmdn.pmdn031,g_pmdn.pmdn003
                 FROM pmdp_t 
                WHERE pmdpent = g_enterprise AND pmapsite = g_site AND pmap001 = l_pmdl004
                  AND pmap002 = l_controlno AND pmap003 = g_pmdn.pmdn001 AND pmap004 = g_pmdn.pmdn002
       
            END IF
         END IF
           
         IF cl_null(l_controlno) OR l_n = 0 THEN        
            #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件
            #SELECT imaf091,imaf092,imaf157
            #  INTO g_pmdn.pmdn028,g_pmdn.pmdn029,g_pmdn.pmdn003
            SELECT imaf157
              INTO g_pmdn.pmdn003
              FROM imaf_t
             WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdn.pmdn001  
         END IF
         
         #150819-00010 by whitney add start
         LET g_pmdn028_t = g_pmdn.pmdn028 #160801-00004#1
         IF cl_null(g_pmdn.pmdn028) THEN
            #CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076') RETURNING g_pmdn.pmdn028  #161205-00025#2
            LET g_pmdn.pmdn028 = l_mfg_0076  #161205-00025#2
         END IF
         #150819-00010 by whitney add end
         
         #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
         #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
         LET g_pmdn.pmdn027 = ''
         SELECT pmao004 INTO g_pmdn.pmdn027 FROM pmao_t 
          WHERE pmaoent = g_enterprise AND pmao001 = l_pmdl004 AND pmao002 = g_pmdn.pmdn001 
            AND pmao003 = g_pmdn.pmdn002 AND pmao007 = 'Y'
            AND pmao000 = '1'    #161221-00064#5 add
         IF cl_null(g_pmdn.pmdn027) THEN
            SELECT pmao004 INTO g_pmdn.pmdn027 FROM pmao_t 
             WHERE pmaoent = g_enterprise AND pmao001 = l_pmdl004 AND pmao002 = g_pmdn.pmdn001 
               AND pmao000 = '1'    #161221-00064#5 add
               AND pmao003 = g_pmdn.pmdn002 AND rownum = 1
         END IF 
           
         #當是VMI採購單時庫存管理特徵固定預設供應商編號，且不可以修改 
         IF l_pmdl005 = '3' THEN
            LET g_pmdn.pmdn053 = l_pmdl004
         END IF

         #整體參數未使用採購計價單位,則賦值當前的採購單位和數量
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
            LET g_pmdn.pmdn010 = g_pmdn.pmdn006
            LET g_pmdn.pmdn011 = g_pmdn.pmdn007
         END IF
           
         LET g_pmdn.pmdn052 = ''
         #161205-00025#2---s
         #LET l_sql = " SELECT qcap006 FROM qcap_t ",
         #            " WHERE qcapent = '",g_enterprise,"' ",
         #            "  AND qcapsite = '",g_site,"' ",
         #            "  AND qcap001 = '",g_pmdn.pmdn001,"' ",
         #            "  AND qcap002 = '",l_pmdl004,"' "
         #            
         #IF g_pmdn.pmdn002 IS NOT NULL THEN
         #   LET l_sql = l_sql ," AND (qcap005 = '",g_pmdn.pmdn002,"' OR qcap005 = 'ALL' )"
         #END IF
         #IF (NOT cl_null(g_pmdn.pmdn004)) AND (NOT cl_null(g_pmdn.pmdn005)) THEN
         #   LET l_sql = l_sql ," AND ( qcap003 = '",g_pmdn.pmdn004,"' OR qcap003 = 'ALL' ) AND qcap004 = '",g_pmdn.pmdn005,"' "
         #END IF
         #  
         #PREPARE get_qcap FROM l_sql
         #EXECUTE get_qcap INTO g_pmdn.pmdn052 
         IF cl_null(g_pmdn.pmdn002) THEN
            LET g_pmdn.pmdn002 = ' '
         END IF
         LET l_pmdn004 = g_pmdn.pmdn004
         LET l_pmdn005 = g_pmdn.pmdn005
         IF cl_null(l_pmdn004) THEN
            LET l_pmdn004 = ' '
         END IF
         IF cl_null(l_pmdn005) THEN
            LET l_pmdn005 = ' '
         END IF
         EXECUTE get_qcap USING g_pmdn.pmdn001,g_pmdn.pmdn002,l_pmdn004,l_pmdn005 INTO g_pmdn.pmdn052 
         #161205-00025#2---e
         
         FREE get_qcap
      
         IF cl_null(g_pmdn.pmdn052) THEN
            #若沒有維護aqci050,再從aqci040中帶值
            SELECT imae114 INTO g_pmdn.pmdn052 FROM imae_t 
             WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_pmdn.pmdn001
                  
         END IF
      
         IF cl_null(g_pmdn.pmdn052) THEN
            LET g_pmdn.pmdn052 = 'N'
         END IF
         
         #161205-00025#2--s
         #LET l_pmdl017 = ''
         #LET l_pmdl009 = ''
         #LET l_pmdl010 = ''
         #LET l_pmdl020 = ''
         #LET l_pmdl023 = ''
         #LET l_pmdldocdt = ''
         #LET l_pmdl054 = ''
         #SELECT pmdl017,pmdl009,pmdl010,pmdl023,pmdldocdt,pmdl054 
         #  INTO l_pmdl017,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdldocdt,l_pmdl054
         #  FROM pmdl_t 
         # WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
         #161205-00025#2--e
         
         IF g_argv[1] = '1' THEN   #委外
            LET l_type = '2'    #取價時類型 ，2.委外
         ELSE
            LET l_type = '1'    #取價時類型 ，1.一般
         END IF  
         #取出價格
         IF cl_null(g_pmdn.pmdn010) OR cl_null(g_pmdn.pmdn011) THEN
            LET g_pmdn.pmdn010 = g_pmdn.pmdn006
            LET g_pmdn.pmdn011 = g_pmdn.pmdn007
         END IF
         CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,g_pmdn.pmdn001,g_pmdn.pmdn002,l_pmdl015,
                                  g_pmdn.pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_pmdldocno,
                                  l_pmdldocdt,g_pmdn.pmdn010,g_pmdn.pmdn011,g_site,l_pmdl054,l_type,g_pmdn.pmdn004,g_pmdn.pmdn005)
              RETURNING g_pmdn.pmdn040,g_pmdn.pmdn043,g_pmdn.pmdn041,g_pmdn.pmdn042
            
         LET g_pmdn.pmdn015 = g_pmdn.pmdn043
         LET g_pmdn.pmdn044 = 0
    
         #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
         CALL s_apmt500_get_amount(g_pmdn.pmdndocno,g_pmdn.pmdnseq,l_pmdl015,g_pmdn.pmdn011,g_pmdn.pmdn015,g_pmdn.pmdn016)
              RETURNING g_pmdn.pmdn046,g_pmdn.pmdn048,g_pmdn.pmdn047
          
         #新增採購單身明細
         INSERT INTO pmdn_t(pmdnent,pmdnsite,pmdndocno,pmdnseq,pmdn001,pmdn002,pmdn003,pmdn006,pmdn007,
                            pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,
                            pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,
                            pmdn027,pmdn028,pmdn029,pmdn031,pmdn032,pmdn033,pmdn035,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                            pmdn046,pmdn047,pmdn048,pmdnunit,pmdnorga,pmdn052,pmdn053,pmdn050,
                            pmdn054,pmdn055,pmdn056,pmdn057, 
                            pmdn058,     #ming 20151225 add 
                            pmdn036,pmdn037,pmdn038)  #add by lixiang 2015/10/15
           VALUES (g_enterprise,g_pmdn.pmdnsite,g_pmdn.pmdndocno,g_pmdn.pmdnseq,g_pmdn.pmdn001,g_pmdn.pmdn002,
                   g_pmdn.pmdn003,g_pmdn.pmdn006,g_pmdn.pmdn007,g_pmdn.pmdn008,g_pmdn.pmdn009,
                   g_pmdn.pmdn010,g_pmdn.pmdn011,g_pmdn.pmdn012,g_pmdn.pmdn013,g_pmdn.pmdn014,
                   g_pmdn.pmdn015,g_pmdn.pmdn016,g_pmdn.pmdn017,g_pmdn.pmdn019,g_pmdn.pmdn020,
                   g_pmdn.pmdn021,g_pmdn.pmdn022,g_pmdn.pmdn023,g_pmdn.pmdn024,g_pmdn.pmdn025,
                   g_pmdn.pmdn026,g_pmdn.pmdn027,g_pmdn.pmdn028,g_pmdn.pmdn029,g_pmdn.pmdn031,
                   g_pmdn.pmdn032,g_pmdn.pmdn033,g_pmdn.pmdn035,g_pmdn.pmdn040,g_pmdn.pmdn041,g_pmdn.pmdn042,
                   g_pmdn.pmdn043,g_pmdn.pmdn044,g_pmdn.pmdn045,
                   g_pmdn.pmdn046,g_pmdn.pmdn047,g_pmdn.pmdn048,g_pmdn.pmdnunit,g_pmdn.pmdnorga,
                   g_pmdn.pmdn052,g_pmdn.pmdn053,g_pmdn.pmdn050,
                   0,0,0,0, 
                   g_pmdn.pmdn058,     #ming 20151225 add 
                   g_pmdn.pmdn036,g_pmdn.pmdn037,g_pmdn.pmdn038)   #add by lixiang 2015/10/15
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdn_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            LET r_success = FALSE                 
            #RETURN r_success
         END IF

         #新增關聯單身明細
         IF NOT apmt500_01_ins_pmdp(l_pmdbdocno,l_pmdbseq,l_pmdb030,g_pmdn.pmdn050) THEN  #add by lixiang 
            LET r_success = FALSE                 
            #RETURN r_success
         END IF
           
         #更新請購單中的已轉採購量
         IF NOT s_apmt500_upd_pmdb049(g_pmdn.pmdndocno,g_pmdn.pmdnseq,'1') THEN
            LET r_success = FALSE                 
            #RETURN r_success
         END IF
           
         #新增交期匯總資料pmdq_t
         IF g_pmdn.pmdn024 = "Y" THEN  #多交期
            IF NOT apmt500_01_ins_pmdq_1() THEN
               LET r_success = FALSE                 
              # RETURN r_success
            END IF
         ELSE
            IF NOT apmt500_01_ins_pmdq_2() THEN  #未勾選多交期，新增pmdq的資料
               LET r_success = FALSE                 
               #RETURN r_success
            END IF
         END IF
           
         #新增交期明細資料
         IF NOT s_apmt500_gen_pmdo(g_pmdldocno,g_pmdn.pmdnseq) THEN
            LET r_success = FALSE                 
            #RETURN r_success
         END IF
         
         #161031-00025#5 add-S
         #有來源時，同原單身備註，依單別參數帶入來源單據長備註
         IF l_code_d_bas_0098 = 'Y' THEN
            FOREACH pmdp_cs USING g_pmdldocno,g_pmdn.pmdnseq INTO l_pmdbdocno,l_pmdbseq
               CALL s_aooi360_sel('7','apmt400',l_pmdbdocno,l_pmdbseq,'','','','','','','','1') RETURNING l_success,l_ooff013
               IF NOT cl_null(l_ooff013) THEN
                  CALL s_aooi360_gen('7',g_prog,g_pmdldocno,g_pmdn.pmdnseq,'','','','','','','','1',l_ooff013) RETURNING l_success
               END IF
            END FOREACH
         END IF
         #161031-00025#5 add-E
           
          LET l_pmdbdocno = ''
          LET l_pmdbseq = ''
        
      END FOREACH
   ELSE 
      #ming 20151113 add -----(S)  
      LET l_sql = "SELECT pmdbdocno,pmdbseq,pmdp001,pmdp002,pmdp022,pmdp023,pmdn010,pmdn011,pmdb030,pmdb006,pmdb006_1, ",
                  "       pmdn050, ", 
                  "       pmdn058, ",      #ming 20151225 add 
                  "       pmdn028,pmdn029, ",  #150819-00010 by whitney add
                  "       pmdn036,pmdn037,pmdn038 ",
                  "  FROM apmt500_01_tmp2 ",
                  " ORDER BY pmdbdocno,pmdbseq "
      PREPARE apmt500_01_tmp2_prep FROM l_sql
      DECLARE apmt500_01_tmp2_curs CURSOR FOR apmt500_01_tmp2_prep

      FOREACH apmt500_01_tmp2_curs INTO l_pmdbdocno,l_pmdbseq,g_pmdn.pmdn001,g_pmdn.pmdn002,
                                        g_pmdn.pmdn006,g_pmdn.pmdn007,g_pmdn.pmdn010,
                                        g_pmdn.pmdn011,l_pmdb030,l_pmdb006,l_pmdb006_1,
                                        g_pmdn.pmdn050, 
                                        g_pmdn.pmdn058,    #ming 20151225 add 
                                        g_pmdn.pmdn028,g_pmdn.pmdn029,  #150819-00010 by whitney add
                                        g_pmdn.pmdn036,g_pmdn.pmdn037,g_pmdn.pmdn038
         ##採購單有關聯單據時，檢查採購量,單位批量，最小採購量，請采容差率
         CALL apmt500_01_pmdn007_chk(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn007,l_pmdb006,l_pmdb006_1)
              RETURNING l_success,l_pmdn007
         IF NOT l_success THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
         #若數量有改變，則重新計算計價數量
         IF l_pmdn007<> g_pmdn.pmdn007 THEN
            IF (NOT cl_null(g_pmdn.pmdn010)) AND (NOT cl_null(g_pmdn.pmdn006)) THEN  #體參數使用採購計價單位
               CALL s_aooi250_convert_qty(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn010,l_pmdn007)
                    RETURNING l_success,g_pmdn.pmdn011
               #數量取位
               CALL s_aooi250_take_decimals(g_pmdn.pmdn010,g_pmdn.pmdn011)
                    RETURNING l_success,g_pmdn.pmdn011
            END IF
            LET g_pmdn.pmdn007 = l_pmdn007 
         END IF

         LET g_pmdn.pmdnsite = g_site
         LET g_pmdn.pmdndocno = g_pmdldocno

         #項次加1
         SELECT MAX(pmdnseq)+1 INTO g_pmdn.pmdnseq
           FROM pmdn_t
          WHERE pmdnent = g_enterprise
            AND pmdndocno = g_pmdldocno
         IF cl_null(g_pmdn.pmdnseq) OR g_pmdn.pmdnseq = 0 THEN
            LET g_pmdn.pmdnseq = 1
         END IF

         #計算交貨、到廠、到庫日期
         #採構匯總策略選擇"1:不同交期匯總取價"時，則取匯總資料中需求日期最早的那一筆，
         #若採構匯總策略選擇"2:不同交期拆解"，則等於匯總的需求日期

         LET g_pmdn.pmdn014 = l_pmdb030   #到庫日期

         #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
         #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
         CALL apmt500_01_date_count(g_pmdn.pmdn014) RETURNING g_pmdn.pmdn013,g_pmdn.pmdn012

         LET g_pmdn.pmdn020 = "1"
         CALL apmt500_01_pmdn014_to_pmdn020(g_pmdn.pmdn014) RETURNING g_pmdn.pmdn020


         #採購欄位賦初始值
         LET g_pmdn.pmdn019 = "1"  #料件子特性 
         #[C:備品率] = [T:料件進銷存檔].[C:採購備品率]  imaf165
         #[C:參考單位] = [T:料件進銷存檔][C:參考單位]   imaf015
         #若[T:料件進銷存檔].[C:接單拆解方式(採購)]的值為'1:自動CKD'或是'2:自動SKD'時，imaf158
         #則[C:子件特性]的值預設'2:CKD'或是'3:SKD'
         LET g_pmdn.pmdn008 = ''
         LET g_pmdn.pmdn009 = 0
         LET g_pmdn.pmdn033 = ''
         LET l_imaf158 = ''
         SELECT imaf158,imaf165,imaf015
           INTO l_imaf158,g_pmdn.pmdn033,g_pmdn.pmdn008
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_pmdn.pmdn001

         LET l_rate = 1
         IF NOT cl_null(g_pmdn.pmdn008) THEN
            CALL s_aooi250_convert_qty(g_pmdn.pmdn001,g_pmdn.pmdn006,g_pmdn.pmdn008,g_pmdn.pmdn007)
                 RETURNING l_success,g_pmdn.pmdn009
         END IF

         IF l_imaf158 = '1' THEN
            LET g_pmdn.pmdn019 = '2'
         END IF
         IF l_imaf158 = '2' THEN
            LET g_pmdn.pmdn019 = '3'
         END IF

         LET g_pmdn.pmdn021 = "N"
         LET g_pmdn.pmdn022 = "Y" 
         LET g_pmdn.pmdn024 = "N"  #多交期否

         #如果單別參數設定不保留備註時，非費用料的就要清空 
         LET l_imaa004 = ''
         SELECT imaa004 INTO l_imaa004
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = g_pmdn.pmdn001

         IF l_imaa004 != 'E' THEN
            IF l_code_d_bas_0098 != 'Y' OR cl_null(l_code_d_bas_0098) THEN
               LET g_pmdn.pmdn050 = ''
            END IF
         END IF

         LET g_pmdn.pmdnunit = g_site
         LET g_pmdn.pmdnorga = g_site

         #161205-00025#2--s
         #LET l_pmdl011 = ''
         #LET l_pmdl012 = ''
         #LET l_pmdl022 = ''
         #LET l_pmdl020 = ''
         #LET l_pmdl025 = ''
         #LET l_pmdl026 = ''
         #LET l_pmdl015 = ''
         #LET l_pmdl024 = ''
         #LET l_pmdl005 = ''
         #SELECT pmdl004,pmdl005,pmdl011,pmdl012,pmdl022,pmdl020,pmdl025,pmdl026,pmdl015,pmdl024
         #  INTO l_pmdl004,l_pmdl005,l_pmdl011,l_pmdl012,l_pmdl022,l_pmdl020,l_pmdl025,l_pmdl026,l_pmdl015,l_pmdl024 
         #  FROM pmdl_t
         # WHERE pmdlent   = g_enterprise
         #   AND pmdldocno = g_pmdldocno
         #161205-00025#2--e
         
         LET g_pmdn.pmdn016 = l_pmdl011
         LET g_pmdn.pmdn017 = l_pmdl012
         
         #161205-00025#2--s
         ##取得稅別類型
         #CALL s_tax_chk(g_site,l_pmdl011)
         #     RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
         #161205-00025#2--e
         IF l_oodb011 = '2' AND NOT cl_null(g_pmdn.pmdn001) AND NOT cl_null(l_pmdl024) THEN
            #依料件設定
            CALL s_tax_chktype(g_site,l_pmdl004,g_pmdn.pmdn001,'2',l_pmdl024)
                 RETURNING l_success,g_pmdn.pmdn016,g_pmdn.pmdn017
            IF NOT l_success THEN
               #稅別檢查失敗，將稅別、稅率清空
               LET g_pmdn.pmdn016 = ''
               LET g_pmdn.pmdn017 = ''
            END IF
         END IF
         IF cl_null(g_pmdn.pmdn016) OR cl_null(g_pmdn.pmdn017) THEN
            #依正常稅率
            LET g_pmdn.pmdn016 = l_pmdl011
            LET g_pmdn.pmdn017 = l_pmdl012
         END IF

         LET g_pmdn.pmdn023 = l_pmdl022
         LET g_pmdn.pmdn025 = l_pmdl025
         LET g_pmdn.pmdn026 = l_pmdl026
         LET g_pmdn.pmdn031 = l_pmdl020
         LET g_pmdn.pmdn032 = "1" 
         LET g_pmdn.pmdn035 = "1"
         LET g_pmdn.pmdn040 = "1"
         LET g_pmdn.pmdn045 = "1"

#150819-00010 by whitney mark start
#         LET g_pmdn.pmdn028 = ''
#         LET g_pmdn.pmdn029 = ''
#150819-00010 by whitney mark end
         #150819-00010 by whitney add start
         IF cl_null(g_pmdn.pmdn028) THEN
            CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-MFG-0076') RETURNING g_pmdn.pmdn028
         END IF
         #150819-00010 by whitney add end
         LET g_pmdn.pmdn003 = ''
         LET g_pmdn.pmdn033 = ''

         #161205-00025#2--s
         ##先判斷這個供應商是否有設多個當前採購控制組範圍內的供應商預設條件，則開窗，讓user 選擇帶哪一個控制組的資料
         #LET l_controlno = ''
         #CALL s_control_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
         #161205-00025#2--e
         
         IF NOT cl_null(l_controlno) THEN
            #161205-00025#2--s
            #LET l_pmdl004 = ''
            #SELECT pmdl004 INTO l_pmdl004 FROM pmdl_t
            # WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
            #161205-00025#2--e
            SELECT COUNT(*) INTO l_n FROM pmap_t
             WHERE pmapent  = g_enterprise
               AND pmapsite = g_site
               AND pmap001  = l_pmdl004
               AND pmap002  = l_controlno
               AND pmap003  = g_pmdn.pmdn001
               AND pmap004  = g_pmdn.pmdn002
            #若採購料件有設置'供應商控制組料件預設條件'(apmi121)時，則需將設置的預設條件值預設到採購單對應欄位
            IF l_n > 0 THEN
               SELECT pmap009,pmap012,pmap014,pmap005
                 INTO g_pmdn.pmdnunit,g_pmdn.pmdn025,g_pmdn.pmdn031,g_pmdn.pmdn003 
                 FROM pmdp_t
                WHERE pmdpent = g_enterprise
                  AND pmapsite = g_site
                  AND pmap001 = l_pmdl004
                  AND pmap002 = l_controlno
                  AND pmap003 = g_pmdn.pmdn001
                  AND pmap004 = g_pmdn.pmdn002

            END IF
         END IF

         IF cl_null(l_controlno) OR l_n = 0 THEN
            #沒有設置'供應商控制組料件預設條件'(apmi121)才改抓料件進銷存檔預設的條件
            SELECT imaf157
              INTO g_pmdn.pmdn003
              FROM imaf_t
             WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdn.pmdn001
         END IF

         #若採購料件有設置'交易對象對應料號'(apmi070)有供應商料號時，需將對應的料號抓出顯示在
         #[C:供應商料號]欄位上，若有設置多筆對應料號時以有勾選主要對應料那一筆為預設值
         LET g_pmdn.pmdn027 = ''
         SELECT pmao004 INTO g_pmdn.pmdn027 FROM pmao_t
          WHERE pmaoent = g_enterprise
            AND pmao001 = l_pmdl004
            AND pmao002 = g_pmdn.pmdn001
            AND pmao003 = g_pmdn.pmdn002 
            AND pmao000 = '1'    #161221-00064#5 add
            AND pmao007 = 'Y'
         IF cl_null(g_pmdn.pmdn027) THEN
            SELECT pmao004 INTO g_pmdn.pmdn027
              FROM pmao_t
             WHERE pmaoent = g_enterprise
               AND pmao001 = l_pmdl004
               AND pmao002 = g_pmdn.pmdn001
               AND pmao003 = g_pmdn.pmdn002
               AND pmao000 = '1'    #161221-00064#5 add
               AND rownum = 1
         END IF

         #當是VMI採購單時庫存管理特徵固定預設供應商編號，且不可以修改 
         IF l_pmdl005 = '3' THEN
            LET g_pmdn.pmdn053 = l_pmdl004
         END IF

         #整體參數未使用採購計價單位,則賦值當前的採購單位和數量
         IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "N" THEN
            LET g_pmdn.pmdn010 = g_pmdn.pmdn006
            LET g_pmdn.pmdn011 = g_pmdn.pmdn007
         END IF

         LET g_pmdn.pmdn052 = ''
         
         #161205-00025#2--s
         #LET l_sql = " SELECT qcap006 FROM qcap_t ",
         #            " WHERE qcapent = '",g_enterprise,"' ",
         #            "  AND qcapsite = '",g_site,"' ",
         #            "  AND qcap001 = '",g_pmdn.pmdn001,"' ", 
         #            "  AND qcap002 = '",l_pmdl004,"' "
         #
         #IF g_pmdn.pmdn002 IS NOT NULL THEN
         #   LET l_sql = l_sql ," AND (qcap005 = '",g_pmdn.pmdn002,"' OR qcap005 = 'ALL' )"
         #END IF
         #IF (NOT cl_null(g_pmdn.pmdn004)) AND (NOT cl_null(g_pmdn.pmdn005)) THEN
         #   LET l_sql = l_sql ," AND ( qcap003 = '",g_pmdn.pmdn004,"' OR qcap003 = 'ALL' ) AND qcap004 = '",g_pmdn.pmdn005,"' "
         #END IF
         #
         #PREPARE get_qcap2 FROM l_sql
         #EXECUTE get_qcap2 INTO g_pmdn.pmdn052
         #FREE get_qcap2
         IF cl_null(g_pmdn.pmdn002) THEN
            LET g_pmdn.pmdn002 = ' '
         END IF
         LET l_pmdn004 = g_pmdn.pmdn004
         LET l_pmdn005 = g_pmdn.pmdn005
         IF cl_null(l_pmdn004) THEN
            LET l_pmdn004 = ' '
         END IF
         IF cl_null(l_pmdn005) THEN
            LET l_pmdn005 = ' '
         END IF
         EXECUTE get_qcap USING g_pmdn.pmdn001,g_pmdn.pmdn002,l_pmdn004,l_pmdn005 INTO g_pmdn.pmdn052 
         FREE get_qcap
         #161205-00025#2--e
         

         IF cl_null(g_pmdn.pmdn052) THEN
            #若沒有維護aqci050,再從aqci040中帶值
            SELECT imae114 INTO g_pmdn.pmdn052 FROM imae_t
             WHERE imaeent = g_enterprise AND imaesite = g_site AND imae001 = g_pmdn.pmdn001

         END IF

         IF cl_null(g_pmdn.pmdn052) THEN
            LET g_pmdn.pmdn052 = 'N'
         END IF

         #161205-00025#2--s
         #LET l_pmdl017 = ''
         #LET l_pmdl009 = ''
         #LET l_pmdl010 = ''
         #LET l_pmdl020 = ''
         #LET l_pmdl023 = ''
         #LET l_pmdldocdt = '' 
         #LET l_pmdl054 = ''
         #SELECT pmdl017,pmdl009,pmdl010,pmdl023,pmdldocdt,pmdl054
         #  INTO l_pmdl017,l_pmdl009,l_pmdl010,l_pmdl023,l_pmdldocdt,l_pmdl054
         #  FROM pmdl_t
         # WHERE pmdlent = g_enterprise
         #   AND pmdldocno = g_pmdldocno
         #161205-00025#2--e
         
         IF g_argv[1] = '1' THEN   #委外
            LET l_type = '2'    #取價時類型 ，2.委外
         ELSE
            LET l_type = '1'    #取價時類型 ，1.一般
         END IF
         #取出價格
         IF cl_null(g_pmdn.pmdn010) OR cl_null(g_pmdn.pmdn011) THEN
            LET g_pmdn.pmdn010 = g_pmdn.pmdn006
            LET g_pmdn.pmdn011 = g_pmdn.pmdn007
         END IF
         CALL s_apmt500_get_price(l_pmdl017,l_pmdl004,g_pmdn.pmdn001,g_pmdn.pmdn002,l_pmdl015,
                                  g_pmdn.pmdn016,l_pmdl009,l_pmdl010,l_pmdl023,g_pmdldocno,
                                  l_pmdldocdt,g_pmdn.pmdn010,g_pmdn.pmdn011,g_site,l_pmdl054,l_type,g_pmdn.pmdn004,g_pmdn.pmdn005)
              RETURNING g_pmdn.pmdn040,g_pmdn.pmdn043,g_pmdn.pmdn041,g_pmdn.pmdn042

         LET g_pmdn.pmdn015 = g_pmdn.pmdn043
         LET g_pmdn.pmdn044 = 0

         #重新計算[C:未稅金額]、[C:含稅金額]、[稅額]
         CALL s_apmt500_get_amount(g_pmdn.pmdndocno,g_pmdn.pmdnseq,l_pmdl015,g_pmdn.pmdn011,g_pmdn.pmdn015,g_pmdn.pmdn016)
              RETURNING g_pmdn.pmdn046,g_pmdn.pmdn048,g_pmdn.pmdn047

         #新增採購單身明細 
         INSERT INTO pmdn_t(pmdnent,pmdnsite,pmdndocno,pmdnseq,pmdn001,pmdn002,pmdn003,pmdn006,pmdn007,
                            pmdn008,pmdn009,pmdn010,pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,pmdn016,
                            pmdn017,pmdn019,pmdn020,pmdn021,pmdn022,pmdn023,pmdn024,pmdn025,pmdn026,
                            pmdn027,pmdn028,pmdn029,pmdn031,pmdn032,pmdn033,pmdn035,pmdn040,pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                            pmdn046,pmdn047,pmdn048,pmdnunit,pmdnorga,pmdn052,pmdn053,pmdn050,
                            pmdn054,pmdn055,pmdn056,pmdn057, 
                            pmdn058,     #ming 20151225 add 
                            pmdn036,pmdn037,pmdn038)
           VALUES (g_enterprise,g_pmdn.pmdnsite,g_pmdn.pmdndocno,g_pmdn.pmdnseq,g_pmdn.pmdn001,g_pmdn.pmdn002,
                   g_pmdn.pmdn003,g_pmdn.pmdn006,g_pmdn.pmdn007,g_pmdn.pmdn008,g_pmdn.pmdn009,
                   g_pmdn.pmdn010,g_pmdn.pmdn011,g_pmdn.pmdn012,g_pmdn.pmdn013,g_pmdn.pmdn014,
                   g_pmdn.pmdn015,g_pmdn.pmdn016,g_pmdn.pmdn017,g_pmdn.pmdn019,g_pmdn.pmdn020,
                   g_pmdn.pmdn021,g_pmdn.pmdn022,g_pmdn.pmdn023,g_pmdn.pmdn024,g_pmdn.pmdn025,
                   g_pmdn.pmdn026,g_pmdn.pmdn027,g_pmdn.pmdn028,g_pmdn.pmdn029,g_pmdn.pmdn031,
                   g_pmdn.pmdn032,g_pmdn.pmdn033,g_pmdn.pmdn035,g_pmdn.pmdn040,g_pmdn.pmdn041,g_pmdn.pmdn042,
                   g_pmdn.pmdn043,g_pmdn.pmdn044,g_pmdn.pmdn045,
                   g_pmdn.pmdn046,g_pmdn.pmdn047,g_pmdn.pmdn048,g_pmdn.pmdnunit,g_pmdn.pmdnorga,
                   g_pmdn.pmdn052,g_pmdn.pmdn053,g_pmdn.pmdn050,
                   0,0,0,0,
                   g_pmdn.pmdn058,     #ming 20151225 add 
                   g_pmdn.pmdn036,g_pmdn.pmdn037,g_pmdn.pmdn038)
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdn_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
         END IF

         #新增關聯單身明細 
         IF NOT apmt500_01_ins_pmdp(l_pmdbdocno,l_pmdbseq,l_pmdb030,g_pmdn.pmdn050) THEN
            LET r_success = FALSE
            #RETURN r_success
         END IF

         #更新請購單中的已轉採購量
         IF NOT s_apmt500_upd_pmdb049(g_pmdn.pmdndocno,g_pmdn.pmdnseq,'1') THEN
            LET r_success = FALSE
         END IF

         #新增交期匯總資料pmdq_t
         IF g_pmdn.pmdn024 = "Y" THEN  #多交期
            IF NOT apmt500_01_ins_pmdq_1() THEN
               LET r_success = FALSE
            END IF
         ELSE
            IF NOT apmt500_01_ins_pmdq_2() THEN  #未勾選多交期，新增pmdq的資料
               LET r_success = FALSE
            END IF
         END IF

         #新增交期明細資料
         IF NOT s_apmt500_gen_pmdo(g_pmdldocno,g_pmdn.pmdnseq) THEN
            LET r_success = FALSE
         END IF
         
         #161031-00025#5 add-S
         #有來源時，同原單身備註，依單別參數帶入來源單據長備註
         IF l_code_d_bas_0098 = 'Y' THEN
            CALL s_aooi360_sel('7','apmt400',l_pmdbdocno,l_pmdbseq,'','','','','','','','1') RETURNING l_success,l_ooff013
            IF NOT cl_null(l_ooff013) THEN
               CALL s_aooi360_gen('7',g_prog,g_pmdldocno,g_pmdn.pmdnseq,'','','','','','','','1',l_ooff013) RETURNING l_success
            END IF
         END IF
         #161031-00025#5 add-E

          LET l_pmdbdocno = ''
          LET l_pmdbseq = ''

      END FOREACH 
      #ming 20151113 add -----(E) 
   END IF 
        
   CALL cl_err_collect_show()
        
   #重新計算整單的未稅、含稅總金額
   CALL s_tax_recount_tmp()
   CALL s_tax_recount(g_pmdldocno)
        RETURNING l_pmdl040,l_pmdl042,l_pmdl041,l_xrcd113,l_xrcd114,l_xrcd115
   UPDATE pmdl_t SET pmdl040 = l_pmdl040,
                     pmdl042 = l_pmdl042,
                     pmdl041 = l_pmdl041
    WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno

   RETURN r_success   
      
END FUNCTION
#产生采购底稿
PRIVATE FUNCTION apmt500_01_gen_pmdn_draft()
DEFINE l_n    LIKE type_t.num5

        LET g_rec_b = g_pmdb_d.getLength()
        IF g_rec_b = 0 THEN
           RETURN
        END IF
        
        LET l_n = 0
        SELECT COUNT(*) INTO l_n FROM apmt500_01_tmp WHERE pmda004 = 'Y'
        IF l_n = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = 'sub-00329'
           LET g_errparam.extend = ''
           LET g_errparam.popup = TRUE
           CALL cl_err()

           RETURN
        END IF
        
        CALL apmt500_01_insert_pmdn_draft()
        
        CALL apmt500_01_b2_fill()
        LET g_rec_b2 = g_pmdb2_d.getLength()
        
END FUNCTION

PRIVATE FUNCTION apmt500_01_pmda002_ref(p_pmda002)
DEFINE p_pmda002      LIKE pmda_t.pmda002
DEFINE r_oofa011      LIKE oofa_t.oofa011

       LET r_oofa011 = ''
       CALL s_desc_get_person_desc(p_pmda002) RETURNING r_oofa011
       RETURN r_oofa011

END FUNCTION

PRIVATE FUNCTION apmt500_01_pmdb004_ref(p_pmdb004)
DEFINE p_pmdb004     LIKE pmdb_t.pmdb004
DEFINE r_imaal003    LIKE imaal_t.imaal003
DEFINE r_imaal004    LIKE imaal_t.imaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmdb004
       CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_imaal003 = '', g_rtn_fields[1] , ''
       LET r_imaal004 = '', g_rtn_fields[2] , ''
       RETURN r_imaal003,r_imaal004
       
END FUNCTION

PRIVATE FUNCTION apmt500_01_pmda003_ref(p_pmda003)
DEFINE p_pmda003      LIKE pmda_t.pmda003
DEFINE r_ooefl003     LIKE ooefl_t.ooefl003

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmda003
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_ooefl003 = '', g_rtn_fields[1] , ''
       RETURN r_ooefl003

END FUNCTION
#新增請購明細單身臨時表
PRIVATE FUNCTION apmt500_01_insert_tmp(p_pmdadocno,p_pmdbseq)
DEFINE p_pmdadocno    LIKE pmda_t.pmdadocno
DEFINE p_pmdbseq      LIKE pmdb_t.pmdbseq
DEFINE l_sql          STRING
DEFINE l_pmdbdocno    LIKE pmdb_t.pmdbdocno
DEFINE l_pmdbseq      LIKE pmdb_t.pmdbseq
DEFINE l_pmdn007      LIKE pmdn_t.pmdn007
DEFINE l_pmdb006      LIKE pmdb_t.pmdb006
       
       #LET l_sql = " INSERT INTO apmt500_01_tmp (SELECT 'N',pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,(pmdb006-NVL(pmdb049,0)),pmdb030,pmdb033,pmda002,pmda003 ",
       LET l_sql = " INSERT INTO apmt500_01_tmp(pmda004,pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,pmdb006_1,pmdb030,pmdb033,pmdb050,pmda002,pmda003) ",   #161222-00027#1 add pmdb050
                   " (SELECT 'N',pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,(pmdb006-(CASE WHEN pmdb049 IS NULL THEN 0 ELSE pmdb049 END)),pmdb030,pmdb033,pmdb050,pmda002,pmda003 ",  #161222-00027#1 add pmdb050
                   " FROM pmdb_t,pmda_t ",
                   " WHERE pmdbent = pmdaent AND pmdbdocno = pmdadocno ",
                   "   AND pmdb032 = '1' ",    #行狀態 未結案的
                   "   AND pmdbent = '",g_enterprise,"' ",
                   "   AND pmdbdocno = '",p_pmdadocno,"' ",
                   "   AND pmdbseq = '",p_pmdbseq,"' ) " 
                   
                   
       PREPARE apmt500_01_tmp FROM l_sql
       EXECUTE apmt500_01_tmp
       #新增單據時，就會回寫已轉採購量，此部分要調整不可以大於請購量 - 轉採購量，不需要加判斷其他採購單據上的數量
       #DECLARE pmdb_cur CURSOR FOR
       #   SELECT pmdbdocno,pmdbseq,pmdb006_1 FROM apmt500_01_tmp WHERE pmdbdocno = p_pmdadocno
       #FOREACH pmdb_cur INTO l_pmdbdocno,l_pmdbseq,l_pmdb006 
       #   SELECT SUM(pmdp024) INTO l_pmdn007
       #     FROM pmdp_t,pmdl_t
       #    WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno
       #      AND pmdpent = g_enterprise AND pmdp003 = l_pmdbdocno AND pmdp004 = l_pmdbseq
       #      AND pmdlstus = 'N'
       #   IF cl_null(l_pmdn007) THEN
       #      LET l_pmdn007 = 0
       #   END IF
       #   IF l_pmdb006 > l_pmdn007 THEN
       #      UPDATE apmt500_01_tmp SET pmdb006_1 = pmdb006_1 - l_pmdn007
       #         WHERE pmdbdocno = l_pmdbdocno AND pmdbseq = l_pmdbseq
       #   ELSE
       #      DELETE FROM apmt500_01_tmp WHERE pmdbdocno = l_pmdbdocno AND pmdbseq = l_pmdbseq
       #   END IF
       #END FOREACH
       
END FUNCTION
#將資料插入到採購底稿臨時表中
PRIVATE FUNCTION apmt500_01_insert_pmdn_draft()
   DEFINE l_sql          STRING
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_pmdn         type_g_pmdb2_d
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_rate         LIKE inaj_t.inaj014
   DEFINE l_pmdb006_1    LIKE pmdb_t.pmdb006
   DEFINE l_pmdn050      LIKE pmdn_t.pmdn050
   DEFINE l_pmdn036      LIKE pmdn_t.pmdn036  #add by lixiang 2015/10/15
   DEFINE l_pmdn037      LIKE pmdn_t.pmdn037  #add by lixiang 2015/10/15
   DEFINE l_pmdn038      LIKE pmdn_t.pmdn038  #add by lixiang 2015/10/15
   #151225-00002#1 20151225 add by ming -----(S) 
   DEFINE l_code_d_bas_0098 LIKE type_t.chr80
   DEFINE l_slip            LIKE oobal_t.oobal002
   DEFINE l_imaa004         LIKE imaa_t.imaa004
   #151225-00002#1 20151225 add by ming -----(E) 
   #ming 20151225 add ----(S) 
   DEFINE l_pmdn058         LIKE pmdn_t.pmdn058 
   #ming 20151225 add ----(E) 
   DEFINE l_pmdn028         LIKE pmdn_t.pmdn028  #150819-00010 by whitney add
   DEFINE l_pmdn029         LIKE pmdn_t.pmdn029  #150819-00010 by whitney add
   DEFINE l_pmdn053         LIKE pmdn_t.pmdn053  #160801-00004#1
   DEFINE l_pmdb006_049     LIKE pmdb_t.pmdb006  #160531-00023#1 
   #151225-00002#1 20151225 add by ming -----(S) 
   DEFINE l_docno           LIKE pmdb_t.pmdbdocno #160531-00023#1   
   DEFINE l_seq             LIKE pmdb_t.pmdbseq   #160531-00023#1
   
   #取得單別 
   CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_slip

   #取得單別參數 
   CALL cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0098')
        RETURNING l_code_d_bas_0098
   #151225-00002#1 20151225 add by ming -----(E) 

   LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006_1,pmdb006,pmdb030,pmdb050", #161222-00027#1 add pmdb050
               " FROM apmt500_01_tmp ",
               "  WHERE pmda004 = 'Y' ",
               " ORDER BY pmdbdocno,pmdbseq "
                   
   PREPARE apmt500_01_tmp_pmdb_pb FROM l_sql
   DECLARE apmt500_01_tmp_pmdb_cs CURSOR FOR apmt500_01_tmp_pmdb_pb
   
   #160531-00023#1---s
   CALL s_transaction_begin()
   
   LET l_sql = "SELECT pmdbdocno,pmdbseq ",
               "  FROM pmdb_t ",
               " WHERE pmdbent   = '",g_enterprise,"' ",
               "   AND pmdbdocno = ? ",
               "   AND pmdbseq   = ? ",
               "   FOR UPDATE SKIP LOCKED "
   PREPARE apmt500_01_test_lock_pr FROM l_sql

   CALL cl_err_collect_init()
   #160531-00023#1---e
   
   FOREACH apmt500_01_tmp_pmdb_cs INTO l_pmdn.pmdbdocno,l_pmdn.pmdbseq,l_pmdn.pmdb004, 
                                       l_pmdn.pmdb005,l_pmdn.pmdb007,l_pmdn.pmdb006, 
                                       l_pmdb006_1,l_pmdn.pmdb030,l_pmdn.pmdb050       #161222-00027#1 add pmdb050
      LET l_n = 0
      SELECT COUNT(*) INTO l_n 
        FROM apmt500_01_tmp2 
       WHERE pmdbdocno = l_pmdn.pmdbdocno 
         AND pmdbseq   = l_pmdn.pmdbseq
      IF l_n > 0 THEN
         CONTINUE FOREACH
      END IF
      
      #160531-00023#1---s
      LET l_docno = ''
      LET l_seq = ''
      EXECUTE apmt500_01_test_lock_pr USING l_pmdn.pmdbdocno,l_pmdn.pmdbseq
                                   INTO l_docno,l_seq
      IF cl_null(l_docno) OR cl_null(l_seq) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'apm-01117'
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = l_pmdn.pmdbdocno
         LET g_errparam.replace[2] = l_pmdn.pmdbseq 
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      #160531-00023#1---e
      
      #add by lixiang
      #獲取請購單上的備註
      LET l_pmdn050 = ''
      LET l_pmdn028 = ''  #150819-00010 by whitney add
      LET l_pmdn029 = ''  #150819-00010 by whitney add
      LET l_pmdn053 = ''  #160801-00004#1
      #ming 20151225 modify -----(S) 
      #SELECT pmdb050,pmdb034,pmdb035,pmdb036 INTO l_pmdn050,l_pmdn036,l_pmdn037,l_pmdn038  #add by lixiang 2015/10/15 pmdb034,pmdb035,pmdb036
      #  FROM pmdb_t 
      # WHERE pmdbdocno = l_pmdn.pmdbdocno 
      #   AND pmdbseq   = l_pmdn.pmdbseq
      SELECT pmdb050,pmdb034,pmdb035,pmdb036,pmdb053
            ,pmdb038,pmdb039,  #150819-00010 by whitney add
            pmdb054,
            (pmdb006-pmdb049)    #160531-00023#1 
        INTO l_pmdn050,l_pmdn036,l_pmdn037,l_pmdn038,l_pmdn058  
            ,l_pmdn028,l_pmdn029,  #150819-00010 by whitney add
            l_pmdn053,   #160801-00004#1
            l_pmdb006_049  #160531-00023#1
        FROM pmdb_t 
       WHERE pmdbdocno = l_pmdn.pmdbdocno 
         AND pmdbseq   = l_pmdn.pmdbseq
         AND pmdbent   = g_enterprise   #160905-00007#11 Add
      #ming 20151225 modify -----(E) 
      
      
      LET l_pmdn.pmdp001 = l_pmdn.pmdb004   #採購料號
      LET l_pmdn.pmdp002 = l_pmdn.pmdb005   #採購產品特徵
      LET l_pmdn.pmdp022 = ''   #採購單位
      SELECT imaf143 INTO l_pmdn.pmdp022 
        FROM imaf_t 
       WHERE imafent  = g_enterprise 
         AND imafsite = g_site 
         AND imaf001  = l_pmdn.pmdb004
      
      #160531-00023#1---S
      IF l_pmdb006_049 < l_pmdn.pmdb006 THEN
         LET l_pmdn.pmdb006 = l_pmdb006_049
      END IF
      #160531-00023#1---E
      
      LET l_rate = 1
      IF NOT cl_null(l_pmdn.pmdp022) THEN
         #CALL s_aimi190_get_convert(l_pmdn.pmdb004,l_pmdn.pmdb007,l_pmdn.pmdp022) RETURNING l_success,l_rate
         #LET l_pmdn.pmdp023 = l_pmdn.pmdb006*l_rate
         CALL s_aooi250_convert_qty(l_pmdn.pmdb004,l_pmdn.pmdb007,l_pmdn.pmdp022,l_pmdn.pmdb006)
               RETURNING l_success,l_pmdn.pmdp023
      END IF
      
      LET l_pmdn.pmdn010 = ''   #計價單位
      SELECT imaf144 INTO l_pmdn.pmdn010 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = l_pmdn.pmdb004
      
      IF NOT cl_null(l_pmdn.pmdn010) THEN
         #CALL s_aimi190_get_convert(l_pmdn.pmdb004,l_pmdn.pmdp022,l_pmdn.pmdn010) RETURNING l_success,l_rate
         #LET l_pmdn.pmdn011 = l_pmdn.pmdp023*l_rate
         CALL s_aooi250_convert_qty(l_pmdn.pmdb004,l_pmdn.pmdp022,l_pmdn.pmdn010,l_pmdn.pmdp023)
               RETURNING l_success,l_pmdn.pmdn011
      ELSE
         LET l_pmdn.pmdn010 = l_pmdn.pmdp022
         LET l_pmdn.pmdn011 = l_pmdn.pmdp023
      END IF
      
      SELECT MAX(pmdp021)+1 INTO l_pmdn.pmdp021 FROM apmt500_01_tmp2 
         WHERE pmdp001 = l_pmdn.pmdp001 AND pmdp002 = l_pmdn.pmdp002 AND pmdp022 = l_pmdn.pmdp022 AND pmdn010 = l_pmdn.pmdn010
      IF cl_null(l_pmdn.pmdp021) OR l_pmdn.pmdp021 = 0 THEN
         LET l_pmdn.pmdp021 = 1
      END IF
      
      #151225-00002#1 20151225 add by ming -----(S) 
      #備註處理 
      #如果單別參數設定不保留備註時，非費用料的就要清空 
      LET l_imaa004 = ''
      SELECT imaa004 INTO l_imaa004
        FROM imaa_t
       WHERE imaaent = g_enterprise
         AND imaa001 = l_pmdn.pmdb004

      IF l_imaa004 != 'E' THEN
         IF l_code_d_bas_0098 != 'Y' OR cl_null(l_code_d_bas_0098) THEN
            LET l_pmdn050 = ''
         END IF
      END IF
      #151225-00002#1 20151225 add by ming -----(E)

      #161216-00032#1--s
      IF cl_null(l_pmdn.pmdp002) THEN
         LET l_pmdn.pmdp002 = ' '
      END IF
      IF cl_null(l_pmdn.pmdb005) THEN
         LET l_pmdn.pmdb005 = ' '
      END IF
      #161216-00032#1---e
      
      INSERT INTO apmt500_01_tmp2 (pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,pmdb006_1,pmdb030,pmdb050,pmdp021, #161222-00027#1 add pmdb050
                                  pmdp001,pmdp002,pmdp022,pmdp023,pmdn010,pmdn011,
                                  pmdn028,pmdn029,  #150819-00010 by whitney add
                                  pmdn053,    #160801-00004#1
                                  pmdn036,pmdn037,pmdn038,  #add by lixiang 2015/10/15
                                  pmdn050,pmdn058)  #add by lixiang #ming 20151225 add pmdn058 
        VALUES (l_pmdn.pmdbdocno,l_pmdn.pmdbseq,l_pmdn.pmdb004,l_pmdn.pmdb005,l_pmdn.pmdb007,l_pmdn.pmdb006,l_pmdb006_1,l_pmdn.pmdb030,l_pmdn.pmdb050, #161222-00027#1 add pmdb050
                l_pmdn.pmdp021,l_pmdn.pmdp001,l_pmdn.pmdp002,l_pmdn.pmdp022,l_pmdn.pmdp023,l_pmdn.pmdn010,l_pmdn.pmdn011,
                l_pmdn028,l_pmdn029,  #150819-00010 by whitney add
                l_pmdn053,   #160801-00004#1
                l_pmdn036,l_pmdn037,l_pmdn038,  #add by lixiang 2015/10/15
                l_pmdn050,l_pmdn058)  #add by lixiang #ming 20151225 add pmdn058 
   
   END FOREACH
   
   CALL cl_err_collect_show()   #160531-00023#1
   
       
END FUNCTION
#採購底稿單身填充
PRIVATE FUNCTION apmt500_01_b2_fill()
DEFINE l_sql          STRING
DEFINE l_success      LIKE type_t.num5

       CALL g_pmdb2_d.clear()
       LET l_ac2 = 1
       
       #161205-00025#2---s
       #LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,'','',pmdb005,pmdb007,pmdb006,pmdb030,pmdp021,pmdp001,'','',pmdp002,pmdp022,pmdp023,pmdn010,pmdn011",
       LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdb007,pmdb006,pmdb030,pmdb050,pmdp021,pmdp001,pmdp002,pmdp022,pmdp023,pmdn010,pmdn011,", #161222-00027#1 add pmdb050
                   "        t1.imaal003,t2.imaal004,t3.inaml004,t4.imaal003,t5.imaal004,t6.inaml004 ",
       #161205-00025#2---e
                   " FROM apmt500_01_tmp2 ",
       #161205-00025#1---s
                   "   LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=pmdb004 AND t1.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN imaal_t t2 ON t2.imaalent="||g_enterprise||" AND t2.imaal001=pmdb004 AND t2.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN inaml_t t3 ON t3.inamlent="||g_enterprise||" AND t3.inaml001=pmdb004 AND t3.inaml002=pmdb005 AND t3.inaml003='"||g_dlang||"' ",
                   "   LEFT JOIN imaal_t t4 ON t4.imaalent="||g_enterprise||" AND t4.imaal001=pmdp001 AND t4.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN imaal_t t5 ON t5.imaalent="||g_enterprise||" AND t5.imaal001=pmdp001 AND t5.imaal002='"||g_dlang||"' ",
                   "   LEFT JOIN inaml_t t6 ON t6.inamlent="||g_enterprise||" AND t6.inaml001=pmdp001 AND t6.inaml002=pmdp002 AND t6.inaml003='"||g_dlang||"' ",
       #161205-00025#1---e            
                   " ORDER BY pmdbdocno,pmdbseq "
                   
       PREPARE apmt500_01_pmdb_pb2 FROM l_sql
       DECLARE apmt500_01_pmdb_cs2 CURSOR FOR apmt500_01_pmdb_pb2

       FOREACH apmt500_01_pmdb_cs2 INTO g_pmdb2_d[l_ac2].pmdbdocno,g_pmdb2_d[l_ac2].pmdbseq,g_pmdb2_d[l_ac2].pmdb004,
                                        #g_pmdb2_d[l_ac2].imaal003,g_pmdb2_d[l_ac2].imaal004,   #161205-00025#2
                                        g_pmdb2_d[l_ac2].pmdb005,g_pmdb2_d[l_ac2].pmdb007,g_pmdb2_d[l_ac2].pmdb006,
                                        g_pmdb2_d[l_ac2].pmdb030,g_pmdb2_d[l_ac2].pmdb050,g_pmdb2_d[l_ac2].pmdp021,g_pmdb2_d[l_ac2].pmdp001,  #161222-00027#1 add pmdb050
                                        #g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2,   #161205-00025#2
                                        g_pmdb2_d[l_ac2].pmdp002,g_pmdb2_d[l_ac2].pmdp022,g_pmdb2_d[l_ac2].pmdp023,
                                        g_pmdb2_d[l_ac2].pmdn010,g_pmdb2_d[l_ac2].pmdn011,
                                        #161205-00025#2---s
                                        g_pmdb2_d[l_ac2].imaal003,g_pmdb2_d[l_ac2].imaal004,g_pmdb2_d[l_ac2].pmdb005_desc,
                                        g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2,g_pmdb2_d[l_ac2].pmdp002_desc
                                        #161205-00025#2---e
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "FOREACH:"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF
          
          #161205-00025#2---s
          #CALL apmt500_01_pmdb004_ref(g_pmdb2_d[l_ac2].pmdb004) RETURNING g_pmdb2_d[l_ac2].imaal003,g_pmdb2_d[l_ac2].imaal004
          #DISPLAY BY NAME g_pmdb2_d[l_ac2].imaal003,g_pmdb2_d[l_ac2].imaal004
          #
          #CALL s_feature_description(g_pmdb2_d[l_ac2].pmdb004,g_pmdb2_d[l_ac2].pmdb005) RETURNING l_success,g_pmdb2_d[l_ac2].pmdb005_desc
          #DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdb005_desc
          #
          #CALL apmt500_01_pmdb004_ref(g_pmdb2_d[l_ac2].pmdp001) RETURNING g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
          #DISPLAY BY NAME g_pmdb2_d[l_ac2].imaal003_2,g_pmdb2_d[l_ac2].imaal004_2
          #
          #CALL s_feature_description(g_pmdb2_d[l_ac2].pmdp001,g_pmdb2_d[l_ac2].pmdp002) RETURNING l_success,g_pmdb2_d[l_ac2].pmdp002_desc
          #DISPLAY BY NAME g_pmdb2_d[l_ac2].pmdp002_desc
          #161205-00025#2---e
          
          LET l_ac2 = l_ac2 + 1
          IF l_ac2 > g_max_rec AND g_error_show = 1 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  9035
             LET g_errparam.extend =  ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             EXIT FOREACH
          END IF
         
       END FOREACH
       
       CALL g_pmdb2_d.deleteElement(g_pmdb2_d.getLength())
       
       
END FUNCTION

PRIVATE FUNCTION apmt500_01_set_entry_b()
       CALL cl_set_comp_entry("pmdp002,pmdn010,pmdn011",TRUE)
END FUNCTION

PRIVATE FUNCTION apmt500_01_set_no_entry_b()
DEFINE l_imaf144   LIKE imaf_t.imaf144
DEFINE l_imaa005   LIKE imaa_t.imaa005

       LET l_imaa005 = ''
       CALL apmt500_01_get_imaa005(g_enterprise,g_pmdb2_d[l_ac2].pmdp001) RETURNING l_imaa005
       IF cl_null(l_imaa005) THEN
          CALL cl_set_comp_entry("pmdp002",FALSE)
          LET g_pmdb2_d[l_ac2].pmdp002 = ' '
       ELSE
          IF cl_null(g_pmdb2_d[l_ac2].pmdp002) THEN
             LET g_pmdb2_d[l_ac2].pmdp002 = ' '
          END IF
       END IF
       
       LET l_imaf144 = ''   #計價單位
       SELECT imaf144 INTO l_imaf144 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdb2_d[l_ac2].pmdp001
       IF cl_null(l_imaf144) THEN
          CALL cl_set_comp_entry("pmdn010,pmdn011",FALSE)
          LET g_pmdb2_d[l_ac2].pmdn010 = g_pmdb2_d[l_ac2].pmdp022
          LET g_pmdb2_d[l_ac2].pmdn011 = g_pmdb2_d[l_ac2].pmdp023
       END IF
       
END FUNCTION
#新增關聯單身明細
PRIVATE FUNCTION apmt500_01_ins_pmdp(p_pmdbdocno,p_pmdbseq,p_pmdb030,p_pmdn050)
   DEFINE l_sql      STRING
   DEFINE r_success  LIKE type_t.num5
   DEFINE p_pmdb030  LIKE pmdb_t.pmdb030
   #161124-00048#9 mod-S
#   DEFINE l_pmdp     RECORD LIKE pmdp_t.*
   DEFINE l_pmdp RECORD  #採購關聯單據明細檔
          pmdpent LIKE pmdp_t.pmdpent, #企业编号
          pmdpsite LIKE pmdp_t.pmdpsite, #营运据点
          pmdpdocno LIKE pmdp_t.pmdpdocno, #采购单号
          pmdpseq LIKE pmdp_t.pmdpseq, #采购项次
          pmdpseq1 LIKE pmdp_t.pmdpseq1, #项序
          pmdp001 LIKE pmdp_t.pmdp001, #料件编号
          pmdp002 LIKE pmdp_t.pmdp002, #产品特征
          pmdp003 LIKE pmdp_t.pmdp003, #来源单号
          pmdp004 LIKE pmdp_t.pmdp004, #来源项次
          pmdp005 LIKE pmdp_t.pmdp005, #来源项序
          pmdp006 LIKE pmdp_t.pmdp006, #来源分批序
          pmdp007 LIKE pmdp_t.pmdp007, #来源料号
          pmdp008 LIKE pmdp_t.pmdp008, #来源产品特征
          pmdp009 LIKE pmdp_t.pmdp009, #来源作业编号
          pmdp010 LIKE pmdp_t.pmdp010, #来源作业序
          pmdp011 LIKE pmdp_t.pmdp011, #来源BOM特性
          pmdp012 LIKE pmdp_t.pmdp012, #来源生产控制组
          pmdp021 LIKE pmdp_t.pmdp021, #冲销顺序
          pmdp022 LIKE pmdp_t.pmdp022, #需求单位
          pmdp023 LIKE pmdp_t.pmdp023, #需求数量
          pmdp024 LIKE pmdp_t.pmdp024, #折合采购量
          pmdp025 LIKE pmdp_t.pmdp025, #已收货量
          pmdp026 LIKE pmdp_t.pmdp026, #已入库量
          pmdp900 LIKE pmdp_t.pmdp900, #保留字段str
          pmdp999 LIKE pmdp_t.pmdp999  #保留字段end
   END RECORD
   #161124-00048#9 mod-E
   DEFINE p_pmdbdocno LIKE pmdb_t.pmdbdocno
   DEFINE p_pmdbseq   LIKE pmdb_t.pmdbseq
   DEFINE p_pmdn050   LIKE pmdn_t.pmdn050
   DEFINE l_success   LIKE type_t.num5

   LET r_success = TRUE
   #161216-00032#1--s
   IF cl_null(g_pmdn.pmdn002) THEN
      LET g_pmdn.pmdn002 = ' '
   END IF
   #161216-00032#1---e
   CASE tm.d 
      WHEN '1' 
         IF NOT cl_null(p_pmdbdocno) AND NOT cl_null(p_pmdbseq) THEN
            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
                        " FROM apmt500_01_tmp2 ",
                        " WHERE pmdbdocno = '",p_pmdbdocno,"' AND pmdbseq = '",p_pmdbseq,"' ",
                        "  AND COALESCE(pmdn050,' ') = COALESCE(?,' ') ",  #170329-00070#1 add
                        " ORDER BY pmdbdocno,pmdbseq "
         ELSE 
            #170324-00034#1 add s
            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
                        "   FROM apmt500_01_tmp2 ",
                        "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ",
                        "    AND COALESCE(pmdp002,' ') = COALESCE('",g_pmdn.pmdn002,"',' ') ",
                        "    AND pmdp022 = '",g_pmdn.pmdn006,"' ",
                        "    AND pmdn010 = '",g_pmdn.pmdn010,"' ",
                        "    AND COALESCE(pmdn036,' ') = COALESCE('",g_pmdn.pmdn036,"',' ') ",
                        "    AND COALESCE(pmdn037,' ') = COALESCE('",g_pmdn.pmdn037,"',' ') ",
                        "    AND COALESCE(pmdn038,' ') = COALESCE('",g_pmdn.pmdn038,"',' ') ",
                        "    AND COALESCE(pmdn050,' ') = COALESCE(?,' ') ",
                        "    AND COALESCE(pmdn058,' ') = COALESCE('",g_pmdn.pmdn058,"',' ') ", 
                        "    AND COALESCE(pmdn028,' ') = COALESCE('",g_pmdn028_t,"',' ') ",
                        "    AND COALESCE(pmdn029,' ') = COALESCE('",g_pmdn.pmdn029,"',' ') ",
                        "    AND COALESCE(pmdn053,' ') = COALESCE('",g_pmdn.pmdn053,"',' ') ",
                        "  ORDER BY pmdbdocno,pmdbseq "
            #170324-00034#1 add e
            
#170324-00034#1 mark s
#            #151225-00002#1 20151225 modify by ming -----(S) 
#            #LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#            #            " FROM apmt500_01_tmp2 ",
#            #            " WHERE pmdp001 = '",g_pmdn.pmdn001,"' AND pmdp002 = '",g_pmdn.pmdn002,"' ",
#            #            "   AND pmdp022 = '",g_pmdn.pmdn006,"' AND pmdn010 = '",g_pmdn.pmdn010,"' ",
#            #            #"   AND pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 <> 'E' ) ",
#            #            "   AND pmdn050 IS NULL "
#            #            #
#            #            #" UNION ",
#            #            #
#            #            #" SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#            #            #" FROM apmt500_01_tmp2 ",
#            #            #" WHERE pmdbdocno = '",p_pmdbdocno,"' AND pmdbseq = '",p_pmdbseq,"' ",
#            #            #"   AND pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 = 'E' )",
#            #            
#            #            #" ORDER BY pmdbdocno,pmdbseq "
#            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#                        "   FROM apmt500_01_tmp2 ",
#                        "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ", 
#                        #"    AND pmdp002 = '",g_pmdn.pmdn002,"' ",  #161216-00032#1
#                        "    AND (pmdp002 = '",g_pmdn.pmdn002,"' OR pmdp002 IS NULL)",  #161216-00032#1
#                        "    AND pmdp022 = '",g_pmdn.pmdn006,"' ", 
#                        "    AND pmdn010 = '",g_pmdn.pmdn010,"' "
#            #151225-00002#1 20151225 modify by ming -----(E) 
#                             
#            #add by lixiang 2015/10/15--begin---
#            IF NOT cl_null(g_pmdn.pmdn036) THEN
#               LET l_sql = l_sql , " AND pmdn036 = '",g_pmdn.pmdn036,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn036 = ' ' OR pmdn036 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn037) THEN
#               LET l_sql = l_sql , " AND pmdn037 = '",g_pmdn.pmdn037,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn037 = ' ' OR pmdn037 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn038) THEN
#               LET l_sql = l_sql , " AND pmdn038 = '",g_pmdn.pmdn038,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn038 = ' ' OR pmdn038 is null) "
#            END IF
#            
#            #170313-00049#1----s
#            ##151225-00002#1 20151225 add by ming -----(S) 
#            #IF NOT cl_null(p_pmdn050) THEN
#            #   #LET l_sql = l_sql," AND pmdn050 = '",p_pmdn050,"' "  #170302-00010#1 mark
#            #   LET l_sql = l_sql," AND pmdn050 = ? "                 #170302-00010#1 add
#            #END IF
#            ##151225-00002#1 20151225 add by ming -----(E) 
#            LET l_sql = l_sql," AND COALESCE(pmdn050,' ') = ? "
#            #170313-00049#1----e
#            
#            #ming 20151225 add ----(S) 
#            IF NOT cl_null(g_pmdn.pmdn058) THEN 
#               LET l_sql = l_sql," AND pmdn058 = '",g_pmdn.pmdn058,"' " 
#            END IF 
#            #ming 20151225 add ----(E) 
#            
#            #160801-00004#1---s
#            IF NOT cl_null(g_pmdn028_t) THEN
#               LET l_sql = l_sql , " AND pmdn028 = '",g_pmdn028_t,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn028 = ' ' OR pmdn028 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn029) THEN
#               LET l_sql = l_sql , " AND pmdn029 = '",g_pmdn.pmdn029,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn029 = ' ' OR pmdn029 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn053) THEN
#               LET l_sql = l_sql , " AND pmdn053 = '",g_pmdn.pmdn053,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn053 = ' ' OR pmdn053 is null) "
#            END IF
#            #160801-00004#1---e
#                 
#            LET l_sql = l_sql , " ORDER BY pmdbdocno,pmdbseq "
#            #add by lixiang 2015/10/15--end---- 
#170324-00034#1 mark e                             
         END IF
      WHEN '2'
         IF NOT cl_null(p_pmdbdocno) AND NOT cl_null(p_pmdbseq) THEN
            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
                        " FROM apmt500_01_tmp2 ",
                        " WHERE pmdbdocno = '",p_pmdbdocno,"' AND pmdbseq = '",p_pmdbseq,"' ",
                        "  AND COALESCE(pmdn050,' ') = COALESCE(?,' ') ",  #170329-00070#1 add
                        " ORDER BY pmdbdocno,pmdbseq "
         ELSE
            #170324-00034#1 add s
            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
                        "   FROM apmt500_01_tmp2 ",
                        "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ", 
                        "    AND COALESCE(pmdp002,' ') = COALESCE('",g_pmdn.pmdn002,"',' ') ",
                        "    AND pmdp022 = '",g_pmdn.pmdn006,"' ", 
                        "    AND pmdn010 = '",g_pmdn.pmdn010,"' ",
                        "    AND pmdb030 = '",p_pmdb030,"' ",
                        "    AND COALESCE(pmdn036,' ') = COALESCE('",g_pmdn.pmdn036,"',' ') ",
                        "    AND COALESCE(pmdn037,' ') = COALESCE('",g_pmdn.pmdn037,"',' ') ",
                        "    AND COALESCE(pmdn038,' ') = COALESCE('",g_pmdn.pmdn038,"',' ') ",
                        "    AND COALESCE(pmdn050,' ') = COALESCE(?,' ') ",
                        "    AND COALESCE(pmdn058,' ') = COALESCE('",g_pmdn.pmdn058,"',' ') ",
                        "    AND COALESCE(pmdn028,' ') = COALESCE('",g_pmdn028_t,"',' ') ",
                        "    AND COALESCE(pmdn029,' ') = COALESCE('",g_pmdn.pmdn029,"',' ') ",
                        "    AND COALESCE(pmdn053,' ') = COALESCE('",g_pmdn.pmdn053,"',' ') ",
                        "  ORDER BY pmdbdocno,pmdbseq "
            #170324-00034#1 add e
            
#170324-00034#1 mark s
#            #151225-00002#1 20151225 modify by ming -----(S) 
#            #LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#            #            " FROM apmt500_01_tmp2 ",
#            #            " WHERE pmdp001 = '",g_pmdn.pmdn001,"' AND pmdp002 = '",g_pmdn.pmdn002,"' ",
#            #            "   AND pmdp022 = '",g_pmdn.pmdn006,"' AND pmdn010 = '",g_pmdn.pmdn010,"' ",
#            #            "   AND pmdb030 = '",p_pmdb030,"' ",
#            #            #"   AND pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 <> 'E' ) ",
#            #            "   AND pmdn050 IS NULL "
#            #            #" UNION ",
#            #            #
#            #            #" SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#            #            #" FROM apmt500_01_tmp2 ",
#            #            #" WHERE pmdbdocno = '",p_pmdbdocno,"' AND pmdbseq = '",p_pmdbseq,"' ",
#            #            #"   AND pmdp001 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004 = 'E')", 
#            #                 
#            #            #"  ORDER BY pmdbdocno,pmdbseq " 
#            LET l_sql = " SELECT pmdbdocno,pmdbseq,pmdb004,pmdb005,pmdp023,pmdp021",
#                        "   FROM apmt500_01_tmp2 ",
#                        "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ", 
#                        #"    AND pmdp002 = '",g_pmdn.pmdn002,"' ",  #161216-00032#1
#                        "    AND (pmdp002 = '",g_pmdn.pmdn002,"' OR pmdp002 IS NULL)",  #161216-00032#1
#                        "    AND pmdp022 = '",g_pmdn.pmdn006,"' ", 
#                        "    AND pmdn010 = '",g_pmdn.pmdn010,"' ",
#                        "    AND pmdb030 = '",p_pmdb030,"' "
#            #151225-00002#1 20151225 modify by ming -----(E) 
#                             
#            #add by lixiang 2015/10/15--begin---
#            IF NOT cl_null(g_pmdn.pmdn036) THEN
#               LET l_sql = l_sql , " AND pmdn036 = '",g_pmdn.pmdn036,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn036 = ' ' OR pmdn036 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn037) THEN
#               LET l_sql = l_sql , " AND pmdn037 = '",g_pmdn.pmdn037,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn037 = ' ' OR pmdn037 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn038) THEN
#               LET l_sql = l_sql , " AND pmdn038 = '",g_pmdn.pmdn038,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn038 = ' ' OR pmdn038 is null) "
#            END IF
#                 
#            #170313-00049#1----s
#            ##151225-00002#1 20151225 add by ming -----(S) 
#            #IF NOT cl_null(p_pmdn050) THEN
#            #   #LET l_sql = l_sql," AND pmdn050 = '",p_pmdn050,"' "  #170302-00010#1 mark
#            #   LET l_sql = l_sql," AND pmdn050 = ? "                 #170302-00010#1 add
#            #END IF
#            ##151225-00002#1 20151225 add by ming -----(E) 
#            LET l_sql = l_sql," AND COALESCE(pmdn050,' ') = ? "
#            #170313-00049#1----e
#            
#            #ming 20151225 add -----(S) 
#            IF NOT cl_null(g_pmdn.pmdn058) THEN 
#               LET l_sql = l_sql," AND pmdn058 = '",g_pmdn.pmdn058,"' " 
#            END IF 
#            #ming 20151225 add -----(E) 
#            
#            #160801-00004#1---s
#            IF NOT cl_null(g_pmdn028_t) THEN
#               LET l_sql = l_sql , " AND pmdn028 = '",g_pmdn028_t,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn028 = ' ' OR pmdn028 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn029) THEN
#               LET l_sql = l_sql , " AND pmdn029 = '",g_pmdn.pmdn029,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn029 = ' ' OR pmdn029 is null) "
#            END IF
#            IF NOT cl_null(g_pmdn.pmdn053) THEN
#               LET l_sql = l_sql , " AND pmdn053 = '",g_pmdn.pmdn053,"' "
#            ELSE
#               LET l_sql = l_sql , " AND (pmdn053 = ' ' OR pmdn053 is null) "
#            END IF
#            #160801-00004#1---e
#                 
#            LET l_sql = l_sql , " ORDER BY pmdbdocno,pmdbseq "
#            #add by lixiang 2015/10/15--end---- 
#170324-00034#1 mark e

       END IF
   END CASE
   PREPARE ins_pmdp_pre FROM l_sql
   DECLARE ins_pmdp_cs CURSOR FOR ins_pmdp_pre
   #170313-00049#1----s
   IF cl_null(p_pmdn050) THEN
      LET p_pmdn050 = ' '
   END IF
   #170313-00049#1----e
   #FOREACH ins_pmdp_cs INTO l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp023,l_pmdp.pmdp021                  #170302-00010#1 mark
   FOREACH ins_pmdp_cs USING p_pmdn050 INTO l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,l_pmdp.pmdp023,l_pmdp.pmdp021   #170302-00010#1 add
           
      LET l_pmdp.pmdpsite = g_site
      LET l_pmdp.pmdpdocno = g_pmdldocno
      LET l_pmdp.pmdpseq = g_pmdn.pmdnseq
      #項序加1
      SELECT MAX(pmdpseq1)+1 INTO l_pmdp.pmdpseq1 FROM pmdp_t
       WHERE pmdpent = g_enterprise AND pmdpdocno = g_pmdldocno AND pmdpseq = g_pmdn.pmdnseq
      IF cl_null(l_pmdp.pmdpseq1) OR l_pmdp.pmdpseq1 = 0 THEN
         LET l_pmdp.pmdpseq1 = 1
      END IF
      LET l_pmdp.pmdp001 = g_pmdn.pmdn001
      LET l_pmdp.pmdp002 = g_pmdn.pmdn002
           
      SELECT pmdb007 INTO l_pmdp.pmdp022 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp.pmdp003 AND pmdbseq = l_pmdp.pmdp004
           
      #LET l_pmdp.pmdp022 = g_pmdn.pmdn006
      LET l_pmdp.pmdp024 = l_pmdp.pmdp023
           
      IF l_pmdp.pmdp022 <> g_pmdn.pmdn006 THEN
         CALL s_aooi250_convert_qty(l_pmdp.pmdp001,g_pmdn.pmdn006,l_pmdp.pmdp022,l_pmdp.pmdp023)
              RETURNING l_success,l_pmdp.pmdp023
      END IF
      LET l_pmdp.pmdp025 = 0
      LET l_pmdp.pmdp026 = 0
           
      INSERT INTO pmdp_t(pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,pmdp001,pmdp002,pmdp003,pmdp004,
                         pmdp007,pmdp008,pmdp021,pmdp022,pmdp023,pmdp024,pmdp025,pmdp026)
                 VALUES (g_enterprise,l_pmdp.pmdpsite,l_pmdp.pmdpdocno,l_pmdp.pmdpseq,l_pmdp.pmdpseq1,l_pmdp.pmdp001,
                         l_pmdp.pmdp002,l_pmdp.pmdp003,l_pmdp.pmdp004,l_pmdp.pmdp007,l_pmdp.pmdp008,
                         l_pmdp.pmdp021,l_pmdp.pmdp022,l_pmdp.pmdp023,l_pmdp.pmdp024,l_pmdp.pmdp025,l_pmdp.pmdp026)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmdp_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE                 
         RETURN r_success
      END IF
   END FOREACH  
        
   RETURN r_success
        
END FUNCTION
#採購料號檢查
PRIVATE FUNCTION apmt500_01_pmdp001_chk(p_pmdp001)
DEFINE p_pmdp001     LIKE pmdp_t.pmdp001
DEFINE l_pmdl004     LIKE pmdl_t.pmdl004
DEFINE l_flag        LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_ooba002     LIKE ooba_t.ooba002
DEFINE l_n           LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdp001) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_pmdp001
             
          #呼叫檢查存在並帶值的library
          IF cl_chk_exist("v_imaa001") THEN
             IF NOT cl_chk_exist("v_imaf001_14") THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          ELSE
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #判斷輸入的料件編號是否在控制組限制的產品範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_group('3','4',g_user,g_dept,p_pmdp001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00265'
                LET g_errparam.extend = p_pmdp001
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('4',g_pmdldocno,p_pmdp001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'ain-00015'
                LET g_errparam.extend = p_pmdp001
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('5',g_pmdldocno,p_pmdp001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                LET r_success = FALSE
                #CALL cl_err(p_pmdp001,'apm-00238',1)
                RETURN r_success
             END IF 
          END IF
          
          #獲取採購供應商編號
          LET l_pmdl004 = ''
          SELECT pmdl004 INTO l_pmdl004 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = g_pmdldocno
          
          #請採購替代是否依據BOM替代資料
          #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
          #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
          CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_ooba002
          IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0096') = "Y" THEN
             IF NOT s_apmt500_chk_bom_replace(g_pmdb2_d[l_ac2].pmdb004,p_pmdp001,g_pmdb2_d[l_ac2].pmdp002) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          ELSE       
             IF NOT s_pmaq_chk_replacement(l_pmdl004,g_pmdb2_d[l_ac2].pmdb004,p_pmdp001,'2',g_pmdb2_d[l_ac2].pmdb005,g_pmdb2_d[l_ac2].pmdp002) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF
       END IF
       
       RETURN r_success
       
END FUNCTION
#根據到庫日期計算緊急度
PRIVATE FUNCTION apmt500_01_pmdn014_to_pmdn020(p_pmdn014)
DEFINE l_imaf171    LIKE imaf_t.imaf171
DEFINE l_imaf172    LIKE imaf_t.imaf172
DEFINE l_imaf173    LIKE imaf_t.imaf173
DEFINE l_imaf174    LIKE imaf_t.imaf174
DEFINE l_imaf175    LIKE imaf_t.imaf175
DEFINE l_time1      LIKE imaf_t.imaf171
DEFINE l_time2      LIKE imaf_t.imaf171
DEFINE p_pmdn014    LIKE pmdn_t.pmdn014
DEFINE r_pmdn020    LIKE pmdn_t.pmdn020

        LET r_pmdn020 = '1'
        IF NOT cl_null(p_pmdn014) THEN  
          LET l_imaf171 = 0
          LET l_imaf172 = 0
          LET l_imaf173 = 0
          LET l_imaf174 = 0
          LET l_imaf175 = 0
          LET l_time1 = 0
          LET l_time2 = 0
          
          SELECT imaf171,imaf172,imaf173,imaf174,imaf175 INTO l_imaf171,l_imaf172,l_imaf173,l_imaf174,l_imaf175
            FROM imaf_t 
            WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdn.pmdn001
          
          #160222-00020#1--add---begin---
          #若是料件未設置，則抓取aoo020上設置的資料
          IF cl_null(l_imaf171) OR l_imaf171 = 0 THEN
             LET l_imaf171 =  cl_get_para(g_enterprise,g_site,'S-BAS-0024')
          END IF
          IF cl_null(l_imaf172) OR l_imaf172 = 0 THEN
             LET l_imaf172 =  cl_get_para(g_enterprise,g_site,'S-BAS-0025')
          END IF
          IF cl_null(l_imaf173) OR l_imaf173 = 0 THEN
             LET l_imaf173 =  cl_get_para(g_enterprise,g_site,'S-BAS-0026')
          END IF
          IF cl_null(l_imaf174) OR l_imaf174 = 0 THEN
             LET l_imaf174 =  cl_get_para(g_enterprise,g_site,'S-BAS-0027')
          END IF
          #160222-00020#1--add---end--- 
          
          LET l_time1 = p_pmdn014 - g_today         #到庫日期  - g_today
          LET l_time2 = l_imaf171+l_imaf172+l_imaf173+l_imaf174  #[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數
          
          #1.若輸入的到庫日期 - g_today >[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數時，則[C:緊急度] = '1'(一般)
          IF l_time1 >= l_time2 THEN
             LET r_pmdn020 = '1'
          END IF
          
          #2.若輸入的到庫日期 - g_today <[T:料件據點進銷存檔]設置的(文件+交貨+到廠+入庫)前置天數，
          #   且到庫日期 - g_today >[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '2'(緊急)
          IF l_time1 < l_time2 AND l_time1 >= l_imaf175 THEN
             LET r_pmdn020 = '2'
          END IF
          
          #3.若輸入的到庫日期 - g_today <[T:料件據點進銷存檔].[C:嚴守交期前置時間]時，則[C:緊急度] = '3'(特急)
          IF l_time1 < l_imaf175 THEN
             LET r_pmdn020 = '3'
          END IF
       END IF
       RETURN r_pmdn020
       
END FUNCTION

PRIVATE FUNCTION apmt500_01_pmdp022_chk(p_pmdp022)
DEFINE p_pmdp022    LIKE pmdp_t.pmdp022
DEFINE r_success    LIKE type_t.num5

       LET r_success = TRUE

       IF NOT cl_null(p_pmdp022) THEN
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL

          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = g_pmdb2_d[l_ac2].pmdp001
          LET g_chkparam.arg2 = p_pmdp022

          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_imao002") THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       RETURN r_success

END FUNCTION
#勾選多交期，新增pmdq的資料
PRIVATE FUNCTION apmt500_01_ins_pmdq_1()
   DEFINE l_sql      STRING
   DEFINE r_success  LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdq     RECORD LIKE pmdq_t.*
   DEFINE l_pmdq RECORD  #採購多交期匯總檔
          pmdqent LIKE pmdq_t.pmdqent, #企业编号
          pmdqsite LIKE pmdq_t.pmdqsite, #营运据点
          pmdqdocno LIKE pmdq_t.pmdqdocno, #采购单号
          pmdqseq LIKE pmdq_t.pmdqseq, #采购项次
          pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
          pmdq002 LIKE pmdq_t.pmdq002, #分批数量
          pmdq003 LIKE pmdq_t.pmdq003, #交货日期
          pmdq004 LIKE pmdq_t.pmdq004, #到厂日期
          pmdq005 LIKE pmdq_t.pmdq005, #到库日期
          pmdq006 LIKE pmdq_t.pmdq006, #收货时段
          pmdq007 LIKE pmdq_t.pmdq007, #MRP冻结否
          pmdq008 LIKE pmdq_t.pmdq008, #交期类型
          pmdq201 LIKE pmdq_t.pmdq201, #分批包装单位
          pmdq202 LIKE pmdq_t.pmdq202, #分批包装数量
          pmdq900 LIKE pmdq_t.pmdq900, #保留字段str
          pmdq999 LIKE pmdq_t.pmdq999  #保留字段end
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_pmdp003  LIKE pmdp_t.pmdp003
   DEFINE l_pmdp004  LIKE pmdp_t.pmdp004
   DEFINE l_pmdq002  LIKE pmdq_t.pmdq002
   DEFINE l_pmdn007  LIKE pmdn_t.pmdn007
   DEFINE l_pmdn050  LIKE pmdn_t.pmdn050  #add by lixiang 
   DEFINE l_pmdn058  LIKE pmdn_t.pmdn058  #ming 20151225 add 

   LET r_success = TRUE

#170324-00034#1 add s
   LET l_sql = " SELECT pmdb030,SUM(pmdp023),pmdn050,pmdn058 FROM apmt500_01_tmp2 ", 
               "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ", 
               "    AND COALESCE(pmdp002,' ') = COALESCE('",g_pmdn.pmdn002,"',' ') ",
               "    AND pmdp022 = '",g_pmdn.pmdn006,"' ", 
               "    AND pmdn010 = '",g_pmdn.pmdn010,"' ",
               "    AND COALESCE(pmdn036,' ') = COALESCE('",g_pmdn.pmdn036,"',' ') ",
               "    AND COALESCE(pmdn037,' ') = COALESCE('",g_pmdn.pmdn037,"',' ') ",
               "    AND COALESCE(pmdn038,' ') = COALESCE('",g_pmdn.pmdn038,"',' ') ",
               "    AND COALESCE(pmdn050,' ') = COALESCE('",g_pmdn.pmdn050,"',' ') ",
               "    AND COALESCE(pmdn058,' ') = COALESCE('",g_pmdn.pmdn058,"',' ') ", 
               "    AND COALESCE(pmdn028,' ') = COALESCE('",g_pmdn028_t,"',' ') ",
               "    AND COALESCE(pmdn029,' ') = COALESCE('",g_pmdn.pmdn029,"',' ') ",
               "    AND COALESCE(pmdn053,' ') = COALESCE('",g_pmdn.pmdn053,"',' ') "
               
               
   IF tm.d = '2' THEN
      LET l_sql = l_sql," AND pmdb030 = '",g_pmdn.pmdn014,"' "
   END IF
   
   LET l_sql = l_sql,"  GROUP BY pmdb030,pmdn050,pmdn058 "
#170324-00034#1 add s

#170324-00034#1 mark s
#   #151225-00002#1 20151225 modify by ming -----(S) 
#   #LET l_sql = " SELECT pmdb030,SUM(pmdp023),pmdn050 FROM apmt500_01_tmp2 ", #add by lixiang 
#   #            " WHERE pmdp001 = '",g_pmdn.pmdn001,"' AND pmdp002 = '",g_pmdn.pmdn002,"' ",
#   #            "   AND pmdp022 = '",g_pmdn.pmdn006,"' AND pmdn010 = '",g_pmdn.pmdn010,"' ",
#   #            "   AND pmdn050 IS NULL "   #add by lixiang 
#   LET l_sql = " SELECT pmdb030,SUM(pmdp023),pmdn050,pmdn058 FROM apmt500_01_tmp2 ", 
#               "  WHERE pmdp001 = '",g_pmdn.pmdn001,"' ", 
#               "    AND pmdp002 = '",g_pmdn.pmdn002,"' ",
#               "    AND pmdp022 = '",g_pmdn.pmdn006,"' ", 
#               "    AND pmdn010 = '",g_pmdn.pmdn010,"' "
#   #151225-00002#1 20151225 modify by ming -----(S) 
#                    
#   #add by lixiang 2015/10/15--begin---
#   IF NOT cl_null(g_pmdn.pmdn036) THEN
#      LET l_sql = l_sql , " AND pmdn036 = '",g_pmdn.pmdn036,"' "
#   ELSE
#      LET l_sql = l_sql , " AND (pmdn036 = ' ' OR pmdn036 is null) "
#   END IF
#   IF NOT cl_null(g_pmdn.pmdn037) THEN
#      LET l_sql = l_sql , " AND pmdn037 = '",g_pmdn.pmdn037,"' "
#   ELSE
#      LET l_sql = l_sql , " AND (pmdn037 = ' ' OR pmdn037 is null) "
#   END IF
#   IF NOT cl_null(g_pmdn.pmdn038) THEN
#      LET l_sql = l_sql , " AND pmdn038 = '",g_pmdn.pmdn038,"' "
#   ELSE
#      LET l_sql = l_sql , " AND (pmdn038 = ' ' OR pmdn038 is null) "
#   END IF
#
#   #add by lixiang 2015/10/15--end----            
#   #ming 20151225 modify -----(S) 
#   #LET l_sql = l_sql ," GROUP BY pmdb030,pmdn050 " #add by lixiang 
#   LET l_sql = l_sql ," GROUP BY pmdb030,pmdn050,pmdn058 "
#   #ming 20151225 modify -----(E) 
#170324-00034#1 mark e

   PREPARE ins_pmdq_pre FROM l_sql
   DECLARE ins_pmdq_cs CURSOR FOR ins_pmdq_pre
   FOREACH ins_pmdq_cs INTO l_pmdq.pmdq005,l_pmdq.pmdq002,l_pmdn050, 
                            l_pmdn058     #ming 20151225 add 

      LET l_pmdq.pmdqsite = g_site
      LET l_pmdq.pmdqdocno = g_pmdldocno
      LET l_pmdq.pmdqseq = g_pmdn.pmdnseq
              
      #分批序加1
      SELECT MAX(pmdqseq2)+1 INTO l_pmdq.pmdqseq2 FROM pmdq_t
       WHERE pmdqent = g_enterprise AND pmdqdocno = g_pmdldocno AND pmdqseq = g_pmdn.pmdnseq
      IF cl_null(l_pmdq.pmdqseq2) OR l_pmdq.pmdqseq2 = 0 THEN
         LET l_pmdq.pmdqseq2 = 1
      END IF
              
      #到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
      #交貨日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
      CALL apmt500_01_date_count(l_pmdq.pmdq005) RETURNING l_pmdq.pmdq004,l_pmdq.pmdq003
           
      LET l_pmdq.pmdq006 = ''
      #根據請購單中的收貨時段帶值
      SELECT pmdp003,pmdp004 INTO l_pmdp003,l_pmdp004 FROM pmdp_t
       WHERE pmdpent = g_enterprise AND pmdpdocno = g_pmdldocno AND pmdpseq = g_pmdn.pmdnseq
      SELECT pmdb048 INTO l_pmdq.pmdq006 FROM pmdb_t
       WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
                 
      LET l_pmdq.pmdq007 = 'N'
      LET l_pmdq.pmdq008 = '1'   #交期類型
              
      INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,
                         pmdq005,pmdq006,pmdq007,pmdq008)
                 VALUES (g_enterprise,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
                         l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008)
      IF SQLCA.SQLcode  THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmdq_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE                 
         RETURN r_success
      END IF
        
   END FOREACH
        
   #如果交期數量與採購量有差，則把差值加在第一筆項次上
   SELECT SUM(pmdq002) INTO l_pmdq002 FROM pmdq_t
    WHERE pmdqent = g_enterprise AND pmdqdocno = g_pmdldocno AND pmdqseq = g_pmdn.pmdnseq
             
   SELECT SUM(pmdn007) INTO l_pmdn007 FROM pmdn_t
    WHERE pmdnent = g_enterprise AND pmdndocno = g_pmdldocno AND pmdnseq = g_pmdn.pmdnseq
          
   IF l_pmdn007 > l_pmdq002 THEN
      UPDATE pmdq_t SET pmdq002 = pmdq002 + (l_pmdn007 - l_pmdq002)
       WHERE pmdqent = g_enterprise AND pmdqdocno = g_pmdldocno 
         AND pmdqseq = g_pmdn.pmdnseq AND pmdqseq2 = 1
   END IF
        
   RETURN r_success
           
END FUNCTION
#根據到庫日期，計算到廠日期，交貨日期
PRIVATE FUNCTION apmt500_01_date_count(p_pmdn014)
DEFINE p_pmdn014   LIKE pmdn_t.pmdn014
DEFINE r_pmdn013   LIKE pmdn_t.pmdn013
DEFINE r_pmdn012   LIKE pmdn_t.pmdn012
DEFINE l_imaf173   LIKE imaf_t.imaf173
DEFINE l_imaf174   LIKE imaf_t.imaf174
DEFINE l_ooef008   LIKE ooef_t.ooef008
DEFINE l_ooef009   LIKE ooef_t.ooef009

     LET r_pmdn013 = ''
     LET r_pmdn012 = ''
     
     IF NOT cl_null(p_pmdn014) THEN
        LET l_imaf173 = ''
        LET l_imaf174 = ''
        SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
           FROM imaf_t 
           WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = g_pmdn.pmdn001
        
        #160222-00020#1--add---begin---
        #若是料件未設置，則抓取aoo020上設置的資料
        IF cl_null(l_imaf173) OR l_imaf173 = 0 THEN
           LET l_imaf173 =  cl_get_para(g_enterprise,g_site,'S-BAS-0026')
        END IF
        IF cl_null(l_imaf174) OR l_imaf174 = 0 THEN
           LET l_imaf174 =  cl_get_para(g_enterprise,g_site,'S-BAS-0027')
        END IF
        #160222-00020#1--add---end---   
        
        #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
        SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=g_site
       
       
        #若到廠日期為NULL時，輸入到庫日期後需自動計算到廠日期，公式為到庫日期-[T:料件據點進銷存檔].[C:到庫前置時間]
        IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
           CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,p_pmdn014,0,(l_imaf174*(-1))) RETURNING r_pmdn013
        ELSE
           LET r_pmdn013 = p_pmdn014
        END IF  
        
        #若交貨日期為NULL時，輸入到庫日期後需自動計算交貨日期，公式為到廠日期-[T:料件據點進銷存檔].[C:到廠前置時間]
        IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
           CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,r_pmdn013,0,(l_imaf173*(-1))) RETURNING r_pmdn012
        ELSE
           LET r_pmdn012 = r_pmdn013
        END IF
     END IF  
        
     RETURN r_pmdn013,r_pmdn012
            
END FUNCTION

#獲取料號是否使用產品特徵
PRIVATE FUNCTION apmt500_01_get_imaa005(p_enterprise,p_imaa001)
DEFINE p_enterprise   LIKE type_t.num5,
       p_imaa001      LIKE imaa_t.imaa001
DEFINE r_imaa005      LIKE imaa_t.imaa005

   LET r_imaa005 = ''
   SELECT imaa005 INTO r_imaa005 
     FROM imaa_t 
    WHERE imaaent = p_enterprise 
      AND imaa001 = p_imaa001
      
   RETURN r_imaa005   
   
END FUNCTION

PRIVATE FUNCTION apmt500_01_pmdn007_chk(p_pmdn001,p_pmdn006,p_pmdn007,p_pmdb006,p_pmdb006_1)
DEFINE p_pmdn001   LIKE pmdn_t.pmdn001  #料號
DEFINE p_pmdn006   LIKE pmdn_t.pmdn006  #單位
DEFINE p_pmdn007   LIKE pmdn_t.pmdn007  #當前採購數量
DEFINE p_pmdb006   LIKE pmdb_t.pmdb006  #未轉的請購量
DEFINE p_pmdb006_1 LIKE pmdb_t.pmdb006  #總請購量
DEFINE r_success   LIKE type_t.num5
DEFINE r_pmdn007   LIKE pmdn_t.pmdn007
DEFINE l_imaf143   LIKE imaf_t.imaf143  #採購單位
DEFINE l_imaf145   LIKE imaf_t.imaf145  #採購單位批量
DEFINE l_imaf146   LIKE imaf_t.imaf146  #採購最小數量
DEFINE l_imaf147   LIKE imaf_t.imaf147  #單位批量控管方式
DEFINE l_success   LIKE type_t.num5
DEFINE l_qty       LIKE pmdb_t.pmdb006  #數量
DEFINE l_mod       LIKE type_t.num10
DEFINE l_num       LIKE type_t.num10
DEFINE l_qty1      LIKE pmdb_t.pmdb006  #數量
DEFINE l_sum       LIKE pmdb_t.pmdb006  #最大可採購數量
DEFINE l_ooba002   LIKE ooba_t.ooba002
DEFINE l_type      LIKE type_t.chr1
DEFINE l_rate      LIKE type_t.num5
DEFINE l_pmdb006   LIKE pmdb_t.pmdb006
DEFINE l_n_qty      LIKE type_t.num10    
DEFINE l_msg        STRING               
DEFINE l_min_qty    LIKE pmdb_t.pmdb006
DEFINE l_qty2       LIKE pmdb_t.pmdb006  #數量

      LET r_success = TRUE
      LET r_pmdn007 = p_pmdn007
      
      #CALL cl_err_collect_init()
      
      IF (NOT cl_null(p_pmdn001)) AND (NOT cl_null(p_pmdn006)) AND (NOT cl_null(p_pmdn007)) THEN
          
          SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
            FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_pmdn001
          IF SQLCA.SQLCODE = 100 THEN
             SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
               FROM imaf_t WHERE imafent = g_enterprise AND imafsite = "ALL" AND imaf001 = p_pmdn001
          END IF
          
          LET l_qty = p_pmdn007
          IF NOT cl_null(l_imaf143) THEN
             #需求單位與採購不一致時，需換算成採購單位對應的數量進行計算
             IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
                CALL s_aooi250_convert_qty(p_pmdn001,p_pmdn006,l_imaf143,p_pmdn007)
                    RETURNING l_success,l_qty
             END IF
             
             CALL s_aooi250_take_decimals(l_imaf143,l_qty) RETURNING l_success,l_qty
             IF NOT cl_null(l_imaf145) THEN
                CALL s_aooi250_take_decimals(l_imaf143,l_imaf145) RETURNING l_success,l_imaf145
             END IF
             IF NOT cl_null(l_imaf146) THEN
                CALL s_aooi250_take_decimals(l_imaf143,l_imaf146) RETURNING l_success,l_imaf146
             END IF
          END IF
          
          IF NOT cl_null(l_imaf146) THEN
             IF l_imaf146 > l_qty THEN
                LET l_min_qty = l_imaf146
             ELSE 
                LET l_min_qty = l_qty
             END IF
          END IF 
          
          IF NOT cl_null(l_imaf145) AND l_imaf145 != 0 THEN
             LET l_n_qty = l_min_qty / l_imaf145
             IF l_min_qty != l_imaf145 * l_n_qty THEN
                IF l_min_qty > l_imaf145 * l_n_qty THEN
                   LET l_qty1 = l_imaf145 * (l_n_qty + 1)
                ELSE
                   LET l_qty1 = l_imaf145 * l_n_qty
                END IF
             ELSE
                LET l_qty1 = l_imaf145 * l_n_qty
             END IF
          ELSE
             LET l_qty1 = l_min_qty
          END IF
          
          #IF l_imaf147 = '1' THEN   #警告
          #   #小於最小採購量，則以最小採購量為主
          #   IF l_qty < l_imaf146 THEN
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code = 'apm-00601'
          #      LET g_errparam.extend = p_pmdn001
          #      LET g_errparam.popup = TRUE
          #      CALL cl_err()
          #   END IF
          #
          #
          #   IF l_imaf145 > 0 THEN  #有維護最小批量時，檢查
          #      LET l_mod = l_qty MOD l_imaf145
          #      IF l_mod <> 0 THEN  #有餘數，說明不是整除
          #         INITIALIZE g_errparam TO NULL
          #         LET g_errparam.code = 'apm-00599'
          #         LET g_errparam.extend = p_pmdn001
          #         LET g_errparam.popup = TRUE
          #         CALL cl_err()
          #      END IF
          #   END IF
          #END IF
          #IF l_imaf147 = '2' THEN   #嚴格控管
          #   小於最小採購量，則以最小採購量為主
          #   IF l_qty < l_imaf146 THEN
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code = 'apm-00601'
          #      LET g_errparam.extend = p_pmdn001
          #      LET g_errparam.popup = TRUE
          #      CALL cl_err()
          #      
          #      LET l_qty = l_imaf146
          #      #將aimm214中維護的採購單位與當前單位進行換算
          #      IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
          #         CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty)
          #             RETURNING l_success,r_pmdn007
          #      ELSE
          #         LET r_pmdn007 = l_qty
          #      END IF
          #      CALL s_aooi250_take_decimals(p_pmdn006,l_qty) RETURNING l_success,r_pmdn007
          #   END IF
          #   
          #   IF l_imaf145 > 0 THEN  #有維護最小批量時，檢查
          #      LET l_mod = l_qty MOD l_imaf145
          #      IF l_mod <> 0 THEN  #有餘數，說明不是整除
          #         #加上符合單位批量的最小差值
          #         INITIALIZE g_errparam TO NULL
          #         LET g_errparam.code = 'apm-00602'
          #         LET g_errparam.extend = p_pmdn001
          #         LET g_errparam.popup = TRUE
          #         CALL cl_err()
          #         ##如果有最小批量檢查不通過，需加上 最小批量差
          #         #ex:如果當前數量是 8，最小批量是5，檢查的時候數量可維護成10，需加上最小批量造成的數量差2
          #         IF l_imaf145 > 0 THEN
          #            LET l_num = l_qty / l_imaf145
          #            #CALL s_num_round('4',l_num,0) RETURNING l_num  #向上取整
          #            LET l_qty1 = (l_num + 1) * l_imaf145    #向上取整,取符合最小批量的數量
          #            #將aimm214中維護的採購單位與當前單位進行換算
          #            IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
          #               CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty1)
          #                   RETURNING l_success,r_pmdn007
          #            ELSE
          #               LET r_pmdn007 = l_qty1
          #            END IF
          #            CALL s_aooi250_take_decimals(p_pmdn006,r_pmdn007) RETURNING l_success,r_pmdn007
          #         END IF
          #      END IF
          #   END IF
          #END IF
          IF l_qty < l_qty1 THEN
             CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty1)
                   RETURNING l_success,l_qty2
             IF l_imaf147 MATCHES '[1]' THEN
                LET l_msg = cl_getmsg('apm-00600',g_lang),l_qty2 USING '---,---,---,--&.&&&'
                IF cl_ask_promp(l_msg) THEN
                   LET l_qty = l_qty1
                END IF
             END IF
             #嚴格控制
             IF l_imaf147 MATCHES '[2]' THEN
                LET l_msg = cl_getmsg('apm-00711',g_lang),l_qty2 USING '---,---,---,--&.&&&'
                #CALL cl_ask_msg_error('',l_msg,'') 
                CALL cl_ask_pressanykey('apm-00711')
                LET l_qty = l_qty1
             END IF
          END IF
          
          IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
             CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty)
                 RETURNING l_success,r_pmdn007
          ELSE
             LET r_pmdn007 = l_qty
          END IF
      END IF
      
      #請采勾稽時，判斷採購的數量 和 容差率的處理
      CALL s_aooi200_get_slip(g_pmdldocno) RETURNING l_success,l_ooba002
      IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0061') AND g_argv[1] <> '1' THEN   #委外時，不關聯請購判斷數量

         #大於容差率 時的處理方式
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0084') RETURNING l_type
         
         #最大容差率
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0085') RETURNING l_rate
         IF l_rate > 0 THEN
            LET l_pmdb006 = (l_rate /100) * p_pmdb006_1
         END IF   
         
         LET l_sum = p_pmdb006 + l_pmdb006 #未轉請購總量 + 最大容差量
         
         IF r_pmdn007 > l_sum THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00585'
            LET g_errparam.extend = p_pmdn001
            LET g_errparam.popup = TRUE
            CALL cl_err()
            IF l_type = '1' THEN  #拒絕
               #CALL cl_err_collect_show()
               LET r_success = FALSE
               RETURN r_success,r_pmdn007
            END IF
         END IF
         
         
      END IF
      
      #CALL cl_err_collect_show()
      
      RETURN r_success,r_pmdn007
      
      
END FUNCTION

#未勾選多交期，新增pmdq的資料，與採購單單身數量相同
PRIVATE FUNCTION apmt500_01_ins_pmdq_2()
DEFINE r_success  LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdq     RECORD LIKE pmdq_t.*
DEFINE l_pmdq RECORD  #採購多交期匯總檔
       pmdqent LIKE pmdq_t.pmdqent, #企业编号
       pmdqsite LIKE pmdq_t.pmdqsite, #营运据点
       pmdqdocno LIKE pmdq_t.pmdqdocno, #采购单号
       pmdqseq LIKE pmdq_t.pmdqseq, #采购项次
       pmdqseq2 LIKE pmdq_t.pmdqseq2, #分批序
       pmdq002 LIKE pmdq_t.pmdq002, #分批数量
       pmdq003 LIKE pmdq_t.pmdq003, #交货日期
       pmdq004 LIKE pmdq_t.pmdq004, #到厂日期
       pmdq005 LIKE pmdq_t.pmdq005, #到库日期
       pmdq006 LIKE pmdq_t.pmdq006, #收货时段
       pmdq007 LIKE pmdq_t.pmdq007, #MRP冻结否
       pmdq008 LIKE pmdq_t.pmdq008, #交期类型
       pmdq201 LIKE pmdq_t.pmdq201, #分批包装单位
       pmdq202 LIKE pmdq_t.pmdq202, #分批包装数量
       pmdq900 LIKE pmdq_t.pmdq900, #保留字段str
       pmdq999 LIKE pmdq_t.pmdq999  #保留字段end
END RECORD
#161124-00048#9 mod-E
DEFINE l_pmdp003  LIKE pmdp_t.pmdp003
DEFINE l_pmdp004  LIKE pmdp_t.pmdp004

        LET r_success = TRUE

        LET l_pmdq.pmdqsite = g_site
        LET l_pmdq.pmdqdocno = g_pmdldocno
        LET l_pmdq.pmdqseq = g_pmdn.pmdnseq
        
        #分批序加1
        SELECT MAX(pmdqseq2)+1 INTO l_pmdq.pmdqseq2 FROM pmdq_t
          WHERE pmdqent = g_enterprise AND pmdqdocno = g_pmdldocno AND pmdqseq = g_pmdn.pmdnseq
        IF cl_null(l_pmdq.pmdqseq2) OR l_pmdq.pmdqseq2 = 0 THEN
           LET l_pmdq.pmdqseq2 = 1
        END IF
        
        LET l_pmdq.pmdq002 = g_pmdn.pmdn007
        LET l_pmdq.pmdq003 = g_pmdn.pmdn012
        LET l_pmdq.pmdq004 = g_pmdn.pmdn013
        LET l_pmdq.pmdq005 = g_pmdn.pmdn014
        
        LET l_pmdq.pmdq006 = ''
        #根據請購單中的收貨時段帶值
        SELECT pmdp003,pmdp004 INTO l_pmdp003,l_pmdp004 FROM pmdp_t
           WHERE pmdpent = g_enterprise AND pmdpdocno = g_pmdldocno AND pmdpseq = g_pmdn.pmdnseq
        SELECT pmdb048 INTO l_pmdq.pmdq006 FROM pmdb_t
           WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
           
        LET l_pmdq.pmdq007 = 'N'
        LET l_pmdq.pmdq008 = '1'   #交期類型
        
        INSERT INTO pmdq_t(pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,pmdq002,pmdq003,pmdq004,
                           pmdq005,pmdq006,pmdq007,pmdq008)
                VALUES (g_enterprise,l_pmdq.pmdqsite,l_pmdq.pmdqdocno,l_pmdq.pmdqseq,l_pmdq.pmdqseq2,
                        l_pmdq.pmdq002,l_pmdq.pmdq003,l_pmdq.pmdq004,l_pmdq.pmdq005,l_pmdq.pmdq006,l_pmdq.pmdq007,l_pmdq.pmdq008)
        IF SQLCA.SQLcode  THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "pmdq_t"
           LET g_errparam.popup = TRUE
           CALL cl_err()

           LET r_success = FALSE                 
           RETURN r_success
        END IF

        RETURN r_success
           
END FUNCTION

################################################################################
# Descriptions...: 設定欄位開關
# Memo...........:
# Usage..........: CALL apmt500_01_set_entry()
# Date & Author..: 2015/11/13 By minig
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt500_01_set_entry()
   CALL cl_set_comp_entry("d",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 設定欄位開關
# Memo...........:
# Usage..........: CALL apmt500_01_set_no_entry()
# Date & Author..: 2015/11/13 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apmt500_01_set_no_entry()
   IF tm.e = 'Y' THEN
      CALL cl_set_comp_entry("d",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立temp table，需要的程式需先行呼叫，以免破壞transaction
# Memo...........:
# Usage..........: CALL apmt500_01_create_temp_table()
# Date & Author..: 2015/12/25 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt500_01_create_temp_table()
   #161216-00032#1 ---s
   #CREATE TEMP TABLE apmt500_01_tmp(
   #pmda004    LIKE pmda_t.pmda004,   #用於標記是否勾選
   #pmdbdocno  LIKE pmdb_t.pmdbdocno,
   #pmdbseq    LIKE pmdb_t.pmdbseq,
   #pmdb004    LIKE pmdb_t.pmdb004,
   #pmdb005    LIKE pmdb_t.pmdb005,
   #pmdb007    LIKE pmdb_t.pmdb007,
   #pmdb006    LIKE pmdb_t.pmdb006,
   #pmdb006_1  LIKE pmdb_t.pmdb006,
   #pmdb030    LIKE pmdb_t.pmdb030,
   #pmdb033    LIKE pmdb_t.pmdb033,
   #pmda002    LIKE pmda_t.pmda002,
   #pmda003    LIKE pmda_t.pmda003
   # );
   CREATE TEMP TABLE apmt500_01_tmp(
   pmda004    VARCHAR(1),   #用於標記是否勾選
   pmdbdocno  VARCHAR(20),
   pmdbseq    DECIMAL(10,0),
   pmdb004    VARCHAR(40),
   pmdb005    VARCHAR(256),
   pmdb007    VARCHAR(10),
   pmdb006    DECIMAL(20,6),
   pmdb006_1  DECIMAL(20,6),
   pmdb030    DATE,
   pmdb033    VARCHAR(10),
   pmdb050    VARCHAR(256),      #161222-00027#1 add pmdb050
   pmda002    VARCHAR(20),
   pmda003    VARCHAR(10)
    );
   #161216-00032#1---e
   
   CREATE TEMP TABLE apmt500_01_tmp2
   (
   pmdbdocno   VARCHAR(20),
   pmdbseq     DECIMAL(10,0),
   pmdb004     VARCHAR(40),
   pmdb005     VARCHAR(256),
   pmdb007     VARCHAR(10),
   pmdb006     DECIMAL(20,6),
   pmdb006_1   DECIMAL(20,6),
   pmdb030     DATE,
   pmdb050     VARCHAR(256),      #161222-00027#1 add pmdb050
   pmdp021     DECIMAL(10,0),
   pmdp001     VARCHAR(40),
   pmdp002     VARCHAR(256),
   pmdp022     VARCHAR(10),
   pmdp023     DECIMAL(20,6),
   pmdn010     VARCHAR(10),
   pmdn011     DECIMAL(20,6),
   #160801-00004#1--s--
   #庫位儲位的定義錯誤
   #pmdn028     DECIMAL(20,6),  #收貨庫位  #150819-00010 by whitney add
   #pmdn029     DECIMAL(20,6),  #收貨儲位  #150819-00010 by whitney add
   pmdn028     VARCHAR(10),  #收貨庫位  
   pmdn029     VARCHAR(10),  #收貨儲位 
   pmdn053     VARCHAR(30),  #庫存管理特徵
   #160801-00004#1---e
   pmdn036     VARCHAR(20),  #专案编号  
   pmdn037     VARCHAR(30),  #WBS     
   pmdn038     VARCHAR(30),  #活动编号  
   pmdn050     VARCHAR(256),    #備註
   pmdn058     VARCHAR(10)     #科目預算 
   );
   
END FUNCTION

################################################################################
# Descriptions...: 刪除temp table，需要的程式需先行呼叫，以免破壞transaction
# Memo...........:
# Usage..........: CALL apmt500_01_drop_temp_table()
# Date & Author..: 2015/12/25 By ming
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt500_01_drop_temp_table()
   DROP TABLE apmt500_01_tmp
   DROP TABLE apmt500_01_tmp2

END FUNCTION

 
{</section>}
 
