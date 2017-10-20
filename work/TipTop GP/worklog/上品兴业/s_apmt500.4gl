#該程式未解開Section, 採用最新樣板產出!
{<section id="s_apmt500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0065(1900-01-01 00:00:00), PR版次:0065(2017-08-29 12:10:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000365
#+ Filename...: s_apmt500
#+ Description: 採購單維護作業相關元件
#+ Creator....: 02294(2013-12-23 11:27:29)
#+ Modifier...: 00000 -SD/PR- topstd
 
{</section>}
 
{<section id="s_apmt500.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#151125-00005#1  2015/11/18 By shiun      訂單的訂金如果已立帳，不能再取消確認了
#160125-00025#2  2016/01/26 By earl       整理條碼產生邏輯
#160222-00005#1  2016/02/24 By lixiang    據參數"採購市價更新原則"(S-BAS-0020)更新料件的採購市價
#160222-00021#1  2016/03/04 By lixiang    修正報錯信息內容錯誤的問題
#160222-00022#1  2016/03/04 By lixiang    修正報錯信息內容錯誤的問題
#160225-00023#1  2016/03/14 By Polly      計算採購已收貨數量之最小套數調整為已入庫量之最小套數
#160316-00006#1  2016/03/16 By lixiang    回寫工單的委外加工量時，需加上作業編號、作業序條件
#150702-00012#1  2016/03/23 By xianghui   当采购单价来源为合约单时，如果有累计量定价，当达到设定的到达数量时
#                                         回写采购单单号和日期到采购合约单的累计量定价页签
#160328-00029#2  2016/03/31 By Jessy      將重複內容的錯誤訊息置換為公用錯誤訊息
#160512-00016#18 2016/05/27 By lixiang    因為s_asft300_02_bom增加參數，所以call s_asft300_02_bom的地方，多加保稅否欄位 pmdn021
#160602-00002#1  2016/06/02 By lixiang    重复性生产委外采购功能完善
#160323-00011#1  2016/06/16 By Ann_Huang  1.若採購料件的子件特性選擇CKD或SKD,交期明細不會產生,取消原本mark的s_apmt500_ins_pmdo_2與s_apmt500_ins_pmdo_4段落
#                                         2.修正s_apmt500_get_pmdo022(),若選擇[2.最近採購單價],取的欄位(imai211)不存在,應修正為imai021
#160324-00038#39  2016/07/12 By lixiang   增加开帐作业中使用的function
#160621-00003#3   2016/07/28 By 06814     通路改為非必輸
#160727-00025#9   2016/09/01 By lixiang   工單轉請購時，須檢核不可超過工單總應發數量
#160829-00037#1   2016/10/10 By lixiang   單據別參數設置為請採勾稽，採購數量需在該項次之關聯單據的請採勾稽允許數量之內   
#161018-00054#1   2016/10/19 By shiun     s_apmt500_stus_abg()段少了以下幾個固定核算項欄位值的處理
#161128-00011#1   2016/11/28 By lixiang   将apmt500中的function apmt500_adjust_pmdn搬到元件中
#161115-00029#2   2016/12/01 By xujing    在aqci050的檢驗程式中增加選項"X.除名"，apmt500在判斷料件承認(bmif_t)時，多串這裡，為X除名的供應商也不行
#161124-00048#9   2016/12/19 By zhujing   .*整批调整
#161205-00025#2   2016/12/22  By lixiang  效能优化
#161228-00036#1   2016/12/29 By dujuan    工单转采购送货地址没值
#161229-00014#1   2016/12/29 By dujuan    委外採購作業(apmt501)該料件有分採購單位(PNL)和計價單位(KG)，但轉出的委外採購單計價單位為PNL錯誤，
#161221-00064#5   2017/01/10 By zhujing   增加pmao000(1-采购，2-销售),用于区分axmi120和apmi120数据显示
#170111-00058#1   2017/01/12 By ouhz      调整审核后更新采购最近价格值错误问题
#170111-00026#7   2017/01/17 By 08993     修改"折合採購量"總和為"需求數量"總和
#161216-00014#1   2017/01/17 By 02040     預先採購單不處理信用額度相關動作
#170120-00035#1   2017/01/20 By Whitney   多帳期預付款金額檢核
#170123-00058#1   2017/01/24 By wuxja     委外采购数量检核时不应再考虑委外完工数量
#170111-00017#1   2017/01/25 By lixiang   新增s_apmt500_ws_postprocess() 给签核流程时处理多角自動拋轉
#170208-00026#1   2017/02/09 By wuxja     单据作废时，工单委外对应料号是一般或者联产品时才会去回写制程档
#160726-00020#20  2017/02/08  By xujing   将g_xxxx变了定义成global
#170207-00018#4   2017/02/13  By 08734    ROWNUM整批调整
#170217-00049#2   2017/02/28  By 08734    ent整批调整
#170302-00017#1   2017/03/02  By Whitney  pmdo040預設0
#170303-00015#1   2017/03/06  By ywtsai   修改產生協作據點訂單時，於呼叫s_apmt500_ins_xmda前須先取得工單的協作據點(sfaa018)資料
#170306-00052#1   2017/03/07  By 07491    採購單自動確認，s_apmt500_ws_postprocess()多角拋轉失敗的處理  
#170301-00021#8   2017/03/07  By 09263    g_prog整批調整
#170321-00041#1   2017/03/22  By lixiang  请采勾稽差异处理方式设为警告的时候，超过最大容差率的资料还是可以审核的，但需弹窗警告
#170324-00115#1   2017/03/27  By catmoon  當工單單號已存在於委外採購單且為作廢狀態時，需抓取新的採購單號
#170325-00090#1   2017/03/28  by 08172    產生委外採購時，要把bom特性帶到pmdp011
#170322-00052#2   2017/03/28  By Mars     新增與EBCHAIN整合相關程式段落
#170214-00015#4   2017/03/29  By Nina     1.增加若pmds056欄位不為空，則不可作廢及刪除單據資料
#                                         2.若與MES整合且為委外採購，則排序則須依接收XML的順序(順序值放在sfcb004)
#170605-00038#1   2017/06/06  By lixiang  写入xrcd时，需传入当前画面上的汇率
#170710-00026#1   2017/07/10  By Whitney  修正170605-00038應考慮批次調用s_apmt500_get_amount()的情境
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="s_apmt500.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="s_apmt500.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
GLOBALS      #160726-00020#20 add
DEFINE g_sql            STRING
DEFINE  g_ooef016      LIKE ooef_t.ooef016            #取本幣 
DEFINE  g_pmaw001      LIKE pmaw_t.pmaw001            #銷售價格參照表號 
DEFINE  g_bmba         DYNAMIC ARRAY OF RECORD        
          bmba001        LIKE bmba_t.bmba001,         #主件料號   
          bmba002        LIKE bmba_t.bmba002,         #特性
          bmba003        LIKE bmba_t.bmba003,         #元件料號
          bmba004        LIKE bmba_t.bmba004,         #部位編號
          bmba005        DATETIME YEAR TO SECOND,     #生效日期時間
          bmba007        LIKE bmba_t.bmba007,         #作業編號
          bmba008        LIKE bmba_t.bmba008,         #作業序
          bmba035        LIKE bmba_t.bmba035,         #保稅否  #160512-00016#18
          l_bmba011      LIKE bmba_t.bmba011,         #組成用量：QPA分子，对应于原始的主件料号
          l_bmba012      LIKE bmba_t.bmba012,         #主件底數：QPA分母，对应于原始的主件料号
          l_inam002      LIKE inam_t.inam002          #元件對應的產品特徵
                       END RECORD                               
DEFINE g_pmdl015       LIKE pmdl_t.pmdl015            #幣別
DEFINE g_pmdl016       LIKE pmdl_t.pmdl016            #匯率  
END GLOBALS  #160726-00020#20 add
#end add-point
 
{</section>}
 
{<section id="s_apmt500.other_dialog" >}

 
{</section>}
 
{<section id="s_apmt500.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 採購單維護作業確認前檢核
# Memo...........:
# Usage..........: CALL s_apmt500_conf_chk(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_conf_chk(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE l_pmdlstus      LIKE pmdl_t.pmdlstus
DEFINE l_pmdl002       LIKE pmdl_t.pmdl002
DEFINE l_pmdl003       LIKE pmdl_t.pmdl003
DEFINE l_pmdldocdt     LIKE pmdl_t.pmdldocdt
DEFINE l_n             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_ooba002       LIKE ooba_t.ooba002
DEFINE l_pmdnseq       LIKE pmdn_t.pmdnseq
DEFINE r_success       LIKE type_t.num5
DEFINE l_pmdn007       LIKE pmdn_t.pmdn007
DEFINE l_pmdo006       LIKE pmdo_t.pmdo006
DEFINE l_pmdm005       LIKE pmdm_t.pmdm005
DEFINE l_pmdm006       LIKE pmdm_t.pmdm006
DEFINE l_pmdn046       LIKE pmdn_t.pmdn046
DEFINE l_pmdn047       LIKE pmdn_t.pmdn047
DEFINE l_pmdl017       LIKE pmdl_t.pmdl017
DEFINE l_pmam006       LIKE pmam_t.pmam006
DEFINE l_pmdn015       LIKE pmdn_t.pmdn015
DEFINE l_pmdn019       LIKE pmdn_t.pmdn019
DEFINE l_pmdl013       LIKE pmdl_t.pmdl013
DEFINE l_pmdl051       LIKE pmdl_t.pmdl051   #150917-00001#4 151124 earl add
DEFINE l_pmdl004       LIKE pmdl_t.pmdl004
DEFINE l_pmdn001       LIKE pmdn_t.pmdn001
DEFINE l_pmdn002       LIKE pmdn_t.pmdn002
DEFINE l_pmdn004       LIKE pmdn_t.pmdn004
DEFINE l_pmdn005       LIKE pmdn_t.pmdn005 
#ming 20150904 add ---------------------------(S) 
DEFINE l_slip          LIKE pmdl_t.pmdldocno
DEFINE l_abg_flag      LIKE type_t.num5
DEFINE l_pmdn058       LIKE pmdn_t.pmdn058
#ming 20150904 add ---------------------------(E) 
DEFINE l_sum_pmdp023   LIKE pmdp_t.pmdp023    #160829-00037#1
DEFINE l_rate          LIKE type_t.num5       #160829-00037#1
DEFINE l_bas_0061      LIKE type_t.chr80      #161205-00025#2
DEFINE l_bas_0084      LIKE type_t.chr80      #170321-00041#1

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_pmdlstus = ''
   SELECT pmdlstus INTO l_pmdlstus FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF l_pmdlstus = 'Y' THEN
      #此筆資料已經確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00178'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_pmdlstus = 'X' THEN
      #此筆資料已經作廢;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   #ming 20150903 add ----------------------(S) 
   #科目預算 
   CALL s_aooi200_get_slip(p_pmdldocno)
        RETURNING l_success,l_slip
   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'Y' THEN
      LET l_abg_flag = TRUE
   ELSE
      LET l_abg_flag = FALSE
   END IF
   #ming 20150903 add ----------------------(E) 

   LET l_pmdl002 = ''
   LET l_pmdl003 = ''
   LET l_pmdldocdt = ''
   LET l_pmdl017 = ''
   LET l_pmdl004 = ''
   SELECT pmdl002,pmdl003,pmdldocdt,pmdl017,pmdl004,
          pmdl051   #150917-00001#4 151124 earl add
     INTO l_pmdl002,l_pmdl003,l_pmdldocdt,l_pmdl017,l_pmdl004,
          l_pmdl051 #150917-00001#4 151124 earl add
     FROM pmdl_t 
    WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
    
   #檢查單頭[C:申請人員]是否有輸入或是有效
   IF NOT cl_null(l_pmdl002) THEN 
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = l_pmdl002
      LET g_errshow = TRUE                                                                                                #160328-00029#2 add
      LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130" #160328-00029#2 add
      
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooag001") THEN
         #檢查成功時後續處理
                      
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      #申請人員未輸入！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00283'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #檢查單頭[C:申請部門]是否有輸入或是有效
   IF NOT cl_null(l_pmdl003) THEN 
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = l_pmdl003
      LET g_chkparam.arg2 = l_pmdldocdt

         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooeg001_2") THEN
         #檢查成功時後續處理

      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF 
   ELSE
      #申請部門未輸入！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00284'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF 
   
   #檢查單身是否有資料，如果沒有錯誤訊息「未輸入單據明細，不可進行確認」
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   IF l_n = 0 OR l_n IS NULL THEN
      #未輸入單據明細，不可進行確認
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00285'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   
   #必要字段欄位不可為空
   IF NOT s_apmt500_conf_fields_chk(p_pmdldocno) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   

   ##檢查對應的請購資料是否已經結案，若已結案則不允許確認成功
   #LET l_n = 0
   #SELECT COUNT(pmdbdocno) INTO l_n FROM pmdb_t,pmdp_t WHERE pmdbent = pmdpent AND pmdbsite = pmdpsite 
   #   AND pmdbdocno = pmdp003 AND pmdbseq = pmdp004 AND pmdb032 <> '1' AND pmdpdocno = p_pmdldocno 
   #IF l_n > 0 THEN
   #   #單身來源的請購單號中存在已經結案的資料，不可進行確認
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'sub-00325'
   #   LET g_errparam.extend = p_pmdldocno
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   #161205-00025#2--s
   LET l_bas_0061 = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0061')
   
   #最大容差率
   LET l_rate = cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0085')
   #161205-00025#2---e      
   
   LET l_bas_0084 = cl_get_doc_para(g_enterprise,g_site,l_slip,'D-BAS-0084') #170321-00041#1 add
   
   #取得價格是否允許單價為0
   LET l_pmam006 = ''
   SELECT pmam006 INTO l_pmam006 FROM pmam_t       
    WHERE pmament = g_enterprise AND pmam001 = l_pmdl017   
   
   #如果請采購勾稽時，採購項次必須有對應的關聯單據
   #採購單身資料的數量 與 多交期數量總和 一致
   #ming 20150903 modify -----------------------------(S) 
   #DECLARE pmdn_cur CURSOR FOR
   #      SELECT pmdnseq,pmdn007,pmdn015,pmdn019,pmdn001,pmdn002,pmdn004,pmdn005 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   DECLARE pmdn_cur CURSOR FOR SELECT pmdnseq,pmdn007,pmdn015,pmdn019,
                                      pmdn001,pmdn002,pmdn004,pmdn005,
                                      pmdn058
                                 FROM pmdn_t
                                WHERE pmdnent = g_enterprise
                                  AND pmdndocno = p_pmdldocno
   #ming 20150903 modify -----------------------------(E) 
   
   #CALL cl_err_collect_init()
   
   #ming 20150903 modify -----------------------------(S) 
   #FOREACH pmdn_cur INTO l_pmdnseq,l_pmdn007,l_pmdn015,l_pmdn019,l_pmdn001,l_pmdn002,l_pmdn004,l_pmdn005
   FOREACH pmdn_cur INTO l_pmdnseq,l_pmdn007,l_pmdn015,l_pmdn019,
                         l_pmdn001,l_pmdn002,l_pmdn004,l_pmdn005,
                         l_pmdn058
   #ming 20150903 modify -----------------------------(E) 
   
      #151229 earl add s
      #多角製造批序號檢查
      IF NOT s_apmt500_inao_chk(p_pmdldocno,'',l_pmdn001) THEN
         LET r_success = FALSE
      END IF
      #151229 earl add e
   
      #161205-00025#2--s
      #CALL s_aooi200_get_slip(p_pmdldocno) RETURNING l_success,l_ooba002
      #IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0061') = "Y" THEN
      IF l_bas_0061 = "Y" THEN
      #161205-00025#2
         LET l_n = 0
         SELECT COUNT(*) INTO l_n FROM pmdp_t 
           WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = l_pmdnseq
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00293'
            LET g_errparam.extend = l_pmdnseq
            LET g_errparam.popup = TRUE
            CALL cl_err()

            LET r_success = FALSE
            #RETURN r_success
         END IF
         
         #160829-00037#1---s---
         #單據別參數設置為請採勾稽，採購數量需在該項次之關聯單據的請採勾稽允許數量之內         
         LET l_sum_pmdp023 = 0
#         SELECT SUM(pmdp024) INTO l_sum_pmdp023     #170111-00026#7 mark
         SELECT SUM(pmdp023) INTO l_sum_pmdp023      #170111-00026#7 add
           FROM pmdp_t
          WHERE pmdpent   = g_enterprise
            AND pmdpdocno = p_pmdldocno
            AND pmdpseq   = l_pmdnseq
         IF cl_null(l_sum_pmdp023) THEN
            LET l_sum_pmdp023 = 0
         END IF
         #最大容差率
         #CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0085') RETURNING l_rate  #161205-00025#2
         IF l_rate > 0 THEN
            LET l_sum_pmdp023 = (1 + l_rate /100) * l_sum_pmdp023
         END IF           
         IF l_pmdn007 > l_sum_pmdp023 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_pmdnseq
            LET g_errparam.code   = 'apm-01118'    
            #單據別參數設置為請採勾稽，該項次之關聯單據需求數量須與採購數量相同！
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            IF l_bas_0084 = '1' THEN #拒绝   #170321-00041#1 add
               LET r_success = FALSE
            END IF        #170321-00041#1 add         
         END IF
         #160829-00037#1---e---
      END IF
      
      #SELECT SUM(pmdo006) INTO l_pmdo006 FROM pmdo_t
      #    WHERE pmdoent = g_enterprise AND pmdodocno = p_pmdldocno AND pmdoseq = l_pmdnseq  
      #IF l_pmdo006 <> l_pmdn007 THEN
      #   INITIALIZE g_errparam TO NULL
      #   LET g_errparam.code = 'apm-00595'
      #   LET g_errparam.extend = l_pmdnseq
      #   LET g_errparam.popup = TRUE
      #   CALL cl_err()
      #
      #   LET r_success = FALSE
      #   RETURN r_success 
      #END IF
      #若有使用多交期，則採購明細的數量 與 多交期匯總檔數量的總合 要一樣
      #ps.不使用交期明細數量的總合來判斷，是因為可能有CKD、SKD或備品..等等加總的數量可能與採購明細數量不一致的情況
      SELECT SUM(pmdq002) INTO l_pmdo006 FROM pmdq_t
          WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdldocno AND pmdqseq = l_pmdnseq  
      IF l_pmdo006 <> l_pmdn007 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00595'
         LET g_errparam.extend = l_pmdnseq
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET r_success = FALSE
         #RETURN r_success 
      END IF
      
      #若單頭取價方式的基本資料設置單價不可為0時，則輸入的單價不可以為0,樣品除外
      IF l_pmam006 = 'N' AND l_pmdn015 <= 0 AND l_pmdn019 <> '9' THEN              
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00013'
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         #RETURN r_success 
      END IF 

      IF cl_null(l_pmdn015) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00635'
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         #RETURN r_success 
      END IF
      
      #檢查料件編號是否符合條件
      IF NOT s_apmt500_item_avl_chk(l_pmdldocdt,l_pmdn001,l_pmdn002,l_pmdn004,l_pmdn005,l_pmdl004,l_pmdn007,p_pmdldocno,l_pmdnseq) THEN  #add by lixiang 2015/10/15 l_pmdn007  #add by lixiang 2015/12/04 add pmdldocno，pmdnseq
         LET r_success = FALSE
         #RETURN r_success
      END IF
      
      #ming 20150903 add ---------------------------(S) 
      #科目預算 
      #單據別參數的「預算控管否」= 'Y' 時，單身的預算項目要輸入  
      IF l_abg_flag THEN
         IF cl_null(l_pmdn058) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = p_pmdldocno
            LET g_errparam.code   = 'apm-00989'     #預算項目不可為空！ 
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
      #ming 20150903 add ---------------------------(E) 
   
   END FOREACH
   
   #CALL cl_err_collect_show()
   
   IF NOT r_success THEN
      RETURN r_success
   END IF
   
   
   #若有維護多交期預付款，金額必須與整張採購單一致
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmdm_t WHERE pmdment = g_enterprise AND pmdmdocno = p_pmdldocno
   IF l_n > 0 THEN
      SELECT SUM(pmdm005),SUM(pmdm006) INTO l_pmdm005,l_pmdm006 FROM pmdm_t
        WHERE pmdment = g_enterprise AND pmdmdocno = p_pmdldocno
      SELECT SUM(pmdn046),SUM(pmdn047) INTO l_pmdn046,l_pmdn047 FROM pmdn_t
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
        
      SELECT pmdl013 INTO l_pmdl013 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
      #含稅時，比較整張單據的含稅金額，未稅時，比較未稅總金額
      IF l_pmdl013 = 'Y' THEN 
         IF l_pmdm006 <> l_pmdn047 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00588'
            LET g_errparam.extend = p_pmdldocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
        
            LET r_success = FALSE
            RETURN r_success 
         END IF
      #170120-00035#1-s
      #ELSE 
      #   IF l_pmdm005 <> l_pmdn046 THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = 'apm-00587'
      #      LET g_errparam.extend = p_pmdldocno
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #   
      #      LET r_success = FALSE
      #      RETURN r_success 
      #   END IF
      #170120-00035#1-e
      END IF
   END IF
   
     
   #呼叫信用額度檢核應用元件，檢核此交易是否會超限
   
   #若此筆交易超限時，需show訊息告知已超限並詢問是否要進行放行
   
   #執行確認的user有放行權限時(虛擬的action功能)則直接進行放行，若執行確認的user沒有放行權限時，
   #則開窗讓user輸入授權碼並呼叫檢核授權碼的的lib判斷是否合理，若合理則進行放行反之則進行留置
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業確認
# Memo...........:
# Usage..........: CALL s_apmt500_conf_upd(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........: 15/05/14 By Polly   確認段新增呼叫產生條碼處理機制
################################################################################
PUBLIC FUNCTION s_apmt500_conf_upd(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE l_pmdlcnfdt     DATETIME YEAR TO SECOND
DEFINE r_success       LIKE type_t.num5
DEFINE l_pmdp003       LIKE pmdp_t.pmdp003
DEFINE l_pmdp004       LIKE pmdp_t.pmdp004
DEFINE l_pmdn007       LIKE pmdn_t.pmdn007
DEFINE l_pmdl005       LIKE pmdl_t.pmdl005
DEFINE l_pmdl008       LIKE pmdl_t.pmdl008
DEFINE l_sfaa018       LIKE sfaa_t.sfaa018
DEFINE l_pmdn001       LIKE pmdn_t.pmdn001
DEFINE l_pmdn015       LIKE pmdn_t.pmdn015
DEFINE l_ooef016       LIKE ooef_t.ooef016
DEFINE l_pmdl054       LIKE pmdl_t.pmdl054
DEFINE l_pmdl015       LIKE pmdl_t.pmdl015
DEFINE l_scc40         LIKE type_t.chr2    #汇率类型
DEFINE l_rate          LIKE ooan_t.ooan005
DEFINE l_pmdn006       LIKE pmdn_t.pmdn006
DEFINE l_imaa006       LIKE imaa_t.imaa006
DEFINE l_success       LIKE type_t.num5
DEFINE l_pmdl004       LIKE pmdl_t.pmdl004
#161124-00048#9 mod-S
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_pmar012       LIKE pmar_t.pmar012    #採購單價
DEFINE l_pmar013       LIKE pmar_t.pmar013    #本幣單價
DEFINE l_pmar014       LIKE pmar_t.pmar014    #採購單位
DEFINE l_pmar015       LIKE pmar_t.pmar015    #採購數量
DEFINE l_pmar016       LIKE pmar_t.pmar016    #採購含稅金額  
DEFINE l_pmar017       LIKE pmar_t.pmar017    #採購未稅金額
DEFINE l_pmar018       LIKE pmar_t.pmar018    #參考單號
DEFINE l_oodbl004      LIKE oodbl_t.oodbl004  #稅別名稱
DEFINE l_oodb005       LIKE oodb_t.oodb005    #含稅否
DEFINE l_oodb006       LIKE oodb_t.oodb006    #稅率
DEFINE l_oodb011       LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定
DEFINE l_pmar000       LIKE pmar_t.pmar000    #委外否
DEFINE l_pmdy020       LIKE pmdy_t.pmdy020
DEFINE l_pmdy021       LIKE pmdy_t.pmdy021
DEFINE l_pmdy022       LIKE pmdy_t.pmdy022
DEFINE l_pmdy023       LIKE pmdy_t.pmdy023
DEFINE l_pmdy008       LIKE pmdy_t.pmdy008
DEFINE l_pmdldocdt     LIKE pmdl_t.pmdldocdt
DEFINE l_imai021       LIKE imai_t.imai021
DEFINE l_pmarcrtdt     DATETIME YEAR TO SECOND
DEFINE l_pmdl002       LIKE pmdl_t.pmdl002
DEFINE l_sfaastus      LIKE sfaa_t.sfaastus
DEFINE l_imai023       LIKE imai_t.imai023  #160222-00005#1
DEFINE l_old_pmdy020   LIKE pmdy_t.pmdy020  #150702-00012#1
DEFINE l_new_pmdy020   LIKE pmdy_t.pmdy020  #150702-00012#1
DEFINE l_bas_0020      LIKE type_t.chr80    #161205-00025#2


   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #產生信用評核異動明細檔:
   #1.若此單據沒有信用超限或是超限但允許放行時，則需呼叫產生信用評核異動明細產生異動明細檔
   #2.若此單據沒有信用超限或是超限但允許放行時，則需呼叫更交易對象信用餘額檔更新信用餘額檔
   #161216-00014#1-s-mark 
   #IF NOT s_apmt500_credit('1',p_pmdldocno) THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161216-00014#1-e-mark 
   #採購單留置:
   #1.開啟單頭留置原因讓user維護
   #2.更新採購單單頭的狀態碼更新為留置狀態
   #3.更新單身每一筆明細的行狀態更新成留置狀態

   #新增單據時，就會回寫已轉採購量，確認時不需要再更新
   ##更新請購單的已轉採購數量:
   ##1.依據採購關聯單據明細的資料回頭更新對應的請購單的已轉採購量，
   ##更新公式如下:[C:已轉採購量] = [C:已轉採購量] + pmdp023
   #LET l_pmdp003 = ''
   #LET l_pmdp004 = ''
   #LET l_pmdn007 = 0
   #DECLARE upd_pmdb_cur CURSOR FOR 
   #  #SELECT pmdn007,pmdp003,pmdp004
   #  SELECT pmdp024,pmdp003,pmdp004
   #    FROM pmdp_t,pmdn_t 
   #   WHERE pmdpent = pmdnent AND pmdpdocno = pmdndocno
   #     AND pmdpseq = pmdnseq AND pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno
   #FOREACH upd_pmdb_cur INTO l_pmdn007,l_pmdp003,l_pmdp004
   #   IF cl_null(l_pmdn007) THEN
   #      LET l_pmdn007 = 0
   #   END IF
   #   UPDATE pmdb_t SET pmdb049 = NVL(pmdb049,0) + l_pmdn007
   #      WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
   #   IF SQLCA.sqlcode THEN
   #      LET r_success = FALSE
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = SQLCA.sqlcode
   #      LET g_errparam.extend = "pmdb_t"
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      RETURN r_success
   #   END IF
   #END FOREACH
   
   #委外採購單確認時，如果來源工單的協作據點有輸入，則自動產生協作據點的訂單
   SELECT pmdl002,pmdl005,pmdl008,pmdldocdt
      INTO l_pmdl002,l_pmdl005,l_pmdl008,l_pmdldocdt
     FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   
  #161216-00014#1-s-add
   #信用額度處理
   IF l_pmdl005 <> '5' THEN     #預先採購單不需寫入信用額度
      IF NOT s_apmt500_credit('1',p_pmdldocno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
  #161216-00014#1-e-add 
   
   #160325-00034#1-add-(S)
   LET l_pmar000 = ''
   IF l_pmdl005 MATCHES '[25]' THEN
      LET l_pmar000 = 'Y'
   ELSE
      LET l_pmar000 = 'N'
   END IF
   #160325-00034#1-add-(E)
   IF l_pmdl005 = '2' THEN
      IF NOT cl_null(l_pmdl008) THEN
         SELECT sfaa018 INTO l_sfaa018 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_pmdl008
         IF NOT cl_null(l_sfaa018) THEN
            IF NOT s_apmt500_gen_order(p_pmdldocno) THEN
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
        
        #by wuxj 20150610 add    ---begin---        
        #委外采购单确认时，如果来源工单是未发放的，则更新为发放状态
         SELECT sfaastus INTO l_sfaastus FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_pmdl008
         IF l_sfaastus != 'F' THEN
            UPDATE sfaa_t SET sfaastus = 'F' WHERE sfaaent = g_enterprise AND sfaadocno = l_pmdl008
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'Upd sfaa_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()         
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
        #by wuxj 20150610 add    ---end---
        
      #ELSE
      #   #根據單身中的來源單號
      #   DECLARE pmdp003_cur CURSOR FOR SELECT DISTINCT pmdp003 FROM pmdp_t WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno
      #   FOREACH pmdp003_cur INTO l_pmdp003
      #      SELECT sfaa018 INTO l_sfaa018 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = l_pmdl008
      #      IF NOT cl_null(l_sfaa018) THEN
      #         IF NOT s_apmt500_gen_order(p_pmdldocno) THEN
      #            LET r_success = FALSE
      #            RETURN r_success
      #         END IF
      #      END IF
      #   END FOREACH
      END IF
   END IF
   
   #更新價格檔:
   #1.呼叫更新銷售/採購價格檔應用元件，更新相關價格資訊
   LET l_ooef016 = ''
   SELECT ooef016 INTO l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooefstus = 'Y'  AND ooef001 = g_site
   #依據傳入內外購參數判斷匯率的來源
   SELECT pmdl004,pmdl054,pmdl015 INTO l_pmdl004,l_pmdl054,l_pmdl015 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   LET l_scc40 = ''
   CASE l_pmdl054
      WHEN '1'  #內購外幣採用匯率類型
         CALL cl_get_para(g_enterprise,g_site,'S-BAS-0014') RETURNING l_scc40
      WHEN '2'  #外購外幣採用匯率類型
         CALL cl_get_para(g_enterprise,g_site,'S-BAS-0015') RETURNING l_scc40
      OTHERWISE EXIT CASE
   END CASE   
   
   #161205-00025#2--s
   LET l_rate = ''
   CALL s_aooi160_get_exrate('1',g_site,l_pmdldocdt,l_pmdl015,l_ooef016,0,l_scc40) RETURNING l_rate
   
   LET l_bas_0020 = cl_get_para(g_enterprise,g_site,'S-BAS-0020') 
   #161205-00025#2--e
      
   #161124-00048#9 mod-S
#   DECLARE upd_imai_cur CURSOR FOR 
#      SELECT * FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   DECLARE upd_imai_cur CURSOR FOR 
      SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
             pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
             pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
             pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
             pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
             pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
             pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
             pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
             pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
             pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
             pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
             pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
             pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
             pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
             pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
             pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
             pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
             pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
             pmdn226,pmdn227,pmdn058,pmdn228
        FROM pmdn_t 
       WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   #161124-00048#9 mod-E
   FOREACH upd_imai_cur INTO l_pmdn.*
      
      LET l_pmar012 = l_pmdn.pmdn015
      #將單價轉換成本國幣的單價
      #161205-00025#2--s
      #LET l_rate = ''
      #CALL s_aooi160_get_exrate('1',g_site,l_pmdldocdt,l_pmdl015,l_ooef016,0,l_scc40) RETURNING l_rate
      #161205-00025#2--e
      
      IF NOT cl_null(l_rate) THEN
         LET l_pmar013 = l_pmar012 * l_rate
         CALL s_curr_round(g_site,l_ooef016,l_pmar013,'1') RETURNING l_pmar013
      END IF
      IF cl_null(l_pmar013) THEN LET l_pmar013 = l_pmar012 END IF
      
      #取稅率、單價含稅否
      CALL s_tax_chk(g_site,l_pmdn.pmdn016)
           RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011  
      
      LET l_pmar014 = l_pmdn.pmdn010
      LET l_pmar015 = l_pmdn.pmdn011
      LET l_pmar016 = l_pmdn.pmdn047
      LET l_pmar017 = l_pmdn.pmdn046
      LET l_pmar018 = p_pmdldocno
      #160325-00034#1-mark-(S)
#      IF g_argv[1] = '1' THEN   #委外採購
#         LET l_pmar000 = 'Y'
#      ELSE
#         LET l_pmar000 = 'N'
#      END IF
      #160325-00034#1-mark-(E)

      #更新供應商料件一般採購價格維護apmi125或委外採購價格apmi126
      IF cl_null(l_pmdn.pmdn002) THEN
         LET l_pmdn.pmdn002 = ' '
      END IF
      
      IF cl_null(l_pmdn.pmdn004) THEN
         LET l_pmdn.pmdn004 = ' '
      END IF
      IF cl_null(l_pmdn.pmdn005) THEN
         LET l_pmdn.pmdn005 = ' '
      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt      
       FROM pmar_t
      WHERE pmarent = g_enterprise
        AND pmarsite = g_site
        AND pmar000 = l_pmar000          
        AND pmar001 = l_pmdl004
        AND pmar002 = l_pmdn.pmdn001
        AND pmar003 = l_pmdn.pmdn002
        AND pmar004 = l_pmdn.pmdn004
        AND pmar005 = l_pmdn.pmdn005
        AND pmar006 = l_pmdn.pmdn010
        AND pmar007 = l_pmdl015
        AND pmar009 = l_pmdn.pmdn016   

      IF l_cnt > 0 THEN
         UPDATE pmar_t
            SET pmar012 = l_pmar012,
                pmar013 = l_pmar013,
                pmar014 = l_pmar014,
                pmar015 = l_pmar015,
                pmar016 = l_pmar016,
                pmar017 = l_pmar017,
                pmar018 = l_pmar018,
                pmar019 = l_pmdldocdt,
                pmar020 = l_pmdl002
          WHERE pmarent = g_enterprise
            AND pmarsite = g_site
            AND pmar000 = l_pmar000          
            AND pmar001 = l_pmdl004
            AND pmar002 = l_pmdn.pmdn001
            AND pmar003 = l_pmdn.pmdn002
            AND pmar004 = l_pmdn.pmdn004
            AND pmar005 = l_pmdn.pmdn005
            AND pmar006 = l_pmdn.pmdn010
            AND pmar007 = l_pmdl015
            AND pmar009 = l_pmdn.pmdn016 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "UPDATE pmar_t"            
            LET g_errparam.popup  = FALSE
            CALL cl_err()         
            LET r_success = FALSE
            EXIT FOREACH
         END IF            
      ELSE
         LET l_pmarcrtdt = cl_get_current()
         INSERT INTO pmar_t
                     (pmarent, pmarsite,  pmar000,  pmar001,pmar002,
                      pmar003,  pmar004,  pmar005,  pmar006,pmar007,  
                      pmar008,  pmar009,  pmar010,  pmar011,pmar012,  
                      pmar013,  pmar014,  pmar015,  pmar016,pmar017,
                      pmar018,  pmar019,  pmar020,pmarownid,pmarowndp,
                      pmarcrtid,pmarcrtdp,pmarcrtdt,pmarstus)
              VALUES (g_enterprise,g_site,l_pmar000,l_pmdl004,l_pmdn.pmdn001,
                      l_pmdn.pmdn002,l_pmdn.pmdn004,l_pmdn.pmdn005,l_pmdn.pmdn010,l_pmdl015,
                      l_rate,l_pmdn.pmdn016,l_oodb005,l_oodb006,l_pmar012,
                      l_pmar013,l_pmar014,l_pmar015,l_pmar016,l_pmar017,
                      l_pmar018,l_pmdldocdt,l_pmdl002,g_user,g_dept,
                      g_user,g_dept,l_pmarcrtdt,'Y')
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.extend = "INSERT pmar_t"            
            LET g_errparam.popup  = FALSE
            CALL cl_err() 
            LET r_success = FALSE            
            EXIT FOREACH 
         END IF   
      END IF
      
      
      #更新回料件主檔的最近採購單價時需轉換成基礎單位的價格
      SELECT imaa006 INTO l_imaa006 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = l_pmdn.pmdn001
      IF l_imaa006 <> l_pmdn.pmdn010 THEN
         #LET l_rate = ''    #170111-00058#1 mark
         #CALL s_aimi190_get_convert(l_pmdn.pmdn001,l_pmdn.pmdn010,l_imaa006) RETURNING l_success,l_rate
         #LET l_pmar013 = l_pmar013 * l_rate
         #CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn010,l_imaa006,l_pmar013)
         CALL s_aooi250_convert_qty1(l_pmdn.pmdn001,l_imaa006,l_pmdn.pmdn010,l_pmar013)
              RETURNING l_success,l_pmar013
      END IF
      
      ##取到的最近採購單價為本國幣的單價，將其轉成交易幣別的單價
      #LET l_rate = ''
      #CALL s_aooi160_get_exrate('1',g_site,g_today,l_pmdl015,l_ooef016,0,l_scc40) RETURNING l_rate
      #IF NOT cl_null(l_rate) THEN
      #   LET l_pmdn015 = l_pmdn015 * l_rate
      #   CALL s_curr_round(g_site,l_pmdl015,l_pmdn015,'1') RETURNING l_pmdn015
      #END IF
      
      LET l_imai021 = l_pmar013
      
      #单价含税时，换算成未税单价，回写到最近采购单价中
      IF l_oodb005 = 'Y' THEN
         LET l_imai021 = l_imai021 / (1 + (l_oodb006 / 100))
      END IF
      
      CALL s_curr_round(g_site,l_ooef016,l_imai021,'1') RETURNING l_imai021
      
      UPDATE imai_t SET imai021 = l_imai021,imai025 = l_pmdldocdt,imai035 = l_pmdldocdt,imai101 = l_pmdldocdt,imai102 = p_pmdldocno
         WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_pmdn.pmdn001
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "imai_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
      
      #160222-00005#1--add--begin---
      #根據參數"採購市價更新原則"(S-BAS-0020)更新料件的採購市價
      #1.最近采购單更新
      #161205-00025#2--s
      #IF cl_get_para(g_enterprise,g_site,'S-BAS-0020') = '1' THEN 
      IF l_bas_0020 = '1' THEN 
      #161205-00025#2--e
         UPDATE imai_t SET imai023 = l_imai021,imai024 = l_pmdldocdt
            WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_pmdn.pmdn001
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "imai_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
      END IF
      #2.採購價格低時更新
      #161205-00025#2--s
      #IF cl_get_para(g_enterprise,g_site,'S-BAS-0020') = '2' THEN
      IF l_bas_0020 = '2' THEN 
      #161205-00025#2--e
         SELECT imai023 INTO l_imai023 FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_pmdn.pmdn001
         IF cl_null(l_imai023) THEN
            LET l_imai023 = 0
         END IF
         IF l_imai021 < l_imai023 OR l_imai023 = 0 THEN
            UPDATE imai_t SET imai023 = l_imai021,imai024 = l_pmdldocdt
               WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = l_pmdn.pmdn001
            IF SQLCA.sqlcode THEN
               LET r_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "imai_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN r_success
            END IF
         END IF
      END IF
      
      #160222-00005#1---add---end----
      
      #判斷採購取價來源若為合約單時，在採購單確認時需累加回寫合約單上的累積量與金額，
      #反之取消確認時需要累減回寫合約單上的量與金額(需轉換成合約單上的單位)
      IF l_pmdn.pmdn040 = '7' THEN
         SELECT pmdy008 INTO l_pmdy008 FROM pmdy_t 
              WHERE pmdyent = g_enterprise AND pmdydocno = l_pmdn.pmdn041 AND pmdyseq = l_pmdn.pmdn042
         IF l_pmdy008 <> l_pmdn.pmdn006 THEN
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn007)
              RETURNING l_success,l_pmdy020
            IF cl_null(l_pmdy020) THEN
               LET l_pmdy020 = 0
            END IF
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn046)
              RETURNING l_success,l_pmdy021
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn047)
              RETURNING l_success,l_pmdy022
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn048)
              RETURNING l_success,l_pmdy023
            IF cl_null(l_pmdy021) THEN
               LET l_pmdy021 = 0
            END IF
            IF cl_null(l_pmdy022) THEN
               LET l_pmdy022 = 0
            END IF
            IF cl_null(l_pmdy023) THEN
               LET l_pmdy023 = 0
            END IF
         ELSE
            LET l_pmdy020 = l_pmdn.pmdn007
            LET l_pmdy021 = l_pmdn.pmdn046
            LET l_pmdy022 = l_pmdn.pmdn047
            LET l_pmdy023 = l_pmdn.pmdn048
         END IF
         #150702-00012#1---add---begin
         SELECT pmdy020 INTO l_old_pmdy020
           FROM pmdy_t
          WHERE pmdyent = g_enterprise 
            AND pmdydocno = l_pmdn.pmdn041 
            AND pmdyseq = l_pmdn.pmdn042
         IF cl_null(l_old_pmdy020) THEN LET l_old_pmdy020 = 0 END IF
         #150702-00012#1---add---end          
         UPDATE pmdy_t SET pmdy020 = pmdy020 + l_pmdy020,
                           pmdy021 = pmdy021 + l_pmdy021,
                           pmdy022 = pmdy022 + l_pmdy022,
                           pmdy023 = pmdy023 + l_pmdy023
              WHERE pmdyent = g_enterprise AND pmdydocno = l_pmdn.pmdn041 AND pmdyseq = l_pmdn.pmdn042
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdy_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF
         #150702-00012#1---add---begin
         SELECT pmdy020 INTO l_new_pmdy020
           FROM pmdy_t
          WHERE pmdyent = g_enterprise 
            AND pmdydocno = l_pmdn.pmdn041 
            AND pmdyseq = l_pmdn.pmdn042
         IF cl_null(l_new_pmdy020) THEN LET l_new_pmdy020 = 0 END IF
         UPDATE pmdz_t 
            SET pmdz004 = l_pmdldocdt,
                pmdz005 = p_pmdldocno
          WHERE pmdzent = g_enterprise 
            AND pmdzdocno = l_pmdn.pmdn041 
            AND pmdzseq = l_pmdn.pmdn042
            AND pmdz001 > l_old_pmdy020 
            AND pmdz001 < = l_new_pmdy020
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdz_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF         
         #150702-00012#1---add---end           
      END IF
      
      #預先採購在審核時，不需回寫專案編號的金額欄位
      IF l_pmdl005 <> '4' THEN
         #回寫apjm210中相關金額欄位
         IF NOT s_apmt500_upd_apj('1',l_pmdldocdt,l_pmdn.pmdn036,l_pmdn.pmdn037,l_pmdn.pmdn047,l_pmdl015,l_pmdl054) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END FOREACH

   #更新單據狀態碼
   LET l_pmdlcnfdt = cl_get_current()
   UPDATE pmdl_t SET pmdlstus = 'Y',
                     pmdlcnfid = g_user,
                     pmdlcnfdt = l_pmdlcnfdt
    WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 
   
   #ming 20150903 add --------------------------(S) 
   #科目預算 
   CALL s_apmt500_stus_abg1(p_pmdldocno,'Y')
        RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #ming 20150903 add --------------------------(E) 
   
   #160125-00025#2  2016/01/26  By earl mod s
   #產生條碼
   IF r_success THEN
      IF NOT s_barcode('1',g_prog,g_site,p_pmdldocno,l_pmdl004) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   #160125-00025#2  2016/01/26  By earl mod e

   #170322-00052#2 add - str -
   IF cl_get_para(g_enterprise,g_site,"S-SYS-0006") = "Y" THEN
      UPDATE pmdl_t SET pmdl057 = 'Y'
       WHERE pmdldocno = p_pmdldocno
         AND pmdlent = g_enterprise
         AND pmdlsite = g_site      

      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         RETURN r_success
      END IF 
      
      CALL s_jscli_ec01_purchase_create(p_pmdldocno) RETURNING l_success
      IF l_success THEN
         LET r_success = FALSE
      ELSE     
         LET g_errparam.code = 'axm-00824'
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = TRUE
         RETURN r_success
      END IF
   END IF
   #170322-00052#2 add - end -

   RETURN  r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業取消確認前檢核
# Memo...........:
# Usage..........: CALL s_apmt500_unconf_chk(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_unconf_chk(p_pmdldocno)
DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE l_pmdlstus        LIKE pmdl_t.pmdlstus
DEFINE l_n               LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5 
DEFINE l_pmdl007         LIKE pmdl_t.pmdl007
DEFINE l_pmdl031         LIKE pmdl_t.pmdl031
DEFINE l_pmdl057         LIKE pmdl_t.pmdl057  #170322-00052#2 add

   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_pmdlstus = ''
   LET l_pmdl007 = ''
   SELECT pmdlstus,pmdl007,pmdl031 INTO l_pmdlstus,l_pmdl007,l_pmdl031 FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF l_pmdlstus = 'N' THEN
      #此筆資料未確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00180'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_pmdlstus = 'X' THEN
      #此筆資料已經作廢;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #預採購單已存在有效的採購單，不可取消確認
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmdl
     WHERE pmdlent = g_enterprise AND pmdl008 = p_pmdldocno AND pmdlstus != 'X'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00620'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #若採購單已經有轉有效的收貨單，有則不允許取消確認成功，錯誤訊息「已轉收貨單，不可做取消確認」
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmdt_t,pmds_t
     WHERE pmdtent = pmdsent AND pmdtdocno = pmdsdocno
       AND pmdtent = g_enterprise AND pmdt001 = p_pmdldocno AND pmdsstus != 'X'
       AND pmds000 IN ('1','8','9','3','23','24','20')  #收貨單
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00432'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #若採購單已經有對應的有效採購單變更單時，則不允許取消確認成功，錯誤訊息「已有採購單變更單，不可做取消確認」
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pmee_t
     WHERE pmeeent = g_enterprise AND pmeedocno = p_pmdldocno AND pmeestus != 'X'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00433'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #採購單是否存在採購預設單aapt310
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM apca_t,apcb_t
     WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno 
       AND apcbent = g_enterprise AND apcb002 = p_pmdldocno AND apcastus != 'X'
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00888'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #add--151125-00005#1 By shiun--(S)
   #採購單的訂金如果已立帳，不能再取消確認了
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM pmdm_t
    WHERE pmdment = g_enterprise
      AND pmdmdocno = p_pmdldocno      #來源單號
      AND pmdm014 = '2' 
      AND pmdm007 IS NOT NULL
   IF l_n > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axm-00736'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success             
   END IF      
   #add--151125-00005#1 By shiun--(E)

   #170322-00052#2 add - str -
   IF cl_get_para(g_enterprise,g_site,"S-SYS-0006") = "Y" THEN
      SELECT pmdl057 INTO l_pmdl057
        FROM pmdl_t
       WHERE pmdldocno = p_pmdldocno
         AND pmdlent = g_enterprise
         AND pmdlsite = g_site   
         
      IF l_pmdl057 = "Y" THEN
         LET g_errparam.code = 'axm-00823'
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success            
      END IF
   END IF
   #170322-00052#2 add - end - 

   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業取消確認
# Memo...........:
# Usage..........: CALL s_apmt500_unconf_upd(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_unconf_upd(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE l_pmdp003       LIKE pmdp_t.pmdp003
DEFINE l_pmdp004       LIKE pmdp_t.pmdp004
DEFINE l_pmdn007       LIKE pmdn_t.pmdn007
DEFINE r_success       LIKE type_t.num5 
#161124-00048#9 mod-S
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_success       LIKE type_t.num5
DEFINE l_pmdy020       LIKE pmdy_t.pmdy020
DEFINE l_pmdy021       LIKE pmdy_t.pmdy021
DEFINE l_pmdy022       LIKE pmdy_t.pmdy022
DEFINE l_pmdy023       LIKE pmdy_t.pmdy023
DEFINE l_pmdy008       LIKE pmdy_t.pmdy008
DEFINE l_pmdl030       LIKE pmdl_t.pmdl030
DEFINE l_pmdl054       LIKE pmdl_t.pmdl054
DEFINE l_pmdl015       LIKE pmdl_t.pmdl015
DEFINE l_pmdldocdt     LIKE pmdl_t.pmdldocdt
DEFINE l_pmdl005       LIKE pmdl_t.pmdl005
DEFINE l_old_pmdy020   LIKE pmdy_t.pmdy020  #150702-00012#1
DEFINE l_new_pmdy020   LIKE pmdy_t.pmdy020  #150702-00012#1


   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #150625---earl---add---s
   #多角已拋轉不可直接取消確認(double chk故不寫在chk段)
   LET l_pmdl030 = ''
   SELECT pmdl030 INTO l_pmdl030
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = p_pmdldocno
      
   IF l_pmdl030 = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aic-00180'   #多角流程已拋轉之單據不可取消確認！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #150625---earl---add---e
   #161216-00014#1-s-mark
   #更新信用額度
   #IF NOT s_apmt500_credit('2',p_pmdldocno) THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161216-00014#1-e-mark
   #新增單據時，就會回寫已轉採購量，取消確認時不需要再更新
   ##更新請購單的已轉採購數量:
   ##1.依據採購關聯單據明細的資料回頭更新對應的請購單的已轉採購量，
   ##更新公式如下:[C:已轉採購量] = [C:已轉採購量] - pmdp023
   #LET l_pmdp003 = ''
   #LET l_pmdp004 = ''
   #LET l_pmdn007 = 0
   #DECLARE upd_pmdb_cur2 CURSOR FOR 
   #  #SELECT pmdn007,pmdp003,pmdp004
   #  SELECT pmdp024,pmdp003,pmdp004
   #    FROM pmdp_t,pmdn_t 
   #   WHERE pmdpent = pmdnent AND pmdpdocno = pmdndocno
   #     AND pmdpseq = pmdnseq AND pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno
   #FOREACH upd_pmdb_cur2 INTO l_pmdn007,l_pmdp003,l_pmdp004
   #   IF cl_null(l_pmdn007) THEN
   #      LET l_pmdn007 = 0
   #   END IF
   #   UPDATE pmdb_t SET pmdb049 = NVL(pmdb049,0) - l_pmdn007
   #      WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
   #   IF SQLCA.sqlcode THEN
   #      LET r_success = FALSE
   #      INITIALIZE g_errparam TO NULL
   #      LET g_errparam.code = 'sub-00034'
   #      LET g_errparam.extend = l_pmdp003
   #      LET g_errparam.popup = TRUE
   #      CALL cl_err()
   #
   #      RETURN r_success
   #   END IF
   #END FOREACH
   
   SELECT pmdldocdt,pmdl054,pmdl015,pmdl005 INTO l_pmdldocdt,l_pmdl054,l_pmdl015,l_pmdl005 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   #161216-00014#1-s-add
   #更新信用額度
   IF l_pmdl005 <> '5' THEN   #預先採購單不需處理信用額度
      IF NOT s_apmt500_credit('2',p_pmdldocno) THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF   
   #161216-00014#1-e-add  
   
   
   #161124-00048#9 mod-S
#   DECLARE upd_pmdb_cur2 CURSOR FOR 
#      SELECT * FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   DECLARE upd_pmdb_cur2 CURSOR FOR 
      SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
             pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
             pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
             pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
             pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
             pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
             pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
             pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
             pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
             pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
             pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
             pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
             pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
             pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
             pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
             pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
             pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
             pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
             pmdn226,pmdn227,pmdn058,pmdn228
        FROM pmdn_t 
       WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   #161124-00048#9 mod-E
   FOREACH upd_pmdb_cur2 INTO l_pmdn.*
      #判斷採購取價來源若為合約單時，在採購單確認時需累加回寫合約單上的累積量與金額，
      #反之取消確認時需要累減回寫合約單上的量與金額(需轉換成合約單上的單位)
      IF l_pmdn.pmdn040 = '7' THEN
         SELECT pmdy008 INTO l_pmdy008 FROM pmdy_t 
              WHERE pmdyent = g_enterprise AND pmdydocno = l_pmdn.pmdn041 AND pmdyseq = l_pmdn.pmdn042
         IF l_pmdy008 <> l_pmdn.pmdn006 THEN
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn007)
              RETURNING l_success,l_pmdy020
            IF cl_null(l_pmdy020) THEN
               LET l_pmdy020 = 0
            END IF
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn046)
              RETURNING l_success,l_pmdy021
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn047)
              RETURNING l_success,l_pmdy022
            CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdy008,l_pmdn.pmdn048)
              RETURNING l_success,l_pmdy023
            IF cl_null(l_pmdy021) THEN
               LET l_pmdy021 = 0
            END IF
            IF cl_null(l_pmdy022) THEN
               LET l_pmdy022 = 0
            END IF
            IF cl_null(l_pmdy023) THEN
               LET l_pmdy023 = 0
            END IF
         ELSE
            LET l_pmdy020 = l_pmdn.pmdn007
            LET l_pmdy021 = l_pmdn.pmdn046
            LET l_pmdy022 = l_pmdn.pmdn047
            LET l_pmdy023 = l_pmdn.pmdn048
         END IF
         #150702-00012#1---add---begin
         SELECT pmdy020 INTO l_old_pmdy020
           FROM pmdy_t
          WHERE pmdyent = g_enterprise 
            AND pmdydocno = l_pmdn.pmdn041 
            AND pmdyseq = l_pmdn.pmdn042
         IF cl_null(l_old_pmdy020) THEN LET l_old_pmdy020 = 0 END IF
         #150702-00012#1---add---end         
         UPDATE pmdy_t SET pmdy020 = pmdy020 - l_pmdy020,
                           pmdy021 = pmdy021 - l_pmdy021,
                           pmdy022 = pmdy022 - l_pmdy022,
                           pmdy023 = pmdy023 - l_pmdy023
              WHERE pmdyent = g_enterprise AND pmdydocno = l_pmdn.pmdn041 AND pmdyseq = l_pmdn.pmdn042
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdy_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
        
            RETURN r_success
         END IF
         #150702-00012#1---add---begin
         SELECT pmdy020 INTO l_new_pmdy020
           FROM pmdy_t
          WHERE pmdyent = g_enterprise 
            AND pmdydocno = l_pmdn.pmdn041 
            AND pmdyseq = l_pmdn.pmdn042
         IF cl_null(l_new_pmdy020) THEN LET l_new_pmdy020 = 0 END IF
         UPDATE pmdz_t 
            SET pmdz004 = '',
                pmdz005 = ''
          WHERE pmdzent = g_enterprise 
            AND pmdzdocno = l_pmdn.pmdn041 
            AND pmdzseq = l_pmdn.pmdn042
            AND pmdz001 > l_new_pmdy020 
            AND pmdz001 < = l_old_pmdy020
         IF SQLCA.sqlcode THEN
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "pmdz_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success
         END IF         
         #150702-00012#1---add---end          
      END IF
      
      #預先採購在審核時，不需回寫專案編號的金額欄位
      IF l_pmdl005 <> '4' THEN
         #回寫apjm210中相關金額欄位
         IF NOT s_apmt500_upd_apj('2',l_pmdldocdt,l_pmdn.pmdn036,l_pmdn.pmdn037,l_pmdn.pmdn047,l_pmdl015,l_pmdl054) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
   END FOREACH
   
   #更新單據狀態碼
   UPDATE pmdl_t SET pmdlstus = 'N',
                     pmdlcnfid = NULL,
                     pmdlcnfdt = NULL
    WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF 
   
   #ming 20150903 add ----------------------(S) 
   #科目預算 
   CALL s_apmt500_stus_abg1(p_pmdldocno,'N')
        RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #ming 20150903 add ----------------------(E) 
   
   #160125-00025#2  2016/01/26  By earl mod s
   #取消條碼
   IF r_success THEN
      IF NOT s_barcode('2',g_prog,g_site,p_pmdldocno,'') THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   #160125-00025#2  2016/01/26  By earl mod e

   RETURN  r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業作废前檢核
# Memo...........:
# Usage..........: CALL s_apmt500_invalid_chk(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_invalid_chk(p_pmdldocno)
DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE l_pmdlstus        LIKE pmdl_t.pmdlstus
DEFINE r_success         LIKE type_t.num5 
DEFINE l_pmdpseq         LIKE pmdp_t.pmdpseq
DEFINE l_pmdp003         LIKE pmdp_t.pmdp003
DEFINE l_pmdp004         LIKE pmdp_t.pmdp004
DEFINE l_pmdp023         LIKE pmdp_t.pmdp023
DEFINE l_pmdb049         LIKE pmdb_t.pmdb049
DEFINE l_pmdl056         LIKE pmdl_t.pmdl056  #170214-00015#4 

   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_pmdlstus = ''
   LET l_pmdl056 = ''   #170214-00015#4
   SELECT pmdlstus,pmdl056 INTO l_pmdlstus,l_pmdl056 FROM pmdl_t  #170214-00015#4 add pmdl056 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF l_pmdlstus = 'Y' THEN
      #此筆資料已經確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00178'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_pmdlstus = 'X' THEN
      #此筆資料已經作廢;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #170214-00015#4 str---
   #判斷據點參數若有勾選「是否啟用MES整合」且為委外採購
   IF cl_get_para(g_enterprise,g_site,'S-SYS-0003') = 'Y' AND g_prog = 'apmt501' THEN
      IF NOT cl_null(l_pmdl056) THEN  #pmdl056(MES單號)不為空
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'wss-00159'     #此资料来源为MES抛转，不可作废！
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
      END IF
   END IF
   #170214-00015#4 end---		
   
   DECLARE pmdn_cur3 CURSOR FOR
     SELECT pmdpseq,pmdp023,pmdp003,pmdp004 FROM pmdp_t
      WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno

   FOREACH pmdn_cur3 INTO l_pmdpseq,l_pmdp023,l_pmdp003,l_pmdp004
      #對應請購單的已轉採購量
      SELECT pmdb049 INTO l_pmdb049 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
      IF l_pmdb049 < l_pmdp023 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00821'
         LET g_errparam.extend = l_pmdpseq
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE                 
         #RETURN r_success
      END IF
   
   END FOREACH
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 自動產生採購單交期明細,依據採購單單身明細資訊自動產生對應的交期明細資料
# Memo...........:
# Usage..........: CALL s_apmt500_gen_pmdo (p_pmdodocno,p_pmdoseq)
#                  RETURNING r_success
# Input parameter: p_pmdodocno   採購單號
#                : p_pmdoseq     採購項次
# Return code....: r_success     TRUE/FALSE
# Date & Author..: 2014/1/20 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_pmdo(p_pmdodocno,p_pmdoseq)
DEFINE p_pmdodocno     LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq       LIKE pmdo_t.pmdoseq
DEFINE l_pmdn024       LIKE pmdn_t.pmdn024
DEFINE l_pmdn019       LIKE pmdn_t.pmdn019
DEFINE r_success       LIKE type_t.num5
DEFINE l_pmdo022       LIKE pmdo_t.pmdo022
DEFINE l_rate          LIKE ooan_t.ooan005 
DEFINE l_scc40         LIKE type_t.chr2       #匯率类型  
DEFINE l_total         LIKE xmdd_t.xmdd018
DEFINE l_cnt           LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
DEFINE l_type          LIKE type_t.chr1       #Y：展尾階S展單階
DEFINE l_i             LIKE type_t.num5
DEFINE l_pmdn001       LIKE pmdn_t.pmdn001
DEFINE l_pmdn002       LIKE pmdn_t.pmdn002
DEFINE l_pmdn006       LIKE pmdn_t.pmdn006
DEFINE l_pmdl054       LIKE pmdl_t.pmdl054
DEFINE l_pmdn021       LIKE pmdn_t.pmdn021  #160512-00016#18 add

       WHENEVER ERROR CONTINUE
       
       LET r_success = TRUE
       
       LET l_pmdn024 = ''
       LET l_pmdn019 = ''
       #SELECT pmdn024,pmdn019 INTO l_pmdn024,l_pmdn019 FROM pmdn_t
       #   WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       SELECT pmdl015,pmdl016,pmdl054,pmdn001,pmdn002,
              pmdn006,pmdn019,pmdn024,pmdn021  #160512-00016#18 add pmdn021
         INTO g_pmdl015,g_pmdl016,l_pmdl054,l_pmdn001,l_pmdn002,
              l_pmdn006,l_pmdn019,l_pmdn024,l_pmdn021  #160512-00016#18 add pmdn021
         FROM pmdl_t,pmdn_t
        WHERE pmdlent = pmdnent
          AND pmdldocno = pmdndocno
          AND pmdlent = g_enterprise
          AND pmdndocno = p_pmdodocno
          AND pmdnseq = p_pmdoseq 
       
       #依據傳入的採購單單號、採購單項次將其對應的交期明細資料(pmdo_t)刪除
       DELETE FROM pmdo_t 
          WHERE pmdoent = g_enterprise AND pmdodocno = p_pmdodocno AND pmdoseq = p_pmdoseq 
            AND pmdo003 <> '11'  #子特性為11拆件元件時，不需要異動
       
       #判斷若子件特性為'2:CKD'時需依據採購單號料展BOM取得最底階原物料清單與組成用量
       
       #判斷若子件特性為'3:SKD'時需開窗詢問展BOM階數，依據採購單號料與展階接數展BOM取得該階的半成品清單與組成用量
       #子件特性：CKD、SKD
       CALL g_bmba.clear()
       IF l_pmdn019 MATCHES '[23]' THEN
          IF l_pmdn019 = '2' THEN
             #子件特性為'2:CKD'時取最尾階
             LET l_type = 'Y'
          ELSE
             #子件特性為'3:SKD'時取單階
             LET l_type = 'S'
          END IF
          #取得BOM資料
          #160512-00016#18-----(S) 
          #CALL s_asft300_02_bom(0,l_pmdn001,'',l_pmdn006,1,1,'',l_type,'',l_pmdn002,'N') 
          #  RETURNING g_bmba
          CALL s_asft300_02_bom(0,l_pmdn001,'',l_pmdn006,1,1,'',l_type,'',l_pmdn002,'N',l_pmdn021) 
            RETURNING g_bmba
          ##160512-00016#18 -----(E) 
          IF g_bmba.getLength() = 0 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'sub-00500'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()             
             LET r_success = FALSE
             RETURN r_success
          END IF 
          #取價格比率：參考價格依主件單價(pmdn015)依據據點參數S-BAS-0023來推算比率                
          LET l_total  = 0
          IF cl_get_para(g_enterprise,g_site,'S-BAS-0022') = '1' THEN
             #取得採購價格參照表號
             LET g_pmaw001 = ''
             LET g_pmaw001 = cl_get_para(g_enterprise,g_site,'S-BAS-0021')
             IF cl_null(g_pmaw001) THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ''
                LET g_errparam.popup = TRUE
                CALL cl_err()             
                LET r_success = FALSE
                RETURN r_success
             END IF
             FOR l_i = 1 TO g_bmba.getLength()             
                 CALL s_apmt500_get_pmdo022('1',g_bmba[l_i].bmba003,g_bmba[l_i].l_inam002) RETURNING l_success,l_pmdo022            
                 IF l_success THEN
                    LET l_total = l_total + l_pmdo022
                 ELSE
                    LET r_success = FALSE
                    RETURN r_success                
                 END IF
             END FOR    
          ELSE
             FOR l_i = 1 TO g_bmba.getLength()             
                 CALL s_apmt500_get_pmdo022('2',g_bmba[l_i].bmba003,' ') RETURNING l_success,l_pmdo022             
                 IF l_success THEN
                    LET l_total = l_total + l_pmdo022
                 ELSE
                    LET r_success = FALSE
                    RETURN r_success                
                 END IF
             END FOR  
          END IF
         #本幣轉換成原幣
         LET g_ooef016 = ''
         SELECT ooef016 INTO g_ooef016
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = g_site 
         IF g_ooef016 = g_pmdl015 THEN
            LET l_rate = 1
         ELSE          
            CASE l_pmdl054
              WHEN '1'  #內購外幣採用匯率類型
                CALL cl_get_para(g_enterprise,g_site,'S-BAS-0014') RETURNING l_scc40
              WHEN '2'  #外購外幣採用匯率類型
                CALL cl_get_para(g_enterprise,g_site,'S-BAS-0015') RETURNING l_scc40
              OTHERWISE EXIT CASE
            END CASE
            #取得匯率
            CALL s_aooi160_get_exrate('1',g_site,g_today,g_ooef016,g_pmdl015,0,l_scc40) RETURNING l_rate
            IF cl_null(l_rate) THEN
               LET l_rate = 1           
            END IF
         END IF     
         #金額依幣別轉換         
         LET l_total = l_total * l_rate
         CALL s_curr_round(g_site,g_pmdl015,l_total,'1') RETURNING l_total         
       END IF
       
       
       #判斷若該採購單明細是未勾選多交期
       IF l_pmdn024 = 'N' THEN
          #若子件特性不是'2:CKD'或是'3:SKD'時，則直接依據採購單明細(pmdn_t)產生一筆交期明細資料
          IF l_pmdn019 NOT MATCHES '[23]' THEN
             IF NOT s_apmt500_ins_pmdo_1(p_pmdodocno,p_pmdoseq) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF
          #若子件特性為'2:CKD'或是'3SKD'時則需依據取得的物料清單產生多筆的交期明細資料(pmdn_t) 產生一筆交期明細資料
          IF l_pmdn019 MATCHES '[23]' THEN
             #取原物料清單和半成品清單FUNCTION還未完成
             #160323-00011#1---S
             IF NOT s_apmt500_ins_pmdo_2(p_pmdodocno,p_pmdoseq,l_rate,l_total) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
             #160323-00011#1---E
          END IF
       END IF
       
       #判斷若該採購單明細是勾選多交期
       IF l_pmdn024 = 'Y' THEN
          #若子件特性不是'2:CKD'或是'3:SKD'時，則子件特性不是'2:CKD'或是'3:SKD'時，則需依據交期匯總明細(pmdq_t)產生多筆交期明細資料
          IF l_pmdn019 NOT MATCHES '[23]' THEN
             IF NOT s_apmt500_ins_pmdo_3(p_pmdodocno,p_pmdoseq) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF
          #若子件特性為'2:CKD'或是'3SKD'時,則需依據取得的物料清單再搭配交期匯總明細(pmdq_t)產生多筆的交期明細資料(pmdn_t) 產生多筆交期明細資料
          IF l_pmdn019 MATCHES '[23]' THEN
             #取原物料清單和半成品清單FUNCTION還未完成
             #160323-00011#1---S
             IF NOT s_apmt500_ins_pmdo_4(p_pmdodocno,p_pmdoseq,l_rate,l_total) THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
             #160323-00011#1---E
          END IF
       END IF
       
       RETURN r_success

END FUNCTION
#採購單明細是未勾選多交期，且子件特性不是'2:CKD'或是'3:SKD'時，則直接依據採購單明細(pmdn_t) 產生一筆交期明細資料
PUBLIC FUNCTION s_apmt500_ins_pmdo_1(p_pmdodocno,p_pmdoseq)
DEFINE p_pmdodocno     LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq       LIKE pmdo_t.pmdoseq
DEFINE r_success       LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdo          RECORD LIKE pmdo_t.*
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_pmdp003       LIKE pmdp_t.pmdp003
DEFINE l_pmdp004       LIKE pmdp_t.pmdp004

       LET r_success = TRUE
       
       INITIALIZE l_pmdn.* TO NULL
       INITIALIZE l_pmdo.* TO NULL
       #161124-00048#9 mod-S
#       SELECT * INTO l_pmdn.* FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
              pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
              pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
              pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
              pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
              pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
              pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
              pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
              pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
              pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
              pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
              pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
              pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
              pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
              pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
              pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
              pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
              pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
              pmdn226,pmdn227,pmdn058,pmdn228
         INTO l_pmdn.* 
         FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       #161124-00048#9 mod-E
       
       LET l_pmdo.pmdosite = g_site
       LET l_pmdo.pmdodocno = p_pmdodocno   #採購單單號
       LET l_pmdo.pmdoseq = p_pmdoseq       #採購單項次
       
       SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
         WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
       IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
          LET l_pmdo.pmdoseq1 = 1
       END IF
       LET l_pmdo.pmdoseq2 = 1              #分批序
       LET l_pmdo.pmdo001 = l_pmdn.pmdn001  #料件編號
       LET l_pmdo.pmdo002 = l_pmdn.pmdn002  #產品特徵
       LET l_pmdo.pmdo003 = l_pmdn.pmdn019  #子件特性
       LET l_pmdo.pmdo004 = l_pmdn.pmdn006  #採購單位
       LET l_pmdo.pmdo005 = l_pmdn.pmdn007  #採購總量
       LET l_pmdo.pmdo006 = l_pmdn.pmdn007  #分批採購量
       LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量
       LET l_pmdo.pmdo008 = 1               #QPA
       LET l_pmdo.pmdo009 = '1'             #交期類型
       LET l_pmdo.pmdo010 = ''              #出貨時段
       #根據請購單中的收貨時段帶值
       SELECT pmdp003,pmdp004 INTO l_pmdp003,l_pmdp004 FROM pmdp_t
          WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdodocno AND pmdpseq = p_pmdoseq
       SELECT pmdb048 INTO l_pmdo.pmdo010 FROM pmdb_t
          WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
          
       LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
       LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
       LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
       LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
       LET l_pmdo.pmdo015 = 0               #已收貨量
       LET l_pmdo.pmdo016 = 0               #驗退量
       LET l_pmdo.pmdo017 = 0               #倉退換貨量
       LET l_pmdo.pmdo019 = 0               #已入庫量
       LET l_pmdo.pmdo040 = 0               #倉退量
       LET l_pmdo.pmdo020 = 0               #VMI請款量
       LET l_pmdo.pmdo021 = '2'             #出貨狀態
       LET l_pmdo.pmdo022 = l_pmdn.pmdn015  #參考價格
       LET l_pmdo.pmdo023 = l_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo024 = l_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo026 = g_user          #最近修改人員
       LET l_pmdo.pmdo027 = g_today         #最近修改日
       LET l_pmdo.pmdo028 = l_pmdn.pmdn008  #分批參考單位
       LET l_pmdo.pmdo029 = l_pmdn.pmdn009  #分批參考數量
       LET l_pmdo.pmdo030 = l_pmdn.pmdn010  #計價單位
       LET l_pmdo.pmdo031 = l_pmdn.pmdn011  #計價數量
       LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
       LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
       LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)
       LET l_pmdo.pmdo040 = 0               #170302-00017#1
       LET l_pmdo.pmdo041 = 0
       LET l_pmdo.pmdo042 = 0
       LET l_pmdo.pmdo043 = 0
       LET l_pmdo.pmdo044 = 0
       
       INSERT INTO pmdo_t
                  (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                   pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                   pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                   pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                   pmdo041,pmdo042,pmdo043,pmdo044) 
            VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                   l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                   l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                   l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                   l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                   l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                   l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmdo_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF

       #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
       IF NOT cl_null(l_pmdn.pmdn033) AND l_pmdn.pmdn033 <> 0 THEN
          SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
            WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
          IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
             LET l_pmdo.pmdoseq1 = 1
          END IF
          
          LET l_pmdo.pmdo003 = '6'        #子件特性
          LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100)  #採購總量
          LET l_pmdo.pmdo006 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100)  #分批採購量
          LET l_pmdo.pmdo022 = 0          #參考價格
          LET l_pmdo.pmdo031 = 0
          LET l_pmdo.pmdo032 = 0          #分批未稅金額 
          LET l_pmdo.pmdo033 = 0          #分批含稅金額
          LET l_pmdo.pmdo034 = 0          #分批稅金額
          LET l_pmdo.pmdo040 = 0          #170302-00017#1
          
          INSERT INTO pmdo_t
                     (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                      pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                      pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                      pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                      pmdo041,pmdo042,pmdo043,pmdo044)  
               VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                      l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                      l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                      l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                      l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                      l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                      l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "pmdo_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
       END IF
       
       RETURN r_success
       
END FUNCTION
#判斷若該採購單明細是未勾選多交期
#但子件特性為'2:CKD'或是'3SKD'時則需取得的物料清單產生多筆的交期明細資料(pmdn_t) 產生一筆交期明細資料
PUBLIC FUNCTION s_apmt500_ins_pmdo_2(p_pmdodocno,p_pmdoseq,p_rate,p_total)
DEFINE p_pmdodocno     LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq       LIKE pmdo_t.pmdoseq
DEFINE p_rate          LIKE ooan_t.ooan005 
DEFINE p_total         LIKE xmdd_t.xmdd018 
DEFINE r_success       LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdo          RECORD LIKE pmdo_t.*
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_pmdo022       LIKE pmdo_t.pmdo022
DEFINE l_bmba010       LIKE bmba_t.bmba010
DEFINE l_bmba020       LIKE bmba_t.bmba020
DEFINE l_bmba025       LIKE bmba_t.bmba025   
DEFINE l_i             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5
   
       LET r_success = TRUE
       
       INITIALIZE l_pmdn.* TO NULL
       INITIALIZE l_pmdo.* TO NULL
       
       #161124-00048#9 mod-S
#       SELECT * INTO l_pmdn.* FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
              pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
              pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
              pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
              pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
              pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
              pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
              pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
              pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
              pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
              pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
              pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
              pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
              pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
              pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
              pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
              pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
              pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
              pmdn226,pmdn227,pmdn058,pmdn228
         INTO l_pmdn.* 
         FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       #161124-00048#9 mod-E
       LET l_pmdo.pmdosite = g_site
       LET l_pmdo.pmdodocno = p_pmdodocno   #採購單單號
       LET l_pmdo.pmdoseq = p_pmdoseq       #採購單項次
       
       #SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
       #  WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
       #IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
       #   LET l_pmdo.pmdoseq1 = 1
       #END IF
       
       LET l_pmdo.pmdoseq2 = 1              #分批序
       #LET l_pmdo.pmdo001 = 原物料料號       #料件編號
       #LET l_pmdo.pmdo002 = 原物料料號產品特徵  #產品特徵
       LET l_pmdo.pmdo003 = l_pmdn.pmdn019  #子件特性
       #LET l_pmdo.pmdo004 = 原物料BOM單位    #採購單位
       #LET l_pmdo.pmdo005 = pmdn007*取得的QPA  #採購總量
       #LET l_pmdo.pmdo006 = pmdn007*取得的QPA  #分批採購量
       LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量
       #LET l_pmdo.pmdo008 = 取得的QPA        #QPA
       LET l_pmdo.pmdo009 = '1'             #交期類型
       LET l_pmdo.pmdo010 = ''              #出貨時段
       LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
       LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
       LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
       LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
       LET l_pmdo.pmdo015 = 0               #已收貨量
       LET l_pmdo.pmdo016 = 0               #驗退量
       LET l_pmdo.pmdo017 = 0               #倉退換貨量
       LET l_pmdo.pmdo040 = 0               #倉退量
       LET l_pmdo.pmdo019 = 0               #已入庫量
       LET l_pmdo.pmdo020 = 0               #VMI請款量
       LET l_pmdo.pmdo021 = '2'             #出貨狀態
       #LET l_pmdo.pmdo022 = 由主件單價(pmdn015)依據據點參數設置的推算比率計算  #參考價格
       LET l_pmdo.pmdo023 = l_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo024 = l_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo026 = g_user          #最近修改人員
       LET l_pmdo.pmdo027 = g_today         #最近修改日
       #LET l_pmdo.pmdo028 = l_pmdn.pmdn008  #分批參考單位
       #LET l_pmdo.pmdo029 = l_pmdn.pmdn009  #分批參考數量
       #LET l_pmdo.pmdo030 = l_pmdn.pmdn010  #計價單位
       #LET l_pmdo.pmdo031 = l_pmdn.pmdn011  #計價數量
       #LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
       #LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
       #LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)
       
       LET l_pmdo.pmdo041 = 0
       LET l_pmdo.pmdo042 = 0
       LET l_pmdo.pmdo043 = 0
       LET l_pmdo.pmdo044 = 0
       
       FOR l_i = 1 TO g_bmba.getLength()
           #需排除是可選件/附屬零件
           CALL s_apmt500_get_bmba(g_bmba[l_i].bmba001,g_bmba[l_i].bmba002,g_bmba[l_i].bmba003,g_bmba[l_i].bmba004,g_bmba[l_i].bmba005,g_bmba[l_i].bmba007,g_bmba[l_i].bmba008) 
             RETURNING l_bmba010,l_bmba020,l_bmba025
           IF l_bmba020 = 'Y' OR l_bmba025 = 'Y' THEN
              CONTINUE FOR
           END IF           
           #項序       
           SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
            WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno 
              AND pmdoseq = l_pmdo.pmdoseq
           IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
              LET l_pmdo.pmdoseq1 = 1
           END IF 
           LET l_pmdo.pmdo001 = g_bmba[l_i].bmba003               #料件編號
           LET l_pmdo.pmdo002 = g_bmba[l_i].l_inam002             #產品特徵  
           LET l_pmdo.pmdo003 = l_pmdn.pmdn019                    #子件特性   #160323-00011#1 add
           #採購單位bmba010
           LET l_pmdo.pmdo004 = l_bmba010
           LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #採購總數量
           LET l_pmdo.pmdo006 = l_pmdn.pmdn007 * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #分批採購數量
           LET l_pmdo.pmdo008 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012  #QPA
           #數量取位
           CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo005) RETURNING l_success,l_pmdo.pmdo005  
           CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo006) RETURNING l_success,l_pmdo.pmdo006 
           CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo008) RETURNING l_success,l_pmdo.pmdo008
           #抓取料件主檔參考單位、計價單位           
           SELECT imaf015,imaf113 
             INTO l_pmdo.pmdo028,l_pmdo.pmdo030
             FROM imaf_t
            WHERE imafent = g_enterprise 
              AND imafsite = g_site 
              AND imaf001 = l_pmdo.pmdo001    
              
           #若料號有設置使用參考單位時，且銷售單位與參考單位有設置換算率時，則應自動推算參考數量
           IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo028) THEN
              CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
                RETURNING l_success,l_pmdo.pmdo029
              #參考數量取位
              CALL s_aooi250_take_decimals(l_pmdo.pmdo028,l_pmdo.pmdo029)
                RETURNING l_success,l_pmdo.pmdo029                     
           END IF
           #若料號有使用採購計價單位時，則輸入[C:採購數量]時則應自動推算計價數量
           IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo030) THEN
              CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
                RETURNING l_success,l_pmdo.pmdo031
              #對計價數量進行取位
              CALL s_aooi250_take_decimals(l_pmdo.pmdo030,l_pmdo.pmdo031)
                RETURNING l_success,l_pmdo.pmdo031   
           END IF 
           
           #參考價格：由主件單價(pmdn015)依據據點參數設置S-BAS-0022的推算比率計算1.依標準成本2.最近採購單價           
           #LET l_pmdo.pmdo022 = l_pmdn.pmdn015  #參考價格
           IF cl_get_para(g_enterprise,g_site,'S-BAS-0022') = '1' THEN
              CALL s_apmt500_get_pmdo022('1',g_bmba[l_i].bmba003,g_bmba[l_i].l_inam002) RETURNING l_success,l_pmdo022           
           ELSE
              CALL s_apmt500_get_pmdo022('2',g_bmba[l_i].bmba003,' ') RETURNING l_success,l_pmdo022 
           END IF
           IF l_success THEN
              LET l_pmdo.pmdo022 = l_pmdn.pmdn015 * (l_pmdo022 / p_total)
              #金額依幣別轉換                      
              LET l_pmdo.pmdo022 = l_pmdo.pmdo022 * p_rate           
              CALL s_curr_round(g_site,g_pmdl015,l_pmdo.pmdo022,'1') RETURNING l_pmdo.pmdo022              
           ELSE
              LET r_success = FALSE
              RETURN r_success                
           END IF 
                      
           #分批未稅、含稅、稅額計算
           CALL s_apmt500_get_amount_2(l_pmdo.pmdo031,l_pmdo.pmdo022,l_pmdo.pmdo023,g_pmdl015,g_pmdl016)
             RETURNING l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034
             
           LET l_pmdo.pmdo040 = 0          #170302-00017#1
       
           INSERT INTO pmdo_t
                      (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                       pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                       pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                       pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                       pmdo041,pmdo042,pmdo043,pmdo044)
                VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                       l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                       l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                       l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                       l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                       l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                       l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "pmdo_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()
           
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
           IF NOT cl_null(l_pmdn.pmdn033) AND l_pmdn.pmdn033 <> 0 THEN
              SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
                WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
              IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
                 LET l_pmdo.pmdoseq1 = 1
              END IF
              
              LET l_pmdo.pmdo003 = '6'        #子件特性
              LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100) * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #採購總量
              LET l_pmdo.pmdo006 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100) * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #分批採購量
              LET l_pmdo.pmdo022 = 0          #參考價格
              LET l_pmdo.pmdo031 = 0
              LET l_pmdo.pmdo032 = 0          #分批未稅金額 
              LET l_pmdo.pmdo033 = 0          #分批含稅金額
              LET l_pmdo.pmdo034 = 0          #分批稅金額
              LET l_pmdo.pmdo040 = 0          #170302-00017#1
              
              #若料號有設置使用參考單位時，且銷售單位與參考單位有設置換算率時，則應自動推算參考數量
              IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo028) THEN
                 CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
                   RETURNING l_success,l_pmdo.pmdo029
                 #參考數量取位
                 CALL s_aooi250_take_decimals(l_pmdo.pmdo028,l_pmdo.pmdo029)
                   RETURNING l_success,l_pmdo.pmdo029                     
              END IF
              #若料號有使用採購計價單位時，則輸入[C:採購數量]時則應自動推算計價數量
              IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo030) THEN
                 CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
                   RETURNING l_success,l_pmdo.pmdo031
                 #對計價數量進行取位
                 CALL s_aooi250_take_decimals(l_pmdo.pmdo030,l_pmdo.pmdo031)
                   RETURNING l_success,l_pmdo.pmdo031   
              END IF 
           
              INSERT INTO pmdo_t
                         (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                          pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                          pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                          pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                          pmdo041,pmdo042,pmdo043,pmdo044)   
                   VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                          l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                          l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                          l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                          l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                          l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                          l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "pmdo_t"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
           
                 LET r_success = FALSE
                 RETURN r_success
              END IF
           END IF
           
       END FOR
       
       RETURN r_success
       
END FUNCTION
#判斷若該採購單明細是勾選多交期
#若子件特性不是'2:CKD'或是'3:SKD'時，則子件特性不是'2:CKD'或是'3:SKD'時，則需依據交期匯總明細(pmdq_t)產生多筆交期明細資料
PUBLIC FUNCTION s_apmt500_ins_pmdo_3(p_pmdodocno,p_pmdoseq)
DEFINE p_pmdodocno     LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq       LIKE pmdo_t.pmdoseq
DEFINE r_success       LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdo          RECORD LIKE pmdo_t.*
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
#DEFINE l_pmdq          RECORD LIKE pmdq_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_success       LIKE type_t.num5
DEFINE l_pmdo032       LIKE pmdo_t.pmdo032
DEFINE l_pmdo033       LIKE pmdo_t.pmdo033
DEFINE l_pmdo034       LIKE pmdo_t.pmdo034
DEFINE l_pmdoseq1      LIKE pmdo_t.pmdoseq1
DEFINE l_pmdoseq2      LIKE pmdo_t.pmdoseq2

       LET r_success = TRUE
       
       INITIALIZE l_pmdn.* TO NULL
       INITIALIZE l_pmdo.* TO NULL
       INITIALIZE l_pmdq.* TO NULL
       
       #161124-00048#9 mod-S
#       SELECT * INTO l_pmdn.* FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
              pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
              pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
              pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
              pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
              pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
              pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
              pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
              pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
              pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
              pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
              pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
              pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
              pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
              pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
              pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
              pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
              pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
              pmdn226,pmdn227,pmdn058,pmdn228
         INTO l_pmdn.* 
         FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       #161124-00048#9 mod-E
       LET l_pmdo.pmdosite = g_site
       LET l_pmdo.pmdodocno = p_pmdodocno   #採購單單號
       LET l_pmdo.pmdoseq = p_pmdoseq       #採購單項次
       
       SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
         WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
       IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
          LET l_pmdo.pmdoseq1 = 1
       END IF
       #LET l_pmdo.pmdoseq2 = 1              #分批序
       LET l_pmdo.pmdo001 = l_pmdn.pmdn001  #料件編號
       LET l_pmdo.pmdo002 = l_pmdn.pmdn002  #產品特徵
       LET l_pmdo.pmdo003 = l_pmdn.pmdn019  #子件特性
       LET l_pmdo.pmdo004 = l_pmdn.pmdn006  #採購單位
       LET l_pmdo.pmdo005 = l_pmdn.pmdn007  #採購總量
       #LET l_pmdo.pmdo006 = l_pmdn.pmdn007  #分批採購量
       #LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量
       LET l_pmdo.pmdo008 = 1               #QPA
       #LET l_pmdo.pmdo009 = '1'             #交期類型
       #LET l_pmdo.pmdo010 = ''              #出貨時段
       #LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
       #LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
       #LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
       #LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
       LET l_pmdo.pmdo015 = 0               #已收貨量
       LET l_pmdo.pmdo016 = 0               #驗退量
       LET l_pmdo.pmdo017 = 0               #倉退換貨量
       LET l_pmdo.pmdo040 = 0               #倉退量
       LET l_pmdo.pmdo019 = 0               #已入庫量
       LET l_pmdo.pmdo020 = 0               #VMI請款量
       LET l_pmdo.pmdo021 = '2'             #出貨狀態
       LET l_pmdo.pmdo022 = l_pmdn.pmdn015  #參考價格
       LET l_pmdo.pmdo023 = l_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo024 = l_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo026 = g_user          #最近修改人員
       LET l_pmdo.pmdo027 = g_today         #最近修改日
       LET l_pmdo.pmdo028 = l_pmdn.pmdn008  #分批參考單位
       LET l_pmdo.pmdo029 = l_pmdn.pmdn009  #分批參考數量
       LET l_pmdo.pmdo030 = l_pmdn.pmdn010  #計價單位
       LET l_pmdo.pmdo031 = l_pmdn.pmdn011  #計價數量
       #LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
       #LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
       #LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)
       
       LET l_pmdo.pmdo041 = 0
       LET l_pmdo.pmdo042 = 0
       LET l_pmdo.pmdo043 = 0
       LET l_pmdo.pmdo044 = 0
       #161124-00048#9 mod-S
#       DECLARE pmdq_cs CURSOR FOR
#          SELECT * FROM pmdq_t WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdodocno AND pmdqseq = p_pmdoseq
       DECLARE pmdq_cs CURSOR FOR
          SELECT pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
                 pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
                 pmdq007,pmdq008,pmdq201,pmdq202,pmdq900,
                 pmdq999 
            FROM pmdq_t 
           WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdodocno AND pmdqseq = p_pmdoseq
       #161124-00048#9 mod-E
       FOREACH pmdq_cs INTO l_pmdq.* 
          LET l_pmdo.pmdoseq2 = l_pmdq.pmdqseq2 #分批序
          LET l_pmdo.pmdo006 = l_pmdq.pmdq002   #分批採購量
          LET l_pmdo.pmdo007 = l_pmdq.pmdq002   #折核主件數量
          LET l_pmdo.pmdo010 = l_pmdq.pmdq006   #出貨時段
          LET l_pmdo.pmdo011 = l_pmdq.pmdq003   #出貨日期
          LET l_pmdo.pmdo012 = l_pmdq.pmdq004   #到廠日期
          LET l_pmdo.pmdo013 = l_pmdq.pmdq005   #到庫日期
          LET l_pmdo.pmdo014 = l_pmdq.pmdq007   #MRP凍結否
          LET l_pmdo.pmdo009 = l_pmdq.pmdq008   #交期類型
          
          
          CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo006)
               RETURNING l_success,l_pmdo.pmdo006
               
          #若料號有設置使用參考單位時，且單位與參考單位有設置換算率時，則應自動推算參考數量
          IF NOT cl_null(l_pmdo.pmdo028) THEN
             CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
               RETURNING l_success,l_pmdo.pmdo029
             #參考數量取位
             CALL s_aooi250_take_decimals(l_pmdo.pmdo028,l_pmdo.pmdo029)
               RETURNING l_success,l_pmdo.pmdo029
          END IF
           
          #若參數有使用計價單位時，則輸入[C:需求數量]時則應自動推算計價數量，
          #[C:計價數量]=[C:需求數量]*[C:單位]與[C:計價單位]換算率
          IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" AND (NOT cl_null(l_pmdo.pmdo030)) AND (NOT cl_null(l_pmdo.pmdo001)) AND (NOT cl_null(l_pmdo.pmdo004)) THEN  #體參數使用採購計價單位
             CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
               RETURNING l_success,l_pmdo.pmdo031
             #數量取位
             CALL s_aooi250_take_decimals(l_pmdo.pmdo030,l_pmdo.pmdo031)
               RETURNING l_success,l_pmdo.pmdo031
          ELSE
             LET l_pmdo.pmdo031 = l_pmdo.pmdo006                   
          END IF
                     
          
          #計算金額 分批數量/總數量 * 金額
          LET l_pmdo.pmdo032 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * l_pmdn.pmdn046  #分批未稅金額
          LET l_pmdo.pmdo033 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * l_pmdn.pmdn047  #分批含稅金額
          LET l_pmdo.pmdo034 = l_pmdq.pmdq002 / l_pmdo.pmdo005 * l_pmdn.pmdn048  #分批稅金額
          LET l_pmdo.pmdo040 = 0          #170302-00017#1
         
          INSERT INTO pmdo_t
                     (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                      pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                      pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                      pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                      pmdo041,pmdo042,pmdo043,pmdo044) 
               VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                      l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                      l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                      l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                      l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                      l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                      l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "pmdo_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
             RETURN r_success
          END IF
   
          #若該採購單明細有設置備品率時，應自動在產生筆各交期的備品明細資料
          IF NOT cl_null(l_pmdn.pmdn033) AND l_pmdn.pmdn033 <> 0 THEN
             SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
               WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
             IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
                LET l_pmdo.pmdoseq1 = 1
             END IF
             
             LET l_pmdo.pmdo003 = '6'        #子件特性
             LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100)  #採購總量
             LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * (l_pmdn.pmdn033/100)  #分批採購量
             LET l_pmdo.pmdo007 = l_pmdq.pmdq002 * (l_pmdn.pmdn033/100)  #折核主件數量
             LET l_pmdo.pmdo022 = 0          #參考價格
             LET l_pmdo.pmdo031 = 0
             LET l_pmdo.pmdo032 = 0          #分批未稅金額 
             LET l_pmdo.pmdo033 = 0          #分批含稅金額
             LET l_pmdo.pmdo034 = 0          #分批稅金額
             LET l_pmdo.pmdo040 = 0          #170302-00017#1
             
             INSERT INTO pmdo_t
                        (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                         pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                         pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                         pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                         pmdo041,pmdo042,pmdo043,pmdo044) 
                  VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                         l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                         l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                         l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                         l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                         l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                         l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "pmdo_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF
          END IF
       END FOREACH
       
       #計算尾差,加在最小项次的上面
       SELECT SUM(pmdo032),SUM(pmdo033),SUM(pmdo034) INTO l_pmdo032,l_pmdo033,l_pmdo034
          FROM pmdo_t WHERE pmdoent = g_enterprise AND pmdodocno = g_pmdl_m.pmdldocno AND pmdoseq = l_pmdn.pmdnseq AND pmdo003 <> '6' 
       IF l_pmdo032 <> l_pmdn.pmdn046 OR l_pmdo033 <> l_pmdn.pmdn047 OR l_pmdo034 <> l_pmdn.pmdn048 THEN
          SELECT MIN(pmdoseq1) INTO l_pmdoseq1 FROM pmdo_t WHERE pmdoent = g_enterprise AND pmdodocno = g_pmdl_m.pmdldocno AND pmdoseq = l_pmdn.pmdnseq
          SELECT MIN(pmdoseq2) INTO l_pmdoseq2 FROM pmdo_t 
             WHERE pmdoent = g_enterprise AND pmdodocno = g_pmdl_m.pmdldocno AND pmdoseq = l_pmdn.pmdnseq AND pmdoseq1 = l_pmdoseq1
          
          UPDATE pmdo_t SET pmdo032 = pmdo032 + (l_pmdn.pmdn046 - l_pmdo032),
                            pmdo033 = pmdo033 + (l_pmdn.pmdn047 - l_pmdo033),
                            pmdo034 = pmdo034 + (l_pmdn.pmdn048 - l_pmdo034)
             WHERE pmdoent = g_enterprise AND pmdodocno = g_pmdl_m.pmdldocno AND pmdoseq = l_pmdn.pmdnseq 
               AND pmdoseq1 = l_pmdoseq1 AND pmdoseq2 = l_pmdoseq2
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.sqlcode
             LET g_errparam.extend = "pmdo_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
             RETURN r_success
          END IF     
       END IF
       
       RETURN r_success
       
       
END FUNCTION
#判斷若該採購單明細是勾選多交期
#若子件特性為'2:CKD'或是'3SKD'時,則需依據取得的物料清單再搭配交期匯總明細(pmdq_t)產生多筆的交期明細資料(pmdn_t) 產生多筆交期明細資料
PUBLIC FUNCTION s_apmt500_ins_pmdo_4(p_pmdodocno,p_pmdoseq,p_rate,p_total)
DEFINE p_pmdodocno     LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq       LIKE pmdo_t.pmdoseq
DEFINE p_rate          LIKE ooan_t.ooan005 
DEFINE p_total         LIKE xmdd_t.xmdd018 
DEFINE r_success       LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdo          RECORD LIKE pmdo_t.*
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
#DEFINE l_pmdq          RECORD LIKE pmdq_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_pmdo022       LIKE pmdo_t.pmdo022
DEFINE l_bmba010       LIKE bmba_t.bmba010
DEFINE l_bmba020       LIKE bmba_t.bmba020
DEFINE l_bmba025       LIKE bmba_t.bmba025   
DEFINE l_i             LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5

       LET r_success = TRUE
       
       INITIALIZE l_pmdn.* TO NULL
       INITIALIZE l_pmdo.* TO NULL
       INITIALIZE l_pmdq.* TO NULL
       
       #161124-00048#9 mod-S
#       SELECT * INTO l_pmdn.* FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
              pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
              pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
              pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
              pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
              pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
              pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
              pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
              pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
              pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
              pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
              pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
              pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
              pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
              pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
              pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
              pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
              pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
              pmdn226,pmdn227,pmdn058,pmdn228
         INTO l_pmdn.* 
         FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       #161124-00048#9 mod-E
       LET l_pmdo.pmdosite = g_site
       LET l_pmdo.pmdodocno = p_pmdodocno   #採購單單號
       LET l_pmdo.pmdoseq = p_pmdoseq       #採購單項次
       
       #SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
       #  WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
       #IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
       #   LET l_pmdo.pmdoseq1 = 1
       #END IF
       
       #LET l_pmdo.pmdoseq2 = 1              #分批序
       #LET l_pmdo.pmdo001 = 原物料料號       #料件編號
       #LET l_pmdo.pmdo002 = 原物料料號產品特徵  #產品特徵
       LET l_pmdo.pmdo003 = l_pmdn.pmdn019  #子件特性
       #LET l_pmdo.pmdo004 = 原物料BOM單位    #採購單位
       #LET l_pmdo.pmdo005 = pmdn007*取得的QPA  #採購總量
       #LET l_pmdo.pmdo006 = pmdn007*取得的QPA  #分批採購量
       #LET l_pmdo.pmdo007 = l_pmdn.pmdn007  #折核主件數量
       #LET l_pmdo.pmdo008 = 取得的QPA        #QPA
       #LET l_pmdo.pmdo009 = '1'             #交期類型
       #LET l_pmdo.pmdo010 = ''              #出貨時段
       #LET l_pmdo.pmdo011 = l_pmdn.pmdn012  #出貨日期
       #LET l_pmdo.pmdo012 = l_pmdn.pmdn013  #到廠日期
       #LET l_pmdo.pmdo013 = l_pmdn.pmdn014  #到庫日期
       #LET l_pmdo.pmdo014 = 'N'             #MRP凍結否
       LET l_pmdo.pmdo015 = 0               #已收貨量
       LET l_pmdo.pmdo016 = 0               #驗退量
       LET l_pmdo.pmdo017 = 0               #倉退換貨量
       LET l_pmdo.pmdo040 = 0               #倉退量
       LET l_pmdo.pmdo019 = 0               #已入庫量
       LET l_pmdo.pmdo020 = 0               #VMI請款量
       LET l_pmdo.pmdo021 = '2'             #出貨狀態
       #LET l_pmdo.pmdo022 = 由主件單價(pmdn015)依據據點參數設置的推算比率計算  #參考價格
       LET l_pmdo.pmdo023 = l_pmdn.pmdn016  #稅別(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo024 = l_pmdn.pmdn017  #稅率(#呼叫應取稅別應用元件取得該品項的稅別與稅率)
       LET l_pmdo.pmdo026 = g_user          #最近修改人員
       LET l_pmdo.pmdo027 = g_today         #最近修改日
       #LET l_pmdo.pmdo028 = l_pmdn.pmdn008  #分批參考單位
       #LET l_pmdo.pmdo029 = l_pmdn.pmdn009  #分批參考數量
       #LET l_pmdo.pmdo030 = l_pmdn.pmdn010  #計價單位
       #LET l_pmdo.pmdo031 = l_pmdn.pmdn011  #計價數量
       #LET l_pmdo.pmdo032 = l_pmdn.pmdn046  #分批未稅金額(呼叫計算含未稅金額應用元件計算取得) 
       #LET l_pmdo.pmdo033 = l_pmdn.pmdn047  #分批含稅金額(呼叫計算含未稅金額應用元件計算取得)
       #LET l_pmdo.pmdo034 = l_pmdn.pmdn048  #分批稅金額(呼叫計算含未稅金額應用元件計算取得)
       LET l_pmdo.pmdo041 = 0
       LET l_pmdo.pmdo042 = 0
       LET l_pmdo.pmdo043 = 0
       LET l_pmdo.pmdo044 = 0
       #161124-00048#9 mod-S
#       DECLARE pmdq_cs2 CURSOR FOR
#          SELECT * FROM pmdq_t WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdodocno AND pmdqseq = p_pmdoseq
       DECLARE pmdq_cs2 CURSOR FOR
          SELECT pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
                 pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
                 pmdq007,pmdq008,pmdq201,pmdq202,pmdq900,
                 pmdq999 
            FROM pmdq_t 
           WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdodocno AND pmdqseq = p_pmdoseq
       #161124-00048#9 mod-E
       FOREACH pmdq_cs2 INTO l_pmdq.* 
          LET l_pmdo.pmdoseq2 = l_pmdq.pmdqseq2 #分批序
          #LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * 取得的QPA   #分批採購量
          LET l_pmdo.pmdo007 = l_pmdq.pmdq002   #折核主件數量
          LET l_pmdo.pmdo010 = l_pmdq.pmdq006   #出貨時段
          LET l_pmdo.pmdo011 = l_pmdq.pmdq003   #出貨日期
          LET l_pmdo.pmdo012 = l_pmdq.pmdq004   #到廠日期
          LET l_pmdo.pmdo013 = l_pmdq.pmdq005   #到庫日期
          LET l_pmdo.pmdo014 = l_pmdq.pmdq007   #MRP凍結否
          LET l_pmdo.pmdo009 = l_pmdq.pmdq008   #交期類型
          
          FOR l_i = 1 TO g_bmba.getLength()
              #需排除是可選件/附屬零件
              CALL s_apmt500_get_bmba(g_bmba[l_i].bmba001,g_bmba[l_i].bmba002,g_bmba[l_i].bmba003,g_bmba[l_i].bmba004,g_bmba[l_i].bmba005,g_bmba[l_i].bmba007,g_bmba[l_i].bmba008) 
                RETURNING l_bmba010,l_bmba020,l_bmba025
              IF l_bmba020 = 'Y' OR l_bmba025 = 'Y' THEN
                 CONTINUE FOR
              END IF           
              #項序       
              SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
               WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno 
                 AND pmdoseq = l_pmdo.pmdoseq
              IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
                 LET l_pmdo.pmdoseq1 = 1
              END IF 
              LET l_pmdo.pmdo001 = g_bmba[l_i].bmba003               #料件編號
              LET l_pmdo.pmdo002 = g_bmba[l_i].l_inam002             #產品特徵  
              LET l_pmdo.pmdo003 = l_pmdn.pmdn019                    #子件特性   #160323-00011#1 add
              #採購單位bmba010
              LET l_pmdo.pmdo004 = l_bmba010
              LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #採購總數量
              LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #分批採購數量
              LET l_pmdo.pmdo008 = g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012  #QPA
              #數量取位
              CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo005) RETURNING l_success,l_pmdo.pmdo005  
              CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo006) RETURNING l_success,l_pmdo.pmdo006 
              CALL s_aooi250_take_decimals(l_pmdo.pmdo004,l_pmdo.pmdo008) RETURNING l_success,l_pmdo.pmdo008
              #抓取料件主檔參考單位、計價單位           
              SELECT imaf015,imaf113 
                INTO l_pmdo.pmdo028,l_pmdo.pmdo030
                FROM imaf_t
               WHERE imafent = g_enterprise 
                 AND imafsite = g_site 
                 AND imaf001 = l_pmdo.pmdo001    
                 
              #若料號有設置使用參考單位時，且採購單位與參考單位有設置換算率時，則應自動推算參考數量
              IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo028) THEN
                 CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
                   RETURNING l_success,l_pmdo.pmdo029
                 #參考數量取位
                 CALL s_aooi250_take_decimals(l_pmdo.pmdo028,l_pmdo.pmdo029)
                   RETURNING l_success,l_pmdo.pmdo029                     
              END IF
              #若料號有使用採購計價單位時，則輸入[C:採購數量]時則應自動推算計價數量
              IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo030) THEN
                 CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
                   RETURNING l_success,l_pmdo.pmdo031
                 #對計價數量進行取位
                 CALL s_aooi250_take_decimals(l_pmdo.pmdo030,l_pmdo.pmdo031)
                   RETURNING l_success,l_pmdo.pmdo031   
              END IF 
              
              #參考價格：由主件單價(pmdn015)依據據點參數設置S-BAS-0022的推算比率計算1.依標準成本2.最近採購單價           
              #LET l_pmdo.pmdo022 = l_pmdn.pmdn015  #參考價格
              IF cl_get_para(g_enterprise,g_site,'S-BAS-0022') = '1' THEN
                 CALL s_apmt500_get_pmdo022('1',g_bmba[l_i].bmba003,g_bmba[l_i].l_inam002) RETURNING l_success,l_pmdo022           
              ELSE
                 CALL s_apmt500_get_pmdo022('2',g_bmba[l_i].bmba003,' ') RETURNING l_success,l_pmdo022 
              END IF
              IF l_success THEN
                 LET l_pmdo.pmdo022 = l_pmdn.pmdn015 * (l_pmdo022 / p_total)
                 #金額依幣別轉換                      
                 LET l_pmdo.pmdo022 = l_pmdo.pmdo022 * p_rate           
                 CALL s_curr_round(g_site,g_pmdl015,l_pmdo.pmdo022,'1') RETURNING l_pmdo.pmdo022              
              ELSE
                 LET r_success = FALSE
                 RETURN r_success                
              END IF 
                         
              #分批未稅、含稅、稅額計算
              CALL s_apmt500_get_amount_2(l_pmdo.pmdo031,l_pmdo.pmdo022,l_pmdo.pmdo023,g_pmdl015,g_pmdl016)
                RETURNING l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034

             LET l_pmdo.pmdo040 = 0                              #170302-00017#1
             
             INSERT INTO pmdo_t
                        (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                         pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                         pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                         pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                         pmdo041,pmdo042,pmdo043,pmdo044) 
                  VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                         l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                         l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                         l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                         l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                         l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                         l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
             IF SQLCA.sqlcode THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "pmdo_t"
                LET g_errparam.popup = TRUE
                CALL cl_err()
             
                LET r_success = FALSE
                RETURN r_success
             END IF
             
             #若該採購單明細有設置備品率時，應自動在產生一筆備品的交期明細資料
             IF NOT cl_null(l_pmdn.pmdn033) AND l_pmdn.pmdn033 <> 0 THEN
                SELECT MAX(pmdoseq1)+1 INTO l_pmdo.pmdoseq1 FROM pmdo_t
                  WHERE pmdoent = g_enterprise AND pmdodocno = l_pmdo.pmdodocno AND pmdoseq = l_pmdo.pmdoseq
                IF cl_null(l_pmdo.pmdoseq1) OR l_pmdo.pmdoseq1 = 0 THEN
                   LET l_pmdo.pmdoseq1 = 1
                END IF
                
                LET l_pmdo.pmdo003 = '6'        #子件特性
                LET l_pmdo.pmdo005 = l_pmdn.pmdn007 * (l_pmdn.pmdn033/100) * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012) #採購總量
                LET l_pmdo.pmdo006 = l_pmdq.pmdq002 * (l_pmdn.pmdn033/100) * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #分批採購量
                LET l_pmdo.pmdo007 = l_pmdq.pmdq002 * (l_pmdn.pmdn033/100) * (g_bmba[l_i].l_bmba011/g_bmba[l_i].l_bmba012)  #折核主件數量
                LET l_pmdo.pmdo022 = 0          #參考價格
                LET l_pmdo.pmdo031 = 0
                LET l_pmdo.pmdo032 = 0          #分批未稅金額 
                LET l_pmdo.pmdo033 = 0          #分批含稅金額
                LET l_pmdo.pmdo034 = 0          #分批稅金額
                LET l_pmdo.pmdo040 = 0          #170302-00017#1
                
                #若料號有設置使用參考單位時，且採購單位與參考單位有設置換算率時，則應自動推算參考數量
                IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo028) THEN
                   CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
                     RETURNING l_success,l_pmdo.pmdo029
                   #參考數量取位
                   CALL s_aooi250_take_decimals(l_pmdo.pmdo028,l_pmdo.pmdo029)
                     RETURNING l_success,l_pmdo.pmdo029                     
                END IF
                #若料號有使用採購計價單位時，則輸入[C:採購數量]時則應自動推算計價數量
                IF NOT cl_null(l_pmdo.pmdo004) AND NOT cl_null(l_pmdo.pmdo030) THEN
                   CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo030,l_pmdo.pmdo006)
                     RETURNING l_success,l_pmdo.pmdo031
                   #對計價數量進行取位
                   CALL s_aooi250_take_decimals(l_pmdo.pmdo030,l_pmdo.pmdo031)
                     RETURNING l_success,l_pmdo.pmdo031   
                END IF 
                
                INSERT INTO pmdo_t
                           (pmdoent,pmdodocno,pmdoseq,pmdoseq1,pmdoseq2,pmdosite,pmdo001,pmdo002,pmdo003,pmdo004,
                            pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                            pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                            pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,pmdo031,pmdo032,pmdo033,pmdo034,pmdo040,
                            pmdo041,pmdo042,pmdo043,pmdo044) 
                     VALUES (g_enterprise,l_pmdo.pmdodocno,l_pmdo.pmdoseq,l_pmdo.pmdoseq1,l_pmdo.pmdoseq2,l_pmdo.pmdosite,
                            l_pmdo.pmdo001,l_pmdo.pmdo002,l_pmdo.pmdo003,l_pmdo.pmdo004,l_pmdo.pmdo005,l_pmdo.pmdo006,l_pmdo.pmdo007,
                            l_pmdo.pmdo008,l_pmdo.pmdo009,l_pmdo.pmdo010,l_pmdo.pmdo011,l_pmdo.pmdo012,l_pmdo.pmdo013,l_pmdo.pmdo014,
                            l_pmdo.pmdo015,l_pmdo.pmdo016,l_pmdo.pmdo017,l_pmdo.pmdo019,l_pmdo.pmdo020,l_pmdo.pmdo021,
                            l_pmdo.pmdo022,l_pmdo.pmdo023,l_pmdo.pmdo024,'',l_pmdo.pmdo026,l_pmdo.pmdo027,l_pmdo.pmdo028,
                            l_pmdo.pmdo029,l_pmdo.pmdo030,l_pmdo.pmdo031,l_pmdo.pmdo032,l_pmdo.pmdo033,l_pmdo.pmdo034,l_pmdo.pmdo040,
                            l_pmdo.pmdo041,l_pmdo.pmdo042,l_pmdo.pmdo043,l_pmdo.pmdo044)
                IF SQLCA.sqlcode THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "pmdo_t"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
             
                   LET r_success = FALSE
                   RETURN r_success
                END IF
             END IF
             
          END FOR
          
       END FOREACH
       
       RETURN r_success
       
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業作废
# Memo...........:
# Usage..........: CALL s_apmt500_invalid_upd(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdldocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/01/12 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_invalid_upd(p_pmdldocno)
DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE l_pmdnseq         LIKE pmdn_t.pmdnseq
DEFINE r_success         LIKE type_t.num5 
DEFINE l_pmdp003         LIKE pmdp_t.pmdp003
DEFINE l_pmdp004         LIKE pmdp_t.pmdp004
DEFINE l_pmdl004         LIKE pmdl_t.pmdl004
DEFINE l_pmdl005         LIKE pmdl_t.pmdl005
DEFINE l_pmdl007         LIKE pmdl_t.pmdl007
DEFINE l_pmdp023         LIKE pmdp_t.pmdp023
DEFINE l_pmdp009         LIKE pmdp_t.pmdp009
DEFINE l_pmdp010         LIKE pmdp_t.pmdp010
DEFINE l_pmdp001         LIKE pmdp_t.pmdp001  #170208-00026#1 add
DEFINE l_n1              LIKE type_t.num5     #170208-00026#1 add

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DECLARE pmdn_cur2 CURSOR FOR
     SELECT pmdnseq FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno

   FOREACH pmdn_cur2 INTO l_pmdnseq
      #更新請購單中的已轉採購量
      IF NOT s_apmt500_upd_pmdb049(p_pmdldocno,l_pmdnseq,'-1') THEN
         LET r_success = FALSE                 
         RETURN r_success
      END IF
   
   END FOREACH
   
   #更新工单sfcb041 委外数量
   #代买料不影响可委外数量
   SELECT pmdl004,pmdl005,pmdl007 
     INTO l_pmdl004,l_pmdl005,l_pmdl007 
     FROM pmdl_t 
    WHERE pmdlent = g_enterprise 
      AND pmdldocno = p_pmdldocno
   IF l_pmdl005 = '2' AND l_pmdl007 = '4' THEN
       
      DECLARE sfcb_upd2 CURSOR FOR 
            SELECT DISTINCT pmdp003,pmdp004,pmdp023,pmdp009,pmdp010,pmdp001 FROM pmdp_t,pmdn_t    #170208-00026#1 add pmdp001 
               WHERE pmdpent = pmdnent AND pmdpdocno = pmdndocno AND pmdpseq = pmdnseq AND pmdn019 <> '8'
                 AND pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno
                 
      FOREACH sfcb_upd2 INTO l_pmdp003,l_pmdp004,l_pmdp023,l_pmdp009,l_pmdp010,l_pmdp001   #170208-00026#1 add pmdp001 
         #170208-00026#1 add   --begin--
         SELECT COUNT(*) INTO l_n1 FROM sfac_t
          WHERE sfacent = g_enterprise AND sfacdocno = l_pmdp003
            AND sfac001 = l_pmdp001 AND (sfac002 = '1' OR sfac002 = '2')
         IF l_n1 = 0 THEN
            CONTINUE FOREACH
         END IF
         #170208-00026#1 add   --end--
         
         #160316-00006#1---add---begin---
         IF cl_null(l_pmdp009) THEN
            LET l_pmdp009 = ' '
         END IF
         IF cl_null(l_pmdp010) THEN
            LET l_pmdp010 = ' '
         END IF
         #160316-00006#1---add---end---
            
         UPDATE sfcb_t SET sfcb041 = sfcb041 - l_pmdp023
          WHERE sfcbent   = g_enterprise
            AND sfcbdocno = l_pmdp003
            AND sfcb001   = l_pmdp004
            #AND sfcb003 = l_pmdp009  #160316-00006#1 mark
            #AND sfcb004 = l_pmdp010  #160316-00006#1 mark
            #160316-00006#1---add---begin---
            AND (CASE WHEN sfcb003 IS NULL THEN ' ' ELSE sfcb003 END) = l_pmdp009
            AND (CASE WHEN sfcb004 IS NULL THEN ' ' ELSE sfcb004 END) = l_pmdp010
            #160316-00006#1---add---end---
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'update sfcb041'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE                 
            RETURN r_success                             
         END IF
      END FOREACH
   END IF
   
   #更新單據狀態碼
   UPDATE pmdl_t SET pmdlstus = 'X'
    WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
      
   RETURN  r_success
   
END FUNCTION
################################################################################
# Descriptions...: 計算採購項次已收貨數量之最小套數
# Memo...........:
# Usage..........: CALL s_apmt500_count_min_pmdo015 (p_pmdodocno,p_pmdoseq)
#                  RETURNING r_min_pmdo015,r_success
# Input parameter: p_pmdodocno   採購單號
#                : p_pmdoseq     採購單項次
# Return code....: r_min_pmdo015 已收貨量最小套數
#                : r_success     處理狀態
# Date & Author..: 2014/03/03 By Elise
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_count_min_pmdo015(p_pmdodocno,p_pmdoseq)
DEFINE p_pmdodocno    LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq      LIKE pmdo_t.pmdoseq
DEFINE r_min_pmdo015  LIKE pmdo_t.pmdo015
DEFINE r_success      LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5
DEFINE l_seq1         LIKE type_t.num20_6

       WHENEVER ERROR CONTINUE

       LET r_success = TRUE
       LET r_min_pmdo015 = 0
       
       IF cl_null(p_pmdodocno) THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'sub-00228'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE 
          RETURN r_min_pmdo015,r_success 
       END IF
       IF cl_null(p_pmdoseq) THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'sub-00406'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE 
          RETURN r_min_pmdo015,r_success 
       END IF
       
       #檢核p_pmdodocno,p_pmdoseq是否存在[T.採購單單身]
       LET l_n=0
       SELECT COUNT(*) INTO l_n FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       IF l_n = 0 THEN                 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00335'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_min_pmdo015,r_success       
       END IF
       
       #依傳入之採購單號、採購項次抓取[T.採購交期明細檔]所有符合資料
       LET l_seq1 = 0
       SELECT MIN(a) 
         INTO l_seq1 
         FROM (SELECT SUM((pmdo015-pmdo016) /pmdo008) a                                                       
                 FROM pmdo_t
                WHERE pmdoent = g_enterprise
                  AND pmdodocno = p_pmdodocno
                  AND pmdoseq = p_pmdoseq
               GROUP BY pmdoseq1)     

       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = l_seq1
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE   
       ELSE          
          LET r_min_pmdo015= l_seq1
       END IF
       
   RETURN r_min_pmdo015,r_success    
   
END FUNCTION

################################################################################
# Descriptions...: 产生采购单
# Memo...........:
# Usage..........: CALL s_apmt500_gen(p_type,p_key1,p_key2,p_doc_type,p_date,p_combine)
#                  RETURNING r_success,r_start_no,r_end_no
# Input parameter: p_type         来源类型
#                                 '1'
#                                 '2'
#                                 '3'
#                                 '4'  工单产生采购单
#                                 '6'  重复性工单产生采购单
#                : p_key1         来源单号
#                : p_key2         来源项次
#                : p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否   
# Return code....: r_success      成功否标识符
#                : r_start_no     起始QC单号
#                : r_end_no       截止QC单号
# Date & Author..: 2014/04/21 By Carrier
################################################################################
PUBLIC FUNCTION s_apmt500_gen(p_type,p_key1,p_key2,p_doc_type,p_date,p_combine)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE p_key1          LIKE qcba_t.qcba001
   DEFINE p_key2          LIKE qcba_t.qcba002
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE qcba_t.qcbadocno
   DEFINE r_end_no        LIKE qcba_t.qcbadocno
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_start_no      LIKE qcba_t.qcbadocno
   DEFINE l_end_no        LIKE qcba_t.qcbadocno
   
   WHENEVER ERROR CONTINUE
   LET r_success   = FALSE
   LET r_start_no  = ''
   LET r_end_no    = ''

   IF cl_null(p_type) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00280'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_start_no,r_end_no
   END IF

   CASE p_type
        WHEN '1'
        WHEN '2'
        WHEN '3'                
        WHEN '4' CALL s_apmt500_gen_4(p_key1,p_key2,p_doc_type,p_date,p_combine)
                      RETURNING l_success,l_start_no,l_end_no
        WHEN '6' CALL s_apmt500_gen_6(p_key1,p_key2,p_doc_type,p_date,p_combine)
                      RETURNING l_success,l_start_no,l_end_no
   END CASE

   IF NOT l_success THEN
      RETURN r_success,r_start_no,r_end_no
   END IF


   LET r_success  = TRUE
   LET r_start_no = l_start_no
   LET r_end_no   = l_end_no

   RETURN r_success,r_start_no,r_end_no

END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单
# Memo...........:
# Usage..........: CALL s_apmt500_gen_4(p_key1,p_key2,p_doc_type,p_date,p_combine)
#                  RETURNING r_success,r_start_no,r_end_no
# Input parameter: p_key1         来源单号
#                : p_key2         来源项次
#                : p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否  
# Return code....: r_success      成功否标识符
#                : r_start_no     起始QC单号
#                : r_end_no       截止QC单号
# Date & Author..: 2014/04/21 By Carrier
################################################################################
PUBLIC FUNCTION s_apmt500_gen_4(p_key1,p_key2,p_doc_type,p_date,p_combine)
   DEFINE p_key1          LIKE qcba_t.qcba001
   DEFINE p_key2          LIKE qcba_t.qcba002
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1   
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE qcba_t.qcbadocno
   DEFINE r_end_no        LIKE qcba_t.qcbadocno
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno
   DEFINE l_pmdl          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE l_n             LIKE type_t.num5
   
   LET r_success  = FALSE
   LET r_start_no = ''
   LET r_end_no   = ''

   IF p_combine = 'N' THEN
      LET g_sql = " SELECT UNIQUE sfcbdocno,sfcb013,pmdl011,pmdl015,pmdl017 ",
                  "   FROM asfp400_tmp_t",
                  "  ORDER BY sfcbdocno,sfcb013 "
   ELSE
      LET g_sql = " SELECT UNIQUE '',sfcb013,pmdl011,pmdl015,pmdl017 ",
                  "   FROM asfp400_tmp_t",
                  "  ORDER BY sfcb013 "
   END IF   

   PREPARE s_apmt500_gen_4_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare s_apmt500_gen_4_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_start_no,r_end_no
   END IF

   DECLARE s_apmt500_gen_4_cs1 CURSOR FOR s_apmt500_gen_4_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare s_apmt500_gen_4_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_start_no,r_end_no
   END IF

   FOREACH s_apmt500_gen_4_cs1 INTO l_pmdl.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_apmt500_gen_4_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success,r_start_no,r_end_no
      END IF
      
      #add by wuxj 20141022
      #当供应商编号、税别、币别、取价方式对应同一工单时，汇总时也应记录工单单号
      SELECT COUNT(UNIQUE sfcbdocno) INTO l_n FROM asfp400_tmp_t
       WHERE sfcb013 = l_pmdl.pmdl004 AND pmdl011 = l_pmdl.pmdl011
         AND pmdl015 = l_pmdl.pmdl015 AND pmdl017 = l_pmdl.pmdl017
      IF l_n = 1 THEN
         SELECT sfcbdocno INTO l_pmdl.sfcbdocno FROM asfp400_tmp_t
          WHERE sfcb013 = l_pmdl.pmdl004 AND pmdl011 = l_pmdl.pmdl011
            AND pmdl015 = l_pmdl.pmdl015 AND pmdl017 = l_pmdl.pmdl017
      END IF
      #end add


      #插入"pmdl_t:採購單頭檔"
      CALL s_apmt500_gen_4_ins_pmdl(p_doc_type,p_date,p_combine,l_pmdl.*)
           RETURNING l_success,l_pmdldocno
      IF NOT l_success THEN
         RETURN r_success,r_start_no,r_end_no
      END IF
      
      #插入"pmdn_t:採購明細檔"
      CALL s_apmt500_gen_4_ins_pmdn(l_pmdldocno,l_pmdl.*)
           RETURNING l_success           
      IF NOT l_success THEN
         RETURN r_success,r_start_no,r_end_no
      END IF

      IF cl_null(r_start_no) THEN
         LET r_start_no = l_pmdldocno
      END IF

      LET r_end_no = l_pmdldocno
      
      
   END FOREACH

   LET r_success = TRUE


   RETURN r_success,r_start_no,r_end_no


END FUNCTION
################################################################################
# Descriptions...: 取得未稅金額、税额、含稅金額
# Memo...........:
# Usage..........: CALL s_apmt500_get_amount(p_pmdldocno,p_pmdnseq,p_pmdl015,p_pmdn007,p_pmdn015,p_pmdn016)
#                  RETURNING r_pmdn046,r_pmdn048,r_pmdn047
# Input parameter: p_pmdldocno    單據編號
#                : p_pmdnseq      項次
#                : p_pmdl015      币别
#                : p_pmdn007      數量
#                : p_pmdn015      單價
#                : p_pmdn016      稅別
# Return code....: r_pmdn046      未稅金額
# Return code....: r_pmdn048      稅額
#                : r_pmdn047      含稅金額
# Date & Author..: 2014/03/28 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_amount(p_pmdldocno,p_pmdnseq,p_pmdl015,p_pmdn007,p_pmdn015,p_pmdn016)
DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq         LIKE pmdn_t.pmdnseq
DEFINE p_pmdl015         LIKE pmdl_t.pmdl015
DEFINE p_pmdn007         LIKE pmdn_t.pmdn007
DEFINE p_pmdn015         LIKE pmdn_t.pmdn015
DEFINE p_pmdn016         LIKE pmdn_t.pmdn016
DEFINE r_pmdn046         LIKE pmdn_t.pmdn046 
DEFINE r_pmdn048         LIKE pmdn_t.pmdn048
DEFINE r_pmdn047         LIKE pmdn_t.pmdn047 
DEFINE l_money           LIKE pmdn_t.pmdn046 
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115
DEFINE l_xrcd123         LIKE xrcd_t.xrcd113
DEFINE l_xrcd124         LIKE xrcd_t.xrcd114
DEFINE l_xrcd125         LIKE xrcd_t.xrcd115
DEFINE l_xrcd133         LIKE xrcd_t.xrcd113
DEFINE l_xrcd134         LIKE xrcd_t.xrcd114
DEFINE l_xrcd135         LIKE xrcd_t.xrcd115
DEFINE l_pmdl016         LIKE pmdl_t.pmdl016  #170605-00038#1 add

   LET r_pmdn046 = 0
   LET r_pmdn048 = 0
   LET r_pmdn047 = 0
   
   IF cl_null(p_pmdldocno) OR cl_null(p_pmdnseq) OR cl_null(p_pmdn007) OR
      cl_null(p_pmdn015) OR cl_null(p_pmdn016) THEN
      RETURN r_pmdn046,r_pmdn048,r_pmdn047
   END IF

   LET l_money = p_pmdn007 * p_pmdn015
   #170605-00038#1--s
   SELECT pmdl016 INTO l_pmdl016 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   #170605-00038#1--e
   #170710-00026#1-s
   IF cl_null(l_pmdl016) THEN
      LET l_pmdl016 = p_pmdn016
   END IF
   #170710-00026#1-e
   CALL s_tax_ins(p_pmdldocno,p_pmdnseq,0,g_site,l_money,p_pmdn016,
                   #p_pmdn007,p_pmdl015,1,' ',1,1)  #170605-00038#1 mark
                  p_pmdn007,p_pmdl015,l_pmdl016,' ',1,1)  #170605-00038#1 add
        RETURNING r_pmdn046,r_pmdn048,r_pmdn047,l_xrcd113,l_xrcd114,l_xrcd115,
                  l_xrcd123,l_xrcd124,l_xrcd125,l_xrcd133,l_xrcd134,l_xrcd135

   IF cl_null(r_pmdn046) THEN LET r_pmdn046 = 0 END IF
   IF cl_null(r_pmdn048) THEN LET r_pmdn048 = 0 END IF
   IF cl_null(r_pmdn047) THEN LET r_pmdn047 = 0 END IF
   
   #呼叫幣別取位應用元件對金額作取位(依單頭幣別做取位基準)
   CALL s_curr_round(g_site,p_pmdl015,r_pmdn046,'2') RETURNING r_pmdn046
   CALL s_curr_round(g_site,p_pmdl015,r_pmdn048,'2') RETURNING r_pmdn048
   CALL s_curr_round(g_site,p_pmdl015,r_pmdn047,'2') RETURNING r_pmdn047

   RETURN r_pmdn046,r_pmdn048,r_pmdn047

END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 产生采购单头pmdl_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_4_ins_pmdl(p_doc_type,p_date,p_combine,p_pmdl)
#                  RETURNING r_success,r_pmdldocno
# Input parameter: p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否
#                : p_pmdl         采购单头信息   
# Return code....: r_success      成功否标识符
#                : r_pmdldocno    产生的采购单号
# Date & Author..: 2014/04/22 By Carrier
################################################################################
PUBLIC FUNCTION s_apmt500_gen_4_ins_pmdl(p_doc_type,p_date,p_combine,p_pmdl)
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1   
   DEFINE p_pmdl          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_pmdldocno     LIKE pmdl_t.pmdldocno
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdl          RECORD LIKE pmdl_t.*
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_doc_type      LIKE ooba_t.ooba002
   #161124-00048#9 mod-S
#   DEFINE l_pmal          RECORD LIKE pmal_t.*
#   DEFINE l_pmab          RECORD LIKE pmab_t.*
   DEFINE l_pmal RECORD  #採購控制組供應商預設條件檔
          pmalent LIKE pmal_t.pmalent, #企业编号
          pmal001 LIKE pmal_t.pmal001, #交易对象编号
          pmal002 LIKE pmal_t.pmal002, #控制组编号
          pmal003 LIKE pmal_t.pmal003, #惯用交易币种
          pmal004 LIKE pmal_t.pmal004, #惯用税务规则
          pmal005 LIKE pmal_t.pmal005, #惯用发票开立方式
          pmal006 LIKE pmal_t.pmal006, #惯用付款条件
          pmal008 LIKE pmal_t.pmal008, #惯用采购渠道
          pmal009 LIKE pmal_t.pmal009, #惯用采购分类
          pmal010 LIKE pmal_t.pmal010, #惯用报表语言
          pmal011 LIKE pmal_t.pmal011, #惯用交运方式
          pmal012 LIKE pmal_t.pmal012, #惯用交运起点
          pmal013 LIKE pmal_t.pmal013, #惯用交运终点
          pmal014 LIKE pmal_t.pmal014, #惯用卸货港
          pmal015 LIKE pmal_t.pmal015, #惯用佣金率
          pmal016 LIKE pmal_t.pmal016, #折扣率
          pmal017 LIKE pmal_t.pmal017, #惯用ForWarder
          pmal018 LIKE pmal_t.pmal018, #惯用Notify
          pmal019 LIKE pmal_t.pmal019, #负责采购人员
          pmal020 LIKE pmal_t.pmal020, #惯用交易条件
          pmal021 LIKE pmal_t.pmal021, #惯用取价方式
          pmal022 LIKE pmal_t.pmal022, #惯用票类型
          pmal023 LIKE pmal_t.pmal023, #惯用内外购
          pmal024 LIKE pmal_t.pmal024, #惯用汇率计算基准
          pmalownid LIKE pmal_t.pmalownid, #资料所有者
          pmalowndp LIKE pmal_t.pmalowndp, #资料所有部门
          pmalcrtid LIKE pmal_t.pmalcrtid, #资料录入者
          pmalcrtdp LIKE pmal_t.pmalcrtdp, #资料录入部门
          pmalcrtdt LIKE pmal_t.pmalcrtdt, #资料创建日
          pmalmodid LIKE pmal_t.pmalmodid, #资料更改者
          pmalmoddt LIKE pmal_t.pmalmoddt, #最近更改日
          pmalstus LIKE pmal_t.pmalstus, #状态码
          pmal025 LIKE pmal_t.pmal025  #负责采购部门
   END RECORD
   DEFINE l_pmab RECORD  #交易對象據點檔
          pmabent LIKE pmab_t.pmabent, #企业编号
          pmabsite LIKE pmab_t.pmabsite, #营运据点
          pmab001 LIKE pmab_t.pmab001, #交易对象编号
          pmab002 LIKE pmab_t.pmab002, #信用额度检查
          pmab003 LIKE pmab_t.pmab003, #额度交易对象
          pmab004 LIKE pmab_t.pmab004, #信用评核等级
          pmab005 LIKE pmab_t.pmab005, #额度计算币种
          pmab006 LIKE pmab_t.pmab006, #企业额度
          pmab007 LIKE pmab_t.pmab007, #可超出率
          pmab008 LIKE pmab_t.pmab008, #有效期限
          pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
          pmab010 LIKE pmab_t.pmab010, #允许除外额度
          pmab011 LIKE pmab_t.pmab011, #额度警示水准一
          pmab012 LIKE pmab_t.pmab012, #水准一通知层
          pmab013 LIKE pmab_t.pmab013, #额度警示水准二
          pmab014 LIKE pmab_t.pmab014, #水准二通知层
          pmab015 LIKE pmab_t.pmab015, #额度警示水准三
          pmab016 LIKE pmab_t.pmab016, #水准三通知层
          pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
          pmab018 LIKE pmab_t.pmab018, #预期应收通知层
          pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
          pmab031 LIKE pmab_t.pmab031, #负责采购人员
          pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
          pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
          pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
          pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
          pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
          pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
          pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
          pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
          pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
          pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
          pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
          pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
          pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
          pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
          pmab046 LIKE pmab_t.pmab046, #供应商折扣率
          pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
          pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
          pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
          pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
          pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
          pmab052 LIKE pmab_t.pmab052, #可提前收货天数
          pmab053 LIKE pmab_t.pmab053, #惯用交易条件
          pmab054 LIKE pmab_t.pmab054, #惯用取价方式
          pmab055 LIKE pmab_t.pmab055, #应付账款类别
          pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
          pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
          pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
          pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
          pmab061 LIKE pmab_t.pmab061, #价格评分
          pmab062 LIKE pmab_t.pmab062, #达交率评分
          pmab063 LIKE pmab_t.pmab063, #质量评分
          pmab064 LIKE pmab_t.pmab064, #配合度评分
          pmab065 LIKE pmab_t.pmab065, #调整加减分
          pmab066 LIKE pmab_t.pmab066, #定性评分一
          pmab067 LIKE pmab_t.pmab067, #定性评分二
          pmab068 LIKE pmab_t.pmab068, #定性评分三
          pmab069 LIKE pmab_t.pmab069, #定性评分四
          pmab070 LIKE pmab_t.pmab070, #定性评分五
          pmab071 LIKE pmab_t.pmab071, #检验程度
          pmab072 LIKE pmab_t.pmab072, #检验水准
          pmab073 LIKE pmab_t.pmab073, #检验级数
          pmab080 LIKE pmab_t.pmab080, #客户ABC分类
          pmab081 LIKE pmab_t.pmab081, #负责业务人员
          pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
          pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
          pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
          pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
          pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
          pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
          pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
          pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
          pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
          pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
          pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
          pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
          pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
          pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
          pmab096 LIKE pmab_t.pmab096, #客户折扣率
          pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
          pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
          pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
          pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
          pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
          pmab102 LIKE pmab_t.pmab102, #可提前交货天数
          pmab103 LIKE pmab_t.pmab103, #惯用交易条件
          pmab104 LIKE pmab_t.pmab104, #惯用取价方式
          pmab105 LIKE pmab_t.pmab105, #应收账款类别
          pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
          pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
          pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
          pmabownid LIKE pmab_t.pmabownid, #资料所有者
          pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
          pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
          pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
          pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
          pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
          pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
          pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
          pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
          pmabstus LIKE pmab_t.pmabstus, #状态码
          pmab059 LIKE pmab_t.pmab059, #负责采购部门
          pmab109 LIKE pmab_t.pmab109, #负责业务部门
          pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
          pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
          pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
          pmab020 LIKE pmab_t.pmab020, #除外额有效日期
          pmab112 LIKE pmab_t.pmab112  #是否使用EC
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_pmal002       LIKE pmal_t.pmal002   #控制组
   DEFINE l_ooef016       LIKE ooef_t.ooef016
   DEFINE l_acc40         LIKE type_t.chr80      
   DEFINE l_oofb002       LIKE oofb_t.oofb002
   DEFINE l_sfaa066       LIKE sfaa_t.sfaa066
   DEFINE l_sfaa067       LIKE sfaa_t.sfaa067
   DEFINE l_site          LIKE pmdl_t.pmdlsite
   DEFINE l_scc40         LIKE type_t.chr2   #20151029 by stellar add
   DEFINE l_cnt           LIKE type_t.num5   #170324-00115#1 add
   
   LET r_success = FALSE
   LET r_pmdldocno = ''

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success,r_pmdldocno
   END IF

   INITIALIZE l_pmdl.* TO NULL

   #插入"采购單頭檔"
   
   #2015/09/08 by stellar add ----- (S)
   #由asft300的轉委外採購ACTION進來的，則委外採購單號=工單單號
   #IF g_prog = 'asft300' AND g_action_choice = 'sub_po' THEN  #160727-00025#9
   #IF (g_prog = 'asft300' OR g_prog = 'asft304') AND g_action_choice = 'sub_po' THEN #160727-00025#9   #170301-00021#8 by 09263 --mark
   IF (g_prog MATCHES 'asft300*' OR g_prog MATCHES 'asft304*') AND g_action_choice = 'sub_po' THEN   #170301-00021#8 by 09263 --add
   #   LET l_pmdl.pmdldocno = p_pmdl.sfcbdocno   #170324-00115#1 mark
   #ELSE                                         #170324-00115#1 mark
   #2015/09/08 by stellar add ----- (E)
   #170324-00115#1--add--start--
      SELECT COUNT(1) INTO l_cnt
        FROM pmdl_t 
       WHERE pmdlent = g_enterprise 
         AND pmdlsite = g_site
         AND pmdldocno = p_pmdl.sfcbdocno
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         LET l_pmdl.pmdldocno = p_pmdl.sfcbdocno
      END IF 
   END IF
   IF (p_combine = 'Y' AND cl_null(l_pmdl.pmdldocno)) OR p_combine = 'N' THEN
   #170324-00115#1--add--end----
   #传入的"采购单别"为空时,仅当按工单产生PO时,有机会从工单的参数档参数中找对应的采购单别
   #IF p_combine = 'N' THEN #170324-00115#1 mark
      IF cl_null(p_doc_type) AND NOT cl_null(p_pmdl.sfcbdocno) THEN
         CALL s_aooi200_get_slip(p_pmdl.sfcbdocno)
              RETURNING l_success,l_doc_type
         IF NOT l_success THEN
            RETURN r_success,r_pmdldocno
         END IF
         LET p_doc_type = cl_get_doc_para(g_enterprise,g_site,l_doc_type,'D-MFG-0066')
         IF cl_null(p_doc_type) THEN
            #工单单别 %1 对应的参数D-MFG-0066值[委外採購單別]为空!
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00247'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_doc_type
            CALL cl_err()
   
            RETURN r_success,r_pmdldocno
         END IF
      END IF
   #END IF                 #170324-00115#1 mark
      
      #传入的采购单据日期为空时,用当前日期
      IF cl_null(p_date) THEN
         LET p_date = cl_get_today()
      END IF
     
      ##單號
      CALL s_aooi200_gen_docno(g_site,p_doc_type,p_date,'apmt501')
           RETURNING l_success,l_pmdl.pmdldocno
      IF NOT l_success THEN
         RETURN r_success,r_pmdldocno
      END IF
   END IF   #2015/09/08 by stellar add for 委外採購單號=工單單號
   
   #取单别默认值
   CALL s_apmt500_get_doc_default(l_pmdl.*)
        RETURNING l_pmdl.*

   LET l_pmdl.pmdlent   =  g_enterprise                 #企業編號        
   LET l_pmdl.pmdlsite  =  g_site                       #營運據點                
   LET l_pmdl.pmdldocdt =  p_date                       #採購日期        
   LET l_pmdl.pmdl001   =  0                            #版次      
   IF cl_null(l_pmdl.pmdl002) THEN  
      LET l_pmdl.pmdl002   =  g_user                    #採購人員      
   END IF      
   IF cl_null(l_pmdl.pmdl003) THEN  
      LET l_pmdl.pmdl003   =  g_dept                    #採購部門        
   END IF      
   LET l_pmdl.pmdl004   =  p_pmdl.pmdl004               #供應商編號      
   LET l_pmdl.pmdl005   =  '2'                          #採購性質        
   #LET l_pmdl.pmdl006   =  '1'                          #多角性質
   IF cl_null(l_pmdl.pmdl006) THEN
      LET l_pmdl.pmdl006 = '1'
   END IF
   
   LET l_pmdl.pmdl007   =  '4'                          #資料來源類型     
   LET l_pmdl.pmdl008   =  p_pmdl.sfcbdocno             #來源單號

   #pmdlsite(營運據點)=g_site,若傳入之"當站營運據點"有值,則為當站營運據點
   #pmdl006(多角性質)=1.一般交易,若工單之"多角流程序號"有值,則為6.中間交易
   #pmdl007(資料來源)=4.工單轉入
   #pmdl051(多角流程代碼)=工單之"多角流程代碼"
   #pmdl031(多角流程序號)=工單之"多角流程序號"
   IF NOT cl_null(p_pmdl.sfcbdocno) THEN
      CALL s_aooi200_get_site(p_pmdl.sfcbdocno) RETURNING l_success,l_site
      IF l_success THEN
         #根據據點截取字段，獲取完整的營運據點
         SELECT ooef001 INTO l_pmdl.pmdlsite FROM ooef_t WHERE ooefent = g_enterprise AND ooef005 = l_site
         IF cl_null(l_pmdl.pmdlsite) THEN
            LET l_pmdl.pmdlsite  =  g_site
         END IF
      ELSE
         LET l_pmdl.pmdlsite  =  g_site
      END IF
   END IF
   
   LET l_sfaa066 = ''
   LET l_sfaa067 = ''
   SELECT sfaa066,sfaa067 INTO l_sfaa066,l_sfaa067 FROM sfaa_t WHERE sfaaent = g_enterprise AND sfaadocno = p_pmdl.sfcbdocno
   IF NOT cl_null(l_sfaa067) THEN
      LET l_pmdl.pmdl006   =  '6'  #若工單之"多角流程序號"有值,則為6.中間交易
   END IF
   LET l_pmdl.pmdl051 = l_sfaa066  #多角流程代碼
   LET l_pmdl.pmdl031 = l_sfaa067  #多角流程序號
   

   #按g_user/g_dept/供应商值选出可预设的控制组代号
   CALL s_control_get_pmal002('4',g_user,g_dept,l_pmdl.pmdl004)
        RETURNING l_success,l_pmal002
   IF NOT l_success THEN
      LET l_pmal002 = NULL
   END IF

   #取供应商的控制组预设条件
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmal.* FROM pmal_t
   SELECT pmalent,pmal001,pmal002,pmal003,pmal004,
          pmal005,pmal006,pmal008,pmal009,pmal010,
          pmal011,pmal012,pmal013,pmal014,pmal015,
          pmal016,pmal017,pmal018,pmal019,pmal020,
          pmal021,pmal022,pmal023,pmal024,pmalownid,
          pmalowndp,pmalcrtid,pmalcrtdp,pmalcrtdt,pmalmodid,
          pmalmoddt,pmalstus,pmal025
     INTO l_pmal.* 
     FROM pmal_t
   #161124-00048#9 mod-E
    WHERE pmalent = g_enterprise
      AND pmal001 = l_pmdl.pmdl004
      AND pmal002 = l_pmal002
   #取供应商主档的预设条件
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmab.* FROM pmab_t
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
     INTO l_pmab.* 
     FROM pmab_t
   #161124-00048#9 mod-E
    WHERE pmabent  = g_enterprise
      AND pmabsite = g_site
      AND pmab001  = l_pmdl.pmdl004
   IF cl_null(l_pmdl.pmdl009) THEN
      LET l_pmdl.pmdl009   = l_pmal.pmal006             #付款條件 
   END IF
   IF cl_null(l_pmdl.pmdl009) THEN
      LET l_pmdl.pmdl009= l_pmab.pmab037
   END IF
   IF cl_null(l_pmdl.pmdl010) THEN
      LET l_pmdl.pmdl010   = l_pmal.pmal020             #交易條件   
   END IF   
   IF cl_null(l_pmdl.pmdl010) THEN
      LET l_pmdl.pmdl010= l_pmab.pmab053
   END IF   
   IF cl_null(l_pmdl.pmdl011) THEN
      LET l_pmdl.pmdl011   = p_pmdl.pmdl011                #稅別 
   END IF
   
   #稅率/#單價含稅否     
   SELECT oodb006,oodb005 INTO l_pmdl.pmdl012,l_pmdl.pmdl013
     FROM oodb_t,ooef_t
     WHERE ooefent = oodbent AND oodbent = g_enterprise
       AND ooef001 = g_site 
       AND ooef019 = oodb001
       AND oodb002 = l_pmdl.pmdl011
       
   IF cl_null(l_pmdl.pmdl015) THEN
      LET l_pmdl.pmdl015   = p_pmdl.pmdl015                #幣別       
   END IF
   
   #匯率   
   SELECT ooef016 INTO l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   #20151029 by stellar modify ----- (S)
#   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0010') RETURNING l_acc40
#   CALL s_aooi160_get_exrate('1',g_site,l_pmdl.pmdldocdt,l_pmdl.pmdl015,l_ooef016,0,l_acc40)
#        RETURNING l_pmdl.pmdl016
   #取匯率
   IF cl_null(l_pmdl.pmdl054) THEN      
      LET l_pmdl.pmdl054   = l_pmal.pmal023                #慣用內外購  
   END IF    
   IF cl_null(l_pmdl.pmdl054) THEN
      LET l_pmdl.pmdl054= l_pmab.pmab057
   END IF  

   IF NOT cl_null(l_pmdl.pmdl015) THEN
      #根據內外購獲取當前營運據點參數設置的匯率類型
      LET l_scc40 = ''
      IF l_pmdl.pmdl054 = '1' THEN
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
      ELSE
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0015')
      END IF
      IF NOT cl_null(l_scc40) THEN
         CALL s_aooi160_get_exrate('1',g_site,g_today,l_pmdl.pmdl015,l_ooef016,0,l_scc40)
              RETURNING l_pmdl.pmdl016
      END IF
   END IF
   #20151029 by stellar modify ----- (E)
  
   IF cl_null(l_pmdl.pmdl017) THEN
      LET l_pmdl.pmdl017   = p_pmdl.pmdl017             #取價方式     
   END IF      
   IF cl_null(l_pmdl.pmdl018) THEN
      LET l_pmdl.pmdl018   = ''                         #付款優惠條件    
   END IF
   IF cl_null(l_pmdl.pmdl019) THEN
      LET l_pmdl.pmdl019   = 'N'                        #納入 MPS/MRP計算
   END IF
   IF cl_null(l_pmdl.pmdl020) THEN
      LET l_pmdl.pmdl020   = l_pmal.pmal011             #運送方式    
   END IF
   IF cl_null(l_pmdl.pmdl020) THEN
      LET l_pmdl.pmdl020= l_pmab.pmab040
   END IF  

   IF cl_null(l_pmdl.pmdl021) THEN
      #付款供應商
      DECLARE s_apmt500_gen_4_ins_pmdl_sel_cs1 SCROLL CURSOR FOR
       SELECT pmac002 FROM pmac_t
        WHERE pmacent  = g_enterprise
          AND pmac001  = l_pmdl.pmdl004
          AND pmac003  = '1'
          AND pmacstus = 'Y'
        ORDER BY pmac004 DESC
      OPEN s_apmt500_gen_4_ins_pmdl_sel_cs1 
      FETCH FIRST s_apmt500_gen_4_ins_pmdl_sel_cs1 INTO l_pmdl.pmdl021
      IF cl_null(l_pmdl.pmdl021) THEN LET l_pmdl.pmdl021 = l_pmdl.pmdl004 END IF
   END IF
      
   IF cl_null(l_pmdl.pmdl022) THEN
      #送貨供應商
      DECLARE s_apmt500_gen_4_ins_pmdl_sel_cs2 SCROLL CURSOR FOR
       SELECT pmac002 FROM pmac_t
        WHERE pmacent  = g_enterprise
          AND pmac001  = l_pmdl.pmdl004
          AND pmac003  = '2'
          AND pmacstus = 'Y'
        ORDER BY pmac004 DESC
      OPEN s_apmt500_gen_4_ins_pmdl_sel_cs2
      FETCH FIRST s_apmt500_gen_4_ins_pmdl_sel_cs2 INTO l_pmdl.pmdl022   
      IF cl_null(l_pmdl.pmdl022) THEN LET l_pmdl.pmdl022 = l_pmdl.pmdl004 END IF
   END IF

   IF cl_null(l_pmdl.pmdl023) THEN
      LET l_pmdl.pmdl023   = l_pmal.pmal008             #採購通路   
   END IF      
   IF cl_null(l_pmdl.pmdl023) THEN
      LET l_pmdl.pmdl023= l_pmab.pmab038
   END IF    
 
   IF cl_null(l_pmdl.pmdl024) THEN
      LET l_pmdl.pmdl024   = l_pmal.pmal009             #採購分類         
   END IF
   IF cl_null(l_pmdl.pmdl024) THEN
      LET l_pmdl.pmdl024= l_pmab.pmab039
   END IF      

#170713-00030#1-s mark
#  #送貨地址
#  SELECT pmaa027 INTO l_oofb002 FROM pmaa_t
#   WHERE pmaaent = g_enterprise
#     AND pmaa001 = l_pmdl.pmdl004
#     
#  IF cl_null(l_pmdl.pmdl025) THEN   
#     DECLARE s_apmt500_gen_4_ins_pmdl_sel_cs3 SCROLL CURSOR FOR
#      SELECT oofb019 FROM oofb_t
#       WHERE oofbent  = g_enterprise
#         AND oofb002  = l_oofb002
#         AND oofb008  = '3'                        #161229-00014#1---dujuan-----'6' 改 ‘3’
#         AND oofbstus = 'Y'
#       ORDER BY oofb010 DESC
#     OPEN s_apmt500_gen_4_ins_pmdl_sel_cs3 
#     FETCH FIRST s_apmt500_gen_4_ins_pmdl_sel_cs3 INTO l_pmdl.pmdl025 
#  END IF
#  #帳款地址
#  IF cl_null(l_pmdl.pmdl026) THEN   
#     DECLARE s_apmt500_gen_4_ins_pmdl_sel_cs4 SCROLL CURSOR FOR
#      SELECT oofb019 FROM oofb_t
#       WHERE oofbent  = g_enterprise
#         AND oofb002  = l_oofb002
#         AND oofb008  = '5'
#         AND oofbstus = 'Y'
#       ORDER BY oofb010 DESC
#     OPEN s_apmt500_gen_4_ins_pmdl_sel_cs4 
#     FETCH FIRST s_apmt500_gen_4_ins_pmdl_sel_cs4 INTO l_pmdl.pmdl026
#  END IF
#170713-00030#1-e mark
   #170713-00030#1-s
   SELECT oofa001 INTO l_oofb002 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
   SELECT oofb019 INTO l_pmdl.pmdl025 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofb002 AND oofb008 = '3' AND oofb010 = 'Y'
   SELECT oofb019 INTO l_pmdl.pmdl026 FROM oofb_t WHERE oofbent = g_enterprise AND oofb002 = l_oofb002 AND oofb008 = '5' AND oofb010 = 'Y'
   #170713-00030#1-e
   
   #供應商連絡人
   IF cl_null(l_pmdl.pmdl027) THEN   
      DECLARE s_apmt500_gen_4_ins_pmdl_sel_cs5 SCROLL CURSOR FOR
       SELECT pmaj002 FROM pmaj_t
        WHERE pmajent  = g_enterprise
          AND pmaj001  = l_pmdl.pmdl004
          AND pmajstus = 'Y'
        ORDER BY pmaj004 DESC
      OPEN s_apmt500_gen_4_ins_pmdl_sel_cs5 
      FETCH FIRST s_apmt500_gen_4_ins_pmdl_sel_cs5 INTO l_pmdl.pmdl027
   END IF
             
   IF cl_null(l_pmdl.pmdl028) THEN             
      LET l_pmdl.pmdl028   = ''                         #一次性交易對象識別碼 
   END IF      
   IF cl_null(l_pmdl.pmdl029) THEN             
      LET l_pmdl.pmdl029   = g_dept                     #收貨部門       
   END IF      
   LET l_pmdl.pmdl030   = 'N'                           #多角貿易已拋轉                      
   LET l_pmdl.pmdl031   = ''                            #多角序號                            
   LET l_pmdl.pmdl032   = ''                            #最終客戶  
   IF cl_null(l_pmdl.pmdl033) THEN             
      LET l_pmdl.pmdl033   = l_pmal.pmal022             #發票類型    
   END IF      
   IF cl_null(l_pmdl.pmdl033) THEN
      LET l_pmdl.pmdl033= l_pmab.pmab056
   END IF    
   LET l_pmdl.pmdl040   = 0                             #採購總未稅金額                      
   LET l_pmdl.pmdl041   = 0                             #採購總含稅金額                      
   LET l_pmdl.pmdl042   = 0                             #採購總稅額    
   IF cl_null(l_pmdl.pmdl043) THEN      
      LET l_pmdl.pmdl043   = ''                         #留置原因     
   END IF      
   IF cl_null(l_pmdl.pmdl044) THEN      
      LET l_pmdl.pmdl044   = ''                         #備註                                
   END IF      
   IF cl_null(l_pmdl.pmdl046) THEN      
      LET l_pmdl.pmdl046   = '1'                        #預付款發票開立方式  
   END IF      
   LET l_pmdl.pmdl047   = 'N'                           #物流結案                            
   LET l_pmdl.pmdl048   = 'N'                           #帳流結案                            
   LET l_pmdl.pmdl049   = 'N'                           #金流結案    

   #20151029 by stellar mark ----- (S)
   #stellar mark:會影響取匯率，故挪到前面給值
#   IF cl_null(l_pmdl.pmdl054) THEN      
#      LET l_pmdl.pmdl054   = l_pmal.pmal023                #慣用內外購  
#   END IF      
#   IF cl_null(l_pmdl.pmdl054) THEN
#      LET l_pmdl.pmdl054= l_pmab.pmab107
#   END IF  
#   IF cl_null(l_pmdl.pmdl054) THEN
#      LET l_pmdl.pmdl054= '1'
#   END IF
   #20151029 by stellar mark ----- (E)
   
   IF cl_null(l_pmdl.pmdl055) THEN      
      LET l_pmdl.pmdl055   = l_pmal.pmal024                #慣用匯率計算基準 
   END IF
   IF cl_null(l_pmdl.pmdl055) THEN
      #20151029 by stellar modify ----- (S)
#      LET l_pmdl.pmdl055= l_pmab.pmab108
      LET l_pmdl.pmdl055= l_pmab.pmab058
      #20151029 by stellar modify ----- (E)
   END IF  
   IF cl_null(l_pmdl.pmdl055) THEN
      LET l_pmdl.pmdl055= '1'
   END IF  

   LET l_pmdl.pmdlownid = g_user                        #資料所有者  
   LET l_pmdl.pmdlowndp = g_dept                        #資料所屬部門
   LET l_pmdl.pmdlcrtid = g_user                        #資料建立者  
   LET l_pmdl.pmdlcrtdp = g_dept                        #資料建立部門
   LET l_pmdl.pmdlcrtdt = cl_get_current()              #資料創建日  
   LET l_pmdl.pmdlmodid = ''                            #資料修改者  
   LET l_pmdl.pmdlmoddt = ''                            #最近修改日  
   LET l_pmdl.pmdlcnfid = ''                            #資料確認者  
   LET l_pmdl.pmdlcnfdt = ''                            #資料確認日  
   LET l_pmdl.pmdlpstid = ''                            #資料過帳者  
   LET l_pmdl.pmdlpstdt = ''                            #資料過帳日  
   LET l_pmdl.pmdlstus  = 'N'                           #狀態碼      
   LET l_pmdl.pmdl900   = ''                            #保留欄位str 
   LET l_pmdl.pmdl999   = ''                            #保留欄位end 
   #161124-00048#9 mod-S
#   INSERT INTO pmdl_t VALUES(l_pmdl.*)
   INSERT INTO pmdl_t(pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
                      pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
                      pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
                      pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
                      pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
                      pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
                      pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
                      pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
                      pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
                      pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
                      pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
                      pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
                      pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
                      pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
                      pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208) 
               VALUES(l_pmdl.*)
   #161124-00048#9 mod-E
   IF SQLCA.sqlcode THEN
      RETURN r_success,r_pmdldocno
   END IF

   LET r_success = TRUE
   LET r_pmdldocno = l_pmdl.pmdldocno

   RETURN r_success,r_pmdldocno

END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 产生采购单身pmdn_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_4_ins_pmdn(p_pmdndocno,p_pmdl)
#                       RETURNING r_success
# Input parameter: p_pmdndocno    采购单单号
#                : p_pmdl         采购单头信息
# Return code....: r_success      成功否标识符
# Date & Author..: 2014/04/22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_4_ins_pmdn(p_pmdndocno,p_pmdl)
   DEFINE p_pmdndocno     LIKE pmdn_t.pmdndocno
   DEFINE p_pmdl          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdn          RECORD LIKE pmdn_t.*
   DEFINE l_pmdn RECORD  #採購單身明細檔
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
   DEFINE l_doc_type      LIKE ooba_t.ooba002
   DEFINE l_pmal002       LIKE pmal_t.pmal002   #控制组
   DEFINE l_sfcb          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          sfaa010       LIKE sfaa_t.sfaa010,
                          sfac006       LIKE sfac_t.sfac006,
                          sfcb001       LIKE sfcb_t.sfcb001,
                          sfcb002       LIKE sfcb_t.sfcb002,
                          sfcb003       LIKE sfcb_t.sfcb003,
                          sfcb004       LIKE sfcb_t.sfcb004,
                          sfcb020       LIKE sfcb_t.sfcb020,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          sfcb044       LIKE sfcb_t.sfcb044,
                          sfcb045       LIKE sfcb_t.sfcb045,
                          price         LIKE pmdn_t.pmdn015   
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE l_pmdl          RECORD LIKE pmdl_t.*
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_rate          LIKE inaj_t.inaj014
   DEFINE l_imaf173       LIKE imaf_t.imaf173
   DEFINE l_imaf174       LIKE imaf_t.imaf174
   #161124-00048#9 mod-S
#   DEFINE l_sfaa          RECORD LIKE sfaa_t.*
   DEFINE l_sfaa RECORD  #工單單頭檔
          sfaaent LIKE sfaa_t.sfaaent, #企业编号
          sfaaownid LIKE sfaa_t.sfaaownid, #资料所有者
          sfaaowndp LIKE sfaa_t.sfaaowndp, #资料所有部门
          sfaacrtid LIKE sfaa_t.sfaacrtid, #资料录入者
          sfaacrtdp LIKE sfaa_t.sfaacrtdp, #资料录入部门
          sfaacrtdt LIKE sfaa_t.sfaacrtdt, #资料创建日
          sfaamodid LIKE sfaa_t.sfaamodid, #资料更改者
          sfaamoddt LIKE sfaa_t.sfaamoddt, #最近更改日
          sfaacnfid LIKE sfaa_t.sfaacnfid, #资料审核者
          sfaacnfdt LIKE sfaa_t.sfaacnfdt, #数据审核日
          sfaapstid LIKE sfaa_t.sfaapstid, #资料过账者
          sfaapstdt LIKE sfaa_t.sfaapstdt, #资料过账日
          sfaastus LIKE sfaa_t.sfaastus, #状态码
          sfaasite LIKE sfaa_t.sfaasite, #营运据点
          sfaadocno LIKE sfaa_t.sfaadocno, #单号
          sfaadocdt LIKE sfaa_t.sfaadocdt, #单据日期
          sfaa001 LIKE sfaa_t.sfaa001, #变更版本
          sfaa002 LIKE sfaa_t.sfaa002, #生管人员
          sfaa003 LIKE sfaa_t.sfaa003, #工单类型
          sfaa004 LIKE sfaa_t.sfaa004, #发料制度
          sfaa005 LIKE sfaa_t.sfaa005, #工单来源
          sfaa006 LIKE sfaa_t.sfaa006, #来源单号
          sfaa007 LIKE sfaa_t.sfaa007, #来源项次
          sfaa008 LIKE sfaa_t.sfaa008, #来源项序
          sfaa009 LIKE sfaa_t.sfaa009, #参考客户
          sfaa010 LIKE sfaa_t.sfaa010, #生产料号
          sfaa011 LIKE sfaa_t.sfaa011, #特性
          sfaa012 LIKE sfaa_t.sfaa012, #生产数量
          sfaa013 LIKE sfaa_t.sfaa013, #生产单位
          sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
          sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
          sfaa016 LIKE sfaa_t.sfaa016, #工艺编号
          sfaa017 LIKE sfaa_t.sfaa017, #部门供应商
          sfaa018 LIKE sfaa_t.sfaa018, #协作据点
          sfaa019 LIKE sfaa_t.sfaa019, #预计开工日
          sfaa020 LIKE sfaa_t.sfaa020, #预计完工日
          sfaa021 LIKE sfaa_t.sfaa021, #母工单单号
          sfaa022 LIKE sfaa_t.sfaa022, #参考原始单号
          sfaa023 LIKE sfaa_t.sfaa023, #参考原始项次
          sfaa024 LIKE sfaa_t.sfaa024, #参考原始项序
          sfaa025 LIKE sfaa_t.sfaa025, #前工单单号
          sfaa026 LIKE sfaa_t.sfaa026, #料表批号(PBI)
          sfaa027 LIKE sfaa_t.sfaa027, #No Use
          sfaa028 LIKE sfaa_t.sfaa028, #项目编号
          sfaa029 LIKE sfaa_t.sfaa029, #WBS
          sfaa030 LIKE sfaa_t.sfaa030, #活动
          sfaa031 LIKE sfaa_t.sfaa031, #理由码
          sfaa032 LIKE sfaa_t.sfaa032, #紧急比率
          sfaa033 LIKE sfaa_t.sfaa033, #优先级
          sfaa034 LIKE sfaa_t.sfaa034, #预计入库库位
          sfaa035 LIKE sfaa_t.sfaa035, #预计入库储位
          sfaa036 LIKE sfaa_t.sfaa036, #手册编号
          sfaa037 LIKE sfaa_t.sfaa037, #保税核准文号
          sfaa038 LIKE sfaa_t.sfaa038, #保税核销
          sfaa039 LIKE sfaa_t.sfaa039, #备料已生成
          sfaa040 LIKE sfaa_t.sfaa040, #生产工艺路线已审核
          sfaa041 LIKE sfaa_t.sfaa041, #冻结
          sfaa042 LIKE sfaa_t.sfaa042, #返工
          sfaa043 LIKE sfaa_t.sfaa043, #备置
          sfaa044 LIKE sfaa_t.sfaa044, #FQC
          sfaa045 LIKE sfaa_t.sfaa045, #实际开始发料日
          sfaa046 LIKE sfaa_t.sfaa046, #最后入库日
          sfaa047 LIKE sfaa_t.sfaa047, #生管结案日
          sfaa048 LIKE sfaa_t.sfaa048, #成本结案日
          sfaa049 LIKE sfaa_t.sfaa049, #已发料套数
          sfaa050 LIKE sfaa_t.sfaa050, #已入库合格量
          sfaa051 LIKE sfaa_t.sfaa051, #已入库不合格量
          sfaa052 LIKE sfaa_t.sfaa052, #Bouns
          sfaa053 LIKE sfaa_t.sfaa053, #工单转入数量
          sfaa054 LIKE sfaa_t.sfaa054, #工单转出数量
          sfaa055 LIKE sfaa_t.sfaa055, #下线数量
          sfaa056 LIKE sfaa_t.sfaa056, #报废数量
          sfaa057 LIKE sfaa_t.sfaa057, #委外类型
          sfaa058 LIKE sfaa_t.sfaa058, #参考数量
          sfaa059 LIKE sfaa_t.sfaa059, #预计入库批号
          sfaa060 LIKE sfaa_t.sfaa060, #参考单位
          sfaa061 LIKE sfaa_t.sfaa061, #工艺
          sfaa062 LIKE sfaa_t.sfaa062, #纳入APS计算
          sfaa063 LIKE sfaa_t.sfaa063, #来源分批序
          sfaa064 LIKE sfaa_t.sfaa064, #参考原始分批序
          sfaa065 LIKE sfaa_t.sfaa065, #生管结案状态
          sfaa066 LIKE sfaa_t.sfaa066, #多角流程编号
          sfaa067 LIKE sfaa_t.sfaa067, #多角流进程号
          sfaa068 LIKE sfaa_t.sfaa068, #成本中心
          sfaa069 LIKE sfaa_t.sfaa069, #可供给量
          sfaa070 LIKE sfaa_t.sfaa070, #原始预计完工日期
          sfaa071 LIKE sfaa_t.sfaa071, #齐料套数
          sfaa072 LIKE sfaa_t.sfaa072  #保税否
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_pmdl040       LIKE pmdl_t.pmdl040
   DEFINE l_pmdl041       LIKE pmdl_t.pmdl041
   DEFINE l_pmdl042       LIKE pmdl_t.pmdl042
   DEFINE l_sql           STRING
   DEFINE l_ooef008       LIKE ooef_t.ooef008
   DEFINE l_ooef009       LIKE ooef_t.ooef009
   DEFINE l_oodbl004      LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005       LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006       LIKE oodb_t.oodb006    #稅率 
   DEFINE l_oodb011       LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定
   DEFINE l_ooba002       LIKE ooba_t.ooba002    #150820#150819-00010 by whitney add
   #160606-00013 by whitney add start
   DEFINE l_sfaadocno_o   LIKE sfaa_t.sfaadocno
   DEFINE l_sfac          RECORD
                          sfac001       LIKE sfac_t.sfac001,
                          sfac003       LIKE sfac_t.sfac003,
                          sfac004       LIKE sfac_t.sfac004,
                          sfac006       LIKE sfac_t.sfac006
                          END RECORD
   #160606-00013 by whitney add end

   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF
   
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmdl.* 
   SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
          pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
          pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
          pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
          pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
          pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
          pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
          pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
          pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
          pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
          pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
          pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208
     INTO l_pmdl.* 
   #161124-00048#9 mod-E
     FROM pmdl_t
    WHERE pmdlent   = g_enterprise
      AND pmdldocno = p_pmdndocno

   #160606-00013 by whitney add start
   LET l_sfaadocno_o = ''
   LET g_sql = " SELECT sfac001,sfac003,sfac004,sfac006 ",
               "   FROM sfac_t ",
               " WHERE sfacent = ",g_enterprise,
               "   AND sfacdocno = ? ",
               "   AND sfac002 = '5' ",  #副产品/回收料
               " ORDER BY sfacseq "
   PREPARE s_apmt500_gen_4_ins_pmdn_p2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "prepare s_apmt500_gen_4_ins_pmdn_p2" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF      
   DECLARE s_apmt500_gen_4_ins_pmdn_cs2 CURSOR FOR s_apmt500_gen_4_ins_pmdn_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "declare s_apmt500_gen_4_ins_pmdn_cs2" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   #160606-00013 by whitney add end

   LET g_sql = " SELECT sfcbdocno, sfaa010, sfac006,   sfcb001, sfcb002, sfcb003,",
               "        sfcb004,   sfcb020, SUM(carry_qty), sfcb044, sfcb045, price ",
               "   FROM asfp400_tmp_t ",
               "  WHERE sfcb013 = '",p_pmdl.pmdl004,"'",        #供应商
               "    AND pmdl017 = '",p_pmdl.pmdl017,"'",        #取价方式
               "    AND pmdl015 = '",p_pmdl.pmdl015,"'",        #币种
               "    AND pmdl011 = '",p_pmdl.pmdl011,"'"         #税种
   IF NOT cl_null(p_pmdl.sfcbdocno) THEN
      LET g_sql = g_sql CLIPPED,"  AND sfcbdocno = '",p_pmdl.sfcbdocno,"'"
   END IF
   LET g_sql = g_sql CLIPPED," GROUP BY sfcbdocno,sfaa010,sfac006,sfcb001,sfcb002,sfcb003,",
                             "          sfcb004,sfcb020,sfcb044,sfcb045,price "
   #170214-00015#4 add str---
   #若與MES整合且為委外採購，則排序則須依接收XML的順序(順序值放在sfcb004)
   IF cl_get_para(g_enterprise,g_site,'S-SYS-0003') = 'Y' AND g_prog = 'wssp312' THEN
      LET g_sql = g_sql CLIPPED," ORDER BY sfcb004,sfcb001,sfcb002"
   ELSE
      LET g_sql = g_sql CLIPPED," ORDER BY sfcbdocno,sfcb001,sfcb002"
   END IF
   #170214-00015#4 add end--- 
   
   PREPARE s_apmt500_gen_4_ins_pmdn_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "prepare s_apmt500_gen_4_ins_pmdn_p1" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN r_success
   END IF      
   
   DECLARE s_apmt500_gen_4_ins_pmdn_cs1 CURSOR FOR s_apmt500_gen_4_ins_pmdn_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "declare s_apmt500_gen_4_ins_pmdn_cs1" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   FOREACH s_apmt500_gen_4_ins_pmdn_cs1 INTO l_sfcb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach s_apmt500_gen_4_ins_pmdn_cs1" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()        
         RETURN r_success
      END IF
      
      #取工单资料
      #161124-00048#9 mod-S
#      SELECT * INTO l_sfaa.* FROM sfaa_t
      SELECT sfaaent,sfaaownid,sfaaowndp,sfaacrtid,sfaacrtdp,
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
             sfaa070,sfaa071,sfaa072
        INTO l_sfaa.* 
        FROM sfaa_t
      #161124-00048#9 mod-E
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = l_sfcb.sfcbdocno
         
      INITIALIZE l_pmdn.* TO NULL   
      
      LET l_pmdn.pmdnent   = g_enterprise      #企業編號
      #LET l_pmdn.pmdnsite  = g_site            #營運據點
      LET l_pmdn.pmdnsite  = l_pmdl.pmdlsite
      LET l_pmdn.pmdndocno = p_pmdndocno       #採購單號
      #項次
      SELECT MAX(pmdnseq) + 1 INTO l_pmdn.pmdnseq
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdndocno = l_pmdn.pmdndocno
      IF cl_null(l_pmdn.pmdnseq) THEN
         LET l_pmdn.pmdnseq = 1
      END IF
      LET l_pmdn.pmdn001   = l_sfcb.sfaa010    #料件編號
      LET l_pmdn.pmdn002   = l_sfcb.sfac006    #產品特徵
      LET l_pmdn.pmdn003   = ''                #包裝容器
      LET l_pmdn.pmdn004   = l_sfcb.sfcb003    #作業編號
      LET l_pmdn.pmdn005   = l_sfcb.sfcb004    #製程序  
      LET l_pmdn.pmdn006   = l_sfcb.sfcb020    #採購單位
      LET l_pmdn.pmdn007   = l_sfcb.carry_qty  #採購數量
      #參考單位
      SELECT imaf015 INTO l_pmdn.pmdn008 FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = l_pmdn.pmdnsite
         AND imaf001  = l_pmdn.pmdn001
         
      #參考數量 
      #若没有参考单位时,参考数量DEFAULT NULL
      IF cl_null(l_pmdn.pmdn008) THEN
         LET l_pmdn.pmdn009 = NULL
      ELSE
         #CALL s_aimi190_get_convert(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008)
         #     RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_pmdn.pmdn009 = l_pmdn.pmdn007 * l_rate
         CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008,l_pmdn.pmdn007)
              RETURNING l_success,l_pmdn.pmdn009
      END IF
         
#      LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位    #161229-00014#1-----dujuan----mark
#      LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量    #161229-00014#1-----dujuan----mark
      LET l_pmdn.pmdn014   = l_sfcb.sfcb045    #到庫日期
      
      #161229-00014#1-----dujuan-----str 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         SELECT imaf144 INTO l_pmdn.pmdn010
         FROM imaf_t
         WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_pmdn.pmdn001
            
         IF cl_null(l_pmdn.pmdn010) THEN
         LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位   
         END IF
            
         CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn007)
         RETURNING l_success,l_pmdn.pmdn011
         IF NOT cl_null(l_pmdn.pmdn011) THEN
         CALL s_apmt500_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011) 
         RETURNING l_pmdn.pmdn011 
         END IF
      ELSE
         LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位
         LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量         
      END IF
      #161229-00014#1-----dujuan----end
      
      #推算"到厂日期"及"出貨日期"
      LET l_imaf173 = 0
      LET l_imaf174 = 0
      SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
        FROM imaf_t
       WHERE imafent = g_enterprise AND imafsite = l_pmdn.pmdnsite AND imaf001 = l_pmdn.pmdn001
      LET l_imaf173 = l_imaf173 * -1
      LET l_imaf174 = l_imaf174 * -1
      
      #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
      SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=l_pmdn.pmdnsite
           
      #以下倒推,由到库日期往前推算到厂日期,再由到厂日期推算交货日期
      #1.到廠日期 = 到库日期 - [T:料件據點進銷存檔].[C:到庫前置時間]
      IF NOT cl_null(l_imaf174) AND l_imaf174 <> 0 THEN
         CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn014,0,l_imaf174) RETURNING l_pmdn.pmdn013
      ELSE
         LET l_pmdn.pmdn013 = l_pmdn.pmdn014
      END IF
      #2.出貨日期= 到厂日期 - [T:料件據點進銷存檔].[C:到廠前置時間]                              
      IF NOT cl_null(l_imaf173) AND l_imaf173 <> 0 THEN
         CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn013,0,l_imaf173) RETURNING l_pmdn.pmdn012
      ELSE
         LET l_pmdn.pmdn012 = l_pmdn.pmdn013
      END IF

      LET l_pmdn.pmdn015   = l_sfcb.price      #單價 
      #若单价为零时,重新取单价
      IF l_pmdn.pmdn015 = 0 OR cl_null(l_pmdn.pmdn015) THEN
         #等取单价的应用元件
         #carrier fill when price function ready
         #LET l_pmdn.pmdn015 = 1
      END IF
      LET l_pmdn.pmdn016   = p_pmdl.pmdl011    #稅別 
      LET l_pmdn.pmdn017   = l_pmdl.pmdl012    #稅率 
      
      #取得稅別類型
      CALL s_tax_chk(l_pmdn.pmdnsite,l_pmdl.pmdl011)
        RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
      IF l_oodb011 = '2' AND NOT cl_null(l_pmdn.pmdn001) AND NOT cl_null(l_pmdl.pmdl024) THEN
         #依料件設定
         CALL s_tax_chktype(l_pmdn.pmdnsite,l_pmdl.pmdl004,l_pmdn.pmdn001,'2',l_pmdl.pmdl024)
              RETURNING l_success,l_pmdn.pmdn016,l_pmdn.pmdn017
         IF NOT l_success THEN
            #稅別檢查失敗，將稅別、稅率清空
            LET l_pmdn.pmdn016 = ''
            LET l_pmdn.pmdn017 = ''
         END IF                   
      END IF
      IF cl_null(l_pmdn.pmdn016) OR cl_null(l_pmdn.pmdn017) THEN
         #依正常稅率
         LET l_pmdn.pmdn016 = l_pmdl.pmdl011
         LET l_pmdn.pmdn017 = l_pmdl.pmdl012
      END IF 
      
      #子件特性
      #若拆件式工单时,为'10',否则为'1'
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM sfba_t
       WHERE sfbaent   = g_enterprise
         AND sfbadocno = l_sfcb.sfcbdocno
         AND sfba006   = l_pmdn.pmdn001
         AND sfba015   > 0
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN
         LET l_pmdn.pmdn019 = '8'    #代买料
      ELSE
         IF l_sfaa.sfaa003 = '3' THEN      
            LET l_pmdn.pmdn019= '10'  #拆件主件
         ELSE
            LET l_pmdn.pmdn019= '1'  #一般
         END IF
      END IF
      
      LET l_pmdn.pmdn020   = '1'               #緊急度                       
      LET l_pmdn.pmdn021   = 'N'               #保稅                    
      LET l_pmdn.pmdn022   = 'Y'               #部分交貨                
      LET l_pmdn.pmdnunit  = g_site            #收貨據點                 
      LET l_pmdn.pmdnorga  = g_site            #付款據點                 
      LET l_pmdn.pmdn023   = p_pmdl.pmdl004    #送貨供應商              
      LET l_pmdn.pmdn024   = 'N'               #多交期                  
      LET l_pmdn.pmdn025   = l_pmdl.pmdl025    #收貨地址代碼            
      LET l_pmdn.pmdn026   = l_pmdl.pmdl026    #帳款地址代碼    
      #供應商料號
      DECLARE s_apmt500_gen_4_ins_pmdn_sel_cs1 SCROLL CURSOR FOR
       SELECT pmao004 FROM pmao_t
        WHERE pmaoent = g_enterprise 
          AND pmao001 = p_pmdl.pmdl004
          AND pmao002 = l_pmdn.pmdn001
          AND pmao003 = l_pmdn.pmdn002
          AND pmao000 = '1'      #161221-00064#5 add
        ORDER BY pmao007 DESC
        
      OPEN s_apmt500_gen_4_ins_pmdn_sel_cs1 
      FETCH FIRST s_apmt500_gen_4_ins_pmdn_sel_cs1 INTO l_pmdn.pmdn027
           
      LET l_pmdn.pmdn028   = l_sfaa.sfaa034    #收貨庫位
      #150820#150819-00010 by whitney add start
      IF cl_null(l_pmdn.pmdn028) THEN
         CALL s_aooi200_get_slip(p_pmdndocno) RETURNING l_success,l_ooba002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076') RETURNING l_pmdn.pmdn028
      END IF
      #150820#150819-00010 by whitney add end
      LET l_pmdn.pmdn029   = l_sfaa.sfaa035    #收貨儲位                
      LET l_pmdn.pmdn030   = l_sfaa.sfaa059    #收貨批號                
      LET l_pmdn.pmdn031   = l_pmdl.pmdl020    #運輸方式                
      LET l_pmdn.pmdn032   = '1'               #取貨模式                
      LET l_pmdn.pmdn033   = 0                 #備品率                  
      LET l_pmdn.pmdn035   = '1'               #價格核決                
      LET l_pmdn.pmdn036   = l_sfaa.sfaa028    #專案編號                
      LET l_pmdn.pmdn037   = l_sfaa.sfaa029    #WBS編號                 
      LET l_pmdn.pmdn038   = l_sfaa.sfaa030    #活動編號                
      LET l_pmdn.pmdn039   = ''                #費用原因
      #carrier 以下5个字段等价格应用元件      
      LET l_pmdn.pmdn040   = '1'               #取價來源    
      LET l_pmdn.pmdn041   = ''                #價格參考單號
      LET l_pmdn.pmdn042   = ''                #價格參考項次
      LET l_pmdn.pmdn043   = 0                 #取出價格    
      LET l_pmdn.pmdn044   = 0                 #價差比      
      LET l_pmdn.pmdn045   ='1'                #行狀態   

      CALL s_apmt500_get_price(l_pmdl.pmdl017,l_pmdl.pmdl004,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdl.pmdl015,
          l_pmdn.pmdn016,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl023,l_pmdn.pmdndocno,
          l_pmdl.pmdldocdt,l_pmdn.pmdn010,l_pmdn.pmdn011,l_pmdn.pmdnsite,l_pmdl.pmdl054,'2',l_pmdn.pmdn004,l_pmdn.pmdn005)
        RETURNING l_pmdn.pmdn040,l_pmdn.pmdn043,l_pmdn.pmdn041,l_pmdn.pmdn042
      
      LET l_pmdn.pmdn015 = l_pmdn.pmdn043
      
      #未稅金額/#含稅金額/#稅額
      CALL s_apmt500_get_amount(l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,
                                l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)     #161229-00014#1-----dujuan----l_pmdn.pmdn007 改 l_pmdn.pmdn011
           RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047

      LET l_pmdn.pmdn049   = ''                #理由碼      
      LET l_pmdn.pmdn050   = ''                #備註        
      LET l_pmdn.pmdn051   = ''                #結案理由碼  
      LET l_pmdn.pmdn900   = ''                #保留欄位str 
      LET l_pmdn.pmdn999   = ''                #保留欄位end 
      
      LET l_pmdn.pmdn052 = ''
      LET l_sql = " SELECT qcap006 FROM qcap_t ",
                 " WHERE qcapent = '",g_enterprise,"' ",
                 "  AND qcapsite = '",l_pmdn.pmdnsite,"' ",
                 "  AND qcap001 = '",l_pmdn.pmdn001,"' ",
                 "  AND qcap002 = '",l_pmdl.pmdl004,"' "
                 
      IF l_pmdn.pmdn002 IS NOT NULL THEN
         LET l_sql = l_sql ," AND qcap005 = '",l_pmdn.pmdn002,"' "
      END IF
      IF (NOT cl_null(l_pmdn.pmdn004)) AND (NOT cl_null(l_pmdn.pmdn005)) THEN
         LET l_sql = l_sql ," AND qcap003 = '",l_pmdn.pmdn004,"' AND qcap004 = '",l_pmdn.pmdn005,"' "
      END IF
      
      PREPARE get_qcap1 FROM l_sql
      EXECUTE get_qcap1 INTO l_pmdn.pmdn052  
      FREE get_qcap1
      
      IF cl_null(l_pmdn.pmdn052) THEN
         #若沒有維護aqci050,再從aqci040中帶值
         SELECT imae114 INTO l_pmdn.pmdn052 FROM imae_t 
             WHERE imaeent = g_enterprise AND imaesite = l_pmdn.pmdnsite AND imae001 = l_pmdn.pmdn001
             
      END IF
           
      IF cl_null(l_pmdn.pmdn052) THEN
         LET l_pmdn.pmdn052 = 'N'
      END IF
         
      LET l_pmdn.pmdn054   = 0
      LET l_pmdn.pmdn055   = 0
      LET l_pmdn.pmdn056   = 0
      LET l_pmdn.pmdn057   = 0
      #161124-00048#9 mod-S
#      INSERT INTO pmdn_t VALUES(l_pmdn.*)
      INSERT INTO pmdn_t(pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
                         pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
                         pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
                         pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
                         pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
                         pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
                         pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
                         pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
                         pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
                         pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                         pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                         pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
                         pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
                         pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
                         pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
                         pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
                         pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
                         pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
                         pmdn226,pmdn227,pmdn058,pmdn228)
                  VALUES(l_pmdn.*)
      #161124-00048#9 mod-E
      IF SQLCA.sqlcode THEN
         RETURN r_success
      END IF

      CALL s_apmt500_gen_pmdq(l_pmdn.pmdndocno,l_pmdn.pmdnseq) RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF  
      
      #插入"pmdo_t:採購交期明細檔"
      CALL s_apmt500_gen_4_ins_pmdo(l_sfcb.*,l_pmdn.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF           
      #插入"pmdp_t:採購關聯單據明細檔"
      CALL s_apmt500_gen_4_ins_pmdp(l_sfcb.*,l_pmdn.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF     

      #更新工单sfcb041 委外数量
      #代买料不影响可委外数量
      IF l_pmdn.pmdn019 <> '8' THEN
         #160316-00006#1---add---begin---
         IF cl_null(l_sfcb.sfcb003) THEN
            LET l_sfcb.sfcb003 = ' '
         END IF
         IF cl_null(l_sfcb.sfcb004) THEN
            LET l_sfcb.sfcb004 = ' '
         END IF
         #160316-00006#1---add---end---
            
         UPDATE sfcb_t SET sfcb041 = sfcb041 + l_sfcb.carry_qty
          WHERE sfcbent   = g_enterprise
            AND sfcbdocno = l_sfcb.sfcbdocno
            AND sfcb001   = l_sfcb.sfcb001
            AND sfcb002   = l_sfcb.sfcb002
            #160316-00006#1---add---begin---
            AND (CASE WHEN sfcb003 IS NULL THEN ' ' ELSE sfcb003 END) = l_sfcb.sfcb003
            AND (CASE WHEN sfcb004 IS NULL THEN ' ' ELSE sfcb004 END) = l_sfcb.sfcb004
            #160316-00006#1---add---end---
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'update sfcb041'
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF

      #160606-00013 by whitney add start
      IF l_sfcb.sfcbdocno <> l_sfaadocno_o OR l_sfaadocno_o IS NULL THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM sfac_t
          WHERE sfacent = g_enterprise
            AND sfacdocno = l_sfcb.sfcbdocno
            AND sfac002 = '5'  #副产品/回收料
         IF l_cnt > 0 THEN
            INITIALIZE l_sfac.* TO NULL
            FOREACH s_apmt500_gen_4_ins_pmdn_cs2 USING l_sfcb.sfcbdocno
               INTO l_sfac.sfac001,l_sfac.sfac003,l_sfac.sfac004,l_sfac.sfac006
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "foreach s_apmt500_gen_4_ins_pmdn_cs2" 
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()        
                  RETURN r_success
               END IF
               #項次
               SELECT MAX(pmdnseq) + 1 INTO l_pmdn.pmdnseq
                 FROM pmdn_t
                WHERE pmdnent   = g_enterprise
                  AND pmdndocno = l_pmdn.pmdndocno
               IF cl_null(l_pmdn.pmdnseq) THEN
                  LET l_pmdn.pmdnseq = 1
               END IF
               LET l_pmdn.pmdn001   = l_sfac.sfac001    #料件編號
               LET l_pmdn.pmdn002   = l_sfac.sfac006    #產品特徵
               LET l_pmdn.pmdn006   = l_sfac.sfac004    #採購單位
               LET l_pmdn.pmdn007   = l_sfac.sfac003    #採購數量
               #參考單位
               SELECT imaf015 INTO l_pmdn.pmdn008 FROM imaf_t
                WHERE imafent  = g_enterprise
                  AND imafsite = l_pmdn.pmdnsite
                  AND imaf001  = l_pmdn.pmdn001
               #參考數量 
               #若没有参考单位时,参考数量DEFAULT NULL
               IF cl_null(l_pmdn.pmdn008) THEN
                  LET l_pmdn.pmdn009 = NULL
               ELSE
                  CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008,l_pmdn.pmdn007)
                       RETURNING l_success,l_pmdn.pmdn009
               END IF
#               LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位  #161229-00014#1-----dujuan-----mark
#               LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量  #161229-00014#1-----dujuan-----mark
               
               #161229-00014#1-----dujuan-----str 
               IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
                  SELECT imaf144 INTO l_pmdn.pmdn010
                  FROM imaf_t
                  WHERE imafent  = g_enterprise
                  AND imafsite = g_site
                  AND imaf001  = l_pmdn.pmdn001
                     
                  IF cl_null(l_pmdn.pmdn010) THEN
                  LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位   
                  END IF
                     
                  CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn007)
                  RETURNING l_success,l_pmdn.pmdn011
                  IF NOT cl_null(l_pmdn.pmdn011) THEN
                  CALL s_apmt500_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011) 
                  RETURNING l_pmdn.pmdn011 
                  END IF
               ELSE
                  LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位
                  LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量         
               END IF
               #161229-00014#1-----dujuan----end
                        
               #推算"到厂日期"及"出貨日期"
               LET l_imaf173 = 0
               LET l_imaf174 = 0
               SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
                 FROM imaf_t
                WHERE imafent = g_enterprise AND imafsite = l_pmdn.pmdnsite AND imaf001 = l_pmdn.pmdn001
               LET l_imaf173 = l_imaf173 * -1
               LET l_imaf174 = l_imaf174 * -1
               #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
               SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=l_pmdn.pmdnsite
               #以下倒推,由到库日期往前推算到厂日期,再由到厂日期推算交货日期
               #1.到廠日期 = 到库日期 - [T:料件據點進銷存檔].[C:到庫前置時間]
               IF NOT cl_null(l_imaf174) AND l_imaf174 <> 0 THEN
                  CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn014,0,l_imaf174) RETURNING l_pmdn.pmdn013
               ELSE
                  LET l_pmdn.pmdn013 = l_pmdn.pmdn014
               END IF
               #2.出貨日期= 到厂日期 - [T:料件據點進銷存檔].[C:到廠前置時間]                              
               IF NOT cl_null(l_imaf173) AND l_imaf173 <> 0 THEN
                  CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn013,0,l_imaf173) RETURNING l_pmdn.pmdn012
               ELSE
                  LET l_pmdn.pmdn012 = l_pmdn.pmdn013
               END IF
               #取得稅別類型
               CALL s_tax_chk(l_pmdn.pmdnsite,l_pmdl.pmdl011)
                 RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
               IF l_oodb011 = '2' AND NOT cl_null(l_pmdn.pmdn001) AND NOT cl_null(l_pmdl.pmdl024) THEN
                  #依料件設定
                  CALL s_tax_chktype(l_pmdn.pmdnsite,l_pmdl.pmdl004,l_pmdn.pmdn001,'2',l_pmdl.pmdl024)
                       RETURNING l_success,l_pmdn.pmdn016,l_pmdn.pmdn017
                  IF NOT l_success THEN
                     #稅別檢查失敗，將稅別、稅率清空
                     LET l_pmdn.pmdn016 = ''
                     LET l_pmdn.pmdn017 = ''
                  END IF                   
               END IF
               IF cl_null(l_pmdn.pmdn016) OR cl_null(l_pmdn.pmdn017) THEN
                  #依正常稅率
                  LET l_pmdn.pmdn016 = l_pmdl.pmdl011
                  LET l_pmdn.pmdn017 = l_pmdl.pmdl012
               END IF
               LET l_pmdn.pmdn019 = '13'  #子件特性
               #供應商料號
               DECLARE s_apmt500_gen_4_ins_pmdn_sel_cs2 SCROLL CURSOR FOR
                SELECT pmao004 FROM pmao_t
                 WHERE pmaoent = g_enterprise 
                   AND pmao001 = p_pmdl.pmdl004
                   AND pmao002 = l_pmdn.pmdn001
                   AND pmao003 = l_pmdn.pmdn002
                   AND pmao000 = '1'      #161221-00064#5 add
                 ORDER BY pmao007 DESC
               OPEN s_apmt500_gen_4_ins_pmdn_sel_cs2
               FETCH FIRST s_apmt500_gen_4_ins_pmdn_sel_cs2 INTO l_pmdn.pmdn027
               LET l_pmdn.pmdn040 = ''
               LET l_pmdn.pmdn041 = ''
               LET l_pmdn.pmdn042 = ''
               LET l_pmdn.pmdn043 = ''
               LET l_pmdn.pmdn015 = 0
               LET l_pmdn.pmdn046 = 0
               LET l_pmdn.pmdn047 = 0
               LET l_pmdn.pmdn048 = 0
               LET l_pmdn.pmdn052 = ''
               LET l_sql = " SELECT qcap006 FROM qcap_t ",
                          " WHERE qcapent = '",g_enterprise,"' ",
                          "  AND qcapsite = '",l_pmdn.pmdnsite,"' ",
                          "  AND qcap001 = '",l_pmdn.pmdn001,"' ",
                          "  AND qcap002 = '",l_pmdl.pmdl004,"' "
               IF l_pmdn.pmdn002 IS NOT NULL THEN
                  LET l_sql = l_sql ," AND qcap005 = '",l_pmdn.pmdn002,"' "
               END IF
               IF (NOT cl_null(l_pmdn.pmdn004)) AND (NOT cl_null(l_pmdn.pmdn005)) THEN
                  LET l_sql = l_sql ," AND qcap003 = '",l_pmdn.pmdn004,"' AND qcap004 = '",l_pmdn.pmdn005,"' "
               END IF
               PREPARE get_qcap3 FROM l_sql
               EXECUTE get_qcap3 INTO l_pmdn.pmdn052  
               FREE get_qcap3
               IF cl_null(l_pmdn.pmdn052) THEN
                  #若沒有維護aqci050,再從aqci040中帶值
                  SELECT imae114 INTO l_pmdn.pmdn052 FROM imae_t 
                      WHERE imaeent = g_enterprise AND imaesite = l_pmdn.pmdnsite AND imae001 = l_pmdn.pmdn001
               END IF
               IF cl_null(l_pmdn.pmdn052) THEN
                  LET l_pmdn.pmdn052 = 'N'
               END IF
               #161124-00048#9 mod-S
#               INSERT INTO pmdn_t VALUES(l_pmdn.*)
               INSERT INTO pmdn_t(pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
                                  pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
                                  pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
                                  pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
                                  pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
                                  pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
                                  pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
                                  pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
                                  pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
                                  pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                                  pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                                  pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
                                  pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
                                  pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
                                  pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
                                  pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
                                  pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
                                  pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
                                  pmdn226,pmdn227,pmdn058,pmdn228)
                           VALUES(l_pmdn.*)
               #161124-00048#9 mod-E
               IF SQLCA.sqlcode THEN
                  RETURN r_success
               END IF
               CALL s_apmt500_gen_pmdq(l_pmdn.pmdndocno,l_pmdn.pmdnseq) RETURNING l_success
               IF NOT l_success THEN
                  RETURN r_success
               END IF
               #插入"pmdo_t:採購交期明細檔"
               CALL s_apmt500_gen_4_ins_pmdo(l_sfcb.*,l_pmdn.*)
                    RETURNING l_success
               IF NOT l_success THEN
                  RETURN r_success
               END IF
               #插入"pmdp_t:採購關聯單據明細檔"
               CALL s_apmt500_gen_4_ins_pmdp(l_sfcb.*,l_pmdn.*)
                    RETURNING l_success
               IF NOT l_success THEN
                  RETURN r_success
               END IF
            END FOREACH
         END IF
         LET l_sfaadocno_o = l_sfcb.sfcbdocno
      END IF
      #160606-00013 by whitney add end

   END FOREACH
   
   #未税/含税/税额
   SELECT SUM(pmdn046),SUM(pmdn047),SUM(pmdn048) INTO l_pmdl040,l_pmdl041,l_pmdl042
     FROM pmdn_t
    WHERE pmdnent   = g_enterprise
      AND pmdndocno = p_pmdndocno
   IF cl_null(l_pmdl040) THEN LET l_pmdl040 = 0 END IF
   IF cl_null(l_pmdl041) THEN LET l_pmdl041 = 0 END IF
   IF cl_null(l_pmdl042) THEN LET l_pmdl042 = 0 END IF
   UPDATE pmdl_t SET pmdl040 = l_pmdl040, pmdl041 = l_pmdl041, pmdl042 = l_pmdl042
    WHERE pmdlent   = g_enterprise
      AND pmdldocno = p_pmdndocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'update pmdl_t SUM'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 产生采购交期明细单身pmdo_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_4_ins_pmdo(p_sfcb,p_pmdn)
#                       RETURNING r_success
# Input parameter: p_sfcb         工单制程信息
#                : p_pmdn         采购明细单身资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014/04/23 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_4_ins_pmdo(p_sfcb,p_pmdn)
   DEFINE p_sfcb          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          sfaa010       LIKE sfaa_t.sfaa010,
                          sfac006       LIKE sfac_t.sfac006,
                          sfcb001       LIKE sfcb_t.sfcb001,
                          sfcb002       LIKE sfcb_t.sfcb002,
                          sfcb003       LIKE sfcb_t.sfcb003,
                          sfcb004       LIKE sfcb_t.sfcb004,
                          sfcb020       LIKE sfcb_t.sfcb020,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          sfcb044       LIKE sfcb_t.sfcb044,
                          sfcb045       LIKE sfcb_t.sfcb045,
                          price         LIKE pmdn_t.pmdn015
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE p_pmdn          RECORD LIKE pmdn_t.*
   DEFINE p_pmdn RECORD  #採購單身明細檔
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdo          RECORD LIKE pmdo_t.*
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企业编号
          pmdosite LIKE pmdo_t.pmdosite, #营运据点
          pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
          pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件编号
          pmdo002 LIKE pmdo_t.pmdo002, #产品特征
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #采购单位
          pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
          pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
          pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期类型
          pmdo010 LIKE pmdo_t.pmdo010, #收货时段
          pmdo011 LIKE pmdo_t.pmdo011, #出货日期
          pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
          pmdo013 LIKE pmdo_t.pmdo013, #到库日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
          pmdo015 LIKE pmdo_t.pmdo015, #已收货量
          pmdo016 LIKE pmdo_t.pmdo016, #验退量
          pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
          pmdo019 LIKE pmdo_t.pmdo019, #已入库量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
          pmdo021 LIKE pmdo_t.pmdo021, #交货状态
          pmdo022 LIKE pmdo_t.pmdo022, #参考价格
          pmdo023 LIKE pmdo_t.pmdo023, #税种
          pmdo024 LIKE pmdo_t.pmdo024, #税率
          pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
          pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
          pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
          pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
          pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
          pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
          pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
          pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
          pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
          pmdo034 LIKE pmdo_t.pmdo034, #分批税额
          pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
          pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
          pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
          pmdo038 LIKE pmdo_t.pmdo038, #初始项序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #仓退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
          pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
          pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
          pmdo041 LIKE pmdo_t.pmdo041, #还料数量
          pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
          pmdo043 LIKE pmdo_t.pmdo043, #还价数量
          pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_arr           DYNAMIC ARRAY OF RECORD
                          item    LIKE sfac_t.sfac001,
                          qty     LIKE pmdo_t.pmdo005,
                          unit    LIKE sfac_t.sfac004,
                          rate    LIKE pmdo_t.pmdo005,    #sfac003 / SUM(sfac003)
                          QPA     LIKE pmdo_t.pmdo005,    #sfac003 / sfaa012
                          pmdo003 LIKE pmdo_t.pmdo003,    #特性
                          pmdo005 LIKE pmdo_t.pmdo005,
                          pmdo007 LIKE pmdo_t.pmdo007,
                          pmdo008 LIKE pmdo_t.pmdo008,
                          pmdo022 LIKE pmdo_t.pmdo022,
                          pmdo032 LIKE pmdo_t.pmdo032,
                          pmdo033 LIKE pmdo_t.pmdo033,
                          pmdo034 LIKE pmdo_t.pmdo034
                          END RECORD
   DEFINE l_tot_pmdo007   LIKE pmdo_t.pmdo007
   DEFINE l_tot_pmdo032   LIKE pmdo_t.pmdo032
   DEFINE l_tot_pmdo033   LIKE pmdo_t.pmdo033
   DEFINE l_tot_pmdo034   LIKE pmdo_t.pmdo034
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_sfaa061       LIKE sfaa_t.sfaa061
   DEFINE l_sfaa012       LIKE sfaa_t.sfaa012
   DEFINE l_j             LIKE type_t.num10
   DEFINE l_sum_sfac003   LIKE sfac_t.sfac003
   DEFINE l_oodb005       LIKE oodb_t.oodb005
   DEFINE l_max_sum       LIKE pmdo_t.pmdo033
   DEFINE l_rate          LIKE inaj_t.inaj014
   DEFINE l_type          LIKE type_t.chr1
   DEFINE l_sfaa003       LIKE sfaa_t.sfaa003

   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF

   #说明:采购明细交期档对"多产出主件"时会有特别处理
   #     若当下工单是一般工单,且多产出主件时,一笔"采购单身资料"pmdn_t会对应多笔pmdo_t"采购交期明细档"
   #     pmdo_t中的(1)pmdo001"料件"记录多产出主件的料件号 (2)pmdo004"采购单位"记录多产出主件的生产单位
   #               (3)pmdo005"采购数量"=pmdn007 * "多产出主件对生产料号的QPA"
   #               (4)多笔多产出主件的pmdo007"折合主件数量"= pmdn007(主件的采购数量)
   #               (5)pmdo008"QPA"=多产出主件对生产料号的QPA(SA决定)
   #               (6)pmdo032"分批未税金额"=pmdn046(生产主件的未税金额)*多产出主件的占比数
   #               (7)pmdo033/pmdo034类似
   #               (8)pmdo022(单价),用pmdo032(未税金额)或是pmdo33(含税金额)/pmdo005

   #具体例子如下:
   # |----------------------------------------------------------------------------------------------------------------
   # |              | 料件编号     |预计产出量    |与生产料件的QPA (A)       | 生产总数 (B)   | 占比% (C)                 |
   # |              |             |             |= sfac003 / sfaa012      | =SUM(sfac003) | =sfac003 / SUM(sfac003)   |
   # |--------------|-------------|-------------|-------------------------|---------------|---------------------------|
   # |工单生产料件   | A           |100          |                         | 1000          |                           |
   # |--------------|-------------|-------------|-------------------------|---------------|---------------------------|
   # |多产出主件     | A1          |100          | 1                       |               | 0.1                       |
   # |--------------|-------------|-------------|-------------------------|---------------|---------------------------|
   # |              | A2          |300          | 3                       |               | 0.3                       |
   # |--------------|-------------|-------------|-------------------------|---------------|---------------------------|
   # |              | A3          |600          | 6                       |               | 0.6                       |
   # |----------------------------------------------------------------------------------------------------------------
   # |
   # |
   # |采购单身 pmdn_t
   # |-----------------------------------------------------------
   # |pmdn001  | pmdn015| pmdn007| pmdn046  | pmdn047 |pmdn048  |
   # |---------|--------|--------|----------|---------|---------|
   # |生产料件  | 单价   | 数量   | 未税      | 含税    |税额      |
   # |---------|--------|--------|----------|---------|---------|
   # |A        | 100    | 100    | 10000    | 11700   |1700     |
   # |-----------------------------------------------------------
   # |
   # |采购交期明细档 pmdo_t
   # |-----------------------------------------------------------------------------------------------------------------------------------
   # |      |pmdo001   |pmdo004   |pmdo005       |pmdo007       |pmdo008   |pmdo022          | pmdo032      | pmdo033      | pmdo034     |
   # |      |料件编号   |采购单位   |采购数量      |折合主件数量   |QPA       |参考单价          | 分批未税金额  | 分批含税金额  | 分批税额     |
   # |------|----------|----------|--------------|--------------|----------|-----------------|--------------|--------------|-------------|
   # |公式  |sfac001   |sfac004   |pmdn007 * A   |pmdn007 * C   |A         |未税金额/数量     | pmdn046 * C   | pmdn047 * C | pmdn048 * C |
   # |      |          |          |              |              |          |或含税金额/数量   |              |              |             |
   # |------|----------|----------|--------------|--------------|----------|-----------------|--------------|--------------|-------------|
   # |      |A1        |PCS       |100           |10            |1         |10               | 1000         | 1170         | 170         |
   # |------|----------|----------|--------------|--------------|----------|-----------------|--------------|--------------|-------------|
   # |      |A2        |PCS       |300           |30            |3         |10               | 3000         | 3510         | 510         |
   # |------|----------|----------|--------------|--------------|----------|-----------------|--------------|--------------|-------------|
   # |      |A3        |PCS       |600           |60            |6         |10               | 6000         | 7020         | 1020        |
   # |------|----------|----------|--------------|--------------|----------|-----------------|--------------|--------------|-------------|
   # |合计   |          |          |1000          |100           |10        |30               | 10000        | 11700        | 1700        |
   # |-----------------------------------------------------------------------------------------------------------------------------------

   #若最后多产出主件的"折合主件数量"/"未税金额"/"含税金额"/"税额"与pmdn_t的那笔资料不匹配时,差异的部分由多产出主件金额最大的那笔资料吸收


   LET l_i = 1
   #制程工单时,资料取至pmdn,若是多产出主件时特别处理
   SELECT sfaa003,sfaa012,sfaa061 INTO l_sfaa003,l_sfaa012,l_sfaa061 FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaadocno = p_sfcb.sfcbdocno
   SELECT COUNT(*),SUM(sfac003) INTO l_cnt,l_sum_sfac003 FROM sfac_t
    WHERE sfacent   = g_enterprise
      AND sfacdocno = p_sfcb.sfcbdocno
#     AND sfac002   = '3'
      AND sfac002   IN ('3','4')

   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF cl_null(l_sum_sfac003) THEN LET l_sum_sfac003 = 0 END IF

   #l_type = '1' --制程工单 或 (非多产出主件 & 非拆件工单) 或 代买料
   #l_type = '2' --拆件工单 & 非制程工单 & 非代买料
   #l_type = '3' --多产出主件 & 非制程工单 & 非代买料
   LET l_type = ''
   IF l_sfaa061 = 'Y' OR l_cnt = 0 OR p_pmdn.pmdn019 = '8' THEN
      LET l_type = '1'
   ELSE
      IF l_sfaa003 = '3' THEN    #拆件工单
         LET l_type = '2'
      ELSE
         LET l_type = '3'
      END IF
   END IF

   #制程工单或是非多产出主件或代买料
#  IF l_sfaa061 = 'Y' OR l_cnt = 0 OR p_pmdn.pmdn019 = '8' THEN
   IF l_type = '1' THEN
      LET l_flag = '2'
      LET l_arr[1].item    = p_pmdn.pmdn001
      LET l_arr[1].qty     = p_pmdn.pmdn007
      LET l_arr[1].unit    = p_pmdn.pmdn006
      LET l_arr[1].rate    = 1
      LET l_arr[1].QPA     = 1
      LET l_arr[1].pmdo003 = p_pmdn.pmdn019
      LET l_arr[1].pmdo005 = p_pmdn.pmdn007
      LET l_arr[1].pmdo007 = p_pmdn.pmdn007
      LET l_arr[1].pmdo008 = 1
      LET l_arr[1].pmdo022 = p_pmdn.pmdn015
      LET l_arr[1].pmdo032 = p_pmdn.pmdn046
      LET l_arr[1].pmdo033 = p_pmdn.pmdn047
      LET l_arr[1].pmdo034 = p_pmdn.pmdn048
      LET l_cnt = 1
   END IF

   IF l_type = '3' THEN
   #非制程工单 & 多产出主件 & 非代买料
      SELECT oodb005 INTO l_oodb005 FROM oodb_t,ooef_t
        WHERE ooefent = oodbent AND oodbent = g_enterprise
          AND ooef001 = g_site
          AND ooef019 = oodb001
          AND oodb002 = p_pmdn.pmdn016

      LET l_flag = '1'
      DECLARE s_apmt500_gen_4_ins_pmdo_cs1 CURSOR FOR
      SELECT sfac001,sfac003,sfac004,1,1,0,0,1,0,0,0,0 FROM sfac_t
       WHERE sfacent   = g_enterprise
         AND sfacdocno = p_sfcb.sfcbdocno
         AND sfac002   = '3'

      LET l_tot_pmdo007 = 0
      LET l_tot_pmdo032 = 0
      LET l_tot_pmdo033 = 0
      LET l_tot_pmdo034 = 0
      LET l_max_sum     = 0
      FOREACH s_apmt500_gen_4_ins_pmdo_cs1 INTO l_arr[l_i].*
         LET l_arr[l_i].rate    = l_arr[l_i].qty / l_sum_sfac003
         LET l_arr[l_i].QPA     = l_arr[l_i].qty / l_sfaa012
         LET l_arr[l_i].pmdo003 = p_pmdn.pmdn019
         LET l_arr[l_i].pmdo005 = p_pmdn.pmdn007 * l_arr[l_i].QPA
         LET l_arr[l_i].pmdo007 = p_pmdn.pmdn007 * l_arr[l_i].rate
         LET l_arr[l_i].pmdo008 = l_arr[l_i].QPA
         LET l_arr[l_i].pmdo032 = p_pmdn.pmdn046 * l_arr[l_i].rate
         LET l_arr[l_i].pmdo033 = p_pmdn.pmdn047 * l_arr[l_i].rate
         LET l_arr[l_i].pmdo034 = p_pmdn.pmdn048 * l_arr[l_i].rate
         IF l_oodb005 = 'Y' THEN  #含税
            LET l_arr[l_i].pmdo022 = l_arr[l_i].pmdo033 / l_arr[l_i].pmdo005
         ELSE                     #不含税
            LET l_arr[l_i].pmdo022 = l_arr[l_i].pmdo032 / l_arr[l_i].pmdo005
         END IF

         LET l_tot_pmdo007 = l_tot_pmdo007 + l_arr[l_i].pmdo007
         LET l_tot_pmdo032 = l_tot_pmdo032 + l_arr[l_i].pmdo032
         LET l_tot_pmdo033 = l_tot_pmdo033 + l_arr[l_i].pmdo033
         LET l_tot_pmdo034 = l_tot_pmdo034 + l_arr[l_i].pmdo034

         IF l_max_sum < l_arr[l_i].pmdo033 THEN
            LET l_max_sum = l_arr[l_i].pmdo033
            LET l_j = l_i
         END IF
         LET l_i = l_i + 1
      END FOREACH
      LET l_cnt = l_i - 1

      #多有尾差时,把差异的单价分在单价最大的一笔上
      #折合主件数量
      IF l_tot_pmdo007 <> p_pmdn.pmdn007 THEN
          LET l_arr[l_j].pmdo007 = l_arr[l_j].pmdo007 + p_pmdn.pmdn007 - l_tot_pmdo007
      END IF
      #未税金额
      IF l_tot_pmdo032 <> p_pmdn.pmdn046 THEN
          LET l_arr[l_j].pmdo032 = l_arr[l_j].pmdo032 + p_pmdn.pmdn046 - l_tot_pmdo032
      END IF
      #含税金额
      IF l_tot_pmdo033 <> p_pmdn.pmdn047 THEN
          LET l_arr[l_j].pmdo033 = l_arr[l_j].pmdo033 + p_pmdn.pmdn047 - l_tot_pmdo033
      END IF
      #税额
      IF l_tot_pmdo034 <> p_pmdn.pmdn048 THEN
          LET l_arr[l_j].pmdo034 = l_arr[l_j].pmdo034 + p_pmdn.pmdn048 - l_tot_pmdo034
      END IF

   END IF

   #拆件工单时,不管主件是否代买,都要写入的
   IF l_type = '2' THEN
      LET l_i = 1
      LET l_flag = '1'

      LET l_arr[l_i].item    = p_pmdn.pmdn001
      LET l_arr[l_i].qty     = p_pmdn.pmdn007
      LET l_arr[l_i].unit    = p_pmdn.pmdn006
      LET l_arr[l_i].rate    = 1
      LET l_arr[l_i].QPA     = 1
      LET l_arr[l_i].pmdo003 = p_pmdn.pmdn019
      LET l_arr[l_i].pmdo005 = p_pmdn.pmdn007
      LET l_arr[l_i].pmdo007 = p_pmdn.pmdn007
      LET l_arr[l_i].pmdo008 = 1
      LET l_arr[l_i].pmdo022 = p_pmdn.pmdn015
      LET l_arr[l_i].pmdo032 = p_pmdn.pmdn046
      LET l_arr[l_i].pmdo033 = p_pmdn.pmdn047
      LET l_arr[l_i].pmdo034 = p_pmdn.pmdn048
      LET l_i = l_i + 1

      DECLARE s_apmt500_gen_4_ins_pmdo_cs2 CURSOR FOR
      SELECT sfac001,sfac003,sfac004,1,1,0,0,1,0,0,0,0 FROM sfac_t
       WHERE sfacent   = g_enterprise
         AND sfacdocno = p_sfcb.sfcbdocno
         AND sfac002   = '4'

      LET l_tot_pmdo007 = 0
      LET l_max_sum     = 0
      FOREACH s_apmt500_gen_4_ins_pmdo_cs2 INTO l_arr[l_i].*
         LET l_arr[l_i].rate    = l_arr[l_i].qty / l_sum_sfac003
         LET l_arr[l_i].QPA     = l_arr[l_i].qty / l_sfaa012
         LET l_arr[l_i].pmdo003 = '11'
         LET l_arr[l_i].pmdo005 = p_pmdn.pmdn007 * l_arr[l_i].QPA
         LET l_arr[l_i].pmdo007 = p_pmdn.pmdn007 * l_arr[l_i].rate
         LET l_arr[l_i].pmdo008 = l_arr[l_i].QPA
         LET l_arr[l_i].pmdo032 = 0
         LET l_arr[l_i].pmdo033 = 0
         LET l_arr[l_i].pmdo034 = 0
         LET l_arr[l_i].pmdo022 = 0

         LET l_tot_pmdo007 = l_tot_pmdo007 + l_arr[l_i].pmdo007

         IF l_max_sum < l_arr[l_i].pmdo007 THEN
            LET l_max_sum = l_arr[l_i].pmdo007
            LET l_j = l_i
         END IF
         LET l_i = l_i + 1
      END FOREACH
      LET l_cnt = l_i - 1

      #多有尾差时,把差异的单价分在单价最大的一笔上
      #折合主件数量
      IF l_tot_pmdo007 <> p_pmdn.pmdn007 THEN
          LET l_arr[l_j].pmdo007 = l_arr[l_j].pmdo007 + p_pmdn.pmdn007 - l_tot_pmdo007
      END IF
   END IF


   FOR l_i = 1 TO l_cnt
       INITIALIZE l_pmdo.* TO NULL
       LET l_pmdo.pmdoent   = p_pmdn.pmdnent               #企業編號
       LET l_pmdo.pmdosite  = p_pmdn.pmdnsite              #營運據點
       LET l_pmdo.pmdodocno = p_pmdn.pmdndocno             #採購單號
       LET l_pmdo.pmdoseq   = p_pmdn.pmdnseq               #採購項次
       #項序
       SELECT MAX(pmdoseq1) + 1 INTO l_pmdo.pmdoseq1
         FROM pmdo_t
        WHERE pmdoent   = g_enterprise
          AND pmdodocno = l_pmdo.pmdodocno
          AND pmdoseq   = l_pmdo.pmdoseq
       IF cl_null(l_pmdo.pmdoseq1) THEN
          LET l_pmdo.pmdoseq1 = 1
       END IF
       LET l_pmdo.pmdoseq2  = 1                            #分批序
       LET l_pmdo.pmdo001   = l_arr[l_i].item              #料件編號
       LET l_pmdo.pmdo002   = p_pmdn.pmdn002               #產品特徵
       LET l_pmdo.pmdo003   = l_arr[l_i].pmdo003           #子件特性
       LET l_pmdo.pmdo004   = l_arr[l_i].unit              #採購單位
       ##採購總數量
       LET l_pmdo.pmdo005   = l_arr[l_i].pmdo005
       LET l_pmdo.pmdo006   = l_pmdo.pmdo005               #分批採購數量
       LET l_pmdo.pmdo007   = l_arr[l_i].pmdo007           #折合主件數量
       LET l_pmdo.pmdo008   = l_arr[l_i].pmdo008           #QPA

       LET l_pmdo.pmdo009   = '1'                          #交期類型
       LET l_pmdo.pmdo010   = ''                           #收貨時段
       LET l_pmdo.pmdo011   = p_pmdn.pmdn012               #出貨日期
       LET l_pmdo.pmdo012   = p_pmdn.pmdn013               #到廠日期
       LET l_pmdo.pmdo013   = p_pmdn.pmdn014               #到庫日期
       LET l_pmdo.pmdo014   = 'N'                          #MRP交期凍結
       LET l_pmdo.pmdo015   = 0                            #已收貨量
       LET l_pmdo.pmdo016   = 0                            #驗退量
       LET l_pmdo.pmdo017   = 0                            #倉退換貨量
       LET l_pmdo.pmdo019   = 0                            #已入庫量
       LET l_pmdo.pmdo020   = 0                            #VMI請款量
       LET l_pmdo.pmdo021   = '2'                          #交貨狀態
       LET l_pmdo.pmdo022   = l_arr[l_i].pmdo022           #參考價格
       LET l_pmdo.pmdo023   = p_pmdn.pmdn016               #稅別
       LET l_pmdo.pmdo024   = p_pmdn.pmdn017               #稅率
       LET l_pmdo.pmdo025   = ''                           #電子採購單號
       LET l_pmdo.pmdo026   = g_user                       #最近修改人員
       LET l_pmdo.pmdo027   = g_dept                       #最近修改時間
       #分批參考單位
       SELECT imaf015 INTO l_pmdo.pmdo028 FROM imaf_t
        WHERE imafent  = g_enterprise
          AND imafsite = g_site
          AND imaf001  = l_pmdo.pmdo001

       #分批參考數量
       #若没有参考单位时,参考数量DEFAULT NULL
       IF cl_null(l_pmdo.pmdo028) THEN
          LET l_pmdo.pmdo029 = NULL
       ELSE
          #CALL s_aimi190_get_convert(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028)
          #     RETURNING l_success,l_rate
          #IF NOT l_success THEN
          #   LET l_rate = 1
          #END IF
          #LET l_pmdo.pmdo029 = l_pmdo.pmdo006 * l_rate
          CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
              RETURNING l_success,l_pmdo.pmdo029
       END IF

       LET l_pmdo.pmdo030   = l_pmdo.pmdo004               #分批計價單位
       LET l_pmdo.pmdo031   = l_pmdo.pmdo006               #分批計價數量

       LET l_pmdo.pmdo032   = l_arr[l_i].pmdo032           #分批未稅金額
       LET l_pmdo.pmdo033   = l_arr[l_i].pmdo033           #分批含稅金額
       LET l_pmdo.pmdo034   = l_arr[l_i].pmdo034           #分批稅額
       LET l_pmdo.pmdo900   = p_pmdn.pmdn900               #保留欄位str
       LET l_pmdo.pmdo999   = p_pmdn.pmdn999               #保留欄位end

       LET l_pmdo.pmdo040   = 0                            #160913-00008#1
       LET l_pmdo.pmdo041   = 0
       LET l_pmdo.pmdo042   = 0
       LET l_pmdo.pmdo043   = 0
       LET l_pmdo.pmdo044   = 0

       #161124-00048#9 mod-S
#      INSERT INTO pmdo_t VALUES(l_pmdo.*)
       INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,
                          pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,
                          pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                          pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                          pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,
                          pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                          pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
                          pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,
                          pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,
                          pmdo200,pmdo201,pmdo900,pmdo999,pmdo041,
                          pmdo042,pmdo043,pmdo044)
                   VALUES(l_pmdo.*)
      #161124-00048#9 mod-E
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'insert pmdo_t'
          LET g_errparam.popup = TRUE
          CALL cl_err()

          RETURN r_success
       END IF
   END FOR

   LET r_success = TRUE
   RETURN r_success


END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 采购关联单据明细档 pmdp_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_4_ins_pmdp(p_sfcb,p_pmdn)
#                       RETURNING r_success
# Input parameter: p_sfcb         工单制程信息
#                : p_pmdn         采购明细单身资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014/04/25 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_4_ins_pmdp(p_sfcb,p_pmdn)
   DEFINE p_sfcb          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          sfaa010       LIKE sfaa_t.sfaa010,
                          sfac006       LIKE sfac_t.sfac006,
                          sfcb001       LIKE sfcb_t.sfcb001,
                          sfcb002       LIKE sfcb_t.sfcb002,
                          sfcb003       LIKE sfcb_t.sfcb003,
                          sfcb004       LIKE sfcb_t.sfcb004,
                          sfcb020       LIKE sfcb_t.sfcb020,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          sfcb044       LIKE sfcb_t.sfcb044,
                          sfcb045       LIKE sfcb_t.sfcb045,
                          price         LIKE pmdn_t.pmdn015   
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE p_pmdn          RECORD LIKE pmdn_t.*
   DEFINE p_pmdn RECORD  #採購單身明細檔
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdp          RECORD LIKE pmdp_t.*
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

   
   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF
   
   INITIALIZE l_pmdp.* TO NULL

   LET l_pmdp.pmdpent   = p_pmdn.pmdnent                #企業編號      
   LET l_pmdp.pmdpsite  = p_pmdn.pmdnsite               #營運據點      
   LET l_pmdp.pmdpdocno = p_pmdn.pmdndocno              #採購單號      
   LET l_pmdp.pmdpseq   = p_pmdn.pmdnseq                #採購項次      
   LET l_pmdp.pmdpseq1  = 1                             #項序          
   LET l_pmdp.pmdp001   = p_pmdn.pmdn001                #料件編號      
   LET l_pmdp.pmdp002   = p_pmdn.pmdn002                #產品特徵      
   LET l_pmdp.pmdp003   = p_sfcb.sfcbdocno              #來源單號      
   LET l_pmdp.pmdp004   = p_sfcb.sfcb001                #來源項次      
   LET l_pmdp.pmdp005   = 0                             #來源項序      
   LET l_pmdp.pmdp006   = 0                             #來源分批序    
   LET l_pmdp.pmdp007   = p_pmdn.pmdn001                #來源料號      
   LET l_pmdp.pmdp008   = p_pmdn.pmdn002                #來源產品特徵  
   LET l_pmdp.pmdp009   = p_sfcb.sfcb003                #來源作業編號  
   LET l_pmdp.pmdp010   = p_sfcb.sfcb004                #來源製程序    
#   LET l_pmdp.pmdp011   = ''                            #來源BOM特性   #170325-00090#1 2017/03/28 mark by 08172
   LET l_pmdp.pmdp012   = ''                            #來源生產控制組
   LET l_pmdp.pmdp021   = 1                             #沖銷順序      
   LET l_pmdp.pmdp022   = p_sfcb.sfcb020                #需求單位      
   LET l_pmdp.pmdp023   = p_sfcb.carry_qty              #需求數量      
   LET l_pmdp.pmdp024   = p_sfcb.carry_qty              #折合採購量    
   LET l_pmdp.pmdp025   = 0                             #已收貨量      
   LET l_pmdp.pmdp026   = 0                             #已入庫量      
   LET l_pmdp.pmdp900   = p_pmdn.pmdn900                #保留欄位str   
   LET l_pmdp.pmdp999   = p_pmdn.pmdn999                #保留欄位end   
   #170325-00090#1 -s 20170328 add by 08172
   #取来源特性只有类型为1.一般的才带出BOM特性
   SELECT sfaa011 INTO l_pmdp.pmdp011
     FROM sfaa_t,sfac_t 
    WHERE sfaaent = g_enterprise
      AND sfaaent = sfacent
      AND sfaadocno = sfacdocno
      AND sfac002 = '1'
      AND sfaadocno = l_pmdp.pmdp003
      AND sfac001 = l_pmdp.pmdp007
   #170325-00090#1 -e 20170328 add by 08172
   #161124-00048#9 mod-S
#   INSERT INTO pmdp_t VALUES(l_pmdp.*)
   INSERT INTO pmdp_t(pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,
                      pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,
                      pmdp006,pmdp007,pmdp008,pmdp009,pmdp010,
                      pmdp011,pmdp012,pmdp021,pmdp022,pmdp023,
                      pmdp024,pmdp025,pmdp026,pmdp900,pmdp999)
               VALUES(l_pmdp.*)
   #161124-00048#9 mod-E
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert pmdp_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 从重复性工单产生采购单
# Memo...........:
# Usage..........: CALL s_apmt500_gen_6(p_key1,p_key2,p_doc_type,p_date,p_combine)
#                       RETURNING r_success,r_start_no,r_end_no
# Input parameter: p_key1         来源单号
#                : p_key2         来源项次
#                : p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否
# Return code....: r_success      成功否标识符
#                : r_start_no     起始QC单号
#                : r_end_no       截止QC单号
# Date & Author..: 2014-05-04 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_6(p_key1,p_key2,p_doc_type,p_date,p_combine)
   DEFINE p_key1          LIKE qcba_t.qcba001
   DEFINE p_key2          LIKE qcba_t.qcba002
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1   
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_start_no      LIKE qcba_t.qcbadocno
   DEFINE r_end_no        LIKE qcba_t.qcbadocno
   DEFINE l_sql           STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno
   DEFINE l_pmdl          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD

   LET r_success  = FALSE
   LET r_start_no = ''
   LET r_end_no   = ''
                             
   IF p_combine = 'N' THEN
      LET g_sql = " SELECT UNIQUE srab000,srab001,srab004,srab005,srab006,srac008,srac009,srab009,",
                  "        pmdl004,pmdl011,pmdl015,pmdl017 ",
                  "   FROM asrp400_tmp_t",
                  "  ORDER BY srab000,srab001,srab004,srab005,srab006,srac008,srac009,srab009  "
   ELSE
      LET g_sql = " SELECT UNIQUE '','','','','','','','',pmdl004,pmdl011,pmdl015,pmdl017 ",
                  "   FROM asrp400_tmp_t",
                  "  ORDER BY pmdl004,pmdl011,pmdl015,pmdl017 "
   END IF   

   PREPARE s_apmt500_gen_6_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare s_apmt500_gen_6_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_start_no,r_end_no
   END IF

   DECLARE s_apmt500_gen_6_cs1 CURSOR FOR s_apmt500_gen_6_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare s_apmt500_gen_6_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_start_no,r_end_no
   END IF

   FOREACH s_apmt500_gen_6_cs1 INTO l_pmdl.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_apmt500_gen_6_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success,r_start_no,r_end_no
      END IF

      #插入"pmdl_t:採購單頭檔"
      CALL s_apmt500_gen_6_ins_pmdl(p_doc_type,p_date,p_combine,l_pmdl.*)
           RETURNING l_success,l_pmdldocno
      IF NOT l_success THEN
         RETURN r_success,r_start_no,r_end_no
      END IF
      
      #插入"pmdn_t:採購明細檔"
      CALL s_apmt500_gen_6_ins_pmdn(l_pmdldocno,l_pmdl.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success,r_start_no,r_end_no
      END IF

      IF cl_null(r_start_no) THEN
         LET r_start_no = l_pmdldocno
      END IF

      LET r_end_no = l_pmdldocno
  
   END FOREACH

   LET r_success = TRUE


   RETURN r_success,r_start_no,r_end_no

END FUNCTION

################################################################################
# Descriptions...: 从重复性工单产生采购单 -- 产生采购单头pmdl_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_6_ins_pmdl(p_doc_type,p_date,p_combine,p_pmdl)
#                  RETURNING r_success,r_pmdldocno
# Input parameter: p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否
#                : p_pmdl         采购单头信息
# Return code....: r_success      成功否标识符
#                : r_pmdldocno    产生的采购单号
# Date & Author..: 2014-05-04 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_6_ins_pmdl(p_doc_type,p_date,p_combine,p_pmdl)
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1   
   DEFINE p_pmdl          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_pmdldocno     LIKE pmdl_t.pmdldocno
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdl          RECORD LIKE pmdl_t.*
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_doc_type      LIKE ooba_t.ooba002
   #161124-00048#9 mod-S
#   DEFINE l_pmal          RECORD LIKE pmal_t.*
#   DEFINE l_pmab          RECORD LIKE pmab_t.*
   DEFINE l_pmal RECORD  #採購控制組供應商預設條件檔
          pmalent LIKE pmal_t.pmalent, #企业编号
          pmal001 LIKE pmal_t.pmal001, #交易对象编号
          pmal002 LIKE pmal_t.pmal002, #控制组编号
          pmal003 LIKE pmal_t.pmal003, #惯用交易币种
          pmal004 LIKE pmal_t.pmal004, #惯用税务规则
          pmal005 LIKE pmal_t.pmal005, #惯用发票开立方式
          pmal006 LIKE pmal_t.pmal006, #惯用付款条件
          pmal008 LIKE pmal_t.pmal008, #惯用采购渠道
          pmal009 LIKE pmal_t.pmal009, #惯用采购分类
          pmal010 LIKE pmal_t.pmal010, #惯用报表语言
          pmal011 LIKE pmal_t.pmal011, #惯用交运方式
          pmal012 LIKE pmal_t.pmal012, #惯用交运起点
          pmal013 LIKE pmal_t.pmal013, #惯用交运终点
          pmal014 LIKE pmal_t.pmal014, #惯用卸货港
          pmal015 LIKE pmal_t.pmal015, #惯用佣金率
          pmal016 LIKE pmal_t.pmal016, #折扣率
          pmal017 LIKE pmal_t.pmal017, #惯用ForWarder
          pmal018 LIKE pmal_t.pmal018, #惯用Notify
          pmal019 LIKE pmal_t.pmal019, #负责采购人员
          pmal020 LIKE pmal_t.pmal020, #惯用交易条件
          pmal021 LIKE pmal_t.pmal021, #惯用取价方式
          pmal022 LIKE pmal_t.pmal022, #惯用票类型
          pmal023 LIKE pmal_t.pmal023, #惯用内外购
          pmal024 LIKE pmal_t.pmal024, #惯用汇率计算基准
          pmalownid LIKE pmal_t.pmalownid, #资料所有者
          pmalowndp LIKE pmal_t.pmalowndp, #资料所有部门
          pmalcrtid LIKE pmal_t.pmalcrtid, #资料录入者
          pmalcrtdp LIKE pmal_t.pmalcrtdp, #资料录入部门
          pmalcrtdt LIKE pmal_t.pmalcrtdt, #资料创建日
          pmalmodid LIKE pmal_t.pmalmodid, #资料更改者
          pmalmoddt LIKE pmal_t.pmalmoddt, #最近更改日
          pmalstus LIKE pmal_t.pmalstus, #状态码
          pmal025 LIKE pmal_t.pmal025  #负责采购部门
   END RECORD
   DEFINE l_pmab RECORD  #交易對象據點檔
          pmabent LIKE pmab_t.pmabent, #企业编号
          pmabsite LIKE pmab_t.pmabsite, #营运据点
          pmab001 LIKE pmab_t.pmab001, #交易对象编号
          pmab002 LIKE pmab_t.pmab002, #信用额度检查
          pmab003 LIKE pmab_t.pmab003, #额度交易对象
          pmab004 LIKE pmab_t.pmab004, #信用评核等级
          pmab005 LIKE pmab_t.pmab005, #额度计算币种
          pmab006 LIKE pmab_t.pmab006, #企业额度
          pmab007 LIKE pmab_t.pmab007, #可超出率
          pmab008 LIKE pmab_t.pmab008, #有效期限
          pmab009 LIKE pmab_t.pmab009, #逾期账款宽限天数
          pmab010 LIKE pmab_t.pmab010, #允许除外额度
          pmab011 LIKE pmab_t.pmab011, #额度警示水准一
          pmab012 LIKE pmab_t.pmab012, #水准一通知层
          pmab013 LIKE pmab_t.pmab013, #额度警示水准二
          pmab014 LIKE pmab_t.pmab014, #水准二通知层
          pmab015 LIKE pmab_t.pmab015, #额度警示水准三
          pmab016 LIKE pmab_t.pmab016, #水准三通知层
          pmab017 LIKE pmab_t.pmab017, #启动预期应收通知
          pmab018 LIKE pmab_t.pmab018, #预期应收通知层
          pmab030 LIKE pmab_t.pmab030, #供应商ABC分类
          pmab031 LIKE pmab_t.pmab031, #负责采购人员
          pmab032 LIKE pmab_t.pmab032, #供应商惯用报表语言
          pmab033 LIKE pmab_t.pmab033, #供应商惯用交易币种
          pmab034 LIKE pmab_t.pmab034, #供应商惯用交易税种
          pmab035 LIKE pmab_t.pmab035, #供应商惯用发票开立方式
          pmab036 LIKE pmab_t.pmab036, #供应商惯用立账方式
          pmab037 LIKE pmab_t.pmab037, #供应商惯用付款条件
          pmab038 LIKE pmab_t.pmab038, #供应商惯用采购渠道
          pmab039 LIKE pmab_t.pmab039, #供应商惯用采购分类
          pmab040 LIKE pmab_t.pmab040, #供应商惯用交运方式
          pmab041 LIKE pmab_t.pmab041, #供应商惯用交运起点
          pmab042 LIKE pmab_t.pmab042, #供应商惯用交运终点
          pmab043 LIKE pmab_t.pmab043, #供应商惯用卸货港
          pmab044 LIKE pmab_t.pmab044, #供应商惯用其它条件
          pmab045 LIKE pmab_t.pmab045, #供应商惯用佣金率
          pmab046 LIKE pmab_t.pmab046, #供应商折扣率
          pmab047 LIKE pmab_t.pmab047, #供应商惯用Forwarder
          pmab048 LIKE pmab_t.pmab048, #供应商惯用 Notify
          pmab049 LIKE pmab_t.pmab049, #默认允许分批收货
          pmab050 LIKE pmab_t.pmab050, #最多可拆解批次
          pmab051 LIKE pmab_t.pmab051, #默认允许提前收货
          pmab052 LIKE pmab_t.pmab052, #可提前收货天数
          pmab053 LIKE pmab_t.pmab053, #惯用交易条件
          pmab054 LIKE pmab_t.pmab054, #惯用取价方式
          pmab055 LIKE pmab_t.pmab055, #应付账款类别
          pmab056 LIKE pmab_t.pmab056, #供应商惯用发票类型
          pmab057 LIKE pmab_t.pmab057, #供应商惯用内外购
          pmab058 LIKE pmab_t.pmab058, #供应商惯用汇率计算基准
          pmab060 LIKE pmab_t.pmab060, #供应商评鉴计算分类
          pmab061 LIKE pmab_t.pmab061, #价格评分
          pmab062 LIKE pmab_t.pmab062, #达交率评分
          pmab063 LIKE pmab_t.pmab063, #质量评分
          pmab064 LIKE pmab_t.pmab064, #配合度评分
          pmab065 LIKE pmab_t.pmab065, #调整加减分
          pmab066 LIKE pmab_t.pmab066, #定性评分一
          pmab067 LIKE pmab_t.pmab067, #定性评分二
          pmab068 LIKE pmab_t.pmab068, #定性评分三
          pmab069 LIKE pmab_t.pmab069, #定性评分四
          pmab070 LIKE pmab_t.pmab070, #定性评分五
          pmab071 LIKE pmab_t.pmab071, #检验程度
          pmab072 LIKE pmab_t.pmab072, #检验水准
          pmab073 LIKE pmab_t.pmab073, #检验级数
          pmab080 LIKE pmab_t.pmab080, #客户ABC分类
          pmab081 LIKE pmab_t.pmab081, #负责业务人员
          pmab082 LIKE pmab_t.pmab082, #客户惯用报表语言
          pmab083 LIKE pmab_t.pmab083, #客户惯用交易币种
          pmab084 LIKE pmab_t.pmab084, #客户惯用交易税种
          pmab085 LIKE pmab_t.pmab085, #客户惯用发票开立方式
          pmab086 LIKE pmab_t.pmab086, #客户惯用立账方式
          pmab087 LIKE pmab_t.pmab087, #客户惯用收款条件
          pmab088 LIKE pmab_t.pmab088, #客户惯用销售渠道
          pmab089 LIKE pmab_t.pmab089, #客户惯用销售分类
          pmab090 LIKE pmab_t.pmab090, #客户惯用交运方式
          pmab091 LIKE pmab_t.pmab091, #客户惯用交运起点
          pmab092 LIKE pmab_t.pmab092, #客户惯用交运终点
          pmab093 LIKE pmab_t.pmab093, #客户惯用卸货港
          pmab094 LIKE pmab_t.pmab094, #客户惯用其它条件
          pmab095 LIKE pmab_t.pmab095, #客户惯用佣金率
          pmab096 LIKE pmab_t.pmab096, #客户折扣率
          pmab097 LIKE pmab_t.pmab097, #客户惯用Forwarder
          pmab098 LIKE pmab_t.pmab098, #客户惯用 Notify
          pmab099 LIKE pmab_t.pmab099, #默认允许分批交货
          pmab100 LIKE pmab_t.pmab100, #最多可拆解批次
          pmab101 LIKE pmab_t.pmab101, #默认允许提前交货
          pmab102 LIKE pmab_t.pmab102, #可提前交货天数
          pmab103 LIKE pmab_t.pmab103, #惯用交易条件
          pmab104 LIKE pmab_t.pmab104, #惯用取价方式
          pmab105 LIKE pmab_t.pmab105, #应收账款类别
          pmab106 LIKE pmab_t.pmab106, #客户惯用发票类型
          pmab107 LIKE pmab_t.pmab107, #客户惯用内外销
          pmab108 LIKE pmab_t.pmab108, #客户惯用汇率计算基准
          pmabownid LIKE pmab_t.pmabownid, #资料所有者
          pmabowndp LIKE pmab_t.pmabowndp, #资料所有部门
          pmabcrtid LIKE pmab_t.pmabcrtid, #资料录入者
          pmabcrtdp LIKE pmab_t.pmabcrtdp, #资料录入部门
          pmabcrtdt LIKE pmab_t.pmabcrtdt, #资料创建日
          pmabmodid LIKE pmab_t.pmabmodid, #资料更改者
          pmabmoddt LIKE pmab_t.pmabmoddt, #最近更改日
          pmabcnfid LIKE pmab_t.pmabcnfid, #资料审核者
          pmabcnfdt LIKE pmab_t.pmabcnfdt, #数据审核日
          pmabstus LIKE pmab_t.pmabstus, #状态码
          pmab059 LIKE pmab_t.pmab059, #负责采购部门
          pmab109 LIKE pmab_t.pmab109, #负责业务部门
          pmab110 LIKE pmab_t.pmab110, #供应商条码包装数量
          pmab111 LIKE pmab_t.pmab111, #客户条码包装数量
          pmab019 LIKE pmab_t.pmab019, #逾期账款宽限额度
          pmab020 LIKE pmab_t.pmab020, #除外额有效日期
          pmab112 LIKE pmab_t.pmab112  #是否使用EC
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_pmal002       LIKE pmal_t.pmal002   #控制组
   DEFINE l_ooef016       LIKE ooef_t.ooef016
   DEFINE l_acc40         LIKE type_t.chr80      
   DEFINE l_oofb002       LIKE oofb_t.oofb002
   DEFINE l_scc40         LIKE type_t.chr2   #20151029 by stellar add
   
   LET r_success = FALSE
   LET r_pmdldocno = ''

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success,r_pmdldocno
   END IF

   INITIALIZE l_pmdl.* TO NULL

   #插入"采购單頭檔"
   
   #传入的采购单据日期为空时,用当前日期
   IF cl_null(p_date) THEN
      LET p_date = cl_get_today()
   END IF

   ##單號
   CALL s_aooi200_gen_docno(g_site,p_doc_type,p_date,'apmt501')
        RETURNING l_success,l_pmdl.pmdldocno
   IF NOT l_success THEN
      RETURN r_success,r_pmdldocno
   END IF

   LET l_pmdl.pmdlent   =  g_enterprise                 #企業編號        
   LET l_pmdl.pmdlsite  =  g_site                       #營運據點                
   LET l_pmdl.pmdldocdt =  p_date                       #採購日期        
   LET l_pmdl.pmdl001   =  0                            #版次            
   LET l_pmdl.pmdl002   =  g_user                       #採購人員        
   LET l_pmdl.pmdl003   =  g_dept                       #採購部門        
   LET l_pmdl.pmdl004   =  p_pmdl.pmdl004               #供應商編號      
   LET l_pmdl.pmdl005   =  '2'                          #採購性質        
   LET l_pmdl.pmdl006   =  '1'                          #多角性質        
   LET l_pmdl.pmdl007   =  '6'                          #資料來源類型     
   LET l_pmdl.pmdl008   =  ''                           #來源單號  

   #按g_user/g_dept/供应商值选出可预设的控制组代号
   CALL s_control_get_pmal002('4',g_user,g_dept,l_pmdl.pmdl004)
        RETURNING l_success,l_pmal002
   IF NOT l_success THEN
      LET l_pmal002 = NULL
   END IF

   #取供应商的控制组预设条件
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmal.* FROM pmal_t
   SELECT pmalent,pmal001,pmal002,pmal003,pmal004,
          pmal005,pmal006,pmal008,pmal009,pmal010,
          pmal011,pmal012,pmal013,pmal014,pmal015,
          pmal016,pmal017,pmal018,pmal019,pmal020,
          pmal021,pmal022,pmal023,pmal024,pmalownid,
          pmalowndp,pmalcrtid,pmalcrtdp,pmalcrtdt,pmalmodid,
          pmalmoddt,pmalstus,pmal025
     INTO l_pmal.* 
     FROM pmal_t
   #161124-00048#9 mod-E
    WHERE pmalent = g_enterprise
      AND pmal001 = l_pmdl.pmdl004
      AND pmal002 = l_pmal002
   #取供应商主档的预设条件
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmab.* FROM pmab_t
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
     INTO l_pmab.* 
     FROM pmab_t
   #161124-00048#9 mod-E
    WHERE pmabent  = g_enterprise
      AND pmabsite = g_site
      AND pmab001  = l_pmdl.pmdl004

   LET l_pmdl.pmdl009   = l_pmal.pmal006                #付款條件 
   IF cl_null(l_pmdl.pmdl009) THEN
      LET l_pmdl.pmdl009= l_pmab.pmab037
   END IF
   LET l_pmdl.pmdl010   = l_pmal.pmal020                #交易條件   
   IF cl_null(l_pmdl.pmdl010) THEN
      LET l_pmdl.pmdl010= l_pmab.pmab053
   END IF   
   LET l_pmdl.pmdl011   = p_pmdl.pmdl011                #稅別 
   
   #稅率/#單價含稅否     
   SELECT oodb006,oodb005 INTO l_pmdl.pmdl012,l_pmdl.pmdl013
     FROM oodb_t,ooef_t
     WHERE ooefent = oodbent AND oodbent = g_enterprise
       AND ooef001 = g_site 
       AND ooef019 = oodb001
       AND oodb002 = l_pmdl.pmdl011
       
   LET l_pmdl.pmdl015   = p_pmdl.pmdl015                #幣別       
   #匯率   
   SELECT ooef016 INTO l_ooef016 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site 
   #20151029 by stellar modify ----- (S)
#   CALL cl_get_para(g_enterprise,g_site,'S-BAS-0010') RETURNING l_acc40
#   CALL s_aooi160_get_exrate('1',g_site,l_pmdl.pmdldocdt,l_pmdl.pmdl015,l_ooef016,0,l_acc40)
#        RETURNING l_pmdl.pmdl016
   LET l_pmdl.pmdl054   = l_pmal.pmal023                #慣用內外購   
   IF cl_null(l_pmdl.pmdl054) THEN
      LET l_pmdl.pmdl054= l_pmab.pmab057
   END IF  
   IF cl_null(l_pmdl.pmdl054) THEN
      LET l_pmdl.pmdl054= '1'
   END IF
   
   IF NOT cl_null(l_pmdl.pmdl015) THEN
      #根據內外購獲取當前營運據點參數設置的匯率類型
      LET l_scc40 = ''
      IF l_pmdl.pmdl054 = '1' THEN
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
      ELSE
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0015')
      END IF
      IF NOT cl_null(l_scc40) THEN
         CALL s_aooi160_get_exrate('1',g_site,g_today,l_pmdl.pmdl015,l_ooef016,0,l_scc40)
              RETURNING l_pmdl.pmdl016
      END IF
   END IF
   #20151029 by stellar modify ----- (E)
  
   LET l_pmdl.pmdl017   = p_pmdl.pmdl017                #取價方式        
   LET l_pmdl.pmdl018   = ''                            #付款優惠條件    
   LET l_pmdl.pmdl019   = 'N'                           #納入 MPS/MRP計算
   LET l_pmdl.pmdl020   = l_pmal.pmal011                #運送方式    
   IF cl_null(l_pmdl.pmdl020) THEN
      LET l_pmdl.pmdl020= l_pmab.pmab040
   END IF  

   #付款供應商
   DECLARE s_apmt500_gen_6_ins_pmdl_sel_cs1 SCROLL CURSOR FOR
    SELECT pmac002 FROM pmac_t
     WHERE pmacent  = g_enterprise
       AND pmac001  = l_pmdl.pmdl004
       AND pmac003  = '1'
       AND pmacstus = 'Y'
     ORDER BY pmac004 DESC
   OPEN s_apmt500_gen_6_ins_pmdl_sel_cs1 
   FETCH FIRST s_apmt500_gen_6_ins_pmdl_sel_cs1 INTO l_pmdl.pmdl021
   IF cl_null(l_pmdl.pmdl021) THEN LET l_pmdl.pmdl021 = l_pmdl.pmdl004 END IF
   
   #送貨供應商
   DECLARE s_apmt500_gen_6_ins_pmdl_sel_cs2 SCROLL CURSOR FOR
    SELECT pmac002 FROM pmac_t
     WHERE pmacent  = g_enterprise
       AND pmac001  = l_pmdl.pmdl004
       AND pmac003  = '2'
       AND pmacstus = 'Y'
     ORDER BY pmac004 DESC
   OPEN s_apmt500_gen_6_ins_pmdl_sel_cs2
   FETCH FIRST s_apmt500_gen_6_ins_pmdl_sel_cs2 INTO l_pmdl.pmdl022   
   IF cl_null(l_pmdl.pmdl022) THEN LET l_pmdl.pmdl022 = l_pmdl.pmdl004 END IF
   
   LET l_pmdl.pmdl023   = l_pmal.pmal008                #採購通路        
   IF cl_null(l_pmdl.pmdl023) THEN
      LET l_pmdl.pmdl023= l_pmab.pmab038
   END IF    
 
   LET l_pmdl.pmdl024   = l_pmal.pmal009                #採購分類         
   IF cl_null(l_pmdl.pmdl024) THEN
      LET l_pmdl.pmdl024= l_pmab.pmab039
   END IF      
   

   #送貨地址
   SELECT pmaa027 INTO l_oofb002 FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = l_pmdl.pmdl004
   
   DECLARE s_apmt500_gen_6_ins_pmdl_sel_cs3 SCROLL CURSOR FOR
    SELECT oofb019 FROM oofb_t
     WHERE oofbent  = g_enterprise
       AND oofb002  = l_oofb002
       AND oofb008  = '3'                     #161229-00014#1---dujuan-----'6' 改 ‘3’
       AND oofbstus = 'Y'
     ORDER BY oofb010 DESC
   OPEN s_apmt500_gen_6_ins_pmdl_sel_cs3 
   FETCH FIRST s_apmt500_gen_6_ins_pmdl_sel_cs3 INTO l_pmdl.pmdl025 
   
   #帳款地址
   DECLARE s_apmt500_gen_6_ins_pmdl_sel_cs4 SCROLL CURSOR FOR
    SELECT oofb019 FROM oofb_t
     WHERE oofbent  = g_enterprise
       AND oofb002  = l_oofb002
       AND oofb008  = '5'
       AND oofbstus = 'Y'
     ORDER BY oofb010 DESC
   OPEN s_apmt500_gen_6_ins_pmdl_sel_cs4 
   FETCH FIRST s_apmt500_gen_6_ins_pmdl_sel_cs4 INTO l_pmdl.pmdl026
   
   #供應商連絡人
   DECLARE s_apmt500_gen_6_ins_pmdl_sel_cs5 SCROLL CURSOR FOR
    SELECT pmaj002 FROM pmaj_t
     WHERE pmajent  = g_enterprise
       AND pmaj001  = l_pmdl.pmdl004
       AND pmajstus = 'Y'
     ORDER BY pmaj004 DESC
   OPEN s_apmt500_gen_6_ins_pmdl_sel_cs5 
   FETCH FIRST s_apmt500_gen_6_ins_pmdl_sel_cs5 INTO l_pmdl.pmdl027
                        
   LET l_pmdl.pmdl028   = ''                            #一次性交易對象識別碼                
   LET l_pmdl.pmdl029   = g_dept                        #收貨部門                            
   LET l_pmdl.pmdl030   = 'N'                           #多角貿易已拋轉                      
   LET l_pmdl.pmdl031   = ''                            #多角序號                            
   LET l_pmdl.pmdl032   = ''                            #最終客戶 
   LET l_pmdl.pmdl033   = l_pmal.pmal022                #發票類型           
   IF cl_null(l_pmdl.pmdl033) THEN
      LET l_pmdl.pmdl033= l_pmab.pmab056
   END IF                            
   LET l_pmdl.pmdl040   = 0                             #採購總未稅金額                      
   LET l_pmdl.pmdl041   = 0                             #採購總含稅金額                      
   LET l_pmdl.pmdl042   = 0                             #採購總稅額                          
   LET l_pmdl.pmdl043   = ''                            #留置原因                            
   LET l_pmdl.pmdl044   = ''                            #備註                                
   LET l_pmdl.pmdl046   = '1'                           #預付款發票開立方式                  
   LET l_pmdl.pmdl047   = 'N'                           #物流結案                            
   LET l_pmdl.pmdl048   = 'N'                           #帳流結案                            
   LET l_pmdl.pmdl049   = 'N'                           #金流結案    
   
   #20151029 by stellar mark ----- (S)
   #stellar mark:會影響取匯率，故挪到前面給值
#   LET l_pmdl.pmdl054   = l_pmal.pmal023                #慣用內外購   
#   IF cl_null(l_pmdl.pmdl054) THEN
#      LET l_pmdl.pmdl054= l_pmab.pmab107
#   END IF  
#   IF cl_null(l_pmdl.pmdl054) THEN
#      LET l_pmdl.pmdl054= '1'
#   END IF
   #20151029 by stellar mark ----- (E)
   LET l_pmdl.pmdl055   = l_pmal.pmal024                #慣用匯率計算基準 
   IF cl_null(l_pmdl.pmdl055) THEN
      #20151029 by stellar mark ----- (S)
#      LET l_pmdl.pmdl055= l_pmab.pmab108
      LET l_pmdl.pmdl055= l_pmab.pmab058
      #20151029 by stellar mark ----- (E)
   END IF  
   IF cl_null(l_pmdl.pmdl055) THEN
      LET l_pmdl.pmdl055= '1'
   END IF  


   LET l_pmdl.pmdlownid = g_user                        #資料所有者  
   LET l_pmdl.pmdlowndp = g_dept                        #資料所屬部門
   LET l_pmdl.pmdlcrtid = g_user                        #資料建立者  
   LET l_pmdl.pmdlcrtdp = g_dept                        #資料建立部門
   LET l_pmdl.pmdlcrtdt = cl_get_current()              #資料創建日  
   LET l_pmdl.pmdlmodid = ''                            #資料修改者  
   LET l_pmdl.pmdlmoddt = ''                            #最近修改日  
   LET l_pmdl.pmdlcnfid = ''                            #資料確認者  
   LET l_pmdl.pmdlcnfdt = ''                            #資料確認日  
   LET l_pmdl.pmdlpstid = ''                            #資料過帳者  
   LET l_pmdl.pmdlpstdt = ''                            #資料過帳日  
   LET l_pmdl.pmdlstus  = 'N'                           #狀態碼      
   LET l_pmdl.pmdl900   = ''                            #保留欄位str 
   LET l_pmdl.pmdl999   = ''                            #保留欄位end 

   #161124-00048#9 mod-S
#   INSERT INTO pmdl_t VALUES(l_pmdl.*)
   INSERT INTO pmdl_t(pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
                      pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
                      pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
                      pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
                      pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
                      pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
                      pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
                      pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
                      pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
                      pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
                      pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
                      pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
                      pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
                      pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
                      pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208) 
               VALUES(l_pmdl.*)
   #161124-00048#9 mod-E
   IF SQLCA.sqlcode THEN
      RETURN r_success,r_pmdldocno
   END IF

   LET r_success = TRUE
   LET r_pmdldocno = l_pmdl.pmdldocno

   RETURN r_success,r_pmdldocno
END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 产生采购单身pmdn_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_6_ins_pmdn(p_pmdndocno,p_pmdl)
#                       RETURNING r_success
# Input parameter: p_pmdndocno    采购单单号
#                : p_pmdl         采购单头信息
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-05-04 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_6_ins_pmdn(p_pmdndocno,p_pmdl)
   DEFINE p_pmdndocno     LIKE pmdn_t.pmdndocno
   DEFINE p_pmdl          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdn          RECORD LIKE pmdn_t.*
   DEFINE l_pmdn RECORD  #採購單身明細檔
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
   DEFINE l_doc_type      LIKE ooba_t.ooba002
   DEFINE l_pmal002       LIKE pmal_t.pmal002   #控制组
   DEFINE l_srab          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          srac027       LIKE srac_t.srac027,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          price         LIKE pmdn_t.pmdn015   
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE l_pmdl          RECORD LIKE pmdl_t.*
   DEFINE l_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_rate          LIKE inaj_t.inaj014
   DEFINE l_imaf173       LIKE imaf_t.imaf173
   DEFINE l_imaf174       LIKE imaf_t.imaf174
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_pmdl040       LIKE pmdl_t.pmdl040
   DEFINE l_pmdl041       LIKE pmdl_t.pmdl041
   DEFINE l_pmdl042       LIKE pmdl_t.pmdl042
   DEFINE l_sql           STRING
   DEFINE l_ooef008       LIKE ooef_t.ooef008
   DEFINE l_ooef009       LIKE ooef_t.ooef009
   DEFINE l_oodbl004  LIKE oodbl_t.oodbl004  #稅別名稱
   DEFINE l_oodb005   LIKE oodb_t.oodb005    #含稅否
   DEFINE l_oodb006   LIKE oodb_t.oodb006    #稅率 
   DEFINE l_oodb011   LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定
   DEFINE l_ooba002   LIKE ooba_t.ooba002    #150820#150819-00010 by whitney add


   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF
   
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmdl.* 
   SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
          pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
          pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
          pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
          pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
          pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
          pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
          pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
          pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
          pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
          pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
          pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208
     INTO l_pmdl.* 
   #161124-00048#9 mod-E
     FROM pmdl_t
    WHERE pmdlent   = g_enterprise
      AND pmdldocno = p_pmdndocno
   
   LET g_sql = " SELECT srab000, srab001, srab004, srab005,       srab006, srac008,",
               "        srac009, srab009, srac027, SUM(carry_qty),price ",
               "   FROM asrp400_tmp_t ",
               "  WHERE pmdl004 = '",p_pmdl.pmdl004,"'",        #供应商
               "    AND pmdl017 = '",p_pmdl.pmdl017,"'",        #取价方式
               "    AND pmdl015 = '",p_pmdl.pmdl015,"'",        #币种
               "    AND pmdl011 = '",p_pmdl.pmdl011,"'"         #税种
   IF NOT cl_null(p_pmdl.srab004) THEN
      LET g_sql = g_sql CLIPPED,"  AND srab000 =  ",p_pmdl.srab000,
                                "  AND srab001 = '",p_pmdl.srab001,"'",
                                "  AND srab004 = '",p_pmdl.srab004,"'",
                                "  AND srab005 = '",p_pmdl.srab005,"'",
                                "  AND srab006 = '",p_pmdl.srab006,"'",
                                "  AND srac008 = '",p_pmdl.srac008,"'",
                                "  AND srac009 = '",p_pmdl.srac009,"'",
                                "  AND srab009 = '",p_pmdl.srab009,"'"
   END IF
   LET g_sql = g_sql CLIPPED," GROUP BY srab000,srab001,srab004,srab005,srab006,srac008,",
                             "          srac009,srab009,srac027,price ",
                             " ORDER BY srab000,srab001,srab004,srab005,srab006,srac008,",
                             "          srac009,srab009 "                         
   PREPARE s_apmt500_gen_6_ins_pmdn_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "prepare s_apmt500_gen_6_ins_pmdn_p1" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF      
   
   DECLARE s_apmt500_gen_6_ins_pmdn_cs1 CURSOR FOR s_apmt500_gen_6_ins_pmdn_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "declare s_apmt500_gen_6_ins_pmdn_cs1" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   FOREACH s_apmt500_gen_6_ins_pmdn_cs1 INTO l_srab.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach s_apmt500_gen_6_ins_pmdn_cs1" 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         RETURN r_success
      END IF
         
      INITIALIZE l_pmdn.* TO NULL   
      
      LET l_pmdn.pmdnent   = g_enterprise      #企業編號
      LET l_pmdn.pmdnsite  = g_site            #營運據點
      LET l_pmdn.pmdndocno = p_pmdndocno       #採購單號
      #項次
      SELECT MAX(pmdnseq) + 1 INTO l_pmdn.pmdnseq
        FROM pmdn_t
       WHERE pmdnent   = g_enterprise
         AND pmdndocno = l_pmdn.pmdndocno
      IF cl_null(l_pmdn.pmdnseq) THEN
         LET l_pmdn.pmdnseq = 1
      END IF
      LET l_pmdn.pmdn001   = l_srab.srab004    #料件編號
      LET l_pmdn.pmdn002   = l_srab.srab006    #產品特徵
      LET l_pmdn.pmdn003   = ''                #包裝容器
      LET l_pmdn.pmdn004   = l_srab.srac008    #作業編號
      LET l_pmdn.pmdn005   = l_srab.srac009    #製程序  
      LET l_pmdn.pmdn006   = l_srab.srac027    #採購單位
      LET l_pmdn.pmdn007   = l_srab.carry_qty  #採購數量
      #參考單位
      SELECT imaf015 INTO l_pmdn.pmdn008 FROM imaf_t
       WHERE imafent  = g_enterprise
         AND imafsite = l_pmdn.pmdnsite
         AND imaf001  = l_pmdn.pmdn001
         
      #參考數量 
      #若没有参考单位时,参考数量DEFAULT NULL
      IF cl_null(l_pmdn.pmdn008) THEN
         LET l_pmdn.pmdn009 = NULL
      ELSE
         #CALL s_aimi190_get_convert(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008)
         #     RETURNING l_success,l_rate
         #IF NOT l_success THEN
         #   LET l_rate = 1
         #END IF
         #LET l_pmdn.pmdn009 = l_pmdn.pmdn007 * l_rate
         CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn008,l_pmdn.pmdn007)
              RETURNING l_success,l_pmdn.pmdn009
      END IF
         
#      LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位   #161229-00014#1-----dujuan-----mark
#      LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量   #161229-00014#1-----dujuan-----mark
      LET l_pmdn.pmdn014   = l_srab.srab009    #到庫日期
      
      #161229-00014#1-----dujuan-----str 
      IF cl_get_para(g_enterprise,g_site,'S-BAS-0019') = "Y" THEN
         SELECT imaf144 INTO l_pmdn.pmdn010
         FROM imaf_t
         WHERE imafent  = g_enterprise
         AND imafsite = g_site
         AND imaf001  = l_pmdn.pmdn001
            
         IF cl_null(l_pmdn.pmdn010) THEN
         LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位   
         END IF
            
         CALL s_aooi250_convert_qty(l_pmdn.pmdn001,l_pmdn.pmdn006,l_pmdn.pmdn010,l_pmdn.pmdn007)
         RETURNING l_success,l_pmdn.pmdn011
         IF NOT cl_null(l_pmdn.pmdn011) THEN
         CALL s_apmt500_unit_round(l_pmdn.pmdn010,l_pmdn.pmdn011) 
         RETURNING l_pmdn.pmdn011 
         END IF
      ELSE
         LET l_pmdn.pmdn010   = l_pmdn.pmdn006    #計價單位
         LET l_pmdn.pmdn011   = l_pmdn.pmdn007    #計價數量         
      END IF
      #161229-00014#1-----dujuan----end
      
      #推算"到厂日期"及"出貨日期"
      LET l_imaf173 = 0
      LET l_imaf174 = 0
      SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
        FROM imaf_t
       WHERE imafent = g_enterprise AND imafsite = l_pmdn.pmdnsite AND imaf001 = l_pmdn.pmdn001
      LET l_imaf173 = l_imaf173 * -1
      LET l_imaf174 = l_imaf174 * -1
      #根据当前营运据点g_site抓取aooi120中设置的行事历参照表号
      SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001=l_pmdn.pmdnsite
       
      #以下倒推,由到库日期往前推算到厂日期,再由到厂日期推算交货日期
      #1.到廠日期 = 到库日期 - [T:料件據點進銷存檔].[C:到庫前置時間]
      IF NOT cl_null(l_imaf174) AND l_imaf174 <> 0 THEN
         CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn014,0,l_imaf174) RETURNING l_pmdn.pmdn013
      ELSE
         LET l_pmdn.pmdn013 = l_pmdn.pmdn014
      END IF
      #2.出貨日期= 到厂日期 - [T:料件據點進銷存檔].[C:到廠前置時間]                              
      IF NOT cl_null(l_imaf173) AND l_imaf173 <> 0 THEN
         CALL s_date_get_work_date(l_pmdn.pmdnsite,l_ooef008,l_ooef009,l_pmdn.pmdn013,0,l_imaf173) RETURNING l_pmdn.pmdn012
      ELSE
         LET l_pmdn.pmdn012 = l_pmdn.pmdn013
      END IF

      LET l_pmdn.pmdn015   = l_srab.price      #單價 
      #若单价为零时,重新取单价
      IF l_pmdn.pmdn015 = 0 OR cl_null(l_pmdn.pmdn015) THEN
         #等取单价的应用元件
         #carrier fill when price function ready
         #LET l_pmdn.pmdn015 = 1
      END IF
      LET l_pmdn.pmdn016   = p_pmdl.pmdl011    #稅別 
      LET l_pmdn.pmdn017   = l_pmdl.pmdl012    #稅率 
      
      #取得稅別類型
      CALL s_tax_chk(l_pmdn.pmdnsite,l_pmdl.pmdl011)
        RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011
      IF l_oodb011 = '2' AND NOT cl_null(l_pmdn.pmdn001) AND NOT cl_null(l_pmdl.pmdl024) THEN
         #依料件設定
         CALL s_tax_chktype(l_pmdn.pmdnsite,l_pmdl.pmdl004,l_pmdn.pmdn001,'2',l_pmdl.pmdl024)
              RETURNING l_success,l_pmdn.pmdn016,l_pmdn.pmdn017
         IF NOT l_success THEN
            #稅別檢查失敗，將稅別、稅率清空
            LET l_pmdn.pmdn016 = ''
            LET l_pmdn.pmdn017 = ''
         END IF                   
      END IF
      IF cl_null(l_pmdn.pmdn016) OR cl_null(l_pmdn.pmdn017) THEN
         #依正常稅率
         LET l_pmdn.pmdn016 = l_pmdl.pmdl011
         LET l_pmdn.pmdn017 = l_pmdl.pmdl012
      END IF 
      
      LET l_pmdn.pmdn019= '1'                  #子件特性
      LET l_pmdn.pmdn020   = '1'               #緊急度                       
      LET l_pmdn.pmdn021   = 'N'               #保稅                    
      LET l_pmdn.pmdn022   = 'Y'               #部分交貨                
      LET l_pmdn.pmdnunit  = g_site            #收貨據點                 
      LET l_pmdn.pmdnorga  = g_site            #付款據點                 
      LET l_pmdn.pmdn023   = p_pmdl.pmdl004    #送貨供應商              
      LET l_pmdn.pmdn024   = 'N'               #多交期                  
      LET l_pmdn.pmdn025   = l_pmdl.pmdl025    #收貨地址代碼            
      LET l_pmdn.pmdn026   = l_pmdl.pmdl026    #帳款地址代碼    
      #供應商料號
      DECLARE s_apmt500_gen_6_ins_pmdn_sel_cs1 SCROLL CURSOR FOR
       SELECT pmao004 FROM pmao_t
        WHERE pmaoent = g_enterprise 
          AND pmao001 = p_pmdl.pmdl004
          AND pmao002 = l_pmdn.pmdn001
          AND pmao003 = l_pmdn.pmdn002
          AND pmao000 = '1'      #161221-00064#5 add
        ORDER BY pmao007 DESC
        
      OPEN s_apmt500_gen_6_ins_pmdn_sel_cs1 
      FETCH FIRST s_apmt500_gen_6_ins_pmdn_sel_cs1 INTO l_pmdn.pmdn027
           
      LET l_pmdn.pmdn028   = ''                #收貨庫位
      #150820#150819-00010 by whitney add start
      IF cl_null(l_pmdn.pmdn028) THEN
         CALL s_aooi200_get_slip(p_pmdndocno) RETURNING l_success,l_ooba002
         CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-MFG-0076') RETURNING l_pmdn.pmdn028
      END IF
      #150820#150819-00010 by whitney add end
      LET l_pmdn.pmdn029   = ''                #收貨儲位                
      LET l_pmdn.pmdn030   = ''                #收貨批號                
      LET l_pmdn.pmdn031   = l_pmdl.pmdl020    #運輸方式                
      LET l_pmdn.pmdn032   = '1'               #取貨模式                
      LET l_pmdn.pmdn033   = 0                 #備品率  
      
     
      LET l_pmdn.pmdn035   = '1'               #價格核決                
      LET l_pmdn.pmdn036   = ''                #專案編號                
      LET l_pmdn.pmdn037   = ''                #WBS編號                 
      LET l_pmdn.pmdn038   = ''                #活動編號                
      LET l_pmdn.pmdn039   = ''                #費用原因
      #carrier 以下5个字段等价格应用元件      
      LET l_pmdn.pmdn040   = '1'               #取價來源    
      LET l_pmdn.pmdn041   = ''                #價格參考單號
      LET l_pmdn.pmdn042   = ''                #價格參考項次
      LET l_pmdn.pmdn043   = 0                 #取出價格    
      LET l_pmdn.pmdn044   = 0                 #價差比      
      LET l_pmdn.pmdn045   ='1'                #行狀態   

      CALL s_apmt500_get_price(l_pmdl.pmdl017,l_pmdl.pmdl004,l_pmdn.pmdn001,l_pmdn.pmdn002,l_pmdl.pmdl015,
          l_pmdn.pmdn016,l_pmdl.pmdl009,l_pmdl.pmdl010,l_pmdl.pmdl023,l_pmdn.pmdndocno,
          l_pmdl.pmdldocdt,l_pmdn.pmdn010,l_pmdn.pmdn011,l_pmdn.pmdnsite,l_pmdl.pmdl054,'2',l_pmdn.pmdn004,l_pmdn.pmdn005)
        RETURNING l_pmdn.pmdn040,l_pmdn.pmdn043,l_pmdn.pmdn041,l_pmdn.pmdn042
      
      LET l_pmdn.pmdn015 = l_pmdn.pmdn043
      
      #未稅金額/#含稅金額/#稅額
      CALL s_apmt500_get_amount(l_pmdn.pmdndocno,l_pmdn.pmdnseq,l_pmdl.pmdl015,
                                l_pmdn.pmdn011,l_pmdn.pmdn015,l_pmdn.pmdn016)    #161229-00014#1-----dujuan----l_pmdn.pmdn007 改 l_pmdn.pmdn011
           RETURNING l_pmdn.pmdn046,l_pmdn.pmdn048,l_pmdn.pmdn047

      LET l_pmdn.pmdn049   = ''                #理由碼      
      LET l_pmdn.pmdn050   = ''                #備註        
      LET l_pmdn.pmdn051   = ''                #結案理由碼  
      LET l_pmdn.pmdn900   = ''                #保留欄位str 
      LET l_pmdn.pmdn999   = ''                #保留欄位end 
      
      LET l_pmdn.pmdn052 = ''
      LET l_sql = " SELECT qcap006 FROM qcap_t ",
                 " WHERE qcapent = '",g_enterprise,"' ",
                 "  AND qcapsite = '",l_pmdn.pmdnsite,"' ",
                 "  AND qcap001 = '",l_pmdn.pmdn001,"' ",
                 "  AND qcap002 = '",l_pmdl.pmdl004,"' "
                 
      IF l_pmdn.pmdn002 IS NOT NULL THEN
         LET l_sql = l_sql ," AND qcap005 = '",l_pmdn.pmdn002,"' "
      END IF
      IF (NOT cl_null(l_pmdn.pmdn004)) AND (NOT cl_null(l_pmdn.pmdn005)) THEN
         LET l_sql = l_sql ," AND qcap003 = '",l_pmdn.pmdn004,"' AND qcap004 = '",l_pmdn.pmdn005,"' "
      END IF
      
      PREPARE get_qcap2 FROM l_sql
      EXECUTE get_qcap2 INTO l_pmdn.pmdn052  
      IF cl_null(l_pmdn.pmdn052) THEN
         #若沒有維護aqci050,再從aqci040中帶值
         SELECT imae114 INTO l_pmdn.pmdn052 FROM imae_t 
             WHERE imaeent = g_enterprise AND imaesite = l_pmdn.pmdnsite AND imae001 = l_pmdn.pmdn001
             
      END IF
      
      IF cl_null(l_pmdn.pmdn052) THEN
         LET l_pmdn.pmdn052 = 'N'
      END IF
      
      LET l_pmdn.pmdn054   = 0
      LET l_pmdn.pmdn055   = 0
      LET l_pmdn.pmdn056   = 0
      LET l_pmdn.pmdn057   = 0
      #161124-00048#9 mod-S
#      INSERT INTO pmdn_t VALUES(l_pmdn.*)
      INSERT INTO pmdn_t(pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
                         pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
                         pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
                         pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
                         pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
                         pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
                         pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
                         pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
                         pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
                         pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
                         pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
                         pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
                         pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
                         pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
                         pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
                         pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
                         pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
                         pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
                         pmdn226,pmdn227,pmdn058,pmdn228)
                  VALUES(l_pmdn.*)
      #161124-00048#9 mod-E
      IF SQLCA.sqlcode THEN
         RETURN r_success
      END IF

      CALL s_apmt500_gen_pmdq(l_pmdn.pmdndocno,l_pmdn.pmdnseq) RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF 
      
      #插入"pmdo_t:採購交期明細檔"
      CALL s_apmt500_gen_6_ins_pmdo(l_srab.*,l_pmdn.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF           
      #插入"pmdp_t:採購關聯單據明細檔"
      CALL s_apmt500_gen_6_ins_pmdp(l_srab.*,l_pmdn.*)
           RETURNING l_success
      IF NOT l_success THEN
         RETURN r_success
      END IF     

   END FOREACH
   
   #未税/含税/税额
   SELECT SUM(pmdn046),SUM(pmdn047),SUM(pmdn048) INTO l_pmdl040,l_pmdl041,l_pmdl042
     FROM pmdn_t
    WHERE pmdnent   = g_enterprise
      AND pmdndocno = p_pmdndocno
   IF cl_null(l_pmdl040) THEN LET l_pmdl040 = 0 END IF
   IF cl_null(l_pmdl041) THEN LET l_pmdl041 = 0 END IF
   IF cl_null(l_pmdl042) THEN LET l_pmdl042 = 0 END IF
   UPDATE pmdl_t SET pmdl040 = l_pmdl040, pmdl041 = l_pmdl041, pmdl042 = l_pmdl042
    WHERE pmdlent   = g_enterprise
      AND pmdldocno = p_pmdndocno
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'update pmdl_t SUM'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 从工单产生采购单 -- 产生采购交期明细单身pmdo_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_6_ins_pmdo(p_srab,p_pmdn)
#                       RETURNING r_success
# Input parameter: p_srab         工单制程信息
#                : p_pmdn         采购明细单身资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-05-04 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_6_ins_pmdo(p_srab,p_pmdn)
   DEFINE p_srab          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          srac027       LIKE srac_t.srac027,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          price         LIKE pmdn_t.pmdn015  
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE p_pmdn          RECORD LIKE pmdn_t.*
   DEFINE p_pmdn RECORD  #採購單身明細檔
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdo          RECORD LIKE pmdo_t.*
   DEFINE l_pmdo RECORD  #採購交期明細檔
          pmdoent LIKE pmdo_t.pmdoent, #企业编号
          pmdosite LIKE pmdo_t.pmdosite, #营运据点
          pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
          pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
          pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
          pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
          pmdo001 LIKE pmdo_t.pmdo001, #料件编号
          pmdo002 LIKE pmdo_t.pmdo002, #产品特征
          pmdo003 LIKE pmdo_t.pmdo003, #子件特性
          pmdo004 LIKE pmdo_t.pmdo004, #采购单位
          pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
          pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
          pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
          pmdo008 LIKE pmdo_t.pmdo008, #QPA
          pmdo009 LIKE pmdo_t.pmdo009, #交期类型
          pmdo010 LIKE pmdo_t.pmdo010, #收货时段
          pmdo011 LIKE pmdo_t.pmdo011, #出货日期
          pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
          pmdo013 LIKE pmdo_t.pmdo013, #到库日期
          pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
          pmdo015 LIKE pmdo_t.pmdo015, #已收货量
          pmdo016 LIKE pmdo_t.pmdo016, #验退量
          pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
          pmdo019 LIKE pmdo_t.pmdo019, #已入库量
          pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
          pmdo021 LIKE pmdo_t.pmdo021, #交货状态
          pmdo022 LIKE pmdo_t.pmdo022, #参考价格
          pmdo023 LIKE pmdo_t.pmdo023, #税种
          pmdo024 LIKE pmdo_t.pmdo024, #税率
          pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
          pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
          pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
          pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
          pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
          pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
          pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
          pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
          pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
          pmdo034 LIKE pmdo_t.pmdo034, #分批税额
          pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
          pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
          pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
          pmdo038 LIKE pmdo_t.pmdo038, #初始项序
          pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
          pmdo040 LIKE pmdo_t.pmdo040, #仓退量
          pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
          pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
          pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
          pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
          pmdo041 LIKE pmdo_t.pmdo041, #还料数量
          pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
          pmdo043 LIKE pmdo_t.pmdo043, #还价数量
          pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_rate          LIKE inaj_t.inaj014
   
   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF
   
   INITIALIZE l_pmdo.* TO NULL
   LET l_pmdo.pmdoent   = p_pmdn.pmdnent               #企業編號    
   LET l_pmdo.pmdosite  = p_pmdn.pmdnsite              #營運據點    
   LET l_pmdo.pmdodocno = p_pmdn.pmdndocno             #採購單號    
   LET l_pmdo.pmdoseq   = p_pmdn.pmdnseq               #採購項次 
   LET l_pmdo.pmdoseq1 = 1                             #項序 
   LET l_pmdo.pmdoseq2  = 1                            #分批序   
   LET l_pmdo.pmdo001   = p_pmdn.pmdn001               #料件編號    
   LET l_pmdo.pmdo002   = p_pmdn.pmdn002               #產品特徵    
   LET l_pmdo.pmdo003   = p_pmdn.pmdn019               #子件特性    
   LET l_pmdo.pmdo004   = p_pmdn.pmdn006               #採購單位  
   LET l_pmdo.pmdo005   = p_pmdn.pmdn007               #採購數量               
   LET l_pmdo.pmdo006   = l_pmdo.pmdo005               #分批採購數量
   LET l_pmdo.pmdo007   = l_pmdo.pmdo005               #折合主件數量
   LET l_pmdo.pmdo008   = 1                            #QPA      
   LET l_pmdo.pmdo009   = '1'                          #交期類型    
   LET l_pmdo.pmdo010   = ''                           #收貨時段    
   LET l_pmdo.pmdo011   = p_pmdn.pmdn012               #出貨日期    
   LET l_pmdo.pmdo012   = p_pmdn.pmdn013               #到廠日期    
   LET l_pmdo.pmdo013   = p_pmdn.pmdn014               #到庫日期    
   LET l_pmdo.pmdo014   = 'N'                          #MRP交期凍結 
   LET l_pmdo.pmdo015   = 0                            #已收貨量    
   LET l_pmdo.pmdo016   = 0                            #驗退量      
   LET l_pmdo.pmdo017   = 0                            #倉退換貨量     
   LET l_pmdo.pmdo019   = 0                            #已入庫量    
   LET l_pmdo.pmdo020   = 0                            #VMI請款量   
   LET l_pmdo.pmdo021   = '2'                          #交貨狀態    
   LET l_pmdo.pmdo022   = p_pmdn.pmdn015               #參考價格 
   LET l_pmdo.pmdo023   = p_pmdn.pmdn016               #稅別
   LET l_pmdo.pmdo024   = p_pmdn.pmdn017               #稅率
   LET l_pmdo.pmdo025   = ''                           #電子採購單號
   LET l_pmdo.pmdo026   = g_user                       #最近修改人員
   LET l_pmdo.pmdo027   = g_dept                       #最近修改時間
   #分批參考單位
   SELECT imaf015 INTO l_pmdo.pmdo028 FROM imaf_t
    WHERE imafent  = g_enterprise
      AND imafsite = g_site
      AND imaf001  = l_pmdo.pmdo001
      
   #分批參考數量 
   #若没有参考单位时,参考数量DEFAULT NULL
   IF cl_null(l_pmdo.pmdo028) THEN
      LET l_pmdo.pmdo029 = NULL
   ELSE
      #CALL s_aimi190_get_convert(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028)
      #     RETURNING l_success,l_rate
      #IF NOT l_success THEN
      #   LET l_rate = 1
      #END IF
      #LET l_pmdo.pmdo029 = l_pmdo.pmdo006 * l_rate
      CALL s_aooi250_convert_qty(l_pmdo.pmdo001,l_pmdo.pmdo004,l_pmdo.pmdo028,l_pmdo.pmdo006)
              RETURNING l_success,l_pmdo.pmdo029
   END IF

   LET l_pmdo.pmdo030   = l_pmdo.pmdo004               #分批計價單位
   LET l_pmdo.pmdo031   = l_pmdo.pmdo006               #分批計價數量
   
   LET l_pmdo.pmdo032   = p_pmdn.pmdn046               #分批未稅金額
   LET l_pmdo.pmdo033   = p_pmdn.pmdn047               #分批含稅金額
   LET l_pmdo.pmdo034   = p_pmdn.pmdn048               #分批稅額    
   LET l_pmdo.pmdo900   = p_pmdn.pmdn900               #保留欄位str 
   LET l_pmdo.pmdo999   = p_pmdn.pmdn999               #保留欄位end 
   LET l_pmdo.pmdo040 = 0                              #170302-00017#1
   LET l_pmdo.pmdo041 = 0
   LET l_pmdo.pmdo042 = 0
   LET l_pmdo.pmdo043 = 0
   LET l_pmdo.pmdo044 = 0
       
   #161124-00048#9 mod-S
#   INSERT INTO pmdo_t VALUES(l_pmdo.*)
   INSERT INTO pmdo_t(pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,
                      pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,
                      pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
                      pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
                      pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,
                      pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
                      pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
                      pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,
                      pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,
                      pmdo200,pmdo201,pmdo900,pmdo999,pmdo041,
                      pmdo042,pmdo043,pmdo044)
               VALUES(l_pmdo.*)
   #161124-00048#9 mod-E
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert pmdo_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   

   
   LET r_success = TRUE
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 从重复性工单产生采购单 -- 采购关联单据明细档 pmdp_t
# Memo...........:
# Usage..........: CALL s_apmt500_gen_6_ins_pmdp(p_srab,p_pmdn)
#                       RETURNING r_success
# Input parameter: p_srab         重复性工单制程信息
#                : p_pmdn         采购明细单身资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-05-04 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_gen_6_ins_pmdp(p_srab,p_pmdn)
   DEFINE p_srab          RECORD
                          srab000       LIKE srab_t.srab000,
                          srab001       LIKE srab_t.srab001,
                          srab004       LIKE srab_t.srab004,   
                          srab005       LIKE srab_t.srab005, 
                          srab006       LIKE srab_t.srab006, 
                          srac008       LIKE srac_t.srac008, 
                          srac009       LIKE srac_t.srac009,
                          srab009       LIKE srab_t.srab009,
                          srac027       LIKE srac_t.srac027,
                          carry_qty     LIKE sfaa_t.sfaa012,
                          price         LIKE pmdn_t.pmdn015  
                          END RECORD
   #161124-00048#9 mod-S
#   DEFINE p_pmdn          RECORD LIKE pmdn_t.*
   DEFINE p_pmdn RECORD  #採購單身明細檔
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   #161124-00048#9 mod-S
#   DEFINE l_pmdp          RECORD LIKE pmdp_t.*
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
   
   LET r_success = FALSE

   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      RETURN r_success
   END IF
   
   INITIALIZE l_pmdp.* TO NULL

   LET l_pmdp.pmdpent   = p_pmdn.pmdnent                #企業編號      
   LET l_pmdp.pmdpsite  = p_pmdn.pmdnsite               #營運據點      
   LET l_pmdp.pmdpdocno = p_pmdn.pmdndocno              #採購單號      
   LET l_pmdp.pmdpseq   = p_pmdn.pmdnseq                #採購項次      
   LET l_pmdp.pmdpseq1  = 1                             #項序          
   LET l_pmdp.pmdp001   = p_pmdn.pmdn001                #料件編號      
   LET l_pmdp.pmdp002   = p_pmdn.pmdn002                #產品特徵      
   LET l_pmdp.pmdp003   = ''                            #來源單號      
   LET l_pmdp.pmdp004   = 0                             #來源項次      
   LET l_pmdp.pmdp005   = 0                             #來源項序      
   LET l_pmdp.pmdp006   = 0                             #來源分批序    
   LET l_pmdp.pmdp007   = p_pmdn.pmdn001                #來源料號      
   LET l_pmdp.pmdp008   = p_pmdn.pmdn002                #來源產品特徵  
   LET l_pmdp.pmdp009   = p_srab.srac008                #來源作業編號  
   LET l_pmdp.pmdp010   = p_srab.srac009                #來源製程序    
   LET l_pmdp.pmdp011   = p_srab.srab005                #來源BOM特性   
   LET l_pmdp.pmdp012   = p_srab.srab001                #來源生產控制組
   LET l_pmdp.pmdp021   = 1                             #沖銷順序      
   LET l_pmdp.pmdp022   = p_srab.srac027                #需求單位      
   LET l_pmdp.pmdp023   = p_srab.carry_qty              #需求數量      
   LET l_pmdp.pmdp024   = p_srab.carry_qty              #折合採購量    
   LET l_pmdp.pmdp025   = 0                             #已收貨量      
   LET l_pmdp.pmdp026   = 0                             #已入庫量      
   LET l_pmdp.pmdp900   = p_pmdn.pmdn900                #保留欄位str   
   LET l_pmdp.pmdp999   = p_pmdn.pmdn999                #保留欄位end   
   
   #161124-00048#9 mod-S
#   INSERT INTO pmdp_t VALUES(l_pmdp.*)
   INSERT INTO pmdp_t(pmdpent,pmdpsite,pmdpdocno,pmdpseq,pmdpseq1,
                      pmdp001,pmdp002,pmdp003,pmdp004,pmdp005,
                      pmdp006,pmdp007,pmdp008,pmdp009,pmdp010,
                      pmdp011,pmdp012,pmdp021,pmdp022,pmdp023,
                      pmdp024,pmdp025,pmdp026,pmdp900,pmdp999)
               VALUES(l_pmdp.*)
   #161124-00048#9 mod-E
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'insert pmdp_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#整合用的「確認」功能應用元件
PUBLIC FUNCTION s_apmt500_ws_confirm(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE r_success       LIKE type_t.num5

   LET r_success = TRUE
   
   #確認前檢核段
   CALL s_apmt500_conf_chk(p_pmdldocno) RETURNING r_success
   IF r_success THEN
       #確認交易處理段
       CALL s_apmt500_conf_upd(p_pmdldocno) RETURNING r_success
   END IF
   RETURN r_success

END FUNCTION

#根據採購單產生訂單
PUBLIC FUNCTION s_apmt500_gen_order(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE r_success       LIKE type_t.num5
DEFINE p_sfaa018       LIKE sfaa_t.sfaa018  #目的據點
DEFINE l_xmdadocno     LIKE xmda_t.xmdadocno
DEFINE l_success       LIKE type_t.num5

   LET r_success = TRUE
   
   #插入訂單單頭
   #170303-00015#1 add---start---
   SELECT sfaa018 INTO p_sfaa018 FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaadocno IN (SELECT pmdl008 FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = p_pmdldocno)
   #170303-00015#1 add---end---
   CALL s_apmt500_ins_xmda(p_pmdldocno,p_sfaa018) RETURNING l_xmdadocno,l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #訂單多帳期預收款檔
   IF NOT s_apmt500_ins_xmdb(p_pmdldocno,l_xmdadocno,p_sfaa018) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #訂單明細單身
   IF NOT s_apmt500_ins_xmdc(p_pmdldocno,l_xmdadocno,p_sfaa018) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #訂單多交期明细
   IF NOT s_apmt500_ins_xmdd(p_pmdldocno,l_xmdadocno,p_sfaa018) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #訂單多交期匯總檔
   IF NOT s_apmt500_ins_xmdf(p_pmdldocno,l_xmdadocno,p_sfaa018) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #產生的訂單自動確認
   CALL s_axmt500_conf_chk(l_xmdadocno) RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   ELSE
      CALL s_axmt500_conf_upd(l_xmdadocno) RETURNING l_success
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
   
END FUNCTION

#根據採購購，新增訂單部分單頭
PUBLIC FUNCTION s_apmt500_ins_xmda(p_pmdldocno,p_sfaa018)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE p_sfaa018       LIKE sfaa_t.sfaa018  #目的據點
#161124-00048#9 mod-S
#DEFINE l_xmda          RECORD LIKE xmda_t.*
#DEFINE l_pmdl          RECORD LIKE pmdl_t.*
DEFINE l_xmda RECORD  #訂單單頭檔
       xmdaent LIKE xmda_t.xmdaent, #企业编号
       xmdasite LIKE xmda_t.xmdasite, #营运据点
       xmdadocno LIKE xmda_t.xmdadocno, #订单单号
       xmdadocdt LIKE xmda_t.xmdadocdt, #订单日期
       xmda001 LIKE xmda_t.xmda001, #版次
       xmda002 LIKE xmda_t.xmda002, #业务人员
       xmda003 LIKE xmda_t.xmda003, #业务部门
       xmda004 LIKE xmda_t.xmda004, #客户编号
       xmda005 LIKE xmda_t.xmda005, #订单性质
       xmda006 LIKE xmda_t.xmda006, #多角性质
       xmda007 LIKE xmda_t.xmda007, #数据源
       xmda008 LIKE xmda_t.xmda008, #来源单号
       xmda009 LIKE xmda_t.xmda009, #收款条件
       xmda010 LIKE xmda_t.xmda010, #交易条件
       xmda011 LIKE xmda_t.xmda011, #税种
       xmda012 LIKE xmda_t.xmda012, #税率
       xmda013 LIKE xmda_t.xmda013, #单价含税否
       xmda015 LIKE xmda_t.xmda015, #币种
       xmda016 LIKE xmda_t.xmda016, #汇率
       xmda017 LIKE xmda_t.xmda017, #取价方式
       xmda018 LIKE xmda_t.xmda018, #收款优惠条件
       xmda019 LIKE xmda_t.xmda019, #纳入APS计算
       xmda020 LIKE xmda_t.xmda020, #运送方式
       xmda021 LIKE xmda_t.xmda021, #账款客户
       xmda022 LIKE xmda_t.xmda022, #收货客户
       xmda023 LIKE xmda_t.xmda023, #销售渠道
       xmda024 LIKE xmda_t.xmda024, #销售分类二
       xmda025 LIKE xmda_t.xmda025, #出货地址
       xmda026 LIKE xmda_t.xmda026, #账款地址
       xmda027 LIKE xmda_t.xmda027, #客户连络人
       xmda028 LIKE xmda_t.xmda028, #一次性交易对象识别码
       xmda029 LIKE xmda_t.xmda029, #出货部门
       xmda030 LIKE xmda_t.xmda030, #多角贸易已抛转
       xmda031 LIKE xmda_t.xmda031, #多角序号
       xmda032 LIKE xmda_t.xmda032, #留置原因
       xmda033 LIKE xmda_t.xmda033, #客户订购单号
       xmda034 LIKE xmda_t.xmda034, #最终客户
       xmda035 LIKE xmda_t.xmda035, #发票类型
       xmda036 LIKE xmda_t.xmda036, #送货供应商
       xmda037 LIKE xmda_t.xmda037, #起运点
       xmda038 LIKE xmda_t.xmda038, #目的地
       xmda039 LIKE xmda_t.xmda039, #预收款发票开立方式
       xmda041 LIKE xmda_t.xmda041, #订单总税前金额
       xmda042 LIKE xmda_t.xmda042, #订单总含税金额
       xmda043 LIKE xmda_t.xmda043, #订单总税额
       xmda044 LIKE xmda_t.xmda044, #唛头编号
       xmda045 LIKE xmda_t.xmda045, #物流结案
       xmda046 LIKE xmda_t.xmda046, #账流结案
       xmda047 LIKE xmda_t.xmda047, #金流结案
       xmda048 LIKE xmda_t.xmda048, #内外销
       xmda049 LIKE xmda_t.xmda049, #汇率计算基准
       xmda050 LIKE xmda_t.xmda050, #多角流程编号
       xmda051 LIKE xmda_t.xmda051, #多角最终站
       xmda071 LIKE xmda_t.xmda071, #备注
       xmdaownid LIKE xmda_t.xmdaownid, #资料所有者
       xmdaowndp LIKE xmda_t.xmdaowndp, #资料所有部门
       xmdacrtid LIKE xmda_t.xmdacrtid, #资料录入者
       xmdacrtdp LIKE xmda_t.xmdacrtdp, #资料录入部门
       xmdacrtdt LIKE xmda_t.xmdacrtdt, #资料创建日
       xmdamodid LIKE xmda_t.xmdamodid, #资料更改者
       xmdamoddt LIKE xmda_t.xmdamoddt, #最近更改日
       xmdacnfid LIKE xmda_t.xmdacnfid, #资料审核者
       xmdacnfdt LIKE xmda_t.xmdacnfdt, #数据审核日
       xmdapstid LIKE xmda_t.xmdapstid, #资料过账者
       xmdapstdt LIKE xmda_t.xmdapstdt, #资料过账日
       xmdastus LIKE xmda_t.xmdastus, #状态码
       xmda200 LIKE xmda_t.xmda200, #调货经销商编号
       xmda201 LIKE xmda_t.xmda201, #代送商编号
       xmda202 LIKE xmda_t.xmda202, #销售办事处
       xmda203 LIKE xmda_t.xmda203, #发票客户
       xmda204 LIKE xmda_t.xmda204, #促销方案编号
       xmda205 LIKE xmda_t.xmda205, #整单折扣
       xmda206 LIKE xmda_t.xmda206, #送货站点编号
       xmda207 LIKE xmda_t.xmda207, #运输路线编号
       xmda208 LIKE xmda_t.xmda208, #地区编号
       xmda209 LIKE xmda_t.xmda209, #县市编号
       xmda210 LIKE xmda_t.xmda210, #省区编号
       xmda211 LIKE xmda_t.xmda211, #区域编号
       xmda212 LIKE xmda_t.xmda212, #本币含税总金额
       xmda213 LIKE xmda_t.xmda213, #收款完成否
       xmdaunit LIKE xmda_t.xmdaunit  #发货组织
END RECORD
DEFINE l_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
#161124-00048#9 mod-E
DEFINE l_success       LIKE type_t.num5
DEFINE r_success       LIKE type_t.num5
DEFINE l_n             LIKE type_t.num5
DEFINE l_ooef016       LIKE ooef_t.ooef016
DEFINE l_controlno     LIKE ooha_t.ooha001
DEFINE l_pmaa027       LIKE pmaa_t.pmaa027
DEFINE l_scc40         LIKE type_t.chr1
DEFINE l_icaf014       LIKE icaf_t.icaf014
DEFINE l_icaf024       LIKE icaf_t.icaf024
DEFINE l_xmdacrtdt     DATETIME YEAR TO SECOND

   LET r_success = TRUE
   
   INITIALIZE l_xmda.* TO NULL 
   
   LET l_xmda.xmdaent = g_enterprise
   LET l_xmda.xmdasite = p_sfaa018 
   LET l_xmda.xmdaownid = g_user
   LET l_xmda.xmdaowndp = g_dept
   LET l_xmda.xmdacrtid = g_user
   LET l_xmda.xmdacrtdp = g_dept 
   #LET l_xmda.xmdacrtdt = cl_get_current()
   LET l_xmdacrtdt = cl_get_current()
   LET l_xmda.xmdamodid = ""
   LET l_xmda.xmdamoddt = ""
   LET l_xmda.xmdastus = "N"

   #訂單單別:用供應商編號，抓取內部直接交易設定作業的預設訂單單別
   LET l_icaf014 = ''  #預設訂單單別
   LET l_icaf024 = ''  #預設收款條件
   SELECT icaf014,icaf024 INTO l_icaf014,l_icaf024  
      FROM icaf_t WHERE icafent = g_enterprise AND icaf001 = g_site AND icaf002 = p_sfaa018
   IF NOT cl_null(l_icaf014) THEN
      CALL s_aooi200_gen_docno(p_sfaa018,l_icaf014,g_today,g_prog) RETURNING l_success,l_xmda.xmdadocno 
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_xmda.xmdadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
        
         LET r_success = FALSE
         RETURN '',r_success
      END IF 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00544'
      LET g_errparam.extend = l_xmda.xmdadocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN '',r_success
   END IF
   
   INITIALIZE l_pmdl.* TO NULL 
   #161124-00048#9 mod-S
#   SELECT * INTO l_pmdl.* FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   SELECT pmdlent,pmdlsite,pmdlunit,pmdldocno,pmdldocdt,
          pmdl001,pmdl002,pmdl003,pmdl004,pmdl005,
          pmdl006,pmdl007,pmdl008,pmdl009,pmdl010,
          pmdl011,pmdl012,pmdl013,pmdl015,pmdl016,
          pmdl017,pmdl018,pmdl019,pmdl020,pmdl021,
          pmdl022,pmdl023,pmdl024,pmdl025,pmdl026,
          pmdl027,pmdl028,pmdl029,pmdl030,pmdl031,
          pmdl032,pmdl033,pmdl040,pmdl041,pmdl042,
          pmdl043,pmdl044,pmdl046,pmdl047,pmdl048,
          pmdl049,pmdl050,pmdl051,pmdl052,pmdl053,
          pmdl054,pmdl055,pmdl200,pmdl201,pmdl202,
          pmdl203,pmdl204,pmdl900,pmdl999,pmdlownid,
          pmdlowndp,pmdlcrtid,pmdlcrtdp,pmdlcrtdt,pmdlmodid,
          pmdlmoddt,pmdlcnfid,pmdlcnfdt,pmdlpstid,pmdlpstdt,
          pmdlstus,pmdl205,pmdl206,pmdl207,pmdl208
     INTO l_pmdl.* 
     FROM pmdl_t 
    WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   #161124-00048#9 mod-E
      
   LET l_xmda.xmdadocdt = l_pmdl.pmdldocdt  #訂單日期=採購日期
   
   #客戶編號=抓取採購單的據點資料內的據點對應客戶/廠商編號(ooef024)
   SELECT ooef024 INTO l_xmda.xmda004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_sfaa018
   
   LET l_xmda.xmda001 = "0"
   LET l_xmda.xmda002 = g_user
   LET l_xmda.xmda003 = g_dept
   LET l_xmda.xmda005 = "1"             #訂單性質=1.一般訂單
   LET l_xmda.xmda006 = "6"             #多角性質=6.協作訂單
   LET l_xmda.xmda007 = "7"             #資料來源=7.協作轉入
   LET l_xmda.xmda008 = p_pmdldocno     #來源單號=採購單號
   LET l_xmda.xmda009 = l_icaf024       #收款條件=用供應商編號，抓取內部直接交易設定作業的收款條件
   LET l_xmda.xmda010 = l_pmdl.pmdl010  #交易條件=採購單的交易條件
   LET l_xmda.xmda011 = l_pmdl.pmdl011  #稅別=採購單的稅別
   LET l_xmda.xmda012 = l_pmdl.pmdl012
   LET l_xmda.xmda013 = l_pmdl.pmdl013
   ##取稅率、單價含稅否
   #IF NOT cl_null(l_xmda.xmda011) THEN
   #   CALL s_tax_chk(l_xmda.xmdasite,l_xmda.xmda011)
   #     RETURNING l_success,'',l_xmda.xmda013,l_xmda.xmda012,''
   #END IF
   
   LET l_xmda.xmda033 = p_pmdldocno     #客戶訂購單號=採購單號
   LET l_xmda.xmda015 = l_pmdl.pmdl015  #幣別=採購單的幣別
   LET l_xmda.xmda016 = l_pmdl.pmdl016
   ##取匯率
   #IF NOT cl_null(l_xmda.xmda015) THEN
   #   LET l_ooef016 = ''
   #   SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_xmda.xmdasite
   #   #根據內外購獲取當前營運據點參數設置的汇率类型
   #   LET l_scc40 = ''
   #   IF l_xmda.xmda048 = '1' THEN   #內銷  
   #      LET l_scc40 = cl_get_para(g_enterprise,l_xmda.xmdasite,'S-BAS-0010')
   #   END IF
   #   IF l_xmda.xmda048 = '2' THEN   #外銷
   #      LET l_scc40 = cl_get_para(g_enterprise,l_xmda.xmdasite,'S-BAS-0011')
   #   END IF
   #   CALL s_aooi160_get_exrate('1',l_xmda.xmdasite,g_today,l_xmda.xmda015,l_ooef016,0,l_scc40) RETURNING l_xmda.xmda016
   #END IF  
   
   LET l_xmda.xmda013 = "N"
   LET l_xmda.xmda019 = "Y"
   LET l_xmda.xmda030 = "N"
   LET l_xmda.xmda045 = "N"
   LET l_xmda.xmda046 = "N"
   LET l_xmda.xmda047 = "N"
   LET l_xmda.xmda041 = "0"
   LET l_xmda.xmda042 = "0"
   LET l_xmda.xmda043 = "0"
   LET l_xmda.xmda039 = l_pmdl.pmdl046
   LET l_xmda.xmda048 = l_pmdl.pmdl054
   LET l_xmda.xmda049 = l_pmdl.pmdl055
   LET l_xmda.xmda041 = l_pmdl.pmdl040
   LET l_xmda.xmda042 = l_pmdl.pmdl041
   LET l_xmda.xmda043 = l_pmdl.pmdl042

   #先判斷這個客戶是否有設多個當前銷售控制組範圍內的客戶預設條件，則開窗，讓user選擇帶哪一個控制組的資料
   LET l_controlno = ''
   CALL s_control_get_group('2',l_xmda.xmda002,l_xmda.xmda003) RETURNING l_success,l_controlno
   
   IF NOT cl_null(l_controlno) THEN
      #判斷客戶是否有設置訂單控制組客戶預設條件(axmi110)，若有則抓取相關的預設條件default到訂購單上
      SELECT COUNT(*) INTO l_n FROM xmae_t 
       WHERE xmaeent = g_enterprise AND xmae001 = l_xmda.xmda004 
         AND xmae002 = l_controlno 
      IF l_n > 0 THEN
         SELECT xmae021,
                xmae011,xmae008,xmae009,xmae022,xmae012,
                xmae013,xmae006
           INTO l_xmda.xmda017,
                l_xmda.xmda020,l_xmda.xmda023,l_xmda.xmda024,l_xmda.xmda035,l_xmda.xmda037,
                l_xmda.xmda038,l_xmda.xmda018
           FROM xmae_t 
          WHERE xmaeent = g_enterprise AND xmae001 = l_xmda.xmda004 
            AND xmae002 = l_controlno 
      END IF
   END IF
   
   #若沒有設置銷售控制組客戶預設條件資料則改抓客戶據點預設條件(axmm202)資料  
   IF cl_null(l_controlno) OR l_n = 0 THEN
      SELECT pmab104,pmab090,pmab091,pmab092,pmab088,
             pmab089,pmab087,pmab106,pmab107,pmab108     
        INTO l_xmda.xmda017,l_xmda.xmda020,l_xmda.xmda037,l_xmda.xmda038,l_xmda.xmda023,
             l_xmda.xmda024,l_xmda.xmda018,l_xmda.xmda035,l_xmda.xmda048,l_xmda.xmda039        
        FROM pmab_t WHERE pmabent = g_enterprise AND pmabsite = l_xmda.xmdasite AND pmab001 = l_xmda.xmda004         
   END IF
   
   #收款客戶
   LET l_xmda.xmda021 = ''
   SELECT pmac002 INTO l_xmda.xmda021 FROM pmac_t 
    WHERE pmacent = g_enterprise AND pmac001 = l_xmda.xmda004 
      AND pmac003 = '1' AND pmacstus = 'Y' AND pmac004 = 'Y'
   IF cl_null(l_xmda.xmda021) THEN
      SELECT pmac002 INTO l_xmda.xmda021 FROM pmac_t 
       WHERE pmacent = g_enterprise AND pmac001 = l_xmda.xmda004 
         AND pmac003 = '1' AND pmacstus = 'Y' AND rownum = 1
      IF cl_null(l_xmda.xmda021) THEN
         LET l_xmda.xmda021 = l_xmda.xmda004
      END IF
   END IF

   #收款地址
   LET l_pmaa027 = ''
   CALL s_axmt500_get_pmaa027(l_xmda.xmda021) RETURNING l_pmaa027

   SELECT oofb019 INTO l_xmda.xmda026 FROM oofb_t
    WHERE oofb002 = l_pmaa027  AND oofb008 = '2' 
      AND oofbstus = 'Y' AND oofb010 = 'Y' AND rownum = 1 
      AND oofbent=g_enterprise #170217-00049#2   2017/02/28  By 08734 add
         
   IF cl_null(l_xmda.xmda026) THEN
      SELECT oofb019 INTO l_xmda.xmda026 FROM oofb_t
       WHERE oofb002 = l_xmda.xmda021 AND oofb008 = '2' 
         AND oofbstus = 'Y' AND rownum = 1
         AND oofbent=g_enterprise  #170217-00049#2   2017/02/28  By 08734 add            
   END IF
     
   #收貨客戶
   SELECT pmac002 INTO l_xmda.xmda022 FROM pmac_t 
    WHERE pmacent = g_enterprise AND pmac001 = l_xmda.xmda004 
      AND pmac003 = '2' AND pmacstus = 'Y' AND pmac004 = 'Y'
   IF cl_null(l_xmda.xmda022) THEN
      SELECT pmac002 INTO l_xmda.xmda022 FROM pmac_t 
       WHERE pmacent = g_enterprise AND pmac001 = l_xmda.xmda004 
         AND pmac003 = '2' AND pmacstus = 'Y' AND rownum = 1
      IF cl_null(l_xmda.xmda022) THEN
         LET l_xmda.xmda022 = l_xmda.xmda004
      END IF
   END IF
   
   #出貨地址
   LET l_pmaa027 = ''
   CALL s_axmt500_get_pmaa027(l_xmda.xmda022) RETURNING l_pmaa027
   SELECT oofb019 INTO l_xmda.xmda025 FROM oofb_t
    WHERE oofb002 = l_pmaa027 AND oofb008 = '2' 
      AND oofbstus = 'Y' AND oofb010 = 'Y' AND rownum = 1
      AND oofbent=g_enterprise  #170217-00049#2   2017/02/28  By 08734 add 
       
   IF cl_null(l_xmda.xmda025) THEN
      SELECT oofb019 INTO l_xmda.xmda025 FROM oofb_t
       WHERE oofb002 = l_pmaa027 AND oofb008 = '2' 
         AND oofbstus = 'Y' AND rownum = 1 
         AND oofbent=g_enterprise #170217-00049#2   2017/02/28  By 08734 add
      
   END IF 

   #抓取交易對象聯絡人明細檔的聯絡對像識別碼顯示在訂單單上的[C:客戶連絡人]，
   #若有設置多個聯絡人時，則取有勾選主要聯絡人的那一個
   LET l_xmda.xmda027 = ''
   SELECT pmaj002 INTO l_xmda.xmda027 FROM pmaj_t 
    WHERE pmajent = g_enterprise AND pmaj001 = l_xmda.xmda004 
      AND pmajstus = 'Y' AND pmaj004 = 'Y'
   IF cl_null(l_xmda.xmda022) THEN
      SELECT pmaj002 INTO l_xmda.xmda027 FROM pmaj_t 
       WHERE pmajent = g_enterprise AND pmaj001 = l_xmda.xmda004 
         AND pmajstus = 'Y' AND pmaj004 = 'Y' AND rownum = 1  
   END IF
   
   INSERT INTO xmda_t (xmdaent,xmdasite,xmdadocno,xmda001,xmdadocdt,xmda004,xmda002,xmda003, 
       xmdastus,xmda005,xmda006,xmda007,xmda008,xmda033,xmda027,xmda009,xmda010,xmda011, 
       xmda012,xmda013,xmda035,xmda015,xmda016,xmda017,xmda018,xmda019,xmda023,xmda032,xmda071, 
       xmda050,xmda021,xmda022,xmda034,xmda024,xmda048,xmda049,xmda044,xmda030,xmda031,xmda045, 
       xmda046,xmda047,xmda028,xmda041,xmda042,xmda043,xmda025,xmda026,xmda020,xmda037,xmda038, 
       xmda036,xmda039,xmdaownid,xmdaowndp,xmdacrtid,xmdacrtdp,xmdacrtdt,xmdacnfid,xmdacnfdt) 

   VALUES (l_xmda.xmdaent,l_xmda.xmdasite,l_xmda.xmdadocno,l_xmda.xmda001,l_xmda.xmdadocdt, 
       l_xmda.xmda004,l_xmda.xmda002,l_xmda.xmda003,l_xmda.xmdastus,l_xmda.xmda005, 
       l_xmda.xmda006,l_xmda.xmda007,l_xmda.xmda008,l_xmda.xmda033,l_xmda.xmda027, 
       l_xmda.xmda009,l_xmda.xmda010,l_xmda.xmda011,l_xmda.xmda012,l_xmda.xmda013, 
       l_xmda.xmda035,l_xmda.xmda015,l_xmda.xmda016,l_xmda.xmda017,l_xmda.xmda018, 
       l_xmda.xmda019,l_xmda.xmda023,l_xmda.xmda032,l_xmda.xmda071,l_xmda.xmda050, 
       l_xmda.xmda021,l_xmda.xmda022,l_xmda.xmda034,l_xmda.xmda024,l_xmda.xmda048, 
       l_xmda.xmda049,l_xmda.xmda044,l_xmda.xmda030,l_xmda.xmda031,l_xmda.xmda045, 
       l_xmda.xmda046,l_xmda.xmda047,l_xmda.xmda028,l_xmda.xmda041,l_xmda.xmda042, 
       l_xmda.xmda043,l_xmda.xmda025,l_xmda.xmda026,l_xmda.xmda020,l_xmda.xmda037, 
       l_xmda.xmda038,l_xmda.xmda036,l_xmda.xmda039,l_xmda.xmdaownid,l_xmda.xmdaowndp, 
       l_xmda.xmdacrtid,l_xmda.xmdacrtdp,l_xmdacrtdt,l_xmda.xmdacnfid,l_xmda.xmdacnfdt)  

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend ="xmda_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET r_success = FALSE
      RETURN '',r_success
   END IF   
       
   RETURN l_xmda.xmdadocno,r_success
   
END FUNCTION

#寫入訂單明細單身
PUBLIC FUNCTION s_apmt500_ins_xmdc(p_pmdldocno,p_xmdadocno,p_sfaa018)
DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
DEFINE p_xmdadocno LIKE xmda_t.xmdadocno
DEFINE p_sfaa018   LIKE sfaa_t.sfaa018
#161124-00048#9 mod-S
#DEFINE l_pmdn      RECORD LIKE pmdn_t.*
#DEFINE l_xmdc      RECORD LIKE xmdc_t.*
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_xmdc RECORD  #訂單單身明細檔
       xmdcent LIKE xmdc_t.xmdcent, #企业编号
       xmdcsite LIKE xmdc_t.xmdcsite, #营运据点
       xmdcdocno LIKE xmdc_t.xmdcdocno, #订单单号
       xmdcseq LIKE xmdc_t.xmdcseq, #项次
       xmdc001 LIKE xmdc_t.xmdc001, #料件编号
       xmdc002 LIKE xmdc_t.xmdc002, #产品特征
       xmdc003 LIKE xmdc_t.xmdc003, #包装容器
       xmdc004 LIKE xmdc_t.xmdc004, #作业编号
       xmdc005 LIKE xmdc_t.xmdc005, #工艺序
       xmdc006 LIKE xmdc_t.xmdc006, #销售单位
       xmdc007 LIKE xmdc_t.xmdc007, #销售数量
       xmdc008 LIKE xmdc_t.xmdc008, #参考单位
       xmdc009 LIKE xmdc_t.xmdc009, #参考数量
       xmdc010 LIKE xmdc_t.xmdc010, #计价单位
       xmdc011 LIKE xmdc_t.xmdc011, #计价数量
       xmdc012 LIKE xmdc_t.xmdc012, #约定交货日
       xmdc013 LIKE xmdc_t.xmdc013, #预定签收日
       xmdc015 LIKE xmdc_t.xmdc015, #单价
       xmdc016 LIKE xmdc_t.xmdc016, #税种
       xmdc017 LIKE xmdc_t.xmdc017, #税率
       xmdc019 LIKE xmdc_t.xmdc019, #子件特性
       xmdc020 LIKE xmdc_t.xmdc020, #急料
       xmdc021 LIKE xmdc_t.xmdc021, #保税
       xmdc022 LIKE xmdc_t.xmdc022, #部分交货
       xmdcunit LIKE xmdc_t.xmdcunit, #出货据点
       xmdcorga LIKE xmdc_t.xmdcorga, #收款据点
       xmdc023 LIKE xmdc_t.xmdc023, #收货客户
       xmdc024 LIKE xmdc_t.xmdc024, #多交期
       xmdc025 LIKE xmdc_t.xmdc025, #收货地址编号
       xmdc026 LIKE xmdc_t.xmdc026, #账款地址编号
       xmdc027 LIKE xmdc_t.xmdc027, #客户料号
       xmdc028 LIKE xmdc_t.xmdc028, #限定库位
       xmdc029 LIKE xmdc_t.xmdc029, #限定储位
       xmdc030 LIKE xmdc_t.xmdc030, #限定批号
       xmdc031 LIKE xmdc_t.xmdc031, #运输方式
       xmdc032 LIKE xmdc_t.xmdc032, #取货模式
       xmdc033 LIKE xmdc_t.xmdc033, #备品率
       xmdc034 LIKE xmdc_t.xmdc034, #可超交率
       xmdc035 LIKE xmdc_t.xmdc035, #价格核决
       xmdc036 LIKE xmdc_t.xmdc036, #项目编号
       xmdc037 LIKE xmdc_t.xmdc037, #WBS编号
       xmdc038 LIKE xmdc_t.xmdc038, #活动编号
       xmdc039 LIKE xmdc_t.xmdc039, #费用原因
       xmdc040 LIKE xmdc_t.xmdc040, #取价来源
       xmdc041 LIKE xmdc_t.xmdc041, #价格参考单号
       xmdc042 LIKE xmdc_t.xmdc042, #价格参考项次
       xmdc043 LIKE xmdc_t.xmdc043, #取出价格
       xmdc044 LIKE xmdc_t.xmdc044, #价差比
       xmdc045 LIKE xmdc_t.xmdc045, #状态码
       xmdc046 LIKE xmdc_t.xmdc046, #税前金额
       xmdc047 LIKE xmdc_t.xmdc047, #含税金额
       xmdc048 LIKE xmdc_t.xmdc048, #税额
       xmdc049 LIKE xmdc_t.xmdc049, #理由码
       xmdc050 LIKE xmdc_t.xmdc050, #备注
       xmdc051 LIKE xmdc_t.xmdc051, #客户订单项次
       xmdc052 LIKE xmdc_t.xmdc052, #检验否
       xmdc053 LIKE xmdc_t.xmdc053, #结案理由码
       xmdc054 LIKE xmdc_t.xmdc054, #BOM有效日期
       xmdc055 LIKE xmdc_t.xmdc055, #来源单号
       xmdc056 LIKE xmdc_t.xmdc056, #来源项次
       xmdc057 LIKE xmdc_t.xmdc057, #库存管理特征
       xmdc058 LIKE xmdc_t.xmdc058, #还量数量
       xmdc059 LIKE xmdc_t.xmdc059, #还量参考数量
       xmdc060 LIKE xmdc_t.xmdc060, #还价数量
       xmdc061 LIKE xmdc_t.xmdc061, #还价参考数量
       xmdc062 LIKE xmdc_t.xmdc062, #BOM特性
       xmdc200 LIKE xmdc_t.xmdc200, #现金折扣单号
       xmdc201 LIKE xmdc_t.xmdc201  #现金折扣单项次
END RECORD
#161124-00048#9 mod-E
DEFINE r_success   LIKE type_t.num5
DEFINE l_xmda022   LIKE xmda_t.xmda022
DEFINE l_xmda025   LIKE xmda_t.xmda025
DEFINE l_xmda026   LIKE xmda_t.xmda026

   LET r_success = TRUE
   #161124-00048#9 mod-S
#   DECLARE xmdc_cur CURSOR FOR
#      SELECT * FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno ORDER BY pmdnseq
   DECLARE xmdc_cur CURSOR FOR
      SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
             pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
             pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
             pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
             pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
             pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
             pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
             pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
             pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
             pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
             pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
             pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
             pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
             pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
             pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
             pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
             pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
             pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
             pmdn226,pmdn227,pmdn058,pmdn228
        FROM pmdn_t 
       WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno 
       ORDER BY pmdnseq
   #161124-00048#9 mod-E
      
   LET l_xmda022 = ''
   LET l_xmda025 = ''
   LET l_xmda026 = ''
   SELECT xmda022,xmda025,xmda026 INTO l_xmda022,l_xmda025,l_xmda026 FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadocno = p_xmdadocno
   
   FOREACH xmdc_cur INTO l_pmdn.*
      INITIALIZE l_xmdc.* TO NULL 
      
      LET l_xmdc.xmdcent = g_enterprise
      LET l_xmdc.xmdcsite = p_sfaa018
      LET l_xmdc.xmdcdocno = p_xmdadocno
      
      ##項次加1
      #SELECT MAX(xmdcseq)+1 INTO l_xmdc.xmdcseq FROM xmdc_t
      # WHERE xmdcent = g_enterprise AND xmdcdocno = p_xmdadocno
      #IF cl_null(l_xmdc.xmdcseq) OR l_xmdc.xmdcseq = 0 THEN
      #   LET l_xmdc.xmdcseq = 1
      #END IF
      LET l_xmdc.xmdcseq = l_pmdn.pmdnseq
      LET l_xmdc.xmdc001 = l_pmdn.pmdn001
      LET l_xmdc.xmdc002 = l_pmdn.pmdn002
      LET l_xmdc.xmdc003 = l_pmdn.pmdn003
      LET l_xmdc.xmdc004 = l_pmdn.pmdn004
      LET l_xmdc.xmdc005 = l_pmdn.pmdn005
      LET l_xmdc.xmdc006 = l_pmdn.pmdn006
      LET l_xmdc.xmdc007 = l_pmdn.pmdn007
      LET l_xmdc.xmdc008 = l_pmdn.pmdn008
      LET l_xmdc.xmdc009 = l_pmdn.pmdn009
      LET l_xmdc.xmdc010 = l_pmdn.pmdn010
      LET l_xmdc.xmdc011 = l_pmdn.pmdn011
      LET l_xmdc.xmdc012 = l_pmdn.pmdn012
      LET l_xmdc.xmdc013 = l_pmdn.pmdn013
      LET l_xmdc.xmdc015 = l_pmdn.pmdn015
      LET l_xmdc.xmdc016 = l_pmdn.pmdn016
      LET l_xmdc.xmdc017 = l_pmdn.pmdn017
      LET l_xmdc.xmdc019 = l_pmdn.pmdn019
      LET l_xmdc.xmdc020 = l_pmdn.pmdn020
      LET l_xmdc.xmdc021 = l_pmdn.pmdn021
      LET l_xmdc.xmdc022 = l_pmdn.pmdn022
      LET l_xmdc.xmdcunit = l_pmdn.pmdnunit
      LET l_xmdc.xmdcorga = l_pmdn.pmdnorga
      LET l_xmdc.xmdc023 = l_xmda022
      LET l_xmdc.xmdc024 = l_pmdn.pmdn024
      LET l_xmdc.xmdc025 = l_xmda025
      LET l_xmdc.xmdc026 = l_xmda026
      LET l_xmdc.xmdc027 = ''
      LET l_xmdc.xmdc028 = l_pmdn.pmdn028
      LET l_xmdc.xmdc029 = l_pmdn.pmdn029
      LET l_xmdc.xmdc030 = l_pmdn.pmdn030
      LET l_xmdc.xmdc031 = l_pmdn.pmdn031
      LET l_xmdc.xmdc032 = l_pmdn.pmdn032
      LET l_xmdc.xmdc033 = l_pmdn.pmdn033
      LET l_xmdc.xmdc035 = l_pmdn.pmdn035
      LET l_xmdc.xmdc036 = l_pmdn.pmdn036
      LET l_xmdc.xmdc037 = l_pmdn.pmdn037
      LET l_xmdc.xmdc038 = l_pmdn.pmdn038
      LET l_xmdc.xmdc039 = l_pmdn.pmdn039
      LET l_xmdc.xmdc040 = l_pmdn.pmdn040
      LET l_xmdc.xmdc041 = l_pmdn.pmdn041
      LET l_xmdc.xmdc042 = l_pmdn.pmdn042
      LET l_xmdc.xmdc043 = l_pmdn.pmdn043
      LET l_xmdc.xmdc044 = l_pmdn.pmdn044
      LET l_xmdc.xmdc045 = l_pmdn.pmdn045
      LET l_xmdc.xmdc046 = l_pmdn.pmdn046
      LET l_xmdc.xmdc047 = l_pmdn.pmdn047
      LET l_xmdc.xmdc048 = l_pmdn.pmdn048
      LET l_xmdc.xmdc049 = l_pmdn.pmdn049
      LET l_xmdc.xmdc050 = l_pmdn.pmdn050
      
      INSERT INTO xmdc_t
                  (xmdcent,xmdcsite,xmdcdocno,xmdcseq,xmdc027,
		             xmdc001,xmdc002,xmdc004,xmdc005,xmdc006,xmdc007,
		             xmdc008,xmdc009,xmdc024,xmdc012,xmdc013,xmdc045,
		             xmdc016,xmdc017,xmdc010,xmdc011,xmdc015,xmdc046,
		             xmdc047,xmdc048,xmdc023,xmdc019,xmdc020,xmdc021,
		             xmdc022,xmdcunit,xmdcorga,xmdc052,xmdc049,xmdc053,
		             xmdc050,xmdc028,xmdc029,xmdc030,xmdc025,xmdc026,
		             xmdc031,xmdc032,xmdc033,xmdc003,xmdc054,xmdc036,
		             xmdc037,xmdc038,xmdc039,xmdc035,xmdc040,xmdc041,xmdc042,xmdc043,xmdc044) 
            VALUES(l_xmdc.xmdcent,l_xmdc.xmdcsite,l_xmdc.xmdcdocno,l_xmdc.xmdcseq,l_xmdc.xmdc027,
                   l_xmdc.xmdc001,l_xmdc.xmdc002,l_xmdc.xmdc004,l_xmdc.xmdc005, 
                   l_xmdc.xmdc006,l_xmdc.xmdc007,l_xmdc.xmdc008, 
                   l_xmdc.xmdc009,l_xmdc.xmdc024,l_xmdc.xmdc012, 
                   l_xmdc.xmdc013,l_xmdc.xmdc045,l_xmdc.xmdc016, 
                   l_xmdc.xmdc017,l_xmdc.xmdc010,l_xmdc.xmdc011, 
                   l_xmdc.xmdc015,l_xmdc.xmdc046,l_xmdc.xmdc047, 
                   l_xmdc.xmdc048,l_xmdc.xmdc023,l_xmdc.xmdc019, 
                   l_xmdc.xmdc020,l_xmdc.xmdc021,l_xmdc.xmdc022, 
                   l_xmdc.xmdcunit,l_xmdc.xmdcorga,l_xmdc.xmdc052, 
                   l_xmdc.xmdc049,l_xmdc.xmdc053,l_xmdc.xmdc050, 
                   l_xmdc.xmdc028,l_xmdc.xmdc029,l_xmdc.xmdc030, 
                   l_xmdc.xmdc025,l_xmdc.xmdc026,l_xmdc.xmdc031, 
                   l_xmdc.xmdc032,l_xmdc.xmdc033,l_xmdc.xmdc003, 
                   l_xmdc.xmdc054,l_xmdc.xmdc036,l_xmdc.xmdc037, 
                   l_xmdc.xmdc038,l_xmdc.xmdc039,l_xmdc.xmdc035, 
                   l_xmdc.xmdc040,l_xmdc.xmdc041,l_xmdc.xmdc042, 
                   l_xmdc.xmdc043,l_xmdc.xmdc044)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend ="xmdc_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         
         LET r_success = FALSE
         RETURN r_success
      END IF      
   
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

#寫入訂單交期明細單身
PUBLIC FUNCTION s_apmt500_ins_xmdd(p_pmdldocno,p_xmdadocno,p_sfaa018)
DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
DEFINE p_xmdadocno LIKE xmda_t.xmdadocno
DEFINE p_sfaa018   LIKE sfaa_t.sfaa018
#161124-00048#9 mod-S
#DEFINE l_pmdo      RECORD LIKE pmdo_t.*
#DEFINE l_xmdd      RECORD LIKE xmdd_t.*
DEFINE l_pmdo RECORD  #採購交期明細檔
       pmdoent LIKE pmdo_t.pmdoent, #企业编号
       pmdosite LIKE pmdo_t.pmdosite, #营运据点
       pmdodocno LIKE pmdo_t.pmdodocno, #采购单号
       pmdoseq LIKE pmdo_t.pmdoseq, #采购项次
       pmdoseq1 LIKE pmdo_t.pmdoseq1, #项序
       pmdoseq2 LIKE pmdo_t.pmdoseq2, #分批序
       pmdo001 LIKE pmdo_t.pmdo001, #料件编号
       pmdo002 LIKE pmdo_t.pmdo002, #产品特征
       pmdo003 LIKE pmdo_t.pmdo003, #子件特性
       pmdo004 LIKE pmdo_t.pmdo004, #采购单位
       pmdo005 LIKE pmdo_t.pmdo005, #采购总数量
       pmdo006 LIKE pmdo_t.pmdo006, #分批采购数量
       pmdo007 LIKE pmdo_t.pmdo007, #折合主件数量
       pmdo008 LIKE pmdo_t.pmdo008, #QPA
       pmdo009 LIKE pmdo_t.pmdo009, #交期类型
       pmdo010 LIKE pmdo_t.pmdo010, #收货时段
       pmdo011 LIKE pmdo_t.pmdo011, #出货日期
       pmdo012 LIKE pmdo_t.pmdo012, #到厂日期
       pmdo013 LIKE pmdo_t.pmdo013, #到库日期
       pmdo014 LIKE pmdo_t.pmdo014, #MRP交期冻结
       pmdo015 LIKE pmdo_t.pmdo015, #已收货量
       pmdo016 LIKE pmdo_t.pmdo016, #验退量
       pmdo017 LIKE pmdo_t.pmdo017, #仓退换货量
       pmdo019 LIKE pmdo_t.pmdo019, #已入库量
       pmdo020 LIKE pmdo_t.pmdo020, #VMI请款量
       pmdo021 LIKE pmdo_t.pmdo021, #交货状态
       pmdo022 LIKE pmdo_t.pmdo022, #参考价格
       pmdo023 LIKE pmdo_t.pmdo023, #税种
       pmdo024 LIKE pmdo_t.pmdo024, #税率
       pmdo025 LIKE pmdo_t.pmdo025, #电子采购单号
       pmdo026 LIKE pmdo_t.pmdo026, #最近更改人员
       pmdo027 LIKE pmdo_t.pmdo027, #最近更改时间
       pmdo028 LIKE pmdo_t.pmdo028, #分批参考单位
       pmdo029 LIKE pmdo_t.pmdo029, #分批参考数量
       pmdo030 LIKE pmdo_t.pmdo030, #分批计价单位
       pmdo031 LIKE pmdo_t.pmdo031, #分批计价数量
       pmdo032 LIKE pmdo_t.pmdo032, #分批税前金额
       pmdo033 LIKE pmdo_t.pmdo033, #分批含税金额
       pmdo034 LIKE pmdo_t.pmdo034, #分批税额
       pmdo035 LIKE pmdo_t.pmdo035, #初始营运据点
       pmdo036 LIKE pmdo_t.pmdo036, #初始来源单号
       pmdo037 LIKE pmdo_t.pmdo037, #初始来源项次
       pmdo038 LIKE pmdo_t.pmdo038, #初始项序
       pmdo039 LIKE pmdo_t.pmdo039, #初始分批序
       pmdo040 LIKE pmdo_t.pmdo040, #仓退量
       pmdo200 LIKE pmdo_t.pmdo200, #分批包装单位
       pmdo201 LIKE pmdo_t.pmdo201, #分批包装数量
       pmdo900 LIKE pmdo_t.pmdo900, #保留字段str
       pmdo999 LIKE pmdo_t.pmdo999, #保留字段end
       pmdo041 LIKE pmdo_t.pmdo041, #还料数量
       pmdo042 LIKE pmdo_t.pmdo042, #还量参考数量
       pmdo043 LIKE pmdo_t.pmdo043, #还价数量
       pmdo044 LIKE pmdo_t.pmdo044  #还价参考数量
END RECORD
DEFINE l_xmdd RECORD  #訂單交期明細檔
       xmddent LIKE xmdd_t.xmddent, #企业编号
       xmddsite LIKE xmdd_t.xmddsite, #营运据点
       xmdddocno LIKE xmdd_t.xmdddocno, #订单单号
       xmddseq LIKE xmdd_t.xmddseq, #项次
       xmddseq1 LIKE xmdd_t.xmddseq1, #项序
       xmddseq2 LIKE xmdd_t.xmddseq2, #分批序
       xmdd001 LIKE xmdd_t.xmdd001, #料件编号
       xmdd002 LIKE xmdd_t.xmdd002, #产品特征
       xmdd003 LIKE xmdd_t.xmdd003, #子件特性
       xmdd004 LIKE xmdd_t.xmdd004, #销售单位
       xmdd005 LIKE xmdd_t.xmdd005, #订购总数量
       xmdd006 LIKE xmdd_t.xmdd006, #分批订购数量
       xmdd007 LIKE xmdd_t.xmdd007, #折合主件数量
       xmdd008 LIKE xmdd_t.xmdd008, #QPA
       xmdd009 LIKE xmdd_t.xmdd009, #交期类型
       xmdd010 LIKE xmdd_t.xmdd010, #出货时段
       xmdd011 LIKE xmdd_t.xmdd011, #约定交货日期
       xmdd012 LIKE xmdd_t.xmdd012, #预计签收日期
       xmdd013 LIKE xmdd_t.xmdd013, #MRP交期冻结
       xmdd014 LIKE xmdd_t.xmdd014, #已出货量
       xmdd015 LIKE xmdd_t.xmdd015, #已销退量
       xmdd016 LIKE xmdd_t.xmdd016, #销退换货数量
       xmdd017 LIKE xmdd_t.xmdd017, #出货状态
       xmdd018 LIKE xmdd_t.xmdd018, #参考价格
       xmdd019 LIKE xmdd_t.xmdd019, #税种
       xmdd020 LIKE xmdd_t.xmdd020, #税率
       xmdd021 LIKE xmdd_t.xmdd021, #电子订购单号
       xmdd022 LIKE xmdd_t.xmdd022, #最近更改人员
       xmdd023 LIKE xmdd_t.xmdd023, #最近更改时间
       xmdd024 LIKE xmdd_t.xmdd024, #分批参考单位
       xmdd025 LIKE xmdd_t.xmdd025, #分批参考数量
       xmdd026 LIKE xmdd_t.xmdd026, #分批计价单位
       xmdd027 LIKE xmdd_t.xmdd027, #分批计价数量
       xmdd028 LIKE xmdd_t.xmdd028, #分批税前金额
       xmdd029 LIKE xmdd_t.xmdd029, #分批含税金额
       xmdd030 LIKE xmdd_t.xmdd030, #分批税额
       xmdd031 LIKE xmdd_t.xmdd031, #已转出通数量
       xmdd032 LIKE xmdd_t.xmdd032, #备置量
       xmdd033 LIKE xmdd_t.xmdd033, #备置原因
       xmdd034 LIKE xmdd_t.xmdd034, #已签退量
       xmdd035 LIKE xmdd_t.xmdd035, #已分配量
       xmdd200 LIKE xmdd_t.xmdd200, #促销方案
       xmdd201 LIKE xmdd_t.xmdd201, #分批包装单位
       xmdd202 LIKE xmdd_t.xmdd202, #分批包装数量
       xmdd203 LIKE xmdd_t.xmdd203, #标准价
       xmdd204 LIKE xmdd_t.xmdd204, #促销价
       xmdd205 LIKE xmdd_t.xmdd205, #交易价
       xmdd206 LIKE xmdd_t.xmdd206, #折价金额
       xmddunit LIKE xmdd_t.xmddunit, #应用组织
       xmdd207 LIKE xmdd_t.xmdd207, #收货网点
       xmdd208 LIKE xmdd_t.xmdd208, #送货地址码
       xmdd209 LIKE xmdd_t.xmdd209, #送货站点
       xmdd210 LIKE xmdd_t.xmdd210, #送货时段
       xmdd211 LIKE xmdd_t.xmdd211, #送货客户
       xmdd212 LIKE xmdd_t.xmdd212, #MRP冻结
       xmdd213 LIKE xmdd_t.xmdd213, #库位/库区
       xmdd214 LIKE xmdd_t.xmdd214, #储位
       xmdd215 LIKE xmdd_t.xmdd215, #批号
       xmdd216 LIKE xmdd_t.xmdd216, #库存锁定等级
       xmdd217 LIKE xmdd_t.xmdd217, #库存余额
       xmdd218 LIKE xmdd_t.xmdd218, #销售渠道
       xmdd219 LIKE xmdd_t.xmdd219, #产品组编号
       xmdd220 LIKE xmdd_t.xmdd220, #销售范围编号
       xmdd221 LIKE xmdd_t.xmdd221, #备注
       xmdd222 LIKE xmdd_t.xmdd222, #办事处
       xmdd223 LIKE xmdd_t.xmdd223, #业务人员
       xmdd224 LIKE xmdd_t.xmdd224, #业务部门
       xmdd225 LIKE xmdd_t.xmdd225, #主合同编号
       xmdd226 LIKE xmdd_t.xmdd226, #经营方式
       xmdd227 LIKE xmdd_t.xmdd227, #结算类型
       xmdd228 LIKE xmdd_t.xmdd228, #结算方式
       xmddorga LIKE xmdd_t.xmddorga, #账务组织
       xmdd229 LIKE xmdd_t.xmdd229, #交易类型
       xmdd230 LIKE xmdd_t.xmdd230, #分批包装销退换货数量
       xmdd036 LIKE xmdd_t.xmdd036, #还量数量
       xmdd037 LIKE xmdd_t.xmdd037, #还量参考数量
       xmdd038 LIKE xmdd_t.xmdd038, #还价数量
       xmdd039 LIKE xmdd_t.xmdd039, #还价参考数量
       xmdd231 LIKE xmdd_t.xmdd231, #库存管理特征
       xmdd040 LIKE xmdd_t.xmdd040  #BOM特性
END RECORD
#161124-00048#9 mod-E
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   #161124-00048#9 mod-S
#   DECLARE xmdd_cur CURSOR FOR
#      SELECT * FROM pmdo_t WHERE pmdoent = g_enterprise AND pmdodocno = p_pmdldocno 
#      ORDER BY pmdoseq,pmdoseq1,pmdoseq2
   DECLARE xmdd_cur CURSOR FOR
      SELECT pmdoent,pmdosite,pmdodocno,pmdoseq,pmdoseq1,
             pmdoseq2,pmdo001,pmdo002,pmdo003,pmdo004,
             pmdo005,pmdo006,pmdo007,pmdo008,pmdo009,
             pmdo010,pmdo011,pmdo012,pmdo013,pmdo014,
             pmdo015,pmdo016,pmdo017,pmdo019,pmdo020,
             pmdo021,pmdo022,pmdo023,pmdo024,pmdo025,
             pmdo026,pmdo027,pmdo028,pmdo029,pmdo030,
             pmdo031,pmdo032,pmdo033,pmdo034,pmdo035,
             pmdo036,pmdo037,pmdo038,pmdo039,pmdo040,
             pmdo200,pmdo201,pmdo900,pmdo999,pmdo041,
             pmdo042,pmdo043,pmdo044
        FROM pmdo_t  
       WHERE pmdoent = g_enterprise AND pmdodocno = p_pmdldocno 
       ORDER BY pmdoseq,pmdoseq1,pmdoseq2
   #161124-00048#9 mod-E
    
   FOREACH xmdd_cur INTO l_pmdo.*
      
      INITIALIZE l_xmdd.* TO NULL 
      
      LET l_xmdd.xmddent = g_enterprise
      LET l_xmdd.xmddsite = p_sfaa018
      LET l_xmdd.xmdddocno = p_xmdadocno
      LET l_xmdd.xmddseq = l_pmdo.pmdoseq
      LET l_xmdd.xmddseq1 = l_pmdo.pmdoseq1
      LET l_xmdd.xmddseq2 = l_pmdo.pmdoseq2
      LET l_xmdd.xmdd001 = l_pmdo.pmdo001
      LET l_xmdd.xmdd002 = l_pmdo.pmdo002
      LET l_xmdd.xmdd003 = l_pmdo.pmdo003
      LET l_xmdd.xmdd004 = l_pmdo.pmdo004
      LET l_xmdd.xmdd005 = l_pmdo.pmdo005
      LET l_xmdd.xmdd006 = l_pmdo.pmdo006
      LET l_xmdd.xmdd007 = l_pmdo.pmdo007
      LET l_xmdd.xmdd008 = l_pmdo.pmdo008
      LET l_xmdd.xmdd009 = l_pmdo.pmdo009
      LET l_xmdd.xmdd010 = l_pmdo.pmdo010
      LET l_xmdd.xmdd011 = l_pmdo.pmdo011
      LET l_xmdd.xmdd012 = l_pmdo.pmdo012
      LET l_xmdd.xmdd013 = l_pmdo.pmdo014
      LET l_xmdd.xmdd014 = 0
      LET l_xmdd.xmdd015 = 0
      LET l_xmdd.xmdd016 = 0
      LET l_xmdd.xmdd017 = '2'
      LET l_xmdd.xmdd018 = l_pmdo.pmdo022
      LET l_xmdd.xmdd018 = l_pmdo.pmdo023
      LET l_xmdd.xmdd020 = l_pmdo.pmdo024
      LET l_xmdd.xmdd024 = l_pmdo.pmdo028
      LET l_xmdd.xmdd025 = l_pmdo.pmdo029
      LET l_xmdd.xmdd026 = l_pmdo.pmdo030
      LET l_xmdd.xmdd027 = l_pmdo.pmdo031
      LET l_xmdd.xmdd028 = l_pmdo.pmdo032
      LET l_xmdd.xmdd029 = l_pmdo.pmdo033
      LET l_xmdd.xmdd030 = l_pmdo.pmdo034
      LET l_xmdd.xmdd031 = 0 
      
      INSERT INTO xmdd_t
                  (xmddent,xmdddocno,xmddseq,xmddseq1,xmddseq2,
                   xmddsite,xmdd001,xmdd002,xmdd003,xmdd004,
                   xmdd005,xmdd006,xmdd007,xmdd008,xmdd009,
                   xmdd010,xmdd011,xmdd012,xmdd013,xmdd014,
                   xmdd015,xmdd016,xmdd017,xmdd018,xmdd019,
                   xmdd020,xmdd021,xmdd022,xmdd023,xmdd024,
                   xmdd025,xmdd026,xmdd027,xmdd028,xmdd029,
                   xmdd030,xmdd031) 
            VALUES (g_enterprise,l_xmdd.xmdddocno,l_xmdd.xmddseq,l_xmdd.xmddseq1,l_xmdd.xmddseq2,
                    l_xmdd.xmddsite,l_xmdd.xmdd001,l_xmdd.xmdd002,l_xmdd.xmdd003,l_xmdd.xmdd004,
                    l_xmdd.xmdd005,l_xmdd.xmdd006,l_xmdd.xmdd007,l_xmdd.xmdd008,l_xmdd.xmdd009,
                    l_xmdd.xmdd010,l_xmdd.xmdd011,l_xmdd.xmdd012,l_xmdd.xmdd013,l_xmdd.xmdd014,
                    l_xmdd.xmdd015,l_xmdd.xmdd016,l_xmdd.xmdd017,l_xmdd.xmdd018,l_xmdd.xmdd019,
                    l_xmdd.xmdd020,l_xmdd.xmdd021,l_xmdd.xmdd022,l_xmdd.xmdd023,l_xmdd.xmdd024,
                    l_xmdd.xmdd025,l_xmdd.xmdd026,l_xmdd.xmdd027,l_xmdd.xmdd028,l_xmdd.xmdd029,
                    l_xmdd.xmdd030,l_xmdd.xmdd031)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend ="xmdd_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
      
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

#寫入訂單多交期匯總檔
PUBLIC FUNCTION s_apmt500_ins_xmdf(p_pmdldocno,p_xmdadocno,p_sfaa018)
DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
DEFINE p_xmdadocno LIKE xmda_t.xmdadocno
DEFINE p_sfaa018   LIKE sfaa_t.sfaa018
#161124-00048#9 mod-S
#DEFINE l_pmdq      RECORD LIKE pmdq_t.*
#DEFINE l_xmdf      RECORD LIKE xmdf_t.*
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
DEFINE l_xmdf RECORD  #訂單多交期匯總檔
       xmdfent LIKE xmdf_t.xmdfent, #企业编号
       xmdfsite LIKE xmdf_t.xmdfsite, #营运据点
       xmdfdocno LIKE xmdf_t.xmdfdocno, #订单单号
       xmdfseq LIKE xmdf_t.xmdfseq, #订单项次
       xmdfseq2 LIKE xmdf_t.xmdfseq2, #分批序
       xmdf002 LIKE xmdf_t.xmdf002, #分批数量
       xmdf003 LIKE xmdf_t.xmdf003, #约定交货日期
       xmdf004 LIKE xmdf_t.xmdf004, #预计签收日
       xmdf005 LIKE xmdf_t.xmdf005, #出货时段
       xmdf006 LIKE xmdf_t.xmdf006, #MRP冻结否
       xmdf007 LIKE xmdf_t.xmdf007, #交期类型
       xmdf200 LIKE xmdf_t.xmdf200, #库区/库位
       xmdf201 LIKE xmdf_t.xmdf201, #储位
       xmdf202 LIKE xmdf_t.xmdf202, #批号
       xmdfunit LIKE xmdf_t.xmdfunit, #发货组织
       xmdf203 LIKE xmdf_t.xmdf203  #库存管理特征
END RECORD
#161124-00048#9 mod-E
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   #161124-00048#9 mod-S
#   DECLARE xmdf_cur CURSOR FOR
#      SELECT * FROM pmdq_t WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdldocno 
#      ORDER BY pmdqseq,pmdqseq1,pmdqseq2
   DECLARE xmdf_cur CURSOR FOR
      SELECT pmdqent,pmdqsite,pmdqdocno,pmdqseq,pmdqseq2,
             pmdq002,pmdq003,pmdq004,pmdq005,pmdq006,
             pmdq007,pmdq008,pmdq201,pmdq202,pmdq900,
             pmdq999
        FROM pmdq_t 
       WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdldocno 
      ORDER BY pmdqseq,pmdqseq1,pmdqseq2
   #161124-00048#9 mod-E
    
   FOREACH xmdf_cur INTO l_pmdq.*
      
      INITIALIZE l_xmdf.* TO NULL 
      
      LET l_xmdf.xmdfent = g_enterprise
      LET l_xmdf.xmdfsite = p_sfaa018
      LET l_xmdf.xmdfdocno = p_xmdadocno
      LET l_xmdf.xmdfseq = l_pmdq.pmdqseq
      LET l_xmdf.xmdfseq2 = l_pmdq.pmdqseq2
      LET l_xmdf.xmdf002 = l_pmdq.pmdq002
      LET l_xmdf.xmdf003 = l_pmdq.pmdq003
      LET l_xmdf.xmdf004 = l_pmdq.pmdq004
      LET l_xmdf.xmdf005 = l_pmdq.pmdq006
      LET l_xmdf.xmdf006 = l_pmdq.pmdq007
      
      INSERT INTO xmdf_t
                  (xmdfent,xmdfdocno,xmdfseq,xmdfseq2,
                   xmdfsite,xmdf002,xmdf003,xmdf004,
                   xmdf005,xmdf006) 
            VALUES (g_enterprise,l_xmdf.xmdfdocno,l_xmdf.xmdfseq,l_xmdf.xmdfseq2,
                    l_xmdf.xmdfsite,l_xmdf.xmdf002,l_xmdf.xmdf003,l_xmdf.xmdf004,
                    l_xmdf.xmdf005,l_xmdf.xmdf006)
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend ="xmdf_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

#寫入訂單多帳期預收款檔
PUBLIC FUNCTION s_apmt500_ins_xmdb(p_pmdldocno,p_xmdadocno,p_sfaa018)
DEFINE p_pmdldocno LIKE pmdl_t.pmdldocno
DEFINE p_xmdadocno LIKE xmda_t.xmdadocno
DEFINE p_sfaa018   LIKE sfaa_t.sfaa018
#161124-00048#9 mod-S
#DEFINE l_pmdm      RECORD LIKE pmdm_t.*
#DEFINE l_xmdb      RECORD LIKE xmdb_t.*
DEFINE l_pmdm RECORD  #採購多帳期預付款檔
       pmdment LIKE pmdm_t.pmdment, #企业编号
       pmdmsite LIKE pmdm_t.pmdmsite, #营运据点
       pmdmdocno LIKE pmdm_t.pmdmdocno, #采购单号
       pmdm001 LIKE pmdm_t.pmdm001, #期别
       pmdm002 LIKE pmdm_t.pmdm002, #付款条件
       pmdm003 LIKE pmdm_t.pmdm003, #预计应付款日
       pmdm004 LIKE pmdm_t.pmdm004, #预计票据到期日
       pmdm005 LIKE pmdm_t.pmdm005, #税前金额
       pmdm006 LIKE pmdm_t.pmdm006, #含税金额
       pmdm007 LIKE pmdm_t.pmdm007, #应付账款单号
       pmdm008 LIKE pmdm_t.pmdm008, #主账套立账税前金额
       pmdm009 LIKE pmdm_t.pmdm009, #主账套立账含税金额
       pmdm010 LIKE pmdm_t.pmdm010, #账套二立账税前金额
       pmdm011 LIKE pmdm_t.pmdm011, #账套二立账含税金额
       pmdm012 LIKE pmdm_t.pmdm012, #账套三立账税前金额
       pmdm013 LIKE pmdm_t.pmdm013, #账套三立账含税金额
       pmdm014 LIKE pmdm_t.pmdm014, #账款类型
       pmdm900 LIKE pmdm_t.pmdm900, #保留字段str
       pmdm999 LIKE pmdm_t.pmdm999  #保留字段end
END RECORD
DEFINE l_xmdb RECORD  #訂單多帳期預收款檔
       xmdbent LIKE xmdb_t.xmdbent, #企业编号
       xmdbsite LIKE xmdb_t.xmdbsite, #营运据点
       xmdbdocno LIKE xmdb_t.xmdbdocno, #订单单号
       xmdb001 LIKE xmdb_t.xmdb001, #期别
       xmdb002 LIKE xmdb_t.xmdb002, #收款条件
       xmdb003 LIKE xmdb_t.xmdb003, #预计应收款日
       xmdb004 LIKE xmdb_t.xmdb004, #预计票据到期日
       xmdb005 LIKE xmdb_t.xmdb005, #税前金额
       xmdb006 LIKE xmdb_t.xmdb006, #含税金额
       xmdb007 LIKE xmdb_t.xmdb007, #应收账款单号
       xmdb008 LIKE xmdb_t.xmdb008, #主账套立账税前金额
       xmdb009 LIKE xmdb_t.xmdb009, #主账套立账含税金额
       xmdb010 LIKE xmdb_t.xmdb010, #账套二立账税前金额
       xmdb011 LIKE xmdb_t.xmdb011, #账套二立账含税金额
       xmdb014 LIKE xmdb_t.xmdb014, #账套三立账税前金额
       xmdb015 LIKE xmdb_t.xmdb015, #账套三立账含税金额
       xmdb016 LIKE xmdb_t.xmdb016, #账款类型
       xmdb017 LIKE xmdb_t.xmdb017, #账款影响出货模式
       xmdb200 LIKE xmdb_t.xmdb200  #本币含税总金额
END RECORD
#161124-00048#9 mod-E
DEFINE l_xmda009   LIKE xmda_t.xmda009
DEFINE r_success   LIKE type_t.num5

   LET r_success = TRUE
   #161124-00048#9 mod-S
#   DECLARE xmdb_cur CURSOR FOR
#      SELECT * FROM pmdm_t WHERE pmdment = g_enterprise AND pmdmdocno = p_pmdldocno ORDER BY pmdm001
   DECLARE xmdb_cur CURSOR FOR
      SELECT pmdment,pmdmsite,pmdmdocno,pmdm001,pmdm002,
             pmdm003,pmdm004,pmdm005,pmdm006,pmdm007,
             pmdm008,pmdm009,pmdm010,pmdm011,pmdm012,
             pmdm013,pmdm014,pmdm900,pmdm999
        FROM pmdm_t 
       WHERE pmdment = g_enterprise AND pmdmdocno = p_pmdldocno ORDER BY pmdm001
   #161124-00048#9 mod-E
   
   LET l_xmda009 =  ''
   SELECT xmda009 INTO l_xmda009 FROM xmda_t WHERE xmdaent = g_enterprise AND xmdadono = p_xmdadocno
   
   FOREACH xmdb_cur INTO l_pmdm.*
      
      INITIALIZE l_xmdb.* TO NULL 
      
      LET l_xmdb.xmdbent = g_enterprise
      LET l_xmdb.xmdbsite = p_sfaa018
      LET l_xmdb.xmdbdocno = p_xmdadocno
      LET l_xmdb.xmdb001 = l_pmdm.pmdm001
      LET l_xmdb.xmdb002 = l_xmda009
      LET l_xmdb.xmdb003 = l_pmdm.pmdm003
      LET l_xmdb.xmdb004 = l_pmdm.pmdm004
      LET l_xmdb.xmdb005 = l_pmdm.pmdm005
      LET l_xmdb.xmdb006 = l_pmdm.pmdm006
      
      INSERT INTO xmdb_t(xmdbent,xmdbdocno,xmdbsite,
		                   xmdb001,xmdb002,xmdb003,xmdb004,xmdb005,xmdb006) 
            VALUES(g_enterprise,l_xmdb.xmdbdocno,l_xmdb.xmdbsite,
                   l_xmdb.xmdb001,l_xmdb.xmdb002,l_xmdb.xmdb003, 
                   l_xmdb.xmdb004,l_xmdb.xmdb005,l_xmdb.xmdb006) 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend ="xmdb_t"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_success
       END IF
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 依據取價方式抓取採購單價
# Memo...........:
# Usage..........: CALL s_apmt500_get_price(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)
#                  RETURNING r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042
# Date & Author..: 2014/08/13 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_price(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)
DEFINE p_pmdl017    LIKE pmdl_t.pmdl017
DEFINE p_pmdl004    LIKE pmdl_t.pmdl004
DEFINE p_pmdn001    LIKE pmdn_t.pmdn001
DEFINE p_pmdn002    LIKE pmdn_t.pmdn002
DEFINE p_pmdl015    LIKE pmdl_t.pmdl015
DEFINE p_pmdn016    LIKE pmdl_t.pmdl011
DEFINE p_pmdl009    LIKE pmdl_t.pmdl009
DEFINE p_pmdl010    LIKE pmdl_t.pmdl010
DEFINE p_pmdl023    LIKE pmdl_t.pmdl023
DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt  LIKE pmdl_t.pmdldocdt
DEFINE p_pmdn010    LIKE pmdn_t.pmdn010
DEFINE p_pmdn011    LIKE pmdn_t.pmdn011
DEFINE p_site       LIKE pmdl_t.pmdlsite
DEFINE p_pmdl054    LIKE pmdl_t.pmdl054
DEFINE p_type       LIKE type_t.chr1    #單價類型(1.一般，2.委外)
DEFINE p_pmdn004    LIKE pmdn_t.pmdn004
DEFINE p_pmdn005    LIKE pmdn_t.pmdn005
DEFINE r_pmdn040    LIKE pmdn_t.pmdn040
DEFINE r_pmdn043    LIKE pmdn_t.pmdn043
DEFINE r_pmdn041    LIKE pmdn_t.pmdn041
DEFINE r_pmdn042    LIKE pmdn_t.pmdn042

     LET r_pmdn040 = ''
     LET r_pmdn043 = ''
     LET r_pmdn041 = ''
     LET r_pmdn042 = ''
     
     #參數檢核
     IF cl_null(p_pmdl017) OR cl_null(p_pmdl004) OR cl_null(p_pmdn001) OR
        cl_null(p_pmdl015) OR cl_null(p_pmdn016) OR cl_null(p_pmdl009) OR
        #cl_null(p_pmdl010) OR cl_null(p_pmdl023) OR cl_null(p_pmdldocno) OR  #160807-00005#1
        cl_null(p_pmdl010) OR cl_null(p_pmdldocno) OR  #160807-00005#1
        cl_null(p_pmdldocdt) OR cl_null(p_pmdn010) OR cl_null(p_pmdn011) OR cl_null(p_type) THEN
           RETURN r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042
     END IF
     
     CALL s_purchase_price_get(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,
                               p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,
                               p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)          
           RETURNING r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042
     
     #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
     CALL s_curr_round(g_site,p_pmdl015,r_pmdn043,'1') RETURNING r_pmdn043
                     
     RETURN r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042

END FUNCTION

#採購單有關聯單據時，檢查採購量
PUBLIC FUNCTION s_apmt500_pmdn007_chk(p_pmdldocno,p_pmdnseq,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdn006,p_pmdn007)
DEFINE p_pmdldocno    LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq      LIKE pmdn_t.pmdnseq
DEFINE p_pmdn007      LIKE pmdn_t.pmdn007
DEFINE r_success      LIKE type_t.num5
DEFINE l_pmdp003      LIKE pmdp_t.pmdp003
DEFINE l_pmdp004      LIKE pmdp_t.pmdp004
DEFINE l_pmdb006      LIKE pmdb_t.pmdb006
DEFINE l_pmdb049      LIKE pmdb_t.pmdb049
DEFINE l_pmdn007      LIKE pmdn_t.pmdn007
DEFINE p_pmdn001      LIKE pmdn_t.pmdn001
DEFINE p_pmdn006      LIKE pmdn_t.pmdn006
DEFINE l_imaf143      LIKE imaf_t.imaf143  #採購單位
DEFINE l_imaf145      LIKE imaf_t.imaf145  #採購單位批量
DEFINE l_imaf146      LIKE imaf_t.imaf146  #採購最小數量
DEFINE l_imaf147      LIKE imaf_t.imaf147  #單位批量控管方式
DEFINE l_success      LIKE type_t.num5
DEFINE l_qty          LIKE pmdb_t.pmdb006  #數量
DEFINE l_mod          LIKE type_t.num10
DEFINE l_num          LIKE type_t.num10
DEFINE l_qty1         LIKE pmdb_t.pmdb006  #數量
DEFINE l_qty2         LIKE pmdb_t.pmdb006  #差異數量
DEFINE l_sum          LIKE pmdb_t.pmdb006  #最大可採購數量
DEFINE l_pmdb006_1    LIKE pmdb_t.pmdb006
DEFINE l_pmdb049_1    LIKE pmdb_t.pmdb049
DEFINE l_pmdn007_1    LIKE pmdn_t.pmdn007
DEFINE l_ooba002      LIKE ooba_t.ooba002
DEFINE l_type         LIKE type_t.chr1
DEFINE l_rate         LIKE type_t.num5
DEFINE l_pmdl007      LIKE pmdl_t.pmdl007
DEFINE l_pmdp024      LIKE pmdp_t.pmdp024
DEFINE l_sum1         LIKE pmdb_t.pmdb006
DEFINE l_n_qty        LIKE type_t.num10    
DEFINE l_msg          STRING               
DEFINE l_min_qty      LIKE pmdb_t.pmdb006
DEFINE r_pmdn007      LIKE pmdn_t.pmdn007
DEFINE l_max          LIKE pmdn_t.pmdn007
DEFINE l_sfcb027      LIKE sfcb_t.sfcb027
DEFINE l_sfcb029      LIKE sfcb_t.sfcb029
DEFINE l_sfcb030      LIKE sfcb_t.sfcb030
DEFINE l_sfcb031      LIKE sfcb_t.sfcb031
DEFINE l_sfcb032      LIKE sfcb_t.sfcb032
DEFINE l_sfcb033      LIKE sfcb_t.sfcb032
DEFINE l_sfcb034      LIKE sfcb_t.sfcb034
DEFINE l_sfcb035      LIKE sfcb_t.sfcb035
DEFINE l_sfcb036      LIKE sfcb_t.sfcb036
DEFINE l_sfcb037      LIKE sfcb_t.sfcb037
DEFINE l_sfcb038      LIKE sfcb_t.sfcb038
DEFINE l_sfcb039      LIKE sfcb_t.sfcb039
DEFINE l_sfcb041      LIKE sfcb_t.sfcb041
DEFINE l_sfcb042      LIKE sfcb_t.sfcb042
DEFINE l_qty3         LIKE pmdb_t.pmdb006  #數量
DEFINE l_pmdp012      LIKE pmdp_t.pmdp012
DEFINE l_pmdp007      LIKE pmdp_t.pmdp007
DEFINE l_pmdp008      LIKE pmdp_t.pmdp008
DEFINE l_pmdp009      LIKE pmdp_t.pmdp009
DEFINE l_pmdp010      LIKE pmdp_t.pmdp010
DEFINE l_pmdp011      LIKE pmdp_t.pmdp011
DEFINE l_pmdp023      LIKE pmdp_t.pmdp023
DEFINE l_srza006      LIKE srza_t.srza006
DEFINE l_pmdn014      LIKE pmdn_t.pmdn014
DEFINE l_pmdn006      LIKE pmdn_t.pmdn006
DEFINE p_pmdn002      LIKE pmdn_t.pmdn002    #add by lixiang 2015/10/15
DEFINE p_pmdn004      LIKE pmdn_t.pmdn004    #add by lixiang 2015/10/15
DEFINE p_pmdn005      LIKE pmdn_t.pmdn005    #add by lixiang 2015/10/15
DEFINE l_pmdldocdt    LIKE pmdl_t.pmdldocdt  #add by lixiang 2015/10/15
DEFINE l_pmdl004      LIKE pmdl_t.pmdl004    #add by lixiang 2015/10/15
DEFINE l_pmdp022      LIKE pmdp_t.pmdp022    #add by lixiang 2016/1/21
DEFINE l_slip         LIKE pmda_t.pmdadocno  #160727-00025#9
DEFINE l_flag         LIKE type_t.num5       #160727-00025#9
DEFINE l_oobx003      LIKE oobx_t.oobx003    #160727-00025#9
DEFINE l_pmdl008      LIKE pmdl_t.pmdl008    #160727-00025#9
DEFINE l_pmdp005      LIKE pmdp_t.pmdp005    #160727-00025#9
DEFINE l_sfba014      LIKE sfba_t.sfba014    #160727-00025#9
DEFINE l_sfba013      LIKE sfba_t.sfba013    #160727-00025#9
DEFINE l_pmdl005      LIKE pmdl_t.pmdl005    #160324-00038#39 add

   LET r_success = TRUE
   LET r_pmdn007 = p_pmdn007
   
   SELECT pmdl005,pmdl007,pmdl008 INTO l_pmdl005,l_pmdl007,l_pmdl008   #160324-00038#39 pmdl005
      FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   
   #add by lixiang 2015/10/15--begin--
   #檢查料件編號是否符合條件
   SELECT pmdldocdt,pmdl004 INTO l_pmdldocdt,l_pmdl004 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF NOT s_apmt500_item_avl_chk(l_pmdldocdt,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,l_pmdl004,p_pmdn007,p_pmdldocno,p_pmdnseq) THEN  #add by lixiang 2015/12/04 add pmdldocno，pmdnseq
      LET r_success = FALSE
      RETURN r_success,r_pmdn007
   END IF
   #add by lixiang 2015/10/15---end---
   
   #一般採購單
   #IF g_argv[1] = '3' THEN  #委外時，不檢查關聯請購單的數量    #160324-00038#39
   IF l_pmdl005 NOT MATCHES '[256]' THEN  #160324-00038#39
      #CALL cl_err_collect_init()
      
      IF (NOT cl_null(p_pmdn001)) AND (NOT cl_null(p_pmdn006)) AND (NOT cl_null(p_pmdn007)) THEN
          
          SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
            FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_pmdn001
          IF SQLCA.SQLCODE = 100 THEN
             SELECT imaf143,imaf145,imaf146,imaf147 INTO l_imaf143,l_imaf145,l_imaf146,l_imaf147
               FROM imaf_t WHERE imafent = g_enterprise AND imafsite = "ALL" AND imaf001 = p_pmdn001
          END IF
          
          LET l_qty = p_pmdn007
          #需求單位與採購不一致時，需換算成採購單位對應的數量進行計算
          IF NOT cl_null(l_imaf143) THEN
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
          
          IF l_qty < l_qty1 THEN
             CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty1)
                   RETURNING l_success,l_qty3
             #警示
             IF l_imaf147 MATCHES '[1]' THEN
                LET l_msg = cl_getmsg('apm-00600',g_lang),l_qty3 USING '---,---,---,--&.&&&'
                IF cl_ask_promp(l_msg) THEN
                   LET l_qty = l_qty1
                END IF
             END IF
             #嚴格控制
             IF l_imaf147 MATCHES '[2]' THEN
                #LET l_msg = cl_getmsg('apm-00711',g_lang),l_qty3 USING '---,---,---,--&.&&&'
                #CALL cl_ask_msg_error(l_msg,'','')
                #CALL cl_ask_pressanykey('apm-00711')
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00711'
                LET g_errparam.extend = p_pmdn001
                LET g_errparam.replace[1] = l_qty3
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET l_qty = l_qty1
             END IF
          END IF
          
          IF l_imaf143 <> p_pmdn006 AND (NOT cl_null(l_imaf143)) THEN
             CALL s_aooi250_convert_qty(p_pmdn001,l_imaf143,p_pmdn006,l_qty)
                 RETURNING l_success,r_pmdn007
          ELSE
             LET r_pmdn007 = l_qty
          END IF

          #IF l_imaf147 = '1' THEN   #警告
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
          #   IF l_qty < l_imaf146 THEN
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code = 'apm-00600'
          #      LET g_errparam.extend = p_pmdn001
          #      LET g_errparam.popup = TRUE
          #      CALL cl_err()
          #      RETURN r_success
          #   END IF
          #END IF
          #IF l_imaf147 = '2' THEN   #嚴格控管
          #   IF l_imaf145 > 0 THEN  #有維護最小批量時，檢查
          #      LET l_mod = l_qty MOD l_imaf145
          #      IF l_mod <> 0 THEN  #有餘數，說明不是整除
          #         INITIALIZE g_errparam TO NULL
          #         LET g_errparam.code = 'apm-00599'
          #         LET g_errparam.extend = p_pmdn001
          #         LET g_errparam.popup = TRUE
          #         CALL cl_err()
          #         
          #         #CALL cl_err_collect_show()
          #         LET r_success = FALSE
          #         RETURN r_success
          #      END IF
          #   END IF
          #   IF l_qty < l_imaf146 THEN
          #      INITIALIZE g_errparam TO NULL
          #      LET g_errparam.code = 'apm-00600'
          #      LET g_errparam.extend = p_pmdn001
          #      LET g_errparam.popup = TRUE
          #      CALL cl_err()
          #      
          #      #CALL cl_err_collect_show()
          #      LET r_success = FALSE
          #      RETURN r_success
          #   END IF
          #END IF
          
          
       END IF
      
      LET l_pmdb049 = 0
      LET l_pmdb006 = 0
      LET l_pmdn007 = 0
      
      LET l_sum = 0
      
      DECLARE pmdn007_chk_cs CURSOR FOR
         SELECT pmdp003,pmdp004,pmdp005,pmdp024,pmdp022,pmdp023 FROM pmdp_t   #160727-00025#9 add pmdp005,pmdp023
            WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
      
      FOREACH pmdn007_chk_cs INTO l_pmdp003,l_pmdp004,l_pmdp005,l_pmdp024,l_pmdp022,l_pmdp023 #add by lixiang 2016/1/21 pmdp022  #160727-00025#9 add pmdp005,pmdp023
         
         #160727-00025#9--s
         #判断单据来源,通过oobx003单据性质来判断
         CALL s_aooi200_get_slip(l_pmdp003) RETURNING l_flag,l_slip
         LET l_oobx003 = ''
         SELECT oobx003 INTO l_oobx003 FROM oobx_t
             WHERE oobxent = g_enterprise AND oobx001 = l_slip
         #160727-00025#9--e
                  
         #IF l_pmdl007 NOT MATCHES '[78]' THEN   #160727-00025#9
         IF l_oobx003 = "apmt400" THEN   #160727-00025#9
            #請采勾稽時，判斷採購的數量 和 容差率的處理
            CALL s_aooi200_get_slip(p_pmdldocno) RETURNING l_success,l_ooba002
            IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0061') = "Y" THEN
               #總請購量、已轉採購量
               SELECT pmdb006,pmdb049 INTO l_pmdb006_1,l_pmdb049_1 FROM pmdb_t
                  WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003
                    AND pmdbseq = l_pmdp004
               IF cl_null(l_pmdb006_1) THEN
                  LET l_pmdb006_1 = 0
               END IF
               IF cl_null(l_pmdb049_1) THEN
                  LET l_pmdb049_1 = 0
               END IF
               
               #add by lixiang 2016/1/21--begin---
               #轉換成當前採購單上的單位對應的數量
               IF l_pmdp022 <> p_pmdn006 AND (NOT cl_null(l_pmdp022)) THEN
                  CALL s_aooi250_convert_qty(p_pmdn001,l_pmdp022,p_pmdn006,l_pmdb006_1)
                      RETURNING l_success,l_pmdb006
                  CALL s_aooi250_convert_qty(p_pmdn001,l_pmdp022,p_pmdn006,l_pmdb049_1)
                   RETURNING l_success,l_pmdb049
               END IF
               #add by lixiang 2016/1/21--end---
               
               ##新增單據時，就會回寫已轉採購量，此部分要調整不可以大於請購量 - 轉採購量
               ##其他單據上 維護的採購量
               #SELECT SUM(pmdn007) INTO l_pmdn007_1 FROM pmdl_t,pmdn_t,pmdp_t
               #   WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
               #     AND pmdnent = pmdpent AND pmdndocno = pmdpdocno 
               #     AND pmdnseq = pmdpseq AND pmdnent = g_enterprise 
               #     AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004
               #     AND (pmdndocno <> p_pmdldocno OR pmdnseq <> p_pmdnseq)
               #     AND pmdlstus = 'N'
               ##SELECT SUM(pmdp024) INTO l_pmdn007_1
               ##   FROM pmdp_t,pmdl_t
               ##  WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno
               ##    AND pmdpent = g_enterprise AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004
               ##    AND (pmdpdocno <> p_pmdldocno OR pmdpseq <> p_pmdnseq)
               ##    AND pmdlstus = 'N'
               #IF cl_null(l_pmdn007_1) THEN
               #   LET l_pmdn007_1 = 0
               #END IF
               
               LET l_pmdb006 = l_pmdb006 + l_pmdb006_1
               LET l_pmdb049 = l_pmdb049 + l_pmdb049_1
               #LET l_pmdn007 = l_pmdn007 + l_pmdn007_1
               
            END IF
         END IF
         
         #來源單據是倉退和預先採購時，數量不可大於來源單據數量
         IF l_pmdl007 MATCHES '[78]' THEN
            #SELECT SUM(pmdp024) INTO l_pmdn007_1
            #   FROM pmdp_t,pmdl_t
            #  WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno
            #    AND pmdpent = g_enterprise AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004
            #    AND (pmdpdocno <> p_pmdldocno OR pmdpseq <> p_pmdnseq)
            #    AND pmdlstus = 'N'
            #其他單據上 維護的採購量
            SELECT SUM(pmdn007) INTO l_pmdn007_1 FROM pmdl_t,pmdn_t,pmdp_t
               WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
                 AND pmdnent = pmdpent AND pmdndocno = pmdpdocno 
                 AND pmdnseq = pmdpseq AND pmdnent = g_enterprise 
                 AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004
                 AND (pmdndocno <> p_pmdldocno OR pmdnseq <> p_pmdnseq)
                 AND pmdlstus = 'N'
            IF cl_null(l_pmdn007_1) THEN
               LET l_pmdn007_1 = 0
            END IF
            
            LET l_sum1 = l_pmdp024 - l_pmdn007_1 
            LET l_sum = l_sum + l_sum1
            
            
         END IF
         
      END FOREACH
      
      #IF l_pmdl007 NOT MATCHES '[78]' THEN  #160727-00025#9
      IF l_oobx003 = "apmt400" THEN          #160727-00025#9
         #請采勾稽時，判斷採購的數量 和 容差率的處理
         CALL s_aooi200_get_slip(p_pmdldocno) RETURNING l_success,l_ooba002
         IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0061') = "Y" THEN 
            #大於容差率 時的處理方式
            CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0084') RETURNING l_type
            
            #最大容差率
            CALL cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0085') RETURNING l_rate
            IF l_rate > 0 THEN
               LET l_pmdb006 = (1 + l_rate /100) * l_pmdb006
            END IF   
            
            #新增單據時，就會回寫已轉採購量，此部分要調整不可以大於請購量 - 轉採購量
            #LET l_sum = l_pmdb006 - l_pmdb049 - l_pmdn007_1
            #如果當前單據已經有存在數量，即是在修改狀態下，需要加上當前項次對應的數量再去計算
            SELECT pmdn006,pmdn007 INTO l_pmdn006,l_pmdn007_1 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno AND pmdnseq = p_pmdnseq
            IF cl_null(l_pmdn007_1) THEN
               LET l_pmdn007_1 = 0
            END IF
            
            #add by lixiang 2016/1/21--begin---
            #轉換成當前採購單上的單位對應的數量
            IF l_pmdn006 <> p_pmdn006 AND (NOT cl_null(l_pmdn006)) THEN
               CALL s_aooi250_convert_qty(p_pmdn001,l_pmdn006,p_pmdn006,l_pmdn007_1)
                   RETURNING l_success,l_pmdn007_1
            END IF
            #add by lixiang 2016/1/21--end---
            
            LET l_sum = l_pmdb006 - l_pmdb049 + l_pmdn007_1
                  
            IF r_pmdn007 > l_sum THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00585'
               LET g_errparam.extend = p_pmdn007
               LET g_errparam.popup = TRUE
               CALL cl_err()
               IF l_type = '1' THEN  #拒絕
                  #CALL cl_err_collect_show()
                  LET r_success = FALSE
                  RETURN r_success,r_pmdn007
               END IF
            END IF
         END IF
      END IF
      
      IF l_pmdl007 MATCHES '[78]' THEN
         IF r_pmdn007 > l_sum THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00614'
            LET g_errparam.extend = p_pmdn007
            LET g_errparam.popup = TRUE
            CALL cl_err()
            
            #CALL cl_err_collect_show()
            LET r_success = FALSE
            RETURN r_success,r_pmdn007
         END IF
      END IF  
      
      #160727-00025#9--s
      #如来源是工单時，須檢核不可超過工單總應發數量
      IF l_pmdl007 = '4' AND NOT cl_null(l_pmdl008) THEN
         SELECT DISTINCT pmdp003,pmdp004,pmdp005 INTO l_pmdp003,l_pmdp004,l_pmdp005 FROM pmdp_t
         WHERE pmdpent = g_enterprise
           AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
         
         IF cl_null(l_pmdp003) OR cl_null(l_pmdp004) OR cl_null(l_pmdp005) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'sub-00344'
            LET g_errparam.extend = p_pmdldocno
            LET g_errparam.popup = TRUE
            CALL cl_err()        
            LET r_success = FALSE
            RETURN r_success,r_pmdn007
         END IF   
         
         LET l_sfba013 = 0    
         SELECT sfba013,sfba014 INTO l_sfba013,l_sfba014 
           FROM sfba_t
          WHERE sfbaent = g_enterprise
            AND sfbadocno = l_pmdp003
            AND sfbaseq = l_pmdp004
            AND sfbaseq1 = l_pmdp005
         IF cl_null(l_sfba013) THEN LET l_sfba013 = 0 END IF
         
         IF p_pmdn006 <> l_sfba014 THEN
            CALL s_aooi250_convert_qty(p_pmdn001,l_sfba014,p_pmdn006,l_sfba013)
              RETURNING l_success,l_sfba013
         END IF
   
         LET l_pmdp023 = 0
         SELECT SUM(pmdp023) INTO l_pmdp023
           FROM pmdl_t,pmdn_t,pmdp_t
          WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno
            AND pmdnent = pmdpent AND pmdndocno = pmdpdocno AND pmdnseq = pmdpseq
            AND pmdlstus <> 'X'
            AND (pmdndocno <> p_pmdldocno OR pmdnseq <> p_pmdnseq)
            AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004 AND pmdp005 = l_pmdp005
         
         IF cl_null(l_pmdp023) THEN LET l_pmdp023 = 0 END IF
         IF p_pmdn006 <> l_sfba014 THEN
            CALL s_aooi250_convert_qty(p_pmdn001,l_sfba014,p_pmdn006,l_pmdp023)
              RETURNING l_success,l_sfba013
         END IF
         
         IF l_pmdp023 + p_pmdn007 > l_sfba013 THEN                                   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01125'
            LET g_errparam.extend = p_pmdn007
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success,r_pmdn007
         END IF
      END IF
      #160727-00025#9---e
   END IF
   
   #委外採購數量的判斷
   #IF g_argv[1] = '1' THEN   #160324-00038#39
   IF l_pmdl005 = '2' THEN    #160324-00038#39
      DECLARE sfcb_chk CURSOR FOR 
         SELECT DISTINCT pmdp003,pmdp004,pmdp024 FROM pmdp_t 
               WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
      FOREACH sfcb_chk INTO l_pmdp003,l_pmdp004,l_pmdp024
         #SELECT SUM(pmdp024) INTO l_pmdn007_1
         #   FROM pmdp_t,pmdl_t
         #  WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno
         #    AND pmdpent = g_enterprise AND pmdp003 = l_pmdp003 AND pmdp004 = l_pmdp004
         #    AND (pmdpdocno <> p_pmdldocno OR pmdpseq <> p_pmdnseq)
         #    AND pmdlstus = 'N'
         #IF cl_null(l_pmdn007_1) THEN
         #   LET l_pmdn007_1 = 0
         #END IF
         #可委外數=標準產出數量(sfcb027)+重工轉入(sfcb029)+工單轉入(sfcb030)+分割轉入(sfcb031)+合併轉入(sfcb032)-良品轉出(sfcb033)-重工轉出(sfcb034)-工單轉出(sfcb035)-當站報廢(sfcb036)-當站下線(sfcb037)-分割轉出(sfcb038)-合併轉出(sfcb039)-委外數量(sfcb041)+委外完工數量(sfcb042)
         SELECT (CASE WHEN sfcb027 IS NULL THEN 0 ELSE sfcb027 END),(CASE WHEN sfcb029 IS NULL THEN 0 ELSE sfcb029 END),(CASE WHEN sfcb030 IS NULL THEN 0 ELSE sfcb030 END),
                (CASE WHEN sfcb031 IS NULL THEN 0 ELSE sfcb031 END),(CASE WHEN sfcb032 IS NULL THEN 0 ELSE sfcb032 END),(CASE WHEN sfcb033 IS NULL THEN 0 ELSE sfcb033 END),
                (CASE WHEN sfcb034 IS NULL THEN 0 ELSE sfcb034 END),(CASE WHEN sfcb035 IS NULL THEN 0 ELSE sfcb035 END),(CASE WHEN sfcb036 IS NULL THEN 0 ELSE sfcb036 END),
                (CASE WHEN sfcb037 IS NULL THEN 0 ELSE sfcb037 END),(CASE WHEN sfcb038 IS NULL THEN 0 ELSE sfcb038 END),(CASE WHEN sfcb039 IS NULL THEN 0 ELSE sfcb039 END),
                (CASE WHEN sfcb041 IS NULL THEN 0 ELSE sfcb041 END),(CASE WHEN sfcb042 IS NULL THEN 0 ELSE sfcb042 END)
             INTO l_sfcb027,l_sfcb029,l_sfcb030,l_sfcb031,l_sfcb032,l_sfcb033,l_sfcb034,l_sfcb035,l_sfcb036,l_sfcb037,l_sfcb038,l_sfcb039,l_sfcb041,l_sfcb042
            FROM sfcb_t WHERE sfcbent   = g_enterprise
                          AND sfcbdocno = l_pmdp003
                          AND sfcb001   = l_pmdp004
                          AND ROWNUM = 1
        #LET l_max = l_sfcb027+l_sfcb029+l_sfcb030+l_sfcb031+l_sfcb032-l_sfcb033-l_sfcb034-l_sfcb035-l_sfcb036-l_sfcb037-l_sfcb038-l_sfcb039-l_sfcb041-l_sfcb042   #170123-00058#1 mark
         LET l_max = l_sfcb027+l_sfcb029+l_sfcb030+l_sfcb031+l_sfcb032-l_sfcb033-l_sfcb034-l_sfcb035-l_sfcb036-l_sfcb037-l_sfcb038-l_sfcb039-l_sfcb041             #170123-00058#1 add
         #LET l_max = l_max - l_pmdn007_1 + l_pmdp024 #修改狀態下，需求加上當前已經錄入的數量
         LET l_max = l_max + l_pmdp024
         IF p_pmdn007 > l_max THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'asf-00220'
            LET g_errparam.extend = p_pmdn007
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = l_max
            LET g_errparam.replace[2] = p_pmdn007
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success,r_pmdn007
         END IF
      END FOREACH         
   END IF 

   #重覆性生產的數量判斷
   #IF g_argv[1] = '2' THEN  #160324-00038#39
   IF l_pmdl005 = '5' THEN   #160324-00038#39
      #160602-00002#1---S
      #調用s_asrp400_get_carried_qty之前要先定義cursor
      IF NOT s_asrp400_def_cursor() THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      #160602-00002#1---E
   
      SELECT pmdn007,pmdn014,pmdn006 INTO l_pmdn007,l_pmdn014,l_pmdn006
         FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno AND pmdnseq = p_pmdnseq
      DECLARE srab_chk CURSOR FOR 
         SELECT DISTINCT pmdp012,pmdp007,pmdp008,pmdp009,pmdp010,pmdp011,pmdp024 FROM pmdp_t 
               WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
      FOREACH srab_chk INTO l_pmdp012,l_pmdp007,l_pmdp008,l_pmdp009,l_pmdp010,l_pmdp011,l_pmdp024
         #carrier 这里应该是少了一个"生产计划"的参数
         #从采购单取已经委外的数量
         CALL s_asrp400_get_carried_qty(l_pmdp012,l_pmdp007,l_pmdp008,l_pmdp009,l_pmdp010,l_pmdp011,l_pmdn014,l_pmdn006)
              RETURNING l_qty2
         #計畫日已委外量=找到委外採購單上此項目該日期的已委外量(用到庫日期找)
         #判斷計畫編號在asri001內的委外數量可否超過當日計畫量，如果允許才可輸入超過預設值
         # 1.拒絕 2.警告 3.允许
         SELECT srza006 INTO l_srza006 FROM srza_t WHERE srzaent = g_enterprise AND srzasite = g_site AND srza001 = l_pmdp012
         
         #可錄入的數量
         LET l_max = l_pmdp024 - l_qty2 + l_pmdn007
         IF p_pmdn007 > l_max THEN
            IF l_srza006 = '1' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00802'
               LET g_errparam.extend = p_pmdn007
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_max
               LET g_errparam.replace[2] = p_pmdn007
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success,r_pmdn007
            END IF
            IF l_srza006 = '2' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00802'
               LET g_errparam.extend = p_pmdn007
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] = l_max
               LET g_errparam.replace[2] = p_pmdn007
               CALL cl_err()
               RETURN r_success,r_pmdn007
            END IF
         END IF
         
      END FOREACH
      
   END IF
   #CALL cl_err_collect_show()
      
   RETURN r_success,r_pmdn007
      
END FUNCTION

#產生交期明細匯總檔
PUBLIC FUNCTION s_apmt500_gen_pmdq(p_pmdqdocno,p_pmdqseq)
DEFINE p_pmdqdocno     LIKE pmdq_t.pmdqdocno
DEFINE p_pmdqseq       LIKE pmdq_t.pmdqseq
DEFINE r_success       LIKE type_t.num5
#161124-00048#9 mod-S
#DEFINE l_pmdq          RECORD LIKE pmdq_t.*
#DEFINE l_pmdn          RECORD LIKE pmdn_t.*
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
DEFINE l_pmdn RECORD  #採購單身明細檔
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

       WHENEVER ERROR CONTINUE
       
       LET r_success = TRUE
       #161124-00048#9 mod-S
#       SELECT * INTO l_pmdn.* FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdqdocno AND pmdnseq = p_pmdqseq
       SELECT pmdnent,pmdnsite,pmdnunit,pmdndocno,pmdnseq,
              pmdn001,pmdn002,pmdn003,pmdn004,pmdn005,
              pmdn006,pmdn007,pmdn008,pmdn009,pmdn010,
              pmdn011,pmdn012,pmdn013,pmdn014,pmdn015,
              pmdn016,pmdn017,pmdn019,pmdn020,pmdn021,
              pmdn022,pmdnorga,pmdn023,pmdn024,pmdn025,
              pmdn026,pmdn027,pmdn028,pmdn029,pmdn030,
              pmdn031,pmdn032,pmdn033,pmdn034,pmdn035,
              pmdn036,pmdn037,pmdn038,pmdn039,pmdn040,
              pmdn041,pmdn042,pmdn043,pmdn044,pmdn045,
              pmdn046,pmdn047,pmdn048,pmdn049,pmdn050,
              pmdn051,pmdn052,pmdn053,pmdn200,pmdn201,
              pmdn202,pmdn203,pmdn204,pmdn205,pmdn206,
              pmdn207,pmdn208,pmdn209,pmdn210,pmdn211,
              pmdn212,pmdn213,pmdn214,pmdn215,pmdn216,
              pmdn217,pmdn218,pmdn219,pmdn220,pmdn221,
              pmdn222,pmdn223,pmdn224,pmdn900,pmdn999,
              pmdn225,pmdn054,pmdn055,pmdn056,pmdn057,
              pmdn226,pmdn227,pmdn058,pmdn228
        INTO l_pmdn.*
        FROM pmdn_t 
       WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdqdocno AND pmdnseq = p_pmdqseq
   #161124-00048#9 mod-E
       IF l_pmdn.pmdn024 = 'N' THEN
       
          DELETE FROM pmdq_t WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdqdocno AND pmdqseq = p_pmdqseq
          
          LET l_pmdq.pmdqsite = g_site
          LET l_pmdq.pmdqdocno = p_pmdqdocno
          LET l_pmdq.pmdqseq = p_pmdqseq
          
          #分批序加1
          SELECT MAX(pmdqseq2)+1 INTO l_pmdq.pmdqseq2 FROM pmdq_t
            WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdqdocno AND pmdqseq = p_pmdqseq
          IF cl_null(l_pmdq.pmdqseq2) OR l_pmdq.pmdqseq2 = 0 THEN
             LET l_pmdq.pmdqseq2 = 1
          END IF
          
          LET l_pmdq.pmdq002 = l_pmdn.pmdn007
          LET l_pmdq.pmdq003 = l_pmdn.pmdn012
          LET l_pmdq.pmdq004 = l_pmdn.pmdn013
          LET l_pmdq.pmdq005 = l_pmdn.pmdn014
          
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
       END IF
       
       RETURN r_success
        
END FUNCTION

#必要字段欄位檢查
PUBLIC FUNCTION s_apmt500_conf_fields_chk(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE r_success       LIKE type_t.num5
DEFINE l_pmdl009       LIKE pmdl_t.pmdl009
DEFINE l_pmdl010       LIKE pmdl_t.pmdl010
DEFINE l_pmdl011       LIKE pmdl_t.pmdl011
DEFINE l_pmdl012       LIKE pmdl_t.pmdl012
DEFINE l_pmdl033       LIKE pmdl_t.pmdl033
DEFINE l_pmdl015       LIKE pmdl_t.pmdl015
DEFINE l_pmdl017       LIKE pmdl_t.pmdl017
DEFINE l_pmdl023       LIKE pmdl_t.pmdl023
DEFINE l_pmdl021       LIKE pmdl_t.pmdl021
DEFINE l_pmdl022       LIKE pmdl_t.pmdl022
DEFINE l_pmdl054       LIKE pmdl_t.pmdl054
DEFINE l_pmdl055       LIKE pmdl_t.pmdl055

   LET r_success = TRUE
   
   #CALL cl_err_collect_init()
   
   SELECT pmdl009,pmdl010,pmdl011,pmdl012,pmdl033,pmdl015,pmdl017,pmdl023,pmdl021,pmdl022,pmdl054,pmdl055
     INTO l_pmdl009,l_pmdl010,l_pmdl011,l_pmdl012,l_pmdl033,l_pmdl015,l_pmdl017,l_pmdl023,l_pmdl021,l_pmdl022,l_pmdl054,l_pmdl055
    FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
    
   IF cl_null(l_pmdl009) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00530'  #付款條件不可為空！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00531'  #交易條件不可為空！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl011) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00228'  #稅別不可為空!
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl012) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00636'  #稅率不可為空！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl033) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00576'  #發票類型不可為空!
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl015) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'amm-00164'  #幣別不可為空！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl017) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00226'  #取價方式不可為空!
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   #160621-00003#3 20160728 mark by beckxie---S
   #IF cl_null(l_pmdl023) THEN
   #   INITIALIZE g_errparam TO NULL
   #   LET g_errparam.code = 'apm-00574'  #採購通路不可為空!
   #   LET g_errparam.extend = p_pmdldocno
   #   LET g_errparam.popup = TRUE
   #   CALL cl_err()
   #   LET r_success = FALSE
   #END IF
   #160621-00003#3 20160728 mark by beckxie---E
   IF cl_null(l_pmdl021) OR cl_null(l_pmdl022) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'art-00282'  #供應商欄位不可為空！
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl054) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00575'  #內外購不可為空!
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   IF cl_null(l_pmdl055) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00577'  #匯率計算基礎不可為空!
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   #CALL cl_err_collect_show()
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 檢查/更新信用額度
# Memo...........:
# Usage..........: CALL s_apmt500_credit(p_type,p_pmdldocno)
#                  RETURNING r_success
# Input parameter: p_type         類型1 更新信用餘額檔(正向)2更新信用餘額檔(反向)
#                : p_pmdldocno    採購單號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2014/10/28 By lixiang
# Modify.........: 140703 By polly 調整信用額度元件
################################################################################
PUBLIC FUNCTION s_apmt500_credit(p_type,p_pmdldocno)
DEFINE  p_type        LIKE type_t.num5         #類型：1更新信用餘額檔(正向) 2更新信用餘額檔(反向)
DEFINE  p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE  l_pmdl004     LIKE pmdl_t.pmdl004      #供應商編號
DEFINE  l_pmdl015     LIKE pmdl_t.pmdl015      #幣別   
DEFINE  l_sql         STRING
DEFINE  l_success     LIKE type_t.num5
DEFINE  ls_js        STRING
DEFINE  lc_param  RECORD
           xmab003    LIKE xmab_t.xmab003,
           xmab006    LIKE xmab_t.xmab006,
           xmab007    LIKE xmab_t.xmab007,
           proj       LIKE xmaa_t.xmaa002,
           proj_o     LIKE xmaa_t.xmaa002,
           type       LIKE type_t.num5,
           glaald     LIKE glaa_t.glaald,
           glaacomp   LIKE glaa_t.glaacomp           
                 END RECORD
DEFINE  r_success     LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE

   SELECT pmdl004,pmdl015 
     INTO l_pmdl004,l_pmdl015
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = p_pmdldocno 

   LET lc_param.xmab003 = p_pmdldocno 
   LET lc_param.xmab006 = l_pmdl004
   LET lc_param.xmab007 = l_pmdl015
   LET lc_param.proj    = 'P1'
   LET lc_param.proj_o  = ''  

   CASE p_type
     WHEN '1'   #更新信用額度(正向)
       LET lc_param.type    = '1'
       LET ls_js = util.JSON.stringify(lc_param)
       IF NOT s_credit_move(ls_js) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
     WHEN '2'   #更新信用額度(反向)
       LET lc_param.type    = '2'
       LET ls_js = util.JSON.stringify(lc_param)
       IF NOT s_credit_move(ls_js) THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
   END CASE
   #--150703--polly--mark--(s)
   #DECLARE pmdn_cs CURSOR FOR  
   #   SELECT pmdnorga, SUM(pmdn047) FROM pmdn_t 
   #    WHERE pmdnent = g_enterprise 
   #      AND pmdndocno = p_pmdldocno 
   #   GROUP BY xmdcorga
   #FOREACH pmdn_cs INTO l_site,l_amount
   #   CASE p_type
   #     WHEN '1'   #更新信用額度(正向)            
   #       IF NOT s_credit_upd_xmac(p_pmdldocno,l_pmdl001,l_site,l_pmdl004,l_pmdl015,l_amount,'P1','','1','') THEN
   #          LET r_success = FALSE
   #          RETURN r_success
   #       END IF     
   #     WHEN '-1'  #更新信用額度(反向)   
   #       IF NOT s_credit_upd_xmac(p_pmdldocno,l_pmdl001,l_site,l_pmdl004,l_pmdl015,l_amount,'P1','','-1','') THEN
   #          LET r_success = FALSE
   #          RETURN r_success
   #       END IF 
   #   END CASE            
   #END FOREACH   
   #--150703--polly--mark--(E)
     RETURN r_success
  
END FUNCTION
#在維護料號時需檢核料件AVL控管點(imaa044)設置
PUBLIC FUNCTION s_apmt500_item_avl_chk(p_pmdldocdt,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdl004,p_pmdn007,p_pmdldocno,p_pmdnseq)
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt #單據日期
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004   #供應商編號
DEFINE p_pmdn001     LIKE pmdn_t.pmdn001   #料件編號
DEFINE p_pmdn002     LIKE pmdn_t.pmdn002   #產品特徵
DEFINE p_pmdn004     LIKE pmdn_t.pmdn004   #作業編號
DEFINE p_pmdn005     LIKE pmdn_t.pmdn005   #製程序
DEFINE l_imaa044     LIKE imaa_t.imaa044
DEFINE r_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_n           LIKE type_t.num5
DEFINE l_str         STRING
DEFINE p_pmdn007     LIKE pmdn_t.pmdn007   #add by lixiang 2015/10/15
DEFINE l_bmif017     LIKE bmif_t.bmif017   #add by lixiang 2015/10/15
DEFINE l_bmif015     LIKE bmif_t.bmif015   #add by lixiang 2015/10/15
DEFINE l_bmif016     LIKE bmif_t.bmif016   #add by lixiang 2015/10/15
DEFINE l_pmdn007     LIKE pmdn_t.pmdn007   #add by lixiang 2015/10/15
DEFINE l_bmif007     LIKE bmif_t.bmif007   #add by lixiang 2015/10/15
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno #add by lixiang 2015/12/04
DEFINE p_pmdnseq     LIKE pmdn_t.pmdnseq   #add by lixiang 2015/12/04
DEFINE l_count       LIKE type_t.num5      #add by 161115-00029#2 20161201
DEFINE l_qcap001     LIKE qcap_t.qcap001   #161115-00029#2 add 20161201 
DEFINE l_qcap002     LIKE qcap_t.qcap002   #161115-00029#2 add 20161201 
DEFINE l_qcap003     LIKE qcap_t.qcap003   #161115-00029#2 add 20161201
DEFINE l_qcap004     LIKE qcap_t.qcap004   #161115-00029#2 add 20161201
DEFINE l_qcap005     LIKE qcap_t.qcap005   #161115-00029#2 add 20161201 
   #在維護料號時需檢核料件AVL控管點(imaa044)設置，若是設置'1:可請購，不可採購'時，則要檢核該
   # 料是否有做料件承認abmt410，若沒有則不允許進行請購
   #1-1.檢查若該料有存在abmt410中且請購單據日期落在承認的生失效日期區間內的及算有做過
   #        料件承認
   #1-2.要依據採購供應商判斷是否有做料件承認時需考慮供應商條件
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocdt) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00320'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   IF cl_null(p_pmdn001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00411'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      #RETURN r_success
   END IF
   
   IF cl_null(p_pmdn002) THEN
      LET p_pmdn002 = ' '
   END IF
   
   IF cl_null(p_pmdn007) THEN
      LET p_pmdn007 = 0
   END IF
   
   
   LET l_imaa044 = ''
   SELECT imaa044 INTO l_imaa044 FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = p_pmdn001
   IF l_imaa044 = '1' THEN
      #LET l_sql = " SELECT COUNT(*) FROM bmif_t ",
      #LET l_sql = " SELECT COUNT(*) FROM bmif_t ",
      LET l_sql = " SELECT MAX(bmif017),COUNT(*) FROM bmif_t ",   #取生效日期最大的一筆資料 #add by lixiang 2015/10/15
                  " WHERE bmifent = '",g_enterprise,"' AND bmif001 = '",p_pmdn001,"' AND bmif006 = '1' ", #供應商
                  "   AND bmif012 IS NOT NULL "  #承認文號不可為空
      IF NOT cl_null(p_pmdn002) THEN
         LET l_sql = l_sql , " AND bmif005 = '",p_pmdn002,"' "
      END IF
      IF NOT cl_null(p_pmdn004) THEN
         LET l_sql = l_sql , " AND bmif002 = '",p_pmdn004,"' "
      END IF
      IF NOT cl_null(p_pmdn005) THEN
         LET l_sql = l_sql , " AND bmif003 = '",p_pmdn005,"' "
      END IF
      IF NOT cl_null(p_pmdl004) THEN
         LET l_sql = l_sql , " AND (bmif007 = '",p_pmdl004,"' OR bmif007 = 'ALL') "  #供應商錄入為ALL的資料，代表全部
      END IF
      
      PREPARE bmif_pre FROM l_sql
      EXECUTE bmif_pre INTO l_bmif017,l_n  #add by lixiang 2015/10/15     
      FREE bmif_pre
      IF l_n = 0 OR cl_null(l_n) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00640'  #該料號不存在於料件承認資料檔 中！
         LET g_errparam.extend = p_pmdn001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         #RETURN r_success
      ELSE
         LET l_sql = l_sql , "  AND bmif017 <= '",p_pmdldocdt,"' AND (bmif018 IS NULL OR bmif018 > '",p_pmdldocdt,"') "
         PREPARE bmif_pre2 FROM l_sql
         EXECUTE bmif_pre2 INTO l_bmif017,l_n  #add by lixiang 2015/10/15       
         FREE bmif_pre2
         IF l_n = 0 OR cl_null(l_n) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00641'  #當前單據日期不在料件承認有效日期範圍內！
            LET l_str = p_pmdn001," : ",p_pmdldocdt
            LET g_errparam.extend = l_str
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            #RETURN r_success
         END IF
      END IF
      
      #add by lixiang 2015/10/15--begin--
      #料件承認檢查時，限制數量(bmif015)、限量承認失效日(bmif016)有值時，需加判斷累計數量不可超過限制數量、日期也不可大於失效日
      #取生效日期最近的那筆資料來判斷
      LET l_sql = " SELECT bmif007,bmif015,bmif016 FROM bmif_t ", 
                  " WHERE bmifent = '",g_enterprise,"' AND bmif001 = '",p_pmdn001,"' AND bmif006 = '1' ", #供應商
                  "   AND bmif012 IS NOT NULL "  #承認文號不可為空
      IF NOT cl_null(p_pmdn002) THEN
         LET l_sql = l_sql , " AND bmif005 = '",p_pmdn002,"' "
      END IF
      IF NOT cl_null(p_pmdn004) THEN
         LET l_sql = l_sql , " AND bmif002 = '",p_pmdn004,"' "
      END IF
      IF NOT cl_null(p_pmdn005) THEN
         LET l_sql = l_sql , " AND bmif003 = '",p_pmdn005,"' "
      END IF
      IF NOT cl_null(p_pmdl004) THEN
         LET l_sql = l_sql , " AND (bmif007 = '",p_pmdl004,"' OR bmif007 = 'ALL') "  #供應商錄入為ALL的資料，代表全部
      END IF
      
      LET l_sql = l_sql , "  AND bmif017 <= '",p_pmdldocdt,"' AND (bmif018 IS NULL OR bmif018 > '",p_pmdldocdt,"') ",
                          "  AND bmif017 = '",l_bmif017,"' ",
                          "  AND ROWNUM = 1 "
      PREPARE bmif_pre3 FROM l_sql
      EXECUTE bmif_pre3 INTO l_bmif007,l_bmif015,l_bmif016   
      FREE bmif_pre3
      
      IF l_bmif015 > 0 THEN
         IF l_bmif007 = 'all' OR l_bmif007 = 'ALL' THEN
            SELECT SUM(pmdn007) INTO l_pmdn007 FROM pmdn_t,pmdl_t
               WHERE pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnent = g_enterprise 
                 AND pmdn001 = p_pmdn001 AND (pmdn002 = p_pmdn002 OR pmdn002 is null) 
                 AND (pmdldocno <> p_pmdldocno OR pmdnseq <> p_pmdnseq)  #add by lixiang 2015/12/04
                 AND pmdlstus <> 'X'
         ELSE
            SELECT SUM(pmdn007) INTO l_pmdn007 FROM pmdn_t,pmdl_t
               WHERE pmdnent = pmdlent AND pmdndocno = pmdldocno AND pmdnent = g_enterprise 
                 AND pmdn001 = p_pmdn001 AND (pmdn002 = p_pmdn002 OR pmdn002 is null) 
                 AND (pmdldocno <> p_pmdldocno OR pmdnseq <> p_pmdnseq)  #add by lixiang 2015/12/04
                 AND pmdlstus <> 'X'
                 AND pmdl004 = l_bmif007
         END IF
         IF cl_null(l_pmdn007) THEN
            LET l_pmdn007 = 0
         END IF
         IF l_pmdn007 + p_pmdn007 > l_bmif015 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01005'  #料號的請購總數量超出料件承認資料中生效日期為：%1的現在數量！
            LET g_errparam.extend = p_pmdn001
            LET g_errparam.replace[1] = l_bmif017
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         IF p_pmdldocdt > l_bmif016 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-01006'  #請購日期不在料件承認資料的限量承認日期 %1 範圍內！
            LET g_errparam.extend = p_pmdldocdt
            LET g_errparam.replace[1] = l_bmif016
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      #add by lixiang 2015/10/15---end---
   END IF
   #161115-00029#2 add(s) 20161201   判断料件+供应商+作业编号+作业序+产品特征 是否存在aqci050 检验程度为'X' 除名中
   LET l_qcap001 = p_pmdn001  #料件编号
   LET l_qcap002 = p_pmdl004  #供应商编号
   LET l_qcap003 = p_pmdn004  #作業編號
   LET l_qcap004 = p_pmdn005  #製程序
   LET l_qcap005 = p_pmdn002  #产品特征
   IF cl_null(l_qcap003) THEN
      LET l_qcap003 = 'ALL'
   END IF
   IF cl_null(l_qcap004) THEN
      LET l_qcap004 = 0
   END IF
   IF cl_null(l_qcap005) THEN
      LET l_qcap005 = 'ALL'
   END IF
   LET l_count = 0
   SELECT COUNT(*) INTO l_count
     FROM qcap_t 
    WHERE qcapent = g_enterprise
      AND qcapsite = g_site
      AND qcap001 = l_qcap001  #料件編號
      AND qcap002 = l_qcap002  #供應商編號
      AND qcap003 = l_qcap003  #作業編號
      AND qcap004 = l_qcap004  #製程序
      AND qcap005 = l_qcap005  #產品特徵
      AND qcap007 = 'X'
      AND qcap006 = 'Y'
   IF l_count > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-01139'  
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.replace[1] = l_qcap001
      LET g_errparam.replace[2] = l_qcap002
      LET g_errparam.replace[3] = l_qcap003
      LET g_errparam.replace[4] = l_qcap004
      LET g_errparam.replace[5] = l_qcap005
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
   #161115-00029#2 add(e) 20161201
   RETURN r_success
   
END FUNCTION

#更新採購對應請購單的已轉採購量
PUBLIC FUNCTION s_apmt500_upd_pmdb049(p_pmdldocno,p_pmdnseq,p_type)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq       LIKE pmdn_t.pmdnseq
DEFINE p_type          LIKE type_t.chr1   #1.增加已轉採購量 -1.減去已轉採購量
DEFINE l_pmdp003       LIKE pmdp_t.pmdp003
DEFINE l_pmdp004       LIKE pmdp_t.pmdp004
DEFINE l_pmdn007       LIKE pmdn_t.pmdn007
DEFINE r_success       LIKE type_t.num5
DEFINE l_pmdb049       LIKE pmdb_t.pmdb049

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) OR cl_null(p_pmdnseq) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #更新請購單的已轉採購數量:
   #1.依據採購關聯單據明細的資料回頭更新對應的請購單的已轉採購量，
   #更新公式如下:[C:已轉採購量] = [C:已轉採購量] + pmdp023
   LET l_pmdp003 = ''
   LET l_pmdp004 = ''
   LET l_pmdn007 = 0
   DECLARE upd_pmdb_cur CURSOR FOR 
     SELECT pmdp023,pmdp003,pmdp004
       FROM pmdp_t
      WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
   FOREACH upd_pmdb_cur INTO l_pmdn007,l_pmdp003,l_pmdp004
      IF cl_null(l_pmdn007) THEN
         LET l_pmdn007 = 0
      END IF
      IF p_type = '1' THEN
         UPDATE pmdb_t SET pmdb049 = (CASE WHEN pmdb049 IS NULL THEN 0 ELSE pmdb049 END) + l_pmdn007
            WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
      ELSE
         SELECT pmdb049 INTO l_pmdb049 FROM pmdb_t WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
         IF l_pmdb049 < l_pmdn007 THEN
            LET l_pmdb049 = 0
         ELSE
            LET l_pmdb049 = l_pmdb049 - l_pmdn007
         END IF
         #UPDATE pmdb_t SET pmdb049 = (CASE WHEN pmdb049 IS NULL THEN 0 ELSE pmdb049 END) - l_pmdn007
         UPDATE pmdb_t SET pmdb049 = l_pmdb049
            WHERE pmdbent = g_enterprise AND pmdbdocno = l_pmdp003 AND pmdbseq = l_pmdp004
      END IF
      IF SQLCA.sqlcode THEN
         LET r_success = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "pmdb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END FOREACH
   RETURN r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業留置前檢核
# Memo...........:
# Usage..........: CALL s_apmt500_hold_chk(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdadocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/12/29 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_hold_chk(p_pmdldocno)
DEFINE p_pmdldocno       LIKE pmdl_t.pmdldocno
DEFINE l_pmdlstus        LIKE pmdl_t.pmdlstus
DEFINE l_n               LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5 

   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_pmdlstus = ''
   SELECT pmdlstus INTO l_pmdlstus FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF l_pmdlstus = 'N' THEN
      #此筆資料未確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00180'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_pmdlstus = 'X' THEN
      #此筆資料已經作廢;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Memo...........: 採購單維護作業留置
# Usage..........: CALL s_apmt500_hold_upd(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdadocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/12/29 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_hold_upd(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE l_pmdl043       LIKE pmdl_t.pmdl043   #留置原因
DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #更新單據狀態碼
   UPDATE pmdl_t SET pmdlstus = 'H'
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #將單頭的狀態碼與單身的行狀態碼更新為留置狀態，並將單頭的留置原因碼更新到單身的留置/結案理由碼欄位
   SELECT pmdl043 INTO l_pmdl043 FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   UPDATE pmdn_t SET pmdn045 = '5',
                     pmdn051 = l_pmdl043
               WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   RETURN  r_success
   
END FUNCTION
################################################################################
# Descriptions...: 採購單維護作業取消留置前檢核
# Memo...........:
# Usage..........: CALL s_apmtt00_unhold_chk(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdadocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/12/29 By lixiang
# Modify.........:
###################################################################################################################################################
PUBLIC FUNCTION s_apmt500_unhold_chk(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE l_pmdlstus      LIKE pmdl_t.pmdlstus
DEFINE r_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_pmdlstus = ''
   SELECT pmdlstus INTO l_pmdlstus FROM pmdl_t 
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF l_pmdlstus = 'Y' THEN
      #此筆資料已經確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00178'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   IF l_pmdlstus = 'X' THEN
      #此筆資料已經作廢;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00229'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF l_pmdlstus = 'N' THEN
      #此筆資料未確認;請確認狀態碼!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00180'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
END FUNCTION
################################################################################
# Memo...........: 採購單維護作業取消留置
# Usage..........: CALL s_apmt500_unhold_upd(p_pmdldocno) RETURNING r_success
# Input parameter: p_pmdadocno  單據編號
# Return code....: r_success   TRUE/FALSE
# Date & Author..: 14/12/29 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_unhold_upd(p_pmdldocno)
DEFINE p_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   IF cl_null(p_pmdldocno) THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   #更新單據狀態碼
   UPDATE pmdl_t SET pmdlstus = 'Y',pmdl043 = ''
      WHERE pmdlent = g_enterprise AND pmdldocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #執行取消留置時將單頭與單身的留置理由碼更新為NULL，並將單頭狀態更新為確認狀態，單身的狀態更新為"1.一般"
   UPDATE pmdn_t SET pmdn045 = '1',
                     pmdn051 = ''
               WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00034'
      LET g_errparam.extend = p_pmdldocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   RETURN  r_success
   
END FUNCTION

################################################################################
# Descriptions...: 取单别的默认设置值
# Memo...........:
# Usage..........: CALL s_apmt500_get_doc_default(p_pmdl)
#                       RETURNING r_pmdl
# Input parameter: p_pmdl         单头传入值
# Return code....: r_pmdl         单头默认值
# Date & Author..: 2015-05-13 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_doc_default(p_pmdl)
   #161124-00048#9 mod-S
#   DEFINE p_pmdl          RECORD LIKE pmdl_t.*
#   DEFINE r_pmdl          RECORD LIKE pmdl_t.*
   DEFINE p_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   DEFINE r_pmdl RECORD  #採購單頭檔
          pmdlent LIKE pmdl_t.pmdlent, #企业编号
          pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
          pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
          pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
          pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
          pmdl001 LIKE pmdl_t.pmdl001, #版次
          pmdl002 LIKE pmdl_t.pmdl002, #采购人员
          pmdl003 LIKE pmdl_t.pmdl003, #采购部门
          pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
          pmdl005 LIKE pmdl_t.pmdl005, #采购性质
          pmdl006 LIKE pmdl_t.pmdl006, #多角性质
          pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
          pmdl008 LIKE pmdl_t.pmdl008, #来源单号
          pmdl009 LIKE pmdl_t.pmdl009, #付款条件
          pmdl010 LIKE pmdl_t.pmdl010, #交易条件
          pmdl011 LIKE pmdl_t.pmdl011, #税种
          pmdl012 LIKE pmdl_t.pmdl012, #税率
          pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
          pmdl015 LIKE pmdl_t.pmdl015, #币种
          pmdl016 LIKE pmdl_t.pmdl016, #汇率
          pmdl017 LIKE pmdl_t.pmdl017, #取价方式
          pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
          pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
          pmdl020 LIKE pmdl_t.pmdl020, #运送方式
          pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
          pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
          pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
          pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
          pmdl025 LIKE pmdl_t.pmdl025, #送货地址
          pmdl026 LIKE pmdl_t.pmdl026, #账款地址
          pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
          pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
          pmdl029 LIKE pmdl_t.pmdl029, #收货部门
          pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
          pmdl031 LIKE pmdl_t.pmdl031, #多角序号
          pmdl032 LIKE pmdl_t.pmdl032, #最终客户
          pmdl033 LIKE pmdl_t.pmdl033, #发票类型
          pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
          pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
          pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
          pmdl043 LIKE pmdl_t.pmdl043, #留置原因
          pmdl044 LIKE pmdl_t.pmdl044, #备注
          pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
          pmdl047 LIKE pmdl_t.pmdl047, #物流结案
          pmdl048 LIKE pmdl_t.pmdl048, #账流结案
          pmdl049 LIKE pmdl_t.pmdl049, #金流结案
          pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
          pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
          pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
          pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
          pmdl054 LIKE pmdl_t.pmdl054, #内外购
          pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
          pmdl200 LIKE pmdl_t.pmdl200, #采购中心
          pmdl201 LIKE pmdl_t.pmdl201, #联络电话
          pmdl202 LIKE pmdl_t.pmdl202, #传真号码
          pmdl203 LIKE pmdl_t.pmdl203, #采购方式
          pmdl204 LIKE pmdl_t.pmdl204, #配送中心
          pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
          pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
          pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
          pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
          pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
          pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
          pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
          pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
          pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
          pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
          pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
          pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
          pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
          pmdlstus LIKE pmdl_t.pmdlstus, #状态码
          pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
          pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
          pmdl207 LIKE pmdl_t.pmdl207, #所属品类
          pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
   END RECORD
   #161124-00048#9 mod-E
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_doc_type      STRING
   
   CALL s_aooi200_get_slip(p_pmdl.pmdldocno)
        RETURNING l_success,l_doc_type

   LET p_pmdl.pmdldocdt = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdldocdt',p_pmdl.pmdldocdt)
   LET p_pmdl.pmdl001   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl001',p_pmdl.pmdl001)
   LET p_pmdl.pmdl002   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl002',p_pmdl.pmdl002)
   LET p_pmdl.pmdl003   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl003',p_pmdl.pmdl003)
   LET p_pmdl.pmdl004   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl004',p_pmdl.pmdl004)
   LET p_pmdl.pmdl005   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl005',p_pmdl.pmdl005)
   LET p_pmdl.pmdl006   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl006',p_pmdl.pmdl006)
   LET p_pmdl.pmdl007   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl007',p_pmdl.pmdl007)
   LET p_pmdl.pmdl008   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl008',p_pmdl.pmdl008)
   LET p_pmdl.pmdl009   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl009',p_pmdl.pmdl009)
   LET p_pmdl.pmdl010   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl010',p_pmdl.pmdl010)
   LET p_pmdl.pmdl011   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl011',p_pmdl.pmdl011)
   LET p_pmdl.pmdl012   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl012',p_pmdl.pmdl012)
   LET p_pmdl.pmdl013   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl013',p_pmdl.pmdl013)
   LET p_pmdl.pmdl015   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl015',p_pmdl.pmdl015)
   LET p_pmdl.pmdl016   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl016',p_pmdl.pmdl016)
   LET p_pmdl.pmdl017   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl017',p_pmdl.pmdl017)
   LET p_pmdl.pmdl018   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl018',p_pmdl.pmdl018)
   LET p_pmdl.pmdl019   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl019',p_pmdl.pmdl019)
   LET p_pmdl.pmdl020   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl020',p_pmdl.pmdl020)
   LET p_pmdl.pmdl021   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl021',p_pmdl.pmdl021)
   LET p_pmdl.pmdl022   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl022',p_pmdl.pmdl022)
   LET p_pmdl.pmdl023   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl023',p_pmdl.pmdl023)
   LET p_pmdl.pmdl024   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl024',p_pmdl.pmdl024)
   LET p_pmdl.pmdl025   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl025',p_pmdl.pmdl025)
   LET p_pmdl.pmdl026   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl026',p_pmdl.pmdl026)
   LET p_pmdl.pmdl027   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl027',p_pmdl.pmdl027)
   LET p_pmdl.pmdl028   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl028',p_pmdl.pmdl028)
   LET p_pmdl.pmdl029   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl029',p_pmdl.pmdl029)
   LET p_pmdl.pmdl030   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl030',p_pmdl.pmdl030)
   LET p_pmdl.pmdl031   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl031',p_pmdl.pmdl031)
   LET p_pmdl.pmdl032   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl032',p_pmdl.pmdl032)
   LET p_pmdl.pmdl033   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl033',p_pmdl.pmdl033)
   LET p_pmdl.pmdl040   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl040',p_pmdl.pmdl040)
   LET p_pmdl.pmdl041   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl041',p_pmdl.pmdl041)
   LET p_pmdl.pmdl042   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl042',p_pmdl.pmdl042)
   LET p_pmdl.pmdl043   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl043',p_pmdl.pmdl043)
   LET p_pmdl.pmdl044   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl044',p_pmdl.pmdl044)
   LET p_pmdl.pmdl046   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl046',p_pmdl.pmdl046)
   LET p_pmdl.pmdl047   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl047',p_pmdl.pmdl047)
   LET p_pmdl.pmdl048   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl048',p_pmdl.pmdl048)
   LET p_pmdl.pmdl049   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl049',p_pmdl.pmdl049)
   LET p_pmdl.pmdl050   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl050',p_pmdl.pmdl050)
   LET p_pmdl.pmdl051   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl051',p_pmdl.pmdl051)
   LET p_pmdl.pmdl052   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl052',p_pmdl.pmdl052)
   LET p_pmdl.pmdl053   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl053',p_pmdl.pmdl053)
   LET p_pmdl.pmdl054   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl054',p_pmdl.pmdl054)
   LET p_pmdl.pmdl055   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl055',p_pmdl.pmdl055)
   LET p_pmdl.pmdl200   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl200',p_pmdl.pmdl200)
   LET p_pmdl.pmdl201   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl201',p_pmdl.pmdl201)
   LET p_pmdl.pmdl202   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl202',p_pmdl.pmdl202)
   LET p_pmdl.pmdl203   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl203',p_pmdl.pmdl203)
   LET p_pmdl.pmdl204   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl204',p_pmdl.pmdl204)
   LET p_pmdl.pmdl900   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl900',p_pmdl.pmdl900)
   LET p_pmdl.pmdl999   = s_aooi200_get_doc_default(g_site,'1',l_doc_type,'pmdl999',p_pmdl.pmdl999)

   LET r_pmdl.* = p_pmdl.*
   RETURN r_pmdl.*
   
END FUNCTION
################################################################################
# Descriptions...: 取參考價格
# Memo...........: 由主件單價(pmdn015)依據據點參數設置-S-BAS-0022的推算比率計算1.依標準成本2.最近採購單價
# Usage..........: CALL s_apmt500_get_pmdo022(p_type,p_bmba003,p_inam002)
#                  RETURNING r_success,r_pmdo022
# Input parameter: p_type         1：成本價格2：最近採購價格   
#                : p_bmba003      料件
#                : p_inam002      產品特徵
# Return code....: r_success      TRUE/FALSE
# Return code....: r_pmdo022      價格
# Date & Author..: 2015/06/10 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_pmdo022(p_type,p_bmba003,p_inam002)
   
   DEFINE p_type        LIKE type_t.num5
   DEFINE p_bmba003     LIKE bmba_t.bmba003
   DEFINE p_inam002     LIKE inam_t.inam002
   DEFINE l_pmaw013     LIKE pmaw_t.pmaw013
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_pmdo022     LIKE pmdo_t.pmdo022
   
   
   LET r_success = TRUE
   
   IF p_type = '1' THEN
      #抓取料件主檔計價單位
      LET l_pmaw013 = ''      
      SELECT imaf113 INTO l_pmaw013
        FROM imaf_t
       WHERE imafent = g_enterprise 
         AND imafsite = g_site 
         AND imaf001 = p_bmba003     
      LET r_pmdo022 = ''
      SELECT pmaw019 INTO r_pmdo022
        FROM pmaw_t
       WHERE pmawent = g_enterprise
         AND pmaw001 = g_pmaw001
         AND pmaw002 = g_pmdl015
         AND pmaw011 = p_bmba003
         AND pmaw012 = p_inam002
         AND pmaw013 = l_pmaw013          
      IF cl_null(r_pmdo022) THEN 
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = 'axm-00608'  #160222-00022#1 mark
         LET g_errparam.code = 'apm-01090'   #160222-00022#1 add
         LET g_errparam.extend = p_bmba003
         LET g_errparam.popup = TRUE
         CALL cl_err()             
         LET r_success = FALSE
         RETURN r_success,0                 
      END IF    
   ELSE
     #SELECT imai211 INTO r_pmdo022         #160323-00011#1 mark
      SELECT imai021 INTO r_pmdo022         #160323-00011#1 add
        FROM imai_t
       WHERE imaient = g_enterprise
         AND imaisite = g_site
         AND imai001 = p_bmba003
      IF cl_null(r_pmdo022) THEN 
         INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = 'axm-00609'  #160222-00021#1 mark
         LET g_errparam.code = 'apm-01089'   #160222-00021#1 add
         LET g_errparam.extend = p_bmba003
         LET g_errparam.popup = TRUE
         CALL cl_err()             
         LET r_success = FALSE
         RETURN r_success,0                  
      END IF         
   END IF
   RETURN r_success,r_pmdo022
   
END FUNCTION
################################################################################
# Descriptions...: 取得未稅金額、含稅金額、稅額
# Memo...........: 單純計算金額，不寫入xrcd檔
# Usage..........: CALL s_apmt500_get_amount_2(p_pmdn011,p_pmdn015,p_pmdn016,p_pmdl015,p_pmdl016)
#                  RETURNING r_pmdn046,r_pmdn047,r_pmdn048
# Input parameter: p_pmdn011      計價數量
#                : p_pmdn015      單價
#                : p_pmdn016      稅別
#                : p_pmdl015      幣別
#                : p_pmdl016      匯率
# Return code....: r_pmdn046      未稅金額
#                : r_pmdn047      含稅金額
#                : r_pmdn048      稅額
# Date & Author..: 2015/06/08 By  lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_amount_2(p_pmdn011,p_pmdn015,p_pmdn016,p_pmdl015,p_pmdl016)
DEFINE p_pmdn011         LIKE pmdn_t.pmdn011
DEFINE p_pmdn015         LIKE pmdn_t.pmdn015
DEFINE p_pmdn016         LIKE pmdn_t.pmdn016
DEFINE p_pmdl015         LIKE pmdl_t.pmdl015
DEFINE p_pmdl016         LIKE pmdl_t.pmdl016
DEFINE r_pmdn046         LIKE pmdn_t.pmdn046
DEFINE r_pmdn047         LIKE pmdn_t.pmdn047
DEFINE r_pmdn048         LIKE pmdn_t.pmdn048
DEFINE l_money           LIKE pmdn_t.pmdn046
DEFINE l_xrcd113         LIKE xrcd_t.xrcd113
DEFINE l_xrcd114         LIKE xrcd_t.xrcd114
DEFINE l_xrcd115         LIKE xrcd_t.xrcd115

   WHENEVER ERROR CONTINUE
   
   LET r_pmdn046 = 0
   LET r_pmdn047 = 0
   LET r_pmdn048 = 0

   IF cl_null(p_pmdn011) OR
      cl_null(p_pmdn015) OR cl_null(p_pmdn016) THEN
      RETURN r_pmdn046,r_pmdn047,r_pmdn048
   END IF

   LET l_money = p_pmdn011 * p_pmdn015
   CALL s_tax_count(g_site,p_pmdn016,l_money,p_pmdn011,p_pmdl015,p_pmdl016)
     RETURNING r_pmdn046,r_pmdn048,r_pmdn047,l_xrcd113,l_xrcd114,l_xrcd115

   IF cl_null(r_pmdn046) THEN LET r_pmdn046 = 0 END IF
   IF cl_null(r_pmdn047) THEN LET r_pmdn047 = 0 END IF
   IF cl_null(r_pmdn048) THEN LET r_pmdn048 = 0 END IF

   RETURN r_pmdn046,r_pmdn047,r_pmdn048
   
END FUNCTION
################################################################################
# Descriptions...: 取得料件BOM相關資料
# Memo...........:
# Usage..........: CALL s_apmt500_get_bmba(p_bmba001,p_bmba002,p_bmba003,p_bmba004,p_bmba005,p_bmba007,p_bmba008)
#                  RETURNING r_bmba010
# Input parameter: p_bmba001     主件料號
#                : p_bmba002     特性
#                : p_bmba003     元件料號
#                : p_bmba004     部位編號
#                : p_bmba005     生效日期時間
#                : p_bmba007     作業編號
#                : p_bmba008     作業序
# Return code....: r_bmba010     發料單位
# Date & Author..: 2015/06/10 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_get_bmba(p_bmba001,p_bmba002,p_bmba003,p_bmba004,p_bmba005,p_bmba007,p_bmba008)
  DEFINE p_bmba001     LIKE bmba_t.bmba001
  DEFINE p_bmba002     LIKE bmba_t.bmba002
  DEFINE p_bmba003     LIKE bmba_t.bmba003
  DEFINE p_bmba004     LIKE bmba_t.bmba004
  DEFINE p_bmba005     LIKE bmba_t.bmba005
  DEFINE p_bmba007     LIKE bmba_t.bmba007
  DEFINE p_bmba008     LIKE bmba_t.bmba008  
  DEFINE l_sql         STRING  
  DEFINE r_bmba010     LIKE bmba_t.bmba010
  DEFINE r_bmba020     LIKE bmba_t.bmba020
  DEFINE r_bmba025     LIKE bmba_t.bmba025  
  
    LET l_sql = " SELECT bmba010,bmba020,bmba025 FROM bmba_t ",
                "  WHERE bmbaent='",g_enterprise,"' ",
                "    AND bmbasite='",g_site,"'",
                "    AND bmba001='",p_bmba001,"' ",
                "    AND bmba002='",p_bmba002,"' ",
                "    AND bmba003='",p_bmba003,"' ",
                "    AND bmba004='",p_bmba004,"' ",
                "    AND bmba007='",p_bmba007,"' ",
                "    AND bmba008='",p_bmba008,"' ", 
                "    AND to_char(bmba005,'yyyy-mm-dd hh24:mi:ss')='",p_bmba005,"' "
    PREPARE s_axmt500_bmba_pre FROM l_sql
    EXECUTE s_axmt500_bmba_pre INTO r_bmba010,r_bmba020,r_bmba025
    
  
    RETURN r_bmba010,r_bmba020,r_bmba025
  
END FUNCTION
################################################################################
# Descriptions...: 請購料與採購料是否存在據BOM替代檔中(abmm217)中
# Memo...........: 
# Usage..........: CALL s_apmt500_chk_bom_replace(p_bmea003,p_bmea008,p_bmea019)
#                  RETURNING r_success
# Input parameter: p_bmea003     元件料號
#                : p_bmea008     替代料號
#                : p_bmea019     替代料號產品特徵
# Return code....: r_success     TRUE有/FALSE没有
# Date & Author..: 2015/07/16 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_chk_bom_replace(p_bmea003,p_bmea008,p_bmea019)
DEFINE p_bmea003    LIKE bmea_t.bmea003
DEFINE p_bmea008    LIKE bmea_t.bmea008
DEFINE p_bmea019    LIKE bmea_t.bmea019
DEFINE r_success    LIKE type_t.num5
DEFINE l_n          LIKE type_t.num5
DEFINE l_sql        STRING

     LET r_success = TRUE
     
     IF cl_null(p_bmea003) OR cl_null(p_bmea008) THEN
        #該料件編號不存在有效的BOM替代關係！
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'sub-00411'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        RETURN r_success
     END IF
     
     IF cl_null(p_bmea019) THEN
        LET p_bmea019 = ' '
     END IF
     
     #檢核請購料與採購料是否存在據BOM替代檔中(abmm217)中，檢核BOM替代檔時需考慮bmea007='2'的資料才可以
     #取替代的生失效日期須介於today的資料才允許
     #不須考慮主件，只要存在替代檔即可
     LET l_n = 0 
     LET l_sql = " SELECT COUNT(*) FROM bmea_t ",
                 " WHERE bmeaent = ",g_enterprise,
                 "   AND bmeasite = '",g_site,"' ",
                 "   AND bmea003 = '",p_bmea003,"' ",  #元件编号
                 "   AND bmea008 = '",p_bmea008,"' ",  #替代料號
                 "   AND bmea007 = '2' ",
                 "   AND bmea009<= '",g_today,"' ",
                 "   AND (bmea010 > '",g_today,"'  OR bmea010 IS NULL ) "
     IF NOT cl_null(p_bmea019) THEN
        LET l_sql = l_sql , " AND (CASE WHEN bmea019 IS NULL THEN ' ' ELSE bmea019 END) = '",p_bmea019,"' "
     END IF
     
     PREPARE get_bmea FROM l_sql
     EXECUTE get_bmea INTO l_n
     FREE get_bmea
      
     IF l_n = 0 OR cl_null(l_n) THEN
        #該料件編號不存在有效的BOM替代關係！
        INITIALIZE g_errparam TO NULL
        LET g_errparam.code = 'apm-00974'
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET r_success = FALSE
        RETURN r_success
     END IF
     
     RETURN r_success
     
END FUNCTION
################################################################################
# Descriptions...: 科目預算的處理
# Memo...........:
# Usage..........: CALL s_apmt500_stus_abg(p_pmdndocno,p_pmdnseq,p_act)
#                  RETURNING r_success,r_errno
# Input parameter: p_pmdndocno   採購單號
#                : p_pmdnseq     採購單項次
#                : p_act         I.新增
#                                U.修改
#                                D.刪除
#                                Y.確認
#                                N.取消確認
# Return code....: r_success     TRUE/FALSE
#                : r_errno       錯誤訊息
# Date & Author..: 2015/08/26 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_stus_abg(p_pmdndocno,p_pmdnseq,p_act)
DEFINE p_pmdndocno        LIKE pmdn_t.pmdndocno
DEFINE p_pmdnseq          LIKE pmdn_t.pmdnseq
DEFINE p_act              LIKE type_t.chr10
DEFINE r_success          LIKE type_t.num5
DEFINE r_errno            LIKE gzze_t.gzze001
DEFINE l_success          LIKE type_t.num5 
DEFINE l_slip             LIKE pmda_t.pmdadocno
#161124-00048#9 mod-S
#DEFINE l_pmdl             RECORD LIKE pmdl_t.*
#DEFINE l_pmdn             RECORD LIKE pmdn_t.*
DEFINE l_pmdl RECORD  #採購單頭檔
       pmdlent LIKE pmdl_t.pmdlent, #企业编号
       pmdlsite LIKE pmdl_t.pmdlsite, #营运据点
       pmdlunit LIKE pmdl_t.pmdlunit, #应用组织
       pmdldocno LIKE pmdl_t.pmdldocno, #采购单号
       pmdldocdt LIKE pmdl_t.pmdldocdt, #采购日期
       pmdl001 LIKE pmdl_t.pmdl001, #版次
       pmdl002 LIKE pmdl_t.pmdl002, #采购人员
       pmdl003 LIKE pmdl_t.pmdl003, #采购部门
       pmdl004 LIKE pmdl_t.pmdl004, #供应商编号
       pmdl005 LIKE pmdl_t.pmdl005, #采购性质
       pmdl006 LIKE pmdl_t.pmdl006, #多角性质
       pmdl007 LIKE pmdl_t.pmdl007, #数据源类型
       pmdl008 LIKE pmdl_t.pmdl008, #来源单号
       pmdl009 LIKE pmdl_t.pmdl009, #付款条件
       pmdl010 LIKE pmdl_t.pmdl010, #交易条件
       pmdl011 LIKE pmdl_t.pmdl011, #税种
       pmdl012 LIKE pmdl_t.pmdl012, #税率
       pmdl013 LIKE pmdl_t.pmdl013, #单价含税否
       pmdl015 LIKE pmdl_t.pmdl015, #币种
       pmdl016 LIKE pmdl_t.pmdl016, #汇率
       pmdl017 LIKE pmdl_t.pmdl017, #取价方式
       pmdl018 LIKE pmdl_t.pmdl018, #付款优惠条件
       pmdl019 LIKE pmdl_t.pmdl019, #纳入APS计算
       pmdl020 LIKE pmdl_t.pmdl020, #运送方式
       pmdl021 LIKE pmdl_t.pmdl021, #付款供应商
       pmdl022 LIKE pmdl_t.pmdl022, #送货供应商
       pmdl023 LIKE pmdl_t.pmdl023, #采购分类一
       pmdl024 LIKE pmdl_t.pmdl024, #采购分类二
       pmdl025 LIKE pmdl_t.pmdl025, #送货地址
       pmdl026 LIKE pmdl_t.pmdl026, #账款地址
       pmdl027 LIKE pmdl_t.pmdl027, #供应商连络人
       pmdl028 LIKE pmdl_t.pmdl028, #一次性交易对象识别码
       pmdl029 LIKE pmdl_t.pmdl029, #收货部门
       pmdl030 LIKE pmdl_t.pmdl030, #多角贸易已抛转
       pmdl031 LIKE pmdl_t.pmdl031, #多角序号
       pmdl032 LIKE pmdl_t.pmdl032, #最终客户
       pmdl033 LIKE pmdl_t.pmdl033, #发票类型
       pmdl040 LIKE pmdl_t.pmdl040, #采购总税前金额
       pmdl041 LIKE pmdl_t.pmdl041, #采购总含税金额
       pmdl042 LIKE pmdl_t.pmdl042, #采购总税额
       pmdl043 LIKE pmdl_t.pmdl043, #留置原因
       pmdl044 LIKE pmdl_t.pmdl044, #备注
       pmdl046 LIKE pmdl_t.pmdl046, #预付款发票开立方式
       pmdl047 LIKE pmdl_t.pmdl047, #物流结案
       pmdl048 LIKE pmdl_t.pmdl048, #账流结案
       pmdl049 LIKE pmdl_t.pmdl049, #金流结案
       pmdl050 LIKE pmdl_t.pmdl050, #多角最终站否
       pmdl051 LIKE pmdl_t.pmdl051, #多角流程编号
       pmdl052 LIKE pmdl_t.pmdl052, #最终供应商
       pmdl053 LIKE pmdl_t.pmdl053, #两角目的据点
       pmdl054 LIKE pmdl_t.pmdl054, #内外购
       pmdl055 LIKE pmdl_t.pmdl055, #汇率计算基准
       pmdl200 LIKE pmdl_t.pmdl200, #采购中心
       pmdl201 LIKE pmdl_t.pmdl201, #联络电话
       pmdl202 LIKE pmdl_t.pmdl202, #传真号码
       pmdl203 LIKE pmdl_t.pmdl203, #采购方式
       pmdl204 LIKE pmdl_t.pmdl204, #配送中心
       pmdl900 LIKE pmdl_t.pmdl900, #保留字段str
       pmdl999 LIKE pmdl_t.pmdl999, #保留字段end
       pmdlownid LIKE pmdl_t.pmdlownid, #资料所有者
       pmdlowndp LIKE pmdl_t.pmdlowndp, #资料所有部门
       pmdlcrtid LIKE pmdl_t.pmdlcrtid, #资料录入者
       pmdlcrtdp LIKE pmdl_t.pmdlcrtdp, #资料录入部门
       pmdlcrtdt LIKE pmdl_t.pmdlcrtdt, #资料创建日
       pmdlmodid LIKE pmdl_t.pmdlmodid, #资料更改者
       pmdlmoddt LIKE pmdl_t.pmdlmoddt, #最近更改日
       pmdlcnfid LIKE pmdl_t.pmdlcnfid, #资料审核者
       pmdlcnfdt LIKE pmdl_t.pmdlcnfdt, #数据审核日
       pmdlpstid LIKE pmdl_t.pmdlpstid, #资料过账者
       pmdlpstdt LIKE pmdl_t.pmdlpstdt, #资料过账日
       pmdlstus LIKE pmdl_t.pmdlstus, #状态码
       pmdl205 LIKE pmdl_t.pmdl205, #采购最终有效日
       pmdl206 LIKE pmdl_t.pmdl206, #长效期订单否
       pmdl207 LIKE pmdl_t.pmdl207, #所属品类
       pmdl208 LIKE pmdl_t.pmdl208  #电子采购单号
END RECORD
DEFINE l_pmdn RECORD  #採購單身明細檔
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
DEFINE l_imaa009          LIKE imaa_t.imaa009
DEFINE l_tran             RECORD
         act              LIKE type_t.chr10,   #[1].chr 動作
         site             LIKE ooef_t.ooef001, #[2].chr 預算組織
         dat              LIKE type_t.dat,     #[3].dat 日期
         bgae001          LIKE bgae_t.bgae001, #[4].chr 預算項目
         bgbd013          LIKE bgbd_t.bgbd013, #[5].chr 部門
         bgbd014          LIKE bgbd_t.bgbd014, #[6].chr 利潤成本中心
         bgbd015          LIKE bgbd_t.bgbd015, #[7].chr 區域
         bgbd016          LIKE bgbd_t.bgbd016, #[8].chr 交易客商
         bgbd017          LIKE bgbd_t.bgbd017, #[9].chr 收款客商
         bgbd018          LIKE bgbd_t.bgbd018, #[10].chr 客群
         bgbd019          LIKE bgbd_t.bgbd019, #[11].chr 產品類別
         bgbd020          LIKE bgbd_t.bgbd020, #[12].chr 人員
         bgbd021          LIKE bgbd_t.bgbd021, #[13].chr 專案
         bgbd022          LIKE bgbd_t.bgbd022, #[14].chr WBS
         bgbd023          LIKE bgbd_t.bgbd023, #[15].chr 經營方式
         bgbd024          LIKE bgbd_t.bgbd024, #[16].chr 自由核算項一
         bgbd025          LIKE bgbd_t.bgbd025, #[17].chr 自由核算項二
         bgbd026          LIKE bgbd_t.bgbd026, #[18].chr 自由核算項三
         bgbd027          LIKE bgbd_t.bgbd027, #[19].chr 自由核算項四
         bgbd028          LIKE bgbd_t.bgbd028, #[20].chr 自由核算項五
         bgbd029          LIKE bgbd_t.bgbd029, #[21].chr 自由核算項六
         bgbd030          LIKE bgbd_t.bgbd030, #[22].chr 自由核算項七
         bgbd031          LIKE bgbd_t.bgbd031, #[23].chr 自由核算項八
         bgbd032          LIKE bgbd_t.bgbd032, #[24].chr 自由核算項九
         bgbd033          LIKE bgbd_t.bgbd033, #[25].chr 自由核算項十
         bgbd042          LIKE bgbd_t.bgbd042, #[26].chr 渠道
         bgbd043          LIKE bgbd_t.bgbd043, #[27].chr 品牌
         used036          LIKE bgbd_t.bgbd036, #[28].chr 使用程式
         used037          LIKE bgbd_t.bgbd037, #[29].chr 使用單號 
         used038          LIKE bgbd_t.bgbd038, #[30].chr 使用項次
         sour036          LIKE bgbd_t.bgbd036, #[31].chr 轉出程式
         sour037          LIKE bgbd_t.bgbd037, #[32].chr 轉出單號
         sour038          LIKE bgbd_t.bgbd038, #[33].chr 轉出項次
         curr             LIKE ooai_t.ooai001, #[34].chr 幣別
         account          LIKE type_t.num20_6 #[35].chr 金額
                          END RECORD
DEFINE ls_js              STRING

   LET r_success = TRUE
   LET r_errno = ''
   
   CALL s_aooi200_get_slip(p_pmdndocno)
        RETURNING l_success,l_slip
   IF cl_get_doc_para(g_enterprise,g_site,l_slip,'D-FIN-5002') = 'N' THEN
      RETURN r_success,r_errno
   END IF
   
   #抓取請購單單頭資料
   INITIALIZE l_pmdl.* TO NULL
   #mod--161018-00054#1 By shiun--(S)
#   SELECT pmdldocdt,pmdl002,pmdl003,pmdl015
#     INTO l_pmdl.pmdldocdt,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl015
   SELECT pmdldocdt,pmdl002,pmdl003,pmdl015,pmdl004,pmdl021
     INTO l_pmdl.pmdldocdt,l_pmdl.pmdl002,l_pmdl.pmdl003,l_pmdl.pmdl015,l_pmdl.pmdl004,l_pmdl.pmdl021
   #mod--161018-00054#1 By shiun--(E)
     FROM pmdl_t
    WHERE pmdlent = g_enterprise
      AND pmdldocno = p_pmdndocno
   
   #抓取請購單單身資料
   INITIALIZE l_pmdn.* TO NULL
   SELECT pmdn001,pmdn023,pmdn046,pmdn036,pmdn037,pmdn058
     INTO l_pmdn.pmdn001,l_pmdn.pmdn023,l_pmdn.pmdn046,l_pmdn.pmdn036,l_pmdn.pmdn037,l_pmdn.pmdn058
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdndocno = p_pmdndocno
      AND pmdnseq = p_pmdnseq
      
   SELECT imaa009 INTO l_imaa009
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = l_pmdn.pmdn001
   
   INITIALIZE l_tran.* TO NULL
   LET l_tran.act = p_act
   LET l_tran.site = g_site
   LET l_tran.dat = l_pmdl.pmdldocdt
   LET l_tran.bgae001 = l_pmdn.pmdn058
   LET l_tran.bgbd013 = l_pmdl.pmdl003
#   LET l_tran.bgbd016 = l_pmdn.pmdn023   #mark--161018-00054#1 By shiun
   LET l_tran.bgbd019 = l_imaa009
   LET l_tran.bgbd020 = l_pmdl.pmdl002
   LET l_tran.bgbd021 = l_pmdn.pmdn036
   LET l_tran.bgbd022 = l_pmdn.pmdn037
   LET l_tran.used036 = 'apmt500'
   LET l_tran.used037 = p_pmdndocno
   LET l_tran.used038 = p_pmdnseq
   LET l_tran.curr    = l_pmdl.pmdl015
   LET l_tran.account = l_pmdn.pmdn046
   
   #add--161018-00054#1 By shiun--(S)
   SELECT ooeg004 INTO l_tran.bgbd014
     FROM ooeg_t
    WHERE ooegent = g_enterprise
      AND ooeg001 = l_pmdl.pmdl003
      AND ooeg003 = '2'   #0.無,1.責任中心子部門,2.利潤中心,3.成本中心,4.收益中心,5.投資中心
      AND ooegstus = 'Y'
   
   SELECT pmaa241,pmaa090 INTO l_tran.bgbd015,l_tran.bgbd018
     FROM pmaa_t
    WHERE pmaaent = g_enterprise
      AND pmaa001 = l_pmdl.pmdl004
      AND (pmaa002 = '1' OR pmaa002 = '3')
      AND pmaastus = 'Y'
      
   LET l_tran.bgbd016 = l_pmdl.pmdl004
   LET l_tran.bgbd017 = l_pmdl.pmdl021
   #add--161018-00054#1 By shiun--(E)
   
   LET ls_js = util.JSON.stringify(l_tran)
   CALL s_abg_bgbd_upd(ls_js) RETURNING r_success,r_errno

   
   RETURN r_success,r_errno
END FUNCTION
################################################################################
# Descriptions...: 處理整張採購單的單身預算處理
# Memo...........:
# Usage..........: CALL s_apmt500_stus_abg1(p_pmdldocno,p_act)
#                  RETURNING r_success
# Input parameter: p_pmdndocno    採購單
#                : p_act          I.新增
#                                 U.修改
#                                 D.刪除
#                                 Y.確認
#                                 N.取消確認
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/08/27 By shiun
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_stus_abg1(p_pmdldocno,p_act)
DEFINE p_pmdldocno        LIKE pmdl_t.pmdldocno
DEFINE p_act              LIKE type_t.chr10
DEFINE r_success          LIKE type_t.num5
DEFINE l_pmdnseq          LIKE pmdn_t.pmdnseq
DEFINE l_success          LIKE type_t.num5
DEFINE l_errno            LIKE gzze_t.gzze001

   LET r_success = TRUE
   
   DECLARE s_apmt500_stus_abg1_cs CURSOR FOR
    SELECT pmdnseq FROM pmdn_t
     WHERE pmdnent = g_enterprise
       AND pmdndocno = p_pmdldocno
     ORDER BY pmdnseq
  
   FOREACH s_apmt500_stus_abg1_cs INTO l_pmdnseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      CALL s_apmt500_stus_abg(p_pmdldocno,l_pmdnseq,p_act)
           RETURNING l_success,l_errno
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = p_pmdldocno
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 專案------------------>財會結案---------->保固結案
#                  採購&變更單(若採購單是未結案下單，但採購變更單是結案後修改金額,則變更單仍是以原採購單金額回寫欄位。)
#                  檢查採購日期位於專案何種狀態，確認時，依"專案編號+WBS編號"
#                  回寫金額至成本管制表單身。(取消確認要還原發包金額)
# Memo...........:
# Usage..........: CALL s_apmt500_upd_apj(p_type,p_docdt,p_pmdn036,p_pmdn037,p_pmdn047)
#                  RETURNING r_success
# Input parameter: p_type    1:累加 2:累減
#                : p_docdt   採購日期
#                : p_pmdn036 專案編號
#                : p_pmdn037 WBS編號
#                : p_pmdn047 採購單含稅金額
#                : p_pmdl015 幣別
#                : p_pmdl054 內外購
# Return code....: r_success   TRUE / FALSE
# Date & Author..: 2015/11/30 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_upd_apj(p_type,p_docdt,p_pmdn036,p_pmdn037,p_pmdn047,p_pmdl015,p_pmdl054)
DEFINE p_type     LIKE type_t.chr1
DEFINE p_docdt    LIKE pmdl_t.pmdldocdt
DEFINE p_pmdn036  LIKE pmdn_t.pmdn036
DEFINE p_pmdn037  LIKE pmdn_t.pmdn037
DEFINE p_pmdn047  LIKE pmdn_t.pmdn047
DEFINE p_pmdl015  LIKE pmdl_t.pmdl015
DEFINE p_pmdl054  LIKE pmdl_t.pmdl054
DEFINE r_success  LIKE type_t.num5
DEFINE l_pjba023  LIKE pjba_t.pjba023 #財會結案日
DEFINE l_pjba024  LIKE pjba_t.pjba024 #保固結案
DEFINE l_ooef016  LIKE ooef_t.ooef016
DEFINE l_scc40    LIKE type_t.chr2        #匯率类型
DEFINE l_rate     LIKE ooan_t.ooan005 

   LET r_success = TRUE
   
   IF cl_null(p_docdt) OR cl_null(p_pmdn036) OR cl_null(p_pmdn037) OR cl_null(p_pmdn047) OR p_pmdn047 = 0 THEN
      RETURN r_success
   END IF

   #先將金額轉換成本幣金額
   LET l_ooef016 = ''
   SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   
   #交易幣別轉換成本幣
    IF l_ooef016 = p_pmdl015 THEN
       LET l_rate = 1
    ELSE          
       CASE p_pmdl054
         WHEN '1'  #內購外幣採用匯率類型
           CALL cl_get_para(g_enterprise,g_site,'S-BAS-0014') RETURNING l_scc40
         WHEN '2'  #外購外幣採用匯率類型
           CALL cl_get_para(g_enterprise,g_site,'S-BAS-0015') RETURNING l_scc40
         OTHERWISE EXIT CASE
       END CASE
       #取得匯率
       CALL s_aooi160_get_exrate('1',g_site,g_today,p_pmdl015,l_ooef016,0,l_scc40) RETURNING l_rate
       IF cl_null(l_rate) THEN
          LET l_rate = 1           
       END IF
    END IF     
    #金額依幣別轉換         
    LET p_pmdn047 = p_pmdn047 * l_rate
    CALL s_curr_round(g_site,p_pmdl015,p_pmdn047,'1') RETURNING p_pmdn047
   
   #專案------------------>財會結案---------->保固結案
   #2015/11/01             2015/12/31        2016/12/01
   #採購&變更單：(若採購單是未結案下單，但採購變更單是結案後修改金額，則變更單仍是以原採購單金額回寫欄位。)
   #檢查採購日期位於專案何種狀態，確認時，依"專案編號+WBS編號"，
   #，回寫金額至成本管制表單身。(取消確認要還原發包金額)
   #amt = 採購單含稅本幣金額
   #If 採購日期 <= 財會結案日 or 財會結案日 is null:
   #    pjbb014 += amt
   #if 採購日期 > 財會結案日 and 財會結案日 is not null:
   #    pjbb015 += amt
   
   LET l_pjba023 = ''
   SELECT pjba023 INTO l_pjba023 FROM pjba_t WHERE pjbaent = g_enterprise AND pjba001 = p_pmdn036
   
   IF p_docdt <= l_pjba023 OR cl_null(l_pjba023) THEN
      IF p_type = '1' THEN
         UPDATE pjbb_t SET pjbb014 = (CASE WHEN pjbb014 IS NULL THEN 0 ELSE pjbb014 END) + p_pmdn047
                 WHERE pjbbent = g_enterprise AND pjbb001 = p_pmdn036 AND pjbb002 = p_pmdn037 
      ELSE
         UPDATE pjbb_t SET pjbb014 = (CASE WHEN pjbb014 IS NULL THEN 0 ELSE pjbb014 END) - p_pmdn047
                 WHERE pjbbent = g_enterprise AND pjbb001 = p_pmdn036 AND pjbb002 = p_pmdn037 
      END IF
   ELSE
      IF p_type = '1' THEN
         UPDATE pjbb_t SET pjbb015 = (CASE WHEN pjbb015 IS NULL THEN 0 ELSE pjbb015 END) + p_pmdn047
                 WHERE pjbbent = g_enterprise AND pjbb001 = p_pmdn036 AND pjbb002 = p_pmdn037 
      ELSE
         UPDATE pjbb_t SET pjbb015 = (CASE WHEN pjbb015 IS NULL THEN 0 ELSE pjbb015 END) - p_pmdn047
                 WHERE pjbbent = g_enterprise AND pjbb001 = p_pmdn036 AND pjbb002 = p_pmdn037 
      END IF
   END IF
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #pjbb013 = pjbb014 +pjbb015 + pjbb016(開帳)
   UPDATE pjbb_t SET pjbb013 = (CASE WHEN pjbb014 IS NULL THEN 0 ELSE pjbb014 END) + (CASE WHEN pjbb015 IS NULL THEN 0 ELSE pjbb015 END) + (CASE WHEN pjbb016 IS NULL THEN 0 ELSE pjbb016 END)
              WHERE pjbbent = g_enterprise AND pjbb001 = p_pmdn036 AND pjbb002 = p_pmdn037 
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "pjbb_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 多角製造批序號檢查
# Memo...........:
# Usage..........: CALL s_apmt500_inao_chk(p_pmdldocno,p_pmdl051,p_pmdn001)
#                  RETURNING r_success
# Input parameter: p_pmdldocno  採購單號
#                : p_pmdl051    多角代碼
#                : p_pmdn001    料號
# Return code....: r_success    執行結果
#                : 
# Date & Author..: 151229 By earl
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_inao_chk(p_pmdldocno,p_pmdl051,p_pmdn001)
   DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno #採購單號
   DEFINE p_pmdl051     LIKE pmdl_t.pmdl051   #多角代碼
   DEFINE p_pmdn001     LIKE pmdn_t.pmdn001   #料號
   DEFINE r_success     LIKE type_t.num5
   
   DEFINE l_sql         STRING
   DEFINE l_pmdn001     LIKE pmdn_t.pmdn001   #料號
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   LET l_sql = "SELECT DISTINCT pmdn001",
               "  FROM pmdn_t",
               " WHERE pmdnent = ",g_enterprise,
               "   AND pmdndocno = '",p_pmdldocno,"'"
   PREPARE s_apmt500_inao_chk_pre FROM l_sql
   DECLARE s_apmt500_inao_chk_cs CURSOR FOR s_apmt500_inao_chk_pre
   
   IF cl_null(p_pmdl051) THEN
      SELECT pmdl051 INTO p_pmdl051
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdldocno = p_pmdldocno
   END IF
   
   IF NOT cl_null(p_pmdl051) THEN
      IF NOT cl_null(p_pmdn001) THEN  #檢查料號
         IF NOT s_aic_carry_inao_chk(p_pmdl051,p_pmdn001) THEN
            LET r_success = FALSE
         END IF
      ELSE   #檢查單據
         IF NOT cl_null(p_pmdldocno) THEN
            LET l_pmdn001 = ''
            FOREACH s_apmt500_inao_chk_cs INTO l_pmdn001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH s_apmt500_inao_chk_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET r_success = FALSE
               END IF
         
               IF NOT s_aic_carry_inao_chk(p_pmdl051,l_pmdn001) THEN
                  LET r_success = FALSE
               END IF
            END FOREACH
            
         END IF
      END IF
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 計算採購項次已入庫數量之最小套數
# Memo...........:
# Usage..........: CALL s_apmt500_count_min_pmdo019(p_pmdodocno,p_pmdoseq)
#                  RETURNING r_min_pmdo015,r_success
# Input parameter: p_pmdodocno   採購單號
#                : p_pmdoseq     採購單項次
# Return code....: r_min_pmdo019 已入庫量最小套數
#                : r_success     處理狀態
# Date & Author..: 2016/03/14    By Polly
# Modify.........:160225-00023#1
################################################################################
PUBLIC FUNCTION s_apmt500_count_min_pmdo019(p_pmdodocno,p_pmdoseq)
DEFINE p_pmdodocno    LIKE pmdo_t.pmdodocno
DEFINE p_pmdoseq      LIKE pmdo_t.pmdoseq
DEFINE r_min_pmdo019  LIKE pmdo_t.pmdo019
DEFINE r_success      LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5
DEFINE l_seq1         LIKE type_t.num20_6

       WHENEVER ERROR CONTINUE

       LET r_success = TRUE
       LET r_min_pmdo019 = 0
       
       IF cl_null(p_pmdodocno) THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'sub-00228'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE 
          RETURN r_min_pmdo019,r_success 
       END IF
       IF cl_null(p_pmdoseq) THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'sub-00406'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE 
          RETURN r_min_pmdo019,r_success 
       END IF
       
       #檢核p_pmdodocno,p_pmdoseq是否存在[T.採購單單身]
       LET l_n=0
       SELECT COUNT(*) INTO l_n FROM pmdn_t 
        WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdodocno AND pmdnseq = p_pmdoseq
       IF l_n = 0 THEN                 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00335'
          LET g_errparam.extend = ""
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE
          RETURN r_min_pmdo019,r_success       
       END IF
       
       #依傳入之採購單號、採購項次抓取[T.採購交期明細檔]所有符合資料
       LET l_seq1 = 0
       SELECT MIN(a) 
         INTO l_seq1   
         FROM (SELECT CASE SUM(pmdo019-pmdo040) WHEN 0 THEN 0 ELSE SUM((pmdo019-pmdo040)/pmdo008) END a   
                 FROM pmdo_t
                WHERE pmdoent = g_enterprise
                  AND pmdodocno = p_pmdodocno
                  AND pmdoseq = p_pmdoseq
               GROUP BY pmdoseq1)     

       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = l_seq1
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET r_success = FALSE   
       ELSE          
          LET r_min_pmdo019= l_seq1
       END IF
       
   RETURN r_min_pmdo019,r_success   
END FUNCTION

################################################################################
# Descriptions...: 單別欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdldocno(p_pmdldocno,p_pmdldocdt,p_pmdl008)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdldocno(p_pmdldocno,p_pmdldocdt,p_pmdl008)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE r_success     LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_flag        LIKE type_t.num5
DEFINE p_pmdl008     LIKE pmdl_t.pmdl008

   LET r_success = TRUE
   IF NOT cl_null(p_pmdldocno) THEN 
      #檢核輸入的單據別是否可以被key人員對應的控制組使用,'4' 為採購控制組類型
      CALL s_control_chk_doc('1',p_pmdldocno,'4',g_user,g_dept,'','') RETURNING l_success,l_flag
      IF NOT l_success OR NOT l_flag THEN
         LET r_success = FALSE
      END IF
                  
      IF NOT s_aooi200_chk_docno(g_site,p_pmdldocno,p_pmdldocdt,'apmt500') THEN
         LET r_success = FALSE
      END IF
                  
      #檢核前後置單別的合理性
      IF NOT cl_null(p_pmdl008) THEN
         IF NOT s_aooi210_check_doc(g_site,'',p_pmdl008,p_pmdldocno,'3','') THEN
            LET r_success = FALSE 
         END IF
      END IF
     
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 人員欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl002(p_pmdldocno,p_pmdl002,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl002(p_pmdldocno,p_pmdl002,p_field,p_pmdl004)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl002     LIKE pmdl_t.pmdl002
DEFINE r_pmdl002     LIKE pmdl_t.pmdl002
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl002 = ''
   LET r_pmdl002 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl002)
   IF cl_null(r_pmdl002) THEN
      LET r_pmdl002 = p_pmdl002
   END IF
   IF NOT cl_null(p_pmdl004) THEN
      IF cl_null(r_pmdl002) THEN
         CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
         IF NOT cl_null(l_controlno) THEN
            SELECT pmal019 INTO r_pmdl002 FROM pmal_t 
              WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
         END IF
      END IF
      
      IF cl_null(r_pmdl002) THEN
         SELECT pmab031 INTO r_pmdl002 FROM pmab_t 
            WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
      END IF
      
      IF cl_null(r_pmdl002) THEN
         SELECT pmaa086 INTO r_pmdl002 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_pmdl004
      END IF   
   END IF
   
   IF cl_null(r_pmdl002) THEN
      LET r_pmdl002 = g_user
   END IF
   
   IF NOT cl_null(r_pmdl002) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl002
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooag001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl002
   
END FUNCTION

################################################################################
# Descriptions...: 部門欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl003(p_pmdldocno,p_pmdldocdt,p_pmdl003,p_field,p_pmdl004)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
#################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl003(p_pmdldocno,p_pmdldocdt,p_pmdl003,p_field,p_pmdl004)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE p_pmdl003     LIKE pmdl_t.pmdl003
DEFINE r_pmdl003     LIKE pmdl_t.pmdl003
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl003 = ''
   LET r_pmdl003 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl003)
   IF cl_null(r_pmdl003) THEN
      LET r_pmdl003 = p_pmdl003
   END IF
   IF NOT cl_null(p_pmdl004) THEN
      IF cl_null(r_pmdl003) THEN
         CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
         IF NOT cl_null(l_controlno) THEN
            SELECT pmal025 INTO r_pmdl003 FROM pmal_t 
              WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
         END IF
      END IF
      
      IF cl_null(r_pmdl003) THEN
         SELECT pmab059 INTO r_pmdl003 FROM pmab_t 
            WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
      END IF
      IF cl_null(r_pmdl003) THEN
         SELECT pmaa087 INTO r_pmdl003 FROM pmaa_t WHERE pmaaent = g_enterprise AND pmaa001 = p_pmdl004
      END IF   
   END IF
   
   IF cl_null(r_pmdl003) THEN
      LET r_pmdl003 = g_dept
   END IF
   
   IF NOT cl_null(r_pmdl003) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl003
      LET g_chkparam.arg2 = p_pmdldocdt
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooeg001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   RETURN r_success,r_pmdl003
   
END FUNCTION

################################################################################
# Descriptions...: 供應商編號欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl004(p_pmdldocno,p_pmdl004,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl004(p_pmdldocno,p_pmdl004,p_field)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE l_success     LIKE type_t.num5
DEFINE l_flag        LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10
DEFINE r_pmdl004     LIKE pmdl_t.pmdl004

       LET r_success = TRUE
       
       LET r_pmdl004 = ''
       LET r_pmdl004 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl004)
       IF cl_null(r_pmdl004) THEN
          LET r_pmdl004 = p_pmdl004
       END IF
       
       IF NOT cl_null(r_pmdl004) THEN 
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = r_pmdl004
   
          #呼叫檢查存在並帶值的library
          IF NOT cl_chk_exist("v_pmaa001_1") THEN
             LET r_success = FALSE
          END IF

           IF NOT cl_chk_exist("v_pmab001_1") THEN
              #檢查失敗時後續處理
              LET r_success = FALSE
           END IF

          #判斷輸入的供應商編號是否在採購控制組限制的供應商範圍內，若不在限制內則不允許跟此供應商採購  
          CALL s_control_chk_group('2','4',g_user,g_dept,r_pmdl004,'','','','') RETURNING l_success,l_flag
          IF NOT l_success OR NOT l_flag THEN      #处理状态
             LET r_success = FALSE
          END IF
          
          #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
          CALL s_control_chk_doc('2',p_pmdldocno,r_pmdl004,'','','','') RETURNING l_success,l_flag
          IF NOT l_success OR NOT l_flag THEN      #处理状态
             LET r_success = FALSE
          END IF

       END IF 
       
       RETURN r_success,r_pmdl004
       
END FUNCTION

################################################################################
# Descriptions...: 來源單號欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl008(p_pmdldocno,p_pmdl008,p_pmdl007,p_pmdl006)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl008(p_pmdldocno,p_pmdl008,p_pmdl007,p_pmdl006)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl008     LIKE pmdl_t.pmdl008
DEFINE p_pmdl007     LIKE pmdl_t.pmdl007
DEFINE p_pmdl006     LIKE pmdl_t.pmdl006
DEFINE r_success     LIKE type_t.num5
DEFINE l_n           LIKE type_t.num5
DEFINE l_flag        LIKE type_t.num5
DEFINE l_sum_pmdn007 LIKE pmdn_t.pmdn007
DEFINE l_pmdn007     LIKE pmdn_t.pmdn007
DEFINE l_pmdnseq     LIKE pmdn_t.pmdnseq
DEFINE l_pmdp023     LIKE pmdp_t.pmdp023
DEFINE l_sfca003     LIKE sfca_t.sfca003

       LET r_success = TRUE
       
       #150909 earl add s
       IF NOT s_aooi210_check_doc(g_site,'',p_pmdl008,p_pmdldocno,'4','') THEN
          LET r_success = FALSE
          RETURN r_success
       END IF
       #150909 earl add e
       
       CASE p_pmdl007
          WHEN '2'  #請購單
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL
             
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = p_pmdl008
 
             #呼叫檢查存在並帶值的library
             IF NOT cl_chk_exist("v_pmdadocno") THEN
                LET r_success = FALSE
                RETURN r_success
             END IF
         #WHEN '3'  #訂單
          WHEN '4'  #工單
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL
             
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = p_pmdl008
             
             #呼叫檢查存在並帶值的library
             IF p_pmdl006 = '8' THEN   #協作採購單
                IF NOT cl_chk_exist("v_sfcbdocno_2") THEN
                   #檢查失敗時後續處理
                   LET r_success = FALSE
                   RETURN r_success
                END IF
             ELSE
                IF NOT cl_chk_exist("v_sfcbdocno_1") THEN
                   #檢查失敗時後續處理
                   LET r_success = FALSE
                   RETURN r_success
                END IF
                #判斷是否存在可委外的數量
                #LET l_n = 0
                #SELECT COUNT(*) INTO l_n FROM sfcb_t 
                #  WHERE sfcbent   = g_enterprise AND
                #       ((CASE WHEN sfcb027 IS NULL THEN 0 ELSE sfcb027 END)+(CASE WHEN sfcb029 IS NULL THEN 0 ELSE sfcb029 END)+(CASE WHEN sfcb030 IS NULL THEN 0 ELSE sfcb030 END)+
                #        (CASE WHEN sfcb031 IS NULL THEN 0 ELSE sfcb031 END)+(CASE WHEN sfcb032 IS NULL THEN 0 ELSE sfcb032 END)-(CASE WHEN sfcb033 IS NULL THEN 0 ELSE sfcb033 END)-
                #        (CASE WHEN sfcb034 IS NULL THEN 0 ELSE sfcb034 END)-(CASE WHEN sfcb035 IS NULL THEN 0 ELSE sfcb035 END)-(CASE WHEN sfcb036 IS NULL THEN 0 ELSE sfcb036 END)-
                #        (CASE WHEN sfcb037 IS NULL THEN 0 ELSE sfcb037 END)-(CASE WHEN sfcb038 IS NULL THEN 0 ELSE sfcb038 END)-(CASE WHEN sfcb039 IS NULL THEN 0 ELSE sfcb039 END)-
                #        (CASE WHEN sfcb041 IS NULL THEN 0 ELSE sfcb041 END)-(CASE WHEN sfcb042 IS NULL THEN 0 ELSE sfcb042 END)) > 0 
                #   AND sfcbdocno = g_pmdl_m.pmdl008
                #160112-00016#1--mark--begin---
                #SELECT SUM(pmdp023) INTO l_pmdp023 FROM pmdp_t,pmdl_t 
                #  WHERE pmdpent = pmdlent AND pmdpent = g_enterprise
                #   AND pmdpdocno = pmdldocno
                #   AND pmdp003   = g_pmdl_m.pmdl008          
                #   AND pmdlstus <> 'X' 
                #   AND pmdldocno <> g_pmdl_m.pmdldocno
                #SELECT sfca003 INTO l_sfca003 FROM sfca_t WHERE sfcaent = g_enterprise AND sfcadocno = g_pmdl_m.pmdl008
                #IF cl_null(l_pmdp023) THEN
                #   LET l_pmdp023 = 0
                #END IF
                #160112-00016#1--mark--end---
                #160112-00016#1--add--begin---
                #可委外数大于0时才可委外
                #可委外數=標準產出數量(sfcb027)+重工轉入(sfcb029)+工單轉入(sfcb030)+分割轉入(sfcb031)+合併轉入(sfcb032)
                #        -良品轉出(sfcb033)-重工轉出(sfcb034)-工單轉出(sfcb035)-當站報廢(sfcb036)-當站下線(sfcb037)
                #        -分割轉出(sfcb038)-合併轉出(sfcb039)-委外數量(sfcb041)+委外完工數量(sfcb042) 
                SELECT COUNT(*) INTO l_n FROM sfcb_t 
                 WHERE sfcbent = g_enterprise AND sfcbsite = g_site
                   AND sfcbdocno = p_pmdl008
                   AND (sfcb027+sfcb029+sfcb030+sfcb031+sfcb032-sfcb033-sfcb034-sfcb035-sfcb036-sfcb037-sfcb038-sfcb039-sfcb041+sfcb042) > 0
                #160112-00016#1--add--end---
                #IF l_pmdp023 = l_sfca003 THEN  #160112-00016#1 mark
                IF l_n = 0 OR cl_null(l_n) THEN #160112-00016#1 add
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'apm-00772'
                   LET g_errparam.extend = p_pmdl008
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   LET r_success = FALSE
                END IF
             END IF
         #WHEN '5'  #MRP
         
         WHEN '7'  #倉退
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL
             
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = p_pmdl008
             
             #呼叫檢查存在並帶值的library
             IF NOT cl_chk_exist("v_pmdsdocno_5") THEN
                #檢查失敗時後續處理
                LET r_success = FALSE
                RETURN r_success
             END IF
             
             #該來源單據不可存在一筆未確認的採購單
             LET l_n = 0
             SELECT COUNT(*) INTO l_n FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdl008 = p_mdl008 AND pmdlstus = 'N'
             IF l_n > 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00618'
                LET g_errparam.extend = p_pmdl008
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET r_success = FALSE
                RETURN r_success
             END IF
             
          WHEN '8'  #預先採購
             #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
             INITIALIZE g_chkparam.* TO NULL
              #160318-00025#15 by 07900 --add-str 
              LET g_errshow = TRUE #是否開窗
              #160318-00025#15 by 07900 --add-end
              
             #設定g_chkparam.*的參數
             LET g_chkparam.arg1 = p_pmdl008
             #160318-00025#15 by 07900 --add-str 
             LET g_chkparam.err_str[1] ="apm-00337:sub-01302|apmt500|",cl_get_progname("apmt500",g_lang,"2"),"|:EXEPROGapmt500"
              #160318-00025#15 by 07900 --add-end
              
             #呼叫檢查存在並帶值的library
             IF NOT cl_chk_exist("v_pmdldocno_2") THEN
                #檢查失敗時後續處理
                LET r_success = FALSE
                RETURN r_success
             END IF
             
             #該來源單據不可存在一筆未確認的採購單
             LET l_n = 0
             SELECT COUNT(*) INTO l_n FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdl008 = p_pmdl008 AND pmdlstus = 'N'
             IF l_n > 0 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00618'
                LET g_errparam.extend = p_pmdl008
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF
             
             LET l_flag = FALSE
       
             DECLARE pmdl008_chk_cs CURSOR FOR
                SELECT pmdnseq,pmdn007 FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdl008
             FOREACH pmdl008_chk_cs INTO l_pmdnseq,l_pmdn007
                #已轉採購單的數量
                SELECT SUM(pmdn007) INTO l_sum_pmdn007 FROM pmdn_t,pmdl_t 
                   WHERE pmdlent = pmdnent AND pmdldocno = pmdndocno AND pmdl008 = p_pmdl008 
                     AND pmdnseq = l_pmdnseq AND pmdlstus <> 'X'
                IF cl_null(l_sum_pmdn007) THEN
                   LET l_sum_pmdn007 = 0
                END IF
                IF l_pmdn007 > l_sum_pmdn007 THEN
                   LET l_flag = TRUE
                   EXIT FOREACH
                END IF
                
             END FOREACH
             #該來源單據的可採購數量已為零
             IF NOT l_flag THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00619'
                LET g_errparam.extend = p_pmdl008
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
            END IF
            
       END CASE
       RETURN r_success
       
END FUNCTION

################################################################################
# Descriptions...: 匯率欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl016(p_pmdl015,p_pmdl016,p_pmdl054)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl016(p_pmdl015,p_pmdl016,p_pmdl054)
DEFINE p_pmdl015   LIKE pmdl_t.pmdl015
DEFINE p_pmdl054   LIKE pmdl_t.pmdl054
DEFINE p_pmdl016   LIKE pmdl_t.pmdl016
DEFINE r_pmdl016   LIKE pmdl_t.pmdl016
DEFINE r_success   LIKE type_t.num5
DEFINE l_ooef016   LIKE ooef_t.ooef016
DEFINE l_scc40     LIKE type_t.chr2

   LET r_success = TRUE
   
   IF cl_null(p_pmdl016) OR p_pmdl016 = 0 THEN
      LET l_ooef016 = ''
      SELECT ooef016 INTO l_ooef016 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
      #根據內外購獲取當前營運據點參數設置的汇率类型
      LET l_scc40 = ''
      IF p_pmdl054 = '1' THEN   #內購
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0014')
      END IF
      IF p_pmdl054 = '2' THEN   #外購
         LET l_scc40 = cl_get_para(g_enterprise,g_site,'S-BAS-0015')
      END IF
      IF NOT cl_null(l_scc40) THEN
         CALL s_aooi160_get_exrate('1',g_site,g_today,p_pmdl015,l_ooef016,0,l_scc40) RETURNING r_pmdl016
      END IF
   ELSE
      LET r_pmdl016 = p_pmdl016
   END IF
   
   IF NOT cl_ap_chk_range(r_pmdl016,"0","0","","","azz-00079",1) THEN
      LET r_success = FALSE
   END IF 
   RETURN r_success,r_pmdl016
   
END FUNCTION

################################################################################
# Descriptions...: 抓取採購控制組編號，只抓一個--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_get_group(p_type,p_user,p_group)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_get_group(p_type,p_user,p_group)
DEFINE p_type    LIKE type_t.chr1
DEFINE p_user    LIKE type_t.chr10
DEFINE p_group   LIKE type_t.chr10
DEFINE r_success LIKE type_t.num5
DEFINE r_controlno    LIKE ooha_t.ooha001
DEFINE l_sql1    STRING
DEFINE l_sql2    STRING
DEFINE l_sql     STRING
DEFINE l_n       LIKE type_t.num5


 WHENEVER ERROR CONTINUE
 LET r_success = TRUE

 #检查控制组类型不可为空且值域在ooha002中
 IF cl_null(p_type) THEN
    RETURN r_success,''
 END IF
 
 SELECT COUNT(ooha002) INTO l_n FROM ooha_t WHERE oohaent=g_enterprise AND ooha002=p_type
    AND oohastus = 'Y'  

 IF l_n = 0 THEN
    RETURN r_success,''
 END IF

 #检查人员编号不可为空
 IF cl_null(p_user) THEN
    RETURN r_success,''
 END IF
 
 #检查部门编号不可为空
 IF cl_null(p_group) THEN
    RETURN r_success,''
 END IF

 #依据传入的人员编号p_user来抓取控制组
 LET l_sql1 = "SELECT unique ooha001 FROM ooha_t,oohc_t WHERE oohaent=oohcent AND ooha001=oohc001 ",
              "   AND oohastus = 'Y'",   #160303-00027#1 2016/03/17 By earl add
              "   AND oohaent = ",g_enterprise," AND ooha002='",p_type,"' AND oohc002='",p_user,"'",
              "   AND (oohc003<='",g_today,"' AND (oohc004 IS NULL OR oohc004>'",g_today,"'))",
              " UNION ",
 #依据传入的部门编号p_group来抓取控制组
              "SELECT unique ooha001 FROM ooha_t,oohb_t WHERE oohaent=oohbent AND ooha001=oohb001 ",
              "   AND oohastus = 'Y'",   #160303-00027#1 2016/03/17 By earl add
              "   AND oohaent = ",g_enterprise," AND ooha002='",p_type,"' AND oohb002='",p_group,"'",
              "   AND (oohb003<='",g_today,"' AND (oohb004 IS NULL OR oohb004>'",g_today,"'))"
              
 #LET l_sql = " SELECT unique ooha001 FROM ( ",l_sql1," ) WHERE ROWNUM =1 ORDER BY ooha001 "  #170207-00018#4    2017/02/13    By 08734 mark
 LET l_sql = " SELECT A.ooha001 FROM(SELECT unique ooha001 FROM ( ",l_sql1," )  ORDER BY ooha001) A WHERE ROWNUM =1 "  #170207-00018#4    2017/02/13    By 08734 add
 PREPARE con_pre1 FROM l_sql
 EXECUTE con_pre1 INTO r_controlno
 
 RETURN r_success,r_controlno
 
END FUNCTION

################################################################################
# Descriptions...: 付款條件欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl009(p_pmdldocno,p_field,p_pmdl004,p_pmdl009)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl009(p_pmdldocno,p_field,p_pmdl004,p_pmdl009)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl009     LIKE pmdl_t.pmdl009
DEFINE r_pmdl009     LIKE pmdl_t.pmdl009
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl009 = ''
   
   LET r_pmdl009 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl009)
   IF cl_null(r_pmdl009) THEN
      LET r_pmdl009 = p_pmdl009
   END IF
   IF cl_null(r_pmdl009) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal006 INTO r_pmdl009 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl009) THEN
      SELECT pmab037 INTO r_pmdl009 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl009) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_pmdl004
      LET g_chkparam.arg2 = r_pmdl009
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_pmad002_1") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl009
   
END FUNCTION

################################################################################
# Descriptions...: 交易条件欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl010(p_pmdldocno,p_field,p_pmdl004,p_pmdl010)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl010(p_pmdldocno,p_field,p_pmdl004,p_pmdl010)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl010     LIKE pmdl_t.pmdl010
DEFINE r_pmdl010     LIKE pmdl_t.pmdl010
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl010 = ''
   
   LET r_pmdl010 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl010)
   IF cl_null(r_pmdl010) THEN
      LET r_pmdl010 = p_pmdl010
   END IF
   IF cl_null(r_pmdl010) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal020 INTO r_pmdl010 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl010) THEN
      SELECT pmab053 INTO r_pmdl010 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl010) THEN
      IF NOT s_azzi650_chk_exist('238',r_pmdl010) THEN
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success,r_pmdl010
   
END FUNCTION

################################################################################
# Descriptions...: 税种欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl011(p_pmdldocno,p_field,p_pmdl004,p_pmdl011)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl011(p_pmdldocno,p_field,p_pmdl004,p_pmdl011)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl011     LIKE pmdl_t.pmdl011
DEFINE r_pmdl011     LIKE pmdl_t.pmdl011
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5
DEFINE l_oodbl004    LIKE oodbl_t.oodbl004  #稅別名稱
DEFINE l_oodb005     LIKE oodb_t.oodb005    #含稅否
DEFINE l_oodb006     LIKE oodb_t.oodb006    #稅率 
DEFINE l_oodb011     LIKE oodb_t.oodb011    #取得稅別類型1:正常稅率2:依料件設定  

   LET r_success = TRUE
   LET r_pmdl011 = ''
   
   LET r_pmdl011 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl011)
   IF cl_null(r_pmdl011) THEN
      LET r_pmdl011 = p_pmdl011
   END IF
   IF cl_null(r_pmdl011) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal004 INTO r_pmdl011 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl011) THEN
      SELECT pmab034 INTO r_pmdl011 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl011) THEN
      CALL s_tax_chk(g_site,r_pmdl011)
          RETURNING l_success,l_oodbl004,l_oodb005,l_oodb006,l_oodb011      
      
      #呼叫檢查存在並帶值的library
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl011
   
END FUNCTION

################################################################################
# Descriptions...: 币种欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl015(p_pmdldocno,p_field,p_pmdl004,p_pmdl015)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl015(p_pmdldocno,p_field,p_pmdl004,p_pmdl015)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl015     LIKE pmdl_t.pmdl015
DEFINE r_pmdl015     LIKE pmdl_t.pmdl015
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl015 = ''
   
   LET r_pmdl015 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl015)
   IF cl_null(r_pmdl015) THEN
      LET r_pmdl015 = p_pmdl015
   END IF
   IF cl_null(r_pmdl015) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal003 INTO r_pmdl015 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl015) THEN
      SELECT pmab033 INTO r_pmdl015 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl015) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_site
      LET g_chkparam.arg2 = r_pmdl015
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooaj002") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl015
   
END FUNCTION

################################################################################
# Descriptions...: 取价方式欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl017(p_pmdldocno,p_field,p_pmdl004,p_pmdl017)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl017(p_pmdldocno,p_field,p_pmdl004,p_pmdl017)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl017     LIKE pmdl_t.pmdl017
DEFINE r_pmdl017     LIKE pmdl_t.pmdl017
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl017 = ''
   
   LET r_pmdl017 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl017)
   IF cl_null(r_pmdl017) THEN
      LET r_pmdl017 = p_pmdl017
   END IF
   IF cl_null(r_pmdl017) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal021 INTO r_pmdl017 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl017) THEN
      SELECT pmab054 INTO r_pmdl017 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl017) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl017
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_pmam001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl017
   
END FUNCTION

################################################################################
# Descriptions...: 付款优惠条件欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl018(p_pmdldocno,p_field,p_pmdl018)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl018(p_pmdldocno,p_field,p_pmdl018)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl018     LIKE pmdl_t.pmdl018
DEFINE r_pmdl018     LIKE pmdl_t.pmdl018
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl018 = ''
   
   LET r_pmdl018 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl018)
   IF cl_null(r_pmdl018) THEN
      LET r_pmdl018 = p_pmdl018
   END IF
   
   IF NOT cl_null(r_pmdl018) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl018
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooid001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl018
END FUNCTION

################################################################################
# Descriptions...: 取价方式欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl020(p_pmdldocno,p_field,p_pmdl004,p_pmdl020)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl020(p_pmdldocno,p_field,p_pmdl004,p_pmdl020)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl020     LIKE pmdl_t.pmdl020
DEFINE r_pmdl020     LIKE pmdl_t.pmdl020
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl020 = ''
   
   LET r_pmdl020 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl020)
   IF cl_null(r_pmdl020) THEN
      LET r_pmdl020 = p_pmdl020
   END IF
   IF cl_null(r_pmdl020) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal011 INTO r_pmdl020 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl020) THEN
      SELECT pmab040 INTO r_pmdl020 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl020) THEN
      IF NOT s_azzi650_chk_exist('263',r_pmdl020) THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl020
END FUNCTION

################################################################################
# Descriptions...: 供應商交易夥伴欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl021(p_field,p_pmdldocno,p_pmdl004,p_pmdl021,p_type)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl021(p_field,p_pmdldocno,p_pmdl004,p_pmdl021,p_type)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl021     LIKE pmdl_t.pmdl021
DEFINE r_pmdl021     LIKE pmdl_t.pmdl021
DEFINE r_success     LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE p_type        LIKE type_t.chr1  #供應商交易夥伴類型
DEFINE l_pmdl004     LIKE pmdl_t.pmdl004

   LET r_success = TRUE
   LET r_pmdl021 = ''
   
   LET r_pmdl021 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl021)
   IF cl_null(r_pmdl021) THEN
      LET r_pmdl021 = p_pmdl021
   END IF
   
   IF p_type = '1' THEN
      IF cl_null(r_pmdl021) THEN
         SELECT pmac002 INTO r_pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '1' AND pmacstus = 'Y' AND pmac004 = 'Y'
      END IF
      IF cl_null(r_pmdl021) THEN
         SELECT pmac002 INTO r_pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '1' AND pmacstus = 'Y' AND rownum = 1
      END IF
   END IF
   IF p_type = '2' THEN
      IF cl_null(r_pmdl021) THEN
         SELECT pmac002 INTO r_pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '2' AND pmacstus = 'Y' AND pmac004 = 'Y'
      END IF
      IF cl_null(r_pmdl021) THEN
         SELECT pmac002 INTO r_pmdl021 FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = p_pmdl004 AND pmac003 = '2' AND pmacstus = 'Y' AND rownum = 1
      END IF
   END IF
   IF cl_null(r_pmdl021) THEN
      LET r_pmdl021 = p_pmdl004
   END IF
   
   IF NOT cl_null(r_pmdl021) AND r_pmdl021 <> p_pmdl004 THEN
      CALL s_apmt500_chk_pmdl004(p_pmdldocno,r_pmdl021,'pmdl004') RETURNING l_success,l_pmdl004
      
      IF NOT l_success THEN
         LET r_success = FALSE
      END IF
     
      IF p_type = '1' THEN     #付款供应商
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = p_pmdl004
         LET g_chkparam.arg2 = r_pmdl021
         LET g_chkparam.arg3 = g_site

         IF NOT cl_chk_exist("v_pmac002") THEN
            LET r_success = FALSE
         END IF
      END IF  
      IF p_type = '2' THEN     #送货供应商
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = p_pmdl004
         LET g_chkparam.arg2 = r_pmdl021
         LET g_chkparam.arg3 = g_site

         IF NOT cl_chk_exist("v_pmac002_2") THEN
            LET r_success = FALSE
         END IF
      END IF        
   END IF
   
   RETURN r_success,r_pmdl021
END FUNCTION

################################################################################
# Descriptions...: 采购渠道欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl023(p_pmdldocno,p_field,p_pmdl004,p_pmdl023)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl023(p_pmdldocno,p_field,p_pmdl004,p_pmdl023)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl023     LIKE pmdl_t.pmdl023
DEFINE r_pmdl023     LIKE pmdl_t.pmdl023
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl023 = ''
   
   LET r_pmdl023 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl023)
   IF cl_null(r_pmdl023) THEN
      LET r_pmdl023 = p_pmdl023
   END IF
   IF cl_null(r_pmdl023) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal008 INTO r_pmdl023 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl023) THEN
      SELECT pmab038 INTO r_pmdl023 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl023) THEN
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = r_pmdl023
      LET g_chkparam.arg2 = '2'
      IF NOT cl_chk_exist("v_oojd001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl023
END FUNCTION

################################################################################
# Descriptions...: 采购分类欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl024(p_pmdldocno,p_field,p_pmdl004,p_pmdl024)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl024(p_pmdldocno,p_field,p_pmdl004,p_pmdl024)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl024     LIKE pmdl_t.pmdl024
DEFINE r_pmdl024     LIKE pmdl_t.pmdl024
DEFINE r_success     LIKE type_t.num5
DEFINE l_controlno   LIKE ooha_t.ooha001
DEFINE l_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl024 = ''
   
   LET r_pmdl024 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl024)
   IF cl_null(r_pmdl024) THEN
      LET r_pmdl024 = p_pmdl024
   END IF
   IF cl_null(r_pmdl024) THEN
      CALL s_apmt500_get_group('4',g_user,g_dept) RETURNING l_success,l_controlno
      IF NOT cl_null(l_controlno) THEN
         SELECT pmal009 INTO r_pmdl024 FROM pmal_t 
           WHERE pmalent = g_enterprise AND pmal001 = p_pmdl004 AND pmal002 = l_controlno AND pmalstus = 'Y'
      END IF
   END IF
   
   IF cl_null(r_pmdl024) THEN
      SELECT pmab039 INTO r_pmdl024 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl024) THEN
      IF NOT s_azzi650_chk_exist('264',r_pmdl024) THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl024
END FUNCTION

################################################################################
# Descriptions...: 地址欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl025(p_field,p_pmdldocno,p_pmdl025,p_type)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl025(p_field,p_pmdldocno,p_pmdl025,p_type)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl025     LIKE pmdl_t.pmdl025
DEFINE r_pmdl025     LIKE pmdl_t.pmdl025
DEFINE r_success     LIKE type_t.num5
DEFINE p_type        LIKE type_t.chr1  #地址类型
DEFINE l_oofa001     LIKE oofa_t.oofa001

   LET r_success = TRUE
   LET r_pmdl025 = ''
   
   LET r_pmdl025 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl025)
   IF cl_null(r_pmdl025) THEN
      LET r_pmdl025 = p_pmdl025
   END IF
   
   IF NOT cl_null(r_pmdl025) THEN
      #獲取當前營運據點的聯絡對象識別碼
      LET l_oofa001 = ''
      SELECT oofa001 INTO l_oofa001 FROM oofa_t WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
   
      IF p_type = '3' THEN     #送货地址
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_oofa001
         LET g_chkparam.arg2 = r_pmdl025

         IF NOT cl_chk_exist("v_oofb019_1") THEN
            LET r_success = FALSE
         END IF
      END IF  
      IF p_type = '5' THEN     #账款地址
         INITIALIZE g_chkparam.* TO NULL
         LET g_chkparam.arg1 = l_oofa001
         LET g_chkparam.arg2 = r_pmdl025

         IF NOT cl_chk_exist("v_oofb019_2") THEN
            LET r_success = FALSE
         END IF
      END IF        
   END IF
   
   RETURN r_success,r_pmdl025
   
END FUNCTION

################################################################################
# Descriptions...: 供应商连络人欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl027(p_pmdldocno,p_field,p_pmdl004,p_pmdl027)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl027(p_pmdldocno,p_field,p_pmdl004,p_pmdl027)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_field       LIKE type_t.chr10
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl027     LIKE pmdl_t.pmdl027
DEFINE r_pmdl027     LIKE pmdl_t.pmdl027
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   LET r_pmdl027 = ''
   
   LET r_pmdl027 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl027)
   IF cl_null(r_pmdl027) THEN
      LET r_pmdl027 = p_pmdl027
   END IF
   IF cl_null(r_pmdl027) THEN
     SELECT pmaj002 INTO r_pmdl027 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = p_pmdl004 AND pmajstus = 'Y' AND pmaj004 = 'Y'
      IF cl_null(r_pmdl027) THEN
         SELECT pmaj002 INTO r_pmdl027 FROM pmaj_t WHERE pmajent = g_enterprise AND pmaj001 = p_pmdl004 AND pmajstus = 'Y' AND rownum = 1  
      END IF
   END IF

   IF NOT cl_null(r_pmdl027) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_pmdl004
      LET g_chkparam.arg2 = r_pmdl027
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_pmaj002") THEN
         LET r_success = FALSE
      END IF      
   END IF
   
   RETURN r_success,r_pmdl027
END FUNCTION

################################################################################
# Descriptions...: 部門欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl029(p_pmdldocno,p_pmdldocdt,p_pmdl029,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
#################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl029(p_pmdldocno,p_pmdldocdt,p_pmdl029,p_field)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE p_pmdl029     LIKE pmdl_t.pmdl029
DEFINE r_pmdl029     LIKE pmdl_t.pmdl029
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10

   LET r_success = TRUE
   LET r_pmdl029 = ''
   LET r_pmdl029 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl029)
   IF cl_null(r_pmdl029) THEN
      LET r_pmdl029 = p_pmdl029
   END IF
   
   IF NOT cl_null(r_pmdl029) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl029
      LET g_chkparam.arg2 = p_pmdldocdt
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_ooeg001") THEN
         LET r_success = FALSE
      END IF      
   END IF
   RETURN r_success,r_pmdl029
   
END FUNCTION

################################################################################
# Descriptions...: 更新单头金额欄位--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_upd_amount(p_pmdldocno)
#                  RETURNING r_success
# Date & Author..: 2016/08/9 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_upd_amount(p_pmdldocno)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE r_xrcd103     LIKE xrcd_t.xrcd103
DEFINE r_xrcd104     LIKE xrcd_t.xrcd104
DEFINE r_xrcd105     LIKE xrcd_t.xrcd105
DEFINE r_xrcd113     LIKE xrcd_t.xrcd113
DEFINE r_xrcd114     LIKE xrcd_t.xrcd114
DEFINE r_xrcd115     LIKE xrcd_t.xrcd115
DEFINE r_success     LIKE type_t.num5
DEFINE l_pmdnseq     LIKE pmdn_t.pmdnseq
DEFINE l_n           LIKE type_t.num5

      LET r_success = TRUE
      IF cl_null(p_pmdldocno) THEN
         RETURN r_success,r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115 
      END IF
      
      CALL s_tax_recount_tmp()
      CALL s_tax_recount(p_pmdldocno)
        RETURNING r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115
      
      #产生多交期单身
      DECLARE azz_gen_pmdo CURSOR FOR
          SELECT pmdnseq FROM pmdn_t WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno
      FOREACH azz_gen_pmdo INTO l_pmdnseq
         IF NOT s_apmt500_gen_pmdo(p_pmdldocno,l_pmdnseq) THEN
            LET r_success = FALSE
            RETURN r_success,r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115
         END IF
         
         SELECT COUNT(*) INTO l_n FROM pmdq_t WHERE pmdqent = g_enterprise AND pmdqdocno = p_pmdldocno AND pmdqseq = l_pmdnseq
         IF l_n > 1 THEN
            UPDATE pmdn_t SET pmdn024 = 'Y' WHERE pmdnent = g_enterprise AND pmdndocno = p_pmdldocno AND pmdnseq = l_pmdnseq
         END IF
      END FOREACH
      
      
      
      RETURN r_success,r_xrcd103,r_xrcd104,r_xrcd105,r_xrcd113,r_xrcd114,r_xrcd115 
      
END FUNCTION

################################################################################
# Descriptions...: 最终客户欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl032(p_pmdldocno,p_pmdl032,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
#################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl032(p_pmdldocno,p_pmdl032,p_field)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE p_pmdl032     LIKE pmdl_t.pmdl032
DEFINE r_pmdl032     LIKE pmdl_t.pmdl032
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10

   LET r_success = TRUE
   LET r_pmdl032 = ''
   LET r_pmdl032 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl032)
   IF cl_null(r_pmdl032) THEN
      LET r_pmdl032 = p_pmdl032
   END IF
   
   IF NOT cl_null(r_pmdl032) THEN
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = r_pmdl032
      LET g_chkparam.arg2 = g_site
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_pmaa001_3") THEN
         LET r_success = FALSE
      END IF      
   END IF
   RETURN r_success,r_pmdl032
   
END FUNCTION

################################################################################
# Descriptions...: 发票类型欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl033(p_pmdldocno,p_pmdl033,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
#################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl033(p_pmdldocno,p_pmdl004,p_pmdl033,p_field)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE p_pmdl033     LIKE pmdl_t.pmdl033
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE r_pmdl033     LIKE pmdl_t.pmdl033
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10
DEFINE l_ooef019     LIKE ooef_t.ooef019

   LET r_success = TRUE
   LET r_pmdl033 = ''
   LET r_pmdl033 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl033)
   IF cl_null(r_pmdl033) THEN
      LET r_pmdl033 = p_pmdl033
   END IF
   IF cl_null(r_pmdl033) THEN
      SELECT pmab056 INTO r_pmdl033 FROM pmab_t 
         WHERE pmabent = g_enterprise AND pmabsite = g_site AND pmab001 = p_pmdl004
   END IF
   IF NOT cl_null(r_pmdl033) THEN
      SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = l_ooef019
      LET g_chkparam.arg2 = r_pmdl033
      
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_isac002_1") THEN
         LET r_success = FALSE
      END IF      
   END IF
   RETURN r_success,r_pmdl033
   
END FUNCTION

################################################################################
# Descriptions...: 多角流程编号欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdl051(p_pmdldocno,p_pmdl006,p_pmdl051,p_field)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
#################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdl051(p_pmdldocno,p_pmdl006,p_pmdl051,p_field)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl006     LIKE pmdl_t.pmdl006
DEFINE p_pmdl051     LIKE pmdl_t.pmdl051
DEFINE r_pmdl051     LIKE pmdl_t.pmdl051
DEFINE r_success     LIKE type_t.num5
DEFINE p_field       LIKE type_t.chr10
DEFINE l_gzcbl004    LIKE gzcbl_t.gzcbl004 

   LET r_success = TRUE
   LET r_pmdl051 = ''
   LET r_pmdl051 = s_aooi200_get_doc_default(g_site,'1',p_pmdldocno,p_field,p_pmdl051)
   IF cl_null(r_pmdl051) THEN
      LET r_pmdl051 = p_pmdl051
   END IF
   
   IF NOT cl_null(r_pmdl051) THEN
     #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
     INITIALIZE g_chkparam.* TO NULL
     #160318-00025#15 by 07900 --add-str 
     LET g_errshow = TRUE #是否開窗
     #160318-00025#15 by 07900 --add-end
     #呼叫檢查存在並帶值的library
     #2:代採購
     IF p_pmdl006 = '2' THEN
        #設定g_chkparam.*的參數
        LET g_chkparam.arg1 = r_pmdl051
        LET g_chkparam.arg2 = '2'
        LET g_chkparam.arg3 = '0'
        LET g_chkparam.arg4 = g_site
        
        #替換錯誤訊息
        LET l_gzcbl004 = ''
        SELECT gzcbl004 INTO l_gzcbl004
          FROM gzcbl_t
         WHERE gzcbl001 = '2501'
           AND gzcbl002 = '2'
           AND gzcbl003 = g_dlang
        LET l_gzcbl004 = g_chkparam.arg2,".",l_gzcbl004
        LET g_chkparam.err_str[1] = "aic-00084|",l_gzcbl004
        LET g_chkparam.err_str[2] = "aic-00085|",g_chkparam.arg3
      
     END IF
     #3:代採購指定供應商
     IF p_pmdl006 = '3' THEN
        #設定g_chkparam.*的參數
        LET g_chkparam.arg1 = r_pmdl051
        LET g_chkparam.arg2 = '3'
        LET g_chkparam.arg3 = '0'
        LET g_chkparam.arg4 = g_site
        
        #替換錯誤訊息
        LET l_gzcbl004 = ''
        SELECT gzcbl004 INTO l_gzcbl004
          FROM gzcbl_t
         WHERE gzcbl001 = '2501'
           AND gzcbl002 = '3'
           AND gzcbl003 = g_dlang
        LET l_gzcbl004 = g_chkparam.arg2,".",l_gzcbl004
        LET g_chkparam.err_str[1] = "aic-00084|",l_gzcbl004
        LET g_chkparam.err_str[2] = "aic-00085|",g_chkparam.arg3
        
     END IF
     #160318-00025#15 by 07900 --add-str 
     LET g_chkparam.err_str[3] ="aic-00012:sub-01302|aici100|",cl_get_progname("aici100",g_lang,"2"),"|:EXEPROGaici100"
     #160318-00025#15 by 07900 --add-end
                       
     IF NOT cl_chk_exist("v_icaa001_1") THEN
        LET r_success = FALSE
     END IF
     
     #多角製造批序號檢查
     IF NOT s_apmt500_inao_chk(p_pmdldocno,r_pmdl051,'') THEN
        LET r_success = FALSE
     END IF
   END IF
   RETURN r_success,r_pmdl051
   
END FUNCTION

################################################################################
# Descriptions...: 地址欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdm005(p_pmdl011,p_pmdl013,p_pmdl015,p_pmdl016,p_pmdl046,p_pmdm014,p_pmdm005)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdm005(p_pmdl011,p_pmdl013,p_pmdl015,p_pmdl016,p_pmdl046,p_pmdm014,p_pmdm005)
DEFINE p_pmdl011     LIKE pmdl_t.pmdl011
DEFINE p_pmdl013     LIKE pmdl_t.pmdl013
DEFINE p_pmdl015     LIKE pmdl_t.pmdl015
DEFINE p_pmdl016     LIKE pmdl_t.pmdl016
DEFINE p_pmdl046     LIKE pmdl_t.pmdl046
DEFINE p_pmdm014     LIKE pmdm_t.pmdm014
DEFINE p_pmdm005     LIKE pmdm_t.pmdm005
DEFINE r_pmdm005     LIKE pmdm_t.pmdm005
DEFINE r_pmdm006     LIKE pmdm_t.pmdm006
DEFINE r_success     LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_xrcd103     LIKE xrcd_t.xrcd103
DEFINE l_xrcd104     LIKE xrcd_t.xrcd104
DEFINE l_xrcd105     LIKE xrcd_t.xrcd105
DEFINE l_xrcd113     LIKE xrcd_t.xrcd113
DEFINE l_xrcd114     LIKE xrcd_t.xrcd114
DEFINE l_xrcd115     LIKE xrcd_t.xrcd115

   LET r_success = TRUE
   LET r_pmdm005 = 0
   LET r_pmdm006 = 0
   
   IF NOT cl_ap_chk_range(p_pmdm005,"0.000","0","","","azz-00079",1) THEN
      LET r_success = FALSE
      RETURN r_success,r_pmdm005,r_pmdm006
   END IF
   
   IF p_pmdm005 > 0 THEN
      IF p_pmdl046 = '1' AND p_pmdm014 = '2' THEN
         #含稅金額=未稅金額
         LET r_pmdm006 = p_pmdm005
         LET r_pmdm005 = p_pmdm005
      ELSE
         #單價含稅時，可錄入含稅金額，
         IF p_pmdl013 = 'Y' THEN
            LET r_pmdm006 = p_pmdm005
            CALL s_tax_count(g_site,p_pmdl011,r_pmdm006,0,p_pmdl015,p_pmdl016)
               RETURNING r_pmdm005,l_xrcd104,l_xrcd105,l_xrcd113,l_xrcd114,l_xrcd115
         ELSE
            LET r_pmdm005 = p_pmdm005
            CALL s_tax_count(g_site,p_pmdl011,r_pmdm005,0,p_pmdl015,p_pmdl016)
               RETURNING l_xrcd103,l_xrcd104,r_pmdm006,l_xrcd113,l_xrcd114,l_xrcd115
         END IF
         
      END IF
      
      #呼叫幣別取位應用元件對單價作取位(依單頭幣別做取位基準)
      CALL s_curr_round(g_site,p_pmdl015,r_pmdm005,'2') RETURNING r_pmdm005
      CALL s_curr_round(g_site,p_pmdl015,r_pmdm006,'2') RETURNING r_pmdm006       
      
   END IF
   
   RETURN r_success,r_pmdm005,r_pmdm006
   
END FUNCTION

################################################################################
# Descriptions...: 交货日期欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdq003(p_pmdn001,p_pmdq003,p_pmdq004,p_pmdq005)
#                  RETURNING r_success
# Date & Author..: 2016/07/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdq003(p_pmdn001,p_pmdq003,p_pmdq004,p_pmdq005)
DEFINE p_pmdn001    LIKE pmdn_t.pmdn001
DEFINE p_pmdq003    LIKE pmdq_t.pmdq003
DEFINE p_pmdq004    LIKE pmdq_t.pmdq004
DEFINE p_pmdq005    LIKE pmdq_t.pmdq005
DEFINE r_pmdq003    LIKE pmdq_t.pmdq003
DEFINE r_pmdq004    LIKE pmdq_t.pmdq004
DEFINE r_pmdq005    LIKE pmdq_t.pmdq005
DEFINE r_success    LIKE type_t.num5
DEFINE l_imaf173    LIKE imaf_t.imaf173
DEFINE l_imaf174    LIKE imaf_t.imaf174
DEFINE l_ooef008    LIKE ooef_t.ooef008
DEFINE l_ooef009    LIKE ooef_t.ooef009
   
   LET r_success = TRUE
   LET r_pmdq003 = p_pmdq003
   LET r_pmdq004 = p_pmdq004
   LET r_pmdq005 = p_pmdq005
   
   SELECT imaf173,imaf174 INTO l_imaf173,l_imaf174
      FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_pmdn001
   SELECT ooef008,ooef009 INTO l_ooef008,l_ooef009 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
   
   IF cl_null(p_pmdq003) THEN
      IF cl_null(p_pmdq004) THEN
         IF NOT cl_null(p_pmdq005) THEN
            IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,p_pmdq005,0,(l_imaf174*(-1))) RETURNING r_pmdq004
            ELSE
               LET r_pmdq004 = p_pmdq005
            END IF   
            
            IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,r_pmdq004,0,(l_imaf173*(-1))) RETURNING r_pmdq003
            ELSE
               LET r_pmdq003 = r_pmdq004
            END IF
         END IF
      ELSE
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,r_pmdq004,0,(l_imaf173*(-1))) RETURNING r_pmdq003
         ELSE
            LET r_pmdq003 = r_pmdq004
         END IF
         IF cl_null(p_pmdq005) THEN
            IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,p_pmdq004,0,l_imaf174) RETURNING r_pmdq005
            ELSE
               LET r_pmdq005 = p_pmdq004
            END IF
         END IF
      END IF
   ELSE
      IF cl_null(p_pmdq004) THEN
         IF (NOT cl_null(l_imaf173)) AND l_imaf173 <> 0 THEN
            CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,p_pmdq003,0,l_imaf173) RETURNING r_pmdq004
         ELSE
            LET r_pmdq004 = p_pmdq003
         END IF
      ELSE
         IF cl_null(p_pmdq005) THEN
            IF (NOT cl_null(l_imaf174)) AND l_imaf174 <> 0 THEN
               CALL s_date_get_work_date(g_site,l_ooef008,l_ooef009,r_pmdq004,0,l_imaf174) RETURNING r_pmdq005
            ELSE
               LET r_pmdq005 = r_pmdq004
            END IF
         END IF
      END IF
   END IF
   
   IF (NOT cl_null(r_pmdq003)) AND (NOT cl_null(r_pmdq004)) AND (NOT cl_null(r_pmdq005)) THEN
      IF r_pmdq004 < r_pmdq003 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00267'
         LET g_errparam.extend = r_pmdq004
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_pmdq003,r_pmdq004,r_pmdq005
      END IF
      
      IF r_pmdq005 < r_pmdq004 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00271'
         LET g_errparam.extend = r_pmdq005
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_pmdq003,r_pmdq004,r_pmdq005
      END IF
      
      IF r_pmdq005 < r_pmdq003 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00272'
         LET g_errparam.extend = r_pmdq005
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success,r_pmdq003,r_pmdq004,r_pmdq005
      END IF
      
   END IF

   RETURN r_success,r_pmdq003,r_pmdq004,r_pmdq005
   

END FUNCTION

################################################################################
# Descriptions...: 来源单号欄位--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdp003(p_pmdldocno,p_pmdl007,p_pmdp003)
#                  RETURNING r_success
# Date & Author..: 2016/08/9 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdp003(p_pmdldocno,p_pmdl007,p_pmdp003)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl007     LIKE pmdl_t.pmdl007
DEFINE p_pmdp003     LIKE pmdp_t.pmdp003
DEFINE r_success     LIKE type_t.num5

   LET r_success = TRUE
   
   #150909 earl add s
   IF NOT s_aooi210_check_doc(g_site,'',p_pmdp003,p_pmdldocno,'4','') THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #150909 earl add e
   
   CASE p_pmdl007
      WHEN '2'  #請購單
         #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
         INITIALIZE g_chkparam.* TO NULL
    
         #設定g_chkparam.*的參數
         LET g_chkparam.arg1 = p_pmdp003
    
         #呼叫檢查存在並帶值的library
         IF NOT cl_chk_exist("v_pmdadocno") THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
     #WHEN '3'  #訂單
     #WHEN '4'  #工單
     #WHEN '5'  #MRP
   END CASE
   RETURN r_success
  
END FUNCTION
################################################################################
# Descriptions...: 来源单号欄位--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdp004(p_pmdldocno,p_pmdl007,p_pmdl004,p_pmdn006,p_pmdp003,p_pmdp004)
#                  RETURNING r_success
# Date & Author..: 2016/08/9 By lixiang
# Modify.........: #160324-00038#39 add
######################################################################################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdp004(p_pmdldocno,p_pmdl007,p_pmdl004,p_pmdn006,p_pmdp003,p_pmdp004)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdl007     LIKE pmdl_t.pmdl007
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdp003     LIKE pmdp_t.pmdp003
DEFINE p_pmdp004     LIKE pmdp_t.pmdp004
DEFINE p_pmdn006     LIKE pmdn_t.pmdn006
DEFINE r_success     LIKE type_t.num5
DEFINE l_pmdb049     LIKE pmdb_t.pmdb049
DEFINE l_pmdb006     LIKE pmdb_t.pmdb006
DEFINE l_pmdb014     LIKE pmdb_t.pmdb014
DEFINE l_pmdb015     LIKE pmdb_t.pmdb015
DEFINE l_pmdb032     LIKE pmdb_t.pmdb032
DEFINE l_pmdp023     LIKE pmdp_t.pmdp023
DEFINE r_pmdp007     LIKE pmdp_t.pmdp007
DEFINE r_pmdp008     LIKE pmdp_t.pmdp008
DEFINE r_pmdp009     LIKE pmdp_t.pmdp009
DEFINE r_pmdp010     LIKE pmdp_t.pmdp010
DEFINE r_pmdp011     LIKE pmdp_t.pmdp011
DEFINE r_pmdp012     LIKE pmdp_t.pmdp012
DEFINE r_pmdp021     LIKE pmdp_t.pmdp021
DEFINE r_pmdp022     LIKE pmdp_t.pmdp022
DEFINE r_pmdp023     LIKE pmdp_t.pmdp023
DEFINE r_pmdp024     LIKE pmdp_t.pmdp024
DEFINE l_success     LIKE type_t.num5

       LET r_success = TRUE
       
       LET r_pmdp007 = ''
       LET r_pmdp008 = ''
       LET r_pmdp009 = ''
       LET r_pmdp010 = ''
       LET r_pmdp011 = ''
       LET r_pmdp012 = ''
       #LET r_pmdp021 = 1
       LET r_pmdp022 = ''
       LET r_pmdp023 = 0
       LET r_pmdp024 = 0

       LET l_pmdb049 = ''
       LET l_pmdb006 = ''
       LET l_pmdb014 = ''
       LET l_pmdb015 = ''
       SELECT SUM(pmdp023) INTO l_pmdp023 FROM pmdp_t,pmdl_t 
         WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno AND pmdlstus = 'N'
           AND pmdpent = g_enterprise AND pmdp003 = p_pmdp003 AND pmdp004 = p_pmdp004
       IF cl_null(l_pmdp023) THEN
          LET l_pmdp023 = 0
       END IF
       
       CASE p_pmdl007
          WHEN '2'  #請購單
             SELECT NVL(pmdb049,0),NVL(pmdb006,0),pmdb014,pmdb015,pmdb032 
                INTO l_pmdb049,l_pmdb006,l_pmdb014,l_pmdb015,l_pmdb032
               FROM pmdb_t 
               WHERE pmdbent = g_enterprise AND pmdbdocno = p_pmdp003 AND pmdbseq = p_pmdp004
             CASE WHEN SQLCA.sqlcode = 100
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'apm-00295'
                       LET g_errparam.extend = p_pmdp004
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET r_success = FALSE
                  WHEN l_pmdb032 <> '1'  #結案狀態不可錄入
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'sub-00437'
                       LET g_errparam.extend = p_pmdp004
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET r_success = FALSE
                  WHEN l_pmdb049 >= l_pmdb006 - l_pmdp023  #已轉採購量大於等於需求量
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'apm-00296'
                       LET g_errparam.extend = p_pmdp004
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET r_success = FALSE
             END CASE
             IF l_pmdb014 = '3' AND l_pmdb015 <> p_pmdl004 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00297'
                LET g_errparam.extend = p_pmdp004
                LET g_errparam.popup = TRUE
                CALL cl_err()
                LET r_success = FALSE      
             END IF
             
             SELECT pmdb004,pmdb005,pmdb007,pmdb006 INTO r_pmdp007,r_pmdp008,r_pmdp022,r_pmdp023
               FROM pmdb_t
               WHERE pmdbent = g_enterprise AND pmdbdocno = p_pmdp003 AND pmdbseq = p_pmdp004
             #其他單據或項次上已經維護的數量
             SELECT SUM(pmdp023) INTO l_pmdp023 FROM pmdp_t,pmdl_t 
               WHERE pmdpent = pmdlent AND pmdpdocno = pmdldocno AND pmdlstus = 'N'
                 AND pmdpent = g_enterprise AND pmdp003 = p_pmdp003 AND pmdp004 = p_pmdp004
             IF cl_null(l_pmdp023) THEN
                LET l_pmdp023 = 0
             END IF
             LET r_pmdp023 = r_pmdp023 - l_pmdp023
             IF r_pmdp022 <> p_pmdn006 THEN
                IF (NOT cl_null(r_pmdp022)) AND (NOT cl_null(r_pmdp007)) AND (NOT cl_null(p_pmdn006)) THEN
                   CALL s_aooi250_convert_qty(r_pmdp007,r_pmdp022,p_pmdn006,r_pmdp023)
                       RETURNING l_success,r_pmdp024
                END IF
             ELSE
                LET r_pmdp024 = r_pmdp023
             END IF
         #WHEN '3'  #訂單
         #WHEN '4'  #工單
         #WHEN '5'  #MRP
       END CASE
       RETURN r_success,r_pmdp007,r_pmdp008,r_pmdp009,r_pmdp010,r_pmdp011,r_pmdp012,r_pmdp022,r_pmdp023,r_pmdp024
  
END FUNCTION

################################################################################
# Descriptions...: 冲销顺序欄位--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdp021(p_pmdldocno,p_pmdnseq,p_pmdp021)
#                  RETURNING r_success
# Date & Author..: 2016/08/9 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdp021(p_pmdldocno,p_pmdnseq,p_pmdp021)
DEFINE p_pmdldocno    LIKE pmdl_t.pmdldocno
DEFINE p_pmdnseq      LIKE pmdn_t.pmdnseq
DEFINE p_pmdp021      LIKE pmdp_t.pmdp021
DEFINE r_pmdp021      LIKE pmdp_t.pmdp021
DEFINE r_success      LIKE type_t.num5

     LET r_success = TRUE
     LET r_pmdp021 = p_pmdp021
     IF NOT cl_null(p_pmdp021) THEN

        IF NOT cl_ap_chk_range(p_pmdp021,"0.000","0","","","azz-00079",1) THEN
           LET r_success = FALSE
           LET r_pmdp021 = ''
        END IF 
        IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmdp_t WHERE "||"pmdpent = '" ||g_enterprise|| "' AND "||"pmdpdocno = '"||p_pmdldocno ||"' AND "|| "pmdpseq = '"||p_pmdnseq ||"'",'apm-00298',1) THEN 
           LET r_success = FALSE
           LET r_pmdp021 = ''
        END IF
     END IF
     IF NOT cl_null(r_pmdp021) THEN
        SELECT MAX(pmdp021)+1 INTO r_pmdp021 FROM pmdp_t WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno AND pmdpseq = p_pmdnseq
        IF cl_null(r_pmdp021) OR r_pmdp021 = 0 THEN
           LET r_pmdp021 = 1
        END IF
     END IF
     
     RETURN r_success,r_pmdp021    
     
END FUNCTION

################################################################################
# Descriptions...: 应用组织欄位--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdnunit(p_type,p_pmdnunit)
#                  RETURNING r_success
# Date & Author..: 2016/08/9 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdnunit(p_type,p_pmdnunit)
DEFINE p_type        LIKE type_t.chr1   #1：收货据点、2：付款据点
DEFINE p_pmdnunit    LIKE pmdn_t.pmdnunit
DEFINE r_pmdnunit    LIKE pmdn_t.pmdnunit
DEFINE r_success     LIKE type_t.num5
DEFINE l_oofa001     LIKE oofa_t.oofa001
DEFINE l_success     LIKE type_t.num5
DEFINE l_flag        LIKE type_t.num5

    LET r_success = TRUE
    
    IF cl_null(p_pmdnunit) THEN
       LET p_pmdnunit = g_site
    ELSE
       #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
       INITIALIZE g_chkparam.* TO NULL
       #160318-00025#15 by 07900 --add-str 
       LET g_errshow = TRUE #是否開窗
       #160318-00025#15 by 07900 --add-end
       
       #設定g_chkparam.*的參數
       LET g_chkparam.arg1 = p_pmdnunit
       #160318-00025#15 by 07900 --add-str 
       LET g_chkparam.err_str[1] ="aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
       #160318-00025#15 by 07900 --add-end
       
       #呼叫檢查存在並帶值的library
       IF NOT cl_chk_exist("v_ooef001") THEN
          LET r_success = FALSE
       END IF
       #檢核輸入的營運據點是否在採購控制組的限制範圍內
       CALL s_control_chk_group('5','4',g_user,g_dept,p_pmdnunit ,'','','','') RETURNING l_success,l_flag
       IF NOT l_success THEN      #处理状态
          LET r_success = FALSE
       ELSE
          IF NOT l_flag THEN      #是否存在
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'apm-00274'
             LET g_errparam.extend = p_pmdnunit
             LET g_errparam.popup = TRUE
             CALL cl_err()
             LET r_success = FALSE
          END IF 
       END IF
       
    END IF
    LET r_pmdnunit = p_pmdnunit
    RETURN r_success,r_pmdnunit
END FUNCTION

################################################################################
# Descriptions...: 料號欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdn001(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl051,p_pmdnseq,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdn007)
#                  RETURNING r_success
# Date & Author..: 2016/08/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdn001(p_pmdldocno,p_pmdldocdt,p_pmdl004,p_pmdl051,p_pmdnseq,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdn007)
DEFINE p_pmdldocno   LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt   LIKE pmdl_t.pmdldocdt
DEFINE p_pmdl004     LIKE pmdl_t.pmdl004
DEFINE p_pmdl051     LIKE pmdl_t.pmdl051
DEFINE p_pmdnseq     LIKE pmdn_t.pmdnseq
DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
DEFINE p_pmdn002     LIKE pmdn_t.pmdn002
DEFINE p_pmdn004     LIKE pmdn_t.pmdn004
DEFINE p_pmdn005     LIKE pmdn_t.pmdn005
DEFINE p_pmdn007     LIKE pmdn_t.pmdn007
DEFINE l_flag        LIKE type_t.num5
DEFINE l_success     LIKE type_t.num5
DEFINE l_ooba002     LIKE ooba_t.ooba002
DEFINE l_pmdp007     LIKE pmdp_t.pmdp007
DEFINE r_success     LIKE type_t.num5
DEFINE l_pmdp008     LIKE pmdp_t.pmdp008

       LET r_success = TRUE
       
       IF NOT cl_null(p_pmdn001) THEN 
          #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
          INITIALIZE g_chkparam.* TO NULL
          
          #設定g_chkparam.*的參數
          LET g_chkparam.arg1 = p_pmdn001
             
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
          CALL s_control_chk_group('3','4',g_user,g_dept,p_pmdn001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'apm-00265'
                LET g_errparam.extend = p_pmdn001
                LET g_errparam.popup = TRUE
                CALL cl_err()

                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的生命週期是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('4',p_pmdldocno,p_pmdn001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                #CALL cl_err(p_pmdn001,'ain-00015',1)
                LET r_success = FALSE
                RETURN r_success
             END IF 
          END IF
          
          #檢核輸入的料件的產品分類是否在單據別限制範圍內，若不在限制內則不允許請購此料
          CALL s_control_chk_doc('5',p_pmdldocno,p_pmdn001,'','','','') RETURNING l_success,l_flag
          IF NOT l_success THEN      #处理状态
             LET r_success = FALSE
             RETURN r_success
          ELSE
             IF NOT l_flag THEN      #是否存在
                LET r_success = FALSE
                #CALL cl_err(p_pmdn001,'apm-00238',1)
                RETURN r_success
             END IF 
          END IF
          
          #若單據別設置是要作請採勾稽時，則修改料號時必須檢核是否與"關聯單據明細"中的來源料號有替代關係
          CALL s_aooi200_get_slip(p_pmdldocno) RETURNING l_success,l_ooba002
          IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0061') = "Y" THEN
             DECLARE pmdp007_cur CURSOR FOR
                SELECT DISTINCT pmdp007,pmdp008 FROM pmdp_t 
                  WHERE pmdpent = g_enterprise AND pmdpdocno = p_pmdldocno
                    AND pmdpseq = p_pmdnseq
             FOREACH pmdp007_cur INTO l_pmdp007,l_pmdp008
                IF l_pmdp007 <> p_pmdn001 THEN
                   #請採購替代是否依據BOM替代資料
                   #選Y時，代表請購轉採購時可以依據BOM替代資料進行採購料的替代
                   #若選N，則是依據apmi131採購替代原則的設定進行採購料的替代
                   IF cl_get_doc_para(g_enterprise,g_site,l_ooba002,'D-BAS-0096') = "Y" THEN
                      IF NOT s_apmt500_chk_bom_replace(l_pmdp007,p_pmdn001,p_pmdn002) THEN
                         LET r_success = FALSE
                         RETURN r_success
                      END IF
                   ELSE                   
                      IF NOT s_pmaq_chk_replacement(p_pmdl004,l_pmdp007,p_pmdn001,'2',l_pmdp008,p_pmdn002) THEN
                         LET r_success = FALSE
                         RETURN r_success
                      END IF
                   END IF
                   
                END IF
             END FOREACH
          END IF
          
          #檢查料件編號是否符合條件
          IF NOT s_apmt500_item_avl_chk(p_pmdldocdt,p_pmdn001,p_pmdn002,p_pmdn004,p_pmdn005,p_pmdl004,p_pmdn007,p_pmdldocno,p_pmdnseq) THEN #add by lixiang 2015/10/15 pmdn007 #add by lixiang 2015/12/04 add pmdldocno，pmdnseq
             LET r_success = FALSE
             RETURN r_success
          END IF
          
          #151229 earl add s
          #多角製造批序號檢查
          IF NOT s_apmt500_inao_chk(p_pmdldocno,p_pmdl051,p_pmdn001) THEN
             LET r_success = FALSE
             RETURN r_success
          END IF
          #151229 earl add e
          
       END IF
       RETURN r_success
       
END FUNCTION

################################################################################
# Descriptions...: 參考數量欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdn009(p_pmdn001,p_pmdn006,p_pmdn007,p_pmdn008,p_pmdn009)
#                  RETURNING r_success
# Date & Author..: 2016/08/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdn009(p_pmdn001,p_pmdn006,p_pmdn007,p_pmdn008,p_pmdn009)
DEFINE p_pmdn001     LIKE pmdn_t.pmdn001
DEFINE p_pmdn006     LIKE pmdn_t.pmdn006
DEFINE p_pmdn007     LIKE pmdn_t.pmdn007
DEFINE p_pmdn008     LIKE pmdn_t.pmdn008
DEFINE p_pmdn009     LIKE pmdn_t.pmdn009
DEFINE r_pmdn008     LIKE pmdn_t.pmdn008
DEFINE r_pmdn009     LIKE pmdn_t.pmdn009
DEFINE l_success     LIKE type_t.num5
DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_pmdn008 = p_pmdn008
   LET r_pmdn009 = p_pmdn009
   
   IF NOT cl_null(r_pmdn008) THEN
      INITIALIZE g_chkparam.* TO NULL
         
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = p_pmdn001
      LET g_chkparam.arg2 = r_pmdn008
       
      #呼叫檢查存在並帶值的library
      IF NOT cl_chk_exist("v_imao002") THEN
         LET r_success = FALSE  
      ELSE
         IF NOT cl_null(r_pmdn009) THEN
            IF NOT cl_ap_chk_range(r_pmdn009,"0.000","1","","","azz-00079",1) THEN
               LET r_success = FALSE 
            ELSE
               CALL s_aooi250_take_decimals(r_pmdn008,r_pmdn009) RETURNING l_success,r_pmdn009 
            END IF
         ELSE
            IF NOT cl_null(r_pmdn008) THEN
               CALL s_aooi250_convert_qty(p_pmdn001,p_pmdn006,r_pmdn008,p_pmdn007) RETURNING l_success,r_pmdn009
            END IF
         END IF               
      END IF
   ELSE
      SELECT imaf015 INTO r_pmdn008 FROM imaf_t WHERE imafent = g_enterprise AND imafsite = g_site AND imaf001 = p_pmdn001
      IF NOT cl_null(r_pmdn008) THEN
         CALL s_aooi250_convert_qty(p_pmdn001,p_pmdn006,r_pmdn008,p_pmdn007) RETURNING l_success,r_pmdn009
      END IF
   END IF
   
   RETURN r_success,r_pmdn008,r_pmdn009
   
END FUNCTION

################################################################################
# Descriptions...: 取價來源欄位的檢查--開張設定作業中使用azzp660
# Memo...........:
# Usage..........: CALL s_apmt500_chk_pmdn040(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)
#                  RETURNING r_success
# Date & Author..: 2016/08/12 By lixiang
# Modify.........: #160324-00038#39 add
################################################################################
PUBLIC FUNCTION s_apmt500_chk_pmdn040(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)
DEFINE p_pmdl017    LIKE pmdl_t.pmdl017
DEFINE p_pmdl004    LIKE pmdl_t.pmdl004
DEFINE p_pmdn001    LIKE pmdn_t.pmdn001
DEFINE p_pmdn002    LIKE pmdn_t.pmdn002
DEFINE p_pmdl015    LIKE pmdl_t.pmdl015
DEFINE p_pmdn016    LIKE pmdl_t.pmdl011
DEFINE p_pmdl009    LIKE pmdl_t.pmdl009
DEFINE p_pmdl010    LIKE pmdl_t.pmdl010
DEFINE p_pmdl023    LIKE pmdl_t.pmdl023
DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
DEFINE p_pmdldocdt  LIKE pmdl_t.pmdldocdt
DEFINE p_pmdn010    LIKE pmdn_t.pmdn010
DEFINE p_pmdn011    LIKE pmdn_t.pmdn011
DEFINE p_site       LIKE pmdl_t.pmdlsite
DEFINE p_pmdl054    LIKE pmdl_t.pmdl054
DEFINE p_type       LIKE type_t.chr1    #單價類型(1.一般，2.委外)
DEFINE p_pmdn004    LIKE pmdn_t.pmdn004
DEFINE p_pmdn005    LIKE pmdn_t.pmdn005
DEFINE r_pmdn040    LIKE pmdn_t.pmdn040
DEFINE r_pmdn043    LIKE pmdn_t.pmdn043
DEFINE r_pmdn041    LIKE pmdn_t.pmdn041
DEFINE r_pmdn042    LIKE pmdn_t.pmdn042

     LET r_pmdn040 = ''
     LET r_pmdn043 = ''
     LET r_pmdn041 = ''
     LET r_pmdn042 = ''
     
     
     CALL s_apmt500_get_price(p_pmdl017,p_pmdl004,p_pmdn001,p_pmdn002,p_pmdl015,p_pmdn016,
                              p_pmdl009,p_pmdl010,p_pmdl023,p_pmdldocno,p_pmdldocdt,p_pmdn010,
                              p_pmdn011,p_site,p_pmdl054,p_type,p_pmdn004,p_pmdn005)          
           RETURNING r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042
     IF r_pmdn040 = 'X' THEN  #取不到單價時，取價來源給'',X 不在來源選項中
        LET r_pmdn040 = ''
     END IF
     RETURN r_pmdn040,r_pmdn043,r_pmdn041,r_pmdn042

END FUNCTION
################################################################################
# Descriptions...: 調整金額尾差
# Memo...........:
# Usage..........: CALL s_apmt500_adjust_pmdn(p_pmdldocno,p_xrcd103,p_xrcd104,p_xrcd105)
# Input parameter: p_xrcd103   原幣未稅金額
#                : p_xrcd104   原幣稅額
#                : p_xrcd105   原幣含稅金額
# Return code....: 
# Date & Author..: #161128-00011#1 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION s_apmt500_adjust_pmdn(p_pmdldocno,p_xrcd103,p_xrcd104,p_xrcd105)
   DEFINE l_pmdn046    LIKE pmdn_t.pmdn046
   DEFINE l_pmdn047    LIKE pmdn_t.pmdn047
   DEFINE l_pmdn048    LIKE pmdn_t.pmdn048
   DEFINE l_pmdnseq    LIKE pmdn_t.pmdnseq
   DEFINE p_pmdldocno  LIKE pmdl_t.pmdldocno
   DEFINE p_xrcd103    LIKE xrcd_t.xrcd103
   DEFINE p_xrcd104    LIKE xrcd_t.xrcd104
   DEFINE p_xrcd105    LIKE xrcd_t.xrcd105
   DEFINE r_success    LIKE type_t.num5
   
   LET l_pmdn046 = 0
   LET l_pmdn047 = 0
   LET l_pmdn048 = 0
   LET l_pmdnseq = ''
   LET r_success = TRUE
   
   #抓取出貨總金額(未稅、含稅、稅額)
   SELECT SUM(pmdn046),SUM(pmdn047),SUM(pmdn048)
     INTO l_pmdn046,l_pmdn047,l_pmdn048
     FROM pmdn_t
    WHERE pmdnent = g_enterprise
      AND pmdnsite = g_site
      AND pmdndocno = p_pmdldocno
      
   #調整金額(未稅、含稅、稅額)
   IF p_xrcd103 <> l_pmdn046 OR p_xrcd104 <> l_pmdn048 OR p_xrcd105 <> l_pmdn047 THEN
      #抓取最大筆金額的項次
      SELECT pmdnseq INTO l_pmdnseq
        FROM pmdn_t
       WHERE pmdnent = g_enterprise
         AND pmdnsite = g_site
         AND pmdndocno = p_pmdldocno
       ORDER BY pmdn046 DESC
     #補尾差
     UPDATE pmdn_t SET pmdn046 = pmdn046 + (p_xrcd103-l_pmdn046),
                       pmdn047 = pmdn047 + (p_xrcd105-l_pmdn047),
                       pmdn048 = pmdn048 + (p_xrcd104-l_pmdn048)
       WHERE pmdnent = g_enterprise
         AND pmdnsite = g_site
         AND pmdndocno = p_pmdldocno
         AND pmdnseq = l_pmdnseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "UPDATE pmdn_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()     
         LET r_success = FALSE
         RETURN r_success         
      END IF 
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明:根據單位取位類型對數量進行取位
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........: 161229-00014
################################################################################
PUBLIC FUNCTION s_apmt500_unit_round(p_pmdn006,p_pmdn007)
DEFINE p_pmdn006   LIKE pmdn_t.pmdn006     #單位
DEFINE p_pmdn007   LIKE pmdn_t.pmdn007     #數量
DEFINE l_success   LIKE type_t.num5
DEFINE l_ooca002   LIKE ooca_t.ooca002      #小数位数
DEFINE l_ooca004   LIKE ooca_t.ooca004      #舍入类型 
DEFINE r_pmdn007   LIKE pmdn_t.pmdn007     #數量
        
       LET l_success = NULL
       LET l_ooca002 = 0
       LET l_ooca004 = NULL
       LET r_pmdn007 = 0
       
       #抓取单位档中的小数位数和舍入类型
       IF NOT cl_null(p_pmdn006) THEN
          CALL s_aooi250_get_msg(p_pmdn006) RETURNING l_success,l_ooca002,l_ooca004
          IF l_success THEN
             IF NOT cl_null(p_pmdn007) THEN
                CALL s_num_round(l_ooca004,p_pmdn007,l_ooca002) RETURNING r_pmdn007
                RETURN r_pmdn007
             END IF
          END IF
       END IF
       RETURN r_pmdn007
END FUNCTION

################################################################################
# Descriptions...: 为代采购 多角采购单，采购单提交BPM审核结束后，自动抛转
# Memo...........:
# Usage..........: CALL s_apmt500_ws_postprocess()
#                  RETURNING r_success
# Date & Author..: 2017/02/03 By lixiang
# Modify.........: 170111-00017#1
################################################################################
PUBLIC FUNCTION s_apmt500_ws_postprocess()
DEFINE l_pmdl006       LIKE pmdl_t.pmdl006  
DEFINE l_pmdl051       LIKE pmdl_t.pmdl051 
DEFINE l_pmdl030       LIKE pmdl_t.pmdl030  
DEFINE la_param   RECORD
       prog            STRING,
       actionid        STRING,
       background      LIKE type_t.chr1,
       param           DYNAMIC ARRAY OF STRING
                  END RECORD
 
DEFINE ls_js          STRING
DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno
DEFINE r_success       LIKE type_t.num5
DEFINE l_success       LIKE type_t.num5

   LET r_success = TRUE
   LET l_pmdldocno = cl_bpm_get_key_value("pmdldocno")
   
   #委外採購單確認時，如果來源工單的協作據點有輸入，則自動產生協作據點的訂單
   SELECT pmdl006,pmdl051  INTO l_pmdl006,l_pmdl051  
      FROM pmdl_t WHERE pmdlent = g_enterprise AND pmdldocno = l_pmdldocno

   #多角自動拋轉
   IF cl_get_para(g_enterprise,'','E-BAS-0022') = 'Y' AND
      l_pmdl006 MATCHES '[23]' AND
      l_pmdl051 IS NOT NULL THEN  
      INITIALIZE la_param.* TO NULL
      LET la_param.prog     = 'aicp200'
      LET la_param.param[1] = l_pmdldocno
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
      LET l_pmdl030 = ''
      SELECT pmdl030 INTO l_pmdl030
        FROM pmdl_t
       WHERE pmdlent = g_enterprise
         AND pmdldocno = l_pmdldocno
      #多角流程拋轉失敗！
      IF l_pmdl030 <> 'Y' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'aic-00177'
         LET g_errparam.popup  = TRUE
         CALL s_transaction_begin()
         CALL cl_err_collect_init()
         CALL s_apmt500_unconf_upd(l_pmdldocno) RETURNING l_success
         CALL cl_err_collect_show()         
         #170306-00052#1-S 取消確認成功時，將單據狀態回復成W送簽中，並回覆BPM多角流程拋轉失敗，不可結案；取消確認失敗時，BPM可結案
         IF l_success THEN         
            #更新單據狀態碼
            UPDATE pmdl_t SET pmdlstus = 'W'
            WHERE pmdlent = g_enterprise AND pmdldocno = l_pmdldocno
            IF SQLCA.sqlcode THEN        
               CALL s_transaction_end('N','0')
               LET g_success = TRUE
            ELSE
               CALL s_transaction_end('Y','0')
               LET g_success = FALSE           
            END IF
         ELSE
            CALL s_transaction_end('N','0')
            LET g_success = TRUE
         END IF
         #CALL s_transaction_end('Y','0')
         #LET r_success = FALSE
         #RETURN r_success
         #170306-00052#1-E
      END IF
   END IF
   #RETURN r_success  #170306-00052#1 mark
   
END FUNCTION

################################################################################
# Descriptions...:產生1對1採購單
# Memo...........:
# Usage..........: CALL s_apmt500_gen02(p_type,p_key1,p_key2,p_doc_type,p_date,p_combine)
#                  RETURNING r_success,r_str
# Input parameter: p_type         来源类型
#                : p_key1         来源单号
#                : p_key2         来源项次
#                : p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否   
# Return code....: r_success      成功否标识符
#                : r_str     單號匯總
# Date & Author..: 2017/08/07 By 08992  #161227-00046#1
################################################################################
PUBLIC FUNCTION s_apmt500_gen02(p_type,p_key1,p_key2,p_doc_type,p_date,p_combine)
   DEFINE p_type          LIKE type_t.chr1
   DEFINE p_key1          LIKE qcba_t.qcba001
   DEFINE p_key2          LIKE qcba_t.qcba002
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_start_no      LIKE qcba_t.qcbadocno
   DEFINE l_end_no        LIKE qcba_t.qcbadocno
   DEFINE l_str           STRING
   DEFINE l_str1          STRING
   DEFINE r_str           STRING  
   DEFINE r_str1           STRING   
   
   WHENEVER ERROR CONTINUE
   LET r_success   = FALSE
   LET r_str  = ''
   LET r_str1  = ''

   CALL s_apmt500_gen_7(p_key1,p_key2,p_doc_type,p_date,p_combine)
                      RETURNING l_success,l_str,l_str1

   IF NOT l_success THEN
      RETURN r_success,r_str,r_str1
   END IF

   LET r_success  = TRUE
   LET r_str = l_str
   LET r_str1= l_str1

   RETURN r_success,r_str,r_str1

END FUNCTION

################################################################################
# Descriptions...: 从工单產生1對1採購單
# Memo...........:
# Usage..........: CALL s_apmt500_gen_7(p_key1,p_key2,p_doc_type,p_date,p_combine)
#                  RETURNING r_success,r_str
# Input parameter: p_key1         来源单号
#                : p_key2         来源项次
#                : p_doc_type     采购单别
#                : p_date         采购日期
#                : p_combine      汇总否  
# Return code....: r_success      成功否标识符
#                : r_str          匯總單號
# Date & Author..: 2017/08/07 By 08992   #161227-00046#1
################################################################################
PUBLIC FUNCTION s_apmt500_gen_7(p_key1,p_key2,p_doc_type,p_date,p_combine)

   DEFINE p_key1          LIKE qcba_t.qcba001
   DEFINE p_key2          LIKE qcba_t.qcba002
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1   
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_sql           STRING
   DEFINE r_str           STRING
   DEFINE r_str1          STRING
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pmdldocno     LIKE pmdl_t.pmdldocno
   DEFINE l_pmdl          RECORD
                          sfcbdocno     LIKE sfcb_t.sfcbdocno,
                          pmdl004       LIKE pmdl_t.pmdl004,
                          pmdl011       LIKE pmdl_t.pmdl011,
                          pmdl015       LIKE pmdl_t.pmdl015,
                          pmdl017       LIKE pmdl_t.pmdl017
                          END RECORD
   DEFINE l_n             LIKE type_t.num5
   
   LET r_success  = FALSE
   LET r_str = ''
   LET r_str1 = ''

   IF p_combine = 'X' THEN
      LET l_sql = " SELECT UNIQUE sfcbdocno,sfcb013,pmdl011,pmdl015,pmdl017 ",
                  "   FROM asfp400_tmp_t02",
                  "  ORDER BY sfcbdocno,sfcb013 "  
   END IF

   PREPARE s_apmt500_gen_7_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare s_apmt500_gen_7_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_str,r_str1
   END IF

   DECLARE s_apmt500_gen_7_cs1 CURSOR FOR s_apmt500_gen_7_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare s_apmt500_gen_7_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_str,r_str1
   END IF

   FOREACH s_apmt500_gen_7_cs1 INTO l_pmdl.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_apmt500_gen_7_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success,r_str,r_str1
      END IF      


      #插入"pmdl_t:採購單頭檔"
      CALL s_apmt500_gen_4_ins_pmdl(p_doc_type,p_date,p_combine,l_pmdl.*)
           RETURNING l_success,l_pmdldocno
      IF NOT l_success THEN
         RETURN r_success,r_str,r_str1
      END IF
      
      #插入"pmdn_t:採購明細檔"
      CALL s_apmt500_gen_4_ins_pmdn(l_pmdldocno,l_pmdl.*)
           RETURNING l_success           
      IF NOT l_success THEN
         RETURN r_success,r_str,r_str1
      END IF
      
      IF cl_null(r_str) THEN
         LET r_str = " '",l_pmdldocno,"' "
         LET r_str1 = " ",l_pmdldocno," "
      ELSE
         LET r_str = r_str CLIPPED," ,'",l_pmdldocno,"' "  
         LET r_str1 = r_str1 CLIPPED," ,",l_pmdldocno," "           
      END IF         
      
      
   END FOREACH

   LET r_success = TRUE


   RETURN r_success,r_str,r_str1


END FUNCTION

 
{</section>}
 
