#該程式未解開Section, 採用最新樣板產出!
{<section id="s_asfp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(1900-01-01 00:00:00), PR版次:0014(2017-08-18 17:25:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000108
#+ Filename...: s_asfp400
#+ Description: 工單轉委外採購單應用元件集合
#+ Creator....: 00378(2014-04-15 11:37:04)
#+ Modifier...: 00000 -SD/PR- 08992
 
{</section>}
 
{<section id="s_asfp400.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160328-00029#3   2016/03/31  By Jessy  將重複內容的錯誤訊息置換為公用錯誤訊息
#161109-00085#50  2016/11/22  By 08993  整批調整系統星號寫法
#151118-00011#1   2016/11/29  By Sarah  chk_carry_qty段計算可委外數時移除委外完工量(sfcb042)
#170227-00002#1   2017/03/06  By xujing 可委外数与本次委外书比较错误修正
#170223-00052#1   2017/03/06  By xujing     修改可委外数量如果大于单头生产数量则=单头生产数量
#170609-00027#1   2017/06/12  By liuym      可转委外数量考虑生产超交率
#170703-00026#1   2017/07/04  By 08992  增加判斷條件若工單單號相同就跳過單身資料的新增
#170710-00032#1   2017/07/12  By xujing 宣告l_sfca003时 把LIKE type_t.num5 改为 LIKE sfca_t.sfca003
#161227-00046#1   2017/08/04  By 08992  新增工單轉委外採購單時,生產數量都=本次轉委外量,需判斷是否1對1,採購單與工單單號一致
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
 
{<section id="s_asfp400.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

TYPE type_g_sfcb_d     RECORD
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

TYPE type_g_sfac_d     RECORD
                       sfacdocno      LIKE sfac_t.sfacdocno,
                       sfac006        LIKE sfac_t.sfac006,
                       carry_qty      LIKE sfac_t.sfac003
                       END RECORD
                       
DEFINE g_sfcb_d        DYNAMIC ARRAY OF type_g_sfcb_d     
DEFINE g_sfac_d        DYNAMIC ARRAY OF type_g_sfac_d
DEFINE g_rec_b1        LIKE type_t.num10
DEFINE g_sql           STRING
#161227-00046#1-s add                       
GLOBALS
DEFINE g_check_pmdldocno         LIKE type_t.chr1   
END GLOBALS                
DEFINE g_temptype                LIKE type_t.chr1
#161227-00046#1-e add
#end add-point
 
{</section>}
 
{<section id="s_asfp400.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
 
#end add-point
 
{</section>}
 
{<section id="s_asfp400.other_dialog" >}

 
{</section>}
 
{<section id="s_asfp400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 预计交期日检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_sfcb045(p_sfcbdocno,p_b_sfcb044,p_b_sfcb045,p_date)
#                       RETURNING r_success
# Input parameter:p_sfcbdocno    工单号码
#                : p_b_sfcb044    预计开工日
#                : p_b_sfcb045    预计交期
#                : p_date         采购单据日期
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_sfcb045(p_sfcbdocno,p_sfcb044,p_sfcb045,p_date)
   DEFINE p_type         LIKE type_t.chr1
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_sfcb044      LIKE sfcb_t.sfcb044
   DEFINE p_sfcb045      LIKE sfcb_t.sfcb045
   DEFINE p_date         LIKE type_t.dat
   DEFINE r_success      LIKE type_t.num5

   LET r_success = FALSE

   IF cl_null(p_sfcb045) THEN
      #预计交期不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00225'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   IF p_sfcb045 < p_sfcb044 THEN
      #不可小于预计开工日
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00221'
      LET g_errparam.extend = p_sfcb045
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   IF NOT cl_null(p_date) THEN
      IF p_sfcb045 < p_date THEN
         #采购日期 %1 不可小于工单委外的预计交期日期 %2
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00229'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = p_date 
         LET g_errparam.replace[2] =  p_sfcb045
         CALL cl_err()

         RETURN r_success
      END IF
   END IF

   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 委外厂商检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_sfcb013(p_sfcbdocno,p_sfcb013,p_doc_type)
#                  RETURNING r_success
# Input parameter: p_sfcbdocno    工单号码
#                : p_sfcb013      委外厂商
#                : p_doc_type     采购单别
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-13 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_sfcb013(p_sfcbdocno,p_sfcb013,p_doc_type)
   DEFINE p_sfcb013      LIKE sfcb_t.sfcb013
   DEFINE p_type         LIKE type_t.chr1
   DEFINE p_doc_type     LIKE ooba_t.ooba002
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_flag         LIKE type_t.num5

   LET r_success = FALSE

   IF cl_null(p_sfcb013) THEN
      #委外厂商不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00222'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL

   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = p_sfcb013

   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_pmaa001_1") THEN
      RETURN r_success
   END IF

   #判斷輸入的供應商編號是否在採購控制組限制的供應商範圍內，若不在限制內則不允許跟此供應商採購
   CALL s_control_chk_group('2','4',g_user,g_dept,p_sfcb013,'','','','')
        RETURNING l_success,l_flag
   IF NOT l_success THEN      #处理状态
      RETURN r_success
   ELSE
      IF NOT l_flag THEN      #是否存在
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00268'
         LET g_errparam.extend = p_sfcb013
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
   END IF
   
   IF NOT cl_null(p_doc_type) THEN
      #檢核輸入的供應商是否在單據別限制範圍內，若不在限制內則不允許跟此供應商採購
      CALL s_control_chk_doc('2',p_doc_type,p_sfcb013,'','','','')
           RETURNING l_success,l_flag
      IF NOT l_success THEN      #处理状态
         RETURN r_success
      ELSE
         IF NOT l_flag THEN      #是否存在
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'apm-00239'
            LET g_errparam.extend = p_sfcb013
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN r_success
         END IF
      END IF
   END IF

   LET r_success = TRUE
   RETURN r_success


END FUNCTION

################################################################################
# Descriptions...: 本次委外数量检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_carry_qty(p_sfcbdocno,p_sfcb001,p_sfcb002,p_carry_qty)
#                       RETURNING r_success
# Input parameter: p_sfcbdocno    工单单号
#                : p_sfcb001      RUN CARD
#                : p_sfcb002      项次
#                : p_carry_qty    本次委外量
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_carry_qty(p_sfcbdocno,p_sfcb001,p_sfcb002,p_carry_qty)
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_sfcb001      LIKE sfcb_t.sfcb001
   DEFINE p_sfcb002      LIKE sfcb_t.sfcb002
   DEFINE p_carry_qty    LIKE sfcb_t.sfcb041
   DEFINE l_qty          LIKE sfcb_t.sfcb041
   #161109-00085#60-s mod
#   DEFINE l_sfcb         RECORD LIKE sfcb_t.*   #161109-00085#60 mark
   DEFINE l_sfcb         RECORD  #工單製程單身檔
       sfcb027 LIKE sfcb_t.sfcb027, #標準產出量
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
       sfcb041 LIKE sfcb_t.sfcb041, #委外加工數
       sfcb042 LIKE sfcb_t.sfcb042  #委外完工數
                 END RECORD
   #161109-00085#60-e mod
   DEFINE r_success      LIKE type_t.num5
#   DEFINE l_sfca003      LIKE type_t.num5  #170223-00052#1 add #170710-00032#1 mark  
   DEFINE l_sfca003      LIKE sfca_t.sfca003  #170710-00032#1 add
   DEFINE l_imae020      LIKE imae_t.imae020  #170609-00027#1 add    
   LET r_success = FALSE
   
   IF cl_null(p_carry_qty) THEN
      #本次委外数量不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00224'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   

   IF p_carry_qty <= 0 THEN
      #数量不可小于等于0
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00016'
      LET g_errparam.extend = p_carry_qty
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #工单的已委外数量已经转完
   #161109-00085#60-s mod
#   SELECT * INTO l_sfcb.* FROM sfcb_t   #161109-00085#60 mark
   SELECT sfcb027,sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,sfcb034,sfcb035,sfcb036,sfcb037,
          sfcb038,sfcb039,sfcb041,sfcb042
     INTO l_sfcb.sfcb027,l_sfcb.sfcb029,l_sfcb.sfcb030,l_sfcb.sfcb031,l_sfcb.sfcb032,
          l_sfcb.sfcb033,l_sfcb.sfcb034,l_sfcb.sfcb035,l_sfcb.sfcb036,l_sfcb.sfcb037,
          l_sfcb.sfcb038,l_sfcb.sfcb039,l_sfcb.sfcb041,l_sfcb.sfcb042
     FROM sfcb_t
   #161109-00085#60-e mod
    WHERE sfcbent   = g_enterprise
      AND sfcbdocno = p_sfcbdocno
      AND sfcb001   = p_sfcb001
      AND sfcb002   = p_sfcb002
   #170609-00027#1 add-------s--------
   #料件超交率
   SELECT imae020 INTO l_imae020 FROM imae_t WHERE imaeent=g_enterprise AND imaesite=g_site 
      AND imae001=(SELECT sfaa010 FROM sfaa_t WHERE sfaaent=g_enterprise AND sfaadocno=p_sfcbdocno)
   LET l_sfcb.sfcb027=l_sfcb.sfcb027*(1+l_imae020/100)
   #170609-00027#1 add--------e-------
   #可委外數=標準產出數量(sfcb027)+重工轉入(sfcb029)+工單轉入(sfcb030)+分割轉入(sfcb031)+合併轉入(sfcb032)
   #        -良品轉出(sfcb033)-重工轉出(sfcb034)-工單轉出(sfcb035)-當站報廢(sfcb036)-當站下線(sfcb037)
   #        -分割轉出(sfcb038)-合併轉出(sfcb039)-委外數量(sfcb041)
#  #        +委外完工數量(sfcb042)   #151118-00011#1 mark 計算時移除委外完工量(sfcb042)   
   LET l_qty = l_sfcb.sfcb027 + l_sfcb.sfcb029 + l_sfcb.sfcb030 + l_sfcb.sfcb031 + l_sfcb.sfcb032 
             - l_sfcb.sfcb033 - l_sfcb.sfcb034 - l_sfcb.sfcb035 - l_sfcb.sfcb036 - l_sfcb.sfcb037 
#            - l_sfcb.sfcb038 - l_sfcb.sfcb039 - l_sfcb.sfcb041 + l_sfcb.sfcb042  #151118-00011#1 mark
             - l_sfcb.sfcb038 - l_sfcb.sfcb039 - l_sfcb.sfcb041                   #151118-00011#1 mod
   #170223-00052#1 add(s)
   SELECT sfca003 INTO l_sfca003 FROM sfca_t
    WHERE sfcaent = g_enterprise
      AND sfcadocno = p_sfcbdocno
      AND sfca001 = p_sfcb001
   IF NOT cl_null(l_sfca003) THEN
      #IF l_qty > l_sfca003 THEN                      #170609-00027#1 mark
      IF l_qty > l_sfca003*(1+l_imae020/100) THEN     #170609-00027#1 add
         LET l_qty = l_sfca003
      END IF
   END IF
   #170223-00052#1 add(e)
   IF l_qty < p_carry_qty THEN
      #本次委外数量 %2 已超过 最大可委外数量为 %1
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00220'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
#      LET g_errparam.replace[1] = p_carry_qty    170227-00002#1 mark
#      LET g_errparam.replace[2] =  l_qty         170227-00002#1 mark
      LET g_errparam.replace[1] =  l_qty          #170227-00002#1 add
      LET g_errparam.replace[2] =  p_carry_qty    #170227-00002#1 add      
      CALL cl_err()

      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success      
END FUNCTION

################################################################################
# Descriptions...: 取价方式检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_pmdl017(p_sfcbdocno,p_pmdl017)
#                       RETURNING r_success
# Input parameter: p_sfcbdocno    工单单号
#                : p_pmdl017      取价方式
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_pmdl017(p_sfcbdocno,p_pmdl017)
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_pmdl017      LIKE pmdl_t.pmdl017
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = FALSE
   
   IF cl_null(p_pmdl017) THEN
      #取价方式不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00226'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL

   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = p_pmdl017
   LET g_errshow = TRUE                                                                                                #160328-00029#3 add
   LET g_chkparam.err_str[1] = "apm-00210:sub-01302|apmi130|",cl_get_progname("apmi130",g_lang,"2"),"|:EXEPROGapmi130" #160328-00029#3 add

   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_pmam001") THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 要转采购单的工单资料插入临时表
# Memo...........:
# Usage..........: CALL s_asfp400_ins_tmp_table(p_doc_type,p_date,p_sfcb_d,p_sfac_d)
#                       RETURNING r_success
# Input parameter: p_doc_type     采购单别
#                : p_date         采购日期
#                : p_sfcb_d       ARRAY1资料
#                : p_sfac_d       ARRAY2资料
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-04-21 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_ins_tmp_table(p_doc_type,p_date,p_sfcb_d,p_sfac_d)
   DEFINE p_sfcb_d       DYNAMIC ARRAY OF type_g_sfcb_d
   DEFINE p_sfac_d       DYNAMIC ARRAY OF type_g_sfac_d
   DEFINE p_doc_type     LIKE ooba_t.ooba002
   DEFINE p_date         LIKE type_t.dat  
   DEFINE l_sfcb         type_g_sfcb_d
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num10
   DEFINE l_j            LIKE type_t.num10
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_cnt1         LIKE type_t.num10
   DEFINE l_cnt2         LIKE type_t.num10
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_cnt          LIKE type_t.num10  #170703-00026#1 add
   #161227-00046#1-s  add
   DEFINE l_cnt3         LIKE type_t.num10  
   DEFINE l_cnt4         LIKE type_t.num10  
   DEFINE l_cnt5         LIKE type_t.num10  
   DEFINE l_sfaa012      LIKE sfaa_t.sfaa012   
   DEFINE l_sfaa061      LIKE sfaa_t.sfaa061   
   DEFINE l_sfcb012      LIKE sfcb_t.sfcb012   
   DEFINE l_sql          STRING           
   DEFINE l_sfcbdocno  LIKE sfcb_t.sfcbdocno   
   #161227-00046#1-e  add            
   WHENEVER ERROR CONTINUE

   LET r_success = FALSE
   LET l_cnt = 0            #170703-00026#1 add
   LET l_cnt3 = 0           #161227-00046#1  add
   LET l_cnt4 = 0           #161227-00046#1  add
   LET l_cnt5 = 0           #161227-00046#1  add
#   #检查:应在事物中的
#   IF NOT s_transaction_chk('Y','0') THEN
#      LET r_success = 'N'
#      RETURN r_success
#   END IF
   
   DELETE FROM asfp400_tmp_t;
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'delete asfp400_tmp_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #单身1的笔数
   LET l_cnt1 = p_sfcb_d.getLength()
   #单身2的笔数
   LET l_cnt2 = p_sfac_d.getLength()
   FOR l_i = 1 TO l_cnt1
      #ARR1中的委外数量若为0,则工单不处理
      IF p_sfcb_d[l_i].carry_qty = 0 OR cl_null(p_sfcb_d[l_i].carry_qty) THEN
         CONTINUE FOR
      END IF
     
      CALL s_asfp400_chk_before_carry(p_sfcb_d[l_i].*,p_doc_type,p_date)
           RETURNING l_success
      IF NOT l_success THEN
         CONTINUE FOR
      END IF
      
      LET l_sfcb.* = p_sfcb_d[l_i].*
      LET l_flag = 'N'
      
      FOR l_j = 1 TO l_cnt2
         IF p_sfcb_d[l_i].sfcbdocno <> p_sfac_d[l_j].sfacdocno THEN
            CONTINUE FOR
         END IF
         #ARR2中的委外数量为0,则此特征不处理
         IF p_sfac_d[l_j].carry_qty = 0 OR cl_null(p_sfac_d[l_j].carry_qty) THEN
            CONTINUE FOR
         END IF
         #161227-00046#1 mark --(S)--
         #170703-00026#1-s add
         #因同一工單不同製程會產生相同的特徵資料,而造成新增到temp的資料重複
#         SELECT COUNT(1) INTO l_cnt 
#           FROM asfp400_tmp_t
#          WHERE sfcbdocno = p_sfcb_d[l_i].sfcbdocno
#            AND sfac006 = p_sfac_d[l_j].sfac006
#            AND sfcb001 = p_sfcb_d[l_i].sfcb001
#            AND sfcb002 = p_sfcb_d[l_i].sfcb002
#         IF l_cnt > 0 THEN
#            CONTINUE FOR
#         END IF 
         #170703-00026#1-e add
         #161227-00046#1 mark --(E)--
         #161227-00046#1-s add
         SELECT sfaa012,sfaa061 INTO l_sfaa012,l_sfaa061
           FROM sfaa_t 
          WHERE sfaaent = g_enterprise 
            AND sfaadocno = p_sfcb_d[l_i].sfcbdocno
         IF l_sfaa061 = 'N' AND p_sfcb_d[l_i].carry_qty >= l_sfaa012 AND g_check_pmdldocno = 'Y' THEN
                        
            SELECT COUNT(1) INTO l_cnt 
              FROM asfp400_tmp_t02
             WHERE sfcbdocno = p_sfcb_d[l_i].sfcbdocno
               AND sfac006 = p_sfac_d[l_j].sfac006
               AND sfcb001 = p_sfcb_d[l_i].sfcb001
               AND sfcb002 = p_sfcb_d[l_i].sfcb002
            IF l_cnt > 0 THEN
               CONTINUE FOR
            END IF 
            LET g_temptype = '2'
            INSERT INTO asfp400_tmp_t02 
                      VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   p_sfac_d[l_j].sfac006,
                             p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                             p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfac_d[l_j].carry_qty,   
                             p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                             p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                             p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert asfp400_tmp_t02'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN r_success
            END IF                                   
         ELSE
            IF l_sfaa061 = 'Y' AND p_sfcb_d[l_i].carry_qty >= l_sfaa012 AND g_check_pmdldocno = 'Y' THEN  
                          
               SELECT COUNT(1) INTO l_cnt 
                 FROM asfp400_tmp_t01
                WHERE sfcbdocno = p_sfcb_d[l_i].sfcbdocno
                  AND sfac006 = p_sfac_d[l_j].sfac006
                  AND sfcb001 = p_sfcb_d[l_i].sfcb001
                  AND sfcb002 = p_sfcb_d[l_i].sfcb002
               IF l_cnt > 0 THEN
                  CONTINUE FOR
               END IF 
               LET g_temptype = '1'
               INSERT INTO asfp400_tmp_t01 
                         VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   p_sfac_d[l_j].sfac006,
                                p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                                p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfac_d[l_i].carry_qty,   
                                p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                                p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                                p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert asfp400_tmp_t01'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  RETURN r_success
               END IF
            ELSE                
               SELECT COUNT(1) INTO l_cnt 
                 FROM asfp400_tmp_t
                WHERE sfcbdocno = p_sfcb_d[l_i].sfcbdocno
                  AND sfac006 = p_sfac_d[l_j].sfac006
                  AND sfcb001 = p_sfcb_d[l_i].sfcb001
                  AND sfcb002 = p_sfcb_d[l_i].sfcb002
               IF l_cnt > 0 THEN
                  CONTINUE FOR
               END IF 
               LET g_temptype = '0'
            #161227-00046#1-e add           
               INSERT INTO asfp400_tmp_t 
                         VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   p_sfac_d[l_j].sfac006,
                                p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                                p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfac_d[l_j].carry_qty,   
                                p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                                p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                                p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert asfp400_tmp_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  RETURN r_success
               END IF
            END IF   #161227-00046#1 add
         END IF #161227-00046#1 add
         #处理代买料
         LET l_sfcb.carry_qty = p_sfac_d[l_j].carry_qty
         CALL s_asfp400_buy(l_sfcb.*,p_sfac_d[l_j].sfac006)
              RETURNING l_success
         IF NOT l_success THEN
            RETURN r_success         
         END IF
         
         LET l_flag = 'Y'
      END FOR
      IF l_flag = 'N' THEN
         #161227-00046#1-s add
         SELECT sfaa012,sfaa061 INTO l_sfaa012,l_sfaa061
           FROM sfaa_t 
          WHERE sfaaent = g_enterprise 
            AND sfaadocno = p_sfcb_d[l_i].sfcbdocno
         IF l_sfaa061 = 'N' AND p_sfcb_d[l_i].carry_qty >= l_sfaa012 AND g_check_pmdldocno = 'Y' THEN
            LET g_temptype = '2'
            INSERT INTO asfp400_tmp_t02 
                      VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   ' ',
                             p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                             p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfcb_d[l_i].carry_qty,   
                             p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                             p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                             p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'insert asfp400_tmp_t02'
               LET g_errparam.popup = TRUE
               CALL cl_err()
            
               RETURN r_success
            END IF                                   
         ELSE
            IF l_sfaa061 = 'Y' AND p_sfcb_d[l_i].carry_qty >= l_sfaa012 AND g_check_pmdldocno = 'Y' THEN  
               LET g_temptype = '1'            
               INSERT INTO asfp400_tmp_t01 
                         VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   ' ',
                                p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                                p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfcb_d[l_i].carry_qty,   
                                p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                                p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                                p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert asfp400_tmp_t01'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  RETURN r_success
               END IF
            ELSE
               LET g_temptype = '0'
         #161227-00046#1-e add
               INSERT INTO asfp400_tmp_t 
                         VALUES(p_sfcb_d[l_i].sfcbdocno,   p_sfcb_d[l_i].sfaa010  ,   ' ',
                                p_sfcb_d[l_i].sfcb001  ,   p_sfcb_d[l_i].sfcb002  ,   p_sfcb_d[l_i].sfcb003  ,   
                                p_sfcb_d[l_i].sfcb004  ,   p_sfcb_d[l_i].sfcb020  ,   p_sfcb_d[l_i].carry_qty,   
                                p_sfcb_d[l_i].sfcb013  ,   p_sfcb_d[l_i].sfcb044  ,   p_sfcb_d[l_i].sfcb045  ,   
                                p_sfcb_d[l_i].pmdl017  ,   p_sfcb_d[l_i].pmdl015  ,   p_sfcb_d[l_i].exrate   ,   
                                p_sfcb_d[l_i].pmdl011  ,   p_sfcb_d[l_i].price  )
               
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'insert asfp400_tmp_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  RETURN r_success
               END IF            
            END IF   #161227-00046#1 add
         END IF #161227-00046#1 add
         #处理代买料
         CALL s_asfp400_buy(p_sfcb_d[l_i].*,'')
              RETURNING l_success
         IF NOT l_success THEN
            RETURN r_success         
         END IF
         
      END IF
   END FOR  
   
   #161227-00046#1-s add            
  
   IF g_check_pmdldocno = 'Y' THEN   
   
      LET l_sql =" SELECT DISTINCT sfcbdocno FROM asfp400_tmp_t01 "  
      PREPARE s_asfp400_arr FROM l_sql                           
      DECLARE s_asfp400_arr1 CURSOR FOR s_asfp400_arr                  
      FOREACH s_asfp400_arr1 INTO l_sfcbdocno
         
         SELECT COUNT(DISTINCT sfcb002) INTO l_cnt3
           FROM asfp400_tmp_t01
          WHERE sfcbdocno = l_sfcbdocno
            AND sfaa010 = (select sfaa010 from sfaa_t where sfaadocno = l_sfcbdocno)  
                     
         SELECT COUNT(1) INTO l_cnt4
           FROM sfcb_t 
          WHERE sfcbdocno = l_sfcbdocno 
            AND sfcb012 = 'Y'
         
         SELECT COUNT(DISTINCT sfcb013) INTO l_cnt5
           FROM asfp400_tmp_t01
          WHERE sfcbdocno = l_sfcbdocno
                     
         IF l_cnt5 = 1 AND l_cnt3 = l_cnt4 THEN             
            INSERT INTO asfp400_tmp_t02 (sfcbdocno,sfaa010,sfac006,sfcb001,sfcb002, 
                                         sfcb003,sfcb004,sfcb020,carry_qty,sfcb013, 
                                         sfcb044,sfcb045,pmdl017,pmdl015,exrate,
                                         pmdl011,price)
                 SELECT sfcbdocno,sfaa010,sfac006,sfcb001,sfcb002, 
                        sfcb003,sfcb004,sfcb020,carry_qty,sfcb013, 
                        sfcb044,sfcb045,pmdl017,pmdl015,exrate,
                        pmdl011,price
                   FROM asfp400_tmp_t01
                  WHERE sfcbdocno = l_sfcbdocno 
         ELSE
            INSERT INTO asfp400_tmp_t (sfcbdocno,sfaa010,sfac006,sfcb001,sfcb002, 
                                       sfcb003,sfcb004,sfcb020,carry_qty,sfcb013, 
                                       sfcb044,sfcb045,pmdl017,pmdl015,exrate,
                                       pmdl011,price)
                 SELECT sfcbdocno,sfaa010,sfac006,sfcb001,sfcb002, 
                        sfcb003,sfcb004,sfcb020,carry_qty,sfcb013, 
                        sfcb044,sfcb045,pmdl017,pmdl015,exrate,
                        pmdl011,price
                   FROM asfp400_tmp_t01
                  WHERE sfcbdocno = l_sfcbdocno 
         END IF         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert asfp400_tmp_t02'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         
            RETURN r_success     
         END IF
      
      END FOREACH      
   END IF   
   #161227-00046#1-e add
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 币种检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_pmdl015(p_sfcbdocno,p_pmdl015)
#                  RETURNING r_success
# Input parameter: p_sfcbdocno    工单单号
#                : p_pmdl015      币种
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-13 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_pmdl015(p_sfcbdocno,p_pmdl015)
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_pmdl015      LIKE pmdl_t.pmdl015
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = FALSE

   IF cl_null(p_pmdl015) THEN
      #币种不可空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00227'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL

   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = p_pmdl015
   LET g_errshow = TRUE                                                                                                #160328-00029#3 add
   LET g_chkparam.err_str[1] = "aoo-00176:sub-01302|aooi150|",cl_get_progname("aooi150",g_lang,"2"),"|:EXEPROGaooi150" #160328-00029#3 add

   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_ooaj002") THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查特征页签的相关内容
# Memo...........:
# Usage..........: CALL s_asfp400_chk_eigenvalue_qty(p_sfcbdocno,p_sfcb001,p_sfcb002,p_carry_qty)
#                       RETURNING r_success
# Input parameter: p_sfcbdocno    工单单号
#                : p_sfcb001      RUN CARD
#                : p_sfcb002      项次
#                : p_carry_qty    本次委外量
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_eigenvalue_qty(p_sfcbdocno,p_sfcb001,p_sfcb002,p_carry_qty)
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_sfcb001      LIKE sfcb_t.sfcb001
   DEFINE p_sfcb002      LIKE sfcb_t.sfcb002
   DEFINE p_carry_qty    LIKE sfcb_t.sfcb041
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_tot_qty      LIKE sfac_t.sfac003
   DEFINE l_cnt          LIKE type_t.num10
   DEFINE l_flag         LIKE type_t.chr1
   DEFINE l_i            LIKE type_t.num10
   
   LET r_success = FALSE
   LET l_tot_qty = 0
   LET l_flag = 'N'
   
   LET l_cnt = g_sfac_d.getLength()
   FOR l_i = 1 TO l_cnt
       IF p_sfcbdocno <> g_sfac_d[l_i].sfacdocno THEN
          CONTINUE FOR
       END IF
       #ARR2中的委外数量为0,则此特征不处理
       IF g_sfac_d[l_i].carry_qty = 0 THEN
          CONTINUE FOR
       END IF   
       LET l_tot_qty = l_tot_qty + g_sfac_d[l_i].carry_qty
       LET l_flag = 'Y'
   END FOR
   
   #有特征值数量
   IF l_flag = 'Y' THEN
      IF l_tot_qty <> p_carry_qty THEN
         #工单各特征的本次委外数量合计 %1 不等于工单的本次委外数量 %2 !
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'asf-00239'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_tot_qty 
         LET g_errparam.replace[2] =  p_carry_qty
         CALL cl_err()

         RETURN r_success
      END IF   
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 工单转委外采购单过程中使用的临时表
# Memo...........:
# Usage..........: CALL s_asfp400_cre_tmp_table(p_doc_type,p_date,p_sfcb_d,p_sfac_d)
#                       RETURNING r_success
# Input parameter: p_doc_type     采购单别
#                : p_date         采购日期
#                : p_sfcb_d       ARRAY1资料
#                : p_sfac_d       ARRAY2资料
# Date & Author..: 2014-04-15 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_cre_tmp_table(p_doc_type,p_date,p_sfcb_d,p_sfac_d)
   DEFINE r_success       LIKE type_t.num5
   DEFINE p_sfcb_d        DYNAMIC ARRAY OF type_g_sfcb_d
   DEFINE p_sfac_d        DYNAMIC ARRAY OF type_g_sfac_d
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE l_success       LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = FALSE

   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      RETURN r_success
   END IF

   DROP TABLE asfp400_tmp_t;
   DROP TABLE asfp400_tmp_t01;  #161227-00046#1  add
   DROP TABLE asfp400_tmp_t02;  #161227-00046#1  add
   
   CREATE TEMP TABLE asfp400_tmp_t(
   sfcbdocno      LIKE sfcb_t.sfcbdocno,
   sfaa010        LIKE sfaa_t.sfaa010,
   sfac006        LIKE sfac_t.sfac006,
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
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   #161227-00046#1-s  add
   CREATE TEMP TABLE asfp400_tmp_t01(
   sfcbdocno      LIKE sfcb_t.sfcbdocno,
   sfaa010        LIKE sfaa_t.sfaa010,
   sfac006        LIKE sfac_t.sfac006,
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
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   CREATE TEMP TABLE asfp400_tmp_t02(
   sfcbdocno      LIKE sfcb_t.sfcbdocno,
   sfaa010        LIKE sfaa_t.sfaa010,
   sfac006        LIKE sfac_t.sfac006,
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
   );

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
   #161227-00046#1-e  add
   #插入临时表
   CALL s_asfp400_ins_tmp_table(p_doc_type,p_date,p_sfcb_d,p_sfac_d)   
        RETURNING l_success  
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 税种检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_pmdl011(p_sfcbdocno,p_pmdl011)
#                  RETURNING r_success
# Input parameter: p_sfcbdocno    工单单号
#                : p_pmdl011      税种
# Return code....: r_success      检查通过否标识符
# Date & Author..: 2014-04-22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_pmdl011(p_sfcbdocno,p_pmdl011)
   DEFINE p_sfcbdocno    LIKE sfcb_t.sfcbdocno
   DEFINE p_pmdl011      LIKE pmdl_t.pmdl011
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = FALSE

   IF cl_null(p_pmdl011) THEN
      #税种不可为空!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00228'
      LET g_errparam.extend = p_sfcbdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
   INITIALIZE g_chkparam.* TO NULL

   #設定g_chkparam.*的參數
   LET g_chkparam.arg1 = g_site
   LET g_chkparam.arg2 = p_pmdl011
   LET g_errshow = TRUE                                                                                                #160328-00029#3 add
   LET g_chkparam.err_str[1] = "aoo-00223:sub-01302|aooi610|",cl_get_progname("aooi610",g_lang,"2"),"|:EXEPROGaooi610" #160328-00029#3 add

   #呼叫檢查存在並帶值的library
   IF NOT cl_chk_exist("v_oodb002") THEN
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: 工单转委外采购单应用元件
# Memo...........
# Usage..........: CALL s_asfp400_carry_po(p_doc_type,p_date,p_combine,p_arr1,p_arr2)
#                       RETURNING r_success, r_begin_no, r_end_no
# Input parameter: p_doc_type     生成的采购单单别
#                : p_date         生成的采购单日期
#                : p_combine      汇总否
#                : p_arr1         工单制程ARRAY
#                : p_arr2         工单特征ARRAY 
# Return code....: r_success      成功否标识符
#                : r_begin_no     起始单号
#                : r_end_no       截止单号
# Date & Author..: 2014/4/21 By Carrier
################################################################################
PUBLIC FUNCTION s_asfp400_carry_po(p_doc_type,p_date,p_combine,p_arr1,p_arr2)
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE r_begin_no      LIKE pmdl_t.pmdldocno
   DEFINE r_end_no        LIKE pmdl_t.pmdldocno
   DEFINE p_arr1          DYNAMIC ARRAY OF type_g_sfcb_d
   DEFINE p_arr2          DYNAMIC ARRAY OF type_g_sfac_d
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt1          LIKE type_t.num10
   DEFINE l_cnt2          LIKE type_t.num10
   DEFINE l_begin_no      LIKE pmdl_t.pmdldocno
   DEFINE l_end_no        LIKE pmdl_t.pmdldocno   
   
   WHENEVER ERROR CONTINUE

   LET r_success  = FALSE
   LET r_begin_no = ''
   LET r_end_no   = ''
   
   #检查:应在事物中的
   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = 'N'
      RETURN r_success,r_begin_no,r_end_no
   END IF

   #检查传入ARRAY是否为空
   SELECT COUNT(1) INTO l_cnt1 FROM asfp400_tmp_t
   IF l_cnt1 = 0 THEN
      #无资料处理!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_begin_no,r_end_no
   END IF
   
#   #插入临时表
#   CALL s_asfp400_ins_tmp_table(p_doc_type,p_date,p_arr1,p_arr2)   
#        RETURNING l_success
#   IF NOT l_success THEN
#      RETURN r_success,r_begin_no,r_end_no
#   END IF
   
   CALL s_apmt500_gen('4','','',p_doc_type,p_date,p_combine)
        RETURNING l_success,l_begin_no,l_end_no
   IF NOT l_success THEN
      RETURN r_success,r_begin_no,r_end_no
   END IF
   
   LET r_begin_no = l_begin_no
   LET r_end_no   = l_end_no
     
   LET r_success = TRUE
   RETURN r_success,r_begin_no,r_end_no
   
END FUNCTION

################################################################################
# Descriptions...: 抛转采购单前的整体检查
# Memo...........:
# Usage..........: CALL s_asfp400_chk_before_carry(p_sfcb,p_doc_type,p_date)
#                       RETURNING r_success
# Input parameter: p_sfcb      工单相关资料
#                : p_doc_type  采购单别
#                : p_date      采购日期
# Return code....: r_success   检查通过否
# Date & Author..: 2014-04-22 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_chk_before_carry(p_sfcb,p_doc_type,p_date)
   DEFINE p_sfcb           type_g_sfcb_d
   DEFINE p_doc_type       LIKE ooba_t.ooba002
   DEFINE p_date           LIKE type_t.dat
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sfaastus       LIKE sfaa_t.sfaastus   #160731-00073#1 add
   
   LET r_success = FALSE

#160731-00073#1-s add
   #需判斷工單的狀態碼為F/C/M才可拋轉
   LET l_sfaastus = ''
   SELECT sfaastus INTO l_sfaastus
     FROM sfaa_t
    WHERE sfaaent = g_enterprise AND sfaadocno = p_sfcb.sfcbdocno
   IF NOT (l_sfaastus = 'F' OR l_sfaastus = 'C' OR l_sfaastus = 'M') THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = p_sfcb.sfcbdocno
      LET g_errparam.code   = 'asf-00444'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
#160731-00073#1-e add

   #本次委外数
   CALL s_asfp400_chk_carry_qty(p_sfcb.sfcbdocno,p_sfcb.sfcb001,p_sfcb.sfcb002,p_sfcb.carry_qty)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   #工单的委外数与特征委外合计数是否相等
   CALL s_asfp400_chk_eigenvalue_qty(p_sfcb.sfcbdocno,p_sfcb.sfcb001,p_sfcb.sfcb002,p_sfcb.carry_qty)
        RETURNING l_success       
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   #委外厂商
   CALL s_asfp400_chk_sfcb013(p_sfcb.sfcbdocno,p_sfcb.sfcb013,p_doc_type)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   #预计交期
   CALL s_asfp400_chk_sfcb045(p_sfcb.sfcbdocno,p_sfcb.sfcb044,p_sfcb.sfcb045,p_date)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF       

   #取价方式
   CALL s_asfp400_chk_pmdl017(p_sfcb.sfcbdocno,p_sfcb.pmdl017)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF
   
   #币种
   CALL s_asfp400_chk_pmdl015(p_sfcb.sfcbdocno,p_sfcb.pmdl015)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   #税种
   CALL s_asfp400_chk_pmdl011(p_sfcb.sfcbdocno,p_sfcb.pmdl011)
        RETURNING l_success
   IF NOT l_success THEN
      RETURN r_success
   END IF

   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 代买料插入临时表
# Memo...........:
# Usage..........: CALL s_asfp400_buy(p_sfcb,p_sfac006)
#                       RETURNING r_success
# Input parameter: p_sfcb         工单等信息
#                : p_sfac006      特征值
# Return code....: r_success      成功否标识符
# Date & Author..: 2014-04-23 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_buy(p_sfcb,p_sfac006)
   DEFINE p_sfcb           type_g_sfcb_d
   DEFINE p_sfac006        LIKE sfac_t.sfac006
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_sfaa013        LIKE sfaa_t.sfaa013
   DEFINE l_sfaa012        LIKE sfaa_t.sfaa012
   DEFINE l_qty            LIKE sfaa_t.sfaa012       
   DEFINE l_po_rate        LIKE type_t.num26_10
   DEFINE l_eigenvalue     LIKE type_t.chr1000
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_rate           LIKE inaj_t.inaj014
   DEFINE l_sfba006        LIKE sfba_t.sfba006
   DEFINE l_sfba010        LIKE sfba_t.sfba010
   DEFINE l_sfba011        LIKE sfba_t.sfba011
   DEFINE l_sfba021        LIKE sfba_t.sfba021
   DEFINE l_sfba014        LIKE sfba_t.sfba014
   DEFINE l_sfba015        LIKE sfba_t.sfba015
   DEFINE l_pmdp023        LIKE pmdp_t.pmdp023
   DEFINE l_std_qty        LIKE pmdp_t.pmdp023
   DEFINE l_std_sum        LIKE pmdp_t.pmdp023
   DEFINE l_mfg_qty        LIKE sfaa_t.sfaa012

   LET r_success = FALSE
   
   #取生产料件的总生产数量
   IF cl_null(p_sfac006) THEN
      #单位/数量
      SELECT sfaa013,sfaa012 INTO l_sfaa013,l_sfaa012 FROM sfaa_t
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = p_sfcb.sfcbdocno
      LET l_mfg_qty = l_sfaa012
   ELSE
      SELECT sfaa013,sfac003 INTO l_sfaa013,l_sfaa012 FROM sfaa_t,sfac_t
       WHERE sfaaent   = sfacent   AND sfaaent = g_enterprise
         AND sfaadocno = sfacdocno AND sfaadocno = p_sfcb.sfcbdocno
         AND sfac006   = p_sfac006
      SELECT sfaa012 INTO l_mfg_qty FROM sfaa_t
       WHERE sfaaent   = g_enterprise
         AND sfaadocno = p_sfcb.sfcbdocno   
      IF cl_null(l_mfg_qty) THEN LET l_mfg_qty = 0 END IF         
   END IF
#   IF l_sfaa013 = p_sfcb.sfcb020 THEN
#      LET l_rate = 1
#   ELSE
#      CALL s_aimi190_get_convert(p_sfcb.sfaa010,p_sfcb.sfcb020,l_sfaa013)
#           RETURNING l_success,l_rate
#      IF NOT l_success THEN
#         LET l_rate = 1
#      END IF  
#   END IF

   IF l_sfaa013 = p_sfcb.sfcb020 THEN
      LET l_qty = p_sfcb.carry_qty
   ELSE
      CALL s_aooi250_convert_qty(p_sfcb.sfaa010,p_sfcb.sfcb020,l_sfaa013,p_sfcb.carry_qty)
           RETURNING l_success,l_qty
      IF NOT l_success THEN
         LET l_qty = p_sfcb.carry_qty
      END IF  
   END IF
#   #取代买比率
#   LET l_qty = p_sfcb.carry_qty * l_rate

   IF l_qty >= l_sfaa012 THEN
      LET l_po_rate = 1
      LET l_std_qty = l_sfaa012
   ELSE
      LET l_po_rate = l_qty / l_sfaa012
      LET l_std_qty = l_qty
   END IF
   IF cl_null(l_po_rate) THEN LET l_po_rate = 1 END IF
   
   LET l_eigenvalue = ''    
   IF NOT cl_null(p_sfac006) THEN
      #carrier
      #呼叫应用元件,取得主件特征值与下阶料特征值的对应清单
      #LET l_eigenvalue = ''
   END IF

   #取PO已经转的代买量
   LET g_sql = " SELECT SUM(pmdp023) FROM pmdl_t,pmdp_t ",
               "  WHERE pmdlent   = pmdpent  AND pmdlent = ",g_enterprise,
               "    AND pmdldocno = pmdpdocno ",
               "    AND pmdp003   = '",p_sfcb.sfcbdocno,"'",
               "    AND pmdp004   = ",p_sfcb.sfcb001,
               "    AND pmdlstus   <> 'X' ",
               "    AND pmdp001   = ? "
   IF NOT cl_null(p_sfcb.sfcb003) THEN
      LET g_sql = g_sql CLIPPED," AND pmdp009 = '",p_sfcb.sfcb003,"'"
   END IF
   IF NOT cl_null(p_sfcb.sfcb004) THEN
      LET g_sql = g_sql CLIPPED," AND pmdp010 = '",p_sfcb.sfcb004,"'"
   END IF               
   IF NOT cl_null(l_eigenvalue) THEN
      LET g_sql = g_sql CLIPPED," AND pmdp008 IN (",l_eigenvalue CLIPPED,") "
   END IF   
   
   PREPARE s_asfp400_buy_cs2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare s_asfp400_buy_p2'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   
   #                    发料料件  QPA分子  QPA分母  特征     单位     委外代买数量
   LET g_sql = " SELECT sfba006, sfba010, sfba011, sfba021, sfba014, sfba015 ",
               "   FROM sfba_t ",
               "  WHERE sfbaent   =  ",g_enterprise,
               "    AND sfbadocno = '",p_sfcb.sfcbdocno,"'",
               "    AND sfba015 > 0 "
   IF NOT cl_null(p_sfcb.sfcb003) THEN
      LET g_sql = g_sql CLIPPED," AND sfba003 = '",p_sfcb.sfcb003,"'"
   END IF
   IF NOT cl_null(p_sfcb.sfcb004) THEN
      LET g_sql = g_sql CLIPPED," AND sfba004 = '",p_sfcb.sfcb004,"'"
   END IF
   IF NOT cl_null(l_eigenvalue) THEN
      LET g_sql = g_sql CLIPPED," AND sfba021 IN (",l_eigenvalue CLIPPED,") "
   END IF
   
   PREPARE s_asfp400_buy_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'prepare s_asfp400_buy_p1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DECLARE s_asfp400_buy_cs1 CURSOR FOR s_asfp400_buy_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'declare s_asfp400_buy_cs1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF   
               
   FOREACH s_asfp400_buy_cs1 INTO l_sfba006,l_sfba010,l_sfba011,l_sfba021,l_sfba014,l_sfba015
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'foreach s_asfp400_buy_cs1'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF   
      EXECUTE s_asfp400_buy_cs2 USING l_sfba006 INTO l_pmdp023
      IF cl_null(l_pmdp023) THEN LET l_pmdp023 = 0 END IF
   
      LET l_qty = l_sfba015 * l_po_rate
      
      #若代买时不分特征,但是asft300主件有特征管理时,会多次进入此FOREACH
      #所以用特征数量*QPA的方式,以便总量不会加倍
      #但是此处的QPA不能用工单备料上的QPA,因为可能当前笔的代买料是部分代买
      #所以只能用当前主件与当前代买量的比值做为QPA
      LET l_std_sum = l_std_qty * l_sfba015 / l_mfg_qty 
      #LET l_std_sum = l_std_qty * l_sfba010 / l_sfba011
      IF l_qty > l_std_sum THEN
         LET l_qty = l_std_sum
      END IF
      
      #已委外数量+本次委外数量是否超过总委外数量
      IF l_qty + l_pmdp023 > l_sfba015 THEN
         LET l_qty = l_sfba015 - l_pmdp023
      END IF
      
      IF g_temptype = '0' THEN       #161227-00046#1 add
      INSERT INTO asfp400_tmp_t
                VALUES(p_sfcb.sfcbdocno,   l_sfba006       ,   l_sfba021,
                       p_sfcb.sfcb001  ,   p_sfcb.sfcb002  ,   p_sfcb.sfcb003  ,   
                       p_sfcb.sfcb004  ,   l_sfba014       ,   l_qty,   
                       p_sfcb.sfcb013  ,   p_sfcb.sfcb044  ,   p_sfcb.sfcb045  ,   
                       p_sfcb.pmdl017  ,   p_sfcb.pmdl015  ,   p_sfcb.exrate   ,   
                       p_sfcb.pmdl011  ,   p_sfcb.price  )   
      #161227-00046#1 add --(S)--
      END IF
      IF g_temptype = '1' THEN
         INSERT INTO asfp400_tmp_t01
                VALUES(p_sfcb.sfcbdocno,   l_sfba006       ,   l_sfba021,
                       p_sfcb.sfcb001  ,   p_sfcb.sfcb002  ,   p_sfcb.sfcb003  ,   
                       p_sfcb.sfcb004  ,   l_sfba014       ,   l_qty,   
                       p_sfcb.sfcb013  ,   p_sfcb.sfcb044  ,   p_sfcb.sfcb045  ,   
                       p_sfcb.pmdl017  ,   p_sfcb.pmdl015  ,   p_sfcb.exrate   ,   
                       p_sfcb.pmdl011  ,   p_sfcb.price  )   
      END IF
      IF g_temptype = '2' THEN
         INSERT INTO asfp400_tmp_t02
                VALUES(p_sfcb.sfcbdocno,   l_sfba006       ,   l_sfba021,
                       p_sfcb.sfcb001  ,   p_sfcb.sfcb002  ,   p_sfcb.sfcb003  ,   
                       p_sfcb.sfcb004  ,   l_sfba014       ,   l_qty,   
                       p_sfcb.sfcb013  ,   p_sfcb.sfcb044  ,   p_sfcb.sfcb045  ,   
                       p_sfcb.pmdl017  ,   p_sfcb.pmdl015  ,   p_sfcb.exrate   ,   
                       p_sfcb.pmdl011  ,   p_sfcb.price  )   
      END IF
      #161227-00046#1 add --(E)--      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'insert asfp400_tmp_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN r_success
      END IF
 
   END FOREACH
         
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: DROP 工单转委外采购单过程中使用的临时表
# Memo...........:
# Usage..........: CALL s_asfp400_drop_tmp_table()
#                       RETURNING NULL
# Input parameter: NULL
# Return code....: NULL
# Date & Author..: 2014-04-21 By Carrier
# Modify.........:
################################################################################
PUBLIC FUNCTION s_asfp400_drop_tmp_table()
   
   WHENEVER ERROR CONTINUE

   DROP TABLE asfp400_tmp_t;
   
   DROP TABLE asfp400_tmp_t01;  #161227-00046#1  add
   
   DROP TABLE asfp400_tmp_t02;  #161227-00046#1  add
   
END FUNCTION

################################################################################
# Descriptions...: 工单转委外采购单应用元件
# Memo...........
# Usage..........: CALL s_asfp400_carry_po02(p_doc_type,p_date,p_combine,p_arr1,p_arr2)
#                       RETURNING r_success, r_str
# Input parameter: p_doc_type     生成的采购单单别
#                : p_date         生成的采购单日期
#                : p_combine      汇总否
#                : p_arr1         工单制程ARRAY
#                : p_arr2         工单特征ARRAY 
# Return code....: r_success      成功否标识符
#                : r_str          單號彙總
# Date & Author..: 2017/08/07 By 08992
################################################################################
PUBLIC FUNCTION s_asfp400_carry_po02(p_doc_type,p_date,p_combine,p_arr1,p_arr2)
   DEFINE p_doc_type      LIKE ooba_t.ooba002
   DEFINE p_date          LIKE type_t.dat
   DEFINE p_combine       LIKE type_t.chr1
   DEFINE r_success       LIKE type_t.num5
   DEFINE p_arr1          DYNAMIC ARRAY OF type_g_sfcb_d
   DEFINE p_arr2          DYNAMIC ARRAY OF type_g_sfac_d
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt1          LIKE type_t.num10
   DEFINE l_cnt2          LIKE type_t.num10
   DEFINE l_str           STRING
   DEFINE l_str1           STRING
   DEFINE r_str           STRING 
   DEFINE r_str1           STRING 
   
   WHENEVER ERROR CONTINUE

   LET r_success  = FALSE
   LET r_str = ''
   LET r_str1 = ''
   

   IF NOT s_transaction_chk('Y','0') THEN
      LET r_success = 'N'
      RETURN r_success,r_str,r_str1
   END IF


   SELECT COUNT(1) INTO l_cnt1 FROM asfp400_tmp_t02
   IF l_cnt1 = 0 THEN

      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00230'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success,r_str,r_str1
   END IF
   
   CALL s_apmt500_gen02('','','',p_doc_type,p_date,p_combine)
        RETURNING l_success,l_str,l_str1
   IF NOT l_success THEN
      RETURN r_success,r_str,r_str1
   END IF
   
   LET r_str = l_str
   LET r_str1 = l_str1
     
   LET r_success = TRUE
   RETURN r_success,r_str,r_str1
   
END FUNCTION

 
{</section>}
 
