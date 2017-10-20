# Prog. Version..: '5.30.06-13.04.17(00010)'     #
#
# Pattern name...: asfp301.4gl
# Descriptions...: 整批工單產生作業
# Date & Author..: 97/06/28 BY Roger
# Modify ........: No:9305 04/03/05 By Melody 跨階產生子工單問題, 此問題修改後特
#                                             別注意BOM設定為'4'時表 '不展開'
# Modify ........: MOD-480504 04/09/06 By Echo 參數工單展備料時,若下階料件須開立工單選'1'時,子工單要show出工單的單號!
# Modify ........: MOD-480540 04/09/06 By Echo 工單展備料時,若下階料件須開立工單設為1:開窗挑選料件時,當有二階的BOM時,會多開一次asfp301的畫面
# Modify.........: No.MOD-490217 04/09/10 by yiting 料號欄位放大
# Modify.........: No.MOD-4B0208 04/11/25 by Carol sr子工單"預計完工日"反而比"預計發料日"少一天->check add 元件投料時距 bmb18
# Modify.........: NO.FUN-510040 05/02/03 By Echo 修改報表架構轉XML,數量type '###.--' 改為 '---.--' 顯示
# Modify.........: No.MOD-530399 05/05/02 By pengu 工單資料應可進行查詢輸入。
# Modify.........: No.FUN-550112 05/05/27 By ching 特性BOM功能修改
# Modify.........: No.FUN-550067 05/05/31 By Trisy 單據編號加大
# Modify.........: No.FUN-560230 05/06/27 By Melody QPA->DEC(16,8)
# Modify.........: No.MOD-550189 05/06/19 By pengu  算出預計開工日時，推算時應將非工作天排除
# Modify.........: No.MOD-580333 05/08/30 By kim 工單展開時若展開的是要展開其他工單時 ,出現的對話窗都是英文的
# Modify.........: No.MOD-580242 05/09/12 By Nicola PAGE LENGTH g_line 改為g_page_line
# Modify.........: No.MOD-580355 05/08/30 By alex 把333沒做完的再補一下
# Modify.........: No.MOD-5A0006 05/10/24 By pengu 自動產生工單時應考慮下階料是否須開立子工單，目前程式只判斷
                                      #            當階若不須開工單即停止並不會繼續往下展
# Modify.........: No.TQC-610003 06/01/17 By Nicola INSERT INTO sfb_file 時, 特性代碼欄位(sfb95)應抓取該工單單頭生產料件在料件主檔(ima_file)設定的'主特性代碼'欄位(ima910)
# Modify.........: No.TQC-630106 06/03/10 By Claire DISPLAY ARRAY無控制單身筆數
# Modify.........: No.MOD-640425 06/04/12 By kim 母工單下階為自動產生工單,若下階子工單為委外工單,單頭委外型態會預設null
# Modify.........: No.FUN-620018 06/05/03 By kim s_cralc5 改 Call  s_cralc
# Modify.........: No.FUN-650193 06/06/02 By kim 2.0功能改善-主特性代碼
# Modify.........: No.FUN-660128 06/06/19 By Xumin cl_err --> cl_err3
# Modify.........: No.FUN-670041 06/08/10 By Pengu 將sma29 [虛擬產品結構展開與否] 改為 no use
# Modify.........: No.FUN-680121 06/09/04 By huchenghao 類型轉換
# Modify.........: No.FUN-6B0044 06/11/13 By kim GP3.5 台虹保稅客製功能回收修改
# Modify.........: No.FUN-6B0031 06/11/16 By yjkhero 新增動態切換單頭部份顯示的功能
# Modify.........: No.TQC-6B0107 06/11/20 By claire  FUN-660128修改
# Modify.........: No.FUN-710026 07/01/15 By hongmei 錯誤訊息匯總顯示修改
# Modify.........: No.TQC-730038 07/03/07 By Smapmin 修改變數名稱
# Modify.........: No.MOD-730136 07/03/29 By chenl   修改變量new_qty類型，由INT->number(16.8)
# Modify.........: No.TQC-740198 07/04/22 By Ray "應生產量"欄位為負數沒有管控，轉到工單時生產數量為負數
# Modify.........: No.TQC-770121 07/07/26 By wujie 有兩個變量定義錯誤
# Modify.........: No.CHI-740001 07/09/27 By rainy bma_file要判斷有效碼
# Modify.........: No.MOD-7B0031 07/11/07 By Pengu 元件間是否開例子工單應是個別獨立不應互相受影響
# Modify.........: No.FUN-710073 07/12/03 By jamie 1.UI將 '天' -> '天/生產批量'
#                                                  2.將程式有用到 'XX前置時間'改為乘以('XX前置時間' 除以 '生產單位批量(ima56)')
# Modify.........: No.MOD-7C0001 07/12/11 By Pengu 若按確定要繼續作業，還是會關閉程式
# Modify.........: No.CHI-810015 08/01/17 By jamie 將FUN-710073修改部份還原
# Modify.........: No.FUN-7B0018 08/02/17 By hellen 行業比拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.MOD-830148 08/03/19 By Pengu 發料損耗率應該考慮整體參數sma71
# Modify.........: No.MOD-810039 08/03/24 By Pengu 產生子工單時應考慮生產批量與最小生產量
# Modify.........: No.MOD-7C0214 08/03/25 By Pengu asf-837的訊息無法完整的show出
# Modify.........: No.MOD-860099 08/06/12 By cliare 不再顯示備料展子工單訊息對話框詢問
# Modify.........: No.FUN-840194 08/06/24 By sherry 增加變動前置時間批量（ima061）
# Modify.........: No.MOD-840543 08/07/04 By Pengu 有寫死 FOR i=1 TO 100如此會導致若為需大量開子工單之行業
# Modify.........: No.MOD-880225 08/09/03 By Pengu "工單編號"欄位應檢核單據性質是否正確
# Modify.........: No.CHI-8A0002 08/10/06 By claire 展開時要先確認BOM是否發放
# Modify.........: No.FUN-8B0035 08/11/12 By jan 下階料展BOM時，特性代碼抓ima910
# Modify.........: No.MOD-8B0297 08/11/28 By sherry 預計工單完工入庫倉庫sfb30應根據子工單生產料號抓ima35
# Modify.........: No.MOD-910092 09/01/09 By claire 子工單的預計完工日未考慮排除非工作日
# Modify.........: No.MOD-930056 09/03/05 By Pengu 當日其未設定工作天資料時則不在往下推
# Modify.........: No.FUN-8C0081 09/03/10 By sabrina INSERT INTO sfb_file時，簽核狀況(sfb43)、申請人(sfb44)、簽核(sfbmksg)要給初始值
# Modify.........: No.MOD-940197 09/05/21 By Pengu 產生子工單時產品手冊應default母工單手冊編號
# Modify.........: No.FUN-980008 09/08/14 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.MOD-9A0065 09/10/12 By Smapmin 計算預計開工日,邏輯需與asfi301.4gl - i300_time()一致
# Modify.........: No:MOD-960148 09/10/20 By Pengu 展子供單時未一料件基本檔的主特性代碼展下階元件
# Modify.........: No:MOD-AC0077 10/12/09 By sabrina 型態為"委外工單"時，則"部門/廠商"default為"主要供應商"
# Modify.........: No:FUN-9C0009 09/12/02 by dxfwo  GP5.2 變更檔案權限時應使用 os.Path.chrwx 指令
# Modify.........: No.FUN-9C0072 10/01/11 By vealxu 精簡程式碼
# Modify.........: No.TQC-A30066 10/03/12 By destiny 管控来源单号只能输入审核后的资料
# Modify.........: No.TQC-A50087 10/05/20 By liuxqa sfb104 赋初值.
# Modify.........: No:MOD-A70044 10/07/06 By Sarah 按下放棄後,應該要將l_flag值變更為'N',才能正常離開程式
# Modify.........: No:FUN-A70034 10/07/15 By Carrier 平行工艺-分量损耗运用
# Modify.........: No:MOD-A70028 10/08/03 By Pengu 程式位使用cl_used()
# Modify.........: No.FUN-A80102 10/08/24 By kim GP5.25號機管理
# Modify.........: No:MOD-A80224 10/08/30 By sabrina 在做chmod之前要先判斷檔案是否存在
# Modify.........: No.FUN-A90035 10/09/20 By vealxu 新增sfd_file時,確認碼給 'N'
# Modify.........: No:MOD-A10157 10/11/24 By sabrina 委外加工件也應該要考慮最小生產批量
# Modify.........: No:TQC-AC0238 10/12/17 By Mengxw  單工工號的欄位檢查及開窗都要排除smy73='Y'的工單
# Modify.........: No:MOD-B10021 11/01/05 By sabrina 料件來源為"S"時，單身的"工單開立展開選項"應帶入BOM的預設值
# Modify.........: No.MOD-B30028 11/03/04 By zhangll 修正插入sfci_file,系统异常当出问题
# Modify.........: No.MOD-B30414 11/03/14 By jan 若asfp301 單頭'應產生PBI'沒有勾選的話，此時子工單的sfb85不須給值
# Modify.........: No:FUN-B30211 11/03/31 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No:CHI-B80053 11/10/06 By johung 成本中心是null時，帶入輸入料號的ima34
# Modify.........: No.FUN-BC0008 11/12/02 By zhangll s_cralc4整合成s_cralc,s_cralc增加傳參
# Modify.........: No:MOD-C20062 12/02/09 by destiny 产生子工单时应该在插入完sfb_file后调用s_schdat,否则ecm_file资料产生不正确
# Modify.........: No.MOD-C30287 12/03/10 By xianghui 產生子工單的時sfb44的預設值給母工單的sfb44
# Modify.........: No:MOD-C50055 12/05/09 By suncx 預計開工和完工日計算錯誤
# Modify.........: No:MOD-C40117 12/04/17 by destiny 产生子工单时应允许子工单的成本中心与母工单的不一致
# Modify.........: No:MOD-BC0108 12/06/15 By ck2yuan p301_bom加上虛擬料繼續展下階的處理
# Modify.........: No:FUN-C30114 12/08/07 By bart 寫入母工單號時，一併寫入上階工單單號
# Modify.........: No:CHI-C60023 12/08/20 By bart 新增欄位-資料類別
# Modify.........: No:TQC-C90030 12/09/07 By chenjing 新增部門/廠商開窗
# Modify.........: No:MOD-CB0090 12/11/23 By Elise 特性代碼判斷是否由母工單串入
# Modify.........: No:MOD-D10272 13/01/31 By suncx 修改子工單類型的抓取方式，優先取單別對應的單據型態，如取不到則按料件判斷
# Modify.........: No:MOD-D20122 13/02/25 By bart 子工單也應考慮損耗率
# Modify.........: No:FUN-D10127 13/03/15 By Alberti 增加sfduser,sfdgrup,sfdmodu,sfddate,sfdacti
# Modify.........: No:MOD-D30136 13/03/18 By bart 單頭的生產數量因要考慮生產單位批量而進位

IMPORT os   #No.FUN-9C0009
DATABASE ds

GLOBALS "../../config/top.global"

DEFINE
         g_sfb	RECORD LIKE sfb_file.*,
         sfc_sw LIKE type_file.chr1,          #No.FUN-680121 VARCHAR(1)
         g_cmd  LIKE type_file.chr1000,       #No.FUN-680121 VARCHAR(200)
         g_t1   LIKE oay_file.oayslip,                     #No.FUN-550067          #No.FUN-680121 VARCHAR(05)
         new DYNAMIC ARRAY OF RECORD
           	new_part	LIKE sfb_file.sfb05,   #No.MOD-490217
            ima02_1   LIKE ima_file.ima02,
            ima021_1  LIKE ima_file.ima021,
          	new_qty 	LIKE bmb_file.bmb06,          #No.MOD-730136
          	b_date  	LIKE type_file.dat,           #No.FUN-680121 DATE
          	e_date  	LIKE type_file.dat,           #No.FUN-680121 DATE
            new_no    LIKE oea_file.oea01,          #No.FUN-680121 VARCHAR(16) #No.FUN-550067
          	wo_type 	LIKE type_file.chr1,          #No.FUN-680121 VARCHAR(1)
          	ven_no  	LIKE pmc_file.pmc01,          #No.FUN-680121 VARCHAR(10)
                new_bmb19       LIKE type_file.chr1           #No.FUN-680121 VARCHAR(1) #No:9305
          	END RECORD
DEFINE  p_argv1 LIKE sfb_file.sfb01,
        p_argv2 LIKE sfb_file.sfb81,
        p_argv3 LIKE sfb_file.sfb42,
        p_argv4 LIKE type_file.chr1,         #No.FUN-680121 VARCHAR(1)
        g_flag  LIKE type_file.chr1          #No.FUN-680121 VARCHAR(1)

DEFINE  g_cnt           LIKE type_file.num10            #No.FUN-680121 INTEGER
DEFINE  g_i             LIKE type_file.num5     #count/index for any purpose        #No.FUN-680121 SMALLINT
DEFINE  l_flag          LIKE type_file.chr1     #Print tm.wc ?(Y/N)        #No.FUN-680121 VARCHAR(1)
DEFINE  g_sql           STRING                  #TQC-AC0238
DEFINE  g_tc_sfb  RECORD LIKE tc_sfb_file.*  #add by wy20150525

MAIN
   DEFINE l_ima910   LIKE ima_file.ima910   #FUN-550112

   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT				# Supress DEL key function

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("ASF")) THEN
      EXIT PROGRAM
   END IF

   CALL cl_used(g_prog,g_time,1) RETURNING g_time   #No:MOD-A70028 add
   LET p_argv1=ARG_VAL(1)
   LET p_argv2=ARG_VAL(2)
   LET p_argv3=ARG_VAL(3)
   LET p_argv4=ARG_VAL(4)

  WHILE TRUE
   IF cl_null(p_argv1)
      THEN
      SELECT * INTO g_tc_sfb.* FROM tc_sfb_file where tc_sfb01=0 #add by wy20150601
      LET g_flag='Y'   # output to print
     #LET l_flag='Y'   # No:MOD-7C0001 add  #MOD-A80224 mark
      LET l_flag='1'   #MOD-A80224 add
      CALL p301_tm()
     #IF l_flag = 'Y' THEN   #MOD-A70044 mod   #MOD-A80224 mark
      IF l_flag = '1' THEN   #MOD-A70044 mod   #MOD-A80224
         CONTINUE WHILE
      ELSE
         CLOSE WINDOW p301_w
         EXIT WHILE
      END IF
    ELSE
      LET g_flag='N'
      LET g_sfb.sfb01=p_argv1
      LET g_sfb.sfb81=p_argv2
      LET g_sfb.sfb42=p_argv3
      LET sfc_sw     =p_argv4
      CALL new.clear()
      LET g_i=0
      SELECT * INTO g_tc_sfb.* FROM tc_sfb_file where tc_sfb01=0 #add by wy20150525
      SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01=g_sfb.sfb01
      LET l_ima910=''
      SELECT sfb95  INTO l_ima910 FROM sfb_file WHERE sfb01=g_sfb.sfb01 #FUN-650193
      IF cl_null(l_ima910) THEN LET l_ima910=' ' END IF

      CALL p301_bom(0,g_sfb.sfb05,l_ima910,g_sfb.sfb08,g_sfb.sfb13)  #FUN-550112
      IF g_i=0 THEN
         CLOSE WINDOW p301_w
        #--------------No:MOD-A70028 modify
        #EXIT PROGRAM
         EXIT WHILE
        #--------------No:MOD-A70028 end
      END IF
      LET g_success='Y'
      BEGIN WORK
      LET g_sfb.sfb42=p_argv3

      CASE
        WHEN g_sma.sma848='1'
             OPEN WINDOW p301_w AT 4,2 WITH FORM "asf/42f/asfp301"
                  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

             CALL cl_ui_init()
             CALL cl_opmsg('z')
             #FUN-A80102(S)
             IF g_sma.sma1421='Y' THEN
                CALL cl_set_comp_visible("sfb919",TRUE)
             ELSE
                CALL cl_set_comp_visible("sfb919",FALSE)
             END IF
             #FUN-A80102(E)
             DISPLAY BY NAME g_sfb.sfb01,g_sfb.sfb05,
                             g_sfb.sfb08,g_sfb.sfb071,
                             g_sfb.sfb13,g_sfb.sfb15,
                             g_sfb.sfb81,g_sfb.sfb42,
                             sfc_sw,g_sfb.sfb919   #FUN-A80102
             LET p_argv1=''
             CALL asfp301()
         WHEN g_sma.sma848='2'
             CLOSE WINDOW screen   #MOD-580355

             OPEN WINDOW p301_w AT 16,10 WITH 4 ROWS, 60 COLUMNS
             CALL cl_ui_act()      #MOD-580355

             CALL asfp301()
      END CASE

         CALL s_showmsg()           #NO.FUN-710026
      IF g_success='Y' THEN
         COMMIT WORK
         CALL cl_msgany(0,0,"lib-022")         #批次作業正確結束
      ELSE
         ROLLBACK WORK
         CALL cl_msgany(0,0,"lib-030")         #批次作業失敗
      END IF
      CLOSE WINDOW p301_w
   END IF
   EXIT WHILE

  END WHILE
  CALL cl_used(g_prog,g_time,2) RETURNING g_time   #No:MOD-A70028 add
END MAIN

FUNCTION p301_tm()
   DEFINE   p_row,p_col   LIKE type_file.num5,          #No.FUN-680121 SMALLINT
            l_cmd         LIKE type_file.chr1000,       #No.FUN-680121 VARCHAR(30)
            l_name        LIKE type_file.chr20,         #No.FUN-680121 VARCHAR(20)
            l_ima02       LIKE ima_file.ima02,
            l_ima021      LIKE ima_file.ima021,
            l_result      LIKE type_file.num5           #MOD-A80224 add
   DEFINE p_cmd      LIKE type_file.chr1    #TQC-AC0238
   DEFINE l_ima910   LIKE ima_file.ima910   #FUN-550112


   IF s_shut(0) THEN
      RETURN
   END IF
   IF g_gui_type MATCHES "[13]" AND fgl_getenv('GUI_VER') = '6' THEN
      LET p_row = 3
      LET p_col = 20
   ELSE
      LET p_row = 4
      LET p_col = 2
   END IF

   OPEN WINDOW p301_w AT p_row,p_col
        WITH FORM "asf/42f/asfp301"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

   CALL cl_ui_init()

   CALL cl_opmsg('z')
   CLEAR FORM
   INITIALIZE g_sfb.* TO NULL
   LET sfc_sw='Y'
   CALL cl_set_head_visible("","YES")  #NO.FUN-6B0031
   INPUT BY NAME g_sfb.sfb01,g_sfb.sfb81,g_sfb.sfb42,sfc_sw
                 WITHOUT DEFAULTS
      ON ACTION locale
          CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf


      AFTER FIELD sfb01
         IF g_sfb.sfb01 IS NULL THEN
            NEXT FIELD sfb01
         END IF
        #SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01=g_sfb.sfb01 AND sfb87!='X'  #No.TQC-A30066
         SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01=g_sfb.sfb01                 #No.TQC-A30066
         IF STATUS THEN
            CALL cl_err3("sel","sfb_file",g_sfb.sfb01,"",STATUS,"","sel sfb:",0)    #No.FUN-660128
            NEXT FIELD sfb01
         END IF
         #No.TQC-A30066--begin
         IF g_sfb.sfb87!='Y' THEN
            CALL cl_err('','aap-084',1)
            NEXT FIELD sfb01
         END IF
         #No.TQC-A30066--end
         SELECT ima02,ima021 INTO l_ima02,l_ima021
           FROM ima_file
          WHERE ima01=g_sfb.sfb05
         DISPLAY l_ima02 TO FORMONLY.ima02
         DISPLAY l_ima021 TO FORMONLY.ima021
         DISPLAY BY NAME g_sfb.sfb05,g_sfb.sfb08,g_sfb.sfb071,g_sfb.sfb42,
                         g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb919   #FUN-A80102

      AFTER FIELD sfb42
         IF g_sfb.sfb42 IS NULL THEN
            NEXT FIELD sfb42
         END IF
         IF g_sfb.sfb42 = 0     THEN
            NEXT FIELD sfb42
         END IF

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION exit                            #加離開功能
         LET INT_FLAG = 1
         EXIT INPUT
      ON ACTION CONTROLP
         CASE
           WHEN INFIELD(sfb01)
              CALL cl_init_qry_var()
             #LET g_qryparam.form = "q_sfb"           #No.TQC-A30066
              LET g_qryparam.form = "q_sfb1103"       #No.TQC-A30066
             # LET g_qryparam.where = " smy73 <>'Y' OR smy73 is null"
              CALL cl_create_qry() RETURNING g_sfb.sfb01
              NEXT FIELD sfb01
         END CASE
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
     #LET l_flag = 'N'   #MOD-A70044 add #MOD-A80224 mark
      LET l_flag = '0'   #MOD-A80224 add
     #EXIT PROGRAM    #No:MOD-A70028 mark
      RETURN          #No:MOD-A70028 add
   END IF
   MESSAGE "WAITING..."
   FOR g_i=1 TO 100 INITIALIZE new[g_i].* TO NULL END FOR
   LET g_i=0
   LET l_ima910=''
   LET l_ima910=g_sfb.sfb95 #FUN-650193
   IF cl_null(l_ima910) THEN LET l_ima910=' ' END IF
   CALL p301_bom(0,g_sfb.sfb05,l_ima910,g_sfb.sfb08,g_sfb.sfb13)  #FUN-550112
   CALL SET_COUNT(g_i)
   LET g_success='Y'
   CALL cl_outnam('asfp301') RETURNING l_name
   LET g_pageno=0
   BEGIN WORK
   START REPORT p301_rep TO l_name
   CALL asfp301()
   CALL s_showmsg()           #NO.FUN-710026
   FINISH REPORT p301_rep
  #IF g_success='Y' THEN                   #No.TQC-A30066
   IF g_success='Y' AND g_i>0 THEN         #No.TQC-A30066
      COMMIT WORK
      CALL cl_prt(l_name,g_prtway,g_copies,g_len)
      CALL cl_end2(1) RETURNING l_flag        #批次作業正確結束
   ELSE
      CALL os.Path.exists(l_name) RETURNING l_result        #MOD-A80224 add
      IF l_result > 0 THEN    #MOD-A80224 add
         IF os.Path.chrwx(l_name CLIPPED,511) THEN END IF   #No.FUN-9C0009
      END IF     #MOD-A80224 add
      ROLLBACK WORK
      CALL cl_end2(2) RETURNING l_flag        #批次作業失敗
   END IF
   ERROR ""
END FUNCTION
#TQC-AC0238--start
FUNCTION i301_new_no(i)
   DEFINE i         LIKE type_file.num5
   DEFINE l_slip    LIKE smy_file.smyslip
   DEFINE l_smy73   LIKE smy_file.smy73

   LET g_errno = ' '
   LET l_slip = s_get_doc_no(new[i].new_no)

   SELECT smy73 INTO l_smy73 FROM smy_file
    WHERE smyslip = l_slip
   IF l_smy73 = 'Y' THEN
      LET g_errno = 'asf-875'
   END IF

END FUNCTION
#TQC-AC0238--end
FUNCTION asfp301()
   DEFINE l_za05	LIKE type_file.chr1000       #No.FUN-680121 VARCHAR(40)
   DEFINE l_item	LIKE ima_file.ima01
   DEFINE l_sfb		RECORD LIKE sfb_file.*
   DEFINE l_sfc		RECORD LIKE sfc_file.*
   DEFINE l_sfd		RECORD LIKE sfd_file.*
   DEFINE l_smy57       LIKE smy_file.smy57
   DEFINE l_smyapr      LIKE smy_file.smyapr    #FUN-8C0081 add
   DEFINE l_slip        LIKE smy_file.smyslip
   DEFINE new_part      LIKE sfb_file.sfb05          #No.MOD-490217
   DEFINE i,j		LIKE type_file.num10         #No.FUN-680121 INTEGER
   DEFINE k             LIKE type_file.num10         #No.FUN-680121 INTEGER #No.B630 add
   DEFINE l_ac          LIKE type_file.num10         #No.MOD-840543 add
   DEFINE l_msg         LIKE type_file.chr1000       #No.FUN-680121 VARCHAR(100) #MOD-480504
   DEFINE l_code        LIKE type_file.chr1          #No.FUN-680121 VARCHAR(1) #MOD-480504
   DEFINE li_result     LIKE type_file.num5          #No.FUN-550067         #No.FUN-680121 SMALLINT
   DEFINE l_sfci        RECORD LIKE sfci_file.*      #No.FUN-7B0018
  #DEFINE l_flag        LIKE type_file.chr1          #No.FUN-7B0018  #MOD-A80224 mark
   DEFINE l_flag2       LIKE type_file.chr1          #MOD-A80224 add
   DEFINE l_sfbi        RECORD LIKE sfbi_file.*      #No.FUN-7B0018
   DEFINE l_cnt         LIKE type_file.num5          #No.MOD-B30028
   DEFINE l_t1          LIKE oay_file.oayslip        #MOD-B30414
   DEFINE l_sfc01       LIKE sfc_file.sfc01          #MOD-B30414
   DEFINE l_sfb89       LIKE sfb_file.sfb89          #FUN-C30114
   DEFINE l_sfb01       LIKE sfb_file.sfb01          #FUN-C30114
   DEFINE l_sfb05       LIKE sfb_file.sfb05          #FUN-C30114
   DEFINE l_sfb95       LIKE sfb_file.sfb95          #MOD-CB0090 add
   DEFINE l_ima562      LIKE ima_file.ima562  #MOD-D20122
   DEFINE l_allowqty    LIKE sfb_file.sfb08          #MOD-D30136
   DEFINE l_calc        LIKE type_file.num5          #MOD-D30136
   DEFINE l_ima56       LIKE ima_file.ima56          #MOD-D30136
   #add by lanhang 131016 begin
   DEFINE l_buf             LIKE ima_file.ima01
   DEFINE l_azf15           LIKE azf_file.azf15
   DEFINE l_azf16           LIKE azf_file.azf16
   DEFINE l_azf17           LIKE azf_file.azf17
   DEFINE l_rate            LIKE type_file.num20_6
   DEFINE l_md              LIKE sfb_file.ta_sfb23
   DEFINE l_ima1003         LIKE ima_file.ima1003
   #add by lanhang 131016 end
   DEFINE l_sql         STRING                       #MOD-DB0130 add
   DEFINE chk_sfb02 LIKE sfb_file.sfb02  #add by wy20150601
   DEFINE l_sfb13   LIKE sfb_file.sfb13  #add by wy20150601
   DEFINE l_bmb03   LIKE bmb_file.bmb03  #add by wy20150602
   DEFINE l_ta_ima07  LIKE ima_file.ta_ima07 #add by liufang170712

   IF cl_null(p_argv1) THEN
      INPUT ARRAY new WITHOUT DEFAULTS FROM s_new.*
         ATTRIBUTE(MAXCOUNT=g_max_rec,UNBUFFERED,INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)
         AFTER FIELD wo_type
           LET i=ARR_CURR()
           IF new[i].wo_type NOT MATCHES '[17]' THEN NEXT FIELD wo_type END IF
         AFTER FIELD ven_no
           LET i=ARR_CURR()
           IF new[i].ven_no IS NOT NULL THEN
              IF new[i].wo_type=1 THEN
                 SELECT gem02 FROM gem_file WHERE gem01=new[i].ven_no
                    AND gemacti='Y'   #NO:6950
                 IF STATUS THEN
                    CALL cl_err3("sel","gem_file",new[i].ven_no,"",STATUS,"","sel gem:",1)    #No.FUN-660128
                    NEXT FIELD ven_no
                 END IF
              END IF
              IF new[i].wo_type=7 THEN
                 SELECT pmc03 FROM pmc_file WHERE pmc01=new[i].ven_no
                 IF STATUS THEN
                    CALL cl_err3("sel","pmc_file",new[i].ven_no,"",STATUS,"","sel pmc:",1)    #No.FUN-660128
                     NEXT FIELD ven_no
                 END IF
              END IF
           END IF

         AFTER FIELD new_qty
           LET i=ARR_CURR()
           IF NOT cl_null(new[i].new_qty) THEN
              IF new[i].new_qty < 0 THEN
                 CALL cl_err(new[i].new_qty,'asf-108',0)
                 NEXT FIELD new_qty
              END IF
           END IF

        AFTER FIELD new_no
          # TQC-AC0238--start
           CALL i301_new_no(i)
           IF NOT cl_null(g_errno) THEN
              CALL cl_err(new[i].new_no,g_errno,0)
              LET new[i].new_no = NULL
              DISPLAY BY NAME new[i].new_no
              NEXT FIELD new_no
           END IF
         #  TQC-AC0238--end
           IF NOT cl_null(new[i].new_no) THEN
              CALL s_check_no("asf",new[i].new_no,'',"1","sfb_file","sfb01","")
              RETURNING li_result,new[i].new_no
              DISPLAY BY NAME new[i].new_no
              IF (NOT li_result) THEN
                NEXT FIELD new_no
              END IF
           END IF

        #MOD-C50055 add begin----------------------------
        AFTER FIELD b_date,e_date
           IF new[i].b_date > new[i].e_date THEN
              CALL cl_err('','asf-310','1')
              NEXT FIELD CURRENT
           END IF
           IF (new[i].b_date IS NULL OR new[i].b_date<g_sfb.sfb81) OR
              (new[i].e_date IS NULL OR new[i].e_date<g_sfb.sfb81) THEN
              CALL cl_err('','asf-373','1')
              NEXT FIELD CURRENT
           END IF
           IF INFIELD(b_date) THEN
              LET li_result = 0
              CALL s_daywk(new[i].b_date) RETURNING li_result
              IF li_result = 0 THEN      #0:非工作日
                 CALL cl_err(new[i].b_date,'mfg3152',1)
              END IF
              IF li_result = 2 THEN      #2:未設定
                 CALL cl_err(new[i].b_date,'mfg3153',1)
              END IF
           END IF
           IF INFIELD(e_date) THEN
              LET li_result = 0
              CALL s_daywk(new[i].e_date) RETURNING li_result
              IF li_result = 0 THEN      #0:非工作日
                 CALL cl_err(new[i].e_date,'mfg3152',1)
              END IF
              IF li_result = 2 THEN      #2:未設定
                 CALL cl_err(new[i].e_date,'mfg3153',1)
              END IF
           END IF
        #MOD-C50055 add end------------------------------
        AFTER DELETE
          LET k = ARR_COUNT()
          INITIALIZE new[k+1].* TO NULL

        ON ACTION controlp
           CASE
              WHEN INFIELD(new_no)
                    LET g_sql = "(smy73<>'Y' OR smy73 is null)"     #TQC-AC0238
                    CALL smy_qry_set_par_where(g_sql)               #TQC-AC0238
                    LET g_t1 = s_get_doc_no(new[i].new_no)
                    CALL q_smy( FALSE,TRUE,g_t1,'ASF','1') RETURNING g_t1
                    LET new[i].new_no=g_t1
                    DISPLAY BY NAME new[i].new_no
                    NEXT FIELD new_no
            #TQC-C90030--add--start--
              WHEN INFIELD(ven_no)
                 IF new[i].wo_type ='7' THEN
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_pmc3"
                    LET g_qryparam.default1 = new[i].ven_no
                    CALL cl_create_qry() RETURNING new[i].ven_no
                 ELSE
                    CALL cl_init_qry_var()
                    LET g_qryparam.form  = "q_gem"
                    LET g_qryparam.default1 = new[i].ven_no
                    CALL cl_create_qry() RETURNING new[i].ven_no
                 END IF
                 DISPLAY BY NAME new[i].ven_no
                 NEXT FIELD ven_no
            #TQC-C90030--add--end--
           END CASE

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT
         ON ACTION CONTROLS
            CALL cl_set_head_visible("","AUTO")
      END INPUT
      IF INT_FLAG THEN LET INT_FLAG=0 LET g_success='N' RETURN END IF
      IF NOT cl_sure(19,0) THEN LET g_success='N' RETURN END IF
   END IF

   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
   IF sfc_sw='Y' THEN
      #MOD-B30414--begin--add-----
      LET l_t1=s_get_doc_no(g_sfb.sfb01)
      SELECT smy75 INTO l_sfc01 FROM smy_file
       WHERE smyslip=l_t1
      IF cl_null(l_sfc01) THEN
         CALL cl_err('sel smy75','aec-060',1)
         LET g_success='N' RETURN
      END IF
      CALL s_auto_assign_no("asf",l_sfc01,g_today,"8","sfd_file","sfd01","","","")
      RETURNING li_result,l_sfc01
      IF (NOT li_result) THEN
         LET g_success='N'
          RETURN
      END IF
       #MOD-B30414--end--add---------
     #UPDATE sfb_file SET sfb85=g_sfb.sfb01 WHERE sfb01=g_sfb.sfb01   #MOD-B30414
      UPDATE sfb_file SET sfb85=l_sfc01 WHERE sfb01=g_sfb.sfb01       #MOD-B30414
      IF STATUS THEN
         CALL cl_err3("upd","sfb_file",g_sfb.sfb01,"",STATUS,"","upd sfb85:",1)    #No.FUN-660128
         LET g_success='N' RETURN

      END IF
     #LET l_sfc.sfc01   =g_sfb.sfb01  #MOD-B30414
      LET l_sfc.sfc01   =l_sfc01      #MOD-B30414
      LET l_sfc.sfcacti ='Y'
      LET l_sfc.sfcuser =g_user
      LET l_sfc.sfcgrup =g_grup
      LET l_sfc.sfcdate =g_today
      LET l_sfc.sfcoriu = g_user      #No.FUN-980030 10/01/04
      LET l_sfc.sfcorig = g_grup      #No.FUN-980030 10/01/04
      INSERT INTO sfc_file VALUES(l_sfc.*)
      IF NOT s_industry('std') THEN
         INITIALIZE l_sfci.* TO NULL
         LET l_sfci.sfci01 = l_sfc.sfc01
        #LET l_flag = s_ins_sfci(l_sfci.*,'')     #MOD-A80224 mark
        #Mod No.MOD-B30028
        #LET l_flag2 = s_ins_sfci(l_sfci.*,'')    #MOD-A80224 add
         SELECT COUNT(*) INTO l_cnt FROM sfci_file
          WHERE sfci01 = l_sfci.sfci01
         IF l_cnt = 0 THEN
            LET l_flag2 = s_ins_sfci(l_sfci.*,'')    #MOD-A80224 add
         END IF
        #End Mod No.MOD-B30028
      END IF
     #LET l_sfd.sfd01   =g_sfb.sfb01 #MOD-B30414
      LET l_sfd.sfd01   =l_sfc01     #MOD-B30414
      LET l_sfd.sfd02   =1
      LET l_sfd.sfd03   =g_sfb.sfb01
      LET l_sfd.sfdconf = 'N'                 #FUN-A90035 add
      LET l_sfd.sfd09   ='2'  #CHI-C60023
      LET l_sfd.sfduser = g_user        #FUN-D10127
      LET l_sfd.sfdgrup = g_grup        #FUN-D10127
      LET l_sfd.sfddate = g_today       #FUN-D10127
      LET l_sfd.sfdacti ='Y'            #FUN-D10127
      LET l_sfd.sfdoriu = g_user        #FUN-D10127
      LET l_sfd.sfdorig = g_grup        #FUN-D10127
      INSERT INTO sfd_file VALUES(l_sfd.*)
   END IF
   CALL s_showmsg_init()    #NO.FUN-710026
   LET l_ac = new.getlength()
   IF cl_null(l_ac) THEN LET l_ac = 1 END IF
   FOR i=1 TO l_ac
   IF g_success='N' THEN
      LET g_totsuccess='N'
      LET g_success="Y"
   END IF

    IF new[i].new_bmb19 ='3' THEN CONTINUE FOR END IF  #No:9305
	IF new[i].new_part IS NULL THEN CONTINUE FOR END IF
	IF new[i].new_qty  IS NULL THEN CONTINUE FOR END IF
	IF new[i].new_qty  = 0     THEN CONTINUE FOR END IF
	INITIALIZE l_sfb.* TO NULL
	LET l_sfb.sfb01 =new[i].new_no
	LET l_sfb.sfb02 =new[i].wo_type
	LET l_sfb.sfb04 ='1'
	LET l_sfb.sfb05 =new[i].new_part
	SELECT ima571,ima94 INTO l_item,l_sfb.sfb06 FROM ima_file WHERE ima01=l_sfb.sfb05
	LET l_sfb.sfb071=g_sfb.sfb071
    #MOD-D20122---begin
    #LET l_sfb.sfb08 =new[i].new_qty
    SELECT ((ima562+100)/100),ima56 INTO l_ima562, l_ima56  #MOD-D30136
      FROM ima_file
     WHERE ima01 = new[i].new_part
    IF cl_null(l_ima562) THEN LET l_ima562 = 1 END IF
    LET l_sfb.sfb08 =new[i].new_qty*l_ima562
    #MOD-D30136---begin
    LET l_allowqty = l_sfb.sfb08
    IF NOT cl_null(l_ima56) AND l_ima56 > 0 THEN
       LET l_calc = 0
       IF l_allowqty MOD l_ima56 > 0 THEN
          LET l_calc = l_allowqty/l_ima56 + 1
          LET l_allowqty = l_calc * l_ima56
       END IF
    END IF
    LET l_sfb.sfb08 = l_allowqty
    #MOD-D30136---end
    #MOD-D20122---end
    LET l_sfb.sfbud02 = g_sfb.sfbud02
	LET l_sfb.sfb081=0
	LET l_sfb.sfb09 =0
	LET l_sfb.sfb10 =0
	LET l_sfb.sfb11 =0
	LET l_sfb.sfb111=0
	LET l_sfb.sfb12 =0
	LET l_sfb.sfb13 =new[i].b_date
	LET l_sfb.sfb15 =new[i].e_date
	LET l_sfb.sfb23 ='N'
	LET l_sfb.sfb24 ='N'
	LET l_sfb.sfb251=g_sfb.sfb251
	LET l_sfb.sfb27 =g_sfb.sfb27
	LET l_sfb.sfb28 =''
	LET l_sfb.sfb29 ='Y'
        LET l_sfb.sfb121=g_sfb.sfb121    #NO:7134
        SELECT ima35 INTO l_sfb.sfb30 FROM ima_file
         WHERE ima01=l_sfb.sfb05
	LET l_sfb.sfb31 =g_sfb.sfb31
	LET l_sfb.sfb39 =g_sfb.sfb39
	LET l_sfb.sfb81 =g_sfb.sfb81
	LET l_sfb.sfb82 =new[i].ven_no
        IF sfc_sw='Y' THEN  #MOD-B30414
          #LET l_sfb.sfb85 =g_sfb.sfb01  #MOD-B30414
           LET l_sfb.sfb85 =l_sfc01      #MOD-B30414
        ELSE                  #MOD-B30414
           LET l_sfb.sfb85='' #MOD-B30414
        END IF                #MOD-B30414
	LET l_sfb.sfb86 =g_sfb.sfb01
    LET l_sfb.sfb89 =g_sfb.sfb01 #FUN-C30114
	LET l_sfb.sfb98 =g_sfb.sfb98
    LET l_sfb.sfb97 =g_sfb.sfb97      #No.MOD-940197 add
	LET l_sfb.sfb919=g_sfb.sfb919     #FUN-A80102
    LET l_sfb.sfb41 = 'N'    #NO:0490
    LET l_sfb.sfb99 = 'N'    #NO:0490
    LET l_sfb.sfb87 = 'N'    #97/08/21 modify
    LET l_sfb.sfb1002='N' #保稅核銷否 #FUN-6B0044
   #MOD-CB0090---add---S
    SELECT sfb95 INTO l_sfb95 FROM sfb_file WHERE sfb01 = g_sfb.sfb01
    IF NOT cl_null(p_argv1) THEN
       LET l_sfb.sfb95 = l_sfb95
    ELSE
       IF cl_null(l_sfb95) THEN
 #MOD-CB0090---add---E
          SELECT ima910 INTO l_sfb.sfb95
            FROM ima_file
           WHERE ima01 = l_sfb.sfb05
       END IF                          #MOD-CB0090 add
    END IF                             #MOD-CB0090 add

    IF cl_null(l_sfb.sfb95) THEN
       LET l_sfb.sfb95 = ' '
    END IF
	LET l_sfb.sfbacti='Y'
	LET l_sfb.sfbuser=g_user
	LET l_sfb.sfbgrup=g_grup
	LET l_sfb.sfbdate=g_today
      CALL s_auto_assign_no("asf",l_sfb.sfb01,l_sfb.sfb81,"","sfb_file","sfb01","","","")
      RETURNING li_result,l_sfb.sfb01
      IF (NOT li_result) THEN LET g_success='N' RETURN END IF	#有問題

      LET l_msg = cl_getmsg('asf-837',g_lang) CLIPPED,l_sfb.sfb05 CLIPPED,"      ",   #No.MOD-7C0214 modify
                  cl_getmsg('asf-839',g_lang) CLIPPED,l_sfb.sfb01                     #No.MOD-7C0214 modify
      CALL cl_err(l_msg,' ',0)
      CALL ui.Interface.refresh()
      LET l_slip = s_get_doc_no(l_sfb.sfb01)     #No.FUN-550067
      SELECT smy57,smyapr INTO l_smy57,l_smyapr FROM smy_file WHERE smyslip=l_slip  #FUN-8C0081 add
      LET l_sfb.sfb93=l_smy57[1,1]  #BugNo:4737
      LET l_sfb.sfb94=l_smy57[2,2]
      LET l_sfb.sfb100=l_smy57[6,6] #MOD-640425
      LET l_sfb.sfb43 = '0'         #FUN-8C0081 add
      LET l_sfb.sfbmksg = l_smyapr  #FUN-8C0081 add
     #LET l_sfb.sfb44 = g_user      #FUN-8C0081 add  #MOD-C30287 mark
      LET l_sfb.sfb44 = g_sfb.sfb44 #MOD-C30287
      LET l_sfb.sfbplant = g_plant  #FUN-980008 add
      LET l_sfb.sfblegal = g_legal  #FUN-980008 add
      LET l_sfb.sfb104 = 'N'        #TQC-A50087 add
        #MOD-C20062--begin
#       IF l_sfb.sfb93='Y' THEN
#          CALL s_schdat(0,l_sfb.sfb13,l_sfb.sfb15,l_sfb.sfb071,
#                        l_sfb.sfb01,l_sfb.sfb06,l_sfb.sfb02,l_item,
#                        l_sfb.sfb08,2)
#             RETURNING g_cnt,l_sfb.sfb13,l_sfb.sfb15,l_sfb.sfb32,l_sfb.sfb24
#       END IF
        #MOD-C20062--end
#CHI-B80053 -- begin --
       #IF cl_null(l_sfb.sfb98) THEN      #MOD-C40117--mark
      SELECT ima34 INTO l_sfb.sfb98 FROM ima_file
       WHERE ima01 = l_sfb.sfb05
       #END IF                            #MOD-C40117--mark
#CHI-B80053 -- end --
      LET l_sfb.sfboriu = g_user      #No.FUN-980030 10/01/04
      LET l_sfb.sfborig = g_grup      #No.FUN-980030 10/01/04
      #add by lanhang 131016 begin PVC料工单，PVC信息截取
      SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=l_sfb.sfb05
      #IF l_sfb.sfb05[1,2] MATCHES "P[ADH]" THEN   #皮料以PA、PD、PH开头

      IF l_ima1003='Y' THEN   #生产料号为皮料
         LET l_sfb.sfb39='2'
      #   LET l_sfb.ta_sfb02 = l_sfb.sfb05[3,6] #mark by liufang170712
      #   LET l_buf=l_sfb.sfb05[7,8]            #mark by liufang170712
      #   LET l_sfb.ta_sfb03=l_buf/100          #mark by liufang170712
      #   LET l_buf=l_sfb.sfb05[9,10]           #mark by liufang170712
      #   SELECT azf03,azf15,azf16,azf17 INTO l_sfb.ta_sfb04,l_azf15,l_azf16,l_azf17 #mark by liufang170712
      #     FROM azf_file WHERE azf01=l_buf AND azf02='P' #mark by liufang170712
    #add by liufang170712 start------
         SELECT ta_ima04,ta_ima06,ta_ima08,ta_ima07 INTO l_sfb.ta_sfb01,l_sfb.ta_sfb03,l_sfb.ta_sfb02,l_ta_ima07
            FROM ima_file WHERE ima01=l_sfb.sfb05
           # SELECT azf03,azf15,azf16,azf17 INTO g_sfb.ta_sfb04,l_azf15,l_azf16,l_azf17 #mark by liufang170724
           SELECT azf03,azf15,azf16,azf17 INTO l_sfb.ta_sfb04,l_azf15,l_azf16,l_azf17 #add by liufang170724
            FROM azf_file WHERE azf01=l_ta_ima07 AND azf02 = 'P'
           IF cl_null(l_azf16) THEN LET l_azf16 = 0 END IF
           IF cl_null(l_azf17) THEN LET l_azf17 = 0 END IF
   #add by liufang170712 start------

        # IF sqlca.sqlcode THEN  #mark by liufang170712
        #    CALL cl_err(l_buf,'csf-000',0)  #mark by liufang170712
        #    CONTINUE FOR  #mark by liufang170712
        # END IF   #mark by liufang170712
         IF l_azf16<>l_azf17 THEN
            IF l_sfb.ta_sfb03<=l_azf15 THEN
               LET l_sfb.ta_sfb06=l_azf16
            ELSE
               LET l_sfb.ta_sfb06=l_azf17
            END IF
         ELSE
            LET l_sfb.ta_sfb06=l_azf16
         END IF
         LET l_sfb.ta_sfb07=l_sfb.ta_sfb03-l_sfb.ta_sfb06
     #    LET l_sfb.ta_sfb01=l_sfb.sfb05[11,16] #mark by liufang170712
         SELECT ta_smd03,ta_smd04 INTO l_md,l_rate
           FROM smd_file,ima_file
          WHERE smd01=l_sfb.sfb05 AND ima01=smd01 AND smd02='码' AND smd03=ima55
         IF cl_null(l_md) THEN LET l_md=1.3 END IF
         IF cl_null(l_rate) THEN LET l_rate=0.9144 END IF
         IF cl_null(l_sfb.ta_sfb23) THEN                #密度
            LET l_sfb.ta_sfb23 = l_md
         END IF
         LET l_sfb.ta_sfb11=l_sfb.sfb08*1000/l_rate/l_sfb.ta_sfb02/l_sfb.ta_sfb07/l_md  #码数产量
         SELECT ceil(l_sfb.ta_sfb11) INTO l_sfb.ta_sfb26 FROM dual         #实际码数
         LET l_sfb.ta_sfb25=l_sfb.ta_sfb26*l_rate*l_sfb.ta_sfb02*l_sfb.ta_sfb07*l_sfb.ta_sfb23/1000 #实际重量
         IF NOT cl_null(l_sfb.ta_sfb12) THEN   #单支码数
            SELECT ceil(l_sfb.ta_sfb11/l_sfb.ta_sfb12) INTO l_sfb.ta_sfb14 FROM dual                #支数
            LET l_sfb.ta_sfb13=l_sfb.ta_sfb12*l_rate*l_sfb.ta_sfb02*l_sfb.ta_sfb07*l_sfb.ta_sfb23/1000 #单支重量
         END IF
         IF NOT cl_null(l_sfb.ta_sfb08) THEN   #单手重量
            SELECT ceil((l_sfb.ta_sfb25+100)/l_sfb.ta_sfb08) INTO l_sfb.ta_sfb09 FROM dual
         END IF
         LET l_sfb.ta_sfb24='上海吉龙'
      END IF
      #add by lanhang 131016 end
      #add by lanhang 131010 begin
      SELECT bmaud01,bmaud02,bmaud03,bmaud04,bmaud05,bmaud06,bmaud07
        INTO l_sfb.sfbud01,l_sfb.sfbud03,l_sfb.sfbud04,l_sfb.sfbud05,
             l_sfb.sfbud06,l_sfb.sfbud08,l_sfb.sfbud07
        FROM bma_file
       WHERE bma01=l_sfb.sfb05 AND bmaacti='Y'
         AND bma05 IS NOT NULL AND bma05 <=l_sfb.sfb81
      #add by lanhang 131010 end
	  INSERT INTO sfb_file VALUES(l_sfb.*)
      IF STATUS THEN
         CALL s_errmsg('smyslip',l_slip,'ins sfb:',STATUS,1)                     #NO.FUN-710026
         LET g_success='N' RETURN
      ELSE
        #MOD-C20062--begin
         IF l_sfb.sfb93='Y' THEN
            CALL s_schdat(0,l_sfb.sfb13,l_sfb.sfb15,l_sfb.sfb071,
                         l_sfb.sfb01,l_sfb.sfb06,l_sfb.sfb02,l_item,
                         l_sfb.sfb08,2)
            RETURNING g_cnt,l_sfb.sfb13,l_sfb.sfb15,l_sfb.sfb32,l_sfb.sfb24
            UPDATE sfb_file SET sfb13 = l_sfb.sfb13,
                                sfb15 = l_sfb.sfb15,
                                sfb32 = l_sfb.sfb32,
                                sfb24 = l_sfb.sfb24
             WHERE sfb01 = l_sfb.sfb01
         END IF
         #MOD-C20062--end
         IF NOT s_industry('std') THEN
            INITIALIZE l_sfbi.* TO NULL
            LET l_sfbi.sfbi01 = l_sfb.sfb01
            IF NOT s_ins_sfbi(l_sfbi.*,'') THEN
               LET g_success = 'N'
               RETURN
            END IF
         END IF
	  END IF
      IF sfc_sw='Y' THEN
   	    #LET l_sfd.sfd01   =g_sfb.sfb01   #MOD-B30414
   	     LET l_sfd.sfd01   =l_sfc01       #MOD-B30414
         SELECT MAX(sfd02) INTO l_sfd.sfd02 FROM sfd_file
          WHERE sfd01=l_sfd.sfd01   #TQC-730038
         IF l_sfd.sfd02 IS NULL THEN LET l_sfd.sfd02 = 0 END IF
         LET l_sfd.sfd02   =l_sfd.sfd02 + 1
   	     LET l_sfd.sfd03   =l_sfb.sfb01
         LET l_sfd.sfdconf = 'N'                #FUN-A90035 add
         LET l_sfd.sfd09   ='2'  #CHI-C60023
         LET  l_sfd.sfduser = g_user        #FUN-D10127
         LET  l_sfd.sfdgrup = g_grup        #FUN-D10127
         LET  l_sfd.sfddate = g_today       #FUN-D10127
         LET  l_sfd.sfdacti ='Y'            #FUN-D10127
         LET  l_sfd.sfdoriu = g_user        #FUN-D10127
         LET  l_sfd.sfdorig = g_grup        #FUN-D10127
   	     INSERT INTO sfd_file VALUES(l_sfd.*)
   	     IF STATUS THEN
            CALL s_errmsg('sfd01', l_sfd.sfd01 ,'ins sfd:',STATUS,1)                        #NO.FUN-710026   #TQC-730038
            LET g_success='N' RETURN
   	     END IF
      END IF
     #IF g_sma.sma27='1' THEN             #mark BY lanhang 131017
      SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=l_sfb.sfb05
     #IF g_sfb.sfb05[1,2] MATCHES "P[ADH]" THEN   #皮料以PA、PD、PH开头
      IF g_sma.sma27='1' AND l_ima1003!='Y' THEN   #mod BY lanhang 131017  皮料不展下阶备料
         CALL s_cralc(l_sfb.sfb01,l_sfb.sfb02,l_sfb.sfb05,'Y',
                     #l_sfb.sfb08,l_sfb.sfb071,'Y',g_sma.sma71,0,l_sfb.sfb95)   #No.TQC-610003
                      l_sfb.sfb08,l_sfb.sfb071,'Y',g_sma.sma71,0,'',l_sfb.sfb95)   #No.TQC-610003  #FUN-BC0008 mod
                      RETURNING g_cnt

   	  END IF
	  IF cl_null(p_argv1) AND g_flag='Y' THEN
         OUTPUT TO REPORT p301_rep(l_sfb.*)
      END IF
   END FOR
   #FUN-C30114
   DECLARE p301_sfb89_cs CURSOR FOR SELECT sfb01,sfb05
                               FROM sfb_file
                              WHERE sfb86 = g_sfb.sfb01
   #MOD-DB0130-Add-Start
   LET l_sfb89 = ''
   LET l_sql = "SELECT sfb01 FROM sfb_file a,sfa_file ",
               " WHERE a.sfb01 = sfa01 ",
               "   AND (a.sfb86 = '",g_sfb.sfb01,"' OR a.sfb01 = '",g_sfb.sfb01,"')",
               "   AND EXISTS (SELECT * FROM sfb_file b  WHERE b.sfb01 = ? AND sfa03 = b.sfb05) ",
   #           "   AND a.sfb01 < ? ",
               " ORDER BY a.sfb01 DESC "
   DECLARE sfb_curs CURSOR FROM l_sql
   #MOD-DB0130-Add-End
   FOREACH p301_sfb89_cs INTO l_sfb01,l_sfb05

     #MOD-DB0130-Modify-Start
      OPEN sfb_curs USING l_sfb01
      FETCH sfb_curs INTO l_sfb89
      IF STATUS THEN
         CALL cl_err("OPEN sfb_curs:", STATUS, 1)
         CLOSE sfb_curs
         RETURN
      END IF
      CLOSE sfb_curs
     #LET l_sfb89 = ''
     #SELECT sfb01
     #  INTO l_sfb89
     #  FROM sfb_file
     # WHERE sfb86 = g_sfb.sfb01
     #   AND EXISTS (SELECT 1 FROM sfa_file
     #                WHERE sfa01 = sfb01
     #                  AND sfa03 = l_sfb05)
     #MOD-DB0130-Modify-End
       IF NOT cl_null(l_sfb89) THEN
          UPDATE sfb_file
             SET sfb89 = l_sfb89
             WHERE sfb01 = l_sfb01

          #add by wy20150601 子工单预计开工日期根据csfi001抓取 begin
          SELECT sfb02 INTO chk_sfb02 FROM sfb_file WHERE sfb01=g_sfb.sfb01 #检查母工单是什么工单
          SELECT sfb13 INTO l_sfb13   FROM sfb_file WHERE sfb01=l_sfb89  #查询上阶工单的预计开工日

          IF l_sfb01[1,3] MATCHES "[ZTJ]MO" THEN  #子工单的下阶料有皮料
          	 LET l_sql=" SELECT bmb03 FROM bmb_file WHERE bmb05 is null and bmb01=?"
 						 DECLARE bmb_curs CURSOR FROM l_sql
 						 OPEN bmb_curs USING l_sfb05
             FETCH bmb_curs INTO l_bmb03
             IF STATUS THEN
                CALL cl_err("OPEN bmb_curs:", STATUS, 1)
                CLOSE bmb_curs
                RETURN
             END IF
             SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=l_bmb03
             IF l_ima1003='Y' THEN
             	 LET l_sfb13=l_sfb13+g_tc_sfb.tc_sfb04
             	 UPDATE sfb_file SET sfb13=l_sfb13 WHERE sfb01=l_sfb01
             	 CLOSE bmb_curs
             END IF
             CLOSE bmb_curs
          ELSE
             SELECT ima1003 INTO l_ima1003 FROM ima_file,sfb_file WHERE ima01=sfb05 and sfb01=l_sfb01

             IF l_ima1003='Y' THEN #皮料
             	 IF l_sfb89[1,3] MATCHES "[ZTJ]MO"  THEN #如果上阶工单是ZMO\TMO\JMO,那么开工日=上阶 【ZMO\TMO\JMO 下阶工单都是皮料工单】
             	    SELECT sfb13 INTO l_sfb13 FROM sfb_file WHERE sfb01=l_sfb89
             	 ELSE
             	    IF  chk_sfb02='7' THEN  #委外工单
             	    	 LET l_sfb13=l_sfb13+g_tc_sfb.tc_sfb02
             	    END IF
             	    IF  chk_sfb02='1' THEN  #一般工单
             	      LET l_sfb13=l_sfb13+g_tc_sfb.tc_sfb03
             	    END IF
               END IF
             	 UPDATE sfb_file SET sfb13=l_sfb13 WHERE sfb01=l_sfb01
             END IF
          END IF
          #add by wy20150601 子工单预计开工日期根据csfi001抓取 end

       END IF
   END FOREACH
   #FUN-C30114
   IF g_totsuccess="N" THEN
      LET g_success="N"
   END IF

   UPDATE sfb_file SET sfb42=g_sfb.sfb42 WHERE sfb01=g_sfb.sfb01



END FUNCTION

FUNCTION p301_bom(p_level,p_key,p_key2,p_qty,p_date)  #FUN-550112
#No.FUN-A70034  --Begin
   DEFINE l_total      LIKE sfa_file.sfa05     #总用量
   DEFINE l_QPA        LIKE bmb_file.bmb06     #标准QPA
   DEFINE l_ActualQPA  LIKE bmb_file.bmb06     #实际QPA
#No.FUN-A70034  --End
   DEFINE p_level      LIKE type_file.num5,          #No.FUN-680121 SMALLINT
          l_cnt11      LIKE type_file.num5,          #No.FUN-680121 SMALLINT
          p_key        LIKE bma_file.bma01,          #主件料件編號
          p_key2	LIKE ima_file.ima910,        #FUN-550112
          p_qty       LIKE oeb_file.oeb13,          #No.FUN-680121 DEC(18,6)
          p_date      LIKE type_file.dat,           #No.FUN-680121 DATE
          l_ac,i      LIKE type_file.num5,          #No.FUN-680121 SMALLINT
          arrno       LIKE type_file.num5,          #No.FUN-680121 SMALLINT #BUFFER SIZE (可存筆數)
          l_ima54     LIKE ima_file.ima54,          #MOD-AC0077 add
          sr    DYNAMIC ARRAY OF RECORD       #每階存放資料
              bmb03 LIKE bmb_file.bmb03,    #元件料號
              bmb06 LIKE bmb_file.bmb06,    #FUN-560230
              bmb10 LIKE bmb_file.bmb10,    #發料單位
              bmb18 LIKE bmb_file.bmb18,    #投料時距
              bmb19 LIKE bmb_file.bmb19,    #工單展開選項  #No:9305
              ima55 LIKE ima_file.ima55,    #生產單位
              ima59 LIKE ima_file.ima59,
              ima60 LIKE ima_file.ima60,
              ima601 LIKE ima_file.ima601,  #No.FUN-840194
              ima61 LIKE ima_file.ima61,
              ima08 LIKE type_file.chr1,          #No.FUN-680121 VARCHAR(1)
              ima111 LIKE aab_file.aab02,         #No.FUN-680121 VARCHAR(05) #No.FUN-550067
              ima56  LIKE ima_file.ima56,    #FUN-710073 add  #No.MOD-810039 add ,
              ima561 LIKE ima_file.ima561,   #No.MOD-810039 add
   #No.FUN-A70034  --Begin
              bmb08  LIKE bmb_file.bmb08,
              bmb081 LIKE bmb_file.bmb081,
              bmb082 LIKE bmb_file.bmb082
   #No.FUN-A70034  --End

          END RECORD
   DEFINE l_ima910   LIKE ima_file.ima910         #FUN-550112
   DEFINE l_time     LIKE type_file.num5          #No.FUN-680121  SMALLINT#No.MOD-550189
   DEFINE l_double   LIKE type_file.num10         #No.MOD-810039 add
   DEFINE l_bmb08    LIKE bmb_file.bmb08          #No.MOD-830148 add
         ,l_bma05    LIKE bma_file.bma05          #CHI-8A0002 add
   DEFINE l_ima910a    DYNAMIC ARRAY OF LIKE ima_file.ima910          #No.FUN-8B0035
   DEFINE li_result    LIKE type_file.num5        #MOD-910092 add
   DEFINE l_day      LIKE type_file.num5          #MOD-9A0065
   DEFINE l_smy72    LIKE smy_file.smy72          #MOD-D10272 add
   DEFINE l_bmbud07  LIKE bmb_file.bmbud07
   DEFINE l_ima1003  LIKE ima_file.ima1003
   #DEFINE l_ima06    LIKE ima_file.ima06 #add by wy20150525
   DEFINE l_bdate    LIKE sfb_file.sfb81 #add by wy20150601

    IF p_level>20 THEN CALL cl_err('','mfg2733',1)
       CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
       EXIT PROGRAM
    END IF
    LET p_level = p_level + 1 IF p_level > g_sfb.sfb42 THEN RETURN END IF
    LET arrno = 600
    DECLARE p301_c1 CURSOR FOR
          SELECT bmb03,SUM(bmb06/bmb07),bmb10,bmb18,bmb19,ima55,  #No:9305
                 ima59,ima60,ima601,ima61,ima08,ima111,ima56,ima561,
                 SUM(bmb06/bmb07*bmb08)/SUM(bmb06/bmb07),#No.FUN-840194
                 SUM(bmb081),MAX(bmb082),SUM(bmbud07/bmb07)        #No.FUN-A70034
            FROM bmb_file, ima_file
           WHERE bmb01=p_key AND bmb03=ima01
             AND bmb29 =p_key2  #FUN-550112
             AND (bmb04<=g_sfb.sfb071)
             AND (bmb05> g_sfb.sfb071 OR bmb05 IS NULL)
             AND (ima08='X' OR ima08='M' OR ima08 ='S')
           GROUP BY bmb03,bmb09,bmb10,bmb18,bmb19,ima55,ima59,ima60,ima601,ima61,ima08,ima111,ima56,ima561
    LET l_ac = 1
    #No.FUN-A70034  --Begin
    #FOREACH p301_c1 INTO sr[l_ac].*,l_bmb08  # 先將BOM單身存入BUFFER  #No.MOD-830148 add bmb08
    FOREACH p301_c1 INTO sr[l_ac].*,l_bmbud07
    #No.FUN-A70034  --End
       IF STATUS THEN CALL cl_err('fore p301_cur:',STATUS,1) EXIT FOREACH END IF

       #No.FUN-A70034  --Begin
       #IF cl_null(l_bmb08) THEN LET l_bmb08 = 0 END IF
       #IF g_sma.sma71 MATCHES'[nN]' THEN LET l_bmb08 = 0 ENd IF
       IF cl_null(sr[l_ac].bmb08) THEN LET sr[l_ac].bmb08 = 0 END IF
       IF g_sma.sma71 MATCHES'[nN]' THEN LET sr[l_ac].bmb08 = 0 END IF
       #No.FUN-A70034  --Begin

       #No.FUN-A70034  --Begin
       #LET sr[l_ac].bmb06 = sr[l_ac].bmb06 * (1+l_bmb08/100)
       #LET sr[l_ac].bmb06=p301_unit_transfer(sr[l_ac].bmb03,
       #                       sr[l_ac].ima55,sr[l_ac].bmb10,sr[l_ac].bmb06)
       #LET sr[l_ac].bmb06=sr[l_ac].bmb06*p_qty
       #No.FUN-A70034  --End

       LET l_ima910a[l_ac]=''
       SELECT ima910 INTO l_ima910a[l_ac] FROM ima_file WHERE ima01=sr[l_ac].bmb03
       IF cl_null(l_ima910a[l_ac]) THEN LET l_ima910a[l_ac]=' ' END IF
       LET l_ac = l_ac + 1                    # 但BUFFER不宜太大
       IF l_ac > arrno THEN EXIT FOREACH END IF
    END FOREACH
    IF STATUS THEN CALL cl_err('fore p301_cur:',STATUS,1) END IF
    FOR i = 1 TO l_ac-1               # 讀BUFFER傳給REPORT
       message p_level,' ',sr[i].bmb03 clipped
       CALL ui.Interface.refresh()

       #No.FUN-A70034  --Begin
       CALL cralc_rate(p_key,sr[i].bmb03,p_qty,sr[i].bmb081,sr[i].bmb08,sr[i].bmb082,sr[i].bmb06,0)
            RETURNING l_total,l_QPA,l_ActualQPA
       LET sr[i].bmb06 = l_total
       LET sr[i].bmb06 = p301_unit_transfer(sr[i].bmb03,sr[i].ima55,sr[i].bmb10,sr[i].bmb06)
       #No.FUN-A70034  --End

       IF sr[i].ima08='M' THEN
          IF sr[i].bmb19 = '2' THEN      #No.MOD-5A0006 判斷下階料是否須開立工單
              SELECT bma05 INTO l_bma05 FROM bma_file
               WHERE bma01 = sr[i].bmb03 AND bma06 = p_key2
               IF sr[i].bmb19 <> '1' THEN
                IF cl_null(l_bma05) OR
                   (NOT cl_null(l_bma05) AND l_bma05 > g_sfb.sfb071) THEN
                   CALL cl_err(sr[i].bmb03,'abm-005',1)
                   RETURN
                END IF
               END IF
             LET g_i=g_i+1
             LET new[g_i].new_part= sr[i].bmb03
             SELECT ima02,ima021 INTO new[g_i].ima02_1,new[g_i].ima021_1
               FROM ima_file
              WHERE ima01=new[g_i].new_part
             #應考慮生產批量與最小生產數量
             LET new[g_i].new_qty = sr[i].bmb06

             IF sr[i].ima561 > 0 THEN #最少生產數量
                IF new[g_i].new_qty < sr[i].ima561 THEN
                   LET new[g_i].new_qty = sr[i].ima561
                END IF
             END IF

             IF NOT cl_null(sr[i].ima56) AND sr[i].ima56>0  THEN #生產單位批量
                LET l_double = (new[g_i].new_qty / sr[i].ima56) + 0.999999
                LET new[g_i].new_qty = l_double * sr[i].ima56
             END IF
             LET new[g_i].new_bmb19 = sr[i].bmb19   #No:9305
             LET l_time = 0

             ##add by wy20150525 逻辑移至预计开工日期前面 begin #
             LET new[g_i].new_no  = sr[i].ima111
             IF new[g_i].new_no IS NULL OR new[g_i].new_no = ' ' THEN    #No.MOD-7C0214 modify
                #add by lanhang 131017 begin  皮料工单单别抓取
                SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=new[g_i].new_part
                 IF l_ima1003 ='Y' THEN
                   SELECT smyslip INTO new[g_i].new_no FROM smy_file WHERE smysys='asf' AND smykind='1' AND smy72='P' AND rownum=1
                ELSE
                #add by lanhang 131017 end
                   LET new[g_i].new_no = s_get_doc_no(g_sfb.sfb01)     #No.FUN-550067
                END IF   #add by lanhang 131017
             END IF
             ##add by wy20150525 逻辑移至预计开工日期前面 end

             ##add by wy20150525 子工单预计开工日期根据csfi001抓取 begin
             #SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=new[g_i].new_part
             #IF l_ima1003='Y' and g_plant='SJLTEST' THEN #皮料
             #	 SELECT sfb13 INTO p_date FROM sfb_file WHERE sfb01
             #	 IF new[g_i].new_no MATCHES "[ZTJ]MO" THEN  #
             #	 	  LET p_date=p_date+g_tc_sfb.tc_sfb04
             #	 	  LET sr[i].bmb18=0
             #	 ELSE
             #	    IF  g_sfb.sfb02='7' THEN  #委外工单
             #	    	  LET p_date=p_date+g_tc_sfb.tc_sfb02
             #	    	  LET sr[i].bmb18=0
             #	    END IF
             #	    IF  g_sfb.sfb02='1' THEN  #一般工单
             #	    	  LET p_date=p_date+g_tc_sfb.tc_sfb03
             #	    	  LET sr[i].bmb18=0
             #	    END IF
             #	 END IF
             #END IF
             ##add by wy20150525 子工单预计开工日期根据csfi001抓取 end

             LET new[g_i].e_date = p_date - sr[i].bmb18

             IF sr[i].bmb18 <= 0 THEN
                SELECT COUNT(*) INTO l_time FROM sme_file
                WHERE sme01 BETWEEN p_date AND new[g_i].e_date AND sme02 = 'N'
             ELSE
                SELECT COUNT(*) INTO l_time FROM sme_file
                WHERE sme01 BETWEEN new[g_i].e_date AND p_date AND sme02 = 'N'
             END IF
             LET new[g_i].e_date = new[g_i].e_date - l_time
             LET l_time = 0
                  LET new[g_i].b_date = new[g_i].e_date
                  LET l_day = (sr[i].ima59+sr[i].ima60/sr[i].ima601*sr[i].bmb06+sr[i].ima61) #MOD-9A0065

                  WHILE TRUE
                      CALL s_daywk(new[g_i].b_date) RETURNING li_result
                      CASE
                        WHEN li_result = 0  #0:非工作日
                          LET new[g_i].b_date = new[g_i].b_date + 1   #MOD-9A0065 -變+
                          CONTINUE WHILE
                        WHEN li_result = 1  #1:工作日
                          EXIT WHILE
                        WHEN li_result = 2  #2:無設定
                          CALL cl_err(new[g_i].b_date,'mfg3153',0)   #MOD-9A0065
                          EXIT WHILE
                        OTHERWISE EXIT WHILE
                      END CASE
                  END WHILE
                  CALL s_aday(new[g_i].b_date,-1,l_day)    #MOD-9A0065
                       RETURNING new[g_i].b_date   #MOD-9A0065

                  #MOD-C50055 add begin---------------------
                  IF new[g_i].b_date >new[g_i].e_date THEN
                     LET new[g_i].e_date = new[g_i].b_date
                  END IF
                  #MOD-C50055 add end-----------------------

                  ##逻辑移至预计开工日期前面 mark by wy20150525 begin #
                  #LET new[g_i].new_no  = sr[i].ima111
                  #IF new[g_i].new_no IS NULL OR new[g_i].new_no = ' ' THEN    #No.MOD-7C0214 modify
                  #   #add by lanhang 131017 begin  皮料工单单别抓取
                  #   SELECT ima1003 INTO l_ima1003 FROM ima_file WHERE ima01=new[g_i].new_part
                  #   IF l_ima1003 ='Y' THEN
                  #      SELECT smyslip INTO new[g_i].new_no FROM smy_file WHERE smysys='asf' AND smykind='1' AND smy72='P' AND rownum=1
                  #   ELSE
                  #   #add by lanhang 131017 end
                  #      LET new[g_i].new_no = s_get_doc_no(g_sfb.sfb01)     #No.FUN-550067
                  #   END IF   #add by lanhang 131017
                  #END IF
                  ##逻辑移至预计开工日期前面 mark by wy20150525 begin #

                  #MOD-D10272 add begin--------------------------------------
                  SELECT smy72 INTO l_smy72 FROM smy_file WHERE smyslip = new[g_i].new_no
                  IF cl_null(l_smy72) THEN
                     LET l_smy72 = 1
                  ELSE
                     IF l_smy72 NOT MATCHES '[17P]' THEN
                        LET l_smy72 = 1
                     ELSE
                        IF l_smy72='P' THEN
                           LET l_smy72=1
                        END IF
                     END IF
                  END IF
                  #MOD-D10272 add end----------------------------------------
                 #LET new[g_i].wo_type = 1       #MOD-D10272 mark
                  LET new[g_i].wo_type = l_smy72 #MOD-D10272 add
                  CALL p301_bom(p_level,sr[i].bmb03,l_ima910a[i],new[g_i].new_qty,new[g_i].b_date)  #FUN-8B0035
   #--No.MOD-5A0006 若不須開立工單則繼續往下搜尋下階料看是否須開立工單
            ELSE
               IF sr[i].bmb19 != '1' THEN
                  CALL p301_bom(p_level,sr[i].bmb03,l_ima910a[i],sr[i].bmb06,p_date)  #FUN-8B0035
               END IF
            END IF
       END IF
       #---------母工單產生子工單,遇來源碼為'S',應產生委外工單
       IF sr[i].ima08='S' THEN
          IF sr[i].bmb19 ='2' THEN  #No.MOD-5A0006
             let l_cnt11 = 0
             LET l_ima910=g_sfb.sfb95
             IF cl_null(l_ima910) THEN LET l_ima910=' ' END IF
             #---檢查是否有下階料件----------
              select count(*) into l_cnt11 from bmb_file,bma_file
              where bmb01 = bma01
                and bma01 =sr[i].bmb03
                AND bma06 = l_ima910  #FUN-550112
                AND bma06 = bmb29     #FUN-550112
                AND bmaacti = 'Y'     #CHI-740001
              if l_cnt11 = 0 or cl_null(l_cnt11) then continue for end if
              LET g_i=g_i+1
              LET new[g_i].new_part= sr[i].bmb03
              SELECT ima02,ima021 INTO new[g_i].ima02_1,new[g_i].ima021_1
                FROM ima_file
               WHERE ima01=new[g_i].new_part
              LET new[g_i].new_qty = sr[i].bmb06
             #------------------No:MOD-A10157 add
              IF sr[i].ima561 > 0 THEN #最少生產數量
                 IF new[g_i].new_qty < sr[i].ima561 THEN
                    LET new[g_i].new_qty = sr[i].ima561
                 END IF
              END IF

              IF NOT cl_null(sr[i].ima56) AND sr[i].ima56>0  THEN #生產單位批量
                 LET l_double = (new[g_i].new_qty / sr[i].ima56) + 0.999999
                 LET new[g_i].new_qty = l_double * sr[i].ima56
              END IF
             #------------------No:MOD-A10157 end
              LET new[g_i].e_date = p_date + sr[i].bmb18
              LET new[g_i].b_date = new[g_i].e_date
              LET l_day = (sr[i].ima59+sr[i].ima60/sr[i].ima601*sr[i].bmb06+sr[i].ima61) #MOD-9A0065
              WHILE TRUE
                  CALL s_daywk(new[g_i].b_date) RETURNING li_result
                  CASE
                    WHEN li_result = 0  #0:非工作日
                      LET new[g_i].b_date = new[g_i].b_date + 1
                      CONTINUE WHILE
                    WHEN li_result = 1  #1:工作日
                      EXIT WHILE
                    WHEN li_result = 2  #2:無設定
                      CALL cl_err(new[g_i].b_date,'mfg3153',0)
                      EXIT WHILE
                    OTHERWISE EXIT WHILE
                  END CASE
              END WHILE
              CALL s_aday(new[g_i].b_date,-1,l_day)
                   RETURNING new[g_i].b_date
              #MOD-C50055 add begin---------------------
              IF new[g_i].b_date >new[g_i].e_date THEN
                 LET new[g_i].e_date = new[g_i].b_date
              END IF
              #MOD-C50055 add end-----------------------
              LET new[g_i].new_no  = sr[i].ima111
              IF new[g_i].new_no IS NULL OR new[g_i].new_no = ' ' THEN   #No.MOD-7C0214 modify
                 LET new[g_i].new_no = s_get_doc_no(g_sfb.sfb01)     #No.FUN-550067
              END IF
              #MOD-D10272 add begin--------------------------------------
              SELECT smy72 INTO l_smy72 FROM smy_file WHERE smyslip = new[g_i].new_no
              IF cl_null(l_smy72) THEN
                 LET l_smy72 = 7
              ELSE
                 IF l_smy72 NOT MATCHES '[17P]' THEN
                    LET l_smy72 = 7
                 ELSE
                    IF l_smy72 = 'P' THEN
                       LET l_smy72=7
                    END IF
                 END IF
              END IF
              #MOD-D10272 add end----------------------------------------
             #LET new[g_i].wo_type = 7        #MOD-D10272 mark
              LET new[g_i].wo_type = l_smy72  #MOD-D10272 add
              LET new[g_i].ven_no  = l_ima54           #MOD-AC0077 add
              LET new[g_i].new_bmb19 = sr[i].bmb19   #MOD-B10021 add
              CALL p301_bom(p_level,sr[i].bmb03,l_ima910a[i],new[g_i].new_qty,new[g_i].b_date)  #FUN-8B0035
          ELSE
             IF sr[i].bmb19 != '1' THEN
                CALL p301_bom(p_level,sr[i].bmb03,l_ima910a[i],sr[i].bmb06,p_date)#FUN-8B0035
             END IF
          END IF

       END IF
      #MOD-BC0108 -- begin --
       IF sr[i].ima08='X' THEN
          CALL p301_bom(p_level,sr[i].bmb03,' ',sr[i].bmb06,p_date)
       END IF
      #MOD-BC0108 -- end --
    END FOR
    message ''
END FUNCTION

REPORT p301_rep(l_sfb)
  DEFINE  l_sfb	RECORD LIKE sfb_file.*

  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin
         PAGE LENGTH g_page_line   #No.MOD-580242

  ORDER BY l_sfb.sfb01

  FORMAT
   PAGE HEADER
      PRINT COLUMN ((g_len-FGL_WIDTH(g_company CLIPPED))/2)+1,g_company CLIPPED
      LET g_pageno = g_pageno + 1
      LET pageno_total = PAGENO USING '<<<',"/pageno"
      PRINT g_head CLIPPED, pageno_total
      PRINT COLUMN ((g_len-FGL_WIDTH(g_x[1]))/2)+1,g_x[1]
      PRINT ' '
      LET g_pageno = g_pageno + 1
      PRINT g_x[11] CLIPPED,g_sfb.sfb01
      PRINT
      PRINT g_dash
      PRINT g_x[31],g_x[32],g_x[33],g_x[34],g_x[35]
      PRINT g_dash1

    ON EVERY ROW
      PRINT COLUMN g_c[31],l_sfb.sfb05,
            COLUMN g_c[32],l_sfb.sfb08 USING '-------&',
            COLUMN g_c[33],l_sfb.sfb13,
            COLUMN g_c[34],l_sfb.sfb15,
            COLUMN g_c[35],l_sfb.sfb01

    PAGE TRAILER
      PRINT g_dash
      PRINT '(asfp301)'
      SKIP 1 LINE
      PRINT g_x[5] CLIPPED,g_x[6] CLIPPED
END REPORT

FUNCTION p301_unit_transfer(p_bmb03,p_ima55,p_bmb10,p_qty)
DEFINE p_bmb03 LIKE bmb_file.bmb03,
       p_ima55 LIKE ima_file.ima55,
       p_bmb10 LIKE bmb_file.bmb10,
       p_qty       LIKE bmb_file.bmb06,
       l_ret_qty   LIKE bmb_file.bmb06

       IF p_ima55=p_bmb10 THEN
          RETURN p_qty
       END IF

       SELECT p_qty*(smd04/smd06) INTO l_ret_qty FROM smd_file
        WHERE smd01=p_bmb03
          AND smd02=p_ima55
          AND smd03=p_bmb10
       IF NOT STATUS THEN RETURN l_ret_qty END IF

       SELECT p_qty*(smd06/smd04) INTO l_ret_qty FROM smd_file
        WHERE smd01=p_bmb03
          AND smd02=p_bmb10
          AND smd03=p_ima55
       IF NOT STATUS THEN RETURN l_ret_qty END IF

       SELECT p_qty*(smc03/smc04) INTO l_ret_qty FROM smc_file
        WHERE smc01=p_ima55
          AND smc02=p_bmb10
          AND smcacti='Y'   #NO:4757
       IF NOT STATUS THEN RETURN l_ret_qty END IF

       SELECT p_qty*(smc04/smc03) INTO l_ret_qty FROM smc_file
        WHERE smc02=p_ima55
          AND smc01=p_bmb10
          AND smcacti='Y'   #NO:4757
       IF NOT STATUS THEN RETURN l_ret_qty END IF

       RETURN p_qty

END FUNCTION
#No.FUN-9C0072 精簡程式碼
