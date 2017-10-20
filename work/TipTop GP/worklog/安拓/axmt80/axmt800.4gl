# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#
# Pattern name...: axmt800.4gl
# Descriptions...: 訂單變更單維護作業
# Date & Author..: 97/10/09 By Lynn
# Modify ........: 99/06/02 By Sophia 單頭增加變更稅別,收款條件,幣別
# Modify ........: 99/07/08 By Carol  加簽核處理
# Modify.........: No:7684 03/08/06 Nicola 訂單變更應可以無單身做確認, 因有可能只變更單頭資料
# Modify.........: No:7647 03/08/15 Carol 訂單變更作業若是新增或變更料號時應考慮oaz46此參數來給oeb11值
# Modify.........: No:7798 03/08/15 Carol 若有變更數量時,應立即重算金額並顯示
# Modify.........: No:8037 03/09/05 Kammy 顯示錯誤誤訊不正確
# Modify.........: No:9458 04/04/15 Melody array增加到200(Genero不適用)
# Modify.........: No:MOD-490242 04/09/17 Melody 新增一筆料件時,品名未代出
# Modify.........: No:MOD-490371 04/09/23 By Kitty Controlp 未加display
# Modify.........: No:MOD-490359 04/10/01 By Mandy 變更單身料號後,品名欄位未代出or代出錯誤
# Modify.........: No:FUN-4A0023 04/10/08 By Carol t800_b() add q_oeb2()
# Modify.........: No.FUN-4B0038 04/11/15 By pengu ARRAY轉為EXCEL檔
# Modify.........: No:FUN-4C0006 04/12/03 By Carol 單價/金額欄位放大(20),位數改為dec(20,6)
# Modify.........: No:FUN-4C0057 04/12/09 By Carol Q,U,R 加入權限控管處理
# Modify.........: No:MOD-4C0041 04/12/13 By Echo  查看"簽核狀況"的button
# Modify.........: No:MOD-510132 05/01/18 By ching 新增時default values
# Modify.........: No:MOD-510061 05/03/02 By ching 多角重拋檢查
# Modify.........: No:MOD-530354 axmt800為非標準雙檔單身, 不應提供單身轉excel功能 ,應將action(轉excel)拿掉
# Modify.........: No:MOD-530870 05/03/30 By Smapmin 將VARCHAR轉為CHAR
# Modify.........: No:MOD-540061 05/04/07 By Echo 送簽中可發出,沒有控管; 按確認時，已確認的單子沒有error message提示
# Modify         : No:FUN-550031 05/05/11 by Echo 複製功能，無判斷單別是否簽核，狀態碼修改為combobox。
#                                                 將確認與簽核流程拆開獨立。
# Modify.........: No:FUN-550070 05/05/26 By Will 單據編號放大
# Modify.........: No:MOD-560007 05/06/02 By Echo   重新定義整合FUN名稱
# Modify.........: No:FUN-560106 05/06/19 By Carrier 雙單位內容修改
# Modify.........: No:FUN-550131 05/06/23 By Lifeng 多屬性料件修改
# Modify.........: No:MOD-560189 05/07/07 By Mandy 單身新增時才需判斷,此訂單有無此項次(若無代表為新增line)
# Modify.........: No:MOD-570401 05/08/04 By Nicola 等拋轉完成後，再繼續向下執行
# Modify.........: No:FUN-580113 05/08/24 By Sarah 以EF為backend engine,由TIPTOP處理前端簽核動作
# Modify.........: NO.MOD-590175 05/09/16 BY yiting 單身輸入單位時，若與原單位一致有錯誤訊息
# Modify.........: NO:MOD-5A0093 05/10/11 By Rosayu axmt410的Change_status Action無法串到axmt800資料
# Modify.........: NO:MOD-5A0232 05/10/21 By Nicola g_oea901的值重抓
# Modify.........: NO:MOD-5B0119 05/11/10 By Nicola 查詢時，判斷錯誤
# Modify.........: No:FUN-610006 06/01/07 By Smapmin 雙單位畫面調整
# Modify.........: No:FUN-610076 06/01/20 By Nicola 計價單位功能改善
# Modify.........: No:TQC-620160 06/03/01 By saki 用cl_set_comp_visible隱藏label元件
# Modify.........: No:FUN-630006 06/03/10 By Nicola 訂單分配量check修改
# Modify.........: No:FUN-640025 06/04/08 By Nicola 改用oea37判斷是否分配
# Modify.........: No:MOD-640304 06/04/12 By pengu 若已經有開出通單，訂單變更數量不能低於出通單數量
# Modify.........: No:FUN-560263 06/05/08 By kim 增加 "價格條件","交運資料" 變更
# Modify.........: No.TQC-650108 06/05/25 By day 新增料件多屬性功能
# Modify.........: No:FUN-640248 06/05/26 By Echo 自動執行確認功能
# Modify.........: No:MOD-640429 06/07/05 By Pengu 1.子單位數量清成空白時會一直跳不過去,會一直顯示數量小於已出貨數量
                                #                  2.參考數量修改為 0 時會將 子數量 / 計價數量都歸 0
# Modify.........: No:MOD-660086 06/07/05 By Sarah 查詢一筆未確認的單號後按新增再放棄,再按作廢,之前查詢的那筆會被作廢掉
# Modify.........: No:FUN-680006 06/08/02 By kim GP3.5 利潤中心
# Modify.........: NO:MOD-670129 06/08/03 By Claire 變更同料號數量時控卡備置量,變更料號時將原備置量取消
# Modify.........: NO.FUN-670007 06/08/07 by Yiting 1.確認時需check是否有轉請購單資料
#                                                   2.訂單變更發出時，沒有拋轉成功，發出碼應為N
# Modify.........: No.FUN-650140 06/09/04 By Sarah 訂單變更發出修改oea_file後才CALL t800_hu1()
# Modify.........: No:FUN-680137 06/09/11 By bnlent 欄位型態用LIKE定義
# Modify.........: No:FUN-690022 06/09/21 By jamie 判斷imaacti
# Modify.........: No:FUN-6A0094 06/11/01 By yjkhero l_time轉g_time
# Modify.........: No:CHI-6A0004 06/11/06 By Jackho 本幣取位修改
# Modify.........: No:FUN-6A0092 06/11/13 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No:FUN-6A0020 06/11/21 By jamie 1.FUNCTION _fetch() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modify.........: NO:MOD-670128 06/12/06 By Claire 刪除時也要刪除備註檔
# Modify.........: NO:MOD-690091 06/12/07 By Claire 變更訂購量時,金額要重計免稅金額
# Modify.........: No:MOD-6A0085 06/12/13 By pengu 訂單變更若該訂單有合約訂單來源，則有數量變更時
# Modify.........: No:FUN-570259 06/12/15 By Sarah 逆拋時,檢查終站是否有"未確認出貨單",若有則warning                                                  亦要一併回寫合約單的"已訂數量"
# Modify.........: NO:MOD-6C0107 06/12/22 By Claire 變更訂購項次時,要確認該項次是否已結案
# Modify.........: NO:TQC-6C0109 06/12/27 By kim 異動料號時,檢驗否也要異動
# Modify.........: NO:CHI-6A0020 07/01/03 By jamie 變更後單位維持不重抓轉換率
# Modify.........: NO:MOD-710031 07/01/08 By Claire 當未稅金額為0或null時控卡
# Modify.........: No.MOD-710064 07/01/12 By claire 已出貨訂單料號,單位,品名及規格調整為noentry
# MDdify.........: NO.FUN-710019 07/01/12 BY yiting S/O變更時，如果己拋過請購單，予以警告
# Modify.........: No:FUN-710046 07/01/31 By cheunl 錯誤訊息匯整
# Modify.........: No:FUN-730018 07/03/28 By kim 行業別架構
# Modify.........: No:CHI-740014 07/04/16 By oea32 查詢應該可以輸入
# Modify.........: No:FUN-740016 07/04/18 By Nicola 借出管理
# Modify.........: No:MOD-740224 07/04/22 By Nicola 語法修改
# Modify.........: No.MOD-740444 07/04/24 By claire chk_oea06() sql條件不可用訂單號碼應用多角序號
# Modify.........: No.TQC-750041 07/05/11 By arman 查詢時，狀態欄位信息都顯示灰色，不能根據其查詢
# Modify.........: No.MOD-750095 07/05/21 By claire 新增時不考慮存在有作廢的單據
# Modify.........: No:FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No:MOD-760049 07/06/11 By claire FUN-560263少加入判斷條件
# Modify.........: No:MOD-760071 07/06/14 By claire 訂單變更項次為原訂單沒有的項次時,料號,單位,數量,交貨日不可空白
# Modify.........: No:MOD-760079 07/06/21 By claire 訂單變更項次為原訂單沒有的項次時,要考慮加入oeb11
# Modify.........: No:MOD-780141 07/08/17 By claire 未稅金額要再重計,記免數量變更後又清空值
# Modify.........: No:MOD-780242 07/08/23 By claire 使用多單位,及計價單位時,變更料號後要帶出變更後的單位一及單位二及訂單數量對計價數量的轉換
# Modify.........: No:MOD-760026 07/08/24 By claire 新增的訂單變更單項次拋轉時僅更新本站並未更新其它站
# Modify.........: No:MOD-760123 07/08/24 By claire 銷售逆拋時變更訂單數量不可小於已出貨量
# Modify.........: No:TQC-760209 07/08/29 By claire 檢驗否應取自obk11而非ima24
# Modify.........: No:MOD-790051 07/09/13 By claire 當g1()已更新單頭後,若仍失敗,oep90不應給2已發出,應待g_success='Y'再給值
# Modify.........: No:CHI-7B0023 07/11/19 By kim 移除GP5.0行業別功能的所有程式段
# Modify.........: No:TQC-7B0111 07/11/19 By lumxa    axmt800沒有考慮折扣和搭贈
# Modify.........: No:MOD-7C0017 07/12/04 By claire 變更後數量清空後計價單位仍有值
# Modify.........: No:MOD-810092 08/02/21 By claire 已出貨料號變更時訊息調整(axm-292->axm-276)
# Modify.........: No:MOD-810195 08/02/21 By claire 給初始值否則會誤判axm-292
# Modify.........: No:FUN-7C0017 07/12/06 By bnlent 新增行業別字段 axmt800.4gl ->axmt800.src.4gl
# Modify.........: No:FUN-7B0018 08/02/27 By hellen 行業比拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No:FUN-7B0077 08/03/11 By mike   新增ICD功能
# Modify.........: No:FUN-830132 08/03/27 By hellen 行業比拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.FUN-840042 08/04/10 by TSD.zeak 自訂欄位功能修改
# Modify.........: No:MOD-840145 08/04/18 By claire 輸入中的變更後料號在未完成輸入時,又回頭改料號,品名規格應清空
# Modify.........: No:TQC-840047 08/04/18 By claire 輸入中的變更後料號在未完成輸入時,又回頭改料號,單位清空
# Modify.........: No:MOD-840367 08/04/23 By hongmei 增加開啟"訂單單價低於取出單價"對單價的控制
# Modify.........: No:MOD-860060 08/06/09 By Nicola 變更數量後系統一直出現"未稅金額不等於(單價*數量)",無法離開此訊息;若任意輸入未稅金額則可跳離此訊息!!
# Modify.........: NO.MOD-860078 08/06/06 BY Yiting ON IDLE 處理
# Modify.........: No:MOD-860134 08/06/12 By Smapmin 抓取oeb920時條件應為訂單單號/項次
# Modify.........: No:MOD-830169 08/07/14 By jan  對變量oeb1012和oeb1006進行賦值，避免出現null現象
# Modify.........: No:MOD-820066 08/07/14 By jan  修改金額計算，將單價*折扣率后的單價進行取位后再與數量相乘得到金額。與應收系統金額計算相同。
# Modify.........: No:MOD-830016 08/07/15 By jan  修正MOD-820066。需判斷折扣率是否為null，若為null則應該賦值為100
# Modify.........: No:CHI-860042 08/07/22 By xiaofeizhu 加入一般采購和委外采購的判斷
# Modify.........: No:MOD-870339 08/07/31 By Smapmin 當oeq12a需顯示時才設為必要輸入欄位
# Modify.........: No:MOD-880003 08/08/01 By Smapmin 修改訂單變更單做變更發出時,回寫產品客戶資料的部份
# Modify.........: No:MOD-880038 08/08/06 By Smapmin 回寫合約單的已訂數量時,應考慮單位換算的問題
# Modify.........: No:MOD-880047 08/08/07 By Smapmin 修正MOD-840367
# Modify.........: No:MOD-880088 08/08/12 By Pengu 重查時付款條件會無法正常顯示
# Modify.........: No:MOD-880104 08/08/14 By wujie 變更料號時，對應的客戶料號也要變更
# Modify.........: No:MOD-880178 08/08/22 By wujie 變更和審核時，也需要檢查訂單數量
# Modify.........: No:MOD-880250 08/09/01 By Smapmin 單身項次不設為no_entry
# Modify.........: No:MOD-870273 08/09/03 By claire 修改單價需回寫ima33
# Modify.........: No:MOD-890137 08/09/19 By Smapmin 修改原有訂單項次時,客戶產品編號未update到訂單中
# Modify.........: No:MOD-890224 08/09/25 By Smapmin 單價未預設
# Modify.........: No:FUN-890128 08/10/07 By Vicky 確認段_chk()與異動資料_upd()若只需顯示提示訊息不可用cl_err()寫法,應改為cl_getmsg()
# Modify.........: No:MOD-8A0137 08/10/17 By chenl 若計價單位與銷售單位相同，則計價數量等于銷售數量，不必通過轉換取得，以避免尾數。
# Modify.........: No:MOD-8A0155 08/10/17 By claire 更新資料要加上key值 oep02序號
# Modify.........: No:MOD-8A0154 08/10/17 By chenl 若使用計價單位，則取價應用計價單位。
# Modify.........: No:FUN-8A0081 08/10/20 By Vicky 補上DISPLAY oag02的值
# Modify.........: No:MOD-8A0186 08/10/21 By chenyu 1.銷售數量也變更時，計價數量等于原來的銷售數量
#                                                   2.新增加單身時，如果使用計價單位但是不使用雙單位，帶出的計價單位不是默認的而是等于銷售單位
# Modify.........: No:FUN-8A0086 08/10/22 By lutingting完善錯誤訊息匯總
# Modify.........: No:MOD-8A0245 08/10/28 By Smapmin 給予變數初始值
# Modify.........: No:MOD-8B0291 08/11/28 By Smapmin 若為新增的訂單項次,輸入單位時未檢核
# Modify.........: No:MOD-8C0119 08/12/15 By Smapmin 價格條件取價方式設為自行輸入,單價應default為''
# Modify.........: No:MOD-8C0281 08/12/29 By Smapmin 重新抓取單價時,金額也要一併計算.
# Modify.........: No:MOD-8C0289 08/12/30 By Smapmin 修改狀態時,g_oeb1012沒有給值,導致金額未計算
# Modify.........: No:MOD-910032 09/01/06 By Smapmin 狀態頁簽無法查詢
# Modify.........: No:MOD-910035 09/01/06 By Smapmin 無變更資料時,整張單據需刪除
# Modify.........: No:MOD-910057 09/01/07 By Smapmin 借出量已全數歸還,提示不需再做展延的動作
# Modify.........: No:MOD-910144 09/01/14 By Smapmin 修改單身項次時,料號等欄位未重新抓取
# Modify.........: No.CHI-910021 09/01/15 By xiaofeizhu 有select bmd_file或select pmh_file的部份，全部加入有效無效碼="Y"的判斷
# Modify.........: No:MOD-920030 09/02/03 By Smapmin 給予變數初始值
# Modify.........: No:FUN-920031 09/02/04 By ve007 排定交貨日(oeb16)預設同約定交貨日(oeb15)
# Modify.........: No:FUN-910082 09/02/02 By ve007 wc,sql 定義為STRING
# Modify.........: No:MOD-920057 09/02/05 By Smapmin 訂單變更單新增訂單項次時,若有使用利潤中心功能,成本中心的default應與訂單登打時相同
#                                                    若無default時,就不可確認與發出.
# Modify.........: No:MOD-920164 09/02/12 By Smapmin 借出量已全數歸還,提示後應卡關
# Modify.........: No:MOD-920227 09/02/18 By Smapmin 單身僅修改未稅金額時,會出現無單身資料...的錯誤訊息
# Modify.........: No:MOD-920300 09/02/24 By Smapmin 已有出貨資料,料號/單位不可修改
# Modify.........: No:MOD-920299 09/02/24 By Smapmin 銷售/庫存單位換算率未update
# Modify.........: No:MOD-920324 09/02/25 By Smapmin 新增訂單項次時,未給oeb28/oeb920預設值
# Modify.........: No:MOD-930236 09/03/27 By Smapmin 變更母單位(oeq23a)時，不會抓出正確的換算率(oeq24a)
# Modify.........: No:MOD-940195 09/04/14 By Smapmin 多行業別單身資料重複
# Modify.........: No:MOD-940283 09/04/22 By Dido 針對 tri-021 訊息增加正拋條件
# Modify.........: No:MOD-940334 09/04/24 By Smapmin 維護備註時,輸入相同序號程式會跑無窮迴圈
# Modify.........: No:MOD-940354 09/04/30 By Smapmin axm1003的訊息判斷,要再加上oea00=9
# Modify.........: No:MOD-940401 09/05/03 By Dido l_oeb12,l_oeb23,l_ogb12 在每一個擷入前做歸0的動作
# Modify.........: No:FUN-950007 09/05/12 By sabrina 跨主機資料拋轉，shell手工調整
# Modify.........: No:MOD-950163 09/05/15 By sabrina 執行memo時，會將g_prog的值變成null，故在做整合時會抓取不到g_prog
# Modify.........: No.MOD-960001 09/06/11 By Dido 發出失敗時,重新顯示狀況碼
# Modify.........: No.TQC-950054 09/06/22 By jan updat行業別檔時，KEY值一并update
# Modify.......... No.MOD-960263 09/06/22 By mike 針對oeb1012給預設值,卻未insert into至oeb_file中
# Modify.........: No.FUN-960066 09/07/02 By Mandy 若單據需要跟EASYFLOW整合，將"信用額度"的檢查時間點調整為=>按下EASYFLOW送簽按鈕當下
# Modify.........: No.MOD-970109 09/07/15 By baofei數值欄位預設值給NULL
# Modify.........: No.TQC-980145 09/08/20 By lilingyu AFTER FIELD oeq25a時,在if g_ima906 = '3' then 里面加判斷 if g_ima906 = '2',這樣無法執行到
# Modify.........: No.MOD-980177 09/08/22 By Smapmin 針對obk_file的異動,新增時檢驗否相關欄位來自於ima_file,修改時不異動
# Modify.........: No.FUN-980010 09/08/24 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No:MOD-980273 09/09/01 By Smapmin 數量不可小於等於0
# Modify.........: No:FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-990030 09/09/21 By chenmoyan 在單身增加 原因碼oeq30a,oeq30b
# Modify.........: No.FUN-980093 09/09/24 By TSD.sar2436  GP5.2 跨資料庫語法修改
# Modify.........: No:FUN-920102 09/09/28 By mike 查詢時,單身展延原因增加開窗.
# Modify.........: No.CHI-960033 09/10/10 By chenmoyan 加pmh22為條件者，再加pmh23=''
# Modify.........: No.CHI-960022 09/10/15 By chenmoyan 預設單位一數量時，加上判斷，單位一數量為空或為1時，才預設
# Modify.........: No.CHI-960052 09/10/15 By chenmoyan 使用多單位，料件是單一單位或參考單位時，單位一的轉換率錯誤
# Modify.........: No.TQC-9A0114 09/10/22 By wujie     5.2轉用標準sql語法
# Modify.........: No:MOD-9A0146 09/10/22 By Dido 若為簽核時給予 gi_ccc_logerr初始值
# Modify.........: No.TQC-9A0168 09/10/28 By liuxqa order by 修改。
# Modify.........: No:MOD-9A0193 09/11/02 By Smapmin AFTER INSERT 判斷沒做異動後就跳出程式
# Modify.........: No:MOD-9B0010 09/11/03 By Smapmin MOD-8B0019追單
# Modify.........: No:MOD-9B0044 09/11/09 By Smapmin 規格未UPDATE回訂單單身
# Modify.........: No:MOD-9B0094 09/11/16 By Dido 改用單身檢核訂單
# Modify.........: No:MOD-9B0104 09/11/17 By Smapmin 簽核否未即時顯示
# Modify.........: No:MOD-9C0018 09/12/02 By lilingyu 當使用多單位,且系統設置不使用計價單位時,變更銷售單位,計價單位并沒有一起改變
# Modify.........: No:FUN-9C0083 09/12/16 By mike 取价call s_fetch_price_new()
# Modify.........: No:FUN-9C0120 09/12/21 By mike 通过价格条件管控未取到价格时单价栏位是否可以人工输入
# Modify.........: No:MOD-9C0326 09/12/24 By Smapmin 單身原因碼若屬於樣品時，建議不受取出單價控管
# Modify.........: No:FUN-9C0152 09/12/25 By mike 取价时，若新的价格条件为空，则优先抓取旧的价格条件，若还是抓不到，则从客户档抓取价格条件
# Modify.........: No:CHI-9C0060 10/01/04 By Smapmin INSERT INTO obk_file時,obk11 default 為'N'
# Modify.........: No:MOD-A10002 10/01/05 By Smapmin 料件為參考單位時,才由單位二default單位一
# Modify.........: No:FUN-9C0071 10/01/12 By huangrh 精簡程式
# Modify.........: No:MOD-A10123 10/02/03 By Smapmin oeb1006若為空時,default 100
# Modify.........: No:MOD-A20109 10/02/25 By Smapmin 判斷是否結案要加上變更序號的條件
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No:FUN-A20057 10/03/04 By Smapmin 增加變更人員
# Modify.........: No:MOD-A40018 10/04/07 By Smapmin 多單位的default值不應只限制於新增的情況
#                                                    變更發出時,要再判斷若為單一單位,則母單位要清空.
# Modify.........: No:MOD-A40066 10/04/14 By Smapmin 多角訂單變更時,若各站的訂單已有轉工單的記錄,要顯示警告訊息
# Modify.........: No:MOD-A50049 10/05/07 By lilingyu 1.做axmp800拋轉前,先檢查g_success 是否為Y,如果為N,則表示已經錯誤不需拋轉 2.MARK t800_chk_oea06()
# Modify.........: No:MOD-A50009 10/05/04 By sabrina CALL s_signx1為舊的簽核功能，目前已不使用
# Modify.........: No:MOD-A40185 10/05/10 By Smapmin 已產生至出通/出貨單,不可修改料號
# Modify.........: No:MOD-A60009 10/06/08 By Smapmin 無效的料號不可登打
# Modify.........: No:FUN-A50103 10/06/03 By Nicola 訂單多帳期 1.變更訂金/出貨/尾款比率金額欄位 2.訂金/尾款多帳期資料變更
# Modify.........: No.FUN-A50102 10/07/01 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:MOD-A70005 10/07/27 By Smapmin 畫面多增加含稅金額的變更
# Modify.........: No:MOD-A70049 10/07/27 By Smapmin 新增項次時才做數量不可為0的控卡,修改項次時不做控卡.
#                                                    而為了避免有數量為0,金額卻有值的情況,當數量為0,金額也只能為0.
# Modify.........: No:MOD-A70077 10/07/27 By Smapmin 若幣別有變更,幣別取位要也跟著變更
# Modify.........: No:MOD-A70098 10/07/27 By Smapmin 打完單位一數量後,沒有即時更新金額
# Modify.........: No:CHI-A60026 10/08/02 By Summer 變更價格條件時，詢問是否update單價
# Modify.........: No:MOD-A80030 10/08/13 By Smapmin 若先前有做過一般訂單變更後，再做借貨訂單變更時，會無法輸入單身的預計歸還日、展延原因碼
# Modify.........: No:MOD-A80114 10/08/16 By Smapmin 隱藏的單據單位與數量有錯
# Modify.........: No:FUN-A80118 10/08/24 By xiaofeizhu 訂單變更改良
# Modify.........: No:CHI-A80030 10/09/06 By Summer 在各功能執行完COMMIT WORK後增加CALL cl_flow_notify()
# Modify.........: No:MOD-A90054 10/09/08 By Smapmin 單位一與計價單位做單位合理性檢核時有錯
# Modify.........: No:MOD-A90087 10/09/13 By Smapmin 訂單單身MISC料是可以改品名,故訂單變更單應要依照此作法.
#                                                    但程式只判斷oeq04a<>'MISC'就將oeq041a設定noentry,但沒考量oeq04a沒有登打時的狀況.
# Modify.........: No:CHI-A90019 10/10/13 By Summer 不管變更前與變更後的料號是否相同?都要帶出對應的變更後的品名資料
# Modify.........: No:FUN-AA0059 10/10/25 By chenying 料號開窗控管
# Modify.........: No:FUN-AB0082 10/12/08 By shiwuying 增加基础价格oeq37a,oeq37b;取價sub更改
# Modify.........: No:TQC-AB0152 10/12/06 By wangxin BUG修改
# Modify.........: No:MOD-AC0117 10/12/14 By lilingyu 訂單變更料件時,單價取不到
# Modify.........: No:TQC-AB0025 10/12/14 By chenying oeq02 是NUMBER型
# Modify.........: No:FUN-B10014 11/01/07 By shiwuying 零售不可以打變更單
# Modify.........: No:MOD-B20119 11/02/22 By lilingyu 訂單變更沒有刪除多帳期資料oepa_file
# Modify.........: No:TQC-B20162 11/02/23 By zhangll 調整單頭各欄位錄入順序
# Modify.........: No:MOD-B30198 11/03/11 By zhangweib 修正離開oep10b時，欄位值會變成名稱
# Modify.........: No:MOD-B30561 11/03/18 By suncx 如有訂金和尾款，則在離開單身時開啟訂金/尾款多帳期畫面
# Modify.........: No:FUN-B20060 11/04/07 By zhangll 增加oeb72赋值
# Modify.........: No:MOD-B40079 11/04/12 By lilingyu 審核時報錯axm-967
# Modify.........: No:MOD-B40099 11/04/18 By Summer 開窗無法查詢合約訂單
# Modify.........: No:FUN-B30063 11/04/22 By suncx 變更發出時加判斷客戶訂單號是否為NULL
# Modify.........: No:TQC-B40206 11/04/25 By lilingyu EF簽核相關問題修改
# Modify.........: No:FUN-B50158 11/05/24 By lixiang 更改幣別和稅別後進行確認
# Modify.........: No:MOD-B60008 11/06/01 By Smapmin 變更數量不能大於oeb24+oeb23才合理.
# Modify.........: No.FUN-B50064 11/06/03 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.MOD-B60080 11/06/15 By Summer 沒有修改單價時oeq13a會是null
# Modify.........: No:MOD-B70041 11/07/06 By JoHung 新項次料號欄位應重新開放
# Modify.........: No:FUN-B70087 11/07/21 By zhangll 增加oah07控管，s_unitprice_entry增加传参
# Modify.........: No:FUN-B30081 11/08/01 By lixiang 增加頁簽其他資料，修改交易資料頁簽的內容
# Modify.........: No:TQC-B80053 11/08/04 By suncx 更改訂金尾款金額BUG修正
# Modify.........: No:CHI-B80012 11/08/05 By johung 數量修改時詢問是否重新取價
# Modify.........: No:MOD-B80105 11/08/10 By johung 調整up_price()中SQLCA.SQLCODE位置
# Modify.........: No:CHI-B80016 11/08/11 By johung 依s_mpslog判斷是否取消異動
# Modify.........: No:MOD-B80192 11/08/19 By johung 單身數量、價格變動時，詢問是否更新單頭金額，依比率更新
#                                                   修改單身重新取價的判斷
# Modify.........: No:MOD-B80196 11/08/22 By johung 修正 只變更數量，不變更計價數量，確定時仍會將數量預設給計價數量的問題
# Modify.........: No:TQC-B80186 11/08/26 By lixia 查詢欄位
# Modify.........: No:MOD-B80339 11/09/03 By johung 修正訂單變更2次以上時，訂金多帳期輸入會控卡-239的問題
# Modify.........: No:MOD-B90023 11/09/06 By johung 金額欄位不可修改
# Modify.........: No:FUN-910088 11/10/13 By chenjing 增加數量欄位小數取位
# Modify.........: No:MOD-BC0120 12/01/30 By Vampire 使用計價單位時，需使用計價數量計算
# Modify.........: No:MOD-C10153 12/01/30 By Vampire 出通、出貨單未確認，則連出通、出貨單一起變更稅別，稅別變更後需詢問，已確認的出通、出貨單，則訂單變更單不可變更稅別
# Modify.........: No:MOD-C10181 12/01/30 By Vampire DEFINE l_p_amt 改為 LIKE oea_file.oea61

# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No:MOD-BA0087 12/02/03 By Summer axm-497重算金額的地方未重新做取位
# Modify.........: No:MOD-C10080 12/02/03 By Summer t800_set_oeq27變更後單位oeq05a沒有輸入時,應改用變更前單位判斷
# Modify.........: No:FUN-C20028 12/02/04 By Abby EF功能調整-客戶不以整張單身資料送簽問題
# Modify.........: No:FUN-BC0071 12/02/08 By huangtao 增加取價參數
# Modify.........: No:MOD-C20013 12/02/13 by jt_chen 修正重新查詢，沒有自動帶出理由碼的中文說明。
# Modify.........: No:TQC-C20211 12/02/16 By Vampire 修正MOD-C10153,錯誤訊息各區要統一
# Modify.........: No:TQC-C20183 12/02/20 By chenjing 增加數量欄位小數取位
# Modify.........: No:MOD-C30462 12/03/16 By dongsz 現程式中都是抓oma54t,改成依判斷單頭含稅否來決定是與oma54還是oma54t比
# Modify.........: No:FUN-C30278 12/03/28 By bart 判斷imaicd05改為判斷imaicd04
# Modify.........: No:FUN-C30289 12/04/03 By bart 所有程式的Multi Die隱藏 帶出EndUser
# Modify.........: No.FUN-C40089 12/05/02 By bart 判斷銷售價格條件(axmi060)的oah08,若oah08為Y則單價欄位可輸入0;若oah08為N則單價欄位不可輸入0
# Modify.........: No:MOD-C50002 12/05/08 By Elise 業態為零售業的時候才顯示"基礎單價"欄位
# Modify.........: No:FUN-BC0088 12/05/10 By Vampire 判斷MISC料可輸入單價
# Modify.........: No:MOD-C50097 12/05/15 By Elise SQL少了UNIQUE會造成上下筆功能錯誤
# Modify.........: No.FUN-C50074 12/05/18 By bart 更改錯誤訊息代碼
# Modify.........: No:MOD-C50154 12/05/24 By Vampire 使用多單位母子單位時,oeq12a會給值,導致確認段判斷不為null時會控卡數量
# Modify.........: No.CHI-C30002 12/05/25 By yuhuabao 離開單身時若單身無資料提示是否刪除單頭資料
# Modify.........: No.CHI-C30107 12/06/12 By yuhuabao  整批修改將確認的詢問窗口放到chk段的前面
# Modify.........: No:MOD-C40077 12/06/15 By Vampire 取消確認時請排除已作廢的訂單變更單
# Modify.........: No:FUN-C30085 12/07/04 By nanbing CR改串GR
# Modify.........: No:FUN-C50136 12/07/11 By chenjing 增加訂單變更單信用控管
# Modify.........: No:TQC-C70161 12/07/24 By zhuhao 變更后交貨日期控管
# Modify.........: No:TQC-C70209 12/07/30 By zhuhao 預計歸還日控管
# Modify.........: No:FUN-C60076 12/08/27 By Lori 新增記錄變更前後的客戶產品編號
# Modify.......... No:CHI-C80060 12/08/27 By pauline 令oeb72預設值為null
# Modify.........: No:FUN-C40081 12/09/05 By Lori 新增變更前後的訂單性質(oep16,oep16b)
# Modify.........: No:FUN-C40080 12/09/05 By Lori 新增變更前後的銷售分類(oep25,oep26,oep25b,oep26b)
# Modify.........: No:FUN-C20109 12/09/05 By Lori 新增變更前後的起運地(oep41,oep41b)
# Modify.........: No:FUN-C70021 12/09/14 By Lori 訂單來源是合約,輸入新增的資料不在訂單中時,以料號反推回合約
# Modify.........: No:CHI-C90034 12/09/21 By Lori 償價訂單同一般訂單，相關欄位皆可變更，除料號欄位
# Modify.........: No:FUN-CA0009 12/10/03 By pauline 當原訂單來源為借貨訂單時,單身開放可變更數量(oeq12a),並且oeq12a不可小於oeb24
# Modify.........: No.MOD-C60036 12/10/15 By Vampire 請調整訂單變更單增加控卡訂單變更單的數量要不可小於已轉採購量
# Modify.........: No.MOD-C70061 12/10/15 By Vampire 訂單變更單維護作業控卡非合約上的料號
# Modify.........: No.MOD-C70245 12/10/15 By Vampire 訂單變更單交貨日期請比照訂單增加控卡axm-330
# Modify.........: No:MOD-C90099 12/10/15 By Vampire 增加判斷單價是否含稅,訂金,出貨,尾款一併檢查
# Modify.........: No:MOD-C80195 12/10/19 By Nina 判斷項次新舊值,先INITIALIZE g_oeq[l_ac].* TO NULL再自動帶出資料
# Modify.........: No:TQC-CB0032 12/11/13 By xuxz 訂單變更后的數量小於訂單已備置量，系統沒有控卡
# Modify.........: No.CHI-C80041 12/11/28 By bart 取消單頭資料控制
# Modify.........: No:CHI-C40019 12/12/14 By Lori 已有出通單/出貨單的訂單不可再變更交易資料和單價,避免影響後續的應收帳款
# Modify.........: No:MOD-D10014 13/01/04 By Vampire FUN-910088修改錯誤,引用陣列錯誤
# Modify.........: No.FUN-C30315 13/01/09 By Nina 只要程式有UPDATE ima_file 的任何一個欄位時,多加imadate=g_today
# Modify.........: No.FUN-CC0094 13/01/22 By xujing 變更發出增加發出人員日期時間欄位
# Modify.........: No:FUN-CC0007 12/12/17 By Sakura 新增ACTION 指定料件特性
# Modify.........: No:FUN-D20025 13/02/22 By chenying 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No.CHI-C50063 13/02/04 By Elise (1) 單身欄位開放查詢
#                                                  (2) 增加開窗，修正開窗
# Modify.........: No:MOD-D10096 13/02/26 By Elise 當有出貨單/出通單時，關閉單身單價欄位不讓使用者修改
# Modify.........: No:MOD-CB0279 13/02/26 By Elise 排除作廢單據
# Modify.........: No:MOD-CB0025 13/02/26 By Elise 排除作廢單據
# Modify.........: No:MOD-D10148 13/03/07 By jt_chen 若有變更料號，也需更新 oeb05_fac
# Modify.........: No:MOD-D20152 13/03/08 By Elise 判斷ima130=0(不可銷售產品)，不可輸入。
# Modify.........: No:MOD-D20057 13/03/12 By jt_chen 若為多角單據，不須控卡axm1162
# Modify.........: No:MOD-D20074 13/03/12 By jt_chen 控卡apm-299錯誤訊息應調整為 axm1179
# Modify.........: No:MOD-D10109 13/03/12 By jt_chen (1) 參考 t800_set_oeq27() axm-072 的空卡，使用 sic06 的數量，在計價數量增加控卡增加控卡 axm-919 檢核
#                                                    (2) 統一調整 AFTER FIELD oeq12a
# Modify.........: No:MOD-D30073 13/03/13 By Vampire 價格條件設定不能人工輸入,且單價不可為零,造成無窮迴圈
# Modify.........: No.MOD-D30115 13/03/12 By SunLM 單身數量,單價變更后,單頭oep261b,oep262b,oep263b應該自動更新
# Modify.........: No.CHI-D10010 13/03/29 By Elise 變更單比照訂單新增時的單別權限控卡
# Modify.........: No.MOD-D30265 13/03/29 By Vampire 當數量變更前後皆為 0 時，不需要將欄位值清空，否則無法確定。
# Modify.........: No.FUN-D30090 13/04/01 By jt_chen 季會決議：新增訂單變更單,輸入訂單單號時檢查是已經否存在出通單,增加提示訊息:此訂單已存在出通單,是否做訂單變更
# Modify.........: No.MOD-D40009 13/04/02 By Vampire 調整當有變更尾款比率金額時，必須判斷督帳期的金額總計是否與訂單金額一致
# Modify.........: ------------- 15/09/21 By donghy  新增8条客户字段的变更操作

DATABASE ds

#GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"

DEFINE
    g_oep01x        LIKE oea_file.oea01, #No.FUN-680137 VARCHAR(13)
    g_oep           RECORD LIKE oep_file.*,       #訂單單號 (假單頭)
    g_oep_t         RECORD LIKE oep_file.*,       #訂單單號 (舊值)
    g_oep_o         RECORD LIKE oep_file.*,       #訂單單號 (舊值)
    g_oep01_t       LIKE oep_file.oep01,          #變更單號 (舊值)
    g_oep02_t       LIKE oep_file.oep02,          #No.TQC-9A0114
    g_oeq           DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
        oeq03       LIKE oeq_file.oeq03,   #項次
        before      LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
        oeq04b      LIKE oeq_file.oeq04b,  #變更前料號(變更前)
        oeq041b     LIKE oeq_file.oeq041b, #品名
        ima021b     LIKE ima_file.ima021,  #規格
        oeq11b      LIKE oeq_file.oeq11b,  #客戶產品編號   #FUN-C60076
        oeq30b      LIKE oeq_file.oeq30b,  #No.FUN-990030
        oeq05b      LIKE oeq_file.oeq05b,  #單    位
        oeq12b      LIKE oeq_file.oeq12b,  #數    量
        oeq23b      LIKE oeq_file.oeq23b,  #單位二
        oeq24b      LIKE oeq_file.oeq24b,  #單位二轉換率
        oeq25b      LIKE oeq_file.oeq25b,  #單位二數量
        oeq20b      LIKE oeq_file.oeq20b,  #單位一
        oeq21b      LIKE oeq_file.oeq21b,  #單位一轉換率
        oeq22b      LIKE oeq_file.oeq22b,  #單位一數量
        oeq26b      LIKE oeq_file.oeq26b,  #計價單位
        oeq27b      LIKE oeq_file.oeq27b,  #計價數量
        oeq37b      LIKE oeq_file.oeq37b,  #單    價   #FUN-AB0082
        oeq13b      LIKE oeq_file.oeq13b,  #單    價
        oeq14b      LIKE oeq_file.oeq14b,  #金    額
        oeq14tb     LIKE oeq_file.oeq14tb, #含稅金額   #MOD-A70005
        #FUN-A80118--Add--Begin
        oeq31b      LIKE oeq_file.oeq31b,
        oeq32b      LIKE oeq_file.oeq32b,
        oeq33b      LIKE oeq_file.oeq33b,
        #FUN-A80118--Add--End
        oeq15b      LIKE oeq_file.oeq15b,  #交 貨 日
        oeq28b      LIKE oeq_file.oeq28b,   #No:FUN-740016
        oeq29b      LIKE oeq_file.oeq29b,   #No:FUN-740016
        oeqiicd01b  LIKE oeqi_file.oeqiicd01b,  #No:FUN-7C0017
        oeqiicd02b  LIKE oeqi_file.oeqiicd02b,  #No:FUN-7C0017
        oeqiicd03b  LIKE oeqi_file.oeqiicd03b,  #No:FUN-7C0017
        oeqiicd04b  LIKE oeqi_file.oeqiicd04b,  #No:FUN-7C0017
        ta_oeq01b   LIKE oeq_file.ta_oeq01b,
        ta_oeq02b   LIKE oeq_file.ta_oeq02b,
        ta_oeq03b   LIKE oeq_file.ta_oeq03b,
        ta_oeq04b   LIKE oeq_file.ta_oeq04b,
        ta_oeq05b   LIKE oeq_file.ta_oeq05b,
        ta_oeq06b   LIKE oeq_file.ta_oeq06b,
        ta_oeq07b   LIKE oeq_file.ta_oeq07b,
        ta_oeq08b   LIKE oeq_file.ta_oeq08b,
        ta_oeq09b   LIKE oeq_file.ta_oeq09b,
        ta_oeq10b   LIKE oeq_file.ta_oeq10b,
        ta_oeq11b   LIKE oeq_file.ta_oeq11b,
        tc_oaf03b   LIKE tc_oaf_file.tc_oaf03,
        after       LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
        oeq04a      LIKE oeq_file.oeq04a,  #變更後料號(變更後)
        oeq041a     LIKE oeq_file.oeq041a, #品名
        ima021a     LIKE ima_file.ima021,  #規格
        oeq11a      LIKE oeq_file.oeq11a,  #客戶產品編號  #FUN-C60076
        oeq30a      LIKE oeq_file.oeq30a,  #No.FUN-990030
        oeq05a      LIKE oeq_file.oeq05a,  #單    位
        oeq12a      LIKE oeq_file.oeq12a,  #數    量
        oeq23a      LIKE oeq_file.oeq23b,  #單位二
        oeq24a      LIKE oeq_file.oeq24b,  #單位二轉換率
        oeq25a      LIKE oeq_file.oeq25b,  #單位二數量
        oeq20a      LIKE oeq_file.oeq20b,  #單位一
        oeq21a      LIKE oeq_file.oeq21b,  #單位一轉換率
        oeq22a      LIKE oeq_file.oeq22b,  #單位一數量
        oeq26a      LIKE oeq_file.oeq26b,  #計價單位
        oeq27a      LIKE oeq_file.oeq27b,  #計價數量
        oeq37a      LIKE oeq_file.oeq37a,  #單    價 #FUN-AB0082
        oeq13a      LIKE oeq_file.oeq13a,  #單    價
        oeq14a      LIKE oeq_file.oeq14a,  #金    額
        oeq14ta     LIKE oeq_file.oeq14ta, #含稅金額   #MOD-A70005
        #FUN-A80118--Add--Begin
        oeq31a      LIKE oeq_file.oeq31a,
        oeq32a      LIKE oeq_file.oeq32a,
        oeq33a      LIKE oeq_file.oeq33a,
        #FUN-A80118--Add--End
        oeq15a      LIKE oeq_file.oeq15a,  #交 貨 日
        oeq28a      LIKE oeq_file.oeq28a,   #No:FUN-740016
        oeq29a      LIKE oeq_file.oeq29a,   #No:FUN-740016
        oeqiicd01a  LIKE oeqi_file.oeqiicd01a,  #No:FUN-7C0017
        oeqiicd02a  LIKE oeqi_file.oeqiicd02a,  #No:FUN-7C0017
        oeqiicd03a  LIKE oeqi_file.oeqiicd03a,  #No:FUN-7C0017
        oeqiicd04a  LIKE oeqi_file.oeqiicd04a,  #No:FUN-7C0017
        ta_oeq01a   LIKE oeq_file.ta_oeq01a,
        ta_oeq02a   LIKE oeq_file.ta_oeq02a,
        ta_oeq03a   LIKE oeq_file.ta_oeq03a,
        ta_oeq04a   LIKE oeq_file.ta_oeq04a,
        ta_oeq05a   LIKE oeq_file.ta_oeq05a,
        ta_oeq06a   LIKE oeq_file.ta_oeq06a,
        ta_oeq07a   LIKE oeq_file.ta_oeq07a,
        ta_oeq08a   LIKE oeq_file.ta_oeq08a,
        ta_oeq09a   LIKE oeq_file.ta_oeq09a,
        ta_oeq10a   LIKE oeq_file.ta_oeq10a,
        ta_oeq11a   LIKE oeq_file.ta_oeq11a,
        tc_oaf03a   LIKE tc_oaf_file.tc_oaf03,
        oeq50       LIKE oeq_file.oeq50    #備    註
                    END RECORD,
    g_oeq_t         RECORD                 #程式變數 (舊值)
        oeq03       LIKE oeq_file.oeq03,   #項次
        before      LIKE type_file.chr1,   #No.FUN-680137 VARCHAR(1)
        oeq04b      LIKE oeq_file.oeq04b,  #變更前料號(變更前)
        oeq041b     LIKE oeq_file.oeq041b, #品名
        ima021b     LIKE ima_file.ima021,  #規格
        oeq11b      LIKE oeq_file.oeq11b,  #客戶產品編號    #FUN-C60076
        oeq30b      LIKE oeq_file.oeq30b,  #No.FUN-990030
        oeq05b      LIKE oeq_file.oeq05b,  #單    位
        oeq12b      LIKE oeq_file.oeq12b,  #數    量
        oeq23b      LIKE oeq_file.oeq23b,  #單位二
        oeq24b      LIKE oeq_file.oeq24b,  #單位二轉換率
        oeq25b      LIKE oeq_file.oeq25b,  #單位二數量
        oeq20b      LIKE oeq_file.oeq20b,  #單位一
        oeq21b      LIKE oeq_file.oeq21b,  #單位一轉換率
        oeq22b      LIKE oeq_file.oeq22b,  #單位一數量
        oeq26b      LIKE oeq_file.oeq26b,  #計價單位
        oeq27b      LIKE oeq_file.oeq27b,  #計價數量
        oeq37b      LIKE oeq_file.oeq37b,  #單    價   #FUN-AB0082
        oeq13b      LIKE oeq_file.oeq13b,  #單    價
        oeq14b      LIKE oeq_file.oeq14b,  #金    額
        oeq14tb     LIKE oeq_file.oeq14tb, #含稅金額   #MOD-A70005
        #FUN-A80118--Add--Begin
        oeq31b      LIKE oeq_file.oeq31b,
        oeq32b      LIKE oeq_file.oeq32b,
        oeq33b      LIKE oeq_file.oeq33b,
        #FUN-A80118--Add--End
        oeq15b      LIKE oeq_file.oeq15b,  #交 貨 日
        oeq28b      LIKE oeq_file.oeq28b,   #No:FUN-740016
        oeq29b      LIKE oeq_file.oeq29b,   #No:FUN-740016
        oeqiicd01b  LIKE oeqi_file.oeqiicd01b,  #No:FUN-7C0017
        oeqiicd02b  LIKE oeqi_file.oeqiicd02b,  #No:FUN-7C0017
        oeqiicd03b  LIKE oeqi_file.oeqiicd03b,  #No:FUN-7C0017
        oeqiicd04b  LIKE oeqi_file.oeqiicd04b,  #No:FUN-7C0017
        ta_oeq01b   LIKE oeq_file.ta_oeq01b,
        ta_oeq02b   LIKE oeq_file.ta_oeq02b,
        ta_oeq03b   LIKE oeq_file.ta_oeq03b,
        ta_oeq04b   LIKE oeq_file.ta_oeq04b,
        ta_oeq05b   LIKE oeq_file.ta_oeq05b,
        ta_oeq06b   LIKE oeq_file.ta_oeq06b,
        ta_oeq07b   LIKE oeq_file.ta_oeq07b,
        ta_oeq08b   LIKE oeq_file.ta_oeq08b,
        ta_oeq09b   LIKE oeq_file.ta_oeq09b,
        ta_oeq10b   LIKE oeq_file.ta_oeq10b,
        ta_oeq11b   LIKE oeq_file.ta_oeq11b,
        tc_oaf03b   LIKE tc_oaf_file.tc_oaf03,
        after       LIKE type_file.chr1,   #No.FUN-680137 VARCHAR(1)
        oeq04a      LIKE oeq_file.oeq04a,  #變更後料號(變更後)
        oeq041a     LIKE oeq_file.oeq041a, #品名
        ima021a     LIKE ima_file.ima021,  #規格
        oeq11a      LIKE oeq_file.oeq11a,  #客戶產品編號   #FUN-C60076
        oeq30a      LIKE oeq_file.oeq30a,  #No.FUN-990030
        oeq05a      LIKE oeq_file.oeq05a,  #單    位
        oeq12a      LIKE oeq_file.oeq12a,  #數    量
        oeq23a      LIKE oeq_file.oeq23b,  #單位二
        oeq24a      LIKE oeq_file.oeq24b,  #單位二轉換率
        oeq25a      LIKE oeq_file.oeq25b,  #單位二數量
        oeq20a      LIKE oeq_file.oeq20b,  #單位一
        oeq21a      LIKE oeq_file.oeq21b,  #單位一轉換率
        oeq22a      LIKE oeq_file.oeq22b,  #單位一數量
        oeq26a      LIKE oeq_file.oeq26b,  #計價單位
        oeq27a      LIKE oeq_file.oeq27b,  #計價數量
        oeq37a      LIKE oeq_file.oeq37a,  #單    價 #FUN-AB0082
        oeq13a      LIKE oeq_file.oeq13a,  #單    價
        oeq14a      LIKE oeq_file.oeq14a,  #金    額
        oeq14ta     LIKE oeq_file.oeq14ta, #含稅金額   #MOD-A70005
        #FUN-A80118--Add--Begin
        oeq31a      LIKE oeq_file.oeq31a,
        oeq32a      LIKE oeq_file.oeq32a,
        oeq33a      LIKE oeq_file.oeq33a,
        #FUN-A80118--Add--End
        oeq15a      LIKE oeq_file.oeq15a,  #交 貨 日
        oeq28a      LIKE oeq_file.oeq28a,   #No:FUN-740016
        oeq29a      LIKE oeq_file.oeq29a,   #No:FUN-740016
        oeqiicd01a  LIKE oeqi_file.oeqiicd01a,  #No:FUN-7C0017
        oeqiicd02a  LIKE oeqi_file.oeqiicd02a,  #No:FUN-7C0017
        oeqiicd03a  LIKE oeqi_file.oeqiicd03a,  #No:FUN-7C0017
        oeqiicd04a  LIKE oeqi_file.oeqiicd04a,  #No:FUN-7C0017
        ta_oeq01a   LIKE oeq_file.ta_oeq01a,
        ta_oeq02a   LIKE oeq_file.ta_oeq02a,
        ta_oeq03a   LIKE oeq_file.ta_oeq03a,
        ta_oeq04a   LIKE oeq_file.ta_oeq04a,
        ta_oeq05a   LIKE oeq_file.ta_oeq05a,
        ta_oeq06a   LIKE oeq_file.ta_oeq06a,
        ta_oeq07a   LIKE oeq_file.ta_oeq07a,
        ta_oeq08a   LIKE oeq_file.ta_oeq08a,
        ta_oeq09a   LIKE oeq_file.ta_oeq09a,
        ta_oeq10a   LIKE oeq_file.ta_oeq10a,
        ta_oeq11a   LIKE oeq_file.ta_oeq11a,
        tc_oaf03a   LIKE tc_oaf_file.tc_oaf03,
        oeq50       LIKE oeq_file.oeq50    #備    註
                    END RECORD,
    g_wc,g_wc2,g_sql    string,  #No.FUN-560106  #No:FUN-580092 HCN
    l_flag          LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
    g_argv1         LIKE oeb_file.oeb01,          # INPUT ARGUMENT - 1
    g_argv2         LIKE oep_file.oep02,          #FUN-580113
    g_argv3         STRING,                       #FUN-640184
    g_oea           RECORD LIKE oea_file.*,       #訂單單號 (假單頭)
    exT             LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(01)
    g_delete        LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(01)
    g_key1          LIKE type_file.chr20,   #No.FUN-680137 VARCHAR(20)              #單號+序號
    g_sta           LIKE cre_file.cre08,    #No.FUN-680137 VARCHAR(10)              #狀態說明
    g_rec_b         LIKE type_file.num5,                #單身筆數  #No.FUN-680137 SMALLINT
    l_ac            LIKE type_file.num5,                #目前處理的ARRAY CNT  #No.FUN-680137 SMALLINT
    g_statu         LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(01)
    g_newline       LIKE type_file.chr1,    #新項次    #MOD-760071 add
    g_buf           LIKE type_file.chr1000 #FUN-560263  #No.FUN-680137 VARCHAR(30)
##FUN-CC0007---add---START
#  DEFINE g_oeqa     DYNAMIC ARRAY OF RECORD
#            oeqa03    LIKE oeqa_file.oeqa03,
#            before    LIKE type_file.chr1,
#            oeqa04   LIKE oeqa_file.oeqa04,
#            ini02     LIKE ini_file.ini02,
#            ini03     LIKE ini_file.ini03,
#            oeqa07b   LIKE oeqa_file.oeqa07b,
#            oeqa05b   LIKE oeqa_file.oeqa05b,
#            oeqa06b   LIKE oeqa_file.oeqa06b,
#            after     LIKE type_file.chr1,
#            oeqa07a   LIKE oeqa_file.oeqa07a,
#            oeqa05a   LIKE oeqa_file.oeqa05a,
#            oeqa06a   LIKE oeqa_file.oeqa06a
#                    END RECORD
#  DEFINE g_oeqa_t   RECORD
#            oeqa03    LIKE oeqa_file.oeqa03,
#            before    LIKE type_file.chr1,
#            oeqa04   LIKE oeqa_file.oeqa04,
#            ini02     LIKE ini_file.ini02,
#            ini03     LIKE ini_file.ini03,
#            oeqa07b   LIKE oeqa_file.oeqa07b,
#            oeqa05b   LIKE oeqa_file.oeqa05b,
#            oeqa06b   LIKE oeqa_file.oeqa06b,
#            after     LIKE type_file.chr1,
#            oeqa07a   LIKE oeqa_file.oeqa07a,
#            oeqa05a   LIKE oeqa_file.oeqa05a,
#            oeqa06a   LIKE oeqa_file.oeqa06a
#                    END RECORD
#DEFINE  l_ac1         LIKE type_file.num5
#DEFINE  l_ac4         LIKE type_file.num5
##FUN-CC0007---add-----END
 DEFINE
      g_up_flag    LIKE type_file.chr1,     #No.FUN-680137 VARCHAR(1)
      g_oea901     LIKE oea_file.oea901,    #三角貿易否
      g_oea905     LIKE oea_file.oea905,    #拋轉否
      g_oea906     LIKE oea_file.oea906,    #來源訂單否
      g_oeaconf    LIKE oea_file.oeaconf,   #確認否
      g_oeq05a,g_oeq05b    LIKE oeq_file.oeq05a,
      g_oeq04a,g_oeq04b    LIKE oeq_file.oeq04a,
      g_oeq041a,g_oeq041b  LIKE oeq_file.oeq041a,
      g_oeq03              LIKE oeq_file.oeq03,
      g_oeq30a,g_oeq30b    LIKE oeq_file.oeq30a,  #No.FUN-990030
      g_oeb17              LIKE oeb_file.oeb17,   #No:MOD-840367
      g_oeq12a,g_oeq12b    LIKE oeq_file.oeq12a,
      g_oeq13a,g_oeq13b    LIKE oeq_file.oeq13a,
      g_oeq37a,g_oeq37b    LIKE oeq_file.oeq37a,  #FUN-AB0082
      g_oeq04f,g_oeq05f    LIKE oeq_file.oeq04a,  #FUN-AB0082
      g_oeq14a,g_oeq14b,g_oeq14ta,g_oeq14tb    LIKE oeq_file.oeq14a,   #MOD-A70005 add g_oeq14tb
      g_oeq15a,g_oeq15b    LIKE oeq_file.oeq15a,
      g_oeq28a,g_oeq28b    LIKE oeq_file.oeq28a,   #No:FUN-740016
      g_oeq29a,g_oeq29b    LIKE oeq_file.oeq29a,   #No:FUN-740016
      g_oeq31a             LIKE oeq_file.oeq31a,   #FUN-A80118 Add
      g_oeq32a             LIKE oeq_file.oeq32a,   #FUN-A80118 Add
      g_oeq33a             LIKE oeq_file.oeq33a,   #FUN-A80118 Add
      g_ta_oeq01a,g_ta_oeq01b  LIKE oeq_file.ta_oeq01a,
      g_ta_oeq02a,g_ta_oeq02b  LIKE oeq_file.ta_oeq02a,
      g_ta_oeq03a,g_ta_oeq03b  LIKE oeq_file.ta_oeq03a,
      g_ta_oeq04a,g_ta_oeq04b  LIKE oeq_file.ta_oeq04a,
      g_ta_oeq05a,g_ta_oeq05b  LIKE oeq_file.ta_oeq05a,
      g_ta_oeq06a,g_ta_oeq06b  LIKE oeq_file.ta_oeq06a,
      g_ta_oeq07a,g_ta_oeq07b  LIKE oeq_file.ta_oeq07a,
      g_ta_oeq08a,g_ta_oeq08b  LIKE oeq_file.ta_oeq08a,
      g_ta_oeq09a,g_ta_oeq09b  LIKE oeq_file.ta_oeq09a,
      g_ta_oeq10a,g_ta_oeq10b  LIKE oeq_file.ta_oeq10a,
      g_ta_oeq11a,g_ta_oeq11b  LIKE oeq_file.ta_oeq11a
      #t_oeq14ta,t_oeq14tb    LIKE oeq_file.oeq14ta   #MOD-A70005
DEFINE g_laststage       LIKE type_file.chr1     #No.FUN-680137 VARCHAR(1)            #FUN-580113
DEFINE g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5    #No.FUN-680137 SMALLINT
DEFINE   g_chr           LIKE type_file.chr1       #No.FUN-680137 VARCHAR(1)
DEFINE   g_chr2          LIKE type_file.chr1       #No.FUN-680137 VARCHAR(1)
DEFINE   g_cnt           LIKE type_file.num10      #No.FUN-680137 INTEGER
DEFINE   g_msg           LIKE type_file.chr1000    #No.FUN-680137 VARCHAR(72)
DEFINE   g_row_count    LIKE type_file.num10       #No.FUN-680137 INTEGER
DEFINE   g_curs_index   LIKE type_file.num10       #No.FUN-680137 INTEGER
DEFINE   g_jump         LIKE type_file.num10       #No.FUN-680137 INTEGER
DEFINE   g_no_ask       LIKE type_file.num5        #No.FUN-680137 SMALLINT
DEFINE
    g_oeq11a,g_oeq11b    LIKE oeq_file.oeq11a,   #FUN-C60076
    g_oeq23a,g_oeq23b    LIKE oeq_file.oeq23a,
    g_oeq24a,g_oeq24b    LIKE oeq_file.oeq24a,
    g_oeq25a,g_oeq25b    LIKE oeq_file.oeq25a,
    g_oeq20a,g_oeq20b    LIKE oeq_file.oeq20a,
    g_oeq21a,g_oeq21b    LIKE oeq_file.oeq21a,
    g_oeq22a,g_oeq22b    LIKE oeq_file.oeq22a,
    g_oeq26a,g_oeq26b    LIKE oeq_file.oeq26a,
    g_oeq27a,g_oeq27b    LIKE oeq_file.oeq27a,
    g_oeq25              LIKE oeq_file.oeq25a,
    g_oeq24              LIKE oeq_file.oeq24a,
    g_oeq21              LIKE oeq_file.oeq21a,
    g_change             LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(01)
    g_oeq04              LIKE ima_file.ima01,
    g_ima25              LIKE ima_file.ima25,
    g_ima31              LIKE ima_file.ima31,
    g_ima906             LIKE ima_file.ima906,
    g_ima907             LIKE ima_file.ima907,
    g_ima908             LIKE ima_file.ima908,
    g_sw                 LIKE type_file.num5,    #No.FUN-680137 SMALLINT
    g_factor             LIKE img_file.img21,
    g_tot1               LIKE img_file.img10
DEFINE g_oeb920          LIKE oeb_file.oeb920    #No:FUN-630006
DEFINE g_oeb1006         LIKE oeb_file.oeb1006   #No:TQC-7B0111
DEFINE g_oeb1012         LIKE oeb_file.oeb1012   #No:TQC-7B0111
DEFINE g_oeb1001         LIKE oeb_file.oeb1001   #No.FUN-990030
DEFINE g_oay22           LIKE oay_file.oay22     #No.TQC-650108
DEFINE g_oea00           LIKE oea_file.oea00     #No:FUN-740016
DEFINE b_oeq             RECORD LIKE oeq_file.*  #No:FUN-7C0017
DEFINE g_oeb11           LIKE oeb_file.oeb11     #MOD-880003
DEFINE g_chk             LIKE type_file.chr1     #MOD-920300
DEFINE g_oep07           LIKE oep_file.oep07     #MOD-AC0117
DEFINE g_oep08           LIKE oep_file.oep08     #MOD-AC0117
DEFINE g_chg_oep14b      LIKE type_file.chr1     #FUN-B50158
#FUN-910088-add-start--
DEFINE g_oeq05a_t        LIKE oeq_file.oeq05a
DEFINE g_oeq20a_t        LIKE oeq_file.oeq20a
DEFINE g_oeq23a_t        LIKE oeq_file.oeq23a
DEFINE g_oeq26a_t        LIKE oeq_file.oeq26a
#FUN-910088-add-end--
DEFINE g_oah08           LIKE oah_file.oah08     #FUN-C40089
DEFINE g_oah04           LIKE oah_file.oah04     #MOD-D30073 add
DEFINE g_oab02_1         LIKE oab_file.oab02     #FUN-C40080
DEFINE g_oab02_1b        LIKE oab_file.oab02     #FUN-C40080
DEFINE g_oab02_2         LIKE oab_file.oab02     #FUN-C40080
DEFINE g_oab02_2b        LIKE oab_file.oab02     #FUN-C40080
DEFINE g_oac02           LIKE oac_file.oac02     #FUN-C20109
DEFINE g_oac02b          LIKE oac_file.oac02     #FUN-C20109
DEFINE g_ogb_cnt         LIKE type_file.num5     #CHI-C40019 add
DEFINE g_t1a             LIKE oay_file.oayslip   #CHI-D10010 add

MAIN
   IF FGL_GETENV("FGLGUI") <> "0" THEN
      OPTIONS                                #改變一些系統預設值
          INPUT NO WRAP                      #輸入的方式: 不打轉
         #FIELD ORDER FORM                   #整個畫面會依照p_per所設定的欄位順序(忽略4gl寫的順序)  #FUN-730018   #FUN-C60019 mark
      DEFER INTERRUPT
   END IF

    LET g_argv1     = ARG_VAL(1)         # 參數值(1) - 訂單單號
    LET g_argv2     = ARG_VAL(2)         # 參數值(2) - 序號       #FUN-640184
    LET g_argv3     = ARG_VAL(3)         # 參數值(3) - 功能       #FUN-640184


   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF

  #FUN-B10014 Begin---
   IF g_azw.azw04 = '2' THEN
      CALL cl_err('','axm-955',1)
      EXIT PROGRAM
   END IF
  #FUN-B10014 End-----

##FUN-CC0007---add---START
#     IF g_sma.sma94 = 'Y' THEN
#        CALL cl_set_act_visible("specify",TRUE)
#     ELSE
#        CALL cl_set_act_visible("specify",FALSE)
#     END IF
##FUN-CC0007---add-----END

   LET g_wc2=' 1=1'

    LET g_forupd_sql = "SELECT * FROM oep_file WHERE oep01 = ?  AND oep02 = ? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t800_cl CURSOR FROM g_forupd_sql

    CALL cl_used(g_prog,g_time,1) RETURNING g_time

    IF g_bgjob='N' OR cl_null(g_bgjob) THEN
       OPEN WINDOW t800_w WITH FORM "cxm/42f/axmt800"
             ATTRIBUTE (STYLE = g_win_style CLIPPED)
       CALL cl_ui_init()
       CALL cl_set_comp_visible("dummy16,oeqiicd03b,oeqiicd03a,dummy15,oeqiicd02b,oeqiicd02a",FALSE)  #FUN-C30289
    END IF

    CALL t800_def_form()

    LET g_oep.oep01 = NULL
   #LET g_ogb_cnt   = NULL   #CHI-C40019 add #MOD-D10096 mark

    IF fgl_getenv('EASYFLOW') = "1" THEN
       LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
       LET g_argv2 = aws_efapp_wsk(2)   #參數:key-2
    END IF

      #建立簽核模式時的 toolbar icon
      CALL aws_efapp_toolbar()

      IF NOT cl_null(g_argv1) THEN
         CASE g_argv3
            WHEN "efconfirm"
               CALL t800_q()
               CALL t800_y_chk()          #CALL 原確認的 check 段
               IF g_success = "Y" THEN
                  LET l_ac = 1
                  CALL t800_y_upd()       #CALL 原確認的 update 段
               END IF
               EXIT PROGRAM
            OTHERWISE
               CALL t800_q()
         END CASE
      END IF

      #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
      CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale,                                  void, undo_void,confirm, undo_confirm, easyflow_approval, change_release,   #FUN-D20025 add undo_void                                 memo,balance_multi_account,deposit_multi_account")
                                  #TQC-B40206 add balance_multi_account,deposit_multi_account
           RETURNING g_laststage

      CALL t800_menu()
   CLOSE t800_cl
   CLOSE WINDOW t800_w

   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION t800_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No:FUN-580031  HCN

   IF NOT cl_null(g_argv1) OR (NOT cl_null(g_argv2)
                                AND g_argv2 != 0) THEN  #No:MOD-5B0119
      IF NOT cl_null(g_argv1) THEN
         LET g_wc = "oep01 = '",g_argv1,"' "
      END IF

      IF  NOT cl_null(g_argv2) AND g_argv2 <> 0 THEN
          LET g_wc = g_wc, " AND oep02 = '",g_argv2,"'"
      END IF

      LET g_wc2= " 1=1"

   ELSE
      CLEAR FORM
      CALL g_oeq.clear()
      CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
   INITIALIZE g_oep.* TO NULL    #No.FUN-750051
      CONSTRUCT BY NAME g_wc ON oep01,oep02,oep04,oep12,oea03,oea32,oep09,oepconf,oepmksg, #CHI-740014 add oea32   #FUN-A20057 add oep12
                                oep06,oep07,oep08,oep10,oep11,
                                oep161,oep261,oep162,oep262,oep163,oep263,          #No:FUN-A50103
                                oep06b,oep07b,oep08b,oep10b,oep11b,                 #FUN-560263 add oep10,oep11
                                oep161b,oep261b,oep162b,oep262b,oep163b,oep263b,    #No:FUN-A50103
                                oepuser,oepgrup,oepmodu,oepdate,                    #MOD-910032
                                oeporiu,oeporig,                                    #TQC-B80186
                                oepsendu,oepsendd,                                  #FUN-CC0094
                                oepud01,oepud02,oepud03,oepud04,oepud05,
                                oepud06,oepud07,oepud08,oepud09,oepud10,
                                oepud11,oepud12,oepud13,oepud14,oepud15
                                #FUN-A80118--Add--Begin
                               ,oep13,oep14,oep15,oep14b,oep15b
                                #FUN-A80118--Add--End
                               ,oep16,oep16b                                        #FUN-C40081 add
                               ,oep25,oep26,oep25b,oep26b                           #FUN-C40080 add
                               ,oep41,oep41b                                        #FUN-C20109 add

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            ON ACTION CONTROLP
            CASE      #查詢符合條件的單號
               WHEN INFIELD(oep01)
                    CALL q_oea( TRUE,TRUE,g_oep.oep01,'','4') RETURNING g_qryparam.multiret #MOD-B40099 mod 3->4
                    DISPLAY g_qryparam.multiret TO oep01
                    NEXT FIELD oep01
               #-----FUN-A20057---------
               WHEN INFIELD(oep12)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_gen"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep12
                    CALL t800_peo('d',g_oep.oep12)
                    NEXT FIELD oep12
               #-----END FUN-A20057-----
               WHEN INFIELD(oea03)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_occ"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oea03
                    NEXT FIELD oea03
              WHEN INFIELD(oea32)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oag"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oea32
                   NEXT FIELD oea32
               WHEN INFIELD(oep06b)   #送貨地址
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_ocd"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep06b
                    NEXT FIELD oep06b
               WHEN INFIELD(oep06)   #送貨地址
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_ocd"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep06
                    NEXT FIELD oep06
               WHEN INFIELD(oep07b)   #價格條件
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_oag"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep07b
                    NEXT FIELD oep07b
               WHEN INFIELD(oep07)   #價格條件
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_oag"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep07
                    NEXT FIELD oep07
               WHEN INFIELD(oep08b)    #幣別
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_azi"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep08b
                    NEXT FIELD oep08b
               WHEN INFIELD(oep08)    #幣別
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_azi"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep08
                    NEXT FIELD oep08
               WHEN INFIELD(oep10)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_oah"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep10
                    NEXT FIELD oep10
               WHEN INFIELD(oep10b)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form ="q_oah"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oep10b
                    NEXT FIELD oep10b
                 WHEN INFIELD(oep11)
                      CALL cl_init_qry_var()
                      LET g_qryparam.state = "c"
                      LET g_qryparam.form ="q_ged"
                      CALL cl_create_qry() RETURNING g_qryparam.multiret
                      DISPLAY g_qryparam.multiret TO oep11
                 WHEN INFIELD(oep11b)
                      CALL cl_init_qry_var()
                      LET g_qryparam.state = "c"
                      LET g_qryparam.form ="q_ged"
                      CALL cl_create_qry() RETURNING g_qryparam.multiret
                      DISPLAY g_qryparam.multiret TO oep11b

              #FUN-A80118--Add--Begin
              WHEN INFIELD(oep13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_azf01a"
                   LET g_qryparam.arg1 = '1'
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep13
                   NEXT FIELD oep13

              WHEN INFIELD(oep14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_gec"
                   LET g_qryparam.arg1 = '2'
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep14
                   NEXT FIELD oep14

              WHEN INFIELD(oep14b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_gec"
                   LET g_qryparam.arg1 = '2'
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep14b
                   NEXT FIELD oep14b
              #FUN-A80118--Add--End

              #FUN-C40080 add begin---
              WHEN INFIELD(oep25)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oab"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep25
                   NEXT FIELD oep25
              WHEN INFIELD(oep26)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oab"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep26
                   NEXT FIELD oep26
              WHEN INFIELD(oep25b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oab"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep25b
                   NEXT FIELD oep25b
              WHEN INFIELD(oep26b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oab"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep26b
                   NEXT FIELD oep26b
              #FUN-C40080 add end-----

              #FUN-C20109 add begin---
              WHEN INFIELD(oep41)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oac"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep41
                   NEXT FIELD oep41
              WHEN INFIELD(oep41b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_oac"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oep41b
                   NEXT FIELD oep41b
              #FUN-C20109 add end-----
               OTHERWISE EXIT CASE
            END CASE
         ON ACTION controls                             #No.FUN-6A0092
            CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121

         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121

         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121

	#No:FUN-580031 --start--     HCN
         ON ACTION qbe_select
	   CALL cl_qbe_list() RETURNING lc_qbe_sn
	   CALL cl_qbe_display_condition(lc_qbe_sn)
	#No:FUN-580031 --end--       HCN
      END CONSTRUCT

      IF INT_FLAG THEN
         RETURN
      END IF

      LET g_wc = g_wc CLIPPED,cl_get_extra_cond('oepuser', 'oepgrup')

      CONSTRUCT g_wc2 ON oeq03, oeq04b,oeq041b,oeq30b,oeq05b,oeq12b,oeq23b,oeq24b,   #No.FUN-990030 add oeq30b #CHI-C50063 add oeq041b,oeq05b
                         oeq25b,oeq20b,oeq21b,oeq22b,oeq26b,
                         oeq27b,oeq37b,oeq13b,oeq14b,oeq14tb,oeq31b,oeq32b,oeq33b,oeq15b,oeq28b,oeq29b    #No:FUN-740016 #FUN-AB0082 #CHI-C50063 add oeq14b,oeq14tb,oeq31b,oeq32b,oeq33b
                        #,oeq31b,oeq32b,oeq33b  #CHI-C50063 move
                         ,oeq04a,oeq041a,oeq30a,oeq05a,oeq12a,        #CHI-C50063 oeq04a,oeq041a,oeq30a,oeq05a,oeq12a
                         oeq13a,oeq14a,oeq14ta,oeq31a,oeq32a,oeq33a   #FUN-A80118 Add #CHI-C50063 oeq13a,oeq14a,oeq14ta
                         ,oeq15a,oeq28a,oeq29a,oeq50                                  #CHI-C50063 add

                    FROM s_oeq[1].oeq03 ,s_oeq[1].oeq04b,s_oeq[1].oeq041b,s_oeq[1].oeq30b,s_oeq[1].oeq05b,s_oeq[1].oeq12b, #No.FUN-990030 add oeq30b #CHI-C50063 add oeq041b,oeq05b
                         s_oeq[1].oeq23b,s_oeq[1].oeq24b,s_oeq[1].oeq25b,
                         s_oeq[1].oeq20b,s_oeq[1].oeq21b,s_oeq[1].oeq22b,
                         s_oeq[1].oeq26b,s_oeq[1].oeq27b,
                         s_oeq[1].oeq37b,s_oeq[1].oeq13b,s_oeq[1].oeq14b,s_oeq[1].oeq14tb,  #CHI-C50063 addoeq14b,oeq14tb
                         s_oeq[1].oeq31b,s_oeq[1].oeq32b,s_oeq[1].oeq33b,s_oeq[1].oeq15b,   #FUN-AB0082 #CHI-C50063 add oeq31b,oeq32b,oeq33b
                         s_oeq[1].oeq28b,s_oeq[1].oeq29b    #No:FUN-740016
                        #,s_oeq[1].oeq31b,s_oeq[1].oeq32b,s_oeq[1].oeq33b                   #FUN-A80118 Add #CHI-C50063 move
                         ,s_oeq[1].oeq04a,s_oeq[1].oeq041a,s_oeq[1].oeq30a,s_oeq[1].oeq05a  #CHI-C50063 add
                         ,s_oeq[1].oeq12a,s_oeq[1].oeq13a,s_oeq[1].oeq14a,s_oeq[1].oeq14ta  #CHI-C50063 add
                         ,s_oeq[1].oeq31a,s_oeq[1].oeq32a,s_oeq[1].oeq33a                   #FUN-A80118 Add
                         ,s_oeq[1].oeq15a,s_oeq[1].oeq28a,s_oeq[1].oeq29a,s_oeq[1].oeq50    #CHI-C50063 add

		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121

         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121

         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121

                    ON ACTION qbe_save
		       CALL cl_qbe_save()

         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(oeq29b)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "q_azf"
                  LET g_qryparam.arg1 = "2"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oeq29b
                  NEXT FIELD oeq29b
               WHEN INFIELD(oeq30b)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_azf03"
                  LET g_qryparam.arg1 = "2"
                  LET g_qryparam.arg2 = "1"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO s_oeq[1].oeq30b
                  NEXT FIELD oeq30b
#FUN-A80118--Add--Begin
              WHEN INFIELD(oeq31b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pja2"
                  #CHI-C50063 mark---S
                  #LET g_qryparam.default1 = g_oeq[l_ac].oeq31b
                  #CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq31b
                  #DISPLAY BY NAME g_oeq[l_ac].oeq31b
                  #CHI-C50063 mark---E
                  #CHI-C50063---S
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq31b
                  #CHI-C50063---E
                   NEXT FIELD oeq31b
              WHEN INFIELD(oeq32b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pjb4"
                  #CHI-C50063 mark---S
                  #LET g_qryparam.default1 = g_oeq[l_ac].oeq32b
                  #LET g_qryparam.arg1 = g_oeq[l_ac].oeq31b
                  #CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq32b
                  #DISPLAY BY NAME g_oeq[l_ac].oeq32b
                  #CHI-C50063 mark---S
                  #CHI-C50063---S
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq32b
                  #CHI-C50063---E
                   NEXT FIELD oeq32b
              WHEN INFIELD(oeq33b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pjk3"
                  #CHI-C50063 mark---S
                  #LET g_qryparam.default1 = g_oeq[l_ac].oeq33b
                  #LET g_qryparam.arg1 = g_oeq[l_ac].oeq32b
                  #CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq33b
                  #DISPLAY BY NAME g_oeq[l_ac].oeq33b
                  #CHI-C50063 mark---E
                  #CHI-C50063---S
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq33b
                  #CHI-C50063---E
                   NEXT FIELD oeq33b
#FUN-A80118--Add--End
             #CHI-C50063------add------S
              WHEN INFIELD(oeq04b)
                   CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'') RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oeq04b
                   NEXT FIELD oeq04b
              WHEN INFIELD(oeq04a)
                   CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'') RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oeq04a
                   NEXT FIELD oeq04a
              WHEN INFIELD(oeq30a)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_azf03"
                  LET g_qryparam.arg1 = "2"
                  LET g_qryparam.arg2 = "1"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO s_oeq[1].oeq30a
                  NEXT FIELD oeq30a
              WHEN INFIELD(oeq29a)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.form = "q_azf"
                  LET g_qryparam.arg1 = "2"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oeq29a
                  NEXT FIELD oeq29a
              WHEN INFIELD(oeq31a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pja2"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq31a
                   NEXT FIELD oeq31a
              WHEN INFIELD(oeq32a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pjb4"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq32a
                   NEXT FIELD oeq32a
              WHEN INFIELD(oeq33a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state = "c"
                   LET g_qryparam.form ="q_pjk3"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO s_oeq[1].oeq33a
                   NEXT FIELD oeq33a
              WHEN INFIELD(oeq05a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gfe"
                   LET g_qryparam.state = 'c'
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oeq05a
                   NEXT FIELD oeq05a
              WHEN INFIELD(oeq05b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gfe"
                   LET g_qryparam.state = 'c'
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oeq05b
                   NEXT FIELD oeq05b
             #CHI-C50063------add------E
               OTHERWISE EXIT CASE
            END CASE
      END CONSTRUCT

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         RETURN
      END IF
   END IF

   IF g_wc2 = " 1=1" THEN                        #若單身未輸入條件
      LET g_sql = "SELECT oep01,oep02 FROM oep_file,oea_file ",   #No.TQC-9A0114
                  " WHERE ", g_wc CLIPPED," AND oep01 IS NOT NULL ",
                  "   AND oep01 = oea01 ",
                  " ORDER BY oep01"   #TQC-9A0168 mod
   ELSE
      LET g_sql= "SELECT UNIQUE oep01,oep02 ",    #No.TQC-9A0114  #MOD-C50097 add UNIQUE
                 " FROM oep_file, oeq_file,oea_file ",
                 " WHERE oep01 = oeq01 AND oep01 IS NOT NULL ",
                 "  AND  oep02 = oeq02 ",
                 "  AND oep01 = oea01 ",
                 "  AND ", g_wc CLIPPED, " AND ", g_wc2 CLIPPED,
                 " ORDER BY oep01 "    #TQC-9A0168 mod
   END IF

   PREPARE t800_prepare FROM g_sql      #預備一下
   DECLARE t800_b_cs                  #宣告成可捲動的
       SCROLL CURSOR WITH HOLD FOR t800_prepare

   DROP TABLE count_tmp

   IF g_wc2 = " 1=1" THEN                      # 取合乎條件筆數
      LET g_sql="SELECT oep01,oep02 FROM oep_file,oea_file ",
                " WHERE ", g_wc CLIPPED,
                "   AND oep01 = oea01 ",
                " GROUP BY oep01,oep02 ",
                " INTO TEMP count_tmp"
   ELSE
      LET g_sql="SELECT oep01,oep02 FROM oep_file,oeq_file,oea_file ",
                " WHERE ", g_wc CLIPPED," AND ",g_wc2 CLIPPED,
                "   AND oeq01 = oep01 ",
                "   AND oep01 = oea01 ",
                " GROUP BY oep01,oep02 ",
                " INTO TEMP count_tmp"
   END IF
   PREPARE t800_cnt_tmp  FROM g_sql
   EXECUTE t800_cnt_tmp
   DECLARE t800_count CURSOR FOR SELECT COUNT(*) FROM count_tmp

END FUNCTION

FUNCTION t800_menu()
   DEFINE l_creator   LIKE type_file.chr1     #No.FUN-680137  VARCHAR(1)         #「不准」時是否退回填表人 #FUN-580113
   DEFINe l_flowuser  LIKE type_file.chr1     #No.FUN-680137  VARCHAR(1)         # 是否有指定加簽人員      #FUN-580113
#   DEFINE p_gaq01     LIKE gaq_file.gaq01     #FUN-CC0007 add
#   DEFINE l_gaq01     STRING                  #FUN-CC0007 add
#   DEFINE l_oeq04     LIKE oeq_file.oeq04a    #FUN-CC0007 add
#   DEFINE l_ima928    LIKE ima_file.ima928    #FUN-CC0007 add
#   DEFINE l_n         LIKE type_file.num5     #FUN-CC0007 add

   LET l_flowuser = "N"   #FUN-580113

   WHILE TRUE
      CALL t800_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t800_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t800_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t800_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t800_u()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t800_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output"
            CALL t800_out()
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()

         #-----No:FUN-A50103-----
         WHEN "deposit_multi_account"   #訂金多帳期
            IF cl_chk_act_auth() THEN
               CALL t800_multi_account('1')
            END IF

         WHEN "balance_multi_account"   #尾款多帳期
            IF cl_chk_act_auth() THEN
               CALL t800_multi_account('2')
            END IF
         #-----No:FUN-A50103 END-----

         WHEN "confirm"
            IF cl_chk_act_auth()THEN
               CALL t800_y_chk()          #CALL 原確認的 check 段
               IF g_success = "Y" THEN
                  CALL t800_y_upd()       #CALL 原確認的 update 段
               END IF
            END IF
         WHEN "undo_confirm"
            IF cl_chk_act_auth()THEN
               CALL t800_z()
            END IF
         WHEN "void"
            IF cl_chk_act_auth()THEN
              #CALL t800_x()   #FUN-D20025
               CALL t800_x(1)  #FUN-D20025
            END IF
         #FUN-D20025--add--str--
         WHEN "undo_void"
            IF cl_chk_act_auth()THEN
               CALL t800_x(2)
            END IF
         #FUN-D20025--add--end--
##FUN-CC0007---add---START
#         WHEN "specify"                    #指定料件特性
#            IF cl_chk_act_auth() AND g_oep.oep01 IS NOT NULL THEN
#               SELECT COUNT(*) INTO l_n FROM oeq_file WHERE oeq01 = g_oep.oep01
#               IF l_n <> 0 THEN
#                  IF cl_null(g_oeq[l_ac].oeq04a) OR g_oeq[l_ac].oeq04a = '' THEN
#                     LET l_oeq04 = g_oeq[l_ac].oeq04b
#                  ELSE
#                     LET l_oeq04 = g_oeq[l_ac].oeq04a
#                  END IF
#                  SELECT ima928 INTO l_ima928
#                    FROM ima_file
#                   WHERE ima01 = l_oeq04
#                  IF l_ima928 = 'Y' THEN
#                     CALL t800_specify()
#                  ELSE
#                     LET p_gaq01= cl_get_feldname('ima01',g_lang)
#                     LET l_gaq01 = p_gaq01,':',l_oeq04
#                     CALL cl_err(l_gaq01,'axm1103',0)
#                  END IF
#               ELSE
#                  LET g_action_choice = NULL
#               END IF
#            END IF
##FUN-CC0007---add-----END
         WHEN "change_release"
            IF cl_chk_act_auth()THEN
               CALL t800_g()
            END IF
         WHEN "memo"
#TQC-B40206 --begin--
           IF g_oep.oep09 = 'S' THEN
              CALL cl_err('','apm-228',0)
           ELSE
#TQC-B40206 --end--
            CALL s_showmsg_init()               #No.FUN-710046
            CALL t800_memo()
            CALL s_showmsg()               #No.FUN-710046
           END IF  #TQC-B40206

         WHEN "easyflow_approval"           #FUN-550031
            IF cl_chk_act_auth() THEN
              #FUN-C20028 add str---
               SELECT * INTO g_oep.* FROM oep_file
                WHERE oep01 = g_oep.oep01
                  AND oep02 = g_oep.oep02
               CALL t800_show()
               CALL t800_b_fill(' 1=1')
              #FUN-C20028 add end---
               CALL t800_ef()
               CALL t800_show()  #FUN-C20028 add
            END IF
         #@WHEN "簽核狀況"
          WHEN "approval_status"               # MOD-4C0041 #FUN-550031
            IF cl_chk_act_auth() THEN  #DISPLAY ONLY
               IF aws_condition2() THEN
                    CALL aws_efstat2()                 #MOD-560007
               END IF
            END IF

      #@WHEN "准"
      WHEN "agree"
           IF g_laststage = "Y" AND l_flowuser = "N" THEN  #最後一關並且沒有加簽人員
              CALL t800_y_upd()      #CALL 原確認的 update 段
           ELSE
              LET g_success = "Y"
              IF NOT aws_efapp_formapproval() THEN
                 LET g_success = "N"
              END IF
           END IF
           IF g_success = 'Y' THEN
              IF cl_confirm('aws-081') THEN
                 IF aws_efapp_getnextforminfo() THEN
                    LET l_flowuser = 'N'
                    LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
                    LET g_argv2 = aws_efapp_wsk(2)   #參數:key-1
                    IF NOT cl_null(g_argv1) AND NOT cl_null(g_argv2) THEN
                       CALL t800_q()
                       #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                       CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,                               locale, void,undo_void, confirm, undo_confirm, easyflow_approval,   #FUN-D20025 add undo_void                               change_release, memo,balance_multi_account,deposit_multi_account")  #TQC-B40206 add balance_multi_account,deposit_multi_account
                            RETURNING g_laststage
                    ELSE
                       EXIT WHILE
                    END IF
                 ELSE
                    EXIT WHILE
                 END IF
              ELSE
                 EXIT WHILE
              END IF
           END IF

      #@WHEN "不准"
      WHEN "deny"
          IF (l_creator := aws_efapp_backflow()) IS NOT NULL THEN
             IF aws_efapp_formapproval() THEN
                IF l_creator = "Y" THEN
                   LET g_oep.oep09 = 'R'
                   DISPLAY BY NAME g_oep.oep09
                END IF
                IF cl_confirm('aws-081') THEN
                   IF aws_efapp_getnextforminfo() THEN
                      LET l_flowuser = 'N'
                      LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
                      LET g_argv2 = aws_efapp_wsk(2)   #參數:key-1
                      IF NOT cl_null(g_argv1) AND NOT cl_null(g_argv2) THEN
                         CALL t800_q()
                         #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                         CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,                            locale, void, undo_void,confirm, undo_confirm, easyflow_approval, change_release,  #FUN-D20025 add undo_void                            memo,balance_multi_account,deposit_multi_account") #TQC-B40206 add balance_multi_account,deposit_multi_account
                              RETURNING g_laststage
                      ELSE
                         EXIT WHILE
                      END IF
                   ELSE
                      EXIT WHILE
                   END IF
                ELSE
                   EXIT WHILE
                END IF
             END IF
          END IF

      #@WHEN "加簽"
      WHEN "modify_flow"
           IF aws_efapp_flowuser() THEN   #選擇欲加簽人員
              LET l_flowuser = 'Y'
           ELSE
              LET l_flowuser = 'N'
END IF

      #@WHEN "撤簽"
      WHEN "withdraw"
           IF cl_confirm("aws-080") THEN
              IF aws_efapp_formapproval() THEN
                 EXIT WHILE
              END IF
           END IF

      #@WHEN "抽單"
      WHEN "org_withdraw"
           IF cl_confirm("aws-079") THEN
              IF aws_efapp_formapproval() THEN
                 EXIT WHILE
              END IF
           END IF

     #@WHEN "簽核意見"
      WHEN "phrase"
           CALL aws_efapp_phrase()

        WHEN "related_document"           #相關文件
         IF cl_chk_act_auth() THEN
            IF g_oep.oep01 IS NOT NULL THEN
               LET g_doc.column1 = "oep01"
               LET g_doc.column2 = "oep02"
               LET g_doc.value1 = g_oep.oep01
               LET g_doc.value2 = g_oep.oep02
               CALL cl_doc()
            END IF
         END IF

      END CASE
   END WHILE
END FUNCTION

FUNCTION t800_a()
  DEFINE l_oea RECORD LIKE oea_file.*
  DEFINE g_t1  LIKE oay_file.oayslip                              #No:FUN-550070  #No.FUN-680137 VARCHAR(5)
    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
   CALL g_oeq.clear()
    INITIALIZE g_oep.* LIKE oep_file.*             #DEFAULT 設定
    INITIALIZE g_oep_t.* LIKE oep_file.*             #DEFAULT 設定
    INITIALIZE g_oep_o.* LIKE oep_file.*             #DEFAULT 設定
    LET g_oep.oep01  = ' '
    LET g_oep.oep04 = g_today
    #-----FUN-A20057---------
    LET g_oep.oep12 = g_user
    CALL t800_peo('d',g_oep.oep12)
    IF NOT cl_null(g_errno) THEN
       LET g_oep.oep12 = ''
    END IF
    #-----END FUN-A20057-----
    CALL cl_opmsg('a')
    WHILE TRUE
        LET g_oep.oep09 = '0'                      #開立
        LET g_oep.oepconf = 'N'                    #確認否
        LET g_oep.oepmksg = 'N'                    #確認否
        LET g_oep.oepacti = 'Y'
        LET g_oep.oepgrup=g_grup
        LET g_oep.oepdate=g_today
        LET g_oep.oepuser=g_user
        LET g_oep.oeporiu = g_user #FUN-980030
        LET g_oep.oeporig = g_grup #FUN-980030
        LET g_data_plant = g_plant #FUN-980030
        #顯示目前狀態
        #FUN-980010 add plant & legal
        LET g_oep.oepplant = g_plant
        LET g_oep.oeplegal = g_legal

        CALL t800_show()
        INITIALIZE g_oeq_t.* TO NULL  #900423
        CALL t800_i("a")                   #輸入單頭
        IF INT_FLAG THEN                   #使用者不玩了
            LET INT_FLAG = 0
            LET g_oep.oep01 = NULL   #MOD-660086 add
            EXIT WHILE
        END IF
        DISPLAY g_oep.oep01 TO oep01
        #依原訂單之簽核否, 簽核等級
        SELECT * INTO l_oea.* FROM oea_file
            WHERE oea01 = g_oep.oep01
        LET g_oep.oepmksg = l_oea.oeamksg
        DISPLAY g_oep.oepmksg TO oepmksg
        CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg)
                      RETURNING g_sta
        DISPLAY g_sta TO FORMONLY.desc

        INSERT INTO oep_file VALUES(g_oep.*)
        IF SQLCA.sqlcode THEN
            CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)
            CONTINUE WHILE
        END IF
        CALL cl_flow_notify(g_oep.oep01,'I') #CHI-A80030 add

        #顯示目前狀態
        CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg)
                      RETURNING g_sta
        DISPLAY g_sta TO FORMONLY.desc

        CALL g_oeq.clear()
        LET g_rec_b =0

        CALL t800_sign()
        CALL t800_b_fill(" 1=1")      #FUN-B50158  add

        CALL t800_b()                   #輸入單身

        EXIT WHILE
    END WHILE

END FUNCTION

FUNCTION t800_u()

   IF s_shut(0) THEN RETURN END IF

   IF g_oep.oep01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   #---->如為'已確認',不可取消
   IF g_oep.oepconf = 'Y' THEN
      CALL cl_err('','axm-291',0)
      RETURN
   END IF

   IF g_oep.oepacti ='N' THEN    #檢查資料是否為無效
      CALL cl_err(g_oep.oep01,9027,0)
      RETURN
   END IF

   IF g_oep.oepconf = 'X' THEN
      CALL cl_err(g_oep.oep01,'9024',0)
      RETURN
   END IF

   IF g_oep.oep09 MATCHES '[Ss]' THEN         #FUN-550031
      CALL cl_err('','apm-030',0)
      RETURN
   END IF

   CALL cl_opmsg('u')
   LET g_oep01_t = g_oep.oep01
   LET g_oep02_t = g_oep.oep02   #No.TQC-9A0114
   LET g_oep_o.* = g_oep.*

   BEGIN WORK

   LET g_success ='Y'

   OPEN t800_cl USING g_oep.oep01,g_oep.oep02   #No.TQC-9A0114
   IF STATUS THEN
      CALL cl_err("OPEN t800_cl:", STATUS, 1)
      CLOSE t800_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t800_cl INTO g_oep.*            # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      # 資料被他人LOCK
      CLOSE t800_cl
      ROLLBACK WORK
      RETURN
   END IF

   CALL t800_show()

   WHILE TRUE
      LET g_oep01_t = g_oep.oep01
      LET g_oep02_t = g_oep.oep02   #No.TQC-9A0114
      LET g_oep.oepmodu=g_user
      LET g_oep.oepdate=g_today

      CALL t800_i("u")                      #欄位更改

      IF INT_FLAG THEN
         LET g_success ='N'
         LET INT_FLAG = 0
         LET g_oep.*=g_oep_o.*
         LET g_oep.oep01 = g_oep_o.oep01
         DISPLAY BY NAME g_oep.oep01
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF

      IF g_oep.oep01 != g_oep01_t THEN            # 更改單號
         UPDATE oeq_file SET oeq01 = g_oep.oep01
             WHERE oeq01 = g_oep01_t
         IF SQLCA.sqlcode THEN
             CALL cl_err('oeq',SQLCA.sqlcode,0) CONTINUE WHILE
         END IF
      END IF
      LET g_oep.oep09 = '0'        #FUN-550031

      UPDATE oep_file SET oep_file.* = g_oep.*
          WHERE oep01 = g_oep01_t
            AND oep02 = g_oep02_t
      IF SQLCA.sqlcode THEN
          CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)
          CONTINUE WHILE
      END IF
      DISPLAY BY NAME g_oep.oep09

      IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
      IF g_oep.oep09  ='1' OR
         g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
      CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

      EXIT WHILE
   END WHILE
   COMMIT WORK
   CALL cl_flow_notify(g_oep.oep01,'U') #CHI-A80030 add

END FUNCTION


FUNCTION t800_i(p_cmd)
DEFINE
    p_cmd           LIKE type_file.chr1,                 #a:輸入 u:更改  #No.FUN-680137 VARCHAR(1)
    l_cmd           LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(70)
    l_oep02         LIKE type_file.num5,    #No.FUN-680137 SMALLINT              #變更序號
    l_n             LIKE type_file.num5,    #No.FUN-680137 SMALLINT
    l_oep01    LIKE oep_file.oep01,
    l_oepconf  LIKE oep_file.oepconf,        #確認否
    l_str           LIKE ima_file.ima01  #No.FUN-680137 VARCHAR(40)
DEFINE l_oea03   LIKE oea_file.oea03,
       l_oea032  LIKE oea_file.oea032,
       l_oea23   LIKE oea_file.oea23,
       l_oea32   LIKE oea_file.oea32,
       l_oea213  LIKE oea_file.oea213,         #MOD-C30462 add
       l_oag02   LIKE oag_file.oag02
  DEFINE l_dbs_new      LIKE type_file.chr21   #No.FUN-680137  VARCHAR(21)    #New DataBase Name
  DEFINE l_azp03        LIKE azp_file.azp03
  DEFINE l_last         LIKE type_file.num5    #No.FUN-680137 SMALLINT     #流程之最後家數
  DEFINE l_last_plant   LIKE cre_file.cre08    #No.FUN-680137 VARCHAR(10)
  DEFINE l_oea904       LIKE oea_file.oea904   #No.FUN-680137 VARCHAR(8)
  DEFINE l_poz011       LIKE poz_file.poz011
  DEFINE l_sql          LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(1000)
  DEFINE l_cnt          LIKE type_file.num10   #No.FUN-680137 INTEGER #FUN-560263
  DEFINE l_oea01        LIKE oea_file.oea01    #FUN-570259 add
  DEFINE l_oea99        LIKE oea_file.oea99    #FUN-570259 add
  DEFINE l_dbs_tra      LIKE azw_file.azw05        #FUN-980093 add
  DEFINE l_plant_new    LIKE azp_file.azp01        #FUN-980093 add
  DEFINE l_oma54        LIKE oma_file.oma54    #No:FUN-A50103
  DEFINE l_count        LIKE type_file.num5    #FUN-A80118 Add
  DEFINE l_azf03        LIKE azf_file.azf03    #FUN-A80118 Add
  DEFINE l_gec04        LIKE gec_file.gec04    #FUN-A80118 Add
  DEFINE l_gec07        LIKE gec_file.gec07    #FUN-A80118 Add
  DEFINE l_gec04b       LIKE gec_file.gec04    #FUN-A80118 Add
  DEFINE l_gec07b       LIKE gec_file.gec07    #FUN-A80118 Add
  DEFINE l_oea00        LIKE oea_file.oea00    #FUN-B50158
  DEFINE l_oea02        LIKE oea_file.oea02    #FUN-B50158
  DEFINE l_oeb1004      LIKE oeb_file.oeb1004  #FUN-B50158
  DEFINE l_term         LIKE oep_file.oep10    #FUN-B50158
  DEFINE l_oah02        LIKE oah_file.oah02,   #FUN-B30081 Add
         l_oag02a       LIKE oag_file.oag02,   #FUN-B30081 Add
         l_azi02        LIKE azi_file.azi02,   #FUN-B30081 Add
         l_ocd03        LIKE ocd_file.ocd03,   #FUN-B30081 Add
         l_ged02        LIKE ged_file.ged02,   #FUN-B30081 Add
         l_oah02b       LIKE oah_file.oah02,   #FUN-B30081 Add
         l_oag02b       LIKE oag_file.oag02,   #FUN-B30081 Add
         l_azi02b       LIKE azi_file.azi02,   #FUN-B30081 Add
         l_ocd03b       LIKE ocd_file.ocd03,   #FUN-B30081 Add
         l_ged02b       LIKE ged_file.ged02    #FUN-B30081 Add
  DEFINE l_gec07_flag   LIKE type_file.chr1    #MOD-C90099 add
  DEFINE li_result      LIKE type_file.num5    #CHI-D10010 add
  DEFINE l_oep01a       LIKE oep_file.oep01    #CHI-D10010 add
  DEFINE l_oea00a       LIKE oea_file.oea00    #CHI-D10010 add
  DEFINE l_gen02        LIKE gen_file.gen02

    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    DISPLAY BY NAME g_oep.oepconf,g_oep.oepuser,g_oep.oepgrup,g_oep.oepmodu,
                    g_oep.oepdate

   #Mod No:TQC-B20162
   #INPUT g_oep.oep01,g_oep.oep04,g_oep.oep12,g_oep.oep06,g_oep.oep06b,g_oep.oep07,   #FUN-A20057 add g_oep.oep12
   #      g_oep.oep07b,g_oep.oep08,g_oep.oep08b,
   #      g_oep.oep10,g_oep.oep10b,g_oep.oep11,g_oep.oep11b,  #FUN-560263
   #      g_oep.oep161b,g_oep.oep261b,g_oep.oep162b,g_oep.oep262b,g_oep.oep163b,g_oep.oep263b,    #No:FUN-A50103
   #      g_oep.oepud01,g_oep.oepud02,g_oep.oepud03,g_oep.oepud04,
   #      g_oep.oepud05,g_oep.oepud06,g_oep.oepud07,g_oep.oepud08,
   #      g_oep.oepud09,g_oep.oepud10,g_oep.oepud11,g_oep.oepud12,
   #      g_oep.oepud13,g_oep.oepud14,g_oep.oepud15
   #      #FUN-A80118--Add--Begin
   #     ,g_oep.oep13,g_oep.oep14,g_oep.oep15,g_oep.oep14b,g_oep.oep15b
   #      #FUN-A80118--Add--End
   #       WITHOUT DEFAULTS FROM oep01,oep04,oep12,oep06,oep06b,   #FUN-A20057 add oep12
   #                             oep07,oep07b,oep08,oep08b,
   #                             oep10,oep10b,oep11,oep11b,  ##FUN-560263
   #                             oep161b,oep261b,oep162b,oep262b,oep163b,oep263b,    #No:FUN-A50103
   #                             oepud01,oepud02,oepud03,oepud04,oepud05,
   #                             oepud06,oepud07,oepud08,oepud09,oepud10,
   #                             oepud11,oepud12,oepud13,oepud14,oepud15
   #                             #FUN-A80118--Add--Begin
   #                            ,oep13,oep14,oep15,oep14b,oep15b
   #                             #FUN-A80118--Add--End

   #FUN-C20109 mark begin---
   #INPUT BY NAME
   #      g_oep.oep01,g_oep.oep04,g_oep.oep12,g_oep.oep13,      #FUN-A20057 add g_oep.oep12
   #     #g_oep.oep06,g_oep.oep06b,g_oep.oep07,                 #FUN-B30081
   #     #g_oep.oep07b,g_oep.oep08,g_oep.oep08b,                #FUN-B30081
   #     #g_oep.oep14,g_oep.oep14b,                             #FUN-B30081
   #     #g_oep.oep10,g_oep.oep10b,g_oep.oep11,g_oep.oep11b,    #FUN-560263    #FUN-B30081
   #      g_oep.oep10,g_oep.oep10b,g_oep.oep07,g_oep.oep07b,    #FUN-B30081 Add
   #      g_oep.oep08,g_oep.oep08b,g_oep.oep14,g_oep.oep14b,    #FUN-B30081 Add
   #      g_oep.oep06,g_oep.oep06b,g_oep.oep11,g_oep.oep11b,    #FUN-B30081 Add
   #      g_oep.oep15,g_oep.oep15b,
   #      g_oep.oep16,g_oep.oep16b,                             #FUN-C40081
   #      g_oep.oep161b,g_oep.oep261b,g_oep.oep162b,g_oep.oep262b,g_oep.oep163b,g_oep.oep263b,    #No:FUN-A50103
   #      g_oep.oep25,g_oep.oep26,g_oep.oep25b,g_oep.oep26b,    #FUN-C40080
   #      g_oep.oepud01,g_oep.oepud02,g_oep.oepud03,g_oep.oepud04,
   #      g_oep.oepud05,g_oep.oepud06,g_oep.oepud07,g_oep.oepud08,
   #      g_oep.oepud09,g_oep.oepud10,g_oep.oepud11,g_oep.oepud12,
   #      g_oep.oepud13,g_oep.oepud14,g_oep.oepud15
   #
   #       WITHOUT DEFAULTS
   #FUN-C20109 mark end-----

   #FUN-C20109 add begin---
    INPUT BY NAME
          g_oep.oep01,g_oep.oep13,g_oep.oep04,g_oep.oep12,g_oep.oep16,g_oep.oep16b,
          g_oep.oepud01,g_oep.oepud07,g_oep.oepud13,g_oep.oepud08,g_oep.oepud14,
          g_oep.oepud02,g_oep.oepud09,g_oep.oepud15,g_oep.oepud03,g_oep.oepud10,
          g_oep.oepud04,g_oep.oepud11,g_oep.oepud05,g_oep.oepud12,g_oep.oepud06,
          g_oep.oep15,g_oep.oep08,g_oep.oep14,g_oep.oep10,g_oep.oep07,
          g_oep.oep15b,g_oep.oep08b,g_oep.oep14b,g_oep.oep10b,g_oep.oep07b,
          g_oep.oep06,g_oep.oep41,g_oep.oep11,g_oep.oep06b,g_oep.oep41b,
          g_oep.oep11b,g_oep.oep161b,g_oep.oep261b,g_oep.oep162b,g_oep.oep262b,g_oep.oep163b,g_oep.oep263b,
          g_oep.oep25,g_oep.oep26,g_oep.oep25b,g_oep.oep26b
          WITHOUT DEFAULTS
   #FUN-C20109 add end-----

{
    INPUT g_oep.oep01,g_oep.oep04,g_oep.oep12,g_oep.oep13,g_oep.oep06,g_oep.oep06b,g_oep.oep07,   #FUN-A20057 add g_oep.oep12
          g_oep.oep07b,g_oep.oep08,g_oep.oep08b,
          g_oep.oep14,g_oep.oep14b,
          g_oep.oep10,g_oep.oep10b,g_oep.oep11,g_oep.oep11b,                                      #FUN-560263
          g_oep.oep15,g_oep.oep15b,
          g_oep.oep161b,g_oep.oep261b,g_oep.oep162b,g_oep.oep262b,g_oep.oep163b,g_oep.oep263b,    #No:FUN-A50103
          g_oep.oepud01,g_oep.oepud02,g_oep.oepud03,g_oep.oepud04,
          g_oep.oepud05,g_oep.oepud06,g_oep.oepud07,g_oep.oepud08,
          g_oep.oepud09,g_oep.oepud10,g_oep.oepud11,g_oep.oepud12,
          g_oep.oepud13,g_oep.oepud14,g_oep.oepud15
           WITHOUT DEFAULTS FROM oep01,oep04,oep12,oep13,oep06,oep06b,               #FUN-A20057 add oep12
                                 oep07,oep07b,oep08,oep08b,
                                 oep14,oep14b,
                                 oep10,oep10b,oep11,oep11b,                          ##FUN-560263
                                 oep15,oep15b,
                                 oep161b,oep261b,oep162b,oep262b,oep163b,oep263b,    #No:FUN-A50103
                                 oepud01,oepud02,oepud03,oepud04,oepud05,
                                 oepud06,oepud07,oepud08,oepud09,oepud10,
                                 oepud11,oepud12,oepud13,oepud14,oepud15
}
   #Mod No:TQC-B20162

        BEFORE INPUT
            LET g_before_input_done = FALSE
            #MOD-D10096 mark start -----
            #CHI-C40019 add begin---
            #IF NOT cl_null(g_oep.oep01) THEN
            #   CALL t800_get_ogbcnt()
            #END IF
            #CHI-C40019 add end-----
            #MOD-D10096 mark end   -----
            CALL t800_set_entry(p_cmd)
            CALL t800_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE
            CALL cl_set_docno_format("oep01")      #No.FUN-550096
            LET g_oep.oep16b = ' '                 #FUN-C40081

        AFTER FIELD oep01                   #訂單單號
            IF NOT cl_null(g_oep.oep01) AND p_cmd = 'a' THEN

              #CHI-D10010---add---S
              #若單別設定檔有做使用者或部門設限，需照新增時的單別權限控卡
               LET g_t1a=s_get_doc_no(g_oep.oep01)
               SELECT oea00 INTO l_oea00a FROM oea_file WHERE oea01=g_oep.oep01
               CASE WHEN l_oea00a = '0' CALL s_check_no('axm',g_t1a,"","20","oea_file","oea01","") RETURNING li_result,l_oep01a  #合約單別
                    WHEN l_oea00a = '1' CALL s_check_no('axm',g_t1a,"","30","oea_file","oea01","") RETURNING li_result,l_oep01a  #訂單單別
                    WHEN l_oea00a = 'A' CALL s_check_no('axm',g_t1a,"","30","oea_file","oea01","") RETURNING li_result,l_oep01a  #訂單單別
                    WHEN l_oea00a = '2' CALL s_check_no('axm',g_t1a,"","32","oea_file","oea01","") RETURNING li_result,l_oep01a  #換貨訂單
                    WHEN l_oea00a MATCHES '[37]' CALL s_check_no('axm',g_t1a,"","33","oea_file","oea01","") RETURNING li_result,l_oep01a
                    WHEN l_oea00a = '4' CALL s_check_no('axm',g_t1a,"","34","oea_file","oea01","") RETURNING li_result,l_oep01a
                    WHEN l_oea00a = '6' CALL s_check_no('axm',g_t1a,"","30","oea_file","oea01","") RETURNING li_result,l_oep01a  #代送訂單單別
                    WHEN l_oea00a = '8' CALL s_check_no('axm',g_t1a,"","22","oea_file","oea01","") RETURNING li_result,l_oep01a
                    WHEN l_oea00a = '9' CALL s_check_no('axm',g_t1a,"","22","oea_file","oea01","") RETURNING li_result,l_oep01a
               END CASE
               IF (NOT li_result) THEN
                  NEXT FIELD oep01
               END IF
              #CHI-D10010---add---E

               #---->判斷此訂單,是否尚有未確認的變更單
               SELECT count(*) INTO g_cnt FROM oep_file
                WHERE oep01 = g_oep.oep01
                  AND oepconf IN ('N','n')     #MOD-750095 add
               IF g_cnt > 0 THEN    # 代表尚有未確認的訂單變更單
                  CALL cl_err('','axm-289',0)
                  NEXT FIELD oep01
               END IF

               #---->判斷此訂單,是否尚有己確認未發出的訂單變更單
               SELECT count(*) INTO g_cnt FROM oep_file
                WHERE oep01 = g_oep.oep01
                  AND oepconf IN ('Y','y') AND oep09 != '2'
               IF g_cnt > 0 THEN
                  CALL cl_err('','axm-404',0)
                  NEXT FIELD oep01
               END IF

               #FUN-D30090 -- add start --
               #---->判斷此訂單,是否存在出通單
               SELECT count(*) INTO g_cnt FROM oga_file
                WHERE oga16 = g_oep.oep01
                  AND oga09 = '1'
                  AND ogaconf <> 'X'
               IF g_cnt > 0 THEN
                  IF NOT cl_confirm('axm1184') THEN
                     NEXT FIELD oep01
                  END IF
               END IF
               #FUN-D30090 -- add end --

               #---->判斷此訂單,是否存在於訂單單頭
               LET g_oea901='N'
               LET g_oea905='N'
               LET g_oea906='N'
               LET g_oeaconf='N'
               SELECT count(*) INTO g_cnt FROM oea_file
                WHERE oea01 = g_oep.oep01 AND oeaconf IN ('Y','y')
                  AND oea49 = '1'
               IF g_cnt = 0 THEN        # 於訂單單頭檔無此訂單單號或無已確認未簽核
                  CALL cl_err('','axm-290',0)
                  NEXT FIELD oep01
               ELSE
                  SELECT oea044,oea32,oea23,oea901,oea905,oea906,oeaconf,oea31,oea43, #FUN-560263 add oea31,oea43
                         oea161,oea162,oea163,oea261,oea262,oea263    #No:FUN-A50103
                        ,oea21,oea10                                  #FUN-A80118 Add
                        ,oea08                                        #FUN-C40081
                        ,oea25,oea26                                  #FUN-C40080
                        ,oea41                                        #FUN-C20109
                        ,oea14
                    INTO g_oep.oep06,g_oep.oep07,g_oep.oep08,
                         g_oea901,g_oea905,g_oea906,g_oeaconf,g_oep.oep10,g_oep.oep11, #FUN-560263 add g_oep.oep10,g_oep.oep11
                         g_oep.oep161,g_oep.oep162,g_oep.oep163,      #No:FUN-A50103
                         g_oep.oep261,g_oep.oep262,g_oep.oep263       #No:FUN-A50103
                        ,g_oep.oep14,g_oep.oep15                      #FUN-A80118 Add
                        ,g_oep.oep16                                  #FUN-C40081
                        ,g_oep.oep25,g_oep.oep26                      #FUN-C40080
                        ,g_oep.oep41                                  #FUN-C20109
                        ,g_oep.oep12
                    FROM oea_file
                   WHERE oea01 = g_oep.oep01
                   #FUN-B30081 Add
                   LET l_oah02 = ' '
                   LET l_oag02a = ' '
                   LET l_azi02 = ' '
                   LET l_ocd03 = ' '
                   LET l_ged02 = ' '
                   IF NOT cl_null(g_oep.oep10) THEN
                      SELECT oah02 INTO l_oah02 FROM oah_file WHERE oah01 = g_oep.oep10
                   END IF
                   DISPLAY l_oah02 TO FORMONLY.oah02
                   IF NOT cl_null(g_oep.oep07) THEN
                      SELECT oag02 INTO l_oag02a FROM oag_file WHERE oag01 = g_oep.oep07
                   END IF
                   DISPLAY l_oag02a TO FORMONLY.oag02a
                   IF NOT cl_null(g_oep.oep08) THEN
                      SELECT azi02 INTO l_azi02 FROM azi_file WHERE azi01 = g_oep.oep08
                   END IF
                   DISPLAY l_azi02 TO FORMONLY.azi02
                   IF NOT cl_null(g_oep.oep06) THEN
                      SELECT ocd03 INTO l_ocd03 FROM ocd_file WHERE ocd01=g_oea.oea04 AND ocd02 = g_oep.oep06
                   END IF
                   DISPLAY l_ocd03 TO FORMONLY.ocd03
                   IF NOT cl_null(g_oep.oep11) THEN
                      SELECT ged02 INTO l_ged02 FROM ged_file WHERE ged01 = g_oep.oep11
                   END IF
                   DISPLAY l_ged02 TO FORMONLY.ged02
                   #FUN-B30081 Add

                   #FUN-C40080 add begin---
                   IF NOT cl_null(g_oep.oep25) THEN
                      SELECT oab02 INTO g_oab02_1 FROM oab_file WHERE oab01=g_oep.oep25
                   END IF

                   IF NOT cl_null(g_oep.oep26) THEN
                      SELECT oab02 INTO g_oab02_2 FROM oab_file WHERE oab01=g_oep.oep26
                   END IF

                   IF NOT cl_null(g_oep.oep25b) THEN
                      SELECT oab02 INTO g_oab02_1b FROM oab_file WHERE oab01=g_oep.oep25b
                   END IF

                   IF NOT cl_null(g_oep.oep26b) THEN
                      SELECT oab02 INTO g_oab02_2b FROM oab_file WHERE oab01=g_oep.oep26b
                   END IF

                   DISPLAY g_oab02_1 TO FORMONLY.oab02_1
                   DISPLAY g_oab02_2 TO FORMONLY.oab02_2
                   DISPLAY g_oab02_1b TO FORMONLY.oab02_1b
                   DISPLAY g_oab02_2b TO FORMONLY.oab02_2b
                   #FUN-C40080 add end-----

                   #FUN-C20109 add begin---
                   IF NOT cl_null(g_oep.oep41) THEN
                      SELECT oac02 INTO g_oac02 FROM oac_file WHERE oac01=g_oep.oep41
                   END IF

                   IF NOT cl_null(g_oep.oep41b) THEN
                      SELECT oac02 INTO g_oac02b FROM oac_file WHERE oac01=g_oep.oep41b
                   END IF

                   DISPLAY g_oac02 TO FORMONLY.oac02
                   DISPLAY g_oac02b TO FORMONLY.oac02b
                   #FUN-C20109 add end-----

                   #FUN-A80118 Add
                   LET l_gec04 = ' '    #FUN-B30081 Add
                   LET l_gec07 = ' '    #FUN-B30081 Add
                   IF NOT cl_null(g_oep.oep14) THEN
                   	 #LET l_gec04 = ' '     #FUN-B30081
                   	 #LET l_gec07 = ' '     #FUN-B30081
              	      SELECT gec04,gec07 INTO l_gec04,l_gec07
              	        FROM gec_file
                       WHERE gec01 = g_oep.oep14
                         AND gec011 = '2'
                   #  DISPLAY l_gec04 TO FORMONLY.gec04      #FUN-B30081
                   #  DISPLAY l_gec07 TO FORMONLY.gec07      #FUN-B30081
                   END IF
                   DISPLAY l_gec04 TO FORMONLY.gec04      #FUN-B30081
                   DISPLAY l_gec07 TO FORMONLY.gec07      #FUN-B30081
                   #FUN-A80118 Add
               END IF

               #99.03.16 三角貿易尚未確認或拋轉,不可訂單變更
               IF NOT cl_null(g_oea901) AND g_oea901='Y' THEN
                  #非來源訂單不可變更
                  IF g_oea906='N' THEN
                     CALL cl_err('','axm-409',0)  #No.8037
                     NEXT FIELD oep01
                  END IF
                  IF g_oeaconf='N' OR g_oea905='N' THEN
                     CALL cl_err('','axm-307',0)  #No.8037
                     NEXT FIELD oep01
                  END IF
                  LET l_oea904=''
                  LET l_azp03=''
                  LET l_dbs_new=''
                  LET l_last=''
                  LET l_last_plant=' '
                  LET l_poz011=''
                  LET g_cnt=0
                  SELECT oea904 INTO l_oea904 FROM oea_file WHERE oea01=g_oep.oep01
                  SELECT poz011 INTO l_poz011 FROM poz_file WHERE poz01=l_oea904
                  SELECT MAX(poy02) INTO l_last FROM poy_file WHERE poy01=l_oea904
                  SELECT poy04 INTO l_last_plant FROM poy_file
                   WHERE poy01 = l_oea904  AND poy02 = l_last
                  SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=l_last_plant
                  IF l_poz011='2' THEN
                     LET l_dbs_new = l_azp03 CLIPPED,"."
                    # FUN-980093 add----GP5.2 Modify #改抓Transaction DB
                     LET g_plant_new = l_last_plant
                     LET l_plant_new = g_plant_new
                     CALL s_getdbs()
                     LET l_dbs_new = g_dbs_new
                     CALL s_gettrandbs()
                     LET l_dbs_tra = g_dbs_tra
                  ELSE
                     LET l_dbs_new = ' '
                    # FUN-980093 add----GP5.2 Modify #改抓Transaction DB
                     LET g_plant_new = g_plant
                     LET l_plant_new = g_plant_new
                     CALL s_getdbs()
                     LET l_dbs_new = g_dbs_new
                     CALL s_gettrandbs()
                     LET l_dbs_tra = g_dbs_tra
                  END IF

                  IF l_poz011='1' THEN   #1.正拋          #MOD-940283 add
                     LET l_sql  = "SELECT COUNT(*) ",
                                  #"  FROM ",l_dbs_tra CLIPPED,"oga_file ", #FUN-980093 add
                                  "  FROM ",cl_get_target_table(l_plant_new,'oga_file'), #FUN-A50102
                                  " WHERE oga16='",g_oep.oep01,"' "
                     CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032 #FUN-950007 add
                     CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
                     PREPARE ogb_p1 FROM l_sql
                     DECLARE ogb_c1 CURSOR FOR ogb_p1
                     OPEN ogb_c1
                     FETCH ogb_c1 INTO g_cnt
                     CLOSE ogb_c1
                     IF g_cnt>0 THEN
                        CALL cl_err('','tri-021',1)
                     END IF
                  END IF                                  #MOD-940283 add

                 #逆拋時,檢查終站是否有"未確認出貨單",若有則warning
                  IF l_poz011='2' THEN   #2.逆拋
                     #先查出多角訂單的多角貿易流程序號
                     SELECT oea99 INTO l_oea99 FROM oea_file
                      WHERE oea01=g_oep.oep01
                     #先查出在終站那邊的多角訂單單號
                     LET l_sql = "SELECT oea01 ",
                                 #"  FROM ",l_dbs_tra CLIPPED,"oea_file ", #FUN-980093 add
                                 "  FROM ",cl_get_target_table(l_plant_new,'oea_file'), #FUN-A50102
                                 " WHERE oea99='",l_oea99,"'"
                       CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
                     CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
                     PREPARE ogb_p2_1 FROM l_sql
                     DECLARE ogb_c2_1 CURSOR FOR ogb_p2_1
                     OPEN ogb_c2_1
                     FETCH ogb_c2_1 INTO l_oea01
                     CLOSE ogb_c2_1
                     #用查出的多角訂單單號,尋找是否有未確認的出貨單
                     LET l_sql = "SELECT COUNT(*) ",
                                 #"  FROM ",l_dbs_tra CLIPPED,"oga_file,",                      #MOD-9B0094
                                 #"       ",l_dbs_tra CLIPPED,"ogb_file ",                      #MOD-9B0094
                                 "  FROM ",cl_get_target_table(l_plant_new,'oga_file'),",", #FUN-A50102                     #MOD-9B0094
                                 "       ",cl_get_target_table(l_plant_new,'ogb_file'),     #FUN-A50102
                                 " WHERE oga01 = ogb01 AND ogb31 = '",l_oea01,"'",              #MOD-9B0094
                                 "   AND ogaconf='N'"
                       CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
                     CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
                     PREPARE ogb_p2_2 FROM l_sql
                     DECLARE ogb_c2_2 CURSOR FOR ogb_p2_2
                     OPEN ogb_c2_2
                     FETCH ogb_c2_2 INTO g_cnt
                     CLOSE ogb_c2_2
                     IF g_cnt>0 THEN
                        CALL cl_err('','axm-430',1)   #此多角訂單終站有未確認出貨單,不可執行變更!
                        NEXT FIELD oep01
                     END IF
                  END IF
               END IF

               #---->變更序號
               SELECT max(oep02) INTO g_oep.oep02 FROM  oep_file
                WHERE oep01 = g_oep.oep01
               IF cl_null(g_oep.oep02) THEN
                  LET g_oep.oep02 = 1
               ELSE
                  LET g_oep.oep02 = g_oep.oep02 + 1
               END IF

               DISPLAY g_oep.oep02 TO oep02
               DISPLAY g_oep.oep04 TO oep04
               DISPLAY g_oep.oep06 TO oep06
               DISPLAY g_oep.oep07 TO oep07
               DISPLAY g_oep.oep07 TO oea32
               DISPLAY g_oep.oep08 TO oep08
               DISPLAY g_oep.oep10 TO oep10                              #FUN-560263
               DISPLAY g_oep.oep11 TO oep11                              #FUN-560263
               DISPLAY g_oep.oepconf TO oepconf
               DISPLAY g_oep.oepmksg TO oepmksg
               DISPLAY g_oep.oep14 TO oep14                              #FUN-A80118 Add
               DISPLAY g_oep.oep15 TO oep15                              #FUN-A80118 Add
               DISPLAY g_oep.oep16 TO oep16                              #FUN-C40081
               DISPLAY BY NAME g_oep.oep161,g_oep.oep162,g_oep.oep163    #No:FUN-A50103
               DISPLAY BY NAME g_oep.oep261,g_oep.oep262,g_oep.oep263    #No:FUN-A50103
               DISPLAY BY NAME g_oep.oep25,g_oep.oep26                   #FUN-C40080
               DISPLAY BY NAME g_oep.oep41                               #FUN-C20109
               DISPLAY g_oep.oep12 TO oep12

               SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01 = g_oep.oep12
               SELECT oea00,oea03,oea032,oea23,oea32,oag02   #No:FUN-740016
                 INTO g_oea00,l_oea03,l_oea032,l_oea23,l_oea32,l_oag02  #No:FUN-740016
                 FROM oea_file LEFT OUTER JOIN oag_file ON oea32 = oag01
                WHERE oea01 = g_oep.oep01
               DISPLAY l_oea03 TO FORMONLY.oea03
               DISPLAY l_oea032 TO FORMONLY.oea032
               DISPLAY l_oea23 TO FORMONLY.oea23
               DISPLAY l_oag02 TO FORMONLY.oag02
               DISPLAY l_gen02 TO FORMONLY.gen02
               CALL t800_set_entry(p_cmd)
               CALL t800_set_no_entry(p_cmd)
            END IF
           #MOD-D10096 mark start -----
           #CALL t800_get_ogbcnt()          #CHI-C40019 add
           #CALL t800_set_entry(p_cmd)      #CHI-C40019 add
           #CALL t800_set_no_entry(p_cmd)   #CHI-C40019 add
           #MOD-D10096 mark end   -----
        #-----FUN-A20057---------
        AFTER FIELD oep12  #變更人員
              IF NOT cl_null(g_oep.oep12) THEN
                 CALL t800_peo('a',g_oep.oep12)
                 IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_oep.oep12,g_errno,1)
                     LET g_oep.oep12 = g_oep_o.oep12
                     DISPLAY BY NAME g_oep.oep12
                     NEXT FIELD oep12
                 END IF
              END IF
        #-----END FUN-A20057-----

        BEFORE FIELD oep06b
            SELECT * INTO g_oea.* FROM oea_file WHERE oea01 = g_oep.oep01

        AFTER FIELD oep06b
           LET l_ocd03b= ' '   #FUN-B30081 Add
            IF NOT cl_null(g_oep.oep06b) THEN
               IF g_oep.oep06b = g_oep.oep06 THEN
                  CALL cl_err('','axm-311',0)
                  NEXT FIELD oep06b
               END IF
               SELECT * FROM ocd_file
                WHERE ocd01=g_oea.oea04 AND ocd02=g_oep.oep06b
               IF STATUS THEN
                  CALL cl_err('','mfg3345',0) NEXT FIELD oep06b
               END IF
               #FUN-B30081 Add
               SELECT ocd03 INTO l_ocd03b FROM ocd_file
                WHERE ocd01=g_oea.oea04 AND ocd02=g_oep.oep06b
               #FUN-B30081 Add
            END IF
            DISPLAY l_ocd03b TO FORMONLY.ocd03b    #FUN-B30081 Add

        AFTER FIELD oep07b
            LET l_oag02b=' '   #FUN-B30081 Add
            IF NOT cl_null(g_oep.oep07b) THEN
               IF g_oep.oep07b = g_oep.oep07 THEN
                  CALL cl_err('','axm-311',0)
                  NEXT FIELD oep07b
               END IF
              #SELECT oag02 FROM oag_file WHERE oag01=g_oep.oep07b #FUN-B30081
               #FUN-B30081 Add
               SELECT oag02 INTO l_oag02b FROM oag_file WHERE oag01=g_oep.oep07b
               #FUN-B30081 Add
               IF STATUS THEN
                  CALL cl_err('select oag',STATUS,0) NEXT FIELD oep07b
               END IF
            END IF
            DISPLAY l_oag02b TO FORMONLY.oag02b  #FUN-B30081 Add

        AFTER FIELD oep08b
         #No.FUN-B50158--MARK--
         #  IF NOT cl_null(g_oep.oep08b) THEN
         #     IF g_oep.oep08b = g_oep.oep08 THEN
         #        CALL cl_err('','axm-311',0)
         #        NEXT FIELD oep08b
         #     END IF
         #     SELECT azi02 FROM azi_file WHERE azi01=g_oep.oep08b
         #     IF STATUS THEN
         #        CALL cl_err('select azi',STATUS,0) NEXT FIELD oep08b
         #     END IF
         #  END IF
         #No.FUN-B50158--END--
         #No.FUN-B50158--ADD--
            IF NOT t800_chk_oep08b(p_cmd) THEN
               NEXT FIELD CURRENT
            END IF
         #No.FUN-B50158--END--

        AFTER FIELD oep10b
           LET l_oah02b=' '   #FUN-B30081
           IF NOT cl_null(g_oep.oep10b) THEN
             #SELECT oah02 INTO g_buf FROM oah_file   #FUN-B30081
             # WHERE oah01=g_oep.oep10b               #FUN-B30081
             #FUN-B30081 Add
              SELECT oah02 INTO l_oah02b FROM oah_file WHERE oah01=g_oep.oep10b
             #FUN-B30081 Add
              IF STATUS THEN
                 CALL cl_err('select oah',STATUS,0)
                 NEXT FIELD oep10b
              END IF
#             DISPLAY g_buf TO oep10b        #No.MOD-B30198  Mark
           END IF
           DISPLAY l_oah02b TO FORMONLY.oah02b    #FUN-B30081 Add

        AFTER FIELD oep11b
           LET l_ged02b= ' '   #FUN-B30081 Add
           IF NOT cl_null(g_oep.oep11b) THEN
              SELECT COUNT(*) INTO l_cnt FROM ged_file
               WHERE ged01=g_oep.oep11b
              IF l_cnt =0 THEN
                 CALL cl_err('','axm-309',0)
                 NEXT FIELD oep11b
              END IF
              SELECT ged02 INTO l_ged02b FROM ged_file WHERE ged01=g_oep.oep11b #FUN-B30081 Add
           END IF
           DISPLAY l_ged02b TO FORMONLY.ged02b     #FUN-B30081 Add

        #-----No:FUN-A50103-----
        AFTER FIELD oep261b
           IF NOT cl_null(g_oep.oep261b) THEN
#MOD-C30462 --------add------ begin
              IF NOT cl_null(g_oep.oep14b) THEN
                 #SELECT gec07 INTO l_oea213 FROM gec_file #MOD-C90099 mark
                 SELECT gec07 INTO l_gec07 FROM gec_file   #MOD-C90099 add
                  WHERE gec01 = g_oep.oep14b
                    AND gec011 = '2' #MOD-C90099 add
              ELSE
                 #SELECT gec07 INTO l_oea213 FROM gec_file #MOD-C90099 mark
                 SELECT gec07 INTO l_gec07b FROM gec_file   #MOD-C90099 add
                 SELECT gec07 INTO l_gec07 FROM gec_file
                  WHERE gec01 = g_oep.oep14
                    AND gec011 = '2' #MOD-C90099 add
              END IF
#MOD-C30462 --------add------ end
              #MOD-C90099 add start -----
              IF l_gec07 = l_gec07b OR cl_null(l_gec07b) THEN
                 LET l_gec07_flag = l_gec07
              ELSE
                 LET l_gec07_flag = l_gec07b
              END IF
              IF l_gec07_flag = 'Y' THEN
              #MOD-C90099 add end   -----
              #IF l_oea213 = 'Y' THEN                         #MOD-C30462 add #MOD-C90099 mark
                 SELECT SUM(oma54t) INTO l_oma54
                   FROM oma_file
                  WHERE oma16 = g_oep.oep01
                    AND oma00 = '11'
                    AND omavoid <> 'Y' #MOD-CB0025 add
              ELSE                                              #MOD-C30462 add
                 SELECT SUM(oma54) INTO l_oma54 FROM oma_file   #MOD-C30462 add
                  WHERE oma16 = g_oep.oep01                     #MOD-C30462 add
                    AND oma00 = '11'                            #MOD-C30462 add
                    AND omavoid <> 'Y' #MOD-CB0025 add
              END IF                                            #MOD-C30462 add
              IF g_oep.oep261b < l_oma54 THEN
                 CALL cl_err('','axm-964',1)
                 NEXT FIELD oep261b
              END IF
           END IF

        AFTER FIELD oep262b
           IF NOT cl_null(g_oep.oep262b) THEN
#MOD-C30462 --------add------ begin
              IF NOT cl_null(g_oep.oep14b) THEN
                 #SELECT gec07 INTO l_oea213 FROM gec_file #MOD-C90099 mark
                 SELECT gec07 INTO l_gec07 FROM gec_file   #MOD-C90099 add
                  WHERE gec01 = g_oep.oep14b
                    AND gec011 = '2' #MOD-C90099 add
              ELSE
                 #SELECT gec07 INTO l_oea213 FROM gec_file #MOD-C90099 amrk
                 SELECT gec07 INTO l_gec07b FROM gec_file   #MOD-C90099 add
                  WHERE gec01 = g_oep.oep14
                    AND gec011 = '2' #MOD-C90099 add
              END IF
#MOD-C30462 --------add------ end
              #MOD-C90099 add start -----
              IF l_gec07 = l_gec07b OR cl_null(l_gec07b) THEN
                 LET l_gec07_flag = l_gec07
              ELSE
                 LET l_gec07_flag = l_gec07b
              END IF
              IF l_gec07_flag = 'Y' THEN
              #MOD-C90099 add end   -----
              #IF l_oea213 = 'Y' THEN                         #MOD-C30462 add #MOD-C90099 mark
                 SELECT SUM(oma54t) INTO l_oma54
                   FROM oma_file
                  WHERE oma19 = g_oep.oep01
                    AND oma00 = '12'
              ELSE                                              #MOD-C30462 add
                 SELECT SUM(oma54) INTO l_oma54 FROM oma_file   #MOD-C30462 add
                  WHERE oma19 = g_oep.oep01                     #MOD-C30462 add
                    AND oma00 = '12'                            #MOD-C30462 add
              END IF                                            #MOD-C30462 add
              IF g_oep.oep262b < l_oma54 THEN
                 CALL cl_err('','axm-965',1)
                 NEXT FIELD oep262b
              END IF
           END IF

        AFTER FIELD oep263b
           IF NOT cl_null(g_oep.oep263b) THEN
#MOD-C30462 --------add------ begin
              IF NOT cl_null(g_oep.oep14b) THEN
                 #SELECT gec07 INTO l_oea213 FROM gec_file #MOD-C90099 mark
                 SELECT gec07 INTO l_gec07 FROM gec_file   #MOD-C90099 add
                  WHERE gec01 = g_oep.oep14b
                    AND gec011 = '2' #MOD-C90099 add
              ELSE
                 #SELECT gec07 INTO l_oea213 FROM gec_file  #MOD-C90099 mark
                 SELECT gec07 INTO  l_gec07b FROM gec_file  #MOD-C90099 add
                  WHERE gec01 = g_oep.oep14
                    AND gec011 = '2' #MOD-C90099 add
              END IF
#MOD-C30462 --------add------ end
              #MOD-C90099 add start -----
              IF l_gec07 = l_gec07b OR cl_null(l_gec07b) THEN
                 LET l_gec07_flag = l_gec07
              ELSE
                 LET l_gec07_flag = l_gec07b
              END IF
              IF l_gec07_flag = 'Y' THEN
              #MOD-C90099 add end   -----
              #IF l_oea213 = 'Y' THEN                         #MOD-C30462 add #MOD-C90099 mark
                 SELECT SUM(oma54t) INTO l_oma54
                   FROM oma_file
                  WHERE oma16 = g_oep.oep01
                    AND oma00 = '13'
              ELSE                                              #MOD-C30462 add
                 SELECT SUM(oma54) INTO l_oma54 FROM oma_file   #MOD-C30462 add
                  WHERE oma16 = g_oep.oep01                     #MOD-C30462 add
                    AND oma00 = '13'                            #MOD-C30462 add
              END IF                                            #MOD-C30462 add
              IF g_oep.oep263b < l_oma54 THEN
                 CALL cl_err('','axm-966',1)
                 NEXT FIELD oep263b
              END IF
           END IF
        #-----No:FUN-A50103 END-----
        #---FUN-B30063 ADD BEGIN---------------------
        AFTER FIELD oep15b
           IF g_oep.oep15b='NULL' OR g_oep.oep15b='null' THEN
              CALL cl_err('','axm1020',0)
           END IF
        #---FUN-B30063 ADD -END----------------------

        #FUN-C40081 add begin---
        AFTER FIELD oep16b
           IF NOT cl_null(g_oep.oep16b) THEN
              IF g_oep.oep16b = g_oep.oep16 THEN
                 CALL cl_err('','axm-311',0)
                 NEXT FIELD oep16b
              END IF
           END IF
           #yemy 20130513  --Begin
           IF g_oep.oep16b IS NULL THEN
              LET g_oep.oep16b = ' '
           END IF
           #yemy 20130513  --End
        #FUN-C40081 add end-----

        #FUN-C40080 add begin---
        AFTER FIELD oep25b
           IF NOT cl_null(g_oep.oep25b) THEN
              IF g_oep.oep25b = g_oep.oep25 THEN
                 CALL cl_err('','axm-311',0)
                 NEXT FIELD oep25b
              END IF

              SELECT oab02 INTO g_oab02_1b FROM oab_file WHERE oab01=g_oep.oep25b
              DISPLAY g_oab02_1b TO FORMONLY.oab02_1b
           END IF

        AFTER FIELD oep26b
           IF NOT cl_null(g_oep.oep26b) THEN
              IF g_oep.oep26b = g_oep.oep26 THEN
                 CALL cl_err('','axm-311',0)
                 NEXT FIELD oep26b
              END IF

              SELECT oab02 INTO g_oab02_2b FROM oab_file WHERE oab01=g_oep.oep26b
              DISPLAY g_oab02_2b TO FORMONLY.oab02_2b
           END IF
        #FUN-C40080 add end-----

        #FUN-C20109 add begin---
        AFTER FIELD oep41b
           IF NOT cl_null(g_oep.oep41b) THEN
              IF g_oep.oep41b = g_oep.oep41 THEN
                 CALL cl_err('','axm-311',0)
                 NEXT FIELD oep41b
              END IF

              SELECT oac02 INTO g_oac02b FROM oac_file WHERE oac01=g_oep.oep41b
              DISPLAY g_oac02b TO FORMONLY.oac02b
           END IF
        #FUN-C20109 add end-----

        AFTER FIELD oepud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD oepud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF

        #FUN-A80118--Add--Begin
        AFTER FIELD oep13
           IF NOT cl_null(g_oep.oep13) THEN
              LET l_count = 0
              SELECT COUNT(*) INTO l_count
                FROM azf_file
               WHERE azf01 = g_oep.oep13
                 AND azf02 = '2'
              IF l_count = 0 THEN
                 CALL cl_err('','aic-040',1)
                 NEXT FIELD oep13
              ELSE
              	 LET l_azf03 = ' '
              	 SELECT azf03 INTO l_azf03
              	   FROM azf_file
                  WHERE azf01 = g_oep.oep13
                    AND azf02 = '2'
                 DISPLAY l_azf03 TO FORMONLY.azf03
              END IF
           END IF

        AFTER FIELD oep14
           IF NOT cl_null(g_oep.oep14) THEN
              LET l_count = 0
              SELECT COUNT(*) INTO l_count
                FROM gec_file
               WHERE gec01 = g_oep.oep14
                 AND gec011 = '2'
              IF l_count = 0 THEN
                 CALL cl_err('','alm-921',1)
                 NEXT FIELD oep14
              ELSE
              	 LET l_gec04 = ' '
              	 LET l_gec07 = ' '
              	 SELECT gec04,gec07 INTO l_gec04,l_gec07
              	   FROM gec_file
                  WHERE gec01 = g_oep.oep14
                    AND gec011 = '2'
                 DISPLAY l_gec04 TO FORMONLY.gec04
                 DISPLAY l_gec07 TO FORMONLY.gec07
              END IF
           END IF

        #TQC-C20211 -----add start -----
        BEFORE FIELD oep14b
            CALL t800_set_entry(p_cmd)
            CALL t800_set_no_entry(p_cmd)
        #TQC-C20211 -----add end -----

        AFTER FIELD oep14b
       #No.FUN-B50158--MARK--
       #TQC-C20211 ----- mark start -----
       ##MOD-C10153 -----modify start -----
       #  IF NOT cl_null(g_oep.oep14b) THEN
       #   LET g_cnt = 0
       #   SELECT COUNT(*) INTO g_cnt FROM oga_file
       #    WHERE oga16 = g_oep.oep01 AND ogaconf = 'Y'
       #   IF g_cnt > 0 THEN
       #      CALL cl_err('','axm1126',0)
       #      NEXT FIELD oep14b
       #   END IF
       ##MOD-C10153 -----modify end -----
       #TQC-C20211 ----- mark end -----
       #      LET l_count = 0
       #      SELECT COUNT(*) INTO l_count
       #        FROM gec_file
       #       WHERE gec01 = g_oep.oep14b
       #         AND gec011 = '2'
       #      IF l_count = 0 THEN
       #         CALL cl_err('','alm-921',1)
       #         NEXT FIELD oep14b
       #      ELSE
       #      	 LET l_gec04b = ' '
       #      	 LET l_gec07b = ' '
       #      	 SELECT gec04,gec07 INTO l_gec04b,l_gec07b
       #      	   FROM gec_file
       #          WHERE gec01 = g_oep.oep14b
       #            AND gec011 = '2'
       #         DISPLAY l_gec04b TO FORMONLY.gec04b
       #         DISPLAY l_gec07b TO FORMONLY.gec07b
       #      END IF
       #   END IF                            #MOD-C10153 remove #  #TQC-C20211 mark
       ##FUN-A80118--Add--End
       #No.FUN-B50158--MARK--END--

       #No.FUN-B50158--add--
          IF NOT t800_chk_oep14b(p_cmd) THEN
             NEXT FIELD CURRENT
          ELSE
             IF g_chg_oep14b THEN
                CALL t800_b_fill(' 1=1')
             END IF
          END IF
       #No.FUN-B50158--add--end--

        AFTER INPUT
           LET g_oep.oepuser = s_get_data_owner("oep_file") #FUN-C10039
           LET g_oep.oepgrup = s_get_data_group("oep_file") #FUN-C10039
            IF INT_FLAG THEN
               EXIT INPUT
            END IF
            #CHI-A60026 add --start--
            IF (NOT cl_null(g_oep.oep10b) AND (g_oep.oep10b != g_oep_t.oep10b OR cl_null(g_oep_t.oep10b)))
               OR (NOT cl_null(g_oep.oep08b) AND (g_oep.oep08b != g_oep_t.oep08b OR cl_null(g_oep_t.oep08b)))
               OR (NOT cl_null(g_oep.oep14b) AND (g_oep.oep14b != g_oep_t.oep14b OR cl_null(g_oep_t.oep14b)))  #FUN-B50158 add
               OR (cl_null(g_oep.oep10b) AND NOT cl_null(g_oep_t.oep10b))   #FUN-B50158 add
               OR (cl_null(g_oep.oep08b) AND NOT cl_null(g_oep_t.oep08b))   #FUN-B50158 add
               OR (cl_null(g_oep.oep14b) AND NOT cl_null(g_oep_t.oep14b))   #FUN-B50158 add
               OR (cl_null(g_oep.oep07b) AND NOT cl_null(g_oep_t.oep07b))   #FUN-B50158 add
               OR (NOT cl_null(g_oep.oep07b) AND (g_oep.oep07b != g_oep_t.oep07b OR cl_null(g_oep_t.oep07b))) THEN
               #FUN-B50158--add--str--
               IF p_cmd = 'a' THEN
                  IF NOT cl_confirm('art-221') THEN
                     RETURN
                  ELSE
                     LET g_sql=" SELECT oeb03, oeb04, oeb05, oeb12, oeb13, oeb14, oeb14t,",
                               "        oeb15, oeb06, oeb913,oeb914,oeb915,oeb910,",
                               "        oeb911,oeb912,oeb916,oeb917,oeb920,oeb30,oeb31, ",
                               "        oeb1001,oeb1012,oeb1006,oeb41,oeb42,oeb43,oeb37",
                               " FROM oeb_file WHERE oeb01 = '",g_oep.oep01,"'",
                               "  AND oeb03 < '9000'"
                     PREPARE oeq_pre FROM g_sql
                     DECLARE oeq_cur CURSOR FOR oeq_pre
                     LET l_ac = 1
                     FOREACH oeq_cur INTO g_oeq[l_ac].oeq03,  g_oeq[l_ac].oeq04b, g_oeq[l_ac].oeq05b,
                                          g_oeq[l_ac].oeq12b, g_oeq[l_ac].oeq13b,
                                          g_oeq[l_ac].oeq14b, g_oeq[l_ac].oeq14tb,
                                          g_oeq[l_ac].oeq15b, g_oeq[l_ac].oeq041b,
                                          g_oeq[l_ac].oeq23b, g_oeq[l_ac].oeq24b,
                                          g_oeq[l_ac].oeq25b, g_oeq[l_ac].oeq20b,
                                          g_oeq[l_ac].oeq21b, g_oeq[l_ac].oeq22b,
                                          g_oeq[l_ac].oeq26b, g_oeq[l_ac].oeq27b, g_oeb920,
                                          g_oeq[l_ac].oeq28b, g_oeq[l_ac].oeq29b,
                                          g_oeq[l_ac].oeq30b,
                                          g_oeb1012,          g_oeb1006
                                         ,g_oeq[l_ac].oeq31b, g_oeq[l_ac].oeq32b,g_oeq[l_ac].oeq33b
                                         ,g_oeq[l_ac].oeq37b
                        IF SQLCA.sqlcode THEN
                           CALL cl_err('foreach oeq_cur',SQLCA.SQLCODE,1)
                        END IF
                        IF cl_null(g_oeb1006) THEN
                           LET g_oeb1006 = 100
                        END IF
                        IF cl_null(g_oeb1012) THEN
                           LET g_oeb1012 = 'N'
                        END IF
                        SELECT ima021,ima31,ima906,ima907,ima908
                          INTO g_oeq[l_ac].ima021b,g_ima31,g_ima906,g_ima907,g_ima908
                          FROM ima_file
                         WHERE ima01=g_oeq[l_ac].oeq04b
                        IF SQLCA.sqlcode THEN
                           IF g_oeq[l_ac].oeq04b MATCHES 'MISC*' THEN
                              SELECT ima021,ima31,ima906,ima907,ima908
                                INTO g_oeq[l_ac].ima021b,g_ima31,g_ima906,g_ima907,g_ima908
                                FROM ima_file
                               WHERE ima01='MISC'
                           END IF
                        END IF
                        IF (NOT cl_null(g_oep.oep08b) AND (g_oep.oep08b != g_oep_t.oep08b OR cl_null(g_oep_t.oep08b)))
                           OR (cl_null(g_oep.oep08b) AND NOT cl_null(g_oep_t.oep08b)) THEN
                           IF cl_confirm('apm-543') THEN  #是否重新取價
                              SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
                                  WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
                              SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
                                  WHERE oea01=g_oep.oep01
                              LET l_term=g_oep.oep10b
                              LET g_oep07 = g_oep.oep07b
                              LET g_oep08 = g_oep.oep08b
                              IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF
                              IF cl_null(g_oep.oep07b) THEN LET g_oep07 = g_oep.oep07 END IF
                              IF cl_null(g_oep.oep08b) THEN LET g_oep08 = g_oep.oep08 END IF
                              IF cl_null(g_oeq[l_ac].oeq04a) THEN LET g_oeq[l_ac].oeq04a = g_oeq[l_ac].oeq04b END IF
                              IF cl_null(g_oeq[l_ac].oeq05a) THEN LET g_oeq[l_ac].oeq05a = g_oeq[l_ac].oeq05b END IF
                           #  IF cl_null(g_oeq[l_ac].oeq12a) THEN LET g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b END IF   #FUN-910088--mark--
                           #FUN-910088--add-start--
                              IF cl_null(g_oeq[l_ac].oeq12a) THEN
                                 LET g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b
                                 LET g_oeq[l_ac].oeq12a = s_digqty(g_oeq[l_ac].oeq12a,g_oeq[l_ac].oeq05a)
                              END IF
                           #FUN-910088--add-end--
                              CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,'',g_oeq[l_ac].oeq05a,l_oea02,    #FUN-BC0071
                                                      '1',g_plant,g_oep08,l_term,
                                                       g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
                                                       g_oeq[l_ac].oeq12a,l_oeb1004,'b')
                                    RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a
                              #FUN-BC0088 ------- add start --------------
                              IF g_oeq[l_ac].oeq04a[1,4] = 'MISC' THEN
                                 CALL s_unitprice_entry(l_oea03,l_term,g_plant,'M')
                              ELSE
                              #FUN-BC0088 ------- add end --------------
                                 IF g_oeq[l_ac].oeq13a=0 THEN
                                    CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
                                 ELSE
                                    CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
                                 END IF
                              END IF #FUN-BC0088 add
                           ELSE
                              LET g_oeq[l_ac].oeq13a=g_oeq[l_ac].oeq13b
                              LET g_oeq[l_ac].oeq37a=g_oeq[l_ac].oeq37b
                           END IF
                        ELSE
                           LET g_oeq[l_ac].oeq13a=g_oeq[l_ac].oeq13b
                           LET g_oeq[l_ac].oeq37a=g_oeq[l_ac].oeq37b
                        END IF
                        CALL t800_oeq14a()
                        IF g_oeq[l_ac].oeq04a=g_oeq[l_ac].oeq04b THEN
                           LET g_oeq[l_ac].oeq04a=NULL
                        END IF
                        IF g_oeq[l_ac].oeq05a=g_oeq[l_ac].oeq05b THEN
                           LET g_oeq[l_ac].oeq05a=NULL
                        END IF
                        IF g_oeq[l_ac].oeq12a=g_oeq[l_ac].oeq12b THEN
                           LET g_oeq[l_ac].oeq12a=NULL
                        END IF
                        CALL t800_b_move_back()
                        INSERT INTO oeq_file VALUES(b_oeq.*)
                        LET l_ac=l_ac+1
                     END FOREACH
                     CALL g_oeq.deleteElement(l_ac)
                     LET l_ac=l_ac-1
                  END IF
               END IF
              #FUN-B50158--add--end--
               IF p_cmd = 'u' THEN   #FUN-B50158 add
                  SELECT COUNT(*) INTO g_cnt FROM oeq_file
                   WHERE oeq01 = g_oep.oep01
                     AND oeq02 = g_oep.oep02
                  IF g_cnt > 0 THEN
                     IF cl_confirm('apm-543') THEN  #是否重新取價
                        FOR l_ac = 1 TO g_cnt
                        #No.FUN-B50158  ---begin---
                         # CALL t800_get_price() RETURNING g_oeq[l_ac].oeq13a
                           SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
                               WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
                           SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
                               WHERE oea01=g_oep.oep01
                           LET l_term=g_oep.oep10b
                           LET g_oep07 = g_oep.oep07b
                           LET g_oep08 = g_oep.oep08b
                           IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF
                           IF cl_null(g_oep.oep07b) THEN LET g_oep07 = g_oep.oep07 END IF
                           IF cl_null(g_oep.oep08b) THEN LET g_oep08 = g_oep.oep08 END IF
                           IF cl_null(g_oeq[l_ac].oeq04a) THEN LET g_oeq[l_ac].oeq04a = g_oeq[l_ac].oeq04b END IF
                           IF cl_null(g_oeq[l_ac].oeq05a) THEN LET g_oeq[l_ac].oeq05a = g_oeq[l_ac].oeq05b END IF
                        #  IF cl_null(g_oeq[l_ac].oeq12a) THEN LET g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b END IF  #FUN-910088--mark--
                        #FUN-910088-add--start--
                           IF cl_null(g_oeq[l_ac].oeq12a) THEN
                              LET g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b
                              LET g_oeq[l_ac].oeq12a = s_digqty(g_oeq[l_ac].oeq12a,g_oeq[l_ac].oeq05a)
                           END IF
                        #FUN-910088--add--end--
                           CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,'',g_oeq[l_ac].oeq05a,l_oea02,      #FUN-BC0071
                                                   '1',g_plant,g_oep08,l_term,
                                                    g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
                                                    g_oeq[l_ac].oeq12a,l_oeb1004,'b')
                                 RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a
                          #FUN-B70087 mod
                          #IF g_oeq[l_ac].oeq13a=0 THEN CALL s_unitprice_entry(l_oea03,l_term,g_plant) END IF
                           #FUN-BC0088 ------- add start --------------
                           IF g_oeq[l_ac].oeq04a[1,4] = 'MISC' THEN
                              CALL s_unitprice_entry(l_oea03,l_term,g_plant,'M')
                           ELSE
                           #FUN-BC0088 ------- add end --------------
                              IF g_oeq[l_ac].oeq13a=0 THEN
                                 CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
                              ELSE
                                 CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
                              END IF
                           END IF #FUN-BC0088 add
                          #FUN-B70087 mod--end
                         #No.FUN-B50158  ---end---
                           CALL t800_oeq14a()
                           LET g_oeq[l_ac].oeq37a=g_oeq[l_ac].oeq13a         #FUN-AB0082
                           UPDATE oeq_file SET oeq13a=g_oeq[l_ac].oeq13a,
                                               oeq14a=g_oeq[l_ac].oeq14a,
                                               #oeq14ta=t_oeq14ta   #MOD-A70005
                                               oeq14ta=g_oeq[l_ac].oeq14ta   #MOD-A70005
                            WHERE oeq01 = g_oep.oep01
                              AND oeq02 = g_oep.oep02
                              AND oeq03 = g_oeq[l_ac].oeq03
                           IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                              CALL cl_err3("upd","oeq_file",g_oep.oep01,g_oep.oep02,STATUS,"","upd oeq:",1)
                              EXIT FOR
                           END IF

                        END FOR
                        CALL t800_b_fill(' 1=1')
                     END IF
                  END IF
               END IF  #FUN-B50158 add
            END IF
            #CHI-A60026 add --end--

        ON ACTION controlp
           CASE      #查詢符合條件的單號
              WHEN INFIELD(oep01)
                   CALL q_oea( FALSE, TRUE,g_oep.oep01,'','4') RETURNING g_oep.oep01 #MOD-B40099 mod 3->4
                   DISPLAY BY NAME g_oep.oep01
                   NEXT FIELD oep01
               #-----FUN-A20057---------
               WHEN INFIELD(oep12)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_gen"
                    LET g_qryparam.default1 = g_oep.oep12
                    CALL cl_create_qry() RETURNING g_oep.oep12
                    DISPLAY BY NAME g_oep.oep12
                    CALL t800_peo('a',g_oep.oep12)
                    NEXT FIELD oep12
               #-----END FUN-A20057-----
              WHEN INFIELD(oep06b)   #送貨地址
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_ocd"
                   LET g_qryparam.default1 = g_oep.oep06b
                   LET g_qryparam.arg1 = g_oea.oea04
                   CALL cl_create_qry() RETURNING g_oep.oep06b
                   DISPLAY BY NAME g_oep.oep06b
                   NEXT FIELD oep06b
              WHEN INFIELD(oep07b)   #價格條件
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_oag"
                   LET g_qryparam.default1 = g_oep.oep07b
                   CALL cl_create_qry() RETURNING g_oep.oep07b
                   DISPLAY BY NAME g_oep.oep07b
                   NEXT FIELD oep07b
              WHEN INFIELD(oep08b)    #幣別
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_azi"
                   LET g_qryparam.default1 = g_oep.oep08b
                   CALL cl_create_qry() RETURNING g_oep.oep08b
                   DISPLAY BY NAME g_oep.oep08b
                   NEXT FIELD oep08b
              WHEN INFIELD(oep10b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_oah"
                   CALL cl_create_qry() RETURNING g_oep.oep10b
                   DISPLAY BY NAME g_oep.oep10b
                   NEXT FIELD oep10b
              WHEN INFIELD(oep11b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_ged"
                   CALL cl_create_qry() RETURNING g_oep.oep11b
                   DISPLAY BY NAME g_oep.oep11b
                   NEXT FIELD oep11b
              #FUN-A80118--Add--Begin
              WHEN INFIELD(oep13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_azf01a"
                   LET g_qryparam.arg1 = '1'
                   CALL cl_create_qry() RETURNING g_oep.oep13
                   DISPLAY BY NAME g_oep.oep13
                   LET l_azf03 = ' '
                	 SELECT azf03 INTO l_azf03
              	     FROM azf_file
                    WHERE azf01 = g_oep.oep13
                      AND azf02 = '2'
                   DISPLAY l_azf03 TO FORMONLY.azf03
                   NEXT FIELD oep13

              WHEN INFIELD(oep14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gec"
                   LET g_qryparam.arg1 = '1'
                   CALL cl_create_qry() RETURNING g_oep.oep14
                   DISPLAY BY NAME g_oep.oep14
              	   LET l_gec04 = ' '
                	 LET l_gec07 = ' '
              	   SELECT gec04,gec07 INTO l_gec04,l_gec07
              	     FROM gec_file
                    WHERE gec01 = g_oep.oep14
                      AND gec011 = '2'
                   DISPLAY l_gec04 TO FORMONLY.gec04
                   DISPLAY l_gec07 TO FORMONLY.gec07
                   NEXT FIELD oep14

              WHEN INFIELD(oep14b)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gec"
                   LET g_qryparam.arg1 = '2'
                   CALL cl_create_qry() RETURNING g_oep.oep14b
                   DISPLAY BY NAME g_oep.oep14b
              	   LET l_gec04 = ' '
                	 LET l_gec07 = ' '
              	   SELECT gec04,gec07 INTO l_gec04,l_gec07
              	     FROM gec_file
                    WHERE gec01 = g_oep.oep14b
                      AND gec011 = '2'
                   DISPLAY l_gec04 TO FORMONLY.gec04b
                   DISPLAY l_gec07 TO FORMONLY.gec07b
                   NEXT FIELD oep14b
              #FUN-A80118--Add--End

              #FUN-C40080 add begin---
              WHEN INFIELD(oep25b)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_oab"
                 LET g_qryparam.default1 = g_oep.oep25b
                 CALL cl_create_qry() RETURNING g_oep.oep25b
                 DISPLAY BY NAME g_oep.oep25b
                 NEXT FIELD oep25b

                 IF NOT cl_null(g_oep.oep25b) THEN
                    IF g_oep.oep25b = g_oep.oep25 THEN
                       CALL cl_err('','axm-311',0)
                       NEXT FIELD oep25b
                    END IF

                    SELECT oab02 INTO g_oab02_1b FROM oab_file WHERE oab01=g_oep.oep25b
                    DISPLAY g_oab02_1b TO FORMONLY.oab02_1b
                 END IF

                 NEXT FIELD oep25b
              WHEN INFIELD(oep26b)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_oab"
                 LET g_qryparam.default1 = g_oep.oep26b
                 CALL cl_create_qry() RETURNING g_oep.oep26b
                 DISPLAY BY NAME g_oep.oep26b
                 NEXT FIELD oep26b

                 IF NOT cl_null(g_oep.oep26b) THEN
                    IF g_oep.oep26b = g_oep.oep26 THEN
                       CALL cl_err('','axm-311',0)
                       NEXT FIELD oep26b
                    END IF

                    SELECT oab02 INTO g_oab02_2b FROM oab_file WHERE oab01=g_oep.oep26b
                    DISPLAY g_oab02_2b TO FORMONLY.oab02_2b
                 END IF

                 NEXT FIELD oep26b
              #FUN-C40080 add end-----

              #FUN-C20109 add begin---
              WHEN INFIELD(oep41b)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_oac"
                 LET g_qryparam.default1 = g_oep.oep41b
                 CALL cl_create_qry() RETURNING g_oep.oep41b
                 DISPLAY BY NAME g_oep.oep41b

                 IF NOT cl_null(g_oep.oep41b) THEN
                    IF g_oep.oep41b = g_oep.oep41 THEN
                       CALL cl_err('','axm-311',0)
                       NEXT FIELD oep41b
                    END IF

                    SELECT oac02 INTO g_oac02b FROM oac_file WHERE oac01=g_oep.oep41b
                    DISPLAY g_oac02b TO FORMONLY.oac02b
                 END IF

                 NEXT FIELD oep41b
              #FUN-C20109 add end-----
              OTHERWISE EXIT CASE
           END CASE

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT

         ON ACTION controlg
            CALL cl_cmdask()

         ON ACTION about
            CALL cl_about()

         ON ACTION help
            CALL cl_show_help()

    END INPUT

END FUNCTION

#No.FUN-B50158--ADD--
FUNCTION t800_chk_oep08b(p_cmd)
   DEFINE p_cmd LIKE type_file.chr1
   DEFINE l_azi02b LIKE azi_file.azi02

   LET l_azi02b= ' '  #FUN-B30081 Add
   IF NOT cl_null(g_oep.oep08b) THEN
      IF g_oep.oep08b = g_oep.oep08 THEN
         CALL cl_err('','axm-311',0)
         RETURN FALSE
      END IF
     #SELECT azi02 FROM azi_file WHERE azi01=g_oep.oep08b #FUN-B30081
     #FUN-B30081 Add
      SELECT azi02 INTO l_azi02b FROM azi_file WHERE azi01=g_oep.oep08b
     #FUN-B30081 Add
      IF STATUS THEN
         CALL cl_err('select azi',STATUS,0)
         RETURN FALSE
      END IF
   END IF
   DISPLAY l_azi02b TO FORMONLY.azi02b   #FUN-B30081 Add

      SELECT COUNT(*) INTO g_cnt FROM oeb_file
           WHERE oeb01 = g_oep.oep01
      IF ((p_cmd='a' AND g_oep.oep08b <> g_oep.oep08 AND g_oep.oep08b IS NOT NULL) OR
          (p_cmd='u' AND g_oep.oep08b <> g_oep_o.oep08b AND g_cnt>0) OR
          (p_cmd='u' AND g_oep.oep08b IS NULL AND g_oep_o.oep08b IS NOT NULL) OR
          (p_cmd='u' AND g_oep.oep08b IS NOT NULL AND g_oep_o.oep08b IS NULL)) THEN
           #確定是你要變更的幣別嗎?
               IF NOT cl_confirm2('axm-918',g_oep.oep08b) THEN
                   LET g_oep.oep08b=g_oep_o.oep08b
                   DISPLAY BY NAME g_oep.oep08b
                   RETURN FALSE
               END IF
      END IF

   #  IF p_cmd='a' OR (p_cmd='u' AND g_oep.oep08b<> g_oep_o.oep08b) THEN
   #     IF g_oea.oea08='1' THEN
   #        LET exT=g_oaz.oaz52
   #     ELSE
   #        LET exT=g_oaz.oaz70
   #     END IF
   #     CALL s_curr3_flagon()
   #     LET g_errno=NULL
   #     CALL s_curr3(g_oea.oea23,g_oea.oea02,exT) RETURNING g_oea.oea24
   #     CALL s_curr3_flagoff()
   #     IF NOT cl_null(g_errno) THEN
   #        CALL cl_err('','axm-084',1)
   #        RETURN FALSE
   #     END IF
   #  END IF
   #END IF
   #IF cl_null(g_oea.oea24) THEN LET g_oea.oea24=0 END IF
   LET g_oep_o.oep08b=g_oep.oep08b
   RETURN TRUE
END FUNCTION

FUNCTION t800_chk_oep14b(p_cmd)
   DEFINE p_cmd        LIKE type_file.chr1
   DEFINE l_oeq        RECORD LIKE oeq_file.*
   DEFINE l_count      LIKE type_file.num5
   DEFINE l_gec04      LIKE gec_file.gec04
   DEFINE l_gec07      LIKE gec_file.gec07
   DEFINE l_gec04b     LIKE gec_file.gec04
   DEFINE l_gec07b     LIKE gec_file.gec07
   DEFINE l_gecacti    LIKE gec_file.gecacti
   DEFINE l_oeq13b     LIKE oeq_file.oeq13b

   LET g_chg_oep14b=FALSE
   IF NOT cl_null(g_oep.oep14) THEN
      LET l_gec04 = ' '
      LET l_gec07 = ' '
      SELECT gec04,gec07 INTO l_gec04,l_gec07
        FROM gec_file
       WHERE gec01 = g_oep.oep14
         AND gec011 = '2'
   END IF
   IF NOT cl_null(g_oep.oep14b) THEN
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM gec_file
       WHERE gec01 = g_oep.oep14b
         AND gec011 = '2'
      IF l_count = 0 THEN
         CALL cl_err('','alm-921',1)
         RETURN FALSE
      ELSE
         LET l_gec04b = ' '
         LET l_gec07b = ' '
         SELECT gec04,gec07,gecacti INTO l_gec04b,l_gec07b,l_gecacti
             FROM gec_file
            WHERE gec01 = g_oep.oep14b
             AND gec011 = '2'
      END IF
      IF l_gecacti <> 'Y' THEN
         CALL cl_err('','axm-985',1)
         RETURN FALSE
      END IF
      DISPLAY l_gec04b TO FORMONLY.gec04b
      DISPLAY l_gec07b TO FORMONLY.gec07b
      IF (p_cmd = 'a' AND ((l_gec04b != l_gec04 OR l_gec04 IS NULL) OR (l_gec07b != l_gec07 OR l_gec07 IS NULL))) OR
         (p_cmd = 'u' AND (g_oep.oep14b != g_oep_o.oep14b OR g_oep_o.oep14b IS NULL) AND g_cnt>0) THEN
         SELECT COUNT(*) INTO g_cnt FROM oeb_file
          WHERE oeq01 = g_oep.oep01
         IF g_cnt > 0 THEN
             #確定是你要變更的稅別嗎?
             IF cl_confirm2('axm-415',g_oep.oep14b) THEN
                 DECLARE oep14b_cs CURSOR FOR
                 SELECT oeq03,oeq12a,oeq13a FROM oeq_file
                     WHERE oeq01 = g_oep.oep01
                 SELECT oeq13b INTO l_oeq13b FROM oeq_file WHERE oeq01 = g_oep.oep01
                 FOREACH oep14b_cs INTO l_oeq.oeq03,l_oeq.oeq12a,l_oeq.oeq13a
                   IF cl_null(l_oeq.oeq13a) THEN
                      LET l_oeq.oeq13a = l_oeq13b
                   END IF
                   IF l_gec07b = 'N' THEN
                      LET l_oeq.oeq14a = l_oeq.oeq12a * l_oeq.oeq13a
                      LET l_oeq.oeq14a = cl_digcut(l_oeq.oeq14a,t_azi04)
                      LET l_oeq.oeq14ta= l_oeq.oeq14a * (1+l_gec04b/100)
                      LET l_oeq.oeq14ta= cl_digcut(l_oeq.oeq14ta,t_azi04)
                   ELSE
                      LET l_oeq.oeq14ta= l_oeq.oeq12a * l_oeq.oeq13a
                      LET l_oeq.oeq14ta= cl_digcut(l_oeq.oeq14ta,t_azi04)
                      LET l_oeq.oeq14a = l_oeq.oeq14ta/ (1+l_gec04b/100)
                      LET l_oeq.oeq14a = cl_digcut(l_oeq.oeq14a,t_azi04)
                   END IF
                   UPDATE oeq_file SET oeq14a = l_oeq.oeq14a,
                                       oeq14ta= l_oeq.oeq14ta
                    WHERE oeq01 = g_oep.oep01 AND oeq03 = l_oeq.oeq03
                   IF SQLCA.SQLCODE THEN
                      CALL cl_err3("upd","oeq_file",g_oep.oep01,l_oeq.oeq03,STATUS,"","upd oep14b:",1)
                      EXIT FOREACH
                   END IF
                 END FOREACH
                 LET g_chg_oep14b=TRUE
             ELSE
                 LET g_oep.oep14b = g_oep_o.oep14b
                 DISPLAY BY NAME g_oep.oep14b
                 RETURN FALSE
             END IF
         END IF
        END IF
   END IF
   LET g_oep_o.oep14b = g_oep.oep14b
   RETURN TRUE
END FUNCTION
#No.FUN-B50158--ADD--END--

FUNCTION t800_set_entry(p_cmd)
 DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("oep01",TRUE)
    END IF

    CALL cl_set_comp_entry("oep06b,oep07b,oep08b,oep10b,oep11b,oep16b,oep25b,oep26b,oep41b",TRUE)   #No:FUN-740016   #FUN-C40081 add oep16b   #FUN-C40080 add oep25b,oep26b   #FUN-C20109 add oep41b

    CALL cl_set_comp_entry("oep161b,oep162b,oep163b",TRUE)    #No:FUN-A50103
    CALL cl_set_comp_entry("oep261b,oep262b,oep263b",TRUE)    #No:FUN-A50103

    #TQC-C20211 ----- add start -----
    LET g_cnt = 0
    SELECT COUNT(*) INTO g_cnt FROM oga_file
     WHERE oga16 = g_oep.oep01 AND ogaconf = 'Y'
    IF g_cnt = 0 THEN
       CALL cl_set_comp_entry("oep14b",TRUE)
    END IF
    #TQC-C20211 ----- add end -----

    #MOD-D10096 add start -----
     LET g_ogb_cnt = 0
     SELECT COUNT(*) INTO g_ogb_cnt
       FROM ogb_file
      WHERE ogb31 = g_oep.oep01
    #MOD-D10096 add end   -----

    #CHI-C40019 add begin---
    IF g_ogb_cnt = 0 THEN
       CALL cl_set_comp_entry("oep08b,oep14b,oep10b,oep07b",TRUE)
    END IF
    #CHI-C40019 add end-----

END FUNCTION

FUNCTION t800_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)
   DEFINE l_cnt   LIKE type_file.num5    #No:FUN-A50103

   IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("oep01",FALSE)
   END IF

  #IF g_oea00 = "8" OR g_oea00 = "9" THEN                                                                 #CHI-C90034 mark
   IF g_oea00 = "8"  THEN                                                                                 #CHI-C90034
      CALL cl_set_comp_entry("oep06b,oep07b,oep08b,oep10b,oep11b,oep16b,oep25b,oep26b,oep41b",FALSE)      #FUN-C40081 add oep16b   #FUN-C40080 add oep25b,oep26b    #FUN-C20109 add oep41b

      CALL cl_set_comp_entry("oep161b,oep162b,oep163b",FALSE)    #No:FUN-A50103
      CALL cl_set_comp_entry("oep261b,oep262b,oep263b",FALSE)    #No:FUN-A50103
   END IF

   #-----No:FUN-A50103-----
   #已出貨不可修改訂金資料
   SELECT COUNT(*) INTO l_cnt
     FROM ogb_file
    WHERE ogb31 = g_oep.oep01

   IF l_cnt <> 0 THEN
      CALL cl_set_comp_entry("oep161b,oep261b",FALSE)
   END IF

   #已有訂金立帳資料時，不可修改幣別
   SELECT COUNT(*) INTO l_cnt
     FROM oma_file
    WHERE oma16 = g_oep.oep01
      AND oma00 = '11'

   IF l_cnt <> 0 THEN
      CALL cl_set_comp_entry("oep08b",FALSE)
   END IF
   #-----No:FUN-A50103 END-----

   #TQC-C20211 ----- add start -----
   LET g_cnt = 0
   SELECT COUNT(*) INTO g_cnt FROM oga_file
    WHERE oga16 = g_oep.oep01 AND ogaconf = 'Y'
   IF g_cnt > 0 THEN
      CALL cl_set_comp_entry("oep14b",FALSE)
   END IF
   #TQC-C20211 ----- add end -----

  #MOD-D10096 add start -----
   LET g_ogb_cnt = 0
   SELECT COUNT(*) INTO g_ogb_cnt
     FROM ogb_file
    WHERE ogb31 = g_oep.oep01
  #MOD-D10096 add end   -----

   #CHI-C40019 add begin---
   IF g_ogb_cnt > 0 THEN
      CALL cl_set_comp_entry("oep08b,oep14b,oep10b,oep07b",FALSE)
   END IF
   #CHI-C40019 add end-----
END FUNCTION

#Query 查詢
FUNCTION t800_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    CALL cl_opmsg('q')
    CALL cl_msg("")                          #FUN-640184

    CLEAR FORM
    CALL g_oeq.clear()
    CALL t800_cs()                           #取得查詢條件
    IF INT_FLAG THEN                         #使用者不玩了
        LET INT_FLAG = 0
        LET g_oep.oep01 = NULL   #MOD-660086 add
        RETURN
    END IF

    OPEN t800_b_cs                          #從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
       CALL cl_err('',SQLCA.sqlcode,0)
       INITIALIZE g_oep.oep01 TO NULL
    ELSE
       CALL t800_fetch('F')                 #讀出TEMP第一筆並顯示
       OPEN t800_count
       FETCH t800_count INTO g_row_count
       DISPLAY g_row_count TO FORMONLY.cnt
       CLOSE t800_count
    END IF

END FUNCTION

#處理資料的讀取
FUNCTION t800_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1                  #處理方式  #No.FUN-680137 VARCHAR(1)

    CALL cl_msg("")                              #FUN-640184

    CASE p_flag
      WHEN 'N' FETCH NEXT     t800_b_cs INTO g_oep.oep01,g_oep.oep02
      WHEN 'P' FETCH PREVIOUS t800_b_cs INTO g_oep.oep01,g_oep.oep02
      WHEN 'F' FETCH FIRST    t800_b_cs INTO g_oep.oep01,g_oep.oep02
      WHEN 'L' FETCH LAST     t800_b_cs INTO g_oep.oep01,g_oep.oep02
      WHEN '/'
            IF (NOT g_no_ask) THEN
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0  ######add for prompt bug
                PROMPT g_msg CLIPPED,': ' FOR g_jump
                   ON IDLE g_idle_seconds
                      CALL cl_on_idle()

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


                END PROMPT
                IF INT_FLAG THEN LET INT_FLAG = 0 EXIT CASE END IF
            END IF
            LET g_no_ask = FALSE
            FETCH ABSOLUTE g_jump t800_b_cs INTO g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
    END CASE

    IF SQLCA.sqlcode THEN                         #有麻煩
        CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)
        INITIALIZE g_oep.oep01 TO NULL           #No.FUN-6A0020
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
    #-----FUN-A20057---------
    SELECT * INTO g_oep.* FROM oep_file WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
    IF SQLCA.sqlcode THEN                         #有麻煩
        CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)
        INITIALIZE g_oep.* TO NULL
        RETURN
    END IF
    #-----END FUN-A20057-----

    LET g_data_owner = g_oep.oepuser      #FUN-4C0057 add
    LET g_data_group = g_oep.oepgrup      #FUN-4C0057 add
    LET g_data_plant = g_oep.oepplant #FUN-980030
    CALL t800_show()
END FUNCTION

#將資料顯示在畫面上
FUNCTION t800_show()
DEFINE l_oea03   LIKE oea_file.oea03,
       l_oea032  LIKE oea_file.oea032,
       l_oea23   LIKE oea_file.oea23,
       l_oea32   LIKE oea_file.oea32,
       l_oag02   LIKE oag_file.oag02,
       l_oep02   LIKE ooy_file.ooytype,  #No.FUN-680137 VARCHAR(02)
       l_oep01x  LIKE oep_file.oep01  #No.FUN-680137 VARCHAR(05)     #No:FUN-550070
  DEFINE l_gec04        LIKE gec_file.gec04    #FUN-A80118 Add
  DEFINE l_gec07        LIKE gec_file.gec07    #FUN-A80118 Add
  DEFINE l_gec04b       LIKE gec_file.gec04    #FUN-A80118 Add
  DEFINE l_gec07b       LIKE gec_file.gec07    #FUN-A80118 Add
  DEFINE l_oah02        LIKE oah_file.oah02,   #FUN-B30081 Add
         l_oag02a       LIKE oag_file.oag02,   #FUN-B30081 Add
         l_azi02        LIKE azi_file.azi02,   #FUN-B30081 Add
         l_ocd03        LIKE ocd_file.ocd03,   #FUN-B30081 Add
         l_ged02        LIKE ged_file.ged02,   #FUN-B30081 Add
         l_oah02b       LIKE oah_file.oah02,   #FUN-B30081 Add
         l_oag02b       LIKE oag_file.oag02,   #FUN-B30081 Add
         l_azi02b       LIKE azi_file.azi02,   #FUN-B30081 Add
         l_ocd03b       LIKE ocd_file.ocd03,   #FUN-B30081 Add
         l_ged02b       LIKE ged_file.ged02    #FUN-B30081 Add
  DEFINE l_azf03        LIKE azf_file.azf03    #MOD-C20013 Add
  DEFINE l_oeaud02      LIKE oea_file.oeaud02

    LET g_oep_t.* = g_oep.*
    DISPLAY BY NAME g_oep.oeporiu,g_oep.oeporig,
           g_oep.oep01,g_oep.oep02,g_oep.oep04,g_oep.oep12,   #FUN-A20057 add g_oep.oep12
           g_oep.oep06,g_oep.oep06b,g_oep.oep07,g_oep.oep07b,
           g_oep.oep08,g_oep.oep08b,g_oep.oepconf,g_oep.oep09,
           g_oep.oep10,g_oep.oep10b,g_oep.oep11,g_oep.oep11b, #FUN-560263
           g_oep.oep161,g_oep.oep162,g_oep.oep163,   #No:FUN-A50103
           g_oep.oep261,g_oep.oep262,g_oep.oep263,   #No:FUN-A50103
           g_oep.oep161b,g_oep.oep162b,g_oep.oep163b,   #No:FUN-A50103
           g_oep.oep261b,g_oep.oep262b,g_oep.oep263b,   #No:FUN-A50103
           g_oep.oepmksg,
           g_oep.oepuser,g_oep.oepgrup,g_oep.oepmodu,g_oep.oepdate, #no.7214
           g_oep.oepsendu,g_oep.oepsendd,g_oep.oepsendt,            #FUN-CC0094 add
           g_oep.oepud01,g_oep.oepud02,g_oep.oepud03,g_oep.oepud04,
           g_oep.oepud05,g_oep.oepud06,g_oep.oepud07,g_oep.oepud08,
           g_oep.oepud09,g_oep.oepud10,g_oep.oepud11,g_oep.oepud12,
           g_oep.oepud13,g_oep.oepud14,g_oep.oepud15
          ,g_oep.oep13,g_oep.oep14,g_oep.oep14b,g_oep.oep15,g_oep.oep15b   #FUN-A80118 Add
          ,g_oep.oep16,g_oep.oep16b                                        #FUN-C40081
          ,g_oep.oep25,g_oep.oep26,g_oep.oep25b,g_oep.oep26b               #FUN-C40080
          ,g_oep.oep41,g_oep.oep41b                                        #FUN-C20109

    #CKP
    IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_oep.oep09  ='1' OR
       g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

    CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg) #顯示目前狀態
         RETURNING g_sta

    DISPLAY g_sta TO FORMONLY.desc

    CALL t800_peo('d',g_oep.oep12)   #FUN-A20057

    SELECT oea00,oea03,oea032,oea23,oea32,oag02 ,oea901,oea905,oeaconf,oeaud02   #No:FUN-740016
      INTO g_oea00,l_oea03,l_oea032,l_oea23,l_oea32,l_oag02 ,   #No:FUN-740016
           g_oea901,g_oea905,g_oeaconf,l_oeaud02
                 FROM oea_file LEFT OUTER JOIN oag_file ON oea32 = oag01
                WHERE oea01 = g_oep.oep01
    #MOD-C20013 -- add start --
    LET l_azf03 = ' '
       SELECT azf03 INTO l_azf03
        FROM azf_file
         WHERE azf01 = g_oep.oep13
          AND azf02 = '2'
    DISPLAY l_azf03 TO FORMONLY.azf03
    #MOD-C20013 -- add end --
    DISPLAY l_oea03  TO FORMONLY.oea03
    DISPLAY l_oea032 TO FORMONLY.oea032
    DISPLAY l_oea23 TO FORMONLY.oea23
    DISPLAY l_oea32 TO FORMONLY.oea32      #No:MOD-880088 add
    DISPLAY l_oag02 TO FORMONLY.oag02      #FUN-8A0081  add
    DISPLAY l_oeaud02 TO FORMONLY.oeaud02
    #FUN-B30081 Add
    LET l_oah02 = ' '
    LET l_oag02a = ' '
    LET l_azi02 = ' '
    LET l_ocd03 = ' '
    LET l_ged02 = ' '
    LET l_oah02b = ' '
    LET l_oag02b = ' '
    LET l_azi02b = ' '
    LET l_ocd03b = ' '
    LET l_ged02b = ' '
    LET l_gec04 = ' '
    LET l_gec07 = ' '
    LET l_gec04b = ' '
    LET l_gec07b = ' '
    #FUN-C40080 add begin---
    LET g_oab02_1  = NULL
    LET g_oab02_2  = NULL
    LET g_oab02_1b = NULL
    LET g_oab02_2b = NULL
    #FUN-C40080 add end-----
    #FUN-C20109 add begin---
    LET g_oac02  = NULL
    LET g_oac02b = NULL
    #FUN-C20109 add end-----
    IF NOT cl_null(g_oep.oep10) THEN
       SELECT oah02 INTO l_oah02 FROM oah_file WHERE oah01 = g_oep.oep10
    END IF
    IF NOT cl_null(g_oep.oep07) THEN
       SELECT oag02 INTO l_oag02a FROM oag_file WHERE oag01 = g_oep.oep07
    END IF
    IF NOT cl_null(g_oep.oep08) THEN
       SELECT azi02 INTO l_azi02 FROM azi_file WHERE azi01 = g_oep.oep08
    END IF
    IF NOT cl_null(g_oep.oep06) THEN
       SELECT ocd03 INTO l_ocd03 FROM ocd_file WHERE ocd01=g_oea.oea04 AND ocd02 = g_oep.oep06
    END IF
    IF NOT cl_null(g_oep.oep11) THEN
       SELECT ged02 INTO l_ged02 FROM ged_file WHERE ged01 = g_oep.oep11
    END IF
    IF NOT cl_null(g_oep.oep10b) THEN
       SELECT oah02 INTO l_oah02b FROM oah_file WHERE oah01 = g_oep.oep10b
    END IF
    IF NOT cl_null(g_oep.oep07b) THEN
       SELECT oag02 INTO l_oag02b FROM oag_file WHERE oag01 = g_oep.oep07b
    END IF
    IF NOT cl_null(g_oep.oep08b) THEN
       SELECT azi02 INTO l_azi02b FROM azi_file WHERE azi01 = g_oep.oep08b
    END IF
    IF NOT cl_null(g_oep.oep06b) THEN
       SELECT ocd03 INTO l_ocd03b FROM ocd_file WHERE ocd01=g_oea.oea04 AND ocd02 = g_oep.oep06b
    END IF
    IF NOT cl_null(g_oep.oep11b) THEN
       SELECT ged02 INTO l_ged02b FROM ged_file WHERE ged01 = g_oep.oep11b
    END IF

    #FUN-C40080 add begin---
    IF NOT cl_null(g_oep.oep25) THEN
       SELECT oab02 INTO g_oab02_1 FROM oab_file WHERE oab01=g_oep.oep25
    END IF

    IF NOT cl_null(g_oep.oep26) THEN
       SELECT oab02 INTO g_oab02_2 FROM oab_file WHERE oab01=g_oep.oep26
    END IF

    IF NOT cl_null(g_oep.oep25b) THEN
       SELECT oab02 INTO g_oab02_1b FROM oab_file WHERE oab01=g_oep.oep25b
    END IF

    IF NOT cl_null(g_oep.oep26b) THEN
       SELECT oab02 INTO g_oab02_2b FROM oab_file WHERE oab01=g_oep.oep26b
    END IF

    DISPLAY g_oab02_1 TO FORMONLY.oab02_1
    DISPLAY g_oab02_2 TO FORMONLY.oab02_2
    DISPLAY g_oab02_1b TO FORMONLY.oab02_1b
    DISPLAY g_oab02_2b TO FORMONLY.oab02_2b
    #FUN-C40080 add end-----

    #FUN-C20109 add begin---
    IF NOT cl_null(g_oep.oep41) THEN
       SELECT oac02 INTO g_oac02 FROM oac_file WHERE oac01=g_oep.oep41
    END IF

    IF NOT cl_null(g_oep.oep41b) THEN
       SELECT oac02 INTO g_oac02b FROM oac_file WHERE oac01=g_oep.oep41b
    END IF

    DISPLAY g_oac02 TO FORMONLY.oac02
    DISPLAY g_oac02b TO FORMONLY.oac02b
    #FUN-C20109 add end-----

    DISPLAY l_oah02 TO FORMONLY.oah02
    DISPLAY l_oag02a TO FORMONLY.oag02a
    DISPLAY l_azi02 TO FORMONLY.azi02
    DISPLAY l_ocd03 TO FORMONLY.ocd03
    DISPLAY l_ged02 TO FORMONLY.ged02
    DISPLAY l_oah02b TO FORMONLY.oah02b
    DISPLAY l_oag02b TO FORMONLY.oag02b
    DISPLAY l_azi02b TO FORMONLY.azi02b
    DISPLAY l_ocd03b TO FORMONLY.ocd03b
    DISPLAY l_ged02b TO FORMONLY.ged02b
    #FUN-B30081 Add
    #FUN-A80118 Add
    IF NOT cl_null(g_oep.oep14) THEN
       LET l_gec04 = ' '
       LET l_gec07 = ' '
       SELECT gec04,gec07 INTO l_gec04,l_gec07
         FROM gec_file
        WHERE gec01 = g_oep.oep14
          AND gec011 = '2'
       DISPLAY l_gec04 TO FORMONLY.gec04
       DISPLAY l_gec07 TO FORMONLY.gec07
    END IF
    IF NOT cl_null(g_oep.oep14b) THEN
       LET l_gec04b = ' '
       LET l_gec07b = ' '
       SELECT gec04,gec07 INTO l_gec04b,l_gec07b
         FROM gec_file
        WHERE gec01 = g_oep.oep14b
          AND gec011 = '2'
       DISPLAY l_gec04b TO FORMONLY.gec04b
       DISPLAY l_gec07b TO FORMONLY.gec07b
    END IF
    #FUN-A80118 Add
    DISPLAY l_gec04 TO FORMONLY.gec04    #FUN-B30081 Add
    DISPLAY l_gec07 TO FORMONLY.gec07    #FUN-B30081 Add
    DISPLAY l_gec04b TO FORMONLY.gec04b  #FUN-B30081 Add
    DISPLAY l_gec07b TO FORMONLY.gec07b  #FUN-B30081 Add
    CALL t800_b_fill(g_wc2)              #單身
    CALL cl_show_fld_cont()                   #No:FUN-550037 hmf
END FUNCTION

FUNCTION t800_r()
    IF s_shut(0) THEN RETURN END IF
    IF g_oep.oep01 IS NULL OR g_oep.oep01 = ' ' THEN
       CALL cl_err("",-400,0)                 #No.FUN-6A0020
       RETURN
    END IF
    #----> 如為'已確認',不可取消
    IF g_oep.oepconf = 'Y' THEN
       CALL cl_err('','axm-291',0)
       RETURN
    END IF
    IF g_oep.oepconf = 'X' THEN CALL cl_err(g_oep.oep01,'9024',0) RETURN END IF
    IF g_oep.oep09 matches '[Ss1]' THEN    #FUN-550031
     CALL cl_err("","mfg3557",0)
     RETURN
    END IF

    LET g_success = 'Y'

    BEGIN WORK

    OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
    IF STATUS THEN
       CALL cl_err("OPEN t800_cl:", STATUS, 1)
       CLOSE t800_cl
       ROLLBACK WORK
       RETURN
    END IF

    FETCH t800_cl INTO g_oep.*               # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)          #資料被他人LOCK
        CLOSE t800_cl ROLLBACK WORK RETURN
    END IF

    CALL t800_show()

    IF cl_delh(0,0) THEN                   #確認一下
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "oep01"         #No.FUN-9B0098 10/02/24
        LET g_doc.column2 = "oep02"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_oep.oep01      #No.FUN-9B0098 10/02/24
        LET g_doc.value2 = g_oep.oep02      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                #No.FUN-9B0098 10/02/24
       DELETE FROM oep_file WHERE oep01 = g_oep.oep01
                            AND oep02 = g_oep.oep02
       IF SQLCA.sqlcode THEN
          CALL cl_err('del_oep',SQLCA.sqlcode,0)
          LET g_success = 'N'
       END IF

#MOD-B20119 --begin--
       DELETE FROM oepa_file WHERE oepa01 = g_oep.oep01
                               AND oepa02 = g_oep.oep02
       IF SQLCA.sqlcode THEN
          CALL cl_err('del_oepa',SQLCA.sqlcode,0)
          LET g_success = 'N'
       END IF
#MOD-B20119 --end--

##FUN-CC0007---add---START
##刪除指定料件特性(oeqa_file)資料
#      DELETE FROM oeqa_file WHERE oeqa01  = g_oep.oep01
#                              AND oeqa011 = g_oep.oep02
#      IF SQLCA.sqlcode THEN
#         CALL cl_err('del_oeqa',SQLCA.sqlcode,0)
#         LET g_success = 'N'
#      END IF
##FUN-CC0007---add-----END

       DELETE FROM oeq_file WHERE oeq01 = g_oep.oep01
                            AND oeq02 = g_oep.oep02
       IF SQLCA.sqlcode THEN
          CALL cl_err('del_oeq',SQLCA.sqlcode,0)
          LET g_success = 'N'
       END IF
       DELETE FROM oer_file WHERE oer01 = g_oep.oep01
                            AND oer02 = g_oep.oep02
       IF SQLCA.sqlcode THEN
          CALL cl_err('del_oer',SQLCA.sqlcode,0)
          LET g_success = 'N'
       END IF

       LET g_key1=g_oep.oep01 CLIPPED,g_oep.oep02 USING '&&' CLIPPED
       DELETE FROM azd_file WHERE azd01 = g_key1 AND azd02=26

       CALL g_oeq.clear()
       INITIALIZE g_oep.* TO NULL
       CLEAR FORM

       LET g_msg=TIME
       INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)  #FUN-980010 add plant & legal
                    VALUES ('axmt800',g_user,g_today,g_msg,g_oep.oep01,'delete',g_plant,g_legal)
    END IF
    IF g_success = 'Y' THEN
       COMMIT WORK
       CALL cl_flow_notify(g_oep.oep01,'D') #CHI-A80030 add
    ELSE
       ROLLBACK WORK
       RETURN                #MOD-760123 add
    END IF

    IF g_success = 'Y' THEN
       DROP TABLE count_tmp
       EXECUTE t800_cnt_tmp
       LET g_row_count=sqlca.sqlerrd[3]
       #FUN-B50064-add-start--
       IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
          COMMIT WORK
          RETURN
       END IF
       #FUN-B50064-add-end--
       DISPLAY g_row_count TO FORMONLY.cnt
       OPEN t800_b_cs
       IF g_curs_index = g_row_count + 1 THEN
          LET g_jump = g_row_count
          CALL t800_fetch('L')
       ELSE
          LET g_jump = g_curs_index
          LET g_no_ask = TRUE
          CALL t800_fetch('/')
       END IF
    END IF

END FUNCTION

#單身
FUNCTION t800_b()
DEFINE
    l_ac_t          LIKE type_file.num5,         #未取消的ARRAY CNT  #No.FUN-680137 SMALLINT
    l_n             LIKE type_file.num5,         #檢查重複用  #No.FUN-680137 SMALLINT
    l_cnt           LIKE type_file.num5,         #檢查重複用  #No.FUN-680137 SMALLINT
    l_lock_sw       LIKE type_file.chr1,         #單身鎖住否  #No.FUN-680137 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,         #處理狀態  #No.FUN-680137 VARCHAR(1)
    l_misc          LIKE fan_file.fan02,         #No.FUN-680137 VARCHAR(04)   #
    l_no            LIKE oeb_file.oeb04,
    l_qty           LIKE oeq_file.oeq12a,        #Qty
    l_up            LIKE oeq_file.oeq13a,        #Unit Price
    l_oeb12         LIKE oeb_file.oeb12,
    l_new_oeq04a    LIKE oeq_file.oeq04a,
    l_new_oeq12a    LIKE oeq_file.oeq12a,
    l_new_oeq15a    LIKE oeq_file.oeq15a,
    l_new_oeq28a    LIKE oeq_file.oeq28a,        #No:FUN-740016
    l_new_oeq29a    LIKE oeq_file.oeq29a,        #No:FUN-740016
    l_oea213        LIKE oea_file.oea213,
    l_oea211        LIKE oea_file.oea211,
    l_oeb16         LIKE oeb_file.oeb16,
    l_oea23         LIKE oea_file.oea23,
    l_oea901        LIKE oea_file.oea901,
    l_oeb905        LIKE oeb_file.oeb905,        #MOD-670129 add 備置否
    l_oeb19         LIKE oeb_file.oeb19,         #MOD-670129 add 已備置量
    g_msg1          LIKE type_file.chr1000,      #No.FUN-680137 VARCHAR(100) #MOD-670129 add
    l_oeq04a_o      LIKE oeq_file.oeq04a,        #MOD-490359
    l_oeq12a_o      LIKE oeq_file.oeq12a,        #MOD-890224
    l_oeq14a_o      LIKE oeq_file.oeq14a,        #MOD-710031 add
    l_allow_insert  LIKE type_file.num5,         #可新增否  #No.FUN-680137 SMALLINT
    l_allow_delete  LIKE type_file.num5,         #可刪除否  #No.FUN-680137 SMALLINT
    l_oep09         LIKE oep_file.oep09,
    l_oep08         LIKE oep_file.oep08          #FUN-C60076
DEFINE l_oeb23 LIKE oeb_file.oeb23               #No:MOD-640304 add
DEFINE l_imaag         LIKE ima_file.imaag       #No.TQC-650108
DEFINE l_imaag1        LIKE ima_file.imaag       #No.TQC-650108
DEFINE g_t1            LIKE oay_file.oayslip     #No.TQC-650108
DEFINE l_form          LIKE gab_file.gab01
DEFINE l_azf08         LIKE azf_file.azf08
DEFINE l_count         LIKE type_file.num5
DEFINE l_ogb12         LIKE ogb_file.ogb12       #MOD-880178
DEFINE l_oeb1004       LIKE oeb_file.oeb1004     #FUN-9C0083
DEFINE l_oea00         LIKE oea_file.oea00       #FUN-9C0083
DEFINE l_oea02         LIKE oea_file.oea02       #FUN-9C0083
DEFINE l_oea03         LIKE oea_file.oea03       #FUN-9C0083
DEFINE l_term          LIKE oep_file.oep10       #FUN-9C0152
DEFINE l_pjb09         LIKE pjb_file.pjb09       #FUN-A80118 Add
DEFINE l_pjb11         LIKE pjb_file.pjb11       #FUN-A80118 Add
DEFINE l_pjb25         LIKE pjb_file.pjb25       #FUN-A80118 Add
DEFINE l_fetch_price   LIKE type_file.chr1       #MOD-B80192 add
DEFINE l_flag1         LIKE type_file.chr10      #FUN-910088 add
DEFINE l_oea02_1       LIKE oea_file.oea02       #TQC-C70161 add
DEFINE l_oeb03         LIKE oeb_file.oeb03       #FUN-C70021 add
DEFINE l_oeb13         LIKE oeb_file.oeb13       #FUN-C70021 add
DEFINE l_oeb14         LIKE oeb_file.oeb14       #FUN-C70021 add
DEFINE l_oeb14t        LIKE oeb_file.oeb14t      #FUN-C70021 add
DEFINE l_oeb71         LIKE oeb_file.oeb71       #FUN-C70021 add
DEFINE l_oeb24         LIKE oeb_file.oeb24       #FUN-CA0009 add
DEFINE l_oea11         LIKE oea_file.oea11       #MOD-C70061 add
DEFINE l_oea12         LIKE oea_file.oea12       #MOD-C70061 add
#DEFINE l_ima928        LIKE ima_file.ima928      #FUN-CC0007 add
#DEFINE l_ima929        LIKE ima_file.ima929      #FUN-CC0007 add
#DEFINE l_imac          RECORD LIKE imac_file.*   #FUN-CC0007 add
#DEFINE l_ini03         LIKE ini_file.ini03       #FUN-CC0007 add
#DEFINE l_oeqa07a       LIKE oeqa_file.oeqa07a    #FUN-CC0007 add
#DEFINE l_oeba          RECORD LIKE oeba_file.*   #FUN-CC0007 add
#DEFINE l_oeq04a        LIKE oeq_file.oeq04a      #FUN-CC0007 add
DEFINE l_ima130        LIKE ima_file.ima130      #MOD-D20152 add

   #FUN-CA0009 add START
   #進入單身時,先抓取原訂單的訂單類型
    IF cl_null(g_oea00) THEN
       SELECT oea00 INTO g_oea00 FROM oea_file
         WHERE oea01 = g_oep.oep01
    END IF
   #FUN-CA0009 add END

    LET g_action_choice = ""
    IF s_shut(0) THEN RETURN END IF
    IF g_oep.oep01 IS NULL THEN
        RETURN
    END IF
    IF g_oep.oepacti ='N' THEN    #檢查資料是否為無效
        CALL cl_err(g_oep.oep01,'aom-000',0)
        RETURN
    END IF
    #--->如為'已確認',不可取消
    IF g_oep.oepconf = 'Y' THEN
       CALL cl_err('','axm-291',0)
       RETURN
    END IF
    IF g_oep.oepconf = 'X' THEN CALL cl_err(g_oep.oep01,'9024',0) RETURN END IF
    IF g_oep.oep09 matches '[Ss]' THEN          #FUN-550031
        CALL cl_err('','apm-030',0)
        RETURN
    END IF
    LET l_fetch_price = 'Y'       #MOD-B80192 add
    LET l_oep09 = g_oep.oep09     #FUN-550031
    CALL cl_opmsg('b')

    LET g_forupd_sql = "SELECT * FROM oeq_file ",
                       " WHERE oeq01= ? AND oeq02 = ? AND oeq03= ?  FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t800_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR


    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    INPUT ARRAY g_oeq WITHOUT DEFAULTS FROM s_oeq.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

        BEFORE INPUT
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF

        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()
            LET g_newline='N'    #MOD-760071 add

            BEGIN WORK

            OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
            IF STATUS THEN
               CALL cl_err("OPEN t800_cl:", STATUS, 1)
               CLOSE t800_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH t800_cl INTO g_oep.*            # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      # 資料被他人LOCK
               CLOSE t800_cl ROLLBACK WORK RETURN
            END IF

            IF g_rec_b >= l_ac THEN
               LET p_cmd='u'
               LET g_oeq_t.* = g_oeq[l_ac].*  #BACKUP
               LET l_oeq04a_o = g_oeq[l_ac].oeq04a  #BACKUP #MOD-490359
               LET l_oeq12a_o = g_oeq[l_ac].oeq12a  #MOD-890224
          #FUN-910088-add--start--
               LET g_oeq05a_t = g_oeq[l_ac].oeq05a
               LET g_oeq20a_t = g_oeq[l_ac].oeq20a
               LET g_oeq23a_t = g_oeq[l_ac].oeq23a
               LET g_oeq26a_t = g_oeq[l_ac].oeq26a
          #FUN-910088-add--edd--

               OPEN t800_bcl USING g_oep.oep01, g_oep.oep02, g_oeq_t.oeq03
               IF STATUS THEN
                  CALL cl_err("OPEN t800_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
               ELSE
                  FETCH t800_bcl INTO b_oeq.*
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_oeq_t.oeq03,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  ELSE
                     CALL t800_b_move_to() #No:FUN-7C0017
                     SELECT ima021 INTO g_oeq[l_ac].ima021a FROM ima_file
                      WHERE ima01=g_oeq[l_ac].oeq04a
                     SELECT ima021 INTO g_oeq[l_ac].ima021b FROM ima_file
                      WHERE ima01=g_oeq[l_ac].oeq04b
                     SELECT oeb920 INTO g_oeb920 FROM oeb_file
                      WHERE oeb01 = g_oep.oep01
                        AND oeb03 = g_oeq[l_ac].oeq03
                    LET g_cnt=0
                    SELECT COUNT(*) INTO g_cnt
                        FROM oeb_file
                        WHERE oeb01=g_oep.oep01
                          AND oeb03=g_oeq[l_ac].oeq03
                    IF g_cnt = 0 THEN
                        LET g_newline='Y'
                    END IF
                    LET g_cnt=0
                    SELECT COUNT(*) INTO g_cnt FROM oeb_file
                      WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
                    IF g_cnt = 0 THEN
                       LET g_oeb1012='N'
                    ELSE
                       SELECT oeb1012 INTO g_oeb1012 FROM oeb_file
                         WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
                       IF cl_null(g_oeb1012) THEN
                          LET g_oeb1012 = 'N'
                       END IF
                    END IF
                     CALL t800_set_no_required(g_newline)
                     CALL t800_set_required(g_newline)
                  END IF
               END IF
               LET g_change='N'
               LET g_oeq04   = g_oeq[l_ac].oeq04b
               IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
                  LET g_oeq04 = g_oeq[l_ac].oeq04a
               END IF
               LET g_before_input_done = FALSE
               CALL t800_set_entry_b(p_cmd)
               CALL t800_set_no_entry_b(p_cmd)
               LET g_before_input_done = TRUE
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF

        BEFORE INSERT

            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oeq[l_ac].* TO NULL      #900423
            LET g_oeq[l_ac].before = '0'
            LET g_oeq[l_ac].after  = '1'
            LET g_oeq_t.* = g_oeq[l_ac].*         #新輸入資料
            LET l_oeq04a_o = g_oeq[l_ac].oeq04a   #MOD-490359
            LET l_oeq12a_o = g_oeq[l_ac].oeq12a   #MOD-890224
            LET g_change='N'  #No.FUN-560106
            LET g_before_input_done = FALSE
            CALL t800_set_entry_b(p_cmd)
            CALL t800_set_no_entry_b(p_cmd)
            LET g_before_input_done = TRUE
            CALL t800_set_no_required(g_newline) #MOD-760071 add
            CALL cl_show_fld_cont()     #FUN-550037(smin)
           #FUN-910088-add--start--
            LET g_oeq05a_t = NULL
            LET g_oeq20a_t = NULL
            LET g_oeq23a_t = NULL
            LET g_oeq26a_t = NULL
           #FUN-910088-add--edd--

            NEXT FIELD oeq03

        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            #若為三角貿易, 新增時交貨日不可空白
            SELECT oea901 INTO l_oea901 FROM oea_file
             WHERE oea01 = g_oep.oep01
            IF NOT cl_null(l_oea901) AND l_oea901 = 'Y' THEN
                IF cl_null(g_oeq[l_ac].oeq04b) AND
                   cl_null(g_oeq[l_ac].oeq15a)  THEN
                   CALL cl_err('','mfg3226',1)
                   NEXT FIELD oeq15a
                END IF
            END IF
            IF cl_null(g_oeq[l_ac].oeq04a)  AND
               cl_null(g_oeq[l_ac].oeq041a) AND
               cl_null(g_oeq[l_ac].oeq11a)  AND   #FUN-C60076
               cl_null(g_oeq[l_ac].oeq12a)  AND
               cl_null(g_oeq[l_ac].oeq13a)  AND
               cl_null(g_oeq[l_ac].oeq37a)  AND   #FUN-AB0082
               cl_null(g_oeq[l_ac].oeq14a)  AND   #MOD-920227
               cl_null(g_oeq[l_ac].oeq14ta) AND   #MOD-A70005
               cl_null(g_oeq[l_ac].oeq15a)  AND
               cl_null(g_oeq[l_ac].oeq23a)  AND
               cl_null(g_oeq[l_ac].oeq24a)  AND
               cl_null(g_oeq[l_ac].oeq25a)  AND
               cl_null(g_oeq[l_ac].oeq20a)  AND
               cl_null(g_oeq[l_ac].oeq21a)  AND
               cl_null(g_oeq[l_ac].oeq22a)  AND
               cl_null(g_oeq[l_ac].oeq26a)  AND
               cl_null(g_oeq[l_ac].oeq27a)  AND
               cl_null(g_oeq[l_ac].oeq28a)  AND   #No:FUN-740016
               cl_null(g_oeq[l_ac].oeq29a)  AND   #No:FUN-740016
               cl_null(g_oeq[l_ac].oeq30a)  AND   #No.FUN-990030
               cl_null(g_oeq[l_ac].oeq05a)  AND
               cl_null(g_oeq[l_ac].oeq31a)  AND   #FUN-A80118 Add
               cl_null(g_oeq[l_ac].oeq32a)  AND   #FUN-A80118 Add
               cl_null(g_oeq[l_ac].oeq33a)  AND   #FUN-A80118 Add
               cl_null(g_oeq[l_ac].ta_oeq01a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq02a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq03a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq04a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq05a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq06a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq07a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq08a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq09a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq10a) AND #add by donghy
               cl_null(g_oeq[l_ac].ta_oeq11a) THEN #add by donghy


               CALL cl_err('','mfg9328',1)   #MOD-9A0193
               CALL g_oeq.deleteElement(l_ac)   #取消 Array Element
            ELSE
                IF g_sma.sma115 = 'Y' THEN
                   IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
                      CALL s_chk_va_setting(g_oeq[l_ac].oeq04a)
                           RETURNING g_sw,g_ima906,g_ima907
                      IF g_sw=1 THEN
                         NEXT FIELD oeq04a
                      END IF

                      CALL s_chk_va_setting1(g_oeq[l_ac].oeq04a)
                           RETURNING g_sw,g_ima908
                      IF g_sw=1 THEN
                         NEXT FIELD oeq04a
                      END IF
                   END IF

                   CALL t800_set_origin_field()
                   IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF #MOD-D10109 add
                END IF
#MOD-B80196 -- begin --
#               IF cl_null(g_oeq[l_ac].oeq26a) AND g_sma.sma115 = 'N' THEN
#                  IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
#                     LET g_oeq[l_ac].oeq26a=g_oeq[l_ac].oeq05a
#                  END IF
#                  IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
#                     LET g_oeq[l_ac].oeq26a = NULL
#                     DISPLAY BY NAME g_oeq[l_ac].oeq26a
#                  END IF
#               END IF
#               IF cl_null(g_oeq[l_ac].oeq27a) AND g_sma.sma115 = 'N' THEN
#                  IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
#                     LET g_oeq[l_ac].oeq27a=g_oeq[l_ac].oeq12a
#                  END IF
#                  IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
#                     LET g_oeq[l_ac].oeq27a = NULL
#                     DISPLAY BY NAME g_oeq[l_ac].oeq27a
#                  END IF
#               END IF
#MOD-B80196 -- end --
                #CALL t800_oeq14ta()       #No.3317 010821 add   #MOD-A70005
                CALL t800_b_move_back()   #No:FUN-7C0017
               #IF b_oeq.oeq37a=0 OR cl_null(b_oeq.oeq37a) THEN LET b_oeq.oeq37a=b_oeq.oeq13a END IF #FUN-AB0082 #MOD-B60080 mark
                IF b_oeq.oeq37a=0 OR cl_null(b_oeq.oeq37a) THEN LET b_oeq.oeq37a=b_oeq.oeq37b END IF #MOD-B60080
                INSERT INTO oeq_file VALUES(b_oeq.*)
                IF SQLCA.sqlcode THEN
                   CALL cl_err(g_oeq[l_ac].oeq03,SQLCA.sqlcode,0)
                   CANCEL INSERT
                ELSE
                   MESSAGE 'INSERT O.K'
                   LET g_rec_b=g_rec_b+1
                   LET l_oep09 = '0'          #FUN-550031
                   DISPLAY g_rec_b TO FORMONLY.cn2
                   IF g_oaz.oaz06 = 'Y' THEN
                      IF cl_null(g_oeq[l_ac].oeq04b) THEN
                         CALL s_mpslog('A',g_oeq[l_ac].oeq04a,
                                        g_oeq[l_ac].oeq12a,
                                        g_oeq[l_ac].oeq15a,'','','',
                                        g_oep.oep01,'',g_oeq[l_ac].oeq03)
                         IF g_success = 'N' THEN CANCEL INSERT END IF   #CHI-B80016 add
                      ELSE
                         IF cl_null(g_oeq[l_ac].oeq04a) THEN
                            LET l_new_oeq04a = g_oeq[l_ac].oeq04b
                         ELSE
                            LET l_new_oeq04a = g_oeq[l_ac].oeq04a
                         END IF
                         IF cl_null(g_oeq[l_ac].oeq12a) THEN
                            LET l_new_oeq12a = g_oeq[l_ac].oeq12b
                            LET l_new_oeq12a = s_digqty(l_new_oeq12a,g_oeq[l_ac].oeq05a)  #FUN-910088--add--
                         ELSE
                            LET l_new_oeq12a = g_oeq[l_ac].oeq12a
                         END IF
                         IF cl_null(g_oeq[l_ac].oeq15a) THEN
                            LET l_new_oeq15a = g_oeq[l_ac].oeq15b
                         ELSE
                            LET l_new_oeq15a = g_oeq[l_ac].oeq15a
                         END IF
                         CALL s_mpslog('U',l_new_oeq04a,
                              l_new_oeq12a,l_new_oeq15a,
                              g_oeq[l_ac].oeq04b,
                              g_oeq[l_ac].oeq12b,g_oeq[l_ac].oeq15b,
                              g_oep.oep01,g_oeq[l_ac].oeq03,
                              g_oeq[l_ac].oeq03)
                         IF g_success = 'N' THEN CANCEL INSERT END IF   #CHI-B80016 add
                      END IF
                   END IF
                   COMMIT WORK
                END IF
            END IF

        BEFORE FIELD oeq12a
            LET l_oeb16 = ''
            SELECT oeb16,oeb19,oeb905
              INTO l_oeb16,l_oeb19,l_oeb905
              FROM oeb_file
             WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03

        AFTER FIELD oeq03
            IF NOT cl_null(g_oeq[l_ac].oeq03) THEN
               IF cl_null(g_oeq_t.oeq03) OR            # 若輸入或更改且改KEY
                  g_oeq[l_ac].oeq03 != g_oeq_t.oeq03  THEN
                   SELECT count(*) INTO l_n FROM oeq_file
                    WHERE oeq01 = g_oep.oep01
                      AND oeq02 = g_oep.oep02
                      AND oeq03 = g_oeq[l_ac].oeq03
                  IF l_n > 0 THEN                  # Duplicated
                      CALL cl_err(g_oeq[l_ac].oeq03,-239,0)
                      LET g_oeq[l_ac].oeq03 = g_oeq_t.oeq03
                      NEXT FIELD oeq03
                  END IF
               END IF
                LET g_cnt=0
                SELECT COUNT(*) INTO g_cnt
                  FROM oeb_file
                 WHERE oeb01=g_oep.oep01
                   AND oeb03=g_oeq[l_ac].oeq03
                   AND oeb70='Y'

                IF g_cnt>0 THEN       #已結案
                   CALL cl_err('','axm-202',0)
                   NEXT FIELD oeq03
                END IF

               LET g_cnt = 0
               SELECT COUNT(*) INTO g_cnt
                 FROM oea_file,oeb_file
                WHERE oeb01=g_oep.oep01
                  AND oeb03=g_oeq[l_ac].oeq03
                  AND oeb12-oeb25-oeb29 <= 0
                  AND oea01=oeb01
                  AND (oea00='8' OR oea00='9')   #MOD-940354
               IF g_cnt > 0 THEN
                  CALL cl_err('','axm1003',1)
                  NEXT FIELD oeq03   #MOD-920164
               END IF

               #---->當已交量>0時,不可變更單位
                LET l_oeb12 = 0  #MOD-810195 add
                SELECT oeb24-oeb25 INTO l_oeb12  FROM oeb_file   #已交量
                 WHERE oeb01 = g_oep.oep01
                   AND oeb03 = g_oeq[l_ac].oeq03
                IF l_oeb12 > 0 THEN
                   CALL cl_err('','axm-276',0)     # 此訂單料號已有交貨  #MOD-810092 modify axm-292->axm-276
                   CALL cl_set_comp_entry("oeq04a,oeq041a,oeq05a,oeq26a,oeq20a,oeq23a,oeq11a",FALSE)      #FUN-C60076 add oeq11a
                   LET g_chk = '1'   #MOD-920300
                ELSE
                   CALL cl_set_comp_entry("oeq04a,oeq041a,oeq05a,oeq26a,oeq20a,oeq23a,oeq11a",TRUE)       #FUN-C60076 add oeq11a
                   LET g_chk = '0'   #MOD-920300
                END IF
                  #------>判斷此訂單有無此項次(若無代表為新增line)
                  LET g_cnt=0
                  SELECT COUNT(*) INTO g_cnt
                      FROM oeb_file
                      WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03

                  LET g_newline='N'       #MOD-760071 add
                  IF g_cnt = 0 THEN
                     LET g_newline='Y'    #MOD-760071 add
                     LET g_oeq[l_ac].oeq04b=''
                     LET g_oeq[l_ac].oeq041b=''
                     LET g_oeq[l_ac].ima021b=''
                     LET g_oeq[l_ac].oeq30b=''
                     LET g_oeq[l_ac].oeq05b=''
                     LET g_oeq[l_ac].oeq12b=0
                     LET g_oeq[l_ac].oeq13b=0
                     LET g_oeq[l_ac].oeq37b=0    #FUN-AB0082
                     LET g_oeq[l_ac].oeq15b=''
                     LET g_oeq[l_ac].oeq14b=0
                     #LET t_oeq14tb=0   #MOD-A70005
                     LET g_oeq[l_ac].oeq14tb=0   #MOD-A70005
                     IF p_cmd = 'a' THEN   #MOD-910144
                        LET g_oeq[l_ac].oeq04a=''
                        LET g_oeq[l_ac].oeq041a=''
                        LET g_oeq[l_ac].ima021a=''
                        LET g_oeq[l_ac].oeq30a=''      #No.FUN-990030
                        LET g_oeq[l_ac].oeq05a=''
                        LET g_oeq[l_ac].oeq12a=''      #MOD-970109
                        LET g_oeq[l_ac].oeq13a=0
                        LET g_oeq[l_ac].oeq37a=0       #FUN-AB0082
                        LET g_oeq[l_ac].oeq15a=''
                        LET g_oeq[l_ac].oeq14a=0
                        #LET t_oeq14ta=0   #MOD-A70005
                        LET g_oeq[l_ac].oeq14ta=0   #MOD-A70005
                     END IF   #MOD-910144
                     LET g_oeq[l_ac].oeq23b=''
                     LET g_oeq[l_ac].oeq24b=0
                     LET g_oeq[l_ac].oeq25b=0
                     LET g_oeq[l_ac].oeq20b=''
                     LET g_oeq[l_ac].oeq21b=0
                     LET g_oeq[l_ac].oeq22b=0
                     LET g_oeq[l_ac].oeq26b=''
                     LET g_oeq[l_ac].oeq27b=0

                     IF p_cmd = 'a' THEN   #MOD-910144
                        LET g_oeq[l_ac].oeq23a=''
                        LET g_oeq[l_ac].oeq24a=0
                        LET g_oeq[l_ac].oeq25a=0
                        LET g_oeq[l_ac].oeq20a=''
                        LET g_oeq[l_ac].oeq21a=0
                        LET g_oeq[l_ac].oeq22a=0
                        LET g_oeq[l_ac].oeq26a=''
                        LET g_oeq[l_ac].oeq27a=0
                     END IF   #MOD-910144
                     LET g_oeb1006 = 100
                     LET g_oeb1012 = 'N'
                  ELSE
                    ##MOD-C80195 -- add start --
                     LET g_oeq[l_ac].oeq13a=''
                     LET g_oeq[l_ac].oeq37a=''
                     LET g_oeq[l_ac].oeq14a=''
                     LET g_oeq[l_ac].oeq14ta=''
                     LET g_oeq[l_ac].oeq24a=''
                     LET g_oeq[l_ac].oeq25a=''
                     LET g_oeq[l_ac].oeq21a=''
                     LET g_oeq[l_ac].oeq22a=''
                     LET g_oeq[l_ac].oeq27a=''
                     LET g_oeq[l_ac].ta_oeq01a=''
                     LET g_oeq[l_ac].ta_oeq02a=''
                     LET g_oeq[l_ac].ta_oeq03a=''
                     LET g_oeq[l_ac].ta_oeq04a=''
                     LET g_oeq[l_ac].ta_oeq05a=''
                     LET g_oeq[l_ac].ta_oeq06a=''
                     LET g_oeq[l_ac].ta_oeq07a=''
                     LET g_oeq[l_ac].ta_oeq08a=''
                     LET g_oeq[l_ac].ta_oeq09a=''
                     LET g_oeq[l_ac].ta_oeq10a=''
                     LET g_oeq[l_ac].ta_oeq11a=''
                    ##MOD-C80195 -- add end --
                     CALL t800_oeq03(p_cmd)
                     IF NOT cl_null(g_errno) THEN
                        LET g_oeq[l_ac].oeq03=g_oeq_t.oeq03
                        NEXT FIELD oeq03
                     ELSE
                        LET l_oeb16 = ''
                        SELECT oeb16 INTO l_oeb16 FROM oeb_file
                         WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03
                        LET l_cnt=0
                        SELECT COUNT(*) INTO l_cnt FROM sfb_file
                         WHERE sfb22 = g_oep.oep01
                           AND sfb221 = g_oeq[l_ac].oeq03
                           AND sfb87!='X'
                        IF l_cnt > 0 THEN
                           CALL cl_err('','mfg-016',1)
                        END IF
                        CALL t800_chk_sfb()   #MOD-A40066
                     END IF
                  END IF
                     CALL t800_set_no_required(g_newline)  #MOD-760071 add
                     CALL t800_set_required(g_newline)     #MOD-760071 add
            END IF
            CALL t800_set_entry_b(p_cmd)
            CALL t800_set_no_entry_b(p_cmd)

        BEFORE FIELD oeq03
            CALL t800_set_entry_b(p_cmd)

        BEFORE FIELD oeq04a
            IF NOT cl_null(g_oeq[l_ac].oeq04b) THEN
               SELECT ima25,ima31,ima906,ima907,ima908
                 INTO g_ima25,g_ima31,g_ima906,g_ima907,g_ima908
                 FROM ima_file
                WHERE ima01=g_oeq[l_ac].oeq04b
               IF SQLCA.sqlcode THEN
                  IF g_oeq[l_ac].oeq04b MATCHES 'MISC*' THEN
                     SELECT ima25,ima31,ima906,ima907,ima908
                       INTO g_ima25,g_ima31,g_ima906,g_ima907,g_ima908
                       FROM ima_file
                      WHERE ima01='MISC'
                  END IF
               END IF
            END IF
            CALL t800_set_entry_b(p_cmd)

        AFTER FIELD oeq04a
            #CHI-A90019 add --start--
            IF cl_null(g_oeq[l_ac].oeq04a) THEN
               LET g_oeq[l_ac].oeq041a=''
               DISPLAY BY NAME g_oeq[l_ac].oeq041a
            ELSE
               #MOD-C70061 add start -----
               IF g_aza.aza50 = 'N' THEN #是否流通
                  SELECT oea11,oea12 INTO l_oea11,l_oea12 #抓取訂單單頭資料
                    FROM oea_file WHERE oea01 = g_oep.oep01
               #MOD-C70061 add end   -----
                  #FUN-C70021 add begin---
                  IF l_oea11 = '3' THEN #是否由合約轉入
                      SELECT oeb71 INTO l_oeb71 #抓取訂單單身資料
                        FROM oeb_file
                       WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03
                     IF cl_null(l_oeb71) THEN
                        SELECT COUNT(*) INTO l_cnt FROM oeb_file
                         WHERE oeb01 = l_oea12
                           AND oeb04 = g_oeq[l_ac].oeq04a
                        IF l_cnt = 0 THEN
                           CALL cl_err('','axm-238',1)
                           NEXT FIELD oeq04a
                        ELSE
                           SELECT oeb03,oeb12,oeb13,oeb14,oeb14t
                             INTO l_oeb03,l_oeb12,l_oeb13,l_oeb14,l_oeb14t
                             FROM oeb_file
                            WHERE oeb01 = l_oea12
                              AND oeb04 = g_oeq[l_ac].oeq04a
                           IF cl_null(l_oeb03) THEN
                              CALL cl_err('','axm-238',1)
                              NEXT FIELD oeq04a
                           END IF
                           LET g_oeq[l_ac].oeq12a  = l_oeb12
                           LET g_oeq[l_ac].oeq13a  = l_oeb13
                           LET g_oeq[l_ac].oeq14a  = l_oeb14
                           LET g_oeq[l_ac].oeq14ta = l_oeb14t
                           DISPLAY BY NAME g_oeq[l_ac].oeq12a
                           DISPLAY BY NAME g_oeq[l_ac].oeq13a
                           DISPLAY BY NAME g_oeq[l_ac].oeq14a
                           DISPLAY BY NAME g_oeq[l_ac].oeq14ta
                        END IF
                     END IF
                  END IF
                  #FUN-C70021 add end-----
               END IF #MOD-C70061 add

               #FUN-AA0059 ---------------------start----------------------------
               IF NOT s_chk_item_no(g_oeq[l_ac].oeq04a,"") THEN
                  CALL cl_err('',g_errno,1)
                  LET g_oeq[l_ac].oeq04a= g_oeq_t.oeq04a
                  NEXT FIELD oeq04a
               END IF
               #FUN-AA0059 ---------------------end-------------------------------
              #MOD-D20152 mark start -----
              #SELECT ima02,ima021
              #  INTO g_oeq[l_ac].oeq041a,g_oeq[l_ac].ima021a
              #MOD-D20152 mark end   -----
              #MOD-D20152 add start -----
               SELECT ima02,ima021,ima130
                 INTO g_oeq[l_ac].oeq041a,g_oeq[l_ac].ima021a,l_ima130
              #MOD-D20152 add end   -----
                 FROM ima_file
                WHERE ima01 = g_oeq[l_ac].oeq04a

              #MOD-D20152 add start -----
               SELECT oea00 INTO l_oea00 FROM oea_file WHERE oea01 = g_oep.oep01
               IF l_oea00 MATCHES '[123467]' AND l_ima130 = '0' THEN
                  CALL cl_err(g_oeq[l_ac].oeq04a,'axm-188',0)
                  NEXT FIELD oeq04a
               END IF
              #MOD-D20152 add end   -----

               #FUN-C60076 add begin---
               #取料號對應的客戶產品編號.
               #先取axmt800是否有變更幣別,再依幣別取客戶產品編號
                IF NOT cl_null(g_oep.oep08b) THEN
                   LET l_oep08 = g_oep.oep08b
                ELSE
                   LET l_oep08 = g_oep.oep08
                END IF

                SELECT obk03 INTO g_oeq[l_ac].oeq11a
                  FROM obk_file
                 WHERE obk01 = g_oeq[l_ac].oeq04a
                   AND obk02 = l_oea03
                   AND obk05 = l_oep08
               #FUN-C60076 add end-----
            END IF
            #CHI-A90019 add --end--
            IF cl_null(g_oeq[l_ac].oeq04a) OR (g_oeq[l_ac].oeq04a = g_oeq[l_ac].oeq04b) THEN
              #LET g_oeq[l_ac].oeq041a=''           #CHI-A90019 mark
               LET g_oeq[l_ac].ima021a=''
               LET g_oeq[l_ac].oeq05a=''            #TQC-840047
               LET g_oeq[l_ac].oeq11a = ''          #FUN-C60076
              #DISPLAY BY NAME g_oeq[l_ac].oeq041a  #CHI-A90019 mark
               DISPLAY BY NAME g_oeq[l_ac].ima021a
               DISPLAY BY NAME g_oeq[l_ac].oeq05a   #TQC-840047
               DISPLAY BY NAME g_oeq[l_ac].oeq11a   #FUN-C60076
            END IF
            #--->代表有變更料號
            IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
               IF g_sma.sma120 = 'Y' THEN
                  DISPLAY g_oeq[l_ac].oeq04a TO oeq04a
                  DISPLAY g_oeq[l_ac].oeq041a TO oeq041a
               END IF

               SELECT imaag,imaag1 INTO l_imaag,l_imaag1 FROM ima_file
                WHERE ima01 =g_oeq[l_ac].oeq04a
               IF NOT CL_null(l_imaag) AND l_imaag <> '@CHILD' THEN
                  CALL cl_err(g_oeq[l_ac].oeq04a,'aim1004',0)
                  NEXT FIELD oeq04a
               END IF
               IF g_sma.sma120 ='Y' AND g_sma.sma907 ='Y' THEN
                  LET g_t1 =g_oep.oep01[1,g_doc_len]
                  SELECT oay22 INTO g_oay22 FROM oay_file
                   WHERE oayslip =g_t1
                   IF NOT cl_null(g_oay22) THEN
                      IF g_oay22 <> l_imaag1 THEN
                         CALL cl_err('','atm-525',0)
                         NEXT FIELD oeq04a
                      END IF
                      IF cl_null(l_imaag1) THEN
                         CALL cl_err('','atm-525',0)
                         NEXT FIELD oeq04a
                      END IF
                   END IF
                END IF
                IF (g_oeq[l_ac].oeq04a != g_oeq[l_ac].oeq04b) OR g_oeq[l_ac].oeq04b IS NULL THEN  #NO:6808  #No:MOD-490242
                  IF NOT cl_null(g_oeq[l_ac].oeq04a)  THEN
                     #-----MOD-A40185---------
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM oga_file,ogb_file
                       WHERE ogb31=g_oep.oep01
                         AND ogb32=g_oeq[l_ac].oeq03
                         AND oga01=ogb01
                         AND ogaconf<>'X'
                     IF l_cnt > 0 THEN
                        CALL cl_err('','axm4100',0)
                        NEXT FIELD oeq04a
                     END IF
                     #-----END MOD-A40185-----
                     IF g_oaz.oaz46='Y' THEN   #將客戶品號轉為本公司品號
                        LET g_msg=NULL
                        SELECT MIN(obk01) INTO g_msg FROM obk_file
                            WHERE obk03=g_oeq[l_ac].oeq04a
                              AND obk02= (SELECT oea03 FROM oea_file
                                          WHERE oea01 = g_oep.oep01 )
                        IF NOT STATUS AND NOT cl_null(g_msg) THEN
                           LET g_oeq[l_ac].oeq04a = g_msg
                        END IF
                     END IF
                     LET l_misc=g_oeq[l_ac].oeq04a[1,4]
                     IF g_oeq[l_ac].oeq04a[1,4]='MISC' THEN  #NO:6808
                        SELECT COUNT(*) INTO l_n FROM ima_file
                         WHERE ima01=l_misc
                           AND ima01='MISC'
                        IF l_n=0 THEN
                           CALL cl_err('','aim-806',0)
                           NEXT FIELD oeq04a
                        END IF
                     END IF
                     LET l_no=g_oeq[l_ac].oeq04a  #NO:6808
                     #IF cl_null(g_oeq[l_ac].oeq041a) OR (g_oeq[l_ac].oeq04a != l_oeq04a_o ) THEN #MOD-490359   #MOD-A60009
                     IF NOT cl_null(g_oeq[l_ac].oeq04a) AND    #MOD-A60009
                        (cl_null(l_oeq04a_o) OR (g_oeq[l_ac].oeq04a != l_oeq04a_o )) THEN #MOD-A60009
                        CALL t800_oeq04a(l_no)                     #判斷有效否
                        IF NOT cl_null(g_errno) AND l_no[1,4] != 'MISC' THEN
                           CALL cl_err(g_oeq[l_ac].oeq04a,g_errno,0)
                           LET g_oeq[l_ac].oeq04a = g_oeq_t.oeq04a
                           LET l_oeq04a_o = NULL   #MOD-A60009
                           NEXT FIELD oeq04a
                        END IF
                     END IF
                  END IF

                  #---->當已交量>0時,不可變更料編號
                  IF NOT cl_null(g_oeq[l_ac].oeq04b)  THEN
                     LET l_oeb12 = 0  #MOD-810195 add
                     SELECT oeb24-oeb25 INTO l_oeb12  FROM oeb_file   #已交量
                      WHERE oeb01 = g_oep.oep01
                        AND oeb03 = g_oeq[l_ac].oeq03
                     IF l_oeb12 > 0 THEN
                        CALL cl_err('','axm-292',0)     # 此訂單料號已有交貨
                        LET g_oeq[l_ac].oeq04a = NULL
                        NEXT FIELD oeq12a
                     END IF

                  END IF
                  SELECT ima25,ima31 INTO g_ima25,g_ima31 FROM ima_file
                   WHERE ima01=g_oeq[l_ac].oeq04a
                  IF SQLCA.sqlcode THEN
                     IF g_oeq[l_ac].oeq04a MATCHES 'MISC*' THEN
                        SELECT ima25,ima31 INTO g_ima25,g_ima31 FROM ima_file
                         WHERE ima01='MISC'
                     END IF
                  END IF
                  IF g_sma.sma115 = 'Y' THEN
                     CALL s_chk_va_setting(g_oeq[l_ac].oeq04a)
                          RETURNING g_sw,g_ima906,g_ima907
                     IF g_sw=1 THEN
                        NEXT FIELD oeq04a
                     END IF
                     CALL s_chk_va_setting1(g_oeq[l_ac].oeq04a)
                          RETURNING g_sw,g_ima908
                     IF g_sw=1 THEN
                        NEXT FIELD oeq04a
                     END IF
                        CALL t800_du_default(p_cmd)
                      IF g_oeq[l_ac].oeq22a=0 THEN LET g_oeq[l_ac].oeq22a=NULL END IF  #MOD-780242
                      IF g_oeq[l_ac].oeq25a=0 THEN LET g_oeq[l_ac].oeq25a=NULL END IF  #MOD-780242
                      CALL t800_set_oeq27()                #MOD-780242
                      #add--str--TQC-CB0032
                     IF NOT cl_null(g_errno) THEN
                        CALL cl_err('',g_errno,0)
                        NEXT FIELD oeq04a
                     END IF
                     #add--end--TQC-CB0032
                  END IF
                  LET g_oeq04 = g_oeq[l_ac].oeq04a
                  LET g_change = 'Y'
               END IF
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq04a) AND
               (g_oeq[l_ac].oeq04a <> l_oeq04a_o OR cl_null(l_oeq04a_o))
               THEN
               SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
                WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
               SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
                WHERE oea01=g_oep.oep01
               LET l_term=g_oep.oep10b  #FUN-9C0152
               IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF #FUN-9C0152
               IF cl_null(g_oep.oep07b) THEN LET g_oep07 = g_oep.oep07 END IF  #MOD-AC0117
               IF cl_null(g_oep.oep08b) THEN LET g_oep08 = g_oep.oep08 END IF  #MOD-AC0117

               CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,'',g_oeq[l_ac].oeq05a,l_oea02,        #FUN-BC0071
                                     #l_oea00,g_plant,g_oep.oep08b,l_term, #FUN-9C0152   g_oep.oep10b-->l_term
#                                     '1',g_plant,g_oep.oep08b,l_term,     #FUN-AB0082   #MOD-AC0117
                                      '1',g_plant,g_oep08,l_term,          #MOD-AC0117
#                                     g_oep.oep07b,g_oep.oep01,g_oeq[l_ac].oeq03,        #MOD-AC0117
                                      g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,             #MOD-AC0117
                                     #g_oeq[l_ac].oeq12a,l_oeb1004,p_cmd)  #FUN-B10014
                                      g_oeq[l_ac].oeq12a,l_oeb1004,'b')    #FUN-B10014
                       #RETURNING g_oeq[l_ac].oeq13a                    #FUN-AB0082
                        RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a #FUN-AB0082
              #FUN-B70087 mod
              #IF g_oeq[l_ac].oeq13a=0 THEN CALL s_unitprice_entry(l_oea03,l_term,g_plant) END IF #FUN-9C0120 #FUN-9C0152   g_oep.oep10b-->l_term
               #FUN-BC0088 ------- add start --------------
               IF g_oeq[l_ac].oeq04a[1,4] = 'MISC' THEN
                  CALL s_unitprice_entry(l_oea03,l_term,g_plant,'M')
               ELSE
               #FUN-BC0088 ------- add end --------------
                  IF g_oeq[l_ac].oeq13a=0 THEN
                     CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
                  ELSE
                     CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
                  END IF
               END IF #FUN-BC0088 add
              #FUN-B70087 mod--end
               CALL t800_oeq14a()   #MOD-8C0281
            END IF
            CALL t800_set_no_entry_b(p_cmd)
            LET l_oeq04a_o = g_oeq[l_ac].oeq04a  #MOD-490359

        #---> 輸入數量後,是否大於已交量
        AFTER FIELD oeq30a
            IF NOT t800_chk_oeq30a() THEN
               NEXT FIELD oeq30a
            END IF
        AFTER FIELD oeq12a
           #FUN-910088 ---begin---
              LET l_flag1 = NULL        #TQC-C20183
              CALL t800_oeq12a_check() RETURNING l_flag1,l_fetch_price
              IF NOT l_flag1 THEN
                 NEXT FIELD oeq12a
              END IF
           #FUN-910088--add
           #FUN-CA0009 add START
           #當訂單類型為借貨出貨時,oeq12a數量控管不可小於oeb24
            IF g_oea00 = '8' THEN
               SELECT oeb24 INTO l_oeb24 FROM oeb_file
                 WHERE oeb01 = g_oep.oep01
                   AND oeb03 = g_oeq[l_ac].oeq03
               IF cl_null(l_oeb24) THEN LET l_oeb24 = 0 END IF
               IF g_oeq[l_ac].oeq12a < l_oeb24  THEN
                  CALL cl_err('','axm-691',0)
                  NEXT FIELD oeq12a
               END IF
            END IF
           #FUN-CA0009 add END
#FUN-910088--mark--start--
#           LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
#           IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
#              LET g_oeq[l_ac].oeq27a = NULL
#              DISPLAY BY NAME g_oeq[l_ac].oeq27a
#           END IF
#           CALL t800_oeq14a()
#           IF cl_null(g_oeq[l_ac].oeq12b) AND NOT cl_null(g_oeq[l_ac].oeq12a) OR
#              g_oeq[l_ac].oeq12b<>g_oeq[l_ac].oeq12a THEN
#              LET g_change = 'Y'
#           END IF
#            IF cl_null(g_oeq[l_ac].oeq12a) AND NOT cl_null(g_oeq_t.oeq12a) THEN
#                 LET g_oeq[l_ac].oeq27a = NULL
#                 LET g_oeq[l_ac].oeq14a = NULL
#                 LET g_oeq[l_ac].oeq14ta = NULL   #MOD-A70005
#                 IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
#                    LET g_oeq[l_ac].oeq27a = NULL
#                    LET g_oeq[l_ac].oeq14a = NULL
#                    LET g_oeq[l_ac].oeq14ta = NULL   #MOD-A70005
#                 END IF
#                 DISPLAY BY NAME g_oeq[l_ac].oeq27a
#                 DISPLAY BY NAME g_oeq[l_ac].oeq14a
#                 DISPLAY BY NAME g_oeq[l_ac].oeq14ta   #MOD-A70005
#            END IF
#           IF NOT cl_null(g_oeq[l_ac].oeq12a)  THEN
#              #IF g_oeq[l_ac].oeq12a <=0 THEN    #MOD-A70049
#              IF g_newline = 'Y' AND g_oeq[l_ac].oeq12a <=0 THEN    #MOD-A70049
#                 CALL cl_err(g_oeq[l_ac].oeq12a,'afa-037',0)
#                 NEXT FIELD oeq12a
#              END IF
#              IF g_oeq[l_ac].oeq04b IS NOT NULL THEN
#                 IF g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b THEN
#                    LET  g_oeq[l_ac].oeq12a=null
#                    DISPLAY BY NAME g_oeq[l_ac].oeq12a
#                    CALL cl_err('','axm-327',0)

#                 END IF
#               IF l_oeb19 = 'Y'  THEN
#                  IF g_oeq[l_ac].oeq12a < l_oeb905 THEN
#                     CALL cl_getmsg('axm-921',g_lang) RETURNING g_msg1
#                     LET g_msg1=g_msg1 CLIPPED,
#                                l_oeb905 USING '######&.###'
#                     CALL cl_err(g_msg1,'axm-919',1)
#                     NEXT FIELD oeq12a
#                  END IF
#               END IF
#              IF cl_null(g_oeq[l_ac].oeq27a) THEN
#                 LET g_oeq_t.oeq12a = g_oeq[l_ac].oeq12a    #MOD-7C0017
#                 LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
#                 IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
#                    LET g_oeq[l_ac].oeq27a = NULL
#                    DISPLAY BY NAME g_oeq[l_ac].oeq27a
#                 END IF
#              END IF
#              IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
#                 IF cl_null(g_oeq[l_ac].oeq26a) THEN
#                    LET g_oeq[l_ac].oeq26a=g_oeq[l_ac].oeq05a
#                    IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
#                       LET g_oeq[l_ac].oeq26a = NULL
#                       DISPLAY BY NAME g_oeq[l_ac].oeq26a
#                    END IF
#                 END IF
#              END IF
#            END IF
#            IF g_change = 'Y' THEN
#               CALL t800_set_oeq27()
#            END IF
#              LET l_oeb12 = 0                               #MOD-940401 add
#              LET l_oeb23 = 0                               #MOD-940401 add
#              SELECT oeb24-oeb25,oeb23 INTO l_oeb12,l_oeb23 FROM oeb_file   #No:MOD-640304 modify
#               WHERE oeb01 = g_oep.oep01
#                 AND oeb03 = g_oeq[l_ac].oeq03
#              #-----MOD-B60008---------
#              #IF l_oeb23 > g_oeq[l_ac].oeq12a  THEN
#              #   CALL cl_err('','axm-814',0)
#              #   NEXT FIELD oeq12a
#              #ELSE
#              #   LET l_ogb12 = 0                            #MOD-940401 add
#              #   SELECT SUM(ogb12) INTO l_ogb12 FROM ogb_file,oga_file
#              #    WHERE ogb31 =g_oep.oep01
#              #      AND ogb32 =g_oeq[l_ac].oeq03
#              #      AND oga01 =ogb01
#              #      AND ogaconf ='N'
#              #   IF cl_null(l_ogb12) THEN
#              #     LET l_ogb12 =0
#              #   END IF
#              #   IF l_oeb12+l_ogb12 > g_oeq[l_ac].oeq12a  THEN
#              #      CALL cl_err('','axm-801',0)
#              #      NEXT FIELD oeq12a
#              #   ELSE
#              #      IF NOT cl_null(g_oeq[l_ac].oeq12a) OR
#              #         NOT cl_null(g_oeq[l_ac].oeq13a) THEN
#              #         CALL t800_oeq14a()
#              #      END IF
#              #   END IF
#              #END IF
#              IF l_oeb12 + l_oeb23 > g_oeq[l_ac].oeq12a THEN
#                 CALL cl_err('','axm0007',0)
#                 NEXT FIELD oeq12a
#              ELSE
#                 IF NOT cl_null(g_oeq[l_ac].oeq12a) OR
#                    NOT cl_null(g_oeq[l_ac].oeq13a) THEN
#                    CALL t800_oeq14a()
#                 END IF
#              END IF
#              #-----END MOD-B60008-----
#            END IF
#            IF NOT cl_null(g_oeq[l_ac].oeq12a) AND
#               (g_oeq[l_ac].oeq12a <> l_oeq12a_o OR cl_null(l_oeq12a_o)) THEN
#               IF cl_confirm('apm-543') THEN   #CHI-B80012 add
#                  SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
#                   WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
#                  SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
#                   WHERE oea01=g_oep.oep01
#                  LET l_term=g_oep.oep10b  #FUN-9C0152
#                  IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF #FUN-9C0152
#                 #FUN-AB0082 Begin---
#                 #CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,g_oeq[l_ac].oeq05a,l_oea02,
#                 #                       l_oea00,g_plant,g_oep.oep08b,l_term, #FUN-9C0152 g_oep.oep10b-->l_term
#                 #                       g_oep.oep07b,g_oep.oep01,g_oeq[l_ac].oeq03,
#                  LET g_oeq04f=g_oeq[l_ac].oeq04a
#                  LET g_oeq05f=g_oeq[l_ac].oeq05a
#                  LET g_oep07=g_oep.oep07b
#                  LET g_oep08=g_oep.oep08b
#                  IF cl_null(g_oep07) THEN LET g_oep07 = g_oep.oep07 END IF
#                  IF cl_null(g_oep08) THEN LET g_oep08 = g_oep.oep08 END IF
#                  IF cl_null(g_oeq04f) THEN LET g_oeq04f=g_oeq[l_ac].oeq04b END IF
#                  IF cl_null(g_oeq05f) THEN LET g_oeq05f=g_oeq[l_ac].oeq05b END IF
#                  CALL s_fetch_price_new(l_oea03,g_oeq04f,g_oeq05f,l_oea02,
#                                         '1',g_plant,g_oep08,l_term,
#                                         g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
#                 #FUN-AB0082 End-----
#                                        #g_oeq[l_ac].oeq12a,l_oeb1004,p_cmd) #FUN-B10014
#                                         g_oeq[l_ac].oeq12a,l_oeb1004,'b')   #FUN-B10014
#                          #RETURNING g_oeq[l_ac].oeq13a                    #FUN-AB0082
#                           RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a #FUN-AB0082
#                 #FUN-B70087 mod
#                 #IF g_oeq[l_ac].oeq13a=0 THEN CALL s_unitprice_entry(l_oea03,l_term,g_plant) END IF #FUN-9C0120 #FUN-9C0152   g_oep.oep10b-->l_term
#                  IF g_oeq[l_ac].oeq13a=0 THEN
#                     CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
#                  ELSE
#                     CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
#                  END IF
#                 #FUN-B70087 mod--end
#                  CALL t800_oeq14a()   #MOD-8C0281
#MOD-B80192 -- begin --
#               ELSE
#                  LET l_fetch_price = 'N'
#MOD-B80192 -- end --
#               END IF   #CHI-B80012 add
#            END IF
#            LET l_oeq12a_o = g_oeq[l_ac].oeq12a
#FUN-910088--mark--end--


        BEFORE FIELD oeq13a
           IF (NOT cl_null(g_oeq[l_ac].oeq04a) AND
              (g_oeq[l_ac].oeq04a <> g_oeq_t.oeq04a OR cl_null(g_oeq_t.oeq04a)))
              OR
              (NOT cl_null(g_oeq[l_ac].oeq12a) AND
              (g_oeq[l_ac].oeq12a <> g_oeq_t.oeq12a OR cl_null(g_oeq_t.oeq12a)))
              THEN
#             IF cl_null(g_oeq[l_ac].oeq13a) OR g_oeq[l_ac].oeq13a = 0 THEN                             #MOD-B80192 mark
              IF l_fetch_price = 'Y' AND (cl_null(g_oeq[l_ac].oeq13a) OR g_oeq[l_ac].oeq13a = 0) THEN   #MOD-B80192
                 SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
                  WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
                 SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
                  WHERE oea01=g_oep.oep01
                 LET l_term=g_oep.oep10b  #FUN-9C0152
                 IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF #FUN-9C0152
                 #FUN-C40089---begin
                #SELECT oah08 INTO g_oah08 FROM oah_file WHERE oah01=l_term #MOD-D30073 mark
                 SELECT oah04,oah08 INTO g_oah04,g_oah08 FROM oah_file WHERE oah01=l_term #MOD-D30073 add
                 IF cl_null(g_oah08) THEN
                    LET g_oah08 = 'Y'
                 END IF
                 IF NOT cl_null(g_oeq[l_ac].oeq13a) THEN
                    IF g_oah08 = 'N' AND g_oeq[l_ac].oeq13a = 0 THEN
                       IF g_oah04 = 'Y' THEN #MOD-D30073 add
                          CALL cl_err(g_oeq[l_ac].oeq13a,'axm-627',0)  #FUN-C50074
                          NEXT FIELD oeq13a
                      #MOD-D30073 add start -----
                       ELSE
                          CALL cl_err(g_oeq[l_ac].oeq13a,'axm1181',0)
                          NEXT FIELD oeq03
                       END IF
                      #MOD-D30073 add end   -----
                    END IF
                 END IF
                 #FUN-C40089---end
               #FUN-AB0082 Begin---
               #CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,g_oeq[l_ac].oeq05a,l_oea02,
               #                       l_oea00,g_plant,g_oep.oep08b,l_term, #FUN-9C0152 g_oep.oep10b-->l_term
               #                       g_oep.oep07b,g_oep.oep01,g_oeq[l_ac].oeq03,
                LET g_oeq04f=g_oeq[l_ac].oeq04a
                LET g_oeq05f=g_oeq[l_ac].oeq05a
                LET g_oep07=g_oep.oep07b
                LET g_oep08=g_oep.oep08b
                IF cl_null(g_oep07) THEN LET g_oep07 = g_oep.oep07 END IF
                IF cl_null(g_oep08) THEN LET g_oep08 = g_oep.oep08 END IF
                IF cl_null(g_oeq04f) THEN LET g_oeq04f=g_oeq[l_ac].oeq04b END IF
                IF cl_null(g_oeq05f) THEN LET g_oeq05f=g_oeq[l_ac].oeq05b END IF
                CALL s_fetch_price_new(l_oea03,g_oeq04f,'',g_oeq05f,l_oea02,                   #FUN-BC0071
                                       '1',g_plant,g_oep08,l_term, #FUN-9C0152 g_oep.oep10b-->l_term
                                       g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
               #FUN-AB0082 End-----
                                      #g_oeq[l_ac].oeq12a,l_oeb1004,p_cmd) #FUN-B10014
                                       g_oeq[l_ac].oeq12a,l_oeb1004,'b')   #FUN-B10014
                        #RETURNING g_oeq[l_ac].oeq13a                    #FUN-AB0082
                         RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a #FUN-AB0082
                #FUN-B70087 mod
                #IF g_oeq[l_ac].oeq13a=0 THEN CALL s_unitprice_entry(l_oea03,l_term,g_plant) END IF #FUN-9C0120 #FUN-9C0152   g_oep.oep10b-->l_term
                #FUN-BC0088 ------- add start --------------
                #add by songlb 20160405 数量减少后，对应的单价会变更（自动从上一行带下来）
                IF NOT cl_null(g_oeq[l_ac].oeq13b) AND g_oeq[l_ac].oeq13b>0 THEN
                    LET g_oeq[l_ac].oeq13a = g_oeq[l_ac].oeq13b
                END IF
                IF g_oeq[l_ac].oeq04a[1,4] = 'MISC' THEN
                   CALL s_unitprice_entry(l_oea03,l_term,g_plant,'M')
                ELSE
                #FUN-BC0088 ------- add end --------------
                   IF g_oeq[l_ac].oeq13a=0 THEN
                      CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
                   ELSE
                      CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
                   END IF
                END IF #FUN-BC0088 add
                #FUN-B70087 mod--end
                 CALL t800_oeq14a()   #MOD-8C0281
              END If
           END IF

        #---->輸入單價後,DISPLAY 金額
        AFTER FIELD oeq13a
          #MOD-D10096 add start -----
           IF cl_null(g_oeq[l_ac].oeq03) THEN
              CALL cl_err("","axm1174",0)
              NEXT FIELD oeq03
           END IF
          #MOD-D10096 add end   -----
          #MOD-D10096 mark start ------
          ##CHI-C40019 add begin---
          #IF NOT cl_null(g_oep.oep01) THEN
          #   CALL t800_get_ogbcnt()
          #END IF
          #IF NOT cl_null(g_oeq[l_ac].oeq13a) AND g_ogb_cnt > 0 THEN
          #   CALL cl_err('','axm2001',0)
          #   LET g_oeq[l_ac].oeq13a = NULL
          #   LET g_oeq[l_ac].oeq14a = NULL
          #   LET g_oeq[l_ac].oeq14ta = NULL
          #   NEXT FIELD CURRENT
          #END IF
          ##CHI-C40019 add end-----
          #MOD-D10096 mark end   -----

             LET l_qty=g_oeq[l_ac].oeq27b
             LET l_up=g_oeq[l_ac].oeq13b

            CALL t800_chk_oeq13a(p_cmd)  #FUN-9C0083
            IF NOT cl_null(g_errno) THEN NEXT FIELD oeq13a END IF   #MOD-880047
            CALL t800_oeq14a()         #MOD-690091 add
           #FUN-AB0082 Begin---
            IF cl_null(g_oeq[l_ac].oeq37a) OR g_oeq[l_ac].oeq37a=0 THEN
               LET g_oeq[l_ac].oeq37a=g_oeq[l_ac].oeq13a
            END IF
           #FUN-AB0082 End-----

        BEFORE FIELD oeq14a
             LET l_oeq14a_o = g_oeq[l_ac].oeq14a

        AFTER FIELD oeq14a
          #有變更數量或金額再做check
           IF NOT cl_null(g_oeq[l_ac].oeq12a) OR NOT cl_null(g_oeq[l_ac].oeq13a) THEN
             IF cl_null(g_oeq[l_ac].oeq14a) OR g_oeq[l_ac].oeq14a< 0 THEN   #No:MOD-860060
                CALL cl_err('','axm-710',1)
                NEXT FIELD oeq14a
             END IF
           END IF
           #-----MOD-A70049---------
           IF g_oeq[l_ac].oeq12a = 0 AND g_oeq[l_ac].oeq14a <> 0 THEN
              CALL cl_err('','axm-710',1)
              NEXT FIELD oeq14a
           END IF
           #-----MOD-A70077---------
           IF cl_null(g_oep.oep08b) THEN
              SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=g_oep.oep08
           ELSE
              SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=g_oep.oep08b
           END IF
           LET g_oeq[l_ac].oeq14a = cl_digcut(g_oeq[l_ac].oeq14a,t_azi04)
           #-----END MOD-A70077-----

        AFTER FIELD oeq14ta
          #有變更數量或金額再做check
           IF NOT cl_null(g_oeq[l_ac].oeq12a) OR NOT cl_null(g_oeq[l_ac].oeq13a) THEN
             IF cl_null(g_oeq[l_ac].oeq14ta) OR g_oeq[l_ac].oeq14ta< 0 THEN
                CALL cl_err('','axm-710',1)
                NEXT FIELD oeq14ta
             END IF
           END IF
           IF g_oeq[l_ac].oeq12a = 0 AND g_oeq[l_ac].oeq14ta <> 0 THEN
              CALL cl_err('','axm-710',1)
              NEXT FIELD oeq14ta
           END IF
           #-----END MOD-A70049-----
           #-----MOD-A70077---------
           IF cl_null(g_oep.oep08b) THEN
              SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=g_oep.oep08
           ELSE
              SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=g_oep.oep08b
           END IF
           LET g_oeq[l_ac].oeq14ta = cl_digcut(g_oeq[l_ac].oeq14ta,t_azi04)
           #-----END MOD-A70077-----
       #TQC-C70161 -- add -- begin
        AFTER FIELD oeq15a
           IF NOT cl_null(g_oeq[l_ac].oeq15a) THEN #MOD-C70245 add
              SELECT oea02 INTO l_oea02_1 FROM oea_file
               WHERE oea01 = g_oep.oep01
              IF NOT cl_null(g_oeq[l_ac].oeq15a) AND g_oeq[l_ac].oeq15a < l_oea02_1 THEN
                 CALL cl_err('','axm-330',0)
                 NEXT FIELD oeq15a
              END IF
           END IF #MOD-C70245 add

       #TQC-C70161 -- add -- end

       #TQC-C70209 -- add -- begin
        AFTER FIELD oeq28a
           IF NOT cl_null(g_oeq[l_ac].oeq28a) THEN
              SELECT oea02 INTO l_oea02_1 FROM oea_file WHERE oea01 = g_oep.oep01
              IF g_oeq[l_ac].oeq28a < l_oea02_1 THEN
                 CALL cl_err(g_oeq[l_ac].oeq28a,'axm1058',0)
                 NEXT FIELD oeq28a
              END IF
              IF g_oeq[l_ac].oeq28a < g_oeq[l_ac].oeq15b AND cl_null(g_oeq[l_ac].oeq15a) THEN
                 CALL cl_err(g_oeq[l_ac].oeq28a,'axm1057',0)
                 NEXT FIELD oeq28a
              END IF
              IF g_oeq[l_ac].oeq28a < g_oeq[l_ac].oeq15a AND
                 NOT cl_null(g_oeq[l_ac].oeq15a) THEN
                 CALL cl_err(g_oeq[l_ac].oeq28a,'axm1056',0)
                 NEXT FIELD oeq28a
              END IF
           END IF
       #TQC-C70209 -- add -- end

        #--->單位需存在於單位檔中
        AFTER FIELD oeq05a #訂單單位,須存在
            LET l_flag1 = NULL       #FUN-C20068--add--
            IF NOT cl_null(g_oeq[l_ac].oeq05a)  THEN
               IF g_oeq[l_ac].oeq05a = g_oeq[l_ac].oeq05b THEN
                  LET  g_oeq[l_ac].oeq05a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq05a
                  CALL cl_err('','axm-327',0)
               ELSE
                  LET g_change = 'Y'
               END IF

               IF g_oeq[l_ac].oeq05a!=g_oeq[l_ac].oeq05b OR   #MOD-8B0291
                  cl_null(g_oeq[l_ac].oeq05b) THEN   #MOD-8B0291
                  CALL t800_unit(g_oeq[l_ac].oeq05a)   #是否存在於單位檔中
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_oeq[l_ac].oeq05a,g_errno,0)
                     LET g_oeq[l_ac].oeq05a = g_oeq_t.oeq05a
                     DISPLAY BY NAME g_oeq[l_ac].oeq05a
                     NEXT FIELD oeq05a
                  END IF
               END IF
               IF cl_null(g_oeq[l_ac].oeq26a) THEN
                  IF g_sma.sma116 MATCHES '[23]' THEN
                     IF cl_null(g_ima908) THEN
                        SELECT ima908 INTO g_ima908 FROM ima_file
                         WHERE ima01 = g_oeq[l_ac].oeq04a
                        LET g_oeq[l_ac].oeq26a = g_ima908
                     END IF
                  END IF
                  IF cl_null(g_oeq[l_ac].oeq26a) THEN
                     LET g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq05a
                  END IF
                  IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
                     LET g_oeq[l_ac].oeq26a = NULL
                     DISPLAY BY NAME g_oeq[l_ac].oeq26a
                  END IF
               END IF
               IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
                  IF cl_null(g_oeq[l_ac].oeq27a) THEN
                     LET g_oeq[l_ac].oeq27a=g_oeq[l_ac].oeq12a
                     LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)  #FUN-910088-add
                  END IF
                  IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
                     LET g_oeq[l_ac].oeq27a = NULL
                     DISPLAY BY NAME g_oeq[l_ac].oeq27a
                  END IF
               END IF

               IF g_change = 'Y' THEN
                  CALL t800_set_oeq27()
                  #add--str--TQC-CB0032
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err('',g_errno,0)
                     NEXT FIELD oeq05a
                  END IF
                 #add--end--TQC-CB0032
               END IF
             END IF
           #FUN-910088--add--start--
             IF NOT cl_null(g_oeq[l_ac].oeq12a)  AND g_oeq[l_ac].oeq12a <> 0 THEN
                CALL t800_oeq12a_check() RETURNING l_flag1,l_fetch_price
                IF NOT l_flag1 THEN
                   LET g_oeq05a_t = g_oeq[l_ac].oeq05a
                   NEXT FIELD oeq12a
                END IF
                LET g_oeq05a_t = g_oeq[l_ac].oeq05a
             END IF
           #FUN-910088--add--end--

        AFTER FIELD oeq23a #單位二
            IF cl_null(g_oeq[l_ac].oeq23b) AND NOT cl_null(g_oeq[l_ac].oeq23a) OR
               g_oeq[l_ac].oeq23b<>g_oeq[l_ac].oeq23a THEN
               LET g_change = 'Y'
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq23a)  THEN
               IF g_oeq[l_ac].oeq23a = g_oeq[l_ac].oeq23b THEN
                  LET  g_oeq[l_ac].oeq23a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq23a
                  IF g_oeq[l_ac].oeq24a = g_oeq[l_ac].oeq24b THEN
                     LET  g_oeq[l_ac].oeq24a=null
                     DISPLAY BY NAME g_oeq[l_ac].oeq24a
                  END IF
                  CALL cl_err('','axm-327',0)
               END IF
              #MOD-D10109 add start    -----
               CALL t800_set_origin_field()
               IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF
              #MOD-D10109 add end    -----
               IF g_oeq[l_ac].oeq23a!=g_oeq[l_ac].oeq23b OR
                  cl_null(g_oeq[l_ac].oeq23b) THEN
                  CALL t800_unit(g_oeq[l_ac].oeq23a)   #是否存在於單位檔中
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_oeq[l_ac].oeq23a,g_errno,0)
                     LET g_oeq[l_ac].oeq23a = g_oeq_t.oeq23a
                     DISPLAY BY NAME g_oeq[l_ac].oeq23a
                     NEXT FIELD oeq23a
                  END IF
               END IF
               IF NOT cl_null(g_oeq[l_ac].oeq23a) THEN  #MOD-590175   #MOD-930236
                   CALL s_du_umfchk(g_oeq04,'','','',
                                    g_ima31,g_oeq[l_ac].oeq23a,g_ima906)
                        RETURNING g_errno,g_factor
                   IF NOT cl_null(g_errno) THEN
                      LET g_oeq[l_ac].oeq23a=g_oeq_t.oeq23a
                      CALL cl_err(g_oeq[l_ac].oeq23a,g_errno,0)
                      NEXT FIELD oeq23a
                   END IF
                   LET g_oeq[l_ac].oeq24a=g_factor
               END IF  ##MOD-590175
            END IF
        #TQC-C20183--add-start--
            CALL t800_oeq25a_check(p_cmd)
            LET g_oeq23a_t = g_oeq[l_ac].oeq23a
        #TQC-C20183--add-end--

        AFTER FIELD oeq24a #單位二轉換率
            IF cl_null(g_oeq[l_ac].oeq24b) AND NOT cl_null(g_oeq[l_ac].oeq24a) OR
               g_oeq[l_ac].oeq24b<>g_oeq[l_ac].oeq24a THEN
               LET g_change = 'Y'
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq24a)  THEN
               IF g_oeq[l_ac].oeq24a = g_oeq[l_ac].oeq24b THEN
                  LET  g_oeq[l_ac].oeq24a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq24a
                  CALL cl_err('','axm-327',0)
               END IF
            END IF
        AFTER FIELD oeq25a #單位二數量
            CALL t800_oeq25a_check(p_cmd)   #FUN-910088-add--
       #FUN-910088--mark--start--
       #    IF cl_null(g_oeq[l_ac].oeq25b) AND NOT cl_null(g_oeq[l_ac].oeq25a) OR
       #       g_oeq[l_ac].oeq25b<>g_oeq[l_ac].oeq25a THEN
       #       LET g_change = 'Y'
       #    END IF
       #    IF NOT cl_null(g_oeq[l_ac].oeq25a)  THEN
       #       IF g_oeq[l_ac].oeq25a = g_oeq[l_ac].oeq25b THEN
       #          LET  g_oeq[l_ac].oeq25a=null
       #          DISPLAY BY NAME g_oeq[l_ac].oeq25a
       #          CALL cl_err('','axm-327',0)
       #       END IF
       #      #MOD-D10109 add start    -----
       #       CALL t800_set_origin_field()
       #       IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF
       #      #MOD-D10109 add end    -----
       #       IF p_cmd = 'a' THEN
       #          IF g_ima906='3' OR g_ima906 = '2' THEN   #TQC-980145 add '2'
       #             LET g_oeq25=g_oeq[l_ac].oeq25b
       #             LET g_oeq24=g_oeq[l_ac].oeq24b
       #             LET g_oeq21=g_oeq[l_ac].oeq21b
       #             IF NOT cl_null(g_oeq[l_ac].oeq25a) THEN
       #                LET g_oeq25=g_oeq[l_ac].oeq25a
       #             END IF
       #             IF NOT cl_null(g_oeq[l_ac].oeq24a) THEN
       #                LET g_oeq24=g_oeq[l_ac].oeq24a
       #             END IF
       #             IF NOT cl_null(g_oeq[l_ac].oeq21a) THEN
       #                LET g_oeq21=g_oeq[l_ac].oeq21a
       #             END IF
       #             LET g_tot1=g_oeq25 * g_oeq24
       #             IF cl_null(g_oeq[l_ac].oeq22a) OR g_oeq[l_ac].oeq22a=0 THEN #CHI-960022
       #                IF g_ima906 = '3' THEN   #No:MOD-640429 add   #MOD-A10002
       #                   LET g_oeq[l_ac].oeq22a=g_tot1*g_oeq21
       #                END IF                   ##No:MOD-640429 add
       #             END IF                                                      #CHI-960022
       #          END IF
       #       END IF
       #    END IF
       #    IF g_change = 'Y' THEN
       #       IF g_ima906 = '3' THEN   #No:MOD-640429 add   #MOD-A10002
       #          CALL t800_set_oeq27()
       #       END IF                   ##No:MOD-640429 add
       #    END IF
       #FUN-910088--mark--end--

        AFTER FIELD oeq20a #單位一
            IF cl_null(g_oeq[l_ac].oeq20b) AND NOT cl_null(g_oeq[l_ac].oeq20a) OR
               g_oeq[l_ac].oeq20b<>g_oeq[l_ac].oeq20a THEN
               LET g_change = 'Y'
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq20a)  THEN
               IF g_oeq[l_ac].oeq20a = g_oeq[l_ac].oeq20b THEN
                  LET  g_oeq[l_ac].oeq20a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq20a
                  IF g_oeq[l_ac].oeq21a = g_oeq[l_ac].oeq21b THEN
                     LET  g_oeq[l_ac].oeq21a=null
                     DISPLAY BY NAME g_oeq[l_ac].oeq21a
                  END IF
                  CALL cl_err('','axm-327',0)
               END IF
               IF g_oeq[l_ac].oeq20a!=g_oeq[l_ac].oeq20b OR
                  cl_null(g_oeq[l_ac].oeq20b) THEN
                  CALL t800_unit(g_oeq[l_ac].oeq20a)   #是否存在於單位檔中
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_oeq[l_ac].oeq20a,g_errno,0)
                     LET g_oeq[l_ac].oeq20a = g_oeq_t.oeq20a
                     DISPLAY BY NAME g_oeq[l_ac].oeq20a
                     NEXT FIELD oeq20a
                  END IF
                  IF g_sma.sma115 = 'Y' THEN
                     IF g_sma.sma116 MATCHES '[01]' THEN
                        LET g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq20a
                     END IF
                  END IF
               END IF
                  IF NOT cl_null(g_oeq[l_ac].oeq20a) THEN  #MOD-590175
                      CALL t800_set_origin_field()   #MOD-A90054
                      IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF #MOD-D10109 add
                      CALL s_du_umfchk(g_oeq04,'','','',
                                       g_oeq[l_ac].oeq05a,g_oeq[l_ac].oeq20a,'1')
                           RETURNING g_errno,g_factor
                      IF NOT cl_null(g_errno) THEN
                         LET g_oeq[l_ac].oeq20a=g_oeq_t.oeq20a
                         CALL cl_err(g_oeq[l_ac].oeq20a,g_errno,0)
                         NEXT FIELD oeq20a
                      END IF
                      LET g_oeq[l_ac].oeq21a=g_factor
                   END IF  ##MOD-590175
               END IF
            #FUN-910088--add--start
               IF NOT cl_null(g_oeq[l_ac].oeq22a) AND g_oeq[l_ac].oeq22a <> 0 THEN
                  CASE t800_oeq22a_check()
                     WHEN "oeq25a"
                        NEXT FIELD oeq25a
                     WHEN "oeq22a"
                        NEXT FIELD oeq22a
                     OTHERWISE EXIT CASE
                  END CASE
                  LET g_oeq20a_t = g_oeq[l_ac].oeq20a
               END IF
            #FUN-910088--add--end--

        AFTER FIELD oeq21a #單位一轉換率
            IF cl_null(g_oeq[l_ac].oeq21b) AND NOT cl_null(g_oeq[l_ac].oeq21a) OR
               g_oeq[l_ac].oeq21b<>g_oeq[l_ac].oeq21a THEN
               LET g_change = 'Y'
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq21a)  THEN
               IF g_oeq[l_ac].oeq21a = g_oeq[l_ac].oeq21b THEN
                  LET  g_oeq[l_ac].oeq21a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq21a
                  CALL cl_err('','axm-327',0)
               END IF
            END IF

        AFTER FIELD oeq22a #單位一數量
        #FUN-910088--add--start--
           CASE t800_oeq22a_check()
              WHEN "oeq25a"
                 NEXT FIELD oeq25a
              WHEN "oeq22a"
                 NEXT FIELD oeq22a
              OTHERWISE EXIT CASE
           END CASE
        #FUN910088--mark--start--
        #   IF cl_null(g_oeq[l_ac].oeq22b) AND NOT cl_null(g_oeq[l_ac].oeq22a) OR
        #      g_oeq[l_ac].oeq22b<>g_oeq[l_ac].oeq22a THEN
        #      LET g_change = 'Y'
        #   END IF
        #   IF NOT cl_null(g_oeq[l_ac].oeq22a)  THEN
        #      IF g_oeq[l_ac].oeq22a = g_oeq[l_ac].oeq22b THEN
        #         LET  g_oeq[l_ac].oeq22a=null
        #         DISPLAY BY NAME g_oeq[l_ac].oeq22a
        #         CALL cl_err('','axm-327',0)
        #      END IF
        #   END IF
        #   CALL t800_set_origin_field()
        #   IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF #MOD-D10109 add
        #   #-----MOD-A70098---------
        #   IF g_change = 'Y' THEN
        #      CALL t800_set_oeq27()
        #   END IF
        #   #-----END MOD-A70098-----
        #   IF t800_qty_check() THEN
        #      IF g_ima906 MATCHES '[23]' THEN
        #         NEXT FIELD oeq25a
        #      ELSE
        #         NEXT FIELD oeq22a
        #      END IF
        #   END IF
        #FUN910088--mark--end--
            #-----MOD-A70098---------
            #往上移
            #IF g_change = 'Y' THEN
            #   CALL t800_set_oeq27()
            #END IF
            #-----END MOD-A70098-----

        AFTER FIELD oeq26a #計價單位
            IF cl_null(g_oeq[l_ac].oeq26b) AND NOT cl_null(g_oeq[l_ac].oeq26a) OR
               g_oeq[l_ac].oeq26b<>g_oeq[l_ac].oeq26a THEN
               LET g_change = 'Y'
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq26a)  THEN
               IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
                  LET  g_oeq[l_ac].oeq26a=null
                  DISPLAY BY NAME g_oeq[l_ac].oeq26a
                  CALL cl_err('','axm-327',0)
               END IF
               IF g_oeq[l_ac].oeq26a!=g_oeq[l_ac].oeq26b OR
                  cl_null(g_oeq[l_ac].oeq26b) THEN
                  CALL t800_unit(g_oeq[l_ac].oeq26a)   #是否存在於單位檔中
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_oeq[l_ac].oeq26a,g_errno,0)
                     LET g_oeq[l_ac].oeq26a = g_oeq_t.oeq26a
                     DISPLAY BY NAME g_oeq[l_ac].oeq26a
                     NEXT FIELD oeq26a
                END IF
             END IF
             IF NOT cl_null(g_oeq[l_ac].oeq26a) THEN  #MOD-590175
                 CALL s_du_umfchk(g_oeq04,'','','',
                                  #g_ima25,g_oeq[l_ac].oeq26a,'1')   #MOD-A90054
                                  g_ima31,g_oeq[l_ac].oeq26a,'1')   #MOD-A90054
                      RETURNING g_errno,g_factor
                 IF NOT cl_null(g_errno) THEN
                    LET g_oeq[l_ac].oeq26a=g_oeq_t.oeq26a
                    CALL cl_err(g_oeq[l_ac].oeq26a,g_errno,0)
                    NEXT FIELD oeq26a
                 END IF
             END IF  #MOD-590175
           END IF
        IF g_change = 'Y' THEN
           CALL t800_set_oeq27()
           #add--str--TQC-CB0032
           IF NOT cl_null(g_errno) THEN
              CALL cl_err('',g_errno,0)
              NEXT FIELD oeq26a
           END IF
          #add--end--TQC-CB0032
        END IF
      #TQC-C20183--add--start--
        CALL t800_oeq27a_check()
        LET g_oeq26a_t = g_oeq[l_ac].oeq26a
       #TQC-C20183--add--edd--

        AFTER FIELD oeq27a #計價數量
            CALL t800_oeq27a_check()    #FUN-910088--add
         #FUN-910088--mark--start--
         #  IF NOT cl_null(g_oeq[l_ac].oeq27a)  THEN
         #     IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
         #        LET  g_oeq[l_ac].oeq27a=null
         #        DISPLAY BY NAME g_oeq[l_ac].oeq27a
         #        CALL cl_err('','axm-327',0)
         #     END IF
         #  END IF
         #FUN-910088--mark--edd--


        #FUN-A80118--Add--Begin
        AFTER FIELD oeq31a
           IF NOT cl_null(g_oeq[l_ac].oeq31a) THEN
              LET l_n=0
              SELECT count(*) INTO l_n FROM pja_file
               WHERE pjaacti='Y'
                 AND pjaclose='N'
                 AND pja01 = g_oeq[l_ac].oeq31a
              IF l_n=0 THEN
                 CALL cl_err('','abg-500',0)
                 NEXT FIELD oeq31a
              END IF
           END IF

        AFTER FIELD oeq32a
           IF NOT cl_null(g_oeq[l_ac].oeq32a) THEN
              LET l_n=0
              SELECT count(*) INTO l_n FROM pjb_file
               WHERE pjb01 = g_oeq[l_ac].oeq31a
                 AND pjb02 = g_oeq[l_ac].oeq32a
              IF l_n=0 THEN
                 CALL cl_err('','apj-051',0)
                 NEXT FIELD oeq32a
              ELSE
              	 LET l_pjb09 = ' '
              	 LET l_pjb11 = ' '
                 SELECT pjb09,pjb11 INTO l_pjb09,l_pjb11
                   FROM pjb_file
                  WHERE pjb01 = g_oeq[l_ac].oeq31a
                    AND pjb02 = g_oeq[l_ac].oeq32a
                    AND pjbacti = 'Y'
                 IF l_pjb09 <>'Y' OR l_pjb11<>'Y' THEN
                    CALL cl_err('','apj-090',0)
                    NEXT FIELD oeq32a
                 END IF
              END IF
           END IF

        BEFORE FIELD oeq33a
           LET l_pjb25 = ' '
           SELECT pjb25 INTO l_pjb25
             FROM pjb_file
            WHERE pjb01 = g_oeq[l_ac].oeq31a
              AND pjb02 = g_oeq[l_ac].oeq32a
              AND pjbacti = 'Y'
           IF l_pjb25 = 'Y' THEN
              CALL cl_set_comp_entry("oeq33a",TRUE)
           ELSE
           	  LET g_oeq[l_ac].oeq33a = ' '
           	  CALL cl_set_comp_entry("oeq33a",FALSE)
           END IF

        AFTER FIELD oeq33a
           IF NOT cl_null(g_oeq[l_ac].oeq33a) THEN
              LET l_n=0
              SELECT count(*) INTO l_n FROM pja_file
               WHERE pjk11=g_oeq[l_ac].oeq32a
                 AND pjkacti='Y'
                 AND pjk01=g_oeq[l_ac].oeq33a
              IF l_n=0 THEN
                 CALL cl_err('','apj-049',0)
                 NEXT FIELD oeq33a
              END IF
           END IF
        AFTER FIELD ta_oeq09a
           IF g_oeq[l_ac].ta_oeq09a IS NOT NULL THEN
              SELECT COUNT(*) INTO l_n FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[l_ac].ta_oeq09a
              IF l_n <= 0 THEN
                 CALL cl_err('','aic-004',1)
                 NEXT FIELD ta_oeq09a
              ELSE
                 IF g_oep.oep01[1,1] !='X' THEN
                    SELECT tc_oaf03 INTO g_oeq[l_ac].ta_oeq10a FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[l_ac].ta_oeq09a AND tc_oaf01='1'
                 ELSE
                    SELECT tc_oaf03 INTO g_oeq[l_ac].ta_oeq10a FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[l_ac].ta_oeq09a AND tc_oaf01='9'
                 END IF
              END IF
           ELSE
              LET g_oeq[l_ac].ta_oeq10a = NULL
           END IF
           DISPLAY BY NAME g_oeq[l_ac].ta_oeq10a
        AFTER FIELD ta_oeq11a
           #IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
           IF NOT cl_null(g_oeq[l_ac].ta_oeq11a) THEN
              IF g_oep.oep01[1,1] !='X' THEN
                 SELECT COUNT(*) INTO l_n FROM obe_file WHERE obe01 = g_oeq[l_ac].ta_oeq11a
              ELSE
                 SELECT COUNT(*) INTO l_n FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[l_ac].ta_oeq11a
              END IF
              IF l_n <= 0 THEN
                 CALL cl_err('','axm-810',1)
                 NEXT FIELD ta_oeq11a
              END IF
              IF g_oep.oep01[1,1] !='X' THEN
                 SELECT obe02 INTO g_oeq[l_ac].tc_oaf03a FROM obe_file WHERE obe01 = g_oeq[l_ac].ta_oeq11a
              ELSE
                 SELECT tc_oaf03 INTO g_oeq[l_ac].tc_oaf03a FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[l_ac].ta_oeq11a AND tc_oaf01='10'
              END IF
              DISPLAY BY NAME  g_oeq[l_ac].tc_oaf03a
           END IF
        #FUN-A80118--Add--End
        #MOD-D30115 add begin-------
        AFTER INPUT
           IF INT_FLAG THEN
              EXIT INPUT
           END IF
           CALL t800_y_chk()
        #MOD-D30115 add end-------
        BEFORE DELETE                            #是否取消單身
            IF g_oeq_t.oeq03 > 0 AND
               g_oeq_t.oeq03 IS NOT NULL THEN
               IF NOT cl_delb(0,0) THEN
                  CANCEL DELETE
               END IF

               IF l_lock_sw = "Y" THEN
                  CALL cl_err("", -263, 1)
                  CANCEL DELETE
               END IF

               DELETE FROM oeq_file
                WHERE oeq01 = g_oep.oep01 AND oeq02 = g_oep.oep02
                  AND oeq03 = g_oeq_t.oeq03
               IF SQLCA.sqlcode THEN
                  CALL cl_err(g_oeq_t.oeq03,SQLCA.sqlcode,0)
                  ROLLBACK WORK
                  CANCEL DELETE
               END IF
           # #FUN-CC0007---add---START
           #    DELETE FROM oeqa_file
           #     WHERE oeqa01  = g_oep.oep01
           #       AND oeqa011 = g_oep.oep02
           #       AND oeqa02  = g_oeq[l_ac].oeq03
           #    IF SQLCA.sqlcode THEN
           #       CALL cl_err3("del","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
           #    END IF
           # #FUN-CC0007---add-----END

               IF g_oaz.oaz06 = 'Y' THEN
                  CALL s_mpslog('R','','','',g_oeq_t.oeq04a,g_oeq_t.oeq12a,
                                g_oeq_t.oeq15a,g_oep.oep01,g_oeq_t.oeq03,'')
                  IF g_success = 'N' THEN CANCEL DELETE END IF   #CHI-B80016
               END IF

               LET g_rec_b=g_rec_b-1
               DISPLAY g_rec_b TO FORMONLY.cn2
               LET l_oep09 = '0'          #FUN-550031
               COMMIT WORK
            END IF

        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_oeq[l_ac].* = g_oeq_t.*
               LET l_oeq04a_o = g_oeq_t.oeq04a #MOD-490359
               LET l_oeq12a_o = g_oeq_t.oeq12a #MOD-890224
               CLOSE t800_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            #若為三角貿易, 新增時交貨日不可空白
            SELECT oea901 INTO l_oea901 FROM oea_file
             WHERE oea01 = g_oep.oep01
            IF NOT cl_null(l_oea901) AND l_oea901 = 'Y' THEN
                IF cl_null(g_oeq[l_ac].oeq04b) AND
                   cl_null(g_oeq[l_ac].oeq15a)  THEN
                   CALL cl_err('','mfg3226',1)
                   NEXT FIELD oeq15a
                END IF
            END IF

            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_oeq[l_ac].oeq03,-263,1)
               LET g_oeq[l_ac].* = g_oeq_t.*
               LET l_oeq04a_o = g_oeq_t.oeq04a #MOD-490359
               LET l_oeq12a_o = g_oeq_t.oeq12a #MOD-890224
            ELSE
               IF g_sma.sma115 = 'Y' THEN
                  IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
                     CALL s_chk_va_setting(g_oeq[l_ac].oeq04a)
                          RETURNING g_sw,g_ima906,g_ima907
                     IF g_sw=1 THEN
                        NEXT FIELD oeq04a
                     END IF

                     CALL s_chk_va_setting1(g_oeq[l_ac].oeq04a)
                          RETURNING g_sw,g_ima908
                     IF g_sw=1 THEN
                        NEXT FIELD oeq04a
                     END IF
                  END IF

                  CALL t800_set_origin_field()
                  IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF #MOD-D10109 add
               END IF
#MOD-B80196 -- begin --
#              IF cl_null(g_oeq[l_ac].oeq26a) AND g_sma.sma115 = 'N' THEN
#                 IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
#                    LET g_oeq[l_ac].oeq26a=g_oeq[l_ac].oeq05a
#                 END IF
#                 IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
#                    LET g_oeq[l_ac].oeq26a = NULL
#                    DISPLAY BY NAME g_oeq[l_ac].oeq26a
#                 END IF
#              END IF
#              IF cl_null(g_oeq[l_ac].oeq27a) AND g_sma.sma115 = 'N' THEN
#                 IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
#                    LET g_oeq[l_ac].oeq27a=g_oeq[l_ac].oeq12a
#                 END IF
#                 IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
#                    LET g_oeq[l_ac].oeq27a = NULL
#                    DISPLAY BY NAME g_oeq[l_ac].oeq27a
#                 END IF
#              END IF
#MOD-B80196 -- end --
               #CALL t800_oeq14ta()      #No.3317 010821 add   #MOD-A70005
               CALL t800_b_move_back()  #No:FUN-7C0017
               UPDATE oeq_file SET * = b_oeq.*
                WHERE oeq01 = g_oep.oep01
                  AND oeq02 = g_oep.oep02
                  AND oeq03 = g_oeq_t.oeq03
               IF SQLCA.sqlcode THEN
                   CALL cl_err(g_oeq[l_ac].oeq03,SQLCA.sqlcode,0)
                   LET g_oeq[l_ac].* = g_oeq_t.*
               ELSE
                   MESSAGE 'UPDATE O.K'
                  LET l_oep09 = '0'          #FUN-550031
                   IF g_oaz.oaz06 = 'Y' THEN
                      CALL s_mpslog('R','','','',
                                    g_oeq_t.oeq04a,g_oeq_t.oeq12a,
                                    g_oeq_t.oeq15a,
                                    g_oep.oep01,g_oeq_t.oeq03,'')
#CHI-B80016 -- begin --
                      IF g_success = 'N' THEN
                         ROLLBACK WORK
                         EXIT INPUT
                      END IF
#CHI-B80016 -- end --
                      IF cl_null(g_oeq[l_ac].oeq04b) THEN
                         CALL s_mpslog('A',g_oeq[l_ac].oeq04a,
                                        g_oeq[l_ac].oeq12a,
                                        g_oeq[l_ac].oeq15a,'','','',
                                        g_oep.oep01,'',g_oeq[l_ac].oeq03)
#CHI-B80016 -- begin --
                         IF g_success = 'N' THEN
                            ROLLBACK WORK
                            EXIT INPUT
                         END IF
#CHI-B80016 -- end --
                      ELSE
                         IF cl_null(g_oeq[l_ac].oeq04a) THEN
                            LET l_new_oeq04a = g_oeq[l_ac].oeq04b
                         ELSE
                            LET l_new_oeq04a = g_oeq[l_ac].oeq04a
                         END IF
                         IF cl_null(g_oeq[l_ac].oeq12a) THEN
                            LET l_new_oeq12a = g_oeq[l_ac].oeq12b
                            LET l_new_oeq12a = s_digqty(l_new_oeq12a ,g_oeq[l_ac].oeq05a) #FUN-910088--add--
                         ELSE
                            LET l_new_oeq12a = g_oeq[l_ac].oeq12a
                         END IF
                         IF cl_null(g_oeq[l_ac].oeq15a) THEN
                            LET l_new_oeq15a = g_oeq[l_ac].oeq15b
                         ELSE
                            LET l_new_oeq15a = g_oeq[l_ac].oeq15a
                         END IF
                         CALL s_mpslog('U',l_new_oeq04a,
                                       l_new_oeq12a,l_new_oeq15a,
                                       g_oeq[l_ac].oeq04b,
                                       g_oeq[l_ac].oeq12b,g_oeq[l_ac].oeq15b,
                                       g_oep.oep01,g_oeq[l_ac].oeq03,
                                       g_oeq[l_ac].oeq03)
#CHI-B80016 -- begin --
                         IF g_success = 'N' THEN
                            ROLLBACK WORK
                            EXIT INPUT
                         END IF
#CHI-B80016 -- end --
                      END IF
                   END IF
                   COMMIT WORK
               END IF
            END IF


        AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_oeq[l_ac].* = g_oeq_t.*
                  LET l_oeq04a_o = g_oeq_t.oeq04a #MOD-490359
                  LET l_oeq12a_o = g_oeq_t.oeq12a #MOD-890224
               END IF
               CLOSE t800_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
           #MOD-D10109 add start    -----
            CALL t800_set_origin_field()
            IF NOT t800_chk_origin_field() THEN NEXT FIELD CURRENT END IF
           #MOD-D10109 add end    -----
##FUN-CC0007---add---START
#           IF p_cmd = 'a' OR g_oeq[l_ac].oeq04a != g_oeq_t.oeq04a THEN  #產品編號
#              #刪除、更改單身資料時，也要一併刪除oeqa_file資料
#              DELETE FROM oeqa_file
#               WHERE oeqa01  = g_oep.oep01
#                 AND oeqa011 = g_oep.oep02
#                 AND oeqa02  = g_oeq_t.oeq03
#              IF SQLCA.sqlcode THEN
#                 CALL cl_err3("del","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
#                 RETURN
#              END IF
#              #訂單單號+項次於oeba_file是否有資料
#              LET l_n = 0
#              SELECT COUNT(*) INTO l_n FROM oeba_file
#               WHERE oeba01 = g_oep.oep01
#                 AND oeba02 = g_oeq[l_ac].oeq03
#              IF l_n > 0 and (cl_null(g_oeq[l_ac].oeq04a) OR g_oeq[l_ac].oeq04a = '' OR g_oeq[l_ac].oeq04a = g_oeq[l_ac].oeq04b)  THEN
#                 LET g_sql = " SELECT * FROM oeba_file",
#                             "  WHERE oeba01 = '",g_oep.oep01,"'",
#                             "    AND oeba02 = '",g_oeq[l_ac].oeq03,"'"
#                 PREPARE t800_bcl_c FROM g_sql
#                 DECLARE t800_oeba_curs CURSOR FOR t800_bcl_c
#                 FOREACH t800_oeba_curs INTO l_oeba.*
#                     INSERT INTO oeqa_file(oeqa01,oeqa011,oeqa02,oeqa03,oeqa04,oeqa05b,oeqa06b,oeqa07b,oeqa07a,oeqalegal,oeqaplant)
#                     VALUES(g_oep.oep01,g_oep.oep02,g_oeq[l_ac].oeq03,l_oeba.oeba03,l_oeba.oeba04,l_oeba.oeba05,l_oeba.oeba06,l_oeba.oeba07,l_oeba.oeba07,g_legal,g_plant)
#                     IF SQLCA.sqlcode THEN
#                        CALL cl_err3("ins","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
#                     ELSE
#                        LET l_flag = 'Y'
#                     END IF
#                 END FOREACH
#              END IF
#              #判斷ima929特性主料編號/ima928特性主料
#              IF cl_null(g_oeq[l_ac].oeq04a) OR g_oeq[l_ac].oeq04a = '' OR g_oeq[l_ac].oeq04a = g_oeq[l_ac].oeq04b THEN
#                 LET l_oeq04a = g_oeq[l_ac].oeq04b
#              ELSE
#                 LET l_oeq04a = g_oeq[l_ac].oeq04a
#              END IF
#              SELECT ima928,ima929 INTO l_ima928,l_ima929
#                FROM ima_file
#               WHERE ima01 = l_oeq04a
#              IF l_flag <> 'Y' THEN
#                 IF l_ima928 = 'Y' THEN
#                    LET g_sql = " SELECT * FROM imac_file",
#                                "  WHERE imac01 = '",l_oeq04a,"'"
#                    PREPARE t800_bcl_a FROM g_sql
#                    DECLARE t800_oeqa_cs CURSOR FOR t800_bcl_a
#                    FOREACH t800_oeqa_cs INTO l_imac.*
#                       SELECT ini03 INTO l_ini03 FROM ini_file WHERE ini01 = l_imac.imac04
#                       IF l_ini03 = '1' THEN
#                          LET l_oeqa07a = '3'
#                       ELSE
#                          LET l_oeqa07a = '6'
#                       END IF
#                       INSERT INTO oeqa_file(oeqa01,oeqa011,oeqa02,oeqa03,oeqa04,oeqa05a,oeqa06a,oeqa07a,oeqalegal,oeqaplant)
#                       VALUES(g_oep.oep01,g_oep.oep02,g_oeq[l_ac].oeq03,l_imac.imac02,l_imac.imac04,'','',l_oeqa07a,g_legal,g_plant)
#                       IF SQLCA.sqlcode THEN
#                          CALL cl_err3("ins","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
#                          RETURN
#                       END IF
#                    END FOREACH
#                 ELSE
#                    IF cl_null(l_ima929) THEN
#                      LET g_sql = " SELECT * FROM imac_file",
#                                  "  WHERE imac01 = '",l_oeq04a,"'",
#                                  "    AND imac03 = '2'"
#                      PREPARE t800_bcl_b FROM g_sql
#                      DECLARE t800_oeqa_curs CURSOR FOR t800_bcl_b
#                      FOREACH t800_oeqa_curs INTO l_imac.*
#                          SELECT ini03 INTO l_ini03 FROM ini_file WHERE ini01 = l_imac.imac04
#                          IF l_ini03 = '1' THEN
#                             LET l_oeqa07a = '3'
#                          ELSE
#                             LET l_oeqa07a = '6'
#                          END IF
#
#                          INSERT INTO oeqa_file(oeqa01,oeqa011,oeqa02,oeqa03,oeqa04,oeqa05a,oeqa06a,oeqa07a,oeqalegal,oeqaplant)
#                          VALUES(g_oep.oep01,g_oep.oep02,g_oeq[l_ac].oeq03,l_imac.imac02,l_imac.imac04,'','',l_oeqa07a,g_legal,g_plant)
#                          IF SQLCA.sqlcode THEN
#                             CALL cl_err3("ins","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
#                             RETURN
#                          END IF
#                       END FOREACH
#                    END IF
#                 END IF
#              END IF
#           END IF
##FUN-CC0007---add-----END
            CLOSE t800_bcl
            COMMIT WORK

        ON ACTION CONTROLR
           CALL cl_show_req_fields()

        ON ACTION CONTROLG
            CALL cl_cmdask()

        ON ACTION controlp
           CASE
              WHEN INFIELD(oeq03)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_oeb2"
                   LET g_qryparam.arg1 = g_oep.oep01
                   CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq03
                   DISPLAY BY NAME g_oeq[l_ac].oeq03
                   NEXT FIELD oeq03
              WHEN INFIELD(oeq04a)
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()
#                   LET g_qryparam.form ="q_ima"
#                   LET g_qryparam.default1 = g_oeq[l_ac].oeq04a
#                   CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq04a
                   CALL q_sel_ima(FALSE, "q_ima","",g_oeq[l_ac].oeq04a,"","","","","",'' )
                       RETURNING  g_oeq[l_ac].oeq04a

#FUN-AA0059---------mod------------end-----------------
                    DISPLAY BY NAME g_oeq[l_ac].oeq04a          #No:MOD-490371
                   NEXT FIELD oeq04a
              WHEN INFIELD(oeq29a)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_azf"
                 LET g_qryparam.arg1 = "2"
                 CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq29a
                 NEXT FIELD oeq29a
              WHEN INFIELD(oeq30a)
                 CALL cl_init_qry_var()
                 LET l_form = "q_azf03"
                 SELECT COUNT(*) INTO l_count FROM ogb_file
                  WHERE ogb31=g_oep.oep01
                    AND ogb32=g_oeq[l_ac].oeq03
                 IF l_count>0 THEN
                    SELECT azf08 INTO l_azf08 FROM azf_file
                     WHERE azf01=g_oeq[l_ac].oeq30b AND azf02='2'
                    IF l_azf08='N' THEN
                       LET l_form = "q_azf17"
                    END IF
                 END IF

                 LET g_qryparam.form = l_form
                 LET g_qryparam.default1 = g_oeq[l_ac].oeq30a
                 LET g_qryparam.arg1 = '2'
                 LET g_qryparam.arg2 = '1'
                 CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq30a
                 DISPLAY BY NAME g_oeq[l_ac].oeq30a
                 NEXT FIELD oeq30a

#FUN-A80118--Add--Begin
              WHEN INFIELD(oeq31a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_pja2"
                   LET g_qryparam.default1 = g_oeq[l_ac].oeq31a
                   CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq31a
                   DISPLAY BY NAME g_oeq[l_ac].oeq31a
                   NEXT FIELD oeq31a
              WHEN INFIELD(oeq32a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_pjb4"
                   LET g_qryparam.default1 = g_oeq[l_ac].oeq32a
                   LET g_qryparam.arg1 = g_oeq[l_ac].oeq31a
                   CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq32a
                   DISPLAY BY NAME g_oeq[l_ac].oeq32a
                   NEXT FIELD oeq32a
              WHEN INFIELD(oeq33a)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_pjk3"
                   LET g_qryparam.default1 = g_oeq[l_ac].oeq33a
                   LET g_qryparam.arg1 = g_oeq[l_ac].oeq32a
                   CALL cl_create_qry() RETURNING g_oeq[l_ac].oeq33a
                   DISPLAY BY NAME g_oeq[l_ac].oeq33a
                   NEXT FIELD oeq33a
              WHEN INFIELD(ta_oeq09a)
                 IF g_oep.oep01[1,1] !='X' THEN
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="cq_oaf02"
                    LET g_qryparam.default1 = g_oeq[l_ac].ta_oeq09a
                    CALL cl_create_qry() RETURNING g_oeq[l_ac].ta_oeq09a
                    DISPLAY BY NAME g_oeq[l_ac].ta_oeq09a
                    NEXT FIELD ta_oeq09a
                 ELSE
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="cq_oaf09"
                    LET g_qryparam.default1 = g_oeq[l_ac].ta_oeq09a
                    CALL cl_create_qry() RETURNING g_oeq[l_ac].ta_oeq09a
                    DISPLAY BY NAME g_oeq[l_ac].ta_oeq09a
                    NEXT FIELD ta_oeq09a
                 END IF
             WHEN INFIELD(ta_oeq11a)
                 IF g_oep.oep01[1,1] !='X' THEN
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_obe"
                    LET g_qryparam.default1 = g_oeq[l_ac].ta_oeq11a
                    CALL cl_create_qry() RETURNING g_oeq[l_ac].ta_oeq11a
                    DISPLAY BY NAME g_oeq[l_ac].ta_oeq11a
                    NEXT FIELD ta_oeq11a
                 ELSE
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="cq_oaf10"
                    LET g_qryparam.default1 = g_oeq[l_ac].ta_oeq11a
                    CALL cl_create_qry() RETURNING g_oeq[l_ac].ta_oeq11a
                    DISPLAY BY NAME g_oeq[l_ac].ta_oeq11a
                    NEXT FIELD ta_oeq11a
                 END IF
#FUN-A80118--Add--End
           END CASE

        ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

       ON ACTION about         #MOD-4C0121
          CALL cl_about()      #MOD-4C0121

       ON ACTION help          #MOD-4C0121
          CALL cl_show_help()  #MOD-4C0121

       ON ACTION controls                        #No.FUN-6A0092
          CALL cl_set_head_visible("","AUTO")    #No.FUN-6A0092

    END INPUT
    UPDATE oep_file SET oepmodu=g_user,oepdate=g_today,oep09=l_oep09
     WHERE oep01=g_oep.oep01 AND oep02 = g_oep.oep02
    LET g_oep.oep09 = l_oep09
    DISPLAY BY NAME g_oep.oep09
    IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_oep.oep09  ='1' OR
       g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

    CLOSE t800_bcl
    COMMIT WORK

    #MOD-B30561 add begin--------------------------
    IF NOT cl_null(g_oep.oep261) THEN
       CALL t800_multi_account('1')
    END IF
    IF NOT cl_null(g_oep.oep263) THEN
       CALL t800_multi_account('2')
    END IF
    #MOD-B30561 add end----------------------------
#   CALL t800_delall() #CHI-C30002 mark
    CALL t800_delHeader()     #CHI-C30002 add

END FUNCTION

FUNCTION t800_set_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("oeq041a",TRUE)   #MOD-880250
    END IF

    IF INFIELD(oeq04a) THEN
       CALL cl_set_comp_entry("oeq041a",TRUE)
    END IF

    CALL cl_set_comp_entry("oeq23a,oeq25a,oeq26a,oeq27a",TRUE)

    CALL cl_set_comp_entry("oeq28a,oeq29a",TRUE)   #MOD-A80030

    CALL cl_set_comp_entry("oeq04a,oeq041a",TRUE)   #No:FUN-630006

   #CALL cl_set_comp_entry("oeq05a,oeq12a,oeq13a,oeq14a,oeq14ta,oeq15a",TRUE)   #No:FUN-740016   #MOD-A70005 add oeq14ta   #MOD-B90023 mark
   #CALL cl_set_comp_entry("oeq05a,oeq12a,oeq13a,oeq15a",TRUE)                  #MOD-B90023 #MOD-D10096 mark

   #MOD-D10096 add start -----
    CALL cl_set_comp_entry("oeq05a,oeq12a,oeq15a",TRUE)
    IF g_before_input_done THEN
       LET g_ogb_cnt = 0
       #mark by liumin 160523 str-- 排除作废的单子
       #SELECT COUNT(*) INTO g_ogb_cnt
       # FROM ogb_file
       #WHERE ogb31 = g_oep.oep01 AND ogb32 = g_oeq[l_ac].oeq03
       #mark by liumin 160523 --end
       #add by liumin 160523 str--
       SELECT COUNT(*) INTO g_ogb_cnt
        FROM ogb_file,oga_file
        WHERE ogb01 = oga01
          AND  ogb31 = g_oep.oep01 AND ogb32 = g_oeq[l_ac].oeq03
          AND ogaconf <> 'X'
       #add by liumin 160523 --end
       IF g_ogb_cnt = 0 THEN
          CALL cl_set_comp_entry("oeq13a",TRUE)
       END IF
    END IF
   #MOD-D10096 add end  -----

   #IF g_oea00 <> "8" OR g_oea00 <> "9" THEN                                    #CHI-C90034 mark
    IF g_oea00 <> "8" THEN                                                      #CHI-C90034
       CALL cl_set_comp_entry("oeq30a",TRUE)
    END IF

END FUNCTION

FUNCTION t800_set_no_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    #IF INFIELD(oeq04a) THEN   #MOD-A90087
       IF g_oeq[l_ac].oeq04a[1,4] !='MISC' OR
          (g_oeq[l_ac].oeq04a IS NULL AND g_oeq[l_ac].oeq04b[1,4] != 'MISC') THEN   #MOD-A90087
          CALL cl_set_comp_entry("oeq041a",FALSE)
       END IF
    #END IF   #MOD-A90087

    IF g_ima906 = '1' THEN
       CALL cl_set_comp_entry("oeq23a,oeq24a,oeq25a,oeq21a",FALSE)
    END IF
    IF g_ima906 = '2' THEN
       CALL cl_set_comp_entry("oeq24a,oeq21a",FALSE)
    END IF
    #參考單位，每個料件只有一個，所以不開放讓用戶輸入
    IF g_ima906 = '3' AND g_user<>'tiptop' THEN
       CALL cl_set_comp_entry("oeq23a,oeq21a",FALSE)
    END IF
    IF g_sma.sma116 MATCHES '[01]' THEN    #No:FUN-610076
       CALL cl_set_comp_entry("oeq26a,oeq27a",FALSE)
    END IF

#   IF g_oeb920 > 0 THEN                       #MOD-B70041 mark
    IF g_oeb920 > 0 AND g_newline = 'N' THEN   #MOD-B70041
       CALL cl_set_comp_entry("oeq04a,oeq041a",FALSE)
    END IF

   #IF g_oea00 = "8" OR g_oea00="9" THEN                                            #CHI-C90034 mark
    IF g_oea00 = "8" THEN                                                           #CHI-C90034
       CALL cl_set_comp_entry("oeq23a,oeq25a,oeq26a,oeq27a",FALSE)
       CALL cl_set_comp_entry("oeq04a,oeq041a",FALSE)
      #CALL cl_set_comp_entry("oeq05a,oeq12a,oeq13a,oeq14a,oeq14ta,oeq15a",FALSE)   #MOD-A70005 add oeq14ta   #MOD-B90023 mark
      #CALL cl_set_comp_entry("oeq05a,oeq12a,oeq13a,oeq15a",FALSE)                  #MOD-B90023  #FUN-CA0009 mark
       CALL cl_set_comp_entry("oeq05a,oeq13a,oeq15a",FALSE)                         #FUN-CA0009 add
       CALL cl_set_comp_entry("oeq30a",FALSE)                                       #No.FUN-990030
    ELSE
       IF g_oea00 = "9" THEN                                                        #CHI-C90034
          CALL cl_set_comp_entry("oeq04a,oeq041a",FALSE)                            #CHI-C90034
       ELSE                                                                         #CHI-C90034
          CALL cl_set_comp_entry("oeq28a,oeq29a",FALSE)
         #MOD-D10096 add start -----
          IF g_before_input_done THEN
             LET g_ogb_cnt = 0
             SELECT COUNT(*) INTO g_ogb_cnt
               FROM ogb_file
              WHERE ogb31 = g_oep.oep01 AND ogb32 = g_oeq[l_ac].oeq03

             IF g_ogb_cnt > 0 THEN
                CALL cl_set_comp_entry("oeq13a",FALSE)
             END IF
          END IF
         #MOD-D10096 add end  -----
       END IF                                                                       #CHI-C90034
    END IF

    CALL cl_set_comp_entry("oeq37a,oeq37b",FALSE) #FUN-AB0082

    IF g_chk = '1' THEN
       CALL cl_set_comp_entry("oeq04a,oeq041a,oeq05a,oeq26a,oeq20a,oeq23a",FALSE)
    END IF

END FUNCTION

#No:7798 重算金額 oeq14a
FUNCTION t800_oeq14a()
 DEFINE l_qty   LIKE oeq_file.oeq12a,   #Qty
        l_up    LIKE oeq_file.oeq13a,   #Unit Price
        l_oeq14a  LIKE oeq_file.oeq14a,
        l_oea213  LIKE oea_file.oea213,
        l_oea211  LIKE oea_file.oea211,
        l_oeb16   LIKE oeb_file.oeb16,
        l_oea23   LIKE oea_file.oea23

     #-----MOD-A70077---------
     LET l_oea23 = g_oep.oep08
     IF NOT cl_null(g_oep.oep08b) THEN
        LET l_oea23 = g_oep.oep08b
     END IF
     #-----END MOD-A70077-----
     SELECT azi03,azi04 INTO t_azi03,t_azi04
      FROM azi_file
     #WHERE azi01=g_oea.oea23   #MOD-A70077
     WHERE azi01=l_oea23   #MOD-A70077
     LET l_qty=g_oeq[l_ac].oeq27b
     LET l_up=g_oeq[l_ac].oeq13b
     IF NOT cl_null(g_oeq[l_ac].oeq27a) THEN
        LET l_qty=g_oeq[l_ac].oeq27a
     END IF
     IF NOT cl_null(g_oeq[l_ac].oeq13a) AND g_oeq[l_ac].oeq13a>0 THEN
        LET l_up=g_oeq[l_ac].oeq13a
     END IF
     LET l_oeq14a=t800_amount(l_qty,l_up,g_oeb1006,t_azi03)   #No.MOD-820066
     #SELECT oea213,oea211,oea23 INTO l_oea213,l_oea211,l_oea23    #MOD-A70077
     SELECT oea213,oea211 INTO l_oea213,l_oea211    #MOD-A70077
             FROM oea_file WHERE oea01 = g_oep.oep01
#FUN-B50158  ---begin---
     IF NOT cl_null(g_oep.oep14b) THEN
        SELECT gec04,gec07 INTO l_oea211,l_oea213 FROM gec_file WHERE gec01 = g_oep.oep14b AND gec011 = '2'
     END IF
#FUN-B50158  ---end---
     #SELECT azi03,azi04 INTO g_azi03,g_azi04   #MOD-A70077
     #        FROM azi_file WHERE azi01=l_oea23   #MOD-A70077
     IF NOT cl_null(g_oeq[l_ac].oeq13a) THEN
          #CALL cl_digcut(g_oeq[l_ac].oeq13a,g_azi03)   #MOD-A70077
          CALL cl_digcut(g_oeq[l_ac].oeq13a,t_azi03)   #MOD-A70077
               RETURNING g_oeq[l_ac].oeq13a
     END IF

#FUN-B50158  ---begin---
     IF cl_null(g_oeb1012) OR cl_null(g_oeb1006) THEN
        SELECT oeb1012,oeb1006 INTO g_oeb1012,g_oeb1006 FROM oeb_file
         WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03
        IF cl_null(g_oeb1006) THEN
           LET g_oeb1006 = 100
        END IF
        IF cl_null(g_oeb1012) THEN
           LET g_oeb1012 = 'N'
        END IF
     END IF
#FUN-B50158  --end---

     IF g_oeb1012 = 'N' THEN        #TQC-7B0111
        IF l_oea213 = 'N' THEN # 不內含
           LET g_oeq[l_ac].oeq14a=t800_amount(l_qty,l_up,g_oeb1006,t_azi03)           #No.MOD-820066
           #LET g_oeq[l_ac].oeq14a=cl_digcut(g_oeq[l_ac].oeq14a,g_azi04)               #No.MOD-820066     #MOD-A70077
           LET g_oeq[l_ac].oeq14a=cl_digcut(g_oeq[l_ac].oeq14a,t_azi04)               #No.MOD-820066     #MOD-A70077
           #LET t_oeq14ta=cl_digcut(g_oeq[l_ac].oeq14a*(1+l_oea211/100),g_azi04)      #MOD-A70005
           #LET g_oeq[l_ac].oeq14ta=cl_digcut(g_oeq[l_ac].oeq14a*(1+l_oea211/100),g_azi04)      #MOD-A70005   #MOD-A70077
           LET g_oeq[l_ac].oeq14ta=cl_digcut(g_oeq[l_ac].oeq14a*(1+l_oea211/100),t_azi04)      #MOD-A70005   #MOD-A70077
        ELSE
           #-----MOD-A70005---------
           LET g_oeq[l_ac].oeq14ta=t800_amount(l_qty,l_up,g_oeb1006,t_azi03)         #No.MOD-820066
           #LET g_oeq[l_ac].oeq14ta=cl_digcut(g_oeq[l_ac].oeq14ta,g_azi04)                      #No.MOD-820066      #MOD-A70077
           LET g_oeq[l_ac].oeq14ta=cl_digcut(g_oeq[l_ac].oeq14ta,t_azi04)                      #No.MOD-820066      #MOD-A70077
           #LET g_oeq[l_ac].oeq14a=cl_digcut(g_oeq[l_ac].oeq14ta/(1+l_oea211/100),g_azi04)    #MOD-A70077
           LET g_oeq[l_ac].oeq14a=cl_digcut(g_oeq[l_ac].oeq14ta/(1+l_oea211/100),t_azi04)    #MOD-A70077
           #-----END MOD-A70005-----
        END IF
     ELSE                           #TQC-7B0111
        LET l_oeq14a = 0            #TQC-7B0111
        #LET t_oeq14ta = 0           #TQC-7B0111   #MOD-A70005
        LET g_oeq[l_ac].oeq14ta = 0           #TQC-7B0111   #MOD-A70005
        LET g_oeq[l_ac].oeq14a = 0  #TQC-7B0111
     END IF                         #TQC-7B0111
     DISPLAY BY NAME g_oeq[l_ac].oeq14a
     DISPLAY BY NAME g_oeq[l_ac].oeq14ta   #MOD-A70005
END FUNCTION

#-----MOD-A70005---------
{
##No.3371 010821 add--- 計算oeq14ta 欄位值, 否則會依游標移動而不正確
#FUNCTION t800_oeq14ta()
# DEFINE l_qty   LIKE oeq_file.oeq12a,   #Qty
#        l_up    LIKE oeq_file.oeq13a,   #Unit Price
#        l_oeq14a  LIKE oeq_file.oeq14a,
#        l_oea213  LIKE oea_file.oea213,
#        l_oea211  LIKE oea_file.oea211,
#        l_oeb16   LIKE oeb_file.oeb16,
#        l_oea23   LIKE oea_file.oea23
#
#     SELECT azi03,azi04 INTO t_azi03,t_azi04
#      FROM azi_file
#     WHERE azi01=g_oea.oea23
#
#     LET l_qty=g_oeq[l_ac].oeq27b
#     LET l_up=g_oeq[l_ac].oeq13b
#     IF NOT cl_null(g_oeq[l_ac].oeq27a) THEN
#        LET l_qty=g_oeq[l_ac].oeq27a
#     END IF
#     IF NOT cl_null(g_oeq[l_ac].oeq13a) THEN
#        LET l_up=g_oeq[l_ac].oeq13a
#     END IF
#     LET l_oeq14a=t800_amount(l_qty,l_up,g_oeb1006,t_azi03) #No.MOD-820066
#
#     SELECT oea213,oea211,oea23 INTO l_oea213,l_oea211,l_oea23
#        FROM oea_file WHERE oea01 = g_oep.oep01
#            SELECT azi03,azi04 INTO t_azi03,t_azi04                       #No.CHI-6A0004  g_azi-->t_azi
#                    FROM azi_file WHERE azi01=l_oea23
#    IF g_oeb1012 = 'N' THEN        #TQC-7B0111
#       IF l_oea213 = 'N'  THEN     # 不內含
#          LET l_oeq14a=t800_amount(l_qty,l_up,g_oeb1006,t_azi03)     #No.MOD-820066
#          LET t_oeq14ta=l_oeq14a*(1+l_oea211/100)
#       ELSE
#          LET t_oeq14ta=t800_amount(l_qty,l_up,g_oeb1006,t_azi03)    #No.MOD-820066
#       END IF
#     ELSE                           #TQC-7B0111
#        LET l_oeq14a = 0            #TQC-7B0111
#        LET t_oeq14ta = 0           #TQC-7B0111
#        LET g_oeq[l_ac].oeq14a = 0  #TQC-7B0111
#     END IF                         #TQC-7B0111
#            CALL cl_digcut(t_oeq14ta,t_azi04) RETURNING t_oeq14ta              #No.CHI-6A0004  g_azi-->t_azi
#END FUNCTION
#}
#-----END MOD-A70005-----

#CHI-C30002 -------- add -------- begin
FUNCTION t800_delHeader()

   DEFINE l_cnt LIKE type_file.num10     #MOD-B30561
   DEFINE l_action_choice    STRING               #CHI-C80041
   DEFINE l_cho              LIKE type_file.num5  #CHI-C80041
   DEFINE l_num              LIKE type_file.num5  #CHI-C80041

    SELECT COUNT(*) INTO g_cnt FROM oeq_file
     WHERE oeq01 = g_oep.oep01
       AND oeq02 = g_oep.oep02

    #MOD-B30561 add begin---------------------
    SELECT COUNT(*) INTO l_cnt FROM oepa_file
     WHERE oepa01 = g_oep.oep01
       AND oepa011= g_oep.oep02
    #MOD-B30561 add end-----------------------
    #IF g_cnt = 0 THEN   #MOD-B30561 mark
       AND oeq02 = g_oep.oep02

    #MOD-B30561 add begin---------------------
    SELECT COUNT(*) INTO l_cnt FROM oepa_file
     WHERE oepa01 = g_oep.oep01
       AND oepa011= g_oep.oep02
    #MOD-B30561 add end-----------------------
    #IF g_cnt = 0 THEN   #MOD-B30561 mark
    IF g_cnt = 0 AND l_cnt = 0 THEN   #MOD-B30561
       #若單頭也無任何變更
       IF cl_null(g_oep.oep06b) AND cl_null(g_oep.oep07b)
          AND cl_null(g_oep.oep16b)                                     #FUN-C40081
          AND cl_null(g_oep.oep25b)                                     #FUN-C40080
          AND cl_null(g_oep.oep26b)                                     #FUN-C40080
          AND cl_null(g_oep.oep41b)                                     #FUN-C20109
          AND cl_null(g_oep.oep08b)
          AND cl_null(g_oep.oep10b)
          AND cl_null(g_oep.oep11b)
          AND cl_null(g_oep.oep161b) AND cl_null(g_oep.oep261b)         #No:FUN-A50103
          AND cl_null(g_oep.oep162b) AND cl_null(g_oep.oep262b)         #No:FUN-A50103
#         AND cl_null(g_oep.oep163b) AND cl_null(g_oep.oep263b) THEN    #No:FUN-A50103 #FUN-A80118 Mark
          AND cl_null(g_oep.oep163b) AND cl_null(g_oep.oep263b)         #FUN-A80118 Add
          AND cl_null(g_oep.oep14b) AND cl_null(g_oep.oep15b) THEN      #FUN-A80118 Add
          #CHI-C80041---begin
          LET l_action_choice = g_action_choice
          LET g_action_choice = 'delete'
          IF cl_chk_act_auth() THEN
             CALL cl_getmsg('aec-130',g_lang) RETURNING g_msg
             LET l_num = 3
          ELSE
             CALL cl_getmsg('aec-131',g_lang) RETURNING g_msg
             LET l_num = 2
          END IF
          LET g_action_choice = l_action_choice
          PROMPT g_msg CLIPPED,': ' FOR l_cho
             ON IDLE g_idle_seconds
                CALL cl_on_idle()

             ON ACTION about
                CALL cl_about()

             ON ACTION HELP
                CALL cl_show_help()

             ON ACTION controlg
                CALL cl_cmdask()
          END PROMPT
          IF l_cho > l_num THEN LET l_cho = 1 END IF
          IF l_cho = 2 THEN
	    #CALL t800_x()    #FUN-D20025
             CALL t800_x(1)   #FUN-D20025
          END IF

          IF l_cho = 3 THEN
             DELETE FROM oepa_file WHERE oepa01 = g_oep.oep01
                                     AND oepa02 = g_oep.oep02

             DELETE FROM oer_file WHERE oer01 = g_oep.oep01
                                    AND oer02 = g_oep.oep02

             LET g_key1=g_oep.oep01 CLIPPED,g_oep.oep02 USING '&&' CLIPPED
             DELETE FROM azd_file WHERE azd01 = g_key1 AND azd02=26
          #CHI-C80041---end
          #IF cl_confirm("9042") THEN  #CHI-C80041
             DELETE FROM oep_file WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
             DELETE FROM oeq_file WHERE oeq01 = g_oep.oep01 AND oeq02 = g_oep.oep02
             INITIALIZE g_oep.* TO NULL
             CLEAR FORM
             CALL g_oeq.clear()
          END IF
       END IF
    END IF
END FUNCTION
#CHI-C30002 -------- add -------- end

#CHI-C30002 -------- mark -------- begin
#FUNCTION t800_delall()                  # 未輸入單身資料, 是否取消單頭資料
#&ifndef STD
#  DEFINE l_flag LIKE type_file.chr1    #No.FUN-7B0018
#&endif

#  DEFINE l_cnt LIKE type_file.num10     #MOD-B30561

#   SELECT COUNT(*) INTO g_cnt FROM oeq_file
#    WHERE oeq01 = g_oep.oep01
#      AND oeq02 = g_oep.oep02
#
#   #MOD-B30561 add begin---------------------
#   SELECT COUNT(*) INTO l_cnt FROM oepa_file
#    WHERE oepa01 = g_oep.oep01
#      AND oepa011= g_oep.oep02
#   #MOD-B30561 add end-----------------------
#   #IF g_cnt = 0 THEN   #MOD-B30561 mark
#   IF g_cnt = 0 AND l_cnt = 0 THEN   #MOD-B30561
#      #若單頭也無任何變更
#      IF cl_null(g_oep.oep06b) AND cl_null(g_oep.oep07b)
#         AND cl_null(g_oep.oep08b)
#         AND cl_null(g_oep.oep10b)
#         AND cl_null(g_oep.oep11b)
#         AND cl_null(g_oep.oep161b) AND cl_null(g_oep.oep261b)    #No:FUN-A50103
#         AND cl_null(g_oep.oep162b) AND cl_null(g_oep.oep262b)    #No:FUN-A50103
#         AND cl_null(g_oep.oep163b) AND cl_null(g_oep.oep263b) THEN    #No:FUN-A50103 #FUN-A80118 Mark
#         AND cl_null(g_oep.oep163b) AND cl_null(g_oep.oep263b)         #FUN-A80118 Add
#         AND cl_null(g_oep.oep14b) AND cl_null(g_oep.oep15b) THEN      #FUN-A80118 Add
#      CALL cl_err(g_oep.oep01,9044,0)
#      DELETE FROM oep_file WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
#      DELETE FROM oeq_file WHERE oeq01 = g_oep.oep01 AND oeq02 = g_oep.oep02
#&ifndef STD
#      LET l_flag = s_del_oeqi(g_oep.oep01,g_oep.oep02,'','')
#&endif
#      CLEAR FORM
#  CALL g_oeq.clear()
#      END IF
#   END IF
#END FUNCTION
#CHI-C30002 -------- mark -------- end

FUNCTION  t800_oeq03(p_cmd)
DEFINE
    p_cmd           LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

    LET g_errno = ' '

        SELECT oeb04, oeb05, oeb12, oeb13, oeb14, oeb14t,
               oeb15, oeb06, oeb913,oeb914,oeb915,oeb910,
               oeb911,oeb912,oeb916,oeb917,oeb920,oeb30,oeb31,   #No:FUN-630006   #No:FUN-740016
               oeb1001,                                          #No.FUN-990030 add oeb1001
               oeb1012,oeb1006                                   #No.TQC-7B0111
              ,oeb41,oeb42,oeb43                                 #FUN-A80118 Add
              ,oeb37                                             #FUN-AB0082
              ,oeb11,oebud04,oebud02,oebud03,oebud05             #FUN-C60076
           INTO g_oeq[l_ac].oeq04b, g_oeq[l_ac].oeq05b,
               g_oeq[l_ac].oeq12b, g_oeq[l_ac].oeq13b,
               #g_oeq[l_ac].oeq14b, t_oeq14tb,   #MOD-A70005
               g_oeq[l_ac].oeq14b, g_oeq[l_ac].oeq14tb,   #MOD-A70005
               g_oeq[l_ac].oeq15b, g_oeq[l_ac].oeq041b,
               g_oeq[l_ac].oeq23b, g_oeq[l_ac].oeq24b,
               g_oeq[l_ac].oeq25b, g_oeq[l_ac].oeq20b,
               g_oeq[l_ac].oeq21b, g_oeq[l_ac].oeq22b,
               g_oeq[l_ac].oeq26b, g_oeq[l_ac].oeq27b,g_oeb920,  #No:FUN-630006
               g_oeq[l_ac].oeq28b, g_oeq[l_ac].oeq29b,                    #No:FUN-740016
               g_oeq[l_ac].oeq30b,                                        #No.FUN-990030
               g_oeb1012,g_oeb1006                                        #No.TQC-7B0111
              ,g_oeq[l_ac].oeq31b, g_oeq[l_ac].oeq32b,g_oeq[l_ac].oeq33b  #FUN-A80118 Add
              ,g_oeq[l_ac].oeq37b                                         #FUN-AB0082
              ,g_oeq[l_ac].oeq11b,g_oeq[l_ac].ta_oeq01b,                  #FUN-C60076
               g_oeq[l_ac].ta_oeq09b,g_oeq[l_ac].ta_oeq10b,
               g_oeq[l_ac].ta_oeq11b
          FROM oeb_file
         WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03

         SELECT tc_oeb04,tc_oeb05,tc_oeb06,tc_oeb07,tc_oeb08,tc_oeb09.tc_oeb10
           INTO g_oeq[l_ac].ta_oeq02b,g_oeq[l_ac].ta_oeq03b,g_oeq[l_ac].ta_oeq04b,
                g_oeq[l_ac].ta_oeq05b,g_oeq[l_ac].ta_oeq06b,g_oeq[l_ac].ta_oeq07b,
                g_oeq[l_ac].ta_oeq08b
           FROM tc_oeb_file
           WHERE tc_oeb01 = '1' AND tc_oeb02=g_oep.oep01 AND tc_oeb03 = g_oeq[l_ac].oeq03

         #FUN-C30289---begin
         SELECT oebiicd01,oebiicd04 INTO g_oeq[l_ac].oeqiicd01b,g_oeq[l_ac].oeqiicd04b
           FROM oebi_file
         WHERE oebi01 = g_oep.oep01 AND oebi03 = g_oeq[l_ac].oeq03
         #FUN-C30289---end
    IF cl_null(g_oeb1006) THEN
       LET g_oeb1006 = 100
    END IF
    IF cl_null(g_oeb1012) THEN
       LET g_oeb1012 = 'N'
    END IF
    SELECT ima021,ima31,ima906,ima907,ima908
      INTO g_oeq[l_ac].ima021b,g_ima31,g_ima906,g_ima907,g_ima908
      FROM ima_file
     WHERE ima01=g_oeq[l_ac].oeq04b
    IF SQLCA.sqlcode THEN
       IF g_oeq[l_ac].oeq04b MATCHES 'MISC*' THEN
          SELECT ima021,ima31,ima906,ima907,ima908
            INTO g_oeq[l_ac].ima021b,g_ima31,g_ima906,g_ima907,g_ima908
            FROM ima_file
           WHERE ima01='MISC'
       END IF
    END IF
    LET g_oeq04=g_oeq[l_ac].oeq04b

END FUNCTION

FUNCTION t800_oeq04a(p_no)            #料件編號
    DEFINE l_imaacti LIKE ima_file.imaacti,
           p_no      LIKE oeb_file.oeb04

  LET g_errno = " "
  SELECT imaacti,ima02,ima31,ima021          #品名及單位
    INTO l_imaacti,g_oeq[l_ac].oeq041a,g_oeq[l_ac].oeq05a,g_oeq[l_ac].ima021a
    FROM ima_file
   WHERE ima01 = p_no

  CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg0002'
                                 LET g_oeq[l_ac].oeq041a=NULL #NO:6808
                                 LET g_oeq[l_ac].oeq05a =NULL
                                 LET g_oeq[l_ac].ima021a=NULL
       WHEN l_imaacti='N' LET g_errno = '9028'
       WHEN l_imaacti MATCHES '[PH]'  LET g_errno = '9038'   #No.FUN-690022 add
       OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
  END CASE

END FUNCTION


#系統參數設料件/供應商須存在
FUNCTION t800_pmh()  #供應廠商
    DEFINE  l_oea09 LIKE oea_file.oea09,
            l_oea23 LIKE oea_file.oea23,
            l_pmhacti LIKE pmh_file.pmhacti

 LET g_errno = " "
SELECT oea09,oea23 INTO l_oea09,l_oea23
  FROM oea_file
 WHERE oea01 = g_oep.oep01
 SELECT pmhacti INTO l_pmhacti
     FROM pmh_file
     WHERE pmh01=g_oeq[l_ac].oeq04a AND pmh02= l_oea09 AND pmh13=l_oea23
       AND pmh21 = " "                                             #CHI-860042
       AND pmh22 = '1'                                             #CHI-860042
       AND pmh23 = ' '                                             #No.CHI-960033
       AND pmhacti = 'Y'                                           #CHI-910021

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg0031'
                            LET l_pmhacti = NULL
         WHEN l_pmhacti='N' LET g_errno = '9028'
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
END FUNCTION

#--->單位檔
FUNCTION t800_unit(p_key)
  DEFINE p_key      LIKE gfe_file.gfe01,
         l_gfeacti  LIKE gfe_file.gfeacti

  LET g_errno = ' '
  SELECT gfeacti INTO l_gfeacti FROM gfe_file
                WHERE gfe01 = p_key
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3098'
                          LET l_gfeacti = NULL
        WHEN l_gfeacti='N' LET g_errno = '9028'
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
END FUNCTION

FUNCTION t800_b_askkey()
DEFINE
    l_wc            LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(200)

    CONSTRUCT l_wc ON oeq03,oeq12a,oeq37a,oeq13a,oeq15a,oeq28a,oeq29a  #螢幕上取條件   #No:FUN-740016 #FUN-AB0082
       FROM s_oeq[1].oeq03,s_oeq[1].oeq12a,s_oeq[1].oeq37a,s_oeq[1].oeq13a,s_oeq[1].oeq15a, #FUN-AB0082
           s_oeq[1].oeq28a,s_oeq[1].oeq29a   #No:FUN-740016
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


		#No:FUN-580031 --start--     HCN
                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
		#No:FUN-580031 --end--       HCN
    END CONSTRUCT
    IF INT_FLAG THEN RETURN END IF
    CALL t800_b_fill(l_wc)
END FUNCTION


FUNCTION t800_b_fill(p_wc)              #BODY FILL UP
DEFINE
    l_qty           LIKE oeq_file.oeq12a,               #Qty
    l_up            LIKE oeq_file.oeq13a,               #Unit Price
    l_sql           STRING,                             #No:FUN-7C0017
    l_sql2          STRING,                             #No:FUN-7C0017
    l_sql3          STRING,                             #No:FUN-7C0017
    p_wc            LIKE type_file.chr1000              #No.FUN-680137 VARCHAR(500)

    IF cl_null(g_oep.oep02) THEN LET g_oep.oep02 = 0 END IF
     LET l_sql =
     "SELECT oeq03, '0',oeq04b,oeq041b,'',oeq11b,oeq30b,oeq05b,oeq12b,",    #NO.FUN-990030 add oeq30b   #FUN-C60076 add oeq11b
     "       oeq23b,oeq24b,oeq25b,oeq20b,oeq21b,oeq22b,oeq26b,oeq27b,",
     "       oeq37b,",  #FUN-AB0082
     "       oeq13b,oeq14b,oeq14tb,oeq31b,oeq32b,oeq33b,oeq15b,oeq28b,oeq29b,'','','','',",      #MOD-A70005 add oeq14tb #FUN-A80118 Add oeq31b,oeq32b,oeq33b
     "       ta_oeq01b,ta_oeq02b,ta_oeq03b,ta_oeq04b,ta_oeq05b,ta_oeq06b,ta_oeq07b,ta_oeq08b,",
     "       ta_oeq09b,ta_oeq10b,ta_oeq11b,'',",
     "              '1',oeq04a,oeq041a,'',oeq11a,oeq30a,oeq05a,oeq12a,",    #No.FUN-990030 add oeq30a   #FUN-C60076 add oeq11a
     "       oeq23a,oeq24a,oeq25a,oeq20a,oeq21a,oeq22a,oeq26a,oeq27a,",
     "       oeq37a, ", #FUN-AB0082
     "       oeq13a,oeq14a,oeq14ta,oeq31a,oeq32a,oeq33a,oeq15a,oeq28a,oeq29a,'','','','',",   #No:FUN-740016   #MOD-A70005 add oeq14ta #FUN-A80118 Add oeq31a,oeq32a,oeq33a
     "       ta_oeq01a,ta_oeq02a,ta_oeq03a,ta_oeq04a,ta_oeq05a,ta_oeq06a,ta_oeq07a,ta_oeq08a,",
     "       ta_oeq09a,ta_oeq10a,ta_oeq11a,'',",
     "       oeq50",
     " FROM oeq_file ",
     " WHERE oeq01 = '",g_oep.oep01, "'",
#    "   AND oeq02 = '",g_oep.oep02,"' AND ", p_wc CLIPPED  #TQC-AB0025 mark
     "   AND oeq02 =  ",g_oep.oep02,"  AND ", p_wc CLIPPED  #TQC-AB0025 add

    PREPARE t800_prepare2 FROM l_sql      #預備一下
    DECLARE oeq_cs CURSOR FOR t800_prepare2

    CALL g_oeq.clear()

    LET g_rec_b = 0
    LET g_cnt = 1
    FOREACH oeq_cs INTO g_oeq[g_cnt].*   #單身 ARRAY 填充
        IF SQLCA.sqlcode THEN
            CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
            EXIT FOREACH
        END IF
        SELECT ima021 INTO g_oeq[g_cnt].ima021a FROM ima_file
         WHERE ima01=g_oeq[g_cnt].oeq04a
        SELECT ima021 INTO g_oeq[g_cnt].ima021b FROM ima_file
         WHERE ima01=g_oeq[g_cnt].oeq04b

        IF g_oep.oep01[1,1] !='X' THEN
           SELECT obe02 INTO g_oeq[g_cnt].tc_oaf03a FROM obe_file WHERE obe01 = g_oeq[g_cnt].ta_oeq11a
        ELSE
           SELECT tc_oaf03 INTO g_oeq[g_cnt].tc_oaf03a FROM tc_oaf_file WHERE tc_oaf02 = g_oeq[g_cnt].ta_oeq11a AND tc_oaf01='10'
        END IF

        LET g_cnt = g_cnt + 1
    END FOREACH
    CALL g_oeq.deleteElement(g_cnt)
    LET g_rec_b = g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2

END FUNCTION

FUNCTION t800_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_oeq TO s_oeq.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )

      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No:FUN-550037 hmf

      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY

      ON ACTION first
         CALL t800_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No:FUN-530067 HCN TEST


      ON ACTION previous
         CALL t800_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No:FUN-530067 HCN TEST


      ON ACTION jump
         CALL t800_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No:FUN-530067 HCN TEST


      ON ACTION next
         CALL t800_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No:FUN-530067 HCN TEST


      ON ACTION last
         CALL t800_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
	ACCEPT DISPLAY                   #No:FUN-530067 HCN TEST


      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #No:FUN-550037 hmf
         CALL t800_def_form()   #FUN-610006
         #CKP
         IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_oep.oep09  ='1' OR
            g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")
         EXIT DISPLAY

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

#     ON ACTION EasyFlow送簽
      ON ACTION easyflow_approval            #FUN-550031
         LET g_action_choice = "easyflow_approval"
         EXIT DISPLAY

      #-----No:FUN-A50103-----
#@    ON ACTION 訂金多帳期
      ON ACTION deposit_multi_account
         LET g_action_choice="deposit_multi_account"
         EXIT DISPLAY

#@    ON ACTION 尾款多帳期
      ON ACTION balance_multi_account
         LET g_action_choice="balance_multi_account"
         EXIT DISPLAY
      #-----No:FUN-A50103 END-----

#@    ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
#@    ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY
#@    ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
#FUN-D20025--add--str--
#@    ON ACTION 取消作廢
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
#FUN-D20025--add--end--

##FUN-CC0007---add---START
##@    ON ACTION 指定料件特性
#     ON ACTION specify
#        LET g_action_choice="specify"
#        EXIT DISPLAY
##FUN-CC0007---add-----END

#@    ON ACTION 變更發出
      ON ACTION change_release
         LET g_action_choice="change_release"
         EXIT DISPLAY
#@    ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY

      #@ON ACTION 簽核狀況
       ON ACTION approval_status     #MOD-4C0041
         LET g_action_choice="approval_status"
         EXIT DISPLAY

       ON ACTION agree
          LET g_action_choice = 'agree'
          EXIT DISPLAY

       ON ACTION deny
          LET g_action_choice = 'deny'
          EXIT DISPLAY

       ON ACTION modify_flow
          LET g_action_choice = 'modify_flow'
          EXIT DISPLAY

       ON ACTION withdraw
          LET g_action_choice = 'withdraw'
          EXIT DISPLAY

       ON ACTION org_withdraw
          LET g_action_choice = 'org_withdraw'
          EXIT DISPLAY

       ON ACTION phrase
          LET g_action_choice = 'phrase'
          EXIT DISPLAY

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

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION related_document                #No:FUN-6A0020  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION


FUNCTION t800_out()
  DEFINE l_sw      LIKE type_file.chr1,    #No.FUN-680137  VARCHAR(01)
         l_wc      LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(200)
         l_cmd     LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(400)
         l_lang    LIKE type_file.chr1     #No.FUN-680137 VARCHAR(1)

     IF g_oep.oep01 IS NOT NULL AND g_oep.oep01 != ' ' THEN
        CALL s_chen_lang(6,10,g_lang) RETURNING l_lang #BugNo:6715
        CALL cl_confirm('axm-293') RETURNING l_sw
        IF l_sw THEN
           LET l_wc = ' oep01 = ',' "',g_oep.oep01,'" ',
                      ' AND oep02 = ',' "',g_oep.oep02,'" '

         #  LET l_cmd = 'axmr800 ','"',g_today,'"', #FUN-C30085 mark
           #LET l_cmd = 'axmg800 ','"',g_today,'"',  #FUN-C30085 add # mark by lixwz  170914 改为cr报表
           LET l_cmd = 'axmr800 ','"',g_today,'"',   # add by lixwz  170914 改为cr报表
                       ' "" "',l_lang,'" "Y" "" "" ',
                       "'",l_wc clipped,"'",' "3" ' clipped
            CALL cl_cmdrun(l_cmd)
         END IF
     END IF
END FUNCTION

FUNCTION t800_y()
  DEFINE x_oep   RECORD  LIKE oep_file.*
  DEFINE l_cmd  LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(60)
  DEFINE l_cnt   LIKE type_file.num5    #No.FUN-680137 SMALLINT


   IF s_shut(0) THEN RETURN END IF
    IF g_oep.oepconf='Y' THEN  CALL cl_err('','9023',0) RETURN END IF  #己確認   #MOD-540061
   IF g_oep.oep01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_oep.oepconf = 'X' THEN CALL cl_err(g_oep.oep01,'9024',0) RETURN END IF
   IF g_oep.oepmksg='Y'   THEN                #FUN-550031
      IF g_oep.oep09 != '1' THEN CALL cl_err('','aws-078',1) RETURN END IF
   END IF

   LET g_cnt=0

   SELECT COUNT(*) INTO g_cnt
     FROM oeb_file,oeq_file
    WHERE oeb01=g_oep.oep01
      AND oeb70='Y'
      AND oeb01=oeq01
      AND oeb03=oeq03
      AND oeq02=g_oep.oep02 #BugNo:4348

   IF g_cnt>0 THEN       #已結案
      CALL cl_err('','aap-730',0)
      RETURN
   END IF

   IF NOT cl_confirm('axm-108') THEN RETURN END IF

   LET g_success = 'Y'

   BEGIN WORK

    OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
    IF STATUS THEN
       CALL cl_err("OPEN t800_cl:", STATUS, 1)
       CLOSE t800_cl
       ROLLBACK WORK
       RETURN
    END IF

    FETCH t800_cl INTO g_oep.*            # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      # 資料被他人LOCK
        CLOSE t800_cl ROLLBACK WORK RETURN
    END IF
#....更改訂單變更單單頭:未確認--->已確認
     UPDATE oep_file SET oepconf = 'Y'
      WHERE oep01 = g_oep.oep01  # 訂單單號
        AND oep02 = g_oep.oep02  # 變更序號
         IF SQLCA.SQLERRD[3] = 0 THEN
            LET g_success = 'N'
            CALL cl_err('(axmt800:ckp#1.1)','mfg9328',1)
         ELSE
            IF g_oep.oepmksg = 'N'  THEN      #不須簽核-->核淮
               UPDATE oep_file SET oep09 = '1'
                WHERE oep01 = g_oep.oep01  # 訂單單號
                  AND oep02 = g_oep.oep02  # 變更序號
               IF SQLCA.SQLERRD[3] = 0 THEN
                  LET g_success = 'N'
                  CALL cl_err('(axmt800:ckp#1.1)','mfg9328',1)
               ELSE
                  LET g_oep.oep09 = '1'
               END IF
            END IF
         END IF
   IF g_success = 'Y' THEN
      IF g_success = 'Y' THEN
         COMMIT WORK
         LET g_oep.oepconf='Y'
         DISPLAY BY NAME g_oep.oep09,g_oep.oepconf
         CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg) #顯示目前狀態
                        RETURNING g_sta
         DISPLAY g_sta TO FORMONLY.desc
      ELSE
         LET g_oep.oepconf='N'
         ROLLBACK WORK
      END IF
   ELSE
      ROLLBACK WORK
   END IF

   SELECT oepconf INTO g_oep.oepconf FROM oep_file
    WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
   DISPLAY BY NAME g_oep.oepconf
    #CKP
    IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_oep.oep09  ='1' OR
       g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

END FUNCTION

FUNCTION t800_y_chk()
   DEFINE x_oep   RECORD  LIKE oep_file.*
   DEFINE l_cmd  LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(60)
   DEFINE l_oeb28 LIKE type_file.num5    #No.FUN-680137 SMALLINT            #NO.FUN-670007
   DEFINE l_oeb27 LIKE oeb_file.oeb27 #NO.FUN-670007
   DEFINE l_msg   LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(500)           #NO.FUN-670007
   DEFINE l_chr   LIKE oay_file.oayslip  #No.FUN-680137 VARCHAR(5)             #NO.FUN-670007
   DEFINE l_ogb12 LIKE ogb_file.ogb12
   DEFINE l_oeb12         LIKE oeb_file.oeb12,
          l_oeb23         LIKE oeb_file.oeb23,
          l_oeb03         LIKE oeb_file.oeb03,
          l_oea01         LIKE oea_file.oea01,
          l_oeq03         LIKE oeq_file.oeq03,
          l_oeq12a        LIKE oeq_file.oeq12a
   DEFINE l_dbs_new       LIKE type_file.chr21  #New DataBase Name
   DEFINE l_azp03         LIKE azp_file.azp03
   DEFINE l_last          LIKE type_file.num5
   DEFINE l_last_plant    LIKE cre_file.cre08
   DEFINE l_oea904        LIKE oea_file.oea904
   DEFINE l_poz011        LIKE poz_file.poz011
   DEFINE #l_sql          LIKE type_file.chr1000
          l_sql           STRING     #NO.FUN-910082
   DEFINE l_msg2          LIKE ze_file.ze03    #FUN-890128
   DEFINE l_cnt2          LIKE type_file.num5   #MOD-910035
   DEFINE l_oea15         LIKE oea_file.oea15   #MOD-920057
   DEFINE l_oea213        LIKE oea_file.oea213  #TQC-AB0152 add
   DEFINE l_oea211        LIKE oea_file.oea211  #TQC-AB0152 add
   DEFINE l_oeq13a        LIKE oeq_file.oeq13a  #TQC-AB0152 add
   DEFINE l_oeq13b        LIKE oeq_file.oeq13b  #TQC-AB0152 add
   DEFINE l_oeq12b        LIKE oeq_file.oeq12b  #TQC-AB0152 add
   DEFINE l_oea23         LIKE oea_file.oea23   #TQC-AB0152 add
   DEFINE l_oeb930        LIKE oeb_file.oeb930  #MOD-920057
   DEFINE l_dbs_tra       LIKE azw_file.azw05        #FUN-980093 add
   DEFINE l_plant_new     LIKE azp_file.azp01        #FUN-980093 add
   #-----No:FUN-A50103-----
   DEFINE l_cnt3          LIKE type_file.num5
   DEFINE l_oea RECORD LIKE oea_file.*
   DEFINE l_oeq14tot      LIKE oeq_file.oeq14b   #變更後單身金額總和
   DEFINE l_oeq14a        LIKE oeq_file.oeq14a   #變更後單身未稅金額
   DEFINE l_oeq14ta       LIKE oeq_file.oeq14ta  #變更後單身含稅金額
   DEFINE l_oeb14         LIKE oeb_file.oeb14    #原訂單單身未稅金額
   DEFINE l_oeb14t        LIKE oeb_file.oeb14t   #原訂單單身含稅金額
   DEFINE l_oeptot        LIKE oea_file.oea61    #變更後單頭訂金/出貨/尾款金額加總
   DEFINE l_oma54         LIKE oma_file.oma54    #已立帳金額
   DEFINE l_oepa02        LIKE oepa_file.oepa02
   DEFINE l_oepa03        LIKE oepa_file.oepa03
   DEFINE l_cnt           LIKE type_file.num5
   DEFINE l_oepa08tot     LIKE oepa_file.oepa08a #變更後多帳期金額總和
   DEFINE l_oeaa08        LIKE oeaa_file.oeaa08  #原訂單多帳期金額
   DEFINE l_oepa08        LIKE oepa_file.oepa08a #變更後多帳期金額
   #-----No:FUN-A50103 END-----
   DEFINE l_oeq27a        LIKE oeq_file.oeq27a  #MOD-BC0120 add
   DEFINE l_oeq27b        LIKE oeq_file.oeq27b  #MOD-BC0120 add
   DEFINE l_term          LIKE oep_file.oep10   #FUN-C40089
   DEFINE l_oeq05         LIKE oeq_file.oeq05a  #MOD-D10014 add
   DEFINE l_oeq05a        LIKE oeq_file.oeq05a  #MOD-D10014 add
   DEFINE l_oeq05b        LIKE oeq_file.oeq05b  #MOD-D10014 add
   DEFINE l_oeq04a        LIKE oeq_file.oeq04a
   DEFINE l_oeq04b        LIKE oeq_file.oeq04b
   DEFINE l_oeq03_s         LIKE oeq_file.oeq03,
          l_oeq04a_s        LIKE oeq_file.oeq04a,
          l_oeq04b_s        LIKE oeq_file.oeq04b,
          l_oeq22a_s        LIKE oeq_file.oeq22a,
          l_oeq22b_s        LIKE oeq_file.oeq22b,
          l_ta_oeq09a_s        LIKE oeq_file.ta_oeq09a,
          l_ta_oeq09b_s        LIKE oeq_file.ta_oeq09b,
          l_cnt_s               LIKE type_file.num5

   LET g_success = 'Y'
   IF s_shut(0) THEN
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF
#CHI-C30107 -------------------- add --------------- begin
   IF g_oep.oepconf='Y' THEN
      CALL cl_err('','9023',0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF  #己確認 #MOD-540061

   IF g_oep.oep01 IS NULL THEN
      CALL cl_err('',-400,0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF

   IF g_oep.oepconf = 'X' THEN
      CALL cl_err(g_oep.oep01,'9024',0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF
   IF g_action_choice CLIPPED = "confirm" THEN
     IF NOT cl_confirm('axm-108') THEN LET g_success = 'N' RETURN END IF
   END IF
   SELECT * INTO g_oep.* FROM oep_file WHERE oep01 = g_oep.oep01
                                         AND oep02 = g_oep.oep02
#CHI-C30107 -------------------- add --------------- end
   IF g_oep.oepconf='Y' THEN
      CALL cl_err('','9023',0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF  #己確認 #MOD-540061

   IF g_oep.oep01 IS NULL THEN
      CALL cl_err('',-400,0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF

   IF g_oep.oepconf = 'X' THEN
      CALL cl_err(g_oep.oep01,'9024',0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF

   #FUN-C40089---begin
   LET l_term=g_oep.oep10b
   IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF
   SELECT oah08 INTO g_oah08 FROM oah_file WHERE oah01=l_term
   IF cl_null(g_oah08) THEN
      LET g_oah08 = 'Y'
   END IF

   LET l_cnt = 0
   IF g_oah08 = 'N' THEN
      SELECT COUNT(*) INTO l_cnt FROM oeq_file
         WHERE oeq01=g_oep.oep01 AND oeq13a=0
      IF l_cnt > 0 THEN
         CALL cl_err('','axm-627',1)  #FUN-C50074
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   #FUN-C40089---end

   SELECT COUNT(*) INTO l_oeb28
     FROM oeb_file
    WHERE oeb01 = g_oep.oep01
      AND oeb28 >0
   IF l_oeb28 >0 THEN
      SELECT oeb27 INTO l_oeb27
        FROM oeb_file
       WHERE oeb01 = g_oep.oep01
      LET l_msg2 = cl_getmsg('axm-542',g_lang)
      CALL cl_msgany(10,20,l_msg2)
   END IF

   LET g_cnt=0

   SELECT COUNT(*) INTO g_cnt
     FROM oeb_file,oeq_file
    WHERE oeb01=g_oep.oep01
      AND oeb70='Y'
      AND oeb01=oeq01
      AND oeb03=oeq03
      AND oeq02=g_oep.oep02 #MODNO:4348

   IF g_cnt>0 THEN       #已結案
      CALL cl_err('','aap-730',0)
      LET g_success = 'N'   #FUN-580113
      RETURN
   END IF

   LET l_cnt2 = 0
   SELECT COUNT(*) INTO l_cnt2 FROM oeq_file
    WHERE oeq01 = g_oep.oep01
      AND oeq02 = g_oep.oep02

   #-----No:FUN-A50103-----
   LET l_cnt3 = 0
   SELECT COUNT(*) INTO l_cnt3
     FROM oepa_file
    WHERE oepa01 = g_oep.oep01
      AND oepa011= g_oep.oep02
   #-----No:FUN-A50103 END-----

   IF cl_null(g_oep.oep06b)
      AND cl_null(g_oep.oep16b)                                #FUN-C40081
      AND cl_null(g_oep.oep25b)                                #FUN-C40080
      AND cl_null(g_oep.oep26b)                                #FUN-C40080
      AND cl_null(g_oep.oep41b)                                #FUN-C20109
      AND cl_null(g_oep.oep07b)
      AND cl_null(g_oep.oep08b)
      AND cl_null(g_oep.oep10b)
      AND cl_null(g_oep.oep11b)
      AND cl_null(g_oep.oep161b) AND cl_null(g_oep.oep261b)    #No:FUN-A50103
      AND cl_null(g_oep.oep162b) AND cl_null(g_oep.oep262b)    #No:FUN-A50103
      AND cl_null(g_oep.oep163b) AND cl_null(g_oep.oep263b)    #No:FUN-A50103
      AND cl_null(g_oep.oep14b) AND cl_null(g_oep.oep15b)      #FUN-A80118 Add
      AND l_cnt2 = 0 AND l_cnt3=0 THEN    #No:FUN-A50103
      CALL cl_err(g_oep.oep01,'apm1020',0)
      LET g_success = 'N'
      RETURN
   END IF

   #songlb 营业下变更单时要判断是否有占库
#   LET l_sql = "SELECT oeq03,oeq04a,oeq04b,oeq22a,oeq22b,ta_oeq09a,ta_oeq09b FROM oeq_file ",
#               " WHERE oeq01 ='", g_oep.oep01,"' ",
#               "   AND oeq02 ='", g_oep.oep02,"' "
#   PREPARE oeq_plb FROM l_sql
#   DECLARE oeq_clb CURSOR FOR oeq_plb#

#   FOREACH oeq_clb INTO l_oeq03_s,l_oeq04a_s,l_oeq04b_s,l_oeq22a_s,l_oeq22b_s,l_ta_oeq09a_s,l_ta_oeq09b_s
#        SELECT count(*) INTO l_cnt_s FROM tc_sfa_file WHERE tc_sfa06=l_oeq04b_s AND tc_sfa01=g_oep.oep01 AND tc_sfa02=l_oeq03_s AND tc_sfa09>0
#        IF l_cnt_s>0 THEN
#            IF NOT cl_null(l_oeq04a_s) AND l_oeq04a_s<>l_oeq04b_s THEN
#                MESSAGE l_oeq03_s,' 该料件生管已占库，请通知生管取消占库！再继续！！'
#                LET g_success = 'N'
#                RETURN
#            END IF
#            IF NOT cl_null(l_oeq22a_s) AND l_oeq22a_s<>l_oeq22b_s THEN
#                MESSAGE l_oeq03_s,' 该料件生管已占库，请通知生管取消占库！再继续！！'
#                LET g_success = 'N'
#                RETURN
#            END IF
#            IF NOT cl_null(l_ta_oeq09a_s) AND l_ta_oeq09a_s<>l_ta_oeq09b_s THEN
#                MESSAGE l_oeq03_s,' 该料件生管已占库，请通知生管取消占库！再继续！！'
#                LET g_success = 'N'
#                RETURN
#            END IF
#        END IF
#   END FOREACH


   LET l_sql = "SELECT oeq12a,oeq03 FROM oeq_file ",
               " WHERE oeq01 ='", g_oep.oep01,"' ",
               "   AND oeq02 ='", g_oep.oep02,"' "
   PREPARE oeq_p10 FROM l_sql
   DECLARE oeq_c10 CURSOR FOR oeq_p10

   FOREACH oeq_c10 INTO l_oeq12a,l_oeq03
      IF g_aaz.aaz90 = 'Y' THEN
         SELECT oeb930 INTO l_oeb930 FROM oeb_file
                                    WHERE oeb01=g_oep.oep01
                                      AND oeb03=l_oeq03
         IF SQLCA.sqlcode THEN
            SELECT oea15 INTO l_oea15 FROM oea_file
             WHERE oea01 = g_oep.oep01
            LET l_oeb930=s_costcenter(l_oea15)
            IF cl_null(l_oeb930) THEN
               CALL cl_err(l_oea15,'axm1010',0)
               LET g_success = 'N'
               RETURN
            END IF
         END IF
      END IF

      IF NOT cl_null(l_oeq12a) THEN
         SELECT oea904 INTO l_oea904 FROM oea_file WHERE oea01=g_oep.oep01
         SELECT poz011 INTo l_poz011 FROM poz_file WHERE poz01=l_oea904
            AND poz00='1'
         SELECT MAX(poy02) INTO l_last FROM poy_file WHERE poy01=l_oea904
         SELECT poy04 INTO l_last_plant FROM poy_file
          WHERE poy01 = l_oea904  AND poy02 = l_last
         SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=l_last_plant
         IF l_poz011='2' THEN
            LET l_dbs_new = l_azp03 CLIPPED,"."
            LET g_plant_new = l_last_plant
            LET l_plant_new = g_plant_new
            CALL s_getdbs()
            LET l_dbs_new = g_dbs_new
            CALL s_gettrandbs()
            LET l_dbs_tra = g_dbs_tra

            SELECT oea99 INTO g_oea.oea99 FROM oea_file
             WHERE oea01=g_oep.oep01

            LET l_sql  = "SELECT  oea01 ",
                         #"  FROM ",l_dbs_tra CLIPPED,"oea_file ", #FUN-980093 add
                         "  FROM ",cl_get_target_table(l_plant_new,'oea_file'), #FUN-A50102
                         " WHERE oea99='",g_oea.oea99,"' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
            CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
            PREPARE oea_p11 FROM l_sql
            DECLARE oea_c11 CURSOR FOR oea_p11
            OPEN oea_c11
            FETCH oea_c11 INTO l_oea01
            CLOSE oea_c11
         ELSE
            LET l_dbs_new =null
            LET g_plant_new = g_plant
            LET l_plant_new = g_plant_new
            CALL s_getdbs()
            LET l_dbs_new = g_dbs_new
            CALL s_gettrandbs()
            LET l_dbs_tra = g_dbs_tra
            LET l_oea01 =g_oep.oep01
         END IF

         LET l_sql  = "SELECT  oeb24-oeb25,oeb23,oeb03 ",
                      #"  FROM ",l_dbs_tra CLIPPED,"oeb_file ",  #FUN-980093 add
                      "  FROM ",cl_get_target_table(l_plant_new,'oeb_file'), #FUN-A50102
                      " WHERE oeb01= '",l_oea01,"' ",
                      "   AND oeb03= '",l_oeq03,"' "

         CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
         CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
         PREPARE oea_p12 FROM l_sql
         DECLARE oea_c12 CURSOR FOR oea_p12
         OPEN oea_c12
         LET l_oeb12 = 0   #MOD-920030
         LET l_oeb23 = 0   #MOD-920030
         LET l_oeb03 = NULL   #MOD-920030
         FETCH oea_c12 INTO l_oeb12,l_oeb23,l_oeb03
         CLOSE oea_c12
         #-----MOD-B60008---------
         #IF l_oeb23 > l_oeq12a  THEN
         #   CALL cl_err(l_dbs_tra,'axm-814',1) #FUN-980093 add
         #   LET g_success = 'N'
         #   RETURN
         #ELSE
         #  LET l_ogb12 = 0                            #MOD-940401 add
         #  SELECT SUM(ogb12) INTO l_ogb12 FROM ogb_file,oga_file
         #   WHERE ogb31 =l_oea01
         #     AND ogb32 =l_oeq03
         #     AND oga01 =ogb01
         #      AND ogaconf ='N'
         #  IF cl_null(l_ogb12) THEN
         #     LET l_ogb12 =0
         #  END IF
         #  IF l_oeb12 + l_ogb12> l_oeq12a  THEN
         #     CALL cl_err(l_dbs_tra,'axm-801',1) #FUN-980093 add
         #     LET g_success = 'N'
         #     RETURN
         #  END IF
         #END IF
         IF l_oeb12 + l_oeb23 > l_oeq12a THEN
            CALL cl_err(l_dbs_tra,'axm0007',1)
            LET g_success = 'N'
            RETURN
         END IF
         #-----END MOD-B60008-----
      END IF
   END FOREACH

   #-----No:FUN-A50103-----
   SELECT * INTO l_oea.* FROM oea_file WHERE oea01 = g_oep.oep01

   #檢查訂金+出貨+尾款比率是否等於100
   LET l_oeptot = 0
   IF cl_null(g_oep.oep161b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea161
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep161b
   END IF

   IF cl_null(g_oep.oep162b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea162
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep162b
   END IF

   IF cl_null(g_oep.oep163b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea163
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep163b
   END IF

   IF l_oeptot <> 100 THEN
      CALL cl_err(g_oep.oep01,'axm-263',1)
      LET g_success = 'N'
      RETURN
   END IF

   #檢查訂金+出貨+尾款是否大於訂單金額
   DECLARE t800_oeq_chk CURSOR FOR SELECT oeq03,oeq14a,oeq14ta
                                     FROM oeq_file
                                    WHERE oeq01 = g_oep.oep01
                                      AND oeq02 = g_oep.oep02
                                    ORDER BY oeq03

   IF l_oea.oea213 = 'Y' THEN
      LET l_oeq14tot = l_oea.oea1008
   ELSE
      LET l_oeq14tot = l_oea.oea61
   END IF

   FOREACH t800_oeq_chk INTO l_oeq03,l_oeq14a,l_oeq14ta
      SELECT oeb14,oeb14t INTO l_oeb14,l_oeb14t
        FROM oeb_file
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = l_oeq03
      IF STATUS THEN
         LET l_oeb14 = 0
         LET l_oeb14t = 0
      END IF

      #---TQC-AB0152---   begin
      #SELECT oeq12a,oeq13a,oeq12b,oeq13b INTO l_oeq12a,l_oeq13a,l_oeq12b,l_oeq13b FROM oeq_file #MOD-D10014 mark
      SELECT oeq12a,oeq13a,oeq12b,oeq13b,oeq05a,oeq05b INTO l_oeq12a,l_oeq13a,l_oeq12b,l_oeq13b,l_oeq05a,l_oeq05b FROM oeq_file #MOD-D10014 add
       WHERE oeq01 = g_oep.oep01 AND oeq02 = g_oep.oep02
         AND oeq03 = l_oeq03

      #MOD-BC0120 ----- modify start -----
      IF g_sma.sma116 MATCHES '[23]' THEN
         IF cl_null(l_oeq27a) THEN
            LET l_oeq12a = l_oeq27b
         ELSE
            LET l_oeq12a = l_oeq27a
         END IF
         IF cl_null(l_oeq13a) THEN
            LET l_oeq13a = l_oeq13b
         END IF
      ELSE
      #MOD-BC0120 ----- modify end -----
         IF cl_null(l_oeq12a) OR cl_null(l_oeq13a) THEN
            IF cl_null(l_oeq12a) THEN
               LET l_oeq12a = l_oeq12b
               #LET l_oeq12a = s_digqty(l_oeq12a,g_oeq[l_ac].oeq05a)  #FUN-910088--add-- #MOD-D10014 mark
               #MOD-D10014 add start -----
               LET l_oeq05 = l_oeq05a
               IF cl_null(l_oeq05) THEN
                  LET l_oeq05 = l_oeq05b
               END IF
               LET l_oeq12a = s_digqty(l_oeq12a,l_oeq05)
               #MOD-D10014 add end   -----
            END IF
            IF cl_null(l_oeq13a) THEN
               LET l_oeq13a = l_oeq13b
            END IF
         END IF
      END IF     #MOD-BC0120 add

      LET l_oea23 = g_oep.oep08
      IF NOT cl_null(g_oep.oep08b) THEN
         LET l_oea23 = g_oep.oep08b
      END IF
      SELECT azi03,azi04 INTO t_azi03,t_azi04
       FROM azi_file
      WHERE azi01=l_oea23

      LET l_oeq14a=t800_amount(l_oeq12a,l_oeq13a,g_oeb1006,t_azi03)
      SELECT oea213,oea211 INTO l_oea213,l_oea211
              FROM oea_file WHERE oea01 = g_oep.oep01
      IF NOT cl_null(l_oeq13a) THEN
           CALL cl_digcut(l_oeq13a,t_azi03)
                RETURNING l_oeq13a
      END IF
     # IF g_oeb1012 = 'N' THEN
         IF l_oea213 = 'N' THEN # 不內含
            LET l_oeq14a=t800_amount(l_oeq12a,l_oeq13a,g_oeb1006,t_azi03)
            LET l_oeq14a=cl_digcut(l_oeq14a,t_azi04)
            LET l_oeq14ta=cl_digcut(l_oeq14a*(1+l_oea211/100),t_azi04)
         ELSE
            LET l_oeq14ta=t800_amount(l_oeq12a,l_oeq13a,g_oeb1006,t_azi03)
            LET l_oeq14ta=cl_digcut(l_oeq14ta,t_azi04)
            LET l_oeq14a=cl_digcut(l_oeq14ta/(1+l_oea211/100),t_azi04)
         END IF
     # ELSE
     #    LET l_oeq14a = 0
     #    LET l_oeq14ta = 0
     # END IF
     #---TQC-AB0152---   end

      #金額總合=原訂單金額-原單身金額+新單身金額
      IF l_oea.oea213 = 'Y' THEN
         LET l_oeq14tot = l_oeq14tot - l_oeb14t + l_oeq14ta
      ELSE
         LET l_oeq14tot = l_oeq14tot - l_oeb14  + l_oeq14a
      END IF
   END FOREACH

#MOD-B80192 -- mark begin --
#MOD-B40079 --begin--
#  IF cl_null(g_oep.oep161b) AND cl_null(g_oep.oep162b) AND cl_null(g_oep.oep163b) THEN
#     LET g_oep.oep161b = g_oep.oep161
#     LET g_oep.oep162b = g_oep.oep162
#     LET g_oep.oep163b = g_oep.oep163
#  ELSE
# 	 IF g_oep.oep161b + g_oep.oep162b + g_oep.oep163b <> 100 THEN
# 	    CALL cl_err('','axm-347',0)
# 	    RETURN
# 	 END IF
#  END IF
#  LET g_oep.oep261b = l_oeq14tot*g_oep.oep161b/100
#  LET g_oep.oep262b = l_oeq14tot*g_oep.oep162b/100
#  LET g_oep.oep263b = l_oeq14tot*g_oep.oep163b/100
#  UPDATE oep_file SET oep.* = g_oep.*
#   WHERE oep01 = g_oep.oep01
#     AND oep02 = g_oep.oep02
#  DISPLAY BY NAME g_oep.oep161b,g_oep.oep162b,g_oep.oep163b,
#                  g_oep.oep261b,g_oep.oep262b,g_oep.oep263b
#MOD-B40079 --end--
#MOD-B80192 -- mark end --

   LET l_oeptot = 0

   IF cl_null(g_oep.oep261b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea261
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep261b
   END IF

   IF cl_null(g_oep.oep262b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea262
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep262b
   END IF

   IF cl_null(g_oep.oep263b) THEN
      LET l_oeptot = l_oeptot + l_oea.oea263
   ELSE
      LET l_oeptot = l_oeptot + g_oep.oep263b
   END IF

   IF l_oeq14tot <> l_oeptot THEN
#MOD-B80192 -- begin --
      IF cl_confirm('axm-497') THEN
         IF cl_null(g_oep.oep161b) AND cl_null(g_oep.oep162b) AND cl_null(g_oep.oep163b) THEN
            LET g_oep.oep161b = g_oep.oep161
            LET g_oep.oep162b = g_oep.oep162
            LET g_oep.oep163b = g_oep.oep163
         ELSE
            IF g_oep.oep161b + g_oep.oep162b + g_oep.oep163b <> 100 THEN
               CALL cl_err('','axm-347',0)
               RETURN
            END IF
         END IF
         #MOD-BA0087 add --start--
         LET l_oea23 = g_oep.oep08
         IF NOT cl_null(g_oep.oep08b) THEN LET l_oea23 = g_oep.oep08b END IF
         SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=l_oea23
         #MOD-BA0087 add --end--
         LET g_oep.oep261b = l_oeq14tot*g_oep.oep161b/100
         CALL cl_digcut(g_oep.oep261b,t_azi04)  RETURNING g_oep.oep261b #MOD-BA0087 add
         LET g_oep.oep262b = l_oeq14tot*g_oep.oep162b/100
         CALL cl_digcut(g_oep.oep262b,t_azi04)  RETURNING g_oep.oep262b #MOD-BA0087 add
         LET g_oep.oep263b = l_oeq14tot*g_oep.oep163b/100
         CALL cl_digcut(g_oep.oep263b,t_azi04)  RETURNING g_oep.oep263b #MOD-BA0087 add
         UPDATE oep_file SET oep.* = g_oep.*
            WHERE oep01 = g_oep.oep01
              AND oep02 = g_oep.oep02
         DISPLAY BY NAME g_oep.oep161b,g_oep.oep162b,g_oep.oep163b,
                         g_oep.oep261b,g_oep.oep262b,g_oep.oep263b
      ELSE
#MOD-B80192 -- end --
         CALL cl_err(g_oep.oep01,'axm-967',1)
         LET g_success = 'N'
         RETURN
      END IF   #MOD-B80192 add
   END IF

   #檢查訂金金額是否大於已立帳金額
   IF NOT cl_null(g_oep.oep261b) THEN
      IF l_oea.oea213 = 'Y' THEN
         SELECT SUM(oma54t) INTO l_oma54 FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma00 = '11'
           #AND omaconf <> 'X'  #MOD-CB0025 mark
            AND omavoid <> 'Y'  #MOD-CB0025 add
      ELSE
         SELECT SUM(oma54) INTO l_oma54 FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma00 = '11'
           #AND omaconf <> 'X'  #MOD-CB0025 mark
            AND omavoid <> 'Y'  #MOD-CB0025 add
      END IF

      IF g_oep.oep261b < l_oma54 THEN
         CALL cl_err(g_oep.oep261,'axm-964',1)
         LET g_success = 'N'
         RETURN
      END IF
   END IF

   #檢查出貨金額是否大於已立帳金額
   IF NOT cl_null(g_oep.oep262b) THEN
      IF l_oea.oea213 = 'Y' THEN
         SELECT SUM(oma54t) INTO l_oma54 FROM oma_file
          WHERE oma19 = g_oep.oep01
            AND oma00 = '12'
           #AND omaconf <> 'X'  #MOD-CB0025 marl
            AND omavoid <> 'Y'  #MOD-CB0025 add
      ELSE
         SELECT SUM(oma54) INTO l_oma54 FROM oma_file
          WHERE oma19 = g_oep.oep01
            AND oma00 = '12'
           #AND omaconf <> 'X'  #MOD-CB0025 mark
            AND omavoid <> 'Y'  #MOD-CB0025 add
      END IF

      IF g_oep.oep262b < l_oma54 THEN
         CALL cl_err(g_oep.oep262,'axm-965',1)
         LET g_success = 'N'
         RETURN
      END IF
   END IF

   #檢查尾款金額是否大於已立帳金額
   IF NOT cl_null(g_oep.oep263b) THEN
      IF l_oea.oea213 = 'Y' THEN
         SELECT SUM(oma54t) INTO l_oma54 FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma00 = '13'
           #AND omaconf <> 'X'  #MOD-CB0025 mark
            AND omavoid <> 'Y'  #MOD-CB0025 add
      ELSE
         SELECT SUM(oma54) INTO l_oma54 FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma00 = '13'
           #AND omaconf <> 'X'  #MOD-CB0025 mark
            AND omavoid <> 'Y'  #MOD-CB0025 add
      END IF

      IF g_oep.oep263b < l_oma54 THEN
         CALL cl_err(g_oep.oep263,'axm-966',1)
         LET g_success = 'N'
         RETURN
      END IF
   END IF

   #檢查多帳期資料是否已立帳
   DECLARE t800_oepa_chk1 CURSOR FOR SELECT oepa02,oepa03
                                       FROM oepa_file
                                      WHERE oepa01 = g_oep.oep01
                                        AND oepa011= g_oep.oep02
                                      ORDER BY oepa02,oepa03

   FOREACH t800_oepa_chk1 INTO l_oepa02,l_oepa03
      IF l_oepa02 = '1' THEN
         SELECT COUNT(*) INTO l_cnt FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma165= l_oepa03
            AND oma00 = '11'
            AND omavoid <> 'Y' #MOD-CB0279 add
         IF l_cnt > 0 THEN
            CALL cl_err(l_oepa03,'axm-963',1)
            LET g_success = 'N'
            RETURN
         END IF
      ELSE
         SELECT COUNT(*) INTO l_cnt FROM oma_file
          WHERE oma16 = g_oep.oep01
            AND oma165= l_oepa03
            AND oma00 = '13'
            AND omavoid <> 'Y' #MOD-CB0279 add
         IF l_cnt > 0 THEN
            CALL cl_err(l_oepa03,'axm-963',1)
            LET g_success = 'N'
            RETURN
         END IF
      END IF
   END FOREACH


   #檢查訂金多帳期資料與單頭訂金金額是否相符
   DECLARE t800_oepa_11chk CURSOR FOR SELECT oepa03,oepa08a
                                        FROM oepa_file
                                       WHERE oepa01 = g_oep.oep01
                                         AND oepa011= g_oep.oep02
                                         AND oepa02 = 1
                                       ORDER BY oepa03
  #MOD-D40009 mark start -----
  #LET l_oepa08tot = l_oea.oea261
  ##TQC-B80053 add begin--------------------------
  #IF g_oep.oep261b = 0 AND g_oep.oep261 != 0 THEN
  #   LET l_oepa08tot = g_oep.oep261b
  #END IF
  ##TQC-B80053 add  end---------------------------
  #MOD-D40009 mark end   -----
   LET l_oepa08tot = 0 #MOD-D40009 add

   FOREACH t800_oepa_11chk INTO l_oepa03,l_oepa08
      SELECT oeaa08 INTO l_oeaa08 FROM oeaa_file
       WHERE oeaa01 = g_oep.oep01
         AND oeaa02 = '1'
         AND oeaa03 = l_oepa03
      IF STATUS THEN
         LET l_oeaa08 = 0
      END IF

      #多帳期總合=原訂金金額-原帳期金額+新帳期金額
      LET l_oepa08tot = l_oepa08tot - l_oeaa08 + l_oepa08

   END FOREACH

   IF NOT cl_null(l_oepa08tot) AND l_oepa08tot != 0 THEN #MOD-D40009 add
      IF cl_null(g_oep.oep261b) THEN
         IF l_oea.oea261 <> l_oepa08tot THEN
            CALL cl_err(l_oea.oea261,'axm-961',1)
            LET g_success = 'N'
            RETURN
         END IF
      ELSE
         IF g_oep.oep261b <> l_oepa08tot THEN
            CALL cl_err(g_oep.oep261b,'axm-961',1)
            LET g_success = 'N'
            RETURN
         END IF
      END IF
   END IF #MOD-D40009 add

   #檢查尾款多帳期資料與單頭尾款金額是否相符
   DECLARE t800_oepa_13chk CURSOR FOR SELECT oepa03,oepa08a
                                        FROM oepa_file
                                       WHERE oepa01 = g_oep.oep01
                                         AND oepa011= g_oep.oep02
                                         AND oepa02 = 2
                                       ORDER BY oepa03

  #MOD-D40009 mark start -----
  #LET l_oepa08tot = l_oea.oea263
  ##TQC-B80053 add begin--------------------------
  #IF g_oep.oep263b = 0 AND g_oep.oep263 != 0 THEN
  #   LET l_oepa08tot = g_oep.oep263b
  #END IF
  ##TQC-B80053 add  end---------------------------
  #MOD-D40009 mark end  -----
   LET l_oepa08tot = 0 #MOD-D40009 add

   FOREACH t800_oepa_13chk INTO l_oepa03,l_oepa08
      SELECT oeaa08 INTO l_oeaa08 FROM oeaa_file
       WHERE oeaa01 = g_oep.oep01
         AND oeaa02 = '2'
         AND oeaa03 = l_oepa03
      IF STATUS THEN
         LET l_oeaa08 = 0
      END IF

      #多帳期總合=原訂金金額-原帳期金額+新帳期金額
      LET l_oepa08tot = l_oepa08tot - l_oeaa08 + l_oepa08

   END FOREACH

   IF NOT cl_null(l_oepa08tot) AND l_oepa08tot != 0 THEN #MOD-D40009 add
      IF cl_null(g_oep.oep263b) THEN
         IF l_oea.oea263 <> l_oepa08tot THEN
            CALL cl_err(l_oea.oea263,'axm-961',1)
            LET g_success = 'N'
            RETURN
         END IF
      ELSE
         IF g_oep.oep263b <> l_oepa08tot THEN
            CALL cl_err(g_oep.oep263b,'axm-961',1)
            LET g_success = 'N'
            RETURN
         END IF
      END IF
   END IF #MOD-D40009 add
   #-----No:FUN-A50103 END-----
   #add by donghy 151020 料号存在变更则检查变更前料号是否存在占库
   #add by songlb 160106 先去掉此控制
#   DECLARE t800_oeq_zhanku CURSOR FOR SELECT oeq03,oeq04a,oeq04b
#                                     FROM oeq_file
#                                    WHERE oeq01 = g_oep.oep01
##                                      AND oeq02 = g_oep.oep02
#                                    ORDER BY oeq03
#   FOREACH t800_oeq_zhanku INTO l_oeq03,l_oeq04a,l_oeq04b
#     IF NOT cl_null(l_oeq04a) AND l_oeq04a !=l_oeq04b THEN
#        IF NOT cl_null(l_oeq04b) THEN
#           SELECT COUNT(*) INTO l_cnt FROM tc_sic_file WHERE tc_sic01=l_oeq04b
#              AND tc_sic02=g_oep.oep01 AND tc_sic03=l_oeq03
#           IF g_cnt > 0 THEN
#               CALL cl_err(l_oeq04b,'cxm-019',1)
#               LET g_success = 'N'
#               RETURN
#           END IF
#        END IF
#     END IF
#   END FOREACH

END FUNCTION

FUNCTION t800_y_upd()
# DEFINE l_oia07  LIKE oia_file.oia07   #FUN-C50136--add--
# DEFINE l_oea03  LIKE oea_file.oea03   #FUN-C50136--add--

 LET g_success = 'Y'
 IF g_action_choice CLIPPED = "confirm" THEN   #按「確認」時
    IF g_oep.oepmksg='Y' THEN
       IF g_oep.oep09 != '1' THEN
          CALL cl_err('','aws-078',1)
          LET g_success = 'N'
          RETURN
       END IF
    END IF
#   IF NOT cl_confirm('axm-108') THEN RETURN END IF #CHI-C30107 mark
 END IF

 BEGIN WORK

 OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
 IF STATUS THEN
    CALL cl_err("OPEN t800_cl:", STATUS, 1)
    CLOSE t800_cl
    ROLLBACK WORK
    RETURN
 END IF

 FETCH t800_cl INTO g_oep.*            # 鎖住將被更改或取消的資料
 IF SQLCA.sqlcode THEN
     CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      # 資料被他人LOCK
     CLOSE t800_cl ROLLBACK WORK RETURN
 END IF
#....更改訂單變更單單頭:未確認--->已確認
 UPDATE oep_file SET oepconf = 'Y'
  WHERE oep01 = g_oep.oep01  # 訂單單號
    AND oep02 = g_oep.oep02  # 變更序號
 IF SQLCA.SQLERRD[3] = 0 THEN
    LET g_success = 'N'
    CALL cl_err('(axmt800:ckp#1.1)','mfg9328',1)
 ELSE
    IF g_oep.oepmksg = 'N'  THEN      #不須簽核-->核淮
       UPDATE oep_file SET oep09 = '1'
        WHERE oep01 = g_oep.oep01  # 訂單單號
          AND oep02 = g_oep.oep02  # 變更序號
       IF SQLCA.SQLERRD[3] = 0 THEN
          LET g_success = 'N'
          CALL cl_err('(axmt800:ckp#1.1)','mfg9328',1)
       ELSE
          LET g_oep.oep09 = '1'
       END IF
    END IF
 END IF
 IF g_success = 'Y' THEN
    IF g_oep.oepmksg = 'Y' THEN #簽核模式
       CASE aws_efapp_formapproval()            #呼叫 EF 簽核功能
           WHEN 0  #呼叫 EasyFlow 簽核失敗
                LET g_oep.oepconf="N"
                LET g_success = "N"
                ROLLBACK WORK
                RETURN
           WHEN 2  #當最後一關有兩個以上簽核者且此次簽核完成後尚未結案
                LET g_oep.oepconf="N"
                ROLLBACK WORK
                RETURN
       END CASE
    END IF
#FUN-C50136--add--start--
#   SELECT oea03 INTO l_oea03 FROM oea_file
#    WHERE oea01=g_oep.oep01
#   IF g_oaz.oaz96 = 'Y' AND g_success = 'Y' THEN
#      CALL s_ccc_oia07('B',l_oea03) RETURNING l_oia07
#      IF l_oia07 = '0' THEN
#         CALL s_ccc_oia(l_oea03,'B',g_oep.oep01,g_oep.oep02,'')
#      END IF
#   END IF
#FUN-C50136--add--end--

    IF g_success = 'Y' THEN
       LET g_oep.oep09='1'      #執行成功, 狀態值顯示為 '1' 已核准
       UPDATE oep_file SET oep09 = g_oep.oep09
        WHERE oep01=g_oep.oep01 AND oep02 = g_oep.oep02
       IF SQLCA.sqlerrd[3]=0 THEN
          LET g_success='N'
       END IF
       LET g_oep.oepconf='Y'    #執行成功, 確認碼顯示為 'Y' 已確認
       DISPLAY BY NAME g_oep.oep09,g_oep.oepconf
       COMMIT WORK
       CALL cl_flow_notify(g_oep.oep01,'Y') #CHI-A80030 add
    ELSE
       LET g_oep.oepconf='N'
       ROLLBACK WORK
    END IF
 ELSE
    ROLLBACK WORK
 END IF

 SELECT oepconf INTO g_oep.oepconf FROM oep_file
  WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
 DISPLAY BY NAME g_oep.oepconf
  #CKP
 IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
 IF g_oep.oep09  ='1' OR
    g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
 CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

END FUNCTION

FUNCTION t800_z()
   DEFINE x_oep   RECORD LIKE oep_file.*
   DEFINE l_cmd   LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(60)
#  DEFINE l_oia07 LIKE oia_file.oia07    #FUN-C50136--add--
#  DEFINE l_oea03 LIKE oea_file.oea03    #FUN-C50136--add--

   IF s_shut(0) THEN RETURN END IF

   IF g_oep.oep09 = 'S' THEN
      CALL cl_err(g_oep.oep09,'apm-030',1)
      RETURN
   END IF

   IF g_oep.oepconf='N' THEN  RETURN END IF  #未確認

   #已變更發出,不可"取消確認"或"作廢"!!
   IF g_oep.oep09='2' THEN
       CALL cl_err(g_oep.oep01,'axm-015',0)
       RETURN
   END IF

   IF g_oep.oepconf = 'X' THEN CALL cl_err(g_oep.oep01,'9024',0) RETURN END IF

   IF g_oep.oep01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF

   LET g_cnt=0
   SELECT COUNT(*) INTO g_cnt
     FROM oeb_file,oeq_file
    WHERE oeb01=g_oep.oep01 AND oeb70='Y'
      AND oeb01=oeq01 AND oeb03=oeq03
      AND oeq02=g_oep.oep02   #MOD-A20109
   IF g_cnt>0 THEN       #已結案
      CALL cl_err('','aap-730',0)
      RETURN
   END IF

   IF NOT cl_confirm('axm-109') THEN RETURN END IF

   LET g_success = 'Y'

   BEGIN WORK

   OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
   IF STATUS THEN
      CALL cl_err("OPEN t800_cl:", STATUS, 1)
      CLOSE t800_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t800_cl INTO g_oep.*            # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      # 資料被他人LOCK
      CLOSE t800_cl ROLLBACK WORK RETURN
   END IF

   CALL t800_z1()

   #FUN-C50136--add--start--
#  SELECT oea03 INTO l_oea03 FROM oea_file
#   WHERE oea01=g_oep.oep01
#  IF g_oaz.oaz96 = 'Y' AND g_success = 'Y' THEN
#     CALL s_ccc_oia07('B',l_oea03) RETURNING l_oia07
#     IF l_oia07 = '0' THEN
#        CALL s_ccc_rback(l_oea03,'B',g_oep.oep01,g_oep.oep02,'')
#     END IF
#  END IF
   #FUN-C50136--add--end--
   IF g_success = 'Y' THEN
      COMMIT WORK
      LET g_oep.oepconf='N'
      LET g_oep.oep09='0'
      DISPLAY BY NAME g_oep.oepconf,g_oep.oep09
      CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg) #顯示目前狀態
                     RETURNING g_sta
      DISPLAY g_sta TO FORMONLY.desc
   ELSE
      ROLLBACK WORK
   END IF

   SELECT oepconf INTO g_oep.oepconf FROM oep_file
    WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02

   DISPLAY BY NAME g_oep.oepconf

   #CKP
   IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
   IF g_oep.oep09  ='1' OR g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
   CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

END FUNCTION

FUNCTION t800_g()
   DEFINE x_oep   RECORD LIKE oep_file.*
   DEFINE l_cmd   LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(60)

   IF s_shut(0) THEN RETURN END IF
   IF g_oep.oep01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
  #IF g_oep.oep09 != '1' THEN CALL cl_err('oep09 != 1','apm-299',0) RETURN END IF #MOD-540061   #MOD-D20074 mark
   IF g_oep.oep09 != '1' THEN CALL cl_err('oep09 != 1','axm1179',0) RETURN END IF #MOD-D20074 add
   IF g_oep.oepconf != 'Y' THEN CALL cl_err('','mfg3550',0) RETURN END IF  #MOD-550031
   IF g_oep.oepconf = 'X' THEN CALL cl_err(g_oep.oep01,'9024',0) RETURN END IF

   SELECT * INTO x_oep.* FROM oep_file
    WHERE oep01 = g_oep.oep01
      AND oep02 = g_oep.oep02
   IF NOT (x_oep.oepmksg IS NULL OR x_oep.oepmksg='N') AND
      x_oep.oepsseq < x_oep.oepsmax AND x_oep.oep09 = '0' THEN  #送簽中
      CALL cl_err (g_oep.oep01,'axm-175',0)
      RETURN
   END IF

   #No.B061 010417 by linda mod 應check變更之項次是否結案
   LET g_cnt=0

   SELECT COUNT(*) INTO g_cnt
     FROM oeb_file,oeq_file
    WHERE oeb01=g_oep.oep01
      AND oeb70='Y'
      AND oeb01=oeq01
      AND oeb03=oeq03
      AND oeq02=g_oep.oep02 #BugNo:4348
   IF g_cnt>0 THEN       #已結案
      CALL cl_err('','aap-730',0)
      RETURN
   END IF

   IF NOT cl_confirm('axm-181') THEN RETURN END IF

   BEGIN WORK

   LET g_success = 'Y'

   CALL s_showmsg_init()                        #No.FUN-710046

   CALL t800_g1()

   CALL s_showmsg()                            #No.FUN-710046

   IF g_success = 'Y' THEN
      LET g_oep.oep09 = '2'  #MOD-790051 add
      COMMIT WORK
      DISPLAY BY NAME g_oep.oep09
      CALL s_axmsta('oep',g_oep.oep09,g_oep.oepconf,g_oep.oepmksg) #顯示目前狀態
          RETURNING g_sta
      DISPLAY g_sta TO FORMONLY.desc
   ELSE
      ROLLBACK WORK
   END IF

   SELECT oea901,oea99 INTO g_oea901,g_oea.oea99 FROM oea_file  #MOD-740444 add oea99
    WHERE oea01=g_oep.oep01
   IF STATUS THEN
      CALL cl_err('sel oea901:',SQLCA.SQLCODE,0)
      LET g_oea901 = ''
   END IF

   IF g_success = 'Y' THEN                              #MOD-A50049
      #若為三角貿易訂單則重新拋轉
      IF NOT cl_null(g_oea901) AND g_oea901='Y' THEN
         #拋轉至各廠
         LET l_cmd="axmp800 '",g_oep.oep01,"' '",g_oea905,"' "
         CALL cl_cmdrun_wait(l_cmd)   #No:MOD-570401
#        CALL t800_chk_oea06()                         #MOD-A50049
      END IF
   END IF                                              #MOD-A50049

   #CKP
   SELECT oepconf,oep09 INTO g_oep.oepconf,g_oep.oep09 FROM oep_file
    WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02

   DISPLAY BY NAME g_oep.oepconf,g_oep.oep09
   #FUN-CC0094---add---str---
   IF g_oep.oepconf = 'Y' AND g_oep.oep09 = '2' THEN
      LET g_oep.oepsendu = g_user
      LET g_oep.oepsendd = g_today
      LET g_oep.oepsendt = g_time
      UPDATE oep_file SET oepsendu = g_oep.oepsendu,
                          oepsendd = g_oep.oepsendd,
                          oepsendt = g_oep.oepsendt
                    WHERE oep01 = g_oep.oep01
                      AND oep02 = g_oep.oep02
      DISPLAY BY NAME g_oep.oepsendu,g_oep.oepsendd,g_oep.oepsendt
   END IF
   #FUN-CC0094---add---end---
   IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF

   IF g_oep.oep09  ='1' OR
      g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF

   CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")

END FUNCTION

FUNCTION t800_memo()
   DEFINE ls_tmp           STRING
   DEFINE i,j,l_i          LIKE type_file.num5,    #No.FUN-680137 SMALLINT
          l_allow_insert   LIKE type_file.num5,                #可新增否  #No.FUN-680137 SMALLINT
          l_allow_delete   LIKE type_file.num5                 #可刪除否  #No.FUN-680137 SMALLINT
   DEFINE g_oer     DYNAMIC ARRAY OF RECORD
                    oer03               LIKE oer_file.oer03,
                    oer04               LIKE oer_file.oer04
                    END RECORD

   IF g_oep.oep01 IS NULL THEN RETURN END IF


   OPEN WINDOW t800_m_w AT 10,03 WITH FORM "axm/42f/axmt8001"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No:FUN-580092 HCN

    CALL cl_ui_locale("axmt8001")


   DECLARE t800_m_c CURSOR FOR
           SELECT oer03,oer04 FROM oer_file
             WHERE oer01 = g_oep.oep01
               AND oer02 = g_oep.oep02
             ORDER BY oer03
   LET i = 1
   LET l_i = 0
   FOREACH t800_m_c INTO g_oer[i].*
      LET i = i + 1
   END FOREACH
   CALL g_oer.deleteElement(i)
   LET l_i = i - 1
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")

   INPUT ARRAY g_oer WITHOUT DEFAULTS FROM s_oer.*
         ATTRIBUTE(COUNT=l_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW t800_m_w
      RETURN
   END IF

   CLOSE WINDOW t800_m_w

   BEGIN WORK

   LET g_success = 'Y'

   WHILE TRUE
      DELETE FROM oer_file
             WHERE oer01 = g_oep.oep01
               AND oer02 = g_oep.oep02
      IF SQLCA.sqlcode THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oep.oep02       #no.FUN-710046
         CALL s_errmsg("oer01,oer02",g_showmsg,"t800_m(chp#1):",SQLCA.sqlcode,1)  #No.FUN-710046
         EXIT WHILE
      END IF
      FOR i = 1 TO g_oer.getLength()
         IF g_oer[i].oer04 IS NULL THEN CONTINUE FOR END IF
         INSERT INTO oer_file (oer01,oer02,oer03,oer04,oerplant,oerlegal)  #FUN-980010 add plant,legal
                        VALUES(g_oep.oep01,g_oep.oep02,g_oer[i].oer03,
                               g_oer[i].oer04,g_plant,g_legal)  #FUN-980010
         IF SQLCA.sqlcode THEN
            LET g_success = 'N'
            CALL s_errmsg('','',"t800_m(chp#2):",SQLCA.sqlcode,1)  #No.FUN-710046
            CONTINUE FOR   #MOD-940334
         END IF
      END FOR

      EXIT WHILE

   END WHILE
   IF g_success = 'Y' THEN
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF

END FUNCTION

FUNCTION t800_z1()

#..將簽核資料還原,確認碼='N'
   UPDATE oep_file SET oepconf='N',oep09='0',oepsseq=0
    WHERE oep01 = g_oep.oep01 AND oep02=g_oep.oep02
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
      CALL cl_err('z1:upd oep09',SQLCA.SQLCODE,1) LET g_success = 'N' RETURN
  #MOD-A50009---mark---start---
  #ELSE
  #   IF g_oep.oepmksg MATCHES '[Yy]'  THEN
  #      LET g_oep.oepsseq = 0
  #      LET g_oep.oep09 = '0'
  #      LET g_oep.oepconf = 'N'
  #      LET g_key1=g_oep.oep01 CLIPPED,g_oep.oep02 USING '&&' CLIPPED
  #      DELETE FROM azd_file WHERE azd01 = g_key1 AND azd02 = 26
  #      IF STATUS THEN LET g_success = 'N' RETURN
  #      ELSE
  #          CALL s_signx1(6,34,g_lang,'2',g_key1,26,g_oep.oepsign,
  #               g_oep.oepdays,g_oep.oepprit,g_oep.oepsmax,g_oep.oepsseq)
  #      END IF
  #   END IF
  #MOD-A50009---mark---end---
   END IF
END FUNCTION

FUNCTION t800_g1()
   DEFINE l_oeb04        LIKE oeb_file.oeb04,   # 料件編號
          l_sql          LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(900)
   DEFINE l_oeb12        LIKE oeb_file.oeb12,
          l_oeb23        LIKE oeb_file.oeb23,
          l_oeb03        LIKE oeb_file.oeb03,
          l_oea01        LIKE oea_file.oea01,
          l_oeq03        LIKE oeq_file.oeq03,
          l_oeq12a       LIKE oeq_file.oeq12a
   DEFINE l_dbs_new      LIKE type_file.chr21  #New DataBase Name
   DEFINE l_azp03        LIKE azp_file.azp03
   DEFINE l_last         LIKE type_file.num5   #流程之最後家數
   DEFINE l_last_plant   LIKE cre_file.cre08
   DEFINE l_oea904       LIKE oea_file.oea904
   DEFINE l_poz011       LIKE poz_file.poz011
   DEFINE l_cnt          LIKE type_file.num10
   DEFINE l_ogb12        LIKE ogb_file.ogb12   #MOD-880178
   DEFINE l_dbs_tra      LIKE azw_file.azw05        #FUN-980093 add
   DEFINE l_plant_new    LIKE azp_file.azp01        #FUN-980093 add

   IF g_oep.oepconf='N' THEN RETURN   END IF

   LET l_sql = "SELECT oeq12a,oeq03 FROM oeq_file ",
               " WHERE oeq01 ='", g_oep.oep01,"' ",
               "   AND oeq02 ='", g_oep.oep02,"' "
   PREPARE oeq_p7 FROM l_sql
   DECLARE oeq_c7 CURSOR FOR oeq_p7

   FOREACH oeq_c7 INTO l_oeq12a,l_oeq03
      IF NOT cl_null(l_oeq12a) THEN
         SELECT oea904 INTO l_oea904 FROM oea_file WHERE oea01=g_oep.oep01

         SELECT poz011 INTo l_poz011 FROM poz_file WHERE poz01=l_oea904 AND poz00='1'

         SELECT MAX(poy02) INTO l_last FROM poy_file WHERE poy01=l_oea904

         SELECT poy04 INTO l_last_plant FROM poy_file
          WHERE poy01 = l_oea904  AND poy02 = l_last

         SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=l_last_plant

         IF l_poz011='2' THEN
            LET l_dbs_new = l_azp03 CLIPPED,"."
           # FUN-980093 add----GP5.2 Modify #改抓Transaction DB
            LET g_plant_new = l_last_plant
            LET l_plant_new = g_plant_new
            CALL s_getdbs()
            LET l_dbs_new = g_dbs_new
            CALL s_gettrandbs()
            LET l_dbs_tra = g_dbs_tra

            SELECT oea99 INTO g_oea.oea99 FROM oea_file
             WHERE oea01=g_oep.oep01

            LET l_sql  = "SELECT oea01 ",
                         #"  FROM ",l_dbs_new CLIPPED,"oea_file ",
                         "  FROM ",cl_get_target_table(l_plant_new,'oea_file'), #FUN-A50102
                         " WHERE oea99='",g_oea.oea99,"' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
            CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-A50102
            PREPARE oea_p8 FROM l_sql
            DECLARE oea_c8 CURSOR FOR oea_p8
            OPEN oea_c8
            FETCH oea_c8 INTO l_oea01
            CLOSE oea_c8
         ELSE
            LET l_dbs_new =null
           # FUN-980093 add----GP5.2 Modify #改抓Transaction DB
            LET g_plant_new = g_plant
            LET l_plant_new = g_plant_new
            CALL s_getdbs()
            LET l_dbs_new = g_dbs_new
            CALL s_gettrandbs()
            LET l_dbs_tra = g_dbs_tra
            LET l_oea01 =g_oep.oep01
         END IF

         LET l_sql  = "SELECT oeb24-oeb25,oeb23,oeb03 ",
                      #"  FROM ",l_dbs_tra CLIPPED,"oeb_file ", #FUN-980093 add
                      "  FROM ",cl_get_target_table(l_plant_new,'oeb_file'), #FUN-A50102
                      " WHERE oeb01= '",l_oea01,"' ",
                      "   AND oeb03= '",l_oeq03,"' "

         CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
         CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
         PREPARE oea_p9 FROM l_sql
         DECLARE oea_c9 CURSOR FOR oea_p9
         OPEN oea_c9
         LET l_oeb12 = 0   #MOD-8A0245
         LET l_oeb23 = 0   #MOD-8A0245
         LET l_oeb03 = NULL   #MOD-8A0245

         FETCH oea_c9 INTO l_oeb12,l_oeb23,l_oeb03
         CLOSE oea_c9
         #-----MOD-B60008---------
         #IF l_oeb23 > l_oeq12a  THEN
         #   CALL cl_err(l_dbs_tra,'axm-814',1)  #FUN-980093 add
         #   LET g_success = 'N'
         #   RETURN
         #ELSE
         #   LET l_ogb12 = 0                            #MOD-940401 add
         #   SELECT SUM(ogb12) INTO l_ogb12 FROM ogb_file,oga_file
         #    WHERE ogb31 =l_oea01
         #      AND ogb32 =l_oeq03
         #      AND oga01 =ogb01
         #       AND ogaconf ='N'
         #   IF cl_null(l_ogb12) THEN
         #      LET l_ogb12 =0
         #   END IF
         #   IF l_oeb12 + l_ogb12> l_oeq12a  THEN
         #      CALL cl_err(l_dbs_tra,'axm-801',1)  #FUN-980093 add
         #      LET g_success = 'N'
         #      RETURN
         #   END IF
         #END IF
         IF l_oeb12 + l_oeb23 > l_oeq12a THEN
            CALL cl_err(l_dbs_tra,'axm0007',1)
            LET g_success = 'N'
            RETURN
         END IF
         #-----END MOD-B60008-----
      END IF
   END FOREACH

   LET g_up_flag='N'

   #...更改訂單單頭檔 99.01.13 by linda add
   CALL t800_upd_oea1()
   IF g_success='N' THEN RETURN END IF

   #訂單變更發出修改 oea_file後才CALL t800_hu1()

   UPDATE oep_file SET oep09 = '2'    #發出
    WHERE oep01 = g_oep.oep01 AND oep02 = g_oep.oep02
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
      CALL cl_err('g1_upd_oep',SQLCA.SQLCODE,1)
      LET g_success = 'N'
      RETURN
   END IF

   DECLARE t800_cur2 CURSOR FOR                 #bugno:5600 add.......
           SELECT oeq05a,oeq05b,oeq04a,oeq04b,oeq041a,oeq041b,oeq11a,oeq11b,oeq03,oeq12b,oeq12a,     #FUN-C60076 add oeq11a,oeq11b
                  oeq13a,oeq13b,oeq14a,oeq14b,oeq15a,oeq15b,oeq14ta,oeq14tb,                         #MOD-A70005 add oeq14tb
                  oeq23a,oeq23b,oeq24a,oeq24b,oeq25a,oeq25b,oeq20a,oeq20b,
                  oeq21a,oeq21b,oeq22a,oeq22b,oeq26a,oeq26b,oeq27a,oeq27b,
                  oeq28a,oeq28b,oeq29a,oeq29b   #No:FUN-740016
                 ,oeq30a,oeq30b                 #No.FUN-990030
                 ,oeq31a,oeq32a,oeq33a          #FUN-A80118 Add
                 ,oeq37a,oeq37b,                 #FUN-AB0082
                 ta_oeq01a,ta_oeq01b,ta_oeq02a,ta_oeq02b,
                 ta_oeq03a,ta_oeq03b,ta_oeq04a,ta_oeq04b,
                 ta_oeq05a,ta_oeq05b,ta_oeq06a,ta_oeq06b,
                 ta_oeq07a,ta_oeq07b,ta_oeq08a,ta_oeq08b,
                 ta_oeq09a,ta_oeq09b,ta_oeq10a,ta_oeq10b,
                 ta_oeq11a,ta_oeq11b
             FROM oeq_file
            WHERE oeq01 = g_oep.oep01 AND oeq02 = g_oep.oep02

   FOREACH t800_cur2 INTO g_oeq05a,g_oeq05b,g_oeq04a,g_oeq04b,g_oeq041a,
                          g_oeq041b,                                                 #bugno:5644 add.............
                          g_oeq11a,g_oeq11b,                                         #FUN-C60076
                          g_oeq03,g_oeq12b,g_oeq12a,g_oeq13a,g_oeq13b,
                          g_oeq14a,g_oeq14b,g_oeq15a,g_oeq15b,g_oeq14ta,g_oeq14tb,   #MOD-A70005 add g_oeq14tb
                          g_oeq23a,g_oeq23b,g_oeq24a,g_oeq24b,
                          g_oeq25a,g_oeq25b,g_oeq20a,g_oeq20b,
                          g_oeq21a,g_oeq21b,g_oeq22a,g_oeq22b,
                          g_oeq26a,g_oeq26b,g_oeq27a,g_oeq27b,
                          g_oeq28a,g_oeq28b,g_oeq29a,g_oeq29b   #No:FUN-740016
                         ,g_oeq30a,g_oeq30b                     #No.FUN-990030
                         ,g_oeq31a,g_oeq32a,g_oeq33a            #FUN-A80118 Add
                         ,g_oeq37a,g_oeq37b,                    #FUN-AB0082
                         g_ta_oeq01a,g_ta_oeq01b,g_ta_oeq02a,g_ta_oeq02b,
                         g_ta_oeq03a,g_ta_oeq03b,g_ta_oeq04a,g_ta_oeq04b,
                         g_ta_oeq05a,g_ta_oeq05b,g_ta_oeq06a,g_ta_oeq06b,
                         g_ta_oeq07a,g_ta_oeq07b,g_ta_oeq08a,g_ta_oeq08b,
                         g_ta_oeq09a,g_ta_oeq09b,g_ta_oeq10a,g_ta_oeq10b,
                         g_ta_oeq11a,g_ta_oeq11b
      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         CALL s_errmsg('','',"Foreach t800_cur2:",SQLCA.sqlcode,1)   #No.FUN-710046
         EXIT FOREACH
      END IF

      IF g_success = "N" THEN
         LET g_totsuccess = "N"
         LET g_success = "Y"
      END IF

      SELECT oeb04 INTO l_oeb04 FROM oeb_file
       WHERE oeb01=g_oep.oep01 AND oeb03 =g_oeq03

      #.....判斷若為新增的項次,則變更前的值為NULL
      IF status=100 THEN
         IF cl_null(g_oeq12b) THEN LET g_oeq12b=0 END IF
         IF cl_null(g_oeq13b) THEN LET g_oeq13b=0 END IF
         IF cl_null(g_oeq37b) THEN LET g_oeq37b=0 END IF     #FUN-AB0082
         IF cl_null(g_oeq14b) THEN LET g_oeq14b=0 END IF
         IF cl_null(g_oeq14tb) THEN LET g_oeq14tb=0 END IF   #MOD-A70005
         IF cl_null(g_oeq23b) THEN LET g_oeq23b=0 END IF
         IF cl_null(g_oeq24b) THEN LET g_oeq24b=0 END IF
         IF cl_null(g_oeq25b) THEN LET g_oeq25b=0 END IF
         IF cl_null(g_oeq20b) THEN LET g_oeq20b=0 END IF
         IF cl_null(g_oeq21b) THEN LET g_oeq21b=0 END IF
         IF cl_null(g_oeq22b) THEN LET g_oeq22b=0 END IF
         IF cl_null(g_oeq26b) THEN LET g_oeq26b=0 END IF
         IF cl_null(g_oeq27b) THEN LET g_oeq27b=0 END IF
         LET l_oeb04 = g_oeq04a
      END IF

      CALL up_price(l_oeb04)
      #若有更改訂購量oeq12a 或 單價oeq13a 才須要更新產品客戶檔obk_file
      IF NOT cl_null(g_oeq27a) OR NOT cl_null(g_oeq13a) OR NOT cl_null(g_oeq11a) THEN        #FUN-C60076 add oeq11a
        #若oeq12a 為NULL 代表訂購量不變
        # IF cl_null(g_oeq27a) THEN LET g_oeq27a = g_oeq27b END IF                           #FUN-910088--mark--
        #FUN-910088--add--start--
          IF cl_null(g_oeq27a) THEN
             LET g_oeq27a = g_oeq27b
             LET g_oeq27a = s_digqty(g_oeq27a,g_oeq26a)
          END IF
        #FUN-910088--add--end--
          #若oeq13a 為NULL 代表單價  不變
          IF cl_null(g_oeq13a) THEN LET g_oeq13a = g_oeq13b END IF

          CALL t800_bu3() IF g_success = 'N' THEN RETURN END IF  #更新產品客戶
      END IF
      IF g_success = 'N' THEN EXIT FOREACH END IF
   END FOREACH

   #-----No:FUN-A50103-----
   IF g_success = 'N' THEN
      RETURN
   END IF

   CALL t800_upd_oeaa()
#   CALL t800_upd_oeba() #FUN-CC0007 add

   IF g_success = 'N' THEN
      RETURN
   END IF
   #-----No:FUN-A50103 END-----

   IF g_totsuccess="N" THEN
      LET g_success="N"
   END IF

   #稅率不同時要重算單身之含稅金額, 未稅金額
   IF g_up_flag='Y' THEN
      CALL t800_upd_oeb()
   END IF

   CALL t800_hu1()  #客戶信用查核   #MOD-9B0010
   IF g_success = 'N' THEN
      RETURN
   END IF

   CALL t800_upd_oea61()

END FUNCTION

FUNCTION t800_upd_oea1()
   DEFINE l_oea211   LIKE oea_file.oea211
   DEFINE l_oea212   LIKE oea_file.oea212
   DEFINE l_oea213   LIKE oea_file.oea213
   DEFINE l_oap      RECORD LIKE oap_file.*
   DEFINE l_oga211    LIKE oga_file.oga211   #MOD-C10153 add
   DEFINE l_ogb01     LIKE ogb_file.ogb01    #MOD-C10153 add
   DEFINE l_ogb03     LIKE ogb_file.ogb03    #MOD-C10153 add
   DEFINE l_ogb13     LIKE ogb_file.ogb13    #MOD-C10153 add
   DEFINE l_ogb917    LIKE ogb_file.ogb917   #MOD-C10153 add
   DEFINE l_ogb31     LIKE ogb_file.ogb31    #MOD-C10153 add
   DEFINE l_ogb14     LIKE ogb_file.ogb14    #MOD-C10153 add
   DEFINE l_ogb14t    LIKE ogb_file.ogb14t   #MOD-C10153 add
   DEFINE l_gec07     LIKE gec_file.gec07    #MOD-C10153 add
   DEFINE l_ogachange LIKE type_file.chr1    #MOD-C10153 add

   SELECT * INTO g_oea.* FROM oea_file
    WHERE oea01=g_oep.oep01

   IF SQLCA.SQLCODE <>0 THEN
      CALL cl_err('sel oea:',SQLCA.SQLCODE,0)
      LET g_success='N'
      RETURN
   END IF

   IF NOT cl_null(g_oep.oep06b) THEN
      LET g_oea.oea044 = g_oep.oep06b
      IF g_oea.oea044[1,4]='MISC' THEN
         SELECT * INTO l_oap.* FROM oap_file
          WHERE oap01=g_oep.oep01
         IF STATUS = 100 THEN
            CALL cl_err('sel oap:',STATUS,1) LET g_success ='N'
         END IF
         SELECT ocd221,ocd222,ocd223
           INTO l_oap.oap041,l_oap.oap042,l_oap.oap043
           FROM ocd_file
          WHERE ocd01=g_oea.oea04 AND ocd02=g_oea.oea044
         #更新單據出貨地址檔
         UPDATE oap_file SET oap041 = l_oap.oap041,
                             oap042 = l_oap.oap042,
                             oap043 = l_oap.oap043
         WHERE oap01 = g_oep.oep01
         IF STATUS THEN
            CALL cl_err('upd oap:',STATUS,1) LET g_success = 'N'
         END IF
      END IF
   END IF

   IF NOT cl_null(g_oep.oep07b) THEN
      LET g_oea.oea32 = g_oep.oep07b    #收款條件
   END IF

   IF NOT cl_null(g_oep.oep08b) THEN
      LET g_oea.oea23 = g_oep.oep08b    #幣別
      IF g_oea.oea08='1' THEN
         LET exT=g_oaz.oaz52
      ELSE
         LET exT=g_oaz.oaz70
      END IF
      CALL s_curr3(g_oea.oea23,g_oea.oea02,exT) RETURNING g_oea.oea24
   END IF

   IF NOT cl_null(g_oep.oep10b) THEN
      LET g_oea.oea31 = g_oep.oep10b
   END IF

   IF NOT cl_null(g_oep.oep11b) THEN
      LET g_oea.oea43 = g_oep.oep11b
   END IF

   #-----No:FUN-A50103-----
   IF NOT cl_null(g_oep.oep161b) THEN
      LET g_oea.oea161 = g_oep.oep161b
   END IF

   IF NOT cl_null(g_oep.oep162b) THEN
      LET g_oea.oea162 = g_oep.oep162b
   END IF

   IF NOT cl_null(g_oep.oep163b) THEN
      LET g_oea.oea163 = g_oep.oep163b
   END IF

   IF NOT cl_null(g_oep.oep261b) THEN
      LET g_oea.oea261 = g_oep.oep261b
   END IF

   IF NOT cl_null(g_oep.oep262b) THEN
      LET g_oea.oea262 = g_oep.oep262b
   END IF

   IF NOT cl_null(g_oep.oep263b) THEN
      LET g_oea.oea263 = g_oep.oep263b
   END IF
   #-----No:FUN-A50103 END-----

   #FUN-A80118--Add--Begin
   IF NOT cl_null(g_oep.oep14b) THEN
      #MOD-C10153 -----modify start -----
      IF cl_confirm('axm1125') THEN
         LET l_ogachange = 1
      ELSE
         LET l_ogachange = 0
      END IF
      SELECT gec07 INTO l_gec07 FROM gec_file
       WHERE gec01 = g_oep.oep14b AND gec011 = '2'

       DECLARE oga21_cs CURSOR FOR
       SELECT ogb01,ogb03,ogb13,ogb917,ogb31 FROM ogb_file
        WHERE ogb31 = g_oep.oep01
       FOREACH oga21_cs INTO l_ogb01,l_ogb03,l_ogb13,l_ogb917,l_ogb31
          IF l_ogachange = 1 THEN
             SELECT oga211 INTO l_oga211 FROM oga_file
              WHERE oga01 = l_ogb01
             IF l_gec07 = 'N' THEN
                LET l_ogb14 =l_ogb917*l_ogb13
                LET l_ogb14t=l_ogb14*(1+l_oga211/100)
                CALL cl_digcut(l_ogb14,g_azi04) RETURNING l_ogb14
                CALL cl_digcut(l_ogb14t,g_azi04) RETURNING l_ogb14t
             ELSE
                LET l_ogb14t=l_ogb917*l_ogb13
                LET l_ogb14 =l_ogb14t/(1+l_oga211/100)
                CALL cl_digcut(l_ogb14t,g_azi04) RETURNING l_ogb14t
                CALL cl_digcut(l_ogb14,g_azi04) RETURNING l_ogb14
             END IF
             UPDATE ogb_file SET ogb14 = l_ogb14, ogb14t= l_ogb14t
              WHERE ogb01 = l_ogb01 AND ogb03 = l_ogb03
             IF SQLCA.SQLCODE THEN
                CALL cl_err3("upd","ogb_file",l_ogb01,l_ogb03,STATUS,"","upd ogb14,ogb14t:",1)
                RETURN FALSE
                EXIT FOREACH
             END IF
          END IF
          UPDATE oga_file SET oga21 = g_oep.oep14b WHERE oga01 = l_ogb01
          IF SQLCA.SQLCODE THEN
             CALL cl_err3("upd","oga_file",l_ogb01,"",STATUS,"","upd oga21:",1)
             RETURN FALSE
             EXIT FOREACH
          END IF
       END FOREACH
      #MOD-C10153 -----modify end -----
      LET g_oea.oea21 = g_oep.oep14b
      SELECT gec04,gec05,gec07
        INTO g_oea.oea211,g_oea.oea212,g_oea.oea213
        FROM gec_file
       WHERE gec01 = g_oea.oea21
         AND gec011 = '2'
      LET g_up_flag='Y'
   END IF

   IF NOT cl_null(g_oep.oep15b) THEN
      LET g_oea.oea10 = g_oep.oep15b
   END IF
   #FUN-A80118--Add--End

   #FUN-C40081 add begin---
   IF NOT cl_null(g_oep.oep16b) THEN
      LET g_oea.oea08 = g_oep.oep16b
   END IF
   #FUN-C40081 add end-----

   #FUN-C40080 add begin---
   IF NOT cl_null(g_oep.oep25b) THEN
      LET g_oea.oea25 = g_oep.oep25b
   END IF

   IF NOT cl_null(g_oep.oep26b) THEN
      LET g_oea.oea26 = g_oep.oep26b
   END IF
   #FUN-C40080 add end-----

   #FUN-C20109 add begin---
   IF NOT cl_null(g_oep.oep41b) THEN
      LET g_oea.oea41 = g_oep.oep41b
   END IF
   #FUN-C20109 add end-----

   #更新單頭檔
   UPDATE oea_file
      SET oea21  = g_oea.oea21,
          oea211 = g_oea.oea211,
          oea212 = g_oea.oea212,
          oea213 = g_oea.oea213,
          oea32  = g_oea.oea32,
          oea23  = g_oea.oea23,
          oea24  = g_oea.oea24,
          oea25  = g_oea.oea25,     #FUN-C40080
          oea26  = g_oea.oea26,     #FUN-C40080
          oea31  = g_oea.oea31,     #FUN-560263
          oea41  = g_oea.oea41,     #FUN-C20109
          oea43  = g_oea.oea43,     #FUN-560263
          oea044 = g_oea.oea044,    #no.7214
          oea161 = g_oea.oea161,    #No:FUN-A50103
          oea162 = g_oea.oea162,    #No:FUN-A50103
          oea163 = g_oea.oea163,    #No:FUN-A50103
          oea261 = g_oea.oea261,    #No:FUN-A50103
          oea262 = g_oea.oea262,    #No:FUN-A50103
          oea263 = g_oea.oea263,    #No:FUN-A50103
          #FUN-A80118--Add--Begin
#         oea21 = g_oea.oea21,
#         oea211= g_oea.oea211,
#         oea212= g_oea.oea212,
#         oea213= g_oea.oea213,
          oea10 = g_oea.oea10
          #FUN-A80118--Add--End
         ,oea08 = g_oea.oea08       #FUN-C40081
     WHERE oea01 = g_oep.oep01
   IF SQLCA.SQLCODE <>0 THEN
      LET g_success = 'N'
   END IF

   #FUN-B30063 add begin-----------
   IF g_oea.oea10='NULL' OR g_oea.oea10='null' THEN
      UPDATE oea_file
         SET oea10  = ''
       WHERE oea01 = g_oep.oep01
   END IF
   IF SQLCA.SQLCODE <>0 THEN
      LET g_success = 'N'
   END IF

END FUNCTION

#稅別不同時, 重新計算單身
FUNCTION t800_upd_oeb()
   DEFINE l_oeb   RECORD LIKE oeb_file.*,
          l_oea23 LIKE oea_file.oea23   #MOD-A70077

     #-----MOD-A70077---------
     LET l_oea23 = g_oep.oep08
     IF NOT cl_null(g_oep.oep08b) THEN
        LET l_oea23 = g_oep.oep08b
     END IF
     #-----END MOD-A70077-----
    SELECT azi03,azi04 INTO t_azi03,t_azi04           #No.CHI-6A0004  g_azi-->t_azi
      FROM azi_file
     #WHERE azi01=g_oea.oea23   #MOD-A70077
     WHERE azi01=l_oea23   #MOD-A70077
   IF STATUS THEN
      CALL s_errmsg('','',"SEL azi_file",SQLCA.sqlcode,0)   #No.FUN-710046
   END IF
   DECLARE upd_oeb CURSOR FOR
      SELECT *
        FROM oeb_file
       WHERE oeb01 = g_oep.oep01
   FOREACH upd_oeb INTO l_oeb.*
     IF SQLCA.SQLCODE <> 0 THEN EXIT FOREACH END IF
     IF g_oea.oea213 = 'N'
        THEN LET l_oeb.oeb14=l_oeb.oeb917*l_oeb.oeb13
             LET l_oeb.oeb14t=l_oeb.oeb14*(1+g_oea.oea211/100)
        ELSE LET l_oeb.oeb14t=l_oeb.oeb917*l_oeb.oeb13
             LET l_oeb.oeb14=l_oeb.oeb14t/(1+g_oea.oea211/100)
     END IF
     CALL cl_digcut(l_oeb.oeb14,t_azi04) RETURNING l_oeb.oeb14          #No.CHI-6A0004  g_azi-->t_azi
     CALL cl_digcut(l_oeb.oeb14t,t_azi04) RETURNING l_oeb.oeb14t        #No.CHI-6A0004  g_azi-->t_azi
     UPDATE oeb_file
        SET oeb14 = l_oeb.oeb14,
            oeb14t = l_oeb.oeb14t
      WHERE oeb01 = l_oeb.oeb01
        AND oeb03 = l_oeb.oeb03
     IF SQLCA.SQLCODE <>0 THEN
        LET g_success = 'N'
        EXIT FOREACH
     END IF
   END FOREACH
END FUNCTION

FUNCTION up_price(p_part)
  DEFINE
      p_part       LIKE oeb_file.oeb04,   # 料件編號
      l_ima25      LIKE ima_file.ima25,
      l_oeb11      LIKE oeb_file.oeb11,
      l_oeb05_fac  LIKE oeb_file.oeb05_fac,
      l_oeb930     LIKE oeb_file.oeb930, #FUN-680006
      l_oea15      LIKE oea_file.oea15   #MOD-920057
   DEFINE
      l_oea12      LIKE oea_file.oea12,
      l_oeb71      LIKE oeb_file.oeb71,
      l_qty        LIKe oeb_file.oeb12
  DEFINE l_oeb906 LIKE oeb_file.oeb906 #TQC-6C0109
  DEFINE l_oeb05_1 LIKE oeb_file.oeb05
  DEFINE l_oeb04 LIKE oeb_file.oeb04
  DEFINE l_oeb05 LIKE oeb_file.oeb05
  DEFINE l_oeb12 LIKE oeb_file.oeb12
  DEFINE l_oeq04 LIKE oeq_file.oeq04a   #MOD-890137
  DEFINE l_oeq05  LIKE oeq_file.oeq05a #MOD-920299
  DEFINE l_ima906 LIKE ima_file.ima906   #MOD-A40018

#-判斷是否為新增的序號,若是則insert,否則update -----
  LET g_cnt=0
  SELECT COUNT(*) INTO g_cnt FROM oeb_file
   WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq03

  #FUN-910088--add--start--
  IF NOT cl_null(g_oeq05a) AND cl_null(g_oeq12a) THEN
     LET g_oeq12a =s_digqty(g_oeq12b,g_oeq05a)
  END IF
  IF NOT cl_null(g_oeq20a) AND cl_null(g_oeq22a) THEN
     LET g_oeq22a =s_digqty(g_oeq22b,g_oeq20a)
  END IF
  IF NOT cl_null(g_oeq23a) AND cl_null(g_oeq25a) THEN
     LET g_oeq25a =s_digqty(g_oeq25b,g_oeq23a)
  END IF
  IF NOT cl_null(g_oeq26a) AND cl_null(g_oeq27a) THEN
     LET g_oeq27a =s_digqty(g_oeq27b,g_oeq26a)
  END IF
  #FUN-910088--add--end
  IF g_cnt=0 THEN
    #---取庫存單位
    SELECT ima25 INTO l_ima25 FROM ima_file WHERE ima01=g_oeq04a
    #---取換算率
    CALL s_umfchk(g_oeq04a,g_oeq05a,l_ima25) RETURNING l_flag,l_oeb05_fac
    IF l_flag=1 THEN LET l_oeb05_fac=1 END IF

    #抓產品客戶檔obk11
    SELECT obk11 INTO l_oeb906
      FROM obk_file
     WHERE obk01 = g_oeq04a
       AND obk02 = (SELECT oea03 FROM oea_file
                    WHERE oea01 = g_oep.oep01 )

    IF cl_null(l_oeb906) THEN
       LET l_oeb906='N'
    END IF

    IF g_aaz.aaz90='Y' THEN
       SELECT oeb930 INTO l_oeb930 FROM oeb_file
                                  WHERE oeb01=g_oep.oep01
                                    AND oeb03=g_oeq03
       IF SQLCA.sqlcode THEN
          SELECT oea15 INTO l_oea15 FROM oea_file
            WHERE oea01 = g_oep.oep01
          LET l_oeb930=s_costcenter(l_oea15)
          IF cl_null(l_oeb930) THEN
             CALL cl_err(l_oea15,'axm1010',0)
             LET g_success = 'N'
             RETURN
          END IF
       END IF
    END IF

    LET l_oeb11 = ''
    #FUN-C60076 mark begin---
    SELECT MIN(obk03) INTO l_oeb11 FROM obk_file
        WHERE obk01=g_oeq04a
          AND obk02= (SELECT oea03 FROM oea_file
                      WHERE oea01 = g_oep.oep01 )
    #FUN-C60076 mark end-----

    #FUN-C60076 add begin---
    IF cl_null(g_oeq11a) THEN
       LET l_oeb11 = g_oeq11b
    ELSE
       LET l_oeb11 = g_oeq11a
    END IF
    #FUN-C60076 add end-----

    LET g_oeb11 = l_oeb11   #MOD-880003

    IF cl_null(g_oeq37a) OR g_oeq37a = 0 THEN LET g_oeq37a = g_oeq13a END IF #FUN-AB0082

    #FUN-C70021 add begin---
     LET l_oeb71 = ''
     IF g_oea.oea11= '3' AND cl_null(l_oeb71) THEN
        SELECT oeb03 INTO l_oeb71
          FROM oeb_file
         WHERE oeb01 = g_oea.oea12
           AND oeb04 = g_oeq04a
     END IF
    #FUN-C70021 add end-----

    INSERT INTO oeb_file(oeb01,oeb03,oeb04,oeb05,oeb05_fac,
                        #oeb06,oeb12,oeb13,oeb17,oeb14,oeb14t,oeb15,oeb72,oeb16,oeb19, #no.7150(add oeb17)    #NO.FUN-920031--addoeb16  #FUN-B20060 add oeb72  #CHI-C80060 mark
                         oeb06,oeb12,oeb13,oeb17,oeb14,oeb14t,oeb15,oeb16,oeb19,                              #no.7150(add oeb17)          #CHI-C80060 add
                         oeb23,oeb24,oeb25,oeb26,oeb70,oeb905,
                         oeb913,oeb914,oeb915,oeb910,oeb911,oeb912,oeb916,oeb917,oeb930,oeb30,oeb31,oeb906,   #no.7182 #FUN-680006   #No:FUN-740016 #TQC-6C0109 add oeb906
                         oeb1003,oeb11,oeb28,oeb920,oeb1012,oeb1001,oeb1006,                                  #MOD-760026 add  #MOD-760079 modify    #MOD-920324 add oeb28/oeb920 #MOD-960263 add oeb1012#No.FUN-990030 add oeb1001   #MOD-A10123 add oeb1006
                         oebplant,oeblegal                                                                    #FUN-980010 add plant & legal
                         ,oeb41,oeb42,oeb43,oeb37,oeb71)                                                      #FUN-A80118 Add        #FUN-AB0082 add oeb37    #FUN-C70021 add oeb71
      VALUES (g_oep.oep01,g_oeq03,g_oeq04a,g_oeq05a,l_oeb05_fac,
             #g_oeq041a,g_oeq12a,g_oeq13a,g_oeq13a,g_oeq14a,g_oeq14ta,g_oeq15a,g_oeq15a,g_oeq15a,'N',         #NO.FUN-920031--add #FUN-B20060 add g_oeq15a  #CHI-C80060 mark
              g_oeq041a,g_oeq12a,g_oeq13a,g_oeq13a,g_oeq14a,g_oeq14ta,g_oeq15a,g_oeq15a,'N',                  #CHI-C80060 add
              0,0,0,0,'N',0,g_oeq23a,g_oeq24a,g_oeq25a,g_oeq20a,g_oeq21a,
              g_oeq22a,g_oeq26a,g_oeq27a,l_oeb930,g_oeq28a,g_oeq29a,l_oeb906,'1',l_oeb11,0,0,g_oeb1012,g_oeq30a,100,     #TQC-6C0109  #FUN-680006   #No:FUN-740016  #MOD-760026 modify  #MOD-760079 modify    #MOD-920324 add oeb28/oeb920 #MOD-960263  add oeb1012#No.FUN-990030 add g_oeq30a   #MOD-A10123 add oeb1006
              g_plant,g_legal,g_oeq31a,g_oeq32a,g_oeq33a,g_oeq37a,l_oeb71)                                               #FUN-A80118 Add g_oeq31a,g_oeq32a,g_oeq33a       #FUN-AB0082 add l_oeb37    #FUN-C70021 add l_oeb71
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        LET g_success = 'N'
        CALL s_errmsg('','',"(axmt800:ins)",SQLCA.sqlcode,1)  #No.FUN-710046
        RETURN
     END IF
     CALL t800_upd_ima33('a',g_oeq03,g_oeq04a,g_oeq05a)   #MOD-870273 add
  ELSE
  {ckp#3}
  #--->更新oeb_file
  #--->有變更料號的情況下,新料號須再做更新
  IF ( NOT cl_null(g_oeq04a) AND p_part != g_oeq04a )   #bugno:5644
  THEN
      #抓產品客戶檔obk11
      SELECT obk11 INTO l_oeb906
        FROM obk_file
       WHERE obk01 = g_oeq04a
         AND obk02 = (SELECT oea03 FROM oea_file
                      WHERE oea01 = g_oep.oep01 )

      IF cl_null(l_oeb906) THEN
         LET l_oeb906='N'
      END IF
      UPDATE oeb_file
         SET oeb04  = g_oeq04a                #料件編號
            ,oeb06  = g_oeq041a               #品名   #MOD-9B0044
            ,oeb19  = 'N'                     #備置否   #MOD-670129 add
            ,oeb905 = 0                       #已備置量 #MOD-670129 add
            ,oeb906 = l_oeb906                #TQC-6C0109
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03                  #訂單單項次
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] =0 THEN
         LET g_success = 'N'
         CALL s_errmsg('','',"axmt800:ckp#3",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF
      CALL t800_upd_ima33('u',g_oeq03,'','')   #MOD-870273 add
   END IF
         LET l_oeb11 = ''
         LET g_msg=NULL
         IF cl_null(g_oeq04a) THEN
            LET l_oeq04 = g_oeq04b
         ELSE
            LET l_oeq04 = g_oeq04a
         END IF

        #FUN-C60076 mark begin---
        #SELECT MIN(obk03) INTO g_msg FROM obk_file
        #    WHERE obk01=l_oeq04    #MOD-890137
        #      AND obk02= (SELECT oea03 FROM oea_file
        #                  WHERE oea01 = g_oep.oep01 )
        #LET g_oeb11 = g_msg   #MOD-880003
        #FUN-C60076 mark end-----

        #FUN-C60076 add begin---
        IF cl_null(g_oeq11a) THEN
           LET l_oeb11 = g_oeq11b
        ELSE
           LET l_oeb11 = g_oeq11a
        END IF
        #FUN-C60076 add end-----
            UPDATE oeb_file
              #SET oeb11 = g_msg                    #客戶料件編號    #FUN-C60076
               SET oeb11 = l_oeb11                                   #FUN-C60076
             WHERE oeb01 = g_oep.oep01
               AND oeb03 = g_oeq03                  #訂單單項次
            IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] =0 THEN
               LET g_success = 'N'
               CALL s_errmsg("oeb01",g_oep.oep01,"UPD oeb_file",SQLCA.sqlcode,1)  #No.FUN-710046
               RETURN
            END IF

  #--->有變更品名的情況下須做更新
  IF ( NOT cl_null(g_oeq041a) AND g_oeq041a !=g_oeq041b )  #bugno:5644 add...
  THEN
      UPDATE oeb_file SET oeb06  = g_oeq041a  # 品名規格
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03       # 訂單單項次

      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] =0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#3.1)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF
   END IF
   #---> 變更銷售單位
  #IF NOT cl_null(g_oeq05a) AND g_oeq05b != g_oeq05a THEN   #MOD-D10148 mark
  #MOD-D10148 add start -----
   IF (NOT cl_null(g_oeq05a) AND g_oeq05b != g_oeq05a)
      OR (NOT cl_null(g_oeq04a) AND p_part != g_oeq04a) THEN
  #MOD-D10148 add start -----
      UPDATE oeb_file SET oeb05 = g_oeq05a    # 銷售單位
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#3.2)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF
      IF NOT cl_null(g_oeq04a) THEN
         LET l_oeq04 = g_oeq04a
      ELSE
         LET l_oeq04 = g_oeq04b
      END IF
      IF NOT cl_null(g_oeq05a) THEN
         LET l_oeq05 = g_oeq05a
      ELSE
         LET l_oeq05 = g_oeq05b
      END IF
      SELECT ima25 INTO l_ima25 FROM ima_file
        WHERE ima01 = l_oeq04
      CALL s_umfchk(l_oeq04,l_oeq05,l_ima25) RETURNING l_flag,l_oeb05_fac
      IF l_flag=1 THEN LET l_oeb05_fac=1 END IF
      UPDATE oeb_file SET oeb05_fac = l_oeb05_fac
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#3.2)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#4}
   IF NOT cl_null(g_oeq12a) AND g_oeq12a != g_oeq12b THEN  # 變更訂購量
      UPDATE oeb_file SET oeb12 = g_oeq12a # 變更後訂購量
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#3.4)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF
      #----------------------------------------------------
      #判斷變更訂單是否由合約訂單轉入，若是的話須去update
      #合約訂單的"已訂數量"欄位
      #----------------------------------------------------
      SELECT oea12,oeb71 INTO l_oea12,l_oeb71 FROM oea_file,oeb_file
          WHERE oeb01 = g_oep.oep01
            AND oeb03 = g_oeq03
            AND oea11 = '3'
            AND oea01 = oeb01
      IF NOT cl_null(l_oea12) AND NOT cl_null (l_oeb71) THEN
         LET l_qty = 0
         DECLARE oeb12_cs CURSOR FOR
           SELECT oeb04,oeb05,oeb12 FROM oea_file,oeb_file
            WHERE oea12 = l_oea12 AND oea00 IN ('1','3','4','6','7')
              AND oeaconf = 'Y'
              AND oea01 = oeb01
              AND oeb71 = l_oeb71
         LET l_oeb05_1 = ''
         SELECT oeb05 INTO l_oeb05_1 FROM oeb_file
           WHERE oeb01 = l_oea12
             AND oeb03 = l_oeb71
         LET l_oeb12 = 0                               #MOD-940401 add
         FOREACH oeb12_cs INTO l_oeb04,l_oeb05,l_oeb12
           CALL s_umfchk(l_oeb04,l_oeb05,l_oeb05_1) RETURNING l_flag,l_oeb05_fac
           IF l_flag = 1 THEN LET l_oeb05_fac = 1 END IF
           LET l_qty = l_qty + (l_oeb12 * l_oeb05_fac)
         END FOREACH
         IF SQLCA.SQLCODE THEN
            LET g_success = 'N'
            LET g_showmsg=l_oea12,"/",l_oeb71       #No.FUN-710046
            CALL s_errmsg("oea12,oeb71",g_showmsg,"oeb:ckp",SQLCA.sqlcode,1)   #No.FUN-710046
            RETURN
         ELSE
            UPDATE oeb_file SET oeb24 = l_qty
                            WHERE oeb01 = l_oea12
                              AND oeb03 = l_oeb71
             IF SQLCA.SQLERRD[3] = 0 THEN
                LET g_success = 'N'
                LET g_showmsg=l_oea12,"/",l_oeb71          #No.FUN-710046
                CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#3.4)",SQLCA.sqlcode,1)  #No.FUN-710046
                RETURN
             END IF
         END IF
      END IF
   END IF
{ckp#5}
   IF NOT cl_null(g_oeq13a) AND g_oeq13a != g_oeq13b THEN  # 變更單價
      UPDATE oeb_file SET oeb13 = g_oeq13a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#5)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#5.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
      CALL t800_upd_ima33('u',g_oeq03,'','')   #MOD-870273 add
   END IF
  #FUN-AB0082 Begin---
   IF NOT cl_null(g_oeq37a) AND g_oeq37a != g_oeq37b THEN  # 變更單價
      UPDATE oeb_file SET oeb37 = g_oeq37a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#5)",SQLCA.sqlcode,1)
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#5.1)","mfg9328",1)
         RETURN
      END IF
   END IF
  #FUN-AB0082 End-----
{ckp#6}
   IF NOT cl_null(g_oeq14a) AND g_oeq14a != g_oeq14b THEN  # 變更金額
      #UPDATE oeb_file SET oeb14 = g_oeq14a, oeb14t = g_oeq14ta   #MOD-A70005
      UPDATE oeb_file SET oeb14 = g_oeq14a   #MOD-A70005
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#6)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#6.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
#-----MOD-A70005---------
{ckp#6-1}
   IF NOT cl_null(g_oeq14ta) AND g_oeq14ta != g_oeq14tb THEN  # 變更金額
      UPDATE oeb_file SET oeb14t = g_oeq14ta
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#6-1)",SQLCA.sqlcode,1)
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#6-1.1)","mfg9328",1)
         RETURN
      END IF
   END IF
#-----END MOD-A70005-----
{ckp#7}
   IF NOT cl_null(g_oeq15a) AND (g_oeq15a != g_oeq15b OR
          g_oeq15b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb15 = g_oeq15a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#7)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#7.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#8}
   IF NOT cl_null(g_oeq23a) AND (g_oeq23a != g_oeq23b OR
          g_oeq23b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb913 = g_oeq23a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#8)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#8.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#9}
   IF NOT cl_null(g_oeq24a) AND (g_oeq24a != g_oeq24b OR
          g_oeq24b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb914 = g_oeq24a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#9)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#9.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#10}
   IF NOT cl_null(g_oeq25a) AND (g_oeq25a != g_oeq25b OR
          g_oeq25b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb915 = g_oeq25a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#10)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#10.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
   #-----MOD-A40018---------
{ckp#16}
   LET l_ima906 = ''
   SELECT ima906 INTO l_ima906 FROM ima_file
     WHERE ima01=g_oeq04a
   IF l_ima906 = '1' THEN
      UPDATE oeb_file SET oeb913=NULL,oeb914=NULL,oeb915=NULL
         WHERE oeb01 = g_oep.oep01
           AND oeb03 = g_oeq03
      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#16)",SQLCA.sqlcode,1)
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#16.1)","mfg9328",1)
         RETURN
      END IF

   END IF
   #-----END MOD-A40018-----
{ckp#11}
   IF NOT cl_null(g_oeq20a) AND (g_oeq20a != g_oeq20b OR
          g_oeq20b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb910 = g_oeq20a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#11)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#11.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#12}
   IF NOT cl_null(g_oeq21a) AND (g_oeq21a != g_oeq21b OR
          g_oeq21b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb911 = g_oeq21a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#12)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#12.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#13}
   IF NOT cl_null(g_oeq22a) AND (g_oeq22a != g_oeq22b OR
          g_oeq22b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb912 = g_oeq22a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#13)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#13.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#14}
   IF NOT cl_null(g_oeq26a) AND (g_oeq26a != g_oeq26b OR
          g_oeq26b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb916 = g_oeq26a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#14)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#14.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
{ckp#15}
   IF NOT cl_null(g_oeq27a) AND (g_oeq27a != g_oeq27b OR
          g_oeq27b IS NULL)  THEN   # 變更原始交貨日期
      UPDATE oeb_file SET oeb917 = g_oeq27a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#15)",SQLCA.sqlcode,1)  #No.FUN-710046
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03          #No.FUN-710046
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#15.1)","mfg9328",1)  #No.FUN-710046
         RETURN
      END IF
   END IF
   IF NOT cl_null(g_oeq28a) AND (g_oeq28a != g_oeq28b OR
          g_oeq28b IS NULL)  THEN
      UPDATE oeb_file SET oeb30 = g_oeq28a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#16)",SQLCA.sqlcode,1)
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#16.1)","mfg9328",1)
         RETURN
      END IF
   END IF

   IF NOT cl_null(g_oeq29a) AND (g_oeq29a != g_oeq29b OR
          g_oeq29b IS NULL)  THEN
      UPDATE oeb_file SET oeb31 = g_oeq29a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03

      IF SQLCA.SQLCODE THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#17)",SQLCA.sqlcode,1)
         RETURN
      END IF

      IF SQLCA.SQLERRD[3] = 0 THEN
         LET g_success = 'N'
         LET g_showmsg=g_oep.oep01,"/",g_oeq03
         CALL s_errmsg("oeb01,oeb03",g_showmsg,"(axmt800:ckp#17.1)","mfg9328",1)
         RETURN
      END IF
   END IF
   IF NOT cl_null(g_oeq30a) AND (g_oeq30a != g_oeq30b OR g_oeq30b IS NULL)  THEN
      UPDATE oeb_file
         SET oeb1001=g_oeq30a
       WHERE oeb01=g_oep.oep01 and oeb03=g_oeq03
   END IF

   #FUN-A80118--Add--Begin
   IF NOT cl_null(g_oeq31a) OR NOT cl_null(g_oeq32a) OR NOT cl_null(g_oeq33a) THEN
      UPDATE oeb_file SET oeb41=g_oeq31a,oeb42=g_oeq32a,oeb43=g_oeq33a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03
   END IF
   #FUN-A80118--Add--End
{ckp#16--add by donghy}
   IF NOT cl_null(g_ta_oeq01a) AND (g_ta_oeq01a != g_ta_oeq01b OR g_ta_oeq01b IS NULL)  THEN
      UPDATE oeb_file SET oebud04=g_ta_oeq01a
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq03
   END IF
{ckp#17--add by donghy}
   IF NOT cl_null(g_ta_oeq02a) AND (g_ta_oeq02a != g_ta_oeq02b OR g_ta_oeq02b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb04=g_ta_oeq02a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF
{ckp#18--add by donghy}
   IF NOT cl_null(g_ta_oeq03a) AND (g_ta_oeq03a != g_ta_oeq03b OR g_ta_oeq03b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb05=g_ta_oeq03a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF

{ckp#19--add by donghy}
 IF NOT cl_null(g_ta_oeq04a) AND (g_ta_oeq04a != g_ta_oeq04b OR g_ta_oeq04b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb06=g_ta_oeq04a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF

{ckp#20--add by donghy}
   IF NOT cl_null(g_ta_oeq05a) AND (g_ta_oeq05a != g_ta_oeq05b OR g_ta_oeq05b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb07=g_ta_oeq05a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF

{ckp#21--add by donghy}
   IF NOT cl_null(g_ta_oeq06a) AND (g_ta_oeq06a != g_ta_oeq06b OR g_ta_oeq06b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb08=g_ta_oeq06a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF

{ckp#22--add by donghy}
   IF NOT cl_null(g_ta_oeq07a) AND (g_ta_oeq07a != g_ta_oeq07b OR g_ta_oeq07b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb09=g_ta_oeq07a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
   END IF

{ckp#22--add by donghy}
  IF NOT cl_null(g_ta_oeq08a) AND (g_ta_oeq08a != g_ta_oeq08b OR g_ta_oeq08b IS NULL)  THEN
      UPDATE tc_oeb_file SET tc_oeb10=g_ta_oeq08a
       WHERE tc_oeb01 = '1'
         AND tc_oeb02 =g_oep.oep01
         AND tc_oeb03 = g_oeq03
  END IF
  {ckp#23--add by donghy}
  IF NOT cl_null(g_ta_oeq09a) AND (g_ta_oeq09a != g_ta_oeq09b OR g_ta_oeq09b IS NULL)  THEN
      UPDATE oeb_file SET oebud02=g_ta_oeq09a
       WHERE oeb01 =g_oep.oep01
         AND oeb03 = g_oeq03
  END IF
  {ckp#23--add by donghy}
  IF NOT cl_null(g_ta_oeq10a) AND (g_ta_oeq10a != g_ta_oeq10b OR g_ta_oeq10b IS NULL)  THEN
      UPDATE oeb_file SET oebud03=g_ta_oeq10a
       WHERE oeb01 =g_oep.oep01
         AND oeb03 = g_oeq03
  END IF
  {ckp#24--add by donghy}
  IF NOT cl_null(g_ta_oeq11a) AND (g_ta_oeq11a != g_ta_oeq11b OR g_ta_oeq11b IS NULL)  THEN
      UPDATE oeb_file SET oebud05=g_ta_oeq11a
       WHERE oeb01 =g_oep.oep01
         AND oeb03 = g_oeq03
  END IF
END IF
END FUNCTION

FUNCTION t800_hu1()             #客戶信用查核
   DEFINE l_oea03 LIKE oea_file.oea03
#  DEFINE l_oia07 LIKE oia_file.oia07    #FUN-C50136--add--

   CALL cl_msg("hu1!")                              #FUN-640184

   IF g_oaz.oaz122 MATCHES "[12]" THEN  #信用查核超限處理方式 (0/1)
      SELECT oea03 INTO l_oea03 FROM oea_file
            WHERE oea01=g_oep.oep01 #0.不檢查 1.顯示警告訊息,可確認但設定留置
      IF g_oep.oepmksg = 'Y' THEN
         CALL s_ccc_logerr()
      END IF
      CALL s_ccc(l_oea03,'1','')    #Customer Credit Check 客戶信用查核  #FUN-C50136
#     #FUN-C50136--add--start--
#     IF g_oaz.oaz96 = 'Y' THEN
#        CALL s_ccc_oia07('B',l_oea03) RETURNING l_oia07
#        IF l_oia07 = '2' THEN
#           CALL s_ccc_oia(l_oea03,'B',g_oep.oep01,g_oep.oep02,'')
#        END IF
#     ELSE
#        CALL s_ccc(l_oea03,'1','')    #Customer Credit Check 客戶信用查核
#     END IF
#     #FUN-C50136--add--end--
      IF g_errno = 'N' THEN
         IF g_oaz.oaz122 = '1'
            THEN CALL cl_err('ccc','axm-104',1)
                 UPDATE oea_file SET oeahold=g_oaz.oaz11
                        WHERE oea01=g_oep.oep01
            ELSE CALL cl_err('ccc','axm-106',0)
                 LET g_success = 'N' RETURN
         END IF
      END IF
   END IF
   CALL cl_msg("")                              #FUN-640184

END FUNCTION

FUNCTION t800_bu3()                             #更新產品客戶
 DEFINE l_oea03    LIKE oea_file.oea03
 DEFINE l_obk01    LIKE obk_file.obk01
 DEFINE l_obk05    LIKE obk_file.obk05
 DEFINE l_obk07    LIKE obk_file.obk07
 DEFINE l_obk08    LIKE obk_file.obk08
 DEFINE l_obk09    LIKE obk_file.obk09
 DEFINE l_obk11    LIKE obk_file.obk11,
        l_obk12    LIKE obk_file.obk12,
        l_obk13    LIKE obk_file.obk13,
        l_obk14    LIKE obk_file.obk14
 DEFINE l_obk03    LIKE obk_file.obk03          #FUN-C60076

      CALL cl_msg("bu3!")                              #FUN-640184

      IF g_oaz.oaz44 = 'Y' THEN

          IF cl_null(g_oeq04a)  THEN
             LET l_obk01=g_oeq04b
          ELSE
             LET l_obk01=g_oeq04a
          END IF

          SELECT oea03 INTO l_oea03 FROM oea_file
           WHERE oea01 = g_oep.oep01

          IF cl_null(g_oep.oep08b) THEN
             LET l_obk05=g_oep.oep08
          ELSE
             LET l_obk05=g_oep.oep08b
          END IF

          IF cl_null(g_oeq26a)  THEN
             LET l_obk07 = g_oeq26b
          ELSE
             LET l_obk07 = g_oeq26a
          END IF

          IF cl_null(g_oeq13a)  THEN
             LET l_obk08 = g_oeq13b
          ELSE
             LET l_obk08 = g_oeq13a
          END IF

          IF cl_null(g_oeq27a)  THEN
             LET l_obk09 = g_oeq27b
          ELSE
             LET l_obk09 = g_oeq27a
          END IF
          LET l_obk09 = s_digqty(l_obk09,l_obk07)  #FUN-910088 add

          LET l_obk11 = 'N'

          #FUN-C60076 add begin---
          IF cl_null(g_oeq11a)  THEN
             LET l_obk03 = g_oeq11b
          ELSE
             LET l_obk03 = g_oeq11a
          END IF
          #FUN-C60076 add end-----

          INSERT INTO obk_file (obk01,obk02,
                                obk03,obk04,obk05,obk06,obk07,obk08,obk09,
                                obk11,obkacti)            #CHI-9C0060
          VALUES (l_obk01,l_oea03,
                 #g_oeb11,                                #FUN-C60076
                  l_obk03,                                #FUN-C60076
                  g_oea.oea02,l_obk05,g_oea.oea21,
                  l_obk07 , l_obk08, l_obk09,
                  l_obk11,'Y')                            #CHI-9C0060
          IF cl_sql_dup_value(SQLCA.SQLCODE) THEN
            #UPDATE obk_file SET obk03 = g_oeb11,         #FUN-C60076
             UPDATE obk_file SET obk03 = l_obk03,         #FUN-C60076
                                 obk04 = g_oea.oea02,
                                 obk05 = l_obk05,
                                 obk06 = g_oea.oea21,
                                 obk07 = l_obk07,
                                 obk08 = l_obk08,
                                 obk09 = l_obk09
               WHERE obk01 = l_obk01
                 AND obk02 = l_oea03
                 AND obk05 = l_obk05
          END IF
      END IF

      CALL cl_msg("")                              #FUN-640184


END FUNCTION

FUNCTION t800_upd_oea61()
DEFINE l_oea61 LIKE oea_file.oea61
   DEFINE l_oea1008 LIKE oea_file.oea1008    #No:FUN-A50103

  #SELECT SUM(oeb14) INTO l_oea61 FROM oeb_file WHERE oeb01=g_oep.oep01
   SELECT SUM(oeb14),SUM(oeb14t) INTO l_oea61,l_oea1008    #No:FUN-A50103
     FROM oeb_file
    WHERE oeb01=g_oep.oep01

   UPDATE oea_file SET oea61 = l_oea61,
                       oea1008 = l_oea1008,    #No:FUN-A50103
                       oea06 = g_oep.oep02
    WHERE oea01 = g_oep.oep01
   IF SQLCA.SQLCODE THEN
      LET g_success = 'N'
      CALL s_errmsg("oea01",g_oep.oep01,"UPD oea61",SQLCA.sqlcode,1)   #No.FUN-710046
      RETURN
   END IF

END FUNCTION

FUNCTION t800_sign()
   DEFINE    p_cmd     LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
             l_slip    LIKE oay_file.oayslip,# No:FUN-680137 VARCHAR(05)
             l_cnt     LIKE type_file.num5,    #No.FUN-680137 SMALLINT
             l_azc     RECORD LIKE azc_file.*,
             l_azd     RECORD LIKE azd_file.*,
             l_azd01   LIKE azd_file.azd01,
             l_oayapr  LIKE oay_file.oayapr,
             l_oaysign LIKE oay_file.oaysign,
             l_oepsign LIKE oep_file.oepsign

   IF cl_null(g_oep.oep01) THEN RETURN END IF
   LET l_oepsign = ' '
   LET l_slip = s_get_doc_no(g_oep.oep01)     #No:FUN-550070
   SELECT oayapr,oaysign INTO g_oep.oepmksg,l_oepsign
     FROM oay_file WHERE oayslip = l_slip
   IF cl_null(g_oep.oepmksg) THEN
      LET g_oep.oepmksg='N'
      LET g_oep.oepsign=' '
   END IF
   IF cl_null(g_oep.oepsign) THEN
      LET g_oep.oepsign=l_oepsign
   END IF
   IF cl_null(g_oep.oepsign) THEN
      LET g_oep.oepsign=' '
   END IF
   LET l_azd01=g_oep.oep01 CLIPPED,g_oep.oep02 USING '&&' CLIPPED
   DELETE FROM azd_file WHERE azd01 = l_azd01 AND azd02 =26
   IF g_oep.oepmksg='N' THEN
      UPDATE oep_file SET oepmksg=g_oep.oepmksg,oepsign=g_oep.oepsign
       WHERE oep01=g_oep.oep01 AND oep02=g_oep.oep02
      COMMIT WORK
      RETURN
   END IF
   LET l_cnt=NULL
   SELECT COUNT(*) INTO l_cnt FROM azc_file WHERE azc01=g_oep.oepsign
   IF l_cnt IS NULL THEN LET l_cnt=0  END IF
   LET g_oep.oepmksg='Y'
   LET g_oep.oepsmax=l_cnt
   UPDATE oep_file SET oepsign = g_oep.oepsign,
                       oepmksg = g_oep.oepmksg,
                       oepsmax = g_oep.oepsmax,
                       oepsseq = 0
    WHERE oep01=g_oep.oep01 AND oep02=g_oep.oep02
   DISPLAY g_oep.oepmksg TO oepmksg   #MOD-9B0104

END FUNCTION

FUNCTION t800_d()
   DEFINE l_cmd		LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(200)
          l_prog	LIKE imd_file.imd01,    # No:FUN-680137 VARCHAR(10)
          l_wc,l_wc2	LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(50)
          l_prtway	LIKE type_file.chr1    #No.FUN-680137 VARCHAR(1)
   DEFINE l_sw          LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
          l_n           LIKE type_file.num5,    #No.FUN-680137 SMALLINT
          l_buf         LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(6)
          l_name        LIKE type_file.chr20   #No.FUN-680137 VARCHAR(20)
   DEFINE l_easycmd     LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(4096)
          l_updsql_0    LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(500)
          l_updsql_1    LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(500)
          l_updsql_2    LIKE type_file.chr1000, #No.FUN-680137 VARCHAR(500)
          l_upload      LIKE type_file.chr1000  #No.FUN-680137 VARCHAR(1000)


   IF g_aza.aza23 matches '[ Nn]' THEN
     CALL cl_err('aza23','mfg3551',0)
     RETURN
   END IF

   IF g_oep.oep01 IS NULL OR g_oep.oep01 = ' ' THEN
      RETURN
   END IF

   IF g_oep.oepmksg IS NULL OR g_oep.oepmksg matches '[Nn]' THEN
     CALL cl_err('','mfg3549',0)
     RETURN
   END IF

   IF g_oep.oepconf matches '[Nn]' THEN
     CALL cl_err('','mfg3550',0)
     RETURN
   END IF

   IF g_oep.oep09 matches '[Ss1]' THEN
     CALL cl_err('','mfg3557',0)  #本單據目前已送簽或已核准
     RETURN
   END IF

#--- 產生本張單據之報表檔
  # LET l_prog='axmr800' #FUN-C30085 mark
  # LET l_prog='axmg800' #FUN-C30085 add # mark by lixwz 170914
  LET l_prog='axmr800' # add by lixwz 170914 改为cr报表

   SELECT zz21,zz22 INTO l_wc2,l_prtway FROM zz_file WHERE zz01 = l_prog
   IF SQLCA.sqlcode OR l_wc2 IS NULL THEN LET l_wc2 = " '3' " END IF

   LET l_wc = ' oep01 = ',' "',g_oep.oep01,'" ',
              ' AND oep02 = ',' "',g_oep.oep02,'" '

#---- 抓報表檔名  l_name
   CALL cl_outnam(l_prog) RETURNING l_name
   LET l_cmd = l_prog CLIPPED,
               " '",g_today CLIPPED,"' ''",
               " '",g_lang CLIPPED,"' 'Y' '0' '1'",
               " '",l_wc CLIPPED,"' '",l_wc2 CLIPPED,"'",
               " '' '",l_name CLIPPED,"'"
    CALL cl_cmdrun(l_cmd)

#---- 更新[目前狀態] 為 'S.送簽中'

   LET l_updsql_0="UPDATE oep_file SET oep09='S' WHERE oep01='",g_oep.oep01,"'",
                  " AND oep02='",g_oep.oep02,"';"
   LET l_updsql_1="UPDATE oep_file SET oep09='1' WHERE oep01='",g_oep.oep01,"'",
                  " AND oep02='",g_oep.oep02,"';"
   LET l_updsql_2="UPDATE oep_file SET oep09='R' WHERE oep01='",g_oep.oep01,"'",
                  " AND oep02='",g_oep.oep02,"';"
   LET l_easycmd='ef ',
                 '"','TIPTOP_COC','" ',                 #E-Form單別
                 '"','axmt800','" ',                    #程式代號
                 '"',g_oep.oep01 CLIPPED,'" ',          #單號
                 '"',g_dbs CLIPPED,'" ',                #資料庫(連線字串)
                 '"',l_updsql_0 CLIPPED,'" ',           #更新狀況碼-送簽中
                 '"',l_updsql_1 CLIPPED,'" ',           #簽核同意
                 '"',l_updsql_2 CLIPPED,'" ',           #簽核不同意
                 '"','1','" ',                          #附件總數
                 '"',l_name CLIPPED,'" ',               #報表檔徑名
                 '"','2','" ',                          #條件欄位總數
                 '"C',g_oep.oepsign CLIPPED,'" ',        #條件1: 簽核等級
                 '"N','5000','" '                       #條件2: 總金額
  RUN l_easycmd

END FUNCTION

#01/08/07 mandy 新增作廢/作廢還原的功能
#FUNCTION t800_x()        #FUN-D20025
FUNCTION t800_x(p_type)   #FUN-D20025
   DEFINE p_type    LIKE type_file.num5     #FUN-D20025
   DEFINE l_flag    LIKE type_file.chr1     #FUN-D20025
   IF s_shut(0) THEN RETURN END IF
   IF cl_null(g_oep.oep01) THEN CALL cl_err('',-400,0) RETURN END IF

   #已變更發出,不可"取消確認"或"作廢"!!
   IF g_oep.oep09='2' THEN
       CALL cl_err(g_oep.oep01,'axm-015',0)
       RETURN
   END IF
   IF g_oep.oep09 matches '[Ss1]' THEN    #FUN-550031
      CALL cl_err("","mfg3557",0)
      RETURN
   END IF

   IF g_oep.oepconf = 'X' THEN
       #---->判斷此訂單,是否尚有未發出的變更單
       SELECT count(*) INTO g_cnt FROM oep_file
        WHERE oep01 = g_oep.oep01
          AND oepconf IN ('N','n')
       IF g_cnt > 0 THEN
           #尚有未確認的訂單變更單,不可作廢還原!
           CALL cl_err('','axm-760',1)
           RETURN
       END IF
       #MOD-C40077 add start -----
       #---->判斷此訂單,是否尚有未確認的訂單
       SELECT count(*) INTO g_cnt FROM oea_file
        WHERE oea01 = g_oep.oep01
          AND oeaconf = 'N'
       IF g_cnt > 0 THEN
           #尚有未確認的訂單,不可作廢還原!
           CALL cl_err('','axm1145',1)
           RETURN
       END IF
       #MOD-C40077 add end    -----
   END IF

   #FUN-D20025--add--str--
   IF p_type = 1 THEN
      IF g_oep.oepconf='X' THEN RETURN END IF
   ELSE
      IF g_oep.oepconf<>'X' THEN RETURN END IF
   END IF
   #FUN-D20025--add--end--

   BEGIN WORK

   LET g_success='Y'

   OPEN t800_cl USING g_oep.oep01,g_oep.oep02    #No.TQC-9A0114
   IF STATUS THEN
      CALL cl_err("OPEN t800_cl:", STATUS, 1)
      CLOSE t800_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t800_cl INTO g_oep.*          #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oep.oep01,SQLCA.sqlcode,0)      #資料被他人LOCK
      CLOSE t800_cl ROLLBACK WORK RETURN
   END IF

   #-->確認不可作廢
   IF g_oep.oepconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF

  #IF cl_void(0,0,g_oep.oepconf)   THEN    #FUN-D20025
   IF p_type = 1 THEN LET l_flag = 'N' ELSE LET l_flag = 'X' END IF  #FUN-D20025
   IF cl_void(0,0,l_flag) THEN             #FUN-D20025
      LET g_chr=g_oep.oepconf

     #IF g_oep.oepconf ='N' THEN           #FUN-D20025
      IF p_type = 1 THEN                   #FUN-D20025
          LET g_oep.oepconf='X'
      ELSE
          LET g_oep.oepconf='N'
      END IF

      LET g_oep.oepmodu = g_user
      LET g_oep.oepdate = g_today

      UPDATE oep_file
          SET oepconf=g_oep.oepconf,
              oepmodu=g_user,
              oepdate=g_today
          WHERE oep01 = g_oep.oep01
            AND oep02 = g_oep.oep02
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
          CALL cl_err(g_oep.oepconf,SQLCA.sqlcode,0)
          LET g_oep.oepconf=g_chr
      END IF
      DISPLAY BY NAME g_oep.oepconf
   END IF

   CLOSE t800_cl
   COMMIT WORK
   CALL cl_flow_notify(g_oep.oep01,'V') #CHI-A80030 add

    #CKP
    IF g_oep.oepconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_oep.oep09  ='1' OR
       g_oep.oep09  ='3' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_oep.oepconf,g_chr2,"","",g_chr,"")


END FUNCTION

FUNCTION t800_ef()

  CALL t800_y_chk()          #CALL 原確認的 check 段
  IF g_success = "N" THEN
      RETURN
  END IF

  CALL t800_hu1() #客戶信用查核
  IF g_success = 'N' THEN
      RETURN
  END IF

  CALL aws_condition()                            #判斷送簽資料
  IF g_success = 'N' THEN
        RETURN
  END IF
  #add by songlb 变更送签OA时的oeaud02字段重新根据物料取
  CALL t800_oeaud02_upd()
##########
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########
   IF aws_efcli2(base.TypeInfo.create(g_oep),base.TypeInfo.create(g_oeq),'','','','') THEN
      LET g_success = 'Y'
      LET g_oep.oep09 = 'S'   #開單成功, 更新狀態碼為 'S. 送簽中'
      DISPLAY BY NAME g_oep.oep09
   ELSE
      LET g_success = 'N'
   END IF

END FUNCTION

#MOD-A50049 --begin--
#FUNCTION t800_chk_oea06()
#  DEFINE l_dbs_new      LIKE type_file.chr21   #No.FUN-680137 VARCHAR(21)    #New DataBase Name
#  DEFINE l_azp03        LIKE azp_file.azp03
#  DEFINE l_last         LIKE type_file.num5    #No.FUN-680137 SMALLINT     #流程之最後家數
#  DEFINE i              LIKE type_file.num5    #No.FUN-680137 SMALLINT
#  DEFINE l_plant        LIKE cre_file.cre08    #No.FUN-680137 VARCHAR(10)
#  DEFINE l_sql          LIKE type_file.chr1000 #No.FUN-680137 VARCHAR(1000)
#  DEFINE l_oea904       LIKE oea_file.oea904
#  DEFINE l_oea06        LIKE oea_file.oea06
#  DEFINE l_dbs_tra      LIKE azw_file.azw05        #FUN-980093 add
#  DEFINE l_plant_new    LIKE azp_file.azp01        #FUN-980093 add
#
#  LET l_oea904=''
#  LET l_azp03=''
#  LET l_dbs_new=''
#  LET l_last=''
#  LET l_plant=' '
#  LET l_oea06=0
#  SELECT oea904 INTO l_oea904 FROM oea_file WHERE oea01=g_oep.oep01
#  SELECT MAX(poy02) INTO l_last FROM poy_file WHERE poy01=l_oea904
#
#  #依流程代碼最多6層
#  FOR i = 1 TO l_last
#      SELECT poy04 INTO l_plant FROM poy_file
#       WHERE poy01 = l_oea904  AND poy02 = i
#      SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=l_plant
#      LET l_dbs_new = l_azp03 CLIPPED,"."
#
#      # FUN-980093 add----GP5.2 Modify #改抓Transaction DB
#       LET g_plant_new = l_plant
#       LET l_plant_new = g_plant_new
#       CALL s_getdbs()
#       LET l_dbs_new = g_dbs_new
#       CALL s_gettrandbs()
#       LET l_dbs_tra = g_dbs_tra
#
#      LET l_sql  = "SELECT oea06 ",
#                   "  FROM ",l_dbs_tra CLIPPED,"oea_file ", #FUN-980093 add
#                   " WHERE oea99='",g_oea.oea99,"' "   #MOD-740444  #MOD-760026 modify
#        CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032  #FUN-950007 add
#       CALL cl_parse_qry_sql(l_sql,l_plant_new) RETURNING l_sql #FUN-980093
#      PREPARE oea06_p1 FROM l_sql
#      DECLARE oea06_c1 CURSOR FOR oea06_p1
#      OPEN oea06_c1
#      FETCH oea06_c1 INTO l_oea06
#      CLOSE oea06_c1
#      IF l_oea06 <> g_oep.oep02 THEN
#         CALL cl_err(l_plant,'tri-030',1)
#         UPDATE oep_file SET oep09 = '1'
#          WHERE oep01 = g_oep.oep01
#            AND oep02 = g_oep.oep02  #MOD-8A0155
#         IF SQLCA.sqlcode THEN
#             CALL cl_err3("upd","oep_file",g_oep.oep01,"",SQLCA.sqlcode,"","",0)
#             LET g_success = 'N'
#         END IF
#      END IF
#  END FOR
#END FUNCTION
##MOD-A50049 --end--

FUNCTION t800_set_origin_field()
  DEFINE    l_tot    LIKE img_file.img10,
            l_unit2  LIKE oeb_file.oeb913,
            l_fac2   LIKE oeb_file.oeb914,
            l_qty2   LIKE oeb_file.oeb915,
            l_unit1  LIKE oeb_file.oeb910,
            l_fac1   LIKE oeb_file.oeb911,
            l_qty1   LIKE oeb_file.oeb912,
            l_oeq05  LIKE oeb_file.oeb05,
            l_oeq12  LIKE oeb_file.oeb12,
            l_factor LIKE img_file.img21  #No.FUN-680137 DECIMAL(16,8)

    LET l_unit2=g_oeq[l_ac].oeq23b
    LET l_fac2 =g_oeq[l_ac].oeq24b
    LET l_qty2 =g_oeq[l_ac].oeq25b
    LET l_unit1=g_oeq[l_ac].oeq20b
    LET l_fac1 =g_oeq[l_ac].oeq21b
    LET l_qty1 =g_oeq[l_ac].oeq22b
    IF NOT cl_null(g_oeq[l_ac].oeq23a) THEN
       LET l_unit2=g_oeq[l_ac].oeq23a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq24a) THEN
       LET l_fac2=g_oeq[l_ac].oeq24a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq25a) THEN
       LET l_qty2=g_oeq[l_ac].oeq25a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq20a) THEN
       LET l_unit1=g_oeq[l_ac].oeq20a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq21a) THEN
       LET l_fac1=g_oeq[l_ac].oeq21a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq22a) THEN
       LET l_qty1=g_oeq[l_ac].oeq22a
    END IF

    LET g_oeq[l_ac].oeq12a = NULL    #No:MOD-640429 add

    IF cl_null(l_fac1) THEN LET l_fac1=1 END IF
    IF cl_null(l_qty1) THEN LET l_qty1=0 END IF
    IF cl_null(l_fac2) THEN LET l_fac2=1 END IF
    IF cl_null(l_qty2) THEN LET l_qty2=0 END IF

    IF g_sma.sma115 = 'Y' THEN
       CASE g_ima906
          WHEN '1' LET l_oeq05 =l_unit1
                   LET l_oeq12 =l_qty1
          WHEN '2' LET l_tot=l_fac1*l_qty1+l_fac2*l_qty2
                   LET l_oeq05 =g_ima31
                   LET l_oeq12 =l_tot
          WHEN '3' LET l_oeq05 =l_unit1
                   LET l_oeq12 =l_qty1
       END CASE
    #ELSE  #不使用雙單位   #MOD-A80114
    #   LET l_oeq05 =l_unit1   #MOD-A80114
    #   LET l_oeq12 =l_qty1    #MOD-A80114
    END IF
    #看是否要存不變的東西
    #IF cl_null(g_oeq[l_ac].oeq05a) OR g_oeq[l_ac].oeq05b <> l_oeq05 THEN   #MOD-A80114
     IF NOT cl_null(g_oeq[l_ac].oeq20a) THEN #MOD-C50154 add
       LET g_oeq[l_ac].oeq05a=l_oeq05
     END IF   #MOD-A80114 #MOD-C50154 remark
    #IF cl_null(g_oeq[l_ac].oeq12a) OR g_oeq[l_ac].oeq12b <> l_oeq12 THEN   #MOD-A80114
     IF NOT cl_null(g_oeq[l_ac].oeq22a) THEN #MOD-C50154 add
       LET g_oeq[l_ac].oeq12a=l_oeq12
       LET g_oeq[l_ac].oeq12a=s_digqty(g_oeq[l_ac].oeq12a,g_oeq[l_ac].oeq05a)  #FUN-910088--add--
    END IF   #MOD-A80114 #MOD-C50154 remark
END FUNCTION

FUNCTION t800_qty_check()
  DEFINE l_oeb12 LIKE oeb_file.oeb12
  DEFINE l_oeb23 LIKE oeb_file.oeb23    #No:MOD-640304 add

    IF NOT cl_null(g_oeq[l_ac].oeq12a)  THEN
       IF g_oea.oea37 = "Y" THEN   #No:FUN-640025
          IF g_oeq[l_ac].oeq12a < g_oeb920 THEN
             CALL cl_err('','axm-037',0)
             RETURN 1
          END IF
       END IF
       IF g_oeq[l_ac].oeq04b IS NOT NULL THEN
          IF g_oeq[l_ac].oeq12a <> g_oeq[l_ac].oeq12b THEN
             LET l_oeb12 = 0                               #MOD-940401 add
             LET l_oeb23 = 0                               #MOD-940401 add
             SELECT oeb24-oeb25,oeb23 INTO l_oeb12,l_oeb23 FROM oeb_file     #No:MOD-640304 modify
              WHERE oeb01 = g_oep.oep01
                AND oeb03 = g_oeq[l_ac].oeq03
             #-----MOD-B60008---------
             #IF l_oeb23 > g_oeq[l_ac].oeq12a  THEN
             #   CALL cl_err('','axm-814',0)
             #   RETURN 1
             #ELSE
             #   IF l_oeb12 > g_oeq[l_ac].oeq12a  THEN
             #      CALL cl_err('','axm-801',0)
             #      RETURN 1
             #   ELSE
             #      IF NOT cl_null(g_oeq[l_ac].oeq12a) OR
             #         NOT cl_null(g_oeq[l_ac].oeq13a) THEN
	     #         CALL t800_oeq14a()   #MOD-690091 add
             #      END IF
             #   END IF
             #END IF
             IF l_oeb12 + l_oeb23 > g_oeq[l_ac].oeq12a THEN
                CALL cl_err('','axm0007',0)
                RETURN 1
             ELSE
                IF NOT cl_null(g_oeq[l_ac].oeq12a) OR
                   NOT cl_null(g_oeq[l_ac].oeq13a) THEN
	           CALL t800_oeq14a()
                END IF
             END IF
             #-----END MOD-B60008-----
          END IF
       END IF
    END IF
    RETURN 0
END FUNCTION

FUNCTION t800_b_move_to()
   LET g_oeq[l_ac].before=0
   LET g_oeq[l_ac].after=1
   LET g_oeq[l_ac].oeq03=b_oeq.oeq03
   LET g_oeq[l_ac].oeq04b=b_oeq.oeq04b
   LET g_oeq[l_ac].oeq041b=b_oeq.oeq041b
   LET g_oeq[l_ac].oeq11b=b_oeq.oeq11b     #FUN-C60076
   LET g_oeq[l_ac].oeq30b=b_oeq.oeq30b
   LET g_oeq[l_ac].oeq05b=b_oeq.oeq05b
   LET g_oeq[l_ac].oeq12b=b_oeq.oeq12b
   LET g_oeq[l_ac].oeq23b=b_oeq.oeq23b
   LET g_oeq[l_ac].oeq24b=b_oeq.oeq24b
   LET g_oeq[l_ac].oeq25b=b_oeq.oeq25b
   LET g_oeq[l_ac].oeq20b=b_oeq.oeq20b
   LET g_oeq[l_ac].oeq21b=b_oeq.oeq21b
   LET g_oeq[l_ac].oeq22b=b_oeq.oeq22b
   LET g_oeq[l_ac].oeq26b=b_oeq.oeq26b
   LET g_oeq[l_ac].oeq27b=b_oeq.oeq27b
   LET g_oeq[l_ac].oeq13b=b_oeq.oeq13b
   LET g_oeq[l_ac].oeq14b=b_oeq.oeq14b
   LET g_oeq[l_ac].oeq14tb=b_oeq.oeq14tb   #MOD-A70005
   LET g_oeq[l_ac].oeq15b=b_oeq.oeq15b
   LET g_oeq[l_ac].oeq28b=b_oeq.oeq28b
   LET g_oeq[l_ac].oeq29b=b_oeq.oeq29b
   LET g_oeq[l_ac].oeq04a=b_oeq.oeq04a
   LET g_oeq[l_ac].oeq041a=b_oeq.oeq041a
   LET g_oeq[l_ac].oeq11a=b_oeq.oeq11a     #FUN-C60076
   LET g_oeq[l_ac].oeq30a=b_oeq.oeq30a
   LET g_oeq[l_ac].oeq05a=b_oeq.oeq05a
   LET g_oeq[l_ac].oeq12a=b_oeq.oeq12a
   LET g_oeq[l_ac].oeq23a=b_oeq.oeq23a
   LET g_oeq[l_ac].oeq24a=b_oeq.oeq24a
   LET g_oeq[l_ac].oeq25a=b_oeq.oeq25a
   LET g_oeq[l_ac].oeq20a=b_oeq.oeq20a
   LET g_oeq[l_ac].oeq21a=b_oeq.oeq21a
   LET g_oeq[l_ac].oeq22a=b_oeq.oeq22a
   LET g_oeq[l_ac].oeq26a=b_oeq.oeq26a
   LET g_oeq[l_ac].oeq27a=b_oeq.oeq27a
   LET g_oeq[l_ac].oeq13a=b_oeq.oeq13a
   LET g_oeq[l_ac].oeq37a=b_oeq.oeq37a     #FUN-AB0082
   LET g_oeq[l_ac].oeq37b=b_oeq.oeq37b     #FUN-AB0082
   LET g_oeq[l_ac].oeq14a=b_oeq.oeq14a
   LET g_oeq[l_ac].oeq14ta=b_oeq.oeq14ta   #MOD-A70005
   LET g_oeq[l_ac].oeq15a=b_oeq.oeq15a
   LET g_oeq[l_ac].oeq28a=b_oeq.oeq28a
   LET g_oeq[l_ac].oeq29a=b_oeq.oeq29a
   LET g_oeq[l_ac].oeq50=b_oeq.oeq50
   #FUN-A80118-- Add--Begin
   LET g_oeq[l_ac].oeq31a=b_oeq.oeq31a
   LET g_oeq[l_ac].oeq32a=b_oeq.oeq32a
   LET g_oeq[l_ac].oeq33a=b_oeq.oeq33a
   LET g_oeq[l_ac].oeq31b=b_oeq.oeq31b
   LET g_oeq[l_ac].oeq32b=b_oeq.oeq32b
   LET g_oeq[l_ac].oeq33b=b_oeq.oeq33b
   #FUN-A80118-- Add--End
END FUNCTION

FUNCTION t800_b_move_back()
   LET b_oeq.oeq01=g_oep.oep01
   LET b_oeq.oeq02=g_oep.oep02
   LET b_oeq.oeq03=g_oeq[l_ac].oeq03
   LET b_oeq.oeq04b=g_oeq[l_ac].oeq04b
   LET b_oeq.oeq041b=g_oeq[l_ac].oeq041b
   LET b_oeq.oeq11b=g_oeq[l_ac].oeq11b     #FUN-C60076
   LET b_oeq.oeq05b=g_oeq[l_ac].oeq05b
   LET b_oeq.oeq12b=g_oeq[l_ac].oeq12b
   LET b_oeq.oeq13b=g_oeq[l_ac].oeq13b
   LET b_oeq.oeq14b=g_oeq[l_ac].oeq14b
   #LET b_oeq.oeq14tb=t_oeq14tb   #MOD-A70005
   LET b_oeq.oeq14tb=g_oeq[l_ac].oeq14tb   #MOD-A70005
   LET b_oeq.oeq15b=g_oeq[l_ac].oeq15b
   LET b_oeq.oeq04a=g_oeq[l_ac].oeq04a
   LET b_oeq.oeq041a=g_oeq[l_ac].oeq041a
   LET b_oeq.oeq11a=g_oeq[l_ac].oeq11a     #FUN-C60076
   LET b_oeq.oeq05a=g_oeq[l_ac].oeq05a
   LET b_oeq.oeq12a=g_oeq[l_ac].oeq12a
   LET b_oeq.oeq13a=g_oeq[l_ac].oeq13a
   LET b_oeq.oeq37a=g_oeq[l_ac].oeq37a     #FUN-AB0082
   LET b_oeq.oeq37b=g_oeq[l_ac].oeq37b     #FUN-AB0082
   LET b_oeq.oeq14a=g_oeq[l_ac].oeq14a
  #LET b_oeq.oeq14ta=t_oeq14ta   #MOD-A70005
   LET b_oeq.oeq14ta=g_oeq[l_ac].oeq14ta   #MOD-A70005
   LET b_oeq.oeq15a=g_oeq[l_ac].oeq15a
   #add by donghy 150921
   LET b_oeq.ta_oeq01a=g_oeq[l_ac].ta_oeq01a
   LET b_oeq.ta_oeq02a=g_oeq[l_ac].ta_oeq02a
   LET b_oeq.ta_oeq03a=g_oeq[l_ac].ta_oeq03a
   LET b_oeq.ta_oeq04a=g_oeq[l_ac].ta_oeq04a
   LET b_oeq.ta_oeq05a=g_oeq[l_ac].ta_oeq05a
   LET b_oeq.ta_oeq06a=g_oeq[l_ac].ta_oeq06a
   LET b_oeq.ta_oeq07a=g_oeq[l_ac].ta_oeq07a
   LET b_oeq.ta_oeq08a=g_oeq[l_ac].ta_oeq08a
   LET b_oeq.ta_oeq09a=g_oeq[l_ac].ta_oeq09a
   LET b_oeq.ta_oeq10a=g_oeq[l_ac].ta_oeq10a
   LET b_oeq.ta_oeq11a=g_oeq[l_ac].ta_oeq11a

   LET b_oeq.oeq50=g_oeq[l_ac].oeq50
   LET b_oeq.oeq20b=g_oeq[l_ac].oeq20b
   LET b_oeq.oeq21b=g_oeq[l_ac].oeq21b
   LET b_oeq.oeq22b=g_oeq[l_ac].oeq22b
   LET b_oeq.oeq23b=g_oeq[l_ac].oeq23b
   LET b_oeq.oeq24b=g_oeq[l_ac].oeq24b
   LET b_oeq.oeq25b=g_oeq[l_ac].oeq25b
   LET b_oeq.oeq26b=g_oeq[l_ac].oeq26b
   LET b_oeq.oeq27b=g_oeq[l_ac].oeq27b
   LET b_oeq.oeq20a=g_oeq[l_ac].oeq20a
   LET b_oeq.oeq21a=g_oeq[l_ac].oeq21a
   LET b_oeq.oeq22a=g_oeq[l_ac].oeq22a
   LET b_oeq.oeq23a=g_oeq[l_ac].oeq23a
   LET b_oeq.oeq24a=g_oeq[l_ac].oeq24a
   LET b_oeq.oeq25a=g_oeq[l_ac].oeq25a
   LET b_oeq.oeq26a=g_oeq[l_ac].oeq26a
   LET b_oeq.oeq27a=g_oeq[l_ac].oeq27a
   LET b_oeq.oeq28a=g_oeq[l_ac].oeq28a
   LET b_oeq.oeq28b=g_oeq[l_ac].oeq28b
   LET b_oeq.oeq29a=g_oeq[l_ac].oeq29a
   LET b_oeq.oeq29b=g_oeq[l_ac].oeq29b
   LET b_oeq.oeq30a=g_oeq[l_ac].oeq30a
   LET b_oeq.oeq30b=g_oeq[l_ac].oeq30b

   LET b_oeq.oeqplant = g_plant
   LET b_oeq.oeqlegal = g_legal
   #FUN-A80118-- Add--Begin
   LET b_oeq.oeq31a=g_oeq[l_ac].oeq31a
   LET b_oeq.oeq32a=g_oeq[l_ac].oeq32a
   LET b_oeq.oeq33a=g_oeq[l_ac].oeq33a
   LET b_oeq.oeq31b=g_oeq[l_ac].oeq31b
   LET b_oeq.oeq32b=g_oeq[l_ac].oeq32b
   LET b_oeq.oeq33b=g_oeq[l_ac].oeq33b
   #FUN-A80118-- Add--End

   #add by donghy 150921
   LET b_oeq.ta_oeq01b=g_oeq[l_ac].ta_oeq01b
   LET b_oeq.ta_oeq02b=g_oeq[l_ac].ta_oeq02b
   LET b_oeq.ta_oeq03b=g_oeq[l_ac].ta_oeq03b
   LET b_oeq.ta_oeq04b=g_oeq[l_ac].ta_oeq04b
   LET b_oeq.ta_oeq05b=g_oeq[l_ac].ta_oeq05b
   LET b_oeq.ta_oeq06b=g_oeq[l_ac].ta_oeq06b
   LET b_oeq.ta_oeq07b=g_oeq[l_ac].ta_oeq07b
   LET b_oeq.ta_oeq08b=g_oeq[l_ac].ta_oeq08b
   LET b_oeq.ta_oeq09b=g_oeq[l_ac].ta_oeq09b
   LET b_oeq.ta_oeq10b=g_oeq[l_ac].ta_oeq10b
   LET b_oeq.ta_oeq11b=g_oeq[l_ac].ta_oeq11b
END FUNCTION

#用于default 雙單位/轉換率/數量
FUNCTION t800_du_default(p_cmd)
  DEFINE    l_item   LIKE img_file.img01,     #料號
            l_ima25  LIKE ima_file.ima25,     #ima單位
            l_ima31  LIKE ima_file.ima31,
            l_ima906 LIKE ima_file.ima906,
            l_ima907 LIKE ima_file.ima907,
            l_ima908 LIKE ima_file.ima907,
            l_unit2  LIKE img_file.img09,     #第二單位
            l_fac2   LIKE img_file.img21,     #第二轉換率
            l_qty2   LIKE img_file.img10,     #第二數量
            l_unit1  LIKE img_file.img09,     #第一單位
            l_fac1   LIKE img_file.img21,     #第一轉換率
            l_qty1   LIKE img_file.img10,     #第一數量
            l_unit3  LIKE img_file.img09,     #計價單位
            l_qty3   LIKE img_file.img10,     #計價數量
            p_cmd    LIKE type_file.chr1,    #No.FUN-680137 VARCHAR(1)
            l_factor LIKE img_file.img21  #No.FUN-680137 DECIMAL(16,8)

    LET l_item = g_oeq[l_ac].oeq04a

    SELECT ima25,ima31,ima906,ima907,ima908
      INTO l_ima25,l_ima31,l_ima906,l_ima907,l_ima908
      FROM ima_file WHERE ima01 = l_item

    IF l_ima906 = '1' THEN  #不使用雙單位
       LET l_unit2 = NULL
       LET l_fac2  = NULL
       LET l_qty2  = NULL
    ELSE
       LET l_unit2 = l_ima907
       CALL s_du_umfchk(l_item,'','','',l_ima31,l_ima907,l_ima906)
            RETURNING g_errno,l_factor
       LET l_fac2 = l_factor
       LET l_qty2  = 0
    END IF

    LET l_unit1 = l_ima31
    LET l_fac1  = 1
    LET l_qty1  = 0

    IF g_sma.sma116 MATCHES '[01]' THEN    #No:FUN-610076
       LET l_unit3 = NULL
       LET l_qty3  = NULL
    ELSE
       LET l_unit3 = l_ima908
       LET l_qty3  = 0
    END IF

    #IF p_cmd = 'a' THEN   #MOD-A40018
       LET g_oeq[l_ac].oeq23a=l_unit2
       LET g_oeq[l_ac].oeq24a=l_fac2
       LET g_oeq[l_ac].oeq25a=l_qty2
       LET g_oeq[l_ac].oeq25a = s_digqty(g_oeq[l_ac].oeq25a,g_oeq[l_ac].oeq23a)  #FUN-910088--add--
       LET g_oeq[l_ac].oeq20a=l_unit1
       LET g_oeq[l_ac].oeq21a=l_fac1
       LET g_oeq[l_ac].oeq22a=l_qty1
       LET g_oeq[l_ac].oeq22a = s_digqty(g_oeq[l_ac].oeq22a,g_oeq[l_ac].oeq20a)  #FUN910088--add--
       LET g_oeq[l_ac].oeq26a=l_unit3
       LET g_oeq[l_ac].oeq27a=l_qty3
       LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)  #FUN910088--add--
    #END IF   #MOD-A40018
END FUNCTION

FUNCTION t800_set_oeq27()
  DEFINE    l_item   LIKE img_file.img01,     #料號
            l_ima25  LIKE ima_file.ima25,     #ima單位
            l_ima31  LIKE ima_file.ima31,     #銷售單位
            l_ima906 LIKE ima_file.ima906,
            l_oeq04  LIKE oeq_file.oeq04a,
            l_oeq05  LIKE oeq_file.oeq05a,
            l_oeq26  LIKE oeq_file.oeq26a,
            l_fac2   LIKE img_file.img21,     #第二轉換率
            l_qty2   LIKE img_file.img10,     #第二數量
            l_fac1   LIKE img_file.img21,     #第一轉換率
            l_qty1   LIKE img_file.img10,     #第一數量
            l_tot    LIKE img_file.img10,     #計價數量
            l_factor LIKE img_file.img21, #No.FUN-680137 DECIMAL(16,8)
            #add--TQC-CB0032
            l_sic06_07 LIKE img_file.img10, #備置數量
            l_sic06  LIKE sic_file.sic06,
            l_sic07_fac LIKE sic_file.sic07_fac,
            l_sic_fac  LIKE img_file.img21,
            l_sic_oeq27 LIKE img_file.img10
           #add--TQC-CB003

    LET l_oeq04 = g_oeq[l_ac].oeq04b
    IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
       LET l_oeq04 = g_oeq[l_ac].oeq04a
    END IF
    SELECT ima25,ima31,ima906 INTO l_ima25,l_ima31,l_ima906
      FROM ima_file WHERE ima01=l_oeq04
    IF SQLCA.sqlcode THEN
       IF l_oeq04 MATCHES 'MISC*' THEN
          SELECT ima25,ima31,ima906 INTO l_ima25,l_ima31,l_ima906
            FROM ima_file WHERE ima01='MISC'
       END IF
    END IF

    LET l_fac2=g_oeq[l_ac].oeq24b
    LET l_qty2=g_oeq[l_ac].oeq25b
    IF NOT cl_null(g_oeq[l_ac].oeq24a) THEN
       LET l_fac2=g_oeq[l_ac].oeq24a
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq25a) THEN
       LET l_qty2=g_oeq[l_ac].oeq25a
    END IF
    #MOD-C10080 add --start--
    LET l_oeq05=g_oeq[l_ac].oeq05b
    IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
       LET l_oeq05=g_oeq[l_ac].oeq05a
    END IF
    #MOD-C10080 add --end--
    IF g_sma.sma115 = 'Y' THEN
       LET l_fac1=g_oeq[l_ac].oeq21b
       LET l_qty1=g_oeq[l_ac].oeq22b
       IF NOT cl_null(g_oeq[l_ac].oeq21a) THEN
          LET l_fac1=g_oeq[l_ac].oeq21a
       END IF
       IF NOT cl_null(g_oeq[l_ac].oeq22a) THEN
          LET l_qty1=g_oeq[l_ac].oeq22a
       END IF
    ELSE
       LET l_fac1=1
       LET l_qty1=g_oeq[l_ac].oeq12b
       IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
          LET l_qty1=g_oeq[l_ac].oeq12a
       END IF
      #MOD-C10080 mark --start--
      #LET l_oeq05=g_oeq[l_ac].oeq05b
      #IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
      #   LET l_oeq05=g_oeq[l_ac].oeq05a
      #END IF
      #MOD-C10080 mark --end--
       CALL s_umfchk(l_oeq04,l_oeq05,l_ima31)
             RETURNING g_cnt,l_fac1
       IF g_cnt = 1 THEN
          LET l_fac1 = 1
       END IF
    END IF
    IF cl_null(l_fac1) THEN LET l_fac1=1 END IF
    IF cl_null(l_qty1) THEN LET l_qty1=0 END IF
    IF cl_null(l_fac2) THEN LET l_fac2=1 END IF
    IF cl_null(l_qty2) THEN LET l_qty2=0 END IF

    IF g_sma.sma115 = 'Y' THEN
       CASE l_ima906
          WHEN '1' LET l_tot=l_qty1*l_fac1
          WHEN '2' LET l_tot=l_qty1*l_fac1+l_qty2*l_fac2
          WHEN '3' LET l_tot=l_qty1*l_fac1
       END CASE
    ELSE  #不使用雙單位
       LET l_tot=l_qty1*l_fac1
    END IF
    IF cl_null(l_tot) THEN LET l_tot = 0 END IF
    LET l_oeq26 = g_oeq[l_ac].oeq26b
    IF NOT cl_null(g_oeq[l_ac].oeq26a) THEN
       LET l_oeq26=g_oeq[l_ac].oeq26a
    END IF

   SELECT ima906 INTO l_ima906
     FROM ima_file
    WHERE ima01 = l_item


    LET l_factor = 1
    IF g_sma.sma115 = 'Y' THEN
       CALL s_umfchk(l_oeq04,g_oeq[l_ac].oeq05a,l_oeq26)
             RETURNING g_cnt,l_factor
    ELSE
    CALL s_umfchk(l_oeq04,l_ima31,l_oeq26)
          RETURNING g_cnt,l_factor
    END IF                           #No.CHI-960052
    IF g_cnt = 1 THEN
       LET l_factor = 1
    END IF
    LET l_tot = l_tot * l_factor

    IF cl_null(g_oeq[l_ac].oeq27b) OR
       NOT cl_null(g_oeq[l_ac].oeq27b) AND l_tot <> g_oeq[l_ac].oeq27b THEN
       LET g_oeq[l_ac].oeq27a = l_tot
       LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)  #FUN-910088-add
    END IF
    IF g_sma.sma115 = 'N' THEN
       IF g_oeq[l_ac].oeq05a = g_oeq[l_ac].oeq26b AND cl_null(g_oeq[l_ac].oeq26a) THEN
          IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
             LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
          ELSE
             LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12b
          END IF
          LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)  #FUN-910088-add
       END IF
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq26a) AND NOT cl_null(g_oeq[l_ac].oeq05a) THEN
       IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq05a THEN
          IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
             LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
          ELSE
             LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12b
          END IF
          LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)  #FUN-910088-add
       END IF
    END IF
   #add--str--TQC-CB0032
   LET l_sic06_07 = 0
   LET g_errno = ''
   DECLARE t800_sic_sel CURSOR FOR SELECT sic06,sic07_fac FROM sic_file,sia_file
    WHERE sic01= sia01 AND sic03 = g_oep.oep01
      AND sic15 = g_oeq[l_ac].oeq03
      AND siaconf = 'Y'
   LET l_sic06_07 = 0
   FOREACH t800_sic_sel INTO l_sic06,l_sic07_fac
      LET l_sic06_07 = l_sic06_07 + l_sic06 * l_sic07_fac
   END FOREACH
   IF cl_null(l_sic06_07) THEN LET l_sic06_07 = 0 END IF
   CALL s_umfchk(l_oeq04,l_oeq26,l_ima25)
      RETURNING g_cnt,l_sic_fac
   IF g_cnt = 1 THEN
      LET l_sic_fac = 1
   END IF
   LET l_sic_oeq27 = g_oeq[l_ac].oeq27a * l_sic_fac
   IF l_sic_oeq27 < l_sic06_07 THEN
      LET g_errno = 'axm-072'
   END IF
  #add--end--TQC-CB0032
END FUNCTION

FUNCTION t800_def_form()
    CALL cl_set_comp_visible("oeq21b,oeq24b,oeq21a,oeq24a",FALSE)
    CALL cl_set_comp_visible("dummy21,dummy24",FALSE)
    IF g_sma.sma115 ='N' THEN
       CALL cl_set_comp_visible("oeq23b,oeq24b,oeq25b",FALSE)
       CALL cl_set_comp_visible("oeq20b,oeq21b,oeq22b",FALSE)
       CALL cl_set_comp_visible("oeq23a,oeq24a,oeq25a",FALSE)
       CALL cl_set_comp_visible("oeq20a,oeq21a,oeq22a",FALSE)
       CALL cl_set_comp_visible("dummy23,dummy24,dummy25,dummy20,dummy21,dummy22",FALSE)
    ELSE
       CALL cl_set_comp_visible("oeq05b,oeq12b",FALSE)
       CALL cl_set_comp_visible("oeq05a,oeq12a",FALSE)
       CALL cl_set_comp_visible("dummy05,dummy06",FALSE)
    END IF
    IF g_sma.sma116 MATCHES '[01]' THEN    #No:FUN-610076
       CALL cl_set_comp_visible("oeq26b,oeq27b",FALSE)
       CALL cl_set_comp_visible("oeq26a,oeq27a",FALSE)
       CALL cl_set_comp_visible("dummy26,dummy27",FALSE)
    END IF
    IF g_sma.sma122 ='1' THEN
       CALL cl_getmsg('asm-302',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy23",g_msg CLIPPED)
       CALL cl_getmsg('asm-306',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy25",g_msg CLIPPED)
       CALL cl_getmsg('asm-303',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy20",g_msg CLIPPED)
       CALL cl_getmsg('asm-307',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy22",g_msg CLIPPED)
    END IF
    IF g_sma.sma122 ='2' THEN
       CALL cl_getmsg('asm-304',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy23",g_msg CLIPPED)
       CALL cl_getmsg('asm-308',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy25",g_msg CLIPPED)
       CALL cl_getmsg('asm-324',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy20",g_msg CLIPPED)
       CALL cl_getmsg('asm-325',g_lang) RETURNING g_msg
       CALL cl_set_comp_lab_text("dummy22",g_msg CLIPPED)
    END IF
   #MOD-C50002---S---
    IF g_azw.azw04 <> '2' THEN
      CALL cl_set_comp_visible("oeq37b,oeq37a",FALSE)
      CALL cl_set_comp_visible("dummy1",FALSE)
    END IF
   #MOD-C50002---E---
END FUNCTION

FUNCTION t800_set_no_required(p_newline)
   DEFINE p_newline LIKE type_file.chr1

   CALL cl_set_comp_required("oeq04a,oeq05a,oeq12a,oeq13a,oeq15a,oeq26a,oeq27a",FALSE)

END FUNCTION

FUNCTION t800_set_required(p_newline)
   DEFINE p_newline LIKE type_file.chr1

   IF p_newline = 'N' THEN  RETURN  END IF
   CALL cl_set_comp_required("oeq04a,oeq13a,oeq15a",TRUE)
   IF g_sma.sma115 = 'N' THEN
      CALL cl_set_comp_required("oeq05a,oeq12a",TRUE)
   END IF

   IF g_sma.sma116 MATCHES '[23]' THEN
      CALL cl_set_comp_required("oeq26a,oeq27a",TRUE)
   END IF

END FUNCTION

#此函數是為了金額計算與應收系統內的金額計算一致。
FUNCTION t800_amount(p_qty,p_price,p_rate,p_azi03)
DEFINE   p_qty      LIKE oeb_file.oeb12     #數量
DEFINE   p_price    LIKE oeb_file.oeb13     #單價(未折扣)
DEFINE   p_rate     LIKE oeb_file.oeb1006   #折扣率
DEFINE   p_azi03    LIKE azi_file.azi03     #單位取位位數
DEFINE   l_price    LIKE oeb_file.oeb13     #單價(已折扣)
DEFINE   l_amount   LIKE oeb_file.oeb14     #金額

    IF cl_null(p_rate) THEN
       LET p_rate = 100
    END IF
    LET l_price = cl_digcut(p_price*p_rate/100,p_azi03)   #折扣后單價
    LET l_amount= p_qty*l_price

    IF cl_null(l_amount) THEN
       LET l_amount = 0
    END IF

    RETURN l_amount
END FUNCTION
FUNCTION t800_chk_oeq13a(p_cmd) #FUN-9C0083
   DEFINE l_msg   LIKE type_file.chr1000
   DEFINE l_oeb13 LIKE oeb_file.oeb13
   DEFINE l_oeb17 LIKE oeb_file.oeb17
   DEFINE l_oeb1004 LIKE oeb_file.oeb1004 #FUN-9C0083
   DEFINE l_oea00   LIKE oea_file.oea00   #FUN-9C0083
   DEFINE l_oea02   LIKE oea_file.oea02   #FUN-9C0083
   DEFINE l_oea03   LIKE oea_file.oea03   #FUN-9C0083
   DEFINE p_cmd     LIKE type_file.chr1   #FUN-9C0083
   DEFINE l_azf08   LIKE azf_file.azf08   #MOD-9C0326
   DEFINE l_oeb1001 LIKE oeb_file.oeb1001   #MOD-9C0326
   DEFINE l_term    LIKE oep_file.oep10   #FUN-9C0152
      LET g_errno = ''   #MOD-880047
      SELECT oeb13 INTO l_oeb13
        FROM oeb_file
       WHERE oeb01 = g_oep.oep01
         AND oeb03 = g_oeq[l_ac].oeq03

       SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
        WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
       SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
        WHERE oea01=g_oep.oep01
       LET l_term=g_oep.oep10b  #FUN-9C0152
       IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF #FUN-9C0152
      #FUN-AB0082 Begin---
      #CALL s_fetch_price_new(l_oea03,g_oeq[l_ac].oeq04a,g_oeq[l_ac].oeq05a,l_oea02,
      #                       l_oea00,g_plant,g_oep.oep08b,l_term, #FUN-9C0152  g_oep.oep10b-->l_term
      #                       g_oep.oep07b,g_oep.oep01,g_oeq[l_ac].oeq03,
       LET g_oeq04f=g_oeq[l_ac].oeq04a
       LET g_oeq05f=g_oeq[l_ac].oeq05a
       LET g_oep07=g_oep.oep07b
       LET g_oep08=g_oep.oep08b
       IF cl_null(g_oep07) THEN LET g_oep07 = g_oep.oep07 END IF
       IF cl_null(g_oep08) THEN LET g_oep08 = g_oep.oep08 END IF
       IF cl_null(g_oeq04f) THEN LET g_oeq04f=g_oeq[l_ac].oeq04b END IF
       IF cl_null(g_oeq05f) THEN LET g_oeq05f=g_oeq[l_ac].oeq05b END IF
       CALL s_fetch_price_new(l_oea03,g_oeq04f,'',g_oeq05f,l_oea02,                 #FUN-BC0071
                              '1',g_plant,g_oep08,l_term, #FUN-9C0152  g_oep.oep10b-->l_term
                              g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
      #FUN-AB0082 End-----
                             #g_oeq[l_ac].oeq12a,l_oeb1004,p_cmd) #FUN-B10014
                              g_oeq[l_ac].oeq12a,l_oeb1004,'b')   #FUN-B10014
                  #RETURNING l_oeb17          #FUN-AB0082
                   RETURNING l_oeb17,g_oeq37a #FUN-AB0082
      LET l_oeb17 = l_oeb17 * (100-g_oaz.oaz185) / 100
      IF cl_null(g_oep.oep08b) THEN
         SELECT azi03 INTO t_azi03 FROM azi_file WHERE azi01=g_oep.oep08
      ELSE
         SELECT azi03 INTO t_azi03 FROM azi_file WHERE azi01=g_oep.oep08b
      END IF
      LET l_oeb17 = cl_digcut(l_oeb17,t_azi03)
      IF cl_null(g_oeq[l_ac].oeq30a) THEN
         LET l_oeb1001 = g_oeq[l_ac].oeq30b
      ELSE
         LET l_oeb1001 = g_oeq[l_ac].oeq30a
      END IF
      LET l_azf08 = ''
      SELECT azf08 INTO l_azf08 FROM azf_file
       WHERE azf01 = l_oeb1001
         AND azf02 = '2'
         AND azfacti ='Y'
      #檢查訂單單價是否低於取出單價(合約訂單不卡)
      IF g_oeq[l_ac].oeq13a < l_oeb17 AND (l_azf08='N' OR cl_null(l_azf08))THEN   #MOD-9C0326
         CASE g_oaz.oaz184
            WHEN 'R' CALL cl_err(l_oeb17,'axm-802',1)
                     LET g_errno = 'axm-802'   #MOD-880047
            WHEN 'W' #CALL cl_err(l_oeb17,'axm-802',1)
                     LET l_msg = cl_getmsg('axm-802',g_lang)
                     LET l_msg=l_msg CLIPPED,l_oeb17
                     CALL cl_msgany(10,20,l_msg)
            WHEN 'N' EXIT CASE
         END CASE
      END IF
END FUNCTION

FUNCTION t800_upd_ima33(p_cmd,p_oeq03,p_oeb04,p_oeb05)
 DEFINE p_oea     RECORD LIKE oea_file.*
 DEFINE l_fac     LIKE ima_file.ima31_fac       #單位換算率
 DEFINE l_ima31   LIKE ima_file.ima31           #銷售單位
 DEFINE l_rate    LIKE oea_file.oea24           #匯率
 DEFINE l_ima33   LIKE ima_file.ima33           #最近售價
 DEFINE l_check   LIKE type_file.chr1
 DEFINE l_exT     LIKE type_file.chr1
 DEFINE l_oeb13   LIKE oeb_file.oeb13           #單價
 DEFINE p_cmd     LIKE type_file.chr1,          #變更:修改/新增
        p_oeq03   LIKE oeq_file.oeq03,          #序號
        p_oeb04   LIKE oeb_file.oeb04,          #料號
        p_oeb05   LIKE oeb_file.oeb05           #單位

 SELECT oeb04,oeb05,oeb13 INTO p_oeb04,p_oeb05,l_oeb13  FROM oeb_file
  WHERE oeb01 = g_oep.oep01  AND oeb03 = p_oeq03

 SELECT * INTO p_oea.* FROM oea_file
     WHERE oea01 = g_oep.oep01

      #更新料件主檔的最近售價ima33
      #==>單位轉換
      SELECT ima31 INTO l_ima31 FROM ima_file
       WHERE ima01= p_oeb04
      IF p_oeb05 =l_ima31 THEN
          LET l_fac = 1
      ELSE
          CALL s_umfchk(p_oeb04,p_oeb05,l_ima31)
               RETURNING l_check,l_fac
      END IF


      #==>幣別匯率轉換
      IF p_oea.oea23 =g_aza.aza17 THEN
          LET l_rate =1
      ELSE
          IF p_oea.oea08='1' THEN
             LET l_exT=g_oaz.oaz52
          ELSE
             LET l_exT=g_oaz.oaz70
          END IF
          CALL s_curr3(p_oea.oea23,p_oea.oea02,l_exT)
                      RETURNING l_rate
      END IF
      #==>更新料件主檔的最近售價
      LET l_ima33 = (l_oeb13/l_fac) * l_rate
      CALL cl_digcut(l_ima33,t_azi03)RETURNING l_ima33     #No.CHI-6A0004
      UPDATE ima_file
         SET ima33 = l_ima33,
             imadate = g_today     #FUN-C30315 add
       WHERE ima01 = p_oeb04
END FUNCTION

FUNCTION t800_get_price()
  DEFINE  l_oep07       LIKE oep_file.oep07,
          l_oep08       LIKE oep_file.oep08,
          l_oep10       LIKE oep_file.oep10,
          l_oeq04       LIKE oeq_file.oeq04a,
          l_oeq05       LIKE oeq_file.oeq05a,
          l_oeq12       LIKE oeq_file.oeq12a,
          l_oeq13a      LIKE oeq_file.oeq13a,
          l_oea02       LIKE oea_file.oea02,
          l_oea03       LIKE oea_file.oea03,
          l_oea08       LIKE oea_file.oea08,
          l_oea21       LIKE oea_file.oea21,
          l_oea24       LIKE oea_file.oea24,
          l_oea25       LIKE oea_file.oea25,
          l_oea213      LIKE oea_file.oea213,
          l_oah03       LIKE oah_file.oah03,
          l_ima131      LIKE ima_file.ima131,
          l_occ20       LIKE occ_file.occ20,
          l_occ21       LIKE occ_file.occ21,
          l_occ22       LIKE occ_file.occ22

   IF cl_null(g_oep.oep07b) THEN
      LET l_oep07 = g_oep.oep07
   ELSE
      LET l_oep07 = g_oep.oep07b
   END IF
   IF cl_null(g_oep.oep08b) THEN
      LET l_oep08 = g_oep.oep08
   ELSE
      LET l_oep08 = g_oep.oep08b
   END IF
   IF cl_null(g_oep.oep10b) THEN
      LET l_oep10 = g_oep.oep10
   ELSE
      LET l_oep10 = g_oep.oep10b
   END IF
   IF cl_null(g_oeq[l_ac].oeq04a) THEN
      LET l_oeq04 = g_oeq[l_ac].oeq04b
   ELSE
      LET l_oeq04 = g_oeq[l_ac].oeq04a
   END IF
   IF cl_null(g_oeq[l_ac].oeq05a) THEN
      LET l_oeq05 = g_oeq[l_ac].oeq05b
   ELSE
      LET l_oeq05 = g_oeq[l_ac].oeq05a
   END IF
   IF cl_null(g_oeq[l_ac].oeq12a) THEN
      LET l_oeq12 = g_oeq[l_ac].oeq12b
   ELSE
      LET l_oeq12 = g_oeq[l_ac].oeq12a
   END IF
   SELECT oea02,oea03,oea08,oea21,oea25,oea213
     INTO l_oea02,l_oea03,l_oea08,l_oea21,l_oea25,l_oea213
    FROM oea_file
      WHERE oea01 = g_oep.oep01
   SELECT occ20,occ21,occ22 INTO l_occ20,l_occ21,l_occ22
     FROM occ_file
    WHERE occ01=l_oea03
      AND occacti='Y'
   SELECT ima131 INTO l_ima131 FROM ima_file
          WHERE ima01 = l_oeq04
   SELECT oah03 INTO l_oah03 FROM oah_file WHERE oah01 = l_oep10

   CASE WHEN l_oah03 = '0' RETURN ''   #MOD-8C0119
        WHEN l_oah03 = '1'
             IF l_oea213='Y' THEN
                SELECT ima128 INTO l_oeq13a FROM ima_file
                       WHERE ima01 = l_oeq04
             ELSE
                SELECT ima127 INTO l_oeq13a FROM ima_file
                       WHERE ima01 = l_oeq04
             END IF
             #->將單價除上匯率
             IF l_oea08='1' THEN
                LET exT=g_oaz.oaz52
             ELSE
                LET exT=g_oaz.oaz70
             END IF
             CALL s_curr3(l_oep08,l_oea02,exT) RETURNING l_oea24
             LET l_oeq13a=l_oeq13a/l_oea24
        WHEN l_oah03 = '2'
             DECLARE t800_get_price_c CURSOR FOR
                 SELECT obg21,
                        obg01,obg02,obg03,obg04,obg05,
                        obg06,obg22,obg07,obg08,obg09,obg10
                  FROM obg_file
                    WHERE (obg01 = l_ima131    OR obg01 = '*')
                      AND (obg02 = l_oeq04     OR obg02 = '*')
                      AND (obg03 = l_oeq05)
                      AND (obg04 = l_oea25     OR obg04 = '*')
                      AND (obg05 = l_oep10     OR obg05 = '*')
                      AND (obg06 = l_oea03     OR obg06 = '*')
                      AND (obg22 = l_occ22     OR obg22 = '*')
                      AND (obg07 = l_occ21     OR obg07 = '*')
                      AND (obg08 = l_occ20     OR obg08 = '*')
                      AND (obg09 = l_oep08)
                      AND (obg10 = l_oea21 OR obg10 = '*')
                 ORDER BY obg01 DESC,obg02 DESC,obg03 DESC,obg04 DESC,
                          obg05 DESC,obg06 DESC,obg07 DESC,obg08 DESC,
                          obg09 DESC,obg10 DESC
             FOREACH t800_get_price_c INTO l_oeq13a
               IF STATUS THEN CALL cl_err('foreach obg',STATUS,1) END IF
               EXIT FOREACH
             END FOREACH
        WHEN l_oah03 = '3'
           SELECT obk08 INTO l_oeq13a FROM obk_file
                  WHERE obk01 = l_oeq04 AND obk02 = l_oea03
                    AND obk05 = l_oep08
        WHEN l_oah03 = '4'
           IF g_sma.sma116 MATCHES '[23]' THEN
              IF NOT cl_null(g_oeq[l_ac].oeq26a) THEN
                 LET l_oeq05 = g_oeq[l_ac].oeq26a
              ELSE
                 LET l_oeq05 = g_oeq[l_ac].oeq26b
              END IF
              CALL s_price(l_oea02,l_oep10,l_oep08,l_oep07,
                           l_oea03,l_oeq04,l_oeq05,
                           l_oeq12,l_oah03)
              RETURNING l_oeq13a
           ELSE
              CALL s_price(l_oea02,l_oep10,l_oep08,l_oep07,
                           l_oea03,l_oeq04,l_oeq05,
                           l_oeq12,l_oah03)
              RETURNING l_oeq13a
           END IF   #No.MOD-8A0154
   END CASE

   RETURN l_oeq13a
END FUNCTION
FUNCTION t800_chk_oeq30a()
   DEFINE l_azf02   LIKE azf_file.azf02
   DEFINE l_azf09   LIKE azf_file.azf09
   DEFINE l_azf08b  LIKE azf_file.azf08
   DEFINE l_azf08   LIKE azf_file.azf08
   DEFINE l_count   LIKE type_file.num5


   IF NOT cl_null(g_oeq[l_ac].oeq30a) THEN
      IF g_oeq[l_ac].oeq30a != g_oeq_t.oeq30a
         OR cl_null(g_oeq_t.oeq30a) THEN
         SELECT azf09,azf08 INTO l_azf09,l_azf08 FROM azf_file
          WHERE azf01=g_oeq[l_ac].oeq30a
            AND azfacti='Y'
            AND azf02='2'  #TQC-740202
         IF l_azf09 != '1' THEN
            CALL cl_err('','aoo-400',1)
            RETURN FALSE
         END IF
         IF cl_null(l_azf08) THEN
            LET l_azf08 = 'N'
         END IF
         IF STATUS=100 THEN
            CALL cl_err3("sel","azf_file",g_oeq[l_ac].oeq30a,"","100","","",1)  #No.FUN-650108     #No.FUN-6B0065
            LET g_oeq[l_ac].oeq30a=g_oeq_t.oeq30a
            RETURN FALSE
         END IF
         SELECT COUNT(*) INTO l_count FROM ogb_file
          WHERE ogb31=g_oep.oep01
            AND ogb32=g_oeq[l_ac].oeq03
         IF l_count > 0 THEN
            SELECT azf08 INTO l_azf08b FROM azf_file
             WHERE azf01 = g_oeq[l_ac].oeq30b
               AND azf02 = '2'
            IF cl_null(l_azf08b) THEN
               LET l_azf08b = 'N'
            END IF
            IF l_azf08<>l_azf08b THEN
               CALL cl_err('','axm-230',1)
               RETURN FALSE
            END IF
         END IF
      END IF
   END IF
   LET g_oeq_t.oeq30a= g_oeq[l_ac].oeq30a
   RETURN TRUE
END FUNCTION

#-----FUN-A20057---------
FUNCTION t800_peo(p_cmd,p_key)
         DEFINE p_cmd       LIKE type_file.chr1,
                p_key       LIKE gen_file.gen01,
                l_gen02     LIKE gen_file.gen02,
                l_genacti   LIKE gen_file.genacti

        LET g_errno = ' '
        SELECT gen02,genacti INTO l_gen02,l_genacti
            FROM gen_file WHERE gen01 = p_key

        CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg1312'
                                       LET l_gen02 = NULL
               WHEN l_genacti='N' LET g_errno = '9028'
               OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
        END CASE
        DISPLAY l_gen02 TO FORMONLY.gen02
END FUNCTION
#-----END FUN-A20057-----
#No:FUN-9C0071--------精簡程式-----

#-----MOD-A40066---------
FUNCTION t800_chk_sfb()
  DEFINE l_oea904       LIKE oea_file.oea904
  DEFINE l_last         LIKE type_file.num5
  DEFINE i              LIKE type_file.num5
  DEFINE l_plant        LIKE cre_file.cre08
  DEFINE l_azp03        LIKE azp_file.azp03
  DEFINE l_dbs_new      LIKE type_file.chr21
  DEFINE l_sql          LIKE type_file.chr1000
  DEFINE l_oea01        LIKE oea_file.oea01
  DEFINE l_cnt          LIKE type_file.num5


  LET l_oea904=''
  LET l_last=''
  LET l_plant=' '
  LET l_azp03=''
  LET l_dbs_new=''

  SELECT oea904 INTO l_oea904 FROM oea_file WHERE oea01=g_oep.oep01
  SELECT MAX(poy02) INTO l_last FROM poy_file WHERE poy01=l_oea904
  SELECT oea99 INTO g_oea.oea99 FROM oea_file
   WHERE oea01=g_oep.oep01

  FOR i = 1 TO l_last
      SELECT poy04 INTO l_plant FROM poy_file
       WHERE poy01 = l_oea904  AND poy02 = i
      SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=l_plant
      LET l_dbs_new = l_azp03 CLIPPED,"."
      LET l_sql  = "SELECT oea01 ",
                   #"  FROM ",l_dbs_new CLIPPED,"oea_file ",
                   "  FROM ",cl_get_target_table(l_plant,'oea_file'), #FUN-A50102
                   " WHERE oea99='",g_oea.oea99,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
      CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql #FUN-A50102
      PREPARE oea01_p1 FROM l_sql
      DECLARE oea01_c1 CURSOR FOR oea01_p1
      OPEN oea01_c1
      FETCH oea01_c1 INTO l_oea01
      CLOSE oea01_c1
      LET l_cnt=0
      LET l_sql = "SELECT COUNT(*) ",
                  #"  FROM ",l_dbs_new CLIPPED,"sfb_file ",
                  "  FROM ",cl_get_target_table(l_plant,'sfb_file'), #FUN-A50102
                  " WHERE sfb22 ='",l_oea01,"' ",
                  "  AND sfb221 ='",g_oeq[l_ac].oeq03,"' ",
                  "  AND sfb87!='X'"
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
      CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql #FUN-A50102
      PREPARE sfb_p1 FROM l_sql
      DECLARE sfb_c1 CURSOR FOR sfb_p1
      OPEN sfb_c1
      FETCH sfb_c1 INTO l_cnt
      CLOSE sfb_c1
      IF l_cnt > 0 THEN
         CALL cl_err_msg("","axm-326",i CLIPPED,1)
      END IF
  END FOR
END FUNCTION
#-----END MOD-A40066-----

#-----No:FUN-A50103-----
#多帳期維護
FUNCTION t800_multi_account(l_oepa02)
   DEFINE l_oepa02   LIKE oepa_file.oepa02
   DEFINE l_oepa     DYNAMIC ARRAY OF RECORD
             oepa03    LIKE oepa_file.oepa03,
             before    LIKE type_file.chr1,
             oepa04b   LIKE oepa_file.oepa04b,
             oag02b    LIKE oag_file.oag02,
             oepa05b   LIKE oepa_file.oepa05b,
             oepa06b   LIKE oepa_file.oepa06b,
             oepa07b   LIKE oepa_file.oepa07b,
             oepa08b   LIKE oepa_file.oepa08b,
             after     LIKE type_file.chr1,
             oepa04a   LIKE oepa_file.oepa04a,
             oag02a    LIKE oag_file.oag02,
             oepa05a   LIKE oepa_file.oepa05a,
             oepa06a   LIKE oepa_file.oepa06a,
             oepa07a   LIKE oepa_file.oepa07a,
             oepa08a   LIKE oepa_file.oepa08a
                     END RECORD
   DEFINE l_oepa_t   RECORD
             oepa03    LIKE oepa_file.oepa03,
             before    LIKE type_file.chr1,
             oepa04b   LIKE oepa_file.oepa04b,
             oag02b    LIKE oag_file.oag02,
             oepa05b   LIKE oepa_file.oepa05b,
             oepa06b   LIKE oepa_file.oepa06b,
             oepa07b   LIKE oepa_file.oepa07b,
             oepa08b   LIKE oepa_file.oepa08b,
             after     LIKE type_file.chr1,
             oepa04a   LIKE oepa_file.oepa04a,
             oag02a    LIKE oag_file.oag02,
             oepa05a   LIKE oepa_file.oepa05a,
             oepa06a   LIKE oepa_file.oepa06a,
             oepa07a   LIKE oepa_file.oepa07a,
             oepa08a   LIKE oepa_file.oepa08a
                     END RECORD
   DEFINE p_cmd           LIKE type_file.chr1
   DEFINE l_rec_b         LIKE type_file.num5
   DEFINE l_n             LIKE type_file.num5
   DEFINE l_ac            LIKE type_file.num5
   DEFINE l_ac_t          LIKE type_file.num5
   DEFINE l_cnt           LIKE type_file.num5
   DEFINE l_oepa08        LIKE oepa_file.oepa08a
   DEFINE l_allow_insert  LIKE type_file.num5
   DEFINE l_allow_delete  LIKE type_file.num5
   DEFINE l_oma00         LIKE oma_file.oma00
   #DEFINE l_p_amt         LIKE oea_file.oea161 #MOD-C10181 mark
   DEFINE l_p_amt         LIKE oea_file.oea61   #MOD-C10181 add
   DEFINE l_new_line      LIKE type_file.chr1
   DEFINE l_oea02         LIKE oea_file.oea02
   DEFINE l_oea03         LIKE oea_file.oea03
   DEFINE l_oea24         LIKE oea_file.oea24

   IF g_oep.oep01 IS NULL THEN
      RETURN
   END IF

   IF l_oepa02 = '1' THEN
      IF cl_null(g_oep.oep261b) THEN
         IF g_oep.oep261 = 0 THEN
            RETURN
         ELSE
            LET l_p_amt = g_oep.oep261
         END IF
      ELSE
         IF g_oep.oep261b = 0 THEN
            RETURN
         ELSE
            LET l_p_amt = g_oep.oep261b
         END IF
      END IF
      LET l_oma00 = '11'
   END IF

   IF l_oepa02 = '2' THEN
      IF cl_null(g_oep.oep263b) THEN
         IF g_oep.oep263 = 0 THEN
            RETURN
         ELSE
            LET l_p_amt = g_oep.oep263
         END IF
      ELSE
         IF g_oep.oep263b = 0 THEN
            RETURN
         ELSE
            LET l_p_amt = g_oep.oep263b
         END IF
      END IF
      LET l_oma00 = '13'
   END IF

   OPEN WINDOW t800_m_w WITH FORM "axm/42f/axmt800_m"
       ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_locale("axmt800_m")

   LET g_sql = "SELECT oepa03,'0',oepa04b,'',oepa05b,oepa06b,oepa07b,oepa08b,",
               "              '1',oepa04a,'',oepa05a,oepa06a,oepa07a,oepa08a ",
               "  FROM oepa_file",
               " WHERE oepa01 = '",g_oep.oep01,"' ",
               "   AND oepa011= ",g_oep.oep02,
               "   AND oepa02 = '",l_oepa02,"' ",
               " ORDER BY oepa03 "

   PREPARE axmt800_m_pre FROM g_sql

   DECLARE axmt800_m_c CURSOR FOR axmt800_m_pre

   CALL l_oepa.clear()

   LET l_cnt = 1

   FOREACH axmt800_m_c INTO l_oepa[l_cnt].*
      IF STATUS THEN
         CALL cl_err('foreach oepa',STATUS,0)
         EXIT FOREACH
      END IF

      SELECT oag02 INTO l_oepa[l_cnt].oag02b
        FROM oag_file
       WHERE oag01 = l_oepa[l_cnt].oepa04b

      SELECT oag02 INTO l_oepa[l_cnt].oag02a
        FROM oag_file
       WHERE oag01 = l_oepa[l_cnt].oepa04a

      LET l_cnt = l_cnt + 1

   END FOREACH

   CALL l_oepa.deleteElement(l_cnt)

   LET l_rec_b = l_cnt - 1

   LET l_ac = 1

   DISPLAY g_oep.oep01 TO FORMONLY.oepa01
   DISPLAY g_oep.oep02 TO FORMONLY.oepa011
   DISPLAY l_oepa02 TO FORMONLY.oepa02
   DISPLAY l_p_amt TO FORMONLY.p_amt

   CALL cl_set_act_visible("cancel", FALSE)

   IF g_oep.oepconf !="N" THEN   #已確認或作廢單據只能查詢
      DISPLAY ARRAY l_oepa TO s_oepa.* ATTRIBUTE(COUNT=l_rec_b,UNBUFFERED)

         ON ACTION CONTROLG
            CALL cl_cmdask()

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DISPLAY

         ON ACTION about
            CALL cl_about()

         ON ACTION help
            CALL cl_show_help()

      END DISPLAY
   ELSE
      LET g_forupd_sql = "SELECT oepa03,'0',oepa04b,'',oepa05b,oepa06b,oepa07b,oepa08b,",
                         "              '1',oepa04a,'',oepa05a,oepa06a,oepa07a,oepa08a ",
                         "  FROM oepa_file",
                         " WHERE oepa01 = '",g_oep.oep01,"' ",
                         "   AND oepa011= ",g_oep.oep02,
                         "   AND oepa02 = '",l_oepa02,"' ",
                         "   AND oepa03 = ? ",
                         "  FOR UPDATE "

      LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)

      DECLARE t800_m_bc1 CURSOR FROM g_forupd_sql

      WHILE TRUE
         LET l_allow_insert = cl_detail_input_auth("insert")
         LET l_allow_delete = cl_detail_input_auth("delete")

         INPUT ARRAY l_oepa WITHOUT DEFAULTS FROM s_oepa.*
               ATTRIBUTE(COUNT=l_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                         INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                         APPEND ROW=l_allow_insert)

            BEFORE INPUT
               IF l_rec_b != 0 THEN
                  CALL fgl_set_arr_curr(l_ac)
               END IF

            BEFORE ROW
               LET p_cmd = ''
               LET l_ac = ARR_CURR()
               BEGIN WORK
               IF l_rec_b >= l_ac THEN
                  LET p_cmd = 'u'
                  LET l_oepa_t.* = l_oepa[l_ac].*
                  OPEN t800_m_bc1 USING l_oepa_t.oepa03
                  IF STATUS THEN
                     CALL cl_err("OPEN t800_m_bc1:", STATUS, 1)
                  ELSE
                     FETCH t800_m_bc1 INTO l_oepa[l_ac].*
                     IF SQLCA.sqlcode THEN
                        CALL cl_err(l_oepa_t.oepa03,SQLCA.sqlcode,1)
                     END IF
                     SELECT oag02 INTO l_oepa[l_ac].oag02a FROM oag_file
                      WHERE oag01=l_oepa[l_ac].oepa04a
                     SELECT oag02 INTO l_oepa[l_ac].oag02b FROM oag_file
                      WHERE oag01=l_oepa[l_ac].oepa04b
                  END IF
               END IF

            BEFORE INSERT
               LET p_cmd = 'a'
               INITIALIZE l_oepa[l_ac].* TO NULL
               LET l_oepa[l_ac].before = '0'
               LET l_oepa[l_ac].after  = '1'
               LET l_oepa_t.* = l_oepa[l_ac].*
               NEXT FIELD oepa03

            AFTER INSERT
               IF INT_FLAG THEN
                  CALL cl_err('',9001,0)
                  LET INT_FLAG = 0
                  CANCEL INSERT
               END IF
               IF cl_null(l_oepa[l_ac].oepa04a) AND
                  cl_null(l_oepa[l_ac].oepa05a) AND
                  cl_null(l_oepa[l_ac].oepa06a) AND
                  cl_null(l_oepa[l_ac].oepa07a) AND
                  cl_null(l_oepa[l_ac].oepa08a) THEN
                  CALL cl_err('','mfg9328',1)
                  CALL l_oepa.deleteElement(l_ac)
               ELSE
                  INSERT INTO oepa_file(oepa01,oepa011,oepa02,oepa03,
                                        oepa04b,oepa05b,oepa06b,oepa07b,oepa08b,
                                        oepa04a,oepa05a,oepa06a,oepa07a,oepa08a,
                                        oepaplant,oepalegal)
                                 VALUES(g_oep.oep01,g_oep.oep02,l_oepa02,
                                        l_oepa[l_ac].oepa03,
                                        l_oepa[l_ac].oepa04b,l_oepa[l_ac].oepa05b,
                                        l_oepa[l_ac].oepa06b,l_oepa[l_ac].oepa07b,
                                        l_oepa[l_ac].oepa08b,
                                        l_oepa[l_ac].oepa04a,l_oepa[l_ac].oepa05a,
                                        l_oepa[l_ac].oepa06a,l_oepa[l_ac].oepa07a,
                                        l_oepa[l_ac].oepa08a,
                                        g_plant,g_legal)
                  IF SQLCA.sqlcode THEN
                     CALL cl_err3("ins","oepa_file",g_oep.oep01,l_oepa[l_ac].oepa03,SQLCA.sqlcode,"","",1)
                     CANCEL INSERT
                  ELSE
                     MESSAGE 'INSERT O.K'
                     LET l_rec_b=l_rec_b+1
                     COMMIT WORK
                  END IF
               END IF

            ON ROW CHANGE
               IF INT_FLAG THEN
                  CALL cl_err('',9001,0)
                  LET INT_FLAG = 0
                  LET l_oepa[l_ac].* = l_oepa_t.*
                  CLOSE t800_m_bc1
                  ROLLBACK WORK
                  EXIT INPUT
               END IF

               UPDATE oepa_file SET oepa03  = l_oepa[l_ac].oepa03,
                                    oepa04a = l_oepa[l_ac].oepa04a,
                                    oepa05a = l_oepa[l_ac].oepa05a,
                                    oepa06a = l_oepa[l_ac].oepa06a,
                                    oepa07a = l_oepa[l_ac].oepa07a,
                                    oepa08a = l_oepa[l_ac].oepa08a,
                                    oepa04b = l_oepa[l_ac].oepa04b,
                                    oepa05b = l_oepa[l_ac].oepa05b,
                                    oepa06b = l_oepa[l_ac].oepa06b,
                                    oepa07b = l_oepa[l_ac].oepa07b,
                                    oepa08b = l_oepa[l_ac].oepa08b
                WHERE oepa01 = g_oep.oep01
                  AND oepa011= g_oep.oep02
                  AND oepa02 = l_oepa02
                  AND oepa03 = l_oepa_t.oepa03
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","oepa_file",g_oep.oep01,l_oepa_t.oepa03,SQLCA.sqlcode,"","",1)
                  LET l_oepa[l_ac].* = l_oepa_t.*
               ELSE
                  MESSAGE 'UPDATE O.K'
                  COMMIT WORK
               END IF

            AFTER ROW
               LET l_ac = ARR_CURR()
               LET l_ac_t = l_ac
               IF INT_FLAG THEN
                  CALL cl_err('',9001,0)
                  LET INT_FLAG = 0
                  IF p_cmd = 'u' THEN
                     LET l_oepa[l_ac].* = l_oepa_t.*
                  END IF
                  CLOSE t800_m_bc1
                  ROLLBACK WORK
                  EXIT INPUT
               END IF
               CLOSE t800_m_bc1
               COMMIT WORK

            BEFORE DELETE                            #是否取消單身
               IF l_oepa_t.oepa03 IS NOT NULL THEN
                  IF NOT cl_delete() THEN
                    CANCEL DELETE
                  END IF
                  DELETE FROM oepa_file
                   WHERE oepa01 = g_oep.oep01
                     AND oepa02 = l_oepa02
                     AND oepa03 = l_oepa_t.oepa03
                  IF SQLCA.sqlcode THEN
                     CALL cl_err3("del","oepa_file",g_oep.oep01,l_oepa_t.oepa03,SQLCA.sqlcode,"","",1)
                     EXIT INPUT
                  END IF
                  LET l_rec_b=l_rec_b-1
                  DISPLAY l_rec_b TO FORMONLY.cn2
                  COMMIT WORK
               END IF

            AFTER FIELD oepa03
               IF NOT cl_null(l_oepa[l_ac].oepa03) THEN
                  #已立帳不可修改
                  SELECT COUNT(*) INTO l_n
                    FROM oma_file
                   WHERE oma16 = g_oep.oep01
                     AND oma165= l_oepa[l_ac].oepa03
                     AND oma00 = l_oma00
                     AND omavoid <> 'Y' #MOD-CB0279 add
                  IF l_n > 0 THEN
                     CALL cl_err('','axm-963',1)
                     LET l_oepa[l_ac].oepa03 = l_oepa_t.oepa03
                     NEXT FIELD oepa03
                  END IF

                  IF l_oepa[l_ac].oepa03 != l_oepa_t.oepa03 OR cl_null(l_oepa_t.oepa03) THEN
                     SELECT COUNT(*) INTO l_n
                       FROM oepa_file
                      WHERE oepa01 = g_oea.oea01
                        AND oepa011 = g_oep.oep02   #MOD-B80339 add
                        AND oepa02 = l_oepa02
                        AND oepa03 = l_oepa[l_ac].oepa03
                     IF l_n > 0 THEN
                        CALL cl_err('',-239,0)
                        LET l_oepa[l_ac].oepa03 = l_oepa_t.oepa03
                        NEXT FIELD oepa03
                     END IF

                     #判斷是否為新資料
                     SELECT COUNT(*) INTO l_n
                       FROM oeaa_file
                      WHERE oeaa01 = g_oep.oep01
                        AND oeaa02 = l_oepa02
                        AND oeaa03 = l_oepa[l_ac].oepa03

                     LET l_new_line = "N"
                     IF l_n = 0 THEN
                        LET l_new_line = "Y"
                        LET l_oepa[l_ac].oepa04b = ''
                        LET l_oepa[l_ac].oepa05b = ''
                        LET l_oepa[l_ac].oepa06b = ''
                        LET l_oepa[l_ac].oepa07b = ''
                        LET l_oepa[l_ac].oepa08b = ''
                        IF p_cmd = 'a' THEN
                           LET l_oepa[l_ac].oepa04a = ''
                           LET l_oepa[l_ac].oepa05a = ''
                           LET l_oepa[l_ac].oepa06a = ''
                           LET l_oepa[l_ac].oepa07a = ''
                           LET l_oepa[l_ac].oepa08a = ''
                        END IF
                        CALL cl_set_comp_required("oepa04a,oepa05a,oepa06a,oepa07a,oepa08a",TRUE)
                     ELSE
                        SELECT oeaa04,oeaa05,oeaa06,oeaa07,oeaa08
                          INTO l_oepa[l_ac].oepa04b,l_oepa[l_ac].oepa05b,l_oepa[l_ac].oepa06b,
                               l_oepa[l_ac].oepa07b,l_oepa[l_ac].oepa08b
                          FROM oeaa_file
                         WHERE oeaa01 = g_oep.oep01
                           AND oeaa02 = l_oepa02
                           AND oeaa03 = l_oepa[l_ac].oepa03

                        DISPLAY BY NAME l_oepa[l_ac].oepa04b,l_oepa[l_ac].oepa05b,
                                        l_oepa[l_ac].oepa06b,l_oepa[l_ac].oepa07b,
                                        l_oepa[l_ac].oepa08b

                        CALL cl_set_comp_required("oepa04a,oepa05a,oepa06a,oepa07a,oepa08a",FALSE)
                     END IF
                  END IF
               END IF

            AFTER FIELD oepa04a
               IF NOT cl_null(l_oepa[l_ac].oepa04a) THEN
                  IF l_oepa[l_ac].oepa04a != l_oepa_t.oepa04a OR cl_null(l_oepa_t.oepa04a) THEN
                     SELECT oag02 INTO l_oepa[l_ac].oag02a FROM oag_file
                      WHERE oag01=l_oepa[l_ac].oepa04a
                     IF STATUS THEN
                        CALL cl_err3("sel","oag_file",l_oepa[l_ac].oepa03,"",STATUS,"","select oag",1)
                        NEXT FIELD oepa04a
                     END IF

                     IF l_new_line = 'Y' THEN
                        SELECT oea02,oea03,oea24 INTO l_oea02,l_oea03,l_oea24
                          FROM oea_file
                         WHERE oea01 = g_oep.oep01
                        CALL s_rdatem(l_oea03,l_oepa[l_ac].oepa04a,l_oea02,l_oea02,l_oea02,g_plant)
                            RETURNING l_oepa[l_ac].oepa05a,l_oepa[l_ac].oepa06a
                        LET l_oepa[l_ac].oepa07a = l_oea24
                     END IF
                  END IF
               END IF

            ON ACTION controlp
               CASE
                  WHEN INFIELD(oepa04a)
                       CALL cl_init_qry_var()
                       LET g_qryparam.form ="q_oag"
                       LET g_qryparam.default1 = l_oepa[l_ac].oepa04a
                       CALL cl_create_qry() RETURNING l_oepa[l_ac].oepa04a
                       DISPLAY BY NAME l_oepa[l_ac].oepa04a
                       NEXT FIELD oepa04a
                  OTHERWISE EXIT CASE
               END CASE

            ON ACTION locale
               CALL cl_dynamic_locale()
               CALL cl_show_fld_cont()

            ON IDLE g_idle_seconds
               CALL cl_on_idle()
               CONTINUE INPUT

            ON ACTION controlg
               CALL cl_cmdask()

            ON ACTION about
               CALL cl_about()

            ON ACTION help
               CALL cl_show_help()

            ON ACTION CONTROLF
               CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
               CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

            ON ACTION CONTROLR
               CALL cl_show_req_fields()

            ON ACTION exit
               EXIT INPUT

         END INPUT

        #SELECT SUM(oepa08) INTO l_oepa08 FROM oepa_file
        # WHERE oepa01 = g_oea.oea01
        #   AND oepa02 = l_oepa02
        #IF l_oepa08 <> l_p_amt THEN
        #   CALL cl_err('','axm-961',1)
        #   CONTINUE WHILE
        #ELSE
            EXIT WHILE
        #END IF
      END WHILE
   END IF

   CLOSE WINDOW t800_m_w

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

END FUNCTION

FUNCTION t800_upd_oeaa()
   DEFINE l_oepa   RECORD LIKE oepa_file.*
   DEFINE l_oeaa   RECORD LIKE oeaa_file.*

   DECLARE t800_oepa CURSOR FOR SELECT * FROM oepa_file
                                 WHERE oepa01 = g_oep.oep01
                                   AND oepa011= g_oep.oep02

   FOREACH t800_oepa INTO l_oepa.*

      SELECT * INTO l_oeaa.* FROM oeaa_file
       WHERE oeaa01 = g_oep.oep01
         AND oeaa02 = l_oepa.oepa02
         AND oeaa03 = l_oepa.oepa03
      IF STATUS THEN    #找不到oeaa的資料，表示為新增
         INSERT INTO oeaa_file(oeaa01,oeaa02,oeaa03,oeaa04,oeaa05,oeaa06,oeaa07,
                               oeaa08,oeaaplant,oeaalegal)
                        VALUES(g_oep.oep01,l_oepa.oepa02,l_oepa.oepa03,
                               l_oepa.oepa04a,l_oepa.oepa05a,l_oepa.oepa06a,
                               l_oepa.oepa07a,l_oepa.oepa08a,g_plant,g_legal)
         IF STATUS THEN
            CALL cl_err3("ins","oeaa_file",g_oep.oep01,l_oepa.oepa03,SQLCA.sqlcode,"","",1)
            LET g_success = "N"
         END IF
      ELSE    #修改
         IF NOT cl_null(l_oepa.oepa04a) THEN
            LET l_oeaa.oeaa04 = l_oepa.oepa04a
         END IF

         IF NOT cl_null(l_oepa.oepa05a) THEN
            LET l_oeaa.oeaa05 = l_oepa.oepa05a
         END IF

         IF NOT cl_null(l_oepa.oepa06a) THEN
            LET l_oeaa.oeaa06 = l_oepa.oepa06a
         END IF

         IF NOT cl_null(l_oepa.oepa07a) THEN
            LET l_oeaa.oeaa07 = l_oepa.oepa07a
         END IF

         IF NOT cl_null(l_oepa.oepa08a) THEN
            LET l_oeaa.oeaa08 = l_oepa.oepa08a
         END IF

         UPDATE oeaa_file SET oeaa04 = l_oeaa.oeaa04,
                              oeaa05 = l_oeaa.oeaa05,
                              oeaa06 = l_oeaa.oeaa06,
                              oeaa07 = l_oeaa.oeaa07,
                              oeaa08 = l_oeaa.oeaa08
          WHERE oeaa01 = g_oep.oep01
            AND oeaa02 = l_oepa.oepa02
            AND oeaa03 = l_oepa.oepa03

         IF STATUS THEN
            LET g_success = 'N'
         END IF
      END IF
   END FOREACH

END FUNCTION
#-----No:FUN-A50103 END-----

#FUN-910088--add--start--
FUNCTION t800_oeq12a_check()
   DEFINE l_oeb19 LIKE oeb_file.oeb19,
          l_oeb905 LIKE oeb_file.oeb905,
          l_oeb12  LIKE oeb_file.oeb12,
          l_oeb23  LIKE oeb_file.oeb23,
          l_oeb1004 LIKE oeb_file.oeb1004,
          l_oeq12a_o  LIKE oeq_file.oeq12a,
          l_oea00   LIKE oea_file.oea00,
          l_oea02   LIKE oea_file.oea02,
          l_oea03   LIKE oea_file.oea03,
          l_term    LIKE oep_file.oep10,
          g_msg1    LIKE type_file.chr1,
          l_fetch_price LIKE type_file.chr1000
   DEFINE l_flag1   LIKE type_file.chr10
   DEFINE l_pmn07   LIKE pmn_file.pmn07     #MOD-C60036 add
   DEFINE l_pmn20   LIKE pmn_file.pmn20     #MOD-C60036 add
   DEFINE l_oeq04a  LIKE oeq_file.oeq04a    #MOD-C60036 add
   DEFINE l_oeq05a  LIKE oeq_file.oeq05a    #MOD-C60036 add
   DEFINE l_oeq12a  LIKE oeq_file.oeq12a    #MOD-C60036 add
   DEFINE l_fac     LIKE ima_file.ima31_fac #MOD-C60036 add
   DEFINE l_oeb28   LIKE oeb_file.oeb28     #MOD-C60036 add
   DEFINE l_ima25   LIKE ima_file.ima25     #MOD-C60036 add
   DEFINE l_oea901  LIKE oea_file.oea901    #MOD-D20057 add

   IF NOT cl_null(g_oeq[l_ac].oeq12a) THEN
      IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
         LET g_oeq[l_ac].oeq12a = s_digqty(g_oeq[l_ac].oeq12a,g_oeq[l_ac].oeq05a)
      ELSE
         LET g_oeq[l_ac].oeq12a = s_digqty(g_oeq[l_ac].oeq12a,g_oeq[l_ac].oeq05b)
      END IF
      DISPLAY BY NAME g_oeq[l_ac].oeq12a
   END IF

   LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
   LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)
   IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
      LET g_oeq[l_ac].oeq27a = NULL
      DISPLAY BY NAME g_oeq[l_ac].oeq27a
   END IF
   CALL t800_oeq14a()
   IF cl_null(g_oeq[l_ac].oeq12b) AND NOT cl_null(g_oeq[l_ac].oeq12a) OR
      g_oeq[l_ac].oeq12b<>g_oeq[l_ac].oeq12a THEN
      LET g_change = 'Y'
   END IF
    IF cl_null(g_oeq[l_ac].oeq12a) AND NOT cl_null(g_oeq_t.oeq12a) THEN
       LET g_oeq[l_ac].oeq27a = NULL
       LET g_oeq[l_ac].oeq14a = NULL
       LET g_oeq[l_ac].oeq14ta = NULL
       IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
          LET g_oeq[l_ac].oeq27a = NULL
          LET g_oeq[l_ac].oeq14a = NULL
          LET g_oeq[l_ac].oeq14ta = NULL
       END IF
       DISPLAY BY NAME g_oeq[l_ac].oeq27a
       DISPLAY BY NAME g_oeq[l_ac].oeq14a
       DISPLAY BY NAME g_oeq[l_ac].oeq14ta
    END IF
    IF NOT cl_null(g_oeq[l_ac].oeq12a)  THEN
      #MOD-D20057 add start -----
       SELECT oea901 INTO l_oea901 FROM oea_file
        WHERE oea01 = g_oep.oep01
       IF l_oea901 = 'N' THEN
      #MOD-D20057 add end   -----
          #MOD-C60036 add start -----
          SELECT pmn07,pmn20 INTO l_pmn07,l_pmn20 FROM pmn_file
           WHERE pmn24 = g_oep.oep01 AND pmn25 = g_oeq[l_ac].oeq03

          IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
             LET l_oeq04a = g_oeq[l_ac].oeq04a
          ELSE
             LET l_oeq04a = g_oeq[l_ac].oeq04b
          END IF

          IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
             LET l_oeq05a = g_oeq[l_ac].oeq05a
          ELSE
             LET l_oeq05a = g_oeq[l_ac].oeq05b
          END IF

          #---取庫存單位
          SELECT ima25 INTO l_ima25 FROM ima_file WHERE ima01=l_oeq04a
          #---取換算率
          CALL s_umfchk(l_oeq04a,l_pmn07,l_ima25) RETURNING l_flag,l_fac
          IF l_flag=1 THEN LET l_fac=1 END IF
          LET l_oeb28 = l_pmn20 * l_fac

          CALL s_umfchk(l_oeq04a,l_oeq05a,l_ima25) RETURNING l_flag,l_fac
          IF l_flag=1 THEN LET l_fac=1 END IF
          LET l_oeq12a = g_oeq[l_ac].oeq12a * l_fac

          IF l_oeb28 > l_oeq12a THEN
             CALL cl_err(l_oeq12a,'axm1162',1)
             RETURN l_flag1,l_fetch_price
          END IF
          #MOD-C60036 add end   -----
       END IF #MOD-D20057 add
       IF g_newline = 'Y' AND g_oeq[l_ac].oeq12a <=0 THEN
          CALL cl_err(g_oeq[l_ac].oeq12a,'afa-037',0)
          RETURN l_flag1,l_fetch_price
       END IF
       IF g_oeq[l_ac].oeq04b IS NOT NULL THEN
          IF g_oeq[l_ac].oeq12a > 0 OR g_oeq[l_ac].oeq12b > 0 THEN #MOD-D30265 add
             IF g_oeq[l_ac].oeq12a = g_oeq[l_ac].oeq12b THEN
                LET  g_oeq[l_ac].oeq12a=null
                DISPLAY BY NAME g_oeq[l_ac].oeq12a
                CALL cl_err('','axm-327',0)

             END IF
          END IF #MOD-D30265 add
        IF l_oeb19 = 'Y'  THEN
           IF g_oeq[l_ac].oeq12a < l_oeb905 THEN
              CALL cl_getmsg('axm-921',g_lang) RETURNING g_msg1
              LET g_msg1=g_msg1 CLIPPED,
                         l_oeb905 USING '######&.###'
              CALL cl_err(g_msg1,'axm-919',1)
              RETURN l_flag1,l_fetch_price
           END IF
        END IF
        IF cl_null(g_oeq[l_ac].oeq27a) THEN
           LET g_oeq_t.oeq12a = g_oeq[l_ac].oeq12a
           LET g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq12a
           LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)
           IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
              LET g_oeq[l_ac].oeq27a = NULL
              DISPLAY BY NAME g_oeq[l_ac].oeq27a
           END IF
        END IF
        IF NOT cl_null(g_oeq[l_ac].oeq05a) THEN
           IF cl_null(g_oeq[l_ac].oeq26a) THEN
              LET g_oeq[l_ac].oeq26a=g_oeq[l_ac].oeq05a
              IF g_oeq[l_ac].oeq26a = g_oeq[l_ac].oeq26b THEN
                 LET g_oeq[l_ac].oeq26a = NULL
                 DISPLAY BY NAME g_oeq[l_ac].oeq26a
              END IF
           END IF
        END IF
      END IF
      IF g_change = 'Y' THEN
         CALL t800_set_oeq27()
        #TQC-CB0032--add--str
         IF NOT cl_null(g_errno) THEN
            CALL cl_err('',g_errno,1)
            RETURN '0',l_fetch_price
         END IF
        #TQC-CB0032--add--end
      END IF
        LET l_oeb12 = 0
        LET l_oeb23 = 0
        SELECT oeb24-oeb25,oeb23 INTO l_oeb12,l_oeb23 FROM oeb_file
         WHERE oeb01 = g_oep.oep01
           AND oeb03 = g_oeq[l_ac].oeq03
        IF l_oeb12 + l_oeb23 > g_oeq[l_ac].oeq12a THEN
           CALL cl_err('','axm0007',0)
           RETURN l_flag1,l_fetch_price
        ELSE
           IF NOT cl_null(g_oeq[l_ac].oeq12a) OR
              NOT cl_null(g_oeq[l_ac].oeq13a) THEN
              CALL t800_oeq14a()
           END IF
        END IF
      END IF
      IF NOT cl_null(g_oeq[l_ac].oeq12a) AND
         (g_oeq[l_ac].oeq12a <> l_oeq12a_o OR cl_null(l_oeq12a_o)) THEN
         IF cl_confirm('apm-543') THEN
            SELECT oeb1004 INTO l_oeb1004 FROM oeb_file
             WHERE oeb01=g_oep.oep01 AND oeb03=g_oeq[l_ac].oeq03
            SELECT oea00,oea02,oea03 INTO l_oea00,l_oea02,l_oea03 FROM oea_file
             WHERE oea01=g_oep.oep01
            LET l_term=g_oep.oep10b
            IF cl_null(g_oep.oep10b) THEN LET l_term=g_oep.oep10 END IF #FUN-9C0152
            LET g_oeq04f=g_oeq[l_ac].oeq04a
            LET g_oeq05f=g_oeq[l_ac].oeq05a
            LET g_oep07=g_oep.oep07b
            LET g_oep08=g_oep.oep08b
            IF cl_null(g_oep07) THEN LET g_oep07 = g_oep.oep07 END IF
            IF cl_null(g_oep08) THEN LET g_oep08 = g_oep.oep08 END IF
            IF cl_null(g_oeq04f) THEN LET g_oeq04f=g_oeq[l_ac].oeq04b END IF
            IF cl_null(g_oeq05f) THEN LET g_oeq05f=g_oeq[l_ac].oeq05b END IF
            CALL s_fetch_price_new(l_oea03,g_oeq04f,'',g_oeq05f,l_oea02,           #FUN-BC0071
                                   '1',g_plant,g_oep08,l_term,
                                   g_oep07,g_oep.oep01,g_oeq[l_ac].oeq03,
                                   g_oeq[l_ac].oeq12a,l_oeb1004,'b')
                     RETURNING g_oeq[l_ac].oeq13a,g_oeq[l_ac].oeq37a
            #FUN-BC0088 ------- add start --------------
            IF g_oeq[l_ac].oeq04a[1,4] = 'MISC' THEN
               CALL s_unitprice_entry(l_oea03,l_term,g_plant,'M')
            ELSE
            #FUN-BC0088 ------- add end --------------
               IF g_oeq[l_ac].oeq13a=0 THEN
                  CALL s_unitprice_entry(l_oea03,l_term,g_plant,'N')
               ELSE
                  CALL s_unitprice_entry(l_oea03,l_term,g_plant,'Y')
               END IF
            END IF #FUN-BC0088 add
            CALL t800_oeq14a()
         ELSE
            LET l_fetch_price = 'N'
         END IF
      END IF
      LET l_oeq12a_o = g_oeq[l_ac].oeq12a
      RETURN l_flag1,l_fetch_price
END FUNCTION

FUNCTION t800_oeq22a_check()
   IF NOT cl_null(g_oeq[l_ac].oeq22a) THEN
      IF NOT cl_null(g_oeq[l_ac].oeq20a) THEN
         LET g_oeq[l_ac].oeq22a = s_digqty(g_oeq[l_ac].oeq22a,g_oeq[l_ac].oeq20a)
      ELSE
         LET g_oeq[l_ac].oeq22a = s_digqty(g_oeq[l_ac].oeq22a,g_oeq[l_ac].oeq20b)
      END IF
      DISPLAY BY NAME g_oeq[l_ac].oeq22a
   END IF

   IF cl_null(g_oeq[l_ac].oeq22b) AND NOT cl_null(g_oeq[l_ac].oeq22a) OR
      g_oeq[l_ac].oeq22b<>g_oeq[l_ac].oeq22a THEN
      LET g_change = 'Y'
   END IF
   IF NOT cl_null(g_oeq[l_ac].oeq22a)  THEN
      IF g_oeq[l_ac].oeq22a > 0 OR g_oeq[l_ac].oeq22b > 0 THEN #MOD-D30265 add
         IF g_oeq[l_ac].oeq22a = g_oeq[l_ac].oeq22b THEN
            LET  g_oeq[l_ac].oeq22a=null
            DISPLAY BY NAME g_oeq[l_ac].oeq22a
            CALL cl_err('','axm-327',0)
         END IF
      END IF #MOD-D30265 add
   END IF
   CALL t800_set_origin_field()
   IF g_change = 'Y' THEN
      CALL t800_set_oeq27()
   END IF
   IF t800_qty_check() THEN
      IF g_ima906 MATCHES '[23]' THEN
         RETURN "oeq25a"
      ELSE
         RETURN "oeq22a"
      END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION t800_oeq25a_check(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1
   IF NOT cl_null(g_oeq[l_ac].oeq25a) THEN
      IF NOT cl_null(g_oeq[l_ac].oeq23a) THEN
         LET g_oeq[l_ac].oeq25a = s_digqty(g_oeq[l_ac].oeq25a,g_oeq[l_ac].oeq23a)
      ELSE
         LET g_oeq[l_ac].oeq25a = s_digqty(g_oeq[l_ac].oeq25a,g_oeq[l_ac].oeq23b)
      END IF
      DISPLAY BY NAME g_oeq[l_ac].oeq25a
   END IF

   IF cl_null(g_oeq[l_ac].oeq25b) AND NOT cl_null(g_oeq[l_ac].oeq25a) OR
      g_oeq[l_ac].oeq25b<>g_oeq[l_ac].oeq25a THEN
      LET g_change = 'Y'
   END IF
   IF NOT cl_null(g_oeq[l_ac].oeq25a)  THEN
      IF g_oeq[l_ac].oeq25a > 0 OR g_oeq[l_ac].oeq25b > 0 THEN #MOD-D30265 add
         IF g_oeq[l_ac].oeq25a = g_oeq[l_ac].oeq25b THEN
            LET  g_oeq[l_ac].oeq25a=null
            DISPLAY BY NAME g_oeq[l_ac].oeq25a
            CALL cl_err('','axm-327',0)
         END IF
      END IF #MOD-D30265 add
      IF p_cmd = 'a' THEN
         IF g_ima906='3' OR g_ima906 = '2' THEN
            LET g_oeq25=g_oeq[l_ac].oeq25b
            LET g_oeq24=g_oeq[l_ac].oeq24b
            LET g_oeq21=g_oeq[l_ac].oeq21b
            IF NOT cl_null(g_oeq[l_ac].oeq25a) THEN
               LET g_oeq25=g_oeq[l_ac].oeq25a
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq24a) THEN
               LET g_oeq24=g_oeq[l_ac].oeq24a
            END IF
            IF NOT cl_null(g_oeq[l_ac].oeq21a) THEN
               LET g_oeq21=g_oeq[l_ac].oeq21a
            END IF
            LET g_tot1=g_oeq25 * g_oeq24
            IF cl_null(g_oeq[l_ac].oeq22a) OR g_oeq[l_ac].oeq22a=0 THEN #CHI-960022
               IF g_ima906 = '3' THEN
                  LET g_oeq[l_ac].oeq22a=g_tot1*g_oeq21
                  LET g_oeq[l_ac].oeq22a = s_digqty(g_oeq[l_ac].oeq22a,g_oeq[l_ac].oeq20a)
               END IF
            END IF
         END IF
      END IF
   END IF
   IF g_change = 'Y' THEN
      IF g_ima906 = '3' THEN
         CALL t800_set_oeq27()
      END IF
   END IF
END FUNCTION

FUNCTION t800_oeq27a_check()
   IF NOT cl_null(g_oeq[l_ac].oeq27a) THEN
      IF NOT cl_null(g_oeq[l_ac].oeq26a) THEN
         LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26a)
      ELSE
         LET g_oeq[l_ac].oeq27a = s_digqty(g_oeq[l_ac].oeq27a,g_oeq[l_ac].oeq26b)
      END IF
      DISPLAY BY NAME g_oeq[l_ac].oeq27a
   END IF
   IF NOT cl_null(g_oeq[l_ac].oeq27a)  THEN
      IF g_oeq[l_ac].oeq27a > 0 OR g_oeq[l_ac].oeq27b > 0 THEN #MOD-D30265 add
         IF g_oeq[l_ac].oeq27a = g_oeq[l_ac].oeq27b THEN
            LET  g_oeq[l_ac].oeq27a=null
            DISPLAY BY NAME g_oeq[l_ac].oeq27a
            CALL cl_err('','axm-327',0)
         END IF
      END IF #MOD-D30265 add
   END IF
END FUNCTION
#FUN-910088--add--end

#MOD-D10096 mark start -----
#CHI-C40019 add begin---
#FUNCTION t800_get_ogbcnt()
#   DEFINE l_cnt   LIKE type_file.num5
#
#   SELECT COUNT(*) INTO l_cnt
#     FROM ogb_file
#    WHERE ogb31 = g_oep.oep01
#
#  LET g_ogb_cnt = l_cnt
#END FUNCTION
#CHI-C40019 add end-----
#MOD-D10096 mark end   -----

##FUN-CC0007---add---START
#FUNCTION t800_specify()
#  IF cl_null(g_oep.oep01) THEN
#     CALL cl_err('',-400,0)
#     RETURN
#  END IF
#  WHENEVER ERROR CONTINUE
#  OPEN WINDOW axmt800_add_w WITH FORM "axm/42f/axmt800_add"
#   ATTRIBUTE (STYLE = g_win_style CLIPPED)
#  CALL cl_ui_init()
#
#  LET g_sql = "SELECT oeqa03,'0',oeqa04,'','',oeqa07b,oeqa05b,oeqa06b,",
#              "              '1',oeqa07a,oeqa05a,oeqa06a",
#              "  FROM oeqa_file",
#              " WHERE oeqa01 = '",g_oep.oep01,"'",
#              "   AND oeqa011= '",g_oep.oep02,"'",
#              "   AND oeqa02 = '",g_oeq[l_ac].oeq03,"'",
#              " ORDER BY oeqa03 "
#  PREPARE t800_add_pre FROM g_sql
#  DECLARE t800_add_cs CURSOR FOR t800_add_pre
#  LET l_ac4 = 1
#  CALL g_oeqa.clear()
#  FOREACH t800_add_cs INTO g_oeqa[l_ac4].*
#     IF SQLCA.sqlcode THEN
#        EXIT FOREACH
#     END IF
#     SELECT ini02,ini03 INTO g_oeqa[l_ac4].ini02,
#                             g_oeqa[l_ac4].ini03
#       FROM ini_file
#      WHERE ini01 = g_oeqa[l_ac4].oeqa04
#     LET l_ac4 = l_ac4 + 1
#  END FOREACH
#  CALL g_oeqa.deleteElement(l_ac4)
#  LET g_rec_b = l_ac4 - 1
#  LET l_ac4  = 1
#  DISPLAY g_oep.oep01 TO FORMONLY.oeqa01
#  DISPLAY g_oep.oep02 TO FORMONLY.oeqa011
#  CALL t800_add_menu()
#  CLOSE WINDOW axmt800_add_w
#END FUNCTION
#
#FUNCTION t800_add_menu()
# WHILE TRUE
#    LET g_action_choice = " "
#    CALL t800_add_bp("G")
#    CASE g_action_choice
#       WHEN "detail"
#          IF g_oep.oepconf = 'N' THEN
#             CALL t800_add_b()
#          ELSE
#             CALL cl_err('','abm-879',0)
#             EXIT CASE
#          END IF
#       WHEN "exit"
#          EXIT WHILE
#       WHEN "controlg"
#          CALL cl_cmdask()
#    END CASE
#  END WHILE
#END FUNCTION
#
#FUNCTION t800_add_bp(p_ud)
#   DEFINE   p_ud   LIKE type_file.chr1
#  IF p_ud <> "G" OR g_action_choice = "detail" THEN
#     RETURN
#  END IF
#  LET g_action_choice = " "
#  CALL cl_set_act_visible("accept,cancel", FALSE)
#  DISPLAY ARRAY g_oeqa TO s_oeqa.* ATTRIBUTE(COUNT=g_rec_b)
#     BEFORE ROW
#        LET l_ac4 = ARR_CURR()
#     CALL cl_show_fld_cont()
#     ON ACTION detail
#        LET g_action_choice="detail"
#        LET l_ac4 = 1
#        EXIT DISPLAY
#     ON ACTION locale
#        CALL cl_dynamic_locale()
#        CALL cl_show_fld_cont()
#     ON ACTION exit
#        LET g_action_choice="exit"
#        EXIT DISPLAY
#     ON ACTION controlg
#        LET g_action_choice="controlg"
#        EXIT DISPLAY
#     ON ACTION accept
#        LET g_action_choice="detail"
#        LET l_ac4 = ARR_CURR()
#        EXIT DISPLAY
#     ON ACTION cancel
#        LET INT_FLAG=FALSE
#        LET g_action_choice="exit"
#        EXIT DISPLAY
#     ON IDLE g_idle_seconds
#        CALL cl_on_idle()
#        CONTINUE DISPLAY
#     AFTER DISPLAY
#        CONTINUE DISPLAY
#  END DISPLAY
#  CALL cl_set_act_visible("accept,cancel", TRUE)
#END FUNCTION
#
#FUNCTION t800_add_b()
#   DEFINE
#     l_ac4_t         LIKE type_file.num5,
#     l_n             LIKE type_file.num5,
#     l_lock_sw       LIKE type_file.chr1,
#     p_cmd           LIKE type_file.chr1,
#     l_allow_insert  LIKE type_file.chr1,
#     l_allow_delete  LIKE type_file.chr1,
#     l_cnt           LIKE type_file.num10
#   DEFINE
#     l_cn            LIKE type_file.num5,
#     l_add           LIKE type_file.num5
#   IF s_shut(0) THEN RETURN END IF
#   CALL cl_opmsg('b')
#
#   LET g_forupd_sql = "SELECT oeqa03,'0',oeqa04,'','',oeqa07b,oeqa05b,oeqa06b,",
#                       "              '1',oeqa07a,oeqa05a,oeqa06a ",
#                       "  FROM oeqa_file",
#                       " WHERE oeqa01 = '",g_oep.oep01,"' ",
#                       "   AND oeqa011= '",g_oep.oep02,"'",
#                       "   AND oeqa02 = '",g_oeq[l_ac].oeq03,"'",
#                       "   AND oeqa03 = ? ",
#                       "  FOR UPDATE "
#   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
#   DECLARE t800_add_bcl CURSOR FROM g_forupd_sql
#
#  LET l_allow_insert = cl_detail_input_auth("insert")
#  LET l_allow_delete = cl_detail_input_auth("delete")
#
#  INPUT ARRAY g_oeqa WITHOUT DEFAULTS FROM s_oeqa.*
#        ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
#                  INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
#                  APPEND ROW=l_allow_insert)
#   BEFORE INPUT
#      IF g_rec_b != 0 THEN
#         CALL fgl_set_arr_curr(l_ac4)
#      END IF
#
#   BEFORE ROW
#       LET p_cmd=''
#       LET l_ac4 = ARR_CURR()
#       LET l_lock_sw = 'N'
#       LET l_n  = ARR_COUNT()
#       IF g_oeqa[l_ac4].ini03 = '1' THEN
#          LET g_oeqa[l_ac4].oeqa06a = ''
#          CALL cl_set_comp_entry('oeqa06a,oeqa07a',FALSE)
#       ELSE
#          CALL cl_set_comp_entry('oeqa06a,oeqa07a',TRUE)
#       END IF
#       IF g_oeqa[l_ac4].oeqa07a <> '6' THEN
#          LET g_oeqa[l_ac4].oeqa06a = ''
#          CALL cl_set_comp_entry('oeqa06a',FALSE)
#       ELSE
#          CALL cl_set_comp_entry('oeqa06a',TRUE)
#       END IF
#       BEGIN WORK
#       IF g_rec_b>=l_ac4 THEN
#          LET p_cmd='u'
#          LET g_oeqa_t.* = g_oeqa[l_ac4].*
#          OPEN t800_add_bcl USING g_oeqa_t.oeqa03
#          IF STATUS THEN
#             CALL cl_err("OPEN t800_add_bcl:", STATUS, 1)
#             LET l_lock_sw = "Y"
#          ELSE
#             FETCH t800_add_bcl INTO g_oeqa[l_ac4].*
#             IF SQLCA.sqlcode THEN
#                CALL cl_err(g_oep.oep01,SQLCA.sqlcode,1)
#                LET l_lock_sw = "Y"
#             END IF
#            SELECT ini02,ini03 INTO g_oeqa[l_ac4].ini02,g_oeqa[l_ac4].ini03
#              FROM ini_file
#            WHERE ini01= g_oeqa[l_ac4].oeqa04
#          END IF
#          CALL cl_show_fld_cont()
#       END IF
#
#    BEFORE INSERT
#       LET p_cmd = 'a'
#       INITIALIZE g_oeqa[l_ac4].* TO NULL
#       LET g_oeqa[l_ac4].before = '0'
#       LET g_oeqa[l_ac4].after  = '1'
#       LET g_oeqa_t.* = g_oeqa[l_ac4].*
#       NEXT FIELD oeqa03
#
#    AFTER FIELD oeqa03
#       IF NOT cl_null(g_oeqa[l_ac4].oeqa03) THEN
#          IF g_oeqa[l_ac4].oeqa03 != g_oeqa_t.oeqa03 OR
#             g_oeqa_t.oeqa03 IS NULL THEN
#                    SELECT COUNT(*) INTO l_n
#                      FROM oeqa_file
#                     WHERE oeqa01  = g_oep.oep01
#                       AND oeqa011 = g_oep.oep02
#                       AND oeqa02  = g_oeq[l_ac].oeq03
#                       AND oeqa03  = g_oeqa[l_ac4].oeqa03
#             IF l_n > 0 THEN
#                 CALL cl_err('',-239,0)
#                 LET g_oeqa[l_ac4].oeqa03 = g_oeqa_t.oeqa03
#                 DISPLAY g_oeqa[l_ac4].oeqa03 TO oeqa03
#                 NEXT FIELD oeqa03
#             END IF
#             #不可輸入未存在oeba_file的資料
#             IF l_n = 0 THEN
#                CALL cl_err('','ask-008',0)
#                NEXT FIELD oeqa03
#             END IF
#             IF g_oeqa[l_ac4].oeqa03 = '1' THEN
#                CALL cl_set_comp_entry('oeqa06a',FALSE)
#                LET g_oeqa[l_ac4].oeqa06a = ''
#                DISPLAY g_oeqa[l_ac4].oeqa06a TO oeqa06a
#             END IF
#          END IF
#       END IF
#    AFTER FIELD oeqa07a
#       IF g_oeqa[l_ac4].oeqa07a <> '6' THEN
#          LET g_oeqa[l_ac4].oeqa06a = ''
#          CALL cl_set_comp_entry('oeqa06a',FALSE)
#       ELSE
#          CALL cl_set_comp_entry('oeqa06a',TRUE)
#       END IF
#    AFTER FIELD oeqa05a
#       IF g_oeqa[l_ac4].ini03='2' THEN
#          IF NOT cl_numchk(g_oeqa[l_ac4].oeqa05a,40) THEN
#             CALL cl_err('','aim1140',0)
#             NEXT FIELD oeqa05a
#          END IF
#       END IF
#    BEFORE FIELD oeqa06a
#       IF g_oeqa[l_ac4].ini03 = '1' THEN
#          LET g_oeqa[l_ac4].oeqa06a = ''
#          CALL cl_set_comp_entry('oeqa06a',FALSE)
#       ELSE
#          CALL cl_set_comp_entry('oeqa06a',TRUE)
#       END IF
#    AFTER FIELD oeqa06a
#       IF g_oeqa[l_ac4].ini03='2' THEN
#          IF NOT cl_numchk(g_oeqa[l_ac4].oeqa06a,40) THEN
#             CALL cl_err('','aim1140',0)
#             NEXT FIELD oeqa06a
#          END IF
#       END IF
#    AFTER INSERT
#       IF INT_FLAG THEN
#          CALL cl_err('',9001,0)
#          LET INT_FLAG = 0
#          CANCEL INSERT
#       END IF
#       IF cl_null(g_oeqa[l_ac4].oeqa04) AND
#          cl_null(g_oeqa[l_ac4].oeqa07a) AND
#          cl_null(g_oeqa[l_ac4].oeqa05a) AND
#          cl_null(g_oeqa[l_ac4].oeqa06a) THEN
#          CALL cl_err('','mfg9328',1)
#          CALL g_oeqa.deleteElement(l_ac4)
#       ELSE
#          INSERT INTO oeqa_file(oeqa01,oeqa011,oeqa02,oeqa03,oeqa04,
#                                oeqa05b,oeqa06b,oeqa07b,
#                                oeqa05a,oeqa06a,oeqa07a,
#                                oeqaplant,oeqalegal)
#                         VALUES(g_oep.oep01,g_oep.oep02,
#                                g_oeq[l_ac].oeq03,g_oeqa[l_ac4].oeqa03,g_oeqa[l_ac4].oeqa04,
#                                g_oeqa[l_ac4].oeqa05b,g_oeqa[l_ac4].oeqa06b,g_oeqa[l_ac4].oeqa07b,
#                                g_oeqa[l_ac4].oeqa05a,g_oeqa[l_ac4].oeqa06a,g_oeqa[l_ac4].oeqa07a,
#                                g_plant,g_legal)
#          IF SQLCA.sqlcode THEN
#             CALL cl_err3("ins","oeqa_file",g_oep.oep01,g_oeqa[l_ac4].oeqa03,SQLCA.sqlcode,"","",1)
#             CANCEL INSERT
#          ELSE
#             MESSAGE 'INSERT O.K'
#             LET g_rec_b = g_rec_b+1
#             DISPLAY g_rec_b TO FORMONLY.cn2
#             COMMIT WORK
#          END IF
#       END IF
#
#    ON ROW CHANGE
#       IF INT_FLAG THEN
#          LET INT_FLAG = 0
#          LET g_oeqa[l_ac4].* = g_oeqa_t.*
#          CLOSE t800_add_bcl
#          ROLLBACK WORK
#          EXIT INPUT
#       END IF
#       IF g_oeqa[l_ac4].ini03='2' THEN
#          IF NOT cl_numchk(g_oeqa[l_ac4].oeqa06a,40) THEN
#             CALL cl_err('','aim1140',0)
#             NEXT FIELD oeqa06a
#          END IF
#       END IF
#       IF l_lock_sw="Y" THEN
#          CALL cl_err(g_oeqa[l_ac4].oeqa03,-263,0)
#          LET g_oeqa[l_ac4].* = g_oeqa_t.*
#       ELSE
#              UPDATE oeqa_file SET oeqa02  = g_oeq[l_ac].oeq03,
#                                   oeqa03  = g_oeqa[l_ac4].oeqa03,
#                                   oeqa04  = g_oeqa[l_ac4].oeqa04,
#                                   oeqa05a = g_oeqa[l_ac4].oeqa05a,
#                                   oeqa06a = g_oeqa[l_ac4].oeqa06a,
#                                   oeqa07a = g_oeqa[l_ac4].oeqa07a,
#                                   oeqa05b = g_oeqa[l_ac4].oeqa05b,
#                                   oeqa06b = g_oeqa[l_ac4].oeqa06b,
#                                   oeqa07b = g_oeqa[l_ac4].oeqa07b
#               WHERE oeqa01 = g_oep.oep01
#                 AND oeqa011= g_oep.oep02
#                 AND oeqa03 = g_oeqa_t.oeqa03
#          IF SQLCA.sqlcode THEN
#             CALL cl_err3("upd","oeqa_file",g_oep.oep01,"",SQLCA.sqlcode,"","",1)
#             ROLLBACK WORK
#             LET g_oeqa[l_ac4].* = g_oeqa_t.*
#          ELSE
#             COMMIT WORK
#          END IF
#       END IF
#    AFTER ROW
#       LET l_ac4 = ARR_CURR()
#       LET l_ac4_t = l_ac4-1
#       IF INT_FLAG THEN
#          CALL cl_err('',9001,0)
#          LET INT_FLAG = 0
#          IF p_cmd='u' THEN
#             LET g_oeqa[l_ac4].* = g_oeqa_t.*
#          END IF
#          CLOSE t800_add_bcl
#          ROLLBACK WORK
#          EXIT INPUT
#       END IF
#       CLOSE t800_add_bcl
#       COMMIT WORK
#
#    BEFORE DELETE                            #是否取消單身
#       IF g_oeqa_t.oeqa03 IS NOT NULL THEN
#          IF NOT cl_delete() THEN
#            CANCEL DELETE
#          END IF
#          DELETE FROM oeqa_file
#           WHERE oeqa01 = g_oep.oep01
#             AND oeqa03 = g_oeqa_t.oeqa03
#          IF SQLCA.sqlcode THEN
#             CALL cl_err3("del","oeqa_file",g_oep.oep01,g_oeqa_t.oeqa03,SQLCA.sqlcode,"","",1)
#             EXIT INPUT
#          END IF
#          LET g_rec_b = g_rec_b-1
#          DISPLAY g_rec_b TO FORMONLY.cn2
#          COMMIT WORK
#       END IF
#
#    ON ACTION controlp
#       CASE
#          WHEN INFIELD(oeqa03)
#               CALL cl_init_qry_var()
#               LET g_qryparam.form ="q_oeba01"
#               LET g_qryparam.arg1 = g_oep.oep01
#               LET g_qryparam.arg2 = g_oeq[l_ac].oeq03
#               CALL cl_create_qry() RETURNING g_oeqa[l_ac].oeqa03
#               DISPLAY BY NAME g_oeqa[l_ac].oeqa03
#               NEXT FIELD oeqa03
#          OTHERWISE EXIT CASE
#       END CASE
#    ON ACTION CONTROLR
#        CALL cl_show_req_fields()
#    ON ACTION CONTROLG
#        CALL cl_cmdask()
#    ON ACTION CONTROLF
#        CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
#        CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
#    ON IDLE g_idle_seconds
#        CALL cl_on_idle()
#        CONTINUE INPUT
#    ON ACTION about
#        CALL cl_about()
#    ON ACTION help
#        CALL cl_show_help()
#    END INPUT
#   CLOSE t800_add_bcl
#   COMMIT WORK
#END FUNCTION
#FUNCTION t800_upd_oeba()
#DEFINE l_oeqa   RECORD LIKE oeqa_file.*
#DEFINE l_n      LIKE type_file.num5
#
#  #當oeba_file無值時,需用insert into的方式處理
#  SELECT COUNT(*) INTO l_n FROM oeba_file
#   WHERE oeba01 = g_oep.oep01
#
#  DECLARE upd_oeba CURSOR FOR
#  SELECT *
#    FROM oeqa_file
#   WHERE oeqa01  = g_oep.oep01
#     AND oeqa011 = g_oep.oep02
#
#  FOREACH upd_oeba INTO l_oeqa.*
#    IF SQLCA.SQLCODE <> 0 THEN
#      EXIT
#    FOREACH END IF
#    IF cl_null(l_oeqa.oeqa06a) THEN LET l_oeqa.oeqa06a = '' END IF
#    IF l_n = 0 THEN
#       INSERT INTO oeba_file(oeba01,oeba02,oeba03,oeba04,oeba05,oeba06,oeba07,oebalegal,oebaplant,oebauser,oebagrup,oebaorig,oebaoriu,oebadate)
#       VALUES(l_oeqa.oeqa01,l_oeqa.oeqa02,l_oeqa.oeqa03,l_oeqa.oeqa04,l_oeqa.oeqa05a,l_oeqa.oeqa06a,l_oeqa.oeqa07a,g_legal,g_plant,g_user,g_grup,g_grup,g_user,g_today)
#       IF SQLCA.sqlcode THEN
#          CALL cl_err3("ins","oeba_file",l_oeqa.oeqa01,"",SQLCA.sqlcode,"","",1)
#          EXIT FOREACH
#       END IF
#    ELSE
#       UPDATE oeba_file SET oeba07 = l_oeqa.oeqa07a,
#                            oeba05 = l_oeqa.oeqa05a,
#                            oeba06 = l_oeqa.oeqa06a
#       WHERE oeba01 = l_oeqa.oeqa01
#         AND oeba02 = l_oeqa.oeqa02
#         AND oeba03 = l_oeqa.oeqa03
#
#       IF SQLCA.SQLCODE <>0 THEN
#          LET g_success = 'N'
#          EXIT FOREACH
#       END IF
#    END IF
#  END FOREACH
#END FUNCTION
##FUN-CC0007---add-----END

#MOD-D10109 add start -----
FUNCTION t800_chk_origin_field()
  DEFINE    l_oeq04  LIKE oeq_file.oeq04a
  DEFINE    l_oeq05  LIKE oeq_file.oeq05a
  DEFINE    l_oeb19  LIKE oeb_file.oeb19
  DEFINE    l_oeb05  LIKE oeb_file.oeb05
  DEFINE    l_sic06  LIKE sic_file.sic06
  DEFINE    l_fac    LIKE ima_file.ima31_fac

  IF g_sma.sma115 = 'Y' THEN
     LET l_oeq04 = g_oeq[l_ac].oeq04b
     IF NOT cl_null(g_oeq[l_ac].oeq04a) THEN
        LET l_oeq04 = g_oeq[l_ac].oeq04a
     END IF

     SELECT ima31 INTO g_ima31
       FROM ima_file
      WHERE ima01 = l_oeq04

     CASE g_ima906
        WHEN '2'
           LET l_oeq05 = g_ima31
        WHEN '3'
           LET l_oeq05 = g_oeq[l_ac].oeq20b
           IF NOT cl_null(g_oeq[l_ac].oeq20a) THEN
              LET l_oeq05 = g_oeq[l_ac].oeq20a
           END IF
     END CASE

     SELECT oeb05,oeb19 INTO l_oeb05,l_oeb19 FROM oeb_file
      WHERE oeb01 = g_oep.oep01 AND oeb03 = g_oeq[l_ac].oeq03

     IF l_oeb19 = 'Y'  THEN
        CALL s_umfchk(l_oeq04,l_oeb05,l_oeq05) RETURNING g_cnt,l_fac
        IF g_cnt = 1 THEN
           LET l_fac = 1
        END IF

        SELECT SUM(sic06) INTO l_sic06 FROM sic_file
         WHERE sic03 = g_oep.oep01
           AND sic15 = g_oeq[l_ac].oeq03
        LET l_sic06 = l_sic06 * l_fac

        IF g_oeq[l_ac].oeq12a < l_sic06 THEN
           CALL cl_getmsg('axm-921',g_lang) RETURNING g_msg
           LET g_msg=g_msg CLIPPED,
                      l_sic06 USING '######&.###'
           CALL cl_err(g_msg,'axm-919',1)
           RETURN FALSE
        END IF
     END IF
  END IF
  RETURN TRUE
END FUNCTION
#MOD-D10109 add end   -----

FUNCTION t800_oeaud02_upd()
   DEFINE l_oeb04   LIKE oeb_file.oeb04
   DEFINE l_oeaud02 LIKE oea_file.oeaud02
   DEFINE l_str     STRING
   DEFINE l_ima67   LIKE ima_file.ima67
   IF cl_null(g_oep.oep01) THEN RETURN END IF
   DECLARE t800_oeaud02_cs CURSOR FOR SELECT DISTINCT oeq04b FROM oeq_file WHERE oeq01 = g_oep.oep01
   FOREACH t800_oeaud02_cs INTO l_oeb04
      SELECT ima67 INTO l_ima67 FROM ima_file WHERE ima01=l_oeb04
      IF cl_null(l_ima67) THEN CONTINUE FOREACH END IF
      IF cl_null(l_oeaud02) THEN
         LET l_oeaud02 = l_ima67 CLIPPED
         LET l_str = l_oeaud02
      ELSE
         IF NOT l_str.getIndexOf(l_ima67,1) THEN
            LET l_oeaud02 = l_oeaud02 CLIPPED,";",l_ima67 CLIPPED
            LET l_str = l_oeaud02
         END IF
      END IF
      UPDATE oea_file SET oeaud02 = l_oeaud02 WHERE oea01 = g_oep.oep01
   END FOREACH

END FUNCTION
