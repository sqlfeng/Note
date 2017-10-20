# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#
# Pattern name...: asfi301.4gl
# Descriptions...: 工單維護作業
# Date & Author..: 97/06/26 By Roger
# Modify(2583)...: 98/10/22 By Star 增加 11.拆件式 工單型態
# Modify.........: 99/05/26 By Carol MENU add 序號維護--> CALL i301_6() (asfi3016.4gl)
# Modify.........: 2000/01/07 By Kammy 增加 15.試產性 工單型態
# Modify.........: 2000/04/21 By Carol 取消 15.試產性 工單型態(sfb05) -- apple
#                             以防後續試產料件無ima_file編號可查詢相關資料
#                  2001/05/31 BY ANN CHEN No.B524 第一站投入量改在工單確認才掛上 確認還原清為0
# Modify.........: No:7592 03/07/15 Carol 'Z.取消確認' 時,
#                                         須檢核已有報工資料(shb_file),
#                                         雖然未發料, 也不允許取消,因工單
#                                         完工方式='2'時,可先行報工而不發料
# Modify.........: No:7315 03/07/15 Carol 1.AFTER FIELD sfb08
#                                           SELECT msb05*ima55_fac ..SQL 修改
#                                         2.Y.確認時check訂單及MPS數量的方法修改
# Modify.........: No:7505 03/07/17 Carol 1.刪除備料時應一併將子工單刪除
#                                         2.母工單刪除時應一併將子工單刪除
#                                         3.須check子工單尚未發料才可delete
# Modify.........: No:6630 03/07/18 Carol 工單在展下階料時,如遇下階料的bom未發
#                                         放,則此下階料不可產生備料
# Modify.........: No:7687 03/08/07 Carol sfb91 應該要可以按 control+P
#                                         查詢製造通知單，並自動帶出
# Modify.........: No:7686 03/08/07 Carol sfb98應該參考gem_file部門資料
#                                         (與 axc 一致) 將smh_file -> gem_file
# Modify.........: No:7665 03/08/11 Carol 工單確認後不可以以功能D 進行修改備料檔的資料
# Modify.........: No:7829 03/08/18 Carol 單據程式中呼叫單據自動編號時,
#                                         應該是要包覆在 BEGIN WORK 中(transaction)
#                                         才會達到lock 的功能
# Modify.........: No:8025 03/11/14 Melody 依工單單別設定(asmi300)委外型態 default sfb100
# Modify.........: No:8123 03/11/14 Melody 調整QBE輸入順序避免跳躍順序不規則
# Modify.........: No:8125 03/11/14 Melody 工單型態欄(sfb02)應比照生產數量的控制，若有單身備料存在，則不允許U.修改
# Modify.........: No:7254 03/11/14 Melody 非製程工單製程欄位(sfb06)直接跳過(依sfb93)
# Modify.........: No:8598 03/11/14 Melody 工單單身新增時，誤差率的預設值應先帶 0
# Modify.........: No:8573 03/11/14 Melody 若該工單已有備料資料,單頭訂單+項次不可更改(U)
# Modify.........: No:8600 03/11/14 Melody 在 3036行此段程式 IF i > 10 THEN EXIT FOREACH END IF
#                                          應改為 i > 24 THEN EXIT FOREACH END IF
# Modify.........: No:8765 03/11/25 Melody 1.after field sfa26 應考慮 6,T
#                                          2.應check 6非T類元件
# Modify.........: No:9000 03/12/31 Melody 'A.輸入'時針對sfb100的初始值的給予,應改在i301_i()後面,而不是在之前
# Modify.........: No:9576 04/05/19 Melody 已有runcard資料不可執行確認還原
# Modify.........: MOD-470493(9785) 04/07/21 Carol
#                                   1.A.新增時,AFTER FIELD sfb221 重撈料號
#                                   2.U.修改時,若單頭的備料否= Y,不允許修改單頭的訂單編號與項次
#                                   3.若該工單已有runcard資料不可執行確認還原
#                                   4.委外重工--會有退料動作(領A, 做A 或領A做B)若做出無單身有單頭資料,刪除單頭加串sfa05 > 0 (不是退料)
# Modify.........: MOD-480095 04/08/04 Carol check g_close 值為'Y' or 'N'應改用 g_sfb.sfb04 來判斷
# Modify.........: MOD-480596 04/08/31 Carol 替代量0的不要帶入工單備料中
# Modify.........: MOD-480392 04/09/03 Echo 工單做確認還原時,不可有任何一張單據存在在發料檔中
# Modify.........: No.MOD-490217 04/09/10 by yiting 料號欄位放大
# Modify.........: MOD-490382 04/09/23 ching 預計完工日不應比預計開工日早
# Modify.........: No.MOD-490371 04/09/22 By Yuna Controlp 未加display
# Modify.........: MOD-490451 04/09/24 ching sfb08 default null
# Modify.........: No.MOD-4A0063 04/10/06 By Mandy q_ime 的參數傳的有誤
# Modify.........: No.FUN-4A0070 04/10/12 By Carol BOM料號處,先開BOM之下階料,若未選任何料則再開料件基本資料檔
# Modify.........: No.MOD-4A0213 04/10/14 By Mandy q_imd 的參數傳的有誤
# Modify.........: No.MOD-4A0254 04/10/19 By Carol mark ACTION page02
# Modify.........: No.MOD-4A0252 04/10/26 By Smapmin 顯示開窗資料
# Modify.........: No.FUN-4B0011 04/11/02 By Carol 新增 I,T,Q類 單身資料轉 EXCEL功能(包含假雙檔)
# Modify.........: No.MOD-4B0169 04/11/22 By Mandy check imd_file 的程式段...應加上 imdacti 的判斷
# Modify.........: No.MOD-4B0275 04/11/27 By Danny  CALL q_coc2
# Modify.........: No.MOD-4C0010 04/12/02 By Mandy DEFINE smydesc欄位用LIKE方式
# Modify.........: No.FUN-4C0035 04/12/08 By Carol Q,U,R 加入權限控管處理
# Modify.........: No.MOD-4C0034 By Carol 工單確認時若屬製程工單，應檢查工單單身之作業編號是否存在於工單製程檔 ecm_file 中。
# Modify.........: No.MOD-4B0177 By Carol 對有發料且產生欠料的單身做取替代時出現欠料量不正常的問題
# Modify.........: No.MOD-510023 05/01/07 By ching defaut pmm31,pmm32
# Modify.........: No.MOD-520072 05/02/23 By ching 替代供需量DISPLAY
# Modify.........: No.MOD-530280 05/03/25 By Carol
#                                            2.查詢時於工單單號欄按Ctrl+P時,會查不到工單.
#                                            3.查詢時於工單單號欄按Ctrl+P時,會查不到工單.(尚未確認者會查不出來),程式中用q_sfb01 應改為q_sfb
#                                            4.預計開工,完工日期若為非工作日,僅提出Warning,不Reject
#                                            5.實際開工日於新或修改時不可輸入
#                                            6.工單資料一之製程,工單資料二之FQC應可於查詢時進行時選取
#                                            7.取替代應該(1)可用負值減少 (2)應發=已發時應可進行取替代
#                                            8.選擇取替代時,查詢下階料件時,應只出現替代碼為1,2,5的備料
#                                            9.於工單單身輸入不屬於BOM之料件時，沒有任何之錯誤訊息
#                                            10.工單單身轉Excel有問題
#                                            11.選取英文版後，列印工單並未直接列印出英文版
#                                            12.工單產生備料時，應先檢查單身備料全部為空者才可重新產生。否則會誤刪原先之資料。
#                                            13.工單列印時，輸入是否列印訂單Memo、嘜頭後，應立即列印，不應再輸入「本張異動單據」，多此一舉。
# Modify.........: No.MOD-530617 05/03/28 By Mandy 系統自動產生委外採購單後,單頭補輸入資料,要離開時,游標停留在'驗收單列印',必需點選才可過,其值default非'N'
# Modify.........: No.MOD-530617 05/04/13 By Carol SQL少了OUTER ima_file
# Modify.........: No.FUN-550112 05/05/27 By ching 特性BOM功能修改
# Modify.........: NO.FUN-550067 05/06/01 By jackie 單據編號加大
# Modify.........: No.MOD-550190 05/06/10 By pengu 在計算預計完工日時，並沒有把非工作日扣掉
# Modify.........: No.FUN-560027 05/06/16 By Mandy 測試BOM加特性代碼
# Modify.........: No.FUN-560084 05/06/18 By Carrier 雙單位內容修改
# Modify.........: No.FUN-560151 05/06/24 By pengu  沒有單身時，單頭之「完工方式」應該可以修改。
# Modify.........: No.MOD-540194 05/07/22 By kim 確認時,檢查替代碼資料的合理性
# Modify.........: No.MOD-530808 05/06/28 By pengu 計算l_oeb12 訂單數量時,應乘上生產損秏率(ima562)
# Modify.........: No.MOD-570386 05/08/01 By pengu 當工單型態為:15試產性工單時,BOM版本應為必要欄位
# Modify.........: No.MOD-570305 05/08/17 By kim 狀態碼為 :"結案"的工單,還可以執行"替代",應該擋住
# Modify.........: No.MOD-580190 05/08/19 By Claire 進入單身的時候,確認碼沒有重新select,未確認工單的畫面還可以進入單身修改或刪除
# Modify.........: No.MOD-580229 05/08/22 By Rosayu 替代碼檢查,確認時應該加入'5'的時候不檢查
# Modify.........: No.MOD-580101 05/08/22 By Claire 一對一委外po,以單據別default取簽核否欄位值
# Modify.........: No.MOD-580338 05/09/07 By kim 刪除單身全部資料更新"備料檔產生否"='N
# Modify.........: No.MOD-590259 05/09/14 By Claire 新增時重新將sfb071清空
# Modify.........: No.MOD-590218 05/09/15 By kim 料號長度大於20一般取替代有問題
# Modify.........: No.MOD-590272 05/09/20 By kim 新增委外採購單時,單據別碼數取錯,只取三碼
# Modify.........: No.MOD-590262 05/09/23 By pengu 工單單身存在時，單頭之「製造通知單號」與項次欄位應該均不允許更改。
# Modify.........: No.MOD-590258 05/09/23 By pengu 工單單頭輸入時，若工單型態為「委外工單」，則需檢查單頭之「委外型態」欄位不可為空值。
# Modify.........: No.MOD-5A0032 05/10/04 By kim 修改i301_chk_sfa26
# Modify.........: No.MOD-5A0033 05/10/05 By Sarah 於工單的訂單欄位上輸入訂單資料後 ,將訂單資料清除 ,但卻無法Pass訂單欄位,會一直出現錯誤訊息
# Modify.........: No.MOD-590117 05/10/21 By pengu 重工工單與拆件式工單不可產生下皆備料或子工單
# Modify.........: No.MOD-5A0008 05/10/21 By pengu 錯誤代碼[abm-731]建議加show料,以便辯別
# Modify.........: No.MOD-570203 05/09/24 By pengu  1.工單成品需控制,若該主件為(Phase out)料,則警示並 Reject
                                        #           2.如是MPS或訂單轉工單時，預計完工日為訂單完工日，預計開工日由預計完工日反推
# Modify.........: No.FUN-5B0130 05/12/08 By Claire 以單身指到該筆為key串aimq804
# Modify.........: No.MOD-5B0289 05/12/23 By Pengu 單身件取替代備料時若用鍵盤按'enter' 有控管替代碼的正確性
                                      #            但若直接用滑鼠點選確定時卻沒有進行控管
# Modify.........: No.TQC-610003 06/01/17 By Nicola 新增欄位sfb95
# Modify.........: No.FUN-610018 06/01/17 By ice 采購含稅單價功能調整
# Modify.........: NO.FUN-550010 06/01/23 BY yiting 單身資料儲存前,均重新計算一次實際QPA
# Modify.........: No.MOD-560225 06/02/15 By Claire確認時1對１委外工單應檢查採購單已發出才可確認
#                                                  確認時1對１的委外採購單不update為已發出(pmm25 = '2')
# Modify.........: No.TQC-630013 06/03/03 By Claire 串報表傳參數
# Modify.........: No.MOD-630021 06/03/06 By Claire 委外工單對 sfb82 要檢核
# Modify.........: No.TQC-630068 06/03/07 By Sarah 指定單據編號、執行功能
# Modify.........: No.FUN-640044 06/04/08 By Sarah 輸入單別後,未自動帶出委外型態(sfb100)
# Modify.........: No.FUN-640030 06/04/09 By kim 重複性料件不應該可以輸入開立工單
# Modify.........: No.MOD-640247 06/04/10 By kim FQC 欄位應依工單單據別自動帶出
# Modify.........: No.MOD-640283 06/04/10 By Carol 生產料件的檢查應加上特性代碼的檢查
# Modify.........: No.MOD-640425 06/04/12 By kim 修改取替代的問題
# Modify.........: No.MOD-640245 06/04/12 By pengu 單生產料號, 不應該與料件主檔之主特代碼作比對的方式相同.
# Modify.........: No.MOD-640197 06/04/14 By pengu 由amrp520產生的工單,無法確認
# Modify.........: No.MOD-640197 06/04/14 By Claire 工單型態5or8,default sfb99(重工)='Y'
# Modify.........: No.FUN-640148 06/04/18 By Sarah 增加當工單完工日與訂單預定交貨日不同時顯示訊息
# Modify.........: No.MOD-640505 06/04/18 By Claire add database ds
# Modify.........: No.FUN-640062 06/04/19 By Claire 委外工單時,廠商及料號需確認已核准
# Modify.........: No.MOD-640478 06/04/27 By Claire 工單型態8or5 -->重工(sfb99)= 'Y'
# Modify.........: No.FUN-640147 06/05/02 By kim 進行替代時,應考慮單位小數點取位
# Modify.........: No.MOD-650015 06/05/05 By rainy 取消輸入時的"預設上筆"功能
# Modify.........: No.MOD-650080 06/05/17 By Claire 工單型態8or7確認時 -->委外型態(sfb100)不可空白,default smy57第6碼,若無default '1'
# Modify.........: No.FUN-630087 06/05/23 By Rainy 新增action產生雜發單
# Modify.........: No.TQC-660067 06/06/14 By Sarah p_flow功能補強
# Modify.........: No.FUN-660106 06/06/16 By kim GP3.1 增加確認碼欄位與處理
# Modify.........: No.FUN-660128 06/06/19 By Xumin cl_err --> cl_err3
# Modify.........: No.FUN-570103 06/06/30 By Sarah 當訂單已有備置時,生產量=訂單數量-已備置量
# Modify.........: No.FUN-660121 06/07/03 By kim 單頭盤盈虧量在其他程式並未處理(g5掃過), 建議可以拿掉
# Modify.........: No.MOD-660107 06/07/04 By Pengu 有QPA異動或是應發數量異動都應該重新計算 QPA值與應發數量
# Modify.........: No.MOD-660086 06/07/05 By Sarah 查詢一筆未確認的單號後按新增再放棄,再按作廢,之前查詢的那筆會被作廢掉
# Modify.........: No.TQC-670008 06/07/05 By rainy 權限修正
# Modify.........: No.TQC-670017 06/07/05 By rainy 產生雜發單時號/儲位若未key值應給空白
# Modify.........: No.FUN-660216 06/07/10 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.TQC-670027 06/07/12 By Pengu 輸入到第二頁再回第1頁時預計開工日與完工日不應回復為原值
# Modify.........: No.FUN-670061 06/07/17 By kim GP3.5 利潤中心
# Modify.........: No.FUN-650122 06/07/24 By rainy 替代碼<>34時才不可進入替代畫面
# Modify.........: No.FUN-5B0117 06/07/24 By rainy asfi301 modi when sfb02='7' , chk if sfb39='2' then warning ... & reject
# Modify.........: No.MOD-670107 06/07/26 By wujie 在審核時，為訂單數量oeb12加上生產損耗率的計算
# Modify.........: No.FUN-670103 06/07/28 By kim GP3.5 利潤中心
# Modify.........: No.FUN-670041 06/08/10 By Pengu 將sma29 [虛擬產品結構展開與否] 改為 no use
# Modify.........: No.TQC-680105 06/08/24 By Pengu 如A料已全由B料取替代後,應該要可以用取替代方式還原
# Modify.........: No.TQC-680109 06/08/24 By Pengu 工單做確認還原時應排除已作廢的發料單據
# Modify.........: No.TQC-680110 06/08/24 By Pengu 在AFTER FIELD sfa27 中加display by name sfa11
# Modify.........: No.FUN-670099 06/08/28 By Nicola 價格管理修改
# Modify.........: No.FUN-580165 06/09/07 By kim BOM 表設定"工單為自動展開" 若參數 工單備料是否必須存在BOM主檔 設定為 Y.必須存在
                                                #的選項時 ,尾階的備料會檢查不過, 會一直出現"該料件未存在BOM表中"
# Modify.........: No.FUN-680121 06/09/13 By huchenghao 類型轉換
# Modify.........: No.FUN-690047 06/09/28 By Sarah pmm45,pmn38預設為'N'
# Modify.........: No.FUN-6A0007 06/10/26 By kim GP3.5 台虹保稅客製功能回收修改
# Modify.........: No.TQC-6A0062 06/10/31 By Ray 重新產生制程時在DELETE ecm_file時要同時刪除sgd_file
# Modify.........: No.FUN-6A0090 06/11/06 By douzh l_time轉g_time
# Modify.........: No.FUN-6A0043 06/11/07 By rainy 已確認才能做委外採購
# Modify.........: No.CHI-6A0042 06/11/08 By rainy 轉雜發單時若該料不存在正式料號(ima_file)則不轉該筆單身
# Modify.........: No.FUN-6B0044 06/11/13 By kim GP3.5 台虹保稅客製功能回收修改
# Modify.........: No.FUN-6A0036 06/11/14 By rainy 判斷停產 ima140時，要再一併判斷生效日ima1401
# Modify.........: No.FUN-6B0031 06/11/14 By yjkhero 新增動態切換單頭部份顯示的功能
# Modfiy.........: No.CHI-690043 06/11/21 By Sarah pmn_file增加pmn90(取出單價),INSERT INTO pmn_file前要增加LET pmn90=pmn31
# Modify.........: No.FUN-6A0164 06/11/22 By jamie 1.FUNCTION _q() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modfiy.........: No.FUN-6B0069 06/12/04 By kim 有工單變更紀錄則不可取消確認
# Modfiy.........: No.CHI-680014 06/12/04 By rainy INSERT INTO pmn_file 時要處理pmn88/pmn88t
# Modfiy.........: No.FUN-6B0093 06/12/04 By jamie 加show "工單結案日期" "工單發料及工時結束日"欄位
# Modify.........: No.MOD-680077 06/12/06 By pengu 改生產料號、數量、預計開工日，應該要會自動計算預計完工日
# Modify.........: No.MOD-6A0103 06/12/11 By claire 委外重工及一般重工對應發數量欄位應考慮單位小數取位
# Modify.........: No.CHI-6A0028 06/12/13 By rainy 拆件式工單、重工工單、委外重工工單, 生產主件可為 p_part,其他的不可
# Modify.........: No.MOD-6A0071 06/12/13 By pengu 工單轉委外採購單時，採購單單身亦要依ima15 default pmn64(保稅否)
# Modify.........: No.CHI-690066 06/12/13 By rainy CALL s_daywk() 要判斷未設定或非工作日
# Modify.........: No.MOD-6B0046 06/12/14 By pengu 工單入庫後卻還可以到替代檔單身維護
# Modify.........: No.MOD-6A0051 06/12/14 By Mandy DEFINE new_rate  改用LIKE bmd07 ,因為其值是放bmd07
# Modify.........: No.MOD-6B0065 06/12/18 By kim 發料倍量與替代料的問題
# Modify.........: No.TQC-6C0114 06/12/20 By day 已審核的工單再審核需提示
# Modify.........: No.MOD-6C0105 06/12/29 By pengu 在i301sub_firm1()中針對生產數量及訂單數量的檢查時會出現異常的狀況
# Modify.........: No.TQC-710006 07/01/04 By day 審核時若有問題，不應立即顯示狀態碼
# Modify.........: No.MOD-6A0086 07/01/09 By pengu 走製程UPDATE ecm_file時並沒有考慮生產單位批量(ima56)
# Modify.........: No.CHI-6B0020 07/01/17 By rainy QPA不可=0
# Modify.........: No.TQC-6B0135 07/01/18 By rainy 刪除或作廢時，先判斷是否有關聯工單，如果有，訊問是否執行
# Modify.........: No.MOD-730002 07/03/02 By pengu 在產生單身備料的替代料時,所產生的替代料無發料單位
# Modify.........: No.TQC-710003 07/03/06 By pengu 修改單身備料檔的單位時，"轉換率"(sfa13)不會被更新
# Modify.........: No.TQC-730032 07/03/07 By pengu 工單在作取銷確認時，位判斷該工單是否有存在已過帳的發料或退料單
# Modify.........: No.TQC-6B0105 07/03/07 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.TQC-720063 07/03/21 By Judy 開窗字段"母工單號","庫位"錄入任何值不報錯
# Modify.........: No.FUN-730012 07/03/22 By kim 將確認段移到asfi301_sub.4gl中
# Modify.........: No.FUN-720043 07/03/23 By Mandy APS相關調整
# Modify.........: No.TQC-730022 07/03/24 By rainy 流程自動化
# Modify.........: NO.FUN-730043 07/03/28 BY yiting 加上生產線欄位sfb102
# Modify.........: No.MOD-730120 07/03/28 By pengu 新增, 輸入單別後未顯示單據名稱
# Modify.........: No.FUN-730075 07/03/30 By kim 行業別架構
# Modify.........: NO.TQC-740056 07/04/12 BY yiting sfb102位置調整
# Modify.........: No.TQC-740125 07/04/17 By Rayven 選“成本中心”后沒有帶出相應的成本中心名稱
#                                                   工單取消確認時，提示信息為英文，需添加中文提示
# Modify.........: No.TQC-740160 07/04/22 By Rayven 委外工單中，委外代買數量可以任意輸入
# Modify.........: No.MOD-740181 07/04/22 By kim 一般工單，按功能鍵「產生雜發單」時，沒有任何錯誤訊息。應該要有：「產生雜發單只於試產性工單有效」。
# Modify.........: No.MOD-740060 07/04/25 By pengu 訂單轉工單判斷訂單是否已開立工單應排除5.再加工工單或8.重工委外工單
# Modify.........: No.TQC-740131 07/04/26 By pengu 替代碼為[3,4,6,S,U,T]時在修改實際QPA不應該重新計算應發數量(sfa05)
# Modify.........: No.TQC-740153 07/05/04 By kim 多項取替代問題修改
# Modify.........: No.TQC-750013 07/05/04 By Mandy 1.一進入程式,不查詢直接按Action "APS相關資料"時的控管
#                                                  2.參數設不串APS時,Action "APS相關資料"不要出現
# Modify.........: No.CHI-750006 07/05/07 By kim 1.有有效的委外採購單時，不允許委外工單的取消審核
#                                                2.修改單身的BOM料號,當取替代是0的時候,要及時變更發料料號
# Modify.........: No.TQC-750023 07/05/10 By pengu 試產工單單身備料不應該受asms270中"工單備料是否存在於BOM主檔"參數控管
# Modify.........: No.FUN-740034 07/05/14 By kim 確認過帳不使用rowid,改用單號
# Modify.........: No.MOD-750080 07/05/16 By claire 專案代號(sfb27)拋委外採購時應代入採購單單身(pmn122)
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.TQC-760038 07/06/05 By xufeng  發料數量和最小批量的比兌條件有誤
# Modify.........: No.CHI-710050 07/06/06 By jamie 若單身備料皆為消耗性料件時,則提醒完工方式應為2.領料(事後領料)
# Modify.........: No.MOD-760072 07/06/15 By pengu 刪除工單備料時無法修改 "有效日期"(sfb071)
# Modify.........: No.MOD-760073 07/06/15 By pengu 工單型態屬於7.委外工單或8.委外重工工單應該不允許FQC
# Modify.........: No.MOD-760043 07/06/15 By pengu 重工工單被料應發數量大負數時會出現錯誤訊息(-391)
# Modify.........: No.TQC-770043 07/07/09 By Rayven 可重復“生成備料”
# Modify.........: No.MOD-760148 07/07/13 By pengu 執行雜發單action時應該要多加ina08='0，且簽核否也要判斷單據性質較為合理
# Modify.........: No.MOD-780080 07/08/20 By pengu 替代碼非sut時發料料號欄位應不可修改
# Modify.........: No.MOD-780164 07/08/21 By kim 檢查訂單量是否超過時,當工單編號為NULL時得到的量會是0
# Modify.........: No.TQC-790002 07/09/03 By Sarah Primary Key：複合key在INSERT INTO table前需增加判斷，如果是NULL就給值blank(字串型態) or 0(數值型態)
# Modify.........: No.CHI-790021 07/09/17 By kim 修改-239的寫法
# Modify.........: No.MOD-790028 07/09/17 By Pengu 生產損耗率ima562應除100
# Modify.........: No.MOD-780247 07/09/17 By pengu 調整TQC-720063修改地方
# Modify.........: No.MOD-730044 07/09/19 By claire 需考慮採購單位與料件採購資料的採購單位換算
# Modify.........: No.MOD-7A0097 07/10/17 By Pengu 調整FUN-580165修改地方
# Modify.........: No.MOD-7A0107 07/10/18 By Pengu 有使用特性代碼時，單身BOM料號開窗應考慮特性代碼
# Modify.........: NO.MOD-7A0163 07/10/29 BY yiting 己產生委外採購單時，不可取消確認
# Modify.........: NO.MOD-790128 07/10/30 BY yiting 工單己產生製程資料時，生產料件不可修改
# Modify.........: No.MOD-7A0195 07/10/30 By Pengu 在計算替代料的欠料量會出現異常
# Modify.........: NO.MOD-7A0181 07/10/31 BY Yiting [預計完工日]在推算時,要參考asmi400所設定的，是否有含假日，若有不可列入工作天。
# Modify.........: NO.MOD-7B0024 07/11/05 BY claire 轉委外採購單時要計算超/短交率(pmn13)
# Modify.........: NO.MOD-7B0074 07/11/09 BY yiting 1.一般工單轉成委外工單時，部門/廠商編號沒有檢查 2.產生委外採購單時 到供應商的欄位亦未檢查資料
# Modify.........: NO.MOD-7B0072 07/11/09 BY yiting 己取消確認的料號不可新增工單
# Modify.........: No.TQC-7B0048 07/11/13 By Judy 母工單號(sfb86)開窗錯誤
# Modify.........: No.CHI-7B0023 07/11/16 By kim 移除GP5.0行業別功能的所有程式段
# Modify.........: No.FUN-710073 07/12/03 By jamie 1.UI將 '天' -> '天/生產批量'
#                                                  2.將程式有用到 'XX前置時間'改為乘以('XX前置時間' 除以 '生產單位批量(ima56)')
# Modify.........: No.FUN-7C0021 07/12/06 By Sarah 當新增工單時,若工單型態(sfb02)為11.拆件式工單時,重工(sfb99)預設值給Y
# Modify.........: No.MOD-7C0213 07/12/27 By Pengu 當生產批量含小數時，則KEY生產數量會出現"asf-308"錯誤訊息
# Modify.........: No.CHI-810015 08/01/17 By jamie 將FUN-710073修改部份還原
# Modify.........: No.FUN-7C0050 08/01/15 By johnray 串查程序代碼添加共用 ACTION 的引用
# Modify.........: No.FUN-810045 08/01/16 By rainy 項目管理 單身加活動編號sfb50)/理由碼sfb51)
# Modify.........: No.FUN-810017 08/02/01 By jan
# Modify.........: No.FUN-7B0018 08/02/16 By hellen 行業比拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.FUN-810038 08/03/03 By kim GP5.1 ICD
# Modify.........: NO.FUN-7C0002 08/03/07 BY Yiting  apsi213-->apsi316.4gl
# Modify.........: No.FUN-830086 08/03/21 By jan 修改服飾作業
# Modify.........: No.CHI-830032 08/03/26 By kim GP5.1 整合測試修改
# Modify.........: No.FUN-830132 08/03/27 By hellen 行業比拆分表以后，增加INS/DEL行業別TABLE
# Modify.........: No.FUN-830114 08/03/28 By jan修改服飾作業
# Modify.........: No.CHI-840001 08/04/01 By kim GP5.1 整合測試修改
# Modify.........: No.MOD-840027 08/04/08 By Pengu 委外工單不可走製程所以當工單型態若為7,8，則sfb93製程否應為N且不得修改。
# Modify.........: No.FUN-840042 08/04/15 by TSD.zeak 自訂欄位功能修改
# Modify.........: No.MOD-840306 08/04/20 By Pengu 試產工單無法輸入測試料號
# Modify.........: No.MOD-840419 08/04/21 By Pengu 委外工單確認後按委外採購,第一次不會顯示委外採購資訊
# Modify.........: No.FUN-840155 08/04/22 By jan修改服飾作業
# Modify.........: No.FUN-840178 08/04/24 By jan修改服飾作業
# Modify.........: No.MOD-840481 08/04/25 By kim GP5.1 整合測試修改
# Modify.........: No.FUN-820025 08/04/17 By Carol 試產性工單input查詢料號時應查測試料號(call q_bmq1)
# Modify.........: No.FUN-850115 08/05/14 By Duke delete 製令工單 & 製令外包資料
#                                            add 製令外包action
# Modify.........: No.MOD-850136 08/05/15 By claire 事後扣帳的工單,取消確認前應確認入庫單是否已有該工單的入庫資料
# Modify.........: No.MOD-850257 08/05/27 By claire 拆件式工單不可走製程
# Modify.........: No.MOD-850325 08/05/30 By claire 製程q_ecu條件應傳入料號
# Modify.........: No.MOD-860001 08/06/02 By claire 有輸入訂單號碼時,產品編號不可輸入不同於訂單的資料
# Modify.........: No.MOD-860055 08/06/05 By claire 訂單所產的工單,生產數>訂單數欄位要控卡
# Modify.........: No.FUN-850027 08/05/30 By douzh WBS編碼錄入時要求時尾階并且為成本對象的WBS編碼
# Modify.........: No.MOD-860081 08/06/10 By jamie ON IDLE問題
# Modify.........: No.MOD-860072 08/06/06 By claire 使用特性代碼時,料號代入ima910的特性代碼
# Modify.........: No.MOD-860125 08/06/13 By claire 非訂單轉入工單,列印時不該詢問asf-930,asf-931(印訂單備註)
# Modify.........: No.FUN-870012 08/06/25 by duke
# Modify.........: No.FUN-840194 08/06/25 By sherry 增加變動前置時間批量（ima061）
# Modify.........: No.MOD-870017 08/07/01 By claire 試產性工單,單身無展出備料時,程式會當出
# Modify.........: No.MOD-870028 08/07/02 By claire 單身人工輸入時,應找insert段卻走了update(on row change)
# Modify.........: No.MOD-840015 08/07/04 By Pengu 試產工單應確認E-BOM的有效碼
# Modify.........: No.CHI-7B0034 08/07/08 By sherry 增加被替代料(sfa27)為Key值
# Modify.........: No.MOD-850023 08/07/13 By Pengu after field sfa161時未考慮到發料批量
# Modify.........: No.MOD-850042 08/07/13 By Pengu 委外工單時廠商欄位不應卡pmc30 IN ('2','3')
# Modify.........: No.MOD-850091 08/07/13 By Pengu 工單作取替代時應該用替代料的作業編號與單位作為UPDATE的條件值
# Modify.........: No.MOD-860224 08/07/16 By Pengu 控管有報工資料(srg_file)時不允許取消確認
# Modify.........: No.FUN-870117 08/07/23 by ve007 增加出口國欄位，增加按作業編號分段備料功能
# Modify.........: No.CHI-860042 08/07/27 By xiaofeizhu 加入一般采購和委外采購的判斷
# Modify.........: No.FUN-870163 08/07/31 By sherry 預設申請數量=原異動數量
# Modify.........: No.FUN-870101 08/08/19 By jamie MES整合
# Modify.........: No.TQC-880054 08/09/01 By chenyu 替代碼為不可取代的時候，bom料號和發料料號會有不一致的情況
# Modify.........: No.MOD-880097 08/09/02 By claire 條件值調整,修改CHI-860042
# Modify.........: No.MOD-880254 08/09/02 By claire 取消確認工單時, 不能存在有效備料底稿sfq_file
# Modify.........: No.MOD-890023 08/09/04 By chenyu ICD功能修改
# Modify.........: No.FUN-7C0051 08/09/04 By sherry [預計完工入庫倉庫]&[預計完工入庫儲位]提供開窗查詢
# Modify.........: No.FUN-890085 08/09/18 BY DUKE  move table aps_smm
# Modify.........: No.MOD-890128 08/09/12 By claire 訂單的欄位控制與q_oea3應一致
# Modify.........: No.MOD-8A0194 08/10/22 BY claire 已結案的製造通知單不可再產工單
# Modify.........: No.MOD-8A0201 08/10/22 BY claire 製程委外採購單作廢後應可以對工單做取消確認
# Modify.........: No.MOD-8A0242 08/10/28 By chenyu 已經由asfp304轉成工單的訂單，手動錄入還可以過
# Modify.........: No.MOD-8B0015 08/11/04 By claire 刪除要先給初值g_success
# Modify.........: No.TQC-8B0011 08/11/05 BY duke 呼叫MES前先判斷aza90必須MATCHE [Yy]
# Modify.........: No.MOD-8B0254 08/11/24 BY claire 工單型態防呆控卡
# Modify.........: No.TQC-8C0016 08/12/12 By Mandy 刪除時,需同時刪除vmn_file資料
# Modify.........: No.CHI-8C0017 08/12/17 By xiaofeizhu 一般及委外問題處理
# Modify.........: No.TQC-8C0058 08/12/24 By Mandy 與APS串連時,需一併刪除平行加工資料vlj_file
# Modify.........: No.MOD-8C0175 08/12/24 By claire 供應商確認應考慮ima915的設定
# Modify.........: No.TQC-8C0081 08/12/29 By Duke 與APS串聯時,若刪除工單需連vnd_file,vne_file,vng_file,vnm_file資料一併刪除
# Modify.........: No.FUN-910005 09/01/06 By duke add 是否受供給法則限制相關欄位
# Modify.........: No.MOD-910016 09/01/08 By Smapmin 已作廢的工單不可轉委外採購單
# Modify.........: No.MOD-8C0279 09/01/09 By claire 試產工單的料號,品名應取試產性料號
# Modify.........: No.MOD-910155 09/01/14 By chenyu 開窗回傳值數量不對
# Modify.........: No.CHI-910028 09/01/16 By claire 訂單轉入的預計開工日及預計完工日推算有誤
# Modify.........: No.MOD-910148 09/01/16 By claire 母工單進單身一筆一筆刪除備料,也需一併將子工單刪除
# Modify.........: No.CHI-8C0050 09/01/20 By jan 解決母工單刪除后，無法產生備料的問題
# Modify.........: No.FUN-910122 09/02/01 By jan 解決刪除母工單時,存在已作廢的子工單的問題
# Modify.........: No.CHI-910021 09/02/01 By xiaofeizhu 有select bmd_file或select pmh_file的部份，全部加入有效無效碼="Y"的判斷
# Modify.........: No.CHI-910055 09/02/11 By jan aza27 & smy57_5 都要為'Y' 才能輸入手冊編號(sfb97)
# Modify.........: No.MOD-920188 09/02/13 By claire 產生雜發單,給inaconf='N',否則雜發單印不出來
# Modify.........: No.FUN-920054 09/02/25 By jan 1.新增刻號/BIN 查詢，刻號/BIN號出庫明細action
#                                                2.修改icd審核action
#                                                3.移除工單領料action
# Modify.........: No.FUN-920190 09/02/26 By kim 接續FUN-920054的修改，處理ICD工單取消確認和作廢，連同相關單據的處理
# Modify.........: No.CHI-920085 09/02/25 By jan 訂單/項次  當新值不等於舊值時，需將手冊編號(sfb97)清空
# Modify.........: No.FUN-920201 09/03/04 By jan ICD業 當 sfb02='7'時，則 sfb82 為必要欄位，反之則為非必要欄位
# Modify.........: No.CHI-930002 09/03/04 By jan sfbiicd01/02/03 此三欄位設為非必要輸入欄位
# Modify.........: No.MOD-930037 09/03/05 By lilingyu 修改預計完工日欄位時,跳出的信息不正確
# Modify.........: No.FUN-8C0081 09/03/06 By sabrina 與EasyFlow整合
# Modify.........: No.TQC-930119 09/03/17 By chenyu AFTER FIELD sfb50后面sfb50寫成fb50
# Modify.........: No.FUN-930145 09/03/17 By lala  理由碼sfb51必須為生產原因
# Modify.........: No.CHI-940010 09/04/08 By hellen 修改SELECT ima或者imaicd欄位卻未JOIN相關表的問題
# Modify.........: No.FUN-940045 09/04/08 By Carrier qbe時過濾掉從組合拆解產生的工單資料!
# Modify.........: No.FUN-930148 09/03/26 By ve007 采購取價和定價
# Modify.........: No.TQC-940069 09/04/14 By kim for ICD 當作業編號屬'6:Turnkey'時,製程編號應該要可以輸入
# Modify.........: No.TQC-940077 09/04/15 By chenyu 工藝編號開窗無資料，手工輸入可以過
# Modify.........: No.TQC-940079 09/04/15 By chenyu 非委外工單時，點“委外采購”時，應該給一個提示
# Modify.........: No.FUN-940008 09/04/20 By hongmei GP5.2發料改善中的欠料量修改
# Modify.........: No.TQC-940074 09/04/22 By sherry 刪除每一筆備料的時候，都要檢查該備料是否有子工單
# Modify.........: No.TQC-940161 09/04/27 By kim ICD SQL修改
# Modify.........: No.TQC-950056 09/05/12 By ve007 多單位顯示ICD欄位
# Modify.........: No.FUN-940083 09/05/21 By shiwuying 採購改善-VMI 修改原可收量的計算
# Modify.........: No.MOD-930247 09/05/21 By Pengu 替代碼為 0:不可取替代 的情況下, 發料料號仍可輸入與BOM料號不同
# Modify.........: No.MOD-940258 09/05/21 By Pengu 取消確認時應判斷是否有工時報工資料
# Modify.........: No.MOD-940349 09/05/21 By Pengu 控管境外倉出貨訂單不可轉工單
# Modify.........: No.MOD-940350 09/05/21 By Pengu ON ROW CHANGE時應判斷SQLCA.SQLERRD[1]是否等於1
# Modify.........: No.FUN-950021 09/05/31 By Carrier 組合拆解
# Modify.........: No.TQC-940070 09/06/05 By jan 當單頭作業編號類型為"6:Turnkey"時，sfb93應='Y'且不可被輸入，反之其他狀況時則可輸入且不控卡'Y/N'
# Modify.........: No.TQC-960234 09/06/19 By lilingyu 工單錄入完后,點"替代"按鈕,選擇"一般替代",錄入料件編號后點確定,會報錯:-284 一個子查詢傳回了不止一列
# Modify.........: No.TQC-950054 09/06/22 By jan updat行業別檔時，KEY值一并update
# Modify.........: No.TQC-960189 09/06/23 By lilingyu 非空字段sfa04可能出現NULL的情況
# Modify.........: No.MOD-940373 09/07/07 By Smapmin 執行一般替代功能,料件開窗後應一併帶回作業編號
# Modify.........: No.FUN-950088 09/07/01 By hongmei add sfa36,mse02
# Modify.........: No.TQC-970073 09/07/10 By lilingyu 將sfb251賦值語句調整到i301_i()后面
# Modify.........: No.MOD-970159 09/07/21 By mike 若在工單型態一開始選5、8、11后，重工否(sfb99)會自動帶Y，
#                                                 但若再修改為一般工單時，重工否未能隨修正而改為N
# Modify.........: No.FUN-950056 09/07/27 By chenmoyan 去掉ima920
# Modify.........: No.TQC-970391 09/08/03 By sherry sfb98控管了必須錄入，仍可以不錄跳過
# Modify.........: No.FUN-980008 09/08/14 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-870100 09/08/20 By Cockroach  對ina12,inapos賦默認值
# Modify.........: No.TQC-980141 09/08/19 By Carrier after field 單位后的重復判斷有問題時,check sfa26的狀態,確定是否要next field sfa03或是sfa12
# Modify.........: No.MOD-980224 09/09/01 By Smapmin q_pja2-->q_pja4
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-960038 09/09/04 By chenmoyan 專案加上'結案'的判斷
# Modify.........: No.FUN-980038 09/09/10 By chenmoyan sfb02的值由smy72代出
# Modify.........: No.MOD-990105 09/09/11 By sherry 修正工單無法入庫的情況
# Modify.........: No.MOD-990137 09/09/14 By lilingyu 如果該工單是委外工單,且未生成委外采購單,則單據名稱欄位smydesc建議顯示為單別
# Modify.........: No.CHI-970012 09/10/14 By jan 刪除母工單時，應作廢子工單
# Modify.........: No.CHI-960033 09/08/03 By chenmoyan 加pmh22為條件者，再加pm23=''
# Modify.........: No.MOD-9A0048 09/10/08 By Dido 由於 q_pja2 取消 pja12 判斷,故將 MOD-980224 還原
# Modify.........: No.TQC-9A0065 09/10/15 By liuxqa 制程編號開窗沒有值，卻可以手動錄入通過。
# Modify.........: No.MOD-990123 09/10/15 By Smapmin 在AFTER FIELD sfa161會判斷最小發料量與發料批量，請加控管重工工單與委外重工不作此判斷
# Modify.........: No.TQC-9A0134 09/10/26 By liuxqa 修改ROWID和OUTER
# Modify.........: No.FUN-990059 09/11/02 By jan 取替代時撈資料有效日期改為當前日期
# Modify.........: No.CHI-970059 09/11/02 By jan 控卡手動輸入單身時，同一張工單的sfa03不可重複
# Modify.........: No:CHI-980013 09/11/02 By jan sfa11的combobox.item加上"X:資訊參考"
# Modify.........: No:MOD-970045 09/07/13 By Pengu 訂單轉工單時，排除oea61>(oea62+oea63)的限制，且加上oeb70='N'的條件
# Modify.........: No:CHI-980019 09/11/05 By jan 虛擬料件不可做任何單據
# Modify.........: No:FUN-9B0045 09/11/06 By liuxqa substring.
# Modify.........: No:MOD-9A0203 09/11/06 By Pengu 以取替代的新/主料不應重推QPA
# Modify.........: No:MOD-9A0017 09/11/06 By Pengu 要給l_unit1變數給default值
# Modify.........: No.FUN-9A0034 09/10/12 By Carrier 拆件式工单,控制单身单号应与单头料号sfb05相同
# Modify.........: No:MOD-990120 09/11/10 By Pengu 當sma841不為'8'時，應使用生產料號檢查料件供應商資料
# Modify.........: No:MOD-990075 09/11/12 By sabrina 判斷供單生產數量是否大於訂單數量應排出重工工單
# Modify.........: No:MOD-980274 09/11/12 By sabrina 取消確認時應判斷是否有製程變更檔
# Modify.........: No:TQC-990052 09/11/13 By jan 當沒有帶出單身的時候，程序down出
# Modify.........: No:FUN-970079 09/11/16 By jan 修改update sfai_file 時的BUG
# Modify.........: No:TQC-9B0112 09/11/17 By Carrier sfb34 非负处理
# Modify.........: No:MOD-970068 09/11/26 By sabrina 數量欄位檢核異常
# Modify.........: No:FUN-9B0144 09/11/27 By jan 修改sfb01的開窗資料
# Modify.........: No:MOD-960244 09/11/27 By sabrina 刪除單身一筆資料時會將相關的替代料也一併刪除
# Modify.........: No:TQC-9B0214 09/11/25 By Sunyanchun  s_defprice --> s_defprice_new
# Modify.........: No:MOD-9C0228 09/12/19 By kim 已發完料的備料也要可以替代
# Modify.........: No:MOD-9C0231 09/12/19 By kim 主料+替代料總已發量不可大於總應發量
# Modify.........: No:MOD-9C0024 09/12/25 By Pengu 單身無資料時，無法再新增資料
# Modify.........: No:MOD-9C0040 09/12/25 By Pengu 試產性工單無法產生雜發單
# Modify.........: No.FUN-9C0072 10/01/11 By vealxu 精簡程式碼
# Modify.........: No:MOD-A10075 10/01/13 By sherry 取替代的時候，應卡取替代後，應發量不可以小於已發量
# Modify.........: No:MOD-A10017 10/01/13 By Pengu 若BOM設定為消耗性料件時，展備料時會備給回一般料件
# Modify.........: No:FUN-9C0040 10/01/29 By jan 工單備料的來源特性要加一項"S:回收料"
# Modify.........: No:FUN-A20037 10/02/24 By lilingyu工單"替代"action開窗時,新增3.規則替代
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: NO.FUN-A20048 10/03/30 By liuxqa 取消审核时，须判断是否存在工单备置，更新sfb104
# Modify.........: No:FUN-A20044 10/03/19 by dxfwo  於 GP5.2 Single DB架構中，因img_file 透過view 會過濾Plant Code，因此會造
#                                                 成 ima26* 角色混亂的狀況，因此对ima26的调整
# Modify.........: No:MOD-A40012 10/04/06 By Sarah 修正MOD-9A0203,取消工單型態不為5/8的限制
# Modify.........: No:MOD-A40006 10/04/07 By Summer 取消FUN-5B0117加上asf-909的控管
# Modify.........: No:MOD-A40017 10/04/08 By Sarah 在單身QPA欄位判斷QPA有改變時才重推應發量
# Modify.........: No:MOD-A40026 10/04/08 By Sarah 1.修改製程編號後應自動重新產生製程追蹤檔
#                                                  2.新增時勾選"製程",修改時改成不走製程,應將已產生的製程追蹤檔刪除,並將sfb24更新為N
# Modify.........: No:FUN-A40032 10/04/13 By lilingyu 過單
# Modify.........: No:FUN-A40023 10/04/13 By dxfwo 過單
# Modify.........: No:FUN-A30093 10/04/15 By jan sfa11的combobox.item加上"C:客供料"
# Modify.........: No:MOD-A40119 10/04/21 By Sarah 修正MOD-A40026,之前判斷當製程編號有變成時才重新產生製程資料,改成只要工單單頭有異動但製程無資料就重新產生
# Modify.........: No:MOD-A40130 10/04/21 By Sarah 替代時,檢核asf-072的判斷式調整(l_sfa05已是加上此次替代的數量)
# Modify.........: No:MOD-A40133 10/04/22 By Sarah 修改訂單單號與項次時,先檢查此訂單編號+項次是否存在訂單檔裡,若是才做asf-005的檢核
# Modify.........: No:MOD-A40160 10/04/27 By Sarah 續MOD-A40133,當經過訂單項次,有抓到訂單的oeb15時才以此值重新帶出sfb15
# Modify.........: No:MOD-A50016 10/05/04 By Sarah 當MPS分批拋入工單,修改工單單頭時重算的生產數量有誤
# Modify.........: No:MOD-A50107 10/05/16 By Sarah 做替代時,當替代數量輸入0不需寫入備料檔
# Modify.........: No:MOD-A50106 10/05/18 By liuxqa 单身时，更改料号后，发料单位并未做修改。
# Modify.........: No:MOD-A50131 10/05/19 By liuxqa 做替代時，須檢查最小發料倍數和最少發料量
# Modify.........: No:MOD-A50141 10/05/24 By Sarah 將"工單變更/挪料"ACTION改為"挪料"
# Modify.........: No:MOD-A50142 10/05/24 By Sarah 當預計開工日(sfb13)小於開單日期(sfb81)時,預設sfb13=sfb81
# Modify.........: No:MOD-A50158 10/05/24 By Sarah 做取替代後,替代料的應發量沒依發料批量進取位
# Modify.........: No:CHI-A50032 10/05/26 By Summer 增加一個ACTION"工單變更"
# Modify.........: No:TQC-A50142 10/05/27 By houlia 調整單身作業編號欄位開窗
# Modify.........: No:MOD-A50195 10/05/28 By Sarah 當訂單分批拋入工單,修改工單單頭時重算的生產數量有誤
# Modify.........: No:TQC-A50141 10/05/31 By houlia 給新增欄位sfa012、sfa013、ecm012賦初值
# Modify.........: No:FUN-A50066 10/06/01 By jan 單身新增欄位sfa012/sfa013
# Modify.........: No:MOD-A60073 10/06/10 By Sarah 計算同一訂單之其他張工單生產數量時,未排除作廢單據
# Modify.........: No:FUN-A60088 10/06/28 By jan 平行製程時,調整產生/刪除備料檔的邏輯
# Modify.........: No:MOD-A70105 10/07/14 By Sarah i301_sfa05()應以sfa03抓取元件的ima64與ima641
# Modify.........: No:MOD-A70142 10/07/19 By Sarah 有輸入製造通知單號時,產品編號不可輸入不同於製造通知單的資料
# Modify.........: No:MOD-A80050 10/08/09 By sabrina sfb14、sfb16給預設值00:00
# Modify.........: No.FUN-A80102 10/08/24 By kim GP5.25號機管理
# Modify.........: No.FUN-A80054 10/08/31 By jan GP5.25工單間合拼
# Modify.........: No:MOD-A80207 10/08/27 By sabrina (1)i301_dealc_cs抓取子工單資料時需排除sfb01=sfb86
#                                                    (2)asf-978的SQL也應排除sfb01=sfb86
# Modify.........: No:MOD-A90069 10/09/23 By Summer 工單取替代後應發參考數量不對
# Modify.........: No:MOD-A90097 10/09/23 By Summer 在after field sfb05時控管料號不可為MISC開頭的料
# Modify.........: No.FUN-A80060 10/09/27 By jan GP5.25工單間合拼(程式調整)
# Modify.........: No:MOD-A90186 10/09/30 By sabrina 當有備料時(sfb23='Y')，特性代碼不可以修改
# Modify.........: No:FUN-AA0007 10/10/14 By jan 若輸入的批號之ids17='Y',则控卡不能输入
# Modify.........: No:FUN-A10138 10/10/21 By jan 拿掉sfbiicd08欄位及相關處理邏輯
# Modify.........: No:MOD-AA0130 10/10/21 By sabrina 替代碼要為"0125"時才可變更實際QPA的值
# Modify.........: No:MOD-AA0160 10/10/26 By sabrina 還原CHI-970059及MOD-AA0130
# Modify.........: No.FUN-AA0059 10/10/28 By chenying 料號開窗控管
# Modify.........: No.FUN-AA0059 10/10/29 By huangtao 修改料號AFTER FIELD的管控
# Modify.........: No.FUN-AA0050 10/11/03 By zhangll 仓库营运中心控管
# Modify.........: No.FUN-AB0025 10/11/05 By huangtao mod料號控管
# Modify.........: No.FUN-AB0054 10/11/12 By zhangll 倉庫營運中心權限控管審核段控管
# Modify.........: No:TQC-AB0244 10/11/30 By chenying 試產型工單維護完虛擬料號後按確定會報無此產品結構資料的錯誤
# Modify.........: No:FUN-A50032 10/12/09 By Lilan 控制EF簽核時,ICD行業別不可執行的ACTION
# Modify.........: No.TQC-AC0257 10/12/22 By suncx s_defprice_new.4gl返回值新增兩個參數
# Modify.........: No:MOD-AC0323 10/12/24 By sabrina 還原TQC-960234的修改
# Modify.........: No:MOD-930073 10/12/25 By sabrina i301_b()FUNCTION中的BEFORE INSERT程式段加上LET g_sfa[l_ac].sfa26 = '0'
# Modify.........: No:TQC-A80169 10/12/27 By destiny 输入完主件料号后应自动带出bom版本号
# Modify.........: No:MOD-AC0336 10/12/28 By jan 重抓製程料號
# Modify.........: No:MOD-B10155 11/01/20 By sabrina asf-978應排除作發子工單
# Modify.........: No:MOD-B10180 11/01/24 By sabrina 做取替代時，若被替代料有重覆，則只取一筆
# Modify.........: No:MOD-B20027 11/02/10 By sabrina BOM料號改完後，發料料號並沒有變更
# Modify.........: No.FUN-B10056 11/02/12 By vealxu 修改制程段號的管控
# Modify.........: No:MOD-B10225 11/01/26 By sabrina 失效日期也會造成資料重覆，將生失效日期改為在where裡判斷
# Modify.........: No:FUN-AB0089 11/02/25 By shenyang  修改本月平均單價
# Modify.........: No.MOD-B30028 11/03/04 By zhangll 修正插入sfci_file,系统异常当出问题
# Modify.........: No.FUN-B30017 11/03/07 By jan 手動輸入工單備料資料時,作業編號應從ecm_file自動帶出
# Modify.........: No.MOD-B30465 11/03/14 by shenyang sfb06的欄位檢查及開窗，請加上過濾 ecu_file.確認碼='Y'的資料
# Modify.........: No.MOD-B30414 11/03/14 by jan 確認是否是合拼工單的條件更改
# Modify.........: No.TQC-B30216 11/03/31 by destiny 规格替代时程序会荡出
# Modify.........: No.TQC-B40002 11/04/01 by destiny 管控开单日期不能小于预计开工日
# Modify.........: No.FUN-9C0119 11/04/06 by shenyang 添加複製功能
# Modify.........: No.TQC-B40025 11/04/12 by destiny 取替代时如果没有更新资料则不应该提示更新资料成功
# Modify.........: No:MOD-B40106 11/04/13 By sabrina 當sfb07不為null時，則不重新抓值
# Modify.........: No.FUN-B40029 11/04/13 By xianghui 修改substr
# Modify.........: No.FUN-AC0074 11/04/20 By shenyang 修改備置量
# Modify.........: No.TQC-B40216 11/04/27 By zhangll 替代時增加考慮生效日
# Modify.........: No:TQC-A10124 11/04/28 By abby MES新增替代料件功能
# Modify.........: No:FUN-9A0095 11/04/14 By abby MES功能追版
# Modify.........: No:TQC-B40221 11/04/28 By zhangll 發料倍量控管算法修正
# Modify.........: No:FUN-B50046 11/05/19 By abby APS GP5.25追版str-----------------------
# Modify.........: No:FUN-930127 09/03/25 By Duke insert vmw_file add vmw26=0
# Modify.........: No:TQC-940179 09/04/29 By Duke 產生製程時，同步產生vmn_file,vnm_file 的資料
# Modify.........: No:FUN-960025  09/06/04 By Duke 當工單型態sfb02='7'時,若凍結碼(sfb41)='Y'時,若vnf_file有此單據資料,則需將vnf03 update成 '2',else
#                                                 若凍結碼(sfb41)='N'時,若vnf_file有此單據資料,則需將vnf03 update成 '1'
# Modify.........: No:FUN-9A0029 09/10/26 By Mandy 有跟APS整合時,畫面可輸入sfb14,sfb16,紀錄到[時:分]
# Modify.........: No:FUN-B50046 11/05/19 By abby APS GP5.25追版end-----------------------
# Modify.........: No:MOD-B40154 11/05/20 By vampire 查詢部門廠商開窗時應該input段一樣
# Modify.........: No:FUN-B50106 11/05/25 By lixh1 將icb05替換為imaicd14
# Modify.........: No.FUN-B50064 11/06/02 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No:TQC-B50078 11/05/13 By destiny 當替代量為小數時，折合量計算不正確，導致發料量不足
# Modify.........: No.FUN-A70095 11/06/14 By lixh1 撈取報工單(shb_file)的所有處理作業,必須過濾是已確認的單據
# Modify.........: No.TQC-B60365 11/06/39 By guoch 對 l_ima64進行判斷
# Modify.........: No.FUN-B50026 11/07/05 By zhangll 單號控管改善
# Modify.........: No.MOD-B70035 11/07/06 By sabrina 加入aoo-403理由碼控卡
# Modify.........: No.MOD-B70051 11/07/07 By lilingyu 單身若存在取替代情況下,刪除其中一筆資料,提示報錯信息,實際後台有刪除多筆資料,但是畫面沒顯示出來
# Modify.........: No.TQC-B70126 11/07/13 By jan 檢查料件是否存在BOM理的邏輯，sma52應該是sma542才對
# Modify.........: No:MOD-B30605 11/07/17 By JoHung 當工單為結案狀態，不允許新增委外採購單
# Modify.........: No:MOD-B60227 11/07/18 By Vampire 當工單型態等於再加工工單時，不去控管生產數量
# Modify.........: No:FUN-B70074 11/07/26 By fengrui 添加行業別表的新增於刪除
# Modify.........: No.TQC-B70202 11/07/27 By zhangll 修正單身顯示錯誤
# Modify.........: No.TQC-B80022 11/08/02 By jason INSERT INTO ecm_file給ecm66預設值'Y'
# Modify.........: No.TQC-B80070 11/08/04 By houlia  規則替代時資料INSERT到行業別table
# Modify.........: No:TQC-B50031 11/08/04 By lilingyu 新增一筆試產工單,尚未審核資料時,點擊"生成雜發單",系統沒有任何反應,也無提示
# Modify.........: No:TQC-B40211 11/08/04 By lilingyu 選擇"規則替代"時,沒有根據設置的資料產生單身
# Modify.........: No:TQC-B80092 11/08/09 By houlia prompt 語言別維護
# Modify.........: No:TQC-B50022 11/08/15 By lilingyu 新增完單身後,點擊確定按钮保存时,报错-268:违反唯一的限制
# Modify.........: No:TQC-B80089 11/08/25 By Abby 調整TQC-940179程式段位置
# Modify.........: No:TQC-B90003 11/09/01 By lilingyu 調整TQC-B50022的修改問題
# Modify.........: No.CHI-B80096 11/09/02 By xianghui 對組成用量(ecm62)/底數(63)/ecm66(關鍵報工點否)的預設值處理
# Modify.........: No.FUN-B80119 11/09/14 By fengrui  增加調用s_icdpost的p_plant參數
# Modify.........: No:CHI-B80053 11/10/11 By johung 成本中心是null時，帶入輸入料號的ima34
# Modify.........: No:MOD-BA0105 11/10/17 By johung 調整QPA修改時會沒有更新應發數量的問題
# Modify.........: No:MOD-BA0116 11/10/18 By destiny 新增一笔资料退出单身，再次进入单身将单身资料删掉，重新录入一次确定退出单身，第3次进入单身，单身资料会消失
# Modify.........: No.FUN-B90008 11/10/25 By jason 規格替代它條件符合應該要抓出來，不該只抓第一筆
# Modify.........: NO:CHI-B80044 11/10/17 By johung 訂單轉工單且料有設生產批量時，生產數量應為批量的倍數，若大於訂單數則不可超過批量數
#                                                   生產數量大於訂單數時不控卡，僅提示訊息
# Modify.........: No:CHI-B50051 11/11/01 By Vampire 將 asf-740 移除
# Modify.........: No:TQC-BA0162 11/10/19 By destiny insert sfai_file 时应该分行业别
# Modify.........: No:TQC-B90236 11/11/08 By zhuhao 替代碼(sfa26)：增加選項"9.主料可做配方替代、A.主料,已做配方替代、B.副料,(配方替代料件)、C.副料,(配方回扣料件)"
#                                                   單身資料維護時，替代碼(sfa26)不可手動選擇A,B,C的選項
#                                                   Action"取替代(i301_s)"，抓取bmd_file的SQL加上條件 bmd02<>'3'
# Modify.........: No.FUN-BA0051 11/11/10 By jason 一批號多DATECODE功能
# Modify.........: No:MOD-BB0005 11/11/12 By johung 當備料已作取代時，不作最小發料量/發料批量的檢查
# Modify.........: No:TQC-BB0224 11/11/25 By jan 若PBI資料已確認,則不可清空sfb85的資料
# Modify.........: No.FUN-BC0008 11/12/02 By zhangll s_cralc4整合成s_cralc,s_cralc增加傳參
# Modify.........: No:FUN-BB0083 11/12/28 By xujing 增加數量欄位小數取位 sfai_file
# Modify.........: No:TQC-BC0032 12/01/09 By destiny 进入sfa161栏位时程序会进死循环
# Modify.........: No:TQC-BC0072 12/01/09 By destiny sfa11栏位会自动修改
# Modify.........: No:TQC-BC0129 12/01/09 By destiny 试产型工单应管控bom版本为必输
# Modify.........: No:TQC-BC0154 12/01/09 By destiny 更改时工单号不允许修改
# Modify.........: No.FUN-BC0103 12/01/13 By jason PIN COUNT以料號設定優先帶入,若無資料則帶icj_file設定
# Modify.........: No:FUN-B50095 12/01/13 By jason 單身新增欄位sfa16標準QPA
# Modify.........: No:TQC-BC0120 12/01/16 By SunLM 對inb10賦初值,從ima24獲得
# Modify.........: No:TQC-BC0071 12/01/16 By SunLM 修改錯誤提示,asf-020-->asf-509
# Modify.........: No.FUN-BB0086 12/01/17 By tanxc 增加數量欄位小數取位
# Modify.........: No.FUN-910088 12/01/18 By chenjing 增加數量欄位小數取位
# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No:FUN-C20027 12/02/04 By Abby EF功能調整-客戶不以整張單身資料送簽問題
# Modify.........: No.FUN-BC0109 12/02/08 By jason for ICD Datecode回寫多筆時即以","做分隔
# Modify.........: No:FUN-C20068 12/02/10 By chenjing 增加數量欄位小數取位
# Modify.........: No:TQC-C10041 12/02/13 By lilingyu 試產工單自動生成的雜發單沒有將[項目編號sfb27]的值帶入到雜發單的[項目編號ina06]中
# Modify.........: No:MOD-B80308 12/02/27 By Vampire TQC-B60365使用的l_ima64是抓到替代料而非主料
# Modify.........: No:FUN-C20126 12/02/23 By Abby 增加判斷：已確認的工單才可拋MES
# Modify.........: No:MOD-C30037 12/03/05 By ck2yuan 恢復取替代數量為0時產生在單身
# Modify.........: No:FUN-C30017 12/03/06 By Mandy (1)TP端簽核時,[工單變更]ACTION要隱藏
#                                                  (2)送簽中應不可執行：[取替代]、[委外採購], [挪料]、[工單變更]、[APS資料維護]、[APS製令外包] Action
# Modify.........: No.MOD-C30548 12/03/12 By chenjing 增加AFTER FIELD/AFTER INPUT sfb44存在否判斷
# Modify.........: No:TQC-C30193 12/03/12 By jason ecm12給預設值
# Modify.........: No:FUN-C30210 12/03/15 by bart "WAFER"action拿掉
# Modify.........: No:MOD-C30754 12/03/16 By ck2yuan 串she與sfw應使用 l_sfb01
# Modify.........: No:TQC-C30300 12/03/26 By destiny 应发数量为0时不用考虑最小批量
# Modify.........: No:FUN-C30250 12/03/27 By bart 於工單開立時判斷若sfb02(工單型態) <> 7,8(非委外)則依參數控制是否自動產生發料單
# Modify.........: No:MOD-C30889 12/03/30 By ck2yuan 工單複製選擇3時,sfb23要為N
# Modify.........: No:TQC-C30238 12/04/01 By destiny 料件特性从回收料改为一般料件时应当判断一下qpa和应发数量是否大于0
# Modify.........: No:MOD-C30887 12/04/02 By Elise 工單複製時，新工單的sfb101預設為空
# Modify.........: No:MOD-C40012 12/04/03 By ck2yuan 刪除元件時,查詢子工單條件修改
# Modify.........: No:FUN-C30274 12/04/03 By jason 1.單身修改倉儲批時,發料單應刪除重新產生 2.DS或AS,FT工單,單頭的生產數量,應於挑選刻號/BIN後回寫
#                                                  3.單身的發料批號要獨立到另外一個table，批號維護要和刻號BIN一起維護     4.pin count抓的順序要先抓aici011抓不到才抓料件主檔
# Modify.........: No:FUN-C30291 12/04/19 By bart ICD增加報表：工單發料表
# Modify.........: No:FUN-C30300 12/04/19 By bart 倉儲批開窗需顯示參考單位數量
# Modify.........: No:FUN-C30302 12/04/20 By bart 修改 s_icdout 回傳值
# Modify.........: No:TQC-C50011 12/05/04 By lixh1 ICD業刪除備料時需要刪除sfaa_file的資料
# Modify.........: No:MOD-C40045 12/05/08 By ck2yuan 刪除元件時,子工單的刪除調整
# Modify.........: No:TQC-C50140 12/05/16 By Sarah 作業群組是5.FT時也應一併回寫發料單身的應發參考數量,單頭的生產數量
# Modify.........: No:TQC-C30232 12/05/17 By destiny 替代码为6不应该管控实际qpa不能为0,并不能修改qpa
# Modify.........: No:TQC-C50189 12/05/21 By Sarah 進入多倉儲批的畫面後,按右邊的「刻號/BIN明細維護」會出現-268的錯誤
# Modify.........: No:TQC-C50186 12/05/22 By fengrui 生產數量考慮已出貨量與已銷退量
# Modify.........: No:FUN-C50108 12/05/24 By bart 當pnz08='N'時,才做aic-139或aic-140的檢核
# Modify.........: No:FUN-C50122 12/05/28 By bart 單位轉換給預設值
# Modify.........: No:TQC-C60028 12/06/04 By bart 只要是ICD行業 倉儲批開窗改用q_idc
# Modify.........: No:TQC-C60019 12/06/04 By Sarah ICD行業別時,進入單身或做備料刪除時都要一併刪除idb_file資料
# Modify.........: No:TQC-C60017 12/06/04 By Sarah ICD行業別時,備料料號不做刻號/BIN或DateCode管理就不以idb_file的數量回寫單頭單身的數量
# Modify.........: No:TQC-C60025 12/06/06 By Sarah ICD行業別時,備料單身勾選多倉儲批維護的資料有問題
# Modify.........: No.TQC-C60079 12/06/11 By fengrui 函數i501sub_y_chk添加參數
# Modify.........: No:MOD-C60154 12/06/18 By ck2yuan 開啟asfi301m(產生雜發單),理由碼開窗應為q_azf01a
# Modify.........: No:TQC-C60185 12/06/27 By bart 備料底稿數量換算與回寫
# Modify.........: No:FUN-C30085 12/07/05 By nanbing CR改串GR
# Modify.........: No:TQC-C70115 12/07/18 By fengrui 單身BEFORE ROW中更新g_ima數組
# Modify.........: No:TQC-C70122 12/07/19 By fengrui 修改點供需查詢按鈕down出問題
# Modify.........: No:TQC-C70119 12/07/20 By lixh1 沒有選取資料是不可使用'產生備料'ACTION
# Modify.........: No:FUN-C30114 12/08/07 By bart 新增欄位上階工單單號(sfb89)
# Modify.........: No:TQC-C80048 12/08/07 By xujing 增加asms280中sma26 = 1 時,點擊產生製程給出相關訊息
# Modify.........: No:FUN-C30145 12/08/08 By bart 修改單身時，如該元件有子工單，則修改數量時需顯示警告訊息"此元件已產生子工單資料"
# Modify.........: No:FUN-C30047 12/08/08 By bart asfi301生產料件可輸入特性主件料號(ima928='Y')，但需檢查是否有聯產品設定
# Modify.........: No:MOD-C80034 12/08/09 By Elise 工單維護單身,開窗應帶出"該料該製程編號"的"製程編號"
# Modify.........: No:TQC-C50227 12/08/13 By SunLM  組合拆解工單可以查詢,但不可取消審核和取消過帳
# Modify.........: No:FUN-C80046 12/08/13 By bart 複製後停在新料號畫面
# Modify.........: No:MOD-C80093 12/08/14 By ck2yuan 取替代時且不走平行製程,sfa012 sfa013不應都是預設值 應抓被料檔中的才對
# Modify.........: No:FUN-C80023 12/08/14 By bart 重工欄位不可修改
# Modify.........: No:TQC-C80129 12/08/22 By fengrui 修改日期預設與日期檢查
# Modify.........: No:CHI-C80056 12/08/22 By bart 單頭製程編號未輸入時，開窗抓取該料件所有作業編號
# Modify.........: No:CHI-C60023 12/08/20 By bart 新增欄位-資料類別sfd09
# Modify.........: No.FUN-C60004 12/08/31 By pauline 將bxa02加入為PK值
# Modify.........: No:MOD-C90005 12/09/03 By suncx 啟用機號管理時，手動錄入訂單，帶出訂單計畫批號到sfb919
# Modify.........: No:CHI-C90009 12/09/05 By bart 替代action預設帶入遊標所指元件
# Modify.........: No:MOD-C90033 12/09/06 By Elise 恢復傳倉儲批參數到s_icdchk中
# Modify.........: No:CHI-C90045 12/10/09 By bart 委外工單確認時，自動產生委外採購單,發料單自動扣帳確認,工單確認需連動
# Modify.........: No:MOD-C90137 12/10/11 By Elise 若idc04為NULL則給預設值' '
# Modify.........: No:MOD-C90069 12/10/11 By Elise 修正QPA回推
# Modify.........: No:MOD-CA0019 12/10/12 By Elise AFTER FIELD sfb82需先將g_errno清空
# Modify.........: No:CHI-C30077 12/10/18 By bart 規格替代數量需可還原
# Modify.........: No:MOD-CB0005 12/11/01 By suncx 修正QPA回推問題，MOD-C90069未完全修正
# Modify.........: No.FUN-CB0014 12/11/12 By fengrui 增加資料清單
# Modify.........: No.CHI-C90006 12/11/26 By bart 失效判斷
# Modify.........: No:TQC-CB0043 12/11/15 By xuxz 先備置后替代時候數量控管
# Modify.........: No.FUN-CB0087 12/12/20 By xujing 倉庫單據理由碼改善
# Modify.........: No:TQC-D10024 13/01/06 By qirl 訂單後面的邏輯放到訂單號之後
# Modify.........: No:MOD-CC0152 13/01/11 By Elise 使用單別自動帶的工單形態(5.再加工工單)時,工單資料(二)的重工需自動勾選
# Modify.........: No:MOD-CC0117 13/01/11 By Elise 工單輸入訂單單號後,生產批量為0時,顯示生產數量
# Modify.........: No:MOD-CB0029 13/01/11 By Elise 若單別有做預算控卡,開窗輸入費用原因參數傳7
# Modify.........: No:MOD-CB0019 13/01/11 By Elise sfaiicd03僅做img_file檢核，若不存在則show警告訊息
# Modify.........: No:FUN-CC0122 13/01/18 By Nina 修正MES標準整合外的工單無拋轉至MES，但在進行工單變更時卻拋轉MES並回饋工單不存在，導致該類工單變更拋轉失敗
# Modify.........: No:MOD-D10066 13/01/22 By bart 計算可生產量抓取訂單資料時，不需計算已出貨量，僅抓取oeb12即可
# Modify.........: No:MOD-D10118 13/01/17 By bart 複製時，簽核欄位應重抓單別設定資料
# Modify.........: No.TQC-D10084 13/01/28 By xujing  資料清單頁簽不可點擊單身按鈕
# Modify.........: No:CHI-C80041 13/02/06 By bart 排除作廢
# Modify.........: No:CHI-D20010 13/02/20 By yangtt 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No.MOD-D20110 13/12/23 By Alberti 修正SQL撈已開工數量
# Modify.........: No.MOD-D30027 13/03/05 By bart ICD一般料不使用i301_icd_gen_allotment
# Modify.........: No.MOD-D30045 13/03/06 By Alberti 修改多倉儲發料之變數宣告
# Modify.........: No.MOD-D30024 13/03/07 By bart 無資料要清空 g_sfa
# Modify.........: No.MOD-D30050 13/03/08 By bart 在EXECUTE i301_icd_upd_cho2之前，多判斷if l_ac2>0才執行
# Modify.........: No:CHI-C50029 13/03/08 By Alberti 當下階料皆為消耗性料件時，提示訊息並修改單頭扣帳方式為2:事後扣帳
# Modify.........: No:MOD-D30090 13/03/11 By bart 修正display錯誤
# Modify.........: No:MOD-D30095 13/03/11 By bart 需刻號BIN管理才判斷idb20 = 'Y'
# Modify.........: No:MOD-D30120 13/03/15 By bart 產生備料時需update製程追蹤檔
# Modify.........: No:FUN-D10127 13/03/15 By Alberti 增加sfduser,sfdgrup,sfdmodu,sfddate,sfdacti
# Modify.........: No.DEV-D30026 13/03/15 By Nina GP5.3 追版:DEV-CA0007、DEV-CB0005、DEV-CC0001、DEV-D10004、DEV-D10007以上為GP5.25 的單號
# Modify.........: No:FUN-D30030 13/03/20 By Nina 修正參數aoos010的是否與M-Barcode整合設定為'N'時有顯示'條碼相關'的功能
# Modify.........: No:MOD-D30198 13/03/22 By bart 加上distinct
# Modify.........: No.DEV-D30037 13/03/21 By TSD.JIE 有用smyb01="2:條碼單據"的控卡的改為用單身任一筆(MIN(項次)判斷即可)料件是否為包號管理(ima931)='Y'
# Modify.........: No:MOD-D30200 13/03/22 By ck2yuan 判斷如單身全為一般料，詢問是否改為1.檢料發料(同單身全為消耗性料件處理方式)
# Modify.........: No:DEV-D30045 13/03/26 By TSD.JIE 1.調整確認自動產生barcode
#                                                    2.調整取消確認自動作廢barcode
# Modify.........: No:CHI-D40002 13/04/08 By bart icm_file 排除失效
# Modify.........: No:FUN-D40030 13/04/08 By xumm 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No.DEV-D40015 13/04/18 By Nina 調整取消確認時條碼作廢段移至asfi301_sub
# Modify.........: No.MOD-D50063 13/05/08 By suncx 委外工單時，根據asmi300中設置的委外類型帶出sfb100的值，其他工單sfb100=1
# Modify.........: No.MOD-D50081 13/05/11 By suncx sma541和sma542在系統初始時可能為空，在程序開始先判斷是否為空，為空則當N處理
# Modify.........: No.MOD-D50082 13/05/11 By suncx CHI-B80044根據批量計算生產數量時有一段邏輯放錯位置，導致先錄入數量再錄入訂單時無法帶出生產數量
# Modify.........: No.MOD-D50191 13/05/23 By suncx 兩邊都改為asfp304的邏輯，oeb72有值則sfb071取自oeb72，無值則按原來sfb071的取法取值
# Modify.........: No.MOD-D60038 13/06/05 By suncx 录入前给sfb071赋默认值
# Modify.........: No.FUN-D60039 13/06/07 By fengrui 小數取位統一為進一制
# Modify.........: No.MOD-D60069 13/06/08 By suncx 取替代時，應該是替代加減量/替代率<未發量-備置量才對
# Modify.........: No.MOD-D60143 13/06/18 By suncx 取替代時新增管控，單身選擇未勾選不讓錄入替代价减量
# Modify.........: No.MOD-D60244 13/06/28 By yuhuabao 取替代界面未带出作业编号
# Modify.........: No:FUN-D40103 13/05/09 By lixh1 增加儲位有效性檢查
# Modify.........: No.TQC-D50126 13/05/29 By lixh1 拿掉部份儲位有效性檢查
# Modify.........: No.TQC-D70019 13/07/02 By yangtt 修改去替代時折合量計算問題

DATABASE ds   #MOD-640505

GLOBALS "../../config/top.global"

#模組變數(Module Variables)
DEFINE
    g_sfb   RECORD LIKE sfb_file.*,
    g_sfb_t RECORD LIKE sfb_file.*,
    g_sfb_o RECORD LIKE sfb_file.*,
    g_yy,g_mm       LIKE type_file.num5,                 #No.FUN-680121 SMALLINT,              #
    b_sfa   RECORD LIKE sfa_file.*,
    g_ima   RECORD LIKE ima_file.*,
    g_bmb   RECORD LIKE bmb_file.*,
    g_sfa     DYNAMIC ARRAY OF RECORD    #程式變數(Prinram Variables)
                 sfa012    LIKE sfa_file.sfa012,  #FUN-A50066
                 ecu014    LIKE ecu_file.ecu014,  #FUN-A50066
                 sfa013    LIKE sfa_file.sfa013,  #FUN-A50066
                 sfa27     LIKE sfa_file.sfa27,
                 sfa08     LIKE sfa_file.sfa08,
                 sfa26     LIKE sfa_file.sfa26,
                 sfa28     LIKE sfa_file.sfa28,
                 sfa03     LIKE sfa_file.sfa03,
                 ima02_b   LIKE ima_file.ima02,
                 ima021_b  LIKE ima_file.ima021,
                 ima08_b   LIKE ima_file.ima08,
                 sfa12     LIKE sfa_file.sfa12,
                 sfaiicd02 LIKE sfai_file.sfaiicd02,  #FUN-810038
                 sfa13     LIKE sfa_file.sfa13,
                 sfa11     LIKE sfa_file.sfa11,
                 sfa16     LIKE sfa_file.sfa16,   #FUN-B50095
                 sfa161    LIKE sfa_file.sfa161,
                 sfa100    LIKE sfa_file.sfa100,
                 sfa05     LIKE sfa_file.sfa05,
                 sfaiicd01 LIKE sfai_file.sfaiicd01,  #FUN-810038  #No.MOD-890023 add
                 sfaislk01 LIKE sfai_file.sfaislk01,       #No.FUN-810017
                 sfa065    LIKE sfa_file.sfa065,
                 sfa06     LIKE sfa_file.sfa06,
                 sfaiicd04 LIKE sfai_file.sfaiicd04,  #FUN-810038
                 sfa062    LIKE sfa_file.sfa062,
                 sfaud02 LIKE sfa_file.sfaud02,
                 sumsfe   LIKE  oeb_file.oeb12,  #add by chuyl 140116
                 sfaud03 LIKE sfa_file.sfaud03,
                 sfaud04 LIKE sfa_file.sfaud04,
                 sfaud05 LIKE sfa_file.sfaud05,
                 sfaiicd05 LIKE sfai_file.sfaiicd05,  #FUN-810038
                 short_qty LIKE sfa_file.sfa07,       #FUN-940008 add
                 sfa063    LIKE sfa_file.sfa063,
                 sfa064    LIKE sfa_file.sfa064,
                 sfaiicd06 LIKE sfai_file.sfaiicd06,  #FUN-C30274
                 sfa30     LIKE sfa_file.sfa30,
                 sfa31     LIKE sfa_file.sfa31,
                 sfa36     LIKE sfa_file.sfa36,       #FUN-950088
                 mse02     LIKE mse_file.mse02,       #FUN-950088
                 sfaiicd03 LIKE sfai_file.sfaiicd03   #FUN-810038
                 ,sfaud01 LIKE sfa_file.sfaud01,
                 sfaud06 LIKE sfa_file.sfaud06,
                 sfaud07 LIKE sfa_file.sfaud07,
                 sfaud08 LIKE sfa_file.sfaud08,
                 sfaud09 LIKE sfa_file.sfaud09,
                 sfaud10 LIKE sfa_file.sfaud10,
                 sfaud11 LIKE sfa_file.sfaud11,
                 sfaud12 LIKE sfa_file.sfaud12,
                 sfaud13 LIKE sfa_file.sfaud13,
                 sfaud14 LIKE sfa_file.sfaud14,
                 sfaud15 LIKE sfa_file.sfaud15
              END RECORD,
    g_sfa29   DYNAMIC ARRAY of LIKE sfa_file.sfa29,  #No.FUN-680121 VARCHAR(40), #MOD-590218
    g_sfa01   DYNAMIC ARRAY of LIKE sfa_file.sfa01,  #FUN-940001 add
    g_sfa_t   RECORD
                 sfa012    LIKE sfa_file.sfa012,  #FUN-A50066
                 ecu014    LIKE ecu_file.ecu014,  #FUN-A50066
                 sfa013    LIKE sfa_file.sfa013,  #FUN-A50066
                 sfa27     LIKE sfa_file.sfa27,
                 sfa08     LIKE sfa_file.sfa08,
                 sfa26     LIKE sfa_file.sfa26,
                 sfa28     LIKE sfa_file.sfa28,
                 sfa03     LIKE sfa_file.sfa03,
                 ima02_b   LIKE ima_file.ima02,
                 ima021_b  LIKE ima_file.ima021,
                 ima08_b   LIKE ima_file.ima08,
                 sfa12     LIKE sfa_file.sfa12,
                 sfaiicd02 LIKE sfai_file.sfaiicd02,  #FUN-810038
                 sfa13     LIKE sfa_file.sfa13,
                 sfa11     LIKE sfa_file.sfa11,
                 sfa16     LIKE sfa_file.sfa16,   #FUN-B50095
                 sfa161    LIKE sfa_file.sfa161,
                 sfa100    LIKE sfa_file.sfa100,
                 sfa05     LIKE sfa_file.sfa05,
                 sfaiicd01 LIKE sfai_file.sfaiicd01,  #FUN-810038  #No.MOD-890023 add
                 sfaislk01 LIKE sfai_file.sfaislk01,       #No.FUN-810017
                 sfa065    LIKE sfa_file.sfa065,
                 sfa06     LIKE sfa_file.sfa06,
                 sfaiicd04 LIKE sfai_file.sfaiicd04,  #FUN-810038
                 sfa062    LIKE sfa_file.sfa062,
                 sfaud02 LIKE sfa_file.sfaud02,
                 sumsfe   LIKE  oeb_file.oeb12,  #add by chuyl 140116
                 sfaud03 LIKE sfa_file.sfaud03,
                 sfaud04 LIKE sfa_file.sfaud04,
                 sfaud05 LIKE sfa_file.sfaud05,
                 sfaiicd05 LIKE sfai_file.sfaiicd05,  #FUN-810038
                 short_qty LIKE sfa_file.sfa07,       #FUN-940008 add
                 sfa063    LIKE sfa_file.sfa063,
                 sfa064    LIKE sfa_file.sfa064,
                 sfaiicd06 LIKE sfai_file.sfaiicd06,  #FUN-C30274
                 sfa30     LIKE sfa_file.sfa30,
                 sfa31     LIKE sfa_file.sfa31,
                 sfa36     LIKE sfa_file.sfa36,       #FUN-950088
                 mse02     LIKE mse_file.mse02,       #FUN-950088
                 sfaiicd03 LIKE sfai_file.sfaiicd03   #FUN-810038
                 ,sfaud01 LIKE sfa_file.sfaud01,
                 sfaud06 LIKE sfa_file.sfaud06,
                 sfaud07 LIKE sfa_file.sfaud07,
                 sfaud08 LIKE sfa_file.sfaud08,
                 sfaud09 LIKE sfa_file.sfaud09,
                 sfaud10 LIKE sfa_file.sfaud10,
                 sfaud11 LIKE sfa_file.sfaud11,
                 sfaud12 LIKE sfa_file.sfaud12,
                 sfaud13 LIKE sfa_file.sfaud13,
                 sfaud14 LIKE sfa_file.sfaud14,
                 sfaud15 LIKE sfa_file.sfaud15
              END RECORD,
    g_sfa_o   RECORD LIKE sfa_file.*,   #MOD-BA0105 add
    g_wc,g_wc2,g_sql    string,  #No.FUN-580092 HCN
    g_t1                LIKE oay_file.oayslip,        #No.FUN-550067  #No.FUN-680121 VARCHAR(5)
    g_ecu01         LIKE ecu_file.ecu01,
    g_buf           LIKE type_file.chr1000, #No.FUN-680121 VARCHAR(20)
    g_rec_b         LIKE type_file.num5,    #單身筆數  #No.FUN-680121 SMALLINT
    g_pmn01         LIKE oea_file.oea01,    #No.FUN-680121 VARCHAR(16),               #No.FUN-550067
    g_argv1         LIKE oea_file.oea01,    #No.FUN-680121 VARCHAR(16),              #No.FUN-550067   #工單號碼
    g_argv2         STRING,                 #TQC-630068      #執行功能
    g_sw            LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(01),  #
    g_ecd03         LIKE ecd_file.ecd03,
    g_bof06_1       LIKE bof_file.bof06,    #No.FUN-810017
    g_bof06_2       LIKE bof_file.bof06,    #No.FUN-810017
    l_n             LIKE type_file.num5,    #No.FUN-680121 SMALLINT
    g_mesg          LIKE type_file.chr1000, #No.FUN-680121 VARCHAR(200),             #No.MOD-5A0008 add
    l_ac            LIKE type_file.num5                 #目前處理的ARRAY CNT  #No.FUN-680121 SMALLINT
#FUN-CB0014---add---str---
DEFINE g_sfb_l DYNAMIC ARRAY OF RECORD
            sfb01   LIKE sfb_file.sfb01,
            smydesc LIKE smy_file.smydesc,
            sfb44   LIKE sfb_file.sfb44,
            gen02   LIKE gen_file.gen02,
            sfb81   LIKE sfb_file.sfb81,
            sfb02   LIKE sfb_file.sfb02,
            sfb39   LIKE sfb_file.sfb39,
            sfb87   LIKE sfb_file.sfb87,
            sfb04   LIKE sfb_file.sfb04,
            sfb43   LIKE sfb_file.sfb43,
            sfbmksg LIKE sfb_file.sfbmksg,
            sfb82   LIKE sfb_file.sfb82,
            pmc03   LIKE pmc_file.pmc03,
            sfb05   LIKE sfb_file.sfb05,
            ima02   LIKE ima_file.ima02,
            ima021  LIKE ima_file.ima021,
            sfb08   LIKE sfb_file.sfb08,
            ima55   LIKE ima_file.ima55,
            sfb93   LIKE sfb_file.sfb93,
            sfb06   LIKE sfb_file.sfb06
           ,sfbud02 LIKE sfb_file.sfbud02  #add by chuyl 140113
           ,sfb09   LIKE sfb_file.sfb09,
            sfv35s  LIKE sfv_file.sfv35
               END RECORD
DEFINE g_tc_sfa DYNAMIC ARRAY OF RECORD
         tc_sfa02   LIKE tc_sfa_file.tc_sfa02,
         ima02      LIKE ima_file.ima02,
         ima021     LIKE ima_file.ima021,
         tc_sfa03   LIKE tc_sfa_file.tc_sfa03,
         tc_sfa04   LIKE tc_sfa_file.tc_sfa04,
         tc_sfa06   LIKE tc_sfa_file.tc_sfa06,
         tc_sfa05   LIKE tc_sfa_file.tc_sfa05,
         tc_sfa08   LIKE tc_sfa_file.tc_sfa08,
         tc_sfa07   LIKE tc_sfa_file.tc_sfa07,
         tc_sfa14   LIKE tc_sfa_file.tc_sfa14,
         tc_sfa09   LIKE tc_sfa_file.tc_sfa09,
         tc_sfa10   LIKE tc_sfa_file.tc_sfa10,
         tc_sfa11   LIKE tc_sfa_file.tc_sfa11,
         tc_sfa12   LIKE tc_sfa_file.tc_sfa12,
         tc_sfa13   LIKE tc_sfa_file.tc_sfa13
               END RECORD
DEFINE l_ac3    LIKE type_file.num5
DEFINE g_rec_b3 LIKE type_file.num5
DEFINE l_ac4    LIKE type_file.num5
DEFINE g_rec_b4 LIKE type_file.num5
DEFINE g_action_flag   STRING
DEFINE w        ui.Window
DEFINE f        ui.Form
DEFINE page     om.DomNode
#FUN-CB0014---add---end---
DEFINE g_ima25      LIKE ima_file.ima25
DEFINE g_ima44      LIKE ima_file.ima44
DEFINE g_ima908     LIKE ima_file.ima908  #MOD-730044 add
DEFINE g_ima906     LIKE ima_file.ima906
DEFINE g_ima907     LIKE ima_file.ima907
DEFINE g_cnt1       LIKE type_file.num5    #No.FUN-680121 SMALLINT
DEFINE g_factor     LIKE img_file.img21
DEFINE g_forupd_sql         STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5    #No.FUN-680121 SMALLINT
DEFINE g_chr           LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_cnt           LIKE type_file.num10   #No.FUN-680121 INTEGER
DEFINE g_i             LIKE type_file.num5    #count/index for any purpose  #No.FUN-680121 SMALLINT
DEFINE g_msg           LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(72)
DEFINE g_row_count     LIKE type_file.num10   #No.FUN-680121 INTEGER
DEFINE g_curs_index    LIKE type_file.num10   #No.FUN-680121 INTEGER
DEFINE g_jump          LIKE type_file.num10   #No.FUN-680121 INTEGER
DEFINE g_no_ask       LIKE type_file.num5    #No.FUN-680121 SMALLINT
DEFINE g_confirm       LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_approve       LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_post          LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_close         LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_void          LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_valid         LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
DEFINE g_gfe03         LIKE gfe_file.gfe03 #FUN-640147
DEFINE g_laststage     LIKE type_file.chr1     #FUN-8C0081 add 是否為簽核最後一站
DEFINE g_short_qty   LIKE sfa_file.sfa07       #FUN-940008 add
DEFINE g_brb         RECORD LIKE brb_file.*    #FUN-A50066
DEFINE g_sfa12_t     LIKE sfa_file.sfa12       #FUN-910088--add--
DEFINE g_wo_cnt      LIKE type_file.num5       #FUN-C30145
DEFINE g_cmd        STRING #No:DEV-CB0005--add


MAIN
   DEFINE p_row,p_col  LIKE type_file.num5    #No.FUN-680121 SMALLINT

   IF FGL_GETENV("FGLGUI") <> "0" THEN  #若為背景執行則不定義系統畫面預設值  #FUN-8C0081
      OPTIONS                                #改變一些系統預設值
          INPUT NO WRAP,
          FIELD ORDER FORM                   #整個畫面欄位輸入會依照p_per所設定的順序(忽略4gl寫的順序)  #FUN-730075
   END IF                                   #FUN-8C0081

   DEFER INTERRUPT



   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("ASF")) THEN
      EXIT PROGRAM
   END IF

   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818   #No.FUN-6A0090

   CALL i301_tmp2()   #FUN-B90008

   LET g_argv1=ARG_VAL(1)   #工單號碼
   LET g_argv2=ARG_VAL(2)   #執行功能   #TQC-630068

   LET p_row = 2 LET p_col = 2
   IF fgl_getenv('EASYFLOW')= "1" THEN   #判斷是否為簽核模式
   LET g_argv1 = aws_efapp_wsk(1)        #取得單號
   END IF

   IF g_bgjob = "N" OR cl_null(g_bgjob) THEN
      OPEN WINDOW t301_w AT p_row,p_col WITH FORM "asf/42f/asfi301"
        ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

      CALL cl_ui_init()
   END IF

   CALL aws_efapp_toolbar()      #建立簽核模式時的 toolbar icon
#FUN-A50032 mod str ----
#  CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, confirm,
#                             undo_confirm, easyflow_approval,gen_allotment,delete_allotment,sub,gen_routing,
#                             mold_wtdw, mold_return, m_iss, mat_shift,  #MOD-A50141 mod #wo_change_mat_shift->mat_shift
#                             sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data")
   CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, undo_void, confirm, undo_confirm, easyflow_approval,gen_allotment,delete_allotment,sub,gen_allotment,delete_allotment,sub,gen_routing, mold_wtdw, mold_return, m_iss, mat_shift, sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data,wo_change")                                          #FUN-C30017 add wo_change   #CHI-D20010 add undo_void
#FUN-A50032 mod end ----
        RETURNING g_laststage    #傳入簽核模式時不應執行的 action 清單

   CALL i301_ui_default()  #畫面的隱藏顯示全部在此   #FUN-810038

  #FUN-D30030 add str-----------
   SELECT aza131 INTO g_aza.aza131 FROM aza_file
   IF g_aza.aza131  = 'N' THEN
      CALL cl_set_act_visible("barcode_gen,barcode_output,barcode_query",FALSE)
   END IF
  #FUN-D30030 add end-----------


   IF cl_null(g_sma.sma541) THEN LET g_sma.sma541 = 'N' END IF   #MOD-D50081 add
   IF cl_null(g_sma.sma542) THEN LET g_sma.sma542 = 'N' END IF   #MOD-D50081 add

   # 先以g_argv2判斷直接執行哪種功能：
   IF NOT cl_null(g_argv1) THEN
      CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL i301_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL i301_a()
            END IF
         WHEN "efconfirm"
            CALL i301_q()
            CALL i301sub_firm1_chk(g_sfb.sfb01,FALSE)       #CALL 原確認段的 check 段 #FUN-940008 add false
            IF g_success = "Y" THEN
               CALL i301sub_firm1_upd(g_sfb.sfb01,g_action_choice,FALSE)    #CALL 原確認段的 update 段 #FUN-940008 add false
            END IF
            EXIT PROGRAM
         OTHERWISE          #TQC-660067 add
            CALL i301_q()   #TQC-660067 add
      END CASE
   END IF

   CALL i301()

   CLOSE WINDOW t301_w                 #結束畫面

   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818 #No.FUN-6A0090

END MAIN

FUNCTION i301()
   DEFINE l_za05    LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(40)

   LET g_wc2=' 1=1'

  #str TQC-C60025 mark
  #LET g_forupd_sql = "SELECT * FROM sfb_file WHERE sfb01 = ? FOR UPDATE"
  #LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
  #DECLARE i301_cl CURSOR FROM g_forupd_sql

  #end TQC-C60025 mark
   CALL i301_lock_cursor()   #TQC-C60025 add

   SELECT * INTO g_sma.* FROM sma_file WHERE sma00='0'

   IF g_argv1 <> ' ' THEN
      CALL i301_q()
   END IF

   CALL i301_menu()

END FUNCTION

#str TQC-C60025 add
FUNCTION i301_lock_cursor()

   LET g_forupd_sql = "SELECT * FROM sfb_file WHERE sfb01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i301_cl CURSOR FROM g_forupd_sql


END FUNCTION
#end TQC-C60025 add

FUNCTION i301_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN

   IF g_argv1<>' ' THEN
      LET g_wc=" sfb01='",g_argv1,"'"
      LET g_wc2=" 1=1"
   ELSE
      CLEAR FORM                             #清除畫面
      CALL g_sfa.clear()
      CALL g_sfa29.clear()
      CALL cl_set_head_visible("","YES")  #NO.FUN-6B0031
      INITIALIZE g_sfb.* TO NULL    #No.FUN-750051
      CONSTRUCT BY NAME g_wc ON sfb01,sfb101,sfb44,sfb81,sfb02,sfb39,sfb87,sfb04,    #FUN-8C0081 add sfb44
                                sfb28,sfb38,sfbmksg,sfb43,sfbuser,sfbgrup,sfbmodu,sfbdate,  #FUN-8C0081 add sfbmksg,sfb43
                                sfbacti,sfb98,sfb82,sfb102,sfb22,sfb221,  #TQC-740056 add sfb102
                                sfb91,sfb92,sfb86,sfb89,  #FUN-C30114 sfb89
                                sfb05,
                                sfb08,sfb07,sfb95,sfb071,   #No.TQC-610003
                                sfb93,sfb06,sfb13,   #MOD-530280-6
                                sfb15,sfb25,sfb081,sfb09,sfb12,sfb23,
                                sfb24,sfb41,sfb99,sfb34,sfb96,sfb40,  #CHI-970012 add sfb96
                                sfb1001,sfb1002,sfb1003, #FUN-6A0007
                                sfb97,sfb27,
                                sfb271,sfb50,sfb51,sfb30,sfb31,sfb32,sfb33,sfb94,sfb104,sfb100,         #MOD-530280-6  #FUN-810045 add sfb50/51  #FUN-A20048 add sfb104
                                sfb36,sfb37,sfb103,sfb85,sfb919    #No.FUN-B0093  add sfb36 sfb37 #FUN-810017 #FUN-A80102
                                ,sfbud01,sfbud02,sfbud03,sfbud04,sfbud05,
                                sfbud06,sfbud07,sfbud08,sfbud09,sfbud10,
                                sfbud11,sfbud12,sfbud13,sfbud14,sfbud15,ta_sfb35,ta_sfb43,ta_sfb44,ta_sfb45
                                ,ta_sfb37 #zangheng20170921aps
               BEFORE CONSTRUCT
                  CALL cl_qbe_init()
         ON ACTION controlp
            CASE
               WHEN INFIELD(sfb01) #order nubmer
                     CALL cl_init_qry_var()
                     LET g_qryparam.state    = "c"
                     LET g_qryparam.form     = "q_sfb"    #MOD-530280-2,3
                    #LET g_qryparam.where = " substr(sfb01,1,",g_doc_len,") NOT IN (SELECT smy69 FROM smy_file WHERE smy69 IS NOT NULL) "
                    # LET g_qryparam.where = " sfb01[1,",g_doc_len,"] NOT IN (SELECT smy69 FROM smy_file WHERE smy69 IS NOT NULL) " #FUN-B40029 #TQC-C50227
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO sfb01
                     NEXT FIELD sfb01
               WHEN INFIELD(sfb82)
                    #MOD-B40154---modify---start---
                    # IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN   #NO:7075
                    #    CALL cl_init_qry_var()
                    #    LET g_qryparam.form     = "q_pmc2"   #No.MOD-850042 modify
                    #    LET g_qryparam.default1 = g_sfb.sfb82
                    #    CALL cl_create_qry() RETURNING g_sfb.sfb82
                    # ELSE
                    #    CALL cl_init_qry_var()
                    #    LET g_qryparam.form     = "q_gem"
                    #    LET g_qryparam.default1 = g_sfb.sfb82
                    #    CALL cl_create_qry() RETURNING g_sfb.sfb82
                    #END IF
                    #DISPLAY BY NAME g_sfb.sfb82
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_gem"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb82
                    #MOD-B40154---modify--end---
                    NEXT FIELD sfb82

               WHEN INFIELD(sfb22)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_oea3"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb22
                    NEXT FIELD sfb22
               WHEN INFIELD(sfb05) #item
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()
#                   LET g_qryparam.state    = "c"
#                   LET g_qryparam.form     = "q_ima18" #FUN-640030
#                   LET g_qryparam.default1 = g_sfb.sfb05
#                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                    CALL q_sel_ima(TRUE, "q_ima18","",g_sfb.sfb05,"","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059---------mod------------end------------------

                    DISPLAY g_qryparam.multiret TO sfb05
                    NEXT FIELD sfb05
               WHEN INFIELD(sfb86) #PBI
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_sfb"    #TQC-7B0048
                    LET g_qryparam.default1 = g_sfb.sfb86
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb86
                    NEXT FIELD sfb86
#FUN-C30114---begin
               WHEN INFIELD(sfb89)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_sfb"
                    LET g_qryparam.default1 = g_sfb.sfb89
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb89
                    NEXT FIELD sfb89
#FUN-C30114---end
               WHEN INFIELD(sfb06)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_ecu"
                    LET g_qryparam.default1 = g_sfb.sfb05  #MOD-850325
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb06
                    NEXT FIELD sfb06
               WHEN INFIELD(sfb98)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    IF g_aaz.aaz90='Y' THEN  #FUN-670103
                      LET g_qryparam.form = "q_gem4"  #FUN-670103
                    ELSE
                      LET g_qryparam.form = "q_gem"
                    END IF
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb98   #MOD-4A0252
                    NEXT FIELD sfb98
               WHEN INFIELD(sfb97)
                    CALL q_coc2(TRUE,TRUE,g_sfb.sfb97,'',g_sfb.sfb13,'0',
                                '',g_sfb.sfb05)
                    RETURNING g_sfb.sfb97
                    DISPLAY BY NAME g_sfb.sfb97
                    NEXT FIELD sfb97
               WHEN INFIELD(sfb91)
                    CALL q_ksg(TRUE,TRUE,g_sfb.sfb91,0)
                    RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb91
                    NEXT FIELD sfb91
               WHEN INFIELD(sfb27)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_pja2"  #FUN-810045   #MOD-980224 q_pja2-->q_pja4 #MOD-9A0048 q_pja4 -> q_pja2
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb27
                    NEXT FIELD sfb27
               WHEN INFIELD(sfb271)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form     = "q_pjb4"  #FUN-810045
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb271
                    NEXT FIELD sfb271

               WHEN INFIELD(sfb50) #活動
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pjk3"
                  LET g_qryparam.state = "c"   #多選
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO sfb50
                  NEXT FIELD sfb50
                WHEN INFIELD(sfb51)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf01a"          #FUN-930145
                  LET g_qryparam.state = "c"   #多選
                  LET g_qryparam.arg1 = 'C'             #FUN-930145
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO sfb51
                  NEXT FIELD sfb51

               WHEN INFIELD(sfb95)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form = "q_bma7"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb95
                    NEXT FIELD sfb95
               WHEN INFIELD(sfb1001)     #核准文號
                    CALL cl_init_qry_var()
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.form = "q_bxa01"
                    CALL cl_create_qry() RETURNING g_sfb.sfb1001
                    DISPLAY BY NAME g_sfb.sfb1001
                    NEXT FIELD sfb1001
              WHEN INFIELD(sfb102)                 #機械編號
                   CALL cl_init_qry_var()
                   LET g_qryparam.state    = "c"
                   LET g_qryparam.form = "q_eci"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO sfb102
                   NEXT FIELD sfb102

              WHEN INFIELD(sfb85)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state    = "c"
                   LET g_qryparam.form = "q_sfb85"       #FUN-A80054
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO sfb85
                   NEXT FIELD sfb85

              WHEN INFIELD(sfb30)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state    = "c"
                   LET g_qryparam.form     = "q_sfb30"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO sfb30
                   NEXT FIELD sfb30
              WHEN INFIELD(sfb31)
                   CALL cl_init_qry_var()
                   LET g_qryparam.state    = "c"
                   LET g_qryparam.form     = "q_sfb31"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO sfb31
                   NEXT FIELD sfb31
               WHEN INFIELD(sfb44)
                    CALL cl_init_qry_var()
                    LET g_qryparam.state = "c"
                    LET g_qryparam.form = "q_gen"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO sfb44
                    NEXT FIELD sfb44
                OTHERWISE EXIT CASE
            END CASE

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

                 ON ACTION qbe_select
       CALL cl_qbe_list() RETURNING lc_qbe_sn
       CALL cl_qbe_display_condition(lc_qbe_sn)
      END CONSTRUCT

      IF INT_FLAG THEN
         RETURN
      END IF

      LET g_wc = g_wc CLIPPED,cl_get_extra_cond('sfbuser', 'sfbgrup')

      #LET g_wc = g_wc CLIPPED," AND sfb01[1,",g_doc_len,"] NOT IN (SELECT smy69 FROM smy_file WHERE smy69 IS NOT NULL) "  #FUN-9B0045 mod #TQC-C50227 mark

      CONSTRUCT g_wc2 ON sfa012,sfa013,sfa27,sfa03,sfa12,   #FUN-A50066
                         sfa13,sfa11,sfa08,sfa26,
                         sfa28,sfa161,sfa100,sfa05,
                         sfa06,
                         sfa062,sfaud02,sfaud03,sfaud04,sfaud05,
                         sfa065,
                         sfa063,sfa064,
                         sfa30,sfa31,sfa36    #FUN-950088 add sfa36
                         ,sfaud01,
                         sfaud06,sfaud07,sfaud08,sfaud09,sfaud10,
                         sfaud11,sfaud12,sfaud13,sfaud14,sfaud15

           FROM s_sfa[1].sfa012,s_sfa[1].sfa013,     #FUN-A50066
                s_sfa[1].sfa27,s_sfa[1].sfa03,s_sfa[1].sfa12,
                s_sfa[1].sfa13,
                s_sfa[1].sfa11,s_sfa[1].sfa08, s_sfa[1].sfa26,s_sfa[1].sfa28,
                s_sfa[1].sfa161,s_sfa[1].sfa100,s_sfa[1].sfa05,
                s_sfa[1].sfa06,
                s_sfa[1].sfa062,s_sfa[1].sfaud02,s_sfa[1].sfaud03,s_sfa[1].sfaud04,s_sfa[1].sfaud05,
                s_sfa[1].sfa065,
                s_sfa[1].sfa063,
                s_sfa[1].sfa064,
                s_sfa[1].sfa30,s_sfa[1].sfa31,
                s_sfa[1].sfa36    #FUN-950088 add
                ,s_sfa[1].sfaud01,
                s_sfa[1].sfaud06,s_sfa[1].sfaud07,s_sfa[1].sfaud08,s_sfa[1].sfaud09,s_sfa[1].sfaud10,
                s_sfa[1].sfaud11,s_sfa[1].sfaud12,s_sfa[1].sfaud13,s_sfa[1].sfaud14,s_sfa[1].sfaud15

    BEFORE CONSTRUCT
       CALL cl_qbe_display_condition(lc_qbe_sn)
         ON ACTION controlp
            CASE WHEN INFIELD(sfa27)
#FUN-AA0059---------mod------------str-----------------
#                     CALL cl_init_qry_var()
#                     LET g_qryparam.state    = "c"
#                     LET g_qryparam.form     = "q_ima"
#                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                      CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059---------mod------------end------------------
                      DISPLAY g_qryparam.multiret TO sfa27
                      NEXT FIELD sfa27
                 WHEN INFIELD(sfa03)
#FUN-AA0059---------mod------------str-----------------
#                     CALL cl_init_qry_var()
#                     LET g_qryparam.state    = "c"
#                     LET g_qryparam.form     = "q_ima"
#                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                      CALL q_sel_ima(TRUE, "q_ima","","","","","","","",'')  RETURNING  g_qryparam.multiret
#FUN-AA0059---------mod------------end------------------
                      DISPLAY g_qryparam.multiret TO sfa03
                      NEXT FIELD sfa03
                 WHEN INFIELD(sfa12)
                      CALL cl_init_qry_var()
                      LET g_qryparam.state    = "c"
                      LET g_qryparam.form     = "q_gfe"
                      CALL cl_create_qry() RETURNING g_qryparam.multiret
                      DISPLAY g_qryparam.multiret TO sfa12
                      NEXT FIELD sfa12
                 WHEN INFIELD(sfa08)
#                     CALL q_ecd(TRUE,TRUE,'') RETURNING g_qryparam.multiret      #TQC-A50142
#TQC-A50142 --add
                      CALL cl_init_qry_var()
                      LET g_qryparam.state    = "c"
                      LET g_qryparam.form     = "q_sfa08"
                      CALL cl_create_qry() RETURNING g_qryparam.multiret
#TQC-A50142 --end
                      DISPLAY g_qryparam.multiret TO sfa08
                      NEXT FIELD sfa08
                 WHEN INFIELD(sfa30)
                   #Mod No.FUN-AA0050
                   #CALL cl_init_qry_var()
                   #LET g_qryparam.form     = "q_imd"
                   #LET g_qryparam.state    = "c"
                   #LET g_qryparam.arg1     = 'SW'        #倉庫類別 #MOD-4A0213
                   #CALL cl_create_qry() RETURNING g_qryparam.multiret
                    CALL q_imd_1(TRUE,TRUE,"","",g_plant,"","")  #只能开当前门店的
                         RETURNING g_qryparam.multiret
                   #End Mod No.FUN-AA0050
                    DISPLAY g_qryparam.multiret TO sfa30
                    NEXT FIELD sfa30
                 WHEN INFIELD(sfa31)
                   #Mod No.FUN-AA0050
                   #CALL cl_init_qry_var()
                   #LET g_qryparam.form     = "q_ime"
                   #LET g_qryparam.state    = "c"
                   #CALL cl_create_qry() RETURNING g_qryparam.multiret
                    CALL q_ime_1(TRUE,TRUE,"","","",g_plant,"","","")
                         RETURNING g_qryparam.multiret
                   #End Mod No.FUN-AA0050
                    DISPLAY g_qryparam.multiret TO sfa31
                    NEXT FIELD sfa31
                 WHEN INFIELD(sfa36)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_mse"
                  LET g_qryparam.state = 'c'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO sfa36
                  NEXT FIELD sfa36
                #FUN-A50066--begin--add------------
                WHEN INFIELD(sfa012)
                  CALL cl_init_qry_var()
                # LET g_qryparam.form = "q_ecb012"    #FUN-B10056 mark
                  LET g_qryparam.form = "q_ecb012_1"  #FUN-B10056
                  LET g_qryparam.state = 'c'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO sfa012
                  NEXT FIELD sfa012
                WHEN INFIELD(sfa013)
                  CALL cl_init_qry_var()
                # LET g_qryparam.form = "q_ecb012"    #FUN-B10056 mark
                  LET g_qryparam.form = "q_ecm03_1"   #FUN-B10056
                  LET g_qryparam.state = 'c'
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO sfa013
                  NEXT FIELD sfa013
                #FUN-A50066--end--add--------------------
            END CASE

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

                    ON ACTION qbe_save
           CALL cl_qbe_save()
      END CONSTRUCT

      IF INT_FLAG THEN
         RETURN
      END IF

   END IF


   IF g_wc2 = " 1=1" THEN   # 若單身未輸入條件
      LET g_sql = "SELECT  sfb01 FROM sfb_file",
                  " WHERE ", g_wc CLIPPED,
                  " ORDER BY 1"
   ELSE     # 若單身有輸入條件
      LET g_sql = "SELECT UNIQUE sfb01 ",
                  "  FROM sfb_file, sfa_file",
                  " WHERE sfb01 = sfa01",
                  "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                  " ORDER BY 1"
   END IF

   PREPARE i301_prepare FROM g_sql
   DECLARE i301_cs SCROLL CURSOR WITH HOLD FOR i301_prepare
   DECLARE i301_fill_cs CURSOR FOR i301_prepare    #FUN-CB0014 add

   IF g_wc2 = " 1=1" THEN   # 取合乎條件筆數
      LET g_sql="SELECT COUNT(*) FROM sfb_file",
                " WHERE ",g_wc CLIPPED
   ELSE
      LET g_sql="SELECT COUNT(DISTINCT sfb01) FROM sfb_file,sfa_file",
                 " WHERE sfa01=sfb01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
   END IF

   PREPARE i301_precount FROM g_sql
   DECLARE i301_count CURSOR FOR i301_precount

END FUNCTION

FUNCTION i301_menu()
DEFINE l_n      LIKE type_file.num5
DEFINE l_sfp01  LIKE sfp_file.sfp01
DEFINE l_sfp    RECORD LIKE sfp_file.*
DEFINE l_creator   LIKE type_file.chr1    #FUN-8C0081 #「不准」時是否退回填表人
DEFINE l_flowuser  LIKE type_file.chr1    #FUN-8C0081 #是否有指定加簽人員
DEFINE l_sfb01     LIKE sfb_file.sfb01    #FUN-A80054
DEFINE l_sfdconf   LIKE sfd_file.sfdconf  #FUN-A80054
DEFINE l_cnt       LIKE type_file.num5    #MOD-B30414
DEFINE l_sfb01_doc LIKE sfb_file.sfb01    #TQC-C50227
DEFINE l_imaicd04  LIKE imaicd_file.imaicd04  #MOD-D30027
DEFINE l_sql       STRING                 #DEV-D30026
#DEV-D30026 add str------------------
DEFINE l_ima918    LIKE ima_file.ima918   #批號管理否
DEFINE l_ima921    LIKE ima_file.ima921   #序號管理否
DEFINE l_ima931    LIKE ima_file.ima931   #包號管理否
#DEV-D30026 add end------------------

  LET l_flowuser = "N"   #FUN-8C0081

   WHILE TRUE
      IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN   #FUN-CB0014 add
         CALL i301_bp("G")
      #FUN-CB0014---add---str---
      ELSE
         CALL i301_list_fill()
         CALL i301_bp3("G")
         IF NOT cl_null(g_action_choice) AND l_ac3>0 THEN #將清單的資料回傳到主畫面
            SELECT sfb_file.* INTO g_sfb.*
              FROM sfb_file
             WHERE sfb01=g_sfb_l[l_ac3].sfb01
         END IF
         IF g_action_choice!= "" THEN
            LET g_action_flag = "page_main"
            LET l_ac3 = ARR_CURR()
            LET g_jump = l_ac3
            LET g_no_ask = TRUE
            IF g_rec_b3 >0 THEN
               CALL i301_fetch('/')
            END IF
            CALL cl_set_comp_visible("info,page_list", FALSE)
            CALL ui.interface.refresh()
            CALL cl_set_comp_visible("info,page_list", TRUE)
         END IF
      END IF
      #FUN-CB0014---add---str--
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i301_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i301_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i301_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i301_u()
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i301_b(' ')
            ELSE
               LET g_action_choice = NULL
            END IF
#FUN-9C0119--add--begin
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL i301_copy()
            END IF
#FUN-9C0119--add--end
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()

         WHEN "openurl"
          IF cl_chk_act_auth() THEN
          LET g_msg='http://192.168.0.2/ERP/pmot.asp?gd=',g_sfb.sfb01
             IF NOT cl_open_url(g_msg) THEN
              CALL cl_err('','-400',0)
              END IF
          END IF
         WHEN "js"
            IF cl_chk_act_auth() THEN
               CALL i301_js()
            END IF
         WHEN "cooi500"
            IF cl_chk_act_auth() THEN
               LET g_msg="cooi500"
               CALL cl_cmdrun_wait(g_msg)
            END IF
         WHEN "cooi301"
            IF cl_chk_act_auth() THEN
               LET g_msg="cooi301"
               CALL cl_cmdrun_wait(g_msg)
            END IF

         WHEN "asfp400"
            IF cl_chk_act_auth() THEN
               LET g_msg="asfp400 '",g_sfb.sfb01,"'"
               CALL cl_cmdrun_wait(g_msg)
            END IF

         WHEN "gen_allotment"
            IF cl_chk_act_auth() THEN
               IF cl_chk_act_auth() THEN
                  CALL i301_cralc()
                  CALL i301_b_fill( '1=1')
               END IF
            END IF
         WHEN "delete_allotment"
            IF cl_chk_act_auth() THEN
               IF cl_chk_act_auth() THEN
                  CALL i301_dealc()
               END IF
            END IF
         WHEN "aimq103"
            IF cl_chk_act_auth() THEN
               LET g_msg="aimq103 2 '",g_sfb.sfb01,"'"
               CALL cl_cmdrun(g_msg)
            END IF
         # add by lixwz 20170928 s
         WHEN "get_bom"
            IF cl_chk_act_auth() THEN
                MESSAGE ''
            END IF
         # add by lixwz 20170928 e
         WHEN "inventory"
            LET g_msg="aimq102 2 '",g_sfb.sfb01,"'"
            CALL cl_cmdrun(g_msg)
         WHEN "status_query"
            LET g_msg="asfq301 '",g_sfb.sfb01,"'"
            CALL cl_cmdrun(g_msg)
         WHEN "demand_supply"
            IF NOT cl_null(g_sfb.sfb01) THEN           #TQC-C70122 add
               IF NOT cl_null(l_ac) AND l_ac > 0 THEN  #TQC-C70122 add
                  LET g_msg="aimq841 '1' '",g_sfa[l_ac].sfa27,"'"
                  CALL cl_cmdrun(g_msg)
               END IF
            ELSE
               CALL cl_err('','-400',0)                #TQC-C70122 add
            END IF
         WHEN "sub"
            IF cl_chk_act_auth() THEN
               IF cl_chk_act_auth() THEN
                   #CALL i301_sub() #FUN-C30017 mark
                   #FUN-C30017 add---str---
                   #IF g_sfb.sfb43 NOT MATCHES '[Ss]' THEN                         #TQC-C70122 mark
                   IF g_sfb.sfb43 NOT MATCHES '[Ss]' OR cl_null(g_sfb.sfb43) THEN  #TQC-C70122 add
                       CALL i301_sub()
                   ELSE
                       CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
                   END IF
                   #FUN-C30017 add---end---
               END IF
            END IF
         WHEN "mat_shift"   #MOD-A50141 mod ##wo_change_mat_shift->mat_shift
            IF cl_chk_act_auth() THEN
              #FUN-C30017 mark--str---
              #LET g_msg="asfp510 '",g_sfb.sfb01,"'"
              #CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
              #FUN-C30017 mark--end---
               #FUN-C30017 add---str---
               #IF g_sfb.sfb43 NOT MATCHES '[Ss]' THEN                        #TQC-C70122 mark
               IF g_sfb.sfb43 NOT MATCHES '[Ss]' OR cl_null(g_sfb.sfb43) THEN #TQC-C70122 add
                   LET g_msg="asfp510 '",g_sfb.sfb01,"'"
                   CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
               ELSE
                   CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
               END IF
               #FUN-C30017 add---end---
            END IF
         WHEN "order_query"
            CALL i301_v(0,0)
         WHEN "sub_p_o"
          IF g_sfb.sfb43 NOT MATCHES '[Ss]' THEN #FUN-C30017  add if 判斷
            IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8) THEN   #NO:7075
               IF g_sfb.sfb87='N' OR g_sfb.sfb87='X' THEN #MOD-910016
                  CALL cl_err('','asf-944',1)
               ELSE
#MOD-B30605 -- begin --
                  IF g_sfb.sfb04 = '8' THEN
                     CALL cl_err(g_sfb.sfb01,'asf-070',1)
                  ELSE
#MOD-B30605 -- end --
                     BEGIN WORK
                     CALL i301sub_ins_pmm(g_sfb.*) RETURNING g_pmn01
                     IF g_success = 'Y' THEN
                        COMMIT WORK
                        LET g_msg="apmt590 '",g_pmn01,"' '0' 'SUB'",
                                   " '",g_sfb.sfb01 CLIPPED,"'"
                        CALL cl_cmdrun_wait(g_msg)
                        SELECT MAX(pmn01) INTO g_pmn01 FROM pmn_file
                            WHERE pmn41=g_sfb.sfb01
                        #No.B356 避免有單頭無單身之採購單存在
                        IF cl_null(g_pmn01) THEN
                           SELECT pmm01 INTO g_pmn01
                             FROM pmm_file WHERE pmm01=g_sfb.sfb01
                        END IF
                        DISPLAY g_pmn01 TO smydesc
                        SELECT sfb04 INTO g_sfb.sfb04 FROM sfb_file
                               WHERE sfb01=g_sfb.sfb01
                        DISPLAY BY NAME g_sfb.sfb04
                     ELSE
                        ROLLBACK WORK
                     END IF
                     #避免有單頭無單身之採購單存在
                      SELECT MAX(pmn01) INTO g_pmn01 FROM pmn_file
                       WHERE pmn41=g_sfb.sfb01
                      IF cl_null(g_pmn01) THEN
                         SELECT pmm01 INTO g_pmn01
                           FROM pmm_file WHERE pmm01=g_sfb.sfb01
                         IF g_pmn01 IS NOT NULL THEN
                            DELETE FROM pmm_file
                              WHERE pmm01=g_sfb.sfb01
                            IF STATUS THEN
                               CALL cl_err3("del","pmm_file",g_sfb.sfb01,"",STATUS,"","delete pmm:",1)  #No.FUN-660128
                            END IF
                         END IF
                      END IF
                  END IF   #MOD-B30605 add
               END IF
            ELSE
               CALL cl_err('','asf-115',1)
            END IF
          #FUN-C30017--add---str---
          ELSE
              CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
          END IF
          #FUN-C30017--add---end---
         WHEN "routing"
            LET g_msg="aeci700", " '",g_sfb.sfb01 CLIPPED,"' ''"
            CALL cl_cmdrun(g_msg)
         WHEN "gen_routing"
           #TQC-C80048---add---str---
           IF g_sma.sma26 = '1' THEN
              CALL cl_err('','asf-775',0)
           END IF
           #TQC-C80048---add---end---
           #TQC-940069 當作業編號屬'6:Turnkey'時，製程編號應該要可以輸入
           IF g_sma.sma26='2' AND g_sfb.sfb02 != 11 AND g_sfb.sfb02 != 15    #MOD-850257 add
                           AND g_sfb.sfb02 != 7  AND g_sfb.sfb02 != 8  THEN  #MOD-850257 add
            CALL i301_crrut("a")   #MOD-A40026 add "a"
           #TQC-940069 當作業編號屬'6:Turnkey'時，製程編號應該要可以輸入
           END IF    #MOD-850257 add
         WHEN "memo"
            CALL s_asf_memo('a',g_sfb.sfb01)
         WHEN "s_n"
            IF NOT cl_null(g_sfb.sfb01) THEN
               IF g_sfb.sfb43 NOT MATCHES '[Ss]' THEN
                  CALL i301_6(g_sfb.sfb01)
                  #FUN-A80102(S)
                  IF g_sma.sma1424='Y' THEN
                     SELECT sfb919 INTO g_sfb.sfb919 FROM sfb_file
                      WHERE sfb01 = g_sfb.sfb01
                     DISPLAY BY NAME g_sfb.sfb919
                  END IF
                  #FUN-A80102(E)
               ELSE
                  CALL cl_err('','mfg3557',0)
               END IF
            END IF
         WHEN "mold_wtdw"
            LET g_msg="afat300"
            CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
         WHEN "mold_return"
            LET g_msg="afat305"
            CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
         WHEN "run_card"
            LET g_msg="asfi310"," '' '' '",g_sfb.sfb01 CLIPPED,"' "   #TQC-630068
            CALL cl_cmdrun(g_msg)

         WHEN "easyflow_approval"        #EasyFlow送簽
            IF cl_chk_act_auth() THEN
              #FUN-C20027 add str---
               SELECT * INTO g_sfb.* FROM sfb_file
                WHERE sfb01 = g_sfb.sfb01
               CALL i301_show()
               CALL i301_b_fill(' 1=1')
              #FUN-C20027 add end---
               CALL i301_ef()
               CALL i301_show()  #FUN-C20027 add
            END IF
         WHEN "approval_status"          #簽核狀況
            IF cl_chk_act_auth() THEN
               IF aws_condition2() THEN
                  CALL aws_efstat2()
               END IF
            END IF

         WHEN "agree"             #EasyFlow簽核,"准"功能
            IF g_laststage = "Y" AND l_flowuser ="N" THEN  #最後一關並且無加簽人員
               CALL i301sub_firm1_upd(g_sfb.sfb01, g_action_choice,FALSE)       #CALL 原確認的 update 段 #FUN-940008 add false
               CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*
               CALL i301_show()
            ELSE
               LET g_success = "Y"
               IF NOT aws_efapp_formapproval() THEN   #執行EF簽核
                  LET g_success = "N"
               END IF
            END IF
            IF g_success = "Y" THEN
               IF cl_confirm('aws-081') THEN           #詢問是否繼續下一筆資料的簽核
                  IF aws_efapp_getnextforminfo() THEN  #取得下一筆簽核單號
                     LET l_flowuser = 'N'
                     LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                     IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                        CALL i301_q()
                        #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
#FUN-A50032 mod str ----
                       #CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, confirm,
                       #                          undo_confirm,easyflow_approval,gen_allotment,delete_allotment,sub,gen_routing,
                       #                          mold_wtdw, mold_return, m_iss, mat_shift,  #MOD-A50141 mod #wo_change_mat_shift->mat_shift
                       #                          sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data")
                        CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, undo_void, confirm, undo_confirm, easyflow_approval,gen_allotment,delete_allotment,sub,gen_allotment,delete_allotment,sub,gen_routing, mold_wtdw, mold_return, m_iss, mat_shift, sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data,wo_change,barcode_gen")   #FUN-C30017 add wo_change  #CHI-D20010 add undo_void  #FUN-D30030 add barcode_gen
#FUN-A50032 mod end ----
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

         WHEN "deny"       #EasyFlow簽核,"不准"功能
            IF (l_creator := aws_efapp_backflow() ) IS NOT NULL THEN #退回關卡
               IF aws_efapp_formapproval() THEN    #執行 EF 簽核
                  IF l_creator = "Y" THEN          #當退回填表人時
                     LET g_sfb.sfb43 = 'R'         #顯示狀態碼為 'R' 送簽退回
                     DISPLAY BY NAME g_sfb.sfb43
                  END IF
                  IF cl_confirm('aws-081') THEN           #詢問是否繼續下一筆資料的簽核
                     IF aws_efapp_getnextforminfo() THEN  #取得下一筆簽核單號
                        LET l_flowuser = 'N'
                        LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                        IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                           CALL i301_q()
                           #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
#FUN-A50032 mod str ----
                          #CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, confirm,
                          #                          undo_confirm,easyflow_approval,gen_allotment,delete_allotment,sub,gen_routing,
                          #                          mold_wtdw, mold_return, m_iss, mat_shift,  #MOD-A50141 mod #wo_change_mat_shift->mat_shift
                          #                          sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data")
                           CALL aws_efapp_flowaction("insert, modify, delete, detail, query, locale, void, undo_void, confirm, undo_confirm, easyflow_approval,gen_allotment,delete_allotment,sub,gen_allotment,delete_allotment,sub,gen_routing, mold_wtdw, mold_return, m_iss, mat_shift, sub_p_o, s_n, run_card, gen_m_iss, aps_related_data, aps_route_subc_data,wo_change")                                          #FUN-C30017 add wo_change   #CHI-D20010 add undo_void
#FUN-A50032 mod end ----
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

         WHEN "modify_flow"               #EasyFlow簽核,"加簽"功能
            IF aws_efapp_flowuser() THEN  #選擇欲加簽人員
               LET l_flowuser = 'Y'
            ELSE
               LET l_flowuser = 'N'
            END IF

         WHEN "withdraw"                  #EasyFlow簽核,"撤簽"功能
            IF cl_confirm("aws-080") THEN
               IF aws_efapp_formapproval() THEN
                  EXIT WHILE
               END IF
            END IF

         WHEN "org_withdraw"              #EasyFlow 簽核,"抽單"功能
            IF cl_confirm("aws-079") THEN
               IF aws_efapp_formapproval() THEN
                  EXIT WHILE
               END IF
            END IF

         WHEN "phrase"                    #EasyFlow 簽核,"簽核意見"功能
              CALL aws_efapp_phrase()

         WHEN "confirm"
            IF cl_chk_act_auth() THEN
                  #CALL i301sub_firm1_chk(g_sfb.sfb01,FALSE)     #CALL原確認的check段  #FUN-8C0081 add #FUN-940008 add false
                  #IF g_success='Y' THEN
#FUN-A80054--	begin--add---------------------------------------------------------------------
#若工單需要合拼，則處理邏輯如下：
#  依照PBI單身的模數(sfd05)比例，檢查此PBI單的所有工單生產數量比例是否符合，若不符合的話修正,
#  如有異動生產數量的工單，需重新產生備料及製程追蹤或Runcard製程追蹤,
#  需依據合拼版的資料更新備料和製程追蹤的資料，
#  並將所有合拼的工單及PBI資料做確認
                     LET l_cnt=0   #MOD-B30414
                     SELECT COUNT(*) INTO l_cnt FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01 AND (sfd07 IS NOT NULL AND sfd07<>' ') #MOD-B30414
                     BEGIN WORK   #FUN-C30274 add ifndef ICD
                     IF NOT cl_null(g_sfb.sfb85) AND l_cnt > 0 THEN  #MOD-B30414
                        LET g_success='Y'
                        CALL i301sub_sfb85(g_sfb.sfb85)
                        IF g_success='Y' THEN
                           CALL i301sub_selsfd(g_sfb.sfb85)
                        END IF
                        IF g_success='Y' THEN
                           DECLARE firm_cs CURSOR FOR
                            SELECT DISTINCT sfd03 FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfdconf='N'
                           LET g_b_confirm='Y'
                           FOREACH firm_cs INTO l_sfb01
                              CALL i301sub_firm1_chk(l_sfb01,TRUE)
                              IF g_success='N' THEN EXIT FOREACH END IF  #FUN-A80060
                              IF g_success='Y' THEN
                                 CALL i301sub_firm1_upd(l_sfb01,g_action_choice,TRUE)
                                 IF g_success='N' THEN EXIT FOREACH END IF  #FUN-A80060
                              END IF
                           END FOREACH
                           LET g_b_confirm='N'
                        END IF
                        IF g_success = 'Y' THEN
                           UPDATE sfd_file SET sfdconf = 'Y' WHERE sfd01=g_sfb.sfb85
                           COMMIT WORK
                        ELSE
                           ROLLBACK WORK
                        END IF
#FUN-A80054--end--add---------------------------------------------------------------------------
                     ELSE    #FUN-A80054
                        #CALL i301sub_firm1_chk(g_sfb.sfb01,FALSE)     #CALL原確認的check段  #FUN-8C0081 add #FUN-940008 add false #FUN-C30274 mark
                        CALL i301sub_firm1_chk(g_sfb.sfb01,TRUE)   #FUN-C30274
                        IF g_success='Y' THEN
                           CALL i301sub_firm1_upd(g_sfb.sfb01,g_action_choice,FALSE)  #CALL原確認的update段 #FUN-8C0081 add #FUN-940008 add false
                          #COMMIT WORK     #FUN-C30274   #TQC-C60025 mark
                          #str TQC-C60025 mod
                           IF g_success='Y' THEN
                              COMMIT WORK
                           ELSE
                              ROLLBACK WORK
                           END IF
                          #end TQC-C60025 mod
                        ELSE               #FUN-C30274
                           ROLLBACK WORK   #FUN-C30274
                        END IF
                     END IF  #FUN-A80054
                     IF g_success='Y' THEN
                        CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*

                        #FUN-9A0095 mark str----------------------------
                        #IF g_aza.aza90 MATCHES "[Yy]" THEN   #TQC-8B0011  ADD
                        #   CASE aws_mescli('asfi301','insert',g_sfb.sfb01)
                        #      WHEN 0  #無與 MES 整合
                        #           MESSAGE 'INSERT O.K'
                        #      WHEN 1  #呼叫 MES 成功
                        #           MESSAGE 'INSERT O.K, INSERT MES O.K'
                        #      WHEN 2  #呼叫 MES 失敗
                        #           RETURN FALSE
                        #   END CASE
                        #END IF #TQC-8B0011  ADD
                        #FUN-9A0095 mark end----------------------------
                     END IF
            END IF
            SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01=g_sfb.sfb01  #CHI-C50029 add 重讀DB
            CALL i301_show()

         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               #TQC-C50227 add begin---- 拆解組合工單不能取消審核
               LET l_cnt=0
               LET l_sfb01_doc = g_sfb.sfb01[1,g_doc_len]
               SELECT COUNT(*) INTO l_cnt FROM smy_file WHERE smy69 = l_sfb01_doc
               IF l_cnt > 0 THEN
                  CALL cl_err('','asf-599',1)
               ELSE
               #TQC-C50227 add  end------
                  #FUN-A80054--begin--modify--若此工單sfb85不為空，則check此PBI單資料的所有工單是否一起取消確認
                  LET l_cnt=0   #MOD-B30414
                  SELECT COUNT(*) INTO l_cnt FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01 AND (sfd07 IS NOT NULL AND sfd07<>' ') #MOD-B30414
                  IF NOT cl_null(g_sfb.sfb85) AND l_cnt > 0 THEN  #MOD-B30414
                     IF cl_confirm('asf-157') THEN
                        BEGIN WORK
                        LET g_success='Y'
                        DECLARE firm_cs1 CURSOR FOR
                          SELECT DISTINCT sfd03 FROM sfd_file WHERE sfd01=g_sfb.sfb85
                        FOREACH firm_cs1 INTO l_sfb01
                          CALL i301sub_firm2(l_sfb01,TRUE,'N')
                          IF g_success = 'N' THEN EXIT FOREACH END IF
                        END FOREACH
                        IF g_success = 'Y' THEN
                           UPDATE sfd_file SET sfdconf='N' WHERE sfd01=g_sfb.sfb85
                           COMMIT WORK
                        ELSE
                           ROLLBACK WORK
                        END IF
                     ELSE
                        CALL i301sub_firm2(g_sfb.sfb01,FALSE,'Y')
                        IF g_success = 'Y' THEN
                           CALL i301_del_edg()
                           DELETE FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01
                           UPDATE sfb_file SET sfb85='' WHERE sfb01=g_sfb.sfb01
                        END IF
                     END IF
                  ELSE
                     CALL i301sub_firm2(g_sfb.sfb01,FALSE,'Y')
                  END IF
                 #DEV-D40015 mark str------
                 ##DEV-D30045--add--begin
                 ##自動作廢barcode
                 #IF g_success='Y' AND g_aza.aza131 = 'Y' THEN
                 #   CALL i301sub_barcode_z(g_sfb.sfb01)
                 #END IF
                 ##DEV-D30045--add--end
                 #DEV-D40015 mark end------
                  CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*
                  CALL i301_show()
                  #FUN-A80054--end--modify---------------------------------
               END IF #TQC-C50227 add
            END IF
           #CALL i301_pic()  #圖形顯示   #FUN-730012

         WHEN "confirm1"
            IF cl_chk_act_auth() THEN
               IF cl_confirm('csf-158') THEN
                  CALL i301_confirm1()
                  CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*
                  CALL i301_show()
               END IF
            END IF

         WHEN "undo_confirm1"
            IF cl_chk_act_auth() THEN
               IF cl_confirm('csf-159') THEN
                  CALL i301_undo_confirm1()
                  CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*
                  CALL i301_show()
               END IF
            END IF
         WHEN "void"
            IF cl_chk_act_auth() THEN
               #FUN-A80054--begin--modify---------------------
               LET l_cnt=0   #MOD-B30414
               SELECT COUNT(*) INTO l_cnt FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01 AND (sfd07 IS NOT NULL AND sfd07<>' ') #MOD-B30414
               IF NOT cl_null(g_sfb.sfb85) AND l_cnt > 0 THEN  #MOD-B30414
                  IF cl_confirm('asf-158') THEN
                     BEGIN WORK
                     LET g_success='Y'
                     DECLARE firm_cs2 CURSOR FOR
                       SELECT DISTINCT sfd03 FROM sfd_file WHERE sfd01=g_sfb.sfb85
                     FOREACH firm_cs2 INTO l_sfb01
                       #CALL i301sub_x(l_sfb01,TRUE,'N')     #CHI-D20010
                        CALL i301sub_x(l_sfb01,TRUE,'N',1)   #CHI-D20010
                        IF g_success = 'N' THEN EXIT FOREACH END IF
                     END FOREACH
                     IF g_success = 'Y' THEN
                        IF g_sfb.sfb87='X' THEN LET l_sfdconf='N' ELSE LET l_sfdconf='X' END IF
                        UPDATE sfd_file SET sfdconf=l_sfdconf WHERE sfd01=g_sfb.sfb85
                        COMMIT WORK
                     ELSE
                        ROLLBACK WORK
                     END IF
                  ELSE
                    #CALL i301sub_x(g_sfb.sfb01,FALSE,'Y')    #CHI-D20010
                     CALL i301sub_x(g_sfb.sfb01,FALSE,'Y',1)  #CHI-D20010
                     IF g_success = 'Y' THEN
                        CALL i301_del_edg()
                        DELETE FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01
                        UPDATE sfb_file SET sfb85='' WHERE sfb01=g_sfb.sfb01
                     END IF
                  END IF
               ELSE
                 #CALL i301sub_x(g_sfb.sfb01,FALSE,'Y')    #FUN-A80054    #CHI-D20010
                  CALL i301sub_x(g_sfb.sfb01,FALSE,'Y',1)  #FUN-A80054    #CHI-D20010
               END IF
               CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*  #FUN-A80054
               CALL i301_show() #FUN-A80054
               #FUN-A80054--end--modify-----------------------------
            END IF
           #CALL i301_pic()  #圖形顯示   #FUN-730012

         #CHI-D20010---begin
         WHEN "undo_void"
            IF cl_chk_act_auth() THEN
               #FUN-A80054--begin--modify---------------------
               LET l_cnt=0   #MOD-B30414
               SELECT COUNT(*) INTO l_cnt FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01 AND (sfd07 IS NOT NULL AND sfd07<>' ') #MOD-B30414
               IF NOT cl_null(g_sfb.sfb85) AND l_cnt > 0 THEN  #MOD-B30414
                  IF cl_confirm('asf-158') THEN
                     BEGIN WORK
                     LET g_success='Y'
                     DECLARE firm_cs2_1 CURSOR FOR
                       SELECT DISTINCT sfd03 FROM sfd_file WHERE sfd01=g_sfb.sfb85
                     FOREACH firm_cs2_1 INTO l_sfb01
                       #CALL i301sub_x(l_sfb01,TRUE,'N')     #CHI-D20010
                        CALL i301sub_x(l_sfb01,TRUE,'N',2)   #CHI-D20010
                        IF g_success = 'N' THEN EXIT FOREACH END IF
                     END FOREACH
                     IF g_success = 'Y' THEN
                        IF g_sfb.sfb87='X' THEN LET l_sfdconf='N' ELSE LET l_sfdconf='X' END IF
                        UPDATE sfd_file SET sfdconf=l_sfdconf WHERE sfd01=g_sfb.sfb85
                        COMMIT WORK
                     ELSE
                        ROLLBACK WORK
                     END IF
                  ELSE
                    #CALL i301sub_x(g_sfb.sfb01,FALSE,'Y')    #CHI-D20010
                     CALL i301sub_x(g_sfb.sfb01,FALSE,'Y',2)  #CHI-D20010
                     IF g_success = 'Y' THEN
                        CALL i301_del_edg()
                        DELETE FROM sfd_file WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01
                        UPDATE sfb_file SET sfb85='' WHERE sfb01=g_sfb.sfb01
                     END IF
                  END IF
               ELSE
                 #CALL i301sub_x(g_sfb.sfb01,FALSE,'Y')    #FUN-A80054    #CHI-D20010
                  CALL i301sub_x(g_sfb.sfb01,FALSE,'Y',2)  #FUN-A80054    #CHI-D20010
               END IF
               CALL i301sub_refresh(g_sfb.sfb01) RETURNING g_sfb.*  #FUN-A80054
               CALL i301_show() #FUN-A80054
               #FUN-A80054--end--modify-----------------------------
            END IF
         #CHI-D20010---end

         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL i301_out()
                SELECT sfb04 INTO g_sfb.sfb04 FROM sfb_file
                WHERE sfb01=g_sfb.sfb01
                DISPLAY BY NAME g_sfb.sfb04
            END IF
         WHEN "exporttoexcel"
            IF cl_chk_act_auth() THEN
              #CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_sfa),'','') #FUN-CB0014 mark
              #FUN-CB0014---add---str---
              LET w = ui.Window.getCurrent()
              LET f = w.getForm()
              IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN
                 LET page = f.FindNode("Page","page_main")
                 CALL cl_export_to_excel(page,base.TypeInfo.create(g_sfa),'','')
              END IF
              IF g_action_flag = "page_list" THEN
                 LET page = f.FindNode("Page","page_list")
                    CALL cl_export_to_excel(page,base.TypeInfo.create(g_sfb_l),'','')
              END IF
              #FUN-CB0014---add---end---
            END IF

         WHEN "gen_m_iss"  #產生雜發單
           CALL i301_gen_m_iss()
         WHEN "m_iss"  #維護雜發單
           CALL i301_m_iss()

         WHEN "related_document"  #相關文件
            IF cl_chk_act_auth() THEN
               IF g_sfb.sfb01 IS NOT NULL THEN
                  LET g_doc.column1 = "sfb01"
                  LET g_doc.value1 = g_sfb.sfb01
                  CALL cl_doc()
               END IF
            END IF

         #APS相關資料
         WHEN "aps_related_data"
               IF cl_chk_act_auth()  THEN
                  CALL i301_aps()
               END IF

         #APS製令外包
         WHEN "aps_route_subc_data"
               IF cl_chk_act_auth() and g_sfb.sfb02='7' THEN  #FUN-870012
                  CALL i301_aps_routesubc()
               END IF
               IF g_sfb.sfb02<>'7' THEN  #FUN-870012
                  CALL cl_err('','aps-707',1)
               END IF

         #CHI-A50032 add --start--
         WHEN "wo_change"
           IF cl_chk_act_auth() THEN

             #FUN-C30017 mark--str---
             #LET g_msg="asft803 '",g_sfb.sfb01,"'"
             #CALL cl_cmdrun_wait(g_msg)
             #FUN-C30017 mark--end---
              #FUN-C30017 add---str---
              IF g_sfb.sfb43 NOT MATCHES '[Ss]' THEN
                  LET g_msg="asft803 '",g_sfb.sfb01,"'"
                  CALL cl_cmdrun_wait(g_msg)
              ELSE
                  CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
              END IF
              #FUN-C30017 add---end---
           END IF
         #CHI-A50032 add --end--
         #add by lanhang 131125 begin
         WHEN "sfa_detail"
            IF cl_chk_act_auth() THEN
               LET l_ac=ARR_CURR()
               CALL i301_sfa_det(l_ac)
            END IF
         #add by lanhang 131125 end

         #DEV-D30026-----add----begin------------
          WHEN "barcode_gen"     #條碼產生
              IF cl_chk_act_auth() THEN
                 #CALL i301_barcode_gen()                  #DEV-D30045--mark
                 CALL i301sub_barcode_gen(g_sfb.sfb01,'Y') #DEV-D30045--mod
              END IF

          WHEN "barcode_query"   #條碼查詢
              IF cl_chk_act_auth() THEN
                 LET l_sql = "abaq100 '",g_sfb.sfb01,"' "
                 CALL cl_cmdrun_wait(l_sql)
              END IF

        #DEV-D30026---add----end----------------
         #No:DEV-CB0005--add--begin
         WHEN "barcode_output"  #條碼列印
             IF cl_chk_act_auth() THEN
                IF g_sfb.sfb01 IS NULL THEN
                   CALL cl_err('',-400,0)
                ELSE
                  #DEV-D30026 add str----------------------------
                   SELECT ima918,ima921,ima931 INTO l_ima918,l_ima921,l_ima931
                     FROM ima_file
                    WHERE ima01 = g_sfb.sfb05

                   IF cl_null(l_ima918) THEN LET l_ima918 = 'N' END IF
                   IF cl_null(l_ima921) THEN LET l_ima921 = 'N' END IF
                   IF cl_null(l_ima931) THEN LET l_ima931 = 'N' END IF
                  #DEV-D30026 add end--------------------------
                   LET g_msg=' ibb03="',g_sfb.sfb01 CLIPPED,'"'
                   LET g_cmd = "abar100",
                       " '",g_today CLIPPED,"' ''",
                       " '",g_lang CLIPPED,"' 'Y' '' '1'",
                       " '' '' '' '' ",
                       " '",g_msg CLIPPED,"' "
                      #" 'C' 'A' '2'"              #DEV-D30026 mark
                      ," ' ' 'A' '",s_gen_barcode_ibd07(),"'"   #DEV-D30045--add
                  #DEV-D30045--mark--begin
                  ##DEV-D30026 add str----------------------------
                  # IF l_ima931 = "Y" THEN #料件為包號管理
                  #    LET g_cmd = g_cmd," 'C' 'A' '2'"
                  # END IF
                  ##DEV-D30026 add end--------------------------
                  #DEV-D30045--mark--end
                   CALL cl_cmdrun_wait(g_cmd)
                END IF
             END IF
         #No:DEV-CB0005--add--end
      END CASE
   END WHILE
   CLOSE i301_cs
END FUNCTION


FUNCTION i301_a()
    DEFINE l_sfc        RECORD LIKE sfc_file.*
   #DEFINE l_sfd        RECORD LIKE sfd_file.*   #FUN-A80054
    DEFINE l_smy57      LIKE smy_file.smy57
    DEFINE li_result    LIKE type_file.num5      #No.FUN-550067  #No.FUN-680121 SMALLINT
    DEFINE l_n1         LIKE type_file.num5   #FUN-A80054
    DEFINE l_sfd08      LIKE sfd_file.sfd08   #FUN-A80054
    DEFINE l_cnt        LIKE type_file.num5   #No.MOD-B30028

    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
    CALL g_sfa.clear()
    CALL g_sfa29.clear()
    INITIALIZE g_sfb.* TO NULL
    LET g_sfb_o.* = g_sfb.*
    LET g_sfb_t.* = g_sfb.*
    CALL cl_opmsg('a')
    WHILE TRUE
        LET g_pmn01=NULL
        LET g_sfb.sfb02  =1
        LET g_sfb.sfb04  =1
        LET g_sfb.sfb071 = TODAY  #MOD-D60038 add
        LET g_sfb.sfb081 =0
        LET g_sfb.sfb09  =0
        LET g_sfb.sfb10  =0
        LET g_sfb.sfb11  =0
        LET g_sfb.sfb111 =0
        LET g_sfb.sfb12  =0
        LET g_sfb.sfb13  =TODAY
        LET g_sfb.sfb14 = "00:00"      #MOD-A80050 add
        LET g_sfb.sfb16 = "00:00"      #MOD-A80050 add
        LET g_sfb.sfb23  ='N'
        LET g_sfb.sfb24  ='N'
        LET g_sfb.sfb41  ='N'
        LET g_sfb.sfb99  ='N'
        LET g_sfb.sfb12  =0
        LET g_sfb.sfb121 =0
        LET g_sfb.sfb29  ='Y'
        LET g_sfb.sfb39  ='1'
        LET g_sfb.sfb81  =TODAY
        LET g_sfb.sfb87  ='N'
        LET g_sfb.sfb98  =' '
        LET g_sfb.sfb1002 = 'N'  #FUN-6A0007
        LET g_sfb.sfbacti='Y'
        LET g_sfb.sfbuser=g_user
        LET g_sfb.sfboriu = g_user #FUN-980030
        LET g_sfb.sfborig = g_grup #FUN-980030
        LET g_data_plant = g_plant #FUN-980030
        LET g_sfb.sfbgrup=g_grup
        LET g_sfb.sfbdate=TODAY
        LET g_sfb.sfb95 = ' '      #FUN-550014 add 特性代碼
        LET g_sfb.sfb1002='N' #保稅核銷否 #FUN-6B0044
        LET g_sfb.sfb43 = '0'      #FUN-8C0081 add
        LET g_sfb.sfb44 = g_user   #FUN-8C0081 add
        LET g_sfb.sfbmksg = 'N'    #FUN-8C0081 add
        LET g_sfb.sfbplant = g_plant #FUN-980008 add
        LET g_sfb.sfblegal = g_legal #FUN-980008 add
        LET g_sfb.ta_sfb35 = 'N'
        CALL i301_i("a")                #輸入單頭
        LET g_sfb.sfb251 = g_sfb.sfb13   #TQC-970073

        IF INT_FLAG THEN
           LET INT_FLAG=0 CALL cl_err('',9001,0)
           INITIALIZE g_sfb.* TO NULL
           ROLLBACK WORK EXIT WHILE
        END IF
        IF g_sfb.sfb98 IS NULL THEN LET g_sfb.sfb98 = ' ' END IF
        IF g_sfb.sfb01 IS NULL THEN CONTINUE WHILE END IF

        SELECT smy57 INTO l_smy57 FROM smy_file  #NO:6961
         WHERE smyslip=g_t1
        LET g_sfb.sfb100=l_smy57[6,6]
        IF g_sfb.sfb02 NOT MATCHES "[78]" THEN   #MOD-D50063 add
           LET g_sfb.sfb100='1'                  #MOD-D50063 add
        END IF                                   #MOD-D50063 add

        IF cl_null(g_sfb.sfb100) THEN
            LET g_sfb.sfb100=1
        END IF                                   #NO:6961
        BEGIN WORK   #No:7829
        CALL s_auto_assign_no("asf",g_sfb.sfb01,g_sfb.sfb81,"1","sfb_file","sfb01","","","")
             RETURNING li_result,g_sfb.sfb01
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY BY NAME g_sfb.sfb01

#FUN-A20037 --begin--
        IF cl_null(g_sfb.sfb104) THEN
           LET g_sfb.sfb104 = 'N'
        END IF
#FUN-A20037  --end--

        INSERT INTO sfb_file VALUES (g_sfb.*)
        IF STATUS THEN
           CALL cl_err3("ins","sfb_file",g_sfb.sfb01,"",STATUS,"","ins sfb:",1)  #No.FUN-660128
           ROLLBACK WORK   #No:7829
           CONTINUE WHILE
          #FUN-960025 ADD --STR-------------------------------
           IF g_sfb.sfb02='7' AND g_sfb.sfb41='Y' THEN
              UPDATE vnf_file SET vnf03 = '2'
               WHERE vnf01 = g_sfb.sfb01
           ELSE
              IF g_sfb.sfb02='7' AND (g_sfb.sfb41='N' OR g_sfb.sfb41 IS NULL) THEN
                 UPDATE vnf_file SET vnf03 = '1'
                  WHERE vnf01 = g_sfb.sfb01
              END IF
           END IF
          #FUN-960025 ADD --END-------------------------------
        END IF
        COMMIT WORK

        CALL cl_flow_notify(g_sfb.sfb01,'I')

        IF NOT cl_null(g_sfb.sfb85) THEN  #FUN-A80054 86-->86
           LET g_cnt=0                                                       #FUN-A80054
           SELECT count(*) INTO g_cnt FROM sfc_file WHERE sfc01=g_sfb.sfb85  #FUN-A80054
           IF g_cnt = 0 THEN                                                 #FUN-A80054
              LET l_sfc.sfc01=g_sfb.sfb85 #FUN-A80054
              LET l_sfc.sfcacti='Y'
              LET l_sfc.sfcuser=g_user
              LET l_sfc.sfcdate=TODAY
              LET l_sfc.sfcoriu = g_user      #No.FUN-980030 10/01/04
              LET l_sfc.sfcorig = g_grup      #No.FUN-980030 10/01/04
              INSERT INTO sfc_file VALUES(l_sfc.*)
           END IF   #FUN-A80054
#FUN-A80054--begin--modify------------------------
           SELECT distinct sfd08 INTO l_sfd08 FROM sfd_file WHERE sfd01=g_sfb.sfb85
           IF NOT cl_null(l_sfd08) THEN
              LET l_n1 = 0
              SELECT count(*) INTO l_n1 FROM edb_file,eda_file
               WHERE edb01=l_sfd08 AND edb03=g_sfb.sfb05
                 AND edb04=g_sfb.sfb06 AND eda01=edb01 AND edaconf='Y'
              IF l_n1 > 0 THEN
                 CALL i301_ins_sfd(l_sfd08)
              END IF
           END IF
           CALL i301_ins_sfd_1()
#          SELECT COUNT(*) INTO g_cnt FROM sfd_file
#            WHERE sfd01=g_sfb.sfb86 AND sfd03=g_sfb.sfb01
#          IF g_cnt=0 THEN
#             SELECT MAX(sfd02)+1 INTO g_cnt FROM sfd_file
#               WHERE sfd01=g_sfb.sfb86
#             IF g_cnt=0 OR g_cnt IS NULL THEN LET g_cnt= 1 END IF
#             LET l_sfd.sfd01=g_sfb.sfb86
#             LET l_sfd.sfd02=g_cnt
#             LET l_sfd.sfd03=g_sfb.sfb01
#             LET l_sfd.sfdconf='N'     #FUN-A80054
#             INSERT INTO sfd_file VALUES(l_sfd.*)
#          END IF
#FUN-A80054--end--modify---------------------------
        END IF

        SELECT sfb01 INTO g_sfb.sfb01 FROM sfb_file WHERE sfb01 = g_sfb.sfb01
        LET g_sfb_t.* = g_sfb.*
        CALL g_sfa.clear()
        CALL g_sfa29.clear()
        LET g_rec_b = 0

        IF g_sma.sma26='2' AND g_sfb.sfb02 != 11 AND g_sfb.sfb02 != 15
                           AND g_sfb.sfb02 != 7  AND g_sfb.sfb02 != 8  THEN
           CALL i301_crrut("a")   #MOD-A40026 add "a"
        END IF
        IF g_sma.sma27='1' THEN
           CALL i301_cralc()
           CALL i301_b_fill( '1=1')
           CALL i301_b(' ')


        END IF

        EXIT WHILE
    END WHILE

END FUNCTION

FUNCTION i301_u()

   IF s_shut(0) THEN RETURN END IF

   IF g_sfb.sfb01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF

   SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01 = g_sfb.sfb01

   IF g_sfb.sfb04 = '8' THEN CALL cl_err('','aap-730',0) RETURN END IF

   IF g_sfb.sfb87 = 'Y' THEN CALL cl_err('','aap-086',1) RETURN END IF

   IF g_sfb.sfb87 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF

   IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43 = '9' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
   IF g_sfb.sfb43 MATCHES '[Ss]' THEN
      CALL cl_err('','apm-030',0)
      RETURN
   END IF

   SELECT COUNT(*) INTO l_n FROM pmm_file,pmn_file     #NO:6961
    WHERE pmm01=pmn01
      AND pmn41=g_sfb.sfb01

   IF l_n>0 THEN CALL cl_err('','asf-936',0) RETURN END IF         #NO:6961

   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_sfb_o.* = g_sfb.*

   BEGIN WORK

   OPEN i301_cl USING g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err("OPEN i301_cl:", STATUS, 1)
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH i301_cl INTO g_sfb.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err('lock sfb:',SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF
   CALL i301_show()

   WHILE TRUE
      LET g_sfb.sfbmodu = g_user
      LET g_sfb.sfbdate = TODAY

      CALL i301_i("u")                      #欄位更改

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_sfb.*=g_sfb_t.*
         CALL i301_show()
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF

      LET g_sfb.sfb43 = '0'    #FUN-8C0081 add
      UPDATE sfb_file SET * = g_sfb.*
       WHERE sfb01 = g_sfb_t.sfb01

      IF STATUS THEN
         CALL cl_err3("upd","sfb_file",g_sfb_t.sfb01,"",STATUS,"","",1)  #No.FUN-660128
         CONTINUE WHILE
      END IF

      #FUN-960025 ADD --STR------------------------------
       IF g_sfb.sfb02='7' AND g_sfb.sfb41='Y' THEN
          UPDATE vnf_file SET vnf03 = '2'
           WHERE vnf01 = g_sfb.sfb01
       ELSE
          IF g_sfb.sfb02='7' AND (g_sfb.sfb41='N' OR g_sfb.sfb41 IS NULL) THEN
             UPDATE vnf_file SET vnf03 = '1'
              WHERE vnf01 = g_sfb.sfb01
          END IF
       END IF
     #FUN-960025 ADD --STR-------------------------------

      IF g_sfb.sfb01 != g_sfb_t.sfb01 THEN
         CALL i301_chkkey()
      END IF

     #str MOD-A40026 add
     #修改製程編號後應自動重新產生製程追蹤檔
      IF g_sma.sma26='2' AND g_sfb.sfb02 != 11 AND g_sfb.sfb02 != 15
                         AND g_sfb.sfb02 != 7  AND g_sfb.sfb02 != 8  THEN
         CALL i301_crrut("u")
      END IF
     #end MOD-A40026 add

      EXIT WHILE
   END WHILE

   CLOSE i301_cl
   DISPLAY BY NAME g_sfb.sfb43   #FUN-8C0081 add
   COMMIT WORK
   CALL cl_flow_notify(g_sfb.sfb01,'U')
   CALL i301_show()        #FUN-8C0081 add
END FUNCTION

FUNCTION i301_chkkey()

   LET g_success='Y'

   UPDATE sfa_file SET sfa01=g_sfb.sfb01
    WHERE sfa01=g_sfb_t.sfb01
   IF STATUS THEN
      CALL cl_err3("upd","sfa_file",g_sfb_t.sfb01,"",STATUS,"","upd sfa01",1)  #No.FUN-660128
      LET g_sfb.*=g_sfb_t.*
      CALL i301_show()
      ROLLBACK WORK
      RETURN
   END IF


   UPDATE ecm_file SET ecm01=g_sfb.sfb01
    WHERE ecm01=g_sfb_t.sfb01
   IF STATUS THEN
      CALL cl_err3("upd","ecm_file",g_sfb_t.sfb01,"",STATUS,"","upd ecm01",1)  #No.FUN-660128
      LET g_sfb.*=g_sfb_t.*
      CALL i301_show()
      ROLLBACK WORK
      RETURN
   #TQC-940179 ADD --STR--------------------
   ELSE
      IF g_sma.sma901='Y' THEN
         UPDATE vmn_file SET vmn02 = g_sfb.sfb01
          WHERE vmn02 = g_sfb_t.sfb01
         UPDATE vnm_file SET vnm01 = g_sfb.sfb01
          WHERE vnm01 = g_sfb_t.sfb01
      END IF
   #TQC-940179 ADD --END--------------------
   END IF

END FUNCTION

FUNCTION i301_i(p_cmd)
   DEFINE g_h1         LIKE type_file.chr2     #FUN-9A0029 add
   DEFINE g_m1         LIKE type_file.chr2     #FUN-9A0029 add
   DEFINE p_cmd,pja_flag  LIKE type_file.chr1                 #a:輸入 u:更改  #No.FUN-680121 VARCHAR(1)  #FUN-810045 gja->pja
   DEFINE l_flag          LIKE type_file.chr1                 #判斷必要欄位是否有輸入  #No.FUN-680121 VARCHAR(1)
   DEFINE l_daywk         LIKE type_file.chr1                 #No.FUN-680121 VARCHAR(1)               #MOD-530280-4 add
   DEFINE l_part          LIKE oeb_file.oeb04                 #No.MOD-490217
#  DEFINE l_qty           LIKE ima_file.ima26                 #No.FUN-680121 DEC(15,3)
   DEFINE l_qty           LIKE type_file.num15_3              ###GP5.2  #NO.FUN-A20044 #NO.FUN-A40023
   DEFINE l_ver           LIKE sfb_file.sfb07                 #No.FUN-680121 VARCHAR(2)
   DEFINE l_code          LIKE type_file.chr1                 #No.FUN-680121 VARCHAR(1)
   DEFINE g_bomdate       LIKE type_file.dat                  #No.FUN-680121 DATE
   DEFINE l_ineffectiveDate LIKE type_file.dat                #No.FUN-680121 DATE
   DEFINE g_cnt           LIKE type_file.num5                 #No.FUN-680121 SMALLINT
   DEFINE l_mss_v         LIKE mss_file.mss_v
   DEFINE l_in,l_n        LIKE type_file.num5                 #No.FUN-680121 SMALLINT
   DEFINE l_mss00         LIKE mss_file.mss00
   DEFINE l_bmq    RECORD LIKE bmq_file.*
   DEFINE l_ksg    RECORD LIKE ksg_file.*
   DEFINE l_bmo05         LIKE bmo_file.bmo05
   DEFINE l_sfb08         LIKE sfb_file.sfb08
   DEFINE l_smy57         LIKE smy_file.smy57
   DEFINE l_oeb05         LIKE oeb_file.oeb05
   DEFINE l_ima55         LIKE ima_file.ima55
   DEFINE l_ima562        LIKE ima_file.ima562           #MOD-530808
   DEFINE l_oeb15         LIKE oeb_file.oeb15            #MOD-530808
   DEFINE l_ima02         LIKE ima_file.ima02
   DEFINE l_coc10         LIKE coc_file.coc10            #No.MOD-4B0275
   DEFINE l_coc04         LIKE coc_file.coc04            #No.MOD-4B0275
   DEFINE l_factor        LIKE ima_file.ima31_fac        #No.FUN-680121 DEC(16,8)
#  DEFINE l_woqty         LIKE ima_file.ima26            #No.FUN-680121 DEC(15,3)
   DEFINE l_woqty         LIKE type_file.num15_3         ###GP5.2  #NO.FUN-A20044
   DEFINE l_oeb12         LIKE oeb_file.oeb12
   DEFINE l_cnt           LIKE type_file.num5            #No.FUN-680121 SMALLINT
   DEFINE l_cnt1          LIKE type_file.num5            #No.TQC-940070
   DEFINE l_ima910        LIKE ima_file.ima910           #FUN-550112
   DEFINE l_bmq910        LIKE bmq_file.bmq910           #FUN-560027 add
   DEFINE li_result       LIKE type_file.num5            #No.FUN-550067  #No.FUN-680121 SMALLINT
   DEFINE l_time          LIKE type_file.num5            #No.FUN-680121 SMALLINT  #No.MOD-550190
   DEFINE l_sfb15         LIKE sfb_file.sfb15            #No.MOD-550190
   DEFINE l_ima140        LIKE ima_file.ima140           #No.MOD-570203
   DEFINE l_ima1401       LIKE ima_file.ima1401          #No.FUN-6A0036
   DEFINE l_msb04         LIKE msb_file.msb04            #No.MOD-570203
   DEFINE l_sfb08_t       LIKE sfb_file.sfb08            #No.MOD-680077 add
   DEFINE l_sfb13_t       LIKE sfb_file.sfb13            #No.MOD-680077 add
   DEFINE l_sfb05_t       LIKE sfb_file.sfb05            #No.MOD-680077 add
   DEFINE l_ima08         LIKE ima_file.ima08,           #No.CHI-6A0028 add
          l_eci01         LIKE eci_file.eci01
   DEFINE l_gem02         LIKE gem_file.gem02            #No.TQC-740125
   DEFINE l_date          LIKE sfb_file.sfb13            #no.MOD-7A0181
   DEFINE l_sfb15_t       LIKE sfb_file.sfb15            #NO.MOD-7A0181
   DEFINE l_ima1010       LIKE type_file.num5            #MOD-7B0072
   DEFINE l_pmc           LIKE type_file.num5            #MOD-7B0074
   DEFINE l_qty1          LIKE sfb_file.sfb08            #No.MOD-7C0213 add
   DEFINE l_qty2          LIKE ima_file.ima56            #No.MOD-7C0213 add
   DEFINE l_pjb25         LIKE pjb_file.pjb25            #No.FUN-950056
   DEFINE l_n1            LIKE type_file.num5            #No.FUN-810017
   DEFINE l_oeb41         LIKE oeb_file.oeb41,   #專案
          l_oeb42         LIKE oeb_file.oeb42,   #WBS
          l_oeb43         LIKE oeb_file.oeb43,   #活動
          l_oeb1001       LIKE oeb_file.oeb1001  #費用原因
   DEFINE l_ecu10         LIKE ecu_file.ecu10            #MOD-840481
   DEFINE   l_pjb09   LIKE pjb_file.pjb09   #No.FUN-850027
   DEFINE   l_pjb11   LIKE pjb_file.pjb11   #No.FUN-850027
   DEFINE l_ima59           LIKE ima_file.ima59,
          l_ima60           LIKE ima_file.ima60,
          l_ima61           LIKE ima_file.ima61,
          l_cn              LIKE type_file.num5,
          s_date            LIKE type_file.num5
   DEFINE l_oeb908          LIKE oeb_file.oeb908         #CHI-910055
   DEFINE l_gen02           LIKE gen_file.gen02          #FUN-8C0081 add
   DEFINE l_azf09           LIKE azf_file.azf09          #FUN-930145
   DEFINE l_oea00           LIKE oea_file.oea00         #No.MOD-940349 add
   DEFINE l_slip            LIKE smy_file.smyslip        #No.FUN-980038
   DEFINE l_sfb02           LIKE sfb_file.sfb02          #No.FUN-980038
   DEFINE l_sfd08           LIKE sfd_file.sfd08                   #FUN-A80054
   DEFINE l_sfd06           LIKE sfd_file.sfd06                   #FUN-A80054
   DEFINE l_sfd01           DYNAMIC ARRAY OF LIKE sfd_file.sfd01  #FUN-A80054
   DEFINE i,n               LIKE type_file.num5                   #FUN-A80054
   #CHI-B80044 -- begin --
   DEFINE l_oebqty          LIKE type_file.num15_3   #訂單數量
   DEFINE l_availqty        LIKE sfb_file.sfb08      #訂單可轉工單數量
   DEFINE l_allowqty        LIKE sfb_file.sfb08      #允許生產數量
   DEFINE l_calc            LIKE type_file.num5      #計算批量倍數用
   #CHI-B80044 -- end --
   DEFINE l_cnt2            LIKE type_file.num5      #MOD-C30548
   DEFINE l_ima928          LIKE ima_file.ima928     #FUN-C30047
   DEFINE l_sfb919          LIKE sfb_file.sfb919     #MOD-C90005 add
   DEFINE l_smy72           LIKE smy_file.smy72,     #MOD-CC0152 add
          l_slip2           LIKE smy_file.smyslip    #MOD-CC0152 add
   DEFINE l_oeb72           LIKE oeb_file.oeb72      #MOD-D50191 add
   DEFINE l_sfb221          STRING                   #add by lanhang 130925
   DEFINE l_sfb92           STRING                   #add by lanhang 130925
   DEFINE l_oebud07         LIKE oeb_file.oebud07
   DEFINE l_tc_sfb09 LIKE tc_sfb_file.tc_sfb09 #add by wy20150526


    LET g_bomdate=NULL
    LET l_IneffectiveDate=NULL
    DISPLAY BY NAME g_sfb.sfb44,g_sfb.sfb081,g_sfb.sfb09,g_sfb.sfb12,    #FUN-8C0081 add sfb44
                    g_sfb.sfb28,g_sfb.sfb38,g_sfb.sfb23,g_sfb.sfb24,g_sfb.sfb87,
                    g_sfb.sfbuser,g_sfb.sfbgrup,g_sfb.sfbdate,g_sfb.sfbacti
    DISPLAY BY NAME g_sfb.sfb1001,g_sfb.sfb1002,g_sfb.sfb1003,g_sfb.ta_sfb35,g_sfb.ta_sfb43,g_sfb.ta_sfb44,g_sfb.ta_sfb45
    CALL cl_set_head_visible("","YES")  #NO.FUN-6B0031
    INPUT BY NAME g_sfb.sfboriu,g_sfb.sfborig,g_sfb.sfb01,g_sfb.sfb101,g_sfb.sfb44,g_sfb.sfb81,g_sfb.sfb02,g_sfb.sfb39,   #FUN-8C0081 add sfb44
                  g_sfb.sfb87,g_sfb.sfb04,g_sfb.sfb28,g_sfb.sfb38,g_sfb.sfbmksg,g_sfb.sfb43,g_sfb.sfb98,    #FUN-8C0081 add sfbmksg,sfb43
                  g_sfb.sfb82,
                  g_sfb.sfb102,  #FUN-730043
                  g_sfb.sfb22,g_sfb.sfb221,g_sfb.sfb91,g_sfb.sfb92,
                  g_sfb.sfb86,g_sfb.sfb89,  #FUN-C30114 asf89
                  g_sfb.sfb05,
                  g_sfb.sfb95,g_sfb.sfb08,
                  g_sfb.sfb07,   #No.TQC-610003   #No.MOD-640245  mdoify
                  g_sfb.sfb071,g_sfb.sfb93,g_sfb.sfb06,        #No:7254
                 #g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb25,g_sfb.sfb081,                         #FUN-9A0029 mark
                  g_sfb.sfb13,g_sfb.sfb14,g_sfb.sfb15,g_sfb.sfb16,g_sfb.sfb25,g_sfb.sfb081, #FUN-9A0029 add
                  g_sfb.sfb09,g_sfb.sfb12,g_sfb.sfb85,g_sfb.sfb919,g_sfb.sfb23,g_sfb.sfb24,   #No.FUN-810017  #FUN-A80102
                  g_sfb.sfb41,g_sfb.sfb99,g_sfb.sfb94,g_sfb.sfb100, #No:7254
                  g_sfb.sfb34,g_sfb.sfb96,g_sfb.sfb40,g_sfb.sfb1001,g_sfb.sfb97, #FUN-6A0007 add sfb1001 #CHI-970012 add sfb96
                  g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51,g_sfb.sfb30,  #FUN-810045 add sfb50/51
                  g_sfb.sfb31,g_sfb.sfb32,g_sfb.sfb33,g_sfb.sfb222
                  ,g_sfb.sfbud01,g_sfb.sfbud02,g_sfb.sfbud03,g_sfb.sfbud04,
                  g_sfb.sfbud05,g_sfb.sfbud06,g_sfb.sfbud07,g_sfb.sfbud08,
                  g_sfb.sfbud09,g_sfb.sfbud10,g_sfb.sfbud11,g_sfb.sfbud12,
                  g_sfb.sfbud13,g_sfb.sfbud14,g_sfb.sfbud15,
                  g_sfb.ta_sfb43,g_sfb.ta_sfb44,g_sfb.ta_sfb45  #add by wy20150811 加工单价结算需要能自己修改
                  ,g_sfb.ta_sfb37 #zangheng20170921aps

        WITHOUT DEFAULTS

        BEFORE INPUT
          LET g_before_input_done = FALSE
          CALL i301_set_entry(p_cmd)
          CALL i301_set_no_entry(p_cmd)
          CALL i301_set_no_required()
          CALL i301_set_required()
          #No.TQC-C80129--add--str--
          IF p_cmd = 'u' THEN
             LET l_sfb08_t = g_sfb.sfb08
             LET l_sfb13_t = g_sfb.sfb13
             LET l_sfb15_t = g_sfb.sfb15
          END IF
          #No.TQC-C80129--add--end--
          LET g_before_input_done = TRUE
          CALL cl_set_docno_format("sfb01")

        BEFORE FIELD sfb01
          CALL i301_set_entry(p_cmd)
          CALL i301_set_no_required()

        AFTER FIELD sfb01
            #FUN-B50026 add
            IF NOT cl_null(g_sfb.sfb01) AND (g_sfb.sfb01 != g_sfb_t.sfb01 OR g_sfb_t.sfb01 IS NULL) THEN
               CALL s_check_no("asf",g_sfb.sfb01,g_sfb_t.sfb01,"1","sfb_file","sfb01","")
               RETURNING li_result,g_sfb.sfb01
               DISPLAY BY NAME g_sfb.sfb01
               IF (NOT li_result) THEN
                 NEXT FIELD sfb01
               END IF
              #MOD-CC0152---add---S
               CALL s_get_doc_no(g_sfb.sfb01) RETURNING l_slip2
               SELECT smy72 INTO l_smy72 FROM smy_file WHERE smyslip = l_slip2

               IF l_smy72 MATCHES '[58]' OR l_smy72 ='11' THEN
                  LET g_sfb.sfb99  ='Y'
                  DISPLAY BY NAME g_sfb.sfb99
               ELSE
                  LET g_sfb.sfb99  ='N'
                  DISPLAY BY NAME g_sfb.sfb99
               END IF
              #MOD-CC0152---add---E
            END IF
            #FUN-B50026 add--end
            IF p_cmd = "a" THEN
              IF NOT cl_null(g_sfb.sfb01) THEN
               #Mark FUN-B50026
               #CALL s_check_no("asf",g_sfb.sfb01,g_sfb_t.sfb01,"1","sfb_file","sfb01","")
               #RETURNING li_result,g_sfb.sfb01
               #DISPLAY BY NAME g_sfb.sfb01
               #IF (NOT li_result) THEN
               #  NEXT FIELD sfb01
               #END IF
               #Mark FUN-B50026--end
                CALL i301_sfb01(p_cmd)
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err(g_sfb.sfb01,g_errno,0)
                   LET g_sfb.sfb01 = g_sfb_t.sfb01
                   DISPLAY BY NAME g_sfb.sfb01
                   NEXT FIELD sfb01
                END IF
                 IF g_sfb_t.sfb01 IS NULL OR (g_sfb.sfb01 != g_sfb_t.sfb01) THEN
                    LET g_sfb.sfbmksg = g_smy.smyapr
                    DISPLAY BY NAME g_sfb.sfbmksg
                 END IF

                  DISPLAY BY NAME g_smy.smydesc       #NO.MOD-730120 re mark
                  CALL i301sub_sfb100(g_sfb.*)      #TQC-730022
                       RETURNING g_sfb.sfb100       #TQC-730022
                  DISPLAY BY NAME g_sfb.sfb100      #TQC-730022
                 IF cl_null(g_sfb_t.sfb01) THEN
                    CALL s_get_doc_no(g_sfb.sfb01) RETURNING l_slip
                    SELECT smy72 INTO l_sfb02 FROM smy_file
                     WHERE smyslip = l_slip
                    IF NOT cl_null(l_sfb02) THEN
                       LET g_sfb.sfb02 = l_sfb02
                       DISPLAY BY NAME g_sfb.sfb02
                       #TQC-BC0129--begin
                       IF g_sfb.sfb02 ='15' THEN
                          CALL cl_set_comp_required("sfb07",TRUE)
                          DISPLAY BY NAME g_sfb.sfb07
                       END IF
                       #TQC-BC0129--end
                    END IF
                 END IF
                 IF p_cmd = "a" THEN
                    LET g_sfb.sfb93=g_smy.smy57[1,1]
                    LET g_sfb.sfb94=g_smy.smy57[2,2]
                    LET g_sfb.sfb98=g_smy.smy60
                 END IF
                 IF cl_null(g_sfb.sfb93) THEN LET g_sfb.sfb93=g_smy.smy57[1,1] END IF
                 IF cl_null(g_sfb.sfb93) THEN LET g_sfb.sfb93='N' END IF   #No:7254

                 IF cl_null(g_sfb.sfb94) THEN LET g_sfb.sfb94=g_smy.smy57[2,2] END IF
                 IF cl_null(g_sfb.sfb94) THEN LET g_sfb.sfb94='N' END IF   #No:7254

                 IF cl_null(g_sfb.sfb98) THEN LET g_sfb.sfb98=g_smy.smy60 END IF
                 ##add by wy20150526 FBZ开头的工单预计开工日 begin  #mark by wy20160113 begin
                 {SELECT tc_sfb09 INTO l_tc_sfb09 FROM tc_sfb_file WHERE tc_sfb01=0
                 IF g_sfb.sfb01[1,3]='FBZ'   THEN
                    LET g_sfb.sfb13=TODAY+l_tc_sfb09
                 ELSE ##add by wy20150526 FBZ开头的工单预计开工日 end}      #mark by wy20160113 end
                    LET g_sfb.sfb13  =TODAY  #预计开工日
                 #END IF #add by wy20150526 #mark by wy20160113

                 DISPLAY BY NAME g_sfb.sfb13 #add by wy20150526
                 DISPLAY BY NAME g_sfb.sfb93
                 DISPLAY BY NAME g_sfb.sfb94
                 DISPLAY BY NAME g_sfb.sfb98
                 #DEV-D30037--mark--begin
                 ##No:DEV-CB0005--add--begin
                 #CALL t301_chk_smyb(g_sfb.sfb05)
                 # IF NOT cl_null(g_errno) THEN
                 #    CALL cl_err(g_sfb.sfb05,g_errno,0)
                 #    NEXT FIELD sfb01
                 # END IF
                 ##No:DEV-CB0005--add--end
                 #DEV-D30037--mark--end
              END IF
           END IF
           CALL i301_set_no_entry(p_cmd)
           CALL i301_set_required()

        AFTER FIELD sfb81
            IF NOT cl_null(g_sfb.sfb81) THEN
               #TQC-B40002--begin
               IF NOT cl_null(g_sfb.sfb13) THEN
                  IF g_sfb.sfb13 < g_sfb.sfb81 THEN
                     CALL cl_err('','asf-607',1)
                     NEXT FIELD sfb81
                  END IF
               END IF
               #TQC-B40002--end
              #No.B474 010507 by plum add 若此BOM尚未發放,不可用
              #BugNo:4482
              #試產性工單(sfb02='15')於產品料號輸入後不需 check BOM 存在否/發放否
              #FUN-A50066--begin--mark-------
               #IF NOT cl_null(g_sfb.sfb05) AND g_sfb.sfb02 != '15' THEN
               #      SELECT COUNT(*) INTO g_cnt FROM bma_file
               #       WHERE bma01=g_sfb.sfb05
               #         AND bma06 =g_sfb.sfb95
               #      IF g_cnt >0 THEN
               #         SELECT COUNT(*) INTO g_cnt FROM bma_file
               #          WHERE bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81
               #            AND bma01=g_sfb.sfb05
               #            AND bma06 =g_sfb.sfb95 #No.MOD-640245 add
               #         IF g_cnt =0 THEN
               #            CALL cl_err(g_sfb.sfb81,'abm-006',0)
               #            NEXT FIELD sfb81
               #         END IF
               #      END IF
               #END IF
              #FUN-A50066--
            END IF

        BEFORE FIELD sfb98
           CALL i301_set_no_required()
           CALL i301_set_required()

        AFTER FIELD sfb98  #bugno:6487 modify .............................
            IF cl_null(g_sfb.sfb98) THEN LET g_sfb.sfb98 = ' '
            ELSE
               IF g_aaz.aaz90='Y' THEN
                  IF NOT s_costcenter_chk(g_sfb.sfb98) THEN
                     LET g_sfb.sfb98=g_sfb_t.sfb98
                     DISPLAY NULL TO gem02
                     DISPLAY BY NAME g_sfb.sfb98
                     NEXT FIELD sfb98
                  ELSE
                     DISPLAY s_costcenter_desc(g_sfb.sfb98) TO gem02
                  END IF
               ELSE
                  CALL i301_sfb98()
                  IF NOT cl_null(g_errno) THEN
                     CALL cl_err('',g_errno,0)
                     NEXT FIELD sfb98
                  END IF
                  SELECT gem02 INTO l_gem02 FROM gem_file
                   WHERE gem01 = g_sfb.sfb98
                  DISPLAY l_gem02 TO FORMONLY.gem02
               END IF
            END IF
            CALL i301_set_no_required()
            CALL i301_set_required()

        AFTER FIELD sfb102
            IF NOT cl_null(g_sfb.sfb102) THEN
               SELECT eci01 INTO l_eci01 FROM eci_file
                WHERE eci01 = g_sfb.sfb102
               IF STATUS THEN
                  CALL cl_err3("sel","eci_file",g_sfb.sfb102,"","aec-011","","",1) #FUN-660091
                  NEXT FIELD sfb102
               END IF
            END IF

        BEFORE FIELD sfb02
           CALL i301_set_entry(p_cmd)

        AFTER FIELD sfb02
           IF NOT cl_null(g_sfb.sfb02) THEN
              IF g_sfb.sfb02 MATCHES '[78]' THEN
                 LET g_sfb.sfb94 = 'N'
                 DISPLAY BY NAME g_sfb.sfb94
              END IF
              CALL i301sub_sfb100(g_sfb.*)      #MOD-D50063
                    RETURNING g_sfb.sfb100      #MOD-D50063
              DISPLAY BY NAME g_sfb.sfb100      #MOD-D50063
              IF (g_sfb.sfb02 MATCHES '[78]' AND
                 g_sfb_t.sfb02 NOT MATCHES '[78]') THEN #NO:7075
                 SELECT COUNT(*) INTO g_i FROM pmn_file
                  WHERE pmn41=g_sfb.sfb01
                 IF g_i > 0 THEN
                    CALL cl_err('pmn.count','apm-196',1)
                    LET g_sfb.sfb02=g_sfb_t.sfb02
                    DISPLAY BY NAME g_sfb.sfb02
                    NEXT FIELD sfb02
                 END IF
              END IF
              IF g_sfb.sfb02 MATCHES '[58]' OR g_sfb.sfb02='11' THEN   #FUN-7C0021 mod 增加sfb02=11
                 LET g_sfb.sfb99  ='Y'
                 DISPLAY BY NAME g_sfb.sfb99
              ELSE #MOD-970159
                 LET g_sfb.sfb99  ='N' #MOD-970159
                 DISPLAY BY NAME g_sfb.sfb99   #MOD-970159
              END IF

              #MOD-A40006 mark---start---
              #IF g_sfb.sfb02 = '7' THEN
              #  IF g_sfb.sfb39 ='2' THEN
              #     CALL cl_err('','asf-909',1)
              #     LET g_sfb.sfb02 = g_sfb_t.sfb02
              #     DISPLAY BY NAME g_sfb.sfb02
              #     NEXT FIELD sfb02
              #  END IF
              #END IF
              #MOD-A40006 mark---end---

             IF g_sfb.sfb02 ='7'  OR g_sfb.sfb02 = '8' THEN
                 IF NOT cl_null(g_sfb.sfb82) THEN
                     SELECT COUNT(*) INTO l_pmc FROM pmc_file
                      WHERE pmc01=g_sfb.sfb82
                        AND pmcacti= 'Y' AND pmc30 IN ('2','3')
                     IF l_pmc = 0  THEN
                         CALL cl_err3("sel","pmc_file",g_sfb.sfb82,"",STATUS,"","sel pmc",1)
                         NEXT FIELD sfb02
                     END IF
                 END IF
             END IF
             IF NOT (g_sfb.sfb02='5' OR g_sfb.sfb02='8' OR g_sfb.sfb02='11') THEN
              IF NOT cl_null(g_sfb.sfb05) THEN
                 LET l_ima08 = ''
                 SELECT ima08 INTO l_ima08 FROM ima_file
                  WHERE ima01 = g_sfb.sfb05
                   IF l_ima08 = 'P' THEN  #不可為 P
                     CALL cl_err('','asf-208',0)
                     NEXT FIELD sfb02
                   END IF
                 END IF
              END IF
           END IF
           CALL i301_set_entry(p_cmd)  #No.MOD-570386 add
           CALL i301_set_no_entry(p_cmd)

           #MOD-A40006 mark---start---
           #AFTER FIELD sfb39
           #   IF g_sfb.sfb39 = '2' THEN
           #     IF g_sfb.sfb02 ='7' THEN
           #        CALL cl_err('','asf-909',1)
           #        LET g_sfb.sfb39 = g_sfb_t.sfb39
           #        DISPLAY BY NAME g_sfb.sfb39
           #        NEXT FIELD sfb39
           #     END IF
           #   END IF
           #MOD-A40006 mark---end---

        AFTER FIELD sfb82
           IF NOT cl_null(g_sfb.sfb82) THEN
              IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN #NO:7075
                 SELECT pmc03 INTO g_buf FROM pmc_file
                  WHERE pmc01=g_sfb.sfb82
                    AND pmcacti= 'Y'
                 IF STATUS THEN
                    CALL cl_err3("sel","pmc_file",g_sfb.sfb82,"",STATUS,"","sel pmc",1)  #No.FUN-660128
                    NEXT FIELD sfb82
                 END IF
                 CALL i301_pmh05()
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_sfb.sfb82,g_errno,1)
                    NEXT FIELD sfb82
                 END IF
              ELSE
                 SELECT gem02 INTO g_buf FROM gem_file
                  WHERE gem01=g_sfb.sfb82
                    AND gemacti='Y'   #NO:6950
                 IF STATUS THEN
                    CALL cl_err3("sel","gem_file",g_sfb.sfb82,"",STATUS,"","sel gem",1)  #No.FUN-660128
                    NEXT FIELD sfb82
                 END IF
              END IF
              DISPLAY g_buf TO pmc03
           END IF
        AFTER FIELD sfb86
           IF NOT cl_null(g_sfb.sfb86) THEN
              SELECT COUNT(*) INTO g_cnt FROM sfb_file
               WHERE sfb01 = g_sfb.sfb86
              IF g_cnt = 0 THEN
                 CALL cl_err(g_sfb.sfb86,'mfg0044',0)
                 NEXT FIELD sfb86
              END IF
           END IF
#FUN-C30114---begin
        AFTER FIELD sfb89
           IF NOT cl_null(g_sfb.sfb89) THEN
              SELECT COUNT(*) INTO g_cnt FROM sfb_file
               WHERE sfb01 = g_sfb.sfb89
              IF g_cnt = 0 THEN
                 CALL cl_err(g_sfb.sfb89,'mfg0044',0)
                 NEXT FIELD sfb89
              END IF
           END IF
#FUN-C30114---end
        AFTER FIELD sfb22
           LET pja_flag='-'    #FUN-810045 gja->pja
           IF NOT cl_null(g_sfb.sfb22) AND g_sfb.sfb22[1,g_doc_len]<>'MRP' THEN   #No.FUN-550067
              LET l_oea00 = NULL
              SELECT oea00 INTO l_oea00 FROM oea_file
               WHERE oea01 = g_sfb.sfb22
              IF l_oea00 = '4' THEN
                 CALL cl_err(g_sfb.sfb22,'axm-155',0)
                 NEXT FIELD sfb22
              END IF
              SELECT oea01 FROM oea_file
               WHERE oea01=g_sfb.sfb22
                 AND oeaconf ='Y' #01/08/08 mandy
              IF STATUS THEN
                 SELECT * FROM msa_file
                  WHERE msa01=g_sfb.sfb22
                    AND msa03='N'  #010813增
                    AND msa05<>'X'  #CHI-C80041
                 IF STATUS THEN
                    LET pja_flag='0'  #FUN-810045 gja->pja
                    SELECT * FROM pja_file
                     WHERE pja01=g_sfb.sfb22
                       AND pjaacti = 'Y'
                       AND pjaclose='N'             #FUN-960038
                    IF STATUS THEN
                       CALL cl_err3("sel","pja_file",g_sfb.sfb22,"",100,"","sel oea/msa/pja",1)  #No.FUN-660128 #FUN-810045 gja->pja
                       NEXT FIELD sfb22
                    ELSE
                       LET pja_flag='1'  #FUN-810045 pja->gja
                    END IF
                 END IF
              END IF
              CALL i301_carry_proj() #FUN-810045
           END IF
           IF g_sfb.sfb22 != g_sfb_t.sfb22 OR g_sfb_t.sfb22 IS NULL THEN
              LET g_sfb.sfb97 = NULL
              DISPLAY BY NAME g_sfb.sfb97
           END IF
           LET l_oeb908 = NULL
           LET l_sfb919 = NULL #MOD-C90005 add
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
             #SELECT oeb908 INTO l_oeb908 FROM oeb_file   #MOD-C90005 mark
              SELECT oeb908,oeb919 INTO l_oeb908,l_sfb919 FROM oeb_file   #MOD-C90005 add l_sfb919
               WHERE oeb01 = g_sfb.sfb22
                 AND oeb03 = g_sfb.sfb221
              IF NOT cl_null(l_oeb908) THEN
                 LET g_sfb.sfb97 = l_oeb908
                 DISPLAY BY NAME g_sfb.sfb97
              END IF
              #MOD-C90005 add begin--------------------
              IF NOT cl_null(l_sfb919) AND g_sma.sma1421 = 'Y' THEN
                 LET g_sfb.sfb919 = l_sfb919
                 DISPLAY BY NAME g_sfb.sfb919
              END IF
              #MOD-C90005 add end----------------------
           END IF

#--TQC-D10024--star---
           IF pja_flag!='1' AND NOT cl_null(g_sfb.sfb22)   #FUN-810045 gja->pja
                            AND g_sfb.sfb22[1,g_doc_len]<>'MRP'     #No.FUN-550067
                            AND cl_null(g_sfb.sfb221) THEN
              NEXT FIELD sfb221
           END IF
           IF NOT cl_null(g_sfb.sfb221) THEN
              LET l_code = 'Y'    #MOD-A50195 add
             #str MOD-A40133 add
              #先檢查此訂單編號+項次是否存在訂單檔裡,若是才做asf-005的檢核
              LET g_cnt = 0
              SELECT COUNT(*) INTO g_cnt FROM oea_file,oeb_file
               WHERE oea01=oeb01
                 AND oeb01=g_sfb.sfb22
                 AND oeb03=g_sfb.sfb221
              IF cl_null(g_cnt) THEN LET g_cnt=0 END IF
              IF g_cnt > 0 THEN
             #end MOD-A40133 add
                 #參考q_oea3的sql
                 SELECT COUNT(*) INTO g_cnt
                   FROM oea_file,oeb_file
                  WHERE oeb70 = 'N'
                    AND oea00 <> '0' AND oea00 <> '4'
                    AND oeaconf = 'Y'                             #MOD-990075 add
                    AND oea01=oeb01
                    AND oeb01=g_sfb.sfb22
                    AND oeb03=g_sfb.sfb221
                 IF g_cnt=0 THEN
                    CALL cl_err('','asf-005',1)
                    NEXT FIELD sfb221
                 END IF
                 #上面判斷是判斷訂單是否存在，
                 #下面判斷是判斷定單存在但是否還有多餘量可轉工單
                 SELECT COUNT(*) INTO g_cnt
                   FROM oea_file,oeb_file
                  WHERE oeb70 = 'N'
                    AND oea00 <> '0' AND oea00 <> '4'
                    AND oeb12>(oeb24-oeb25) AND oeaconf = 'Y'
                    AND oea01=oeb01
                    AND oeb01=g_sfb.sfb22
                    AND oeb03=g_sfb.sfb221
                 IF g_cnt=0 THEN
                    IF g_sfb.sfb02 NOT MATCHES '[58]' THEN
                       CALL cl_err('','asf-005',1)
                       NEXT FIELD sfb221
                    END IF
                 END IF
              END IF   #MOD-A40133 add

              #SELECT oeb04,(oeb12-oeb905-oeb24+oeb25),oeb22,oeb05,ima55,((100+ima562)/100),oeb41,oeb42,oeb43,oeb1001  #bug  #MOD-D10066
              SELECT oeb04,oeb12+NVL(oebud07,0),oeb22,oeb05,ima55,((100+ima562)/100),oeb41,oeb42,oeb43,oeb1001  #MOD-D10066
                     ,oeb15,oeb72          #CHI-910028 add   #MOD-D50191 add oeb72
                INTO l_part,l_qty,l_ver,l_oeb05,l_ima55,l_ima562,      # #No: MOD-530808
                     l_oeb41,l_oeb42,l_oeb43,l_oeb1001    #FUN-810045 add
                     ,l_date,l_oeb72    #CHI-910028 add   #MOD-D50191 add l_oeb72
                FROM oeb_file LEFT OUTER JOIN ima_file ON oeb04=ima_file.ima01
               WHERE oeb01=g_sfb.sfb22 AND oeb03=g_sfb.sfb221
                 AND oeb70='N'  #bugno:5512 add......
              #CHI-B80044 -- begin --
              IF g_sfb.sfb02 != '15' THEN   #非試產性工單
                 SELECT * INTO g_ima.* FROM ima_file WHERE ima01 = l_part
              END IF
              LET l_sfb221 = g_sfb.sfb221 USING '#####'                          #add by lanhang 130925
              LET g_sfb.sfbud02 = g_sfb.sfb22 CLIPPED,'_',l_sfb221.trim()        #add by lanhang 130925
              DISPLAY BY NAME g_sfb.sfbud02                                      #add by lanhang 130925
              #CHI-B80044 -- end --
              IF STATUS THEN
                 LET l_date = NULL   #MOD-A40160 add
                 LET l_code = 'N'    #MOD-A50195 add
                 SELECT msb03,(msb05*ima55_fac) #CHI-910028 mark ,msb04
                   INTO l_part,l_qty   #CHI-910028 mark ,l_date
                   FROM msb_file LEFT OUTER JOIN ima_file ON msb03=ima01,msa_file
                  WHERE msb01=g_sfb.sfb22 AND msb02=g_sfb.sfb221
                    AND msb01=msa01 AND msa03 = 'N'
                    AND msa05<>'X'  #CHI-C80041
                 IF STATUS THEN
                    CALL cl_err3("sel","msb_file",g_sfb.sfb22,g_sfb.sfb221,100,"","sel oea/msb",1)  #No.FUN-660128
                    NEXT FIELD sfb221
                 END IF
              END IF
              IF l_qty IS NULL THEN LET l_qty=0 END IF
              CALL s_umfchk(l_part,l_oeb05,l_ima55) RETURNING g_cnt,l_factor
              IF g_cnt = 1 THEN LET l_factor=1 END IF
              IF cl_null(l_ima562) THEN LET l_ima562 = 1 END IF   #no.MOD-7A0181
              LET l_qty=l_qty*l_factor*l_ima562     # #No: MOD-530808
              LET g_sfb.sfb05 = l_part
              LET g_sfb.sfb071 = l_oeb72  #MOD-D50191 add
              IF g_sfb.sfb08=0 OR g_sfb.sfb08 IS NULL THEN
                #str MOD-A50195 add
                 LET l_woqty = 0
                 SELECT SUM(sfb08) INTO l_woqty
                   FROM sfb_file
                  WHERE sfb22 = g_sfb.sfb22 AND sfb221 = g_sfb.sfb221
                   #AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 = sfb09))     #MOD-D20110  mark
                    AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 <= sfb09))    #MOD-D20110
                    AND  sfb01 <> g_sfb.sfb01
                    AND sfb02 !='5' AND sfb02 !='8'     #No:MOD-740060 add
                    AND sfb87 !='X'    #bugno:5512
                 IF SQLCA.sqlcode OR cl_null(l_woqty) THEN
                    LET l_woqty = 0
                 END IF
                #end MOD-A50195 add
                #LET g_sfb.sfb08 = l_qty             #MOD-A50195 mark
                #LET g_sfb.sfb08 = l_qty - l_woqty   #MOD-A50195        #CHI-B80044 mark
                 #MOD-D50082 mark begin---------------------------------
                 ##CHI-B80044 -- begin --
                 #LET l_oebqty = l_qty
                 #LET l_availqty = l_qty - l_woqty
                 #IF l_availqty < 0 THEN
                 #   LET l_availqty = 0
                 #END IF
                 #LET l_allowqty = l_availqty    #MOD-CC0117 move
                 #IF NOT cl_null(g_ima.ima56) AND g_ima.ima56 > 0 THEN
                 #   LET l_calc = 0
                 #  #LET l_allowqty = l_availqty #MOD-CC0117 mark
                 #   IF l_oebqty MOD g_ima.ima56 > 0 THEN
                 #      LET l_calc = l_qty/g_ima.ima56 +1
                 #      LET l_oebqty = l_calc * g_ima.ima56
                 #   END IF
                 #   IF l_availqty MOD g_ima.ima56 > 0 THEN
                 #      LET l_calc = l_availqty/g_ima.ima56 + 1
                 #      LET l_allowqty = l_calc * g_ima.ima56
                 #   END IF
                 #END IF
                 #LET g_sfb.sfb08 = l_allowqty
                 #CHI-B80044 -- end --
                 #MOD-D50082 mark  end ---------------------------------
              END IF
              LET g_sfb.sfb07 = l_ver
              DISPLAY BY NAME g_sfb.sfb07      #MOD-B40106 add
              DISPLAY BY NAME g_sfb.sfb05,g_sfb.sfb08
              DISPLAY BY NAME g_sfb.sfb071     #MOD-D50191 add
              IF NOT cl_null(l_date) THEN      #MOD-A40160 add
                 LET g_sfb.sfb15 = l_date      #NO.MOD-7A0181
                 DISPLAY BY NAME g_sfb.sfb15   #NO.MOD-7A0181
              END IF                           #MOD-A40160 add
              LET l_sfb08_t = g_sfb.sfb08      #NO.MOD-7A0181
              CALL i300_time('2')              #NO.MOD-7A0181
              IF g_sfb.sfb13 < g_sfb.sfb81 THEN
                 LET g_sfb.sfb13 = g_sfb.sfb81
              END IF
              IF g_sfb.sfb13 > g_sfb.sfb15 THEN
                 LET g_sfb.sfb15 = g_sfb.sfb13
                 DISPLAY BY NAME g_sfb.sfb15
              END IF
              DISPLAY BY NAME g_sfb.sfb13      #NO.MOD-7A0181
              LET g_sfb.sfb27 = l_oeb41   #專案
              LET g_sfb.sfb271= l_oeb42   #WBS
              LET g_sfb.sfb50 = l_oeb43   #活動
              LET g_sfb.sfb51 = l_oeb1001 #費用原因
              DISPLAY BY NAME g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51
           END IF
           ###### check是否應開立工單
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
              LET l_woqty = ''
              IF cl_null(g_sfb.sfb01) THEN
                 LET g_sfb.sfb01=' '
              END IF
              SELECT SUM(sfb08) INTO l_woqty
                FROM sfb_file
               WHERE sfb22 = g_sfb.sfb22 AND sfb221 = g_sfb.sfb221
                #AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 = sfb09))     #MOD-D20110  mark
                 AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 <= sfb09))    #MOD-D20110
                 AND  sfb01 <> g_sfb.sfb01
                 AND sfb02 !='5' AND sfb02 !='8'     #No.MOD-740060 add
                 AND sfb87 !='X'    #bugno:5512
              IF SQLCA.sqlcode OR cl_null(l_woqty) THEN
                 LET l_woqty = 0
              END IF
             #MOD-D50082 add begin-------------------------------
              LET l_oebqty = l_qty
              LET l_availqty = l_qty - l_woqty
              IF l_availqty < 0 THEN
                 LET l_availqty = 0
              END IF
              LET l_allowqty = l_availqty
              IF NOT cl_null(g_ima.ima56) AND g_ima.ima56 > 0 THEN
                 LET l_calc = 0
                 IF l_oebqty MOD g_ima.ima56 > 0 THEN
                    LET l_calc = l_qty/g_ima.ima56 +1
                    LET l_oebqty = l_calc * g_ima.ima56
                 END IF
                 IF l_availqty MOD g_ima.ima56 > 0 THEN
                    LET l_calc = l_availqty/g_ima.ima56 + 1
                    LET l_allowqty = l_calc * g_ima.ima56
                 END IF
              END IF
              LET g_sfb.sfb08 = l_allowqty
             #MOD-D50082 add  end--------------------------------
             #IF l_woqty>= g_sfb.sfb08 THEN               #MOD-A50016 mark
             #IF l_woqty + g_sfb.sfb08 > l_qty THEN       #MOD-A50016        #CHI-B80044 mark
              IF l_woqty + g_sfb.sfb08 > l_oebqty THEN    #CHI-B80044
                 IF g_sfb.sfb02 NOT MATCHES '[58]' THEN    #MOD-740060 add
                    CALL cl_err('','asf-001',0)
                    NEXT FIELD sfb221    #No.MOD-8A0242 add
                 END IF                        #MOD-740060 add
              ELSE
                #LET g_sfb.sfb08 = g_sfb.sfb08 - l_woqty  #MOD-A50016 mark
                #LET g_sfb.sfb08 = l_qty - l_woqty        #MOD-A50016        #CHI-B80044 mark
                 LET g_sfb.sfb08 = l_allowqty             #CHI-B80044
                 IF g_sfb.sfb02 NOT MATCHES '[58]' THEN      #MOD-B60227 add
                   #str MOD-A50195 add
                    IF g_sfb.sfb08 = 0 THEN
                       IF l_code = 'Y' THEN
                          CALL cl_err('','asf-005',1)
                       ELSE
                          CALL cl_err('','asf-011',1)
                       END IF
                       NEXT FIELD sfb221
                    END IF
                   #end MOD-A50195 add
                 END IF                                       #MOD-B60227 add
              END IF
           END IF
           DISPLAY BY NAME g_sfb.sfb08

           #add by wy20160113 begin
           SELECT tc_sfb09 INTO l_tc_sfb09 FROM tc_sfb_file WHERE tc_sfb01=0
           #FBZ的预计完工日
           IF g_sfb.sfb01[1,3]='FBZ'   THEN
             IF l_oeb15-g_sfb.sfb81>=0 AND l_oeb15-g_sfb.sfb81<=45 THEN  #45天以内订单，完工日提前3天
                LET g_sfb.sfb15=l_oeb15-3
             END IF
             IF l_oeb15-g_sfb.sfb81>45 AND l_oeb15-g_sfb.sfb81<=60 THEN  #45-60天订单，完工日提前7天
                LET g_sfb.sfb15=l_oeb15-7
             END IF
             IF l_oeb15-g_sfb.sfb81>60 THEN                              #60天以上订单，完工日提前10天
                LET g_sfb.sfb15=l_oeb15-10
             END IF

             #FBZ的预计开工日
             LET g_sfb.sfb13=g_sfb.sfb15+l_tc_sfb09
             DISPLAY BY NAME g_sfb.sfb13
             DISPLAY BY NAME g_sfb.sfb15
           END IF
           #add by wy20160113 end

           IF g_sfb.sfb221 != g_sfb_t.sfb221 OR g_sfb_t.sfb221 IS NULL THEN
              LET g_sfb.sfb97 = NULL
              DISPLAY BY NAME g_sfb.sfb97
           END IF
           LET l_oeb908 = NULL
           LET l_sfb919 = NULL #MOD-C90005 add
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
             #SELECT oeb908 INTO l_oeb908 FROM oeb_file   #MOD-C90005 mark
              SELECT oeb908,oeb919 INTO l_oeb908,l_sfb919 FROM oeb_file   #MOD-C90005 add l_sfb919
               WHERE oeb01 = g_sfb.sfb22
                 AND oeb03 = g_sfb.sfb221
              IF NOT cl_null(l_oeb908) THEN
                 LET g_sfb.sfb97 = l_oeb908
                 DISPLAY BY NAME g_sfb.sfb97
              END IF
              #MOD-C90005 add begin--------------------
              IF NOT cl_null(l_sfb919) AND g_sma.sma1421 = 'Y' THEN
                 LET g_sfb.sfb919 = l_sfb919
                 DISPLAY BY NAME g_sfb.sfb919
              END IF
              #MOD-C90005 add end----------------------
           END IF
           CALL i301_carry_proj() #FUN-810045
           CALL i301_set_entry(p_cmd)  #FUN-810045
           CALL i301_set_no_entry(p_cmd) #FUN-810045
#--TQC-D10024--add--end--
        AFTER FIELD sfb221
           IF pja_flag!='1' AND NOT cl_null(g_sfb.sfb22)   #FUN-810045 gja->pja
                            AND g_sfb.sfb22[1,g_doc_len]<>'MRP'     #No.FUN-550067
                            AND cl_null(g_sfb.sfb221) THEN
              NEXT FIELD sfb221
           END IF
           IF NOT cl_null(g_sfb.sfb221) THEN
              LET l_code = 'Y'    #MOD-A50195 add
             #str MOD-A40133 add
              #先檢查此訂單編號+項次是否存在訂單檔裡,若是才做asf-005的檢核
              LET g_cnt = 0
              SELECT COUNT(*) INTO g_cnt FROM oea_file,oeb_file
               WHERE oea01=oeb01
                 AND oeb01=g_sfb.sfb22
                 AND oeb03=g_sfb.sfb221
              IF cl_null(g_cnt) THEN LET g_cnt=0 END IF
              IF g_cnt > 0 THEN
             #end MOD-A40133 add
                 #參考q_oea3的sql
                 SELECT COUNT(*) INTO g_cnt
                   FROM oea_file,oeb_file
                  WHERE oeb70 = 'N'
                    AND oea00 <> '0' AND oea00 <> '4'
                    AND oeaconf = 'Y'                             #MOD-990075 add
                    AND oea01=oeb01
                    AND oeb01=g_sfb.sfb22
                    AND oeb03=g_sfb.sfb221
                 IF g_cnt=0 THEN
                    CALL cl_err('','asf-005',1)
                    NEXT FIELD sfb221
                 END IF
                 #上面判斷是判斷訂單是否存在，
                 #下面判斷是判斷定單存在但是否還有多餘量可轉工單
                 SELECT COUNT(*) INTO g_cnt
                   FROM oea_file,oeb_file
                  WHERE oeb70 = 'N'
                    AND oea00 <> '0' AND oea00 <> '4'
                    AND oeb12>(oeb24-oeb25) AND oeaconf = 'Y'
                    AND oea01=oeb01
                    AND oeb01=g_sfb.sfb22
                    AND oeb03=g_sfb.sfb221
                 IF g_cnt=0 THEN
                    IF g_sfb.sfb02 NOT MATCHES '[58]' THEN
                       CALL cl_err('','asf-005',1)
                       NEXT FIELD sfb221
                    END IF
                 END IF
              END IF   #MOD-A40133 add
              IF NOT cl_null(g_sfb.sfb22) THEN  #MOD-D50082
                 #SELECT oeb04,(oeb12-oeb905-oeb24+oeb25),oeb22,oeb05,ima55,((100+ima562)/100),oeb41,oeb42,oeb43,oeb1001  #bugno:6105 add oeb05,ima55 #No.MOD-530808 add ima562   #FUN-570103  #No.MOD-790028 modify  #FUN-810045 add oeb41/42/43/1001 #TQC-C50186 add (-oeb24+oeb25) #MOD-D10066
                 SELECT oeb04,oeb12+NVL(oebud07,0),oeb22,oeb05,ima55,((100+ima562)/100),oeb41,oeb42,oeb43,oeb1001  #MOD-D10066   #add +NVL(oebud07,0) by lanhang 131010
                        ,oeb15,oeb72 ,oeb15         #CHI-910028 add  #MOD-D50191 add oeb72 #add oeb15 by wy20160113
                   INTO l_part,l_qty,l_ver,l_oeb05,l_ima55,l_ima562,      # #No: MOD-530808
                        l_oeb41,l_oeb42,l_oeb43,l_oeb1001    #FUN-810045 add
                        ,l_date,l_oeb72 ,l_oeb15   #CHI-910028 add   #MOD-D50191 add l_oeb72 #add oeb15 by wy20160113
                   FROM oeb_file LEFT OUTER JOIN ima_file ON oeb04=ima_file.ima01
                  WHERE oeb01=g_sfb.sfb22 AND oeb03=g_sfb.sfb221
                    AND oeb70='N'  #bugno:5512 add......
                 IF STATUS THEN
                    LET l_date = NULL   #MOD-A40160 add
                    LET l_code = 'N'    #MOD-A50195 add
                    SELECT msb03,(msb05*ima55_fac) #CHI-910028 mark ,msb04
                      INTO l_part,l_qty   #CHI-910028 mark ,l_date
                      FROM msb_file LEFT OUTER JOIN ima_file ON msb03=ima01,msa_file
                     WHERE msb01=g_sfb.sfb22 AND msb02=g_sfb.sfb221
                       AND msb01=msa01 AND msa03 = 'N'
                       AND msa05<>'X'  #CHI-C80041
                    IF STATUS THEN
                       CALL cl_err3("sel","msb_file",g_sfb.sfb22,g_sfb.sfb221,100,"","sel oea/msb",1)  #No.FUN-660128
                       NEXT FIELD sfb221
                    END IF
                 END IF

                 LET l_sfb221 = g_sfb.sfb221 USING '#####'                       #add by lanhang 130925
                 LET g_sfb.sfbud02 = g_sfb.sfb22 CLIPPED,'_',l_sfb221.trim()     #add by lanhang 130925
                 DISPLAY BY NAME g_sfb.sfbud02                                   #add by lanhang 130925
                 #CHI-B80044 -- begin --
                 IF g_sfb.sfb02 != '15' THEN   #非試產性工單
                    SELECT * INTO g_ima.* FROM ima_file WHERE ima01 = l_part
                 END IF
                 #CHI-B80044 -- end --
                 IF l_qty IS NULL THEN LET l_qty=0 END IF
                 CALL s_umfchk(l_part,l_oeb05,l_ima55) RETURNING g_cnt,l_factor
                 IF g_cnt = 1 THEN LET l_factor=1 END IF
                 IF cl_null(l_ima562) THEN LET l_ima562 = 1 END IF   #no.MOD-7A0181
                 LET l_qty=l_qty*l_factor*l_ima562     # #No: MOD-530808
                 LET g_sfb.sfb05 = l_part
                 LET g_sfb.sfb071 = l_oeb72  #MOD-D50191 add
                 IF g_sfb.sfb08=0 OR g_sfb.sfb08 IS NULL THEN
                   #str MOD-A50195 add
                    LET l_woqty = 0
                    SELECT SUM(sfb08) INTO l_woqty
                      FROM sfb_file
                     WHERE sfb22 = g_sfb.sfb22 AND sfb221 = g_sfb.sfb221
                      #AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 = sfb09))     #MOD-D20110  mark
                       AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 <= sfb09))    #MOD-D20110
                       AND  sfb01 <> g_sfb.sfb01
                       AND sfb02 !='5' AND sfb02 !='8'     #No:MOD-740060 add
                       AND sfb87 !='X'    #bugno:5512
                    IF SQLCA.sqlcode OR cl_null(l_woqty) THEN
                       LET l_woqty = 0
                    END IF
                   #end MOD-A50195 add
                   #LET g_sfb.sfb08 = l_qty             #MOD-A50195 mark
                   #LET g_sfb.sfb08 = l_qty - l_woqty   #MOD-A50195        #CHI-B80044 mark
                    #MOD-D50082 mark begin--------------------
                    ##CHI-B80044 -- begin --
                    #LET l_oebqty = l_qty
                    #LET l_availqty = l_qty - l_woqty
                    #IF l_availqty < 0 THEN
                    #   LET l_availqty = 0
                    #END IF
                    #LET l_allowqty = l_availqty    #MOD-CC0117 move
                    #IF NOT cl_null(g_ima.ima56) AND g_ima.ima56 > 0 THEN
                    #   LET l_calc = 0
                    #  #LET l_allowqty = l_availqty #MOD-CC0117 mark
                    #   IF l_oebqty MOD g_ima.ima56 > 0 THEN
                    #      LET l_calc = l_qty/g_ima.ima56 +1
                    #      LET l_oebqty = l_calc * g_ima.ima56
                    #   END IF
                    #   IF l_availqty MOD g_ima.ima56 > 0 THEN
                    #      LET l_calc = l_availqty/g_ima.ima56 + 1
                    #      LET l_allowqty = l_calc * g_ima.ima56
                    #   END IF
                    #END IF
                    #LET g_sfb.sfb08 = l_allowqty
                    ##CHI-B80044 -- end --
                    #MOD-D50082 mark end-----------------------
                 END IF
                 LET g_sfb.sfb07 = l_ver
                 DISPLAY BY NAME g_sfb.sfb07      #MOD-B40106 add
                 DISPLAY BY NAME g_sfb.sfb05,g_sfb.sfb08
                 DISPLAY BY NAME g_sfb.sfb071     #MOD-D50191 add
                 IF NOT cl_null(l_date) THEN      #MOD-A40160 add
                    LET g_sfb.sfb15 = l_date      #NO.MOD-7A0181
                    DISPLAY BY NAME g_sfb.sfb15   #NO.MOD-7A0181
                 END IF                           #MOD-A40160 add
                 LET l_sfb08_t = g_sfb.sfb08      #NO.MOD-7A0181
                 CALL i300_time('2')              #NO.MOD-7A0181
                 IF g_sfb.sfb13 < g_sfb.sfb81 THEN
                    LET g_sfb.sfb13 = g_sfb.sfb81
                 END IF
                 IF g_sfb.sfb13 > g_sfb.sfb15 THEN
                    LET g_sfb.sfb15 = g_sfb.sfb13
                    DISPLAY BY NAME g_sfb.sfb15
                 END IF
                 DISPLAY BY NAME g_sfb.sfb13      #NO.MOD-7A0181
                 LET g_sfb.sfb27 = l_oeb41   #專案
                 LET g_sfb.sfb271= l_oeb42   #WBS
                 LET g_sfb.sfb50 = l_oeb43   #活動
                 LET g_sfb.sfb51 = l_oeb1001 #費用原因
                 DISPLAY BY NAME g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51
              END IF  #MOD-D50082 add
           END IF
           ###### check是否應開立工單
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
              LET l_woqty = ''
              IF cl_null(g_sfb.sfb01) THEN
                 LET g_sfb.sfb01=' '
              END IF
              SELECT SUM(sfb08) INTO l_woqty
                FROM sfb_file
               WHERE sfb22 = g_sfb.sfb22 AND sfb221 = g_sfb.sfb221
                #AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 = sfb09))     #MOD-D20110  mark
                 AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 <= sfb09))    #MOD-D20110
                 AND  sfb01 <> g_sfb.sfb01
                 AND sfb02 !='5' AND sfb02 !='8'     #No.MOD-740060 add
                 AND sfb87 !='X'    #bugno:5512
              IF SQLCA.sqlcode OR cl_null(l_woqty) THEN
                 LET l_woqty = 0
              END IF
              #MOD-D50082 add begin-----------
              LET l_oebqty = l_qty
              LET l_availqty = l_qty - l_woqty
              IF l_availqty < 0 THEN
                 LET l_availqty = 0
              END IF
              LET l_allowqty = l_availqty
              IF NOT cl_null(g_ima.ima56) AND g_ima.ima56 > 0 THEN
                 LET l_calc = 0
                 IF l_oebqty MOD g_ima.ima56 > 0 THEN
                    LET l_calc = l_qty/g_ima.ima56 +1
                    LET l_oebqty = l_calc * g_ima.ima56
                 END IF
                 IF l_availqty MOD g_ima.ima56 > 0 THEN
                    LET l_calc = l_availqty/g_ima.ima56 + 1
                    LET l_allowqty = l_calc * g_ima.ima56
                 END IF
              END IF
              LET g_sfb.sfb08 = l_allowqty
             #MOD-D50082 add end-------------
             #IF l_woqty>= g_sfb.sfb08 THEN               #MOD-A50016 mark
             #IF l_woqty + g_sfb.sfb08 > l_qty THEN       #MOD-A50016        #CHI-B80044 mark
              IF l_woqty + g_sfb.sfb08 > l_oebqty THEN    #CHI-B80044
                 IF g_sfb.sfb02 NOT MATCHES '[58]' THEN    #MOD-740060 add
                    CALL cl_err('','asf-001',0)
                    NEXT FIELD sfb221    #No.MOD-8A0242 add
                 END IF                        #MOD-740060 add
              ELSE
                #LET g_sfb.sfb08 = g_sfb.sfb08 - l_woqty  #MOD-A50016 mark
                #LET g_sfb.sfb08 = l_qty - l_woqty        #MOD-A50016        #CHI-B80044 mark
                 LET g_sfb.sfb08 = l_allowqty             #CHI-B80044
                 IF g_sfb.sfb02 NOT MATCHES '[58]' THEN      #MOD-B60227 add
                   #str MOD-A50195 add
                    IF g_sfb.sfb08 = 0 THEN
                       IF l_code = 'Y' THEN
                          CALL cl_err('','asf-005',1)
                       ELSE
                          CALL cl_err('','asf-011',1)
                       END IF
                       NEXT FIELD sfb221
                    END IF
                   #end MOD-A50195 add
                 END IF                                       #MOD-B60227 add
              END IF
           END IF
           DISPLAY BY NAME g_sfb.sfb08
           #add by wy20160113 begin
           SELECT tc_sfb09 INTO l_tc_sfb09 FROM tc_sfb_file WHERE tc_sfb01=0
           #FBZ的预计完工日
           IF g_sfb.sfb01[1,3]='FBZ'   THEN
             IF l_oeb15-g_sfb.sfb81>=0 AND l_oeb15-g_sfb.sfb81<=45 THEN  #45天以内订单，完工日提前3天
                LET g_sfb.sfb15=l_oeb15-3
             END IF
             IF l_oeb15-g_sfb.sfb81>45 AND l_oeb15-g_sfb.sfb81<=60 THEN  #45-60天订单，完工日提前7天
                LET g_sfb.sfb15=l_oeb15-7
             END IF
             IF l_oeb15-g_sfb.sfb81>60 THEN                              #60天以上订单，完工日提前10天
                LET g_sfb.sfb15=l_oeb15-10
             END IF

             #FBZ的预计开工日
             LET g_sfb.sfb13=g_sfb.sfb15+l_tc_sfb09
             DISPLAY BY NAME g_sfb.sfb13
             DISPLAY BY NAME g_sfb.sfb15
           END IF
           #add by wy20160113 end
           IF g_sfb.sfb221 != g_sfb_t.sfb221 OR g_sfb_t.sfb221 IS NULL THEN
              LET g_sfb.sfb97 = NULL
              DISPLAY BY NAME g_sfb.sfb97
           END IF
           LET l_oeb908 = NULL
           LET l_sfb919 = NULL #MOD-C90005 add
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
             #SELECT oeb908 INTO l_oeb908 FROM oeb_file   #MOD-C90005 mark
              SELECT oeb908,oeb919 INTO l_oeb908,l_sfb919 FROM oeb_file   #MOD-C90005 add l_sfb919
               WHERE oeb01 = g_sfb.sfb22
                 AND oeb03 = g_sfb.sfb221
              IF NOT cl_null(l_oeb908) THEN
                 LET g_sfb.sfb97 = l_oeb908
                 DISPLAY BY NAME g_sfb.sfb97
              END IF
              #MOD-C90005 add begin--------------------
              IF NOT cl_null(l_sfb919) AND g_sma.sma1421 = 'Y' THEN
                 LET g_sfb.sfb919 = l_sfb919
                 DISPLAY BY NAME g_sfb.sfb919
              END IF
              #MOD-C90005 add end----------------------
           END IF
           CALL i301_carry_proj() #FUN-810045
           CALL i301_set_entry(p_cmd)  #FUN-810045
           CALL i301_set_no_entry(p_cmd) #FUN-810045

        BEFORE FIELD sfb05
          CALL i301_set_entry(p_cmd)

        AFTER FIELD sfb05
            IF NOT cl_null(g_sfb.sfb05) THEN
#FUN-AA0059 ---------------------start----------------------------
            IF g_sfb.sfb02 <> 15 THEN                                       #FUN-AB0025  add
               IF NOT s_chk_item_no(g_sfb.sfb05,"") THEN
                  CALL cl_err('',g_errno,1)
                  LET g_sfb.sfb05= g_sfb_t.sfb05
                  NEXT FIELD sfb05
               END IF
               #FUN-C30047---begin
               LET l_ima928 = 'N'
               SELECT ima928 INTO l_ima928 FROM ima_file
                WHERE ima01 = g_sfb.sfb05
               IF l_ima928 = 'Y' THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt FROM bmm_file
                   WHERE bmm01 = g_sfb.sfb05
                     AND bmm05 = 'Y'
                  IF l_cnt = 0 THEN
                     CALL cl_err('','ima-001',1)
                     LET g_sfb.sfb05= g_sfb_t.sfb05
                     NEXT FIELD sfb05
                  END IF
               END IF
               #FUN-C30047---end
            END IF                                                          #FUN-AB0025
#FUN-AA0059 ---------------------end-------------------------------
               IF NOT s_chkima08(g_sfb.sfb05) THEN
                  NEXT FIELD CURRENT
               END IF
            #--No.MOD-570203 add 判斷料件是否為(Phase Out)
               SELECT ima140,ima1401,ima910 INTO l_ima140,l_ima1401,l_ima910 FROM ima_file #FUN-6A0036 add ima1401  #MOD-860072 add ima910
                   WHERE ima01=g_sfb.sfb05
               IF l_ima140 = 'Y' AND l_ima1401 <= g_sfb.sfb81 THEN  #FUN-6A0036
                  CALL cl_err('','asf-960',1)
                  NEXT FIELD sfb05
               END IF
               #MOD-A90097 add --start--
               IF g_sfb.sfb05 MATCHES 'MISC*' THEN
                  CALL cl_err('','asf-306',1)
                  NEXT FIELD sfb05
               END IF
               #MOD-A90097 add --end--
             IF p_cmd='a' OR g_sfb_t.sfb05 IS NULL OR
               (p_cmd='u' AND g_sfb.sfb05 != g_sfb_t.sfb05) THEN
              IF g_sma.sma118 ='Y' THEN
                 LET g_sfb.sfb95 = l_ima910
              END IF
             END IF
            #str MOD-A70142 mod
            #IF NOT cl_null(l_part) AND l_part <> g_sfb.sfb05 THEN
            #   CALL cl_err('','asf-099',1)
            #   NEXT FIELD sfb05
            #END IF
             IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
                LET l_part = ''
                SELECT oeb04 INTO l_part FROM oeb_file
                 WHERE oeb01=g_sfb.sfb22 AND oeb03=g_sfb.sfb221
                IF STATUS THEN
                   SELECT msb03 INTO l_part FROM msb_file
                    WHERE msb01=g_sfb.sfb22 AND msb02=g_sfb.sfb221
                END IF
                IF NOT cl_null(l_part) AND l_part <> g_sfb.sfb05 THEN
                   CALL cl_err('','asf-099',1)
                   NEXT FIELD sfb05
                END IF
             END IF
             IF NOT cl_null(g_sfb.sfb91) AND NOT cl_null(g_sfb.sfb92) THEN
                LET l_part = ''
                SELECT ksg03 INTO l_part FROM ksg_file
                 WHERE ksg01=g_sfb.sfb91 AND ksg02=g_sfb.sfb92
                IF NOT cl_null(l_part) AND l_part <> g_sfb.sfb05 THEN
                   CALL cl_err('','asf-141',1)
                   NEXT FIELD sfb05
                END IF
             END IF
            #end MOD-A70142 mod
             IF g_sfb.sfb02 != '15' THEN     #No.MOD-840306 add
                SELECT ima1010 INTO l_ima1010 FROM ima_file
                 WHERE ima01 = g_sfb.sfb05
                IF l_ima1010 <> '1' THEN
                   CALL cl_err('','atm-380',1)
                   NEXT FIELD sfb05
                END IF
             END IF                          #No.MOD-840306 add
             CALL i301_pmh05()
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_sfb.sfb82,g_errno,1)
                NEXT FIELD sfb05
             END IF

             SELECT COUNT(*) INTO g_cnt FROM ima_file
              WHERE ima01=g_sfb.sfb05
                AND ima911='Y'
             IF g_cnt>0 THEN
                CALL cl_err('','asr-040',1)
                NEXT FIELD sfb05
             END IF
             IF g_sfb.sfb02 != '15' THEN   #非試產性工單
                SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_sfb.sfb05
                IF STATUS THEN
                   CALL cl_err3("sel","ima_file",g_sfb.sfb05,"",STATUS,"","sel ima",1)  #No.FUN-660128
                      NEXT FIELD sfb05

                END IF
              #除了拆件式工單、重工工單、委外式重工工單外，主件來源碼不可 P part
               IF NOT (g_sfb.sfb02='5' OR g_sfb.sfb02='8' OR g_sfb.sfb02='11') THEN
                 LET l_ima08 = ''
                 SELECT ima08 INTO l_ima08 FROM ima_file
                  WHERE ima01 = g_sfb.sfb05
                 IF l_ima08 = 'P' THEN  #不可為 P
                   CALL cl_err('','asf-208',0)
                   NEXT FIELD sfb05
                 END IF
               END IF
               #add by lanhang 131010 begin
               SELECT bmaud01,bmaud02,bmaud03,bmaud04,bmaud05,bmaud06,bmaud07
                 INTO g_sfb.sfbud01,g_sfb.sfbud03,g_sfb.sfbud04,g_sfb.sfbud05,
                      g_sfb.sfbud06,g_sfb.sfbud08,g_sfb.sfbud07
                 FROM bma_file
                WHERE bma01=g_sfb.sfb05 AND bmaacti='Y'
                  AND bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81
               DISPLAY BY NAME  g_sfb.sfbud01,g_sfb.sfbud03,g_sfb.sfbud04,
                                g_sfb.sfbud05,g_sfb.sfbud06,g_sfb.sfbud08,g_sfb.sfbud07
               #add by lanhang 131010 end
               #No.B474 010507 by plum add 若此BOM尚未發放,不可用
               #FUN-A50066--begin--mark----------------
               # SELECT COUNT(*) INTO g_cnt FROM bma_file
               #    WHERE bma01=g_sfb.sfb05 AND bmaacti='Y'
               #   IF g_cnt >0 THEN
               #    SELECT COUNT(*) INTO g_cnt FROM bma_file
               #    WHERE bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81
               #      AND bma01=g_sfb.sfb05
               #     #AND bma06 = l_ima910   #FUN-550112    #No.MOD-640245 mark
               #   IF g_cnt =0 THEN
               #      CALL cl_err(g_sfb.sfb81,'abm-006',0)
               #      NEXT FIELD sfb05
               #   END IF
               #FUN-A50066--end--mark------------
               # ELSE
               #   IF NOT (g_sfb.sfb02='5' OR g_sfb.sfb02='8'
               #           OR g_sfb.sfb02='11') THEN  #CHI-6A0028--add
               #    CALL cl_err(g_sfb.sfb05,'abm-742',0)
               #    NEXT FIELD sfb05
               #   END IF     #CHI-6A0028 add
               # END IF
               #FUN-A50066--end--mark----------------
             END IF
             IF g_sfb.sfb02 = '15' THEN
                LET l_n = 0
                SELECT COUNT(ima01) INTO l_n FROM ima_file
                 WHERE ima01 = g_sfb.sfb05
                IF l_n = 0 THEN
                   SELECT bmq02,bmq021,bmq55,bmq05 INTO g_ima.ima02,g_ima.ima021,g_ima.ima55,g_ima.ima05 #TQC-A80169 add bmq05
                     FROM bmq_file
                    WHERE bmq01 = g_sfb.sfb05
                ELSE
                   SELECT ima02,ima021,ima55,ima05 INTO g_ima.ima02,g_ima.ima021,g_ima.ima55,g_ima.ima05 #TQC-A80169 add bmq05
                     FROM ima_file
                    WHERE ima01 = g_sfb.sfb05
                END IF
             END IF
             DISPLAY BY NAME g_ima.ima02,g_ima.ima55
             DISPLAY BY NAME g_ima.ima021
             IF cl_null(g_sfb.sfb07) THEN      #MOD-B40106 add
               LET g_sfb.sfb07=g_ima.ima05 #TQC-A80169
               DISPLAY BY NAME g_sfb.sfb07 #TQC-A80169
             END IF                            #MOD-B40106 add
             IF g_sfb.sfb06 IS NULL AND g_sfb.sfb93='Y' THEN #No:7254
                IF g_sfb.sfb02 NOT MATCHES '[78]' THEN    #NO:7075
                   LET g_sfb.sfb06=g_ima.ima94
                   DISPLAY BY NAME g_sfb.sfb06
                END IF
             END IF
             #CHI-B80053 -- begin --
             IF cl_null(g_sfb.sfb98) THEN
                LET g_sfb.sfb98 = g_ima.ima34
                DISPLAY BY NAME g_sfb.sfb98
             END IF
             #CHI-B80053 -- end --

             #若修改料號時詢問是否自動計算完工日期
               IF NOT cl_null(l_sfb05_t) AND g_sfb.sfb05 != l_sfb05_t THEN
                  IF cl_confirm("asf-980") THEN
                     CALL i300_time('1')
                  END IF
               END IF
               #DEV-D30037--mrak--begin
               ##No:DEV-CB0005--add--begin
               #CALL t301_chk_smyb(g_sfb.sfb05)
               # IF NOT cl_null(g_errno) THEN
               #    CALL cl_err(g_sfb.sfb05,g_errno,0)
               #    NEXT FIELD sfb01
               # END IF
               ##No:DEV-CB0005--add--end
               #DEV-D30037--mrak--end
            END IF
            LET l_sfb05_t = g_sfb.sfb05
            DISPLAY BY NAME g_sfb.sfb13
            DISPLAY BY NAME g_sfb.sfb15
           CALL i301_set_no_entry(p_cmd)



        AFTER FIELD sfb08
            IF NOT cl_null(g_sfb.sfb08) THEN
               IF g_sfb.sfb08=0 THEN NEXT FIELD sfb08 END IF
               IF g_sfb.sfb08<g_sfb.sfb081 THEN NEXT FIELD sfb05 END IF
# No:2422  modify 1998/09/08 ---------(check 最小生產數量) ---
               IF g_ima.ima561 > 0 THEN #生產單位批量&最少生產數量
                  IF g_sfb.sfb08<g_ima.ima561 THEN
                     CALL cl_err(g_ima.ima561,'asf-307',0)
                     NEXT FIELD sfb08
                  END IF
               END IF
               IF NOT cl_null(g_ima.ima56) AND g_ima.ima56>0  THEN #生產單位批量
                  LET l_qty1 = g_sfb.sfb08 * 1000
                  LET l_qty2 = g_ima.ima56 * 1000
                  IF (l_qty1 MOD l_qty2) > 0 THEN
                     CALL cl_err(g_ima.ima56,'asf-308',0)
                     NEXT FIELD sfb08
                  END IF
               END IF
               ###### 當此工單為訂單式生產時,check是否數量大於訂單
               IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
                  LET l_code = 'Y'    #bugno:9731 add
              #判斷來源若為MRP時不做check
               IF g_sfb.sfb22[1,3] != 'MRP' THEN
                   LET l_flag = 'N'               #MOD-970068 add
                   SELECT oeb12,oebud07,oeb05,oeb15,ima55,((ima562+100)/100) INTO l_oeb12,l_oebud07,l_oeb05,    #No.MOD-790028 modify   #add oebud07 by lanhang 131010
                       l_oeb15,l_ima55,l_ima562
                       FROM oeb_file LEFT OUTER JOIN ima_file ON oeb04=ima_file.ima01
                      WHERE oeb01 = g_sfb.sfb22 AND oeb03 = g_sfb.sfb221
                        AND oeb70 = 'N'
                    IF SQLCA.sqlcode OR cl_null(l_oeb12) THEN
                       LET l_flag = 'Y'
                    END IF
                    IF l_oeb12 IS NULL THEN LET l_oeb12=0 END IF
                    IF l_oebud07 IS NULL THEN LET l_oebud07=0 END IF
                    CALL s_umfchk(l_part,l_oeb05,l_ima55) RETURNING g_cnt,l_factor
                    IF g_cnt = 1 THEN LET l_factor=1 END IF
                     #LET l_oeb12=l_oeb12*l_factor*l_ima562     # MOD-530808
                     LET l_oeb12=(l_oeb12+l_oebud07)*l_factor*l_ima562     # MOD-530808 #mod by lanhang 131010
                     IF l_flag = 'Y' THEN
                        LET l_code = 'N'
                        SELECT msb04,msb05*ima55_fac INTO l_msb04,l_oeb12    #no.MOD-7A0181
                          FROM msb_file LEFT OUTER JOIN ima_file ON msb03=ima01,msa_file   #7315 modify
                         WHERE msb01=g_sfb.sfb22 AND msb02=g_sfb.sfb221
                           AND msb01=msa01 AND msa03 = 'N'
                           AND msa05<>'X'  #CHI-C80041
                        IF STATUS THEN LET l_oeb12 = 0 END IF
                     END IF
                     IF cl_null(g_sfb.sfb01) THEN
                        LET g_sfb.sfb01=' '
                     END IF
                     SELECT SUM(sfb08) INTO l_woqty
                       FROM sfb_file
                      WHERE sfb22 = g_sfb.sfb22 AND sfb221 = g_sfb.sfb221
                       #AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 = sfb09))     #MOD-D20110  mark
                        AND (sfb04 <> '8' OR (sfb04 = '8' AND sfb08 <= sfb09))    #MOD-D20110
                        AND sfb02 !='5' AND sfb02 !='8'     #No.MOD-740060 add
                        AND sfb01 <> g_sfb.sfb01
                        AND sfb87 !='X'                   #MOD-A60073 add
                     IF SQLCA.sqlcode OR cl_null(l_woqty) THEN
                        LET l_woqty = 0
                     END IF
                     #CHI-B80044 -- begin --
                     LET l_availqty = l_oeb12 - l_woqty
                     IF l_availqty > 0 THEN
                        IF NOT cl_null(g_ima.ima56) AND g_ima.ima56 > 0 THEN
                           LET l_calc = 0
                           LET l_allowqty = g_sfb.sfb08
                           IF l_availqty MOD g_ima.ima56 > 0 THEN
                              LET l_calc = l_availqty/g_ima.ima56 + 1
                              LET l_allowqty = l_calc * g_ima.ima56
                           END IF
                           IF g_sfb.sfb08 > l_allowqty THEN
                              CALL cl_err('','asf-358',1)
                              NEXT FIELD sfb08
                           END IF
                        END IF
                     END IF
                     #CHI-B80044 -- end --
                     IF (l_woqty+g_sfb.sfb08) > l_oeb12 THEN
                        IF g_sfb.sfb02 NOT MATCHES '[58]' THEN   #MOD-740060 add
                           IF l_code = 'Y' THEN
                             #CALL cl_err('','asf-005',1)     #CHI-B80044 mark
                             #NEXT FIELD sfb08  #MOD-860055   #CHI-B80044 mark
                              CALL cl_err('','asf-005',0)     #CHI-B80044
                           ELSE
                             #CALL cl_err('','asf-011',1)     #CHI-B80044 mark
                             #NEXT FIELD sfb08  #MOD-860055   #CHI-B80044 mark
                              CALL cl_err('','asf-011',0)     #CHI-B80044
                           END IF
                        END IF                     #MOD-740060 add
                     END IF
                      #CHI-B80044 -- begin --
                     IF NOT cl_null(g_errno) THEN
                        CALL cl_err('',g_errno,0)
                        IF cl_null(g_ima.ima56) OR g_ima.ima56 = 0 THEN
                           NEXT FIELD sfb08
                        END IF
                     END IF
                    #CHI-B80044 -- end --
                  #--#No.MOD-570203 由預計完工日反推預計開工日
                     #若為MPS單或訂單轉工單時
                     IF l_code ='N' THEN
                        LET g_sfb.sfb15 = l_msb04
                     ELSE
                        LET g_sfb.sfb15 = l_oeb15
                     END IF
                     #若修改數量時詢問是否自動計算完工日期
                       IF NOT cl_null(l_sfb08_t) AND g_sfb.sfb08 != l_sfb08_t THEN
                          IF cl_confirm("asf-982") THEN
                             CALL i300_time('2')
                          END IF
                       ELSE
                          #若是一開始新增的話不詢問而自動計算
                          IF cl_null(l_sfb08_t) THEN
                             CALL i300_time('2')
                          END IF
                       END IF
              END IF        #No.MOD-640197 add
                  IF  g_sfb.sfb13 < g_sfb.sfb81 THEN
                      LET g_sfb.sfb13 = g_sfb.sfb81
                  END IF
                  IF g_sfb.sfb13 > g_sfb.sfb15 THEN
                     LET g_sfb.sfb15 = g_sfb.sfb13
                  END IF
               ELSE
                  #若非MPS單或訂單轉工單的況
                 #------------No.MOD-680077 add
                 #若修改數量時詢問是否自動計算完工日期
                   IF NOT cl_null(l_sfb08_t) AND g_sfb.sfb08 != l_sfb08_t THEN
                      IF cl_confirm("asf-981") THEN
                         CALL i300_time('1')
                      END IF
                   ELSE
                      #若是一開始新增的話不詢問而自動計算
                      IF cl_null(l_sfb08_t) THEN
                         CALL i300_time('1')
                      END IF
                   END IF
               END IF
            END IF
            LET l_sfb08_t = g_sfb.sfb08   #No.MOD-680077 add
            LET l_sfb13_t = g_sfb.sfb13   #No.MOD-680077 add
            DISPLAY BY NAME g_sfb.sfb13
            DISPLAY BY NAME g_sfb.sfb15
            LET l_sfb15_t = g_sfb.sfb15   #no.MOD-7A0181


        AFTER FIELD sfb07

            IF NOT cl_null(g_sfb.sfb07) THEN
               IF g_sfb.sfb02 = '15' THEN
                 #檢查是否存在 E-BOM中
                  SELECT bmq910 INTO l_bmq910 FROM bmq_file
                   WHERE bmq01 = g_sfb.sfb05
                  IF l_bmq910 IS NULL THEN
                      LET l_bmq910 = ' '
                  END IF
                  SELECT COUNT(*) INTO g_cnt FROM bmo_file,bmp_file
                   WHERE bmo01 =g_sfb.sfb05
                     AND bmo011=g_sfb.sfb07
                     AND bmo06 =l_bmq910 #FUN-560027 add
                     AND bmp01 =bmo01
                     AND bmo011=bmp011
                     AND bmo06 =bmp28    #FUN-560027 add
                     AND bmoacti = 'Y'   #No.MOD-840015 add
                  IF g_cnt = 0 THEN
                     CALL cl_err('','asf-903',0) NEXT FIELD sfb05
                  END IF
               ELSE  #非試產性工單
                  CALL s_version(g_sfb.sfb05,g_sfb.sfb07)
                  RETURNING g_bomdate,l_IneffectiveDate,g_cnt
                  IF g_cnt THEN
                     LET g_bomdate = '01/01/01'
                     LET l_IneffectiveDate = NULL
                     LET g_sfb.sfb071=g_today
                     CALL cl_err(g_sfb.sfb05,'asf-656',1)
                  ELSE
                     ERROR 'Effective Date:',g_bomdate,
                       ' InActive Date:',l_IneffectiveDate
                  END IF
                  IF cl_null(g_sfb.sfb071) THEN
                     LET g_sfb.sfb071=g_bomdate
                     DISPLAY BY NAME g_sfb.sfb071
                  END IF
               END IF
            END IF

#FUN-A50066--begin--mark---------------
#        AFTER FIELD sfb95
#           IF NOT cl_null(g_sfb.sfb95) THEN
#              SELECT COUNT(*) INTO g_cnt FROM bma_file
#               WHERE bma06 = g_sfb.sfb95
#                 AND bma01 = g_sfb.sfb05
#                 AND bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81  #MOD-640283 add
#              IF g_cnt = 0 THEN
#                 CALL cl_err(g_sfb.sfb95,"abm-618",0)
#                 NEXT FIELD sfb95
#              END IF
#           END IF
#FUN-A50066--end--mark--------------------

        BEFORE FIELD sfb071
            IF cl_null(g_sfb.sfb071) THEN
               LET g_sfb.sfb071=TODAY
               DISPLAY BY NAME g_sfb.sfb071
            END IF

        AFTER FIELD sfb071
            IF NOT cl_null(g_sfb.sfb071) THEN
              #No.B474 010507 by plum add 若此BOM尚未發放,不可用
              #FUN-A50066--begin--mark-----------
              # SELECT COUNT(*) INTO g_cnt FROM bma_file
              #  WHERE bma01=g_sfb.sfb05
              #    AND bma06 = g_sfb.sfb95   #No.MOD-640245 add
              # IF g_cnt >0 AND g_sfb.sfb02 !=15 THEN   #NO:7112 此判斷應剔除 '15'試產性工單
              #    SELECT COUNT(*) INTO g_cnt FROM bma_file
              #     WHERE bma05 IS NOT NULL AND bma05 <=g_sfb.sfb071
              #       AND bma01=g_sfb.sfb05
              #       AND bma06 = g_sfb.sfb95   #No.MOD-640245 add
              #    IF g_cnt =0 THEN
              #       CALL cl_err(g_sfb.sfb071,'abm-005',0)
              #       NEXT FIELD sfb071
              #    END IF
              # END IF
              #FUN-A50066--end--mark----------------
            END IF

        AFTER FIELD sfb06
            IF NOT cl_null(g_sfb.sfb06) THEN

               #使用製程(試產性工單不考慮製程)
               IF (g_sfb.sfb93='Y' AND g_sfb.sfb02!='15') THEN
                  IF p_cmd='a' OR g_sfb_t.sfb06 IS NULL OR
                    (p_cmd='u' AND g_sfb.sfb06 != g_sfb_t.sfb06) THEN
                     #以 ima571+sfb06 讀 ecu_file
                     SELECT ima571 INTO g_msg FROM ima_file
                      WHERE ima01=g_sfb.sfb05

                    #IF g_msg IS NULL THEN LET g_msg=' ' END IF # when ima571='' #MOD-B30465
                     IF cl_null(g_msg) THEN LET g_msg=g_sfb.sfb05 END IF         #MOD-B30465
                    #MOD-B30465--begin--mark-------
                    #SELECT DISTINCT ecu01 FROM ecu_file  #FUN-A50066
                    # WHERE ecu01=g_msg AND ecu02=g_sfb.sfb06
                    #IF STATUS THEN
                    #   SELECT DISTINCT ecu01 FROM ecu_file  #FUN-A50066
                    #    WHERE ecu01=g_sfb.sfb05
                    #      AND ecu02=g_sfb.sfb06
                    #   IF STATUS THEN
                    #      CALL cl_err3("sel","ecu_file",g_sfb.sfb05,g_sfb.sfb06,STATUS,"","sel ecu:",1)  #No.FUN-660128
                    #        NEXT FIELD sfb06
                    #   END IF
                    #END IF
                    #MOD-B30465--end--mark-------------
                    #MOD-B30465--begin--add--------
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM ecu_file WHERE ecu01=g_msg AND ecu02=g_sfb.sfb06
                        AND ecuacti = 'Y'  #CHI-C90006
                     IF l_cnt = 0 THEN CALL cl_err('','mfg4030',1) NEXT FIELD sfb06 END IF
                     LET l_cnt = 0
                     SELECT COUNT(*) INTO l_cnt FROM ecu_file
                      WHERE ecu01=g_msg AND ecu02=g_sfb.sfb06 AND ecu10='N'
                        AND ecuacti = 'Y'  #CHI-C90006
                     IF l_cnt > 0 THEN
                       CALL cl_err(g_msg,'mfg-064',1)
                       NEXT FIELD sfb06
                     END IF
                    #MOD-B30465--end--add----
                  END IF
               ELSE   ##不使用製程
                  LET g_sfb.sfb06=' '
                  DISPLAY BY NAME g_sfb.sfb06
               END IF
               IF NOT cl_null(g_sfb.sfb05) THEN
                  LET l_cnt = 0    #FUN-A50066
                  SELECT COUNT(*) INTO l_cnt #FUN-A50066 #MOD-AC0336  #MOD-B30465
                    FROM ecu_file
                   WHERE ecu01=g_sfb.sfb05
                     AND ecu02=g_sfb.sfb06
                    #AND ecu10 = 'Y'         #FUN-A50066 #MOD-AC0336
                     AND ecu10 = 'N'         #MOD-B30465
                     AND ecuacti = 'Y'  #CHI-C90006
                 #IF l_ecu10='N' THEN        #FUN-A50066 #MOD-AC0336 #MOD-B30465
                  IF l_cnt > 0  THEN         #MOD-B30465
                     CALL cl_err("","mfg-064",1)
                     NEXT FIELD sfb06
                  END IF
               END IF
            END IF
            CALL i301_set_required()

        AFTER FIELD sfb13
            IF NOT cl_null(g_sfb.sfb13) THEN
              #str MOD-A50142 add
               IF g_sfb.sfb13 < g_sfb.sfb81 THEN
                  #TQC-C80129--modify--str--
                  #LET g_sfb.sfb13 = g_sfb.sfb81
                  #DISPLAY BY NAME g_sfb.sfb13
                  CALL cl_err(g_sfb.sfb13,'asf-867',1)
                  NEXT FIELD sfb13
                  #TQC-C80129--modify--end--
               END IF
              #end MOD-A50142 add
               LET li_result = 0
               CALL s_daywk(g_sfb.sfb13) RETURNING li_result
               IF li_result = 0 THEN      #0:非工作日
                  CALL cl_err(g_sfb.sfb13,'mfg3152',1)
               END IF
               IF li_result = 2 THEN      #2:未設定
                  CALL cl_err(g_sfb.sfb13,'mfg3153',1)
               END IF
              #判斷是否由訂單或MPS轉工單
               IF cl_null(g_sfb.sfb22) AND cl_null(g_sfb.sfb221) THEN
                 #若修改預計開工日時詢問是否自動計算完工日期
                  IF NOT cl_null(l_sfb13_t) AND g_sfb.sfb13 != l_sfb13_t THEN
                     IF cl_confirm("asf-983") THEN
                        CALL i300_time('1')
                        LET l_sfb15_t = g_sfb.sfb15  #TQC-C80129 add
                     END IF
                  END IF
               END IF
               LET l_sfb13_t = g_sfb.sfb13
               DISPLAY BY NAME g_sfb.sfb13
               DISPLAY BY NAME g_sfb.sfb15

               IF cl_null(g_sfb.sfb15) THEN
                  LET l_sfb15=g_sfb.sfb13+(g_ima.ima59+g_ima.ima60/g_ima.ima601*g_sfb.sfb08+g_ima.ima61)  #No.FUN-840194 #CHI-810015 mark還原
                  SELECT COUNT(*) INTO l_time FROM sme_file
                     WHERE sme01 BETWEEN g_sfb.sfb13 AND l_sfb15  AND sme02 = 'N'
                  LET g_sfb.sfb15 =l_sfb15+l_time
                  DISPLAY BY NAME g_sfb.sfb15
               END IF
            END IF
            IF NOT cl_null(g_sfb.sfb15) THEN
               IF g_sfb.sfb13>g_sfb.sfb15 THEN
                  CALL cl_err('','asf-310',0)
                  LET g_sfb.sfb15=''
                  DISPLAY BY NAME g_sfb.sfb15
                  NEXT FIELD sfb13
               END IF
            END IF

        #FUN-9A0029--add----str----
        AFTER FIELD sfb14
              IF NOT cl_null(g_sfb.sfb14) THEN
                 LET g_h1=g_sfb.sfb14[1,2]
                 LET g_m1=g_sfb.sfb14[4,5]
                 IF cl_null(g_h1) OR cl_null(g_m1) OR g_h1<'00' OR g_h1>='24' OR g_m1<'00' OR g_m1>='60' THEN
                    #時間數值不在正確區間範圍內 !!
                    CALL cl_err(g_sfb.sfb14,'asf-807',1)
                    NEXT FIELD sfb14
                 END IF
             END IF
        AFTER FIELD sfb16
             IF NOT cl_null(g_sfb.sfb16) THEN
                 LET g_h1=g_sfb.sfb16[1,2]
                 LET g_m1=g_sfb.sfb16[4,5]
                 IF cl_null(g_h1) OR cl_null(g_m1) OR g_h1<'00' OR g_h1>='24' OR g_m1<'00' OR g_m1>='60' THEN
                    #時間數值不在正確區間範圍內 !!
                    CALL cl_err(g_sfb.sfb16,'asf-807',1)
                    NEXT FIELD sfb16
                 END IF
             END IF
        #FUN-9A0029--add----end----

        AFTER FIELD sfb15
           IF NOT cl_null(g_sfb.sfb15) THEN
              #TQC-C80129--add--str--
              IF g_sfb.sfb15 < g_sfb.sfb81 THEN
                 CALL cl_err(g_sfb.sfb15,'asf-868',1)
                 NEXT FIELD sfb15
              END IF
              #TQC-C80129--add--end--
              LET li_result = 0
              CALL s_daywk(g_sfb.sfb15) RETURNING li_result
              IF li_result = 0 THEN      #0:非工作日
                 CALL cl_err(g_sfb.sfb15,'mfg3152',1)
              END IF
              IF li_result = 2 THEN      #2:未設定
                 CALL cl_err(g_sfb.sfb15,'mfg3153',1)
              END IF
              IF cl_null(g_sfb.sfb13) THEN
                 IF g_sfb.sfb93<>'Y' THEN   #使用製程
                     LET g_sfb.sfb13=g_sfb.sfb15-                                #CHI-810015 mark還原
                               (g_ima.ima59+g_ima.ima60/g_ima.ima601*g_sfb.sfb08+g_ima.ima61)  #No.FUN-840194 #CHI-810015 mark還原
                    DISPLAY BY NAME g_sfb.sfb13
                 END IF
              END IF
           END IF

           #TQC-C80129--mark--str--  # 預設完再檢查開工日與完工日
           #IF NOT cl_null(g_sfb.sfb13) THEN
           #   IF g_sfb.sfb13>g_sfb.sfb15 THEN
           #      CALL cl_err('','asf-310',0)
           #      LET g_sfb.sfb15=''
           #      DISPLAY BY NAME g_sfb.sfb15
           #      NEXT FIELD sfb13
           #   END IF
           #END IF
           #TQC-C80129--mark--end--

           #增加顯示asf-382:"工單完工日與訂單預定交貨日不同!!"
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
              SELECT oeb15 INTO l_oeb15 FROM oeb_file
               WHERE oeb01 = g_sfb.sfb22 AND oeb03 = g_sfb.sfb221
              IF g_sfb.sfb15 != l_oeb15 THEN
                 CALL cl_err('','asf-382',0)
              END IF
           END IF
           IF NOT cl_null(l_sfb15_t) AND g_sfb.sfb15 != l_sfb15_t THEN
              IF cl_confirm("asf-988") THEN   #MOD-930037
                 CALL i300_time('2')
              END IF
           ELSE
              #若是一開始新增的話不詢問而自動計算
              IF cl_null(l_sfb15_t) THEN
                 CALL i300_time('2')
              END IF
           END IF

           #TQC-C80129--add--str--
           IF g_sfb.sfb13 < g_sfb.sfb81 THEN
              LET g_sfb.sfb13 = g_sfb.sfb81
              DISPLAY BY NAME g_sfb.sfb13
           END IF
           IF NOT cl_null(g_sfb.sfb13) THEN
              IF g_sfb.sfb13>g_sfb.sfb15 THEN
                 CALL cl_err('','asf-310',0)
                 LET g_sfb.sfb15=''
                 DISPLAY BY NAME g_sfb.sfb15
                 NEXT FIELD sfb13
              END IF
           END IF
           LET l_sfb13_t = g_sfb.sfb13
           LET l_sfb15_t = g_sfb.sfb15
           #TQC-C80129--add--end--

        AFTER FIELD sfb91
           IF NOT cl_null(g_sfb.sfb91) THEN
               SELECT COUNT(*) INTO l_n FROM ksf_file
                WHERE ksf01=g_sfb.sfb91
                  AND ksfconf='Y'
               IF l_n=0 THEN
                   CALL cl_err('','aap-091',0)
                   LET g_sfb.sfb91=NULL
                   DISPLAY BY NAME g_sfb.sfb91
                   NEXT FIELD sfb91
               END IF
           END IF

        AFTER FIELD sfb92
            IF NOT cl_null(g_sfb.sfb92) THEN
               IF p_cmd='a' AND
                 ( cl_null(g_sfb.sfb22) OR cl_null(g_sfb.sfb05)) THEN
                  SELECT ksg_file.*,ima02 INTO l_ksg.*,l_ima02
                    FROM ksf_file,ksg_file,ima_file
                   WHERE ksg03=ima01
                     AND ksf01=ksg01
                     AND ksg01=g_sfb.sfb91
                     AND ksg02=g_sfb.sfb92
                  IF l_ksg.ksg09 = 'Y' THEN
                     CALL cl_err('','9004',0)
                     NEXT FIELD sfb92
                  END IF
                  LET g_sfb.sfb05 =l_ksg.ksg03   #NO:料號
                  LET g_sfb.sfb15 =l_ksg.ksg04   #完工日
                  LET g_sfb.sfb071=l_ksg.ksg07   #有效日

                  SELECT SUM(sfb08) INTO l_sfb08 FROM sfb_file
                   WHERE sfb91=g_sfb.sfb91
                     AND sfb92=g_sfb.sfb92
                     AND sfb05=g_sfb.sfb05
                     AND sfb87 !='X'             #MOD-A60073 add
                  IF cl_null(l_sfb08) THEN
                      LET l_sfb08=0
                  END IF
                  LET g_sfb.sfb08=l_ksg.ksg05-l_sfb08   #生產數量
                  #CHI-B50051 ----- start -----
                  IF g_sfb.sfb08 < 0  THEN
                     LET g_sfb.sfb08 = 0
                  END IF
                  LET l_sfb92 = g_sfb.sfb92 USING '#####'                        #add by lanhang 130925
                  LET g_sfb.sfbud02=g_sfb.sfb91 CLIPPED,'_',l_sfb92.trim()       #add by lanhang 130925
                  DISPLAY BY NAME g_sfb.sfbud02                                  #add by lanhang 130925
                  #CHI-B50051 -----  end  -----
                  DISPLAY BY NAME g_sfb.sfb05
                  DISPLAY BY NAME g_sfb.sfb15
                  DISPLAY BY NAME g_sfb.sfb071
                  DISPLAY BY NAME g_sfb.sfb08
                  DISPLAY l_ima02 TO FORMONLY.ima02
               END IF
            END IF

        AFTER FIELD sfb97
           LET l_oeb908 = NULL
           IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221) THEN
              SELECT oeb908 INTO l_oeb908 FROM oeb_file
               WHERE oeb01 = g_sfb.sfb22
                 AND oeb03 = g_sfb.sfb221
              IF NOT cl_null(l_oeb908) THEN
                 IF l_oeb908 != g_sfb.sfb97 THEN
                    CALL cl_err('','asf-682',0)
                    LET g_sfb.sfb97 = l_oeb908
                    NEXT FIELD sfb97
                 END IF
                 DISPLAY BY NAME g_sfb.sfb97
              END IF
           END IF
           IF cl_null(l_oeb908) THEN
            IF NOT cl_null(g_sfb.sfb97) THEN
               SELECT coc10 INTO l_coc10 FROM coc_file
                WHERE coc03 = g_sfb.sfb97
               IF STATUS THEN
                  CALL cl_err3("sel","coc_file",g_sfb.sfb97,"","aco-062","","",1)  #No.FUN-660128
                  NEXT FIELD sfb97
               END IF
               SELECT COUNT(*) INTO l_cnt FROM coc_file,cod_file,coa_file
                WHERE coc01 = cod01
                  AND cod03 = coa03
                  AND coa05 = l_coc10
                  AND coa01 = g_sfb.sfb05
                  AND coc03 = g_sfb.sfb97
               IF l_cnt = 0 THEN
                  CALL cl_err(g_sfb.sfb97,'aco-073',0)
                  NEXT FIELD sfb97
               END IF
            END IF
           END IF   #CHI-910055

       BEFORE FIELD sfb93
          CALL i301_set_entry(p_cmd)
          CALL i301_set_no_required()

       AFTER FIELD sfb93
          IF cl_null(g_sfb.sfb93) OR g_sfb.sfb93 NOT MATCHES '[YN]' THEN
             NEXT FIELD sfb93
          END IF
          CALL i301_set_no_entry(p_cmd)
          CALL i301_set_required()

       AFTER FIELD sfb94
          IF cl_null(g_sfb.sfb94) OR g_sfb.sfb94 NOT MATCHES '[YN]' THEN
             NEXT FIELD sfb94
          END IF

       AFTER FIELD sfb27
          IF NOT cl_null(g_sfb.sfb27) AND g_aza.aza08='Y' THEN    #bugno:7255
             SELECT * FROM pja_file WHERE pja01=g_sfb.sfb27
                                      AND pjaclose='N'            #FUN-960038
             IF STATUS THEN
                CALL cl_err3("sel","pja_file",g_sfb.sfb27,"","apj-005","","sel_pja",1)  #No.FUN-660128
                NEXT FIELD sfb27
             END IF
             CALL i301_proj()  #FUN-810045
             CALL i301_set_entry(p_cmd)    #FUN-810045
             CALL i301_set_no_entry(p_cmd) #FUN-810045
          END IF

       AFTER FIELD sfb271
          IF NOT cl_null(g_sfb.sfb271)  THEN
             SELECT * FROM pjb_file
              WHERE pjb01=g_sfb.sfb27 AND pjb02=g_sfb.sfb271
               AND pjbacti = 'Y'
             IF STATUS THEN
                CALL cl_err3("sel","pjb_file",g_sfb.sfb27,g_sfb.sfb271,STATUS,"","sel_pjb",1)  #No.FUN-660128
                NEXT FIELD sfb271
             END IF
             SELECT pjb09,pjb11 INTO l_pjb09,l_pjb11
              FROM pjb_file WHERE pjb01 = g_sfb.sfb27
               AND pjb02 = g_sfb.sfb271
               AND pjbacti = 'Y'
             IF l_pjb09 != 'Y' OR l_pjb11 != 'Y' THEN
                CALL cl_err(g_sfb.sfb271,'apj-090',0)
                LET g_sfb.sfb271 = g_sfb_t.sfb271
                NEXT FIELD sfb271
             END IF

             CALL i301_proj()  #FUN-810045
             CALL i301_set_entry(p_cmd)    #FUN-810045
             CALL i301_set_no_entry(p_cmd) #FUN-810045
          END IF

       BEFORE FIELD sfb50
         IF cl_null(g_sfb.sfb271) THEN
            NEXT FIELD sfb51
         ELSE
            SELECT pjb25 INTO l_pjb25 FROM pjb_file
             WHERE pjb02 = g_sfb.sfb271
            IF l_pjb25 = 'N' THEN  #WBS不做活動時，活動帶空白，跳開不輸入
               LET g_sfb.sfb50 = ' '
               DISPLAY BY NAME g_sfb.sfb50
               NEXT FIELD sfb51
            END IF
         END IF

       AFTER FIELD sfb50
          IF NOT cl_null(g_sfb.sfb50) THEN
             SELECT COUNT(*) INTO g_cnt FROM pjk_file
              WHERE pjk02 = g_sfb.sfb50
                AND pjk11 = g_sfb.sfb271
                AND pjkacti = 'Y'
             IF g_cnt = 0 THEN
                CALL cl_err(g_sfb.sfb50,'apj-049',0)
                NEXT FIELD sfb50
             END IF
             CALL i301_proj()  #FUN-810045
          END IF

       AFTER FIELD sfb51
         IF NOT cl_null(g_sfb.sfb51) THEN
            SELECT COUNT(*) INTO g_cnt FROM azf_file
              WHERE azf01=g_sfb.sfb51 AND azf02='2' AND azfacti='Y'
            IF g_cnt = 0 THEN
               CALL cl_err(g_sfb.sfb51,'asf-453',0)
               NEXT FIELD sfb51
            END IF
            LET l_azf09=' '      #MOD-B70035 add
            SELECT azf09 INTO l_azf09 FROM azf_file
              WHERE azf01=g_sfb.sfb51 AND azf02='2' AND azfacti='Y'
           #MOD-CB0029---add---S
            IF g_smy.smy59 = 'Y' THEN
               IF l_azf09 != '7' THEN
                  CALL cl_err('','aoo-406',1)
                  NEXT FIELD sfb51
               END IF
            ELSE
           #MOD-CB0029---add---E
               IF l_azf09 != 'C' THEN
                  CALL cl_err('','aoo-411',0)
                  NEXT FIELD sfb51
               END IF
            END IF         #MOD-CB0029 add
            CALL i301_proj()  #FUN-810045

         ELSE  #料號如果要做專案控管的話，一定要輸入理由碼
           IF g_smy.smy59 = 'Y' THEN
              CALL cl_err('','apj-201',0)
              NEXT FIELD sfb51
           END IF
         END IF

       AFTER FIELD sfb30
         #IF g_sfb.sfb30 IS NOT NULL THEN
          IF NOT cl_null(g_sfb.sfb30) THEN  #Mod No.FUN-AA0050
             SELECT imd02 FROM imd_file
              WHERE imd01=g_sfb.sfb30
                AND imdacti = 'Y' #MOD-4B0169
             IF STATUS THEN
                CALL cl_err3("sel","imd_file",g_sfb.sfb30,"",STATUS,"","sel imd:",1)  #No.FUN-660128
                NEXT FIELD sfb30
             END IF
             #Add No.FUN-AA0050
             IF NOT s_chk_ware(g_sfb.sfb30) THEN  #检查仓库是否属于当前门店
                NEXT FIELD sfb30
             END IF
             #End Add No.FUN-AA0050
          END IF

       AFTER FIELD sfb100 #NO:6961
          IF NOT cl_null(g_sfb.sfb100) THEN
             IF g_sfb.sfb100 NOT MATCHES '[12]' THEN
                NEXT FIELD sfb100
             END IF
             IF (g_sfb.sfb100<>g_sfb_t.sfb100)
                AND (g_sfb.sfb100='2' AND g_sfb_t.sfb100<>'2') THEN
                SELECT COUNT(*) INTO g_cnt FROM pmn_file,pmm_file
                 WHERE pmn41=g_sfb.sfb01
                   AND pmm01=pmn01
                IF g_cnt >0 THEN
                    CALL cl_err('','asf-951',1)
                    LET g_sfb.sfb100=g_sfb_t.sfb100
                    DISPLAY BY NAME g_sfb.sfb100
                    NEXT FIELD sfb100
                END IF
             END IF
          ELSE
              IF g_sfb.sfb02 MATCHES '[78]' THEN
                 CALL cl_err('','aap-099',0)
                 NEXT FIELD sfb100
              END IF
          END IF

       AFTER FIELD sfb34
          IF g_sfb.sfb34 < 0 OR g_sfb.sfb34 > 100 THEN
             CALL cl_err(g_sfb.sfb34,'aec-002',0)
             NEXT FIELD sfb34
          END IF

       AFTER FIELD sfb1001
          IF NOT cl_null(g_sfb.sfb1001) THEN
             CALL i301_sfb1001()
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_sfb.sfb1001,g_errno,0)
                NEXT FIELD sfb1001
             END IF
          END IF

       AFTER FIELD sfb85
         IF NOT cl_null(g_sfb.sfb85) THEN
            #FUN-A80054--begin--add-------------------------
            LET l_n1=0
            SELECT count(*) INTO l_n1 FROM sfc_file
             WHERE sfc01=g_sfb.sfb85
            IF l_n1 = 0 THEN
               CALL cl_err('','asf-432',1)
               NEXT FIELD sfb85
            END IF
            LET l_n1=0
            SELECT count(*) INTO l_n1 FROM sfd_file
             WHERE sfd01=g_sfb.sfb85 AND sfdconf='Y'
            IF l_n1 > 0 THEN
               CALL cl_err(g_sfb.sfb85,'asf-159',1)
               NEXT FIELD sfb85
            END IF
            IF p_cmd='u' AND (g_sfb.sfb85 <> g_sfb_t.sfb85 OR cl_null(g_sfb_t.sfb85)) THEN
               CALL i301_del_edg()
               DELETE FROM sfd_file WHERE sfd03=g_sfb.sfb01 AND sfd01=g_sfb_t.sfb85
               SELECT DISTINCT sfd08 INTO l_sfd08 FROM sfd_file WHERE sfd01=g_sfb.sfb85
               IF NOT cl_null(l_sfd08) THEN
                  LET l_n1 = 0
                  SELECT count(*) INTO l_n1 FROM edb_file,eda_file
                   WHERE edb01=l_sfd08 AND edb03=g_sfb.sfb05
                     AND edb04=g_sfb.sfb06 AND eda01=edb01 AND edaconf='Y'
                  IF l_n1 > 0 THEN
                     CALL i301_ins_sfd(l_sfd08)
                  END IF
               END IF
               CALL i301_ins_sfd_1()
            END IF
         ELSE
            #TQC-BB0224--begin--add---
            IF NOT cl_null(g_sfb_t.sfb85) THEN
               LET l_n1 = 0
               SELECT COUNT(*) INTO l_n1 FROM sfd_file WHERE sfd01=g_sfb_t.sfb85 AND sfdconf='Y'
               IF l_n1 > 0 THEN
                  CALL cl_err(g_sfb_t.sfb85,'asf-159',1)
                  LET g_sfb.sfb85=g_sfb_t.sfb85
                  DISPLAY BY NAME g_sfb.sfb85
                  NEXT FIELD sfb85
               END IF
            END IF
            ##TQC-BB0224--end--add---
            IF p_cmd='u' THEN
               SELECT count(*) INTO g_cnt FROM sfd_file WHERE sfd03=g_sfb.sfb01 AND sfdconf='N'
               IF g_cnt > 0 THEN
                  CALL i301_del_edg()
                  DECLARE sfd_cs CURSOR FOR
                   SELECT DISTINCT sfd01 FROM sfd_file WHERE sfd03=g_sfb.sfb01 AND sfdconf='N'
                  LET i=1
                  FOREACH sfd_cs INTO l_sfd01[i]
                    LET i=i+1
                  END FOREACH
                  DELETE FROM sfd_file WHERE sfd03=g_sfb.sfb01
                  FOR n=1 TO i-1
                     SELECT sum(sfd05) INTO l_sfd06 FROM sfd_file WHERE sfd01=l_sfd01[n]
                     UPDATE sfd_file SET sfd06=l_sfd06 WHERE sfd01=l_sfd01[n]
                  END FOR
               END IF
            END IF
        #FUN-A80054--end--add------------------------------
         END IF



       AFTER FIELD sfbud01
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud02
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud03
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud04
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud05
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud06
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud07
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud08
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud09
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud10
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud11
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud12
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud13
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud14
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfbud15
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD ta_sfb37                                    #zangheng20170921aps
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF  #zangheng20170921aps

       AFTER FIELD sfb44
           IF NOT cl_null(g_sfb.sfb44) THEN
            #MOD-C30548--add--start--
              LET l_cnt2 = 0
              SELECT COUNT(*) INTO l_cnt2 FROM gen_file WHERE gen01=g_sfb.sfb44
              IF l_cnt2 = 0 THEN
                 CALL cl_err(g_sfb.sfb44,'mfg1312',0)
                 NEXT FIELD sfb44
              END IF
            #MOD-C30548--add--end--
              SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01 = g_sfb.sfb44
              IF SQLCA.sqlcode = 100 THEN
                 CALL cl_err(g_sfb.sfb44,'mfg1312',0)
                 NEXT FIELD sfb44
              ELSE
                 DISPLAY l_gen02 TO FORMONLY.gen02
              END IF
           END IF

       AFTER FIELD sfbmksg
           IF NOT cl_null(g_sfb.sfbmksg) THEN
              IF g_sfb.sfbmksg NOT MATCHES '[yYnN]' THEN
                 NEXT FIELD sfbmksg
              END IF
              IF g_sfb.sfbmksg MATCHES '[Yy]' THEN
                 LET g_sfb.sfb43 = "0"
                 DISPLAY BY NAME g_sfb.sfb43
              END IF
              IF g_sfb.sfbmksg MATCHES '[Nn]' THEN
                 LET g_sfb.sfb43 = "1"
                 DISPLAY BY NAME g_sfb.sfb43
              END IF
           END IF

        AFTER INPUT #判斷必要欄位之值是否有值,若無則反白顯示,並要求重新輸入
           LET g_sfb.sfbuser = s_get_data_owner("sfb_file") #FUN-C10039
           LET g_sfb.sfbgrup = s_get_data_group("sfb_file") #FUN-C10039
            IF INT_FLAG THEN EXIT INPUT  END IF
           IF cl_null(g_sfb.sfb100) THEN
              IF g_sfb.sfb02 MATCHES '[78]' THEN
                 CALL cl_err('','aap-099',0)
                 NEXT FIELD sfb100
              END IF
           END IF
            IF g_aaz.aaz90 = 'Y' THEN
               IF cl_null(g_sfb.sfb98) THEN
                  NEXT FIELD sfb98
               END IF
            END IF

            #FUN-A50066--begin--add-------------
            IF NOT i301sub_chk_sfb81(g_sfb.sfb93,g_sfb.sfb05,g_sfb.sfb95,g_sfb.sfb06,
                                     g_sfb.sfb02,g_sfb.sfb071,g_sfb.sfb81) THEN
               IF g_errno = 'abm-005' THEN NEXT FIELD sfb071 END IF
               IF g_errno = 'abm-006' THEN NEXT FIELD sfb81 END IF
            END IF
            LET g_cnt = 0
            IF g_sma.sma542 = 'Y' AND g_sfb.sfb93='Y' THEN
               SELECT COUNT(*) INTO g_cnt FROM bra_file
                WHERE bra01=g_sfb.sfb05 AND braacti='Y'
            ELSE
               SELECT COUNT(*) INTO g_cnt FROM bma_file
                WHERE bma01=g_sfb.sfb05 AND bmaacti='Y'
               #TQC-AB0244--begin--add-------
               IF g_cnt = 0 AND g_sfb.sfb02='15' THEN
                  SELECT COUNT(*) INTO g_cnt FROM bmo_file
                   WHERE bmo01=g_sfb.sfb05 AND bmoacti='Y'
               END IF
               #TQC-AB0244--end--add----------
            END IF
            IF g_cnt = 0 THEN
               IF NOT (g_sfb.sfb02='5' OR g_sfb.sfb02='8'
                       OR g_sfb.sfb02='11') THEN
                       CALL cl_err(g_sfb.sfb05,'abm-742',1)
                       NEXT FIELD sfb05
                END IF
             END IF
             IF NOT cl_null(g_sfb.sfb95) THEN
                LET g_cnt = 0
                IF g_sma.sma542 = 'Y' AND g_sfb.sfb93 = 'Y' THEN  #TQC-B70126
                   SELECT COUNT(*) INTO g_cnt FROM bra_file
                    WHERE bra06 = g_sfb.sfb95
                      AND bra01 = g_sfb.sfb05
                      AND bra011 = g_sfb.sfb06
                      AND bra05 IS NOT NULL AND bra05 <=g_sfb.sfb81
                 ELSE
                   SELECT COUNT(*) INTO g_cnt FROM bma_file
                    WHERE bma06 = g_sfb.sfb95
                      AND bma01 = g_sfb.sfb05
                      AND bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81
                   #TQC-AB0244--begin--add-------
                   IF g_cnt = 0 AND g_sfb.sfb02='15' THEN
                      SELECT COUNT(*) INTO g_cnt FROM bmo_file
                       WHERE bmo06 = g_sfb.sfb95
                         AND bmo01 = g_sfb.sfb05
                         AND bmo05 IS NOT NULL AND bmo05 <=g_sfb.sfb81
                   END IF
                   #TQC-AB0244--end--add-------
                 END IF
                 IF g_cnt = 0 THEN
                    CALL cl_err(g_sfb.sfb95,"abm-618",1)
                    NEXT FIELD sfb95
                 END IF
             END IF
            #FUN-A50066--end--add-----------------

            IF g_sfb.sfb08 <=0 THEN
               LET l_flag='Y'
               DISPLAY BY NAME g_sfb.sfb08
               NEXT FIELD sfb08
            END IF
            IF NOT cl_null(g_sfb.sfb1001) THEN
               CALL i301_sfb1001()
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_sfb.sfb1001,g_errno,0)
                  NEXT FIELD sfb1001
               END IF
            END IF

           #檢查審核人員（sfb44）是否存在
           #MOD-C30548--add--start--
            IF NOT cl_null(g_sfb.sfb44) THEN
               LET l_cnt2 = 0
               SELECT COUNT(*) INTO l_cnt2 FROM gen_file WHERE gen01 = g_sfb.sfb44
               IF l_cnt2 = 0 THEN
                  CALL cl_err(g_sfb.sfb44,'mfg1312',0)
                  NEXT FIELD sfb44
               END IF
            END IF
           #MOD-C30548--add--end--

        ON ACTION controlp
           CASE
              WHEN INFIELD(sfb01) #order nubmer
                     LET g_t1 = s_get_doc_no(g_sfb.sfb01)       #No.FUN-550067
                     LET g_sql = " (smy73 <> 'Y' OR smy73 is null) AND smy72<>'P' "  #FUN-9B014
                     CALL smy_qry_set_par_where(g_sql)
                     CALL q_smy( FALSE,TRUE,g_t1,'ASF','1') RETURNING g_t1  #TQC-670008
                    LET g_sfb.sfb01=g_t1     #No.FUN-550067
                    DISPLAY BY NAME g_sfb.sfb01
                    NEXT FIELD sfb01
               WHEN INFIELD(sfb82)
                    IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN   #NO:7075
                        CALL cl_init_qry_var()
                        LET g_qryparam.form     = "q_pmc3"      #No.MOD-850042 modify
                        LET g_qryparam.default1 = g_sfb.sfb82
                        CALL cl_create_qry() RETURNING g_sfb.sfb82
                     ELSE
                        CALL cl_init_qry_var()
                        LET g_qryparam.form     = "q_gem"
                        LET g_qryparam.default1 = g_sfb.sfb82
                        CALL cl_create_qry() RETURNING g_sfb.sfb82
                    END IF
                    DISPLAY BY NAME g_sfb.sfb82
                    NEXT FIELD sfb82
               WHEN INFIELD(sfb22)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_oea3"
                    LET g_qryparam.default1 = g_sfb.sfb22
                    LET g_qryparam.default2 = g_sfb.sfb221
                    CALL cl_create_qry() RETURNING g_sfb.sfb22,g_sfb.sfb221
                    DISPLAY BY NAME g_sfb.sfb22,g_sfb.sfb221
                    NEXT FIELD sfb22
               WHEN INFIELD(sfb05) #item
#FUN-AA0059---------mod------------str-----------------
#                   CALL cl_init_qry_var()                              #FUN-AA0059 mark
                    IF g_sfb.sfb02 = '15' THEN
                       CALL cl_init_qry_var()                           #FUN-AA0059 add
                       LET g_qryparam.form     = "q_bmq1"
                       LET g_qryparam.default1 = g_sfb.sfb05
                       CALL cl_create_qry() RETURNING g_sfb.sfb05
                    ELSE
#                      LET g_qryparam.form     = "q_ima18" #FUN-640030  #FUN-AA0059 mark
                       CALL q_sel_ima(FALSE, "q_ima18","",g_sfb.sfb05,"","","","","",'' )   #FUN-AA0059 add
                         RETURNING g_sfb.sfb05                                              #FUN-AA0059 add
                    END IF
#                   LET g_qryparam.default1 = g_sfb.sfb05              #FUN-AA0059 mark
#                   CALL cl_create_qry() RETURNING g_sfb.sfb05         #FUN-AA0059 mark
#FUN-AA0059---------mod------------end-----------------
                    DISPLAY BY NAME g_sfb.sfb05
                    NEXT FIELD sfb05
               WHEN INFIELD(sfb86) #PBI
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_sfb"    #TQC-7B0048
                    LET g_qryparam.default1 = g_sfb.sfb86
                    CALL cl_create_qry() RETURNING g_sfb.sfb86
                    DISPLAY BY NAME g_sfb.sfb86
                    NEXT FIELD sfb86
#FUN-C30114---begin
               WHEN INFIELD(sfb89)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_sfb"
                    LET g_qryparam.default1 = g_sfb.sfb89
                    CALL cl_create_qry() RETURNING g_sfb.sfb89
                    DISPLAY BY NAME g_sfb.sfb89
                    NEXT FIELD sfb89
#FUN-C30114---end
               WHEN INFIELD(sfb06)
                    CALL cl_init_qry_var()
                    IF g_sma.sma541 = 'Y' THEN    #FUN-A50066
                       LET g_qryparam.form     = "q_ecu_a"   #FUN-A50066
                    ELSE   #FUN-A50066
                       LET g_qryparam.form     = "q_ecu"
                    END IF #FUN-A50066
                    IF g_ima.ima571 IS NULL THEN LET g_ima.ima571 = ' ' END IF  #No.TQC-940077 add
                    LET g_qryparam.arg1     = g_ima.ima571
                    LET g_qryparam.arg2 = g_sfb.sfb05        #No.TQC-9A0065 add
                    LET g_qryparam.default1 = g_sfb.sfb06
                    CALL cl_create_qry() RETURNING g_sfb.sfb06
                    DISPLAY BY NAME g_sfb.sfb06
                    NEXT FIELD sfb06
               WHEN INFIELD(sfb98)
                    CALL cl_init_qry_var()
                    IF g_aaz.aaz90='Y' THEN  #FUN-670103
                       LET g_qryparam.form  = "q_gem4"  #FUN-670103
                    ELSE
                       LET g_qryparam.form  = "q_gem"
                    END IF
                    LET g_qryparam.default1 = g_sfb.sfb98
                    CALL cl_create_qry() RETURNING g_sfb.sfb98
                    DISPLAY BY NAME g_sfb.sfb98
                    NEXT FIELD sfb98
               WHEN INFIELD(sfb97)
                    CALL q_coc2(FALSE,FALSE,g_sfb.sfb97,'',g_sfb.sfb13,'0',
                                '',g_sfb.sfb05)
                    RETURNING g_sfb.sfb97,l_coc04
                    DISPLAY BY NAME g_sfb.sfb97
                    NEXT FIELD sfb97
               WHEN INFIELD(sfb91)
                    CALL q_ksg(FALSE,TRUE,g_sfb.sfb91,0)
                    RETURNING g_sfb.sfb91,g_sfb.sfb92
                    DISPLAY BY NAME g_sfb.sfb91,g_sfb.sfb92
                    NEXT FIELD sfb91
               WHEN INFIELD(sfb27)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_pja2"   #FUN-810045   #MOD-980224 q_pja2-->q_pja4 #MOD-9A0048 q_pja4 -> q_pja2
                    LET g_qryparam.default1 = g_sfb.sfb27
                    CALL cl_create_qry() RETURNING g_sfb.sfb27
                    DISPLAY BY NAME g_sfb.sfb27
                    NEXT FIELD sfb27
               WHEN INFIELD(sfb271)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_pjb4"   #FUN-810045
                    LET g_qryparam.default1 = g_sfb.sfb271
                    LET g_qryparam.arg1     = g_sfb.sfb27
                    CALL cl_create_qry() RETURNING g_sfb.sfb271
                    DISPLAY BY NAME g_sfb.sfb271
                    NEXT FIELD sfb271
               WHEN INFIELD(sfb50) #活動
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pjk3"
                  LET g_qryparam.arg1 = g_sfb.sfb271
                  CALL cl_create_qry() RETURNING g_sfb.sfb50
                  DISPLAY BY NAME g_sfb.sfb50
                  NEXT FIELD sfb50
                WHEN INFIELD(sfb51)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf01a"            #FUN-930145
                  IF g_smy.smy59 = 'Y' THEN                  #MOD-CB0029 add
                     LET g_qryparam.arg1 = '7'               #MOD-CB0029 add
                  ELSE                                       #MOD-CB0029 add
                     LET g_qryparam.arg1 = 'C'               #FUN-930145
                  END IF                                     #MOD-CB0029 add
                  CALL cl_create_qry() RETURNING g_sfb.sfb51
                  DISPLAY BY NAME g_sfb.sfb51
                  NEXT FIELD sfb51
               WHEN INFIELD(sfb95)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_bma7"
                    LET g_qryparam.default1 = g_sfb.sfb95
                    LET g_qryparam.arg1 = g_sfb.sfb05
                    CALL cl_create_qry() RETURNING g_sfb.sfb95
                    DISPLAY BY NAME g_sfb.sfb95
                    NEXT FIELD sfb95
               WHEN INFIELD(sfb1001)     #核准文號
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_bxa01"
                    CALL cl_create_qry() RETURNING g_sfb.sfb1001
                    DISPLAY BY NAME g_sfb.sfb1001
                    NEXT FIELD sfb1001
               WHEN INFIELD(sfb102)                 #機械編號
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_eci"
                    LET g_qryparam.default1 =g_sfb.sfb102
                    CALL cl_create_qry() RETURNING g_sfb.sfb102
                    DISPLAY BY NAME g_sfb.sfb102
                    NEXT FIELD sfb102

               WHEN INFIELD(sfb85)                 #機械編號
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_sfb85"     #FUN-A80054
                    LET g_qryparam.default1 =g_sfb.sfb85
                    CALL cl_create_qry() RETURNING g_sfb.sfb85
                    DISPLAY BY NAME g_sfb.sfb85
                    NEXT FIELD sfb85

               WHEN INFIELD(sfb30)                 #機械編號
                   #Mod No.FUN-AA0050
                   #CALL cl_init_qry_var()
                   #LET g_qryparam.form = "q_imd02"
                   #LET g_qryparam.default1 =g_sfb.sfb30
                   #CALL cl_create_qry() RETURNING g_sfb.sfb30
                    CALL q_imd_1(FALSE,TRUE,g_sfb.sfb30,"",g_plant,"","")  #只能开当前门店的
                         RETURNING g_sfb.sfb30
                   #End Mod No.FUN-AA0050
                    DISPLAY BY NAME g_sfb.sfb30
                    NEXT FIELD sfb30
               WHEN INFIELD(sfb31)                 #機械編號
                   #Mod No.FUN-AA0050
                   #CALL cl_init_qry_var()
                   #IF g_sfb.sfb30 IS NULL THEN
                   #   LET g_qryparam.form = "q_ime2"
                   #ELSE
                   #   LET g_qryparam.form = "q_ime02"
                   #   LET g_qryparam.arg1 = g_sfb.sfb30
                   #END IF
                   #LET g_qryparam.default1 =g_sfb.sfb31
                   #CALL cl_create_qry() RETURNING g_sfb.sfb31
                    IF g_sfb.sfb30 IS NULL THEN
                       CALL q_ime_1(FALSE,TRUE,g_sfb.sfb31,"","",g_plant,"Y","","")
                                RETURNING g_sfb.sfb31
                    ELSE
                       CALL q_ime_1(FALSE,TRUE,g_sfb.sfb31,g_sfb.sfb30,"",g_plant,"Y","","")
                                RETURNING g_sfb.sfb31
                    END IF
                   #End Mod No.FUN-AA0050
                    DISPLAY BY NAME g_sfb.sfb31
                    NEXT FIELD sfb31
               WHEN INFIELD(sfb44)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 =g_sfb.sfb44
                    CALL cl_create_qry() RETURNING g_sfb.sfb44
                    DISPLAY BY NAME g_sfb.sfb44
                    NEXT FIELD sfb44
               WHEN INFIELD(sfbud04)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "cq_azfn"
                    LET g_qryparam.default1 =g_sfb.sfbud04
                    CALL cl_create_qry() RETURNING g_sfb.sfbud04
                    DISPLAY BY NAME g_sfb.sfbud04
                    NEXT FIELD sfbud04
               OTHERWISE EXIT CASE
           END CASE


        ON ACTION cooi301
           LET g_msg="cooi301"
           CALL cl_cmdrun_wait(g_msg)

        ON ACTION qry_mps  #NO:3537
           CALL cl_init_qry_var()
           LET g_qryparam.construct = "Y"
           LET g_qryparam.form = "q_msb1"   #FUN-A50066
           LET g_qryparam.default1 = g_sfb.sfb22
           CALL cl_create_qry() RETURNING g_sfb.sfb22,g_sfb.sfb221
           DISPLAY BY NAME g_sfb.sfb22,g_sfb.sfb221
           NEXT FIELD sfb22

        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913

        ON ACTION CONTROLR
           CALL cl_show_req_fields()

        ON ACTION CONTROLG CALL cl_cmdask()

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

    END INPUT

END FUNCTION

FUNCTION i301_set_required()

  IF g_sfb.sfb93 = 'Y' THEN
     CALL cl_set_comp_required("sfb06",TRUE)
  END IF

  IF g_aaz.aaz90 = 'Y' THEN
     CALL cl_set_comp_required("sfb98",TRUE)
  END IF

END FUNCTION

FUNCTION i301_set_no_required()

  CALL cl_set_comp_required("sfb06",FALSE)

  IF g_aaz.aaz90 = 'N' THEN
     CALL cl_set_comp_required("sfb98",FALSE)
  END IF

END FUNCTION

FUNCTION i301_set_entry(p_cmd)
 DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)


    IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("sfb01,sfb39,sfb071",TRUE)  #MOD-590259 add sfb071
    END IF

    IF ( NOT g_before_input_done ) THEN   #No:8125  #No:8573
       CALL cl_set_comp_entry("sfb02,sfb39,sfb22,sfb221,sfb05,sfb08,sfb07,  #No.FUN-560151                               sfb071,sfb91,sfb92",TRUE)  #No.MOD-590262
    END IF

    IF g_sfb.sfb02<>'7' AND g_sfb.sfb02<>'8'  AND g_sfb.sfb02<>'11' AND g_sfb.sfb02<>'15' THEN  #MOD-850257
       CALL cl_set_comp_entry("sfb93,sfb06",TRUE)
    END IF

    IF INFIELD(sfb01) OR ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("sfb06",TRUE)
    END IF

    #作業群組6或製程工單可維護製程編號
    IF INFIELD(sfb93) THEN
       CALL cl_set_comp_entry("sfb06",TRUE)
    END IF

    IF INFIELD(sfb02) OR ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("sfb100",TRUE)
       IF g_sfb.sfb02 ='15' THEN
          CALL cl_set_comp_required("sfb07",TRUE)
       END IF
    END IF


       CALL cl_set_comp_entry("sfb97",TRUE)

   IF g_sma.sma118 = "Y" THEN
      CALL cl_set_comp_entry("sfb95",TRUE)
   END IF

    IF p_cmd= 'u' AND g_sfb.sfb23='N' THEN
       CALL cl_set_comp_entry("sfb071",TRUE)
    END IF

   IF g_sfb.sfb02 NOT MATCHES '[78]' THEN
      CALL cl_set_comp_entry("sfb94",TRUE)
   END IF

   CALL cl_set_comp_entry("sfb1001",TRUE)    #FUN-6A0007
   CALL cl_set_comp_entry("sfb27,sfb271,sfb50,sfb51",TRUE)    #FUN-810045

END FUNCTION

FUNCTION i301_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
  DEFINE l_cnt   LIKE type_file.num5      #No.FUN-560151  #No.FUN-680121 SMALLINT
  DEFINE l_ecm   LIKE type_file.num5      #no.MOD-790128
  DEFINE l_smy57_5  LIKE type_file.chr1  #CHI-910055
  DEFINE l_t1       LIKE smy_file.smyslip #CHI-910055

    SELECT COUNT(*) INTO l_ecm
      FROM ecm_file
     WHERE ecm01 = g_sfb.sfb01
    IF l_ecm > 0 THEN
       CALL cl_set_comp_entry("sfb05",FALSE)
    END IF

    #IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN #TQC-BC0154
    IF p_cmd = 'u' AND ( NOT g_before_input_done ) THEN  #TQC-BC0154
       CALL cl_set_comp_entry("sfb01",FALSE)
    END IF
    LET l_cnt =0
    SELECT COUNT(*) INTO l_cnt FROM sfa_file WHERE sfa01=g_sfb.sfb01
    IF l_cnt > 0  THEN
      IF p_cmd = 'u' AND ( NOT g_before_input_done ) THEN
         CALL cl_set_comp_entry("sfb39",FALSE)
      END IF
    END IF

   #TQC-940069 add ICD行業時不受此控管,及ICD委外工單也要可以輸入sfb06(for sfbiicd09 kind = '6:tyk')
    IF g_sfb.sfb02='7' OR g_sfb.sfb02='8' OR g_sfb.sfb02='11' OR g_sfb.sfb02='15' THEN  #MOD-850257
       LET g_sfb.sfb93 = 'N'
       LET g_sfb.sfb06 = ''
       DISPLAY BY NAME g_sfb.sfb93
       DISPLAY BY NAME g_sfb.sfb06
       CALL cl_set_comp_entry("sfb93,sfb06",FALSE)
    END IF
    IF p_cmd= 'u' AND g_sfb.sfb23='Y' THEN     #MOD-470493(9785) add
       CALL cl_set_comp_entry("sfb22,sfb221,sfb91,sfb92",FALSE)   #MOD-590262 add sfb91,sfb92
    END IF
    IF g_sfb.sfb23='Y' THEN     #No:8125  #No:8573 MOD-470493(9785)
       #CALL cl_set_comp_entry("sfb02,sfb05,sfb08,sfb07,sfb071,sfb95",FALSE)    #MOD-A90186 add sfb95
       CALL cl_set_comp_entry("sfb05,sfb08,sfb07,sfb071,sfb95",FALSE)    #MOD-A90186 add sfb95
    END IF

    IF g_sfb.sfb93 !='Y' THEN    #No:7254
       LET g_sfb.sfb06 = ''
       DISPLAY BY NAME g_sfb.sfb06
       CALL cl_set_comp_entry("sfb06",FALSE)
    END IF

    IF INFIELD(sfb02) OR ( NOT g_before_input_done ) THEN
       IF g_sfb.sfb02 NOT MATCHES '[78]' THEN
          CALL cl_set_comp_entry("sfb100",FALSE)
       END IF
    END IF

     IF g_sfb.sfb02 !='15' THEN
        CALL cl_set_comp_required("sfb07",FALSE)
     END IF

       LET l_t1=g_sfb.sfb01[1,g_doc_len]                                #CHI-910055
       SELECT smy57[5,5] INTO l_smy57_5 FROM smy_file WHERE smyslip=l_t1#CHI-910055
       IF g_aza.aza27 !='Y' OR l_smy57_5 != 'Y' THEN                    #CHI-910055
          CALL cl_set_comp_entry("sfb97",FALSE)
       END IF

   IF g_sma.sma118 = "N" THEN
      CALL cl_set_comp_entry("sfb95",FALSE)
   END IF

   IF g_sfb.sfb02 MATCHES '[78]' THEN
      CALL cl_set_comp_entry("sfb94",FALSE)
   END IF

   IF g_sfb.sfb02 NOT MATCHES '[78]' THEN
      CALL cl_set_comp_entry("sfb1001",FALSE)
   END IF

    IF NOT cl_null(g_sfb.sfb22) AND NOT cl_null(g_sfb.sfb221)  THEN
      CALL cl_set_comp_entry("sfb27,sfb271,sfb50,sfb51",FALSE)
    END IF

END FUNCTION

FUNCTION i301_sfb39(p_sfb39)
    DEFINE p_sfb39      LIKE type_file.num5    #No.FUN-680121 SMALLINT
    DEFINE l_str        LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(10)

    CASE WHEN p_sfb39 ='1' LET l_str='PUSH'
         WHEN p_sfb39 ='2' LET l_str='PULL'
    END CASE
    RETURN l_str
END FUNCTION

FUNCTION i301_sfb98()
DEFINE
    p_cmd           LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(1)
    l_gemacti       LIKE gem_file.gemacti

    LET g_errno = ''
    SELECT gemacti  INTO l_gemacti FROM gem_file
     WHERE gem01 = g_sfb.sfb98

    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg1318'
                                   LET l_gemacti = NULL
         WHEN l_gemacti='N'        LET g_errno = '9028'
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE

END FUNCTION

FUNCTION i301_1()
  DEFINE l_pjb25   LIKE   pjb_file.pjb25,    #FUN-810045
         l_ima920  LIKE   ima_file.ima920,   #FUN-8100045
         l_azf09   LIKE   azf_file.azf09     #FUN-930145

    SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01 = g_sfb.sfb01
    IF g_sfb.sfb01 IS NULL THEN RETURN END IF
    IF g_sfb.sfb87 = 'X'   THEN CALL cl_err('','9024',0) RETURN END IF

    OPEN WINDOW i3011_w AT 13,11 WITH FORM "asf/42f/asfi301a"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("asfi301a")


    INPUT BY NAME g_sfb.sfb93,g_sfb.sfb94,g_sfb.sfb27,g_sfb.sfb271,
                  g_sfb.sfb50,g_sfb.sfb51,                           #FUN-810045 add
                  g_sfb.sfb30,g_sfb.sfb31,g_sfb.sfb32,g_sfb.sfb33,
                  g_sfb.sfb222,g_sfb.sfb100
          WITHOUT DEFAULTS
       AFTER FIELD sfb93
          IF cl_null(g_sfb.sfb93) OR g_sfb.sfb93 NOT MATCHES '[YN]' THEN
             NEXT FIELD sfb93
          END IF
       AFTER FIELD sfb94
          IF cl_null(g_sfb.sfb94) OR g_sfb.sfb94 NOT MATCHES '[YN]' THEN
             NEXT FIELD sfb94
          END IF
       AFTER FIELD sfb27
          IF NOT cl_null(g_sfb.sfb27) AND g_aza.aza08='Y' THEN    #bugno:7255
             SELECT * FROM pja_file WHERE pja01=g_sfb.sfb27
                                      AND pjaclose='N'            #FUN-960038
             IF STATUS THEN
                CALL cl_err3("sel","pja_file",g_sfb.sfb27,"","apj-005","","sel_pja",1)  #No.FUN-660128
                NEXT FIELD sfb27
             END IF
             CALL i301_proj()  #FUN-810045
          END IF
       AFTER FIELD sfb271
          IF NOT cl_null(g_sfb.sfb271)  THEN
             SELECT * FROM pjb_file
              WHERE pjb01=g_sfb.sfb27 AND pjb02=g_sfb.sfb271
             IF STATUS THEN
                CALL cl_err3("sel","pjb_file",g_sfb.sfb27,g_sfb.sfb271,STATUS,"","sel_pjb",1)  #No.FUN-660128
                NEXT FIELD sfb271
             END IF
             CALL i301_proj()  #FUN-810045
          END IF
       BEFORE FIELD sfb50
         IF cl_null(g_sfb.sfb271) THEN
            NEXT FIELD sfb51
         ELSE
            SELECT pjb25 INTO l_pjb25 FROM pjb_file
             WHERE pjb02 = g_sfb.sfb271
            IF l_pjb25 = 'N' THEN  #WBS不做活動時，活動帶空白，跳開不輸入
               LET g_sfb.sfb50 = ' '
               DISPLAY BY NAME g_sfb.sfb50
               NEXT FIELD sfb51
            END IF
         END IF

       AFTER FIELD sfb50
          IF NOT cl_null(g_sfb.sfb50) THEN
             SELECT COUNT(*) INTO g_cnt FROM pjk_file
              WHERE pjk02 = g_sfb.sfb50     #No.TQC-930119 add
                AND pjk11 = g_sfb.sfb271
                AND pjkacti = 'Y'
             IF g_cnt = 0 THEN
                CALL cl_err(g_sfb.sfb50,'apj-049',0)
                NEXT FIELD sfb50
             END IF
             CALL i301_proj()  #FUN-810045
          END IF

       AFTER FIELD sfb51
         IF NOT cl_null(g_sfb.sfb51) THEN
            SELECT COUNT(*) INTO g_cnt FROM azf_file
              WHERE azf01=g_sfb.sfb51 AND azf02='2' AND azfacti='Y'
            IF g_cnt = 0 THEN
               CALL cl_err(g_sfb.sfb51,'asf-453',0)
               NEXT FIELD sfb51
            END IF
            LET l_azf09=' '      #MOD-B70035 add
            SELECT azf09 INTO l_azf09 FROM azf_file
              WHERE azf01=g_sfb.sfb51 AND azf02='2' AND azfacti='Y'
            IF l_azf09 != 'C' THEN
               CALL cl_err('','aoo-411',0)
               NEXT FIELD sfb51
            END IF
            CALL i301_proj()  #FUN-810045
         ELSE  #料號如果要做專案控管的話，一定要輸入理由碼
           SELECT ima920 INTO l_ima920
             FROM ima_file
            WHERE ima01 = g_sfb.sfb05
           IF l_ima920 = 'Y' THEN
              CALL cl_err(g_sfb.sfb51,'apj-200',0)
              NEXT FIELD sfb51
           END IF
         END IF
       AFTER FIELD sfb30
         #IF g_sfb.sfb30 IS NOT NULL THEN
          IF NOT cl_null(g_sfb.sfb30) THEN  #Mod No.FUN-AA0050
             SELECT imd02 FROM imd_file
              WHERE imd01=g_sfb.sfb30
                AND imdacti = 'Y' #MOD-4B0169
             IF STATUS THEN
                CALL cl_err3("sel","imd_file",g_sfb.sfb30,"",STATUS,"","sel imd:",1)  #No.FUN-660128
                NEXT FIELD sfb30
             END IF
             #Add No.FUN-AA0050
             IF NOT s_chk_ware(g_sfb.sfb30) THEN  #检查仓库是否属于当前门店
                NEXT FIELD sfb30
             END IF
             #End Add No.FUN-AA0050
          END IF
       AFTER FIELD sfb100 #NO:6961
          IF cl_null(g_sfb.sfb100) OR g_sfb.sfb100 NOT MATCHES '[12]' THEN
             NEXT FIELD sfb100
          END IF
          IF (g_sfb.sfb100<>g_sfb_t.sfb100)
             AND (g_sfb.sfb100='2' AND g_sfb_t.sfb100<>'2') THEN
             SELECT COUNT(*) INTO g_cnt FROM pmn_file,pmm_file
              WHERE pmn41=g_sfb.sfb01
                AND pmm01=pmn01
             IF g_cnt >0 THEN
                 CALL cl_err('','asf-951',1)
                 LET g_sfb.sfb100=g_sfb_t.sfb100
                 DISPLAY BY NAME g_sfb.sfb100
                 NEXT FIELD sfb100
             END IF
          END IF

          ON ACTION controlp
             IF INFIELD(sfb27) THEN
                CALL cl_init_qry_var()
                LET g_qryparam.form     = "q_pja2"   #FUN-810045   #MOD-980224 q_pja2-->q_pja4 #MOD-9A0048 q_pja4 -> q_pja2
                LET g_qryparam.default1 = g_sfb.sfb27
                CALL cl_create_qry() RETURNING g_sfb.sfb27
                DISPLAY BY NAME g_sfb.sfb27
                NEXT FIELD sfb27
             END IF
             IF INFIELD(sfb271) THEN
                CALL cl_init_qry_var()
                LET g_qryparam.form     = "q_pjb4"   #FUN-810045
                LET g_qryparam.default1 = g_sfb.sfb271
                LET g_qryparam.arg1     = g_sfb.sfb27
                CALL cl_create_qry() RETURNING g_sfb.sfb271
                DISPLAY BY NAME g_sfb.sfb271
                NEXT FIELD sfb271
             END IF
             IF INFIELD(sfb50) THEN #活動
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_pjk3"
                  LET g_qryparam.arg1 = g_sfb.sfb271
                  CALL cl_create_qry() RETURNING g_sfb.sfb50
                  DISPLAY BY NAME g_sfb.sfb50
                  NEXT FIELD sfb50
             END IF
             IF INFIELD(sfb51) THEN  #理由碼
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf"
                  LET g_qryparam.arg1 = '2'
                  CALL cl_create_qry() RETURNING g_sfb.sfb51
                  DISPLAY BY NAME g_sfb.sfb51
                  NEXT FIELD sfb51
             END IF

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

    END INPUT
    CLOSE WINDOW i3011_w

    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF

    UPDATE sfb_file SET * = g_sfb.* WHERE sfb01 = g_sfb.sfb01
    IF SQLCA.SQLCODE THEN
       CALL cl_err3("upd","sfb_file",g_sfb_t.sfb01,"",SQLCA.sqlcode,"","update sfb",1)  #No.FUN-660128
    #FUN-960025 ADD --STR-------------------------------
    ELSE
       IF g_sfb.sfb02='7' AND g_sfb.sfb41='Y' THEN
          UPDATE vnf_file SET vnf03 = '2'
           WHERE vnf01 = g_sfb.sfb01
       ELSE
          IF g_sfb.sfb02='7' AND (g_sfb.sfb41='N' OR g_sfb.sfb41 IS NULL) THEN
             UPDATE vnf_file SET vnf03 = '1'
              WHERE vnf01 = g_sfb.sfb01
          END IF
       END IF
    #FUN-960025 ADD --END-------------------------------
    END IF

END FUNCTION

FUNCTION i301_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_sfb.* TO NULL               #No.FUN-6A0164
    CALL cl_opmsg('q')
    CALL cl_msg("")    #FUN-8C0081 add  MESSAGE改為cl_msg寫法
    DISPLAY '   ' TO FORMONLY.cnt
    CALL i301_cs()
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       INITIALIZE g_sfb.* TO NULL
       RETURN
    END IF
    CALL cl_msg(" SEARCHING ! ")   #FUN-8C0081 add MESSAGE改為cl_msg寫法
    OPEN i301_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_sfb.* TO NULL
    ELSE
        OPEN i301_count
        FETCH i301_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL i301_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
    CALL cl_msg("")    #FUN-8C0081 add  MESSAGE改為cl_msg寫法
END FUNCTION

FUNCTION i301_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,                 #處理方式  #No.FUN-680121 VARCHAR(1)
    l_abso          LIKE type_file.num10                 #絕對的筆數  #No.FUN-680121 INTEGER

    CASE p_flag
        WHEN 'N' FETCH NEXT     i301_cs INTO g_sfb.sfb01
        WHEN 'P' FETCH PREVIOUS i301_cs INTO g_sfb.sfb01
        WHEN 'F' FETCH FIRST    i301_cs INTO g_sfb.sfb01
        WHEN 'L' FETCH LAST     i301_cs INTO g_sfb.sfb01
        WHEN '/'
            IF (NOT g_no_ask) THEN
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
               PROMPT g_msg CLIPPED,': ' FOR g_jump
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()
               END PROMPT
               IF INT_FLAG THEN
                   LET INT_FLAG = 0
                   EXIT CASE
               END IF
            END IF
            FETCH ABSOLUTE g_jump i301_cs INTO g_sfb.sfb01
            LET g_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN
        CALL cl_err(g_sfb.sfb01,SQLCA.sqlcode,0)
        INITIALIZE g_sfb.* TO NULL  #TQC-6B0105
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
    SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01 = g_sfb.sfb01
    IF SQLCA.sqlcode THEN
        CALL cl_err3("sel","sfb_file",g_sfb.sfb01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660128
    ELSE
       LET g_data_owner = g_sfb.sfbuser      #FUN-4C0035
       LET g_data_group = g_sfb.sfbgrup      #FUN-4C0035
       LET g_data_plant = g_sfb.sfbplant #FUN-980030
       CALL i301_show()
    END IF
END FUNCTION

FUNCTION i301_show()
   DEFINE l_smydesc LIKE smy_file.smydesc  #MOD-4C0010
   DEFINE l_sfv35s  LIKE sfv_file.sfv35

    LET g_sfb_t.* = g_sfb.*                #保存單頭舊值
    DISPLAY BY NAME g_sfb.sfboriu,g_sfb.sfborig,
        g_sfb.sfb01,g_sfb.sfb101,g_sfb.sfb44,g_sfb.sfb81,g_sfb.sfb02,g_sfb.sfb39,    #FUN-8C0081 add sfb44
        g_sfb.sfb87,g_sfb.sfb04,g_sfb.sfb28,g_sfb.sfb38,
        g_sfb.sfbmksg,g_sfb.sfb43,g_sfb.sfb98,                                       #FUN-8C0081 add sfbmksg,sfb43
        g_sfb.sfb82,g_sfb.sfb102,g_sfb.sfb22,g_sfb.sfb221,g_sfb.sfb91,g_sfb.sfb92,  #TQC-740056 add sfb102
        g_sfb.sfb86,g_sfb.sfb89,g_sfb.sfb05,g_sfb.sfb08,g_sfb.sfb07,g_sfb.sfb95,  #No.TQC-610003 #FUN-C30114 sfb89
       #g_sfb.sfb071,g_sfb.sfb06,g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb25,                         #FUN-9A0029 mark
        g_sfb.sfb071,g_sfb.sfb06,g_sfb.sfb13,g_sfb.sfb14,g_sfb.sfb15,g_sfb.sfb16,g_sfb.sfb25, #FUN-9A0029 add
        g_sfb.sfb081,g_sfb.sfb09,g_sfb.sfb12,g_sfb.sfb23,
        g_sfb.sfb24,g_sfb.sfb41,g_sfb.sfb99,g_sfb.sfb93,g_sfb.sfb94,g_sfb.sfb104,     #FUN-A20048 add sfb104
        g_sfb.sfb100,g_sfb.sfb34,g_sfb.sfb40,g_sfb.sfb97,g_sfb.sfb96, #CHI-970012 add sfb96
        g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51,g_sfb.sfb30, #FUN-810045 add sfb50/51
        g_sfb.sfb31,g_sfb.sfb32,g_sfb.sfb33,g_sfb.sfb222,
        g_sfb.sfb1001,g_sfb.sfb1002,g_sfb.sfb1003,   #FUN-6A0007
        g_sfb.sfbuser, g_sfb.sfbgrup, g_sfb.sfbmodu, g_sfb.sfbdate,
        g_sfb.sfbacti,g_sfb.sfb36,g_sfb.sfb37, #No.FUN-6B0093 add sfb36 sfb37
        g_sfb.sfb103,g_sfb.sfb85,g_sfb.sfb919                 #No.FUN-810017  #FUN-A80102

      ,g_sfb.sfbud01,g_sfb.sfbud02,g_sfb.sfbud03,g_sfb.sfbud04,
       g_sfb.sfbud05,g_sfb.sfbud06,g_sfb.sfbud07,g_sfb.sfbud08,
       g_sfb.sfbud09,g_sfb.sfbud10,g_sfb.sfbud11,g_sfb.sfbud12,
       g_sfb.sfbud13,g_sfb.sfbud14,g_sfb.sfbud15
      ,g_sfb.ta_sfb34,g_sfb.ta_sfb38,g_sfb.ta_sfb35,g_sfb.ta_sfb43,g_sfb.ta_sfb44,g_sfb.ta_sfb45
      ,g_sfb.ta_sfb37      #zangheng20170921aps

    LET g_buf = s_get_doc_no(g_sfb.sfb01)       #No.FUN-550067
    IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN   #NO:7075
       SELECT MAX(pmn01) INTO g_pmn01 FROM pmn_file WHERE pmn41=g_sfb.sfb01
       #No.B356 避免有單頭無單身之採購單存在
       IF cl_null(g_pmn01) THEN
          SELECT pmm01 INTO g_pmn01
            FROM pmm_file WHERE pmm01=g_sfb.sfb01 AND pmm18 <> 'X'
       END IF
       DISPLAY g_pmn01 TO smydesc
       IF cl_null(g_pmn01) THEN
          SELECT smydesc INTO l_smydesc FROM smy_file WHERE smyslip = g_buf
          DISPLAY l_smydesc TO smydesc
          LET g_buf = NULL
       END IF
    ELSE
       SELECT smydesc INTO l_smydesc FROM smy_file WHERE smyslip=g_buf
       DISPLAY l_smydesc TO smydesc LET g_buf = NULL
    END IF
    SELECT SUM(sfv35) INTO l_sfv35s FROM sfv_file,sfu_file WHERE sfv11=g_sfb.sfb01 AND sfv01=sfu01 AND sfuconf='Y' AND sfupost='Y'
    DISPLAY l_sfv35s TO sfv35s
    CALL i301_show2()
    CALL i301_pic()  #圖形顯示   #FUN-730012
    CALL i301_b_fill(g_wc2)
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION

FUNCTION i301_show2()
  DEFINE l_gen02 LIKE gen_file.gen02  #FUN-8C0081 add

    INITIALIZE g_ima.* TO NULL
    SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_sfb.sfb05
     IF g_sfb.sfb02 = '15' THEN
        LET l_n = 0
        SELECT COUNT(ima01) INTO l_n FROM ima_file
         WHERE ima01 = g_sfb.sfb05
        IF l_n = 0 THEN
           SELECT bmq02,bmq021,bmq55 INTO g_ima.ima02,g_ima.ima021,g_ima.ima55
             FROM bmq_file
            WHERE bmq01 = g_sfb.sfb05
        ELSE
           SELECT ima02,ima021,ima55 INTO g_ima.ima02,g_ima.ima021,g_ima.ima55
             FROM ima_file
            WHERE ima01 = g_sfb.sfb05
        END IF
     END IF

    SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01 = g_sfb.sfb44  #FUN-8C0081 add
    DISPLAY l_gen02 TO gen02           #FUN-8C0081 add
    DISPLAY BY NAME g_ima.ima02,g_ima.ima55
    DISPLAY BY NAME g_ima.ima021
    LET g_buf=NULL
    IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN   #NO:7075
       SELECT pmc03 INTO g_buf FROM pmc_file WHERE pmc01=g_sfb.sfb82
     ELSE
       SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_sfb.sfb82
    END IF
    DISPLAY s_costcenter_desc(g_sfb.sfb98) TO gem02 #FUN-670103
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
    DISPLAY g_buf TO pmc03
    LET g_buf=NULL #CHI-840001

    SELECT pja02 INTO g_buf FROM pja_file WHERE pja01 = g_sfb.sfb27
    DISPLAY g_buf TO FORMONLY.pja02
    LET g_buf=NULL #CHI-840001
    SELECT pjb03 INTO g_buf FROM pjb_file WHERE pjb02 = g_sfb.sfb271
    DISPLAY g_buf TO FORMONLY.pjb03
    LET g_buf=NULL #CHI-840001
    SELECT pjk03 INTO g_buf FROM pjk_file,pjj_file
     WHERE pjk01 = pjj01
       AND pjk02 = g_sfb.sfb50
       AND pjj04 = g_sfb.sfb27
    DISPLAY g_buf TO FORMONLY.pjk03
    LET g_buf=NULL #CHI-840001
    SELECT azf03 INTO g_buf FROM azf_file
     WHERE azf01 = g_sfb.sfb51  AND azf02 = '2'
    DISPLAY g_buf TO FORMONLY.azf03
END FUNCTION

FUNCTION i301_b(p_in)
   DEFINE l_ac_t          LIKE type_file.num5,      #未取消的ARRAY CNT  #No.FUN-680121 SMALLINT
          l_row,l_col     LIKE type_file.num5,      #No.FUN-680121 SMALLINT,              #分段輸入之行,列數
          l_n,l_cnt       LIKE type_file.num5,      #檢查重複用  #No.FUN-680121 SMALLINT
          l_cnt1          LIKE type_file.num5,      #CHI-710050 add
          l_lock_sw       LIKE type_file.chr1,      #單身鎖住否  #No.FUN-680121 VARCHAR(1)
          p_cmd,p_in      LIKE type_file.chr1,      #No.FUN-680121 VARCHAR(1),  #處理狀態
          l_sfa26         LIKE sfa_file.sfa26,      #No.MOD-5B0289 add
          l_qpa           LIKE sfa_file.sfa161,
          l_code          LIKE type_file.num5,      #No.FUN-680121 SMALLINT,
          l_allow_insert  LIKE type_file.num5,      #可新增否  #No.FUN-680121 SMALLINT
          l_allow_delete  LIKE type_file.num5,      #可刪除否  #No.FUN-680121 SMALLINT
          l_ima910        LIKE ima_file.ima910,     #FUN-550112
          l_sfb43         LIKE sfb_file.sfb43,      #FUN-8C0081 add
          l_sfa05         LIKE sfa_file.sfa05,
          l_ima64         LIKE ima_file.ima64,
          l_ima641        LIKE ima_file.ima641,
          l_gfe03         LIKE gfe_file.gfe03,
          l_double        LIKE type_file.num10,     #No.FUN-680121 INTEGER
          l_num_y         LIKE sfa_file.sfa05,      #No.TQC-760038
          l_num_z         LIKE type_file.num20,     #No.TQC-760038
          l_ecu014        LIKE ecu_file.ecu014,     #FUN-A50066
          l_bmb16         LIKE bmb_file.bmb16,      #FUN-A50066
          l_ima571        LIKE ima_file.ima571,     #MOD-AC0336
          l_flag          LIKE type_file.num5,      #MOD-AC0336
          l_tf            LIKE type_file.chr1,      #FUN-910088--add--
          l_sfaa          RECORD LIKE sfaa_file.*,  #FUN-C30274
          l_sfaa05        LIKE sfaa_file.sfaa05,    #FUN-C30274
          l_sfaa051       LIKE sfaa_file.sfaa051    #FUN-C30274
   DEFINE l_ima928        LIKE ima_file.ima928      #FUN-C30047
   DEFINE l_tc_sfa        RECORD LIKE tc_sfa_file.*

    LET g_action_choice = ""

    LET l_sfb43 = g_sfb.sfb43    #FUN-8C0081 add
    IF g_sfb.sfb01 IS NULL THEN RETURN END IF
    IF g_sfb.sfb04 = '8'   THEN CALL cl_err('','aap-730',0) RETURN END IF
    # MOD-580190 再確認一次確認碼
    SELECT sfb87 INTO g_sfb.sfb87 FROM sfb_file WHERE sfb01 = g_sfb.sfb01
    IF g_sfb.sfb87='Y' THEN CALL cl_err('','aap-086',1) RETURN END IF
    IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43='9' THEN
        CALL cl_err('','9024',0)
        RETURN
    END IF
    IF g_sfb.sfb43 MATCHES '[Ss]' THEN
       CALL cl_err('','apm-030',0)
       RETURN
    END IF
    IF g_sfb.sfb87='Y' AND g_sfb.sfb43='1' AND g_sfb.sfbmksg='Y' THEN
       CALL cl_err('','mfg3168',0)
       RETURN
    END IF

    SELECT COUNT(*) INTO l_n FROM pmm_file,pmn_file     #NO:6961
     WHERE pmm01=pmn01
       AND pmn41=g_sfb.sfb01
    IF l_n>0 THEN CALL cl_err('','asf-936',0) RETURN END IF         #NO:6961

    CALL cl_opmsg('b')

    LET g_forupd_sql = "SELECT * FROM sfa_file ",
                       " WHERE sfa01= ? AND sfa03= ? AND sfa08=? AND sfa12=? AND sfa27=? AND sfa012=? AND sfa013=?", #CHI-7B0034 #FUN-A50066
                       " FOR UPDATE"
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i301_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

   #IF g_rec_b=0 THEN CALL g_sfa.clear() END IF #MOD-BA0116
   #IF g_rec_b > 0 THEN LET l_ac = 1 END IF     #MOD-BA0116

    INPUT ARRAY g_sfa WITHOUT DEFAULTS FROM s_sfa.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

        BEFORE INPUT
            IF g_rec_b!=0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            LET g_before_input_done = FALSE
            CALL i301_set_entry_b('a')
            CALL i301_set_no_entry_b('a')
            LET g_before_input_done = TRUE
            #FUN-C30145---begin
            LET g_wo_cnt = 0
            SELECT COUNT(*) INTO g_wo_cnt
              FROM sfb_file
             WHERE sfb86 = g_sfb.sfb01
            #FUN-C30145---end
            #MOD-D30024---begin
            LET l_n  = ARR_COUNT()
            IF l_n = 0 THEN
               CALL g_sfa.clear()
            END IF
            #MOD-D30024---end
        BEFORE ROW
            LET p_cmd=''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN i301_cl USING g_sfb.sfb01
            IF STATUS THEN
               CALL cl_err("OPEN i301_cl:", STATUS, 1)
               CLOSE i301_cl
               ROLLBACK WORK
               RETURN
            END IF

            FETCH i301_cl INTO g_sfb.*          # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err('lock sfb:',SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE i301_cl
               ROLLBACK WORK
               RETURN
            END IF

            IF g_rec_b >= l_ac THEN
                LET p_cmd='u'
                LET g_sfa_t.* = g_sfa[l_ac].*         #BACKUP
                LET g_sfa_o.sfa161 = g_sfa[l_ac].sfa161   #MOD-CB0005
                LET g_sfa12_t = g_sfa[l_ac].sfa12     #FUN-910088--add--
                OPEN i301_bcl USING g_sfb.sfb01,g_sfa_t.sfa03,
                                    g_sfa_t.sfa08,g_sfa_t.sfa12,g_sfa_t.sfa27, #CHI-7B0034
                                    g_sfa_t.sfa012,g_sfa_t.sfa013  #FUN-A50066
                IF STATUS THEN
                   CALL cl_err("OPEN i301_bcl:", STATUS, 1)
                   LET l_lock_sw = "Y"
                ELSE
                   FETCH i301_bcl INTO b_sfa.*
                   IF SQLCA.sqlcode THEN
                       CALL cl_err('lock sfa',SQLCA.sqlcode,1)
                       LET l_lock_sw = "Y"
                   ELSE
                       SELECT mse02 INTO g_sfa[l_ac].mse02
                         FROM mse_file WHERE mse01=g_sfa[l_ac].sfa36
                       DISPLAY g_sfa[l_ac].mse02 TO FORMONLY.mse02
                       #MOD-AC0336--begin--add----
                       CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571
                       IF l_flag THEN
                       #MOD-AC0336--end--add----
                          LET l_ecu014=''                                  #FUN-A50066
                         #FUN-B10056 --------mod start---------
                         #SELECT ecu014 INTO l_ecu014 FROM ecu_file        #FUN-A50066
                         # WHERE ecu01=l_ima571 AND ecu02=g_sfb.sfb06 AND ecu012=b_sfa.sfa012 #FUN-A50066 #MOD-AC0336
                          CALL s_schdat_ecm014(g_sfb.sfb01,b_sfa.sfa012) RETURNING l_ecu014
                         #FUN-B10056 --------mod end------------
                          DISPLAY l_ecu014 TO FORMONLY.ecu014  #FUN-A50066
                      END IF  #MOD-AC0336
                      #TQC-C70115--add--str--
                      IF NOT cl_null(g_sfa[l_ac].sfa03) THEN
                         SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_sfa[l_ac].sfa03
                         IF STATUS THEN
                            CALL cl_err3("sel","ima_file",g_sfa[l_ac].sfa03,"",STATUS,"","s ima",1)
                         END IF
                      END IF
                      #TQC-C70115--add--end--
                      CALL i301_b_move_to()
                   END IF
                END IF
                CALL cl_show_fld_cont()     #FUN-550037(smin)
                CALL i301_set_entry_b(p_cmd)        #No.MOD-930247 add
                CALL i301_set_no_entry_b(p_cmd)     #No.MOD-930247 add
            END IF

        BEFORE INSERT
            IF g_sfb.sfb87='Y' AND p_in ='d' THEN
               CALL cl_err('','aap-086',1)
               RETURN
            ELSE
               INITIALIZE g_sfa_o.* TO NULL   #MOD-C90069 add
               LET l_n = ARR_COUNT()
               LET p_cmd='a'
               INITIALIZE g_sfa[l_ac].* TO NULL      #900423
               LET g_sfa29[l_ac]=NULL
               INITIALIZE g_sfa_t.* TO NULL
               LET g_sfa12_t = NULL                 #FUN-910088--add--
               LET g_sfa[l_ac].sfa26 = '0'          #MOD-930073 add
               LET b_sfa.sfa01=g_sfb.sfb01
               LET g_sfa[l_ac].sfa08 =' '
               LET g_sfa[l_ac].sfa012=' '  #FUN-A50066
               LET g_sfa[l_ac].sfa013=0    #FUN-A50066
               LET g_sfa[l_ac].sfa28 =1
               LET b_sfa.sfa16       =0
               LET g_sfa[l_ac].sfa161=0
               LET g_sfa[l_ac].sfa05 =0
               LET g_sfa[l_ac].sfa06 =0
               LET g_sfa[l_ac].short_qty=0  #FUN-940008 add
               LET b_sfa.sfa061      =0
               LET g_sfa[l_ac].sfa062=0
               LET g_sfa[l_ac].sfa063=0
               LET g_sfa[l_ac].sfa064=0
               LET g_sfa[l_ac].sfa065=0
               LET g_sfa[l_ac].sfa100=0 #No:8595
               LET b_sfa.sfa066      =0
               LET b_sfa.sfa25       =0
               LET g_sfa[l_ac].sfa11 ='N'
               IF g_sfb.sfb39='2' THEN
                  LET b_sfa.sfa11 ='E'
                  LET g_sfa[l_ac].sfa11='E'
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)
               IF g_sma.sma542 = 'Y' AND g_sfb.sfb93 = 'Y' THEN  #FUN-A50066
                  NEXT FIELD sfa012
               ELSE   #FUN-A50066
                  NEXT FIELD sfa27
               END IF    #FUN-A50066
            END IF

        AFTER INSERT

            IF INT_FLAG THEN
               CALL cl_err('',9001,1)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            CALL i301_b_move_back()
            CALL i301_b_else()
           #MOD-AA0160---mark---start---
           #LET l_cnt = 0
           #SELECT COUNT(*) INTO l_cnt FROM sfa_file
           # WHERE sfa01 = g_sfb.sfb01
           #   AND sfa03 = g_sfa[l_ac].sfa03
           #   AND sfa012 = g_sfa[l_ac].sfa012  #FUN-A50066
           #   AND sfa013 = g_sfa[l_ac].sfa013  #FUN-A50066
           #IF l_cnt > 0 THEN
           #   CALL cl_err(g_sfa[l_ac].sfa03,'asf-595',1)
           #   CANCEL INSERT
           #END IF
           #MOD-AA0160---mark---end---
            IF g_sfa[l_ac].sfa03 IS NULL THEN
                INITIALIZE g_sfa[l_ac].* TO NULL  #重要欄位空白,無效
                LET g_sfa29[l_ac]=NULL
            END IF

            IF g_sfa[l_ac].sfa26 MATCHES '[0123456T78]' THEN   #FUN-A20037 add '7,8'
               LET g_sfa[l_ac].sfa03=g_sfa[l_ac].sfa27
               LET b_sfa.sfa03=b_sfa.sfa27
            END IF

            IF cl_null(b_sfa.sfa100) THEN
               LET b_sfa.sfa100 = 0
            END IF

            IF cl_null(b_sfa.sfa04) THEN
               LET b_sfa.sfa04 = 0
            END IF
#TQC-A50141 --add
            IF cl_null(b_sfa.sfa012) THEN
               LET b_sfa.sfa012 = ' '   #FUN-A50066
            END IF
            IF cl_null(b_sfa.sfa013) THEN
               LET b_sfa.sfa013 = 0
            END IF
#TQC-A50141 --end
            INSERT INTO sfa_file VALUES(b_sfa.*)
            IF SQLCA.sqlcode THEN
               CALL cl_err3("ins","sfa_file",b_sfa.sfa01,b_sfa.sfa03,SQLCA.sqlcode,"","ins sfa",1)  #No.FUN-660128
               CANCEL INSERT
            ELSE
                #add by lanhang 140107 begin
                LET l_tc_sfa.tc_sfa01=b_sfa.sfa01
                LET l_tc_sfa.tc_sfa02=b_sfa.sfa03
                LET l_tc_sfa.tc_sfa03=b_sfa.sfa08
                SELECT MAX(tc_sfa04)+1 INTO l_tc_sfa.tc_sfa04
                  FROM tc_sfa_file
                 WHERE tc_sfa01=l_tc_sfa.tc_sfa01
                   AND tc_sfa02=l_tc_sfa.tc_sfa02
                   AND tc_sfa03=l_tc_sfa.tc_sfa03
                IF cl_null(l_tc_sfa.tc_sfa04) THEN LET l_tc_sfa.tc_sfa04=1 END IF
                LET l_tc_sfa.tc_sfa05=b_sfa.sfa12
                LET l_tc_sfa.tc_sfa06=b_sfa.sfa05
                LET l_tc_sfa.tc_sfa07=b_sfa.sfaud02
                LET l_tc_sfa.tc_sfa08=b_sfa.sfaud07
                LET l_tc_sfa.tc_sfa09=b_sfa.sfaud03
                LET l_tc_sfa.tc_sfa10=b_sfa.sfaud04
                LET l_tc_sfa.tc_sfa11=''
                LET l_tc_sfa.tc_sfa12=b_sfa.sfa16
                LET l_tc_sfa.tc_sfa13=b_sfa.sfa161
                LET l_tc_sfa.tc_sfa14=b_sfa.sfaud05
                INSERT INTO tc_sfa_file VALUES(l_tc_sfa.*)
                #add by lanhang 140107 end
               CALL i301_bu()
               IF g_success = 'Y' THEN
                  LET l_sfb43 = '0'    #FUN-8C0081 add
                  COMMIT WORK
                  MESSAGE 'INSERT O.K'
                  LET g_rec_b=g_rec_b+1
                  DISPLAY g_rec_b TO FORMONLY.cn2
               ELSE
                  ROLLBACK WORK
               END IF

            END IF


#FUN-A50066--begin--add-----
        AFTER FIELD sfa012
            IF NOT cl_null(g_sfa[l_ac].sfa012) THEN
               LET l_cnt = 0
               CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571 #MOD-AC0336
              #FUN-B10056 -----------mod start---------
              #SELECT COUNT(*) INTO l_cnt FROM ecu_file,ecb_file
              # WHERE ecu01=ecb01 AND ecu02=ecb02
              #   AND ecu012 = ecb012
              #   AND ecu10 = 'Y' AND ecuacti = 'Y'
              #  #AND ecb01=g_sfb.sfb05  #MOD-AC0336
              #   AND ecb01=l_ima571     #MOD-AC0336
              #   AND ecb02=g_sfb.sfb06
              #   AND ecb012 = g_sfa[l_ac].sfa012
              #IF l_cnt = 0 THEN
              #   CALL cl_err('','abm-214',1)
              #   LET g_sfa[l_ac].sfa012=''
              #   LET g_sfa[l_ac].sfa013=''
              #   NEXT FIELD sfa012
              #END IF
              #CALL i301_sfa012()
              #IF NOT cl_null(g_errno) THEN
              #   CALL cl_err('',g_errno,0)
              #   LET g_sfa[l_ac].sfa012=g_sfa_t.sfa012
              #   DISPLAY BY NAME g_sfa[l_ac].sfa012
              #   NEXT FIELD sfa012
              #END IF
               IF NOT s_schdat_ecm012(g_sfb.sfb01,g_sfa[l_ac].sfa012) THEN
                  CALL cl_err('','abm-214',1)
                  LET g_sfa[l_ac].sfa012=''
                  LET g_sfa[l_ac].sfa013=''
                  NEXT FIELD sfa012
               END IF
               CALL s_schdat_ecm014(g_sfb.sfb01,g_sfa[l_ac].sfa012) RETURNING g_sfa[l_ac].ecu014
              #FUN-B10056 ------- mod end-----------
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM bra_file
                WHERE bra01=g_sfb.sfb05
                  AND bra011=g_sfb.sfb06
                  AND bra012=g_sfa[l_ac].sfa012
               IF l_cnt = 0 THEN
                  IF g_sma.sma887[1]='Y' THEN
                     CALL cl_err('sel bom:','asf-136',1)
                     NEXT FIELD sfa012
                  END IF
                  IF g_sma.sma887[1]='W' THEN
                     IF NOT cl_confirm('asf-137') THEN
                        NEXT FIELD sfa012
                     END IF
                  END IF
               END IF
               CALL i301_sfa08()
               IF NOT cl_null(g_sfa[l_ac].sfa013) THEN #FUN-B30017
                  CALL i301_sel_sfa08()                #FUN-B30017
               END IF                                  #FUN-B30017
            END IF

        AFTER FIELD sfa013
            IF NOT cl_null(g_sfa[l_ac].sfa013) THEN
               CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571 #MOD-AC0336
               LET l_cnt = 0
              #FUN-B10056 ------------mod start---------
              #SELECT COUNT(*) INTO l_cnt FROM ecu_file,ecb_file
              # WHERE ecu01=ecb01 AND ecu02=ecb02
              #   AND ecu012 = ecb012
              #   AND ecu10 = 'Y' AND ecuacti = 'Y'
              #   AND ecb01=l_ima571  #MOD-AC0336
              #   AND ecb02=g_sfb.sfb06
              #   AND ecb012 = g_sfa[l_ac].sfa012
              #   AND ecb03  = g_sfa[l_ac].sfa013
              #IF l_cnt = 0 THEN
              #   CALL cl_err('','abm-215',1)
              #   LET g_sfa[l_ac].sfa012=''
              #   LET g_sfa[l_ac].sfa013=''
              #   NEXT FIELD sfa013
              #END IF
               SELECT COUNT(*) INTO l_cnt FROM ecm_file
                WHERE ecm01 = g_sfb.sfb01
                  AND ecm012 = g_sfa[l_ac].sfa012
                  AND ecm03 = g_sfa[l_ac].sfa013
               IF l_cnt = 0 THEN
                  CALL cl_err('','abm-215',1)
                  LET g_sfa[l_ac].sfa012=''
                  LET g_sfa[l_ac].sfa013=''
               END IF
              #FUN-B10056 ----------mod end------------
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt FROM bra_file
                WHERE bra01=g_sfb.sfb05
                  AND bra011=g_sfb.sfb06
                  AND bra012=g_sfa[l_ac].sfa012
                  AND bra013=g_sfa[l_ac].sfa013
               IF l_cnt = 0 THEN
                  IF g_sma.sma887[1]='Y' THEN
                     CALL cl_err('sel bom:','asf-136',1)
                     NEXT FIELD sfa013
                  END IF
                  IF g_sma.sma887[1]='W' THEN
                     IF NOT cl_confirm('asf-137') THEN
                        NEXT FIELD sfa013
                     END IF
                  END IF
               END IF
               CALL i301_sfa08()
               CALL i301_sel_sfa08()  #FUN-B30017
            END IF
#FUN-A50066--begin--add----------

        AFTER FIELD sfa27
            LET l_tf = NULL  #FUN-910088 add
            IF NOT cl_null(g_sfa[l_ac].sfa27) THEN
#FUN-AA0059 ---------------------start----------------------------
               IF g_sfb.sfb02 <> 15 THEN                               #FUN-AB0025
                  IF NOT s_chk_item_no(g_sfa[l_ac].sfa27,"") THEN
                     CALL cl_err('',g_errno,1)
                     LET g_sfa[l_ac].sfa27= g_sfa_t.sfa27
                     NEXT FIELD sfa27
                  END IF
                  #FUN-C30047---begin
                  LET l_ima928 = 'N'
                  SELECT ima928 INTO l_ima928 FROM ima_file
                   WHERE ima01 = g_sfa[l_ac].sfa27
                  IF l_ima928 = 'Y' THEN
                     CALL cl_err('','ima-001',1)
                     LET g_sfa[l_ac].sfa27= g_sfa_t.sfa27
                     NEXT FIELD sfa27
                  END IF
                  #FUN-C30047---end
               END IF                                                  #FUN-AB0025
#FUN-AA0059 ---------------------end-------------------------------
               SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_sfa[l_ac].sfa27
               IF STATUS THEN
                  CALL cl_err3("sel","ima_file",g_sfa[l_ac].sfa27,"",STATUS,"","sel ima",1)  #No.FUN-660128
                  NEXT FIELD sfa27
               ELSE
                  LET g_sfa[l_ac].ima02_b=g_ima.ima02
                  LET g_sfa[l_ac].ima021_b=g_ima.ima021
                  LET g_sfa[l_ac].ima08_b=g_ima.ima08
                  DISPLAY BY NAME g_sfa[l_ac].ima02_b
                  DISPLAY BY NAME g_sfa[l_ac].ima021_b
                  DISPLAY BY NAME g_sfa[l_ac].ima08_b
               END IF
               #拆件式工单,单身发的料号要与单头相同
               IF g_sfb.sfb02 = '11' THEN
                  IF g_sfa[l_ac].sfa27 <> g_sfb.sfb05 THEN
                     CALL cl_err(g_sfa[l_ac].sfa27,'asf-170',1)
                     NEXT FIELD sfa27
                  END IF
               END IF

              #-------------------No:MOD-A10017 mark
              #IF g_sfa[l_ac].sfa11 != 'X' THEN     #CHI-980013
              #   IF g_ima.ima70='Y' THEN
              #      LET g_sfa[l_ac].sfa11 ='E'
              #      DISPLAY BY NAME g_sfa[l_ac].sfa11      #No:TQC-680110 add
              #   #FUN-580165...............begin
              #   ELSE
              #     IF g_sfb.sfb39 != '2' THEN    #No:MOD-7A0097 add
              #        LET g_sfa[l_ac].sfa11 ='N'
              #        DISPLAY BY NAME g_sfa[l_ac].sfa11
              #      END IF                        #No:MOD-7A0097 add
              #   END IF
              #   #FUN-580165...............end
              #END IF                              #CHI-980013
              #-------------------No:MOD-A10017 end
               #FUN-A50066--begin--add----------
               IF g_sma.sma542 = 'Y' AND g_sfb.sfb93='Y' THEN
                  INITIALIZE g_bmb.* TO NULL
                  DECLARE i301_brb_c CURSOR FOR
                     SELECT brb01,brb02,brb03,brb04,brb05,brb06,brb07,brb08,brb09,brb10,
                            brb10_fac,brb10_fac2,brb11,brb13,brb14,brb15,brb16,brb17,brb18,
                            brb19,brb20,brb21,brb22,brb23,brb24,brb25,brb26,brb27,brb28,
                            brbmodu,brbdate,brbcomm,brb29,brb30,brb31,brb33,'','','','',
                            '','','','','','','','','','','',brb081,brb082 FROM brb_file
                         WHERE brb01=g_sfb.sfb05
                           AND brb29=g_sfb.sfb95
                           AND brb03=g_sfa[l_ac].sfa27
                           AND brb011=g_sfb.sfb06
                           AND brb012=g_sfa[l_ac].sfa012
                           AND brb013=g_sfa[l_ac].sfa013
                           AND (brb04<=g_sfb.sfb071 OR brb04 IS NULL)
                           AND (g_sfb.sfb071<brb05 OR brb05 IS NULL)

                  FOREACH i301_brb_c INTO g_bmb.*
                     IF STATUS THEN
                        CALL cl_err('for brb:',STATUS,1)
                        EXIT FOREACH
                     END IF
                     EXIT FOREACH  # 僅讀取第一筆
                  END FOREACH
                  DECLARE i301_bmb16_c CURSOR FOR
                     SELECT bmb16 FROM bmb_file
                         WHERE bmb01=g_sfb.sfb05
                           AND bmb29=g_sfb.sfb95
                           AND bmb03=g_sfa[l_ac].sfa27
                           AND (bmb04<=g_sfb.sfb071 OR bmb04 IS NULL)
                           AND (g_sfb.sfb071<bmb05 OR bmb05 IS NULL)

                  FOREACH i301_bmb16_c INTO g_bmb.bmb16
                     IF STATUS THEN
                        CALL cl_err('sel bmb16:',STATUS,1)
                        EXIT FOREACH
                     END IF
                     LET l_bmb16 = g_bmb.bmb16
                     EXIT FOREACH  # 僅讀取第一筆
                  END FOREACH
               ELSE
               #FUN-A50066--end--add-----------
                  INITIALIZE g_bmb.* TO NULL
                  DECLARE i301_bmb_c CURSOR FOR
                     SELECT * FROM bmb_file         #7130
                         WHERE bmb01=g_sfb.sfb05
                           AND bmb29=g_sfb.sfb95  #No.MOD-640245 add
                           AND bmb03=g_sfa[l_ac].sfa27
                           AND (bmb04<=g_sfb.sfb071 OR bmb04 IS NULL)
                           AND (g_sfb.sfb071<bmb05 OR bmb05 IS NULL)

                  FOREACH i301_bmb_c INTO g_bmb.*
                     IF STATUS THEN
                        CALL cl_err('for bmb:',STATUS,1)
                        EXIT FOREACH
                     END IF
                     EXIT FOREACH  # 僅讀取第一筆
                  END FOREACH
               END IF   #FUN-A50066
               ##No.2707 modify 1998/11/04 檢查是否存在BOM中
                IF (cl_null(g_bmb.bmb03))  #FUN-580165
                  AND (g_sfb.sfb02 NOT MATCHES '[58]')  THEN     #bugno:6009 add check NO:7075 add (g_sfb.sfb02!=8)
                  IF g_sfb.sfb02=15 THEN
                     CALL s_ebomchk(g_sfb.sfb05,g_sfa[l_ac].sfa27,g_sfb.sfb07)
                        RETURNING g_bmb.*,g_errno
                  ELSE
                    #FUN-A50066--begin--add---------------------
                    IF g_sma.sma542 = 'Y' AND g_sfb.sfb93 = 'Y' THEN  #TQC-B70126
                       CALL s_check_muti_bom_brb(g_sfb.sfb05,g_sfa[l_ac].sfa27,g_sfb.sfb071,
                                          g_sfb.sfb95,g_sfb.sfb06,g_sfa[l_ac].sfa012,g_sfa[l_ac].sfa013)
                            RETURNING g_brb.*,g_errno
                            LET g_bmb.bmb01 = g_brb.brb01  LET g_bmb.bmb03=g_brb.brb03
                            LET g_bmb.bmb06 = g_brb.brb06  LET g_bmb.bmb07=g_brb.brb07
                            LET g_bmb.bmb08 = g_brb.brb08  LET g_bmb.bmb10=g_brb.brb10
                            LET g_bmb.bmb10_fac = g_brb.brb10_fac  LET g_bmb.bmb15 = g_brb.brb15
                            LET g_bmb.bmb28 = g_brb.brb28  LET g_bmb.bmb16 = l_bmb16
                    ELSE
                    #FUN-A50066--end--add-------------------------
                       CALL s_check_muti_bom(g_sfb.sfb05,g_sfa[l_ac].sfa27,
                                             g_sfb.sfb071,g_sfb.sfb95)
                         RETURNING g_bmb.*,g_errno
                    END IF
                  END IF
               ELSE
                  LET g_errno = ''
               END IF
               LET l_n=0
               IF g_sfb.sfb22 IS NOT NULL THEN
                  SELECT COUNT(*) INTO l_n FROM oeo_file
                    WHERE oeo01=g_sfb.sfb22 AND oeo03=g_sfb.sfb221
                      AND oeo04=g_sfa[l_ac].sfa27
                      AND oeo08='1' #no.7168
               END IF
               IF g_sfb.sfb02<>5 AND g_sfb.sfb02<>11 AND g_sfb.sfb02<>8  #NO:7075 add g_sfb.sfb02<>8
                        AND g_sfb.sfb02 <>15                   #No.TQC-750023 add g_sfb.sfb02<>15
                  AND g_bmb.bmb01 IS NULL AND l_n=0 THEN
                  IF g_sma.sma887[1]='Y' THEN
                     CALL cl_err('sel bom:','mfg2631',1)
                     NEXT FIELD sfa27
                  END IF
                  IF g_sma.sma887[1]='W' THEN
                     IF NOT cl_confirm('mfg2632') THEN
                  NEXT FIELD sfa27
                     END IF
                  END IF
               END IF
              #-------------------No:MOD-A10017 end
               IF p_cmd='a' OR (p_cmd='u' AND g_sfa_t.sfa11 !=g_sfa[l_ac].sfa11) THEN  #TQC-BC0072
               IF g_sfa[l_ac].sfa11 != 'X' AND g_sfa[l_ac].sfa11 != 'S' #FUN-9C0040
                  AND g_sfa[l_ac].sfa11 != 'C' THEN    #FUN-A30093
                  IF cl_null(g_bmb.bmb15) THEN
                     IF g_ima.ima70='Y' THEN
                        LET g_sfa[l_ac].sfa11 = 'E'
                     ELSE
                        LET g_sfa[l_ac].sfa11 = 'N'
                     END IF
                  ELSE
                     IF g_bmb.bmb15='Y' THEN
                        LET g_sfa[l_ac].sfa11 = 'E'
                     ELSE
                        LET g_sfa[l_ac].sfa11 = 'N'
                     END IF
                  END IF
                  IF g_sfb.sfb39 = '2' THEN LET g_sfa[l_ac].sfa11='E' END IF
               END IF
               END IF
               DISPLAY BY NAME g_sfa[l_ac].sfa11
              #-------------------No:MOD-A10017 end
               #IF g_sfa[l_ac].sfa26 IS NULL AND g_bmb.bmb16 IS NOT NULL THEN  #MOD-A50106 mark
               IF (g_sfa[l_ac].sfa26 IS NULL OR g_sfa[l_ac].sfa27 != g_sfa_t.sfa27 )
                  AND g_bmb.bmb16 IS NOT NULL THEN             #MOD-A50106 mod
                  LET g_sfa[l_ac].sfa26 = g_bmb.bmb16
                  LET b_sfa.sfa16       = g_bmb.bmb06/g_bmb.bmb07*
                        (1+g_bmb.bmb08/100)
                  LET g_sfa[l_ac].sfa161= b_sfa.sfa16
                  LET g_sfa[l_ac].sfa12 = g_bmb.bmb10
                  LET g_sfa[l_ac].sfa13 = g_bmb.bmb10_fac
                  LET g_sfa[l_ac].sfa100= g_bmb.bmb28
                  DISPLAY BY NAME g_sfa[l_ac].sfa26
                  DISPLAY BY NAME g_sfa[l_ac].sfa161
                  DISPLAY BY NAME g_sfa[l_ac].sfa12
                  DISPLAY BY NAME g_sfa[l_ac].sfa13
                  DISPLAY BY NAME g_sfa[l_ac].sfa100
              #FUN-910088--add--start--
                  LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa06 = s_digqty(g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa062 = s_digqty(g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa063 = s_digqty(g_sfa[l_ac].sfa063,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa064 = s_digqty(g_sfa[l_ac].sfa064,g_sfa[l_ac].sfa12)
                  DISPLAY BY NAME g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa063,
                                  g_sfa[l_ac].sfa064
                  IF g_sfb.sfb02 NOT MATCHES '[78]' AND NOT g_before_input_done THEN
                     LET g_sfa[l_ac].sfa065 = s_digqty(g_sfa[l_ac].sfa065,g_sfa[l_ac].sfa12)
                     DISPLAY BY NAME g_sfa[l_ac].sfa065
                  ELSE
                     IF NOT cl_null(g_sfa[l_ac].sfa065) AND g_sfa[l_ac].sfa065 <> 0 THEN
                        CALL i301_sfa065_check() RETURNING l_tf
                        LET g_sfa12_t = g_sfa[l_ac].sfa12
                     END IF
                  END IF
              #FUN-910088--add--end--
               END IF
               #IF g_sfa[l_ac].sfa12 IS NULL THEN                                       #MOD-A50106 mark
               IF g_sfa[l_ac].sfa12 IS NULL OR g_sfa[l_ac].sfa27 != g_sfa_t.sfa27 THEN  #MOD-A50106 mod
                  LET g_sfa[l_ac].sfa12 = g_ima.ima63
                  LET g_sfa[l_ac].sfa13 = g_ima.ima63_fac
                  DISPLAY BY NAME g_sfa[l_ac].sfa12
                  DISPLAY BY NAME g_sfa[l_ac].sfa13
              #FUN-910088--add--start--
                  LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa06 = s_digqty(g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa062 = s_digqty(g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa063 = s_digqty(g_sfa[l_ac].sfa063,g_sfa[l_ac].sfa12)
                  LET g_sfa[l_ac].sfa064 = s_digqty(g_sfa[l_ac].sfa064,g_sfa[l_ac].sfa12)
                  DISPLAY BY NAME g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa063,
                                  g_sfa[l_ac].sfa064
                  IF g_sfb.sfb02 NOT MATCHES '[78]' AND NOT g_before_input_done THEN
                     LET g_sfa[l_ac].sfa065 = s_digqty(g_sfa[l_ac].sfa065,g_sfa[l_ac].sfa12)
                     DISPLAY BY NAME g_sfa[l_ac].sfa065
                  ELSE
                     IF NOT cl_null(g_sfa[l_ac].sfa065) AND g_sfa[l_ac].sfa065 <> 0 THEN
                        CALL i301_sfa065_check() RETURNING l_tf
                        LET g_sfa12_t = g_sfa[l_ac].sfa12
                     END IF
                  END IF
              #FUN-910088--add--end--
               END IF
               IF cl_null(g_sfa[l_ac].sfa03) THEN
                  LET g_sfa[l_ac].sfa03 = g_sfa[l_ac].sfa27
                  DISPLAY g_sfa[l_ac].sfa03 TO sfa03
               END IF
              #IF (g_sfa[l_ac].sfa26='0') THEN                #MOD-B20027 mark
               IF g_sfa[l_ac].sfa26 MATCHES '[0123456]' THEN  #MOD-B20027 add
                  LET g_sfa[l_ac].sfa03=g_sfa[l_ac].sfa27
                 #MOD-B20027---add---start---
                  SELECT * INTO g_ima.* FROM ima_file
                   WHERE ima01=g_sfa[l_ac].sfa03
                  IF STATUS THEN
                     CALL cl_err3("sel","ima_file",g_sfa[l_ac].sfa03,"",STATUS,"","sel ima",1)
                     NEXT FIELD sfa27
                  END IF
                  LET g_sfa[l_ac].ima02_b = g_ima.ima02
                  LET g_sfa[l_ac].ima08_b = g_ima.ima08
                  LET g_sfa[l_ac].ima021_b = g_ima.ima021
                 #MOD-B20027---add---end---
                  DISPLAY BY NAME g_sfa[l_ac].sfa03
               END IF
            END IF
       #FUN-910088--add--start--
            IF NOT l_tf  THEN
               NEXT FIELD sfa065
            END IF
       #FUN-910088--add--end--

    AFTER FIELD sfa08
        IF NOT cl_null(g_sfa[l_ac].sfa08) THEN
           SELECT COUNT(*) INTO g_cnt FROM ecd_file
      WHERE ecd01=g_sfa[l_ac].sfa08
           IF g_cnt=0 THEN
        CALL cl_err('sel ecd_file',100,0)
        NEXT FIELD sfa08
           END IF
        END IF
        IF g_sfa[l_ac].sfa08 IS NULL THEN LET g_sfa[l_ac].sfa08=' ' END IF

    BEFORE FIELD sfa26
        CALL i301_set_entry_b(p_cmd)

    AFTER FIELD sfa26
        IF NOT cl_null(g_sfa[l_ac].sfa26) THEN
           IF NOT cl_null(g_sfa[l_ac].sfa03) THEN
              IF g_sfa[l_ac].sfa26 MATCHES '[SUZ]' THEN    #FUN-A20037 add 'Z'
                 SELECT sfa26 INTO l_sfa26 FROM sfa_file
                  WHERE sfa01=g_sfb.sfb01
                    AND sfa03=g_sfa[l_ac].sfa27
                    AND sfa08=g_sfa[l_ac].sfa08
                    AND sfa012=g_sfa[l_ac].sfa012  #FUN-A50066
                    AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066
                 IF STATUS THEN
                    CALL cl_err3("sel","sfa_file",g_sfb.sfb01,g_sfa[l_ac].sfa27,STATUS,"","sel o.sfa",1)  #No.FUN-660128
                    NEXT FIELD sfa26
                 END IF
                 IF l_sfa26 MATCHES '[0SUZ]' THEN          #FUN-A20037 add 'Z'
                    CALL cl_err('o.sfa26=0','mfg6201',1)
                    NEXT FIELD sfa26
                 END IF
                 IF l_sfa26 MATCHES '[13]' AND (g_sfa[l_ac].sfa26='S' OR g_sfa[l_ac].sfa26 ='Z') THEN   #FUN-A20037 add 'Z'
                    CALL cl_err('o.sfa26=1/3','mfg2607',1)
                    NEXT FIELD sfa26
                 END IF
                 IF l_sfa26 MATCHES '[2478]' AND g_sfa[l_ac].sfa26='U' THEN   #FUN-A20037 add '7,8'
                    CALL cl_err('o.sfa26=2/4','mfg3540',1)
                    NEXT FIELD sfa26
                 END IF
              END IF
           END IF

           IF g_sfa[l_ac].sfa26 NOT MATCHES '[0123456SUT78Z9]' THEN  #No:8765   #FUN-A20037 add '7,8,Z'  #TQC-B90236 add '9'
#No.TQC-B90236-----add----begin----
              IF (g_sfa[l_ac].sfa26<>g_sfa_t.sfa26 AND p_cmd='u') OR p_cmd='a' THEN
                 IF g_sfa[l_ac].sfa26 MATCHES '[ABC]' THEN
                    CALL cl_err('','asf1025',0)
                    NEXT FIELD sfa26
                 END IF
              END IF
#No.TQC-B90236-----add----end------
             #NEXT FIELD sfa26           #TQC-B90236 mark
           END IF
           IF g_sfa[l_ac].sfa26 MATCHES '[0123456789]' THEN  #No:8765  #FUN-A20037 add '7,8' #TQC-B90236 add '9'
              LET g_sfa[l_ac].sfa03=g_sfa[l_ac].sfa27
              SELECT * INTO g_ima.* FROM ima_file
               WHERE ima01=g_sfa[l_ac].sfa03
              IF STATUS THEN
                 CALL cl_err3("sel","ima_file",g_sfa[l_ac].sfa03,"",STATUS,"","sel ima",1)  #No.FUN-660128
                 NEXT FIELD sfa27
              END IF
              LET g_sfa[l_ac].ima02_b = g_ima.ima02
              LET g_sfa[l_ac].ima08_b = g_ima.ima08
              LET g_sfa[l_ac].ima021_b = g_ima.ima021
              DISPLAY g_sfa[l_ac].sfa03 TO sfa03
           END IF
           IF g_sfa[l_ac].sfa26 MATCHES '[SUTZ]' THEN   #No:7111 add 'T'   #FUN-A20037 add 'Z'
              SELECT COUNT(*) INTO l_n FROM sfa_file
               WHERE sfa01=g_sfb.sfb01
                 AND sfa27=g_sfa[l_ac].sfa27
                 AND sfa08=g_sfa[l_ac].sfa08
                 AND sfa26='0'
                 AND sfa012=g_sfa[l_ac].sfa012  #FUN-A50066
                 AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066
              IF l_n > 0 THEN
                 CALL cl_err('','mfg6201',0) NEXT FIELD sfa26
              END IF
              LET g_sfa[l_ac].sfa161=0
           END IF

           IF g_sfa[l_ac].sfa26 NOT MATCHES '[SUTZ]' THEN  #No:8765   #FUN-A20037 add 'Z'
              LET g_sfa[l_ac].sfa28=1
              DISPLAY BY NAME g_sfa[l_ac].sfa28
           END IF
         #MOD-AA0160---mark---start---
         ##MOD-AA0130---add---start---
         # IF g_sfa[l_ac].sfa26 MATCHES '[0125]' THEN
         #    LET g_sfa[l_ac].sfa161=g_sfa[l_ac].sfa05/g_sfb.sfb08
         #    DISPLAY BY NAME g_sfa[l_ac].sfa161
         # END IF
         ##MOD-AA0130---add---end---
         #MOD-AA0160---mark---end---
        END IF
        CALL i301_set_no_entry_b(p_cmd)

    AFTER FIELD sfa28
        IF NOT cl_null(g_sfa[l_ac].sfa28) THEN
           IF g_sfa[l_ac].sfa28=0  THEN NEXT FIELD sfa28 END IF
        END IF

    BEFORE FIELD sfa11             #CHI-980013
       CALL i301_set_entry_b(p_cmd)#CHI-980013

    AFTER FIELD sfa11
        IF NOT cl_null(g_sfa[l_ac].sfa11) THEN
           IF g_sfa[l_ac].sfa11 NOT MATCHES '[NEVURXSC]' THEN #CHI-980013 add X #FUN-9C0040 add S #FUN-A30093
              NEXT FIELD sfa11
           END IF
           #FUN-9C0040--begin---add------
           IF g_sfa[l_ac].sfa11 = 'S' THEN
              IF g_sfa[l_ac].sfa05 > 0 THEN
                 CALL cl_err('','asf-605',0)
                 NEXT FIELD sfa05
              END IF
              IF g_sfa[l_ac].sfa161 > 0 THEN
                 CALL cl_err('','asf-605',0)
                 NEXT FIELD sfa161
              END IF
           END IF
           #FUN-9C0040--end--add------
           #TQC-C30238--begin
           IF g_sfa_t.sfa11='S' AND g_sfa_t.sfa11 !=g_sfa[l_ac].sfa11 THEN
              IF g_sfa[l_ac].sfa05 < 0 OR g_sfa[l_ac].sfa161 < 0 THEN
                 CALL cl_err('','asf-605',0)
                 NEXT FIELD sfa11
              END IF
           END IF
           #TQC-C30238--end
        END IF
        CALL i301_set_no_entry_b(p_cmd)  #CHI-980013

    BEFORE FIELD sfa03
        IF cl_null(g_sfa29[l_ac]) THEN
           SELECT MAX(sfa29) INTO g_sfa29[l_ac] FROM sfa_file
      WHERE sfa01=g_sfb.sfb01
        AND sfa27=g_sfa[l_ac].sfa27
        END IF

    AFTER FIELD sfa03
     IF NOT cl_null(g_sfa[l_ac].sfa03) THEN
#FUN-AA0059 ---------------------start----------------------------
         IF g_sfb.sfb02 <> 15 THEN                                 #FUN-AB0025
            IF NOT s_chk_item_no(g_sfa[l_ac].sfa03,"") THEN
               CALL cl_err('',g_errno,1)
               LET g_sfa[l_ac].sfa03= g_sfa_t.sfa03
               NEXT FIELD sfa03
            END IF
            #FUN-C30047---begin
            LET l_ima928 = 'N'
            SELECT ima928 INTO l_ima928 FROM ima_file
             WHERE ima01 = g_sfa[l_ac].sfa03
            IF l_ima928 = 'Y' THEN
               CALL cl_err('','ima-001',1)
               LET g_sfa[l_ac].sfa03= g_sfa_t.sfa03
               NEXT FIELD sfa03
            END IF
            #FUN-C30047---end
         END IF                                                    #FUN-AB0025
#FUN-AA0059 ---------------------end-------------------------------
       #MOD-AA0160---mark---start---
       #IF g_sfa[l_ac].sfa03 != g_sfa_t.sfa03
       #   OR g_sfa_t.sfa03 IS NULL THEN
       #   LET l_cnt = 0
       #   SELECT COUNT(*) INTO l_cnt FROM sfa_file
       #    WHERE sfa01 = g_sfb.sfb01
       #      AND sfa012 = g_sfa[l_ac].sfa012   #FUN-A50066
       #      AND sfa013 = g_sfa[l_ac].sfa013   #FUN-A50066
       #      AND sfa03 = g_sfa[l_ac].sfa03
       #   IF l_cnt > 0 THEN
       #      CALL cl_err(g_sfa[l_ac].sfa03,'asf-595',1)
       #      NEXT FIELD sfa03
       #   END IF
       #MOD-AA0160---mark---end---
           #拆件式工单,单身发的料号要与单头相同
           IF g_sfb.sfb02 = '11' THEN
              IF g_sfa[l_ac].sfa03 <> g_sfb.sfb05 THEN
                 CALL cl_err(g_sfa[l_ac].sfa03,'asf-170',1)
                 NEXT FIELD sfa03
              END IF
           END IF
           IF g_sfa[l_ac].sfa26 MATCHES '[SUZ]' THEN #SUB料號不可與原來相同  #FUN-A20037 add 'Z'
        IF g_sfa[l_ac].sfa03=g_sfa[l_ac].sfa27 THEN
           CALL cl_err('sfa03=sfa27:','mfg2626',0) NEXT FIELD sfa03
        END IF
           END IF
           SELECT COUNT(*) INTO l_n FROM bmd_file #檢查是否存在取替代檔
        WHERE bmd01 = g_sfa[l_ac].sfa27
          AND (bmd08=g_sfa29[l_ac] OR bmd08='ALL')
          AND bmd04 = g_sfa[l_ac].sfa03
          AND bmdacti = 'Y'                                           #CHI-910021
           IF l_n=0 THEN
         IF g_sfb.sfb02 NOT MATCHES '[58]' THEN   #NO:7075
            IF g_sma.sma887[1]='Y' THEN
               CALL cl_err('sel bmd:','mfg2636',0) NEXT FIELD sfa03
            END IF
            IF g_sma.sma887[1]='W' THEN
         IF NOT cl_confirm('mfg2637') THEN
            NEXT FIELD sfa03
         END IF
            END IF
         END IF
           END IF
           IF g_sfa[l_ac].sfa26 MATCHES '[SUZ]' THEN   #FUN-A20037 add 'Z'
        SELECT sfa26 INTO l_sfa26 FROM sfa_file
         WHERE sfa01=g_sfb.sfb01
           AND sfa03=g_sfa[l_ac].sfa27
           AND sfa08=g_sfa[l_ac].sfa08
           AND sfa012=g_sfa[l_ac].sfa012  #FUN-A50066
           AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066
        IF STATUS THEN
           CALL cl_err('sel o.sfa',STATUS,1)  #No.FUN-660128
           CALL cl_err3("sel","sfa_file",g_sfb.sfb01,g_sfa[l_ac].sfa27,STATUS,"","sel o.sfa",1)  #No.FUN-660128
           NEXT FIELD sfa03
        END IF
        IF l_sfa26 MATCHES '[0SUZ]' THEN   #FUN-A20037 add 'Z'
           CALL cl_err('o.sfa26=0','mfg6201',1)
           NEXT FIELD sfa03
        END IF
        IF l_sfa26 MATCHES '[13]' AND (g_sfa[l_ac].sfa26='S' OR g_sfa[l_ac].sfa26 ='Z') THEN  #FUN-A20037 add 'Z'
           CALL cl_err('o.sfa26=1/3','mfg2607',1)
           NEXT FIELD sfa03
        END IF
        IF l_sfa26 MATCHES '[2478]' AND g_sfa[l_ac].sfa26='U' THEN                             #FUN-A20037 add '7,8'
           CALL cl_err('o.sfa26=2/4','mfg3540',1)
           NEXT FIELD sfa03
        END IF
           END IF

           SELECT * INTO g_ima.* FROM ima_file WHERE ima01=g_sfa[l_ac].sfa03
           IF STATUS THEN
              CALL cl_err3("sel","ima_file",g_sfa[l_ac].sfa03,"",STATUS,"","s ima",1)  #No.FUN-660128
              NEXT FIELD sfa03 END IF
           LET g_sfa[l_ac].ima02_b = g_ima.ima02
           LET g_sfa[l_ac].ima08_b = g_ima.ima08
           LET g_sfa[l_ac].ima021_b = g_ima.ima021
       #END IF  #CHI-970059       #MOD-AA0160 mark
     END IF

    AFTER FIELD sfa12
        LET l_tf = NULL    #FUN-C20068--add--
        IF NOT cl_null(g_sfa[l_ac].sfa12) THEN
           IF cl_null(g_sfa_t.sfa03) THEN
             SELECT count(*) INTO l_n FROM sfa_file
              WHERE sfa01=g_sfb.sfb01       AND sfa03=g_sfa[l_ac].sfa03
                AND sfa08=g_sfa[l_ac].sfa08 AND sfa12=g_sfa[l_ac].sfa12
                AND sfa27=g_sfa[l_ac].sfa27 #CHI-7B0034
                AND sfa012=g_sfa[l_ac].sfa012  #FUN-A50066
                AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066
             IF l_n > 0 THEN
                #若sfa26='SUT'時,sfa03是開放的,其他狀況sfa03是noentry
                CALL cl_err('',-239,0)
                IF g_sfa[l_ac].sfa26 NOT MATCHES '[SUTZ]' THEN           #FUN-A20037 add 'Z'
                   NEXT FIELD sfa12
                ELSE
                   NEXT FIELD sfa03
                END IF
             END IF
           END IF
           CALL s_umfchk(g_sfa[l_ac].sfa03,g_sfa[l_ac].sfa12,g_ima.ima25)
             RETURNING l_n,g_sfa[l_ac].sfa13
           IF l_n = 1 THEN
              CALL cl_err('','mfg3075',0) NEXT FIELD sfa12
           END IF
           DISPLAY BY NAME g_sfa[l_ac].sfa13   #No.TQC-710003
       #FUN-910088--add--start--
           LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)
           LET g_sfa[l_ac].sfa06 = s_digqty(g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa12)
           LET g_sfa[l_ac].sfa062 = s_digqty(g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa12)
           LET g_sfa[l_ac].sfa063 = s_digqty(g_sfa[l_ac].sfa063,g_sfa[l_ac].sfa12)
           LET g_sfa[l_ac].sfa064 = s_digqty(g_sfa[l_ac].sfa064,g_sfa[l_ac].sfa12)
           DISPLAY BY NAME g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa06,g_sfa[l_ac].sfa062,g_sfa[l_ac].sfa063,
                           g_sfa[l_ac].sfa064
           IF g_sfb.sfb02 NOT MATCHES '[78]' AND NOT g_before_input_done THEN
               LET g_sfa[l_ac].sfa065 = s_digqty(g_sfa[l_ac].sfa065,g_sfa[l_ac].sfa12)
               DISPLAY BY NAME g_sfa[l_ac].sfa065
           ELSE
              IF NOT cl_null(g_sfa[l_ac].sfa065) AND g_sfa[l_ac].sfa065 <> 0 THEN
                 IF NOT i301_sfa065_check() THEN
                    LET g_sfa12_t = g_sfa[l_ac].sfa12
                    NEXT FIELD sfa065
                 END IF
                 LET g_sfa12_t = g_sfa[l_ac].sfa12
              END IF
           END IF
       #FUN-910088--add--end--
        END IF

    AFTER FIELD sfa100
        IF NOT cl_null(g_sfa[l_ac].sfa100) THEN
           IF g_sfa[l_ac].sfa100< 0 OR g_sfa[l_ac].sfa100 > 100 THEN
        CALL cl_err(g_sfa[l_ac].sfa100,'mfg0013',0)
        LET g_sfa[l_ac].sfa100 = g_sfa_t.sfa100
        DISPLAY BY NAME g_sfa[l_ac].sfa100
        NEXT FIELD sfa100
           END IF
        END IF

    AFTER FIELD sfa30
        IF NOT cl_null(g_sfa[l_ac].sfa30) THEN
           SELECT * FROM imd_file
            WHERE imd01=g_sfa[l_ac].sfa30
              AND imdacti = 'Y' #MOD-4B0169
           IF STATUS THEN
             CALL cl_err3("sel","imd_file",g_sfa[l_ac].sfa30,"","mfg1100","","imd:",1)   #No.FUN-660128
             NEXT FIELD sfa30
           END IF
   #------>check-1
           IF NOT s_imfchk1(g_sfa[l_ac].sfa27,g_sfa[l_ac].sfa30)
             THEN CALL cl_err(g_sfa[l_ac].sfa30,'mfg9036',0)
             NEXT FIELD sfa30
           END IF
   #------>check-2
           CALL s_stkchk(g_sfa[l_ac].sfa30,'A') RETURNING l_code
           IF NOT l_code THEN
              CALL cl_err(g_sfa[l_ac].sfa30,'mfg1100',0)
              NEXT FIELD sfa30
           END IF
           #Add No.FUN-AA0050
           IF NOT s_chk_ware(g_sfa[l_ac].sfa30) THEN  #检查仓库是否属于当前门店
              NEXT FIELD sfa30
           END IF
           #End Add No.FUN-AA0050
        ELSE
           LET g_sfa[l_ac].sfa30=' '  #FUN-810038
        END IF
   #TQC-D50126 -------Begin------
    ##FUN-D40103 -----Begin------
    #   IF NOT s_imechk(g_sfa[l_ac].sfa30,g_sfa[l_ac].sfa31) THEN
    #      NEXT FIELD sfa31
    #   END IF
    ##FUN-D40103 -----End--------
   #TQC-D50126 -------End--------

    AFTER FIELD sfa31
        IF NOT cl_null(g_sfa[l_ac].sfa31) THEN
           IF NOT s_imfchk(g_sfa[l_ac].sfa27,g_sfa[l_ac].sfa30,g_sfa[l_ac].sfa31)
              THEN CALL cl_err(g_sfa[l_ac].sfa31,'mfg6095',0)
              NEXT FIELD sfa31
           END IF
        ELSE
           LET g_sfa[l_ac].sfa31=' '  #FUN-810038
        END IF
   #TQC-D50126 -------Begin------
    ##FUN-D40103 -----Begin------
    #   IF NOT s_imechk(g_sfa[l_ac].sfa30,g_sfa[l_ac].sfa31) THEN
    #      NEXT FIELD sfa31
    #   END IF
    ##FUN-D40103 -----End--------
   #TQC-D50126 -------End--------

    AFTER FIELD sfa36
        IF NOT cl_null(g_sfa[l_ac].sfa36) THEN
           SELECT COUNT(*) INTO g_cnt FROM mse_file
            WHERE mse01 = g_sfa[l_ac].sfa36
           IF g_cnt = 0 THEN
              CALL cl_err(g_sfa[l_ac].sfa36,'mfg2603',0)
              NEXT FIELD sfa36
           ELSE
             SELECT mse02 INTO g_sfa[l_ac].mse02
               FROM mse_file WHERE mse01=g_sfa[l_ac].sfa36
             DISPLAY g_sfa[l_ac].mse02 TO FORMONLY.mse02
           END IF
        END IF

    BEFORE FIELD sfa05
        IF cl_null(g_sfa_t.sfa05) THEN
           LET b_sfa.sfa04       = g_sfb.sfb08 * b_sfa.sfa16
           LET g_sfa[l_ac].sfa05 = g_sfb.sfb08 * g_sfa[l_ac].sfa161
           LET b_sfa.sfa04       = s_digqty(b_sfa.sfa04,b_sfa.sfa12)         #FUN-910088--add--
           LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)   #FUN-910088--add
           DISPLAY BY NAME g_sfa[l_ac].sfa05
        END IF

    AFTER FIELD sfa05
      IF g_sfa[l_ac].sfa11 != 'X'  THEN   #CHI-980013
         IF g_sfa[l_ac].sfa11 != 'S' THEN #FUN-9C0040
            IF cl_null(g_sfa[l_ac].sfa05) THEN NEXT FIELD sfa05 END IF

            IF g_sfa[l_ac].sfa05<0 AND g_sfb.sfb02 NOT MATCHES '[58]' THEN
               CALL cl_err('','asf-678',0)
               NEXT FIELD sfa05
            END IF
            IF g_sfb.sfb02 NOT MATCHES '[58]' THEN  #NO:7075
               CALL i301_sfa05()
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  LET g_sfa[l_ac].sfa05=g_sfa_t.sfa05
                  DISPLAY g_sfa[l_ac].sfa05 TO s_sfa[l_ac].sfa05
                  NEXT FIELD sfa05
               END IF
            END IF
        ELSE
           IF g_sfa[l_ac].sfa05 > 0 THEN   #FUN-9C0040
              CALL cl_err('','asf-605',0)  #FUN-9C0040
              NEXT FIELD sfa05             #FUN-9C0040
           END IF                          #FUN-9C0040
        END IF   #FUN-9C0040
        #-->考慮單位小數取位
         #FUN-D60039--mark--str--
         #SELECT gfe03 INTO l_gfe03 FROM gfe_file
         # WHERE gfe01 = g_sfa[l_ac].sfa12
         #IF SQLCA.sqlcode OR cl_null(l_gfe03) THEN
         #   LET l_gfe03 = 0
         #END IF
         #CALL cl_digcut(g_sfa[l_ac].sfa05,l_gfe03)
         #      RETURNING g_sfa[l_ac].sfa05
         #FUN-D60039--mark--end--
         LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)  #FUN-D60039 add
         IF g_sfa[l_ac].sfa26 MATCHES '[01257]' THEN  #FUN-A20037 add '7'  #MOD-A40012 mod
        #   AND g_sfb.sfb02 NOT MATCHES '[58]' THEN                        #MOD-A40012 mark
            LET g_sfa[l_ac].sfa161=g_sfa[l_ac].sfa05/g_sfb.sfb08
            LET g_sfa_o.sfa161 = g_sfa[l_ac].sfa161  #MOD-C90069 add
            DISPLAY BY NAME g_sfa[l_ac].sfa161
         END IF
         IF NOT cl_null(g_sfa[l_ac].sfa05) AND NOT cl_null(g_sfa[l_ac].sfa065) THEN
            IF g_sfa[l_ac].sfa065 > g_sfa[l_ac].sfa05 AND g_sfa[l_ac].sfa05 >= 0 THEN  #No.MOD-760043 modify
               LET g_sfa[l_ac].sfa065 = NULL
               NEXT FIELD sfa065
            END IF
         END IF
      END IF    #CHI-980013
      #FUN-C30145---begin
      IF NOT  cl_null(g_sfa_t.sfa05) THEN
         IF g_wo_cnt > 0 THEN
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt
              FROM sfb_file
             WHERE sfb86 = g_sfb.sfb01
               AND sfb05 = g_sfa[l_ac].sfa03
               AND sfb87 <> 'X'
            IF l_cnt > 0 THEN
               CALL cl_err('','asf-278',1)
            END IF
         END IF
      END IF
      #FUN-C30145---end
  #    LET g_sfa_o.sfa161 = g_sfa_t.sfa161   #MOD-C90069 add   #MOD-CB0005 mark


        AFTER FIELD sfa161
         IF g_sfa[l_ac].sfa11 != 'X' THEN   #CHI-980013
           IF NOT cl_null(g_sfa[l_ac].sfa161) THEN
              IF g_sfa[l_ac].sfa161 = 0 THEN
                 #IF g_sfa[l_ac].sfa26 MATCHES '[SUTZ]' THEN   #TQC-BC0032   #TQC-C30232
                 IF g_sfa[l_ac].sfa26 MATCHES '[SUTZ6]' THEN   #TQC-BC0032  #TQC-C30232 add '6'
                    NEXT FIELD sfa27                          #TQC-BC0032
                 ELSE                                         #TQC-BC0032
                    CALL cl_err('','asf-106',0)
                    NEXT FIELD sfa161
                 END IF                                       #TQC-BC0032
              END IF
              IF g_sfa[l_ac].sfa11 = 'S' THEN    #FUN-9C0040
                 IF g_sfa[l_ac].sfa161 > 0 THEN  #FUN-9C0040
                    CALL cl_err('','asf-605',0)  #FUN-9C0040
                    NEXT FIELD sfa161             #FUN-9C0040
                 END IF                          #FUN-9C0040
              END IF   #FUN-9C0040
              #判斷QPA有改變時才重推應發量
             #MOD-BA0105 -- mark begin --
             #IF g_sfa_t.sfa161 IS NULL OR                 #MOD-A40017 add
             #   g_sfa[l_ac].sfa161!=g_sfa_t.sfa161 THEN   #MOD-A40017 add
             #MOD-BA0105 -- mark end --
              #MOD-BA0105 -- begin --
              IF g_sfa_o.sfa161 IS NULL OR
                 g_sfa[l_ac].sfa161 != g_sfa_o.sfa161 THEN
              #MOD-BA0105 -- end --
                 IF g_sfa[l_ac].sfa26 MATCHES '[01257]'  #MOD-990123  #FUN-A20037 add '7'
                    AND g_sfb.sfb02 NOT MATCHES '[58]' THEN   #MOD-990123
                    LET g_sfa[l_ac].sfa05 = g_sfa[l_ac].sfa161 * g_sfb.sfb08
                    LET l_sfa05 = g_sfa[l_ac].sfa05
                    IF g_sfa[l_ac].sfa11 = 'S' THEN LET l_sfa05 = l_sfa05 * (-1) END IF  #FUN-9C0040
                       SELECT ima64,ima641 INTO l_ima64,l_ima641 FROM ima_file
                        WHERE ima01=g_sfa[l_ac].sfa27
                       IF STATUS THEN LET l_ima64 = 0 LET l_ima641 = 0 END IF
                       #check最少發料數量
                       IF l_ima641 <>  0 AND l_sfa05 < l_ima641 THEN
                          LET l_sfa05 = l_ima641
                       END IF
                       LET l_num_z=l_sfa05/l_ima64
                       LET l_num_y=l_sfa05-l_num_z*l_ima64
                       IF l_ima64 <> 0 AND (l_num_y) != 0 THEN  #No.TQC-760038
                          LET l_double=(l_sfa05/l_ima64)+ 0.999999
                          LET l_sfa05=l_double*l_ima64
                       END IF
                    IF g_sfa[l_ac].sfa11 = 'S' THEN LET l_sfa05 = l_sfa05 * (-1) END IF  #FUN-9C0040

                       IF l_sfa05 != g_sfa[l_ac].sfa05 THEN
                          CALL cl_err('','asf-971',1)
                          LET g_sfa[l_ac].sfa161 = l_sfa05 / g_sfb.sfb08
                          LET g_sfa[l_ac].sfa05 = l_sfa05
                       END IF
                    #-->考慮單位小數取位
                    #SELECT gfe03 INTO l_gfe03 FROM gfe_file WHERE gfe01 = g_sfa[l_ac].sfa12  #FUN-D60039 mark
                    #IF SQLCA.sqlcode OR cl_null(l_gfe03) THEN LET l_gfe03 = 0 END IF         #FUN-D60039 mark
                    #CALL cl_digcut(g_sfa[l_ac].sfa05,l_gfe03) RETURNING g_sfa[l_ac].sfa05    #FUN-D60039 mark
                    LET g_sfa[l_ac].sfa05 = s_digqty(g_sfa[l_ac].sfa05,g_sfa[l_ac].sfa12)     #FUN-D60039 add
                 END IF
                 LET g_sfa_o.sfa161 = g_sfa[l_ac].sfa161   #MOD-BA0105 add
                 DISPLAY BY NAME g_sfa[l_ac].sfa05
                 DISPLAY BY NAME g_sfa[l_ac].sfa161
              END IF   #MOD-A40017 add
           END IF
         END IF  #CHI-980013


    AFTER FIELD sfa065
       IF NOT i301_sfa065_check() THEN NEXT FIELD sfa065 END IF    #FUN-910088--add--
     #FUN-910088--mark--start--
     #  IF g_sfb.sfb02 MATCHES '[8]' THEN          #NO:7075
     #     IF g_sfa[l_ac].sfa05 < 0 AND g_sfa[l_ac].sfa065 <> 0 THEN
     #         CALL cl_err('','asf-957',1)
     #         LET g_sfa[l_ac].sfa065=0
     #         NEXT FIELD sfa065
     #     END IF
     #  END IF
     #  IF NOT cl_null(g_sfa[l_ac].sfa05) AND NOT cl_null(g_sfa[l_ac].sfa065) THEN
     #     IF g_sfa[l_ac].sfa065 > g_sfa[l_ac].sfa05 AND g_sfa[l_ac].sfa05>=0 THEN    #No.MOD-760043 modify
     #        CALL cl_err('','asf-976',1)
     #        NEXT FIELD sfa065
     #     END IF
     #  END IF
     #FUN-910088--mark--end--


       AFTER FIELD sfaud01
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud02
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud03
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud04
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud05
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud06
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud07
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud08
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud09
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud10
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud11
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud12
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud13
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud14
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
       AFTER FIELD sfaud15
          IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF

    BEFORE DELETE                            #是否取消單身
        IF g_sfb.sfb87='Y' AND p_in ='d' THEN
           CALL cl_err('','aap-086',1)
           RETURN
        ELSE
           IF g_sfa_t.sfa03 IS NOT NULL THEN
        IF NOT cl_delb(0,0) THEN
           CANCEL DELETE
        END IF

        CALL i301_b_dealc(g_sfa[l_ac].sfa27)
        IF g_success = 'N' THEN
			    CANCEL DELETE
        END IF

        IF l_lock_sw = "Y" THEN
           CALL cl_err("", -263, 1)
           CANCEL DELETE
        END IF

        DELETE FROM sfa_file
         WHERE sfa01 = g_sfb.sfb01   AND sfa03 = g_sfa_t.sfa03
           AND sfa08 = g_sfa_t.sfa08 AND sfa12 = g_sfa_t.sfa12
           AND sfa27 = g_sfa_t.sfa27 #CHI-7B0034
           AND sfa012 = g_sfa_t.sfa012  #FUN-A50066
           AND sfa013 = g_sfa_t.sfa013  #FUN-A50066
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","sfa_file",g_sfb.sfb01,g_sfa_t.sfa03,SQLCA.sqlcode,"","del sfa:",1) #No.FUN-660128
           ROLLBACK WORK
           CANCEL DELETE
        END IF
        DELETE FROM tc_sfa_file
         WHERE tc_sfa01 = g_sfb.sfb01   AND tc_sfa02 = g_sfa_t.sfa03
           AND tc_sfa03 = g_sfa_t.sfa08
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","tc_sfa_file",g_sfb.sfb01,g_sfa_t.sfa03,SQLCA.sqlcode,"","del tc_sfa:",1) #No.FUN-660128
           ROLLBACK WORK
           CANCEL DELETE
        END IF
        CALL i301_bu()
        IF g_success = 'Y' THEN
           LET l_sfb43 = '0'    #FUN-8C0081 add
           COMMIT WORK
           LET g_rec_b=g_rec_b-1
           DISPLAY g_rec_b TO FORMONLY.cn2
        ELSE
           ROLLBACK WORK
        END IF
           END IF
        END IF

    ON ROW CHANGE
        IF INT_FLAG THEN
           CALL cl_err('',9001,0)
           LET INT_FLAG = 0
           LET g_sfa[l_ac].* = g_sfa_t.*
           CLOSE i301_bcl
           ROLLBACK WORK
           EXIT INPUT
        END IF
       #MOD-AA0160---mark---start---
       #LET l_cnt = 0
       #SELECT COUNT(*) INTO l_cnt FROM sfa_file
       # WHERE sfa01 = g_sfb.sfb01
       #   AND sfa03 = g_sfa[l_ac].sfa03
       #   AND sfa012 = g_sfa[l_ac].sfa012  #FUN-A50066
       #   AND sfa013 = g_sfa[l_ac].sfa013  #FUN-A50066
       #   AND (sfa03 != g_sfa_t.sfa03
       #    OR sfa012!= g_sfa_t.sfa012      #FUN-A50066
       #    OR sfa013!= g_sfa_t.sfa013)     #FUN-A50066
       #IF l_cnt > 0 THEN
       #   CALL cl_err(g_sfa[l_ac].sfa03,'asf-595',1)
       #   NEXT FIELD sfa27
       #END IF
       #MOD-AA0160---mark---end---
        IF l_lock_sw = 'Y' THEN
           CALL cl_err(g_sfa[l_ac].sfa03,-263,1)
           LET g_sfa[l_ac].* = g_sfa_t.*
        ELSE
           CALL i301_b_move_back()
           CALL i301_b_else()
#TQC-B90003 --mark begin--
##TQC-B50022 --begin--
#          LET l_cnt = 0
#          SELECT COUNT(*) INTO l_cnt FROM sfa_file
#            WHERE sfa01=g_sfb.sfb01   AND sfa03=g_sfa_t.sfa03
#              AND sfa08=g_sfa_t.sfa08 AND sfa12=g_sfa_t.sfa12
#              AND sfa27=g_sfa_t.sfa27
#              AND sfa012=g_sfa_t.sfa012
#              AND sfa013=g_sfa_t.sfa013
#          IF l_cnt = 0 THEN
##TQC-B50022 --end--
#TQC-B90003 --mark--end--
           LET g_success = 'Y'   #FUN-C30274
           UPDATE sfa_file SET * = b_sfa.*
            WHERE sfa01=g_sfb.sfb01   AND sfa03=g_sfa_t.sfa03
              AND sfa08=g_sfa_t.sfa08 AND sfa12=g_sfa_t.sfa12
              AND sfa27=g_sfa_t.sfa27 #CHI-7B0034
              AND sfa012=g_sfa_t.sfa012  #FUN-A50066
              AND sfa013=g_sfa_t.sfa013  #FUN-A50066
           IF SQLCA.sqlcode THEN
              CALL cl_err3("upd","sfa_file",g_sfa_t.sfa03,"",SQLCA.sqlcode,"","upd sfa",1)   #No.FUN-660128
              LET g_sfa[l_ac].* = g_sfa_t.*
           ELSE
              #add by lanhang 140107 begin
              SELECT * INTO l_tc_sfa.* FROM tc_sfa_file
               WHERE tc_sfa01=g_sfb.sfb01
                 AND tc_sfa02=g_sfa_t.sfa03
                 AND tc_sfa03=g_sfa_t.sfa08
                 AND tc_sfa05=g_sfa_t.sfa12
                 AND ROWNUM=1
              LET l_tc_sfa.tc_sfa02=b_sfa.sfa03
              LET l_tc_sfa.tc_sfa03=b_sfa.sfa08
              LET l_tc_sfa.tc_sfa05=b_sfa.sfa12
              LET l_tc_sfa.tc_sfa06=b_sfa.sfa05
              LET l_tc_sfa.tc_sfa07=b_sfa.sfaud02
              LET l_tc_sfa.tc_sfa08=b_sfa.sfaud07
              LET l_tc_sfa.tc_sfa09=b_sfa.sfaud03
              LET l_tc_sfa.tc_sfa10=b_sfa.sfaud04
              LET l_tc_sfa.tc_sfa11=''
              LET l_tc_sfa.tc_sfa12=b_sfa.sfa16
              LET l_tc_sfa.tc_sfa13=b_sfa.sfa161
              LET l_tc_sfa.tc_sfa14=b_sfa.sfaud05
              UPDATE tc_sfa_file SET *=l_tc_sfa.*
               WHERE tc_sfa01=g_sfb.sfb01
                 AND tc_sfa02=g_sfa_t.sfa03
                 AND tc_sfa03=g_sfa_t.sfa08
                 AND tc_sfa05=g_sfa_t.sfa12
              #add by lanhang 140107 end
              CALL i301_bu()
#        END IF     #TQC-B50022           #TQC-B90003 mark

              IF g_success = 'Y' THEN
                 LET l_sfb43 = '0'    #FUN-8C0081 add
                 MESSAGE 'UPDATE O.K'
                 COMMIT WORK
              ELSE
                 ROLLBACK WORK
              END IF
           END IF
        END IF

    AFTER ROW
        LET l_ac = ARR_CURR()
       #LET l_ac_t = l_ac       #FUN-D40030 Mark
        IF INT_FLAG THEN
           CALL cl_err('',9001,0)
           LET INT_FLAG = 0
           IF p_cmd='u' THEN
              LET g_sfa[l_ac].* = g_sfa_t.*
           #FUN-D40030--add--str--
           ELSE
              CALL g_sfa.deleteElement(l_ac)
              IF g_rec_b != 0 THEN
                 LET g_action_choice = "detail"
                 LET l_ac = l_ac_t
              END IF
           #FUN-D40030--add--end--
           END IF
           CLOSE i301_bcl
           ROLLBACK WORK
           EXIT INPUT
        END IF
        LET l_ac_t = l_ac       #FUN-D40030 Add
        CLOSE i301_bcl
        COMMIT WORK

    ON ACTION CONTROLO                        #沿用所有欄位
       IF l_ac > 1 THEN
          LET g_sfa[l_ac].sfa27 = g_sfa[l_ac-1].sfa27
          LET g_sfa[l_ac].sfa08 = g_sfa[l_ac-1].sfa08
          LET g_sfa[l_ac].sfa26 = g_sfa[l_ac-1].sfa26
          LET g_sfa[l_ac].sfa28 = g_sfa[l_ac-1].sfa28
          LET g_sfa[l_ac].sfa03 = g_sfa[l_ac-1].sfa03
          LET g_sfa[l_ac].sfa05 = 0
          LET g_sfa[l_ac].sfa065= 0
          LET g_sfa[l_ac].sfa06 = 0
          LET g_sfa[l_ac].sfa062= 0
          LET g_sfa[l_ac].short_qty = 0  #FUN-940008 add
          LET g_sfa[l_ac].sfa063= 0
          LET g_sfa[l_ac].sfa064= 0
          NEXT FIELD sfa27
       END IF

    ON ACTION qry_bom_item
       CALL q_bmx2(FALSE,FALSE,g_sfb.sfb05,g_sfb.sfb071,'')
            RETURNING g_sfa[l_ac].sfa27
       IF cl_null(g_sfa[l_ac].sfa27) THEN
          LET g_sfa[l_ac].sfa27=g_sfa_t.sfa27
       END IF
       NEXT FIELD sfa27

   ON ACTION controlp
     #FUN-A50066--begin--add------------
     CASE WHEN INFIELD(sfa012)
         CALL cl_init_qry_var()
       # LET g_qryparam.form = "q_ecb012"     #FUN-B10056 mark
         LET g_qryparam.form = "q_sgx012_2"   #FUN-B10056
       # LET g_qryparam.arg1 = g_sfb.sfb05    #FUN-B10056 mark
       # LET g_qryparam.arg2 = g_sfb.sfb06    #FUN-B10056
         LET g_qryparam.arg1 = g_sfb.sfb01    #FUN-B10056
         LET g_qryparam.default1 = g_sfa[l_ac].sfa012
         LET g_qryparam.default2 = g_sfa[l_ac].sfa013
         CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa012,g_sfa[l_ac].sfa013
         DISPLAY BY NAME g_sfa[l_ac].sfa012,g_sfa[l_ac].sfa013
         NEXT FIELD sfa012
      WHEN INFIELD(sfa013)
         CALL cl_init_qry_var()
       # LET g_qryparam.form = "q_ecb012"     #FUN-B10056 mark
         LET g_qryparam.form = "q_sgx012_2"   #FUN-B10056
       # LET g_qryparam.arg1 = g_sfb.sfb05    #FUN-B10056 mark
       # LET g_qryparam.arg2 = g_sfb.sfb06    #FUN-B10056 mark
         LET g_qryparam.arg1 = g_sfb.sfb01    #FUN-B10056
         LET g_qryparam.default1 = g_sfa[l_ac].sfa012
         LET g_qryparam.default2 = g_sfa[l_ac].sfa013
         CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa012,g_sfa[l_ac].sfa013
         DISPLAY BY NAME g_sfa[l_ac].sfa012,g_sfa[l_ac].sfa013
         NEXT FIELD sfa013
      #FUN-A50066--end--add--------------------
      WHEN INFIELD(sfa27)
           CALL cl_init_qry_var()
           #FUN-A50066--begin--add--------------
           IF g_sma.sma542 = 'Y' AND g_sfb.sfb93 = 'Y' THEN   #FUN-A50066
              LET g_qryparam.form = "q_brb03_1"
              LET g_qryparam.arg4 = g_sfb.sfb06
              LET g_qryparam.arg5 = g_sfa[l_ac].sfa012
              LET g_qryparam.arg6 = g_sfa[l_ac].sfa013
           ELSE
           #FUN-A50066--end--add---------------
              LET g_qryparam.form = "q_bmb202"
           END IF
           LET g_qryparam.arg1 = g_sfb.sfb071
           LET g_qryparam.arg2 = g_sfb.sfb05
           LET g_qryparam.arg3 = g_sfb.sfb95     #No.MOD-7A0107 add
           CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa27
           DISPLAY BY NAME g_sfa[l_ac].sfa27
           IF cl_null(g_sfa[l_ac].sfa27) THEN
#FUN-AA0059---------mod------------str-----------------
#       CALL cl_init_qry_var()
#       LET g_qryparam.form     = "q_ima"
#       LET g_qryparam.default1 = g_sfa[l_ac].sfa27
#       CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa27
           CALL q_sel_ima(FALSE, "q_ima","",g_sfa[l_ac].sfa27,"","","","","",'' )
              RETURNING g_sfa[l_ac].sfa27
#FUN-AA0059---------mod------------end-----------------
         DISPLAY BY NAME g_sfa[l_ac].sfa27  #No.MOD-490371
           END IF
           NEXT FIELD sfa27
      WHEN INFIELD(sfa03)
#FUN-AA0059---------mod------------str-----------------
#          CALL cl_init_qry_var()
#          LET g_qryparam.form     = "q_ima"
#          LET g_qryparam.default1 = g_sfa[l_ac].sfa03
#          CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa03
           CALL q_sel_ima(FALSE, "q_ima","",g_sfa[l_ac].sfa03,"","","","","",'' )
              RETURNING g_sfa[l_ac].sfa03
#FUN-AA0059---------mod------------end-----------------
            DISPLAY BY NAME g_sfa[l_ac].sfa03  #No.MOD-490371
      WHEN INFIELD(sfa12)
           CALL cl_init_qry_var()
           LET g_qryparam.form     = "q_gfe"
           LET g_qryparam.default1 = g_sfa[l_ac].sfa12
           CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa12
      WHEN INFIELD(sfa08)
      #    CALL q_ecd(FALSE,TRUE,g_sfa[l_ac].sfa08)      #TQC-A50142
      #   RETURNING g_sfa[l_ac].sfa08                               #TQC-A50142
#TQC-A50142 --add
           CALL cl_init_qry_var()
           IF NOT cl_null(g_sfb.sfb06) THEN  #CHI-C80056
              LET g_qryparam.form     = "q_ecb_02"
              LET g_qryparam.arg1     = g_sfb.sfb06
              LET g_qryparam.arg2     = g_sfb.sfb05   #MOD-C80034 add
           #CHI-C80056---begin
           ELSE
              LET g_qryparam.form     = "q_ecb_03"
              LET g_qryparam.arg1     = g_sfb.sfb05
           END IF
           #CHI-C80056---end
           CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa08
#TQC-A50142 --  end
           DISPLAY BY NAME g_sfa[l_ac].sfa08    #No.MOD-490371
           NEXT FIELD sfa08
      WHEN INFIELD(sfa30)
          #Mod No.FUN-AA0050
          #CALL cl_init_qry_var()
          #LET g_qryparam.form     = "q_imd"
          #LET g_qryparam.default1 = g_sfa[l_ac].sfa30
          #LET g_qryparam.arg1     = 'SW'        #倉庫類別 #MOD-4A0213
          #CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa30
           CALL q_imd_1(FALSE,TRUE,g_sfa[l_ac].sfa30,"",g_plant,"","")  #只能开当前门店的
                RETURNING g_sfa[l_ac].sfa30
          #End Mod No.FUN-AA0050
           DISPLAY BY NAME g_sfa[l_ac].sfa30
           NEXT FIELD sfa30
      WHEN INFIELD(sfa31)
          #Mod No.FUN-AA0050
          #CALL cl_init_qry_var()
          #LET g_qryparam.form     = "q_ime"
          #LET g_qryparam.default1 = g_sfa[l_ac].sfa31
          #LET g_qryparam.arg1     = g_sfa[l_ac].sfa30 #倉庫編號 #MOD-4A0063
          #LET g_qryparam.arg2     = 'SW'              #倉庫類別 #MOD-4A0063
          #CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa31
           CALL q_ime_1(FALSE,TRUE,g_sfa[l_ac].sfa31,g_sfa[l_ac].sfa30,"",g_plant,"","","")
                    RETURNING g_sfa[l_ac].sfa31
          #End Mod No.FUN-AA0050
           DISPLAY BY NAME g_sfa[l_ac].sfa31
           NEXT FIELD sfa31
      WHEN INFIELD(sfa36)
           CALL cl_init_qry_var()
           LET g_qryparam.form = "q_mse"
           LET g_qryparam.default1 = g_sfa[l_ac].sfa36
           CALL cl_create_qry() RETURNING g_sfa[l_ac].sfa36
           DISPLAY BY NAME g_sfa[l_ac].sfa36
           NEXT FIELD sfa36
     END CASE

    ON ACTION CONTROLR
       CALL cl_show_req_fields()

    ON ACTION CONTROLG CALL cl_cmdask()

    ON ACTION CONTROLF
     CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
     CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913


        IF INT_FLAG THEN    #900423
     CALL cl_err('',9001,0)
     LET INT_FLAG = 0
     LET g_sfa[l_ac].* = g_sfa_t.*
     EXIT INPUT
        END IF

         ON IDLE g_idle_seconds
      CALL cl_on_idle()
      CONTINUE INPUT
    ON ACTION CONTROLS
           CALL cl_set_head_visible("","AUTO")
      END INPUT
            IF g_sfb.sfb39='1' THEN
               LET l_cnt=0
               SELECT COUNT(*) INTO l_cnt
                 FROM sfa_file
                WHERE sfa01 = g_sfb.sfb01

               LET l_cnt1=0
               SELECT COUNT(*) INTO l_cnt1
                 FROM sfa_file
                WHERE sfa01 = g_sfb.sfb01
                  AND sfa11 = 'E'

               IF l_cnt <> 0 THEN
                  IF l_cnt = l_cnt1 THEN
                     #CHI-C50029 str add-----
                     IF cl_confirm('asf-897')THEN
                        LET g_sfb.sfb39='2'
                        UPDATE sfb_file SET sfb39='2' WHERE sfb01=g_sfb.sfb01
                        DISPLAY BY NAME g_sfb.sfb39
                     ELSE
                    #CHI-C50029 end add-----
                     CALL cl_err('','asf-899',1)
                     END IF                                 #CHI-C50029 add
                  END IF
               END IF
            END IF

           #MOD-D30200 str add-----
            IF g_sfb.sfb39='2' THEN
               LET l_cnt=0
               SELECT COUNT(*) INTO l_cnt
                 FROM sfa_file
                WHERE sfa01 = g_sfb.sfb01

               LET l_cnt1=0
               SELECT COUNT(*) INTO l_cnt1
                 FROM sfa_file
                WHERE sfa01 = g_sfb.sfb01
                  AND sfa11 = 'N'

               IF l_cnt <> 0 THEN
                  IF l_cnt = l_cnt1 THEN
                     IF cl_confirm('asf-896') THEN
                        LET g_sfb.sfb39='1'
                        UPDATE sfb_file SET sfb39='1' WHERE sfb01=g_sfb.sfb01
                        DISPLAY BY NAME g_sfb.sfb39
                     ELSE
                        CALL cl_err('','asf-899',1)
                     END IF
                  END IF
               END IF
            END IF
           #MOD-D30200 end add-----

      UPDATE sfb_file SET sfbmodu=g_user,sfbdate=g_today,sfb43=l_sfb43   #FUN-8C0081 add sfb43
       WHERE sfb01=g_sfb.sfb01
      LET g_sfb.sfb43 = l_sfb43    #FUN-8C0081 add
      DISPLAY BY NAME g_sfb.sfb43  #FUN-8C0081 add
      SELECT COUNT(*) INTO g_cnt FROM sfa_file WHERE sfa01=g_sfb.sfb01

      IF g_cnt>0 AND g_sfb.sfb23!='Y' THEN #MOD-580338 g_sfb.sfb23='N' ->g_sfb.sfb23!='Y'
       UPDATE sfb_file SET sfb23='Y' WHERE sfb01=g_sfb.sfb01
       LET g_sfb.sfb23='Y' #MOD-580338
       DISPLAY g_sfb.sfb23 TO sfb23 #MOD-580338
    END IF

    IF g_cnt=0 AND g_sfb.sfb23!='N' THEN
       UPDATE sfb_file SET sfb23='N' WHERE sfb01=g_sfb.sfb01
       LET g_sfb.sfb23='N'
       DISPLAY g_sfb.sfb23 TO sfb23
    END IF
    CLOSE i301_bcl
    COMMIT WORK

    CALL i301_sub_chk(g_sfb.sfb01)

END FUNCTION

FUNCTION i301_set_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)

    IF NOT g_before_input_done THEN
       CALL cl_set_comp_entry("sfa065",TRUE)
    END IF

    IF INFIELD(sfa26) THEN
       CALL cl_set_comp_entry("sfa28,sfa03,sfa161",TRUE)
    END IF

    #FUN-A50066--begin--add-------
    IF g_sma.sma541 = 'Y' THEN
       CALL cl_set_comp_entry("sfa012,sfa013",TRUE)
    END IF
    CALL cl_set_comp_entry("sfa08",TRUE)
    #FUN-A50066--end--add---------

    CALL cl_set_comp_entry("sfa05,sfa161",TRUE)   #CHI-980013
END FUNCTION

FUNCTION i301_set_no_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)

    IF g_sfb.sfb02 NOT MATCHES '[78]' AND NOT g_before_input_done THEN
       CALL cl_set_comp_entry("sfa065",FALSE)
    END IF

    IF g_before_input_done THEN     #No.MOD-7A0107 add
   IF g_before_input_done OR p_cmd='u' THEN            #MOD-870028
       IF g_sfa[l_ac].sfa26 NOT MATCHES '[SUTZ]' THEN    #No:8765  #FUN-A20037 add 'Z'
          LET g_sfa[l_ac].sfa28=1
          CALL cl_set_comp_entry("sfa28,sfa03",FALSE)
       END IF
       IF g_sfa[l_ac].sfa26 MATCHES '[SUTZ6]' THEN        #No:7111 add 'T'  #FUN-A20037 add 'Z'  #TQC-C30232 add '6'
          LET g_sfa[l_ac].sfa161=0
          CALL cl_set_comp_entry("sfa161",FALSE)
       END IF
    END IF    #No.MOD-7A0107 add
   END IF             #MOD-870017 add
   IF p_cmd='u' OR INFIELD(sfa11) THEN         #TQC-990052  #No:MOD-9C0024 modify
      IF g_sfa[l_ac].sfa11 = 'X' THEN #CHI-980013
         LET g_sfa[l_ac].sfa05 = 0             #CHI-980013
         LET g_sfa[l_ac].sfa161 = 0             #CHI-980013
         CALL cl_set_comp_entry("sfa05,sfa161",FALSE) #CHI-980013
      END IF                                   #CHI-980013
   END IF   #TQC-990052
   #FUN-A50066--begin--add---------
   IF g_sma.sma541='Y' THEN
      IF g_sma.sma542 = 'N' OR g_sfb.sfb93 <> 'Y' THEN
         CALL cl_set_comp_entry("sfa012,sfa013",FALSE)
      ELSE
         CALL cl_set_comp_entry("sfa08",FALSE)
      END IF
   END IF
   #FUN-A50066--end--add---------

END FUNCTION

FUNCTION i301_b_move_to()
   LET g_sfa[l_ac].sfa27 = b_sfa.sfa27
   LET g_sfa[l_ac].sfa08 = b_sfa.sfa08
   LET g_sfa[l_ac].sfa26 = b_sfa.sfa26
   LET g_sfa[l_ac].sfa28 = b_sfa.sfa28
   LET g_sfa[l_ac].sfa03 = b_sfa.sfa03
   LET g_sfa[l_ac].sfa11 = b_sfa.sfa11
   LET g_sfa[l_ac].sfa12 = b_sfa.sfa12
   LET g_sfa[l_ac].sfa13 = b_sfa.sfa13
   IF g_sfa[l_ac].sfa26 NOT MATCHES '[SUZ]' THEN   #FUN-A20037 add 'Z'
       LET g_sfa[l_ac].sfa161=g_sfa[l_ac].sfa05/g_sfb.sfb08
   END IF
   LET g_sfa[l_ac].sfa161= b_sfa.sfa161
   LET g_sfa[l_ac].sfa05 = b_sfa.sfa05
   LET g_sfa[l_ac].sfa06 = b_sfa.sfa06
   LET g_sfa[l_ac].sfa062= b_sfa.sfa062
   LET g_sfa[l_ac].sfa063= b_sfa.sfa063
   LET g_sfa[l_ac].sfa064= b_sfa.sfa064
   LET g_sfa[l_ac].sfa065= b_sfa.sfa065
   LET g_sfa29[l_ac] = b_sfa.sfa29
   LET g_sfa[l_ac].sfa30 = b_sfa.sfa30
   LET g_sfa[l_ac].sfa31 = b_sfa.sfa31
   LET g_sfa[l_ac].sfa36 = b_sfa.sfa36    #FUN-950088 add
   LET g_sfa[l_ac].sfa100 = b_sfa.sfa100  #NO:7075
   LET g_sfa[l_ac].sfa012 = b_sfa.sfa012  #FUN-A50066
   LET g_sfa[l_ac].sfa013 = b_sfa.sfa013  #FUN-A50066
   LET g_sfa[l_ac].sfaud01 = b_sfa.sfaud01
   LET g_sfa[l_ac].sfaud02 = b_sfa.sfaud02
   LET g_sfa[l_ac].sfaud03 = b_sfa.sfaud03
   LET g_sfa[l_ac].sfaud04 = b_sfa.sfaud04
   LET g_sfa[l_ac].sfaud05 = b_sfa.sfaud05
   LET g_sfa[l_ac].sfaud06 = b_sfa.sfaud06
   LET g_sfa[l_ac].sfaud07 = b_sfa.sfaud07
   LET g_sfa[l_ac].sfaud08 = b_sfa.sfaud08
   LET g_sfa[l_ac].sfaud09 = b_sfa.sfaud09
   LET g_sfa[l_ac].sfaud10 = b_sfa.sfaud10
   LET g_sfa[l_ac].sfaud11 = b_sfa.sfaud11
   LET g_sfa[l_ac].sfaud12 = b_sfa.sfaud12
   LET g_sfa[l_ac].sfaud13 = b_sfa.sfaud13
   LET g_sfa[l_ac].sfaud14 = b_sfa.sfaud14
   LET g_sfa[l_ac].sfaud15 = b_sfa.sfaud15
END FUNCTION

FUNCTION i301_b_move_back()
   LET b_sfa.sfa01 = g_sfb.sfb01
   LET b_sfa.sfa02 = g_sfb.sfb02
   LET b_sfa.sfa27 = g_sfa[l_ac].sfa27
   LET b_sfa.sfa08 = g_sfa[l_ac].sfa08
   LET b_sfa.sfa26 = g_sfa[l_ac].sfa26
   LET b_sfa.sfa28 = g_sfa[l_ac].sfa28
   LET b_sfa.sfa03 = g_sfa[l_ac].sfa03
   LET b_sfa.sfa11 = g_sfa[l_ac].sfa11
   LET b_sfa.sfa12 = g_sfa[l_ac].sfa12
   LET b_sfa.sfa13 = g_sfa[l_ac].sfa13
   LET b_sfa.sfa161= g_sfa[l_ac].sfa161
   LET b_sfa.sfa05 = g_sfa[l_ac].sfa05
   LET b_sfa.sfa06 = g_sfa[l_ac].sfa06
   LET g_sfa[l_ac].short_qty = g_sfa[l_ac].short_qty  #FUN-940008 add
   LET b_sfa.sfa062= g_sfa[l_ac].sfa062
   LET b_sfa.sfa063= g_sfa[l_ac].sfa063
   LET b_sfa.sfa064= g_sfa[l_ac].sfa064
   LET b_sfa.sfa065= g_sfa[l_ac].sfa065
   LET b_sfa.sfa29 = g_sfa29[l_ac]
   IF cl_null(b_sfa.sfa29) THEN LET b_sfa.sfa29=g_sfb.sfb05 END IF #MOD-4A0157
   LET b_sfa.sfa30 = g_sfa[l_ac].sfa30
   LET b_sfa.sfa31 = g_sfa[l_ac].sfa31
   LET b_sfa.sfa36 = g_sfa[l_ac].sfa36     #FUN-950088 add
   LET b_sfa.sfa100 = g_sfa[l_ac].sfa100   #NO:7075
   LET b_sfa.sfa012 = g_sfa[l_ac].sfa012   #FUN-A50066
   LET b_sfa.sfa013 = g_sfa[l_ac].sfa013   #FUN-A50066
   LET b_sfa.sfaud01 = g_sfa[l_ac].sfaud01
   LET b_sfa.sfaud02 = g_sfa[l_ac].sfaud02
   LET b_sfa.sfaud03 = g_sfa[l_ac].sfaud03
   LET b_sfa.sfaud04 = g_sfa[l_ac].sfaud04
   LET b_sfa.sfaud05 = g_sfa[l_ac].sfaud05
   LET b_sfa.sfaud06 = g_sfa[l_ac].sfaud06
   LET b_sfa.sfaud07 = g_sfa[l_ac].sfaud07
   LET b_sfa.sfaud08 = g_sfa[l_ac].sfaud08
   LET b_sfa.sfaud09 = g_sfa[l_ac].sfaud09
   LET b_sfa.sfaud10 = g_sfa[l_ac].sfaud10
   LET b_sfa.sfaud11 = g_sfa[l_ac].sfaud11
   LET b_sfa.sfaud12 = g_sfa[l_ac].sfaud12
   LET b_sfa.sfaud13 = g_sfa[l_ac].sfaud13
   LET b_sfa.sfaud14 = g_sfa[l_ac].sfaud14
   LET b_sfa.sfaud15 = g_sfa[l_ac].sfaud15
   LET b_sfa.sfaplant = g_plant #FUN-980008 add
   LET b_sfa.sfalegal = g_legal #FUN-980008 add
END FUNCTION

FUNCTION i301_b_else()
   IF g_sfa[l_ac].sfa05 IS NULL THEN LET g_sfa[l_ac].sfa05 =0 END IF
   IF g_sfa[l_ac].sfa06 IS NULL THEN LET g_sfa[l_ac].sfa06 =0 END IF
   IF g_sfa[l_ac].short_qty IS NULL THEN LET g_sfa[l_ac].short_qty =0 END IF  #FUN-940008 add
END FUNCTION

FUNCTION i301_bu()
   DEFINE l_sfa         RECORD LIKE sfa_file.*
   DEFINE l_sfa05       LIKE sfa_file.sfa05    #No.FUN-680121 DEC(15,3)
   DEFINE p_cmd         LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
   DEFINE i,s           LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE l_ima64       LIKE ima_file.ima64
   DEFINE l_ima641      LIKE ima_file.ima641
   DEFINE l_double      LIKE type_file.num10   #No.FUN-680121 INTEGER
#  DEFINE l_qty         LIKE ima_file.ima26    #No.FUN-680121 DEC(15,3)
   DEFINE l_qty         LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_sfa05_t     LIKE sfa_file.sfa05
   DEFINE l_sfa26_t     LIKE sfa_file.sfa26

   LET g_success = 'Y'
   IF g_sfa[l_ac].sfa26 MATCHES '[SUTZ]' THEN      #FUN-A20037 add 'Z'
      SELECT * INTO l_sfa.* FROM sfa_file
       WHERE sfa01 = g_sfb.sfb01       AND sfa03 = g_sfa[l_ac].sfa27
         AND sfa08 = g_sfa[l_ac].sfa08 AND sfa12 = g_sfa[l_ac].sfa12
         AND sfa012= g_sfa[l_ac].sfa012 AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066
      IF STATUS THEN
        CALL cl_err3("sel","sfa_file",g_sfb.sfb01,g_sfa[l_ac].sfa27,STATUS,"","sel orignal sfa:",1)   #No.FUN-660128
          RETURN END IF

      IF l_sfa.sfa26='0' THEN
         CALL cl_err('','mfg6201',1)
         RETURN
      END IF

      SELECT SUM(sfa05/sfa28) INTO l_sfa05 FROM sfa_file
         WHERE sfa01 = g_sfb.sfb01       AND sfa27 = g_sfa[l_ac].sfa27
           AND sfa08 = g_sfa[l_ac].sfa08 AND sfa12 = g_sfa[l_ac].sfa12
           AND sfa26 IN ('S','U','T','Z')  #FUN-A20037 add 'Z'
           AND sfa012= g_sfa[l_ac].sfa012 AND sfa013=g_sfa[l_ac].sfa013  #FUN-A50066

      IF l_sfa05 IS NULL THEN LET l_sfa05=0 END IF

      LET l_qty = g_sfb.sfb08 * l_sfa.sfa161
      LET l_sfa.sfa05=l_qty-l_sfa05
      LET l_sfa.sfa05 = s_digqty(l_sfa.sfa05,g_sfa[l_ac].sfa12)   #FUN-910088--add--
      IF l_sfa.sfa26='1' THEN LET l_sfa.sfa26='3' END IF
      IF l_sfa.sfa26='2' THEN LET l_sfa.sfa26='4' END IF
      IF l_sfa.sfa26='7' THEN LET l_sfa.sfa26='8' END IF  #FUN-A20037 add

      UPDATE sfa_file SET sfa26=l_sfa.sfa26,
                          sfa05=l_sfa.sfa05
       WHERE sfa01 = g_sfb.sfb01       AND sfa03 = g_sfa[l_ac].sfa27
         AND sfa08 = g_sfa[l_ac].sfa08 AND sfa12 = g_sfa[l_ac].sfa12
         AND sfa27 = g_sfa[l_ac].sfa27 #CHI-7B0034
         AND sfa012 = g_sfa[l_ac].sfa012   #FUN-A50066
         AND sfa013 = g_sfa[l_ac].sfa013   #FUN-A50066
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_err3("upd","sfa_file",g_sfb.sfb01,g_sfa[l_ac].sfa27,STATUS,"","upd sfa:",1)  #No.FUN-660128
         LET g_success = "N"
      END IF
   END IF

END FUNCTION

FUNCTION i301_sfa05()   #no.5173 add
   DEFINE l_ima64       LIKE ima_file.ima64,
          l_ima641      LIKE ima_file.ima641,
          l_gfe03       LIKE gfe_file.gfe03,
          l_num_y       LIKE sfa_file.sfa05,     #No.TQC-760038
          l_num_z       LIKE type_file.num20     #No.TQC-760038

   LET g_errno = ' '
   IF NOT g_sfa[l_ac].sfa26 MATCHES '[3468]' THEN   #MOD-BB0005 add
      SELECT ima64,ima641 INTO l_ima64,l_ima641 FROM ima_file
     # WHERE ima01=g_sfa[l_ac].sfa27   #MOD-A70105 mark
       WHERE ima01=g_sfa[l_ac].sfa03   #MOD-A70105
      IF STATUS THEN LET l_ima64 = 0 LET l_ima641 = 0 END IF
      #check最少發料數量
     #IF l_ima641 <>  0 AND g_sfa[l_ac].sfa05 < l_ima641 THEN #TQC-C30300
      IF l_ima641 <>  0 AND g_sfa[l_ac].sfa05 < l_ima641 AND g_sfa[l_ac].sfa05 !=0 THEN #TQC-C30300
         LET g_errno = 'asf-100'
      END IF
      LET l_num_z=g_sfa[l_ac].sfa05/l_ima64
      LET l_num_y=g_sfa[l_ac].sfa05-l_num_z*l_ima64
     #IF l_ima64 <> 0 AND (l_num_y) > 0 THEN   #No.TQC-760038
      IF l_ima64 <> 0 AND (l_num_y) <> 0 THEN   #No.TQC-760038 #TQC-B40221 未考慮四捨五入情況
         LET g_errno = 'asf-101'
      END IF
   END IF   #MOD-BB0005 add

END FUNCTION

FUNCTION i301_sub_chk(p_wo)
   DEFINE p_wo          LIKE sfb_file.sfb01  #No.FUN-680121 VARCHAR(16)     #No.FUN-550067
   DEFINE l_sfb08       LIKE sfb_file.sfb08  #No.FUN-680121 DEC(15,3)
#  DEFINE l_bomqty      LIKE ima_file.ima26  #No.FUN-680121 DEC(15,3)
   DEFINE l_bomqty      LIKE type_file.num15_3    ###GP5.2  #NO.FUN-A20044
#  DEFINE l_aloqty      LIKE ima_file.ima26  #No.FUN-680121 DEC(15,3)
   DEFINE l_aloqty      LIKE type_file.num15_3    ###GP5.2  #NO.FUN-A20044
#  DEFINE l_difqty      LIKE ima_file.ima26  #No.FUN-680121 DEC(15,3)
   DEFINE l_difqty      LIKE type_file.num15_3    ###GP5.2  #NO.FUN-A20044
   DEFINE l_sfa         RECORD LIKE sfa_file.*
   #TQC-B80092  --begin
   DEFINE asf001        LIKE type_file.chr1000
   DEFINE asf002        LIKE type_file.chr1000
   DEFINE asf003        LIKE type_file.chr1000
   DEFINE asf004        LIKE type_file.chr1000
   #TQC-B80092  --end

   SELECT sfb08 INTO l_sfb08 FROM sfb_file WHERE sfb01=p_wo

   DECLARE i301_sub_chk_c CURSOR FOR
      SELECT * FROM sfa_file WHERE sfa01=p_wo AND sfa26 IN ('3','4','6','8') #No:8765  #FUN-A20037 add '8'

   FOREACH i301_sub_chk_c INTO l_sfa.*                     #bugno:7111 add '6'
      SELECT SUM(sfa05/sfa28) INTO l_aloqty FROM sfa_file
             WHERE sfa01=p_wo        AND sfa27=l_sfa.sfa27
               AND sfa08=l_sfa.sfa08 AND sfa12=l_sfa.sfa12
               AND sfa012=l_sfa.sfa012   #FUN-A50066
               AND sfa013=l_sfa.sfa013   #FUN-A50066
      LET l_aloqty = s_digqty(l_aloqty,l_sfa.sfa012)   #FUN-910088--add--
      IF l_aloqty IS NULL THEN LET l_aloqty = 0 END IF
      LET l_bomqty=l_sfb08*l_sfa.sfa161
      LET l_difqty=l_bomqty-l_aloqty
      IF l_aloqty<>l_bomqty THEN
      #TQC-B80092  --begin
         CALL cl_getmsg('asf001',g_lang) RETURNING asf001
         CALL cl_getmsg('asf002',g_lang) RETURNING asf002
         CALL cl_getmsg('asf003',g_lang) RETURNING asf003
         CALL cl_getmsg('asf004',g_lang) RETURNING asf004
         PROMPT  asf001 CLIPPED,': ',l_sfa.sfa27,
                 asf002 CLIPPED,': ',l_bomqty,
                 asf003 CLIPPED,': ',l_aloqty,
                 asf004 CLIPPED,': ',l_difqty,
                ":" FOR CHAR g_chr
        # PROMPT " 料號:",l_sfa.sfa27,
        #        " BOM應發:",l_bomqty,
        #        " W/O備料:",l_aloqty,
        #        " 差異:",l_difqty,
        #        ":" FOR CHAR g_chr
       #TQC-B80092  --end
             ON IDLE g_idle_seconds
                CALL cl_on_idle()

             ON ACTION about
                CALL cl_about()

             ON ACTION controlg
                CALL cl_cmdask()

             ON ACTION help
                CALL cl_show_help()
          END PROMPT
      END IF
   END FOREACH

END FUNCTION

FUNCTION i301_b_askkey()
DEFINE l_wc2           LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(200)

    CONSTRUCT l_wc2 ON sfa012,sfa013,sfa27,sfa08,sfa26,sfa28,sfa03,  #FUN-A50066
                       sfa12,sfa161,sfa05,sfa065,sfa06,
                       sfa062,
                       sfa063,sfa064
            FROM s_sfa[1].sfa012,s_sfa[1].sfa013,    #FUN-A50066
                 s_sfa[1].sfa27, s_sfa[1].sfa08, s_sfa[1].sfa26,
                 s_sfa[1].sfa28, s_sfa[1].sfa03, s_sfa[1].sfa12,
                 s_sfa[1].sfa161, s_sfa[1].sfa05, s_sfa[1].sfa065,
                 s_sfa[1].sfa06, s_sfa[1].sfa062,
                 s_sfa[1].sfa063, s_sfa[1].sfa064

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

    CALL i301_b_fill(l_wc2)
END FUNCTION

FUNCTION i301_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2          STRING, #No.FUN-680121 VARCHAR(800)
       l_ima021       LIKE ima_file.ima021
DEFINE l_ima571       LIKE ima_file.ima571  #MOD-AC0336
DEFINE l_flag         LIKE type_file.num5   #MOD-AC0336

      LET g_sql =
          "SELECT sfa012,'',sfa013,sfa27,sfa08,sfa26,sfa28,sfa03,ima02,ima021,ima08,",   #FUN-A50066
          " sfa12,'',sfa13,sfa11,sfa16,sfa161,sfa100,sfa05,'','',sfa065,sfa06,'',sfa062,",   #FUN-B50095 add sfa16
        #  " sfaud02,sfaud03,sfaud04,sfaud05,",
         " sfaud02,'',sfaud03,sfaud04,sfaud05,", #modify by chuyl 140116
          " '','',sfa063,sfa064,'',sfa30,sfa31,sfa36,'','' ,",    #FUN-940008 sfa07-->'' #FUN-950088 add sfa36,'' #FUN-C30274 add sfaiicd06''
          "sfaud01,",
          "sfaud06,sfaud07,sfaud08,sfaud09,sfaud10,",
          "sfaud11,sfaud12,sfaud13,sfaud14,sfaud15,",
          "ima021, sfa29 ",
          " FROM sfa_file LEFT OUTER JOIN ima_file ON sfa03 = ima01 ",
          " WHERE sfa01 ='",g_sfb.sfb01,"'",  #單頭
          "   AND  ",p_wc2 CLIPPED,                     #單身
          " ORDER BY sfa012,sfa013,sfa08,sfa27,sfa26"  #FUN-A50066

    PREPARE i301_pb FROM g_sql
    DECLARE sfa_curs CURSOR FOR i301_pb

    CALL g_sfa.clear()
    CALL g_sfa29.clear()

    LET l_ima021 = NULL
    LET g_cnt = 1

   #單身 ARRAY 填充
    FOREACH sfa_curs INTO g_sfa[g_cnt].*,l_ima021,g_sfa29[g_cnt]
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
      CALL s_shortqty(g_sfb.sfb01,g_sfa[g_cnt].sfa03,g_sfa[g_cnt].sfa08,
                      g_sfa[g_cnt].sfa12,g_sfa[g_cnt].sfa27,
                      g_sfa[g_cnt].sfa012,g_sfa[g_cnt].sfa013)  #FUN-A50066
              RETURNING g_short_qty
      IF cl_null(g_short_qty) THEN LET g_short_qty = 0 END IF
      LET g_sfa[g_cnt].short_qty = g_short_qty

       #add by chuyl 140116----str
      #SELECT SUM(sfe35) INTO g_sfa[g_cnt].sumsfe FROM sfe_file WHERE sfe01 = g_sfb.sfb01
       SELECT SUM(CASE sfe06 WHEN '1' THEN sfe35 WHEN '2' THEN sfe35 WHEN '3' THEN sfe35 WHEN '4' THEN -1*sfe35 END)
         INTO g_sfa[g_cnt].sumsfe FROM sfe_file WHERE sfe01=g_sfb.sfb01
          AND sfe07 = g_sfa[g_cnt].sfa03 AND  sfe14 = g_sfa[g_cnt].sfa08
       #add by chuyl 140116----end
        SELECT mse02 INTO g_sfa[g_cnt].mse02
          FROM mse_file WHERE mse01=g_sfa[g_cnt].sfa36
       #FUN-B10056 -------------mod start---------
       #CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571  #MOD-AC0336
       #SELECT ecu014 INTO g_sfa[g_cnt].ecu014 FROM ecu_file   #FUN-A50066
       # WHERE ecu01=l_ima571 AND ecu012 = g_sfa[g_cnt].sfa012       #FUN-A50066 #MOD-AC0336
       #   AND ecu02=g_sfb.sfb06    #FUN-A50066
        CALL s_schdat_ecm014(g_sfb.sfb01,g_sfa[g_cnt].sfa012) RETURNING g_sfa[g_cnt].ecu014
       #FUN-B10056 ------------mod end------------
        LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
    END FOREACH
    CALL g_sfa.deleteElement(g_cnt)
    LET g_rec_b=g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2
    LET g_cnt = 0

END FUNCTION

FUNCTION i301_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY g_sfa TO s_sfa.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         IF g_sma.sma901 != 'Y' THEN
             CALL cl_set_act_visible("aps_related_data",FALSE)
             CALL cl_set_act_visible("aps_route_subc_data",FALSE) #FUN-850115
         END IF

      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

      #FUN-CB0014---add---str---
      ON ACTION page_list
         LET g_action_flag = "page_list"
         EXIT DISPLAY
      #FUN-CB0014---add---end---
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
#FUN-9C0119--add--begin
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
#FUN-9C0119--add--end
      ON ACTION first
         CALL i301_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION previous
         CALL i301_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION jump
         CALL i301_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION next
         CALL i301_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION last
         CALL i301_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
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
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         CALL i301_ui_default()
         CALL i301_pic()  #圖形顯示   #FUN-730012
         EXIT DISPLAY
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION agree           #准
         LET g_action_choice = "agree"
         EXIT DISPLAY

      ON ACTION deny            #不准
         LET g_action_choice = "deny"
         EXIT DISPLAY

      ON ACTION modify_flow     #加簽
         LET g_action_choice = "modify_flow"
         EXIT DISPLAY

      ON ACTION withdraw        #撤簽
         LET g_action_choice = "withdraw"
         EXIT DISPLAY

      ON ACTION org_withdraw    #抽單
         LET g_action_choice = "org_withdraw"
         EXIT DISPLAY

      ON ACTION phrase          #簽核意見
         LET g_action_choice = "phrase"
         EXIT DISPLAY
      #--FUN-8C0081--end--

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY

      ON ACTION openurl
         LET g_action_choice="openurl"
         EXIT DISPLAY

#@    ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY

#@    ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY

#@    ON ACTION 维护气塞字样
      ON ACTION cooi301
         LET g_action_choice="cooi301"
         EXIT DISPLAY

#@    ON ACTION 加工费用结算
      ON ACTION js   #加工费用结算
         LET g_action_choice="js"
         EXIT DISPLAY

#@    ON ACTION 加工淡季月度维护
      ON ACTION cooi500   #加工淡季月度维护
         LET g_action_choice="cooi500"
         EXIT DISPLAY

#@    ON ACTION 可结案
      ON ACTION confirm1
         LET g_action_choice="confirm1"
         EXIT DISPLAY

#@    ON ACTION 取消可结案
      ON ACTION undo_confirm1
         LET g_action_choice="undo_confirm1"
         EXIT DISPLAY

#@    ON ACTION 工单结案
      ON ACTION asfp400
         LET g_action_choice='asfp400'
         EXIT DISPLAY

#@    ON ACTION 產生備料
      ON ACTION gen_allotment
         LET g_action_choice="gen_allotment"
         EXIT DISPLAY
#@    ON ACTION 刪除備料
      ON ACTION delete_allotment
         LET g_action_choice="delete_allotment"
         EXIT DISPLAY
      # add by lixwz 20170928 s
#@    ON ACTION 从BOM取包材
      ON ACTION get_bom
         LET g_action_choice="get_bom"
         EXIT DISPLAY
      # add by lixwz 20170928 e
#@    ON ACTION 库存状况查询
      ON ACTION aimq103
         LET g_action_choice="aimq103"
         EXIT DISPLAY
#@    ON ACTION 庫存資料
      ON ACTION inventory
         LET g_action_choice="inventory"
         EXIT DISPLAY
#@    ON ACTION 狀況查詢
      ON ACTION status_query
         LET g_action_choice="status_query"
         EXIT DISPLAY
#@    ON ACTION 供需
      ON ACTION demand_supply
         LET g_action_choice="demand_supply"
         EXIT DISPLAY
#@    ON ACTION 替代
      ON ACTION sub
         LET g_action_choice="sub"
         EXIT DISPLAY
#@    ON ACTION 挪料                       #MOD-A50141 mod #工單變更/挪料->挪料
      ON ACTION mat_shift                  #MOD-A50141 mod #wo_change_mat_shift->mat_shift
         LET g_action_choice="mat_shift"   #MOD-A50141 mod
         EXIT DISPLAY
#@    ON ACTION 訂單相關查詢
      ON ACTION order_query
         LET g_action_choice="order_query"
         EXIT DISPLAY
#@    ON ACTION 委外採購
      ON ACTION sub_p_o
         LET g_action_choice="sub_p_o"
         EXIT DISPLAY
#@    ON ACTION 產生製程
      ON ACTION gen_routing
         LET g_action_choice="gen_routing"
         EXIT DISPLAY
#@    ON ACTION 製程
      ON ACTION routing
         LET g_action_choice="routing"
         EXIT DISPLAY
#@    ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY
#@    ON ACTION 序號維護
      ON ACTION s_n
         LET g_action_choice="s_n"
         EXIT DISPLAY
#@    ON ACTION 模具領用
      ON ACTION mold_wtdw
         LET g_action_choice="mold_wtdw"
         EXIT DISPLAY
#@    ON ACTION 模具歸還
      ON ACTION mold_return
         LET g_action_choice="mold_return"
         EXIT DISPLAY
      ON ACTION run_card
         LET g_action_choice="run_card"
         EXIT DISPLAY
#@    ON ACTION EasyFlow送簽
      ON ACTION easyflow_approval
         LET g_action_choice="easyflow_approval"
         EXIT DISPLAY
#@    ON ACTION 簽核狀況
      ON ACTION approval_status
         LET g_action_choice="approval_status"
         EXIT DISPLAY
#@    ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
      #CHI-D20010---begin
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
      #CHI-D20010---end

#No.FUN-630087 on action產生雜發單
      ON ACTION gen_m_iss
         LET g_action_choice="gen_m_iss"
         EXIT DISPLAY
#No.FUN-630087 維護雜發單
      ON ACTION m_iss
         LET g_action_choice="m_iss"
         EXIT DISPLAY

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE         #MOD-570244 mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

     #DEV-D30026--add--begin-----------
      ON ACTION barcode_gen
         LET g_action_choice = 'barcode_gen'
         EXIT DISPLAY

      ON ACTION barcode_query
         LET g_action_choice = 'barcode_query'
         EXIT DISPLAY
     #DEV-D30026--add--end-------------

      #No:DEV-CB0005--add--begin
      ON ACTION barcode_output #條碼列印
         LET g_action_choice = 'barcode_output'
         EXIT DISPLAY
      #No:DEV-CB0005--add--end

      ON ACTION CONTROLS
         CALL cl_set_head_visible("","AUTO")

      ON ACTION related_document                #No.FUN-6A0164  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      ON ACTION aps_related_data
         LET g_action_choice = 'aps_related_data'
         EXIT DISPLAY

      ON ACTION aps_route_subc_data
         LET g_action_choice = 'aps_route_subc_data'
         EXIT DISPLAY

      #CHI-A50032 add --start--
      ON ACTION wo_change #工單變更
         LET g_action_choice="wo_change"
         EXIT DISPLAY
      #CHI-A50032 add --end--

      #add by lanhang 131125
      ON ACTION sfa_detail
         LET g_action_choice="sfa_detail"
         EXIT DISPLAY
      #add by lanhang 131125
      &include "qry_string.4gl"

   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION


FUNCTION i301_out()
    DEFINE l_no   LIKE oea_file.oea01    #No.FUN-680121 VARCHAR(16)   #No.FUN-550067
    DEFINE l_memo LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
    DEFINE l_mark LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
    DEFINE l_sw   LIKE type_file.num5    #No.FUN-680121 SMALLINT
    DEFINE l_sw1  LIKE type_file.num5    #No.FUN-680121 SMALLINT

    IF g_sfb.sfb01 IS NULL THEN RETURN END IF
    LET l_no=g_sfb.sfb01


     LET g_cnt =0
     IF NOT cl_null(g_sfb.sfb22) THEN
        SELECT COUNT(*) INTO g_cnt FROM oeb_file
         WHERE oeb01= g_sfb.sfb22
           AND oeb03= g_sfb.sfb221
     END IF
    IF g_cnt > 0 THEN
    #IF cl_confirm('asf-930') THEN
    #   LET l_memo = 'Y'
    #ELSE
       LET l_memo = 'N'
    #END IF
    #IF cl_confirm('asf-931') THEN
    #   LET l_mark = 'Y'
    #ELSE
       LET l_mark = 'N'
    #END IF
    END IF   #MOD-860125 add

    LET g_wc = 'sfb01 = "',l_no,'"'
   MENU
   # LET g_sql = "asfr102 ",  #FUN-C30085 mark
#     LET g_sql = "asfg102 ",  #mark by wangxh131126
      ON ACTION csfr301
        LET g_sql = "csfr301 ",  #131126 add by wangxh
                    " '",g_today,"'",
                    " '",g_user,"'",
                    " '",g_lang,"'", #  " '0'",  #MOD-530280-11
                    " 'Y'",
                    " ' '",
                    " '1'",
                    " '",g_wc clipped,"'",
                    " 'Y'",
                    " 'N'",
                    " '",l_memo,"'",
                    " '",l_mark,"'",
                    " 'Y'"             #TQC-630013
        CALL cl_cmdrun(g_sql)
      ON ACTION csfr310
        LET g_sql = "csfr320 ",  #131126 add by wangxh
                    " '",g_today,"'",
                    " '",g_user,"'",
                    " '",g_lang,"'", #  " '0'",  #MOD-530280-11
                    " 'Y'",
                    " ' '",
                    " '1'",
                    " '",g_wc clipped,"'"
        CALL cl_cmdrun(g_sql)

      ON ACTION EXIT
         EXIT MENU
      ON ACTION CANCEL
         EXIT MENU
   END MENU
END FUNCTION

FUNCTION i301_sub()     #bugno:7111 add
  DEFINE tm RECORD
         a               LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
         END RECORD,
         p_row,p_col     LIKE type_file.num5    #No.FUN-680121 SMALLINT

   #TQC-C70122--add--str--
   IF cl_null(g_sfb.sfb01) THEN
      CALL cl_err('','-400',0)
      RETURN
   END IF
   #TQC-C70122--add--str--

   IF g_sfb.sfb04 = '8' THEN
      CALL cl_err('','9004',1)
      RETURN
   END IF

   LET p_row = 10
   LET p_col = 35

   OPEN WINDOW t301_sub_w AT p_row,p_col WITH FORM "asf/42f/asfi301g"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("asfi301g")

   LET tm.a='1' #MOD-640425
   DISPLAY BY NAME tm.a #MOD-640425

   INPUT BY NAME tm.a WITHOUT DEFAULTS
      AFTER FIELD a
           #IF tm.a NOT MATCHES '[012]' THEN    #FUN-A20037
            IF tm.a NOT MATCHES '[0123]' THEN   #FUN-A20037
               NEXT FIELD a
            END IF
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW t301_sub_w
      RETURN
   END IF

   CLOSE WINDOW t301_sub_w

   CASE tm.a
        WHEN '0'     RETURN
        WHEN '1'     CALL i301_s()               #一般替代
        WHEN '2'     CALL i301f(g_sfb.sfb01)     #set替代
        WHEN '3'     CALL i301e()                #規則替代  #FUN-A20037    #FUN-A40032
   END CASE

  #MOD-A90069 add --start--
  #MOD-A90069 add --end--

   CALL i301_b_fill('1=1')

END FUNCTION

FUNCTION i301e()
   DEFINE old_part          LIKE ima_file.ima01
   DEFINE old_sfa08         LIKE sfa_file.sfa08
   DEFINE l_ima02           LIKE ima_file.ima02
   DEFINE l_ima021          LIKE ima_file.ima021
   DEFINE l_ima022          LIKE ima_file.ima022
   DEFINE l_ima109          LIKE ima_file.ima109
   DEFINE i,j               LIKE type_file.num5
#  DEFINE old_qty           LIKE ima_file.ima26
#  DEFINE left_qty          LIKE ima_file.ima26
   DEFINE old_qty           LIKE type_file.num15_3    ###GP5.2  #NO.FUN-A20044
   DEFINE left_qty          LIKE type_file.num15_3    ###GP5.2  #NO.FUN-A20044
   DEFINE old_sfa26         LIKE sfa_file.sfa26
   DEFINE l_sfa      RECORD LIKE sfa_file.*
   DEFINE lr_sfa     RECORD LIKE sfa_file.*

   DEFINE l_bon04           LIKE bon_file.bon04
   DEFINE l_bon05           LIKE bon_file.bon05
   DEFINE l_bon06           LIKE bon_file.bon06
   DEFINE l_bon07           LIKE bon_file.bon07
   DEFINE l_bon08           LIKE bon_file.bon08
   DEFINE l_bon09           LIKE bon_file.bon09
   DEFINE l_bon10           LIKE bon_file.bon10
   DEFINE l_bon11           LIKE bon_file.bon11
   DEFINE l_tot             LIKE pml_file.pml20
   DEFINE l_qty51           LIKE pml_file.pml20
   DEFINE l_qty52           LIKE pml_file.pml20
   DEFINE l_qty53           LIKE pml_file.pml20
   DEFINE l_qty54           LIKE pml_file.pml20
   DEFINE l_qty55           LIKE pml_file.pml20
   DEFINE l_qty56           LIKE pml_file.pml20
   DEFINE l_qty61           LIKE pml_file.pml20
   DEFINE l_qty62           LIKE pml_file.pml20
   DEFINE l_qty63           LIKE pml_file.pml20

   DEFINE new DYNAMIC ARRAY OF RECORD
          new_part          LIKE sfa_file.sfa03,
         ima02_1           LIKE ima_file.ima02,
          ima021_1          LIKE ima_file.ima021,
          new_rate          LIKE bmd_file.bmd07,
          new_yes           LIKE type_file.chr1,
          new_qty           LIKE pml_file.pml20,
          new_qty3          LIKE pml_file.pml20,
         #ima262            LIKE ima_file.ima262,      #TQC-B30216
          avl_stk           LIKE type_file.num15_3,    ###GP5.2  #NO.FUN-A20044
          new_qty4          LIKE pml_file.pml20,
          new_qty5          LIKE pml_file.pml20,
          new_qty6          LIKE pml_file.pml20,
          new_qty7          LIKE pml_file.pml20,
          new_qty8          LIKE pml_file.pml20
         END RECORD
  DEFINE  l_new DYNAMIC ARRAY OF RECORD
          sfa08            LIKE sfa_file.sfa08,
          sfa12            LIKE sfa_file.sfa12
          END RECORD
 #TQC-CB0043--add--str
  DEFINE l_sic_tot LIKE type_file.num15_3,
         l_sic06   LIKE sic_file.sic06,
         l_sic07_fac LIKE sic_file.sic07_fac
 #TQC-CB0043--add--end

  DEFINE  l_i              LIKE type_file.num5,
          l_allow_insert   LIKE type_file.num5,                #可新增否
          l_allow_delete   LIKE type_file.num5,                #可刪除否
          l_double         LIKE type_file.num10,
          l_ima64          LIKE ima_file.ima64,
          l_ima63          LIKE ima_file.ima63,
          l_ima63_fac      LIKE ima_file.ima63_fac,
          l_ima86          LIKE ima_file.ima86,
          l_ima86_fac      LIKE ima_file.ima86_fac
   DEFINE l_sql            STRING
  #DEFINE l_ima63_a        LIKE ima_file.ima63         #MOD-AC0323 mark
   DEFINE l_sfa05          LIKE sfa_file.sfa05
   DEFINE l_sfa06          LIKE sfa_file.sfa06
   DEFINE l_chr            LIKE type_file.chr1
   DEFINE l_n1             LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_n2             LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_n3             LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_sfai           RECORD LIKE sfai_file.*    #TQC-B80070
   DEFINE l_qty            LIKE sfa_file.sfa05    #CHI-C30077
   DEFINE l_yes_cnt        LIKE type_file.num5    #CHI-C30077

   OPEN WINDOW i301e_sw AT 2,2 WITH FORM "asf/42f/asfi301e"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_locale("asfi301e")

   LET old_sfa08 = ' '
   IF NOT cl_null(l_ac) AND l_ac > 0 THEN #MOD-D60244 ADD by yuhuabao 13/06/28
   LET old_part = g_sfa[l_ac].sfa03  #CHI-C90009
   LET old_sfa08 = g_sfa[l_ac].sfa08 #MOD-D60244 add by yuhuabao 13/06/28  #预设为当前光标对应的单身的作业编号
   END IF                            #MOD-D60244 ADD by yuhuabao 13/06/28
   DISPLAY old_sfa08 TO old_sfa08    #MOD-D60244 ADD by yuhuabao 13/06/28
   DISPLAY old_part TO old_part      #CHI-C90009

   WHILE TRUE
      INPUT BY NAME old_part,old_sfa08 WITHOUT DEFAULTS

          AFTER FIELD old_part
             LET l_ima02 = NULL
             LET l_ima021= NULL
             LET l_ima022= NULL
             LET l_ima109= NULL
            #MOD-AC0323---modify---start---
            #SELECT ima02,ima021,ima022,ima109,ima64,ima63
            #  INTO l_ima02,l_ima021,l_ima022,l_ima109,l_ima64,l_ima63_a
             SELECT ima02,ima021,ima022,ima109,ima64
               INTO l_ima02,l_ima021,l_ima022,l_ima109,l_ima64
            #MOD-AC0323---modify---end---
               FROM ima_file
              WHERE ima01=old_part
             DISPLAY l_ima02  TO FORMONLY.ima02
             DISPLAY l_ima021 TO FORMONLY.ima021
             DISPLAY l_ima022 TO FORMONLY.ima022
             DISPLAY l_ima109 TO FORMONLY.ima109

         AFTER FIELD old_sfa08
             IF cl_null(old_sfa08) THEN
                LET old_sfa08 = ' '
            END IF

       ON ACTION controlp
           CASE
              WHEN INFIELD(old_part)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form  = "q_sfa101"   #copy from q_sfa10
                  LET g_qryparam.arg1  = g_sfb.sfb01
                  CALL cl_create_qry() RETURNING old_sfa08,old_part
                  IF cl_null(old_sfa08) THEN
                     LET old_sfa08 = ' '
                  END IF
                  DISPLAY old_part  TO FORMONLY.old_part
                  DISPLAY old_sfa08 TO FORMONLY.old_sfa08
                  NEXT FIELD old_part
           END CASE

          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE INPUT

          ON ACTION about
            CALL cl_about()

          ON ACTION controlg
            CALL cl_cmdask()

          ON ACTION help
             CALL cl_show_help()
      END INPUT

      IF INT_FLAG THEN
         LET INT_FLAG=0
         CLOSE WINDOW i301e_sw
         EXIT WHILE
      END IF
      IF old_part IS NULL THEN
         CLOSE WINDOW i301e_sw
         EXIT WHILE
      END IF

      SELECT * INTO l_sfa.* FROM sfa_file
       WHERE sfa01 = g_sfb.sfb01
         AND sfa03 = old_part
         AND sfa08 = old_sfa08
         AND sfa27 = old_part
        #AND sfa12 = l_ima63_a             #MOD-AC0323 mark

      IF STATUS THEN
         CALL cl_err3("sel","sfa_file",g_sfb.sfb01,old_part,STATUS,"","sel sfa",1)
         CONTINUE WHILE
      END IF
      #CHI-C30077---begin
      SELECT SUM((sfa05-sfa06)*sfa28)
        INTO l_qty
        FROM sfa_file
       WHERE sfa01 = g_sfb.sfb01
         AND sfa08 = old_sfa08
         AND sfa27 = old_part
         AND sfa26 = 'Z'
      IF cl_null(l_qty) THEN LET l_qty = 0 END IF
      #CHI-C30077---end
      LET l_sfa.sfa27 = l_sfa.sfa03
      #LET left_qty = l_sfa.sfa05                 #應發數量 #CHI-C30077
      LET left_qty = l_sfa.sfa05 + l_qty  #CHI-C30077
      #LET old_qty = l_sfa.sfa05 - l_sfa.sfa06    #未發量 #CHI-C30077
      LET old_qty = l_sfa.sfa05 - l_sfa.sfa06 + l_qty  #CHI-C30077
      DISPLAY BY NAME l_sfa.sfa26,old_qty

      IF l_sfa.sfa26 NOT MATCHES '[78Z]' THEN
         CALL cl_err('','mfg6201',1)
         CONTINUE WHILE
      END IF

      IF old_qty <=0 THEN
          CALL cl_err('','mfg6181',1)
          CONTINUE WHILE
      END IF
      LET old_sfa26=l_sfa.sfa26
#FUN-B90008 --START mark--
#      SELECT bon04,bon05,bon06,bon07,bon08,bon10,bon11
#        INTO l_bon04,l_bon05,l_bon06,l_bon07,l_bon08,l_bon10,l_bon11
#        FROM bon_file,bmb_file,ima_file
#       WHERE bmb01 = bon02 AND bmb03 = bon01 AND bmb16 ='7'
#         AND bon01 = old_part
#         AND (bon02 = l_sfa.sfa29 OR bon02 = '*')
#         AND bonacti = 'Y'
#         AND ima01 = bon02
#
#     IF cl_null(l_bon07) THEN LET l_bon07 = ' ' END IF
#     IF cl_null(l_bon08) THEN LET l_bon08 = ' ' END IF
#     IF cl_null(l_bon10) THEN LET l_bon10 = ' ' END IF
#
#     DECLARE i301e_sc CURSOR FOR
##     SELECT ima01,ima02,ima021,'','N',0,0,ima262,0,0,0,0,0  #NO.FUN-A20044
#      SELECT ima01,ima02,ima021,'','N',0,0,0,0,0,0,0,0       #NO.FUN-A20044
#        FROM ima_file
#       WHERE ima251 = l_bon06
#         AND ima022 BETWEEN l_bon04 AND l_bon05
##TQC-B40211 --begin--
##        AND ima109 = l_bon07
##        AND ima54 = l_bon08
#         AND (ima109 = l_bon07 OR ima109 IS NULL)
#         AND (ima54  = l_bon08 OR ima54 IS NULL)
##TQC-B40211 --end--
#         AND ima01 != old_part
##FUN-B90008 --END mark--

      #FUN-B90008 --START--
      DELETE FROM i301_tmp2
      #替代規則
      DECLARE i301_bon_sc CURSOR FOR
       SELECT bon04,bon05,bon06,bon07,bon08,bon10,bon11
        FROM bon_file,bmb_file,ima_file
       WHERE bmb01 = bon02 AND bmb03 = bon01 AND bmb16 ='7'
         AND bon01 = old_part
         AND (bon02 = l_sfa.sfa29 OR bon02 = '*')
         AND bonacti = 'Y'
         AND ima01 = bon02

      FOREACH i301_bon_sc INTO l_bon04,l_bon05,l_bon06,l_bon07,l_bon08,l_bon10,l_bon11
         IF SQLCA.SQLCODE THEN
            CALL cl_err('foreach',STATUS,0)
            CONTINUE WHILE
         END IF
         IF cl_null(l_bon07) THEN LET l_bon07 = ' ' END IF
         IF cl_null(l_bon08) THEN LET l_bon08 = ' ' END IF
         IF cl_null(l_bon10) THEN LET l_bon10 = ' ' END IF
         #加入暫存以便過濾重覆資料
         LET g_sql = "INSERT INTO i301_tmp2",
                     " SELECT ima01,ima02,ima021,'','N',0,0,0,0,0,0,0,0",
                     " FROM ima_file",
                     " WHERE ima251 = '", l_bon06, "'",
                     " AND ima022 BETWEEN ", l_bon04, " AND ", l_bon05,
                     " AND (ima109 = '", l_bon07,"' OR ima109 IS NULL)",
                     " AND (ima54  = '", l_bon08,"' OR ima54 IS NULL)",
                     " AND ima01 != '", old_part, "'"
         PREPARE i301_ima_p1 FROM g_sql
         EXECUTE i301_ima_p1
      END FOREACH

      #過濾重覆資料
      LET g_sql = "SELECT DISTINCT * FROM i301_tmp2 "
      DECLARE i301e_sc CURSOR FROM g_sql
      #FUN-B90008 --END--

      CALL new.clear()
      CALL l_new.clear()

      LET i = 1
    # FOREACH i301e_sc INTO new[i].*,j,l_bon09,l_bon10
      FOREACH i301e_sc INTO new[i].*
        IF STATUS THEN
           CALL cl_err('foreach',STATUS,0)
           CONTINUE WHILE
        END IF
        LET new[i].new_rate = l_bon11
        CALL s_getstock(new[i].new_part,g_plant) RETURNING  l_n1,l_n2,l_n3  ###GP5.2  #NO.FUN-A20044
        LET new[i].avl_stk = l_n3                                           #NO.FUN-A20044
        IF g_sfb.sfb071>=l_bon10 THEN
           CONTINUE FOREACH
        END IF
        LET l_new[i].sfa08=l_sfa.sfa08
        LET l_new[i].sfa12=l_sfa.sfa12     #發料單位
        IF new[i].new_rate = 0 THEN
           LET new[i].new_rate = 1
        END IF
        #CHI-C30077---begin
        SELECT sfa05-sfa06 INTO new[i].new_qty FROM sfa_file
         WHERE sfa01=g_sfb.sfb01
           AND sfa03=new[i].new_part
        IF cl_null(new[i].new_qty) THEN LET new[i].new_qty = 0 END IF
        LET new[i].new_qty3 = new[i].new_qty * new[i].new_rate
        IF new[i].new_qty <> 0 THEN
           LET new[i].new_yes = 'Y'
        END IF
        #CHI-C30077---end
#取得已替代量
        SELECT sfa06 INTO new[i].new_qty4 FROM sfa_file
         WHERE sfa01=g_sfb.sfb01
           AND sfa03=new[i].new_part
        IF cl_null(new[i].new_qty4) THEN LET new[i].new_qty4=0 END IF
        LET i = i + 1
        IF i > g_max_rec THEN
           CALL cl_err( '', 9035,1 )
           EXIT FOREACH
        END IF
      END FOREACH

      CALL new.deleteElement(i)
      IF i = 0 THEN CALL cl_err('','mfg6201',1) CONTINUE WHILE END IF
      LET l_i=i-1
      DISPLAY l_i TO FORMONLY.rec

      INPUT ARRAY new WITHOUT DEFAULTS FROM s_new.*
            ATTRIBUTE(COUNT=l_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

#TQC-D70019 add begin---------------------------------------
         BEFORE FIELD new_qty
            LET i = ARR_CURR()
            IF new[i].new_yes = 'Y' THEN
            ELSE
               CALL cl_err('','asf-320',0)
               NEXT FIELD new_yes
            END IF
#TQC-D70019 add end  --------------------------------------

         AFTER FIELD new_qty
            LET i = ARR_CURR()
           #TQC-D70019  ---begin---
            LET l_tot = 0
   ###折和量累加
            LET new[i].new_qty3 = new[i].new_qty / new[i].new_rate  #TQC-D70019
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                  new[i].new_yes = "Y"  THEN
                  LET l_tot = l_tot + new[i].new_qty3
               END IF
            END FOR
            DISPLAY BY NAME l_tot
            LET i = ARR_CURR()
         #TQC-D70019  ---end--
           #TQC-CB0043--add--str
            DECLARE i301_sel_sic CURSOR FOR
             SELECT sic06,sic07_fac  FROM sic_file
              WHERE sic03 = g_sfb.sfb01
                AND sic05 = old_part
            LET l_sic_tot = 0
            FOREACH i301_sel_sic INTO l_sic06,l_sic07_fac
               LET l_sic_tot = l_sic_tot + l_sic06 * l_sic07_fac
            END FOREACH
           #IF old_qty - l_sic_tot < l_tot + new[i].new_rate * new[i].new_qty  THEN #MOD-D60069 mark
           #IF old_qty - l_sic_tot < l_tot + new[i].new_rate / new[i].new_qty  THEN #MOD-D60069 add  #TQC-D70019
            IF old_qty - l_sic_tot < l_tot THEN  #TQC-D70019
               CALL cl_err('','asf-298',0)
               NEXT FIELD new_qty
            END IF
           #TQC-CB0043--add--end
            IF new[i].new_qty < 0 THEN
               IF (new[i].new_qty*(-1)) > new[i].new_qty4 THEN
                  LET new[i].new_qty=0
                  NEXT FIELD CURRENT
               END IF
            END IF
            IF new[i].new_yes = 'N' THEN LET new[i].new_qty = 0 END IF
            LET new[i].new_qty3 = new[i].new_qty / new[i].new_rate

          #考慮發料單位倍量
            IF l_ima64!=0 THEN
               IF new[i].new_qty < 0 THEN
                  LET l_double=(new[i].new_qty3/l_ima64)- 0.999999
               ELSE
                  LET l_double=(new[i].new_qty3/l_ima64)+ 0.999999
               END IF
               LET new[i].new_qty3=l_double*l_ima64
            END IF

         BEFORE FIELD new_yes
            LET i = ARR_CURR()
          #---->在途量(供給)
            #---->請購量
            SELECT SUM((pml20-pml21)*pml09) INTO l_qty51
              FROM pmk_file,pml_file
             WHERE pml04  = new[i].new_part
               AND pml01  = pmk01
               AND pml20  > pml21
               AND pml16  <='2'
               AND pml011 !='SUB'
               AND pmk18  != 'X'
            IF l_qty51 IS NULL THEN LET l_qty51=0 END IF

            #---->採購量
            SELECT SUM((pmn20-pmn50+pmn55+pmn58)*pmn09) INTO l_qty52
              FROM pmn_file, pmm_file
             WHERE pmn04  = new[i].new_part
               AND pmn01  = pmm01
               AND pmn20  > pmn50-pmn55-pmn58
               AND pmn16  <='2'
               AND pmn011 !='SUB'
               AND pmm18  != 'X'
            IF l_qty52 IS NULL THEN LET l_qty52=0 END IF

            #---->工單在製量
            SELECT SUM((sfb08-sfb09-sfb10-sfb11-sfb12)*ima55_fac)
              INTO l_qty53
              FROM sfb_file,ima_file
             WHERE sfb05 = ima01
               AND sfb05 = new[i].new_part
               AND sfb04 < '8'
               AND sfb02 <>'7'
               AND sfb08 > (sfb09+sfb11+sfb12)
               AND sfb87 !='X'
            IF l_qty53 IS NULL THEN LET l_qty53=0 END IF

            #---->委外在製量
            SELECT SUM((sfb08-sfb09-sfb10-sfb11-sfb12)*ima55_fac)
              INTO l_qty55
              FROM sfb_file,ima_file
             WHERE sfb05 =  ima01
               AND sfb05 =  new[i].new_part
               AND sfb04 <  '8'
               AND sfb02 =  '7'
               AND sfb08 >  (sfb09+sfb10+sfb11+sfb12)
               AND sfb87 != 'X'
            IF l_qty55 IS NULL THEN LET l_qty55=0 END IF

            #---->IQC在驗量
            SELECT SUM((rvb07-rvb29-rvb30)*pmn09) INTO l_qty54
              FROM rvb_file, rva_file, pmn_file
             WHERE rvb05 = new[i].new_part
               AND rvb01 = rva01
               AND rvb04 = pmn01
               AND rvb03 = pmn02
               AND rvb07 > (rvb29+rvb30)
               AND rvaconf='Y'
            IF l_qty54 IS NULL THEN LET l_qty54=0 END IF

            #---->FQC 在驗量
            SELECT SUM(sfb11) INTO l_qty56
              FROM sfb_file
             WHERE sfb05 =  new[i].new_part
               AND sfb02 <> '7'
               AND sfb87 != 'X'
               AND sfb04 <  '8'
            IF l_qty56 IS NULL THEN LET l_qty56=0 END IF

            LET new[i].new_qty5=l_qty51+l_qty52+l_qty53+l_qty54+l_qty55+l_qty56

          #---->在途量(需求)
            #---->受訂量
            SELECT SUM((oeb12-oeb24)*oeb05_fac) INTO l_qty61
              FROM oeb_file, oea_file
             WHERE oeb04   = new[i].new_part
               AND oeb01   = oea01
               AND oea00   <>'0'
               AND oeb70   = 'N'
               AND oeb12   > oeb24
               AND oeaconf != 'X'
            IF l_qty61 IS NULL THEN LET l_qty61=0 END IF

            LET l_qty62=0
            LET l_qty63=0
            LET l_sql = "SELECT sfa_file.*",
                        "  FROM sfb_file,sfa_file",
                        " WHERE sfa03 = '",new[i].new_part,"'",
                        "   AND sfb01 = sfa01 ",
                        "   AND sfb04 !='8'",
                        "   AND sfb87 !='X'"
            PREPARE i301e_sum_pre FROM l_sql
            DECLARE i301e_sum CURSOR FOR i301e_sum_pre
            FOREACH i301e_sum INTO lr_sfa.*
               CALL s_shortqty(lr_sfa.sfa01,lr_sfa.sfa03,lr_sfa.sfa08,
                               lr_sfa.sfa12,lr_sfa.sfa27,lr_sfa.sfa012,lr_sfa.sfa013)
                 RETURNING g_short_qty
               IF cl_null(g_short_qty) THEN LET g_short_qty = 0 END IF
               IF (lr_sfa.sfa05 > (lr_sfa.sfa06+ g_short_qty)) OR (g_short_qty > 0) THEN
                  LET l_qty62= l_qty62 + ((lr_sfa.sfa05 - lr_sfa.sfa06 - g_short_qty) * lr_sfa.sfa13)
                  LET l_qty63= l_qty63 + (g_short_qty * lr_sfa.sfa13)
               END IF
            END FOREACH
            LET new[i].new_qty6 = l_qty61+l_qty62+l_qty63
#FUN-AC0074--mark(s)
            #---->出貨備置量(alocated)
#            SELECT SUM(oeb905*oeb05_fac) INTO new[i].new_qty7
#              FROM oeb_file, oea_file, occ_file
#             WHERE oeb04 = new[i].new_part
#               AND oeb01 = oea01
#               AND oea00 <> '0'
#               AND oeb19 = 'Y'
#               AND oeb70 = 'N'
#               AND oeb12 > oeb24
#               AND oea03 = occ01
#            IF new[i].new_qty7 IS NULL THEN LET new[i].new_qty7=0 END IF
#FUN-AC0074--mark(e)
#FUN-AC0074--add--begin
             SELECT SUM(sig05)  INTO  new[i].new_qty7
               FROM sig_file
             WHERE sig01 = new[i].new_part
             IF new[i].new_qty7 IS NULL THEN LET new[i].new_qty7=0 END IF
#FUN-AC0074--add--end
            #---->可用量

            LET new[i].new_qty8
#             =new[i].ima262 + new[i].new_qty5 - new[i].new_qty6 ###GP5.2  #NO.FUN-A20044
              =new[i].avl_stk + new[i].new_qty5 - new[i].new_qty6          ###GP5.2  #NO.FUN-A20044
            DISPLAY new[i].new_qty5 TO s_new[i].new_qty5
            DISPLAY new[i].new_qty6 TO s_new[i].new_qty6
            DISPLAY new[i].new_qty7 TO s_new[i].new_qty7
            DISPLAY new[i].new_qty8 TO s_new[i].new_qty8   #j->i
            LET l_tot = 0
   ###折和量累加
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                  new[i].new_yes = "Y"  THEN
                  LET l_tot = l_tot + new[i].new_qty3
               END IF
            END FOR
            DISPLAY BY NAME l_tot

         AFTER INPUT
            IF INT_FLAG THEN
               LET INT_FLAG=0
               EXIT INPUT
            END IF

            LET g_success = 'Y'

            BEGIN WORK

            LET l_tot = 0
            LET l_yes_cnt = 0  #CHI-C30077
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                   new[i].new_yes = "Y"       THEN
                  LET l_yes_cnt = l_yes_cnt + 1  #CHI-C30077
                #重新抓取發料單位與轉換率
                  SELECT ima63,ima63_fac,ima86,ima86_fac INTO l_ima63,
                    l_ima63_fac,l_ima86,l_ima86_fac
                    FROM ima_file
                   WHERE ima01 = new[i].new_part

                   IF STATUS THEN
                      CALL cl_err('sel ima63',STATUS,1)
                      LET g_success ='N'
                      EXIT INPUT
                   END IF
                  #LET g_gfe03=i301_gfe03(l_sfa.sfa12)                     #FUN-D60039 mark
                  #LET new[i].new_qty=cl_digcut(new[i].new_qty,g_gfe03)    #FUN-D60039 mark
                  LET new[i].new_qty=s_digqty(new[i].new_qty,l_sfa.sfa12)  #FUN-D60039 add
                  LET l_tot = l_tot + new[i].new_qty3
                  LET l_sfa.sfa03 = new[i].new_part
                  LET l_sfa.sfa04 = new[i].new_qty
                  LET l_sfa.sfa05 = new[i].new_qty
                  LET l_sfa.sfa06 = 0
                  LET l_sfa.sfa061 = 0
                  LET l_sfa.sfa062 = 0
                  LET l_sfa.sfa063 = 0
                  LET l_sfa.sfa064 = 0
                  LET l_sfa.sfa065 = 0
                  LET l_sfa.sfa066 = 0
                  IF l_sfa.sfa08 IS NULL THEN LET l_sfa.sfa08=' ' END IF
                  LET l_sfa.sfa12=l_ima63
                  LET l_sfa.sfa13=l_ima63_fac
                  LET l_sfa.sfa14=l_ima86
                  LET l_sfa.sfa15=l_ima86_fac
                  LET l_sfa.sfa16 = 0
                  LET l_sfa.sfa161= 0
                  LET l_sfa.sfa25 = new[i].new_qty
                  LET l_tot = s_digqty(l_tot,l_sfa.sfa12)    #FUN-910088--add--
            #      IF old_sfa26 = '8' THEN
                     LET l_sfa.sfa26 = 'Z'
            #      END IF

                  LET l_sfa.sfa28 = new[i].new_rate
                  IF cl_null(l_sfa.sfa100) THEN
                     LET l_sfa.sfa100 = 0
                  END IF

                  LET l_sfa.sfaplant = g_plant
                  LET l_sfa.sfalegal = g_legal

                  #TQC-B80070  --begin
#TQC-BA0162
#TQC-BA0162
                  #TQC-B80070  --end

                  INSERT INTO sfa_file VALUES (l_sfa.*)
                  IF SQLCA.SQLCODE THEN
                     IF cl_sql_dup_value(SQLCA.SQLCODE) THEN
                        UPDATE sfa_file SET
                           #sfa05=sfa05 + new[i].new_qty,  #CHI-C30077
                           sfa05=sfa06 + new[i].new_qty,  #CHI-C30077
                           sfa27=l_sfa.sfa27,sfa26=l_sfa.sfa26,
                           sfa16 = 0 , sfa161= 0 ,
                           #sfa25=l_sfa.sfa25 + new[i].new_qty  #CHI-C30077
                           sfa25= new[i].new_qty  #CHI-C30077
                         WHERE sfa01=g_sfb.sfb01 AND sfa03=new[i].new_part
                           AND sfa08=l_sfa.sfa08 AND sfa12=l_sfa.sfa12
                           AND sfa27=old_part
                         IF SQLCA.SQLCODE THEN
                            CALL cl_err3("upd","sfa_file",g_sfb.sfb01,new[i].new_part,STATUS,"","update sfa",1)
                            LET g_success ='N' EXIT FOR
                         ELSE
                            SELECT sfa05,sfa06 INTO l_sfa05,l_sfa06 FROM sfa_file
                             WHERE sfa01 = g_sfb.sfb01 AND sfa03=new[i].new_part
                               AND sfa08=l_sfa.sfa08 AND sfa12=l_sfa.sfa12
                               AND sfa27=old_part
                            IF cl_null(l_sfa05) THEN LET l_sfa05 = 0 END IF
                            IF cl_null(l_sfa06) THEN LET l_sfa06 = 0 END IF
                            IF l_sfa05 + new[i].new_qty < l_sfa06 THEN
                               CALL cl_err3("upd","sfa_file",g_sfb.sfb01,new[i].new_part,'asf-072',"","update sfa",1)
                               LET g_success ='N' EXIT FOR
                            END IF
                         END IF
                     ELSE
                       CALL cl_err('ins sfa',STATUS,1)
                       LET g_success ='N' EXIT FOR
                    END IF
                  END IF
               END IF
            END FOR
            DISPLAY BY NAME l_tot
            IF g_success = 'Y' THEN
                IF l_tot > old_qty THEN
                   CALL cl_err('','mfg6202',1)
                   LET g_success = 'N'
                ELSE
                  #IF l_tot != 0 THEN   #CHI-C30077
                   IF l_yes_cnt <> 0 THEN  #CHI-C30077
                     LET left_qty = left_qty - l_tot
                     LET left_qty = s_digqty(left_qty,l_sfa.sfa12)   #FUN-910088--add--
                 #   IF old_sfa26='1' THEN LET old_sfa26='3' END IF
                 #   IF old_sfa26='2' THEN LET old_sfa26='4' END IF
                     IF old_sfa26='7' THEN LET old_sfa26='8' END IF
                     UPDATE sfa_file SET sfa05=left_qty,
                                         #sfa25=sfa25-l_tot, #CHI-C30077
                                         sfa25 = left_qty-sfa06, #CHI-C30077
                                         sfa26=old_sfa26
                        WHERE sfa01 = g_sfb.sfb01
                          AND sfa03 = old_part AND sfa08 = old_sfa08
                          AND sfa27 = old_part
                         #AND sfa12 = l_ima63_a             #MOD-AC0323 mark
                       IF STATUS THEN
                          CALL cl_err3("upd","sfa_file",g_sfb_t.sfb01,old_part,STATUS,"","upd sfa",1)
                          LET g_success ='N'
                       END IF
                  END IF
                END IF
            END IF

            LET l_chr = 'N'
            IF g_success = 'Y' THEN
               FOR i = 1 TO new.getLength()
                   IF new[i].new_yes = 'Y'THEN
                      LET l_chr = 'Y'
                      COMMIT WORK
                      CALL cl_err('','9062',1)
                   END IF
               END FOR
               IF l_chr = 'N' THEN
                  ROLLBACK WORK
                  CALL cl_err('','9050',1)
               END IF
            ELSE
               ROLLBACK WORK
               CALL cl_err('','9050',1)
               NEXT FIELD new_yes
            END IF

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT
      END INPUT

      CLEAR FORM
      CALL g_sfa.clear()
      CALL g_sfa29.clear()

   END WHILE
END FUNCTION

FUNCTION i301_s()
   DEFINE old_part          LIKE ima_file.ima01 #MOD-590218
   DEFINE old_sfa08         LIKE sfa_file.sfa08
   DEFINE l_ima02           LIKE ima_file.ima02
   DEFINE l_ima021          LIKE ima_file.ima021
   DEFINE i,j               LIKE type_file.num5    #No.FUN-680121 SMALLINT
#  DEFINE old_qty,left_qty  LIKE ima_file.ima26    #No.FUN-680121 DEC(15,3)  #MOD-480301
   DEFINE old_qty,left_qty  LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE old_sfa26         LIKE sfa_file.sfa26    #MOD-590218
   DEFINE l_sfa  RECORD LIKE sfa_file.*
   DEFINE lr_sfa RECORD LIKE sfa_file.*            #No.FUN-940008 add
  #DEFINE l_bmd05,l_bmd06   LIKE type_file.dat     #No.FUN-680121 DATE      #MOD-B10225 mark
   DEFINE l_bmd03           LIKE bmd_file.bmd03    #MOD-B10225 add
   DEFINE l_tot             LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty51           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty52           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty53           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty54           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty55           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty56           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty61           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty62           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE l_qty63           LIKE pml_file.pml20    #No.FUN-680121 DECIMAL(13,3)
   DEFINE new DYNAMIC ARRAY OF RECORD
          new_part          LIKE sfa_file.sfa03, #No.MOD-490217
         ima02_1            LIKE ima_file.ima02,
         ima021_1           LIKE ima_file.ima021,
          new_rate          LIKE bmd_file.bmd07,                                            #MOD-6A0051 mod
          new_yes           LIKE type_file.chr1,   #No.FUN-680121 VARCHAR(1),
          new_qty           LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301
          new_qty3          LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301,
#         ima262            LIKE ima_file.ima262,  ###GP5.2  #NO.FUN-A20044
          avl_stk           LIKE type_file.num15_3,###GP5.2  #NO.FUN-A20044
          new_qty4          LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301
          new_qty5          LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301
          new_qty6          LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301
          new_qty7          LIKE pml_file.pml20,   #No.FUN-680121 DEC(15,3), #MOD-480301
          new_qty8          LIKE pml_file.pml20    #No.FUN-680121 DEC(15,3)  #MOD-480301
         END RECORD,

          l_new DYNAMIC ARRAY OF RECORD
          sfa08        LIKE sfa_file.sfa08,
          sfa12        LIKE sfa_file.sfa12
          END RECORD,
          l_i              LIKE type_file.num5,    #No.FUN-680121 SMALLINT
          l_allow_insert   LIKE type_file.num5,                #可新增否  #No.FUN-680121 SMALLINT
          l_allow_delete   LIKE type_file.num5,                #可刪除否  #No.FUN-680121 SMALLINT
          l_double     LIKE type_file.num10,
          l_ima64      LIKE ima_file.ima64,
          l_ima641     LIKE ima_file.ima641,      #MOD-A50131 add
          l_ima63      LIKE ima_file.ima63,
          l_ima63_fac  LIKE ima_file.ima63_fac,
          l_ima86      LIKE ima_file.ima86,
          l_ima86_fac  LIKE ima_file.ima86_fac
   DEFINE l_sql  string  #FUN-940008 add
  #DEFINE l_ima63_a      LIKE ima_file.ima63           #TQC-960234       #MOD-AC0323 mark
   DEFINE l_sfa05        LIKE sfa_file.sfa05     #MOD-A10075
   DEFINE l_sfa06        LIKE sfa_file.sfa06     #MOD-A10075
   DEFINE l_n1           LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_n2           LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_n3           LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE l_num_y        LIKE sfa_file.sfa05     #MOD-A50131 add
   DEFINE l_num_z        LIKE type_file.num20    #MOD-A50131 add
   DEFINE l_new_qty      LIKE pml_file.pml20     #MOD-A50158 add
   DEFINE l_gfe03        LIKE gfe_file.gfe03     #MOD-A50158 add
   DEFINE old_sfa012     LIKE sfa_file.sfa012    #FUN-A50066
   DEFINE old_sfa013     LIKE sfa_file.sfa013    #FUN-A50066
   DEFINE old_ecu014     LIKE ecu_file.ecu014    #FUN-A50066
   DEFINE l_cnt          LIKE type_file.num5     #FUN-A50066
   DEFINE l_ima571       LIKE ima_file.ima571    #MOD-AC0336
   DEFINE l_flag         LIKE type_file.num5     #MOD-AC0336
   DEFINE l_t            LIKE type_file.num5     #TQC-B40025
  #TQC-CB0043--add--str
   DEFINE l_sic_tot LIKE type_file.num15_3,
          l_sic06   LIKE sic_file.sic06,
          l_sic07_fac LIKE sic_file.sic07_fac
  #TQC-CB0043--add--end
  #MOD-B10225---add---start---
   DEFINE l_bmd        RECORD
                         bmd04   LIKE bmd_file.bmd04,
                         ima02   LIKE ima_file.ima02,
                         ima021  LIKE ima_file.ima021,
                         bmd07   LIKE bmd_file.bmd07,
                         l_yes   LIKE type_file.chr1,
                         l_qty   LIKE type_file.num5,
                         l_qty3  LIKE type_file.num5,
                         ima262  LIKE ima_file.ima262,
                         l_qty4  LIKE type_file.num5,
                         l_qty5  LIKE type_file.num5,
                         l_qty6  LIKE type_file.num5,
                         l_qty7  LIKE type_file.num5,
                         l_qty8  LIKE type_file.num5,
                         bmd03   LIKE bmd_file.bmd03
                       END RECORD
  #MOD-B10225---add---end---

   OPEN WINDOW i301_sw AT 2,2 WITH FORM "asf/42f/asfi301c"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("asfi301c")

   #FUN-A50066--begin--add------
   IF g_sma.sma541 = 'N' THEN
      CALL cl_set_comp_visible("old_sfa012,old_sfa013,old_ecu014",FALSE)
   END IF
   #FUN-A50066--end--add------
   LET old_sfa08 = ' '
   LET old_sfa012 = ' '  #FUN-A50066

   IF NOT cl_null(l_ac) AND  l_ac > 0 THEN #MOD-D60244 add by yuhuabao 13/06/28
   LET old_part = g_sfa[l_ac].sfa03  #CHI-C90009
   LET old_sfa08 = g_sfa[l_ac].sfa08 #MOD-D60244 add by yuhuabao 13/06/28  #预设为当前光标对应的单身的作业编号
   END IF
   DISPLAY old_sfa08 TO old_sfa08  #MOD-D60244 add by yuhuabao 13/06/28

   DISPLAY old_part TO old_part      #CHI-C90009

   WHILE TRUE
      INPUT BY NAME old_part,old_sfa08,old_sfa012,old_sfa013 WITHOUT DEFAULTS  #FUN-A50066

         #FUN-A50066--begin--add--------
         BEFORE INPUT
            IF g_sma.sma541 = 'Y' THEN
               CALL cl_set_comp_entry("ols_sfa012,old_sfa013",TRUE)
               IF g_sma.sma542 <> 'Y' OR g_sfb.sfb93 <> 'Y' THEN
                  CALL cl_set_comp_entry("old_sfa012,old_sfa013",FALSE)
                  LET old_sfa012=' '   LET old_sfa013=0
               END IF
            END IF
         #FUN-A50066--end--add----------

          AFTER FIELD old_part
             LET l_ima02=''
             LET l_ima021=''
            #SELECT ima02,ima021,ima64,ima63 INTO l_ima02,l_ima021,l_ima64,l_ima63_a  #TQC-960234     #MOD-AC0323 mark
             SELECT ima02,ima021,ima64 INTO l_ima02,l_ima021,l_ima64                                  #MOD-AC0323 add
               FROM ima_file
              WHERE ima01=old_part
             DISPLAY l_ima02  TO ima02
             DISPLAY l_ima021 TO ima021

#FUN-A50066--begin--add------------------
           AFTER FIELD old_sfa012
              IF NOT cl_null(old_sfa012) THEN
                 LET l_cnt = 0
                 SELECT count(*) INTO l_cnt FROM sfa_file
                  WHERE sfa01=g_sfb.sfb01
                    AND sfa26 in ('1','2','3','4','5')
                    AND sfa012=old_sfa012
                    AND sfa03=old_part
                 IF l_cnt = 0 THEN
                    CALL cl_err('','abm-214',0)
                    NEXT FIELD old_sfa012
                 END IF
                 CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571  #MOD-AC0336
                #FUN-B10056 --------mod start---------
                #SELECT ecu014 INTO old_ecu014 FROM ecu_file
                # WHERE ecu01=l_ima571   #MOD-AC0336
                #   AND ecu02=g_sfb.sfb06
                #   AND ecu012=old_sfa012
                 CALL s_schdat_ecm014(g_sfb.sfb01,old_sfa012) RETURNING old_ecu014
                #FUN-B10056 -------mod end----------
                    DISPLAY BY NAME old_ecu014
              END IF

             AFTER FIELD old_sfa013
              IF NOT cl_null(old_sfa013) THEN
                 LET l_cnt = 0
                 SELECT count(*) INTO l_cnt FROM sfa_file
                  WHERE sfa01=g_sfb.sfb01
                    AND sfa26 in ('1','2','3','4','5')
                    AND sfa012=old_sfa012
                    AND sfa03=old_part
                    AND sfa013=old_sfa013
                 IF l_cnt = 0 THEN
                    CALL cl_err('','abm-215',0)
                    NEXT FIELD old_sfa013
                 END IF
              END IF
#FUN-A50066--end--add---------------------------

         AFTER FIELD old_sfa08
             IF cl_null(old_sfa08) THEN
                LET old_sfa08 = ' '
             END IF

        ON ACTION controlp
           CASE WHEN INFIELD(old_part)
                     CALL cl_init_qry_var()
                     #FUN-A50066--begin--add-----------
                     IF g_sma.sma541 = 'N' THEN
                        LET g_qryparam.form     = "q_sfa10_a"
                        LET g_qryparam.arg1     = g_sfb.sfb01
                        CALL cl_create_qry() RETURNING old_part,old_sfa08
                        IF cl_null(old_sfa08) THEN  LET old_sfa08 = ' ' END IF
                        IF cl_null(old_sfa012) THEN LET old_sfa012= ' ' END IF
                        IF cl_null(old_sfa013) THEN LET old_sfa013=0 END IF
                        DISPLAY old_part   TO old_part
                     ELSE
                     #FUN-A50066--end--add--------------------
                      # LET g_qryparam.form     = "q_sfa10"    #MOD-530280-8     #FUN-B10056 mark
                        LET g_qryparam.form     = "q_sfa10_b"  #FUN-B10056
                        LET g_qryparam.arg1     = g_sfb.sfb01
                        CALL cl_create_qry() RETURNING old_sfa012,old_ecu014,old_sfa013,   #FUN-A500066
                                                       old_part,old_sfa08  #MOD-940373
                        IF cl_null(old_sfa08) THEN
                           LET old_sfa08 = ' '
                        END IF
                        IF cl_null(old_sfa012) THEN LET old_sfa012= ' ' END IF   #FUN-A50066
                        IF cl_null(old_sfa013) THEN LET old_sfa013=0 END IF  #FUN-A50066
                        DISPLAY old_part   TO old_part
                        DISPLAY old_sfa012 TO old_sfa012  #FUN-A50066
                        DISPLAY old_ecu014 TO old_ecu014  #FUN-A50066
                        DISPLAY old_sfa013 TO old_sfa013  #FUN-A50066
                      END IF
                      NEXT FIELD old_part
           #FUN-A50066--begin--add-----------------
                WHEN INFIELD(old_sfa012)
                     CALL cl_init_qry_var()
                   # LET g_qryparam.form     = "q_sfa10"     #FUN-B10056 mark
                     LET g_qryparam.form     = "q_sfa10_b"   #FUN-B10056
                     LET g_qryparam.arg1     = g_sfb.sfb01
                     CALL cl_create_qry() RETURNING old_sfa012,old_ecu014,old_sfa013,old_part,old_sfa08
                     IF cl_null(old_sfa08) THEN LET old_sfa08 = ' ' END IF
                     IF cl_null(old_sfa012) THEN LET old_sfa012= ' ' END IF
                     IF cl_null(old_sfa013) THEN LET old_sfa013=0 END IF
                     DISPLAY old_part   TO old_part
                     DISPLAY old_sfa012 TO old_sfa012
                     DISPLAY old_ecu014 TO old_ecu014
                     DISPLAY old_sfa013 TO old_sfa013
                     NEXT FIELD old_sfa012
                WHEN INFIELD(old_sfa013)
                     CALL cl_init_qry_var()
                   # LET g_qryparam.form     = "q_sfa10"     #FUN-B10056 mark
                     LET g_qryparam.form     = "q_sfa10_b"   #FUN-B10056
                     LET g_qryparam.arg1     = g_sfb.sfb01
                     CALL cl_create_qry() RETURNING old_sfa012,old_ecu014,old_sfa013,old_part,old_sfa08
                     IF cl_null(old_sfa08) THEN LET old_sfa08 = ' ' END IF
                     IF cl_null(old_sfa012) THEN LET old_sfa012= ' ' END IF
                     IF cl_null(old_sfa013) THEN LET old_sfa013=0 END IF
                     DISPLAY old_part   TO old_part
                     DISPLAY old_sfa012 TO old_sfa012
                     DISPLAY old_ecu014 TO old_ecu014
                     DISPLAY old_sfa013 TO old_sfa013
                     NEXT FIELD old_sfa013
             #FUN-A50066--end--add---------------------
           END CASE
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE INPUT

          ON ACTION about
             CALL cl_about()

          ON ACTION controlg
             CALL cl_cmdask()

          ON ACTION help
             CALL cl_show_help()
      END INPUT
      IF INT_FLAG THEN
         LET INT_FLAG=0 CLOSE WINDOW i301_sw EXIT WHILE END IF
      IF old_part IS NULL THEN CLOSE WINDOW i301_sw EXIT WHILE END IF
     #MOD-C80093 str add-----
      IF g_sma.sma541 = 'N' THEN
         SELECT sfa012,sfa013 INTO old_sfa012,old_sfa013
           FROM sfa_file
          WHERE sfa01 = g_sfb.sfb01 AND sfa03 = old_part
            AND sfa08 = old_sfa08 AND sfa27 = old_part
      END IF
     #MOD-C80093 end add-----
      IF cl_null(old_sfa012) THEN LET old_sfa012=' ' END IF  #FUN-A50066
      IF cl_null(old_sfa013) THEN LET old_sfa013=0   END IF  #FUN-A50066
      SELECT * INTO l_sfa.* FROM sfa_file
       WHERE sfa01 = g_sfb.sfb01 AND sfa03 = old_part AND sfa08 = old_sfa08
         AND sfa27 = old_part  #CHI-7B0034
        #AND sfa12 = l_ima63_a  #TQC-960234        #MOD-AC0323 mark
         AND sfa012 = old_sfa012   #FUN-A50066
         AND sfa013 = old_sfa013   #FUN-A50066
      IF STATUS THEN
         CALL cl_err3("sel","sfa_file",g_sfb.sfb01,old_part,STATUS,"","sel sfa",1)   #No.FUN-660128
         CONTINUE WHILE
      END IF
      LET l_sfa.sfa27 = l_sfa.sfa03
      LET left_qty = l_sfa.sfa05
      LET old_qty = l_sfa.sfa05 - l_sfa.sfa06
      DISPLAY BY NAME l_sfa.sfa26,old_qty,l_sfa.sfa12
      IF l_sfa.sfa26 NOT MATCHES '[1234]' THEN
         CALL cl_err('','mfg6201',0) CONTINUE WHILE
      END IF

      IF (l_sfa.sfa26 NOT MATCHES '[34]' AND old_qty <0) THEN  #FUN-650122 add #MOD-9C0231
          CALL cl_err('','mfg6181',0)  #MOD-640425
          CONTINUE WHILE               #No.FUN-660113 mark
      END IF
      LET old_sfa26=l_sfa.sfa26

      DECLARE i301_sc CURSOR FOR
#             SELECT bmd04,ima02,ima021,bmd07,'N',0,0,ima262,0,0,0,0,0,bmd03,bmd05,bmd06  #MOD-6B0065
             #SELECT bmd04,ima02,ima021,bmd07,'N',0,0,0,0,0,0,0,0,bmd03,bmd05,bmd06       #NO.FUN-A20044  #MOD-B10180 mark
             #SELECT DISTINCT bmd04,ima02,ima021,bmd07,'N',0,0,0,0,0,0,0,0,bmd06          #MOD-B10180 add #MOD-B10225 mark
              SELECT bmd04,ima02,ima021,bmd07,'N',0,0,0,0,0,0,0,0,bmd03                   #MOD-B10225 add
                FROM bmd_file LEFT OUTER JOIN ima_file ON bmd04=ima01
               WHERE bmd01 = old_part #AND bmd02='2'
                 AND bmd02 <> '3'                                            #TQC-B90236 add
                 AND (bmd08=l_sfa.sfa29 OR bmd08='ALL')
                 AND (bmd05 IS NULL OR bmd05 <= g_sfb.sfb071)                #TQC-B40216 add
                 AND (bmd06 IS NULL OR bmd06 > g_sfb.sfb071)                 #MOD-B10225 add
                 AND bmdacti = 'Y'                                           #CHI-910021
              #ORDER BY bmd03           #MOD-B10180 mark
               ORDER BY bmd03,bmd04     #MOD-B10180 add   #MOD-B10225 add

     #MOD-B10225---add---start---
      CALL i301_cre_tmp()
      DELETE FROM i301_tmp
      FOREACH i301_sc INTO l_bmd.*
        LET l_bmd03 = 0
        SELECT bmd03 INTO l_bmd03 FROM i301_tmp WHERE bmd04=l_bmd.bmd04
        IF cl_null(l_bmd03) OR l_bmd03 = 0 THEN
           INSERT INTO i301_tmp VALUES(l_bmd.*)
        ELSE
           IF l_bmd03 <= l_bmd.bmd03 THEN
              CONTINUE FOREACH
           ELSE
              UPDATE i301_tmp SET bmd03 = l_bmd.bmd03 WHERE bmd04 = l_bmd.bmd04
           END IF
        END IF
      END FOREACH
      LET l_sql = "SELECT * FROM i301_tmp "
      DECLARE i301_sc2 CURSOR FROM l_sql
     #MOD-B10225---add---end---
      CALL new.clear()
      CALL l_new.clear()

      LET i = 1
     #FOREACH i301_sc INTO new[i].*,j,l_bmd05,l_bmd06      #MOD-B10180 mark
     #FOREACH i301_sc INTO new[i].*,l_bmd06                #MOD-B10180 aDd  #MOD-B10225 mark
      FOREACH i301_sc2 INTO new[i].*                       #MOD-B10225 add
        IF STATUS THEN CALL cl_err('foreach',STATUS,0) CONTINUE WHILE END IF
       #IF g_sfb.sfb071>=l_bmd06      THEN CONTINUE FOREACH END IF          #MOD-B10225 mark
        CALL s_getstock(new[i].new_part,g_plant) RETURNING  l_n1,l_n2,l_n3  ###GP5.2  #NO.FUN-A20044
        LET new[i].avl_stk = l_n3                                           #NO.FUN-A20044
        LET l_new[i].sfa08=l_sfa.sfa08
        LET l_new[i].sfa12=l_sfa.sfa12
        IF new[i].new_rate = 0 THEN LET new[i].new_rate = 1 END IF
        ###取得已替代量
           SELECT sfa05 INTO new[i].new_qty4 FROM sfa_file
            WHERE sfa01=g_sfb.sfb01 AND sfa03=new[i].new_part
              AND sfa012 = old_sfa012 AND sfa013 = old_sfa013   #FUN-A50066
           IF cl_null(new[i].new_qty4) THEN LET new[i].new_qty4=0 END IF
        LET i = i + 1
        IF i > g_max_rec THEN        #No:8600
           CALL cl_err( '', 9035,1 )
           EXIT FOREACH
        END IF
      END FOREACH

      CALL new.deleteElement(i)
      IF i = 0 THEN CALL cl_err('','mfg6201',0) CONTINUE WHILE END IF
      LET l_i=i-1
      DISPLAY l_i TO FORMONLY.rec

      INPUT ARRAY new WITHOUT DEFAULTS FROM s_new.*
            ATTRIBUTE(COUNT=l_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)

#MOD-D60143 add begin---------------------------------------
         ON CHANGE new_yes
            LET i = ARR_CURR()
            IF new[i].new_yes = 'Y' THEN
               CALL cl_set_comp_entry("new_qty",TRUE)
            ELSE
               CALL cl_set_comp_entry("new_qty",FALSE)
            END IF

         AFTER FIELD new_yes
            LET i = ARR_CURR()
            IF new[i].new_yes = 'Y' THEN
               CALL cl_set_comp_entry("new_qty",TRUE)
            ELSE
               CALL cl_set_comp_entry("new_qty",FALSE)
            END IF
#MOD-D60143 add end  ---------------------------------------

#TQC-D70019 add begin---------------------------------------
         BEFORE FIELD new_qty
            LET i = ARR_CURR()
            IF new[i].new_yes = 'Y' THEN
            ELSE
               CALL cl_err('','asf-320',0)
               NEXT FIELD new_yes
            END IF
#TQC-D70019 add end  --------------------------------------

         AFTER FIELD new_qty
            LET i = ARR_CURR()
           #TQC-D70019  ---begin---
            LET l_tot = 0
   ###折和量累加
            LET new[i].new_qty3 = new[i].new_qty / new[i].new_rate  #TQC-D70019
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                  new[i].new_yes = "Y"  THEN
                  LET l_tot = l_tot + new[i].new_qty3
               END IF
            END FOR
            DISPLAY BY NAME l_tot
            LET i = ARR_CURR()
         #TQC-D70019  ---end--
           #TQC-CB0043--add--str
            DECLARE i301_sel_sic_1 CURSOR FOR
             SELECT sic06,sic07_fac  FROM sic_file
              WHERE sic03 = g_sfb.sfb01
                AND sic05 = old_part
            LET l_sic_tot = 0
            FOREACH i301_sel_sic_1 INTO l_sic06,l_sic07_fac
               LET l_sic_tot = l_sic_tot + l_sic06 * l_sic07_fac
            END FOREACH
           #IF old_qty - l_sic_tot < l_tot + new[i].new_rate * new[i].new_qty  THEN #MOD-D60069 mark
           #IF old_qty - l_sic_tot < l_tot + new[i].new_rate / new[i].new_qty  THEN #MOD-D60069 add    #TQC-D70019
            IF old_qty - l_sic_tot < l_tot THEN  #TQC-D70019
               CALL cl_err('','asf-298',0)
               NEXT FIELD new_qty
            END IF
           #TQC-CB0043--add--end
           #str MOD-A50158 add
            LET g_errno = ''   #清空變數
           #考慮單位小數取位
            #FUN-D60039--mark--str--
            #SELECT gfe03 INTO l_gfe03 FROM gfe_file
            # WHERE gfe01 = l_sfa.sfa12
            #IF SQLCA.sqlcode OR cl_null(l_gfe03) THEN
            #   LET l_gfe03 = 0
            #END IF
            #CALL cl_digcut(new[i].new_qty,l_gfe03) RETURNING new[i].new_qty
            #FUN-D60039--mark--end--
            LET new[i].new_qty=s_digqty(new[i].new_qty,l_sfa.sfa12)  #FUN-D60039 add
            LET l_new_qty = new[i].new_qty
           #end MOD-A50158 add
            IF new[i].new_qty < 0 THEN
               LET l_new_qty = new[i].new_qty*(-1)   #MOD-A50158 add
               IF (new[i].new_qty*(-1)) > new[i].new_qty4 THEN
                  LET new[i].new_qty=0 NEXT FIELD new_qty
               END IF
            END IF
            IF new[i].new_yes = 'N' THEN LET new[i].new_qty = 0 END IF
            LET new[i].new_qty3 = new[i].new_qty / new[i].new_rate
           #MOD-A50131 add --begin
            SELECT ima64,ima641 INTO l_ima64,l_ima641 FROM ima_file
              WHERE ima01 = new[i].new_part
            IF STATUS THEN LET l_ima64 = 0 LET l_ima641 = 0 END IF
           #check 最少發料量
           #IF l_ima641 <> 0 AND new[i].new_qty < 0 THEN   #MOD-A50158 mark
            IF l_ima641 <> 0 AND l_new_qty < 0 THEN        #MOD-A50158
               LET g_errno = 'asf-100'
            END IF
            LET l_num_z=new[i].new_qty/l_ima64
            LET l_num_y=new[i].new_qty-l_num_z*l_ima64
           #IF l_ima64 <> 0 AND (l_num_y) > 0 THEN
            IF l_ima64 <> 0 AND (l_num_y) <> 0 THEN    #TQC-B40221 未考慮四捨五入情況
               LET g_errno = 'asf-101'
            END IF
            IF NOT cl_null(g_errno) THEN
               CALL cl_err('',g_errno,0)
               NEXT FIELD new_qty
            END IF
            #MOD-A50131 add --end
         #TQC-B50078--begin
         ##MOD-6B0065...............begin 考慮發料單位倍量
         #  IF l_ima64!=0 THEN
         #     IF new[i].new_qty < 0 THEN
         #        LET l_double=(new[i].new_qty3/l_ima64)- 0.999999
         #     ELSE
         #        LET l_double=(new[i].new_qty3/l_ima64)+ 0.999999
         #     END IF
         #     LET new[i].new_qty3=l_double*l_ima64
         #  END IF
         #TQC-B50078--end

          BEFORE FIELD new_yes #MOD-520072

            LET i = ARR_CURR()
#MOD-D60143 add begin---------------------------------------
            IF new[i].new_yes = 'Y' THEN
               CALL cl_set_comp_entry("new_qty",TRUE)
            ELSE
               CALL cl_set_comp_entry("new_qty",FALSE)
            END IF
#MOD-D60143 add end  ---------------------------------------
          #---->在途量(供給)**********************************************
            #---->請購量
            SELECT SUM((pml20-pml21)*pml09) INTO l_qty51
              FROM pmk_file,pml_file
             WHERE pml04  = new[i].new_part
               AND pml01  = pmk01
               AND pml20  > pml21
               AND pml16  <='2'
               AND pml011 !='SUB'
               AND pmk18  != 'X'
            IF l_qty51 IS NULL THEN LET l_qty51=0 END IF

            #---->採購量
            SELECT SUM((pmn20-pmn50+pmn55+pmn58)*pmn09) INTO l_qty52   #No.FUN-940083
              FROM pmn_file, pmm_file
             WHERE pmn04  = new[i].new_part
               AND pmn01  = pmm01
               AND pmn20  > pmn50-pmn55-pmn58                #No.FUN-940083
               AND pmn16  <='2'
               AND pmn011 !='SUB'
               AND pmm18  != 'X'
            IF l_qty52 IS NULL THEN LET l_qty52=0 END IF

            #---->工單在製量
            SELECT SUM((sfb08-sfb09-sfb10-sfb11-sfb12)*ima55_fac)
              INTO l_qty53
              FROM sfb_file,ima_file
             WHERE sfb05 = ima01
               AND sfb05 = new[i].new_part
               AND sfb04 < '8'
               AND sfb02 <>'7'     #NO:7075?
               AND sfb08 > (sfb09+sfb11+sfb12)
               AND sfb87 !='X'
            IF l_qty53 IS NULL THEN LET l_qty53=0 END IF

            #---->委外在製量
            SELECT SUM((sfb08-sfb09-sfb10-sfb11-sfb12)*ima55_fac)
              INTO l_qty55
              FROM sfb_file,ima_file
             WHERE sfb05 =  ima01
               AND sfb05 =  new[i].new_part
               AND sfb04 <  '8'
               AND sfb02 =  '7'    #NO:7075?
               AND sfb08 >  (sfb09+sfb10+sfb11+sfb12)
               AND sfb87 != 'X'
            IF l_qty55 IS NULL THEN LET l_qty55=0 END IF

            #---->IQC在驗量
            SELECT SUM((rvb07-rvb29-rvb30)*pmn09) INTO l_qty54
              FROM rvb_file, rva_file, pmn_file
             WHERE rvb05 = new[i].new_part
               AND rvb01 = rva01
               AND rvb04 = pmn01
               AND rvb03 = pmn02
               AND rvb07 > (rvb29+rvb30)
               AND rvaconf='Y'
            IF l_qty54 IS NULL THEN LET l_qty54=0 END IF

            #---->FQC 在驗量
            SELECT SUM(sfb11) INTO l_qty56
              FROM sfb_file
             WHERE sfb05 =  new[i].new_part
               AND sfb02 <> '7'    #NO:7075?
               AND sfb87 != 'X'
               AND sfb04 <  '8'
            IF l_qty56 IS NULL THEN LET l_qty56=0 END IF

            LET new[i].new_qty5=l_qty51+l_qty52+l_qty53+l_qty54+l_qty55+l_qty56

          #---->在途量(需求)*********************************************
            #---->受訂量
            SELECT SUM((oeb12-oeb24)*oeb05_fac) INTO l_qty61
              FROM oeb_file, oea_file
             WHERE oeb04   = new[i].new_part
               AND oeb01   = oea01
               AND oea00   <>'0'
               AND oeb70   = 'N'
               AND oeb12   > oeb24
               AND oeaconf != 'X'
            IF l_qty61 IS NULL THEN LET l_qty61=0 END IF

            LET l_qty62=0
            LET l_qty63=0
            LET l_sql = "SELECT sfa_file.*",
                        "  FROM sfb_file,sfa_file",
                        " WHERE sfa03 = '",new[i].new_part,"'",
                        "   AND sfb01 = sfa01 ",
                        "   AND sfb04 !='8'",
                        "   AND sfb87 !='X'"
            PREPARE i301_sum_pre FROM l_sql
            DECLARE i301_sum CURSOR FOR i301_sum_pre
            FOREACH i301_sum INTO lr_sfa.*
               CALL s_shortqty(lr_sfa.sfa01,lr_sfa.sfa03,lr_sfa.sfa08,
                               lr_sfa.sfa12,lr_sfa.sfa27,lr_sfa.sfa012,lr_sfa.sfa013)  #FUN-A50066
                 RETURNING g_short_qty
               IF cl_null(g_short_qty) THEN LET g_short_qty = 0 END IF
               IF (lr_sfa.sfa05 > (lr_sfa.sfa06+ g_short_qty)) OR (g_short_qty > 0) THEN
                  LET l_qty62= l_qty62 + ((lr_sfa.sfa05 - lr_sfa.sfa06 - g_short_qty) * lr_sfa.sfa13)
                  LET l_qty63= l_qty63 + (g_short_qty * lr_sfa.sfa13)
               END IF
            END FOREACH

            LET new[i].new_qty6 = l_qty61+l_qty62+l_qty63
            #---->出貨備置量(alocated)
            SELECT SUM(oeb905*oeb05_fac) INTO new[i].new_qty7     #no.7182
              FROM oeb_file, oea_file, occ_file
             WHERE oeb04 = new[i].new_part
               AND oeb01 = oea01
               AND oea00 <> '0'
               AND oeb19 = 'Y'
               AND oeb70 = 'N'
               AND oeb12 > oeb24
               AND oea03 = occ01
            IF new[i].new_qty7 IS NULL THEN LET new[i].new_qty7=0 END IF

            #---->可用量
            LET new[i].new_qty8
#               =new[i].ima262 + new[i].new_qty5 - new[i].new_qty6   #NO.FUN-A20044
                =new[i].avl_stk + new[i].new_qty5 - new[i].new_qty6  #NO.FUN-A20044
            DISPLAY new[i].new_qty5 TO s_new[j].new_qty5
            DISPLAY new[i].new_qty6 TO s_new[j].new_qty6
            DISPLAY new[i].new_qty7 TO s_new[j].new_qty7
            DISPLAY new[i].new_qty8 TO s_new[j].new_qty8
            LET l_tot = 0
   ###折和量累加
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                  new[i].new_yes = "Y"  THEN
                  LET l_tot = l_tot + new[i].new_qty3
               END IF
            END FOR
            DISPLAY BY NAME l_tot

         AFTER INPUT

            IF INT_FLAG THEN
               LET INT_FLAG=0
               EXIT INPUT
            END IF

            LET g_success = 'Y'

            BEGIN WORK
            LET l_t=0               #TQC-B40025
            LET l_tot = 0
            FOR i = 1 TO new.getLength()
               IF new[i].new_part IS NOT NULL AND
                   new[i].new_yes = "Y"                        THEN  #MOD-490390  #MOD-A50107 mark   #MOD-C30037 remark
                  #new[i].new_yes = "Y" AND new[i].new_qty !=0 THEN  #MOD-490390  #MOD-A50107        #MOD-C30037 mark
                #重新抓取發料單位與轉換率
                  SELECT ima63,ima63_fac,ima86,ima86_fac INTO l_ima63,
                    l_ima63_fac,l_ima86,l_ima86_fac
                    FROM ima_file
                   WHERE ima01 = new[i].new_part

                   IF STATUS THEN
                      CALL cl_err('sel ima63',STATUS,1)
                      LET g_success ='N'
                      EXIT INPUT
                   END IF
                  #LET g_gfe03=i301_gfe03(l_sfa.sfa12) #FUN-640147                   #FUN-D60039 mark
                  #LET new[i].new_qty=cl_digcut(new[i].new_qty,g_gfe03) #FUN-640147  #FUN-D60039 mark
                  LET new[i].new_qty=s_digqty(new[i].new_qty,l_sfa.sfa12)  #FUN-D60039 add
                  LET l_tot = l_tot + new[i].new_qty3
                  LET l_sfa.sfa03 = new[i].new_part
                  LET l_sfa.sfa04 = new[i].new_qty
                  LET l_sfa.sfa05 = new[i].new_qty
                  LET l_sfa.sfa06 = 0
                  LET l_sfa.sfa061 = 0
                  LET l_sfa.sfa062 = 0
                  LET l_sfa.sfa063 = 0
                  LET l_sfa.sfa064 = 0
                  LET l_sfa.sfa065 = 0
                  LET l_sfa.sfa066 = 0
                  IF l_sfa.sfa08 IS NULL THEN LET l_sfa.sfa08=' ' END IF
                  LET l_sfa.sfa12=l_ima63
                  LET l_sfa.sfa13=l_ima63_fac
                  LET l_sfa.sfa14=l_ima86
                  LET l_sfa.sfa15=l_ima86_fac
                  LET l_sfa.sfa16 = 0
                  LET l_sfa.sfa161= 0
                  LET l_sfa.sfa25 = new[i].new_qty
                  LET l_sfa.sfa012 = old_sfa012  #FUN-A50066
                  LET l_sfa.sfa013 = old_sfa013  #FUN-A50066
                  LET l_tot = s_digqty(l_tot,l_sfa.sfa12)   #FUN-910088--add--
                  IF old_sfa26 MATCHES '[13]' THEN
                     LET l_sfa.sfa26 = 'U'
                  ELSE
                     LET l_sfa.sfa26 = 'S'
                  END IF

                  LET l_sfa.sfa28 = new[i].new_rate
                  IF cl_null(l_sfa.sfa100) THEN
                     LET l_sfa.sfa100 = 0
                  END IF

                  LET l_sfa.sfaplant = g_plant #FUN-980008 add
                  LET l_sfa.sfalegal = g_legal #FUN-980008 add

#TQC-A50141 --add
                  IF cl_null(l_sfa.sfa012) THEN
                     LET l_sfa.sfa012 = ' '
                  END IF
                  IF cl_null(l_sfa.sfa013) THEN
                     LET l_sfa.sfa013 = 0
                  END IF
#TQC-A50141 --end
                  INSERT INTO sfa_file VALUES (l_sfa.*)
                  #TQC-B40025--begin
                  IF SQLCA.sqlerrd[3]>0 THEN
                     LET l_t=l_t+1
                  END IF
                  #TQC-B40025--end
                  IF SQLCA.SQLCODE THEN
                     IF cl_sql_dup_value(SQLCA.SQLCODE) THEN  #CHI-790021
                        UPDATE sfa_file SET
                           sfa05=sfa05 + new[i].new_qty,
                           sfa27=l_sfa.sfa27,sfa26=l_sfa.sfa26,    #MOD-990105 add
                           sfa16 = 0 , sfa161= 0 ,
                           sfa25=l_sfa.sfa25 + new[i].new_qty
                         WHERE sfa01=g_sfb.sfb01 AND sfa03=new[i].new_part
                           AND sfa08=l_sfa.sfa08 AND sfa12=l_sfa.sfa12
                           AND sfa27=old_part       #CHI-7B0034
                           AND sfa012=old_sfa012    #FUN-A50066
                           AND sfa013=old_sfa013    #FUN-A50066
                         IF SQLCA.SQLCODE THEN
                            CALL cl_err3("upd","sfa_file",g_sfb.sfb01,new[i].new_part,STATUS,"","update sfa",1)  #No.FUN-660128
                            LET g_success ='N' EXIT FOR
                         #MOD-A10075----Begin
                         ELSE
                            SELECT sfa05,sfa06 INTO l_sfa05,l_sfa06 FROM sfa_file
                             WHERE sfa01 = g_sfb.sfb01 AND sfa03=new[i].new_part
                               AND sfa08=l_sfa.sfa08 AND sfa12=l_sfa.sfa12
                               AND sfa27=old_part
                               AND sfa012=old_sfa012    #FUN-A50066
                               AND sfa013=old_sfa013    #FUN-A50066
                            IF cl_null(l_sfa05) THEN LET l_sfa05 = 0 END IF
                            IF cl_null(l_sfa06) THEN LET l_sfa06 = 0 END IF
                           #IF l_sfa05 + new[i].new_qty < l_sfa06 THEN   #MOD-A40130 mark
                            IF l_sfa05 < l_sfa06 THEN                    #MOD-A40130
                               CALL cl_err3("upd","sfa_file",g_sfb.sfb01,new[i].new_part,'asf-072',"","update sfa",1)
                               LET g_success ='N' EXIT FOR
                            ELSE                     #TQC-B40025
                            	 LET l_t=l_t+1         #TQC-B40025
                            END IF
                         #MOD-A10075----End
                         END IF
                     ELSE
                       CALL cl_err('ins sfa',STATUS,1)
                       LET g_success ='N'
                       EXIT FOR
                    END IF
                  END IF
               END IF
            END FOR
            DISPLAY BY NAME l_tot
            IF g_success = 'Y' THEN
                IF l_tot > old_qty THEN
                   CALL cl_err('','mfg6202',1)
                   LET g_success = 'N'
                ELSE
                 #IF l_tot != 0 THEN     #no.5227,6776...................    #MOD-C30037 mark
                    #MOD-B80308---add---start---
                     LET l_ima64=0
                     SELECT ima64 INTO l_ima64 FROM ima_file
                       WHERE ima01 = old_part
                    #MOD-B80308---add---end---
                     LET left_qty = left_qty - l_tot
                     #TQC-B50078--begin
                     IF left_qty!=0 THEN
                        IF l_ima64 <> 0 THEN  #TQC-B60365 add
                           IF left_qty < 0 THEN
                              LET l_double=(left_qty/l_ima64)- 0.999999
                           ELSE
                              LET l_double=(left_qty/l_ima64)+ 0.999999
                           END IF
                           LET left_qty=l_double*l_ima64
                           LET left_qty = s_digqty(left_qty,l_sfa.sfa12)    #FUN-910088--add--
                        END IF  #TQC-B60365 add
                     END IF
                     #TQC-B50078--end
                     IF old_sfa26='1' THEN LET old_sfa26='3' END IF
                     IF old_sfa26='2' THEN LET old_sfa26='4' END IF
                     UPDATE sfa_file SET sfa05=left_qty,
                                         sfa25=sfa25-l_tot,
                                         sfa26=old_sfa26
                        WHERE sfa01 = g_sfb.sfb01
                          AND sfa03 = old_part AND sfa08 = old_sfa08
                          AND sfa27 = old_part  #CHI-7B0034
                         #AND sfa12 = l_ima63_a  #TQC-960234    #MOD-AC0323 mark
                          AND sfa012 = old_sfa012 #FUN-A50066
                          AND sfa013 = old_sfa013 #FUN-A50066
                       IF STATUS THEN
                          CALL cl_err3("upd","sfa_file",g_sfb_t.sfb01,old_part,STATUS,"","upd sfa",1)  #No.FUN-660128
                          LET g_success ='N'
                       END IF
                 #END IF               #bug end.....................         #MOD-C30037 mark
                END IF
            END IF
            IF g_success = 'Y' THEN
               IF l_t>0 THEN                 #TQC-B40025
                  COMMIT WORK
                  CALL cl_err('','9062',1)   #NO:7075
               ELSE                          #TQC-B40025
               	  ROLLBACK WORK              #TQC-B40025
                  CALL cl_err('','9050',1)   #TQC-B40025
               END IF                        #TQC-B40025
            ELSE
               ROLLBACK WORK
               CALL cl_err('','9050',1)   #NO:7075
               NEXT FIELD new_yes
            END IF

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT

      END INPUT

      IF g_sfb.sfb87 = 'Y' THEN  #FUN-C20126 add
        #TQC-A10124 add str --
         IF g_success = 'Y' AND g_aza.aza90 MATCHES "[Yy]" THEN
            IF g_sfb.sfb02 = '1' OR g_sfb.sfb02 = '5' OR  g_sfb.sfb02 = '13' THEN     #FUN-CC0122 add g_sfb.sfb02 = '5'
               CALL i301_mes('update',g_sfb.sfb01)
            END IF
         END IF
        #TQC-A10124 add end --
      END IF  #FUN-C20126 add

      CLEAR FORM
      CALL g_sfa.clear()
      CALL g_sfa29.clear()
   END WHILE

END FUNCTION

FUNCTION i301_crrut(p_cmd)   #MOD-A40026 add p_cmd
  DEFINE p_cmd     LIKE type_file.chr1    #MOD-A40026 add
  DEFINE l_ecb     RECORD LIKE ecb_file.*
  DEFINE l_ima571  LIKE ima_file.ima571
  DEFINE l_ecu02   LIKE ecu_file.ecu02
  DEFINE l_code    LIKE type_file.chr1    #No.FUN-680121 VARCHAR(01)
  DEFINE l_flag    LIKE type_file.chr1    #MOD-A40119 add
  DEFINE l_flag1   LIKE type_file.num5    #MOD-AC0336

  #No.+092 010427 by linda add  委外工單不產生製程
  IF g_sfb.sfb02 MATCHES '[78]' THEN
     CALL cl_err('','mfg-022',1)
     RETURN
  END IF
  #No.+325 010629 add by linda 已確認則不可重新產生製程
  IF g_sfb.sfb87 = 'Y' THEN
     CALL cl_err(g_sfb.sfb87,'mfg-055',1)
     RETURN
  END IF
    IF g_sfb.sfb87 = 'X'   THEN CALL cl_err('','9024',1) RETURN END IF
  IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43 = '9' THEN
     CALL cl_err('','9024',1)
     RETURN
  END IF

 #str MOD-A40119 add
  LET l_flag = 'N'
  IF p_cmd = "u" THEN
     #有變更製程編號,需重新產生製程資料
     IF cl_null(g_sfb_t.sfb06) OR g_sfb.sfb06 != g_sfb_t.sfb06 THEN
        LET l_flag = 'Y'
     END IF
     IF l_flag = 'N' THEN
        #沒製程資料,但工單單頭有製程編號,需重新產生製程資料
        LET g_cnt = 0
        SELECT COUNT(*) INTO g_cnt FROM ecm_file
         WHERE ecm01=g_sfb.sfb01
        IF cl_null(g_cnt) THEN LET g_cnt = 0 END IF
        IF not cl_null(g_sfb.sfb06) AND g_cnt = 0 THEN
           LET l_flag = 'Y'
        END IF
     END IF
  END IF
 #end MOD-A40119 add

 #IF NOT cl_null(g_sfb.sfb06) THEN                         #MOD-A40026 mark
  IF NOT cl_null(g_sfb.sfb06) AND                          #MOD-A40026
     (p_cmd="a" OR ( p_cmd="u" AND l_flag = 'Y')) THEN     #MOD-A40026  #MOD-A40119 mod
                   #(cl_null(g_sfb_t.sfb06) OR             #MOD-A40026  #MOD-A40119 mark
                   # g_sfb.sfb06 != g_sfb_t.sfb06))) THEN  #MOD-A40026  #MOD-A40119 mark
     #---->check 製程追蹤是否有投入等量
     SELECT COUNT(*) INTO g_cnt FROM ecm_file
      WHERE ecm01=g_sfb.sfb01
        AND (ecm301+ecm302+ecm303)<>0  #(良入 + 重入)

      IF g_cnt > 0 THEN
        IF NOT cl_confirm('asf-017') THEN
           CALL cl_err('','asf-386',1)
           RETURN
        END IF
      END IF

      #生產日報已有資料
      SELECT COUNT(*) INTO g_cnt FROM shb_file WHERE shb05 = g_sfb.sfb01
                                                 AND shbconf = 'Y'     #FUN-A70095
      IF g_cnt > 0 THEN CALL cl_err('','asf-025',1) RETURN END IF

      SELECT COUNT(*) INTO g_cnt FROM ecm_file WHERE ecm01=g_sfb.sfb01
      IF g_cnt > 0 THEN
           DELETE FROM ecm_file WHERE ecm01=g_sfb.sfb01
           IF SQLCA.sqlerrd[3]=0 THEN
              CALL cl_err3("del","ecm_file",g_sfb.sfb01,"","asf-026","","",1)  #No.FUN-660128
              RETURN
          #TQC-B80089 mark str-----
          ##TQC-940179 ADD --STR----------------------------
          #ELSE
          #   IF g_sma.sma901='Y' THEN
          #      DELETE FROM vmn_file
          #       WHERE vmn02 = g_sfb.sfb01
          #      DELETE FROM vnm_file
          #       WHERE vnm01 = g_sfb.sfb01
          #   END IF
          ##TQC-940179 ADD --END----------------------------
          #TQC-B80089 mark end-----
           END IF
      END IF
     #TQC-B80089 add str-----
      IF g_sma.sma901='Y' THEN
         DELETE FROM vmn_file
          WHERE vmn02 = g_sfb.sfb01
         DELETE FROM vnm_file
          WHERE vnm01 = g_sfb.sfb01
      END IF
     #TQC-B80089 add end-----
      SELECT COUNT(*) INTO g_cnt FROM sgd_file where sgd00=g_sfb.sfb01
      IF g_cnt > 0 THEN
         DELETE FROM sgd_file WHERE sgd00=g_sfb.sfb01
         IF SQLCA.sqlerrd[3]=0 THEN
            CALL cl_err3("del","sgd_file",g_sfb.sfb01,"","asf-024","","",1)
            RETURN
         END IF
      END IF
      #99/06/23----展追蹤先用--->ima571產品料號+ecu02製程編號
    #MOD-AC0336--begin--modify--將下面一段獨立成FUNCTION
    # SELECT ima571 INTO l_ima571 FROM ima_file
    #  WHERE ima01=g_sfb.sfb05

    # IF l_ima571 IS NULL THEN LET l_ima571=' ' END IF # when ima571=''

    # LET g_cnt = 0                                 #MOD-A40119 add
    ##SELECT ecu01 FROM ecu_file                    #MOD-A40119 mark
    # SELECT COUNT(ecu01) INTO g_cnt FROM ecu_file  #MOD-A40119
    #  WHERE ecu01=l_ima571 AND ecu02=g_sfb.sfb06
    # IF cl_null(g_cnt) THEN LET g_cnt = 0 END IF   #MOD-A40119 add
    ##IF STATUS THEN     #MOD-A40119 mark
    # IF g_cnt = 0 THEN  #MOD-A40119
    #    LET g_cnt = 0                                 #MOD-A40119 add
    #   #SELECT ecu01 FROM ecu_file                    #MOD-A40119 mark
    #    SELECT COUNT(ecu01) INTO g_cnt FROM ecu_file  #MOD-A40119
    #     WHERE ecu01=g_sfb.sfb05
    #       AND ecu02=g_sfb.sfb06
    #    IF cl_null(g_cnt) THEN LET g_cnt = 0 END IF   #MOD-A40119 add
    #   #IF STATUS THEN     #MOD-A40119 mark
    #    IF g_cnt = 0 THEN  #MOD-A40119
    #       CALL cl_err3("sel","ecu_file",g_sfb.sfb05,g_sfb.sfb06,STATUS,"","sel ecu:",1)  #No.FUN-660128
    #       RETURN
    #    ELSE
    #       LET g_ecu01=g_sfb.sfb05
    #    END IF
    # ELSE
    #    LET g_ecu01=l_ima571
    # END IF
      CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag1,g_ecu01
      IF l_flag1 = 0 THEN    #出錯
         CALL cl_err3("sel","ecu_file",g_sfb.sfb05,g_sfb.sfb06,STATUS,"","sel ecu:",1)
         RETURN
      END IF
    #MOD-AC0336--end--modify----------

      CALL s_schdat(0,g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb071,g_sfb.sfb01,
                    g_sfb.sfb06,g_sfb.sfb02,g_ecu01,g_sfb.sfb08,2)
          RETURNING g_cnt,g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb32,g_sfb.sfb24
      DISPLAY BY NAME g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb24
      SELECT count(*) INTO g_cnt FROM ecm_file WHERE ecm01 = g_sfb.sfb01
      IF g_cnt > 0 THEN LET g_sfb.sfb24 = 'Y' ELSE LET g_sfb.sfb24 = 'N' END IF
      SELECT count(*) INTO g_cnt FROM sfb_file
       WHERE sfb01=g_sfb.sfb01
         AND (sfb13 IS NOT NULL AND sfb15 IS NOT NULL )
      IF g_cnt > 0 THEN
         UPDATE sfb_file SET sfb24=g_sfb.sfb24 WHERE sfb01=g_sfb.sfb01
         SELECT sfb13,sfb15 INTO g_sfb.sfb13,g_sfb.sfb15 FROM sfb_file
          WHERE sfb01=g_sfb.sfb01
         DISPLAY BY NAME g_sfb.sfb13,g_sfb.sfb15,g_sfb.sfb24
      ELSE
         UPDATE sfb_file SET sfb13=g_sfb.sfb13,
                             sfb15=g_sfb.sfb15,
                             sfb24=g_sfb.sfb24
          WHERE sfb01=g_sfb.sfb01
      END IF
      CALL cl_getmsg('asf-386',g_lang) RETURNING g_msg
      CALL cl_msgany(0,0,g_msg)
 #str MOD-A40026 add
  ELSE
     IF g_sfb.sfb93='N' THEN   #MOD-A40119 add
        #製程編號空白的話,若先前已產生過製程追蹤檔應刪除,並將sfb24更新為N
        SELECT COUNT(*) INTO g_cnt FROM ecm_file WHERE ecm01=g_sfb.sfb01
        IF g_cnt > 0 THEN
           DELETE FROM ecm_file WHERE ecm01=g_sfb.sfb01
           IF SQLCA.sqlerrd[3]=0 THEN
#             CALL cl_err('','asf-026',1)   #No.FUN-660128
              CALL cl_err3("del","ecm_file",g_sfb.sfb01,"","asf-026","","",1)  #No.FUN-660128
              RETURN
           #TQC-940179 ADD --STR----------------------------
           ELSE
              IF g_sma.sma901='Y' THEN
                 DELETE FROM vmn_file
                  WHERE vmn02 = g_sfb.sfb01
                 DELETE FROM vnm_file
                  WHERE vnm01 = g_sfb.sfb01
              END IF
           #TQC-940179 ADD --END----------------------------
           END IF
        END IF
        #No.TQC-6A0062 --begin
        SELECT COUNT(*) INTO g_cnt FROM sgd_file where sgd00=g_sfb.sfb01
        IF g_cnt > 0 THEN
           DELETE FROM sgd_file WHERE sgd00=g_sfb.sfb01
           IF SQLCA.sqlerrd[3]=0 THEN
              CALL cl_err3("del","sgd_file",g_sfb.sfb01,"","asf-024","","",1)
              RETURN
           END IF
        END IF
        #No.TQC-6A0062 --end
        LET g_sfb.sfb24 = 'N'
        UPDATE sfb_file SET sfb24=g_sfb.sfb24 WHERE sfb01=g_sfb.sfb01
        DISPLAY BY NAME g_sfb.sfb24
     END IF   #MOD-A40119 add
 #end MOD-A40026 add
  END IF

END FUNCTION
FUNCTION i301_cralc()
   DEFINE l_minopseq   LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE l_btflg   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)
   DEFINE l_ima910     LIKE ima_file.ima910   #FUN-550112
   DEFINE l_n          LIKE type_file.num5    #No.TQC-770043
   #MOD-D30120---begin
   DEFINE l_ecm     RECORD LIKE ecm_file.*
   DEFINE l_ecm65   LIKE ecm_file.ecm65
   DEFINE l_ecb19   LIKE ecb_file.ecb19
   DEFINE l_ecb21   LIKE ecb_file.ecb21
   DEFINE l_ecb38   LIKE ecb_file.ecb38
   DEFINE l_cnt     LIKE type_file.num5
   #MOD-D30120---end

#TQC-C70119 ----------Begin-----------
   IF cl_null(g_sfb.sfb01) THEN
      CALL cl_err('','-400',0)
      RETURN
   END IF
#TQC-C70119 ----------End-------------

   #工單狀態=8.結案時不可產生備料
   IF g_sfb.sfb04 = '8' THEN
      CALL cl_err('','aap-730',0)
      RETURN
   END IF
   #工單確認後不可產生備料
   IF g_sfb.sfb87='Y' THEN
      CALL cl_err('','aap-086',1)
      RETURN
   END IF
   #工單作廢或簽核狀況=9.作廢時不可產生備料
   IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43 = '9' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
   #簽核狀況=S.送簽中或1.已核准時不可產生備料
   IF g_sfb.sfb43 MATCHES '[Ss1]' THEN
      CALL cl_err('','mfg3557',0)
      RETURN
   END IF
   #已存在子工單時不可產生備料
   SELECT COUNT(*) INTO l_n FROM sfb_file
    WHERE sfb86 = g_sfb.sfb01
      AND sfb01 != sfb86         #MOD-A80207 add
      AND sfb87 != 'X'            #MOD-B10155 add
   IF l_n > 0 THEN
      CALL cl_err('','asf-978',0)  #MOD-910148
      RETURN
   END IF

#FUN-A50066--begin--add-------------
   IF NOT i301sub_chk_sfb81(g_sfb.sfb93,g_sfb.sfb05,g_sfb.sfb95,g_sfb.sfb06,
                            g_sfb.sfb02,g_sfb.sfb071,g_sfb.sfb81) THEN
      RETURN
   END IF
#FUN-A50066--end--add-----------------

#FUN-A50066--begin--mark------------
#    #No.B474 010507 by plum add 若此BOM尚未發放,不可用
#     SELECT COUNT(*) INTO g_cnt FROM bma_file
#      WHERE bma01=g_sfb.sfb05
#        AND bma06 = g_sfb.sfb95 #No.MOD-640245 add
#
#     IF g_cnt >0 AND g_sfb.sfb02 !=15 THEN   #NO:7112 此判斷應剔除 '15'試產性工單
#         SELECT COUNT(*) INTO g_cnt FROM bma_file
#          WHERE bma05 IS NOT NULL AND bma05 <=g_sfb.sfb071
#            AND bma01=g_sfb.sfb05
#            AND bma06 = g_sfb.sfb95 #No.MOD-640245 add
#
#         IF g_cnt =0 THEN
#            CALL cl_err(g_sfb.sfb071,'abm-005',0)
#            RETURN
#         END IF
#
#         SELECT COUNT(*) INTO g_cnt FROM bma_file
#         WHERE bma05 IS NOT NULL AND bma05 <=g_sfb.sfb81
#           AND bma01=g_sfb.sfb05
#           AND bma06 = g_sfb.sfb95 #No.MOD-640245 add
#
#         IF g_cnt =0 THEN
#            CALL cl_err(g_sfb.sfb81,'abm-006',0)
#            RETURN
#         END IF
#      END IF
#FUN-A50066--end--mark-------------------
   #備料單身已有資料時,詢問是否確定要執行此動作(確定執行會將備料資料刪除後重新產生)
   SELECT COUNT(*) INTO g_cnt FROM sfa_file
    WHERE sfa01=g_sfb.sfb01
   IF g_cnt > 0 THEN
      IF NOT cl_sure(0,0) THEN
         RETURN
      END IF
   END IF

   #工單已發過料(已發數量<>0或超領數量<>0或報廢數量<>0或盤盈虧量<>0)時不可產生備料
   SELECT COUNT(*) INTO g_cnt FROM sfa_file
    WHERE sfa01=g_sfb.sfb01
      AND (sfa06<>0 OR sfa062<>0 OR sfa063<>0 OR sfa064<>0)
   IF g_cnt>0 THEN CALL cl_err('','asf-413',0) RETURN END IF


   DELETE FROM sfa_file WHERE sfa01=g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err3("del","sfa_file",g_sfb.sfb01,"",STATUS,"","del sfa:",1)  #No.FUN-660128
      RETURN
   END IF
   DELETE FROM tc_sfa_file WHERE tc_sfa01=g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err3("del","tc_sfa_file",g_sfb.sfb01,"",STATUS,"","del tc_sfa:",1)  #No.FUN-660128
      RETURN
   END IF




   #FUN-A60088--begin--add------------------------------
   IF g_sma.sma542='Y' AND g_sfb.sfb93='Y' THEN
    # IF g_action_choice = "gen_allotment" THEN   #FUN-9C0119--mark
      IF g_action_choice = "gen_allotment" OR g_action_choice = "reproduce" THEN  #FUN-9C0119
         DELETE FROM ecm_file WHERE ecm01=g_sfb.sfb01
         IF g_sma.sma26='2' AND g_sfb.sfb02 != 11 AND g_sfb.sfb02 != 15
            AND g_sfb.sfb02 != 7  AND g_sfb.sfb02 != 8  THEN
            CALL i301_crrut('a')
         END IF
      END IF
   END IF
   #FUN-A60088--end--add--------------------------------

   CALL s_minopseq(g_sfb.sfb05,g_sfb.sfb06,g_sfb.sfb071) RETURNING l_minopseq

   CASE
      WHEN g_sfb.sfb02='13'     #預測工單展至尾階
           CALL s_cralc2(g_sfb.sfb01,g_sfb.sfb02,g_sfb.sfb05,'Y',
                         g_sfb.sfb08,g_sfb.sfb071,'Y',g_sma.sma71,l_minopseq,
                         ' 1=1',g_sfb.sfb95)   #No.TQC-610003
           RETURNING g_cnt
      WHEN g_sfb.sfb02='15'     #試產性工單
           CALL s_cralc3(g_sfb.sfb01,g_sfb.sfb02,g_sfb.sfb05,'Y',
                         g_sfb.sfb08,g_sfb.sfb071,'Y',g_sma.sma71,
                         g_sfb.sfb07,g_sma.sma883,g_sfb.sfb95)  #No.TQC-610003
           RETURNING g_cnt
      OTHERWISE                 #一般工單展單階
          IF g_sfb.sfb02 = 11 THEN
             LET l_btflg = 'N'
          ELSE
             LET l_btflg = 'Y'
          END IF
          CALL s_cralc(g_sfb.sfb01,g_sfb.sfb02,g_sfb.sfb05,l_btflg,
                      #g_sfb.sfb08,g_sfb.sfb071,'Y',g_sma.sma71,l_minopseq,g_sfb.sfb95)  #No.TQC-610003
                       g_sfb.sfb08,g_sfb.sfb071,'Y',g_sma.sma71,l_minopseq,'',g_sfb.sfb95)  #No.TQC-610003  #FUN-BC0008 mod
             RETURNING g_cnt
            #---No.MOD-590117 判斷sfb02若為'5，11'時不產生子工單
               IF g_sfb.sfb02 != '5' AND g_sfb.sfb02 != '11' THEN
                   LET g_msg="asfp301 '",g_sfb.sfb01,"' '",   # for top40
                              g_sfb.sfb81,"' '99' 'N'"
                   CALL cl_cmdrun_wait(g_msg)
               END IF

   END CASE

   #MOD-D30120---begin
   SELECT COUNT(*) INTO l_cnt
     FROM ecm_file
    WHERE ecm01 = g_sfb.sfb01
   IF l_cnt > 0 THEN
      DECLARE ecm_cus CURSOR FOR
         SELECT * FROM ecm_file
          WHERE ecm01 = g_sfb.sfb01
      FOREACH ecm_cus INTO l_ecm.*
         SELECT ecb19,ecb21,ecb38 INTO l_ecb19,l_ecb21,l_ecb38
           FROM ecb_file
          WHERE ecb01 = g_sfb.sfb05
            AND ecb02 = g_sfb.sfb06
            AND ecb03 = l_ecm.ecm03
            AND ecb012 = l_ecm.ecm012
         CALL cralc_eck_rate(g_sfb.sfb01,l_ecm.ecm03,l_ecm.ecm012,g_sfb.sfb08,l_ecm.ecm12,l_ecm.ecm34,
                            l_ecm.ecm64,l_ecm.ecm62/l_ecm.ecm63,1)
         RETURNING l_ecm65
         LET l_ecm65 = s_digqty(l_ecm65,l_ecm.ecm58)

         UPDATE ecm_file
            SET ecm14 = l_ecb19 * g_sfb.sfb08,
                ecm16 = l_ecb21 * g_sfb.sfb08,
                ecm49 = l_ecb38 * g_sfb.sfb08,
                ecm65 = l_ecm65
          WHERE ecm01 = l_ecm.ecm01
            AND ecm03 = l_ecm.ecm03
            AND ecm012 = l_ecm.ecm012
      END FOREACH
   END IF
   #MOD-D30120---end

   LET g_sfb.sfb23='Y'
   DISPLAY BY NAME g_sfb.sfb23

   SELECT COUNT(*) INTO g_cnt FROM sfa_file
    WHERE sfa01=g_sfb.sfb01

   DISPLAY ARRAY g_sfa TO s_sfa.* ATTRIBUTE(COUNT=g_cnt)

      BEFORE DISPLAY
        EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

FUNCTION i301_dealc()
   DEFINE l_minopseq    LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE l_cnt         LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE l_sfb86_cnt   LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE l_sfb01       LIKE sfb_file.sfb01
   DEFINE l_sql         STRING                 #No.FUN-870117
   DEFINE l_k           LIKE type_file.num5    #No.FUN-870117
   DEFINE l_n           LIKE type_file.num5    #No.FUN-870117


   IF g_sfb.sfb04 = '8'   THEN CALL cl_err('','aap-730',0) RETURN END IF

   IF g_sfb.sfb87='Y'     THEN CALL cl_err('','aap-086',1) RETURN END IF
   IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43 = '9' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
   IF g_sfb.sfb43 MATCHES '[Ss1]' THEN
      CALL cl_err('','mfg3557',0)
      RETURN
   END IF

   SELECT COUNT(*) INTO g_cnt FROM sfa_file
    WHERE sfa01=g_sfb.sfb01
      AND (sfa06<>0 OR sfa062<>0 OR sfa063<>0 OR sfa064<>0)

   IF g_cnt>0 THEN CALL cl_err('','asf-413',0) RETURN END IF

  #CHECK是否有已確認的子工單
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM sfb_file
    WHERE sfb86 = g_sfb.sfb01
      AND ( sfb86 IS NOT NULL AND sfb86 != ' ')
      AND sfb87 = 'Y'
   IF l_cnt > 0 THEN
      CALL cl_err('','asf-102',1)  #MOD-910148 modify 0->1
      LET g_success = 'N'   #MOD-910148 add
      RETURN
   END IF

  #CHECK是否有未確認的子工單
   LET l_sfb86_cnt = 0
   SELECT COUNT(*) INTO l_sfb86_cnt FROM sfb_file
    WHERE sfb86 = g_sfb.sfb01
      AND ( sfb86 IS NOT NULL AND sfb86 != ' ')
      AND sfb87 = 'N'
   IF cl_null(l_sfb86_cnt) THEN
      LET l_sfb86_cnt =  0
   END IF

   BEGIN WORK

   LET g_success = 'Y'

  #表示有尚未確認的子工單需要一起清除
   IF l_sfb86_cnt > 0 THEN
      DECLARE i301_dealc_cs CURSOR FOR
       SELECT sfb01 FROM sfb_file WHERE sfb86 = g_sfb.sfb01
          AND ( sfb86 IS NOT NULL AND sfb86 != ' ')
          AND sfb87 = 'N'
          AND sfb01 != sfb86    #MOD-A80207 add

      FOREACH i301_dealc_cs INTO l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err('',SQLCA.sqlcode,0)
           LET g_success = 'N'
           EXIT FOREACH
        END IF
        MESSAGE "Delete sub WO !"
        DELETE FROM sfb_file WHERE sfb01 = l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","sfb_file",l_sfb01,"",SQLCA.sqlcode,"","No sfb deleted_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF

        DELETE FROM sfa_file WHERE sfa01 = l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","sfa_file",l_sfb01,"",SQLCA.sqlcode,"","del sfa_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF
        DELETE FROM tc_sfa_file WHERE tc_sfa01 = l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","tc_sfa_file",l_sfb01,"",SQLCA.sqlcode,"","del tc_sfa_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF
#TQC-BA0162--begin
#TQC-BA0162--end

        DELETE FROM ecm_file WHERE ecm01 = l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","ecm_file",l_sfb01,"",STATUS,"","del ecm_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        #TQC-940179 ADD --STR----------------------------
        ELSE
           IF g_sma.sma901='Y' THEN
              DELETE FROM vmn_file
               WHERE vmn02 = l_sfb01
              DELETE FROM vnm_file
               WHERE vnm01 = l_sfb01
           END IF
        #TQC-940179 ADD --END----------------------------
        END IF

        DELETE FROM sfd_file WHERE sfd03 = l_sfb01
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","sfd_file",l_sfb01,"",STATUS,"","del sfd_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF

       #DELETE FROM she_file WHERE she01 = g_sfb.sfb01   #MOD-C30754 mark
        DELETE FROM she_file WHERE she01 = l_sfb01       #MOD-C30754 add
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","she_file",g_sfb.sfb01,"",STATUS,"","del she_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF

       #DELETE FROM sfw_file WHERE sfw01 = g_sfb.sfb01   #MOD-C30754 mark
        DELETE FROM sfw_file WHERE sfw01 = l_sfb01       #MOD-C30754 add
        IF SQLCA.sqlcode THEN
           CALL cl_err3("del","sfw_file",g_sfb.sfb01,"",STATUS,"","del sfw_sub",1)  #No.FUN-660128
           LET g_success = 'N'
        END IF
      END FOREACH
   END IF
    IF g_sma.sma542='Y' AND g_sfb.sfb93='Y' THEN      #FUN-A60088
       DELETE FROM ecm_file WHERE ecm01=g_sfb.sfb01   #FUN-A60088
    END IF                                            #FUN-A60088
    DELETE FROM sfa_file WHERE sfa01=g_sfb.sfb01
    IF STATUS THEN
       CALL cl_err3("del","sfa_file",g_sfb.sfb01,"",STATUS,"","del sfa:",1)  #No.FUN-660128
       LET g_success = 'N'
    END IF
    DELETE FROM tc_sfa_file WHERE tc_sfa01=g_sfb.sfb01
    IF STATUS THEN
       CALL cl_err3("del","tc_sfa_file",g_sfb.sfb01,"",STATUS,"","del tc_sfa:",1)  #No.FUN-660128
       LET g_success = 'N'
    END IF

   UPDATE sfb_file SET sfb23='N'
    WHERE sfb01=g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err3("upd","sfb_file",g_sfb_t.sfb01,"",STATUS,"","upd sfb:",1)  #No.FUN-660128
      LET g_success = 'N'
   END IF

   IF g_success = 'N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
      LET g_sfb.sfb23='N'
      DISPLAY BY NAME g_sfb.sfb23
      CALL i301_b_fill(' 1=1')
   END IF

END FUNCTION

FUNCTION i301_v(p_row,p_col)
  DEFINE p_row,p_col  LIKE type_file.num5    #No.FUN-680121 SMALLINT
  DEFINE l_oea01      LIKE oea_file.oea01
  DEFINE l_ob01       LIKE ofb_file.ofb01
  DEFINE l_oea04      LIKE oea_file.oea04
  DEFINE l_oea44      LIKE oea_file.oea44
  DEFINE tm_a         LIKE type_file.chr1    #No.FUN-680121 VARCHAR(01)

   IF g_sfb.sfb01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF

   LET p_row = 8 LET p_col = 30

   OPEN WINDOW t301_v AT p_row,p_col WITH FORM "asf/42f/asfi301v"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

    CALL cl_ui_locale("asfi301v")


   INPUT tm_a WITHOUT DEFAULTS FROM a

       AFTER FIELD a
           IF cl_null(tm_a) THEN NEXT FIELD a END IF
           IF tm_a NOT MATCHES '[012]' THEN NEXT FIELD a END IF

           CASE tm_a
               WHEN '1'
                    IF g_sfb.sfb22 IS NULL THEN
                       EXIT INPUT
                    END IF
                    CALL s_axm_memo(g_sfb.sfb22,g_sfb.sfb221,'d')
               WHEN '2'
                    IF g_sfb.sfb22 IS NULL THEN
                       EXIT INPUT
                    END IF
                    SELECT oea01,oea04,oea44 INTO l_oea01,l_oea04,l_oea44
                      FROM oea_file
                     WHERE oea01=g_sfb.sfb22
                    IF cl_null(l_oea01) THEN
                       CALL cl_err(g_sfb.sfb22,'anm-027',0)
                       CLOSE WINDOW t301_v
                       RETURN
                     END IF
                     LET g_msg = "axmi230 '",l_oea04,"' '",l_oea44,"' 'D'"
                     CALL cl_cmdrun(g_msg)
               OTHERWISE
                   EXIT INPUT
                   # RETURN
           END CASE

      AFTER INPUT
           IF INT_FLAG THEN
              LET INT_FLAG=0
              EXIT INPUT
           END IF

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

   END INPUT

   CLOSE WINDOW t301_v

END FUNCTION

FUNCTION i301_t()     #bugno:7111 add
  DEFINE tm RECORD
         a               LIKE type_file.chr1     #No.FUN-680121 VARCHAR(1)
         END RECORD,
         l_cmd           LIKE type_file.chr1000, #No.FUN-680121 VARCHAR(100)
         p_row,p_col     LIKE type_file.num5    #No.FUN-680121 SMALLINT

   IF g_sfb.sfb87 = 'X'   THEN CALL cl_err('','9024',0) RETURN END IF

   WHILE TRUE
         LET p_row = 10 LET p_col = 35

         OPEN WINDOW t301_t_w AT p_row,p_col WITH FORM "asf/42f/asfi301t"
               ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

         CALL cl_ui_locale("asfi301t")


         INPUT BY NAME tm.a WITHOUT DEFAULTS
            AFTER FIELD a
                  IF tm.a NOT MATCHES '[012]' THEN
                     NEXT FIELD a
                  END IF
            ON IDLE g_idle_seconds
               CALL cl_on_idle()
               CONTINUE INPUT

         END INPUT
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            CLOSE WINDOW t301_t_w
            RETURN
         END IF
         CLOSE WINDOW t301_t_w

         CASE tm.a
              WHEN '0'     EXIT WHILE
              WHEN '1'     IF cl_null(g_sfb.sfb01) THEN
                              CALL cl_err('','-400',0)
                           ELSE
                              LET l_cmd = "asft801 '",g_sfb.sfb01 CLIPPED,"'"
                              CALL cl_cmdrun_wait(l_cmd)  #FUN-660216 add
                           END IF
              WHEN '2'     IF cl_null(g_sfb.sfb01) THEN
                              CALL cl_err('','-400',0)
                           ELSE
                              LET l_cmd = "asft802 '",g_sfb.sfb01 CLIPPED,"'"
                              CALL cl_cmdrun_wait(l_cmd)  #FUN-660216 add
                           END IF
         END CASE
   END WHILE
   CALL i301_b_fill('1=1')

END FUNCTION

FUNCTION i301_pmh05()
DEFINE l_pmh LIKE type_file.num10     #No.FUN-680121 INTEGER
DEFINE l_ima915 LIKE ima_file.ima915  #MOD-8C0175 add

  LET g_errno=' '  #MOD-CA0019 move
  #適用於委外工單
  IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) AND NOT cl_null(g_sfb.sfb05) THEN
     SELECT ima915 INTO l_ima915 FROM ima_file WHERE ima01=g_sfb.sfb05
     IF l_ima915 = 0  THEN RETURN  END IF
  END IF
 #LET g_errno=' '  #MOD-CA0019 mark
  LET l_pmh=0
  IF (g_sfb.sfb02=7 OR g_sfb.sfb02=8 ) THEN   #適用於委外工單
     ##廠商+料號不可空白才做確認,委外時廠商可空白
     IF NOT cl_null(g_sfb.sfb82) AND NOT cl_null(g_sfb.sfb05) THEN
        SELECT COUNT(*) INTO l_pmh FROM pmh_file
         WHERE pmh01=g_sfb.sfb05
           AND pmh02=g_sfb.sfb82
           AND pmh05='0'   #MOD-880097 modify 0->'0'
           AND pmh22 = '2' #CHI-860042  #MOD-880097 modify 1->2
           AND pmh23 = ' ' #CHI-960033
           AND pmhacti = 'Y'                                           #CHI-910021

        IF l_pmh=0 THEN
             LET g_errno='asf-970'
        END IF
     END IF
  END IF
END FUNCTION

FUNCTION i301_gfe03(p_unit)
DEFINE p_unit LIKE sfa_file.sfa12
DEFINE l_gfe03 LIKE gfe_file.gfe03
   SELECT gfe03 INTO l_gfe03 FROM gfe_file
      WHERE gfe01=p_unit
   IF SQLCA.sqlcode OR cl_null(l_gfe03) THEN
      LET l_gfe03=0
   END IF
   RETURN l_gfe03
END FUNCTION

FUNCTION i301_gen_m_iss()
DEFINE l_cnt  LIKE type_file.num10      #No.FUN-680121 INTEGER
DEFINE li_result LIKE type_file.num5    #No.FUN-680121 SMALLINT
DEFINE l_sno     LIKE type_file.num10   #No.FUN-680121 INTEGER
DEFINE tm RECORD
        ship    LIKE oay_file.oayslip,  #No.FUN-680121      VARCHAR(5),
        dept    LIKE  gem_file.gem01,   #No.FUN-680121      VARCHAR(6),
        gem02   LIKE  gem_file.gem02,
        reas    LIKE  azf_file.azf01,   #No.FUN-680121      VARCHAR(4),
        stk     LIKE  inb_file.inb05,   #No.FUN-680121      VARCHAR(10),
        azf03   LIKE  azf_file.azf03,
        loc     LIKE  ime_file.ime01    #No.FUN-680121      VARCHAR(10)
        END RECORD

DEFINE g_ina RECORD LIKE ina_file.*
DEFINE g_inb RECORD LIKE inb_file.*

DEFINE l_unit1 LIKE inb_file.inb08
DEFINE l_cmd        LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(100)
DEFINE p_row        LIKE type_file.num10,   #No.FUN-680121 INTEGER,
       p_col        LIKE type_file.num10    #No.FUN-680121 INTEGER

DEFINE l_err        STRING
DEFINE l_sfb98      LIKE sfb_file.sfb98 #FUN-670103
DEFINE l_rvbs       RECORD LIKE rvbs_file.*   #FUN-810045
DEFINE l_azf09      LIKE azf_file.azf09     #MOD-B70035 add
DEFINE l_ima24      LIKE ima_file.ima24     #TQC-BC0120 add

  IF g_sfb.sfb02<>'15' THEN
     CALL cl_err('','asf-305',1)
     RETURN
  END IF

  IF g_sfb.sfb43 MATCHES '[Ss]' THEN     #No:MOD-9C0040 modify
     CALL cl_err('','mfg3557',0)
     RETURN
  END IF

#TQC-B50031 --begin--
  IF g_sfb.sfb87 = 'N' THEN
     CALL cl_err('','alm-007',0)
     RETURN
  END IF
#TQC-B50031 --end--

  IF (g_sfb.sfb02=15 AND g_sfb.sfb87='Y' ) THEN
     LET l_cnt = 0
     SELECT COUNT(*) INTO l_cnt FROM ima_file
      WHERE ima01 IN (SELECT sfa03 FROM sfa_file WHERE sfa01 = g_sfb.sfb01)
        AND imaacti ='Y'
     IF l_cnt = 0 THEN  RETURN  END IF

#    如已產生過雜發單不可再重新產生
     LET l_cnt = 0
     SELECT COUNT(*) INTO l_cnt FROM ina_file
       WHERE ina10 = g_sfb.sfb01 and inapost <> 'X'

     IF l_cnt < 1 THEN
        LET p_row = 10 LET p_col = 35

        OPEN WINDOW i301_m_w AT p_row,p_col WITH FORM "asf/42f/asfi301m"
             ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

        CALL cl_ui_locale("asfi301m")

        IF NOT cl_null(g_sfb.sfb51) THEN
          LET tm.reas = g_sfb.sfb51  #FUN-810045
          LET l_azf09=' '      #MOD-B70035 add
          SELECT azf03,azf09 INTO tm.azf03,l_azf09 FROM azf_file    #MOD-B70035 add azf09,l_azf09
            WHERE azf01=tm.reas AND azf02='2'
         #MOD-B70035---add---start---
          IF l_azf09 !='4' OR cl_null(l_azf09) THEN
             CALL cl_err('','aoo-403',0)
             RETURN
          END IF
         #MOD-B70035---add---end---
        END IF
        INPUT BY NAME tm.ship,tm.dept,tm.reas,tm.stk,tm.loc
              WITHOUT DEFAULTS

           AFTER FIELD ship
             IF cl_null(tm.ship) THEN
                NEXT FIELD ship
             ELSE
               CALL s_check_no("aim",tm.ship,'','1',"ina_file","ina01","")
                 RETURNING li_result,tm.ship
               DISPLAY BY NAME tm.ship
               IF (NOT li_result) THEN
                   NEXT FIELD ship
               END IF
             END IF

           AFTER FIELD dept
             IF cl_null(tm.dept) THEN
          NEXT FIELD dept
             ELSE
                SELECT COUNT(*) INTO l_cnt FROM gem_file
                  WHERE gem01=tm.dept

                IF l_cnt = 0 THEN #部門別不存在
                   LET tm.dept=''
                   DISPLAY BY NAME tm.dept
                   NEXT FIELD dept
                ELSE
                  SELECT gem02 INTO tm.gem02 FROM gem_file
                    WHERE gem01=tm.dept
                  DISPLAY by NAME tm.gem02
                END IF
             END IF

           AFTER FIELD reas
             IF cl_null(tm.reas) THEN
          NEXT FIELD reas
             ELSE
                SELECT COUNT(*) INTO l_cnt FROM azf_file
                  WHERE azf01=tm.reas AND azf02='2'

                IF l_cnt < 0 THEN #理由碼不存在
                   LET tm.reas=''
                   DISPLAY BY NAME tm.reas
                   NEXT FIELD reas
                ELSE
                  LET l_azf09=' '      #MOD-B70035 add
                  SELECT azf03,azf09 INTO tm.azf03,l_azf09 FROM azf_file  #MOD-B70035 add azf09,l_azf09
                    WHERE azf01=tm.reas AND azf02='2'
                 #MOD-B70035---add---start---
                  IF l_azf09 !='4' OR cl_null(l_azf09) THEN
                     CALL cl_err('','aoo-403',0)
                     NEXT FIELD reas
                  END IF
                 #MOD-B70035---add---end---
                  DISPLAY by NAME tm.azf03
                END IF
             END IF

           AFTER FIELD stk
             IF NOT cl_null(tm.stk) THEN
                SELECT COUNT(*) INTO l_cnt FROM imd_file
                  WHERE imd01=tm.stk AND imd10='S'
                IF l_cnt < 0 THEN #倉庫別不存在
                   LET tm.stk=''
                   DISPLAY BY NAME tm.stk
                   NEXT FIELD stk
                END IF
                #Add No.FUN-AA0050
                IF NOT s_chk_ware(tm.stk) THEN  #检查仓库是否属于当前门店
                   NEXT FIELD stk
                END IF
                #End Add No.FUN-AA0050
             END IF

          #FUN-D40103 -----Begin--------
             IF NOT s_imechk(tm.stk,tm.loc) THEN
                LET tm.stk=''
                DISPLAY BY NAME tm.stk
             #  NEXT FIELD stk    #TQC-D50126
                NEXT FIELD loc    #TQC-D50126
             END IF
          #FUN-D40103 -----End----------
           AFTER FIELD loc
           #FUN-D40103 -----Begin------
            #IF NOT cl_null(tm.loc) THEN
            #   SELECT COUNT(*) INTO l_cnt FROM ime_file
            #     WHERE ime01=tm.loc

            #   IF l_cnt < 0 THEN #儲位不存在
            #      CALL cl_err('','asf-951',1)
            #      LET tm.loc=''
            #      DISPLAY BY NAME tm.stk
            #      NEXT FIELD loc
            #   END IF

            #END IF
             IF cl_null(tm.loc) THEN LET tm.loc = ' ' END IF    #TQC-D50126
             IF NOT s_imechk(tm.stk,tm.loc) THEN
                LET tm.loc=''
                DISPLAY BY NAME tm.loc
                NEXT FIELD loc
             END IF
           #FUN-D40103 -----End--------

           ON ACTION CONTROLP
              CASE
                WHEN INFIELD(ship)
                   LET g_t1 = s_get_doc_no(g_sfb.sfb01)       #No.FUN-550067
                   CALL q_smy( FALSE,TRUE,g_t1,'AIM','1') RETURNING g_t1  #TQC-670008
                   LET tm.ship=g_t1     #No.FUN-550067
                   DISPLAY tm.ship TO ship
                   NEXT FIELD ship
                WHEN INFIELD(dept)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form     = "q_gem"
                   CALL cl_create_qry() RETURNING tm.dept
                   DISPLAY tm.dept TO dept
                   NEXT FIELD dept
                WHEN INFIELD(reas)
                   CALL cl_init_qry_var()
                  #IET g_qryparam.form     = "q_azf"              #MOD-C60154 mark
                   LET g_qryparam.form ="q_azf01a"                #MOD-C60154 add
                  #IET g_qryparam.arg1='2'                        #MOD-C60154 mark
                   LET g_qryparam.arg1 = "4"                      #MOD-C60154 add
                   CALL cl_create_qry() RETURNING tm.reas
                   DISPLAY tm.reas TO reas
                   NEXT FIELD reas
                WHEN INFIELD(stk)
                  #Mod No.FUN-AA0050
                  #CALL cl_init_qry_var()
                  #LET g_qryparam.form     = "q_imd"
                  #LET g_qryparam.arg1 = 'S'
                  #CALL cl_create_qry() RETURNING tm.stk
                   CALL q_imd_1(FALSE,TRUE,"","S",g_plant,"","")  #只能开当前门店的
                        RETURNING tm.stk
                  #End Mod No.FUN-AA0050
                   DISPLAY tm.stk TO stk
                   NEXT FIELD stk
                WHEN INFIELD(loc)
                  #Mod No.FUN-AA0050
                  #CALL cl_init_qry_var()
                  #LET g_qryparam.form     = "q_ime1"
                  #LET g_qryparam.arg1 = 'S'
                  #CALL cl_create_qry() RETURNING tm.loc
                   CALL q_ime_2(FALSE,TRUE,"","","S",g_plant)
                        RETURNING tm.loc
                  #End Mod No.FUN-AA0050
                   DISPLAY tm.loc TO loc
                   NEXT FIELD loc
              END CASE

           ON IDLE g_idle_seconds
              CALL cl_on_idle()
              CONTINUE INPUT

           ON ACTION about
              CALL cl_about()

           ON ACTION controlg
              CALL cl_cmdask()

           ON ACTION help
              CALL cl_show_help()

        END INPUT

        IF INT_FLAG THEN
           LET INT_FLAG=0
           CLOSE WINDOW i301_m_w
        ELSE
     #塞雜發單
           BEGIN WORK
           INITIALIZE g_ina.* TO NULL
           LET g_ina.ina00   = '1'
           LET g_ina.ina02   = g_today
           LET g_ina.ina03   = g_today
           LET g_ina.ina04   = tm.dept
           LET g_ina.ina06   = g_sfb.sfb27    #TQC-C10041
           LET g_ina.ina10   = g_sfb.sfb01
           LET g_ina.ina11   = g_user
           LET g_ina.ina08   = '0'              #No.MOD-760148 add
           LET g_ina.ina11   = g_user
           LET g_ina.inaprsw = 0
           LET g_ina.inapost = 'N'
           LET g_ina.inaconf = 'N'              #MOD-920188 add
           LET g_ina.inauser = g_user
           LET g_ina.inagrup = g_grup
           LET g_ina.inamodu = ''
           LET g_ina.inadate = g_today
           LET g_ina.inamksg = g_smy.smyapr     #No.MOD-760148 add
           LET g_ina.inaplant = g_plant #FUN-980008 add
           LET g_ina.inalegal = g_legal #FUN-980008 add
           LET g_ina.ina12 = 'N'        #FUN-870100 ADD
           LET g_ina.inapos = 'N'       #FUN-870100 ADD

           CALL s_auto_assign_no("aim",tm.ship,g_ina.ina03,'1',"ina_file","ina01","","","")
               RETURNING li_result,g_ina.ina01

           LET g_ina.inaoriu = g_user      #No.FUN-980030 10/01/04
           LET g_ina.inaorig = g_grup      #No.FUN-980030 10/01/04
           INSERT INTO ina_file VALUES(g_ina.*)

           IF SQLCA.sqlcode THEN
              CALL cl_err3("ins","ina_file",g_ina.ina01,"",SQLCA.sqlcode,"","ins ina:",1)  #No.FUN-660128
              ROLLBACK WORK
              RETURN
           END IF


           SELECT sfb98 INTO l_sfb98 FROM sfb_file
                                    WHERE sfb01=g_sfb.sfb01
           IF SQLCA.sqlcode THEN
              LET l_sfb98=NULL
           END IF
           LET l_sno = 0
           LET g_sql =
             "SELECT sfa03,sfa12,sfa05,ima35,ima36",
             " FROM sfa_file LEFT OUTER JOIN ima_file ON sfa03 = ima01",
             " WHERE sfa01 ='",g_sfb.sfb01,"'"
           # foreach 塞資料
           PREPARE i301_pb2 FROM g_sql
           DECLARE sfa_curs2 CURSOR FOR i301_pb2
           FOREACH sfa_curs2 INTO g_inb.inb04,g_inb.inb08,g_inb.inb09,g_inb.inb05,g_inb.inb06
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM ima_file
               WHERE ima01 = g_inb.inb04
                 AND imaacti ='Y'
              IF l_cnt = 0 THEN
                 CONTINUE FOREACH
              END IF

             ##Add No.FUN-AA0050  #Mark No.FUN-AB0054 此处不做判断，交予单据审核时控管
             #IF NOT s_chk_ware(g_inb.inb05) THEN  #检查仓库是否属于当前门店
             #   LET g_inb.inb05 = ' '
             #END IF
             ##End Add No.FUN-AA0050
               LET l_sno = l_sno + 1
               IF NOT cl_null(tm.stk) THEN
                  LET g_inb.inb05=tm.stk
               END IF
               IF NOT cl_null(tm.loc) THEN
                  LET g_inb.inb06 = tm.loc
               ELSE LET g_inb.inb06 = ' '  #TQC-670017 add
               END IF


               LET g_inb.inb01  = g_ina.ina01
               LET g_inb.inb03 = l_sno
               LET g_inb.inb07  = ' ' #TQC-670017 add
               #抓異動單位
                LET l_unit1 = NULL      #No:MOD-9A0017 add
                SELECT img09 INTO l_unit1 FROM img_file
                  WHERE img01 = g_inb.inb04 AND img02 = g_inb.inb05
                    AND img03 = g_inb.inb06 AND img04 = g_inb.inb07

               #異動(inb08)/庫存單位(img09)
               CALL  s_umfchk(g_inb.inb04,g_inb.inb08,l_unit1)
                         RETURNING l_cnt,g_inb.inb08_fac
               IF l_cnt = 1 THEN
                   CALL cl_err('','mfg3075',0)
                   LET g_inb.inb08_fac = 0
               END IF

               # LET g_inb.inb10  = '' #TQC-BC0120  mark
               #TQC-BC0120  begin
               SELECT ima24 INTO l_ima24 FROM ima_file
                WHERE ima01 = g_inb.inb04
               LET g_inb.inb10 = l_ima24
               #TQC-BC0120  end
               LET g_inb.inb11  = ''
               LET g_inb.inb12  = ''
               LET g_inb.inb13  = 0
    #FUN-AB0089--add--begin
               LET g_inb.inb132 = 0
               LET g_inb.inb133 = 0
               LET g_inb.inb134 = 0
               LET g_inb.inb135 = 0
               LET g_inb.inb136 = 0
               LET g_inb.inb137 = 0
               LET g_inb.inb138 = 0
    #FUN-AB0089--add--end
               LET g_inb.inb14  = 0
               LET g_inb.inb15  = tm.reas
               LET g_inb.inb901 = ''
               LET g_inb.inb902 = g_inb.inb08
               LET g_inb.inb903 = g_inb.inb08_fac
               LET g_inb.inb904 = g_inb.inb09
               LET g_inb.inb905 = ''
               LET g_inb.inb906 = ''
               LET g_inb.inb907 = ''
               LET g_inb.inb930 = l_sfb98 #FUN-670103
               LET g_inb.inb41 = g_sfb.sfb27   #專案
               LET g_inb.inb42 = g_sfb.sfb271  #WBS
               LET g_inb.inb43 = g_sfb.sfb50   #活動
               LET g_inb.inb16 = g_inb.inb09  #No.FUN-870163

              LET g_inb.inbplant = g_plant #FUN-980008 add
              LET g_inb.inblegal = g_legal #FUN-980008 add

              #判斷是否做專案庫存及批序號管理
              #IF 有專案庫存但無批序號管理，則要insert到rvbs_file
               IF s_chk_rvbs(g_inb.inb41,g_inb.inb04) THEN
                 LET g_success = 'Y'
                 #              出庫  作業代號   單號        單身序號     數量(換算成庫存數量)      專案代號
                 LET l_rvbs.rvbs00 = "aimt301"
                 LET l_rvbs.rvbs01 = g_ina.ina01
                 LET l_rvbs.rvbs02 = g_inb.inb03
                 LET l_rvbs.rvbs021= g_inb.inb04
                 LET l_rvbs.rvbs06 =g_inb.inb09*g_inb.inb08_fac
                 LET l_rvbs.rvbs08 = g_inb.inb41
                 LET l_rvbs.rvbs09 = -1   #出庫
                 CALL s_ins_rvbs("1",l_rvbs.*)
                 IF g_success = 'N' THEN
                   LET l_err = 'N'
                   EXIT FOREACH
                 END IF
               END IF
              #FUN-CB0087-xj---add---str
               IF g_aza.aza115 = 'Y' THEN
                 CALL s_reason_code(g_ina.ina01,g_ina.ina10,'',g_inb.inb04,g_inb.inb05,g_ina.ina04,g_ina.ina11) RETURNING g_inb.inb15
                 IF cl_null(g_inb.inb15) THEN
                    CALL cl_err('','aim-425',1)
                    EXIT FOREACH
                 END IF
               END IF
              #FUN-CB0087-xj---add---end
               INSERT INTO inb_file VALUES(g_inb.*)

               IF SQLCA.sqlcode THEN
                  LET l_err = SQLCA.sqlcode
                  CALL cl_err3("ins","inb_file",g_inb.inb01,g_inb.inb03,l_err,"","ins inb:",1)  #No.FUN-660128
                  EXIT FOREACH
               END IF
           END FOREACH
           CLOSE WINDOW i301_m_w


           IF cl_null(l_err) THEN
        COMMIT WORK
              LET l_cmd = "aimt301 '", g_ina.ina01 CLIPPED ,"'"
              CALL cl_cmdrun_wait(l_cmd)  #FUN-660216 add
           ELSE
              ROLLBACK WORK
           END IF

        END IF
     END IF
  END IF
END FUNCTION

#FUN-630087 add 維護雜發單
FUNCTION i301_m_iss()
  DEFINE l_ina01  LIKE ina_file.ina01
  DEFINE l_cmd        LIKE type_file.chr1000 #No.FUN-680121 VARCHAR(100)

  SELECT ina01 INTO l_ina01 FROM ina_file
   WHERE ina10 = g_sfb.sfb01

  IF SQLCA.sqlcode THEN
     IF SQLCA.sqlerrd[3]=0 THEN
        CALL cl_err3("sel","ina_file",g_sfb.sfb01,"","asf-509","","",1)  #No.FUN-660128  #TQC-BC0071 change
        RETURN
     ELSE
     RETURN
     END IF
  END IF

  IF NOT cl_null(l_ina01) THEN
     LET l_cmd = "aimt301 '", l_ina01 CLIPPED ,"'"
     CALL cl_cmdrun_wait(l_cmd)  #FUN-660216 add
  ELSE
     CALL cl_err('','asf-020',1)
  END IF
END FUNCTION

FUNCTION i301_sfb1001()
   DEFINE l_bxa06      LIKE bxa_file.bxa06,  #起始日期
          l_bxa07      LIKE bxa_file.bxa07,  #截止日期
          l_bxa08      LIKE bxa_file.bxa08,  #核準加工數量
          l_bxa09      LIKE bxa_file.bxa09,  #已核銷數量
          l_sum           LIKE bxa_file.bxa08   #可核准數量bxa08-bxa09

   LET g_errno = ''
   SELECT bxa06,bxa07,bxa08,bxa09
     INTO l_bxa06,l_bxa07,l_bxa08,l_bxa09
     FROM bxa_file
    WHERE bxa01 = g_sfb.sfb1001
      AND bxa02 = g_sfb.sfb05      #FUN-C60004 add
      AND bxaacti = 'Y'
   IF SQLCA.SQLCODE THEN
      LET g_errno = 'abx-051'
      RETURN
   END IF
   IF g_sfb.sfb02 MATCHES '[78]' THEN
      IF l_bxa08 IS NULL THEN LET l_bxa08 = 0 END IF
      IF l_bxa09 IS NULL THEN LET l_bxa09 = 0 END IF
      LET l_sum = l_bxa08 - l_bxa09
      IF g_sfb.sfb08 > l_sum OR
         (g_sfb.sfb81 < l_bxa06 OR g_sfb.sfb81 > l_bxa07) THEN
         LET g_errno = 'abx-052'
         RETURN
      END IF
   END IF
END FUNCTION
FUNCTION i300_time(p_cmd)

DEFINE p_cmd      LIKE type_file.chr1  #'1'代表推算預計完工日
                                       #'2'代表推算預計開工日
DEFINE l_ima59    LIKE ima_file.ima59
DEFINE l_ima60    LIKE ima_file.ima60
DEFINE l_ima601   LIKE ima_file.ima601  #No.FUN-840194
DEFINE l_ima61    LIKE ima_file.ima61
DEFINE l_time     LIKE sfb_file.sfb13
DEFINE li_result  LIKE type_file.num5  #CHI-690066 add SMALLINT
DEFINE l_day      LIKE type_file.num5  #MOD-7A0181
DEFINE i          LIKE type_file.num5  #NO.MOD-7A0181
DEFINE l_ima56    LIKE ima_file.ima56  #FUN-710073 add

   IF cl_null(g_sfb.sfb05) OR cl_null(g_sfb.sfb08)
      OR cl_null(g_sfb.sfb13) THEN
      RETURN
   END IF

   SELECT ima59,ima60,ima601,ima61,ima56 INTO l_ima59,l_ima60,l_ima601,l_ima61,l_ima56  #No.FUN-840194 add ima601
      FROM ima_file WHERE ima01=g_sfb.sfb05

   IF p_cmd = '1' THEN
      LET l_time = g_sfb.sfb13
       LET l_day = (l_ima59+l_ima60/l_ima601*g_sfb.sfb08+l_ima61)   #No.FUN-840194 #CHI-810015 mark還原
      WHILE TRUE
         LET li_result = 0
         CALL s_daywk(l_time) RETURNING li_result
         CASE
           WHEN li_result = 0  #0:非工作日
             LET l_time = l_time + 1
             CONTINUE WHILE
           WHEN li_result = 1  #1:工作日
             EXIT WHILE
           WHEN li_result = 2  #2:無設定
             CALL cl_err(l_time,'mfg3153',0)
             EXIT WHILE
           OTHERWISE EXIT WHILE
         END CASE
      END WHILE
      LET g_sfb.sfb15 = l_time
      CALL s_aday(g_sfb.sfb15,1,l_day) RETURNING g_sfb.sfb15   #no.MOD-7A0181 add
      RETURN
   ELSE
      LET l_time = g_sfb.sfb15
       LET l_day = (l_ima59+l_ima60/l_ima601*g_sfb.sfb08+l_ima61)  #No.FUN-840194 #CHI-810015 mark還原

      WHILE TRUE
         LET li_result = 0
         CALL s_daywk(l_time) RETURNING li_result
         CASE
           WHEN li_result = 0  #0:非工作日
            #LET l_time = l_time + 1    #TQC-C80129 mark
             LET l_time = l_time - 1    #TQC-C80129 add
             CONTINUE WHILE
           WHEN li_result = 1  #1:工作日
             EXIT WHILE
           WHEN li_result = 2  #2:無設定
             CALL cl_err(l_time,'mfg3153',0)
             EXIT WHILE
           OTHERWISE EXIT WHILE
         END CASE
      END WHILE
      LET g_sfb.sfb13 = l_time
      CALL s_aday(g_sfb.sfb13,-1,l_day) RETURNING g_sfb.sfb13   #no.MOD-7A0181 add
      RETURN
   END IF

END FUNCTION

FUNCTION i301_pic()
   CASE g_sfb.sfb87
        WHEN 'Y'   LET g_confirm = 'Y'
                   LET g_void = ''
        WHEN 'N'   LET g_confirm = 'N'
                   LET g_void = ''
        WHEN 'X'   LET g_confirm = ''
                   LET g_void = 'Y'
     OTHERWISE     LET g_confirm = ''
                   LET g_void = ''
   END CASE
    IF g_sfb.sfb04='8' THEN   #MOD-480095
      LET g_close = 'Y'
   ELSE
      LET g_close = 'N'
   END IF
   IF g_sfb.sfb43 = '1' THEN
      LET g_approve = "Y"
   ELSE
      LET g_approve = "N"
   END IF
   #圖形顯示
   CALL cl_set_field_pic(g_confirm,g_approve,"",g_close,g_void,g_sfb.sfbacti)
END FUNCTION

FUNCTION i301_aps()
   DEFINE  l_chr4      LIKE type_file.chr4
   DEFINE  l_cmd       LIKE type_file.chr1000
   DEFINE  l_vmw       RECORD LIKE vmw_file.*  #FUN-7C0002

         IF cl_null(g_sfb.sfb01) THEN
            CALL cl_err('',-400,1)
            RETURN #TQC-750013 add
         END IF
         #FUN-C30017 add---str---
         IF g_sfb.sfb43 MATCHES '[Ss]' THEN
             CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
             RETURN
         END IF
         #FUN-C30017 add---end---

         SELECT vmw01 FROM vmw_file
          WHERE vmw01 = g_sfb.sfb01
         IF SQLCA.SQLCODE=100 THEN
             LET l_vmw.vmw01 = g_sfb.sfb01
             LET l_vmw.vmw02 = NULL
             LET l_vmw.vmw25 = 0   #FUN-910005 ADD
             LET l_vmw.vmw26 = 0   #FUN-930127 ADD
             LET l_vmw.vmwlegal = g_legal #FUN-B50046 add
             LET l_vmw.vmwplant = g_plant #FUN-B50046 add
             INSERT INTO vmw_file VALUES(l_vmw.*)
                IF STATUS THEN
                   CALL cl_err3("ins","vmw_file",l_vmw.vmw01,"",SQLCA.sqlcode,
                                "","",1)
                END IF
         END IF
         LET l_cmd = "apsi316 '",g_sfb.sfb01,"'"
         CALL cl_cmdrun(l_cmd)
END FUNCTION

FUNCTION i301_aps_routesubc()
   DEFINE  l_chr4      LIKE type_file.chr4
   DEFINE  l_cmd LIKE type_file.chr1000
   DEFINE  l_vnf RECORD LIKE vnf_file.*

   IF cl_null(g_sfb.sfb01) THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF
   #FUN-C30017 add---str---
   IF g_sfb.sfb43 MATCHES '[Ss]' THEN
       CALL cl_err('','mfg3557',0) #本單據目前已送簽或已核准
       RETURN
   END IF
   #FUN-C30017 add---end---
   SELECT vnf01 FROM vnf_file
      WHERE vnf01 = g_sfb.sfb01
   IF SQLCA.SQLCODE=100 THEN
      LET l_vnf.vnf01 = g_sfb.sfb01
     #FUN-960025 MOD --STR-------------------
     #LET l_vnf.vnf03 = 1   #FUN-870012
      IF g_sfb.sfb41='Y' THEN
         LET l_vnf.vnf03 = '2'
      ELSE
         LET l_vnf.vnf03 = '1'
      END IF
     #FUN-960025 MOD --END-------------------
      LET l_vnf.vnf07 = 0   #FUN-870012
      LET l_vnf.vnflegal = g_legal #FUN-B50046 add
      LET l_vnf.vnfplant = g_plant #FUN-B50046 add
      INSERT INTO vnf_file VALUES(l_vnf.*)
      IF STATUS THEN
         CALL cl_err3("ins","vnf_file",l_vnf.vnf01,"",SQLCA.sqlcode,
                      "","",1)
      END IF
   END IF
   LET l_cmd = "apsi323 '",g_sfb.sfb01,"'"
   CALL cl_cmdrun(l_cmd)
END FUNCTION


FUNCTION i301_proj()
  DEFINE l_pja02  LIKE pja_file.pja02,
         l_pjb03  LIKE pjb_file.pjb03,
         l_pjk03  LIKE pjk_file.pjk03,
         l_azf03  LIKE azf_file.azf03

  IF NOT cl_null(g_sfb.sfb27) THEN
    SELECT pja02 INTO l_pja02 FROM pja_file
     WHERE pja01 = g_sfb.sfb27
    DISPLAY l_pja02 TO FORMONLY.pja02
  END IF

  IF NOT cl_null(g_sfb.sfb271) THEN
    SELECT pjb03 INTO l_pjb03 FROM pjb_file
     WHERE pjb02 = g_sfb.sfb271
    DISPLAY l_pjb03 TO FORMONLY.pjb03
  END IF

  IF NOT cl_null(g_sfb.sfb50) THEN
    SELECT pjk03 INTO l_pjk03 FROM pjk_file,pjj_file
     WHERE pjk01 = pjk01
       AND pjk02 = g_sfb.sfb50
       AND pjj04 = g_sfb.sfb27
    DISPLAY l_pjk03 TO FORMONLY.pjk03
  END IF

  IF NOT cl_null(g_sfb.sfb51) THEN
    SELECT azf03 INTO l_azf03 FROM azf_file
     WHERE azf01 = g_sfb.sfb51
       AND azf02 = '2'
    DISPLAY l_azf03 TO FORMONLY.azf03
  END IF
END FUNCTION

FUNCTION i301_carry_proj()
  IF cl_null(g_sfb.sfb22) OR cl_null(g_sfb.sfb221) THEN RETURN END IF


  SELECT oeb41,oeb42,oeb43,oeb1001
    INTO g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51
    FROM oeb_file
   WHERE oeb01 = g_sfb.sfb22
     AND oeb02 = g_sfb.sfb221
  DISPLAY BY NAME g_sfb.sfb27,g_sfb.sfb271,g_sfb.sfb50,g_sfb.sfb51

  CALL i301_proj()
END FUNCTION


FUNCTION i301_ui_default()
   # add by lixwz 20170928 s
   IF g_plant = 'SJLTEST' THEN
      CALL cl_set_act_visible("get_bom", TRUE)
   ELSE
      CALL cl_set_act_visible("get_bom", FALSE)
   END IF
   # add by lixwz 20170928 e
       CALL cl_set_comp_visible("sfaislk01",FALSE)

    IF g_aaz.aaz90='Y' THEN
       CALL cl_set_comp_required("sfb98",TRUE)
    END IF
   CALL cl_set_comp_visible("sfb1001,sfb1002,sfb1003",g_sma.sma79='Y') #FUN-6A0007

   IF g_sma.sma118 = "N" THEN
      CALL cl_set_comp_visible("sfb95",FALSE)
   END IF

   CALL cl_set_comp_visible("sfb27,sfb271,sfb50,sfb51,pja02,pjb03,pjk03,azf03",g_aza.aza08= 'Y') #FUN-810045 add

    #FUN-A50066--begin--add------
   IF g_sma.sma541 = 'N' THEN
      CALL cl_set_comp_visible("sfa012,sfa013,ecu014",FALSE)
   END IF
   #FUN-A50066--end--add------
   CALL cl_set_comp_visible("sfaiicd06",FALSE)  #FUN-C30274
   #FUN-A80102(S)
   IF g_sma.sma1421='Y' THEN
      CALL cl_set_comp_visible("sfb919",TRUE)
   ELSE
      CALL cl_set_comp_visible("sfb919",FALSE)
   END IF
   #FUN-A80102(E)

   #FUN-9A0029----add----str----
   #不串APS時,欄位隱藏
   IF cl_null(g_sma.sma901) OR g_sma.sma901 = 'N' THEN
       #sfb14預計起始生產時間
       #sfb16預計結束生產時間
       CALL cl_set_comp_visible("sfb14,sfb16",FALSE)
   ELSE
       CALL cl_set_comp_visible("sfb14,sfb16",TRUE)
   END IF
   #FUN-9A0029----add----end----
   CALL cl_set_comp_visible("Wafer", FALSE)   #FUN-C30210
   CALL cl_set_comp_entry("sfb99",FALSE)   #FUN-C80023
END FUNCTION

FUNCTION i301_ef()

    CALL i301sub_firm1_chk(g_sfb.sfb01,FALSE)  #FUN-940008 add false
    IF g_success = "N" THEN
       RETURN
    END IF

    CALL aws_condition()        #判斷送簽資料
    IF g_success = 'N' THEN
       RETURN
    END IF

##########
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########
    IF aws_efcli2(base.TypeInfo.create(g_sfb),base.TypeInfo.create(g_sfa),'','','','')
    THEN
      LET g_success = 'Y'
      LET g_sfb.sfb43 = 'S'
      DISPLAY BY NAME g_sfb.sfb43
    ELSE
      LET g_success = 'N'
    END IF

END FUNCTION


FUNCTION i301_sfb01(p_cmd)
   DEFINE p_cmd     LIKE type_file.chr1
   DEFINE l_slip    LIKE smy_file.smyslip
   DEFINE l_smy73   LIKE smy_file.smy73    #FUN-9B0144

   LET g_errno = ' '
   IF cl_null(g_sfb.sfb01) THEN RETURN END IF
   LET l_slip = s_get_doc_no(g_sfb.sfb01)

   SELECT smy73 INTO l_smy73 FROM smy_file
    WHERE smyslip = l_slip
   IF l_smy73 = 'Y' THEN
      LET g_errno = 'asf-875'
   END IF

END FUNCTION

FUNCTION i301_b_dealc(p_sfa27)
   DEFINE l_minopseq    LIKE type_file.num5
   DEFINE l_cnt         LIKE type_file.num5
   DEFINE l_sfb86_cnt   LIKE type_file.num5
   DEFINE l_sfa_n       LIKE type_file.num5
   DEFINE l_sfb01       LIKE sfb_file.sfb01
   DEFINE l_sfb87       LIKE sfb_file.sfb87
   DEFINE p_sfa27       LIKE sfa_file.sfa27
   DEFINE l_sql         STRING                       #MOD-C40045 add
   DEFINE l_string      STRING                       #MOD-C40045 add
   DEFINE l_bmb03       LIKE bmb_file.bmb03          #MOD-C40045 add

   IF g_sfb.sfb04 = '8'   THEN CALL cl_err('','aap-730',0) RETURN END IF

   IF g_sfb.sfb87='Y'     THEN CALL cl_err('','aap-086',1) RETURN END IF

   IF g_sfb.sfb87 = 'X' OR g_sfb.sfb43 = '9' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
   IF g_sfb.sfb43 MATCHES '[Ss1]' THEN
      CALL cl_err('','mfg3557',0)
      RETURN
   END IF

   SELECT COUNT(*) INTO g_cnt FROM sfa_file
    WHERE sfa01=g_sfb.sfb01
      AND (sfa06<>0 OR sfa062<>0 OR sfa063<>0 OR sfa064<>0)

   IF g_cnt>0 THEN CALL cl_err('','asf-413',0) RETURN END IF

   #CHECK是否有未確認的子工單
   LET l_sfb86_cnt = 0
   SELECT COUNT(*) INTO l_sfb86_cnt FROM sfb_file
    WHERE sfb05 = p_sfa27
      AND sfb86 = g_sfb.sfb01    #MOD-C40012 add
   IF cl_null(l_sfb86_cnt) THEN
      LET l_sfb86_cnt =  0
   END IF

   BEGIN WORK

   LET g_success = 'Y'

  #表示有尚未確認的子工單需要一起清除
   IF l_sfb86_cnt > 0 THEN
     #MOD-C40045 str add-----
     #DECLARE i301_b_dealc_cs CURSOR FOR
     # SELECT sfb01,sfb87 FROM sfb_file WHERE sfb86 = g_sfb.sfb01
     #    AND ( sfb86 IS NOT NULL AND sfb86 != ' ')
      DROP TABLE i301_tmp_bom
      CREATE TEMP TABLE i301_tmp_bom(
                  tmp_bmb03 LIKE bmb_file.bmb03,
                  tmp_level LIKE type_file.num5)
      IF SQLCA.SQLCODE THEN
        CALL cl_err('cretmp',SQLCA.SQLCODE,1)
        CALL cl_used(g_prog,g_time,2) RETURNING g_time
        EXIT PROGRAM
      END IF
      INSERT INTO i301_tmp_bom VALUES(p_sfa27,'0')
      IF SQLCA.sqlcode THEN
         CALL cl_err3("ins","tmp_bom",p_sfa27,"",SQLCA.sqlcode,"","ins tmp_bom",1)  #No.FUN-660128

      END IF
      CALL i301_bom(0)
      LET l_string = NULL

      DECLARE i301_list CURSOR FOR
       SELECT tmp_bmb03 FROM i301_tmp_bom

      FOREACH i301_list INTO l_bmb03
        IF cl_null(l_string) THEN
          LET l_string = "'",l_bmb03,"'"
        ELSE
          LET l_string =l_string,",'",l_bmb03,"'"
        END IF
      END FOREACH
      LET l_sql= " SELECT sfb01,sfb87 FROM sfb_file ",
                 "  WHERE sfb86 ='",g_sfb.sfb01,"'",
                 "   AND ( sfb86 IS NOT NULL AND sfb86 != ' ')",
                 "   AND  sfb05 IN(",l_string,")"
      PREPARE i301_b_dealc_p FROM l_sql
      DECLARE i301_b_dealc_cs SCROLL CURSOR WITH HOLD FOR i301_b_dealc_p
     #MOD-C40045 end add-----

      FOREACH i301_b_dealc_cs INTO l_sfb01,l_sfb87
        IF SQLCA.sqlcode THEN
           CALL cl_err('',SQLCA.sqlcode,0)
           LET g_success = 'N'
           EXIT FOREACH
        END IF
        IF l_sfb87='Y' THEN
           CALL cl_err('','asf-102',1)
           LET g_success = 'N'
           RETURN
        ELSE
           MESSAGE "Delete sub WO !"
           DELETE FROM sfb_file WHERE sfb01 = l_sfb01
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","sfb_file",l_sfb01,"",SQLCA.sqlcode,"","No sfb deleted_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF

           DELETE FROM sfa_file WHERE sfa01 = l_sfb01
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","sfa_file",l_sfb01,"",SQLCA.sqlcode,"","del sfa_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF
           DELETE FROM tc_sfa_file WHERE tc_sfa01 = l_sfb01
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","tc_sfa_file",l_sfb01,"",SQLCA.sqlcode,"","del tc_sfa_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF

           DELETE FROM ecm_file WHERE ecm01 = l_sfb01
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","ecm_file",l_sfb01,"",STATUS,"","del ecm_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           #TQC-940179 ADD --STR----------------------
           ELSE
             IF g_sma.sma901='Y' THEN
                DELETE FROM vmn_file
                 WHERE vmn02 = l_sfb01
                DELETE FROM vnm_file
                 WHERE vnm01 = l_sfb01
             END IF
           #TQC-940179 ADD --END----------------------
           END IF

           DELETE FROM sfd_file WHERE sfd03 = l_sfb01
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","sfd_file",l_sfb01,"",STATUS,"","del sfd_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF

          #DELETE FROM she_file WHERE she01 = g_sfb.sfb01   #MOD-C30754 mark
           DELETE FROM she_file WHERE she01 = l_sfb01       #MOD-C30754 add
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","she_file",g_sfb.sfb01,"",STATUS,"","del she_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF

          #DELETE FROM sfw_file WHERE sfw01 = g_sfb.sfb01   #MOD-C30754 mark
           DELETE FROM sfw_file WHERE sfw01 = l_sfb01       #MOD-C30754 add
           IF SQLCA.sqlcode THEN
              CALL cl_err3("del","sfw_file",g_sfb.sfb01,"",STATUS,"","del sfw_sub",1)  #No.FUN-660128
              LET g_success = 'N'
           END IF
        END IF
      END FOREACH
   END IF
   SELECT COUNT(*) INTO l_sfa_n FROM sfa_file
    WHERE sfa01 = g_sfb.sfb01

   DELETE FROM sfa_file
    WHERE sfa01 = g_sfb.sfb01
      AND sfa03 = g_sfa_t.sfa03  #TQC-B70202  add
      AND sfa08 = g_sfa_t.sfa08 AND sfa12 = g_sfa_t.sfa12
      AND sfa27 = p_sfa27
      AND sfa012 = g_sfa_t.sfa012  #FUN-A50066
      AND sfa013 = g_sfa_t.sfa013  #FUN-A50066
   IF STATUS THEN
      CALL cl_err3("del","sfa_file",g_sfb.sfb01,"",STATUS,"","del sfa:",1)  #No.FUN-660128
      LET g_success = 'N'
#TQC-B70202 mark
##MOD-B70051--begin--
#   ELSE
#   	  CALL i301_b_fill(' 1=1')
##MOD-B70051--end--
#TQC-B70202 mark--end
   END IF
   DELETE FROM tc_sfa_file
    WHERE tc_sfa01 = g_sfb.sfb01
      AND tc_sfa02 = g_sfa_t.sfa03  #TQC-B70202  add
      AND tc_sfa03 = g_sfa_t.sfa08
   IF STATUS THEN
      CALL cl_err3("del","tc_sfa_file",g_sfb.sfb01,g_sfa_t.sfa03,STATUS,"","del tc_sfa:",1)  #No.FUN-660128
      LET g_success = 'N'
   END IF

   IF l_sfa_n = 1 THEN
      UPDATE sfb_file SET sfb23='N'
       WHERE sfb01=g_sfb.sfb01
      IF STATUS THEN
         CALL cl_err3("upd","sfb_file",g_sfb_t.sfb01,"",STATUS,"","upd sfb:",1)  #No.FUN-660128
         LET g_success = 'N'
      END IF
      IF g_success = 'N' THEN
         ROLLBACK WORK
      ELSE
         COMMIT WORK
         LET g_sfb.sfb23='N'
         DISPLAY BY NAME g_sfb.sfb23
         CALL i301_b_fill(' 1=1')
      END IF
   END IF

END FUNCTION

#TQC-A10124 -- add i301_mes() for MES------------
FUNCTION i301_mes(p_key1,p_key2)
  DEFINE p_key1   LIKE type_file.chr6
  DEFINE p_key2   LIKE type_file.chr500
  DEFINE l_mesg01 LIKE type_file.chr30

  CASE p_key1
    WHEN 'insert'  #新增
         LET l_mesg01 = 'INSERT O.K, INSERT MES O.K'
    WHEN 'update'  #修改
         LET l_mesg01 = 'UPDATE O.K, UPDATE MES O.K'
    WHEN 'delete'  #刪除
         LET l_mesg01 = 'DELETE O.K, DELETE MES O.K'
    OTHERWISE
  END CASE

 # CALL aws_mescli
 # 傳入參數: (1)程式代號
 #           (2)功能選項：insert(新增),update(修改),delete(刪除)
 #           (3)Key
  CASE aws_mescli('asfi301',p_key1,p_key2)
    WHEN 1  #呼叫 MES 成功
         MESSAGE l_mesg01
         LET g_success = 'Y'
    WHEN 2  #呼叫 MES 失敗
         LET g_success = 'N'
    OTHERWISE  #其他異常
         LET g_success = 'N'
  END CASE

END FUNCTION
#TQC-A10124 add end ------------------------

#FUN-A50066--begin--add----------------------
#FUN-B10056 -----------mark start---------
#FUNCTION i301_sfa012()
#DEFINE
#    p_cmd           LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(1)
#    l_ecuacti       LIKE ecu_file.ecuacti
#DEFINE l_flag   LIKE type_file.num5   #MOD-AC0336
#DEFINE l_ima571 LIKE ima_file.ima571  #MOD-AC0336
#
#   CALL s_schdat_sel_ima571(g_sfb.sfb01) RETURNING l_flag,l_ima571  #MOD-AC0336
#   LET g_errno = ''
#   SELECT ecu014,ecuacti  INTO g_sfa[l_ac].ecu014,l_ecuacti FROM ecu_file
#    WHERE ecu012 = g_sfa[l_ac].sfa012
#      AND ecu01 = l_ima571   #MOD-AC0336
#      AND ecu02 = g_sfb.sfb06
#
#   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'abm-214'
#                                  LET g_sfa[l_ac].ecu014 = NULL
#                                  LET l_ecuacti = NULL
#        WHEN l_ecuacti='N'        LET g_errno = '9028'
#        OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
#   END CASE
#
#END FUNCTION
#FUN-B10056 -----------mark end----------

FUNCTION i301_sel_sfa08()

  IF NOT cl_null(g_sfa[l_ac].sfa08) THEN RETURN END IF
  IF NOT cl_null(g_sfa[l_ac].sfa012) AND NOT cl_null(g_sfa[l_ac].sfa013) THEN
     SELECT brb09 INTO g_sfa[l_ac].sfa08 FROM brb_file
      WHERE brb01 = g_sfb.sfb05
        AND brb011= g_sfb.sfb06
        AND brb012= g_sfa[l_ac].sfa012
        AND brb013= g_sfa[l_ac].sfa013
     IF g_sfa[l_ac].sfa08 IS NULL THEN LET g_sfa[l_ac].sfa08=' ' END IF
  END IF
END FUNCTION
#FUN-A50066--end--add--------------------------

#FUN-A80054--begin--add------------------
FUNCTION i301_r()
    CALL i301sub_r(g_sfb.sfb01,FALSE,'Y')
    IF g_success = 'Y' THEN
       CLEAR FORM
       CALL g_sfa.clear()
       CALL g_sfa29.clear()
       INITIALIZE g_sfb.* TO NULL
       MESSAGE ""
       OPEN i301_count
       #FUN-B50064-add-start--
       IF STATUS THEN
          CLOSE i301_cs
          CLOSE i301_count
          COMMIT WORK
          RETURN
       END IF
       #FUN-B50064-add-end--
       FETCH i301_count INTO g_row_count
       #FUN-B50064-add-start--
       IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
          CLOSE i301_cs
          CLOSE i301_count
          COMMIT WORK
          RETURN
       END IF
       #FUN-B50064-add-end--
       DISPLAY g_row_count TO FORMONLY.cnt
       OPEN i301_cs
       IF g_curs_index = g_row_count + 1 THEN
          LET g_jump = g_row_count
          CALL i301_fetch('L')
       ELSE
          LET g_jump = g_curs_index
          LET g_no_ask = TRUE
          CALL i301_fetch('/')
       END IF
    END IF
END FUNCTION
#FUN-A80054--end--add------------------------

#FUN-A80054--begin--add---------------
FUNCTION i301_ins_sfd(p_sfd08)
DEFINE p_sfd08   LIKE sfd_file.sfd08
DEFINE l_cnt     LIKE type_file.num5
DEFINE l_sfd     RECORD LIKE sfd_file.*

 LET l_cnt=0
 SELECT count(*) INTO l_cnt FROM sfd_file
  WHERE sfd01=g_sfb.sfb85
    AND sfd03=g_sfb.sfb01
 IF l_cnt = 0 THEN
    LET l_sfd.sfd01=g_sfb.sfb85
    SELECT MAX(sfd02)+1 INTO l_sfd.sfd02 FROM sfd_file WHERE sfd01=g_sfb.sfb85
    IF cl_null(l_sfd.sfd02) THEN LET l_sfd.sfd02=1 END IF
    LET l_sfd.sfd03=g_sfb.sfb01
    LET l_sfd.sfd08=p_sfd08
    LET l_sfd.sfdconf='N'
    LET l_sfd.sfd09 = '2'  #CHI-C60023
    LET  l_sfd.sfduser = g_user        #FUN-D10127
    LET  l_sfd.sfdgrup = g_grup        #FUN-D10127
    LET  l_sfd.sfddate = g_today       #FUN-D10127
    LET  l_sfd.sfdacti ='Y'            #FUN-D10127
    LET  l_sfd.sfdoriu = g_user        #FUN-D10127
    LET  l_sfd.sfdorig = g_grup        #FUN-D10127
    DECLARE edb_cs CURSOR FOR
       SELECT edb02,edb05,edb07 FROM edb_file
        WHERE edb01=p_sfd08 AND edb03=g_sfb.sfb05
          AND edb04=g_sfb.sfb06
    FOREACH edb_cs INTO l_sfd.sfd04,l_sfd.sfd05,l_sfd.sfd07
      EXIT FOREACH
    END FOREACH
    INSERT INTO sfd_file VALUES l_sfd.*
    IF cl_null(l_sfd.sfd07) THEN LET l_sfd.sfd07=' ' END IF
    IF SQLCA.sqlcode THEN CALL cl_err('ins sfd',SQLCA.sqlcode,1) RETURN END IF
    SELECT sum(sfd05) INTO l_sfd.sfd06 FROM sfd_file WHERE sfd01=g_sfb.sfb85
    UPDATE sfd_file SET sfd06=l_sfd.sfd06 WHERE sfd01=g_sfb.sfb85
 END IF
END FUNCTION

FUNCTION i301_ins_sfd_1()
DEFINE l_sfd  RECORD LIKE sfd_file.*

   SELECT COUNT(*) INTO g_cnt FROM sfd_file
     WHERE sfd01=g_sfb.sfb85 AND sfd03=g_sfb.sfb01
   IF g_cnt=0 THEN
      SELECT MAX(sfd02)+1 INTO g_cnt FROM sfd_file
        WHERE sfd01=g_sfb.sfb85
      IF g_cnt=0 OR g_cnt IS NULL THEN LET g_cnt= 1 END IF
      LET l_sfd.sfd01=g_sfb.sfb85
      LET l_sfd.sfd02=g_cnt
      LET l_sfd.sfd03=g_sfb.sfb01
      LET l_sfd.sfdconf='N'     #FUN-A80054
      LET l_sfd.sfd09 = '2'     #CHI-C60023
      LET  l_sfd.sfduser = g_user        #FUN-D10127
      LET  l_sfd.sfdgrup = g_grup        #FUN-D10127
      LET  l_sfd.sfddate = g_today       #FUN-D10127
      LET  l_sfd.sfdacti ='Y'            #FUN-D10127
      LET  l_sfd.sfdoriu = g_user        #FUN-D10127
      LET  l_sfd.sfdorig = g_grup        #FUN-D10127
      IF cl_null(l_sfd.sfd07) THEN LET l_sfd.sfd07=' ' END IF
      INSERT INTO sfd_file VALUES(l_sfd.*)
   END IF
END FUNCTION

FUNCTION i301_del_edg()
DEFINE l_sfd01   LIKE sfd_file.sfd01
DEFINE l_sfd02   LIKE sfd_file.sfd02

   DECLARE sfd_cs1 CURSOR FOR
       SELECT sfd01,sfd02 FROM sfd_file WHERE sfd03=g_sfb.sfb01
   FOREACH sfd_cs1 INTO l_sfd01,l_sfd02
       DELETE FROM edg_file WHERE edg01=l_sfd01 AND edg02=l_sfd02
       DELETE FROM edh_file WHERE edh01=l_sfd01 AND edh011=l_sfd02
   END FOREACH
END FUNCTION
#FUN-A80054--end--add-----------------
#No.FUN-9C0072 精簡程式碼
#MOD-B10225---add---start---
FUNCTION i301_cre_tmp()
    CREATE TEMP TABLE i301_tmp(
                bmd04   LIKE bmd_file.bmd04,
                ima02   LIKE ima_file.ima02,
                ima021  LIKE ima_file.ima021,
                bmd07   LIKE bmd_file.bmd07,
                l_yes   LIKE type_file.chr1,
                l_qty   LIKE type_file.num5,
                l_qty3  LIKE type_file.num5,
                ima262  LIKE ima_file.ima262,
                l_qty4  LIKE type_file.num5,
                l_qty5  LIKE type_file.num5,
                l_qty6  LIKE type_file.num5,
                l_qty7  LIKE type_file.num5,
                l_qty8  LIKE type_file.num5,
                bmd03   LIKE bmd_file.bmd03)
END FUNCTION
#MOD-B10225---add---end---

#FUN-B30017--begin--add-----
FUNCTION i301_sfa08()

 SELECT ecm04 INTO g_sfa[l_ac].sfa08 FROM ecm_file
  WHERE ecm01=g_sfb.sfb01
    AND ecm012=g_sfa[l_ac].sfa012
    AND ecm03 = g_sfa[l_ac].sfa013
END FUNCTION
#FUN-B30017--end--add-----
#FUN-9C0119--add--begin
FUNCTION i301_copy()
  DEFINE tm RECORD
         a               LIKE type_file.chr1
         END RECORD
   OPEN WINDOW i301_copy_w  WITH FORM "asf/42f/asfi301_c"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)

  CALL cl_ui_locale("asfi301_c")

   LET tm.a='1'
   DISPLAY BY NAME tm.a

   INPUT BY NAME tm.a WITHOUT DEFAULTS
      AFTER FIELD a
            IF tm.a NOT MATCHES '[123]' THEN   #FUN-A20037
               NEXT FIELD a
            END IF
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW i301_copy_w
      RETURN
   END IF

   CLOSE WINDOW i301_copy_w

   CASE tm.a
        WHEN '1'     CALL i301_copy_1()     #1.複製來源備料資料
        WHEN '2'     CALL i301_copy_2()     #2.依BOM重新產生備料資料
        WHEN '3'     CALL i301_copy_3()     #3.不複製也不產生備料資料
   END CASE

END FUNCTION
FUNCTION i301_copy_1()
   DEFINE old_no,new_no   LIKE sfb_file.sfb01,
          new_date        LIKE type_file.dat
   DEFINE l_sfb           RECORD LIKE sfb_file.*
   DEFINE l_oayapr        LIKE oay_file.oayapr
   DEFINE li_result       LIKE type_file.num5
   DEFINE p_cmd           LIKE type_file.chr1
   DEFINE l_slip          LIKE smy_file.smyslip
   DEFINE l_sfb02         LIKE sfb_file.sfb02
   DEFINE l_sfb13         LIKE sfb_file.sfb13
   DEFINE l_sfb15         LIKE sfb_file.sfb15
   DEFINE l_time          LIKE type_file.num5
   DEFINE l_sfbmksg       LIKE sfb_file.sfbmksg  #MOD-D10118

   LET p_cmd = 'a'
   LET new_no = NULL
   LET new_date=g_today
   LET old_no  = g_sfb.sfb01

   IF g_sfb.sfb01 IS NULL THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF

   BEGIN WORK
   LET g_before_input_done = FALSE
   CALL i301_set_entry('a')
   LET g_before_input_done = TRUE

WHILE TRUE
    CALL cl_set_head_visible("","YES")
    INPUT new_no,new_date FROM sfb01,sfb81
    BEFORE INPUT
    CALL cl_set_docno_format("sfb01")

       AFTER FIELD sfb01
            #FUN-B50026 add
            IF NOT cl_null(new_no) THEN
               CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               RETURNING li_result,new_no
               DISPLAY BY NAME new_no
               IF (NOT li_result) THEN
                 NEXT FIELD sfb01
               END IF
            END IF
            #FUN-B50026 add--end
            IF p_cmd = "a" THEN
              IF NOT cl_null(new_no) THEN
               #FUN-B50026 Mark
               #CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               #RETURNING li_result,new_no
               #DISPLAY BY NAME new_no
               #IF (NOT li_result) THEN
               #  NEXT FIELD sfb01
               #END IF
               #FUN-B50026 Mark--end
                CALL i301_new_no(p_cmd)
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err(new_no,g_errno,0)
                   LET new_no = g_sfb.sfb01
                   DISPLAY BY NAME new_no
                   NEXT FIELD sfb01
                END IF
              END IF
           END IF
      #     CALL i301_set_no_entry(p_cmd)
      #     CALL i301_set_required()

        ON ACTION controlp
           CASE
              WHEN INFIELD(sfb01)
                   LET g_t1 = s_get_doc_no(new_no)
                   LET g_sql = " (smy73 <> 'Y' OR smy73 is null)"
                   CALL smy_qry_set_par_where(g_sql)
                   CALL q_smy( FALSE,TRUE,g_t1,'ASF','1') RETURNING g_t1
                   LET new_no=g_t1
                   DISPLAY new_no TO sfb01
                   NEXT FIELD sfb01
           END CASE

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()


    END INPUT

    IF INT_FLAG THEN
       LET INT_FLAG = 0
       DISPLAY g_sfb.sfb81 TO sfb81
       DISPLAY g_sfb.sfb01 TO sfb01
       RETURN
    END IF
        CALL s_auto_assign_no("asf",new_no,new_date,"1","sfb_file","sfb01","","","")
        RETURNING li_result,new_no
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY new_no TO sfb01
    EXIT WHILE
END WHILE

    IF INT_FLAG THEN
       LET INT_FLAG=0
       ROLLBACK WORK
       RETURN
    END IF

    IF NOT cl_sure(0,0) THEN
       ROLLBACK WORK
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM sfb_file
        WHERE sfb01=old_no
        INTO TEMP x
    LET l_sfb13 = g_today
    LET l_sfb15=l_sfb13+(g_ima.ima59+g_ima.ima60/g_ima.ima601*g_sfb.sfb08+g_ima.ima61)
        SELECT COUNT(*) INTO l_time FROM sme_file
           WHERE sme01 BETWEEN l_sfb13 AND l_sfb15  AND sme02 = 'N'
    LET l_sfb15 =l_sfb15+l_time
    #MOD-D10118---begin
    CALL s_get_doc_no(new_no) RETURNING l_slip
    SELECT smyapr INTO l_sfbmksg
      FROM smy_file
     WHERE smyslip = l_slip
    IF cl_null(l_sfbmksg) THEN LET l_sfbmksg = 'N' END IF
    #MOD-D10118---end
    UPDATE x
        SET sfb01=new_no,     #資料鍵值
            sfb101=NULL,      #MOD-C30887 add
            sfb81=new_date,   #日期
            sfb13=l_sfb13,
            sfb15=l_sfb15,
            sfb44=g_user,
            sfb87='N',
            sfb04='1',
            sfb28=NULL,
            sfb38=NULL,
            sfb43=0,
            sfb22=NULL,
            sfb221=NULL,
            sfb91=NULL,
            sfb92=NULL,
            sfb86=NULL,
            sfb89=NULL, #FUN-C30114
            sfb85=NULL,
            sfb919=NULL,
            sfb25=NULL,
            sfb081=0,sfb09=0,sfb12=0,
            sfb36=NULL,sfb37=NULL,sfb103=NULL,sfb104='N',
            sfb96=NULL,
            sfbuser=g_user,   #資料所有者
            sfbgrup=g_grup,   #資料所有者所屬群
            sfboriu=g_user,
            sfborig=g_grup,
            sfbmodu=NULL,     #資料修改日期
            sfbdate=g_today,   #資料建立日期
            #sfbmksg='N'    #MOD-D10118
            sfbmksg=l_sfbmksg   #MOD-D10118
    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("upd","sfb_file",new_no,"",SQLCA.sqlcode,"","upd sfb:",1)  #No.FUN-650108
       ROLLBACK WORK RETURN
    END IF
    INSERT INTO sfb_file
        SELECT * FROM x
    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("ins","sfb_file",new_no,"",SQLCA.sqlcode,"","ins sfb:",1)  #No.FUN-650108
       ROLLBACK WORK RETURN
    END IF
    DROP TABLE x       #---------------------------------------- copy sfa_file
    SELECT * FROM sfa_file WHERE sfa01=old_no INTO TEMP x
    IF STATUS THEN
       CALL cl_err3("ins","x",old_no,"",STATUS,"","sfa- x:",1)
       ROLLBACK WORK
       RETURN
    END IF

    UPDATE x SET sfa01=new_no,
                 sfa065=0,sfa06=0,sfa062=0,sfa063=0,sfa064=0

    INSERT INTO sfa_file SELECT * FROM x

    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("ins","sfa_file",new_no,"",SQLCA.sqlcode,"","ins sfa:",1)
       ROLLBACK WORK RETURN
    END IF
    #add by lanhang 140107 begin
    DROP TABLE x
    SELECT * FROM tc_sfa_file WHERE tc_sfa01=old_no INTO TEMP x
    IF STATUS THEN
       CALL cl_err3("ins","x",old_no,"",STATUS,"","tc_sfa- x:",1)
       ROLLBACK WORK
       RETURN
    END IF
    UPDATE x SET tc_sfa01=new_no

    INSERT INTO tc_sfa_file SELECT * FROM x

    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("ins","tc_sfa_file",new_no,"",SQLCA.sqlcode,"","ins tc_sfa:",1)
       ROLLBACK WORK RETURN
    END IF
    #add by lanhang 140107 end
    SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=new_no
    IF g_sfb.sfb93='Y' THEN
       DROP TABLE x       #---------------------------------------- copy ecm_file

       SELECT * FROM ecm_file WHERE ecm01=old_no INTO TEMP x
       IF STATUS THEN
          CALL cl_err3("ins","x",old_no,"",STATUS,"","ecm- x:",1)
          ROLLBACK WORK
          RETURN
       END IF

       UPDATE x SET ecm01=new_no,
                    ecm301=0,ecm302=0,ecm303=0,ecm311=0,
                    ecm312=0,ecm316=0,ecm313=0,ecm314=0,
                    ecm315=0,ecm321=0,ecm322=0,ecm292=0
       INSERT INTO ecm_file SELECT * FROM x
       IF STATUS THEN
          CALL cl_err3("ins","ecm_file",new_no,"",STATUS,"","ins ecm:",1)
          ROLLBACK WORK
          RETURN
       END IF
       SELECT COUNT(*) INTO g_cnt FROM sgd_file where sgd00=old_no
       IF g_cnt > 0 THEN
          DROP TABLE x       #---------------------------------------- copy sgd_file

          SELECT * FROM sgd_file WHERE sgd01=old_no INTO TEMP x
          IF STATUS THEN
             CALL cl_err3("ins","x",old_no,"",STATUS,"","sgd- x:",1)
             ROLLBACK WORK
             RETURN
          END IF

          UPDATE x SET sgd00=new_no

          INSERT INTO sgd_file SELECT * FROM x
          IF STATUS THEN
             CALL cl_err3("ins","sgd_file",new_no,"",STATUS,"","ins sgd:",1)  #No.FUN-650108
             ROLLBACK WORK
             RETURN
          END IF
       END IF
    END IF

    COMMIT WORK          #---------------------------------------- commit work

    CALL cl_msg("Copy Ok!")
    SELECT COUNT(*) INTO g_cnt FROM sfa_file where sfa01=old_no
    IF g_cnt >0 THEN
       UPDATE sfb_file SET sfb23 = 'Y' WHERE sfb01 = new_no
    ELSE
       UPDATE sfb_file SET sfb23 = 'N' WHERE sfb01 = new_no
    END IF
    SELECT COUNT(*) INTO g_cnt FROM ecm_file where ecm01=old_no
    IF g_cnt >0 THEN
       UPDATE sfb_file SET sfb24 = 'Y' WHERE sfb01 = new_no
    ELSE
       UPDATE sfb_file SET sfb24 = 'N' WHERE sfb01 = new_no
    END IF
    SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=new_no
    CALL i301_show()
    CALL i301_u()
    #SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=old_no      #FUN-C80046
    CALL i301_show()

END FUNCTION
FUNCTION i301_copy_2()
   DEFINE old_no,new_no   LIKE sfb_file.sfb01,
          new_date        LIKE type_file.dat
   DEFINE l_sfb           RECORD LIKE sfb_file.*
   DEFINE l_oayapr        LIKE oay_file.oayapr
   DEFINE li_result       LIKE type_file.num5
   DEFINE p_cmd           LIKE type_file.chr1
   DEFINE l_slip          LIKE smy_file.smyslip
   DEFINE l_sfb02         LIKE sfb_file.sfb02
   DEFINE l_sfb13         LIKE sfb_file.sfb13
   DEFINE l_sfb15         LIKE sfb_file.sfb15
   DEFINE l_time          LIKE type_file.num5
   DEFINE l_sfbmksg       LIKE sfb_file.sfbmksg  #MOD-D10118

   LET p_cmd = 'a'
   LET new_no = NULL
   LET new_date=g_today
   LET old_no  = g_sfb.sfb01

   IF g_sfb.sfb01 IS NULL THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF

   BEGIN WORK
   LET g_before_input_done = FALSE
   CALL i301_set_entry('a')
   LET g_before_input_done = TRUE

WHILE TRUE
    CALL cl_set_head_visible("","YES")
    INPUT new_no,new_date FROM sfb01,sfb81
    BEFORE INPUT
    CALL cl_set_docno_format("sfb01")

       AFTER FIELD sfb01
            #FUN-B50026 add
            IF NOT cl_null(new_no) THEN
               CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               RETURNING li_result,new_no
               DISPLAY BY NAME new_no
               IF (NOT li_result) THEN
                 NEXT FIELD sfb01
               END IF
            END IF
            #FUN-B50026 add--end
            IF p_cmd = "a" THEN
              IF NOT cl_null(new_no) THEN
               #Mark FUN-B50026
               #CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               #RETURNING li_result,new_no
               #DISPLAY BY NAME new_no
               #IF (NOT li_result) THEN
               #  NEXT FIELD sfb01
               #END IF
               #Mark FUN-B50026--end
                CALL i301_new_no(p_cmd)
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err(new_no,g_errno,0)
                   LET new_no = g_sfb.sfb01
                   DISPLAY BY NAME new_no
                   NEXT FIELD sfb01
                END IF
              END IF
           END IF
      #     CALL i301_set_no_entry(p_cmd)
      #     CALL i301_set_required()

        ON ACTION controlp
           CASE
              WHEN INFIELD(sfb01)
                   LET g_t1 = s_get_doc_no(new_no)
                   LET g_sql = " (smy73 <> 'Y' OR smy73 is null)"
                   CALL smy_qry_set_par_where(g_sql)
                   CALL q_smy( FALSE,TRUE,g_t1,'ASF','1') RETURNING g_t1
                   LET new_no=g_t1
                   DISPLAY new_no TO sfb01
                   NEXT FIELD sfb01
           END CASE

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()


    END INPUT

    IF INT_FLAG THEN
       LET INT_FLAG = 0
       DISPLAY g_sfb.sfb81 TO sfb81
       DISPLAY g_sfb.sfb01 TO sfb01
       RETURN
    END IF
        CALL s_auto_assign_no("asf",new_no,new_date,"1","sfb_file","sfb01","","","")
        RETURNING li_result,new_no
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY new_no TO sfb01
    EXIT WHILE
END WHILE

    IF INT_FLAG THEN
       LET INT_FLAG=0
       ROLLBACK WORK
       RETURN
    END IF

    IF NOT cl_sure(0,0) THEN
       ROLLBACK WORK
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM sfb_file
        WHERE sfb01=old_no
        INTO TEMP x
    LET l_sfb13 = g_today
    LET l_sfb15=l_sfb13+(g_ima.ima59+g_ima.ima60/g_ima.ima601*g_sfb.sfb08+g_ima.ima61)
        SELECT COUNT(*) INTO l_time FROM sme_file
           WHERE sme01 BETWEEN l_sfb13 AND l_sfb15  AND sme02 = 'N'
    LET l_sfb15 =l_sfb15+l_time
    #MOD-D10118---begin
    CALL s_get_doc_no(new_no) RETURNING l_slip
    SELECT smyapr INTO l_sfbmksg
      FROM smy_file
     WHERE smyslip = l_slip
    IF cl_null(l_sfbmksg) THEN LET l_sfbmksg = 'N' END IF
    #MOD-D10118---end
    UPDATE x
        SET sfb01=new_no,     #資料鍵值
            sfb101=NULL,      #MOD-C30887 add
            sfb81=new_date,   #日期
            sfb13=l_sfb13,
            sfb15=l_sfb15,
            sfb44=g_user,
            sfb87='N',
            sfb04='1',
            sfb28=NULL,
            sfb38=NULL,
            sfb43=0,
            sfb22=NULL,
            sfb221=NULL,
            sfb91=NULL,
            sfb92=NULL,
            sfb86=NULL,
            sfb89=NULL, #FUN-C30114
            sfb85=NULL,
            sfb919=NULL,
            sfb25=NULL,
            sfb081=0,sfb09=0,sfb12=0,
            sfb36=NULL,sfb37=NULL,sfb103=NULL,sfb104='N',
            sfb96=NULL,
            sfbuser=g_user,   #資料所有者
            sfbgrup=g_grup,   #資料所有者所屬群
            sfboriu=g_user,
            sfborig=g_grup,
            sfbmodu=NULL,     #資料修改日期
            sfbdate=g_today,   #資料建立日期
            #sfbmksg='N'  #MOD-D10118
            sfbmksg=l_sfbmksg  #MOD-D10118

    INSERT INTO sfb_file
        SELECT * FROM x
    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("ins","sfb_file",new_no,"",SQLCA.sqlcode,"","ins sfb:",1)  #No.FUN-650108
       ROLLBACK WORK RETURN
    END IF
    COMMIT WORK

    SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=new_no
    IF g_sfb.sfb93='N' THEN
       call i301_cralc()
    END IF
    IF g_sfb.sfb93='Y' AND g_sma.sma542<>'Y' THEN
       IF g_sma.sma26='2' THEN
          CALL i301_crrut('a')
       END IF
       CALL i301_cralc()
    END IF
    IF g_sfb.sfb93='Y' AND g_sma.sma542='Y' THEN
       CALL i301_cralc()
    END IF

    LET g_cnt=0
    SELECT count(*) INTO g_cnt FROM sfa_file where sfa01=new_no
    IF g_cnt =0 THEN
       DELETE FROM sfb_file where sfb01= new_no
    END IF
    CALL cl_msg("Copy Ok!")
    SELECT COUNT(*) INTO g_cnt FROM sfa_file where sfa01=old_no
    IF g_cnt >0 THEN
       UPDATE sfb_file SET sfb23 = 'Y' WHERE sfb01 = new_no
    ELSE
       UPDATE sfb_file SET sfb23 = 'N' WHERE sfb01 = new_no
    END IF
    SELECT COUNT(*) INTO g_cnt FROM ecm_file where ecm01=old_no
    IF g_cnt >0 THEN
       UPDATE sfb_file SET sfb24 = 'Y' WHERE sfb01 = new_no
    ELSE
       UPDATE sfb_file SET sfb24 = 'N' WHERE sfb01 = new_no
    END IF
    SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=new_no
    CALL i301_show()
    CALL i301_u()
    #SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=old_no      #FUN-C80046
    CALL i301_show()
END FUNCTION
FUNCTION i301_copy_3()
   DEFINE old_no,new_no   LIKE sfb_file.sfb01,
          new_date        LIKE type_file.dat
   DEFINE l_sfb           RECORD LIKE sfb_file.*
   DEFINE l_oayapr        LIKE oay_file.oayapr
   DEFINE li_result       LIKE type_file.num5
   DEFINE p_cmd           LIKE type_file.chr1
   DEFINE l_slip          LIKE smy_file.smyslip
   DEFINE l_sfb02         LIKE sfb_file.sfb02
   DEFINE l_sfb13         LIKE sfb_file.sfb13
   DEFINE l_sfb15         LIKE sfb_file.sfb15
   DEFINE l_time          LIKE type_file.num5
   DEFINE l_sfbmksg       LIKE sfb_file.sfbmksg  #MOD-D10118

   LET p_cmd = 'a'
   LET new_no = NULL
   LET new_date=g_today
   LET old_no  = g_sfb.sfb01

   IF g_sfb.sfb01 IS NULL THEN
      CALL cl_err('',-400,1)
      RETURN
   END IF

   BEGIN WORK
   LET g_before_input_done = FALSE
   CALL i301_set_entry('a')
   LET g_before_input_done = TRUE

WHILE TRUE
    CALL cl_set_head_visible("","YES")
    INPUT new_no,new_date FROM sfb01,sfb81
    BEFORE INPUT
    CALL cl_set_docno_format("sfb01")

       AFTER FIELD sfb01
            #FUN-B50026 add
            IF NOT cl_null(new_no) THEN
               CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               RETURNING li_result,new_no
               DISPLAY BY NAME new_no
               IF (NOT li_result) THEN
                 NEXT FIELD sfb01
               END IF
            END IF
            #FUN-B50026 add--end
            IF p_cmd = "a" THEN
              IF NOT cl_null(new_no) THEN
               #Mark FUN-B50026
               #CALL s_check_no("asf",new_no,old_no,"1","sfb_file","sfb01","")
               #RETURNING li_result,new_no
               #DISPLAY BY NAME new_no
               #IF (NOT li_result) THEN
               #  NEXT FIELD sfb01
               #END IF
               #Mark FUN-B50026--end
                CALL i301_new_no(p_cmd)
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err(new_no,g_errno,0)
                   LET new_no = g_sfb.sfb01
                   DISPLAY BY NAME new_no
                   NEXT FIELD sfb01
                END IF
              END IF
           END IF
      #     CALL i301_set_no_entry(p_cmd)
      #     CALL i301_set_required()

        ON ACTION controlp
           CASE
              WHEN INFIELD(sfb01)
                   LET g_t1 = s_get_doc_no(new_no)
                   LET g_sql = " (smy73 <> 'Y' OR smy73 is null)"
                   CALL smy_qry_set_par_where(g_sql)
                   CALL q_smy( FALSE,TRUE,g_t1,'ASF','1') RETURNING g_t1
                   LET new_no=g_t1
                   DISPLAY new_no TO sfb01
                   NEXT FIELD sfb01
           END CASE

       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION controlg
         CALL cl_cmdask()


    END INPUT

    IF INT_FLAG THEN
       LET INT_FLAG = 0
       DISPLAY g_sfb.sfb81 TO sfb81
       DISPLAY g_sfb.sfb01 TO sfb01
       RETURN
    END IF
        CALL s_auto_assign_no("asf",new_no,new_date,"1","sfb_file","sfb01","","","")
        RETURNING li_result,new_no
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY new_no TO sfb01
    EXIT WHILE
END WHILE

    IF INT_FLAG THEN
       LET INT_FLAG=0
       ROLLBACK WORK
       RETURN
    END IF

    IF NOT cl_sure(0,0) THEN
       ROLLBACK WORK
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM sfb_file
        WHERE sfb01=old_no
        INTO TEMP x
    LET l_sfb13 = g_today
    LET l_sfb15=l_sfb13+(g_ima.ima59+g_ima.ima60/g_ima.ima601*g_sfb.sfb08+g_ima.ima61)
        SELECT COUNT(*) INTO l_time FROM sme_file
           WHERE sme01 BETWEEN l_sfb13 AND l_sfb15  AND sme02 = 'N'
    LET l_sfb15 =l_sfb15+l_time
    #MOD-D10118---begin
    CALL s_get_doc_no(new_no) RETURNING l_slip
    SELECT smyapr INTO l_sfbmksg
      FROM smy_file
     WHERE smyslip = l_slip
    IF cl_null(l_sfbmksg) THEN LET l_sfbmksg = 'N' END IF
    #MOD-D10118---end
    UPDATE x
        SET sfb01=new_no,     #資料鍵值
            sfb101=NULL,      #MOD-C30887 add
            sfb81=new_date,   #日期
            sfb13=l_sfb13,
            sfb15=l_sfb15,
            sfb44=g_user,
            sfb87='N',
            sfb04='1',
            sfb28=NULL,
            sfb38=NULL,
            sfb43=0,
            sfb22=NULL,
            sfb23='N',        #MOD-C30889 add
            sfb221=NULL,
            sfb91=NULL,
            sfb92=NULL,
            sfb86=NULL,
            sfb89=NULL, #FUN-C30114
            sfb85=NULL,
            sfb919=NULL,
            sfb25=NULL,
            sfb081=0,sfb09=0,sfb12=0,
            sfb36=NULL,sfb37=NULL,sfb103=NULL,sfb104='N',
            sfb96=NULL,
            sfbuser=g_user,   #資料所有者
            sfbgrup=g_grup,   #資料所有者所屬群
            sfboriu=g_user,
            sfborig=g_grup,
            sfbmodu=NULL,     #資料修改日期
            sfbdate=g_today,   #資料建立日期
            #sfbmksg='N'       #MOD-D10118
            sfbdate=l_sfbmksg  #MOD-D10118

    INSERT INTO sfb_file
        SELECT * FROM x
    IF STATUS OR SQLCA.SQLCODE THEN
       CALL cl_err3("ins","sfb_file",new_no,"",SQLCA.sqlcode,"","ins sfb:",1)  #No.FUN-650108
       ROLLBACK WORK RETURN
    END IF
    COMMIT WORK          #---------------------------------------- commit work

    CALL cl_msg("Copy Ok!")
   #MOD-C30889 str mark-----
   #SELECT COUNT(*) INTO g_cnt FROM sfa_file where sfa01=old_no
   #IF g_cnt >0 THEN
   #   UPDATE sfb_file SET sfb23 = 'Y' WHERE sfb01 = new_no
   #ELSE
   #   UPDATE sfb_file SET sfb23 = 'N' WHERE sfb01 = new_no
   #END IF
   #MOD-C30889 end mark-----
    SELECT COUNT(*) INTO g_cnt FROM ecm_file where ecm01=old_no
    IF g_cnt >0 THEN
       UPDATE sfb_file SET sfb24 = 'Y' WHERE sfb01 = new_no
    ELSE
       UPDATE sfb_file SET sfb24 = 'N' WHERE sfb01 = new_no
    END IF
    SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=new_no
    CLEAR FORM         #MOD-C30889 add
    CALL i301_show()
    CALL i301_u()
    #SELECT sfb_file.* INTO g_sfb.* FROM sfb_file WHERE sfb01=old_no      #FUN-C80046
    CLEAR FORM         #MOD-C30889 add
    CALL i301_show()
END FUNCTION
FUNCTION i301_new_no(p_cmd)
   DEFINE p_cmd     LIKE type_file.chr1
   DEFINE l_slip    LIKE smy_file.smyslip
   DEFINE l_smy73   LIKE smy_file.smy73
   DEFINE new_no    LIKE sfb_file.sfb01
   LET g_errno = ' '
   IF cl_null(new_no) THEN RETURN END IF
   LET l_slip = s_get_doc_no(new_no)

   SELECT smy73 INTO l_smy73 FROM smy_file
    WHERE smyslip = l_slip
   IF l_smy73 = 'Y' THEN
      LET g_errno = 'asf-875'
   END IF

END FUNCTION
#FUN-9C0119--add--end

#FUN-B90008 --START--
FUNCTION i301_tmp2()

   LET g_sql = "new_part.sfa_file.sfa03,",
               "ima02_1.ima_file.ima02,",
               "ima021_1.ima_file.ima021,",
               "new_rate.bmd_file.bmd07,",
               "new_yes.type_file.chr1,",
               "new_qty.pml_file.pml20,",
               "new_qty3.pml_file.pml20,",
               "avl_stk.type_file.num15_3,",
               "new_qty4.pml_file.pml20,",
               "new_qty5.pml_file.pml20,",
               "new_qty6.pml_file.pml20,",
               "new_qty7.pml_file.pml20,",
               "new_qty8.pml_file.pml20"

  DROP TABLE i301_temp

   CREATE TEMP TABLE i301_tmp2(
               new_part LIKE sfa_file.sfa03,
               ima02_1  LIKE ima_file.ima02,
               ima021_1 LIKE ima_file.ima021,
               new_rate LIKE bmd_file.bmd07,
               new_yes  LIKE type_file.chr1,
               new_qty  LIKE pml_file.pml20,
               new_qty3 LIKE pml_file.pml20,
               avl_stk  LIKE type_file.num15_3,
               new_qty4 LIKE pml_file.pml20,
               new_qty5 LIKE pml_file.pml20,
               new_qty6 LIKE pml_file.pml20,
               new_qty7 LIKE pml_file.pml20,
               new_qty8 LIKE pml_file.pml20)

   IF SQLCA.SQLCODE THEN
     CALL cl_err('cretmp',SQLCA.SQLCODE,1)
     CALL cl_used(g_prog,g_time,2) RETURNING g_time
     EXIT PROGRAM
   END IF

END FUNCTION
#FUN-B90008 --END--
#FUN-B50046

#FUN-910088--add--start--
FUNCTION i301_sfa065_check()
   IF NOT cl_null(g_sfa[l_ac].sfa065) AND NOT cl_null(g_sfa[l_ac].sfa12) THEN
      IF cl_null(g_sfa12_t) OR cl_null(g_sfa_t.sfa065) OR g_sfa12_t != g_sfa[l_ac].sfa12 OR g_sfa_t.sfa065 != g_sfa[l_ac].sfa065 THEN
         LET g_sfa[l_ac].sfa065 = s_digqty(g_sfa[l_ac].sfa065,g_sfa[l_ac].sfa12)
         DISPLAY BY NAME g_sfa[l_ac].sfa065
      END IF
   END IF
   IF g_sfb.sfb02 MATCHES '[8]' THEN
      IF g_sfa[l_ac].sfa05 < 0 AND g_sfa[l_ac].sfa065 <> 0 THEN
          CALL cl_err('','asf-957',1)
          LET g_sfa[l_ac].sfa065=0
          RETURN FALSE
      END IF
   END IF
   IF NOT cl_null(g_sfa[l_ac].sfa05) AND NOT cl_null(g_sfa[l_ac].sfa065) THEN
      IF g_sfa[l_ac].sfa065 > g_sfa[l_ac].sfa05 AND g_sfa[l_ac].sfa05>=0 THEN
         CALL cl_err('','asf-976',1)
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION
#FUN-910088--add--end--

#MOD-C40045 str add------
FUNCTION i301_bom(l_level)

   DEFINE l_level       LIKE type_file.num5
   DEFINE l_bmb03       LIKE bmb_file.bmb03
   DEFINE l_bmb_num     LIKE type_file.num5
   DEFINE l_flag        LIKE type_file.chr1
   DEFINE l_bma01       LIKE bma_file.bma01

   DECLARE i301_bom_cs CURSOR FOR
    SELECT tmp_bmb03 FROM i301_tmp_bom WHERE tmp_level=l_level


   LET l_flag = 'N'
   FOREACH i301_bom_cs INTO l_bma01
     DECLARE i301_bom_cs2 CURSOR FOR
      SELECT bmb03 FROM bmb_file WHERE bmb01=l_bma01
     FOREACH i301_bom_cs2 INTO l_bmb03
       LET l_bmb_num = 0
       SELECT COUNT(bmb03) INTO l_bmb_num FROM bmb_file WHERE bmb01=l_bmb03
       IF l_bmb_num >0 THEN
          INSERT INTO i301_tmp_bom(tmp_bmb03,tmp_level) VALUES (l_bmb03,l_level+1)
          LET l_flag = 'Y'
       END IF
     END FOREACH
   END FOREACH
   IF l_flag = 'Y' THEN
      CALL i301_bom(l_level+1)
   END IF

END FUNCTION
#MOD-C40045 end add------


#FUN-CB0014---add---str---
FUNCTION i301_list_fill()
  DEFINE l_sfb01         LIKE sfb_file.sfb01
  DEFINE l_i             LIKE type_file.num10

    CALL g_sfb_l.clear()
    LET l_i = 1
    FOREACH i301_fill_cs INTO l_sfb01
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach item_cur',SQLCA.sqlcode,1)
          CONTINUE FOREACH
       END IF
       SELECT sfb01,'',sfb44,gen02,sfb81,sfb02,sfb39,sfb87,sfb04,sfb43,
              sfbmksg,sfb82,'',sfb05,ima02,ima021,sfb08,ima55,sfb93,sfb06,sfbud02 #chuyl add sfbud02 140113
             ,sfb09,0
         INTO g_sfb_l[l_i].*
         FROM sfb_file
              LEFT OUTER JOIN gen_file ON sfb44 = gen01
              LEFT OUTER JOIN ima_file ON sfb05 = ima01
        WHERE sfb01=l_sfb01
       LET g_buf = s_get_doc_no(g_sfb_l[l_i].sfb01)
       SELECT smydesc INTO g_sfb_l[l_i].smydesc FROM smy_file WHERE smyslip = g_buf
       IF (g_sfb_l[l_i].sfb02=7 OR g_sfb_l[l_i].sfb02=8 ) THEN
          SELECT pmc03 INTO g_sfb_l[l_i].pmc03 FROM pmc_file WHERE pmc01=g_sfb_l[l_i].sfb82
       ELSE
          SELECT gem02 INTO g_sfb_l[l_i].pmc03 FROM gem_file WHERE gem01=g_sfb_l[l_i].sfb82
       END IF
       SELECT SUM(sfv35) INTO g_sfb_l[l_i].sfv35s FROM sfv_file,sfu_file WHERE sfv11=g_sfb_l[l_i].sfb01 AND sfv01=sfu01 AND sfuconf='Y' AND sfupost='Y'
       LET l_i = l_i + 1
       IF l_i > g_max_rec THEN
          LET g_buf = NULL
          IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
          END IF
          EXIT FOREACH
       END IF
    END FOREACH
    LET g_rec_b3 = l_i - 1
    DISPLAY ARRAY g_sfb_l TO s_sfb_l.* ATTRIBUTE(COUNT=g_rec_b3,UNBUFFERED)
       BEFORE DISPLAY
          EXIT DISPLAY
    END DISPLAY

END FUNCTION

FUNCTION i301_bp3(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-680121 VARCHAR(1)

   IF p_ud <> "G"  THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_sfb_l TO s_sfb_l.* ATTRIBUTE(COUNT=g_rec_b3,UNBUFFERED)
       BEFORE DISPLAY
         CALL fgl_set_arr_curr(g_curs_index)
         CALL cl_navigator_setting( g_curs_index, g_row_count )

       BEFORE ROW
         LET l_ac3 = ARR_CURR()
         LET g_curs_index = l_ac3
         CALL cl_show_fld_cont()
     ON ACTION page_main
         LET g_action_flag = "page_main"
         LET l_ac3 = ARR_CURR()
         LET g_jump = l_ac3
         LET g_no_ask = TRUE
         IF g_rec_b3 > 0 THEN
             CALL i301_fetch('/')
         END IF
         CALL cl_set_comp_visible("info,page_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("info,page_list", TRUE)
         EXIT DISPLAY

      ON ACTION ACCEPT
         LET g_action_flag = "page_main"
         LET l_ac3 = ARR_CURR()
         LET g_jump = l_ac3
         LET g_no_ask = TRUE
         CALL i301_fetch('/')
         CALL cl_set_comp_visible("info,page_list", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("info,page_list", TRUE)
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
#FUN-9C0119--add--begin
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
#FUN-9C0119--add--end
      ON ACTION first
         CALL i301_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION previous
         CALL i301_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION jump
         CALL i301_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION next
         CALL i301_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
      ON ACTION last
         CALL i301_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(1)  ######add in 040505
         END IF
         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
#TQC-D10084---mark---str---
#     ON ACTION detail
#        LET g_action_choice="detail"
#        LET l_ac = 1
#        EXIT DISPLAY
#TQC-D10084---mark---end---
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         CALL i301_ui_default()
         CALL i301_pic()  #圖形顯示   #FUN-730012
         EXIT DISPLAY
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION agree           #准
         LET g_action_choice = "agree"
         EXIT DISPLAY

      ON ACTION deny            #不准
         LET g_action_choice = "deny"
         EXIT DISPLAY

      ON ACTION modify_flow     #加簽
         LET g_action_choice = "modify_flow"
         EXIT DISPLAY

      ON ACTION withdraw        #撤簽
         LET g_action_choice = "withdraw"
         EXIT DISPLAY

      ON ACTION org_withdraw    #抽單
         LET g_action_choice = "org_withdraw"
         EXIT DISPLAY

      ON ACTION phrase          #簽核意見
         LET g_action_choice = "phrase"
         EXIT DISPLAY
      #--FUN-8C0081--end--

      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################


      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY

      ON ACTION openurl
         LET g_action_choice="openurl"
         EXIT DISPLAY
#@    ON ACTION 產生備料
      ON ACTION gen_allotment
         LET g_action_choice="gen_allotment"
         EXIT DISPLAY
#@    ON ACTION 刪除備料
      ON ACTION delete_allotment
         LET g_action_choice="delete_allotment"
         EXIT DISPLAY
#@    ON ACTION 庫存資料
      ON ACTION inventory
         LET g_action_choice="inventory"
         EXIT DISPLAY
#@    ON ACTION 狀況查詢
      ON ACTION status_query
         LET g_action_choice="status_query"
         EXIT DISPLAY
#@    ON ACTION 供需
      ON ACTION demand_supply
         LET g_action_choice="demand_supply"
         EXIT DISPLAY
#@    ON ACTION 替代
      ON ACTION sub
         LET g_action_choice="sub"
         EXIT DISPLAY
#@    ON ACTION 挪料                       #MOD-A50141 mod #工單變更/挪料->挪料
      ON ACTION mat_shift                  #MOD-A50141 mod #wo_change_mat_shift->mat_shift
         LET g_action_choice="mat_shift"   #MOD-A50141 mod
         EXIT DISPLAY
#@    ON ACTION 訂單相關查詢
      ON ACTION order_query
         LET g_action_choice="order_query"
         EXIT DISPLAY
#@    ON ACTION 委外採購
      ON ACTION sub_p_o
         LET g_action_choice="sub_p_o"
         EXIT DISPLAY
#@    ON ACTION 產生製程
      ON ACTION gen_routing
         LET g_action_choice="gen_routing"
         EXIT DISPLAY
#@    ON ACTION 製程
      ON ACTION routing
         LET g_action_choice="routing"
         EXIT DISPLAY
#@    ON ACTION 備註
      ON ACTION memo
         LET g_action_choice="memo"
         EXIT DISPLAY
#@    ON ACTION 序號維護
      ON ACTION s_n
         LET g_action_choice="s_n"
         EXIT DISPLAY
#@    ON ACTION 模具領用
      ON ACTION mold_wtdw
         LET g_action_choice="mold_wtdw"
         EXIT DISPLAY
#@    ON ACTION 模具歸還
      ON ACTION mold_return
         LET g_action_choice="mold_return"
         EXIT DISPLAY
      ON ACTION run_card
         LET g_action_choice="run_card"
         EXIT DISPLAY
#@    ON ACTION EasyFlow送簽
      ON ACTION easyflow_approval
         LET g_action_choice="easyflow_approval"
         EXIT DISPLAY
#@    ON ACTION 確認
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
#@    ON ACTION 取消確認
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY
#@    ON ACTION 可结案
      ON ACTION confirm1
         LET g_action_choice="confirm1"
         EXIT DISPLAY
#@    ON ACTION 取消可结案
      ON ACTION undo_confirm1
         LET g_action_choice="undo_confirm1"
         EXIT DISPLAY
#@    ON ACTION 簽核狀況
      ON ACTION approval_status
         LET g_action_choice="approval_status"
         EXIT DISPLAY
#@    ON ACTION 作廢
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
      #CHI-D20010---begin
      ON ACTION undo_void
         LET g_action_choice="undo_void"
         EXIT DISPLAY
      #CHI-D20010---end

#No.FUN-630087 on action產生雜發單
      ON ACTION gen_m_iss
         LET g_action_choice="gen_m_iss"
         EXIT DISPLAY
#No.FUN-630087 維護雜發單
      ON ACTION m_iss
         LET g_action_choice="m_iss"
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE         #MOD-570244 mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
      ON ACTION CONTROLS
         CALL cl_set_head_visible("","AUTO")

      ON ACTION related_document                #No.FUN-6A0164  相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY

      ON ACTION aps_related_data
         LET g_action_choice = 'aps_related_data'
         EXIT DISPLAY

      ON ACTION aps_route_subc_data
         LET g_action_choice = 'aps_route_subc_data'
         EXIT DISPLAY

      #CHI-A50032 add --start--
      ON ACTION wo_change #工單變更
         LET g_action_choice="wo_change"
         EXIT DISPLAY
      #CHI-A50032 add --end--

      &include "qry_string.4gl"

   END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION

#FUN-CB0014---add---end---

#條碼產生函式
#DEV-D30026---add--begin-------------
#DEV-D30045--mark--begin
#FUNCTION i301_barcode_gen()
#  DEFINE l_ima930 LIKE ima_file.ima930
#  DEFINE l_ima932 LIKE ima_file.ima932
#  DEFINE l_ima918 LIKE ima_file.ima918
#  DEFINE l_ima919 LIKE ima_file.ima919
#  DEFINE l_ima921 LIKE ima_file.ima921
#  DEFINE l_ima922 LIKE ima_file.ima922
#  DEFINE l_ima931 LIKE ima_file.ima931
#  DEFINE l_count  LIKE type_file.num5
#  DEFINE l_cnt    LIKE type_file.num5 #DEV-D30026 add
#
#  IF cl_null(g_sfb.sfb01) THEN
#     CALL cl_err('',-400,0)
#     RETURN
#  END IF
#  SELECT * INTO g_sfb.* FROM sfb_file WHERE sfb01 = g_sfb.sfb01
#
#  IF g_sfb.sfb87 = 'N' THEN
#     CALL cl_err('','sfb-999',0)
#     RETURN
#  END IF
#
#  IF g_sfb.sfb87 = 'X' THEN
#     CALL cl_err('','sfb-998',0)
#     RETURN
#  END IF
#
#  #DEV-D30026 add----str---
#  LET l_cnt = 0
#  SELECT COUNT(*) INTO l_cnt
#    FROM tlfb_file
#   WHERE tlfb01 IN (SELECT UNIQUE ibb01 FROM ibb_file
#                     WHERE ibb03 = g_sfb.sfb01)
#  IF l_cnt >=1 THEN
#     #在條碼掃瞄異動記錄檔(tlfb_file)已有異動的記錄,不可再重新產生條碼!
#     CALL cl_err(g_sfb.sfb01,'aba-127',1)
#     RETURN
#  END IF
#  #DEV-D30026 add----end---
#
#   #No:DEV-CB0002--add--begin
#   LET g_success = 'Y'
#   BEGIN WORK
#   CALL s_showmsg_init()
#
#   OPEN i301_cl USING g_sfb.sfb01
#   IF STATUS THEN
#      CALL cl_err("OPEN i301_cl:", STATUS, 1)
#      CLOSE i301_cl
#      ROLLBACK WORK
#      RETURN
#   END IF
#
#   FETCH i301_cl INTO g_sfb.*          # 鎖住將被更改或取消的資料
#   IF SQLCA.sqlcode THEN
#      CALL cl_err('lock sfb:',SQLCA.sqlcode,0)     # 資料被他人LOCK
#      CLOSE i301_cl
#      ROLLBACK WORK
#      RETURN
#   END IF
#   #No:DEV-CB0002--add--end
#
#  SELECT ima918,ima919,ima921,ima922,ima930,ima931,ima932
#    INTO l_ima918,l_ima919,l_ima921,l_ima922,l_ima930,l_ima931,l_ima932
#    FROM ima_file WHERE ima01 = g_sfb.sfb05
#
#  IF l_ima930 <> 'Y' OR cl_null(l_ima930) THEN CALL cl_err('','sfb-997',1) RETURN END IF #DEV-D30026 cl_err 0-->1
#  IF l_ima932 <> 'A' OR cl_null(l_ima932) THEN CALL cl_err('','sfb-996',1) RETURN END IF #DEV-D30026 cl_err 0-->1
#  SELECT count(*) INTO l_count FROM ibb_file WHERE ibb02 = 'A' AND ibb03 = g_sfb.sfb01
#  IF l_count > 0 THEN
#     IF NOT cl_confirm('sfb-995') THEN RETURN END IF
#     DELETE FROM iba_file WHERE iba01 IN (SELECT ibb01 FROM ibb_file
#                                           WHERE ibb02 = 'A'
#                                             AND ibb03 = g_sfb.sfb01)
#     IF SQLCA.sqlcode THEN
#        CALL cl_err3("del","iba_file",g_sfb.sfb01,'',SQLCA.sqlcode,"","",1)
#        LET g_success = 'N' #No:DEV-CB0002--add
#        ROLLBACK WORK       #No:DEV-CB0002--add
#        RETURN
#     END IF
#     DELETE FROM ibb_file WHERE ibb02 = 'A' AND ibb03 = g_sfb.sfb01
#     IF SQLCA.sqlcode THEN
#        CALL cl_err3("del","ibb_file",g_sfb.sfb01,'',SQLCA.sqlcode,"","",1)
#        LET g_success = 'N' #No:DEV-CB0002--add
#        ROLLBACK WORK       #No:DEV-CB0002--add
#        RETURN
#     END IF
#  END IF
#
#  IF l_ima918 = 'Y' AND l_ima919 = 'Y' THEN
#     CALL s_gen_barcode('1','A',g_sfb.sfb01,0,g_sfb.sfb05,g_sfb.sfb08)
#  END IF
#
#  IF l_ima921 = 'Y' AND l_ima922 = 'Y' THEN
#     CALL s_gen_barcode('2','A',g_sfb.sfb01,0,g_sfb.sfb05,g_sfb.sfb08)
#  END IF
#
#  IF l_ima931 = 'Y' THEN
#     CALL s_gen_barcode('3','A',g_sfb.sfb01,0,g_sfb.sfb05,g_sfb.sfb08)
#  END IF
#
#   #No:DEV-CB0002--add--begin
#   CALL s_showmsg()
#   IF g_success='Y' THEN
#      CALL cl_msgany(0,0,'aba-001')
#      COMMIT WORK
#   ELSE
#      CALL cl_msgany(0,0,'aba-002')
#      COMMIT WORK
#      ROLLBACK WORK
#   END IF
#   #No:DEV-CB0002--add--end
#END FUNCTION
#DEV-D30045--mark--end
#DEV-D30026---add--end---------------

#No:DEV-CB0005--add--begin
FUNCTION t301_chk_smyb(p_sfb05)
   DEFINE p_sfb05    LIKE sfb_file.sfb05
   DEFINE l_smyb01   LIKE smyb_file.smyb01
   DEFINE l_ima930   LIKE ima_file.ima930
   DEFINE l_ima932   LIKE ima_file.ima932

   LET g_errno = ''
   IF g_aza.aza131 <> 'Y' OR
      cl_null(g_sfb.sfb01) OR cl_null(p_sfb05) THEN
      RETURN
   END IF

   LET g_t1 = s_get_doc_no(g_sfb.sfb01)
   LET l_smyb01 = ''
   SELECT smyb01 INTO l_smyb01
     FROM smyb_file
    WHERE smybslip = g_t1

   LET l_ima930 = ''
   LET l_ima932 = ''
   SELECT ima930,ima932
     INTO l_ima930,l_ima932
     FROM ima_file
    WHERE ima01 = p_sfb05
   IF cl_null(l_ima930) THEN LET l_ima930 = 'N' END IF

   CASE
      WHEN l_smyb01 = '1'  #1:非條碼單據
        #IF l_ima930 = 'N' THEN #DEV-D30026 mark
         IF l_ima930 = 'Y' THEN #DEV-D30026 add
            LET g_errno = 'aba-036' #當前單別不允許輸入使用條碼料件！
         END IF

      WHEN l_smyb01 = '2'  #2:條碼單據
        #IF l_ima930 <> 'Y' OR l_ima932 = 'H' THEN #DEV-D30026 mark
         IF l_ima930 = 'N' THEN                    #DEV-D30026 add
            LET g_errno = 'aba-095' #當前單別只允許輸入使用條碼料件(ima930='Y')!
         END IF
     #DEV-D30026 mark---str---
     #WHEN l_smyb01 = '3'
     #   IF l_ima930 <> 'Y' OR l_ima932 <> 'H' OR cl_null(l_ima932) THEN
     #      LET g_errno = 'aba-096'
     #   END IF
     #DEV-D30026 mark---end---
   END CASE
END FUNCTION
#No:DEV-CB0005--add--end
#add by lanhang 131125 begin
FUNCTION i301_sfa_det(p_ac)
DEFINE p_ac LIKE type_file.num5
   IF g_sfb.sfb01 IS NULL THEN RETURN END IF
   IF l_ac IS NULL OR l_ac=0 OR l_ac>g_rec_b THEN RETURN END IF
   OPEN WINDOW i301_b_w AT 13,11 WITH FORM "csf/42f/csfi301_d"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

   CALL cl_ui_locale("csfi301_d")
   DECLARE i301_sfa_cs CURSOR FOR
      SELECT tc_sfa02,ima02,ima021,tc_sfa03,tc_sfa04,tc_sfa06,tc_sfa05,tc_sfa08,
             tc_sfa07,tc_sfa14,tc_sfa09,tc_sfa10,tc_sfa11,tc_sfa12,tc_sfa13
        FROM tc_sfa_file,ima_file
       WHERE tc_sfa01=g_sfb.sfb01 AND tc_sfa02=g_sfa[p_ac].sfa03
         AND tc_sfa03=g_sfa[p_ac].sfa08 AND tc_sfa02=ima01
   LET g_cnt=1
   FOREACH i301_sfa_cs INTO g_tc_sfa[g_cnt].*
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_tc_sfa.deleteElement(g_cnt)
   LET g_rec_b4=g_cnt-1
   DISPLAY g_rec_b4 TO cn3
   LET g_cnt=0
   DISPLAY ARRAY g_tc_sfa TO s_tc_sfa.* ATTRIBUTE(COUNT=g_rec_b4,UNBUFFERED)
      BEFORE DISPLAY
         CALL fgl_set_arr_curr(g_curs_index)
         CALL cl_navigator_setting(g_curs_index,g_row_count)

      BEFORE ROW
         LET l_ac4 = ARR_CURR()
         LET g_curs_index = l_ac4
         CALL cl_show_fld_cont()
      ON ACTION ACCEPT
         EXIT DISPLAY

      ON ACTION EXIT
         EXIT DISPLAY

      ON ACTION CANCEL
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()

      ON ACTION about
         CALL cl_about()

      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION help
         CALL cl_show_help()

   END DISPLAY
   CLOSE WINDOW i301_b_w
END FUNCTION
#add by lanhang 131125 end
FUNCTION i301_confirm1()

   LET g_success = 'Y'
   BEGIN WORK

   OPEN i301_cl USING g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err("OPEN i301_cl:", STATUS, 1)
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH i301_cl INTO g_sfb.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err('lock sfb:',SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF
   LET g_sfb.ta_sfb35='Y'
   UPDATE sfb_file SET ta_sfb35=g_sfb.ta_sfb35 WHERE sfb01=g_sfb.sfb01
   IF sqlca.sqlcode THEN
      CALL cl_err3("upd","sfb_file",g_sfb.sfb01,"sfb35",sqlca.sqlcode,"","upd sfb:",1)
      CLOSE i301_cl
      LET g_sfb.ta_sfb35=g_sfb_t.ta_sfb35
      DISPLAY BY NAME g_sfb.ta_sfb35
      ROLLBACK WORK
      RETURN
   END IF
   COMMIT WORK
   CLOSE i301_cl

END FUNCTION
FUNCTION i301_undo_confirm1()

   LET g_success = 'Y'
   BEGIN WORK

   OPEN i301_cl USING g_sfb.sfb01
   IF STATUS THEN
      CALL cl_err("OPEN i301_cl:", STATUS, 1)
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH i301_cl INTO g_sfb.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err('lock sfb:',SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE i301_cl
      ROLLBACK WORK
      RETURN
   END IF
   LET g_sfb.ta_sfb35='N'
   UPDATE sfb_file SET ta_sfb35=g_sfb.ta_sfb35 WHERE sfb01=g_sfb.sfb01
   IF sqlca.sqlcode THEN
      CALL cl_err3("upd","sfb_file",g_sfb.sfb01,"sfb35",sqlca.sqlcode,"","upd sfb:",1)
      CLOSE i301_cl
      LET g_sfb.ta_sfb35=g_sfb_t.ta_sfb35
      DISPLAY BY NAME g_sfb.ta_sfb35
      ROLLBACK WORK
      RETURN
   END IF
   DISPLAY BY NAME g_sfb.ta_sfb35
   COMMIT WORK
   CLOSE i301_cl

END FUNCTION

FUNCTION i301_js()
DEFINE l_month,l_c LIKE type_file.num5
DEFINE l_js        LIKE type_file.num15_3

   IF cl_null(g_sfb.sfb01) THEN RETURN END IF

   LET l_month=MONTH(g_sfb.sfb15)
   SELECT COUNT(*) INTO l_c FROM sjl.azf_file WHERE azf02='M' AND azf01=l_month
   IF l_c>0 THEN    #淡季
      LET l_js=0
      SELECT NVL(tc_imf05,1) INTO l_js
        FROM sjl.tc_imf_file
       WHERE tc_imf01=g_sfb.sfb05
         AND tc_imf03<=g_sfb.sfb08
         AND (tc_imf04>=g_sfb.sfb08 OR tc_imf04=0)
         AND ROWNUM=1
       ORDER BY tc_imf02
      IF cl_null(l_js) OR l_js=0 THEN
         LET l_js=0
      END IF
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb43   #印刷结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0002'
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb44   #高频结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0003'
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb45   #包装结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0004'

      UPDATE sfb_file
         SET ta_sfb43=g_sfb.ta_sfb43,
             ta_sfb44=g_sfb.ta_sfb44,
             ta_sfb45=g_sfb.ta_sfb45
       WHERE sfb01=g_sfb.sfb01
      IF SQLCA.sqlcode THEN
         CALL s_errmsg('sfb01',g_sfb.sfb01,'','cxm-023',1)
         LET g_success='N'
      END IF
   ELSE             #旺季
      LET l_js=0
      SELECT NVL(tc_ime05,1) INTO l_js
        FROM sjl.tc_ime_file
       WHERE tc_ime01=g_sfb.sfb05
         AND tc_ime03<=g_sfb.sfb08
         AND (tc_ime04>=g_sfb.sfb08 OR tc_ime04=0)
         AND ROWNUM=1
       ORDER BY tc_ime02
      IF cl_null(l_js) OR l_js=0 THEN
         LET l_js=0
      END IF
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb43   #印刷结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0002'
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb44   #高频结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0003'
      SELECT tc_ecb07*l_js INTO g_sfb.ta_sfb45   #包装结算价
        FROM sjl.tc_ecb_file
       WHERE tc_ecb01=g_sfb.sfb05
         AND tc_ecb03='0004'

      UPDATE sfb_file
         SET ta_sfb43=g_sfb.ta_sfb43,
             ta_sfb44=g_sfb.ta_sfb44,
             ta_sfb45=g_sfb.ta_sfb45
       WHERE sfb01=g_sfb.sfb01
      IF SQLCA.sqlcode THEN
         CALL s_errmsg('sfb01',g_sfb.sfb01,'','cxm-023',1)
         LET g_success='N'
      END IF
   END IF
   CALL i301_show()
END FUNCTION
