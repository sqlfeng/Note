# Prog. Version..: '5.30.06-13.04.22(00010)'     #
#
# Pattern name...: gapi140.4gl
# Descriptions...: 入庫/退貨單發票資料維護作業
# Date & Author..: 05/04/08 By ice
# Modify ........: No.FUN-580006 05/08/17 By ice 有稅控時,發票代碼Required
# Modify ........: No.FUN-580083 06/03/31 By Alexstar 新增資料多語言顯示功能
# Modify.........: No.MOD-640405 06/04/14 By Smapmin 將匯率欄位移到單頭
# Modify.........: No.MOD-650015 06/05/05 By rainy 取消輸入時的"預設上筆"功能monster代
# Modify.........: No.FUN-660071 06/06/13 By Carrier cl_err --> cl_err3
# Modify.........: No.FUN-690009 06/09/04 By Dxfwo  欄位類型定義
# Modify.........: No.FUN-690024 06/09/19 By jamie 判斷pmcacti
# Modify.........: No.FUN-690025 06/09/19 By jamie 所有判斷狀況碼pmc05改判斷有效碼pmcacti
# Modify.........: No.FUN-680029 06/09/19 By wujie 修正informix下b_fill報錯
# Modify.........: No.MOD-690135 06/09/26 By Tracy 單頭欄位循環錄入
# Modify.........: No.CHI-6A0004 06/10/23 By hongmei g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.FUN-6A0097 06/11/06 By hongmei l_time轉g_time
# Modify.........: No.FUN-6A0092 06/11/14 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No.TQC-6C0126 06/12/20 By Smapmin 暫估的數量也應該呈現出來
# Modify.........: No.TQC-6B0105 07/03/08 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.TQC-730030 07/03/08 By Rayven 匯率抓當月匯率，增加一個Action(拋轉帳款)
# Modify.........: No.MOD-740008 07/04/04 By Rayven 原幣稅額欄位微調，本幣稅額沒改動
# Modify.........: No.TQC-740342 07/04/27 By Ray 當使用計價單位時單身帶出的應該是計價數量而非庫存單位的數量
# Modify.........: No.TQC-750041 07/05/16 By sherry 指定筆彈出的輸入框格式有誤
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.MOD-750109 07/05/23 By Smapmin 取消項次開窗
# Modify.........: No.TQC-760012 07/06/04 By Rayven AFTER FIELD rvw06f時不要重算原幣金額
# Modify.........: No.TQC-760013 07/06/07 By Rayven 類型欄位增加"兩者"同時可選入庫和退貨單號
# Modify.........: No.TQC-770051 07/07/12 By Rayven 錄入退貨發票，單身輸入退貨單，數量欄位不通過，報錯信息不准確
# Modify.........: No.MOD-770055 07/07/13 By Rayven 新增時單身開窗q_rvv4的p_no4參數傳'1'
# Modify.........: No.TQC-790140 07/09/26 By wujie  單身選擇的是倉退單時數量應該顯示為負數
# Modify.........: No.MOD-7B0150 07/11/15 By chenl  1.根據發票金額調用不同程序，若金額大于等于0則調用aapp110,否則調用aapp111
# Modify.........:                                  2.修正查詢后，類型顯示錯誤。
# Modify.........: No.TQC-7B0114 07/11/21 By Rayven 1.類型為2兩者，維護無收貨倉退單的發票報錯：更新收貨單失敗
# Modify.........: No.TQC-7B0126 07/11/22 By chenl  1.修正TQC-790140針對數量正負的錯誤。
#                                                   3.錄入時,類型為2兩者時,開窗選取退貨單號的數量默認為正數
# Modify.........: No.TQC-7B0131 07/11/23 By chenl  放寬單據類型控制，以免卡住后不能錄入其他類型單據。
# Modify.........: No.TQC-7B0164 07/11/30 By chenl  1.修正bug,錄入發票單身選擇無來源退貨單和項次后報錯“無匯率資料”
# Modify.........:                                  2.修正bug,錄入發票單身時，錄入退貨單號但沒有項次也可以保存，但保存后查詢不到此筆資料
# Modify.........:                                  3.增加對數量的控管。
# Modify.........: No.TQC-7C0016 07/12/05 By chenl  修正未錄入項次保存的bug,已將rvw09在per中設為不可為空，故程序中無需再作判斷。
# Modify.........: No.MOD-810005 08/01/08 By Smapmin 匯率, 未依aaps100之應付匯率使用類別取
# Modify.........: No.TQC-810054 08/01/22 by chenl  若采用"入庫單身查詢"按鈕，插入的倉退單數量為負數，單價為正，金額為負.
# Modify.........: No.TQC-840062 08/04/25 by judy 改s_curr()->s_curr3()
# Modify.........: NO.MOD-860078 08/06/10 by Yiting ON IDLE處理
# Modify.........: No.TQC-840063 08/04/25 by lumx  調整單身原幣稅額，本幣稅額的對應計算方式
# Modify.........: No.MOD-870301 08/08/14 By wujie 單身數量判斷時，漏了rvu00=2的情況，應該將2,3情況合并
# Modify.........: No.MOD-870285 08/08/15 By Sarah 有倉退是只折讓金額而不退數量的,所以應調整為數量(rvw10)允許為0但金額不可為0
# Modify.........: No.MOD-880206 08/08/26 By lumx  對取出的已開票的數量取絕對值
# Modify.........: No.MOD-890008 08/09/01 By Sarah 當單身入庫/退貨單號開窗選擇多筆,帶出來的資料是錯的
# Modify.........: No.MOD-860196 08/06/23 By chenl 單身匯率將直接參照單頭匯率
# Modify.........: No.TQC-8A0020 08/10/15 By Sarah 稅別開窗應不分類別,統一抓進項稅別來開窗
# Modify.........: No.MOD-8C0032 08/12/04 By chenyu 采購單單頭單價含稅時，未稅金額=含稅金額/稅率。但是這里的原幣金額確又用單價*數量。這樣就有尾差
# Modify.........: No.MOD-8B0103 08/12/25 By wujie 修改MOD-870285的一個判斷錯誤
# Modify.........: No.MOD-910007 09/01/04 By chenyu 調整MOD-880206中的abs(SUM(apb09))-->SUM(abs(apb09))
# Modify.........: No.MOD-910042 09/01/06 By chenyu 刪除時，發票號碼要還原成和原來一樣的NULL
# Modify.........: No.MOD-910073 09/01/09 By Nicola 數量異動與舊值同時，不會重新計算未稅金額
# Modify.........: No.TQC-920081 09/02/24 By chenl  對單身直接錄入入庫單和倉退單進行判斷，單據是否已經審核。
# Modify.........: No.MOD-920384 09/02/27 By chenyu 帶出來的數量為0，金額也應該是0
# Modify.........: No.MOD-940125 09/04/09 By lilingyu 稅額未正確取位
# Modify.........: No.FUN-940135 09/04/29 By Carrier 去掉顏色的ATTRIBUTE設置
# Modify.........: No.MOD-940412 09/04/30 By chenl   改善數量和原幣稅前單價異動后，對金額的重算。以及開窗選擇后，金額的重算。
# Modify.........: No.FUN-940083 09/06/02 By douzh VMI新增相關流程
# Modify.........: No.MOD-960197 09/06/17 By Carrier 單頭修改時,重新取匯率
# Modify.........: No.MOD-980034 09/08/05 By mike FUNCTION i140_ins_rvw(),針對g_type != '1'也要能產生資料,
# Modify.........: No.FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.CHI-980038 09/08/24 By Sarah 單價含稅時,以(含稅單價*數量)/(1+稅率/100)=未稅金額
#                                                  單價未稅時,以(未稅單價*數量)*(1+稅率/100)=含稅金額
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.MOD-990163 09/09/16 By mike 若為樣品時,金額部份(rvw17,rvw05,rvw05f,rvw06,rvw06f)應帶0
# Modify.........: No.MOD-990204 09/10/14 By Carrier 若為台灣地區功能時,不執行此作業
# Modify.........: No.TQC-9A0091 09/10/15 By liuxqa 輸入稅種后，報錯不可通過。
# Modify.........: No.FUN-9B0130 09/11/25 By lutingting去掉rvwplant單身增加rvw99,單身入庫單號根據rvw99過濾可以選擇同一法人下得入庫單
# Modify.........: No.FUN-9C0001 09/12/06 By lutingting單身修改時ON ROW CHANGE得UPDATE語句加上rvw99
# Modify.........: No.FUN-9C0041 09/12/15 By lutingting單身根據來源營運中心抓取資料時應該去實體DB抓取資料
# Modify.........: No:MOD-9C0061 09/12/25 By sabrina 數量為0 時，rvw05f金額直接用金額去除以稅率
# Modify.........: No.FUN-9C0072 10/01/09 By vealxu 精簡程式碼
# Modify.........: No:MOD-A20009 10/02/02 By wujie   与发票日期不同年月的入库/仓退单必须在当月有暂估才可跨月开票
# Modify.........: No.FUN-A20006 10/02/04 By lutingting i140_rvw10()中加入rvw99得條件,避免不同DB得入庫單/退貨單單號相同從而導致數量不對得情況
# Modify.........: No:MOD-A20066 10/02/09 By Sarah 刪除發票前,檢查該發票是否存在折讓單(aapt210)裡,若存在則不可刪除
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No.MOD-A30163 10/03/23 by sabrina 進入i140_sel_rvb cursor時，若t_rvw11為null時，改抓單頭的rvw11
# Modify.........: No.MOD-A40045 10/04/09 by Dido 增加暫估倉退條件
# Modify.........: No.FUN-A50102 10/06/22 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No.FUN-A60056 10/07/09 By lutingting GP5.2財務串前段問題整批調整
# Modify.........: No.MOD-A70133 10/07/16 By wujie  单价不分条件都应该抓取rvv的资料
# Modify.........: No:MOD-A80052 10/08/09 By Dido 若為運輸發票(gec05='T')時,稅額與未稅金額邏輯調整
# Modify.........: No:MOD-AA0093 10/10/15 By Dido 當稅率改變時,單身未稅金額有重算相對未稅單價也需重算
# Modify.........: No.TQC-AC0009 10/11/01 By yinhy 新增時，更改"廠商編號"，"稅種"及"幣種"沒有跟著進行相應默認值變更
# Modify.........: No:MOD-AC0024 11/01/06 By sabrina 未稅金額與採購單不同
# Modify.........: No:FUN-B30211 11/04/01 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No:MOD-B50003 11/05/03 By wujie   查询加入rvv06
# Modify.........: No:MOD-B50016 11/05/04 By Sarah rvw08開窗時,也應做MOD-990163的處理
# Modify.........: No:FUN-B50019 11/05/05 By elva 支持无采购无收货单的入库单产生应付
# Modify.........: No.FUN-B50065 11/05/13 BY huangrh BUG修改，刪除時提取資料報400錯誤
# Modify.........: No:MOD-B70073 11/07/11 By destiny 修正税前单价税前金额栏位在修改后原币税额本币税额取值方式
# Modify.........: No:MOD-B70210 11/07/25 By Polly 修正新增進入單身時，點選右方的按鈕入庫單身檔查詢，帶出的單身資料來源營運中心為NULL
# Modify.........: No.MOD-BA0066 11/10/10 By yinhy 發票金額為0時不可拋轉賬款
# Modify.........: No.MOD-BC0098 11/12/12 By Polly 調整"入庫單身資料查詢"撈入的資料錯誤
# Modify.........: No.MOD-BC0104 11/12/12 By yinhy 原幣經過lamt調整後，本幣需按匯率再調整一次
# Modify.........: No.MOD-C20225 12/02/28 By yinhy 更改幣種時帶出匯率
# Modify.........: No.TQC-BB0163 12/03/19 By yinhy 單身入庫單需過濾經營方式必須為經銷類型才可以錄入發票
# Modify.........: No.MOD-C40103 12/04/20 By yinhy 單頭金額應依照aooi050設置做截位
# Modify.........: No.MOD-C50188 12/05/24 By yinhy rvw99默認為當前登陸的營運中心
# Modify.........: No.MOD-C60098 12/06/12 By Polly 調整單身action[入庫單身檔查詢]抓取rvw10和單身抓取條件一致
# Modify.........: No.MOD-C60217 12/06/26 By wujie VMI仓的入库单不可请款
# Modify.........: No.FUN-C80027 12/08/07 By minpp 增加原币含税，本币含税，原币未税合计，本币未税合计
# Modify.........: No.CHI-C80054 12/09/10 By yinhy 更改原幣稅前金額后，單價也應更新
# Modify.........: No.CHI-C80003 12/09/26 By wangwei 價格折讓類型的已衝過暫估資料不應被挑選
# Modify.........: No.MOD-CB0246 12/11/26 By yinhy s_curr3傳參錯誤
# Modify.........: No.MOD-CA0222 12/10/31 By yinhy 單身原幣稅額、原幣含稅金額等截位錯誤
# Modify.........: No.MOD-CB0281 12/12/05 By Polly 單價取位調整參考azi03
# Modify.........: No.FUN-CB0080 12/12/26 By wangrr 增加"資料清單"頁簽
# Modify.........: No.FUN-CB0048 13/01/09 By zhangweib 增加賬款編號(rvw18)、增加ACTION"賬款查詢" ,根據賬款編號rvw18抓取apa00,分別串aapt110/aapt210
# Modify.........: No.FUN-CB0053 13/01/09 By zhangweib 增加錄入日期(rvw19)記錄單據錄入的時間
# Modify.........: No.CHI-CC0038 12/12/05 By yinhy 付款方式不同show警告
# Modify.........: No.FUN-D10064 13/03/08 By minpp 增加【狀態】頁簽
# Modify.........: No.CHI-B30082 13/03/08 By apo apm-241把發票代碼rvw07加入檢查發票重複
# Modify.........: No.yinhy130308 13/03/08 By yinhy 註釋MOD-CA0222
# Modify.........: No.MOD-C90185 13/03/19 By Polly 增加控卡，單身入庫單號不可為多角入庫單
# Modify.........: No:FUN-D30032 13/04/03 By xumm 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No.FUN-D70021 13/08/26 By yangtt MISC料件不判斷跨月是否立暫估
# Modify.........: No.MOD-DC0088 13/12/12 By yinhy 賬款編號rvw18不為空，不可刪除

DATABASE ds

GLOBALS "../../config/top.global"

DEFINE
   g_head_1      RECORD
                 rvw01      LIKE rvw_file.rvw01,         #發票號碼
                 rvw07      LIKE rvw_file.rvw07,         #發票類型
                 rvw02      LIKE rvw_file.rvw02,         #發票日期
                 rvw19      LIKE rvw_file.rvw19,         #錄入日期    #No.FUN-CB0053   Add
                 rvw03      LIKE rvw_file.rvw03,         #稅別
                 rvw04      LIKE rvw_file.rvw04,         #稅率
                 rvw11      LIKE rvw_file.rvw11,         #幣種
                 rvw12      LIKE rvw_file.rvw12,         #匯率   #MOD-640405
                 rvv06      LIKE rvv_file.rvv06,         #供應廠商
                 pmc03      LIKE pmc_file.pmc03,         #簡稱
                 rvw05f_s   LIKE rvw_file.rvw05f,        #未稅金額
                 rvw06f_s   LIKE rvw_file.rvw06f,        #稅額
                 rvw05f_sum LIKE rvw_file.rvw05f,        #未稅金額
                 rvw06f_sum LIKE rvw_file.rvw06f,        #稅額
               #FUN-C80027---ADD---STR
                 sum3       LIKE rvw_file.rvw05f,        #原币含税金额合计
                 rvw05_sum  LIKE rvw_file.rvw05,         #未稅金額
                 rvw06_sum  LIKE rvw_file.rvw06,         #稅額
                 sum4       LIKE rvw_file.rvw05          #本币含税金额合计
               #FUN-C80027---ADD---END
                ,rvw18      LIKE rvw_file.rvw18          #帳款編號   No.FUN-CB0048   Add
                 #FUN-D10064--add--str--
                ,rvwacti    LIKE rvw_file.rvwacti,
                 rvwuser    LIKE rvw_file.rvwuser,
                 rvwgrup    LIKE rvw_file.rvwgrup,
                 rvwmodu    LIKE rvw_file.rvwmodu,
                 rvwdate    LIKE rvw_file.rvwdate,
                 rvworiu    LIKE rvw_file.rvworiu,
                 rvworig    LIKE rvw_file.rvworig
                #FUN-D10064--add--end
                 END RECORD,
   g_head_t      RECORD
                 rvw01      LIKE rvw_file.rvw01,         #發票號碼
                 rvw07      LIKE rvw_file.rvw07,         #發票類型
                 rvw02      LIKE rvw_file.rvw02,         #發票日期
                 rvw19      LIKE rvw_file.rvw19,         #錄入日期    #No.FUN-CB0053   Add
                 rvw03      LIKE rvw_file.rvw03,         #稅別
                 rvw04      LIKE rvw_file.rvw04,         #稅率
                 rvw11      LIKE rvw_file.rvw11,         #幣種
                 rvw12      LIKE rvw_file.rvw12,         #匯率   #MOD-640405
                 rvv06      LIKE rvv_file.rvv06,         #供應廠商
                 pmc03      LIKE pmc_file.pmc03,
                 rvw05f_s   LIKE rvw_file.rvw05f,
                 rvw06f_s   LIKE rvw_file.rvw06f,
                 rvw05f_sum LIKE rvw_file.rvw05f,
                 rvw06f_sum LIKE rvw_file.rvw06f,
               #FUN-C80027---ADD---STR
                 sum3       LIKE rvw_file.rvw05f,        #原币含税金额合计
                 rvw05_sum  LIKE rvw_file.rvw05,         #未稅金額
                 rvw06_sum  LIKE rvw_file.rvw06,         #稅額
                 sum4       LIKE rvw_file.rvw05          #本币含税金额合计
               #FUN-C80027---ADD---END
                ,rvw18      LIKE rvw_file.rvw18          #帳款編號   No.FUN-CB0048   Add
                 #FUN-D10064--add--str--
                ,rvwacti    LIKE rvw_file.rvwacti,
                 rvwuser    LIKE rvw_file.rvwuser,
                 rvwgrup    LIKE rvw_file.rvwgrup,
                 rvwmodu    LIKE rvw_file.rvwmodu,
                 rvwdate    LIKE rvw_file.rvwdate,
                 rvworiu    LIKE rvw_file.rvworiu,
                 rvworig    LIKE rvw_file.rvworig
                #FUN-D10064--add--end
                 END RECORD,
   g_rvw01_t     LIKE rvw_file.rvw01,                    #OWID
   g_type        LIKE type_file.chr1,         #NO FUN-690009 VARCHAR(01)   #類型
   g_rvw_arrno   LIKE type_file.num5,         #NO FUN-690009 SMALLINT   #程式變數的個數
   g_rvw         DYNAMIC ARRAY OF RECORD                 #程式變數(Program Variables)
                 rvw99      LIKE rvw_file.rvw99,         #來源營運中心   #FUN-9B0130
                 rvw08      LIKE rvw_file.rvw08,         #收貨單號/倉退單號
                 rvw09      LIKE rvw_file.rvw09,         #項次
                 rvu08      LIKE rvu_file.rvu08,         #采购性质  #add by dengsy151231
                 ima01      LIKE ima_file.ima01,         #料件編號
                 ima02      LIKE ima_file.ima02,         #品名
                 rvv09      LIKE rvv_file.rvv09,         #收貨日期
                 rvw10      LIKE rvw_file.rvw10,         #數量
                 rvw17      LIKE rvw_file.rvw17,         #原幣未稅單價
                 rvw05f     LIKE rvw_file.rvw05f,
                 rvw06f     LIKE rvw_file.rvw06f,
                 sum1       LIKE rvw_file.rvw05f,         #FUN-C80027 #原币含税金额
                 rvw05      LIKE rvw_file.rvw05,
                 rvw06      LIKE rvw_file.rvw06,
                 sum2       LIKE rvw_file.rvw05           #FUN-C80027 #本币含税金额
                 ,rvvud02   LIKE rvv_file.rvvud02         #add by zhaoxiangb 160324
                 ,pja02     LIKE pja_file.pja02           #add by zhaoxiangb 160324
                 END RECORD,
   g_rvw_t       RECORD                                  #程式變數(Program Variables)
                 rvw99      LIKE rvw_file.rvw99,         #来源营运中心   #FUN-9B0130
                 rvw08      LIKE rvw_file.rvw08,         #收貨單號/倉退單號
                 rvw09      LIKE rvw_file.rvw09,         #項次
                 rvu08      LIKE rvu_file.rvu08,         #采购性质  #add by dengsy151231
                 ima01      LIKE ima_file.ima01,
                 ima02      LIKE ima_file.ima02,
                 rvv09      LIKE rvv_file.rvv09,         #收貨日期
                 rvw10      LIKE rvw_file.rvw10,
                 rvw17      LIKE rvw_file.rvw17,
                 rvw05f     LIKE rvw_file.rvw05f,
                 rvw06f     LIKE rvw_file.rvw06f,
                 sum1       LIKE rvw_file.rvw05f,         #FUN-C80027
                 rvw05      LIKE rvw_file.rvw05,
                 rvw06      LIKE rvw_file.rvw06,
                 sum2       LIKE rvw_file.rvw05           #FUN-C80027
                 ,rvvud02   LIKE rvv_file.rvvud02         #add by zhaoxiangb 160324
                 ,pja02     LIKE pja_file.pja02           #add by zhaoxiangb 160324
                 END RECORD,
       g_wc,g_wc2,g_sql     STRING,                  #No.FUN-580092 HCN
       g_rvw10              LIKE rvw_file.rvw10,     #記錄未請款入庫數量
       g_rec_b              LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #單身筆數
       l_ac,l_sl            LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #目前處理的ARRAY CNT
       g_gec05              LIKE gec_file.gec05,     #發票聯數
       g_gec07              LIKE gec_file.gec07,     #含稅否    #CHI-980038 add
       g_rvw05f             LIKE rvw_file.rvw05f,    #MOD-A80052
       g_flag               LIKE type_file.chr1,     #MOD-A80052
       g_rvv38t             LIKE rvv_file.rvv38t,    #含稅單價  #CHI-980038 add
       g_rvv39              LIKE rvv_file.rvv39,     #MOD-9C0061 add
       g_rvv39t             LIKE rvv_file.rvv39t     #MOD-9C0061 add
DEFINE p_row,p_col          LIKE type_file.num5      #NO FUN-690009 SMALLINT
DEFINE g_forupd_sql         STRING                   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5      #NO FUN-690009 SMALLINT

DEFINE g_cmd                LIKE type_file.chr1000   #NO FUN-690009 VARCHAR(100)
DEFINE g_chr                LIKE type_file.chr1      #NO FUN-690009 VARCHAR(1)
DEFINE g_cnt                LIKE type_file.num10     #NO FUN-690009 INTEGER
DEFINE g_i                  LIKE type_file.num5      #NO FUN-690009 SMALLINT     #count/index for any purpose
DEFINE g_msg                LIKE ze_file.ze03        #NO FUN-690009 VARCHAR(72)

DEFINE g_row_count          LIKE type_file.num10     #NO FUN-690009 INTEGER      #總比數
DEFINE g_curs_index         LIKE type_file.num10     #NO FUN-690009 INTEGER
DEFINE g_jump               LIKE type_file.num10     #NO FUN-690009 INTEGER      #查詢指定比數
DEFINE mi_no_ask            LIKE type_file.num5      #NO FUN-690009 SMALLINT     #是否開啟指定窗口
DEFINE li_dbs               LIKE azp_file.azp01      #No.FUN-9B0130
DEFINE g_rvw17              LIKE rvw_file.rvw17      #No.MOD-CA0222
#FUN-CB0080--add--str--
DEFINE g_rvw_1         DYNAMIC ARRAY OF RECORD
           rvw01_1      LIKE rvw_file.rvw01,
           rvw02_1      LIKE rvw_file.rvw02,
           rvw19_1      LIKE rvw_file.rvw19,
           rvv06_1      LIKE rvv_file.rvv06,
           pmc03_1      LIKE pmc_file.pmc03,
           rvw03_1      LIKE rvw_file.rvw03,
           rvw04_1      LIKE rvw_file.rvw04,
           rvw11_1      LIKE rvw_file.rvw11,
           rvw05f_1     LIKE rvw_file.rvw05f,
           rvw06f_1     LIKE rvw_file.rvw06f,
           rvw12_1      LIKE rvw_file.rvw12
           END RECORD
DEFINE g_rec_b1     LIKE type_file.num10,
       l_ac1        LIKE type_file.num5
DEFINE g_bp_flag    STRING
#FUN-CB0080--add--end

MAIN

   OPTIONS                                               #改變一些系統預設值
      INPUT NO WRAP
   DEFER INTERRUPT                                       #擷取中斷鍵, 由程式處理
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("GAP")) THEN
      EXIT PROGRAM
   END IF

   IF g_aza.aza26 <> '2' THEN
      CALL cl_err('','gap-202',1)
      EXIT PROGRAM
   END IF

   LET g_forupd_sql = "SELECT rvw01,rvw07,rvw02,rvw18,rvw19,rvw03,rvw04,rvw11,rvw12 ",    #MOD-DC0088 add rvw18
                      "      ,rvwacti,rvwuser,rvwgrup,rvwmodu,rvwdate,rvworiu,rvworig ",  #FUN-D10064
                      " FROM rvw_file WHERE rvw01=? FOR UPDATE"   #MOD-640405 #No.FUN-CB0053 Add rvw19

   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i140_cl CURSOR FROM g_forupd_sql

     CALL  cl_used(g_prog,g_time,1)                      #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0097
         RETURNING g_time    #No.FUN-6A0097
   LET p_row = 3 LET p_col = 17
   OPEN WINDOW i140_w AT p_row,p_col                     #顯示畫面
      WITH FORM "gap/42f/gapi140"
   CALL cl_ui_init()
   LET g_type='1'
   CALL i140_menu()                                      #中文

   CLOSE WINDOW i140_w                                   #結束畫面
     CALL  cl_used(g_prog,g_time,2)                      #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0097
         RETURNING g_time    #No.FUN-6A0097
END MAIN

FUNCTION i140_menu()
DEFINE   l_rvw05f_s        LIKE rvw_file.rvw05     #No.MOD-7B0150

   WHILE TRUE
      CALL i140_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i140_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i140_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i140_r()
            END IF
        #add by zhaoxiangb 160120
        WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL i140_out()
            END IF
        #end add
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i140_u()
            END IF
         #FUN-D10064--add--str--
         WHEN "invalid"
            IF cl_chk_act_auth() THEN
               CALL i140_x()
               CALL i140_show()
            END IF
         #FUN-D10064--add--end
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i140_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         #依單據輸入發票
         WHEN "Input_Invoice_By_No"
            IF g_type = '2' THEN
               CALL cl_err('','aap-900',0)
            ELSE
               LET g_cmd = "gapi120 '",g_type,"' '",g_head_1.rvw01,"'"
               CALL cl_cmdrun(g_cmd)
               #避免兩支作業同時對rvw_file操作的錯誤
               IF NOT cl_null(g_head_1.rvw01) THEN
                  CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
                  EXIT PROGRAM
               END IF
               CALL i140_list_fill()  #FUN-CB0080
            END IF #No.TQC-760013

         WHEN "Carry_Account"
           #IF NOT cl_null(g_head_1.rvw01) THEN                                 #No.FUN-CB0053 Mark
            IF NOT cl_null(g_head_1.rvw01) AND cl_null(g_head_1.rvw18) THEN #No.FUN-CB0053 Add
               SELECT SUM(rvw05f) INTO l_rvw05f_s FROM rvw_file
                WHERE rvw01 = g_head_1.rvw01
               IF cl_null(l_rvw05f_s) THEN
                  LET l_rvw05f_s = 0
               END IF
               #No.MOD-BA0066   --Begin
               #IF l_rvw05f_s >= 0 THEN
               #   LET g_cmd = "aapp110 '' '' '' '' '' '' '' '' '1' 'N' '",g_head_1.rvw01,"'"
               #ELSE
               #   LET g_cmd = "aapp111 '' '3' '4' '' '",g_today,"' '' '' '",g_user,"' '",g_clas,"' '' 'N' '",g_head_1.rvw01,"'"
               #END IF
               #CALL cl_cmdrun(g_cmd)
               IF l_rvw05f_s = 0 THEN
                  CALL cl_err("","alm-340",0)
               END IF
               IF l_rvw05f_s > 0 THEN
                 #LET g_cmd = "aapp110 '' '' '' '' '' '' '' '' '1' 'N' '",g_head_1.rvw01,"'"                     #No.FUN-CB0053   Mark
                  LET g_cmd = "aapp110 '' '' '",g_head_1.rvw19,"' '' '' '' '' '' '1' 'N' '",g_head_1.rvw01,"'"   #No.FUN-CB0053   Add
                 #CALL cl_cmdrun(g_cmd)       #No.FUN-CB053   Mark
                  CALL cl_cmdrun_wait(g_cmd)  #No.FUN-CB0053  Add
                  SELECT rvw18 INTO g_head_1.rvw18 FROM rvw_file WHERE rvw01 = g_head_1.rvw01   #No.FUN-CB0053 Add
               END IF
               IF l_rvw05f_s < 0 THEN
                 #LET g_cmd = "aapp111 '' '3' '4' '' '",g_today,"' '' '' '",g_user,"' '",g_clas,"' '' 'N' '",g_head_1.rvw01,"'"  #No.FUN-CN0053 Mark
                  LET g_cmd = "aapp111 '' '3' '4' '' '",g_head_1.rvw19,"' '' '' '",g_user,"' '",g_clas,"' '' 'N' '",g_head_1.rvw01,"'" #No.FUN-CB0053 Add
                 #CALL cl_cmdrun(g_cmd)       #No.FUN-CB053   Mark
                  CALL cl_cmdrun_wait(g_cmd)  #No.FUN-CB0053  Add
                  SELECT rvw18 INTO g_head_1.rvw18 FROM rvw_file WHERE rvw01 = g_head_1.rvw01   #No.FUN-CB0053 Add
               END IF
               #No.MOD-BA0066   --End
               CALL i140_show()   #No.FUN-CB0053   Add
            END IF
            CALL i140_list_fill()  #FUN-CB0080

        #No.FUN-CB0048 ---start--- Add
         WHEN "gen_da"
            IF cl_chk_act_auth() THEN
               IF NOT cl_null(g_head_1.rvw18) THEN
                  CALL i140_gen()
               END IF
            END IF
            SELECT rvw18 INTO g_head_1.rvw18 FROM rvw_file WHERE rvw01 = g_head_1.rvw01   #No.FUN-CB0053 Add
            CALL i140_show()   #No.FUN-CB0053   Add
        #No.FUN-CB0048 ---end  --- Add

         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"
            CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_rvw),'','')

         WHEN "related_document"  #相關文件
           IF cl_chk_act_auth() THEN
              IF g_head_1.rvw01 IS NOT NULL THEN
                LET g_doc.column1 = "rvw01"
                LET g_doc.value1 = g_head_1.rvw01
                CALL cl_doc()
              END IF
          END IF

      END CASE
   END WHILE
END FUNCTION

FUNCTION i140_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01   #No.FUN-580031  HCN
   DEFINE l_wc          LIKE type_file.chr1000   #NO FUN-690009 VARCHAR(300)
   DEFINE l_wc2         LIKE type_file.chr1000   #NO FUN-690009 VARCHAR(300)
   DEFINE i             LIKE type_file.num5      #NO FUN-690009 SMALLINT

   CLEAR FORM                                              #清除畫面
   CALL g_rvw.clear()
   LET l_ac = 1
   CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

   INITIALIZE g_head_1.* TO NULL    #No.FUN-750051
   CONSTRUCT BY NAME g_wc ON                               # 螢幕上取單頭條件
                rvw01,rvw02,rvw07,rvv06,rvw03,rvw04,rvw11,rvw12   #FUN-9B0130  #No.MOD-B50003 add rvv06
               ,rvw18                                             #No.FUN-CB0048   Add
               ,rvwuser,rvwgrup,rvworiu,rvworig,rvwmodu,rvwdate,rvwacti   #FUN-D10064
     BEFORE CONSTRUCT
        CALL cl_qbe_display_condition(lc_qbe_sn)
         INITIALIZE g_head_1.* TO NULL

      ON ACTION controlp
         CASE
#No.MOD-B50003 --begin
            WHEN INFIELD(rvv06)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_pmc1"
               LET g_qryparam.state = "c"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvv06
               NEXT FIELD rvv06
#No.MOD-B50003 --end
	    WHEN INFIELD(rvw03)
	       CALL cl_init_qry_var()
	       LET g_qryparam.form ="q_gec"
	       LET g_qryparam.state = "c"
	       CALL cl_create_qry() RETURNING g_qryparam.multiret
	       DISPLAY g_qryparam.multiret TO rvw03
	       NEXT FIELD rvw03

	    WHEN INFIELD(rvw11)
	       CALL cl_init_qry_var()
	       LET g_qryparam.form ="q_azi"
	       LET g_qryparam.state = "c"
	       CALL cl_create_qry() RETURNING g_qryparam.multiret
	       DISPLAY g_qryparam.multiret TO rvw11
	       NEXT FIELD rvw11

           #No.FUN-CB0048 ---start--- Add
            WHEN INFIELD(rvw18)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_apa07"
               LET g_qryparam.state = "c"
               LET g_qryparam.where = " apa00 IN ('11','21')"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvw18
               NEXT FIELD rvw18
           #No.FUN-CB0048 ---end  --- Add

	    OTHERWISE EXIT CASE
	 END CASE
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

                 ON ACTION qbe_select
         	   CALL cl_qbe_select()

   END CONSTRUCT
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond(null, null) #FUN-980030
   IF INT_FLAG THEN RETURN END IF

   # 螢幕上取單身條件
   CONSTRUCT g_wc2 ON rvw99,rvw08,rvw09,rvv09,rvw10,rvw05f,rvw06f,sum1        #MOD-640405      #CHI-980038   #FUN-9B0130 add rvw99 FUN-C80027  ADD--sum1
		 FROM s_rvw[1].rvw99,s_rvw[1].rvw08,s_rvw[1].rvw09,s_rvw[1].rvv09,   #FUN-9B0130 add rvw99
		      s_rvw[1].rvw10,s_rvw[1].rvw05f,   #MOD-640405
		      s_rvw[1].rvw06f,s_rvw[1].sum1     #FUN-C80027--ADD sum1
      BEFORE CONSTRUCT
         CALL cl_qbe_display_condition(lc_qbe_sn)
	 CALL g_rvw.clear()

      ON ACTION controlp
	 CASE
	    WHEN INFIELD(rvw08)
               LET g_qryparam.multiret_index =1
               CALL q_rvv4(TRUE,TRUE,g_head_1.rvv06,g_rvw[l_ac].rvw08,
                           #g_rvw[l_ac].rvw09,g_type,'0',g_head_1.rvw01)   #FUN-9B0130
                           g_rvw[l_ac].rvw09,g_type,'0',g_head_1.rvw01,g_rvw[l_ac].rvw99)  #FUN-9B0130
                 RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvw08
               IF INT_FLAG THEN
                  LET INT_FLAG=0
                  NEXT FIELD rvw08
               ELSE
                  CALL i140_rvw08()
                  NEXT FIELD rvw09
               END IF

         END CASE
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

                 ON ACTION qbe_save
		   CALL cl_qbe_save()

   END CONSTRUCT
   LET g_sql = "SELECT UNIQUE rvw01,rvw07,rvw02,rvw19,rvw03,rvw04,rvw11,rvw12",   #No.FUN-CB0053   Add rvw19
                  "  FROM rvw_file,rvv_file ",   #No.MOD-B50003
                  " WHERE ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
#No.MOD-B50003 --begin
                  "   AND rvv01 = rvw08 AND rvv02 = rvw09 ",
                  "   AND rvv03 <> '2' ",
#No.MOD-B50003 --end
                  " ORDER BY rvw02,rvw19"   #No.FUN-CB0053   Add   rvw19
   PREPARE i140_prepare FROM g_sql
   IF SQLCA.sqlcode THEN   #No.TQC-790140
      CALL cl_err('i140_prepare',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE i140_cs                         #SCROLL CURSOR
      SCROLL CURSOR WITH HOLD FOR i140_prepare

   #FUN-CB0080--add--str--
   LET g_sql = "SELECT rvw01,rvw02,rvw19,rvv06,'',rvw03,rvw04,",
               "       rvw11,SUM(rvw05f),SUM(rvw06),rvw12",
               "  FROM rvw_file,rvv_file ",
               " WHERE rvv01 = rvw08 AND rvv02 = rvw09 ",
               "   AND rvv03 <> '2'",
               "   AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
               " GROUP BY rvw01,rvw07,rvw02,rvw19,rvw03,rvw04,rvw11,rvw12,rvv06,rvw18 ",
               " ORDER BY rvw02,rvw19"
   PREPARE i140_list_pr FROM g_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('i140_list_pr',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF
   DECLARE i140_list_cs CURSOR FOR i140_list_pr
   #FUN-CB0080--add--end

      LET g_sql = "SELECT COUNT(UNIQUE rvw01)",
                  "  FROM rvw_file,rvv_file",   #No.MOD-B50003
                  " WHERE ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
#No.MOD-B50003 --begin
                  "   AND rvv01 = rvw08 AND rvv02 = rvw09 ",
                  "   AND rvv03 <> '2' "
#No.MOD-B50003 --end
   PREPARE i140_precount FROM g_sql
   IF SQLCA.sqlcode THEN   #No.TQC-790140
      CALL cl_err('i140_precount',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE i140_count CURSOR FOR i140_precount
END FUNCTION

FUNCTION i140_q()
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   INITIALIZE g_head_1.* TO NULL             #No.FUN-6A0009
   MESSAGE ""
   CALL cl_opmsg('q')
   DISPLAY ' ' TO FORMONLY.cnt
   CALL i140_cs()
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_head_1.* TO NULL
      RETURN
   END IF
   MESSAGE " SEARCHING ! " ATTRIBUTE(REVERSE)
   OPEN i140_cs               # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_head_1.* TO NULL
   ELSE
      OPEN i140_count
      FETCH i140_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt  #ATTRIBUTE(MAGENTA)
      CALL i140_fetch('F')    # 讀出TEMP第一筆并顯示
      CALL i140_list_fill()       #FUN-CB0080
      LET g_bp_flag ='item_list'  #FUN-CB0080
   END IF
   MESSAGE ""
END FUNCTION

FUNCTION i140_fetch(p_flag)
DEFINE
   l_sql           LIKE type_file.chr1000,  #NO FUN-690009 VARCHAR(300)
   p_flag          LIKE type_file.chr1,     #NO FUN-690009 VARCHAR(1)        #處理方式
   l_abso          LIKE type_file.num10     #NO FUN-690009 INTEGER        #絕對的筆數
   CASE p_flag
      WHEN 'N' FETCH NEXT     i140_cs INTO g_head_1.rvw01
      WHEN 'P' FETCH PREVIOUS i140_cs INTO g_head_1.rvw01
      WHEN 'F' FETCH FIRST    i140_cs INTO g_head_1.rvw01
      WHEN 'L' FETCH LAST     i140_cs INTO g_head_1.rvw01
      WHEN '/'
         IF (NOT mi_no_ask) THEN
            CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
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
         FETCH ABSOLUTE g_jump i140_cs INTO g_head_1.rvw01
         LET mi_no_ask = FALSE
   END CASE

   IF SQLCA.sqlcode THEN
      CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)
      INITIALIZE g_head_1.* TO NULL  #TQC-6B0105
      LET g_rec_b=0
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
      DISPLAY g_curs_index TO FORMONLY.idx  #FUN-CB0080
      CALL cl_navigator_setting( g_curs_index, g_row_count )
   END IF

      SELECT UNIQUE rvw01,rvw07,rvw02,rvw19,rvw03,rvw04,rvw11,rvw12,rvv06, #No.MOD-B50003 add rvv06   #No.FUN-CB0053   Add rvw19
      #      '',SUM(rvw05f),SUM(rvw06f),SUM(rvw05f),SUM(rvw06f)        #FUN-C80027 mark
      #      '',SUM(rvw05f),SUM(rvw06f),'',SUM(rvw05f),SUM(rvw06f),''  #FUN-C80027 add 2'' #No.FUN-CB0048   Mark
             '',SUM(rvw05f),SUM(rvw06f),SUM(rvw05f),SUM(rvw06f),'',SUM(rvw05f),SUM(rvw06f),'',rvw18        #No.FUN-CB0048   Add
        INTO g_head_1.*
        FROM rvw_file,rvv_file              #FUN-9B0130  #No.MOD-B50003
       WHERE rvw01 = g_head_1.rvw01
         AND rvw08=rvv01 AND rvw09 = rvv02 #No.MOD-B50003
       GROUP BY rvw01,rvw07,rvw02,rvw19,rvw03,rvw04,rvw11,rvw12,rvv06,rvw18    #No.MOD-B50003  #No.FUN-CB0048   Add rvw18 #No.FUN-CB0053  Add rvw19
      SELECT pmc03 INTO g_head_1.pmc03
        FROM pmc_file
       WHERE pmc01 = g_head_1.rvv06
   SELECT SUM(rvw05f),SUM(rvw06f)
     INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
     FROM rvw_file
    WHERE rvw01 = g_head_1.rvw01

   #FUN-C80027--ADD--STR
    SELECT SUM(rvw05),SUM(rvw06)
     INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
     FROM rvw_file
    WHERE rvw01 = g_head_1.rvw01
    LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum
    LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
   #FUN-C80027--ADD--END
   IF NOT cl_null(g_head_1.rvw11) THEN   #FUN-9B0130
      SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
       WHERE azi01 = g_head_1.rvw11
      IF SQLCA.sqlcode THEN
         CALL cl_err3("sel","azi_file",g_head_1.rvw11,"",SQLCA.sqlcode,"","",1)  #No.FUN-660071
         INITIALIZE g_head_1.* TO NULL
         RETURN
      END IF
   END IF   #FUN-9B0130
   LET g_head_1.rvw05f_s=g_head_1.rvw05f_sum
   LET g_head_1.rvw06f_s=g_head_1.rvw06f_sum
   LET g_head_1.rvw05f_s=cl_digcut(g_head_1.rvw05f_s,t_azi04)
   LET g_head_1.rvw06f_s=cl_digcut(g_head_1.rvw06f_s,t_azi04)
   #FUN-D10064--add--str--
   SELECT rvwacti,rvwuser,rvwgrup,rvwmodu,rvwdate,rvworiu,rvworig
     INTO g_head_1.rvwacti,g_head_1.rvwuser,g_head_1.rvwgrup,
          g_head_1.rvwmodu,g_head_1.rvwdate,g_head_1.rvworiu,
          g_head_1.rvworig
     FROM rvw_file
    WHERE rvw01=g_head_1.rvw01
   #FUN-D10064--add--end
   CALL i140_show()
END FUNCTION

#將資料顯示在畫面上
FUNCTION i140_show()
   DEFINE  l_pmc03    LIKE pmc_file.pmc03
   DISPLAY BY NAME g_type
   DISPLAY BY NAME g_head_1.*
   CALL i140_b_fill(g_wc2)                #單身
   CALL cl_show_fld_cont()               #No.FUN-590083
END FUNCTION

FUNCTION i140_b()
DEFINE
   l_ac_t          LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #未取消的ARRAY CNT
   l_n             LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #檢查重復用
   l_lock_sw       LIKE type_file.chr1,     #NO FUN-690009 VARCHAR(1)     #單身鎖住否
   p_cmd           LIKE type_file.chr1,     #NO FUN-690009 VARCHAR(1)
   l_allow_insert  LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #可新增否
   l_allow_delete  LIKE type_file.num5,     #NO FUN-690009 SMALLINT    #可刪除否
   l_cnt           LIKE type_file.num5,     #NO FUN-690009 SMALLINT
   l_rvv04         LIKE rvv_file.rvv04,
   l_rvv05         LIKE rvv_file.rvv05
#入庫發票的入庫數量不能大于入庫異動的入庫數量
DEFINE   l_rvv17   LIKE rvv_file.rvv17
DEFINE   l_rvv03   LIKE rvv_file.rvv03    #No.TQC-760013

DEFINE tok base.StringTokenizer
DEFINE l_str       STRING
DEFINE l_i         LIKE type_file.num5,     #NO FUN-690009 SMALLINT
       l_rvw08     LIKE rvw_file.rvw08,
       l_rvw09     LIKE rvw_file.rvw09,
       l_rvw01     LIKE rvw_file.rvw01,     #fro delete
       l1_n        LIKE type_file.num5      #NO FUN-690009 SMALLINT     #for delete
DEFINE l_rvw10     LIKE rvw_file.rvw10      #No.TQC-790140
DEFINE l_rvw05f_sum LIKE rvw_file.rvw05f     #No.TQC-790140
DEFINE l_rvu00     LIKE rvu_file.rvu00      #No.TQC-790140
DEFINE l_rvw10_t   LIKE rvw_file.rvw10      #No.MOD-940412
DEFINE l_rvw17_t   LIKE rvw_file.rvw17      #No.MOD-940412
DEFINE l_rvu116    LIKE rvu_file.rvu116     #FUN-940083
DEFINE l_rvv25     LIKE rvv_file.rvv25      #MOD-990163
DEFINE l_rvw05f    LIKE rvw_file.rvw05f     #CHI-C80054
DEFINE l_rvw05f_t  LIKE rvw_file.rvw05f     #CHI-C80054
DEFINE l_rvv36     LIKE rvv_file.rvv36      #MOD-C90185 add
DEFINE l_rvv37     LIKE rvv_file.rvv37      #MOD-C90185 add
DEFINE l_pmm01     LIKE pmm_file.pmm01      #MOD-C90185 add
DEFINE l_pmm02     LIKE pmm_file.pmm02      #MOD-C90185 add

   LET g_action_choice = ""
   IF cl_null(g_head_1.rvw01) THEN RETURN END IF
   SELECT COUNT(*) INTO l_cnt FROM apk_file
    WHERE apk03 = g_head_1.rvw01
     # AND apk28 = g_head_1.rvw07                  #CHI-B30082 add
      AND apk01 IN (SELECT apa01 FROM apa_file)   #MOD-A20066 mod
                   # WHERE apa00 MATCHES '1*')    #MOD-A20066 mark
   IF l_cnt > 0 THEN
      CALL cl_err('','apm-241',0)
      RETURN
   END IF

  #--------------------MOD-CB0281---------------(S)
   SELECT azi03,azi04 INTO t_azi03,t_azi04
     FROM azi_file
    WHERE azi01 = g_head_1.rvw11
  #--------------------MOD-CB0281---------------(E)
   CALL cl_opmsg('b')
 # LET g_forupd_sql = "SELECT rvw99,rvw08,rvw09,'','',rvw02,rvw10,rvw17,rvw05f,rvw06f,rvw05,rvw06",    #FUN-9B0130 add rvw99  #FUN-C80027 mark
   LET g_forupd_sql = "SELECT rvw99,rvw08,rvw09,'','','',rvw02,rvw10,rvw17,rvw05f,rvw06f,'',rvw05,rvw06,'','','' ",    #FUN-C80027 ADD  #add '', by dengsy151231  #add  '','' by zhaoxiangb 160324
                      "  FROM rvw_file ",
                      " WHERE rvw01 = ? ",
                      "   AND rvw08 = ? ",
                      "   AND rvw09 = ? ",
                      "   FOR UPDATE   "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i140_bcl CURSOR FROM g_forupd_sql
   LET l_ac_t = 0
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")

   INPUT ARRAY g_rvw WITHOUT DEFAULTS FROM s_rvw.*
         ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                   APPEND ROW=l_allow_insert)
      BEFORE INPUT
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF

      BEFORE ROW
         LET p_cmd=''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'                     #DEFAULT
         LET l_n  = ARR_COUNT()

         IF g_rec_b >= l_ac THEN
            LET p_cmd='u'
            LET g_rvw_t.* = g_rvw[l_ac].*        #BACKUP
            BEGIN WORK
            OPEN i140_bcl USING g_head_1.rvw01,g_rvw_t.rvw08,g_rvw_t.rvw09               #表示更改狀態
               IF SQLCA.sqlcode THEN
                  CALL cl_err(g_rvw_t.rvw09,SQLCA.sqlcode,1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH i140_bcl INTO g_rvw[l_ac].*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err(g_rvw_t.rvw09,SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  END IF
                  #add by zhaoxiangb 160324
                  LET g_rvw[l_ac].sum1 = g_rvw_t.sum1
                  LET g_rvw[l_ac].sum2 = g_rvw_t.sum2
                  #end add
                 LET g_plant_new = g_rvw[l_ac].rvw99
                 CALL s_gettrandbs()
                 LET li_dbs = g_dbs_tra
                 #LET g_sql = "SELECT rvv09,rvv31,rvv031 FROM ",li_dbs CLIPPED,"rvv_file ",
                 LET g_sql = "SELECT rvv09,rvv31,rvv031,rvvud02 FROM ",cl_get_target_table(g_rvw[l_ac].rvw99,'rvv_file'), #FUN-A50102
                             " WHERE rvv01 ='", g_rvw[l_ac].rvw08,"' ",
                             "   AND rvv02 ='", g_rvw[l_ac].rvw09,"' "
                 CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		         CALL cl_parse_qry_sql(g_sql,g_rvw[l_ac].rvw99) RETURNING g_sql #FUN-A50102
                 PREPARE sel_rvv09_pre FROM g_sql
                 EXECUTE sel_rvv09_pre INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,g_rvw[l_ac].ima02,g_rvw[l_ac].rvvud02
                 SELECT rvu08 INTO g_rvw[l_ac].rvu08 FROM rvu_file   #add by dengsy151231
                 WHERE rvu01=g_rvw[l_ac].rvw08    #add by dengsy151231
                 SELECT pja02 INTO g_rvw[l_ac].pja02 FROM pja_file WHERE pja01 = g_rvw[l_ac].rvvud02
               END IF
            IF NOT cl_null(g_rvw_t.rvw08) AND NOT cl_null(g_rvw_t.rvw09) THEN
               SELECT COUNT(*) INTO l_cnt
                 FROM apb_file,apa_file,apk_file
                WHERE apb01 = apa01
                  AND apa01 = apk01
                  AND apa08 <> 'UNAP'
                  AND apa00 = '11'
                  AND apb21 = g_rvw_t.rvw08
                  AND apb22 = g_rvw_t.rvw09
                  AND apk03 = g_head_1.rvw01
              #str MOD-A20066 add
               #檢查發票是否存在退貨折讓帳款裡
               IF l_cnt = 0 THEN
                  SELECT COUNT(*) INTO l_cnt
                    FROM apb_file,apa_file
                   WHERE apb01 = apa01
                     AND apa00 = '21'
                     AND apb21 = g_rvw_t.rvw08
                     AND apb22 = g_rvw_t.rvw09
                     AND apb11 = g_head_1.rvw01
#                     AND apk28 = g_head_1.rvw07                  #CHI-B30082 add
               END IF
              #end MOD-A20066 add
               IF l_cnt > 0 THEN
                  CALL cl_err('','apm-241',0)
                  CALL i140_set_no_entry_b(p_cmd)
                  NEXT FIELD rvw08
               ELSE
                  CALL i140_set_entry_b(p_cmd)
                  MESSAGE " "
               END IF
            END IF
         END IF

      AFTER INSERT
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         #No.MOD-CA0222  --Begin
        #LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi04)    #MOD-CB0281 mark
         LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi03)    #MOD-CB0281 add
         LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)
         LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
         DISPLAY BY NAME g_rvw[l_ac].rvw17
         DISPLAY BY NAME g_rvw[l_ac].rvw05f
         DISPLAY BY NAME g_rvw[l_ac].rvw06f
         #No.MOD-CA0222  --End
         INSERT INTO rvw_file(rvw01,rvw02,rvw03,rvw04,rvw07,rvw11,rvw12,   #MOD-640405
                              rvwacti,rvwuser,rvwgrup,rvwmodu,rvwdate,rvworiu,rvworig, #FUN-D10064
                              rvw05f,rvw06f,rvw05,rvw06,rvw99,rvw08,rvw09,rvw10,    #FUN-9B0130 add rvw99
                              rvw17,rvw19,   #No.FUN-CB0053   Add rvw19
                              rvwlegal)   #FUN-9B0130
                       VALUES(g_head_1.rvw01,g_head_1.rvw02,g_head_1.rvw03,
                              g_head_1.rvw04,g_head_1.rvw07,g_head_1.rvw11,
                              g_head_1.rvw12,   #MOD-640405
                              g_head_1.rvwacti,g_head_1.rvwuser,g_head_1.rvwgrup, #FUN-D10064
                              g_head_1.rvwmodu,g_head_1.rvwdate,g_head_1.rvworiu, #FUN-D10064
                              g_head_1.rvworig, #FUN-D10064
                              g_rvw[l_ac].rvw05f,g_rvw[l_ac].rvw06f,
                              g_rvw[l_ac].rvw05,g_rvw[l_ac].rvw06,
                              g_rvw[l_ac].rvw99,                      #FUN-9B0130 add
                              g_rvw[l_ac].rvw08,g_rvw[l_ac].rvw09,
                              g_rvw[l_ac].rvw10,  #MOD-640405     #No.TQC-7B0126 unmark
                              g_rvw[l_ac].rvw17,g_head_1.rvw19,   #No.FUN-CB0053   Add g_head_1.rvw19
                              g_legal)            #FUN-9B0130
         IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
            CALL cl_err3("ins","rvw_file",g_rvw[l_ac].rvw08,g_rvw[l_ac].rvw09,SQLCA.sqlcode,"","",1)  #No.FUN-660071
            LET g_rvw[l_ac].* = g_rvw_t.*
         ELSE
            MESSAGE 'INSERT O.K'
            COMMIT WORK
            LET g_rec_b=g_rec_b+1
            DISPLAY g_rec_b TO FORMONLY.cn2
         END IF

      BEFORE INSERT
         LET l_n = ARR_COUNT()
         LET p_cmd='a'
         INITIALIZE g_rvw[l_ac].* TO NULL        #900423
         LET g_rvw[l_ac].rvw99 = g_plant         #MOD-C50188
         LET g_rvw_t.* = g_rvw[l_ac].*           #新輸入資料

      AFTER FIELD rvw99
         IF NOT cl_null(g_rvw[l_ac].rvw99) THEN
            CALL i140_rvw99()
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(g_rvw[l_ac].rvw99,g_errno,1)
               NEXT FIELD rvw99
            END IF
         ELSE
            CALL cl_err('','alm-809',0)
            NEXT FIELD rvw99
         END IF

      BEFORE FIELD rvw08
         IF NOT cl_null(g_rvw_t.rvw08) AND NOT cl_null(g_rvw_t.rvw09) THEN
            SELECT COUNT(*) INTO l_cnt
              FROM apb_file,apa_file,apk_file
             WHERE apb01 = apa01
               AND apa01 = apk01
               AND apa08 <> 'UNAP'
               AND apa00 = '11'
               AND apb21 = g_rvw_t.rvw08
               AND apb22 = g_rvw_t.rvw09
               AND apk03 = g_head_1.rvw01
           #str MOD-A20066 add
            #檢查發票是否存在退貨折讓帳款裡
            IF l_cnt = 0 THEN
               SELECT COUNT(*) INTO l_cnt
                 FROM apb_file,apa_file
                WHERE apb01 = apa01
                  AND apa00 = '21'
                  AND apb21 = g_rvw_t.rvw08
                  AND apb22 = g_rvw_t.rvw09
                  AND apb11 = g_head_1.rvw01
            END IF
           #end MOD-A20066 add
         ELSE
            LET l_cnt = 0
            CALL i140_set_entry_b(p_cmd)
            MESSAGE " "
         END IF

      AFTER FIELD rvw08
         IF l_cnt > 0 AND (g_rvw[l_ac].rvw08 <> g_rvw_t.rvw08
                       OR  cl_null(g_rvw[l_ac].rvw08)) THEN
            LET g_rvw[l_ac].rvw08 = g_rvw_t.rvw08
            NEXT FIELD rvw08
         END IF
         IF NOT cl_null(g_rvw[l_ac].rvw08) THEN
            IF p_cmd = 'a' OR
               (g_rvw_t.rvw08 != g_rvw[l_ac].rvw08) THEN
               CALL i140_rvw08()
               IF NOT cl_null(g_errno) THEN
                  IF NOT cl_null(g_rvw_t.rvw08) THEN
                     LET g_rvw[l_ac].rvw08 = g_rvw_t.rvw08
                  END IF
                  CALL cl_err(g_rvw[l_ac].rvw08,g_errno,0) NEXT FIELD rvw08
               END IF
               INITIALIZE g_rvw[l_ac].rvw10,   #MOD-640405
                          g_rvw[l_ac].rvw05,g_rvw[l_ac].rvw05f,
                          g_rvw[l_ac].rvw06,g_rvw[l_ac].rvw06f,
                          g_rvw[l_ac].rvw09 TO NULL
               DISPLAY g_rvw[l_ac].* TO s_rvw[l_sl].*
               SELECT rvu08 INTO g_rvw[l_ac].rvu08 FROM rvu_file   #add by dengsy151231
                 WHERE rvu01=g_rvw[l_ac].rvw08    #add by dengsy151231
            END IF
         END IF

      AFTER FIELD rvw09
         IF NOT cl_null(g_rvw[l_ac].rvw09) THEN
            IF (p_cmd = 'a') OR
               (p_cmd = 'u' AND (g_rvw_t.rvw09 != g_rvw[l_ac].rvw09 OR g_rvw_t.rvw08 != g_rvw[l_ac].rvw08)) THEN
               CALL i140_rvw09()
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_rvw[l_ac].rvw09,g_errno,0)
                  NEXT FIELD rvw09
               END IF
               IF NOT cl_null(g_rvw[l_ac].rvw08) THEN
                 #---------------------MOD-C90185-------------------(S)
                  SELECT rvv36,rvv37 INTO l_rvv36,l_rvv37
                    FROM rvv_file
                   WHERE rvv01 = g_rvw[l_ac].rvw08
                     AND rvv02 = g_rvw[l_ac].rvw09
                  SELECT pmm01,pmm02 INTO l_pmm01,l_pmm02
                    FROM pmm_file,pmn_file
                   WHERE pmm01 = pmn01
                     AND pmn01 = l_rvv36
                     AND pmn02 = l_rvv37
                  IF l_pmm02 = 'TAP' OR l_pmm02 = 'TRI' THEN
                     CALL i140_pmm02(l_pmm01)
                     IF NOT cl_null(g_errno) THEN
                        CALL cl_err(g_rvw[l_ac].rvw08,g_errno,0)
                        NEXT FIELD rvw08
                     END IF
                  END IF
                 #---------------------MOD-C90185-------------------(E)
                  LET l_rvv25=""                                    #MOD-B50016 add
                  #LET g_sql = "SELECT rvv25 FROM ",li_dbs CLIPPED,"rvv_file ",
                  LET g_sql = "SELECT rvv25 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                              " WHERE rvv01='",g_rvw[l_ac].rvw08,"' ",
                              "   AND rvv02='",g_rvw[l_ac].rvw09,"' "
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		          CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                  PREPARE sel_rvv25_pre FROM g_sql
                  EXECUTE sel_rvv25_pre INTO l_rvv25
                  IF cl_null(l_rvv25) THEN LET l_rvv25="N" END IF   #MOD-B50016 add
                  IF l_rvv25="Y" THEN
                     LET g_rvw[l_ac].rvw17=0
                     LET g_rvw[l_ac].rvw05=0
                     LET g_rvw[l_ac].rvw05f=0
                     LET g_rvw[l_ac].sum1 =0      #FUN-C80027
                     LET g_rvw[l_ac].rvw06=0
                     LET g_rvw[l_ac].rvw06f=0
                     LET g_rvw[l_ac].sum2=0       #FUN-C80027
                     DISPLAY BY NAME g_rvw[l_ac].rvw17,g_rvw[l_ac].rvw05,g_rvw[l_ac].rvw05f,
                                     g_rvw[l_ac].rvw06,g_rvw[l_ac].rvw06f
                                    ,g_rvw[l_ac].sum1,g_rvw[l_ac].sum2                   #FUN-C80027
                  END IF
               END IF
            END IF
         END IF

      #No.CHI-C80054  --Begin
      BEFORE FIELD rvw05f
         LET l_rvw05f_t = g_rvw[l_ac].rvw05f
      #No.CHI-C80054  --End

      AFTER FIELD rvw05f
         IF NOT cl_null(g_rvw[l_ac].rvw05f) THEN
            #NO.CHI-C80054  --Begin
            IF l_rvw05f_t != g_rvw[l_ac].rvw05f AND g_rvw[l_ac].rvw10 ! = 0 THEN
               IF g_rvw[l_ac].rvw05f < 0 THEN
                  LET l_rvw05f = g_rvw[l_ac].rvw05f * -1
               ELSE
                  LET l_rvw05f = g_rvw[l_ac].rvw05f
               END IF
               LET g_rvw[l_ac].rvw17 = l_rvw05f / g_rvw[l_ac].rvw10
               LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi03)
               DISPLAY BY NAME g_rvw[l_ac].rvw17
            END IF
            #NO.CHI-C80054  --End
            IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
               #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file",
               LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
	             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvv03_pre FROM g_sql
               EXECUTE sel_rvv03_pre INTO l_rvv03
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
               END IF
            END IF
            LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)   #No.MOD-740008
            IF g_gec07 <> 'Y' AND g_gec05 <> 'T' THEN                        #MOD-A80052
               LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f*g_head_1.rvw04/100   #原幣稅額
               LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)   #No.MOD-740008
            END IF                                                           #MOD-A80052
            IF g_type = '3' AND g_rvw[l_ac].rvw05 > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05 > 0 THEN
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
               END IF
            END IF
            #MOD-B70073--begin
            #IF g_flag='N' OR (g_rvw_t.rvw05f <> g_rvw[l_ac].rvw05f) OR (g_rvw_t.rvw05f IS NULL)THEN
            IF g_flag='N' OR (l_rvw05f_t <> g_rvw[l_ac].rvw05f) OR (g_rvw_t.rvw05f IS NULL)THEN   #No.CHI-C80054
               LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f*g_head_1.rvw04/100   #原幣稅額
               LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
               LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12  #本幣金額   #MOD-640405
               LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)   #No.MOD-740008
               LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05*g_head_1.rvw04/100   #本幣稅額    rvw04:稅率
               LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
               LET g_rvw[l_ac].sum1   = g_rvw[l_ac].rvw05f +g_rvw[l_ac].rvw06f    #FUN-C80027  ADD
               LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            END IF
            #MOD-B70073--end
            #MOD-B70073--mark--begin
            #LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12  #本幣金額   #MOD-640405
            #LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)   #No.MOD-740008
            #LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05*g_head_1.rvw04/100   #本幣稅額    rvw04:稅率
            #LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
            #MOD-B70073--mark--end
            DISPLAY BY NAME g_rvw[l_ac].rvw05f
            DISPLAY BY NAME g_rvw[l_ac].rvw06f
            DISPLAY BY NAME g_rvw[l_ac].rvw05
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].sum1       #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].sum2       #FUN-C80027  ADD
            #LET g_sql = "SELECT rvu00,rvu116 FROM ",li_dbs CLIPPED,"rvu_file ",
            LET g_sql = "SELECT rvu00,rvu116 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102
                        " WHERE rvu01 ='",g_rvw[l_ac].rvw08,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvu00_pre1 FROM g_sql
            EXECUTE sel_rvu00_pre1 INTO l_rvu00,l_rvu116
            IF l_rvu00 = '3' AND g_rvw[l_ac].rvw05f = 0 AND l_rvu116 = '3' THEN   #FUN-940083--add rvu116
               CALL cl_err(g_rvw[l_ac].rvw05f,'gap-143',0)   #異動金額不可為零
               NEXT FIELD rvw05f
            END IF
         END IF

      AFTER FIELD rvw06f
         IF NOT cl_null(g_rvw[l_ac].rvw06f) THEN
            LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw06f*g_head_1.rvw12     #TQC-840063
            LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
            LET g_rvw[l_ac].sum1   = g_rvw[l_ac].rvw05f +g_rvw[l_ac].rvw06f    #FUN-C80027  ADD
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].rvw05f
            DISPLAY BY NAME g_rvw[l_ac].rvw05
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].rvw06f
            DISPLAY BY NAME g_rvw[l_ac].sum1       #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].sum2       #FUN-C80027  ADD
         END IF

      AFTER FIELD rvw05
         IF NOT cl_null(g_rvw[l_ac].rvw05) AND (g_rvw[l_ac].rvw05 <> g_rvw_t.rvw05 )  THEN
            IF s_abs(g_rvw[l_ac].rvw05/g_head_1.rvw12-g_rvw[l_ac].rvw05f) >= 1 THEN
               CALL cl_err('','gap-004',0)
            END IF
            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05*g_head_1.rvw04/100
            LET g_rvw[l_ac].rvw05 = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)
            LET g_rvw[l_ac].rvw06 = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].rvw05
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].sum2       #FUN-C80027  ADD
            #LET g_sql = "SELECT rvu00,rvu116 FROM ",li_dbs CLIPPED,"rvu_file ",
            LET g_sql = "SELECT rvu00,rvu116 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102
                        " WHERE rvu01 ='",g_rvw[l_ac].rvw08,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvu00_pre2 FROM g_sql
            EXECUTE sel_rvu00_pre2 INTO l_rvu00,l_rvu116
            IF l_rvu00 = '3' AND g_rvw[l_ac].rvw05 = 0 AND l_rvu116 = '3' THEN    #FUN-940083--add rvu116
               CALL cl_err(g_rvw[l_ac].rvw05,'gap-143',0)   #異動金額不可為零
               NEXT FIELD rvw05
            END IF
         END IF

      AFTER FIELD rvw06
         IF NOT cl_null(g_rvw[l_ac].rvw06) THEN
            IF s_abs(g_rvw[l_ac].rvw06/g_head_1.rvw12-g_rvw[l_ac].rvw06f) >= 1 THEN
               CALL cl_err('','gap-005',0)
            END IF
            LET g_rvw[l_ac].rvw06 = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)  #No.MOD-740008
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].sum2       #FUN-C80027  ADD
         END IF

      BEFORE FIELD rvw10
         LET l_rvw10_t = g_rvw[l_ac].rvw10
#MOD-B70073--mark--begin
#      AFTER FIELD rvw10
#         IF cl_null(g_rvw[l_ac].rvw10) THEN
#            NEXT FIELD rvw10
#         ELSE
#            #LET g_sql = "SELECT rvu00,rvu116 FROM ",li_dbs CLIPPED,"rvu_file ",
#            LET g_sql = "SELECT rvu00,rvu116 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102
#                        " WHERE rvu01 ='",g_rvw[l_ac].rvw08,"' "
#            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#            PREPARE sel_rvu00_pre3 FROM g_sql
#            EXECUTE sel_rvu00_pre3 INTO l_rvu00,l_rvu116
#            IF l_rvu00 = '3' AND l_rvu116 ='3' THEN                       #FUN-940083--add rvu116
#               IF g_rvw[l_ac].rvw10 > 0 THEN
#                  LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 *-1
#                  NEXT FIELD rvw10
#               END IF
#            END IF
#            IF l_rvu00 = '1' THEN
#               IF g_rvw[l_ac].rvw10 < 0 THEN
#                  LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 *-1
#                  NEXT FIELD rvw10
#               END IF
#            END IF
#            IF g_sma.sma116 MATCHES '[13]' THEN
#               #LET g_sql = "SELECT rvv87 FROM ",li_dbs CLIPPED,"rvv_file",
#               LET g_sql = "SELECT rvv87 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
#                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_rvv87_pre FROM g_sql
#               EXECUTE sel_rvv87_pre INTO l_rvv17
#            ELSE
#               #LET g_sql = "SELECT rvv17 FROM ",li_dbs CLIPPED,"rvv_file ",
#               LET g_sql = "SELECT rvv17 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
#                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_rvv17_pre FROM g_sql
#               EXECUTE sel_rvv17_pre INTO l_rvv17
#            END IF
#            IF cl_null(l_rvv17) THEN LET l_rvv17 = 0 END IF
#            #計算未生成請款的入庫數量
#            CALL i140_rvw10()
#               IF l_rvu00 MATCHES '[23]' THEN       #No.MOD-870301
#                  LET l_rvw10 = g_rvw[l_ac].rvw10 * -1
#               END IF
#               IF l_rvu00 ='1' THEN
#                  LET l_rvw10 = g_rvw[l_ac].rvw10
#               END IF
#            IF l_rvw10 > l_rvv17 - g_rvw10 THEN              #No.TQC-7B0164
#               IF g_type = '1' THEN  #No.TQC-770051
#                  CALL cl_err(' ','apm-282',0)
#               END IF
#               IF g_type = '2' THEN
#                  #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file",
#                  LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
#                              " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                              "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
#                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		          CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#                  PREPARE sel_rvv03_pre4 FROM g_sql
#                  EXECUTE sel_rvv03_pre4 INTO l_rvv03
#                  IF l_rvv03 = '1' THEN
#                     CALL cl_err(' ','apm-282',0)
#                  END IF
#                  IF l_rvv03 = '3' THEN
#                     CALL cl_err(' ','apm-980',0)
#                  END IF
#               END IF
#               IF g_type = '3' THEN
#                  CALL cl_err(' ','apm-980',0)
#               END IF
#               NEXT FIELD rvw10
#            END IF
#            IF g_rvw[l_ac].rvw10 <> 0 AND (l_rvw10_t <> g_rvw[l_ac].rvw10            #No.MOD-940412
#               OR g_rvw_t.rvw05f <> g_rvw[l_ac].rvw05f) THEN   #No.MOD-910073
#               LET g_flag = 'N'                                #MOD-A80052
#              #LET g_sql = " SELECT gec07 FROM ",li_dbs CLIPPED,"gec_file",
#              #LET g_sql = " SELECT gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102            #MOD-A80052 mark
#               LET g_sql = " SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102      #MOD-A80052
#                           "  WHERE gec01='",g_head_1.rvw03,"' ",
#                           "    AND gec011 = '1'"
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_gec07_pre1 FROM g_sql
#              #EXECUTE sel_gec07_pre1 INTO g_gec07             #MOD-A80052 mark
#               EXECUTE sel_gec07_pre1 INTO g_gec05,g_gec07     #MOD-A80052
#               IF g_gec07 = 'Y' THEN    #含稅
#                  LET g_rvv38t = 0
#                  #LET g_sql = "SELECT rvv38t FROM ",li_dbs CLIPPED,"rvv_file,",
#                  #                                  li_dbs CLIPPED,"rvu_file ",
#                  LET g_sql = "SELECT rvv38t FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
#                                                    cl_get_target_table(g_plant_new,'rvu_file'),     #FUN-A50102
#                              " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                              "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
#                              "   AND rvv01 = rvu01 "
#                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		          CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#                  PREPARE sel_rvv38t_pre FROM g_sql
#                  EXECUTE sel_rvv38t_pre INTO g_rvv38t
#                 #-MOD-A80052-add-
#                  IF g_gec05 = 'T' THEN
#                     LET g_rvw05f = g_rvv38t*g_rvw[l_ac].rvw10
#                     LET g_rvw05f = cl_digcut(g_rvw05f,t_azi04)
#                     LET g_rvw[l_ac].rvw06f = g_rvw05f * (g_head_1.rvw04/100)
#                     LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
#                     LET g_rvw[l_ac].rvw05f = g_rvw05f - g_rvw[l_ac].rvw06f
#                     LET g_flag = 'Y'
#                  ELSE
#                     #未稅金額=(含稅單價*數量)/(1+稅率/100)
#                    #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)   #MOD-AC0024
#                     LET g_rvw[l_ac].rvw05f = cl_digcut((g_rvv38t*g_rvw[l_ac].rvw10),t_azi04)/(1+g_head_1.rvw04/100)   #MOD-AC0024
#                  END IF
#                 #-MOD-A80052-end-
#                  #未稅金額=(含稅單價*數量)/(1+稅率/100)
#                 #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)   #MOD-A80052 mark
#               ELSE                     #不含稅
#                  #未稅金額=未稅單價*數量
#                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10                  #原幣稅前
#               END IF
#            END IF   #MOD-870285 add
#            IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
#               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
#            END IF
#            IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
#               #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file ",
#               LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
#                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_rvv03_pre5 FROM g_sql
#               EXECUTE sel_rvv03_pre5 INTO l_rvv03
#               IF l_rvv03 = '3' THEN
#                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
#               END IF
#            END IF
#            LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)  #No.MOD-740008   #MOD-AC0024
#            IF g_flag = 'N' THEN                                               #MOD-A80052
#               LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f * g_head_1.rvw04 / 100              #原幣稅額
#               LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)  #MOD-A80052
#            END IF                                                             #MOD-A80052
#           #LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)  #No.MOD-740008   #MOD-AC0024 mark
#           #LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)  #No.MOD-740008 #MOD-A80052 mark
#            LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12 #本幣金額   #MOD-640405                     #MOD-870285
#            IF g_type = '3' AND g_rvw[l_ac].rvw05 > 0 THEN                 #負值顯示
#               LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
#            END IF
#            IF g_type = '2' AND g_rvw[l_ac].rvw05 > 0 THEN
#               IF l_rvv03 = '3' THEN
#                  LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1    #No.TQC-790140
#               END IF
#            END IF
#            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05 * g_head_1.rvw04 / 100                #本幣稅額    rvw04:稅率
#            LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)  #No.MOD-740008
#            LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
#            DISPLAY BY NAME g_rvw[l_ac].rvw05
#            DISPLAY BY NAME g_rvw[l_ac].rvw06
#            DISPLAY BY NAME g_rvw[l_ac].rvw05f
#            DISPLAY BY NAME g_rvw[l_ac].rvw06f
#         END IF
      AFTER FIELD rvw10
         IF cl_null(g_rvw[l_ac].rvw10) THEN
            NEXT FIELD rvw10
         ELSE
            LET g_sql = "SELECT rvu00,rvu116 FROM ",cl_get_target_table(g_plant_new,'rvu_file'),
                        " WHERE rvu01 ='",g_rvw[l_ac].rvw08,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql
		        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
            PREPARE sel_rvu00_pre3 FROM g_sql
            EXECUTE sel_rvu00_pre3 INTO l_rvu00,l_rvu116
            IF l_rvu00 = '3' AND l_rvu116 ='3' THEN
               IF g_rvw[l_ac].rvw10 > 0 THEN
                  LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 *-1
                  NEXT FIELD rvw10
               END IF
            #yinhy131108  --Begin
            ELSE
               IF g_rvw[l_ac].rvw10 = 0 THEN
               	  CALL cl_err(' ','afa-978',0)
               	  NEXT FIELD rvw10
               END IF
            #yinhy131108  --End
            END IF
            IF l_rvu00 = '1' THEN
               IF g_rvw[l_ac].rvw10 < 0 THEN
                  LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 *-1
                  NEXT FIELD rvw10
               END IF
            END IF
            IF g_sma.sma116 MATCHES '[13]' THEN
               LET g_sql = "SELECT rvv87 FROM ",cl_get_target_table(g_plant_new,'rvv_file'),
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql
		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
               PREPARE sel_rvv87_pre FROM g_sql
               EXECUTE sel_rvv87_pre INTO l_rvv17
            ELSE
               LET g_sql = "SELECT rvv17 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvv17_pre FROM g_sql
               EXECUTE sel_rvv17_pre INTO l_rvv17
            END IF
            IF cl_null(l_rvv17) THEN LET l_rvv17 = 0 END IF
            #計算未生成請款的入庫數量
            CALL i140_rvw10()
               IF l_rvu00 MATCHES '[23]' THEN       #No.MOD-870301
                  LET l_rvw10 = g_rvw[l_ac].rvw10 * -1
               END IF
               IF l_rvu00 ='1' THEN
                  LET l_rvw10 = g_rvw[l_ac].rvw10
               END IF
            IF l_rvw10 > l_rvv17 - g_rvw10 THEN              #No.TQC-7B0164
               IF g_type = '1' THEN  #No.TQC-770051
                  CALL cl_err(' ','apm-282',0)
               END IF
               IF g_type = '2' THEN
                  LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                              " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                              "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                  PREPARE sel_rvv03_pre4 FROM g_sql
                  EXECUTE sel_rvv03_pre4 INTO l_rvv03
                  IF l_rvv03 = '1' THEN
                     CALL cl_err(' ','apm-282',0)
                  END IF
                  IF l_rvv03 = '3' THEN
                     CALL cl_err(' ','apm-980',0)
                  END IF
               END IF
               IF g_type = '3' THEN
                  CALL cl_err(' ','apm-980',0)
               END IF
               NEXT FIELD rvw10
            END IF
            IF g_rvw[l_ac].rvw10 <> 0 AND (l_rvw10_t <> g_rvw[l_ac].rvw10            #No.MOD-940412
               OR g_rvw_t.rvw05f <> g_rvw[l_ac].rvw05f) THEN   #No.MOD-910073
               LET g_flag = 'N'                                #MOD-A80052
               LET g_sql = " SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102      #MOD-A80052
                           "  WHERE gec01='",g_head_1.rvw03,"' ",
                           "    AND gec011 = '1'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_gec07_pre1 FROM g_sql
               EXECUTE sel_gec07_pre1 INTO g_gec05,g_gec07     #MOD-A80052
               #不含稅
               #未稅金額=未稅單價*數量
               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10                  #原幣稅前  #MOD-CA0222 mark #yinhy130308
               #LET g_rvw[l_ac].rvw05f = g_rvw17*g_rvw[l_ac].rvw10                  #No.MOD-CA0222  #yinhy130308
            END IF
            IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
               LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvv03_pre5 FROM g_sql
               EXECUTE sel_rvv03_pre5 INTO l_rvv03
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
               END IF
            END IF
            LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)
            LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f * g_head_1.rvw04 / 100              #原幣稅額
            LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
            LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12 #本幣金額   #MOD-640405                     #MOD-870285
            LET g_rvw[l_ac].sum1   = g_rvw[l_ac].rvw05f +g_rvw[l_ac].rvw06f    #FUN-C80027  ADD
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            IF g_type = '3' AND g_rvw[l_ac].rvw05 > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05 > 0 THEN
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1    #No.TQC-790140
               END IF
            END IF
            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05 * g_head_1.rvw04 / 100                #本幣稅額    rvw04:稅率
            LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)  #No.MOD-740008
            LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].rvw05
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].rvw05f
            DISPLAY BY NAME g_rvw[l_ac].rvw06f
            DISPLAY BY NAME g_rvw[l_ac].sum1       #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].sum2       #FUN-C80027  ADD
         END IF
#MOD-B70073--end

      BEFORE FIELD rvw17
         LET l_rvw17_t = g_rvw[l_ac].rvw17
#MOD-B70073--mark--begin
#      AFTER FIELD rvw17
#         IF NOT cl_null(g_rvw[l_ac].rvw17) THEN
#            IF cl_null(g_rvw[l_ac].rvw05f) OR g_rvw[l_ac].rvw05f=0 OR l_rvw17_t <> g_rvw[l_ac].rvw17 THEN    #MOD-870285 add #No.MOD-940412
#               LET g_flag = 'N'          #MOD-A80052
#              #LET g_sql = "SELECT gec07 FROM ",li_dbs CLIPPED,"gec_file ",
#              #LET g_sql = "SELECT gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102           #MOD-A80052 mark
#               LET g_sql = "SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102     #MOD-A80052
#                           " WHERE gec01='",g_head_1.rvw03,"' ",
#                           "   AND gec011='1' "
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#	             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_gec07_pre2 FROM g_sql
#              #EXECUTE sel_gec07_pre2 INTO g_gec07                            #MOD-A80052 mark
#               EXECUTE sel_gec07_pre2 INTO g_gec05,g_gec07                    #MOD-A80052
#               IF g_gec07 = 'Y' THEN    #含稅
#                  LET g_rvv38t = 0
#                  #LET g_sql = "SELECT rvv38t,rvv39,rvv39t FROM ",li_dbs CLIPPED,"rvv_file,",   #MOD-9C0061 add rvv39,rvv39t
#                  #                                  li_dbs CLIPPED,"rvu_file ",
#                  LET g_sql = "SELECT rvv38t,rvv39,rvv39t FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
#                                                                 cl_get_target_table(g_plant_new,'rvu_file'),     #FUN-A50102
#                              " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                              "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
#                              "   AND rvv01 = rvu01 "
#                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#                  PREPARE sel_rvv38t_pre2 FROM g_sql
#                  EXECUTE sel_rvv38t_pre2 INTO g_rvv38t,g_rvv39,g_rvv39t       #MOD-9C0061 add rvv39,rvv39t
#                  #未稅金額=(含稅單價*數量)/(1+稅率/100)
#                  IF g_rvw[l_ac].rvw10 <> 0 THEN
#                    #-MOD-A80052-add-
#                     IF g_gec05 = 'T' THEN
#                        LET g_rvw05f = g_rvv38t*g_rvw[l_ac].rvw10
#                        LET g_rvw05f = cl_digcut(g_rvw05f,t_azi04)
#                        LET g_rvw[l_ac].rvw06f = g_rvw05f * (g_head_1.rvw04/100)
#                        LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
#                        LET g_rvw[l_ac].rvw05f = g_rvw05f - g_rvw[l_ac].rvw06f
#                        LET g_flag = 'Y'
#                     ELSE
#                       #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)   #MOD-AC0024
#                        LET g_rvw[l_ac].rvw05f = cl_digcut((g_rvv38t*g_rvw[l_ac].rvw10),t_azi04)/(1+g_head_1.rvw04/100)   #MOD-AC0024
#                     END IF
#                    #-MOD-A80052-end-
#                    #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)   #MOD-A80052 mark
#                  ELSE
#                     LET g_rvw[l_ac].rvw05f = g_rvv39t/(1+g_head_1.rvw04/100)
#                  END IF
#               ELSE                     #不含稅
#                  #未稅金額=未稅單價*數量
#                  IF g_rvw[l_ac].rvw10 <> 0 THEN
#                     LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10                  #原幣稅前
#                  ELSE
#                     LET g_rvw[l_ac].rvw05f = g_rvv39
#                  END IF
#               END IF
#            END IF   #MOD-870285 add
#            IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
#               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
#            END IF
#            IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
#               #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file ",
#               LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
#                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
#                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
#		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
#               PREPARE sel_rvv03_pre6 FROM g_sql
#               EXECUTE sel_rvv03_pre6 INTO l_rvv03
#               IF l_rvv03 = '3' THEN
#                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
#               END IF
#            END IF
#            LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)  #No.MOD-740008   #MOD-AC0024
#            IF g_flag = 'N' THEN                                               #MOD-A80052
#               LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f * g_head_1.rvw04 / 100              #原幣稅額
#               LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)  #MOD-A80052
#            END IF                                                             #MOD-A80052
#           #LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)  #No.MOD-740008   #MOD-AC0024 mark
#           #LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)  #No.MOD-740008       #MOD-A80052 mark
#            LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12 #本幣金額   #MOD-640405                    #MOD-870285
#            IF g_type = '3' AND g_rvw[l_ac].rvw05 > 0 THEN                 #負值顯示
#               LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
#            END IF
#            IF g_type = '2' AND g_rvw[l_ac].rvw05 > 0 THEN
#               IF l_rvv03 = '3' THEN
#                  LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1    #No.TQC-790140
#               END IF
#            END IF
#            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05 * g_head_1.rvw04 / 100                #本幣稅額    rvw04:稅率
#            LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)  #No.MOD-740008
#            LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
#            DISPLAY BY NAME g_rvw[l_ac].rvw05
#            DISPLAY BY NAME g_rvw[l_ac].rvw06
#            DISPLAY BY NAME g_rvw[l_ac].rvw05f
#            DISPLAY BY NAME g_rvw[l_ac].rvw06f
#         END IF
#MOD-B70073--mark--end
      #MOD-B70073--add--begin
      AFTER FIELD rvw17
         IF NOT cl_null(g_rvw[l_ac].rvw17) THEN
            IF cl_null(g_rvw[l_ac].rvw05f) OR g_rvw[l_ac].rvw05f=0 OR l_rvw17_t <> g_rvw[l_ac].rvw17 THEN
               LET g_flag = 'N'
               LET g_sql = "SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'),
                           " WHERE gec01='",g_head_1.rvw03,"' ",
                           "   AND gec011='1' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql
	             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
               PREPARE sel_gec07_pre2 FROM g_sql
               EXECUTE sel_gec07_pre2 INTO g_gec05,g_gec07
               #IF g_gec07 = 'Y' THEN    #含稅
               #   IF g_gec05 = 'T' THEN
               #      LET g_rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10
               #      LET g_rvw05f = cl_digcut(g_rvw05f,t_azi04)
               #      LET g_rvw[l_ac].rvw06f = g_rvw05f * (g_head_1.rvw04/100)
               #      LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
               #      LET g_rvw[l_ac].rvw05f = g_rvw05f - g_rvw[l_ac].rvw06f
               #      LET g_flag = 'Y'
               #    ELSE
               #      LET g_rvw[l_ac].rvw05f = cl_digcut((g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10),t_azi04)/(1+g_head_1.rvw04/100)
               #    END IF
               #ELSE                     #不含稅
               #   #未稅金額=未稅單價*數量
               #   LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10                  #原幣稅
               #END IF
               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10      #MOD-CA0222 mark   #yinhy130308
               #LET g_rvw[l_ac].rvw05f = g_rvw17*g_rvw[l_ac].rvw10                 #MOD-CA0222   #yinhy130308 mark
            END IF
            IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
               LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql
		           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
               PREPARE sel_rvv03_pre6 FROM g_sql
               EXECUTE sel_rvv03_pre6 INTO l_rvv03
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
               END IF
            END IF
            LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)
            LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12 #本幣金額   #MOD-640405                    #MOD-870285
            IF g_type = '3' AND g_rvw[l_ac].rvw05 > 0 THEN                 #負值顯示
               LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
            END IF
            IF g_type = '2' AND g_rvw[l_ac].rvw05 > 0 THEN
               IF l_rvv03 = '3' THEN
                  LET g_rvw[l_ac].rvw05 = g_rvw[l_ac].rvw05 * -1
               END IF
            END IF
            LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f * (g_head_1.rvw04/100)
            LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05 * g_head_1.rvw04 / 100                #本幣稅額    rvw04:稅率
            LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)
            LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
            LET g_rvw[l_ac].sum1   = g_rvw[l_ac].rvw05f +g_rvw[l_ac].rvw06f    #FUN-C80027  ADD
            LET g_rvw[l_ac].sum2   = g_rvw[l_ac].rvw05  +g_rvw[l_ac].rvw06     #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].rvw05
            DISPLAY BY NAME g_rvw[l_ac].rvw06
            DISPLAY BY NAME g_rvw[l_ac].rvw05f
            DISPLAY BY NAME g_rvw[l_ac].rvw06f
            DISPLAY BY NAME g_rvw[l_ac].sum1      #FUN-C80027  ADD
            DISPLAY BY NAME g_rvw[l_ac].sum2      #FUN-C80027  ADD
         END IF
      #MOD-B70073--end
      BEFORE DELETE                          #是否取消單身
         IF NOT cl_null(g_rvw_t.rvw09) AND NOT cl_null(g_rvw_t.rvw08)THEN
            SELECT COUNT(*) INTO l_cnt
              FROM apb_file,apa_file,apk_file
             WHERE apb01 = apa01
               AND apa01 = apk01
               AND apa08 <> 'UNAP'
               AND apa00 = '11'
               AND apb21 = g_rvw_t.rvw08
               AND apb22 = g_rvw_t.rvw09
               AND apk03 = g_head_1.rvw01
           #str MOD-A20066 add
            #檢查發票是否存在退貨折讓帳款裡
            IF l_cnt = 0 THEN
               SELECT COUNT(*) INTO l_cnt
                 FROM apb_file,apa_file
                WHERE apb01 = apa01
                  AND apa00 = '21'
                  AND apb21 = g_rvw_t.rvw08
                  AND apb22 = g_rvw_t.rvw09
                  AND apb11 = g_head_1.rvw01
#                  AND apk28 = g_head_1.rvw07                  #CHI-B30082 add
            END IF
           #end MOD-A20066 add
            IF l_cnt > 0 THEN
               CALL cl_err('','apm-241',0)
               CANCEL DELETE
            END IF
         END IF
         IF NOT cl_null(g_rvw_t.rvw09) AND NOT cl_null(g_rvw_t.rvw08)THEN
            IF NOT cl_delb(0,0) THEN
               CANCEL DELETE
            END IF
            IF l_lock_sw = "Y" THEN
               CALL cl_err("", -263, 1)
               CANCEL DELETE
            END IF
            DELETE FROM rvw_file WHERE rvw08 = g_rvw_t.rvw08
                                AND rvw09 = g_rvw_t.rvw09
                                   AND rvw01 = g_head_1.rvw01
            IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
               CALL cl_err3("del","rvw_file",g_rvw_t.rvw08,g_rvw_t.rvw09,SQLCA.sqlcode,"","",1)  #No.FUN-660071
               ROLLBACK WORK
               CANCEL DELETE
            ELSE
               MESSAGE 'DELETE O.K'
               COMMIT WORK
               LET g_rec_b=g_rec_b-1
               DISPLAY g_rec_b TO FORMONLY.cn2
            END IF

            SELECT COUNT(rvw01) INTO l1_n FROM rvw_file
             WHERE rvw08 = g_rvw_t.rvw08
               AND rvw09 = g_rvw_t.rvw09
            IF l1_n < 2 THEN
               #LET g_sql = "SELECT rvv04,rvv05 FROM ",li_dbs CLIPPED,"rvv_file ",
               LET g_sql = "SELECT rvv04,rvv05 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                           " WHERE rvv01 = '",g_rvw_t.rvw08,"' ",
                           "   AND rvv02 = '",g_rvw_t.rvw09,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvv04_pre FROM g_sql
               EXECUTE sel_rvv04_pre INTO l_rvv04,l_rvv05
               IF l1_n = 1 THEN
                  SELECT rvw01 INTO l_rvw01 FROM rvw_file
                   WHERE rvw08 = g_rvw_t.rvw08
                     AND rvw09 = g_rvw_t.rvw09
                  IF NOT cl_null(l_rvv04) THEN  #No.TQC-7B0114
                     #LET g_sql = "UPDATE ",li_dbs CLIPPED,"rvb_file",
                     LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'rvb_file'), #FUN-A50102
                                 "   SET rvb22 = '",l_rvw01,"' ",
                                 " WHERE rvb01 = '",l_rvv04,"' ",
                                 "   AND rvb02 = '",l_rvv05,"' "
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                     PREPARE upd_rvb_pre FROM g_sql
                     EXECUTE upd_rvb_pre
                     IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                        CALL cl_err3("upd","rvb_file",l_rvv04,l_rvv05,STATUS,"","del upd rvb",1)  #No.FUN-660071
                     END IF
                  END IF
               ELSE
                  IF NOT cl_null(l_rvv04) THEN  #No.TQC-7B0114
                     #LET g_sql = "UPDATE ",li_dbs CLIPPED,"rvb_file ",
                     LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'rvb_file'), #FUN-A50102
                                 "   SET rvb22 = NULL",
                                 " WHERE rvb01 = '",l_rvv04,"' ",
                                 "   AND rvb02 = '",l_rvv05,"' "
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                     PREPARE upd_rvb22_pre FROM g_sql
                     EXECUTE upd_rvb22_pre
                     IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                        CALL cl_err3("upd","rvb_file",l_rvv04,l_rvv05,STATUS,"","del upd rvb",1)  #No.FUN-660071
                     END IF
                  END IF
               END IF
            END IF
            SELECT SUM(rvw05f),SUM(rvw06f)
              INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
              FROM rvw_file WHERE rvw01=g_head_1.rvw01
            IF cl_null(g_head_1.rvw05f_sum) THEN LET g_head_1.rvw05f_sum = 0 END IF
            IF cl_null(g_head_1.rvw06f_sum) THEN LET g_head_1.rvw06f_sum = 0 END IF
            LET g_head_1.rvw06f_s = g_head_1.rvw06f_sum
            LET g_head_1.rvw05f_s = g_head_1.rvw05f_sum                    #FUN-C80027
            LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum      #FUN-C80027
            DISPLAY BY NAME g_head_1.rvw05f_s                              #FUN-C80027
            DISPLAY BY NAME g_head_1.rvw06f_s
            DISPLAY BY NAME g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
            DISPLAY BY NAME g_head_1.sum3                                   #FUN-C80027

            #FUN-C80027---ADD--STR
            SELECT SUM(rvw05),SUM(rvw06)
              INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
              FROM rvw_file WHERE rvw01=g_head_1.rvw01
            IF cl_null(g_head_1.rvw05_sum) THEN LET g_head_1.rvw05_sum = 0 END IF
            IF cl_null(g_head_1.rvw06_sum) THEN LET g_head_1.rvw06_sum = 0 END IF
            DISPLAY BY NAME g_head_1.rvw05_sum,g_head_1.rvw06_sum
            LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
            DISPLAY BY NAME g_head_1.sum4
            #FUN-C80027---ADD--END

         END IF

      ON ROW CHANGE
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            LET g_rvw[l_ac].* = g_rvw_t.*
            CLOSE i140_bcl
            ROLLBACK WORK
            EXIT INPUT
         END IF
         IF l_lock_sw = 'Y' THEN
            CALL cl_err(g_rvw[l_ac].rvw08,-263,1)
            LET g_rvw[l_ac].* = g_rvw_t.*
         ELSE
            SELECT COUNT(*) INTO l_cnt
              FROM apb_file,apa_file,apk_file
             WHERE apb01 = apa01
               AND apa01 = apk01
               AND apa08 <> 'UNAP'
               AND apa00 = '11'
               AND apb21 = g_rvw_t.rvw08
               AND apb22 = g_rvw_t.rvw09
               AND apk03 = g_head_1.rvw01
           #str MOD-A20066 add
            #檢查發票是否存在退貨折讓帳款裡
            IF l_cnt = 0 THEN
               SELECT COUNT(*) INTO l_cnt
                 FROM apb_file,apa_file
                WHERE apb01 = apa01
                  AND apa00 = '21'
                  AND apb21 = g_rvw_t.rvw08
                  AND apb22 = g_rvw_t.rvw09
                  AND apb11 = g_head_1.rvw01
#                  AND apk28 = g_head_1.rvw07                  #CHI-B30082 add
            END IF
           #end MOD-A20066 add
            IF l_cnt >0 THEN
               CALL cl_err(g_rvw[l_ac].rvw08,'apm-241',1)
               LET g_rvw[l_ac].* = g_rvw_t.*
            ELSE
               IF g_rvw[l_ac].rvw08 != g_rvw_t.rvw08 OR
                  g_rvw[l_ac].rvw09 != g_rvw_t.rvw09 THEN
                  SELECT COUNT(rvw01) INTO l1_n FROM rvw_file
                   WHERE rvw08 = g_rvw_t.rvw08
                     AND rvw09 = g_rvw_t.rvw09
                     AND rvw01 != g_head_1.rvw01
                  IF l1_n < 2 THEN
                     #LET g_sql = "SELECT rvv04,rvv05 FROM ",li_dbs CLIPPED,"rvv_file ",
                     LET g_sql = "SELECT rvv04,rvv05 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                                 " WHERE rvv01 = '",g_rvw_t.rvw08,"' ",
                                 "   AND rvv02 = '",g_rvw_t.rvw09,"' "
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                     PREPARE sel_rvv04_pre1 FROM g_sql
                     EXECUTE sel_rvv04_pre1 INTO l_rvv04,l_rvv05
                     IF l1_n = 1 THEN
                        SELECT rvw01 INTO l_rvw01 FROM rvw_file
                         WHERE rvw08 = g_rvw_t.rvw08
                           AND rvw09 = g_rvw_t.rvw09
                           AND rvw01 != g_head_1.rvw01
                        IF NOT cl_null(l_rvv04) THEN  #No.TQC-7B0114
                           #LET g_sql = "UPDATE ",li_dbs CLIPPED,"rvb_file ",
                           LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'rvb_file'), #FUN-A50102
                                       "   SET rvb22 = '",l_rvw01,"' ",
                                       " WHERE rvb01 = '",l_rvv04,"' ",
                                       "   AND rvb02 = '",l_rvv05,"' "
                           CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		                   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                           PREPARE upd_rvb22_pre1 FROM g_sql
                           EXECUTE upd_rvb22_pre1
                           IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                              CALL cl_err3("upd","rvb_file",l_rvv04,l_rvv05,STATUS,"","del upd rvb",1)  #No.FUN-660071
                           END IF
                        END IF
                     ELSE
                        IF NOT cl_null(l_rvv04) THEN  #No.TQC-7B0114
                           #LET g_sql = "UPDATE ",li_dbs CLIPPED,"rvb_file ",
                           LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'rvb_file'), #FUN-A50102
                                       "   SET rvb22 = NULL ",
                                       " WHERE rvb01 = '",l_rvv04,"' ",
                                       "   AND rvb02 = '",l_rvv05,"' "
                           CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		                   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
                           PREPARE upd_rvb_pre1 FROM g_sql
                           EXECUTE upd_rvb_pre1
                           IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                              CALL cl_err3("upd","rvb_file",l_rvv04,l_rvv05,STATUS,"","del upd rvb",1)  #No.FUN-660071
                           END IF
                        END IF
                     END IF
                  END IF
               END IF
               UPDATE rvw_file SET rvw05f = g_rvw[l_ac].rvw05f,
                                   rvw06f = g_rvw[l_ac].rvw06f,
                                   rvw05  = g_rvw[l_ac].rvw05,
                                   rvw06  = g_rvw[l_ac].rvw06,
                                   rvw08  = g_rvw[l_ac].rvw08,
                                   rvw09  = g_rvw[l_ac].rvw09,
                                   rvw10  = g_rvw[l_ac].rvw10,
                                   rvw99  = g_rvw[l_ac].rvw99,    #FUN-9C0001
                                   rvw17  = g_rvw[l_ac].rvw17
                             WHERE rvw01  = g_head_1.rvw01
                               AND rvw08  = g_rvw_t.rvw08
                               AND rvw09  = g_rvw_t.rvw09
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                  CALL cl_err3("upd","rvw_file",g_rvw_t.rvw08,g_rvw_t.rvw09,SQLCA.sqlcode,"","",1)  #No.FUN-660071
                  LET g_rvw[l_ac].* = g_rvw_t.*
               ELSE
                  COMMIT WORK
               END IF
            END IF
         END IF

      AFTER ROW
         LET l_ac = ARR_CURR()
        #LET l_ac_t = l_ac      #FUN-D30032 Mark
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
           #LET g_rvw[l_ac].* = g_rvw_t.*   #FUN-D30032 Mark
            #FUN-D30032--add--str--
            IF p_cmd = 'u' THEN
               LET g_rvw[l_ac].* = g_rvw_t.*
            ELSE
               CALL g_rvw.deleteElement(l_ac)
               IF g_rec_b != 0 THEN
                  LET g_action_choice = "detail"
                  LET l_ac = l_ac_t
               END IF
            END IF
            #FUN-D30032--add--end--
            CLOSE i140_bcl
            ROLLBACK WORK
            IF g_type ='2' THEN
               SELECT SUM(rvw05f) INTO l_rvw05f_sum FROM rvw_file WHERE rvw01 =g_head_1.rvw01
               IF l_rvw05f_sum < 0 THEN
                  CALL cl_err('','gap-003',1)
                  NEXT FIELD rvw08
               END IF
            END IF
            EXIT INPUT
         END IF
         LET l_ac_t = l_ac      #FUN-D30032 Add
         CLOSE i140_bcl
         COMMIT WORK
         SELECT SUM(rvw05f),SUM(rvw06f)
           INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
           FROM rvw_file WHERE rvw01=g_head_1.rvw01
         LET g_head_1.rvw06f_s = g_head_1.rvw06f_sum
         DISPLAY BY NAME g_head_1.rvw06f_s
         DISPLAY BY NAME g_head_1.rvw05f_sum,g_head_1.rvw06f_sum

         #FUN-C80027---ADD--STR
          SELECT SUM(rvw05),SUM(rvw06)
            INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
            FROM rvw_file WHERE rvw01=g_head_1.rvw01
          DISPLAY BY NAME g_head_1.rvw05_sum,g_head_1.rvw06_sum
          LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum
          LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
          DISPLAY BY NAME g_head_1.sum3
          DISPLAY BY NAME g_head_1.sum4
          #FUN-C80027---ADD--END

      AFTER INPUT
         IF g_type ='2' THEN
            SELECT SUM(rvw05f) INTO l_rvw05f_sum FROM rvw_file WHERE rvw01 =g_head_1.rvw01
            IF l_rvw05f_sum < 0 THEN
               CALL cl_err('','gap-003',1)
               NEXT FIELD rvw08
            END IF
         END IF
      ON ACTION CONTROLG
         CALL cl_cmdask()
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

      ON ACTION controlp
         CASE
            WHEN INFIELD(rvw99)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_azw"
               LET g_qryparam.where = " azw02 = '",g_legal,"' "
               CALL cl_create_qry() RETURNING g_rvw[l_ac].rvw99
               DISPLAY g_rvw[l_ac].rvw99 TO rvw99
               NEXT FIELD rvw99
            WHEN INFIELD(rvw08)
              CALL q_rvv4(TRUE,TRUE,g_head_1.rvv06,g_rvw[l_ac].rvw08,
                          g_rvw[l_ac].rvw09,g_type,'1',g_head_1.rvw01,g_rvw[l_ac].rvw99)   #FUN-9B0130
                   RETURNING g_qryparam.multiret
              LET l_str=g_qryparam.multiret CLIPPED
              LET tok = base.StringTokenizer.create(l_str,"|")
              IF NOT cl_null(l_str) THEN
                 LET l_i=1
                 WHILE tok.hasMoreTokens()
                    IF l_i mod 2 THEN
                       LET l_rvw08=tok.nextToken()
                       LET l_i=l_i+1
                       CONTINUE WHILE
                    END IF
                    LET l_i=l_i+1
                    LET l_rvw09=tok.nextToken()
                    #*****************
                    #LET l_ac = l_ac + 1    #MOD-890008 add
                    #LET g_rvw[l_ac].rvw99=g_rvw[l_ac-1].rvw99   #FUN-9B0130
                    #LET g_rvw[l_ac].rvw08=l_rvw08
                    #LET g_rvw[l_ac].rvw09=l_rvw09
                    #
                    LET g_rvw[l_ac].rvw08=l_rvw08
                    LET g_rvw[l_ac].rvw09=l_rvw09
                    LET l_ac = l_ac + 1
                    LET g_rvw[l_ac].rvw99=g_rvw[l_ac-1].rvw99

                   # CALL i140_rvw08()
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_rvw[l_ac].rvw08,g_errno,0)
                       CONTINUE WHILE
                    END IF
                   # CALL i140_rvw09()
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_rvw[l_ac].rvw08,g_errno,0)
                       CONTINUE WHILE
                    END IF
                   #str MOD-B50016 add
                   #若為樣品時,金額部份(rvw17,rvw05,rvw05f,rvw06,rvw06f)應帶0
                    LET l_rvv25=""
                    LET g_sql = "SELECT rvv25 FROM ",cl_get_target_table(g_plant_new,'rvv_file'),
                                " WHERE rvv01='",g_rvw[l_ac].rvw08,"' ",
                                "   AND rvv02='",g_rvw[l_ac].rvw09,"' "
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
                    PREPARE sel_rvv25_pre_1 FROM g_sql
                    EXECUTE sel_rvv25_pre_1 INTO l_rvv25
                    IF cl_null(l_rvv25) THEN LET l_rvv25="N" END IF
                    IF l_rvv25="Y" THEN
                       LET g_rvw[l_ac].rvw17 =0
                       LET g_rvw[l_ac].rvw05 =0
                       LET g_rvw[l_ac].rvw05f=0
                       LET g_rvw[l_ac].rvw06 =0
                       LET g_rvw[l_ac].rvw06f=0
                       LET g_rvw[l_ac].sum1  =0     #FUN-C80027
                       LET g_rvw[l_ac].sum2  =0     #FUN-C80027
                    END IF
                   #end MOD-B50016 add
                    INSERT INTO rvw_file(rvw01,rvw02,rvw03,rvw04,rvw07,rvw11,rvw12,
                                         rvwacti,rvwuser,rvwgrup,rvwmodu,rvwdate,rvworiu,rvworig, #FUN-D10064
                                         rvw05f,rvw06f,rvw05,rvw06,rvw08,rvw09,rvw10,rvw17,rvw19,   #No.FUN-CB0053   Add rvw19
                                         rvw99,rvwlegal)       #FUN-9B0130
                                  VALUES(g_head_1.rvw01,g_head_1.rvw02,g_head_1.rvw03,
                                         g_head_1.rvw04,g_head_1.rvw07,g_head_1.rvw11,
                                         g_head_1.rvw12,
                                         g_head_1.rvwacti,g_head_1.rvwuser,g_head_1.rvwgrup, #FUN-D10064
                                         g_head_1.rvwmodu,g_head_1.rvwdate,g_head_1.rvworiu, #FUN-D10064
                                         g_head_1.rvworig, #FUN-D10064
                                         g_rvw[l_ac].rvw05f,g_rvw[l_ac].rvw06f,
                                         g_rvw[l_ac].rvw05,g_rvw[l_ac].rvw06,
                                         g_rvw[l_ac].rvw08,g_rvw[l_ac].rvw09,
                                         g_rvw[l_ac].rvw10,g_rvw[l_ac].rvw17,g_head_1.rvw19,       #No.FUN-CB0053   Add g_head_1.rvw19
                                         g_rvw[l_ac].rvw99,g_legal)      #FUN-9B0130 add
                    IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                       CALL cl_err(g_rvw[l_ac].rvw08,SQLCA.sqlcode,0)
                    END IF
                 END WHILE
                 SELECT SUM(rvw05f),SUM(rvw06f)
                   INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
                   FROM rvw_file WHERE rvw01=g_head_1.rvw01
                 LET g_head_1.rvw06f_s = g_head_1.rvw06f_sum
                 DISPLAY BY NAME g_head_1.rvw06f_s
                 DISPLAY BY NAME g_head_1.rvw05f_sum,g_head_1.rvw06f_sum

                 #FUN-C80027---ADD--STR
                 SELECT SUM(rvw05),SUM(rvw06)
                   INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
                   FROM rvw_file WHERE rvw01=g_head_1.rvw01
                 IF cl_null(g_head_1.rvw05_sum) THEN LET g_head_1.rvw05_sum = 0 END IF
                 IF cl_null(g_head_1.rvw06_sum) THEN LET g_head_1.rvw06_sum = 0 END IF
                 DISPLAY BY NAME g_head_1.rvw05_sum,g_head_1.rvw06_sum
                 LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum
                 LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
                 DISPLAY BY NAME g_head_1.sum3
                 DISPLAY BY NAME g_head_1.sum4
                #FUN-C80027---ADD--END
              END IF
               IF INT_FLAG THEN
                  LET INT_FLAG=0 NEXT FIELD rvw08
               ELSE
                  CALL i140_b_fill('all')    #No.TQC-7B0131
                  CALL i140_b()
                  EXIT INPUT
               END IF

         END CASE

      ON ACTION sel_rvv
         IF cl_null(g_head_1.rvw01) OR cl_null(g_head_1.rvv06) THEN RETURN END IF
         LET l_str=NULL
         CALL q_rvv4(TRUE,TRUE,g_head_1.rvv06,
                     g_rvw[l_ac].rvw08,g_rvw[l_ac].rvw09,g_type,'1',g_head_1.rvw01,g_rvw[l_ac].rvw99)   #FUN-9B0130
              RETURNING g_qryparam.multiret
         LET l_str=g_qryparam.multiret CLIPPED
         LET tok = base.StringTokenizer.create(l_str,"|")
         IF NOT cl_null(l_str) THEN
            LET g_success='Y'
            LET l_i=1
            WHILE tok.hasMoreTokens()
               IF l_i mod 2 THEN
                  LET l_rvw08=tok.nextToken()
                  LET l_i=l_i+1
                  CONTINUE WHILE
               END IF
               LET l_i=l_i+1
               LET l_rvw09=tok.nextToken()
               LET g_rvw[l_ac].rvw08=l_rvw08
               LET g_rvw[l_ac].rvw09=l_rvw09
               CALL i140_ins_rvw()
               IF g_type = '1' OR g_type = '2' THEN   #No.TQC-760013
                  CALL i140_upd_rvb22('b')
               END IF
            END WHILE
            SELECT SUM(rvw05f),SUM(rvw06f)
              INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
              FROM rvw_file WHERE rvw01=g_head_1.rvw01
            LET g_head_1.rvw06f_s = g_head_1.rvw06f_sum
            DISPLAY BY NAME g_head_1.rvw06f_s
            DISPLAY BY NAME g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
            #FUN-C80027---ADD--STR
            SELECT SUM(rvw05),SUM(rvw06)
              INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
              FROM rvw_file WHERE rvw01=g_head_1.rvw01
            IF cl_null(g_head_1.rvw05_sum) THEN LET g_head_1.rvw05_sum = 0 END IF
            IF cl_null(g_head_1.rvw06_sum) THEN LET g_head_1.rvw06_sum = 0 END IF
            DISPLAY BY NAME g_head_1.rvw05_sum,g_head_1.rvw06_sum
            LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum
            LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
            DISPLAY BY NAME g_head_1.sum3
            DISPLAY BY NAME g_head_1.sum4
           #FUN-C80027---ADD--END
            CALL i140_b_fill('all')                               #單身  #No.TQC-7B0131
            EXIT INPUT
         END IF

      ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

   END INPUT
   CALL i140_chk_amt()
   IF NOT cl_null(g_errno) THEN
      CALL cl_err('',g_errno,0)
   END IF
   IF g_type = '1' OR g_type = '2' THEN   #No.TQC-760013
      CALL i140_upd_rvb22('b')
   END IF

   CALL i140_var_process('b')

   CLOSE i140_bcl
   COMMIT WORK
   CALL i140_list_fill()  #FUN-CB0080
END FUNCTION

FUNCTION i140_upd_rvb22(p_cmd)                #更新驗收單發票號碼
   DEFINE p_cmd    LIKE type_file.chr1        #NO FUN-690009 VARCHAR(01)   #b:單身新增 d:刪除
   DEFINE l_rvw    RECORD LIKE rvw_file.*,
          l_guino  LIKE rvw_file.rvw01,
          l_cnt    LIKE type_file.num5,       #NO FUN-690009 SMALLINT
          l_rvv04  LIKE rvv_file.rvv04,
          l_rvv05  LIKE rvv_file.rvv05

   DECLARE i140_curs CURSOR FOR
      SELECT * FROM rvw_file
       WHERE rvw01 = g_head_1.rvw01 ORDER BY rvw08,rvw09
   LET g_success = 'Y'
   FOREACH i140_curs INTO l_rvw.*
      IF STATUS THEN
         CALL cl_err('i140_curs',STATUS,0)
         LET g_success='N'
         EXIT FOREACH
      END IF
      #LET g_sql = "SELECT rvv04,rvv05 FROM ",li_dbs CLIPPED,"rvv_file ",
      LET g_sql = "SELECT rvv04,rvv05 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01='",l_rvw.rvw08,"' ",
                  "   AND rvv02='",l_rvw.rvw09,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvv04_pre4 FROM g_sql
      EXECUTE sel_rvv04_pre4 INTO l_rvv04,l_rvv05
      LET g_sql = "SELECT COUNT(UNIQUE rvw01) FROM rvw_file,",
                  #                                 li_dbs CLIPPED,"rvv_file ",
                                                   cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01 = rvw08 AND rvv02 = rvw09 ",
                  "   AND rvv04 = '",l_rvv04,"' AND rvv05='",l_rvv05,"' ",
                  "   AND rvv03 = '1'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvw01_pre FROM g_sql
      EXECUTE sel_rvw01_pre INTO l_cnt
      IF p_cmd = 'b' THEN
         IF l_cnt > 1 THEN
            LET l_guino = 'MISC'
         ELSE
            LET l_guino = l_rvw.rvw01
         END IF
      ELSE
         IF l_cnt > 2 THEN
            LET l_guino = 'MISC'
         END IF
         IF l_cnt = 2 THEN
            LET g_sql = "SELECT rvw01 FROM rvw_file,",
                        #                   li_dbs CLIPPED,"rvv_file ",
                                           cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                        " WHERE rvv01 = rvw08 AND rvv02 = rvw09 ",
                        "   AND rvv04 = '",l_rvv04,"' AND rvv05='",l_rvv05,"' ",
                        "   AND rvv03 = '1' ",
                        "   AND rvw01 != '",l_rvw.rvw01,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvw01_pre1 FROM g_sql
            EXECUTE sel_rvw01_pre1 INTO l_guino
         END IF
         IF l_cnt =1 THEN
            LET l_guino = " "
         END IF
      END IF
      IF NOT cl_null(l_rvv04) THEN  #No.TQC-7B0114
         #LET g_sql = "UPDATE ",li_dbs CLIPPED,"rvb_file ",
         LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'rvb_file'), #FUN-A50102
                     "   SET rvb22 = '",l_guino,"' ",
                     " WHERE rvb01 = '",l_rvv04,"' ",
                     "   AND rvb02 = '",l_rvv05,"' "
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
         PREPARE upd_rvb_pre2 FROM g_sql
         EXECUTE upd_rvb_pre2
         IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
            CALL cl_err3("upd","rvb_file",l_rvv04,l_rvv05,STATUS,"","upd rvb",1)  #No.FUN-660071
            LET g_success='N' EXIT FOREACH
         END IF
      END IF  #No.TQC-7B0114
   END FOREACH
END FUNCTION

FUNCTION i140_rvw08()
   DEFINE l_n       LIKE type_file.num5,         #NO FUN-690009 SMALLINT
          l_rvv06   LIKE rvv_file.rvv06
   DEFINE l_rvuconf LIKE rvu_file.rvuconf        #No.TQC-920081
#No.MOD-A20009 --begin
   DEFINE l_year    LIKE type_file.num5
   DEFINE l_month   LIKE type_file.num5
#No.MOD-A20009 --end
   DEFINE l_rvu21   LIKE rvu_file.rvu21           #NO.TQC-BB0163
   DEFINE l_rvv31   LIKE rvv_file.rvv31  #FUN-D70021

   LET g_errno = ''
   #LET g_sql = "SELECT UNIQUE rvv06 FROM ",li_dbs CLIPPED,"rvv_file ",
   LET g_sql = "SELECT UNIQUE rvv06 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
               " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' "
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
   PREPARE sel_rvv06_pre FROM g_sql
   EXECUTE sel_rvv06_pre INTO l_rvv06
   IF STATUS THEN
      LET g_errno = 'asf-700'
      RETURN
   END IF
   IF l_rvv06 != g_head_1.rvv06 THEN
      LET g_errno = 'tis-205'
      RETURN
   END IF
 #LET g_sql = "SELECT rvuconf FROM ",li_dbs CLIPPED,"rvu_file ",
 LET g_sql = "SELECT rvu21,rvuconf FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102  #TQC-BB0163 add rvu21
             " WHERE rvu01 = '",g_rvw[l_ac].rvw08,"' "
 CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
 PREPARE sel_rvuconf_pre FROM g_sql
 EXECUTE sel_rvuconf_pre INTO l_rvu21,l_rvuconf  #TQC-BB0163 add rvu21

   IF l_rvuconf != 'Y' THEN
      LET g_errno = 'anm-960'
      RETURN
   END IF
   #No.TQC-BB0163  --Begin
   IF l_rvu21 = '2' OR l_rvu21 = '3' OR l_rvu21='4' THEN
      LET g_errno = 'gap-006'
      RETURN
   END IF
   #No.TQC-BB0163  --End
#No.MOD-A20009 --begin
  #FUN-A60056--mod--str--
  #SELECT YEAR(rvu03),MONTH(rvu03) INTO l_year,l_month
  #  FROM rvu_file
  # WHERE rvu01 = g_rvw[l_ac].rvw08

  #FUN-D70021--add--str--
  IF NOT cl_null(g_rvw[l_ac].rvw09) THEN
     SELECT rvv31 INTO l_rvv31 FROM rvv_file
      WHERE rvv01=g_rvw[l_ac].rvw08 AND rvv02=g_rvw[l_ac].rvw09
     IF l_rvv31[1,4] != 'MISC' THEN
  #FUN-D70021--add--end
   LET g_sql = "SELECT YEAR(rvu03),MONTH(rvu03) ",
               "  FROM ",cl_get_target_table(g_rvw[l_ac].rvw99,'rvu_file'),
               " WHERE rvu01 = '",g_rvw[l_ac].rvw08,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_rvw[l_ac].rvw99) RETURNING g_sql
   PREPARE sel_y_rvu03 FROM g_sql
   EXECUTE sel_y_rvu03 INTO l_year,l_month
  #FUN-A60056--mod--end
   IF l_year <> YEAR(g_head_1.rvw02) OR
      l_month <> MONTH(g_head_1.rvw02) THEN
      LET l_n = 0
      SELECT COUNT(apa01) INTO l_n FROM apb_file,apa_file
       WHERE apb21 = g_rvw[l_ac].rvw08
         AND apb01 = apa01
         AND apb22 = g_rvw[l_ac].rvw09  #FUN-D70021
        #AND apa00 ='16'             #MOD-A40045 mark
         AND apa00 IN ('16','26')    #MOD-A40045
         AND YEAR(apa02) = l_year
         AND MONTH(apa02) = l_month
      IF l_n = 0 THEN
         LET g_errno = 'gap-145'
         RETURN
      END IF
      END IF #FUN-D70021
   END IF    #FUN-D70021
   END IF
#No.MOD-A20009 --end
END FUNCTION

#--------------MOD-C90185------------(S)
FUNCTION i140_pmm02(p_pmm01)
   DEFINE p_pmm01  LIKE pmm_file.pmm01
   DEFINE l_poz01  LIKE poz_file.poz01
   DEFINE l_poz18  LIKE poz_file.poz18
   DEFINE l_poz19  LIKE poz_file.poz19
   DEFINE l_n      LIKE type_file.num5

   LET g_errno = ''
   LET g_sql = "SELECT poz01,poz18,poz19 ",
               "  FROM ",cl_get_target_table(g_plant_new,'pmm_file'),",",
                         cl_get_target_table(g_plant_new,'poz_file'),
               " WHERE pmm904 = poz01 ",
               "   AND pmm01  = '",p_pmm01,"' ",
               "   AND pmm901 = 'Y' ",
               "   AND pmm905 = 'Y' "
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_poz01_pre FROM g_sql
   EXECUTE sel_poz01_pre INTO l_poz01,l_poz18,l_poz19

   LET l_n = 0
   IF l_poz19 = 'Y'  AND g_plant_new = l_poz18 THEN    #已設立中斷點
       LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'poy_file'),
                   " WHERE poy01 = '",l_poz01,"' ",
                   "   AND poy04 = '",l_poz18,"' "
       CALL cl_replace_sqldb(g_sql) RETURNING g_sql
       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
       PREPARE sel_cou_poy FROM g_sql
       EXECUTE sel_cou_poy INTO l_n
       IF l_n = 0 THEN
          LET g_errno = 'axr-080'
          RETURN
       END IF
   END IF

END FUNCTION
#--------------MOD-C90185------------(E)

FUNCTION i140_rvw09()
   DEFINE g_rvw11  LIKE rvw_file.rvw11,
          g_rvw12  LIKE rvw_file.rvw12,   #MOD-640405
          g_rvw03  LIKE rvw_file.rvw03,
          g_rvw04  LIKE rvw_file.rvw04,
          g_rvb22  LIKE rvb_file.rvb22,
          l_rvu12  LIKE rvu_file.rvu12
   DEFINE l_cnt    LIKE type_file.num5    #NO FUN-690009 SMALLINT
   DEFINE l_rvv03  LIKE rvv_file.rvv03    #No.TQC-760013
   DEFINE l_rvu00  LIKE rvu_file.rvu00    #No.TQC-7B0164
   DEFINE l_rvv04  LIKE rvv_file.rvv04    #No.FUN-940083
   DEFINE l_rvv36  LIKE rvv_file.rvv36    #No.FUN-940083
   DEFINE l_rvu116 LIKE rvu_file.rvu116   #No.fun-940083
#No.MOD-C60217 --begin
   DEFINE l_rvv32  LIKE rvv_file.rvv32
   DEFINE l_rvv33  LIKE rvv_file.rvv33
   DEFINE l_ime12  LIKE ime_file.ime12
#No.MOD-C60217 --end
   DEFINE l_pmm20  LIKE pmm_file.pmm20    #CHI-CC0038
   DEFINE t_pmm20  LIKE pmm_file.pmm20    #CHI-CC0038
   DEFINE l_year   LIKE type_file.num5   #FUN-D70021
   DEFINE l_month  LIKE type_file.num5   #FUN-D70021
   DEFINE l_rvv31  LIKE rvv_file.rvv31   #FUN-D70021
   DEFINE l_rvw10  LIKE rvw_file.rvw10   #yinhy130917
   DEFINE l_rvw05  LIKE rvw_file.rvw05   #yinhy130917
   DEFINE l_rvw05f LIKE rvw_file.rvw05f  #yinhy130917

   LET g_errno = ''

   LET g_rvv38t = 0   #CHI-980038 add

   #不能重復
   SELECT COUNT(*) INTO l_cnt FROM rvw_file
    WHERE rvw08 = g_rvw[l_ac].rvw08
      AND rvw09 = g_rvw[l_ac].rvw09
      AND rvw01 = g_head_1.rvw01
   IF l_cnt>0 THEN
      LET g_errno = 'tis-201'
      RETURN
   END IF

   #NO.yinhy130917  --Begin
   SELECT COUNT(*) INTO l_cnt FROM rvw_file
    WHERE rvw08 = g_rvw[l_ac].rvw08
      AND rvw09 = g_rvw[l_ac].rvw09
      AND rvw01 <> g_head_1.rvw01
      AND rvw18 IS NULL
   IF l_cnt>0 THEN
   	  SELECT ABS(SUM(rvw10)),SUM(rvw05),SUM(rvw05f) INTO l_rvw10,l_rvw05,l_rvw05f
    	  FROM rvw_file
       WHERE rvw08 = g_rvw[l_ac].rvw08
         AND rvw09 = g_rvw[l_ac].rvw09
         AND rvw01 <> g_head_1.rvw01
         AND rvw18 IS NULL
      IF cl_null(l_rvw10) THEN LET l_rvw10 = 0 END IF
      IF cl_null(l_rvw05) THEN LET l_rvw05 = 0 END IF
      IF cl_null(l_rvw05f) THEN LET l_rvw05f = 0 END IF
   END IF
   #NO.yinhy130917  --End

   #FUN-D70021--add--str--
   IF NOT cl_null(g_rvw[l_ac].rvw08) THEN
      SELECT rvv31 INTO l_rvv31 FROM rvv_file
       WHERE rvv01=g_rvw[l_ac].rvw08 AND rvv02=g_rvw[l_ac].rvw09
      IF l_rvv31[1,4] != 'MISC' THEN
         LET g_sql = "SELECT YEAR(rvu03),MONTH(rvu03) ",
                     "  FROM ",cl_get_target_table(g_rvw[l_ac].rvw99,'rvu_file'),
                     " WHERE rvu01 = '",g_rvw[l_ac].rvw08,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_rvw[l_ac].rvw99) RETURNING g_sql
         PREPARE sel_rvw09_rvu03 FROM g_sql
         EXECUTE sel_rvw09_rvu03 INTO l_year,l_month
         IF l_year <> YEAR(g_head_1.rvw02) OR
            l_month <> MONTH(g_head_1.rvw02) THEN
            SELECT COUNT(apa01) INTO l_cnt FROM apb_file,apa_file
             WHERE apb21 = g_rvw[l_ac].rvw08
              AND apb01 = apa01
              AND apb22 = g_rvw[l_ac].rvw09
              AND apa00 IN ('16','26')
              AND YEAR(apa02) = l_year
              AND MONTH(apa02) = l_month
            IF l_cnt = 0 THEN
               LET g_errno = 'gap-145'
               RETURN
            END IF
         END IF
      END IF
   END IF
   #FUN-D70021--add--end
   #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file ",
   LET g_sql = "SELECT rvv03,rvv32,rvv33 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102  #No.MOD-C60217 add rvv32,rvv33
               " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
               "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
   PREPARE sel_rvv03_pre1 FROM g_sql
   EXECUTE sel_rvv03_pre1 INTO l_rvv03,l_rvv32,l_rvv33            #No.MOD-C60217 add rvv32,rvv33
#No.MOD-C60217 --begin
   IF l_rvv33 IS NULL THEN LET l_rvv33 =' ' END IF
   SELECT ime12 INTO l_ime12 FROM ime_file WHERE ime01 = l_rvv32 AND ime02 = l_rvv33
   IF l_ime12 ='1' THEN
   	  LET g_errno ='gap-203'
   	  RETURN
   END IF
#No.MOD-C60217 --end
   IF g_type = '1' OR (g_type = '2' AND l_rvv03 = '1') THEN  #No.TQC-760013
      #LET g_sql = "SELECT rvv04,rvv36 FROM ",li_dbs CLIPPED,"rvv_file ",
      LET g_sql = "SELECT rvv04,rvv36 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                  "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvv04_pre2 FROM g_sql
      EXECUTE sel_rvv04_pre2 INTO l_rvv04,l_rvv36
      IF g_sma.sma116 MATCHES '[13]' THEN
         IF NOT cl_null(l_rvv36) THEN              #FUN-940083--add
            LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv87,",
                        "       gec04,rvv38,pmm20,pmm22,pmm21,",   #CHI-CC0038 add pmm20
                        "       gec05,pmm42,rvb22,",
                        "       rvv39,rvv38t,rvv39t,rvvud02",           #MOD-9C0061 add rvv39t
                        #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                        #          li_dbs CLIPPED,"rvb_file,",li_dbs CLIPPED,"pmm_file,",
                        #          li_dbs CLIPPED,"gec_file",
                        "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'pmm_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                        " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                        "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                        "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                        "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                        "   AND rvb04 = pmm01 AND gec01 = pmm21 ",
                        "   AND gec011= '1'   AND rvv01 = rvu01 ",
                        "   AND rvuconf = 'Y' AND rvu00 = '1' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvu03_pre FROM g_sql
            EXECUTE sel_rvu03_pre INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,g_rvw[l_ac].ima02,
                                       g_rvw[l_ac].rvw10,l_rvu12,g_rvw[l_ac].rvw17,l_pmm20,    #CHI-CC0038 add pmm20
                                       g_rvw11,g_rvw03,g_gec05,g_rvw12,g_rvb22,
                                       g_rvw[l_ac].rvw05f,g_rvv38t,g_rvv39t,g_rvw[l_ac].rvvud02       #MOD-9C0061 add rvv39t
            SELECT pja02 INTO g_rvw[l_ac].pja02 FROM pja_file WHERE pja01 = g_rvw[l_ac].rvvud02
         ELSE
            IF NOT cl_null(l_rvv04) THEN
               LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv87,",
                           "       gec04,rvv38,rva113,rva115,",
                           "       gec05,rva114,rvb22,",
                           "       rvv39,rvv38t,rvv39t,rvvud02",          #MOD-9C0061 add rvv39t
                           #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                           #          li_dbs CLIPPED,"rva_file,",li_dbs CLIPPED,"rvb_file,",
                           #          li_dbs CLIPPED,"gec_file",
                           "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                           "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                           "   AND rva01 = rvb01 AND gec01 = rva115",
                           "   AND gec011= '1' AND rvv01 = rvu01 ",
                           "   AND rvuconf = 'Y' AND rvu00 = '1' ",
                           "   AND rvv89 <> 'Y' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvu03_pre1 FROM g_sql
               EXECUTE sel_rvu03_pre1 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                           g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,
                                           l_rvu12,g_rvw[l_ac].rvw17,g_rvw11,g_rvw03,
                                           g_gec05,g_rvw12,g_rvb22,
                                           g_rvw[l_ac].rvw05f,g_rvv38t,g_rvv39t,g_rvw[l_ac].rvvud02     #MOD-9C0061 add rvv39t

            ELSE
               LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv87,",
                           "       gec04,rvv38,rvu113,rvu115,",
                           "       gec05,rvu114,rvb22,rvv39,rvvud02 ",
                           #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                           #          li_dbs CLIPPED,"rva_file,",li_dbs CLIPPED,"rvb_file,",
                           #          li_dbs CLIPPED,"gec_file",
                        #FUN-B50019 --begin
                        #  "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                           "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",",
                                     cl_get_target_table(g_plant_new,'gec_file'),",",
                                     cl_get_target_table(g_plant_new,'rvv_file'),
                        "  LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'rvb_file')," ON rvb_file.rvb01=rvv_file.rvv04 AND rvb_file.rvb02=rvv_file.rvv05 ",
                        "  LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'rva_file')," ON rva_file.rva01=rvv_file.rvv04 ",
                        #FUN-B50019 --end
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                         #FUN-B50019 --begin
                         # "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                         # "   AND rva01 = rvb01 AND gec01 = rvu115",
                           "   AND gec01 = rvu115 ",
                         #FUN-B50019 --end
                           "   AND gec011= '1'   AND rvv01 = rvu01 ",
                           "   AND rvuconf = 'Y' AND rvu00 = '1' ",
                           "   AND rvv89 <> 'Y'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvu03_pre2 FROM g_sql
               EXECUTE sel_rvu03_pre2 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                           g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,
                                           l_rvu12,g_rvw[l_ac].rvw17,g_rvw11,g_rvw03,
                                           g_gec05,g_rvw12,g_rvb22,g_rvw[l_ac].rvw05f,g_rvw[l_ac].rvvud02
            END IF
         END IF
      ELSE
         IF NOT cl_null(l_rvv36) THEN              #FUN-940083--add
            LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv17,",
                        "       gec04,rvv38,pmm20,pmm22,pmm21,",   #CHI-CC0038 add pmm20
                        "       gec05,pmm42,rvb22,rvv39,rvvud02",
                        #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                        #          li_dbs CLIPPED,"rvb_file,",li_dbs CLIPPED,"pmm_file,",
                        #          li_dbs CLIPPED,"gec_file",
                        "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'pmm_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                        " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                        "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                        "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                        "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                        "   AND rvb04 = pmm01 AND gec01 = pmm21 ",
                        "   AND gec011= '1'   AND rvv01 = rvu01 ",
                        "   AND rvuconf = 'Y' AND rvu00 = '1' ",
                        "   AND rvv89 <> 'Y'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvu03_pre3 FROM g_sql
            EXECUTE sel_rvu03_pre3 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                        g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,
                                        l_rvu12,g_rvw[l_ac].rvw17,l_pmm20,g_rvw11,   #CHI-CC0038 add pmm20
                                        g_rvw03,g_gec05,g_rvw12,g_rvb22,g_rvw[l_ac].rvw05f,g_rvw[l_ac].rvvud02
         ELSE
            IF NOT cl_null(l_rvv04) THEN
               LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv17,",
                           "       gec04,rvv38,rva113,rva115,",
                           "       gec05,rva114,rvb22,rvv39,rvvud02 ",
                           #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                           #          li_dbs CLIPPED,"rvb_file,",li_dbs CLIPPED,"rva_file,",
                           #          li_dbs CLIPPED,"gec_file",
                           "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                                     cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                           "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                           "   AND rvb01 = rva01 AND gec01 = rva115",
                           "   AND gec011= '1'   AND rvv01 = rvu01 ",
                           "   AND rvuconf = 'Y' AND rvu00 = '1' ",
                           "   AND rvv89 <> 'Y'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
               PREPARE sel_rvu03_pre4 FROM g_sql
               EXECUTE sel_rvu03_pre4 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                           g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,
                                           l_rvu12,g_rvw[l_ac].rvw17,g_rvw11,g_rvw03,
                                           g_gec05,g_rvw12,g_rvb22,g_rvw[l_ac].rvw05f,g_rvw[l_ac].rvvud02
            ELSE
            LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv17,",
                        "       gec04,rvv38,rvu113,rvu115,",
                        "       gec05,rvu114,rvb22,rvv39,rvvud02 ",
                        #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                        #          li_dbs CLIPPED,"rvb_file,",li_dbs CLIPPED,"rva_file,",
                        #          li_dbs CLIPPED,"gec_file",
                        #FUN-B50019 --begin
                        #  "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'rvb_file'),",", #FUN-A50102
                        #            cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                           "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",",
                                     cl_get_target_table(g_plant_new,'gec_file'),",",
                                     cl_get_target_table(g_plant_new,'rvv_file'),
                        "  LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'rvb_file')," ON rvb_file.rvb01=rvv_file.rvv04 AND rvb_file.rvb02=rvv_file.rvv05 ",
                        "  LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'rva_file')," ON rva_file.rva01=rvv_file.rvv04 ",
                        #FUN-B50019 --end
                           " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvu01 = '",g_rvw[l_ac].rvw08,"' ",
                           "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                         #FUN-B50019 --begin
                         # "   AND rvb01 = rvv04 AND rvb02 = rvv05 ",
                         # "   AND rva01 = rvb01 AND gec01 = rvu115",
                           "   AND gec01 = rvu115 ",
                         #FUN-B50019 --end
                        "   AND gec011= '1'   AND rvv01 = rvu01 ",
                        "   AND rvuconf = 'Y' AND rvu00 = '1'   ",
                        "   AND rvv89 <> 'Y'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_rvu03_pre5 FROM g_sql
            EXECUTE sel_rvu03_pre5 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                        g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,
                                        l_rvu12,g_rvw[l_ac].rvw17,g_rvw11,g_rvw03,
                                        g_gec05,g_rvw12,g_rvb22,g_rvw[l_ac].rvw05f ,g_rvw[l_ac].rvvud02
            END IF
         END IF
      END IF
      LET g_rvw04=l_rvu12
      IF STATUS THEN
         LET g_errno = 'asf-700' RETURN
      END IF
      IF g_rvw03 != g_head_1.rvw03 THEN
         LET g_errno = 'tis-203' RETURN
      END IF
      IF g_rvw11 != g_head_1.rvw11 THEN
    	 LET g_errno = 'tis-204' RETURN
      END IF
   END IF
#  IF g_type = '3' OR (g_type = '2' AND l_rvv03 = '3') THEN     #No.MOD-A70133  mark
      IF g_sma.sma116 MATCHES '[13]' THEN
         LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv87,rvu12,rvv38,rvv39,rvv38t,rvv39t",   #MOD-9C0061 add rvv39t
                     #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file",
                     "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                               cl_get_target_table(g_plant_new,'rvu_file'),     #FUN-A50102
                     " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                     "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                     "   AND rvv01 = rvu01 AND rvuconf != 'X' "  #排除作廢入庫單
#                    "   AND rvu00 = '3' AND rvv89 <> 'Y'"       #只抓退貨單資料     #No.MOD-A70133 mark
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
         PREPARE sel_rvu03_pre6 FROM g_sql
         EXECUTE sel_rvu03_pre6 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,g_rvw[l_ac].ima02,
                                     g_rvw[l_ac].rvw10,l_rvu12,g_rvw[l_ac].rvw17,
                                     g_rvw[l_ac].rvw05f,g_rvv38t,g_rvv39t         #MOD-9C0061 add rvv39t
      ELSE
         LET g_sql = "SELECT rvu03,rvv31,rvv031,rvv17,rvu12,rvv38,rvv39,rvv38t,rvv39t  ",  #MOD-9C0061 add rvv39t
                     #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file",
                     "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                               cl_get_target_table(g_plant_new,'rvu_file'),     #FUN-A50102
                     " WHERE rvv01 = '",g_rvw[l_ac].rvw08,"' ",
                     "   AND rvv02 = '",g_rvw[l_ac].rvw09,"' ",
                     "   AND rvv01 = rvu01 AND rvuconf != 'X' " #排除作廢入庫單
#                    "   AND rvu00 = '3'   AND rvv89 <> 'Y'"    #只抓退貨單資料     #No.MOD-A70133 mark
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
         PREPARE sel_rvu03_pre7 FROM g_sql
         EXECUTE sel_rvu03_pre7 INTO g_rvw[l_ac].rvv09,g_rvw[l_ac].ima01,
                                     g_rvw[l_ac].ima02,g_rvw[l_ac].rvw10,l_rvu12,
                                     g_rvw[l_ac].rvw17,g_rvw[l_ac].rvw05f,g_rvv38t,
                                     g_rvv39t                              #MOD-9C0061 add

      END IF
      IF STATUS THEN
         LET g_errno = 'asf-700' RETURN
      END IF
      #No.CHI-CC0038  --Begin
      IF NOT cl_null(l_pmm20) THEN
         LET g_sql = "SELECT DISTINCT pmm20 ",
                     "  FROM ",cl_get_target_table(g_plant_new,'rvw_file'),",",
                               cl_get_target_table(g_plant_new,'rvv_file'),",",
                               cl_get_target_table(g_plant_new,'pmm_file'),
                      " WHERE rvw01 = '",g_head_1.rvw01,"' ",
                      "   AND rvv01 = rvw08 AND pmm01=rvv36 "
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_pmm20_pre FROM g_sql
         DECLARE pmm20_curs CURSOR FOR sel_pmm20_pre
         FOREACH pmm20_curs INTO t_pmm20
            IF t_pmm20 <> l_pmm20 THEN
               IF NOT cl_confirm('gap-009') THEN
             	    LET g_errno = 'gap-010'
                  EXIT FOREACH
                  RETURN
               END IF
            ELSE
               EXIT FOREACH
            END IF
         END FOREACH
      END IF
      #No.CHI-CC0038  --End
      LET g_rvw04=l_rvu12
      IF cl_null(l_rvu12) THEN LET g_rvw04 = g_head_1.rvw04 END IF
#  END IF                          #No.MOD-A70133  mark

   #計算未生成請款的入庫數量
   CALL i140_rvw10()
  #當異動類別(rvu00)為3.倉退時,有可能只折讓金額而不退數量,
  #所以rvu00='3'時,不做數量(rvw10)的管控
   #LET g_sql = "SELECT rvu00,rvu116 FROM ",li_dbs CLIPPED,"rvu_file ",
   LET g_sql = "SELECT rvu00,rvu116 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102
               " WHERE rvu01 ='",g_rvw[l_ac].rvw08,"' "
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
   PREPARE sel_rvu00_pre FROM g_sql
   EXECUTE sel_rvu00_pre INTO l_rvu00,l_rvu116
   IF l_rvu00 != '3' OR l_rvu116 != '3' THEN                  #FUN-940083--add rvu116
      IF g_rvw[l_ac].rvw10 = 0 THEN
         LET g_errno = 'aim-120' RETURN
      END IF
   END IF   #MOD-870285 add
   LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 - g_rvw10
   IF l_rvu00 = '3' THEN
      LET g_rvw[l_ac].rvw10 = g_rvw[l_ac].rvw10 * -1
      #CHI-C80003  --Begin
      SELECT COUNT(*) INTO l_cnt FROM apb_file,apa_file
       WHERE apb21 = g_rvw[l_ac].rvw08
         AND apb22 = g_rvw[l_ac].rvw09
         AND apb37 = g_rvw[l_ac].rvw99
         AND apa00 <> '26'
         AND apa01 = apb01
      IF l_cnt > 0 THEN
         LET g_errno = 'aap-348'
         RETURN
      END IF
     #CHI-C80003  --End

   END IF

   #No.yinhy130917  --Begin
   IF g_rvw[l_ac].rvw10 = 0 AND g_rvw[l_ac].rvw05f - l_rvw05f = 0 THEN
   	  LET g_errno = 'aap-034'
      RETURN
   END IF
   #No.yinhy130917  --End

   IF cl_null(g_rvw12) THEN                              #rvw12匯率   #MOD-640405
      CALL s_curr2(g_head_1.rvw11,g_head_1.rvw02,g_apz.apz33,g_rvw[l_ac].rvw99)     #FUN-9B0130
      RETURNING g_rvw12   #MOD-640405
   END IF

   LET g_flag = 'N'          #MOD-A80052
   IF cl_null(g_rvw[l_ac].rvw05f) OR g_rvw[l_ac].rvw05f=0 OR (NOT cl_null(g_rvw[l_ac].rvw10)) THEN    #No.MOD-920384 add  #No.MOD-940412
     #LET g_sql = "SELECT gec07 FROM ",li_dbs CLIPPED,"gec_file ",
     #LET g_sql = "SELECT gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102           #MOD-A80052 mark
      LET g_sql = "SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102     #MOD-A80052
                  " WHERE gec01='",g_head_1.rvw03,"' ",
                  "   AND gec011='1'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_gec07_pre FROM g_sql
     #EXECUTE sel_gec07_pre INTO g_gec07                             #MOD-A80052 mark
      EXECUTE sel_gec07_pre INTO g_gec05,g_gec07                     #MOD-A80052
      IF g_gec07 = 'Y' THEN    #含稅
         #未稅金額=(含稅單價*數量)/(1+稅率/100)
         IF g_rvw[l_ac].rvw10 <> 0 THEN
           #-MOD-A80052-add-
            IF g_gec05 = 'T' THEN
               LET g_rvw05f = g_rvv38t*g_rvw[l_ac].rvw10
               LET g_rvw05f = cl_digcut(g_rvw05f,t_azi04)
               LET g_rvw[l_ac].rvw06f = g_rvw05f * (g_head_1.rvw04/100)
               LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)
               LET g_rvw[l_ac].rvw05f = g_rvw05f - g_rvw[l_ac].rvw06f
               LET g_flag = 'Y'
            ELSE
              #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)      #MOD-AC0024
               LET g_rvw[l_ac].rvw05f = cl_digcut((g_rvv38t*g_rvw[l_ac].rvw10),t_azi04)/(1+g_head_1.rvw04/100)      #MOD-AC0024
            END IF
           #-MOD-A80052-end-
           #LET g_rvw[l_ac].rvw05f = (g_rvv38t*g_rvw[l_ac].rvw10)/(1+g_head_1.rvw04/100)   #MOD-A80052 mark
            LET g_rvw[l_ac].rvw17 = g_rvv38t/(1+g_head_1.rvw04/100)             #MOD-AA0093
            LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi03)        #MOD-AA0093

         ELSE
            LET g_rvw[l_ac].rvw05f = g_rvv39t/(1+g_head_1.rvw04/100)
         END IF
      ELSE                     #不含稅
         #未稅金額=未稅單價*數量
         IF g_rvw[l_ac].rvw10 <> 0 THEN
            LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw17*g_rvw[l_ac].rvw10   #原幣金額
         END IF
      END IF
   END IF   #MOD-870285 add
   IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
      LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
   END IF
   IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
      IF l_rvv03 = '3' THEN
         LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
      END IF
   END IF
   LET g_rvw[l_ac].rvw05f = cl_digcut(g_rvw[l_ac].rvw05f,t_azi04)  #No.MOD-740008
   IF g_flag = 'N' THEN                                            #MOD-A80052
      LET g_rvw[l_ac].rvw06f = g_rvw[l_ac].rvw05f*g_rvw04/100        #原幣稅額
      LET g_rvw[l_ac].rvw06f = cl_digcut(g_rvw[l_ac].rvw06f,t_azi04)  #No.MOD-740008
   END IF                                                          #MOD-A80052
   LET g_rvw[l_ac].rvw05  = g_rvw[l_ac].rvw05f*g_head_1.rvw12  #本幣金額   #MOD-640405 #No.MOD-860196
   LET g_rvw[l_ac].rvw05  = cl_digcut(g_rvw[l_ac].rvw05,g_azi04)   #No.MOD-740008
   LET g_rvw[l_ac].rvw06  = g_rvw[l_ac].rvw05*g_rvw04/100                     #本幣稅額    rvw04:稅率
   LET g_rvw[l_ac].rvw06  = cl_digcut(g_rvw[l_ac].rvw06,g_azi04)
   LET g_rvw[l_ac].sum1=g_rvw[l_ac].rvw05f + g_rvw[l_ac].rvw06f      #FUN-C80027
   LET g_rvw[l_ac].sum2=g_rvw[l_ac].rvw05 + g_rvw[l_ac].rvw06         #FUN-C80027
   #LET g_rvw17 = g_rvw[l_ac].rvw17                                 #No.MOD-CA0222  #yinhy130308 mark
  #LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi04)    #No.MOD-CA0222 #MOD-CB0281 mark
   LET g_rvw[l_ac].rvw17 = cl_digcut(g_rvw[l_ac].rvw17,t_azi03)    #MOD-CB0281 add
   DISPLAY BY NAME g_rvw[l_ac].ima01
   DISPLAY BY NAME g_rvw[l_ac].ima02
   DISPLAY BY NAME g_rvw[l_ac].rvv09
   DISPLAY BY NAME g_rvw[l_ac].rvw10
   DISPLAY BY NAME g_rvw[l_ac].rvw17
   DISPLAY BY NAME g_rvw[l_ac].rvw05f
   DISPLAY BY NAME g_rvw[l_ac].rvw06f
   DISPLAY BY NAME g_rvw[l_ac].rvw05
   DISPLAY BY NAME g_rvw[l_ac].rvw06
   DISPLAY BY NAME g_rvw[l_ac].sum1     #FUN-C80027
   DISPLAY BY NAME g_rvw[l_ac].sum2     #FUN-C80027

END FUNCTION

FUNCTION i140_b_askkey()
DEFINE
   l_wc2           LIKE type_file.chr1000,  #NO FUN-690009 VARCHAR(300)
   i               LIKE type_file.num10     #NO FUN-690009 INTEGER
   CONSTRUCT l_wc2 ON rvw08,rvw09,rvw10,rvw05f,rvw06f,sum1,rvw05,rvw06,sum2   #MOD-640405   #FUN-C80027 add--sum1,sum2
                 FROM s_rvw[1].rvw08,s_rvw[1].rvw09,
                      s_rvw[1].rvw10,s_rvw[1].rvw05f,  #MOD-640405
                      s_rvw[1].rvw06f,s_rvw[1].sum1,s_rvw[1].rvw05,s_rvw[1].rvw06,s_rvw[1].sum2  #FUN-C80027 add--sum1,sum2

              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
   END CONSTRUCT
   IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
   CALL i140_b_fill(l_wc2)
END FUNCTION

FUNCTION i140_b_fill(p_wc2)                        #BODY FILL UP
DEFINE
   p_wc2           LIKE type_file.chr1000  #NO FUN-690009 VARCHAR(200)
DEFINE l_n1        LIKE type_file.num5
DEFINE l_n2        LIKE type_file.num5
DEFINE l_rvu00     LIKE rvu_file.rvu00
DEFINE l_sta       LIKE type_file.chr1    #No.TQC-7B0131   #用于判斷是否需要對單據類型進行判斷。
DEFINE l_dbs       LIKE type_file.chr21   #FUN-9B0130
      IF p_wc2 = 'all' THEN
         LET l_sta = 'N'
      ELSE
         LET l_sta = 'Y'
      END IF
      IF cl_null(p_wc2) OR p_wc2 = 'all' THEN
         LET p_wc2 ='1=1'
      END IF
   LET g_sql =
      #   "SELECT rvw99,rvw08,rvw09,'','','',rvw10,rvw17,rvw05f,rvw06f,rvw05,rvw06",   #FUN-9B0130 add rvw99  #FUN-C80027 MARK
          "SELECT rvw99,rvw08,rvw09,'','','','',rvw10,rvw17,rvw05f,rvw06f,'',rvw05,rvw06,'','','' ",      #FUN-C80027   #add '', by dengsy151231   # add '' '' by zhaoxiangb 160324
          "  FROM rvw_file ",    #FUN-9B0130
          " WHERE rvw01 ='",g_head_1.rvw01,"'",      #單頭
          "   AND ",p_wc2 CLIPPED,                 #單身
          " ORDER BY rvw08,rvw09 "
   PREPARE i140_pb FROM g_sql

   IF SQLCA.sqlcode THEN    #No.TQC-790140
      CALL cl_err('i140_pb:',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE rvw_curs CURSOR FOR i140_pb
   CALL g_rvw.clear()
   LET g_cnt=1

   LET l_n1 =0
   LET l_n2 =0
   FOREACH rvw_curs INTO g_rvw[g_cnt].*            #單身 ARRAY 填充
      IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
      LET g_plant_new = g_rvw[g_cnt].rvw99
      CALL s_gettrandbs()
      LET l_dbs = g_dbs_tra

      LET g_rvw[g_cnt].sum1 = g_rvw[g_cnt].rvw05f + g_rvw[g_cnt].rvw06f    #FUN-C80027
      LET g_rvw[g_cnt].sum2 = g_rvw[g_cnt].rvw05 + g_rvw[g_cnt].rvw06      #FUN-C80027

      #LET g_sql = "SELECT rvu00 FROM ",l_dbs CLIPPED,"rvu_file ",
      LET g_sql = "SELECT rvu00,rvu08 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102   #add ,rvu08 by dengsy151231
                  " WHERE rvu01 ='",g_rvw[g_cnt].rvw08,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvu00_pre7 FROM g_sql
      EXECUTE sel_rvu00_pre7 INTO l_rvu00
                                  ,g_rvw[g_cnt].rvu08  #add by dengsy151231

      #LET g_sql = "SELECT rvv31,rvv031 FROM ",l_dbs CLIPPED,"rvv_file ",
      LET g_sql = "SELECT rvv31,rvv031,rvvud02 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01 = '",g_rvw[g_cnt].rvw08,"' ",
                  "   AND rvv02 = '",g_rvw[g_cnt].rvw09,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvv031 FROM g_sql
      EXECUTE sel_rvv031 INTO g_rvw[g_cnt].ima01,g_rvw[g_cnt].ima02,g_rvw[g_cnt].rvvud02
      SELECT pja02 INTO g_rvw[g_cnt].pja02 FROM pja_file WHERE pja01 = g_rvw[g_cnt].rvvud02

      #LET g_sql = "SELECT rvu03,rvu04,rvu05 FROM ",l_dbs CLIPPED,"rvu_file ",
      LET g_sql = "SELECT rvu03,rvu04,rvu05 FROM ",cl_get_target_table(g_plant_new,'rvu_file'), #FUN-A50102
                  " WHERE rvu01 = '",g_rvw[g_cnt].rvw08,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvu03 FROM g_sql
      EXECUTE sel_rvu03 INTO g_rvw[g_cnt].rvv09,g_head_1.rvv06,g_head_1.pmc03
      DISPLAY BY NAME g_head_1.rvv06
      DISPLAY BY NAME g_head_1.pmc03

      IF l_rvu00 ='1' THEN
         LET l_n1 =l_n1+1
      END IF
      IF l_rvu00 ='3' THEN
         LET l_n2 =l_n2+1
      END IF
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   IF l_sta = 'Y' THEN    #No.TQC-7B0131
      IF l_n1 >0 AND l_n2 >0 THEN
         LET g_type ='2'
      END IF
      IF l_n1 >0 AND l_n2 <=0 THEN
         LET g_type ='1'
      END IF
      IF l_n1 <=0 AND l_n2 >0 THEN
         LET g_type ='3'             #No.MOD-7B0150
      END IF
      DISPLAY BY NAME g_type
   END IF     #No.TQC-7B0131
   CALL g_rvw.deleteElement(g_cnt)
   LET g_rec_b=g_cnt - 1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt=0
END FUNCTION

FUNCTION i140_bp(p_ud)
DEFINE
   p_ud            LIKE type_file.chr1       #NO FUN-690009 VARCHAR(1)
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY g_rvw TO s_rvw.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
      BEFORE ROW
         LET l_ac = ARR_CURR()
      #FUN-CB0080--add--str--
      ON ACTION item_list
         LET g_action_choice = ""
         CALL i140_b_menu()
         CALL cl_set_act_visible("accept,cancel", FALSE)
         LET g_action_choice = ""
      #FUN-CB0080--add--end
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION insert
         LET g_action_choice = "insert"
         EXIT DISPLAY
      #add by zhaoxiangb 160120
      ON ACTION output
         LET g_action_choice = "output"
         EXIT DISPLAY
      #end add
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      #依單據輸入發票
      ON ACTION input_invoice_by_no
         LET g_action_choice= "Input_Invoice_By_No"
         EXIT DISPLAY
      #拋轉帳款
      ON ACTION carry_account
         LET g_action_choice= "Carry_Account"
         EXIT DISPLAY
     #No.FUN-CB0048 ---start--- Add
      ON ACTION gen_da
         LET g_action_choice= "gen_da"
         EXIT DISPLAY
     #No.FUN-CB0048 ---end  --- Add
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
      #FUN-D10064--add--str--
      ON ACTION invalid
         LET g_action_choice="invalid"
         EXIT DISPLAY
      #FUN-D10064--add--end

      ON ACTION first
         CALL i140_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)

      ON ACTION previous
         CALL i140_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)

      ON ACTION jump
         CALL i140_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(1)
           END IF

      ON ACTION next
         CALL i140_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)

      ON ACTION last
         CALL i140_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(1)

      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()               #No.FUN-590083
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY

      ON ACTION cancel
             LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document                #No.FUN-6A0009  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
      DISPLAY 'i140_bp OK'
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION i140_chk_amt()
   DEFINE l_rvw08          LIKE rvw_file.rvw08
   DEFINE l_rvw09          LIKE rvw_file.rvw09
   DEFINE l_amt,l_amt2     LIKE rvw_file.rvw05
   DEFINE l_rvv03          LIKE rvv_file.rvv03  #No.TQC-760013

   DECLARE i140_chk_curs CURSOR FOR
   SELECT rvw08,rvw09 ,rvw14
     FROM rvw_file
    WHERE rvw01 = g_head_1.rvw01
    ORDER BY rvw08,rvw09
   IF STATUS THEN CALL cl_err('i140_chk_curs',STATUS,0) RETURN END IF
   LET g_errno = ''

   FOREACH i140_chk_curs INTO l_rvw08,l_rvw09,l_amt
      IF cl_null(l_amt) THEN LET l_amt = 0 END IF
      LET l_rvv03 = NULL
      #LET g_sql = "SELECT rvv03 FROM ",li_dbs CLIPPED,"rvv_file ",
      LET g_sql = "SELECT rvv03 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01 = '",l_rvw08,"' ",
                  "   AND rvv02 = '",l_rvw09,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvv03_pre2 FROM g_sql
      EXECUTE sel_rvv03_pre2 INTO l_rvv03
      IF g_type = '1' OR (g_type = '2' AND l_rvv03 = '1') THEN #No.TQC-760013
         IF g_sma.sma116 MATCHES '[13]' THEN
            #LET g_sql = "SELECT SUM(rvv87*rvv38) FROM ",li_dbs CLIPPED,"rvv_file ",
            LET g_sql = "SELECT SUM(rvv87*rvv38) FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                        " WHERE rvv01 = '",l_rvw08,"' ",
                        "   AND rvv02 = '",l_rvw09,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_srvv87_pre FROM g_sql
            EXECUTE sel_srvv87_pre INTO l_amt2
         ELSE
            #LET g_sql = "SELECT SUM(rvv17*rvv38) FROM ",li_dbs CLIPPED,"rvv_file ",
            LET g_sql = "SELECT SUM(rvv17*rvv38) FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                        " WHERE rvv01 = '",l_rvw08,"' ",
                        "   AND rvv02 = '",l_rvw09,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
            PREPARE sel_srvv17_pre FROM g_sql
            EXECUTE sel_srvv17_pre INTO l_amt2
         END IF
         LET l_amt2= cl_digcut(l_amt2,t_azi04)
      END IF
      IF g_type = '3' OR (g_type = '2' AND l_rvv03 = '3') THEN
         LET l_amt = l_amt * -1
         #LET g_sql = "SELECT SUM(rvv39) FROM ",li_dbs CLIPPED,"rvv_file ",
         LET g_sql = "SELECT SUM(rvv39) FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                     " WHERE rvv01 = '",l_rvw08,"' ",
                     "   AND rvv02 = '",l_rvw09,"' "
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
         PREPARE sel_rvv39_pre FROM g_sql
         EXECUTE sel_rvv39_pre INTO l_amt2
      END IF

      IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
         #發票金額大于收/退貨金額
         IF l_amt > l_amt2 THEN
            LET g_errno = 'tis-005'
         END IF
   END FOREACH
END FUNCTION

FUNCTION i140_a()
DEFINE l_str    LIKE ze_file.ze03   #NO FUN-690009 VARCHAR(17)
   IF s_shut(0) THEN RETURN END IF
   MESSAGE ""
   CLEAR FORM
   CALL g_rvw.clear()
   INITIALIZE g_head_1.* TO NULL
   CALL cl_opmsg('a')
   #FUN-D10064--add--str--
   LET g_head_1.rvwacti='Y'
   LET g_head_1.rvwuser=g_user
   LET g_head_1.rvworiu=g_user
   LET g_head_1.rvworig=g_grup
   LET g_head_1.rvwgrup=g_grup
   LET g_head_1.rvwdate=g_today
   #FUN-D10064--add--end

   WHILE TRUE
      LET g_head_1.rvw02 = g_today       #Default
      LET g_head_1.rvw19 = g_today       #Default   #No.FUN-CB0053   Add
      LET g_head_1.rvw05f_s  = 0         #
      LET g_head_1.rvw06f_s  = 0         #Default
      CALL i140_i("a")                 #輸入單頭

      IF INT_FLAG THEN                 #使用者不玩了
         INITIALIZE g_head_1.* TO NULL
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
      IF cl_null(g_head_1.rvw01) IS NULL THEN                # KEY 不可空白
         CONTINUE WHILE
      END IF
      IF cl_null(g_head_1.rvw02) OR cl_null(g_head_1.rvw11)
         OR cl_null(g_head_1.rvv06) OR cl_null(g_head_1.rvw03) THEN
         CONTINUE WHILE
      END IF
      SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
       WHERE azi01 = g_head_1.rvw11
      CALL g_rvw.clear()
      LET g_rec_b=0
      CALL i140_b()                  #輸入單身
      CALL cl_getmsg('agl-042',g_lang) RETURNING l_str
         EXIT WHILE
   END WHILE
END FUNCTION

FUNCTION i140_u()
DEFINE  l_cnt   LIKE type_file.num5     #NO FUN-690009 SMALLINT
   IF s_shut(0) THEN RETURN END IF
   IF g_head_1.rvw01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   SELECT COUNT(*) INTO l_cnt FROM apk_file
    WHERE apk03 = g_head_1.rvw01
      #AND apk28 = g_head_1.rvw07                 #CHI-B30082 add
      AND apk01 IN (SELECT apa01 FROM apa_file)  #MOD-A20066 mod
                   # WHERE apa00 MATCHES '1*')   #MOD-A20066 mark
   IF l_cnt > 0 THEN
      CALL cl_err('','apm-241',0)
      RETURN
   END IF
   MESSAGE ""
   CALL cl_opmsg('u')

   BEGIN WORK
   OPEN i140_cl USING g_head_1.rvw01
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE i140_cl
      ROLLBACK WORK
      RETURN
   ELSE
      FETCH i140_cl INTO
            g_head_1.rvw01,g_head_1.rvw07,g_head_1.rvw02,g_head_1.rvw18,g_head_1.rvw19,g_head_1.rvw03,   #No.FUN-CB0053 Add g_head_1.rvw19  #MOD-DC0088 add rvw18
            g_head_1.rvw04,g_head_1.rvw11,g_head_1.rvw12               # 鎖住將被更改或取消的資料   #MOD-640405
            ,g_head_1.rvwacti,g_head_1.rvwuser,g_head_1.rvwgrup,g_head_1.rvwmodu, #FUN-D10064
            g_head_1.rvwdate,g_head_1.rvworiu,g_head_1.rvworig  #FUN-D10064
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)  # 資料被他人LOCK
         CLOSE i140_cl ROLLBACK WORK RETURN
      END IF
   END IF
   LET g_head_t.* = g_head_1.*  #No.MOD-960197
   LET g_head_1.rvw05f_s=g_head_1.rvw05f_sum
   LET g_head_1.rvw06f_s=g_head_1.rvw06f_sum
   LET g_head_1.rvw05f_s=cl_digcut(g_head_1.rvw05f_s,t_azi04)
   LET g_head_1.rvw06f_s=cl_digcut(g_head_1.rvw06f_s,t_azi04)
   CALL i140_show()
   WHILE TRUE
      LET g_rvw01_t = g_head_1.rvw01
      CALL i140_i("u")                                  #欄位更改

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_head_1.*=g_head_t.*
         CALL i140_show()
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF

      UPDATE rvw_file SET rvw_file.rvw01 = g_head_1.rvw01,
                          rvw_file.rvw02 = g_head_1.rvw02,
                          rvw_file.rvw19 = g_head_1.rvw19,   #No.FUN-CB0053   Add
                          rvw_file.rvw07 = g_head_1.rvw07,
                          rvw_file.rvw12 = g_head_1.rvw12   #MOD-640405
                         ,rvw_file.rvwmodu=g_user,    #FUN-D10064
                          rvw_file.rvwdate=g_today    #FUN-D10064
                    WHERE rvw_file.rvw01 = g_rvw01_t
      IF SQLCA.sqlcode THEN
         CALL cl_err3("upd","rvw_file",g_rvw01_t,"",SQLCA.sqlcode,"","",1)  #No.FUN-660071
         CONTINUE WHILE
      END IF

      IF g_type = '1' OR g_type = '2' THEN  #No.TQC-760013
         CALL i140_upd_rvb22('b')
      END IF  #No.TQC-760013

      IF g_head_1.rvw05f_s != g_head_t.rvw05f_s OR g_head_1.rvw06f_s != g_head_t.rvw06f_s THEN
         CALL i140_var_process('u')
      END IF
      CALL i140_list_fill()  #FUN-CB0080
      EXIT WHILE
   END WHILE
   CLOSE i140_cl
   COMMIT WORK
END FUNCTION

FUNCTION i140_i(p_cmd)
DEFINE
   l_flag          LIKE type_file.chr1,     #NO FUN-690009 VARCHAR(1)    #判斷必要欄位是否有輸入
   p_cmd           LIKE type_file.chr1,     #NO FUN-690009 VARCHAR(1)    #a:輸入 u:更改
   l_n         	   LIKE type_file.num10     #NO FUN-690009 INTEGER
   CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

   INPUT BY NAME g_type,g_head_1.rvw01,g_head_1.rvw02,g_head_1.rvw19,g_head_1.rvw07,   #No.FUN-CB0053   Add g_head_1.rvw19
                 g_head_1.rvv06,g_head_1.rvw03,g_head_1.rvw11,
                 g_head_1.rvw05f_s,g_head_1.rvw06f_s,g_head_1.rvw12   #MOD-640405
         WITHOUT DEFAULTS HELP 1
      BEFORE INPUT
         LET g_before_input_done = FALSE
         CALL i140_set_entry(p_cmd)
         CALL i140_set_no_entry(p_cmd)
         LET g_before_input_done = TRUE

      AFTER FIELD rvw01
         IF (p_cmd = 'a') OR
            (p_cmd = 'u' AND g_head_t.rvw01 != g_head_1.rvw01) THEN
            IF NOT cl_null(g_head_1.rvw07) THEN                        #CHI-B30082 add
               LET l_n = 0                                             #CHI-B30082 add
               SELECT COUNT(*) INTO l_n FROM rvw_file
                WHERE rvw01 = g_head_1.rvw01
               IF cl_null(l_n) THEN LET l_n = 0 END IF                 #CHI-B30082 add
               IF l_n > 0  THEN
                  CALL cl_err('',-239,0)
                  LET g_head_1.rvw01 = g_head_t.rvw01
                  DISPLAY BY NAME g_head_1.rvw01
                  NEXT FIELD rvw01
               END IF
            END IF                                                     #CHI-B30082 add
            LET l_n = 0                                                #CHI-B30082 add
            SELECT COUNT(*) INTO l_n FROM apk_file
             WHERE apk03 = g_head_1.rvw01
#               AND apk28 = g_head_1.rvw07                              #CHI-B30082 add
               AND apk01 IN (SELECT apa01 FROM apa_file)  #MOD-A20066 mod
                            # WHERE apa00 MATCHES '1*')   #MOD-A20066 mark
            IF cl_null(l_n) THEN LET l_n = 0 END IF                    #CHI-B30082 add
            IF l_n > 0 THEN
               CALL cl_err('','apm-241',0)
               NEXT FIELD rvw01
            END IF
         END IF
      AFTER FIELD rvw02
         IF NOT cl_null(g_head_1.rvw02) AND NOT cl_null(g_head_1.rvw11) THEN
            IF p_cmd='a' OR (p_cmd='u' AND
                            (g_head_1.rvw11 <> g_head_t.rvw11)  OR
                            (g_head_1.rvw02 <> g_head_t.rvw02)) THEN
               CALL s_curr3(g_head_1.rvw11,g_head_1.rvw02,g_apz.apz33)  #TQC-840062 mark
                    RETURNING g_head_1.rvw12
               IF cl_null(g_head_1.rvw12) THEN
                  LET g_head_1.rvw12 = 0
               END IF
               DISPLAY g_head_1.rvw12 TO rvw12
            END IF
         END IF

      AFTER FIELD rvw07
         IF cl_null(g_head_1.rvw07) AND g_aza.aza46 = 'Y' THEN
            CALL cl_err('','gap-142',0)
            NEXT FIELD rvw07
        #-----------------------CHI-B30082-----------------(S)
       # ELSE
       #    LET l_n = 0
       #    SELECT COUNT(*) INTO l_n
       #      FROM rvw_file
       #     WHERE rvw01 = g_head_1.rvw01
       #       AND rvw07 = g_head_1.rvw07
       #    IF cl_null(l_n) THEN LET l_n = 0 END IF
       #    IF l_n > 0  THEN
       #       CALL cl_err('',-239,0)
       #       LET g_head_1.rvw01 = g_head_t.rvw01
       #       LET g_head_1.rvw07 = g_head_t.rvw07
       #       DISPLAY BY NAME g_head_1.rvw01
       #       DISPLAY BY NAME g_head_1.rvw07
       #       NEXT FIELD rvw07
       #    END IF
        #-----------------------CHI-B30082-----------------(E)
         END IF

      AFTER FIELD rvw11
         IF NOT cl_null(g_head_1.rvw11) THEN
            SELECT azi04 INTO t_azi04 FROM azi_file
             WHERE azi01 = g_head_1.rvw11
            IF STATUS THEN
               CALL cl_err3("sel","azi_file",g_head_1.rvw11,"","aap-002","","",1)  #No.FUN-660071
               NEXT FIELD rvw11
            END IF
            IF p_cmd='a' OR (p_cmd='u' AND
                            (g_head_1.rvw11 <> g_head_t.rvw11)  OR
                            (g_head_1.rvw02 <> g_head_t.rvw02)) THEN
               CALL s_curr3(g_head_1.rvw11,g_head_1.rvw02,g_apz.apz33)  #TQC-840062 mark
                    RETURNING g_head_1.rvw12
               IF cl_null(g_head_1.rvw12) THEN
                  LET g_head_1.rvw12 = 0
               END IF
               DISPLAY g_head_1.rvw12 TO rvw12
            END IF
         END IF

      AFTER FIELD rvw12
         IF g_head_1.rvw11 = g_aza.aza17 THEN
            LET g_head_1.rvw12 = 1
            DISPLAY g_head_1.rvw12 TO rvw12
         END IF
         IF g_head_1.rvw12 <> g_head_t.rvw12 OR
            cl_null(g_head_t.rvw12) THEN
            UPDATE rvw_file SET rvw05 = rvw05f * g_head_1.rvw12,
                                rvw06 = rvw06f * g_head_1.rvw12
              WHERE rvw01 = g_head_1.rvw01
            CALL i140_show()
         END IF

      AFTER FIELD rvv06
         IF NOT cl_null(g_head_1.rvv06) THEN
            CALL i140_rvv06()
         END IF
         IF NOT cl_null(g_errno) THEN
            CALL cl_err(g_head_1.rvv06,g_errno,0)
            LET g_head_1.rvv06 = g_head_t.rvv06
            DISPLAY BY NAME g_head_1.rvv06
            NEXT FIELD rvv06
         END IF

      AFTER FIELD rvw03
         IF NOT cl_null(g_head_1.rvw03) THEN
            SELECT gec04,gec05 INTO g_head_1.rvw04,g_gec05
              FROM gec_file WHERE gec01 = g_head_1.rvw03 AND gec011='1'  #No.TQC-9A0091 mod
            IF STATUS THEN
               CALL cl_err3("sel","gec_file",g_head_1.rvw03,"","mfg3044","","",1)  #No.FUN-660071
               NEXT FIELD rvw03
            END IF
            DISPLAY BY NAME g_head_1.rvw04
         END IF

      AFTER FIELD rvw05f_s
         IF g_head_1.rvw05f_s IS NULL THEN
            NEXT FIELD rvw05f_s
         ELSE
            LET g_head_1.rvw06f_s=g_head_1.rvw05f_s*g_head_1.rvw04/100
            IF cl_null(g_head_1.rvw06f_s) THEN LET g_head_1.rvw06f_s = 0 END IF
            LET g_head_1.rvw06f_s = cl_digcut(g_head_1.rvw06f_s,t_azi04)    #MOD-C40103 add
            DISPLAY BY NAME g_head_1.rvw06f_s
	 END IF

      AFTER FIELD rvw06f_s
         IF g_head_1.rvw06f_s IS NULL THEN
            NEXT FIELD rvw06f_s
         END IF

      AFTER INPUT  #判斷必要欄位之值是否有值,若無則反白顯示,并要求重新輸入
         LET l_flag='N'
         IF INT_FLAG THEN
            EXIT INPUT
         END IF
         IF g_head_1.rvw01 IS NULL THEN
            LET l_flag='Y'
            DISPLAY BY NAME g_head_1.rvw01 ATTRIBUTE(REVERSE)
         END IF
         IF g_head_1.rvw02 IS NULL THEN
            LET l_flag='Y'
            DISPLAY BY NAME g_head_1.rvw02 ATTRIBUTE(REVERSE)
         END IF
         IF cl_null(g_head_1.rvw07) AND g_aza.aza46 = 'Y' THEN
            CALL cl_err('','gap-142',0)
            NEXT FIELD rvw07
         END IF
        #No.FUN-CB0053 ---start--- Add
         IF g_head_1.rvw19 IS NULL THEN
            LET l_flag='Y'
            DISPLAY BY NAME g_head_1.rvw19 ATTRIBUTE(REVERSE)
         END IF
        #No.FUN-CB0053 ---start--- Add
         IF g_head_1.rvw12 <> g_head_t.rvw12 OR
            cl_null(g_head_t.rvw12) THEN
            UPDATE rvw_file SET rvw05 = rvw05f * g_head_1.rvw12,
                                rvw06 = rvw06f * g_head_1.rvw12
              WHERE rvw01 = g_head_1.rvw01
         END IF


      ON ACTION controlp
         CASE
            WHEN INFIELD(rvw03)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_gec"
               LET g_qryparam.arg1 ="1"
               LET g_qryparam.default1 = g_head_1.rvw03
               CALL cl_create_qry() RETURNING g_head_1.rvw03
               NEXT FIELD rvw03

            WHEN INFIELD(rvw11)               # CURRENCY
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_azi"
               LET g_qryparam.default1 = g_head_1.rvw11
               CALL cl_create_qry() RETURNING g_head_1.rvw11
               DISPLAY BY NAME g_head_1.rvw11

            WHEN INFIELD (rvv06)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_pmc1"
               LET g_qryparam.default1 = g_head_1.rvv06
               CALL cl_create_qry() RETURNING g_head_1.rvv06
               NEXT FIELD rvv06

            OTHERWISE EXIT CASE
         END CASE

      ON ACTION CONTROLF                     #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)


      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION CONTROLG
         CALL cl_cmdask()

   END INPUT

   CALL i140_show()

END FUNCTION

FUNCTION i140_set_entry(p_cmd)
DEFINE p_cmd         LIKE type_file.chr1     #NO FUN-690009 VARCHAR(01)
   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("g_type,rvv06,rvw03,rvw11",TRUE)
   END IF
END FUNCTION

FUNCTION i140_set_no_entry(p_cmd)
DEFINE p_cmd   LIKE type_file.chr1      #NO FUN-690009 VARCHAR(01)
   IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("g_type,rvv06,rvw03,rvw11",FALSE)
   END IF
END FUNCTION

FUNCTION i140_rvv06()
   DEFINE p_cmd     LIKE type_file.chr1     #NO FUN-690009 VARCHAR(01)
   DEFINE l_pmc03   LIKE pmc_file.pmc03
   DEFINE l_pmc22   LIKE pmc_file.pmc22
   DEFINE l_pmc05   LIKE pmc_file.pmc05
   DEFINE l_pmcacti LIKE pmc_file.pmcacti
   DEFINE l_pmc47   LIKE pmc_file.pmc47

   SELECT pmc03,pmc05,pmcacti,pmc22,pmc47
     INTO l_pmc03,l_pmc05,l_pmcacti,l_pmc22,l_pmc47
      FROM pmc_file WHERE pmc01 = g_head_1.rvv06
   LET g_errno = ' '
   CASE
      WHEN l_pmcacti = 'N'            LET g_errno = '9028'
      WHEN l_pmcacti MATCHES '[PH]'   LET g_errno = '9038' #No.FUN-690024

      WHEN l_pmc05   = '0'     LET g_errno = 'aap-032'     #No.FUN-690025
      WHEN l_pmc05   = '3'     LET g_errno = 'aap-033'     #No.FUN-690025
      WHEN SQLCA.SQLCODE != 0  LET g_errno = SQLCA.SQLCODE USING '-----'
   END CASE
   LET g_head_1.pmc03 = l_pmc03
   #IF cl_null(g_head_1.rvw11) THEN LET g_head_1.rvw11 = l_pmc22 END IF  #No.TQC-AC0009 mark
   #IF cl_null(g_head_1.rvw03) THEN LET g_head_1.rvw03 = l_pmc47 END IF  #No.TQC-AC0009 mark
   LET g_head_1.rvw11 = l_pmc22                                          #No.TQC-AC0009 mod
   LET g_head_1.rvw03 = l_pmc47                                          #No.TQC-AC0009 mod
   SELECT gec04 INTO g_head_1.rvw04
     FROM gec_file WHERE gec01 = g_head_1.rvw03 AND gec011='1' #No.TQC-9A0091 mod
   #CALL s_curr3(g_head_1.rvw04,g_head_1.rvw02,g_apz.apz33) RETURNING g_head_1.rvw12            #MOD-C20225 #MOD-CB0246 mark
   CALL s_curr3(g_head_1.rvw11,g_head_1.rvw02,g_apz.apz33) RETURNING g_head_1.rvw12            #MOD-CB0246
   DISPLAY BY NAME g_head_1.pmc03,g_head_1.rvw11,g_head_1.rvw03,g_head_1.rvw04,g_head_1.rvw12  #MOD-C20225
END FUNCTION

FUNCTION i140_r()
   DEFINE l_chr   LIKE type_file.chr1     #NO FUN-690009 VARCHAR(01)
   DEFINE l_cnt   LIKE type_file.num5     #NO FUN-690009 SMALLINT
   IF s_shut(0) THEN RETURN END IF
   IF g_head_1.rvw01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   BEGIN WORK
   OPEN i140_cl USING g_head_1.rvw01
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)
      ROLLBACK WORK
      RETURN
   ELSE
      FETCH i140_cl INTO g_head_1.rvw01,g_head_1.rvw07,g_head_1.rvw02,    #鎖住將被更改或取消的數據
                         g_head_1.rvw18,g_head_1.rvw19,               #No.FUN-CB0053   Add  #MOD-DC0088 add rvw18
                         g_head_1.rvw03,g_head_1.rvw04,g_head_1.rvw11,
                         g_head_1.rvw12   #MOD-640405
                        ,g_head_1.rvwacti,g_head_1.rvwuser,g_head_1.rvwgrup,g_head_1.rvwmodu, #FUN-D10064
                         g_head_1.rvwdate,g_head_1.rvworiu,g_head_1.rvworig  #FUN-D10064
      IF SQLCA.sqlcode THEN                                         #資料被他人LOCK
         CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0) RETURN END IF
      END IF
      CALL i140_show()
      #No.MOD-DC0088  --Begin
      IF NOT cl_null(g_head_1.rvw18) THEN
      	 CALL cl_err('','apm-241',0)
         RETURN
      END IF
      #No.MOD-DC0088  --End
      SELECT COUNT(*) INTO l_cnt FROM apk_file
       WHERE apk03 = g_head_1.rvw01
#         AND apk28 = g_head_1.rvw07                  #CHI-B30082 add
         AND apk01 IN (SELECT apa01 FROM apa_file)  #MOD-A20066 mod
                      # WHERE apa00 MATCHES '1*')   #MOD-A20066 mark
      IF l_cnt > 0 THEN
         CALL cl_err('','apm-241',0)
         RETURN
      END IF
      IF cl_delh(15,21) THEN                                         #確認一下
          INITIALIZE g_doc.* TO NULL             #No.FUN-9B0098 10/02/24
          LET g_doc.column1 = "rvw01"            #No.FUN-9B0098 10/02/24
          LET g_doc.value1 = g_head_1.rvw01      #No.FUN-9B0098 10/02/24
          CALL cl_del_doc()                                        #No.FUN-9B0098 10/02/24
         IF g_type = '1' OR g_type = '2' THEN   #No.TQC-7600013
            CALL i140_upd_rvb22('d')
         END IF
         IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
            CALL cl_err('del upd rvb',STATUS,0)
         END IF
         DELETE FROM rvw_file WHERE rvw01=g_head_1.rvw01
         IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
            CALL cl_err3("del","rvw_file",g_head_1.rvw01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660071
            ROLLBACK WORK RETURN
         END IF
         CALL i140_list_fill()  #FUN-CB0080
         CLEAR FORM                                                  #刪除后要將畫面上數據清空
         CALL g_rvw.clear()
         MESSAGE ""
         OPEN i140_count                                             #重新計算總比數
#FUN-B50065------begin---
         IF STATUS THEN
            CLOSE i140_count
            CLOSE i140_cl
            COMMIT WORK
            RETURN
         END IF
#FUN-B50065------end------
         FETCH i140_count INTO g_row_count
#FUN-B50065------begin---
         IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
            CLOSE i140_count
            CLOSE i140_cl
            COMMIT WORK
            RETURN
         END IF
#FUN-B50065------end------
         DISPLAY g_row_count TO FORMONLY.cnt
         OPEN i140_cs
         IF g_curs_index = g_row_count + 1 THEN                      #若原本刪除那筆是最后一筆數據的話，則
            LET g_jump = g_row_count                                 #利用_fetch子程序將數據跳到最后一筆
            CALL i140_fetch('L')
         ELSE
            LET g_jump = g_curs_index
            LET mi_no_ask = TRUE
            CALL i140_fetch('/')
         END IF
      END IF
      CLOSE i140_cl
      COMMIT WORK
END FUNCTION

FUNCTION i140_ins_rvw()
DEFINE l_rvw RECORD LIKE rvw_file.*,
       t_rvw03      LIKE rvw_file.rvw03,
       t_rvw04      LIKE rvw_file.rvw04,
       t_rvw10      LIKE rvw_file.rvw10,
       t_rvw11      LIKE rvw_file.rvw11,
       t_rvw12      LIKE rvw_file.rvw12,    #MOD-640405
       t_gec05      LIKE gec_file.gec05,
       t_rvb22      LIKE rvb_file.rvb22,
       l_sql        LIKE type_file.chr1000, #NO FUN-690009 VARCHAR(300)
       l_apb09      LIKE apb_file.apb09,    #TQC-6C0126
       l_rvv03      LIKE rvv_file.rvv03,    #No.TQC-760013
       l_rvv04      LIKE rvv_file.rvv04,    #No.FUN-940083
       l_rvv36      LIKE rvv_file.rvv36,    #No.FUN-940083
       l_rvv25      LIKE rvv_file.rvv25     #MOD-B50016 add

   LET l_rvw.rvw01=g_head_1.rvw01
   LET l_rvw.rvw02=g_head_1.rvw02
   LET l_rvw.rvw19=g_head_1.rvw19           #No.FUN-CB0053   Add
   LET l_rvw.rvw03=g_head_1.rvw03
   LET l_rvw.rvw04=g_head_1.rvw04
   LET l_rvw.rvw07=g_head_1.rvw07
   LET l_rvw.rvw11=g_head_1.rvw11
   LET l_rvw.rvw12=g_head_1.rvw12   #MOD-640405
   LET l_rvw.rvw08=g_rvw[l_ac].rvw08
   LET l_rvw.rvw09=g_rvw[l_ac].rvw09
   #FUN-D10064--add--str--
   LET l_rvw.rvwacti='Y'
   LET l_rvw.rvwuser=g_user
   LET l_rvw.rvwgrup=g_grup
   LET l_rvw.rvwmodu=''
   LET l_rvw.rvwdate=g_today
   LET l_rvw.rvworiu=g_user
   LET l_rvw.rvworig=g_grup
   #FUN-D10064--add--end
      #LET g_sql = "SELECT rvv04,rvv36 FROM ",li_dbs CLIPPED,"rvv_file ",
      LET g_sql = "SELECT rvv04,rvv36 FROM ",cl_get_target_table(g_plant_new,'rvv_file'), #FUN-A50102
                  " WHERE rvv01 = '",l_rvw.rvw08,"' ",
                  "   AND rvv02 = '",l_rvw.rvw09,"' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_rvv04_pre3 FROM g_sql
      EXECUTE sel_rvv04_pre3 INTO l_rvv04,l_rvv36

      IF g_sma.sma116 MATCHES '[13]' THEN
         IF NOT cl_null(l_rvv36) THEN                                             #FUN-940083--add
            LET l_sql="SELECT rvv38,rvv87,rvv39,pmm22,pmm21,gec04,gec05,",   #TQC-6C0126
                      "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                      #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"pmn_file,",      #FUN-9B0130
                      #          li_dbs CLIPPED,"pmm_file LEFT OUTER JOIN ",                 #FUN-9B0130
                      #          li_dbs CLIPPED,"gec_file ON pmm_file.pmm21=gec_file.gec01", #FUN-9B0130
                      "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'pmn_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'pmm_file'),     #FUN-A50102
                                " LEFT OUTER JOIN ",                             #FUN-A50102
                                cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                                " ON pmm_file.pmm21=gec_file.gec01",
                      " WHERE rvv01 = '", l_rvw.rvw08,"'",
                      "   AND rvv02 = '", l_rvw.rvw09,"'",
                      "   AND pmn01 = rvv36 AND pmn02 = rvv37",
                      "   AND pmm01 = pmn01 AND gec01 = pmm21 AND gec011='1'",  #No.TQC-9A0091 mod
                      "   AND rvv89 <>'Y'"                                        #FUN-940083--add
                     ," UNION SELECT rvv38,rvv87,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                      #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",   #FUN-9B0130
                      "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                      " WHERE rvv01 = '", l_rvw.rvw08,"'",
                      "   AND rvv02 = '", l_rvw.rvw09,"'",
                      "   AND rvv01 = rvu01 "
         ELSE
            IF NOT cl_null(l_rvv04) THEN
               LET l_sql="SELECT rvv38,rvv87,rvv39,rva113,rva115,gec04,gec05,",
                         "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rva_file,",  #FUN-9B0130
                         #          "OUTER",li_dbs CLIPPED,"gec_file ",              #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                         " OUTER ",cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rva01 = rvv04",
                         "   AND gec01 = rva115",
                         "   AND gec011= '1' ",     #No.TQC-9A0091 add
                         "   AND rvv89 <>'Y'"
                        ," UNION SELECT rvv38,rvv87,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",  #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvv01 = rvu01 "
            ELSE
               LET l_sql="SELECT rvv38,rvv87,rvv39,rvu113,rvu115,gec04,gec05,",
                         "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",   #FUN-9B0130
                         #          "OUTER ",li_dbs CLIPPED,"gec_file ",  #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                         " OUTER ",cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvu01 = rvv01",
                         "   AND gec01 = rvu115",
                         "   AND gec011= '1'",     #No.TQC-9A0091 add
                         "   AND rvv89 <>'Y'"
                        ," UNION SELECT rvv38,rvv87,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",   #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvv01 = rvu01 "
            END IF
         END IF
      ELSE
         IF NOT cl_null(l_rvv36) THEN                                             #FUN-940083--add
            LET l_sql="SELECT rvv38,rvv17,rvv39,pmm22,pmm21,gec04,gec05,",   #TQC-6C0126
                      "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                      #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"pmn_file,",
                      #          li_dbs CLIPPED,"pmm_file LEFT OUTER JOIN ",
                      #          li_dbs CLIPPED,"gec_file ON pmm_file.pmm21=gec_file.gec01 ",
                      "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'pmn_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'pmm_file'), #FUN-A50102
                                " LEFT OUTER JOIN ",
                                cl_get_target_table(g_plant_new,'gec_file'), #FUN-A50102
                                " ON pmm_file.pmm21=gec_file.gec01 ",
                      " WHERE rvv01 = '", l_rvw.rvw08,"'",
                      "   AND rvv02 = '", l_rvw.rvw09,"'",
                      "   AND pmn01 = rvv36 AND pmn02 = rvv37",
                      "   AND pmm01 = pmn01 AND gec01 = pmm21 AND gec011='1' ", #No.TQC-9A0091 mod
                      "   AND rvv89 <>'Y'"                                        #FUN-940083--add
                     ," UNION SELECT rvv38,rvv17,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                      #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",   #FUN-9B0130
                      "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                      " WHERE rvv01 = '", l_rvw.rvw08,"'",
                      "   AND rvv02 = '", l_rvw.rvw09,"'",
                      "   AND rvu01=rvv01 "
         ELSE
            IF NOT cl_null(l_rvv04) THEN
               LET l_sql="SELECT rvv38,rvv17,rvv39,rva113,rva115,gec04,gec05,",
                         "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rva_file,",
                         #          "OUTER ",li_dbs CLIPPED,"gec_file ",
                         "  FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rva_file'),",", #FUN-A50102
                         " OUTER ",cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rva01 = rvv04 AND gec01 = rva115 AND gec011='1' ", #No.TQC-9A0091 mod
                         "   AND rvv89 <>'Y'"
                        ," UNION SELECT rvv38,rvv17,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",  #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rvv_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvu01=rvv01 "
               ELSE
               LET l_sql="SELECT rvv38,rvv17,rvv39,rvu113,rvu115,gec04,gec05,",
                         "       rvv03,rvv25",  #No.TQC-760013 add rvv03   #MOD-B50016 add rvv25
                         #"   FROM ",li_dbs CLIPPED,"rvv_file,",li_dbs CLIPPED,"rvu_file,",
                         #           "OUTER ",li_dbs CLIPPED,"gec_file ",
                         "   FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                    cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                         "  OUTER ",cl_get_target_table(g_plant_new,'gec_file'),     #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvu01 = rvv01 AND gec01 = rvu115 AND gec011='1' ", #No.TQC-9A0091 mod
                         "   AND rvv89 <>'Y'"
                        ," UNION SELECT rvv38,rvv17,rvv39,'','',rvu12,'',rvv03,rvv25",  #MOD-B50016 add rvv25
                         #"  FROM ",li_dbs CLIPPED,"rvu_file,",li_dbs CLIPPED,"rvv_file ",  #FUN-9B0130
                         "  FROM ",cl_get_target_table(g_plant_new,'rvu_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'rvv_file'),      #FUN-A50102
                         " WHERE rvv01 = '", l_rvw.rvw08,"'",
                         "   AND rvv02 = '", l_rvw.rvw09,"'",
                         "   AND rvu01=rvv01 "
            END IF
         END IF
      END IF
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
   PREPARE i140_pr FROM l_sql
   IF STATUS THEN
      CALL cl_err('i140_pb:',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE i140_sel_rvb CURSOR FOR i140_pr
   FOREACH i140_sel_rvb INTO l_rvw.rvw17,l_rvw.rvw10,l_rvw.rvw05f,
                             t_rvw11,t_rvw03,t_rvw04,t_gec05,l_rvv03,  #,t_rvb22  #No.TQC-760013 add l_rvv03
                             l_rvv25                                   #MOD-B50016 add rvv25
      IF STATUS THEN
         LET g_errno = 'asf-700' RETURN
      END IF
     #MOD-A30163---add---start---
      IF cl_null(t_rvw11) THEN LET t_rvw11 = l_rvw.rvw11 END IF
      IF cl_null(t_rvw03) THEN LET t_rvw03 = l_rvw.rvw03 END IF
     #MOD-A30163---add---end---
      IF g_type = '1' AND NOT cl_null(t_rvb22) THEN CONTINUE FOREACH END IF
      IF g_type = '2' AND l_rvv03 = '1' AND NOT cl_null(t_rvb22) THEN CONTINUE FOREACH END IF  #No.TQC-760013
      IF t_rvw03 != l_rvw.rvw03 THEN
         LET g_errno = 'tis-203' CONTINUE FOREACH
      END IF
      IF t_rvw04 != l_rvw.rvw04 THEN
         LET g_errno = 'tis-204' CONTINUE FOREACH
      END IF
      IF t_rvw11 != l_rvw.rvw11 THEN
         LET g_errno = 'tis-204' CONTINUE FOREACH
      END IF
      IF cl_null(l_rvv25) THEN LET l_rvv25 = 'N' END IF   #MOD-B50016 add
      CALL s_curr2(t_rvw11,g_head_1.rvw02,g_apz.apz33,g_rvw[l_ac].rvw99) RETURNING l_rvw.rvw12  #FUN-9B0130
      #計算未生成請款的入庫數量
     #LET l_sql = " SELECT SUM(rvw10) ",         #MOD-C60098 mark
      LET l_sql = " SELECT abs(SUM(rvw10)) ",    #MOD-C60098 add
                  "   FROM rvw_file ",
                  "  WHERE rvw01 NOT IN ",
                  "(SELECT DISTINCT apk03 ",
                  "   FROM apk_file,apa_file,apb_file ",
                  "  WHERE apk01 = apa01 ",
                  "    AND apa01 = apb01 ",
                  "    AND apb21 = '",l_rvw.rvw08,"' ",
                  "    AND apb22 = ",l_rvw.rvw09,") ",
                  "    AND rvw01 <> '",g_head_1.rvw01,"'",      #MOD-C60098 add
                  "    AND rvw99 = '",g_rvw[l_ac].rvw99,"' ",   #MOD-C60098 add
                  "    AND rvw08 = '",l_rvw.rvw08,"' ",
                  "    AND rvw09 = ",l_rvw.rvw09," "
      PREPARE i140_pb2 FROM l_sql
      IF STATUS THEN CALL cl_err('prepare:',STATUS,1)
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
         EXIT PROGRAM
      END IF
      DECLARE rvw_curs2 CURSOR FOR i140_pb2
      OPEN rvw_curs2
      FETCH rvw_curs2 INTO g_rvw10
      IF cl_null(g_rvw10) THEN LET g_rvw10 = 0 END IF
      LET l_sql = " SELECT SUM(apb09) ",
                  "   FROM apb_file,apa_file ",
                  "  WHERE apb01 = apa01 ",
                  "    AND apb21 = '",l_rvw.rvw08,"' ",
                  "    AND apb22 = ",l_rvw.rvw09,
                  "    AND apa08 <> 'UNAP' "
      PREPARE i140_pb3 FROM l_sql
      IF STATUS THEN CALL cl_err('prepare:',STATUS,1)
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
         EXIT PROGRAM
      END IF
      DECLARE rvw_curs3 CURSOR FOR i140_pb3
      OPEN rvw_curs3
      FETCH rvw_curs3 INTO l_apb09
      IF cl_null(l_apb09) THEN LET l_apb09 = 0 END IF
      LET l_rvw.rvw10 = l_rvw.rvw10 - g_rvw10 - l_apb09
      IF g_type = '3' AND g_rvw[l_ac].rvw05f > 0 THEN                 #負值顯示
         LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
      END IF
      IF g_type = '2' AND g_rvw[l_ac].rvw05f > 0 THEN
         IF l_rvv03 = '3' THEN
            LET g_rvw[l_ac].rvw05f = g_rvw[l_ac].rvw05f * -1
         END IF
      END IF
      LET g_flag = 'N'          #MOD-A80052
     #LET g_sql = "SELECT gec07 FROM ",li_dbs CLIPPED,"gec_file ",
     #LET g_sql = "SELECT gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'),      #FUN-A50102            #MOD-A80052 mark
      LET g_sql = "SELECT gec05,gec07 FROM ",cl_get_target_table(g_plant_new,'gec_file'),      #FUN-A50102      #MOD-A80052
                  " WHERE gec01='",t_rvw03,"' ",
                  "   AND gec011='1' "
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
      PREPARE sel_gec07_pre3 FROM g_sql
     #EXECUTE sel_gec07_pre3 INTO g_gec07                            #MOD-A80052 mark
      EXECUTE sel_gec07_pre3 INTO g_gec05,g_gec07                    #MOD-A80052
      IF g_gec07 = 'Y' THEN    #含稅
         LET g_rvv38t = 0
         #LET g_sql = "SELECT rvv38t FROM ",li_dbs CLIPPED,"rvv_file,",
         #                                  li_dbs CLIPPED,"rvu_file ",
         LET g_sql = "SELECT rvv38t FROM ",cl_get_target_table(g_plant_new,'rvv_file'),",", #FUN-A50102
                                           cl_get_target_table(g_plant_new,'rvu_file'),     #FUN-A50102
                     " WHERE rvv01 = '",l_rvw.rvw08,"' ",
                     "   AND rvv02 = '",l_rvw.rvw09,"' ",
                     "   AND rvv01 = rvu01 "
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql                   #FUN-A50102
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql       #FUN-A50102
         PREPARE sel_rvv38t_pre1 FROM g_sql
         EXECUTE sel_rvv38t_pre1 INTO g_rvv38t
         #未稅金額=(數量*含稅單價)/(1+稅率/100)
         IF l_rvw.rvw10 <> 0 THEN
           #-MOD-A80052-add-
            IF g_gec05 = 'T' THEN
               LET g_rvw05f = g_rvv38t*l_rvw.rvw10
               LET g_rvw05f = cl_digcut(g_rvw05f,t_azi04)
               LET l_rvw.rvw06f = g_rvw05f * (t_rvw04/100)
               LET l_rvw.rvw06f = cl_digcut(l_rvw.rvw06f,t_azi04)
               LET l_rvw.rvw05f = g_rvw05f - l_rvw.rvw06f
               LET g_flag = 'Y'
            ELSE
              #LET l_rvw.rvw05f = (l_rvw.rvw10*g_rvv38t)/(1+t_rvw04/100)     #MOD-AC0024
               LET l_rvw.rvw05f = cl_digcut((l_rvw.rvw10*g_rvv38t),t_azi04)/(1+t_rvw04/100)     #MOD-AC0024
            END IF
           #-MOD-A80052-end-
           #LET l_rvw.rvw05f = (l_rvw.rvw10*g_rvv38t)/(1+t_rvw04/100)          #MOD-A80052 mark
         ELSE
            LET l_rvw.rvw05f = g_rvv39t/(1+t_rvw04/100)
         END IF
      ELSE                     #不含稅
         #未稅金額=數量*未稅單價
         IF l_rvw.rvw10 <> 0 THEN
            LET l_rvw.rvw05f = l_rvw.rvw10*l_rvw.rvw17
        #ELSE                                            #MOD-BC0098 mark
        #   LET l_rvw.rvw05f = g_rvv39                   #MOD-BC0098 mark
         END IF
      END IF
     #LET l_rvw.rvw05f = l_rvw.rvw10 * l_rvw.rvw17       #MOD-BC0098 mark
      LET l_rvw.rvw05f = cl_digcut(l_rvw.rvw05f,t_azi04)
      IF g_flag = 'N' THEN                                               #MOD-A80052
         LET l_rvw.rvw06f = l_rvw.rvw05f * t_rvw04 / 100
         LET l_rvw.rvw06f = cl_digcut(l_rvw.rvw06f,t_azi04)
      END IF                                                             #MOD-A80052
      LET l_rvw.rvw05 = l_rvw.rvw05f * l_rvw.rvw12
      LET l_rvw.rvw05 = cl_digcut(l_rvw.rvw05,g_azi04)
      LET l_rvw.rvw06 = l_rvw.rvw05 * t_rvw04 / 100
      LET l_rvw.rvw06 = cl_digcut(l_rvw.rvw06,g_azi04)
      IF l_rvv03 <> '1' THEN
         LET l_rvw.rvw10 = l_rvw.rvw10 * -1
         LET l_rvw.rvw05 = l_rvw.rvw05 * -1
         LET l_rvw.rvw06 = l_rvw.rvw06 * -1
         LET l_rvw.rvw05f= l_rvw.rvw05f* -1
         LET l_rvw.rvw06f= l_rvw.rvw06f* -1
      END IF
      LET l_rvw.rvwlegal= g_legal #FUN-980011 add
     #str MOD-B50016 add
     #若為樣品時,金額部份(rvw17,rvw05,rvw05f,rvw06,rvw06f)應帶0
      IF l_rvv25="Y" THEN
         LET l_rvw.rvw17 =0
         LET l_rvw.rvw05 =0
         LET l_rvw.rvw05f=0
         LET l_rvw.rvw06 =0
         LET l_rvw.rvw06f=0
      END IF
     #end MOD-B50016 add
#----------------------No.MOD-B70210----------------------------START
      IF cl_null(g_rvw[l_ac].rvw99) THEN
         LET l_rvw.rvw99=g_plant
      ELSE
         LET l_rvw.rvw99=g_rvw[l_ac].rvw99
      END IF
#----------------------No.MOD-B70210-----------------------------END
      INSERT INTO rvw_file VALUES (l_rvw.*)

   END FOREACH
END FUNCTION

FUNCTION i140_var_process(p_cmd)
DEFINE p_cmd       LIKE type_file.chr1,    #NO FUN-690009  VARCHAR(01)  #b:單身 u:單頭修改
       tag         LIKE type_file.num5,    #NO FUN-690009  SMALLINT
       ls_msg      LIKE ze_file.ze03,      #NO FUN-690009  VARCHAR(80)
       lc_title    LIKE ze_file.ze03       #NO FUN-690009  VARCHAR(30)

   LET tag=0
   IF g_head_1.rvw05f_sum<>g_head_1.rvw05f_s THEN
      CALL cl_getmsg('gap-141',g_lang) RETURNING ls_msg
      CALL cl_getmsg('gap-140',g_lang) RETURNING lc_title
      IF p_cmd = 'b' THEN
         MENU lc_title ATTRIBUTE (STYLE="dialog", COMMENT=ls_msg CLIPPED, IMAGE="information")

            ON ACTION continue_type_b    #繼續輸入單身
               LET tag=1
               IF tag=1 THEN
                  CALL i140_b()
               END IF

            ON ACTION dantou             #調整單頭
               LET tag=3
               IF tag=3 THEN
                  LET g_head_1.rvw05f_s=g_head_1.rvw05f_sum
                  LET g_head_1.rvw06f_s=g_head_1.rvw06f_sum
                  DISPLAY BY NAME g_head_1.rvw05f_s,g_head_1.rvw06f_s
               END IF

              ON IDLE g_idle_seconds
                 CALL cl_on_idle()
         END MENU
      ELSE
         MENU lc_title ATTRIBUTE (STYLE="dialog", COMMENT=ls_msg CLIPPED, IMAGE="information")

            ON ACTION continue_type_b    #繼續輸入單身
               LET tag=1
               IF tag=1 THEN
                  CALL i140_b()
               END IF

            ON ACTION fentan             #分攤到單身
               CALL i140_share()

              ON IDLE g_idle_seconds
                 CALL cl_on_idle()

         END MENU
      END IF
   END IF
END FUNCTION

FUNCTION i140_share()
   DEFINE rvw       RECORD LIKE rvw_file.*
   DEFINE l_rvw05f         LIKE rvw_file.rvw05f
   DEFINE l_rvw08          LIKE rvw_file.rvw08
   DEFINE l_rvw09          LIKE rvw_file.rvw09
   DEFINE lamt             LIKE rvw_file.rvw05
   DEFINE lamt1            LIKE rvw_file.rvw05
   DEFINE t_rvw05f         LIKE rvw_file.rvw05f  #MOD-BC0104
   DEFINE t_rvw06f         LIKE rvw_file.rvw06f  #MOD-BC0104
   DEFINE t_rvw05          LIKE rvw_file.rvw05f  #MOD-BC0104
   DEFINE t_rvw06          LIKE rvw_file.rvw06f  #MOD-BC0104

   LET l_rvw08 = ''
   LET l_rvw09 = ''
   LET l_rvw05f = 0

  #--------------------MOD-CB0281---------------(S)
   SELECT azi03,azi04 INTO t_azi03,t_azi04
     FROM azi_file
    WHERE azi01 = g_head_1.rvw11
  #--------------------MOD-CB0281---------------(E)

   DECLARE i140_share_c CURSOR FOR
    SELECT * FROM rvw_file WHERE rvw01=g_head_1.rvw01

   FOREACH i140_share_c INTO rvw.*
      LET rvw.rvw05f=rvw.rvw05f*(g_head_1.rvw05f_s/g_head_1.rvw05f_sum)
      LET rvw.rvw06f=rvw.rvw06f*(g_head_1.rvw06f_s/g_head_1.rvw06f_sum)
      LET rvw.rvw05 =rvw.rvw05f*rvw.rvw12
      LET rvw.rvw06 =rvw.rvw06f*rvw.rvw12
      LET rvw.rvw17=rvw.rvw05f/rvw.rvw10
      LET rvw.rvw05f = cl_digcut(rvw.rvw05f,t_azi04)
      LET rvw.rvw06f = cl_digcut(rvw.rvw06f,t_azi04)
      LET rvw.rvw05 = cl_digcut(rvw.rvw05,g_azi04)
      LET rvw.rvw06 = cl_digcut(rvw.rvw06,g_azi04)
      LET rvw.rvw17 = cl_digcut(rvw.rvw17,t_azi03)

      IF l_rvw05f < rvw.rvw05f THEN
      	 LET l_rvw05f = rvw.rvw05f
         LET l_rvw08 = rvw.rvw08
         LET l_rvw09 = rvw.rvw09
      END IF

      UPDATE rvw_file SET rvw05=rvw.rvw05,
                          rvw06=rvw.rvw06,
                          rvw05f=rvw.rvw05f,
                          rvw06f=rvw.rvw06f,
                          rvw17=rvw.rvw17
       WHERE rvw01=rvw.rvw01
         AND rvw08=rvw.rvw08
         AND rvw09=rvw.rvw09
   END FOREACH

   SELECT SUM(rvw05f),SUM(rvw06f) INTO g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
     FROM rvw_file
    WHERE rvw01=g_head_1.rvw01

   #FUN-C80027--ADD--STR
   SELECT SUM(rvw05),SUM(rvw06) INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
     FROM rvw_file
    WHERE rvw01=g_head_1.rvw01
   #FUN-C80027--ADD--END

   IF g_head_1.rvw05f_sum != g_head_1.rvw05f_s OR g_head_1.rvw06f_sum != g_head_1.rvw06f_s THEN
      LET lamt = g_head_1.rvw05f_sum - g_head_1.rvw05f_s
      LET lamt1= g_head_1.rvw06f_sum - g_head_1.rvw06f_s
      IF lamt != 0 OR lamt1 !=0 THEN
         LET lamt = lamt * -1  LET lamt1 = lamt1 * -1
         #No.MOD-BC0104  --Begin
         LET t_rvw05f = 0  LET t_rvw06f = 0
         SELECT rvw05f,rvw06f INTO t_rvw05f,t_rvw06f
           FROM rvw_file
          WHERE rvw01=g_head_1.rvw01 AND rvw08=l_rvw08 AND rvw09=l_rvw09
         LET t_rvw05 = (t_rvw05f + lamt) * rvw.rvw12
         LET t_rvw06 = (t_rvw06f + lamt1) * rvw.rvw12
         LET t_rvw05 = cl_digcut(t_rvw05,g_azi04)
         LET t_rvw06 = cl_digcut(t_rvw06,g_azi04)
         #No.MOD-BC0104  --End
         UPDATE rvw_file SET rvw05f = rvw05f+lamt,
                             rvw06f = rvw06f+lamt1,
                             rvw05 = t_rvw05,            #MOD-BC0104
                             rvw06 = t_rvw06             #MOD-BC0104
         WHERE rvw01=g_head_1.rvw01 AND rvw08=l_rvw08 AND rvw09=l_rvw09
      END IF
   END IF
   CALL i140_b_fill(' 1=1')

   #FUN-C80027--ADD--STR
   SELECT SUM(rvw05),SUM(rvw06) INTO g_head_1.rvw05_sum,g_head_1.rvw06_sum
     FROM rvw_file
    WHERE rvw01=g_head_1.rvw01
    LET g_head_1.sum3=g_head_1.rvw05f_sum+g_head_1.rvw06f_sum
    LET g_head_1.sum4=g_head_1.rvw05_sum+g_head_1.rvw06_sum
    DISPLAY BY NAME g_head_1.rvw05_sum,g_head_1.rvw06_sum
    DISPLAY BY NAME g_head_1.sum3,g_head_1.sum4
   #FUN-C80027--ADD--END

   LET g_head_1.rvw05f_s=g_head_1.rvw05f_sum LET g_head_1.rvw06f_s=g_head_1.rvw06f_sum
   DISPLAY BY NAME g_head_1.rvw05f_sum,g_head_1.rvw06f_sum
   DISPLAY BY NAME g_head_1.rvw05f_s,g_head_1.rvw06f_s
END FUNCTION

FUNCTION i140_set_entry_b(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1     #NO FUN-690009 VARCHAR(01)

   CALL cl_set_comp_entry("rvw09,rvw17,rvw05f,rvw06f",TRUE)
END FUNCTION

FUNCTION i140_set_no_entry_b(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1     #NO FUN-690009 VARCHAR(01)

   CALL cl_set_comp_entry("rvw09,rvw17,rvw05f,rvw06f",FALSE)
END FUNCTION

#計算未生成請款的入庫數量、衝暫估數量
FUNCTION i140_rvw10()
   DEFINE l_sql    LIKE type_file.chr1000 #NO FUN-690009 VARCHAR(300)
   DEFINE l_apb09  LIKE apb_file.apb09   #衝暫估數量
   LET l_sql = " SELECT abs(SUM(rvw10)) ",        #No.TQC-7B0164 取絕對值。
               "   FROM rvw_file ",
               "  WHERE rvw01 NOT IN ",
               "(SELECT DISTINCT apk03 ",
               "   FROM apk_file,apa_file,apb_file ",
               "  WHERE apk01 = apa01 ",
               "    AND apa01 = apb01 ",
               "    AND apb21 = '",g_rvw[l_ac].rvw08,"' ",
               "    AND apb22 = ",g_rvw[l_ac].rvw09,") ",
               "    AND rvw01 <> '",g_head_1.rvw01,"'", #No.TQC-7B0164
               "    AND rvw99 = '",g_rvw[l_ac].rvw99,"' ",    #FUN-A20006
               "    AND rvw08 = '",g_rvw[l_ac].rvw08,"' ",
               "    AND rvw09 = ",g_rvw[l_ac].rvw09," "
   PREPARE i140_pb1 FROM l_sql
   IF STATUS THEN CALL cl_err('prepare:',STATUS,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE rvw_curs1 CURSOR FOR i140_pb1
   OPEN rvw_curs1
   FETCH rvw_curs1 INTO g_rvw10
   IF cl_null(g_rvw10) THEN LET g_rvw10 = 0 END IF
   SELECT SUM(abs(apb09)) INTO l_apb09    #MOD-880206  #No.MOD-910007 add
     FROM apb_file,apa_file
    WHERE apa01 = apb01
      AND apa08 <> 'UNAP'   #TQC-6C0126
      AND apb21 = g_rvw[l_ac].rvw08
      AND apb22 = g_rvw[l_ac].rvw09
   IF cl_null(l_apb09) THEN LET l_apb09 = 0 END IF
   LET g_rvw10 = g_rvw10 + l_apb09   #TQC-6C0126
END FUNCTION

FUNCTION i140_rvw99()
   LET g_errno = ''

   SELECT * FROM azp_file,azw_file
    WHERE azp01 = azw01 AND azp01 = g_rvw[l_ac].rvw99
      AND azw02 = g_legal
   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'agl-171'
        OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

   LET g_plant_new = g_rvw[l_ac].rvw99
   CALL s_gettrandbs()
   LET li_dbs = g_dbs_tra
END FUNCTION
#No.FUN-9C0072 精簡程式碼

#No.FUN-CB0048 ---start--- Add
FUNCTION i140_gen()
   DEFINE g_no1      LIKE apy_file.apyslip
   DEFINE g_argv2    STRING
   DEFINE l_str      STRING

   LET g_argv2 = "query"
   LET g_no1 = s_get_doc_no(g_head_1.rvw18)
   SELECT * INTO g_apy.* FROM apy_file WHERE apyslip = g_no1
   IF g_apy.apykind = '11' THEN
      LET l_str = "aapt110 '",g_head_1.rvw18,"' '",g_argv2,"'"
   ELSE
      LET l_str = "aapt210 '",g_head_1.rvw18,"' '",g_argv2,"'"
   END IF
  #CALL cl_cmdrun(l_str)       #No.FUN-CB0053  Mark
   CALL cl_cmdrun_wait(l_str)  #No.FUN-CB0053  Add

END FUNCTION
#No.FUN-CB0048 ---end  --- Add

#FUN-CB0080--add--str--
FUNCTION i140_b_menu()
DEFINE   l_rvw05f_s        LIKE rvw_file.rvw05

   WHILE TRUE
      CALL i140_list_bp("G")
      IF NOT cl_null(g_action_choice) AND l_ac1>0 THEN #將清單的資料回傳到主畫面
         LET g_jump=l_ac1
         LET mi_no_ask = TRUE
         CALL i140_fetch('/')
      END IF
      IF cl_null(g_action_choice) THEN
         CALL cl_set_act_visible("accept,cancel", FALSE)
      END IF
      IF g_action_choice!= "" THEN
         LET g_bp_flag = 'main'
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
             CALL i140_fetch('/')
         END IF
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page2", TRUE)
       END IF

      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i140_a()
            END IF
            EXIT WHILE
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i140_q()
            END IF
            EXIT WHILE
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i140_r()
            END IF
            EXIT WHILE
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i140_u()
            END IF
            EXIT WHILE
         #FUN-D10064--add--str--
        WHEN "invalid"
            IF cl_chk_act_auth() THEN
               CALL i140_x()
               CALL i140_show()
            END IF
       #FUN-D10064--add--end
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i140_b()
            ELSE
               LET g_action_choice = NULL
            END IF
            EXIT WHILE
         #依單據輸入發票
         WHEN "Input_Invoice_By_No"
            IF g_type = '2' THEN
               CALL cl_err('','aap-900',0)
            ELSE
               LET g_cmd = "gapi120 '",g_type,"' '",g_head_1.rvw01,"'"
               CALL cl_cmdrun(g_cmd)
               #避免兩支作業同時對rvw_file操作的錯誤
               IF NOT cl_null(g_head_1.rvw01) THEN
                  CALL cl_used(g_prog,g_time,2) RETURNING g_time
                  EXIT PROGRAM
               END IF
            END IF

         WHEN "Carry_Account"
            IF NOT cl_null(g_head_1.rvw01) AND cl_null(g_head_1.rvw18) THEN
               SELECT SUM(rvw05f) INTO l_rvw05f_s FROM rvw_file
                WHERE rvw01 = g_head_1.rvw01
               IF cl_null(l_rvw05f_s) THEN
                  LET l_rvw05f_s = 0
               END IF
               IF l_rvw05f_s >= 0 THEN
                  LET g_cmd = "aapp110 '' '' '",g_head_1.rvw19,"' '' '' '' '' '' '1' 'N' '",g_head_1.rvw01,"'"   #No.FUN-CB0053   Add
               ELSE
                  LET g_cmd = "aapp111 '' '3' '4' '' '",g_head_1.rvw19,"' '' '' '",g_user,"' '",g_clas,"' '' 'N' '",g_head_1.rvw01,"'" #No.FUN-CB0053 Add
               END IF
               CALL cl_cmdrun(g_cmd)
            END IF

         WHEN "gen_da"
            IF cl_chk_act_auth() THEN
               IF NOT cl_null(g_head_1.rvw18) THEN
                  CALL i140_gen()
               END IF
            END IF

         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"
            CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_rvw),'','')

         WHEN "related_document"  #相關文件
           IF cl_chk_act_auth() THEN
              IF g_head_1.rvw01 IS NOT NULL THEN
                LET g_doc.column1 = "rvw01"
                LET g_doc.value1 = g_head_1.rvw01
                CALL cl_doc()
              END IF
          END IF
         OTHERWISE
            EXIT WHILE
      END CASE
   END WHILE
END FUNCTION

FUNCTION i140_list_bp(p_ud)
DEFINE p_ud       LIKE type_file.chr1
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY g_rvw_1 TO s_rvw_1.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF
      BEFORE ROW
         LET l_ac1 = ARR_CURR()
      ON ACTION main
         LET g_bp_flag = 'main'
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
             CALL i140_fetch('/')
         END IF
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page2", TRUE)
         EXIT DISPLAY
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      #依單據輸入發票
      ON ACTION input_invoice_by_no
         LET g_action_choice= "Input_Invoice_By_No"
         EXIT DISPLAY
      #拋轉帳款
      ON ACTION carry_account
         LET g_action_choice= "Carry_Account"
         EXIT DISPLAY
      ON ACTION gen_da
         LET g_action_choice= "gen_da"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
      #FUN-D10064--add--str--
      ON ACTION invalid
         LET g_action_choice="invalid"
         EXIT DISPLAY
      #FUN-D10064--add--end

      ON ACTION first
         CALL i140_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF

      ON ACTION previous
         CALL i140_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF

      ON ACTION jump
         CALL i140_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF

      ON ACTION next
         CALL i140_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF

      ON ACTION last
         CALL i140_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         IF g_rec_b1 != 0 THEN
            CALL fgl_set_arr_curr(g_curs_index)
         END IF

      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY

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
      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      ON ACTION accept
         LET l_ac1 = ARR_CURR()
         LET g_jump = l_ac1
         LET mi_no_ask = TRUE
         LET g_bp_flag = NULL
         CALL i140_fetch('/')
         CALL cl_set_comp_visible("info", FALSE)
         CALL cl_set_comp_visible("page2", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page2", TRUE)
         CALL cl_set_comp_visible("info", TRUE)
         EXIT DISPLAY

      ON ACTION cancel
             LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON ACTION related_document
         LET g_action_choice="related_document"
         EXIT DISPLAY
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel",TRUE)
END FUNCTION
FUNCTION i140_list_fill()
DEFINE l_rvw01         LIKE rvw_file.rvw01
DEFINE l_i             LIKE type_file.num10

   CALL g_rvw_1.clear()
   LET l_i = 1
   FOREACH i140_list_cs INTO g_rvw_1[l_i].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach i140_list_cs',SQLCA.sqlcode,1)
         CONTINUE FOREACH
      END IF
      SELECT pmc03 INTO g_rvw_1[l_i].pmc03_1 FROM pmc_file
       WHERE pmc01=g_rvw_1[l_i].rvv06_1
      LET l_i = l_i + 1
      IF l_i > g_max_rec THEN
         IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   LET g_rec_b1 = l_i - 1
   DISPLAY ARRAY g_rvw_1 TO s_rvw_1.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION
#FUN-CB0080--add--end

#FUN-D10064--add--str--
FUNCTION i140_x()
   DEFINE l_cnt LIKE type_file.num5

   IF s_shut(0) THEN RETURN END IF
   IF g_head_1.rvw01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   SELECT COUNT(*) INTO l_cnt FROM apk_file
   WHERE apk03 = g_head_1.rvw01
     AND apk28 = g_head_1.rvw07
     AND apk01 IN (SELECT apa01 FROM apa_file)

   IF l_cnt > 0 THEN
      CALL cl_err('','apm-241',0)
      RETURN
   END IF
   BEGIN WORK
   OPEN i140_cl USING g_head_1.rvw01
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE i140_cl
      ROLLBACK WORK
      RETURN
   ELSE
      FETCH i140_cl INTO
            g_head_1.rvw01,g_head_1.rvw07,g_head_1.rvw02,g_head_1.rvw18,g_head_1.rvw19,g_head_1.rvw03, #MOD-DC0088 add rvw18
            g_head_1.rvw04,g_head_1.rvw11,g_head_1.rvw12,g_head_1.rvwacti,
            g_head_1.rvwuser,g_head_1.rvwgrup,g_head_1.rvwmodu,
            g_head_1.rvwdate,g_head_1.rvworiu,g_head_1.rvworig
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_head_1.rvw01,SQLCA.sqlcode,0)  # 資料被他人LOCK
         CLOSE i140_cl ROLLBACK WORK RETURN
      END IF
   END IF

   IF cl_exp(0,0,g_head_1.rvwacti) THEN
      LET g_chr=g_head_1.rvwacti
      IF g_head_1.rvwacti='N' THEN
         LET g_head_1.rvwacti='Y'
      ELSE
         LET g_head_1.rvwacti='N'
      END IF

      UPDATE rvw_file
      SET rvwacti=g_head_1.rvwacti,
          rvwmodu=g_user,
          rvwdate=g_today
      WHERE rvw01 = g_head_1.rvw01

      IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err3("upd","rvw_file",g_head_1.rvw01,"",SQLCA.sqlcode,"","",1)
         LET g_head_1.rvwacti=g_chr
         LET g_success = 'N'
      END IF
      IF g_success = 'N' THEN
         ROLLBACK WORK
         CLOSE i140_cl
         RETURN
      END IF

      DISPLAY g_head_1.rvwacti,g_user,g_today TO rvwacti,rvwmodu,rvwdate
      CALL i140_list_fill()
    END IF
    CLOSE i140_cl
    COMMIT WORK

END FUNCTION
#FUN-D10064--add--end
FUNCTION i140_out()
DEFINE l_wc STRING
DEFINE l_cmd  STRING
LET l_wc = 'rvw01="',g_head_1.rvw01,'"'
      LET l_cmd = " cxmr140 " CLIPPED,
                  " '",g_today CLIPPED,"' ''",
                  " '",g_lang CLIPPED,"' 'N' '' '1'",
                  " '",l_wc CLIPPED,"' 'N' 'N' '0' 'N'"
      CALL cl_cmdrun(l_cmd)
END FUNCTION

