# Prog. Version..: '5.30.06-13.03.12(00000)'     #
# pRog. Version..: '5.20.01-10.05.01(00000)'     #
#
# Pattern name...: sapmt420.4gl
# Descriptions...: 請購單單頭資料維護作業(簡易輸入)
# Date & Author..: 92/11/17 By Apple
#        Modify..: 94/08/12 By Danny (Add 單身)
#   modi by kitty: 特別說明call apmt402,交貨日改需求日
#   modi by kitty: 立即列印修改,insert完R.刪除時會出現-201之error
# Modify by Carol: 99/04/16 modify s_pmksta()
# Modify by Carol: 99/08/27 狀態:2.已轉採購單,不可作取消確認
# Modify by Carol: 00/02/14 更新專案之已轉請購量,add t420_chk_pjf06()
# Modify BY ANN CHEN :010420 執行copy動作時,依user輸入單據日抓最大號
# Modify.........: No:7766 03/08/11 By Raymon 呼叫自動取單號時應在 Transction中
# Modify.........: No.8841 03/12/04 By Kitty pml12 不可為null否則轉ap會有問題
# Modify.........: No.8384 04/02/05 By Melody 相同料號的第二筆料件之品名規格無法正常存檔
# Modify.........: No.9561 04/05/13 By Carol  預防查詢翻頁的異常 add UNIQUE
# Modify.........: No.9782 04/05/13 By Wiky 新增單據,全相同料號(系統會自動帶),品名看起來很正常,事實上是 just display
#                : 重 Q 此單號,第2筆以後品名是空的……事實上沒塞進,第2筆以後後的資料 pml40 都是 null (只有第一筆抓到ima39)
# Modify.........: No.MOD-480235 04/08/10 By Wiky copy有問題
# Modify.........: No.MOD-490217 04/09/10 by yiting 料號欄位放大
# Modify.........: No.MOD-480478 04/09/15 by Melody 新增時,於 "確認員" Ctrl-P 查詢完,Cursor 卻回到 "請購員",^P開窗q_pmh查不出資料
# Modify.........: No.MOD-490256 04/09/16 by Melody 進入後直接作多語言切換  切換完成後會出現 -404 錯誤
# Modify.........: No.MOD-490477 04/09/29 by Melody 單頭敲完,選依BOM產生時, 未show出單身資料,卻先問列印/確認此單據否
# Modify.........: No.MOD-4A0252 04/10/21 By Smapmin 請購單號開窗
# Modify.........: No.MOD-4A0125 04/10/22 By Mandy 單身維護修改請購量後,再做上移下移的動作,會出現 insert 重復訊息
# Modify.........: No.FUN-4B0025 04/11/05 By Smapmin ARRAY轉為EXCEL檔
# Modify.........: No.MOD-4B0105 04/11/15 By Mandy pml121/pml122 的default值給0
# Modify.........: No.FUN-4B0051 04/11/24 By Mandy 匯率加開窗功能
# Modify.........: No.MOD-4B0276 04/11/26 By Mandy LET g_qryparam.where = " AND ........."
# Modify.........: No.MOD-4B0276                                            ^^^最一開始這�不能有AND 否則組SQL會錯
# Modify.........: No.MOD-4B0255 04/11/26 By Mandy 串apmi600/apmq210/apmq220時,可針對供應商顯示相關的資料,如果供應商空白則可查詢全部的資料
# Modify.........: No.MOD-4B0058 04/12/06 By Echo  aoos010設定不使用 EasyFlow 但單據設定需簽核(使用tiptop簡易簽核)
# Modify.........: No.FUN-4C0056 04/12/08 By Carol Q,U,R 加入權限控管處理
# Modify.........: No.FUN-4C0074 04/12/14 By pengu  匯率幣別欄位修改，與aoos010的azi17做判斷，
                                                    #如果二個幣別相同時，匯率強制為 1
# Modify.........: No.MOD-510099 05/01/13 By ching 第二筆pml33 default
# Modify.........: No.MOD-530190 05/03/22 By Mandy 將DEFINE 用DEC(),DECIMAL()方式的改成用LIKE方式 or DEC(20,6)
# Modify.........: No.MOD-530199 05/03/24 By Mandy 無法作 作廢 動作,  因pml121,pml122 default為0, 條件: AND ( pml12 IS NOT NULL OR pml12 !=' ')   造成一定會進入  CALL t420_sum_pjf08
# Modify.........: No.MOD-530199 05/03/24 By Mandy                                            增加條件: AND pml121!=0 AND pml122!=0
# Modify.........: No.MOD-520022 05/03/25 By Mandy 單身新增 button 可以再補入預算資料
# Modify.........: No.MOD-530423 05/03/26 By Yuna  輸入完單頭後到單身跳出視窗,RADIO BOX要DEFAULT 'N'
# Modify.........: No.MOD-530414 05/03/29 By Mandy 執行複製功能時, 單身交期會清為空白, 若沒有維護, 還是可以確認, 應改為確認時要擋掉
# Modify         : No.MOD-530885 05/03/31 by alexlin VAR CHAR->CHAR
# Modify.........: No.FUN-550019 05/04/19 By Danny 採購含稅單價
# Modify.........: No.MOD-540182 05/05/06 By saki  單據編號欄位放大
# Modify         : No.FUN-550038 05/05/11 by Echo 複製功能，無判斷單別是否簽核，狀態碼修改為combobox。
#                                                 將確認與簽核流程拆開獨立。
# Modify.........: No.FUN-540027 05/05/23 By Carrier 雙單位內容修改
# Modify.........: No.MOD-560007 05/06/02 By Echo   重新定義整合FUN名稱
# Modify.........: No.FUN-560074 05/06/16 By pengu  CREATE TEMP TABLE 欄位放大
# Modify.........: No.FUN-560102 05/06/18 By Danny 採購含稅單價取消判斷大陸版
# Modify.........: No.MOD-560162 05/06/22 By Mandy p_zz有設不可更改索引(Key)值,但仍可以更改請購單號
# Modify.........: No.MOD-570070 05/07/12 By kim 已定義的變數(g_pmk)未給予INITIALIZE或DEFAUL
# Modify.........: No.MOD-570072 05/07/15 By kim 請購單一輸入完就會列印 (就算單別 asmi300 沒有勾直接列印)
# Modify.........: No.MOD-570071 05/07/19 By kim 請購之 <MRP 查詢> 功能 ,開窗不要出現t420_k_w的子視窗
# Modify.........: NO.MOD-570246 05/07/20 By Yiting 日期資料維護沒有算出正確的到廠日
# Modify.........: No.MOD-570233 05/08/10 By Nicola MISC帶品名/單位錯誤
# Modify.........: No.MOD-580131 05/09/02 By Nicola 開窗時,送貨地址要過濾單據性質是"0,2",發票地址要過濾"1,2"
# Modify.........: No.FUN-580162 05/09/02 By Nicola 料件有建議數量的話,會開一個建議數量的視窗,可是按確定後,欄位的數量沒有變成建議的數量
# Modify.........: No.MOD-580164 05/09/02 By Nicola g_pml_o 給值
# Modify.........: No.MOD-590119 05/09/09 By Carrier 多單位set_origin_field修改
# Modify.........: No.FUN-580011 05/08/05 By echo 以 EF 為 backend engine, 由 TIPTOP 處理前端簽核動作
# Modify.........: No.FUN-570106 05/09/12 By Sarah 新增請購單身維護 pml34(到廠日),pml35(入庫日) After pml33(交貨)
# Modify.........: No.MOD-590269 05/09/13 By Nicola 加日期判斷  請購日期=<交貨日期=<到廠日期=<到庫日期
# Modify.........: No.MOD-5A0056 05/10/05 By Nicola 單一單位才做建議數量判斷
# Modify.........: No.MOD-580341 05/10/19 By Nicola 按取消時，不詢問是否要列印
# Modify.........: No.TQC-5C0014 05/12/05 By Carrier set_required時去除單位換算率
# Modify.........: No.MOD-5C0158 05/12/28 By Nicola 抓取欄位錯誤
# Modify.........: No.MOD-530058 06/01/06 By Mandy 1.修正show的訊息,不要show 'apm-229',改show'apm-203'==>無此"預算編號+科目編號+部門編號+年度"
#                                                  2.增加q_pnr
# Modify.........: No.FUN-610018 06/01/17 By ice 採購含稅單價功能調整
# Modify.........: No.FUN-610076 06/01/20 By Nicola 計價單位功能改善
# Modify.........: No.FUN-610067 06/01/07 By Smapmin 雙單位畫面調整
# Modify.........: No.FUN-620063 06/02/27 By saki 自訂欄位功能
# Modify.........: No.FUN-630010 06/03/08 By saki 流程訊息通知功能
# Modify.........: No.FUN-630040 06/03/15 By Nicola 加入欄位pml190,pml191,pml192
# Modify.........: No.TQC-610085 06/04/06 By Claire Review 所有報表程式接收的外部參數是否完整
# Modify.........: No.MOD-640151 06/04/09 By Mandy 單身預設上筆時,沒給g_pml2.*值,導致INSERT INTO pml_file的資料有誤
# Modify.........: No.FUN-640085 06/04/10 By kim GP3.0匯率改善功能
# Modify.........: No.MOD-640299 06/04/10 By kim 檢查單身項次不可為0
# Modify.........: No.TQC-640132 06/04/18 By Nicola 日期調整
# Modify.........: No.FUN-640184 06/04/19 By Echo 自動執行確認功能
# Modify.........: No.MOD-640532 06/04/24 By Nicola 新增日期預設
# Modify.........: No.MOD-650040 06/05/09 By rainy 取消輸入時的"預設上筆"功能
# Modify.........: No.MOD-650031 06/05/12 By pengu單身時有個"查詢料件供應商"的ACTION，按第一次有值，第二次就沒值了
# Modify.........: No.TQC-630043 06/05/18 By Pengu 421_w 時維護pml31 tAFTER FIELD pml31t也應加上
                                    #              LET g_pml2.pml44=g_pml2.pml31*g_pmk.pmk42
# Modify.........: NO.TQC-650108 06/05/24 By day 料件多屬性新機制修改
# Modify.........: No.MOD-660039 06/06/16 By Pengu 入單身,游標下移過某項時,即會出現資料重覆
# Modify.........: No.FUN-660129 06/06/19 By Rayven cl_err --> cl_err3
# Modify.........: No.TQC-660097 06/06/21 By Rayven 多屬性功能改進:查詢時不顯示多屬性內容
# Modify.........: No.MOD-660090 06/06/22 By Rayven 料件多屬性補充修改，check_料號()內應再加傳p_cmd的參數
# Modify.........: No.TQC-660124 06/06/27 By Pengu asms290設定不使用計價單位，一旦按了進入單身,此時計價數量卻跑了出來
# Modify.........: No.TQC-670008 06/07/05 By kim 將 g_sys 變數改成寫死系統別(要大寫)
# Modify.........: No.FUN-660216 06/07/10 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.TQC-630284 06/07/12 By Pengu 隱藏無權限按鈕功能修改
# Modify.........: No.FUN-670051 06/07/13 By kim GP3.5 利潤中心
# Modify.........: NO.FUN-670007 06/08/07 BY yiting 1.刪除/作廢請購單時，要將訂單上的請購單資料清除oeb28/(oeb28-pml87)
#                                                   2.請購單單身加上pml24/pml25
#                                                   3.請購量有異動時，不可大於訂單數量，依來源號碼回寫S/O之資料
# Modify.........: No.FUN-650191 06/08/14 By rainy pmw03改抓pmx12
# Modify.........: No.FUN-680029 06/08/23 By Rayven 新增多帳套功能
# Modify.........: No.FUN-680136 06/09/14 By Jackho 欄位類型修改
# Modify.........: No.FUN-690022 06/09/21 By jamie 判斷imaacti
# Modify.........: No.FUN-690024 06/09/21 By jamie 判斷pmcacti
# Modify.........: No.FUN-690025 06/09/21 By jamie 改判斷狀況碼pmc05
# Modify.........: No.FUN-690047 06/09/28 By Sarah 畫面單身增加顯示pml38,單身的pml38(可用/不可用)預設跟單頭的pmn45一樣,
#                                                  當pmk45='Y'時,單身的pml38可進入更改,當pmk45='N'時,單身的pml38不可更改
# Modify.........: No.FUN-570078 06/10/16 By rainy 1.單身顯示凍結碼pml11
#                                                  2.單頭的更動序號不可修改
# Modify.........: No.CHI-6A0004 06/10/25 By bnlent g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.FUN-6A0036 06/11/13 By rainy 判斷停產(ima140)時，要一併判斷生效日期(ima1401)
# Modify.........: No.FUN-6B0032 06/11/13 By Czl 增加雙檔單頭折疊功能
# Modify.........: No.FUN-6A0162 06/11/16 By jamie 新增action"相關文件"
# Modify.........: No.FUN-6A0153 06/11/21 By Sarah 當單頭的"MPS/MRP可用"欄位改成Y時,詢問是否更新單身
# Modify.........: No.MOD-6C0013 06/12/06 By Sarah 單身修改交貨日期、到廠日期、入庫日期後沒有檢查合理性(交貨日期>=到廠日期>=入庫日期)
# Modify.........: No.MOD-6A0014 06/10/13 By pengu 新增請購單時pml190(統購否)應該default為'N'
# Modify.........: No.MOD-6A0014 06/12/13 By pengu 新增請購單時pml190(統購否)應該default為'N'
# Modify.........: No.TQC-6B0124 06/12/18 By pengu 參數勾選不使用多單位但使用計價單位時，計價單位與計價數量會異常
# Modify.........: No.FUN-6C0055 07/01/08 By Joe 新增與GPM整合的顯示及查詢的Toolbar
# Modify.........: No.TQC-710042 07/01/11 By Joe 解決未經設定整合之工廠,會有Action顯示異常情況出現
# Modify.........: NO.FUN-710019 07/01/12 BY yiting   S/O拋P/R時，如P/R數量有更動要回寫到S/O
# Modify.........: No.FUN-710030 07/02/07 By johnray 錯誤訊息匯總顯示修改
# Modify.........: No.TQC-6A0026 07/03/05 By pengu 1.修改請購單身"到庫日期"時，應該要重推"到廠日期"與"交貨日期
#                                                  2.控制到庫日期&到廠日期不得小於開單日期
# Modify.........: No.TQC-6B0105 07/03/07 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.MOD-730047 07/03/14 By claire 做幣別取位
# Modify.........: No.FUN-730012 07/03/20 By kim 確認段移到sapmt420_sub.4gl
# Modify.........: No.FUN-720043 07/03/23 By Mandy APS相關調整
# Modify.........: No.TQC-730022 07/03/23 By rainy 流程自動化
# Modify.........: No.FUN-730068 07/03/29 By kim 行業別架構
# Modify.........: No.FUN-730033 07/03/29 By Carrier 會計科目加帳套
# Modify.........: No.FUN-740029 07/04/10 By dxfwo   會計科目加帳套
# Modify.........: No.FUN-740033 07/03/27 By Carrier 會計科目加帳套-afa_file要傳帳套
# Modify.........: No.TQC-740084 07/04/13 By Ray 錄入資料，審核等一系列連續的動作，審核后畫面上單身資料會消失
# Modify.........: No.CHI-740014 07/04/16 By kim "agree"段的確認後的show的位置錯誤
# Modify.........: No.TQC-740113 07/04/18 By jacklai 將 CALL aws_gpmcli_toolbar() 移至 CALL aws_efapp_toolbar() 後面才呼叫
# Modify.........: No.TQC-740281 07/04/24 By Echo 若由TIPTOP走簽核流程,APS Action要隱藏
# Modify.........: No.MOD-740471 07/04/25 By claire sfb25要加入key值,否則會造成apm_p470寫入時重複值的問題
# Modify.........: No.TQC-750013 07/05/04 By Mandy 1.參數設不串APS時 Action "APS相關資料"不要出現
#                                                  2.一進入程式,不查詢直接按APS相關資料,當出
# Modify.........: No.FUN-740034 07/05/14 By kim 確認過帳不使用rowid,改用單號
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.TQC-760044 07/06/15 By rainy 單身統購否pml190='N'的才可拋轉採購單
# Modify.........: No.TQC-760109 07/06/20 By rainy AFTER FIELD pmk04段內會給g_pmk.pmk31,g_pmk.pmk32,g_bookno1,g_bookno2值新增時,輸入好單頭的請購單號的單別之後馬上按Ctrl + N 離開會漏掉該抓的值
# Modify.........: No.FUN-710060 07/08/07 By jamie 料件供應商管制建議依品號設定;程式中原判斷sma62=1者改為判斷ima915=1 OR 3
# Modify.........: No.MOD-770084 07/08/09 By claire 單身下一筆不default上一筆的到庫,到廠,交貨日期,才不會有(apm-028)到庫日期不可小於到廠日期的錯誤
# Modify.........: No.MOD-780026 07/08/09 By claire 供應商空白時要清除上一筆的簡稱
# Modify.........: No.TQC-710080 07/08/11 By pengu  當不使用計價單位時,若去修改請購單位時隱藏的計價單位不會跟著變動
# Modify.........: No.MOD-780083 07/08/15 By claire 付款條件空白時要清除上一筆的說明
# Modify.........: No.CHI-7B0023/CHI-7B0039 07/11/14 By kim 移除GP5.0行業別功能的所有程式段
# Modify.........: No.FUN-7B0080 07/11/16 By saki 自定義欄位功能修改
# Modify.........: No.TQC-7C0024 07/12/05 By wujie 1,單別未綁定屬性群組，且asms290未選擇單據輸入可新增料件,單身料號以多屬性輸入時,此料號不存在于ima_file時也可完成輸入,并且ima_file并未有料件新增進去,這是錯誤的，應該不允許通過
#                                                  2,單別未綁定屬性群組，且asms290選擇單據輸入可新增料件,單身料號以多屬性輸入時,此料號不存在于ima_file時也可完成輸入,并且ima_file并未有料件新增進去,這是錯誤的，應該是先新增料件，然后通過檢查
# Modify.........: No.MOD-7C0050 07/12/07 By claire MISC料件無效時不可使用
# Modify.........: No.TQC-7C0120 07/12/08 By Davidzv 單身"維護料件資料"action改為調用aimi100
# Modify.........: No.TQC-7C0144 07/12/13 By wujie  TQC-7C0024中漏了排除MISC開頭的料件
# Modify.........: No.MOD-7C0225 07/12/28 By Pengu 資料權限不應該影響刪除action的權限顯示
# Modify.........: No.FUN-7C0050 08/01/15 By johnray 串查程序代碼添加共用 ACTION 的引用
# Modify.........: No.MOD-7B0034 08/01/23 By Smapmin 單身維護單位轉換與維護日期資料後,要重新DISPLAY才會觸發ON ROW CHANGE
# Modify.........: No.FUN-810017 08/01/31 By jan 新增服飾作業和mark掉pjf021字段
# Modify.........: No.FUN-7B0018 08/02/01 By hellen 行業別拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.FUN-810045 08/02/26 By rainy 1.項目管理,pml121改為wbs編號/ pml122 改為活動編號,新增費用原因pml90
#                                                  2.子畫面 apmt421取消
#                                                  3.單身專案代號(pml12)後，加入wbs編號(pml121),活動代號(pml122),部門代號(pml67),費用原因(pml90),會計科目(pml40,pml401),預算編號(pml66),未稅單價(pml31),含稅單價(pml31t)
#                                                  4.pjf_file架構已全部不同，調整 pjf_file 相關處理
# Modify.........: NO.FUN-7C0002 08/03/06 by Yiting apsi214->apsi317.4gl
# Modify.........: No.CHI-820010 08/03/20 By claire 不使用計價單位,計價數量計算會有小數位差
# Modify.........: No.FUN-830086 08/03/24 By jan 當使用多屬性時，過料件編號，只要料號存在，母料號也可過
# Modify.........: No.MOD-830188 08/03/25 By Dido 單身維護時自動帶 pml08 庫存單位
# Modify.........: No.FUN-830132 08/03/27 By hellen 行業別拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.FUN-830161 08/04/01 By Carrier 去掉預算編號pml66,pmk06
# Modify.........: No.FUN-840042 08/04/15 by TSD.zeak 自訂欄位功能修改
# Modify.........: No.CHI-840016 08/04/16 By claire 由訂單來源產生的請購單,修改請購量時,要回寫訂單已轉請購量oeb28
# Modify.........: No.MOD-840226 08/04/20 By claire 不由訂單來源產生的請購單,刪除時會rollback
# Modify.........: No.MOD-840201 08/04/20 By claire 凍結碼default為'N'
# Modify.........: No.MOD-840626 07/04/24 By claire 當不使用計價單位及雙單位時,單身修改時若已存在單位一(pmn80)則單位一數量(pmn82)會不隱藏
# Modify.........: No.FUN-850027 08/05/30 By douzh WBS編碼錄入時要求時尾階并且為成本對象的WBS編碼
# Modify.........: No.MOD-860100 08/06/10 By Smapmin 修改set_no_entry的條件
# Modify.........: No.TQC-860019 08/06/09 By cliare ON IDLE 控制調整
# Modify.........: No.FUN-850027 08/06/17 By douzh 計算并檢核預算耗用時考慮是以部門還是以營運中心傳入計算耗用
# Modify.........: No.MOD-870021 08/07/01 By Mandy FUN-840042 不應加至t444() 的INPUT 段內
# Modify.........: No.MOD-870161 08/07/14 By chenmoyan BUG修改
#                                            1、修改報錯訊息mfg0032開啟后自動關閉
#                                            2、送貨地址和發票地址輸入無效數據時，添加報錯訊息
#                                            3、將“運送方式”欄位開窗
#                                            4、在未審核資料“取消審核”時，增加提示訊息
#                                            5、用直接錄入方式錄入一筆單身后確定，再點擊單身錄入，會報資料重復錯誤，修改此錯誤
# Modify.........: No.CHI-860042 08/07/22 By xiaofeizhu 加入一般采購和委外采購的判斷
# Modify.........: No.FUN-870124 08/07/29 By jan 服飾作業增加新的功能
# Modify.........: No.FUN-860106 08/08/06 By xiaofeizhu 多單位處理：輸入完子單位后，檢查最少采購量并帶出訊息
# Modify.........: No.FUN-880072 08/08/19 By jan 服飾作業過單
# Modify.........: No.FUN-890118 08/09/26 by sabrina add delete vmz_file
# Modify.........: No.FUN-8A0086 08/10/17 By baofei 完善FUN-710050的錯誤匯總的修改
# Modify.........: No.MOD-8a0276 08/11/01 By Smapmin MRP查詢無資料
# Modify.........: No.MOD-8C0134 08/12/15 By Smapmin 刪除/作廢時才update 訂單單身的請購單號為null
# Modify.........: No.CHI-8C0017 08/12/22 By xiaofeizhu 抓取供應商資料時應多加判斷pmh22='1',pmh21=''
# Modify.........: No.MOD-8C0263 08/12/26 By Smapmin 修改變數定義
# Modify.........: No.TQC-910003 09/01/03 BY DUKE MOVE OLD APS TABLE
# Modify.........: No.FUN-910005 09/01/06 BY DUKE ADD 串接 apsi317時,新增 vmz_file.vmz25 = 0
# Modify.........: No.MOD-910060 09/01/07 By Smapmin 修改預算編號的entry/noentry控管
# Modify.........: No.CHI-910021 09/02/01 By xiaofeizhu 有select bmd_file或select pmh_file的部份，全部加入有效無效碼="Y"的判斷
# Modify.........: No.MOD-920166 09/02/19 By Smapmin 移到下一筆後沒有改資料馬上按確認,不應控卡required
# Modify.........: No.FUN-920183 09/03/17 By shiwuying MRP功能改善,單身增加字段pml91
# Modify.........: No.FUN-930113 09/03/19 By mike   將oah_file-->pnz_file
# Modify.........: No.FUN-930104 09/03/23 By dxfwo   理由碼的分類改善
# Modify.........: No.MOD-950156 09/05/15 By xiaofeizhu ima920的部分有誤，應去除
# Modify.........: No.MOD-950256 09/05/30 By Dido 提前給予 g_pml2.pml31,g_pml2.pml31t 值
# Modify.........: No.MOD-950284 09/06/03 By Smapmin 使用利潤中心功能又做預算控管時,會一直卡在會計科目的欄位
# Modify.........: No.FUN-960007 09/06/03 By chenmoyan global檔內沒有定義rowid變量
# Modify.........: No.MOD-960034 09/06/03 By mike 計算pmk40=sum(pml88)
# Modify.........: No.MOD-960186 09/07/08 By Smapmin 使用多單位且料件為單一單位時,單位一的轉換率有錯誤
# Modify.........: No.FUN-950088 09/06/29 By hongmei 單身增加pml123,mse02欄位
# Modify.........: No.TQC-970119 09/07/13 By lilingyu 錄入完單頭在進入單身前報錯
# Modify.........: No.FUN-870007 09/07/16 By Zhangyajun 流通零售系統功能修改
# Modify.........: No.MOD-970187 09/07/21 By mike 在CONTROLO(預設上筆資料)時,加上 LET g_pml_t.* = g_pml[l_ac].*
# Modify.........: No.TQC-970421 09/08/03 By mike 還原MOD-970187的修改.
# Modify.........: No.TQC-970335 09/07/29 By dxfwo  sapmt420_slk.4gl
#1.單身異動"項次"字段跑on row change段時，不會更新pmli_file的項次字段，
#  下次再進入這筆單身數據時，在open t420_bcl_ind時會出現錯誤
#  g_pmli.pmli02 沒有更新為新值 導致在on row change 時沒有更新為新值
# Modify.........: No.FUN-980006 09/08/14 By TSD.sar2436 GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.MOD-960221 09/08/22 By Smapmin 檢核請購數量是否超過訂單數量
# Modify.........: No.MOD-960212 09/08/22 By Smapmin 單身新增時,未default pml08/pml09
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-960038 09/09/04 By chenmoyan 專案加上'結案'的判斷
# Modify.........: No.FUN-980038 09/09/10 By chenmoyan pmk02的值由smy72代出
# Modify.........: No.MOD-9A0028 09/10/07 By Dido 料件與前一筆不同時,應清空前一筆 pml40,pml401
# Modify.........: No.CHI-960033 09/10/10 By chenmoyan 加pmh22為條件者，再加pmh23=''
# Modify.........: No.CHI-960022 09/10/15 By chenmoyan 預設單位一數量時，加上判斷，單位一數量為空或為1時，才預設
# Modify.........: No.FUN-990080 09/10/21 By mike 于请购单单身增加pml16状态码栏位
# Modify.........: NO.FUN-9B0023 09/11/04 By baofei 寫入請購單身時，也要一併寫入"電子採購否(pml92)"='N'
# Modify.........: NO.FUN-9A0065 09/11/04 By baofei 增加Action"發佈電子採購需求"和身增加二個欄位"電子採購否(pml92)"、"電子採購序號(pml93)"
# Modify.........: NO.CHI-930021 09/11/17 By jan 虛擬料件不可做任何單據
# Modify.........: No:MOD-9B0137 09/11/23 By Smapmin 加嚴控管入庫/到廠/到貨日與單據日的檢核
# Modify.........: No:TQC-9C0003 09/12/10 By lilingyu 刪除一筆請購單號后,未清除掉axmt410訂單那邊生成的"請購單號"和"已轉請購量"等欄位內容
# Modify.........: No.FUN-9C0069 09/12/14 By bnlent mark or replace rucplant/ruclegal
# Modify.........: No:CHI-9C0002 09/12/15 By Smapmin special_description加入權限控管
# Modify.........: No:FUN-A10037 10/01/07 By bnlent 1.增加採購類型統采代采insert into ruc_file 2.零售採購中心管控，并改為buttonedit
# Modify.........: No:FUN-A10034 10/01/07 By baofei   取消確認時加判斷，if 有資料已轉電子採購，則不可取消確認及BUG修改
# Modify.........: No.FUN-A10034 10/01/09 By chenmoyan cus_temp請購單號，發布后清空多需求廠商
# Modify.........: No:FUN-9C0071 10/01/18 By huangrh 精簡程式
# Modify.........: No:FUN-A20039 10/02/21 By liuxqa 单身输入时，增加依产品订单展BOM请购。
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No:TQC-A30041 10/03/16 By Cockroach add oriu/orig
# Modify.........: No:MOD-A30154 10/03/24 By Smapmin 請購單做預算控管時,傳入的年月應為pmk31/pmk32
# Modify.........: No:MOD-A50021 10/05/07 By Smapmin sfb25-->sfb13
# Modify.........: No.FUN-A50071 10/05/19 By vealxu GP5.2 增加POS單號字段 并管控如果不為空的情況下 不可取消審核與取消過帳
# Modify.........: No.FUN-A50054 FUN-A60035 10/05/31 By chenmoyan 增加服饰版二维功能
# Modify.........: No:CHI-A40021 10/06/04 By Summer 用agli102科目是否有做專案控管的參數,
#                                                   做為抓取預算資料時是否要以專案為條件
# Modify.........: No:MOD-A50129 10/06/15 By Smapmin 單身新增時,不default料號
# Modify.........: No:FUN-A60035 10/07/06 By chenls 服飾狀態下單身顯示
# Modify.........: No:FUN-A70034 10/07/23 By Carrier 服饰版时自动产生单身CALL p490,若非服饰版时CALL p500
# Modify.........: No:MOD-A70072 10/07/23 By Carrier 供应商查询时,不区分业态
# Modify.........: No:FUN-A60035 10/07/27 By chenls 服飾版二維功能mark
# Modify.........: No:FUN-A80016 10/08/02 By houlia p500加傳參數接收QBE資料
# Modify.........: No:CHI-A80006 10/08/13 By Summer 單身查詢pml2應改為pml24
# Modify.........: No.FUN-A80087 10/08/31 By Lilan EF簽核時,賦值給g_action_choice
# Modify.........: No.FUN-A80150 10/09/07 By sabrina 單身新增"計畫批號"(pml919)欄位
# Modify.........: No.TQC-A90101 10/09/25 By Carrier prompt提示信息多语系化
# Modify.........: No.FUN-A90009 10/09/29 By destiny B2B修改
# Modify.........: No.FUN-A80148 10/10/09 By vealxu 因為rtzacti已不使用,所以都不要再使用rtzacti相關的變數名稱
# Modify.........: No:MOD-AA0099 10/10/19 By sabrina 在INSERT INTO pml_file前再取一次pml09的值
# Modify.........: No.FUN-AA0059 10/10/22 By chenying 料號開窗控管
# Modify.........: No.FUN-AA0059 10/11/01 By huangtao 修改料號AFTER FIELD的管控
# Modify.........: No.MOD-AA0084 10/11/03 By lilingyu 進入單身,未錄入資料,此時按“確定”鍵,程式無法結束錄入動作
# Modify.........: No.FUN-A80117 10/11/09 By huangtao
# Modify.........: No.TQC-AB0038 10/11/09 By vealxu sybase err
# Modify.........: No.FUN-AB0025 10/11/11 By vealxu 全系統增加料件管控
# Modify.........: No.TQC-AB0081 10/11/28 By lixh1  複製后按esc键取消,"請購日期"欄位也一併顯示出來
# Modify.........: No.TQC-AB0397 10/11/30 By wangxin 給pml91默認值'N'
# Modify.........: No.TQC-AC0337 10/12/23 By huangrh 來源為2補貨建議的請購單據不可刪除數據，只能有補貨建議取消確認同時刪除
# Modify.........: No.MOD-AC0309 10/12/28 By chenying 新增時pml04欄位欄位可開窗複選料號，但複選後，料號不會分項次到請購單單身
# Modify.........: No.MOD-AC0309 11/01/04 By chenying 將"複選自動展單身"的功能先MARK，恢複為原程式，但新增時，只能單選
# Modify.........: No.TQC-B10044 11/01/07 By huangrh  IF g_success = 'Y' THEN #TQC-AB0397 add   判斷 的去掉 判斷
# Modify.........: No.TQC-AC0375 11/01/12 By huangtao apm1024 報錯加條件
# Modify.........: No:MOD-B10094 11/01/13 By Summer 會科欄位pml40|pml401應該要隨著料號做default
# Modify.........: No:MOD-B10129 11/01/19 By Summer 不需獨立出ICD,故mark掉ICD
# Modify.........: No:FUN-B10052 11/01/26 By lilingyu 科目查詢自動過濾
# Modify.........: No:TQC-B20184 11/02/28 By wuxj   電子採購按鈕中多廠商需求廠商欄位檢查修改
# Modify.........: No:TQC-B30010 11/03/02 By wuxj   電子採購按鈕中更改报价截止日栏位时，无法执行
# Modify.........: No.MOD-B30150 11/03/11 By huangrh 當點選採購狀況查詢是單身有資料的，
                                                     #之後再點選採購狀況查詢單身是沒有資料，在右方按鈕出現一堆的按鈕。
# Modify.........: No:MOD-B30262 11/03/12 By wangxin 取消審核時判斷是否存在請購變更單，若存在則不能取消審核。
# Modify.........: No:MOD-B30310 11/03/12 By chenying 請購單單頭POS欄位、[電子採購收貨]是否流通才顯示(相關文件)
# Modify.........: No:TQC-B30200 11/03/29 By lilingyu 請購單單身錄入MISC,報錯"此料件不存在於料件主檔中..."
# Modify.........: No:FUN-B30211 11/04/01 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No:FUN-B30082 11/04/02 By yangtingting 添加action"變更狀況",使其直接連接到apmt900
# Modify.........: No:MOD-B40202 11/04/21 By lilingyu 在asmi300中設置單別做預算控管時,請購單錄完單身後控管不嚴謹
# Modify.........: No:FUN-B40042 11/04/26 By shiwuying 料号开窗更改
# Modify.........: No:FUN-B40085 11/04/26 By xianghui 加cl_used(g_prog,g_time,2)
# Modify.........: No:TQC-B50066 11/05/16 By lilingyu 費用預算控管時,程式跳不出來
# Modify.........: No:TQC-B50094 11/05/18 By wujie    通过预算项目带出预设科目改为从aglt600抓科目
# Modify.........: No:FUN-B50046 11/05/24 By abby APS GP5.25追版問題調整
# Modify.........: No:MOD-B50258 11/05/31 By zhangll 修正TQC-B50066问题
# Modify.........: No.FUN-B50063 11/06/01 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.MOD-B60032 11/06/03 By zhangll 做預算控管的請購單可以不輸入單價就可以確認及審核
# Modify.........: No:MOD-B60015 11/06/10 By Summer 將default幣別的動作拿掉
# Modify.........: No:MOD-B60119 11/06/15 By JoHung 刪除單身時一併刪除對應項次的特別說明
#                                                   修改單身項次時一併修改對應的特別說明項次
# Modify.........: No:TQC-B60102 11/06/15 By zhangweib 在AFTER INPUT斷加入對請購員的檢查
# Modify.........: No:MOD-B70253 11/07/27 By johung 在t420_b() BEFORE ROW給g_no值
# Modify.........: No.FUN-B80088 11/08/10 By fengrui  程式撰寫規範修正
# Modify.........: No:FUN-B80167 11/08/24 By Abby 單身增加show pml05(APS單據編號)欄位,NOENTRY,不可輸入,當參數與APS串聯時,此欄位才show
# Modify.........: No:CHI-B80082 11/09/08 By johung 將apm-281控卡改為判斷是否存在pmh_file，存在才允許修改
#                                                   t420_pmh()加傳參數-料號
# Modify.........: No:MOD-B90082 11/09/09 By suncx 品名抓取錯誤BUG修正，新增t420_get_pml041()抓取品名和規格
# Modify.........: No:MOD-B90092 11/09/13 By suncx 取消審核時不應更新單身狀況碼為9、已作廢的
# Modify.........: No:MOD-B90094 11/09/13 By suncx 1.請購單作業：取消審核，作廢兩個功能之后沒有show(),導致狀態不能正确顯示
#                                                  2.請購單取消審核時，如果單頭狀態碼為2,6,9時，沒有報錯信息。

# Modify.........: No.FUN-B90101 11/10/09 By lixiang  服飾二維開發
# Modify.........: No.MOD-BB0233 11/11/22 By ck2yuan  mark  CALL cl_set_comp_required("pml20",TRUE) #No.FUN-870007
# Modify.........: No.TQC-C10020 12/01/05 By suncx 無資料時，點擊複製報錯信息內容不對
# Modify.........: No.TQC-C10018 12/01/05 By suncx CHI-B80082卡控時未完全卡控住資料
# Modify.........: No:FUN-BB0086 12/01/18 By tanxc 增加數量欄位小數取位

# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No:FUN-C20006 12/02/03 By lixiang 服飾二維BUG修改(對多屬性料件的判斷，製造業開啟的畫面等)
# Modify.........: No:MOD-BA0139 12/02/03 By Vampire 將_u() -420 錯誤訊息改為 -400
# Modify.........: No:MOD-BC0117 12/02/03 By Vampire 請購部門會被改回原部門
# Modify.........: No:MOD-C10008 12/02/03 By Vampire 如果匯率是null,則給1去做預算控管的計算
# Modify.........: No.MOD-C10159 12/02/03 By jt_chen 取消確認時,更動序號不加1
# Modify.........: No:FUN-C20026 12/02/04 By Abby EF功能調整-客戶不以整張單身資料送簽問題
# Modify.........: No:TQC-BB0169 12/02/13 By destiny 取消确认应清空审核人
# Modify.........: No:TQC-BB0128 12/02/13 By destiny 显示运输方式说明栏
# Modify.........: No.TQC-BB0121 12/02/13 By lilingyu 錄入完供應商,帶出賬單地址和送貨地址後，光標移至此欄位，值又會清除
# Modify.........: No:TQC-BC0111 12/02/16 By SunLM 当料件的供應廠商和幣種為空時,單身料號欄位(pml04)不进行管制(l_ima915 ='1' OR l_ima915='3')
# Modify.........: No.TQC-BB0167 12/02/16 By SunLM display廠牌名稱
# Modify.........: No:TQC-C20232 12/02/11 By lixiang BUG修改
# Modify.........: No:TQC-C20292 12/02/20 By lixiang BUG修改
# Modify.........: No:TQC-C20183 12/02/21 By fengrui 數量欄位小數取位處理
# Modify.........: No:TQC-C20348 12/02/22 By lixiang 服飾流通業商品策略，採購策略的修改
# Modify.........: No:TQC-C20411 12/02/23 By lixiang 服飾中詳細資料即使顯示
# Modify.........: No.MOD-C10218 12/02/29 By jt_chen 作廢還原時控卡已轉數量不可大於來源單據數量
# Modify.........: No:TQC-C30005 12/03/01 By lixiang 修正TQC-C20348的問題
# Modify.........: No:MOD-C30118 12/03/09 By lixiang 修改新增時的備份值
# Modify.........: No:TQC-C30196 12/03/10 By lixiang 服飾新增時錄入資料后，再返回來更改母料件,需將後面的數值金額欄位等重新賦值
# Modify.........: No:MOD-C30217 12/03/10 By lixiang 控管數量欄位數量不可小於零 和多屬性單身bug修改
# Modify.........: No:FUN-C30052 12/03/14 By lixiang 支持服飾流通業下母料件可以錄入相同的料件編號
# Modify.........: No:TQC-C30165 12/03/27 By SunLM 修正複製採購單據時候,匯率不能取到最新值
# Modify.........: No:FUN-C30293 12/03/29 By Abby  執行[單身],換下一行按"放棄",狀況碼需不變
# Modify.........: No:TQC-C40149 12/04/18 By lixiang 復制時，沒有將到庫/到廠/交貨日期復制到詳細資料頁簽
# Modify.........: No:TQC-C50053 12/05/04 By fanbj  apmt420請購時沒有根據料號正確帶出經營方式，報-217錯誤 找不到rts930,rtt930字段
# Modify.........: No:FUN-C50051 12/05/14 By lixiang 母單身料件和供應廠商關系依照料件來控管，判斷ima915
# Modify.........: No.CHI-C30002 12/05/24 By yuhuabao 離開單身時若單身無資料提示是否刪除單頭資料
# Modify.........: No:FUN-C60100 12/06/26 By qiaozy   服飾流通：快捷鍵controlb的問題，切換的標記請在BEFORE INPUT 賦值
# Modify.........: No:FUN-C30085 12/07/04 By nanbing CR改串GR
# Modify.........: No:FUN-C60098 12/07/12 By xjll    服飾流通行業單身開啟對話框可選擇直接錄入或從訂單帶出
# Modify.........: No:MOD-C70108 12/07/17 By SunLM  月結后,不能錄入上月單據
# Modify.........: No:FUN-C80046 12/08/13 By bart 複製後停在新料號畫面
# Modify.........: No.FUN-C80045 12/08/17 By nanbing 檢查POS單別，不允許在ERP中錄入
# Modify.........: No:MOD-C80135 12/09/17 By jt_chen 刪除請購單時，回寫訂單的已轉請購量有誤
# Modify.........: No:MOD-C80244 12/09/21 By Elise 單身新增時將備註pml06清空
# Modify.........: No:MOD-C80239 12/09/21 By Elise 還原TQC-BB0169,新增修改時確認人no entry
# Modify.........: No:MOD-C80183 12/10/10 By yinhy 單頭部門更改且不做預算控管時，單身部門應與單頭部門一致
# Modify.........: No.FUN-CB0014 12/11/12 By xujing 增加資料清單
# Modify.........: No.CHI-C80041 12/11/27 By bart 取消單頭資料控制
# Modify.........: No.FUN-CC0057 12/12/17 By xumeimei 增加生产营运中心栏位
# Modify.........: No.TQC-D10084 13/01/28 By xianghui 資料清單頁簽下隱藏一部分ACTION
# Modify.........: No.FUN-C30075 13/01/29 By Sakura 料號為特性主料(ima928='Y')時需判斷存在替代料資料(apmi303)
# Modify.........: No:MOD-CA0223 13/01/31 By Elise 預算控管時MOD-C10008有給幣別與匯率預設值,請調整增加DISPLAY顯示
# Modify.........: No.FUN-D20025 13/02/21 By nanbing 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No:MOD-D10269 13/02/26 By Elise 新增時變更版號pmk03不能輸入
# Modify.........: No.MOD-D20125 13/03/04 By bart 請購單整張刪除時，抓取pml41資料，以”-“分隔取得模擬版本，update mss10='N'
# Modify.........: No.TQC-D30025 13/03/08 By bart pml41_c1 多判斷 pml41 不為空值
# Modify.........: No:CHI-C10037 13/03/22 By Elise s_sizechk.4gl目前只有判斷採購單位，應該要考慮單據單位
# Modify.........: No:FUN-D30087 13/03/27 By Elise 廠牌開窗判斷有做需要料件承認(ima926)的撈abmi310，若沒有的則撈amri504
# Modify.........: No:FUN-D30088 13/03/27 By Elise 增加action單身全部刪除後重新產生的功能
# Modify.........: No:CHI-C80072 13/03/27 By xumm 取消审核赋值审核异动日期和审核异动人员
# Modify.........: No:CHI-D20006 13/04/08 By jt_chen 調整單身無資料，進單身也需開窗(4204)詢問USER
# Modify.........: No.CHI-D30005 13/04/09 By Elise 串查apmi600第一個參數g_argv1為廠商代號,第二個g_argv2為執行功能
# Modify.........: No.TQC-D40036 13/04/16 By chenjing 取消审核赋值审核异动日期和审核异动人员
# Modify.........: No:TQC-D40025 13/04/19 By chenjing 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No:FUN-D50097 13/05/29 By zhuhao 更改ACTION CONTROLF显示顺序

DATABASE ds

GLOBALS "../../config/top.global"
GLOBALS "../4gl/sapmt420.global"
GLOBALS "../../axm/4gl/s_slk.global"      #No.FUN-B90101

DEFINE g_bookno1     LIKE aza_file.aza81  #No.FUN-730033
DEFINE g_bookno2     LIKE aza_file.aza82  #No.FUN-730033
DEFINE g_flag        LIKE type_file.chr1  #No.FUN-730033
DEFINE g_sum1        LIKE afc_file.afc07  #No.FUN-830161
DEFINE g_sum2        LIKE afc_file.afc07  #No.FUN-830161
DEFINE g_pml02       LIKE type_file.chr20  #FUN-890118
DEFINE g_cnt1        LIKE type_file.num5   #FUN-9A0065
DEFINE g_rec_b1      LIKE type_file.num5
DEFINE   g_b_flag       LIKE type_file.chr1   #TQC-D40025
#DEFINE g_multi_ima01 STRING               #MOD-AC0309
DEFINE  g_pml1  DYNAMIC ARRAY OF RECORD
                ch     LIKE  type_file.chr1,  #選擇
                wpc10  LIKE  wpc_file.wpc10,  #No.FUN-A90009
                pml33  LIKE  pml_file.pml33,  #No.FUN-A90009
                pml02  LIKE  pml_file.pml02,  #項次
                pml04  LIKE  pml_file.pml04,  #料件編號
                pml041 LIKE  pml_file.pml041, #品名規格
                pml07  LIKE  pml_file.pml07,  #請購單位
                pml20  LIKE  pml_file.pml20  #訂購量
                END RECORD
DEFINE  g_pml1_t  DYNAMIC ARRAY OF RECORD
                ch     LIKE  type_file.chr1,  #選擇
                wpc10  LIKE  wpc_file.wpc10,  #No.FUN-A90009
                pml33  LIKE  pml_file.pml33,  #No.FUN-A90009
                pml02  LIKE  pml_file.pml02,  #項次
                pml04  LIKE  pml_file.pml04,  #料件編號
                pml041 LIKE  pml_file.pml041, #品名規格
                pml07  LIKE  pml_file.pml07,  #請購單位
                pml20  LIKE  pml_file.pml20  #訂購量
                END RECORD
DEFINE g_renew      LIKE  type_file.num5
DEFINE g_ac         LIKE  type_file.num5
DEFINE   g_c            DYNAMIC ARRAY OF RECORD
               pmk09       LIKE pmk_file.pmk09,
               pmc03       LIKE pmc_file.pmc03
                           END RECORD
DEFINE   g_wpc         RECORD LIKE wpc_file.*
DEFINE g_channel        base.Channel
DEFINE g_tmpstr         STRING
DEFINE g_pml07_t         LIKE pml_file.pml07   #No.FUN-BB0086
DEFINE g_pml80_t         LIKE pml_file.pml80   #No.FUN-BB0086
DEFINE g_pml83_t         LIKE pml_file.pml83   #No.FUN-BB0086
DEFINE g_pml86_t        LIKE pml_file.pml86   #No.FUN-BB0086

#FUN-B90101--add--begin--
#FUN-B90101--add--end--

#FUN-CB0014---add---str---
DEFINE g_pmk_l       DYNAMIC ARRAY OF RECORD
                  pmk46    LIKE pmk_file.pmk46,
                  pmk01    LIKE pmk_file.pmk01,
                  pmk03    LIKE pmk_file.pmk03,
                  pmk04    LIKE pmk_file.pmk04,
                  pmk02    LIKE pmk_file.pmk02,
                  pmk09    LIKE pmk_file.pmk09,
                  pmc03    LIKE pmc_file.pmc03,
                  pmk49    LIKE pmk_file.pmk49,
                  pmk18    LIKE pmk_file.pmk18,
                  pmkcond  LIKE pmk_file.pmkcond,
                  pmkconu  LIKE pmk_file.pmkconu,
                  pmkconu_desc LIKE gen_file.gen02,
                  pmk47    LIKE pmk_file.pmk47,
                  pmkplant LIKE pmk_file.pmkplant
                     END RECORD,
       l_ac4      LIKE type_file.num5,
       g_rec_b4   LIKE type_file.num5,
       g_action_flag     STRING
DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode
#FUN-CB0014---add---end---

FUNCTION t420(p_argv1,p_argv2,p_argv3,p_argv4) #No.FUN-630010
   DEFINE p_argv1    LIKE pmk_file.pmk01,     #請購單號
          p_argv2    LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01)         #狀況碼
          p_argv3    LIKE pmk_file.pmk02,     #性質
          p_argv4    STRING                   #No.FUN-630010

   WHENEVER ERROR CONTINUE

   IF g_sma.sma31 matches'[Nn]' THEN    #無使用請購功能
      CALL cl_err(g_sma.sma31,'mfg0032',1)    #No.MOD-870161
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B40085
      EXIT PROGRAM                            #No.MOD-870161
   END IF
   CREATE TEMP TABLE apm_p470(
       sfb01    LIKE sfb_file.sfb01,   #add by lanhang 130922
       part     LIKE sfa_file.sfa03,
       sfbud02  LIKE sfb_file.sfbud02,
       sfa26    LIKE sfa_file.sfa26,
       sfb13    LIKE sfb_file.sfb13,    #實際開工日 #MOD-740471 add   #MOD-A50021 sfb25-->sfb13
       req_qty  LIKE sfa_file.sfa04,
       al_qty   LIKE sfa_file.sfa04,
       pr_qty   LIKE sfa_file.sfa04,
       po_qty   LIKE sfa_file.sfa04,
       qc_qty   LIKE sfa_file.sfa04,
       wo_qty   LIKE sfa_file.sfa04)

   CREATE UNIQUE INDEX p470_t1 ON apm_p470 (sfa01,part,sfa26,sfb13)  #MOD-740471   #MOD-A50021 sfb25--sfb13 #add sfa01 by lanhang 130922
   DROP table  cus_temp

   CREATE TEMP TABLE cus_temp (
     c01  LIKE  pml_file.pml02,
     c02  LIKE  pmk_file.pmk09,
     c03  LIKE  pmk_file.pmk01)
   INITIALIZE g_pmk.* TO NULL
   INITIALIZE g_pmk_t.* TO NULL
   INITIALIZE g_pmk_o.* TO NULL
   LET g_rec_b1 = 0   #FUN-9A0065
   #初始化界面的樣式(沒有任何默認屬性組)
   LET lg_smy62 = ''
   LET lg_group = ''

   LET g_forupd_sql = "SELECT * FROM pmk_file WHERE pmk01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t420_cl CURSOR FROM g_forupd_sql

   LET g_argv1 = p_argv1      #單號
   LET g_argv2 = p_argv2      #狀況
   LET g_argv3 = p_argv3      #性質
   LET g_argv4 = p_argv4      #No.FUN-630010
   LET g_ydate = NULL

   IF fgl_getenv('EASYFLOW') = "1" THEN   #判斷是否為簽核模式
      LET g_argv1 = aws_efapp_wsk(1)   #取得單號
   END IF
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
      OPEN WINDOW t420_w WITH FORM "apm/42f/apmt420"
       ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
#FUN-B90101 add &endif
      CALL cl_ui_init()
   END IF
   LET g_sql = "pmk48,pmk46,pmkcond,pmkcont,pmkconu,pmkconu_desc,pmk47,pmk47_desc,pmk50,pmk50_desc,"    #FUN-CC0057 add pmk50,pmk50_desc
             ||"pmkplant,pmkplant_desc,pml47,pml48,pml48_desc,"
             ||"pml49,pml50,pml51,pml52,pml53,pml54,pml55,pml56"
   CALL cl_set_comp_visible(g_sql,g_azw.azw04='2')
   CALL cl_set_comp_visible('pml919',g_sma.sma1421='Y')         #FUN-A80150 add
   CALL cl_set_act_visible("e_proc_require",g_aza.aza95='Y')    #No.FUN-A90009
   CALL cl_set_comp_visible("pmlislk01",FALSE)    #No.FUN-810017
   CALL cl_set_comp_visible("pmlslk92",g_aza.aza95 = 'Y')     #FUN-B90101
   CALL cl_set_comp_visible("pmk49",g_aza.aza88 = 'Y')#No.FUN-A50071 add
   CALL cl_set_comp_visible("pml93,pml92",g_aza.aza95 = 'Y')  #MOD-B30310 add
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
#FUN-C60100 ADD &IFDEF
#FUN-C60100 ADD &ENDIF
   CALL cl_set_comp_visible("pml05",g_sma.sma901 = 'Y') #FUN-B80167 add

   CALL t420_refresh_detail()   #No.TQC-650108

   CALL aws_efapp_toolbar()    #建立簽核模式時的 toolbar icon #FUN-580011

   #將aws_gpmcli_toolbar()移到aws_efapp_toolbar()之後
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      IF g_aza.aza71 MATCHES '[Yy]' THEN
         CALL aws_gpmcli_toolbar()
         CALL cl_set_act_visible("gpm_show,gpm_query", TRUE)
      ELSE
         CALL cl_set_act_visible("gpm_show,gpm_query", FALSE)
      END IF
   END IF

   CALL t420_def_form()

   IF NOT cl_null(g_argv1) THEN
      CASE g_argv4
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t420_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t420_a()
            END IF
         WHEN "efconfirm"
            LET g_action_choice = "efconfirm"        #FUN-A80087 add
            CALL t420_q()
            CALL t420sub_y_chk(g_pmk.pmk01)          #CALL 原確認的 check 段 #FUN-740034
            IF g_success = "Y" THEN
               CALL t420sub_y_upd(g_pmk.pmk01,g_action_choice)       #CALL 原確認的 update 段
            END IF
            CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B40085
            EXIT PROGRAM
         OTHERWISE
            CALL t420_q()
      END CASE
   END IF

   ##傳入簽核模式時不應執行的 action 清單
   #CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, confirm, undo_confirm,easyflow_approval, aps_related_data")  #TQC-740281 #FUN-D20025 mark
   CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, undo_void, confirm, undo_confirm,easyflow_approval, aps_related_data") #FUN-D20025 add
         RETURNING g_laststage

   CALL t420_menu()

   CLOSE WINDOW t420_w

END FUNCTION

FUNCTION t420_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
DEFINE  l_ima926        LIKE    ima_file.ima926   #FUN-D30087 add
DEFINE tok          base.StringTokenizer  # add by lixwz 20170929
DEFINE l_sfaud01       LIKE sfa_file.sfaud01  # add by lixwz 20170929
DEFINE l_chk           LIKE type_file.num5  # add by lixwz 20170929

   CLEAR FORM
   CALL g_pml.clear()
#No.FUN-B90101--add--
#No.FUN-B90101--end--

   IF NOT cl_null(g_argv1) THEN
      # add by lixwz 20170929 s
      IF g_argv1[1,1] = '/' THEN
          LET tok = base.StringTokenizer.create(g_argv1,'/')
          #LET l_tok = 1
          LET g_wc = " pmk01 in("
          WHILE tok.hasMoreTokens()
           # IF l_tok = 1 THEN
           #   LET  g_wc = g_wc CLIPPED , tok.nextToken() CLIPPED,"'"
           #   LET l_tok =2
           # ELSE
           #   LET  g_wc = g_wc CLIPPED ,",'",tok.nextToken() CLIPPED,"'"
           # END IF
	           LET g_sql ="SELECT DISTINCT sfaud01 FROM sfa_file ",
	               " WHERE sfa01 = '",tok.nextToken() CLIPPED ,"'"
	  				 EXIT WHILE
          END WHILE
          PREPARE i301_pmk FROM g_sql
    			DECLARE pmk_curs  CURSOR FOR i301_pmk

    			LET l_chk = 1
    			FOREACH pmk_curs INTO l_sfaud01
    				IF SQLCA.sqlcode THEN
	             CALL cl_err('foreach:',SQLCA.sqlcode,1)
	             EXIT FOREACH
	          END IF

	          IF l_chk =1 THEN
	          		LET l_chk =2
	          ELSE
	          		LET g_wc = g_wc CLIPPED ,","
	         	END IF

	          LET g_wc = g_wc CLIPPED,"'",l_sfaud01 CLIPPED,"'"
    			END FOREACH
          LET  g_wc = g_wc CLIPPED ,")"
      # add by lixwz 20170929 e
      ELSE
          LET g_wc = " pmk01 = '",g_argv1,"'"
          LET g_wc2 = ' 1=1'  #TQC-730022
      END IF
   ELSE
      CALL cl_set_head_visible("","YES")           #No.FUN-6B0032
      INITIALIZE g_pmk.* TO NULL    #No.FUN-750051`
#FUN-B90101--add--begin--
      DIALOG ATTRIBUTES(UNBUFFERED)
      CONSTRUCT BY NAME g_wc ON pmk46,pmk01,pmk03,pmk04,pmk48,pmk02,pmk09,pmk05,pmk49,pmk18,   #No.FUN-870007  #FUN-A50071 add pmk49
                                pmkcond,pmkconu,pmkcont,pmk47,pmk50,pmkplant,            #No.FUN-870007 #FUN-CC0057 add pmk50
                                pmk20,pmk41,pmk10,pmk11,pmk12,pmk13,pmk21,
                                pmk43,pmk22,pmk42,pmk45,pmkmksg,pmksign,pmk25,
                                pmk14,pmk15,pmk16,pmk17,pmk30,
                                pmkud01,pmkud02,pmkud03,pmkud04,pmkud05,
                                pmkud06,pmkud07,pmkud08,pmkud09,pmkud10,
                                pmkud11,pmkud12,pmkud13,pmkud14,pmkud15,
                                pmkuser,pmkgrup,pmkmodu,pmkdate,pmkacti,pmkcrat    #No.FUN-870007-add-pmkcrat
                               ,pmkoriu,pmkorig                           #TQC-A30041 ADD

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
      END CONSTRUCT
      CONSTRUCT g_wc2 ON pml02,pml24,pml25,pml47,pml04,pml041,pml07,        #No.FUN-870007 #CHI-A80006 mod pml2->pml24
                         pml48,pml49,pml50,pml51,pml52,pml53,pml54,pml20,    #No.FUN-870007
                         pml83,pml84,pml85,pml80,pml81,pml82,pml86,pml87,
                         pml21,pml35,pml34,pml33,pmlud02,pml919,pml55,pml41,pml190,pml191,pml192,  #No.FUN-630040   #No.TQC-640132 #No.FUN-870007-add-pml55 #FUN-A80150 pml919
                         pml92,pml93,                  #FUN-9A0065 add pml92,pml93
                         pml12,pml121,pml122,
                         pml67,pml90,pml40,pml401,pml31,p31t,        #FUN-810045 add  #No.FUN-830161
                         pml930,pml06,pml16,pml56,pml123                   #FUN-570106  #FUN-670051 #FUN-950088 add pml123 #No.FUN-870007-add-pml56 #FUN-990080 add pml16
                         ,pml91          #No.FUN-920183 add
                         ,pml05          #No.FUN-B80167 add
           ,pmlud01,pmlud03,pmlud04,pmlud05,
           pmlud06,pmlud07,pmlud08,pmlud09,pmlud10,
           pmlud11,pmlud12,pmlud13,pmlud14,pmlud15
           FROM s_pml[1].pml02,
                s_pml[1].pml24,s_pml[1].pml25,   #NO.FUN-670007 add
                s_pml[1].pml47,                  #No.FUN-870007
                s_pml[1].pml04,
                s_pml[1].pml041,s_pml[1].pml07,
                s_pml[1].pml48,s_pml[1].pml49,   #No.FUN-870007
                s_pml[1].pml50,s_pml[1].pml51,   #No.FUN-870007
                s_pml[1].pml52,s_pml[1].pml53,   #No.FUN-870007
                s_pml[1].pml54,                  #No.FUN-870007
                s_pml[1].pml20, s_pml[1].pml83,
                s_pml[1].pml84, s_pml[1].pml85,
                s_pml[1].pml80, s_pml[1].pml81,
                s_pml[1].pml82, s_pml[1].pml86,
                s_pml[1].pml87, s_pml[1].pml21,
                s_pml[1].pml35, s_pml[1].pml34,   #FUN-570106   #No.TQC-640132
                s_pml[1].pml33,s_pml[1].pmlud02, s_pml[1].pml919,s_pml[1].pml55,s_pml[1].pml41,   #FUN-570106   #No.TQC-640132 #No.FUN-870007-add-pml55 #FUN-A80150 add pml919
                s_pml[1].pml190,s_pml[1].pml191,s_pml[1].pml192,  #No.FUN-630040
                s_pml[1].pml92,s_pml[1].pmL93,  #FUN-9A0065 add pml92,pml93
                s_pml[1].pml12, s_pml[1].pml121,
                s_pml[1].pml122,
                s_pml[1].pml67,s_pml[1].pml90,
                s_pml[1].pml40,s_pml[1].pml401,
                s_pml[1].pml31,s_pml[1].pml31t,                 #No.FUN-830161
                s_pml[1].pml930,s_pml[1].pml06,  #FUN-670051
                s_pml[1].pml16, #FUN-990080
                s_pml[1].pml56,                  #No.FUN-870007
                s_pml[1].pml123    #FUN-950088 add
               ,s_pml[1].pml91                 #No.FUN-920183 add
               ,s_pml[1].pml05                 #No.FUN-B80167 add
                ,s_pml[1].pmlud01,s_pml[1].pmlud03,s_pml[1].pmlud04,s_pml[1].pmlud05,
                s_pml[1].pmlud06,s_pml[1].pmlud07,s_pml[1].pmlud08,s_pml[1].pmlud09,s_pml[1].pmlud10,
                s_pml[1].pmlud11,s_pml[1].pmlud12,s_pml[1].pmlud13,s_pml[1].pmlud14,s_pml[1].pmlud15

		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
      END CONSTRUCT

      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(pmk01) #請購單號
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmk3"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk01
                 NEXT FIELD pmk01

            WHEN INFIELD(pmk05)  #專案代號
                 CALL cl_init_qry_var()
                 LET g_qryparam.state= "c"
                 LET g_qryparam.form ="q_pja2"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk05
                 NEXT FIELD pmk05
            WHEN INFIELD(pmk09) #查詢廠商檔
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmc1"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk09
                 NEXT FIELD pmk09
            WHEN INFIELD(pmk10)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form = "q_pme"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk10
            WHEN INFIELD(pmk11)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form = "q_pme"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk11
            WHEN INFIELD(pmk12) #請購員
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gen"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk12
                 NEXT FIELD pmk12
            WHEN INFIELD(pmk13) #請購Dept
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gem"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk13
                 NEXT FIELD pmk13
            WHEN INFIELD(pmk14) #收貨Dept
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gem"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk14
                 NEXT FIELD pmk14
            WHEN INFIELD(pmk15) #確認人
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gen"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk15
                 NEXT FIELD pmk15
            WHEN INFIELD(pmk16) #運送方式
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_ged"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk16
                 NEXT FIELD pmk16
            WHEN INFIELD(pmk17) #廠商資料
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmc1"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk17
                 NEXT FIELD pmk17
            WHEN INFIELD(pmk20) #查詢付款條件資料檔(pma_file)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pma"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk20
                 NEXT FIELD pmk20
            WHEN INFIELD(pmk21) #查詢稅別資料檔(gec_file)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gec"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk21
                 NEXT FIELD pmk21
            WHEN INFIELD(pmk22) #查詢幣別資料檔
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_azi"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk22
                 NEXT FIELD pmk22
            WHEN INFIELD(pmk41) #價格條件
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pnz01" #FUN-930113 oah-->pnz01
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk41
                 NEXT FIELD pmk41
            WHEN INFIELD(pmkconu) #確認人員
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmkconu"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkconu
                 NEXT FIELD pmkconu
            WHEN INFIELD(pmk47) #取貨機構
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_azp"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk47
                 NEXT FIELD pmk47
            #FUN-CC0057------add----str
            WHEN INFIELD(pmk50)  #生产营运中心
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmk50"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmk50
                 NEXT FIELD pmk50
            #FUN-CC0057------add----end
            WHEN INFIELD(pmkplant) #機構別
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_azp"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkplant
                 NEXT FIELD pmkplant
            WHEN INFIELD(pmkud02)
                 CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkud02
                 NEXT FIELD pmkud02
            WHEN INFIELD(pmkud03)
                 CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkud03
                 NEXT FIELD pmkud03
            WHEN INFIELD(pmkud04)
                 CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkud04
                 NEXT FIELD pmkud04
            WHEN INFIELD(pmkud05)
                 CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkud05
                 NEXT FIELD pmkud05
            WHEN INFIELD(pmkud06)
                 CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmkud06
                 NEXT FIELD pmkud06
            WHEN INFIELD(pmlslk04) #料件編號
                 CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmlslk04
                 NEXT FIELD pmlslk04
            WHEN INFIELD(pmlslk07) #採購單位
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gfe"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pmlslk07
                 NEXT FIELD pmlslk07
            WHEN INFIELD(pmlslk90) #費用原因
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf01a"
                  LET g_qryparam.state = "c"   #多選
                  LET g_qryparam.arg1 = '7'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO pmlslk90
                  NEXT FIELD pmlslk90
            WHEN INFIELD(pml04) #料件編號
#FUN-AA0059--------mod------------str-----------------
#                 CALL cl_init_qry_var()
#                 LET g_qryparam.form = "q_ima"
#                 LET g_qryparam.state = 'c'
#                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059--------mod------------end-----------------
                 DISPLAY g_qryparam.multiret TO pml04
                 NEXT FIELD pml04
            WHEN INFIELD(pml07) #採購單位
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gfe"
                 LET g_qryparam.state = 'c'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml07
                 NEXT FIELD pml07
            WHEN INFIELD(pml83)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form ="q_gfe"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml83
                 NEXT FIELD pml83

            WHEN INFIELD(pml80)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form ="q_gfe"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml80
                 NEXT FIELD pml80

            WHEN INFIELD(pml86)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form ="q_gfe"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml86
                 NEXT FIELD pml86
            WHEN INFIELD(pml12)  #專案代號
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_pja2"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml12
                 NEXT FIELD pml12
            WHEN INFIELD(pml121) #WBS
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_pjb4"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml121
                 NEXT FIELD pml121
            WHEN INFIELD(pml122) #活動
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_pjk3"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml122
                 NEXT FIELD pml122
            WHEN INFIELD(pml67)  #部門
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gem"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml67
                 NEXT FIELD pml67
            WHEN INFIELD(pml90) #費用原因
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_azf01a"    #No.FUN-930104
                 LET g_qryparam.state = "c"   #多選
                 LET g_qryparam.arg1 = '7'          #No.FUN-930104
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml90
                 NEXT FIELD pml90
            WHEN INFIELD(pml40)  #科目
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_aag"
                 LET g_qryparam.state = "c"   #多選
                 LET g_qryparam.arg1 = g_bookno1   #No.FUN-730033
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml40
                 NEXT FIELD pml40
            WHEN INFIELD(pml401) #科目二
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_aag"
                 LET g_qryparam.state = "c"   #多選
                 LET g_qryparam.arg1 = g_bookno2   #No.FUN-730033
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml40
                 NEXT FIELD pml401
            WHEN INFIELD(pml930)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form  = "q_gem4"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml930
                 NEXT FIELD pml930
            WHEN INFIELD(pml123)
                 LET l_ima926 = 'N'                #FUN-D30087 add
                 SELECT ima926 INTO l_ima926 FROM ima_file  #FUN-D30087 add
                  WHERE ima01 = g_pml[l_ac].pml04           #FUN-D30087 add
                 CALL cl_init_qry_var()
                 IF l_ima926 = 'Y' THEN            #FUN-D30087 add
                    LET g_qryparam.form = "q_bmj3" #FUN-D30087 add
                 ELSE                              #FUN-D30087 add
                    LET g_qryparam.form = "q_mse"
                 END IF                            #FUN-D30087 add
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.arg1 = g_pml[l_ac].pml04  #FUN-D30087 add
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml123
                 NEXT FIELD pml123
            WHEN INFIELD(pml48) #供應商
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form ="q_pml48"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml48
                 NEXT FIELD pml48
            WHEN INFIELD(pml191)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_geu"
                 LET g_qryparam.state = "c"
                 LET g_qryparam.arg1 = '4'
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO pml191
                 NEXT FIELD pml191
                 END CASE

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

      ON ACTION qbe_select
		 CALL cl_qbe_list() RETURNING lc_qbe_sn
	     CALL cl_qbe_display_condition(lc_qbe_sn)

      ON ACTION accept
         EXIT DIALOG

      ON ACTION EXIT
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT DIALOG
      END DIALOG
#FUN-B90101--add--end----
#FUN-B90101--mark--begin--
#
#      CONSTRUCT BY NAME g_wc ON pmk46,pmk01,pmk03,pmk04,pmk48,pmk02,pmk09,pmk05,pmk49,pmk18,   #No.FUN-870007  #FUN-A50071 add pmk49
#                                pmkcond,pmkconu,pmkcont,pmk47,pmkplant,            #No.FUN-870007
#                                pmk20,pmk41,pmk10,pmk11,pmk12,pmk13,pmk21,
#                                pmk43,pmk22,pmk42,pmk45,pmkmksg,pmksign,pmk25,
#                                pmk14,pmk15,pmk16,pmk17,pmk30,
#                                pmkud01,pmkud02,pmkud03,pmkud04,pmkud05,
#                                pmkud06,pmkud07,pmkud08,pmkud09,pmkud10,
#                                pmkud11,pmkud12,pmkud13,pmkud14,pmkud15,
#                                pmkuser,pmkgrup,pmkmodu,pmkdate,pmkacti,pmkcrat    #No.FUN-870007-add-pmkcrat
#                               ,pmkoriu,pmkorig                           #TQC-A30041 ADD
#
#         BEFORE CONSTRUCT
#            CALL cl_qbe_init()
#
#         ON ACTION CONTROLP
#            CASE
#               WHEN INFIELD(pmk01) #請購單號
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pmk3"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk01
#                    NEXT FIELD pmk01
#
#               WHEN INFIELD(pmk05)  #專案代號
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.state= "c"
#                    LET g_qryparam.form ="q_pja2"
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk05
#                    NEXT FIELD pmk05
#               WHEN INFIELD(pmk09) #查詢廠商檔
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pmc1"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk09
#                    NEXT FIELD pmk09
#               WHEN INFIELD(pmk10)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.state = "c"
#                  LET g_qryparam.form = "q_pme"
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmk10
#               WHEN INFIELD(pmk11)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.state = "c"
#                  LET g_qryparam.form = "q_pme"
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmk11
#               WHEN INFIELD(pmk12) #請購員
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gen"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk12
#                    NEXT FIELD pmk12
#               WHEN INFIELD(pmk13) #請購Dept
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gem"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk13
#                    NEXT FIELD pmk13
#               WHEN INFIELD(pmk14) #收貨Dept
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gem"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk14
#                    NEXT FIELD pmk14
#               WHEN INFIELD(pmk15) #確認人
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gen"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk15
#                    NEXT FIELD pmk15
#               WHEN INFIELD(pmk16) #運送方式
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_ged"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk16
#                    NEXT FIELD pmk16
#               WHEN INFIELD(pmk17) #廠商資料
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pmc1"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk17
#                    NEXT FIELD pmk17
#               WHEN INFIELD(pmk20) #查詢付款條件資料檔(pma_file)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pma"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk20
#                    NEXT FIELD pmk20
#               WHEN INFIELD(pmk21) #查詢稅別資料檔(gec_file)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gec"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk21
#                    NEXT FIELD pmk21
#               WHEN INFIELD(pmk22) #查詢幣別資料檔
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_azi"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk22
#                    NEXT FIELD pmk22
#               WHEN INFIELD(pmk41) #價格條件
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pnz01" #FUN-930113 oah-->pnz01
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk41
#                    NEXT FIELD pmk41
#               WHEN INFIELD(pmkconu) #確認人員
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_pmkconu"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmkconu
#                    NEXT FIELD pmkconu
#               WHEN INFIELD(pmk47) #取貨機構
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_azp"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmk47
#                    NEXT FIELD pmk47
#               WHEN INFIELD(pmkplant) #機構別
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_azp"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pmkplant
#                    NEXT FIELD pmkplant
#               WHEN INFIELD(pmkud02)
#                  CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmkud02
#                  NEXT FIELD pmkud02
#               WHEN INFIELD(pmkud03)
#                  CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmkud03
#                  NEXT FIELD pmkud03
#               WHEN INFIELD(pmkud04)
#                  CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmkud04
#                  NEXT FIELD pmkud04
#               WHEN INFIELD(pmkud05)
#                  CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmkud05
#                  NEXT FIELD pmkud05
#               WHEN INFIELD(pmkud06)
#                  CALL cl_dynamic_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmkud06
#                  NEXT FIELD pmkud06
#               OTHERWISE EXIT CASE
#            END CASE
#
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE CONSTRUCT
#
#         ON ACTION about         #MOD-4C0121
#            CALL cl_about()      #MOD-4C0121
#
#         ON ACTION help          #MOD-4C0121
#            CALL cl_show_help()  #MOD-4C0121
#
#         ON ACTION controlg      #MOD-4C0121
#            CALL cl_cmdask()     #MOD-4C0121
#
#		#No.FUN-580031 --start--     HCN
#                 ON ACTION qbe_select
#		   CALL cl_qbe_list() RETURNING lc_qbe_sn
#		   CALL cl_qbe_display_condition(lc_qbe_sn)
#		#No.FUN-580031 --end--       HCN
#      END CONSTRUCT
#
#      IF INT_FLAG THEN
#         LET INT_FLAG=0
#         RETURN
#      END IF
#
#       CONSTRUCT g_wc2 ON pml02,pml24,pml25,pml47,pml04,pml041,pml07,        #No.FUN-870007 #CHI-A80006 mod pml2->pml24
#                         pml48,pml49,pml50,pml51,pml52,pml53,pml54,pml20,    #No.FUN-870007
#                         pml83,pml84,pml85,pml80,pml81,pml82,pml86,pml87,
#                         pml21,pml35,pml34,pml33,pml919,pml55,pml41,pml190,pml191,pml192,  #No.FUN-630040   #No.TQC-640132 #No.FUN-870007-add-pml55 #FUN-A80150 pml919
#                         pml92,pml93,                  #FUN-9A0065 add pml92,pml93
#                         pml12,pml121,pml122,
#                         pml67,pml90,pml40,pml401,pml31,p31t,        #FUN-810045 add  #No.FUN-830161
#                         pml930,pml06,pml16,pml56,pml123                   #FUN-570106  #FUN-670051 #FUN-950088 add pml123 #No.FUN-870007-add-pml56 #FUN-990080 add pml16
#                         ,pml91          #No.FUN-920183 add
#                         ,pml05          #No.FUN-B80167 add
#&ifdef SLK
#                         ,pmlislk01    #No.FUN-810017
#&endif
#
#           ,pmlud01,pmlud02,pmlud03,pmlud04,pmlud05,
#           pmlud06,pmlud07,pmlud08,pmlud09,pmlud10,
#           pmlud11,pmlud12,pmlud13,pmlud14,pmlud15
#           FROM s_pml[1].pml02,
#                s_pml[1].pml24,s_pml[1].pml25,   #NO.FUN-670007 add
#                s_pml[1].pml47,                  #No.FUN-870007
#                s_pml[1].pml04,
#                s_pml[1].pml041,s_pml[1].pml07,
#                s_pml[1].pml48,s_pml[1].pml49,   #No.FUN-870007
#                s_pml[1].pml50,s_pml[1].pml51,   #No.FUN-870007
#                s_pml[1].pml52,s_pml[1].pml53,   #No.FUN-870007
#                s_pml[1].pml54,                  #No.FUN-870007
#                s_pml[1].pml20, s_pml[1].pml83,
#                s_pml[1].pml84, s_pml[1].pml85,
#                s_pml[1].pml80, s_pml[1].pml81,
#                s_pml[1].pml82, s_pml[1].pml86,
#                s_pml[1].pml87, s_pml[1].pml21,
#                s_pml[1].pml35, s_pml[1].pml34,   #FUN-570106   #No.TQC-640132
#                s_pml[1].pml33, s_pml[1].pml919,s_pml[1].pml55,s_pml[1].pml41,   #FUN-570106   #No.TQC-640132 #No.FUN-870007-add-pml55 #FUN-A80150 add pml919
#                s_pml[1].pml190,s_pml[1].pml191,s_pml[1].pml192,  #No.FUN-630040
#                s_pml[1].pml92,s_pml[1].pmL93,  #FUN-9A0065 add pml92,pml93
#                s_pml[1].pml12, s_pml[1].pml121,
#                s_pml[1].pml122,
#                s_pml[1].pml67,s_pml[1].pml90,
#                s_pml[1].pml40,s_pml[1].pml401,
#                s_pml[1].pml31,s_pml[1].pml31t,                 #No.FUN-830161
#                s_pml[1].pml930,s_pml[1].pml06,  #FUN-670051
#                s_pml[1].pml16, #FUN-990080
#                s_pml[1].pml56,                  #No.FUN-870007
#                s_pml[1].pml123    #FUN-950088 add
#               ,s_pml[1].pml91                 #No.FUN-920183 add
#               ,s_pml[1].pml05                 #No.FUN-B80167 add
#&ifdef SLK
#                ,s_pml[1].pmlislk01                             #No.FUN-810017
#&endif
#                ,s_pml[1].pmlud01,s_pml[1].pmlud02,s_pml[1].pmlud03,s_pml[1].pmlud04,s_pml[1].pmlud05,
#                s_pml[1].pmlud06,s_pml[1].pmlud07,s_pml[1].pmlud08,s_pml[1].pmlud09,s_pml[1].pmlud10,
#                s_pml[1].pmlud11,s_pml[1].pmlud12,s_pml[1].pmlud13,s_pml[1].pmlud14,s_pml[1].pmlud15
#
#  	        #No.FUN-580031 --start--     HCN
#		BEFORE CONSTRUCT
#		   CALL cl_qbe_display_condition(lc_qbe_sn)
#		#No.FUN-580031 --end--       HCN
#         ON ACTION CONTROLP
#            CASE
#               WHEN INFIELD(pml04) #料件編號
##FUN-AA0059---------mod------------str-----------------
##                    CALL cl_init_qry_var()
##                    LET g_qryparam.form = "q_ima"
##                    LET g_qryparam.state = 'c'
##                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
##FUN-AA0059---------mod------------end-----------------
#                    DISPLAY g_qryparam.multiret TO pml04
#                    NEXT FIELD pml04
#               WHEN INFIELD(pml07) #採購單位
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gfe"
#                    LET g_qryparam.state = 'c'
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pml07
#                    NEXT FIELD pml07
#               WHEN INFIELD(pml83)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.state = "c"
#                    LET g_qryparam.form ="q_gfe"
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pml83
#                    NEXT FIELD pml83
#
#               WHEN INFIELD(pml80)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.state = "c"
#                    LET g_qryparam.form ="q_gfe"
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pml80
#                    NEXT FIELD pml80
#
#               WHEN INFIELD(pml86)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.state = "c"
#                    LET g_qryparam.form ="q_gfe"
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pml86
#                    NEXT FIELD pml86
#               WHEN INFIELD(pml12)  #專案代號
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form ="q_pja2"
#                  LET g_qryparam.state = "c"   #多選
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml12
#                  NEXT FIELD pml12
#               WHEN INFIELD(pml121) #WBS
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form ="q_pjb4"
#                  LET g_qryparam.state = "c"   #多選
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml121
#                  NEXT FIELD pml121
#               WHEN INFIELD(pml122) #活動
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form ="q_pjk3"
#                  LET g_qryparam.state = "c"   #多選
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml122
#                  NEXT FIELD pml122
#               WHEN INFIELD(pml67)  #部門
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form = "q_gem"
#                  LET g_qryparam.state = "c"   #多選
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml67
#                  NEXT FIELD pml67
#               WHEN INFIELD(pml90) #費用原因
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form ="q_azf01a"    #No.FUN-930104
#                  LET g_qryparam.state = "c"   #多選
#                  LET g_qryparam.arg1 = '7'          #No.FUN-930104
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml90
#                  NEXT FIELD pml90
#               WHEN INFIELD(pml40)  #科目
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form = "q_aag"
#                  LET g_qryparam.state = "c"   #多選
#                  LET g_qryparam.arg1 = g_bookno1   #No.FUN-730033
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml40
#                  NEXT FIELD pml40
#               WHEN INFIELD(pml401) #科目二
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form = "q_aag"
#                  LET g_qryparam.state = "c"   #多選
#                  LET g_qryparam.arg1 = g_bookno2   #No.FUN-730033
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml40
#                  NEXT FIELD pml401
#               WHEN INFIELD(pml930)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form  = "q_gem4"
#                  LET g_qryparam.state = "c"   #多選
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml930
#                  NEXT FIELD pml930
#               WHEN INFIELD(pml123)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form = "q_mse"
#                  LET g_qryparam.state = 'c'
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pml123
#                  NEXT FIELD pml123
#               WHEN INFIELD(pml48) #供應商
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.state = "c"
#                    LET g_qryparam.form ="q_pml48"
#                    CALL cl_create_qry() RETURNING g_qryparam.multiret
#                    DISPLAY g_qryparam.multiret TO pml48
#                    NEXT FIELD pml48
#&ifdef SLK
#               WHEN INFIELD(pmlislk01)
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form  = "q_skd1"
#                  LET g_qryparam.state = "c"
#                  CALL cl_create_qry() RETURNING g_qryparam.multiret
#                  DISPLAY g_qryparam.multiret TO pmlislk01
#                  NEXT FIELD pmlislk01
#&endif
#               WHEN INFIELD(pml191)
#                 CALL cl_init_qry_var()
#                 LET g_qryparam.form = "q_geu"
#                 LET g_qryparam.state = "c"
#                 LET g_qryparam.arg1 = '4'
#                 CALL cl_create_qry() RETURNING g_qryparam.multiret
#                 DISPLAY g_qryparam.multiret TO pml191
#                 NEXT FIELD pml191
#               OTHERWISE EXIT CASE
#            END CASE
#
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE CONSTRUCT
#
#         ON ACTION about         #MOD-4C0121
#            CALL cl_about()      #MOD-4C0121
#
#         ON ACTION help          #MOD-4C0121
#            CALL cl_show_help()  #MOD-4C0121
#
#         ON ACTION controlg      #MOD-4C0121
#            CALL cl_cmdask()     #MOD-4C0121
#
#		#No.FUN-580031 --start--     HCN
#                    ON ACTION qbe_save
#		       CALL cl_qbe_save()
#		#No.FUN-580031 --end--       HCN
#      END CONSTRUCT
#
#FUN-B90101--mark--end--
      IF INT_FLAG THEN
         RETURN
      END IF
   END IF

   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('pmkuser', 'pmkgrup')

   IF g_argv2 = '1' THEN      #已核淮
      LET g_wc = g_wc clipped," AND pmk25 IN ('1') "
   END IF

   IF cl_null(g_argv3) THEN    #97-05-02
      LET g_wc = g_wc clipped," AND pmk02 != 'SUB' "
   ELSE
      LET g_wc = g_wc clipped," AND pmk02 = 'SUB' "
   END IF

   IF g_wc2=' 1=1 ' OR cl_null(g_wc2) THEN
      LET g_sql="SELECT UNIQUE pmk01 FROM pmk_file ",
                " WHERE ",g_wc CLIPPED, " ORDER BY pmk01"
#FUN-B90101--add--begin--
#FUN-B90101--add--end---
   ELSE
      LET g_sql="SELECT UNIQUE pmk01 FROM pmk_file,pml_file ",
                " WHERE pmk01=pml01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
                " ORDER BY pmk01"
#FUN-B90101--add--begin--
#FUN-B90101--add--end---
   END IF

   PREPARE t420_prepare FROM g_sql           # RUNTIME 編譯
   DECLARE t420_cs SCROLL CURSOR WITH HOLD FOR t420_prepare
   DECLARE t420_fill_cs CURSOR FOR t420_prepare     #FUN-CB0014 add

   IF g_wc2=' 1=1' OR cl_null(g_wc2) THEN
      LET g_sql= "SELECT COUNT(*) FROM pmk_file WHERE ",g_wc CLIPPED
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
   ELSE
      LET g_sql= "SELECT COUNT(DISTINCT pmk01) FROM pmk_file,pml_file",
                 " WHERE pmk01=pml01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
   END IF

   PREPARE t420_precount FROM g_sql

   DECLARE t420_count CURSOR FOR t420_precount

END FUNCTION

FUNCTION t420_b_askkey()
   DEFINE l_ima926 LIKE ima_file.ima926  #FUN-D30087 add

   CONSTRUCT g_wc2 ON pml02 ,pml24,pml25,
                      pml04 ,pml041 ,pml20 ,  #NO.FUN-670007 ADD pml24/pml25
                      pml83,pml84,pml85,pml80,pml81,pml82,pml86,pml87,
                      pml35,pml34,pml33,pml919,pml06,pml41,   #FUN-570106   #No.TQC-640132   #FUN-A80150 add pml919
                      pml190,pml191,pml192,     #No.FUN-630040
                      pml92,pml93,       #FUN-9A0065 add pml92,pml93
                      pml12,pml121,pml122,
                      pml67,pml90,pml40,pml401,pml31,pml31t,pml123  #FUN-810045  #No.FUN-830161 #FUN-950088 add apml123
                 FROM s_pml[1].pml02,
                      s_pml[1].pml24,s_pml[1].pml25,   #NO.FUN-670007
                      s_pml[1].pml04,
                      s_pml[1].pml041,s_pml[1].pml20,
                      s_pml[1].pml83, s_pml[1].pml84,
                      s_pml[1].pml85, s_pml[1].pml80,
                      s_pml[1].pml81, s_pml[1].pml82,
                      s_pml[1].pml86, s_pml[1].pml87,
                      s_pml[1].pml35, s_pml[1].pml34,   #FUN-570106   #No.TQC-640132
                      s_pml[1].pml33, s_pml[1].pml919,s_pml[1].pml06,   #FUN-570106   #No.TQC-640132  #FUN-A80150 add pml919
                      s_pml[1].pml41,
                      s_pml[1].pml190,s_pml[1].pml191,s_pml[1].pml192,   #No.FUN-630040
                      s_pml[1].pml92,s_pml[1].pml93,  #FUN-9A0065 add pml92,pml93
                      s_pml[1].pml12,
                      s_pml[1].pml121,s_pml[1].pml122,
                      s_pml[1].pml67,s_pml[1].pml90,
                      s_pml[1].pml40,s_pml[1].pml401,
                      s_pml[1].pml31,s_pml[1].pml31t,s_pml[1].pml23  #No.FUN-830161 #FUN-950088 add pml123
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()

          ON ACTION CONTROLP
             CASE
                WHEN INFIELD(pml83)
                     CALL cl_init_qry_var()
                     LET g_qryparam.state = "c"
                     LET g_qryparam.form ="q_gfe"
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO pml83
                     NEXT FIELD pml83

                WHEN INFIELD(pml80)
                     CALL cl_init_qry_var()
                     LET g_qryparam.state = "c"
                     LET g_qryparam.form ="q_gfe"
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO pml80
                     NEXT FIELD pml80

                WHEN INFIELD(pml86)
                     CALL cl_init_qry_var()
                     LET g_qryparam.state = "c"
                     LET g_qryparam.form ="q_gfe"
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO pml86
                     NEXT FIELD pml86

                WHEN INFIELD(pml122) #活動
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_pjk3"
                   LET g_qryparam.state = "c"   #多選
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO pml122
                   NEXT FIELD pml122
                WHEN INFIELD(pml67)  #部門
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gem"
                   LET g_qryparam.state = "c"   #多選
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO pml67
                   NEXT FIELD pml67
                WHEN INFIELD(pml90) #費用原因
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_azf01a"    #No.FUN-930104
                   LET g_qryparam.state = "c"   #多選
                   LET g_qryparam.arg1 = '7'          #No.FUN-930104
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO pml90
                   NEXT FIELD pml90
                WHEN INFIELD(pml40)  #科目
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_aag"
                   LET g_qryparam.state = "c"   #多選
                   LET g_qryparam.arg1 = g_bookno1   #No.FUN-730033
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO pml40
                   NEXT FIELD pml40
                WHEN INFIELD(pml401) #科目二
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_aag"
                   LET g_qryparam.state = "c"   #多選
                   LET g_qryparam.arg1 = g_bookno2   #No.FUN-730033
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO pml40
                   NEXT FIELD pml401
                WHEN INFIELD(pml123)
                   LET l_ima926 = 'N'                #FUN-D30087 add
                   SELECT ima926 INTO l_ima926 FROM ima_file  #FUN-D30087 add
                    WHERE ima01 = g_pml[l_ac].pml04           #FUN-D30087 add
                   CALL cl_init_qry_var()
                   IF l_ima926 = 'Y' THEN            #FUN-D30087 add
                      LET g_qryparam.form = "q_bmj3" #FUN-D30087 add
                   ELSE                              #FUN-D30087 add
                      LET g_qryparam.form = "q_mse"
                   END IF                            #FUN-D30087 add
                   LET g_qryparam.arg1 = g_pml[l_ac].pml04    #FUN-D30087 add
                   LET g_qryparam.default1 = g_pml[l_ac].pml123
                   CALL cl_create_qry() RETURNING g_pml[l_ac].pml123
                   DISPLAY BY NAME g_pml[l_ac].pml123
                   NEXT FIELD pml123
                OTHERWISE EXIT CASE
             END CASE
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
   END CONSTRUCT
END FUNCTION

FUNCTION t420_menu()
   DEFINE l_creator    LIKE type_file.chr1      #No.FUN-680136 VARCHAR(1)   #「不准」時是否退回填表人 #FUN-580011
   DEFINE l_flowuser   LIKE type_file.chr1      #No.FUN-680136 VARCHAR(1)   # 是否有指定加簽人員      #FUN-580011
   DEFINE l_partnum    STRING   #GPM料號
   DEFINE l_supplierid STRING   #GPM廠商
   DEFINE l_status     LIKE type_file.num10  #GPM傳回值
   DEFINE l_cnt        LIKE type_file.num5   #TQC-760044

   LET l_flowuser = "N"                  #FUN-580011

   WHILE TRUE
      LET g_chr='@'
   IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN   #FUN-CB0014 add
      CALL t420_bp("G")
   ELSE
         CALL t420_list_fill()
         CALL t420_bp3("G")
         IF NOT cl_null(g_action_choice) AND l_ac4>0 THEN #將清單的資料回傳到主畫面
            SELECT pmk_file.* INTO g_pmk.*
              FROM pmk_file
             WHERE pmk01=g_pmk_l[l_ac4].pmk01
         END IF
         IF g_action_choice!= "" THEN
            LET g_action_flag = "page_main"
            LET l_ac4 = ARR_CURR()
            LET g_jump = l_ac4
            LET mi_no_ask = TRUE
            IF g_rec_b4 >0 THEN
               CALL t420_fetch('/')
            END IF
            CALL cl_set_comp_visible("page_list", FALSE)
            CALL cl_set_comp_visible("info", FALSE)
            CALL ui.interface.refresh()
            CALL cl_set_comp_visible("page_list", TRUE)
            CALL cl_set_comp_visible("info", TRUE)
          END IF
      END IF
      #FUN-CB0014---add---end--
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t420_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t420_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t420_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t420_u()
            END IF
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL t420_copy()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               #CHI-D20006 -- add start --
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM pml_file
                WHERE pml01 = g_pmk.pmk01
               IF l_cnt > 0 THEN
               #CHI-D20006 -- add end --
                  CALL t420_b()
               #CHI-D20006 -- add start --
               ELSE
                  CALL t420_g_b()
               END IF
               #CHI-D20006 -- add end --
               CALL t420_sign('b')
               ELSE                           #TQC-D40025
                  LET g_action_choice = ""    #TQC-D40025
            END IF
          # LET g_action_choice = ""    #TQC-D40025
         WHEN "output"
            CALL t420_out()
         WHEN "help"
            CALL cl_show_help()
         WHEN "EXIT"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()

         WHEN "mod_date"
            CALL t420_mod()

       #@WHEN "MRP查詢"
         WHEN "query_mrp"
            CALL t420_k()
       #@WHEN "採購狀況查詢"
         WHEN "qry_po_status"
            LET g_cmd = "apmq540 ","'",g_pmk.pmk01,"'"
            CALL cl_cmdrun(g_cmd)

          WHEN "approval_status"               # MOD-4C0041
            IF cl_chk_act_auth() THEN  #DISPLAY ONLY
               IF aws_condition2() THEN                #FUN-550038
                    CALL aws_efstat2()     #MOD-560007
               END IF
            END IF

         WHEN "easyflow_approval"     #FUN-550038
            IF cl_chk_act_auth() THEN
              #FUN-C20026 add str---
               SELECT * INTO g_pmk.* FROM pmk_file
                WHERE pmk01 = g_pmk.pmk01
               CALL t420_show()
               CALL t420_b_fill(' 1=1',' 1=1')
              #FUN-C20026 add end---
               CALL t420_ef()
               CALL t420_show()  #FUN-C20026 add
            END IF

       #FUN-B30082----ADD----START------
       #@WHEN "變更狀況"
         WHEN "modify_status"
            IF cl_null(g_pmk.pmk01) THEN
               CALL cl_err('','-400',1)
            ELSE
               LET g_cmd = "apmt900 '",g_pmk.pmk01,"'"
               CALL cl_cmdrun_wait(g_cmd)
            END IF
       #FUN-B30082----ADD----END--------
       #@WHEN "備註"
         WHEN "memo"
            IF cl_chk_act_auth() THEN
               IF g_pmk.pmk01 IS NOT NULL AND g_pmk.pmk01 != ' '
                  AND g_pmk.pmk18 !='X' THEN
                  LET g_cmd = "apmt403 ",'0 ',"'",g_pmk.pmk01,"'" CLIPPED
                  CALL cl_cmdrun_wait(g_cmd)  #FUN-660216 add
               END IF
            END IF
       #@WHEN "特別說明"
         WHEN "special_description"
            IF cl_chk_act_auth() THEN   #CHI-9C0002
               IF g_pmk.pmk01 IS NOT NULL AND g_pmk.pmk01 != ' '
                  AND g_pmk.pmk18 !='X' THEN
                  LET g_cmd = "apmt402 ",'0 ',"'",g_pmk.pmk01,"'",' ','0'
                  CALL cl_cmdrun_wait(g_cmd)  #FUN-660216 add
               END IF
            END IF   #CHI-9C0002
       #@WHEN "確認"
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
               CALL t420sub_y_chk(g_pmk.pmk01)          #CALL 原確認的 check 段
               IF g_success = "Y" THEN
                   CALL t420sub_y_upd(g_pmk.pmk01,g_action_choice)      #CALL 原確認的 update 段
                   IF g_success = 'Y' THEN
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt
                       FROM pml_file
                      WHERE pml01 = g_pmk.pmk01
                        AND pml190 = 'N'
                     IF l_cnt > 0 THEN
                      CALL s_auto_gen_doc('apmt420',g_pmk.pmk01,'')  #TQC-730022
                     END IF
#                     IF g_success = 'Y' THEN #TQC-AB0397 add  #TQC-B10044 mark
#                       IF g_azw.azw04='2' THEN                #FUN-CC0057 mark
#                          CALL t420_transfer()                #FUN-CC0057 mark
#                       END IF                                 #FUN-CC0057 mark
#                     END IF #TQC-AB0397 add                   #TQC-B10044 mark
                   END IF
                   CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*  #FUN-730012 重新讀取g_pmk
                   CALL t420_show()                                 #FUN-730012
               END IF
            END IF
       #@WHEN "取消確認"
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t420_z()
              #MOD-B90094------------
               CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*
               CALL t420_show()
              #MOD-B90094-end------
            END IF
       #@WHEN "作廢"
         WHEN "void"
            IF cl_chk_act_auth() THEN
               #CALL t420_x() #FUN-D20025 mark
               CALL t420_x(1) #FUN-D20025 add
              #MOD-B90094------------
               CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*
               CALL t420_show()
              #MOD-B90094-end------
            END IF
#FUN-D20025 add
       #@WHEN "取消作廢"
         WHEN "undo_void"
            IF cl_chk_act_auth() THEN
               CALL t420_x(2)
               CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*
               CALL t420_show()
            END IF
#FUN-D20025 add
         WHEN "exporttoexcel"     #FUN-4B0025
            LET w = ui.Window.getCurrent()   #FUN-CB0014 add
            LET f = w.getForm()              #FUN-CB0014 add
            IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN   #FUN-CB0014 add
               IF cl_chk_act_auth() THEN
                  LET page = f.FindNode("Page","page_main")  #FUN-CB0014 add
#                 CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_pml),'','')   #FUN-CB0014 mark
                  CALL cl_export_to_excel(page,base.TypeInfo.create(g_pml),'','')                         #FUN-CB0014 add
               END IF
            #FUN-CB0014---add---str---
            END IF
            IF g_action_flag = "page_list" THEN
               LET page = f.FindNode("Page","page_list")
               IF cl_chk_act_auth() THEN
                  CALL cl_export_to_excel(page,base.TypeInfo.create(g_pmk_l),'','')
               END IF
            END IF
            #FUN-CB0014---add---end---
         #@WHEN "准"
         WHEN "agree"
              IF g_laststage = "Y" AND l_flowuser = "N" THEN  #最後一關並且沒有加簽人員
                 CALL t420sub_y_upd(g_pmk.pmk01,g_action_choice)      #CALL 原確認的 update 段
                 CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*  #FUN-730012 重新讀取g_pmk #CHI-740014
                 CALL t420_show()                                 #FUN-730012 #CHI-740014
              ELSE
                 LET g_success = "Y"
                 IF NOT aws_efapp_formapproval() THEN #執行 EF 簽核
                    LET g_success = "N"
                 END IF
              END IF
              IF g_success = 'Y' THEN
                 IF cl_confirm('aws-081') THEN    #詢問是否繼續下一筆資料的簽核
                    IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                       LET l_flowuser = 'N'
                       LET g_argv1 = aws_efapp_wsk(1)   #取得單號
                       IF NOT cl_null(g_argv1) THEN     #自動 query 帶出資料
                             CALL t420_q()
                             #傳入簽核模式時不應執行的 action 清單
                             #CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, confirm, undo_confirm,easyflow_approval, aps_related_data")  #TQC-740281 #FUN-D20025 mark
                             CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, undo_void, confirm, undo_confirm,easyflow_approval, aps_related_data")  #FUN-D20025 add
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
             IF (l_creator := aws_efapp_backflow()) IS NOT NULL THEN #退回關卡
                IF aws_efapp_formapproval() THEN   #執行 EF 簽核
                   IF l_creator = "Y" THEN       #當退回填表人時
                      LET g_pmk.pmk25 = 'R'        #顯示狀態碼為 'R' 送簽退回
                      DISPLAY BY NAME g_pmk.pmk25
                   END IF
                   IF cl_confirm('aws-081') THEN #詢問是否繼續下一筆資料的簽核
                      IF aws_efapp_getnextforminfo() THEN   #取得下一筆簽核單號
                          LET l_flowuser = 'N'
                          LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                          IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                                CALL t420_q()
                                #傳入簽核模式時不應執行的 action 清單
                               # CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, confirm, undo_confirm,easyflow_approval, aps_related_data")  #TQC-740281 #FUN-D20025 mark
                                CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query, locale, void, undo_void,confirm, undo_confirm,easyflow_approval, aps_related_data")  #FUN-D20025 add
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

         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_pmk.pmk01 IS NOT NULL THEN
                 LET g_doc.column1 = "pmk01"
                 LET g_doc.value1 = g_pmk.pmk01
                 CALL cl_doc()
               END IF
         END IF

         #@WHEN GPM規範顯示
         WHEN "gpm_show"
              LET l_partnum = ''
              LET l_supplierid = ''
              IF l_ac > 0 THEN LET l_partnum = g_pml[l_ac].pml04 END IF
              LET l_supplierid = g_pmk.pmk09
              CALL aws_gpmcli(l_partnum,l_supplierid)
                RETURNING l_status

         #@WHEN GPM規範查詢
         WHEN "gpm_query"
              LET l_partnum = ''
              LET l_supplierid = ''
              IF l_ac > 0 THEN LET l_partnum = g_pml[l_ac].pml04 END IF
              LET l_supplierid = g_pmk.pmk09
              CALL aws_gpmcli(l_partnum,l_supplierid)
                RETURNING l_status

      #APS相關資料
      WHEN "aps_related_data"
            IF cl_chk_act_auth() THEN
               CALL t420_aps()
            END IF
      WHEN "e_proc_require"
         IF cl_chk_act_auth() THEN
            CALL t420_epr()
         END IF
#FUN-A60035 ---MARK BEGIN
#&ifdef SLK
##FUN-A50054---begin add
#     WHEN "style_detail"
#        IF l_ac>0 THEN
#           CALL s_detail(g_prog,g_pmk.pmk01,g_pml[l_ac].pml02,g_pml[l_ac].pml04,'Y')
#           RETURNING g_pml[l_ac].pml20
#        END IF
##FUN-A50054 --End
#&endif
#FUN-A60035 ---MARK END
      END CASE
   END WHILE

   CLOSE t420_cs

END FUNCTION

FUNCTION t420_k()
   DEFINE l_pml02      LIKE pml_file.pml02    #No.FUN-680136 INTEGER
   DEFINE l_ver        LIKE mss_file.mss_v   #MOD-8A0276
   DEFINE l_part       LIKE pml_file.pml04    #No.MOD-490217
   DEFINE l_pml41      LIKE pml_file.pml41   #MOD-8A0276
   DEFINE l_str        STRING   #MOD-8A0276
   DEFINE l_cnt        LIKE type_file.num5   #MOD-8A0276

   #No.TQC-A90101  --Begin
   CALL cl_getmsg('apm-169',g_lang) RETURNING g_msg

   LET INT_FLAG = 0
   PROMPT g_msg CLIPPED FOR l_pml02
   ON IDLE g_idle_seconds
     CALL cl_on_idle()

   ON ACTION about
      CALL cl_about()

   ON ACTION help
      CALL cl_show_help()

   ON ACTION controlg
      CALL cl_cmdask()

   END PROMPT
   #CASE g_lang
   #  WHEN '0'
   #     LET INT_FLAG = 0  ######add for prompt bug
   #     PROMPT "請輸入查詢項次:" FOR l_pml02
   #     ON IDLE g_idle_seconds
   #       CALL cl_on_idle()

   #     ON ACTION about
   #        CALL cl_about()

   #     ON ACTION help
   #        CALL cl_show_help()

   #     ON ACTION controlg
   #        CALL cl_cmdask()

   #     END PROMPT
   #  WHEN '2'
   #         LET INT_FLAG = 0  ######add for prompt bug
   #    PROMPT "請輸入查詢項次:" FOR l_pml02
   #     ON IDLE g_idle_seconds
   #       CALL cl_on_idle()

   #     ON ACTION about
   #        CALL cl_about()

   #     ON ACTION help
   #        CALL cl_show_help()

   #     ON ACTION controlg
   #        CALL cl_cmdask()

   #     END PROMPT
   #  OTHERWISE
   #         LET INT_FLAG = 0  ######add for prompt bug
   #    PROMPT "Enter Qry Line #:" FOR l_pml02
   #       ON IDLE g_idle_seconds
   #          CALL cl_on_idle()

   #   ON ACTION about         #MOD-4C0121
   #      CALL cl_about()      #MOD-4C0121

   #   ON ACTION help          #MOD-4C0121
   #      CALL cl_show_help()  #MOD-4C0121

   #   ON ACTION controlg      #MOD-4C0121
   #      CALL cl_cmdask()     #MOD-4C0121


   #    END PROMPT
   #END CASE
   #No.TQC-A90101  --End

   CLOSE WINDOW t420_k_w

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   SELECT pml41,pml04 INTO l_pml41,l_part FROM pml_file    #MOD-8A0276
    WHERE pml01 = g_pmk.pmk01
      AND pml02 = l_pml02

   LET l_str = l_pml41
   LET l_cnt = l_str.getIndexOf('-',1)
   LET l_ver = l_str.subString(1,l_cnt-1)

   LET g_cmd = "amrq500 '",l_ver CLIPPED,"' '",l_part,"'"

   CALL cl_cmdrun(g_cmd)

END FUNCTION

FUNCTION t420_a()
   DEFINE  l_chr       LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
           l_prt       LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
           l_k         LIKE type_file.num5     #No.FUN-680136 SMALLINT
   DEFINE  li_result   LIKE type_file.num5     #No.FUN-680136 SMALLINT
   DEFINE  ls_doc      STRING
   DEFINE  li_inx      LIKE type_file.num10    #No.FUN-680136 INTEGER
   DEFINE l_pmkplant_desc LIKE azp_file.azp02  #No.FUN-870007

   IF s_shut(0) THEN RETURN END IF
   IF g_sma.sma44 MATCHES'[Nn]' THEN           #請購單不可直接輸入
      CALL cl_err(g_sma.sma44,'mfg0033',1)
      RETURN
   END IF
   MESSAGE ""
   CLEAR FORM                                  # 清螢墓欄位內容
   CALL g_pml.clear()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
   INITIALIZE g_pmk.* LIKE pmk_file.*
   INITIALIZE g_pmk_o.* LIKE pmk_file.*
   IF g_ydate IS NULL THEN
       LET g_pmk.pmk01 = NULL
       LET g_pmk.pmk04 = g_today               #請購日期
   ELSE                                        #使用上筆資料值
       LET g_pmk.pmk01 = g_sheet               #單別
       LET g_pmk.pmk04 = g_ydate               #收貨日期
   END IF

   SELECT azn02,azn04 INTO g_pmk.pmk31,g_pmk.pmk32 FROM azn_file
    WHERE azn01 = g_pmk.pmk04
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","azn_file",g_pmk.pmk04,"","mfg0027","","",1)
      LET g_pmk.pmk04 = g_pmk_o.pmk04
      DISPLAY BY NAME g_pmk.pmk04
   END IF
   CALL s_get_bookno(YEAR(g_pmk.pmk04))
        RETURNING g_flag,g_bookno1,g_bookno2

   LET g_pmk01_t = NULL
   IF NOT cl_null(g_argv3) THEN
      LET g_pmk.pmk02 = g_argv3
   ELSE
      LET g_pmk.pmk02 = 'REG'       #單號性質
   END IF
   LET g_pmk.pmk03 = '0'
   LET g_pmk.pmk12 = g_user
   LET g_pmk.pmk13 = g_grup
   CALL t420_peo('d','1',g_pmk.pmk12)
   IF NOT cl_null(g_errno) THEN
      LET g_pmk.pmk12 = ''
   END IF
   CALL t420_dep('d','1',g_pmk.pmk13)
   IF NOT cl_null(g_errno) THEN
      LET g_pmk.pmk13 = ''
   END IF
   LET g_pmk.pmk18 = 'N'
   LET g_pmk.pmk25 = '0'         #開立
   LET g_pmk.pmk27 = g_today
   LET g_pmk.pmk30 = 'Y'
   LET g_pmk.pmk40 = 0           #總金額
   LET g_pmk.pmk401= 0           #總金額
  #LET g_pmk.pmk42 = 1           #匯率 #MOD-B60015 mark
   LET g_pmk.pmk43 = 0           #稅率
   LET g_pmk.pmk45 = 'Y'         #可用
   LET g_pmk.pmkdays = 0         #簽核天數
   LET g_pmk.pmkprno = 0         #列印次數
   LET g_pmk.pmksmax = 0         #己簽順序
   LET g_pmk.pmksseq = 0         #應簽順序
  #LET g_pmk.pmk22 = g_aza.aza17 #本幣幣別  No.B358 #MOD-B60015 mark
   CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg) RETURNING g_sta
   DISPLAY g_sta TO FORMONLY.desc2
   CALL cl_opmsg('a')
   LET g_pmk.pmk05   =''      #No.MOD-590269 Move
   LET g_pmk.pmk12   = g_user               #請購員  #No.MOD-590269 Move
   LET g_pmk.pmkplant = g_plant
   LET g_pmk.pmklegal = g_legal
   LET g_pmk.pmk46 = '1'
   LET g_pmk.pmk47 = g_plant
   LET g_pmk.pmk50 = null    #FUN-CC0057 add
   LET g_pmk.pmk48 = TIME
   IF g_azw.azw04 = '2' THEN
      SELECT azp02 INTO l_pmkplant_desc FROM azp_file
       WHERE azp01 = g_plant
      DISPLAY l_pmkplant_desc,l_pmkplant_desc
           TO pmk47_desc,pmkplant_desc
   END IF
   WHILE TRUE
       LET g_pmk.pmkacti ='Y'                   #有效的資料
       LET g_pmk.pmkuser = g_user
       LET g_pmk.pmkoriu = g_user #FUN-980030
       LET g_pmk.pmkorig = g_grup #FUN-980030
       LET g_data_plant = g_plant #FUN-980030
       LET g_pmk.pmkgrup = g_grup               #使用者所屬群
       LET g_pmk.pmkcrat = g_today           #資料創建日 #No.FUN-870007
       LET g_pmk.pmkplant = g_plant          #FUN-980006 add
       LET g_pmk.pmklegal = g_legal          #FUN-980006 add
       CALL t420_i("a")                      # 各欄位輸入
       IF INT_FLAG THEN                         # 若按了DEL鍵
          LET INT_FLAG = 0
          INITIALIZE g_pmk.* TO NULL
          CALL cl_err('',9001,0)
          CLEAR FORM
          CALL g_pml.clear()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
          EXIT WHILE
       END IF
       IF cl_null(g_pmk.pmk01) THEN                # KEY 不可空白
           CONTINUE WHILE
       END IF
       #輸入後, 若該單據需自動編號, 並且其單號為空白, 則自動賦予單號
       BEGIN WORK  #No:7766
       IF g_smy.smyauno='Y' THEN
       CALL s_auto_assign_no("apm",g_pmk.pmk01,g_pmk.pmk04,"1","pmk_file","pmk01","","","") RETURNING li_result,g_pmk.pmk01
       IF (NOT li_result) THEN
          CONTINUE WHILE
       END IF
       DISPLAY BY NAME g_pmk.pmk01
       END IF
       MESSAGE '' #BugNo:5207
       IF cl_null(g_pmk.pmkmksg) THEN
          LET  g_pmk.pmkmksg = g_smy.smyapr
       END IF
       IF cl_null(g_pmk.pmkmksg) THEN
          LET  g_pmk.pmkmksg = 'N'
       END IF

      IF cl_null(g_pmk.pmk46) THEN
         LET g_pmk.pmk46 = '1'
      END IF

       #MOD-C10008 ----- add start -----
       IF g_smy.smy59 = 'Y' AND cl_null(g_pmk.pmk22) THEN
          LET g_pmk.pmk22 = g_aza.aza17
          LET g_pmk.pmk42 = 1
          DISPLAY BY NAME g_pmk.pmk22,g_pmk.pmk42 #MOD-CA0223 add
       END IF
       #MOD-C10008 ----- add end -----

       INSERT INTO pmk_file VALUES(g_pmk.*)     #DISK WRITE
       LET g_ydate = g_pmk.pmk04                #備份上一筆交貨日期
       CALL s_get_doc_no(g_pmk.pmk01) RETURNING g_sheet
       IF SQLCA.sqlcode THEN
          CALL cl_err3("ins","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660129   #No.FUN-B80088---上移一行調整至回滾事務前---
          ROLLBACK WORK  #No:7766
          CONTINUE WHILE
       ELSE
          COMMIT WORK    #No:7766

          CALL cl_flow_notify(g_pmk.pmk01,'I')
          SELECT pmk01 INTO g_pmk.pmk01 FROM pmk_file
            WHERE pmk01 = g_pmk.pmk01


          #單據別有做預管控管時，才顯示預算相關欄位 預算/部門/科目一
          CALL cl_set_comp_visible("pml67,pml40,pml31,pml31t",g_smy.smy59='Y')          #No.FUN-830161
          #單據別有做預算控管且有使用多套帳時才顯示科目二
          CALL cl_set_comp_visible("pml401",g_smy.smy59='Y' AND g_aza.aza63='Y')

#CHI-D20006 -- mark start #程式段搬移為獨立FUNCTION t420_g_b()--
#          #將prompt改開窗滑鼠選
#&ifdef SLK
#         #FUN-C20006--add--begin--
#          IF g_azw.azw04 = '2' THEN
#             LET g_rec_b = 0
#             LET g_rec_b2= 0
#             LET g_rec_b3= 0
#             CALL g_pml.clear()
#             CALL g_pmlslk.clear()
#             CALL g_imx.clear()
#            #CALL t420_b2()    #FUN-C60098--mark
#             CALL t420_b2_i()  #FUN-C60098--add
#          ELSE
#         #FUN-C20006--add--end--
#             OPEN WINDOW t4206_w WITH FORM "apm/42f/apmt4206"
#                ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
#
#             CALL cl_ui_locale("apmt4206")
#          END IF        #FUN-C20006 add
#&else
#          OPEN WINDOW t4204_w WITH FORM "apm/42f/apmt4204"
#             ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
#
#          CALL cl_ui_locale("apmt4204")
#&endif
#           LET l_chr='1'   #MOD-530423
#          INPUT l_chr WITHOUT DEFAULTS FROM FORMONLY.a
#
#&ifdef SLK
#             AFTER FIELD a
#                IF l_chr NOT MATCHES '[1234]' THEN  #No.FUN-870124 add 4
#                   NEXT FIELD a
#                END IF
#&else
#          AFTER FIELD a
#            IF l_chr NOT MATCHES '[1234]' THEN  #No.FUN-A20039 add 4
#               NEXT FIELD a
#            END IF
#&endif
#
#          ON ACTION CONTROLR
#             CALL cl_show_req_fields()
#
#          ON ACTION CONTROLG
#             CALL cl_cmdask()
#
#          AFTER INPUT
#             IF INT_FLAG THEN                         # 若按了DEL鍵
#                LET INT_FLAG = 0
#                EXIT INPUT
#             END IF
#
#          ON IDLE g_idle_seconds
#             CALL cl_on_idle()
#             CONTINUE INPUT
#
#          ON ACTION about         #MOD-4C0121
#             CALL cl_about()      #MOD-4C0121
#
#          ON ACTION help          #MOD-4C0121
#             CALL cl_show_help()  #MOD-4C0121
#
#          END INPUT
#          IF INT_FLAG THEN
#             LET INT_FLAG=0
#             LET l_chr = '1'
#          END IF
#&ifdef SLK
#          IF g_azw.azw04 <> '2' THEN           #FUN-C20006 add
#             CLOSE WINDOW t4206_w              #結束畫面
#          END IF                               #FUN-C20006 add
#&else
#          CLOSE WINDOW t4204_w                 #結束畫面
#&endif
#
##FUN-C20006--add--begin--
#&ifdef SLK
#          IF g_azw.azw04 <> '2' THEN
#             IF cl_null(l_chr) THEN
#                LET l_chr = '1'
#             END IF
#             LET g_rec_b = 0
#             CASE
#               WHEN l_chr = '1'
#                    CALL g_pml.clear()
#                    CALL t420_b()
#               WHEN l_chr = '2'
#                    CALL p470("G",g_pmk.pmk01)
#                    COMMIT WORK
#                    LET g_wc2=NULL
#                    CALL t420_b_fill(g_wc2,' 1=1')   #FUN-B90101 add 第二個參數，服飾中母單身的條件
#                    LET g_action_choice="detail"
#                    IF cl_chk_act_auth() THEN
#                       CALL t420_b()
#                    ELSE
#                       RETURN
#                    END IF
#               WHEN l_chr='3'
#                    CALL p480(g_pmk.pmk01)
#                    LET g_wc2=NULL
#                    CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
#                    LET g_action_choice="detail"
#                    IF cl_chk_act_auth() THEN
#                       CALL t420_b()
#                    ELSE
#                       RETURN
#                    END IF
#               WHEN l_chr='4'
#                    CALL p490("G",g_pmk.pmk01,'')
#                    LET g_wc2=NULL
#                    CALL t420_b_fill(g_wc2,' 1=1')
#                    LET g_action_choice="detail"
#                    IF cl_chk_act_auth() THEN
#                       CALL t420_b()
#                    ELSE
#                       RETURN
#                    END IF
#               OTHERWISE EXIT CASE
#             END CASE
#             LET g_pmk_t.* = g_pmk.*                # 保存上筆資料
#             LET g_pmk_o.* = g_pmk.*                # 保存上筆資料
#             CALL t420_sign('a')
#          END IF
#       END IF
#&else
##FUN-C20006--add--end--
#       IF cl_null(l_chr) THEN
#          LET l_chr = '1'
#       END IF
#       LET g_rec_b = 0
#       CASE
#         WHEN l_chr = '1'
#              CALL g_pml.clear()
#              CALL t420_b()
#         WHEN l_chr = '2'
#              CALL p470("G",g_pmk.pmk01)
#              COMMIT WORK
#              LET g_wc2=NULL
#              CALL t420_b_fill(g_wc2,' 1=1')   #FUN-B90101 add 第二個參數，服飾中母單身的條件
#              LET g_action_choice="detail"
#              IF cl_chk_act_auth() THEN
#                 CALL t420_b()
#              ELSE
#                 RETURN
#              END IF
#         WHEN l_chr='3'
#              CALL p480(g_pmk.pmk01)
#              LET g_wc2=NULL
#              CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
#              LET g_action_choice="detail"
#              IF cl_chk_act_auth() THEN
#                 CALL t420_b()
#              ELSE
#                 RETURN
#              END IF
##FUN-C20006--mark-begin--
###No.FUN-A70034  --Begin
##&ifdef SLK
##              WHEN l_chr='4'
##                   CALL p490("G",g_pmk.pmk01,'')
##                   LET g_wc2=NULL
##                   CALL t420_b_fill(g_wc2)
##                   LET g_action_choice="detail"
##                   IF cl_chk_act_auth() THEN
##                      CALL t420_b()
##                   ELSE
##                      RETURN
##                   END IF
##&else
##FUN-C20006--mark--end--
#              #FUN-A20039 add --begin--
#               WHEN l_chr='4'
# #FUN-A80016 --modify
#               #    CALL p500("G",g_pmk.pmk01)
#                    CALL p500("G",g_pmk.pmk01,"")    #FUN-A80016
#                    LET g_wc2=NULL
#                    CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
#                    LET g_action_choice="detail"
#                    IF cl_chk_act_auth() THEN
#                       CALL t420_b()
#                    ELSE
#                       RETURN
#                    END IF
#               #FUN-A20039 add --end---
##&endif       #FUN-C20006 mark
##No.FUN-A70034  --End
#               OTHERWISE EXIT CASE
#             END CASE
#            LET g_pmk_t.* = g_pmk.*                # 保存上筆資料
#            LET g_pmk_o.* = g_pmk.*                # 保存上筆資料
#            CALL t420_sign('a')
#         END IF
#&endif
#CHI-D20006 -- mark end --
          CALL t420_g_b()   #CHI-D20006 add
       END IF   #CHI-D20006 add

       IF NOT cl_null(g_pmk.pmk01) AND g_smy.smydmy4='Y'
          AND g_smy.smyapr <> 'Y'                        #確認  #FUN-640184
       THEN
          LET g_action_choice = "insert"      #FUN-640184

         CALL t420sub_y_chk(g_pmk.pmk01)          #CALL 原確認的 check 段
          IF g_success = "Y" THEN
              CALL t420sub_y_upd(g_pmk.pmk01,g_action_choice)      #CALL 原確認的 update 段
              CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*  #FUN-730012 重新讀取g_pmk
              CALL t420_show()                                 #FUN-730012
          END IF
       END IF
       IF g_smy.smyprint='Y' THEN #MOD-570072
         CALL t420_prt()
       END IF #MOD-570072
       EXIT WHILE
   END WHILE
END FUNCTION

FUNCTION t420_i(p_cmd)
    DEFINE
        p_cmd           LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(1)
        l_str           LIKE imd_file.imd01,     #No.FUN-680136 VARCHAR(10)
        l_buf           LIKE type_file.chr1000,  #No.FUN-680136 VARCHAR(30)
        l_cmd           LIKE type_file.chr1000,  #No.FUN-680136 VARCHAR(60)
        l_flag          LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01)
        l_pnz01         LIKE pnz_file.pnz01, #FUN-930113
        l_pmc03         LIKE pmc_file.pmc03,
        l_gen02         LIKE gen_file.gen02,
        l_n,l_cnt       LIKE type_file.num5     #No.FUN-680136 SMALLINT
  DEFINE  li_result     LIKE type_file.num5     #No.FUN-680136 SMALLINT
  DEFINE  l_slip        LIKE smy_file.smyslip   #No.FUN-980038
  DEFINE  l_pmk02       LIKE pmk_file.pmk02     #No.FUN-980038
#CHI-B80082 -- begin --
  DEFINE  l_pml04       LIKE pml_file.pml04
  DEFINE  l_ima915      LIKE ima_file.ima915
#CHI-B80082 -- end --
DEFINE l_ged02          LIKE ged_file.ged02  #TQC-BB0128
DEFINE l_pmk42          LIKE pmk_file.pmk42    #TQC-C30165
DEFINE l_cnt1           LIKE type_file.num5 #FUN-C80045
    DISPLAY BY NAME g_pmk.pmk18,g_pmk.pmkuser,g_pmk.pmkgrup,
                    g_pmk.pmk46,g_pmk.pmk47,g_pmk.pmk50,g_pmk.pmkplant,  #No.FUN-870007   #FUN-CC0047 add pmk50
                    g_pmk.pmkcrat,g_pmk.pmk48,               #No.FUN-870007
                    g_pmk.pmkdate,g_pmk.pmkacti
                   ,g_pmk.pmkoriu,g_pmk.pmkorig             #TQC-A30041 ADD

    CALL cl_set_head_visible("","YES")           #No.FUN-6B0032
    INPUT BY NAME g_pmk.pmkoriu,g_pmk.pmkorig,
         g_pmk.pmk01,g_pmk.pmk03,g_pmk.pmk04,g_pmk.pmk48,g_pmk.pmk02, #No.FUN-870007-add-pmk48
         g_pmk.pmk09,g_pmk.pmk05,g_pmk.pmk49,g_pmk.pmk18,              #FUN-810045 add pmk05  #No.FUN-830161  #FUN-A50071 add pmk49
         g_pmk.pmk20,g_pmk.pmk41,g_pmk.pmk10,g_pmk.pmk11,
         g_pmk.pmk12,g_pmk.pmk13,g_pmk.pmk21,g_pmk.pmk43,
         g_pmk.pmk22,g_pmk.pmk42,
         g_pmk.pmk45,g_pmk.pmkmksg,g_pmk.pmksign,g_pmk.pmk25,
         g_pmk.pmk14,g_pmk.pmk15,g_pmk.pmk16,g_pmk.pmk17,g_pmk.pmk30,
         g_pmk.pmkud01,g_pmk.pmkud02,g_pmk.pmkud03,g_pmk.pmkud04,g_pmk.pmkud05,
         g_pmk.pmkud06,g_pmk.pmkud07,g_pmk.pmkud08,g_pmk.pmkud09,g_pmk.pmkud10,
         g_pmk.pmkud11,g_pmk.pmkud12,g_pmk.pmkud13,g_pmk.pmkud14,g_pmk.pmkud15,
         g_pmk.pmkuser,g_pmk.pmkgrup,g_pmk.pmkmodu,g_pmk.pmkdate,
         g_pmk.pmkacti
        WITHOUT DEFAULTS

        BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL t420_set_entry(p_cmd)
            CALL t420_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE
            CALL cl_set_docno_format("pmk01")

        AFTER FIELD pmk01
            IF NOT cl_null(g_pmk.pmk01) THEN
               LET g_t1=s_get_doc_no(g_pmk.pmk01)
               #FUN-C80045 add sta
               LET l_cnt1 = 0
               SELECT COUNT(*) INTO l_cnt1 FROM  rye_file WHERE rye04 = g_t1 AND ryeacti = 'Y' AND rye01 = 'apm'
               IF l_cnt1 > 0 THEN
                  CALL cl_err(g_t1,'apc1036',0)
                   NEXT FIELD pmk01
               END IF
               #FUN-C80045 add end
               #得到該單別對應的屬性群組
               IF (g_sma.sma120 = 'Y') AND (g_sma.sma907 = 'Y') THEN
                  #讀取smy_file中指定作業對應的默認屬性群組
                  SELECT smy62 INTO lg_smy62 FROM smy_file WHERE smyslip = g_t1
                  #刷新界面顯示
                  CALL t420_refresh_detail()
               ELSE
                  LET lg_smy62 = ''
               END IF

               CALL s_check_no("apm",g_pmk.pmk01,g_pmk01_t,"1","pmk_file","pmk01","") RETURNING li_result,g_pmk.pmk01
               DISPLAY BY NAME g_pmk.pmk01
               IF (NOT li_result) THEN
                  NEXT FIELD pmk01
               END IF
               IF cl_null(g_pmk01_t) THEN
                  CALL s_get_doc_no(g_pmk.pmk01) RETURNING l_slip
                  SELECT smy72 INTO l_pmk02 FROM smy_file
                   WHERE smyslip = l_slip
                  IF NOT cl_null(l_pmk02) THEN
                     LET g_pmk.pmk02 = l_pmk02
                     DISPLAY BY NAME g_pmk.pmk02
                  END IF
               END IF

                IF g_pmk_t.pmk01 IS NULL OR
                   (g_pmk.pmk01 != g_pmk_t.pmk01 ) THEN
                   LET  g_pmk.pmkmksg = g_smy.smyapr
                   LET  g_pmk.pmksign = g_smy.smysign
                   DISPLAY BY NAME g_pmk.pmkmksg   #簽核否
                   DISPLAY BY NAME g_pmk.pmksign   #簽核等級
                END IF
                LET g_pmk.pmkprsw = 'Y' #g_smy.smyprint      #modi by kitty 96-06-18
            ELSE
               IF g_sma.sma120 = 'Y' AND g_sma.sma907 = 'Y' THEN
                  LET lg_smy62 = ''
                  CALL t420_refresh_detail()
               END IF
            END IF
            CALL t420_set_entry(p_cmd)   #MOD-910060
            CALL t420_set_no_entry(p_cmd)

        AFTER FIELD pmk02  #單據性質
           IF NOT cl_null(g_pmk.pmk02) THEN
               IF g_pmk.pmk02 != 'REG' AND g_pmk.pmk02 != 'EXP' AND
                  g_pmk.pmk02 != 'CAP' AND g_pmk.pmk02 != 'TAP' AND
                  cl_null(g_argv3) THEN
                  LET g_pmk.pmk02 = g_pmk_o.pmk02
                  DISPLAY BY NAME g_pmk.pmk02
                  NEXT FIELD pmk02
               END IF
               LET g_pmk_o.pmk02 = g_pmk.pmk02
           END IF

      AFTER FIELD pmk04       #請購日期(預設會計年度/期間)
          IF NOT cl_null(g_pmk.pmk04) THEN
             #MOD-C70108 add begin
             IF NOT cl_null(g_sma.sma53) AND g_pmk.pmk04 <= g_sma.sma53 THEN
               CALL cl_err('','mfg9999',0)
               NEXT FIELD pmk04
             END IF
             #MOD-C70108 add end
             IF (g_pmk_o.pmk04 IS NULL) OR (g_pmk_o.pmk04 != g_pmk.pmk04) THEN
                 SELECT azn02,azn04 INTO g_pmk.pmk31,g_pmk.pmk32 FROM azn_file
                  WHERE azn01 = g_pmk.pmk04
                 IF SQLCA.sqlcode THEN
                    CALL cl_err3("sel","azn_file",g_pmk.pmk04,"","mfg0027","","",1)  #No.FUN-660129
                    LET g_pmk.pmk04 = g_pmk_o.pmk04
                    DISPLAY BY NAME g_pmk.pmk04
                    NEXT FIELD pmk04
                 END IF
             END IF
             CALL s_get_bookno(YEAR(g_pmk.pmk04))
                  RETURNING g_flag,g_bookno1,g_bookno2
             IF g_flag =  '1' THEN  #抓不到帳別
                CALL cl_err(g_pmk.pmk04,'aoo-081',1)
                NEXT FIELD pmk04
             END IF
             #TQC-C30165--begin
             IF g_aza.aza17 != g_pmk.pmk22 THEN
                IF NOT cl_null(g_pmk_o.pmk04) AND g_pmk_o.pmk04 != g_pmk.pmk04 THEN
                   IF cl_confirm('apm-701') THEN
                      CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904)
                            RETURNING g_pmk.pmk42
                      DISPLAY BY NAME g_pmk.pmk42
                   END IF
                END IF
             END IF
             #TQC-C30165--end
             LET g_pmk_o.pmk04 = g_pmk.pmk04
           END IF

          AFTER FIELD pmk05
           IF NOT cl_null(g_pmk.pmk05) THEN
              SELECT COUNT(*) INTO g_cnt FROM pja_file
               WHERE pja01 = g_pmk.pmk05
                 AND pjaacti = 'Y'
                 AND pjaclose='N'             #FUN-960038
              IF g_cnt = 0 THEN
                 CALL cl_err(g_pmk.pmk05,'asf-984',0)
                 NEXT FIELD pmk05
              END IF
           END IF

        AFTER FIELD pmk09     #供應商
          IF NOT cl_null(g_pmk.pmk09) THEN
             IF (g_pmk_o.pmk09 IS NULL) OR (g_pmk_o.pmk09 != g_pmk.pmk09)
             THEN CALL t420_supplier('a','1',g_pmk.pmk09)     #show 簡稱
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_pmk.pmk09,g_errno,0)
                     LET g_pmk.pmk09 = g_pmk_o.pmk09
                     DISPLAY BY NAME g_pmk.pmk09
                     NEXT FIELD pmk09
                  END IF
                  IF p_cmd='u' THEN
#CHI-B80082 -- mark begin --
                    #SELECT COUNT(*) INTO l_n FROM pmk_file,pml_file
                    # WHERE pmk01=g_pmk.pmk01
                    #   AND pml01=pmk01
                    #   AND pml04 IN (SELECT ima01 FROM ima_file
                    #                  WHERE ima915 IN ('1','3'))
                    #IF l_n > 0 THEN
                    #   CALL cl_err('','apm-281',1)
                    #   LET g_pmk.pmk09 = g_pmk_o.pmk09
                    #   DISPLAY BY NAME g_pmk.pmk09
                    #   CALL t420_supplier('a','1',g_pmk.pmk09)
                    #   NEXT FIELD pmk09
                    #END IF
#CHI-B80082 -- mark end --
#CHI-B80082 -- begin --
                     DECLARE pml_cur CURSOR FOR
                        SELECT pml04 FROM pml_file
                           WHERE pml01 = g_pmk.pmk01
                     FOREACH pml_cur INTO l_pml04
                        SELECT ima915 INTO l_ima915 FROM ima_file WHERE ima01 = l_pml04
                        IF (l_ima915 ='1' OR l_ima915='3') AND NOT cl_null(g_pmk.pmk09) #TQC-BC0111 (l_ima915 ='1' OR l_ima915='3')加括號
                           AND NOT cl_null(g_pmk.pmk22) THEN
                           CALL t420_pmh(l_pml04)
                           IF NOT cl_null(g_errno) THEN
                              CALL cl_err(l_pml04,g_errno,1)
                              LET g_pmk.pmk09 = g_pmk_o.pmk09
                              DISPLAY BY NAME g_pmk.pmk09
                              NEXT FIELD pmk09
                              EXIT FOREACH
                           END IF
                        END IF
                     END FOREACH
#CHI-B80082 -- end --
                  END IF
                  CALL t420_pmk09_cd()     #show 出預設值
                  IF g_aza.aza17 = g_pmk.pmk22 THEN   #本幣
                     LET g_pmk.pmk42 = 1
                  ELSE
                     CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904) #FUN-640085
                     RETURNING g_pmk.pmk42
                  END IF
                  DISPLAY BY NAME g_pmk.pmk42
                  IF NOT cl_null(g_chr) THEN
                     LET g_pmk.pmk09 = g_pmk_o.pmk09
                     DISPLAY BY NAME g_pmk.pmk09
                     NEXT FIELD pmk09
                   END IF
             END IF
             LET g_pmk_o.pmk09 = g_pmk.pmk09
          END IF
          IF cl_null(g_pmk.pmk09) THEN DISPLAY '  ' TO FORMONLY.pmc03 END IF  #MOD-780026 add

       AFTER FIELD pmk10     #送貨地址
          IF NOT cl_null(g_pmk.pmk10) THEN
             LET l_cnt=0
             SELECT COUNT(*) INTO l_cnt FROM pme_file
              WHERE pme01=g_pmk.pmk10 AND pme02 IN ('0','2')
             IF l_cnt=0 THEN
                    CALL cl_err(g_pmk.pmk10,'apm-423',0)                      #No.MOD-870161
                    NEXT FIELD pmk10
             END IF
          END IF

       AFTER FIELD pmk11     #發票地址
          IF NOT cl_null(g_pmk.pmk11) THEN
             LET l_cnt=0
             SELECT COUNT(*) INTO l_cnt FROM pme_file
              WHERE pme01=g_pmk.pmk11 AND pme02 IN ('1','2')
             IF l_cnt=0 THEN
                   CALL cl_err(g_pmk.pmk11,'apm-424',0)                       #No.MOD-870161
                   NEXT FIELD pmk11
             END IF
          END IF

       AFTER FIELD pmk12       #請購員
          IF NOT cl_null(g_pmk.pmk12) THEN
              IF g_pmk_o.pmk12 IS NULL OR (g_pmk.pmk12 != g_pmk_o.pmk12 ) THEN
                 CALL t420_peo('a','1',g_pmk.pmk12)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pmk.pmk12,g_errno,0)
                    LET g_pmk.pmk12 = g_pmk_o.pmk12
                    DISPLAY BY NAME g_pmk.pmk12
                    CALL t420_peo('d','1',g_pmk.pmk12)
                    NEXT FIELD pmk12
                 END IF
              END IF
              LET g_pmk_o.pmk12 = g_pmk.pmk12
          END IF

       AFTER FIELD pmk13       #請購部門
          IF NOT cl_null(g_pmk.pmk13) THEN
              IF g_pmk_o.pmk13 IS NULL OR (g_pmk.pmk13 != g_pmk_o.pmk13 ) THEN
                 CALL t420_dep('a','1',g_pmk.pmk13)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pmk.pmk13,g_errno,0)
                    LET g_pmk.pmk13 = g_pmk_o.pmk13
                    DISPLAY BY NAME g_pmk.pmk13
                    CALL t420_dep('d','1',g_pmk.pmk13)
                    NEXT FIELD pmk13
                 END IF
              END IF
              LET g_pmk_o.pmk13 = g_pmk.pmk13
          END IF
     AFTER FIELD pmk16
          IF NOT cl_null(g_pmk.pmk16) THEN
            LET l_n=0
              SELECT count(*) INTO l_n from ged_file
               WHERE ged01=g_pmk.pmk16
            IF l_n=0 THEN
               CALL cl_err(g_pmk.pmk16,'apm-425',0)
               NEXT FIELD pmk16
            END IF
            #TQC-BB0128--begin
            SELECT ged02 INTO l_ged02 FROM ged_file
               WHERE ged01=g_pmk.pmk16
            DISPLAY l_ged02 TO ged02
            #TQC-BB0128--end
          END IF

        AFTER FIELD pmk20                       #付款條件
          IF NOT cl_null(g_pmk.pmk20) THEN
             IF (g_pmk_o.pmk20 IS NULL) OR (g_pmk_o.pmk20 != g_pmk.pmk20) THEN
                 CALL t420_pmk20()
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pmk.pmk20,g_errno,0)
                    LET g_pmk.pmk20 = g_pmk_o.pmk20
                    DISPLAY BY NAME g_pmk.pmk20
                    CALL t420_pmk20()
                    NEXT FIELD pmk20
                 END IF
             END IF
             LET g_pmk_o.pmk20 = g_pmk.pmk20
           END IF
          IF cl_null(g_pmk.pmk20) THEN DISPLAY '  ' TO pma02 END IF  #MOD-780083 add

        AFTER FIELD pmk21                       #稅別條件
            IF NOT cl_null(g_pmk.pmk21) THEN
              IF (g_pmk_o.pmk21 IS NULL) OR (g_pmk.pmk21 != g_pmk_o.pmk21) THEN
                  CALL t420_pmk21()
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err(g_pmk.pmk21,g_errno,0)
                     LET g_pmk.pmk21 = g_pmk_o.pmk21
                     DISPLAY BY NAME g_pmk.pmk21
                     CALL t420_pmk21()
                     NEXT FIELD pmk21
                  END IF
              END IF
           ELSE
	       LET g_pmk.pmk43 = 0
	       LET g_gec07 = 'N'
	       DISPLAY g_gec07 TO gec07
	       DISPLAY BY NAME g_pmk.pmk43
            END IF
              LET g_pmk_o.pmk21 = g_pmk.pmk21

        AFTER FIELD pmk43          #稅率
            IF cl_null(g_pmk.pmk43) THEN
               LET g_pmk.pmk43 = 0
               DISPLAY BY NAME g_pmk.pmk43
            END IF
            IF NOT cl_null(g_pmk.pmk43) AND g_pmk.pmk43 < 0
            THEN CALL cl_err(g_pmk.pmk43,'mfg0013',0)
                 LET g_pmk.pmk43 = g_pmk_o.pmk43
                 DISPLAY BY NAME g_pmk.pmk43
                 NEXT FIELD pmk43
            END IF
            LET g_pmk_o.pmk43 = g_pmk.pmk43

        AFTER FIELD pmk22                       #幣別
            IF NOT cl_null(g_pmk.pmk22) THEN
              IF (g_pmk_o.pmk22 IS NULL) OR (g_pmk_o.pmk22 != g_pmk.pmk22)
                 THEN CALL t420_pmk22()
                      IF NOT cl_null(g_errno) THEN
                         CALL cl_err(g_pmk.pmk22,g_errno,0)
                         LET g_pmk.pmk22 = g_pmk_o.pmk22
                         DISPLAY BY NAME g_pmk.pmk22
                         CALL t420_pmk22()
                         NEXT FIELD pmk22
                      END IF
                      IF g_aza.aza17 = g_pmk.pmk22 THEN   #本幣
                          LET g_pmk.pmk42 = 1
                      ELSE
                          CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904) #FUN-640085
                          RETURNING g_pmk.pmk42
                      END IF
                      DISPLAY BY NAME g_pmk.pmk42
              END IF
            ELSE
               LET g_pmk.pmk42 = 1
               DISPLAY BY NAME g_pmk.pmk42
            END IF
              LET g_pmk_o.pmk22 = g_pmk.pmk22

       AFTER FIELD pmk41                      #價格條件
           IF NOT cl_null(g_pmk.pmk41) THEN
            SELECT pnz02 INTO l_buf FROM pnz_file WHERE pnz01=g_pmk.pmk41 #FUN-930113 oah-->pnz
            IF STATUS THEN
               CALL cl_err3("sel","pnz_file",g_pmk.pmk41,"",STATUS,"","sel pnz:",1)  #No.FUN-660129 #FUN-930113 oah-->pnz
                NEXT FIELD pmk41
            END IF
           ELSE               #MOD-780083 add
             LET l_buf=NULL   #MOD-780083 add
           END IF             #MOD-780083 add
           DISPLAY l_buf TO FORMONLY.pnz02 #FUN-930113 oah-->pnz

       AFTER FIELD pmk42                      #匯率
            IF NOT cl_null(g_pmk.pmk42) THEN
               IF g_pmk.pmk42 <= 0 THEN
                   CALL cl_err(g_pmk.pmk42,'mfg0013',0)
                   LET g_pmk.pmk42 = g_pmk_o.pmk42
                   DISPLAY BY NAME g_pmk.pmk42
                   NEXT FIELD pmk42
               END IF
               LET g_pmk_o.pmk42 = g_pmk.pmk42

               IF g_pmk.pmk22 =g_aza.aza17 THEN
                  LET g_pmk.pmk42 =1
                  DISPLAY g_pmk.pmk42  TO pmk42
               END IF
#TQC-C30165 add begin
               IF g_aza.aza17 != g_pmk.pmk22 THEN
                  CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904)
                     RETURNING l_pmk42
                  IF l_pmk42 <>  g_pmk.pmk42 THEN
                      IF cl_confirm('apm-702') THEN
                         LET  g_pmk.pmk42 = l_pmk42
                         DISPLAY BY NAME g_pmk.pmk42
                      END IF
                  END IF
               END IF
#TQC-C30165 add end
            END IF

        AFTER FIELD pmk45                      #可用否
           IF NOT cl_null(g_pmk.pmk45) THEN
               IF g_pmk.pmk45 NOT MATCHES'[YyNn]' THEN
                   CALL cl_err(g_pmk.pmk45,'mfg1002',0)
                   LET g_pmk.pmk45 = g_pmk_o.pmk45
                   DISPLAY BY NAME g_pmk.pmk45
                   NEXT FIELD pmk45
               END IF
               LET g_pmk_o.pmk45= g_pmk.pmk45
           END IF

        AFTER FIELD pmkmksg    #簽核否
           IF NOT cl_null(g_pmk.pmkmksg) THEN
               IF g_pmk.pmkmksg NOT MATCHES'[yYnN]' THEN NEXT FIELD pmkmksg END IF
               IF g_pmk.pmkmksg  MATCHES'[Nn]'
                 THEN LET g_pmk.pmksmax = 0
                      LET g_pmk.pmksseq = 0
               END IF
               IF g_pmk.pmkmksg MATCHES '[Yy]' THEN
                  LET g_pmk.pmk25 = "0"
                  DISPLAY BY NAME g_pmk.pmk25
                  CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg)
                                 RETURNING g_sta
                  DISPLAY g_sta TO FORMONLY.desc2
               END IF
               IF g_pmk.pmkmksg MATCHES '[Nn]' THEN
                  LET g_pmk.pmk25 = "1"
                  DISPLAY BY NAME g_pmk.pmk25
                  CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg)
                                 RETURNING g_sta
                  DISPLAY g_sta TO FORMONLY.desc2
               END IF
           END IF

##-------------- Genero 其他畫面副程式(sapmt423)加入主程式 ---------------##
       AFTER FIELD pmk14
            IF cl_null(g_pmk.pmk14) THEN    #收貨部門
               DISPLAY ' ' TO  FORMONLY.gem02_2
            ELSE IF (g_pmk_o.pmk14 IS NULL) OR
                    (g_pmk.pmk14 != g_pmk_o.pmk14 ) THEN
                     CALL t420_dep('a','2',g_pmk.pmk14)
                     IF NOT cl_null(g_errno) THEN
                        CALL cl_err(g_pmk.pmk14,g_errno,0)
                        LET g_pmk.pmk14 = g_pmk_o.pmk14
                        DISPLAY BY NAME g_pmk_o.pmk14
                        NEXT FIELD pmk14
                     END IF
                 END IF
            END IF
            LET g_pmk_o.pmk14 = g_pmk.pmk14

       AFTER FIELD pmk15
            IF cl_null(g_pmk.pmk15) THEN    #確認人
               DISPLAY ' ' TO FORMONLY.gen02_2
            ELSE IF (g_pmk_o.pmk15 IS NULL) OR
                    (g_pmk.pmk15 != g_pmk_o.pmk15 ) THEN
                    CALL t420_peo('a','2',g_pmk.pmk15)
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_pmk.pmk15,g_errno,0)
                       LET g_pmk.pmk15 = g_pmk_o.pmk15
                       DISPLAY BY NAME g_pmk_o.pmk15
                       NEXT FIELD pmk15
                    END IF
                 END IF
            END IF
            LET g_pmk_o.pmk15 = g_pmk.pmk15

       AFTER FIELD pmk17                      #代理商
           IF cl_null(g_pmk.pmk17) THEN
               DISPLAY ' ' TO FORMONLY.pmc03_2
            ELSE IF (g_pmk_o.pmk17 IS NULL) OR
                    (g_pmk.pmk17 != g_pmk_o.pmk17 ) THEN
                    CALL t420_supplier('a','2',g_pmk.pmk17)
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_pmk.pmk17,g_errno,0)
                       LET g_pmk.pmk17 = g_pmk_o.pmk17
                       DISPLAY BY NAME g_pmk_o.pmk17
                       NEXT FIELD pmk17
                    END IF
                 END IF
            END IF

       AFTER FIELD pmk30                      #印驗收單
           IF NOT cl_null(g_pmk.pmk30 ) THEN
               IF g_pmk.pmk30 NOT MATCHES'[YyNn]' THEN
                   CALL cl_err(g_pmk.pmk30,'mfg1002',0)
                   LET g_pmk.pmk30 = g_pmk_o.pmk30
                   DISPLAY BY NAME g_pmk.pmk30
                   NEXT FIELD pmk30
               END IF
               LET g_pmk_o.pmk30= g_pmk.pmk30
           END IF

##-------------- Genero 其他畫面副程式(sapmt423)加入主程式 (end)----------##
        AFTER FIELD pmkud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD pmkud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF

       AFTER INPUT
#TQC-B60102   ---start   Add
          LET g_pmk.pmkuser = s_get_data_owner("pmk_file") #FUN-C10039
          LET g_pmk.pmkgrup = s_get_data_group("pmk_file") #FUN-C10039
         IF NOT cl_null(g_pmk.pmk12) THEN
             IF g_pmk_o.pmk12 IS NULL OR (g_pmk.pmk12 != g_pmk_o.pmk12 ) THEN
                CALL t420_peo('a','1',g_pmk.pmk12)
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err(g_pmk.pmk12,g_errno,0)
                   LET g_pmk.pmk12 = g_pmk_o.pmk12
                   DISPLAY BY NAME g_pmk.pmk12
                   CALL t420_peo('d','1',g_pmk.pmk12)
                   NEXT FIELD pmk12
                END IF
             END IF
             LET g_pmk_o.pmk12 = g_pmk.pmk12
         END IF
# TQC-B60102   ---end     Add
#TQC-C30165 add begin
         IF p_cmd='u' THEN
            IF g_aza.aza17 != g_pmk.pmk22 THEN
               CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904)
                  RETURNING l_pmk42
               IF l_pmk42 <>  g_pmk.pmk42 THEN
                   IF cl_confirm('apm-702') THEN
                      LET  g_pmk.pmk42 = l_pmk42
                      DISPLAY BY NAME g_pmk.pmk42
                   END IF
               END IF
            END IF
         END IF
#TQC-C30165 add end
#TQC-C10018 add begin----------------------------------------
        IF p_cmd='u' THEN
           DECLARE pml_cur1 CURSOR FOR
              SELECT pml04 FROM pml_file
                 WHERE pml01 = g_pmk.pmk01
           FOREACH pml_cur1 INTO l_pml04
              SELECT ima915 INTO l_ima915 FROM ima_file WHERE ima01 = l_pml04
              IF (l_ima915 ='1' OR l_ima915='3') AND NOT cl_null(g_pmk.pmk09)
                 AND NOT cl_null(g_pmk.pmk22) THEN
                 CALL t420_pmh(l_pml04)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(l_pml04,g_errno,1)
                    LET g_pmk.pmk09 = g_pmk_o.pmk09
                    DISPLAY BY NAME g_pmk.pmk09
                    NEXT FIELD pmk09
                    EXIT FOREACH
                 END IF
              END IF
           END FOREACH
        END IF
#TQC-C10018 add end-----------------------------------------
        IF INT_FLAG THEN                         # 若按了DEL鍵
            CALL cl_err('',9001,0)
            EXIT INPUT
        END IF

        ON ACTION maintain_supplier_common_data
           #LET g_cmd = "apmi600  '' ",g_pmk.pmk09 CLIPPED  #MOD-4B0255 #參數傳錯 #CHI-D30005 mark
            LET g_cmd = "apmi600 '",g_pmk.pmk09,"' '' "     #CHI-D30005 add
           CALL cl_cmdrun(g_cmd)

        ON ACTION qry_item_supplier
            LET g_cmd = "apmq210 '' ",g_pmk.pmk09 CLIPPED  #MOD-4B0255
           CALL cl_cmdrun(g_cmd)

        ON ACTION qry_supplr_item_last_p_o_price
            LET g_cmd = "apmq220 ",g_pmk.pmk09 CLIPPED  #MOD-4B0255
           CALL cl_cmdrun(g_cmd)

        ON ACTION CONTROLP
            CASE
               WHEN INFIELD(pmk01) #單據編號
                     LET g_t1 = s_get_doc_no(g_pmk.pmk01)    #No.MOD-540182
                    CALL q_smy(FALSE,FALSE,g_t1,'APM','1') RETURNING g_t1 #TQC-670008
                    LET g_pmk.pmk01 = g_t1
                    NEXT FIELD pmk01

               WHEN INFIELD(pmk05)  #專案代號
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_pja2"
                    LET g_qryparam.default1 = g_pmk.pmk05
                    CALL cl_create_qry() RETURNING g_pmk.pmk05
                    DISPLAY BY NAME g_pmk.pmk05
                    NEXT FIELD pmk05

               WHEN INFIELD(pmk09) #查詢廠商檔
                    CALL cl_init_qry_var()
                    #No.MOD-A70072  --Begin
                    #IF g_azw.azw04 = '2' THEN
                    #   LET g_qryparam.form = "q_pmc1_1"
                    #   LET g_qryparam.arg1 = g_plant
                    #ELSE
                    #   LET g_qryparam.form = "q_pmc1"
                    #END IF
                    LET g_qryparam.form = "q_pmc1"
                    #No.MOD-A70072  --End
                    LET g_qryparam.default1 = g_pmk.pmk09
                    CALL cl_create_qry() RETURNING g_pmk.pmk09
                    DISPLAY BY NAME g_pmk.pmk09
                    CALL t420_supplier('a','1',g_pmk.pmk09)
                    NEXT FIELD pmk09
               WHEN INFIELD(pmk10)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_pme"
                  LET g_qryparam.default1 = g_pmk.pmk10
                  LET g_qryparam.where = " ( pme02 = '0' OR pme02 = '2' )"
                  CALL cl_create_qry() RETURNING g_pmk.pmk10
                  DISPLAY BY NAME g_pmk.pmk10
                  NEXT FIELD pmk10
               WHEN INFIELD(pmk11)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_pme"
                  LET g_qryparam.default1 = g_pmk.pmk11
                  LET g_qryparam.where = " ( pme02 = '1' OR pme02 = '2' )"
                  CALL cl_create_qry() RETURNING g_pmk.pmk11
                  DISPLAY BY NAME g_pmk.pmk11
                  NEXT FIELD pmk11
               WHEN INFIELD(pmk12) #請購員
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_pmk.pmk12
                    CALL cl_create_qry() RETURNING g_pmk.pmk12
                    DISPLAY BY NAME g_pmk.pmk12
                    CALL t420_peo('a','1',g_pmk.pmk12)
                    NEXT FIELD pmk12
               WHEN INFIELD(pmk15) #確認人
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_pmk.pmk15
                    CALL cl_create_qry() RETURNING g_pmk.pmk15
                    DISPLAY BY NAME g_pmk.pmk15
                    CALL t420_peo('a','2',g_pmk.pmk15)
                     NEXT FIELD pmk15   #NO.MOD-480478
                WHEN INFIELD(pmk16) #運送方式
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_ged"
                    LET g_qryparam.default1 = g_pmk.pmk16
                    CALL cl_create_qry() RETURNING g_pmk.pmk16
                    DISPLAY BY NAME g_pmk.pmk16
                     NEXT FIELD pmk16
               WHEN INFIELD(pmk13) #請購Dept
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem"
                    LET g_qryparam.default1 = g_pmk.pmk13
                    CALL cl_create_qry() RETURNING g_pmk.pmk13
                    DISPLAY BY NAME g_pmk.pmk13
                    CALL t420_dep('a','1',g_pmk.pmk13)
                    NEXT FIELD pmk13
               WHEN INFIELD(pmk14) #收貨Dept
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem"
                    LET g_qryparam.default1 = g_pmk.pmk14
                    CALL cl_create_qry() RETURNING g_pmk.pmk14
                    DISPLAY BY NAME g_pmk.pmk14
                    CALL t420_dep('a','2',g_pmk.pmk14)
               WHEN INFIELD(pmk17) #廠商資料
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_pmc1"
                  LET g_qryparam.default1 = g_pmk.pmk17
                  CALL cl_create_qry() RETURNING g_pmk.pmk17
                  DISPLAY BY NAME g_pmk.pmk17
                  NEXT FIELD pmk17
               WHEN INFIELD(pmk20) #查詢付款條件資料檔(pma_file)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_pma"
                    LET g_qryparam.default1 = g_pmk.pmk20
                    CALL cl_create_qry() RETURNING g_pmk.pmk20
                    DISPLAY BY NAME g_pmk.pmk20
                    NEXT FIELD pmk20
               WHEN INFIELD(pmk21) #查詢稅別資料檔(gec_file)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gec"
                    LET g_qryparam.default1 = g_pmk.pmk21
                    LET g_qryparam.arg1     = '1'
                    CALL cl_create_qry() RETURNING g_pmk.pmk21
                    DISPLAY BY NAME g_pmk.pmk21
                    NEXT FIELD pmk21
               WHEN INFIELD(pmk22) #查詢幣別資料檔
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_pmk.pmk22
                    CALL cl_create_qry() RETURNING g_pmk.pmk22
                    DISPLAY BY NAME g_pmk.pmk22
                    NEXT FIELD pmk22
                WHEN INFIELD(pmk42)
                   CALL s_rate(g_pmk.pmk22,g_pmk.pmk42) RETURNING g_pmk.pmk42
                   DISPLAY BY NAME g_pmk.pmk42
                   NEXT FIELD pmk42
               WHEN INFIELD(pmk41) #價格條件
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_pnz01" #FUN-930113 oah-->pnz01
                    LET g_qryparam.default1 = g_pmk.pmk41
                    CALL cl_create_qry() RETURNING g_pmk.pmk41
                    DISPLAY BY NAME g_pmk.pmk41
                    SELECT pnz02 INTO l_buf FROM pnz_file WHERE pnz01=g_pmk.pmk41 #FUN-930113 oah-->pnz
                    DISPLAY l_buf TO FORMONLY.pnz02 #FUN-930113 oah-->pnz
               WHEN INFIELD(pmkud02)
                  CALL cl_dynamic_qry() RETURNING g_pmk.pmkud02
                  DISPLAY BY NAME g_pmk.pmkud02
                  NEXT FIELD pmkud02
               WHEN INFIELD(pmkud03)
                  CALL cl_dynamic_qry() RETURNING g_pmk.pmkud03
                  DISPLAY BY NAME g_pmk.pmkud03
                  NEXT FIELD pmkud03
               WHEN INFIELD(pmkud04)
                  CALL cl_dynamic_qry() RETURNING g_pmk.pmkud04
                  DISPLAY BY NAME g_pmk.pmkud04
                  NEXT FIELD pmkud04
               WHEN INFIELD(pmkud05)
                  CALL cl_dynamic_qry() RETURNING g_pmk.pmkud05
                  DISPLAY BY NAME g_pmk.pmkud05
                  NEXT FIELD pmkud05
               WHEN INFIELD(pmkud06)
                  CALL cl_dynamic_qry() RETURNING g_pmk.pmkud06
                  DISPLAY BY NAME g_pmk.pmkud06
                  NEXT FIELD pmkud06
               OTHERWISE EXIT CASE
            END CASE

         ON ACTION CONTROLR
             CALL cl_show_req_fields()

         ON ACTION CONTROLG
            CALL cl_cmdask()

        ON ACTION CONTROLF                        # 欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

    END INPUT
END FUNCTION


FUNCTION t420_supplier(p_cmd,p_code,p_key)  #供應廠商
    DEFINE l_pmc03   LIKE pmc_file.pmc03,
           l_pmc30   LIKE pmc_file.pmc30,
           l_pmcacti LIKE pmc_file.pmcacti,
           p_cmd     LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(1)
           p_code    LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
           p_key     LIKE pmc_file.pmc01
DEFINE l_pmc05  LIKE pmc_file.pmc05  #No.FUN-870007
DEFINE l_pmc930 LIKE pmc_file.pmc930 #No.FUN-870007

    LET g_errno = ' '
     SELECT pmc03,pmc30,pmcacti,pmc05,pmc930             #No.FUN-870007
       INTO l_pmc03,l_pmc30,l_pmcacti,l_pmc05,l_pmc930   #No.FUN-870007
       FROM pmc_file
      WHERE pmc01 = p_key
  IF g_azw.azw04 = '2' THEN
     CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3014'
                                      LET l_pmc03 = NULL
            WHEN l_pmcacti !='Y'   LET g_errno = 'art-471'
            WHEN l_pmc05 !='1'     LET g_errno = 'art-472'
            WHEN l_pmc30  ='2' LET g_errno = 'apm-420'      #付款商
            WHEN l_pmc930 = g_plant LET g_errno = 'art-445'
            OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
     END CASE
  ELSE
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3014'
                            LET l_pmc03 = NULL
         WHEN l_pmcacti='N' LET g_errno = '9028'
         WHEN l_pmcacti MATCHES '[PH]'   LET g_errno = '9038'  #No.FUN-690024 add
         WHEN l_pmc30  ='2' LET g_errno = 'apm-420'      #付款商
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
  END IF #No.FUN-870007
    IF cl_null(g_errno) OR p_cmd = 'd' THEN
       IF p_code = '1' THEN
          DISPLAY l_pmc03 TO FORMONLY.pmc03
       ELSE
          DISPLAY l_pmc03 TO FORMONLY.pmc03_2
       END IF
    END IF
END FUNCTION

FUNCTION t420_pmk09_cd()  #供應廠商check ,default
    DEFINE l_pmc05   LIKE pmc_file.pmc05,   #廠商目前狀況
           l_pmcacti LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(1)
           l_cnt     LIKE type_file.num5,     #No.FUN-680136 SMALLINT
           l_buf     LIKE type_file.chr1000,  #No.FUN-680136 VARCHAR(30)
           l_chr     LIKE type_file.chr1      #No.FUN-680136 VARCHAR(1)

   LET g_chr = " "
   #交易狀況/送貨地址/帳單地址/付款方式/付款幣別/稅別
   SELECT pmc05,pmc15,pmc16,pmc17,pmc22,pmc47,pmcacti,pmc49
     INTO l_pmc05,g_pmk.pmk10,g_pmk.pmk11,
          g_pmk.pmk20,g_pmk.pmk22,g_pmk.pmk21,l_pmcacti,g_pmk.pmk41
     FROM pmc_file
    WHERE pmc01 = g_pmk.pmk09 AND pmc30 IN ('1','3')
    CASE
       WHEN l_pmc05 = '0'   #No.FUN-690025 mod
            CALL cl_getmsg('mfg3174',g_lang) RETURNING g_msg  #尚侍核准
            WHILE l_chr IS NULL OR l_chr NOT MATCHES'[YyNn]'
            LET INT_FLAG = 0  ######add for prompt bug
               PROMPT g_msg CLIPPED FOR CHAR l_chr
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

               END PROMPT
               IF INT_FLAG THEN LET INT_FLAG = 0 EXIT WHILE END IF
               IF l_chr MATCHES '[Nn]' THEN LET g_chr = 'e'  END IF
            END WHILE
       WHEN l_pmc05 = '3'  CALL cl_err(g_pmk.pmk09,'mfg3042',0)  #No.FUN-690025
                           LET g_chr = 's'
       OTHERWISE EXIT CASE
    END CASE


#TQC-BB0121 --begin--
#    DISPLAY BY NAME g_pmk.pmk10         #送貨地址
#    DISPLAY BY NAME g_pmk.pmk11         #帳單地址
#    DISPLAY BY NAME g_pmk.pmk20         #付款條件
#    DISPLAY BY NAME g_pmk.pmk21         #稅別
#    DISPLAY BY NAME g_pmk.pmk22         #幣別
#    DISPLAY BY NAME g_pmk.pmk41         #價格條件
#TQC-BB0121 --end--

    IF NOT cl_null(g_pmk.pmk10) THEN
       LET l_cnt=0
       SELECT COUNT(*) INTO l_cnt FROM pme_file
        WHERE pme01=g_pmk.pmk10 AND pme02 IN ('0','2')
        IF l_cnt=0 THEN
           LET g_pmk.pmk10 = ''
        END IF
    END IF

    IF NOT cl_null(g_pmk.pmk11) THEN
       LET l_cnt=0
       SELECT COUNT(*) INTO l_cnt FROM pme_file
        WHERE pme01=g_pmk.pmk11 AND pme02 IN ('1','2')
        IF l_cnt=0 THEN
           LET g_pmk.pmk11 = ''
        END IF
    END IF

    IF NOT cl_null(g_pmk.pmk20) THEN
       CALL t420_pmk20()
       IF NOT cl_null(g_errno) THEN
          LET g_pmk.pmk20 = ''
       END IF
    END IF

    IF NOT cl_null(g_pmk.pmk21) THEN
       CALL t420_pmk21()
       IF NOT cl_null(g_errno) THEN
          LET g_pmk.pmk21 = ''
       END IF
    END IF

    IF NOT cl_null(g_pmk.pmk22) THEN
       CALL t420_pmk22()
       IF NOT cl_null(g_errno) THEN
          LET g_pmk.pmk22 = ''
       ELSE
          IF g_aza.aza17 = g_pmk.pmk22 THEN   #本幣
             LET g_pmk.pmk42 = 1
          ELSE
             CALL s_curr3(g_pmk.pmk22,g_pmk.pmk04,g_sma.sma904) #FUN-640085
                  RETURNING g_pmk.pmk42
          END IF
       END IF
    END IF

    IF NOT cl_null(g_pmk.pmk41) THEN
       SELECT pnz02 INTO l_buf FROM pnz_file #FUN-930113 oah-->pnz
        WHERE pnz01=g_pmk.pmk41 #FUN-930113 oah-->pnz
       IF STATUS THEN
          LET g_pmk.pmk41 = ''
          LET l_buf=''
       END IF
       DISPLAY l_buf TO FORMONLY.pnz02 #FUN-930113 oah-->pnz
    END IF

#TQC-BB0121 --begin--
    DISPLAY BY NAME g_pmk.pmk10         #送貨地址
    DISPLAY BY NAME g_pmk.pmk11         #帳單地址
    DISPLAY BY NAME g_pmk.pmk20         #付款條件
    DISPLAY BY NAME g_pmk.pmk21         #稅別
    DISPLAY BY NAME g_pmk.pmk22         #幣別
    DISPLAY BY NAME g_pmk.pmk41         #價格條件
#TQC-BB0121 --end--


END FUNCTION

FUNCTION t420_peo(p_cmd,p_code,p_key)    #人員
  DEFINE p_cmd       LIKE type_file.chr1,    #No.FUN-680136  VARCHAR(01)
         p_code      LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
         p_key       LIKE gen_file.gen01,
         l_gen02     LIKE gen_file.gen02,
         l_gen03     LIKE gen_file.gen03,
         l_genacti   LIKE gen_file.genacti
  LET g_errno = ' '
  SELECT gen02,gen03,genacti INTO l_gen02,l_gen03,l_genacti
         FROM gen_file  WHERE gen01 = p_key

  CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg1312' LET l_gen02 = NULL
       WHEN l_genacti='N' LET g_errno = '9028'
       OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
  END CASE
  IF cl_null(g_errno) OR p_cmd = 'd' THEN
     IF p_code = '1' THEN
        IF p_cmd='a' THEN
           IF cl_null(g_pmk.pmk13) THEN   #MOD-BC0117 add
              LET g_pmk.pmk13=l_gen03 DISPLAY BY NAME g_pmk.pmk13
           END IF                         #MOD-BC0117 add
        END IF
        DISPLAY l_gen02 TO FORMONLY.gen02
     ELSE
        DISPLAY l_gen02 TO FORMONLY.gen02_2
     END IF
  END IF
END FUNCTION

FUNCTION t420_dep(p_cmd,p_code,p_key)    #Dept
   DEFINE p_cmd       LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
          p_code      LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
          p_key       LIKE gem_file.gem01,
          l_gem02     LIKE gem_file.gem02,
          l_gemacti   LIKE gem_file.gemacti

   LET g_errno = ' '

   SELECT gem02,gemacti INTO l_gem02,l_gemacti
     FROM gem_file
    WHERE gem01 = p_key

   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3097' LET l_gem02 = NULL
        WHEN l_gemacti='N' LET g_errno = '9028'
        OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

   IF cl_null(g_errno) OR p_cmd = 'd' THEN
      IF p_code = '1' THEN
         DISPLAY l_gem02 TO FORMONLY.gem02
      ELSE
         DISPLAY l_gem02 TO FORMONLY.gem02_2
      END IF
   END IF

END FUNCTION

FUNCTION t420_pmk20()  #付款條件
   DEFINE l_pmaacti  LIKE pma_file.pmaacti,
          l_pma02    LIKE pma_file.pma02

   LET g_errno = " "

   SELECT pma02,pmaacti INTO l_pma02,l_pmaacti
     FROM pma_file
    WHERE pma01 = g_pmk.pmk20

   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3099'
                         LET l_pmaacti = NULL
                         LET l_pma02   = NULL
     WHEN l_pmaacti='N' LET g_errno = '9028'
     OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

   DISPLAY l_pma02 TO pma02

END FUNCTION

FUNCTION t420_pmk21()  #稅別
   DEFINE l_gec04     LIKE gec_file.gec04,
          l_gecacti   LIKE gec_file.gecacti

   LET g_errno = " "

   SELECT gec04,gecacti,gec07 INTO l_gec04,l_gecacti,g_gec07    #No.FUN-550019
     FROM gec_file
    WHERE gec01 = g_pmk.pmk21
      AND gec011 = '1'  #進項

   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3044'
                            LET l_gec04 = 0
        WHEN l_gecacti='N' LET g_errno = '9028'
        OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

   IF NOT cl_null(l_gec04) THEN
      LET g_pmk.pmk43 = l_gec04
      DISPLAY BY NAME g_pmk.pmk43
   END IF

   DISPLAY g_gec07 TO gec07        #No.FUN-550019

END FUNCTION

FUNCTION t420_pmk22()  #幣別
   DEFINE l_aziacti LIKE azi_file.aziacti

   LET g_errno = " "

   SELECT azi03,aziacti INTO t_azi03,l_aziacti FROM azi_file  #No.FUN-550019  #No.CHI-6A0004
    WHERE azi01 = g_pmk.pmk22

   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3008'
                            LET l_aziacti = 0
        WHEN l_aziacti='N' LET g_errno = '9028'
        OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

END FUNCTION

FUNCTION t420_q()

   LET g_row_count = 0
   LET g_curs_index = 0

   CALL cl_navigator_setting( g_curs_index, g_row_count )
   INITIALIZE g_pmk.* TO NULL                   #MOD-570070

   CALL cl_msg("")                              #FUN-640184

   CALL cl_opmsg('q')
   DISPLAY '   ' TO FORMONLY.cnt

   IF g_sma.sma120 = 'Y'  THEN
      LET lg_smy62 = ''
      LET lg_group = ''
      CALL t420_refresh_detail()
   END IF
   CALL t420_cs()                          # 宣告 SCROLL CURSOR

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLEAR FORM
      CALL g_pml.clear()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
      INITIALIZE g_pmk.* TO NULL
      RETURN
   END IF

   CALL cl_msg(" SEARCHING ! ")                              #FUN-640184

   OPEN t420_count
   FETCH t420_count INTO g_row_count
   DISPLAY g_row_count TO FORMONLY.cnt

   OPEN t420_cs                            # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
      INITIALIZE g_pmk.* TO NULL
   ELSE
      CALL t420_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF

   CALL cl_msg("")                              #FUN-640184

END FUNCTION

FUNCTION t420_fetch(p_flpmk)
   DEFINE p_flpmk   LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)
   DEFINE l_slip    LIKE smy_file.smyslip  #No.FUN-680136 VARCHAR(10)  #No.TQC-650108

    CASE p_flpmk
        WHEN 'N' FETCH NEXT     t420_cs INTO g_pmk.pmk01
        WHEN 'P' FETCH PREVIOUS t420_cs INTO g_pmk.pmk01
        WHEN 'F' FETCH FIRST    t420_cs INTO g_pmk.pmk01
        WHEN 'L' FETCH LAST     t420_cs INTO g_pmk.pmk01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
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
                IF INT_FLAG THEN
                    LET INT_FLAG = 0
                    EXIT CASE
                END IF
            END IF
            FETCH ABSOLUTE g_jump t420_cs INTO g_pmk.pmk01
            LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN
        CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
        INITIALIZE g_pmk.* TO NULL  #TQC-6B0105
        LET g_pmk.pmk01 = NULL      #TQC-6B0105
        RETURN
    ELSE
       CASE p_flpmk
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE

       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF

   #在使用Q查詢的情況下得到當前對應的屬性組smy62
   IF g_sma.sma120 = 'Y' AND g_sma.sma907 = 'Y' THEN
      LET l_slip = g_pmk.pmk01[1,g_doc_len]
      SELECT smy62 INTO lg_smy62 FROM smy_file
         WHERE smyslip = l_slip
   END IF

    SELECT * INTO g_pmk.* FROM pmk_file            # 重讀DB,因TEMP有不被更新特性
     WHERE pmk01 = g_pmk.pmk01
    IF SQLCA.sqlcode THEN
       IF g_bgerr THEN
          CALL s_errmsg("pmk01",g_pmk.pmk01,"",SQLCA.sqlcode,1)
       ELSE
          CALL cl_err3("sel","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)
       END IF
    ELSE
       LET g_t1=g_pmk.pmk01[1,g_doc_len]
       SELECT * INTO g_smy.* FROM smy_file WHERE smyslip=g_t1

       LET g_data_owner = g_pmk.pmkuser      #FUN-4C0056 add
       LET g_data_group = g_pmk.pmkgrup      #FUN-4C0056 add
       LET g_data_plant = g_pmk.pmkplant #FUN-980030
       CALL s_get_bookno(YEAR(g_pmk.pmk04)) RETURNING g_flag,g_bookno1,g_bookno2
       IF g_flag =  '1' THEN  #抓不到帳別
          CALL cl_err(g_pmk.pmk04,'aoo-081',1)
       END IF
       CALL t420_show()                      # 重新顯示
    END IF

END FUNCTION

FUNCTION t420_show()
   DEFINE l_str   LIKE imd_file.imd01    #No.FUN-680136 VARCHAR(10)
   DEFINE l_buf   LIKE pnz_file.pnz02   #MOD-8C0263 #FUN-930113
DEFINE l_pmkconu_desc LIKE gen_file.gen02  #No.FUN-870007
DEFINE l_pmkplant_desc LIKE azp_file.azp02 #No.FUN-870007
DEFINE l_pmk47_desc    LIKE azp_file.azp02 #No.FUN-870007
DEFINE l_ged02          LIKE ged_file.ged02  #TQC-BB0128
DEFINE l_pmk50_desc     LIKE azp_file.azp02  #FUN-CC0057 add

   LET g_pmk_t.* = g_pmk.*
   LET g_pmk_o.* = g_pmk.*
   DISPLAY BY NAME g_pmk.pmk01,g_pmk.pmk03,g_pmk.pmk04,g_pmk.pmk02, g_pmk.pmkoriu,g_pmk.pmkorig,
                   g_pmk.pmk09,g_pmk.pmk05,g_pmk.pmk49,g_pmk.pmk18,g_pmk.pmk20,  #FUN-810045 add pmk05  #No.FUN-830161  #FUN-A50071 add pmk49
                   g_pmk.pmk41,g_pmk.pmk10,g_pmk.pmk11,g_pmk.pmk12,
                   g_pmk.pmk13,g_pmk.pmk21,g_pmk.pmk43,g_pmk.pmk22,
                   g_pmk.pmk42,g_pmk.pmk45,g_pmk.pmkmksg,g_pmk.pmksign,
                   g_pmk.pmk25,g_pmk.pmk14,g_pmk.pmk15,g_pmk.pmk16,
                   g_pmk.pmk17,g_pmk.pmk30,g_pmk.pmkuser,g_pmk.pmkgrup,
                   g_pmk.pmkmodu,g_pmk.pmkdate,g_pmk.pmkacti,
                   g_pmk.pmk46,g_pmk.pmk47,g_pmk.pmk50,g_pmk.pmkcond,g_pmk.pmkconu,     #No.FUN-870007   #FUN-CC0057 add pmk50
                   g_pmk.pmkcrat,g_pmk.pmk48,g_pmk.pmkcont,g_pmk.pmkplant,  #No.FUN-870007
                   g_pmk.pmkud01,g_pmk.pmkud02,g_pmk.pmkud03,g_pmk.pmkud04,g_pmk.pmkud05,
                   g_pmk.pmkud06,g_pmk.pmkud07,g_pmk.pmkud08,g_pmk.pmkud09,g_pmk.pmkud10,
                   g_pmk.pmkud11,g_pmk.pmkud12,g_pmk.pmkud13,g_pmk.pmkud14,g_pmk.pmkud15
   IF g_azw.azw04 = '2' THEN
      IF NOT cl_null(g_pmk.pmkconu) THEN
         SELECT gen02 INTO l_pmkconu_desc FROM gen_file
          WHERE gen01 = g_pmk.pmkconu AND genacti = 'Y'
         DISPLAY l_pmkconu_desc TO pmkconu_desc
      ELSE
         CLEAR pmkconu_desc
      END IF
      SELECT azp02 INTO l_pmkplant_desc FROM azp_file
       WHERE azp01 = g_pmk.pmkplant
      SELECT azp02 INTO l_pmk47_desc FROM azp_file
       WHERE azp01 = g_pmk.pmk47
      DISPLAY l_pmk47_desc,l_pmkplant_desc
           TO pmk47_desc,pmkplant_desc
      #FUN-CC0057---add---str
      SELECT azp02 INTO l_pmk50_desc FROM azp_file
       WHERE azp01 = g_pmk.pmk50
      DISPLAY l_pmk50_desc TO pmk50_desc
      #FUN-CC0057---add---end
   END IF
   CALL t420_pic() #FUN-730012
   #TQC-BB0128--begin
    SELECT ged02 INTO l_ged02 FROM ged_file
     WHERE ged01=g_pmk.pmk16
    DISPLAY l_ged02 TO ged02
   #TQC-BB0128--end

   CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg)
                  RETURNING g_sta

   DISPLAY g_sta TO FORMONLY.desc2

   SELECT pnz02 INTO l_buf FROM pnz_file WHERE pnz01=g_pmk.pmk41 #FUN-930113 oah-->pnz
   DISPLAY l_buf TO FORMONLY.pnz02 #FUN-930113 oah-->pnz

   #單據別有做預管控管時，才顯示預算相關欄位 預算/部門/科目一/未稅單價/含稅單價
   CALL cl_set_comp_visible("pml67,pml40,pml31,pml31t",g_smy.smy59='Y')          #No.FUN-830161
   #單據別有做預算控管且有使用多套帳時才顯示科目二
   CALL cl_set_comp_visible("pml401",g_smy.smy59='Y' AND g_aza.aza63='Y')

   CALL t420_peo('d','1',g_pmk.pmk12)

   CALL t420_peo('d','2',g_pmk.pmk15)

   CALL t420_dep('d','1',g_pmk.pmk13)

   CALL t420_dep('d','2',g_pmk.pmk14)

   CALL t420_supplier('d','1',g_pmk.pmk09)

   CALL t420_supplier('d','2',g_pmk.pmk17)

   CALL t420_pmk20()

   CALL t420_pmk21()       #No.FUN-550019

   CALL t420_pmk22()       #No.FUN-550019

#FUN-B90101--add--begin
   CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
#FUN-B90101--add--begin
#FUN-B90101--add--end--
   CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

END FUNCTION

FUNCTION t420_b_fill(p_wc2,p_wc3)          #FUN-B90101 add 第二個參數，服飾中母單身的條件
   DEFINE p_wc2    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(200)
          l_cnt    LIKE type_file.num5,    #No.FUN-680136 SMALLINT
          l_name   LIKE type_file.chr4     #No.FUN-680136 VARCHAR(04)
#FUN-A60035 ---MARK BEGIN
##FUN-A60035 ---add begin
#   DEFINE l_pml02  DYNAMIC ARRAY OF RECORD
#          pml02    LIKE pml_file.pml02
#          END RECORD
#   DEFINE l_i      LIKE type_file.num5
#   DEFINE l_go     LIKE type_file.chr1
##FUN-A60035 ---add end
#FUN-A60035 ---MARK END

     DEFINE p_wc3    STRING                  #FUN-B90101 add

   IF cl_null(p_wc2) THEN
      LET p_wc2 = " 1=1"
   END IF
#&ifndef STD   #FUN-B901010 mark
#&else          #FUN-B901010 mark
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
      LET g_sql="SELECT pml02,pml24,pml25,'',pml47,pml04,'','','','','','','','','','','','','','','','','','','','','', ",  #NO.FUN-670007 ADD pml24/pml25 #No.FUN-870007-add-pml47
                "       pml041,ima021,pml07,pml48,'',pml49,pml50,pml51,pml52,pml53,pml54,pml20,",   #No.FUN-870007
                "       pml83,pml84,pml85,pml80,pml81,pml82,pml86,pml87,",
                "       pml21,pml35,pml34,pml33,pmlud02,pml919,pml55,pml41,",   #FUN-570106   #No.TQC-640132 #No.FUN-870007-add-pml55  #FUN-A80150 add pml919
                "       pml190,pml191,pml192,",     #No.FUN-630040
                "       pml92,pml93,",  #FUN-9A0065 add pml92,pml93
                "       pml12,pml121,pml122,",
                "       pml67,pml90,pml40,pml401,pml31,pml31t,",        #FUN-810045  #No.FUN-830161
                "       pml930,'',pml06,pml38,pml16,pml11,pml56,pml123,'',pml91,pml05 ",  #No.FUN-870007 #FUN-990080 add pml16 #FUN-B80167 add pml05
                "       ,pmlud01,pmlud03,pmlud04,pmlud05,",
                "       pmlud06,pmlud07,pmlud08,pmlud09,pmlud10,",
                "       pmlud11,pmlud12,pmlud13,pmlud14,pmlud15",
                " FROM pml_file,OUTER ima_file ",
                " WHERE pml01= '",g_pmk.pmk01,"' AND ",p_wc2 CLIPPED,
                "   AND pml_file.pml04=ima_file.ima01 ",
                " ORDER BY pml02 " CLIPPED
   PREPARE t420_pp FROM g_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('prepare:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF

   DECLARE t420_cs2 CURSOR FOR t420_pp

   CALL g_pml.clear()
   LET l_cnt=1
   FOREACH t420_cs2 INTO g_pml[l_cnt].*

      IF SQLCA.sqlcode THEN
         CALL cl_err('prepare2:',SQLCA.sqlcode,1) EXIT FOREACH
      END IF
      IF cl_null(g_pml[l_cnt].pml80) THEN
         LET g_pml[l_cnt].pml81 = NULL
         LET g_pml[l_cnt].pml82 = NULL
      END IF
      IF cl_null(g_pml[l_cnt].pml83) THEN
         LET g_pml[l_cnt].pml84 = NULL
         LET g_pml[l_cnt].pml85 = NULL
      END IF
      CALL t420_set_pml930(g_pml[l_cnt].pml930)
         RETURNING g_pml[l_cnt].gem02a #FUN-670051
       SELECT mse02 INTO g_pml[l_cnt].mse02
         FROM mse_file WHERE mse01=g_pml[l_cnt].pml123
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#      SELECT ata02,ata05 INTO g_pml[l_cnt].pml02,g_pml[l_cnt].pml04
#        FROM ata_file
#       WHERE ata00 = g_prog
#         AND ata01 = g_pmk.pmk01
#         AND ata03 = g_pml[l_cnt].pml02
#      LET l_pml02[l_pml02.getLength() + 1] = g_pml[l_cnt].pml02   #FUN-A60035 add
#      IF l_cnt > 1 THEN
#         #FUN-A60035 ---mark begin
#         #IF g_pml[l_cnt].pml02 = g_pml[l_cnt-1].pml02 THEN
#         #   CONTINUE FOREACH
#         #END IF
#         #FUN-A60035 ---mark end
#         #FUN-A60035 ---add begin
#                LET l_go = 'N'
#                FOR l_i = 1 TO l_pml02.getLength()-1
#                    IF g_pml[l_cnt].pml02 = l_pml02[l_i].pml02 THEN
#                       LET l_go = 'Y'
#                       EXIT FOR
#                    END IF
#                END FOR
#                IF l_go = 'Y' THEN
#                   CONTINUE FOREACH
#                END IF
#          #FUN-A60035 ---add end
#      END IF
#      SELECT SUM(ata08) INTO g_pml[l_cnt].pml20 from ata_file
#       WHERE ata00 = g_prog
#         AND ata01 = g_pmk.pmk01
#         AND ata02 = g_pml[l_cnt].pml02
#      #FUN-A60035 ---add begin
#      SELECT SUM(pml21) INTO g_pml[l_cnt].pml21 FROM pml_file
#       WHERE pml01 = g_pmk.pmk01
#         AND pml02 IN (SELECT ata03 FROM ata_file
#                          WHERE ata00 = g_prog
#                            AND ata01 = g_pmk.pmk01
#                            AND ata02 = g_pml[l_cnt].pml02)
#      #FUN-A60035 ---add end
#&else
##FUN-A50054 --End
#FUN-A60035 ---MARK END
      #如果進行料件多屬性管理并選擇新機制則要對單身顯示的東東進行更改
      IF g_sma.sma120 = 'Y' AND g_sma.sma907 = 'Y' THEN
         #得到該料件對應的父料件和所有屬性
         SELECT imx00,imx01,imx02,imx03,imx04,imx05,imx06,
                imx07,imx08,imx09,imx10 INTO
                g_pml[l_cnt].att00,g_pml[l_cnt].att01,g_pml[l_cnt].att02,
                g_pml[l_cnt].att03,g_pml[l_cnt].att04,g_pml[l_cnt].att05,
                g_pml[l_cnt].att06,g_pml[l_cnt].att07,g_pml[l_cnt].att08,
                g_pml[l_cnt].att09,g_pml[l_cnt].att10
         FROM imx_file WHERE imx000 = g_pml[l_cnt].pml04

         LET g_pml[l_cnt].att01_c = g_pml[l_cnt].att01
         LET g_pml[l_cnt].att02_c = g_pml[l_cnt].att02
         LET g_pml[l_cnt].att03_c = g_pml[l_cnt].att03
         LET g_pml[l_cnt].att04_c = g_pml[l_cnt].att04
         LET g_pml[l_cnt].att05_c = g_pml[l_cnt].att05
         LET g_pml[l_cnt].att06_c = g_pml[l_cnt].att06
         LET g_pml[l_cnt].att07_c = g_pml[l_cnt].att07
         LET g_pml[l_cnt].att08_c = g_pml[l_cnt].att08
         LET g_pml[l_cnt].att09_c = g_pml[l_cnt].att09
         LET g_pml[l_cnt].att10_c = g_pml[l_cnt].att10

      END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin add
#&endif
##FUN-A50054---end
#FUN-A60035 ---MARK END
      IF NOT cl_null(g_pml[l_cnt].pml48) THEN
         SELECT pmc03 INTO g_pml[l_cnt].pml48_desc FROM pmc_file
          WHERE pmc01=g_pml[l_cnt].pml48
      END IF
      LET l_cnt=l_cnt+1
      IF l_cnt > g_max_rec THEN     #No.FUN-870007
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL g_pml.deleteElement(l_cnt)
   LET g_rec_b=l_cnt - 1
#FUN-C20006--add--begin--
    DISPLAY g_rec_b TO FORMONLY.cn2
#FUN-C20006--add--end--
#FUN-C20006--mark-begin--
##FUN-B90101  add &ifndef SLK
#&ifndef SLK
#  DISPLAY g_rec_b TO FORMONLY.cn2
#&endif
##FUN-B90101 add &endif
#FUN-C20006--mark--end--
   CALL t420_refresh_detail()  #No.TQC-650108
END FUNCTION

#FUN-B90101--add--begin--
#FUN-B90101--add--end--

FUNCTION t420_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)
#FUN-C20006--mark--begin--
##FUN-B90101--add--begin--
#&ifdef SLK
#  DEFINE l_i        LIKE type_file.num5,
#         l_index    LIKE type_file.num5
#&endif
##FUN-B90101--add--end--
#FUN-C20006--mark--end--

    IF p_ud <> "G" OR g_action_choice = "detail" THEN
       RETURN
    END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
#FUN-B90101---Add---Str--
   DIALOG ATTRIBUTES(UNBUFFERED)

#FUN-C20006--mark--begin--
#&ifdef SLK
#     DISPLAY ARRAY g_pmlslk TO s_pmlslk.*
#        BEFORE DISPLAY
#           CALL cl_navigator_setting( g_curs_index, g_row_count )
#           CALL g_imx.clear()
#           CALL t420_b_fill2(g_wc3,g_wc2)
#           LET g_action_choice=""

#        BEFORE ROW
#           CALL cl_set_comp_visible("color",FALSE)
#           FOR l_i = 1 TO 15
#               LET l_index = l_i USING '&&'
#               CALL cl_set_comp_visible("imx" || l_index,FALSE)
#           END FOR
#           LET l_ac2 = DIALOG.getCurrentRow("s_pmlslk")
#           IF l_ac2 != 0 THEN
#              CALL s_settext_slk(g_pmlslk[l_ac2].pmlslk04)
#              CALL s_fillimx_slk(g_pmlslk[l_ac2].pmlslk04,
#                                  g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#              LET g_rec_b3 = g_imx.getLength()
#           END IF
#     END DISPLAY

#     DISPLAY ARRAY g_imx TO s_imx.*
#        BEFORE DISPLAY
#           CALL cl_navigator_setting( g_curs_index, g_row_count )
#           LET g_action_choice=""

#        BEFORE ROW
#           LET l_ac3 = DIALOG.getCurrentRow("s_imx")
#           CALL cl_show_fld_cont()
#     END DISPLAY
#&endif
##FUN-B90101---Add---End--
#FUN-C20006--mark--end--

  #DISPLAY ARRAY g_pml TO s_pml.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)   #FUN-B90101---mark---
   DISPLAY ARRAY g_pml TO s_pml.*                                       #FUN-B90101---Add---
   BEFORE DISPLAY
      CALL cl_navigator_setting( g_curs_index, g_row_count )
      IF g_sma.sma901 != 'Y' THEN
          CALL cl_set_act_visible("aps_related_data",FALSE)
      END IF
       LET g_action_choice=""   #No.MOD-490256
       LET g_b_flag = '1'       #TQC-D40025

      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
#FUN-B90101--mark--
#      ON ACTION insert
#         LET g_action_choice="insert"
#         EXIT DISPLAY
#
#      ON ACTION query
#         LET g_action_choice="query"
#         EXIT DISPLAY
#
#      ON ACTION delete
#         LET g_action_choice="delete"
#         EXIT DISPLAY
#
#      ON ACTION modify
#         LET g_action_choice="modify"
#         EXIT DISPLAY
#
#      ON ACTION first
#         CALL t420_fetch('F')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         CALL fgl_set_arr_curr(1)
#         ACCEPT DISPLAY   #FUN-530067(smin)
#
#      ON ACTION previous
#         CALL t420_fetch('P')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         CALL fgl_set_arr_curr(1)
#         ACCEPT DISPLAY   #FUN-530067(smin)
#
#      ON ACTION jump
#         CALL t420_fetch('/')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         CALL fgl_set_arr_curr(1)
#         ACCEPT DISPLAY   #FUN-530067(smin)
#
#      ON ACTION next
#         CALL t420_fetch('N')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         CALL fgl_set_arr_curr(1)
#         ACCEPT DISPLAY   #FUN-530067(smin)
#
#      ON ACTION last
#         CALL t420_fetch('L')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         CALL fgl_set_arr_curr(1)
#         ACCEPT DISPLAY   #FUN-530067(smin)
#
#      ON ACTION reproduce
#         LET g_action_choice="reproduce"
#         EXIT DISPLAY
#      ON ACTION detail
#         LET g_action_choice="detail"
#         LET l_ac = 1
#         EXIT DISPLAY
#      ON ACTION output
#         LET g_action_choice="output"
#         EXIT DISPLAY
#      ON ACTION help
#         LET g_action_choice="help"
#         EXIT DISPLAY
#
#      ON ACTION locale
#         CALL cl_dynamic_locale()
#         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
#         CALL t420_def_form()   #FUN-610067
#         IF g_aza.aza71 MATCHES '[Yy]' THEN
#            CALL aws_gpmcli_toolbar()
#            CALL cl_set_act_visible("gpm_show,gpm_query", TRUE)
#         ELSE
#            CALL cl_set_act_visible("gpm_show,gpm_query", FALSE)  #N0.TQC-710042
#         END IF
#         CALL t420_pic() #FUN-730012
#         EXIT DISPLAY
#
#      ON ACTION exit
#         LET g_action_choice="exit"
#         EXIT DISPLAY
#
#      ON ACTION controlg
#         LET g_action_choice="controlg"
#         EXIT DISPLAY
#
#    #@ON ACTION MRP查詢
#      ON ACTION query_mrp
#         LET g_action_choice="query_mrp"
#         EXIT DISPLAY
#
#    #@ON ACTION 採購查詢
#      ON ACTION qry_po_status
#         LET g_action_choice="qry_po_status"
#         EXIT DISPLAY
#
#    #@ON ACTION 簽核狀況
#      ON ACTION approval_status
#         LET g_action_choice="approval_status"
#         EXIT DISPLAY
#
#    #FUN-B30082----ADD----START----
#    #@ON ACTION 變更狀況
#      ON ACTION modify_status
#         LET g_action_choice="modify_status"
#         EXIT DISPLAY
#    #FUN-B30082----ADD-----END-----
#
#    #@ON ACTION 備註
#      ON ACTION memo
#         LET g_action_choice="memo"
#         EXIT DISPLAY
#
#    #@ON ACTION 特別說明
#      ON ACTION special_description
#         LET g_action_choice="special_description"
#         EXIT DISPLAY
#
#    #@ON ACTION easyflow送簽
#      ON ACTION easyflow_approval         #FUN-550038
#         LET g_action_choice = "easyflow_approval"
#         EXIT DISPLAY
#
#    #@ON ACTION 確認
#      ON ACTION confirm
#         LET g_action_choice="confirm"
#         EXIT DISPLAY
#
#    #@ON ACTION 取消確認
#      ON ACTION undo_confirm
#         LET g_action_choice="undo_confirm"
#         EXIT DISPLAY
#
#    #@ON ACTION 作廢
#      ON ACTION void
#         LET g_action_choice="void"
#         EXIT DISPLAY
#
#      ON ACTION accept
#         LET g_action_choice="detail"
#         LET l_ac = ARR_CURR()
#         EXIT DISPLAY
#
#      ON ACTION cancel
#             LET INT_FLAG=FALSE                 #MOD-570244     mars
#         LET g_action_choice="exit"
#         EXIT DISPLAY
#
#      ON IDLE g_idle_seconds
#         CALL cl_on_idle()
#         CONTINUE DISPLAY
#
#      ON ACTION about         #MOD-4C0121
#         CALL cl_about()      #MOD-4C0121
#
#
#      ON ACTION exporttoexcel       #FUN-4B0025
#         LET g_action_choice = 'exporttoexcel'
#         EXIT DISPLAY
#      ON ACTION agree
#         LET g_action_choice = 'agree'
#         EXIT DISPLAY
#
#      ON ACTION deny
#         LET g_action_choice = 'deny'
#         EXIT DISPLAY
#
#      ON ACTION modify_flow
#         LET g_action_choice = 'modify_flow'
#         EXIT DISPLAY
#
#      ON ACTION withdraw
#         LET g_action_choice = 'withdraw'
#         EXIT DISPLAY
#
#      ON ACTION org_withdraw
#         LET g_action_choice = 'org_withdraw'
#         EXIT DISPLAY
#
#      ON ACTION phrase
#         LET g_action_choice = 'phrase'
#         EXIT DISPLAY
#      ON ACTION e_proc_require
#         LET g_action_choice = 'e_proc_require'
#         EXIT DISPLAY
##FUN-A60035 ---MARK BEGIN
##&ifdef SLK
###FUN-A50054 ---Begin add
##      ON ACTION style_detail
##         LET g_action_choice = 'style_detail'
##         EXIT DISPLAY
###FUN-A50054---End
##&endif
##FUN-A60035 ---MARK END
#      AFTER DISPLAY
#         CONTINUE DISPLAY
#
#      ON ACTION controls                           #No.FUN-6B0032
#         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032
#
#      ON ACTION related_document                #No.FUN-6A0162  相關文件
#         LET g_action_choice="related_document"
#         EXIT DISPLAY
#
#      ON ACTION gpm_show
#         LET g_action_choice="gpm_show"
#         EXIT DISPLAY
#
#      ON ACTION gpm_query
#         LET g_action_choice="gpm_query"
#         EXIT DISPLAY
#
#      ON ACTION aps_related_data
#         LET g_action_choice = 'aps_related_data'
#         EXIT DISPLAY
#
##      &include "qry_string.4gl"          #MOD-B30150 mark
#FUN-B90101--mark--
   END DISPLAY

      #FUN-CB0014---add---str---
      ON ACTION page_list
         LET g_action_flag = "page_list"
         EXIT DIALOG
      #FUN-CB0014---add---end---
#FUN-B90101--add--begin--
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DIALOG

      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG

      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DIALOG

      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DIALOG

      ON ACTION first
         CALL t420_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   #FUN-530067(smin)

      ON ACTION previous
         CALL t420_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   #FUN-530067(smin)

      ON ACTION jump
         CALL t420_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   #FUN-530067(smin)

      ON ACTION next
         CALL t420_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   #FUN-530067(smin)

      ON ACTION last
         CALL t420_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         CALL fgl_set_arr_curr(1)
         ACCEPT DIALOG   #FUN-530067(smin)

      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DIALOG
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DIALOG
      ON ACTION output
         LET g_action_choice="output"
         EXIT DIALOG
      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         CALL t420_def_form()   #FUN-610067
         IF g_aza.aza71 MATCHES '[Yy]' THEN
            CALL aws_gpmcli_toolbar()
            CALL cl_set_act_visible("gpm_show,gpm_query", TRUE)
         ELSE
            CALL cl_set_act_visible("gpm_show,gpm_query", FALSE)  #N0.TQC-710042
         END IF
         CALL t420_pic() #FUN-730012
         EXIT DIALOG

#FUN-C20006--mark--begin--
#&ifdef SLK
#     ON ACTION controlb
#        IF li_a THEN
#           LET li_a = FALSE
#           NEXT FIELD pmlslk04
#        ELSE
#           LET li_a = TRUE
#           NEXT FIELD color
#        END IF
#&endif
#FUN-C20006--mark--end--

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG

      ON ACTION mod_date
         LET g_action_choice="mod_date"
         EXIT DIALOG

    #@ON ACTION MRP查詢
      ON ACTION query_mrp
         LET g_action_choice="query_mrp"
         EXIT DIALOG

    #@ON ACTION 採購查詢
      ON ACTION qry_po_status
         LET g_action_choice="qry_po_status"
         EXIT DIALOG

    #@ON ACTION 簽核狀況
      ON ACTION approval_status
         LET g_action_choice="approval_status"
         EXIT DIALOG

    #FUN-B30082----ADD----START----
    #@ON ACTION 變更狀況
      ON ACTION modify_status
         LET g_action_choice="modify_status"
         EXIT DIALOG
    #FUN-B30082----ADD-----END-----

    #@ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DIALOG

    #@ON ACTION 特別說明
      ON ACTION special_description
         LET g_action_choice="special_description"
         EXIT DIALOG

    #@ON ACTION easyflow送簽
      ON ACTION easyflow_approval         #FUN-550038
         LET g_action_choice = "easyflow_approval"
         EXIT DIALOG

    #@ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DIALOG

    #@ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DIALOG

    #@ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DIALOG
#FUN-D20025 add
    #@ON ACTION 取消作廢
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DIALOG
#FUN-D20025 add
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION exporttoexcel       #FUN-4B0025
         LET g_action_choice = 'exporttoexcel'
         EXIT DIALOG
      ON ACTION agree
         LET g_action_choice = 'agree'
         EXIT DIALOG

      ON ACTION deny
         LET g_action_choice = 'deny'
         EXIT DIALOG

      ON ACTION modify_flow
         LET g_action_choice = 'modify_flow'
         EXIT DIALOG

      ON ACTION withdraw
         LET g_action_choice = 'withdraw'
         EXIT DIALOG

      ON ACTION org_withdraw
         LET g_action_choice = 'org_withdraw'
         EXIT DIALOG

      ON ACTION phrase
         LET g_action_choice = 'phrase'
         EXIT DIALOG
      ON ACTION e_proc_require
         LET g_action_choice = 'e_proc_require'
         EXIT DIALOG
#FUN-A60035 ---MARK BEGIN
#&ifdef SLK
##FUN-A50054 ---Begin add
#      ON ACTION style_detail
#         LET g_action_choice = 'style_detail'
#         EXIT DIALOG
##FUN-A50054---End
#&endif
#FUN-A60035 ---MARK END

      ON ACTION controls                           #No.FUN-6B0032
         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032

      ON ACTION related_document                #No.FUN-6A0162  相關文件
         LET g_action_choice="related_document"
         EXIT DIALOG

      ON ACTION gpm_show
         LET g_action_choice="gpm_show"
         EXIT DIALOG

      ON ACTION gpm_query
         LET g_action_choice="gpm_query"
         EXIT DIALOG

      ON ACTION aps_related_data
         LET g_action_choice = 'aps_related_data'
         EXIT DIALOG

      ON ACTION EXIT
         LET g_action_choice = "EXIT"
         EXIT DIALOG

      ON ACTION accept
         LET g_action_choice="detail"
#&ifndef SLK                    #FUN-C20006--mark--
         LET l_ac = ARR_CURR()
#&endif                         #FUN-C20006--mark--
         EXIT DIALOG
      ON ACTION cancel
         LET INT_FLAG = TRUE
         LET g_action_choice = "EXIT"
         EXIT DIALOG
   END DIALOG
#FUN-B90101--add--end--
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#FUN-C20006--add--begin--
#FUN-C20006--add--end--

FUNCTION t420_u()
    DEFINE  l_pml02  LIKE pml_file.pml02
    DEFINE  l_first  LIKE type_file.chr1   #FUN-6A0153 add
    DEFINE  l_update LIKE type_file.chr1   #FUN-6A0153 add

    IF s_shut(0) THEN RETURN END IF
   #IF g_pmk.pmk01 IS NULL THEN CALL cl_err('',-420,0) RETURN END IF
   #IF g_pmk.pmk01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF   #TQC-C10020 #MOD-BA0139 mark
    IF g_pmk.pmk01 IS NULL THEN CALL cl_err('',-400,1) RETURN END IF   #MOD-BA0139 add
    SELECT * INTO g_pmk.* FROM pmk_file
     WHERE pmk01=g_pmk.pmk01
    IF g_pmk.pmk25 MATCHES'[69]' THEN CALL cl_err('','mfg3262',0) RETURN END IF
    IF g_pmk.pmk18 = 'Y' THEN CALL cl_err('','axm-101',0) RETURN END IF
    IF g_pmk.pmk18 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    IF g_pmk.pmk25 matches '[Ss]' THEN          #FUN-550038
         CALL cl_err('','apm-030',0)
         RETURN
    END IF

    #已發出轉請購單僅可"已發出採購單作業"才可更改
    IF g_argv2 matches '[01]' AND g_pmk.pmk25='2' THEN
       CALL cl_err('','mfg9118',0)
       RETURN
    END IF
   #在未核淮採購單維護作業下已核淮資料不可更改    #加條件pmkmksg by Keith
    IF  (g_argv2 ='1'  AND g_pmk.pmk18 = 'Y' AND g_pmk.pmk25 !='1' ) OR  #FUN-550038
        (g_argv2 = '0' AND g_pmk.pmk18 = 'Y' AND g_pmk.pmkmksg = 'Y' AND g_pmk.pmk25 = '1')
    THEN CALL cl_err('','mfg3168',0)
         RETURN
    END IF
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_pmk01_t = g_pmk.pmk01
    BEGIN WORK
    LET g_success = 'Y'  #No.FUN-8A0086
    OPEN t420_cl USING g_pmk.pmk01
    IF STATUS THEN
       CALL cl_err("OPEN t420_cl:", STATUS, 1)
       CLOSE t420_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
        CLOSE t420_cl
        ROLLBACK WORK
        RETURN
    END IF
    LET g_pmk.pmkmodu=g_user                     #修改者
    LET g_pmk.pmkdate = g_today                  #修改日期
    CALL t420_show()                             # 顯示最新資料
    WHILE TRUE
        LET g_pmk_o.* = g_pmk.*
        CALL t420_i("u")                         # 欄位更改
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_pmk.*=g_pmk_t.*
            CALL t420_show()
            CALL cl_err('',9001,0)
            EXIT WHILE
        END IF
        IF g_pmk.pmkmksg  MATCHES'[Yy]'  THEN
           IF g_argv2='1' THEN #為巳核准
              IF g_sma.sma77 = '2' THEN #不可重簽
                 CALL cl_err('','mfg6144',0)
                 CALL s_signm(6,34,g_lang,'2',g_pmk.pmk01,2,g_pmk.pmksign,
                      g_pmk.pmkdays,g_pmk.pmkprit,g_pmk.pmksmax,g_pmk.pmksseq)
              ELSE  #可重簽
                 CALL s_signm(6,34,g_lang,'1',g_pmk.pmk01,2,g_pmk.pmksign,
                      g_pmk.pmkdays,g_pmk.pmkprit,g_pmk.pmksmax,g_pmk.pmksseq)
                 RETURNING g_pmk.pmksign,       #等級
                           g_pmk.pmkdays,
                           g_pmk.pmkprit,
                           g_pmk.pmksmax,       #應簽
                           g_pmk.pmksseq,       #已簽
                           g_statu
                 #重簽的處理1:將巳簽歸零2:過程檔delete 3:狀況碼為開立
                 LET g_pmk.pmksseq = 0
                 LET g_pmk.pmk25   = '0'
                 DELETE FROM azd_file WHERE azd01 = g_pmk.pmk01 AND
                                            azd02 = 2
             END IF
          END IF
        END IF
        LET g_pmk.pmk25 = '0'        #FUN-550038
        UPDATE pmk_file SET pmk_file.* = g_pmk.*    # 更新DB
            WHERE pmk01 = g_pmk.pmk01             # COLAUTH?
        IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660129
            CONTINUE WHILE
        END IF
        IF g_pmk.pmk01 != g_pmk_t.pmk01 THEN
           UPDATE pml_file SET pml01=g_pmk.pmk01 WHERE pml01=g_pmk_t.pmk01
           IF STATUS THEN
              CALL cl_err3("upd","pml_file",g_pmk_t.pmk01,"",STATUS,"","upd pml01",1)  #No.FUN-660129
              ROLLBACK WORK RETURN
           END IF
        END IF
        #No.MOD-C80183  --Begin
        IF g_smy.smy59 <> 'Y' THEN
           IF g_pmk.pmk13 != g_pmk_t.pmk13 THEN
              UPDATE pml_file SET pml67=g_pmk.pmk13 WHERE pml01=g_pmk_t.pmk01
              IF STATUS THEN
                 CALL cl_err3("upd","pml_file",g_pmk_t.pmk01,"",STATUS,"","upd pml67",1)
                 ROLLBACK WORK RETURN
              END IF
           END IF
        END IF
        #No.MOD-C80183  --End

        #---更改單身狀況
          DECLARE t420_stat CURSOR FOR SELECT pml02 FROM pml_file
                           WHERE pml01 = g_pmk.pmk01
          IF NOT SQLCA.sqlcode THEN
             LET l_first = 'Y'   #FUN-6A0153 add
             LET l_update= 'Y'   #FUN-6A0153 add
             CALL s_showmsg_init()        #No.FUN-710030
             FOREACH t420_stat INTO l_pml02
                  IF g_success="N" THEN
                     LET g_totsuccess="N"
                     LET g_success="Y"
                  END IF

               #當單頭的pmk45改成N時,要將單身所有的pml38全部改成N
                IF g_pmk.pmk45 != g_pmk_t.pmk45 THEN
                   IF g_pmk.pmk45='N' THEN
                      UPDATE pml_file SET pml16 = g_pmk.pmk25,
                                          pml011= g_pmk.pmk02,
                                          pml38 = 'N'
                                    WHERE pml01 = g_pmk.pmk01 AND pml02 = l_pml02
                   ELSE   #g_pmk.pmk45='Y'
                      IF l_first = 'Y' THEN
                         IF cl_confirm('apm-580') THEN
                            LET l_first = 'N'   #FUN-6A0153 add
                            LET l_update= 'Y'   #FUN-6A0153 add
                            UPDATE pml_file SET pml16 = g_pmk.pmk25,
                                                pml011= g_pmk.pmk02,
                                                pml38 = 'Y'
                                          WHERE pml01 = g_pmk.pmk01
                                            AND pml02 = l_pml02
                         ELSE
                            LET l_first = 'N'   #FUN-6A0153 add
                            LET l_update= 'N'   #FUN-6A0153 add
                         END IF
                      ELSE
                         IF l_update = 'Y' THEN
                            UPDATE pml_file SET pml16 = g_pmk.pmk25,
                                                pml011= g_pmk.pmk02,
                                                pml38 = 'Y'
                                          WHERE pml01 = g_pmk.pmk01
                                            AND pml02 = l_pml02
                         END IF
                      END IF
                   END IF
                ELSE
                  UPDATE pml_file SET pml16 = g_pmk.pmk25,
                                      pml011= g_pmk.pmk02
                               WHERE pml01 = g_pmk.pmk01 AND pml02 = l_pml02
                END IF   #FUN-690047 add
                IF SQLCA.sqlcode THEN
                   LET g_success = 'N'
                   IF g_bgerr THEN
                      LET g_showmsg = g_pmk.pmk01,"/",l_pml02
                      CALL s_errmsg("pml01,pml02",g_showmsg,"",SQLCA.sqlcode,1)
                      CONTINUE FOREACH
                   ELSE
                      CALL cl_err3("upd","pml_file",g_pmk.pmk01,l_pml02,SQLCA.sqlcode,"","",1)
                   END IF
                END IF
             END FOREACH
             IF g_totsuccess="N" THEN
                LET g_success="N"
             END IF
          END IF
         EXIT WHILE
    END WHILE
    CLOSE t420_cl
    DISPLAY BY NAME g_pmk.pmk25
    CALL t420_pic() #FUN-730012

    CALL s_showmsg()       #No.FUN-710030
    IF g_success = 'N' THEN
       ROLLBACK WORK
       LET g_success = 'Y'
    ELSE
       COMMIT WORK
    END IF
    CALL t420_show()                             # 顯示最新資料   #FUN-690047 add
    CALL cl_flow_notify(g_pmk.pmk01,'U')
END FUNCTION

FUNCTION t420_r()
   DEFINE  l_pml      RECORD
           pml12      LIKE pml_file.pml12,
           pml121     LIKE pml_file.pml121,
           pml122     LIKE pml_file.pml122
           END RECORD,
           l_azo      RECORD LIKE azo_file.*
    DEFINE l_chr,l_sure LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)
    DEFINE l_pml20      LIKE pml_file.pml20    #MOD-530190
    DEFINE l_cmd        LIKE type_file.chr1000 #No.FUN-720043 add
    DEFINE l_pml02      LIKE pml_file.pml02    #CHI-840016
    DEFINE l_oeb01      LIKE oeb_file.oeb01    #NO.FUN-B90101
    DEFINE l_oeb28      LIKE oeb_file.oeb28    #MOD-C80135
    DEFINE l_pml24      LIKE pml_file.pml24    #MOD-C80135
    DEFINE l_pml25      LIKE pml_file.pml25    #MOD-C80135
    DEFINE l_sql        STRING                 #MOD-C80135
    DEFINE   l_pml41   LIKE pml_file.pml41  #MOD-D20125
    DEFINE   l_str     STRING  #MOD-D20125
    DEFINE   l_mss_v   LIKE mss_file.mss_v  #MOD-D20125

    IF s_shut(0) THEN RETURN END IF
    IF g_pmk.pmk01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_pmk.* FROM pmk_file
     WHERE pmk01=g_pmk.pmk01
    IF g_pmk.pmk18 = 'Y' THEN CALL cl_err('','axm-101',0) RETURN END IF
    IF g_pmk.pmk18 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    IF g_pmk.pmk25 matches '[Ss1]' THEN          #FUN-550038
       CALL cl_err("","mfg3557",0)
       RETURN
    END IF
    IF g_pmk.pmkacti='N' THEN
       CALL cl_err('','art-264',0)
       RETURN
    END IF
    IF g_pmk.pmk46 = '2' AND g_azw.azw04 = '2'  THEN  #TQC-AC0337
       CALL cl_err('','apm1052',1)                    #TQC-AC0337
       RETURN                                         #TQC-AC0337
    END IF                                            #TQC-AC0337
    IF g_azw.azw04 = '2' AND g_pmk.pmk46 != '1' THEN
       CALL cl_err('','apm1023',1)
       RETURN
    END IF
    SELECT COUNT(*) INTO g_cnt FROM pml_file
           WHERE pml01=g_pmk.pmk01 AND pml21 > 0
    IF g_cnt > 0 THEN CALL cl_err('','mfg9118',0) RETURN END IF

    BEGIN WORK
    LET g_success = 'Y'  #No.FUN-8A0086
    OPEN t420_cl USING g_pmk.pmk01
    IF STATUS THEN
       CALL cl_err("OPEN t420_cl:", STATUS, 1)
       CLOSE t420_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t420_cl INTO g_pmk.*
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0) ROLLBACK WORK RETURN
    END IF
    CALL t420_show()
    IF cl_delh(20,16) THEN
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "pmk01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_pmk.pmk01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                            #No.FUN-9B0098 10/02/24
       MESSAGE "Delete pmk,pml"
       DELETE FROM pmk_file WHERE pmk01 = g_pmk.pmk01
       IF SQLCA.SQLERRD[3]=0 THEN
          CALL cl_err3("del","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","No pmk deleted",1)  #No.FUN-660129
          ROLLBACK WORK RETURN
       END IF
       #MOD-D20125---begin
       DECLARE pml41_c1 CURSOR FOR
                        SELECT pml41 FROM pml_file WHERE pml01 = g_pmk.pmk01
                                                     AND pml41 IS NOT NULL  #TQC-D30025

       FOREACH pml41_c1 INTO l_pml41
           LET l_str = l_pml41
           LET l_mss_v = l_pml41[1,l_str.getIndexOf('-',1)-1]
           UPDATE mss_file
              SET mss10 = 'N'
            WHERE mss_v = l_mss_v
       END FOREACH
       #MOD-D20125---end
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
      #MOD-C80135 -- mark start --
      #UPDATE oeb_file set oeb27 = NULL,
      #                    oeb28 = 0
      #              WHERE oeb27 = g_pmk.pmk01
      #IF SQLCA.sqlcode THEN
      #     CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","NO pmk deleted from Order",0)
      #     ROLLBACK WORK RETURN
      #END IF
      #MOD-C80135 -- mark end --
      ##MOD-C80135 -- add start --
       LET l_sql = "SELECT * FROM oeb_file WHERE oeb01 = ?  AND oeb03 = ? FOR UPDATE"
       LET l_sql=cl_forupd_sql(l_sql)
       DECLARE t420y1_cl CURSOR FROM l_sql

       LET l_sql = "SELECT pml24,pml25,pml20 FROM pml_file ",
                   " WHERE pml01='",g_pmk.pmk01,"'"
       DECLARE t420y2_cl CURSOR FROM l_sql

       FOREACH t420y2_cl INTO l_pml24,l_pml25,l_pml20
          IF SQLCA.sqlcode THEN
             CALL cl_err3("sel","pml_file",g_pmk.pmk01,"",STATUS,"","foreach",1)
             LET g_success='N'
             EXIT FOREACH
          END IF
          OPEN t420y1_cl USING l_pml24,l_pml25 #check DB 是否被他人鎖定
          IF STATUS THEN
             LET g_success = 'N'
             CALL cl_err("OPEN t420y1_cl:", STATUS, 1)
             CLOSE t420y1_cl
             RETURN
          END IF
          CLOSE t420y1_cl  #無被鎖定就可以CLOSE
          SELECT SUM(oeb28) INTO l_oeb28 FROM oeb_file WHERE oeb01= l_pml24 AND oeb03 = l_pml25
          LET l_oeb28 = l_oeb28 - l_pml20
          IF l_oeb28 <= 0 THEN
             LET l_oeb28 = 0
          END IF
          UPDATE oeb_file set oeb27 = NULL,
                              oeb28 = l_oeb28
                        WHERE oeb27 = g_pmk.pmk01
          IF SQLCA.sqlcode THEN
               CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","NO pmk deleted from Order",0)
               ROLLBACK WORK RETURN
          END IF
       END FOREACH
       #MOD-C80135 --add end--

   DECLARE t420_r1_c CURSOR FOR
      SELECT pml12,pml121,pml122 FROM pml_file
       WHERE pml01=g_pmk.pmk01
         AND ( pml12 IS NOT NULL OR pml12 !=' ')
         AND pml121 IS NOT NULL
          AND pml121 != 0       #MOD-530199
         AND pml122 IS NOT NULL
          AND pml122 != 0       #MOD-530199
   CALL s_showmsg_init()        #No.FUN-710030
   FOREACH t420_r1_c INTO l_pml.*
      IF g_success="N" THEN
         LET g_totsuccess="N"
         LET g_success="Y"
      END IF
      #pjf_file 已不記錄已轉請購量，所以不用更新
   END FOREACH
   IF g_totsuccess="N" THEN
      LET g_success="N"
   END IF

       IF g_sma.sma901 = 'Y' THEN
           LET l_cmd = " DELETE FROM vmz_file ",
                       "  WHERE vmz01 MATCHES '",g_pmk.pmk01,"*'"
           PREPARE t420_del_aps_spm FROM l_cmd
           EXECUTE t420_del_aps_spm
           IF SQLCA.sqlcode THEN
               CALL cl_err3("del","vmz_file",g_pmk.pmk01,'',SQLCA.sqlcode,"","",1)
               ROLLBACK WORK
               RETURN
           END IF
       END IF
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
       DELETE FROM pml_file WHERE pml01 = g_pmk.pmk01
       #add by lanhang 131129 删除请购单回写cpmp300 begin
       UPDATE tc_oed_file SET tc_oed10='N',tc_oed11='' WHERE tc_oed11=g_pmk.pmk01 AND tc_oed10='Y'
       #add by lanhang 131129 end

#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#       DELETE FROM ata_file WHERE ata00=g_prog AND ata01=g_pmk.pmk01  #FUN-A50054
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
       DELETE FROM pmo_file WHERE pmo01 = g_pmk.pmk01
       DELETE FROM pmp_file WHERE pmp01 = g_pmk.pmk01
       LET g_cnt = 0
       SELECT COUNT(*) INTO g_cnt FROM oea_file WHERE oea40 = g_pmk.pmk01
       IF SQLCA.sqlcode OR STATUS THEN LET g_cnt = 0 END IF
       IF g_cnt > 0 THEN
          UPDATE oea_file SET oea40 = '' WHERE oea40 = g_pmk.pmk01
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] <> 1 THEN
             LET g_success = 'N'
             IF g_bgerr THEN
                CALL s_errmsg("oea40",g_pmk.pmk01,"upd oea",SQLCA.sqlcode,1)
             ELSE
                CALL cl_err3("upd","oea_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","upd oea",1)
             END IF
          END IF
       END IF
       LET g_msg=TIME
        INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal) #FUN-980006 add azoplant,azolegal
           VALUES ('apmt420',g_user,g_today,g_msg,g_pmk.pmk01,'delete',g_plant,g_legal) #FUN-980006 add g_plant,g_legal
        SELECT * INTO l_azo.* FROM azo_file
         WHERE azo01='apmt420'
           AND azo02=g_user
           AND azo03=g_today
           AND azo04=g_msg
           AND azo05=g_pmk.pmk01
           AND azo06='delete'
        CLEAR FORM
        CALL g_pml.clear()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
        INITIALIZE g_pmk.* TO NULL
        MESSAGE ""
        OPEN t420_count
        #FUN-B50063-add-start--
        IF STATUS THEN
           CLOSE t420_cs
           CLOSE t420_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50063-add-end--
        FETCH t420_count INTO g_row_count
        #FUN-B50063-add-start--
        IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
           CLOSE t420_cs
           CLOSE t420_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50063-add-end--
        DISPLAY g_row_count TO FORMONLY.cnt
        OPEN t420_cs
        IF g_curs_index = g_row_count + 1 THEN
           LET g_jump = g_row_count
           CALL t420_fetch('L')
        ELSE
           LET g_jump = g_curs_index
           LET mi_no_ask = TRUE
           CALL t420_fetch('/')
        END IF
    END IF
    CLOSE t420_cl
    CALL s_showmsg()       #No.FUN-710030
    IF g_success = 'N' THEN
       ROLLBACK WORK
       LET g_success = 'Y'
    ELSE
       COMMIT WORK
    END IF
    CALL cl_flow_notify(g_pmk.pmk01,'D')
END FUNCTION

FUNCTION t420_sign(p_cmd)
  DEFINE     p_cmd    LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(1)
              l_slip   LIKE oay_file.oayslip,  #No.FUN-680136 VARCHAR(05)   #No.MOD-540182
             l_pmksign   LIKE pmk_file.pmksign

 IF cl_null(g_pmk.pmk01) THEN RETURN END IF
 IF g_pmk.pmkmksg MATCHES'[nN]' OR g_pmk.pmk25 matches'[269]'
 THEN RETURN
 END IF
 LET g_pmk.pmkdays = g_smy.smydays   #1999/04/21 add by Carol
 IF p_cmd = 'a' OR g_argv2 matches'[0X]' THEN
    LET l_pmksign = ' '
    IF p_cmd = 'b' THEN
       LET g_smy.smyatsg=' '
       LET l_slip = g_pmk.pmk01[1,g_doc_len]
       SELECT smyatsg INTO g_smy.smyatsg FROM smy_file
                     WHERE smyslip = l_slip
       SELECT pmksign INTO l_pmksign FROM pmk_file WHERE pmk01 = g_pmk.pmk01
    END IF
    IF g_smy.smyatsg matches'[Yy]' THEN   #自動賦予簽核等級
       CALL s_sign(g_pmk.pmk01,2,'pmk01','pmk_file') RETURNING g_pmk.pmksign
    END IF
    CALL signm_count(g_pmk.pmksign) RETURNING g_pmk.pmksmax
    IF l_pmksign != g_pmk.pmksign THEN
        UPDATE pmk_file SET pmksign = g_pmk.pmksign,
                            pmksmax = g_pmk.pmksmax,
                            pmkdays = g_pmk.pmkdays,
                            pmkprit = g_pmk.pmkprit,
                            pmksseq = 0
                        WHERE pmk01 = g_pmk.pmk01
        DELETE FROM azd_file WHERE azd01 = g_pmk.pmk01 AND azd02 = 2
    END IF
 ELSE
    IF g_argv2 = '1' THEN  #已核准P/R
        #重簽的處理1:將巳簽歸零2:過程檔delete 3:狀況碼為開立
        #如為自動符予簽核等級則要重新來過
       IF g_sma.sma77 = '1' THEN  #需重簽
          LET g_smy.smyatsg = ' '
          LET l_slip = g_pmk.pmk01[1,g_doc_len]
          SELECT smyatsg INTO g_smy.smyatsg FROM smy_file
                        WHERE smyslip = l_slip
          IF g_smy.smyatsg matches'[Yy]' THEN
             CALL s_sign(g_pmk.pmk01,2,'pmk01','pmk_file')
             RETURNING l_pmksign
          ELSE CALL s_signm(6,34,g_lang,'1',g_pmk.pmk01,2,g_pmk.pmksign,
                   g_pmk.pmkdays,g_pmk.pmkprit,g_pmk.pmksmax,g_pmk.pmksseq)
                            RETURNING l_pmksign,       #等級
                                      g_pmk.pmkdays,
                                      g_pmk.pmkprit,
                                      g_pmk.pmksmax,       #應簽
                                      g_pmk.pmksseq,       #已簽
                                      g_statu
          END IF
          IF l_pmksign != g_pmk.pmksign THEN
             CALL signm_count(l_pmksign) RETURNING g_pmk.pmksmax
             UPDATE pmk_file SET pmksseq = 0,
                                 pmk25 = '0',
                                 pmksmax = g_pmk.pmksmax,
                                 pmksign = l_pmksign,
                                 pmkdays = g_pmk.pmkdays,
                                 pmkprit = g_pmk.pmkprit
                            WHERE pmk01 = g_pmk.pmk01
              DELETE FROM azd_file WHERE azd01 = g_pmk.pmk01 AND azd02 = 2
          END IF
       ELSE
           CALL s_signm(6,34,g_lang,'1',g_pmk.pmk01,2,g_pmk.pmksign,
                g_pmk.pmkdays,g_pmk.pmkprit,g_pmk.pmksmax,g_pmk.pmksseq)
                         RETURNING l_pmksign,       #等級
                                   g_pmk.pmkdays,
                                   g_pmk.pmkprit,
                                   g_pmk.pmksmax,       #應簽
                                   g_pmk.pmksseq,       #已簽
                                   g_statu
           IF l_pmksign != g_pmk.pmksign THEN
              CALL signm_count(l_pmksign) RETURNING g_pmk.pmksmax
               UPDATE pmk_file SET pmksseq = 0,
                                   pmk25   = '0',
                                   pmksmax = g_pmk.pmksmax,
                                   pmksign = l_pmksign,
                                   pmkdays = g_pmk.pmkdays,
                                   pmkprit = g_pmk.pmkprit
                             WHERE pmk01 = g_pmk.pmk01
               DELETE FROM azd_file WHERE azd01 = g_pmk.pmk01 AND azd02 = 2
           END IF
       END IF
    END IF
 END IF
END FUNCTION

FUNCTION t420_copy()
DEFINE
       l_newno      LIKE pmk_file.pmk01,
       l_oldno      LIKE pmk_file.pmk01,
       l_pmk25      LIKE pmk_file.pmk25,
       l_pmk01_t    LIKE pmk_file.pmk01

DEFINE l_newdate    LIKE pmk_file.pmk04,    #No.B359
       l_pmk31      LIKE pmk_file.pmk31,
       l_pmk32      LIKE pmk_file.pmk32,
       l_pmk04_t    LIKE pmk_file.pmk04
DEFINE li_result    LIKE type_file.num5     #No.FUN-680136 SMALLINT
DEFINE l_pmk48      LIKE pmk_file.pmk48     #No.FUN-870007
DEFINE l_cnt1       LIKE type_file.num5     #FUN-C80045 add
    IF s_shut(0) THEN RETURN END IF
    #TQC-C10020 mark---------------
    #IF g_pmk.pmk01 IS NULL THEN
    #    CALL cl_err('',-420,0)
    #    RETURN
    #END IF
    #TQC-C10020 mark end-----------
    IF g_pmk.pmk01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF   #TQC-C10020
    LET l_pmk01_t = g_pmk.pmk01
    LET l_pmk04_t = g_pmk.pmk04
    IF g_argv2 MATCHES '[Yy]' THEN
        CALL cl_err('','mfg0055',0)
        RETURN
    END IF
     LET g_before_input_done = FALSE  #No.MOD-480235
     CALL t420_set_entry('a')         #No.MOD-480235
     LET g_before_input_done = TRUE   #No.MOD-480235

    CALL cl_set_head_visible("","YES")           #No.FUN-6B0032
    INPUT l_newno,l_newdate FROM pmk01,pmk04  #No.B359
          BEFORE INPUT
             CALL cl_set_docno_format("pmk01")

          AFTER FIELD pmk01
              IF NOT cl_null(l_newno) THEN
                 #FUN-C80045 add sta
                 LET g_t1=s_get_doc_no(l_newno)
                 LET l_cnt1 = 0
                 SELECT COUNT(*) INTO l_cnt1 FROM  rye_file WHERE rye04 = g_t1 AND ryeacti = 'Y' AND rye01 = 'apm'
                 IF l_cnt1 > 0 THEN
                    CALL cl_err(g_t1,'apc1036',0)
                     NEXT FIELD pmk01
                 END IF
                 #FUN-C80045 add end
                 CALL s_check_no("apm",l_newno,"","1","pmk_file","pmk01","") RETURNING li_result,l_newno
                 DISPLAY l_newno TO pmk01
                 IF (NOT li_result) THEN
                    NEXT FIELD pmk01
                 END IF
              END IF

          AFTER FIELD pmk04       #請購日期(預設會計年度/期間)
             IF NOT cl_null(l_newdate) THEN
                SELECT azn02,azn04 INTO l_pmk31,l_pmk32 FROM azn_file
                 WHERE azn01 = l_newdate
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","azn_file",l_newdate,"","mfg0027","","",1)  #No.FUN-660129
                   LET l_newdate = l_pmk04_t
                   DISPLAY l_newdate TO pmk04
                   NEXT FIELD pmk04
                END IF
                CALL s_get_bookno(YEAR(l_newdate))
                     RETURNING g_flag,g_bookno1,g_bookno2
                IF g_flag =  '1' THEN  #抓不到帳別
                   CALL cl_err(l_newdate,'aoo-081',1)
                   NEXT FIELD pmk04
                END IF
             END IF
             LET l_pmk25='0'
            BEGIN WORK
            CALL s_auto_assign_no("apm",l_newno,l_newdate,"","pmk_file","pmk01","","","") RETURNING li_result,l_newno
            IF (NOT li_result) THEN
               NEXT FIELD pmk01
            END IF
            DISPLAY l_newno TO pmk01

             ON ACTION controlp
                 CASE
                     WHEN INFIELD(pmk01) #單據編號
                           LET g_t1 = s_get_doc_no(l_newno)       #No.MOD-540182
                          CALL q_smy(FALSE,FALSE,g_t1,'APM','1') RETURNING g_t1 #TQC-670008
                          LET l_newno = g_t1
                          DISPLAY l_newno TO pmk01
                          NEXT FIELD pmk01
                     OTHERWISE EXIT CASE
                  END CASE
             ON IDLE g_idle_seconds
                CALL cl_on_idle()
                CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


    END INPUT

    IF INT_FLAG THEN
        LET INT_FLAG = 0
        ROLLBACK WORK
        DISPLAY BY NAME g_pmk.pmk01
        DISPLAY BY NAME g_pmk.pmk04       #TQC-AB0081
        RETURN
    END IF
    DROP TABLE y
    SELECT * FROM pmk_file         #單頭複製
        WHERE pmk01=l_pmk01_t
        INTO TEMP y
    LET l_pmk48 = TIME  #No.FUN-870007
    UPDATE y
        SET pmk01=l_newno,    #新的鍵值97-05-26
            pmk04=l_newdate,  #新的日期No.B359
            pmk31=l_pmk31,    #會計年No.B359
            pmk32=l_pmk32,    #會計月No.B359
            pmk03=0,          #狀態No.B359
            pmk18='N',        #確認碼(NO:0468)
            pmk25=l_pmk25,    #狀況碼
            pmk27= g_today,   #狀況日期
            pmkprdt= NULL,    #列印日期
            pmkprno= 0,       #列印次數
            pmkmksg=g_smy.smyapr,#是否簽核 BugNo:6417
            pmkuser=g_user,   #資料所有者
            pmkgrup=g_grup,   #資料所有者所屬群
            pmkoriu=g_user,   #TQC-A30041 ADD
            pmkorig=g_grup,   #TQC-A30041 ADD
            pmkmodu=NULL,     #資料修改日期
            pmkdate=NULL,                   #No.FUN-870007
            pmkcrat=g_today,  #資料創建日   #No.FUN-870007
            pmk46='1',        #來源類型     #No.FUN-870007
            pmk47=g_plant,    #取貨機構     #No.FUN-870007
            pmk50=null,       #生产营运中心 #FUN-CC0057
            pmkconu='',       #審核人員     #No.FUN-870007
            pmkcond='',       #審核時間     #No.FUN-870007
            pmkplant=g_plant,   #機構別       #No.FUN-870007
            pmk48=l_pmk48,    #請購時間     #No.FUN-870007
            pmkcont='',       #審核時間     #No.FUN-870007
            pmkacti='Y'       #有效資料
    INSERT INTO pmk_file
        SELECT * FROM y
    IF SQLCA.sqlcode THEN
        CALL cl_err3("ins","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660129
        ROLLBACK WORK
        RETURN
    ELSE
        COMMIT WORK
    END IF
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
    DROP TABLE x
    SELECT * FROM pml_file         #單身複製
        WHERE pml01=l_pmk01_t
        INTO TEMP x
    IF SQLCA.sqlcode THEN
        CALL cl_err3("sel","pml_file",l_pmk01_t,"",SQLCA.sqlcode,"","",1)  #No.FUN-660129
        RETURN
    END IF
    UPDATE x
        SET pml01=l_newno,   #97-05-26
            pml05= ' ',
            pml16= '0',
            pml21= 0  ,
            pml43= 0,
            pml431= 0,
            pml33='',  #No.B345
            pml34='',
            pml35='',
            pml18='',
            pml92='N',  #FUN-A10034
            pml93=NULL  #FUN-A10034
    INSERT INTO pml_file
        SELECT * FROM x
    IF SQLCA.sqlcode THEN
        CALL cl_err3("ins","pml_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660129
        RETURN
    END IF
    LET g_cnt=SQLCA.SQLERRD[3]
    MESSAGE '(',g_cnt USING '##&',') ROW of (',l_newno,') O.K'

     LET l_oldno = g_pmk.pmk01
     SELECT pmk_file.* INTO g_pmk.* FROM pmk_file
                    WHERE pmk01 = l_newno
     CALL t420_u()
     #SELECT pmk_file.* INTO g_pmk.* FROM pmk_file    #FUN-C80046
     #               WHERE pmk01 = l_pmk01_t          #FUN-C80046
     #CALL t420_show()                                #FUN-C80046
    DISPLAY BY NAME g_pmk.pmk01
END FUNCTION

FUNCTION t420_prt()

   IF cl_confirm('mfg3242') THEN
      CALL t420_out()
   END IF

END FUNCTION

FUNCTION t420_out()
   DEFINE l_cmd         LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(200)
          l_prog        LIKE zz_file.zz01,      #No.FUN-680136 VARCHAR(10)
          l_wc,l_wc2    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(50)
          l_prtway      LIKE type_file.chr1     #No.FUN-680136 VARCHAR(1)

    IF cl_null(g_pmk.pmk01) THEN RETURN END IF
  #  LET l_prog='apmr903' #FUN-C30085 mark
#    LET l_prog='apmg903' #FUN-C30085 add
    LET l_prog='cpmr420'

    SELECT pmkprsw INTO g_pmk.pmkprsw FROM pmk_file
     WHERE pmk01 = g_pmk.pmk01
    LET l_wc='pmk01="',g_pmk.pmk01,'"'
    SELECT zz21,zz22 INTO l_wc2,l_prtway FROM zz_file
     WHERE zz01 = l_prog
    IF SQLCA.sqlcode OR l_wc2 IS NULL THEN LET l_wc2 = " '3' " END IF

#    LET l_cmd = l_prog CLIPPED,
#                " '",g_today CLIPPED,"' ''",
#                " '",g_lang CLIPPED,"' 'Y' '",l_prtway,"' '1'",
#                " '",l_wc CLIPPED,"' "  # ,l_wc2  TQC-610085
    LET l_cmd = l_prog CLIPPED,
                " '",g_today CLIPPED,"' ''",
                " '",g_lang CLIPPED,"' 'Y' '' '1'",
                " '",l_wc CLIPPED,"' "
display 'l_cmd:',l_cmd
    CALL cl_cmdrun(l_cmd)

END FUNCTION

FUNCTION t420_b()
DEFINE l_ac_t,l_cnt    LIKE type_file.num5,    #No.FUN-680136 SMALLINT              #未取消的ARRAY CNT
       l_n,l_idx       LIKE type_file.num5,    #No.FUN-680136 SMALLINT     #檢查重複用
       l_lock_sw       LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(1)              #單身鎖住否
       p_cmd           LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(1)              #處理狀態
       l_flag          LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
       l_misc          LIKE type_file.num5,    #No.FUN-680136 VARCHAR(04)
       l_date,g_date   LIKE type_file.dat,     #No.FUN-680136 DATE
       l_pml18         LIKE pml_file.pml18,
       l_qty,l_diff    LIKE pml_file.pml20,
       l_flag1,g_flag  LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
       l_pml16         LIKE pml_file.pml16,
       l_pml20         LIKE pml_file.pml20,
       l_pml121        LIKE pml_file.pml121,
       l_pml122        LIKE pml_file.pml122,
       l_ins_flag      LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
       p_ima53         LIKE ima_file.ima53,
       l_allow_insert  LIKE type_file.num5,    #No.FUN-680136 SMALLINT   #可新增否
       l_allow_delete  LIKE type_file.num5,    #No.FUN-680136 SMALLINT   #可刪除否
       l_pmk25         LIKE pmk_file.pmk25,
       l_ima928        LIKE ima_file.ima928    #FUN-C30075 add
   DEFINE   li_i         LIKE type_file.num5    #No.FUN-680136 SMALLINT
   DEFINE   l_azf09      LIKE azf_file.azf09    #No.FUN-930104
   DEFINE   l_imaag      LIKE ima_file.imaag
   DEFINE   l_count      LIKE type_file.num5    #No.FUN-680136 SMALLINT
   DEFINE   l_temp       LIKE ima_file.ima01
   DEFINE   l_check_res  LIKE type_file.num5    #No.FUN-680136 SMALLINT
   DEFINE l_chr4      LIKE type_file.chr4
   DEFINE  l_pjb25    LIKE pjb_file.pjb25,
           l_ima920   LIKE ima_file.ima920
   DEFINE  l_pjb09    LIKE pjb_file.pjb09   #No.FUN-850027
   DEFINE  l_pjb11    LIKE pjb_file.pjb11   #No.FUN-850027

   DEFINE l_rtz04 LIKE rtz_file.rtz04
   DEFINE l_rte04 LIKE rte_file.rte04
   DEFINE l_rte07 LIKE rte_file.rte07
   DEFINE l_rtdconf LIKE rtd_file.rtdconf
   DEFINE l_pmc05 LIKE pmc_file.pmc05
   DEFINE l_pmc30 LIKE pmc_file.pmc30
   DEFINE l_pmcacti LIKE pmc_file.pmcacti
   DEFINE l_pmc930 LIKE pmc_file.pmc930
   DEFINE li_result LIKE type_file.chr1
#FUN-C20006--mark-begin--
##FUN-B90101--add--begin--
#&ifdef SLK
# DEFINE l_i        LIKE type_file.num5,
#        l_index    LIKE type_file.num5,
#        l_pmlslk09 LIKE pml_file.pml09
#
#
#&endif
##FUN-B90101--add--end--
#FUN-C20006--mark--end--

  DEFINE l_tf   LIKE type_file.chr1    #No.FUN-BB0086
  DEFINE l_case STRING    #No.FUN-BB0086
  DEFINE l_ima926 LIKE ima_file.ima926  #FUN-D30087 add

   LET g_action_choice = ""

   IF s_shut(0) THEN RETURN END IF
   IF cl_null(g_pmk.pmk01)  THEN RETURN END IF
   LET g_success = 'Y'
   SELECT * INTO g_pmk.* FROM pmk_file
    WHERE pmk01=g_pmk.pmk01
   LET l_pmk25 = g_pmk.pmk25          #FUN-550038
   IF g_pmk.pmk18 = 'Y'  THEN CALL cl_err('','axm-101',0) RETURN END IF
   IF g_pmk.pmk18 = 'X'  THEN CALL cl_err('','9024',0) RETURN END IF
   IF g_pmk.pmkacti ='N' THEN CALL cl_err('','aom-000',0) RETURN END IF
   IF g_pmk.pmk25 matches '[Ss]' THEN
        CALL cl_err('','apm-030',0)
        RETURN
   END IF
   IF g_argv2 = '0' AND g_pmk.pmk18='Y' AND g_pmk.pmk25 = "1" AND g_pmk.pmkmksg = "Y"  THEN
      CALL cl_err('','mfg3168',0)
      RETURN
   END IF

   IF g_argv2 = '0' AND g_pmk.pmk25 matches'[269]' THEN
      CALL cl_err('','mfg3141',0)
      RETURN
   END IF
   IF g_argv2 = '1' AND g_pmk.pmk25 matches'[269]' THEN
      CALL cl_err('','mfg3141',0)
      RETURN
   END IF
   #已發出採購單僅可"已發出採購單作業"才可更改
   IF g_argv2 matches '[01]' AND g_pmk.pmk25='2' THEN
      CALL cl_err('','mfg9118',0)
      RETURN
   END IF

   CALL cl_opmsg('b')

    LET g_forupd_sql =
    "SELECT * ",
    "  FROM pml_file ",
    "  WHERE pml01= ? ",
    "   AND pml02= ? ",
    "FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t420_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

#FUN-C20006--mark-begin--
##FUN-B90101--add--begin--
#&ifdef SLK
#    LET g_forupd_sql = " SELECT * FROM pmlslk_file WHERE pmlslk01 = ? AND pmlslk02 = ? ",
#                       " FOR UPDATE "
#   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
#   DECLARE t420_bcl_slk CURSOR FROM g_forupd_sql
#&endif
##FUN-B90101--add--end--
#FUN-C20006--mark--end--

    LET l_ac_t = 0

    IF g_rec_b > 0 THEN LET l_ac = 1 END IF

    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
    IF g_rec_b > 0 THEN LET l_ac = 1 END IF   #TQC-D40025 add

#FUN-B90101--add--str--
    DIALOG ATTRIBUTES(UNBUFFERED)
#FUN-C20006--mark-begin--
#&ifdef SLK
#      INPUT ARRAY g_pmlslk FROM s_pmlslk.*
#            ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS=TRUE,
#            INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
#
#         BEFORE INPUT
#             IF g_rec_b2 != 0 THEN
#                CALL fgl_set_arr_curr(l_ac2)
#             END IF
#
#         BEFORE ROW
#            LET p_cmd = ''
#            LET l_ac2 = ARR_CURR()
#            LET l_n  = ARR_COUNT()
#            LET l_ins_flag = 'N'
#            CALL s_settext_slk(g_pmlslk[l_ac2].pmlslk04)
#            CALL s_fillimx_slk(g_pmlslk[l_ac2].pmlslk04,
#                               g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#            LET g_rec_b3 = g_imx.getLength()
#            BEGIN WORK
#
#            OPEN t420_cl USING g_pmk.pmk01
#            IF STATUS THEN
#               CALL cl_err("OPEN t420_cl:", STATUS, 1)
#               CLOSE t420_cl
#               ROLLBACK WORK
#               RETURN
#            END IF
#            FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
#            IF SQLCA.sqlcode THEN
#               CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
#               CLOSE t420_cl
#               ROLLBACK WORK
#               RETURN
#            END IF
#            SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#            IF l_ima151 = 'Y' THEN
#               CALL cl_set_comp_entry("pmlslk20",FALSE)
#            ELSE
#               CALL cl_set_comp_entry("pmlslk20",TRUE)
#            END IF
#            IF g_gec07 = 'N' OR cl_null(g_gec07) THEN         #No.FUN-560102   #MOD-860100
#               CALL cl_set_comp_entry("pmlslk31t",FALSE)
#               CALL cl_set_comp_entry("pmlslk31",TRUE)
#            ELSE
#               CALL cl_set_comp_entry("pmlslk31",FALSE)
#               CALL cl_set_comp_entry("pmlslk31t",TRUE)
#            END IF
#            IF g_sma.sma59 = 'Y' AND g_pmlslk[l_ac2].pmlslk20 != 0 THEN
#               CALL cl_set_comp_required("pmlslk31,pmlslk31t",TRUE)
#            ELSE
#               CALL cl_set_comp_required("pmlslk31,pmlslk31t",FALSE)
#            END IF
#            #用在 INSERT 時的判斷
#            #因為輸入新資料時不做 INITIALIZE g_pmlslk[l_ac2].* TO NULL ( L600 )
#            IF g_rec_b2 >= l_ac2 THEN
#               LET p_cmd='u'
#               LET g_pmlslk_t.* = g_pmlslk[l_ac2].*  #BACKUP
#               LET l_lock_sw = 'N'            #DEFAULT
#
#               OPEN t420_bcl_slk USING g_pmk.pmk01,g_pmlslk_t.pmlslk02
#               IF STATUS THEN
#                   CALL cl_err("OPEN t420_bcl_slk:", STATUS, 1)
#                   LET l_lock_sw = "Y"
#               ELSE
#                   FETCH t420_bcl_slk INTO g_pmlslk2.* #FUN-730068
#                   IF SQLCA.sqlcode THEN
#                       CALL cl_err(g_pmlslk_t.pmlslk02,SQLCA.sqlcode,1)
#                       LET l_lock_sw = "Y"
#                   ELSE
#                       CALL t420_b_move_to() #FUN-730068
#                       SELECT pmlslk_file.* INTO g_pmlslk2.*
#                         FROM pmlslk_file
#                        WHERE pmlslk01 = g_pmk.pmk01
#                          AND pmlslk02 = g_pmlslk_t.pmlslk02
#                        LET g_pmlslk_o.* = g_pmlslk2.*     #No.MOD-580164
#                        LET g_no = g_pmlslk2.pmlslk04[1,4]   #MOD-B70253 add
#                   END IF
#               END IF
#               LET g_change='N'
#               CALL t420_sel_ima()
#               CALL cl_show_fld_cont()     #FUN-550037(smin)
#            END IF
#
#         AFTER INSERT
#             IF INT_FLAG THEN
#                CALL cl_err('',9001,0)
#                LET INT_FLAG = 0
#                CANCEL INSERT
#             END IF
#             IF g_sma.sma115 = 'Y' THEN
#                CALL s_chk_va_setting(g_pmlslk[l_ac2].pmlslk04)
#                     RETURNING g_flag,g_ima906,g_ima907
#                IF g_flag=1 THEN
#                   NEXT FIELD pmlslk04
#                END IF
#                CALL s_chk_va_setting1(g_pmlslk[l_ac2].pmlslk04)
#                     RETURNING g_flag,g_ima908
#                IF g_flag=1 THEN
#                   NEXT FIELD pmlslk04
#                END IF
#             END IF
#            IF g_smy.smy59 = 'Y' THEN
#              IF cl_null(g_pmlslk[l_ac2].pmlslk90) THEN
#                 CALL cl_err('','apj-201',0)
#                 NEXT FIELD pmlslk90
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk33) THEN
#                 LET g_pmlslk[l_ac2].pmlslk33 = g_today
#              END IF
#            END IF

#             LET g_pmlslk2.pmlslk31  = g_pmlslk[l_ac2].pmlslk31 	#MOD-950256 add
#             LET g_pmlslk2.pmlslk31t = g_pmlslk[l_ac2].pmlslk31t    #MOD-950256 add
#
#             SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
#              WHERE azi01 = g_pmk.pmk22  AND aziacti= 'Y'  #原幣
#             LET g_pmlslk2.pmlslk88 =cl_digcut(g_pmlslk2.pmlslk20*g_pmlslk2.pmlslk31,t_azi04)
#             LET g_pmlslk2.pmlslk88t=cl_digcut(g_pmlslk2.pmlslk20*g_pmlslk2.pmlslk31t,t_azi04)
#             LET g_pmlslk2.pmlslk930=g_pmlslk[l_ac2].pmlslk930 #FUN-670051

#             IF cl_null(g_pmlslk[l_ac2].pmlslk90) THEN
#                LET g_pmlslk[l_ac2].pmlslk90=' '
#             END IF
#             LET g_pmlslk2.pmlslk24 =g_pmlslk[l_ac2].pmlslk24
#             LET g_pmlslk2.pmlslk25 =g_pmlslk[l_ac2].pmlslk25
#             CALL t420_b_move_back() #FUN-730068
#             IF cl_null(g_pmlslk2.pmlslk50) THEN LET g_pmlslk2.pmlslk50='1' END IF
#             LET g_pmlslk2.pmlslkplant =g_plant  #FUN-980006 add
#             LET g_pmlslk2.pmlslklegal =g_legal  #FUN-980006 add
#
#             CALL s_umfchk(g_pmlslk[l_ac2].pmlslk04,g_pmlslk[l_ac2].pmlslk07,
#                           g_pmlslk2.pmlslk08) RETURNING l_flag,l_pmlslk09
#             IF l_flag THEN
#                CALL cl_err(g_pmlslk[l_ac2].pmlslk07,'mfg1206',0)
#                LET g_pmlslk[l_ac2].pmlslk07 = g_pmlslk2.pmlslk07
#             END IF
#             INSERT INTO pmlslk_file VALUES(g_pmlslk2.*)
#             IF SQLCA.sqlcode THEN
#                CALL cl_err3("ins","pmlslk_file",g_pmlslk2.pmlslk01,g_pmlslk2.pmlslk02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
#                CANCEL INSERT
#             ELSE
#                MESSAGE 'INSERT O.K'
#                LET g_rec_b2=g_rec_b2+1
#                SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#                IF l_ima151 = 'N' THEN        #非子、母料件
#                   LET g_pml_slk.pml01 = g_pmk.pmk01
#                   SELECT MAX(pml02) INTO l_n FROM pml_file WHERE pml01 = g_pmk.pmk01
#                   IF cl_null(l_n) THEN
#                      LET l_n = 0
#                   END IF
#                   LET g_pml_slk.pml02 = l_n + 1
#                   LET g_pml_slk.pml04 = g_pmlslk[l_ac2].pmlslk04
#                   LET g_pml_slk.pml041= g_pmlslk[l_ac2].pmlslk041
#                   CALL t420_pmlslk_move()
#                   INSERT INTO pml_file VALUES(g_pml_slk.*)
#                   IF SQLCA.sqlcode THEN
#                      CALL cl_err3("ins","pml_file",g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02,SQLCA.sqlcode,"","",1)
#                      CANCEL INSERT
#                   ELSE
#                      LET g_pmli_slk.pmli01 = g_pmk.pmk01
#                      LET g_pmli_slk.pmli02 = g_pml_slk.pml02
#                      LET g_pmli_slk.pmlislk02 = g_pmlslk[l_ac2].pmlslk04
#                      LET g_pmli_slk.pmlislk03 = g_pmlslk[l_ac2].pmlslk02
#                      LET g_pmli_slk.pmliplant = g_plant
#                      LET g_pmli_slk.pmlilegal = g_legal
#                      INSERT INTO pmli_file VALUES(g_pmli_slk.*)
#                      IF SQLCA.sqlcode THEN
#                         CALL cl_err3("ins","pmli_file",g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02,SQLCA.sqlcode,"","",1)
#                         CANCEL INSERT
#                      END IF
#                   END IF
#                END IF
#                LET l_pmk25 = '0'
#                CALL t420_update() #MOD-960034
#                DISPLAY g_rec_b2 TO FORMONLY.cn2
#             END IF

#         BEFORE INSERT
#            LET l_n = ARR_COUNT()
#            INITIALIZE arr_detail[l_ac2].* TO NULL   #No.TQC-650108
#            IF l_ac2 = 1 THEN
#               INITIALIZE g_pmlslk[l_ac2].* TO NULL
#            ELSE
#               LET g_pmlslk[l_ac2].* = g_pmlslk[l_ac2-1].*
#               SELECT MAX(pmlslk02)+1 INTO g_pmlslk[l_ac2].pmlslk02 FROM pmlslk_file
#                WHERE pmlslk01 = g_pmk.pmk01
#               IF g_pmlslk[l_ac2].pmlslk02 IS NULL THEN
#                  LET g_pmlslk[l_ac2].pmlslk02 = g_pmlslk[l_ac2-1].pmlslk02+1
#               END IF
#               LET g_pmlslk[l_ac2].pmlslk04=''   #MOD-A50129
#               LET g_pmlslk[l_ac2].pmlslk041=''   #MOD-A50129
#               LET g_change='Y'
#               LET g_pmlslk[l_ac2].pmlslk33 =''
#               LET g_pmlslk[l_ac2].pmlslk34 =''
#               LET g_pmlslk[l_ac2].pmlslk35 =''
#               LET g_pmlslk[l_ac2].pmlslk24 =''
#               LET g_pmlslk[l_ac2].pmlslk25 =''
#            END IF
#            LET l_ins_flag = 'Y'
#            INITIALIZE g_pmlslk2.* TO NULL
#            INITIALIZE g_pmlslk_o.* TO NULL
#            INITIALIZE g_pmlslk_t.* TO NULL
#            CALL t420_azi()
#            LET g_pmlslk2.pmlslk01 = g_pmk.pmk01
#            IF l_ac2 != 1 THEN
#               SELECT pmlslk08 INTO g_pmlslk2.pmlslk08 FROM pmlslk_file
#                 WHERE pmlslk01 = g_pmk.pmk01 AND pmlslk02 = g_pmlslk[l_ac2-1].pmlslk02
#            END IF
#            LET g_pmlslk[l_ac2].pmlslk20 = 0
#            LET g_pmlslk[l_ac2].pmlslk21 = 0          #已轉採購量
#            LET g_pmlslk[l_ac2].pmlslk30 = 0
#            LET g_pmlslk[l_ac2].pmlslk31 = 0
#            LET g_pmlslk[l_ac2].pmlslk31t= 0
#            LET g_pmlslk[l_ac2].pmlslk44 = 0
#            LET g_pmlslk[l_ac2].pmlslk88 = 0
#            LET g_pmlslk[l_ac2].pmlslk88t= 0
#            LET g_pmlslk[l_ac2].pmlslk33 = g_today
#            LET g_pmlslk[l_ac2].pmlslk34 = g_today
#            LET g_pmlslk[l_ac2].pmlslk35 = g_today
#            LET g_pmlslk[l_ac2].pmlslk90 = ' '           #費用原因
#            LET g_pmlslk[l_ac2].pmlslk50 = '1'
#            LET g_pmlslk[l_ac2].pmlslk190 = 'N'          #No.MOD-6A0014 add
#            LET g_pmlslk[l_ac2].pmlslk192 = "N"  #No.FUN-630040
#            LET g_pmlslk[l_ac2].pmlslk930=s_costcenter(g_pmk.pmk13)
#            LET g_pmlslk_t.* = g_pmlslk[l_ac2].*         #新輸入資料
#            LET p_cmd='a'
#            CALL t420_sel_ima()
#            CALL cl_show_fld_cont()     #FUN-550037(smin)
#            NEXT FIELD pmlslk02
#
#         BEFORE FIELD pmlslk02                        #default 序號
#            IF g_pmlslk[l_ac2].pmlslk02 IS NULL OR g_pmlslk[l_ac2].pmlslk02 = 0 THEN
#               SELECT max(pmlslk02)+1 INTO g_pmlslk[l_ac2].pmlslk02
#                 FROM pmlslk_file WHERE pmlslk01 = g_pmk.pmk01
#               IF g_pmlslk[l_ac2].pmlslk02 IS NULL THEN
#                   LET g_pmlslk[l_ac2].pmlslk02 = 1
#               END IF
#            END IF
#         AFTER FIELD pmlslk02                        #check 序號是否重複
#            IF g_pmlslk[l_ac2].pmlslk02 IS NULL THEN
#               LET g_pmlslk[l_ac2].pmlslk02 = g_pmlslk_t.pmlslk02
#            END IF
#            IF g_pmlslk[l_ac2].pmlslk02=0 THEN
#               CALL cl_err('','apm-422',1)
#               LET g_pmlslk[l_ac2].pmlslk02 = g_pmlslk_t.pmlslk02
#               NEXT FIELD pmlslk02
#            END IF
#            IF NOT cl_null(g_pmlslk[l_ac2].pmlslk02) THEN
#                IF g_pmlslk[l_ac2].pmlslk02 != g_pmlslk_t.pmlslk02 OR
#                   g_pmlslk_t.pmlslk02 IS NULL THEN
#                   LET g_pmli.pmlislk02=g_pmlslk[l_ac2].pmlslk02   #No.TQC-970335
#                   SELECT count(*) INTO l_n FROM pmlslk_file
#                     WHERE pmlslk01 = g_pmk.pmk01 AND
#                           pmlslk02 = g_pmlslk[l_ac2].pmlslk02
#                   IF l_n > 0 THEN
#                      CALL cl_err('',-239,0)
#                      LET g_pmlslk[l_ac2].pmlslk02 = g_pmlslk_t.pmlslk02
#                      NEXT FIELD pmlslk02
#                   ELSE
#                      UPDATE pmo_file SET pmo03 = g_pmlslk[l_ac2].pmlslk02
#                         WHERE pmo01 = g_pmk.pmk01
#                         AND pmo03 = g_pmlslk_o.pmlslk02
#                   END IF
#                END IF
#                LET g_pmlslk2.pmlslk02 = g_pmlslk[l_ac2].pmlslk02
#                LET g_pmlslk_o.pmlslk02 = g_pmlslk[l_ac2].pmlslk02
#            END IF
#
#         BEFORE FIELD pmlslk04
#            LET g_pmlslk04_y= g_pmlslk[l_ac2].pmlslk04
#
#         AFTER FIELD pmlslk04     # check 料件編號
#            IF NOT cl_null(g_pmlslk[l_ac2].pmlslk04) THEN
#            #FUN-C20006 mark
#            #  SELECT COUNT(*) INTO l_n FROM ima_file WHERE ima01=g_pmlslk[l_ac2].pmlslk04
#            #                                           AND imaacti='Y'
#            #                                           AND ( ima151 != 'N' OR imaag <> '@CHILD' )
#            #  IF l_n = 0 THEN
#            #     CALL cl_err('g_pmlslk[l_ac2].pmlslk04','-0811',0)
#            #     NEXT FIELD pmlslk04
#            #  END IF
#            #FUN-C20006 mark
#            #FUN-C20006--add--begin--
#               SELECT COUNT(*) INTO l_n FROM ima_file WHERE ima01=g_pmlslk[l_ac2].pmlslk04
#                                                        AND ima1010='1' and imaacti='Y'
#               IF l_n=0 THEN
#                  CALL cl_err('','100',0)
#                  LET g_pmlslk[l_ac2].pmlslk04=g_pmlslk_t.pmlslk04
#                  NEXT FIELD pmlslk04
#               END IF
#               SELECT ima151,imaag INTO l_ima151,l_imaag FROM ima_file
#                WHERE ima01=g_pmlslk[l_ac2].pmlslk04 AND imaacti='Y'
#               IF l_ima151='N' AND l_imaag='@CHILD' THEN
#                  CALL cl_err('','axm1104',0)
#                  NEXT FIELD pmlslk04
#               END IF
#            #FUN-C20006--add--end--
#               SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#               IF l_ima151 = 'Y' THEN
#                  CALL cl_set_comp_entry("pmlslk20",FALSE)
#               ELSE
#                  CALL cl_set_comp_entry("pmlslk20",TRUE)
#               END IF
#               IF g_pmlslk_o.pmlslk04 IS NULL OR g_pmlslk[l_ac2].pmlslk04 != g_pmlslk_o.pmlslk04 THEN
#                  SELECT COUNT(*) INTO l_n FROM pmlslk_file WHERE pmlslk01=g_pmk.pmk01
#                                                              AND pmlslk04=g_pmlslk[l_ac2].pmlslk04
#                  IF l_n > 0 THEN
#                     CALL cl_err('',-239,0)
#                     NEXT FIELD pmlslk04
#                  END IF
#               END IF
#               IF g_pmlslk[l_ac2].pmlslk04[1,4] != 'MISC' THEN        #TQC-B30200
#                  IF NOT s_chk_item_no(g_pmlslk[l_ac2].pmlslk04,"") THEN
#                     CALL cl_err('',g_errno,1)
#                     NEXT FIELD pmlslk04
#                  END IF
#               END IF                                          #TQC-B30200
#            END IF
#            IF NOT s_chkima08(g_pmlslk[l_ac2].pmlslk04) THEN
#               NEXT FIELD CURRENT
#            END IF
#         #如果設置為不允許新增
#            IF (g_pmlslk_o.pmlslk04 IS NULL OR g_pmlslk[l_ac2].pmlslk04 != g_pmlslk_o.pmlslk04)
#               AND (g_pmlslk[l_ac2].pmlslk04[1,4] != 'MISC') THEN
#               IF g_sma.sma908 = 'N' THEN
#                  SELECT COUNT(*) INTO l_n FROM ima_file WHERE ima01 =g_pmlslk[l_ac2].pmlslk04
#                  IF l_n =0 THEN
#                     LET g_pmlslk[l_ac2].pmlslk04 =NULL
#                     CALL cl_err(g_pmlslk[l_ac2].pmlslk04,'ams-003',1)
#                     NEXT FIELD pmlslk04
#                  END IF
#               END IF
#            END IF   #No.TQC-7C0144
#      # #使用多屬性時，過料件編號，只要料號存在，母料號也可過
#      #  IF g_sma.sma120 = 'N' THEN                  #No.FUN-830086
#      #     SELECT imaag INTO l_imaag FROM ima_file  #母料件不可過
#      #      WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#      #     IF NOT cl_null(l_imaag) AND l_imaag <> '@CHILD' THEN
#      #        LET g_pmlslk[l_ac2].pmlslk041 = NULL
#      #        DISPLAY BY NAME g_pmlslk[l_ac2].*
#      #        CALL cl_err(g_pmlslk[l_ac2].pmlslk04,'aim1004',0)
#      #        NEXT FIELD pmlslk04
#      #     END IF
#      #  END IF                                      #No.FUN-830086
#         CALL s_settext_slk(g_pmlslk[l_ac2].pmlslk04)
#         CALL s_fillimx_slk(g_pmlslk[l_ac2].pmlslk04,
#                             g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#         LET g_rec_b3 = g_imx.getLength()
#         SELECT ima02,ima44,ima25,ima913,ima914 INTO g_pmlslk[l_ac2].pmlslk041,g_pmlslk[l_ac2].pmlslk07,
#                                                    g_pmlslk[l_ac2].pmlslk08,g_pmlslk[l_ac2].pmlslk190,
#                                                    g_pmlslk[l_ac2].pmlslk191 FROM ima_file
#             WHERE ima01=g_pmlslk[l_ac2].pmlslk04
#
#        SELECT imb118 INTO g_pmlslk[l_ac2].pmlslk30 FROM imb_file WHERE imb01=g_pmlslk[l_ac2].pmlslk04
#        LET g_pmlslk[l_ac2].pmlslk192='N'
#        LET g_pmlslk[l_ac2].pmlslk930=s_costcenter(g_pmk.pmk13)
#        SELECT rty03 INTO g_pmlslk[l_ac2].pmlslk50 FROM rty_file
#            WHERE rty01=g_plant AND rty02=g_pmlslk[l_ac2].pmlslk04
#        DISPLAY BY NAME g_pmlslk[l_ac2].*                       #MOD-AA0084
#
#
#         AFTER FIELD pmlslk07    #請購單位
#            IF g_pmlslk_t.pmlslk07 IS NULL AND g_pmlslk[l_ac2].pmlslk07 IS NOT NULL OR
#               g_pmlslk_t.pmlslk07 IS NOT NULL AND g_pmlslk[l_ac2].pmlslk07 IS NULL OR
#               g_pmlslk_t.pmlslk07 <> g_pmlslk[l_ac2].pmlslk07 THEN
#               LET g_change='Y'
#            END IF
#            IF NOT cl_null(g_pmlslk[l_ac2].pmlslk07) THEN
#               IF g_pmlslk_o.pmlslk07 IS NULL OR (g_pmlslk_t.pmlslk07 IS NULL)
#                  OR (g_pmlslk[l_ac2].pmlslk07 != g_pmlslk_o.pmlslk07) THEN
#                  CALL t420_unit(g_pmlslk[l_ac2].pmlslk07)
#                  IF NOT cl_null(g_errno) THEN
#                     CALL cl_err(g_pmlslk[l_ac2].pmlslk07,g_errno,0)
#                     LET g_pmlslk[l_ac2].pmlslk07 = g_pmlslk_o.pmlslk07
#                     NEXT FIELD pmlslk07
#                  END IF
#               END IF
#               IF ( cl_null(g_pmlslk_o.pmlslk07) AND NOT cl_null(g_pmlslk2.pmlslk08))
#                  OR (g_pmlslk[l_ac2].pmlslk07 != g_pmlslk_o.pmlslk07 AND
#                  NOT cl_null(g_pmlslk2.pmlslk08) ) THEN
#                  CALL s_umfchk(g_pmlslk[l_ac2].pmlslk04,g_pmlslk[l_ac2].pmlslk07,
#                    g_pmlslk2.pmlslk08) RETURNING l_flag,l_pmlslk09
#                  IF l_flag THEN
#                     CALL cl_err(g_pmlslk[l_ac2].pmlslk07,'mfg1206',0)
#                     LET g_pmlslk[l_ac2].pmlslk07 = g_pmlslk2.pmlslk07
#                     NEXT FIELD pmlslk07
#                  END IF
#               END IF
#               LET g_pmlslk2.pmlslk07 = g_pmlslk[l_ac2].pmlslk07
#               LET g_pmlslk_o.pmlslk07 = g_pmlslk[l_ac2].pmlslk07
#              #IF g_change='Y' THEN
#              #  CALL t420_bud(p_cmd,'3')
#              #  IF NOT cl_null(g_errno) THEN
#              #     NEXT FIELD pmlslk07
#              #  END IF
#              #END IF
#            END IF

#         AFTER FIELD pmlslk20    #數量
#            IF NOT cl_null(g_pmlslk[l_ac2].pmlslk20) THEN
#               IF  g_pmlslk[l_ac2].pmlslk20 < 0 THEN
#                   LET g_pmlslk[l_ac2].pmlslk20 = g_pmlslk_t.pmlslk20
#                   NEXT FIELD pmlslk20
#               END IF
#               IF NOT cl_null(g_pmlslk[l_ac2].pmlslk31) THEN
#                  LET g_pmlslk[l_ac2].pmlslk88 = g_pmlslk[l_ac2].pmlslk31*g_pmlslk[l_ac2].pmlslk20
#               END IF
#               IF NOT cl_null(g_pmlslk[l_ac2].pmlslk31T) THEN
#                  LET g_pmlslk[l_ac2].pmlslk88t= g_pmlslk[l_ac2].pmlslk31t*g_pmlslk[l_ac2].pmlslk20
#               END IF
#               CALL cl_digcut(g_pmlslk[l_ac2].pmlslk88,t_azi04) RETURNING g_pmlslk[l_ac2].pmlslk88
#               CALL cl_digcut(g_pmlslk[l_ac2].pmlslk88t,t_azi04) RETURNING g_pmlslk[l_ac2].pmlslk88t
#            END IF
#         AFTER FIELD pmlslk33    #交貨日期
#           IF NOT cl_null(g_pmlslk[l_ac2].pmlslk33) THEN
#              IF g_pmlslk[l_ac2].pmlslk33 < g_pmk.pmk04 THEN
#                 CALL cl_err("","apm-027",0)
#                 NEXT FIELD pmlslk33
#              END IF
#              CALL s_wkday(g_pmlslk[l_ac2].pmlslk33) RETURNING l_flag,l_date
#              IF l_date IS NULL OR l_date = ' ' THEN
#                 NEXT FIELD pmlslk33
#              ELSE
#                 LET g_pmlslk[l_ac2].pmlslk33 = l_date
#              END IF
#              IF g_pmlslk[l_ac2].pmlslk33 > g_pmlslk[l_ac2].pmlslk34 THEN
#                 CALL cl_err("","mfg3225",0)
#                 NEXT FIELD pmlslk33
#              END IF
#              DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk33
#              LET g_pmlslk2.pmlslk33 = g_pmlslk[l_ac2].pmlslk33
#            # CALL t420_bud(p_cmd,'3')
#            # IF NOT cl_null(g_errno) THEN
#            #    NEXT FIELD pmlslk33
#            # END IF
#           END IF
#           LET g_pmlslk_o.pmlslk33 = g_pmlslk[l_ac2].pmlslk33

#        AFTER FIELD pmlslk34
#           IF NOT cl_null(g_pmlslk[l_ac2].pmlslk34) THEN
#              IF g_pmlslk[l_ac2].pmlslk34 < g_pmk.pmk04 THEN
#                 CALL cl_err("","apm-090",0)
#                 NEXT FIELD pmlslk34
#              END IF
#              CALL s_wkday(g_pmlslk[l_ac2].pmlslk34) RETURNING g_flag,g_date
#              IF cl_null(g_date) THEN
#                   NEXT FIELD pmlslk34
#              ELSE LET g_pmlslk[l_ac2].pmlslk34 = g_date
#                   DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk34
#              END IF
#              IF g_pmlslk[l_ac2].pmlslk34 < g_pmlslk[l_ac2].pmlslk33 THEN
#                 CALL cl_err("","mfg3225",0)
#                 NEXT FIELD pmlslk34
#              END IF
#              IF g_pmlslk[l_ac2].pmlslk34 > g_pmlslk[l_ac2].pmlslk35 THEN
#                 CALL cl_err("","apm-028",0)
#                 NEXT FIELD pmlslk34
#              END IF
#           ELSE  LET g_pmlslk[l_ac2].pmlslk34 = g_pmlslk[l_ac2].pmlslk33 + g_ima49
#                 DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk34
#           END IF
#           LET g_pmlslk2.pmlslk34 = g_pmlslk[l_ac2].pmlslk34
#           LET g_pmlslk_o.pmlslk34 = g_pmlslk[l_ac2].pmlslk34
#           IF g_pmlslk[l_ac2].pmlslk33 < g_pmk.pmk04 THEN
#              CALL cl_err("","apm-027",0)
#              NEXT FIELD pmlslk33
#           END IF
#
#        AFTER FIELD pmlslk35
#           IF NOT cl_null(g_pmlslk[l_ac2].pmlslk35) THEN
#             SELECT ima49,ima491 INTO g_ima49,g_ima491
#               FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#              IF g_pmlslk[l_ac2].pmlslk35 < g_pmk.pmk04 THEN
#                 CALL cl_err("","apm-060",0)
#                 NEXT FIELD pmlslk35
#              END IF
#              CALL s_wkday(g_pmlslk[l_ac2].pmlslk35) RETURNING g_flag,g_date
#              IF cl_null(g_date) THEN
#                   NEXT FIELD pmlslk35
#              ELSE LET g_pmlslk[l_ac2].pmlslk35 = g_date
#                   DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk35
#              END IF
#              IF g_pmlslk[l_ac2].pmlslk35 < g_pmlslk[l_ac2].pmlslk34 OR
#                 g_pmlslk[l_ac2].pmlslk35 < g_pmlslk[l_ac2].pmlslk33
#              THEN CALL cl_err(g_pmlslk[l_ac2].pmlslk35,'apm-028',0)
#                   NEXT FIELD pmlslk35
#              END IF
#           ELSE
#                LET g_pmlslk[l_ac2].pmlslk35 = g_pmlslk[l_ac2].pmlslk34 + g_ima491
#                DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk35
#           END IF
#           IF cl_null(g_pmlslk[l_ac2].pmlslk34)
#              OR g_pmlslk_t.pmlslk35 != g_pmlslk[l_ac2].pmlslk35 OR cl_null(g_pmlslk_t.pmlslk35) THEN #TQC-970421
#              CALL s_aday(g_pmlslk[l_ac2].pmlslk35,-1,g_ima491) RETURNING g_pmlslk[l_ac2].pmlslk34
#           END IF
#           IF cl_null(g_pmlslk[l_ac2].pmlslk33)
#              OR g_pmlslk_t.pmlslk35 != g_pmlslk[l_ac2].pmlslk35 OR cl_null(g_pmlslk_t.pmlslk35) THEN #TQC-970421
#              CALL s_aday(g_pmlslk[l_ac2].pmlslk34,-1,g_ima49) RETURNING g_pmlslk[l_ac2].pmlslk33
#           END IF
#           LET g_pmlslk2.pmlslk33 = g_pmlslk[l_ac2].pmlslk33
#           LET g_pmlslk2.pmlslk34 = g_pmlslk[l_ac2].pmlslk34
#           LET g_pmlslk_o.pmlslk33 = g_pmlslk[l_ac2].pmlslk33
#           LET g_pmlslk_o.pmlslk34 = g_pmlslk[l_ac2].pmlslk34
#           LET g_pmlslk2.pmlslk35 = g_pmlslk[l_ac2].pmlslk35
#           LET g_pmlslk_o.pmlslk35 = g_pmlslk[l_ac2].pmlslk35
#           IF g_pmlslk[l_ac2].pmlslk34 < g_pmk.pmk04 THEN
#              CALL cl_err("","apm-090",0)
#              NEXT FIELD pmlslk34
#           END IF
#           IF g_pmlslk[l_ac2].pmlslk33 < g_pmk.pmk04 THEN
#              CALL cl_err("","apm-027",0)
#              NEXT FIELD pmlslk33
#           END IF
#
#        AFTER FIELD pmlslk90  #費用原因
#          IF NOT cl_null(g_pmlslk[l_ac2].pmlslk90) THEN
#             SELECT COUNT(*) INTO g_cnt FROM azf_file
#               WHERE azf01=g_pmlslk[l_ac2].pmlslk90 AND azf02='2' AND azfacti='Y'
#             IF g_cnt = 0 THEN
#                CALL cl_err(g_pmlslk[l_ac2].pmlslk90,'asf-453',0)
#                NEXT FIELD pmlslk90
#             END IF
#             SELECT azf09 INTO l_azf09 FROM azf_file
#              WHERE azf01=g_pmlslk[l_ac2].pmlslk90 AND azf02='2' AND azfacti='Y'
#                 IF l_azf09 !='7' THEN
#                   CALL cl_err('','aoo-406',1)
#                    NEXT FIELD pmlslk90
#                 END IF
#           # CALL t420_bud(p_cmd,'3')
#           # IF NOT cl_null(g_errno) THEN
#           #    NEXT FIELD pmlslk90
#           # END IF
#          END IF
#
#        BEFORE FIELD pmlslk31
#           IF g_gec07 = 'N' OR cl_null(g_gec07) THEN         #No.FUN-560102   #MOD-860100
#              CALL cl_set_comp_entry("pmlslk31t",FALSE)
#           ELSE
#              CALL cl_set_comp_entry("pmlslk31",FALSE)
#           END IF
#
#        BEFORE FIELD pmlslk31t
#           IF g_gec07 = 'N' OR cl_null(g_gec07) THEN         #No.FUN-560102   #MOD-860100
#              CALL cl_set_comp_entry("pmlslk31t",FALSE)
#           ELSE
#              CALL cl_set_comp_entry("pmlslk31",FALSE)
#           END IF
#
#        AFTER FIELD pmlslk31   #未稅單價
#           IF NOT cl_null(g_pmlslk[l_ac2].pmlslk31) THEN
#              IF cl_null(g_pmlslk[l_ac2].pmlslk31) OR g_pmlslk[l_ac2].pmlslk31<0 THEN
#                 LET g_pmlslk[l_ac2].pmlslk31=g_pmlslk_t.pmlslk31
#                 DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk31
#                 NEXT FIELD pmlslk31
#              END IF
#              LET g_pmlslk[l_ac2].pmlslk31 = cl_digcut(g_pmlslk[l_ac2].pmlslk31,t_azi03)  #No.CHI-6A0004
#              LET g_pmlslk[l_ac2].pmlslk44 = g_pmlslk[l_ac2].pmlslk31*g_pmk.pmk42
#              LET g_pmlslk[l_ac2].pmlslk44 = cl_digcut(g_pmlslk[l_ac2].pmlslk44,t_azi03)
#              LET g_pmlslk[l_ac2].pmlslk31t = g_pmlslk[l_ac2].pmlslk31 * (1 + g_pmk.pmk43/100)
#              LET g_pmlslk[l_ac2].pmlslk31t = cl_digcut(g_pmlslk[l_ac2].pmlslk31t,t_azi03) #No.CHI-6A0004
#              IF NOT cl_null(g_pmlslk[l_ac2].pmlslk20) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88 = cl_digcut(g_pmlslk[l_ac2].pmlslk31*g_pmlslk[l_ac2].pmlslk20,t_azi04)
#                 LET g_pmlslk[l_ac2].pmlslk88t= cl_digcut(g_pmlslk[l_ac2].pmlslk31t*g_pmlslk[l_ac2].pmlslk20,t_azi04)
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk44) THEN
#                 LET g_pmlslk[l_ac2].pmlslk44 = 0
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk88) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88 = 0
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk88t) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88t = 0
#              END IF
#            # CALL t420_bud(p_cmd,'3')
#            # IF NOT cl_null(g_errno) THEN
#            #    NEXT FIELD pmlslk31
#            # END IF
#           END IF
#        AFTER FIELD pmlslk31t  #含稅單價
#          IF NOT cl_null(g_pmlslk[l_ac2].pmlslk31t) THEN
#              IF g_pmlslk[l_ac2].pmlslk31t<0 THEN
#                 LET g_pmlslk[l_ac2].pmlslk31t=g_pmlslk_t.pmlslk31t
#                 DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk31t
#                 NEXT FIELD pmlslk31t
#              END IF
#              LET g_pmlslk[l_ac2].pmlslk31t = cl_digcut(g_pmlslk[l_ac2].pmlslk31t,t_azi03)  #No.CHI-6A0004
#              LET g_pmlslk[l_ac2].pmlslk31 = g_pmlslk[l_ac2].pmlslk31t / (1 + g_pmk.pmk43/100)
#              LET g_pmlslk[l_ac2].pmlslk31 = cl_digcut(g_pmlslk[l_ac2].pmlslk31,t_azi03)  #No.CHI-6A0004
#              LET g_pmlslk[l_ac2].pmlslk44=g_pmlslk[l_ac2].pmlslk31*g_pmk.pmk42             #No.TQC-630043 add
#              LET g_pmlslk[l_ac2].pmlslk44 = cl_digcut(g_pmlslk[l_ac2].pmlslk44,t_azi03)
#              IF NOT cl_null(g_pmlslk[l_ac2].pmlslk20) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88 = cl_digcut(g_pmlslk[l_ac2].pmlslk31*g_pmlslk[l_ac2].pmlslk20,t_azi04)
#                 LET g_pmlslk[l_ac2].pmlslk88t= cl_digcut(g_pmlslk[l_ac2].pmlslk31t*g_pmlslk[l_ac2].pmlslk20,t_azi04)
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk44) THEN
#                 LET g_pmlslk[l_ac2].pmlslk44 = 0
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk88) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88 = 0
#              END IF
#              IF cl_null(g_pmlslk[l_ac2].pmlslk88t) THEN
#                 LET g_pmlslk[l_ac2].pmlslk88t = 0
#              END IF
#          END IF

#         BEFORE DELETE                            #是否取消單身
#            IF g_pmlslk_t.pmlslk02 > 0 AND g_pmlslk_t.pmlslk02 IS NOT NULL THEN
#               IF NOT cl_delb(0,0) THEN
#                  CANCEL DELETE
#               END IF
#
#               IF l_lock_sw = "Y" THEN
#                  CALL cl_err("", -263, 1)
#                  CANCEL DELETE
#               END IF
#               IF g_pmk.pmk46 = '2' AND g_azw.azw04 = '2'  THEN  #TQC-AC0337
#                  CALL cl_err('','apm1052',1)                    #TQC-AC0337
#                  RETURN                                         #TQC-AC0337
#               END IF                                            #TQC-AC0337

#               IF g_sma.sma901 = 'Y' THEN
#                  LET l_chr4 = g_pmlslk[l_ac2].pmlslk02 USING '&&&&'
#                  LET g_pmlslk02 = g_pmlslk_t.pmlslk02
#                  IF g_pmlslk_t.pmlslk02<10 THEN
#                     LET g_pmlslk02='000',g_pmlslk02
#                  ELSE
#                     IF g_pmlslk_t.pmlslk02<100 THEN
#                        LET g_pmlslk02='00',g_pmlslk02
#                     ELSE
#                        IF g_pmlslk_t.pmlslk02<1000 THEN
#                           LET g_pmlslk02='0',g_pmlslk02
#                        ELSE
#                           LET g_pmlslk02=g_pmlslk02
#                        END IF
#                     END IF
#                  END IF
#
#                  LET g_pmlslk02 = g_pmk.pmk01,'-',g_pmlslk02
#                  DISPLAY "g_pmlslk02 = ",g_pmlslk02
#                  DELETE FROM vmz_file where vmz01=g_pmlslk02
#               END IF
#               CALL t420_upd_oebslk28('d',g_pmlslk_t.pmlslk02)
#               DELETE FROM pmo_file
#                  WHERE pmo01 = g_pmk.pmk01
#                  AND pmo03 = g_pmlslk_t.pmlslk02
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err3("del","pmo_file",g_pmk.pmk01,g_pmlslk_t.pmlslk02,SQLCA.sqlcode,"","",1)
#               END IF

#               DELETE FROM pmlslk_file
#                   WHERE pmlslk01 = g_pmk.pmk01 AND
#                         pmlslk02 = g_pmlslk_t.pmlslk02
#               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#                   CALL cl_err3("del","pmlslk_file",g_pmk.pmk01,g_pmlslk_t.pmlslk02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
#                   ROLLBACK WORK
#                   CANCEL DELETE
#               ELSE
#                  LET g_rec_b2=g_rec_b2-1
#                  DELETE FROM pml_file WHERE pml01=g_pmk.pmk01
#                                         AND pml02 IN (SELECT pml02 FROM pml_file,pmli_file
#                                                        WHERE pml01=pmli01
#                                                          AND pml02=pmli02
#                                                          AND pmli01=g_pmk.pmk01
#                                                          AND pmlislk02=g_pmlslk_t.pmlslk04
#                                                          AND pmlislk03=g_pmlslk_t.pmlslk02)
#                  DELETE FROM pmli_file WHERE pmli01=g_pmk.pmk01
#                                          AND pmlislk02=g_pmlslk_t.pmlslk04
#                                          AND pmlislk03=g_pmlslk_t.pmlslk02
#               END IF
#
#               DISPLAY g_rec_b2 TO FORMONLY.cn2
#               SELECT SUM(pml20) INTO l_count FROM pml_file WHERE pml01=g_pmk.pmk01
#               DISPLAY l_count TO FORMONLY.qty
#               LET l_pmk25 = '0'          #FUN-550038
#               LET g_no = g_pmlslk2.pmlslk04[1,4]
#               CALL t420_update() #MOD-960034
#               COMMIT WORK
#            END IF
#
#         ON ROW CHANGE
#             IF INT_FLAG THEN
#                CALL cl_err('',9001,0)
#                LET INT_FLAG = 0
#                LET g_pmlslk[l_ac2].* = g_pmlslk_t.*
#                CLOSE t420_bcl_slk
#                ROLLBACK WORK
#                EXIT DIALOG
#             END IF
#             IF l_lock_sw = 'Y' THEN
#                CALL cl_err(g_pmlslk[l_ac2].pmlslk02,-263,1)
#                LET g_pmlslk[l_ac2].* = g_pmlslk_t.*
#             ELSE
#                IF g_sma.sma115 = 'Y' THEN
#                   CALL s_chk_va_setting(g_pmlslk[l_ac2].pmlslk04)
#                        RETURNING g_flag,g_ima906,g_ima907
#                   IF g_flag=1 THEN
#                      NEXT FIELD pmlslk04
#                   END IF
#                   CALL s_chk_va_setting1(g_pmlslk[l_ac2].pmlslk04)
#                        RETURNING g_flag,g_ima908
#                   IF g_flag=1 THEN
#                      NEXT FIELD pmlslk04
#                   END IF
#                END IF
#
#                LET g_pmlslk2.pmlslk31  = g_pmlslk[l_ac2].pmlslk31 	#MOD-950256 add
#                LET g_pmlslk2.pmlslk31t = g_pmlslk[l_ac2].pmlslk31t #MOD-950256 add

#                SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
#                 WHERE azi01 = g_pmk.pmk22  AND aziacti= 'Y'  #原幣
#                LET g_pmlslk2.pmlslk88 =cl_digcut(g_pmlslk2.pmlslk20*g_pmlslk2.pmlslk31,t_azi04)
#                LET g_pmlslk2.pmlslk88t=cl_digcut(g_pmlslk2.pmlslk20*g_pmlslk2.pmlslk31t,t_azi04)
#                LET g_pmlslk2.pmlslk930=g_pmlslk[l_ac2].pmlslk930 #FUN-670051
#                IF g_pmlslk[l_ac2].pmlslk20 < 0  THEN
#                    CALL cl_err(g_pmlslk[l_ac2].pmlslk20,'mfg0013',1)
#                    LET g_pmlslk[l_ac2].pmlslk20 = g_pmlslk_o.pmlslk20
#                    IF g_sma.sma115 != 'Y' THEN
#                       NEXT FIELD pmlslk20
#                    END IF
#                END IF
#                CALL t420_b_move_back() #FUN-730068

#                UPDATE pmlslk_file SET pmlslk_file.* = g_pmlslk2.*   # 更新DB
#                 WHERE pmlslk01=g_pmk.pmk01 AND pmlslk02=g_pmlslk_t.pmlslk02
#                IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
#                   CALL cl_err3("upd","pmlslk_file",g_pmk.pmk01,g_pmlslk_t.pmlslk02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
#                   LET g_pmlslk[l_ac2].* = g_pmlslk_t.*
#                ELSE
#                   IF g_pmlslk[l_ac2].pmlslk04 != g_pmlslk_t.pmlslk04 THEN
#                      DELETE FROM pml_file WHERE pml01=g_pmk.pmk01
#                                             AND pml02 IN (SELECT pml02 FROM pml_file,pmli_file
#                                                            WHERE pml01=pmli01
#                                                              AND pml02=pmli02
#                                                              AND pmli01=g_pmk.pmk01
#                                                              AND pmlislk02=g_pmlslk_t.pmlslk04
#                                                              AND pmlislk03=g_pmlslk_t.pmlslk02)
#                      DELETE FROM pmli_file WHERE pmli01=g_pmk.pmk01
#                                              AND pmlislk02=g_pmlslk_t.pmlslk04
#                                              AND pmlislk03=g_pmlslk_t.pmlslk02
#                      SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#                      IF l_ima151 = 'N' THEN        #非子、母料件
#                          LET g_pml_slk.pml01 = g_pmk.pmk01
#                          SELECT MAX(pml02) INTO l_n FROM pml_file WHERE pml01 = g_pmk.pmk01
#                          IF cl_null(l_n) THEN
#                             LET l_n = 0
#                          END IF
#                          LET g_pml_slk.pml02 = l_n + 1
#                          LET g_pml_slk.pml04 = g_pmlslk[l_ac2].pmlslk04
#                          LET g_pml_slk.pml041= g_pmlslk[l_ac2].pmlslk041
#                          CALL t420_pmlslk_move()
#                          INSERT INTO pml_file VALUES(g_pml_slk.*)
#                          IF SQLCA.sqlcode THEN
#                             CALL cl_err3("ins","pml_file",g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02,SQLCA.sqlcode,"","",1)
#                          ELSE
#                             LET g_pmli_slk.pmli01 = g_pmk.pmk01
#                             LET g_pmli_slk.pmli02 = g_pml_slk.pml02
#                             LET g_pmli_slk.pmlislk02 = g_pmlslk[l_ac2].pmlslk04
#                             LET g_pmli_slk.pmlislk03 = g_pmlslk[l_ac2].pmlslk02
#                             LET g_pmli_slk.pmliplant = g_plant
#                             LET g_pmli_slk.pmlilegal = g_legal
#                             INSERT INTO pmli_file VALUES(g_pmli_slk.*)
#                             IF SQLCA.sqlcode THEN
#                                CALL cl_err3("ins","pmli_file",g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02,SQLCA.sqlcode,"","",1)
#                             END IF
#                          END IF
#                      END IF
#                   ELSE
#                      SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk_t.pmlslk04
#                      IF l_ima151 = 'N' THEN        #非子、母料件
#                         UPDATE pml_file SET pml07  = g_pmlslk[l_ac2].pmlslk07,
#                                             pml08  = g_pmlslk[l_ac2].pmlslk08,
#                                             pml20  = g_pmlslk[l_ac2].pmlslk20,
#                                             pml30  = g_pmlslk[l_ac2].pmlslk30,
#                                             pml31  = g_pmlslk[l_ac2].pmlslk31,
#                                             pml33  = g_pmlslk[l_ac2].pmlslk33,
#                                             pml34  = g_pmlslk[l_ac2].pmlslk34,
#                                             pml35  = g_pmlslk[l_ac2].pmlslk35,
#                                             pml31t = g_pmlslk[l_ac2].pmlslk31t,
#                                             pml44  = g_pmlslk[l_ac2].pmlslk44,
#                                             pml82  = g_pmlslk[l_ac2].pmlslk20,
#                                             pml87  = g_pmlslk[l_ac2].pmlslk20,
#                                             pml88  = g_pmlslk[l_ac2].pmlslk88,
#                                             pml88t = g_pmlslk[l_ac2].pmlslk88t,
#                                             pml190 = g_pmlslk[l_ac2].pmlslk190,
#                                             pml191 = g_pmlslk[l_ac2].pmlslk191,
#                                             pml192 = g_pmlslk[l_ac2].pmlslk192,
#                                             pml90  = g_pmlslk[l_ac2].pmlslk90,
#                                             pml930 = g_pmlslk[l_ac2].pmlslk930
#                                       WHERE pml01 = g_pmk.pmk01
#                                         AND pml02 IN (SELECT pml02 FROM pml_file,pmli_file
#                                                             WHERE pml01=pmli01
#                                                               AND pml02=pmli02
#                                                               AND pmli01=g_pmk.pmk01
#                                                               AND pmlislk03=g_pmlslk_t.pmlslk02)
#                      ELSE
#                         UPDATE pml_file SET pml07  = g_pmlslk[l_ac2].pmlslk07,
#                                             pml08  = g_pmlslk[l_ac2].pmlslk08,
#                                             pml30  = g_pmlslk[l_ac2].pmlslk30,
#                                             pml31  = g_pmlslk[l_ac2].pmlslk31,
#                                             pml33  = g_pmlslk[l_ac2].pmlslk33,
#                                             pml34  = g_pmlslk[l_ac2].pmlslk34,
#                                             pml35  = g_pmlslk[l_ac2].pmlslk35,
#                                             pml31t = g_pmlslk[l_ac2].pmlslk31t,
#                                             pml44  = g_pmlslk[l_ac2].pmlslk44,
#                                             pml88  = g_pmlslk[l_ac2].pmlslk31*pml20,
#                                             pml88t = g_pmlslk[l_ac2].pmlslk31t*pml20,
#                                             pml90  = g_pmlslk[l_ac2].pmlslk90,
#                                             pml930 = g_pmlslk[l_ac2].pmlslk930
#                                       WHERE pml01=g_pmk.pmk01
#                                          AND pml02 IN (SELECT pml02 FROM pml_file,pmli_file
#                                                          WHERE pml01=pmli01
#                                                            AND pml02=pmli02
#                                                            AND pmli01=g_pmk.pmk01
#                                                            AND pmlislk02=g_pmlslk_t.pmlslk04
#                                                            AND pmlislk03=g_pmlslk_t.pmlslk02)
#                      END IF
#                  END IF
#               END IF       #FUN-A50054 add
#               MESSAGE 'UPDATE O.K'
#               LET l_pmk25 = '0'
#               CALL t420_upd_oebslk28('b',g_pmlslk_t.pmlslk02)
#               CALL t420_update() #MOD-960034
#               COMMIT WORK
#             END IF
#
#         AFTER ROW
#             LET l_ac2 = ARR_CURR()
#             LET l_ac2_t = l_ac2
#             IF INT_FLAG THEN
#                CALL cl_err('',9001,0)
#                LET INT_FLAG = 0
#                IF p_cmd = 'u' THEN
#                   LET g_pmlslk[l_ac2].* = g_pmlslk_t.*
#                END IF
#                CLOSE t420_bcl_slk
#                ROLLBACK WORK
#                EXIT DIALOG
#             ELSE
#                IF g_smy.smy59 = 'Y' THEN
#                   IF cl_null(g_pmlslk[l_ac2].pmlslk90) THEN
#                      CALL cl_err('','apj-201',0)
#                      NEXT FIELD pmlslk90
#                   END IF
#                   IF cl_null(g_pmlslk[l_ac2].pmlslk33) THEN
#                      LET g_pmlslk[l_ac2].pmlslk33 = g_today
#                   END IF
#                END IF
#             END IF
#             CLOSE t420_bcl_slk
#             COMMIT WORK
#
#
#         ON ACTION CONTROLP
#            CASE
#               WHEN INFIELD(pmlslk04) #料件編號
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ="q_ima01"
#                    LET g_qryparam.default1 = g_pmlslk[l_ac2].pmlslk04
#                    CALL cl_create_qry() RETURNING g_pmlslk[l_ac2].pmlslk04
#                    DISPLAY g_pmlslk[l_ac2].pmlslk04 TO pmlslk04
#                    NEXT FIELD pmlslk04
#               WHEN INFIELD(pmlslk07) #採購單位
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = "q_gfe"
#                    LET g_qryparam.default1 = g_pmlslk[l_ac2].pmlslk07
#                    CALL cl_create_qry() RETURNING g_pmlslk[l_ac2].pmlslk07
#                    DISPLAY g_pmlslk[l_ac2].pmlslk07 TO pmlslk07
#                    NEXT FIELD pmlslk07
#               WHEN INFIELD(pmlslk90)  #費用原因
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ="q_azf01a" #No.FUN-930104
#                    LET g_qryparam.default1 = g_pmlslk[l_ac2].pmlslk90
#                    LET g_qryparam.arg1 = '7'       #No.FUN-930104
#                    CALL cl_create_qry() RETURNING g_pmlslk[l_ac2].pmlslk90
#                    DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk90
#                    NEXT FIELD pmlslk90
#               WHEN INFIELD(pmlslk930)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ="q_gem4"
#                    CALL cl_create_qry() RETURNING g_pmlslk[l_ac2].pmlslk930
#                    DISPLAY BY NAME g_pmlslk[l_ac2].pmlslk930
#                    NEXT FIELD pmlslk930
#               OTHERWISE EXIT CASE
#            END CASE
#
#         ON ACTION maintain_item_master
#            IF g_sma.sma38 MATCHES'[Yy]' THEN
#               IF not cl_null(g_pmlslk[l_ac2].pmlslk04) THEN
#                  LET g_cmd = "aimi100 '",g_pmlslk[l_ac2].pmlslk04 CLIPPED,"'"
#               ELSE
#                  LET g_cmd = "aimi100 "
#               END IF
#               CALL cl_cmdrun(g_cmd)
#            ELSE
#               CALL cl_err(g_sma.sma38,'mfg0035',1)
#            END IF
#
#         ON ACTION maintain_unit_data
#            LET g_cmd = 'aooi101 '
#            CALL cl_cmdrun(g_cmd)
#
#         ON ACTION maintain_unit_conversion
#            LET g_cmd = 'aooi102 '
#            CALL cl_cmdrun(g_cmd)
#
#         ON ACTION maintain_item_unit_conversion
#            LET g_cmd = 'aooi103 '
#            CALL cl_cmdrun(g_cmd)
#
#         ON ACTION maintain_pr_unit_conv
#        #   CALL t442()
#
#         ON ACTION maintain_date_data
#        #   CALL t444()
#
#         ON ACTION b_input
#            SELECT count(*) INTO l_n3
#              FROM pmlslk_file
#             WHERE pmlslk01 = g_pmk.pmk01
#           # IF l_n3 = 0 THEN
#           #    CALL t420_b_i()
#           #    EXIT INPUT
#           # END IF
#
#         ON ACTION special_description #特別說明
#            LET g_cmd = "apmt402 0 '",g_pmk.pmk01,"' ",g_pmlslk[l_ac2].pmlslk02
#            CALL cl_cmdrun_wait(g_cmd)  #FUN-660216 add
#
#         ON ACTION item_vender_query
#            IF NOT cl_null(g_pmk.pmk09) THEN
#                CALL cl_init_qry_var()
#                LET g_qryparam.form = "q_pmh"
#                LET g_qryparam.arg1 = g_pmk.pmk09  #No.MOD-480478
#                LET g_qryparam.default1 = g_pmlslk[l_ac2].pmlslk04
#                CALL cl_create_qry() RETURNING g_pmlslk[l_ac2].pmlslk04
#                DISPLAY g_pmlslk[l_ac2].pmlslk04 TO pmlslk04
#                NEXT FIELD pmlslk04
#            ELSE
#                #供應廠商並無輸入,所以無法在此^U!
#                CALL cl_err('','apm-004',0)
#            END IF
#
#         ON ACTION item_inquiry_list
#         #  CALL t420_b_more()
#
#         ON ACTION CONTROLO                        #沿用所有欄位
#            IF INFIELD(pmlslk02) AND l_ac2 > 1 THEN
#               LET g_pmlslk[l_ac2].* = g_pmlslk[l_ac2-1].*
#               SELECT max(pmlslk02)+1 INTO g_pmlslk[l_ac2].pmlslk02
#                 FROM pmlslk_file WHERE pmlslk01 = g_pmk.pmk01
#               IF g_pmlslk[l_ac2].pmlslk02 IS NULL THEN
#                   LET g_pmlslk[l_ac2].pmlslk02 = 1
#               END IF
#               DISPLAY BY NAME g_pmlslk[l_ac2].*
#               SELECT pmlslk_file.* INTO g_pmlslk2.*
#                 FROM pmlslk_file
#                WHERE pmlslk01 = g_pmk.pmk01
#                  AND pmlslk02 = g_pmlslk[l_ac2-1].pmlslk02
#               NEXT FIELD pmlslk02
#            END IF
#
#      END INPUT
#      INPUT ARRAY g_imx FROM s_imx.*
#            ATTRIBUTE(COUNT=g_rec_b3,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS=TRUE,
#            INSERT ROW=TRUE,DELETE ROW=TRUE,APPEND ROW=TRUE)
#         BEFORE INPUT
#             IF g_rec_b3 != 0 THEN
#                CALL fgl_set_arr_curr(l_ac3)
#             END IF
#             CALL cl_set_comp_required('color',TRUE)
#
#         BEFORE ROW
#            LET p_cmd3 = ''
#            LET l_ac3 = ARR_CURR()
#            INITIALIZE g_imx_t.* TO NULL

#            BEGIN WORK
#
#            OPEN t420_cl USING g_pmk.pmk01
#            IF STATUS THEN
#               CALL cl_err("OPEN t420_cl:", STATUS, 1)
#               CLOSE t420_cl
#               ROLLBACK WORK
#               RETURN
#            END IF
#            FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
#            IF SQLCA.sqlcode THEN
#               CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
#               CLOSE t420_cl
#               ROLLBACK WORK
#               RETURN
#            END IF

#            IF g_rec_b3 >= l_ac3 THEN
#               LET p_cmd3='u'
#               LET g_imx_t.* = g_imx[l_ac3].*
#               LET l_lock_sw = 'N'
#            END IF
#
#          BEFORE INSERT
#            LET p_cmd3='a'
#            LET l_ac3 = ARR_CURR()
#            INITIALIZE g_imx_t.* TO NULL

#          AFTER FIELD color
#             IF NOT cl_null(g_imx[l_ac3].color) THEN
#                IF NOT t420_check_color() THEN
#                   LET g_imx[l_ac3].color=g_imx_t.color
#                   NEXT FIELD color
#                END IF
#                IF g_imx[l_ac3].color !=g_imx_t.color AND g_imx_t.color IS NOT NULL THEN
#                   CALL s_updcolor_slk(l_ac3,g_pmlslk[l_ac2].pmlslk04,
#                                    g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#                END IF
#             END IF
#

#          AFTER FIELD imx01
#             IF NOT cl_null(g_imx[l_ac3].imx01) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx01 !=g_imx_t.imx01 AND g_imx_t.imx01 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(1,g_imx[l_ac3].imx01,g_imx_t.imx01) THEN
#                      LET g_imx[l_ac3].imx01 = g_imx_t.imx01
#                      NEXT FIELD imx01
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,1,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx02
#             IF NOT cl_null(g_imx[l_ac3].imx02) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx02 !=g_imx_t.imx02 AND g_imx_t.imx02 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(2,g_imx[l_ac3].imx02,g_imx_t.imx02) THEN
#                      LET g_imx[l_ac3].imx02 = g_imx_t.imx02
#                      NEXT FIELD imx02
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,2,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx03
#             IF NOT cl_null(g_imx[l_ac3].imx03) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx03 !=g_imx_t.imx03 AND g_imx_t.imx03 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(3,g_imx[l_ac3].imx03,g_imx_t.imx03) THEN
#                      LET g_imx[l_ac3].imx03 = g_imx_t.imx03
#                      NEXT FIELD imx03
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,3,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx04
#             IF NOT cl_null(g_imx[l_ac3].imx04) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx04 !=g_imx_t.imx04 AND g_imx_t.imx04 IS NOT NULL) THEN
#                    IF NOT t420_check_imx(4,g_imx[l_ac3].imx04,g_imx_t.imx04) THEN
#                       LET g_imx[l_ac3].imx04 = g_imx_t.imx04
#                       NEXT FIELD imx04
#                    END IF
#                   CALL s_ins_ima_slk(l_ac3,4,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx05
#             IF NOT cl_null(g_imx[l_ac3].imx05) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx05 !=g_imx_t.imx05 AND g_imx_t.imx05 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(5,g_imx[l_ac3].imx05,g_imx_t.imx05) THEN
#                      LET g_imx[l_ac3].imx05 = g_imx_t.imx05
#                      NEXT FIELD imx05
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,5,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx06
#             IF NOT cl_null(g_imx[l_ac3].imx06) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx06 !=g_imx_t.imx06 AND g_imx_t.imx06 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(6,g_imx[l_ac3].imx06,g_imx_t.imx06) THEN
#                      LET g_imx[l_ac3].imx06 = g_imx_t.imx06
#                      NEXT FIELD imx06
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,6,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx07
#             IF NOT cl_null(g_imx[l_ac3].imx07) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx07 !=g_imx_t.imx07 AND g_imx_t.imx07 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(7,g_imx[l_ac3].imx07,g_imx_t.imx07) THEN
#                      LET g_imx[l_ac3].imx07 = g_imx_t.imx07
#                      NEXT FIELD imx07
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,7,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx08
#             IF NOT cl_null(g_imx[l_ac3].imx08) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx08 !=g_imx_t.imx08 AND g_imx_t.imx08 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(8,g_imx[l_ac3].imx08,g_imx_t.imx08) THEN
#                      LET g_imx[l_ac3].imx08 = g_imx_t.imx08
#                      NEXT FIELD imx08
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,8,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx09
#             IF NOT cl_null(g_imx[l_ac3].imx09) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx09 !=g_imx_t.imx09 AND g_imx_t.imx09 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(9,g_imx[l_ac3].imx09,g_imx_t.imx09) THEN
#                      LET g_imx[l_ac3].imx09 = g_imx_t.imx09
#                      NEXT FIELD imx09
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,9,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx10
#             IF NOT cl_null(g_imx[l_ac3].imx10) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx10 !=g_imx_t.imx10 AND g_imx_t.imx10 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(10,g_imx[l_ac3].imx10,g_imx_t.imx10) THEN
#                      LET g_imx[l_ac3].imx10 = g_imx_t.imx10
#                      NEXT FIELD imx10
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,10,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx11
#             IF NOT cl_null(g_imx[l_ac3].imx11) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx11 !=g_imx_t.imx11 AND g_imx_t.imx11 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(11,g_imx[l_ac3].imx11,g_imx_t.imx11) THEN
#                      LET g_imx[l_ac3].imx11 = g_imx_t.imx11
#                      NEXT FIELD imx11
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,11,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx12
#             IF NOT cl_null(g_imx[l_ac3].imx12) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx12 !=g_imx_t.imx12 AND g_imx_t.imx12 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(12,g_imx[l_ac3].imx12,g_imx_t.imx12) THEN
#                      LET g_imx[l_ac3].imx12 = g_imx_t.imx12
#                      NEXT FIELD imx12
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,12,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx13
#             IF NOT cl_null(g_imx[l_ac3].imx13) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx13 !=g_imx_t.imx13 AND g_imx_t.imx13 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(13,g_imx[l_ac3].imx13,g_imx_t.imx13) THEN
#                      LET g_imx[l_ac3].imx13 = g_imx_t.imx13
#                      NEXT FIELD imx13
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,13,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx14
#             IF NOT cl_null(g_imx[l_ac3].imx14) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx14 !=g_imx_t.imx14 AND g_imx_t.imx14 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(14,g_imx[l_ac3].imx14,g_imx_t.imx14) THEN
#                      LET g_imx[l_ac3].imx14 = g_imx_t.imx14
#                      NEXT FIELD imx14
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,14,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF
#          AFTER FIELD imx15
#             IF NOT cl_null(g_imx[l_ac3].imx15) THEN
#                IF p_cmd3='a' OR (g_imx[l_ac3].imx15 !=g_imx_t.imx15 AND g_imx_t.imx15 IS NOT NULL) THEN
#                   IF NOT t420_check_imx(15,g_imx[l_ac3].imx15,g_imx_t.imx15) THEN
#                      LET g_imx[l_ac3].imx15 = g_imx_t.imx15
#                      NEXT FIELD imx15
#                   END IF
#                   CALL s_ins_ima_slk(l_ac3,15,g_pmlslk[l_ac2].pmlslk04)
#                END IF
#             END IF

#          BEFORE DELETE
#            IF NOT cl_delb(0,0) THEN
#               CANCEL DELETE
#            END IF
#            CALL s_ins_slk('r',l_ac3,g_pmlslk[l_ac2].pmlslk04,
#                           g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#            LET g_rec_b3=g_rec_b3-1
#            CALL t420_update_pmlslk()
#            CALL t420_update()
#            IF g_success = 'Y' THEN
#                COMMIT WORK
#            ELSE
#                ROLLBACK WORK
#            END IF
#            DISPLAY ARRAY g_pml TO s_pml.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
#               BEFORE DISPLAY
#                  EXIT DISPLAY
#            END DISPLAY
#
#          AFTER INSERT
#             CALL t420_pmlslk_move()
#             CALL s_ins_slk('a',l_ac3,g_pmlslk[l_ac2].pmlslk04,
#                           g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#             LET g_rec_b3=g_rec_b3+1
#             CALL t420_update_pmlslk()
#             CALL t420_update()
#             IF g_success = 'Y' THEN
#                COMMIT WORK
#             ELSE
#                ROLLBACK WORK
#             END IF
#             DISPLAY ARRAY g_pml TO s_pml.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
#                BEFORE DISPLAY
#                   EXIT DISPLAY
#             END DISPLAY

#          ON ROW CHANGE
#             CALL t420_pmlslk_move()
#             CALL s_ins_slk('u',l_ac3,g_pmlslk[l_ac2].pmlslk04,
#                           g_pmk.pmk01,g_pmlslk[l_ac2].pmlslk02)
#             CALL t420_update_pmlslk()
#             CALL t420_update()
#             IF g_success = 'Y' THEN
#                COMMIT WORK
#             ELSE
#                ROLLBACK WORK
#             END IF
#             DISPLAY ARRAY g_pml TO s_pml.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
#                BEFORE DISPLAY
#                   EXIT DISPLAY
#             END DISPLAY
#
#          AFTER ROW
#             IF g_success = 'Y' THEN
#                COMMIT WORK
#             ELSE
#  	         ROLLBACK WORK
#             END IF
#             CLOSE t420_cl

#          AFTER INPUT
#             IF INT_FLAG THEN                         # 若按了DEL鍵
#                LET INT_FLAG = 0
#                EXIT DIALOG
#             END IF

#       END INPUT
#&else
#FUN-C20006--mark--end--
       INPUT ARRAY g_pml FROM s_pml.*
             ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS=TRUE,
             INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
#FUN-B90101--add--end--
#FUN-B90101--mark--
#       INPUT ARRAY g_pml WITHOUT DEFAULTS FROM s_pml.*
#            ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
#            INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
#
#FUN-B90101--mark--
          BEFORE INPUT
              IF g_rec_b != 0 THEN
                 CALL fgl_set_arr_curr(l_ac)
              END IF
              LET g_b_flag = '1'            #TQC-D40025

          BEFORE ROW
             LET p_cmd = ''
             LET l_ac = ARR_CURR()
             LET l_n  = ARR_COUNT()
             LET l_ins_flag = 'N'
             BEGIN WORK

             OPEN t420_cl USING g_pmk.pmk01
             IF STATUS THEN
                CALL cl_err("OPEN t420_cl:", STATUS, 1)
                CLOSE t420_cl
                ROLLBACK WORK
                RETURN
             END IF
             FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
             IF SQLCA.sqlcode THEN
                CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
                CLOSE t420_cl
                ROLLBACK WORK
                RETURN
             END IF

             #用在 INSERT 時的判斷
             #因為輸入新資料時不做 INITIALIZE g_pml[l_ac].* TO NULL ( L600 )
             IF g_rec_b >= l_ac THEN
                LET p_cmd='u'
                LET g_pml_t.* = g_pml[l_ac].*  #BACKUP
                #No.FUN-BB0086--add--begin--
                LET g_pml07_t = g_pml[l_ac].pml07
                LET g_pml80_t = g_pml[l_ac].pml80
                LET g_pml83_t = g_pml[l_ac].pml83
                LET g_pml86_t = g_pml[l_ac].pml86
                #No.FUN-BB0086--add--end--
                LET l_pml121  = 0 #MOD-4B0105
                LET l_pml122  = 0 #MOD-4B0105
                LET l_lock_sw = 'N'            #DEFAULT
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#                DECLARE t420_ata1 SCROLL CURSOR FOR
#                 SELECT ata02,ata03,ata04,ata05 FROM ata_file #FUN-A60035 add ata05
#                  WHERE ata00=g_prog
#                    AND ata01=g_pmk.pmk01
#                    AND ata02=g_pml_t.pml02
#                FOREACH t420_ata1 INTO l_ata02,g_pml_t.pml02,l_ata04,l_ata05 #FUN-A60035 add l_ata05
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                OPEN t420_bcl USING g_pmk.pmk01,g_pml_t.pml02
                IF STATUS THEN
                    CALL cl_err("OPEN t420_bcl:", STATUS, 1)
                    LET l_lock_sw = "Y"
                ELSE
                    FETCH t420_bcl INTO g_pml2.* #FUN-730068
                    IF SQLCA.sqlcode THEN
                        CALL cl_err(g_pml_t.pml02,SQLCA.sqlcode,1)
                        LET l_lock_sw = "Y"
                    ELSE
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifndef SLK
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                        CALL t420_b_move_to() #FUN-730068
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                        IF g_sma.sma120 = 'Y' AND g_sma.sma907 = 'Y' THEN
                           #得到該料件對應的父料件和所有屬性
                           SELECT imx00,imx01,imx02,imx03,imx04,imx05,imx06,
                                  imx07,imx08,imx09,imx10 INTO
                                  g_pml[l_ac].att00,g_pml[l_ac].att01,g_pml[l_ac].att02,
                                  g_pml[l_ac].att03,g_pml[l_ac].att04,g_pml[l_ac].att05,
                                  g_pml[l_ac].att06,g_pml[l_ac].att07,g_pml[l_ac].att08,
                                  g_pml[l_ac].att09,g_pml[l_ac].att10
                           FROM imx_file WHERE imx000 = g_pml[l_ac].pml04

                           LET g_pml[l_ac].att01_c = g_pml[l_ac].att01
                           LET g_pml[l_ac].att02_c = g_pml[l_ac].att02
                           LET g_pml[l_ac].att03_c = g_pml[l_ac].att03
                           LET g_pml[l_ac].att04_c = g_pml[l_ac].att04
                           LET g_pml[l_ac].att05_c = g_pml[l_ac].att05
                           LET g_pml[l_ac].att06_c = g_pml[l_ac].att06
                           LET g_pml[l_ac].att07_c = g_pml[l_ac].att07
                           LET g_pml[l_ac].att08_c = g_pml[l_ac].att08
                           LET g_pml[l_ac].att09_c = g_pml[l_ac].att09
                           LET g_pml[l_ac].att10_c = g_pml[l_ac].att10

                        END IF
                        SELECT ima021 INTO g_pml[l_ac].ima021 FROM ima_file
                        WHERE ima01=g_pml[l_ac].pml04
                        IF g_azw.azw04='2' THEN
                           CALL t420_pml48('d')
                        END IF
                        CALL t420_set_pml930(g_pml[l_ac].pml930) RETURNING g_pml[l_ac].gem02a #FUN-670051
                        SELECT pml_file.* INTO g_pml2.*
                          FROM pml_file
                         WHERE pml01 = g_pmk.pmk01
                           AND pml02 = g_pml_t.pml02
                        SELECT mse02 INTO g_pml[l_ac].mse02
                          FROM mse_file WHERE mse01=g_pml[l_ac].pml123
                        DISPLAY g_pml[l_ac].mse02 TO FORMONLY.mse02
                         LET g_pml_o.* = g_pml2.*     #No.MOD-580164
                         LET g_no = g_pml2.pml04[1,4]   #MOD-B70253 add
                    END IF
                END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#                 END FOREACH
#                 LET g_pml2.pml02 = l_ata02
##                LET g_pml2.pml04 = l_ata04 #FUN-A60035
#                 LET g_pml2.pml04 = l_ata05 #FUN-A60035
#                 LET g_pml_t.pml02 = g_pml2.pml02
#                 LET g_pml_t.pml04 = g_pml2.pml04
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                LET g_change='N'
                CALL t420_sel_ima()
                CALL t420_set_entry_b('u')
                CALL t420_set_no_entry_b('u')
                CALL t420_set_no_required()
                CALL t420_set_required()
                CALL cl_show_fld_cont()     #FUN-550037(smin)
             END IF
             LET g_before_input_done = FALSE
             CALL t420_set_entry_b('u')
             CALL t420_set_no_entry_b('u')
             LET g_before_input_done = TRUE
             CALL t420_set_pml191()    #No.FUN-A10037

          AFTER INSERT
              IF INT_FLAG THEN
                 CALL cl_err('',9001,0)
                 LET INT_FLAG = 0
                 CANCEL INSERT
              END IF
              IF g_sma.sma115 = 'Y' THEN
                 CALL s_chk_va_setting(g_pml[l_ac].pml04)
                      RETURNING g_flag,g_ima906,g_ima907
                 IF g_flag=1 THEN
                    NEXT FIELD pml04
                 END IF
                 CALL s_chk_va_setting1(g_pml[l_ac].pml04)
                      RETURNING g_flag,g_ima908
                 IF g_flag=1 THEN
                    NEXT FIELD pml04
                 END IF
                 CALL t420_du_data_to_correct()
                 CALL t420_set_origin_field()
              END IF

#TQC-B50066 --begin--
             IF g_smy.smy59 = 'Y' THEN
               IF cl_null(g_pml[l_ac].pml90) THEN
                  CALL cl_err('','apj-201',0)
                  NEXT FIELD pml90
               END IF
               IF cl_null(g_pml[l_ac].pml40) THEN
                  CALL cl_err('','apj-202',0)
                  NEXT FIELD pml40
               END IF
               IF g_aza.aza63 = 'Y' AND cl_null(g_pml[l_ac].pml401) THEN
                  CALL cl_err('','apj-203',0)
                  NEXT FIELD pml401
               END IF
              #MOD-B50258 mark  下方有赋值，此处没必要
              #IF cl_null(g_pml[l_ac].pml121) THEN
              #   NEXT FIELD pml121
              #END IF
              #IF cl_null(g_pml[l_ac].pml12) THEN
              #   LET g_pml[l_ac].pml12 = ' '
              #END IF
              #MOD-B50258 mark--end
               IF cl_null(g_pml[l_ac].pml33) THEN
                  LET g_pml[l_ac].pml33 = g_today
               END IF
               IF cl_null(g_pml[l_ac].pml67) THEN
                  LET g_pml[l_ac].pml67 = ' '
               END IF
               CALL t420_bud(p_cmd,'3')
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD pml12
               END IF
             END IF
#TQC-B50066 --end--

#TQC-B50066 --begin--
##MOD-B40202 --begin--
#              IF g_smy.smy59 = 'Y' THEN
#                 IF cl_null(g_pml[l_ac].pml90) THEN
#                    LET g_pml[l_ac].pml90 = ' '
#                 END IF
#                 IF cl_null(g_pml[l_ac].pml40) THEN
#                    LET g_pml[l_ac].pml40 = ' '
#                 END IF
#                 IF cl_null(g_pml[l_ac].pml33) THEN
#                    LET g_pml[l_ac].pml33 = g_today
#                 END IF
#                 IF cl_null(g_pml[l_ac].pml121) THEN
#                    LET g_pml[l_ac].pml121 = ' '
#                 END IF
#                 IF cl_null(g_pml[l_ac].pml67) THEN
#                    LET g_pml[l_ac].pml67 = ' '
#                 END IF
#                 IF cl_null(g_pml[l_ac].pml12) THEN
#                    LET g_pml[l_ac].pml12 = ' '
#                 END IF
#
#                 CALL t420_bud(p_cmd,'3')
#                 IF NOT cl_null(g_errno) THEN
#                    NEXT FIELD pml12
#                 END IF
#              END IF
##MOD-B40202 --end-
#TQC-B50066 --end--
              IF cl_null(g_pml[l_ac].pml86) THEN
                 LET g_pml[l_ac].pml86 = g_pml[l_ac].pml07
                 LET g_pml[l_ac].pml87 = g_pml[l_ac].pml20
              END IF
              LET g_pml2.pml31  = g_pml[l_ac].pml31 	#MOD-950256 add
              LET g_pml2.pml31t = g_pml[l_ac].pml31t    #MOD-950256 add
              LET g_pml2.pml80 =g_pml[l_ac].pml80
              LET g_pml2.pml81 =g_pml[l_ac].pml81
              LET g_pml2.pml82 =g_pml[l_ac].pml82
              LET g_pml2.pml83 =g_pml[l_ac].pml83
              LET g_pml2.pml84 =g_pml[l_ac].pml84
              LET g_pml2.pml85 =g_pml[l_ac].pml85
              LET g_pml2.pml86 =g_pml[l_ac].pml86
              LET g_pml2.pml87 =g_pml[l_ac].pml87
              SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
               WHERE azi01 = g_pmk.pmk22  AND aziacti= 'Y'  #原幣
              LET g_pml2.pml88 =cl_digcut(g_pml2.pml87*g_pml2.pml31,t_azi04)
              LET g_pml2.pml88t=cl_digcut(g_pml2.pml87*g_pml2.pml31t,t_azi04)
              LET g_pml2.pml930=g_pml[l_ac].pml930 #FUN-670051
              IF cl_null(g_pml[l_ac].pml12) THEN     #No:8841
                 LET g_pml[l_ac].pml12=' '
              END IF
              IF cl_null(g_pml[l_ac].pml121) THEN     #No:8841
                  LET g_pml[l_ac].pml121=' '              #FUN-810045
              END IF
              IF cl_null(g_pml[l_ac].pml122) THEN     #No:8841
                LET g_pml[l_ac].pml122=' '              #FUN-810045
              END IF
              IF cl_null(g_pml[l_ac].pml90) THEN
                 LET g_pml[l_ac].pml90=' '
              END IF
              LET g_pml2.pml24 =g_pml[l_ac].pml24
              LET g_pml2.pml25 =g_pml[l_ac].pml25
              CALL t420_b_move_back() #FUN-730068
              IF cl_null(g_pml2.pml49) THEN LET g_pml2.pml49='1' END IF
              IF cl_null(g_pml2.pml50) THEN LET g_pml2.pml50='1' END IF
              IF cl_null(g_pml2.pml54) THEN LET g_pml2.pml54='2' END IF
              IF cl_null(g_pml2.pml56) THEN LET g_pml2.pml56='1' END IF
              LET g_pml2.pmlplant =g_plant  #FUN-980006 add
              LET g_pml2.pmllegal =g_legal  #FUN-980006 add
              LET g_pml2.pml92 = 'N'  #FUN-9B0023
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#             LET l_sql = " SELECT ata03,ata04,ata08 FROM ata_file ",
#                         "  WHERE ata00 = '",g_prog,"'",
#                         "    AND ata01 = '",g_pmk.pmk01,"'",
#                         "    AND ata02 = ",g_pml[l_ac].pml02
#             DECLARE t420_ata_curs SCROLL CURSOR FROM l_sql
#             FOREACH t420_ata_curs INTO g_pml2.pml02,g_pml2.pml04,g_pml2.pml20
#             LET g_pml2.pml31=(g_pml2.pml20/g_pml[l_ac].pml20)*g_pml[l_ac].pml31
#             LET g_pml2.pml31t=(g_pml2.pml20/g_pml[l_ac].pml20)*g_pml[l_ac].pml31t
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
             #MOD-AA0099---add---start---
              CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,
                            g_pml2.pml08) RETURNING l_flag,g_pml2.pml09
              IF l_flag THEN
                 CALL cl_err(g_pml[l_ac].pml07,'mfg1206',0)
                 LET g_pml[l_ac].pml07 = g_pml2.pml07
              END IF
              IF cl_null(g_pml2.pml09) THEN LET g_pml2.pml09=1 END IF
             #MOD-AA0099---add---end---
              INSERT INTO pml_file VALUES(g_pml2.*)
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("ins","pml_file",g_pml2.pml01,g_pml2.pml02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
                 CANCEL INSERT
              ELSE
                    MESSAGE 'INSERT O.K'
                    LET g_rec_b=g_rec_b+1
                    LET l_pmk25 = '0'
                    CALL t420_update() #MOD-960034
                    DISPLAY g_rec_b TO FORMONLY.cn2

              END IF
#FUN-A60035 ---MARK BEGIN
#&ifdef SLK
#   END FOREACH   #FUN-A50054 add
#&endif
#                    MESSAGE 'INSERT O.K'
#                    LET g_rec_b=g_rec_b+1
#                    LET l_pmk25 = '0'
#                    CALL t420_update() #MOD-960034
#                    DISPLAY g_rec_b TO FORMONLY.cn2
##FUN-A50054 --Begin
#&ifndef SLK
#                    COMMIT WORK
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
          BEFORE INSERT
             LET l_n = ARR_COUNT()
             INITIALIZE arr_detail[l_ac].* TO NULL   #No.TQC-650108
             #No.FUN-BB0086--add--begin--
             LET g_pml07_t = NULL
             LET g_pml80_t = NULL
             LET g_pml83_t = NULL
             LET g_pml86_t = NULL
             #No.FUN-BB0086--add--end--
             IF l_ac = 1 THEN
                INITIALIZE g_pml[l_ac].* TO NULL
                LET g_pml[l_ac].pml92 = 'N'  #FUN-9A0065
                LET g_pml[l_ac].pml38 = g_pmk.pmk45        #MPS/MRP 可用/不可用   #FUN-690047 add
             ELSE
                LET g_pml[l_ac].* = g_pml[l_ac-1].*
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#              SELECT MAX(ata02)+1 INTO g_pml[l_ac].pml02
#                FROM ata_file WHERE ata00 = g_prog
#                 AND ata01 = g_pmk.pmk01
#              IF g_pml[l_ac].pml02 IS NULL THEN
#                 LET g_pml[l_ac].pml02 = g_pml[l_ac-1].pml02+1
#              END IF
#&else
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                SELECT MAX(pml02)+1 INTO g_pml[l_ac].pml02 FROM pml_file
                 WHERE pml01 = g_pmk.pmk01
                IF g_pml[l_ac].pml02 IS NULL THEN
                   LET g_pml[l_ac].pml02 = g_pml[l_ac-1].pml02+1
                END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                LET g_pml[l_ac].pml04=''   #MOD-A50129
                LET g_pml[l_ac].pml041=''   #MOD-A50129
                LET g_pml[l_ac].pml38 = g_pmk.pmk45        #MPS/MRP 可用/不可用   #FUN-690047 add
                LET g_change='Y'
                LET g_pml[l_ac].pml82 = 0
                LET g_pml[l_ac].pml85 = 0
                LET g_pml[l_ac].pml87 = 0
                LET g_pml[l_ac].pml92 = 'N'  #FUN-9A0065
                LET g_pml[l_ac].pml33 =''
                LET g_pml[l_ac].pml34 =''
                LET g_pml[l_ac].pml35 =''
                LET g_pml[l_ac].pml24 =''
                LET g_pml[l_ac].pml25 =''
                LET g_pml[l_ac].pml06 =''   #MOD-C80244 add
             END IF
             LET l_ins_flag = 'Y'
             INITIALIZE g_pml2.* TO NULL
             INITIALIZE g_pml_o.* TO NULL
             INITIALIZE g_pml_t.* TO NULL
             CALL t420_azi()
             IF l_ac =1 THEN
                LET g_pml[l_ac].pml82 = 0
                LET g_pml[l_ac].pml85 = 0
                LET g_pml[l_ac].pml87 = 0
             END IF
             IF g_azw.azw04 = '2' THEN
                IF g_pmk.pmk46='1' OR g_pmk.pmk46='2' THEN
                   LET g_pml[l_ac].pml54='1'
                ELSE
                   IF g_pmk.pmk46='3' OR g_pmk.pmk46='4' THEN
                      LET g_pml[l_ac].pml54='2'
                   END IF
                END IF
                IF NOT cl_null(g_pmk.pmk09) THEN
                   LET g_pml[l_ac].pml48=g_pmk.pmk09
                END IF
                LET g_pml[l_ac].pml56='1'
                LET g_pml[l_ac].pml55=TIME
              END IF
             LET g_pml2.pml01 = g_pmk.pmk01
             LET g_pml2.pml011= g_pmk.pmk02
             LET g_pml2.pml16 = g_pmk.pmk25
             LET g_pml[l_ac].pml16 = g_pmk.pmk25 #FUN-990080
             IF l_ac = 1 THEN
                LET g_pml2.pml09 = 1
             ELSE
                SELECT pml08,pml09 INTO g_pml2.pml08,g_pml2.pml09 FROM pml_file
                  WHERE pml01 = g_pmk.pmk01 AND pml02 = g_pml[l_ac-1].pml02
             END IF
             LET g_pml2.pml11 ='N'         #凍結碼
             LET g_pml[l_ac].pml11 = g_pml2.pml11        #凍結碼  #MOD-840201 add
             LET g_pml2.pml91 = 'N'                      #No.FUN-920183 add
             LET g_pml[l_ac].pml91 = g_pml2.pml91        #No.FUN-920183 add
             LET g_pml2.pml13 =0           #超短交限率
             LET g_pml2.pml14 =g_sma.sma886[1,1]         #部份交貨
             LET g_pml2.pml15 =g_sma.sma886[2,2]         #提前交貨
             LET g_pml2.pml82 = 0          #單位一數量
             LET g_pml2.pml85 = 0          #單位二數量
             LET g_pml2.pml87 = 0          #計價單位數量
             LET g_pml2.pml21 = 0          #已轉採購量
            LET g_pml[l_ac].pml12 = g_pmk.pmk05   #專案代號
            LET g_pml[l_ac].pml121 = ''           #WBS
            LET g_pml[l_ac].pml122 = ''           #活動
            LET g_pml[l_ac].pml67  = g_pmk.pmk13  #部門
            LET g_pml[l_ac].pml90 = ''           #費用原因
            LET g_pml2.pml12 = g_pmk.pmk05   #專案代號
            LET g_pml2.pml121 = ''           #WBS
            LET g_pml2.pml122 = ''           #活動
            LET g_pml2.pml67  = g_pmk.pmk13  #部門
            LET g_pml2.pml90 = ''           #費用原因
             LET g_pml2.pml23 = 'Y'        #課稅否
             LET g_pml2.pml30 = 0          #標準價格
             LET g_pml2.pml31 = 0          #單價
             LET g_pml2.pml31t= 0          #含稅單價  No.FUN-550019
             LET g_pml2.pml32 = 0          #PPV
            #單身的pml38(可用/不可用)預設跟單頭的pmn45一樣
             LET g_pml2.pml38 = g_pmk.pmk45        #MPS/MRP 可用/不可用
             LET g_pml2.pml42 = '0'        #替代碼
             LET g_pml2.pml44 = 0          #本幣單價
             LET g_pml2.pml192 = "N"       #No.FUN-630040
             LET g_pml2.pml190 = 'N'               #No.MOD-6A0014 add
             LET g_pml[l_ac].pml190 = 'N'          #No.MOD-6A0014 add
             LET g_pml2.pml35  = g_pml2.pml18   #No.TQC-640132
             LET g_pml[l_ac].pml192 = "N"  #No.FUN-630040
             LET g_pml2.pmlplant = g_pmk.pmkplant #No.FUN-870007
             LET g_pml2.pmllegal = g_pmk.pmklegal #No.FUN-870007
             LET g_pml[l_ac].pml930=s_costcenter(g_pmk.pmk13)
             LET g_pml2.pml930=g_pml[l_ac].pml930
             CALL t420_set_pml930(g_pml[l_ac].pml930) RETURNING g_pml[l_ac].gem02a
             LET g_pml_t.* = g_pml[l_ac].*         #新輸入資料
             IF l_ac >1 THEN
                CALL t420_pml04('a','bi')   #MOD-920166
             END IF
             LET p_cmd='a'
             CALL t420_sel_ima()
             CALL t420_set_entry_b('u')
             CALL t420_set_no_entry_b('u')
             CALL t420_set_no_required()
             CALL t420_set_required()
             #CALL cl_set_comp_required("pml20",TRUE) #No.FUN-870007   #MOD-BB0233 mark
             CALL cl_show_fld_cont()     #FUN-550037(smin)
             NEXT FIELD pml02

          BEFORE FIELD pml02                        #default 序號
             IF g_pml[l_ac].pml02 IS NULL OR g_pml[l_ac].pml02 = 0 THEN
#FUN-A60035 ---MARK BEGIN
#&ifdef SLK
##FUN-A50054 --Begin
#              SELECT MAX(ata02)+1 INTO g_pml[l_ac].pml02
#                FROM ata_file WHERE ata00 = g_prog
#                 AND ata01 = g_pmk.pmk01
#                  IF g_pml[l_ac].pml02 IS NULL THEN
#                     LET g_pml[l_ac].pml02 = 1
#                  END IF
##FUN-A50054 --End
#&else
#FUN-A60035 ---MARK END
                SELECT max(pml02)+1 INTO g_pml[l_ac].pml02
                  FROM pml_file WHERE pml01 = g_pmk.pmk01
                IF g_pml[l_ac].pml02 IS NULL THEN
                    LET g_pml[l_ac].pml02 = 1
                END IF
#&endif             #FUN-A60035 ---MARK
             END IF
          AFTER FIELD pml02                        #check 序號是否重複
             IF g_pml[l_ac].pml02 IS NULL THEN
                LET g_pml[l_ac].pml02 = g_pml_t.pml02
             END IF
             IF g_pml[l_ac].pml02=0 THEN
                CALL cl_err('','apm-422',1)
                LET g_pml[l_ac].pml02 = g_pml_t.pml02
                NEXT FIELD pml02
             END IF
             IF NOT cl_null(g_pml[l_ac].pml02) THEN
                 IF g_pml[l_ac].pml02 != g_pml_t.pml02 OR
                    g_pml_t.pml02 IS NULL THEN
                    LET g_pmli.pmli02=g_pml[l_ac].pml02   #No.TQC-970335
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#                    SELECT COUNT(*) INTO l_n FROM ata_file
#                     WHERE ata00 = g_prog
#                       AND ata01 = g_pmk.pmk01
#                       AND ata02 = g_pml[l_ac].pml02
#&else
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                    SELECT count(*) INTO l_n FROM pml_file
                      WHERE pml01 = g_pmk.pmk01 AND
                            pml02 = g_pml[l_ac].pml02
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin
#&endif
##FUN-A50054---end
#FUN-A60035 ---MARK END
                    IF l_n > 0 THEN
                       CALL cl_err('',-239,0)
                       LET g_pml[l_ac].pml02 = g_pml_t.pml02
                       NEXT FIELD pml02
#MOD-B60119 -- begin --
                    ELSE
                       UPDATE pmo_file SET pmo03 = g_pml[l_ac].pml02
                          WHERE pmo01 = g_pmk.pmk01
                          AND pmo03 = g_pml_o.pml02
#MOD-B60119 -- end --
                    END IF
                 END IF
                 SELECT pml92,pml93 INTO g_pml[l_ac].pml92,g_pml[l_ac].pml93
                   FROM pml_file
                  WHERE pml01 = g_pmk.pmk01 AND
                        pml02 = g_pml[l_ac].pml02
                 LET g_pml2.pml02 = g_pml[l_ac].pml02
                 LET g_pml_o.pml02 = g_pml[l_ac].pml02
#                DISPLAY BY NAME g_pml[l_ac].*   #MOD-920166    #MOD-AA0084
             END IF

          AFTER FIELD pml47
             IF NOT cl_null(g_pml[l_ac].pml47) THEN
#FUN-AB0025 ----------mark start----------
#               #FUN-AA0059 ---------------------start----------------------------
#               IF NOT s_chk_item_no(g_pml[l_ac].pml47,"") THEN
#                  CALL cl_err('',g_errno,1)
#                  NEXT FIELD pml47
#               END IF
#               #FUN-AA0059 ---------------------end-------------------------------
#FUN-AB0025 ----------mark end------------
                #商品條碼必須是商品條碼維護作業中的有效商品!
                LET l_cnt=0
                SELECT count(*) INTO l_cnt FROM rta_file
                 WHERE rta05=g_pml[l_ac].pml47 AND rtaacti='Y'
                IF l_cnt=0 THEN
                   CALL cl_err('','art-231',1)
                   NEXT FIELD pml47
                END IF
                SELECT rta01,rta03 INTO g_pml[l_ac].pml04,g_pml[l_ac].pml07 FROM rta_file
                 WHERE rta05=g_pml[l_ac].pml47
                CALL check_pml04_1() RETURNING li_result
                IF NOT li_result THEN
                   NEXT FIELD pml47
                END IF
                SELECT ima02,ima021 INTO g_pml[l_ac].pml041,g_pml[l_ac].ima021 FROM ima_file
                 WHERE ima01=g_pml[l_ac].pml04
                CALL t420_pml4953('d')
                CALL t420_pml48('d')
                IF p_cmd='u' THEN
                   CALL cl_set_comp_entry("pml04",FALSE)
                END IF
             END IF
          BEFORE FIELD pml04
             CALL t420_set_entry_b(p_cmd)
             CALL t420_set_no_required()
             LET g_pml04_y= g_pml[l_ac].pml04

          AFTER FIELD pml04     # check 料件編號
#FUN-AA0059 ---------------------start----------------------------
            IF NOT cl_null(g_pml[l_ac].pml04) THEN
              IF g_pml[l_ac].pml04[1,4] != 'MISC' THEN        #TQC-B30200
                IF NOT s_chk_item_no(g_pml[l_ac].pml04,"") THEN
                   CALL cl_err('',g_errno,1)
                   NEXT FIELD pml04
                END IF
              END IF                                          #TQC-B30200
            #FUN-C30075---add---START
              SELECT ima928 INTO l_ima928 FROM ima_file WHERE ima01 = g_pml[l_ac].pml04
              IF l_ima928 = 'Y' THEN
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt FROM pnc_file WHERE pnc01 = g_pml[l_ac].pml04
                IF l_cnt <= 0 THEN
                   CALL cl_err('','apm1092',0)
                   NEXT FIELD pml04
                END IF
              END IF
            #FUN-C30075---add-----END
            END IF
#FUN-AA0059 ---------------------end-------------------------------
             IF NOT s_chkima08(g_pml[l_ac].pml04) THEN
                NEXT FIELD CURRENT
             END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---begin add
#&ifdef SLK
#            SELECT ima151 INTO l_ima151                                                  #FUN-A60035
#              FROM ima_file                                                                #FUN-A60035
#             WHERE ima01 = g_pml[l_ac].pml04                                               #FUN-A60035
#            CALL cl_set_comp_entry("oeb12",FALSE)
#              IF g_sma.sma908='Y' AND g_sma.sma120='Y' AND l_ima151='Y' THEN               #FUN-A60035
#                 CALL s_detail(g_prog,g_pmk.pmk01,g_pml[l_ac].pml02,g_pml[l_ac].pml04,'N') #FUN-A50054
#                             RETURNING g_pml[l_ac].pml20
#                 SELECT ima25 INTO l_ima25
#                   FROM ima_file
#                  WHERE ima01 = g_pml[l_ac].pml04
#                 CALL t420_check_pml04('pml04',l_ac,p_cmd) RETURNING
#                      l_check_res
#                 IF NOT l_check_res THEN NEXT FIELD pml04 END IF
#                 DISPLAY BY NAME g_pml[l_ac].pml20
#              ELSE
#              END IF
#&else
##FUN-A50054---End add
#             CALL cl_set_comp_entry("pml20",TRUE)   #FUN-A50054 add
#FUN-A60035 ---MARK END
             #AFTER FIELD 處理邏輯修改為使用下面的函數來進行判斷，請參考相關代碼
             CALL t420_check_pml04('pml04',l_ac,p_cmd) RETURNING #No.MOD-660090
                   l_check_res
             IF NOT l_check_res THEN NEXT FIELD pml04 END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin add
#&endif
##FUN-A50054---End
#FUN-A60035 ---MARK END
          #如果設置為不允許新增
             IF (g_pml_o.pml04 IS NULL OR g_pml[l_ac].pml04 != g_pml_o.pml04)
                AND (g_pml[l_ac].pml04[1,4] != 'MISC') THEN
                IF g_sma.sma908 = 'N' THEN
                   SELECT COUNT(*) INTO l_n FROM ima_file WHERE ima01 =g_pml[l_ac].pml04
                   IF l_n =0 THEN
                      LET g_pml[l_ac].pml04 =NULL
                      CALL cl_err(g_pml[l_ac].pml04,'ams-003',1)
                      NEXT FIELD pml04
                   END IF
                END IF
             END IF   #No.TQC-7C0144
#使用多屬性時，過料件編號，只要料號存在，母料號也可過
          IF g_sma.sma120 = 'N' THEN                  #No.FUN-830086
             SELECT imaag INTO l_imaag FROM ima_file  #母料件不可過
              WHERE ima01 = g_pml[l_ac].pml04
             IF NOT cl_null(l_imaag) AND l_imaag <> '@CHILD' THEN
                LET g_pml[l_ac].pml041 = NULL
                LET g_pml[l_ac].ima021 = NULL
                DISPLAY BY NAME g_pml[l_ac].*
                CALL cl_err(g_pml[l_ac].pml04,'aim1004',0)
                NEXT FIELD pml04
             END IF
          END IF                                      #No.FUN-830086
          IF g_azw.azw04 = '2' THEN
             IF cl_null(g_pml[l_ac].pml47) AND NOT cl_null(g_pml[l_ac].pml04) THEN
                CALL check_pml04_1() RETURNING li_result
                IF NOT li_result THEN
                   NEXT FIELD pml04
                END IF
                SELECT ima02,ima021
                  INTO g_pml[l_ac].pml041,g_pml[l_ac].ima021
                  FROM ima_file
                 WHERE ima01=g_pml[l_ac].pml04
                CALL cl_set_comp_entry("pml041,ima021",FALSE)
                CALL t420_pml4953('d')
                CALL cl_set_comp_entry("pml49,pml50,pml51,pml52,pml53",FALSE)
                CALL t420_pml48('d')
             END IF
         END IF
         CALL t420_set_pml191()    #No.FUN-A10037
         CALL t420_get_pml041()    #MOD-B90082 add
         DISPLAY BY NAME g_pml[l_ac].*                       #MOD-AA0084

      #當sma908 <> 'Y'的時候,即不准通過單身來新增子料件,這時
      #對于采用料件多屬性新機制(與單據性質綁定)的分支來說,各個明細屬性欄位都
      #變NOENTRY的, 只能通過在母料件欄位開窗來選擇子料件,并且母料件本身也不允許
      #接受輸入,而只能開窗,所以這里要進行一個特殊的處理,就是一進att00母料件
      #欄位的時候就auto開窗,開完窗之后直接NEXT FIELD以避免用戶亂動
      #其他分支就不需要這么麻煩了
      BEFORE FIELD att00

            #根據子料件找到母料件及各個屬性
            SELECT imx00,imx01,imx02,imx03,imx04,imx05,
                   imx06,imx07,imx08,imx09,imx10
            INTO g_pml[l_ac].att00, g_pml[l_ac].att01, g_pml[l_ac].att02,
                 g_pml[l_ac].att03, g_pml[l_ac].att04, g_pml[l_ac].att05,
                 g_pml[l_ac].att06, g_pml[l_ac].att07, g_pml[l_ac].att08,
                 g_pml[l_ac].att09, g_pml[l_ac].att10
            FROM imx_file
            WHERE imx000 = g_pml[l_ac].pml04
            #賦值所有屬性
            LET g_pml[l_ac].att01_c = g_pml[l_ac].att01
            LET g_pml[l_ac].att02_c = g_pml[l_ac].att02
            LET g_pml[l_ac].att03_c = g_pml[l_ac].att03
            LET g_pml[l_ac].att04_c = g_pml[l_ac].att04
            LET g_pml[l_ac].att05_c = g_pml[l_ac].att05
            LET g_pml[l_ac].att06_c = g_pml[l_ac].att06
            LET g_pml[l_ac].att07_c = g_pml[l_ac].att07
            LET g_pml[l_ac].att08_c = g_pml[l_ac].att08
            LET g_pml[l_ac].att09_c = g_pml[l_ac].att09
            LET g_pml[l_ac].att10_c = g_pml[l_ac].att10
            #顯示所有屬性
            DISPLAY BY NAME
              g_pml[l_ac].att01, g_pml[l_ac].att01_c,
              g_pml[l_ac].att02, g_pml[l_ac].att02_c,
              g_pml[l_ac].att03, g_pml[l_ac].att03_c,
              g_pml[l_ac].att04, g_pml[l_ac].att04_c,
              g_pml[l_ac].att05, g_pml[l_ac].att05_c,
              g_pml[l_ac].att06, g_pml[l_ac].att06_c,
              g_pml[l_ac].att07, g_pml[l_ac].att07_c,
              g_pml[l_ac].att08, g_pml[l_ac].att08_c,
              g_pml[l_ac].att09, g_pml[l_ac].att09_c,
              g_pml[l_ac].att10, g_pml[l_ac].att10_c

      #以下是為料件多屬性機制新增的20個屬性欄位的AFTER FIELD代碼
      #下面是十個輸入型屬性欄位的判斷語句
      AFTER FIELD att00
          #FUN-AB0025 ------------add start----------
          IF NOT cl_null(g_pml[l_ac].att00) THEN
             IF NOT s_chk_item_no(g_pml[l_ac].att00,'') THEN
                CALL cl_err('',g_errno,1)
                NEXT FIELD att00
             END IF
          END IF
          #FUN-AB0025 ------------add end------------
          #檢查att00里面輸入的母料件是否是符合對應屬性組的母料件
          SELECT COUNT(ima01) INTO l_count FROM ima_file
            WHERE ima01 = g_pml[l_ac].att00 AND imaag = lg_smy62
          IF l_count = 0 THEN
             CALL cl_err_msg('','aim-909',lg_smy62,0)
             NEXT FIELD att00
          END IF

          #如果設置為不允許新增
          IF g_sma.sma908 <> 'Y' THEN
             CALL t420_check_pml04('imx00',l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
             IF NOT l_check_res THEN NEXT FIELD att00 END IF
          END IF

      AFTER FIELD att01
          CALL t420_check_att0x(g_pml[l_ac].att01,1,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att01 END IF
      AFTER FIELD att02
          CALL t420_check_att0x(g_pml[l_ac].att02,2,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att02 END IF
      AFTER FIELD att03
          CALL t420_check_att0x(g_pml[l_ac].att03,3,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att03 END IF
      AFTER FIELD att04
          CALL t420_check_att0x(g_pml[l_ac].att04,4,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att04 END IF
      AFTER FIELD att05
          CALL t420_check_att0x(g_pml[l_ac].att05,5,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att05 END IF
      AFTER FIELD att06
          CALL t420_check_att0x(g_pml[l_ac].att06,6,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att06 END IF
      AFTER FIELD att07
          CALL t420_check_att0x(g_pml[l_ac].att07,7,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att07 END IF
      AFTER FIELD att08
          CALL t420_check_att0x(g_pml[l_ac].att08,8,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att08 END IF
      AFTER FIELD att09
          CALL t420_check_att0x(g_pml[l_ac].att09,9,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att09 END IF
      AFTER FIELD att10
          CALL t420_check_att0x(g_pml[l_ac].att10,10,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att10 END IF
      #下面是十個輸入型屬性欄位的判斷語句
      AFTER FIELD att01_c
          CALL t420_check_att0x_c(g_pml[l_ac].att01_c,1,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att01_c END IF
      AFTER FIELD att02_c
          CALL t420_check_att0x_c(g_pml[l_ac].att02_c,2,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att02_c END IF
      AFTER FIELD att03_c
          CALL t420_check_att0x_c(g_pml[l_ac].att03_c,3,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att03_c END IF
      AFTER FIELD att04_c
          CALL t420_check_att0x_c(g_pml[l_ac].att04_c,4,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att04_c END IF
      AFTER FIELD att05_c
          CALL t420_check_att0x_c(g_pml[l_ac].att05_c,5,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att05_c END IF
      AFTER FIELD att06_c
          CALL t420_check_att0x_c(g_pml[l_ac].att06_c,6,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att06_c END IF
      AFTER FIELD att07_c
          CALL t420_check_att0x_c(g_pml[l_ac].att07_c,7,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att07_c END IF
      AFTER FIELD att08_c
          CALL t420_check_att0x_c(g_pml[l_ac].att08_c,8,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att08_c END IF
      AFTER FIELD att09_c
          CALL t420_check_att0x_c(g_pml[l_ac].att09_c,9,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att09_c END IF
      AFTER FIELD att10_c
          CALL t420_check_att0x_c(g_pml[l_ac].att10_c,10,l_ac,p_cmd) RETURNING #No.MOD-660090
               l_check_res
          IF NOT l_check_res THEN NEXT FIELD att10_c END IF

          AFTER FIELD pml041
             LET g_pml2.pml041 = g_pml[l_ac].pml041
             LET g_pml_o.pml041 = g_pml[l_ac].pml041

          AFTER FIELD pml07    #請購單位
             IF g_pml_t.pml07 IS NULL AND g_pml[l_ac].pml07 IS NOT NULL OR
                g_pml_t.pml07 IS NOT NULL AND g_pml[l_ac].pml07 IS NULL OR
                g_pml_t.pml07 <> g_pml[l_ac].pml07 THEN
                LET g_change='Y'
             END IF
             IF NOT cl_null(g_pml[l_ac].pml07) THEN
                IF g_pml_o.pml07 IS NULL OR (g_pml_t.pml07 IS NULL)
                   OR (g_pml[l_ac].pml07 != g_pml_o.pml07) THEN
                   CALL t420_unit(g_pml[l_ac].pml07)
                   IF NOT cl_null(g_errno) THEN
                      CALL cl_err(g_pml[l_ac].pml07,g_errno,0)
                      LET g_pml[l_ac].pml07 = g_pml_o.pml07
                      NEXT FIELD pml07
                   END IF
                END IF
                IF g_pml[l_ac].pml07 = g_pml2.pml08 THEN
                   LET g_pml2.pml09 = 1
                ELSE
                   IF ( cl_null(g_pml_o.pml07) AND NOT cl_null(g_pml2.pml08))
                      OR (g_pml[l_ac].pml07 != g_pml_o.pml07 AND
                      NOT cl_null(g_pml2.pml08) ) THEN
                      CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,
                        g_pml2.pml08) RETURNING l_flag,g_pml2.pml09
                      IF l_flag THEN
                         CALL cl_err(g_pml[l_ac].pml07,'mfg1206',0)
                         LET g_pml[l_ac].pml07 = g_pml2.pml07
                         NEXT FIELD pml07
                      END IF
                      IF cl_null(g_pml2.pml09) THEN LET g_pml2.pml09=1 END IF
                   END IF
                END IF
                LET g_pml2.pml07 = g_pml[l_ac].pml07
                LET g_pml_o.pml07 = g_pml[l_ac].pml07
                IF g_change='Y' THEN
                   IF g_sma.sma116 MATCHES '[02]' THEN
                      LET g_pml[l_ac].pml86 = g_pml[l_ac].pml07
                   END IF
                   CALL t420_set_pml87()
                   IF g_sma.sma116 MATCHES '[02]' THEN
                      LET g_pml[l_ac].pml87 = g_pml[l_ac].pml20
                   END IF
                   DISPLAY BY NAME g_pml[l_ac].pml87
                  CALL t420_bud(p_cmd,'3')
                  IF NOT cl_null(g_errno) THEN
                     NEXT FIELD pml07
                  END IF
                END IF
                #No.FUN-BB0086--add--begin--
                IF NOT cl_null(g_pml[l_ac].pml20) AND g_pml[l_ac].pml20<>0 THEN  #TQC-C20183 add
                   IF NOT t420_pml20_check(p_cmd) THEN
                      LET g_pml07_t = g_pml[l_ac].pml07
                      NEXT FIELD pml20
                   END IF
                END IF
                LET g_pml07_t = g_pml[l_ac].pml07
                #No.FUN-BB0086--add--end--
             END IF
         AFTER FIELD pml48
            IF NOT cl_null(g_pml[l_ac].pml48) THEN
               IF g_pml_t.pml48 IS NULL OR g_pml[l_ac].pml48 !=g_pml_t.pml48 THEN
                   IF cl_null(g_pmk.pmk09) THEN
                      SELECT pmc05,pmc30,pmcacti,pmc930
                        INTO l_pmc05,l_pmc30,l_pmcacti,l_pmc930
                        FROM pmc_file
                       WHERE pmc01 = g_pml[l_ac].pml48
                      IF SQLCA.SQLCODE = 100  THEN
                         CALL cl_err('','mfg3014',0)
                         NEXT FIELD pml48
                      END IF
                      IF l_pmcacti != 'Y' THEN
                         CALL cl_err('','art-471',0)
                         NEXT FIELD pml48
                      END IF
                      IF l_pmc05 !='1' THEN
                         CALL cl_err('','art-472',0)
                         NEXT FIELD pml48
                      END IF
                      IF l_pmc30  ='2' THEN
                         CALL cl_err('','apm-420',0)
                         NEXT FIELD pml48
                      END IF
                      IF NOT cl_null(l_pmc930) THEN
                         IF l_pmc930=g_plant THEN
                            CALL cl_err('','art-445',0)
                            NEXT FIELD pml48
                         END IF
                      END IF
                      LET l_cnt =0
                      SELECT COUNT(*) INTO l_cnt FROM rto_file,rtt_file,rts_file
                       WHERE rto05=g_pml[l_ac].pml48 AND rtt04=g_pml[l_ac].pml04 AND rtt15='Y'
                         AND rtt930=g_plant AND rtsconf='Y' AND rts04=rto01 AND rto08<=g_pmk.pmk04
                         AND rto09>=g_pmk.pmk04 AND rtt01=rts01 AND rtt02=rts02 AND rttplant=rtsplant
                         AND rtoplant=g_plant
                      IF l_cnt=0 THEN
                         LET l_cnt=0
                         SELECT COUNT(*) INTO l_cnt FROM pmc_file
                          WHERE pmc01=g_pml[l_ac].pml48
                            AND pmc05='1'
                            AND pmc30 !='2'
                            AND pmcacti='Y'
                            AND (pmc930 !=g_plant OR pmc930 IS NULL)
                         IF l_cnt=0 THEN
                            CALL cl_err('','art-479',0)
                            NEXT FIELD pml48
                         END IF
                      END IF
                      CALL t420_pml48('d')
                   END IF
                END IF
           END IF

          BEFORE FIELD pml20
            CALL t420_set_no_required()

          AFTER FIELD pml20   #請購數量
             IF NOT t420_pml20_check(p_cmd) THEN NEXT FIELD pml20 END IF   #No.FUN-BB0086
             #No.FUN-BB0086--mark--begin--
             #IF g_pml_t.pml20 IS NULL AND g_pml[l_ac].pml20 IS NOT NULL OR
             #   g_pml_t.pml20 IS NOT NULL AND g_pml[l_ac].pml20 IS NULL OR
             #   g_pml_t.pml20 <> g_pml[l_ac].pml20 THEN
             #   LET g_change='Y'
             #END IF
             #IF NOT cl_null(g_pml[l_ac].pml20) THEN
             #   IF g_pml[l_ac].pml20 <= 0  THEN
             #      CALL cl_err(g_pml[l_ac].pml20,'mfg0013',1)
             #      LET g_pml[l_ac].pml20 = g_pml_o.pml20
             #      NEXT FIELD pml20
             #   END IF
             #    IF p_cmd = 'u' THEN
             #       IF g_pml[l_ac].pml20 < g_pml[l_ac].pml21 THEN
             #          CALL cl_err(g_pml[l_ac].pml20,'mfg3082',1)
             #          LET g_pml[l_ac].pml20 = g_pml_t.pml20
             #          NEXT FIELD pml20
             #       END IF
             #    END IF
             #    IF (cl_null(g_pml_o.pml20) OR g_pml[l_ac].pml20 != g_pml_o.pml20 )
             #       AND (g_no[1,4] != 'MISC') THEN
             #       CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang)
             #        RETURNING g_pml[l_ac].pml20
             #    END IF
             #    DISPLAY BY NAME g_pml[l_ac].pml20
             #    #for專案
             #    IF NOT cl_null(g_pml[l_ac].pml12)
             #       AND NOT cl_null(g_pml[l_ac].pml121)
             #       AND NOT cl_null(g_pml[l_ac].pml122)
             #       AND g_pml[l_ac].pml12 != ' '
             #       AND g_pml[l_ac].pml121 != ' '
             #       AND g_pml[l_ac].pml122 != ' '
             #    THEN
             #       IF cl_null(g_pml_t.pml20) THEN LET g_pml_t.pml20=0 END IF
             #       CALL t420_chk_pjf05(g_pml[l_ac].pml121,g_pml[l_ac].pml04,g_pml_t.pml20)
             #       IF NOT cl_null(g_errno) THEN CALL cl_err('',g_errno,'1') END IF
             #    END IF
             #    LET g_pml2.pml20 = g_pml[l_ac].pml20
             #    LET g_pml_o.pml20 = g_pml[l_ac].pml20
             #    IF cl_null(g_pml[l_ac].pml86) THEN
             #       LET g_pml[l_ac].pml86=g_pml[l_ac].pml07
             #       LET g_pml[l_ac].pml87=g_pml[l_ac].pml20
             #       DISPLAY BY NAME g_pml[l_ac].pml86
             #       DISPLAY BY NAME g_pml[l_ac].pml87
             #    END IF
             #    CALL t420_set_required() #FUN-810045 add
             #    IF g_change='Y' THEN
             #       CALL t420_set_pml87()
             #      IF g_sma.sma116 MATCHES '[02]' THEN
             #         LET g_pml[l_ac].pml87 = g_pml[l_ac].pml20
             #      END IF
             #       DISPLAY BY NAME g_pml[l_ac].pml87
             #      CALL t420_bud(p_cmd,'3')
             #      IF NOT cl_null(g_errno) THEN
             #         NEXT FIELD pml20
             #      END IF
             #    END IF
             #END IF
             #No.FUN-BB0086--mark--end--

        BEFORE FIELD pml83
           CALL t420_sel_ima()
           CALL t420_set_no_required()

        AFTER FIELD pml83  #第二單位
           IF cl_null(g_pml[l_ac].pml04) THEN NEXT FIELD pml04 END IF
           IF g_pml_t.pml83 IS NULL AND g_pml[l_ac].pml83 IS NOT NULL OR
              g_pml_t.pml83 IS NOT NULL AND g_pml[l_ac].pml83 IS NULL OR
              g_pml_t.pml83 <> g_pml[l_ac].pml83 THEN
              LET g_change='Y'
           END IF
           IF NOT cl_null(g_pml[l_ac].pml83) THEN
              IF g_pml_o.pml83 IS NULL OR (g_pml_t.pml83 IS NULL)
                 OR (g_pml[l_ac].pml83 != g_pml_o.pml83) THEN
                 CALL t420_unit(g_pml[l_ac].pml83)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pml[l_ac].pml83,g_errno,0)
                    LET g_pml[l_ac].pml83 = g_pml_o.pml83
                    NEXT FIELD pml83
                 END IF
              END IF
              CALL s_du_umfchk(g_pml[l_ac].pml04,'','','',
                               g_ima44,g_pml[l_ac].pml83,g_ima906)
                   RETURNING g_errno,g_factor
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_pml[l_ac].pml83,g_errno,0)
                 NEXT FIELD pml83
              END IF
              IF cl_null(g_pml_t.pml83) OR g_pml_t.pml83 <> g_pml[l_ac].pml83 THEN
                 LET g_pml[l_ac].pml84 = g_factor
                 DISPLAY BY NAME g_pml[l_ac].pml84
              END IF
              LET g_pml2.pml83 = g_pml[l_ac].pml83
              LET g_pml_o.pml83 = g_pml[l_ac].pml83
              #No.FUN-BB0086--add--begin--
              IF NOT cl_null(g_pml[l_ac].pml85) AND g_pml[l_ac].pml85<>0 THEN  #TQC-C20183 add
                 IF NOT t420_pml85_check(p_cmd) THEN
                    LET g_pml83_t = g_pml[l_ac].pml83
                    NEXT FIELD pml85
                 END IF
              END IF
              LET g_pml83_t = g_pml[l_ac].pml83
              #No.FUN-BB0086--add--end--
           END IF
           IF g_change='Y' THEN
              CALL t420_set_pml87()
              DISPLAY BY NAME g_pml[l_ac].pml87
              CALL t420_bud(p_cmd,'3')
              IF NOT cl_null(g_errno) THEN
                 NEXT FIELD pml83
              END IF
           END IF
           CALL t420_set_required()
           CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

        AFTER FIELD pml84  #第二轉換率
           IF g_pml_t.pml84 IS NULL AND g_pml[l_ac].pml84 IS NOT NULL OR
              g_pml_t.pml84 IS NOT NULL AND g_pml[l_ac].pml84 IS NULL OR
              g_pml_t.pml84 <> g_pml[l_ac].pml84 THEN
              LET g_change='Y'
           END IF
           IF NOT cl_null(g_pml[l_ac].pml84) THEN
              IF g_pml[l_ac].pml84<=0 THEN
                 NEXT FIELD pml84
              END IF
              LET g_pml2.pml84 = g_pml[l_ac].pml84
              LET g_pml_o.pml84 = g_pml[l_ac].pml84
           END IF

        AFTER FIELD pml85  #第二數量
           IF NOT t420_pml85_check(p_cmd) THEN NEXT FIELD pml85 END IF   #No.FUN-BB0086
           #No.FUN-BB0086--mark--begin--
           #IF g_pml_t.pml85 IS NULL AND g_pml[l_ac].pml85 IS NOT NULL OR
           #   g_pml_t.pml85 IS NOT NULL AND g_pml[l_ac].pml85 IS NULL OR
           #   g_pml_t.pml85 <> g_pml[l_ac].pml85 THEN
           #   LET g_change='Y'
           #END IF
           #IF NOT cl_null(g_pml[l_ac].pml85) THEN
           #   IF g_pml[l_ac].pml85 < 0 THEN
           #      CALL cl_err('','aim-391',0)  #
           #      NEXT FIELD pml85
           #   END IF
           #   IF p_cmd = 'a' OR  p_cmd = 'u' AND
           #      g_pml_t.pml85 <> g_pml[l_ac].pml85 THEN
           #      IF g_ima906='3' THEN
           #         LET g_tot=g_pml[l_ac].pml85*g_pml[l_ac].pml84
           #         IF cl_null(g_pml[l_ac].pml82) OR g_pml[l_ac].pml82=0 THEN #CHI-960022
           #            LET g_pml[l_ac].pml82=g_tot*g_pml[l_ac].pml81
           #         END IF                                                    #CHI-960022
           #         DISPLAY BY NAME g_pml[l_ac].pml82
           #      END IF
           #   END IF
           #   LET g_pml2.pml85 = g_pml[l_ac].pml85
           #   LET g_pml_o.pml85 = g_pml[l_ac].pml85
           #END IF
           #IF g_change='Y' THEN
           #   CALL t420_set_pml87()
           #   DISPLAY BY NAME g_pml[l_ac].pml87
           #   CALL t420_bud(p_cmd,'3')
           #   IF NOT cl_null(g_errno) THEN
           #      NEXT FIELD pml85
           #   END IF
           #END IF
           #CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           #No.FUN-BB0086--mark--end--

        BEFORE FIELD pml80
           CALL t420_sel_ima()
           CALL t420_set_no_required()

        AFTER FIELD pml80  #第一單位
           #No.FUN-BB0086--add--begin--
           LET l_tf = ""
           LET l_case = ""
           #No.FUN-BB0086--add--end--
           IF cl_null(g_pml[l_ac].pml04) THEN NEXT FIELD pml04 END IF
           IF g_pml_t.pml80 IS NULL AND g_pml[l_ac].pml80 IS NOT NULL OR
              g_pml_t.pml80 IS NOT NULL AND g_pml[l_ac].pml80 IS NULL OR
              g_pml_t.pml80 <> g_pml[l_ac].pml80 THEN
              LET g_change='Y'
           END IF
           IF NOT cl_null(g_pml[l_ac].pml80) THEN
              IF g_pml_o.pml80 IS NULL OR (g_pml_t.pml80 IS NULL)
                 OR (g_pml[l_ac].pml80 != g_pml_o.pml80) THEN
                 CALL t420_unit(g_pml[l_ac].pml80)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pml[l_ac].pml80,g_errno,0)
                    LET g_pml[l_ac].pml80 = g_pml_o.pml80
                    NEXT FIELD pml80
                 END IF
              END IF
              CALL t420_set_origin_field()
              CALL s_du_umfchk(g_pml[l_ac].pml04,'','','',
                               g_pml[l_ac].pml07,g_pml[l_ac].pml80,'1')
                   RETURNING g_errno,g_factor
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_pml[l_ac].pml80,g_errno,0)
                 NEXT FIELD pml80
              END IF
              IF cl_null(g_pml_t.pml80) OR g_pml_t.pml80 <> g_pml[l_ac].pml80 THEN
                 LET g_pml[l_ac].pml81 = g_factor
                 DISPLAY BY NAME g_pml[l_ac].pml81
              END IF
              LET g_pml2.pml80 = g_pml[l_ac].pml80
              LET g_pml_o.pml80 = g_pml[l_ac].pml80
              #No.FUN-BB0086--add--begin--
              IF NOT cl_null(g_pml[l_ac].pml82) AND g_pml[l_ac].pml82<>0 THEN  #TQC-C20183 add
                 CALL t420_pml82_check(p_cmd,l_flag) RETURNING l_tf,l_case
              END IF
              #No.FUN-BB0086--add--end--
           END IF
           IF g_change='Y' THEN
              CALL t420_set_pml87()
              DISPLAY BY NAME g_pml[l_ac].pml87
              CALL t420_bud(p_cmd,'3')
              IF NOT cl_null(g_errno) THEN
                 NEXT FIELD pml80
              END IF
           END IF
           CALL t420_set_required()
           CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           #No.FUN-BB0086--add--begin--
           LET g_pml80_t = g_pml[l_ac].pml80
           IF NOT l_tf THEN
              CASE l_case
                 WHEN "pml82" NEXT FIELD pml82
                 WHEN "pml85" NEXT FIELD pml85
                 OTHERWISE EXIT CASE
              END CASE
           END IF
           #No.FUN-BB0086--add--end--

        AFTER FIELD pml81  #第一轉換率
           IF g_pml_t.pml81 IS NULL AND g_pml[l_ac].pml81 IS NOT NULL OR
              g_pml_t.pml81 IS NOT NULL AND g_pml[l_ac].pml81 IS NULL OR
              g_pml_t.pml81 <> g_pml[l_ac].pml81 THEN
              LET g_change='Y'
           END IF
           IF NOT cl_null(g_pml[l_ac].pml81) THEN
              IF g_pml[l_ac].pml81<=0 THEN
                 NEXT FIELD pml81
              END IF
              LET g_pml2.pml81 = g_pml[l_ac].pml81
              LET g_pml_o.pml81 = g_pml[l_ac].pml81
           END IF

        AFTER FIELD pml82  #第一數量
           #No.FUN-BB0086--add--begin--
           LET l_tf = ""
           LET l_case = ""
           CALL t420_pml82_check(p_cmd,l_flag) RETURNING l_tf,l_case
           IF NOT l_tf THEN
              CASE l_case
                 WHEN "pml82" NEXT FIELD pml82
                 WHEN "pml85" NEXT FIELD pml85
                 OTHERWISE EXIT CASE
              END CASE
           END IF
           #No.FUN-BB0086--add--end--
           #No.FUN-BB0086--mark--begin---
           #IF g_pml_t.pml82 IS NULL AND g_pml[l_ac].pml82 IS NOT NULL OR
           #   g_pml_t.pml82 IS NOT NULL AND g_pml[l_ac].pml82 IS NULL OR
           #   g_pml_t.pml82 <> g_pml[l_ac].pml82 THEN
           #   LET g_change='Y'
           #END IF
           #IF NOT cl_null(g_pml[l_ac].pml82) THEN
           #   IF g_pml[l_ac].pml82 < 0 THEN
           #      CALL cl_err('','aim-391',0)  #
           #      NEXT FIELD pml82
           #   END IF
           #   LET g_pml2.pml82 = g_pml[l_ac].pml82
           #   LET g_pml_o.pml82 = g_pml[l_ac].pml82
           #END IF
           #CALL t420_set_origin_field()
           #IF g_pml[l_ac].pml07 = g_pml2.pml08 THEN
           #   LET g_pml2.pml09 = 1
           #ELSE
           #   IF ( cl_null(g_pml_o.pml07) AND NOT cl_null(g_pml2.pml08))
           #   OR (g_pml[l_ac].pml07 != g_pml_o.pml07 AND
           #      NOT cl_null(g_pml2.pml08) ) THEN
           #      CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,
           #           g_pml2.pml08) RETURNING l_flag,g_pml2.pml09
           #      IF l_flag THEN
           #         CALL cl_err(g_pml[l_ac].pml07,'mfg1206',0)
           #         LET g_pml[l_ac].pml07 = g_pml2.pml07
           #         LET g_pml[l_ac].pml83 = g_pml_t.pml83
           #         LET g_pml[l_ac].pml80 = g_pml_t.pml80
           #         IF g_ima906 MATCHES '[23]' THEN
           #            NEXT FIELD pml85
           #         ELSE
           #            NEXT FIELD pml82
           #         END IF
           #      END IF
           #      IF cl_null(g_pml2.pml09) THEN LET g_pml2.pml09=1 END IF
           #   END IF
           #END IF
           #LET g_pml2.pml07 = g_pml[l_ac].pml07
           #LET g_pml_o.pml07 = g_pml[l_ac].pml07
           #IF p_cmd = 'u' THEN
           #   IF g_pml[l_ac].pml20 < g_pml[l_ac].pml21 THEN
           #      CALL cl_err(g_pml[l_ac].pml20,'mfg3082',1)
           #      LET g_pml[l_ac].pml20 = g_pml_t.pml20
           #      LET g_pml[l_ac].pml85 = g_pml_t.pml85
           #      LET g_pml[l_ac].pml82 = g_pml_t.pml82
           #      IF g_ima906 MATCHES '[23]' THEN
           #         NEXT FIELD pml85
           #      ELSE
           #         NEXT FIELD pml82
           #      END IF
           #   END IF
           #END IF
           #LET g_pml20_t = g_pml[l_ac].pml20
           #   IF (cl_null(g_pml_o.pml20) OR g_pml[l_ac].pml20 != g_pml_o.pml20 )
           #      AND (g_no[1,4] != 'MISC') THEN
           #      CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang)
           #      RETURNING g_pml[l_ac].pml20
           #      DISPLAY BY NAME g_pml[l_ac].pml20
           #      IF g_pml20_t <> g_pml[l_ac].pml20 THEN
           #         IF g_ima906 MATCHES '[23]' THEN
           #            NEXT FIELD pml85
           #         ELSE
           #            NEXT FIELD pml82
           #         END IF
           #      END IF
           #   END IF
           ##for專案
           #IF NOT cl_null(g_pml[l_ac].pml12)
           #   AND NOT cl_null(g_pml[l_ac].pml121)
           #   AND NOT cl_null(g_pml[l_ac].pml122)
           #   AND g_pml[l_ac].pml12 != ' '
           #   AND g_pml[l_ac].pml121 != ' '
           #   AND g_pml[l_ac].pml122 != ' '
           #THEN
           #   IF cl_null(g_pml_t.pml20) THEN LET g_pml_t.pml20=0 END IF
           #   CALL t420_chk_pjf05(g_pml[l_ac].pml121,g_pml[l_ac].pml04,g_pml_t.pml20)
           #   IF NOT cl_null(g_errno) THEN CALL cl_err('',g_errno,'1') END IF
           #END IF
           #LET g_pml2.pml20 = g_pml[l_ac].pml20
           #LET g_pml_o.pml20 = g_pml[l_ac].pml20
           #IF g_change='Y' THEN
           #   CALL t420_set_pml87()
           #   DISPLAY BY NAME g_pml[l_ac].pml87
           #   CALL t420_bud(p_cmd,'3')
           #   IF NOT cl_null(g_errno) THEN
           #      NEXT FIELD pml82
           #   END IF
           #END IF
           #CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           #No.FUN-BB0086--mark--end---

        BEFORE FIELD pml86
           CALL t420_sel_ima()
           CALL t420_set_no_required()

        AFTER FIELD pml86  #計價單位
           IF cl_null(g_pml[l_ac].pml04) THEN NEXT FIELD pml04 END IF
           IF g_pml_t.pml86 IS NULL AND g_pml[l_ac].pml86 IS NOT NULL OR
              g_pml_t.pml86 IS NOT NULL AND g_pml[l_ac].pml86 IS NULL OR
              g_pml_t.pml86 <> g_pml[l_ac].pml86 THEN
              LET g_change='Y'
           END IF
           IF NOT cl_null(g_pml[l_ac].pml86) THEN
              IF g_pml_o.pml86 IS NULL OR (g_pml_t.pml86 IS NULL)
                 OR (g_pml[l_ac].pml86 != g_pml_o.pml86) THEN
                 CALL t420_unit(g_pml[l_ac].pml86)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_pml[l_ac].pml86,g_errno,0)
                    LET g_pml[l_ac].pml86 = g_pml_o.pml86
                    NEXT FIELD pml86
                 END IF
              END IF
              CALL s_du_umfchk(g_pml[l_ac].pml04,'','','',
                               g_ima44,g_pml[l_ac].pml86,'1')
                   RETURNING g_errno,g_factor
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_pml[l_ac].pml86,g_errno,0)
                 NEXT FIELD pml86
              END IF
              LET g_pml2.pml86 = g_pml[l_ac].pml86
              LET g_pml_o.pml86 = g_pml[l_ac].pml86
              #No.FUN-BB0086--add--begin--
              IF NOT cl_null(g_pml[l_ac].pml87) AND g_pml[l_ac].pml87<>0 THEN  #TQC-C20183
                 IF NOT t420_pml87_check() THEN
                    LET g_pml86_t = g_pml[l_ac].pml86
                    NEXT FIELD pml87
                 END IF
              END IF
              LET g_pml86_t = g_pml[l_ac].pml86
              #No.FUN-BB0086--add--end--
           END IF
           CALL t420_set_required()

        BEFORE FIELD pml87
           IF cl_null(g_pml[l_ac].pml83) THEN
              LET g_pml[l_ac].pml84 = NULL
              LET g_pml[l_ac].pml85 = NULL
           END IF
           IF cl_null(g_pml[l_ac].pml80) THEN
              LET g_pml[l_ac].pml81 = NULL
              LET g_pml[l_ac].pml82 = NULL
           END IF
           IF g_change='Y' THEN
              CALL t420_set_pml87()
              DISPLAY BY NAME g_pml[l_ac].pml87
              CALL t420_bud(p_cmd,'3')
              IF NOT cl_null(g_errno) THEN
                 NEXT FIELD pml82
              END IF
           END IF

        AFTER FIELD pml87  #計價數量
           IF NOT t420_pml87_check() THEN NEXT FIELD pml87 END IF   #No.FUN-BB0086
           #No.FUN-BB0086--mark--begin--
           #IF NOT cl_null(g_pml[l_ac].pml87) THEN
           #   IF g_pml[l_ac].pml87 < 0 THEN
           #      CALL cl_err('','aim-391',0)  #
           #      NEXT FIELD pml87
           #   END IF
           #   LET g_pml2.pml87 = g_pml[l_ac].pml87
           #   LET g_pml_o.pml87 = g_pml[l_ac].pml87
           #END IF
           #No.FUN-BB0086--mark--end--

          AFTER FIELD pml33    #交貨日期
            IF NOT cl_null(g_pml[l_ac].pml33) THEN
               IF g_pml[l_ac].pml33 < g_pmk.pmk04 THEN
                  CALL cl_err("","apm-027",0)
                  NEXT FIELD pml33
               END IF
               CALL s_wkday(g_pml[l_ac].pml33) RETURNING l_flag,l_date
               IF l_date IS NULL OR l_date = ' ' THEN
                  NEXT FIELD pml33
               ELSE
                  LET g_pml[l_ac].pml33 = l_date
               END IF
               IF g_pml[l_ac].pml33 > g_pml[l_ac].pml34 THEN
                  CALL cl_err("","mfg3225",0)
                  NEXT FIELD pml33
               END IF
               DISPLAY BY NAME g_pml[l_ac].pml33
               LET g_pml2.pml33 = g_pml[l_ac].pml33
               CALL t420_bud(p_cmd,'3')
               IF NOT cl_null(g_errno) THEN
                  NEXT FIELD pml33
               END IF
            END IF

             LET g_pml_o.pml33 = g_pml[l_ac].pml33

        #FUN-A80150---add---start---
         BEFORE FIELD pml919
            IF cl_null(g_pml[l_ac].pml33) THEN
               NEXT FIELD pml33
            END IF
        #FUN-A80150---add---end---

         AFTER FIELD pml34
            IF NOT cl_null(g_pml[l_ac].pml34) THEN
               IF g_pml[l_ac].pml34 < g_pmk.pmk04 THEN
                  CALL cl_err("","apm-090",0)
                  NEXT FIELD pml34
               END IF
               CALL s_wkday(g_pml[l_ac].pml34) RETURNING g_flag,g_date
               IF cl_null(g_date) THEN
                    NEXT FIELD pml34
               ELSE LET g_pml[l_ac].pml34 = g_date
                    DISPLAY BY NAME g_pml[l_ac].pml34
               END IF
               IF g_pml[l_ac].pml34 < g_pml[l_ac].pml33 THEN
                  CALL cl_err("","mfg3225",0)
                  NEXT FIELD pml34
               END IF
               IF g_pml[l_ac].pml34 > g_pml[l_ac].pml35 THEN
                  CALL cl_err("","apm-028",0)
                  NEXT FIELD pml34
               END IF
            ELSE  LET g_pml[l_ac].pml34 = g_pml[l_ac].pml33 + g_ima49
                  DISPLAY BY NAME g_pml[l_ac].pml34
            END IF
            LET g_pml2.pml34 = g_pml[l_ac].pml34
            LET g_pml_o.pml34 = g_pml[l_ac].pml34
            IF g_pml[l_ac].pml33 < g_pmk.pmk04 THEN
               CALL cl_err("","apm-027",0)
               NEXT FIELD pml33
            END IF

         AFTER FIELD pml35
            IF NOT cl_null(g_pml[l_ac].pml35) THEN
              SELECT ima49,ima491 INTO g_ima49,g_ima491
                FROM ima_file WHERE ima01 = g_pml[l_ac].pml04
               IF g_pml[l_ac].pml35 < g_pmk.pmk04 THEN
                  CALL cl_err("","apm-060",0)
                  NEXT FIELD pml35
               END IF
               CALL s_wkday(g_pml[l_ac].pml35) RETURNING g_flag,g_date
               IF cl_null(g_date) THEN
                    NEXT FIELD pml35
               ELSE LET g_pml[l_ac].pml35 = g_date
                    DISPLAY BY NAME g_pml[l_ac].pml35
               END IF
               IF g_pml[l_ac].pml35 < g_pml[l_ac].pml34 OR
                  g_pml[l_ac].pml35 < g_pml[l_ac].pml33
               THEN CALL cl_err(g_pml[l_ac].pml35,'apm-028',0)
                    NEXT FIELD pml35
               END IF
            ELSE
                 LET g_pml[l_ac].pml35 = g_pml[l_ac].pml34 + g_ima491
                 DISPLAY BY NAME g_pml[l_ac].pml35
            END IF
            IF cl_null(g_pml[l_ac].pml34)
               OR g_pml_t.pml35 != g_pml[l_ac].pml35 OR cl_null(g_pml_t.pml35) THEN #TQC-970421
               CALL s_aday(g_pml[l_ac].pml35,-1,g_ima491) RETURNING g_pml[l_ac].pml34
            END IF
            IF cl_null(g_pml[l_ac].pml33)
               OR g_pml_t.pml35 != g_pml[l_ac].pml35 OR cl_null(g_pml_t.pml35) THEN #TQC-970421
               CALL s_aday(g_pml[l_ac].pml34,-1,g_ima49) RETURNING g_pml[l_ac].pml33
            END IF
            LET g_pml2.pml33 = g_pml[l_ac].pml33
            LET g_pml2.pml34 = g_pml[l_ac].pml34
            LET g_pml_o.pml33 = g_pml[l_ac].pml33
            LET g_pml_o.pml34 = g_pml[l_ac].pml34
            LET g_pml2.pml35 = g_pml[l_ac].pml35
            LET g_pml_o.pml35 = g_pml[l_ac].pml35
            IF g_pml[l_ac].pml34 < g_pmk.pmk04 THEN
               CALL cl_err("","apm-090",0)
               NEXT FIELD pml34
            END IF
            IF g_pml[l_ac].pml33 < g_pmk.pmk04 THEN
               CALL cl_err("","apm-027",0)
               NEXT FIELD pml33
            END IF

          BEFORE FIELD pml12
            CALL t420_set_entry_b(p_cmd)

         AFTER FIELD pml12   #專案代號
          IF NOT cl_null(g_pml[l_ac].pml12) THEN
             SELECT COUNT(*) INTO g_cnt FROM pja_file
              WHERE pja01 = g_pml[l_ac].pml12
                AND pjaacti = 'Y'
                AND pjaclose='N'             #FUN-960038
             IF g_cnt = 0 THEN
                CALL cl_err(g_pml[l_ac].pml12,'asf-984',0)
                NEXT FIELD pml12
             END IF
             CALL t420_bud(p_cmd,'3')
             IF NOT cl_null(g_errno) THEN
                NEXT FIELD pml12
             END IF
          ELSE
             NEXT FIELD pml90    #IF 專案沒輸入資料，直接跳到費用原因,WBS/活動不可輸入
          END IF
          CALL t420_set_no_entry_b(p_cmd)

         BEFORE FIELD pml121    #wbs
           IF cl_null(g_pml[l_ac].pml12) THEN
             NEXT FIELD pml12
           END IF

         AFTER FIELD pml121  #WBS
          IF NOT cl_null(g_pml[l_ac].pml121) THEN
             SELECT COUNT(*) INTO g_cnt FROM pjb_file
              WHERE pjb01 = g_pml[l_ac].pml12
                AND pjb02 = g_pml[l_ac].pml121
                AND pjbacti = 'Y'
             IF g_cnt = 0 THEN
                CALL cl_err(g_pml[l_ac].pml121,'apj-051',0)
                LET g_pml[l_ac].pml121 = g_pml_t.pml121
                NEXT FIELD pml121
             ELSE
                SELECT pjb09,pjb11 INTO l_pjb09,l_pjb11
                 FROM pjb_file WHERE pjb01 = g_pml[l_ac].pml12
                  AND pjb02 = g_pml[l_ac].pml121
                  AND pjbacti = 'Y'
                IF l_pjb09 != 'Y' OR l_pjb11 != 'Y' THEN
                   CALL cl_err(g_pml[l_ac].pml121,'apj-090',0)
                   LET g_pml[l_ac].pml121 = g_pml_t.pml121
                   NEXT FIELD pml121
                END IF
             END IF
             SELECT pjb25 INTO l_pjb25 FROM pjb_file
              WHERE pjb02 = g_pml[l_ac].pml121
             IF l_pjb25 = 'Y' THEN
                NEXT FIELD pml122
             ELSE
                LET g_pml[l_ac].pml122 = ' '
                DISPLAY BY NAME g_pml[l_ac].pml122
                NEXT FIELD pml90
             END IF
             CALL t420_bud(p_cmd,'3')
             IF NOT cl_null(g_errno) THEN
                NEXT FIELD pml121
             END IF
          END IF

        BEFORE FIELD pml122
          IF cl_null(g_pml[l_ac].pml121) THEN
             NEXT FIELD pml121
          ELSE
             SELECT pjb25 INTO l_pjb25 FROM pjb_file
              WHERE pjb02 = g_pml[l_ac].pml121
             IF l_pjb25 = 'N' THEN  #WBS不做活動時，活動帶空白，跳開不輸入
                LET g_pml[l_ac].pml122 = ' '
                DISPLAY BY NAME g_pml[l_ac].pml122
                NEXT FIELD pml90
             END IF
          END IF

         AFTER FIELD pml122  #活動
          IF NOT cl_null(g_pml[l_ac].pml122) THEN
             SELECT COUNT(*) INTO g_cnt FROM pjk_file
              WHERE pjk02 = g_pml[l_ac].pml122
                AND pjk11 = g_pml[l_ac].pml121
                AND pjkacti = 'Y'
             IF g_cnt = 0 THEN
                CALL cl_err(g_pml[l_ac].pml122,'apj-049',0)
                NEXT FIELD pml122
             END IF
          END IF

         AFTER FIELD pml67   #部門
          IF NOT cl_null(g_pml[l_ac].pml67) THEN
            SELECT COUNT(*) INTO g_cnt FROM gem_file
             WHERE gem01=g_pml[l_ac].pml67
               AND gemacti='Y'
            IF g_cnt = 0 THEN
               CALL cl_err(g_pml[l_ac].pml67,'apm-003',0)
               NEXT FIELD pml67
            END IF
            CALL t420_bud(p_cmd,'3')
            IF NOT cl_null(g_errno) THEN
               NEXT FIELD pml67
            END IF
          ELSE
            LET g_pml[l_ac].pml67 = ' '
          END IF

         AFTER FIELD pml90  #費用原因
           IF NOT cl_null(g_pml[l_ac].pml90) THEN
              SELECT COUNT(*) INTO g_cnt FROM azf_file
                WHERE azf01=g_pml[l_ac].pml90 AND azf02='2' AND azfacti='Y'
              IF g_cnt = 0 THEN
                 CALL cl_err(g_pml[l_ac].pml90,'asf-453',0)
                 NEXT FIELD pml90
              END IF
              SELECT azf09 INTO l_azf09 FROM azf_file
               WHERE azf01=g_pml[l_ac].pml90 AND azf02='2' AND azfacti='Y'
                  IF l_azf09 !='7' THEN
                    CALL cl_err('','aoo-406',1)
                     NEXT FIELD pml90
                  END IF
              CALL t420_bud(p_cmd,'3')
              IF NOT cl_null(g_errno) THEN
#MOD-B40202 --begin--
#                 LET g_pml[l_ac].pml40 = g_pml_t.pml40
#                 LET g_pml[l_ac].pml401= g_pml_t.pml401
#                 DISPLAY BY NAME g_pml[l_ac].pml40,g_pml[l_ac].pml401
#MOD-B40202 --end-
                 NEXT FIELD pml90
              END IF
#TQC-B50066 --begin--
#           ELSE  #料號如果要做專案控管的話，一定要輸入費用原因碼
#             IF g_smy.smy59 = 'Y' THEN
#               CALL cl_err(g_pml[l_ac].pml12,'apj-201',0)
#               NEXT FIELD pml90
#             END IF
#TQC-B50066 --end--
           END IF

           IF g_pml_t.pml90 IS NULL AND g_pml[l_ac].pml90 IS NOT NULL OR
              g_pml_t.pml90 IS NOT NULL AND g_pml[l_ac].pml90 IS NULL OR
              g_pml_t.pml90 <> g_pml[l_ac].pml90 THEN
              IF cl_null(g_pml[l_ac].pml40) THEN
#No.TQC-B50094 --begin
                IF g_pml[l_ac].pml12  IS NULL THEN LET g_pml[l_ac].pml12   = ' ' END IF
                IF g_pml[l_ac].pml121 IS NULL THEN LET g_pml[l_ac].pml121  = ' ' END IF
                IF g_pml[l_ac].pml67  IS NULL THEN LET g_pml[l_ac].pml67   = ' ' END IF
                SELECT afb02 INTO g_pml[l_ac].pml40
                  FROM afb_file
                 WHERE afb00 = g_bookno1
                   AND afb01 = g_pml[l_ac].pml90
                   AND afb03 = YEAR(g_pmk.pmk04)
                   AND afb04 = g_pml[l_ac].pml121
                   AND afb041= g_pml[l_ac].pml67
                   AND afb042= g_pml[l_ac].pml12

#                SELECT azf14 INTO g_pml[l_ac].pml40
#                  FROM azf_file
#                WHERE azf01=g_pml[l_ac].pml90 AND azf02='2' AND azfacti='Y'
#No.TQC-B50094 --end
              END IF

              IF g_aza.aza63='Y' AND cl_null(g_pml[l_ac].pml401) THEN
                LET g_pml[l_ac].pml401 = g_pml[l_ac].pml40
              END IF
              DISPLAY BY NAME g_pml[l_ac].pml40,g_pml[l_ac].pml401
           END IF

         AFTER FIELD pml40   #科目一
           IF NOT cl_null(g_pml[l_ac].pml40) THEN
               SELECT COUNT(*) INTO g_cnt
                 FROM aag_file
                WHERE aag01=g_pml[l_ac].pml40
                  AND aag00=g_bookno1
               IF g_cnt = 0 THEN
#FUN-B10052 --begin--
#                 LET g_pml[l_ac].pml40=g_pml_t.pml40
#                 CALL cl_err3("sel","aag_file",g_bookno1,g_pml[l_ac].pml40,"aap-021","","",1)  #No.FUN-660129  #No.FUN-730033
                  CALL cl_err3("sel","aag_file",g_bookno1,g_pml[l_ac].pml40,"aap-021","","",0)

                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_aag"
                  LET g_qryparam.default1 = g_pml[l_ac].pml40
                  LET g_qryparam.arg1 = g_bookno1
                  LET g_qryparam.construct = 'N'
                  LET g_qryparam.where = " aag07 IN ('2','3')  AND aag03 = '2' AND aag01 LIKE '",g_pml[l_ac].pml40 CLIPPED,"%'"
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml40
#FUN-B10052 --end--
                  DISPLAY BY NAME g_pml[l_ac].pml40
                  NEXT FIELD pml40
               END IF
               CALL t420_bud(p_cmd,'1')
               IF NOT cl_null(g_errno) THEN
                  NEXT FIELD pml40
               END IF
#TQC-B50066 --begin--
#           ELSE
#             IF g_smy.smy59 = 'Y' THEN
#               CALL cl_err('','apj-202',0)
#               NEXT FIELD pml40
#             END IF
#TQC-B50066 --end--
           END IF

         AFTER FIELD pml401  #科目二
           IF NOT cl_null(g_pml[l_ac].pml401) THEN
             SELECT COUNT(*) INTO g_cnt FROM aag_file
              WHERE aag01=g_pml[l_ac].pml401
                AND aag00=g_bookno2
             IF g_cnt = 0 THEN
#FUN-B10052 --begin--
#               LET g_pml[l_ac].pml401=g_pml_t.pml401
#               CALL cl_err(g_pml[l_ac].pml401,"aap-021",1)
                 CALL cl_err(g_pml[l_ac].pml401,"aap-021",0)

                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_aag"
                  LET g_qryparam.default1 = g_pml[l_ac].pml401
                  LET g_qryparam.arg1 = g_bookno2
                  LET g_qryparam.construct = 'N'
                  LET g_qryparam.where = " aag03 IN ('2','4') AND aag01 LIKE '",g_pml[l_ac].pml401 CLIPPED,"%'"
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml401
#FUN-B10052 --end--
                DISPLAY BY NAME g_pml[l_ac].pml401
                NEXT FIELD pml401
             END IF
             CALL t420_bud(p_cmd,'2')
             IF NOT cl_null(g_errno) THEN
                NEXT FIELD pml401
             END IF
#TQC-B50066 --begin--
#           ELSE
#             IF g_aza.aza63 = 'Y' AND g_smy.smy59 = 'Y' THEN
#               CALL cl_err('','apj-203',0)
#               NEXT FIELD pml401
#             END IF
#TQC-B50066 --end--
           END IF

         AFTER FIELD pml31   #未稅單價
           IF NOT cl_null(g_pml[l_ac].pml31) THEN
               IF cl_null(g_pml[l_ac].pml31) OR g_pml[l_ac].pml31<0 THEN
                  LET g_pml[l_ac].pml31=g_pml_t.pml31
                  #MOD-C10008 ----- add start -----
                  IF cl_null(g_pmk.pmk42) THEN
                     LET g_pml2.pml44=g_pml[l_ac].pml31
                  ELSE
                  #MOD-C10008 ----- add end -----
                     LET g_pml2.pml44=g_pml[l_ac].pml31*g_pmk.pmk42
                  END IF #MOD-C10008 add
                  DISPLAY BY NAME g_pml[l_ac].pml31
                  NEXT FIELD pml31
               END IF
               LET g_pml[l_ac].pml31 = cl_digcut(g_pml[l_ac].pml31,t_azi03)  #No.CHI-6A0004
               #MOD-C10008 ----- add start -----
               IF cl_null(g_pmk.pmk42) THEN
                  LET g_pml2.pml44=g_pml[l_ac].pml31
               ELSE
               #MOD-C10008 ----- add end -----
                  LET g_pml2.pml44=g_pml[l_ac].pml31*g_pmk.pmk42
               END IF #MOD-C10008 add
               LET g_pml[l_ac].pml31t = g_pml[l_ac].pml31 * (1 + g_pmk.pmk43/100)
               LET g_pml[l_ac].pml31t = cl_digcut(g_pml[l_ac].pml31t,t_azi03) #No.CHI-6A0004
               CALL t420_bud(p_cmd,'3')
               IF NOT cl_null(g_errno) THEN
                  NEXT FIELD pml31
               END IF
           END IF
         AFTER FIELD pml31t  #含稅單價
           IF NOT cl_null(g_pml[l_ac].pml31t) THEN
               IF g_pml[l_ac].pml31t<0 THEN
                  LET g_pml[l_ac].pml31t=g_pml_t.pml31t
                  DISPLAY BY NAME g_pml[l_ac].pml31t
                  NEXT FIELD pml31t
               END IF
               LET g_pml[l_ac].pml31t = cl_digcut(g_pml[l_ac].pml31t,t_azi03)  #No.CHI-6A0004
               LET g_pml[l_ac].pml31 = g_pml[l_ac].pml31t / (1 + g_pmk.pmk43/100)
               LET g_pml[l_ac].pml31 = cl_digcut(g_pml[l_ac].pml31,t_azi03)  #No.CHI-6A0004
               #MOD-C10008 ----- add start -----
               IF cl_null(g_pmk.pmk42) THEN
                  LET g_pml2.pml44=g_pml[l_ac].pml31
               ELSE
               #MOD-C10008 ----- add end ----
                  LET g_pml2.pml44=g_pml[l_ac].pml31*g_pmk.pmk42             #No.TQC-630043 add
               END IF #MOD-C10008 add
           END IF

          AFTER FIELD pml06
             LET g_pml2.pml06=g_pml[l_ac].pml06

          AFTER FIELD pml930
             IF NOT cl_null(g_pml[l_ac].pml930) THEN
                 LET l_cnt=0
                 SELECT COUNT(*) INTO l_cnt FROM gem_file
                                           WHERE gem01=g_pml[l_ac].pml930
                                             AND gem09 IN ('1','2')
                                             AND gemacti='Y'
                 IF l_cnt=0 THEN
                    CALL cl_err3("sel","gem_file",g_pml[l_ac].pml930,"",100,"","",1)
                    LET g_pml[l_ac].pml930=g_pml_t.pml930
                    LET g_pml[l_ac].gem02a=g_pml_t.gem02a
                    DISPLAY BY NAME g_pml[l_ac].pml930,g_pml[l_ac].gem02a
                    NEXT FIELD pml930
                 END IF
                 CALL t420_bud(p_cmd,'3')
                 IF NOT cl_null(g_errno) THEN
                    NEXT FIELD pml930
                 END IF
                 CALL t420_set_pml930(g_pml[l_ac].pml930) RETURNING g_pml[l_ac].gem02a
                 DISPLAY BY NAME g_pml[l_ac].gem02a
             ELSE
                 LET g_pml[l_ac].gem02a=NULL
                 DISPLAY BY NAME g_pml[l_ac].gem02a
             END IF

             LET g_pml2.pml930  = g_pml[l_ac].pml930
             LET g_pml_o.pml930 = g_pml[l_ac].pml930

          AFTER FIELD pml38
             LET g_pml2.pml38=g_pml[l_ac].pml38

          AFTER FIELD pml123
              IF NOT cl_null(g_pml[l_ac].pml123) THEN
                 SELECT COUNT(*) INTO g_cnt FROM mse_file
                  WHERE mse01 = g_pml[l_ac].pml123
                 IF g_cnt = 0 THEN
                    CALL cl_err(g_pml[l_ac].pml123,'mfg2603',0)
                    NEXT FIELD pml123
                 ELSE
                   SELECT mse02 INTO g_pml[l_ac].mse02
                     FROM mse_file WHERE mse01=g_pml[l_ac].pml123
                   DISPLAY g_pml[l_ac].mse02 TO FORMONLY.mse02
                 END IF
              END IF
#TQC-BB0167 add begin
              IF cl_null(g_pml[l_ac].pml123) THEN
                 LET g_pml[l_ac].mse02 = ''
                 DISPLAY g_pml[l_ac].mse02 TO FORMONLY.mse02
              END IF
#TQC-BB0167 add end
        BEFORE FIELD pml191
             CALL t420_set_pml191()
        AFTER FIELD pml191
         IF NOT cl_null(g_pml[l_ac].pml191) THEN
            IF p_cmd = "a" OR (p_cmd = "u" AND
               g_pml[l_ac].pml191 <> g_pml_t.pml191 OR cl_null(g_pml_t.pml191)) THEN
               CALL t420_pml191()
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('pml191:',g_errno,1)
                  LET g_pml[l_ac].pml191 = g_pml_t.pml191
                  DISPLAY BY NAME g_pml[l_ac].pml191
                  NEXT FIELD pml191
               ELSE
                  LET g_pml_t.pml191 = g_pml[l_ac].pml191
               END IF
            END IF
         END IF


          BEFORE DELETE                            #是否取消單身
             IF g_pml_t.pml02 > 0 AND g_pml_t.pml02 IS NOT NULL THEN
                SELECT pml16 INTO l_pml16 FROM pml_file
                 WHERE pml01=g_pmk.pmk01 AND pml02=g_pml_t.pml02
                IF g_argv2 = '1' and (l_pml16 matches'[26789]'
                   or g_pml2.pml21 > 0 ) THEN
                   CALL cl_err('','mfg3141',0)
                   CANCEL DELETE
                END IF
                IF NOT cl_delb(0,0) THEN
                   CANCEL DELETE
                END IF

                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   CANCEL DELETE
                END IF
                IF g_pmk.pmk46 = '2' AND g_azw.azw04 = '2'  THEN  #TQC-AC0337
                   CALL cl_err('','apm1052',1)                    #TQC-AC0337
                   RETURN                                         #TQC-AC0337
                END IF                                            #TQC-AC0337

                IF g_sma.sma901 = 'Y' THEN
                   LET l_chr4 = g_pml[l_ac].pml02 USING '&&&&'
                   LET g_pml02 = g_pml_t.pml02
                   IF g_pml_t.pml02<10 THEN
                      LET g_pml02='000',g_pml02
                   ELSE
                      IF g_pml_t.pml02<100 THEN
                         LET g_pml02='00',g_pml02
                      ELSE
                         IF g_pml_t.pml02<1000 THEN
                            LET g_pml02='0',g_pml02
                         ELSE
                            LET g_pml02=g_pml02
                         END IF
                      END IF
                   END IF

                   LET g_pml02 = g_pmk.pmk01,'-',g_pml02
                   DISPLAY "g_pml02 = ",g_pml02
                   DELETE FROM vmz_file where vmz01=g_pml02
                END IF
                CALL t420_upd_oeb28('d',g_pml_t.pml02)   #CHI-840016 add
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin
#&ifdef SLK
#               DELETE FROM pml_file
#                WHERE pml01 = g_pmk.pmk01
#                  AND pml02 IN
#              (SELECT ata03 FROM ata_file
#                WHERE ata00 = g_prog
#                  AND ata02 = g_pml_t.pml02
#                  AND ata01 = g_pmk.pmk01)
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err3("del","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)
#                  ROLLBACK WORK
#                  CANCEL DELETE
#               ELSE
#                  DELETE FROM pmli_file
#                   WHERE pmli01 = g_pmk.pmk01
#                     AND pmli02 IN
#                 (SELECT ata03 FROM ata_file
#                   WHERE ata00 = g_prog
#                     AND ata02 = g_pml_t.pml02
#                     AND ata01 = g_pmk.pmk01)
#                  IF SQLCA.sqlcode THEN
#                     CALL cl_err3("del","pmki_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)
#                     ROLLBACK WORK
#                     CANCEL DELETE
#                  ELSE
#                     DELETE FROM ata_file
#                      WHERE ata00 = g_prog
#                        AND ata02 = g_pml_t.pml02
#                        AND ata01 = g_pmk.pmk01
#                     IF SQLCA.sqlcode THEN
#                        CALL cl_err3("del","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)
#                        ROLLBACK WORK
#                        CANCEL DELETE
#                     END IF
#                  END IF
#               END IF
#&else
##FUN-A50054 --End
#FUN-A60035 ---MARK END
#MOD-B60119 -- begin --
                DELETE FROM pmo_file
                   WHERE pmo01 = g_pmk.pmk01
                   AND pmo03 = g_pml_t.pml02
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("del","pmo_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)
                END IF
#MOD-B60119 -- end --
                DELETE FROM pml_file
                    WHERE pml01 = g_pmk.pmk01 AND
                          pml02 = g_pml_t.pml02
                IF SQLCA.sqlcode THEN
                    CALL cl_err3("del","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
                    ROLLBACK WORK
                    CANCEL DELETE
                ELSE
                   IF SQLCA.sqlerrd[3] != 0 THEN
                      LET g_rec_b=g_rec_b-1
                   END IF
                END IF

#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&endif
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                DISPLAY g_rec_b TO FORMONLY.cn2
                LET l_pmk25 = '0'          #FUN-550038
                LET g_no = g_pml2.pml04[1,4]
                LET l_diff = (g_pml[l_ac].pml20 * g_pml2.pml09) * -1
                CALL t420_update() #MOD-960034
                COMMIT WORK
             END IF

          ON ROW CHANGE
              IF INT_FLAG THEN
                 CALL cl_err('',9001,0)
                 LET INT_FLAG = 0
                 LET g_pml[l_ac].* = g_pml_t.*
                 CLOSE t420_bcl
                 ROLLBACK WORK
                 EXIT DIALOG
              END IF
              IF l_lock_sw = 'Y' THEN
                 CALL cl_err(g_pml[l_ac].pml02,-263,1)
                 LET g_pml[l_ac].* = g_pml_t.*
              ELSE
                 IF g_sma.sma115 = 'Y' THEN
                    CALL s_chk_va_setting(g_pml[l_ac].pml04)
                         RETURNING g_flag,g_ima906,g_ima907
                    IF g_flag=1 THEN
                       NEXT FIELD pml04
                    END IF
                    CALL s_chk_va_setting1(g_pml[l_ac].pml04)
                         RETURNING g_flag,g_ima908
                    IF g_flag=1 THEN
                       NEXT FIELD pml04
                    END IF
                    CALL t420_du_data_to_correct()
                    CALL t420_set_origin_field()
                 END IF

                 #檢核請購數量是否超過訂單數量
                 IF NOT cl_null(g_pml[l_ac].pml24) AND
                    NOT cl_null(g_pml[l_ac].pml25) THEN
                    LET l_qty = 0
                    SELECT oeb12 * oeb05_fac INTO l_qty FROM oeb_file
                     WHERE oeb01 = g_pml[l_ac].pml24
                       AND oeb03 = g_pml[l_ac].pml25
         #           IF g_pml[l_ac].pml20 * g_pml2.pml09 > l_qty THEN                          #TQC-AC0375  mark
                     IF g_pml[l_ac].pml20 * g_pml2.pml09 > l_qty AND g_pmk.pmk46 = '3' THEN    #TQC-AC0375
                       CALL cl_err(g_pml[l_ac].pml20,'apm1024',1)
                       IF g_sma.sma115 = 'Y' THEN
                          IF g_ima906 MATCHES '[23]' THEN
                             NEXT FIELD pml85
                          ELSE
                             NEXT FIELD pml82
                          END IF
                       ELSE
                          NEXT FIELD pml20
                       END IF
                    END IF
                 END IF

                 IF cl_null(g_pml[l_ac].pml86) THEN
                    LET g_pml[l_ac].pml86 = g_pml[l_ac].pml07
                    LET g_pml[l_ac].pml87 = g_pml[l_ac].pml20
                 END IF
                 LET g_pml2.pml31  = g_pml[l_ac].pml31 	#MOD-950256 add
                 LET g_pml2.pml31t = g_pml[l_ac].pml31t #MOD-950256 add
                 LET g_pml2.pml80=g_pml[l_ac].pml80
                 LET g_pml2.pml81=g_pml[l_ac].pml81
                 LET g_pml2.pml82=g_pml[l_ac].pml82
                 LET g_pml2.pml83=g_pml[l_ac].pml83
                 LET g_pml2.pml84=g_pml[l_ac].pml84
                 LET g_pml2.pml85=g_pml[l_ac].pml85
                 LET g_pml2.pml86=g_pml[l_ac].pml86
                 LET g_pml2.pml87=g_pml[l_ac].pml87
                 LET g_pml2.pml919=g_pml[l_ac].pml919    #FUN-A80150 add



                 SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
                  WHERE azi01 = g_pmk.pmk22  AND aziacti= 'Y'  #原幣
                 LET g_pml2.pml88 =cl_digcut(g_pml2.pml87*g_pml2.pml31,t_azi04)
                 LET g_pml2.pml88t=cl_digcut(g_pml2.pml87*g_pml2.pml31t,t_azi04)
                 LET g_pml2.pml930=g_pml[l_ac].pml930 #FUN-670051
                 IF g_pml[l_ac].pml20 <= 0  THEN
                     CALL cl_err(g_pml[l_ac].pml20,'mfg0013',1)
                     LET g_pml[l_ac].pml20 = g_pml_o.pml20
                     IF g_sma.sma115 = 'Y' THEN
                        IF g_ima906 MATCHES '[23]' THEN
                           NEXT FIELD pml85
                        ELSE
                           NEXT FIELD pml82
                        END IF
                     ELSE
                        NEXT FIELD pml20
                     END IF
                 END IF
                 IF cl_null(g_pml[l_ac].pml12) THEN     #No:8841
                    LET g_pml[l_ac].pml12=' '
                 END IF
                 IF cl_null(g_pml[l_ac].pml121) THEN     #No:8841
                     LET g_pml[l_ac].pml121=' '              #FUN-810045
                 END IF
                 IF cl_null(g_pml[l_ac].pml122) THEN     #No:8841
                     LET g_pml[l_ac].pml122=' '            #FUN-810045
                 END IF
                 CALL t420_b_move_back() #FUN-730068
#FUN-A60035 ---MARK BEGIN
##FUN-A50054 --Begin
#&ifdef SLK
#                DELETE FROM pml_file WHERE pml01=g_pmk.pmk01
#                   AND pml02 NOT IN
#                (SELECT ata03 FROM ata_file
#                  WHERE ata00=g_prog
#                    AND ata01=g_pmk.pmk01)
#                DELETE FROM pml_file WHERE pml01=g_pmk.pmk01
#                   AND pml02 IN
#                ( SELECT ata03 FROM ata_file
#                  WHERE ata00=g_prog
#                    AND ata01=g_pmk.pmk01
#                    AND ata02=g_pml[l_ac].pml02)
#                DELETE FROM pmli_file WHERE pmli01=g_pmk.pmk01
#                   AND pmli02 IN
#                ( SELECT ata03 FROM ata_file
#                  WHERE ata00=g_prog
#                    AND ata01=g_pmk.pmk01
#                    AND ata02=g_pml[l_ac].pml02)

#                LET l_sql = " SELECT * FROM ata_file ",
#                            "  WHERE ata00 = '",g_prog,"'",
#                            "    AND ata01 = '",g_pmk.pmk01,"'",
#                            "    AND ata02 = '",g_pml_t.pml02,"'"
#                DECLARE t420_ata_curs1 SCROLL CURSOR FROM l_sql
##FUN-A60035 ---add begin
#                IF g_pml[l_ac].pml04 <> g_pml_t.pml04 THEN     #料號更改時首先更新ata_file
#                   FOREACH t420_ata_curs1 INTO l_ata.*
#                      LET l_ata.ata04 = cl_replace_str(l_ata.ata04,l_ata.ata05,g_pml[l_ac].pml04)
#                      UPDATE ata_file SET ata04 = l_ata.ata04,
#                                          ata05 = g_pml[l_ac].pml04
#                       WHERE ata00 = g_prog AND ata01 = g_pmk.pmk01
#                         AND ata02 = g_pml_t.pml02
#                         AND ata03 = l_ata.ata03
#                      IF SQLCA.sqlcode THEN
#                         CALL cl_err3("upd","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","upd pml",1)
#                      END IF
#                   END FOREACH
#                END IF
##FUN-A60035 ---add end
#                FOREACH t420_ata_curs1 INTO l_ata.*
#                   LET g_pml2.pml02= l_ata.ata03
#                 #  LET g_pml2.pml04= l_ata.ata05    #FUN-A60035 mark
#                   LET g_pml2.pml04= l_ata.ata04     #FUN-A60035 add
#                   LET g_pml2.pml20= l_ata.ata08
#                  #IF g_oea.oea213 = 'N' THEN
#                  #   LET b_oeb.oeb14 = t400_amount(g_oeb[l_ac].oeb917,g_oeb[l_ac].oeb13,g_oeb[l_ac].oeb1006,t_azi03)
#                  #   CALL cl_digcut(b_oeb.oeb14,t_azi04)  RETURNING b_oeb.oeb14
#                  #   LET b_oeb.oeb14t= b_oeb.oeb14*(1+ g_oea.oea211/100)
#                  #   CALL cl_digcut(b_oeb.oeb14t,t_azi04) RETURNING b_oeb.oeb14t
#                  #ELSE
#                  #   LET b_oeb.oeb14t= t400_amount(g_oeb[l_ac].oeb917,g_oeb[l_ac].oeb13,g_oeb[l_ac].oeb1006,t_azi03)
#                  #   CALL cl_digcut(b_oeb.oeb14t,t_azi04) RETURNING b_oeb.oeb14t
#                  #   LET b_oeb.oeb14 = b_oeb.oeb14t/(1+ g_oea.oea211/100)
#                  #   CALL cl_digcut(b_oeb.oeb14,t_azi04)  RETURNING b_oeb.oeb14
#                  #END IF

#                   IF cl_null(g_pml2.pml91) THEN
#                      LET g_pml2.pml91 = "1"
#                   END IF
#                   IF cl_null(g_pml2.pml49) THEN
#                      LET g_pml2.pml49 = "1"
#                   END IF
#                   IF cl_null(g_pml2.pml50) THEN
#                      LET g_pml2.pml50 = "1"
#                   END IF
#                   IF cl_null(g_pml2.pml54) THEN
#                      LET g_pml2.pml54 = "1"
#                   END IF
#                   IF cl_null(g_pml2.pml56) THEN
#                      LET g_pml2.pml56 = "1"
#                   END IF
#                   INSERT INTO pml_file VALUES(g_pml2.*)
#                   IF SQLCA.sqlcode THEN
#                      CALL cl_err3("ins","pml_file",g_pmk.pmk01,g_pml2.pml02,SQLCA.sqlcode,"","upd pml",1)
#                      RETURN FALSE
#                   ELSE
#                      LET g_pmli.pmli01 = g_pml2.pml01
#                      LET g_pmli.pmli02 = g_pml2.pml02
#                      IF NOT s_ins_pmli(g_pmli.*,g_pmk.pmkplant) THEN #FUN-A50054
#                         RETURN FALSE
#                      END IF
#                   END IF

#                   #  UPDATE pml_file SET pml_file.* = g_pml2.*
#                   #   WHERE pml01=g_pmk.pmk01 AND pml02=l_ata03_t
#                   #  IF SQLCA.sqlcode THEN
#                   #     CALL cl_err3("upd","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","upd pml",1)  #No.FUN-650108
#                   #     LET g_pml[l_ac].* = g_pml_t.*
#                   #  ELSE
#                   #     LET g_pmli.pmli02 = l_ata03_t
#                   #     LET g_pmli.pmlislk01 = g_pml[l_ac].pmlislk01
#                   #     UPDATE pmli_file SET pmli_file.* = g_pmli.*
#                   #      WHERE pmli01=g_pmk.pmk01
#                   #        AND pmli02=l_ata03_t
#                   #     IF SQLCA.sqlcode THEN
#                   #        CALL cl_err3("upd","pmli_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","upd pmli",1)
#                   #     END IF
#                   #  END IF
#                   #LSE
#                   #  INSERT INTO pml_file VALUES(g_pml2.*)
#                   #  IF SQLCA.sqlcode THEN
#                   #     CALL cl_err3("ins","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","upd pml",1)  #No.FUN-650108
#                   #     LET g_pml[l_ac].* = g_pml_t.*
#                   #     RETURN FALSE
#                   #  ELSE
#                   #     LET g_pmli.pmli01 = g_pml2.pml01
#                   #     LET g_pmli.pmli02 = g_pml2.pml02
#                   #     LET g_pmli.pmlislk01 = g_pml[l_ac].pmlislk01
#                   #     IF NOT s_ins_pmli(g_pmli.*,g_pmk.pmkplant) THEN #FUN-A50054
#                   #        LET g_pml[l_ac].* = g_pml_t.*
#                   #        RETURN FALSE
#                   #     END IF
#                   #  END IF
#                   #ND IF
#                END FOREACH
#&else
##FUN-A50054 --End
#FUN-A60035 ---MARK END
                 UPDATE pml_file SET pml_file.* = g_pml2.*   # 更新DB
                  WHERE pml01=g_pmk.pmk01 AND pml02=g_pml_t.pml02
                 IF SQLCA.sqlcode THEN
                    CALL cl_err3("upd","pml_file",g_pmk.pmk01,g_pml_t.pml02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
                    LET g_pml[l_ac].* = g_pml_t.*
                 ELSE
                END IF       #FUN-A50054 add
                    MESSAGE 'UPDATE O.K'
                    LET l_pmk25 = '0'          #FUN-550038
                    CALL t420_upd_oeb28('b',g_pml_t.pml02)   #CHI-840016 add
                    CALL t420_update() #MOD-960034
                    COMMIT WORK
#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin add
#&endif
##FUN-A50054---end
#FUN-A60035 ---MARK END
              END IF

          AFTER ROW
              LET l_ac = ARR_CURR()
              LET l_ac_t = l_ac
              IF INT_FLAG THEN
                 CALL cl_err('',9001,0)
                 LET INT_FLAG = 0
                 IF p_cmd = 'u' THEN
                    LET g_pml[l_ac].* = g_pml_t.*
                 END IF
                 LET l_pmk25 = g_pmk.pmk25  #FUN-C30293
                 CLOSE t420_bcl
                 ROLLBACK WORK
                 EXIT DIALOG
#TQC-B50066 --begin--
          ELSE
             IF g_smy.smy59 = 'Y' THEN
               IF cl_null(g_pml[l_ac].pml90) THEN
                  CALL cl_err('','apj-201',0)
                  NEXT FIELD pml90
               END IF
               IF cl_null(g_pml[l_ac].pml40) THEN
                  CALL cl_err('','apj-202',0)
                  NEXT FIELD pml40
               END IF
               IF g_aza.aza63 = 'Y' AND cl_null(g_pml[l_ac].pml401) THEN
                  CALL cl_err('','apj-203',0)
                  NEXT FIELD pml401
               END IF
               IF cl_null(g_pml[l_ac].pml121) THEN
                 #NEXT FIELD pml121
                  LET g_pml[l_ac].pml121 = ' '  #MOD-B50258 mod
               END IF
               IF cl_null(g_pml[l_ac].pml12) THEN
                  LET g_pml[l_ac].pml12 = ' '
               END IF
               IF cl_null(g_pml[l_ac].pml33) THEN
                  LET g_pml[l_ac].pml33 = g_today
               END IF
               IF cl_null(g_pml[l_ac].pml67) THEN
                  LET g_pml[l_ac].pml67 = ' '
               END IF
               CALL t420_bud(p_cmd,'3')
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD pml12
               END IF
             END IF
#TQC-B50066 --end--
              END IF
              CLOSE t420_bcl
              COMMIT WORK

          ON ACTION CONTROLP
             CASE
               #這里只需要處理g_sma.sma908='Y'的情況,因為不允許單身新增子料件則在前面
               #BEFORE FIELD att00來做開窗了
               #需注意的是其條件限制是要開多屬性母料件且母料件的屬性組等于當前屬性組
                WHEN INFIELD(att00)
                     #可以新增子料件,開窗是單純的選取母料件
#FUN-AA0059---------mod------------str-----------------
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ="q_ima_p"
#                    LET g_qryparam.arg1 = lg_group
#                    CALL cl_create_qry() RETURNING g_pml[l_ac].att00
                     CALL q_sel_ima(FALSE, "q_ima_p","","",lg_group,"","","","",'' )
                      RETURNING g_pml[l_ac].att00
#FUN-AA0059---------mod------------end-----------------
                     DISPLAY BY NAME g_pml[l_ac].att00
                     NEXT FIELD att00

                WHEN INFIELD(pml04) #料件編號
                     #MOD-AC0309------add------str------------------
                    #IF p_cmd = 'a' AND cl_null(g_pml[l_ac].pml24) AND cl_null(g_pml[l_ac].pml25) THEN
                    #   CALL q_ima(1,1,g_plant) RETURNING g_multi_ima01
                    #   IF NOT cl_null(g_multi_ima01)  THEN
                    #      CALL t420_multi_ima01()
                    #      CALL t420_b_fill(' 1=1')
                    #      LET g_flag = TRUE
                    #      CALL t420_b()
                    #      EXIT INPUT
                    #   END IF
                    #ELSE
                     #MOD-AC0309------add------end------------------
#FUN-AA0059---------mod------------str-----------------
                     #FUN-B40042 Begin---
#                    # CALL cl_init_qry_var()
                     # IF g_azw.azw04 = '2' THEN
                     #    CALL cl_init_qry_var()                           #FUN-AA0059 add
                     #    LET g_qryparam.form = "q_rte03_2"
                     #    LET g_qryparam.default1 = g_pml[l_ac].pml04      #FUN-AA0059 add
                     #    CALL cl_create_qry() RETURNING g_pml[l_ac].pml04 #FUN-AA0059 add
                     #ELSE
#                    #    LET g_qryparam.form = "q_ima"                    #FUN-AA0059 mark
#                    #    CALL q_sel_ima(TRUE, "q_ima","",g_pml[l_ac].pml04,"","","","","",'')  RETURNING  g_pml[l_ac].pml04  #FUN-AA0059 add  #MOD-AC0309 mark
                     #    CALL q_sel_ima(FALSE, "q_ima","",g_pml[l_ac].pml04,"","","","","",'')  RETURNING  g_pml[l_ac].pml04  #FUN-AA0059 add #MOD-AC0309 add
                     #END IF  #No.FUN-870007
                      CALL q_sel_ima(FALSE, "q_ima","",g_pml[l_ac].pml04,"","","","","",'')  RETURNING  g_pml[l_ac].pml04
                     #FUN-B40042 End-----
#                     LET g_qryparam.default1 = g_pml[l_ac].pml04        #FUN-AA0059 mark
#                     CALL cl_create_qry() RETURNING g_pml[l_ac].pml04   #FUN-AA0059 mark
#FUN-AA0059---------mod------------end-----------------
                      DISPLAY g_pml[l_ac].pml04 TO pml04
                      NEXT FIELD pml04
                   #END IF   #MOD-AC0309 add
                WHEN INFIELD(pml07) #採購單位
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_gfe"
                     LET g_qryparam.default1 = g_pml[l_ac].pml07
                     CALL cl_create_qry() RETURNING g_pml[l_ac].pml07
                     DISPLAY g_pml[l_ac].pml07 TO pml07
                     NEXT FIELD pml07
               WHEN INFIELD(pml48)
                      CALL cl_init_qry_var()
                      #No.MOD-A70072  --Begin
                      #LET g_qryparam.form = "q_pmc1_1"
                      #LET g_qryparam.arg1 = g_plant
                      LET g_qryparam.form = "q_pmc1"
                      #No.MOD-A70072  --End
                      LET g_qryparam.default1=g_pml[l_ac].pml48
                      CALL cl_create_qry() RETURNING g_pml[l_ac].pml48
                      DISPLAY  g_pml[l_ac].pml48 TO pml48
                      CALL t420_pml48('d')
                      NEXT FIELD pml48
                WHEN INFIELD(pml33) #交貨日期
                     CALL t444()
                WHEN INFIELD(pml80) #單位
                     CALL cl_init_qry_var()
                     LET g_qryparam.form ="q_gfe"
                     LET g_qryparam.default1 = g_pml[l_ac].pml80
                     CALL cl_create_qry() RETURNING g_pml[l_ac].pml80
                     DISPLAY BY NAME g_pml[l_ac].pml80
                     NEXT FIELD pml80

                WHEN INFIELD(pml83) #單位
                     CALL cl_init_qry_var()
                     LET g_qryparam.form ="q_gfe"
                     LET g_qryparam.default1 = g_pml[l_ac].pml83
                     CALL cl_create_qry() RETURNING g_pml[l_ac].pml83
                     DISPLAY BY NAME g_pml[l_ac].pml83
                     NEXT FIELD pml83

                WHEN INFIELD(pml86) #單位
                     CALL cl_init_qry_var()
                     LET g_qryparam.form ="q_gfe"
                     LET g_qryparam.default1 = g_pml[l_ac].pml86
                     CALL cl_create_qry() RETURNING g_pml[l_ac].pml86
                     DISPLAY BY NAME g_pml[l_ac].pml86
                     NEXT FIELD pml86
               WHEN INFIELD(pml12)   #專案
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pja2"
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml12
                  DISPLAY BY NAME g_pml[l_ac].pml12
                  NEXT FIELD pml12
               WHEN INFIELD(pml121)  #WBS
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pjb4"
                  LET g_qryparam.arg1 = g_pml[l_ac].pml12
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml121
                  DISPLAY BY NAME g_pml[l_ac].pml121
                  NEXT FIELD pml121
               WHEN INFIELD(pml122)  #活動
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pjk3"
                  LET g_qryparam.arg1 = g_pml[l_ac].pml121
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml122
                  DISPLAY BY NAME g_pml[l_ac].pml122
                  NEXT FIELD pml122
               WHEN INFIELD(pml67)   #部門
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gem"
                  LET g_qryparam.default1 = g_pml[l_ac].pml67
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml67
                  DISPLAY BY NAME g_pml[l_ac].pml67
                  NEXT FIELD pml67
               WHEN INFIELD(pml90)  #費用原因
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf01a" #No.FUN-930104
                  LET g_qryparam.default1 = g_pml[l_ac].pml90
                  LET g_qryparam.arg1 = '7'       #No.FUN-930104
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml90
                  DISPLAY BY NAME g_pml[l_ac].pml90
                  NEXT FIELD pml90
               WHEN INFIELD(pml40)   #科目一
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_aag"
                  LET g_qryparam.default1 = g_pml[l_ac].pml40
                  LET g_qryparam.arg1 = g_bookno1
                  LET g_qryparam.where = " aag07 IN ('2','3')  AND aag03 = '2' "
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml40
                  DISPLAY BY NAME g_pml[l_ac].pml40
                  NEXT FIELD pml40
               WHEN INFIELD(pml401)  #科目二
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_aag"
                  LET g_qryparam.default1 = g_pml[l_ac].pml401
                  LET g_qryparam.arg1 = g_bookno2
                  LET g_qryparam.where = " aag03 IN ('2','4') "
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml401
                  DISPLAY BY NAME g_pml[l_ac].pml401
                  NEXT FIELD pml401
               WHEN INFIELD(pml930)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_gem4"
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml930
                  DISPLAY BY NAME g_pml[l_ac].pml930
                  NEXT FIELD pml930
               WHEN INFIELD(pml123)
                  LET l_ima926 = 'N'                #FUN-D30087 add
                  SELECT ima926 INTO l_ima926 FROM ima_file  #FUN-D30087 add
                   WHERE ima01 = g_pml[l_ac].pml04           #FUN-D30087 add
                  CALL cl_init_qry_var()
                  IF l_ima926 = 'Y' THEN            #FUN-D30087 add
                     LET g_qryparam.form = "q_bmj3" #FUN-D30087 add
                  ELSE                              #FUN-D30087 add
                     LET g_qryparam.form = "q_mse"
                  END IF                            #FUN-D30087 add
                  LET g_qryparam.arg1 = g_pml[l_ac].pml04    #FUN-D30087 add
                  LET g_qryparam.default1 = g_pml[l_ac].pml123
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml123
                  DISPLAY BY NAME g_pml[l_ac].pml123
                  NEXT FIELD pml123
               WHEN INFIELD(pml191)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_geu"
                  LET g_qryparam.default1 = g_pml[l_ac].pml191
                  LET g_qryparam.arg1 = '4'
                  CALL cl_create_qry() RETURNING g_pml[l_ac].pml191
                  DISPLAY BY NAME g_pml[l_ac].pml191
                  NEXT FIELD pml191
               OTHERWISE EXIT CASE
             END CASE

          ON ACTION maintain_item_master
             IF g_sma.sma38 MATCHES'[Yy]' THEN
                IF not cl_null(g_pml[l_ac].pml04) THEN
                   LET g_cmd = "aimi100 '",g_pml[l_ac].pml04 CLIPPED,"'"
                ELSE
                   LET g_cmd = "aimi100 "
                END IF
                CALL cl_cmdrun(g_cmd)
             ELSE
                CALL cl_err(g_sma.sma38,'mfg0035',1)
             END IF

          ON ACTION maintain_unit_data
             LET g_cmd = 'aooi101 '
             CALL cl_cmdrun(g_cmd)

          ON ACTION maintain_unit_conversion
             LET g_cmd = 'aooi102 '
             CALL cl_cmdrun(g_cmd)

          ON ACTION maintain_item_unit_conversion
             LET g_cmd = 'aooi103 '
             CALL cl_cmdrun(g_cmd)

          ON ACTION maintain_pr_unit_conv
             CALL t442()

          ON ACTION maintain_date_data
             CALL t444()


          ON ACTION special_description #特別說明
             LET g_cmd = "apmt402 0 '",g_pmk.pmk01,"' ",g_pml[l_ac].pml02
             CALL cl_cmdrun_wait(g_cmd)  #FUN-660216 add

          ON ACTION item_vender_query
             IF NOT cl_null(g_pmk.pmk09) THEN
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_pmh"
                 LET g_qryparam.arg1 = g_pmk.pmk09  #No.MOD-480478
                 LET g_qryparam.default1 = g_pml[l_ac].pml04
                 CALL cl_create_qry() RETURNING g_pml[l_ac].pml04
                 DISPLAY g_pml[l_ac].pml04 TO pml04
                 NEXT FIELD pml04
             ELSE
                 #供應廠商並無輸入,所以無法在此^U!
                 CALL cl_err('','apm-004',0)
             END IF

          ON ACTION item_inquiry_list
             CALL t420_b_more()

         #FUN-D30088---add---S
          ON ACTION regen_detail   #單身全部刪除再重新產生
             IF g_pmk.pmk18 = 'Y' OR g_pmk.pmk18 = 'X' THEN
                CALL cl_err('','aim-027',0)
                EXIT DIALOG
             END IF
             IF NOT cl_confirm('aim-148') THEN
                EXIT DIALOG
             END IF
             CALL t420_del()
             CALL g_pml.clear()
             CALL t420_g_2()
             CALL t420_b_fill(' 1=1',' 1=1')
             EXIT DIALOG
         #FUN-D30088---add---E

          ON ACTION CONTROLO                        #沿用所有欄位
             IF INFIELD(pml02) AND l_ac > 1 THEN
                LET g_pml[l_ac].* = g_pml[l_ac-1].*
                SELECT max(pml02)+1 INTO g_pml[l_ac].pml02
                  FROM pml_file WHERE pml01 = g_pmk.pmk01
                IF g_pml[l_ac].pml02 IS NULL THEN
                    LET g_pml[l_ac].pml02 = 1
                END IF
                DISPLAY BY NAME g_pml[l_ac].*
                SELECT pml_file.* INTO g_pml2.*
                  FROM pml_file
                 WHERE pml01 = g_pmk.pmk01
                   AND pml02 = g_pml[l_ac-1].pml02
                NEXT FIELD pml02
             END IF

#FUN-B90101--mark--begin--
#          ON ACTION CONTROLR
#            CALL cl_show_req_fields()
#
#         ON ACTION CONTROLG
#            CALL cl_cmdask()
#
#         ON ACTION CONTROLF
#        CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
#        CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
#
#
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
#
#     ON ACTION about         #MOD-4C0121
#        CALL cl_about()      #MOD-4C0121
#
#     ON ACTION help          #MOD-4C0121
#        CALL cl_show_help()  #MOD-4C0121
#
#     ON ACTION controls                           #No.FUN-6B0032
#        CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032
#
#FUN-B90101--mark--end--
       END INPUT
#FUN-B90101--add--begin--
#&endif      #FUN-C20006 mark

#FUN-C20006--mark-begin--
#&ifdef SLK
#      ON ACTION controlb
#         SELECT ima151 INTO l_ima151 FROM ima_file WHERE ima01 = g_pmlslk[l_ac2].pmlslk04
#         IF l_ima151 = 'Y' THEN
#            IF li_a THEN
#               LET li_a = FALSE
#               NEXT FIELD pmlslk04
#            ELSE
#               LET li_a = TRUE
#               NEXT FIELD color
#            END IF
#         END IF
#&endif
#FUN-C20006--mark--end--
   #TQC-D40025--add--str--
         BEFORE DIALOG
         CASE g_b_flag
            WHEN '1' NEXT FIELD pml02
         END CASE
   #TQC-D40025--add--end--

       ON ACTION CONTROLR
          CALL cl_show_req_fields()

       ON ACTION controlg
         CALL cl_cmdask()

#FUN-D50097 ------- mark ----------- begin ------------
#       ON ACTION CONTROLF
#          CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
#          CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
#FUN-D50097 ------- mark ----------- end --------------

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE DIALOG

       ON ACTION about         #MOD-4C0121
          CALL cl_about()      #MOD-4C0121

       ON ACTION help          #MOD-4C0121
          CALL cl_show_help()  #MOD-4C0121

       ON ACTION controls                           #No.FUN-6B0032
          CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032

       ON ACTION ACCEPT
          ACCEPT DIALOG

       ON ACTION CANCEL
    #TQC-D40025--add--str--
         IF g_b_flag = '1' THEN
            IF p_cmd = 'a' THEN
               CALL g_pml.deleteElement(l_ac)
               IF g_rec_b != 0 THEN
                  LET g_action_choice = "detail"
                  LET l_ac = l_ac_t
               END IF
            END IF
         END IF
    #TQC-D40025--add--end--
         EXIT DIALOG

#FUN-D50097 ------- add ------------ begin ------------
       ON ACTION CONTROLF
          CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
          CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
#FUN-D50097 ------- add ------------ end --------------

    END DIALOG
#FUN-B90101--add--end--
       UPDATE pmk_file SET pmkmodu=g_user,pmkdate=g_today ,pmk25 = l_pmk25
         WHERE pmk01=g_pmk.pmk01
       LET g_pmk.pmk25 = l_pmk25
       DISPLAY BY NAME g_pmk.pmk25
       CALL t420_pic() #FUN-730012

       CALL t420_b_fill('1=1',' 1=1')    #FUN-B90101 add
       CLOSE t420_bcl
       COMMIT WORK
       CALL t420_delHeader()     #CHI-C30002 add
END FUNCTION

#FUN-D30088---add---S
FUNCTION t420_del()
   DELETE FROM pml_file WHERE pml01 = g_pmk.pmk01
END FUNCTION

FUNCTION t420_g_2()  ####單身產生方式(直接輸入、工單、BOM、訂單)
DEFINE  l_chr       LIKE type_file.chr1
DEFINE  l_cnt       LIKE type_file.num5

    OPEN WINDOW t4204_w WITH FORM "apm/42f/apmt4204"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
    CALL cl_ui_locale("apmt4204")

    LET l_chr='1'
    INPUT l_chr WITHOUT DEFAULTS FROM FORMONLY.a

    AFTER FIELD a
       IF l_chr NOT MATCHES '[1234]' THEN
          NEXT FIELD a
       END IF

    ON ACTION CONTROLR
       CALL cl_show_req_fields()

    ON ACTION CONTROLG
       CALL cl_cmdask()

    AFTER INPUT
       IF INT_FLAG THEN                         # 若按了DEL鍵
          LET INT_FLAG = 0
          EXIT INPUT
       END IF

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

       ON ACTION about
          CALL cl_about()

       ON ACTION help
          CALL cl_show_help()

    END INPUT

    IF INT_FLAG THEN
       LET INT_FLAG=0
       LET l_chr = '1'
    END IF

    CLOSE WINDOW t4204_w

    IF cl_null(l_chr) THEN
       LET l_chr = '1'
    END IF
    LET g_rec_b = 0
    CASE
       WHEN l_chr = '1'
            CALL g_pml.clear()
            CALL t420_b()
       WHEN l_chr = '2'
            CALL p470("G",g_pmk.pmk01)
            COMMIT WORK
            LET g_wc2=NULL
            CALL t420_b_fill(g_wc2,' 1=1')       #第二個參數，服飾中母單身的條件
            LET g_action_choice="detail"
            IF cl_chk_act_auth() THEN
               CALL t420_b()
            ELSE
               RETURN
            END IF
       WHEN l_chr='3'
            CALL p480(g_pmk.pmk01)
            LET g_wc2=NULL
            CALL t420_b_fill(g_wc2,' 1=1')       #第二個參數，服飾中母單身的條件
            LET g_action_choice="detail"
            IF cl_chk_act_auth() THEN
               CALL t420_b()
            ELSE
               RETURN
            END IF
       WHEN l_chr='4'
            CALL p500("G",g_pmk.pmk01,"")
            LET g_wc2=NULL
            CALL t420_b_fill(g_wc2,' 1=1')       #第二個參數，服飾中母單身的條件
            LET g_action_choice="detail"
            IF cl_chk_act_auth() THEN
               CALL t420_b()
            ELSE
               RETURN
            END IF
       OTHERWISE EXIT CASE
    END CASE
    LET g_pmk_t.* = g_pmk.*                #保存上筆資料
    LET g_pmk_o.* = g_pmk.*                #保存上筆資料
    CALL t420_sign('a')
END FUNCTION
#FUN-D30088---add---E

#CHI-C30002 -------- add -------- begin
FUNCTION t420_delHeader()
DEFINE l_n LIKE type_file.num5
DEFINE l_action_choice    STRING               #CHI-C80041
DEFINE l_cho              LIKE type_file.num5  #CHI-C80041
DEFINE l_num              LIKE type_file.num5  #CHI-C80041
DEFINE l_slip             LIKE type_file.chr5  #CHI-C80041
DEFINE l_sql              STRING               #CHI-C80041
DEFINE l_cnt              LIKE type_file.num5  #CHI-C80041

   SELECT COUNT(*) INTO l_n FROM pml_file WHERE pml01 = g_pmk.pmk01
   IF l_n = 0 THEN
      #CHI-C80041---begin
      CALL s_get_doc_no(g_pmk.pmk01) RETURNING l_slip
      LET l_sql = " SELECT COUNT(*) FROM pmk_file ",
                  "  WHERE pmk01 LIKE '",l_slip,"%' ",
                  "    AND pmk01 > '",g_pmk.pmk01,"'"
      PREPARE t420_pb1 FROM l_sql
      EXECUTE t420_pb1 INTO l_cnt

      LET l_action_choice = g_action_choice
      LET g_action_choice = 'delete'
      IF cl_chk_act_auth() AND l_cnt = 0 THEN
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

         ON ACTION help
            CALL cl_show_help()

         ON ACTION controlg
            CALL cl_cmdask()
      END PROMPT
      IF l_cho > l_num THEN LET l_cho = 1 END IF
      IF l_cho = 2 THEN
         #CALL t420_x() #FUN-D20025 mark
         CALL t420_x(1) #FUN-D20025 add
         CALL t420sub_refresh(g_pmk.pmk01) RETURNING g_pmk.*
         CALL t420_show()
      END IF

      IF l_cho = 3 THEN
         DELETE FROM pmo_file WHERE pmo01 = g_pmk.pmk01
         DELETE FROM pmp_file WHERE pmp01 = g_pmk.pmk01
      #CHI-C80041---end
      #IF cl_confirm("9042") THEN  #CHI-C80041
         DELETE FROM pmk_file WHERE pmk01=g_pmk.pmk01
         INITIALIZE g_pmk.* TO NULL
         CLEAR FORM
      END IF
   END IF
END FUNCTION
#CHI-C30002 -------- add -------- end
FUNCTION check_pml04_1()
DEFINE l_cnt LIKE type_file.num5
DEFINE l_n LIKE type_file.num5
DEFINE l_rtz04 LIKE rtz_file.rtz04
DEFINE l_rte04 LIKE rte_file.rte04
DEFINE l_rte07 LIKE rte_file.rte07
DEFINE l_rtdconf LIKE rtd_file.rtdconf
DEFINE li_result LIKE type_file.chr1

    LET l_cnt=0
    SELECT COUNT(*) INTO l_cnt FROM rty_file
     WHERE rty01=g_plant AND rty02=g_pml[l_ac].pml04 AND rtyacti='Y'
    IF l_cnt=0 THEN
       CALL cl_err('','art-229',0)
       RETURN FALSE
    END IF
    #商品策略管控
    SELECT rtz04 INTO l_rtz04
  #   FROM rtz_file                            #FUN-A80148 mark
  #  WHERE rtz01=g_plant AND rtzacti='Y'       #FUN-A80148 mark
      FROM rtz_file INNER JOIN azw_file        #FUN-A80148 add
        ON rtz01 = azw01                       #FUN-A80148 add
    WHERE rtz01=g_plant AND azwacti = 'Y'      #fun-a80148 add
    IF NOT cl_null(l_rtz04) THEN
       SELECT rte04,rte07,rtdconf INTO l_rte04,l_rte07,l_rtdconf
         FROM rte_file,rtd_file
        WHERE rte01=rtd01 AND rte03=g_pml[l_ac].pml04
          AND rte01=l_tqb13
       IF SQLCA.sqlcode=100 THEN
           CALL cl_err('','art-431',0)
           RETURN FALSE
       END IF
       IF l_rte04='N' THEN
          CALL cl_err('','art-435',0)
          RETURN FALSE
       END IF
       IF l_rte07='N' THEN
          CALL cl_err('','art-433',0)
          RETURN FALSE
       END IF
       IF l_rtdconf !='Y' THEN
          CALL cl_err('','art-434',0)
          RETURN FALSE
       END IF
    END IF

    #條碼對應的商品 與 請購單的供應商 須滿足以下條件
    IF NOT cl_null(g_pmk.pmk09) THEN
       CALL check() RETURNING li_result
       IF NOT li_result THEN
          RETURN FALSE
       END IF
    ELSE
       #經營方式，供應商
       SELECT rty06,rty05
         INTO g_pml[l_ac].pml49,g_pml[l_ac].pml48
         FROM rty_file
        WHERE rty01=g_plant AND rtyacti='Y'
          AND rty02=g_pml[l_ac].pml04
       {LET  l_n=0
       SELECT COUNT(*) INTO l_n FROM pmc_file
        WHERE pmc01=g_pml[l_ac].pml48 AND pmc930=g_plant
       IF l_n !=0 THEN CALL cl_err('','art-445',0) RETURN FALSE END IF}
       CALL check() RETURNING li_result
       IF NOT li_result THEN
         RETURN FALSE
       END IF
    END IF
   RETURN TRUE
END FUNCTION

FUNCTION check()
DEFINE l_n LIKE type_file.num5
DEFINE l_rto06 LIKE rto_file.rto06

   LET l_n=0
   SELECT COUNT(*) INTO l_n FROM rtt_file,rts_file,rto_file
                   WHERE rtt04 = g_pml[l_ac].pml04
                     #AND rtt930 = g_pmk.pmkplant            #TQC-C50053 mark
                     AND rttplant = g_pmk.pmkplant           #TQC-C50053 add
                     AND rtt15 = 'Y'
                     AND rts01 = rtt01
                     AND rts02 = rtt02
                     AND rto01 = rts04
                     AND rto03 = rts02
                     #AND rts930 = g_pmk.pmkplant             #TQC-C50053 mark
                     AND rtsplant = g_pmk.pmkplant            #TQC-C50053 add
                     AND rtsconf = 'Y'
                     AND rto05 = g_pml[l_ac].pml48
                     AND rtoconf ='Y'
                     AND rto08 <= g_today
                     AND rto09 >= g_today
                     AND rtoplant = g_pmk.pmkplant
   IF l_n>0 THEN
      SELECT DISTINCT rto06 INTO l_rto06 FROM rtt_file,rts_file,rto_file
                   WHERE rtt04 = g_pml[l_ac].pml04
                     #AND rtt930 = g_pmk.pmkplant            #TQC-C50053 mark
                     AND rttplant = g_pmk.pmkplant           #TQC-C50053 add
                     AND rtt15 = 'Y'
                     AND rts01 = rtt01
                     AND rts02 = rtt02
                     AND rto01 = rts04
                     AND rto03 = rts02
                     #AND rts930 = g_pmk.pmkplant             #TQC-C50053 mark
                     AND rtsplant = g_pmk.pmkplant            #TQC-C50053 add
                     AND rtsconf = 'Y'
                     AND rto05 = g_pml[l_ac].pml48
                     AND rtoconf ='Y'
                     AND rto08 <= g_today
                     AND rto09 >= g_today
                     AND rtoplant = g_pmk.pmkplant
   ELSE
      LET l_n=0
      {SELECT COUNT(*) INTO l_n FROM tqb_file
       WHERE tqb01=(SELECT pmc930 FROM pmc_file WHERE pmc01=g_pml[l_ac].pml48)
         AND tqb09 = '4'}
      SELECT COUNT(*) INTO l_n FROM pmc_file
       WHERE pmc01=g_pml[l_ac].pml48
         AND pmc05='1'
         AND pmc30 !='2'
         AND pmcacti='Y'
         AND (pmc930 !=g_plant OR pmc930 IS NULL)
      IF l_n=0 THEN
         CALL cl_err('','art-479',0)
         RETURN FALSE
      ELSE
         LET l_rto06='1'
      END IF
   END IF

   IF NOT cl_null(g_pmk.pmk09) THEN
      LET g_pml[l_ac].pml49=l_rto06
   END IF

   RETURN TRUE

END FUNCTION

FUNCTION t420_pml47(p_cmd)
DEFINE p_cmd LIKE type_file.chr1
DEFINE l_rta01 LIKE rta_file.rta01
DEFINE l_rta03 LIKE rta_file.rta03
   SELECT rta01,rta03 INTO l_rta01,l_rta03 FROM rta_file
    WHERE rta05=g_pml[l_ac].pml47
   IF SQLCA.sqlcode=100 THEN
      LET l_rta01=null
      LET l_rta03=null
   END IF
   IF p_cmd='d' THEN
      LET g_pml[l_ac].pml04=l_rta01
      LET g_pml[l_ac].pml07=l_rta03
      SELECT ima02,ima021 INTO g_pml[l_ac].pml041,g_pml[l_ac].ima021 FROM ima_file
       WHERE ima01=g_pml[l_ac].pml04
   END IF

END FUNCTION

FUNCTION t420_pml48(p_cmd)
DEFINE p_cmd LIKE type_file.chr1
DEFINE l_pmc03 LIKE pmc_file.pmc03
   SELECT pmc03 INTO l_pmc03 FROM pmc_file
    WHERE pmc01=g_pml[l_ac].pml48 AND pmcacti='Y'
   IF SQLCA.sqlcode=100 THEN
      LET l_pmc03=null
   END IF
   IF p_cmd='d' THEN
      LET g_pml[l_ac].pml48_desc =l_pmc03
   END IF
END FUNCTION

FUNCTION t420_pml4953(p_cmd)
DEFINE p_cmd LIKE type_file.chr1
DEFINE l_rty03 LIKE rty_file.rty03
   SELECT rty03 INTO l_rty03 FROM rty_file
    WHERE rty01=g_plant AND rty02=g_pml[l_ac].pml04
   IF p_cmd='d' THEN
      LET g_pml[l_ac].pml50=l_rty03
      IF g_pml[l_ac].pml50='2' OR g_pml[l_ac].pml50='4' THEN  #No.FUN-A10037
         LET g_pml[l_ac].pml51=g_plant
         LET g_pml[l_ac].pml52=g_pmk.pmk01
         LET g_pml[l_ac].pml53=g_pml[l_ac].pml02
      ELSE
         LET g_pml[l_ac].pml51=''
         LET g_pml[l_ac].pml52=''
         LET g_pml[l_ac].pml53=''
      END IF
   END IF
END FUNCTION


#專案需求 pjf_file 架構修改為
#pjf01:WBS  pjf02:項次  pjf03:料號  pjf04:品名 pjf05:需求量
#所以check數量改以 WBS及料號 check pjf05
FUNCTION t420_chk_pjf05(p_pml121,p_pml04,p_pml20_t)
    DEFINE p_pml121    LIKE pml_file.pml121,  #WBS
           p_pml20_t   LIKE pml_file.pml20,   #請購量
           p_pml04     LIKE pml_file.pml04,   #料號
           l_pjf05     LIKE pjf_file.pjf05,   #需求數量
           l_pml20     LIKE pml_file.pml20,
           l_pml       RECORD LIKE pml_file.*

    LET g_errno = ''
    SELECT pjf05 INTO l_pjf05 FROM pjf_file
     WHERE pjf01 = p_pml121
       AND pjf03 = p_pml04

   #合計&換算單位數量
    SELECT SUM(pml20) INTO l_pml20 FROM pml_file
     WHERE pml121=p_pml121 AND pml04=p_pml04
    IF cl_null(l_pml20)  THEN LET l_pml20=0   END IF
    LET l_pml20 = l_pml20-p_pml20_t+g_pml[l_ac].pml20
    IF l_pml20 > l_pjf05 THEN CALL cl_err('','apm-165','1')  END IF
END FUNCTION

FUNCTION t420_azi()
  DEFINE  l_aziacti LIKE  azi_file.aziacti

  LET g_errno = ' '
  IF cl_null(g_pmk.pmk22) THEN LET g_pmk.pmk22 = g_aza.aza17 END IF
  SELECT azi03,azi04,azi05,aziacti INTO t_azi03,t_azi04,t_azi05,l_aziacti   #No.CHI-6A0004
    FROM azi_file
   WHERE azi01 = g_pmk.pmk22
   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg3008'
                                 LET l_aziacti = NULL
        WHEN l_aziacti='N' LET g_errno = '9028'
        OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF g_pmk.pmk22 != g_aza.aza17 THEN
      SELECT azi03,azi04,azi05
        INTO g_azi03_l,g_azi04_l,g_azi05_l
        FROM azi_file
       WHERE azi01 = g_aza.aza17  AND aziacti IN ('Y','y')
   END IF
  IF cl_null(g_azi03_l) THEN  LET g_azi03_l = t_azi03 END IF  #No.CHI-6A0004
  IF cl_null(g_azi04_l) THEN  LET g_azi04_l = t_azi04 END IF  #No.CHI-6A0004
  IF cl_null(g_azi05_l) THEN  LET g_azi05_l = t_azi05 END IF  #No.CHI-6A0004
END FUNCTION

FUNCTION t420_pml04(p_cmd,p_no)  #料件編號
    DEFINE l_ima02   LIKE ima_file.ima02,
           l_ima021  LIKE ima_file.ima021,
           l_ima39   LIKE ima_file.ima39,
           l_ima391  LIKE ima_file.ima391, #No.FUN-680029
           l_ima140  LIKE ima_file.ima140, #No:7225
           l_ima1401 LIKE ima_file.ima1401, #FUN-6A0036
           l_imaacti LIKE ima_file.imaacti,
           p_no      LIKE type_file.chr4,    #No.FUN-680136 VARCHAR(04)
           p_cmd     LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)

  LET g_errno = " "
  SELECT ima02,ima021,ima39,ima391,ima49,ima491,ima140,ima1401,imaacti,  #No:7225 #No.FUN-680029 add ima391  #FUN-6A0036
         ima913,ima914   #No.FUN-630040
    INTO l_ima02,l_ima021,l_ima39,l_ima391,g_ima49,g_ima491,l_ima140,l_ima1401,l_imaacti, #No:7225  #No.FUN-680029 add l_ima391 #FUN-6A0036 add ima1401
         g_pml2.pml190,g_pml2.pml191   #No.FUN-630040
    FROM ima_file
   WHERE ima01 = g_pml[l_ac].pml04

  CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg0002'
                          LET l_ima02 = NULL  LET l_imaacti = NULL
       WHEN l_imaacti='N' LET g_errno = '9028'
       WHEN l_imaacti MATCHES '[PH]'  LET g_errno = '9038'  #No.FUN-690022 add
       WHEN l_ima140 = 'Y' AND l_ima1401 <= g_pmk.pmk04
         LET g_errno = 'apm-006' #No:7225
       OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
  END CASE
  #MISC料無效時不可用於請/採購
  IF g_pml[l_ac].pml04[1,4]='MISC' AND g_errno<>'9028' THEN
     LET g_errno=''
  END IF
     LET g_pml[l_ac].pml041 = l_ima02
     LET g_pml2.pml041      = l_ima02
     LET g_pml[l_ac].ima021 = l_ima021
  LET g_pml[l_ac].pml190 = g_pml2.pml190   #No.FUN-630040
  LET g_pml[l_ac].pml191 = g_pml2.pml191   #No.FUN-630040
  IF g_pml[l_ac].pml04[1,4] <> 'MISC' AND (g_pml2.pml40 IS NULL OR g_pml2.pml40=' ')
     THEN LET g_pml2.pml40 = l_ima39
  END IF
  IF g_aza.aza63 = 'Y' THEN
     IF g_pml[l_ac].pml04[1,4] <> 'MISC' AND (g_pml2.pml401 IS NULL OR g_pml2.pml401 =' ') THEN
        LET g_pml2.pml401 = l_ima391
     END IF
  END IF
  IF cl_null(g_ima49) THEN LET g_ima49 = 0 END IF
  IF cl_null(g_ima491) THEN LET g_ima491 = 0 END IF
  IF p_no <> 'bi' OR cl_null(p_no) THEN    #MOD-920166
     DISPLAY g_pml[l_ac].pml041 TO pml041 #MOD-530058 add
     DISPLAY g_pml[l_ac].ima021 TO ima021 #MOD-530058 add
  END IF   #MOD-920166
END FUNCTION

FUNCTION t420_b_more()
    DEFINE l_cnt  LIKE type_file.num5

    OPEN WINDOW t4205_w WITH FORM "apm/42f/apmt4205"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("apmt4205")


    INPUT BY NAME g_pml2.pml06,g_pml2.pml03 WITHOUT DEFAULTS

    BEFORE FIELD pml06
     IF cl_null(g_pml2.pml06) THEN
        SELECT  pmh04 INTO g_pml2.pml06 FROM pmh_file
         WHERE pmh01 = g_pml2.pml04 AND pmh02 = g_pmk.pmk09
           AND pmh13 = g_pmk.pmk22
           AND pmh22 = '1' AND pmh21 =' '    #No.CHI-8C0017 add
           AND pmh23 = ' '                                             #No.CHI-960033
           AND pmhacti = 'Y'                                           #CHI-910021
        DISPLAY BY NAME g_pml2.pml06
     END IF

    AFTER FIELD pml03  #詢價單號
      IF NOT cl_null(g_pml2.pml03) THEN
         CALL t420_pml03()
         IF NOT cl_null(g_errno) THEN
            CALL cl_err(g_pml2.pml03,g_errno,0)
            LET g_pml2.pml03 = g_pml_o.pml03
            DISPLAY BY NAME g_pml2.pml03
            NEXT FIELD pml03
         END IF
         IF NOT cl_null(g_pmk.pmk09) THEN  #詢價單號的廠商與P/O 不同   #FUN-650191
            SELECT COUNT(*) INTO l_cnt FROM pmx_file
             WHERE pmx01= g_pml2.pml03
               AND pmx12 = g_pmk.pmk09
               AND pmx10 = " "                                        #CHI-860042
               AND pmx11 = '1'                                        #CHI-860042
            IF l_cnt = 0 THEN
              CALL cl_err(g_pml2.pml03,'mfg0028',0)
              NEXT FIELD pml03
            END IF
         END IF
      END IF
      LET g_pml_o.pml03 = g_pml2.pml03

    ON ACTION CONTROLR
       CALL cl_show_req_fields()

    ON ACTION CONTROLG
       CALL cl_cmdask()

    AFTER INPUT
       IF INT_FLAG THEN                         # 若按了DEL鍵
          LET INT_FLAG = 0
          EXIT INPUT
       END IF
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121


    END INPUT
    CLOSE WINDOW t4205_w                 #結束畫面
    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
END FUNCTION

FUNCTION t420_pml03()  #詢價單號
   DEFINE l_pmwacti   LIKE pmw_file.pmwacti

   LET g_errno = " "

   SELECT pmwacti INTO l_pmwacti   #FUN-650191 拿掉 pmw03
     FROM pmw_file
    WHERE pmw01 = g_pml2.pml03

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET g_errno = 'mfg3051'
         LET l_pmwacti = NULL
      WHEN l_pmwacti='N'
         LET g_errno = '9028'
      OTHERWISE
         LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

END FUNCTION

#系統參數設料件/供應商須存在
#FUNCTION t420_pmh()  #供應廠商   #CHI-B80082 mark
FUNCTION t420_pmh(p_pml04)        #CHI-B80082
   DEFINE l_pmhacti   LIKE pmh_file.pmhacti
   DEFINE l_pmh05     LIKE pmh_file.pmh05
   DEFINE p_pml04     LIKE pml_file.pml04   #CHI-B80082 add

   LET g_errno = " "

   SELECT pmhacti,pmh05 INTO l_pmhacti,l_pmh05
     FROM pmh_file
#   WHERE pmh01 = g_pml[l_ac].pml04   #CHI-B80082 mark
    WHERE pmh01 = p_pml04             #CHI-B80082
      AND pmh02 = g_pmk.pmk09
      AND pmh13 = g_pmk.pmk22
      AND pmh22 = '1' AND pmh21 =' '    #No.CHI-8C0017 add
      AND pmh23 = ' '                                             #No.CHI-960033
      AND pmhacti = 'Y'                                           #CHI-910021

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET g_errno = 'mfg0031'
         LET l_pmhacti = NULL
      WHEN l_pmhacti = 'N'
         LET g_errno = '9028'
      WHEN l_pmh05 MATCHES '[12]'
         LET g_errno = 'mfg3043'   #00/03/07 add
      OTHERWISE
         LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

END FUNCTION

#料件輸入完後
FUNCTION t420_def()
  DEFINE  l_imaacti  LIKE ima_file.imaacti,
          l_ima02    LIKE ima_file.ima02,
          l_ima021   LIKE ima_file.ima021

  LET g_errno = " "
#來源料件主檔的預設值 (版本/採購單位/庫存單位/OPC/再補貨量)
  SELECT ima44,ima25,ima37,ima99,imaacti,ima02,ima021,ima913,ima914   #No.FUN-630040
    INTO g_pml2.pml07,g_pml2.pml08,g_ima37,g_ima99,
         l_imaacti,l_ima02,l_ima021,g_pml2.pml190,g_pml2.pml191   #No.FUN-630040
    FROM ima_file
   WHERE ima01=g_pml[l_ac].pml04
   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg0002'
                                   LET l_imaacti = NULL
         WHEN l_imaacti='N' LET g_errno = '9028'
         WHEN l_imaacti MATCHES '[PH]'       LET g_errno = '9038'  #No.FUN-690022 add
         OTHERWISE          LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF NOT cl_null(g_errno) THEN RETURN END IF
   LET g_pml[l_ac].pml07 = g_pml2.pml07

   LET g_pml[l_ac].pml190 = g_pml2.pml190   #No.FUN-630040
   LET g_pml[l_ac].pml191 = g_pml2.pml191   #No.FUN-630040

#來源料件/供廠商對應檔的預設值(廠商料件)
   SELECT  pmh04 INTO g_pml2.pml06 FROM pmh_file
           WHERE pmh01 = g_pml[l_ac].pml04 AND pmh02 = g_pmk.pmk09
             AND pmh13 = g_pmk.pmk22
             AND pmh22 = '1' AND pmh21 =' '    #No.CHI-8C0017 add
             AND pmh23 = ' '                                             #No.CHI-960033
             AND pmhacti = 'Y'                                           #CHI-910021

#來源料件/供廠商對應檔的預設值(超短交限率)
   CALL s_overate(g_pml[l_ac].pml04) RETURNING g_pml2.pml13

#來源料件/供廠商對應檔的預設值(標準價格)
   SELECT imb118 INTO g_pml2.pml30 FROM imb_file
                WHERE imb01 = g_pml[l_ac].pml04

END FUNCTION

FUNCTION t420_unit(p_unit)  #單位
   DEFINE p_unit    LIKE gfe_file.gfe01,
          l_gfeacti LIKE gfe_file.gfeacti

   LET g_errno = ' '

   SELECT gfeacti INTO l_gfeacti
     FROM gfe_file
    WHERE gfe01 = p_unit

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET g_errno = 'mfg2605'
         LET l_gfeacti = NULL
      WHEN l_gfeacti = 'N'
         LET g_errno = '9028'
      OTHERWISE
         LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

END FUNCTION

FUNCTION t441(p_cmd)
   DEFINE p_cmd    LIKE type_file.num5,    #No.FUN-680136 VARCHAR(01)
          l_seq    LIKE type_file.num5,    #No.FUN-680136 SMALLINT
          l_flag   LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)

   OPEN WINDOW t441_w WITH FORM "apm/42f/apmt441"
     ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

   CALL cl_ui_locale("apmt441")

   IF p_cmd = 'u' THEN
      SELECT pml40 INTO g_pml2.pml40 FROM pml_file
       WHERE pml01 = g_pmk.pmk01
         AND pml02 = g_pml[l_ac].pml02
      IF SQLCA.sqlcode THEN
         LET g_pml2.pml40 = ' '
      END IF
   ELSE
      IF g_pml[l_ac].pml02 > 1 THEN
         LET l_seq = g_pml[l_ac].pml02 - 1
         SELECT pml40 INTO g_pml2.pml40 FROM pml_file
          WHERE pml01 = g_pmk.pmk01
            AND pml02 = l_seq
         IF SQLCA.sqlcode THEN
            LET g_pml2.pml40 = ' '
         END IF
      END IF
   END IF

   DISPLAY BY NAME g_pml2.pml40

   INPUT BY NAME g_pml2.pml40 WITHOUT DEFAULTS

      AFTER FIELD pml40                 #會計科目
         IF NOT cl_null(g_pml2.pml40) THEN
            IF g_sma.sma03='Y' THEN
               IF NOT s_actchk3(g_pml2.pml40,g_bookno1) THEN  #No.FUN-730033
                  CALL cl_err(g_pml2.pml40,'mfg0018',0)
#FUN-B10052 --begin--
#                 LET g_pml2.pml40 = g_pml_o.pml40
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_aag"
                 LET g_qryparam.default1 = g_pml2.pml40
                 LET g_qryparam.arg1 = g_bookno1
                 LET g_qryparam.construct = 'N'
                 LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aag01 LIKE '",g_pml2.pml40 CLIPPED,"%'"
                 CALL cl_create_qry() RETURNING g_pml2.pml40
                 DISPLAY BY NAME g_pml2.pml40
#FUN-B10052 --end--
                  NEXT FIELD pml40
               END IF
            END IF
         END IF
         LET g_pml_o.pml40 = g_pml2.pml40

      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(pml40) #會計科目
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_aag"
                 LET g_qryparam.default1 = g_pml2.pml40
                 LET g_qryparam.arg1 = g_bookno1  #No.FUN-730033
                  LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' " #MOD-4B0276
                 CALL cl_create_qry() RETURNING g_pml2.pml40

               DISPLAY BY NAME g_pml2.pml40
               NEXT FIELD pml40
            OTHERWISE EXIT CASE
         END CASE

      ON ACTION CONTROLR
         CALL cl_show_req_fields()

      ON ACTION CONTROLG
         CALL cl_cmdask()

      AFTER INPUT
         IF INT_FLAG THEN                         # 若按了DEL鍵
            LET INT_FLAG = 0
            EXIT INPUT
         END IF
         LET l_flag = 'N'
         IF l_flag = 'Y' THEN
            CALL cl_err('','9033',0)
            NEXT FIELD pml40
         END IF

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

   END INPUT

   CLOSE WINDOW t441_w

   LET g_pml[l_ac].pml40 = g_pml2.pml40
   DISPLAY BY NAME g_pml[l_ac].pml40

END FUNCTION

FUNCTION  t442()
  DEFINE  l_flag   LIKE type_file.chr1    #No.FUN-680136 VARCHAR(1)
  DEFINE  l_ima906 LIKE ima_file.ima906 #No.FUN-540027

  OPEN WINDOW t442_w WITH FORM "apm/42f/apmt442"
        ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("apmt442")

    SELECT ima906 INTO l_ima906 FROM ima_file WHERE ima01=g_pml2.pml04
    CALL cl_set_comp_entry("pml81,pml84",FALSE)
    IF g_sma.sma115 = 'Y' THEN
       CALL cl_set_comp_visible("pml07",FALSE)
       CALL cl_set_comp_visible("pml09",FALSE)
       CALL cl_set_comp_att_text("pml07",' ')
       CALL cl_set_comp_att_text("pml09",' ')
    ELSE
       CALL cl_set_comp_visible("pml83",FALSE)
       CALL cl_set_comp_visible("pml84",FALSE)
       CALL cl_set_comp_visible("pml80",FALSE)
       CALL cl_set_comp_visible("pml81",FALSE)
       CALL cl_set_comp_att_text("pml83",' ')
       CALL cl_set_comp_att_text("pml84",' ')
       CALL cl_set_comp_att_text("pml80",' ')
       CALL cl_set_comp_att_text("pml81",' ')
    END IF
    IF g_sma.sma122 ='1' THEN
       CALL cl_getmsg('asm-302',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml83",g_msg CLIPPED)
       CALL cl_getmsg('asm-353',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml84",g_msg CLIPPED)
       CALL cl_getmsg('asm-303',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml80",g_msg CLIPPED)
       CALL cl_getmsg('asm-354',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml81",g_msg CLIPPED)
    END IF
    IF g_sma.sma122 ='2' THEN
       CALL cl_getmsg('asm-304',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml83",g_msg CLIPPED)
       CALL cl_getmsg('asm-355',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml84",g_msg CLIPPED)
       CALL cl_getmsg('asm-359',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml80",g_msg CLIPPED)
       CALL cl_getmsg('asm-361',g_lang) RETURNING g_msg
       CALL cl_set_comp_att_text("pml81",g_msg CLIPPED)
    END IF

 DISPLAY BY NAME g_pml2.pml07,g_pml2.pml83,g_pml2.pml84,
                 g_pml2.pml80,g_pml2.pml81,g_pml2.pml08,g_pml2.pml09

 INPUT BY NAME g_pml2.pml07,g_pml2.pml83,g_pml2.pml84,
               g_pml2.pml80,g_pml2.pml81,g_pml2.pml08,g_pml2.pml09
        WITHOUT DEFAULTS

        BEFORE INPUT
            CALL t420_sel_ima()
            CALL t420_set_entry_b('u')
            CALL t420_set_no_entry_b('u')
            CALL t420_set_no_required()
            CALL t420_set_required()

        AFTER FIELD pml83  #第二單位
            IF NOT cl_null(g_pml2.pml83) THEN
                IF (g_pml_o.pml83 IS NULL ) OR
                   (g_pml2.pml83 != g_pml_o.pml83) THEN
                    CALL t420_unit(g_pml2.pml83)
                    IF NOT cl_null(g_errno) THEN
                        CALL cl_err(g_pml2.pml83,g_errno,0)
                        LET g_pml2.pml83 = g_pml_o.pml83
                        DISPLAY BY NAME g_pml2.pml83
                        NEXT FIELD pml83
                    END IF
                    CALL s_du_umfchk(g_pml[l_ac].pml04,'','','',
                                     g_ima44,g_pml2.pml83,l_ima906)
                         RETURNING g_errno,g_factor
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_pml2.pml83,g_errno,0)
                       NEXT FIELD pml83
                    END IF
                    LET g_pml2.pml84 = g_factor
                    DISPLAY BY NAME g_pml2.pml84
                END IF
                LET g_pml_o.pml83  = g_pml2.pml83
             END IF

        AFTER FIELD pml80  #第一單位
            IF NOT cl_null(g_pml2.pml80) THEN
                IF (g_pml_o.pml80 IS NULL ) OR
                   (g_pml2.pml80 != g_pml_o.pml80) THEN
                    CALL t420_unit(g_pml2.pml80)
                    IF NOT cl_null(g_errno) THEN
                        CALL cl_err(g_pml2.pml80,g_errno,0)
                        LET g_pml2.pml80 = g_pml_o.pml80
                        DISPLAY BY NAME g_pml2.pml80
                        NEXT FIELD pml80
                    END IF
                    CALL s_du_umfchk(g_pml[l_ac].pml04,'','','',
                                     g_ima44,g_pml2.pml80,'1')
                         RETURNING g_errno,g_factor
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_pml2.pml80,g_errno,0)
                       NEXT FIELD pml80
                    END IF
                    LET g_pml2.pml81 = g_factor
                    DISPLAY BY NAME g_pml2.pml81
                END IF
                LET g_pml_o.pml80  = g_pml2.pml80
             END IF

        BEFORE FIELD pml09
             IF g_sma.sma115 = 'Y' THEN
                IF cl_null(g_pml2.pml80) AND cl_null(g_pml2.pml83) THEN
                   NEXT FIELD pml80
                END IF
                CALL t420_set_pml07() RETURNING l_flag
                IF l_flag THEN
                  CALL cl_err(g_pml2.pml07,'mfg1206',0)
                  LET g_pml2.pml07 = g_pml_o.pml07
                  LET g_pml2.pml83 = g_pml_o.pml83
                  LET g_pml2.pml80 = g_pml_o.pml80
                  LET g_pml2.pml84 = g_pml_o.pml84
                  LET g_pml2.pml81 = g_pml_o.pml81
                  DISPLAY BY NAME g_pml2.pml07
                  DISPLAY BY NAME g_pml2.pml83
                  DISPLAY BY NAME g_pml2.pml80
                  DISPLAY BY NAME g_pml2.pml84
                  DISPLAY BY NAME g_pml2.pml81
                  LET g_pml2.pml09 = g_pml_o.pml09
                  DISPLAY BY NAME g_pml2.pml09
                  IF l_ima906 MATCHES '[23]' THEN
                    NEXT FIELD pml83
                  ELSE
                    NEXT FIELD pml80
                  END IF
                ELSE
                   LET g_pml_o.pml07  = g_pml2.pml07
                END IF
             END IF

        AFTER FIELD pml07  #採購單位,須存在
            IF NOT cl_null(g_pml2.pml07) THEN
                IF (g_pml_o.pml07 IS NULL ) OR
                   (g_pml2.pml07 != g_pml_o.pml07) THEN
                    CALL t420_unit(g_pml2.pml07)
                    IF NOT cl_null(g_errno) THEN
                        CALL cl_err(g_pml2.pml07,g_errno,0)
                        LET g_pml2.pml07 = g_pml_o.pml07
                        DISPLAY BY NAME g_pml2.pml07
                        NEXT FIELD pml07
                    END IF
                END IF
                IF (g_pml2.pml07 != g_pml_o.pml07 AND
                       g_pml2.pml08 IS NOT NULL ) THEN
                   CALL s_umfchk(g_pml[l_ac].pml04,g_pml2.pml07,g_pml2.pml08)
                   RETURNING l_flag,g_pml2.pml09
                   IF l_flag THEN
                     CALL cl_err(g_pml2.pml07,'mfg1206',0)
                     LET g_pml2.pml07 = g_pml_o.pml07
                     DISPLAY BY NAME g_pml2.pml07
                     LET g_pml2.pml09 = g_pml_o.pml09
                     DISPLAY BY NAME g_pml2.pml09
                     NEXT FIELD pml07
                  END IF
                  DISPLAY BY NAME g_pml2.pml09
                END IF
                LET g_pml_o.pml07  = g_pml2.pml07
            END IF

       AFTER FIELD pml09         #轉換率
            IF NOT cl_null(g_pml2.pml09) THEN
                IF g_pml2.pml09 <= 0 THEN
                    CALL cl_err(g_pml2.pml09,'mfg0013',0)
                    LET g_pml2.pml09 = g_pml_o.pml09
                    DISPLAY g_pml2.pml09 TO pml09
                    NEXT FIELD pml09
                END IF
                LET g_pml_o.pml09  = g_pml2.pml09
            END IF

        ON ACTION CONTROLP
            CASE
               WHEN INFIELD(pml07) #採購單位
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gfe"
                  LET g_qryparam.default1 = g_pml2.pml07
                  CALL cl_create_qry() RETURNING g_pml2.pml07

                  DISPLAY BY NAME g_pml2.pml07
                  NEXT FIELD pml07
               WHEN INFIELD(pml83) #第二單位
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gfe"
                  LET g_qryparam.default1 = g_pml2.pml83
                  CALL cl_create_qry() RETURNING g_pml2.pml83
                  DISPLAY BY NAME g_pml2.pml83
                  NEXT FIELD pml83
               WHEN INFIELD(pml80) #第一單位
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gfe"
                  LET g_qryparam.default1 = g_pml2.pml80
                  CALL cl_create_qry() RETURNING g_pml2.pml80
                  DISPLAY BY NAME g_pml2.pml80
                  NEXT FIELD pml80
               OTHERWISE EXIT CASE
            END CASE

       ON ACTION maintain_unit_conversion
                   LET g_cmd = 'aooi102 '
                   CALL cl_cmdrun(g_cmd)

       ON ACTION maintain_item_unit_conversion
                   LET g_cmd = 'aooi103 '
                   CALL cl_cmdrun(g_cmd)

       ON ACTION CONTROLR
           CALL cl_show_req_fields()

       ON ACTION CONTROLG
           CALL cl_cmdask()

       AFTER INPUT
        IF INT_FLAG THEN                         # 若按了DEL鍵
           LET INT_FLAG = 0
           EXIT INPUT
        END IF
        LET l_flag = 'N'
        IF cl_null(g_pml2.pml07) THEN
           LET l_flag = 'Y'
           DISPLAY BY NAME g_pml2.pml07
        END IF
        IF g_sma.sma115 = 'Y' THEN
           IF cl_null(g_pml2.pml83) AND cl_null(g_pml2.pml80) THEN
              LET l_flag = 'Y'
              DISPLAY BY NAME g_pml2.pml80
              DISPLAY BY NAME g_pml2.pml83
           END IF
        END IF
        IF cl_null(g_pml2.pml09) OR g_pml2.pml09 <= 0 THEN
           LET l_flag = 'Y'
           DISPLAY BY NAME g_pml2.pml09
        END IF
        IF l_flag = 'Y' THEN
           CALL cl_err('','9033',0)
           IF g_sma.sma115 = 'Y' THEN
              IF l_ima906 MATCHES '[23]' THEN
                 NEXT FIELD pml83
              ELSE
                 NEXT FIELD pml80
              END IF
           ELSE
              NEXT FIELD pml07
           END IF
        END IF
        LET g_pml[l_ac].pml07=g_pml2.pml07
        LET g_pml[l_ac].pml83=g_pml2.pml83
        LET g_pml[l_ac].pml80=g_pml2.pml80
    ON IDLE g_idle_seconds
       CALL cl_on_idle()
       CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121


 END INPUT
 CLOSE WINDOW t442_w
 DISPLAY BY NAME g_pml[l_ac].pml07
 DISPLAY BY NAME g_pml[l_ac].pml80
 DISPLAY BY NAME g_pml[l_ac].pml83
END FUNCTION

FUNCTION  t443()
   DEFINE
      l_ima53   LIKE ima_file.ima53,
      l_ima531  LIKE ima_file.ima531,
      l_flag    LIKE type_file.chr1    #No.FUN-680136 VARCHAR(01)

    OPEN WINDOW t443_w WITH FORM "apm/42f/apmt443"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("apmt443")

   SELECT ima49,ima491,ima53,ima531
     INTO g_ima49,g_ima491,l_ima53,l_ima531
     FROM ima_file WHERE ima01 =  g_pml[l_ac].pml04
   IF cl_null(l_ima53) THEN LET l_ima53 = 0 END IF
   IF cl_null(l_ima531) THEN LET l_ima531 = 0 END IF
   DISPLAY l_ima53 TO FORMONYL.ima53
   DISPLAY l_ima531 TO FORMONYL.ima531
   DISPLAY BY NAME g_pml2.pml44,g_pml2.pml30,g_pml2.pml32

   INPUT BY NAME g_pml2.pml23 WITHOUT DEFAULTS
      AFTER FIELD pml23
         IF NOT cl_null(g_pml2.pml23) THEN
             IF g_pml2.pml23 NOT MATCHES'[YN]' THEN
                 NEXT FIELD pml23
             END IF
         END IF

      AFTER INPUT
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            EXIT INPUT
         END IF
         LET l_flag = 'N'
         IF cl_null(g_pml2.pml23) THEN
            LET l_flag = 'Y'
            DISPLAY BY NAME g_pml2.pml23
         END IF
         IF l_flag = 'Y' THEN CALL cl_err('','9033',0) NEXT FIELD pml23 END IF
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


   END INPUT
   CLOSE WINDOW t443_w
END FUNCTION

FUNCTION  t444()
  DEFINE  l_ima53   LIKE ima_file.ima53,
          l_ima531  LIKE ima_file.ima531,
          l_qty     LIKE pml_file.pml20,
          l_flag1   LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
          g_flag,l_flag   LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(01)
          g_date    LIKE type_file.dat     #No.FUN-680136 DATE

  CALL t420_pml04('a',g_no)   #MOD-570246

  OPEN WINDOW t444_w WITH FORM "apm/42f/apmt444"
     ATTRIBUTE (STYLE = g_win_style CLIPPED)

  CALL cl_ui_locale("apmt444")

  INPUT BY NAME g_pml2.pml14,g_pml2.pml15,
               g_pml2.pml18,g_pml2.pml35,g_pml2.pml34,g_pml2.pml33,   #No.TQC-640132
               g_pml2.pml05
        WITHOUT DEFAULTS

        AFTER FIELD pml33    #交貨日期
            IF cl_null(g_pml2.pml33)
            THEN  IF NOT cl_null(g_pml2.pml34) THEN #依到廠日推出交貨日
                      LET g_pml2.pml33 = g_pml2.pml34 - g_ima49
                      DISPLAY BY NAME g_pml2.pml33
                  ELSE IF NOT cl_null(g_pml2.pml35) THEN
                          LET g_pml2.pml34 = g_pml2.pml35 - g_ima491
                          LET g_pml2.pml33 = g_pml2.pml34 - g_ima49
                          DISPLAY BY NAME g_pml2.pml33
                          DISPLAY BY NAME g_pml2.pml34
                       END IF
                  END IF
            END IF
            CALL s_wkday(g_pml2.pml33) RETURNING g_flag,g_date
            IF cl_null(g_date) THEN
                 NEXT FIELD pml33
            ELSE LET g_pml2.pml33 = g_date
                 DISPLAY BY NAME g_pml2.pml33
            END IF
            IF g_pml_o.pml33 IS NULL OR g_pml_o.pml33 != g_pml2.pml33 THEN
               IF cl_null(g_pml2.pml34) THEN   #FUN-570106
                  LET g_pml2.pml34 = g_pml2.pml33 + g_ima49
               END IF                          #FUN-570106
               IF cl_null(g_pml2.pml35) THEN   #FUN-570106
                  LET g_pml2.pml35 = g_pml2.pml34 + g_ima491
               END IF                          #FUN-570106
               DISPLAY BY NAME g_pml2.pml34
               DISPLAY BY NAME g_pml2.pml35
            END IF
            LET g_pml_o.pml33 = g_pml2.pml33

        AFTER FIELD pml34     #到廠日期
            IF NOT cl_null(g_pml2.pml34) THEN
               CALL s_wkday(g_pml2.pml34) RETURNING g_flag,g_date
               IF cl_null(g_date) THEN
                    NEXT FIELD pml34
               ELSE LET g_pml2.pml34 = g_date
                    DISPLAY BY NAME g_pml2.pml34
               END IF
               IF g_pml2.pml34 < g_pml2.pml33 THEN #到庫日不可小於到廠日
                  LET g_pml2.pml34 = g_pml_o.pml34
                  DISPLAY BY NAME g_pml2.pml34
                  CALL cl_err(g_pml2.pml34,'mfg3225',0)
                  NEXT FIELD pml34
               END IF
            ELSE  LET g_pml2.pml34 = g_pml2.pml33 + g_ima49
                  DISPLAY BY NAME g_pml2.pml34
            END IF
            IF g_pml_o.pml34 != g_pml2.pml34 THEN
               LET g_pml2.pml35 = g_pml2.pml34 + g_ima491
               DISPLAY BY NAME g_pml2.pml35
            END IF
            LET g_pml_o.pml34 = g_pml2.pml34

        AFTER FIELD pml35    #入庫日期
          IF NOT cl_null(g_pml2.pml35) THEN
               CALL s_wkday(g_pml2.pml35) RETURNING g_flag,g_date
               IF cl_null(g_date) THEN
                    NEXT FIELD pml35
               ELSE LET g_pml2.pml35 = g_date
                    DISPLAY BY NAME g_pml2.pml35
               END IF
               IF g_pml2.pml35 < g_pml2.pml34 OR
                  g_pml2.pml35 < g_pml2.pml33
               THEN CALL cl_err(g_pml2.pml35,'mfg3195',0)
                    LET g_pml2.pml35 = g_pml_o.pml35
                    DISPLAY BY NAME g_pml2.pml35
                    NEXT FIELD pml35
               END IF
           ELSE
                 LET g_pml2.pml35 = g_pml2.pml34 + g_ima491
                 DISPLAY BY NAME g_pml2.pml35
           END IF
           LET g_pml_o.pml35 = g_pml2.pml35

       AFTER INPUT
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            EXIT INPUT
        END IF
        LET l_flag = 'N'
        IF cl_null(g_pml2.pml33) THEN
           LET l_flag = 'Y'
           DISPLAY BY NAME g_pml2.pml33
        END IF
        IF cl_null(g_pml2.pml34) THEN
           LET l_flag = 'Y'
           DISPLAY BY NAME g_pml2.pml34
        END IF
        IF cl_null(g_pml2.pml35) THEN
           LET l_flag = 'Y'
           DISPLAY BY NAME g_pml2.pml35
        END IF
        IF l_flag = 'Y' THEN CALL cl_err('','9033',0) NEXT FIELD pml33 END IF
    ON IDLE g_idle_seconds
       CALL cl_on_idle()
       CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121


 END INPUT
 CLOSE WINDOW t444_w
 LET g_pml[l_ac].pml33=g_pml2.pml33
 DISPLAY BY NAME g_pml[l_ac].pml33   #MOD-7B0034
 LET g_pml[l_ac].pml34=g_pml2.pml34
 LET g_pml[l_ac].pml35=g_pml2.pml35
 DISPLAY BY NAME g_pml[l_ac].pml34
 DISPLAY BY NAME g_pml[l_ac].pml35

END FUNCTION

FUNCTION t420_z() # when g_pmk.pmk18='Y' (Turn to 'N')
   DEFINE l_pml21    LIKE pml_file.pml21
   DEFINE l_n,l_n2   LIKE type_file.num5    #No.FUN-680136 SMALLINT
   DEFINE l_pmkcont  LIKE pmk_file.pmkcont  #CHI-C80072 Add

   IF g_pmk.pmk01 IS NULL THEN RETURN END IF
   IF g_pmk.pmk25 = 'S' THEN
      CALL cl_err(g_pmk.pmk25,'apm-030',1)
      RETURN
   END IF
   #MOD-B30262 add ---begin---
   SELECT COUNT(*) INTO l_n FROM pne_file WHERE pne01=g_pmk.pmk01
   IF l_n > 0 THEN
      CALL cl_err('','axm-676',1)
      RETURN
   END IF
   #MOD-B30262 add ----end----
   SELECT * INTO g_pmk.* FROM pmk_file WHERE pmk01=g_pmk.pmk01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","sel pmk_file",1)  #No.FUN-660129
      RETURN
   END IF
#No.FUN-A50071 -----start-------
   IF g_pmk.pmk46 = '7' THEN
      CALL cl_err('','axm-740',0)
      RETURN
   END IF
#No.FUN-A50071 -----end-----

   SELECT SUM(pml21) INTO l_pml21 FROM pml_file WHERE pml01 = g_pmk.pmk01
   IF l_pml21 > 0  THEN CALL cl_err('sel_pml','apm-294',0)  RETURN END IF
   IF g_pmk.pmk18='N'             THEN CALL cl_err('','9025',1) RETURN END IF #MOD-870161
   IF g_pmk.pmk18='X'             THEN CALL cl_err('','9024',1) RETURN END IF
  #IF g_pmk.pmk25 MATCHES '[269]' THEN RETURN END IF #轉成採購單.結束.取消
   IF g_pmk.pmk25 MATCHES '[269]' THEN CALL cl_err('','apm1061',1) RETURN END IF #轉成採購單.結束.取消  #MOD-B90094
   #CHECK 請購單是否已產生採購單，如已產生，則不可再取消確認
    SELECT COUNT(*) INTO l_n FROM pmn_file ,pmm_file
     WHERE pmn01 = pmm01
       AND pmn24 = g_pmk.pmk01
       AND pmm18 != 'X'  #作廢
    IF l_n > 0 THEN
       CALL cl_err('','apm-581',0)
       RETURN
    END IF
   LET l_n = 0
   SELECT COUNT(*) INTO l_n FROM pml_file
    WHERE pml01 = g_pmk.pmk01
      AND pml92 = 'Y'
   IF l_n > 0 THEN
       CALL cl_err('','apm-141',0)
       RETURN
   END IF
   IF g_azw.azw04 = '2' THEN
      LET l_n=0
      SELECT COUNT(*) INTO l_n FROM ruc_file
       WHERE ruc00='1' AND ruc01=g_pmk.pmkplant AND ruc02=g_pmk.pmk01
         AND (ruc19<>'0' OR ruc20<>'0' OR ruc21<>'0')
      IF l_n<>0 THEN
         CALL cl_err('','art-243',1)
         RETURN
      END IF
      LET l_n=0
      SELECT COUNT(*) INTO l_n FROM pml_file
       WHERE pml01=g_pmk.pmk01
         AND pml56='2'
      IF l_n != 0 THEN
         CALL cl_err('','art-513',1)
         RETURN
      END IF
   END IF
   IF NOT cl_confirm('axm-109') THEN RETURN END IF
   SELECT COUNT(*) INTO l_n FROM pnn_file
    WHERE pnn01=g_pmk.pmk01
   IF l_n > 0 THEN CALL cl_err(g_pmk.pmk01,'apm-510',0) RETURN END IF


   BEGIN WORK
   LET g_success = 'Y'

   OPEN t420_cl USING g_pmk.pmk01
   IF STATUS THEN
      CALL cl_err("OPEN t420_cl:", STATUS, 1)
      CLOSE t420_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
      CLOSE t420_cl
      ROLLBACK WORK
      RETURN
   END IF

   CALL t420_z1()

   LET l_pmkcont = TIME  #CHI-C80072 Add
   IF g_success = 'Y' THEN
      LET g_pmk.pmk18='N' COMMIT WORK
      DISPLAY BY NAME g_pmk.pmk03
      DISPLAY BY NAME g_pmk.pmk18
      DISPLAY BY NAME g_pmk.pmk25
      CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg) RETURNING g_sta
      DISPLAY g_sta TO FORMONLY.desc2

     #LET g_pmk.pmk15=''  #TQC-BB0169  #MOD-C80239 mark
     #CHI-C80072 Mark&Add Str
     #LET g_pmk.pmkconu=''
     #LET g_pmk.pmkcond=''
     #LET g_pmk.pmkcont=''
      LET g_pmk.pmk15 = g_user   #TQC-D40036
      LET g_pmk.pmkconu=g_user
      LET g_pmk.pmkcond=g_today
      LET g_pmk.pmkcont=l_pmkcont
     #CHI-C80072 Mark&Add End
      DISPLAY BY NAME g_pmk.pmk15,g_pmk.pmkconu,g_pmk.pmkcond,g_pmk.pmkcont   #TQC-D40036 add g_pmk.pmk15
      CALL t420_peo('a','2',g_pmk.pmk15)     #TQC-D40036 add
   ELSE
      LET g_pmk.pmk18 = 'Y'
      ROLLBACK WORK
   END IF

   SELECT * INTO g_pmk.* FROM pmk_file WHERE pmk01 = g_pmk.pmk01

   CALL t420_pic() #FUN-730012
END FUNCTION

#FUNCTION t420_x() # when g_pmk.pmk18='N' (Turn to 'X') #FUN-D20025 mark
FUNCTION t420_x(p_type) #FUN-D20025 add
   DEFINE l_pml     RECORD
                       pml12    LIKE pml_file.pml12,
                       pml121   LIKE pml_file.pml121,
                       pml122   LIKE pml_file.pml122
                    END RECORD
   DEFINE l_pml21   LIKE pml_file.pml21
   DEFINE l_pml16   LIKE pml_file.pml16
   DEFINE l_n       LIKE type_file.num5    #No.FUN-680136 SMALLINT
   DEFINE l_pml02   LIKE pml_file.pml02    #CHI-840016
   DEFINE p_type    LIKE type_file.chr1  #FUN-D20025 add
   IF cl_null(g_pmk.pmk01) THEN RETURN END IF

   SELECT * INTO g_pmk.* FROM pmk_file WHERE pmk01=g_pmk.pmk01

   SELECT SUM(pml21) INTO l_pml21 FROM pml_file WHERE pml01 = g_pmk.pmk01

   IF l_pml21 > 0  THEN CALL cl_err('sel_pml','apm-294',0)  RETURN END IF

   IF g_pmk.pmk18 ='Y' THEN CALL cl_err('','9023',0) RETURN  END IF

   IF g_pmk.pmk25 NOT MATCHES '[0RW9]' THEN RETURN END IF #非開立&作廢    #FUN-550038
   #FUN-D20025---begin
    IF p_type = 1 THEN
       IF g_pmk.pmk18='X' THEN RETURN END IF
    ELSE
       IF g_pmk.pmk18<>'X' THEN RETURN END IF
    END IF
    #FUN-D20025---end
   SELECT COUNT(*) INTO l_n FROM pnn_file
    WHERE pnn01=g_pmk.pmk01

   IF l_n > 0 THEN CALL cl_err(g_pmk.pmk01,'apm-510',0) RETURN END IF

   BEGIN WORK
   LET g_success = 'Y'

   OPEN t420_cl USING g_pmk.pmk01
   IF STATUS THEN
      CALL cl_err("OPEN t420_cl:", STATUS, 1)
      CLOSE t420_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t420_cl INTO g_pmk.*               # 對DB鎖定
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
      CLOSE t420_cl
      ROLLBACK WORK
      RETURN
   END IF

   IF cl_void(0,0,g_pmk.pmk18) THEN
      IF g_pmk.pmk18 ='N' THEN
         LET g_pmk.pmk18='X'
         LET g_pmk.pmk25='9'
         LET l_pml16 = '9'
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
          DECLARE t420_x2_c CURSOR FOR
             SELECT pml02 FROM pml_file
              WHERE pml01=g_pmk.pmk01
          FOREACH t420_x2_c INTO l_pml02
             CALL t420_upd_oeb28('x',l_pml02)
          END FOREACH
#FUN-B90101 add &endif
      ELSE
         LET g_pmk.pmk18='N'
         LET g_pmk.pmk25='0'
         LET l_pml16 = '0'
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
          DECLARE t420_x3_c CURSOR FOR
             SELECT pml02 FROM pml_file
              WHERE pml01=g_pmk.pmk01
          FOREACH t420_x3_c INTO l_pml02
             CALL t420_upd_oeb28('z',l_pml02)
          END FOREACH
#FUN-B90101 add &endif
      END IF
      UPDATE pmk_file SET
             pmk18=g_pmk.pmk18,
             pmk25=g_pmk.pmk25,
             pmkmodu=g_user,
             pmkdate=g_today
          WHERE pmk01 = g_pmk.pmk01
      IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",STATUS,"","x_upd pmk18",1)  #No.FUN-660129
         LET g_success = 'N'
      END IF
      UPDATE pml_file SET
             pml16 = l_pml16
          WHERE pml01 = g_pmk.pmk01
      IF STATUS THEN  #No:8753
         CALL cl_err3("upd","pml_file",g_pmk.pmk01,"",STATUS,"","x_upd pml16",1)  #No.FUN-660129
         LET g_success = 'N'
      END IF
   END IF
   DECLARE t420_x1_c CURSOR FOR
      SELECT pml12,pml121,pml122 FROM pml_file
       WHERE pml01=g_pmk.pmk01
         AND ( pml12 IS NOT NULL OR pml12 !=' ')
         AND pml121 IS NOT NULL
          AND pml121 != ' '                  #FUN-810045
         AND pml122 IS NOT NULL
          AND pml122 != ' '                  #FUN-810045
   CALL s_showmsg_init()        #No.FUN-710030
   FOREACH t420_x1_c INTO l_pml.*
      IF g_success="N" THEN
         LET g_totsuccess="N"
         LET g_success="Y"
      END IF
   END FOREACH
   IF g_totsuccess="N" THEN
      LET g_success="N"
   END IF

   CLOSE t420_cl
   CALL s_showmsg()       #No.FUN-710030
   IF g_success='Y' THEN
      COMMIT WORK
      CALL cl_flow_notify(g_pmk.pmk01,'V')
   ELSE
      ROLLBACK WORK
   END IF
   SELECT pmk18,pmk25,pmkmksg
     INTO g_pmk.pmk18,g_pmk.pmk25,g_pmk.pmkmksg FROM pmk_file
    WHERE pmk01=g_pmk.pmk01
   DISPLAY BY NAME g_pmk.pmk18,g_pmk.pmk25

   CALL s_pmksta('pmk',g_pmk.pmk25,g_pmk.pmk18,g_pmk.pmkmksg) RETURNING g_sta
   DISPLAY g_sta TO FORMONLY.desc2

   CALL t420_pic() #FUN-730012
END FUNCTION

FUNCTION t420_z1()
   DEFINE l_pml         RECORD LIKE pml_file.*
   DEFINE l_pml20       LIKE pml_file.pml20
   DEFINE l_pmkcont     LIKE pmk_file.pmkcont   #CHI-C80072 Add

 # LET g_pmk.pmk25=0                 #TQC-AB0038 mark
   LET g_pmk.pmk25 = '0'             #TQC-AB0038 add
  #LET g_pmk.pmk03=g_pmk.pmk03+1     #MOD-C10159 mark
   LET l_pmkcont = TIME              #CHI-C80072 Add
   UPDATE pmk_file SET
          pmk03=g_pmk.pmk03,
          pmk18='N',
         #pmk15='',          #TQC-BB0169  #MOD-C80239 mark
          pmk25=g_pmk.pmk25,
         #CHI-C80072 Mark&Add Str
         #pmkconu='',        #No.FUN-870007
         #pmkcond='',        #No.FUN-870007
         #pmkcont='',        #No.FUN-870007
          pmk15 = g_user,    #TQC-D40036
          pmkconu=g_user,
          pmkcond=g_today,
          pmkcont=l_pmkcont,
         #CHI-C80072 Mark&Add End
          pmksseq=0
    WHERE pmk01 = g_pmk.pmk01
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
      IF g_bgerr THEN
         CALL s_errmsg("pmk01",g_pmk.pmk01,"upd pmk18",STATUS,1)
      ELSE
         CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",STATUS,"","upd pmk18",1)
      END IF
      LET g_success = 'N' RETURN
   ELSE
       #單身的 pml16相對更新成0
       UPDATE pml_file SET
         # pml16=0                   #TQC-AB0038 mark
           pml16 = '0'               #TQC-AB0038 add
        WHERE pml01 = g_pmk.pmk01
          AND pml16 != '9'           #MOD-B90092
#FUN-B90101--add--begin--
#FUN-B90101--add--end
       IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#FUN-B90101 add &endif
         IF g_bgerr THEN
            CALL s_errmsg("pml01",g_pmk.pmk01,"upd pml16",STATUS,1)
         ELSE
            CALL cl_err3("upd","pml_file",g_pmk.pmk01,"",STATUS,"","upd pml16",1)
         END IF
           LET g_success = 'N'
           RETURN
       END IF
      #取消簽核的處理
      IF g_pmk.pmkmksg MATCHES '[Yy]'  THEN
         LET g_pmk.pmksseq = 0
         DELETE FROM azd_file WHERE azd01 = g_pmk.pmk01 AND azd02 = 2
         IF STATUS  THEN  LET g_success = 'N' RETURN
         ELSE
            CALL s_signm(6,34,g_lang,'2',g_pmk.pmk01,2,g_pmk.pmksign,
                 g_pmk.pmkdays,g_pmk.pmkprit,g_pmk.pmksmax,g_pmk.pmksseq)
         END IF
      END IF
      IF g_azw.azw04='2' THEN
         DELETE FROM ruc_file WHERE ruc00='1' AND ruc01=g_pmk.pmkplant
                    AND ruc02=g_pmk.pmk01  #No.FUN-9C0069
         IF STATUS THEN
            CALL cl_err3("del","ruc_file",g_pmk.pmk01,"",SQLCA.sqlcode,
                               "","",1)
            LET g_success="N"
            RETURN
         END IF
       END IF
   END IF
END FUNCTION
#FUN-CC0057--------mark---------str
#FUNCTION t420_transfer()
#DEFINE l_ruc RECORD LIKE ruc_file.*
#DEFINE l_flag LIKE type_file.chr1
#DEFINE l_rate LIKE ruc_file.ruc17
#
#   LET g_sql="SELECT '','',pml01,pml02,pml04,'','','',pml24,pml25,pml48,pml49,pml50,'',",
#             " pml47,pml041,pml07,'',pml20,'','','','',",
#             " pml51,pml52,pml53,'',pml33,pml54,'',pml191,pml55 ",        #No.FUN-9C0069
#             " FROM pml_file WHERE pml01='",g_pmk.pmk01,"' ORDER BY pml02 "
#   PREPARE t420_prepsel FROM g_sql
#   DECLARE t420_curssel CURSOR FOR t420_prepsel
#   FOREACH t420_curssel INTO l_ruc.*
#      IF SQLCA.sqlcode THEN
#        CALL cl_err('foreach:',SQLCA.sqlcode,1)
#        EXIT FOREACH
#      END IF
#      SELECT ima25 INTO l_ruc.ruc13 FROM ima_file WHERE ima01=l_ruc.ruc04
#      IF SQLCA.sqlcode=100 THEN LET l_ruc.ruc13=NULL END IF
#      CALL s_umfchk(l_ruc.ruc04,l_ruc.ruc16,l_ruc.ruc13)
#         RETURNING l_flag,l_rate
#      IF l_flag='0' THEN
#         LET l_ruc.ruc17=l_rate
#      END IF
#      LET l_ruc.ruc00='1'
#      LET l_ruc.ruc01=g_pmk.pmkplant
#      LET l_ruc.ruc05=g_today
#      LET l_ruc.ruc06=g_pmk.pmk47
#      LET l_ruc.ruc32=g_pmk.pmk50    #FUN-CC0057 add
#      IF cl_null(l_ruc.ruc06) THEN
#         LET l_ruc.ruc06 = g_pmk.pmkplant
#         LET l_ruc.ruc29 = 'Y'
#      ELSE
#         LET l_ruc.ruc29 = 'N'
#      END IF
#      SELECT rty04 INTO l_ruc.ruc26 FROM rty_file
#       WHERE rty01=l_ruc.ruc06 AND rty02=l_ruc.ruc04
#      LET l_ruc.ruc07=g_pmk.pmk46
#      IF g_pmk.pmk46='1' THEN
#         LET l_ruc.ruc08=g_pmk.pmk01
#         LET l_ruc.ruc09=l_ruc.ruc03
#      END IF
#      LET l_ruc.ruc19='0'
#      LET l_ruc.ruc20='0'
#      LET l_ruc.ruc21='0'
#      LET l_ruc.ruc22=NULL
#      LET l_ruc.ruc33=' '
#      IF l_ruc.ruc12='2' OR l_ruc.ruc12='3' OR l_ruc.ruc12 ='4' THEN  #No.FUN-A10037
#         INSERT INTO ruc_file VALUES(l_ruc.*)
#         IF STATUS THEN
#            CALL cl_err3("ins","ruc_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","",1)
#            EXIT FOREACH
#         END IF
#      END IF
#      IF NOT cl_null(l_ruc.ruc23) AND l_ruc.ruc23<>g_plant THEN
#         UPDATE pml_file SET pml11="Y" WHERE pml01=l_ruc.ruc02 AND pml02=l_ruc.ruc03
#                                         AND pml930=g_plant
#         IF STATUS THEN
#            CALL cl_err3("upd","pml_file",g_pmk.pmk01,"",SQLCA.sqlcode,
#                               "","",1)
#            EXIT FOREACH
#         END IF
#      END IF
#      INITIALIZE l_ruc.* TO NULL
#   END FOREACH
#END FUNCTION
#FUN-CC0057--------mark---------end

FUNCTION t420_g()
   DEFINE l_cmd         LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(200)
          l_prog        LIKE zz_file.zz01,      #No.FUN-680136 VARCHAR(10)
          l_wc,l_wc2    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(50)
          l_prtway      LIKE type_file.chr1     #No.FUN-680136 VARCHAR(1)
   DEFINE l_sw          LIKE type_file.chr1,    #No.FUN-680136 VARCHAR(1)
          l_n           LIKE type_file.num5,    #No.FUN-680136 SMALLINT
          l_buf         LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(6)
          l_name        LIKE type_file.chr20    #No.FUN-680136 VARCHAR(20)
   DEFINE l_easycmd     LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(4096)
          l_updsql_0    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(500)
          l_updsql_1    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(500)
          l_updsql_2    LIKE type_file.chr1000, #No.FUN-680136 VARCHAR(500)
          l_upload      LIKE type_file.chr1000  #No.FUN-680136 VARCHAR(1000)


   IF g_aza.aza23 matches '[ Nn]'
     THEN
      IF g_bgerr THEN
         CALL s_errmsg("","","aza23","mfg3551",1)
      ELSE
         CALL cl_err3("","","","","mfg3551","","aza23",0)
      END IF
     RETURN
   END IF

   IF g_pmk.pmk01 IS NULL OR g_pmk.pmk01 = ' '
     THEN RETURN
   END IF

   IF g_pmk.pmkmksg IS NULL OR g_pmk.pmkmksg matches '[Nn]'
     THEN
      IF g_bgerr THEN
         CALL s_errmsg("","","","mfg3549",1)
      ELSE
         CALL cl_err3("","","","","mfg3549","","",0)
      END IF
     RETURN
   END IF

   IF g_pmk.pmk18 matches '[Nn]'
     THEN
      IF g_bgerr THEN
         CALL s_errmsg("","","","mfg3550",1)
      ELSE
         CALL cl_err3("","","","","mfg3550","","",0)
      END IF
     RETURN
   END IF
   IF g_pmk.pmk18 matches '[X]'
     THEN
      IF g_bgerr THEN
         CALL s_errmsg("","","",SQLCA.sqlcode,1)
      ELSE
         CALL cl_err3("","","","",SQLCA.sqlcode,"","",0)
      END IF
     RETURN
   END IF

   IF g_pmk.pmk25 matches '[Ss1]'
     THEN
      IF g_bgerr THEN
         CALL s_errmsg("","","","mfg3557",1)
      ELSE
         CALL cl_err3("","","","","mfg3557","","",0)
      END IF
     RETURN
   END IF

#--- 產生本張單據之報表檔
  # LET l_prog='apmr903' #FUN-C30085 mark
   LET l_prog='apmg903'  #FUN-C30085 add
   LET l_wc='pmk01="',g_pmk.pmk01,'"'

   SELECT zz21,zz22 INTO l_wc2,l_prtway FROM zz_file WHERE zz01 = l_prog
   IF SQLCA.sqlcode OR l_wc2 IS NULL THEN LET l_wc2 = " '3' " END IF

#---- 抓報表檔名  l_name
   CALL cl_outnam(l_prog) RETURNING l_name
   LET l_cmd = l_prog CLIPPED,
               " '",g_today CLIPPED,"' ''",
               " '",g_lang CLIPPED,"' 'Y' '0' '1'",
               " '",l_wc CLIPPED,"' '",l_wc2 CLIPPED,"' '' '' ",
               " '",l_name CLIPPED,"'"
    CALL cl_cmdrun(l_cmd)


#---- 更新[目前狀態] 為 'S.送簽中'

   LET l_updsql_0="UPDATE pmk_file SET pmk25='S' WHERE pmk01='",g_pmk.pmk01,"';"
   LET l_updsql_1="UPDATE pmk_file SET pmk25='1' WHERE pmk01='",g_pmk.pmk01,"';",
                  "UPDATE pml_file SET pml16='1' WHERE pml01='",g_pmk.pmk01,"';"
   LET l_updsql_2="UPDATE pmk_file SET pmk25='R' WHERE pmk01='",g_pmk.pmk01,"';"
   LET l_easycmd='ef ',
                 '"','TIPTOP_PR','" ',                  #E-Form單別
                 '"','apmt420','" ',                    #程式代號
                 '"',g_pmk.pmk01 CLIPPED,'" ',          #單號
                 '"',g_dbs CLIPPED,'" ',                #資料庫(連線字串)
                 '"',l_updsql_0 CLIPPED,'" ',           #更新狀況碼-送簽中
                 '"',l_updsql_1 CLIPPED,'" ',           #簽核同意
                 '"',l_updsql_2 CLIPPED,'" ',           #簽核不同意
                 '"','1','" ',                          #附件總數
                 '"',l_name CLIPPED,'" ',               #報表檔徑名
                 '"','2','" ',                          #條件欄位總數
                 '"C',g_pmk.pmksign CLIPPED,'" ',        #條件1: 簽核等級
                 '"N','5000','" '                       #條件2: 總金額
  RUN l_easycmd

  CALL t420_pic() #FUN-730012
END FUNCTION

FUNCTION t420_ef()

     CALL t420sub_y_chk(g_pmk.pmk01)          #CALL 原確認的 check 段
     IF g_success = "N" THEN
         RETURN
     END IF

     CALL aws_condition()#判斷送簽資料
     IF g_success = 'N' THEN
         RETURN
     END IF
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########

   IF aws_efcli2(base.TypeInfo.create(g_pmk),base.TypeInfo.create(g_pml),'','','','')
   THEN
       LET g_success='Y'
       LET g_pmk.pmk25='S'
       DISPLAY BY NAME g_pmk.pmk25
   ELSE
       LET g_success='N'
   END IF
END FUNCTION
#genero

FUNCTION t420_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1     #No.FUN-680136  VARCHAR(1)

   IF (NOT g_before_input_done) OR INFIELD(pmk01) THEN
     #CALL cl_set_comp_entry("pmk01,pmk02,pmk03",TRUE)   #FUN-570078 add pmk03 #No.FUN-830161 #MOD-D10269 mark
      CALL cl_set_comp_entry("pmk01,pmk02",TRUE)         #MOD-D10269
   END IF

   CALL cl_set_comp_entry("pmk15",TRUE)   #MOD-C80239 add
END FUNCTION

FUNCTION t420_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1     #No.FUN-680136  VARCHAR(1)

    IF (NOT g_before_input_done) THEN                    #MOD-560162
       IF p_cmd = 'u' AND g_chkey matches'[Nn]' THEN
           CALL cl_set_comp_entry("pmk01",FALSE)
       END IF
   END IF

  #MOD-D10269 mark---S
  #IF (NOT g_before_input_done) THEN
  #  IF p_cmd='u' THEN
  #     CALL cl_set_comp_entry("pmk03",FALSE)
  #  END IF
  #END IF
  #MOD-D10269 mark---E

   IF NOT cl_null(g_argv3) THEN
       CALL cl_set_comp_entry("pmk02",FALSE)
   END IF

  #MOD-C80239---S---
   IF p_cmd='u' OR p_cmd='a' THEN
      CALL cl_set_comp_entry("pmk15",FALSE)
   END IF
  #MOD-C80239---E---

END FUNCTION

FUNCTION t420_set_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1     #No.FUN-680136 VARCHAR(1)

   IF g_pmk.pmk45='Y' AND (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("pml38",TRUE)
   END IF

   IF INFIELD(pml04) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("pml041",TRUE)
   END IF

   IF INFIELD(pml12) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("pml07",TRUE)
   END IF

   CALL cl_set_comp_entry("pml83,pml85,pml86,pml87",TRUE)

   CALL cl_set_comp_entry("pml12,pml121,pml122",TRUE)
   IF cl_null(g_pmk.pmk09) THEN
      CALL cl_set_comp_entry("pml48",TRUE)
   END IF

END FUNCTION

FUNCTION t420_set_no_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1     #No.FUN-680136 VARCHAR(1)

   IF g_pmk.pmk45='N' AND (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("pml38",FALSE)
   END IF

   IF INFIELD(pml04) OR (NOT g_before_input_done) THEN
      IF g_no[1,4] != 'MISC' THEN
          CALL cl_set_comp_entry("pml041",FALSE)
      END IF
   END IF

   IF INFIELD(pml12) OR (NOT g_before_input_done) THEN
      IF NOT cl_null(g_pml[l_ac].pml12) THEN
          CALL cl_set_comp_entry("pml07",FALSE)
      END IF
   END IF

#FUN-A60035 ---MARK BEGIN
##No.FUN-A50054 --begin--by dxfwo
# IF g_sma.sma124 = 'slk' THEN
#    CALL cl_set_comp_entry("pml20",FALSE)
# END IF
##No.FUN-A50054 --end--
#FUN-A60035 ---MARK END

   IF g_ima906 = '1' THEN
      CALL cl_set_comp_entry("pml83,pml84,pml85",FALSE)
   END IF
   IF g_ima906 = '2' THEN
      CALL cl_set_comp_entry("pml81,pml84",FALSE)
   END IF
   IF g_ima906 = '3' THEN
      CALL cl_set_comp_entry("pml83",FALSE)
   END IF
   IF g_sma.sma116 MATCHES '[02]' THEN    #No.FUN-610076
      CALL cl_set_comp_entry("pml86,pml87",FALSE)
   END IF

   #如果資料是由前端帶入的，則不可修改專案相關欄位
   IF NOT cl_null(g_pml[l_ac].pml24) THEN
     CALL cl_set_comp_entry("pml12,pml121,pml122",FALSE)
   END IF
   IF NOT cl_null(g_pmk.pmk09) THEN
      CALL cl_set_comp_entry("pml48",FALSE)
   END IF
END FUNCTION

FUNCTION t420_set_required()

 IF g_ima906 = '3' THEN
    CALL cl_set_comp_required("pml83,pml85,pml80,pml82",TRUE)
 END IF
 IF g_sma.sma115='Y' THEN  #MOD-840626   add
   IF NOT cl_null(g_pml[l_ac].pml80) THEN
      CALL cl_set_comp_required("pml82",TRUE)
   END IF
   IF NOT cl_null(g_pml[l_ac].pml83) THEN
      CALL cl_set_comp_required("pml85",TRUE)
   END IF
 END IF                    #MOD-840626 add
 IF g_sma.sma116 NOT MATCHES '[02]' THEN
    IF NOT cl_null(g_pml[l_ac].pml86) THEN
       CALL cl_set_comp_required("pml87",TRUE)
    END IF
 END IF

 #IF g_apy.apydmy5 = 'Y' AND g_pml[l_ac].pml20 !=0  THEN  #單據有做預算控算時，則預算相關欄位要輸入
  IF g_smy.smy59 = 'Y' AND g_pml[l_ac].pml20 !=0  THEN  #單據有做預算控算時，則預算相關欄位要輸入  #MOD-B60032 mod
     CALL cl_set_comp_required("pml67,pml40,pml31,pml31t",TRUE)        #No.FUN-830161
     IF g_aza.aza63 = 'Y' THEN #多套帳
       CALL cl_set_comp_required("pml401",TRUE)
     END IF
  END IF

END FUNCTION

FUNCTION t420_set_no_required()

 CALL cl_set_comp_required("pml83,pml84,pml85,pml80,pml81,pml82,pml86,pml87",FALSE)
 CALL cl_set_comp_required("pml67,pml40,pml401,pml31,pml31t",FALSE)        #FUN-810045  #No.FUN-830161

END FUNCTION

FUNCTION t421_set_entry(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1     #No.FUN-680136 VARCHAR(1)

   IF (NOT g_before_input_done) THEN
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
       CALL cl_set_comp_entry("pml31,pml31t",TRUE)
#FUN-B90101 add &endif
   END IF

END FUNCTION

FUNCTION t421_set_no_entry(p_cmd)
DEFINE   p_cmd    LIKE type_file.chr1     #No.FUN-680136  VARCHAR(1)

   IF g_gec07 = 'N' OR cl_null(g_gec07) THEN         #No.FUN-560102   #MOD-860100
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
      CALL cl_set_comp_entry("pml31t",FALSE)
   ELSE
      CALL cl_set_comp_entry("pml31",FALSE)
#FUN-B90101 add &endif
   END IF

END FUNCTION
FUNCTION t420_set_pml191()
  IF g_azw.azw04 ='2' AND g_pml[l_ac].pml50 MATCHES '[24]' THEN
      LET g_pml[l_ac].pml190 ='Y'
      IF cl_null(g_pml[l_ac].pml191) AND NOT cl_null(g_pml[l_ac].pml04) THEN
         SELECT rty12 INTO g_pml[l_ac].pml191
           FROM rty_file
          WHERE rty01 = g_pmk.pmkplant
            AND rty02 = g_pml[l_ac].pml04
      END IF
      CALL cl_set_comp_entry("pml191",TRUE)
      CALL cl_set_comp_required("pml191",TRUE)
      DISPLAY BY NAME g_pml[l_ac].pml190
      DISPLAY BY NAME g_pml[l_ac].pml191
  ELSE
      CALL cl_set_comp_entry("pml191",FALSE)
  END IF
END FUNCTION
FUNCTION t420_pml191()
DEFINE  l_geuacti LIKE geu_file.geuacti

    LET g_errno=''
    SELECT geuacti INTO l_geuacti
      FROM geu_file
     WHERE geu01 = g_pml[l_ac].pml191 AND geu00='4'
    CASE
        WHEN SQLCA.sqlcode=100   LET g_errno = 'art-591'
        WHEN l_geuacti='N'       LET g_errno='9028'
        OTHERWISE
        LET g_errno=SQLCA.sqlcode USING '------'
   END CASE
END FUNCTION

FUNCTION t420_set_pml07()
  DEFINE    l_ima906 LIKE ima_file.ima906,
            l_ima907 LIKE ima_file.ima907,
            l_img09  LIKE img_file.img09,
            l_tot    LIKE img_file.img10,
            l_fac2   LIKE pml_file.pml84,
            l_qty2   LIKE pml_file.pml85,
            l_fac1   LIKE pml_file.pml81,
            l_qty1   LIKE pml_file.pml82,
            l_factor LIKE ima_file.ima31_fac,   #No.FUN-680136 DECIMAL(16,8)
            l_ima25  LIKE ima_file.ima25,
            l_ima44  LIKE ima_file.ima44,
            p_code   LIKE type_file.chr1     #No.FUN-680136 VARCHAR(01)

   SELECT ima25,ima44,ima906 INTO l_ima25,l_ima44,l_ima906 FROM ima_file
    WHERE ima01=g_pml[l_ac].pml04
   LET l_fac2=g_pml2.pml84
   LET l_qty2=g_pml2.pml85
   LET l_fac1=g_pml2.pml81
   LET l_qty1=g_pml2.pml82

   IF cl_null(l_fac1) THEN LET l_fac1=1 END IF
   IF cl_null(l_qty1) THEN LET l_qty1=0 END IF
   IF cl_null(l_fac2) THEN LET l_fac2=1 END IF
   IF cl_null(l_qty2) THEN LET l_qty2=0 END IF
   IF g_sma.sma115 = 'Y' THEN
      CASE l_ima906
         WHEN '1' LET g_pml2.pml07=g_pml2.pml80
                  LET g_pml2.pml20=l_qty1
         WHEN '2' LET l_tot=l_fac1*l_qty1+l_fac2*l_qty2
                  LET g_pml2.pml07=l_ima44
                  LET g_pml2.pml20=l_tot
		  LET g_pml2.pml20=s_digqty(g_pml2.pml20,g_pml2.pml07)   #No.FUN-BB0086
         WHEN '3' LET g_pml2.pml07=g_pml2.pml80
                  LET g_pml2.pml20=l_qty1
      END CASE
   ELSE
      LET g_pml2.pml07=g_pml2.pml80
      LET g_pml2.pml20=l_qty1
   END IF

   LET g_cnt = 0
   LET g_factor = 1
   CALL s_umfchk(g_pml2.pml04,g_pml2.pml07,l_ima25)
         RETURNING g_cnt,g_factor
   IF g_cnt = 1 THEN
      LET g_factor = 1
   END IF
   LET g_pml2.pml09 = g_factor

   IF cl_null(g_pml2.pml86) THEN
      LET g_pml2.pml86 = g_pml2.pml07
      LET g_pml2.pml87 = g_pml2.pml09
   END IF
   RETURN g_cnt

END FUNCTION

#用于default 雙單位/轉換率/數量
FUNCTION t420_du_default(p_cmd)
  DEFINE    l_item   LIKE img_file.img01,     #料號
            l_ima25  LIKE ima_file.ima25,     #ima單位
            l_ima44  LIKE ima_file.ima44,     #ima單位
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
            p_cmd    LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01)
            l_factor LIKE ima_file.ima31_fac  #No.FUN-680136 DECIMAL(16,8)

    LET l_item = g_pml[l_ac].pml04

    SELECT ima25,ima44,ima31,ima906,ima907,ima908
      INTO l_ima25,l_ima44,l_ima31,l_ima906,l_ima907,l_ima908
      FROM ima_file WHERE ima01 = l_item

    IF g_sma.sma115 = 'Y' THEN   #No.TQC-6B0124 add
       IF l_ima906 = '1' THEN  #不使用雙單位
          LET l_unit2 = NULL
          LET l_fac2  = NULL
          LET l_qty2  = NULL
       ELSE
          LET l_unit2 = l_ima907
          CALL s_du_umfchk(l_item,'','','',l_ima44,l_ima907,l_ima906)
               RETURNING g_errno,l_factor
          LET l_fac2 = l_factor
          LET l_qty2  = 0
       END IF

       LET l_unit1 = l_ima44
       LET l_fac1  = 1
       LET l_qty1  = 0
    END IF       #No.TQC-6B0124 add

    IF g_sma.sma116 MATCHES '[02]' THEN    #No.FUN-610076
       LET l_unit3 = NULL
       LET l_qty3  = NULL
    ELSE
       LET l_unit3 = l_ima908
       LET l_qty3  = 0
    END IF

    IF p_cmd = 'a' OR g_pml[l_ac].pml04 <> g_pml04_y THEN
       LET g_pml[l_ac].pml83=l_unit2
       LET g_pml[l_ac].pml84=l_fac2
       LET g_pml[l_ac].pml85=l_qty2
       LET g_pml[l_ac].pml80=l_unit1
       LET g_pml[l_ac].pml81=l_fac1
       LET g_pml[l_ac].pml82=l_qty1
       LET g_pml[l_ac].pml86=l_unit3
       LET g_pml[l_ac].pml87=l_qty3
    END IF
END FUNCTION

#對原來數量/換算率/單位的賦值
FUNCTION t420_set_origin_field()
  DEFINE    l_ima906 LIKE ima_file.ima906,
            l_ima907 LIKE ima_file.ima907,
            l_img09  LIKE img_file.img09,     #img單位
            l_tot    LIKE img_file.img10,
            l_fac2   LIKE pml_file.pml84,
            l_qty2   LIKE pml_file.pml85,
            l_fac1   LIKE pml_file.pml81,
            l_qty1   LIKE pml_file.pml82,
            l_factor LIKE ima_file.ima31_fac,   #No.FUN-680136 DECIMAL(16,8)
            l_ima25  LIKE ima_file.ima25,
            l_ima44  LIKE ima_file.ima44

    IF g_sma.sma115='N' THEN RETURN END IF
    SELECT ima25,ima44 INTO l_ima25,l_ima44
      FROM ima_file WHERE ima01=g_pml[l_ac].pml04
    IF SQLCA.sqlcode =100 THEN
       IF g_pml[l_ac].pml04 MATCHES 'MISC*' THEN
          SELECT ima25,ima44 INTO l_ima25,l_ima44
            FROM ima_file WHERE ima01='MISC'
       END IF
    END IF
    IF cl_null(l_ima44) THEN LET l_ima44 = l_ima25 END IF

    LET l_fac2=g_pml[l_ac].pml84
    LET l_qty2=g_pml[l_ac].pml85
    LET l_fac1=g_pml[l_ac].pml81
    LET l_qty1=g_pml[l_ac].pml82

    IF cl_null(l_fac1) THEN LET l_fac1=1 END IF
    IF cl_null(l_qty1) THEN LET l_qty1=0 END IF
    IF cl_null(l_fac2) THEN LET l_fac2=1 END IF
    IF cl_null(l_qty2) THEN LET l_qty2=0 END IF

    IF g_sma.sma115 = 'Y' THEN
       CASE g_ima906
          WHEN '1' LET g_pml[l_ac].pml07=g_pml[l_ac].pml80
                   LET g_pml[l_ac].pml20=l_qty1
          WHEN '2' LET l_tot=l_fac1*l_qty1+l_fac2*l_qty2
                   LET g_pml[l_ac].pml07=l_ima44
                   LET g_pml[l_ac].pml20=l_tot
                   LET g_pml[l_ac].pml20=s_digqty(g_pml[l_ac].pml20,g_pml[l_ac].pml07)   #No.FUN-BB0086
          WHEN '3' LET g_pml[l_ac].pml07=g_pml[l_ac].pml80
                   LET g_pml[l_ac].pml20=l_qty1
                   IF l_qty2 <> 0 THEN
                      LET g_pml[l_ac].pml84=l_qty1/l_qty2
                   ELSE
                      LET g_pml[l_ac].pml84=0
                   END IF
                   LET g_pml2.pml84=g_pml[l_ac].pml84
       END CASE
    END IF

    LET g_factor = 1
    CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,l_ima25)
          RETURNING g_cnt,g_factor
    IF g_cnt = 1 THEN
       LET g_factor = 1
    END IF
    LET g_pml2.pml09 = g_factor

     SELECT azi03,azi04 INTO t_azi03,t_azi04 FROM azi_file
      WHERE azi01 = g_pmk.pmk22  AND aziacti= 'Y'  #原幣
    IF g_sma.sma116 MATCHES '[13]' THEN    #No.FUN-610076
       LET g_pml2.pml88 =cl_digcut(g_pml2.pml31*g_pml2.pml87,t_azi04)  #MOD-730047
    ELSE
       LET g_pml2.pml88 =cl_digcut(g_pml2.pml31*g_pml2.pml20,t_azi04)  #MOD-730047
    END IF
END FUNCTION

#兩組雙單位資料不是一定要全部KEY,如果沒有KEY單位,則把換算率/數量清空
FUNCTION t420_du_data_to_correct()

   IF cl_null(g_pml[l_ac].pml80) THEN
      LET g_pml[l_ac].pml81 = NULL
      LET g_pml[l_ac].pml82 = NULL
      LET g_pml2.pml80 = NULL
      LET g_pml2.pml81 = NULL
      LET g_pml2.pml82 = NULL
   END IF

   IF cl_null(g_pml[l_ac].pml83) THEN
      LET g_pml[l_ac].pml84 = NULL
      LET g_pml[l_ac].pml85 = NULL
      LET g_pml2.pml83 = NULL
      LET g_pml2.pml84 = NULL
      LET g_pml2.pml85 = NULL
   END IF

   IF cl_null(g_pml[l_ac].pml86) THEN
      LET g_pml[l_ac].pml87 = NULL
      LET g_pml2.pml86 = NULL
      LET g_pml2.pml87 = NULL
   END IF

   DISPLAY BY NAME g_pml[l_ac].pml81
   DISPLAY BY NAME g_pml[l_ac].pml82
   DISPLAY BY NAME g_pml[l_ac].pml84
   DISPLAY BY NAME g_pml[l_ac].pml85
   DISPLAY BY NAME g_pml[l_ac].pml86
   DISPLAY BY NAME g_pml[l_ac].pml87

END FUNCTION

FUNCTION t420_set_pml87()
  DEFINE    l_item   LIKE img_file.img01,     #料號
            l_ima25  LIKE ima_file.ima25,     #ima單位
            l_ima44  LIKE ima_file.ima44,     #ima單位
            l_ima906 LIKE ima_file.ima906,
            l_fac2   LIKE img_file.img21,     #第二轉換率
            l_qty2   LIKE img_file.img10,     #第二數量
            l_fac1   LIKE img_file.img21,     #第一轉換率
            l_qty1   LIKE img_file.img10,     #第一數量
            l_tot    LIKE img_file.img10,     #計價數量
            l_factor LIKE ima_file.ima31_fac  #No.FUN-680136 DECIMAL(16,8)

    SELECT ima25,ima44,ima906 INTO l_ima25,l_ima44,l_ima906
      FROM ima_file WHERE ima01=g_pml[l_ac].pml04
    IF SQLCA.sqlcode =100 THEN
       IF g_pml[l_ac].pml04 MATCHES 'MISC*' THEN
          SELECT ima25,ima44,ima906 INTO l_ima25,l_ima44,l_ima906
            FROM ima_file WHERE ima01='MISC'
       END IF
    END IF
    IF cl_null(l_ima44) THEN LET l_ima44 = l_ima25 END IF

    LET l_fac2=g_pml[l_ac].pml84
    LET l_qty2=g_pml[l_ac].pml85
    IF g_sma.sma115 = 'Y' THEN
       LET l_fac1=g_pml[l_ac].pml81
       LET l_qty1=g_pml[l_ac].pml82
    ELSE
       LET l_fac1=1
       LET l_qty1=g_pml[l_ac].pml20
       CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,l_ima44)
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
    LET l_factor = 1
    IF g_sma.sma115 = 'Y' THEN
       CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,g_pml[l_ac].pml86)
             RETURNING g_cnt,l_factor
    ELSE
       CALL s_umfchk(g_pml[l_ac].pml04,l_ima44,g_pml[l_ac].pml86)
             RETURNING g_cnt,l_factor
    END IF
    IF g_cnt = 1 THEN
       LET l_factor = 1
    END IF
    LET l_tot = l_tot * l_factor

    LET g_pml[l_ac].pml87 = l_tot
    LET g_pml[l_ac].pml87 = s_digqty(g_pml[l_ac].pml87,g_pml[l_ac].pml86)   #No.FUN-BB0086
END FUNCTION

FUNCTION t420_sel_ima()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
    SELECT ima25,ima44,ima906,ima907,ima908
      INTO g_ima25,g_ima44,g_ima906,g_ima907,g_ima908
      FROM ima_file
     WHERE ima01=g_pml[l_ac].pml04
#FUN-B90101 add &endif
END FUNCTION

FUNCTION t420_def_form()

   CALL cl_set_comp_visible("pml81,pml84",FALSE)
   IF g_sma.sma115 = 'Y' THEN
      CALL cl_set_comp_visible("pml07,pml20",FALSE)
   ELSE
      CALL cl_set_comp_visible("pml83,pml84,pml85",FALSE)
      CALL cl_set_comp_visible("pml80,pml81,pml82",FALSE)
   END IF

   IF g_sma.sma116 MATCHES '[02]' THEN    #No.FUN-610076
      CALL cl_set_comp_visible("pml86,pml87",FALSE)
   END IF

   IF g_sma.sma122 ='1' THEN
      CALL cl_getmsg('asm-302',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml83",g_msg CLIPPED)
      CALL cl_getmsg('asm-306',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml85",g_msg CLIPPED)
      CALL cl_getmsg('asm-303',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml80",g_msg CLIPPED)
      CALL cl_getmsg('asm-307',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml82",g_msg CLIPPED)
   END IF

   IF g_sma.sma122 ='2' THEN
      CALL cl_getmsg('asm-304',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml83",g_msg CLIPPED)
      CALL cl_getmsg('asm-308',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml85",g_msg CLIPPED)
      CALL cl_getmsg('asm-359',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml80",g_msg CLIPPED)
      CALL cl_getmsg('asm-360',g_lang) RETURNING g_msg
      CALL cl_set_comp_att_text("pml82",g_msg CLIPPED)
   END IF
   CALL cl_set_comp_visible("pml930,gem02a",g_aaz.aaz90='Y')

   CALL cl_set_comp_visible("pmk05,pml12,pml121,pml122",g_aza.aza08='Y')  #FUN-810045 add

END FUNCTION

FUNCTION t420_refresh_detail()
  DEFINE l_compare          LIKE smy_file.smy62
  DEFINE li_col_count       LIKE type_file.num5     #No.FUN-680136 SMALLINT
  DEFINE li_i, li_j         LIKE type_file.num5     #No.FUN-680136 SMALLINT
  DEFINE lc_agb03           LIKE agb_file.agb03
  DEFINE lr_agd             RECORD LIKE agd_file.*
  DEFINE lc_index           STRING
  DEFINE ls_combo_vals      STRING
  DEFINE ls_combo_txts      STRING
  DEFINE ls_sql             STRING
  DEFINE ls_show,ls_hide    STRING
  DEFINE l_gae04            LIKE gae_file.gae04

  #判斷是否進行料件多屬性新機制管理以及是否傳入了屬性群組
  IF (g_sma.sma120 = 'Y') AND (g_sma.sma907 = 'Y') AND
     NOT cl_null(lg_smy62) THEN
     #首先判斷有無單身記錄，如果單身根本沒有東東，則按照默認的lg_smy62來決定
     #顯示什么組別的信息，如果有單身，則進行下面的邏輯判斷
     IF g_pml.getLength() = 0 THEN
        LET lg_group = lg_smy62
     ELSE
       #讀取當前單身所有的料件資料，如果它們都屬于多屬性子料件，并且擁有一致的
       #屬性群組，則以該屬性群組作為顯示單身明細屬性的依據，如果有不統一的狀況
       #則返回一個NULL，下面將不顯示任明細屬性列
       FOR li_i = 1 TO g_pml.getLength()
         #如果某一個料件沒有對應的母料件(已經在前面的b_fill中取出來放在imx00中了)
         #則不進行下面判斷直接退出了
         IF  cl_null(g_pml[li_i].att00) THEN
            LET lg_group = ''
            EXIT FOR
         END IF
         SELECT imaag INTO l_compare FROM ima_file WHERE ima01 = g_pml[li_i].att00
         #第一次是賦值
         IF cl_null(lg_group) THEN
            LET lg_group = l_compare
         #以后是比較
         ELSE
           #如果在單身料件屬于不同的屬性組則直接退出（不顯示這些東東)
           IF l_compare <> lg_group THEN
              LET lg_group = ''
              EXIT FOR
           END IF
         END IF
         IF lg_group <> lg_smy62 THEN
            LET lg_group = ''
            EXIT FOR
         END IF
       END FOR
     END IF

     #到這里時lg_group中存放的已經是應該顯示的組別了，該變量是一個全局變量
     #在單身INPUT或開窗時都會用到，因為refresh函數被執行的時機較早，所以能保証在需要的時候有值
     SELECT COUNT(*) INTO li_col_count FROM agb_file WHERE agb01 = lg_group

     #走到這個分支說明是采用新機制，那么使用att00父料件編號代替oeb04子料件編號來顯示
     #得到當前語言別下oeb04的欄位標題
     SELECT gae04 INTO l_gae04 FROM gae_file
       WHERE gae01 = g_prog AND gae02 = 'pml04' AND gae03 = g_lang
     CALL cl_set_comp_att_text("att00",l_gae04)

     #為了提高效率，把需要顯示和隱藏的欄位都放到各自的變量里，然后在結尾的地方一次性顯示或隱藏
     IF NOT cl_null(lg_group) THEN
        LET ls_hide = 'pml04,pml041'
        LET ls_show = 'att00'
     ELSE
        LET ls_hide = 'att00'
        LET ls_show = 'pml04,pml041'
     END IF

     #顯現該有的欄位,置換欄位格式
     CALL lr_agc.clear()  #因為這個過程可能會被執行多次，作為一個公共變量，每次執行之前必須要初始化
     FOR li_i = 1 TO li_col_count
         SELECT agb03 INTO lc_agb03 FROM agb_file
           WHERE agb01 = lg_group AND agb02 = li_i

         LET lc_agb03 = lc_agb03 CLIPPED
         SELECT * INTO lr_agc[li_i].* FROM agc_file
           WHERE agc01 = lc_agb03

         LET lc_index = li_i USING '&&'

         CASE lr_agc[li_i].agc04
           WHEN '1'
             LET ls_show = ls_show || ",att" || lc_index
             LET ls_hide = ls_hide || ",att" || lc_index || "_c"
             CALL cl_set_comp_att_text("att" || lc_index,lr_agc[li_i].agc02)

             #這里需要判別g_sma.sma908,如果是允許新增子料件則要把這些屬性設置成為REQUIRED的,否則要設成NOENTRY
                CALL cl_chg_comp_att("formonly.att" || lc_index,"NOT NULL|REQUIRED|SCROLL","1|1|1")
           WHEN '2'
             LET ls_show = ls_show || ",att" || lc_index || "_c"
             LET ls_hide = ls_hide || ",att" || lc_index
             CALL cl_set_comp_att_text("att" || lc_index || "_c",lr_agc[li_i].agc02)
             LET ls_sql = "SELECT * FROM agd_file WHERE agd01 = '",lr_agc[li_i].agc01,"'"
             DECLARE agd_curs CURSOR FROM ls_sql
             LET ls_combo_vals = ""
             LET ls_combo_txts = ""
             FOREACH agd_curs INTO lr_agd.*
                IF SQLCA.sqlcode THEN
                   EXIT FOREACH
                END IF
                IF ls_combo_vals IS NULL THEN
                   LET ls_combo_vals = lr_agd.agd02 CLIPPED
                ELSE
                   LET ls_combo_vals = ls_combo_vals,",",lr_agd.agd02 CLIPPED
                END IF
                IF ls_combo_txts IS NULL THEN
                   LET ls_combo_txts = lr_agd.agd02 CLIPPED,":",lr_agd.agd03 CLIPPED
                ELSE
                   LET ls_combo_txts = ls_combo_txts,",",lr_agd.agd02 CLIPPED,":",lr_agd.agd03 CLIPPED
                END IF
             END FOREACH
             CALL cl_set_combo_items("formonly.att" || lc_index || "_c",ls_combo_vals,ls_combo_txts)
             #這里需要判別g_sma.sma908,如果是允許新增子料件則要把這些屬性設置成為REQUIRED的,否則要設成NOENTRY
                CALL cl_chg_comp_att("formonly.att" || lc_index || "_c","NOT NULL|REQUIRED|SCROLL","1|1|1")
          WHEN '3'
             LET ls_show = ls_show || ",att" || lc_index
             LET ls_hide = ls_hide || ",att" || lc_index || "_c"
             CALL cl_set_comp_att_text("att" || lc_index,lr_agc[li_i].agc02)
             #這里需要判別g_sma.sma908,如果是允許新增子料件則要把這些屬性設置成為REQUIRED的,否則要設成NOENTRY
                CALL cl_chg_comp_att("formonly.att" || lc_index,"NOT NULL|REQUIRED|SCROLL","1|1|1")
       END CASE
     END FOR

  ELSE
    #否則什么也不做(不顯示任何屬性列)
    LET li_i = 1
    #為了提高效率，把需要顯示和隱藏的欄位都放到各自的變量里，然后在結尾的地方一次性顯示或隱藏
    LET ls_hide = 'att00'
    LET ls_show = 'pml04'
  END IF

  #下面開始隱藏其他明細屬性欄位(從li_i開始)
  FOR li_j = li_i TO 10
      LET lc_index = li_j USING '&&'
      #注意att0x和att0x_c都要隱藏，別忘了_c的
      LET ls_hide = ls_hide || ",att" || lc_index || ",att" || lc_index || "_c"
  END FOR

  #這樣只用調兩次公共函數就可以解決問題了，效率應該會高一些
  CALL cl_set_comp_visible(ls_show, TRUE)
  CALL cl_set_comp_visible(ls_hide, FALSE)

END FUNCTION

#--------------------在修改下面的代碼前請讀一下注釋先，謝了! -----------------------

#下面代碼是從單身INPUT ARRAY語句中的AFTER FIELD段中拷貝來的，因為在多屬性新模式下原來的oea04料件編號
#欄位是要被隱藏起來，并由新增加的imx00（母料件編號）+各個明細屬性欄位來取代，所以原來的AFTER FIELD
#代碼是不會被執行到，需要執行的判斷應該放新增加的几個欄位的AFTER FIELD中來進行，因為要用多次嘛，所以
#單獨用一個FUNCTION來放，順便把oeb04的AFTER FIELD也移過來，免得將來維護的時候遺漏了
#下標g_oeb[l_ac]都被改成g_oeb[p_ac]，請注意

#本函數返回TRUE/FALSE,表示檢核過程是否通過，一般說來，在使用過程中應該是如下方式□
#    AFTER FIELD XXX
#        IF NOT t420_check_oeb04(.....)  THEN NEXT FIELD XXX END IF
FUNCTION t420_check_pml04(p_field,p_ac,p_cmd) #No.MOD-660090
DEFINE
  p_field                     STRING,    #當前是在哪個欄位中觸發了AFTER FIELD事件
  p_ac                        LIKE type_file.num5,     #No.FUN-680136 SMALLINT  #g_oeb數組中的當前記錄下標
  l_flag1,g_flag              LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01)

  l_ps                        LIKE sma_file.sma46,
  l_str_tok                   base.stringTokenizer,
  l_tmp, ls_sql               STRING,
  l_param_list                STRING,
  l_cnt, li_i                 LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  ls_value                    STRING,
  ls_pid,ls_value_fld         LIKE ima_file.ima01,
  ls_name, ls_spec            STRING,
  lc_agb03                    LIKE agb_file.agb03,
  lc_agd03                    LIKE agd_file.agd03,
  ls_pname                    LIKE ima_file.ima02,
  l_misc                      LIKE type_file.chr4,     #No.FUN-680136 VARCHAR(04)
  l_n                         LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  l_b2                        LIKE ima_file.ima31,
  l_ima130                    LIKE ima_file.ima130,
  l_ima131                    LIKE ima_file.ima131,
  l_ima25                     LIKE ima_file.ima25,
  l_imaacti                   LIKE ima_file.imaacti,
  l_qty                       LIKE type_file.num10,    #No.FUN-680136 INTEGER
  p_cmd                       LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01) #No.MOD-660090
  l_ima915                    LIKE ima_file.ima915     #FUN-710060 add

#FUN-A60035 ---MARK BEGIN
##FUN-A50054---Begin add
#&ifndef SLK
##FUN-A50054---end
#FUN-A60035 ---MARK END
  #如果當前欄位是新增欄位（母料件編號以及十個明細屬性欄位）的時候，如果全部輸了值則合成出一個
  #新的子料件編號并把值填入到已經隱藏起來的oeb04中（如果imxXX能夠顯示，oeb04一定是隱藏的）
  #下面就可以直接沿用oeb04的檢核邏輯了
  #如果不是，則看看是不是oeb04自己觸發了，如果還不是則什么也不做(無聊)，返回一個FALSE
  IF (p_field = 'imx00') OR (p_field = 'imx01') OR (p_field = 'imx02') OR
     (p_field = 'imx03') OR (p_field = 'imx04') OR (p_field = 'imx05') OR
     (p_field = 'imx06') OR (p_field = 'imx07') OR (p_field = 'imx08') OR
     (p_field = 'imx09') OR (p_field = 'imx10')  THEN

     #首先判斷需要的欄位是否全部完成了輸入（只有母料件編號+被顯示出來的所有明細屬性
     #全部被輸入完成了才進行后續的操作
     LET ls_pid = g_pml[p_ac].att00   # ls_pid 父料件編號
     LET ls_value = g_pml[p_ac].att00   # ls_value 子料件編號
     IF cl_null(ls_pid) THEN
        #所有要返回TRUE的分支都要加這兩句話,原來下面的會被
        #注釋掉
        CALL t420_set_no_entry_b(p_cmd)
        CALL t420_set_required()

        RETURN TRUE
     END IF  #注意這里沒有錯，所以返回TRUE

     #取出當前母料件包含的明細屬性的個數
     SELECT COUNT(*) INTO l_cnt FROM agb_file WHERE agb01 =
        (SELECT imaag FROM ima_file WHERE ima01 = ls_pid)
     IF l_cnt = 0 THEN
        #所有要返回TRUE的分支都要加這兩句話,原來下面的會被
        #注釋掉
        CALL t420_set_no_entry_b(p_cmd)
        CALL t420_set_required()

         RETURN TRUE
     END IF

     FOR li_i = 1 TO l_cnt
         #如果有任何一個明細屬性應該輸而沒有輸的則退出
         IF cl_null(arr_detail[p_ac].imx[li_i]) THEN
            #所有要返回TRUE的分支都要加這兩句話,原來下面的會被
            #注釋掉
            CALL t420_set_no_entry_b(p_cmd)
            CALL t420_set_required()

            RETURN TRUE
         END IF
     END FOR

     #得到系統定義的標准分隔符sma46
     SELECT sma46 INTO l_ps FROM sma_file

     #合成子料件的名稱
     SELECT ima02 INTO ls_pname FROM ima_file   # ls_name 父料件名稱
       WHERE ima01 = ls_pid
     LET ls_spec = ls_pname  # ls_spec 子料件名稱
     #方法:循環在agd_file中找有沒有對應記錄，如果有，就用該記錄的名稱來
     #替換初始名稱，如果找不到則就用原來的名稱
     FOR li_i = 1 TO l_cnt
         LET lc_agd03 = ""
         LET ls_value = ls_value.trim(), l_ps, arr_detail[p_ac].imx[li_i]
         SELECT agd03 INTO lc_agd03 FROM agd_file
          WHERE agd01 = lr_agc[li_i].agc01 AND agd02 = arr_detail[p_ac].imx[li_i]
         IF cl_null(lc_agd03) THEN
            LET ls_spec = ls_spec.trim(),l_ps,arr_detail[p_ac].imx[li_i]
         ELSE
            LET ls_spec = ls_spec.trim(),l_ps,lc_agd03
         END IF
     END FOR

     #解析ls_value生成要傳給cl_copy_bom的那個l_param_list
     LET l_str_tok = base.StringTokenizer.create(ls_value,l_ps)
     LET l_tmp = l_str_tok.nextToken()   #先把第一個部分--名稱去掉

     LET ls_sql = "SELECT agb03 FROM agb_file,ima_file WHERE ",
                  "ima01 = '",ls_pid CLIPPED,"' AND agb01 = imaag ",
                  "ORDER BY agb02"
     DECLARE param_curs CURSOR FROM ls_sql
     FOREACH param_curs INTO lc_agb03
       #l_str_tok中的Tokens數量應該和param_curs中的記錄數量完全一致
       IF cl_null(l_param_list) THEN
          LET l_param_list = '#',lc_agb03,'#|',l_str_tok.nextToken()
       ELSE
          LET l_param_list = l_param_list,'|#',lc_agb03,'#|',l_str_tok.nextToken()
       END IF
     END FOREACH

     LET g_value = ls_value
     IF g_sma.sma908 <> 'Y' THEN
        SELECT COUNT(*) INTO l_n FROM ima_file WHERE ima01=g_value
        IF l_n=0 THEN
           CALL cl_err(g_value,'ams-003',1)
           RETURN FALSE
        END IF
     END IF

     #調用cl_copy_ima將新生成的子料件插入到數據庫中
     IF cl_copy_ima(ls_pid,ls_value,ls_spec,l_param_list) = TRUE THEN
        #如果向其中成功插入記錄則同步插入屬性記錄到imx_file中去
        LET ls_value_fld = ls_value
        INSERT INTO imx_file VALUES(ls_value_fld,ls_pid,arr_detail[p_ac].imx[1],
          arr_detail[p_ac].imx[2],arr_detail[p_ac].imx[3],arr_detail[p_ac].imx[4],
          arr_detail[p_ac].imx[5],arr_detail[p_ac].imx[6],arr_detail[p_ac].imx[7],
          arr_detail[p_ac].imx[8],arr_detail[p_ac].imx[9],arr_detail[p_ac].imx[10])
        #如果向imx_file中插入記錄失敗則也應將ima_file中已經建立的紀錄刪除以保証兩邊
        #記錄的完全同步
        IF SQLCA.sqlcode THEN
           CALL cl_err3("ins","imx_file",ls_value_fld,"",SQLCA.sqlcode,"","Failure to insert imx_file , rollback insert to ima_file!",1)  #No.FUN-660129
           DELETE FROM ima_file WHERE ima01 = ls_value_fld
           RETURN FALSE
#MOD-B10129 mark --start--
#&ifdef ICD
#        ELSE
#           IF NOT s_del_imaicd(ls_value_fld,'') THEN
#              RETURN FALSE
#           END IF
#&endif
#MOD-B10129 mark --end--
        END IF
     END IF
     #把生成的子料件賦給oeb04，否則下面的檢查就沒有意義了
     LET g_pml[p_ac].pml04 = ls_value
  ELSE
    IF ( p_field <> 'pml04' )AND( p_field <> 'imx00' ) THEN
       RETURN FALSE
    END IF
  END IF
#FUN-A60035 ---MARK BEGIN
##FUN-A50054--Begin add
#&endif
##FUN-A50054---end
#FUN-A60035 ---MARK END
  #到這里已經完成了以前在cl_itemno_multi_att()中做的所有准備工作，在系統資料庫
  #中已經有了對應的子料件的名稱，下面可以按照oeb04進行判斷了

  #--------重要 !!!!!!!!!!!-------------------------
  #下面的代碼都是從原INPUT ARRAY中的AFTER FIELD oeb04段拷貝來的，唯一做的修改
  #是將原來的NEXT FIELD 語句都改成了RETURN FALSE, xxx,xxx ... ，因為NEXE FIELD
  #語句要交給調用方來做，這里只需要返回一個FALSE告訴它有錯誤就可以了，同時一起
  #返回的還有一些CHECK過程中要從ima_file中取得的欄位信息，其他的比如判斷邏輯和
  #錯誤提示都沒有改，如果你需要在里面添加代碼請注意上面的那個要點就可以了

    IF NOT cl_null(g_pml[l_ac].pml04) THEN
       LET l_misc=g_pml[l_ac].pml04[1,4]
       IF g_pml[l_ac].pml04[1,4]='MISC' THEN
          SELECT COUNT(*) INTO l_n FROM ima_file
           WHERE ima01=l_misc
             AND ima01='MISC'
          IF l_n=0 THEN
              CALL cl_err('','aim-806',0)
              RETURN FALSE
          END IF
       END IF
       LET g_pml2.pml04 = g_pml[l_ac].pml04
       LET g_no = g_pml2.pml04[1,4]
       IF g_pml[l_ac].pml04 != g_pml_t.pml04 OR cl_null(g_pml_t.pml04) THEN
	  LET g_pml2.pml40  = NULL	#MOD-9A0028
	  LET g_pml2.pml401 = NULL	#MOD-9A0028
          CALL t420_pml04('a',g_no)
          LET g_pml[l_ac].pml40 = g_pml2.pml40   #MOD-B10094 add
          LET g_pml[l_ac].pml401 = g_pml2.pml401 #MOD-B10094 add
          IF NOT cl_null(g_errno) THEN  #MOD-7C0050
              CALL cl_err(g_pml[l_ac].pml04,g_errno,0)
              LET g_pml[l_ac].pml04 = g_pml_o.pml04
              RETURN FALSE
          END IF
       END IF
       IF (g_pml_o.pml04 IS NULL OR g_pml[l_ac].pml04 != g_pml_o.pml04)
          AND (g_no[1,4] != 'MISC') THEN
              #請購料件/供應商控制
          SELECT ima915 INTO l_ima915 FROM ima_file WHERE ima01=g_pml[l_ac].pml04  #FUN-710060 add
          IF (l_ima915='1' OR l_ima915='3') AND NOT cl_null(g_pmk.pmk09)      #FUN-710060 mod #TQC-BC0111 (l_ima915 ='1' OR l_ima915='3') 加括號
             AND NOT cl_null(g_pmk.pmk22) THEN
#            CALL t420_pmh()                    #CHI-B80082 mark
             CALL t420_pmh(g_pml[l_ac].pml04)   #CHI-B80082
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_pml[l_ac].pml04,g_errno,1)
                LET g_pml[l_ac].pml04 = g_pml_o.pml04
                RETURN FALSE
             END IF
          END IF
          #料件主檔檢查/預設值的讀取
          CALL t420_def()
          IF NOT cl_null(g_errno) THEN
             CALL cl_err(g_pml[l_ac].pml04,g_errno,1)
             LET g_pml[l_ac].pml04 = g_pml_o.pml04
             RETURN FALSE
          END IF
          DISPLAY BY NAME g_pml[l_ac].pml04
       END IF
       IF g_sma.sma886[4,4]='Y' AND
         (g_pmk.pmk02='EXP' OR g_pmk.pmk02='CAP'
          OR g_no[1,4] = 'MISC') THEN
          CALL t441(p_cmd)
       END IF
       IF g_sma.sma115 = 'Y' THEN
          CALL s_chk_va_setting(g_pml[l_ac].pml04)
               RETURNING g_flag,g_ima906,g_ima907
          IF g_flag=1 THEN
             RETURN FALSE
          END IF
          CALL s_chk_va_setting1(g_pml[l_ac].pml04)
               RETURNING g_flag,g_ima908
          IF g_flag=1 THEN
             RETURN FALSE
          END IF
          IF g_ima906 = '3' THEN
             LET g_pml[l_ac].pml83=g_ima907
             DISPLAY BY NAME g_pml[l_ac].pml83
          END IF
       END IF
       IF g_sma.sma116 MATCHES '[13]' THEN
          IF cl_null(g_pml[l_ac].pml86) THEN
             LET g_pml[l_ac].pml86=g_ima908
             DISPLAY BY NAME g_pml[l_ac].pml86
          END IF
       END IF
       SELECT ima25,ima44 INTO g_ima25,g_ima44 FROM ima_file
        WHERE ima01=g_pml[l_ac].pml04
          CALL t420_du_default(p_cmd)
       LET g_pml2.pml04 = g_pml[l_ac].pml04
       LET g_pml_o.pml04 = g_pml[l_ac].pml04
    DISPLAY g_pml[l_ac].pml04 TO pml04
    DISPLAY g_pml[l_ac].pml041 TO pml041

#FUN-A60035 ---MARK BEGIN
##FUN-A50054 Begin add
#&ifndef SLK
#FUN-A60035 ---MARK END
     #新增一個判斷,如果lg_smy62不為空,表示當前采用的是料件多屬性的新機制,因此這個函數應該是被
     #attxx這樣的明細屬性欄位的AFTER FIELD來調用的,所以不再使用原來的輸入機制,否則不變
     IF cl_null(lg_smy62) THEN
       IF g_sma.sma120 = 'Y' THEN
          CALL cl_itemno_multi_att("pml04",g_pml[l_ac].pml04,"","1","c") RETURNING l_check,g_pml[l_ac].pml04,g_pml[l_ac].pml041
          IF NOT l_check THEN
             RETURN FALSE
          END IF
          DISPLAY g_pml[l_ac].pml04 TO pml04
          DISPLAY g_pml[l_ac].pml041 TO pml041
       END IF
     END IF
#FUN-A60035 ---MARK BEGIN
#&endif
##FUN-A50054 end add
#FUN-A60035 ---MARK END

     #-新增的關于AFTER FIELD oeb的邏輯請同樣加一份在這里

     #所有要返回TRUE的分支都要加這兩句話,原來下面的會被
     #注釋掉
     CALL t420_set_no_entry_b(p_cmd)
     CALL t420_set_required()

     RETURN TRUE
  ELSE
     #如果是由oeb04來觸發的,說明當前用的是舊的流程,那么oeb04為空是可以的
     #如果是由att00來觸發,原理一樣
     IF (p_field = 'pml04') OR (p_field = 'imx00') THEN
        #所有要返回TRUE的分支都要加這兩句話,原來下面的會被
        #注釋掉
        CALL t420_set_no_entry_b(p_cmd)
        CALL t420_set_required()

        RETURN TRUE
     ELSE
        #如果不是oeb,則是由attxx來觸發的,則非輸不可
        RETURN FALSE
     END IF #如果為空則不允許新增
  END IF
END FUNCTION

#用于att01~att10這十個輸入型屬性欄位的AFTER FIELD事件的判斷函數
#傳入參數:p_value 要比較的欄位內容,p_index當前欄位的索引號(從1~10表示att01~att10)
#         p_row是當前行索引,傳入INPUT ARRAY中使用的l_ac即可
#與t420_check_oeb04相同,如果檢查過程中如果發現錯誤,則報錯并返回一個FALSE
#而AFTER FIELD的時候檢測到這個返回值則會做NEXT FIELD

FUNCTION t420_check_att0x(p_value,p_index,p_row,p_cmd) #No.MOD-660090
DEFINE
  p_value      LIKE imx_file.imx01,
  p_index      LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  p_row        LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  li_min_num   LIKE agc_file.agc05,
  li_max_num   LIKE agc_file.agc06,
  l_index      STRING,
  p_cmd        LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01) #No.MOD-660090
  l_check_res  LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  l_b2         LIKE type_file.chr1000,  #No.FUN-680136 VARCHAR(30)
  l_imaacti    LIKE ima_file.imaacti,
  l_ima130     LIKE ima_file.ima130,    #No.FUN-680136 VARCHAR(1)
  l_ima131     LIKE ima_file.ima131,    #No.FUN-680136 VARCHAR(10)
  l_ima25      LIKE ima_file.ima25

  #這個欄位一旦進入了就不能忽略，因為要保証在輸入其他欄位之前必須要生成oeb04料件編號
  IF cl_null(p_value) THEN
     RETURN FALSE
  END IF

  #這里使用到了一個用于存放當前屬性組包含的所有屬性信息的全局數組lr_agc
  #該數組會由t420_refresh_detail()函數在較早的時候填充

  #判斷長度與定義的使用位數是否相等
  IF LENGTH(p_value CLIPPED) <> lr_agc[p_index].agc03 THEN
     CALL cl_err_msg("","aim-911",lr_agc[p_index].agc03,1)
     RETURN FALSE
  END IF
  #比較大小是否在合理范圍之內
  LET li_min_num = lr_agc[p_index].agc05
  LET li_max_num = lr_agc[p_index].agc06
  IF (lr_agc[p_index].agc05 IS NOT NULL) AND
     (p_value < li_min_num) THEN
     CALL cl_err_msg("","lib-232",lr_agc[p_index].agc05 || "|" || lr_agc[p_index].agc06,1)
     RETURN FALSE
  END IF
  IF (lr_agc[p_index].agc06 IS NOT NULL) AND
     (p_value > li_max_num) THEN
     CALL cl_err_msg("","lib-232",lr_agc[p_index].agc05 || "|" || lr_agc[p_index].agc06,1)
     RETURN FALSE
  END IF
  #通過了欄位檢查則可以下面的合成子料件代碼以及相應的檢核操作了
  LET arr_detail[p_row].imx[p_index] = p_value
  LET l_index = p_index USING '&&'
  CALL t420_check_pml04('imx' || l_index ,p_row,p_cmd)  #No.MOD-660090
    RETURNING l_check_res
    RETURN l_check_res
END FUNCTION

#用于att01_c~att10_c這十個選擇型屬性欄位的AFTER FIELD事件的判斷函數
#傳入參數:p_value 要比較的欄位內容,p_index當前欄位的索引號(從1~10表示att01~att10)
#         p_row是當前行索引,傳入INPUT ARRAY中使用的l_ac即可
#與t420_check_oeb04相同,如果檢查過程中如果發現錯誤,則報錯并返回一個FALSE
#而AFTER FIELD的時候檢測到這個返回值則會做NEXT FIELD
FUNCTION t420_check_att0x_c(p_value,p_index,p_row,p_cmd) #No.MOD-660090
DEFINE
  p_value  LIKE imx_file.imx01,
  p_index  LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  p_row    LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  l_index  STRING,
  p_cmd    LIKE type_file.chr1,     #No.FUN-680136 VARCHAR(01) #No.MOD-660090
  l_check_res     LIKE type_file.num5,     #No.FUN-680136 SMALLINT
  l_b2            LIKE type_file.chr1000,  #No.FUN-680136 VARCHAR(30)
  l_imaacti       LIKE ima_file.imaacti,
  l_ima130        LIKE ima_file.ima130,    #No.FUN-680136 VARCHAR(1)
  l_ima131        LIKE ima_file.ima131,    #No.FUN-680136 VARCHAR(10)
  l_ima25         LIKE ima_file.ima25


  #這個欄位一旦進入了就不能忽略，因為要保証在輸入其他欄位之前必須要生成oeb04料件編號
  IF cl_null(p_value) THEN
     RETURN FALSE
  END IF

  #下拉框選擇項相當簡單，不需要進行范圍和長度的判斷，因為肯定是符合要求的了
  LET arr_detail[p_row].imx[p_index] = p_value
  LET l_index = p_index USING '&&'
  CALL t420_check_pml04('imx'||l_index,p_row,p_cmd) RETURNING l_check_res

  RETURN l_check_res
END FUNCTION


FUNCTION t420_set_pml930(p_pml930)
   DEFINE p_pml930 LIKE pml_file.pml930
   DEFINE l_gem02  LIKE gem_file.gem02

   SELECT gem02 INTO l_gem02 FROM gem_file
                            WHERE gem01=p_pml930
   IF SQLCA.sqlcode THEN
      LET l_gem02=NULL
   END IF
   RETURN l_gem02
END FUNCTION


FUNCTION t420_pic()
   IF g_pmk.pmk18 = 'X' THEN
      LET g_chr = 'Y'
   ELSE
      LET g_chr = 'N'
   END IF

   IF g_pmk.pmk25 = '1' OR g_pmk.pmk25 = '2' THEN
      LET g_chr2 = 'Y'
   ELSE
      LET g_chr2 = 'N'
   END IF

   IF g_pmk.pmk25 = '6' THEN
      LET g_chr3 = 'Y'
   ELSE
      LET g_chr3 = 'N'
   END IF

   CALL cl_set_field_pic(g_pmk.pmk18,g_chr2,"",g_chr3,g_chr,"")
END FUNCTION

FUNCTION t420_aps()
   DEFINE  l_chr4      LIKE type_file.chr4
   DEFINE  l_vmz       RECORD LIKE vmz_file.*    #FUN-7C0002
   DEFINE  l_vmz01     LIKE vmz_file.vmz01       #FUN-7C0002

         IF cl_null(l_ac) OR l_ac = 0 THEN LET l_ac = 1 END IF
         IF cl_null(g_pmk.pmk01) THEN
             CALL cl_err('',-400,1)
             RETURN
         END IF
         IF cl_null(g_pml[l_ac].pml02) THEN
             CALL cl_err('','arm-034',1)
             RETURN
         END IF
         LET l_chr4 = g_pml[l_ac].pml02 USING '&&&&'

         LET l_vmz01 = g_pmk.pmk01 CLIPPED,'-',l_chr4
         SELECT vmz01 FROM vmz_file
          WHERE vmz01 = l_vmz01
         IF SQLCA.SQLCODE=100 THEN
            LET l_vmz.vmz01 = l_vmz01
            LET l_vmz.vmz12 = 0
            LET l_vmz.vmz16 = NULL
            LET l_vmz.vmz25 = 0    #FUN-910005 ADD
            LET l_vmz.vmzplant = g_plant #FUN-B50046 add
            LET l_vmz.vmzlegal = g_legal #FUN-B50046 add
            INSERT INTO vmz_file VALUES(l_vmz.*)
               IF STATUS THEN
                  CALL cl_err3("ins","vmz_file",l_vmz.vmz01,"",SQLCA.sqlcode,
                               "","",1)
               END IF
         END IF
         LET g_cmd = "apsi317 '",l_vmz01,"'"
         CALL cl_cmdrun(g_cmd)
END FUNCTION

FUNCTION t420_b_move_to()
#FUN-B90101--add--begin
#FUN-B90101--add--end--
   LET g_pml[l_ac].pml02  = g_pml2.pml02
   LET g_pml[l_ac].pml24  = g_pml2.pml24
   LET g_pml[l_ac].pml25  = g_pml2.pml25
   LET g_pml[l_ac].pml04  = g_pml2.pml04
   LET g_pml[l_ac].pml041 = g_pml2.pml041
   LET g_pml[l_ac].pml07  = g_pml2.pml07
   LET g_pml[l_ac].pml20  = g_pml2.pml20
   LET g_pml[l_ac].pml83  = g_pml2.pml83
   LET g_pml[l_ac].pml84  = g_pml2.pml84
   LET g_pml[l_ac].pml85  = g_pml2.pml85
   LET g_pml[l_ac].pml80  = g_pml2.pml80
   LET g_pml[l_ac].pml81  = g_pml2.pml81
   LET g_pml[l_ac].pml82  = g_pml2.pml82
   LET g_pml[l_ac].pml86  = g_pml2.pml86
   LET g_pml[l_ac].pml87  = g_pml2.pml87
   LET g_pml[l_ac].pml21  = g_pml2.pml21
   LET g_pml[l_ac].pml35  = g_pml2.pml35
   LET g_pml[l_ac].pml34  = g_pml2.pml34
   LET g_pml[l_ac].pml33  = g_pml2.pml33
   LET g_pml[l_ac].pml919  = g_pml2.pml919     #FUN-A80150 add
   LET g_pml[l_ac].pml41  = g_pml2.pml41
   LET g_pml[l_ac].pml190 = g_pml2.pml190
   LET g_pml[l_ac].pml191 = g_pml2.pml191
   LET g_pml[l_ac].pml192 = g_pml2.pml192
   LET g_pml[l_ac].pml12  = g_pml2.pml12
   LET g_pml[l_ac].pml121 = g_pml2.pml121
   LET g_pml[l_ac].pml122 = g_pml2.pml122
   LET g_pml[l_ac].pml67  = g_pml2.pml67
   LET g_pml[l_ac].pml90 = g_pml2.pml90
   LET g_pml[l_ac].pml40  = g_pml2.pml40
   LET g_pml[l_ac].pml401 = g_pml2.pml401
   LET g_pml[l_ac].pml31  = g_pml2.pml31
   LET g_pml[l_ac].pml31t = g_pml2.pml31t
   LET g_pml[l_ac].pml930 = g_pml2.pml930
   LET g_pml[l_ac].pml06  = g_pml2.pml06
   LET g_pml[l_ac].pml38  = g_pml2.pml38
   LET g_pml[l_ac].pml16  = g_pml2.pml16    #FUN-990080
   LET g_pml[l_ac].pml11  = g_pml2.pml11
   LET g_pml[l_ac].pml123 = g_pml2.pml123 #FUN-950088 add
   LET g_pml[l_ac].pml91  = g_pml2.pml91  #No.FUN-920183
   LET g_pml[l_ac].pml05  = g_pml2.pml05  #No.FUN-B80167
#&ifdef SLK                                                       #No.FUN-B90101
#   LET g_pml[l_ac].pmlislk01 = g_pmli.pmlislk01  #No.FUN-810017  #No.FUN-B90101
#&endif                                                           #No.FUN-B90101
   LET g_pml[l_ac].pmlud01 = g_pml2.pmlud01
   LET g_pml[l_ac].pmlud02 = g_pml2.pmlud02
   LET g_pml[l_ac].pmlud03 = g_pml2.pmlud03
   LET g_pml[l_ac].pmlud04 = g_pml2.pmlud04
   LET g_pml[l_ac].pmlud05 = g_pml2.pmlud05
   LET g_pml[l_ac].pmlud06 = g_pml2.pmlud06
   LET g_pml[l_ac].pmlud07 = g_pml2.pmlud07
   LET g_pml[l_ac].pmlud08 = g_pml2.pmlud08
   LET g_pml[l_ac].pmlud09 = g_pml2.pmlud09
   LET g_pml[l_ac].pmlud10 = g_pml2.pmlud10
   LET g_pml[l_ac].pmlud11 = g_pml2.pmlud11
   LET g_pml[l_ac].pmlud12 = g_pml2.pmlud12
   LET g_pml[l_ac].pmlud13 = g_pml2.pmlud13
   LET g_pml[l_ac].pmlud14 = g_pml2.pmlud14
   LET g_pml[l_ac].pmlud15 = g_pml2.pmlud15
   LET g_pml[l_ac].pml47=g_pml2.pml47
   LET g_pml[l_ac].pml48=g_pml2.pml48
   LET g_pml[l_ac].pml49=g_pml2.pml49
   LET g_pml[l_ac].pml50=g_pml2.pml50
   LET g_pml[l_ac].pml51=g_pml2.pml51
   LET g_pml[l_ac].pml52=g_pml2.pml52
   LET g_pml[l_ac].pml53=g_pml2.pml53
   LET g_pml[l_ac].pml54=g_pml2.pml54
   LET g_pml[l_ac].pml55=g_pml2.pml55
   LET g_pml[l_ac].pml56=g_pml2.pml56
#FUN-B90101 add &endif
END FUNCTION

FUNCTION t420_b_move_back()
#FUN-B90101--add--begin--
#FUN-B90101--add--end--
   LET g_pml2.pml02  = g_pml[l_ac].pml02
   LET g_pml2.pml24  = g_pml[l_ac].pml24
   LET g_pml2.pml25  = g_pml[l_ac].pml25
   LET g_pml2.pml04  = g_pml[l_ac].pml04
   LET g_pml2.pml041 = g_pml[l_ac].pml041
   LET g_pml2.pml07  = g_pml[l_ac].pml07
   IF g_pml2.pml08 IS NULL THEN
      SELECT ima25
        INTO g_pml2.pml08
        FROM ima_file
       WHERE ima01=g_pml[l_ac].pml04
   END IF
   LET g_pml2.pml20  = g_pml[l_ac].pml20
   LET g_pml2.pml83  = g_pml[l_ac].pml83
   LET g_pml2.pml84  = g_pml[l_ac].pml84
   LET g_pml2.pml85  = g_pml[l_ac].pml85
   LET g_pml2.pml80  = g_pml[l_ac].pml80
   LET g_pml2.pml81  = g_pml[l_ac].pml81
   LET g_pml2.pml82  = g_pml[l_ac].pml82
   LET g_pml2.pml86  = g_pml[l_ac].pml86
   LET g_pml2.pml87  = g_pml[l_ac].pml87
   LET g_pml2.pml21  = g_pml[l_ac].pml21
   IF cl_null(g_pml2.pml21) THEN LET g_pml2.pml21 = 0 END IF #TQC-730022
   LET g_pml2.pml35  = g_pml[l_ac].pml35
   LET g_pml2.pml34  = g_pml[l_ac].pml34
   LET g_pml2.pml33  = g_pml[l_ac].pml33
   LET g_pml2.pml919  = g_pml[l_ac].pml919     #FUN-A80150 add
   LET g_pml2.pml41  = g_pml[l_ac].pml41
   LET g_pml2.pml190 = g_pml[l_ac].pml190
   LET g_pml2.pml191 = g_pml[l_ac].pml191
   LET g_pml2.pml192 = g_pml[l_ac].pml192
   LET g_pml2.pml12  = g_pml[l_ac].pml12
   LET g_pml2.pml121 = g_pml[l_ac].pml121
   LET g_pml2.pml122 = g_pml[l_ac].pml122
   LET g_pml2.pml67  = g_pml[l_ac].pml67
   LET g_pml2.pml90 = g_pml[l_ac].pml90
   LET g_pml2.pml40  = g_pml[l_ac].pml40
   LET g_pml2.pml401 = g_pml[l_ac].pml401
   LET g_pml2.pml31  = g_pml[l_ac].pml31
   LET g_pml2.pml31t = g_pml[l_ac].pml31t
   LET g_pml2.pml930 = g_pml[l_ac].pml930
   LET g_pml2.pml06  = g_pml[l_ac].pml06
   LET g_pml2.pml38  = g_pml[l_ac].pml38
   LET g_pml2.pml16  = g_pml[l_ac].pml16    #FUN-990080
   LET g_pml2.pml11  = g_pml[l_ac].pml11
   LET g_pml2.pml123 = g_pml[l_ac].pml123 #FUN-950088 add
   LET g_pml2.pml91  = g_pml[l_ac].pml91  #No.FUN-920183
   LET g_pml2.pml05  = g_pml[l_ac].pml05  #No.FUN-B80167
#&ifdef SLK                                                          #FUN-B90101
#   LET g_pmli.pmlislk01 = g_pml[l_ac].pmlislk01   #No.FUN-810017    #FUN-B90101
#&endif                                                              #FUN-B90101
   LET g_pml2.pmlud01 = g_pml[l_ac].pmlud01
   LET g_pml2.pmlud02 = g_pml[l_ac].pmlud02
   LET g_pml2.pmlud03 = g_pml[l_ac].pmlud03
   LET g_pml2.pmlud04 = g_pml[l_ac].pmlud04
   LET g_pml2.pmlud05 = g_pml[l_ac].pmlud05
   LET g_pml2.pmlud06 = g_pml[l_ac].pmlud06
   LET g_pml2.pmlud07 = g_pml[l_ac].pmlud07
   LET g_pml2.pmlud08 = g_pml[l_ac].pmlud08
   LET g_pml2.pmlud09 = g_pml[l_ac].pmlud09
   LET g_pml2.pmlud10 = g_pml[l_ac].pmlud10
   LET g_pml2.pmlud11 = g_pml[l_ac].pmlud11
   LET g_pml2.pmlud12 = g_pml[l_ac].pmlud12
   LET g_pml2.pmlud13 = g_pml[l_ac].pmlud13
   LET g_pml2.pmlud14 = g_pml[l_ac].pmlud14
   LET g_pml2.pmlud15 = g_pml[l_ac].pmlud15
   LET g_pml2.pml47=g_pml[l_ac].pml47
   LET g_pml2.pml48=g_pml[l_ac].pml48
   LET g_pml2.pml49=g_pml[l_ac].pml49
   LET g_pml2.pml50=g_pml[l_ac].pml50
   LET g_pml2.pml51=g_pml[l_ac].pml51
   LET g_pml2.pml52=g_pml[l_ac].pml52
   LET g_pml2.pml53=g_pml[l_ac].pml53
   LET g_pml2.pml54=g_pml[l_ac].pml54
   LET g_pml2.pml55=g_pml[l_ac].pml55
   LET g_pml2.pml56=g_pml[l_ac].pml56
#FUN-B90101 add &endif
END FUNCTION

FUNCTION t420_bud(p_cmd,p_flag)
  DEFINE p_cmd       LIKE type_file.chr1
  DEFINE p_flag      LIKE type_file.chr1
  DEFINE p_sum1      LIKE afc_file.afc06
  DEFINE p_sum2      LIKE afc_file.afc06
  DEFINE l_flag      LIKE type_file.num5
  DEFINE l_msg       LIKE ze_file.ze03
  DEFINE l_over      LIKE afc_file.afc07
  DEFINE l_afb07     LIKE afb_file.afb07
  DEFINE l_aag23     LIKE aag_file.aag23  #CHI-A40021 add
  DEFINE l_pml121    LIKE pml_file.pml121 #CHI-A40021 add
  DEFINE l_pml12     LIKE pml_file.pml12  #CHI-A40021 add

  LET g_errno = ''
  IF g_smy.smy59 <> 'Y' THEN RETURN END IF

  IF g_aza.aza08 = 'N' THEN
     LET g_pml[l_ac].pml12 = ' '
     LET g_pml[l_ac].pml121= ' '
  END IF
  IF g_bookno1 IS NULL OR g_pml[l_ac].pml90 IS NULL OR
     g_pml[l_ac].pml40 IS NULL OR g_pml[l_ac].pml33 IS NULL OR
     g_pml[l_ac].pml121 IS NULL OR g_pml[l_ac].pml67 IS NULL OR
     g_pml[l_ac].pml12 IS NULL THEN
     RETURN
  END IF

  IF g_aaz.aaz90 = 'Y' THEN
     IF g_pml[l_ac].pml930 IS NULL THEN
        RETURN
     END IF
  END IF
  IF g_aza.aza63 = 'Y' THEN
     IF g_bookno2 IS NULL OR g_pml[l_ac].pml401 IS NULL THEN
        RETURN
     END IF
  END IF

  #MOD-C10008 ----- add start -----
  IF cl_null(g_pmk.pmk42) THEN
     LET p_sum1 = g_pml_t.pml87 * g_pml_t.pml31
     LET p_sum2 = g_pml[l_ac].pml87 * g_pml[l_ac].pml31
  ELSE
  #MOD-C10008 ----- add end -----
     LET p_sum1 = g_pml_t.pml87 * g_pml_t.pml31 * g_pmk.pmk42
     LET p_sum2 = g_pml[l_ac].pml87 * g_pml[l_ac].pml31 * g_pmk.pmk42
  END IF #MOD-C10008 add
  IF cl_null(p_sum1) THEN LET p_sum1 = 0 END IF
  IF cl_null(p_sum2) THEN LET p_sum2 = 0 END IF

  #CHI-A40021 add --start--
  SELECT aag23 INTO l_aag23 FROM  aag_file
   WHERE aag00=g_bookno1
     AND aag01=g_pml[l_ac].pml40
  IF l_aag23='Y' THEN
     LET l_pml121 = g_pml[l_ac].pml121
     LET l_pml12 = g_pml[l_ac].pml12
  ELSE
     LET l_pml121 = ' '
     LET l_pml12 = ' '
  END IF
  #CHI-A40021 add --end--
  IF p_flag = '1' OR p_flag = '3' THEN
     IF g_aaz.aaz90='Y' THEN
        CALL s_budchk1(g_bookno1,g_pml[l_ac].pml90,g_pml[l_ac].pml40,
                       g_pmk.pmk31,l_pml121,   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml930,l_pml12,          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'0',p_cmd,0,p_sum2)   #MOD-A30154
             RETURNING l_flag,l_afb07,l_over
        IF l_flag = FALSE THEN
           LET l_msg = g_bookno1,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml40,'/',
                       g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml930,'/',l_pml12,'/',          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'/',l_over   #MOD-A30154
           CALL cl_err(l_msg,g_errno,1)
           RETURN
        ELSE
           IF l_afb07 = '2' AND l_over < 0 THEN
              LET l_msg = g_bookno1,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml40,'/',
                          g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                          g_pml[l_ac].pml930,'/',l_pml12,'/',          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                          g_pmk.pmk32,'/',l_over   #MOD-A30154
              CALL cl_err(l_msg,g_errno,1)
              LET g_errno =' '
           END IF
        END IF
     ELSE
        CALL s_budchk1(g_bookno1,g_pml[l_ac].pml90,g_pml[l_ac].pml40,
                       g_pmk.pmk31,l_pml121,   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml67,l_pml12,           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'0',p_cmd,0,p_sum2)   #MOD-A30154
             RETURNING l_flag,l_afb07,l_over
        IF l_flag = FALSE THEN
           LET l_msg = g_bookno1,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml40,'/',
                       g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml67,'/',l_pml12,'/',           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'/',l_over    #MOD-A30154
           CALL cl_err(l_msg,g_errno,1)
           RETURN
        ELSE
           IF l_afb07 = '2' AND l_over < 0 THEN
              LET l_msg = g_bookno1,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml40,'/',
                          g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                          g_pml[l_ac].pml67,'/',l_pml12,'/',           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                          g_pmk.pmk32,'/',l_over    #MOD-A30154
              CALL cl_err(l_msg,g_errno,1)
              LET g_errno =' '
           END IF
        END IF
     END IF
  END IF

  IF g_aza.aza63 = 'N' THEN RETURN END IF
  IF p_flag = '2' OR p_flag = '3' THEN
     IF g_aaz.aaz90='Y' THEN
        #CHI-A40021 add --start--
        SELECT aag23 INTO l_aag23 FROM  aag_file
         WHERE aag00=g_bookno2
           AND aag01=g_pml[l_ac].pml401
        IF l_aag23='Y' THEN
           LET l_pml121 = g_pml[l_ac].pml121
           LET l_pml12 = g_pml[l_ac].pml12
        ELSE
           LET l_pml121 = ' '
           LET l_pml12 = ' '
        END IF
        #CHI-A40021 add --end--
        IF g_bookno2 IS NULL OR g_pml[l_ac].pml90 IS NULL OR
           g_pml[l_ac].pml401 IS NULL OR g_pml[l_ac].pml33 IS NULL OR
           g_pml[l_ac].pml121 IS NULL OR g_pml[l_ac].pml930 IS NULL OR
           g_pml[l_ac].pml12 IS NULL THEN
           RETURN
        END IF
        CALL s_budchk1(g_bookno2,g_pml[l_ac].pml90,g_pml[l_ac].pml401,
                       g_pmk.pmk31,l_pml121,   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml930,l_pml12,          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'1',p_cmd,0,p_sum2)    #MOD-A30154
             RETURNING l_flag,l_afb07,l_over
        IF l_flag = FALSE THEN
           LET l_msg = g_bookno2,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml401,'/',
                       g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml930,'/',l_pml12,'/',          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'/',l_over    #MOD-A30154
           CALL cl_err(l_msg,g_errno,1)
           RETURN
        ELSE
           IF l_afb07 = '2' AND l_over < 0 THEN
              LET l_msg = g_bookno2,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml401,'/',
                          g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                          g_pml[l_ac].pml930,'/',l_pml12,'/',          #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                          g_pmk.pmk32,'/',l_over    #MOD-A30154
              CALL cl_err(l_msg,g_errno,1)
              LET g_errno = ' '
              RETURN
           END IF
        END IF
     ELSE
        IF g_bookno2 IS NULL OR g_pml[l_ac].pml90 IS NULL OR
           g_pml[l_ac].pml401 IS NULL OR g_pml[l_ac].pml33 IS NULL OR
           g_pml[l_ac].pml121 IS NULL OR g_pml[l_ac].pml67 IS NULL OR
           g_pml[l_ac].pml12 IS NULL THEN
           RETURN
        END IF
        CALL s_budchk1(g_bookno2,g_pml[l_ac].pml90,g_pml[l_ac].pml401,
                       g_pmk.pmk31,l_pml121,   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml67,l_pml12,           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'1',p_cmd,0,p_sum2)    #MOD-A30154
             RETURNING l_flag,l_afb07,l_over
        IF l_flag = FALSE THEN
           LET l_msg = g_bookno2,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml401,'/',
                       g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                       g_pml[l_ac].pml67,'/',l_pml12,'/',           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                       g_pmk.pmk32,'/',l_over    #MOD-A30154
           CALL cl_err(l_msg,g_errno,1)
           RETURN
        ELSE
           IF l_afb07 = '2' AND l_over < 0 THEN
              LET l_msg = g_bookno2,'/',g_pml[l_ac].pml90,'/',g_pml[l_ac].pml401,'/',
                          g_pmk.pmk31,'/',l_pml121,'/',   #MOD-A30154  #CHI-A40021 mod g_pml[l_ac].pml121->l_pml121
                          g_pml[l_ac].pml67,'/',l_pml12,'/',           #CHI-A40021 mod g_pml[l_ac].pml12->l_pml12
                          g_pmk.pmk32,'/',l_over    #MOD-A30154
              CALL cl_err(l_msg,g_errno,1)
              LET g_errno = ' '
              RETURN
           END IF
        END IF
     END IF
  END IF
  RETURN

END FUNCTION

FUNCTION t420_upd_oeb28(l_cmd,l_pml02)
    DEFINE l_oeb28    LIKE oeb_file.oeb28,
           l_oeb28_o  LIKE oeb_file.oeb28,   #MOD-C10218
           l_pml02    LIKE pml_file.pml02,
           l_pml20    LIKE pml_file.pml20,
           l_pml24    LIKE pml_file.pml24,
           l_pml25    LIKE pml_file.pml25,
           l_cmd      LIKE type_file.chr5,
           l_oeb27    LIKE oeb_file.oeb27,   #MOD-8C0134
           l_oeb12    LIKE oeb_file.oeb12,   #MOD-C10218
           l_msg      STRING                 #MOD-C10218

   IF g_pmk.pmk46 <> '3' THEN
      RETURN
   END IF
   LET l_pml20 = 0
   LET g_sql = "SELECT pml20,pml24,pml25 ",
                " FROM pml_file ",
                " WHERE pml01= '",g_pmk.pmk01,"'",
                "   AND pml02= '",l_pml02,"'"
   PREPARE t420_pml_b FROM g_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('prepare:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
   DECLARE t420_pml_bc CURSOR FOR t420_pml_b
   OPEN t420_pml_bc
   FETCH t420_pml_bc INTO l_pml20,l_pml24,l_pml25
   IF cl_null(l_pml24) AND (cl_null(l_pml25) OR l_pml25=0) THEN
      RETURN
   END IF
      SELECT SUM(pml20) INTO l_oeb28
        FROM pml_file,pmk_file
       WHERE pml24 = l_pml24
         AND pml25 = l_pml25
         AND pml01 = pmk01
         AND pmk18 <> 'X'
         AND pml16 <> '9'
      IF cl_null(l_oeb28) THEN LET l_oeb28 = 0 END IF   #MOD-8C0134
      SELECT oeb12 INTO l_oeb12 FROM oeb_file
       WHERE oeb01 = l_pml24 AND oeb03 = l_pml25        #MOD-C10218
   CASE
      WHEN l_cmd = 'z'
           LET l_oeb28_o = l_oeb28           #MOD-C10218 add
           LET l_oeb28 = l_oeb28 + l_pml20   #單身修改時,sum已轉量加上還原那一筆
           #MOD-C10218 -- add start --
           IF l_oeb28 > l_oeb12 THEN
              LET l_oeb28 = l_oeb28_o
              LET l_msg = g_pmk.pmk01,'-',l_pml02,' '
               CALL cl_err(l_msg,'axm-614',1)
               LET g_success = 'N'
           END IF
           #MOD-C10218 -- add end --
      WHEN l_cmd <> 'b'
           LET l_oeb28 = l_oeb28 - l_pml20   #單身修改時,sum已轉量排除原本那一筆
   END CASE
   #更新訂單單身應以請購單身一筆一筆對應回寫
   IF l_cmd MATCHES '[rdx]' THEN
      LET l_oeb27 = NULL
   ELSE
      LET l_oeb27 = g_pmk.pmk01
   END IF
   UPDATE oeb_file set oeb27 = l_oeb27,
                       oeb28 = l_oeb28
                 WHERE oeb01 = l_pml24
                   AND oeb03 = l_pml25
   IF SQLCA.sqlcode OR sqlca.sqlerrd[3]=0 THEN
        CALL cl_err3("upd","oeb_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","NO pmk deleted from Order",0)
        LET g_success ='N'
        ROLLBACK WORK RETURN
   END IF
END FUNCTION

FUNCTION t420_update()
   SELECT SUM(pml88) INTO g_pmk.pmk40
     FROM pml_file
    WHERE pml01=g_pmk.pmk01
   IF SQLCA.sqlcode OR g_pmk.pmk40 IS NULL THEN
      LET g_pmk.pmk40=0
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file
    WHERE azi01=g_pmk.pmk22 AND aziacti='Y'
   CALL cl_digcut(g_pmk.pmk40,t_azi04) RETURNING g_pmk.pmk40
   UPDATE pmk_file SET pmk40=g_pmk.pmk40
    WHERE pmk01=g_pmk.pmk01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("upd","pmk_file",g_pmk.pmk01,"",SQLCA.sqlcode,"","update pmk40 fail :",1)
      LET g_success = 'N'
   END IF

END FUNCTION

FUNCTION t420_epr()
 DEFINE  l_wpc  RECORD LIKE  wpc_file.*
 DEFINE  l_wpc01 LIKE  wpc_file.wpc01
 DEFINE  n_wpc01 LIKE  wpc_file.wpc01
 DEFINE  s_wpc01 LIKE  type_file.num5
 DEFINE  l_month LIKE  type_file.chr3
 DEFINE  l_day   LIKE  type_file.chr3
 DEFINE  i       LIKE  type_file.num5
 DEFINE  l_cnt   LIKE  type_file.num5
 DEFINE  l_n     LIKE  type_file.num5
 DEFINE  l_count LIKE  type_file.num5
 DEFINE  l_sum   LIKE  type_file.num5
 DEFINE  l_c02   LIKE  pmk_file.pmk09
 DEFINE  l_sql   STRING
 DEFINE  l_pml33 LIKE  pml_file.pml33
 DEFINE  l_t     LIKE  type_file.num5 #No.FUN-A90009
 DEFINE  l_b     LIKE  type_file.num5 #No.FUN-A90009

  IF cl_null(g_pmk.pmk01) THEN  RETURN END IF
  IF g_pmk.pmk18 = 'N'  THEN CALL cl_err(g_pmk.pmk01,'aap-717',0)  RETURN END IF
  IF g_pmk.pmk18 = 'X'  THEN CALL cl_err(g_pmk.pmk01,'9024',0)  RETURN END IF
  IF g_pmk.pmk25 != '1' AND g_pmk.pmk25 != '2' THEN CALL cl_err(g_pmk.pmk01,'aqc-012',0)  RETURN END IF


  OPEN WINDOW p4201_w WITH FORM "apm/42f/apmt420_e"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
  CALL cl_ui_locale("apmt420_e")
  CALL cl_set_comp_visible('pml33',FALSE) #No.FUN-A90009
  LET g_renew = 1
 WHILE TRUE
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM pml_file
    WHERE pml01 = g_pmk.pmk01  #AND pml92='N'
   IF l_count = 0 THEN
      CALL cl_err(g_pmk.pmk01,'apm-136',1)
      EXIT WHILE
   END IF
   #No.FUN-A90009--begin
   #LET g_sql = " SELECT 'N',pml02,pml04,pml041,pml07,pml20 ",
   #            " FROM pml_file ",
   #            " WHERE pml01 = '",g_pmk.pmk01,"' AND pml92='N' ",
   #            " ORDER BY pml02 " CLIPPED
   IF cl_null(g_pmk.pmk09) THEN
      LET g_sql = " SELECT 'N','',pml33,pml02,pml04,pml041,pml07,(pml20-pml21) ",
                  " FROM pml_file,ima_file ",
                  " WHERE pml01 = '",g_pmk.pmk01,"' AND pml92='N' AND ima927='Y' AND ima01=pml04 ",
                  " ORDER BY pml02 " CLIPPED
   ELSE
      LET g_sql = " SELECT 'N','',pml33,pml02,pml04,pml041,pml07,(pml20-pml21) ",
                  " FROM pml_file,pmh_file,pmk_file ",
                  " WHERE pml01=pmk01 AND pml01 = '",g_pmk.pmk01,"' AND pml92='N' AND pmh25='Y' AND pmh01=pml04 AND pmh02=pmk09",
                  " ORDER BY pml02 " CLIPPED
   END IF
   #No.FUN-A90009--end
   PREPARE t420_e FROM g_sql
   IF SQLCA.sqlcode THEN
      CALL cl_err('prepare:',SQLCA.sqlcode,1)
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF

   DECLARE t420_de CURSOR FOR t420_e

   CALL g_pml1.clear()
   LET l_cnt=1
   FOREACH t420_de INTO g_pml1[l_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('preparE_e:',SQLCA.sqlcode,1) EXIT FOREACH
      END IF
      LET g_pml1[l_cnt].wpc10=(g_today+g_pml1[l_cnt].pml33)/2     #No.FUN-A90009
      LET g_pml1_t[l_cnt].* = g_pml1[l_cnt].*
      LET l_cnt = l_cnt+1
   END FOREACH
      LET g_cnt1 = l_cnt-1
   CALL g_pml1.deleteElement(l_cnt)
   INPUT ARRAY g_pml1 WITHOUT DEFAULTS FROM tb3.*
         ATTRIBUTE(INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE,UNBUFFERED)

     BEFORE ROW
         IF g_renew THEN
            LET g_ac = ARR_CURR()
         END IF
         CALL fgl_set_arr_curr(g_ac)
         LET g_renew = 1
         CALL cl_show_fld_cont()

          #No.FUN-A90009--begin
          AFTER FIELD ch
            IF g_pml1[g_ac].ch='Y' THEN
               CALL cl_set_comp_entry('wpc10',TRUE)
               LET g_pml1[g_ac].wpc10=(g_today+g_pml1[g_ac].pml33)/2
               DISPLAY BY NAME g_pml1[g_ac].wpc10
            ELSE
            	 CALL cl_set_comp_entry('wpc10',FALSE)
#           	 LET g_pml1[g_ac].wpc10=NULL               #No.FUN-A90009
#           	 DISPLAY BY NAME g_pml1[g_ac].wpc10        #No.FUN-A90009
            END IF

          ON CHANGE ch
            IF g_pml1[g_ac].ch='Y' THEN
               CALL cl_set_comp_entry('wpc10',TRUE)
               LET g_pml1[g_ac].wpc10=(g_today+g_pml1[g_ac].pml33)/2
               DISPLAY BY NAME g_pml1[g_ac].wpc10
            ELSE
             	 CALL cl_set_comp_entry('wpc10',FALSE)
#          	 LET g_pml1[g_ac].wpc10=NULL
#          	 DISPLAY BY NAME g_pml1[g_ac].wpc10
            END IF

          AFTER FIELD wpc10
            IF NOT cl_null(g_pml1[g_ac].wpc10) THEN
              #IF g_pml1[g_ac].wpc10<=g_today OR g_pml1[g_ac].wpc10 >g_pml1[g_ac].pml33 THEN  #TQC-B30010  mark
               IF g_pml1[g_ac].wpc10<g_today OR g_pml1[g_ac].wpc10 >g_pml1[g_ac].pml33 THEN   #TQC-B30010  add
                  CALL cl_err('','apm-319',1)
                  NEXT FIELD wpc10
               END IF
            END IF
          #No.FUN-A90009--end

     ON ACTION mul
        LET g_renew = 0
        CALL t420_mul()

     ON ACTION accept
        IF g_cnt1 = 0 THEN
           LET INT_FLAG = 1
           EXIT INPUT
        END IF
        IF cl_confirm('apm-135') THEN
           EXIT INPUT
        END IF

     ON ACTION cancel
        EXIT INPUT
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      EXIT WHILE
   END IF

   BEGIN WORK
   CALL s_showmsg_init()
   LET l_sum = 0
   LET g_success = 'Y'
   FOR i=1 TO l_cnt-1
    INITIALIZE g_wpc.* TO NULL
    IF g_pml1[i].ch ='Y' THEN
      LET l_n = 0
         LET l_month = "0"||MONTH(g_today)
         LET l_month = l_month[LENGTH(l_month)-1,LENGTH(l_month)]
         LET l_day = "0"||DAY(g_today)
         LET l_day = l_day[LENGTH(l_day)-1,LENGTH(l_day)]
         LET l_wpc01 = "P"||YEAR(g_today)||l_month||l_day
         SELECT MAX(wpc01) INTO n_wpc01 FROM wpc_file
          WHERE wpc01 LIKE l_wpc01||'%'
         IF cl_null(n_wpc01) THEN
            LET g_wpc.wpc01 = "0001"
         ELSE
            LET s_wpc01 = n_wpc01[LENGTH(l_wpc01)+3,LENGTH(l_wpc01)+4]+1
            LET g_wpc.wpc01 = "000"||s_wpc01
            LET g_wpc.wpc01 = g_wpc.wpc01[LENGTH(g_wpc.wpc01)-3,LENGTH(g_wpc.wpc01)]
         END IF
         LET g_wpc.wpc01 = l_wpc01 CLIPPED,g_wpc.wpc01
         LET g_wpc.wpc02 = '1'
         LET l_pml33 = ''
         SELECT  pml33 INTO l_pml33 FROM pml_file WHERE pml01 =  g_pmk.pmk01
            AND pml02 = g_pml1[i].pml02
         LET g_wpc.wpc04 = l_pml33
         LET g_wpc.wpc05 = g_pml1[i].pml04
         LET g_wpc.wpc06 = g_pml1[i].pml041
         LET g_wpc.wpc07 = g_pml1[i].pml07
         LET g_wpc.wpc08 = g_pml1[i].pml20
         LET g_wpc.wpc09 = 'N'
         LET g_wpc.wpc10=g_pml1[i].wpc10 #No.FUN-A90009
         LET g_wpc.wpc11=g_plant         #No.FUN-A90009
         IF cl_null(g_wpc.wpc08) THEN
            LET g_wpc.wpc08 = 0
         END IF
      #No.FUN-A90009--begin
      #IF  cl_null(g_pmk.pmk09) THEN
      #  LET l_sql = " SELECT c02 FROM cus_temp WHERE c01 = '",g_pml1[i].pml02,"' ",
      #              "    AND c03 = '",g_pmk.pmk01,"'"       #FUN-A10034
      #
      #  PREPARE e_pr5 FROM l_sql
      #  DECLARE e_curs5 CURSOR FOR e_pr5
      #
      #  FOREACH e_curs5 INTO l_c02
      #
      #     LET g_wpc.wpc03 = l_c02
      #     IF cl_null(g_wpc.wpc03) THEN
      #        LET g_wpc.wpc03 = ' '
      #     END IF
      #
      #     INSERT INTO wpc_file VALUES(g_wpc.*)
      #     IF STATUS OR SQLCA.SQLCODE THEN
      #        CALL s_errmsg('','','',SQLCA.sqlcode,1)
      #        LET g_success = 'N'
      #     ELSE
      #     	  CALL sendmail()
      #     	  LET l_n = l_n+1
      #     END IF
      #
      #  END FOREACH
      #END IF
      #IF l_n = 0 THEN
      #   LET	g_wpc.wpc03 =  g_pmk.pmk09
      #   IF cl_null(g_wpc.wpc03) THEN
      #      LET g_wpc.wpc03 = ' '
      #   END IF
      #
      #   INSERT INTO wpc_file VALUES(g_wpc.*)
      #   IF STATUS OR SQLCA.SQLCODE THEN
      #      CALL s_errmsg('','','',SQLCA.sqlcode,1)
      #      LET g_success = 'N'
      #   ELSE
      #   	  CALL sendmail()
      #   END IF
      #END IF
      SELECT COUNT(*) INTO l_t FROM cus_temp WHERE c01 = g_pml1[i].pml02 AND c03=g_pmk.pmk01
      IF l_t=0 THEN
         IF NOT cl_null(g_pmk.pmk09) THEN   #指定廠商
            LET	g_wpc.wpc03 =  g_pmk.pmk09
            INSERT INTO wpc_file VALUES(g_wpc.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               CALL s_errmsg('','','',SQLCA.sqlcode,1)
               LET g_success = 'N'
               CONTINUE FOR
            ELSE
            	 CALL sendmail()
            END IF
         ELSE
         	  SELECT COUNT(*) INTO l_b FROM pmh_file WHERE pmh01=g_pml1[i].pml04 AND pmh25='Y'
         	  IF l_b=0 THEN
         	     CALL s_errmsg('ima01',g_pml1[i].pml04,'','apm-320',1)
               LET g_success = 'N'
               CONTINUE FOR
         	  ELSE
         	  	 DECLARE e_cur6 CURSOR FOR SELECT pmh02 FROM pmh_file WHERE pmh01=g_pml1[i].pml04 AND pmh25='Y'
               FOREACH e_cur6 INTO l_c02
                  LET g_wpc.wpc03 = l_c02
                  INSERT INTO wpc_file VALUES(g_wpc.*)
                  IF STATUS OR SQLCA.SQLCODE THEN
                     CALL s_errmsg('','','',SQLCA.sqlcode,1)
                     LET g_success = 'N'
                     CONTINUE FOREACH
                  ELSE
                  	 CALL sendmail()
                  END IF
               END FOREACH
         	  END IF
         END IF
      ELSE #多需求
         LET l_sql = " SELECT c02 FROM cus_temp WHERE c01 = '",g_pml1[i].pml02,"' ",
                     "    AND c03 = '",g_pmk.pmk01,"'"
         PREPARE e_pr5 FROM l_sql
         DECLARE e_curs5 CURSOR FOR e_pr5
         FOREACH e_curs5 INTO l_c02
            LET g_wpc.wpc03 = l_c02
            INSERT INTO wpc_file VALUES(g_wpc.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               CALL s_errmsg('','','',SQLCA.sqlcode,1)
               LET g_success = 'N'
               CONTINUE FOREACH
            ELSE
            	 CALL sendmail()
            END IF
         END FOREACH
      END IF
      #No.FUN-A90009--end
      IF g_success='Y' THEN #No.FUN-A90009
         UPDATE pml_file SET pml92 = 'Y',pml93 = g_wpc.wpc01
          WHERE pml01 = g_pmk.pmk01 AND pml02 = g_pml1[i].pml02
      END IF                #No.FUN-A90009
      LET l_sum = l_sum+1
    END IF
   END FOR
   CALL s_showmsg()
   IF g_success = 'N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
      DELETE FROM cur_temp            #FUN-A10034
        WHERE c01 = g_pml1[i].pml02   #FUN-A10034
          AND c03 = g_pmk.pmk01       #FUN-A10034
      CALL cl_err(l_sum,'apm-137',1)
     #CALL t420_b_fill(g_wc2)
     EXIT WHILE
   END IF
  END WHILE
    CLOSE WINDOW p4201_w
 END FUNCTION

FUNCTION sendmail()
  DEFINE  l_str      STRING
  DEFINE  l_sql      STRING
  DEFINE  l_pmd07    LIKE  pmd_file.pmd07
  DEFINE  l_pmd02    LIKE  pmd_file.pmd02
  DEFINE  l_cn       LIKE  type_file.num5
  DEFINE  ls_temppath       STRING
  DEFINE  ls_filename       STRING

  WHENEVER ERROR CALL cl_err_msg_log
  LET ls_temppath = FGL_GETENV("TEMPDIR")
  LET ls_filename = ls_temppath.trim(),"/apmt420_" || FGL_GETPID() || ".htm"


  INITIALIZE g_xml.* TO NULL

  LET g_xml.subject = "鼎新電腦股份有份公司-採購需求發佈通知"
  LET l_pmd07 = ''
  LET l_str = ''
  LET l_cn = 0
  IF NOT cl_null(g_wpc.wpc03) THEN
#No.TQC-B20184   begin
#    SELECT pmd07,pmd02 INTO l_pmd07,l_pmd02  FROM pmd_file
#     WHERE pmd07 IS NOT NULL AND pmd08 = 'Y' AND pmd01 = g_wpc.wpc03
#    IF NOT cl_null(l_pmd07) THEN
#       LET l_str = l_pmd07,":",l_pmd02  CLIPPED
#    END IF
     LET l_sql = "SELECT pmd07,pmd02 FROM pmd_file WHERE pmd07 IS NOT NULL AND pmd08 = 'Y' AND pmd01 = '",g_wpc.wpc03,"'"
     PREPARE pmd_pr2 FROM l_sql
     DECLARE pmd_curs2 CURSOR FOR pmd_pr2
     FOREACH pmd_curs2 INTO l_pmd07,l_pmd02
        IF l_cn = 0 THEN
           LET l_str = l_pmd07,":",l_pmd02  CLIPPED
        ELSE
           LET l_str = l_str,";",l_pmd07,":",l_pmd02  CLIPPED
        END IF
        LET l_cn = l_cn + 1
     END FOREACH
#No.TQC-B20184   end

#No.FUN-A90009--begin
#  ELSE
#     LET l_sql = " SELECT pmd07,pmd02 FROM pmd_file,wpa_file WHERE pmd07 IS NOT NULL ",
#                 "    AND pmd08 = 'Y' AND pmd01 = wpa01 AND wpa02 ='Y' "
#     PREPARE pmd_pr2 FROM l_sql
#     DECLARE pmd_curs2 CURSOR FOR pmd_pr2
#     FOREACH pmd_curs2 INTO l_pmd07,l_pmd02
#        IF l_cn = 0 THEN
#           LET l_str = l_pmd07,":",l_pmd02  CLIPPED
#        ELSE
#           LET l_str = l_str,";",l_pmd07,":",l_pmd02  CLIPPED
#        END IF
#        LET l_cn = l_cn +1
#     END FOREACH
#No.FUN-A90009--end
  END IF
  LET g_xml.body      = ls_filename.trim()
  LET g_xml.sender    = "tiptop@dsc.com.tw:top30"
  LET g_xml.recipient = l_str.trim()
  LET g_channel = base.Channel.create()
  CALL g_channel.openFile( ls_filename CLIPPED, "a" )
  CALL g_channel.setDelimiter("")

  CALL t420_head()
  CALL t420_detail()
  CALL t420_tail()

  CALL g_channel.close()

  CALL cl_jmail()

  RUN "rm -f " || ls_filename

  RUN "rm -f " || FGL_GETPID() || ".xml"

END FUNCTION

FUNCTION t420_mul()
  DEFINE   l_sql           STRING
  DEFINE   l_cn            LIKE   type_file.num5
  DEFINE   l_allow_insert  LIKE   type_file.num5
  DEFINE   l_allow_delete  LIKE   type_file.num5
  DEFINE   l_count         LIKE   type_file.num5
  DEFINE   l_pmk09_t       LIKE   pmk_file.pmk09
  DEFINE   l_c             LIKE   type_file.num5

    IF g_cnt1 = 0 THEN
       RETURN
    END IF
   IF g_ac = 0 THEN
      CALL cl_err('','apm-140',0)
   END IF
    IF g_pml1[g_ac].ch <> 'Y' THEN
       CALL cl_err('','apm-138',1)
       RETURN
    END IF
    IF NOT cl_null(g_pmk.pmk09) THEN
       CALL cl_err('','apm-139',1)
       RETURN
    END IF
    CALL g_c.clear()
    LET l_c = 1
    LET l_sql = " SELECT c02 FROM cus_temp WHERE c01 = '",g_pml1[g_ac].pml02,"' ",
                "    AND c03 = '",g_pmk.pmk01,"'"        #FUN-A10034

    PREPARE cus_pre  FROM l_sql
    DECLARE cus_d CURSOR FOR cus_pre

    FOREACH cus_d INTO g_c[l_c].pmk09
       SELECT pmc03 INTO g_c[l_c].pmc03 FROM pmc_file
        WHERE pmc01 = g_c[l_c].pmk09
        LET l_c=l_c+1
    END FOREACH
    LET g_rec_b1 = l_c-1
    CALL g_c.deleteElement(l_c)


    OPEN WINDOW t420_w2 WITH FORM "apm/42f/apmt420_m"
      ATTRIBUTE(STYLE=g_win_style)
    CALL cl_ui_locale("apmt420_m")
    DISPLAY  g_pml1[g_ac].pml02  TO FORMONLY.pml02


    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
    INPUT ARRAY g_c WITHOUT DEFAULTS FROM tb4.*
        ATTRIBUTE(COUNT=g_rec_b1,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)
        BEFORE ROW
             LET l_cn = ARR_CURR()
             LET  l_pmk09_t = g_c[l_cn].pmk09
        AFTER FIELD pmk09
             IF NOT cl_null(g_c[l_cn].pmk09) THEN
                CALL t420_pmk09(g_c[l_cn].pmk09)
                IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_c[l_cn].pmk09,g_errno,0)
                  LET g_c[l_cn].pmk09  = l_pmk09_t
                  DISPLAY g_c[l_cn].pmk09 TO pmk09
                  NEXT FIELD pmk09
                END IF
               IF l_pmk09_t <> g_c[l_cn].pmk09  THEN
                LET l_count = 0
                SELECT COUNT(*) INTO l_count FROM cus_temp
                 WHERE c02 = g_c[l_cn].pmk09
                   AND c01 = g_pml1[g_ac].pml02
                   AND c03 = g_pmk.pmk01       #FUN-A10034
                IF l_count > 0 THEN
                   CALL cl_err('','aec-009',0)
                   NEXT FIELD  pmk09
                END IF
               END IF
                SELECT pmc03 INTO g_c[l_cn].pmc03 FROM pmc_file
                 WHERE pmc01 = g_c[l_cn].pmk09
                DISPLAY g_c[l_cn].pmc03 TO pmc03
             END IF
        BEFORE DELETE                      #是否取消單身
           DISPLAY "BEFORE DELETE"

              IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
              END IF

              DELETE FROM cus_temp
               WHERE c02 = g_c[l_cn].pmk09
                 AND c01 = g_pml1[g_ac].pml02
                #AND c03 = g_pmk.pmk09        #No.FUN-A10034
                 AND c03 = g_pmk.pmk01        #No.TQC-B20184
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","cus_file",'','',SQLCA.sqlcode,"","",1)
                 CANCEL DELETE
              ELSE
                 LET g_rec_b1=g_rec_b1-1
              END IF

       AFTER INSERT
           DISPLAY "AFTER INSERT!"
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              CANCEL INSERT
           END IF

         # INSERT INTO cus_temp VALUES(g_pm1[g_ac].pml02,g_c[l_cn].pmk09,g_pmk.pmk01)   #No.TQC-B20184  mark
           INSERT INTO cus_temp VALUES(g_pml1[g_ac].pml02,g_c[l_cn].pmk09,g_pmk.pmk01)  #No.TQC-B20184  add
           IF SQLCA.sqlcode THEN
              CALL cl_err3("ins","cus_temp",'','',SQLCA.sqlcode,"","",1)
              CANCEL INSERT
           ELSE
           	   LET g_rec_b1=g_rec_b1+1
           END IF

        ON ROW CHANGE
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              LET g_c[l_cn].pmk09 = l_pmk09_t
              EXIT INPUT
           END IF

              UPDATE cus_temp SET  c02 = g_c[l_cn].pmk09  WHERE c01 = g_pml1[g_ac].pml02
                AND c02 = l_pmk09_t
               #AND c03 = g_pmk.pmk09            #FUN-A10034 #TQC-B20184 mark
                AND c03 = g_pmk.pmk01            #TQC-B20184 add
              IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                 CALL cl_err3("upd","cus_file",'','',SQLCA.sqlcode,"","",1)
                 LET g_c[l_cn].pmk09 = l_pmk09_t
              ELSE
                 MESSAGE 'UPDATE O.K'
              END IF

      ON ACTION CONTROLP
            CASE
               WHEN INFIELD(pmk09)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_pmk09"
                    LET g_qryparam.default1 = g_c[l_cn].pmk09
                    CALL cl_create_qry() RETURNING g_c[l_cn].pmk09
                    DISPLAY g_c[l_cn].pmk09 TO pmk09
                    SELECT pmc03 INTO g_c[l_cn].pmc03 FROM pmc_file
                     WHERE pmc01 = g_c[l_cn].pmk09
                    DISPLAY g_c[l_cn].pmc03 TO pmc03
                    NEXT FIELD pmk09
            END CASE


    END INPUT
    CLOSE WINDOW t420_w2
END FUNCTION

FUNCTION t420_pmk09(p_wpa01)
  DEFINE  p_wpa01   LIKE  wpa_file.wpa01
  DEFINE  l_wpa01   LIKE  wpa_file.wpa01
  DEFINE  l_wpa02   LIKE  wpa_file.wpa02
    LET g_errno = ' '
    SELECT DISTINCT wpa01,wpa02 INTO l_wpa01,l_wpa02 FROM wpa_file
     WHERE wpa01 = p_wpa01
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'aom-061'
                               LET l_wpa01 = NULL
                               LET l_wpa02 = NULL
         WHEN l_wpa02<>'Y'     LET g_errno = '9028'
                               LET l_wpa01 = NULL
                               LET l_wpa02 = NULL
         OTHERWISE             LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
END FUNCTION

FUNCTION t420_head()
   DEFINE l_codeset STRING
   DEFINE l_lang    STRING

   CASE g_lang
      WHEN '0'
         LET l_lang = "zh-tw"
      WHEN '2'
         LET l_lang = "zh-cn"
      OTHERWISE
         LET l_lang = "en"
   END CASE
   LET l_codeset = "UTF-8"

   LET g_tmpstr ='<html><head>                                                               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<meta http-equiv="Content-Language" content="',l_lang,'">                  ' CALL g_channel.write(g_tmpstr.trimRight()) #No.FUN-740189
   LET g_tmpstr ='<meta http-equiv="Content-Type" content="text/html; charset=',l_codeset,'">' CALL g_channel.write(g_tmpstr.trimRight()) #No.FUN-740189
   LET g_tmpstr ='<title>',g_xml.subject CLIPPED,'</title>                                   ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<style><!--                                                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='div.Section1                                                               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      {page:Section1;}                                                     ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr =' p.MsoNormal                                                               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      {mso-style-parent:"";                                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      margin-bottom:.0001pt;                                               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      font-size:12.0pt;                                                    ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      font-family:新細明體;                                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      margin-left:0cm; margin-right:0cm; margin-top:0cm}                   ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='span.GramE                                                                 ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      {}  -->                                                              ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</style></head><body>                                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      <div class="Section1">                                               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      <p class="MsoNormal">                                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      <span style="COLOR: #000000; FONT-FAMILY: 新細明體; font-weight:700">' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      <font size="4"><i></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;        ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='      ',g_xml.subject CLIPPED,'</font></span></p></div>                    ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<p class="MsoNormal">　</p>                                                ' CALL g_channel.write(g_tmpstr.trimRight())

END FUNCTION

FUNCTION t420_detail()

   DEFINE ls_zl15    STRING

   LET g_tmpstr ='<table border="1" style="border-collapse: collapse" width="680" id="table2">               ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<tr><td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b>                                                       ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <font color="#FFFF00" size="2">需求單號</font></b></td>                                ' CALL g_channel.write(g_tmpstr.trimRight())

   LET ls_zl15 = g_wpc.wpc01 CLIPPED
   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',ls_zl15.trim(),'</font></td>         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr><tr>                                                                                  ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b>                                                       ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <font color="#FFFF00" size="2">需求日期</font></b></td>                                ' CALL g_channel.write(g_tmpstr.trimRight())

   LET ls_zl15 = g_wpc.wpc04 CLIPPED
   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',ls_zl15.trim(),'</font></td>         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr><tr>' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b><font color="#FFFF00" size="2">料件編號</font></b></td>' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',g_wpc.wpc05 CLIPPED,'</font></td>      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr><tr>                                                                                  ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b>                                                       ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <font color="#FFFF00" size="2">品名規格</font></b></td>                                ' CALL g_channel.write(g_tmpstr.trimRight())

   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',g_wpc.wpc06 CLIPPED,'</font></td> ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr><tr>                                                                                  ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b>                                                       ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <font color="#FFFF00" size="2">需求單位</font></b></td>                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',g_wpc.wpc07 CLIPPED,'</font></td> ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr><tr>                                                                                  ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="100" bgcolor="#000080" align="center">                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><b>                                                       ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <font color="#FFFF00" size="2">需求數量</font></b></td>                                ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td><p style="line-height: 150%"><font size="2">',g_wpc.wpc08 CLIPPED,'</font></td> ' CALL g_channel.write(g_tmpstr.trimRight())

   LET g_tmpstr ='</tr></table><p class="MsoNormal"></p>                                                     ' CALL g_channel.write(g_tmpstr.trimRight())

END FUNCTION

FUNCTION t420_tail()

   DEFINE l_time      DATETIME YEAR TO SECOND
   DEFINE lc_zx02     LIKE zx_file.zx02

   LET g_tmpstr ='<p class="MsoNormal"> </p>                                                    ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<table border="1" style="border-collapse: collapse" width="680" id="table3">  ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<tr><td width="50%" bgcolor="#000080" align="center">                         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><font color="#FFFF00" size="2">              ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    寄發人員</font></td>                                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="50%" bgcolor="#000080" align="center">                         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <p style="line-height: 150%"><font color="#FFFF00" size="2">              ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    寄發時間</font></td>                                                      ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr>                                                                         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='<tr><td width="50%" align="center">                                           ' CALL g_channel.write(g_tmpstr.trimRight())
   SELECT zx02 INTO lc_zx02 FROM zx_file WHERE zx01=g_user
   LET g_tmpstr ='    <p style="line-height: 150%"><font size="2">',g_user CLIPPED,' / ',lc_zx02 CLIPPED,'</font></td>' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='    <td width="50%" align="center">                                           ' CALL g_channel.write(g_tmpstr.trimRight())

   LET l_time = CURRENT YEAR TO SECOND

   LET g_tmpstr ='    <p style="line-height: 150%"><font size="2">',l_time CLIPPED,'</font></td>' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</tr>                                                                         ' CALL g_channel.write(g_tmpstr.trimRight())
   LET g_tmpstr ='</table></body></html>                                                        ' CALL g_channel.write(g_tmpstr.trimRight())

END FUNCTION

#FUN-BB0086--add--begin--
FUNCTION t420_pml20_check(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1

   IF NOT cl_null(g_pml[l_ac].pml20) AND NOT cl_null(g_pml[l_ac].pml07) THEN
      IF cl_null(g_pml_t.pml20) OR cl_null(g_pml07_t) OR g_pml_t.pml20 != g_pml[l_ac].pml20 OR g_pml07_t != g_pml[l_ac].pml07 THEN
         LET g_pml[l_ac].pml20=s_digqty(g_pml[l_ac].pml20,g_pml[l_ac].pml07)
         DISPLAY BY NAME g_pml[l_ac].pml20
      END IF
   END IF

   IF g_pml_t.pml20 IS NULL AND g_pml[l_ac].pml20 IS NOT NULL OR
      g_pml_t.pml20 IS NOT NULL AND g_pml[l_ac].pml20 IS NULL OR
      g_pml_t.pml20 <> g_pml[l_ac].pml20 THEN
      LET g_change='Y'
   END IF
   IF NOT cl_null(g_pml[l_ac].pml20) THEN
      IF g_pml[l_ac].pml20 <= 0  THEN
         CALL cl_err(g_pml[l_ac].pml20,'mfg0013',1)
         LET g_pml[l_ac].pml20 = g_pml_o.pml20
         RETURN FALSE
      END IF
       IF p_cmd = 'u' THEN
          IF g_pml[l_ac].pml20 < g_pml[l_ac].pml21 THEN
             CALL cl_err(g_pml[l_ac].pml20,'mfg3082',1)
             LET g_pml[l_ac].pml20 = g_pml_t.pml20
             RETURN FALSE
          END IF
       END IF
       IF (cl_null(g_pml_o.pml20) OR g_pml[l_ac].pml20 != g_pml_o.pml20 )
          AND (g_no[1,4] != 'MISC') THEN
         #CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang) #CHI-C10037 mark
          CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang,g_pml[l_ac].pml07) #CHI-C10037 add
           RETURNING g_pml[l_ac].pml20
       END IF
       DISPLAY BY NAME g_pml[l_ac].pml20
       #for專案
       IF NOT cl_null(g_pml[l_ac].pml12)
          AND NOT cl_null(g_pml[l_ac].pml121)
          AND NOT cl_null(g_pml[l_ac].pml122)
          AND g_pml[l_ac].pml12 != ' '
          AND g_pml[l_ac].pml121 != ' '
          AND g_pml[l_ac].pml122 != ' '
       THEN
          IF cl_null(g_pml_t.pml20) THEN LET g_pml_t.pml20=0 END IF
          CALL t420_chk_pjf05(g_pml[l_ac].pml121,g_pml[l_ac].pml04,g_pml_t.pml20)
          IF NOT cl_null(g_errno) THEN CALL cl_err('',g_errno,'1') END IF
       END IF
       LET g_pml2.pml20 = g_pml[l_ac].pml20
       LET g_pml_o.pml20 = g_pml[l_ac].pml20
       IF cl_null(g_pml[l_ac].pml86) THEN
          LET g_pml[l_ac].pml86=g_pml[l_ac].pml07
          LET g_pml[l_ac].pml87=g_pml[l_ac].pml20
          DISPLAY BY NAME g_pml[l_ac].pml86
          DISPLAY BY NAME g_pml[l_ac].pml87
       END IF
       CALL t420_set_required() #FUN-810045 add
       IF g_change='Y' THEN
          CALL t420_set_pml87()
         IF g_sma.sma116 MATCHES '[02]' THEN
            LET g_pml[l_ac].pml87 = g_pml[l_ac].pml20
         END IF
          DISPLAY BY NAME g_pml[l_ac].pml87
         CALL t420_bud(p_cmd,'3')
         IF NOT cl_null(g_errno) THEN
            RETURN FALSE
         END IF
       END IF
   END IF
   RETURN TRUE
END FUNCTION

FUNCTION t420_pml82_check(p_cmd,l_flag)
   DEFINE p_cmd,l_flag  LIKE type_file.chr1
   IF NOT cl_null(g_pml[l_ac].pml82) AND NOT cl_null(g_pml[l_ac].pml80) THEN
      IF cl_null(g_pml_t.pml82) OR cl_null(g_pml80_t) OR g_pml_t.pml82 != g_pml[l_ac].pml82 OR g_pml80_t != g_pml[l_ac].pml80 THEN
         LET g_pml[l_ac].pml82=s_digqty(g_pml[l_ac].pml82,g_pml[l_ac].pml80)
         DISPLAY BY NAME g_pml[l_ac].pml82
      END IF
   END IF

   IF g_pml_t.pml82 IS NULL AND g_pml[l_ac].pml82 IS NOT NULL OR
      g_pml_t.pml82 IS NOT NULL AND g_pml[l_ac].pml82 IS NULL OR
      g_pml_t.pml82 <> g_pml[l_ac].pml82 THEN
      LET g_change='Y'
   END IF
   IF NOT cl_null(g_pml[l_ac].pml82) THEN
      IF g_pml[l_ac].pml82 < 0 THEN
         CALL cl_err('','aim-391',0)  #
         RETURN FALSE,'pml82'
      END IF
      LET g_pml2.pml82 = g_pml[l_ac].pml82
      LET g_pml_o.pml82 = g_pml[l_ac].pml82
   END IF
   CALL t420_set_origin_field()
   IF g_pml[l_ac].pml07 = g_pml2.pml08 THEN
      LET g_pml2.pml09 = 1
   ELSE
      IF ( cl_null(g_pml_o.pml07) AND NOT cl_null(g_pml2.pml08))
      OR (g_pml[l_ac].pml07 != g_pml_o.pml07 AND
         NOT cl_null(g_pml2.pml08) ) THEN
         CALL s_umfchk(g_pml[l_ac].pml04,g_pml[l_ac].pml07,
              g_pml2.pml08) RETURNING l_flag,g_pml2.pml09
         IF l_flag THEN
            CALL cl_err(g_pml[l_ac].pml07,'mfg1206',0)
            LET g_pml[l_ac].pml07 = g_pml2.pml07
            LET g_pml[l_ac].pml83 = g_pml_t.pml83
            LET g_pml[l_ac].pml80 = g_pml_t.pml80
            IF g_ima906 MATCHES '[23]' THEN
               RETURN FALSE,'pml85'
            ELSE
               RETURN FALSE,'pml82'
            END IF
         END IF
         IF cl_null(g_pml2.pml09) THEN LET g_pml2.pml09=1 END IF
      END IF
   END IF
   LET g_pml2.pml07 = g_pml[l_ac].pml07
   LET g_pml_o.pml07 = g_pml[l_ac].pml07
   IF p_cmd = 'u' THEN
      IF g_pml[l_ac].pml20 < g_pml[l_ac].pml21 THEN
         CALL cl_err(g_pml[l_ac].pml20,'mfg3082',1)
         LET g_pml[l_ac].pml20 = g_pml_t.pml20
         LET g_pml[l_ac].pml85 = g_pml_t.pml85
         LET g_pml[l_ac].pml82 = g_pml_t.pml82
         IF g_ima906 MATCHES '[23]' THEN
            RETURN FALSE,'pml85'
         ELSE
            RETURN FALSE,'pml82'
         END IF
      END IF
   END IF
   LET g_pml20_t = g_pml[l_ac].pml20
      IF (cl_null(g_pml_o.pml20) OR g_pml[l_ac].pml20 != g_pml_o.pml20 )
         AND (g_no[1,4] != 'MISC') THEN
        #CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang) #CHI-C10037 mark
         CALL s_sizechk(g_pml[l_ac].pml04,g_pml[l_ac].pml20,g_lang,g_pml[l_ac].pml07) #CHI-C10037 add
         RETURNING g_pml[l_ac].pml20
         DISPLAY BY NAME g_pml[l_ac].pml20
         IF g_pml20_t <> g_pml[l_ac].pml20 THEN
            IF g_ima906 MATCHES '[23]' THEN
               RETURN FALSE,'pml85'
            ELSE
               RETURN FALSE,'pml82'
            END IF
         END IF
      END IF
   #for專案
   IF NOT cl_null(g_pml[l_ac].pml12)
      AND NOT cl_null(g_pml[l_ac].pml121)
      AND NOT cl_null(g_pml[l_ac].pml122)
      AND g_pml[l_ac].pml12 != ' '
      AND g_pml[l_ac].pml121 != ' '
      AND g_pml[l_ac].pml122 != ' '
   THEN
      IF cl_null(g_pml_t.pml20) THEN LET g_pml_t.pml20=0 END IF
      CALL t420_chk_pjf05(g_pml[l_ac].pml121,g_pml[l_ac].pml04,g_pml_t.pml20)
      IF NOT cl_null(g_errno) THEN CALL cl_err('',g_errno,'1') END IF
   END IF
   LET g_pml2.pml20 = g_pml[l_ac].pml20
   LET g_pml_o.pml20 = g_pml[l_ac].pml20
   IF g_change='Y' THEN
      CALL t420_set_pml87()
      DISPLAY BY NAME g_pml[l_ac].pml87
      CALL t420_bud(p_cmd,'3')
      IF NOT cl_null(g_errno) THEN
         RETURN FALSE,'pml82'
      END IF
   END IF
   CALL cl_show_fld_cont()
   RETURN TRUE,''
END FUNCTION

FUNCTION t420_pml85_check(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1
   IF NOT cl_null(g_pml[l_ac].pml85) AND NOT cl_null(g_pml[l_ac].pml83) THEN
      IF cl_null(g_pml_t.pml85) OR cl_null(g_pml83_t) OR g_pml_t.pml85 != g_pml[l_ac].pml85 OR g_pml83_t != g_pml[l_ac].pml83 THEN
         LET g_pml[l_ac].pml85=s_digqty(g_pml[l_ac].pml85,g_pml[l_ac].pml83)
         DISPLAY BY NAME g_pml[l_ac].pml85
      END IF
   END IF

   IF g_pml_t.pml85 IS NULL AND g_pml[l_ac].pml85 IS NOT NULL OR
      g_pml_t.pml85 IS NOT NULL AND g_pml[l_ac].pml85 IS NULL OR
      g_pml_t.pml85 <> g_pml[l_ac].pml85 THEN
      LET g_change='Y'
   END IF
   IF NOT cl_null(g_pml[l_ac].pml85) THEN
      IF g_pml[l_ac].pml85 < 0 THEN
         CALL cl_err('','aim-391',0)  #
         RETURN FALSE
      END IF
      IF p_cmd = 'a' OR  p_cmd = 'u' AND
         g_pml_t.pml85 <> g_pml[l_ac].pml85 THEN
         IF g_ima906='3' THEN
            LET g_tot=g_pml[l_ac].pml85*g_pml[l_ac].pml84
            IF cl_null(g_pml[l_ac].pml82) OR g_pml[l_ac].pml82=0 THEN #CHI-960022
               LET g_pml[l_ac].pml82=g_tot*g_pml[l_ac].pml81
               LET g_pml[l_ac].pml82=s_digqty(g_pml[l_ac].pml82,g_pml[l_ac].pml80)   #No.FUN-BB0086
            END IF                                                    #CHI-960022
            DISPLAY BY NAME g_pml[l_ac].pml82
         END IF
      END IF
      LET g_pml2.pml85 = g_pml[l_ac].pml85
      LET g_pml_o.pml85 = g_pml[l_ac].pml85
   END IF
   IF g_change='Y' THEN
      CALL t420_set_pml87()
      DISPLAY BY NAME g_pml[l_ac].pml87
      CALL t420_bud(p_cmd,'3')
      IF NOT cl_null(g_errno) THEN
         RETURN FALSE
      END IF
   END IF
   CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
   RETURN TRUE
END FUNCTION

FUNCTION t420_pml87_check()
   IF NOT cl_null(g_pml[l_ac].pml87) AND NOT cl_null(g_pml[l_ac].pml86) THEN
      IF cl_null(g_pml_t.pml87) OR cl_null(g_pml86_t) OR g_pml_t.pml87 != g_pml[l_ac].pml87 OR g_pml86_t != g_pml[l_ac].pml86 THEN
         LET g_pml[l_ac].pml87=s_digqty(g_pml[l_ac].pml87,g_pml[l_ac].pml86)
         DISPLAY BY NAME g_pml[l_ac].pml87
      END IF
   END IF

   IF NOT cl_null(g_pml[l_ac].pml87) THEN
      IF g_pml[l_ac].pml87 < 0 THEN
         CALL cl_err('','aim-391',0)  #
         RETURN FALSE
      END IF
      LET g_pml2.pml87 = g_pml[l_ac].pml87
      LET g_pml_o.pml87 = g_pml[l_ac].pml87
   END IF
   RETURN TRUE
END FUNCTION
#FUN-BB0086--add--end--

#MOD-AC0309------add-----str--------------------
#FUNCTION t420_multi_ima01()
#DEFINE   tok          base.StringTokenizer
#DEFINE   l_sql        STRING
#DEFINE   l_n          LIKE type_file.num5
#DEFINE   g_cnt        LIKE type_file.num5
#DEFINE   l_plant      LIKE azw_file.azw01
#DEFINE   l_pml        RECORD LIKE pml_file.*
#DEFINE   l_ima31      LIKE ima_file.ima31,
#        l_ima906     LIKE ima_file.ima906,
#        l_ima907     LIKE ima_file.ima907,
#        l_ima908     LIKE ima_file.ima907,
#        l_factor     LIKE ima_file.ima31_fac,
#        l_max        LIKE tqw_file.tqw07,
#        l_ima49      LIKE ima_file.ima49,
#        l_ima491     LIKE ima_file.ima491,
#        l_ima44      LIKE ima_file.ima44,
#        l_flag       LIKE type_file.chr1
#DEFINE l_ima02   LIKE ima_file.ima02,
#      l_ima021  LIKE ima_file.ima021,
#      l_ima39   LIKE ima_file.ima39,
#      l_ima391  LIKE ima_file.ima391
#
#   CALL s_showmsg_init()
#   LET l_plant = g_plant
#   LET tok = base.StringTokenizer.create(g_multi_ima01,"|")
#       WHILE tok.hasMoreTokens()
#          LET l_pml.pml04 = tok.nextToken()
#          IF NOT s_chk_item_no(l_pml.pml04,"") THEN
#            CALL s_errmsg('pml01',l_pml.pml04,'INS pml_file',g_errno,1)
#            CONTINUE WHILE
#           END IF
#
#    LET l_pml.pml01  = g_pmk.pmk01
#    LET l_pml.pml011 = g_pmk.pmk02
#    LET l_pml.pml12  = g_pmk.pmk05
#    LET l_pml.pml33  = g_pmk.pmk04
#
#   LET l_sql="SELECT max(pml02)+1 FROM ",cl_get_target_table(l_plant,'pml_file'),
#                    " WHERE pml01 = '",g_pmk.pmk01,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#   CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql
#   PREPARE sel_pml_pre FROM l_sql
#   EXECUTE sel_pml_pre INTO l_pml.pml02
#   IF cl_null(l_pml.pml02) THEN
#      LET  l_pml.pml02 = '1'
#   END IF
#
#   LET l_sql="SELECT ima44,ima25, ima44,ima31,ima49,ima491,ima906,ima907,ima908 FROM ",cl_get_target_table(l_plant,'ima_file'),
#             " WHERE ima01 = '",l_pml.pml04,"'"
#   CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#   CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql
#          PREPARE sel_ima_pre FROM l_sql
#          EXECUTE sel_ima_pre INTO  l_pml.pml07,l_pml.pml08,l_ima44,l_ima31,l_ima49,l_ima491,l_ima906,l_ima907,l_ima908
#
#    IF g_sma.sma115 = 'Y' THEN
#       IF l_ima906 = '1' THEN  #不使用雙單位
#          LET l_pml.pml83 = NULL
#          LET l_pml.pml84  = NULL
#          LET l_pml.pml85  = NULL
#       ELSE
#          LET l_pml.pml83 = l_ima907
#          CALL s_du_umfchk(l_pml.pml04,'','','',l_ima44,l_ima907,l_ima906)
#              RETURNING g_errno,l_factor
#          LET l_pml.pml84 = l_factor
#          LET l_pml.pml85  = 0
#       END IF
#       LET l_pml.pml80 = l_ima44
#           LET l_pml.pml81  = 1
#           LET l_pml.pml82  = 0
#       END IF
#       IF g_sma.sma116 MATCHES '[02]' THEN
#          LET l_pml.pml86 = NULL
#          LET l_pml.pml87 = NULL
#       ELSE
#          LET l_pml.pml86 = l_ima908
#          LET l_pml.pml87 = 0
#       END IF

#       SELECT ima02,ima021,ima39,ima391 INTO l_ima02,l_ima021,l_ima39,l_ima391
#          FROM ima_file
#          WHERE ima01 = l_pml.pml04
#       LET l_pml.pml041= l_ima02

#       IF l_pml.pml04[1,4] <> 'MISC' THEN
#          LET l_pml.pml40 = l_ima39
#       END IF
#       IF g_aza.aza63 = 'Y' THEN
#          IF l_pml.pml04[1,4] <> 'MISC' THEN
#             LET l_pml.pml401 = l_ima391
#          END IF
#       END IF
#
#
#       IF g_sma.sma115 = 'Y' THEN
#          CALL s_chk_va_setting(l_pml.pml04)
#           RETURNING g_flag,g_ima906,g_ima907
#          IF g_flag=1 THEN
#             CONTINUE WHILE
#          END IF
#          CALL s_chk_va_setting1(l_pml.pml04)
#           RETURNING g_flag,g_ima908
#          IF g_flag=1 THEN
#             CONTINUE WHILE
#          END IF
#          IF g_ima906 = '3' THEN
#             LET l_pml.pml83=g_ima907
#             SELECT ima44 INTO l_ima44 FROM ima_file
#               WHERE ima01=l_pml.pml04
#             LET l_pml.pml80=l_ima44
#          END IF
#       END IF
#
#       LET l_sql="SELECT gen03 FROM ",cl_get_target_table(l_plant,'gen_file'),
#                 " WHERE gen01 = '",g_pmk.pmk12,"' "
#       CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#       CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql
#       PREPARE sel_gen03_pre FROM l_sql
#       EXECUTE sel_gen03_pre INTO  l_pml.pml67

#       LET l_sql="SELECT imb118 FROM ",cl_get_target_table(l_plant,'imb_file'),
#                 " WHERE imb01 = '",l_pml.pml04,"' "
#       CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#       CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql
#       PREPARE sel_imb_pre FROM l_sql
#       EXECUTE sel_imb_pre INTO  l_pml.pml30
#       IF cl_null(l_pml.pml30)  THEN
#          LET  l_pml.pml30 = '0'
#       END IF
#       LET  l_pml.pml03 = NULL
#       LET  l_pml.pml05 = NULL
#       IF NOT cl_null(l_pml.pml04) THEN
#          CALL s_umfchk(l_pml.pml04,l_pml.pml07,
#                        l_pml.pml08)
#               RETURNING g_sw,l_pml.pml09
#       END IF
#       LET  l_pml.pml10 = NULL
#       LET  l_pml.pml11 = 'N'
#       IF NOT cl_null(l_pml.pml04) THEN
#          CALL s_overate(l_pml.pml04) RETURNING l_pml.pml13
#       END IF
#          LET  l_pml.pml31  = 0
#          LET  l_pml.pml31t = 0
#          LET  l_pml.pml14 = g_sma.sma886[1,1]
#          LET  l_pml.pml15 = g_sma.sma886[2,2]
#          LET  l_pml.pml16 = '0'
#          LET  l_pml.pml20 = 0
#          LET  l_pml.pml25 = ' '
#          LET  l_pml.pml34 = l_pml.pml33 + l_ima49
#          LET  l_pml.pml35 = l_pml.pml34 + l_ima491
#          LET  l_pml.pml38 = g_pmk.pmk45
#          LET  l_pml.pml42 = '0'
#          LET  l_pml.pml44 = cl_digcut( l_pml.pml31*g_pmk.pmk42, g_azi03)
#          LET  l_pml.pml49 = '1'
#          LET  l_pml.pml50 = '1'
#          LET  l_pml.pml53 = ' '
#          LET  l_pml.pml54 = '1'
#          LET  l_pml.pml55 = TIME
#          LET  l_pml.pml56 = ' '
#          LET  l_pml.pml88 = l_pml.pml31 * l_pml.pml87
#          LET  l_pml.pml88t= l_pml.pml31t* l_pml.pml87
#          LET  l_pml.pml91 = ' '
#          LET  l_pml.pml92 = ' '
#          LET  l_pml.pml190 = 'N'
#          LET  l_pml.pml192 = 'N'
#          LET  l_pml.pml92  = 'N'
#          LET  l_pml.pml91  = 'N'
#          LET  l_pml.pml11  = 'N'
#          LET  l_pml.pmlplant = g_plant
#          LET  l_pml.pmllegal = g_legal
#          IF g_azw.azw04 = '2' THEN
#             LET l_pml.pml52=' '
#             LET l_pml.pml54=' '
#          END IF
#
#          LET l_sql="SELECT gem10 FROM ",cl_get_target_table(l_plant,'gem_file'),
#                    " WHERE gem01 = '",l_pml.pml67,"' "
#          CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#          CALL cl_parse_qry_sql(l_sql,l_plant) RETURNING l_sql
#          PREPARE sel_gem10_pre FROM l_sql
#          EXECUTE sel_gem10_pre INTO  l_pml.pml930
#          INSERT INTO pml_file VALUES (l_pml.*)
#          IF SQLCA.sqlcode THEN
#               CALL s_errmsg('pml01',l_pml.pml04,'INS pml_file',SQLCA.sqlcode,1)
#               CONTINUE WHILE
#          END IF
#       END WHILE
#   CALL s_showmsg()
#END FUNCTION
#MOD-AC0309--------add------------------end----------------
#No:FUN-9C0071--------精簡程式-----
#MOD-B90082 add begin-------------
FUNCTION t420_get_pml041()
   SELECT ima02,ima021 INTO g_pml[l_ac].pml041,g_pml[l_ac].ima021 FROM ima_file
    WHERE ima01=g_pml[l_ac].pml04
END FUNCTION
#MOD-B90082 add end---------------
#FUN-C60098----add--begin----------
#FUN-C60098----add---end-----------
#FUN-A80117

#FUN-CB0014---add---str---
FUNCTION t420_list_fill()
  DEFINE l_pmk01         LIKE pmk_file.pmk01
  DEFINE l_i             LIKE type_file.num10

    CALL g_pmk_l.clear()
    LET l_i = 1
    FOREACH t420_fill_cs INTO l_pmk01
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach item_cur',SQLCA.sqlcode,1)
          CONTINUE FOREACH
       END IF
       SELECT pmk46,pmk01,pmk03,pmk04,pmk02,pmk09,pmc03,pmk49,
              pmk18,pmkcond,pmkconu,gen02,pmk47,pmkplant
         INTO g_pmk_l[l_i].*
         FROM pmk_file
              LEFT OUTER JOIN gen_file ON pmkconu = gen01
                                      AND genacti = 'Y'
              LEFT OUTER JOIN pmc_file ON pmk09 = pmc01
        WHERE pmk01=l_pmk01

       LET l_i = l_i + 1
       IF l_i > g_max_rec THEN
          IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
          END IF
          EXIT FOREACH
       END IF
    END FOREACH
    LET g_rec_b4 = l_i - 1
    DISPLAY ARRAY g_pmk_l TO s_pmk_l.* ATTRIBUTE(COUNT=g_rec_b4,UNBUFFERED)
       BEFORE DISPLAY
          EXIT DISPLAY
    END DISPLAY

END FUNCTION

FUNCTION t420_bp3(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1


   IF p_ud <> "G" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY g_pmk_l TO s_pmk_l.* ATTRIBUTE(COUNT=g_rec_b4,UNBUFFERED)                                     #FUN-B90101---Add---
       BEFORE DISPLAY
          CALL fgl_set_arr_curr(g_curs_index)
          CALL cl_navigator_setting( g_curs_index, g_row_count )
       BEFORE ROW
          LET l_ac4 = ARR_CURR()
          LET g_curs_index = l_ac4
          CALL cl_show_fld_cont()

      ON ACTION page_main
         LET g_action_flag = "page_main"
         LET l_ac4 = ARR_CURR()
         LET g_jump = l_ac4
         LET mi_no_ask = TRUE
         IF g_rec_b4 > 0 THEN
             CALL t420_fetch('/')
         END IF
         CALL cl_set_comp_visible("page_list", FALSE)
         CALL cl_set_comp_visible("info", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_list", TRUE)
         CALL cl_set_comp_visible("info", TRUE)
         EXIT DISPLAY

      ON ACTION ACCEPT
         LET g_action_flag = "page_main"
         LET l_ac4 = ARR_CURR()
         LET g_jump = l_ac4
         LET mi_no_ask = TRUE
         CALL t420_fetch('/')
         CALL cl_set_comp_visible("info", FALSE)
         CALL cl_set_comp_visible("info", TRUE)
         CALL cl_set_comp_visible("page_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_list", TRUE)
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

      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY

      ON ACTION first
         CALL t420_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(g_curs_index)
         ACCEPT DISPLAY

      ON ACTION previous
         CALL t420_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(g_curs_index)
         ACCEPT DISPLAY

      ON ACTION jump
         CALL t420_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(g_curs_index)
         ACCEPT DISPLAY

      ON ACTION next
         CALL t420_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(g_curs_index)
         ACCEPT DISPLAY

      ON ACTION last
         CALL t420_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
         CALL fgl_set_arr_curr(g_curs_index)
         ACCEPT DISPLAY

      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY

      #TQC-D10084--mark--str--
      #ON ACTION detail
      #   LET g_action_choice="detail"
      #   LET l_ac = 1
      #   EXIT DISPLAY
      #TQC-D10084--mark--end--
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
         CALL t420_def_form()
         IF g_aza.aza71 MATCHES '[Yy]' THEN
            CALL aws_gpmcli_toolbar()
            CALL cl_set_act_visible("gpm_show,gpm_query", TRUE)
         ELSE
            CALL cl_set_act_visible("gpm_show,gpm_query", FALSE)
         END IF
         CALL t420_pic()
         EXIT DISPLAY


      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY

      ON ACTION mod_date
         LET g_action_choice="mod_date"
         EXIT DISPLAY

    #@ON ACTION MRP查詢
      ON ACTION query_mrp
         LET g_action_choice="query_mrp"
         EXIT DISPLAY

    #@ON ACTION 採購查詢
      ON ACTION qry_po_status
         LET g_action_choice="qry_po_status"
         EXIT DISPLAY

    #@ON ACTION 簽核狀況
      ON ACTION approval_status
         LET g_action_choice="approval_status"
         EXIT DISPLAY


    #@ON ACTION 變更狀況
      ON ACTION modify_status
         LET g_action_choice="modify_status"
         EXIT DISPLAY


    #@ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY

    #@ON ACTION 特別說明
      ON ACTION special_description
         LET g_action_choice="special_description"
         EXIT DISPLAY

    #@ON ACTION easyflow送簽
      ON ACTION easyflow_approval         #FUN-550038
         LET g_action_choice = "easyflow_approval"
         EXIT DISPLAY

    #@ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY

    #@ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY

    #@ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
#FUN-D20025 add
    #@ON ACTION 取消作廢
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
#FUN-D20025 add
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION exporttoexcel       #FUN-4B0025
         LET g_action_choice = 'exporttoexcel'
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
      ON ACTION e_proc_require
         LET g_action_choice = 'e_proc_require'
         EXIT DISPLAY

      ON ACTION controls                           #No.FUN-6B0032
         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032

      ON ACTION related_document                #No.FUN-6A0162  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      ON ACTION gpm_show
         LET g_action_choice="gpm_show"
         EXIT DISPLAY

      ON ACTION gpm_query
         LET g_action_choice="gpm_query"
         EXIT DISPLAY

      ON ACTION aps_related_data
         LET g_action_choice = 'aps_related_data'
         EXIT DISPLAY

      ON ACTION EXIT
         LET g_action_choice = "EXIT"
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG = TRUE
         LET g_action_choice = "EXIT"
         EXIT DISPLAY
   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
#FUN-CB0014---add---end---
#CHI-D20006 -- add start --
FUNCTION t420_g_b()
DEFINE  l_chr       LIKE type_file.chr1

#將prompt改開窗滑鼠選
          OPEN WINDOW t4204_w WITH FORM "apm/42f/apmt4204"
             ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

          CALL cl_ui_locale("apmt4204")
          LET l_chr='1'   #MOD-530423
          INPUT l_chr WITHOUT DEFAULTS FROM FORMONLY.a

          AFTER FIELD a
            IF l_chr NOT MATCHES '[1234]' THEN  #No.FUN-A20039 add 4
               NEXT FIELD a
            END IF

          ON ACTION CONTROLR
             CALL cl_show_req_fields()

          ON ACTION CONTROLG
             CALL cl_cmdask()

          AFTER INPUT
             IF INT_FLAG THEN                         # 若按了DEL鍵
                LET INT_FLAG = 0
                EXIT INPUT
             END IF

          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE INPUT

          ON ACTION about         #MOD-4C0121
             CALL cl_about()      #MOD-4C0121

          ON ACTION help          #MOD-4C0121
             CALL cl_show_help()  #MOD-4C0121

          END INPUT
          IF INT_FLAG THEN
             LET INT_FLAG=0
             LET l_chr = '1'
          END IF
          CLOSE WINDOW t4204_w                 #結束畫面

#FUN-C20006--add--begin--
#FUN-C20006--add--end--
       IF cl_null(l_chr) THEN
          LET l_chr = '1'
       END IF
       LET g_rec_b = 0
       CASE
         WHEN l_chr = '1'
              CALL g_pml.clear()
              CALL t420_b()
         WHEN l_chr = '2'
              CALL p470("G",g_pmk.pmk01)
              COMMIT WORK
              LET g_wc2=NULL
              CALL t420_b_fill(g_wc2,' 1=1')   #FUN-B90101 add 第二個參數，服飾中母單身的條件
              LET g_action_choice="detail"
              IF cl_chk_act_auth() THEN
                 CALL t420_b()
              ELSE
                 RETURN
              END IF
         WHEN l_chr='3'
              CALL p480(g_pmk.pmk01)
              LET g_wc2=NULL
              CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
              LET g_action_choice="detail"
              IF cl_chk_act_auth() THEN
                 CALL t420_b()
              ELSE
                 RETURN
              END IF
#FUN-C20006--mark-begin--
##No.FUN-A70034  --Begin
#&ifdef SLK
#              WHEN l_chr='4'
#                   CALL p490("G",g_pmk.pmk01,'')
#                   LET g_wc2=NULL
#                   CALL t420_b_fill(g_wc2)
#                   LET g_action_choice="detail"
#                   IF cl_chk_act_auth() THEN
#                      CALL t420_b()
#                   ELSE
#                      RETURN
#                   END IF
#&else
#FUN-C20006--mark--end--
              #FUN-A20039 add --begin--
               WHEN l_chr='4'
 #FUN-A80016 --modify
               #    CALL p500("G",g_pmk.pmk01)
                    CALL p500("G",g_pmk.pmk01,"")    #FUN-A80016
                    LET g_wc2=NULL
                    CALL t420_b_fill(g_wc2,' 1=1')       #FUN-B90101 add 第二個參數，服飾中母單身的條件
                    LET g_action_choice="detail"
                    IF cl_chk_act_auth() THEN
                       CALL t420_b()
                    ELSE
                       RETURN
                    END IF
               #FUN-A20039 add --end---
#&endif       #FUN-C20006 mark
#No.FUN-A70034  --End
               OTHERWISE EXIT CASE
       END CASE
       LET g_pmk_t.* = g_pmk.*                # 保存上筆資料
       LET g_pmk_o.* = g_pmk.*                # 保存上筆資料
       CALL t420_sign('a')
   #END IF   #CHI-D20006 mark
END FUNCTION
#CHI-D20006 -- add end --
FUNCTION t420_mod()
   DEFINE g_dat   LIKE type_file.dat

   SELECT * INTO g_pmk.* FROM pmk_file WHERE pmk01=g_pmk.pmk01
   IF g_pmk.pmk18!='N' THEN CALL cl_err(g_pmk.pmk01,'cpm-002',1) RETURN END IF

   OPEN WINDOW t420mod_w WITH FORM "cpm/42f/cpmt420_d"
        ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_locale("cpmt420_d")
   INPUT BY NAME g_dat
      BEFORE INPUT
         LET g_dat=g_today
         DISPLAY BY NAME g_dat

      ON ACTION EXIT
         LET INT_FLAG=1
         EXIT INPUT

      ON ACTION CANCLE
         LET INT_FLAG=1
         EXIT INPUT

   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG=0
      CLOSE WINDOW t420mod_w
      RETURN
   END IF
   UPDATE pml_file
      SET pml33=g_dat,
          pml34=g_dat,
          pml35=g_dat
    WHERE pml01=g_pmk.pmk01
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_pmk.pmk01,SQLCA.sqlcode,0)
      CLOSE WINDOW t420mod_w
      RETURN
   END IF
   CLOSE WINDOW t420mod_w
END FUNCTION
