# Prog. Version..: '5.25.02-11.06.24(00010)'     #
#
# Pattern name...: axrt300.4gl
# Descriptions...: 應收帳款維護作業
# Date & Author..: 95/01/05 By Roger
# Modify.........: 95/06/20 By Danny  (當稅別修改時,單身金額重計)
# Modify.........: 95/07/18 By Danny  (673行)
# Modify.........: 95/12/19 By WUPN   (822-823行)
#                  96-09-23 By Charis 1.立即確認、列印2.編碼方式3.單別<^P> oo_file
#                  4.傳票編號拿掉 5.brief_report_print合計位置未對齊 6.作廢無法執行
#                  7.增加單身自動產生功能(同2.0版功能) 8.invoice_print拿掉
# Modify.........: 97-04-18 BY joanne
#                  1.單頭原幣金額取位錯誤 (t_azi04 -> g_azi04)
# Modify.........: 97-04-23 BY joanne
#                  1.配合 AP修改,call s_fsgl 時多傳一參數 1
# Modify.........: 97-05-15 BY Sophia
#                  CALL s_t300_gl之前的DELETE拿掉,s_t300_gl中再DELETE
# Modify.........: 97-05-26 BY Sophia 1.確認不產生分錄底稿,但須check存在且平衡
#                  2.確認時check不可小於關帳日期3.確認時,出貨單之發票號碼拿掉
#                  4.發票開立須已確認 5.發票開立時,update出貨單之發票號碼
#                  6.取消確認不刪除分錄底稿,傳票號碼不為空白仍可
#                  7.取消確認不可小於關帳日期
# Modify.........: 97-06-30 BY sophia 畫面多銷售分類一,二
# Modify.........: 97-07-14 BY sophia 產生發票時不update帳款編號
# Modify.........: 97/07/31 By sophia若金額為0,但數量不為0則此筆資料仍須保留
# Modify.........: 97/08/01 By Sophia判斷是否須確認後才可開立發票
# Modify.........: 97/08/20 By Sophia輸入一筆資料後,按G.可重開多次
# Modify.........: 98/10/29 By Sophia 新增一帳款類別 '25'銷貨折扣
# Modify.........: 01/08/09 By Wiky 9.修改稅額應不可跳至發票號碼欄位,
#                                     若有須要改發票或重開, 應用 G.發票開立功能
# Modify.........: No:7680 03/08/11 By Wiky 9.稅額修正 在 Y.確認 及 有發票號碼 時, 不可執行
# Modify.........: No:7837 03/08/19 By Wiky 呼叫自動取單號時應在 Transction中
# Modify.........: No:7682 03/08/26 By Wiky 同一出貨單項次在立帳未確認狀態下可重覆輸入(未考慮已輸入數量)
# Modify.........: No:8161 03/09/09 Kammy 1.add oma99 多角序號
#                                         2.如果 oma99 not null 不可取消確認
#                                         3.取消 axrt301程式
# Modify.........: No:8383 03/10/02 Melody AFTER ROW時,若金額為0,但數量不為0則此
# Modify.........: No:8519 03/10/31 Kitty 類別為'31'無法取消確認
# Modify.........: No:A097 03/11/25 ching 紅字發票處理 append
# Modify.........: No:9340 04/05/13 ching 三角貿易 執行'G.發票開立' 不必call s_up_omb & oar_file nouse
# Modify.........: No:A120 04/04/02 Danny  大陸版功能,T.發票待抵維護
# Modify.........: No.MOD-470514 04/07/23 ching 4ad 有 "三角貿易" 中文字
# Modify.........: No.MOD-480390 04/08/17 ching 列印有錯
# Modify.........: No.MOD-490344 04/09/21 By Kitty Controlp 未加display
# Modify.........: No.MOD-490461 04/09/29 By Yuna 部門.人員 請加 show 簡稱
# Modify.........: No.FUN-4B0017 04/11/02 By ching add '轉Excel檔' action
# Modify.........: No.MOD-4A0297 04/11/11 By Nicola 雜項應收刪除時，把afat110的帳款編號欄位也清空
# Modify.........: No.FUN-4B0056 04/11/24 By ching add 匯率開窗 call s_rate
# Modify ........: No.FUN-4C0013 04/12/01 By ching 單價,金額改成 DEC(20,6)
# Modify.........: No.FUN-4C0049 04/12/09 By Nicola 權限控管修改
# Modify.........: No.FUN-4C0100 05/01/06 By Smapmin 報表轉XML格式
# Modify.........: No.MOD-510092 05/03/09 By Kitty oma00='31'的無法刪除
# Modify.........: No.MOD-530008 05/03/10 By Kitty 修正輸入/更改順序: 員工(oma14)->部門(oma15), 系統自動根據員工所屬部門代入
# Modify.........: No.MOD-520040 05/03/18 By Kitty 發現取位問題,一併修改
# Modify.........: No.MOD-530272 05/03/25 By Nicola 部門判斷會計部門為"Y"
# Modify.........: No.MOD-530284 05/03/25 By Nicola 1.用mouse 操作時, 應收款日及票到期日 顯示不出來
#                                                   2.列印時, 應可選擇 "應收憑單" (axrr301)-->列印新加call
# Modify.........: No.MOD-530315 05/03/28 By Nicola 本幣的含稅金額未依幣別檔取小數位數(如: 741-530003)
# Modify.........: No.MOD-530692 05/03/29 By day 1.MENU中"發票待扺維護"有誤。
#                                                2.單身錄入時數量after field不能過
# Modify.........: No.MOD-530227 05/04/18 By Nicola 開立發票時,check收款條件若起算基準日為發票日,則詢問客戶是否要重算收款日及票到期日
# Modify.........: No.FUN-540040 05/04/20 By Nicola TIPTOP與EasyFlow整合
# Modify.........: No.FUN-540006 05/04/26 By day 取消有條件隱藏“發票開立”按鈕，當有防偽稅控接口時串到gisp100
# Modify.........: No.FUN-540057 05/05/10 By wujie 發票號碼調整
# Modify.........: No.FUN-550071 05/05/25 By vivien 單據編號格式放大
# Modify.........: No.FUN-530041 05/05/18 By Smapmin 只詢問一次"是否重新產生分錄"
# Modify.........: No.FUN-550049 05/06/11 By Echo 新增 TIPTOP 與 EasyFlow 整合
# Modify.........: No.MOD-560007 05/06/11 By Echo 重新定義整合FUN名稱
# Modify.........: No.FUN-560070 05/06/18 By Smapmin 單位數量改抓計價單位計價數量
# Modify.........: No.FUN-560198 05/07/05 By trisy 發票欄位加大后截位修改
# Modify.........: No.MOD-560094 05/07/04 By ching fix oma171,oma172給值
# Modify.........: No.MOD-570128 05/07/06 By day   g_x[41]未列印
# Modify.........: No.FUN-570273 05/07/29 By Dido  單身未輸入確認無法跳出視窗
# Modify.........: No.FUN-570272 05/08/01 By wujie u功能時check單別有問題
# Modify.........: No.MOD-570266 05/08/03 By Nicola 重新oga10時，同時重新oga05
# Modify.........: No.FUN-580006 05/08/16 By ice 是否使用銷項防偽稅控接口
# Modify.........: No.FUN-580153 05/08/27 By Dido 以EF為backend engine,由TIPTOP處理前端簽核動作
# Modify.........: No.MOD-580269 05/08/29 By Smapmin 訊息寫死中文
# Modify.........: No.FUN-570099 05/09/12 By Elva  新增直接收款功能
# Modify.........: No.FUN-590100 05/09/05 By elva 新增紅衝功能
# Modify.........: No.MOD-590095 05/09/07 By ice 調整aza47的判斷
# Modify.........: No.FUN-530061 05/09/27 By Sarah 確認時, 應提供整批確認功能
# Modify.........: No.MOD-590116 05/09/29 By Smapmin 應收單身若料號為MISC*,應也要 FIND ima_file後,再供user修改才是.
#                                                    若為MISC*,而 omb06,omb05 已有值時則不可再覆蓋!
#                                                    單身料號開窗.
# Modify.........: No.FUN-5A0124 05/10/19 By elva 刪除帳款資料時，刪除oov_file；調整由于FUN-530061動到的紅衝功能，使其能審核!
# Modify.........: No.MOD-5A0019 05/10/24 By Smapmin 先判斷出貨單上有此帳款才作UPDATE oga10的動作
# Modify.........: No.MOD-5A0186 05/10/25 By Carrier s_get_doc誤用
# Modify.........: No.TQC-5A0089 05/10/27 By Smapmin 單別寫死
# Modify.........: No.MOD-5A0318 05/11/08 By Smapmin 帳款刪除時,沒有檢查此帳款是否已在其他帳款的發票待抵維護中.
#                                                    錯誤訊息顯示有誤.
#                                                    單別有限定user,但新增時輸入限制使用者之單別,卻可pass,系統沒判斷.
#                                                    取消確認時,請加判斷是否已存在"有效"收帳單(確認,未確認皆判斷)
# Modify.........: No.TQC-5B0116 05/11/14 BY yiting &051112
#含稅否(oma213)應設為noentry,才不會因為含稅否值可人為變動,造成發票開立時帳款與發票的含稅碼別不一致的狀況
#axrt310中 ome213 也有同上的問題,也應同上方式修改
# Modify.........: No.MOD-5A0331 05/11/28 By ice 使用稅控系統:發票底稿有資料(不為作廢)時不可再取消確認;發票種類為'A',才走gisi100
# Modify.........: No.TQC-5B0080 05/11/28 By ice 確認&取消確認更新已收金額時,應考慮發票待扺&直接收款&收款衝帳三部分的異動
# Modify.........: No.TQC-5B0175 05/11/28 By ice 大陸版時:確認后應更新發票金額;查詢只須呈現待扺資料;gisi100應呈現出負值顯示的待扺資料
# Modify.........: No.MOD-5B0006 05/12/07 By Smapmin 收款客戶與送貨客戶不同時,只需秀出警告訊息.
#                                                    確認時跑二次axr-007的訊息.
#                                                    進入單身前,自動會產生銷退單身資料,但是沒有即時做單身的fill
#                                                    稅額僅可透過稅額修正來修改
# Modify.........: No.MOD-5C0077 05/12/15 By Smapmin 整批確認時,確認否與狀況未UPDATE
# Modify.........: No.MOD-5C0111 05/12/21 By Smapmin omb14/omb14t的計算邏輯要與s_g_ar.4gl一致
# Modify.........: No.FUN-610020 06/01/18 By Carrier 出貨驗收功能 -- 修改oga09的判斷
# Modify.........: No.MOD-620003 06/02/07 By Smapmin 錯誤訊息(未稅金額 * 0.05<>稅額)僅為提示作用,不做卡關動作
# Modify.........: No.TQC-630066 06/03/07 By Kevin 流程訊息通知功能修改
# Modify.........: No.FUN-630043 06/03/14 By Melody 多工廠帳務中心功能修改
# Modify.........: No.MOD-630088 06/03/30 By Smampin 帳款類別為11時,不更新oga54
# Modify.........: No.MOD-630103 06/03/31 By Smapmin 同一發票編號,不同張帳款,發票金額等欄位不重新計算
# Modify.........: No.MOD-640082 06/04/08 By Sarah ACTIOIN中的「其他資料」的銷售分類二，開窗選完的資料會帶到銷售分類一
# Modify.........: No.FUN-640029 06/04/14 By kim GP3.0 匯率改善功能
# Modify.........: No.FUN-640191 06/04/14 By kim Add oma67 Invoice No.
# Modify.........: No.FUN-640246 06/05/02 By Echo 自動執行確認功能
# Modify.........: No.MOD-650003 06/05/03 By Smapmin UPDATE oha_file時,先判斷該筆資料是否存在
# Modify.........: No.TQC-5C0086 05/12/28 By ice AR月底重評修改
# Modify.........: No.FUN-630015 06/05/25 BY yiting s_rdate2改呼叫s_rdatem
# Modify.........: No.FUN-5C0014 06/06/01 By rainy 新增欄位oma67存放INVOICE No.
# Modify.........: No.TQC-660010 06/06/02 By Smapmin 報表列印有誤
# Modify.........: No.MOD-530702 06/06/14 By Rayven 單身加判斷：單身稅前金額*(1+稅率/100)與單身稅后金額的差異不可>=0.06
# Modify.........: No.FUN-660116 06/06/19 By ice cl_err --> cl_err3
# Modify.........: No.MOD-660091 06/06/22 By Smapmin  當 oma00 = '12' 時,若 oma16 未輸入,則取 omb31 出貨單編號串 oga_file
# Modify.........: No.MOD-660152 06/07/03 By rainy '23'預收款類資料不能做取消確認及刪除
# Modify.........: No.TQC-670008 06/07/04 By rainy 權限修正
# Modify.........: No.MOD-660086 06/07/05 By Sarah 查詢一筆未確認的單號後按新增再放棄,再按作廢,之前查詢的那筆會被作廢掉
# Modify.........: No.TQC-670001 06/07/05 By Elva 待扺衝帳時Mark 掉不可能的情況
# Modify.........: No.FUN-660216 06/07/10 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.FUN-670047 06/07/13 By Elva 新增多套帳功能
# Modify.........: No.MOD-670103 06/07/25 By wujie 修正MOD-530702引起的問題
# Modify.........: No.FUN-670026 06/07/27 By Tracy 應收銷退合并  
# Modify.........: No.FUN-680001 06/08/01 By kim GP3.5 利潤中心
# Modify.........: No.FUN-670060 06/08/07 By Rayven 新增"直接拋轉總帳"功能
# Modify.........: No.FUN-680022 06/08/10 By Tracy 多帳期修改,s_rdatem()增加一個參數   
# Modify.........: No.FUN-680123 06/08/29 By hongmei 欄位類型轉換
# Modify.........: No.FUN-670026 06/10/18 By cl    處理單身來源無法更新的問題
# Modify.........: No.FUN-6A0095 06/10/27 By xumin l_time轉g_time 
# Modify.........: No.FUN-690012 06/10/31 By rainy 12類的 omb33<--oba11 
# Modify.........: No.TQC-690110 06/11/02 By cl    處理立尾款時單身數量卡死現象。立尾款時，單身數量要麼是訂單數量要麼自定。
# Modify.........: No.FUN-690090 06/11/02 By cl    增加欄位oma992 
# Modify.........: No.FUN-6A0092 06/11/14 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No.FUN-6B0042 06/11/17 By jamie 1.FUNCTION _q() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modify.........: No.MOD-6B0113 06/11/23 By cl    1.當oma00='2*'時，判斷oov_file是否存在，若存在必須先刪除oov_file資料后，再刪除oma_file
# Modify.........:                                 2.對參數g_amt1f和g_amt1;g_amt3f和g_amt3進行mark。
# Modify.........: No.TQC-6B0067 06/11/29 By cl    1.為2*的帳款單據，多帳期資料僅為1筆。
# Modify.........:                                 2.t300_k()待扺衝賬功能下，若該帳款單據對應的待扺單據中的多帳期資料僅為1筆，則oov05(子項次)自動賦值為1
# Modify.........:                                 3.修正t300_k()待扺衝賬功能下，對oma,omc的計算，并增加對待扺帳款omc的處理功能代碼。
# Modify.........: No.MOD-6B0121 06/12/05 By Smapmin 匯率開窗輸入後要重算本幣金額
# Modify.........: No.MOD-680050 06/12/07 By Smapmin 只要是多角貿易皆不可取消確認
# Modify.........: No.MOD-6A0011 06/12/07 By Smapmin 作廢理由碼開窗,應只開理由碼即可
# Modify.........: No.TQC-6B0003 06/12/07 By Smapmin 發票限額的處理僅限於大陸版
# Modify.........: No.MOD-6B0012 06/12/07 By Smapmin 單身輸入筆數限制應依照axrs010的設定
# Modify.........: No.TQC-6B0151 06/12/08 By Smapmin 數量應抓取計價數量
# Modify.........: No.MOD-680005 06/12/08 By Smapmin 修改輸入客戶編號後Default帶出收款條件的時機
#                                                    為因應s_rdatem.4gl程式內對於dbname的處理,故LET g_dbs2=g_dbs,'.'
# Modify.........: No.MOD-690136 06/12/08 By Smapmin 增加單身科目控管,已立待驗收入者不可輸入科目
# Modify.........: No.MOD-680041 06/12/08 By Smapmin 訂金本幣金額與立帳本幣金額不符
# Modify.........: No.TQC-6C0046 06/12/11 By Smapmin 發票匯率開窗輸入後要重算本幣發票金額
# Modify.........: No.MOD-6C0044 06/12/11 By Smapmin UPDATE oma_file數值不可為NULL
# Modify.........: No.TQC-6B0051 06/12/13 By xufeng  修改報表 
# Modify.........: No.TQC-6C0085 06/12/15 By chenl   根據來源類型，控管金額的正負。                        
# Modify.........: No.CHI-710005 07/01/18 By Elva 去掉aza26的判斷
# Modify.........: No.FUN-710050 07/02/01 By hongmei 錯誤訊息匯總顯示修改
# Modify.........: No.MOD-720089 07/02/14 By Smapmin 增加CALL q_ogb()的參數
# Modify.........: No.MOD-710205 07/03/01 By Smapmin 未確認的單據才可重新產生分錄
# Modify.........: No.MOD-710187 07/03/01 By Smapmin 開放 2* 類別可做稅額修正
# Modify.........: No.MOD-710157 07/03/01 By Smapmin 類別為22的預設值和判斷與類別為21相同
# Modify.........: No.FUN-720038 07/03/05 By rainy 顯示單身金額合計
# Modify.........: No.TQC-6B0105 07/03/08 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.FUN-730073 07/04/02 By mike    會計科目加帳套
# Modify.........: No.TQC-740094 07/04/16 By Carrier 錯誤匯總功能-修改
# Modify.........: No.MOD-740051 07/04/18 By Smapmin 沖帳細項查詢無法顯示
# Modify.........: No.TQC-740130 07/04/18 By Smapmin 修正FUN-670026
# Modify.........: No.TQC-740047 07/04/18 By Rayven 走客戶簽收流程時，原來出貨單可以在axrt300里手工立帳，沒有控管，造成重復立帳
# Modify.........: No.TQC-740156 07/04/22 By claire 修正 FUN-670026 EasyFlow背景執行時才需判斷
# Modify.........: No.MOD-740170 07/04/22 By Rayven 更改時報axr-953的錯
# Modify.........: No.MOD-740429 07/04/24 By Ray 單身金額不會自動帶出
# Modify.........: No.TQC-740129 07/04/25 By sherry 錄入單身時，錄入一筆已審核尚未過帳的出貨單號時，報錯信息維護錯誤。
# Modify.........: No.MOD-740321 07/04/27 By Nicola 加show 訊息
# Modify.........: No.TQC-740350 07/04/29 By Rayven 直接手工在axrt300中錄入，返利單身無法錄入
# Modify.........: No.TQC-740278 07/04/29 By Judy 執行多帳期維護未處理帳款尾差 , 以致產出與單頭不合
# Modify.........: No.TQC-740309 07/05/08 By Rayven 新增oma04，omb39一定要有值，為空時給'N'值
# Modify.........: No.CHI-750012 07/05/09 By kim 1.在確認狀態,執行"發票開立"後,不應顯示"apa-919:多帳期資料須做調整"的訊息
#                                                2.刪除發票號,多帳期的發票號碼未刪除
# Modify.........: No.TQC-750058 07/05/14 By Smapmin 檢核出貨日期與帳款日期不同年月的狀況
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.TQC-750177 07/05/25 By rainy 單身輸入 MISC1 確警告 (select ima01.).error應改為和訂單處理一致
# Modify.........: No.TQC-750177 07/05/28 By rainy 進入單身維護後離開單身後警告 ...ins omc error
#                                                  直接收款""銀存異動碼""開窗查詢,應只需查出 ""存提別""(nmc03='1') 存入資料
#                                                  直接收款,分錄未修正,確認前應檢查 直接收款科目金額
#                                                  輸完單身後,離開單身,單頭 未收 (oma55_u,oma57_u) 未re-show! 
# Modify.........: No.TQC-750226 07/05/FUN-FUN-y0 By rainy 產生的訂金按 u.修改,直接離開 卻警告 aap-919 ...多帳期...,並到 列印選項  應該是可直接離開!
# Modify.........: No.MOD-750142 07/05/31 By smapmin 修改錯誤訊息顯示方式;修改回寫oha10機制
# Modify.........: No.TQC-750093 07/05/22 By Rayven 金額取位有問題
# Modify.........: No.TQC-760015 07/06/07 By Rayven oma04欄位取值按是否流通配銷處理
# Modify.........: No.MOD-760039 07/06/08 By Smapmin 已存在發票資料不可作廢
# Modify.........: No.MOD-760035 07/06/13 By Smapmin 修改update oga54
# Modify.........: No.MOD-760086 07/06/21 By Smapmin oga07='Y'可以在出貨單日期的隔月後立應收
# Modify.........: No.TQC-770008 07/07/02 By Judy 收款條件無控管
# Modify.........: No.MOD-760140 07/06/29 By Smapmin 輸入完客戶編號後,預設科目類別
# Modify.........: No.TQC-770025 07/07/04 By Rayven 帳款單別為無效時,錄入此單別無控管
#                                                   更改原幣的幣種后,直接點擊確定,本幣的立帳匯率改變,但本幣金額并未改變
#                                                   打印簡表客戶名稱欄位太短
#                                                   打印時選擇“應收憑單打印”，在打印結果中制表日期只有時間顯示，無日期顯示
# Modify.........: No.TQC-770025 07/07/04 By Rayven 帳款單別為無效時,錄入此單別無控管
# Modify.........: No.MOD-770142 07/07/30 By Smapmin 更改單身後,重新顯示未付金額
# Modify.........: No.TQC-780039 07/08/09 By Rayven 對訂單收尾款時，出貨單號欄位輸入值后會報錯(axr-953)
# Modify.........: No.MOD-780091 07/08/17 By Smapmin 開立發票時,發票匯率應依發票日更新
# Modify.........: No.CHI-780036 07/08/22 By Smapmin 修改set entry寫法
# Modify.........: No.MOD-790005 07/09/03 By Smapmin 刪除發票時,要將ogb60 update 為0
# Modify.........: No.MOD-790030 07/09/07 By Smapmin 銷退單號不為空時,才更新銷退檔
# Modify.........: No.CHI-790015 07/09/11 By Smapmin 帳款日期有更改時,應同時update匯率與金額
# Modify.........: No.TQC-790092 07/09/14 By rainy 修正Primary Key後, 程式判斷錯誤訊息時必須改變做法
# Modify.........: No.TQC-790124 07/09/24 By lumxa axrt300科目名稱只能顯示2個漢字（程序中大量使用g_buf和g_buf1變量，這2個變量是按單據別定義，長度太短，取科目名稱時使用這2個變量，導致科目名稱顯示只有2個漢字）
# Modify.........: No.TQC-790125 07/09/24 By wujie 搭增新增時預設為'N'
# Modify.........: No.TQC-790165 07/10/05 By Smapmin 單身連續輸入二筆時,當第二筆的數量為0未將金額清空
# Modify.........: No.TQC-7A0013 07/10/10 By dxfwo   報表改為CR報表               
# Modify.........: No.MOD-7A0066 07/10/19 By Smapmin 已有發票資料不可刪除單身
# Modify.........: No.TQC-7A0014 07/10/19 By Smapmin 單身修改各欄位金額時，沒有依幣別取位.
# Modify.........: No.MOD-7A0135 07/10/24 By Smapmin 已有發票資料不可作廢,需將已作廢發票排除
# Modify.........: No.MOD-7A0179 07/10/30 By smapmin cl_err3的第三個參數不可空白
# Modify.........: No.MOD-7B0011 07/11/05 By Smapmin 還原MOD-750142修改update oha10部份
#                                                    單身新增/刪除時增加update oha10  
# Modify.........: No.TQC-7B0035 07/11/06 By wujie   當客戶編號選擇MISC，客戶簡稱應可以修改，程序進入后錄入第一筆時，收款客戶簡稱可以修改，錄入第二筆時此欄位不能進入。
#                                                    已保存的雜項應收，修改單身稅前金額時報錯"axr-158搭贈金額必須為0"
#                                                    待扺衝帳，被衝帳款的omc13回寫錯誤，ln#12674
#                                                    LET l_omc.omc13 = l_omc.omc10 + g_oov_t.oov04  - g_oov[i].oov04
#                                                    應改為
#                                                    LET l_omc.omc13 = l_omc.omc13 + g_oov_t.oov04  - g_oov[i].oov04
# Modify.........: No.MOD-7B0071 07/11/08 By Smapmin omb39不可為NULL
# Modify.........: No.TQC-7B0043 07/11/12 By wujie   有直接收款的應收帳款，取消審核時，未更新omc13
#                                                    插入oob負項次不應放在產生分錄時做改，錄入第二筆時此欄位不能進入。
#                                                    單身修改時，修改單價或數量時，金額沒有重新計算
#                                                    有直接收款的帳款，日期修改時，生成的ooa_file的日期欄位沒有更新
#                                                    直接收款記錄刪除后，ooa_file仍然存在
# Modify.........: No.TQC-7B0062 07/11/13 By wujie   待扺衝帳畫面，當選擇衝多帳期帳款，會檢查金額是否超過整帳款未衝金額，但未按多帳期項次檢查，造成帳款的某帳期未衝金額可能衝成負數
# Modify.........: No.TQC-7B0092 07/11/15 By wujie   取消審核時應判斷帳款日期所在的會計期間及以后的會計期間是否存在調匯記錄。t300_z()中 #add by danny 020314 開頭的這一段須改寫
#                                                    本幣未收金額顯示有誤,FUNCTION t300_show_rec_amt()
#                                                    LET l_oma57_u = l_oma57_u + g_net
#                                                    應改為
#                                                    LET l_oma57_u = l_oma57_u - g_net
# Modify.........: No.TQC-7A0120 07/11/22 By chenl   1.update oga05/oga10,只判斷類別為12,并未判斷單身是出貨還是銷退,導致單身為銷退單時,仍會跑update oga05/oga10,而產生錯誤訊息
# Modify.........:                                   2.單身刪除銷退單時,由於 update oga 失敗,但程式仍會刪除成功
# Modify.........:                                   3.單身銷退單開窗應該要有資料視窗卻無資料
# Modify.........: No.TQC-790152 07/11/27 By chenl   當帳款類型為'12'，來源類型為'3'(銷退)時，增加對數量的判斷，不可大于銷退單數量。
# Modify.........: No.TQC-7B0107 07/11/29 By claire 直接收款/拋轉傳票/拋轉傳票還原 串EasyFlow簽核時應隱藏,(multi_account_period,FUN-680022再調整)
# Modify.........: No.TQC-7B0165 07/11/30 By xufeng 1.本位幣為RMB時,把單頭的幣種同原幣(USD)改為本位幣(RMB)時,本幣金額沒有隨之改變
#                                                   2.訂金直接收款(多帳期按比率收款方式),會回寫原幣的直接衝帳金額.
# Modify.........: No.MOD-7C0054 07/12/07 By wujie  TQC-7B0043有改錯，修正
# Modify.........: No.TQC-7C0048 07/12/06 By chenl  1.axrt300在新增時,若變更幣別,會詢問是否更新單身金額,但此時單身并未有資料,所以導致報錯!
#                                                   2.g_buf變量寬度太小，程序中大量使用該變量。
# Modify.........: No.MOD-7C0206 07/12/27 By Smapmin 補缺號時,要符合序時序號原則
# Modify.........: No.FUN-810046 08/01/15 By Johnray 增加串查段
# Modify.........: No.TQC-810075 08/01/24 by chenl  若有折扣率，則應該在單價處計算折扣后的單價。
# Modify.........: No.FUN-810045 08/01/29 by rainy 項目管理 單身新增項目代號(omb41)/WBS代號(omb42)
# Modify.........: No.MOD-810062 08/01/31 By Smapmin 合併開發票時,發票檔的帳款編號要清空,發票檔的金額要累加
# Modify.........: No.MOD-820007 08/03/03 By Smapmin oga00='6'也要可以維護
# Modify.........: No.MOD-820044 08/03/03 By Smapmin 確認時,發票待抵的金額未回寫至多帳期的已沖金額
# Modify.........: No.MOD-820032 08/03/03 By Smapmin informix locking cursor不可join二個table
# Modify.........: No.MOD-820113 08/03/04 By Smapmin 稅額修正時未做幣別位數取位
# Modify.........: No.MOD-820115 08/03/04 By Smapmin 稅額修正時,自動更新多帳期資料
# Modify.........: No.FUN-820072 08/03/04 By Smapmin 開帳時(雜項),INVOICE NO要可以輸入
# Modify.........: No.MOD-830052 08/03/07 By Smapmin 文件資料輸入後放棄,未將舊值備份起來
# Modify.........: No.TQC-830007 08/03/07 By claire 中斷點的AR應允許可以取消確認
# Modify.........: No.MOD-830043 08/03/07 By Smapmin 除了23.預收和24.暫收及31.非應收發票不能開票其他都應該可以開發票
# Modify.........: No.MOD-830082 08/03/11 By Smapmin 已開發票時,單身只能輸入科目 
# Modify.........: No.MOD-830119 08/03/17 By Smapmin 單頭會計科目未依照科目類別做預設
# Modify.........: No.FUN-830091 08/03/31 By Smapmin 增加多角分錄底稿
# Modify.........: No.TQC-840015 08/04/09 By hongmei 單身出貨單欄位增加判斷，oga65不能等于'Y' 
# Modify.........: No.MOD-840095 08/04/14 By Smapmin 修改理由碼來源
# Modify.........: No.MOD-840129 08/04/16 By Smapmin 若未確認即可開立發票,取消確認時不可擋已有發票資料存在
# Modify.........: No.CHI-810019 08/04/16 By Smapmin 票據系統立帳資料不可取消確認
# Modify.........: No.MOD-840253 08/04/20 By Dido    批次確認時單據開窗應為單據資料
# Modify.........: No.FUN-840213 08/04/25 By Carrier 加入"日期修正"功能
# Modify.........: No.MOD-840608 08/04/28 By hellen  拋磚憑証傳參給axrp590的修改
# Modify.........: No.FUN-850038 08/05/09 By TSD.Wind 自定欄位功能修改
# Modify.........: No.MOD-850184 08/05/23 By Sarah 程式裡CALL s_up_omb(g_oma.oma01)計算稅金額後,在CALL t300_ins_omc()前,需重抓一次g_oma變數
# Modify.........: No.MOD-850261 08/05/28 By Sarah 當oma65='2'時,不可修改單頭匯率
# Modify.........: No.FUN-850027 08/05/30 By douzh WBS編碼錄入時要求時尾階并且為成本對象的WBS編碼
# Modify.........: No.MOD-860078 08/06/10 by Yiting ON IDLE處理
# Modify.........: No.MOD-860075 08/06/10 By Carrier 直接拋轉總帳時，aba07(來源單號)沒有取得值
# Modify.........: No.MOD-860088 08/06/11 By Sarah AFTER FIELD oma68裡,錯誤訊息axr-601,axr-602,axr-603應要用oma68比對
# Modify.........: No.MOD-860152 08/06/17 By Sarah 當帳款類別為22.待抵時,科目類別所帶出來的會科,若單據別勾選【拋轉傳票】,應抓ool25
# Modify.........: No.MOD-860256 08/07/01 By Sarah AFTER FIELD oma03裡,錯誤訊息axr-601,axr-602,axr-603應要用oma68比對
# Modify.........: No.MOD-860185 08/07/01 By Sarah 確認段回寫待抵預付時,應以本次訂金金額寫入
# Modify.........: No.MOD-870146 08/07/21 By Smapmin 已有直接收款資料,不可作廢
# Modify.........: No.MOD-870209 08/07/21 By Smapmin omb38未給值
# Modify.........: No.MOD-870095 08/07/21 By Sarah 1.AFTER FIELD oma03,將FUN-670026增加有關抓oma68值的程式段,搬到前面IF g_oma.oma03 != 'MISC'段裡
#                                                  2.AFTER FIELD oma03,IF g_oma.oma04 != 'MISC' OR g_oma.oma04 IS NULL THEN裡改為LET g_oma.oma04 = g_oma.oma68
#                                                  3.AFTER FIELD oma10,判斷l_ome.ome04=g_oma.oma03應改為l_ome.ome04=g_oma.oma04
# Modify.........: No.MOD-870237 08/07/21 By Sarah 將l_wc,l_wc2,p_wc2改為STRING
# Modify.........: No.MOD-870253 08/07/21 By Sarah omb38的值只有1,2,3,4,5,99,將判斷01,02,03,04,05的部份修正
# Modify.........: No.TQC-860003 08/07/22 By lumx  刪除發票時,要將ohb60 update 為0
# Modify.........: No.MOD-870331 08/08/04 By Sarah 檢核aap-278時,分錄部份需排除匯差科目(ool52/ool521/ool53/ool531),帳款部分增加訂金金額(oma53)
# Modify.........: No.MOD-880213 08/08/27 By Sarah 將t300_i()段AFTER FIELD oma03裡,NEXT FIELD oma68這行mark掉,不然程式跑到這邊後面的程式段都不會進去
# Modify.........: No.TQC-880029 08/08/28 By chenl 對于同一張訂單，不可重復產生訂金應收單據。
# Modify.........: No.MOD-880253 08/08/29 By Sarah aza26='0'時(台灣版),發票號碼檢核長度需輸入10碼
# Modify.........: No.MOD-890148 08/09/16 By chenl 修正，當帳款類型為訂金時，對訂單單號(其他頁簽內)的判斷錯誤。
# Modify.........: No.MOD-890172 08/09/18 By chenl 將MOD-860152修改功能切分成大陸版和台灣地區版。
# Modify.........: No.MOD-890208 08/09/22 By chenl 增加對銷退單的管控，銷退單日期不可大于立賬日期。
# Modify.........: No.MOD-890215 08/10/01 By Sarah 當單身來源類型為3.銷退,選擇的銷退單其銷退方式為5.折讓時,金額直接帶銷退單的金額
# Modify.........: No.MOD-890292 08/10/01 By Sarah 大陸版單身來源為3.銷退,銷退單的銷退方式為5.折讓時,數量為0資料會存不進去
# Modify.........: No.MOD-8A0018 08/10/03 By Sarah 當oma20沒勾選,又按了"會計分錄產生"會沒有反應,增加提示訊息axr-176告知
# Modify.........: No.FUN-890128 08/10/07 By Vicky 確認段_chk()與異動資料_upd()若只需顯示提示訊息不可用cl_err()寫法,應改為cl_getmsg()
# Modify.........: No.MOD-8A0052 08/10/15 By Sarah 整張刪除或執行無效時,當oma00='12'回寫oga10時,抓取同一出貨單是否有已立帳,將前一張帳款編號回寫
# Modify.........: No.FUN-8A0086 08/10/21 By dongbg 修正FUN-710050錯誤
# Modify.........: No.MOD-8A0230 08/10/27 By sherry 增加oba111(銷貨收入科目二)，從oba_file帶出oba111到omb331  
# Modify.........: No.MOD-8B0041 08/11/05 By sherry 若已存在一張相同出貨單的請款單，單身的數量欄位帶出的值不對
# Modify.........: No.FUN-8A0075 08/11/05 By jan S.送簽時，可再修改以下內容：單頭：oma18、oma181、oma13。/ 單身：omb33、omb331
#                                                并可執行以下功能：【分錄底稿產生、分錄底稿、傳票拋轉、傳票拋轉還原、發票開立、發票維護、文件資料、其他資料、確認】
# Modify.........: No.TQC-8B0022 08/11/12 By Sarah 將t300_s1()段UPDATE oma_file程式段移到此FUNCTION最後才做
# Modify.........: No.MOD-8B0127 08/11/13 By chenl 對MOD-890208進行調整。單身判斷銷退應采用omb38，來源類型來判斷。
# Modify.........: No.TQC-8C0001 08/12/03 By claire 中斷點的單據可以取消確認
# Modify.........: No.MOD-8C0018 08/12/03 By Sarah 當發票未開立時,出示警告視窗詢問USER是否同步更新發票匯率
# Modify.........: No.MOD-8C0141 08/12/15 By Sarah 修正MOD-8A0052,當m_oma01,m_oma05為null,保持原值,不需給予' '值
# Modify.........: No.MOD-8C0192 08/12/22 By Sarah 當ooz65為Y時,在單身輸入銷退單時,需檢查銷退單+項次其數量是否已全數立帳,若是則不可再輸入
# Modify.........: No.MOD-8C0223 08/12/29 By Sarah t300_y_upd()段,檢查單頭金額與分錄金額是否相符,抓分錄時應過濾npq00=2
# Modify.........: No.FUN-8C0089 08/12/31 By jamie 依參數控管,檢查會科/部門/成本中心 AFTER FIELD 
# Modify.........: No.MOD-910093 09/01/12 By wujie 增加oma08=3的情況，同oma08=2處理
# Modify.........: No.MOD-910250 09/02/03 By Sarah CALL axrp590時,user應傳g_oma.omauser(參考5X TQC- 8 10036)
# Modify.........: No.MOD-920035 09/02/03 By Sarah AFTER FIELD oma18/oma181/omb33/omb331段判斷輸入科目有否存在aag_file時,增加aag07 IN ('2','3')條件
# Modify.........: No.MOD-920038 09/02/03 By Sarah FUNCTION t300_g_guino()若遇錯需RETURN時皆需回傳1
# Modify.........: No.MOD-920110 09/02/07 By Sarah 當oma00為1*時,應取借方金額總和-借方匯兌損益金額,來跟oma比對,oma00為2*時應抓貸方
# Modify.........: No.MOD-920136 09/02/10 By Sarah t300_omc_check()段,應將l_amtf<=l_omc[l_cnt].omc08裡的EXIT FOREACH拿掉,否則多帳期資料若有多筆時,只會UPDATE第一筆
# Modify.........: No.MOD-920134 09/02/10 By Sarah t300_multi_account()段,離開多帳期時需檢查多帳期合計金額應等於帳款金額
# Modify.........: No.MOD-920162 09/02/16 By Sarah 發票開立時，沒有控卡發票別
# Modify.........: No.FUN-920166 09/02/20 By alex g_dbs2改為使用s_dbstring
# Modify.........: No.MOD-920296 09/02/23 By chenl 審核時，增加對單身單據的判斷，需確定單身中的單據都必須存在。
# Modify.........: No.MOD-920356 09/02/26 By Sarah t300_b()段詢問是否產生分錄底稿,不需判斷g_v0
# Modify.........: No.MOD-920343 09/02/27 By chenl 拋轉憑証時，若存在多角貿易序號，則憑証人員放開限制。
# Modify.........: No.TQC-930154 09/03/27 By chenl 修正部門輸入錯誤后，不報錯的問題。
# Modify.........: No.TQC-930151 09/03/27 By chenl 單身科目加入限制條件，aag03='2'
# Modify.........: No.FUN-830163 09/04/03 By Cockroach mark cl_outnam()       
# Modify.........: No.MOD-940065 09/04/07 By lilingyu misc 改成g_oma.oma03
# Modify.........: No.MOD-940069 09/04/08 By lilingyu mark ooygclr
# Modify.........: No.MOD-940153 09/04/10 By Dido 訊息代碼修改
# Modify.........: No.MOD-940155 09/04/11 By Sarah 1.t300_b()段,要檢查l_oha09前都要再重抓值
#                                                  2.需判斷oha09!='5'時才檢查axr-390
#                                                  3.t300_chk_ohb()段,若應以單身omb31重抓oha09來檢查,不要用g_oma.oma34檢查
# Modify.........: No.MOD-940200 09/04/14 By chenl 紅衝待扺單判斷調整。
# Modify.........: No.MOD-940226 09/04/16 By lilingyu 增加oma00='12'且oma19<>''時的金額檢查
# Modify.........: No.FUN-910091 09/04/21 By jan 新增"打印折讓單" ACTION    
# Modify.........: No.TQC-940041 09/04/27 By chenl 修正開立發票時，卡"發票未符合序時序號原則!"的錯誤。
# Modify.........: No.MOD-940419 09/05/05 By lilingyu t300_d_c CURSOR需區分oma00的不同取值情況
# Modify.........: No.MOD-950088 09/05/11 By xiaofeizhu 修改l_oma57_u的值
# Modify.........: No.TQC-950148 09/05/27 By xiaofeizhu 增加對部門欄位的管控
# Modify.........: No.MOD-950311 09/05/31 By xiaofeizhu 只有在流通配銷系統勾選時,維護應收時才會check 單頭收款客戶與oha1001一致
# Modify.........: No.MOD-960051 09/06/04 By baofei CALL axrr301時，第10個參數default為Y                                            
# Modify.........: No.MOD-960099 09/06/06 By Sarah 刪除單身時會回寫出貨/銷退單單頭的帳款編號,當更新失敗時,整個刪除動作應該ROLLBACK WORK
# Modify.........: No.MOD-960105 09/06/08 By baofei 修改做客戶簽收的出貨單可立帳成功                                                
# Modify.........: No.MOD-960116 09/06/10 By baofei 多帳期維護時，若金額不同選者重新產生，omc_file會刪除無法重新產生  
# Modify.........: No.TQC-960170 09/06/16 By xiaofeizhu 修改點擊發票開立功能鈕，進入發票資訊頁簽，未維護發票別，發票號碼，點退出則無法退出的問題
# Modify.........: No.FUN-960141 09/06/26 By dongbg GP5.2修改:s_t300_gl個的建臨時表放到主程序內
# Modify.........: No.FUN-960140 09/07/08 By lutingting GP5.2修改
# Modify.........: No.MOD-970074 09/07/09 By mike 判斷IF p_cmd='u' AND g_oma.oma21 != old_oma21 THEN改成IF p_cmd='u' AND g_oma.oma21
#                                                 AFTER FIELD oma21最后的LET old_oma21=g_oma.oma21需mark,改成LET g_oma_o.oma21=g_oma
# Modify.........: No.MOD-970130 09/07/15 By mike 修改axrt300.4gl,發票資訊頁簽里的"發票客戶簡稱"改成"發票客戶全名",4fd檔occ02改成occ
#                                                 若發票號碼(oma10)欄位為Null時,改顯示occ18,若發票號碼(oma10)欄位有值時,改顯示ome043
# Modify.........: No.MOD-980024 09/08/10 By Dido axr-373 應區分出貨或銷退抓取不同檔案
# Modify.........: No.TQC-970154 09/07/17 By Carrier 拋轉傳票判斷修改
# Modify.........: No.MOD-970296 09/08/04 By Sarah 有UPDATE omc09的地方,也要一起UPDATE omc13
# Modify.........: No.FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.TQC-960415 09/08/19 By destiny 原因碼新增時可開窗 
# Modify.........: No.MOD-960045 09/08/22 By Smapmin 若有不折讓不換貨的銷退單透過axrp310產生帳款時,作廢/刪除時必須將銷退單的帳款編號清空
# Modify.........: NO.FUN-910074 09/09/01 BY hongmei FUN-8A0075內容因SOP修改一同異動
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: NO.MOD-990035 09/09/03 By sherry 單身既有銷退單又有出貨單時，刪除整張單，需UPDATE oha10 
# Modify.........: No.FUN-960038 09/09/04 By chenmoyan 專案加上'結案'的判斷
# Modify.........: No.FUN-980020 09/09/17 By douzh 加上GP5.2的相關設定
# Modify.........: No.FUN-990069 09/09/27 By baofei 修改GP5.2的相關設定
# Modify.........: NO.FUN-970108 09/08/20 By hongmei add oma71申報統編
# Modify.........: No.MOD-990153 09/09/15 By Sarah 當整張刪除時會一併刪除發票,刪完需回寫oom09(已開發票號),目前程式寫法造成無窮迴圈
# Modify.........: No.FUN-990017 09/10/14 By Carrier 去掉 "待扺衝帳"功能
# Modify.........: No.FUN-970121 09/10/21 By sabrina 將oma16的串查功能移除，並增加一個action，依oma00的值連結到該支程式作業 
# Modify.........: No:FUN-990031 09/10/27 By lutingting单身新增omb44其他栏位如参考单号等依照门店编号过滤 
# Modify.........: No.FUN-9A0093 09/10/29 By lutingting 将FUN-990031 拆单处理
# Modify.........: No:CHI-9A0041 09/10/30 By mike FUNCTION t300_x(),在此FUNCTION一开始的资料检核段,增加检核当g_oma.omavoid='Y'(已经>
#                                                 取消作废前要检核前端单据是否已作废,若已作废就不可取消作废                         
# Modify.........: No.FUN-9B0044 09/11/06 By wujie   5.2SQL转标准语法
# Modify.........: No.MOD-9B0043 09/11/09 By lutingting 取消原本對單頭營運中心oma66得不可錄入控管
# Modify.........: No:MOD-9B0052 09/11/09 By Smapmin 修正MOD-990035
# Modify.........: No:MOD-9B0074 09/11/19 By Sarah 重新產生多帳期資料後沒有更新到oma_file的應收款日
# Modify.........: No:MOD-9B0159 09/11/24 By Sarah 執行"日期修正"後更改了應收款日,應一併更新多帳期裡的應收款日
# Modify.........: No:FUN-9C0013 09/12/03 By lutingting 單身加了來源營運中心.但是有些欄位仍然沒有跨庫處理
# Modify.........: No:FUN-9C0014 09/12/08 By shiwuying axrp310跨庫處理,sub加參數;增加跨庫處理邏輯
# Modify.........: No:MOD-9C0084 09/12/08 By Sarah oma69的給值應與oma32無關
# Modify.........: No:MOD-9C0075 09/12/09 By Sarah 若是輸入雜項應收,輸入完客戶後帶出occ04->oma14,再依人員帶出其部門gen03->oma15
# Modify.........: No.FUN-9C0041 09/12/14 By lutingting 審核時對前段訂單出貨單得處理需要跨庫,跨库选前端资料时用实体DB
# Modify.........: No:MOD-9C0124 09/12/14 By Sarah "來源單據查詢"應視行業別串不同的程式代號
# Modify.........: No.TQC-9C0099 09/12/17 By jan s_rdatem 參數調整
# Modify.........: No:FUN-990053 09/09/16 By hongmei s_chkban前先检查aza21 = 'Y'  
# Modify.........: No:MOD-9C0164 09/12/18 By Sarah 回寫來源單據的帳款編號與發票別時,若抓不到最後一張帳款編號可回寫,發票別就維持原值不需清空
# Modify.........: No:MOD-9C0409 09/12/25 By Dido 發票維護後應可重新產生 omc_file 
# Modify.........: No:MOD-9C0410 09/12/25 By Dido 折讓不應計算 oma11,oma12  
# Modify.........: No.FUN-9C0072 10/01/07 By vealxu 精簡程式碼
# Modify.........: No.MOD-A10050 10/01/12 By liuxqa 删除账款时，未针对一对多的情况更新Update Oga60.
# Modify.........: No:FUN-A10104 10/01/20 By shiwuying 傳參修改
# Modify.........: No.MOD-A20104 10/02/25 by sabrina 調整MOD-940155
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No.FUN-A30106 10/03/30 by wujie   增加凭证联查功能
# Modify.........: No:MOD-A40078 10/04/19 By Smapmin 多角貿易帳款必須要由批次整批產生,不能由各站自已登打(中斷點除外)
# Modify.........: No:TQC-A40100 10/04/21 By xiaofeizhu Â¶µ3¦¬®É"°Ѧҳ渹"Ä¦ì¤£¤¹³\¶}µ¡
# Modify.........: No:FUN-A40054 10/05/06 By shiwuying 
# Modify.........: No:TQC-A50022 10/05/06 By lilingyu "资料来源营运中心oma66"移到"客户编号"上面
# Modify.........: No:MOD-A50077 10/05/12 By sabrina 大陸帳務待客戶驗收後才開立發票，且大陸在發票開立上並未控管一定要序時序號
# Modify.........: NO.CHI-A20013 10/05/12 by sabrina 外銷開立發票(影響媒體申報擷取方式)(ooz64='N'),且外銷(oma08='2')
# Modify.........: No:MOD-A50108 10/05/19 By sabrina oga00應要加入"B.借貨償價"的類別 
# Modify.........: No:TQC-A40140 10/05/19 By xiaofeizhu 單別勾選“紅沖”功能不涉及銀行存款，僅應收和銷售收入為負數， 應該不提供“直接收款”的功能
# Modify.........: No:TQC-A50118 10/04/29 By xiaofeizhu 手動新增折讓賬款單，單身對銷退方式為“不折讓”的銷退單據未過濾， 仍然可以手動新增不折讓銷退單的折讓賬款資料，應控卡
# Modify.........: No:TQC-A50116 10/05/21 By houlia 銷退單轉立折讓應收后，刪除該賬款資料，同時清空oha10“帳單編號”欄位
# Modify.........: No:FUN-A40076 10/05/21 By xiaofeizhu oma70的判斷處，去除azw04的判斷. 
# Modify.........: No:CHI-A50040 10/06/02 By Dido 尾款改由訂單來源 
# Modify.........: No:FUN-A50103 10/06/03 By Nicola 訂單多帳期 add oma165 
# Modify.........: No:MOD-A60017 10/06/04 By Dido 銷退金額抓取增加確認碼 
# Modify.........: No:MOD-A60076 10/06/10 By Dido 發票刪除時檢核發票最大號不須排除作廢資料 
# Modify.........: No.MOD-A60103 10/06/15 By Dido 科目類別請先給客戶慣用科目類別occ67,否則再帶ooz08 
# Modify.........: No.FUN-A50102 10/07/06 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:CHI-A70015 10/07/06 By Nicola 需考慮無訂單出貨
# Modify.........: No.FUN-A60056 10/07/09 By lutingting GP5.2財務串前段問題整批調整
# Modify.........: No:MOD-A70191 10/07/27 By Dido 調整訊息axr-164提示位置,將原 s_ar_upinv 位置移至此處理 
# Modify.........: No:MOD-A70194 10/07/27 By Dido 無訂單出貨應與原出貨計算相同 
# Modify.........: No:MOD-A80073 10/08/10 By Dido 訊息 axr-390 檢核邏輯調整 
# Modify.........: No.FUN-810070 10/08/13 By vealxu 作廢及取消作廢同一個功能鍵
# Modify.........: No.CHI-920009 10/08/16 By vealxu 產生分錄底稿時借貸相同的問題; 抓會科方式不再分為大陸版和臺灣版
# Modify.........: No.FUN-9A0036 10/08/18 By chenmoyan 二套帳時,第二分錄金額本幣金額應再乘上匯率
# Modify.........: No.FUN-A60007 10/08/18 By chenmoyan 1.確認時比較帳款是否平衡不需要再換算匯率
#                                                      2.輸入完分錄之後,要依axmi1101設定遞延收入科目check分錄中的科目金額INSERT oct_file
# Modify.........: No:MOD-A80138 10/08/19 By Dido 檢核金額若讀取不到應清為 0 
# Modify.........: No:MOD-A80163 10/08/23 By Dido 確認段檢核銷退立帳重複時條件應調整為大於 
# Modify.........: No:CHI-A70028 10/08/26 By Summer 寫入ome_file時需同步增加寫入到發票與帳款對照檔(omee_file)
# Modify.........: No.MOD-A90001 10/09/01 By Carrier 单向分录时,若出现分录值为负数,审核会报aap-278的错误
# Modify.........: No.MOD-A90003 10/09/01 By wujie   红冲审核时，分录底稿金额取正数与单头金额比较
# Modify.........: No:MOD-A90150 10/09/23 By Dido 出口報單號碼需檢核是否為 14碼 
# Modify.........: No:MOD-A90154 10/09/23 By Dido 折讓銷退不可重複立帳 
# Modify.........: No:CHI-A80031 10/09/27 By Summer 整批確認時,其他單號的資料也需檢查 
# Modify.........: No.MOD-A10141 10/09/28 By sabrina 當為14類帳款時，單身的omb04與omb06要可以輸入
# Modify.........: No:CHI-A80056 10/09/23 By Summer 增加一個ACTION"多角Invoice No修改"
# Modify.........: No:MOD-AA0044 10/10/11 By Dido 檢核發票重複問題 
# Modify.........: No:CHI-A90023 10/10/13 By Summer 來源單號查詢改用單身的單號串查
# Modify.........: No:MOD-AA0149 10/10/25 By Dido 取消 smu_file/smv_file 檢核,已於 s_auto_assign_no 處理 
# Modify.........: No:MOD-AA0153 10/10/26 By Dido 檢核發票開立時發票別不可為空 
# Modify.........: No:MOD-AA0185 10/10/29 By Dido 若客戶為 MISC 則 oma042/oma044 預設值調整為 occm02/occm04 
# Modify.........: No:MOD-AB0025 10/11/02 By Dido oma16 輸入後由於改變 oma23 應重新取 azi_file 
# Modify.........: No:CHI-AB0001 10/11/04 By Summer 列印(簡表)應要出現查詢後的所有單據資料 
# Modify.........: No:MOD-AB0101 10/11/11 By Dido SUM ogb14 應以出貨單為主;SUM omb16 應排除作廢部分 
# Modify.........: No:MOD-AB0164 10/11/17 By Dido oga71 需新增至 oma71 
# Modify.........: No:TQC-AB0056 10/11/17 By Dido 作廢還原應檢核是否已存在其他應收帳款中 
# Modify.........: No:MOD-AB0174 10/11/17 By Dido 單別若為紅沖時,分錄金額檢核需 * -1 
# Modify.........: No:MOD-AB0199 10/11/22 By Dido 產生分錄時增加訊息提示 
# Modify.........: No:MOD-AB0216 10/11/24 By Dido 出貨單回寫 oga10 調整
# Modify.........: No:TQC-AB0075 10/11/24 By Dido 合併開立發票無須重編發票號碼 
# Modify.........: No.TQC-AB0228 10/11/30 By lixia 來源為出貨或銷退時，單號為必輸項
# Modify.........: No:FUN-AB0034 10/12/02 By wujie  流通财务改善
# Modify.........: NO.MOD-AC0033 10/12/07 BY Dido 檢核 aap-278 若為出貨待驗時,無須增加 oma53預收金額,因分錄並不存在預收科目 
# Modify.........: NO.MOD-AC0127 10/12/17 BY Dido 若已有收款不可修改日期 
# Modify.........: NO.MOD-AC0233 10/12/20 BY Dido FOREACH 增加 STATUS 判斷 
# Modify.........: No.MOD-AC0395 10/12/29 By Carrier chk_oma66中occacti接错变量
# Modify.........: No.MOD-AC0265 11/01/05 By Summer 1.當人員、客戶編號、收款客戶未異動時,不可影響部門欄位
#                                                   2.點選action【多帳期維護】進入修改並存檔後, 無法關閉視窗
# Modify.........: No:CHI-AC0046 11/01/05 By Summer 確認時若碰到應收金額=0的資料,增加詢問"應收金額為0,是否確定執行確認(Y/N)?"
# Modify.........: No:MOD-B10011 11/01/04 By Dido control + o 帶出後無法直接儲存 
# Modify.........: No:MOD-B10012 11/01/04 By Dido 超交需增加訂單項次條件 
# Modify.........: No:TQC-B10014 11/01/10 By Dido 若收款條件有異動才需檢核 
# Modify.........: No:TQC-B10142 11/01/14 By Carrier 审核时,第二帐套出现aap-278的错误,原因第二帐套的帐套币种和记帐本位币不一样时,npq07值为第二帐套的本币金额,若和当前记帐本位币种单头的金额做比较没有意义
# Modify.........: No.FUN-AB0110 11/01/24 By chenmoyan 自動產生應收且自動確認時,先判斷是否產生遞延收入檔再做確認
# Modify.........: No.FUN-B10053 11/01/26 By yinhy 科目查询自动过滤
# Modify.........: No.FUN-B10058 11/01/25 By lutingting 流通财务改善
# Modify.........: No:CHI-B10042 11/02/09 By Summer 將upd()段判斷狀況碼要為1.已核准才可以確認的段落往上搬到chk()段 
# Modify.........:               11/02/09 By chenmoyan 因FUN-B10058先行過單,MARK FUN-AB0110
# Modify.........: No.MOD-B20038 11/02/12 By lutingtig删除时前段账款编号更新有误
# Modify.........: No:MOD-B20044 11/02/15 By Dido 1.若ooz65='Y'時 omb31 輸入前需檢核 omb38 是否有值 
#                                                 2.omb40預設值;折讓銷退金額問題
# Modify.........: No:TQC-B20065 11/02/16 By elva 来源单号查询新增oma00=15/17/18/19/28类型
# Modify.........: No:TQC-B20096 11/02/17 By zhangll 发票号码显示异常调整
# Modify.........: No:FUN-B20059 11/02/22 By wujie  科目自动开窗hard code修改
# Modify.........: No:MOD-B30086 11/03/10 By Sarah 修正FUN-9C0014,在t300_y0()增加omb44時放錯位置
# Modify.........: No:MOD-B30597 11/03/18 By Sarah 當oma59t為0時,提示訊息"發票金額為0,不可產生發票資料!",且不產生ome_file資料
# Modify.........: No:MOD-B30601 11/03/18 By Sarah 單別為不產生分錄的單據無法確認
# Modify.........: No:MOD-B30656 11/03/23 By Dido 訊息 axr-263 如為折讓時應於新增才需檢核 
# Modify.........: No:MOD-B30690 11/03/29 By Dido 多帳期回沖時,若第一筆未沖完不可更新第二筆 
# Modify.........: No:CHI-B30042 11/03/30 By huangrh 當aoos010勾選流通參數時,隱藏oma00 屬於下列的屬性15/17/18/26/27
# Modify.........: No:MOD-B30709 11/03/30 By Dido 第二套帳帳款與分錄比較應以第二套帳使用幣別比較 
# Modify.........: No:TQC-B30218 11/03/31 By yinhy 發票開立,發票維護時,不需判斷gec05 是否為 'A'
# Modify.........: No:MOD-B40025 11/04/07 By Dido 匯率變更不需限定更新時才要連動其他欄位 
# Modify.........: No:TQC-B40042 11/04/08 By yinhy aza50='N'時，隱藏oma00屬於下列的屬性15/17/18/26/27
# Modify.........: No:TQC-B40067 11/04/11 By yinhy  s_chkban前先检查aza21 = 'Y'  
# Modify.........: No:MOD-B40084 11/04/12 By wujie  r()中将oha10误写成oga10            
# Modify.........: No:FUN-B40032 11/04/19 By baogc 新增"實際交易稅別明細"和"單身稅別明細"的ACTION,修改來源類型為POS交易時的邏輯
# Modify.........: No:MOD-B40217 11/04/25 By Dido 開立發票時檢核發票聯數若為空則提示警訊 
# Modify.........: No:MOD-B40264 11/04/29 By Dido 開立發票無須重新產生 omc_file,僅更新omc12即可 
# Modify.........: No:TQC-B40172 11/05/05 By yinhy 修正TQC-B40042,應判定azw04<>2
# Modify.........: No:MOD-B50043 11/05/06 By destiny 未超交时单头金额计算错误
# Modify.........: No:FUN-B40056 11/05/12 By guoch 刪除資料時一併刪除tic_file的資料
# Modify.........: No.MOD-B50216 11/05/25 By Dido 超交出貨金額計算與過濾條件調整;過濾作廢條件 
# Modify.........: No.MOD-B50230 11/05/26 By Dido 計算訂單數量取消項次,依整張訂單數量比對給予訂金金額 
# Modify.........: No.MOD-B50234 11/05/27 By Dido 取消作廢時,如為出貨且有銷退時應也要更新oha10 
# Modify.........: No.FUN-B50170 11/05/31 By baogc 添加當來源類型為POS交易時的控管
# Modify.........: No.FUN-B50090 11/06/01 By suncx 財務關帳日期加嚴控管修正
# Modify.........: No.MOD-B60021 11/06/03 By Dido 匯率修改時,發票金額應重新給予
# Modify.........: No.MOD-B60023 11/06/03 By Dido 稅額修正時,應以 oma213 判斷處理 
# Modify.........: No.FUN-B50064 11/06/03 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.MOD-B60059 11/06/08 By Dido 次帳別檢核分錄不須乘算匯率 
# Modify.........: No.TQC-B10201 11/06/10 By Dido 調整 sel_oga_cs71 計數問題 
# Modify.........: No.MOD-B60081 11/06/10 By Dido 取消發票匯率異動重取匯率問題,因為發票金額須以實際出貨匯率開立發票 
# Modify.........: No.TQC-B60089 11/06/15 By Dido 1.修改單頭時,若有呼叫 t300_bu 則需抓取 ogb_file 資料 
#                                                 2.出貨原幣一律採用倒扣計算,本幣金額依原幣與匯率乘算即可
# Modify.........: No.TQC-B60312 11/06/23 By zhangweib 修改單頭資料時,若成本中心(oma930)已經有值,不應該再用LET g_oma.oma930=s_costcenter(g_oma.oma15)重取值
# Modify.........: No:110927     11/09/27 By yangjian 数据权限管控
# Modify.........: No.CHI-B90025 11/09/28 By Polly 程式梳理專案，將計算單身至單頭的程式段合併成一隻
# Modify.........:               12/05/29 by shenrr 增加冲账按钮
# Modify.........: No.FUN-C60033 12/07/02 By minpp  ooz32='N'且大陆版时，发票别，发票号码+发票代码不需要check
# Modify.........: No.FUN-C60033 12/07/03 By xuxz 添加更新omf_file的資料

DATABASE ds
 
#GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"   #modify by zhangym 110906
 
#模組變數(Module Variables)
DEFINE g_tt                 LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
       g_oma                RECORD LIKE oma_file.*,
       m_oma                RECORD LIKE oma_file.*,   #FUN-530061
       b_oma                RECORD LIKE oma_file.*,
       g_oma_t              RECORD LIKE oma_file.*,
       g_oma_o              RECORD LIKE oma_file.*,
       g_oma01_t            LIKE oma_file.oma01,   #(舊值) #CHI-A80031 add
       b_omb                RECORD LIKE omb_file.*,
       g_omb                DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
                               omb03     LIKE omb_file.omb03,
                               omb38     LIKE omb_file.omb38, #No.FUN-670026 --add
                               omb44     LIKE omb_file.omb44, #FUN-990031 add
                               omb31     LIKE omb_file.omb31,
                               omb32     LIKE omb_file.omb32,
                               omb39     LIKE omb_file.omb39, #No.FUN-670026 --add
                               omb04     LIKE omb_file.omb04,
                               omb06     LIKE omb_file.omb06,
#No.FUN-AB0034 --begin
                               omb45     LIKE omb_file.omb45,
                               omb47     LIKE omb_file.omb47,
#No.FUN-AB0034 --end
                               omb40     LIKE omb_file.omb40,  #No.FUN-660073
                               omb05     LIKE omb_file.omb05,
                               omb12     LIKE omb_file.omb12,
                               omb41     LIKE omb_file.omb41, #專案代號
                               omb42     LIKE omb_file.omb42, #WBS
                               omb33     LIKE omb_file.omb33,
                               omb331    LIKE omb_file.omb331, #FUN-670047
                               omb13     LIKE omb_file.omb13,
                               omb14     LIKE omb_file.omb14,
                               omb14t    LIKE omb_file.omb14t,
                               omb15     LIKE omb_file.omb15,
                               omb16     LIKE omb_file.omb16,
                               omb16t    LIKE omb_file.omb16t,
                               omb17     LIKE omb_file.omb17,
                               omb18     LIKE omb_file.omb18,
                               omb18t    LIKE omb_file.omb18t,
                               omb930    LIKE omb_file.omb930, #FUN-680001
                               gem02c    LIKE gem_file.gem02,  #FUN-680001
                               ombud01 LIKE omb_file.ombud01,
                               ombud02 LIKE omb_file.ombud02,
                               ombud03 LIKE omb_file.ombud03,
                               ombud04 LIKE omb_file.ombud04,
                               ombud05 LIKE omb_file.ombud05,
                               ombud06 LIKE omb_file.ombud06,
                               ombud07 LIKE omb_file.ombud07,
                               ombud08 LIKE omb_file.ombud08,
                               ombud09 LIKE omb_file.ombud09,
                               ombud10 LIKE omb_file.ombud10,
                               ombud11 LIKE omb_file.ombud11,
                               ombud12 LIKE omb_file.ombud12,
                               ombud13 LIKE omb_file.ombud13,
                               ombud14 LIKE omb_file.ombud14,
                               ombud15 LIKE omb_file.ombud15
                            END RECORD,
       g_omb_t              RECORD
                               omb03     LIKE omb_file.omb03,
                               omb38     LIKE omb_file.omb38, #No.FUN-670026 --add
                               omb44     LIKE omb_file.omb44, #FUN-990031 add
                               omb31     LIKE omb_file.omb31,
                               omb32     LIKE omb_file.omb32,
                               omb39     LIKE omb_file.omb39, #No.FUN-670026 --add
                               omb04     LIKE omb_file.omb04,
                               omb06     LIKE omb_file.omb06,
#No.FUN-AB0034 --begin
                               omb45     LIKE omb_file.omb45,
                               omb47     LIKE omb_file.omb47,
#No.FUN-AB0034 --end
                               omb40     LIKE omb_file.omb40,  #No.FUN-660073
                               omb05     LIKE omb_file.omb05,
                               omb12     LIKE omb_file.omb12,
                               omb41     LIKE omb_file.omb41, #專案代號
                               omb42     LIKE omb_file.omb42, #WBS
                               omb33     LIKE omb_file.omb33,
                               omb331    LIKE omb_file.omb331, #FUN-670047
                               omb13     LIKE omb_file.omb13,
                               omb14     LIKE omb_file.omb14,
                               omb14t    LIKE omb_file.omb14t,
                               omb15     LIKE omb_file.omb15,
                               omb16     LIKE omb_file.omb16,
                               omb16t    LIKE omb_file.omb16t,
                               omb17     LIKE omb_file.omb17,
                               omb18     LIKE omb_file.omb18,
                               omb18t    LIKE omb_file.omb18t,
                               omb930    LIKE omb_file.omb930, #FUN-680001
                               gem02c    LIKE gem_file.gem02,  #FUN-680001
                               ombud01 LIKE omb_file.ombud01,
                               ombud02 LIKE omb_file.ombud02,
                               ombud03 LIKE omb_file.ombud03,
                               ombud04 LIKE omb_file.ombud04,
                               ombud05 LIKE omb_file.ombud05,
                               ombud06 LIKE omb_file.ombud06,
                               ombud07 LIKE omb_file.ombud07,
                               ombud08 LIKE omb_file.ombud08,
                               ombud09 LIKE omb_file.ombud09,
                               ombud10 LIKE omb_file.ombud10,
                               ombud11 LIKE omb_file.ombud11,
                               ombud12 LIKE omb_file.ombud12,
                               ombud13 LIKE omb_file.ombud13,
                               ombud14 LIKE omb_file.ombud14,
                               ombud15 LIKE omb_file.ombud15
                            END RECORD,
       g_oga                RECORD LIKE oga_file.*,
       g_ogb                RECORD LIKE ogb_file.*,
       g_ogb_o              RECORD LIKE ogb_file.*,    #TQC-B60089
       g_oea                RECORD LIKE oea_file.*,
       g_oeaa               RECORD LIKE oeaa_file.*,    #No:FUN-A50103
       g_oeb                RECORD LIKE oeb_file.*,
       g_oha                RECORD LIKE oha_file.*,
       g_ohb                RECORD LIKE ohb_file.*,
       t_omb                RECORD LIKE omb_file.*,
       g_oar                RECORD LIKE oar_file.*,
       g_gec                RECORD LIKE gec_file.*,
       g_oga909             LIKE oga_file.oga909,      #三角貿易否
       l_ohb14t             LIKE ohb_file.ohb14t,
       l_ohb14              LIKE ohb_file.ohb14,
       g_ohb14              LIKE ohb_file.ohb14,
       g_ohb14t             LIKE ohb_file.ohb14t,
       g_ohb14_1            LIKE ohb_file.ohb14,
       g_ohb14t_1           LIKE ohb_file.ohb14t,
       l_ohb12              LIKE ohb_file.ohb12,
       g_ohb12              LIKE ohb_file.ohb12,
       g_ohb12_1            LIKE ohb_file.ohb12,
       l_ohb917             LIKE ohb_file.ohb917,   #FUN-560070
       g_ohb917             LIKE ohb_file.ohb917,   #FUN-560070
       g_ohb917_1           LIKE ohb_file.ohb917,   #FUN-560070
       g_ogb12              LIKE ogb_file.ogb12,
       g_ogb12_1            LIKE ogb_file.ogb12,
       g_ogb917             LIKE ogb_file.ogb917,   #FUN-560070
       g_ogb917_1           LIKE ogb_file.ogb917,   #FUN-560070
       l_omb12              LIKE omb_file.omb12,
       g_omb12_n            LIKE omb_file.omb12,
       g_omb12_b            LIKE omb_file.omb12,
       g_omb12              LIKE omb_file.omb12,
       g_omb14t             LIKE omb_file.omb14t,
       g_omb14t_n           LIKE omb_file.omb14t,
       g_omb14t_b           LIKE omb_file.omb14t,
       g_omb14              LIKE omb_file.omb14,
       g_omb14_n            LIKE omb_file.omb14,
       g_omb14_b            LIKE omb_file.omb14,
       l_omb14t             LIKE omb_file.omb14t,
       l_omb14              LIKE omb_file.omb14,
       l_oma53              LIKE oma_file.oma53,
       l_oma56              LIKE oma_file.oma56,
       l_oma56x             LIKE oma_file.oma56x,
       l_oma56t             LIKE oma_file.oma56t,
       m_oma01              LIKE oma_file.oma01,          #MOD-8A0052 add
       m_oma05              LIKE oma_file.oma05,          #MOD-8A0052 add
       m_omb31              LIKE omb_file.omb31,          #MOD-8A0052 add
       g_amt1f,g_amt2f,g_amt3f  LIKE type_file.num20_6,   #No.FUN-680123 DEC(20,6),  #FUN-590100
       g_amt1,g_amt2,g_amt3     LIKE type_file.num20_6,   #No.FUN-680123 DEC(20,6),  #FUN-590100
       g_unikey             LIKE type_file.chr1,          #No.FUN-680123 VARCHAR(1),
       l_msg1,l_msg2,l_msg3 LIKE type_file.chr1000,       #No.FUN-680123 VARCHAR(40),
       g_msg1               LIKE type_file.chr1000,       #No.FUN-680123 VARCHAR(100),
       g_flag               LIKE type_file.chr1,          #No.FUN-680123 VARCHAR(01),
       g_wc,g_wc2,g_sql     STRING,                       #No.FUN-580092 HCN
       g_t1                 LIKE ooy_file.ooyslip,        #No.FUN-680123 VARCHAR(5),  #No.FUN-550071
       g_buf                LIKE oay_file.oayslip,        #No.FUN-680123 VARCHAR(20),
       g_buf1               LIKE oay_file.oayslip,        #No.FUN-680123 VARCHAR(20), #FUN-670047
       g_oay11              LIKE oay_file.oay11,
       g_rec_b              LIKE type_file.num5,          #No.FUN-680123 SMALLINT, #單身筆數
       l_ac                 LIKE type_file.num5,          #No.FUN-680123 SMALLINT, #目前處理的ARRAY CNT
       l_sl                 LIKE type_file.num5,          #No.FUN-680123 SMALLINT, #目前處理的SCREEN LINE
       exT                  LIKE type_file.chr1,          #No.FUN-680123 VARCHAR(1),  #匯率採用方式 (S.銷售 C.海關)
       g_argv1              LIKE oma_file.oma01,          #No.FUN-560198,580153(帳款編號)
       g_argv2              STRING,                       #No.TQC-630066
       g_argv3              LIKE oma_file.oma00           #No.FUN-680123 VARCHAR(2)   #帳款分類
DEFINE g_forupd_sql         STRING                   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_file.num5      #No.FUN-680123 SMALLINT
DEFINE g_chr                LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
DEFINE g_chr2               LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
DEFINE g_chr3               LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)            #FUN-580153
DEFINE g_laststage          LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)            #FUN-580153
DEFINE g_cnt                LIKE type_file.num10     #No.FUN-680123 INTEGER
DEFINE g_i                  LIKE type_file.num5      #No.FUN-680123 SMALLINT   #count/index for any purpose
DEFINE g_msg                LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(72)
DEFINE g_str                STRING                   #No.FUN-670060
DEFINE g_wc_gl              STRING                   #No.FUN-670060
DEFINE g_dbs_gl             LIKE type_file.chr21     #No.FUN-680123 VARCHAR(21)   #No.FUN-670060
DEFINE i                    LIKE type_file.num5      #No.FUN-680123 SMALLINT
DEFINE g_row_count          LIKE type_file.num10     #No.FUN-680123 INTEGER
DEFINE g_curs_index         LIKE type_file.num10     #No.FUN-680123 INTEGER
DEFINE g_jump               LIKE type_file.num10     #No.FUN-680123 INTEGER
DEFINE mi_no_ask            LIKE type_file.num10     #No.FUN-680123 SMALLINT
DEFINE g_net                LIKE oox_file.oox10      #No.TQC-5C0086
DEFINE g_dec                LIKE omb_file.omb16      #No.MOD-530702
DEFINE g_ohb14_ret          LIKE ohb_file.ohb14      #No.FUN-670026
DEFINE l_table              STRING                   #No.TQC-7A0013                                                                    
DEFINE l_sql                STRING                   #No.TQC-7A0013                                                                    
DEFINE g_ape     ARRAY [48] of RECORD
                    no          LIKE oea_file.oea01,    #No.FUN-680123 VARCHAR(16),
                    sq          LIKE type_file.num5,    #No.FUN-680123 SMALLINT,
                    amtf        LIKE type_file.num20_6, #No.FUN-680123 DEC(20,6),
                    amt         LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)
                    END RECORD
DEFINE g_v0                LIKE type_file.num5          #No.FUN-680123  SMALLINT           #FUN-640246
DEFINE g_dbs2              LIKE type_file.chr30   #MOD-680005
DEFINE cb              ui.ComboBox           #FUN-670026
DEFINE g_cb     DYNAMIC ARRAY OF STRING 
DEFINE g_bookno1     LIKE aza_file.aza81
DEFINE g_bookno2     LIKE aza_file.aza82
DEFINE g_flag1       LIKE type_file.chr1
DEFINE g_oob         RECORD  LIKE oob_file.*       
DEFINE g_ooa         RECORD  LIKE ooa_file.*       
DEFINE g_dept        LIKE    nmh_file.nmh15        
DEFINE g_nmh         RECORD  LIKE nmh_file.*       
DEFINE g_nms         RECORD  LIKE nms_file.*       
DEFINE g_oow         RECORD  LIKE oow_file.*       
DEFINE pb_cmd        LIKE    type_file.chr1       
DEFINE g_plant2      LIKE type_file.chr10   #FUN-980020 
DEFINE li_dbs        STRING                 #FUN-9A0031 
DEFINE g_flag2       LIKE type_file.chr1 #CHI-AC0046 add
DEFINE g_no          LIKE oma_file.oma16 #TQC-B20065 add
DEFINE g_comb           ui.ComboBox    #CHI-B30042
DEFINE l_ima08         LIKE ima_file.ima08 #add by dengsy170629
DEFINE l_count4,l_count5 LIKE type_file.num10 #add by dengsy170629
DEFINE l_omb33         LIKE omb_file.omb33  #add by dengsy170629

MAIN
   DEFINE p_row,p_col   LIKE type_file.num5      #No.FUN-680123 SMALLINT
   IF FGL_GETENV("FGLGUI") <> "0" THEN
     OPTIONS                                #改變一些系統預設值
        INPUT NO WRAP
   END IF
 
   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
#   IF (NOT cl_setup("AXR")) THEN
   IF (NOT cl_setup("CXR")) THEN
      EXIT PROGRAM
   END IF
 
   LET g_argv1 = ARG_VAL(1)
   LET g_argv2 = ARG_VAL(2)
   LET g_argv3 = ARG_VAL(3)
   LET g_wc2 = ' 1=1'
 
   CALL cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
      RETURNING g_time     #No.FUN-6A0095
 
   LET g_sql = " oma00.oma_file.oma00,",
               " oma01.oma_file.oma01,",
               " oma21.oma_file.oma21,",
               " oma05.oma_file.oma05,",
               " oma03.oma_file.oma03,",
               " oma032.oma_file.oma032,",
               " oma16.oma_file.oma16,",
               " oma53.oma_file.oma53 ,",
               " oma56.oma_file.oma56 ,",
               " oma56x.oma_file.oma56x ,",
               " oma56t.oma_file.oma56t "                                                                                                                                                                                                        
           LET l_table = cl_prt_temptable('axrt300',g_sql) CLIPPED                                                                  
           IF l_table = -1 THEN EXIT PROGRAM END IF                                                                                 
           LET g_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,                                                                    
                       " VALUES(?,?,?,?,?,?,?,?,?,?,?)"                                                   
           PREPARE insert_prep FROM g_sql                                                                                           
           IF STATUS THEN                                                                                                           
              CALL cl_err('insert_prep:',status,1) EXIT PROGRAM                                                                     
           END IF                                                                                                                   
 
   LET g_plant2 = g_plant                    #FUN-980020
   LET g_dbs2 = s_dbstring(g_dbs CLIPPED)    #FUN-920166
 
   IF fgl_getenv('EASYFLOW') = "1" THEN
      LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
   END IF
 
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      LET p_row = 2 LET p_col = 2
      OPEN WINDOW t300_w AT p_row,p_col
#        WITH FORM "axr/42f/axrt300"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
        WITH FORM "cxr/42f/axrt300"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN  #modify by zhangym 110906
      
      CALL cl_ui_init()
   END IF
 
   IF g_aza.aza26 = '2' THEN  
      DROP TABLE omad_tmp
   
      CREATE TEMP TABLE omad_tmp
        ( sel LIKE type_file.chr1,  
          omad01 LIKE oma_file.oma01,
          omad23 LIKE oma_file.oma23,
          omad54 LIKE oma_file.oma54,
          omad54x LIKE oma_file.oma54x,
          omad54t LIKE oma_file.oma54t, 
          omad56 LIKE oma_file.oma56,
          omad56x LIKE oma_file.oma56x,
          omad56t LIKE oma_file.oma56t)
   
      IF STATUS THEN
         CALL cl_err('create tmp',STATUS,0)
         EXIT PROGRAM
      END IF
   END IF  
 
   LET g_forupd_sql = "SELECT * FROM oma_file WHERE oma01 = ? FOR UPDATE "   #MOD-7A0066
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t300_cl CURSOR FROM g_forupd_sql   #MOD-7A0066
 
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN  #TQC-740156 add
      LET cb = ui.ComboBox.forName("omb38")
      LET g_cb[1]  = cb.getItemText(1)
      LET g_cb[2]  = cb.getItemText(2)
      LET g_cb[3]  = cb.getItemText(3)
      LET g_cb[4]  = cb.getItemText(4)
      LET g_cb[5]  = cb.getItemText(5)
      LET g_cb[6]  = cb.getItemText(6)
   END IF    #TQC-740156 add
 
   IF g_aza.aza63 = 'N' THEN  #大陸版
      CALL cl_set_comp_visible("oma181,aag02_2,omb331",FALSE)  
   END IF

###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
   IF g_azw.azw04 = '2' THEN
      CALL cl_set_act_visible("detail_tax,trans_tax",TRUE)
   ELSE
      CALL cl_set_act_visible("detail_tax,trans_tax",FALSE)
   END IF
   IF g_azw.azw04 <> '2' THEN
      LET cb = ui.ComboBox.forName("oma70")
      CALL cb.removeItem('3')
   END IF
###-FUN-B40032- ADD -  END  ---------------------------------------------------

   IF g_ooz.ooz65 = 'Y' THEN  
      CALL cl_set_comp_visible("omb38",TRUE)
      IF g_aza.aza50 = 'Y' THEN  
         CALL cl_set_comp_visible("omb39",TRUE)
      ELSE
         CALL cl_set_comp_visible("omb39",FALSE)
      END IF
   ELSE
      CALL cl_set_comp_visible("omb38",FALSE)
      CALL cl_set_comp_visible("omb39",FALSE)
   END IF
 
   CALL cl_set_comp_visible("oma930,gem02a,omb930,gem02c",g_aaz.aaz90='Y')
 
   CALL cl_set_comp_visible("oma63,omb41,omb42",g_aza.aza08='Y') 
#No.FUN-AB0034 --begin
   IF (g_azw.azw04 <> '2') THEN
       CALL cl_set_comp_visible("oma73,oma73f,omb45,omb47",FALSE)
   END IF
#No.FUN-AB0034 --end 
   #如果由表單追蹤區觸發程式, 此參數指定為何種資料匣
   #當為 EasyFlow 簽核時, 加入 EasyFlow 簽核 toolbar icon
   CALL aws_efapp_toolbar()    #FUN-580153
   IF NOT cl_null(g_argv1) THEN
      CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t300_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t300_a()
            END IF
          WHEN "efconfirm"
             display "efconfirm"
             CALL t300_q()
             CALL s_showmsg_init() #CHI-A80031 add
             CALL t300_y_chk()          #CALL 原確認的 check 段
             IF g_success = "Y" THEN
                CALL t300_y_upd()       #CALL 原確認的 update 段
             END IF              
             CALL s_showmsg()  #CHI-A80031 add
             EXIT PROGRAM 
          OTHERWISE
             CALL t300_q()
      END CASE
   END IF
 
  #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
 #CHI-A80056 mod --start-- add modi_mul_tra_inv
 #CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, 
 #                           query,locale, void, confirm, undo_confirm, 
 #                           easyflow_approval,issue_invoice,maintain_invoice,
 #                           doc_data,other_data,modify_tax,gen_entry,
 #                           entry_sheet,entry_sheet2,T_T_entry_sheet,T_T_entry_sheet2,modi_mul_tra_acc,   #FUN-830091
 #                           multi_account_period,carry_voucher, undo_carry_voucher, rec_direct,modify_date") #FUN-670047 #No:FUN-680022 #TQC-7B0107 modify  #No.FUN-840213 
 #     RETURNING g_laststage
  CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, 
                             query,locale, void, confirm, undo_confirm, 
                             easyflow_approval,issue_invoice,maintain_invoice,
                             doc_data,other_data,modify_tax,gen_entry,
                             entry_sheet,entry_sheet2,T_T_entry_sheet,T_T_entry_sheet2,modi_mul_tra_acc,
                             multi_account_period,carry_voucher, undo_carry_voucher, 
                             rec_direct,modify_date,modi_mul_tra_inv") 
       RETURNING g_laststage
  #CHI-A80056 mod --end--
 
#CHI-B30042----begin------
#IF g_aza.aza50='Y' THEN   #No.TQC-B40042
#IF g_aza.aza50='N' THEN    #No.TQC-B40042  #TQC-B40172 mark
IF g_azw.azw04 <> '2' THEN   #No.TQC-B40172
   LET g_comb = ui.ComboBox.forName("oma00")
   CALL g_comb.removeItem('15')
   CALL g_comb.removeItem('16')   #No.TQC-B40172
   CALL g_comb.removeItem('17')
   CALL g_comb.removeItem('18')
   CALL g_comb.removeItem('19')   #No.TQC-B40172
   CALL g_comb.removeItem('26')
   CALL g_comb.removeItem('27')
   CALL g_comb.removeItem('28')   #No.TQC-B40172
END IF

#CHI-B30042-----end-------

   LET g_flag='Y'
 
   CALL t300_menu()
 
   CLOSE WINDOW t300_w                 #結束畫面
     CALL cl_used(g_prog,g_time,2)    #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
       RETURNING g_time    #No.FUN-6A0095
 
END MAIN
 
FUNCTION t300_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
 
   CLEAR FORM                             #清除畫面
   CALL g_omb.clear()
 
  IF NOT cl_null(g_argv1) THEN
     LET g_wc =" oma01='",g_argv1,"'"
     IF NOT cl_null(g_argv3) THEN #No.TQC-630066
        LET g_wc = g_wc CLIPPED," AND oma00 = '",g_argv3,"'"
     END IF
     LET g_wc2=" 1=1"
  ELSE
     LET g_oma.oma00 = '00'
 
     CALL t300_show0()  #for genero
     CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
     INITIALIZE g_oma.* TO NULL    #No.FUN-750051

     CONSTRUCT BY NAME g_wc ON oma00,oma01,oma08,oma02,oma33,oma66,oma03,oma032,oma68,oma69,   #No.FUN-670060 add oma68,oma69   #TQC-A50022 add oma66
                               omaconf,omavoid,omamksg,oma64,oma70,oma32,oma11,   #No.FUN-540040  #FUN-960140 add oma70 
                               oma12,oma13,ool02,oma18,oma181,oma65,oma23,oma52,oma73f,oma54,oma54x,oma51f,   #FUN-570099  #FUN-590100 #FUN-670047   FUN-AB0034 add oma73f
                               oma54t,oma55,oma24,oma53,oma73,oma56,oma56x,oma51,oma56t,  #FUN-590100   FUN-AB0034 add oma73
                               oma57,oma14,oma15,oma930,oma16,oma165,oma19,oma99,   #No:FUN-A50103   #No.8186 add oma99 #No.MOD-530008 #FUN-630043 #FUN-640191 add oma67 #FUN-680001
                            #  oma992,oma66,oma67,oma25,oma26,oma63,oma40,omaprsw,   #No.FUN-690090 add oma992   #TQC-A50022 MARK
                               oma992,      oma67,oma25,oma26,oma63,oma40,omaprsw,         #TQC-A50022
                               oma09,oma05,oma10,oma04,oma71,oma21,oma211,oma212,  #No.TQC-740309 add oma04 #FUN-970108 add oma71
                               oma213,oma74,oma58,oma59,oma59x,oma59t,   #FUN-AB0034 add oma74
                               omauser,omagrup,omaoriu,omaorig,omamodu,omadate, #No.FUN-A40054 Add omaoriu,omaorig
                               omaud01,omaud02,omaud03,omaud04,omaud05,
                               omaud06,omaud07,omaud08,omaud09,omaud10,
                               omaud11,omaud12,omaud13,omaud14,omaud15
 
        BEFORE CONSTRUCT
           CALL cl_qbe_init()

        ON ACTION CONTROLP
           CASE
              WHEN INFIELD(oma01)  #genero要改查單據單(未改)
                    CALL q_oma(TRUE,TRUE,g_oma.oma01,'','')  #NO:6842
                    RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO oma01
              WHEN INFIELD(oma03)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_occ"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma03
                   NEXT FIELD oma03
              WHEN INFIELD(oma04)
                   CALL cl_init_qry_var()
                   IF g_aza.aza50 = 'Y' THEN  #No.TQC-760015
                      LET g_qryparam.form ="q_occ12"
                   ELSE                                                                                                            
                      LET g_qryparam.form ="q_occ13"                                                                               
                   END IF                                                                                                          
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma04
                   NEXT FIELD oma04
              WHEN INFIELD(oma32)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_oag"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma32
                   NEXT FIELD oma32
              WHEN INFIELD(oma68)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_occ11"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma68
                   NEXT FIELD oma68
              WHEN INFIELD(oma13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ool"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma13
                   NEXT FIELD oma13
              WHEN INFIELD(oma14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gen"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma14
                   NEXT FIELD oma14
              WHEN INFIELD(oma15)
                   CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem1"   #No.MOD-530272
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma15
                   NEXT FIELD oma15
              WHEN INFIELD(oma18)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_aag'
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma18
                   NEXT FIELD oma18
              WHEN INFIELD(oma181)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_aag'
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma181
                   NEXT FIELD oma181
              WHEN INFIELD(oma21)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gec"
                   LET g_qryparam.state = "c"
                   LET g_qryparam.where = " gec011='2' "
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma21
                   NEXT FIELD oma21
              WHEN INFIELD(oma23)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azi"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma23
                   NEXT FIELD oma23
              WHEN INFIELD(oma25)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_oab"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma25
                   NEXT FIELD oma25
              WHEN INFIELD(oma26)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_oab"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma26
                   NEXT FIELD oma26
              WHEN INFIELD(oma63)         #bugno:7258
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_pja"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oma63
                   NEXT FIELD oma63
              WHEN INFIELD(oma930)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form  = "q_gem4"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oma930
                 NEXT FIELD oma930
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
           CALL cl_qbe_list() RETURNING lc_qbe_sn
           CALL cl_qbe_display_condition(lc_qbe_sn)

     END CONSTRUCT
 
     IF INT_FLAG THEN
        RETURN
     END IF
 
     CONSTRUCT g_wc2 ON omb03,omb38,omb44,omb31,omb32,omb39,omb04,omb06,omb45,omb47,omb40,omb05,omb930   #No.FUN-670026--add omb38,omb39  #No.FUN-660073  #FUN-990031 add omb44   FUN-AB0034 add omb45,omb47
                        ,ombud01,ombud02,ombud03,ombud04,ombud05
                        ,ombud06,ombud07,ombud08,ombud09,ombud10
                        ,ombud11,ombud12,omb41,omb42,ombud13,ombud14,ombud15                      #No.FUN-850027--add omb41,omb42
                   FROM s_omb[1].omb03,s_omb[1].omb38,s_omb[1].omb44,s_omb[1].omb31,s_omb[1].omb32, #No.FUN-670026--add omb38,omb39   #FUN-990031 add omb44
                        s_omb[1].omb39,s_omb[1].omb04,s_omb[1].omb06,s_omb[1].omb45,s_omb[1].omb47,s_omb[1].omb40,s_omb[1].omb05, #No.FUN-670026--add omb38,omb39  #No.FUN-660073    FUN-AB0034 add omb45,omb47
                        s_omb[1].omb930  #FUN-680001
                        ,s_omb[1].ombud01,s_omb[1].ombud02,s_omb[1].ombud03
                        ,s_omb[1].ombud04,s_omb[1].ombud05,s_omb[1].ombud06
                        ,s_omb[1].ombud07,s_omb[1].ombud08,s_omb[1].ombud09
                        ,s_omb[1].ombud10,s_omb[1].ombud11,s_omb[1].ombud12
                        ,s_omb[1].omb41,s_omb[1].omb42                                        #No.FUN-850027--add omb41,omb42
                        ,s_omb[1].ombud13,s_omb[1].ombud14,s_omb[1].ombud15
 
        BEFORE CONSTRUCT
           CALL cl_qbe_display_condition(lc_qbe_sn)

        ON ACTION CONTROLP   #ok
           CASE
              WHEN INFIELD(omb04)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_ima"
                LET g_qryparam.state = "c"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO omb04
                NEXT FIELD omb04
              WHEN INFIELD(omb05)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_gfe"
                LET g_qryparam.state = "c"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO omb05
                NEXT FIELD omb05
              WHEN INFIELD(omb41)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_pja2"  
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO omb41
                 NEXT FIELD omb41
               WHEN INFIELD(omb42)  #WBS
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_pjb4"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO omb42
                 NEXT FIELD omb42

              WHEN INFIELD(omb44)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_azw"
                LET g_qryparam.state = "c"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO omb44
                NEXT FIELD omb44
              WHEN INFIELD(omb33)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_aag"
                LET g_qryparam.state = "c"
                LET g_qryparam.where = " aag07 IN ('2','3') AND ",
                                       " aag03 IN ('2') "
                LET g_qryparam.arg1=g_bookno1                #No.FUN-730073
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO omb33
                NEXT FIELD omb33
 
             WHEN INFIELD(omb40)
                CALL cl_init_qry_var()
                LET g_qryparam.state = "c"
                LET g_qryparam.form ="q_azf"
                LET g_qryparam.arg1 ="2"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO omb40
                NEXT FIELD omb40
 
              WHEN INFIELD(omb930)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form  = "q_gem4"
                 LET g_qryparam.state = "c"   #多選
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO omb930
                 NEXT FIELD omb930
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
 
        ON ACTION qbe_save
           CALL cl_qbe_save()
 
     END CONSTRUCT
 
     IF INT_FLAG THEN
        LET INT_FLAG = 0
        RETURN
     END IF
   END IF
 
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('omauser', 'omagrup')
 
   IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
      LET g_sql = "SELECT oma01 FROM oma_file",
                  " WHERE ", g_wc CLIPPED,
                  " ORDER BY 1"
   ELSE                              # 若單身有輸入條件
      LET g_sql = "SELECT UNIQUE oma_file.oma01 ",
                  "  FROM oma_file, omb_file",
                  " WHERE oma01 = omb01",
                  "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                  " ORDER BY 1"
   END IF
 
   PREPARE t300_prepare FROM g_sql
   DECLARE t300_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR t300_prepare
 
   IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
      LET g_sql="SELECT COUNT(*) FROM oma_file WHERE ",g_wc CLIPPED
   ELSE
      LET g_sql="SELECT COUNT(DISTINCT oma01) FROM oma_file,omb_file WHERE ",
                " omb01=oma01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
   END IF
 
   PREPARE t300_precount FROM g_sql
   DECLARE t300_count CURSOR FOR t300_precount
 
END FUNCTION
 
FUNCTION t300_menu()
   DEFINE l_creator    LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINe l_flowuser   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)              # 是否有指定加簽人員      #FUN-580153
   DEFINE l_gec05      LIKE gec_file.gec05      # MOD-5A0331
   DEFINE l_azp03      LIKE azp_file.azp03      # FUN-630043
   DEFINE l_oga09      LIKE oga_file.oga09     #CHI-A90023 add
  
   LET l_flowuser = "N"
 
   WHILE TRUE
      CALL t300_bp("G")
      CASE g_action_choice
 
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t300_a()
            END IF
 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t300_q()
            END IF
 
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t300_u()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               IF g_oma.oma00 = "23" THEN
                  CALL cl_err('','axr-024',0);
               ELSE
                  CALL t300_r()
               END IF
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t300_b()
            ELSE
               LET g_action_choice = NULL
            END IF
 
         WHEN "output"
            IF cl_chk_act_auth() THEN
               CALL t300_out()
            END IF
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         WHEN "exporttoexcel"
             IF cl_chk_act_auth() THEN
                CALL cl_export_to_excel
                (ui.Interface.getRootNode(),base.TypeInfo.create(g_omb),'','')
             END IF
         WHEN "doc_data"
            IF cl_chk_act_auth() THEN
               CALL t300_1()
            END IF
 
         WHEN "other_data"
            IF cl_chk_act_auth() THEN
               CALL t300_2()
            END IF
 
         WHEN "modify_tax"
            IF cl_chk_act_auth() THEN
     ###-FUN-B40032- ADD - BEGIN -------------------------------------
               IF g_oma.oma70 = '3' THEN
                  CALL cl_err('','axr-086',0)
               ELSE
     ###-FUN-B40032- ADD -  END  -------------------------------------
                  CALL t300_9()
               END IF       #FUN-B40032  ADD
            END IF
 
         WHEN "maintain_invoice"
     ###-FUN-B40032- ADD - BEGIN -------------------------------------
            IF g_oma.oma70 = '3' THEN
               CALL cl_err('','axr-086',0)
            ELSE
     ###-FUN-B40032- ADD -  END  -------------------------------------
              #FUN-C60033--ad--str-by xuxz
               SELECT oaz92 INTO g_oaz.oaz92 FROM oaz_file
               IF g_oaz.oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
                  LET g_msg = "axmt670 '' '' '",g_oma.oma01,"'"
                  CALL cl_cmdrun_wait(g_msg)
               ELSE
               #FUN-C60033--ad--end-by xuxz     
               IF g_oma.oma64 NOT matches '[Ss]' THEN      #FUN-910074 add 
                  IF g_aza.aza26 = '2' AND g_aza.aza47 = 'Y' THEN #No.MOD-590095
                 # No.TQC-B30218  --Mark Begin
                 # SELECT gec05 INTO l_gec05
                 #   FROM gec_file
                 #  WHERE gec01 = g_oma.oma21
                 #    AND gec011 = '2'
                 # IF l_gec05 = 'A' THEN
                     LET g_msg="gisi100 '",g_oma.oma01,"'"
                 # ELSE
                 #    LET g_msg="axrt310 '",g_oma.oma10,"'"
                 # END IF
                 # No.TQC-B30218  --Mark End
                  ELSE
                     LET g_msg="axrt310 '",g_oma.oma10,"'"
                  END IF
                  CALL cl_cmdrun_wait(g_msg)
## No.2696 modify 1998/11/02  重新顯示單頭資料
                  SELECT oma10,oma09 INTO g_oma.oma10,g_oma.oma09 FROM oma_file
                  WHERE oma01 = g_oma.oma01
                  UPDATE omc_file SET omc12 = g_oma.oma10 WHERE omc01=oma01 #No.FUN-680022
                  DISPLAY BY NAME g_oma.oma10
                  DISPLAY BY NAME g_oma.oma09
               END IF        #FUN-910074 add
               END IF #FUN-C60036 add               
            END IF       #FUN-B40032  ADD
         WHEN "qry_receive"
            CALL t300_d()
 
         WHEN "qry_contra_detail"
            IF g_ooz.ooz62='Y' THEN
               CALL t300_j(0,0,'')
            ELSE
               CALL cl_err("ooz62='N'",'axr-906',0)
            END IF
 
         WHEN "qry_Source_Doc"
           #IF NOT cl_null(g_oma.oma16) THEN #CHI-A90023 mark
            IF l_ac > 0 THEN #CHI-A90023
               LET g_msg=""
               CASE
                 #WHEN g_oma.oma00='11'                        #CHI-A50040 mark
                  WHEN g_oma.oma00='11' OR g_oma.oma00='13'    #CHI-A50040
                    IF s_industry('std') THEN   #標準行業  #MOD-9C0124 add
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt410 '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt410 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       ELSE
                         #LET g_msg = "axmt810 '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt810 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF   #MOD-9C0124 add
                    IF s_industry('icd') THEN   #ICD行業
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt410_icd '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt410_icd '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       ELSE
                         #LET g_msg = "axmt810_icd '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt810_icd '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF
                    IF s_industry('slk') THEN   #SLK行業
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt410_slk '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt410_slk '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       ELSE
                         #LET g_msg = "axmt810_slk '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt810_slk '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF
 
                 #WHEN g_oma.oma00='12' OR g_oma.oma00='13'   #CHI-A50040 mark
                 #WHEN g_oma.oma00='12'                       #CHI-A50040  #TQC-B20065
                  WHEN g_oma.oma00='12' OR g_oma.oma00='19'                      #CHI-A50040 #TQC-B20065
                    #CHI-A90023 add --start--
                    SELECT oga09 INTO l_oga09 FROM oga_file
                     WHERE oga01 = g_omb[l_ac].omb31
                    #CHI-A90023 add --end--
                    IF s_industry('std') THEN   #標準行業  #MOD-9C0124 add
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt620 '",g_oma.oma16,"'" #CHI-A90023 mark
                          #CHI-A90023 add --start--
                          IF l_oga09 ='3' THEN
                             LET g_msg = "axmt650 '",g_omb[l_ac].omb31,"'"
                          ELSE
                             LET g_msg = "axmt620 '",g_omb[l_ac].omb31,"'"
                          END IF
                          #CHI-A90023 add --end--
                       ELSE
                         #LET g_msg = "axmt820 '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt820 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF   #MOD-9C0124 add
                    IF s_industry('icd') THEN   #ICD行業
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt620_icd '",g_oma.oma16,"'" #CHI-A90023 mark
                          #CHI-A90023 add --start--
                          IF l_oga09 ='3' THEN
                             LET g_msg = "axmt650 '",g_omb[l_ac].omb31,"'"
                          ELSE
                             LET g_msg = "axmt620_icd '",g_omb[l_ac].omb31,"'" 
                          END IF
                          #CHI-A90023 add --end--
                       ELSE
                         #LET g_msg = "axmt820 '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt820 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF
                    IF s_industry('slk') THEN   #SLK行業
                       IF cl_null(g_oma.oma99) THEN
                         #LET g_msg = "axmt620 '",g_oma.oma16,"'" #CHI-A90023 mark
                          #CHI-A90023 add --start--
                          IF l_oga09 ='3' THEN
                             LET g_msg = "axmt650 '",g_omb[l_ac].omb31,"'"
                          ELSE
                             LET g_msg = "axmt620 '",g_omb[l_ac].omb31,"'"
                          END IF
                          #CHI-A90023 add --end--
                       ELSE
                         #LET g_msg = "axmt820 '",g_oma.oma16,"'" #CHI-A90023 mark
                          LET g_msg = "axmt820 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                       END IF
                    END IF
 
                 #TQC-B20065 --begin
                  WHEN g_oma.oma00='15'  #订金/押金
                    LET g_no = NULL
                    LET g_sql = " SELECT lua01 FROM ",cl_get_target_table(g_plant_new,'lua_file'), #FUN-A50102
                                "  WHERE lua01 = '",g_oma.oma16,"'",
                                "    AND lua02= '01' AND lua15 = 'Y' "
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                    PREPARE sel_lua_pre66 FROM g_sql
                    EXECUTE sel_lua_pre66 INTO g_no
                    IF NOT cl_null(g_no) THEN
                       LET g_msg = "artt610 '",g_oma.oma16,"'" 
                    ELSE
                       LET g_sql = " SELECT rxr01 FROM ",cl_get_target_table(g_plant_new,'rxr_file'), #FUN-A50102
                                   "  WHERE rxr01 = '",g_oma.oma16,"'",
                                   "    AND rxr00 = '1' AND rxrconf = 'Y' "
                       CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                       PREPARE sel_rxr_pre66 FROM g_sql
                       EXECUTE sel_rxr_pre66 INTO g_no
                       IF NOT cl_null(g_no) THEN
                          LET g_msg = "artt615 '' '",g_oma.oma16,"'" 
                       END IF
                    END IF

                  WHEN g_oma.oma00='17'  #费用单收入/储值卡购卡金额
                    LET g_no = NULL
                    LET g_sql = " SELECT lua01 FROM ",cl_get_target_table(g_plant_new,'lua_file'), #FUN-A50102
                                "  WHERE lua01 = '",g_oma.oma16,"'",
                                "    AND lua02= '02' AND lua15 = 'Y' "
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                    PREPARE sel_lua02_pre66 FROM g_sql
                    EXECUTE sel_lua02_pre66 INTO g_no
                    IF NOT cl_null(g_no) THEN
                       LET g_msg = "artt610 '",g_oma.oma16,"'" 
                    ELSE
                       LET g_sql = " SELECT lps01 FROM ",cl_get_target_table(g_plant_new,'lps_file'), #FUN-A50102
                                   "  WHERE lps01 = '",g_oma.oma16,"'",
                                   "    AND lps09 = 'Y' "
                       CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                       PREPARE sel_lps01_pre FROM g_sql
                       EXECUTE sel_lps01_pre INTO g_no
                       IF NOT cl_null(g_no) THEN
                          LET g_msg = "almt610 '",g_oma.oma16,"'" 
                       END IF
                    END IF

                  WHEN g_oma.oma00='18'  #储值卡销售/充值
                    LET g_no = NULL
                    LET g_sql = " SELECT lps01 FROM ",cl_get_target_table(g_plant_new,'lps_file'), #FUN-A50102
                                "  WHERE lps01 = '",g_oma.oma16,"'",
                                "    AND lps09 = 'Y' "
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                    PREPARE sel_lps02_pre66 FROM g_sql
                    EXECUTE sel_lps02_pre66 INTO g_no
                    IF NOT cl_null(g_no) THEN
                       LET g_msg = "almt610 '",g_oma.oma16,"'" 
                    ELSE
                       LET g_sql = " SELECT lpu01 FROM ",cl_get_target_table(g_plant_new,'lpu_file'), #FUN-A50102
                                   "  WHERE lpu01 = '",g_oma.oma16,"'",
                                   "    AND lpu08 = 'Y' "
                       CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                       PREPARE sel_lpu_pre66 FROM g_sql
                       EXECUTE sel_lpu_pre66 INTO g_no
                       IF NOT cl_null(g_no) THEN
                          LET g_msg = "almt620 '",g_oma.oma16,"'" 
                       END IF
                    END IF
                 #TQC-B20065 --end

                 #WHEN g_oma.oma00='21'  #TQC-B20065
                  WHEN g_oma.oma00='21' OR g_oma.oma00='28'  #TQC-B20065
                    IF cl_null(g_oma.oma99) THEN
                      #LET g_msg = "axmt700 '",g_oma.oma16,"'" #CHI-A90023 mark
                       LET g_msg = "axmt700 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                    ELSE
                      #LET g_msg = "axmt840 '",g_oma.oma16,"'" #CHI-A90023 mark
                       LET g_msg = "axmt840 '",g_omb[l_ac].omb31,"'" #CHI-A90023
                    END IF
               END CASE 
               IF not cl_null(g_msg) THEN
                  CALL cl_cmdrun_wait(g_msg CLIPPED)
               END IF
            END IF
 
         WHEN "modify_date"
            IF cl_chk_act_auth() THEN
     ###-FUN-B40032- ADD - BEGIN -------------------------------------
               IF g_oma.oma70 = '3' THEN
                  CALL cl_err('','axr-086',0)
               ELSE
     ###-FUN-B40032- ADD -  END  -------------------------------------
                  CALL t300_date()
               END IF       #FUN-B40032  ADD
            END IF
 
 
         WHEN "rec_direct"
            #TQC-A40140--Add-Begin
            IF g_ooy.ooydmy2 = 'Y' THEN
               CALL cl_err('','axr-418',1)
            ELSE
            #TQC-A40140--Add-End
            IF cl_chk_act_auth() THEN
               IF g_oma.oma64 NOT matches '[Ss]' THEN      #FUN-910074 add 
                  CASE
                     WHEN g_oma.omavoid = 'Y' #已作廢
                        CALL cl_err(g_oma.oma01,'aap-165',0)
                     WHEN g_oma.oma00 MATCHES '2*'
                        CALL cl_err(g_oma.oma01,'axr-935',0)
                     OTHERWISE
                        CALL s_t300_w(g_oma.oma01)
                        CALL t300_show()
                  END CASE
               END IF    #FUN-910074 add  
            END IF
            END IF        #TQC-A40140--Add    

      #add by shenrr 120529---begin
         WHEN "contra"
            IF g_ooy.ooydmy2 = 'Y' THEN
               CALL cl_err('','axr-418',1)
            ELSE
            IF cl_chk_act_auth() THEN
               IF g_oma.oma64 NOT matches '[Ss]' THEN    
                  CASE
                     WHEN g_oma.omavoid = 'Y' #已作廢
                        CALL cl_err(g_oma.oma01,'aap-165',0)
                     WHEN g_oma.oma00 MATCHES '2*'
                        CALL cl_err(g_oma.oma01,'axr-935',0)
                     OTHERWISE
                        CALL s_t3002_w(g_oma.oma01)
                        IF cl_confirm('axr-309') THEN
                           CALL t300_v0() 
                         END IF
                        CALL t300_show()
                  END CASE
               END IF  
            END IF
            END IF     
      #add by shenrr 120529---end
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
         WHEN "trans_tax"           #--實際交易稅別明細
            IF cl_chk_act_auth() THEN
               CALL t300_trans_tax()
            END IF 

         WHEN "detail_tax"          #--單身稅別明細
            IF cl_chk_act_auth() THEN
               CALL t300_detail_tax()
            END IF 
###-FUN-B40032- ADD -  END  ---------------------------------------------------
 
         WHEN "gen_entry"
            IF cl_chk_act_auth() THEN
               CALL t300_v0()      #No.8161
            END IF
 
         WHEN "entry_sheet"
            IF cl_chk_act_auth() THEN
               CALL t300_3()
               CALL t300_npp02('0')  #FUN-670047
            END IF
 
         WHEN "entry_sheet2"
            IF cl_chk_act_auth() THEN
               CALL t300_31()
               CALL t300_npp02('1')  #FUN-670047
            END IF
 
         WHEN "T_T_entry_sheet"
            IF cl_chk_act_auth() THEN
               CALL t300_3()
               CALL t300_npp02('0')  
            END IF
 
         WHEN "T_T_entry_sheet2"
            IF cl_chk_act_auth() THEN
               CALL t300_31()
               CALL t300_npp02('1')  
            END IF
 
         WHEN "memo"
            IF cl_chk_act_auth() THEN
               CALL t300_m()
            END IF

         WHEN "carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_oma.omaconf = 'Y' THEN
                  CALL t300_carry_voucher() 
               ELSE 
                  CALL cl_err('','atm-402',1)
               END IF
            END IF
 
         WHEN "undo_carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_oma.omaconf = 'Y' THEN
                  CALL t300_undo_carry_voucher() 
               ELSE 
                  CALL cl_err('','atm-403',1)
               END IF
            END IF
 
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
              CALL s_showmsg_init() #CHI-A80031 add
              CALL t300_y_chk()          #CALL 原確認的 check 段
              IF g_success = "Y" THEN
                 CALL t300_y_upd()       #CALL 原確認的 update 段
                 CALL ui.Interface.refresh()
                 SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
                 CALL t300_show()
              END IF
              CALL s_showmsg()  #CHI-A80031 add
            END IF
 
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               IF g_oma.oma00 = "23" THEN
                  CALL cl_err('','axr-023',0);
               ELSE   
                  CALL t300_z()
               END IF
               CALL ui.Interface.refresh()
               SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
               CALL t300_show()
            END IF
 
         WHEN "void"
            IF cl_chk_act_auth() THEN
               CALL t300_x()
            END IF
 
         WHEN "modi_mul_tra_acc"
            IF cl_chk_act_auth() THEN
               CALL t300_w()
            END IF

         #CHI-A80056 add --start--
         WHEN "modi_mul_tra_inv"
            IF cl_chk_act_auth() THEN
               CALL t300_modi_mul_tra_inv()
            END IF
         #CHI-A80056 add --end--
 
         WHEN "mntn_offset_inv"      #MOD-530692
           IF cl_chk_act_auth() THEN
              IF g_aza.aza26 = '2' THEN
                 CALL t300_d2()
              END IF
           END IF
 
         WHEN "issue_invoice"
            IF cl_chk_act_auth() THEN
     ###-FUN-B40032- ADD - BEGIN -------------------------------------
               IF g_oma.oma70 = '3' THEN
                  CALL cl_err('','axr-086',0)
               ELSE
     ###-FUN-B40032- ADD -  END  -------------------------------------
                  #IF g_oma.oma64 NOT matches '[Ss]' THEN      #FUN-910074 add
                  IF g_oma.oma64 NOT matches '[Ss]' OR cl_null(g_oma.oma64) THEN      #FUN-910074 add  #mod by zhangym 120522
                     IF g_aza.aza26 = '2' AND g_aza.aza47 = 'Y' THEN #No.MOD-590095
                    # No.TQC-B30218  -Mark Begin
                    # SELECT gec05 INTO l_gec05
                    #   FROM gec_file
                    #  WHERE gec01 = g_oma.oma21
                    #    AND gec011 = '2'
                    # IF l_gec05 = 'A' THEN
                        LET g_msg="gisp100 '",g_oma.oma01,"'"
                        CALL cl_cmdrun_wait(g_msg)  #FUN-660216 add
                    # ELSE
                    #    CALL t300_g()
                    # END IF
                    # No.TQC-B30218  -Mark End
                     ELSE
                        CALL t300_g()
                     END IF
                     SELECT oma10 INTO g_oma.oma10 FROM oma_file 
                      WHERE oma01= g_oma.oma01
                     DISPLAY BY NAME g_oma.oma10  #Add No:TQC-B20096
                     UPDATE omc_file SET omc12 = g_oma.oma10 
                      WHERE omc01=g_oma.oma01
                  END IF    #FUN-910074  add
               END IF       #FUN-B40032  ADD 
            END IF
 
         #@WHEN "准"
         WHEN "agree"
            IF g_laststage = "Y" AND l_flowuser = "N" THEN  #最後一關並且沒有加簽人員
               CALL t300_y_upd()      #CALL 原確認的 update 段
            ELSE
               LET g_success = "Y"
               IF NOT aws_efapp_formapproval() THEN
                  LET g_success = "N"
               END IF
            END IF
            IF g_success = 'Y' THEN
                   IF cl_confirm('aws-081') THEN  #詢問是否繼續下一筆資料的簽核
                     IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                        LET l_flowuser = "N"
                        LET g_argv1 = aws_efapp_wsk(1)   #取得單號
                        IF NOT cl_null(g_argv1) THEN     #自動 query 帶出資料
                          CALL t300_q()
                         #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          #CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, confirm, undo_confirm, easyflow_approval,issue_invoice,maintain_invoice,doc_data,other_data,modify_tax,gen_entry,entry_sheet,entry_sheet3,T_T_entry_sheet,T_T_entry_sheet2,modi_mul_tra_acc,multi_account_period,carry_voucher, undo_carry_voucher, rec_direct,modify_date") #FUN-670047 #TQC-7B0107 modify   #FUN-830091  #No.FUN-840213 #CHI-A80056 mark
                          #CHI-A80056 mod --start-- add modi_mul_tra_inv
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, 
                                                     confirm, undo_confirm, easyflow_approval,issue_invoice,
                                                     maintain_invoice,doc_data,other_data,modify_tax,gen_entry,
                                                     entry_sheet,entry_sheet3,T_T_entry_sheet,T_T_entry_sheet2,
                                                     modi_mul_tra_acc,multi_account_period,carry_voucher, 
                                                     undo_carry_voucher, rec_direct,modify_date,modi_mul_tra_inv")
                               RETURNING g_laststage
                          #CHI-A80056 mod --end--
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
            IF ( l_creator := aws_efapp_backflow() ) IS NOT NULL THEN #退回關卡
               IF aws_efapp_formapproval() THEN
                  IF l_creator = "Y" THEN
                     LET g_oma.oma64= 'R'
                     DISPLAY BY NAME g_oma.oma64
                  END IF
                  IF cl_confirm('aws-081') THEN     #詢問是否繼續下一筆資料的簽核
                     IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                       LET l_flowuser = "N"
                       LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                       IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                          CALL t300_q()
                        #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          #CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, confirm, undo_confirm, easyflow_approval,issue_invoice,maintain_invoice,doc_data,other_data,modify_tax,gen_entry,entry_sheet,entry_sheet2,T_T_entry_sheet,T_T_entry_sheet2,modi_mul_tra_acc,multi_account_period,carry_voucher, undo_carry_voucher, rec_direct,modify_date") #FUN-670047 #TQC-7B0107 modify   #FUN-830091  #No.FUN-840213 #CHI-A80056 mark
                          #CHI-A80056 mod --start-- add modi_mul_tra_inv
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, 
                                                     detail, query,locale, void, confirm, 
                                                     undo_confirm, easyflow_approval,
                                                     issue_invoice,maintain_invoice,
                                                     doc_data,other_data,modify_tax,
                                                     gen_entry,entry_sheet,entry_sheet2,
                                                     T_T_entry_sheet,T_T_entry_sheet2,
                                                     modi_mul_tra_acc,multi_account_period,
                                                     carry_voucher, undo_carry_voucher, 
                                                     rec_direct,modify_date,modi_mul_tra_inv")
                              RETURNING g_laststage
                          #CHI-A80056 mod --end--
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
 
       ##EasyFlow送簽
         WHEN "easyflow_approval"     #FUN-550049
           IF cl_chk_act_auth() THEN
                CALL t300_ef()
           END IF
 
       #@WHEN "簽核狀況"
         WHEN "approval_status"
            IF cl_chk_act_auth() THEN        #DISPLAY ONLY
               IF aws_condition2() THEN                #FUN-550049
                    CALL aws_efstat2()                  #MOD-560007
               END IF
            END IF
 
         WHEN "multi_account_period"             #多帳期
            IF cl_chk_act_auth() THEN
               CALL t300_multi_account()
               CALL ui.Interface.refresh()
               IF g_success = 'Y' THEN
                  SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
                  CALL t300_show()
               END IF
            END IF

         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_oma.oma64 NOT matches '[Ss]' THEN      #FUN-910074 add
                    IF g_oma.oma01 IS NOT NULL THEN
                       LET g_doc.column1 = "oma01"
                       LET g_doc.value1 = g_oma.oma01
                       CALL cl_doc()
                    END IF
                 END IF    #FUN-910074 add 
         END IF
#No.FUN-A30106 --begin                                                          
         WHEN "drill_down"                                                      
            IF cl_chk_act_auth() THEN                                           
               CALL t300_drill_down()                                           
            END IF                                                              
#No.FUN-A30106 --end  
         END CASE
    END WHILE
END FUNCTION
 
FUNCTION t300_a()
   DEFINE l_oma171   LIKE oma_file.oma171
   DEFINE l_oga      RECORD LIKE oga_file.*
   DEFINE li_result  LIKE type_file.num5     #No.FUN-680123 SMALLINT
 
   IF s_shut(0) THEN RETURN END IF
 
   MESSAGE ""
   CLEAR FORM
   CALL g_omb.clear()
   INITIALIZE g_oma.* TO NULL
   LET g_oma_o.* = g_oma.*
   LET g_oma_t.* = g_oma.*
   CALL cl_opmsg('a')
 
   WHILE TRUE
      IF NOT cl_null(g_argv1) AND (g_argv2 = "insert") THEN
         LET g_oma.oma01 = g_argv1
      END IF     
      LET g_oma.oma08 = '1'
      LET g_oma.oma02 = g_today
      LET g_oma.oma07 = 'N'
      LET g_oma.oma17 = '1'
      LET g_oma.oma171 = '31'
      LET g_oma.oma172 = '1'
      LET g_oma.oma161 = 0
      LET g_oma.oma162 = 100
      LET g_oma.oma163 = 0
      LET g_oma.oma20 = 'Y'
      LET g_oma.oma24 = 0
      LET g_oma.oma40 = 'N'
      LET g_oma.oma58 = 0
      LET g_oma.oma50 = 0
      LET g_oma.oma50t = 0
      LET g_oma.oma52 = 0      
      LET g_oma.oma53 = 0
      LET g_oma.oma54 = 0
      LET g_oma.oma54x = 0
      LET g_oma.oma51f = 0  #FUN-590100
      LET g_oma.oma54t = 0
      LET g_oma.oma55 = 0
      LET g_oma.oma56 = 0
      LET g_oma.oma56x = 0
      LET g_oma.oma51 = 0   #FUN-590100
      LET g_oma.oma56t = 0
      LET g_oma.oma57 = 0
      LET g_oma.oma59 = 0
      LET g_oma.oma59x = 0
      LET g_oma.oma59t = 0
      LET g_oma.oma34 = ' '  #No.+225
      LET g_oma.omaconf = 'N'
      LET g_oma.omavoid = 'N'
      LET g_oma.omaprsw = 0
      LET g_oma.omauser = g_user
      LET g_oma.omagrup = g_grup
      LET g_oma.omaoriu = g_user  #No.FUN-A40054
      LET g_oma.omaorig = g_grup  #No.FUN-A40054
      LET g_oma.omadate = g_today
      LET g_oma.omamksg = "N"     #No.FUN-540040
      LET g_oma.oma64 = "0"       #No.FUN-540040
      LET g_oma.oma70 = "2"       #FUN-960140 
      LET g_oma.oma65 = "1"       #No.FUN-570099
      LET g_oma.oma66 = g_plant   #No.FUN-630043
      LET g_oma.oma930=s_costcenter(g_oma.oma15)  #FUN-680001
      LET g_oma.omalegal = g_legal #FUN-980011 add
#No.FUN-AB0034 --begin
      LET g_oma.oma73 = 0
      LET g_oma.oma73f= 0
      LET g_oma.oma74 ='1'
#No.FUN-AB0034 --end
 
      CALL t300_i("a")                #輸入單頭
 
      IF INT_FLAG THEN
         INITIALIZE g_oma.* TO NULL
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         ROLLBACK WORK
         EXIT WHILE
      END IF
 
      IF g_oma.oma01 IS NULL THEN
         CONTINUE WHILE
      END IF
 
      BEGIN WORK  #No:7837
      CALL s_auto_assign_no("axr",g_oma.oma01,g_oma.oma02,g_oma.oma00,"oma_file","oma01","","","")
      RETURNING li_result,g_oma.oma01
      DISPLAY BY NAME g_oma.oma01
      IF (NOT li_result) THEN
         CONTINUE WHILE
      END IF
 
      IF g_oma.oma24 IS NULL THEN
         LET g_oma.oma24 = 0
      END IF
 
      IF g_oma.oma58 IS NULL THEN
         LET g_oma.oma58 = 0
      END IF
 
      ## No.2676 modify 1998/10/29 以原發票判斷格式-----------
      IF g_oma.oma00 = '21' OR g_oma.oma00 = '22' OR g_oma.oma00 = '23' OR
         g_oma.oma00 = '24' OR g_oma.oma00 = '25' THEN
         LET g_oma.oma11 = g_oma.oma02
         LET g_oma.oma12 = g_oma.oma02
      END IF
 
      LET li_dbs = ''
      IF NOT cl_null(g_oma.oma16) AND NOT cl_null(g_oma.oma66) THEN
         LET g_plant_new = g_oma.oma66
      ELSE
         LET g_plant_new = g_plant
      END IF
      #CALL s_gettrandbs()
      #LET li_dbs = g_dbs_tra

      IF g_oma.oma00 = '25' OR g_oma.oma00 = '21' THEN
         SELECT gec04,gec05,gec07,gec08,gec06
           INTO g_oma.oma211,g_oma.oma212,g_oma.oma213,
                g_oma.oma171,g_oma.oma172
           FROM gec_file
          WHERE gec01=g_oma.oma21 AND gec011='2'  #銷項
 
         IF g_oma.oma00 = '21' THEN
            #LET g_sql = " SELECT oma171 FROM ",li_dbs CLIPPED,"oha_file,oma_file",
            LET g_sql = " SELECT oma171 FROM ",cl_get_target_table(g_plant_new,'oha_file'), ",oma_file", #FUN-A50102           
                        "  WHERE oha01 = '",g_oma.oma16,"'",
                        "    AND ohaconf = 'Y'",
                        "    AND oha16 = oma01"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
		    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
            PREPARE sel_oha_pre84 FROM g_sql
            EXECUTE sel_oha_pre84 INTO l_oma171
         END IF
 
         IF g_oma.oma00 = '25' THEN
            SELECT oma171 INTO l_oma171 FROM oma_file
             WHERE oma01 = g_oma.oma16
               AND omaconf = 'Y'
         END IF
 
         IF l_oma171 = '31' THEN
            LET g_oma.oma171 = '33'
         END IF
 
         IF l_oma171 = '32' THEN
            LET g_oma.oma171 = '34'
         END IF
 
         IF l_oma171 = '36' THEN
            LET g_oma.oma171 = '34'
         END IF
      END IF

      #No.+074 010423 by linda add 外銷方式,經海關/非經海關等方式
      IF g_oma.oma00 = '12' AND g_oma.oma16 IS NOT NULL THEN
         #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oga_file ",
        #-MOD-AB0216-mark-
        #LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
        #            "    SET oga10 = '",g_oma.oma01,"',",
        #            "        oga05 = '",g_oma.oma05,"' ",
        #            "  WHERE oga01 = '",g_oma.oma16,"'"
        #CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	#CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
        #PREPARE upd_oga_pre15 FROM g_sql
        #EXECUTE upd_oga_pre15
        # IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
        #    CALL cl_err3("upd","oga_file",g_oma.oma16,"",SQLCA.SQLCODE,"","update oga_file",1)  #No.FUN-660116   #MOD-7A0179
        # END IF
        #-MOD-AB0216-end-
         #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oga_file ",
         LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                     "  WHERE oga01 = '",g_oma.oma16,"'",
                     "    AND oga00 !='2'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
		 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
         PREPARE sel_oga_pre16 FROM g_sql
         EXECUTE sel_oga_pre16
         LET g_oma.oma35 = l_oga.oga35
         LET g_oma.oma36 = l_oga.oga36
         LET g_oma.oma37 = l_oga.oga37
         LET g_oma.oma38 = l_oga.oga38
         LET g_oma.oma39 = l_oga.oga39
 
      END IF
 
      IF g_oma.oma00 = '21' AND g_oma.oma16 IS NOT NULL THEN
         IF cl_null(g_oma.oma34) THEN
            LET g_oma.oma34 = g_oha.oha09
         END IF
      END IF
 
      LET g_oma.oma60=g_oma.oma24
      LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
      CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                  
      LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                         
 
      IF g_oma.oma00 MATCHES '1*' THEN
         SELECT gec08,gec06 INTO g_oma.oma171,g_oma.oma172
           FROM gec_file WHERE gec01=g_oma.oma21 AND gec011='2'
      END IF
 
     #LET g_sql = " SELECT oga27 FROM ",li_dbs CLIPPED,"oga_file",
     LET g_sql = " SELECT oga27 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                 "  WHERE oga01 = '",g_oma.oma16,"'"
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
     PREPARE sel_oga_pre66 FROM g_sql
     EXECUTE sel_oga_pre66 INTO g_oma.oma67
 
       LET g_oma.omaoriu = g_user      #No.FUN-980030 10/01/04   
       LET g_oma.omaorig = g_grup      #No.FUN-980030 10/01/04    
       LET g_oma.omauser = g_oma.oma14     #No:110927  Add  <<--yangjian--
       LET g_oma.omagrup = g_oma.oma15     #No:110927  Add  <<--yangjian--
#No.FUN-AB0034 --begin
   IF cl_null(g_oma.oma73) THEN LET g_oma.oma73 =0 END IF
   IF cl_null(g_oma.oma73f) THEN LET g_oma.oma73f =0 END IF
   IF cl_null(g_oma.oma74) THEN LET g_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
      INSERT INTO oma_file VALUES (g_oma.*)
       IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
          ROLLBACK WORK  #No:7837
          CALL cl_err3("ins","oma_file",g_oma.oma01,"",SQLCA.SQLCODE,"","",1)  #No.FUN-660116
          CONTINUE WHILE
        END IF
 
      ##No.2939 modify 1998/12/18新增應收時須UPDATE回出貨單或銷退單頭
     #-MOD-AB0216-mark-
     #IF g_oma.oma00 = '12' AND g_oma.oma16 IS NOT NULL THEN
     #  #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oga_file ",
     #   LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
     #               "    SET oga10 = '",g_oma.oma01,"',",
     #               "        oga05 = '",g_oma.oma05,"' ",
     #               "  WHERE oga01 = '",g_oma.oma16,"'"
     #   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
     #       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
     #   PREPARE upd_oga_pre17 FROM g_sql
     #   EXECUTE upd_oga_pre17
     #END IF
     #-MOD-AB0216-end-

     #-CHI-A50040-mark- 
     #IF g_oma.oma00 = '13' AND g_oma.oma16 IS NOT NULL AND
     #   g_oma.oma162=0 THEN
     #   UPDATE oga_file SET oga10 = g_oma.oma01,
     #                        oga05 = g_oma.oma05   #No.MOD-570266
     #    WHERE oga01 = g_oma.oma16
     #   LET g_sql = " UPDATE ",li_dbs CLIPPED,"oga_file ",
     #               "    SET oga10 = '",g_oma.oma01,"',",
     #               "        oga05 = '",g_oma.oma05,"' ",
     #               "  WHERE oga01 = '",g_oma.oma16,"'"
     #   PREPARE upd_oga_pre18 FROM g_sql
     #   EXECUTE upd_oga_pre18
     #END IF
     #-CHI-A50040-end- 
 
      IF g_oma.oma00 = '21' AND g_oma.oma16 IS NOT NULL THEN
         #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oha_file ",
         LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                     "    SET oha10 = '",g_oma.oma01,"'",
                     "  WHERE oha01 = '",g_oma.oma16,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
         PREPARE upd_oga_pre19 FROM g_sql
         EXECUTE upd_oga_pre19
      END IF
 
      COMMIT WORK
 
      CALL cl_flow_notify(g_oma.oma01,'I')
 
      SELECT oma01 INTO g_oma.oma01 FROM oma_file WHERE oma01 = g_oma.oma01
 
      LET g_oma_t.* = g_oma.*
      CALL g_omb.clear()
      LET g_rec_b=0
 
      CALL t300_b()                   #輸入單身
 
      EXIT WHILE
   END WHILE
 
    CALL cl_set_act_visible("entry_sheet,entry_sheet2,
                             T_T_entry_sheet,T_T_entry_sheet2",TRUE)
    IF cl_null(g_oma.oma99) THEN
       CALL cl_set_act_visible("T_T_entry_sheet,T_T_entry_sheet2",FALSE)
       IF g_aza.aza63 = 'N' THEN
          CALL cl_set_act_visible("entry_sheet2",FALSE)  
       END IF
    ELSE
       CALL cl_set_act_visible("entry_sheet,entry_sheet2",FALSE)
       IF g_aza.aza63 = 'N' THEN
          CALL cl_set_act_visible("T_T_entry_sheet2",FALSE)  
       END IF
    END IF  
 
END FUNCTION
 
FUNCTION t300_d2( )
   DEFINE l_oma01         LIKE oma_file.oma01
   DEFINE t_oma01         LIKE oma_file.oma01
   DEFINE t_omad          DYNAMIC ARRAY OF RECORD
                             sel      LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
                             oma01    LIKE oma_file.oma01,
                             oma23    LIKE oma_file.oma23,
                             oma54    LIKE oma_file.oma54,
                             oma54x   LIKE oma_file.oma54x,
                             oma54t   LIKE oma_file.oma54t,
                             oma56    LIKE oma_file.oma56,
                             oma56x   LIKE oma_file.oma56x,
                             oma56t   LIKE oma_file.oma56t
                          END RECORD
   DEFINE p_col,p_row     LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE i,j,k           LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_omad_arrno    LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE t56,t56x,t56t   LIKE oma_file.oma56t
   DEFINE p56,p56x,p56t   LIKE oma_file.oma56t
   DEFINE ls_tmp          STRING
   DEFINE l_allow_insert  LIKE type_file.num5      #No.FUN-680123 SMALLINT              #可新增否
   DEFINE l_allow_delete  LIKE type_file.num5      #No.FUN-680123 SMALLINT              #可刪除否
   DEFINE l_row_count     LIKE type_file.num5      #No.FUN-680123 SMALLINT              #No.FUN-570099
   DEFINE l_sql           STRING                   #No.FUN-680123 VARCHAR(500)             #No.TQC-5B0175
 
   IF s_shut(0) THEN RETURN END IF
 
   IF cl_null(g_oma.oma01) THEN
      CALL cl_err(g_oma.oma01,'axr-350',0)
      RETURN
   END IF
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
 
   IF g_oma.oma00 MATCHES '21' THEN
      CALL cl_err('','axr-905',0)
      RETURN
   END IF
 
   IF g_oma.omavoid = 'Y' THEN
      RETURN
   END IF
 
   LET p_row = 6 LET p_col = 4
   OPEN WINDOW t300d2_w AT p_row,p_col
     WITH FORM "gxr/42f/gxrt300d2"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   CALL cl_ui_locale("gxrt300d2")
 
   IF g_oma.omaconf = 'Y' THEN
      LET l_sql = "SELECT 'Y',oot01,oot06,oot04,oot04x,oot04t,oot05, ",
                  "       oot05x,oot05t  ",
                  "  FROM oot_file  ",
                  " WHERE oot03 = '",g_oma.oma01,"' "
   ELSE
      LET l_sql = "SELECT 'N',oma01,oma23,oma54,oma54x,oma54t,oma56, ",
                  "       oma56x,oma56t  ",
                  "  FROM oma_file,ooy_file ",
                  " WHERE oma00 = '21' ",
                  "   AND oma03 = '",g_oma.oma03,"' ",
                  "   AND omaconf = 'Y' ",
                  "   AND oma23 = '",g_oma.oma23,"' ",
                  "   AND oma55 = 0 ",             #未衝
                  "   AND ooyslip = oma01[",1 ,",",g_doc_len,"] ",   #No.FUN-9B0044
                  "   AND ooydmy1 = 'N' ",
                  "   AND oma01 NOT IN(SELECT oot01 ",
                  "  FROM oot_file,oma_file  ",
                  " WHERE oot01=oma01) ",
                  " UNION ALL ",
                  "SELECT 'Y',oot01,oot06,oot04,oot04x,oot04t,oot05, ",
                  "       oot05x,oot05t  ",
                  "  FROM oot_file ",
                  " WHERE oot03 = '",g_oma.oma01,"' "
   END IF

   PREPARE oma_tmp_pl1 FROM l_sql
   DECLARE oma_tmp_cl1 CURSOR FOR oma_tmp_pl1
 
   IF STATUS THEN
      CALL cl_err('oma_tmp_c11',STATUS,1)
      CLOSE WINDOW t300d2_w
      RETURN
   END IF
 
   LET l_omad_arrno = 250
   CALL t_omad.clear()
   LET i = 1
   LET t56 = 0
   LET t56x = 0
   LET t56t = 0           #No.A120
   LET p56 = 0
   LET p56x = 0
   LET p56t = 0           #No.A120
 
   FOREACH oma_tmp_cl1 INTO t_omad[i].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
 
      INSERT INTO omad_tmp VALUES(t_omad[i].*)
      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("ins","omad_tmp",t_omad[i].oma01,"",STATUS,"","ins omad_tmp",1)  #No.FUN-660116
         CLOSE WINDOW t300d2_w
         RETURN               #No.A120
      END IF
 
      IF t_omad[i].sel = 'Y' THEN
         LET p56  = p56  + t_omad[i].oma56
         LET p56x = p56x + t_omad[i].oma56x
         LET p56t = p56t + t_omad[i].oma56t
      END IF
 
      LET i = i + 1
      IF i > l_omad_arrno THEN
         CALL cl_err('',9035,0)
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL SET_COUNT(i-1)
   LET i=i-1
   LET l_row_count = i         #No.FUN-570099

   IF g_oma.omaconf = 'Y' THEN

      DISPLAY BY NAME t56,t56x,t56t,p56,p56x,p56t

      DISPLAY ARRAY t_omad TO s_omad.*
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DISPLAY
        
         ON ACTION about         
            CALL cl_about()      
        
         ON ACTION help          
            CALL cl_show_help()  
        
         ON ACTION controlg      
            CALL cl_cmdask()     
      END DISPLAY 

      CLOSE WINDOW t300d2_w

      RETURN

   END IF
 
   WHILE TRUE
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")
 
      INPUT ARRAY t_omad WITHOUT DEFAULTS FROM s_omad.*
            ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
         BEFORE INPUT
            CALL fgl_set_arr_curr(l_ac)
 
         BEFORE ROW
            LET t56 = 0
            LET t56x = 0
            LET t56t = 0
            LET p56 = 0
            LET p56x = 0
            LET p56t = 0
 
            FOR i=1 TO l_row_count      #No.FUN-570099
               IF cl_null(t_omad[i].oma01) THEN
                  CONTINUE FOR
               END IF
               LET t56 = t56 + t_omad[i].oma56
               LET t56x = t56x + t_omad[i].oma56x
               LET t56t = t56t + t_omad[i].oma56t
               IF t_omad[i].sel = 'Y' THEN
                  LET p56 = p56 + t_omad[i].oma56
                  LET p56x = p56x + t_omad[i].oma56x
                  LET p56t = p56t + t_omad[i].oma56t
               END IF
            END FOR
            DISPLAY BY NAME t56,t56x,t56t,p56,p56x,p56t
            CALL cl_show_fld_cont()     #FUN-550037(smin)
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT INPUT
            END IF
 
            IF p56 > g_oma.oma56 OR p56x > g_oma.oma56x OR
               p56t > g_oma.oma56t THEN
               CALL cl_err('','gxr-004',0)
            END IF
 
            FOR i = 1 TO l_omad_arrno
               IF cl_null(t_omad[i].oma01) THEN
                  CONTINUE FOR
               END IF
 
               IF t_omad[i].sel = 'Y' THEN
                  CONTINUE FOR
               END IF
               DELETE FROM omad_tmp WHERE omad01 = t_omad[i].oma01
            END FOR
 
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
 
      EXIT WHILE
   END WHILE
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW t300d2_w
      RETURN
   END IF
 
   BEGIN WORK
   LET g_success = 'Y'
   DELETE FROM oot_file WHERE oot03 = g_oma.oma01
 
   FOR i=1 TO l_omad_arrno
      IF cl_null(t_omad[i].oma01) THEN
         CONTINUE FOR
      END IF
 
      IF t_omad[i].sel != 'Y' OR cl_null(t_omad[i].sel) THEN
         CONTINUE FOR
      END IF
 
      INSERT INTO oot_file(oot01,oot02,oot03,oot04,oot04x,oot04t,oot05,
                           oot05x,oot05t,oot06,
                           ootlegal) #FUN-980011 add
                    VALUES(t_omad[i].oma01,g_oma.oma03,g_oma.oma01,
                           t_omad[i].oma54,t_omad[i].oma54x,t_omad[i].oma54t,
                           t_omad[i].oma56,t_omad[i].oma56x,t_omad[i].oma56t,
                           t_omad[i].oma23,
                           g_legal)   #FUN-980011 add
      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("ins","oot_file",t_omad[i].oma01,"",STATUS,"","ins oot",1)  #No.FUN-660116
         LET g_success = 'N'
         EXIT FOR  #No.A12
      END IF
   END FOR
 
   IF g_success = 'Y' THEN
      CALL cl_cmmsg(4)
      COMMIT WORK
   ELSE
      CALL cl_rbmsg(4)
      ROLLBACK WORK
   END IF
 
   CLOSE WINDOW t300d2_w
 
END FUNCTION
 
FUNCTION t300_g()
   DEFINE s    LIKE type_file.num10     #No.FUN-680123  INTEGER
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
 
   IF g_aza.aza26 = '2' THEN
      IF g_oma.oma00 = '23' OR g_oma.oma00 = '24' OR g_oma.oma00 ='31' THEN
         CALL cl_err('','axr-905',0)
         RETURN
      END IF
   ELSE
      IF g_oma.oma00 MATCHES '2*' THEN
         CALL cl_err('','axr-905',0)
         RETURN
      END IF
   END IF

  #CHI-A20013---add---start---
   IF g_ooz.ooz64 = 'N' AND g_oma.oma08 = '2' AND
      g_aza.aza26 = '0' THEN    
      CALL cl_err('','axr-079',0)
      RETURN
   END IF
  #CHI-A20013---add---end---

#发票开立时，不管控是否关帐by zhangym 120706 begin----- 
#   #FUN-B50090 add begin-------------------------
#   #重新抓取關帳日期
#   SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
#   #FUN-B50090 add -end--------------------------
#  #-MOD-A70191-add-
#   IF g_oma.oma02 <= g_ooz.ooz09 THEN
#      CALL cl_err('','axr-164',0)
#      LET g_success='N'
#      RETURN
#   END IF
#  #-MOD-A70191-end-
#by zhangym 120706 end-----   

  #str MOD-B30597 add
  #當oma59t為0時,提示訊息"發票金額為0,不可產生發票資料!",且不產生ome_file資料
   IF g_oma.oma59t = 0 THEN
      CALL cl_err('','axr-325',0)
      LET g_success='N'
      RETURN
   END IF
  #end MOD-B30597 add

  #-MOD-B40217-add-
   IF cl_null(g_oma.oma212) THEN
      CALL cl_err('','axr-089',0)
      RETURN
   END IF
  #-MOD-B40217-end-

   CALL t300_g_guino() RETURNING s
 
   IF s = 1 THEN
      LET g_oma.oma09 = g_oma_t.oma09
      LET g_oma.oma05 = g_oma_t.oma05
      LET g_oma.oma10 = g_oma_t.oma10
      LET g_oma.oma58 = g_oma_t.oma58
      LET g_oma.oma11 = g_oma_t.oma11   #No.MOD-530227
      LET g_oma.oma12 = g_oma_t.oma12   #No.MOD-530227
      DISPLAY BY NAME g_oma.oma09,g_oma.oma05,g_oma.oma10,g_oma.oma58,
                      g_oma.oma11,g_oma.oma12   #No.MOD-530227
   END IF
 
   #No.+074 010423 add by linda 若為外銷開窗輸入文件資料(媒體申報用)
   IF g_oma.oma08 MATCHES '[23]' AND g_oma.oma00 MATCHES '1*' THEN  #No.MOD-910093
      CALL t300_1()
   END IF
 
END FUNCTION
 
FUNCTION t300_g_guino()
   DEFINE p_cmd        LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINE l_oom        RECORD LIKE oom_file.*
   DEFINE l_omb        RECORD LIKE omb_file.*
   DEFINE l_oma        RECORD LIKE oma_file.*
   DEFINE l_ome        RECORD LIKE ome_file.*
   DEFINE x            RECORD LIKE omb_file.*
   DEFINE oma10_t      LIKE oma_file.oma10      #No.FUN-680123 VARCHAR(16) #FUN-540057
   DEFINE old_oma58    LIKE oma_file.oma58      #FUN-4C0013
   DEFINE l_oga909     LIKE oga_file.oga909     #三角貿易否
   DEFINE l_oga16      LIKE oga_file.oga16      #訂單單號
   DEFINE l_mm         LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_oea904     LIKE oea_file.oea904     #流程代碼
   DEFINE l_oag03      LIKE oag_file.oag03      #No.MOD-530227
   DEFINE l_cnt        LIKE type_file.num5      #CHI-780036
   DEFINE l_ome02_1,l_ome02_2  LIKE ome_file.ome02   #MOD-7C0206
   DEFINE l_omee       RECORD LIKE omee_file.*  #CHI-A70028 add
   DEFINE l_flag       LIKE type_file.chr1      #MOD-AA0044
   DEFINE l_oeaa08     LIKE oeaa_file.oeaa08    #CHI-B90025 add
   DEFINE l_oea01      LIKE oea_file.oea01      #CHI-B90025 add   
 
   IF s_shut(0) THEN RETURN 1 END IF
 
   IF cl_null(g_oma.oma01) THEN
      CALL cl_err(g_oma.oma01,'axr-350',0)
      RETURN 1
   END IF
 
   IF g_oma.omavoid = 'Y' THEN RETURN 1 END IF   #bugno:5930 add return 1
 
   IF NOT cl_null(g_oma.oma10) THEN
      CALL cl_err(g_oma.oma01,'axr-348',0)
      RETURN 1
   END IF
 
   #------97/08/01 modify 若參數ooz20是否須確認後才可開立發票為Y
   #------97/05/26 modify 須確認才可開立發票
   IF g_ooz.ooz20 = 'Y' THEN
      IF g_oma.omaconf = 'N' THEN
         CALL cl_err(g_oma.oma01,'axr-349',0)
         RETURN 1
      END IF
   END IF
 
   LET l_oga909='N'

    LET li_dbs = ''
    IF NOT cl_null(g_oma.oma66) THEN
       LET g_plant_new = g_oma.oma66
    ELSE
       LET g_plant_new = g_plant
    END IF
    #CALL s_gettrandbs()
    #LET li_dbs = g_dbs_tra
 
   #-----99/01/25 for cec 若為三角貿易則發票單價不重算
   IF g_oma.oma00='12' THEN
      #LET g_sql = " SELECT oga16,oga909 FROM ",li_dbs CLIPPED,"oga_file",
      LET g_sql = " SELECT oga16,oga909 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                  "  WHERE oga01='",g_oma.oma16,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
      PREPARE sel_oga_pre81 FROM g_sql
      EXECUTE sel_oga_pre81 INTO l_oga16,l_oga909
      IF SQLCA.SQLCODE <>0 OR l_oga909 IS NULL THEN
         LET l_oga909='N'
      END IF
   END IF
 
   IF cl_null(l_oga909) THEN
      LET l_oga909 = 'N'
   END IF
 
   LET g_oga909 = l_oga909  #for genero
 
   IF l_oga909 = 'Y' THEN
      #讀取流程代碼
      #LET g_sql = " SELECT oea904 FROM ",li_dbs CLIPPED,"oea_file",
      LET g_sql = " SELECT oea904 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                  "  WHERE oea01='",l_oga16,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
      PREPARE sel_oea_pre82 FROM g_sql
      EXECUTE sel_oea_pre82 INTO l_oea904
 
      LET g_unikey='N'
   ELSE
      LET g_unikey='N'
   END IF
 
   BEGIN WORK
   LET g_success='Y'
   LET l_flag = 'N'                    #MOD-AA0044
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN 1   #MOD-920038 mod 增加回傳值
   END IF
 
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN 1   #MOD-920038 mod 增加回傳值
   END IF
 
   CALL cl_set_comp_entry("oma09,oma05,oma10,oma58",TRUE)
   IF g_oga909='Y' THEN
      CALL cl_set_comp_entry("oma58",FALSE)
   END IF
   #若有發票待扺資料則不可更改發票匯率
   SELECT COUNT(*) INTO l_cnt FROM oot_file WHERE oot03 = g_oma.oma01
   IF l_cnt > 0 THEN
      CALL cl_set_comp_entry("oma58",FALSE)
   END IF
 
   INPUT BY NAME g_oma.oma09,g_oma.oma05,g_oma.oma10,g_oma.oma58 WITHOUT DEFAULTS
 
      AFTER FIELD oma05 
        IF g_ooz.ooz32='Y' OR  g_aza.aza26<>'2' THEN     #FUN-C60033      
        #-MOD-AA0153-add-
         IF NOT cl_null(g_oma.oma05) THEN
            CALL t300_oma71() 
         ELSE
            CALL cl_err(g_oma.oma10,'atm-064',0)
            NEXT FIELD oma05
         END IF 
        #-MOD-AA0153-end-
       END IF                                          #FUN-C60033        
 
     #-MOD-B60081-mark- 
     #AFTER FIELD oma09 
     #   IF g_oma.oma23!=g_aza.aza17 THEN
     #      IF g_oma.oma08='1' THEN
     #         LET exT=g_ooz.ooz17
     #      ELSE
     #         LET exT=g_ooz.ooz63
     #      END IF
     #      CALL s_curr3(g_oma.oma23,g_oma.oma09,exT) RETURNING g_oma.oma58
     #   END IF
     #   DISPLAY BY NAME g_oma.oma58
     #-MOD-B60081-end- 

#mark by zhangym 120619 begin----- 
#      BEFORE FIELD oma10            # 賦予最大 GUI NO
#         IF g_ooz.ooz32='Y' OR  g_aza.aza26<>'2' THEN    #FUN-C60033
#         IF g_oma.oma10 IS NULL THEN
#            #99.01.25 for cec三角貿易
#            IF g_unikey = 'N' THEN
#               CALL s_guiauno(g_oma.oma10,g_oma.oma09,g_oma.oma05,g_oma.oma212)
#                    RETURNING g_i,oma10_t
#            ELSE
#               CALL s_guiauno(g_oma.oma10,g_oma.oma09,g_oma.oma05,g_gec.gec05)
#                    RETURNING g_i,oma10_t
#            END IF
# 
#            IF NOT g_i THEN
#               LET g_oma.oma10 = oma10_t
#               DISPLAY BY NAME g_oma.oma10
#            END IF
#         END IF
#         END IF               #FUN-C60033
#mark by zhangym 120619 end-----          
 
      AFTER FIELD oma10
         IF g_ooz.ooz32='Y' OR  g_aza.aza26<>'2' THEN    #FUN-C60033      
         IF NOT cl_null(g_oma.oma10) THEN
#mark by zhangym 120605 begin-----         
#            SELECT * INTO l_oom.* FROM oom_file
#             WHERE oom07 <= g_oma.oma10
#               AND oom08 >= g_oma.oma10
#               AND oom03  = g_oma.oma05   #MOD-920162 add
#            IF STATUS THEN
#               CALL cl_err3("sel","oom_file",g_oma.oma10,g_oma.oma10,"axr-128","","",1)  #No.FUN-660116
#               NEXT FIELD oma10
#            END IF
# 
#            LET l_mm = MONTH(g_oma.oma09)
#            IF g_oma.oma10 > l_oom.oom09 AND g_oma.oma09 < l_oom.oom10 THEN
#               CALL cl_err(g_oma.oma10,'axr-208',0)
#               NEXT FIELD oma10
#            END IF
# 
#            IF g_oma.oma10 <= l_oom.oom09 THEN 
#               DECLARE axr_ome_c_1 SCROLL CURSOR FOR
#                 SELECT ome02 FROM ome_file
#                   WHERE ome01 BETWEEN l_oom.oom07 AND l_oom.oom08
#                     AND ome01 <= g_oma.oma10
#                   ORDER BY ome01
#               OPEN axr_ome_c_1
#               FETCH LAST axr_ome_c_1 INTO l_ome02_1
#               DECLARE axr_ome_c_2 SCROLL CURSOR FOR
#                 SELECT ome02 FROM ome_file
#                   WHERE ome01 BETWEEN l_oom.oom07 AND l_oom.oom08
#                     AND ome01 >= g_oma.oma10
#                   ORDER BY ome01
#               OPEN axr_ome_c_2
#               FETCH FIRST axr_ome_c_2 INTO l_ome02_2
#               IF NOT (g_oma.oma09 >= l_ome02_1 AND 
#                       g_oma.oma09 <= l_ome02_2) AND 
#                       g_aza.aza26 = '0' THEN         #MOD-A50077 add                         
#                  CALL cl_err(g_oma.oma10,'axr-046',0)
#                  NEXT FIELD oma10
#               END IF  
#            END IF
# 
#            IF l_oom.oom04 != g_oma.oma212 THEN
#               IF g_aza.aza26 = '2' THEN
#                  CALL cl_err(g_oma.oma10,'axr-127',0)
#               ELSE
#                  CALL cl_err(g_oma.oma10,'axr-129',0)
#               END IF
#               NEXT FIELD oma10
#            END IF
# 
#            IF l_oom.oom01!=YEAR(g_oma.oma09) OR
#               NOT l_oom.oom02 <= l_mm <= l_oom.oom021 THEN
#               CALL cl_err(g_oma.oma10,'axr-314',0)
#               NEXT FIELD oma10
#            END IF
# 
#            #台灣版發票長度需輸入10碼
#            IF g_aza.aza26 != '2' THEN
#               IF g_oma.oma171 != 'XX' THEN
#                  IF LENGTH(g_oma.oma10) != 10 THEN
#                     CALL cl_err(g_oma.oma10,'amd-010',0)
#                     NEXT FIELD oma10
#                  END IF
#               END IF
#            END IF
# 
#            SELECT * INTO l_ome.* FROM ome_file WHERE ome01=g_oma.oma10
# 
#            IF STATUS = 0 THEN
#               IF g_ooz.ooz11='Y' AND l_ome.omevoid='N' AND
#                  l_ome.ome04=g_oma.oma04 AND l_ome.ome21=g_oma.oma21 THEN   #MOD-870095
#                  IF NOT cl_confirm('axr-322') THEN
#                     NEXT FIELD oma10
#                  ELSE
#                     LET l_flag = 'Y'                    #MOD-AA0044
#                     UPDATE ome_file SET ome59 = l_ome.ome59 + g_oma.oma59,
#                                         ome59x= l_ome.ome59x + g_oma.oma59x,
#                                         ome59t= l_ome.ome59t + g_oma.oma59t,
#                                         ome16 = ''
#                       WHERE ome01 = g_oma.oma10
#                     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#                        CALL cl_err('upd ome',SQLCA.SQLCODE,1)
#                        NEXT FIELD oma10
#                     END IF
#                     #CHI-A70028 add --start--
#                     INITIALIZE l_omee.* TO NULL
#                     LET l_omee.omee01 = l_ome.ome01
#                    #LET l_omee.omee02 = l_ome.ome16        #TQC-AB0075 mark
#                     LET l_omee.omee02 = g_oma.oma01        #TQC-AB0075
#                     LET l_omee.omeedate = TODAY
#                     LET l_omee.omeegrup = g_grup
#                     LET l_omee.omeelegal = g_legal
#                     LET l_omee.omeeorig = g_grup
#                     LET l_omee.omeeoriu = g_user
#                     LET l_omee.omeeuser = g_user
#
#                     INSERT INTO omee_file VALUES(l_omee.*)
#                     IF SQLCA.SQLCODE AND (NOT cl_sql_dup_value(SQLCA.SQLCODE)) THEN
#                        CALL cl_err('upd omee',SQLCA.SQLCODE,1)
#                        NEXT FIELD oma10
#                     END IF
#                     #CHI-A70028 add --end--
#                  END IF
#               ELSE
#                  CALL cl_err('sel ome','-239',1)
#                  NEXT FIELD oma10
#               END IF
#            END IF
#mark by zhangym 120605 end----- 
            CALL t300_oma71()   #FUN-970108 add
         END IF
         DISPLAY BY NAME g_oma.oma10
       END IF                                                        #FUN-C60033         
 
       BEFORE FIELD oma58
          LET old_oma58=g_oma.oma58
          IF g_oma.oma23!=g_aza.aza17 AND (g_oma.oma58=0 OR g_oma.oma58=1) THEN
             IF g_oma.oma08='1' THEN
                LET exT=g_ooz.ooz17
             ELSE
                LET exT=g_ooz.ooz63
             END IF
             CALL s_curr3(g_oma.oma23,g_oma.oma09,exT) RETURNING g_oma.oma58
          END IF
          DISPLAY BY NAME g_oma.oma58
 
       AFTER FIELD oma58
          IF NOT cl_null(g_oma.oma58) THEN
             IF g_oma.oma58 != old_oma58 OR old_oma58 IS NULL THEN
                IF cl_confirm('axr-175') THEN   #TQC-6C0046
                   LET i = 1
                   LET l_oma.oma59 = 0
                   LET l_oma.oma59t = 0
                   DECLARE t300_oma58_c2 CURSOR FOR SELECT * FROM omb_file
                                                     WHERE omb01 = g_oma.oma01
 
                   FOREACH t300_oma58_c2 INTO x.*
                      IF STATUS THEN
                         EXIT FOREACH
                      END IF
 
                      LET x.omb17 =x.omb13 *g_oma.oma58
                      LET x.omb18 =x.omb14 *g_oma.oma58
                      LET x.omb18t=x.omb14t*g_oma.oma58
                      CALL cl_digcut(x.omb17,g_azi03) RETURNING x.omb17  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18,g_azi04) RETURNING x.omb18  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18t,g_azi04)RETURNING x.omb18t #No.TQC-750093 t_azi -> g_azi
                      LET l_oma.oma59 = l_oma.oma59 + x.omb18
                      LET l_oma.oma59t= l_oma.oma59t+ x.omb18t
 
                      DISPLAY x.omb17,x.omb18,x.omb18t
                           TO s_omb[i].omb17,s_omb[i].omb18,s_omb[i].omb18t
 
                      LET i = i + 1
                      UPDATE omb_file SET * = x.*
                       WHERE omb01 = g_oma.oma01
                         AND omb03 = x.omb03
                   END FOREACH
      
                  #-TQC-B60089-add-
                   LET g_ogb_o.* = g_ogb.*
                   LET g_sql = " SELECT * ",
                               "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                               "  WHERE ogb01 = '",x.omb31,"'",
                               "    AND ogb03 = '",x.omb32,"'"
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                   PREPARE sel_ogb_pre20 FROM g_sql
                   EXECUTE sel_ogb_pre20 INTO g_ogb.*
                  #-TQC-B60089-end-
                  #-------------------------------No.CHI-B90025----------------------------------start
                   IF g_oma.oma00='11' THEN
                      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                       WHERE oeaa01 = g_oma.oma16
                         AND oeaa02 = '1'
                         AND oeaa03 = g_oma.oma165
                         AND oeaa01 = oea01
                   END IF
                   IF g_oma.oma00='13' THEN
                      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                       WHERE oeaa01 = g_oma.oma16
                         AND oeaa02 = '2'
                         AND oeaa03 = g_oma.oma165
                         AND oeaa01 = oea01
                   END IF
                   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                  #CALL t300_bu()
                  #-------------------------------No.CHI-B90025----------------------------------end
                   LET g_ogb.* = g_ogb_o.*     #TQC-B60089
 
                   DISPLAY BY NAME g_oma.oma59,g_oma.oma59t
                END IF
             END IF
          END IF
 
        AFTER INPUT
            IF INT_FLAG THEN   
               LET g_oma.oma71 = g_oma_t.oma71  #NO.FUN-970108
               DISPLAY BY NAME g_oma.oma71      #NO.FUN-970108                                                                                                     
               LET INT_FLAG = 0                                                                                                     
               ROLLBACK WORK                                                                                                        
               RETURN 1                                                                                                             
            END IF
            IF g_ooz.ooz32='Y' OR  g_aza.aza26<>'2' THEN    #FUN-C60033             
         #mark by zhangym 120621 begin------                                                                                                                 
         #   IF l_flag='N' THEN                  #TQC-AB0075 
         #      IF g_unikey='N' THEN   
         #         CALL s_guiauno(g_oma.oma10,g_oma.oma09,g_oma.oma05,g_oma.oma212) 
         #              RETURNING g_i,oma10_t  
         #      ELSE               
         #         CALL s_guiauno(g_oma.oma10,g_oma.oma09,g_oma.oma05,g_gec.gec05)
         #              RETURNING g_i,oma10_t 
         #      END IF 
         #   END IF
         #mark by zhangym 120621 end------                                             #TQC-AB0075
           #-MOD-AA0044-add-
            LET l_cnt = 0 
            SELECT COUNT(*) INTO l_cnt
             FROM ome_file
            WHERE ome01 = g_oma.oma10
            IF l_cnt > 0 AND l_flag = 'N' THEN      
               CALL cl_err('sel ome','aec-009',1)
               LET g_oma.oma10 = ''
               CONTINUE INPUT
            END IF  
           #-MOD-AA0044-end- 
            END IF  #FUN-C60033                    
            IF g_i THEN 
               NEXT FIELD oma10 
            END IF    
 
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
      RETURN 1
   END IF
 
   # 判斷發票是否有值
   IF g_oma.oma10 IS NULL OR g_oma.oma10 = ' ' THEN
      LET INT_FLAG = 0
      ROLLBACK WORK
      RETURN 1
   END IF
 
   SELECT oag03 INTO l_oag03 FROM oag_file
    WHERE oag01 = g_oma.oma32
 
   IF l_oag03 = "2" OR l_oag03 = "5" THEN
      IF cl_confirm("axr-933") THEN
         IF NOT cl_null(g_oma.oma66) THEN
            LET g_plant2=g_oma.oma66 
         ELSE
            LET g_plant2 = g_plant
         END IF
         CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                       g_oma.oma02,g_plant2) #FUN-980020
             RETURNING g_oma.oma11,g_oma.oma12
         DISPLAY BY NAME g_oma.oma11,g_oma.oma12
      END IF
   END IF
 
   UPDATE oma_file SET oma05 = g_oma.oma05,
                       oma09 = g_oma.oma09,
                       oma10 = g_oma.oma10,
                       oma58 = g_oma.oma58,
                       oma11 = g_oma.oma11,   #No.MOD-530227
                       oma12 = g_oma.oma12,   #No.MOD-530227
                       oma71 = g_oma.oma71    #FUN-970108
    WHERE oma01 = g_oma.oma01
 
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err('upd oma',SQLCA.SQLCODE,1)
      ROLLBACK WORK
      RETURN 1
   END IF
 
   IF l_oga909 = 'N' THEN  #No.9340
      CALL s_up_omb(g_oma.oma01)
      SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
   END IF
  #CALL t300_ins_omc('1')   #No.FUN-680022   ##TQC-750177  #MOD-9C0409       #MOD-B40264 mark
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
   CALL t300_show()
 
   LET g_oma_t.* = g_oma.*
 
   IF g_unikey = 'N' THEN
      CALL s_insome(g_oma.oma01,g_oma.oma21,'') #No.FUN-9C0014
   ELSE
      CALL s_insome(g_oma.oma01,g_gec.gec01,'') #No.FUN-9C0014
   END IF
 
   IF g_success='N' THEN
      ROLLBACK WORK
      RETURN 1
   END IF
 
   COMMIT WORK
   RETURN 0
 
END FUNCTION
 
FUNCTION t300_g_b()                       #由出貨單或訂單自動產生單身
 
   IF cl_null(g_oma.oma16) THEN
      RETURN
   END IF
 
   LET g_cnt = 0
 
   SELECT COUNT(*) INTO g_cnt FROM omb_file WHERE omb01=g_oma.oma01
 
   IF g_cnt > 0 THEN            #已有單身則不可再產生
      RETURN
   END IF
  #-MOD-AB0025-add-
   SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05    
     FROM azi_file WHERE azi01=g_oma.oma23
  #-MOD-AB0025-end-

   LET li_dbs = ''
   IF NOT cl_null(g_oma.oma16) AND NOT cl_null(g_oma.oma66) THEN
      LET g_plant_new = g_oma.oma66
   ELSE
      LET g_plant_new = g_plant
   END IF
   #CALL s_gettrandbs()
   #LET li_dbs = g_dbs_tra
 
   CASE WHEN g_oma.oma00='11' CALL t300_g_b1()
        WHEN g_oma.oma00='12' CALL t300_g_b2()
        WHEN g_oma.oma00='13' CALL t300_g_b3()   #No.+172 010614 mark plum  #No.TQC-690110 unmark
        WHEN g_oma.oma00='21' CALL t300_g_b4()
        WHEN g_oma.oma00='25' CALL t300_g_b5()   #add 2000/04/25
   END CASE
 
END FUNCTION
 
FUNCTION t300_g_b1()                       #由訂單產生單身
   DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
   DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add  
   IF NOT cl_confirm('axr-132') THEN
      RETURN
   END IF

   LET g_sql = "SELECT oeb_file.* ",
               #"  FROM ",li_dbs CLIPPED,"oea_file,",li_dbs CLIPPED,"oeb_file",
               "  FROM ",cl_get_target_table(g_plant_new,'oea_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'oeb_file'),     #FUN-A50102
               " WHERE oeb01 = '",g_oma.oma16,"'",
               "   AND oeb01 = oea01",
               "   AND oea00 = '1'",
               "   AND oeaconf = 'Y'",
               "   AND oeb1003 ! = '2'",
               "   AND oeb1012 ! = 'Y'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
   DECLARE t300_g_b_c1 CURSOR FROM g_sql

   FOREACH t300_g_b_c1 INTO g_oeb.*
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb38 = '1'                      #為訂單 #No.FUN-670026
 
      CALL t300_g_b1_detail()
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36=g_oma.oma24
         LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
      END IF
 
      INSERT INTO omb_file VALUES(b_omb.*)
 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf2',SQLCA.SQLCODE,1)
      END IF
      LET pb_cmd='Y'                        #NO.FUN-960140
   END FOREACH
 
 #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
#-------------------------------No.CHI-B90025----------------------------------end
 
   CALL s_up_omb(g_oma.oma01)
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
   CALL t300_ins_omc('0')      #No.FUN-680022   #TQC-750177
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
 
   CALL t300_show()
 
END FUNCTION
 
FUNCTION t300_g_b1_detail()

   LET b_omb.omb01 = g_oma.oma01
   LET b_omb.omb03 = g_oeb.oeb03
   LET b_omb.omb31 = g_oeb.oeb01
   LET b_omb.omb32 = g_oeb.oeb03
   LET b_omb.omb04 = g_oeb.oeb04
   LET b_omb.omb05 = g_oeb.oeb916   #FUN-560070
   LET b_omb.omb06 = g_oeb.oeb06
   LET b_omb.omb40 = g_oeb.oeb1001  #No.FUN-660073
   IF NOT cl_null(b_omb.omb40) THEN
     SELECT azf14 INTO b_omb.omb33
       FROM azf_file
     WHERE azf01=b_omb.omb40 AND azf02='2' AND azfacti='Y'
     IF g_aza.aza63='Y' AND cl_null(b_omb.omb331) THEN
       LET b_omb.omb331 = b_omb.omb33
     END IF
   END IF
   LET b_omb.omb12 = g_oeb.oeb917   #FUN-560070
   LET b_omb.omb41 = g_oeb.oeb41
   LET b_omb.omb42 = g_oeb.oeb42
   LET b_omb.omb44 = g_oeb.oebplant   #FUN-990031
   IF cl_null(g_oeb.oeb1006) THEN
      LET b_omb.omb13 = g_oeb.oeb13
   ELSE
      LET b_omb.omb13 = g_oeb.oeb13*(g_oeb.oeb1006/100)
   END IF
   LET b_omb.omb930 = g_oeb.oeb930 #FUN-680001
   LET b_omb.omb39 = g_oeb.oeb1012 #FUN-670026
   IF cl_null(b_omb.omb39) THEN
      LET b_omb.omb39 = 'N'
   END IF
 
   IF b_omb.omb12 > 0 THEN
      IF g_oma.oma213 = 'N' THEN
         LET b_omb.omb14 = b_omb.omb12 * b_omb.omb13 
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14t = b_omb.omb14 * (1 + g_oma.oma211 / 100)
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      ELSE
         LET b_omb.omb14t = b_omb.omb12 * b_omb.omb13 
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14 = b_omb.omb14t / (1 + g_oma.oma211 / 100)
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      END IF
   END IF
 
   CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
 
   LET b_omb.omb15 = b_omb.omb13 * g_oma.oma24
   LET b_omb.omb16 = b_omb.omb14 * g_oma.oma24
   LET b_omb.omb16t= b_omb.omb14t* g_oma.oma24
   LET b_omb.omb17 = b_omb.omb13 * g_oma.oma58
   LET b_omb.omb18 = b_omb.omb14 * g_oma.oma58
   LET b_omb.omb18t= b_omb.omb14t* g_oma.oma58
 
   CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15   #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16   #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16t,g_azi04) RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17   #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18   #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18t,g_azi04) RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
 
   LET b_omb.omb34 = 0
   LET b_omb.omb35 = 0
 
   LET b_omb.omblegal = g_legal #FUN-980011 add
   
   MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb12
 
END FUNCTION
 
FUNCTION t300_g_b2()                       #由出貨單產生單身
   DEFINE l_omb12   LIKE omb_file.omb12  #No:7682
   DEFINE l_omb14   LIKE omb_file.omb14  #No.FUN-670026
   DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
   DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add  
   IF NOT cl_confirm('axr-130') THEN
      RETURN
   END IF

   LET g_sql = "SELECT ogb_file.* ",
               #"  FROM ",li_dbs CLIPPED,"oga_file,",li_dbs CLIPPED,"ogb_file",
               "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'ogb_file'),     #FUN-A50102
               " WHERE ogb01 = '",g_oma.oma16,"'",
               "   AND (ogb917 - ogb60 - ogb64) > 0",
               "   AND ogb01 = oga01",
               "   AND oga00 IN ('1','4','5','6','B')",    #MOD-A50108 add B
               "   AND ogaconf = 'Y'",
               "   AND oga09 IN ('2','3','8')",
               "   AND oga65='N'",
               "   AND ogapost = 'Y'",
               "   AND ogb1005 != '2'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
   DECLARE t300_g_b_c2 CURSOR FROM g_sql
   FOREACH t300_g_b_c2 INTO g_ogb.*
      SELECT SUM(omb12) INTO l_omb12
        FROM omb_file,oma_file
       WHERE oma00 = '12'
         AND oma01 = omb01
         AND omavoid = 'N'
         AND omb31 = g_ogb.ogb01
         AND omb32 = g_ogb.ogb03
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      IF cl_null(l_omb12) THEN
         LET l_omb12 = 0
      END IF
 
      IF g_ogb.ogb917-l_omb12 <= 0 THEN   #判斷出貨數量<= AR數量則不產生   #FUN-560070
         CONTINUE FOREACH                #單身部份
      END IF
 
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb01 = g_oma.oma01
      SELECT MAX(omb03) INTO b_omb.omb03
        FROM omb_file
       WHERE omb01 = g_oma.oma01
      IF cl_null(b_omb.omb03) THEN
         LET b_omb.omb03 = 0
      END IF
      LET b_omb.omb03 = b_omb.omb03+1
      LET b_omb.omb38 = '2'                      #No.FUN-670026
 
      CALL t300_g_b2_detail()
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36 = g_oma.oma24
         LET b_omb.omb37 = b_omb.omb16t - b_omb.omb35
      END IF
      #str------ add by dengsy170510
     IF NOT cl_null(b_omb.omb04) THEN 
     LET l_ima08=NULL 
     LET l_count4=0
     LET l_count5=0
     LET l_omb33=NULL 
     SELECT ima08 INTO l_ima08 FROM ima_file
     WHERE ima01=b_omb.omb04
     SELECT count(*) INTO l_count4 FROM tc_ool_file
     WHERE tc_ool03=b_omb.omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
     IF l_count4>0 THEN 
       IF g_aza.aza63 = 'Y' THEN
         SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
         WHERE tc_ool03=b_omb.omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
       ELSE 
         SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
         WHERE tc_ool03=b_omb.omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
       END IF 
     ELSE 
        SELECT count(*) INTO l_count5 FROM tc_ool_file
        WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
        IF l_count5>0 THEN 
          IF g_aza.aza63 = 'Y' THEN
         SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
         WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
       ELSE 
         SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
         WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
       END IF
        END IF 
     END IF 

     END IF 
     IF NOT cl_null(l_omb33) THEN 
        LET b_omb.omb33=l_omb33
     END IF 
     
     #end------ add by dengsy170510
 
      INSERT INTO omb_file VALUES(b_omb.*)
 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf3',SQLCA.SQLCODE,1)
      END IF
     #-MOD-AB0216-add- 
      LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), 
                  "    SET oga10 = '",g_oma.oma01,"',",
                  "        oga05 = '",g_oma.oma05,"' ",
                  "  WHERE oga01 = '",b_omb.omb31,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
      PREPARE upd_oga_pre02 FROM g_sql
      EXECUTE upd_oga_pre02
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("upd","oga_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)     
      END IF
     #-MOD-AB0216-end- 
 
   END FOREACH
 
   IF cl_null(g_ohb14_ret) THEN
      LET g_ohb14_ret = 0
   END IF
 
   LET g_sql = " SELECT ogb_file.* ",
               #"   FROM ",li_dbs CLIPPED,"oga_file,",li_dbs CLIPPED,"ogb_file",
               "   FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                          cl_get_target_table(g_plant_new,'ogb_file'),     #FUN-A50102
               "  WHERE ogb01 = '",g_oma.oma16,"'",
               "    AND (ogb14-ogb1013-'",g_ohb14_ret,"')>0",
               "    AND ogb01 = oga01",
               "    AND oga00 IN ('1','4','5','6','B')",    #MOD-A50108 add B
               "    AND ogaconf = 'Y'",
               "    AND oga09 IN ('2','3','8')",
               "    AND oga65='N'",
               "    AND ogapost = 'Y'",
               "    AND ogb1005 = '2'"
    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
   DECLARE t300_g_b_c3 CURSOR FROM g_sql
   FOREACH t300_g_b_c3 INTO g_ogb.*
      SELECT SUM(abs(omb14)) INTO l_omb14                   #No.TQC-740350
        FROM omb_file,oma_file
       WHERE oma00 = '12'
         AND oma01 = omb01
         AND omavoid = 'N'
         AND omaconf = 'N'                            #NO.MOD-530692
         AND omb31 = g_ogb.ogb01
         AND omb32 = g_ogb.ogb03
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      IF cl_null(l_omb12) THEN
         LET l_omb12 = 0
      END IF
 
      IF g_ogb.ogb14-l_omb14<= 0 THEN    #No.FUN-670026
         CONTINUE FOREACH                #單身部份
      END IF
 
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb01 = g_oma.oma01
      SELECT MAX(omb03) INTO b_omb.omb03
        FROM omb_file
       WHERE omb01 = g_oma.oma01
      IF cl_null(b_omb.omb03) THEN
         LET b_omb.omb03 = 0
      END IF
      LET b_omb.omb03 = b_omb.omb03+1
      LET b_omb.omb38 = '4'                      #No.FUN-670026
 
      CALL t300_g_b2_detail_1()
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36 = g_oma.oma24
         LET b_omb.omb37 = b_omb.omb16t - b_omb.omb35
      END IF
 
      INSERT INTO omb_file VALUES(b_omb.*)
 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf3',SQLCA.SQLCODE,1)
      END IF
 
     #-MOD-AB0216-add- 
      LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), 
                  "    SET oga10 = '",g_oma.oma01,"',",
                  "        oga05 = '",g_oma.oma05,"' ",
                  "  WHERE oga01 = '",b_omb.omb31,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
      PREPARE upd_oga_pre03 FROM g_sql
      EXECUTE upd_oga_pre03
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("upd","oga_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)     
      END IF
     #-MOD-AB0216-end- 
   END FOREACH
 
 #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
#-------------------------------No.CHI-B90025----------------------------------end
 
   CALL s_up_omb(g_oma.oma01)
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
   CALL t300_ins_omc('0')       #No.FUN-680022    ##TQC-750177
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
 
   CALL t300_show()
   CALL t300_count_amount('')  #FUN-720038
 
END FUNCTION
 
FUNCTION t300_g_b2_detail()
   DEFINE l_omb12   LIKE omb_file.omb12    #No:7682
   DEFINE l_oba11   LIKE oba_file.oba11    
   DEFINE l_oba111  LIKE oba_file.oba111   #MOD-8A0230 add
 
   LET b_omb.omb31 = g_ogb.ogb01
   LET b_omb.omb32 = g_ogb.ogb03
   LET b_omb.omb04 = g_ogb.ogb04
   LET b_omb.omb05 = g_ogb.ogb916   #FUN-560070
   LET b_omb.omb06 = g_ogb.ogb06
   LET b_omb.omb40 = g_ogb.ogb1001  #No.FUN-660073
   LET b_omb.omb39 = g_ogb.ogb1012  #FUN-670026
   LET b_omb.omb41 = g_ogb.ogb41
   LET b_omb.omb42 = g_ogb.ogb42
#No.FUN-AB0034 --begin
   LET b_omb.omb45 = g_ogb.ogb49
#No.FUN-AB0034 --end

   IF NOT cl_null(b_omb.omb40) THEN
     #LET l_sql = "SELECT azf14 FROM ",li_dbs CLIPPED,"azf_file ",
     LET l_sql = "SELECT azf14 FROM ",cl_get_target_table(g_plant_new,'azf_file'), #FUN-A50102
                 " WHERE azf01='",b_omb.omb40,"' ",
                 "   AND azf02='2' AND azfacti='Y' "
     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
     PREPARE sel_azf14_pre FROM l_sql
     EXECUTE sel_azf14_pre INTO b_omb.omb33
     IF g_aza.aza63='Y' AND cl_null(b_omb.omb331) THEN
       LET b_omb.omb331 = b_omb.omb33
     END IF
   END IF

   LET b_omb.omb44 = g_ogb.ogbplant   #FUN-990031
   IF cl_null(b_omb.omb39) THEN
      LET b_omb.omb39 = 'N'
   END IF
   LET b_omb.omb930 = g_ogb.ogb930  #FUN-680001
   SELECT SUM(omb12) INTO l_omb12
     FROM omb_file,oma_file
    WHERE oma00 = '12'
      AND oma01 = omb01
      AND omavoid = 'N'
      AND omb31 = g_ogb.ogb01
      AND omb32 = g_ogb.ogb03
     #AND omb44 = g_omb[l_ac].omb44      #FUN-9C0013  
      AND omb44 = b_omb.omb44    #No:FUN-A50103
   IF cl_null(l_omb12) THEN
      LET l_omb12 = 0
   END IF
 
   LET b_omb.omb12 = (g_ogb.ogb917-g_ogb.ogb60 - g_ogb.ogb64)-l_omb12   #No:7682   #FUN-560070
 
   IF b_omb.omb12 < 0  THEN
      CALL cl_err(g_ogb.ogb01,'axr-126',1)
      LET b_omb.omb12=0
   END IF
 
   IF cl_null(g_ogb.ogb1006) THEN
      LET b_omb.omb13 = g_ogb.ogb13
   ELSE
      LET b_omb.omb13 = g_ogb.ogb13*(g_ogb.ogb1006/100)
   END IF
 
   IF b_omb.omb12 > 0 AND b_omb.omb39 !='Y' THEN  #No.FUN-670026  --modify
      IF g_oma.oma213 = 'N' THEN
         LET b_omb.omb14 =b_omb.omb12*b_omb.omb13
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      ELSE
         LET b_omb.omb14t=b_omb.omb12*b_omb.omb13 
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      END IF
   END IF
   
   IF b_omb.omb39 = 'Y' THEN
      LET b_omb.omb14  = 0
      LET b_omb.omb14t = 0  
   END IF
 
   IF b_omb.omb12=0 THEN
      LET b_omb.omb13=0
      LET b_omb.omb14=0
      LET b_omb.omb14t=0
      LET b_omb.omb15=0
      LET b_omb.omb16=0
      LET b_omb.omb16t=0
      LET b_omb.omb17=0
      LET b_omb.omb18=0
      LET b_omb.omb18t=0
      LET b_omb.omb34=0
      LET b_omb.omb35=0
   ELSE
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
      IF cl_null(b_omb.omb14)  THEN LET b_omb.omb14=0  END IF
      IF cl_null(b_omb.omb14t) THEN LET b_omb.omb14t=0 END IF
      IF cl_null(b_omb.omb15)  THEN LET b_omb.omb15=0  END IF
      IF cl_null(b_omb.omb16)  THEN LET b_omb.omb16=0  END IF
      IF cl_null(b_omb.omb16t) THEN LET b_omb.omb16t=0 END IF
      IF cl_null(b_omb.omb17)  THEN LET b_omb.omb17=0  END IF
      IF cl_null(b_omb.omb18)  THEN LET b_omb.omb18=0  END IF
      IF cl_null(b_omb.omb34)  THEN LET b_omb.omb34=0  END IF
      IF cl_null(b_omb.omb35)  THEN LET b_omb.omb35=0  END IF
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
   END IF
      LET l_oba11 = NULL
      #LET l_sql = "SELECT oba11 FROM ",li_dbs CLIPPED,"oba_file,",
      #                                 li_dbs CLIPPED,"ima_file ",
      LET l_sql = "SELECT oba11 FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", #FUN-A50102
                                       cl_get_target_table(g_plant_new,'ima_file'),      #FUN-A50102
                  " WHERE oba01 =ima_file.ima131 ",
                  "   AND ima_file.ima01 = '",b_omb.omb04,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
      PREPARE sel_oba11_pre FROM l_sql
      EXECUTE sel_oba11_pre INTO l_oba11
      IF SQLCA.sqlcode THEN
         LET l_oba11 = NULL
         CALL cl_err3("sel","oba_file",b_omb.omb04,"",STATUS,"","sel oba",0)
      END IF
      LET b_omb.omb33 = l_oba11
 
      LET l_oba111 = NULL
      #LET l_sql = "SELECT oba111 FROM ",li_dbs CLIPPED,"oba_file,",
      #                                  li_dbs CLIPPED,"ima_file ",
      LET l_sql = "SELECT oba111 FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", #FUN-A50102
                                        cl_get_target_table(g_plant_new,'ima_file'),      #FUN-A50102
                  " WHERE oba01 = ima_file.ima131",
                  "   AND ima_file.ima01 = '",b_omb.omb04,"' "
      CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
      PREPARE sel_oba111_pre FROM l_sql
      EXECUTE sel_oba111_pre INTO l_oba111
       IF SQLCA.sqlcode THEN 
          LET l_oba111 = NULL 
          CALL cl_err3("sel","oba_file",b_omb.omb04,"",STATUS,"","sel oba",0)
       END IF
       LET b_omb.omb331 = l_oba111  
   CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
#No.FUN-AB0034 --begin
   IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
          SELECT ool36,ool361 INTO b_omb.omb33,b_omb.omb331  FROM ool_file
                 WHERE ool01 = g_oma.oma13
   END IF 
#No.FUN-AB0034 --end 
   LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
   LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
   LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
   LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
   LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
   LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
 
   CALL cl_digcut(b_omb.omb15,g_azi03)  RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16,g_azi04)  RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16t,g_azi04) RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb17,g_azi03)  RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18,g_azi04)  RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18t,g_azi04) RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
 
   LET b_omb.omb34 = 0
   LET b_omb.omb35 = 0
   LET b_omb.omblegal = g_legal #FUN-980011 add
#No.FUN-AB0034 --begin
   IF g_oma.oma74 ='2' THEN 
      LET b_omb.omb14 = b_omb.omb14t
      LET b_omb.omb16 = b_omb.omb16t
      LET b_omb.omb18 = b_omb.omb18t
   END IF 
#No.FUN-AB0034 --end 
   MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb12
 
END FUNCTION
 
FUNCTION t300_g_b3()                       #由出貨單產生尾款單身
DEFINE l_omb12   LIKE omb_file.omb12 
DEFINE l_oeaa08  LIKE oeaa_file.oeaa08  #CHI-B90025 add
DEFINE l_oea01   LIKE oea_file.oea01    #CHI-B90025 add   
   IF NOT cl_confirm('axr-135') THEN
      RETURN
   END IF
  
  #-CHI-A50040-add- 
  #LET g_sql = "SELECT ogb_file.* ",
  #            "  FROM ",li_dbs CLIPPED,"oga_file,",li_dbs CLIPPED,"ogb_file",
  #            " WHERE ogb01 = '",g_oma.oma16,"'",
  #            "   AND (ogb917 - ogb60 - ogb64) > 0",
  #            "   AND ogb01 = oga01",
  #            "   AND oga00 IN ('1','4','5','6','B')",    #MOD-A50108 add B
  #            "   AND ogaconf = 'Y'",
  #            "   AND oga09 IN ('2','3')",
  #            "   AND ogapost = 'Y'"
   LET g_sql = "SELECT oeb_file.* ",
               #"  FROM ",li_dbs CLIPPED,"oea_file,",li_dbs CLIPPED,"oeb_file",
               "  FROM ",cl_get_target_table(g_plant_new,'oea_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'oeb_file'),      #FUN-A50102
               " WHERE oeb01 = '",g_oma.oma16,"'",
               "   AND oeb01 = oea01",
               "   AND oea00 = '1'",
               "   AND oeaconf = 'Y'",
               "   AND oeb1003 ! = '2'",
               "   AND oeb1012 ! = 'Y'"
  #-CHI-A50040-add- 
  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
   DECLARE t300_g_b_cs3 CURSOR FROM g_sql
       
  #FOREACH t300_g_b_cs3 INTO g_ogb.*    #CHI-A50040 mark
   FOREACH t300_g_b_cs3 INTO g_oeb.*    #CHI-A50040
      SELECT SUM(omb12) INTO l_omb12
        FROM omb_file,oma_file
       WHERE oma00 = '13'
         AND oma01 = omb01
         AND omavoid = 'N'
        #AND omb31 = g_ogb.ogb01   #CHI-A50040 mark
        #AND omb32 = g_ogb.ogb03   #CHI-A50040 mark
         AND omb31 = g_oeb.oeb01   #CHI-A50040 
         AND omb32 = g_oeb.oeb03   #CHI-A50040
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      IF cl_null(l_omb12) THEN
         LET l_omb12 = 0
      END IF
 
     #IF g_ogb.ogb917-l_omb12 <= 0 THEN   #判斷出貨數量<= AR數量則不產生   #TQC-6B0151
      IF g_oeb.oeb917-l_omb12 <= 0 THEN   #判斷訂單數量<= AR數量則不產生   #TQC-6B0151
         CONTINUE FOREACH                #單身部份
      END IF
 
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb01 = g_oma.oma01
     #LET b_omb.omb03 = g_ogb.ogb03   #CHI-A50040 mark
      LET b_omb.omb03 = g_oeb.oeb03   #CHI-A50040
 
      CALL t300_g_b3_detail()
 
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36 = g_oma.oma24
         LET b_omb.omb37 = b_omb.omb16t - b_omb.omb35
      END IF
 
 
      INSERT INTO omb_file VALUES(b_omb.*)
 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf3',SQLCA.SQLCODE,1)
      END IF
 
 
   END FOREACH
 
 #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
#-------------------------------No.CHI-B90025----------------------------------end
 
   CALL s_up_omb(g_oma.oma01)
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
 
   CALL t300_show()
 
END FUNCTION
 
FUNCTION t300_g_b3_detail()
   DEFINE l_omb12   LIKE omb_file.omb12    #No:7682
 
   LET b_omb.omb31 = g_oeb.oeb01                   #CHI-A50040 ogb -> oeb
   LET b_omb.omb32 = g_oeb.oeb03                   #CHI-A50040 ogb -> oeb
   LET b_omb.omb04 = g_oeb.oeb04                   #CHI-A50040 ogb -> oeb 
   LET b_omb.omb05 = g_oeb.oeb916   #TQC-6B0151    #CHI-A50040 ogb -> oeb
   LET b_omb.omb06 = g_oeb.oeb06                   #CHI-A50040 ogb -> oeb
 
   LET b_omb.omb41 = g_oeb.oeb41                   #CHI-A50040 ogb -> oeb
   LET b_omb.omb42 = g_oeb.oeb42                   #CHI-A50040 ogb -> oeb
   LET b_omb.omb44 = g_oeb.oebplant   #FUN-990031  #CHI-A50040 ogb -> oeb 
   SELECT SUM(omb12) INTO l_omb12
     FROM omb_file,oma_file
    WHERE oma00 = '13'
      AND oma01 = omb01
      AND omavoid = 'N'
      AND omb31 = g_oeb.oeb01                      #CHI-A50040 ogb -> oeb
      AND omb32 = g_oeb.oeb03                      #CHI-A50040 ogb -> oeb
      AND omb44 = g_omb[l_ac].omb44     #FUN-9C0013 

   IF cl_null(l_omb12) THEN
      LET l_omb12 = 0
   END IF
 
   LET b_omb.omb12 = g_oeb.oeb917      #TQC-6B0151   #CHI-A50040 ogb -> oeb 
 
   IF b_omb.omb12 < 0  THEN
      CALL cl_err(g_oeb.oeb01,'axr-126',1)           #CHI-A50040 ogb -> oeb
      LET b_omb.omb12=0
   END IF
 
   IF cl_null(g_oeb.oeb1006) THEN                         #CHI-A50040 ogb -> oeb
      LET b_omb.omb13 = g_oeb.oeb13                       #CHI-A50040 ogb -> oeb
   ELSE
      LET b_omb.omb13 = g_oeb.oeb13*(g_oeb.oeb1006/100)   #CHI-A50040 ogb -> oeb 
   END IF 
 
   IF b_omb.omb12 > 0 THEN
      IF g_oma.oma213 = 'N' THEN
         LET b_omb.omb14 =b_omb.omb12*b_omb.omb13 
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      ELSE
         LET b_omb.omb14t=b_omb.omb12*b_omb.omb13 
         CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
         LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
         CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
      END IF
   END IF
 
   IF b_omb.omb12=0 THEN
      LET b_omb.omb13=0
      LET b_omb.omb14=0
      LET b_omb.omb14t=0
      LET b_omb.omb15=0
      LET b_omb.omb16=0
      LET b_omb.omb16t=0
      LET b_omb.omb17=0
      LET b_omb.omb18=0
      LET b_omb.omb18t=0
      LET b_omb.omb34=0
      LET b_omb.omb35=0
   ELSE
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
      IF cl_null(b_omb.omb14)  THEN LET b_omb.omb14=0  END IF
      IF cl_null(b_omb.omb14t) THEN LET b_omb.omb14t=0 END IF
      IF cl_null(b_omb.omb15)  THEN LET b_omb.omb15=0  END IF
      IF cl_null(b_omb.omb16)  THEN LET b_omb.omb16=0  END IF
      IF cl_null(b_omb.omb16t) THEN LET b_omb.omb16t=0 END IF
      IF cl_null(b_omb.omb17)  THEN LET b_omb.omb17=0  END IF
      IF cl_null(b_omb.omb18)  THEN LET b_omb.omb18=0  END IF
      IF cl_null(b_omb.omb34)  THEN LET b_omb.omb34=0  END IF
      IF cl_null(b_omb.omb35)  THEN LET b_omb.omb35=0  END IF
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
   END IF
   ##
 
   CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
 
   LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
   LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
   LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
   LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
   LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
   LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
 
   CALL cl_digcut(b_omb.omb15,g_azi03)  RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16,g_azi04)  RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16t,g_azi04) RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb17,g_azi03)  RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18,g_azi04)  RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18t,g_azi04) RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
 
   LET b_omb.omb34 = 0
   LET b_omb.omb35 = 0
   LET b_omb.omb39 = g_oeb.oeb1012  #FUN-670026   #CHI-A50040 ogb -> oeb
   IF cl_null(b_omb.omb39) THEN
      LET b_omb.omb39 = 'N'
   END IF
 
   LET b_omb.omblegal = g_legal #FUN-980011 add
 
   MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb12
 
END FUNCTION
 
FUNCTION t300_g_b4()                       #由銷退單產生單身
   DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
   DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add  
   IF NOT cl_confirm('axr-131') THEN RETURN END IF
   LET g_sql = "SELECT ohb_file.* ",
               #"  FROM ",li_dbs CLIPPED,"ohb_file,",li_dbs CLIPPED,"oha_file",
               "  FROM ",cl_get_target_table(g_plant_new,'ohb_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'oha_file'),      #FUN-A50102
               " WHERE ohb01='",g_oma.oma16,"'",
               "   AND ohb01=oha01",
               "   AND ohaconf='Y'",
               "   AND ohapost='Y'",
               "   AND ohb1005 != '2'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
   DECLARE t300_g_b_c4 CURSOR FROM g_sql
   FOREACH t300_g_b_c4 INTO g_ohb.*
     IF STATUS THEN EXIT FOREACH END IF
     IF g_oma.oma34 !='5' AND g_ohb.ohb917 <=g_ohb.ohb60 THEN   #FUN-560070
        CONTINUE FOREACH
     END IF
     INITIALIZE b_omb.* TO NULL
    #LET b_omb.omb38 = '3'                       #為銷退單 #No.FUN-670026 #MOD-B20044 mark 
     CALL t300_g_b4_detail()
     IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
       LET b_omb.omb36=g_oma.oma24
       LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
     END IF
     INSERT INTO omb_file VALUES(b_omb.*)
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err('ins ombf4',SQLCA.SQLCODE,1)
     END IF
 
   END FOREACH
   LET g_sql = "SELECT ohb_file.* ",
               #"  FROM ",li_dbs CLIPPED,"ohb_file,",li_dbs CLIPPED,"oha_file",
               "  FROM ",cl_get_target_table(g_plant_new,'ohb_file'),",", #FUN-A50102
                         cl_get_target_table(g_plant_new,'oha_file'),      #FUN-A50102
               " WHERE ohb01='",g_oma.oma16,"'",
               "   AND ohb01=oha01",
               "   AND ohaconf='Y'",
               "   AND ohapost='Y'",
               "   AND ohb1005 = '2'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
   DECLARE t300_g_b_c6 CURSOR FROM g_sql
   FOREACH t300_g_b_c6 INTO g_ohb.*
     IF STATUS THEN EXIT FOREACH END IF
     IF g_oma.oma34 !='5' AND g_ohb.ohb14 <=g_ohb.ohb1012 THEN  
        CONTINUE FOREACH
     END IF
     INITIALIZE b_omb.* TO NULL
    #LET b_omb.omb38 = '5'                       #銷退返利 #No.FUN-670026  #MOD-B20044 mark
     CALL t300_g_b4_detail_1()                   #No.FUN-670026 
     IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
       LET b_omb.omb36=g_oma.oma24
       LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
     END IF
     INSERT INTO omb_file VALUES(b_omb.*)
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err('ins ombf4',SQLCA.SQLCODE,1)
     END IF
   END FOREACH
  
 #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
#-------------------------------No.CHI-B90025----------------------------------end
 
   CALL t300_ins_omc('0')   #No.FUN-680022    #TQC-750177
   CALL t300_b_fill('1=1')   #MOD-5B0006
 
END FUNCTION
 
FUNCTION t300_g_b4_detail()
    DEFINE l_omb12  LIKE omb_file.omb12
    DEFINE l_oha09  LIKE oha_file.oha09      #MOD-940155 add
 
     SELECT abs(SUM(omb12)) INTO l_omb12 FROM oma_file,omb_file #MOD-8C0192
      WHERE oma01=omb01 AND omavoid='N'                         #MOD-8C0192
        AND omb31=g_ohb.ohb01 AND omb32=g_ohb.ohb03
        AND omb44=g_omb[l_ac].omb44   #FUN-9C0013
     IF cl_null(l_omb12) THEN LET l_omb12=0 END IF
     LET b_omb.omb00 = g_oma.oma00  #plum
     LET b_omb.omb01 = g_oma.oma01
     LET b_omb.omb03 = g_ohb.ohb03
     LET b_omb.omb31 = g_ohb.ohb01
     LET b_omb.omb32 = g_ohb.ohb03
     LET b_omb.omb04 = g_ohb.ohb04
     LET b_omb.omb05 = g_ohb.ohb916   #FUN-560070
     LET b_omb.omb06 = g_ohb.ohb06
     LET b_omb.omb12 = g_ohb.ohb917-l_omb12   #FUN-560070
#No.FUN-AB0034 --begin
    LET b_omb.omb45 = g_ohb.ohb70
    IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
           SELECT ool36,ool361 INTO b_omb.omb33,b_omb.omb331  FROM ool_file
                  WHERE ool01 = g_oma.oma13
    END IF 
#No.FUN-AB0034 --end
     IF NOT cl_null(g_ohb.ohb31) AND NOT cl_null(g_ohb.ohb32) THEN
       #LET l_sql = "SELECT ogb41,ogb42 FROM ",li_dbs CLIPPED,"ogb_file ",
       LET l_sql = "SELECT ogb41,ogb42 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                   " WHERE ogb01 = '",g_ohb.ohb31,"' ",
                   "   AND ogb03 = '",g_ohb.ohb32,"' "
       CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
       PREPARE sel_ogb41_pre FROM l_sql
       EXECUTE sel_ogb41_pre INTO b_omb.omb41,b_omb.omb42
     ELSE
       IF NOT cl_null(g_ohb.ohb33) AND NOT cl_null(g_ohb.ohb34) THEN
         #LET l_sql = "SELECT oeb41,oeb42 FROM ",li_dbs CLIPPED,"oeb_file ",
         LET l_sql = "SELECT oeb41,oeb42 FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                     " WHERE oeb01 = '",g_ohb.ohb33,"' ",
                     "   AND oeb03 = '",g_ohb.ohb34,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	     CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                  
         PREPARE sel_oeb41_pre FROM l_sql
         EXECUTE sel_oeb41_pre INTO b_omb.omb41,b_omb.omb42
       END IF
     END IF
     IF cl_null(g_ohb.ohb1003) THEN
        LET b_omb.omb13 = g_ohb.ohb13
     ELSE
        LET b_omb.omb13 = g_ohb.ohb13*(g_ohb.ohb1003/100)
     END IF
     LET b_omb.omb38 = '3'                       #銷退單  #MOD-B20044 
     LET b_omb.omb39 = g_ohb.ohb1004   #No.FUN-670026 --add
     IF cl_null(b_omb.omb39) THEN
        LET b_omb.omb39 = 'N'
     END IF
     LET b_omb.omb40 = g_ohb.ohb50     #MOD-B20044
     LET b_omb.omb44 = g_ohb.ohbplant   #FUN-990031 
     LET b_omb.omb930 = g_ohb.ohb930   #FUN-680001
     #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
     LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                 " WHERE oha01='",b_omb.omb31,"' "
     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
	 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                 
     PREPARE sel_oha09_pre4 FROM l_sql
     EXECUTE sel_oha09_pre4 INTO l_oha09
     IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
     IF b_omb.omb12>0 THEN
        IF g_oma.oma213 = 'N' THEN
           LET b_omb.omb14 =b_omb.omb12*b_omb.omb13 
           CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
           LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
           CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
        ELSE
           LET b_omb.omb14t=b_omb.omb12*b_omb.omb13 
           CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
           LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
           CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
        END IF
     ELSE
        IF b_omb.omb12 = 0  AND l_oha09 ='5' THEN       #MOD-940155
          #IF g_oma.oma00='21' THEN   #MOD-940155 add   #MOD-B20044 mark
              LET b_omb.omb14 =g_ohb.ohb14
              LET b_omb.omb14t=g_ohb.ohb14t
          #MOD-A20104---mark---start---
          #ELSE
          #   LET b_omb.omb14 =g_ohb.ohb14 *-1
          #   LET b_omb.omb14t=g_ohb.ohb14t*-1
          #MOD-A20104---mark---end---
          #END IF         #MOD-A20104 add               #MOD-B20044 mark
        END IF
     END IF
     IF b_omb.omb39='Y' THEN
        LET b_omb.omb14  = 0
        LET b_omb.omb14t = 0
     END IF
     CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
     LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
     LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
     LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
     LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
     LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
     LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
    #IF b_omb.omb39 != 'Y' AND g_oma.oma00 MATCHES '1*' THEN     #MOD-A20104 mark
     IF b_omb.omb38 = '3' AND g_oma.oma00 MATCHES '1*' THEN      #MOD-A20104 add
        LET b_omb.omb12  =b_omb.omb12 * (-1)
        LET b_omb.omb14  =b_omb.omb14 * (-1)
        LET b_omb.omb14t =b_omb.omb14t* (-1)
        LET b_omb.omb16  =b_omb.omb16 * (-1)
        LET b_omb.omb16t =b_omb.omb16t* (-1)
        LET b_omb.omb18  =b_omb.omb18 * (-1)
        LET b_omb.omb18t =b_omb.omb18t* (-1)
     END IF 
     CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
     LET b_omb.omb34=0 LET b_omb.omb35=0
 
     LET b_omb.omblegal = g_legal #FUN-980011 add
#No.FUN-AB0034 --begin
     IF g_oma.oma74 ='2' THEN 
        LET b_omb.omb14 = b_omb.omb14t
        LET b_omb.omb16 = b_omb.omb16t
        LET b_omb.omb18 = b_omb.omb18t
     END IF 
#No.FUN-AB0034 --end  
     MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb12
END FUNCTION
 
FUNCTION t300_g_b5()                       #由原立帳單產生單身
   DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
   DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add
   IF NOT cl_confirm('axr-133') THEN RETURN END IF
   DECLARE t300_g_b_c5 CURSOR FOR
    SELECT omb_file.* FROM omb_file,oma_file
     WHERE omb01=g_oma.oma16
       AND omb01=oma01
       AND omaconf='Y'
   FOREACH t300_g_b_c5 INTO t_omb.*
     IF STATUS THEN EXIT FOREACH END IF
     INITIALIZE b_omb.* TO NULL
     CALL t300_g_b5_detail()
     IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
       LET b_omb.omb36=g_oma.oma24
       LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
     END IF
     INSERT INTO omb_file VALUES(b_omb.*)
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err('ins ombf5',SQLCA.SQLCODE,1)
     END IF
 
   END FOREACH
 
 #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
#-------------------------------No.CHI-B90025----------------------------------end
 
   CALL s_up_omb(g_oma.oma01)
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
   CALL t300_ins_omc('0')      #No.FUN-680022  #TQC-750177
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
   CALL t300_show()
END FUNCTION
 
FUNCTION t300_g_b5_detail()
DEFINE l_ogb1006    LIKE ogb_file.ogb1006
     LET b_omb.omb38 = t_omb.omb38
     LET b_omb.omb39 = t_omb.omb39
     LET b_omb.omb01 = g_oma.oma01
     LET b_omb.omb03 = t_omb.omb03
     LET b_omb.omb31 = t_omb.omb31
     LET b_omb.omb32 = t_omb.omb32
     LET b_omb.omb04 = t_omb.omb04
     LET b_omb.omb05 = t_omb.omb05
     LET b_omb.omb06 = t_omb.omb06
     LET b_omb.omb40 = t_omb.omb40  #No.FUN-660073
     LET b_omb.omb12 = t_omb.omb12
     LET b_omb.omb41 = t_omb.omb41
     LET b_omb.omb42 = t_omb.omb42
     LET b_omb.omb13 = t_omb.omb13
     LET b_omb.omb930 = t_omb.omb930 #FUN-680001
     IF b_omb.omb12>0 THEN
        IF g_oma.oma213 = 'N' THEN
           LET b_omb.omb14 =b_omb.omb12*b_omb.omb13 
           CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
           LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
           CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
        ELSE
           LET b_omb.omb14t=b_omb.omb12*b_omb.omb13 
           CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
           LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
           CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
        END IF
     END IF
     CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
     LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
     LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
     LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
     LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
     LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
     LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
     CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
     CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
     LET b_omb.omb34=0 LET b_omb.omb35=0
     IF b_omb.omb39 = 'Y' AND b_omb.omb38 != '4' THEN 
        LET b_omb.omb14  = 0
        LET b_omb.omb14t = 0
        LET b_omb.omb16  = 0
        LET b_omb.omb16t = 0
        LET b_omb.omb18  = 0
        LET b_omb.omb18t = 0
     END IF
 
     LET b_omb.omblegal = g_legal #FUN-980011 add
 
     MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb12
END FUNCTION
 
FUNCTION t300_u()
  DEFINE l_flag  LIKE type_file.chr1     #TQC-750226
  DEFINE li_n    LIKE type_file.num5     #FUN-960140
 
   LET l_flag = 'Y'                      #TQC-750226
 
   IF s_shut(0) THEN RETURN END IF
   IF g_oma.oma01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
   IF g_oma.omavoid = 'Y' THEN CALL cl_err('','axr-103',0) RETURN END IF
 
 IF g_oma.omaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
#No.FUN-AB0034 --begin
   IF g_oma.oma70 = '1'  THEN
      CALL cl_err('','aap-829',0) RETURN
   END IF
#No.FUN-AB0034 --end 
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
   IF g_oma.oma70 = '3'  THEN
      CALL cl_err('','axr-087',0) RETURN
      #POS交易產生的單據不可維護, 但可刪除\確認\取消確認！
   END IF
###-FUN-B40032- ADD -  END  ---------------------------------------------------
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_oma_o.* = g_oma.*
   BEGIN WORK
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       CLOSE t300_cl ROLLBACK WORK RETURN
   END IF
   CALL t300_show()
   WHILE TRUE
       LET g_oma.omamodu=g_user
       LET g_oma.omadate=g_today
       CALL t300_i("u")                      #欄位更改
       IF INT_FLAG THEN
           LET INT_FLAG = 0
           LET g_oma.*=g_oma_t.*
           CALL t300_show()
           CALL cl_err('','9001',0)
           LET l_flag = 'N'           #TQC-750226 
           EXIT WHILE
       END IF
     IF g_oma.oma24 IS NULL THEN LET g_oma.oma24 = 0 END IF
     IF g_oma.oma58 IS NULL THEN LET g_oma.oma58 = 0 END IF
       LET g_oma.oma60=g_oma.oma24
       LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
       CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                 
       LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                        
 
       IF g_oma.oma64 NOT matches '[Ss]' THEN   #FUN-8A0075
          LET g_oma.oma64 = '0'                 #FUN-550049
       END IF                                   #FUN-8A0075 
       
       LET g_oma.omauser = g_oma.oma14     #No:110927  Add  <<--yangjian--
       LET g_oma.omagrup = g_oma.oma15     #No:110927  Add  <<--yangjian--
       UPDATE oma_file SET * = g_oma.* WHERE oma01 = g_oma.oma01
       IF SQLCA.sqlcode THEN
           CALL cl_err3("upd","oma_file",g_oma_t.oma01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
           CONTINUE WHILE
       END IF
       IF g_oma.oma01 != g_oma_t.oma01 THEN            # 更改單號
          UPDATE omb_file SET omb01 = g_oma.oma01 WHERE omb01 = g_oma_t.oma01
          IF SQLCA.sqlcode THEN
              CALL cl_err3("upd","omb_file",g_oma_t.oma01,"",SQLCA.sqlcode,"","update omb01",1)  #No.FUN-660116
              CONTINUE WHILE
          END IF
       END IF
       IF g_oma.oma02 != g_oma_t.oma02 THEN            # 更改單號
          UPDATE npp_file SET npp02=g_oma.oma02
           WHERE npp01=g_oma.oma01 AND npp011=1 AND npp00=2
             AND nppsys = 'AR'
          IF STATUS THEN 
             CALL cl_err3("upd","npp_file",g_oma.oma01,"",STATUS,"","upd npp02:",1)  #No.FUN-660116
          END IF
       END IF
       EXIT WHILE
   END WHILE
   CLOSE t300_cl
    LET li_dbs = ''
    IF NOT cl_null(g_oma.oma66) THEN
       LET g_plant_new = g_oma.oma66
    ELSE
       LET g_plant_new = g_plant
    END IF
    #CALL s_gettrandbs()
    #LET li_dbs = g_dbs_tra
   IF l_flag = 'Y'  THEN   #TQC-750226 
      COMMIT WORK
     DISPLAY BY NAME g_oma.oma64
     IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
     CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
   
      CALL cl_flow_notify(g_oma.oma01,'U')
      CALL s_up_omb(g_oma.oma01)
      SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
      IF g_oma.oma32 != g_oma_t.oma32 THEN          #收款條件 
         DELETE FROM omc_file 
          WHERE omc01=g_oma.oma01 
         IF STATUS THEN 
            CALL cl_err3("del","omc_file",g_oma.oma01,"",STATUS,"","",1)  
         END IF
      END IF
      CALL t300_ins_omc('1')      #No.FUN-680022    #TQC-750177
      SELECT COUNT(*) INTO g_cnt FROM omc_file
       WHERE omc01 = g_oma.oma01
      IF g_cnt = 1 THEN 
         IF g_oma.oma11 != g_oma_t.oma11 OR g_oma.oma12 != g_oma_t.oma12 THEN
            UPDATE omc_file SET omc04 = g_oma.oma11,
                                omc05 = g_oma.oma12
             WHERE omc01 = g_oma.oma01
            IF STATUS THEN 
               CALL cl_err3("upd","omc_file",g_oma.oma11,g_oma.oma12,STATUS,"","",1)  
            END IF
         END IF
      END IF
      SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
      CALL t300_show()
   # 新增自動確認功能 Modify by Charis 96-09-23
       CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1     #No.FUN-550071
       SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
       IF STATUS THEN
          RETURN
       END IF
       IF g_ooy.ooyprit='Y' THEN CALL t300_out() END IF   #單據需立即列印
       IF (g_oma.omaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr = 'Y') #單據已確認或單據不需自動確認,或需簽核  #FUN-640246
          THEN RETURN
       ELSE
          LET g_action_choice = "insert"                     #FUN-640246
          CALL s_showmsg_init() #CHI-A80031 add
          CALL t300_y_chk()          #CALL 原確認的 check 段
          IF g_success = "Y" THEN
             CALL t300_y_upd()       #CALL 原確認的 update 段
          END IF
          CALL s_showmsg()  #CHI-A80031 add
       END IF
 END IF  #TQC-750226
END FUNCTION
 
FUNCTION t300_npp02(p_npptype)  #FUN-670047
DEFINE  p_npptype  LIKE npp_file.npptype  #FUN-670047
 
  IF g_oma.oma33 IS NULL OR g_oma.oma33=' ' THEN
     UPDATE npp_file SET npp02=g_oma.oma02
      WHERE npp01=g_oma.oma01 AND npp011=1 AND npp00=2
        AND nppsys = 'AR'
        AND npptype = p_npptype #FUN-670047
     IF STATUS THEN 
        CALL cl_err3("upd","npp_file",g_oma.oma01,"",STATUS,"","upd npp02:",1)  #No.FUN-660116
     END IF
  END IF
END FUNCTION
 
#處理INPUT
FUNCTION t300_i(p_cmd)
  DEFINE p_cmd       LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)                #a:輸入 u:更改
  DEFINE l_flag      LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)               #判斷必要欄位是否有輸入
  DEFINE l_n1        LIKE type_file.num5    #No.FUN-680123 SMALLINT
  DEFINE l_oom04     LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)
  DEFINE l_occ       RECORD LIKE occ_file.*
  DEFINE l_ool       RECORD LIKE ool_file.*
  DEFINE l_ool02     LIKE ool_file.ool02    #FUN-670047
  DEFINE x           RECORD LIKE omb_file.*
  DEFINE old_oma21   LIKE oma_file.oma21
  DEFINE old_oma24   LIKE oma_file.oma24    #FUN-4C0013
  DEFINE old_oma58   LIKE oma_file.oma58    #FUN-4C0013
  DEFINE li_result   LIKE type_file.num5    #No.FUN-680123 SMALLINT         #No.FUN-550071
  DEFINE l_cnt       LIKE type_file.num5    #No.FUN-680123 SMALLINT   #MOD-5A0318
 #DEFINE l_smu02     LIKE smu_file.smu02    #MOD-5A0318               #MOD-AA0149 mark
 #DEFINE l_smv02     LIKE smv_file.smv02    #MOD-5A0318               #MOD-AA0149 mark
  DEFINE l_oga021    LIKE oga_file.oga021   #FUN-640029
  DEFINE l_occ01     LIKE occ_file.occ01    #FUN-670026--add
  DEFINE l_oha09     LIKE oha_file.oha09    #FUN-670026--add
  DEFINE l_oga65     LIKE oga_file.oga65    #No.TQC-740047                                                                        
  DEFINE l_n         LIKE type_file.num5    #No.TQC-740047
  DEFINE l_occ18     LIKE occ_file.occ18    #MOD-970130                 
  DEFINE l_occ06     LIKE occ_file.occ06    #No.TQC-740309
  DEFINE l_oga02     LIKE oga_file.oga02    #TQC-750058
  DEFINE l_oga07     LIKE oga_file.oga07    #MOD-760086
  DEFINE l_ooyacti   LIKE ooy_file.ooyacti  #No.TQC-770025
  DEFINE l_aag02     LIKE aag_file.aag02    #TQC-790124
  DEFINE l_aag02a    LIKE aag_file.aag02    #TQC-790124
  DEFINE l_oha02     LIKE oha_file.oha02    #MOD-890208
  DEFINE l_aag05     LIKE aag_file.aag05    #FUN-8C0089  add
  DEFINE l_aag05a    LIKE aag_file.aag05    #FUN-8C0089  add
  DEFINE l_gen02     LIKE gen_file.gen02    #MOD-9C0075 add
  DEFINE l_gem02     LIKE gem_file.gem02    #MOD-9C0075 add
  DEFINE l_oma66_t   LIKE oma_file.oma66    #No.FUN-9C0014 Add
  DEFINE l_oeaa08    LIKE oeaa_file.oeaa08  #CHI-B90025 add
  DEFINE l_oea01     LIKE oea_file.oea01    #CHI-B90025 add  
 
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

    LET li_dbs = ''
    IF NOT cl_null(g_oma.oma66) THEN
       LET g_plant_new = g_oma.oma66
    ELSE
       LET g_plant_new = g_plant
    END IF
    #CALL s_gettrandbs()
    #LET li_dbs = g_dbs_tra
 
    INPUT BY NAME
           g_oma.oma00,g_oma.oma01,g_oma.oma08,g_oma.oma02,
           g_oma.oma33,g_oma.oma66,g_oma.oma03,g_oma.oma032,g_oma.oma68,g_oma.oma69,  #No.FUN-670026--add oma68,oma69  #FUN-960140 add omaplant  #FUN-960140 090824 del omaplant   #TQC-A50022 add oma66
           g_oma.omaconf,g_oma.omavoid,g_oma.oma70,   #FUN-960140  add oma70
           g_oma.oma32,g_oma.oma11,g_oma.oma12,g_oma.oma13,g_oma.oma65,  #No.FUN-570099 #FUN-670047
           g_oma.oma23,g_oma.oma52,g_oma.oma73f,g_oma.oma54,g_oma.oma54x,g_oma.oma54t,g_oma.oma55,  #No.FUN-AB0034 add oma73f
           g_oma.oma24,g_oma.oma53,g_oma.oma73,g_oma.oma56,g_oma.oma56x,g_oma.oma56t,g_oma.oma57,   #No.FUN-AB0034 add oma73
           g_oma.oma18,g_oma.oma181,g_oma.oma14,g_oma.oma15,g_oma.oma930,g_oma.oma16,g_oma.oma165,g_oma.oma19,g_oma.oma99 , #No.8161 add oma99 #No.MOD-530008  #FUN-630043 #FUN-670047 #FUN-680001     #No:FUN-A50103
        #  g_oma.oma992,g_oma.oma66,g_oma.oma67,g_oma.oma25,g_oma.oma26,g_oma.oma63,g_oma.oma40 ,g_oma.omaprsw,      #No.FUN-690090 add oma992   #FUN-820072  #TQC-A50022 mark
           g_oma.oma992,            g_oma.oma67,g_oma.oma25,g_oma.oma26,g_oma.oma63,g_oma.oma40 ,g_oma.omaprsw,     #TQC-A50022 
           g_oma.oma09,g_oma.oma05,g_oma.oma10,g_oma.oma04,g_oma.oma71, #No.TQC-740309 add oma04 #FUN-970108 add
           g_oma.oma21,g_oma.oma211,g_oma.oma212,g_oma.oma213,
           g_oma.oma58,g_oma.oma59 ,g_oma.oma59x,g_oma.oma59t  ,
           g_oma.omauser,g_oma.omagrup,g_oma.omaoriu,g_oma.omaorig,g_oma.omamodu,g_oma.omadate, #No.FUN-A40054
           g_oma.omaud01,g_oma.omaud02,g_oma.omaud03,g_oma.omaud04,
           g_oma.omaud05,g_oma.omaud06,g_oma.omaud07,g_oma.omaud08,
           g_oma.omaud09,g_oma.omaud10,g_oma.omaud11,g_oma.omaud12,
           g_oma.omaud13,g_oma.omaud14,g_oma.omaud15 
           WITHOUT DEFAULTS
 
        BEFORE INPUT
           LET g_before_input_done = FALSE
           CALL t300_set_entry(p_cmd)
           CALL t300_set_entry_1()    #No.FUN-8A0075
           CALL t300_set_no_entry(p_cmd)
           CALL t300_set_no_entry_1() #No.FUN-8A0075
           LET g_before_input_done = TRUE
           CALL cl_set_docno_format("oma01")
 
        BEFORE FIELD oma00
         IF g_oma.oma64 NOT matches '[Ss]' THEN #No.FUN-8A0075
            CALL t300_set_entry(p_cmd)
         END IF                                 #No.FUN-8A0075
 
        AFTER FIELD oma00
         IF g_oma.oma64 NOT matches '[Ss]' THEN #No.FUN-8A0075
           IF NOT cl_null(g_oma.oma00) THEN
              IF g_oma.oma00 NOT MATCHES '1[1-8]' AND   
                 g_oma.oma00 NOT MATCHES '2[1-7]' AND   
                 g_oma.oma00 NOT MATCHES '31' THEN
                 NEXT FIELD oma00
              END IF
              IF g_oma.oma00 MATCHES '1[5-8]' OR
                 g_oma.oma00 MATCHES '2[6-7]' THEN
                 NEXT FIELD oma00
              END IF
              
              CALL  t300_set_entry(p_cmd)
              CALL  t300_set_no_entry(p_cmd)
 
              IF g_oma.oma00 = '11' OR g_oma.oma00='13' THEN
                 CALL cl_set_comp_required("oma16,oma165",TRUE)     #No:FUN-A50103
              ELSE
                 CALL cl_set_comp_required("oma16,oma165",FALSE)     #No:FUN-A50103
              END IF
              IF g_oma.oma00 = '23' THEN NEXT FIELD oma00 END IF
              IF g_oma.oma00 = '24' THEN NEXT FIELD oma00 END IF
              CALL t300_show0()  #for genero
           END IF
           CALL t300_set_no_entry(p_cmd)
         END IF          #FUN-8A0075
 
        AFTER FIELD oma08
           DISPLAY "AFTER FIELD oma08"
           IF g_oma.oma08 NOT MATCHES '[123]' THEN NEXT FIELD oma08 END IF   #No.MOD-910093
 
        BEFORE FIELD oma01             #因為oma00一定要有值,oma01才能開窗正確
          IF cl_null(g_oma.oma00) THEN
             NEXT FIELD oma00
          END IF
 
        AFTER FIELD oma01
           IF NOT cl_null(g_oma.oma01) THEN
              LET g_t1 = g_oma.oma01[1,g_doc_len]
              LET l_ooyacti = NULL
              SELECT ooyacti INTO l_ooyacti FROM ooy_file
               WHERE ooyslip = g_t1
              IF l_ooyacti <> 'Y' THEN
                 CALL cl_err(g_t1,'axr-956',1)
                 NEXT FIELD oma01
              END IF
             #-MOD-AA0149-mark-
             #LET l_cnt=0
             ##LET g_sql = " SELECT count(*) FROM ",li_dbs CLIPPED,"smu_file",
             #LET g_sql = " SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'smu_file'), #FUN-A50102
             #            "  WHERE smu01 = '",g_t1,"'",
             #            "    AND upper(smu03) = 'AXR'"
             #CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	     #CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
             #PREPARE sel_smu_pre46 FROM g_sql
             #EXECUTE sel_smu_pre46 INTO l_cnt
             #IF l_cnt > 0 THEN
             #   #LET g_sql = " SELECT smu02 FROM ",li_dbs CLIPPED,"smu_file",
             #   LET g_sql = " SELECT smu02 FROM ",cl_get_target_table(g_plant_new,'smu_file'), #FUN-A50102
             #               "  WHERE smu01 = '",g_t1,"'",
             #               "    AND upper(smu03) = 'AXR'"
             #   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	     #   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             #   DECLARE smu_c CURSOR FROM g_sql
             #   FOREACH smu_c INTO l_smu02
             #      IF l_smu02 <> g_user THEN
             #         CONTINUE FOREACH
             #      ELSE
             #         EXIT FOREACH
             #      END IF
             #   END FOREACH
             #   IF l_smu02 <> g_user THEN
             #      CALL cl_err('','axr-011',0)
             #      NEXT FIELD oma01
             #   END IF
             #END IF
             #LET l_cnt=0
             ##LET g_sql = " SELECT count(*) FROM ",li_dbs CLIPPED,"smv_file",
             #LET g_sql = " SELECT count(*) FROM ",cl_get_target_table(g_plant_new,'smv_file'), #FUN-A50102
             #            "  WHERE smv01 = '",g_t1,"'",
             #            "    AND upper(smv03) = 'AXR'"
             #CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	     #CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
             #PREPARE sel_smv_pre47 FROM g_sql
             #EXECUTE sel_smv_pre47 INTO l_cnt
             #IF l_cnt > 0 THEN
             #   #LET g_sql = " SELECT smv02 FROM ",li_dbs CLIPPED,"smv_file",
             #   LET g_sql = " SELECT smv02 FROM ",cl_get_target_table(g_plant_new,'smv_file'), #FUN-A50102
             #               "  WHERE smv01 = '",g_t1,"'",
             #               "    AND upper(smv03) = 'AXR'"
             #   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	     #   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             #   DECLARE smv_c CURSOR FROM g_sql
             #   FOREACH smv_c INTO l_smv02
             #      IF l_smv02 <> g_grup THEN
             #         CONTINUE FOREACH
             #      ELSE
             #         EXIT FOREACH
             #      END IF
             #   END FOREACH
             #   IF l_smv02 <> g_grup THEN
             #      CALL cl_err('','axr-012',0)
             #      NEXT FIELD oma01
             #   END IF
             #END IF
             #-MOD-AA0149-end-
 
             CALL  s_check_no("axr",g_oma.oma01,"",g_oma.oma00,"","","")
                   RETURNING li_result,g_oma.oma01
             DISPLAY BY NAME g_oma.oma01
             IF (NOT li_result) THEN
                NEXT FIELD oma01
              ELSE
                 SELECT ooyapr,'0' INTO g_oma.omamksg,g_oma.oma64
                   FROM ooy_file
                  WHERE ooyslip = g_t1
                 DISPLAY BY NAME g_oma.omamksg,g_oma.oma64
              END IF
          END IF
 
        AFTER FIELD oma02
          IF NOT cl_null(g_oma.oma02) THEN
             #FUN-B50090 add begin-------------------------
             #重新抓取關帳日期
             SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
             #FUN-B50090 add -end--------------------------
             IF g_oma.oma02 <= g_ooz.ooz09 THEN
                CALL cl_err('','axr-164',0) NEXT FIELD oma02
             END IF
             CALL s_get_bookno(year(g_oma.oma02))
                  RETURNING g_flag1,g_bookno1,g_bookno2
             IF g_flag1='1' THEN #抓不到帳別
                CALL cl_err(g_oma.oma02,'aoo-081',1)
                NEXT FIELD oma02
             END IF
             IF g_oma.oma09 IS NULL THEN
                LET g_oma.oma09 = g_oma.oma02
                DISPLAY BY NAME g_oma.oma09
             END IF
             IF NOT cl_null(g_oma.oma66) THEN 
                LET g_plant2=g_oma.oma66 
             ELSE 
                LET g_plant2 = g_plant 
             END IF 
             IF p_cmd = 'u' AND (g_oma.oma02 != g_oma_t.oma02 OR
                                 g_oma.oma02 != g_oma_o.oma02) AND (g_oma.oma00 MATCHES '1*' OR g_oma.oma00 MATCHES '31' ) #MOD-9C0410
             THEN CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                                g_oma.oma02,g_plant2) #NO.FUN-630015#No.FUN-680022 add oma02   #MOD-680005#TQC-9C0099
                        RETURNING g_oma.oma11,g_oma.oma12
                  DISPLAY BY NAME g_oma.oma11,g_oma.oma12
                  IF g_oma.oma08='1' THEN
                     LET exT=g_ooz.ooz17
                  ELSE
                     LET exT=g_ooz.ooz63
                  END IF
                  CALL s_curr3(g_oma.oma23,g_oma.oma02,exT) 
                        RETURNING g_oma.oma24   
                  DISPLAY BY NAME g_oma.oma24   
                  IF g_oma.oma24 != g_oma_o.oma24 THEN   
                     IF cl_confirm('axr-172') THEN
                        DECLARE t300_oma24_c2 CURSOR FOR
                                SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                        FOREACH t300_oma24_c2 INTO x.*
                           IF STATUS THEN EXIT FOREACH END IF
                           LET x.omb15 =x.omb13 *g_oma.oma24
                           LET x.omb16 =x.omb14 *g_oma.oma24
                           LET x.omb16t=x.omb14t*g_oma.oma24
                           CALL cl_digcut(x.omb15,g_azi03) RETURNING x.omb15  
                           CALL cl_digcut(x.omb16,g_azi04) RETURNING x.omb16  
                           CALL cl_digcut(x.omb16t,g_azi04)RETURNING x.omb16t 
                           IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
                              LET x.omb37=x.omb16t
                           END IF
                           UPDATE omb_file SET *=x.*
                                 WHERE omb01=g_oma.oma01 AND omb03=x.omb03
                        END FOREACH
                        UPDATE omc_file SET omc06 = g_oma.oma24,
                                            omc07 = g_oma.oma24,
                                            omc09 = omc08 * g_oma.oma24,
                                            omc13 = omc09 - omc11   #MOD-970296 add
                         WHERE omc01 = g_oma.oma01
 
                       #-TQC-B60089-add-
                        LET g_ogb_o.* = g_ogb.*
                        LET g_sql = " SELECT * ",
                                    "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                                    "  WHERE ogb01 = '",x.omb31,"'",
                                    "    AND ogb03 = '",x.omb32,"'"
                        CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                        PREPARE sel_ogb_pre11 FROM g_sql
                        EXECUTE sel_ogb_pre11 INTO g_ogb.*
                       #-TQC-B60089-end-
                       #-------------------------------No.CHI-B90025----------------------------------start
                        IF g_oma.oma00='11' THEN
                           SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                            WHERE oeaa01 = g_oma.oma16
                              AND oeaa02 = '1'
                              AND oeaa03 = g_oma.oma165
                              AND oeaa01 = oea01
                       END IF
                       IF g_oma.oma00='13' THEN
                          SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                           WHERE oeaa01 = g_oma.oma16
                             AND oeaa02 = '2'
                             AND oeaa03 = g_oma.oma165
                             AND oeaa01 = oea01
                       END IF
                       CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                       #CALL t300_bu()
                      #-------------------------------No.CHI-B90025----------------------------------end
                        LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                     END IF
                  END IF
             ELSE
                  IF g_oma.oma00 MATCHES '2*' THEN
                     LET g_oma.oma11 = g_oma.oma02
                     LET g_oma.oma12 = g_oma.oma02
                     DISPLAY BY NAME g_oma.oma11,g_oma.oma12
                  END IF
             END IF
             LET g_oma_o.oma02 = g_oma.oma02
             UPDATE ooa_file SET ooa02 = g_oma.oma02    #No.TQC-7B0043
              WHERE ooa01 =g_oma.oma01                  #No.MOD-7C0054
          END IF
          
        AFTER FIELD oma05 
          CALL t300_oma71()
 
        AFTER FIELD oma10
          DISPLAY "AFTER FIELD oma10"
          IF g_oma.oma10 IS NOT NULL AND g_oma.oma00 = '25' THEN
             LET g_cnt=0
             SELECT COUNT(*) INTO g_cnt FROM oma_file
              WHERE oma10 = g_oma.oma10
                AND oma00 MATCHES '1*'
             IF g_cnt = 0 THEN
                CALL cl_err(g_oma.oma10,'axr-353',0) NEXT FIELD oma10
             END IF
             CALL t300_oma71()   #FUN-970108 add
          END IF
 
        AFTER FIELD oma04
          IF NOT cl_null(g_oma.oma04) THEN
            IF cl_null(g_oma.oma10) THEN #MOD-970130    
             IF g_aza.aza50 = 'N' THEN
                LET g_sql = " SELECT occ18,occ06",
                            #"   FROM ",li_dbs CLIPPED,"occ_file",
                            "   FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01 = '",g_oma.oma04,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
                PREPARE sel_occ_pre48 FROM g_sql
                EXECUTE sel_occ_pre48 INTO l_occ18,l_occ06
             ELSE
                LET g_sql = " SELECT occ18,occ06",
                            #"   FROM ",li_dbs CLIPPED,"occ_file",
                            "   FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01 = '",g_oma.oma04,"'",
                            "    AND occ1004 = '1'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
                PREPARE sel_occ_pre49 FROM g_sql
                EXECUTE sel_occ_pre49 INTO l_occ18,l_occ06
             END IF    #No.TQC-760015
             IF cl_null(l_occ06) THEN
                CALL cl_err(g_oma.oma04,'anm-045',1)
                NEXT FIELD oma04
             ELSE
                IF l_occ06 <> '1' AND l_occ06 <> '4' THEN
                   CALL cl_err(l_occ06,'axr-954',1)
                   NEXT FIELD oma04
                END IF
             END IF
             DISPLAY l_occ18 TO FORMONLY.occ18                                                                          
           ELSE                                                                                                                     
              SELECT ome043 INTO l_occ18                                                                                            
                FROM ome_file                                                                                                       
               WHERE ome01 = g_oma.oma10                                                                                            
              DISPLAY l_occ18 TO FORMONLY.occ18                                                                                     
           END IF                                                                                                                   
          END IF
 
        AFTER FIELD oma16
          IF NOT cl_null(g_oma.oma16) THEN
             IF cl_null(g_oma.oma66) THEN
                LET g_plant_new = g_plant
             ELSE
                LET g_plant_new = g_oma.oma66
             END IF
             #CALL s_gettrandbs()
             #LET li_dbs = g_dbs_tra
             #-----MOD-A40078---------
             CALL t300_chk_it(g_oma.oma16)
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_oma.oma16,g_errno,1)
                NEXT FIELD oma16
             END IF
             #-----END MOD-A40078-----
             IF g_oma.oma00 ='11' THEN
               #IF g_oma.oma00 = '11' THEN
                IF NOT cl_null(g_oma.oma165) THEN    #No:FUN-A50103
                   SELECT COUNT(*) INTO l_n FROM oma_file
                    WHERE oma01!=g_oma.oma01
                      AND oma16 = g_oma.oma16
                      AND oma165 = g_oma.oma165    #No:FUN-A50103
                      AND oma00 = '11'
                   IF l_n > 0 THEN
                      CALL cl_err(g_oma.oma16,'axr-102',1)
                      NEXT FIELD oma16
                   END IF
                END IF
             END IF
             LET g_buf= s_get_doc_no(g_oma.oma16)      #No.FUN-550071
             #LET g_sql = " SELECT oay11 FROM ",li_dbs CLIPPED,"oay_file",
             LET g_sql = " SELECT oay11 FROM ",cl_get_target_table(g_plant_new,'oay_file'), #FUN-A50102
                         "  WHERE oayslip='",g_buf,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                                    
             PREPARE sel_oay_pre30 FROM g_sql
             EXECUTE sel_oay_pre30 INTO g_oay11
             IF NOT STATUS AND
                g_oay11<>'Y' THEN
                CALL cl_err(g_oma.oma16,'axr-372',0)
                NEXT FIELD oma16
             END IF
             #LET g_sql = " SELECT oga65 FROM ",li_dbs CLIPPED,"oga_file",
             LET g_sql = " SELECT oga65 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                         "  WHERE oga01 = '",g_oma.oma16,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                                                
             PREPARE sel_oga_pre31 FROM g_sql
             EXECUTE sel_oga_pre31 INTO l_oga65
             IF l_oga65 = 'Y' THEN
                IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_oma.oma16 != g_oma_t.oma16 OR  #No.MOD-740170
                                   g_oma.oma16 != g_oma_o.oma16)) THEN #No.MOD-740170
                   CALL cl_err(g_oma.oma16,'axr-952',1)
                   NEXT FIELD oma16
                END IF  #No.MOD-740170
             END IF
          END IF
          IF g_oma.oma00='11' AND cl_null(g_oma.oma16) THEN
             CALL cl_err('','axr-168',0)
             NEXT FIELD oma16
          END IF
          IF g_oma.oma00='13' AND cl_null(g_oma.oma16) THEN
             CALL cl_err('','axr-169',0)
             NEXT FIELD oma16
          END IF
         #IF g_oma.oma00='11' AND NOT cl_null(g_oma.oma16) THEN                         #CHI-A50040 mark
          IF (g_oma.oma00='11' OR g_oma.oma00='13')   #CHI-A50040
              AND NOT cl_null(g_oma.oma16) AND NOT cl_null(g_oma.oma165) THEN    #No:FUN-A50103
            ##-----No:FUN-A50103 Mark 與下面重覆了-----
            ##-CHI-A50040-add-
            #IF g_oma.oma00='13' THEN
            #   LET g_cnt=0
            #   SELECT COUNT(*) INTO g_cnt FROM oma_file
            #    WHERE oma00='13'
            #      AND oma01 !=g_oma.oma01
            #      AND oma16=g_oma.oma16
            #   IF g_cnt >0 THEN
            #      CALL cl_err('','axr-261',0) NEXT FIELD oma16
            #   END IF
            #END IF
            ##-CHI-A50040-end-
            ##-----No:FUN-A50103 Mark END-----
             LET l_n = 0 
             IF g_oma.oma00 = '11' THEN                       #CHI-A50040           
                SELECT COUNT(*) INTO l_n FROM oma_file
                 WHERE oma16 = g_oma.oma16            
                   AND oma01 <> g_oma.oma01  #No.MOD-890148
                   AND oma00 = '11'                           #CHI-A50040
                   AND oma165 = g_oma.oma165    #No:FUN-A50103
             ELSE                                             #CHI-A50040
                SELECT COUNT(*) INTO l_n FROM oma_file        #CHI-A50040
                 WHERE oma16 = g_oma.oma16                    #CHI-A50040
                   AND oma01 <> g_oma.oma01                   #CHI-A50040 
                   AND oma00 = '13'                           #CHI-A50040
                   AND oma165 = g_oma.oma165    #No:FUN-A50103
             END IF                                           #CHI-A50040
             IF l_n > 0 THEN                        
                CALL cl_err(g_oma.oma16,'atm-310',0) 
                NEXT FIELD oma16   
             END IF 
 
             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oea_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                            "  WHERE oea01='",g_oma.oma16,"'",
                            "    AND oea00='1' ",
                            "    AND oeaplant = '",g_oma.oma66,"'"
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oea_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                            "  WHERE oea01='",g_oma.oma16,"'",
                            "    AND oea00='1'"
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel_oea_pre32 FROM g_sql
             EXECUTE sel_oea_pre32 INTO g_oea.*
             IF STATUS THEN
                CALL cl_err3("sel","oea_file",g_oma.oma16,"",STATUS,"","select oea",1)  #No.FUN-660116
                NEXT FIELD oma16 
             END IF

             #-----No:FUN-A50103-----
             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oeaa_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oeaa_file'), #FUN-A50102
                            "  WHERE oeaa01='",g_oma.oma16,"'",
                            "    AND oeaa03=",g_oma.oma165,
                            "    AND oeaaplant = '",g_oma.oma66,"'"
                IF g_oma.oma00='11' THEN
                   LET g_sql = g_sql," AND oeaa02='1' "
                ELSE
                   LET g_sql = g_sql," AND oeaa02='2' "
                END IF
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oeaa_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oeaa_file'), #FUN-A50102
                            "  WHERE oeaa01='",g_oma.oma16,"'",
                            "    AND oeaa01=",g_oma.oma165
                IF g_oma.oma00='11' THEN
                   LET g_sql = g_sql," AND oeaa02='1' "
                ELSE
                   LET g_sql = g_sql," AND oeaa02='2' "
                END IF
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel_oeaa_pre32 FROM g_sql
             EXECUTE sel_oeaa_pre32 INTO g_oeaa.*
             IF STATUS THEN
                CALL cl_err3("sel","oeaa_file",g_oma.oma16,"",STATUS,"","select oeaa",1)
                NEXT FIELD oma16 
             END IF
             #-----No:FUN-A50103 END-----

             IF g_oea.oeaconf = 'N' THEN
                CALL cl_err('','axr-194',0)
                NEXT FIELD oma16
             END IF
             IF p_cmd='a' THEN #由訂單轉訂金應收
                LET g_oma.oma03 = g_oea.oea03
                LET g_oma.oma032= g_oea.oea032
               #-MOD-AA0185-add-
                IF g_oma.oma03 = 'MISC' THEN
                   LET g_sql = " SELECT occm02,occm04 ",
                               " FROM ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                               "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                               "  WHERE oea01='",g_oea.oea01,"'",
                               "    AND oea01= occm01 "
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                   PREPARE sel_occm_pre FROM g_sql
                   EXECUTE sel_occm_pre INTO g_oma.oma042,g_oma.oma044 
                END IF
               #-MOD-AA0185-end-
                LET g_oma.oma04 = g_oea.oea03 
                LET g_oma.oma08 = g_oea.oea08
                LET g_oma.oma14 = g_oea.oea14 
                LET g_oma.oma15 = g_oea.oea15
                LET g_oma.oma161= g_oea.oea161
                LET g_oma.oma162= g_oea.oea162
                LET g_oma.oma163= g_oea.oea163
                LET g_oma.oma21 = g_oea.oea21
                LET g_oma.oma211= g_oea.oea211
                LET g_oma.oma212= g_oea.oea212
                LET g_oma.oma213= g_oea.oea213
                LET g_oma.oma23 = g_oea.oea23
                LET g_oma.oma68 = g_oea.oea17   
                #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
                LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01='",g_oma.oma68,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
                PREPARE sel_occ_pre33 FROM g_sql
                EXECUTE sel_occ_pre33 INTO g_oma.oma69
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","occ_file",g_oma.oma68,"",SQLCA.sqlcode,"","select occ_file",0)
                END IF
                IF g_oma.oma08='1' THEN
                   LET exT=g_ooz.ooz17
                ELSE
                   LET exT=g_ooz.ooz63
                END IF
               #CALL s_curr3(g_oma.oma23,g_oma.oma02,exT) RETURNING g_oma.oma24
               #CALL s_curr3(g_oma.oma23,g_oma.oma09,exT) RETURNING g_oma.oma58
                LET g_oma.oma24 = g_oeaa.oeaa07    #No:FUN-A50103
                LET g_oma.oma58 = g_oeaa.oeaa07    #No:FUN-A50103
                LET g_oma.oma25 = g_oea.oea25
                LET g_oma.oma26 = g_oea.oea26
               ##-----No:FUN-A50103-----
                LET g_oma.oma32 = g_oeaa.oeaa04
                LET g_oma.oma11 = g_oeaa.oeaa05
                LET g_oma.oma12 = g_oeaa.oeaa06
                IF g_oea.oea261 > 0 THEN
                   IF g_oma.oma00='13' AND g_oea.oea262=0 THEN
                      IF cl_null(g_oma.oma19) THEN
                         LET g_oma.oma19 = g_oea.oea01
                      END IF
                   END IF
                   IF NOT cl_null(g_oma.oma19) THEN   #check 訂金產生的待抵是否已沖平
                      IF g_ooz.ooz07 = 'N' THEN
                         SELECT COUNT(*) INTO g_cnt FROM oma_file
                          WHERE oma16=g_oma.oma19 AND (oma56t-oma57) >0
                            AND omaconf='Y'  AND omavoid='N' AND oma00='23'
                      ELSE
                         SELECT COUNT(*) INTO g_cnt FROM oma_file
                          WHERE oma16=g_oma.oma19 AND oma61 >0
                            AND omaconf='Y'  AND omavoid='N' AND oma00='23'
                      END IF
                      IF g_cnt =0 THEN   #表待抵均已沖完
                         LET g_oma.oma19=' '
                      END IF
                   END IF
                END IF
               ##-CHI-A50040-add-
               #IF g_oma.oma00='11' THEN 
               #   LET g_oma.oma32 = g_oea.oea80    #No.FUN-680022 
               #ELSE  
               #   IF g_oma.oma00='13' THEN
               #      LET g_oma.oma32 = g_oea.oea81   
               #   END IF
               #END IF
               ##-CHI-A50040-end-
               #CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
               #              g_oma.oma02,g_plant2) #NO.FUN-980020
               #     RETURNING g_oma.oma11,g_oma.oma12
               ##-----No:FUN-A50103 END-----

                IF NOT cl_null(g_oma.oma66) THEN 
                   LET g_plant2=g_oma.oma66 
                ELSE 
                   LET g_plant2 = g_plant 
                END IF 
                DISPLAY BY NAME g_oma.oma19, g_oma.oma03, g_oma.oma032,
                                g_oma.oma68,g_oma.oma69,
                                g_oma.oma11, g_oma.oma12,
                                g_oma.oma13, g_oma.oma14, g_oma.oma15,
                                g_oma.oma23, g_oma.oma24, g_oma.oma58,
                                g_oma.oma21,
                                g_oma.oma211, g_oma.oma212, g_oma.oma213
                CALL t300_show2()
             END IF
             #-----No:FUN-A50103 Mark 移到上面-----
             #-CHI-A50040-add-
            #IF g_oma.oma161 > 0 THEN
            #   IF g_oma.oma00='13' AND g_oma.oma162 =0 THEN 
            #       LET g_sql = " SELECT MAX(oma19) ",
            #                   "   FROM ",li_dbs CLIPPED,"oma_file",
            #                   "  WHERE oma16='",g_oma.oma16,"'",
            #                   "    AND oma00='11'",
            #                   "    AND omavoid='N"
            #       PREPARE sel_oma_pre36 FROM g_sql
            #       EXECUTE sel_oma_pre36 INTO g_oma.oma19
            #       IF NOT cl_null(g_oma.oma19) THEN
            #          LET g_cnt=0
            #          IF g_ooz.ooz07 = 'N' THEN
            #             SELECT COUNT(*) INTO g_cnt FROM oma_file
            #              WHERE oma00='23' AND oma01=g_oma.oma19
            #                AND oma56t-oma57>0
            #          ELSE                                                                                                         
            #             SELECT COUNT(*) INTO g_cnt FROM oma_file                                                                  
            #              WHERE oma00='23' AND oma01=g_oma.oma19                                                                   
            #                AND oma61>0                                                                                            
            #          END IF                                                                                                       
            #          IF g_cnt =0 THEN
            #             CALL cl_err(g_oma.oma19,'axr-190',0) NEXT FIELD oma16
            #          END IF
            #       END IF
            #       DISPLAY BY NAME g_oma.oma19
            #   END IF
            #END IF
            ##-CHI-A50040-end-
            ##-----No:FUN-A50103 Mark END-----
          END IF
         #IF (g_oma.oma00='12' OR g_oma.oma00='13') AND   #CHI-A50040 mark
          IF g_oma.oma00='12' AND                         #CHI-A50040
             NOT cl_null(g_oma.oma16) THEN
            #-CHI-A50040-mark-
            #IF g_oma.oma00='13' THEN
            #   LET g_cnt=0
            #   SELECT COUNT(*) INTO g_cnt FROM oma_file
            #    WHERE oma00='13' AND oma01 !=g_oma.oma01 AND oma16=g_oma.oma16
            #   IF g_cnt >0 THEN
            #      CALL cl_err('','axr-261',0) NEXT FIELD oma16
            #   END IF
            #END IF
            #-CHI-A50040-mark-
             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oga_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                            "  WHERE oga01='",g_oma.oma16,"'",
                            "    AND oga00 IN ('1','4','5','6','B')",    #MOD-A50108 add B
                            "    AND ogaplant = '",g_oma.oma66,"'"
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oga_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                            "  WHERE oga01='",g_oma.oma16,"'",
                            "    AND oga00 IN ('1','4','5','6','B')"     #MOD-A50108 add B
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102    
             PREPARE sel_oga_pre34 FROM g_sql
             EXECUTE sel_oga_pre34 INTO g_oga.*
             IF STATUS THEN
                CALL cl_err3("sel","oga_file",g_oma.oma16,"",STATUS,"","select oga",1)  #No.FUN-660116
                NEXT FIELD oma16 
             END IF
             IF g_oga.ogaconf = 'N' OR g_oga.ogapost = 'N' THEN
                CALL cl_err('','axr-194',0) NEXT FIELD oma16
             END IF
             #---99/05/13--oga00='3'或'5'則不產生AR
             IF (g_oay11 IS NOT NULL AND g_oay11 = 'N') AND
                g_oga.oga00 MATCHES '[35]' THEN
                 CALL cl_err('','axr-367',1) NEXT FIELD oma16
             END IF
             IF p_cmd='a' THEN #由出貨單轉應收
                LET g_oma.oma03 = g_oga.oga03 LET g_oma.oma032= g_oga.oga032
               #-MOD-AA0185-add-
                IF g_oma.oma03 = 'MISC' THEN
                   LET g_sql = " SELECT occm02,occm04 ",
                               " FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", 
                               "      ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                               "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                               "  WHERE oga01='",g_oga.oga01,"'",
                               "    AND oga16 = oea01 AND oeaconf <> 'X' ",
                               "    AND oea01= occm01 "
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                   PREPARE sel_occm_pre12 FROM g_sql
                   EXECUTE sel_occm_pre12 INTO g_oma.oma042,g_oma.oma044 
                   IF SQLCA.sqlcode THEN
                      LET g_sql = " SELECT occm02,occm04 ",
                                  " FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'ogb_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                                  "  WHERE oga01 = ogb01 ",
                                  "    AND oga01='",g_oga.oga01,"' AND ogb03 = 1 ",
                                  "    AND ogb31 = oea01 AND oeaconf <> 'X' ",
                                  "    AND oea01= occm01 "
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                      PREPARE sel_occm_pre122 FROM g_sql
                      EXECUTE sel_occm_pre122 INTO g_oma.oma042,g_oma.oma044 
                   END IF
                END IF
               #-MOD-AA0185-end-
                LET g_oma.oma04 = g_oga.oga03 LET g_oma.oma08 = g_oga.oga08
                LET g_oma.oma05 = g_oga.oga05
                LET g_oma.oma07 = g_oga.oga07
                LET g_oma.oma13 = g_oga.oga13
                LET g_oma.oma14 = g_oga.oga14 LET g_oma.oma15 = g_oga.oga15
                LET g_oma.oma161= g_oga.oga161 LET g_oma.oma162= g_oga.oga162
                LET g_oma.oma163= g_oga.oga163
                IF g_oma.oma00='12' THEN
                   LET g_oma.oma19 = g_oga.oga19
                END IF
                LET g_oma.oma21 = g_oga.oga21
                LET g_oma.oma211= g_oga.oga211 LET g_oma.oma212= g_oga.oga212
                LET g_oma.oma213= g_oga.oga213 LET g_oma.oma23 = g_oga.oga23
                LET g_oma.oma68 = g_oga.oga18   
                #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
                LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01='",g_oma.oma68,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
                PREPARE sel_occ_pre35 FROM g_sql
                EXECUTE sel_occ_pre35 INTO g_oma.oma69
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","occ_file",g_oma.oma68,"",SQLCA.sqlcode,"","select occ_file",0)
                END IF
                IF g_oma.oma08='1' THEN
                   LET exT=g_ooz.ooz17
                ELSE
                   LET exT=g_ooz.ooz63
                END IF
                IF (NOT cl_null(g_oga.oga021)) AND (g_oga.oga021>0) THEN
                   CALL s_curr3(g_oma.oma23,g_oga.oga021,exT)RETURNING g_oma.oma24
                ELSE
                   CALL s_curr3(g_oma.oma23,g_oma.oma02,exT)RETURNING g_oma.oma24
                END IF
                CALL s_curr3(g_oma.oma23,g_oma.oma09,exT)RETURNING g_oma.oma58
                LET g_oma.oma25 = g_oga.oga25
                LET g_oma.oma26 = g_oga.oga26
                IF g_oma.oma00='12' THEN 
                   LET g_oma.oma32 = g_oga.oga32
               #-CHI-A50040-mark-
               #ELSE  
               #   IF g_oma.oma00='13' THEN
               #      LET g_oma.oma32 = g_oea.oea81   
               #   END IF
               #-CHI-A50040-end-
                END IF
                IF NOT cl_null(g_oma.oma66) THEN 
                   LET g_plant2=g_oma.oma66 
                ELSE 
                   LET g_plant2 = g_plant 
                END IF 
                CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                              g_oma.oma02,g_plant2) #FUN-980020
                     RETURNING g_oma.oma11,g_oma.oma12
                LET g_oma.oma71 = g_oga.oga71                                  #MOD-AB0164
                DISPLAY BY NAME g_oma.oma19, g_oma.oma03, g_oma.oma032,
                                g_oma.oma32, g_oma.oma11, g_oma.oma12,
                                g_oma.oma68,g_oma.oma69,   #No.FUN-670026
                                g_oma.oma05,
                                g_oma.oma13, g_oma.oma14, g_oma.oma15,
                                g_oma.oma23, g_oma.oma24, g_oma.oma58,
                                g_oma.oma21,
                                g_oma.oma211, g_oma.oma212, g_oma.oma213,      
                                g_oma.oma71                                    #MOD-AB0164
                CALL t300_show2()
             END IF
             IF g_oma.oma161 > 0 THEN
               #IF (g_oma.oma00='12' AND g_oma.oma162 !=0  OR      #CHI-A50040 mark
               #    g_oma.oma00='13' AND g_oma.oma162  =0) THEN    #CHI-A50040 mark
                IF g_oma.oma00='12' AND g_oma.oma162 !=0 THEN      #CHI-A50040
                   ##-----No:FUN-A50103-----
                   #LET g_sql = " SELECT MAX(oma19) ",
                   #            "   FROM ",li_dbs CLIPPED,"oga_file,oma_file",
                   #            "  WHERE oga01='",g_oma.oma16,"'",
                   #            "    AND oga09 IN ('2','8')",
                   #            "    AND oga65='N'",
                   #            "    AND oga16=oma16",
                   #            "    AND oma00='11'",
                   #            "    AND oga00!='2'"
                   #PREPARE sel_oga_pre36 FROM g_sql
                   #EXECUTE sel_oga_pre36 INTO g_oma.oma19
                   LET g_oma.oma19 = g_oga.oga16
                   ##-----No:FUN-A50103 END-----
                    IF NOT cl_null(g_oma.oma19) THEN
                       LET g_cnt=0
                       IF g_ooz.ooz07 = 'N' THEN
                          SELECT COUNT(*) INTO g_cnt FROM oma_file
                          #WHERE oma00='23' AND oma01=g_oma.oma19
                           WHERE oma00='23' AND oma16=g_oma.oma19    #No:FUN-A50103
                             AND oma56t-oma57>0
                       ELSE                                                                                                         
                          SELECT COUNT(*) INTO g_cnt FROM oma_file                                                                  
                          #WHERE oma00='23' AND oma01=g_oma.oma19                                                                   
                           WHERE oma00='23' AND oma16=g_oma.oma19    #No:FUN-A50103
                             AND oma61>0                                                                                            
                       END IF                                                                                                       
                       IF g_cnt =0 THEN
                          CALL cl_err(g_oma.oma19,'axr-190',0) NEXT FIELD oma16
                       END IF
                    END IF
                    DISPLAY BY NAME g_oma.oma19
                END IF
             END IF
          END IF
         #IF g_oma.oma00='13' AND NOT cl_null(g_oma.oma16) THEN   #CHI-A50040 mark
         #END IF                                                  #CHI-A50040 mark
          IF g_oma.oma00 = '12' THEN 
             LET l_oga02 = '' 
             LET l_oga07 = ''   #MOD-760086
             #LET g_sql = " SELECT oga02,oga07 FROM ",li_dbs CLIPPED,"oga_file",
             LET g_sql = " SELECT oga02,oga07 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                         "  WHERE oga01 = '",g_oma.oma16,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
             PREPARE sel_oga_pre37 FROM g_sql
             EXECUTE sel_oga_pre37 INTO l_oga02,l_oga07
             IF l_oga02 > g_oma.oma02 THEN
                CALL cl_err(l_oga02,'axr-297',0)
                NEXT FIELD oma16
             END IF
             IF l_oga07 <> 'Y' THEN   #MOD-760086
                IF YEAR(l_oga02) <> YEAR(g_oma.oma02) OR
                   MONTH(l_oga02) <> MONTH(g_oma.oma02) THEN
                   CALL cl_err(l_oga02,'axr-299',0)
                   NEXT FIELD oma16
                END IF
             ELSE
                IF (YEAR(l_oga02) > YEAR(g_oma.oma02)) OR
                   (YEAR(l_oga02) = YEAR(g_oma.oma02) AND
                   MONTH(l_oga02) > MONTH(g_oma.oma02)) THEN
                   CALL cl_err(l_oga02,'axr-299',0)
                   NEXT FIELD oma16
                END IF
             END IF
          END IF
          IF g_oma.oma00 = '21' THEN 
             LET l_oha02 = ''
             #LET g_sql = " SELECT oha02 FROM ",li_dbs CLIPPED,"oha_file",
             LET g_sql = " SELECT oha02 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                         "  WHERE oha01 = '",g_oma.oma16,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             PREPARE sel_oha_pre38 FROM g_sql
             EXECUTE sel_oha_pre38 INTO l_oha02
             IF l_oha02 > g_oma.oma02 THEN
                CALL cl_err(l_oha02,'axr-296',0)
                NEXT FIELD oma16
             END IF
             IF (YEAR(l_oha02) > YEAR(g_oma.oma02)) OR
                (YEAR(l_oha02) = YEAR(g_oma.oma02) AND
                MONTH(l_oha02) > MONTH(g_oma.oma02)) THEN
                CALL cl_err(l_oha02,'axr-298',0)
                NEXT FIELD oma16
             END IF
          END IF 
          IF g_oma.oma00='21' AND NOT cl_null(g_oma.oma16) THEN
             #LET g_sql = " SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file",
             LET g_sql = " SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                         "  WHERE oha01 = '",g_oma.oma16,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             PREPARE sel_oha_pre39 FROM g_sql
             EXECUTE sel_oha_pre39 INTO l_oha09
             IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF   #MOD-940155 add
               IF l_oha09 = '2' OR l_oha09 = '3' THEN
                  CALL cl_err("","axr-605",1)
                  NEXT FIELD oma16
               END IF 
             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oha_file ",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                            "  WHERE oha01='",g_oma.oma16,"'",
                            "    AND ohaplant = '",g_oma.oma66,"'"
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oha_file ",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                            "  WHERE oha01='",g_oma.oma16,"'"
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel_oha_pre40 FROM g_sql
             EXECUTE sel_oha_pre40 INTO g_oha.*
             IF STATUS THEN
                CALL cl_err3("sel","oha_file",g_oma.oma16,"",STATUS,"","select oha",1)  #No.FUN-660116
                NEXT FIELD oma16
             END IF
             IF g_oha.ohaconf = 'N' THEN
                CALL cl_err('','axr-194',0) NEXT FIELD oma16
             END IF
              IF g_oha.ohapost = 'N' THEN
                 CALL cl_err('','axm-299',0) NEXT FIELD omb31
              END IF
             LET g_sql = " SELECT SUM(ohb917),SUM(ohb14t)",
                         #"   FROM ",li_dbs CLIPPED,"oha_file,",li_dbs CLIPPED,"ohb_file",
                         "   FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                    cl_get_target_table(g_plant_new,'ohb_file'),     #FUN-A50102
                         "  WHERE oha01=ohb01",
                         "    AND ohaconf='Y'",
                         "    AND ohb01='",g_oma.oma16,"'",
                         "    AND ohapost='Y'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
             PREPARE sel_oha_pre41 FROM g_sql
             EXECUTE sel_oha_pre41 INTO l_ohb917,l_ohb14t
             IF cl_null(l_ohb917 ) THEN LET l_ohb917 =0 END IF  #FUN-560070
             IF cl_null(l_ohb14t) THEN LET l_ohb14t=0 END IF
             SELECT SUM(omb12),SUM(omb14t) INTO l_omb12,l_omb14t
               FROM oma_file,omb_file
              WHERE oma01=omb01 AND oma00 MATCHES '21' AND omavoid='N'
                AND omb31=g_oma.oma16
             IF cl_null(l_omb12 ) THEN LET l_omb12 =0 END IF
             IF cl_null(l_omb14t) THEN LET l_omb14t=0 END IF
             IF (g_oma.oma34 !='5' AND l_ohb917!=0 AND l_ohb917-l_omb12<0) OR   #FUN-560070
                (g_oma.oma34  ='5' AND l_ohb14t = l_omb14t AND
                #l_ohb14t =0)      THEN     #BUGNO:4697     #MOD-A90154 mark
                 l_ohb917 =0 AND p_cmd='a') THEN                     #MOD-A90154 #MOD-B30656 mod
                CALL cl_err(l_ohb917,'axr-263',0) NEXT FIELD oma16   #FUN-560070
             END IF
             IF p_cmd='a' THEN #由銷退單轉折讓
                LET g_oma.oma03 = g_oha.oha03 LET g_oma.oma032= g_oha.oha032
                LET g_oma.oma04 = g_oha.oha03 LET g_oma.oma08 = g_oha.oha08
                LET g_oma.oma14 = g_oha.oha14 LET g_oma.oma15 = g_oha.oha15
                LET g_oma.oma21 = g_oha.oha21
                LET g_oma.oma211= g_oha.oha211 LET g_oma.oma212= g_oha.oha212
                LET g_oma.oma213= g_oha.oha213 LET g_oma.oma23 = g_oha.oha23
                LET g_oma.oma68 = g_oha.oha1001 
                #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
                LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01='",g_oma.oma68,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
                PREPARE sel_occ_pre42 FROM g_sql
                EXECUTE sel_occ_pre42 INTO g_oma.oma69
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","occ_file",g_oma.oma68,"",SQLCA.sqlcode,"","select occ_file",0)
                END IF
                IF g_oma.oma23=g_aza.aza17 THEN
                   LET g_oma.oma24 = 1
                   LET g_oma.oma58 = 1
                ELSE
                   LET g_sql = " SELECT UNIQUE oma24,oma58",
                               #"  FROM ",li_dbs CLIPPED,"oga_file,oma_file",
                               "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",oma_file", #FUN-A50102                               
                               " WHERE oga01 = '",g_oha.oha16,"'",
                               "   AND ogaconf = 'Y'",
                               "   AND ogapost = 'Y'",
                               "   AND oga01 = oma16",
                               "   AND oga00 != '2'",
                               "   AND omaconf = 'Y'"
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                   PREPARE sel_oga_pre43 FROM g_sql
                   EXECUTE sel_oga_pre43 INTO g_oma.oma24,g_oma.oma58
                   IF STATUS THEN
                      IF g_oma.oma08='1' THEN
                         LET exT=g_ooz.ooz17
                      ELSE
                         LET exT=g_ooz.ooz63
                      END IF
                      CALL s_curr3(g_oma.oma23,g_oma.oma02,exT)
                           RETURNING g_oma.oma24
                      LET g_oma.oma58 = g_oha.oha24
                   END IF
                END IF
                LET g_oma.oma25 = g_oha.oha25
                LET g_oma.oma26 = g_oha.oha26
                LET g_oma.oma11 = g_oma.oma02
                LET g_oma.oma12 = g_oma.oma02
                DISPLAY BY NAME g_oma.oma19, g_oma.oma03, g_oma.oma032,
                                g_oma.oma68,g_oma.oma69,
                                g_oma.oma11, g_oma.oma12,
                                g_oma.oma05,
                                g_oma.oma13, g_oma.oma14, g_oma.oma15,
                                g_oma.oma23, g_oma.oma24, g_oma.oma58,
                                g_oma.oma21,
                                g_oma.oma211, g_oma.oma212, g_oma.oma213
                CALL t300_show2()
             END IF
          END IF
          IF g_oma.oma00='25' AND NOT cl_null(g_oma.oma16) THEN
             SELECT * INTO b_oma.* FROM oma_file WHERE oma01=g_oma.oma16
             IF STATUS THEN
                CALL cl_err3("sel","oma_file",g_oma.oma16,"",STATUS,"","select oha",1)  #No.FUN-660116
                NEXT FIELD oma16 
             END IF
             IF b_oma.omaconf = 'N' THEN
                CALL cl_err('','axr-194',0) NEXT FIELD oma16
             END IF
             IF p_cmd='a' THEN #由銷退單轉折讓
                LET g_oma.oma03 = b_oma.oma03 LET g_oma.oma032= b_oma.oma032
                LET g_oma.oma04 = b_oma.oma03 LET g_oma.oma08 = b_oma.oma08
                LET g_oma.oma14 = b_oma.oma14 LET g_oma.oma15 = b_oma.oma15
                IF g_oma.oma10 IS NULL THEN
                   LET g_oma.oma09 = b_oma.oma09
                   LET g_oma.oma10 = b_oma.oma10
                END IF
                LET g_oma.oma21 = b_oma.oma21
                LET g_oma.oma211= b_oma.oma211 LET g_oma.oma212= b_oma.oma212
                LET g_oma.oma213= b_oma.oma213 LET g_oma.oma23 = b_oma.oma23
                LET g_oma.oma68 = b_oma.oma68   
                #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
                LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01='",g_oma.oma68,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                PREPARE sel_occ_pre44 FROM g_sql
                EXECUTE sel_occ_pre44 INTO g_oma.oma69
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","occ_file",g_oma.oma68,"",SQLCA.sqlcode,"","select occ_file",0)
                END IF
                LET g_oma.oma24 = b_oma.oma24
                LET g_oma.oma58 = b_oma.oma58 #取原出貨AR立帳匯率
               #LET g_oma.oma13 = '1'           #MOD-A60103 mark
               #-MOD-A60103-add-
                SELECT occ67 INTO g_oma.oma13 FROM occ_file
                  WHERE occ01 = b_oma.oma03
                IF cl_null(g_oma.oma13) THEN 
                   LET g_oma.oma13 = g_ooz.ooz08
                END IF
               #-MOD-A60103-add-
                SELECT ool51,ool511 INTO g_oma.oma18,g_oma.oma181 FROM ool_file
                 WHERE ool01 = g_oma.oma13
                LET g_oma.oma25 = b_oma.oma25
                LET g_oma.oma26 = b_oma.oma26
                DISPLAY BY NAME g_oma.oma19, g_oma.oma03, g_oma.oma032,
                                g_oma.oma68,g_oma.oma69,
                                g_oma.oma11, g_oma.oma12,
                                g_oma.oma05, g_oma.oma24,g_oma.oma58,
                                g_oma.oma13, g_oma.oma14, g_oma.oma15,
                                g_oma.oma23, g_oma.oma24, g_oma.oma58,
                                g_oma.oma21, g_oma.oma18, g_oma.oma09,
                                g_oma.oma10, g_oma.oma181, #FUN-670047
                                g_oma.oma211, g_oma.oma212, g_oma.oma213
                CALL t300_show2()
             END IF
          END IF
  
        #-----No:FUN-A50103-----
        AFTER FIELD oma165
          IF g_oma.oma00='11' AND cl_null(g_oma.oma165) THEN
             CALL cl_err('','axr-168',0)
             NEXT FIELD oma165
          END IF
          IF g_oma.oma00='13' AND cl_null(g_oma.oma165) THEN
             CALL cl_err('','axr-169',0)
             NEXT FIELD oma165
          END IF
          IF (g_oma.oma00='11' OR g_oma.oma00='13')
              AND NOT cl_null(g_oma.oma16) AND NOT cl_null(g_oma.oma165) THEN 
             LET l_n = 0 
             IF g_oma.oma00 = '11' THEN 
                SELECT COUNT(*) INTO l_n FROM oma_file
                 WHERE oma16 = g_oma.oma16            
                   AND oma01 <> g_oma.oma01
                   AND oma00 = '11' 
                   AND oma165 = g_oma.oma165
             ELSE
                SELECT COUNT(*) INTO l_n FROM oma_file 
                 WHERE oma16 = g_oma.oma16
                   AND oma01 <> g_oma.oma01
                   AND oma00 = '13'
                   AND oma165 = g_oma.oma165
             END IF
             IF l_n > 0 THEN                        
                CALL cl_err(g_oma.oma16,'atm-310',0) 
                NEXT FIELD oma165
             END IF 
 
             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oea_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                            "  WHERE oea01='",g_oma.oma16,"'",
                            "    AND oea00='1' ",
                            "    AND oeaplant = '",g_oma.oma66,"'"
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oea_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                            "  WHERE oea01='",g_oma.oma16,"'",
                            "    AND oea00='1'"
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
             PREPARE sel_oea_pre33 FROM g_sql
             EXECUTE sel_oea_pre33 INTO g_oea.*
             IF STATUS THEN
                CALL cl_err3("sel","oea_file",g_oma.oma16,"",STATUS,"","select oea",1) 
                NEXT FIELD oma165
             END IF

             IF NOT cl_null(g_oma.oma66) THEN  #不分業態
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oeaa_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oeaa_file'), #FUN-A50102
                            "  WHERE oeaa01='",g_oma.oma16,"'",
                            "    AND oeaa03=",g_oma.oma165,
                            "    AND oeaaplant = '",g_oma.oma66,"'"
                IF g_oma.oma00='11' THEN
                   LET g_sql = g_sql," AND oeaa02='1' "
                ELSE
                   LET g_sql = g_sql," AND oeaa02='2' "
                END IF
             ELSE
                #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oeaa_file",
                LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oeaa_file'), #FUN-A50102
                            "  WHERE oeaa01='",g_oma.oma16,"'",
                            "    AND oeaa01=",g_oma.oma165
                IF g_oma.oma00='11' THEN
                   LET g_sql = g_sql," AND oeaa02='1' "
                ELSE
                   LET g_sql = g_sql," AND oeaa02='2' "
                END IF
             END IF
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
             PREPARE sel_oeaa_pre33 FROM g_sql
             EXECUTE sel_oeaa_pre33 INTO g_oeaa.*
             IF STATUS THEN
                CALL cl_err3("sel","oeaa_file",g_oma.oma16,"",STATUS,"","select oeaa",1)
                NEXT FIELD oma165
             END IF

             IF g_oea.oeaconf = 'N' THEN
                CALL cl_err('','axr-194',0)
                NEXT FIELD oma165
             END IF
             IF p_cmd='a' THEN #由訂單轉訂金應收
                LET g_oma.oma03 = g_oea.oea03
                LET g_oma.oma032= g_oea.oea032
                LET g_oma.oma04 = g_oea.oea03 
                LET g_oma.oma08 = g_oea.oea08
                LET g_oma.oma14 = g_oea.oea14 
                LET g_oma.oma15 = g_oea.oea15
                LET g_oma.oma161= g_oea.oea161
                LET g_oma.oma162= g_oea.oea162
                LET g_oma.oma163= g_oea.oea163
                LET g_oma.oma21 = g_oea.oea21
                LET g_oma.oma211= g_oea.oea211
                LET g_oma.oma212= g_oea.oea212
                LET g_oma.oma213= g_oea.oea213
                LET g_oma.oma23 = g_oea.oea23
                LET g_oma.oma68 = g_oea.oea17   
                #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
                LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            "  WHERE occ01='",g_oma.oma68,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                PREPARE sel_occ_pre34 FROM g_sql
                EXECUTE sel_occ_pre34 INTO g_oma.oma69
                IF SQLCA.sqlcode THEN
                   CALL cl_err3("sel","occ_file",g_oma.oma68,"",SQLCA.sqlcode,"","select occ_file",0)
                END IF
                IF g_oma.oma08='1' THEN
                   LET exT=g_ooz.ooz17
                ELSE
                   LET exT=g_ooz.ooz63
                END IF
                LET g_oma.oma24 = g_oeaa.oeaa07
                LET g_oma.oma58 = g_oeaa.oeaa07
                LET g_oma.oma25 = g_oea.oea25
                LET g_oma.oma26 = g_oea.oea26
                LET g_oma.oma32 = g_oeaa.oeaa04
                LET g_oma.oma11 = g_oeaa.oeaa05
                LET g_oma.oma12 = g_oeaa.oeaa06
                IF g_oea.oea261 > 0 THEN
                   IF g_oma.oma00='13' AND g_oea.oea262=0 THEN
                      IF cl_null(g_oma.oma19) THEN
                         LET g_oma.oma19 = g_oea.oea01
                      END IF
                   END IF
                   IF NOT cl_null(g_oma.oma19) THEN   #check 訂金產生的待抵是否已沖平
                      IF g_ooz.ooz07 = 'N' THEN
                         SELECT COUNT(*) INTO g_cnt FROM oma_file
                          WHERE oma16=g_oma.oma19 AND (oma56t-oma57) >0
                            AND omaconf='Y'  AND omavoid='N' AND oma00='23'
                      ELSE
                         SELECT COUNT(*) INTO g_cnt FROM oma_file
                          WHERE oma16=g_oma.oma19 AND oma61 >0
                            AND omaconf='Y'  AND omavoid='N' AND oma00='23'
                      END IF
                      IF g_cnt =0 THEN   #表待抵均已沖完
                         LET g_oma.oma19=' '
                      END IF
                   END IF
                END IF

                IF NOT cl_null(g_oma.oma66) THEN 
                   LET g_plant2=g_oma.oma66 
                ELSE 
                   LET g_plant2 = g_plant 
                END IF 
                DISPLAY BY NAME g_oma.oma19, g_oma.oma03, g_oma.oma032,
                                g_oma.oma68,g_oma.oma69,
                                g_oma.oma11, g_oma.oma12,
                                g_oma.oma13, g_oma.oma14, g_oma.oma15,
                                g_oma.oma23, g_oma.oma24, g_oma.oma58,
                                g_oma.oma21,
                                g_oma.oma211, g_oma.oma212, g_oma.oma213
                CALL t300_show2()
             END IF
          END IF
          #-----No:FUN-A50103 END-----
         #-MOD-AB0025-add-
          SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05    
            FROM azi_file WHERE azi01=g_oma.oma23
         #-MOD-AB0025-end-

       AFTER FIELD oma67
         IF NOT cl_null(g_oma.oma67) THEN 
            LET l_cnt = 0 
            #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"ofa_file",
            LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'ofa_file'), #FUN-A50102
                        "  WHERE ofa01 = '",g_oma.oma67,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                         
            PREPARE sel_ofa_pre50 FROM g_sql
            EXECUTE sel_ofa_pre50 INTO l_cnt
            IF l_cnt = 0 THEN
               CALL cl_err(g_oma.oma67,'axr-252',1)
            END IF
         END IF
 
       BEFORE FIELD oma03
         CALL t300_set_entry(p_cmd)
 
       AFTER FIELD oma03
         IF NOT cl_null(g_oma.oma03) THEN
            #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"occ_file",
            LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        "  WHERE occ01='",g_oma.oma03,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
            PREPARE sel_occ_pre51 FROM g_sql
            EXECUTE sel_occ_pre51 INTO l_occ.*
            IF STATUS THEN
               CALL cl_err3("sel","occ_file",g_oma.oma03,"",STATUS,"","select occ",1)  #No.FUN-660116
               NEXT FIELD oma03 
            END IF
## No.2681 modify 1998/10/29 無效客戶不可立帳
            IF l_occ.occacti = 'N' THEN
               CALL cl_err(l_occ.occ01,'9028',0) NEXT FIELD oma03
            END IF
            IF g_oma.oma03[1,4] != 'MISC' THEN   #MOD-870095
               LET g_oma.oma032 = l_occ.occ02 DISPLAY BY NAME g_oma.oma032
               IF g_oma.oma68 IS NULL THEN
                  #LET g_sql = " SELECT occ07 FROM ",li_dbs CLIPPED,"occ_file",
                  LET g_sql = " SELECT occ07 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                              "  WHERE occ01='",g_oma.oma03,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                  PREPARE sel_occ_pre52 FROM g_sql
                  EXECUTE sel_occ_pre52 INTO g_oma.oma68
               END IF
            ELSE
                LET g_oma.oma68 = g_oma.oma03     #MOD-940065 
            END IF
            IF g_oma.oma04[1,4] != 'MISC' OR g_oma.oma04 IS NULL THEN  #MOD-9C0084
               LET g_oma.oma04 = g_oma.oma68   #MOD-870095 mod oma03->oma68
            END IF
           #對訂單、出貨單、銷退單進行客戶核對，凡客戶不同不允許過。
            IF NOT cl_null(g_oma.oma16) THEN
               CASE 
                #WHEN g_oma.oma00='11'                         #CHI-A50040 mark
                 WHEN (g_oma.oma00='11' OR g_oma.oma00='13')   #CHI-A50040 
                   #LET g_sql = " SELECT oea17 FROM ",li_dbs CLIPPED,"oea_file",
                   LET g_sql = " SELECT oea17 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                               "  WHERE oea01='",g_oma.oma16,"'"
                   IF NOT cl_null(g_oma.oma66) THEN
                      LET g_sql = g_sql CLIPPED," AND oeaplant = '",g_oma.oma66,"'"
                   END IF
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
                   PREPARE sel_oea_pre53 FROM g_sql
                   EXECUTE sel_oea_pre53 INTO l_occ01
                   IF SQLCA.sqlcode THEN
                      CALL cl_err3("sel","oea_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                   END IF
                   IF l_occ01 != g_oma.oma68 THEN  #MOD-860256 mod oma03->oma68
                      CALL cl_err("","axr-601",1)
                      NEXT FIELD oma03
                   END IF
                  #-MOD-AA0185-add-
                   IF g_oma.oma03 = 'MISC' THEN
                      LET g_sql = " SELECT oea032,occm02,occm04 ",
                                  " FROM ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                                  "  WHERE oea01='",g_oma.oma16,"'",
                                  "    AND oea01= occm01 "
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                      PREPARE sel_occm_oea_pre FROM g_sql
                      EXECUTE sel_occm_oea_pre INTO g_oma.oma032,g_oma.oma042,g_oma.oma044 
                   END IF
                  #-MOD-AA0185-end-
                #WHEN (g_oma.oma00='12' OR g_oma.oma00='13')   #CHI-A50040 mark
                 WHEN g_oma.oma00='12'                         #CHI-A50040
                   #LET g_sql = " SELECT oga18 FROM ",li_dbs CLIPPED,"oga_file",
                   LET g_sql = " SELECT oga18 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                               "  WHERE oga01='",g_oma.oma16,"'"
                   IF NOT cl_null(g_oma.oma66) THEN
                      LET g_sql = g_sql CLIPPED," AND ogaplant = '",g_oma.oma66,"'"
                   END IF
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
                   PREPARE sel_oga_pre54 FROM g_sql
                   EXECUTE sel_oga_pre54 INTO l_occ01
                   IF SQLCA.sqlcode THEN
                      CALL cl_err3("sel","oga_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                   END IF
                   IF l_occ01 != g_oma.oma68 THEN  #MOD-860256 mod oma03->oma68
                      CALL cl_err("","axr-602",1)
                      NEXT FIELD oma03
                   END IF
                  #-MOD-AA0185-add-
                   IF g_oma.oma03 = 'MISC' THEN
                      LET g_sql = " SELECT oga032,occm02,occm04 ",
                                  " FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                                  "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                                  "  WHERE oga01='",g_oma.oma16,"'",
                                  "    AND oga16 = oea01 AND oeaconf <> 'X' ",
                                  "    AND oea01= occm01 "
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                      PREPARE sel_occm_oga_pre12 FROM g_sql
                      EXECUTE sel_occm_oga_pre12 INTO g_oma.oma032,g_oma.oma042,g_oma.oma044 
                      IF SQLCA.sqlcode THEN
                         LET g_sql = " SELECT oga032,occm02,occm04 ",
                                     " FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", 
                                     "      ",cl_get_target_table(g_plant_new,'ogb_file'),",", 
                                     "      ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                                     "      ",cl_get_target_table(g_plant_new,'occm_file'), 
                                     "  WHERE oga01 = ogb01 ",
                                     "    AND oga01='",g_oma.oma16,"' AND ogb03 = 1 ",
                                     "    AND ogb31 = oea01 AND oeaconf <> 'X' ",
                                     "    AND oea01= occm01 "
                         CALL cl_replace_sqldb(g_sql) RETURNING g_sql            				
	                 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
                         PREPARE sel_occm_oga_pre122 FROM g_sql
                         EXECUTE sel_occm_oga_pre122 INTO g_oma.oma032,g_oma.oma042,g_oma.oma044 
                      END IF
                   END IF
                  #-MOD-AA0185-end-
                 WHEN g_oma.oma00='21'
                   IF g_aza.aza50='Y' THEN         #MOD-950311
                   #LET g_sql = " SELECT oha1001 FROM ",li_dbs CLIPPED,"oha_file",
                   LET g_sql = " SELECT oha1001 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                               "  WHERE oha01='",g_oma.oma16,"'"
                   IF NOT cl_null(g_oma.oma66) THEN
                      LET g_sql = g_sql CLIPPED," AND ohaplant = '",g_oma.oma66,"'"
                   END IF
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
                   PREPARE sel_oha_pre55 FROM g_sql
                   EXECUTE sel_oha_pre55 INTO l_occ01
                   IF SQLCA.sqlcode THEN
                      CALL cl_err3("sel","oha_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                   END IF
                   IF l_occ01 != g_oma.oma68 THEN  #MOD-860256 mod oma03->oma68
                      CALL cl_err("","axr-603",1)
                      NEXT FIELD oma03
                   END IF
                   END IF                          #MOD-950311
                 OTHERWISE EXIT CASE
               END CASE
            END IF
            DISPLAY BY NAME g_oma.oma032           #MOD-AA0185
            IF g_oma.oma16 IS NULL OR g_oma.oma00 = '14' THEN
                IF (p_cmd = 'a' AND g_oma_t.oma03 IS NULL ) OR    #MOD-680005
                    g_oma.oma03 != g_oma_t.oma03 THEN   #MOD-680005
                   LET g_oma.oma04 = g_oma.oma03
                   LET g_oma.oma05 = l_occ.occ08 DISPLAY BY NAME g_oma.oma05
                   LET g_oma.oma14 = l_occ.occ04 DISPLAY BY NAME g_oma.oma14   #MOD-9C0075 mark回復
                   IF NOT cl_null(g_oma.oma14) THEN
                      #MOD-AC0265 add --start--
                      IF g_oma.oma03 <> g_oma_t.oma03 OR cl_null(g_oma_t.oma03) THEN
                        # SELECT gen03 INTO g_oma.oma15 FROM gen_file      #No:110927  Modify <<--yangjian--
                        #  WHERE gen01=g_oma.oma14
                         LET g_oma.oma15 = l_occ.occ1005     #No:110927  Add  <<--yangjian--
                      END IF
                      #MOD-AC0265 add --end--
                      LET l_gen02 = ' '
                     #SELECT gen02,gen03 INTO l_gen02,g_oma.oma15 FROM gen_file #MOD-AC0265 mark
                      SELECT gen02 INTO l_gen02 FROM gen_file                   #MOD-AC0265
                       WHERE gen01=g_oma.oma14
                      SELECT gem02 INTO l_gem02 FROM gem_file
                       WHERE gem01=g_oma.oma15
                      DISPLAY l_gen02 TO FORMONLY.gen02
                      DISPLAY BY NAME g_oma.oma15
                      DISPLAY l_gem02 TO FORMONLY.gem02
                      IF cl_null(g_oma.oma930) THEN   #TQC-B60312   Add
                         LET g_oma.oma930=s_costcenter(g_oma.oma15)
                         DISPLAY BY NAME g_oma.oma930
                         DISPLAY s_costcenter_desc(g_oma.oma930) TO FORMONLY.gem02a
                      END IF                              #TQC-B60312   Add
                   END IF
                   LET g_oma.oma21 = l_occ.occ41 DISPLAY BY NAME g_oma.oma21
                   LET g_oma.oma23 = l_occ.occ42 DISPLAY BY NAME g_oma.oma23
                   LET g_oma.oma40 = l_occ.occ37 DISPLAY BY NAME g_oma.oma40
                   LET g_oma.oma25 = l_occ.occ43
                   LET g_oma.oma32 = l_occ.occ45
                   LET g_oma.oma042= l_occ.occ11
                   LET g_oma.oma043= l_occ.occ18
                   LET g_oma.oma044= l_occ.occ231
                   IF NOT cl_null(g_oma.oma66) THEN 
                      LET g_plant2=g_oma.oma66 
                   ELSE 
                      LET g_plant2 = g_plant 
                   END IF 
                   CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                                 g_oma.oma02,g_plant2) #NO.FUN-980020
                               RETURNING g_oma.oma11,g_oma.oma12   #No.MOD-530284
                   DISPLAY BY NAME g_oma.oma11,g_oma.oma12   #No.MOD-530284
                   SELECT gec04,gec05,gec07
                     INTO g_oma.oma211,g_oma.oma212,g_oma.oma213
                     FROM gec_file WHERE gec01=g_oma.oma21
                      AND gec011='2'  #銷項
                   DISPLAY BY NAME g_oma.oma211,g_oma.oma212,g_oma.oma213
                   IF g_oma.oma08='1' THEN
                      LET exT=g_ooz.ooz17
                   ELSE
                      LET exT=g_ooz.ooz63
                   END IF
                   IF g_oma.oma23=g_aza.aza17 THEN
                      LET g_oma.oma24=1
                      LET g_oma.oma58=1
                      DISPLAY BY NAME g_oma.oma24,g_oma.oma58
                   ELSE
                      IF g_oma.oma23!=g_oma_o.oma23 OR
                         g_oma.oma24=0 OR g_oma.oma24=1 THEN
                         CALL s_curr3(g_oma.oma23,g_oma.oma02,exT)
                                     RETURNING g_oma.oma24
                      END IF
                      IF g_oma.oma23!=g_oma_o.oma23 OR
                         g_oma.oma58=0 OR g_oma.oma58=1 THEN
                         CALL s_curr3(g_oma.oma23,g_oma.oma09,exT)
                              RETURNING g_oma.oma58
                      END IF
                      DISPLAY BY NAME g_oma.oma24,g_oma.oma58
                   END IF
                END IF
            END IF
            IF g_oma.oma03 <> g_oma_t.oma03 OR 
               g_oma_t.oma03 IS NULL THEN 
               #LET g_sql = " SELECT occ67 FROM ",li_dbs CLIPPED,"occ_file",
               LET g_sql = " SELECT occ67 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           "  WHERE occ01 = '",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
               PREPARE sel_occ_pre56 FROM g_sql
               EXECUTE sel_occ_pre56 INTO g_oma.oma13 
               IF cl_null(g_oma.oma13) THEN 
                  LET g_oma.oma13 = g_ooz.ooz08
               END IF
               DISPLAY BY NAME g_oma.oma13
            END IF
            LET g_oma_t.oma03 = g_oma.oma03   #MOD-680005
         END IF
         CALL t300_set_no_entry(p_cmd)
 
       AFTER FIELD oma032
         IF g_oma.oma03[1,4] = 'MISC' AND g_oma.oma68[1,4] = 'MISC' AND
            g_oma.oma69 IS NULL THEN
            LET g_oma.oma69 = g_oma.oma032
            DISPLAY BY NAME g_oma.oma69
         END IF

       AFTER FIELD oma32
          IF g_oma.oma00 MATCHES '1*' AND cl_null(g_oma.oma32) THEN
             NEXT FIELD oma32
          END IF
          IF NOT cl_null(g_oma.oma32) THEN
             #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oag_file",
             LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oag_file'), #FUN-A50102
                         "  WHERE oag01 = '",g_oma.oma32,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
             PREPARE sel_oag_pre57 FROM g_sql
             EXECUTE sel_oag_pre57 INTO l_n
             IF l_n = 0 THEN
                CALL cl_err('','axr-955',0)
                NEXT FIELD oma32
             END IF
             IF g_oma.oma00 MATCHES '1*' OR g_oma.oma00 MATCHES '31' THEN #MOD-9C0410
                IF NOT cl_null(g_oma.oma66) THEN
                   LET g_plant2=g_oma.oma66
                ELSE
                   LET g_plant2 = g_plant
                END IF
                CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                              g_oma.oma02,g_plant2) #FUN-980020
                           RETURNING g_oma.oma11,g_oma.oma12
             ELSE
                LET g_oma.oma11 = g_oma.oma02
                LET g_oma.oma12 = g_oma.oma02
             END IF
             DISPLAY BY NAME g_oma.oma11,g_oma.oma12  #No.FUN-680022 mark
          END IF
 
       BEFORE FIELD oma68
          CALL cl_set_comp_entry("oma69",TRUE)
       AFTER FIELD oma68
          IF (g_oma.oma68[1,4]!='MISC') AND (NOT cl_null(g_oma.oma68)) AND (g_oma.oma68!=' ') THEN
             #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"occ_file",
             LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                         "  WHERE occ01='",g_oma.oma68,"' AND occacti='Y'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             PREPARE sel_occ_pre65 FROM g_sql
             EXECUTE sel_occ_pre65 INTO l_occ.*
             IF SQLCA.sqlcode THEN
                CALL cl_err3("sel","occ_file",g_oma.oma68,"Y",SQLCA.sqlcode,"","sel acti",1)
                NEXT FIELD oma68
             ELSE
                IF l_occ.occ06 NOT MATCHES '[1,3]' THEN 
                   CALL cl_err(g_oma.oma68,"axr-604",1)
                   NEXT FIELD oma68 
                END IF
             END IF
            #與訂單、出貨單、銷退單進行客戶核對，凡客戶不同不允許過。
             IF NOT cl_null(g_oma.oma16) THEN
                CASE 
                 #WHEN g_oma.oma00='11'                         #CHI-A50040 mark
                  WHEN (g_oma.oma00='11' OR g_oma.oma00='13')   #CHI-A50040
                    #LET g_sql = " SELECT oea17 FROM ",li_dbs CLIPPED,"oea_file",
                    LET g_sql = " SELECT oea17 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                                "  WHERE oea01='",g_oma.oma16,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
                    PREPARE sel_oea_pre58 FROM g_sql
                    EXECUTE sel_oea_pre58 INTO l_occ01
                    IF SQLCA.sqlcode THEN
                       CALL cl_err3("sel","oea_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                    END IF
                    IF l_occ01 != g_oma.oma68 THEN  #MOD-860088 mod oma03->oma68
                       CALL cl_err("","axr-601",1)
                       NEXT FIELD oma68             #MOD-860088 mod oma03->oma68
                    END IF
                 #WHEN (g_oma.oma00='12' OR g_oma.oma00='13')   #CHI-A50040 mark
                  WHEN g_oma.oma00='12'                         #CHI-A50040
                    #LET g_sql = " SELECT oga18 FROM ",li_dbs CLIPPED,"oga_file",
                    LET g_sql = " SELECT oga18 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "  WHERE oga01='",g_oma.oma16,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
                    PREPARE sel_oga_pre59 FROM g_sql
                    EXECUTE sel_oga_pre59 INTO l_occ01
                    IF SQLCA.sqlcode THEN
                       CALL cl_err3("sel","oga_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                    END IF
                    IF l_occ01 != g_oma.oma68 THEN  #MOD-860088 mod oma03->oma68
                       CALL cl_err("","axr-602",1)
                       NEXT FIELD oma68             #MOD-860088 mod oma03->oma68
                    END IF
                  WHEN g_oma.oma00='21'
                    IF g_aza.aza50='Y' THEN         #MOD-950311
                    #LET g_sql = " SELECT oha1001 FROM ",li_dbs CLIPPED,"oha_file",
                    LET g_sql = " SELECT oha1001 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                "  WHERE oha01='",g_oma.oma16,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                    PREPARE sel_oha_pre60 FROM g_sql
                    EXECUTE sel_oha_pre60 INTO l_occ01
                    IF SQLCA.sqlcode THEN
                       CALL cl_err3("sel","oha_file",g_oma.oma16,"",SQLCA.sqlcode,"","",1)
                    END IF
                    IF l_occ01 != g_oma.oma68 THEN  #MOD-860088 mod oma03->oma68
                       CALL cl_err("","axr-603",1)
                       NEXT FIELD oma68             #MOD-860088 mod oma03->oma68
                    END IF
                    END IF                          #MOD-950311
                  OTHERWISE EXIT CASE
                END CASE
             END IF
             #LET g_sql = " SELECT occ02 FROM ",li_dbs CLIPPED,"occ_file",
             LET g_sql = " SELECT occ02 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                         "  WHERE occ01='",g_oma.oma68,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
             PREPARE sel_occ_pre61 FROM g_sql
             EXECUTE sel_occ_pre61 INTO g_oma.oma69
             DISPLAY BY NAME g_oma.oma69
          END IF
       
       BEFORE FIELD oma69
          IF g_oma.oma03[1,4]='MISC' OR g_oma.oma68[1,4]='MISC' THEN
             IF g_oma.oma03[1,4]='MISC' AND g_oma.oma68[1,4]='MISC' THEN
                CALL cl_set_comp_entry("oma69",TRUE)
             ELSE
                CALL cl_err('','axr-037',1)
                CALL cl_set_comp_entry("oma69",FALSE)
             END IF
          ELSE
             CALL cl_set_comp_entry("oma69",FALSE)
          END IF
 
       AFTER FIELD oma69
          CALL cl_set_comp_entry("oma69",FALSE)
 
       AFTER FIELD oma13
          IF g_oma.oma00 MATCHES '1*' AND cl_null(g_oma.oma13) THEN
             NEXT FIELD oma13
          END IF
          IF NOT cl_null(g_oma.oma13) THEN
             SELECT * INTO l_ool.* FROM ool_file WHERE ool01=g_oma.oma13   #FUN-670047
             IF STATUS THEN
                CALL cl_err3("sel","ool_file",g_oma.oma13,"0",STATUS,"","select ool",1)  #No.FUN-660116 MOD-670103
                NEXT FIELD oma13
             END IF
             IF g_oma_t.oma13 IS NULL OR g_oma.oma13 <> g_oma_t.oma13 THEN   #MOD-830119
                   IF g_oma.oma00='11' THEN LET g_oma.oma18=l_ool.ool11 END IF
                   IF g_oma.oma00='12' THEN LET g_oma.oma18=l_ool.ool11 END IF
                   IF g_oma.oma00='13' THEN LET g_oma.oma18=l_ool.ool11 END IF
                   IF g_oma.oma00='14' THEN LET g_oma.oma18=l_ool.ool11 END IF
                   IF g_oma.oma00 MATCHES '2[1,2,5]' THEN
                     #無論單據別是否要拋轉傳票，都照下面的邏輯抓科目
                     #IF g_aza.aza26 = '2' THEN           #CHI-920009 mark
                         IF g_ooy.ooydmy1='Y' THEN       
                            LET g_oma.oma18=l_ool.ool26  
                         ELSE                            
                            IF g_oma.oma00='21' THEN
                               IF g_oma.oma34 ='5' THEN
                                  LET g_oma.oma18=l_ool.ool47
                               ELSE
                                  LET g_oma.oma18=l_ool.ool42
                               END IF
                            END IF
                            IF g_oma.oma00='22' THEN
                               LET g_oma.oma18=l_ool.ool25
                            END IF
                            IF g_oma.oma00='25' THEN
                               LET g_oma.oma18=l_ool.ool51
                            END IF
                         END IF   
                     #END IF                        #CHI-920009 mark         
                     #CHI-920009------------mark start----不要再拆分大陸/臺灣版不同處理方式-----------
                     #IF g_aza.aza26 <> '2' THEN    #No.MOD-890172
                     #      IF g_oma.oma00='21' THEN
                     #         IF g_oma.oma34 ='5' THEN
                     #            LET g_oma.oma18=l_ool.ool47
                     #         ELSE
                     #            LET g_oma.oma18=l_ool.ool42
                     #         END IF
                     #      END IF
                     #      IF g_oma.oma00='22' THEN
                     #         LET g_oma.oma18=l_ool.ool25
                     #      END IF
                     #      IF g_oma.oma00='25' THEN
                     #         LET g_oma.oma18=l_ool.ool51
                     #      END IF
                     #END IF    #No.MOD-890172
                     #CHI-920009 ----------------mark end------------------------------------------- 
                   END IF
                DISPLAY BY NAME g_oma.oma18
             END IF
             IF g_oma_t.oma13 IS NULL OR g_oma.oma13 <> g_oma_t.oma13 THEN   #MOD-830119
                   IF g_oma.oma00='11' THEN LET g_oma.oma181=l_ool.ool111 END IF
                   IF g_oma.oma00='12' THEN LET g_oma.oma181=l_ool.ool111 END IF
                   IF g_oma.oma00='13' THEN LET g_oma.oma181=l_ool.ool111 END IF
                   IF g_oma.oma00='14' THEN LET g_oma.oma181=l_ool.ool111 END IF
                   IF g_oma.oma00 MATCHES '2[1,2,5]' THEN
                     #無論單據別是否要拋轉傳票，都照下面的邏輯抓科目
                     #CHI-920009 -------------------mark start-----------------------
                     #IF g_aza.aza26 = '2' THEN 
                     #   IF g_ooy.ooydmy1='Y' THEN         
                     #      LET g_oma.oma181=l_ool.ool261  
                     #   ELSE                              
                     #      IF g_oma.oma00='21' THEN
                     #         IF g_oma.oma34 ='5' THEN
                     #            LET g_oma.oma181=l_ool.ool471
                     #         ELSE
                     #            LET g_oma.oma181=l_ool.ool421
                     #         END IF
                     #      END IF
                     #      IF g_oma.oma00='22' THEN
                     #         LET g_oma.oma181=l_ool.ool251
                     #      END IF
                     #      IF g_oma.oma00='25' THEN
                     #         LET g_oma.oma181=l_ool.ool511
                     #      END IF
                     #   END IF   
                     #END IF
                     #IF g_aza.aza26 <> '2' THEN   #No.MOD-890172
                     #CHI-920009 ---------------mark end------------------------------
                         IF g_ooy.ooydmy1='Y' THEN              #CHI-920009 add
                            LET g_oma.oma181 = l_ool.ool261     #CHI-920009 add
                         ELSE                                   #CHI-920009 add
                            IF g_oma.oma00='21' THEN
                               IF g_oma.oma34 ='5' THEN
                                  LET g_oma.oma181=l_ool.ool471
                               ELSE
                                  LET g_oma.oma181=l_ool.ool421
                               END IF
                            END IF
                            IF g_oma.oma00='22' THEN
                               LET g_oma.oma181=l_ool.ool251
                            END IF
                            IF g_oma.oma00='25' THEN
                               LET g_oma.oma181=l_ool.ool511
                            END IF
                         END IF                #CHI-920009 add  
                     #END IF   #No.MOD-890172  #CHI-920009 mark
                   END IF
                DISPLAY BY NAME g_oma.oma181
             END IF
             SELECT ool02 INTO l_ool02 FROM ool_file 
              WHERE ool01 = g_oma.oma13
             DISPLAY l_ool02 TO FORMONLY.ool02
          END IF
 
       AFTER FIELD oma14
          IF NOT cl_null(g_oma.oma14) THEN
             IF g_oma.oma14 <> g_oma_t.oma14 OR cl_null(g_oma_t.oma14) THEN   #MOD-AC0265 add
                SELECT gen03 INTO g_oma.oma15 FROM gen_file WHERE gen01=g_oma.oma14 AND genacti='Y'       #No.TQC-7C0048 
                DISPLAY BY NAME g_oma.oma15        #No.MOD-530008
             END IF #MOD-AC0265 add
              CALL t300_oma14(p_cmd)       #No.MOD-490461
             IF STATUS THEN
                CALL cl_err('select gen',STATUS,0)  
                NEXT FIELD oma14 
             END IF
          END IF
 
       AFTER FIELD oma15
          IF NOT cl_null(g_oma.oma15) THEN
             LET l_n1 = 0                                                                                                           
             SELECT COUNT(*) INTO l_n1 FROM gem_file                                                                                
              WHERE gem01=g_oma.oma15                                                                                               
                AND gemacti='Y'                                                                                                     
             IF l_n1 = 0 THEN                                                                                                       
                CALL cl_err('','aap-039',0)                                                                                         
                NEXT FIELD oma15                                                                                                    
             END IF                                                                                                                 
              CALL t300_oma15(p_cmd)       #No.MOD-490461
              IF NOT cl_null(g_errno) THEN 
                 CALL cl_err(g_oma.oma15,g_errno,0)
                 NEXT FIELD oma15
              END IF
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET l_aag05=''   
             SELECT aag05 INTO l_aag05 FROM aag_file
              WHERE aag01 = g_oma.oma18
                AND aag00 = g_bookno1      
            
             LET g_errno = ' '   
             IF l_aag05 = 'Y' AND NOT cl_null(g_oma.oma18) THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN    
                   CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma15,g_bookno1)  #No.FUN-730064
                                 RETURNING g_errno
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oma15
                END IF
             END IF
            
             IF g_aza.aza63='Y' THEN 
                LET l_aag05a=''   
                SELECT aag05 INTO l_aag05a FROM aag_file
                 WHERE aag01 = g_oma.oma181
                   AND aag00 = g_bookno2      
                
                LET g_errno = ' '   
                IF l_aag05a = 'Y' AND NOT cl_null(g_oma.oma181) THEN
                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                   IF g_aaz.aaz90 !='Y' THEN  
                      CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma15,g_bookno2)
                                    RETURNING g_errno
                   END IF
                   IF NOT cl_null(g_errno) THEN
                      CALL cl_err('',g_errno,0)
                      NEXT FIELD oma15
                   END IF
                END IF
             END IF  
 

             IF cl_null(g_oma.oma930) THEN      #TQC-B60312   Add
                LET g_oma.oma930=s_costcenter(g_oma.oma15)
                DISPLAY BY NAME g_oma.oma930
                DISPLAY s_costcenter_desc(g_oma.oma930) TO FORMONLY.gem02a
             END IF                             #TQC-B60312   Add
          END IF
 
       AFTER FIELD oma66
          IF NOT cl_null(g_oma.oma66) THEN 
             CALL t300_oma66(p_cmd)
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_oma.oma66,g_errno,1)
                NEXT FIELD oma66
             END IF
          END IF 
          LET li_dbs = ''
          IF NOT cl_null(g_oma.oma66) THEN
             LET g_plant_new = g_oma.oma66
          ELSE
             LET g_plant_new = g_plant
          END IF
          #CALL s_gettrandbs()
          #LET li_dbs = g_dbs_tra
          IF NOT cl_null(g_oma.oma16) AND l_oma66_t <> g_oma.oma66 THEN
             NEXT FIELD oma16
          END IF

       BEFORE FIELD oma66
          LET l_oma66_t = g_oma.oma66
 
       BEFORE FIELD oma23
          LET g_oma_o.oma23=g_oma.oma23
          CALL t300_set_entry(p_cmd)
 
       AFTER FIELD oma23
          IF NOT cl_null(g_oma.oma23) THEN
             SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05     #No.TQC-7C0070
               FROM azi_file WHERE azi01=g_oma.oma23
             IF STATUS THEN
                CALL cl_err3("sel","azi_file",g_oma.oma23,"",STATUS,"","select azi",1)  #No.FUN-660116
                NEXT FIELD oma23
             END IF
             IF cl_null(g_oma.oma24) THEN LET g_oma.oma24=0 END IF
             IF cl_null(g_oma.oma58) THEN LET g_oma.oma58=0 END IF
             IF g_oma.oma08='1' THEN
                LET exT=g_ooz.ooz17
             ELSE
                LET exT=g_ooz.ooz63
             END IF
             IF g_oma.oma23=g_aza.aza17 AND g_oma.oma23=g_oma_o.oma23 THEN #No.TQC-7B0165
                LET g_oma.oma24=1
                LET g_oma.oma58=1
                DISPLAY BY NAME g_oma.oma24,g_oma.oma58
             ELSE
                IF g_oma.oma23!=g_oma_o.oma23 OR
                   g_oma.oma24=0 OR g_oma.oma24=1 THEN
                   CALL s_curr3(g_oma.oma23,g_oma.oma02,exT)
                        RETURNING g_oma.oma24
                END IF
                IF g_oma.oma23!=g_oma_o.oma23 OR
                   g_oma.oma58=0 OR g_oma.oma58=1 THEN
                   CALL s_curr3(g_oma.oma23,g_oma.oma09,exT)
                        RETURNING g_oma.oma58
                END IF
                DISPLAY BY NAME g_oma.oma24,g_oma.oma58
                IF g_oma.oma23!=g_oma_o.oma23 AND
                   g_oma.oma24!=g_oma_o.oma24 THEN
                   #若無單身則不需要修改
                   SELECT COUNT(*) INTO l_n FROM omb_file
                    WHERE omb01=g_oma.oma01
                   IF l_n > 0 THEN
                      IF cl_confirm('axr-172') THEN
                         DECLARE t300_oma24_c1 CURSOR FOR
                            SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                         FOREACH t300_oma24_c1 INTO x.*
                            IF STATUS THEN EXIT FOREACH END IF
                            LET x.omb15 =x.omb13 *g_oma.oma24
                            LET x.omb16 =x.omb14 *g_oma.oma24
                            LET x.omb16t=x.omb14t*g_oma.oma24
                            CALL cl_digcut(x.omb15,g_azi03) RETURNING x.omb15
                            CALL cl_digcut(x.omb16,g_azi04) RETURNING x.omb16
                            CALL cl_digcut(x.omb16t,g_azi04)RETURNING x.omb16t
                            IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
                               LET x.omb37=x.omb16t
                            END IF
                            LET x.omb17 =x.omb13 *g_oma.oma58
                            LET x.omb18 =x.omb14 *g_oma.oma58
                            LET x.omb18t=x.omb14t*g_oma.oma58
                            CALL cl_digcut(x.omb17,g_azi03) RETURNING x.omb17  #No.TQC-750093 t_azi -> g_azi
                            CALL cl_digcut(x.omb18,g_azi04) RETURNING x.omb18  #No.TQC-750093 t_azi -> g_azi
                            CALL cl_digcut(x.omb18t,g_azi04)RETURNING x.omb18t #No.TQC-750093 t_azi -> g_azi
                            UPDATE omb_file SET *=x.*
                             WHERE omb01=g_oma.oma01 AND omb03=x.omb03
                         END FOREACH
                         UPDATE omc_file SET omc06 = g_oma.oma24,
                                             omc07 = g_oma.oma24,
                                             omc09 = omc08 * g_oma.oma24,
                                             omc13 = omc09 - omc11   #MOD-970296 add
                          WHERE omc01 = g_oma.oma01
   
                        #-TQC-B60089-add-
                         LET g_ogb_o.* = g_ogb.*
                         LET g_sql = " SELECT * ",
                                     "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                                     "  WHERE ogb01 = '",x.omb31,"'",
                                     "    AND ogb03 = '",x.omb32,"'"
                         CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                         PREPARE sel_ogb_pre12 FROM g_sql
                         EXECUTE sel_ogb_pre12 INTO g_ogb.*
                        #-TQC-B60089-end-
                       #-------------------------------No.CHI-B90025----------------------------------start
                        IF g_oma.oma00='11' THEN
                           SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                            WHERE oeaa01 = g_oma.oma16
                              AND oeaa02 = '1'
                              AND oeaa03 = g_oma.oma165
                              AND oeaa01 = oea01
                       END IF
                       IF g_oma.oma00='13' THEN
                          SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                           WHERE oeaa01 = g_oma.oma16
                             AND oeaa02 = '2'
                             AND oeaa03 = g_oma.oma165
                             AND oeaa01 = oea01
                       END IF
                       CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                       #CALL t300_bu()
                      #-------------------------------No.CHI-B90025----------------------------------end
                         LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                      END IF
                   END IF     #No.TQC-7C0048
                END IF
                #No.TQC-770025 --end--
                LET g_oma_o.oma24 = g_oma.oma24   #MOD-B40025
             END IF
          END IF
          CALL t300_set_no_entry(p_cmd)
 
 
       AFTER FIELD oma24
          IF NOT cl_null(g_oma.oma24) THEN
            #IF p_cmd='u' AND g_oma.oma24 != g_oma_o.oma24 THEN   #MOD-6B0121 #MOD-B40025 mark
             IF g_oma.oma24 != g_oma_o.oma24 THEN                             #MOD-B40025 
                IF g_oma.oma65='2' THEN   #當為直接付款時,不可修改匯率
                   CALL cl_err('','axr-073',1)
                   LET g_oma.oma24 = g_oma_o.oma24
                   DISPLAY BY NAME g_oma.oma24
                   NEXT FIELD oma24
                END IF
                SELECT COUNT(*) INTO l_n FROM omb_file 
                 WHERE omb01 = g_oma.oma01
                IF l_n > 0 THEN
                   IF cl_confirm('axr-172') THEN
                      DECLARE t300_oma24_c CURSOR FOR
                         SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                      FOREACH t300_oma24_c INTO x.*
                         IF STATUS THEN EXIT FOREACH END IF
                         LET x.omb15 =x.omb13 *g_oma.oma24
                         LET x.omb16 =x.omb14 *g_oma.oma24
                         LET x.omb16t=x.omb14t*g_oma.oma24
                         CALL cl_digcut(x.omb15,g_azi03) RETURNING x.omb15  #No.TQC-750093 t_azi -> g_azi
                         CALL cl_digcut(x.omb16,g_azi04) RETURNING x.omb16  #No.TQC-750093 t_azi -> g_azi
                         CALL cl_digcut(x.omb16t,g_azi04)RETURNING x.omb16t #No.TQC-750093 t_azi -> g_azi
                         IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
                            LET x.omb37=x.omb16t
                         END IF
                         UPDATE omb_file SET *=x.*
                               WHERE omb01=g_oma.oma01 AND omb03=x.omb03
                      END FOREACH
                      UPDATE omc_file SET omc06 = g_oma.oma24,
                                          omc07 = g_oma.oma24,
                                          omc09 = omc08 * g_oma.oma24,
                                          omc13 = omc09 - omc11   #MOD-970296 add
                       WHERE omc01 = g_oma.oma01
 
                     #-TQC-B60089-add-
                      LET g_ogb_o.* = g_ogb.*
                      LET g_sql = " SELECT * ",
                                  "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                                  "  WHERE ogb01 = '",x.omb31,"'",
                                  "    AND ogb03 = '",x.omb32,"'"
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                      PREPARE sel_ogb_pre13 FROM g_sql
                      EXECUTE sel_ogb_pre13 INTO g_ogb.*
                     #-TQC-B60089-end-
                       #-------------------------------No.CHI-B90025----------------------------------start
                         IF g_oma.oma00='11' THEN
                            SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                             WHERE oeaa01 = g_oma.oma16
                               AND oeaa02 = '1'
                               AND oeaa03 = g_oma.oma165
                               AND oeaa01 = oea01
                        END IF
                        IF g_oma.oma00='13' THEN
                           SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                            WHERE oeaa01 = g_oma.oma16
                              AND oeaa02 = '2'
                              AND oeaa03 = g_oma.oma165
                              AND oeaa01 = oea01
                        END IF
                        CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                        #CALL t300_bu()
                      #-------------------------------No.CHI-B90025----------------------------------end
                      LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                   END IF
                END IF      #No.TQC-7C0048
                IF cl_null(g_oma.oma10) THEN
                   IF cl_confirm('axr-177') THEN
                      LET g_oma.oma58 = g_oma.oma24
                      LET g_oma.oma59 = g_oma.oma56    #MOD-B60021
                      LET g_oma.oma59x = g_oma.oma56x  #MOD-B60021
                      LET g_oma.oma59t = g_oma.oma56t  #MOD-B60021
                      DISPLAY BY NAME g_oma.oma58
                      DISPLAY BY NAME g_oma.oma59      #MOD-B60021
                      DISPLAY BY NAME g_oma.oma59x     #MOD-B60021
                      DISPLAY BY NAME g_oma.oma59t     #MOD-B60021
                   END IF 
                END IF 
             END IF
          END IF
          LET g_oma_o.oma24 = g_oma.oma24   #MOD-6B0121
 
 
       AFTER FIELD oma58
          IF NOT cl_null(g_oma.oma58) THEN
             IF p_cmd='u' AND g_oma.oma58 != g_oma_t.oma58 THEN   #TQC-6C0046
                IF cl_confirm('axr-175') THEN   #TQC-6C0046
                   DECLARE t300_oma58_c CURSOR FOR
                      SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                   FOREACH t300_oma58_c INTO x.*
                      IF STATUS THEN EXIT FOREACH END IF
                      LET x.omb17 =x.omb13 *g_oma.oma58
                      LET x.omb18 =x.omb14 *g_oma.oma58
                      LET x.omb18t=x.omb14t*g_oma.oma58
                      CALL cl_digcut(x.omb17,g_azi03) RETURNING x.omb17  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18,g_azi04) RETURNING x.omb18  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18t,g_azi04)RETURNING x.omb18t #No.TQC-750093 t_azi -> g_azi
                      UPDATE omb_file SET * = x.*
                       WHERE omb01=g_oma.oma01 AND omb03=x.omb03
                    END FOREACH
 
                   #-TQC-B60089-add-
                    LET g_ogb_o.* = g_ogb.*
                    LET g_sql = " SELECT * ",
                                "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                                "  WHERE ogb01 = '",x.omb31,"'",
                                "    AND ogb03 = '",x.omb32,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                    PREPARE sel_ogb_pre14 FROM g_sql
                    EXECUTE sel_ogb_pre14 INTO g_ogb.*
                   #-TQC-B60089-end-
                     #-------------------------------No.CHI-B90025----------------------------------start
                      IF g_oma.oma00='11' THEN
                         SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                          WHERE oeaa01 = g_oma.oma16
                            AND oeaa02 = '1'
                            AND oeaa03 = g_oma.oma165
                            AND oeaa01 = oea01
                      END IF
                      IF g_oma.oma00='13' THEN
                         SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                          WHERE oeaa01 = g_oma.oma16
                            AND oeaa02 = '2'
                            AND oeaa03 = g_oma.oma165
                            AND oeaa01 = oea01
                      END IF
                      CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                      #CALL t300_bu()
                     #-------------------------------No.CHI-B90025----------------------------------end
                    LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                END IF
             END IF
          END IF
          LET g_oma_o.oma58 = g_oma.oma58   #TQC-6C0046
 
 
        AFTER FIELD oma21
           IF NOT cl_null(g_oma.oma21) THEN
              SELECT gec04,gec05,gec07,gec08,gec06
                INTO g_oma.oma211,g_oma.oma212,g_oma.oma213,g_oma.oma171,
                    g_oma.oma172
               FROM gec_file WHERE gec01=g_oma.oma21
                               AND gec011='2'  #銷項
              IF STATUS THEN
                 CALL cl_err3("sel","gec_file",g_oma.oma21,"",STATUS,"","select gec",1)  #No.FUN-660116
                 NEXT FIELD oma21
              END IF
              DISPLAY BY NAME g_oma.oma211, g_oma.oma212, g_oma.oma213
             IF p_cmd='u' AND g_oma.oma21 != g_oma_o.oma21 THEN #MOD-970074  
                IF cl_confirm('axr-173') THEN
                   DECLARE t300_oma21_c CURSOR FOR
                      SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                   FOREACH t300_oma21_c INTO x.*
                      IF STATUS THEN EXIT FOREACH END IF
                      IF g_oma.oma213 = 'N' THEN
                         LET x.omb14 =x.omb12*x.omb13
                         CALL cl_digcut(x.omb14,t_azi04)  RETURNING x.omb14    #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                         LET x.omb14t=x.omb14*(1+g_oma.oma211/100)
                         CALL cl_digcut(x.omb14t,t_azi04) RETURNING x.omb14t   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                      ELSE
                         LET x.omb14t=x.omb12*x.omb13
                         CALL cl_digcut(x.omb14t,t_azi04) RETURNING x.omb14t   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                         LET x.omb14 =x.omb14t/(1+g_oma.oma211/100)
                         CALL cl_digcut(x.omb14,t_azi04)  RETURNING x.omb14    #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                      END IF
                      CALL cl_digcut(x.omb13,t_azi03)  RETURNING x.omb13    #No.TQC-750093 g_azi -> t_azi
                      LET x.omb15 =x.omb13 *g_oma.oma24
                      LET x.omb16 =x.omb14 *g_oma.oma24
                      LET x.omb16t=x.omb14t*g_oma.oma24
                      LET x.omb17 =x.omb13 *g_oma.oma58
                      LET x.omb18 =x.omb14 *g_oma.oma58
                      LET x.omb18t=x.omb14t*g_oma.oma58
                      CALL cl_digcut(x.omb15,g_azi03) RETURNING x.omb15  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb16,g_azi04) RETURNING x.omb16  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb16t,g_azi04)RETURNING x.omb16t #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb17,g_azi03) RETURNING x.omb17  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18,g_azi04) RETURNING x.omb18  #No.TQC-750093 t_azi -> g_azi
                      CALL cl_digcut(x.omb18t,g_azi04)RETURNING x.omb18t #No.TQC-750093 t_azi -> g_azi
                      UPDATE omb_file SET *=x.*
                       WHERE omb01=g_oma.oma01 AND omb03 = x.omb03
                      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                         CALL cl_err3("upd","omb_file",g_oma.oma01,x.omb03,SQLCA.SQLCODE,"","update omb",1)  #No.FUN-660116
                      END IF
                   END FOREACH
 
                  #-TQC-B60089-add-
                   LET g_ogb_o.* = g_ogb.*
                   LET g_sql = " SELECT * ",
                               "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                               "  WHERE ogb01 = '",x.omb31,"'",
                               "    AND ogb03 = '",x.omb32,"'"
                   CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                   PREPARE sel_ogb_pre15 FROM g_sql
                   EXECUTE sel_ogb_pre15 INTO g_ogb.*
                  #-TQC-B60089-end-
                   #-------------------------------No.CHI-B90025----------------------------------start
                    IF g_oma.oma00='11' THEN
                       SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                        WHERE oeaa01 = g_oma.oma16
                          AND oeaa02 = '1'
                          AND oeaa03 = g_oma.oma165
                          AND oeaa01 = oea01
                    END IF
                    IF g_oma.oma00='13' THEN
                       SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                        WHERE oeaa01 = g_oma.oma16
                          AND oeaa02 = '2'
                          AND oeaa03 = g_oma.oma165
                          AND oeaa01 = oea01
                    END IF
                    CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                   #CALL t300_bu()
                   #-------------------------------No.CHI-B90025----------------------------------end
                   LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                END IF
             END IF
          END IF
          LET g_oma_o.oma21=g_oma.oma21 #MOD-970074    
       AFTER FIELD oma18
          IF g_oma.oma00 MATCHES "1*" AND cl_null(g_oma.oma18) THEN
             NEXT FIELD oma18
          END IF
          LET l_aag05=''  #FUN-8C0089 add
          IF NOT cl_null(g_oma.oma18) THEN
             SELECT aag02,aag05 INTO l_aag02,l_aag05  #FUN-8C0089 add aag05,l_aag05 #TQC-790124
               FROM aag_file
              WHERE aag01=g_oma.oma18
                AND aag00=g_bookno1  #No.FUN-730073 
                AND aag07 IN ('2','3')   #MOD-920035 add
                AND aag03 IN ('2')       #TQC-B10053 add
             IF STATUS THEN
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oma.oma18,"",STATUS,"","select aag",1)  #No.FUN-660116
                CALL cl_err3("sel","aag_file",g_oma.oma18,"",STATUS,"","select aag",0)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_aag"
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 = g_oma.oma18
                LET g_qryparam.arg1=g_bookno1
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2') AND aagacti = 'Y' AND aag01 LIKE '",g_oma.oma18 CLIPPED,"%'"             
                CALL cl_create_qry() RETURNING g_oma.oma18
                DISPLAY BY NAME g_oma.oma18
                #No.FUN-B10053  --End       
                NEXT FIELD oma18
             END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 ='Y' THEN
                   IF NOT cl_null(g_oma.oma930) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma930,g_bookno1)  
                                    RETURNING g_errno
                   END IF
                ELSE
                   IF NOT cl_null(g_oma.oma15) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma15,g_bookno1)  
                                    RETURNING g_errno
                   END IF 
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oma18
                END IF
             END IF
 
             DISPLAY l_aag02 TO aag02   #TQC-790124
          END IF
       AFTER FIELD oma181
          IF g_oma.oma00 MATCHES "1*" AND cl_null(g_oma.oma181) THEN
             NEXT FIELD oma181
          END IF
          LET l_aag05a=''       #FUN-8C0089 add
          IF NOT cl_null(g_oma.oma181) THEN
             SELECT aag02,aag05 INTO l_aag02a,l_aag05a   #FUN-8C0089 add aag05,l_aag05a  #TQC-790124
               FROM aag_file
              WHERE aag01=g_oma.oma181
                AND aag00=g_bookno2   #No.FUN-730073
                AND aag07 IN ('2','3')   #MOD-920035 add
                AND aag03 IN ('2')       #TQC-B10053 add
             IF STATUS THEN
                #No.FUN-B10053  --Begin
                #CALL cl_err3("sel","aag_file",g_oma.oma181,"",STATUS,"","select aag",1)  #No.FUN-660116
                CALL cl_err3("sel","aag_file",g_oma.oma181,"",STATUS,"","select aag",0)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_aag"
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 = g_oma.oma181
                LET g_qryparam.arg1 = g_bookno2
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2') AND aagacti = 'Y' AND aag01 LIKE '",g_oma.oma181 CLIPPED,"%'"
                CALL cl_create_qry() RETURNING g_oma.oma181
                DISPLAY BY NAME g_oma.oma181
                #No.FUN-B10053  --End
                NEXT FIELD oma181
             END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05a = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 ='Y' THEN
                   IF NOT cl_null(g_oma.oma930) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma930,g_bookno2)  
                                    RETURNING g_errno
                   END IF
                ELSE
                   IF NOT cl_null(g_oma.oma15) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma15,g_bookno2)  
                                    RETURNING g_errno
                   END IF 
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oma181
                END IF
             END IF
 
             DISPLAY l_aag02a TO aag02_2   #TQC-790124
          END IF
 
       AFTER FIELD oma25
          IF NOT cl_null(g_oma.oma25) THEN
             LET g_cnt=0
             #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oab_file",
             LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                         "  WHERE oab01='",g_oma.oma25,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
             PREPARE sel_oab_pre62 FROM g_sql
             EXECUTE sel_oab_pre62 INTO g_cnt
             IF STATUS THEN
                CALL cl_err3("sel","oab_file",g_oma.oma25,"",STATUS,"","select oab",1)  #No.FUN-660116
                NEXT FIELD oma25 
             END IF
          END IF
       AFTER FIELD oma26
          IF NOT cl_null(g_oma.oma26) THEN
             LET g_cnt=0
             #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oab_file",
             LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                         "  WHERE oab01='",g_oma.oma26,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
             PREPARE sel_oab_pre63 FROM g_sql
             EXECUTE sel_oab_pre63 INTO g_cnt
             IF STATUS THEN
                CALL cl_err3("sel","oab_file",g_oma.oma26,"",STATUS,"","select oab",1)  #No.FUN-660116
                NEXT FIELD oma26
             END IF
          END IF
      AFTER FIELD oma40
          IF g_oma.oma40 NOT MATCHES '[YN]' THEN
             CALL cl_err('',9061,0)
             NEXT FIELD oma40
          END IF
 
       AFTER FIELD oma63        #bugno:7258
          IF NOT cl_null(g_oma.oma63) AND g_aza.aza08='Y' THEN
             #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"pja_file",
             LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'pja_file'), #FUN-A50102
                         "  WHERE pja01='",g_oma.oma63,"'",
                         "    AND pjaclose = 'N'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             PREPARE sel_pja_pre64 FROM g_sql
             EXECUTE sel_pja_pre64
             IF STATUS THEN
                CALL cl_err3("sel","pja_file",g_oma.oma63,"","apj-005","","sel_pja",1)  #No.FUN-660116
                NEXT FIELD oma63
             END IF
          END IF
          
      AFTER FIELD oma930 
         IF NOT s_costcenter_chk(g_oma.oma930) THEN
            LET g_oma.oma930=NULL
            DISPLAY BY NAME g_oma.oma930
            DISPLAY NULL TO FORMONLY.gem02a
            NEXT FIELD oma930
         ELSE
            DISPLAY s_costcenter_desc(g_oma.oma930) TO FORMONLY.gem02a
         END IF
        #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
         LET l_aag05=''   
         SELECT aag05 INTO l_aag05 FROM aag_file
          WHERE aag01 = g_oma.oma18
            AND aag00 = g_bookno1      
         
         LET g_errno = ' '   
         IF l_aag05 = 'Y' AND NOT cl_null(g_oma.oma18) THEN
           #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
            IF g_aaz.aaz90 ='Y' THEN
               CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma930,g_bookno1)  
                             RETURNING g_errno
            END IF
            IF NOT cl_null(g_errno) THEN
               CALL cl_err('',g_errno,0)
               NEXT FIELD oma930
            END IF
         END IF
 
        #會科二
         IF g_aza.aza63='Y' THEN
            LET l_aag05a=''   
            SELECT aag05 INTO l_aag05a FROM aag_file
             WHERE aag01 = g_oma.oma181
               AND aag00 = g_bookno2      
            
            LET g_errno = ' '   
            IF l_aag05a = 'Y' AND NOT cl_null(g_oma.oma181) THEN
               IF g_aaz.aaz90 ='Y' THEN
                  CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma930,g_bookno2)                
                                RETURNING g_errno
               END IF
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD oma930
               END IF
            END IF
         END IF
 
  
        AFTER FIELD omaud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD omaud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
       AFTER INPUT   #97/05/22 modify
          IF INT_FLAG THEN EXIT INPUT END IF
          IF cl_null(g_oma.oma13) THEN      #No:7682
             DISPLAY BY NAME g_oma.oma13
             NEXT FIELD oma13
          END IF
          CALL t300_chk_oma66()                         #No.FUN-9C0014 Add
          IF g_errno = 'N' THEN NEXT FIELD oma66 END IF #No.FUN-9C0014 Add
           
 
       ON ACTION CONTROLP
            CASE
               WHEN INFIELD(oma01)
                    CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1           #No.FUN-550071
                    CALL cl_init_qry_var()
                    CALL q_ooy( FALSE, TRUE, g_t1,g_oma.oma00,'AXR') RETURNING g_t1    #TQC-670008
                     LET g_oma.oma01=g_t1                              #No.FUN-550071
                     DISPLAY BY NAME g_oma.oma01
                     NEXT FIELD oma01
               WHEN INFIELD(oma03)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_occ"
                    LET g_qryparam.default1 = g_oma.oma03
                    CALL cl_create_qry() RETURNING g_oma.oma03
                    DISPLAY BY NAME g_oma.oma03
                    NEXT FIELD oma03
               WHEN INFIELD(oma04)
                    CALL cl_init_qry_var()
                    IF g_aza.aza50 = 'Y' THEN   #No.TQC-760015
                       LET g_qryparam.form = "q_occ12"
                    ELSE
                       LET g_qryparam.form = "q_occ13"
                    END IF
                    LET g_qryparam.default1 = g_oma.oma04
                    CALL cl_create_qry() RETURNING g_oma.oma04
                    DISPLAY BY NAME g_oma.oma04
                    NEXT FIELD oma04
               WHEN INFIELD(oma32)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_oag"
                    LET g_qryparam.default1 = g_oma.oma32
                    CALL cl_create_qry() RETURNING g_oma.oma32
                    DISPLAY BY NAME g_oma.oma32
                    NEXT FIELD oma32
               WHEN INFIELD(oma68)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_occ11"
                    LET g_qryparam.default1 = g_oma.oma68
                    CALL cl_create_qry() RETURNING g_oma.oma68
                    DISPLAY BY NAME g_oma.oma68
                    NEXT FIELD oma68
               WHEN INFIELD(oma13)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_ool"
                    LET g_qryparam.default1 = g_oma.oma13
                    CALL cl_create_qry() RETURNING g_oma.oma13
                    DISPLAY BY NAME g_oma.oma13
                    NEXT FIELD oma13
               WHEN INFIELD(oma14)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_oma.oma14
                    CALL cl_create_qry() RETURNING g_oma.oma14
                    DISPLAY BY NAME g_oma.oma14
                    NEXT FIELD oma14
               WHEN INFIELD(oma15)
                    CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_gem1"   #No.MOD-530272
                    LET g_qryparam.default1 = g_oma.oma15
                    CALL cl_create_qry() RETURNING g_oma.oma15
                    DISPLAY BY NAME g_oma.oma15
                    NEXT FIELD oma15
               WHEN INFIELD(oma18)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_aag"
                    LET g_qryparam.default1 = g_oma.oma18
                    LET g_qryparam.where = " aag07 IN ('2','3') AND ",
                                           " aag03 IN ('2') "
                    LET g_qryparam.arg1=g_bookno1                  #No.FUN-730073
                    CALL cl_create_qry() RETURNING g_oma.oma18
                    DISPLAY BY NAME g_oma.oma18
                    NEXT FIELD oma18
               WHEN INFIELD(oma181)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_aag"
                    LET g_qryparam.default1 = g_oma.oma181
                    LET g_qryparam.where = " aag07 IN ('2','3') AND ",
                                           " aag03 IN ('2') "
                    LET g_qryparam.arg1 = g_bookno2                      #No.FUN-730073
                    CALL cl_create_qry() RETURNING g_oma.oma181
                    DISPLAY BY NAME g_oma.oma181
                    NEXT FIELD oma181
               WHEN INFIELD(oma21)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gec"
                    LET g_qryparam.default1 = g_oma.oma21
                    LET g_qryparam.arg1 = '2'
                    CALL cl_create_qry() RETURNING g_oma.oma21
                    DISPLAY BY NAME g_oma.oma21
                    NEXT FIELD oma21
               WHEN INFIELD(oma23)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_oma.oma23
                    CALL cl_create_qry() RETURNING g_oma.oma23
                    DISPLAY BY NAME g_oma.oma23
                    NEXT FIELD oma23
               WHEN INFIELD(oma25)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_oab"
                    LET g_qryparam.default1 = g_oma.oma25
                    CALL cl_create_qry() RETURNING g_oma.oma25
                    DISPLAY BY NAME g_oma.oma25
                    NEXT FIELD oma25
               WHEN INFIELD(oma26)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_oab"
                    LET g_qryparam.default1 = g_oma.oma25
                    CALL cl_create_qry() RETURNING g_oma.oma26
                    DISPLAY BY NAME g_oma.oma26
                    NEXT FIELD oma26
               WHEN INFIELD(oma63)         #bugno:7258
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_pja"
                    LET g_qryparam.default1 = g_oma.oma63
                    CALL cl_create_qry() RETURNING g_oma.oma63
                    DISPLAY BY NAME g_oma.oma63
                    NEXT FIELD oma63
 
              WHEN INFIELD(oma24)
                 CALL s_rate(g_oma.oma23,g_oma.oma24)
                 RETURNING g_oma.oma24
                 DISPLAY BY NAME g_oma.oma24
                 NEXT FIELD oma24
              WHEN INFIELD(oma58)
                 CALL s_rate(g_oma.oma23,g_oma.oma58)
                 RETURNING g_oma.oma58
                 DISPLAY BY NAME g_oma.oma58
                 NEXT FIELD oma58
               WHEN INFIELD(oma66)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azw"
                    LET g_qryparam.where = "azw02 = '",g_legal,"' "
                    CALL cl_create_qry() RETURNING g_oma.oma66
                    DISPLAY BY NAME g_oma.oma66
                    NEXT FIELD oma66
              WHEN INFIELD(oma930)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_gem4"
                 CALL cl_create_qry() RETURNING g_oma.oma930
                 DISPLAY BY NAME g_oma.oma930
                 NEXT FIELD oma930
            END CASE
 
        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG CALL cl_cmdask()
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
    END INPUT
END FUNCTION

FUNCTION t300_chk_oma66()
 DEFINE l_occ06       LIKE occ_file.occ06
 DEFINE l_occ18       LIKE occ_file.occ18
 DEFINE l_occacti     LIKE occ_file.occacti
 DEFINE l_cnt         LIKE type_file.num5

  #check oma66下資料的正確性
   LET g_errno = 'Y'
   IF NOT cl_null(g_oma.oma03) THEN
      #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"occ_file",
      #No.MOD-AC0395  --Begin
      #LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
      LET g_sql = " SELECT occacti FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
      #No.MOD-AC0395  --End  
                  "  WHERE occ01='",g_oma.oma03,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
      PREPARE sel_occ_pre86 FROM g_sql
      EXECUTE sel_occ_pre86 INTO l_occacti
      IF STATUS THEN
         CALL cl_err3("sel","occ_file",g_oma.oma03,"",STATUS,"","select occ",1)
         LET g_errno = 'N'
      END IF
      #無效客戶不可立帳
      IF l_occacti = 'N' THEN
         CALL cl_err(g_oma.oma03,'9028',0)
         LET g_errno = 'N'
      END IF
   END IF

  #chenck oma32 -----
   IF NOT cl_null(g_oma.oma32) THEN
      #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oag_file",
      LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oag_file'), #FUN-A50102
                  "  WHERE oag01 = '",g_oma.oma32,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
      PREPARE sel_oag_pre87 FROM g_sql
      EXECUTE sel_oag_pre87 INTO l_cnt
      IF l_cnt = 0 THEN
         CALL cl_err('','axr-955',0)
         LET g_errno = 'N'
      END IF
   END IF

  #check oma67 -----
   IF NOT cl_null(g_oma.oma67) THEN 
      LET l_cnt = 0  
      #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"ofa_file",
      LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'ofa_file'), #FUN-A50102
                  "  WHERE ofa01 = '",g_oma.oma67,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
      PREPARE sel_ofa_pre88 FROM g_sql
      EXECUTE sel_ofa_pre88 INTO l_cnt
      IF l_cnt = 0 THEN
         CALL cl_err(g_oma.oma67,'axr-252',1)
         LET g_errno = 'N'
      END IF       
   END IF

  #check oma25,oma26 -----
   IF NOT cl_null(g_oma.oma25) THEN
      LET g_cnt=0
      #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oab_file",
      LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                  "  WHERE oab01='",g_oma.oma25,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
      PREPARE sel_oab_pre89 FROM g_sql
      EXECUTE sel_oab_pre89 INTO g_cnt
      IF STATUS THEN
         CALL cl_err3("sel","oab_file",g_oma.oma25,"",STATUS,"","select oab",1)
         LET g_errno = 'N'
      END IF
   END IF 
   IF NOT cl_null(g_oma.oma26) THEN
      LET g_cnt=0
      #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oab_file",
      LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                  "  WHERE oab01='",g_oma.oma26,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
      PREPARE sel_oab_pre90 FROM g_sql
      EXECUTE sel_oab_pre90 INTO g_cnt
      IF STATUS THEN
         CALL cl_err3("sel","oab_file",g_oma.oma26,"",STATUS,"","select oab",1)
         LET g_errno = 'N'
      END IF
   END IF

  #check oma63 -----
   IF NOT cl_null(g_oma.oma63) AND g_aza.aza08='Y' THEN
      #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"pja_file",
      LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'pja_file'), #FUN-A50102
                  "  WHERE pja01='",g_oma.oma63,"'",
                  "    AND pjaclose = 'N'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
      PREPARE sel_pja_pre91 FROM g_sql
      EXECUTE sel_pja_pre91
      IF STATUS THEN
         CALL cl_err3("sel","pja_file",g_oma.oma63,"","apj-005","","sel_pja",1)
         LET g_errno = 'N'
      END IF
   END IF

  #check oma04 -----
   IF NOT cl_null(g_oma.oma04) THEN
      IF cl_null(g_oma.oma10) THEN
         IF g_aza.aza50 = 'N' THEN
            LET g_sql = " SELECT occ18,occ06",
                        #"   FROM ",li_dbs CLIPPED,"occ_file",
                        "   FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        "  WHERE occ01 = '",g_oma.oma04,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
            PREPARE sel_occ_pre92 FROM g_sql
            EXECUTE sel_occ_pre92 INTO l_occ18,l_occ06
         ELSE
            LET g_sql = " SELECT occ18,occ06",
                        #"   FROM ",li_dbs CLIPPED,"occ_file",
                        "   FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        "  WHERE occ01 = '",g_oma.oma04,"'",
                        "    AND occ1004 = '1'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
            PREPARE sel_occ_pre93 FROM g_sql
            EXECUTE sel_occ_pre93 INTO l_occ18,l_occ06
         END IF
         IF cl_null(l_occ06) THEN
            CALL cl_err(g_oma.oma04,'anm-045',1)
            LET g_errno = 'N'
         ELSE
            IF l_occ06 <> '1' AND l_occ06 <> '4' THEN
               CALL cl_err(l_occ06,'axr-954',1)
               LET g_errno = 'N'
            END IF
         END IF
         DISPLAY l_occ18 TO FORMONLY.occ18
      ELSE
         SELECT ome043 INTO l_occ18
           FROM ome_file
          WHERE ome01 = g_oma.oma10
         DISPLAY l_occ18 TO FORMONLY.occ18
      END IF
   END IF

END FUNCTION
 
FUNCTION t300_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)

   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("oma00,oma01",TRUE)
   END IF

   IF p_cmd = 'a' AND ( NOT g_before_input_done ) AND g_aza.aza52='Y' THEN
      CALL cl_set_comp_entry("oma66",TRUE)  #FUN-630043
   END IF

   IF INFIELD(oma00) OR ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("oma09,oma10",TRUE)
   END IF

   IF INFIELD(oma03) OR ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("oma032",TRUE)
      DISPLAY "oma032 OPEN"
   END IF

   IF INFIELD(oma23) OR ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("oma24,oma58",TRUE)
   END IF

   CALL cl_set_comp_entry("oma54x,oma56x,oma59x",TRUE)     #MOD-5B0006

   CALL cl_set_comp_entry("oma67",TRUE)   #FUN-820072

   CALL cl_set_comp_entry("oma165",TRUE)     #No:FUN-A50103
 
END FUNCTION
 
FUNCTION t300_set_entry_1()
      CALL cl_set_comp_entry("oma00,oma01,oma03,oma08,oma02,
                              oma032,oma68,oma69,
                              oma32,oma11,oma12,oma58,
                              oma23,oma54x,oma24,oma56x,oma59x,
                              oma14,oma15,oma930,oma16,oma165,     #No:FUN-A50103
                              oma66,oma67,oma25,oma26,oma63,
                              oma09,oma05,oma10,oma04,oma21",TRUE)
END FUNCTION
 
FUNCTION t300_set_no_entry_1()
  IF g_oma.oma64 matches '[Ss]' THEN
      CALL cl_set_comp_entry("oma00,oma01,oma03,oma08,oma02,
                              oma032,oma68,oma69,
                              oma32,oma11,oma12,oma58,
                              oma23,oma54x,oma24,oma56x,oma59x,
                              oma14,oma15,oma930,oma16,oma165,     #No:FUN-A50103
                              oma67,oma25,oma26,oma63,   #MOD-9B0043 del oma66
                              oma09,oma05,oma10,oma04,oma21",FALSE)
  END IF
END FUNCTION
 
FUNCTION t300_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
  DEFINE l_cnt   LIKE type_file.num5      #No.FUN-680123 SMALLINT   #No.TQC-5B0175
 
    IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
       CALL cl_set_comp_entry("oma00,oma01",FALSE)
    END IF

    IF INFIELD(oma00) OR (NOT g_before_input_done) THEN
       CALL cl_set_comp_entry("oma09,oma10",FALSE)
    END IF

    IF INFIELD(oma03) OR (NOT g_before_input_done) THEN
       IF g_oma.oma03[1,4] != 'MISC' THEN  #MOD-9C0084
          CALL cl_set_comp_entry("oma032",FALSE)
          DISPLAY "oma032 CLOSE"
       END IF
    END IF

    IF INFIELD(oma23) OR (NOT g_before_input_done) THEN
       IF g_oma.oma23 = g_aza.aza17 THEN
          LET g_oma.oma24 = 1 DISPLAY BY NAME g_oma.oma24
          LET g_oma.oma58 = 1 DISPLAY BY NAME g_oma.oma58
          CALL cl_set_comp_entry("oma24,oma58",FALSE)
       END IF
    END IF

    CALL cl_set_comp_entry("oma54x,oma56x,oma59x",FALSE)   #MOD-5B0006

    IF g_oma.oma00<>'14' THEN
       CALL cl_set_comp_entry("oma67",FALSE)
    END IF
 
    #-----No:FUN-A50103-----
    IF g_oma.oma00<>'11' AND g_oma.oma00<>'13' THEN
       CALL cl_set_comp_entry("oma165",FALSE)
    END IF
    #-----No:FUN-A50103 END-----
 
END FUNCTION
 
FUNCTION t300_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_oma.* TO NULL                   #NO.FUN-6B0042 
    CALL cl_msg("")                              #FUN-640246
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL t300_cs()
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_oma.* TO NULL 
       RETURN 
    END IF
    CALL cl_msg(" SEARCHING ! ")                              #FUN-640246
    OPEN t300_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_oma.* TO NULL
    ELSE
        OPEN t300_count
        FETCH t300_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL t300_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
END FUNCTION
 
FUNCTION t300_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),               #處理方式
    l_abso          LIKE type_file.num10      #No.FUN-680123 INTEGER                #絕對的筆數
 
    CALL cl_msg("")                              #FUN-640246
 
    CASE p_flag
        WHEN 'N' FETCH NEXT     t300_cs INTO g_oma.oma01
        WHEN 'P' FETCH PREVIOUS t300_cs INTO g_oma.oma01
        WHEN 'F' FETCH FIRST    t300_cs INTO g_oma.oma01
        WHEN 'L' FETCH LAST     t300_cs INTO g_oma.oma01
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
            FETCH ABSOLUTE g_jump t300_cs INTO g_oma.oma01
            LET mi_no_ask = FALSE
    END CASE
 
    IF SQLCA.sqlcode THEN
         CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0) #MOD-4A0109
         INITIALIZE g_oma.* TO NULL  #TQC-6B0105
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
    CALL s_get_bookno(year(g_oma.oma02)) RETURNING g_flag1,g_bookno1,g_bookno2
    IF  g_flag1='1' THEN #抓不到帳別
       CALL cl_err(g_oma.oma02,'aoo-081',1)
    END IF
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
       INITIALIZE g_oma.* TO NULL
       RETURN
    ELSE
       LET g_data_owner = g_oma.omauser     #No.FUN-4C0049
       LET g_data_group = g_oma.omagrup     #No.FUN-4C0049
       CALL t300_show()
    END IF
END FUNCTION
 
FUNCTION t300_oma15(p_cmd)  #部門名稱
   DEFINE p_cmd     LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
   DEFINE l_gem02   LIKE gem_file.gem02
 
   LET g_errno = ' '
   LET l_gem02 = ' '
   SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01 = g_oma.oma15
   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'aap-039'   #No.TQC-930154
                                  LET l_gem02 = NULL
        OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
 
   IF cl_null(g_errno) OR p_cmd = 'd' THEN
      DISPLAY l_gem02 TO FORMONLY.gem02
   END IF
 
END FUNCTION
 
FUNCTION t300_oma14(p_cmd)  #員工姓名
    DEFINE p_cmd     LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
    DEFINE l_gen02   LIKE gen_file.gen02
 
    LET g_errno = ' '
    LET l_gen02 = ' '
    SELECT gen02 INTO l_gen02 FROM gen_file WHERE gen01 = g_oma.oma14
    CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'mfg1312' #MOD-940153 modify mfg-1312 -> mfg1312
                                   LET l_gen02 = NULL
         OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
 
    IF cl_null(g_errno) OR p_cmd = 'd' THEN
       DISPLAY l_gen02 TO FORMONLY.gen02
    END IF
END FUNCTION
 
FUNCTION t300_show()
    DEFINE l_ool02 LIKE ool_file.ool02    #FUN-670047
    DEFINE l_occ18 LIKE occ_file.occ18    #MOD-970130                 
    DEFINE l_azp02 LIKE azp_file.azp02    #FUN-960140
    SELECT oma51f,oma55,oma57 INTO g_oma.oma51f,g_oma.oma55,g_oma.oma57
      FROM oma_file
     WHERE oma01 = g_oma.oma01
    SELECT oma65 INTO g_oma.oma65 FROM oma_file
     WHERE oma01 = g_oma.oma01
    LET g_oma_t.* = g_oma.*                #保存單頭舊值
    CALL t300_show0()
    DISPLAY BY NAME
 
           g_oma.oma00,g_oma.oma01,g_oma.oma08,g_oma.oma02,  
           g_oma.oma33,g_oma.oma03,g_oma.oma032,g_oma.oma68,g_oma.oma69,   #,g_oma.omaplant,#No.FUN-680022 add oma68,oma69  #FUN-960140 add omaplant  #FUN-960140 090824 del omaplant
           g_oma.omaconf,g_oma.omavoid,g_oma.omamksg,g_oma.oma64,g_oma.oma70,   #No.FUN-540040  #FUN-960140 add oma70
           g_oma.oma32,g_oma.oma11,g_oma.oma12,g_oma.oma13,g_oma.oma18,g_oma.oma181,g_oma.oma65, #No.FUN-570099 #FUN-670047
           g_oma.oma23,g_oma.oma52,g_oma.oma54,g_oma.oma54x,g_oma.oma54t,g_oma.oma55,
           g_oma.oma24,g_oma.oma53,g_oma.oma56,g_oma.oma56x,g_oma.oma56t,g_oma.oma57,
           g_oma.oma15,g_oma.oma14,g_oma.oma930,g_oma.oma16,g_oma.oma165,g_oma.oma19,g_oma.oma99 , #No.8161 add oma99  #FUN-630043 #FUN-640191 add oma67 #FUN-680001     #No:FUN-A50103
           g_oma.oma992,g_oma.oma66,g_oma.oma67,g_oma.oma25,g_oma.oma26,g_oma.oma63,g_oma.oma40 ,g_oma.omaprsw,         #No.FUN-690090 add oma992
           g_oma.oma09,g_oma.oma05,g_oma.oma10,g_oma.oma04,g_oma.oma71, #No.TQC-740309 add oma04 #FUN-970108 add oma71
           g_oma.oma21,g_oma.oma211,g_oma.oma212,g_oma.oma213,
           g_oma.oma58,g_oma.oma59 ,g_oma.oma59x,g_oma.oma59t  ,
           g_oma.omauser,g_oma.omagrup,g_oma.omamodu,g_oma.omadate,
           g_oma.omaud01,g_oma.omaud02,g_oma.omaud03,g_oma.omaud04,
           g_oma.omaud05,g_oma.omaud06,g_oma.omaud07,g_oma.omaud08,
           g_oma.omaud09,g_oma.omaud10,g_oma.omaud11,g_oma.omaud12,
           g_oma.omaud13,g_oma.omaud14,g_oma.omaud15,g_oma.oma73,g_oma.oma73f,g_oma.oma74        #No.FUN-AB0034 add oma73,oma73f,oma74 
    SELECT ool02 INTO l_ool02 FROM ool_file
     WHERE ool01 = g_oma.oma13
    DISPLAY l_ool02 TO FORMONLY.ool02
    IF cl_null(g_oma.oma10) THEN               #MOD-970130                                                                          
       SELECT occ18 INTO l_occ18 FROM occ_file #MOD-970130   
        WHERE occ01 = g_oma.oma04
    ELSE                                                                                                                            
       SELECT ome043 INTO l_occ18 FROM ome_file                                                                                     
        WHERE ome01=g_oma.oma10                                                                                                     
    END IF                                                                                                                          
    DISPLAY l_occ18 TO FORMONLY.occ18                                                                                               
  IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
 
    CALL t300_show2()
    CALL t300_show_amt()
    IF g_oma.oma00='21' THEN
       CALL t300_oma34()
    END IF
    CALL t300_oma15('d')
    CALL t300_oma14('d')
    IF NOT cl_null(g_oma.oma66) THEN
       CALL t300_oma66('d')
    END IF 
    CALL t300_show_rec_amt()  #FUN-570099
    CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1           #No.FUN-550071
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    DISPLAY s_costcenter_desc(g_oma.oma930) TO FORMONLY.gem02a #FUN-680001
    CALL t300_b_fill(g_wc2)
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
    SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05
      FROM azi_file
     WHERE azi01 = g_oma.oma23
 
    CALL cl_set_act_visible("entry_sheet,entry_sheet2,
                             T_T_entry_sheet,T_T_entry_sheet2",TRUE)
    IF cl_null(g_oma.oma99) THEN
       CALL cl_set_act_visible("T_T_entry_sheet,T_T_entry_sheet2",FALSE)
       IF g_aza.aza63 = 'N' THEN
          CALL cl_set_act_visible("entry_sheet2",FALSE)  
       END IF
    ELSE
       CALL cl_set_act_visible("entry_sheet,entry_sheet2",FALSE)
       IF g_aza.aza63 = 'N' THEN
          CALL cl_set_act_visible("T_T_entry_sheet2",FALSE)  
       END IF
    END IF  
 
END FUNCTION
 
FUNCTION t300_oma34()
 
   CASE WHEN g_oma.oma34='1' CALL cl_getmsg('axd-074',g_lang) RETURNING g_msg
        WHEN g_oma.oma34='4' CALL cl_getmsg('axd-077',g_lang) RETURNING g_msg
        WHEN g_oma.oma34='5' CALL cl_getmsg('axd-078',g_lang) RETURNING g_msg
   END CASE
   CALL cl_msg(g_msg)                              #FUN-640246
 
END FUNCTION
#新的t300_show0
FUNCTION t300_show0()
   DEFINE   ls_msg  LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(50)
 
   IF g_lang='1' THEN RETURN END IF
   CASE g_oma.oma00
      WHEN '11'
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-500' AND ze02 = g_lang
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-AB0034
      WHEN '12'
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-501' AND ze02 = g_lang     #No.FUN-670026 
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         #CALL cl_set_comp_visible("oma74",TRUE)   #No.FUN-AB0034    #FUN-B10058
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-B10058
      WHEN '13'
        #SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-501' AND ze02 = g_lang     #No.FUN-670026   #CHI-A50040 mark 
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-500' AND ze02 = g_lang                      #CHI-A50040
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-AB0034
      WHEN '14'
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-502' AND ze02 = g_lang
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-AB0034
      WHEN '31'
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-502' AND ze02 = g_lang
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-AB0034
      WHEN '21'
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-503' AND ze02 = g_lang
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
         #CALL cl_set_comp_visible("oma74",TRUE)   #No.FUN-AB0034   #FUN-B10058
         CALL cl_set_comp_visible("oma74",FALSE)   #No.FUN-B10058
      #FUN-B10058--add--str--
      WHEN '19'
         CALL cl_set_comp_visible("oma74",TRUE) 
      WHEN '28'
         CALL cl_set_comp_visible("oma74",TRUE)
      #FUN-B10058--add--end
      OTHERWISE
         SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-502' AND ze02 = g_lang
         CALL cl_set_comp_att_text("oma16,omb31",ls_msg CLIPPED || "," || ls_msg CLIPPED)
#No.FUN-AB0034 --begin
         IF g_action_choice <> 'query' THEN 
            CALL cl_set_comp_visible("oma74",FALSE)
         END IF 
#No.FUN-AB0034 --end  
         CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
   END CASE
END FUNCTION
{genero應該不用)
FUNCTION t300_show0()
    IF g_lang='1' THEN RETURN END IF
    IF g_gui_type MATCHES "[13]" AND fgl_getenv('GUI_VER') = '6' THEN
         CASE WHEN g_oma.oma00='11' DISPLAY '訂單單號' AT  7,6
                                    DISPLAY '訂單單號' AT 14,7
              WHEN g_oma.oma00='12' DISPLAY '出貨單號' AT  7,6
                                    DISPLAY '出貨單號' AT 14,7
              WHEN g_oma.oma00='13' DISPLAY '出貨單號' AT  7,6
                                    DISPLAY '出貨單號' AT 14,7
              WHEN g_oma.oma00='14' DISPLAY '參考單號' AT  7,6
                                    DISPLAY '參考單號' AT 14,7
              WHEN g_oma.oma00='31' DISPLAY '參考單號' AT  7,6
                                    DISPLAY '參考單號' AT 14,7
              WHEN g_oma.oma00='21' DISPLAY '銷退單號' AT  7,6
                                    DISPLAY '銷退單號' AT 14,7
              OTHERWISE             DISPLAY '參考單號' AT  7,6
                                    DISPLAY '參考單號' AT 14,7
         END CASE
    ELSE
         CASE WHEN g_oma.oma00='11' DISPLAY '訂單單號' AT  8,1
                                    DISPLAY '訂單單號' AT 12,6
              WHEN g_oma.oma00='12' DISPLAY '出貨單號' AT  8,1
                                    DISPLAY '出貨單號' AT 12,6
              WHEN g_oma.oma00='13' DISPLAY '出貨單號' AT  8,1
                                    DISPLAY '出貨單號' AT 12,6
              WHEN g_oma.oma00='14' DISPLAY '參考單號' AT  8,1
                                    DISPLAY '參考單號' AT 12,6
              WHEN g_oma.oma00='31' DISPLAY '參考單號' AT  8,1
                                    DISPLAY '參考單號' AT 12,6
              WHEN g_oma.oma00='21' DISPLAY '銷退單號' AT  8,1
                                    DISPLAY '銷退單號' AT 12,6
              OTHERWISE             DISPLAY '參考單號' AT  8,1
                                    DISPLAY '參考單號' AT 12,6
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
          END CASE
    END IF
END FUNCTION
}
 
FUNCTION t300_show2()
DEFINE l_aag02    LIKE   aag_file.aag02    #TQC-790124
DEFINE l_aag02a   LIKE   aag_file.aag02    #TQC-790124
    SELECT aag02 INTO l_aag02 FROM aag_file WHERE aag01 = g_oma.oma18  #TQC-790124
                                            AND aag00 = g_bookno1   #No.FUN-730073
    SELECT aag02 INTO l_aag02a FROM aag_file WHERE aag01 = g_oma.oma181  #TQC-790124
                                             AND aag00 = g_bookno2   #No.FUN-730073
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
    DISPLAY l_aag02 TO aag02   #TQC-790124
    DISPLAY l_aag02a TO aag02_2  #TQC-790124 
END FUNCTION
 
FUNCTION t300_show_amt()
  DEFINE l_net  LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DISPLAY BY NAME
        g_oma.oma52,g_oma.oma54,g_oma.oma54x,g_oma.oma51f,g_oma.oma54t,g_oma.oma55, #FUN-590100
        g_oma.oma53,g_oma.oma56,g_oma.oma56x,g_oma.oma51,g_oma.oma56t,g_oma.oma57,  #fun-590100
        g_oma.oma19,g_oma.oma59,g_oma.oma59x,g_oma.oma59t,g_oma.oma73,g_oma.oma73f     #No.FUN-AB0034 add oma73,oma73f
   IF g_ooz.ooz07 = 'Y' THEN
      SELECT SUM(oox10) INTO l_net FROM oox_file
       WHERE oox00 ='AR' AND oox03 = g_oma.oma01
      IF cl_null(l_net) THEN LET l_net = 0 END IF
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
      DISPLAY l_net TO net
   END IF
END FUNCTION
 
FUNCTION t300_r()
    DEFINE l_chr,l_sure LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
           l_n          LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
           l_cnt        LIKE type_file.num5       #No.FUN-680123 SMALLINT   #MOD-5A0318
   DEFINE  l_omb        RECORD LIKE omb_file.*,   #MOD-630088
           tot          LIKE omb_file.omb18   #MOD-630088
   DEFINE  l_flag       LIKE type_file.chr1       #No.MOD-6B0113
   DEFINE  l_oob06      LIKE oob_file.oob06
   DEFINE  l_nmh17      LIKE nmh_file.nmh17
   DEFINE  l_nmh24      LIKE nmh_file.nmh24
   DEFINE  l_nmh33      LIKE nmh_file.nmh33
   DEFINE  l_omb38      LIKE omb_file.omb38       #MOD-990035 add    
   DEFINE  l_azw05      LIKE azw_file.azw05
   DEFINE  l_azw05_t    LIKE azw_file.azw05
   DEFINE  l_azw        DYNAMIC ARRAY OF RECORD
             azw05      LIKE azw_file.azw05,      
             azw01      LIKE azw_file.azw01     #FUN-A50102
                        END RECORD
   DEFINE  l_omb44      LIKE omb_file.omb44
   DEFINE  l_i          LIKE type_file.num5
   DEFINE  l_count      LIKE type_file.num5
   DEFINE  l_oaz92      LIKE oaz_file.oaz92     #FUN-C60033  

    IF s_shut(0) THEN RETURN END IF           
    IF g_oma.oma01 IS NULL THEN
       DELETE FROM oma_file WHERE oma01 IS NULL
       DELETE FROM omb_file WHERE omb01 IS NULL
       DELETE FROM omc_file WHERE omc01 IS NULL  #No.FUN-680022
       DELETE FROM npp_file WHERE npp01 IS NULL
       DELETE FROM npq_file WHERE npq01 IS NULL
       DELETE FROM oov_file WHERE oov01 IS NULL  #FUN-5A0124
       DELETE FROM oml_file WHERE oml01 IS NULL  #FUN-B40032 ADD
       DELETE FROM omk_file WHERE omk01 IS NULL  #FUN-B40032 ADD
       CALL cl_err("",-400,0)                 #No.FUN-6B0042
       RETURN
    END IF
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
    IF g_oma.omaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_oma.omavoid = 'Y' THEN CALL cl_err('','axr-103',0) RETURN END IF
    IF g_oma.oma64 matches '[Ss1]' THEN          #FUN-550049
       CALL cl_err('','mfg3557',0)
       RETURN
    END IF
#    IF g_azw.azw04 <> '2' THEN                  #FUN-A40076 Mark   
       IF g_oma.oma70 = '1'  THEN
          CALL cl_err('','alm-552',0) RETURN
       END IF
#    END IF                                      #FUN-A40076 Mark
    SELECT COUNT(*) INTO l_cnt FROM oot_file
     WHERE oot01 = g_oma.oma01
    IF l_cnt > 0 THEN
       CALL cl_err('','axr-009',0)
       RETURN
    END IF
 
   IF g_aza.aza26 != '2' OR g_oma.oma00[1,1]!='2' OR g_ooy.ooydmy2!='Y' THEN
      IF g_oma.oma55 != 0 AND g_oma.oma00!='31' THEN CALL cl_err('','axr-160',0) RETURN END IF                #No.MOD-510092
   END IF
   IF NOT cl_null(g_oma.oma33) THEN
      CALL cl_err(g_oma.oma01,'axr-310',0)
      RETURN
   END IF
    BEGIN WORK
    LET g_success = 'Y'
    DECLARE oob_cs1 CURSOR FOR
      SELECT oob06 FROM oob_file
       WHERE oob01=g_oma.oma01 AND oob03='1' AND oob04='1' AND oob02>0
    FOREACH oob_cs1 INTO l_oob06
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          LET g_success = 'N'
          EXIT FOREACH
       END IF
       SELECT nmh17,nmh24,nmh33 INTO l_nmh17,l_nmh24,l_nmh33 FROM nmh_file
        WHERE nmh01=l_oob06
       IF l_nmh24<>'2' THEN
          CALL cl_err('','axr-045',1)
          LET g_success='N'
          EXIT FOREACH
       END IF
       IF l_nmh17 > 0 THEN
          CALL cl_err('','axr-077',1)
          LET g_success='N'
          EXIT FOREACH
       END IF
       IF NOT cl_null(l_nmh33) THEN
          CALL cl_err('','axr-047',1)
          LET g_success='N'
          EXIT FOREACH
       END IF
       DELETE FROM nmh_file WHERE nmh01=l_oob06
       IF STATUS OR SQLCA.SQLCODE THEN
          CALL cl_err3("del","nmh_file","","",SQLCA.sqlcode,"","",1)
          LET g_success = 'N'
          EXIT FOREACH
       END IF
       DELETE FROM npp_file
        WHERE nppsys= 'NM' AND npp00=2 AND npp01 = l_oob06 AND npp011=1
       DELETE FROM npq_file
        WHERE npqsys= 'NM' AND npq00=2 AND npq01 = l_oob06 AND npq011=1
     #FUN-B40056--add--str--
       DELETE FROM tic_file WHERE tic04 = l_oob06
     #FUN-B40056--add--end--
    END FOREACH
    OPEN t300_cl USING g_oma.oma01
    IF STATUS THEN
       CALL cl_err("OPEN t300_cl:", STATUS, 1)
       CLOSE t300_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t300_cl INTO g_oma.*
    IF STATUS THEN CALL cl_err('sel oma',STATUS,0) ROLLBACK WORK RETURN END IF
    IF g_oma.oma00 = '11' OR g_oma.oma00 = '12' OR g_oma.oma00 = '13' OR
       g_oma.oma00 = '14' OR g_oma.oma00 = '31' THEN
       IF STATUS THEN
          CALL cl_err('lock oom',STATUS,0) ROLLBACK WORK RETURN
       END IF
    END IF
    CALL t300_show()
    DECLARE sel_oga_cs08 CURSOR FOR
     SELECT azw05,omb44 FROM omb_file,azw_file
      WHERE omb01 = g_oma.oma01
        AND omb44 = azw01
      ORDER BY azw05 
    LET g_cnt = 1
    LET l_azw05_t = ''
    FOREACH sel_oga_cs08 INTO l_azw05,l_omb44
       IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
       IF l_azw05_t = l_azw05 THEN
          CONTINUE FOREACH
       END IF
       LET l_azw[g_cnt].azw05 = l_azw05
       LET l_azw[g_cnt].azw01 = l_omb44   #FUN-A50102
       LET l_azw05_t = l_azw05
       LET g_cnt = g_cnt + 1
    END FOREACH
    LET l_count = g_cnt - 1
    IF cl_delh(20,16) THEN
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "oma01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_oma.oma01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                            #No.FUN-9B0098 10/02/24
        IF g_oma.oma10 IS NOT NULL THEN
           SELECT COUNT(*) INTO g_cnt FROM oma_file
            WHERE oma10 = g_oma.oma10
          #FUN-C60033--add--str--
          SELECT oaz92 INTO l_oaz92 FROM oaz_file
          IF l_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
          ELSE
           #FUN-C60033--add--end            
           IF g_cnt = 1 THEN  #一張發票對一張應收時才詢問是否殺
              IF NOT cl_confirm('axr-153') THEN RETURN END IF
              DELETE FROM ome_file WHERE ome01 = g_oma.oma10   #No.MOD-A10050 add
              DELETE FROM omee_file WHERE omee01 = g_oma.oma10 #CHI-A70028 add
           END IF                                              #No.MOD-A10050 add
            #IF g_oma.oma00 = '12' OR g_oma.oma00 = '13' OR    #CHI-A50040 mark
             IF g_oma.oma00 = '12' OR                          #CHI-A50040
                #g_oma.oma00 = '21' THEN                       #MOD-B20038
                g_oma.oma00 = '21' OR g_oma.oma00 = '19' OR g_oma.oma00 = '28' THEN  #MOD-B20038
                DECLARE omb_curs2 CURSOR FOR
                   SELECT * FROM omb_file WHERE omb01=g_oma.oma01
                FOREACH omb_curs2 INTO l_omb.*
                   IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
                   LET g_plant_new = l_omb.omb44
                   #CALL s_gettrandbs()
                   #LET li_dbs = g_dbs_tra
                   SELECT SUM(omb14*oma162/100) INTO tot FROM omb_file, oma_file   #MOD-760035
                     WHERE omb31=l_omb.omb31 AND omb01=oma01
                       AND omb32=l_omb.omb32   #MOD-760035
                       AND omavoid='N'
                       AND oma00=g_oma.oma00
                       AND oma10 IS NOT NULL AND oma10 != ' '
                   IF cl_null(tot) THEN LET tot = 0 END IF
                   IF l_omb.omb38 != 3 THEN        #TQC-860003
                      #LET g_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                      LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                  "   SET oga54 = oga54 - '",tot,"'",
                                  " WHERE oga01 = '",l_omb.omb31,"'"
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                      PREPARE upd_oga_pre01 FROM g_sql
                      EXECUTE upd_oga_pre01
                      IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                         CALL cl_err3("upd","oga_file",l_omb.omb31,"",STATUS,"","upd oga54",1)  #No.FUN-660116  
                         LET g_success='N' 
                         EXIT FOREACH
                      END IF
                      #LET g_sql = " UPDATE ",li_dbs CLIPPED,"ogb_file SET ogb60 = 0 ",
                      LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                                  " SET ogb60 = 0 ",
                                  "  WHERE ogb01 = '",l_omb.omb31,"'",
                                  "    AND ogb03 = '",l_omb.omb32,"'"
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                      PREPARE upd_ogb_pre02 FROM g_sql
                      EXECUTE upd_ogb_pre02
                      IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                         CALL cl_err3("upd","ogg_file",l_omb.omb31,l_omb.omb32,STATUS,"","upd ogb60",1) 
                         LET g_success='N' 
                         EXIT FOREACH
                      END IF
                   ELSE
                      #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oha_file ",
                      LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                  "    SET oha54 = oha54 - '",tot,"'",
                                  "  WHERE oha01 = '",l_omb.omb31,"'"
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                      PREPARE upd_oha_pre03 FROM g_sql
                      EXECUTE upd_oha_pre03
                      IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                         CALL cl_err3("upd","oha_file",l_omb.omb31,"",STATUS,"","upd oha54",1)  #No.FUN-660116  
                         LET g_success='N' 
                         EXIT FOREACH
                      END IF
                      #LET g_sql = " UPDATE ",li_dbs CLIPPED,"ohb_file SET ohb60 = 0 ",
                      LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                                  " SET ohb60 = 0 ",
                                  "  WHERE ohb01 = '",l_omb.omb31,"' ",
                                  "    AND ohb03 = '",l_omb.omb32,"'"
                      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
                      PREPARE upd_ohb_pre04 FROM g_sql
                      EXECUTE upd_ohb_pre04
                      IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                         CALL cl_err3("upd","ohb_file",l_omb.omb31,l_omb.omb32,STATUS,"","upd ohb60",1) 
                         LET g_success='N' 
                         EXIT FOREACH
                      END IF
                   END IF
                END FOREACH
             END IF
          END IF  #FUN-C60033             
        END IF
 
       #將程式段從下面搬到前面(因為要抓omb_file資料,需在DELETE前抓)
        #IF g_oma.oma00='12' THEN   #MOD-B20038
        IF g_oma.oma00='12' OR g_oma.oma00 = '19' THEN   #MOD-B20038
           LET g_cnt=0

           FOR l_i = 1 TO l_count
              #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."  #FUN-A50102
              LET g_plant_new = l_azw[l_i].azw01  #FUN-A50102
              #LET g_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oga_file ",
              LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                          " WHERE oga10 = '",g_oma.oma01,"' AND oga00 !='2'"
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
              PREPARE sel_oga_pre06 FROM g_sql
              EXECUTE sel_oga_pre06 INTO l_cnt
              LET g_cnt = g_cnt + l_cnt
           END FOR
           IF g_cnt > 0 THEN
             #抓取單身的出貨單
              LET g_sql = "SELECT DISTINCT omb31,omb38,omb44 FROM oma_file,omb_file", #No.FUN-9C0014
                          " WHERE oma01 = omb01",
                          "   AND omb38 <>'99'",  #FUN-C60033                          
                          #"   AND oma00 = '12'",   #MOD-B20038
                          "   AND (oma00 = '12' OR oma00 = '19')",   #MOD-B20038
                          "   AND omavoid != 'Y'",
                          "   AND omb01 = '",g_oma.oma01,"'",
                          " ORDER BY omb31"
              PREPARE t300_oga10_p1 FROM g_sql
              DECLARE t300_oga10_c1 CURSOR FOR t300_oga10_p1
              FOREACH t300_oga10_c1 INTO m_omb31,l_omb38,l_omb44 #MOD-9B0052 #No.FUN-9C0014 Add l_omb44
                 IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
                 LET m_oma01 = ''  LET m_oma05 = ''
                 SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
                  WHERE oma01 = omb01
                    #AND oma00 = '12'   #MOD-B20038
                    AND (oma00 = '12' OR oma00 = '19')   #MOD-B20038
                    AND omavoid != 'Y'
                    AND oma01 != g_oma.oma01
                    AND omb31 = m_omb31
                 IF cl_null(m_oma01) THEN
                    LET m_oma01=''   #MOD-8C0141 mod
                    LET m_oma05=g_oma.oma05            #MOD-9C0164
                 ELSE
                    SELECT oma05 INTO m_oma05 FROM oma_file WHERE oma01=m_oma01
                    IF cl_null(m_oma05) THEN LET m_oma05='' END IF   #MOD-8C0141 mod
                 END IF
                 LET g_plant_new = l_omb44
                 #CALL s_gettrandbs()
                 #LET li_dbs = g_dbs_tra
                 IF g_ooz.ooz65 = 'Y' AND l_omb38 = '3' THEN
                    #LET g_sql = "UPDATE ",li_dbs CLIPPED,"oha_file SET oha10 = NULL ",
                    LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                " SET oha10 = NULL ",
                                " WHERE oha01 = '",m_omb31,"'"
                 ELSE
                    #LET g_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                    LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "   SET oga10 = '",m_oma01,"',oga05 = '",m_oma05,"'",
                                " WHERE oga01 = '",m_omb31,"'"
                 END IF
                 CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                 PREPARE sel_oga_pre07 FROM g_sql
                 EXECUTE sel_oga_pre07
                 IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                    CALL cl_err3("upd","oga_file",m_omb31,"",SQLCA.sqlcode,"","upd oga10:",1)  #No.FUN-660116
                    LET g_success = 'N'
                 END IF
              END FOREACH
           END IF
        END IF
 
        MESSAGE "Delete oma,omb,oao,npp,npq!"
        DELETE FROM oma_file WHERE oma01 = g_oma.oma01
        IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
           CALL cl_err3("del","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","No oma deleted",1)  #No.FUN-660116
           LET g_success = 'N'
#TQC-A50116 --add
      ELSE        
         #FUN-A60056--mod--str--
         #UPDATE oha_file SET oha10 = NULL
         # WHERE oha10 = g_oma.oma01
         LET g_sql = "SELECT UNIQUE omb44 FROM omb_file ",
                     " WHERE omb01 = '",g_oma.oma01,"'"
         PREPARE sel_omb44_pre FROM g_sql
         DECLARE sel_omb44_cur CURSOR FOR sel_omb44_pre
         FOREACH sel_omb44_cur INTO l_omb44
            IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
            LET g_sql = "UPDATE ",cl_get_target_table(l_omb44,'oha_file'),
                        "   SET oha10 = NULL ",
                        " WHERE oha10 = '",g_oma.oma01,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql
            CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql
            PREPARE upd_oha FROM g_sql
            EXECUTE upd_oha
         #FUN-A60056--mod--end
            IF STATUS THEN 
               CALL cl_err('',STATUS,0)
               LET g_success = 'N'
            END IF     
         END FOREACH   #FUN-A60056
#TQC-A50116 --end                
        END IF
        DELETE FROM omb_file WHERE omb01 = g_oma.oma01
        IF STATUS THEN
           CALL cl_err3("del","omb_file",g_oma.oma01,"",STATUS,"","No omb deleted",1)  #No.FUN-660116
           LET g_success = 'N'
        END IF
        DELETE FROM omc_file WHERE omc01 = g_oma.oma01
        IF STATUS THEN
           CALL cl_err3("del","omc_file",g_oma.oma01,"",STATUS,"","No omc deleted",1)
           LET g_success = 'N'
        END IF
        DELETE FROM oov_file WHERE oov01 = g_oma.oma01
        IF STATUS THEN
           CALL cl_err3("del","oov_file",g_oma.oma01,"",STATUS,"","No oov deleted",1)  #No.FUN-660116
           LET g_success = 'N'
        END IF
        IF g_oma.oma00='14' THEN
           UPDATE fbe_file SET fbe11=NULL WHERE fbe11=g_oma.oma01
        END IF
        IF g_oma.oma00 MATCHES '1*' THEN
           DELETE FROM oot_file WHERE oot03 = g_oma.oma01
        ELSE
           DELETE FROM oot_file WHERE oot01 = g_oma.oma01
        END IF
        DELETE FROM npp_file WHERE npp01 = g_oma.oma01 AND nppsys = 'AR'
                               AND npp00 = 2 AND npp011 = 1
        DELETE FROM npq_file WHERE npq01 = g_oma.oma01 AND npqsys = 'AR'
                               AND npq00 = 2 AND npq011 = 1
     #FUN-B40056--add--str--
        DELETE FROM tic_file WHERE tic04 = g_oma.oma01
     #FUN-B40056--add--end--
        DELETE FROM oob_file WHERE oob01 = g_oma.oma01
        DELETE FROM ooa_file WHERE ooa01 = g_oma.oma01
        DELETE FROM oml_file WHERE oml01 = g_oma.oma01  #FUN-B40032 ADD
        DELETE FROM omk_file WHERE omk01 = g_oma.oma01  #FUN-B40032 ADD
        IF g_oma.oma16 IS NOT NULL THEN
           IF g_oma.oma01 <> g_oma.oma16 THEN
              DELETE FROM oao_file WHERE oao01 = g_oma.oma01
           END IF
        ELSE
           LET g_cnt=0
           SELECT COUNT(*) INTO g_cnt FROM omb_file
            WHERE omb31 = g_oma.oma01
           IF g_cnt = 0 THEN
              DELETE FROM oao_file WHERE oao01 = g_oma.oma01
           END IF
        END IF
       #-CHI-A50040-mark-
       #IF g_oma.oma00 = '13' AND g_oma.oma16 IS NOT NULL AND
       #   g_oma.oma162=0 THEN
       #   LET g_cnt=0
       #   FOR l_i = 1 TO l_count
       #      LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
       #      LET g_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oga_file ",
       #                  " WHERE oga10 = '",g_oma.oma01,"' AND oga00 !='2'"
       #      PREPARE sel_oga_pre09 FROM g_sql
       #      EXECUTE sel_oga_pre09 INTO l_cnt
       #      LET g_cnt = g_cnt + l_cnt
       #   END FOR
       #   IF g_cnt > 0 THEN
       #      FOR l_i = 1 TO l_count
       #         LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
       #         LET g_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
       #                     "   SET oga10 = NULL ",
       #                     " WHERE oga10 = '",g_oma.oma01,"'"
       #         PREPARE upd_oga_pre10 FROM g_sql
       #         EXECUTE upd_oga_pre10
       #         IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
       #            CALL cl_err3("upd","oga_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oga10:",1)
       #            LET g_success = 'N'
       #         END IF
       #      END FOR
       #   END IF
       #END IF
       #-CHI-A50040-mark-
        #IF g_oma.oma00='21' THEN   #MOD-B20038
        IF g_oma.oma00='21' OR g_oma.oma00 = '28' THEN
           LET g_cnt=0
           FOR l_i = 1 TO l_count
              #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"." #FUN-A50102
              LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
              #LET g_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file ",
              LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
#                         " WHERE oga10 = '",g_oma.oma01,"' "
                          " WHERE oha10 = '",g_oma.oma01,"' "          #No.MOD-B40084
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
              PREPARE sel_oga_pre12 FROM g_sql
              EXECUTE sel_oga_pre12 INTO l_cnt
              LET g_cnt = g_cnt + l_cnt
           END FOR
           IF g_cnt > 0 THEN
              FOR l_i = 1 TO l_count
                 #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"." #FUN-A50102
                 LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
                 #LET g_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                 LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             "   SET oha10 = NULL ",
                             " WHERE oha10 = '",g_oma.oma01,"'"
                 CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
                 PREPARE upd_oha_pre13 FROM g_sql
                 EXECUTE upd_oha_pre13
                 IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                    CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)
                    LET g_success = 'N'
                 END IF
              END FOR
           END IF
        END IF
        LET g_cnt = 0 
        FOR l_i = 1 TO l_count
           #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"." #FUN-A50102
           LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
           #LET g_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file ",
           LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                       " WHERE oha10 = '",g_oma.oma01,"' ",
                       "   AND ohaconf = 'Y'",
                       "   AND ohapost = 'Y'",
                       "   AND oha09 = '3' "
           CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                        
           PREPARE sel_oga_pre14 FROM g_sql
           EXECUTE sel_oga_pre14 INTO l_cnt
           LET g_cnt = g_cnt + l_cnt
        END FOR
        IF g_cnt > 0 THEN 
           FOR l_i = 1 TO l_count
              #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"." #FUN-A50102
              LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
              #LET g_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
              LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                          "   SET oha10 = NULL ",
                          " WHERE oha10 = '",g_oma.oma01,"'",
                          "   AND ohaconf = 'Y'",
                          "   AND ohapost = 'Y'",
                          "   AND oha09 = '3' "
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                                    
              PREPARE upd_oha_pre14 FROM g_sql
              EXECUTE upd_oha_pre14
              IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                 CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)
                 LET g_success = 'N'
              END IF
           END FOR
        END IF
        LET g_msg=TIME
        IF NOT cl_null(g_oma.oma62) THEN
           #FUN-A60056--mod--str--
           #UPDATE rme_file SET rme10=NULL
           # WHERE rme01=g_oma.oma62
            LET g_sql = "SELECT UNIQUE omb44 FROM omb_file ",
                        " WHERE omb01 = '",g_oma.oma01,"'"
            PREPARE sel_omb44_pre1 FROM g_sql
            DECLARE sel_omb44_cur1 CURSOR FOR sel_omb44_pre1
            FOREACH sel_omb44_cur1 INTO l_omb44
               IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
               LET g_sql = "UPDATE ",cl_get_target_table(l_omb44,'rme_file'),
                           "   SET rme10 = NULL ",
                           " WHERE rme01 = '",g_oma.oma62,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql
               CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql
               PREPARE upd_rme FROM g_sql
               EXECUTE upd_rme
         #FUN-A60056--mod--end
               IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                  CALL cl_err3("upd","rme_file",g_oma.oma62,"",SQLCA.sqlcode,"","upd rme10:",1)  #No.FUN-660116
                  LET g_success = 'N'
               END IF
            END FOREACH   #FUN-A60056 
        END IF
        INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)     #FUN-980011 add
           VALUES ('axrt300',g_user,g_today,g_msg,g_oma.oma01,'delete',g_plant,g_legal) #FUN-980011 add
        CLEAR FORM
        CALL g_omb.clear()
        #FUN-C60033--add--str--by xuxz
        SELECT oaz92 INTO g_oaz.oaz92 FROM oaz_file
        IF g_oaz.oaz92 = 'Y' AND g_aza.aza26 ='2' THEN
           UPDATE omf_file SET omf04 = '' WHERE omf04 = g_oma.oma01
        END IF
        #FUN-C60033--ad--end--by xuxz        
        CALL t300_r_minus_invno()
          INITIALIZE g_oma.* TO NULL
        MESSAGE ""
        OPEN t300_count
        #FUN-B50064-add-start--
        IF STATUS THEN
           CLOSE t300_cs
           CLOSE t300_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end--
        FETCH t300_count INTO g_row_count
        #FUN-B50064-add-start--
        IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
           CLOSE t300_cs
           CLOSE t300_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end-- 
        DISPLAY g_row_count TO FORMONLY.cnt
        IF g_row_count > 0 THEN
           OPEN t300_cs
           IF g_curs_index = g_row_count + 1 THEN
              LET g_jump = g_row_count
              CALL t300_fetch('L')
           ELSE
              LET g_jump = g_curs_index
              LET mi_no_ask = TRUE
              CALL t300_fetch('/')
           END IF
        END IF
 
    END IF
    CLOSE t300_cl
    IF g_success = 'Y' THEN
        COMMIT WORK
        CALL cl_flow_notify(g_oma.oma01,'D')
    ELSE
        ROLLBACK WORK
    END IF
    CALL t300_show()    #FUN-960140
END FUNCTION
 
FUNCTION t300_r_minus_invno()
   DEFINE l_oma01            LIKE oma_file.oma01
   DEFINE l_oom07            LIKE oom_file.oom07
   DEFINE l_oom11            LIKE oom_file.oom11
   DEFINE l_oom12            LIKE oom_file.oom12
   DEFINE l_last_no          LIKE oom_file.oom09
   DEFINE l_i                LIKE type_file.num5       #No.FUN-680123 SMALLINT
   DEFINE g_format           LIKE oom_file.oom07       #No.FUN-680123 VARCHAR(16)
   IF g_oma.oma10 IS NULL THEN RETURN END IF
   IF g_oma.oma00 = '11' OR g_oma.oma00 = '12' OR g_oma.oma00 = '13' OR
      g_oma.oma00 = '14' OR g_oma.oma00 = '31'
      THEN LET l_last_no = g_oma.oma10
      ELSE RETURN
   END IF
   SELECT oom07,oom11,oom12 INTO l_oom07,l_oom11,l_oom12  #No.FUN-560198
     FROM oom_file
     WHERE oom09=g_oma.oma10
   IF STATUS THEN RETURN END IF
   WHILE TRUE
      LET g_format = ''   #MOD-990153 add
      #為了與舊寫法兼容，default初值
      IF cl_null(l_oom11) THEN LET l_oom11 = 3 END IF
      IF cl_null(l_oom12) THEN LET l_oom12 = 10 END IF
      FOR l_i = l_oom11 TO l_oom12
         LET g_format = '&',g_format CLIPPED
      END FOR
      IF l_oom11 > 1 THEN
         LET l_last_no=l_last_no[1,l_oom11-1],
            (l_last_no[l_oom11,l_oom12]-1) USING g_format
      ELSE
         LET l_last_no=l_last_no[l_oom11,l_oom12]-1 USING g_format
      END IF
      IF l_last_no<=l_oom07 THEN LET l_last_no = NULL EXIT WHILE END IF  #MOD-990153
     #SELECT ome01 FROM ome_file WHERE ome01=l_last_no AND omevoid = 'N'   #MOD-A60076 mark
      SELECT ome01 FROM ome_file WHERE ome01=l_last_no                     #MOD-A60076
      IF STATUS=0 THEN EXIT WHILE END IF
   END WHILE
   UPDATE oom_file SET oom09 = l_last_no WHERE oom09=g_oma.oma10
   MESSAGE 'invoice no return to:',l_last_no RETURN
END FUNCTION
 
FUNCTION t300_b()
    DEFINE l_ac_t          LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #未取消的ARRAY CNT
           l_row,l_col     LIKE type_file.num5,      #No.FUN-680123 SMALLINT,                     #分段輸入之行,列數
           l_n,l_cnt,l_n1  LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #檢查重複用
           l_lock_sw       LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),               #單身鎖住否
           p_cmd           LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),               #處理狀態
           l_b2            LIKE ima_file.ima25,      #No.FUN-680123 VARCHAR(30),
           l_i             LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
           l_qty           LIKE omb_file.omb12,      #No:7682
           l_oma24         LIKE oma_file.oma24,
           l_oma24_b       LIKE oma_file.oma24,
           l_oma58         LIKE oma_file.oma58,
           l_count         LIKE oeb_file.oeb14t,
           l_flag          LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(01),
           l_allow_insert  LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #可新增否
           l_allow_delete  LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #可刪除否
           l_act           LIKE type_file.num20_6,   #No.FUN-680123 DEC(20,6),             #No.FUN-670026
           l_oma64         LIKE oma_file.oma64
    DEFINE l_str1,l_str2   STRING                #No.FUN-570099
    DEFINE l_oga02         LIKE oga_file.oga02   #TQC-750058
    DEFINE l_oga07         LIKE oga_file.oga07   #MOD-760086
    DEFINE l_aag02         LIKE aag_file.aag02   #TQC-790124
    DEFINE l_pjb25         LIKE pjb_file.pjb25   #FUN-810045
    DEFINE l_pjb09         LIKE pjb_file.pjb09   #No.FUN-850027 
    DEFINE l_pjb11         LIKE pjb_file.pjb11   #No.FUN-850027
    DEFINE l_oha02         LIKE oha_file.oha02   #No.MOD-890208
    DEFINE l_oha09         LIKE oha_file.oha09   #MOD-890215 add
    DEFINE l_omb12         LIKE omb_file.omb12   #MOD-8C0192 add
    DEFINE l_aag05         LIKE aag_file.aag05   #FUN-8C0089 add
    DEFINE l_aag05a        LIKE aag_file.aag05   #FUN-8C0089 add
    DEFINE l_omb31         LIKE omb_file.omb31  
    DEFINE l_rec_b1        LIKE type_file.num5  
    DEFINE l_oob06         LIKE oob_file.oob06  
    DEFINE l_nmh17         LIKE nmh_file.nmh17  
    DEFINE l_nmh24         LIKE nmh_file.nmh24  
    DEFINE l_nmh33         LIKE nmh_file.nmh33  
    DEFINE l_sql           STRING                #FUN-9A0093
    DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
    DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add       

    LET pb_cmd= 'N'   
    LET g_action_choice = ""
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
    LET l_oma64 = g_oma.oma64               #FUN-550049
    IF g_oma.omaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_oma.omavoid = 'Y' THEN CALL cl_err('','axr-103',0) RETURN END IF

###-FUN-B50170- ADD - BEGIN ---------------------------------------------
    IF g_oma.oma70 = '3'  THEN
       CALL cl_err('','axr-087',0) RETURN
       #POS交易產生的單據不可維護, 但可刪除\確認\取消確認！
    END IF
###-FUN-B50170- ADD -  END  ---------------------------------------------

      IF g_oma.oma64 matches '[Ss]' THEN
       SELECT count(*) INTO l_n1
         FROM omb_file
        WHERE omb01 = g_oma.oma01
       IF l_n1 = 0 THEN
           RETURN
       END IF
    END IF
 
    IF g_aza.aza26 != '2' OR g_oma.oma00[1,1]!='2' OR g_ooy.ooydmy2!='Y' THEN
       IF g_oma.oma55 != 0 AND g_oma.oma00!='31' THEN   #No:8519
          CALL cl_err('','axr-160',0) RETURN
       END IF
    END IF
    CALL t300_g_b()                 #由出貨單或訂單自動產生單身
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = " SELECT * FROM omb_file ",
                       "  WHERE omb01=? AND omb03=? ",
                       " FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t300_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
      LET l_ac_t = 0
      LET l_ac_t = 0                                                                                                                
      IF g_oma.oma64 matches '[Ss]' THEN #FUN-8A0075 
         LET l_allow_insert = FALSE    #FUN-8A0075
         LET l_allow_delete = FALSE    #FUN-8A0075
      ELSE                             #FUN-8A0075
         LET l_allow_insert = cl_detail_input_auth("insert")
         LET l_allow_delete = cl_detail_input_auth("delete")
      END IF                           #FUN-8A0075
      IF g_rec_b=0 THEN CALL g_omb.clear() END IF
 
 
      INPUT ARRAY g_omb WITHOUT DEFAULTS FROM s_omb.*
            ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            CALL cl_set_comp_entry("omb31,omb32",TRUE) #NO.FUN-960140
           CALL cl_set_docno_format("omb31")
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.cn3
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()
            BEGIN WORK
 
            OPEN t300_cl USING g_oma.oma01
            IF STATUS THEN
               CALL cl_err("OPEN t300_cl:", STATUS, 1)
               CLOSE t300_cl
               ROLLBACK WORK
               RETURN
            END IF
            FETCH t300_cl INTO g_oma.*  # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE t300_cl ROLLBACK WORK RETURN
            END IF
            IF g_rec_b >= l_ac THEN
                LET g_omb_t.* = g_omb[l_ac].*  #BACKUP
                LET p_cmd='u'
                IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
                   CALL cl_set_comp_entry("omb31,omb32",FALSE)
                END IF
                #add by zhangym 111103 begin-----
                IF g_oma.oma00 = '11' OR g_oma.oma00 = '12' OR g_oma.oma00 = '13' THEN 
                   CALL cl_set_comp_entry("omb12",FALSE)
                END IF 
                #add by zhangym 111103 end-----
                OPEN t300_bcl USING g_oma.oma01,g_omb_t.omb03
                IF STATUS THEN
                   CALL cl_err("OPEN t300_bcl:", STATUS, 1)
                   LET l_lock_sw = "Y"
                   CLOSE t300_bcl
                   ROLLBACK WORK
                   RETURN
                ELSE
                   FETCH t300_bcl INTO b_omb.*
                   IF SQLCA.sqlcode THEN
                       CALL cl_err('lock omb',SQLCA.sqlcode,1)
                       LET l_lock_sw = "Y"
                   END IF
                   CALL t300_b_move_to()
                   LET g_omb[l_ac].gem02c=s_costcenter_desc(g_omb[l_ac].omb930) #FUN-680001
                END IF
                CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF
            CALL t300_set_entry_b()   #MOD-690136    
            CALL t300_set_no_entry_b(p_cmd)           
            CALL t300_set_no_entry_b_1()   #No;FUN-8A0075
            CALL t300_ooz65()  #No.FUN-670026
            LET l_oha09 = ' '  #MOD-890215 add
 
        ON CHANGE omb03
            LET pb_cmd='Y'
        ON CHANGE omb38
            LET pb_cmd='Y'
        ON CHANGE omb31
            LET pb_cmd='Y'
        ON CHANGE omb32
            LET pb_cmd='Y'
        ON CHANGE omb04
            LET pb_cmd='Y'
        ON CHANGE omb05
            LET pb_cmd='Y'
        ON CHANGE omb12
            LET pb_cmd='Y'
        ON CHANGE omb13
            LET pb_cmd='Y'
        ON CHANGE omb14
            LET pb_cmd='Y'
        ON CHANGE omb14t
            LET pb_cmd='Y'
        ON CHANGE omb15
            LET pb_cmd='Y'
        ON CHANGE omb16
            LET pb_cmd='Y'
        ON CHANGE omb16t
            LET pb_cmd='Y'
        ON CHANGE omb17
            LET pb_cmd='Y'
        ON CHANGE omb18
            LET pb_cmd='Y'
        ON CHANGE omb18t
            LET pb_cmd='Y'
        ON CHANGE omb40
            LET pb_cmd='Y'
        ON CHANGE omb41
            LET pb_cmd='Y'
        ON CHANGE omb42
            LET pb_cmd='Y'
        ON CHANGE omb33
            LET pb_cmd='Y'
        ON CHANGE omb331
            LET pb_cmd='Y'
        ON CHANGE omb930
            LET pb_cmd='Y'
 
 
        AFTER INSERT
            IF NOT cl_null(g_omb[l_ac].omb31) THEN
               IF cl_null(g_omb[l_ac].omb32) THEN
                  NEXT FIELD omb32
               END IF
            END IF
            #數量、金額欄位皆為0表示根本沒有輸入單身(都是default來的)
            IF g_omb[l_ac].omb12 =0 AND g_omb[l_ac].omb13 =0 AND
               g_omb[l_ac].omb14 =0 AND g_omb[l_ac].omb14t=0 AND
               g_omb[l_ac].omb15 =0 AND g_omb[l_ac].omb16 =0 AND
               g_omb[l_ac].omb16t=0 AND g_omb[l_ac].omb17 =0 AND
               g_omb[l_ac].omb18 =0 AND g_omb[l_ac].omb18t=0 THEN
               CALL cl_err('','amr-304',0)
               INITIALIZE g_omb[l_ac].* TO NULL  #重要欄位空白,無效
               DISPLAY g_omb[l_ac].* TO s_omb.*
            END IF
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
              INITIALIZE g_omb[l_ac].* TO NULL  #重要欄位空白,無效
              DISPLAY g_omb[l_ac].* TO s_omb.*
              CALL g_omb.deleteElement(l_ac)
              ROLLBACK WORK
              EXIT INPUT
               CANCEL INSERT
            END IF
            CALL t300_b_move_back()
            CALL t300_b_else()
            IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
               LET b_omb.omb36=g_oma.oma24
               LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
            END IF
             #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
             LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                         " WHERE oha01='",g_omb[l_ac].omb31,"' "
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                            
             PREPARE sel_oha09_pre FROM l_sql
             EXECUTE sel_oha09_pre INTO l_oha09
            IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
            IF (  g_omb[l_ac].omb12 IS NULL OR
                ( g_omb[l_ac].omb12 = 0 AND g_omb[l_ac].omb32 < 9001 AND
                 ((g_omb[l_ac].omb38 ='3' AND l_oha09!='5') OR g_omb[l_ac].omb38!='3'))) THEN #No.TQC-740350
                 INITIALIZE g_omb[l_ac].* TO NULL  #重要欄位空白,無效
            ELSE
               INSERT INTO omb_file VALUES(b_omb.*)
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("ins","omb_file",b_omb.omb01,b_omb.omb03,SQLCA.sqlcode,"","ins ombf",1)  #No.FUN-660116
                  CANCEL INSERT
               ELSE
                  MESSAGE 'INSERT O.K'
                  LET pb_cmd='Y'                        #NO.FUN-960140
                 #IF g_oma.oma00 = '12' AND g_oma.oma16 IS NULL THEN    #MOD-AB0216 mark 
                  IF g_oma.oma00 = '12' THEN                            #MOD-AB0216
                     IF g_omb[l_ac].omb38 = '2' OR g_omb[l_ac].omb38 = '4' THEN     #MOD-870253
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                    "   SET oga10 = '",g_oma.oma01,"' ,",
                                    "       oga05 = '",g_oma.oma05,"' ",
                                    " WHERE oga01 = '",b_omb.omb31,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                   
                        PREPARE upd_oga_pre FROM l_sql
                        EXECUTE upd_oga_pre
                        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                           CALL cl_err3("upd","oga_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)     #MOD-7A0179
                        END IF
                     END IF 
                     IF g_omb[l_ac].omb38 = '3' OR g_omb[l_ac].omb38 = '5' THEN     #MOD-870253
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                    "   SET oha10 = '",g_oma.oma01,"' ",
                                    " WHERE oha01 = '",b_omb.omb31,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
                        PREPARE upd_oha_pre FROM l_sql
                        EXECUTE upd_oha_pre
                        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                           CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)     #MOD-7A0179
                        END IF
                     END IF
                  END IF
                  IF g_oma.oma00 ='21' AND g_oma.oma16 IS NULL THEN
                     #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                     LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                 "   SET oha10 = '",g_oma.oma01,"' ",
                                 " WHERE oha01 = '",b_omb.omb31,"' "
                     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
                     PREPARE upd_oha_pre1 FROM l_sql
                     EXECUTE upd_oha_pre1
                      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                         CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                      END IF
                  END IF     
                  LET l_oma64 = '0'          #FUN-550049
                  LET g_rec_b=g_rec_b+1
                  CALL t300_mlog('A')
                  DISPLAY g_rec_b TO FORMONLY.cn2
                 #-TQC-B60089-add-
                  LET g_ogb_o.* = g_ogb.*
                  LET g_sql = " SELECT * ",
                              "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                              "  WHERE ogb01 = '",b_omb.omb31,"'",
                              "    AND ogb03 = '",b_omb.omb32,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                  PREPARE sel_ogb_pre16 FROM g_sql
                  EXECUTE sel_ogb_pre16 INTO g_ogb.*
                 #-TQC-B60089-end-
                 #-------------------------------No.CHI-B90025----------------------------------start
                  IF g_oma.oma00='11' THEN
                     SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                      WHERE oeaa01 = g_oma.oma16
                        AND oeaa02 = '1'
                        AND oeaa03 = g_oma.oma165
                        AND oeaa01 = oea01
                  END IF
                  IF g_oma.oma00='13' THEN
                     SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                      WHERE oeaa01 = g_oma.oma16
                        AND oeaa02 = '2'
                        AND oeaa03 = g_oma.oma165
                        AND oeaa01 = oea01
                  END IF
                  CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                 #CALL t300_bu()
                 #-------------------------------No.CHI-B90025----------------------------------end
                  LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                  CALL t300_show_rec_amt()   #MOD-770142
                COMMIT WORK
               END IF
            END IF
 
        BEFORE INSERT
            LET g_cnt=0
            SELECT COUNT(*) INTO g_cnt FROM omb_file WHERE omb01=g_oma.oma01
            IF (g_oma.oma08='1' AND g_cnt = g_ooz.ooz121) OR
               (g_oma.oma08 MATCHES '[23]' AND g_cnt = g_ooz.ooz122) THEN   #No.MOD-910093
               CALL cl_err('','axr-156',0)
               CANCEL INSERT
            END IF
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_omb[l_ac].* TO NULL      #900423
            LET b_omb.omb01=g_oma.oma01
            IF g_ooz.ooz65!='Y' THEN
               LET b_omb.omb39='N'             
               LET g_omb[l_ac].omb39='N'        
               CASE g_oma.oma00
                 WHEN '11' LET g_omb[l_ac].omb38 = '1' 
                 WHEN '12' LET g_omb[l_ac].omb38 = '2' 
                #WHEN '13' LET g_omb[l_ac].omb38 = '2'    #CHI-A50040 mark 
                 WHEN '13' LET g_omb[l_ac].omb38 = '1'    #CHI-A50040
                 WHEN '21' LET g_omb[l_ac].omb38 = '3' 
                 OTHERWISE LET g_omb[l_ac].omb38 = '99'
               END CASE
            END IF
            IF NOT cl_null(g_oma.oma66) THEN
               LET g_omb[l_ac].omb44 = g_oma.oma66
            END IF 
            LET g_omb[l_ac].omb12=0
            LET g_omb[l_ac].omb13=0
            LET g_omb[l_ac].omb14=0
            LET g_omb[l_ac].omb14t=0
            LET g_omb[l_ac].omb15=0
            LET g_omb[l_ac].omb16=0
            LET g_omb[l_ac].omb16t=0
            LET g_omb[l_ac].omb17=0
            LET g_omb[l_ac].omb18=0
            LET g_omb[l_ac].omb18t=0
            LET g_omb[l_ac].omb930=g_oma.oma930 #FUN-680001
            LET g_omb[l_ac].gem02c=s_costcenter_desc(g_omb[l_ac].omb930) #FUN-680001
            LET b_omb.omb34=0
            LET b_omb.omb35=0
            LET b_omb.omb39='N'             #No.TQC-790125
            LET g_omb[l_ac].omb39='N'       #MOD-7B0071  
            IF NOT cl_null(g_oma.oma63) THEN
              LET g_omb[l_ac].omb41 = g_oma.oma63
            END IF
            LET g_omb_t.* = g_omb[l_ac].*             #新輸入資料
            CALL cl_show_fld_cont()     #FUN-550037(smin)
            NEXT FIELD omb03
 
        BEFORE FIELD omb03                            #default 序號
            IF g_omb[l_ac].omb03 IS NULL OR g_omb[l_ac].omb03 = 0 THEN
                SELECT max(omb03)+1 INTO g_omb[l_ac].omb03
                   FROM omb_file WHERE omb01 = g_oma.oma01
                IF g_omb[l_ac].omb03 IS NULL THEN
                    LET g_omb[l_ac].omb03 = 1
                END IF
            END IF
           IF g_oma.oma00='13' THEN
              IF NOT cl_null(g_oma.oma16) THEN
                 IF cl_null(g_omb[l_ac].omb31) THEN
                    LET g_omb[l_ac].omb31 = g_oma.oma16
                 END IF
              END IF
           END IF
 
        AFTER FIELD omb03                        #check 序號是否重複
           IF NOT cl_null(g_omb[l_ac].omb03) THEN
              IF g_omb[l_ac].omb03 != g_omb_t.omb03 OR
                 g_omb_t.omb03 IS NULL THEN
                  SELECT count(*) INTO l_n FROM omb_file
                      WHERE omb01 = g_oma.oma01 AND omb03 = g_omb[l_ac].omb03
                  IF l_n > 0 THEN
                      LET g_omb[l_ac].omb03 = g_omb_t.omb03
                      CALL cl_err('',-239,0) NEXT FIELD omb03
                  ELSE                     #FUN-960140
                      LET pb_cmd='Y'       #FUN-960140                   
                  END IF
              END IF
           END IF
 
        BEFORE FIELD omb38
           IF g_ooz.ooz65 = 'Y' THEN
              CALL cb.clear()
              CALL cb.addItem(1,g_cb[1])
              CALL cb.addItem(2,g_cb[2])
              CALL cb.addItem(3,g_cb[3])
              CALL cb.addItem(4,g_cb[4])
              CALL cb.addItem(5,g_cb[5])
              CALL cb.addItem(99,g_cb[6])
              CASE 
                WHEN g_oma.oma00='11'
                  CALL cb.removeItem('2')
                  CALL cb.removeItem('3')
                  CALL cb.removeItem('4')
                  CALL cb.removeItem('5')
                  CALL cb.removeItem('99')
                WHEN g_oma.oma00='12'
                  IF g_aza.aza50='Y' THEN
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('99')
                  ELSE
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('4')
                     CALL cb.removeItem('5')
                     CALL cb.removeItem('99')
                  END IF
                WHEN g_oma.oma00='13'
                 #-CHI-A50040-add- 
                 #IF g_aza.aza50='Y' THEN
                 #   CALL cb.removeItem('1')
                 #   CALL cb.removeItem('99')
                 #ELSE
                 #   CALL cb.removeItem('1')
                 #   CALL cb.removeItem('4')
                 #   CALL cb.removeItem('5')
                 #   CALL cb.removeItem('99')
                 #END IF
                  CALL cb.removeItem('2')
                  CALL cb.removeItem('3')
                  CALL cb.removeItem('4')
                  CALL cb.removeItem('5')
                  CALL cb.removeItem('99')
                 #-CHI-A50040-add- 
                WHEN g_oma.oma00='21'
                  IF g_aza.aza50='Y' THEN
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('2')
                     CALL cb.removeItem('4')
                     CALL cb.removeItem('99')
                  ELSE
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('2')
                     CALL cb.removeItem('4')
                     CALL cb.removeItem('5')
                     CALL cb.removeItem('99')
                  END IF
                WHEN g_oma.oma00='25'
                  IF g_aza.aza50='Y' THEN
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('3')
                     CALL cb.removeItem('5')
                  ELSE
                     CALL cb.removeItem('1')
                     CALL cb.removeItem('2')
                     CALL cb.removeItem('3')
                     CALL cb.removeItem('4')
                     CALL cb.removeItem('5')
                  END IF  
                OTHERWISE 
                  CALL cb.removeItem('1')
                  CALL cb.removeItem('2')
                  CALL cb.removeItem('3')
                  CALL cb.removeItem('4')
                  CALL cb.removeItem('5')
              END CASE
           END IF
 
       AFTER FIELD omb38
           IF g_omb[l_ac].omb38 MATCHES '[4,5]' THEN
              CALL cl_set_comp_entry("omb04,omb05,omb12,omb03,omb15,omb17",FALSE)
           ELSE
#              CALL cl_set_comp_entry("omb04,omb05,omb12,omb03,omb15,omb17",TRUE)
              CALL cl_set_comp_entry("omb04,omb05,omb03,omb15,omb17",TRUE)    #modify by zhangym 111103             
           END IF
#TQC-AB0228--add--str--
           IF g_omb[l_ac].omb38 MATCHES '[2,3]' THEN
              CALL cl_set_comp_required("omb31",TRUE)
           ELSE
             CALL cl_set_comp_required("omb31",FALSE)
           END IF
#TQC-AB0228--add--end--
        
        BEFORE FIELD omb44
           IF NOT cl_null(g_oma.oma66) THEN
              LET g_omb[l_ac].omb44 = g_oma.oma66
           END IF 

        AFTER FIELD omb44
           IF NOT cl_null(g_omb[l_ac].omb44) THEN
              CALL t300_omb44()
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_omb[l_ac].omb44,g_errno,1)
                 NEXT FIELD omb44
              END IF
           ELSE
              CALL cl_err('','alm-809',0)
              NEXT FIELD omb44 
           END IF

        BEFORE FIELD omb31                                          #MOD-B20044 
           IF g_ooz.ooz65 = 'Y' AND cl_null(g_omb[l_ac].omb38) THEN #MOD-B20044
              CALL cl_err(g_omb[l_ac].omb38,-474,1)                 #MOD-B20044
              NEXT FIELD omb38                                      #MOD-B20044
           END IF                                                   #MOD-B20044
 
        AFTER FIELD omb31
           IF NOT cl_null(g_omb[l_ac].omb31) THEN
              #-----MOD-A40078---------
              CALL t300_chk_it(g_omb[l_ac].omb31)
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_omb[l_ac].omb31,g_errno,1)
                 NEXT FIELD omb31
              END IF
              #-----END MOD-A40078-----
              CALL s_get_doc_no(g_omb[l_ac].omb31) RETURNING g_buf           #No.FUN-550071
              #LET l_sql = "SELECT oay11 FROM ",li_dbs CLIPPED,"oay_file ",
              LET l_sql = "SELECT oay11 FROM ",cl_get_target_table(g_plant_new,'oay_file'), #FUN-A50102
                          " WHERE oayslip='",g_buf,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
              PREPARE sel_oay11_pre FROM l_sql
              EXECUTE sel_oay11_pre INTO g_oay11
              IF NOT STATUS AND
                 g_oay11<>'Y' THEN
                 CALL cl_err(g_omb[l_ac].omb31,'axr-372',0)
                 NEXT FIELD omb31
              END IF
           END IF
           LET g_oma.oma34 = ' '
           #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
           LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                       " WHERE oha01='",g_omb[l_ac].omb31,"' "
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
           PREPARE sel_oha09_pre1 FROM l_sql
           EXECUTE sel_oha09_pre1 INTO g_oma.oma34
           IF cl_null(g_oma.oma34) THEN LET g_oma.oma34 = ' ' END IF
           IF g_oma.oma00='11' AND cl_null(g_omb[l_ac].omb31) THEN
              NEXT FIELD omb31
           END IF
           IF g_oma.oma00='12' AND cl_null(g_omb[l_ac].omb31) AND
              g_ooz.ooz19='N' THEN NEXT FIELD omb31
           END IF
           IF g_oma.oma00='11' AND NOT cl_null(g_omb[l_ac].omb31) THEN
              IF NOT cl_null(g_omb[l_ac].omb44) THEN #No.FUN-9C0014
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oea_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                             " WHERE oea01='",g_omb[l_ac].omb31,"' ",
                             "   AND oea00='1' AND oeaplant = '",g_omb[l_ac].omb44,"' "  #No.FUN-9C0014
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
                 PREPARE sel_oea_pre FROM l_sql
                 EXECUTE sel_oea_pre INTO g_oea.* 
              ELSE
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oea_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                             " WHERE oea01='",g_omb[l_ac].omb31,"' ",
                             "   AND oea00='1'"
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                             
                 PREPARE sel_oea_pre1 FROM l_sql
                 EXECUTE sel_oea_pre1 INTO g_oea.* 
              END IF    #FUN-960140
              IF STATUS THEN
                 CALL cl_err3("sel","oea_file",g_omb[l_ac].omb31,"",STATUS,"","sel oea",1)  #No.FUN-660116
                 NEXT FIELD omb31 
              END IF
              IF g_oea.oeaconf = 'N' THEN
                 CALL cl_err('','axr-194',0) NEXT FIELD omb31
              END IF
              IF g_oea.oea161 = 0 THEN            #不可開訂金應收
                 CALL cl_err('','axr-166',0) NEXT FIELD omb31
              END IF
              IF g_oea.oea17 != g_oma.oma68 AND g_oea.oea17 IS NOT NULL THEN
                 CALL cl_err("","axr-601",1)
                 NEXT FIELD omb31
              END IF
              IF g_omb[l_ac].omb31 != g_oma.oma16  THEN
                 CALL cl_err("","axr-612",1)
                 NEXT FIELD omb31
              END IF
              IF g_omb[l_ac].omb31 != g_oma.oma16  THEN
                 CALL cl_err("","axr-612",1)
                 NEXT FIELD omb31
              END IF
          #END IF                                          #CHI-A50040 mark
          #IF (g_oma.oma00='12' OR g_oma.oma00='13') AND   #CHI-A50040 mark
          #   NOT cl_null(g_omb[l_ac].omb31) THEN          #CHI-A50040 mark
              IF g_oma.oma00='13' THEN
                 LET g_cnt=0
                 SELECT COUNT(*) INTO g_cnt FROM oma_file,omb_file
                  WHERE oma00='13' AND oma01=omb01
                    AND omb31=g_omb[l_ac].omb31
                    AND oma01 !=g_oma.oma01
                 IF g_cnt >0 THEN
                    CALL cl_err('','axr-261',0) NEXT FIELD omb31
                 END IF
                 IF g_oma.oma16 !=g_omb[l_ac].omb31 THEN
                    CALL cl_err(g_oma.oma16,'axm-300',0) NEXT FIELD omb31
                 END IF
              END IF
           END IF                                          #CHI-A50040
           IF g_oma.oma00='12' AND NOT cl_null(g_omb[l_ac].omb31) THEN    #CHI-A50040
             #增加判斷條件1.當出貨及出貨返利時，檢查方式與原有一樣，
             #            2.當銷退及銷退返利時，檢查方式與"折讓"類型相同
              IF g_omb[l_ac].omb38 = '2' OR g_omb[l_ac].omb38 = '4' THEN #FUN-670026--add
                 IF NOT cl_null(g_omb[l_ac].omb44) THEN #No.FUN-9C0014
                    #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oga_file ",
                    LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                " WHERE oga01='",g_omb[l_ac].omb31,"' ",
                                "   AND oga00 IN ('1','4','5','6','B')",    #MOD-A50108 add B
                                "   AND ogaplant = '",g_omb[l_ac].omb44,"' " #No.FUN-9C0014
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                                            
                    PREPARE sel_oga_pre FROM l_sql
                    EXECUTE sel_oga_pre INTO g_oga.*
                 ELSE
                    #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oga_file ",
                    LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                " WHERE oga01='",g_omb[l_ac].omb31,"' ",
                                "   AND oga00 IN ('1','4','5','6','B')"     #MOD-A50108 add B
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                    PREPARE sel_oga_pre1 FROM l_sql
                    EXECUTE sel_oga_pre1 INTO g_oga.*
                 END IF   #FUN-960140 
                 IF STATUS THEN                                              #產生錯誤,所以要mark掉
                    CALL cl_err3("sel","oga_file",g_omb[l_ac].omb31,"",STATUS,"","sel oga",1)  #No.FUN-660116
                    NEXT FIELD omb31
                 END IF
                 IF g_oga.ogaconf = 'N' OR g_oga.ogapost = 'N' THEN
                    CALL cl_err('','axm-206',0) NEXT FIELD omb31     #No.TQC-740129
                 END IF
                 IF g_oga.oga65 ='Y' THEN
                    CALL cl_err('','axr-952',0) NEXT FIELD omb31 
                 END IF
                 IF g_oga.oga08 != g_oma.oma08 THEN      #國內外不符
                    CALL cl_err('sel oga','axr-125',0) NEXT FIELD omb31
                 END IF
                 IF g_oga.oga03 != g_oma.oma03 THEN      #客戶不符
                    CALL cl_err('sel oga','axr-138',0)    #MOD-5B0006
                 END IF
                 #檢查帳款客戶
                 IF g_oga.oga18 IS NOT NULL AND g_oga.oga18 != g_oma.oma68 THEN
                    CALL cl_err("","axr-602",1)
                    NEXT FIELD omb31 
                 END IF
                 IF g_oga.oga21 != g_oma.oma21 THEN      #稅別不符
                    CALL cl_err('sel oga','axr-142',0) NEXT FIELD omb31
                 END IF
                 IF g_oga.oga23 != g_oma.oma23 THEN      #幣別不符
                    CALL cl_err('sel oga','axr-144',0) NEXT FIELD omb31
                 END IF
              ELSE
                 IF g_omb[l_ac].omb38 = '3' OR g_omb[l_ac].omb38 ='5' THEN #FUN-670026--add
                    #判斷方式與"折讓"類型相同
                    #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oha_file ",
                    LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                " WHERE oha01='",g_omb[l_ac].omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                    PREPARE sel_oha_pre FROM l_sql
                    EXECUTE sel_oha_pre INTO g_oha.*
                    IF STATUS THEN
                       CALL cl_err3("sel","oha_file",g_omb[l_ac].omb31,"",STATUS,"","sel oha",1)  #No.FUN-660116
                       NEXT FIELD omb31
                    END IF
                    IF g_oha.oha09 NOT MATCHES '[145]' THEN   
                       CALL cl_err('','axr-191',0) NEXT FIELD omb31
                    END IF
                    IF g_oha.ohaconf = 'N' THEN
                       CALL cl_err('','axr-194',0) NEXT FIELD omb31
                    END IF
                   #No.+249 010621 by plum 銷退單要已扣帳才可立待抵
                    IF g_oha.ohapost = 'N' THEN
                       CALL cl_err('','axm-299',0) NEXT FIELD omb31
                    END IF
                    IF g_oha.oha08 != g_oma.oma08 THEN      #國內外不符
                       CALL cl_err('sel oha','axr-125',0) NEXT FIELD omb31
                    END IF
                    IF g_oha.oha03 != g_oma.oma03 THEN      #客戶不符
                       CALL cl_err('sel oha','axr-138',0)    #MOD-5B0006
                    END IF
                    IF g_aza.aza50='Y' THEN         #MOD-950311
                    IF g_oha.oha1001 != g_oma.oma68 AND g_oha.oha1001 IS NOT NULL THEN
                       CALL cl_err("","axr-603",1)
                       NEXT FIELD omb31
                    END IF
                    END IF                          #MOD-950311
                    IF g_oha.oha21 != g_oma.oma21 THEN      #稅別不符
                       CALL cl_err('sel oha','axr-142',0) NEXT FIELD omb31
                    END IF
                    IF g_oha.oha23 != g_oma.oma23 THEN      #幣別不符
                       CALL cl_err('sel oha','axr-144',0) NEXT FIELD omb31
                    END IF
                 END IF     
              END IF  #FUN-670026--add
           END IF
           IF g_oma.oma00 = '12' THEN 
              LET l_oga02 = '' 
              LET l_oga07 = ''   #MOD-760086
              IF NOT cl_null(g_omb[l_ac].omb44) THEN  #No.FUN-9C0014
                 #LET l_sql = "SELECT oga02,oga07 FROM ",li_dbs CLIPPED,"oga_file ",
                 LET l_sql = "SELECT oga02,oga07 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                             " WHERE oga01 = '",g_omb[l_ac].omb31,"' ",
                             "   AND ogaplant = '",g_omb[l_ac].omb44,"' " #No.FUN-9C0014
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
                 PREPARE sel_oga02_pre FROM l_sql
                 EXECUTE sel_oga02_pre INTO l_oga02,l_oga07
              ELSE 
                 #LET l_sql = "SELECT oga02,oga07 FROM ",li_dbs CLIPPED,"oga_file ",
                 LET l_sql = "SELECT oga02,oga07 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                             " WHERE oga01 = '",g_omb[l_ac].omb31,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                 PREPARE sel_oga02_pre1 FROM l_sql
                 EXECUTE sel_oga02_pre1 INTO l_oga02,l_oga07
              END IF   #FUN-960140 
              IF l_oga02 > g_oma.oma02 THEN
                 CALL cl_err(l_oga02,'axr-297',0)
                 NEXT FIELD omb31
              END IF
              IF l_oga07 <> 'Y' THEN   #MOD-760086
                 IF YEAR(l_oga02) <> YEAR(g_oma.oma02) OR
                    MONTH(l_oga02) <> MONTH(g_oma.oma02) THEN
                    CALL cl_err(l_oga02,'axr-299',0)
                    NEXT FIELD omb31
                 END IF
              ELSE
                 IF (YEAR(l_oga02) > YEAR(g_oma.oma02)) OR
                    (YEAR(l_oga02) = YEAR(g_oma.oma02) AND
                    MONTH(l_oga02) > MONTH(g_oma.oma02)) THEN
                    CALL cl_err(l_oga02,'axr-299',0)
                    NEXT FIELD omb31
                 END IF
              END IF
           END IF
           IF g_omb[l_ac].omb38 = '3' THEN  #No.MOD-8B0127   
              LET l_oha02 = ''
              #LET l_sql = "SELECT oha02 FROM ",li_dbs CLIPPED,"oha_file ",
              LET l_sql = "SELECT oha02 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                          " WHERE oha01 = '",g_omb[l_ac].omb31,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
              PREPARE sel_oha02_pre FROM l_sql
              EXECUTE sel_oha02_pre INTO l_oha02
              IF l_oha02 > g_oma.oma02 THEN
                 CALL cl_err(l_oha02,'axr-296',0)
                 NEXT FIELD omb31
              END IF
              IF (YEAR(l_oha02) > YEAR(g_oma.oma02)) OR
                 (YEAR(l_oha02) = YEAR(g_oma.oma02) AND
                 MONTH(l_oha02) > MONTH(g_oma.oma02)) THEN
                 CALL cl_err(l_oha02,'axr-298',0)
                 NEXT FIELD omb31
              END IF
           END IF 
           IF (g_oma.oma00='21' OR g_oma.oma00='22') AND NOT cl_null(g_omb[l_ac].omb31) THEN   #MOD-710157
              IF NOT cl_null(g_omb[l_ac].omb44) THEN #No.FUN-9C0014
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oha_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             " WHERE oha01='",g_omb[l_ac].omb31,"' ",
                             "   AND ohaplant = '",g_omb[l_ac].omb44,"' " #No.FUN-9C0014
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                 PREPARE sel_oha_pre1 FROM l_sql
                 EXECUTE sel_oha_pre1 INTO g_oha.*
              ELSE
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oha_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             " WHERE oha01='",g_omb[l_ac].omb31,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                 PREPARE sel_oha_pre2 FROM l_sql
                 EXECUTE sel_oha_pre2 INTO g_oha.*
              END IF    #FUN-960140
              IF STATUS THEN
                 CALL cl_err3("sel","oha_file",g_omb[l_ac].omb31,"",STATUS,"","sel oha",1)  #No.FUN-660116
                 NEXT FIELD omb31
              END IF
             #TQC-A50118-Add--Begin 
             IF g_oma.oma00='21' THEN
                IF g_oha.oha09 MATCHES '[236]' THEN
                   CALL cl_err(g_omb[l_ac].omb31,'aap-191',1)
                   NEXT FIELD omb31
                END IF
             END IF
             #TQC-A50118-Add--End
              IF g_oha.ohaconf = 'N' THEN
                 CALL cl_err('','axr-194',0) NEXT FIELD omb31
              END IF
              IF g_oha.ohapost = 'N' THEN
                 CALL cl_err('','axm-299',0) NEXT FIELD omb31
              END IF
              IF g_oha.oha08 != g_oma.oma08 THEN      #國內外不符
                 CALL cl_err('sel oha','axr-125',0) NEXT FIELD omb31
              END IF
              IF g_oha.oha03 != g_oma.oma03 THEN      #客戶不符
                 CALL cl_err('sel oha','axr-138',0)    #MOD-5B0006
              END IF
              IF g_aza.aza50='Y' THEN         #MOD-950311
              IF g_oha.oha1001 != g_oma.oma68 AND g_oha.oha1001 IS NOT NULL THEN
                 CALL cl_err("","axr-603",1)
                 NEXT FIELD omb31
              END IF
              END IF                          #MOD-950311
              IF g_oha.oha21 != g_oma.oma21 THEN      #稅別不符
                 CALL cl_err('sel oha','axr-142',0) NEXT FIELD omb31
              END IF
              IF g_oha.oha23 != g_oma.oma23 THEN      #幣別不符
                 CALL cl_err('sel oha','axr-144',0) NEXT FIELD omb31
              END IF
           END IF
## No.2682 modify 1998/10/29 檢查單身每筆資料原發票的資料,
##-----------客戶,稅別,幣別,匯率要一致
           IF g_oma.oma00='25' AND NOT cl_null(g_omb[l_ac].omb31) THEN
              LET l_flag = 'Y'
              IF l_ac > 1 THEN
                 DECLARE t300_oma24 CURSOR FOR
                 SELECT oma24 FROM oma_file   #此張發票之匯率
                  WHERE oma16 = g_omb[l_ac].omb31
                    AND oma00 MATCHES '1*'
                 FOREACH t300_oma24 INTO l_oma24
                     EXIT FOREACH
                 END FOREACH
                 FOR l_i = 1 TO l_ac-1
                     DECLARE t300_oma24_2 CURSOR FOR
                      SELECT oma24 FROM oma_file #與前面之發票比較
                       WHERE oma16 = g_omb[l_i].omb31
                         AND oma00 MATCHES '1*'
                     FOREACH t300_oma24_2 INTO l_oma24_b
                        EXIT FOREACH
                     END FOREACH
                     IF l_oma24_b IS NOT NULL AND
                        l_oma24 != l_oma24_b THEN   #若不相同
                        CALL cl_getmsg('axr-300',g_lang) RETURNING l_str1
                        ERROR l_str1
                        EXIT FOR
                        LET l_flag = 'N'
                     END IF
                 END FOR
                 IF l_flag = 'N' THEN
                    NEXT FIELD omb31
                 END IF
              END IF
              LET g_cnt=0
              SELECT COUNT(*) INTO g_cnt FROM oma_file
               WHERE oma16 = g_omb[l_ac].omb31    #原發票 #modi by canny(7/7)
                 AND oma23 = g_oma.oma23          #幣別
                 AND oma03 = g_oma.oma03          #客戶
                 AND oma21 = g_oma.oma21          #稅別
                 AND oma00 MATCHES '1*'
              IF g_cnt = 0 THEN   #與原發票資料不同
                 CALL cl_getmsg('axr-301',g_lang) RETURNING l_str2
                 ERROR l_str2
                 NEXT FIELD omb31
              END IF
           END IF
           IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
              FOR l_i = 1 TO g_rec_b
                IF p_cmd ='a' AND g_omb[l_ac].omb31 = g_omb[l_i].omb31 AND l_i<>l_ac THEN
                         CALL cl_err('','axr-615',0)
                         NEXT FIELD omb31
                END IF
              END FOR
           END IF
           IF p_cmd ='a' AND g_azw.azw04 = '2' AND g_oma.oma00='12'
                 AND NOT cl_null(g_omb[l_ac].omb31) THEN
              IF NOT cl_confirm('axr-613') THEN
                 LET g_omb[l_ac].omb31 = ''
                 NEXT FIELD omb31
              ELSE
                 CALL t300_omb31_takeb()
                 #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                 LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                             "   SET oga10 = '",g_oma.oma01,"' ",
                             " WHERE oga01 = '",g_omb[l_ac].omb31,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
                 PREPARE upd_oga_pre1 FROM l_sql
                 EXECUTE upd_oga_pre1
                 IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                     CALL cl_err3("upd","oga_file",g_omb[l_ac].omb31,"",SQLCA.SQLCODE,"","update oga_file",1)
                     LET g_success = 'N'
                 END IF
                 CALL t300_b_fill(g_wc2) 
                 CALL t300_b()
                 EXIT INPUT
               END IF
           END IF
           CALL t300_set_entry_b()   #MOD-830082
           CALL t300_set_no_entry_b(p_cmd)   #FUN-960140
              IF cl_null(g_omb[l_ac].omb32) THEN                                                                                    
                 NEXT FIELD omb32                                                                                                   
              END IF
            #str------ add by dengsy170629
                 IF NOT cl_null(g_omb[l_ac].omb04) THEN 
                    LET l_ima08=NULL 
                    LET l_count4=0
                    LET l_count5=0
                    LET l_omb33=NULL 
                    SELECT ima08 INTO l_ima08 FROM ima_file
                        WHERE ima01=g_omb[l_ac].omb04
                    SELECT count(*) INTO l_count4 FROM tc_ool_file
                    WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count4>0 THEN 
                    IF g_aza.aza63 = 'Y' THEN
                        SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    ELSE 
                        SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    END IF 
                ELSE 
                    SELECT count(*) INTO l_count5 FROM tc_ool_file
                    WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count5>0 THEN 
                        IF g_aza.aza63 = 'Y' THEN
                            SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                                WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        ELSE 
                            SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                            WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        END IF
                    END IF 
                END IF 
            END IF 
            IF NOT cl_null(l_omb33) THEN 
                LET g_omb[l_ac].omb33=l_omb33
            END IF 
            DISPLAY BY NAME g_omb[l_ac].omb33
     
            #end------ add by dengsy170629
              
        AFTER FIELD omb32
            IF NOT cl_null(g_omb[l_ac].omb31) THEN
               IF cl_null(g_omb[l_ac].omb32) THEN
                  NEXT FIELD omb32
               END IF
            END IF
          #IF g_oma.oma00='11' AND NOT cl_null(g_omb[l_ac].omb32) THEN                         #CHI-A50040 mark
           IF (g_oma.oma00='11' OR g_oma.oma00='13') AND NOT cl_null(g_omb[l_ac].omb32) THEN   #CHI-A50040
              #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"oeb_file ",
              LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                          " WHERE oeb01='",g_omb[l_ac].omb31,"' ",
                          "   AND oeb03='",g_omb[l_ac].omb32,"' ",
                          "   AND oeb1003 != '2' AND oeb1012 != 'Y' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
              PREPARE sel_oeb_pre FROM l_sql
              EXECUTE sel_oeb_pre INTO g_oeb.*
              IF STATUS THEN 
                 CALL cl_err3("sel","oeb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,STATUS,"","sel oeb",1)  #No.FUN-660116
                 NEXT FIELD omb32
              END IF
              IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                           OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                #CALL t300_g_b1_detail() CALL t300_b_move_to()     #CHI-A50040 mark
                #-CHI-A50040-add-
                 IF g_oma.oma00='11' THEN     
                    CALL t300_g_b1_detail() 
                 END IF                      
                 IF g_oma.oma00='13' THEN                                                                       
                    CALL t300_g_b3_detail()                                                                     
                 END IF                      
                 LET b_omb.omb03 = g_omb[l_ac].omb03
                 CALL t300_b_move_to()
                #-CHI-A50040-end-
              END IF
           END IF
          #IF (g_oma.oma00='12' OR g_oma.oma00='13') AND   #CHI-A50040 mark
           IF g_oma.oma00='12'  AND                        #CHI-A50040
              NOT cl_null(g_omb[l_ac].omb32) THEN
           #增加判斷條件omb38的情況
              IF g_omb[l_ac].omb32 >= 9001 THEN
                 LET g_omb[l_ac].omb38 = '4'
              END IF
              IF g_omb[l_ac].omb38 = '2' THEN  #FUN-670026 --add
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ogb_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                             " WHERE ogb01='",g_omb[l_ac].omb31,"' ",
                             "   AND ogb03='",g_omb[l_ac].omb32,"' ",
                             "   AND ogb1005 != '2' "
                  CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
                 PREPARE sel_ogb_pre2 FROM l_sql
                 EXECUTE sel_ogb_pre2 INTO g_ogb.*
                 IF STATUS THEN 
                    CALL cl_err3("sel","ogb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,STATUS,"","sel ogb",1)  #No.FUN-660116
                    NEXT FIELD omb32
                 END IF
                 IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60-g_ogb.ogb64))   #FUN-560070
                 THEN   CALL cl_err('sel ogb','axr-148',0) NEXT FIELD omb32
                 END IF
                 IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                              OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                    IF g_oma.oma00='12' THEN     #No.TQC-690110 add
                       CALL t300_g_b2_detail()
                    END IF                       #No.TQC-690110 add 
                   #IF g_oma.oma00='13' THEN     #No.TQC-690110 add   #CHI-A50040 mark                                                                 
                   #   CALL t300_g_b3_detail()   #No.TQC-690110 add   #CHI-A50040 mark                                                                  
                   #END IF                       #No.TQC-690110 add   #CHI-A50040 mark
                    LET b_omb.omb03 = g_omb[l_ac].omb03
                    CALL t300_b_move_to()
                 END IF
                 #檢查此項是否有可轉應收余額
                 IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60+g_ogb.ogb64)) THEN  #FUN-670026 --add
                    CALL cl_err('sel ogb','axr-148',0) NEXT FIELD omb32                  #FUN-670026 --add
                 END IF                                                                  #FUN-670026 --add
              END IF
              IF g_omb[l_ac].omb38 = '4' THEN
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ogb_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                             " WHERE ogb01='",g_omb[l_ac].omb31,"' ",
                             "   AND ogb03='",g_omb[l_ac].omb32,"' ",
                             "   AND ogb1005 = '2' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                 PREPARE sel_ogb_pre3 FROM l_sql
                 EXECUTE sel_ogb_pre3 INTO g_ogb.*
                 IF SQLCA.sqlcode AND SQLCA.sqlcode !=100 THEN 
                    CALL cl_err3("sel","ogb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,SQLCA.sqlcode,"","sel ogb",1)  #No.FUN-660116
                    NEXT FIELD omb32
                 END IF
                 IF SQLCA.sqlcode = 100 THEN
                    CALL cl_err3("sel","ogb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,"axr-606","","sel ogb",1) #No.FUN-670026 --add
                 END IF
                 IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60-g_ogb.ogb64))   #FUN-560070
                 THEN   CALL cl_err('sel ogb','axr-148',0) NEXT FIELD omb32
                 END IF
                 IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                              OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                     CALL t300_g_b2_detail_1()
                     LET b_omb.omb03 = g_omb[l_ac].omb03
                     CALL t300_b_move_to()
                 END IF
                 #LET l_sql = "SELECT SUM(ohb14) FROM ",li_dbs CLIPPED,"oha_file,",
                 #                                      li_dbs CLIPPED,"ohb_file ", 
                 LET l_sql = "SELECT SUM(ohb14) FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                                       cl_get_target_table(g_plant_new,'ohb_file'),     #FUN-A50102
                             " WHERE oha01=ohb01 AND oha09='3' ",
                             "   AND ohb31='",g_ogb.ogb01,"' ",
                             "   AND ohb32='",g_ogb.ogb03,"' ",
                             "   AND ohaconf = 'Y' AND ohapost = 'Y'"
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                 PREPARE sel_ohb14_pre1 FROM l_sql
                 EXECUTE sel_ohb14_pre1 INTO g_ohb14_ret 
                 IF SQLCA.sqlcode THEN
                    CALL cl_err3("sel","oha_file,ohb_file",g_ogb.ogb01,g_ogb.ogb03,SQLCA.sqlcode,"","",1)
                 END IF
                 IF g_oma.oma00='12' AND (g_ogb.ogb14<=(g_ogb.ogb1013+g_ohb14_ret)) THEN
                    CALL cl_err("","axr-607",1)
                    NEXT FIELD omb32
                 END IF
              END IF
              IF g_omb[l_ac].omb38 = '3' THEN
                 #LET l_sql = "SELECT *  FROM ",li_dbs CLIPPED,"ohb_file",
                 LET l_sql = "SELECT *  FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                             " WHERE ohb01='",g_omb[l_ac].omb31,"' AND ohb03='",g_omb[l_ac].omb32,"' ",
                             "   AND ohb1005 !='2' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
                 PREPARE sel_ohb_pre FROM l_sql
                 EXECUTE sel_ohb_pre INTO g_ohb.*
                 IF STATUS THEN
                    CALL cl_err3("sel","ohb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,STATUS,"","sel ohb",1)  #No.FUN-660116
                    NEXT FIELD omb32
                 END IF
                 #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
                 LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             " WHERE oha01='",g_omb[l_ac].omb31,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                 PREPARE sel_oha09_pre2 FROM l_sql
                 EXECUTE sel_oha09_pre2 INTO l_oha09
                 IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
                #-MOD-A80073-add-
                 LET l_cnt = 0 
                 SELECT count(*) INTO l_cnt
                   FROM omb_file
                  WHERE omb01 <> g_oma.oma01 AND omb31 = g_omb[l_ac].omb31 
                    AND omb32 = g_omb[l_ac].omb32
                #-MOD-A80073-end-
                 IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                              OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                    SELECT abs(SUM(omb12)) INTO l_omb12 FROM oma_file,omb_file
                     WHERE oma01=omb01 AND omavoid='N'
                       AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
                       AND omb44=g_omb[l_ac].omb44   #FUN-9C0013 add
                    IF cl_null(l_omb12) THEN LET l_omb12=0 END IF
                   #IF l_oha09!='5' THEN   #MOD-940155 add                                                #MOD-A80073 mark
                   #   IF l_omb12 = g_ohb.ohb12 THEN                                                      #MOD-A80073 mark
                    IF (l_oha09 = '5' AND l_cnt > 0) OR (l_oha09!='5' AND l_omb12 = g_ohb.ohb12) THEN     #MOD-A80073  
                          CALL cl_err("","axr-390",1)
                          NEXT FIELD omb32
                      #END IF                                                                             #MOD-A80073 mark
                    END IF                 #MOD-940155 add
                 END IF
                #選擇的銷退單其銷退方式為5.折讓時,金額直接帶銷退單的金額
                 IF l_oha09 = '5' THEN
                    LET g_omb[l_ac].omb14 = g_ohb.ohb14 * -1
                    LET g_omb[l_ac].omb14t= g_ohb.ohb14t* -1
                 END IF
                 CALL t300_chk_ohb(p_cmd)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_msg1,g_errno,0)
                    IF p_cmd='a' THEN
                       LET g_omb[l_ac].omb32=g_omb_t.omb32
                       DISPLAY g_omb[l_ac].omb32  TO omb32
                       IF g_flag='N' THEN NEXT FIELD omb32 END IF
                    ELSE
                       IF g_flag='N' THEN
                          IF cl_confirm('axr-273') THEN
                             IF l_oha09='5' THEN       #MOD-940155
                                NEXT FIELD omb13
                             ELSE
                                NEXT FIELD omb12
                             END IF
                          END IF
                       END IF
                    END IF
                  END IF
                 IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                              OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                    CALL t300_g_b4_detail()
                    LET b_omb.omb03 = g_omb[l_ac].omb03   #plum 010621 add
                    CALL t300_b_move_to()
                 END IF
 
              END IF
              IF g_omb[l_ac].omb38 ='5' THEN
                 #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ohb_file ",
                 LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                             " WHERE ohb01='",g_omb[l_ac].omb31,"' ",
                             "   AND ohb03='",g_omb[l_ac].omb32,"' ",
                             "   AND ohb1005='2'"
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                 PREPARE sel_ohb_pre1 FROM l_sql
                 EXECUTE sel_ohb_pre1 INTO g_ohb.*
                 IF SQLCA.sqlcode AND SQLCA.sqlcode !=100 THEN
                    CALL cl_err3("sel","ohb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,SQLCA.sqlcode,"","sel ohb",1)  #No.FUN-660116
                    NEXT FIELD omb32
                 END IF
                 IF SQLCA.sqlcode = 100 THEN
                    CALL cl_err3("sel","ohb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,"axr-606","","sel ohb",1) #No.FUN-670026
                    NEXT FIELD omb32
                 END IF
                 CALL t300_chk_ohb_1(p_cmd)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_msg1,g_errno,0)
                    IF p_cmd='a' THEN
                       LET g_omb[l_ac].omb32=g_omb_t.omb32
                       DISPLAY g_omb[l_ac].omb32  TO omb32
                       IF g_flag='N' THEN NEXT FIELD omb32 END IF
                    ELSE
                       IF g_flag='N' THEN
                          IF cl_confirm("axr-609") THEN
                             NEXT FIELD omb14
                          END IF
                       END IF
                    END IF
                 END IF
                 IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                              OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                    CALL t300_g_b4_detail_1()
                    LET b_omb.omb03 = g_omb[l_ac].omb03   #plum 010621 add
                    CALL t300_b_move_to()
                 END IF
              END IF
           END IF
           IF (g_oma.oma00='21' OR g_oma.oma00 ='22') AND NOT cl_null(g_omb[l_ac].omb32) THEN   #MOD-710157
              #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ohb_file ",
              LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                          " WHERE ohb01='",g_omb[l_ac].omb31,"' AND ohb03='",g_omb[l_ac].omb32,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
            # PREPARE sel_ohb_pre2 FROM l_sql          #FUN-810070 mark
            # EXECUTE sel_ohb_pre2 INTO g_ohb.*        #FUN-810070 mark
              PREPARE sel_ohb_pre3 FROM l_sql          #FUN-810070
              EXECUTE sel_ohb_pre3 INTO g_ohb.*        #FUN-810070 
              IF STATUS THEN
                 CALL cl_err3("sel","ohb_file",g_omb[l_ac].omb31,g_omb[l_ac].omb32,STATUS,"","sel ohb",1)  #No.FUN-660116
                 NEXT FIELD omb32
              END IF
              #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file",
              LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                          " WHERE oha01='",g_omb[l_ac].omb31,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
              PREPARE sel_oha09_pre5 FROM l_sql
              EXECUTE sel_oha09_pre5 INTO l_oha09
              IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
	     #-MOD-A80073-add-
	      LET l_cnt = 0 
	      SELECT count(*) INTO l_cnt
	        FROM omb_file
	       WHERE omb01 <> g_oma.oma01 AND omb31 = g_omb[l_ac].omb31 
	         AND omb32 = g_omb[l_ac].omb32
	     #-MOD-A80073-end-
              IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                           OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                 SELECT abs(SUM(omb12)) INTO l_omb12 FROM oma_file,omb_file
                  WHERE oma01=omb01 AND omavoid='N'
                    AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
                    AND omb44=g_omb[l_ac].omb44  #FUN-9C0013
                 IF cl_null(l_omb12) THEN LET l_omb12=0 END IF
                #IF l_oha09!='5' THEN   #MOD-940155 add                                                #MOD-A80073 mark
                #   IF l_omb12 = g_ohb.ohb12 THEN                                                      #MOD-A80073 mark
                 IF (l_oha09 = '5' AND l_cnt > 0) OR (l_oha09!='5' AND l_omb12 = g_ohb.ohb12) THEN     #MOD-A80073  
                       CALL cl_err("","axr-390",1)
                       NEXT FIELD omb32
                   #END IF                                                                             #MOD-A80073 mark
                 END IF                 #MOD-940155 add
              END IF
              IF g_oma.oma00='21' AND NOT cl_null(g_omb[l_ac].omb32) THEN
                 CALL t300_chk_ohb(p_cmd)
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_msg1,g_errno,0)
                    IF p_cmd='a' THEN
                       LET g_omb[l_ac].omb32=g_omb_t.omb32
                       DISPLAY g_omb[l_ac].omb32  TO omb32
                       IF g_flag='N' THEN NEXT FIELD omb32 END IF
                    ELSE
                       IF g_flag='N' THEN
                          IF cl_confirm('axr-273') THEN
                             IF l_oha09='5' THEN       #MOD-940155
                                NEXT FIELD omb13
                             ELSE
                                NEXT FIELD omb12
                             END IF
                          END IF
                       END IF
                    END IF
                 END IF
              END IF
              IF p_cmd='a' OR g_omb[l_ac].omb31!=g_omb_t.omb31
                           OR g_omb[l_ac].omb32!=g_omb_t.omb32 THEN
                 CALL t300_g_b4_detail()
                 LET b_omb.omb03 = g_omb[l_ac].omb03   #plum 010621 add
                 CALL t300_b_move_to()
              END IF
           END IF
           #str------ add by dengsy170629
                 IF NOT cl_null(g_omb[l_ac].omb04) THEN 
                    LET l_ima08=NULL 
                    LET l_count4=0
                    LET l_count5=0
                    LET l_omb33=NULL 
                    SELECT ima08 INTO l_ima08 FROM ima_file
                        WHERE ima01=g_omb[l_ac].omb04
                    SELECT count(*) INTO l_count4 FROM tc_ool_file
                    WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count4>0 THEN 
                    IF g_aza.aza63 = 'Y' THEN
                        SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    ELSE 
                        SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    END IF 
                ELSE 
                    SELECT count(*) INTO l_count5 FROM tc_ool_file
                    WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count5>0 THEN 
                        IF g_aza.aza63 = 'Y' THEN
                            SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                                WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        ELSE 
                            SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                            WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        END IF
                    END IF 
                END IF 
            END IF 
            IF NOT cl_null(l_omb33) THEN 
                LET g_omb[l_ac].omb33=l_omb33
            END IF 
            DISPLAY BY NAME g_omb[l_ac].omb33
     
            #end------ add by dengsy170629
 
 
        AFTER FIELD omb04
           IF NOT cl_null(g_omb[l_ac].omb04) THEN
               LET g_plant_new = g_omb[l_ac].omb44
                #CALL s_gettrandbs()
                #LET li_dbs = g_dbs_tra
                IF g_omb[l_ac].omb04[1,4]!='MISC' THEN   #TQC-750177
                   #LET l_sql = "SELECT  ima02,ima25 FROM ",li_dbs CLIPPED,"ima_file ",
                   LET l_sql = "SELECT  ima02,ima25 FROM ",cl_get_target_table(g_plant_new,'ima_file'), #FUN-A50102
                               " WHERE ima01 = '",g_omb[l_ac].omb04,"' "
                   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                   PREPARE ima_pre FROM l_sql
                   DECLARE ima_cs CURSOR FOR ima_pre
                   OPEN ima_cs
                   FETCH ima_cs INTO  g_msg,l_b2         #No.FUN-9C0014
                ELSE   #TQC-750177 begin
                   #LET l_sql = "SELECT ima02,ima25 FROM ",li_dbs CLIPPED,"ima_file ",
                   LET l_sql = "SELECT ima02,ima25 FROM ",cl_get_target_table(g_plant_new,'ima_file'), #FUN-A50102
                               " WHERE ima01 = 'MISC' "
                   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
                   PREPARE ima_pre1 FROM l_sql
                   DECLARE ima_cs1 CURSOR FOR ima_pre1
                   OPEN ima_cs1
                   FETCH ima_cs1 INTO g_msg,l_b2
                END IF #TQC-750177 end
                 IF STATUS THEN
                    CALL cl_err3("sel","ima_file",g_omb[l_ac].omb04,"",STATUS,"","sel ima",1)  #No.FUN-660116
                    NEXT FIELD omb04
                 END IF
                 IF g_omb[l_ac].omb04[1,4]!='MISC' THEN    #MOD-590116
                    LET g_omb[l_ac].omb06=g_msg    #TQC-750177
                    LET g_omb[l_ac].omb05=l_b2
                 ELSE
                     IF cl_null(g_omb[l_ac].omb06) THEN  #TQC-750177  #No.TQC-7B0043--(TQC-750177的mark是錯誤的)
                       LET g_omb[l_ac].omb06=g_msg    #TQC-750177
                     END IF                              #TQC-750177  #No.TQC-7B0043--(TQC-750177的mark是錯誤的)
                    IF cl_null(g_omb[l_ac].omb05) THEN
                       LET g_omb[l_ac].omb05=l_b2
                    END IF
                 END IF
               #str------ add by dengsy170629
                 IF NOT cl_null(g_omb[l_ac].omb04) THEN 
                    LET l_ima08=NULL 
                    LET l_count4=0
                    LET l_count5=0
                    LET l_omb33=NULL 
                    SELECT ima08 INTO l_ima08 FROM ima_file
                        WHERE ima01=g_omb[l_ac].omb04
                    SELECT count(*) INTO l_count4 FROM tc_ool_file
                    WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count4>0 THEN 
                    IF g_aza.aza63 = 'Y' THEN
                        SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    ELSE 
                        SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                        WHERE tc_ool03=g_omb[l_ac].omb04 AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    END IF 
                ELSE 
                    SELECT count(*) INTO l_count5 FROM tc_ool_file
                    WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                    IF l_count5>0 THEN 
                        IF g_aza.aza63 = 'Y' THEN
                            SELECT tc_ool111 INTO l_omb33 FROM tc_ool_file
                                WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        ELSE 
                            SELECT tc_ool11 INTO l_omb33 FROM tc_ool_file
                            WHERE tc_ool03='*' AND tc_ool04=l_ima08 AND tc_ool01=g_oma.oma13
                        END IF
                    END IF 
                END IF 
            END IF 
            IF NOT cl_null(l_omb33) THEN 
                LET g_omb[l_ac].omb33=l_omb33
            END IF 
            DISPLAY BY NAME g_omb[l_ac].omb33
     
            #end------ add by dengsy170629
           END IF
 
        AFTER FIELD omb05
           IF NOT cl_null(g_omb[l_ac].omb05) THEN
              LET g_plant_new = g_omb[l_ac].omb44
              #CALL s_gettrandbs()
              #LET li_dbs = g_dbs_tra
              #LET l_sql = "SELECT gfe01 FROM ",li_dbs CLIPPED,"gfe_file ",
              LET l_sql = "SELECT gfe01 FROM ",cl_get_target_table(g_plant_new,'gfe_file'), #FUN-A50102
                          " WHERE gfe01 = '",g_omb[l_ac].omb05,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
              PREPARE gfe_pre FROM l_sql
              DECLARE gfe_cs CURSOR FOR gfe_pre
              OPEN gfe_cs
              FETCH gfe_cs INTO g_chr
              IF STATUS THEN CALL cl_err('',STATUS,0) NEXT FIELD omb05 END IF
           END IF
 
        AFTER FIELD omb12
           IF NOT cl_null(g_omb[l_ac].omb12) THEN
              IF (p_cmd='a' OR g_omb_t.omb12 IS NULL) OR
                 (p_cmd='u' OR g_omb_t.omb12 != g_omb[l_ac].omb12) THEN
                 CASE g_omb[l_ac].omb38
                   WHEN '1'
                     IF g_omb[l_ac].omb12<0 THEN
                        CALL cl_err("","axr-610",1) 
                        NEXT FIELD omb12
                     END IF
                   WHEN '2'
                     IF g_omb[l_ac].omb12<0 THEN
                        CALL cl_err("","axr-610",1) 
                        NEXT FIELD omb12
                     END IF
                   WHEN '3'
                     IF g_oma.oma00 MATCHES '1*' THEN
                        IF g_omb[l_ac].omb12 > 0 THEN 
                           CALL cl_err("","axr-611",1)
                           NEXT FIELD omb12
                        END IF 
                     ELSE
                        IF g_omb[l_ac].omb12 < 0 THEN 
                           CALL cl_err("","axr-610",1)
                           NEXT FIELD omb12
                        END IF 
                     END IF
                   OTHERWISE EXIT CASE
                 END CASE 
                #IF g_oma.oma00 = '11' THEN                         #CHI-A50040 mark
                 IF g_oma.oma00 = '11' OR g_oma.oma00 = '13' THEN   #CHI-A50040
                    #LET l_sql="SELECT oeb12 FROM ",li_dbs CLIPPED,"oeb_file,",li_dbs CLIPPED,"oea_file",
                    LET l_sql="SELECT oeb12 FROM ",cl_get_target_table(g_plant_new,'oeb_file'),",", #FUN-A50102
                                                   cl_get_target_table(g_plant_new,'oea_file'),     #FUN-A50102
                              " WHERE oea00='1' AND oea01=oeb01",
                              "   AND oeaconf='Y' ",
                              "   AND oeb01='",g_omb[l_ac].omb31,"' ",
                              "   AND oeb03='",g_omb[l_ac].omb32,"' " 
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102           
                    PREPARE sel_oeb12_pre FROM l_sql
                    EXECUTE sel_oeb12_pre INTO l_qty 
                     IF SQLCA.sqlcode THEN
                        CALL cl_err("",SQLCA.sqlcode,1)
                        NEXT FIELD omb12
                     END IF                
                     IF l_qty != g_omb[l_ac].omb12 THEN
                        IF g_oma.oma00 = '11' THEN        #CHI-A50040 
                           CALL cl_err("","axr-123",1)
                        ELSE                              #CHI-A50040
                           CALL cl_err("","axr-124",1)    #CHI-A50040
                        END IF                            #CHI-A50040
                        LET g_omb[l_ac].omb12 = l_qty
                        NEXT FIELD omb12
                     END IF
                 END IF
                #-CHI-A50040-mark-
                #IF g_oma.oma00 = '13' THEN
                #   LET l_sql = "SELECT ogb917 FROM ",li_dbs CLIPPED,"ogb_file,",li_dbs CLIPPED,"oga_file ",
                #               " WHERE ogb01 = '",g_omb[l_ac].omb31,"' ",
                #               "   AND ogb01 = oga01 AND oga00 IN ('1','4','5','6','B') ", #MOD-A50108 add B
                #               "   AND ogaconf = 'Y' AND oga09 IN ('2','3') ",
                #               "   AND ogapost = 'Y' AND ogb03 = '",g_omb[l_ac].omb32,"' "
                #   PREPARE sel_ogb917_pre FROM l_sql
                #   EXECUTE sel_ogb917_pre INTO l_qty
                #    IF SQLCA.sqlcode THEN
                #       CALL cl_err("",SQLCA.sqlcode,1)
                #       NEXT FIELD omb12
                #    END IF  
                #    IF l_qty != g_omb[l_ac].omb12 THEN
                #       CALL cl_err("","axr-124",1)
                #       LET g_omb[l_ac].omb12 = l_qty
                #       NEXT FIELD omb12
                #    END IF                                        
                #END IF
                #-CHI-A50040-mark-
                 IF g_oma.oma00 = '12' THEN     #No.TQC-690110 add
                    IF g_omb[l_ac].omb38 ='2' THEN      #No.TQC-790152
                       SELECT abs(SUM(omb12)) INTO l_qty FROM omb_file,oma_file  #No.TQC-740350
                        WHERE oma00='12'
                          AND oma01=omb01
                          AND omavoid='N'
                          AND omb31=g_ogb.ogb01
                          AND omb32=g_ogb.ogb03
                          AND omb44=g_omb[l_ac].omb44   #FUN-9C0013 

                       IF cl_null(l_qty) THEN LET l_qty=0 END IF
                       LET l_qty=(l_qty-abs(g_omb_t.omb12)+abs(g_omb[l_ac].omb12))-  #No.TQC-740350
                                 (g_ogb.ogb917-g_ogb.ogb64)    #FUN-560070
                    END IF                             #No.TQC-790152
                    IF g_omb[l_ac].omb38 = '3' THEN
                       SELECT abs(SUM(omb12)) INTO l_qty FROM omb_file,oma_file  #No.TQC-740350
                        WHERE oma00='12'
                          AND oma01=omb01
                          AND omavoid='N'
                          AND omb31=g_ohb.ohb01
                          AND omb32=g_ohb.ohb03
                          AND omb44=g_omb[l_ac].omb44    #FUN-9C0013    
                       IF cl_null(l_qty) THEN LET l_qty=0 END IF
                       LET l_qty=(l_qty-abs(g_omb_t.omb12)+abs(g_omb[l_ac].omb12))-
                                 g_ohb.ohb917 
                    END IF 
                    IF l_qty > 0 THEN
                        CALL cl_err('','axr-126',0) NEXT FIELD omb12
                    END IF
                 END IF                          #No.TQC-690110 add
              END IF
              IF g_oma.oma00='21' AND NOT cl_null(g_omb[l_ac].omb31) THEN
                 CALL t300_chk_ohb('b')
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err(g_msg1,g_errno,0)
                    #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file",
                    LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                " WHERE oha01='",g_omb[l_ac].omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
                    PREPARE sel_oha09_pre6 FROM l_sql
                    EXECUTE sel_oha09_pre6 INTO l_oha09
                    IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
                    IF p_cmd='a' THEN
                       IF l_oha09 !='5' THEN       #MOD-940155
                          LET g_omb[l_ac].omb12=g_ohb.ohb917 -    #FUN-560070
                                                g_omb12 - g_omb12_n - g_omb12_b
                          IF cl_null(g_omb[l_ac].omb12) OR g_omb[l_ac].omb12 <0 THEN
                             LET g_omb[l_ac].omb12 = 0
                          END IF
                          DISPLAY g_omb[l_ac].omb12 TO omb12
                          IF g_flag='N' THEN NEXT FIELD omb12 END IF
                       ELSE
                          LET g_omb[l_ac].omb12=g_omb_t.omb12
                          DISPLAY g_omb[l_ac].omb12 TO omb12
                       END IF
                    ELSE
                       IF l_oha09 !='5' AND g_flag='N' THEN       #MOD-940155
                          LET g_omb[l_ac].omb12=g_omb_t.omb12
                          DISPLAY g_omb[l_ac].omb12 TO omb12
                          NEXT FIELD omb12
                       END IF
                    END IF
                 END IF
              END IF
           END IF
          #No:8519 順便改,修改完數量,應該再算一次金額
           LET b_omb.omb12 = g_omb[l_ac].omb12
           LET b_omb.omb13 = g_omb[l_ac].omb13
           #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
           LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                       " WHERE oha01='",g_omb[l_ac].omb31,"' "
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
           PREPARE sel_oha09_pre7 FROM l_sql
           EXECUTE sel_oha09_pre7 INTO l_oha09
           IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
           IF g_omb[l_ac].omb39 !='Y' AND g_omb[l_ac].omb38 !='4' AND
              g_omb[l_ac].omb38 !='5' THEN
              IF b_omb.omb12 > 0 OR b_omb.omb12 < 0 THEN
                 IF g_oma.oma213 = 'N' THEN
                    IF l_oha09 != '5' THEN   #MOD-890215 add
                       LET b_omb.omb14 =b_omb.omb12*b_omb.omb13 
                       CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
                       CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                    END IF                   #MOD-890215 add
                 ELSE
                    IF l_oha09 != '5' THEN   #MOD-890215 add
                       LET b_omb.omb14t=b_omb.omb12*b_omb.omb13
                       CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
                       CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                    END IF                   #MOD-890215 add
                 END IF
              ELSE
                 IF b_omb.omb12 = 0  AND l_oha09 ='5' THEN       #MOD-940155
                    IF g_oma.oma213 = 'N' THEN
                       IF l_oha09 != '5' THEN   #MOD-890215 add
                          LET b_omb.omb14 =b_omb.omb13
                          CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
                          CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       END IF                   #MOD-890215 add
                    ELSE
                       IF l_oha09 != '5' THEN   #MOD-890215 add
                          LET b_omb.omb14t=b_omb.omb13
                          CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          LET b_omb.omb14 =b_omb.omb14t*(1+g_oma.oma211/100)
                          CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       END IF                   #MOD-890215 add
                    END IF
                 ELSE
                    IF l_oha09 != '5' THEN   #MOD-890215 add
                       LET b_omb.omb14 = 0
                       LET b_omb.omb14t= 0
                    ELSE
                       LET b_omb.omb14 = g_omb[l_ac].omb14
                       LET b_omb.omb14t= g_omb[l_ac].omb14t
                    END IF
                 END IF
              END IF
              CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13   #No.TQC-750093 g_azi -> t_azi
              LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
              LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
              LET g_omb[l_ac].omb15 = b_omb.omb15
              LET g_omb[l_ac].omb17 = b_omb.omb17
              LET g_omb[l_ac].omb14 = b_omb.omb14
              LET g_omb[l_ac].omb14t= b_omb.omb14t
              LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
              LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
              LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
              LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
              CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
              LET g_omb[l_ac].omb15 = b_omb.omb15
              LET g_omb[l_ac].omb16 = b_omb.omb16
              LET g_omb[l_ac].omb16t= b_omb.omb16t
              LET g_omb[l_ac].omb17 = b_omb.omb17
              LET g_omb[l_ac].omb18 = b_omb.omb18
              LET g_omb[l_ac].omb18t= b_omb.omb18t
              DISPLAY g_omb[l_ac].omb13,g_omb[l_ac].omb15,g_omb[l_ac].omb17
                   TO omb13, omb15,omb17
              DISPLAY g_omb[l_ac].omb14,g_omb[l_ac].omb14t,
                      g_omb[l_ac].omb16,g_omb[l_ac].omb16t,
                      g_omb[l_ac].omb18,g_omb[l_ac].omb18t
                   TO omb14,omb14t, omb16,omb16t, omb18,omb18t
           ELSE 
             IF g_omb[l_ac].omb39 = 'Y' THEN
                LET b_omb.omb14  = 0
                LET b_omb.omb14t = 0
                LET b_omb.omb16  = 0
                LET b_omb.omb16t = 0
                LET b_omb.omb18  = 0
                LET b_omb.omb18t = 0
                CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13   #No.TQC-750093 g_azi -> t_azi
                LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
                LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
                LET g_omb[l_ac].omb15 = b_omb.omb15
                LET g_omb[l_ac].omb17 = b_omb.omb17
                LET g_omb[l_ac].omb14 = b_omb.omb14
                LET g_omb[l_ac].omb14t= b_omb.omb14t
                LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
                LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
                LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
                LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
                CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
                CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
                CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
                CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
                CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
                CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
                LET g_omb[l_ac].omb15 = b_omb.omb15
                LET g_omb[l_ac].omb16 = b_omb.omb16
                LET g_omb[l_ac].omb16t= b_omb.omb16t
                LET g_omb[l_ac].omb17 = b_omb.omb17
                LET g_omb[l_ac].omb18 = b_omb.omb18
                LET g_omb[l_ac].omb18t= b_omb.omb18t
                DISPLAY g_omb[l_ac].omb13,g_omb[l_ac].omb15,g_omb[l_ac].omb17
                     TO omb13, omb15,omb17
                DISPLAY g_omb[l_ac].omb14,g_omb[l_ac].omb14t
       
             END IF 
           END IF
          CALL t300_count_amount(p_cmd)  #FUN-720038
 
        AFTER FIELD omb41
          IF NOT cl_null(g_omb[l_ac].omb41) THEN
             LET g_plant_new = g_omb[l_ac].omb44
              #CALL s_gettrandbs()
              #LET li_dbs = g_dbs_tra
             #LET l_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"pja_file ",
             LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'pja_file'), #FUN-A50102
                         " WHERE pja01 = '",g_omb[l_ac].omb41,"' ",
                         "   AND pjaacti = 'Y' AND pjaclose = 'N'"
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
             PREPARE pja_pre FROM l_sql
             DECLARE pja_cs CURSOR FOR pja_pre
             OPEN pja_cs
             FETCH pja_cs INTO g_cnt
             IF g_cnt = 0 THEN
                CALL cl_err(g_omb[l_ac].omb41,'asf-984',0)
                NEXT FIELD omb41
             END IF
          ELSE 
             NEXT FIELD omb33    #IF 專案沒輸入資料，直接跳開專案相關欄位(wbs/活動)
          END IF
         
       BEFORE FIELD omb42
         IF cl_null(g_omb[l_ac].omb41) THEN
            NEXT FIELD omb41
         END IF
 
       AFTER FIELD omb42
          IF NOT cl_null(g_omb[l_ac].omb42) THEN
             LET g_plant_new = g_omb[l_ac].omb44
              #CALL s_gettrandbs()
              #LET li_dbs = g_dbs_tra
             #LET l_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"pjb_file ",
             LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'pjb_file'), #FUN-A50102
                         " WHERE pjb01 = '",g_omb[l_ac].omb41,"' ",
                         "   AND pjb02 ='", g_omb[l_ac].omb42,"' ",
                         "   AND pjbacti = 'Y' "
             CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
             PREPARE pjb_pre FROM l_sql
             DECLARE pjb_cs CURSOR FOR pjb_pre
             OPEN pjb_cs
             FETCH pjb_cs INTO g_cnt
             IF g_cnt = 0 THEN
                CALL cl_err(g_omb[l_ac].omb42,'apj-051',0)
                LET g_omb[l_ac].omb42 = g_omb_t.omb42
                NEXT FIELD omb42
             ELSE
                #LET l_sql = "SELECT pjb09,pjb11 FROM ",li_dbs CLIPPED,"pjb_file ",
                LET l_sql = "SELECT pjb09,pjb11 FROM ",cl_get_target_table(g_plant_new,'pjb_file'), #FUN-A50102
                            " WHERE pjb01 = '",g_omb[l_ac].omb41,"' ",
                            "   AND pjb02 = '",g_omb[l_ac].omb42,"' ",
                            "   AND pjbacti = 'Y' "
                CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
                PREPARE sel_pjb09_pre FROM l_sql
                EXECUTE sel_pjb09_pre INTO l_pjb09,l_pjb11
                IF l_pjb09 != 'Y' OR l_pjb11 != 'Y' THEN
                   CALL cl_err( g_omb[l_ac].omb42,'apj-090',0)
                   LET g_omb[l_ac].omb42 = g_omb_t.omb42
                   NEXT FIELD omb42
                END IF
             END IF
          END IF
 
        AFTER FIELD omb33
           IF NOT cl_null(g_omb[l_ac].omb33) THEN
              LET g_plant_new = g_omb[l_ac].omb44
              # CALL s_gettrandbs()
              # LET li_dbs = g_dbs_tra
              #LET l_sql = "SELECT aag02,aag05 FROM ",li_dbs CLIPPED,"aag_file ",
              LET l_sql = "SELECT aag02,aag05 FROM ",cl_get_target_table(g_plant_new,'aag_file'), #FUN-A50102
                          " WHERE aag01='",g_omb[l_ac].omb33,"' ",
                          "   AND aag00='",g_bookno1,"' ",
                          "   AND aag07 IN ('2','3') AND aag03 = '2' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
              PREPARE aag_pre FROM l_sql
              DECLARE aag_cs CURSOR FOR aag_pre
              OPEN aag_cs
              FETCH aag_cs INTO l_aag02,l_aag05 
              IF STATUS THEN 
#No.FUN-B20059 --begin
                 CALL cl_err3("sel","aag_file",g_omb[l_ac].omb33,"",STATUS,"","sel aag",0)  #No.FUN-660116
                 CALL q_m_aag(FALSE,FALSE,g_omb[l_ac].omb44,g_omb[l_ac].omb33,'23',g_bookno1)
                     RETURNING g_omb[l_ac].omb33
#No.FUN-B20059 --end
                 NEXT FIELD omb33
              END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 ='Y' THEN
                   IF NOT cl_null(g_omb[l_ac].omb930) THEN 
                      CALL s_chkdept_dbs(g_aaz.aaz72,g_omb[l_ac].omb33,g_omb[l_ac].omb930,g_bookno1,g_omb[l_ac].omb44) #FUN-9C0013 
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)                   
                   NEXT FIELD omb33
                END IF
             END IF
 
              MESSAGE l_aag02  #TQC-790124
           END IF
 
        AFTER FIELD omb331
           IF NOT cl_null(g_omb[l_ac].omb331) THEN
              LET g_plant_new = g_omb[l_ac].omb44
               #CALL s_gettrandbs()
               #LET li_dbs = g_dbs_tra
              #LET l_sql = "SELECT aag02,aag05 FROM ",li_dbs CLIPPED,"aag_file ",
              LET l_sql = "SELECT aag02,aag05 FROM ",cl_get_target_table(g_plant_new,'aag_file'), #FUN-A50102
                          " WHERE aag01='",g_omb[l_ac].omb331,"' ",
                          "   AND aag00='",g_bookno2,"' ",
                          "   AND aag07 IN ('2','3') AND aag03 = '2' " 
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
              PREPARE aag_pre1 FROM l_sql
              DECLARE aag_cs1 CURSOR FOR aag_pre1
              OPEN aag_cs1
              FETCH aag_cs1 INTO l_aag02,l_aag05a 
              IF STATUS THEN 
#No.FUN-B20059 --begin
                 CALL cl_err3("sel","aag_file",g_omb[l_ac].omb331,"",STATUS,"","sel aag",0)  #No.FUN-660116
                 CALL q_m_aag(FALSE,FALSE,g_omb[l_ac].omb44,g_omb[l_ac].omb331,'23',g_bookno2)
                      RETURNING g_omb[l_ac].omb331
#No.FUN-B20059 --end 
                 NEXT FIELD omb331
              END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05a = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 ='Y' THEN
                   IF NOT cl_null(g_omb[l_ac].omb930) THEN 
                      CALL s_chkdept_dbs(g_aaz.aaz72,g_omb[l_ac].omb331,g_omb[l_ac].omb930,g_bookno2,g_omb[l_ac].omb44)  #FUN-9C0013 
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD omb331
                END IF
             END IF
 
              MESSAGE l_aag02  #TQC-790124
           END IF
 
        AFTER FIELD omb13
           #LET l_sql = "SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file ",
           LET l_sql = "SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                       " WHERE oha01='",g_omb[l_ac].omb31,"' "
           CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
           CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
           PREPARE sel_oha09_pre8 FROM l_sql
           EXECUTE sel_oha09_pre8 INTO l_oha09
           IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
           IF b_omb.omb39!='Y' AND ((b_omb.omb38!='4' AND b_omb.omb38!='5') OR cl_null(b_omb.omb38)) THEN  #No.FUN-670026      #No.MOD-740429
              IF NOT cl_null(g_omb[l_ac].omb13) THEN
                 LET b_omb.omb12 = g_omb[l_ac].omb12
                 LET b_omb.omb13 = g_omb[l_ac].omb13
                 IF b_omb.omb12 > 0 OR b_omb.omb12 < 0 THEN   #No.FUN-670026
                    IF g_oma.oma213 = 'N' THEN
                       IF l_oha09 != '5' THEN   #MOD-890215 add
                          LET b_omb.omb14 =b_omb.omb12*b_omb.omb13 
                          CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
                          CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       END IF                   #MOD-890215 add
                    ELSE
                       IF l_oha09 != '5' THEN   #MOD-890215 add
                          LET b_omb.omb14t=b_omb.omb12*b_omb.omb13
                          CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          LET b_omb.omb14 =b_omb.omb14t/(1+g_oma.oma211/100)
                          CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                       END IF                   #MOD-890215 add
                    END IF
                 ELSE
                    IF b_omb.omb12 = 0  AND l_oha09 ='5' THEN       #MOD-940155
                       IF g_oma.oma213 = 'N' THEN
                          IF l_oha09 != '5' THEN   #MOD-890215 add
                             LET b_omb.omb14 =b_omb.omb13
                             CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                             LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
                             CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          END IF                   #MOD-890215 add
                       ELSE
                          IF l_oha09 != '5' THEN   #MOD-890215 add
                             LET b_omb.omb14t=b_omb.omb13
                             CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                             LET b_omb.omb14 =b_omb.omb14t*(1+g_oma.oma211/100)
                             CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                          END IF                   #MOD-890215 add
                       END IF
                    END IF
                 END IF
                 CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
                 IF g_oma.oma00='11' THEN
                    #LET l_sql = "SELECT SUM(oeb14t) FROM ",li_dbs CLIPPED,"oeb_file ",
                    LET l_sql = "SELECT SUM(oeb14t) FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                                " WHERE oeb01='",g_omb[l_ac].omb31,"' ",
                                "   AND oeb04='",g_omb[l_ac].omb04,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                    PREPARE sel_oeb14t_pre FROM l_sql
                    EXECUTE sel_oeb14t_pre INTO l_count
                     IF cl_null(l_count) THEN LET l_count=0 END IF
                     IF b_omb.omb14t > l_count then
                        CALL cl_err(b_omb.omb14t,'axr-910',0)
                        NEXT FIELD omb13
                     END IF
                 END IF
                 LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
                  CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15   #No.MOD-520040 由下面移上來  #No.TQC-750093 t_azi -> g_azi
                 LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
                  CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17   #No.MOD-520040 由下面移上來  #No.TQC-750093 t_azi -> g_azi
                 LET g_omb[l_ac].omb15 = b_omb.omb15
                 LET g_omb[l_ac].omb17 = b_omb.omb17
                 LET g_omb[l_ac].omb14 = b_omb.omb14
                 LET g_omb[l_ac].omb14t= b_omb.omb14t
                 LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
                 LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
                 LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
                 LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
                 CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
                 LET g_omb[l_ac].omb13 = b_omb.omb13   #TQC-7A0014
                 LET g_omb[l_ac].omb15 = b_omb.omb15
                 LET g_omb[l_ac].omb16 = b_omb.omb16
                 LET g_omb[l_ac].omb16t= b_omb.omb16t
                 LET g_omb[l_ac].omb17 = b_omb.omb17
                 LET g_omb[l_ac].omb18 = b_omb.omb18
                 LET g_omb[l_ac].omb18t= b_omb.omb18t
              END IF
           ELSE
              IF b_omb.omb39='Y' THEN
                 LET b_omb.omb14 = 0
                 LET b_omb.omb14t= 0
                 LET b_omb.omb16 = 0
                 LET b_omb.omb16t= 0
                 LET b_omb.omb18 = 0
                 LET b_omb.omb18t= 0
                 LET g_omb[l_ac].omb14 = b_omb.omb14
                 LET g_omb[l_ac].omb14t= b_omb.omb14t
                 LET g_omb[l_ac].omb16 = b_omb.omb16
                 LET g_omb[l_ac].omb16t= b_omb.omb16t
                 LET g_omb[l_ac].omb18 = b_omb.omb18
                 LET g_omb[l_ac].omb18t= b_omb.omb18t
                 IF NOT cl_null(g_omb[l_ac].omb13) THEN
                    LET b_omb.omb13 = g_omb[l_ac].omb13
                    LET b_omb.omb15 =b_omb.omb13 *g_oma.oma24
                    LET b_omb.omb17 =b_omb.omb13 *g_oma.oma58
                    CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15   #No.TQC-750093 t_azi -> g_azi
                    CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13   #No.TQC-750093 g_azi -> t_azi
                    CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17   #No.TQC-750093 t_azi -> g_azi
                    LET g_omb[l_ac].omb15 = b_omb.omb15
                    LET g_omb[l_ac].omb17 = b_omb.omb17
                 END IF
              END IF
           END IF
           IF NOT cl_null(g_omb[l_ac].omb13) THEN
              IF g_omb[l_ac].omb13 < 0 THEN
                 CALL cl_err(' ','axr-033',0)
                 NEXT FIELD omb13
              END IF
           END IF
           CALL t300_count_amount(p_cmd)  #FUN-720038
 
        AFTER FIELD omb15 
           IF NOT cl_null(g_omb[l_ac].omb15) THEN
              IF g_omb[l_ac].omb15 < 0 THEN
                 CALL cl_err(' ','axr-033',0)
                  NEXT FIELD omb15
              END IF
           END IF
           LET g_omb[l_ac].omb15 = cl_digcut(g_omb[l_ac].omb15,g_azi03)   #TQC-7A0014
        
        AFTER FIELD omb17
           IF NOT cl_null(g_omb[l_ac].omb17) THEN
              IF g_omb[l_ac].omb17 < 0 THEN
                 CALL cl_err(' ','axr-033',0)
                 NEXT FIELD omb17
              END IF
           END IF
           LET g_omb[l_ac].omb17 = cl_digcut(g_omb[l_ac].omb17,g_azi03)   #TQC-7A0014
 
 
        AFTER FIELD omb14
         IF b_omb.omb39 != 'Y' THEN              #No.FUN-670026 
           IF NOT cl_null(g_omb[l_ac].omb14) THEN
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb14<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb14
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb14<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb14
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb14>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb14
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb14<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb14
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
              IF g_oma.oma00='21' AND NOT cl_null(g_omb[l_ac].omb31) THEN
                 IF b_omb.omb38 = '3' THEN
                    CALL t300_chk_ohb('b')
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_msg1,g_errno,0)
                       IF g_flag='N' THEN
                          LET g_omb[l_ac].omb13 =g_omb_t.omb13
                          LET g_omb[l_ac].omb15 =g_omb_t.omb15
                          LET g_omb[l_ac].omb17 =g_omb_t.omb17
                          LET g_omb[l_ac].omb14 =g_omb_t.omb14
                          LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                          LET g_omb[l_ac].omb16 =g_omb_t.omb16
                          LET g_omb[l_ac].omb16t=g_omb_t.omb16t
                          LET g_omb[l_ac].omb18 =g_omb_t.omb18
                          LET g_omb[l_ac].omb18t=g_omb_t.omb18t
                          LET g_errno=' '
                       END IF
                    END IF
                 ELSE 
                    IF b_omb.omb38 = '5' THEN
                       CALL t300_chk_ohb_1('b')
                    END IF
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_msg1,g_errno,0)
                       IF g_flag='N' THEN
                          LET g_omb[l_ac].omb13 =g_omb_t.omb13
                          LET g_omb[l_ac].omb15 =g_omb_t.omb15
                          LET g_omb[l_ac].omb17 =g_omb_t.omb17
                          LET g_omb[l_ac].omb14 =g_omb_t.omb14
                          LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                          LET g_omb[l_ac].omb16 =g_omb_t.omb16
                          LET g_omb[l_ac].omb16t=g_omb_t.omb16t
                          LET g_omb[l_ac].omb18 =g_omb_t.omb18
                          LET g_omb[l_ac].omb18t=g_omb_t.omb18t
                          LET g_errno=' '
                       END IF
                    END IF
                 END IF
              ELSE
                 IF b_omb.omb38 = '3' THEN
                    CALL t300_chk_ohb('b')
                 ELSE 
                    IF b_omb.omb38 = '5' THEN
                       CALL t300_chk_ohb_1('b')
                    ELSE  
                       IF b_omb.omb38 = '4' THEN
                          #LET l_sql = "SELECT SUM(ohb14) FROM ",li_dbs CLIPPED,"oha_file,",
                          #                                      li_dbs CLIPPED,"ohb_file ",
                          LET l_sql = "SELECT SUM(ohb14) FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                                                cl_get_target_table(g_plant_new,'ohb_file'),      #FUN-A50102
                                      " WHERE oha09='3' AND oha01=ohb01 ",
                                      "   AND ohb31= '",g_ogb.ogb01,"' ",
                                      "   AND ohb32= '",g_ogb.ogb03,"' ",
                                      "   AND ohaconf='Y' AND ohapost='Y' "
                          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                          PREPARE sel_ohb14_pre2 FROM l_sql
                          EXECUTE sel_ohb14_pre2 INTO g_ohb14_ret
                          SELECT SUM(omb14) INTO l_act FROM omb_file,oma_file
                           WHERE oma00='12'
                             AND oma01=omb01
                             AND omavoid='N'
                             AND omb31=g_omb[l_ac].omb31
                             AND omb32=g_omb[l_ac].omb31
                             AND omb44=g_omb[l_ac].omb44     #FUN-9C0013
                          LET l_act=(l_act-g_omb_t.omb14+g_omb[l_ac].omb14)- 
                                    (g_ogb.ogb14-g_ohb14_ret)  
                          IF l_act>0 THEN
                             LET g_msg1=g_omb[l_ac].omb31,'',g_omb[l_ac].omb32
                             LET g_errno='axr-167'
                             LET g_flag='N'
                          END IF
                       END IF
                    END IF
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_msg1,g_errno,0)
                       IF g_flag='N' THEN
                          LET g_omb[l_ac].omb13 =g_omb_t.omb13
                          LET g_omb[l_ac].omb15 =g_omb_t.omb15
                          LET g_omb[l_ac].omb17 =g_omb_t.omb17
                          LET g_omb[l_ac].omb14 =g_omb_t.omb14
                          LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                          LET g_omb[l_ac].omb16 =g_omb_t.omb16
                          LET g_omb[l_ac].omb16t=g_omb_t.omb16t
                          LET g_omb[l_ac].omb18 =g_omb_t.omb18
                          LET g_omb[l_ac].omb18t=g_omb_t.omb18t
                          LET g_errno=' '
                       END IF
                    END IF
                 END IF 
                 IF cl_null(b_omb.omb14) OR g_omb[l_ac].omb14 != b_omb.omb14 THEN
                    LET b_omb.omb14 = g_omb[l_ac].omb14
                    CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14    #MOD-5C0111  #No.TQC-750093 g_azi -> t_azi
                    LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
                    CALL cl_digcut(b_omb.omb14t,t_azi04) RETURNING b_omb.omb14t    #No.MOD-520040  #No.TQC-750093 g_azi -> t_azi
                 END IF
                 LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
                 LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
                 LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
                 LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
                 CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16   #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t  #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18   #No.TQC-750093 t_azi -> g_azi
                 CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t  #No.TQC-750093 t_azi -> g_azi
                 LET g_omb[l_ac].omb14 = b_omb.omb14
                 LET g_omb[l_ac].omb14t= b_omb.omb14t
                 LET g_omb[l_ac].omb16 = b_omb.omb16
                 LET g_omb[l_ac].omb16t= b_omb.omb16t
                 LET g_omb[l_ac].omb18 = b_omb.omb18
                 LET g_omb[l_ac].omb18t= b_omb.omb18t
              END IF
           END IF
        ELSE
         IF b_omb.omb39 ='Y' THEN      #No.TQC-7B0035
           IF g_omb[l_ac].omb14 != 0 THEN
              CALL cl_err(g_omb[l_ac].omb14,'axr-158',1)
              LET g_omb[l_ac].omb14 = 0 
              LET g_omb[l_ac].omb14t= 0
              LET g_omb[l_ac].omb16 = 0
              LET g_omb[l_ac].omb16t= 0
              LET g_omb[l_ac].omb18 = 0
              LET g_omb[l_ac].omb18t= 0
           END IF
         END IF                              #No.TQC-7B0035
        END IF
         CALL t300_count_amount(p_cmd)  #FUN-720038
 
        AFTER FIELD omb14t
           IF NOT cl_null(g_omb[l_ac].omb14t) THEN
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb14t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb14t
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb14t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb14t
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb14t>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb14t
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb14t<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb14t
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
              IF g_oma.oma00='21' AND NOT cl_null(g_omb[l_ac].omb31) THEN
                 IF b_omb.omb38 = '3' THEN
                    CALL t300_chk_ohb('b')
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_msg1,g_errno,0)
                       IF g_flag='N' THEN
                          LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                          DISPLAY g_omb[l_ac].omb14t TO omb14t
                          NEXT FIELD omb14t
                       END IF
                    END IF
                 ELSE 
                    IF b_omb.omb38 = '5' THEN
                       CALL t300_chk_ohb_1('b')
                       IF NOT cl_null(g_errno) THEN
                          CALL cl_err(g_msg1,g_errno,0)
                          IF g_flag='N' THEN
                             LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                             DISPLAY g_omb[l_ac].omb14t TO omb14t
                             NEXT FIELD omb14t
                          END IF
                       END IF
                    END IF
                 END IF
              ELSE
                 IF b_omb.omb38 = '3' THEN
                    CALL t300_chk_ohb('b')
                 ELSE 
                    IF b_omb.omb38 = '5' THEN
                       CALL t300_chk_ohb_1('b')
                    ELSE  
                       IF b_omb.omb38 = '4' THEN
                          #LET l_sql = "SELECT SUM(ohb14) FROM ",li_dbs CLIPPED,"oha_file,",
                          #                                      li_dbs CLIPPED,"ohb_file ",
                          LET l_sql = "SELECT SUM(ohb14) FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                                                cl_get_target_table(g_plant_new,'ohb_file'),     #FUN-A50102
                                      " WHERE oha09='3' AND oha01=ohb01 ",
                                      "   AND ohb31= '",g_ogb.ogb01,"' ",
                                      "   AND ohb32= '",g_ogb.ogb03,"' ",
                                      "   AND ohaconf='Y' AND ohapost='Y'"
                          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                          PREPARE sel_ohb14_cs FROM l_sql
                          EXECUTE sel_ohb14_cs INTO g_ohb14_ret
                          SELECT SUM(omb14) INTO l_act FROM omb_file,oma_file
                           WHERE oma00='12'
                             AND oma01=omb01
                             AND omavoid='N'
                             AND omb31=g_omb[l_ac].omb31
                             AND omb32=g_omb[l_ac].omb31
                             AND omb44=g_omb[l_ac].omb44  #FUN-9C0013
                          LET l_act=(l_act-g_omb_t.omb14+g_omb[l_ac].omb14)- 
                                    (g_ogb.ogb14-g_ohb14_ret)  
                          IF l_act>0 THEN
                             LET g_msg1=g_omb[l_ac].omb31,'',g_omb[l_ac].omb32
                             LET g_errno='axr-167'
                             LET g_flag='N'
                          END IF
                       END IF
                    END IF
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err(g_msg1,g_errno,0)
                       IF g_flag='N' THEN
                          LET g_omb[l_ac].omb14t=g_omb_t.omb14t
                          LET g_errno=' '
                          DISPLAY g_omb[l_ac].omb14t TO omb14t
                          NEXT FIELD omb14t
                       END IF
                    END IF
                 END IF 
              END IF
              IF cl_null(b_omb.omb14t) OR g_omb[l_ac].omb14t != b_omb.omb14t THEN
                 LET b_omb.omb14t = g_omb[l_ac].omb14t
                 CALL cl_digcut(b_omb.omb14t,t_azi04) RETURNING b_omb.omb14t   #TQC-7A0014
              END IF
              LET b_omb.omb16 =b_omb.omb14  *g_oma.oma24
              LET b_omb.omb16t=b_omb.omb14t *g_oma.oma24
              LET b_omb.omb18 =b_omb.omb14  *g_oma.oma58
              LET b_omb.omb18t=b_omb.omb14t *g_oma.oma58
              CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16   #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t  #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18   #No.TQC-750093 t_azi -> g_azi
              CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t  #No.TQC-750093 t_azi -> g_azi
              LET g_omb[l_ac].omb14t = b_omb.omb14t
              LET g_omb[l_ac].omb16 = b_omb.omb16
              LET g_omb[l_ac].omb16t= b_omb.omb16t
              LET g_omb[l_ac].omb18 = b_omb.omb18
              LET g_omb[l_ac].omb18t= b_omb.omb18t
           END IF
           CALL t300_count_amount(p_cmd)  #FUN-720038
 
        AFTER FIELD omb16
           IF NOT cl_null(g_omb[l_ac].omb16) THEN 
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb16<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb16
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb16<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb16
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb16>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb16
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb16<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb16
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
           END IF 
           IF NOT cl_null(g_omb[l_ac].omb16) AND g_aza.aza26 ='2' THEN     #No.MOD-670103
              IF NOT cl_null(g_omb[l_ac].omb16t) THEN
                 LET g_dec = g_omb[l_ac].omb16*(1+g_oma.oma211/100) - g_omb[l_ac].omb16t
                 IF g_dec >= 0.06 OR g_dec <= -0.06 THEN
                    CALL cl_err(g_omb[l_ac].omb16,'axr-022',1)
                    NEXT FIELD omb16
                 END IF
              END IF
           END IF
         CALL cl_digcut(g_omb[l_ac].omb16,g_azi04) RETURNING g_omb[l_ac].omb16   #TQC-7A0014
         CALL t300_count_amount(p_cmd)  #FUN-720038
 
        AFTER FIELD omb16t
           IF NOT cl_null(g_omb[l_ac].omb16t) THEN 
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb16t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb16t
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb16t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb16t
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb16t>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb16t
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb16t<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb16t
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
           END IF 
           LET b_omb.omb16t = g_omb[l_ac].omb16t
           IF NOT cl_null(g_omb[l_ac].omb16t) AND g_aza.aza26  ='2' THEN     #No.MOD-670103
              IF NOT cl_null(g_omb[l_ac].omb16) THEN
                 LET g_dec = g_omb[l_ac].omb16*(1+g_oma.oma211/100) - g_omb[l_ac].omb16t
                 IF g_dec >= 0.06 OR g_dec <= -0.06 THEN
                    CALL cl_err(g_omb[l_ac].omb16t,'axr-022',1)
                    NEXT FIELD omb16t
                 END IF
              END IF
           END IF
           CALL cl_digcut(g_omb[l_ac].omb16t,g_azi04)RETURNING g_omb[l_ac].omb16t  #No.TQC-750093 t_azi -> g_azi
           CALL t300_count_amount(p_cmd)  #FUN-720038
 
 
        AFTER FIELD omb18
           IF NOT cl_null(g_omb[l_ac].omb18) THEN 
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb18<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb18
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb18<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb18
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb18>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb18
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb18<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb18
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
           END IF 
           LET g_omb[l_ac].omb18 = cl_digcut(g_omb[l_ac].omb18,g_azi04)   #TQC-7A0014
           
        AFTER FIELD omb18t
           IF NOT cl_null(g_omb[l_ac].omb18t) THEN 
              CASE g_omb[l_ac].omb38
                WHEN '1'
                  IF g_omb[l_ac].omb18t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb18t
                  END IF 
                WHEN '2'
                  IF g_omb[l_ac].omb18t<0 THEN 
                     CALL cl_err('','axr-029',1)
                     NEXT FIELD omb18t
                  END IF 
                WHEN '3'
                  IF g_oma.oma00 MATCHES '1*' THEN 
                     IF g_omb[l_ac].omb18t>0 THEN 
                        CALL cl_err('','axr-028',1)
                        NEXT FIELD omb18t
                     END IF 
                  ELSE
                   IF g_omb[l_ac].omb18t<0 THEN 
                      CALL cl_err('','axr-029',1)
                      NEXT FIELD omb18t
                   END IF 
                  END IF 
                OTHERWISE EXIT CASE 
              END CASE 
           END IF          
           LET g_omb[l_ac].omb18t = cl_digcut(g_omb[l_ac].omb18t,g_azi04)   #TQC-7A0014
           
        AFTER FIELD omb930 
           IF NOT s_costcenter_chk(g_omb[l_ac].omb930) THEN
              LET g_omb[l_ac].omb930=g_omb_t.omb930
              LET g_omb[l_ac].gem02c=g_omb_t.gem02c
              DISPLAY BY NAME g_omb[l_ac].omb930,g_omb[l_ac].gem02c
              NEXT FIELD omb930
           ELSE
              LET g_omb[l_ac].gem02c=s_costcenter_desc(g_omb[l_ac].omb930)
              DISPLAY BY NAME g_omb[l_ac].gem02c
           END IF
        #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
         LET l_aag05=''   
         #LET l_sql = "SELECT aag05 FROM ",li_dbs CLIPPED,"aag_file ",
         LET l_sql = "SELECT aag05 FROM ",cl_get_target_table(g_plant_new,'aag_file'), #FUN-A50102
                    " WHERE aag01 = '",g_omb[l_ac].omb33,"' ",
                    "   AND aag00 = '",g_bookno1,"' "
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
         PREPARE sel_aag05_cs FROM l_sql
         EXECUTE sel_aag05_cs INTO l_aag05
         
         LET g_errno = ' '   
         IF l_aag05 = 'Y' AND NOT cl_null(g_omb[l_ac].omb33) THEN
           #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
            IF g_aaz.aaz90 ='Y' THEN
               CALL s_chkdept_dbs(g_aaz.aaz72,g_omb[l_ac].omb33,g_omb[l_ac].omb930,g_bookno1,g_omb[l_ac].omb44)  #FUN-9C0013 
                             RETURNING g_errno
            END IF
            IF NOT cl_null(g_errno) THEN
               CALL cl_err('',g_errno,0)
               NEXT FIELD omb930
            END IF
         END IF
 
        #會科二
         IF g_aza.aza63='Y' THEN
            LET l_aag05a=''   
            #LET l_sql = "SELECT aag05 FROM ",li_dbs CLIPPED,"aag_file ",
            LET l_sql = "SELECT aag05 FROM ",cl_get_target_table(g_plant_new,'aag_file'), #FUN-A50102
                        " WHERE aag01 = '",g_omb[l_ac].omb331,"' ",
                        "   AND aag00 = '",g_bookno2,"' "
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
            PREPARE sel_aag05_cs1 FROM l_sql
            EXECUTE sel_aag05_cs1 INTO l_aag05a
            
            LET g_errno = ' '   
            IF l_aag05a = 'Y' AND NOT cl_null(g_omb[l_ac].omb331) THEN
               IF g_aaz.aaz90 ='Y' THEN
                  CALL s_chkdept_dbs(g_aaz.aaz72,g_omb[l_ac].omb331,g_omb[l_ac].omb930,g_bookno2,g_omb[l_ac].omb44)  #FUN-9C0013            
                                RETURNING g_errno
               END IF
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD omb930
               END IF
            END IF
         END IF
 
        AFTER FIELD ombud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD ombud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        BEFORE DELETE                            #是否取消單身
           IF g_omb_t.omb03 > 0 AND g_omb_t.omb03 IS NOT NULL THEN
              IF g_azw.azw04 = '2' AND g_oma.oma00='12'       
                 AND NOT cl_null(g_omb_t.omb31) THEN    
                    IF NOT cl_confirm('axr-614') THEN
                     CANCEL DELETE
                    END IF
              ELSE
                 IF NOT cl_delb(0,0) THEN
                    CANCEL DELETE
                 END IF
              END IF    #FUN-960140
              IF l_lock_sw = "Y" THEN
                 CALL cl_err("", -263, 1)
                 CANCEL DELETE
              END IF
              IF NOT cl_null(g_oma.oma10) THEN
                 CALL cl_err('','axr-141',1)
                 CANCEL DELETE 
              END IF
           
              ######若有支票收款刪除之前應該刪除nmh_file的資料
              ######要求未衝賬未拋磚總帳
              DECLARE oob_cs_del CURSOR FOR
                 SELECT oob06 FROM oob_file
                  WHERE oob01=g_oma.oma01 AND oob03='1' AND oob04='1' AND oob02>0
              FOREACH oob_cs_del INTO l_oob06
                 IF SQLCA.sqlcode THEN
                    CALL cl_err('foreach:',SQLCA.sqlcode,1)
                    LET g_success = 'N' 
                    CANCEL DELETE
                    EXIT FOREACH
                 END IF
                 SELECT nmh17,nmh24,nmh33 INTO l_nmh17,l_nmh24,l_nmh33 FROM nmh_file
                  WHERE nmh01=l_oob06
                 IF l_nmh24<>'2' THEN
                   CALL cl_err('','axr-045',1)
                   LET g_success='N'
                   CANCEL DELETE
                   EXIT FOREACH
                 END IF
                 IF l_nmh17 >0 THEN
                    CALL cl_err('','axr-077',1)
                    LET g_success='N'
                    CANCEL DELETE
                    EXIT FOREACH
                 END IF
 
                 IF NOT cl_null(l_nmh33) THEN
                    CALL cl_err('','axr-047',1)
                    LET g_success='N'
                    CANCEL DELETE
                    EXIT FOREACH
                 END IF
 
                 DELETE FROM nmh_file WHERE nmh01=l_oob06
                 IF STATUS OR SQLCA.SQLCODE THEN
                    CALL cl_err3("del","nmh_file","","",SQLCA.sqlcode,"","",1)
                    LET g_success = 'N'
                    CANCEL DELETE
                    EXIT FOREACH
                 END IF
              END FOREACH
 
              IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
                 LET l_omb31 =''
                 SELECT omb31 INTO l_omb31 FROM omb_file
                  WHERE omb01 = g_oma.oma01 AND omb03 = g_omb_t.omb03
                 IF NOT cl_null(l_omb31) THEN
                    #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                    LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "   SET oga10 = '' ",
                                " WHERE oga01 = '",l_omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                    PREPARE upd_oga_pre2 FROM l_sql
                    EXECUTE upd_oga_pre2
                    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                       CALL cl_err3("upd","oga_file",l_omb31,"",SQLCA.SQLCODE,"","update oga_file",1)
                       LET g_success = 'N'
                    END IF
                    LET l_rec_b1 =0
                    SELECT count(omb03) INTO l_rec_b1 FROM omb_file
                     WHERE omb01 = g_oma.oma01 AND omb31 = l_omb31
                    DELETE FROM omb_file WHERE omb01 = g_oma.oma01 AND omb31 = l_omb31
                    IF SQLCA.sqlcode THEN
                       CALL cl_err3("del","omb_file",g_oma.oma01,"",SQLCA.sqlcode,"","",1)
                       ROLLBACK WORK
                       CANCEL DELETE
                    ELSE
                       LET pb_cmd = 'Y'  
                    END IF
                 ELSE
                    DELETE FROM omb_file
                     WHERE omb01 = g_oma.oma01 AND omb03 = g_omb_t.omb03
                    IF SQLCA.sqlcode THEN
                       CALL cl_err3("del","omb_file",g_oma.oma01,g_omb_t.omb03,SQLCA.sqlcode,"","",1) 
                       ROLLBACK WORK
                       CANCEL DELETE
                    ELSE
                       LET pb_cmd = 'Y' 
                    END IF
                 END IF
              ELSE
                 DELETE FROM omb_file
                  WHERE omb01 = g_oma.oma01 AND omb03 = g_omb_t.omb03
                 IF SQLCA.sqlcode THEN
                    CALL cl_err3("del","omb_file",g_oma.oma01,g_omb_t.omb03,SQLCA.sqlcode,"","",1)  #No.FUN-660116
                    ROLLBACK WORK
                    CANCEL DELETE
                 END IF
              END IF     #FUN-960140
              IF g_oma.oma00 = '12' AND g_oma.oma16 IS NULL THEN
                 IF g_omb[l_ac].omb38 = '2' OR g_omb[l_ac].omb38 = '4' THEN     #MOD-870253
                    LET m_oma01 = ''  LET m_oma05 = ''
                    SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
                     WHERE oma01 = omb01
                       AND oma00 = '12'
                       AND omavoid != 'Y'
                       AND oma01 != g_oma.oma01
                       AND omb31 = b_omb.omb31
                    IF cl_null(m_oma01) THEN
                       LET m_oma01=''   #MOD-8C0141 mod
                       LET m_oma05=g_oma.oma05            #MOD-9C0164
                    ELSE
                       SELECT oma05 INTO m_oma05 FROM oma_file
                        WHERE oma01=m_oma01
                       IF cl_null(m_oma05) THEN LET m_oma05='' END IF   #MOD-8C0141 mod
                    END IF
                    #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                    LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "   SET oga10='",m_oma01,"' ,",
                                "       oga05='",m_oma05,"'  ",
                                " WHERE oga01='",b_omb.omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                    PREPARE upd_oga_pre3 FROM l_sql
                    EXECUTE upd_oga_pre3
                    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                       CALL cl_err3("upd","oga_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)  
                       ROLLBACK WORK
                    END IF 
                 END IF 
                 IF g_omb[l_ac].omb38 = '3' OR g_omb[l_ac].omb38 = '5' THEN     #MOD-870253
                    #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                    LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                "   SET oha10 = '' ",
                                " WHERE oha01 = '",b_omb.omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
                    PREPARE upd_oha_pre2 FROM l_sql
                    EXECUTE upd_oha_pre2
                    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                       CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                       ROLLBACK WORK
                    END IF
                 END IF
              END IF
              IF g_oma.oma00 = '21' AND g_oma.oma16 IS NULL THEN
                 #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                 LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             "   SET oha10 = '' ",
                             " WHERE oha01 = '",b_omb.omb31,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                 CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                 PREPARE upd_oha_pre3 FROM l_sql
                 EXECUTE upd_oha_pre3
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                     CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                     ROLLBACK WORK   #MOD-960099 add
                  END IF
              END IF
              LET g_cnt = 0 
              #LET l_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file ",
              LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                          " WHERE ohaconf = 'Y' AND ohapost = 'Y' AND oha09 = '3' ",
                          "   AND oha10 = '",g_oma.oma01,"' "
              CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
              PREPARE sel_cou_oha FROM l_sql
              EXECUTE sel_cou_oha INTO g_cnt
              IF g_cnt > 0 THEN 
                 #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                 LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                             "   SET oha10 = '' ",
                             " WHERE ohaconf = 'Y' AND ohapost = 'Y' AND oha09 = '3' ",
                             "   AND oha10 = '",g_oma.oma01,"' "
                 CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                 PREPARE upd_oha_pre4 FROM l_sql
                 EXECUTE upd_oha_pre4 
                 IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                    CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)  
                    ROLLBACK WORK   #MOD-960099 add
                 END IF
              END IF
              CALL t300_mlog('R')
              IF g_omb[l_ac].omb38 = '2' OR g_omb[l_ac].omb38 = '4' THEN    #No.TQC-7A0120     #MOD-870253
                 SELECT COUNT(*) INTO g_cnt FROM omb_file,oma_file
                  WHERE  oma01=omb01 AND omb31= g_omb_t.omb31
                    AND  omb38 IN ('2','4')      #No.TQC-7A0120     #MOD-870253
                 IF g_cnt=0 THEN
                    LET m_oma01 = ''  LET m_oma05 = ''
                    SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
                     WHERE oma01 = omb01
                       AND oma00 = '12'
                       AND omavoid != 'Y'
                       AND oma01 != g_oma.oma01
                       AND omb31 = g_omb_t.omb31
                    IF cl_null(m_oma01) THEN
                       LET m_oma01=''   #MOD-8C0141 mod
                       LET m_oma05=g_oma.oma05            #MOD-9C0164
                    ELSE
                       SELECT oma05 INTO m_oma05 FROM oma_file
                        WHERE oma01=m_oma01
                       IF cl_null(m_oma05) THEN LET m_oma05='' END IF   #MOD-8C0141 mod
                    END IF
                    #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                    LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "   SET oga10='",m_oma01,"' ,",
                                "       oga05='",m_oma05,"'  ",
                                " WHERE oga01='",g_omb_t.omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                    PREPARE upd_oga_pre4 FROM l_sql
                    EXECUTE upd_oga_pre4 
                    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN   #MOD-960099 mod
                       CALL cl_err3("upd","oga_file",g_omb_t.omb31,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
                       ROLLBACK WORK   #MOD-960099 add
                    END IF
                 END IF
              END IF      #No.TQC-7A0120
              IF g_omb[l_ac].omb38 = '3' OR g_omb[l_ac].omb38 = '5' THEN  #No.TQC-7A0120     #MOD-870253
                 SELECT COUNT(*) INTO g_cnt FROM omb_file,oma_file
                  WHERE oma01=omb01 AND omb31=g_omb_t.omb31
                    AND omb38 IN ('3','5')     #MOD-870253
                 IF g_cnt = 0 THEN
                    #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                    LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                "   SET oha10=NULL ",
                                " WHERE oha01 = '",g_omb_t.omb31,"' "
                    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                    PREPARE upd_oha_pre5 FROM l_sql
                    EXECUTE upd_oha_pre5 
                    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN   #MOD-960099 mod
                       CALL cl_err3("upd","oha_file",g_omb_t.omb31,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
                       ROLLBACK WORK   #MOD-960099 add
                    END IF
                 END IF
              END IF    #No.TQC-7A0120
              COMMIT WORK   #MOD-960099 add
              IF g_azw.azw04 = '2' AND g_oma.oma00='12' AND l_rec_b1 > 0 THEN 
                 LET g_rec_b=g_rec_b - l_rec_b1            
              ELSE
                 LET g_rec_b=g_rec_b-1
              END IF         #FUN-960140
              DISPLAY g_rec_b TO FORMONLY.cn2
              LET l_oma64 = '0'          #FUN-550049
           END IF
          #-TQC-B60089-add-
           LET g_ogb_o.* = g_ogb.*
           LET g_sql = " SELECT * ",
                       "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                       "  WHERE ogb01 = '",g_omb[l_ac].omb31,"'",
                       "    AND ogb03 = '",g_omb[l_ac].omb32,"'"
           CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
           CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
           PREPARE sel_ogb_pre17 FROM g_sql
           EXECUTE sel_ogb_pre17 INTO g_ogb.*
          #-TQC-B60089-end-
          #-------------------------------No.CHI-B90025----------------------------------start
           IF g_oma.oma00='11' THEN
              SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
               WHERE oeaa01 = g_oma.oma16
                 AND oeaa02 = '1'
                 AND oeaa03 = g_oma.oma165
                 AND oeaa01 = oea01
           END IF
           IF g_oma.oma00='13' THEN
              SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
               WHERE oeaa01 = g_oma.oma16
                 AND oeaa02 = '2'
                 AND oeaa03 = g_oma.oma165
                 AND oeaa01 = oea01
           END IF
           CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
           #CALL t300_bu()
           #-------------------------------No.CHI-B90025----------------------------------end
           LET g_ogb.* = g_ogb_o.*     #TQC-B60089
           CALL t300_count_amount('')  #FUN-720038
 
        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_omb[l_ac].* = g_omb_t.*
               CLOSE t300_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_omb[l_ac].omb03,-263,1)
               LET g_omb[l_ac].* = g_omb_t.*
            ELSE
               CALL t300_b_move_back()
               CALL t300_b_else()
               IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
                  LET b_omb.omb36=g_oma.oma24
                  LET b_omb.omb37=b_omb.omb16t-b_omb.omb35
               END IF
               UPDATE omb_file SET * = b_omb.*
                WHERE omb01=g_oma.oma01 AND omb03=g_omb_t.omb03
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","omb_file",g_oma.oma01,g_omb_t.omb03,SQLCA.sqlcode,"","upd omb",1)  #No.FUN-660116
                  LET g_omb[l_ac].* = g_omb_t.*
               ELSE
                  MESSAGE 'UPDATE O.K'
                  LET pb_cmd = 'Y'   #FUN-960140
                  IF g_oma.oma00 = '12' AND g_oma.oma16 IS NULL THEN
                     IF g_omb[l_ac].omb38 = '2' OR g_omb[l_ac].omb38 = '4' THEN     #No.TQC-7A0120     #MOD-870253
                        LET m_oma01 = ''  LET m_oma05 = ''
                        SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
                         WHERE oma01 = omb01
                           AND oma00 = '12'
                           AND omavoid != 'Y'
                           AND oma01 != g_oma.oma01
                           AND omb31 = g_omb_t.omb31
                        IF cl_null(m_oma01) THEN
                           LET m_oma01=''   #MOD-8C0141 mod
                           LET m_oma05=g_oma.oma05            #MOD-9C0164
                        ELSE
                           SELECT oma05 INTO m_oma05 FROM oma_file
                            WHERE oma01=m_oma01
                           IF cl_null(m_oma05) THEN LET m_oma05='' END IF   #MOD-8C0141 mod
                        END IF
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                    "   SET oga10='",m_oma01,"' ,",
                                    "       oga05='",m_oma05,"'  ",
                                    " WHERE oga01='",g_omb_t.omb31,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                        PREPARE upd_oga_pre5 FROM l_sql
                        EXECUTE upd_oga_pre5
                        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                           CALL cl_err3("upd","oga_file",g_omb_t.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)  
                        END IF
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oga_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                    "   SET oga10 = '",g_oma.oma01,"' ,",
                                    "       oga05 = '",g_oma.oma05,"'  ",
                                    " WHERE oga01 = '",b_omb.omb31,"'  "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                        PREPARE upd_oga_pre6 FROM l_sql
                        EXECUTE upd_oga_pre6
                        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                           CALL cl_err3("upd","oga_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oga_file",1)  
                        END IF
                      END IF                                                              #No.TQC-7A0120 
                     IF g_omb[l_ac].omb38 = '3' OR g_omb[l_ac].omb38 = '5' THEN     #No.TQC-7A0120     #MOD-870253
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                    "   SET oha10 = '' ",
                                    " WHERE oha01 = '",g_omb_t.omb31,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                        PREPARE upd_oha_pre6 FROM l_sql
                        EXECUTE upd_oha_pre6
                         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                            CALL cl_err3("upd","oha_file",g_omb_t.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                         END IF
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                    "   SET oha10 = '",g_oma.oma01,"' " ,
                                    " WHERE oha01 = '",b_omb.omb31,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                        PREPARE upd_oha_pre7 FROM l_sql
                        EXECUTE upd_oha_pre7
                         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                            CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                         END IF
                      END IF                                                              #No.TQC-7A0120 
                        
                  END IF
                  IF g_oma.oma00 = '21' AND g_oma.oma16 IS NULL THEN
                     #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                     LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                 "   SET oha10 = '' ",
                                 " WHERE oha01 = '",g_omb_t.omb31,"' "
                     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                     PREPARE upd_oha_pre8 FROM l_sql
                     EXECUTE upd_oha_pre8
                      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                         CALL cl_err3("upd","oha_file",g_omb_t.omb03,"",SQLCA.SQLCODE,"","update oha_file",1)  
                      END IF
                     #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                     LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                 "   SET oha10 = '",g_oma.oma01,"' " ,
                                 " WHERE oha01 = '",b_omb.omb31,"' "
                     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
                     PREPARE upd_oha_pre9 FROM l_sql
                     EXECUTE upd_oha_pre9
                      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                         CALL cl_err3("upd","oha_file",b_omb.omb31,"",SQLCA.SQLCODE,"","update oha_file",1)  
                      END IF
                  END IF
                  IF g_omb[l_ac].omb31 <> g_omb_t.omb31 AND p_cmd = 'u' THEN 
                     LET g_cnt = 0 
                     #LET l_sql = "SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file ",
                     LET l_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                 " WHERE ohaconf = 'Y' AND ohapost = 'Y' AND oha09 = '3' ",
                                 "   AND oha10 = '",g_oma.oma01,"' "
                     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
                     PREPARE sel_cou_oha1 FROM l_sql
                     EXECUTE sel_cou_oha1 INTO g_cnt
                     IF g_cnt > 0 THEN 
                        #LET l_sql = "UPDATE ",li_dbs CLIPPED,"oha_file ",
                        LET l_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                    "   SET oha10 = '' ",
                                    " WHERE ohaconf = 'Y' AND ohapost = 'Y' AND oha09 = '3' ",
                                    "   AND oha10 = '",g_oma.oma01,"' "
                        CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
                        CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102                
                        PREPARE upd_oha_pre10 FROM l_sql
                        EXECUTE upd_oha_pre10 
                        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
                           CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)  
                        END IF
                     END IF
                  END IF
                  IF g_oma.oma64 NOT matches '[Ss]' THEN   #FUN-8A007
                     LET l_oma64 = '0'          #FUN-550049
                  END IF                                   #FUN-8A0075
                  CALL t300_mlog('U')
                 #-TQC-B60089-add-
                  LET g_ogb_o.* = g_ogb.*
                  LET g_sql = " SELECT * ",
                              "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                              "  WHERE ogb01 = '",b_omb.omb31,"'",
                              "    AND ogb03 = '",b_omb.omb32,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                  PREPARE sel_ogb_pre18 FROM g_sql
                  EXECUTE sel_ogb_pre18 INTO g_ogb.*
                 #-TQC-B60089-end-
                       #-------------------------------No.CHI-B90025----------------------------------start
                        IF g_oma.oma00='11' THEN
                           SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                            WHERE oeaa01 = g_oma.oma16
                              AND oeaa02 = '1'
                              AND oeaa03 = g_oma.oma165
                              AND oeaa01 = oea01
                       END IF
                       IF g_oma.oma00='13' THEN
                          SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                           WHERE oeaa01 = g_oma.oma16
                             AND oeaa02 = '2'
                             AND oeaa03 = g_oma.oma165
                             AND oeaa01 = oea01
                       END IF
                       CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                       #CALL t300_bu()
                      #-------------------------------No.CHI-B90025----------------------------------end
                  CALL t300_show_rec_amt()   #MOD-770142
                  LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                COMMIT WORK
               END IF
            END IF
            IF g_oma.oma00 = '25' AND p_cmd = 'a' THEN
               IF NOT cl_null(g_omb[l_ac].omb31) THEN
                  SELECT oma24,oma58 INTO l_oma24,l_oma58
                    FROM oma_file
                   WHERE oma16 = g_omb[l_ac].omb31     #modi by canny(980707)
                     AND oma00 MATCHES '1*'
                  IF STATUS THEN
                     CALL cl_err3("sel","oma_file",g_omb[l_ac].omb31,"",STATUS,"","",1)  #No.FUN-660116
                  END IF
                  UPDATE oma_file SET oma24 = l_oma24,oma60=l_oma24,oma58 = l_oma58
                   WHERE oma01 = g_oma.oma01
                 IF STATUS OR SQLCA.SQLCODE THEN
                    CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma",1)  #No.FUN-660116
                 END IF
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                     CALL cl_err('upd omab',SQLCA.SQLCODE,1)
                  END IF
                  LET g_oma.oma24 = l_oma24
                  LET g_oma.oma58 = l_oma58
                  DISPLAY BY NAME g_oma.oma24,g_oma.oma58
               END IF
            END IF
 
        AFTER ROW
          LET l_ac = ARR_CURR()
          LET l_ac_t = l_ac
          IF INT_FLAG THEN                 #900423
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             IF p_cmd = 'u' THEN
                LET g_omb[l_ac].* = g_omb_t.*
             END IF
             CLOSE t300_bcl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          CLOSE t300_bcl
          COMMIT WORK
          IF g_azw.azw04 = '2' AND g_oma.oma00='12' AND
              l_rec_b1 >1 THEN
             FOR i=1 TO l_rec_b1
               CALL g_omb.deleteElement(g_rec_b+i)
             END FOR
             FOR i = 1 TO g_rec_b
               CALL g_omb.deleteElement(i)
             END FOR
             CALL t300_b_fill(g_wc2)
          ELSE
             CALL g_omb.deleteElement(g_rec_b+1)
          END IF    #FUN-960140
        ON ACTION controls                             #No.FUN-6A0092
           CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(omb03) AND l_ac > 1 THEN
                LET g_omb[l_ac].* = g_omb[l_ac-1].*
                LET g_omb[l_ac].omb03 = NULL
                DISPLAY g_omb[l_ac].* TO s_omb[l_ac].*           #MOD-B10011
                NEXT FIELD omb03
            END IF
        ON ACTION CONTROLP   #ok
            CASE
               WHEN INFIELD(omb04)
                 CALL q_ima(FALSE,TRUE,g_omb[l_ac].omb44)
                      RETURNING g_omb[l_ac].omb04
                 DISPLAY g_omb[l_ac].omb04 TO omb04
                 NEXT FIELD omb04
              WHEN INFIELD(omb40)                                                                                                   
                 CALL cl_init_qry_var()                                                                                             
                 CALL q_m_azf(FALSE,TRUE,g_omb[l_ac].omb40,'2','',g_omb[l_ac].omb44)
                      RETURNING g_omb[l_ac].omb40
                 DISPLAY g_qryparam.multiret TO omb40                                                                               
                 NEXT FIELD omb40                                                                                                   
              WHEN INFIELD(omb44)     #门店编号
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_azw"
                 LET g_qryparam.default1 = g_omb[l_ac].omb44
                 LET g_qryparam.where = "azw02 = '",g_legal,"' "
                 CALL cl_create_qry() RETURNING g_omb[l_ac].omb44
                 DISPLAY g_omb[l_ac].omb44 TO omb44
                 NEXT FIELD omb44
                
               WHEN INFIELD(omb31)
                 IF g_ooz.ooz65='N' THEN 
                    IF g_oma.oma00 != '16' AND g_oma.oma00 != '18'  AND  g_oma.oma00 != '26'    #FUN-960140 add
                       AND g_oma.oma00 != '14'            #TQC-A40100 Add
                       AND g_oma.oma00 != '27'  THEN      #FUN-960140 add
                       CASE g_oma.oma00
                             WHEN '11'
                                 IF g_azw.azw04 = '2' THEN
                                    CALL q_oeb9(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,
                                               g_oma.oma211,g_oma.oma24,g_omb[l_ac].omb44)   #FUN-9A0093 add omb44
                                 ELSE
                                    CALL q_oeb1(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,
                                               g_oma.oma211,g_oma.oma24,g_omb[l_ac].omb44)   #FUN-9A0093 add omb44
                                 END IF         #FUN-960140
                             WHEN '21'
                                 CALL q_ohb1(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,
                                            g_oma.oma211,g_oma.oma24,g_oma.oma00,g_oma.oma02, #No.MOD-890208
                                            g_omb[l_ac].omb44)   #FUN-9A0093
                             OTHERWISE
                                  IF g_azw.azw04 = '2' THEN
                                     CALL q_ogb4(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,
                                          g_oma.oma211,g_oma.oma24,g_oma.oma58,
                                          g_oma.oma00,g_oma.oma02,g_omb[l_ac].omb44)    #FUN-9A0093 add omb44
                                  ELSE
                                     CALL q_ogb(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,
                                            g_oma.oma211,g_oma.oma24,g_oma.oma58,g_oma.oma00,g_oma.oma02,    #TQC-750058
                                            g_omb[l_ac].omb44)    #FUN-9A0093
                                  END IF         #FUN-960140 
                       END CASE           
                   END IF     #FUN-960140 add         
                 ELSE 
                    CASE g_omb[l_ac].omb38
                      WHEN '1'
                        CALL q_oeb8(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68)
                      WHEN '2'
                        CALL q_ogb2(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68,'2')   #MOD-870209
                      WHEN '3'
                        CALL q_ohb2(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68,g_oma.oma00,g_oma.oma02) #No.MOD-890208 
                      WHEN '4'
                        CALL q_ogb3(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68)
                      WHEN '5'
                        CALL q_ohb3(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68,g_oma.oma00) 
                      WHEN '99'
                        CALL q_ogb2(TRUE,TRUE,g_oma.oma03,g_oma.oma01,g_oma.oma213,g_oma.oma211,g_oma.oma24,g_oma.oma68,'99')   #MOD-870209
                      OTHERWISE EXIT CASE
                    END CASE
                 END IF       #No.TQC-6C0085 
                 DISPLAY g_omb[l_ac].omb31 TO omb31             #No.MOD-490344
                #-TQC-B60089-add-
                 LET g_ogb_o.* = g_ogb.*
                 LET g_sql = " SELECT * ",
                             "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                             "  WHERE ogb01 = '",g_omb[l_ac].omb31,"'",
                             "    AND ogb03 = '",g_omb[l_ac].omb32,"'"
                 CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
                 CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql            
                 PREPARE sel_ogb_pre19 FROM g_sql
                 EXECUTE sel_ogb_pre19 INTO g_ogb.*
                #-TQC-B60089-end-
                #-------------------------------No.CHI-B90025----------------------------------start
                 IF g_oma.oma00='11' THEN
                    SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                     WHERE oeaa01 = g_oma.oma16
                       AND oeaa02 = '1'
                       AND oeaa03 = g_oma.oma165
                       AND oeaa01 = oea01
                 END IF
                 IF g_oma.oma00='13' THEN
                    SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
                     WHERE oeaa01 = g_oma.oma16
                       AND oeaa02 = '2'
                       AND oeaa03 = g_oma.oma165
                       AND oeaa01 = oea01
                 END IF
                 CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
                #CALL t300_bu()
                #-------------------------------No.CHI-B90025----------------------------------end
                 LET g_ogb.* = g_ogb_o.*     #TQC-B60089
                 CALL t300_b_fill(' 1=1')
                 CALL t300_b() 
                 EXIT INPUT                    #FUN-640246
               WHEN INFIELD(omb05)
                 CALL cl_init_qry_var()
                 CALL q_gfe(FALSE,TRUE,g_omb[l_ac].omb44)
                      RETURNING g_omb[l_ac].omb05
                 DISPLAY g_omb[l_ac].omb05 TO omb05
                 NEXT FIELD omb05
                WHEN INFIELD(omb41)  #專案
                  CALL cl_init_qry_var()
                  CALL q_pja(FALSE,TRUE,g_omb[l_ac].omb41,g_omb[l_ac].omb44)
                       RETURNING g_omb[l_ac].omb41
                  DISPLAY BY NAME g_omb[l_ac].omb41
                  NEXT FIELD omb41
                WHEN INFIELD(omb42)  #WBS
                  CALL cl_init_qry_var()
                  CALL q_pjb(FALSE,TRUE,g_omb[l_ac].omb42,g_omb[l_ac].omb41,g_omb[l_ac].omb44)
                       RETURNING g_omb[l_ac].omb42
                  DISPLAY BY NAME g_omb[l_ac].omb42
                  NEXT FIELD omb42
               WHEN INFIELD(omb33)
                 CALL cl_init_qry_var()
                 CALL q_m_aag(FALSE,TRUE,g_omb[l_ac].omb44,g_omb[l_ac].omb33,'23',g_bookno1)
                      RETURNING g_omb[l_ac].omb33
                 DISPLAY g_omb[l_ac].omb33 TO omb33
                 NEXT FIELD omb33
               WHEN INFIELD(omb331)
                 CALL cl_init_qry_var()
                 CALL q_m_aag(FALSE,TRUE,g_omb[l_ac].omb44,g_omb[l_ac].omb331,'23',g_bookno2)
                      RETURNING g_omb[l_ac].omb331
                 DISPLAY g_omb[l_ac].omb331 TO omb331
                 NEXT FIELD omb331
               WHEN INFIELD(omb930)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_gem4"
                  CALL cl_create_qry() RETURNING g_omb[l_ac].omb930
                  DISPLAY BY NAME g_omb[l_ac].omb930
                  NEXT FIELD omb930
            END CASE
 
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION other_data
           CALL t300_b_more()
 
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
 
 
      END INPUT
      IF g_oma.oma00 = '12' or g_oma.oma00 = '13' or g_oma.oma00='21' THEN #來源類型為出貨及尾款或折讓
         IF g_oma.oma50 <0 or g_oma.oma50t<0 or g_oma.oma56 <0 or 
            g_oma.oma56t<0 or g_oma.oma59 <0 or g_oma.oma59t<0 THEN
            CALL cl_err('','axr-155',1)
            IF cl_confirm('axr-159') THEN         #繼續輸入單身
               CALL t300_b()
            END IF
         END IF
      END IF
      IF g_oma.oma00 = '25' THEN
         FOR l_i = 1 TO l_ac
           IF NOT cl_null(g_omb[l_i].omb31) THEN   #No.B478 010503 by linda mod
             SELECT oma24,oma58 INTO l_oma24,l_oma58
               FROM oma_file
              WHERE oma16 = g_omb[l_i].omb31     #modi by canny(980707)
                AND oma00 MATCHES '1*'
             IF STATUS THEN 
                CALL cl_err3("sel","oma_file",g_omb[l_i].omb31,"",STATUS,"","",1)  #No.FUN-660116
             END IF
             UPDATE oma_file SET oma24 = l_oma24,oma60=l_oma24,oma58 = l_oma58
              WHERE oma01 = g_oma.oma01
             IF STATUS OR SQLCA.SQLCODE THEN
                CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.SQLCODE,"","upd omab",1)  #No.FUN-660116
             END IF
             LET g_oma.oma24 = l_oma24
             LET g_oma.oma58 = l_oma58
             DISPLAY BY NAME g_oma.oma24,g_oma.oma58
             EXIT FOR
           END IF
         END FOR
      END IF
 
     IF g_oma.omaconf <> 'Y' THEN
        UPDATE oma_file SET omamodu = g_user,omadate = g_today,oma64 = l_oma64
         WHERE oma01 = g_oma.oma01
        LET g_oma.oma64 = l_oma64
        DISPLAY BY NAME g_oma.oma64
     END IF
     IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
     CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
    CLOSE t300_bcl
    COMMIT WORK
    CALL s_up_omb(g_oma.oma01)
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
    CALL t300_ins_omc('1')  #TQC-750177                         #No.FUN-680022
    CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1           #No.FUN-550071
    IF g_t1 IS NOT NULL THEN   #97/06/19 modify
       SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
       IF STATUS THEN RETURN END IF
       IF g_ooy.ooydmy1 = 'Y' THEN                       #MOD-920356
          IF cl_confirm('axr-309') THEN
             CALL t300_v0()  #No.8161
          END IF
       END IF
       #單據已確認或單據不需自動確認,或需簽核  #FUN-640246
       IF (g_oma.omaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr = 'Y') THEN
          SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
          CALL t300_show()
          RETURN
       ELSE
          LET g_action_choice = "insert"                     #FUN-640246
          CALL s_showmsg_init() #CHI-A80031 add
          CALL t300_y_chk()          #CALL 原確認的 check 段
          IF g_success = "Y" THEN
             CALL t300_y_upd()       #CALL 原確認的 update 段
          END IF
          CALL s_showmsg()  #CHI-A80031 add
          LET g_action_choice = ""
       END IF
       IF g_ooy.ooyprit='Y' THEN CALL t300_out() END IF   #單據需立即列印
    END IF
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
   CALL t300_show()
END FUNCTION
FUNCTION t300_set_entry_b()

   #MOD-A10141---add---start---
    IF g_oma.oma00 = '14' THEN
       CALL cl_set_comp_entry("omb04,omb06",TRUE)                
    END IF
   #MOD-A10141---add---end---
    CALL cl_set_comp_entry("omb31,omb32",TRUE)   #FUN-960140  add
 
    CALL cl_set_comp_entry("omb44",TRUE)     #FUN-990031

    IF INFIELD(omb31) THEN
       CALL cl_set_comp_entry("omb04,omb05,omb06",TRUE)
    END IF
    CALL cl_set_comp_entry("omb33,omb331",TRUE)   #MOD-690136
    CALL cl_set_comp_entry("omb41,omb42",TRUE)   #FUN-810045
    CALL cl_set_comp_entry("omb03,omb38,omb31,omb32,omb39,omb04,
                            omb06,omb40,omb05,omb12,omb13,omb14,
                            omb14t,omb15,omb16,omb16t,omb17,omb18,
                            omb18t,omb930",TRUE)
END FUNCTION
 
FUNCTION t300_set_no_entry_b_1()
 IF g_oma.oma64 matches '[Ss]' THEN
    CALL cl_set_comp_entry("omb03,omb38,omb31,omb32,omb39,omb04,omb06,
                            omb40,omb05,omb12,omb13,omb14,omb14t,omb15,
                            omb16,omb16t,omb17,omb18,omb18t,omb930",FALSE)
 END IF
END FUNCTION
 
FUNCTION t300_set_no_entry_b(p_cmd)  #FUN-960140
   DEFINE l_oga07   LIKE oga_file.oga07   #MOD-690136
   DEFINE p_cmd     LIKE type_file.chr1   #FUN-960140

    IF g_oma.oma00 <> '14' THEN                      #MOD-A10141 add
       IF INFIELD(omb31) THEN
          IF NOT cl_null(g_omb[l_ac].omb31) THEN
             CALL cl_set_comp_entry("omb04,omb05,omb06",FALSE)
          END IF
       END IF
    END IF                                           #MOD-A10141 add
    LET l_oga07= ''
    #LET l_sql = "SELECT oga07 FROM ",li_dbs CLIPPED,"oga_file ",
    LET l_sql = "SELECT oga07 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                " WHERE oga01='",g_omb[l_ac].omb31,"' "
    CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
    CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
    PREPARE sel_oga07_pre FROM l_sql
    EXECUTE sel_oga07_pre INTO l_oga07
    IF l_oga07 = 'Y' THEN
       CALL cl_set_comp_entry("omb33,omb331",FALSE)
    END IF
     IF NOT cl_null(g_omb[l_ac].omb31) THEN
        CALL cl_set_comp_entry("omb41,omb42",FALSE)
     END IF
   #IF (g_oma.oma00='12' OR g_oma.oma00='13') AND   #CHI-A50040 mark
    IF g_oma.oma00='12' AND                         #CHI-A50040
       NOT cl_null(g_omb[l_ac].omb32) THEN
       IF g_omb[l_ac].omb32 >= 9001 THEN
          LET g_omb[l_ac].omb38 = '4'
       END IF
       IF g_omb[l_ac].omb38 = '2' THEN  
          #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ogb_file ",
          LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                      " WHERE ogb01='",g_omb[l_ac].omb31,"' ",
                      "   AND ogb03='",g_omb[l_ac].omb32,"' ",
                      "   AND ogb1005 != '2' "
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
          PREPARE sel_ogb_pre FROM l_sql
          EXECUTE sel_ogb_pre INTO g_ogb.*
          IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60-g_ogb.ogb64)) THEN 
             CALL cl_set_comp_entry("omb03,omb38,omb31,omb32,omb39,omb04,
                                     omb06,omb40,omb05,omb12,omb41,omb42,
                                     omb13,omb14,omb14t,omb15,omb16,omb16t,
                                     omb17,omb18,omb18t,omb930",FALSE)
          END IF
          IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60+g_ogb.ogb64)) THEN  
             CALL cl_set_comp_entry("omb03,omb38,omb31,omb32,omb39,omb04,
                                     omb06,omb40,omb05,omb12,omb41,omb42,
                                     omb13,omb14,omb14t,omb15,omb16,omb16t,
                                     omb17,omb18,omb18t,omb930",FALSE)
          END IF                                                                  
       END IF
       IF g_omb[l_ac].omb38 = '4' THEN
          #LET l_sql = "SELECT * FROM ",li_dbs CLIPPED,"ogb_file ",
          LET l_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                      " WHERE ogb01='",g_omb[l_ac].omb31,"' ",
                      "   AND ogb03='",g_omb[l_ac].omb32,"' ",
                      "   AND ogb1005 = '2' "
          CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
          CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102               
          PREPARE sel_ogb_pre1 FROM l_sql
          EXECUTE sel_ogb_pre1 INTO g_ogb.*
          IF g_oma.oma00='12' AND (g_ogb.ogb917<=(g_ogb.ogb60-g_ogb.ogb64)) THEN 
             CALL cl_set_comp_entry("omb03,omb38,omb31,omb32,omb39,omb04,
                                     omb06,omb40,omb05,omb12,omb41,omb42,
                                     omb13,omb14,omb14t,omb15,omb16,omb16t,
                                     omb17,omb18,omb18t,omb930",FALSE)
          END IF
       END IF
    END IF
 
    IF g_oma.oma00 = '12' AND p_cmd MATCHES '[uU]' AND NOT cl_null(b_omb.omb31) THEN
       CALL cl_set_comp_entry("omb31,omb32",FALSE)
    END IF
 
    IF NOT cl_null(g_oma.oma66) THEN
       CALL cl_set_comp_entry("omb44",FALSE)
    END IF 

    #add by zhangym 111103 begin-----
    IF p_cmd = 'u' AND (g_oma.oma00 = '11' OR g_oma.oma00 = '12' OR g_oma.oma00 = '13') THEN 
       CALL cl_set_comp_entry("omb12",FALSE)
    END IF 
    #add by zhangym 111103 end-----    
    
END FUNCTION
 
FUNCTION t300_b_move_to()
  LET g_omb[l_ac].omb31 = b_omb.omb31 LET g_omb[l_ac].omb32 = b_omb.omb32
  LET g_omb[l_ac].omb04 = b_omb.omb04
  LET g_omb[l_ac].omb06 = b_omb.omb06
  LET g_omb[l_ac].omb40 = b_omb.omb40  #No.FUN-660073
  LET g_omb[l_ac].omb05 = b_omb.omb05
  LET g_omb[l_ac].omb12 = b_omb.omb12
  LET g_omb[l_ac].omb41 = b_omb.omb41
  LET g_omb[l_ac].omb42 = b_omb.omb42
  LET g_omb[l_ac].omb44 = b_omb.omb44   #FUN-990031
  LET g_omb[l_ac].omb33 = b_omb.omb33
  LET g_omb[l_ac].omb331= b_omb.omb331 #FUN-670047
  LET g_omb[l_ac].omb13 = b_omb.omb13
  LET g_omb[l_ac].omb14 = b_omb.omb14 LET g_omb[l_ac].omb14t= b_omb.omb14t
  LET g_omb[l_ac].omb15 = b_omb.omb15
  LET g_omb[l_ac].omb16 = b_omb.omb16 LET g_omb[l_ac].omb16t= b_omb.omb16t
  LET g_omb[l_ac].omb17 = b_omb.omb17
  LET g_omb[l_ac].omb18 = b_omb.omb18 LET g_omb[l_ac].omb18t= b_omb.omb18t
#No.FUN-AB0034 --begin
  LET g_omb[l_ac].omb45 = b_omb.omb45
  LET g_omb[l_ac].omb47 = b_omb.omb47
#No.FUN-AB0034 --end
  LET g_omb[l_ac].omb39 = b_omb.omb39 #No.FUN-670026 --add
  LET g_omb[l_ac].omb930 = b_omb.omb930 #FUN-680001
  LET g_omb[l_ac].ombud01 = b_omb.ombud01
  LET g_omb[l_ac].ombud02 = b_omb.ombud02
  LET g_omb[l_ac].ombud03 = b_omb.ombud03
  LET g_omb[l_ac].ombud04 = b_omb.ombud04
  LET g_omb[l_ac].ombud05 = b_omb.ombud05
  LET g_omb[l_ac].ombud06 = b_omb.ombud06
  LET g_omb[l_ac].ombud07 = b_omb.ombud07
  LET g_omb[l_ac].ombud08 = b_omb.ombud08
  LET g_omb[l_ac].ombud09 = b_omb.ombud09
  LET g_omb[l_ac].ombud10 = b_omb.ombud10
  LET g_omb[l_ac].ombud11 = b_omb.ombud11
  LET g_omb[l_ac].ombud12 = b_omb.ombud12
  LET g_omb[l_ac].ombud13 = b_omb.ombud13
  LET g_omb[l_ac].ombud14 = b_omb.ombud14
  LET g_omb[l_ac].ombud15 = b_omb.ombud15
END FUNCTION
FUNCTION t300_b_move_back()
  LET b_omb.omb00 = g_oma.oma00
  LET b_omb.omb03 = g_omb[l_ac].omb03
  LET b_omb.omb31 = g_omb[l_ac].omb31 LET b_omb.omb32 = g_omb[l_ac].omb32
  LET b_omb.omb04 = g_omb[l_ac].omb04
  LET b_omb.omb06 = g_omb[l_ac].omb06
  LET b_omb.omb40 = g_omb[l_ac].omb40  #No.FUN-660073
  LET b_omb.omb05 = g_omb[l_ac].omb05
  LET b_omb.omb12 = g_omb[l_ac].omb12
  LET b_omb.omb41 = g_omb[l_ac].omb41
  LET b_omb.omb42 = g_omb[l_ac].omb42
  LET b_omb.omb44 = g_omb[l_ac].omb44  #FUN-990031
  LET b_omb.omb33 = g_omb[l_ac].omb33
  LET b_omb.omb331= g_omb[l_ac].omb331 #FUN-670047
  LET b_omb.omb13 = g_omb[l_ac].omb13
  LET b_omb.omb14 = g_omb[l_ac].omb14 LET b_omb.omb14t= g_omb[l_ac].omb14t
  LET b_omb.omb15 = g_omb[l_ac].omb15
  LET b_omb.omb16 = g_omb[l_ac].omb16 LET b_omb.omb16t= g_omb[l_ac].omb16t
  LET b_omb.omb17 = g_omb[l_ac].omb17
  LET b_omb.omb18 = g_omb[l_ac].omb18 LET b_omb.omb18t= g_omb[l_ac].omb18t
  LET b_omb.omb38 = g_omb[l_ac].omb38 #No.FUN-670026 by cl
  LET b_omb.omb39 = g_omb[l_ac].omb39 #No.TQC-790125
  IF b_omb.omb34 IS NULL THEN LET b_omb.omb34=0 END IF
  IF b_omb.omb35 IS NULL THEN LET b_omb.omb35=0 END IF
#No.FUN-AB0034 --begin
  LET b_omb.omb45 = g_omb[l_ac].omb45
  LET b_omb.omb47 = g_omb[l_ac].omb47
#No.FUN-AB0034 --end
  LET b_omb.omb930 = g_omb[l_ac].omb930  #FUN-680001
  LET b_omb.ombud01 = g_omb[l_ac].ombud01
  LET b_omb.ombud02 = g_omb[l_ac].ombud02
  LET b_omb.ombud03 = g_omb[l_ac].ombud03
  LET b_omb.ombud04 = g_omb[l_ac].ombud04
  LET b_omb.ombud05 = g_omb[l_ac].ombud05
  LET b_omb.ombud06 = g_omb[l_ac].ombud06
  LET b_omb.ombud07 = g_omb[l_ac].ombud07
  LET b_omb.ombud08 = g_omb[l_ac].ombud08
  LET b_omb.ombud09 = g_omb[l_ac].ombud09
  LET b_omb.ombud10 = g_omb[l_ac].ombud10
  LET b_omb.ombud11 = g_omb[l_ac].ombud11
  LET b_omb.ombud12 = g_omb[l_ac].ombud12
  LET b_omb.ombud13 = g_omb[l_ac].ombud13
  LET b_omb.ombud14 = g_omb[l_ac].ombud14
  LET b_omb.ombud15 = g_omb[l_ac].ombud15
  LET b_omb.omblegal = g_legal #FUN-980011 add
END FUNCTION
FUNCTION t300_b_else()
END FUNCTION
 
FUNCTION t300_mlog(p_cmd)      # Transaction Modify Log (存入 oem_file)
  DEFINE p_cmd     LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)
END FUNCTION

#-------------------------------No.CHI-B90025----------------------------------start-mark 
#FUNCTION t300_bu()        # 注意: 此段_bu()必須與 s_g_ar.4gl 的_bu()完全相同
#   DEFINE l_oma54     LIKE oma_file.oma54   #CHI-A50040
#   DEFINE l_oma54t    LIKE oma_file.oma54t  #CHI-A50040
#   DEFINE l_oma56     LIKE oma_file.oma56   #CHI-A50040
#   DEFINE l_oma56t    LIKE oma_file.oma56t  #CHI-A50040
#   DEFINE l_sumogb14  LIKE ogb_file.ogb14   #CHI-A50040     #出貨總金額(未稅)
#   DEFINE l_sumogb14t LIKE ogb_file.ogb14t  #CHI-A50040     #出貨總金額(含稅)
#   DEFINE l_11_oma54  LIKE oma_file.oma54   #CHI-A50040     #訂金金額(未稅)
#   DEFINE l_11_oma54t LIKE oma_file.oma54t  #CHI-A50040     #訂金金額(含稅)
#   DEFINE l_12_oma52  LIKE oma_file.oma52   #No:FUN-A50103  #分批訂金金額(未稅)
#   DEFINE l_12_oma54  LIKE oma_file.oma54   #CHI-A50040     #分批出貨金額(未稅)
#   DEFINE l_12_oma54t LIKE oma_file.oma54t  #CHI-A50040     #分批出貨金額(含稅)
#   DEFINE l_13_oma54  LIKE oma_file.oma54   #CHI-A50040     #尾款金額(未稅)
#   DEFINE l_13_oma54t LIKE oma_file.oma54t  #CHI-A50040     #尾款金額(含稅)
#   DEFINE l_oeb917    LIKE oeb_file.oeb917  #CHI-A50040
#   DEFINE l_ogb917    LIKE ogb_file.ogb917  #CHI-A50040
#   DEFINE l_sumogb917 LIKE ogb_file.ogb917  #MOD-B50230     #出貨總數量
#   DEFINE l_flag2     LIKE type_file.chr1   #CHI-A50040 
#   DEFINE l_sumomb16  LIKE omb_file.omb16   #CHI-A50040     #出貨總金額(未稅)
#   DEFINE l_sumomb16t LIKE omb_file.omb16t  #CHI-A50040     #出貨總金額(含稅)
#   DEFINE l_11_oma56  LIKE oma_file.oma56   #CHI-A50040     #訂金金額(未稅)
#   DEFINE l_11_oma56t LIKE oma_file.oma56t  #CHI-A50040     #訂金金額(含稅)
#   DEFINE l_12_oma53  LIKE oma_file.oma53   #No:FUN-A50103  #分批訂金金額(未稅)
#   DEFINE l_12_oma56  LIKE oma_file.oma56   #CHI-A50040     #分批出貨金額(未稅)
#   DEFINE l_12_oma56t LIKE oma_file.oma56t  #CHI-A50040     #分批出貨金額(含稅)
#   DEFINE l_13_oma56  LIKE oma_file.oma56   #CHI-A50040     #尾款金額(未稅)
#   DEFINE l_13_oma56t LIKE oma_file.oma56t  #CHI-A50040     #尾款金額(含稅)
#   DEFINE l_sumomb18  LIKE omb_file.omb18   #CHI-A50040     #發票出貨總金額(未稅)
#   DEFINE l_sumomb18t LIKE omb_file.omb18t  #CHI-A50040     #發票出貨總金額(含稅)
#   DEFINE l_11_oma59  LIKE oma_file.oma59   #CHI-A50040     #發票訂金金額(未稅)
#   DEFINE l_11_oma59t LIKE oma_file.oma59t  #CHI-A50040     #發票訂金金額(含稅)
#   DEFINE l_12_oma59  LIKE oma_file.oma59   #CHI-A50040     #發票分批出貨金額(未稅)
#   DEFINE l_12_oma59t LIKE oma_file.oma59t  #CHI-A50040     #發票分批出貨金額(含稅)
#   DEFINE l_13_oma59  LIKE oma_file.oma59   #CHI-A50040     #發票尾款金額(未稅)
#   DEFINE l_13_oma59t LIKE oma_file.oma59t  #CHI-A50040     #發票尾款金額(含稅)
#   DEFINE l_oea61     LIKE oea_file.oea61    #No:FUN-A50103
#   DEFINE l_oea1008   LIKE oea_file.oea1008  #No:FUN-A50103
#   DEFINE l_oea261    LIKE oea_file.oea261   #No:FUN-A50103
#   DEFINE l_oea262    LIKE oea_file.oea262   #No:FUN-A50103
#   DEFINE l_oea263    LIKE oea_file.oea263   #No:FUN-A50103
#   DEFINE l_oeaa08    LIKE oeaa_file.oeaa08  #No:FUN-A50103
#   DEFINE l_cnt       LIKE type_file.num5   #MOD-A70194
#
#   #-----No:FUN-A50103-----
#   IF g_oma.oma00='11' THEN
#      SELECT oeaa08 INTO l_oeaa08 FROM oeaa_file
#       WHERE oeaa01 = g_oma.oma16
#         AND oeaa02 = '1'
#         AND oeaa03 = g_oma.oma165
#   END IF
#
#   IF g_oma.oma00='13' THEN
#      SELECT oeaa08 INTO l_oeaa08 FROM oeaa_file
#       WHERE oeaa01 = g_oma.oma16
#         AND oeaa02 = '2'
#         AND oeaa03 = g_oma.oma165
#
#      SELECT oea61,oea1008,oea261,oea262,oea263
#        INTO l_oea61,l_oea1008,l_oea261,l_oea262,l_oea263
#       FROM oea_file
#      WHERE oea01 = g_oma.oma16
#   END IF
#
#   IF g_oma.oma00 = '12' THEN
#      SELECT oea61,oea1008,oea261,oea262,oea263
#        INTO l_oea61,l_oea1008,l_oea261,l_oea262,l_oea263
#       FROM oea_file
#      WHERE oea01 = g_ogb.ogb31
#   END IF
#   #-----No:FUN-A50103 END-----
#
#   #-----No:CHI-A70015-----
#   IF STATUS THEN     #找不到訂單，表無訂單出貨
#      LET l_oea61 = 100
#      LET l_oea1008 = 100
#      LET l_oea261 = 0
#      LET l_oea262 = 100
#      LET l_oea263 = 0
#   END IF
#   #-----No:CHI-A70015 END-----
#
#   LET g_oma.oma50 = 0 LET g_oma.oma50t= 0
#   LET l_flag2 = 'N'                                           #CHI-A50040
##No.FUN-AB0034 --begin
#   SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#     FROM omb_file WHERE omb01=g_oma.oma01 
#   IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#   IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
#   IF g_oma.oma74 ='2' THEN 
#      SELECT SUM(omb14),SUM(omb16) INTO g_oma.oma73f,g_oma.oma73
#        FROM omb_file WHERE omb01=g_oma.oma01 
#      IF g_oma.oma73 IS NULL THEN LET g_oma.oma73=0 END IF
#      IF g_oma.oma73f IS NULL THEN LET g_oma.oma73f=0 END IF
#   ELSE 
#      LET g_oma.oma73 = 0
#      LET g_oma.oma73f= 0
#   END IF 
##No.FUN-AB0034 --end 
#  #-CHI-A50040-mark-
#  #IF g_oma.oma213='N'
#  #   THEN LET g_oma.oma50t=g_oma.oma50 *(1+g_oma.oma211/100)
#  #   ELSE LET g_oma.oma50 =g_oma.oma50t*100/(100+g_oma.oma211)
#  #END IF
#  #-CHI-A50040-end-
#   LET g_oma.oma52 = 0   #MOD-680041
#   CASE WHEN g_oma.oma00 = '11' 
#            #-----No:FUN-A50103-----
#            IF g_oma.oma213 = 'Y' THEN
#               LET g_oma.oma54t = l_oeaa08
#               LET g_oma.oma54  = g_oma.oma54t/(1+ g_oma.oma211/100)
#            ELSE
#               LET g_oma.oma54  = l_oeaa08
#               LET g_oma.oma54t = g_oma.oma54*(1+ g_oma.oma211/100)
#            END IF
#           #LET g_oma.oma54 = g_oma.oma50 *g_oma.oma161/100
#           #LET g_oma.oma54t= g_oma.oma50t*g_oma.oma161/100
#            #-----No:FUN-A50103 END-----
#       WHEN g_oma.oma00 = '12'
#          #-TQC-B60089-mark-
#          ##-MOD-A70194-add-
#          # LET l_cnt = 0
#          ##-MOD-AB0101-add-
#          ##SELECT count(*) INTO l_cnt
#          ##  FROM oeb_file
#          ## WHERE oeb01 = g_ogb.ogb31 AND oeb03 = g_ogb.ogb32
#          # LET g_sql = "SELECT COUNT(*) ",
#          #             "  FROM ",cl_get_target_table(g_plant_new,'oeb_file'),        
#          #             " WHERE oeb01 = '",g_ogb.ogb31,"' AND oeb03 = '",g_ogb.ogb32,"'"
#          # CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	  # CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#          # PREPARE sel_oeb_pre01 FROM g_sql
#          # EXECUTE sel_oeb_pre01 INTO l_cnt  
#          ##-MOD-A70194-end-
#          #-TQC-B60089-end-
#           #-CHI-A50040-add- 
#           #若出貨數量大於訂單數量即表示超交
#           #SELECT oeb917 INTO l_oeb917  
#           #  FROM oeb_file
#           # WHERE oeb01 = g_ogb.ogb31 AND oeb03 = g_ogb.ogb32
#           #LET g_sql = "SELECT oeb917 ",         #MOD-B50230 mark
#            LET g_sql = "SELECT SUM(oeb917) ",    #MOD-B50230
#                        "  FROM ",cl_get_target_table(g_plant_new,'oeb_file'),        
#                       #" WHERE oeb01 = '",g_ogb.ogb31,"' AND oeb03 = '",g_ogb.ogb32,"'" #MOD-B50230 mark
#                        " WHERE oeb01 = '",g_ogb.ogb31,"'"                               #MOD-B50230
#            CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#            PREPARE sel_oeb_pre02 FROM g_sql
#            EXECUTE sel_oeb_pre02 INTO l_oeb917  
#           #-MOD-AB0101-end-
#            IF l_oeb917  IS NULL THEN LET l_oeb917 = 0 END IF
#           #抓取非此張出貨單的其他同訂單+項次數量
#           #-MOD-AB0101-add-
#           #SELECT SUM(ogb917) INTO l_ogb917  
#           # #FROM ogb_file
#           #  FROM ogb_file,oga_file    #No:FUN-A50103
#           # WHERE ogb01 <> g_ogb.ogb01
#           #   AND ogb31 = g_ogb.ogb31
#           #   AND ogb32 = g_ogb.ogb32
#           #   AND (oga10 IS NOT NULL AND oga10 <> ' ' )    #No:FUN-A50103
#           #   AND oga01 = ogb01    #No:FUN-A50103
#            LET g_sql = "SELECT SUM(ogb917)",
#                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",        
#                                  cl_get_target_table(g_plant_new,'ogb_file'),           
#                        " WHERE ogb01 <> '",g_ogb.ogb01,"' AND ogb31 = '",g_ogb.ogb31,"'",
#                       #"   AND ogb32 = '",g_ogb.ogb32,"'",      #MOD-B50230 mark
#                        "   AND (oga10 IS NOT NULL AND oga10 <> ' ' ) ",
#                       #"   AND oga01 = ogb01 AND oga09 IN ('2','3','4','8','A')"                  #MOD-B50216 mark 
#                        "   AND oga01 = ogb01 ",                                                   #MOD-B50216  
#                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "  #MOD-B50216
#            CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#            PREPARE sel_ogb_pre01 FROM g_sql
#            EXECUTE sel_ogb_pre01 INTO l_ogb917  
#           #-MOD-AB0101-end-
#            IF l_ogb917  IS NULL THEN LET l_ogb917 = 0 END IF
#           #-MOD-B50230-add-
#           #抓取此張出貨單的總數量
#            LET l_sumogb917 = 0
#            LET g_sql = "SELECT SUM(ogb917)",
#                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",        
#                                  cl_get_target_table(g_plant_new,'ogb_file'),           
#                        " WHERE ogb01 = '",g_ogb.ogb01,"' AND ogb31 = '",g_ogb.ogb31,"'",
#                        "   AND oga01 = ogb01 ",                                                   
#                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) " 
#            CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#            PREPARE sel_ogb_pre08 FROM g_sql
#            EXECUTE sel_ogb_pre08 INTO l_sumogb917  
#            IF l_sumogb917  IS NULL THEN LET l_sumogb917 = 0 END IF
#           #抓取不是本張出貨單的其他訂金應收之訂金金額
#            LET l_12_oma52 = 0
#            LET g_sql = " SELECT SUM(oma52) ",
#                        " FROM oma_file ",
#                        " WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),  
#                        " WHERE oma16 = ogb01 ",
#                        "   AND oma16 <> '",g_ogb.ogb01,"'",
#                        "   AND (oma00 = '12' OR oma00 = '19')",  
#                        "   AND omavoid = 'N' ", 
#                        "   AND ogb31 = '",g_ogb.ogb31,"' AND omaconf = 'N')"
#            CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#            PREPARE sel_ogb_pre09 FROM g_sql
#            EXECUTE sel_ogb_pre09 INTO l_12_oma52
#            IF l_12_oma52  IS NULL THEN LET l_12_oma52 = 0 END IF   
#           #-MOD-B50230-end-
#          #-TQC-B60089-mark-
#          ##IF l_oeb917 < g_ogb.ogb917+l_ogb917 THEN
#          ##IF l_oeb917 <= g_ogb.ogb917+l_ogb917 THEN    #No:FUN-A50103         #MOD-A70194 mark
#          ##IF l_oeb917 <= g_ogb.ogb917+l_ogb917 AND l_cnt > 0 THEN             #MOD-A70194 #MOD-B50043
#          ##IF l_oeb917 < g_ogb.ogb917+l_ogb917 AND l_cnt > 0 THEN              #MOD-B50043 #MOD-B50230 mark
#          # IF l_oeb917 < l_sumogb917+l_ogb917 AND l_cnt > 0 THEN                           #MOD-B50230
#          #    LET l_flag2 = 'Y'   
#          #   #-MOD-AB0101-add-
#          #   #SELECT SUM(ogb14),SUM(ogb14t)
#          #   #  INTO l_sumogb14,l_sumogb14t
#          #   #  FROM ogb_file
#          #   # WHERE ogb31 = g_ogb.ogb31 
#          #   #此訂單在出貨單的金額 
#          #    LET g_sql = "SELECT SUM(ogb14),SUM(ogb14t)",
#          #                "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",        
#          #                          cl_get_target_table(g_plant_new,'ogb_file'),",",        
#          #                "         oma_file,omb_file ",                            #MOD-B50216
#          #                " WHERE ogb31 = '",g_ogb.ogb31,"'",
#          #               #"   AND ogb32 = '",g_ogb.ogb32,"'",                       #MOD-B10012 #MOD-B50230 mark 
#          #                "   AND oma01 = omb01 ",                                  #MOD-B50216
#          #                "   AND omavoid = 'N' ",                                  #MOD-B50216 
#          #                "   AND omb31 = ogb01 ",                                  #MOD-B50216 
#          #                "   AND omb32 = ogb03 ",                                  #MOD-B50216
#          #               #"   AND oga01 = ogb01 AND oga09 IN ('2','3','4','8','A') "                 #MOD-B50216 mark 
#          #                "   AND oga01 = ogb01 ",                                                   #MOD-B50216  
#          #                "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "  #MOD-B50216
#          #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	  #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#          #    PREPARE sel_ogb_pre02 FROM g_sql
#          #    EXECUTE sel_ogb_pre02 INTO l_sumogb14,l_sumogb14t 
#          #   #-MOD-AB0101-end-
#          #    IF l_sumogb14  IS NULL THEN LET l_sumogb14 = 0 END IF
#          #    IF l_sumogb14t IS NULL THEN LET l_sumogb14t = 0 END IF
#
#          #    #-----No:FUN-A50103-----
#          #    IF g_oma.oma213 = 'Y' THEN
#          #       ##-----No:CHI-A70015-----
#          #       #SELECT oea263 INTO l_13_oma54t
#          #       #  FROM oea_file
#          #       # WHERE oea01 = g_ogb.ogb31
#          #        LET l_13_oma54t = l_oea263  
#          #        #-----No:CHI-A70015 END-----
#          #       LET l_13_oma54  = l_13_oma54t/(1+ g_oma.oma211/100)
#          #       CALL cl_digcut(l_13_oma54,t_azi04) RETURNING l_13_oma54
#          #    ELSE
#          #       ##-----No:CHI-A70015-----
#          #       #SELECT oea263 INTO l_13_oma54
#          #       #  FROM oea_file
#          #       # WHERE oea01 = g_ogb.ogb31
#          #        LET l_13_oma54 = l_oea263  
#          #        #-----No:CHI-A70015 END-----
#          #       LET l_13_oma54t = l_13_oma54 *(1+ g_oma.oma211/100)
#          #       CALL cl_digcut(l_13_oma54t,t_azi04) RETURNING l_13_oma54t
#          #    END IF
#          #   #SELECT oma50,oma50t,oma54,oma54t
#          #   #  INTO l_13_oma54,l_13_oma54t,l_11_oma54,l_11_oma54t
#          #   #  FROM oma_file
#          #   # WHERE oma16 = g_ogb.ogb31 AND oma00 = '11' 
#          #    IF l_11_oma54  IS NULL THEN LET l_11_oma54 = 0 END IF  
#          #    IF l_11_oma54t IS NULL THEN LET l_11_oma54t = 0 END IF
#          #    IF l_13_oma54  IS NULL THEN LET l_13_oma54 = 0 END IF
#          #    IF l_13_oma54t IS NULL THEN LET l_13_oma54t = 0 END IF
#      
#          #   #LET l_13_oma54 = l_13_oma54  * g_oma.oma163/100
#          #   #LET l_13_oma54t= l_13_oma54t * g_oma.oma163/100
#          #   #CALL cl_digcut(l_13_oma54,t_azi04)  RETURNING l_13_oma54 
#          #   #CALL cl_digcut(l_13_oma54t,t_azi04) RETURNING l_13_oma54t 
#          #   ##-----No:FUN-A50103 END-----
#
#          #   #-MOD-B10012-add-
#          #   #SELECT SUM(oma52),SUM(oma54),SUM(oma54t)    #No:FUN-A50103 
#          #   #  INTO l_12_oma52,l_12_oma54,l_12_oma54t    #No:FUN-A50103 
#          #   #  FROM oma_file
#          #   # WHERE oma01 IN (SELECT oma01 FROM oma_file,ogb_file  
#          #   #                  WHERE oma16 = ogb01
#          #   #                    AND oma16 <> g_ogb.ogb01
#          #   #                    AND oma00 = '12' 
#          #   #                    AND omavoid = 'N' 
#          #   #                    AND ogb31 = g_ogb.ogb31) 
#          #   #抓取不是本張出貨單的其他出貨應收之未稅與含稅金額
#          #    LET g_sql = " SELECT SUM(oma54),SUM(oma54t) ",    #MOD-B50230 remove SUM(oma52) 
#          #                " FROM oma_file ",
#          #                " WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),  
#          #                " WHERE oma16 = ogb01 ",
#          #                "   AND oma16 <> '",g_ogb.ogb01,"'",
#          #                "   AND oma00 = '12' ", 
#          #                "   AND omavoid = 'N' ", 
#          #                "   AND ogb31 = '",g_ogb.ogb31,"')"   
#          #               #"   AND ogb32 = '",g_ogb.ogb32,"')"    #MOD-B50230 mark
#          #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	  #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#          #    PREPARE sel_ogb_pre04 FROM g_sql
#          #    EXECUTE sel_ogb_pre04 INTO l_12_oma54,l_12_oma54t #MOD-B50230 remove SUM(oma52) 
#          #   #-MOD-B10012-end-
#          #   #IF l_12_oma52  IS NULL THEN LET l_12_oma52 = 0 END IF    #No:FUN-A50103 #MOD-B50230 mark 
#          #    IF l_12_oma54  IS NULL THEN LET l_12_oma54 = 0 END IF
#          #    IF l_12_oma54t IS NULL THEN LET l_12_oma54t = 0 END IF
#
#          #    LET g_oma.oma54 = l_sumogb14 - l_11_oma54 - l_12_oma54 - l_13_oma54
#          #    LET g_oma.oma54t= l_sumogb14t - l_11_oma54t - l_12_oma54t - l_13_oma54t
#          #   #LET g_oma.oma52 = l_11_oma54
#          #    LET g_oma.oma52 = l_11_oma54 - l_12_oma52    #No:FUN-A50103
#          # ELSE
#          #    #-----No:FUN-A50103-----
#          #    IF g_oma.oma213 = 'Y' THEN 
#          #       LET g_oma.oma54 = g_oma.oma50 * l_oea262 / l_oea1008
#          #       LET g_oma.oma54t= g_oma.oma50t* l_oea262 / l_oea1008
#          #       LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea1008  #無收款 訂單轉銷貨收入實際計算
#          #    ELSE
#          #       LET g_oma.oma54 = g_oma.oma50 * l_oea262 / l_oea61
#          #       LET g_oma.oma54t= g_oma.oma50t* l_oea262 / l_oea61
#          #       LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61  #無收款 訂單轉銷貨收入實際計算
#          #    END IF
#          #   #LET g_oma.oma54 = g_oma.oma50 *g_oma.oma162/100
#          #   #LET g_oma.oma54t= g_oma.oma50t*g_oma.oma162/100
#          #   #LET g_oma.oma52 = g_oma.oma50 *g_oma.oma161/100  
#          #    #-----No:FUN-A50103 END-----
#          # END IF
#          #-TQC-B60089-end-
#           #-CHI-A50040-end-
#           #LET g_oma.oma54 = g_oma.oma50*(1-g_oma.oma163/100)     #CHI-A50040 mark
#           #LET g_oma.oma54t = g_oma.oma50t*(1-g_oma.oma163/100)   #CHI-A50040 mark
#           #IF g_oma.oma07='N' OR cl_null(g_oma.oma07) THEN        #CHI-A50040 mark
#              ##此段可能有問題,訂金轉銷貨收入不管業態現在都不記錄                                                                    
#              ##因為是根據1-尾款比例立賬的                                                                                           
#              #IF g_azw.azw04 = '2' THEN #零售業                   #CHI-A50040 mark                                                                                
#              #   LET g_oma.oma52 = 0                              #CHI-A50040 mark                                                                
#              #ELSE                                                #CHI-A50040 mark                                                                
#              #    LET g_oma.oma52 = 0 #FUN-960140 add             #CHI-A50040 mark
#              #END IF     #FUN-960141                              #CHI-A50040 mark
#              #CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52    #No.TQC-750093 g_azi -> t_azi
#           #-TQC-B60089-add-
#            LET g_oma.oma52 = g_oma.oma50 *g_oma.oma161/100
#            LET l_13_oma54  = g_oma.oma50 *g_oma.oma163/100
#            LET l_13_oma54t = g_oma.oma50t *g_oma.oma163/100
#            CALL cl_digcut(l_13_oma54,t_azi04) RETURNING l_13_oma54 
#            CALL cl_digcut(l_13_oma54t,t_azi04) RETURNING l_13_oma54t 
#           #-TQC-B60089-end-
#           #-CHI-A50040-add- 
#            #判斷變更後金額是否超出原待抵金額,
#            #若是的話,oma52=原待抵金額,oma54=變更後金額-原待抵金額
#            IF NOT cl_null(g_oma.oma19) THEN    #待抵帳款單號不為空
#               LET l_oma54=0  LET l_oma54t=0
#              #SELECT (oma54t-oma55),oma54t INTO l_oma54,l_oma54t
#               SELECT SUM(oma54t-oma55),SUM(oma54t) INTO l_oma54,l_oma54t    #No:FUN-A50103
#                 FROM oma_file 
#               #WHERE oma01=g_oma.oma19 
#                WHERE oma16=g_oma.oma19     #No:FUN-A50103
#              #IF l_oma54 < g_oma.oma52 THEN   #MOD-B50230 mark
#               IF l_oma54 < g_oma.oma52 OR l_oeb917 <= l_sumogb917+l_ogb917 THEN #MOD-B50230
#                 #LET g_oma.oma52 = l_oma54                 #原幣訂金      #MOD-B50230 mark
#                  LET g_oma.oma52 = l_oma54 - l_12_oma52    #原幣訂金      #MOD-B50230
#               END IF
#             ELSE                     #TQC-B60089 
#               LET g_oma.oma52 = 0    #TQC-B60089
#            END IF
#            CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52   #MOD-760078
#            LET g_oma.oma54 = g_oma.oma50 - g_oma.oma52 - l_13_oma54    #TQC-B60089
#            LET g_oma.oma54t= g_oma.oma50t - g_oma.oma52 - l_13_oma54t  #TQC-B60089
#           #-CHI-A50040-end- 
#           #END IF                                                 #CHI-A50040 mark
#       WHEN g_oma.oma00 = '13' 
#            #-----No:FUN-A50103-----
#            IF g_oma.oma213 = 'Y' THEN
#               LET g_oma.oma54t = l_oeaa08
#               LET g_oma.oma54  = g_oma.oma54t/(1+ g_oma.oma211/100)
#            ELSE
#               LET g_oma.oma54  = l_oeaa08
#               LET g_oma.oma54t = g_oma.oma54*(1+ g_oma.oma211/100)
#            END IF
#            IF l_oea262=0 AND l_oea263 >0 THEN
#               IF g_oma.oma213 = 'Y' THEN 
#                  LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea1008
#               ELSE
#                  LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61 
#               END IF
#               CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52    #No.TQC-750093 g_azi -> t_azi
#            END IF
#           #LET g_oma.oma54 = g_oma.oma50 *g_oma.oma163/100
#           #LET g_oma.oma54t= g_oma.oma50t*g_oma.oma163/100
#           #IF g_oma.oma162=0 AND g_oma.oma163 >0 THEN
#           #   LET g_oma.oma52 = g_oma.oma50 *g_oma.oma161/100
#           #   CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52    #No.TQC-750093 g_azi -> t_azi
#           #END IF
#           ##-----No:FUN-A50103 END-----
#       OTHERWISE
#            LET g_oma.oma54 = g_oma.oma50
#            LET g_oma.oma54t= g_oma.oma50t
#   END CASE
#   IF g_oma.oma213='N' THEN
#      #--- 97-04-18 原幣金額取位應為 t_azi04  #No.TQC-750093 g_azi -> t_azi
#      CALL cl_digcut(g_oma.oma54,t_azi04) RETURNING g_oma.oma54  #No.TQC-750093 g_azi -> t_azi
#      IF g_oma.oma00 = '11' THEN
#         LET g_oma.oma54x = 0
#      ELSE
#         LET g_oma.oma54x=g_oma.oma54*g_oma.oma211/100
#      END IF    #FUN-960140
#      CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x  #No.TQC-750093 g_azi -> t_azi
#      LET g_oma.oma54t=g_oma.oma54+g_oma.oma54x
#   ELSE 
#      CALL cl_digcut(g_oma.oma54t,t_azi04) RETURNING g_oma.oma54t  #No.TQC-750093 g_azi -> t_azi
#      IF g_oma.oma00 = '11' THEN                                                                                       
#         LET g_oma.oma54x = 0                                                                                          
#      ELSE 
#         LET g_oma.oma54x=g_oma.oma54t*g_oma.oma211/(100+g_oma.oma211)
#      END IF    #FUN-960140
#      CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x  #No.TQC-750093 g_azi -> t_azi
#      LET g_oma.oma54 =g_oma.oma54t-g_oma.oma54x
#   END IF
#   LET g_oma.oma56 = 0 LET g_oma.oma56t= 0
#   LET g_oma.oma53 = 0   #MOD-680041
#   SELECT SUM(omb16),SUM(omb16t) INTO g_oma.oma56,g_oma.oma56t
#     FROM omb_file 
#    WHERE omb01=g_oma.oma01 
#   IF g_oma.oma56  IS NULL THEN LET g_oma.oma56 =0 END IF   #CHI-A50040
#   IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t=0 END IF   #CHI-A50040
#   CASE WHEN g_oma.oma00 = '11' 
#             #-----No:FUN-A50103-----
#             LET g_oma.oma56  = g_oma.oma54 * g_oma.oma24
#             LET g_oma.oma56t = g_oma.oma54t* g_oma.oma24
#            #LET g_oma.oma56 = g_oma.oma56 *g_oma.oma161/100
#            #LET g_oma.oma56t= g_oma.oma56t*g_oma.oma161/100
#             #-----No:FUN-A50103 END-----
#        WHEN g_oma.oma00 = '12' 
#           #-TQC-B60089-add-
#           ##-MOD-B50230-add-
#           ##抓取不是本張出貨單的其他訂金應收之訂金金額
#           # LET l_12_oma53 = 0
#           # LET g_sql = " SELECT SUM(oma53) ",
#           #             " FROM oma_file ",
#           #             " WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),  
#           #             " WHERE oma16 = ogb01 ",
#           #             "   AND oma16 <> '",g_ogb.ogb01,"'",
#           #             "   AND (oma00 = '12' OR oma00 = '19')", 
#           #             "   AND omavoid = 'N' ", 
#           #             "   AND ogb31 = '",g_ogb.ogb31,"' AND omaconf = 'N')"
#           # CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	   # CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#           # PREPARE sel_ogb_pre10 FROM g_sql
#           # EXECUTE sel_ogb_pre10 INTO l_12_oma53
#           # IF l_12_oma53  IS NULL THEN LET l_12_oma53 = 0 END IF   
#           ##-MOD-B50230-end-
#           ##-CHI-A50040-add-
#           # IF l_flag2 = 'Y' THEN
#           #   #-MOD-AB0101-add-
#           #   #SELECT SUM(omb16),SUM(omb16t)
#           #   #  INTO l_sumomb16,l_sumomb16t
#           #   #  FROM omb_file,ogb_file
#           #   # WHERE omb31 = ogb01 AND omb32 = ogb03 AND ogb31 = g_ogb.ogb31 
#           #   #此訂單在出貨單的金額 
#           #    LET g_sql = "SELECT SUM(omb16),SUM(omb16t) ",
#           #                "  FROM oma_file,omb_file,",
#           #                        cl_get_target_table(g_plant_new,'ogb_file'),        
#           #                " WHERE omb31 = ogb01 AND omb32 = ogb03 AND ogb31 = '",g_ogb.ogb31,"'",
#           #               #"   AND ogb32 = '",g_ogb.ogb32,"'",                 #MOD-B10012 #MOD-B50230 mark 
#           #                "   AND oma01 = omb01 AND omavoid = 'N' "     
#           #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	   #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#           #    PREPARE sel_ogb_pre03 FROM g_sql
#           #    EXECUTE sel_ogb_pre03 INTO l_sumomb16,l_sumomb16t 
#           #   #-MOD-AB0101-end-
#           #    IF l_sumomb16  IS NULL THEN LET l_sumomb16 = 0 END IF
#           #    IF l_sumomb16t IS NULL THEN LET l_sumomb16t = 0 END IF
#
#           #   ##-----No:FUN-A50103-----
#           #   #此訂單的訂金金額 
#           #    SELECT SUM(oma56),SUM(oma56t)
#           #      INTO l_11_oma56,l_11_oma56t
#           #      FROM oma_file
#           #     WHERE oma16 = g_ogb.ogb31
#           #       AND oma00 = '11' 
#           #    IF g_oma.oma213 = 'Y' THEN
#           #      ##-----No:CHI-A70015-----
#           #      #SELECT oea263 INTO l_13_oma56t
#           #      #  FROM oea_file
#           #      # WHERE oea01 = g_ogb.ogb31
#           #       LET l_13_oma56t = l_oea263
#           #       #-----No:CHI-A70015 END-----
#           #       LET l_13_oma56t = l_13_oma56t * g_oma.oma24
#           #       LET l_13_oma56  = l_13_oma56t/(1+ g_oma.oma211/100)
#           #       CALL cl_digcut(l_13_oma56,t_azi04) RETURNING l_13_oma56
#           #    ELSE
#           #      ##-----No:CHI-A70015-----
#           #      #SELECT oea263 INTO l_13_oma56
#           #      #  FROM oea_file
#           #      # WHERE oea01 = g_ogb.ogb31
#           #       LET l_13_oma56 = l_oea263
#           #       #-----No:CHI-A70015 END-----
#           #       LET l_13_oma56  = l_13_oma56  * g_oma.oma24
#           #       LET l_13_oma56t = l_13_oma56 *(1+ g_oma.oma211/100)
#           #       CALL cl_digcut(l_13_oma56t,t_azi04) RETURNING l_13_oma56t
#           #    END IF
#           #   #SELECT oma50,oma50t,oma56,oma56t
#           #   #  INTO l_13_oma56,l_13_oma56t,l_11_oma56,l_11_oma56t
#           #   #  FROM oma_file
#           #   # WHERE oma16 = g_ogb.ogb31 AND oma00 = '11' 
#           #    IF l_11_oma56  IS NULL THEN LET l_11_oma56 = 0 END IF  
#           #    IF l_11_oma56t IS NULL THEN LET l_11_oma56t = 0 END IF
#           #    IF l_13_oma56  IS NULL THEN LET l_13_oma56 = 0 END IF
#           #    IF l_13_oma56t IS NULL THEN LET l_13_oma56t = 0 END IF
#      
#           #   #LET l_13_oma56 = l_13_oma56  * g_oma.oma163/100
#           #   #LET l_13_oma56t= l_13_oma56t * g_oma.oma163/100
#           #   #CALL cl_digcut(l_13_oma56,g_azi04)  RETURNING l_13_oma56 
#           #   #CALL cl_digcut(l_13_oma56t,g_azi04) RETURNING l_13_oma56t 
#           #   ##-----No:FUN-A50103 END-----
#
#           #   #-MOD-B10012-add-
#           #   #SELECT SUM(oma53),SUM(oma56),SUM(oma56t)     #No:FUN-A50103 
#           #   #  INTO l_12_oma53,l_12_oma56,l_12_oma56t     #No:FUN-A50103 
#           #   #  FROM oma_file
#           #   # WHERE oma01 IN (SELECT oma01 FROM oma_file,ogb_file  
#           #   # WHERE oma16 = ogb01 AND oma16 <> g_ogb.ogb01 AND oma00 = '12' AND omavoid = 'N' 
#           #   #   AND ogb31 = g_ogb.ogb31) 
#           #   #抓取不是本張出貨單的其他出貨應收之未稅與含稅金額
#           #    LET g_sql = " SELECT SUM(oma56),SUM(oma56t) ",    #MOD-B50230 remove l_12_oma53
#           #                " FROM oma_file ",
#           #                " WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),  
#           #                " WHERE oma16 = ogb01 ",
#           #                "   AND oma16 <> '",g_ogb.ogb01,"'",
#           #                "   AND oma00 = '12' ", 
#           #                "   AND omavoid = 'N' ", 
#           #                "   AND ogb31 = '",g_ogb.ogb31,"')" 
#           #               #"   AND ogb32 = '",g_ogb.ogb32,"')"       #MOD-B50230 mark 
#           #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	   #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#           #    PREPARE sel_ogb_pre05 FROM g_sql
#           #    EXECUTE sel_ogb_pre05 INTO l_12_oma56,l_12_oma56t #MOD-B50230 remove l_12_oma53 
#           #   #-MOD-B10012-end-
#           #   #IF l_12_oma53  IS NULL THEN LET l_12_oma53 = 0 END IF   #TQC-A60027 #MOD-B50230 mark 
#           #    IF l_12_oma56  IS NULL THEN LET l_12_oma56 = 0 END IF
#           #    IF l_12_oma56t IS NULL THEN LET l_12_oma56t = 0 END IF
#
#           #    LET g_oma.oma56 = l_sumomb16 - l_11_oma56 - l_12_oma56 - l_13_oma56
#           #    LET g_oma.oma56t= l_sumomb16t - l_11_oma56t - l_12_oma56t - l_13_oma56t
#           #   #LET g_oma.oma53 = l_11_oma56   
#           #    LET g_oma.oma53 = l_11_oma56 - l_12_oma53    #No:FUN-A50103
#           # ELSE
#           #    #-----No:FUN-A50103-----
#           #    IF g_oma.oma213 = 'Y' THEN 
#           #       LET g_oma.oma53 = g_oma.oma56 * l_oea261 / l_oea1008
#           #       LET g_oma.oma56 = g_oma.oma56 * l_oea262 / l_oea1008
#           #       LET g_oma.oma56t= g_oma.oma56t* l_oea262 / l_oea1008
#           #    ELSE
#           #       LET g_oma.oma53 = g_oma.oma56 * l_oea261 / l_oea61 
#           #       LET g_oma.oma56 = g_oma.oma56 * l_oea262 / l_oea61
#           #       LET g_oma.oma56t= g_oma.oma56t* l_oea262 / l_oea61
#           #    END IF
#           #   #LET g_oma.oma53 = g_oma.oma56 *g_oma.oma161/100   #訂單轉銷貨收入實際計算
#           #   #LET g_oma.oma56 = g_oma.oma56 *g_oma.oma162/100
#           #   #LET g_oma.oma56t= g_oma.oma56t*g_oma.oma162/100
#           #   ##-----No:FUN-A50103 END-----
#           # END IF 
#           ##-CHI-A50040-end-
#           #-TQC-B60089-end-
#            #IF g_oma.oma07='N' OR cl_null(g_oma.oma07) THEN        #CHI-A50040 mark
#               #IF g_azw.azw04 = '2' THEN  #零售業                  #CHI-A50040 mark
#               #   LET g_oma.oma53 = 0                              #CHI-A50040 mark
#               #ELSE                                                #CHI-A50040 mark
#               #    LET g_oma.oma53 = 0 #FUN-960140 add             #CHI-A50040 mark
#               #END IF    #FUN-960140                               #CHI-A50040 mark
#             LET g_oma.oma53 = g_oma.oma52 * g_oma.oma24            #TQC-B60089
#             CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53
#            #END IF                                                 #CHI-A50040 mark
#            #LET g_oma.oma56 = g_oma.oma56*(1-g_oma.oma163/100)     #CHI-A50040 mark
#            #LET g_oma.oma56t = g_oma.oma56t*(1-g_oma.oma163/100)   #CHI-A50040 mark
#            #-CHI-A50040-add-
#            #-TQC-B60089-add-
#            #單頭本幣與單身本幣尾差調整
#             LET l_oma56=0 
#             LET l_oma56t=0
#             SELECT SUM(omb16),SUM(omb16t) INTO l_sumomb16,l_sumomb16t
#               FROM omb_file
#              WHERE omb01 = g_oma.oma01 
#             IF l_sumomb16  IS NULL THEN LET l_sumomb16 = 0 END IF
#             IF l_sumomb16t IS NULL THEN LET l_sumomb16t = 0 END IF
#             LET g_oma.oma56 = g_oma.oma54 *g_oma.oma24
#             LET l_oma56 = g_oma.oma53 + g_oma.oma56 
#             CALL cl_digcut(l_oma56,g_azi04) RETURNING l_oma56  
#             LET l_oma56 = l_oma56 - l_sumomb16
#             IF l_oma56 <> 0 THEN
#                LET g_oma.oma56 = g_oma.oma56 - l_oma56
#             END IF
#             LET g_oma.oma56t= g_oma.oma54t*g_oma.oma24
#             LET l_oma56t = g_oma.oma53 + g_oma.oma56t 
#             CALL cl_digcut(l_oma56t,g_azi04) RETURNING l_oma56t  
##             LET l_oma56t = l_oma56t - l_sumomb16
#             LET l_oma56t = l_oma56t - l_sumomb16t     #modify by zhangym 110906
#             IF l_oma56t <> 0 THEN
#                LET g_oma.oma56t = g_oma.oma56t - l_oma56t
#             END IF
#            #-TQC-B60089-mark-
#            ##判斷變更後金額是否超出原待抵金額,
#            ##若是的話,oma53=原待抵金額,oma56=變更後金額-原待抵金額
#            #IF NOT cl_null(g_oma.oma19) THEN    #待抵帳款單號不為空
#            #   LET l_oma56=0 LET l_oma56t=0
#            #  #SELECT (oma56t-oma57),oma56t INTO l_oma56,l_oma56t
#            #   SELECT SUM(oma56t-oma57),SUM(oma56t) INTO l_oma56,l_oma56t
#            #     FROM oma_file 
#            #   #WHERE oma01=g_oma.oma19 
#            #    WHERE oma16=g_oma.oma19     #No:FUN-A50103
#            #  #IF l_oma56 < g_oma.oma53 THEN   #MOD-B50230 mark
#            #   IF l_oma56 < g_oma.oma53 OR l_oeb917 <= l_sumogb917+l_ogb917 THEN  #MOD-B50230
#            #     #LET g_oma.oma53 = l_oma56                 #本幣訂金     #MOD-B50230 mark 
#            #      LET g_oma.oma53 = l_oma56 - l_12_oma53    #本幣訂金     #MOD-B50230
#            #   END IF
#            #END IF
#            #-TQC-B60089-end-
#            #-CHI-A50040-end-
#        WHEN g_oma.oma00 = '13' 
#             #-----No:FUN-A50103-----
#             LET g_oma.oma56  = g_oma.oma54 * g_oma.oma24
#             LET g_oma.oma56t = g_oma.oma54t* g_oma.oma24
#             IF l_oea262 = 0 AND l_oea263 > 0 THEN
#                LET g_oma.oma53  = g_oma.oma52 * g_oma.oma24
#                CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53 
#             END IF
#            #IF g_oma.oma162=0 AND g_oma.oma163 >0 THEN
#            #   LET g_oma.oma53 = g_oma.oma56 *g_oma.oma161/100
#            #   CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53  #No.TQC-750093 t_azi -> g_azi
#            #END IF
#            #LET g_oma.oma56 = g_oma.oma56 *g_oma.oma163/100
#            #LET g_oma.oma56t= g_oma.oma56t*g_oma.oma163/100
#            ##-----No:FUN-A50103 END-----
#   END CASE
#   IF g_oma.oma56  IS NULL THEN LET g_oma.oma56 =0 END IF
#   IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t=0 END IF
#   IF g_oma.oma213='N' THEN
#      CALL cl_digcut(g_oma.oma56,g_azi04) RETURNING g_oma.oma56    #No.TQC-750093 t_azi -> g_azi
#      IF g_oma.oma00 = '11' THEN
#         LET g_oma.oma56x = 0
#      ELSE
#         LET g_oma.oma56x=g_oma.oma56*g_oma.oma211/100
#      END IF #FUN-960140 
#      CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x  #No.TQC-750093 t_azi -> g_azi
#      LET g_oma.oma56t=g_oma.oma56+g_oma.oma56x
#   ELSE 
#      CALL cl_digcut(g_oma.oma56t,g_azi04) RETURNING g_oma.oma56t  #No.TQC-750093 t_azi -> g_azi
#      IF g_oma.oma00 = '11' THEN                                                                                       
#         LET g_oma.oma56x = 0                                                                                          
#      ELSE                                                                                                             
#         LET g_oma.oma56x=g_oma.oma56t*g_oma.oma211/(100+g_oma.oma211)
#      END IF #  FUN-960140 
#      CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x  #No.TQC-750093 t_azi -> g_azi
#      LET g_oma.oma56 =g_oma.oma56t-g_oma.oma56x
#   END IF
#   LET g_oma.oma59 = 0 LET g_oma.oma59t= 0
#   SELECT SUM(omb18),SUM(omb18t) INTO g_oma.oma59,g_oma.oma59t
#     FROM omb_file 
#    WHERE omb01=g_oma.oma01 
#   CASE WHEN g_oma.oma00 = '11' 
#             #-----No:FUN-A50103-----
#             LET g_oma.oma59  = g_oma.oma54 * g_oma.oma58
#             LET g_oma.oma59t = g_oma.oma54t* g_oma.oma58
#            #LET g_oma.oma59 = g_oma.oma59 *g_oma.oma161/100
#            #LET g_oma.oma59t= g_oma.oma59t*g_oma.oma161/100
#            ##-----No:FUN-A50103 END-----
#        WHEN g_oma.oma00 = '12' 
#           #-TQC-B60089-mark-
#           ##-CHI-A50040-add-
#           # IF l_flag2 = 'Y' THEN
#           #   #-MOD-B10012-add-
#           #   #SELECT SUM(omb18),SUM(omb18t)
#           #   #  INTO l_sumomb18,l_sumomb18t
#           #   #  FROM omb_file,ogb_file
#           #   # WHERE omb31 = ogb01 AND omb32 = ogb03 AND ogb31 = g_ogb.ogb31 
#           #   #此訂單在出貨單的金額 
#           #    LET g_sql = "SELECT SUM(omb18),SUM(omb18t) ",
#           #                "  FROM oma_file,omb_file,",
#           #                        cl_get_target_table(g_plant_new,'ogb_file'),        
#           #                " WHERE omb31 = ogb01 AND omb32 = ogb03 AND ogb31 = '",g_ogb.ogb31,"'",
#           #               #"   AND ogb32 = '",g_ogb.ogb32,"'",        #MOD-B50230 mark 
#           #                "   AND oma01 = omb01 AND omavoid = 'N'"  
#           #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	   #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#           #    PREPARE sel_ogb_pre06 FROM g_sql
#           #    EXECUTE sel_ogb_pre06 INTO l_sumomb18,l_sumomb18t 
#           #   #-MOD-B10012-end-
#           #    IF l_sumomb18  IS NULL THEN LET l_sumomb18 = 0 END IF
#           #    IF l_sumomb18t IS NULL THEN LET l_sumomb18t = 0 END IF
#
#           #   ##-----No:FUN-A50103-----
#           #    SELECT SUM(oma59),SUM(oma59t)
#           #      INTO l_11_oma59,l_11_oma59t
#           #      FROM oma_file
#           #     WHERE oma16 = g_ogb.ogb31
#           #       AND oma00 = '11' 
#           #    IF g_oma.oma213 = 'Y' THEN
#           #      ##-----No:CHI-A70015-----
#           #      #SELECT oea263 INTO l_13_oma59t
#           #      #  FROM oea_file
#           #      # WHERE oea01 = g_ogb.ogb31
#           #       LET l_13_oma59t = l_oea263
#           #       #-----No:CHI-A70015 END-----
#           #       LET l_13_oma59t = l_13_oma59t * g_oma.oma58
#           #       LET l_13_oma59  = l_13_oma59t/(1+ g_oma.oma211/100)
#           #       CALL cl_digcut(l_13_oma59,t_azi04) RETURNING l_13_oma59
#           #    ELSE
#           #      ##-----No:CHI-A70015-----
#           #      #SELECT oea263 INTO l_13_oma59
#           #      #  FROM oea_file
#           #      # WHERE oea01 = g_ogb.ogb31
#           #       LET l_13_oma59 = l_oea263
#           #       #-----No:CHI-A70015 END-----
#           #       LET l_13_oma59  = l_13_oma59 * g_oma.oma58
#           #       LET l_13_oma59t = l_13_oma59 *(1+ g_oma.oma211/100)
#           #       CALL cl_digcut(l_13_oma59t,t_azi04) RETURNING l_13_oma59t
#           #    END IF
#           #   #SELECT oma50,oma50t,oma59,oma59t
#           #   #  INTO l_13_oma59,l_13_oma59t,l_11_oma59,l_11_oma59t
#           #   #  FROM oma_file
#           #   # WHERE oma16 = g_ogb.ogb31 AND oma00 = '11' 
#           #    IF l_11_oma59  IS NULL THEN LET l_11_oma59 = 0 END IF
#           #    IF l_11_oma59t IS NULL THEN LET l_11_oma59t = 0 END IF
#           #    IF l_13_oma59  IS NULL THEN LET l_13_oma59 = 0 END IF
#           #    IF l_13_oma59t IS NULL THEN LET l_13_oma59t = 0 END IF
#      
#           #   #LET l_13_oma59 = l_13_oma59  * g_oma.oma163/100
#           #   #LET l_13_oma59t= l_13_oma59t * g_oma.oma163/100
#           #   #CALL cl_digcut(l_13_oma59,g_azi04)  RETURNING l_13_oma59 
#           #   #CALL cl_digcut(l_13_oma59t,g_azi04) RETURNING l_13_oma59t 
#           #   ##-----No:FUN-A50103 END-----
#
#           #   #-MOD-B10012-add-
#           #   #SELECT SUM(oma59),SUM(oma59t)
#           #   #  INTO l_12_oma59,l_12_oma59t
#           #   #  FROM oma_file
#           #   # WHERE oma01 IN (SELECT oma01 FROM oma_file,ogb_file  
#           #   # WHERE oma16 = ogb01 AND oma16 <> g_ogb.ogb01 AND oma00 = '12' AND omavoid = 'N' 
#           #   #   AND ogb31 = g_ogb.ogb31 )   
#           #    LET g_sql = " SELECT SUM(oma59),SUM(oma59t) ",
#           #                " FROM oma_file ",
#           #                " WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),  
#           #                " WHERE oma16 = ogb01 ",
#           #                "   AND oma16 <> '",g_ogb.ogb01,"'",
#           #                "   AND oma00 = '12' ", 
#           #                "   AND omavoid = 'N' ", 
#           #                "   AND ogb31 = '",g_ogb.ogb31,"')"      
#           #               #"   AND ogb32 = '",g_ogb.ogb32,"')"     #MOD-B50230 mark
#           #    CALL cl_replace_sqldb(g_sql) RETURNING g_sql      	
#	   #    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
#           #    PREPARE sel_ogb_pre07 FROM g_sql
#           #    EXECUTE sel_ogb_pre07 INTO l_12_oma59,l_12_oma59t 
#           #   #-MOD-B10012-end-
#           #    IF l_12_oma59  IS NULL THEN LET l_12_oma59 = 0 END IF
#           #    IF l_12_oma59t IS NULL THEN LET l_12_oma59t = 0 END IF
#
#           #    LET g_oma.oma59 = l_sumomb18 - l_11_oma59 - l_12_oma59 - l_13_oma59
#           #    LET g_oma.oma59t= l_sumomb18t - l_11_oma59t - l_12_oma59t - l_13_oma59t
#           # ELSE
#           #    #-----No:FUN-A50103-----
#           #   ##-----No:CHI-A70015-----
#           #   #SELECT oea61,oea1008,oea262
#           #   #  INTO l_oea61,l_oea1008,l_oea262
#           #   #  FROM oea_file
#           #   # WHERE oea01 = g_ogb.ogb31
#           #   ##-----No:CHI-A70015 END-----
#           #    IF g_oma.oma213 = 'Y' THEN 
#           #       LET g_oma.oma59 = g_oma.oma59 * l_oea262 / l_oea1008
#           #       LET g_oma.oma59t= g_oma.oma59t* l_oea262 / l_oea1008
#           #    ELSE
#           #       LET g_oma.oma59 = g_oma.oma59 * l_oea262 / l_oea61
#           #       LET g_oma.oma59t= g_oma.oma59t* l_oea262 / l_oea61
#           #    END IF
#           #   #LET g_oma.oma59 = g_oma.oma59 *g_oma.oma162/100
#           #   #LET g_oma.oma59t= g_oma.oma59t*g_oma.oma162/100
#           #   ##-----No:FUN-A50103 END-----
#           # END IF 
#           ##-CHI-A50040-end-
#           #-TQC-B60089-end-
#            #LET g_oma.oma59 = g_oma.oma59 *(1-g_oma.oma163)/100   #CHI-A50040 mark 
#            #LET g_oma.oma59t= g_oma.oma59t*(1-g_oma.oma163)/100   #CHI-A50040 mark
#            LET g_oma.oma59  = g_oma.oma54 *g_oma.oma58    #TQC-B60089
#            LET g_oma.oma59t = g_oma.oma54t*g_oma.oma58    #TQC-B60089
#        WHEN g_oma.oma00 = '13'
#           #-----No:FUN-A50103-----
#           LET g_oma.oma59  = g_oma.oma54 * g_oma.oma58
#           LET g_oma.oma59t = g_oma.oma54t* g_oma.oma58
#          #LET g_oma.oma59 = g_oma.oma59 *g_oma.oma163/100
#          #LET g_oma.oma59t= g_oma.oma59t*g_oma.oma163/100
#          ##-----No:FUN-A50103 END-----
#   END CASE
#   IF g_oma.oma59  IS NULL THEN LET g_oma.oma59 =0 END IF
#   IF g_oma.oma59t IS NULL THEN LET g_oma.oma59t=0 END IF
#   IF g_oma.oma213='N' THEN
#      CALL cl_digcut(g_oma.oma59,g_azi04) RETURNING g_oma.oma59    #No.TQC-750093 t_azi -> g_azi
#      IF g_oma.oma00 = '11' THEN 
#         LET g_oma.oma59x = 0 
#      ELSE   #FUN-960140 
#         LET g_oma.oma59x=g_oma.oma59*g_oma.oma211/100
#      END IF    #FUN_960140  
#      CALL cl_digcut(g_oma.oma59x,g_azi04) RETURNING g_oma.oma59x  #No.TQC-750093 t_azi -> g_azi
#      LET g_oma.oma59t=g_oma.oma59+g_oma.oma59x
#   ELSE 
#      CALL cl_digcut(g_oma.oma59t,g_azi04) RETURNING g_oma.oma59t  #No.TQC-750093 t_azi -> g_azi
#      IF g_oma.oma00 = '11' THEN 
#         LET g_oma.oma59x = 0 
#      ELSE   #FUN-960140     
#         LET g_oma.oma59x=g_oma.oma59t*g_oma.oma211/(100+g_oma.oma211)
#      END IF    #FUN_960140 
#      CALL cl_digcut(g_oma.oma59x,g_azi04) RETURNING g_oma.oma59x  #No.TQC-750093 t_azi -> g_azi
#      LET g_oma.oma59 =g_oma.oma59t-g_oma.oma59x
#   END IF
#   #------------------------------------------------------------
#   IF g_oma.oma00='31' THEN            # '31'類視為已沖帳, 不再視為應收
#      LET g_oma.oma55=g_oma.oma54t LET g_oma.oma57=g_oma.oma56t
#      DISPLAY BY NAME g_oma.oma55,g_oma.oma57
#   END IF
#   LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
#   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                     
#   LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                            
#  IF cl_null(g_oma.oma50) THEN LET g_oma.oma50 = 0 END IF
#  IF cl_null(g_oma.oma50t) THEN LET g_oma.oma50t = 0 END IF
#  IF cl_null(g_oma.oma52) THEN LET g_oma.oma52 = 0 END IF
#  IF cl_null(g_oma.oma53) THEN LET g_oma.oma53 = 0 END IF
#  IF cl_null(g_oma.oma54) THEN LET g_oma.oma54 = 0 END IF
#  IF cl_null(g_oma.oma54x) THEN LET g_oma.oma54x = 0 END IF
#  IF cl_null(g_oma.oma54t) THEN LET g_oma.oma54t = 0 END IF
#  IF cl_null(g_oma.oma56) THEN LET g_oma.oma56 = 0 END IF
#  IF cl_null(g_oma.oma56x) THEN LET g_oma.oma56x = 0 END IF
#  IF cl_null(g_oma.oma56t) THEN LET g_oma.oma56t = 0 END IF
#  IF cl_null(g_oma.oma59) THEN LET g_oma.oma59 = 0 END IF
#  IF cl_null(g_oma.oma59x) THEN LET g_oma.oma59x = 0 END IF
#  IF cl_null(g_oma.oma59t) THEN LET g_oma.oma59t = 0 END IF
#  IF cl_null(g_oma.oma55) THEN LET g_oma.oma55 = 0 END IF
#  IF cl_null(g_oma.oma57) THEN LET g_oma.oma57 = 0 END IF
#  IF cl_null(g_oma.oma61) THEN LET g_oma.oma61 = 0 END IF
#   UPDATE oma_file SET
#  oma50=g_oma.oma50, oma50t=g_oma.oma50t,oma52=g_oma.oma52,
#  oma53=g_oma.oma53,oma54=g_oma.oma54,oma54x=g_oma.oma54x,
#  oma54t=g_oma.oma54t,oma56=g_oma.oma56,oma56x=g_oma.oma56x,
#  oma56t=g_oma.oma56t,oma59=g_oma.oma59,oma59x=g_oma.oma59x,
#  oma59t=g_oma.oma59t,oma55=g_oma.oma55, oma57=g_oma.oma57,
#  oma61=g_oma.oma61,oma71 = g_oma.oma71,    #FUN-970108
#  oma73=g_oma.oma73,oma73f=g_oma.oma73f     #No.FUN-AB0034
#  WHERE oma01=g_oma.oma01
#   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma50",1)  #No.FUN-660116
#      LET g_success='N' RETURN
#   END IF
#   CALL t300_show_amt()            # 只有本指令須追加
#END FUNCTION
#-------------------------------No.CHI-B90025----------------------------------end-mark
 
FUNCTION t300_delall()
    SELECT COUNT(*) INTO g_cnt FROM omb_file
WHERE omb01 = g_oma.oma01
    IF g_cnt = 0 THEN                   # 未輸入單身資料, 則取消單頭資料
       CALL cl_getmsg('9044',g_lang) RETURNING g_msg
       ERROR g_msg CLIPPED
       DELETE FROM oma_file WHERE oma01 = g_oma.oma01
       DELETE FROM omc_file WHERE omc01 = g_oma.oma01 #No.FUN-680022
    END IF
END FUNCTION
 
FUNCTION t300_b_askkey()
DEFINE l_wc2     STRING   #MOD-870237 mod
 
    CONSTRUCT l_wc2 ON omb03,omb38,omb44,omb31,omb32,omb39,omb06,omb45,omb47,omb40,omb05                   #No.FUN-670026 --add omb38,omb39  #No.FUN-660073  #FUN-990031 add omb44  FUN-AB0034 add omb45,omb47
       ,ombud01,ombud02,ombud03,ombud04,ombud05
       ,ombud06,ombud07,ombud08,ombud09,ombud10
       ,ombud11,ombud12,ombud13,ombud14,ombud15
    FROM s_omb[1].omb03,s_omb[1].omb38,s_omb[1].omb44,s_omb[1].omb31,s_omb[1].omb32,   #No.FUN-670026 --add omb38,omb39   #FUN-990031 add omb44
 s_omb[1].omb39,s_omb[1].omb06,s_omb[1].omb45,s_omb[1].omb47,s_omb[1].omb40,s_omb[1].omb05                    #No.FUN-670026 --add omb38,omb39  #No.FUN-660073  FUN-AB0034 add omb45,omb47
 ,s_omb[1].ombud01,s_omb[1].ombud02,s_omb[1].ombud03
 ,s_omb[1].ombud04,s_omb[1].ombud05,s_omb[1].ombud06
 ,s_omb[1].ombud07,s_omb[1].ombud08,s_omb[1].ombud09
 ,s_omb[1].ombud10,s_omb[1].ombud11,s_omb[1].ombud12
 ,s_omb[1].ombud13,s_omb[1].ombud14,s_omb[1].ombud15
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
 
 
 ON ACTION qbe_select
   CALL cl_qbe_select()
 ON ACTION qbe_save
   CALL cl_qbe_save()
    END CONSTRUCT
    IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
    CALL t300_b_fill(l_wc2)
END FUNCTION
 
FUNCTION t300_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2     STRING   #MOD-870237 mod
 
    LET g_sql =
"SELECT omb03,omb38,omb44,omb31,omb32,omb39,omb04,omb06,omb45,omb47,omb40,omb05,omb12,omb41,omb42,omb33,omb331,", #FUN-670047  #No.FUN-670026--add omb38,omb39  #No.FUN-660073 #FUN-810045 add omb41/42  #FUN-990031 add omb44   FUN-AB0034 add omb45,omb47
"       omb13,omb14,omb14t,omb15,omb16,omb16t,omb17,omb18,omb18t,omb930,'', ", #FUN-680001
"       ombud01,ombud02,ombud03,ombud04,ombud05,",
"       ombud06,ombud07,ombud08,ombud09,ombud10,",
"       ombud11,ombud12,ombud13,ombud14,ombud15 ", 
" FROM omb_file ",
" WHERE omb01 ='",g_oma.oma01,"'",  #單頭
" AND ",p_wc2 CLIPPED,                     #單身
" ORDER BY 1"
 
    PREPARE t300_pb FROM g_sql
    DECLARE omb_curs                       #SCROLL CURSOR
CURSOR FOR t300_pb
    CALL g_omb.clear()
    LET g_rec_b = 0
    LET g_cnt = 1
    FOREACH omb_curs INTO g_omb[g_cnt].*   #單身 ARRAY 填充
IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
LET g_omb[g_cnt].gem02c=s_costcenter_desc(g_omb[g_cnt].omb930) #FUN-680006
LET g_cnt = g_cnt + 1
IF g_cnt > g_max_rec THEN
   CALL cl_err( '', 9035, 0 )
   EXIT FOREACH
END IF
    END FOREACH
    CALL g_omb.deleteElement(g_cnt)
    LET g_rec_b=g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2
    CALL t300_count_amount('')  #FUN-720038
END FUNCTION
 
 
 
FUNCTION t300_bp(p_ud)
   DEFINE p_ud      LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_omb  TO s_omb.*  ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
 
      BEFORE DISPLAY
 CALL cl_navigator_setting( g_curs_index, g_row_count )
  IF g_aza.aza26 <> '2' THEN
      CALL cl_set_act_visible("mntn_offset_inv,",FALSE)
  ELSE
     CALL cl_set_comp_att_text("oma212",cl_getmsg("axr-504",g_lang))
  END IF
  IF g_aza.aza63 = 'N' THEN
     CALL cl_set_act_visible("entry_sheet2,T_T_entry_sheet2",FALSE)     #FUN-830091
  END IF
 
      BEFORE ROW
 LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
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
 
      ON ACTION locale
 CALL cl_dynamic_locale()
 CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
 CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
 
 EXIT DISPLAY
 
      ON ACTION first
 CALL t300_fetch('F')
 CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
 IF g_rec_b != 0 THEN
    CALL fgl_set_arr_curr(1)  ######add in 040505
 END IF
 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION previous
 CALL t300_fetch('P')
 CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
 IF g_rec_b != 0 THEN
    CALL fgl_set_arr_curr(1)  ######add in 040505
 END IF
 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION jump
 CALL t300_fetch('/')
 CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
 IF g_rec_b != 0 THEN
    CALL fgl_set_arr_curr(1)  ######add in 040505
 END IF
 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION next
 CALL t300_fetch('N')
 CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
 IF g_rec_b != 0 THEN
    CALL fgl_set_arr_curr(1)  ######add in 040505
 END IF
 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
      ON ACTION last
 CALL t300_fetch('L')
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
 
      ON ACTION exit
 LET g_action_choice="exit"
 EXIT DISPLAY
 
      ON ACTION controlg
 LET g_action_choice="controlg"
 EXIT DISPLAY
 
      ON ACTION mntn_offset_inv  #發票待抵維護
 LET g_action_choice="mntn_offset_inv"
 EXIT DISPLAY
 
      ON ACTION issue_invoice  #發票開立
 LET g_action_choice="issue_invoice"
 EXIT DISPLAY
 
      ON ACTION maintain_invoice  #發票維護
 LET g_action_choice="maintain_invoice"
 EXIT DISPLAY
 
      ON ACTION doc_data  #文件資料
 LET g_action_choice="doc_data"
 EXIT DISPLAY
 
      ON ACTION other_data  #其他資料
 LET g_action_choice="other_data"
 EXIT DISPLAY
 
      ON ACTION modify_tax #稅額修正
 LET g_action_choice="modify_tax"
 EXIT DISPLAY
 
      ON ACTION qry_receive  #收款查詢
 LET g_action_choice="qry_receive"
 EXIT DISPLAY
 
      ON ACTION qry_contra_detail  #沖帳細項查詢
 LET g_action_choice="qry_contra_detail"
 EXIT DISPLAY
 
      ON ACTION qry_Source_Doc  #來源單號查詢
 LET g_action_choice="qry_Source_Doc"
 EXIT DISPLAY
 
      ON ACTION modify_date #日期修正
 LET g_action_choice="modify_date"
 EXIT DISPLAY
 
      ON ACTION rec_direct #直接收款
 LET g_action_choice="rec_direct"
 EXIT DISPLAY

  #add by shenrr 120529----begin
      ON ACTION contra    #冲账
      LET g_action_choice="contra"
      EXIT DISPLAY
  #add by shenrr 120529----end

###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
#     ON ACTION 實際交易稅別明細
      ON ACTION trans_tax       #--實際交易稅別明細
         LET g_action_choice="trans_tax"
         EXIT DISPLAY

#     ON ACTION 單身稅別明細
      ON ACTION detail_tax      #--單身稅別明細
         LET g_action_choice="detail_tax"
         EXIT DISPLAY
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
 
      ON ACTION gen_entry  #會計分錄產生
 LET g_action_choice="gen_entry"
 EXIT DISPLAY
 
      ON ACTION entry_sheet #分錄底稿
 LET g_action_choice="entry_sheet"
 EXIT DISPLAY
 
      ON ACTION entry_sheet2 #分錄底稿2
 LET g_action_choice="entry_sheet2"
 EXIT DISPLAY
 
      ON ACTION T_T_entry_sheet #分錄底稿
 LET g_action_choice="T_T_entry_sheet"
 EXIT DISPLAY
 
      ON ACTION T_T_entry_sheet2 #分錄底稿2
 LET g_action_choice="T_T_entry_sheet2"
 EXIT DISPLAY
 
      ON ACTION memo #備註
 LET g_action_choice="memo"
 EXIT DISPLAY
 
      ON ACTION easyflow_approval           #FUN-550049
 LET g_action_choice="easyflow_approval"
 EXIT DISPLAY
 
      ON ACTION carry_voucher #傳票拋轉
 LET g_action_choice="carry_voucher"
 EXIT DISPLAY
    
      ON ACTION undo_carry_voucher #傳票拋轉還原
 LET g_action_choice="undo_carry_voucher"
 EXIT DISPLAY
 
      ON ACTION confirm  #確認
 LET g_action_choice="confirm"
 EXIT DISPLAY
 
      ON ACTION undo_confirm #取消確認
 LET g_action_choice="undo_confirm"
 EXIT DISPLAY
 
      ON ACTION multi_account_period             #多帳期
 LET g_action_choice="multi_account_period"
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
 
      ON ACTION void #作廢
 LET g_action_choice="void"
 EXIT DISPLAY
 
       #MOD-470514
      ON ACTION modi_mul_tra_acc #三角貿易修改會計科目
 LET g_action_choice="modi_mul_tra_acc"
 EXIT DISPLAY

 #CHI-A80056 add --start--
      ON ACTION modi_mul_tra_inv 
 LET g_action_choice="modi_mul_tra_inv"
 EXIT DISPLAY
 #CHI-A80056 add --end--
 
      ON ACTION accept
 LET g_action_choice="detail"
 LET l_ac = ARR_CURR()
 EXIT DISPLAY
 
      ON ACTION cancel
 LET INT_FLAG=FALSE #MOD-570244mars
 LET g_action_choice="exit"
 EXIT DISPLAY
 
      ON IDLE g_idle_seconds
 CALL cl_on_idle()
 CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
      ON ACTION controls                             #No.FUN-6A0092
 CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
 
      ON ACTION exporttoexcel
 LET g_action_choice = 'exporttoexcel'
 EXIT DISPLAY
      ON ACTION approval_status                    #FUN-550049
 LET g_action_choice="approval_status"
 EXIT DISPLAY
 
      ON ACTION related_document                #No.FUN-6B0042  相關文件
 LET g_action_choice="related_document"          
 EXIT DISPLAY 
 
      AFTER DISPLAY
 CONTINUE DISPLAY
      &include "qry_string.4gl"
#No.FUN-A30106 --begin                                                          
              ON ACTION drill_down                                              
                 LET g_action_choice="drill_down"                               
                 EXIT DISPLAY                                                   
#No.FUN-A30106 --end  
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
FUNCTION t300_out()
    IF g_oma.oma01 IS NULL THEN RETURN END IF
 
    MENU ""
       ON ACTION brief_report_print
  CALL t300_out1()
 
       ON ACTION invoice_print
  LET g_msg = "axrr300 '' '' '",g_lang,"' 'Y' '' '' ",
      "'ome01 =\"",g_oma.oma10,"\"'"
  CALL cl_cmdrun(g_msg)
 
       ON ACTION ar_voucher_print
                  LET g_msg = "axrr301 ",g_today," '' '",g_lang,"' 'Y' '' '' ",  #MOD-960051                                        
                              "'oma01 =\"",g_oma.oma01,"\"' 'Y' 'N' 'Y'"         #MOD-960051
  CALL cl_cmdrun(g_msg)
 
               ON ACTION Print_Allowance
                  IF g_oma.oma00='21' OR g_oma.oma00='22' THEN
                         LET g_msg = "axrr303 '",g_oma.oma01,"' ",
                                     "'",g_oma.oma02,"' ",
                                     "'",g_oma.oma68,"' ", 
                                     "'",g_oma.oma00,"' "   
                     CALL cl_cmdrun(g_msg)    
                  END IF  
       ON ACTION exit
  EXIT MENU
 
       ON ACTION cancel      #No.TQC-7A0013
  EXIT MENU          #No.TQC-7A0013 
 
       ON IDLE g_idle_seconds
  CALL cl_on_idle()
  CONTINUE MENU
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
 CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
 CALL cl_cmdask()     #MOD-4C0121
 
 
 
-- for Windows close event trapped
ON ACTION close   #COMMAND KEY(INTERRUPT) #FUN-9B0145  
     LET INT_FLAG=FALSE #MOD-570244mars
    LET g_action_choice = "exit"
    EXIT MENU
 
    END MENU
 
END FUNCTION
 
FUNCTION t300_out1()
DEFINE
    l_i             LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
    l_n             LIKE type_file.num5,      #No.TQC-7A0013  
    sr              RECORD
oma00       LIKE oma_file.oma00,   #
oma01       LIKE oma_file.oma01,   #
oma21       LIKE oma_file.oma21,   #
oma05       LIKE oma_file.oma05,   #
oma03       LIKE oma_file.oma03,   #
oma032      LIKE oma_file.oma032,   #
oma16       LIKE oma_file.oma16,   #
oma53       LIKE oma_file.oma53,   #
oma56       LIKE oma_file.oma56,
oma56x      LIKE oma_file.oma56x,
oma56t      LIKE oma_file.oma56t,
oma23       LIKE oma_file.oma23
    END RECORD,
    l_name          LIKE type_file.chr20,     #No.FUN-680123 VARCHAR(20),              #External(Disk) file name
    l_za05          LIKE za_file.za05         #No.FUN-680123 VARCHAR(40)               #
 
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    #LET g_wc=" oma01='",g_oma.oma01,"'"   #MOD-480390 #CHI-AB0001 mark
    CALL cl_wait()
    LET l_oma53=0
    LET l_oma56=0
    LET l_oma56x=0
    LET l_oma56t=0
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    LET g_sql="SELECT DISTINCT oma00,oma01,oma21,oma05,oma03,oma032,oma16,", #CHI-AB0001 add DISTINCT
      "       oma53,oma56,oma56x,oma56t,oma23",
     #CHI-AB0001 mod --start--
     #" FROM oma_file",
     #" WHERE ",g_wc CLIPPED," AND omavoid='N' ",      #No:9456
      " FROM oma_file,omb_file",
      " WHERE oma01 = omb01",
      "   AND ",g_wc CLIPPED," AND omavoid='N' ",
      "   AND ",g_wc2 CLIPPED,
     #CHI-AB0001 mod --end--
      " ORDER BY 1"
    PREPARE t300_p1 FROM g_sql              # RUNTIME 編譯
    DECLARE t300_co                         # SCROLL CURSOR
CURSOR FOR t300_p1
 
    CALL cl_del_data(l_table)               #No.TQC-7A0013
    FOREACH t300_co INTO sr.*
IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
IF cl_null(sr.oma53) THEN LET sr.oma53=0  END IF                                                                        
IF cl_null(sr.oma56) THEN LET sr.oma56=0  END IF                                                                        
IF cl_null(sr.oma56x) THEN LET sr.oma56x=0  END IF                                                                      
IF cl_null(sr.oma56t) THEN LET sr.oma56t=0  END IF                                                                      
SELECT azi05 INTO l_n FROM azi_file WHERE azi01=sr.oma23 
IF (sr.oma00 ='21' OR sr.oma00 ='22' OR sr.oma00 ='23'  #bugno:4503                                                     
     OR sr.oma00 ='24' OR sr.oma00 ='25') THEN                                                                          
     LET  l_oma53=l_oma53+sr.oma53                                                                                      
     LET  l_oma56=l_oma56+sr.oma56                                                                                      
     LET  l_oma56x=l_oma56x+sr.oma56x                                                                                   
     LET  l_oma56t=l_oma56t+sr.oma56t        
EXECUTE insert_prep USING sr.oma00,sr.oma01,sr.oma21,sr.oma05,sr.oma03,
  sr.oma032,sr.oma16,sr.oma53,sr.oma56,sr.oma56x,
  sr.oma56t
ELSE
EXECUTE insert_prep USING sr.oma00,sr.oma01,sr.oma21,sr.oma05,sr.oma03,                                                     
  sr.oma032,sr.oma16,sr.oma53,sr.oma56,sr.oma56x,                                                   
  sr.oma56t
END IF 
    END FOREACH
 
    IF g_zz05 = 'Y' THEN                                                        
       CALL cl_wcchp(g_wc,'g_wc ON oma00,oma01,oma08,oma02,oma33,oma03,oma032,oma68,oma69,   #omaplant,#FUN-960140 add omaplant #FUN-960140 090824 del omaplant              
     omaconf,omavoid,omamksg,oma64,oma70,oma32,oma11,        #FUN-960140 add oma70                                       
     oma12,oma13,ool02,oma18,oma181,oma65,oma23,oma52,oma54,oma54x,oma51f,   
     oma54t,oma55,oma24,oma53,oma56,oma56x,oma51,oma56t,                                      
     oma57,oma14,oma15,oma930,oma16,oma66,oma67,oma19,oma99,   
     oma992,oma25,oma26,oma63,oma40,omaprsw,                                     
     oma09,oma05,oma10,oma04,oma21,oma211,oma212,                               
     oma213,oma58,oma59,oma59x,oma59t,                                                                    
     omauser,omagrup,omamodu,omadate,
     omb03,omb38,omb44,omb31,omb32,omb39,omb04,omb06,omb40,omb05,omb930    #FUN-990031 add omb44
     omb03,omb38,omb31,omb32,omb39,omb06,omb40,omb05,
     oma00,oma08,oma01,oma02,oma14,oma15,
     oma01,oma02,oma03,
     omb03,omb38,omb31,omb32,omb39,omb04,omb06,omb40,omb05')         
    RETURNING g_wc                                                                                                                    
    END IF                                                                                                                          
     LET g_str = g_wc,";",g_azi04,";",g_azi05                                                                
     LET l_sql = "SELECT * FROM ", g_cr_db_str CLIPPED, l_table CLIPPED                                              
     CALL cl_prt_cs3('axrt300','axrt300',l_sql,g_str)
 
END FUNCTION

FUNCTION t300_1()
DEFINE p_row,p_col   LIKE type_file.num5      #No.FUN-680123 SMALLINT
DEFINE ls_tmp STRING
DEFINE l_cnt        LIKE type_file.num5     #FUN-970108
 
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    IF g_oma.omavoid = 'Y' THEN RETURN END IF
    
    IF g_oma.oma64 matches '[Ss]' THEN      
        RETURN
    END IF
    
    LET p_row = 10 LET p_col = 20
    OPEN WINDOW t3001_w AT p_row,p_col WITH FORM "axr/42f/axrt3001"
  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt3001")
 
    LET g_action_choice="modify"
 
    LET g_oma_t.oma35 = g_oma.oma35
    LET g_oma_t.oma36 = g_oma.oma36
    LET g_oma_t.oma37 = g_oma.oma37
    LET g_oma_t.oma38 = g_oma.oma38
    LET g_oma_t.oma39 = g_oma.oma39
    LET g_oma_t.oma71 = g_oma.oma71  #FUN-970108
    
    IF NOT cl_chk_act_auth() THEN
       DISPLAY BY NAME g_oma.oma35,g_oma.oma36,g_oma.oma37,
       g_oma.oma38,g_oma.oma39
    LET INT_FLAG = 0  ######add for prompt bug
       PROMPT ">" FOR CHAR g_chr
  ON IDLE g_idle_seconds
     CALL cl_on_idle()
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
 CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
 CALL cl_cmdask()     #MOD-4C0121
 
 
       END PROMPT
       CLOSE WINDOW t3001_w
       RETURN
    END IF
    INPUT BY NAME  g_oma.oma35,g_oma.oma36,g_oma.oma37,
               g_oma.oma38,g_oma.oma39,g_oma.oma71  #FUN-970108 add oma71
  WITHOUT DEFAULTS
  
    BEFORE INPUT
      CALL t300_set_no_required() 
      CALL t300_set_required()   
    
   #-MOD-A90150-add-
    AFTER FIELD oma39
       IF NOT cl_null(g_oma.oma39) THEN
          LET l_cnt = 0 
          LET l_cnt = LENGTH(g_oma.oma39)
          IF l_cnt != 14 THEN
             CALL cl_err(g_oma.oma39,'amd-017',0)
             NEXT FIELD oma39
          END IF
       END IF
   #-MOD-A90150-add-
    
    AFTER FIELD oma71
      IF NOT cl_null(g_oma.oma71) THEN   
         LET l_cnt = 0                    #MOD-A90150 
         SELECT COUNT(*) INTO l_cnt FROM ama_file
          WHERE ama02 = g_oma.oma71
           IF l_cnt = 0 THEN 
              CALL cl_err("","mfg9329",1) 
           END IF
           #IF g_aza.aza21 = 'Y' OR NOT s_chkban(g_oma.oma71) THEN #FUN-990053 mod #TQC-B40067 mark
           IF g_aza.aza21 = 'Y' AND NOT s_chkban(g_oma.oma71) THEN #TQC-B40067 
              CALL cl_err("","mfg7015",1)
              NEXT FIELD oma71
           END IF
      ELSE 
          IF g_aza.aza94 = 'Y' THEN
              CALL cl_err('oma71 is null: ','aap-099',0) 
          END IF
      END IF
    
    AFTER FIELD oma35
    IF NOT cl_null(g_oma.oma35) THEN
       IF g_oma.oma35 NOT MATCHES '[12345678]' THEN   #MOD-830052
          NEXT FIELD oma35
       END IF
    END IF
   ON IDLE g_idle_seconds
  CALL cl_on_idle()
  CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
       CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
       CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
       CALL cl_cmdask()     #MOD-4C0121
 
      ON ACTION CONTROLP
       CASE
          WHEN INFIELD(oma71)
             CALL cl_init_qry_var()
             LET g_qryparam.form = "q_ama02"
             LET g_qryparam.default1 = g_oma.oma71
             CALL cl_create_qry() RETURNING g_oma.oma71
             DISPLAY BY NAME g_oma.oma71
             NEXT FIELD oma71 
          OTHERWISE EXIT CASE
       END CASE
      
    END INPUT
    IF INT_FLAG THEN 
       LET INT_FLAG=0 
       LET g_oma.oma35 = g_oma_t.oma35
       LET g_oma.oma36 = g_oma_t.oma36
       LET g_oma.oma37 = g_oma_t.oma37
       LET g_oma.oma38 = g_oma_t.oma38
       LET g_oma.oma39 = g_oma_t.oma39
       LET g_oma.oma71 = g_oma_t.oma71   #FUN-970108
       CLOSE WINDOW t3001_w 
       RETURN 
    END IF
    CLOSE WINDOW t3001_w
    UPDATE oma_file SET oma35 = g_oma.oma35,
oma36 = g_oma.oma36,
oma37 = g_oma.oma37,
oma38 = g_oma.oma38,
oma39 = g_oma.oma39,
      oma71 = g_oma.oma71    #FUN-970108
   WHERE oma01 = g_oma.oma01
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
       CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","update oma",1)  #No.FUN-660116
    END IF
    IF NOT cl_null(g_oma.oma71) AND NOT cl_null(g_oma.oma10) THEN
        UPDATE ome_file SET ome60 = g_oma.oma71
         WHERE ome16 = g_oma.oma01
    END IF
END FUNCTION
 
FUNCTION t300_2()
   DEFINE  l_oap   RECORD LIKE oap_file.*
   DEFINE p_row,p_col   LIKE type_file.num5      #No.FUN-680123  SMALLINT
   DEFINE ls_tmp STRING
   DEFINE  l_oab02      LIKE oab_file.oab02      #No.TQC-7C0070
 
 
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    IF g_oma.omavoid = 'Y' THEN RETURN END IF
#   IF g_oma.oma70 = '1' THEN RETURN END IF   #FUN-960140          #FUN-B40032 MARK
    IF g_oma.oma70 = '1' OR g_oma.oma70 = '3' THEN RETURN END IF   #FUN-B40032 ADD 
    IF g_oma.oma64 matches '[Ss]' THEN      
        RETURN
    END IF
    LET p_row = 8  LET p_col = 25
    OPEN WINDOW t3002_w AT p_row,p_col WITH FORM "axr/42f/axrt3002"
  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt3002")
 
    LET l_oab02 = NULL 
    LET li_dbs = ''
    IF NOT cl_null(g_oma.oma66) THEN
       LET g_plant_new = g_oma.oma66
    ELSE
       LET g_plant_new = g_plant
    END IF
    #CALL s_gettrandbs()
    #LET li_dbs = g_dbs_tra

    #LET g_sql = " SELECT oab02 FROM ",li_dbs CLIPPED,"oab_file",
    LET g_sql = " SELECT oab02 FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                "  WHERE oab01='",g_oma.oma25,"'"
    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
    PREPARE sel_oab_pre77 FROM g_sql
    EXECUTE sel_oab_pre77 INTO l_oab02
    DISPLAY l_oab02 TO oab02 LET l_oab02 = ''
    #LET g_sql = " SELECT oab02 FROM ",li_dbs CLIPPED,"oab_file",
    LET g_sql = " SELECT oab02 FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                "  WHERE oab01='",g_oma.oma26,"'"
    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
    PREPARE sel_oab_pre78 FROM g_sql
    EXECUTE sel_oab_pre78 INTO l_oab02
    DISPLAY l_oab02 TO oab022 LET l_oab02 = ''
    IF NOT cl_chk_act_auth() THEN
       DISPLAY BY NAME g_oma.oma161, g_oma.oma162, g_oma.oma163,
       g_oma.oma25, g_oma.oma26,
       g_oma.oma07, g_oma.oma20, g_oma.omaprsw
    LET INT_FLAG = 0  ######add for prompt bug
       PROMPT ">" FOR CHAR g_chr
  ON IDLE g_idle_seconds
     CALL cl_on_idle()
 
  ON ACTION about         #MOD-4C0121
     CALL cl_about()      #MOD-4C0121
 
  ON ACTION help          #MOD-4C0121
     CALL cl_show_help()  #MOD-4C0121
 
  ON ACTION controlg      #MOD-4C0121
     CALL cl_cmdask()     #MOD-4C0121
 
       END PROMPT
       CLOSE WINDOW t3002_w
       RETURN
    END IF
    INPUT BY NAME g_oma.oma161, g_oma.oma162, g_oma.oma163,
                  g_oma.oma25, g_oma.oma26,
                  g_oma.oma07, g_oma.oma20, g_oma.omaprsw
  WITHOUT DEFAULTS
       BEFORE FIELD oma161,oma162,oma163
  IF cl_null(g_oma.oma161) THEN LET g_oma.oma161 = 0 END IF
  IF cl_null(g_oma.oma162) THEN LET g_oma.oma162 = 0 END IF
  IF cl_null(g_oma.oma163) THEN LET g_oma.oma163 = 0 END IF
       AFTER FIELD oma163
  IF (g_oma.oma161 + g_oma.oma162 + g_oma.oma163) != 100
     THEN
     CALL cl_err('','axr-258',0)
     NEXT FIELD oma161
  END IF
       AFTER FIELD oma25
  IF NOT cl_null(g_oma.oma25) THEN
             #LET g_sql = " SELECT oab02 FROM ",li_dbs CLIPPED,"oab_file",
             LET g_sql = " SELECT oab02 FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                         "  WHERE oab01='",g_oma.oma25,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
             PREPARE sel_oab_pre79 FROM g_sql
             EXECUTE sel_oab_pre79 INTO l_oab02
     IF STATUS THEN
CALL cl_err3("sel","oab_file",g_oma.oma25,"",STATUS,"","select oab",1)  #No.FUN-660116
NEXT FIELD oma25
     END IF
     DISPLAY l_oab02 TO oab02 #No.TQC-7C0077
  END IF
       AFTER FIELD oma26
  IF NOT cl_null(g_oma.oma26) THEN
             #LET g_sql = " SELECT oab02 FROM ",li_dbs CLIPPED,"oab_file",
             LET g_sql = " SELECT oab02 FROM ",cl_get_target_table(g_plant_new,'oab_file'), #FUN-A50102
                         "  WHERE oab01='",g_oma.oma26,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102 
             PREPARE sel_oab_pre80 FROM g_sql
             EXECUTE sel_oab_pre80 INTO l_oab02
     IF STATUS THEN
CALL cl_err3("sel","oab_file",g_oma.oma26,"",STATUS,"","select oab",1)  #No.FUN-660116
NEXT FIELD oma26
     END IF
     DISPLAY l_oab02 TO oab022
  END IF
 
       ON ACTION CONTROLP
  CASE
       WHEN INFIELD(oma25)
 CALL cl_init_qry_var()
 LET g_qryparam.form = "q_oab"
 LET g_qryparam.default1 = g_oma.oma25
 CALL cl_create_qry() RETURNING g_oma.oma25
 DISPLAY BY NAME g_oma.oma25
 NEXT FIELD oma25
       WHEN INFIELD(oma26)
 CALL cl_init_qry_var()
 LET g_qryparam.form = "q_oab"
 LET g_qryparam.default1 = g_oma.oma26        #MOD-640082 modify
 CALL cl_create_qry() RETURNING g_oma.oma26   #MOD-640082 modify
 DISPLAY BY NAME g_oma.oma26
 NEXT FIELD oma26
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
    IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t3002_w RETURN END IF
    CLOSE WINDOW t3002_w
    LET g_oma.oma60=g_oma.oma24
    LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
    CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                    
    LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                           
    UPDATE oma_file SET * = g_oma.* WHERE oma01 = g_oma.oma01
    IF SQLCA.SQLCODE THEN
       CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","update oma",1)  #No.FUN-660116
    END IF
END FUNCTION
 
FUNCTION t300_3()
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    IF g_oma.omavoid = 'Y' THEN RETURN END IF
    IF NOT cl_chk_act_auth()
       THEN LET g_chr='D'
       ELSE LET g_chr='U'
    END IF
    IF NOT cl_null(g_oma.oma99) AND cl_null(g_oma.oma33) THEN  #No.8161
       CALL s_fsgl('AR',2,g_oma.oma01,0,g_ooz.ooz02b,1,'N','0',g_ooz.ooz02p) #FUN-670047
    ELSE
       CALL s_fsgl('AR',2,g_oma.oma01,0,g_ooz.ooz02b,1,g_oma.omaconf,'0',g_ooz.ooz02p) #FUN-670047
    END IF
END FUNCTION
 
FUNCTION t300_31()
    IF g_oma.oma01 IS NULL THEN RETURN END IF
    IF g_oma.omavoid = 'Y' THEN RETURN END IF
    IF NOT cl_chk_act_auth()
       THEN LET g_chr='D'
       ELSE LET g_chr='U'
    END IF
    IF NOT cl_null(g_oma.oma99) AND cl_null(g_oma.oma33) THEN  #No.8161
       CALL s_fsgl('AR',2,g_oma.oma01,0,g_ooz.ooz02c,1,'N','1',g_ooz.ooz02p) #FUN-670047
    ELSE
       CALL s_fsgl('AR',2,g_oma.oma01,0,g_ooz.ooz02c,1,g_oma.omaconf,'1',g_ooz.ooz02p) #FUN-670047
    END IF
END FUNCTION
 
FUNCTION t300_9()
    DEFINE l_ome      RECORD LIKE ome_file.*
 
    IF g_oma.omavoid = 'Y' THEN RETURN END IF
    IF g_oma.omaconf= 'Y' THEN
       CALL cl_err('','axr-913',0) RETURN
    END IF
    IF NOT cl_null(g_oma.oma10 ) THEN
       CALL cl_err('','axr-912',0) RETURN
    END IF
    IF g_oma.oma64 matches '[Ss1]' THEN          #FUN-550049
       CALL cl_err('','mfg3557',0)
       RETURN
    END IF
 
    SELECT * INTO l_ome.* FROM ome_file
     WHERE ome01=g_oma.oma10 AND omevoid = 'N'
    IF l_ome.omeprsw <> 0 THEN
       CALL cl_err('omeprsw<>0','axr-600',0) RETURN
    END IF
    CALL t300_set_entry('')   #MOD-5B0006
    CALL t300_set_entry_1()   #FUN-8A0075
    INPUT BY NAME g_oma.oma52,g_oma.oma53,
       g_oma.oma54,g_oma.oma54x,g_oma.oma54t,
       g_oma.oma56,g_oma.oma56x,g_oma.oma56t,
       g_oma.oma59,g_oma.oma59x,g_oma.oma59t
    WITHOUT DEFAULTS
 
       AFTER FIELD oma54x
          IF g_oma.oma213 = 'N' THEN   #MOD-B60023
             LET g_oma.oma54x=cl_digcut(g_oma.oma54x,t_azi04)   #MOD-820113
             LET g_oma.oma54t=g_oma.oma54 + g_oma.oma54x
             LET g_oma.oma56x=g_oma.oma54x * g_oma.oma24
             LET g_oma.oma56x=cl_digcut(g_oma.oma56x,g_azi04)   #MOD-820113
             LET g_oma.oma56t=g_oma.oma56 + g_oma.oma56x
             LET g_oma.oma59x=g_oma.oma54x * g_oma.oma58
             LET g_oma.oma59x=cl_digcut(g_oma.oma59x,g_azi04)   #MOD-820113
             LET g_oma.oma59t=g_oma.oma59 + g_oma.oma59x
         #-MOD-B60023-add-
          ELSE
             LET g_oma.oma54x=cl_digcut(g_oma.oma54x,t_azi04)   
             LET g_oma.oma54 =g_oma.oma54t - g_oma.oma54x
             LET g_oma.oma56x=g_oma.oma54x * g_oma.oma24
             LET g_oma.oma56x=cl_digcut(g_oma.oma56x,g_azi04) 
             LET g_oma.oma56 =g_oma.oma56t - g_oma.oma56x
             LET g_oma.oma59x=g_oma.oma54x * g_oma.oma58
             LET g_oma.oma59x=cl_digcut(g_oma.oma59x,g_azi04)
             LET g_oma.oma59 =g_oma.oma59t - g_oma.oma59x
          END IF
          DISPLAY BY NAME g_oma.oma54 
          DISPLAY BY NAME g_oma.oma56
          DISPLAY BY NAME g_oma.oma59 
         #-MOD-B60023-end-
          DISPLAY BY NAME g_oma.oma54x   #MOD-820113
          DISPLAY BY NAME g_oma.oma54t
          DISPLAY BY NAME g_oma.oma56x
          DISPLAY BY NAME g_oma.oma56t
          DISPLAY BY NAME g_oma.oma59x
          DISPLAY BY NAME g_oma.oma59t
 
       AFTER FIELD oma56x
          IF g_oma.oma213 = 'N' THEN   #MOD-B60023
             LET g_oma.oma56x=cl_digcut(g_oma.oma56x,g_azi04)   #MOD-820113
             LET g_oma.oma56t=g_oma.oma56 + g_oma.oma56x
         #-MOD-B60023-add- 
          ELSE
             LET g_oma.oma56x=cl_digcut(g_oma.oma56x,g_azi04) 
             LET g_oma.oma56 =g_oma.oma56t - g_oma.oma56x
          END IF
          DISPLAY BY NAME g_oma.oma56 
         #-MOD-B60023-end- 
          DISPLAY BY NAME g_oma.oma56x   #MOD-820113
          DISPLAY BY NAME g_oma.oma56t
 
       AFTER FIELD oma59x
          IF g_oma.oma213 = 'N' THEN   #MOD-B60023
             LET g_oma.oma59x=cl_digcut(g_oma.oma59x,g_azi04)   #MOD-820113
             LET g_oma.oma59t=g_oma.oma59 + g_oma.oma59x
         #-MOD-B60023-add- 
          ELSE
             LET g_oma.oma59x=cl_digcut(g_oma.oma59x,g_azi04) 
             LET g_oma.oma59 =g_oma.oma59t - g_oma.oma59x
          END IF
          DISPLAY BY NAME g_oma.oma59   
         #-MOD-B60023-end- 
          DISPLAY BY NAME g_oma.oma59x   #MOD-820113
          DISPLAY BY NAME g_oma.oma59t

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
       LET g_oma.oma54x = g_oma_t.oma54x
       LET g_oma.oma56x = g_oma_t.oma56x
       LET g_oma.oma59x = g_oma_t.oma59x
       DISPLAY By NAME g_oma.oma54x,g_oma.oma56x,g_oma.oma59x
       LET INT_FLAG=0
       RETURN
    END IF
    LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
    CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                    
    LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                           
 
    UPDATE oma_file SET oma52=g_oma.oma52,
                        oma53=g_oma.oma53,
                        oma54=g_oma.oma54,
                        oma54x=g_oma.oma54x,
                        oma54t=g_oma.oma54t,
                        oma56=g_oma.oma56,
                        oma56x=g_oma.oma56x,
                        oma56t=g_oma.oma56t,
                        oma59=g_oma.oma59,
                        oma59x=g_oma.oma59x,
                        oma59t=g_oma.oma59t,
                        oma61=g_oma.oma61,
                        oma71 = g_oma.oma71    #FUN-970108
    WHERE oma01=g_oma.oma01
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
       CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma",1)  #No.FUN-660116
    END IF
    SELECT SUM(oma59),SUM(oma59x),SUM(oma59t)
      INTO l_ome.ome59,l_ome.ome59x,l_ome.ome59t
      FROM oma_file
     WHERE oma10=g_oma.oma10
    IF STATUS THEN 
       CALL cl_err3("sel","oma_file",g_oma.oma01,"",STATUS,"","sel sum(oma59x)",1)  #No.FUN-660116
    END IF
    IF l_ome.ome59  IS NULL THEN LET l_ome.ome59 =0 END IF
    IF l_ome.ome59x IS NULL THEN LET l_ome.ome59x=0 END IF
    IF l_ome.ome59t IS NULL THEN LET l_ome.ome59t=0 END IF
    #no.A010依幣別取位
    LET l_ome.ome59 = cl_digcut(l_ome.ome59,g_azi04)   #No.TQC-750093 t_azi -> g_azi
    LET l_ome.ome59x= cl_digcut(l_ome.ome59x,g_azi04)  #No.TQC-750093 t_azi -> g_azi
    LET l_ome.ome59t= cl_digcut(l_ome.ome59t,g_azi04)  #No.TQC-750093 t_azi -> g_azi
    UPDATE ome_file SET ome59=l_ome.ome59,
                        ome59x=l_ome.ome59x,
                        ome59t=l_ome.ome59t
    WHERE ome01=g_oma.oma10
    IF STATUS THEN 
       CALL cl_err3("upd","ome_file",g_oma.oma01,"",STATUS,"","upd ome",1)  #No.FUN-660116
    END IF
    CALL s_up_omb(g_oma.oma01)
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01   #MOD-850184 add
    CALL t300_ins_omc('1')   #MOD-820115
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
    CALL t300_show()
END FUNCTION
 
FUNCTION t300_v0()
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
  #IF g_oma.omavoid = 'Y' THEN RETURN END IF                              #MOD-AB0199 mark
   IF g_oma.omavoid = 'Y' THEN CALL cl_err('','9024',0) RETURN END IF     #MOD-AB0199
  #IF g_ooy.ooydmy1 = 'N' THEN RETURN END IF                              #MOD-AB0199 mark
   IF g_ooy.ooydmy1 = 'N' THEN CALL cl_err('','mfg9310',0) RETURN END IF  #MOD-AB0199 
 
   DROP TABLE x
   SELECT * FROM npq_file WHERE 1=2 INTO TEMP x
   IF cl_null(g_oma.oma99) THEN
      CALL t300_v()
   ELSE
      #多角貿易單據一次只產生一張分錄
      #且已確認但未拋轉傳票，可重新產生分錄
      CALL t300_v2()
   END IF
END FUNCTION
 
FUNCTION t300_v2()
  DEFINE l_wc      STRING   #MOD-870237 mod
  DEFINE l_oma01   LIKE oma_file.oma01
  DEFINE only_one  LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)
 
   IF NOT cl_null(g_oma.oma33) THEN CALL cl_err('','aap-925',0) RETURN END IF
   IF cl_confirm('axr-309') THEN
      IF g_oma.oma65 != '2' THEN
 CALL s_t300_gl(g_oma.oma01,'0')    #No.FUN-A10104
 IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
    CALL s_t300_gl(g_oma.oma01,'1') #No.FUN-A10104
 END IF
      ELSE
         CALL s_t300_rgl(g_oma.oma01,'0')   #No.FUN-A10104
 IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
    CALL s_t300_rgl(g_oma.oma01,'1')#No.FUN-A10104
 END IF
      END IF
   END IF
   MESSAGE ""
END FUNCTION
 
FUNCTION t300_v()
   DEFINE l_wc         STRING   #MOD-870237 mod
   DEFINE l_oma01      LIKE oma_file.oma01
   DEFINE only_one     LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)
   DEFINE p_row,p_col  LIKE type_file.num5    #No.FUN-680123 SMALLINT
   DEFINE ls_tmp       STRING
   DEFINE l_cnt        LIKE type_file.num5    #No.FUN-680123 SMALLINT   #FUN-530041
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
   IF g_oma.omaconf = 'Y' THEN RETURN END IF
   IF g_oma.omavoid = 'Y' THEN RETURN END IF
   IF g_ooy.ooydmy1 = 'N' THEN RETURN END IF
    IF g_oma.oma64 MATCHES '[1]' THEN      #FUN-8A0075 
       RETURN
    END IF
 
   LET p_row = 7 LET p_col = 11
   OPEN WINDOW t3009_w AT p_row,p_col WITH FORM "axr/42f/axrt3009"
   ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   CALL cl_ui_locale("axrt3009")
 
   LET only_one = '1'
   INPUT BY NAME only_one WITHOUT DEFAULTS
      AFTER FIELD only_one
 IF only_one NOT MATCHES "[12]" THEN NEXT FIELD only_one END IF
 
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
   IF INT_FLAG THEN LET INT_FLAG = 0 CLOSE WINDOW t3009_w RETURN END IF
   IF only_one = '1' THEN
      LET l_wc = " oma01 = '",g_oma.oma01,"' "
   ELSE
      CONSTRUCT BY NAME l_wc ON oma00,oma08,oma01,oma02,oma14,oma15
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
 
 ON ACTION qbe_select
    CALL cl_qbe_select()
 ON ACTION qbe_save
    CALL cl_qbe_save()
      END CONSTRUCT
      IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t3009_w RETURN END IF
   END IF
   CLOSE WINDOW t3009_w
   IF only_one = '1' THEN
      #FUN-B50090 add begin-------------------------
      #重新抓取關帳日期
      SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
      #FUN-B50090 add -end--------------------------
      IF g_oma.oma02 <= g_ooz.ooz09 THEN
         CALL cl_err(g_oma.oma02,'axr-164',0) RETURN
      END IF
   END IF
   MESSAGE "WORKING !"
   BEGIN WORK
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      CLOSE t300_cl ROLLBACK WORK RETURN
   END IF
   LET g_success = 'Y'
   LET g_sql = "SELECT oma01,oma20 FROM oma_file",
       " WHERE ",l_wc CLIPPED,
       " AND omaconf = 'N' ",   #MOD-710205
       " AND oma01 IN ",   #FUN-530041
       " (SELECT npq01 FROM npq_file WHERE npq00 = 2 AND npqsys = 'AR'",   #FUN-530041
       " AND npq011 = 1)"    #FUN-530041
   IF only_one <> '1' THEN
      #FUN-B50090 add begin-------------------------
      #重新抓取關帳日期
      SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
      #FUN-B50090 add -end--------------------------
      IF NOT cl_null(g_ooz.ooz09) THEN
 LET g_sql = g_sql CLIPPED," AND oma02 >'",g_ooz.ooz09,"'"
      END IF
   END IF
   PREPARE t300_v_p2 FROM g_sql
   DECLARE t300_v_c2 CURSOR FOR t300_v_p2
   LET l_cnt = 0   #FUN-530041
   CALL s_showmsg_init()              #NO.FUN-710050
   FOREACH t300_v_c2 INTO l_oma01,g_chr
      IF STATUS THEN LET g_success = 'N' EXIT FOREACH END IF   #No.FUN-8A0086
      IF g_success='N' THEN                                                                                                          
 LET g_totsuccess='N'                                                                                                       
 LET g_success="Y"                                                                                                          
      END IF                    
 
      IF g_chr='N' THEN
 CALL cl_err(g_oma.oma01,'axr-176',1)   #MOD-8A0018 add
 CONTINUE FOREACH
      END IF
      IF l_cnt = 0 THEN
 IF NOT s_ask_entry(l_oma01) THEN EXIT FOREACH END IF
 DELETE FROM npq_file WHERE npq01 = l_oma01 AND npq00 = 2
AND npqsys = 'AR'  AND npq011 = 1
#FUN-B40056--add--str--
 DELETE FROM tic_file WHERE tic04 = l_oma01
#FUN-B40056--add--end--
 IF g_oma.oma65 != '2' THEN
    CALL s_t300_gl(l_oma01,'0')     #No.FUN-A10104
    IF g_aza.aza63='Y' AND g_success='Y' THEN 
       CALL s_t300_gl(l_oma01,'1')  #No.FUN-A10104
    END IF  
 ELSE
    CALL s_t300_rgl(l_oma01,'0')    #No.FUN-A10104
    IF g_aza.aza63='Y' AND g_success='Y' THEN
       CALL s_t300_rgl(l_oma01,'1') #No.FUN-A10104
    END IF  
 END IF
 LET l_cnt = l_cnt + 1
      ELSE
 DELETE FROM npq_file WHERE npq01 = l_oma01 AND npq00 = 2
AND npqsys = 'AR'  AND npq011 = 1
#FUN-B40056--add--str--
 DELETE FROM tic_file WHERE tic04 = l_oma01
#FUN-B40056--add--end--
 IF g_oma.oma65 != '2' THEN
    CALL s_t300_gl(l_oma01,'0')     #No.FUN-A10104
    IF g_aza.aza63='Y' AND g_success='Y' THEN
       CALL s_t300_gl(l_oma01,'1')  #No.FUN-A10104
    END IF  
 ELSE
    CALL s_t300_rgl(l_oma01,'0')    #No.FUN-A10104
    IF g_aza.aza63='Y' AND g_success='Y' THEN
        CALL s_t300_rgl(l_oma01,'1')#No.FUN-A10104
    END IF  
 END IF
      END IF
   END FOREACH
   IF g_totsuccess="N" THEN                                                                                                         
      LET g_success="N"                                                                                                             
   END IF 
 
   LET g_sql = "SELECT oma01,oma20 FROM oma_file",
       " WHERE ",l_wc CLIPPED,
       " AND omaconf = 'N' ",   #MOD-710205
       " AND oma01 NOT IN ",    #FUN-530041
       " (SELECT npq01 FROM npq_file WHERE npq00 = 2 AND npqsys = 'AR'",   #FUN-530041
       " AND npq011 = 1)"    #FUN-530041
   IF only_one <> '1' THEN
      #FUN-B50090 add begin-------------------------
      #重新抓取關帳日期
      SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
      #FUN-B50090 add -end--------------------------
      IF NOT cl_null(g_ooz.ooz09) THEN
         LET g_sql = g_sql CLIPPED," AND oma02 >'",g_ooz.ooz09,"'"
      END IF
   END IF
   PREPARE t300_v_p FROM g_sql
   DECLARE t300_v_c CURSOR FOR t300_v_p
   FOREACH t300_v_c INTO l_oma01,g_chr
      IF STATUS THEN EXIT FOREACH END IF
      IF g_success='N' THEN                                                                                                          
 LET g_totsuccess='N'                                                                                                       
 LET g_success="Y"                                                                                                          
      END IF                    
 
      IF g_chr='N' THEN CONTINUE FOREACH END IF
      IF g_oma.oma65 != '2' THEN
 CALL s_t300_gl(l_oma01,'0')    #No.FUN-A10104
 IF g_aza.aza63='Y' AND g_success='Y' THEN
    CALL s_t300_gl(l_oma01,'1') #No.FUN-A10104
 END IF
      ELSE
 CALL s_t300_rgl(l_oma01,'0')   #No.FUN-A10104
 IF g_aza.aza63='Y' AND g_success='Y' THEN
    CALL s_t300_rgl(l_oma01,'1')#No.FUN-A10104
 END IF
      END IF
   END FOREACH
   IF g_totsuccess="N" THEN                                                                                                         
      LET g_success="N"                                                                                                             
   END IF 
 
   MESSAGE ""
   CALL s_showmsg()           #NO.FUN-710050
   IF g_success = 'Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF
END FUNCTION
 
FUNCTION t300_b_more()
  DEFINE l_ima25       LIKE ima_file.ima25      #No.FUN-680123 VARCHAR(4)
  DEFINE p_row,p_col   LIKE type_file.num5      #No.FUN-680123 SMALLINT
  DEFINE ls_tmp STRING
    
    IF g_oma.oma64 matches '[Ss]' THEN      
       RETURN
    END IF
  
  LET p_row = 12 LET p_col = 10
  OPEN WINDOW t3005_w AT 14,10 WITH FORM "axr/42f/axrt3005"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
  CALL cl_ui_locale("axrt3005")
 
 
  INPUT BY NAME b_omb.omb04 WITHOUT DEFAULTS
 
      ON ACTION CONTROLP
    CASE WHEN INFIELD(omb04)
 CALL cl_init_qry_var()
 LET g_qryparam.form = "q_ima"
 LET g_qryparam.default1 = b_omb.omb04
 CALL cl_create_qry() RETURNING b_omb.omb04
 DISPLAY BY NAME b_omb.omb04
 NEXT FIELD omb04
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
 
    CLOSE WINDOW t3005_w                 #結束畫面
    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
END FUNCTION
 
FUNCTION t300_m()
   IF g_oma.oma01 IS NULL THEN RETURN END IF
   IF NOT cl_chk_act_auth()
      THEN LET g_chr='d'
      ELSE LET g_chr='u'
   END IF
   CALL s_axm_memo(g_oma.oma01,0,g_chr)
END FUNCTION
 
FUNCTION t300_y_chk()              # when g_oma.omaconf='N' (Turn to 'Y')
   DEFINE l_occ     RECORD LIKE occ_file.*
   DEFINE l_cnt     LIKE type_file.num5   #No.FUN-680123 SMALLINT
   DEFINE l_oot05t  LIKE oot_file.oot05t
   DEFINE l_oov04f  LIKE oov_file.oov04f  #FUN-590100
   DEFINE l_oov04   LIKE oov_file.oov04   #FUN-590100
   DEFINE l_omc08   LIKE omc_file.omc08   #No.FUN-680022
   DEFINE l_omc09   LIKE omc_file.omc09   #No.FUN-680022
   DEFINE l_npq07f  LIKE npq_file.npq07f, #TQC-750177
  l_oob09   LIKE oob_file.oob09   #TQC-750177
   DEFINE l_errmsg  STRING                #No.MOD-920296 
 
   LET g_success = 'Y'
   #CHI-A80031 add --start--
   SELECT * INTO g_oma.* FROM oma_file
    WHERE oma01 = g_oma.oma01
   #CHI-A80031 add --end--
 
   IF g_oma.omaconf = 'Y' THEN
     #CALL cl_err('','axr-101',0) #CHI-A80031 mark
      CALL s_errmsg('','','','axr-101',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
 
   IF g_oma.omavoid = 'Y' THEN
     #CALL cl_err('','axr-103',0) #CHI-A80031 mark
      CALL s_errmsg('','','','axr-103',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
 
   LET l_errmsg = NULL 
   CALL t300_chk_omb31_32(g_oma.oma01) RETURNING l_errmsg
   IF NOT cl_null(l_errmsg) THEN 
     #CALL cl_err(l_errmsg,'axr-074',1) #CHI-A80031 mark
      CALL s_errmsg('',l_errmsg,'','axr-074',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF 

   #CHI-AC0046 add --start--
   LET g_flag2 = 'Y'
   IF g_oma.oma54t = 0  THEN
      CALL cl_getmsg('axr-083',g_lang) RETURNING g_msg
      LET g_msg = g_oma.oma01,g_msg
      IF cl_confirm(g_msg) THEN 
         LET g_flag2 = 'N' #不檢查,直接確認
      ELSE
         LET g_flag2 = 'Y'
         LET g_success = 'N'
      END IF
      RETURN
   END IF
   #CHI-AC0046 add --end--
 
   IF g_ooy.ooydmy2='Y' THEN
      SELECT COUNT(*) INTO l_cnt FROM npq_file
       WHERE npq01 = g_oma.oma01
         AND npq011 =  1
         AND npqsys = 'AR'
         AND npq00 = 2
         AND npqtype = '0'
         AND npq03 = g_oma.oma18
         AND npq06 = '1'
      
      IF l_cnt > 0 THEN 
         LET l_npq07f = 0
         LET l_oob09 = 0
         SELECT SUM(oob09) INTO l_oob09 FROM oob_file, ooa_file
          WHERE oob01=g_oma.oma01 AND oob01=ooa01 AND ooaconf<>'X'
            AND oob03='1'  AND oob04='2' 
            AND oob02 > 0 
         IF l_oob09 IS NULL THEN LET l_oob09 = 0 END IF       #MOD-A80138
        
         SELECT npq07f INTO l_npq07f FROM npq_file
          WHERE npq01 = g_oma.oma01
            AND npq011 =  1
            AND npqsys = 'AR'
            AND npq00 = 2
            AND npqtype = '0'
            AND npq03 = g_oma.oma18
            AND npq06 = '1'
         IF l_npq07f IS NULL THEN LET l_npq07f = 0 END IF     #MOD-A80138
         LET l_npq07f = l_npq07f * -1                         #No.MOD-A90003 
         IF l_npq07f <> (g_oma.oma54t - l_oob09) THEN
           #CALL cl_err('','axr-111',0) #CHI-A80031 mark
            CALL s_errmsg('','','','axr-111',1) #CHI-A80031
            LET g_success = 'N'
           #RETURN #CHI-A80031 mark
         END IF
      ELSE
        #CALL cl_err('','aap-995',0) #CHI-A80031 mark
         CALL s_errmsg('','','','aap-995',1) #CHI-A80031
         LET g_success = 'N'
        #RETURN #CHI-A80031 mark
      END IF

      IF g_aza.aza63 = 'Y' THEN
         SELECT COUNT(*) INTO l_cnt FROM npq_file
          WHERE npq01 = g_oma.oma01
            AND npq011 =  1
            AND npqsys = 'AR'
            AND npq00 = 2
            AND npqtype = '1'
            AND npq03 = g_oma.oma181
            AND npq06 = '1'
 
         IF l_cnt > 0 THEN 
            LET l_npq07f = 0
            LET l_oob09 = 0
            SELECT SUM(oob09) INTO l_oob09 FROM oob_file, ooa_file
             WHERE oob01=g_oma.oma01 AND oob01=ooa01 AND ooaconf<>'X'
               AND oob03='1'  AND oob04='2' 
               AND oob02 > 0 
            IF l_oob09 IS NULL THEN LET l_oob09 = 0 END IF       #MOD-A80138
            
            SELECT npq07f INTO l_npq07f FROM npq_file
             WHERE npq01 = g_oma.oma01
               AND npq011 =  1
               AND npqsys = 'AR'
               AND npq00 = 2
               AND npqtype = '1'
               AND npq03 = g_oma.oma181
               AND npq06 = '1'
            IF l_npq07f IS NULL THEN LET l_npq07f = 0 END IF     #MOD-A80138
            IF l_npq07f<0 THEN LET l_npq07f = (-1)*l_npq07f  END IF  #MOD-AB0174
            
            IF l_npq07f <> (g_oma.oma54t - l_oob09) THEN
              #CALL cl_err('','axr-112',0) #CHI-A80031 mark
               CALL s_errmsg('','','','axr-112',1) #CHI-A80031
               LET g_success = 'N'
              #RETURN #CHI-A80031 mark
            END IF
         ELSE
          #CALL cl_err('','aap-975',0) #CHI-A80031 mark
           CALL s_errmsg('','','','aap-975',1) #CHI-A80031
           LET g_success = 'N'
          #RETURN #CHI-A80031 mark
         END IF
      END IF
   END IF
 
   #CHI-A80031 mark --start--
   #SELECT * INTO g_oma.* FROM oma_file
   # WHERE oma01 = g_oma.oma01
   #CHI-A80031 mark --end--
 
   SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
    WHERE omc01 =g_oma.oma01                                                                                                  
   IF l_omc08 IS NULL THEN LET l_omc08 = 0 END IF     #MOD-A80138
   IF l_omc09 IS NULL THEN LET l_omc09 = 0 END IF     #MOD-A80138

   IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                   
     #CALL cl_err('','axr-025',1) #CHI-A80031 mark 
      CALL s_errmsg('','','','axr-025',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF                 

   SELECT * INTO l_occ.* FROM occ_file WHERE occ01 = g_oma.oma03
   IF l_occ.occacti = 'N' THEN
     #CALL cl_err(l_occ.occ01,'9028',0) #CHI-A80031 mark
      CALL s_errmsg('occ01',l_occ.occ01,'','9028',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF

   IF g_oma.oma00 = '12' or g_oma.oma00 = '13' or g_oma.oma00='21' THEN #來源類型為出貨及尾款或折讓
      IF g_bgjob='N' OR cl_null(g_bgjob) THEN       #FUN-890128
         IF g_oma.oma50 <0 or g_oma.oma50t<0 or g_oma.oma56 <0 or 
            g_oma.oma56t<0 or g_oma.oma59 <0 or g_oma.oma59t<0 THEN
            IF cl_confirm('axr-151') THEN         #繼續輸入單身
               CALL t300_b()
            END IF
         END IF
      END IF          #FUN-890128
   END IF

   #CHI-B10042 add --start--
   IF g_action_choice CLIPPED = "confirm" OR     #執行 "確認" 功能(非簽核模式呼叫)
      g_action_choice CLIPPED = "insert"  THEN 
      IF g_oma.omamksg='Y' THEN       #若簽核碼為 'Y' 且狀態碼不為 '1' 已同意
         IF g_oma.oma64 != '1' THEN
            CALL s_errmsg('occ01',l_occ.occ01,'','aws-078',1) 
            LET g_success = 'N'
         END IF
      END IF
   END IF
   #CHI-B10042 add --end--

END FUNCTION
 
FUNCTION t300_y_upd()        # when g_oma.omaconf='N' (Turn to 'Y')
   DEFINE l_npq07     LIKE npq_file.npq07
   DEFINE l_npq07_1   LIKE npq_file.npq07      #FUN-670047
   DEFINE l_oma54x    LIKE oma_file.oma54x
   DEFINE l_slip      LIKE ooy_file.ooyslip
   DEFINE l_ooy10     LIKE ooy_file.ooy10
   DEFINE l_ooy11     LIKE ooy_file.ooy11
   DEFINE l_omb31     LIKE omb_file.omb31
   DEFINE l_oga07     LIKE oga_file.oga07      #MOD-AC0033
   DEFINE l_oga23     LIKE oga_file.oga23
   DEFINE l_oga24     LIKE oga_file.oga24
   DEFINE l_omb18t    LIKE omb_file.omb18t
   DEFINE l_cnt       LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_oot04t    LIKE oot_file.oot04t     #MOD-B30709 
   DEFINE l_oot05t    LIKE oot_file.oot05t
   DEFINE l_status    LIKE npq_file.npq06      #FUN-590100
   DEFINE l_ooa01     LIKE ooa_file.ooa01   
   DEFINE only_one    LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)     #FUN-530061
   DEFINE l_amt       LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)   #FUN-530061
   DEFINE l_ool       RECORD LIKE ool_file.*   #MOD-870331 add
   DEFINE l_npq03     LIKE npq_file.npq03      #MOD-870331 add
   DEFINE l_npq031    LIKE npq_file.npq03      #MOD-870331 add
   DEFINE l_buser     LIKE type_file.chr10     #No.MOD-920343
   DEFINE l_euser     LIKE type_file.chr10     #No.MOD-920343 
   DEFINE p_dbs       LIKE type_file.chr21     #FUN-9C0041
   DEFINE l_omb44     LIKE omb_file.omb44      #FUN-9C0041
   DEFINE l_rate      LIKE oma_file.oma58      #FUN-9A0036
   DEFINE l_npq07_amt LIKE npq_file.npq07      #FUN-9A0036
   DEFINE l_azi04_2   LIKE azi_file.azi04      #MOD-B30709
   DEFINE l_oma53     LIKE oma_file.oma53      #MOD-B60021
 
   LET g_success = 'Y'
   LET g_totsuccess='Y' #CHI-A80031 add
   LET only_one = '1'           #FUN-530061
 
   IF g_action_choice CLIPPED = "confirm" OR     #執行 "確認" 功能(非簽核模式呼叫)
      g_action_choice CLIPPED = "insert"  THEN   #FUN-640246
      IF g_action_choice CLIPPED = "insert"  THEN   #CHI-B10042 add
         IF g_oma.omamksg='Y' THEN       #若簽核碼為 'Y' 且狀態碼不為 '1' 已同意
            IF g_oma.oma64 != '1' THEN
               CALL cl_err('','aws-078',1)
               LET g_success = 'N'
               RETURN
            END IF
         END IF
      END IF #CHI-B10042 add
 
      OPEN WINDOW t300_w6 WITH FORM "axr/42f/axrt300_6" ATTRIBUTE (STYLE = g_win_style CLIPPED)

      CALL cl_ui_locale("axrt300_6")
 
      LET only_one = '1'

      INPUT BY NAME only_one WITHOUT DEFAULTS

         AFTER FIELD only_one
            IF NOT cl_null(only_one) THEN
               IF only_one NOT MATCHES "[12]" THEN
                  NEXT FIELD only_one
               END IF
            END IF
 
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
         LET g_success = 'N'
         CLOSE WINDOW t300_w6
         RETURN
      END IF
   ELSE
      IF g_action_choice CLIPPED = "insert" THEN 
         IF g_oma.omamksg='Y' THEN       #若簽核碼為'Y'且狀態碼不為'1'已同意
            IF g_oma.oma64 != '1' THEN
               CALL cl_err('','aws-078',1)
               LET g_success = 'N'
               RETURN
            END IF
         END IF
      END IF
   END IF
 
   IF only_one = '1' THEN
      LET g_wc = " oma01 = '",g_oma.oma01,"' "
   ELSE
      CONSTRUCT BY NAME g_wc ON oma01,oma02,oma03

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
         
         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(oma01)
                  LET g_qryparam.state = 'c' #FUN-980030
                  LET g_qryparam.plant = g_plant #FUN-980030:預設為g_plant
                  CALL q_oma(TRUE,TRUE,g_oma.oma01,'','')  #NO:6842
                  RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oma01
               WHEN INFIELD(oma03)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_occ"
                  LET g_qryparam.state = "c"
                  LET g_qryparam.default1 = g_oma.oma03
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oma03
                  NEXT FIELD oma03
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
 
      IF INT_FLAG THEN
         LET INT_FLAG=0
         LET g_success = 'N'
         CLOSE WINDOW t300_w6
         RETURN
      END IF
   END IF
 
   LET g_sql = "SELECT SUM(oma56t) FROM oma_file",    #應收帳款本幣含稅金額
               " WHERE omaconf = 'N' AND omavoid !='Y' ",
               "   AND oma00='",g_oma.oma00,"' AND ",g_wc CLIPPED
   PREPARE t300_firm1_p2 FROM g_sql
   DECLARE t300_firm1_c2 CURSOR FOR t300_firm1_p2
 
   OPEN t300_firm1_c2
   FETCH t300_firm1_c2 INTO l_amt
 
   IF cl_null(l_amt) THEN
      LET l_amt = 0
   END IF

   DISPLAY BY NAME l_amt
 
   IF g_action_choice CLIPPED = "confirm" #按「確認」時
   OR g_action_choice CLIPPED = "insert"   #FUN-640246
   THEN
      IF NOT cl_confirm('aap-222') THEN   #是否進行確認
         LET g_success = 'N'
         CLOSE WINDOW t300_w6   #FUN-530061
         RETURN
      END IF
   END IF
 
   CALL cl_msg("WORKING !")                              #FUN-640246
 
   LET g_sql = "SELECT * FROM oma_file",
               " WHERE ",g_wc CLIPPED,   #MOD-5C0077
               "   AND omaconf = 'N' AND omavoid !='Y'"
   PREPARE t300_firm1_p3 FROM g_sql
  #DECLARE t300_firm1_c3 CURSOR FOR t300_firm1_p3           #FUN-AB0110
   DECLARE t300_firm1_c3 CURSOR WITH HOLD FOR t300_firm1_p3 #FUN-AB0110
 
  #-MOD-B30709-add-
   SELECT azi04 INTO l_azi04_2 
     FROM aaa_file,azi_file
    WHERE azi01 = aaa03
      AND aaa01 = g_bookno2
  #-MOD-B30709-end-

   BEGIN WORK
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      LET g_success = 'N'
      CLOSE t300_cl
      ROLLBACK WORK
      CLOSE WINDOW t300_w6   #FUN-530061
      RETURN
   END IF
 
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      LET g_success = 'N'
      CLOSE t300_cl
      ROLLBACK WORK
      CLOSE WINDOW t300_w6   #FUN-530061
      RETURN
   END IF

  #CALL s_showmsg_init()    #NO.FUN-710050 #CHI-A80031 mark
   LET g_oma01_t = g_oma.oma01     #保留舊值 #CHI-A80031 add
   #FUN-B50090 add begin-------------------------
   #重新抓取關帳日期
   SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
   #FUN-B50090 add -end--------------------------
   FOREACH t300_firm1_c3 INTO m_oma.*  #-->逐筆確認   #FUN-530061
      IF STATUS THEN EXIT FOREACH END IF              #MOD-AC0233
      IF g_success='N' THEN                                                                                                          
         LET g_totsuccess='N'                                                                                                       
         LET g_success="Y"                                                                                                          
      END IF                    
 
      SELECT COUNT(*),SUM(oot04t),SUM(oot05t) INTO l_cnt,l_oot04t,l_oot05t  #MOD-B30709 add oot04t
        FROM oot_file
       WHERE oot03 = m_oma.oma01   #FUN-530061 mod g_oma->m_oma
     #-MOD-B30709-add-
      IF cl_null(l_oot04t) THEN
         LET l_oot04t = 0
      END IF
     #-MOD-B30709-end-
      IF cl_null(l_oot05t) THEN
         LET l_oot05t = 0
      END IF
 
     #CHI-A80031 add --start--
     LET g_oma.oma01=m_oma.oma01
     IF only_one = '2' THEN #CHI-AC0046 add
        CALL t300_y_chk() 
     END IF #CHI-AC0046 add
     CALL s_get_doc_no(m_oma.oma01) RETURNING g_t1
     SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
     #CHI-A80031 add --end--

      IF m_oma.omavoid = 'Y' THEN   #FUN-530061 mod g_oma->m_oma
         CALL s_errmsg("omavoid","Y","","axr-103",1)             #No.TQC-740094
         LET g_success = 'N'
         LET g_totsuccess='N' #CHI-A80031 add
         CONTINUE FOREACH
      END IF
 
      IF m_oma.oma02 <= g_ooz.ooz09 THEN   #FUN-530061 mod g_oma->m_oma
         LET g_success = 'N'
         LET g_totsuccess='N' #CHI-A80031 add
         CALL s_errmsg("oma02",m_oma.oma02,"","axr-164",1)
         CONTINUE FOREACH
      END IF
 
      CALL s_get_doc_no(m_oma.oma01) RETURNING l_slip   #No.FUN-550071   #FUN-530061 mod g_oma->m_oma

      SELECT ooy10,ooy11 INTO l_ooy10,l_ooy11
        FROM ooy_file
       WHERE ooyslip = l_slip
 
      IF g_aza.aza26='2' AND l_ooy10 = 'Y' THEN   #TQC-6B0003
         SELECT SUM(omb18t) INTO l_omb18t FROM omb_file
          WHERE omb01 = m_oma.oma01   #FUN-530061 mod g_oma->m_oma
         IF cl_null(l_omb18t) THEN
            LET l_omb18t = 0
         END IF
         IF l_omb18t > l_ooy11 THEN
            CALL s_errmsg("omb18t",l_omb18t,"","axm-700",1)                         #No.TQC-740094
            LET g_success = 'N'
            LET g_totsuccess='N' #CHI-A80031 add
            CONTINUE FOREACH
         END IF
      END IF
 
      IF g_aza.aza26 != '2' AND (m_oma.oma00 = '21' OR m_oma.oma00 = '25') THEN   #FUN-530061 mod g_oma->m_oma
         CALL t300_y0()    #銷退總額不得超過發票金額-已銷退或折讓金額
         IF g_success='N' THEN
            CONTINUE FOREACH
         END IF  #021226
      END IF

      # 正常確認後，若存在直接付款，則需更新相應字段
      SELECT oma65 INTO m_oma.oma65 FROM oma_file WHERE oma01=m_oma.oma01 #No.TQC-7B0165
      IF m_oma.oma65='2' THEN   #FUN-530061
         SELECT ooa01 INTO l_ooa01 FROM ooa_file WHERE ooa01 = m_oma.oma01   #FUN-530061 mod g_oma->m_oma

         LET g_forupd_sql = "SELECT * FROM ooa_file WHERE ooa01 = ? FOR UPDATE "
         LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
         DECLARE s_t300_ooa_cl CURSOR FROM g_forupd_sql

         OPEN s_t300_ooa_cl USING l_ooa01
         IF STATUS THEN
            CALL s_errmsg('ooa01',m_oma.oma01,"OPEN s_t300_ooa_cl:", STATUS, 1)     #NO.FUN-710050
            CLOSE s_t300_ooa_cl
            LET g_success = 'N'
            LET g_totsuccess='N' #CHI-A80031 add
            CONTINUE FOREACH
         END IF
         CALL s_t300_confirm(m_oma.oma01,'')   #No.FUN-9C0014 Add ''
      END IF

     #IF g_ooy.ooydmy1 = 'Y' THEN  #MOD-940069      #CHI-AC0046 mark
      IF g_ooy.ooydmy1 = 'Y' AND g_flag2 ='Y' THEN  #MOD-940069 #CHI-AC0046
         IF m_oma.oma65 != '2' THEN   #FUN-570099             #FUN-530061 mod g_oma->m_oma
            CALL s_chknpq(m_oma.oma01,'AR',1,'0',g_bookno1)   #-->NO:0151   #FUN-530061
            IF g_aza.aza63='Y' AND g_success='Y' THEN
               CALL s_chknpq(m_oma.oma01,'AR',1,'1',g_bookno2)   #-->NO:0151   #FUN-530061
            END IF
         END IF
 
         #抓取匯兌損失(ool52,ool521)、匯兌收益(ool53,ool531)
         INITIALIZE l_ool.* TO NULL
         LET l_npq03 = ''
         LET l_npq031 = ''
         SELECT * INTO l_ool.* FROM ool_file WHERE ool01=m_oma.oma13
         
         #檢查單頭金額與分錄金額借方科目是否相符
         IF m_oma.oma00 MATCHES '2*' THEN   #FUN-530061 mod g_oma->m_oma   #MOD-920110 mod
            LET l_status= '2'            #貸
            LET l_npq03 = l_ool.ool53    #匯兌收益科目     #MOD-870331 add
            LET l_npq031= l_ool.ool531   #匯兌收益科目二   #MOD-870331 add
         ELSE
            LET l_status= '1'            #借
            LET l_npq03 = l_ool.ool52    #匯兌損失科目     #MOD-870331 add
            LET l_npq031= l_ool.ool521   #匯兌損失科目二   #MOD-870331 add
         END IF

         IF cl_null(l_npq03)  THEN LET l_npq03 = ' ' END IF   #MOD-870331 add
         IF cl_null(l_npq031) THEN LET l_npq031= ' ' END IF   #MOD-870331 add

         IF m_oma.oma00 MATCHES '2*' THEN   #FUN-530061 mod g_oma->m_oma
            #No.MOD-A90001  --Begin
            #SELECT SUM(npq07) INTO l_npq07 FROM npq_file
            # WHERE npq01 = m_oma.oma01 AND npq06 = l_status  #FUN-590100
            #   AND npqsys= 'AR' AND npq011 = 1   #AND npq03=m_oma.oma18             #FUN-530061   #MOD-860185 mark npq03條件
            #   AND npqtype= '0'  #FUN-670047
            #   AND npq03 != l_npq03   #MOD-870331 add   #排除匯差科目
            #   AND npq00 = 2   #MOD-8C0223 add   #只抓2.應收的分錄
            #IF cl_null(l_npq07) THEN LET l_npq07=0 END IF

            #贷方金额
            SELECT SUM(ABS(npq07)) INTO l_npq07 FROM npq_file
             WHERE npq01 = m_oma.oma01 
               AND npqsys= 'AR' AND npq011 = 1   
               AND npqtype= '0' 
               AND npq03 != l_npq03  
               AND npq00 = 2   
               AND (npq06 = '2' AND npq07 > 0 OR npq06 = '1' AND npq07 < 0 )
            IF cl_null(l_npq07) THEN LET l_npq07=0 END IF
            #No.MOD-A90001  --End

            IF l_npq07<0 THEN LET l_npq07 = (-1)*l_npq07  END IF  #FUN-590100
            IF l_npq07 !=(m_oma.oma56t+m_oma.oma53) THEN   #FUN-530061     #MOD-860185
               CALL s_errmsg("npq07",l_npq07,"","aap-278",1)
               LET g_success = 'N'
               LET g_totsuccess='N' #CHI-A80031 add
            END IF
            IF g_aza.aza63 = 'Y' THEN
               #--FUN-9A0036 start----
               CALL s_newrate(g_bookno1,g_bookno2,m_oma.oma23,
                              m_oma.oma58,m_oma.oma02)
               RETURNING l_rate
               #--FUN-9A0036 end-----

               #No.MOD-A90001  --Begin
               #SELECT SUM(npq07) INTO l_npq07_1 FROM npq_file
               # WHERE npq01 = m_oma.oma01 AND npq06 = l_status
               #   AND npqsys= 'AR' AND npq011 = 1   #AND npq03=m_oma.oma181             #FUN-530061   #MOD-860185 mark npq03條件
               #   AND npqtype= '1'
               #   AND npq03 != l_npq031  #MOD-870331 add   #排除匯差科目
               #   AND npq00 = 2   #MOD-8C0223 add   #只抓2.應收的分錄

               SELECT SUM(ABS(npq07f)) INTO l_npq07_1 FROM npq_file     #MOD-B60021 mod npq07f
                WHERE npq01 = m_oma.oma01 
                  AND npqsys= 'AR' AND npq011 = 1
                  AND npqtype= '1'
                  AND npq03 != l_npq031  
                  AND npq00 = 2 
                  AND (npq06 = '2' AND npq07 > 0 OR npq06 = '1' AND npq07 < 0 )
               #No.MOD-A90001  --End  

               IF cl_null(l_npq07_1) THEN LET l_npq07_1=0 END IF
               IF l_npq07_1<0 THEN LET l_npq07_1 = (-1)*l_npq07_1  END IF  #FUN-590100
#              IF l_npq07_1 !=(m_oma.oma56t+m_oma.oma53) THEN   #FUN-530061  #MOD-860185 #FUN-9A0036 mark
               #--FUN-9A0036 start--
              #CALL cl_digcut(l_npq07_1,g_azi04) RETURNING l_npq07_1        #MOD-B30709 mark
              #LET l_npq07_amt = (m_oma.oma56t+m_oma.oma53)*l_rate          #MOD-B30709 mark
              #LET l_npq07_amt = (m_oma.oma54t+m_oma.oma52)*l_rate          #MOD-B30709 #MOD-B60059 mark
               LET l_npq07_amt = m_oma.oma54t+m_oma.oma52                   #MOD-B60059
              #CALL cl_digcut(l_npq07_amt,g_azi04) RETURNING l_npq07_amt    #MOD-B30709 mark
               CALL cl_digcut(l_npq07_amt,l_azi04_2) RETURNING l_npq07_amt  #MOD-B30709
               IF l_npq07_1 !=l_npq07_amt THEN
               #--FUN-9A0036 end----
                  CALL s_errmsg("npq07",l_npq07_1,"","aap-278",1)
                  LET g_success = 'N'
                  LET g_totsuccess='N' #CHI-A80031 add
               END IF
            END IF
         ELSE
            IF m_oma.oma65 != '2' THEN   #FUN-570099   #FUN-530061 mod g_oma->m_oma
               IF m_oma.oma00 = '12' AND NOT cl_null(m_oma.oma19) THEN 
                  #No.MOD-A90001  --Begin
                  #SELECT SUM(npq07) INTO l_npq07 FROM npq_file
                  # WHERE npq01 = m_oma.oma01 AND npq06 = '2'
                  #   AND npqsys= 'AR' AND npq011 = 1 
                  #   AND npqtype = '0' 
                  #   AND npq03 != l_ool.ool53
                  #   AND npq00 = 2   

                  SELECT SUM(ABS(npq07)) INTO l_npq07 FROM npq_file
                   WHERE npq01 = m_oma.oma01
                     AND npqsys= 'AR' AND npq011 = 1 
                     AND npqtype = '0' 
                     AND npq03 != l_ool.ool53
                     AND npq00 = 2   
                     AND (npq06 = '2' AND npq07 > 0 OR npq06 = '1' AND npq07 < 0 )
                  #No.MOD-A90001  --End  
               ELSE     
                  #No.MOD-A90001  --Begin
                  #SELECT SUM(npq07) INTO l_npq07 FROM npq_file
                  # WHERE npq01 = m_oma.oma01 AND npq06 = l_status   #'1'     #FUN-530061   #MOD-870331 mod '1'->l_status
                  #   AND npqsys= 'AR' AND npq011 = 1   #AND npq03=m_oma.oma18   #FUN-530061   #MOD-860185 mark npq03條件
                  #   AND npqtype= '0' #FUN-670047
                  #   AND npq03 != l_npq03   #MOD-870331 add   #排除匯差科目
                  #   AND npq00 = 2   #MOD-8C0223 add   #只抓2.應收的分錄
                  SELECT SUM(ABS(npq07)) INTO l_npq07 FROM npq_file
                   WHERE npq01 = m_oma.oma01 
                     AND npqsys= 'AR' AND npq011 = 1 
                     AND npqtype= '0' 
                     AND npq03 != l_npq03 
                     AND npq00 = 2  
                     AND (npq06 = '1' AND npq07 > 0 OR npq06 = '2' AND npq07 < 0)
                  #No.MOD-A90001  --End  
               END IF      #MOD-940226                                  

               IF cl_null(l_npq07) THEN LET l_npq07=0 END IF
              #-MOD-AC0033-add-
               LET l_oga07 = 'N'
               IF m_oma.oma00 = '12' AND NOT cl_null(m_oma.oma16) THEN
                  SELECT oga07 INTO l_oga07 
                    FROM oga_file
                   WHERE oga01 = m_oma.oma16
                  IF l_oga07 = 'Y' THEN 
                     LET m_oma.oma53 = 0
                  END IF 
               END IF 
              #-MOD-AC0033-end-
               LET l_oma53 = m_oma.oma24 * m_oma.oma52             #MOD-B60021
               CALL cl_digcut(l_oma53,g_azi04) RETURNING l_oma53   #MOD-B60021
               IF l_cnt > 0 THEN
                  #No.MOD-A90001  --Begin
                 #IF l_npq07 != (m_oma.oma56t+m_oma.oma53-l_oot05t) THEN   #FUN-9A0036 mark  #No.MOD-A90001 unmark #MOD-B60021 mark
                  IF l_npq07 != (m_oma.oma56t+l_oma53-l_oot05t) THEN       #MOD-B60021
#                 IF l_npq07_1 !=l_npq07_amt THEN                          #FUN-9A0036       #No.MOD-A90001 mark
                  #No.MOD-A90001  --End  
                     CALL s_errmsg("npq07",l_npq07,"","aap-278",1)
                     LET g_success = 'N'
                     LET g_totsuccess='N' #CHI-A80031 add
                  END IF
               ELSE
                  #No.MOD-A90001  --Begin
                 #IF l_npq07 !=(m_oma.oma56t+m_oma.oma53) THEN             #FUN-9A0036 mark  #No.MOD-A90002 unmark #MOD-B60021 mark
                  IF l_npq07 !=(m_oma.oma56t+l_oma53) THEN       #MOD-B60021 
#                 IF l_npq07_1 !=l_npq07_amt THEN                          #FUN-9A0036       #No.MOD-A90002 mark
                  #No.MOD-A90001  --End  
                     CALL s_errmsg("npq07",l_npq07,"","aap-278",1)
                     LET g_success = 'N'
                     LET g_totsuccess='N' #CHI-A80031 add
                  END IF
               END IF

               IF g_aza.aza63 = 'Y' THEN
                  #--No.TQC-B10142 start----
                  CALL s_newrate(g_bookno1,g_bookno2,m_oma.oma23,
                                 m_oma.oma58,m_oma.oma02)
                       RETURNING l_rate
                  #--No.TQC-B10142 end-----
                  IF m_oma.oma00 = '12' AND NOT cl_null(m_oma.oma19) THEN 
                     #No.MOD-A90001  --Begin
                     #SELECT SUM(npq07) INTO l_npq07_1 FROM npq_file
                     # WHERE npq01 = m_oma.oma01 AND npq06 = '2'
                     #   AND npqsys= 'AR' AND npq011 = 1 
                     #   AND npqtype = '1' 
                     #   AND npq03 != l_ool.ool531
                     #   AND npq00 = 2   
                     SELECT SUM(ABS(npq07f)) INTO l_npq07_1 FROM npq_file     #MOD-B60021 mod npq07f
                      WHERE npq01 = m_oma.oma01
                        AND npqsys= 'AR' AND npq011 = 1 
                        AND npqtype = '1' 
                        AND npq03 != l_ool.ool531
                        AND npq00 = 2   
                        AND (npq06 = '2' AND npq07 > 0 OR npq06 = '1' AND npq07 < 0)
                     #No.MOD-A90001  --End  
                  ELSE     
                     #No.MOD-A90001  --Begin
                     #SELECT SUM(npq07) INTO l_npq07_1 FROM npq_file
                     # WHERE npq01 = m_oma.oma01 AND npq06 = l_status   #'1'          #FUN-530061   #MOD-870331 mod '1'->l_status
                     #   AND npqsys= 'AR' AND npq011 = 1    #AND npq03=m_oma.oma181   #FUN-530061   #MOD-860185 mark npq03條件
                     #   AND npqtype= '1' 
                     #   AND npq03 != l_npq031  #MOD-870331 add   #排除匯差科目
                     #   AND npq00 = 2   #MOD-8C0223 add   #只抓2.應收的分錄
                     SELECT SUM(ABS(npq07f)) INTO l_npq07_1 FROM npq_file     #MOD-B60021 mod npq07f
                      WHERE npq01 = m_oma.oma01 
                        AND npqsys= 'AR' AND npq011 = 1 
                        AND npqtype= '1' 
                        AND npq03 != l_npq031 
                        AND npq00 = 2  
                        AND (npq06 = '1' AND npq07 > 0 OR npq06 = '2' AND npq07 < 0)
                     #No.MOD-A90001  --End  
                  END IF      #MOD-940226                                     
               
                  IF cl_null(l_npq07_1) THEN LET l_npq07_1=0 END IF

                  #--No.TQC-B10142 start--
                 #CALL cl_digcut(l_npq07_1,g_azi04) RETURNING l_npq07_1   #MOD-B30709 mark
                  #--No.TQC-B10142 end----

                  IF l_cnt > 0 THEN
                     #--No.TQC-B10142 start--
                    #LET l_npq07_amt = (m_oma.oma56t+m_oma.oma53-l_oot05t)*l_rate #MOD-B30709 mark
                    #LET l_npq07_amt = (m_oma.oma54t+m_oma.oma52-l_oot04t)*l_rate #MOD-B30709 #MOD-B60059 mark
                     LET l_npq07_amt = m_oma.oma54t+m_oma.oma52-l_oot04t          #MOD-B60059
                    #CALL cl_digcut(l_npq07_amt,g_azi04) RETURNING l_npq07_amt    #MOD-B30709 mark
                     CALL cl_digcut(l_npq07_amt,l_azi04_2) RETURNING l_npq07_amt  #MOD-B30709
                     #IF l_npq07_1 != (m_oma.oma56t+m_oma.oma53-l_oot05t) THEN   #FUN-530061   #MOD-870331
                     IF l_npq07_1 !=l_npq07_amt THEN
                     #--No.TQC-B10142 end----
                        CALL s_errmsg("npq07",l_npq07_1,"","aap-278",1)
                        LET g_success = 'N'
                        LET g_totsuccess='N' #CHI-A80031 add
                     END IF
                  ELSE
                     #--No.TQC-B10142 start--
                    #LET l_npq07_amt = (m_oma.oma56t+m_oma.oma53)*l_rate          #MOD-B30709 mark
                    #LET l_npq07_amt = (m_oma.oma54t+m_oma.oma52)*l_rate #MOD-B30709 #MOD-B60059 mark
                     LET l_npq07_amt = m_oma.oma54t+m_oma.oma52          #MOD-B60059
                    #CALL cl_digcut(l_npq07_amt,g_azi04) RETURNING l_npq07_amt    #MOD-B30709 mark
                     CALL cl_digcut(l_npq07_amt,l_azi04_2) RETURNING l_npq07_amt  #MOD-B30709
                     #IF l_npq07_1 !=(m_oma.oma56t+m_oma.oma53) THEN   #FUN-530061  #MOD-860185
                     IF l_npq07_1 !=l_npq07_amt THEN
                     #--No.TQC-B10142 end----
                        CALL s_errmsg("npq07",l_npq07_1,"","aap-278",1)
                        LET g_success = 'N'
                        LET g_totsuccess='N' #CHI-A80031 add
                     END IF
                  END IF
               END IF
            END IF
         END IF
         CALL s_t300_w1('+',m_oma.oma01)     #No.FUN-AB0034
         IF g_success='Y' THEN
            LET g_cnt=0
            SELECT COUNT(*) INTO g_cnt FROM npp_file,oma_file
             WHERE oma01=m_oma.oma01   #FUN-530061 mod g_oma->m_oma
               AND npp01=oma01 AND nppsys='AR' AND npp011=1 AND npp00=2
               AND ( YEAR(oma02) != YEAR(npp02) OR
                   (YEAR(oma02)  = YEAR(npp02) AND MONTH(oma02) != MONTH(npp02)))
            IF g_cnt >0 THEN
               LET g_showmsg=m_oma.oma01,"/",'AR',"/",1,"/",2                  #NO.FUN-710050
               CALL s_errmsg('oma01,nppsys,npp011,npp00',g_showmsg,'','aap-279',1)    #NO.FUN-710050  #No.TQC-740094
               LET g_success = 'N'
               LET g_totsuccess='N' #CHI-A80031 add
            END IF
         END IF

         IF g_success='Y' THEN
            IF m_oma.oma213='N' THEN
               LET l_oma54x=m_oma.oma54*m_oma.oma211/100
               CALL cl_digcut(l_oma54x,t_azi04) RETURNING l_oma54x  #No.TQC-750093 g_azi -> t_azi
            ELSE
               LET l_oma54x=m_oma.oma54t*m_oma.oma211/(100+m_oma.oma211)
               CALL cl_digcut(l_oma54x,t_azi04) RETURNING l_oma54x  #No.TQC-750093 g_azi -> t_azi
            END IF
            IF l_oma54x != m_oma.oma54x THEN
               CALL s_errmsg("oma54x",l_oma54x,"","aap-757",0)
            END IF
         END IF
      END IF
 
      IF g_success = 'N' THEN
          CONTINUE FOREACH #CHI-A80031 add 
         #EXIT FOREACH           #No.TQC-7B0043 #CHI-A80031 mark
      END IF
 
      IF m_oma.oma10 IS NULL OR m_oma.oma10 = ' ' THEN   #FUN-530061 mod g_oma->m_oma
         SLEEP 0
      ELSE
         IF m_oma.oma00 MATCHES '1*' THEN    #2000/04/25 modify
            LET l_cnt = 0
            SELECT COUNT(*) INTO l_cnt FROM oma_file
             WHERE oma10 = g_oma.oma10 AND oma01 != g_oma.oma01
            IF l_cnt = 0 THEN
               UPDATE ome_file SET ome21  = m_oma.oma21,
                                   ome211 = m_oma.oma211,
                                   ome212 = m_oma.oma212,
                                   ome213 = m_oma.oma213,
                                   ome59  = m_oma.oma59,
                                   ome59x = m_oma.oma59x,
                                   ome59t = m_oma.oma59t,
                                   ome17  = m_oma.oma17,
                                   ome171 = m_oma.oma171,
                                   ome172 = m_oma.oma172
                WHERE ome00 = '1'
                  AND ome01 = m_oma.oma10
            END IF   #MOD-630103
         END IF
      END IF
 
      LET m_oma.oma64 = '1'   #FUN-530061 mod g_oma->m_oma
 
      UPDATE oma_file SET oma64 = m_oma.oma64 WHERE oma01 = m_oma.oma01   #FUN-530061 mod g_oma->m_oma
      IF STATUS THEN
         CALL s_errmsg("oma01",m_oma.oma01,"",STATUS,1)   #No.TQC-740094
         LET g_success = 'N'
         LET g_totsuccess='N' #CHI-A80031 add
      END IF
#FUN-AB0110 --Begin
      IF g_ooy.ooydmy1 = 'Y' AND g_success = 'Y' THEN
         CALL s_t300_ins_oct(g_oma.oma01,g_oma.oma00,'0') RETURNING i
         IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
             CALL s_t300_ins_oct(g_oma.oma01,g_oma.oma00,'1') RETURNING i
         END IF
     #END IF   #MOD-B30601 mark
        #IF i = 0 THEN LET g_success = 'N' RETURN END IF   #TQC-AC0187 mark
        #-TQC-AC0187-add-
         IF i = 0 THEN
            LET g_success = 'N'
            CLOSE WINDOW t300_w6
            RETURN
         END IF
        #-TQC-AC0187-end-
      END IF   #MOD-B30601 add
#FUN-AB0110 --End
 
      CALL s_ar_conf('y',m_oma.oma01,'') RETURNING i   #No.FUN-9C0014 Add ''

      CALL t300_omc_check()   #MOD-820044
 
      IF i=0 THEN
         SELECT * INTO m_oma.* FROM oma_file WHERE oma01 = m_oma.oma01
         DISPLAY m_oma.omaconf TO omaconf
         DISPLAY m_oma.oma19 TO oma19
         DISPLAY m_oma.oma64 TO oma64 #FUN-540040
      END IF
 
      IF g_flag2 ='Y' THEN  #CHI-AC0046 add
         IF g_ooy.ooydmy1 = 'Y' THEN   #MOD-940069
            SELECT COUNT(*) INTO l_cnt FROM npq_file 
             WHERE npq01= m_oma.oma01
               AND npq00= 2  
               AND npqsys= 'AR'  
               AND npq011= 1
            IF l_cnt = 0 THEN
               CALL t300_gen_glcr(m_oma.*,g_ooy.*)
            END IF

            IF g_success = 'Y' THEN 
               IF m_oma.oma65 != '2' THEN
                  CALL s_chknpq(m_oma.oma01,'AR',1,'0',g_bookno1)
                  IF g_aza.aza63='Y' THEN
                     CALL s_chknpq(m_oma.oma01,'AR',1,'1',g_bookno2)
                  END IF
               END IF
            END IF
            IF g_success = 'N' THEN CONTINUE FOREACH END IF #No.FUN-670047
         END IF
 
         #BUGNO:4288 回寫出貨單匯率
         IF m_oma.omaconf ='Y' AND g_ooz.ooz10='Y' THEN   #FUN-530061 mod g_oma->m_oma
            DECLARE t300_oga CURSOR FOR SELECT omb44,omb31 FROM omb_file    #FUN-9C0041 add omb44
              WHERE omb01=m_oma.oma01   #FUN-530061 mod g_oma->m_oma
 
            FOREACH t300_oga INTO l_omb44,l_omb31    #FUN-9C0041 add omb44
               IF SQLCA.SQLCODE THEN
                  CALL s_errmsg("omb01",m_oma.oma01,"",SQLCA.sqlcode,0)
                  EXIT FOREACH
               END IF
 
               #LET g_plant_new = l_omb44
               #CALL s_gettrandbs()
               #LET p_dbs = g_dbs_tra
               #LET g_sql = "SELECT oga23,oga24 FROM ",p_dbs CLIPPED,"oga_file ",
               LET g_sql = "SELECT oga23,oga24 FROM ",cl_get_target_table(l_omb44,'oga_file'), #FUN-A50102
                           " WHERE oga01 = '",l_omb31,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102              
               PREPARE sel_oga23_pre FROM g_sql
               EXECUTE sel_oga23_pre INTO l_oga23,l_oga24
 
               IF l_oga23 = g_aza.aza17 THEN
                  CONTINUE FOREACH       #同為本國幣別不UPDATE
               END IF
               
               IF l_oga23 = m_oma.oma23 THEN   #FUN-530061 mod g_oma->m_oma
                  #LET g_sql = "UPDATE ",p_dbs CLIPPED ,"oga_file ",
                  LET g_sql = "UPDATE ",cl_get_target_table(l_omb44,'oga_file'), #FUN-A50102
                              "   SET oga24 = '",m_oma.oma24,"' ",
                              " WHERE oga01 = '",l_omb31,"' " 
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102             
                  PREPARE upd_oga_pre7 FROM g_sql
                  EXECUTE upd_oga_pre7
               ELSE                      #不同幣別不UPDATE
                  CONTINUE FOREACH
               END IF
            END FOREACH
         END IF
      END IF  #CHI-AC0046 add
   END FOREACH   #FUN-530061
   LET g_oma.oma01 = g_oma01_t #CHI-A80031 add

   IF g_totsuccess="N" THEN                                                                                                         
      LET g_success="N"                                                                                                             
   END IF 
 
   #CALL s_showmsg()            #NO.FUN-710050  #No.TQC-740094 #CHI-A80031 mark

   IF g_action_choice CLIPPED = "confirm"  #執行 "確認" 功能(非簽核模式呼叫)
   OR g_action_choice CLIPPED = "insert"  
   THEN
      CLOSE WINDOW t300_w6   #FUN-530061
   END IF
 
   IF g_success = 'Y' THEN
      IF g_oma.omamksg = 'Y' THEN #簽核模式
         CASE aws_efapp_formapproval()#呼叫 EF 簽核功能
            WHEN 0  #呼叫 EasyFlow 簽核失敗
               LET g_oma.omaconf="N"
               LET g_success = "N"
               ROLLBACK WORK
               RETURN
            WHEN 2  #當最後一關有兩個以上簽核者且此次簽核完成後尚未結案
               LET g_oma.omaconf="N"
               ROLLBACK WORK
               RETURN
         END CASE
      END IF

      IF g_success='Y' THEN
         LET g_oma.oma64='1'#執行成功, 狀態值顯示為 '1' 已核准
         LET g_oma.omaconf='Y'              #執行成功, 確認碼顯示為 'Y' 已確認
         DISPLAY BY NAME g_oma.omaconf
         DISPLAY BY NAME g_oma.oma64
         COMMIT WORK
         CALL cl_flow_notify(g_oma.oma01,'Y')
      ELSE
         LET g_oma.omaconf='N'
         LET g_success = 'N'
         ROLLBACK WORK
      END IF
   ELSE
      LET g_oma.omaconf='N'
      LET g_success = 'N'
      ROLLBACK WORK
   END IF
 
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
      IF NOT cl_null(g_oma.oma99) THEN 
         LET l_buser = '0'  
         LET l_euser = 'z' 
      ELSE                 
         LET l_buser = g_oma.omauser 
         LET l_euser = g_oma.omauser  
      END IF                    
      LET g_wc_gl = 'npp01 = "',m_oma.oma01,'" AND npp011 = 1'
      LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",l_buser,"' '",l_euser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",m_oma.oma02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"   #No.FUN-670047  #No.MOD-860075  #MOD-910250 #No.MOD-920343
      CALL cl_cmdrun_wait(g_str)
      SELECT oma33 INTO g_oma.oma33 FROM oma_file
       WHERE oma01 = m_oma.oma01
      DISPLAY BY NAME m_oma.oma33
   END IF

#FUN-AB0110 --Begin mark
#  #--FUN-A60007 start--
#  IF g_ooy.ooydmy1 = 'Y' AND g_success = 'Y' THEN
#      CALL s_t300_ins_oct(g_oma.oma01,g_oma.oma00,'0')
#      IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
#          CALL s_t300_ins_oct(g_oma.oma01,g_oma.oma00,'1')
#      END IF
#  END IF
#  #--FUN-A60007 end--
#FUN-AB0110 --End mark
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01

   IF g_oma.omaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
   IF g_oma.oma64='1' OR g_oma.oma64='2' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
   IF g_oma.oma64='6' THEN LET g_chr3='Y' ELSE LET g_chr3='N' END IF
   CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"",g_chr3,g_chr,"")
 
END FUNCTION
 
FUNCTION t300_ef()
    CALL s_showmsg_init() #CHI-A80031 add
    CALL t300_y_chk()          #CALL 原確認段的 check 段後在執行送簽
    IF g_success = "N" THEN
RETURN
    END IF
    CALL s_showmsg()  #CHI-A80031 add
 
    CALL aws_condition()#判斷送簽資料
    IF g_success = 'N' THEN
  RETURN
    END IF
##########
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########
 
 IF aws_efcli2(base.TypeInfo.create(g_oma),base.TypeInfo.create(g_omb),'','','','')
 THEN
    LET g_success = 'Y'
    LET g_oma.oma64 = 'S'
    DISPLAY BY NAME g_oma.oma64
 ELSE
    LET g_success = 'N'
 END IF
 
END FUNCTION
 
FUNCTION t300_y0()
   DEFINE l_oha16 LIKE oha_file.oha16
   DEFINE l_ohb30 LIKE ohb_file.ohb30                      #canny(980824)
   DEFINE l_oha01 LIKE oha_file.oha01,
          l_omb   RECORD   LIKE omb_file.*,
          l_diff1,l_diff2,l_diff3  LIKE oma_file.oma56t
   DEFINE lb_oma01   LIKE oma_file.oma01
   DEFINE lb_omaconf LIKE oma_file.omaconf
   DEFINE lb_oma00   LIKE oma_file.oma00
   DEFINE lb_oma54t  LIKE oma_file.oma54t
   DEFINE lb_oma56t  LIKE oma_file.oma56t
   DEFINE lb_oma59t  LIKE oma_file.oma59t
   DEFINE l_ohb31    LIKE ohb_file.ohb31
   DEFINE l_oma54t,l_oma56t  LIKE oma_file.oma54t
   DEFINE l_oma59t           LIKE oma_file.oma59t
   DEFINE l_tot1,l_tot2,l_tot3,l_tot4,l_tot5,l_tot6  LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_tot22,l_tot42,l_tot62                    LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_str3,l_str4   STRING    #No.FUN-570099
   DEFINE l_str           STRING    #MOD-750142
 
### 需考慮一張發票可能同時有銷退和折扣
   DECLARE t300_by_omb CURSOR FOR
   #SELECT omb31,omb44,SUM(omb14t),SUM(omb16t),SUM(omb18t) FROM omb_file #No.FUN-9C0014 Add omb44  #MOD-B30086 mark
    SELECT omb31,SUM(omb14t),SUM(omb16t),SUM(omb18t),omb44 FROM omb_file #No.FUN-9C0014 Add omb44  #MOD-B30086
     WHERE omb01 = g_oma.oma01
     GROUP BY omb31,omb44      #No.FUN-9C0014 Add omb44

   FOREACH t300_by_omb INTO l_omb.omb31,l_omb.omb14t,l_omb.omb16t,l_omb.omb18t,l_omb.omb44 #No.FUN-9C0014 Add omb44
      IF STATUS THEN 
         CALL s_errmsg("omb01",g_oma.oma01,"foreach omb",STATUS,0)
         EXIT FOREACH
      END IF

      LET li_dbs = ''
      IF NOT cl_null(l_omb.omb44) THEN
         LET g_plant_new = l_omb.omb44
      ELSE
         LET g_plant_new = g_plant
      END IF

      #CALL s_gettrandbs()
      #LET li_dbs = g_dbs_tra
      LET l_tot1 = 0
      LET l_tot2 = 0   LET l_tot22 = 0
      LET l_tot3 = 0
      LET l_tot4 = 0   LET l_tot42 = 0
      IF g_oma.oma00 = '25' THEN
         ### 得多張銷折
         SELECT SUM(omb14t),SUM(omb16t),SUM(omb18t)
           INTO l_tot1,l_tot2,l_tot22
           FROM omb_file,oma_file
          WHERE omb31 = l_omb.omb31     ### 出貨單
            AND omb01 = oma01 AND omaconf ='Y'
            AND oma00 = '25'
         IF STATUS OR l_tot1 IS NULL THEN
            LET l_tot1 = 0
            LET l_tot2 = 0   LET l_tot22 = 0
         END IF

         #LET g_sql = " SELECT oha01 FROM ",li_dbs CLIPPED,"oha_file",
         LET g_sql = " SELECT oha01 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                     "  WHERE oha16 = '",l_omb.omb31,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
         DECLARE a_curs CURSOR FROM g_sql

         FOREACH a_curs INTO l_oha01
            IF STATUS THEN EXIT FOREACH END IF              #MOD-AC0233
            SELECT SUM(omb14t),SUM(omb16t),SUM(omb18t)
              INTO l_tot5,l_tot6,l_tot62
              FROM omb_file,oma_file
             WHERE omb31 = l_oha01
               AND omb01 = oma01 AND omaconf ='Y'
               AND oma00 = '21'
            IF STATUS OR l_tot5 IS NULL THEN
               LET l_tot5 = 0
               LET l_tot6 = 0  LET l_tot62 = 0
            END IF
            LET l_tot3  = l_tot3  + l_tot5
            LET l_tot4  = l_tot4  + l_tot6
            LET l_tot42 = l_tot42 + l_tot62
         END FOREACH
         SELECT oma54t,oma56t,oma59t INTO l_oma54t,l_oma56t,l_oma59t
           FROM oma_file
          WHERE oma01 = g_oma.oma16
            AND omaconf = 'Y'
            AND oma00 MATCHES '1*'
         IF STATUS OR l_oma54t IS NULL THEN
            LET l_oma54t = 0
            LET l_oma56t = 0
            LET l_oma59t = 0
         END IF
      ELSE
         LET g_sql = " SELECT UNIQUE ohb31,ohb30",
                     #"   FROM ",li_dbs CLIPPED,"ohb_file",
                     "   FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                     "  WHERE ohb01 = '",l_omb.omb31,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
         PREPARE sel_ohb_pre83 FROM g_sql
         EXECUTE sel_ohb_pre83 INTO l_oha16,l_ohb30

         IF STATUS = 0 THEN
            LET g_sql = " SELECT unique oha01 ",
                        #"   FROM ",li_dbs CLIPPED,"oha_file,",li_dbs CLIPPED,"ohb_file",
                        "   FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                   cl_get_target_table(g_plant_new,'ohb_file'),      #FUN-A50102
                        "  WHERE oha16 = '",l_oha16,"'",
                        "    AND oha01 = ohb01",
                        "    AND ohb30 = '",l_ohb30,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
            DECLARE b_curs CURSOR FROM g_sql

            FOREACH b_curs INTO l_oha01
               IF STATUS THEN EXIT FOREACH END IF              #MOD-AC0233
               SELECT SUM(omb14t),SUM(omb16t),SUM(omb18t)
                 INTO l_tot3,l_tot4,l_tot42
                 FROM omb_file,oma_file
                WHERE omb31 = l_oha01
                  AND omb01 = oma01 AND omaconf ='Y'
                  AND oma00 = '21'
               IF STATUS OR l_tot3 IS NULL  THEN
                  LET l_tot3 = 0
                  LET l_tot4 = 0  LET l_tot42 = 0
               END IF
               IF cl_null(l_tot3)  THEN LET l_tot3 = 0 END IF
               IF cl_null(l_tot4)  THEN LET l_tot4 = 0 END IF
               IF cl_null(l_tot42) THEN LET l_tot42 = 0 END IF
               LET l_tot1  = l_tot1 + l_tot3
               LET l_tot2  = l_tot2 + l_tot4
               LET l_tot22 = l_tot22 + l_tot42
            END FOREACH
         END IF

         ### 得多張銷折
         LET l_tot3 = 0 LET l_tot4 = 0 LET l_tot42 = 0
         SELECT SUM(omb14t),SUM(omb16t),SUM(omb18t)
           INTO l_tot3,l_tot4,l_tot42
           FROM omb_file,oma_file
          WHERE omb31 = l_oha16     ### 出貨單
            AND omb01 = oma01 AND omaconf ='Y'
            AND oma00 = '25'
         IF STATUS OR l_tot3 IS NULL THEN
            LET l_tot3 = 0
            LET l_tot4 = 0
         END IF

         IF cl_null(l_tot3)  THEN LET l_tot3 = 0 END IF
         IF cl_null(l_tot4)  THEN LET l_tot4 = 0 END IF
         IF cl_null(l_tot42) THEN LET l_tot42 = 0 END IF
         IF cl_null(l_oma54t) THEN LET l_oma54t = 0 END IF  #原幣應收含稅金額
         IF cl_null(l_oma56t) THEN LET l_oma56t = 0 END IF  #本幣應收含稅金額
         IF cl_null(l_oma59t) THEN LET l_oma59t = 0 END IF  #本幣發票含稅金額

         LET g_sql = " SELECT ohb31 ",
                     #"   FROM ",li_dbs CLIPPED,"oha_file,",li_dbs CLIPPED,"ohb_file",
                     "   FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                cl_get_target_table(g_plant_new,'ohb_file'),     #FUN-A50102
                     "  WHERE ohb01=oha01",
                     "    AND oha01='",l_oha01,"'",                              #MOD-A60017
                     "    AND ohaconf='Y'"                                       #MOD-A60017
          CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
	  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102            
         DECLARE cur_ohb CURSOR FROM g_sql

         FOREACH cur_ohb INTO l_ohb31
            IF SQLCA.SQLCODE THEN
               CALL s_errmsg("oha01",l_oha01,"",SQLCA.sqlcode,1)
               LET g_success='N'
            END IF
            
            SELECT sum(omb14t),sum(omb16t),sum(omb18t) INTO lb_oma54t,lb_oma56t,lb_oma59t
              FROM oma_file,omb_file
             WHERE omb31=l_ohb31
               AND oma01=omb01
               AND omaconf='Y'
               AND oma00='12'
            
            LET l_oma54t=lb_oma54t
            LET l_oma56t=lb_oma56t
            LET l_oma59t=lb_oma59t
            IF cl_null(l_oma54t) THEN LET l_oma54t = 0 END IF  #原幣應收含稅金額
            IF cl_null(l_oma56t) THEN LET l_oma56t = 0 END IF  #本幣應收含稅金額
            IF cl_null(l_oma59t) THEN LET l_oma59t = 0 END IF  #本幣發票含稅金額
            
            LET l_diff1 = l_oma54t - (l_tot1 +l_tot3 +l_omb.omb14t)
            LET l_diff2 = l_oma56t - (l_tot2 +l_tot4 +l_omb.omb16t)
            LET l_diff3 = l_oma59t - (l_tot22+l_tot42+l_omb.omb18t)
            IF l_diff3<0 THEN    #bugno:6244 021219
               SELECT SUM(amd06) INTO l_oma59t
                 FROM amd_file
                WHERE amd03=l_ohb30
                  AND amd30='Y'
               IF cl_null(l_oma59t) THEN
                  LET l_oma59t = 0 
               END IF
               LET l_diff3 = l_oma59t - (l_tot22+l_tot42+l_omb.omb18t)
            END IF
            
            IF l_diff1 < 0 OR l_diff2 < 0 OR l_diff3 < 0 THEN
               CALL cl_getmsg('axr-305',g_lang) RETURNING l_str3
               CALL cl_getmsg('axr-306',g_lang) RETURNING l_str4
               LET l_str = l_str3,l_omb.omb31,l_str4,l_diff1,"/",l_diff2,"/",l_diff3
               CALL cl_err(l_str,'!',1) 
               LET g_success = 'N'
               EXIT FOREACH
            END IF
         END FOREACH   #no:4976 021227
      END IF
   END FOREACH

END FUNCTION
 
FUNCTION t300_z()                        # when g_oma.omaconf='Y' (Turn to 'N')
 DEFINE  l_n,l_cnt LIKE type_file.num5   #No.FUN-680123  SMALLINT
 DEFINE l_oga909   LIKE oga_file.oga909  #三角貿易否
 DEFINE l_yy,l_mm  LIKE type_file.num5   #No.FUN-680123 SMALLINT
 DEFINE l_oov04f   LIKE oov_file.oov04f  #FUN-590100
 DEFINE l_oov04    LIKE oov_file.oov04   #FUN-590100
 DEFINE l_cnt2     LIKE type_file.num5   #No.FUN-680123 SMALLINT    #MOD-5A0318
 DEFINE l_aba19    LIKE aba_file.aba19   #No.FUN-670060
 DEFINE l_dbs      STRING                #No.FUN-670060
 DEFINE l_sql      STRING                #No.FUN-670060
 DEFINE l_poz01    LIKE poz_file.poz01   #No.TQC-830007 add
 DEFINE l_poz18    LIKE poz_file.poz18   #No.TQC-830007 add
 DEFINE l_poz19    LIKE poz_file.poz19   #No.TQC-830007 add
 DEFINE l_oaz92    LIKE oaz_file.oaz92   #FUN-C60033 
 
   IF NOT cl_null(g_oma.oma992) THEN
      CALL cl_err('','axr-950',1) 
      LET g_success='N'
      RETURN
   END IF
 
#No.FUN-AB0034 --begin
   IF g_oma.oma70 = '1'  THEN
      CALL cl_err('','aap-829',0) RETURN
   END IF
#No.FUN-AB0034 --end
   IF g_oma.oma64 = "S" THEN
      CALL cl_err("","mfg3557",0)
      LET g_success='N'
      RETURN
   END IF
#           IF g_azw.azw04 <>'2' THEN                   #FUN-A40076 Mark 
              IF g_oma.oma70 ='1'  THEN
                 CALL cl_err("","alm-119",0)
                 LET g_success='N'
                 RETURN
              END IF
#           END IF                                      #FUN-A40076 Mark           
   SELECT COUNT(*) INTO l_cnt2 FROM ooa_file,oob_file
    WHERE ooa01=oob01 AND oob06=g_oma.oma01 AND ooaconf<>'X'
      AND ooa00 != '2'        #No.TQC-5B0080
   IF l_cnt2 > 0 THEN
      CALL cl_err('','axr-014',0)
      RETURN
   END IF
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
   IF g_oma.omaconf='N' THEN RETURN END IF
   #---97/10/20 由axrt400產生的溢收單應不可作確認取消
   IF g_oma.oma00 = '24' THEN
      CALL cl_err('','axr-010',0)    #MOD-5A0318
      LET g_success='N'
      RETURN
   END IF
   #FUN-B50090 add begin-------------------------
   #重新抓取關帳日期
   SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
   #FUN-B50090 add -end--------------------------
   IF g_oma.oma02<=g_ooz.ooz09 THEN
      CALL cl_err('','axr-164',0)
      LET g_success='N'
      RETURN
   END IF
   IF g_ooz.ooz07 = 'Y' AND g_oma.oma23 != g_aza.aza17 THEN
      CALL s_yp(g_oma.oma02) RETURNING l_yy,l_mm
      SELECT COUNT(*) INTO l_cnt FROM oox_file WHERE (oox01*12+oox02) >=(l_yy*12+l_mm)
 AND oox03 =g_oma.oma01
      IF l_cnt >0 THEN
 CALL cl_err(l_mm,'axr-407',0)
 LET g_success='N'
 RETURN
      END IF
   END IF
   #FUN-C60033--add--str--
   SELECT oaz92 INTO l_oaz92 FROM oaz_file 
   IF l_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
   ELSE 
   #FUN-C60033--add--end   
   IF g_ooz.ooz20 = 'Y' THEN    #MOD-840129
      IF (g_aza.aza26='2' AND g_oma.oma00='21' AND NOT cl_null(g_oma.oma10)) OR
( (g_oma.oma00 MATCHES '1*' OR g_oma.oma00='31') AND #No:8519
  (g_oma.oma10 IS NOT NULL AND g_oma.oma10 !=' ')
) THEN #已開發票不可取消確認
 CALL cl_err(g_oma.oma10,'axr-904',0)
 LET g_success='N'
 RETURN
      END IF
   END IF   #MOD-840129
   END IF  #FUN-C60033   
   SELECT COUNT(*) INTO l_cnt FROM oot_file WHERE oot03 = g_oma.oma01
   SELECT oma65 INTO g_oma.oma65 FROM oma_file WHERE oma01=g_oma.oma01
   IF g_aza.aza26 != '2' OR g_oma.oma00[1,1]!='2' OR g_ooy.ooydmy2!='Y' THEN
      IF g_oma.oma65 != '2' AND l_cnt=0 AND  #FUN-570099 若是直接收款，則不需考慮
 g_oma.oma55 != 0 AND g_oma.oma00!='31' THEN   #No:8519
    CALL cl_err(g_oma.oma01,'axr-160',0)
    LET g_success='N'
    RETURN
      END IF
   END IF
 
   #只要是多角貿易皆不可取消確認
   IF NOT cl_null(g_oma.oma99) THEN
       LET l_poz18=''
       LET l_poz19=''
       LET l_poz01=''
               LET li_dbs = ''    
               IF NOT cl_null(g_omb[1].omb44) THEN
                  LET g_plant_new = g_omb[1].omb44
               ELSE  
                  LET g_plant_new = g_plant
               END IF 
               #CALL s_gettrandbs()
               #LET li_dbs = g_dbs_tra
               IF g_oma.oma00 MATCHES '1*' THEN
                  LET g_sql = " SELECT poz01,poz18,poz19",
                              #"   FROM ",li_dbs CLIPPED,"ogb_file,",li_dbs CLIPPED,"oea_file,",li_dbs CLIPPED,"poz_file",
                              "   FROM ",cl_get_target_table(g_plant_new,'ogb_file'),",", #FUN-A50102
                                         cl_get_target_table(g_plant_new,'oea_file'),",", #FUN-A50102
                                         cl_get_target_table(g_plant_new,'poz_file'),      #FUN-A50102
                              "  WHERE oea904 = poz01",
                              "    AND ogb31 = oea01",
                              "    AND ogb01  = '",g_omb[1].omb31,"'",
                              "    AND ogb03  = '",g_omb[1].omb32,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                  PREPARE sel_poz_pre84 FROM g_sql
                  EXECUTE sel_poz_pre84 INTO l_poz01,l_poz18,l_poz19
               ELSE
                  IF g_oma.oma00 MATCHES '2*' THEN
                     LET g_sql = " SELECT poz01,poz18,poz19",
                                 #"   FROM ",li_dbs CLIPPED,"ohb_file,",li_dbs CLIPPED,"oea_file,",li_dbs CLIPPED,"poz_file",
                                 "   FROM ",cl_get_target_table(g_plant_new,'ohb_file'),",", #FUN-A50102
                                            cl_get_target_table(g_plant_new,'oea_file'),",", #FUN-A50102
                                            cl_get_target_table(g_plant_new,'poz_file'),      #FUN-A50102
                                 "  WHERE oea904 = poz01",
                                 "    AND ohb33 = oea01",
                                 "    AND ohb01  = '",g_omb[1].omb31,"'",
                                 "    AND ohb03  = '",g_omb[1].omb32,"'"
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                     PREPARE sel_poz_pre85 FROM g_sql
                     EXECUTE sel_poz_pre85 INTO l_poz01,l_poz18,l_poz19
                  END IF
               END IF
       IF l_poz19 = 'Y'  AND g_plant=l_poz18 THEN  
          #已設立中斷點,單據可以取消確認
       ELSE 
          CALL cl_err3("sel","oga_file",g_oma.oma16,"","axr-373","","",1)  #No.FUN-660116
  RETURN
       END IF  #TQC-830007 add
   END IF
   #已有銷項發票底稿資料(不為作廢)時,則不可取消確認
   IF g_aza.aza26 = '2' AND g_aza.aza47 = 'Y' THEN
      SELECT COUNT(*) INTO l_cnt
FROM isa_file
       WHERE isa04 = g_oma.oma01
 AND isa07 != 'V'
      IF l_cnt > 0 THEN
 CALL cl_err(g_oma.oma01,'axr-016',1)
 RETURN
      END IF
   END IF
 
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM npn_file
      WHERE npn01 = g_oma.oma16
   IF l_cnt > 0 THEN
      CALL cl_err('','aap-425',0)
      RETURN
   END IF 
   #取消確認時，若單據別設為"系統自動拋轉總帳",則可自動拋轉還原
   CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1
   SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
   IF NOT cl_null(g_oma.oma33) THEN
      IF NOT (g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y') THEN
 CALL cl_err(g_oma.oma01,'axr-370',0) RETURN
      END IF
   END If
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN
      LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new
      LET l_dbs=l_dbs.trimRight()                                                                                                    
      #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
      LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
  "  WHERE aba00 = '",g_ooz.ooz02b,"'",
  "    AND aba01 = '",g_oma.oma33,"'"
  CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102 
      PREPARE aba_pre FROM l_sql
      DECLARE aba_cs CURSOR FOR aba_pre
      OPEN aba_cs
      FETCH aba_cs INTO l_aba19
      IF l_aba19 = 'Y' THEN
 CALL cl_err(g_oma.oma33,'axr-071',1)
 RETURN
      END IF
   END IF
 
   IF NOT cl_confirm('axr-109') THEN RETURN END IF
   LET g_success='Y'     #No:8519
   BEGIN WORK
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      LET g_success='N'
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       LET g_success='N'
       CLOSE t300_cl ROLLBACK WORK RETURN
   END IF
   LET g_success = 'Y'
           CALL s_ar_conf('z',g_oma.oma01,'') RETURNING i #No.FUN-9C0014 Add '' 
   CALL s_t300_w1('-',g_oma.oma01)
   CALL t300_omc_check()   #MOD-820044
#FUN-AB0110 --Begin
   IF g_ooy.ooydmy1 = 'Y' AND g_success = 'Y' THEN
      CALL s_t300_del_oct(g_oma.oma00,g_oma.oma01,'0') RETURNING i
      IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
         CALL s_t300_del_oct(g_oma.oma00,g_oma.oma01,'1') RETURNING i
      END IF
    END IF
#FUN-AB0110 --End
   IF i = 0 THEN
      LET g_oma.omaconf = 'N'
      LET g_oma.oma64 = "0"
      DISPLAY BY NAME g_oma.omaconf,g_oma.oma64
      UPDATE oma_file SET oma64 = g_oma.oma64 WHERE oma01 = g_oma.oma01
      IF STATUS THEN
 LET g_success = 'N'
      END IF
   END IF
   SELECT oma65 INTO g_oma.oma65 FROM oma_file WHERE oma01=g_oma.oma01  #No.TQC-7B0165
   IF g_oma.oma65='2' THEN
      CALL s_t300_unconfirm(g_oma.oma01)
   END IF
   IF g_success = 'Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF
 
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
      LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_oma.oma33,"' 'Y'"
      CALL cl_cmdrun_wait(g_str)
      SELECT oma33 INTO g_oma.oma33 FROM oma_file
       WHERE oma01 = g_oma.oma01
      DISPLAY BY NAME g_oma.oma33
   END IF
 
  IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
 
END FUNCTION
 
FUNCTION t300_x()                   # when g_oma.omavoid='N' (Turn to 'Y')
DEFINE p_row,p_col   LIKE type_file.num5      #No.FUN-680123 SMALLINT
DEFINE ls_tmp  STRING
DEFINE l_cnt   LIKE type_file.num5   #MOD-760039
DEFINE l_azf03 LIKE azf_file.azf03   #No.TQC-7C0077   #MOD-840095
        DEFINE l_conf  LIKE type_file.chr1   #CHI-9A0041                                                                                      
        DEFINE l_omb31 LIKE omb_file.omb31   #CHI-9A0041                                                                                      
        DEFINE l_omb38 LIKE omb_file.omb38   #CHI-9A0041      
        DEFINE l_omb44 LIKE omb_file.omb44   #No.FUN-9C0014
        DEFINE li_dbs1 LIKE type_file.chr21  #No.FUN-9C0014
        DEFINE l_plant1 LIKE type_file.chr21  #No.FUN-A50102

   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01       #MOD-660086 add
#No.FUN-AB0034 --begin
   IF g_oma.oma70 = '1'  THEN
      CALL cl_err('','aap-829',0) RETURN
   END IF
#No.FUN-AB0034 --end
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
   IF g_oma.oma70 = '3'  THEN
      CALL cl_err('','axr-088',0) RETURN
      #POS交易產生的單據不可設為無效！
   END IF
###-FUN-B40032- ADD -  END  ---------------------------------------------------
   IF cl_null(g_oma.oma01) THEN CALL cl_err('',-400,0) RETURN END IF   #MOD-660086 add

           LET li_dbs = ''  
           IF NOT cl_null(g_oma.oma66) THEN
              LET g_plant_new = g_oma.oma66
           ELSE 
              LET g_plant_new = g_plant
           END IF
           #CALL s_gettrandbs()
           #LET li_dbs = g_dbs_tra

   IF g_oma.oma64 MATCHES '[Ss1]' THEN    #FUN-550049
     CALL cl_err("","mfg3557",0)
     LET g_success='N'
     RETURN
   END IF
 
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM ome_file WHERE ome16=g_oma.oma01
      AND omevoid<>'Y'   #MOD-7A0135
   IF l_cnt > 0 THEN
      CALL cl_err(g_oma.oma01,'axr-510',0)
      RETURN
   END IF
 
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM ooa_file
     WHERE ooa01 = g_oma.oma01
   IF l_cnt > 0 THEN
      CALL cl_err(g_oma.oma01,'axr-374',0)
      RETURN
   END IF
 
   IF g_oma.omaconf='Y' THEN
      CALL cl_err('conf=Y','axr-154',0)
      LET g_success='N'
      RETURN
   END IF

  #-MOD-AB0216-add-
   IF g_oma.oma00='12' THEN
      LET g_cnt=0
      LET g_sql = " SELECT COUNT(*) ",
                  "   FROM ",cl_get_target_table(g_plant_new,'oga_file'), 
                  "  WHERE oga10 = '",g_oma.oma01,"'",
                  "    AND oga00 != '2'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
      PREPARE sel_oga_pre01 FROM g_sql
      EXECUTE sel_oga_pre01 INTO g_cnt
      IF g_cnt > 0 THEN
        #抓取單身的出貨單
         LET g_sql = "SELECT DISTINCT omb31,omb38 FROM oma_file,omb_file",   
                     " WHERE oma01 = omb01",
                     "   AND oma00 = '12'",
                     "   AND omavoid != 'Y'",
                     "   AND omb01 = '",g_oma.oma01,"'",
                     " ORDER BY omb31"
         PREPARE t300_oga10_p4 FROM g_sql
         DECLARE t300_oga10_c4 CURSOR FOR t300_oga10_p4
         FOREACH t300_oga10_c4 INTO l_omb31,l_omb38   
            IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
            LET m_oma01 = ''  LET m_oma05 = ''
            SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
             WHERE oma01 = omb01
               AND oma00 = '12'
               AND omavoid != 'Y'
               AND oma01 != g_oma.oma01
               AND omb31 = l_omb31
            IF cl_null(m_oma01) THEN
               LET m_oma01=''   
               LET m_oma05=g_oma.oma05           
            ELSE
               SELECT oma05 INTO m_oma05 FROM oma_file WHERE oma01=m_oma01
               IF cl_null(m_oma05) THEN LET m_oma05='' END IF   
            END IF
            IF g_ooz.ooz65 = 'Y' AND l_omb38 = '3' THEN
               LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), 
                           "    SET oha10 = NULL",
                           "  WHERE oha01 = '",l_omb31,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
               PREPARE upd_oha_pre11 FROM g_sql
               EXECUTE upd_oha_pre11
            ELSE
               UPDATE oga_file SET oga10=m_oma01,oga05=m_oma05
                WHERE oga01 = l_omb31
               LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), 
                           "    SET oga10 = '",m_oma01,"',",
                           "        oga05 = '",m_oma05,"' ",
                           "  WHERE oga01 = '",l_omb31,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
               PREPARE upd_oga_pre04 FROM g_sql
               EXECUTE upd_oga_pre04
            END IF   
            IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
               CALL cl_err3("upd","oga_file",l_omb31,"",SQLCA.sqlcode,"","upd oga10:",1) 
               LET g_success = 'N'
            END IF
         END FOREACH
      END IF
   END IF
  #-MOD-AB0216-end-

   IF g_oma.omavoid='Y' THEN                                                                                                        
      LET l_cnt = 0                                       #TQC-AB0056
      IF NOT cl_null(g_oma.oma16) THEN                                                                                              
         CASE
           #WHEN g_oma.oma00='11'                         #CHI-A50040 mark
            WHEN (g_oma.oma00='11' OR g_oma.oma00='13')   #CHI-A50040 
               #LET g_sql = " SELECT oeaconf FROM ",li_dbs CLIPPED,"oea_file",
               LET g_sql = " SELECT oeaconf FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102
                           "  WHERE oea01='",g_oma.oma16,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
               PREPARE sel_oea_pre67 FROM g_sql
               EXECUTE sel_oea_pre67 INTO l_conf
           #WHEN (g_oma.oma00='12' OR g_oma.oma00='13')   #CHI-A50040 mark
            WHEN g_oma.oma00='12'                         #CHI-A50040
               #LET g_sql = " SELECT ogaconf FROM ",li_dbs CLIPPED,"oga_file",
               LET g_sql = " SELECT ogaconf FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                           "  WHERE oga01='",g_oma.oma16,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
               PREPARE sel_oga_pre68 FROM g_sql
               EXECUTE sel_oga_pre68 INTO l_conf
            WHEN g_oma.oma00='21'
               #LET g_sql = " SELECT ohaconf FROM ",li_dbs CLIPPED,"oha_file",
               LET g_sql = " SELECT ohaconf FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                           "  WHERE oha01='",g_oma.oma16,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102               
               PREPARE sel_oha_pre69 FROM g_sql
               EXECUTE sel_oha_pre69 INTO l_conf
            WHEN g_oma.oma00='25'                                                                                                   
               SELECT omavoid INTO l_conf FROM oma_file                                                                             
                WHERE oma01=g_oma.oma16                                                                                             
               IF l_conf='Y' THEN LET l_conf='X' END IF                                                                             
            OTHERWISE EXIT CASE                                                                                                     
         END CASE                                                                                                                   
         IF l_conf='X' THEN                                                                                                         
            CALL cl_err(g_oma.oma01,'axr-057',0)                                                                                    
            LET g_success='N'
            RETURN
         END IF
        #-TQC-AB0056-add-                                                                                             
         SELECT COUNT(*) INTO l_cnt 
           FROM oma_file                                                                             
          WHERE oma01 <> g_oma.oma01 
            AND oma16 = g_oma.oma16
            AND omavoid = 'N'
         IF l_cnt > 0 THEN                                                                                             
            CALL cl_err(g_oma.oma01,'axr-081',0)                                                                                    
            LET g_success='N'                                                                                                       
            RETURN        
         END IF                                                                                                          
        #-TQC-AB0056-end-                                                                                             
      ELSE
         LET l_omb31 = ''               #MOD-AB0216   
         LET l_omb38 = ''               #MOD-AB0216   
         DECLARE omb38_cs CURSOR FOR
          SELECT omb38,omb31,omb44 FROM oma_file,omb_file WHERE oma01=omb01 AND oma01=g_oma.oma01 #No.FUN-9C0014 Add omb44
         FOREACH omb38_cs INTO l_omb38,l_omb31,l_omb44  #No.FUN-9C0014 Add omb44
            IF SQLCA.sqlcode !=0 THEN
               CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)
               EXIT FOREACH
            END IF
            LET li_dbs1 = ''
            LET l_plant1 = ''
            IF NOT cl_null(l_omb44) THEN
               #LET g_plant_new = l_omb44
               LET l_plant1 = l_omb44  #FUN-A50102
            ELSE
               #LET g_plant_new = g_plant
               LET l_plant1 = g_plant  #FUN-A50102
            END IF
            #CALL s_gettrandbs()
            #LET li_dbs1 = g_dbs_tra

            CASE
               WHEN l_omb38='1'
                  #LET g_sql = " SELECT oeaconf FROM ",li_dbs1 CLIPPED,"oea_file",
                  LET g_sql = " SELECT oeaconf FROM ",cl_get_target_table(l_plant1,'oea_file'), #FUN-A50102
                              "  WHERE oea01='",l_omb31,"'"
               WHEN (l_omb38='2' OR l_omb38='4')
                  #LET g_sql = " SELECT ogaconf FROM ",li_dbs1 CLIPPED,"oga_file",
                  LET g_sql = " SELECT ogaconf FROM ",cl_get_target_table(l_plant1,'oga_file'), #FUN-A50102
                              "  WHERE oga01='",l_omb31,"'"
               WHEN (l_omb38='3' OR l_omb38='5')
                  #LET g_sql = " SELECT ohaconf FROM ",li_dbs1 CLIPPED,"oha_file",
                  LET g_sql = " SELECT ohaconf FROM ",cl_get_target_table(l_plant1,'oha_file'), #FUN-A50102
                              "  WHERE oha01='",l_omb31,"'"
               OTHERWISE EXIT CASE
            END CASE
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
               CALL cl_parse_qry_sql(g_sql,l_plant1) RETURNING g_sql #FUN-A50102 
            PREPARE sel_oea_pre70 FROM g_sql
            EXECUTE sel_oea_pre70 INTO l_conf
            IF l_conf='X' THEN                                                                                                      
               CALL cl_err(g_oma.oma01,'axr-057',0)            
               LET g_success='N'                                                                                                    
               EXIT FOREACH                                                                                                         
            END IF                                                                                                                  
           #-TQC-AB0056-add-                                                                                             
            SELECT COUNT(*) INTO l_cnt 
              FROM oma_file,omb_file                                                                             
             WHERE oma01 = omb01 
               AND oma01 <> g_oma.oma01 
               AND omb31 = l_omb31
               AND omavoid = 'N' 
            IF l_cnt > 0 THEN                                                                                             
               CALL cl_err(g_oma.oma01,'axr-081',0)                                                                                    
               LET g_success='N'                                                                                                       
               EXIT FOREACH                                                                                                         
            END IF                                                                                                          
           #-TQC-AB0056-end-                                                                                             
         END FOREACH                                                                                                                
         IF g_success='N' THEN RETURN END IF                                                                                        
      END IF                                                                                                                        
   END IF                                                                                                                           

   IF cl_void(0,0,g_oma.omavoid) THEN   #FUN-810070 add
      IF g_oma.oma64 != '9' THEN      #FUN-810070 add
         IF g_oma.omavoid='Y' THEN RETURN END IF
#        IF g_oma.oma70 = '1' THEN RETURN END IF    #FUN-960140              #FUN-B40032 MARK
         IF (g_oma.oma70 = '1') OR (g_oma.oma70 = '3') THEN RETURN END IF    #FUN-B40032 ADD
         LET p_row = 10 LET p_col = 11
         OPEN WINDOW t300x_w AT p_row,p_col WITH FORM "axr/42f/axrt3002"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
        CALL cl_ui_locale("axrt3002")
 
        INPUT BY NAME g_oma.omavoid2 WITHOUT DEFAULTS
 
        AFTER FIELD omavoid2
          SELECT azf03 INTO l_azf03 FROM azf_file WHERE azf01 = g_oma.omavoid2 AND #No.TQC-7C0077   #MOD-840095
                 azf02 = '2'   #MOD-840095
          IF STATUS THEN CALL cl_err('',STATUS,0) NEXT FIELD omavoid2 END IF
          DISPLAY l_azf03 TO azf03   #MOD-840095
 
       ON ACTION CONTROLP
          CALL cl_init_qry_var()
          LET g_qryparam.form = "q_azf"   #MOD-6A0011   #MOD-840095
          LET g_qryparam.default1 = g_oma.omavoid2
          LET g_qryparam.arg1 ='2'   #MOD-6A0011
          CALL cl_create_qry() RETURNING g_oma.omavoid2
          DISPLAY BY NAME g_oma.omavoid2
          NEXT FIELD omavoid2
 
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
 
       CLOSE WINDOW t300x_w
       IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
      #IF NOT cl_confirm('axr-152') THEN RETURN END IF     #FUN-810070 mark
       BEGIN WORK LET g_success = 'Y'
 
       OPEN t300_cl USING g_oma.oma01
       IF STATUS THEN
          CALL cl_err("OPEN t300_cl:", STATUS, 1)
          LET g_success='N'
          CLOSE t300_cl
          ROLLBACK WORK
          RETURN
       END IF
       FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
 
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
         LET g_success='N'
         CLOSE t300_cl
         ROLLBACK WORK
         RETURN
      END IF
 
         CALL t300_s1()
 
         IF g_success = 'Y' THEN
            LET g_oma.omavoid='Y'
            LET g_oma.oma64 = '9'    #No.FUN-540040
            COMMIT WORK
 
            UPDATE fbe_file SET fbe11 = NULL WHERE fbe11 = g_oma.oma01    #No.MOD-4A0297
 
            IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
            CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
 
            DISPLAY BY NAME g_oma.omavoid,g_oma.oma64   #No.FUN-540040
 
            CALL cl_flow_notify(g_oma.oma01,'V')
         ELSE
            LET g_oma.omavoid = 'N'
            ROLLBACK WORK
         END IF
   #FUN-810070 ---------start---已經作廢的單據若再次確認作廢則作取消作廢處理  
   ELSE
      BEGIN WORK
      LET g_success = 'Y'                                                  
                                                                                
        OPEN t300_cl USING g_oma.oma01                                       
        IF STATUS THEN                                                       
           CALL cl_err("OPEN t300_cl:", STATUS, 1)                           
           LET g_success='N'                                                 
           CLOSE t300_cl                                                     
           ROLLBACK WORK                                                     
           RETURN                                                            
        END IF 
        FETCH t300_cl INTO g_oma.*     #鎖住將被更改或取消的資料
        IF SQLCA.sqlcode THEN 
           CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)
           LET g_success='N'
           CLOSE t300_cl                                                     
           ROLLBACK WORK                                                     
           RETURN                                                            
        END IF
   
        CALL t300_s2()                                                       
        IF g_success = 'Y' THEN                                              
           LET g_oma.omavoid = 'N'                                           
           LET g_oma.omavoid2=''                                             
           LET g_oma.oma64 = '0'                                             
           UPDATE oma_file SET omavoid='N',                                  
                               omavoid2='',                                  
                               oma64 = '0'                                   
               WHERE oma01=g_oma.oma01                                    
           IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
              CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd ogbvoid",1) 
              LET g_success = 'N' RETURN
           END IF 
           COMMIT WORK                                                       
           DISPLAY BY NAME g_oma.omavoid                                     
           DISPLAY BY NAME g_oma.omavoid2                                    
           DISPLAY BY NAME g_oma.oma64                                       
           UPDATE fbe_file SET fbe11 = g_oma.oma01                           
            WHERE fbe11 = g_oma.oma16 
           IF g_oma.oma64 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N'   END IF 
           CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")
           DISPLAY BY NAME g_oma.omavoid,g_oma.oma64
           CALL cl_flow_notify(g_oma.oma01,'V')
        ELSE
           LET g_oma.omavoid = 'Y'
           ROLLBACK WORK 
        END IF 
     END IF 
   END IF          
#FUN-810070 --------------end--------------------------------------- 
END FUNCTION
 
FUNCTION t300_s1()
   DEFINE l_cnt   LIKE type_file.num5     #No.FUN-680123 SMALLINT   #MOD-5A0019
           DEFINE  l_azw05      LIKE azw_file.azw05
           DEFINE  l_azw05_t    LIKE azw_file.azw05
           DEFINE  l_azw        DYNAMIC ARRAY OF RECORD
                     azw05      LIKE azw_file.azw05,
                     azw01      LIKE azw_file.azw01    #FUN-A50102
                                END RECORD
           DEFINE  l_omb44      LIKE omb_file.omb44
           DEFINE  l_i          LIKE type_file.num5
           DEFINE  l_count      LIKE type_file.num5
           DEFINE  l_cnt1       LIKE type_file.num5
  
   #-->刪分錄底稿
   DELETE FROM npp_file WHERE npp01 = g_oma.oma01 AND npp00 = 2
  AND nppsys = 'AR'  AND npp011 = 1   #異動序號
   IF STATUS OR SQLCA.SQLCODE THEN
      CALL cl_err3("del","npp_file",g_oma.oma01,"",STATUS,"","del npp_file",1)  #No.FUN-660116
      LET g_success = 'N' 
      RETURN 
   END IF
   DELETE FROM npq_file WHERE npq01 = g_oma.oma01 AND npq00 = 2
  AND npqsys = 'AR'  AND npq011 = 1   #異動序號
   IF STATUS OR SQLCA.SQLCODE THEN
      CALL cl_err3("del","npq_file",g_oma.oma01,"",STATUS,"","del npq_file",1)  #No.FUN-660116
      LET g_success = 'N' 
      RETURN
   END IF
 #FUN-B40056--add--str--        
   DELETE FROM tic_file WHERE tic04 = g_oma.oma01
   IF STATUS OR SQLCA.SQLCODE THEN
      CALL cl_err3("del","tic_file",g_oma.oma01,"",STATUS,"","del tic:",1)
      LET g_success='N'
   END IF
 #FUN-B40056--add--end--
           DECLARE sel_oga_cs71 CURSOR FOR
            SELECT azw05,omb44 FROM omb_file,azw_file
             WHERE omb01 = g_oma.oma01
               AND azw01 = omb44
             ORDER By azw05
           LET g_cnt = 1
           LET l_cnt = 0
           LET l_azw05_t = ''
           FOREACH sel_oga_cs71 INTO l_azw05,l_omb44
              IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
              IF l_azw05_t = l_azw05 THEN
                 CONTINUE FOREACH
              END IF
              LET l_azw[g_cnt].azw05 = l_azw05 
              LET l_azw[g_cnt].azw01 = l_omb44   #FUN-A50102
              LET l_azw05_t = l_azw05
              LET g_cnt = g_cnt + 1

              #LET g_sql = " SELECT COUNT(*) FROM ",l_azw05 CLIPPED,".oga_file",
              LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(l_omb44,'oga_file'), #FUN-A50102
                          "  WHERE oga10 = '",g_oma.oma01,"'"
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
              CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102              
              PREPARE sel_oga_pre76 FROM g_sql
              EXECUTE sel_oga_pre76 INTO l_cnt1
              LET l_cnt = l_cnt + l_cnt1
           END FOREACH
          #LET l_cnt = l_cnt - 1       #TQC-B10201 mark
           LET l_count = g_cnt - 1
   IF l_cnt > 0 THEN
      IF g_oma.oma00='12' THEN
#抓取單身的出貨單
 LET g_sql = "SELECT DISTINCT omb31,omb44 FROM oma_file,omb_file", #No.FUN-9C0014 Add omb44
     " WHERE oma01 = omb01",
     "   AND oma00 = '12'",
     "   AND omavoid != 'Y'",
     "   AND omb01 = '",g_oma.oma01,"'",
     " ORDER BY omb31"
 PREPARE t300_oga10_p2 FROM g_sql
 DECLARE t300_oga10_c2 CURSOR FOR t300_oga10_p2
 FOREACH t300_oga10_c2 INTO m_omb31,l_omb44     #No.FUN-9C0014
    IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
    LET m_oma01 = ''  LET m_oma05 = ''
    SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file
     WHERE oma01 = omb01
       AND oma00 = '12'
       AND omavoid != 'Y'
       AND oma01 != g_oma.oma01
       AND omb31 = m_omb31
    IF cl_null(m_oma01) THEN
                       LET m_oma01=''   #MOD-8C0141 mod
                       LET m_oma05=g_oma.oma05            #MOD-9C0164
    ELSE
       SELECT oma05 INTO m_oma05 FROM oma_file WHERE oma01=m_oma01
                       IF cl_null(m_oma05) THEN LET m_oma05='' END IF   #MOD-8C0141 mod
    END IF
                    LET g_plant_new = l_omb44
                    #CALL s_gettrandbs()
                    #LET li_dbs = g_dbs_tra
                    #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oga_file",
                    LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                                "    SET oga10='",m_oma01,"',",
                                "        oga05='",m_oma05,"'",
                                "  WHERE oga01='",m_omb31,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                    PREPARE upd_oga_pre71 FROM g_sql
                    EXECUTE upd_oga_pre71
    IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
       CALL cl_err3("upd","oga_file",m_omb31,"",SQLCA.sqlcode,"","upd oga10:",1)  #No.FUN-660116
       LET g_success = 'N'
    END IF
 END FOREACH
      END IF
#-CHI-A50040-mark-
#     IF g_oma.oma00 = '13' AND g_oma.oma16 IS NOT NULL AND
#g_oma.oma162=0 THEN
#                FOR l_i = 1 TO l_count
#                   LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
#                   LET g_sql = " UPDATE ",li_dbs CLIPPED,"oga_file",
#                               "    SET oga10=NULL ",
#                               "  WHERE oga10='",g_oma.oma01,"'"
#                   PREPARE upd_oga_pre72 FROM g_sql
#                   EXECUTE upd_oga_pre72
#                   IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
#                      CALL cl_err3("upd","oga_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oga01:",1)
#                      LET g_success = 'N'
#                   END IF
#                END FOR
#     END IF
#-CHI-A50040-mark-
   END IF   #MOD-5A0019
   IF g_oma.oma00='21' THEN
      LET l_cnt = 0
              FOR l_i = 1 TO l_count
                  #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
                  LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
                  #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file",
                  LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                              "  WHERE oha10='",g_oma.oma01,"'"
                 CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
                 PREPARE sel_oha_pre73 FROM g_sql
                 EXECUTE sel_oha_pre73 INTO l_cnt1
                 LET l_cnt = l_cnt + l_cnt1
              END FOR
      IF l_cnt > 0 THEN
                 FOR l_i = 1 TO l_count
                    #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
                    LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
                    #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oha_file",
                    LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                                "    SET oha10=NULL ",
                                "  WHERE oha10='",g_oma.oma01,"'"
                    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
                    PREPARE upd_oha_pre74 FROM g_sql
                    EXECUTE upd_oha_pre74
                    IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                       CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)
                       LET g_success = 'N'
                    END IF
                 END FOR
      END IF   #MOD-650003
   END IF
 
         LET g_cnt = 0 
         FOR l_i = 1 TO l_count
            #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
            LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
            #LET g_sql = " SELECT COUNT(*) FROM ",li_dbs CLIPPED,"oha_file",
            LET g_sql = " SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                        "  WHERE oha10='",g_oma.oma01,"'",
                        "    AND ohaconf = 'Y'",
                        "    AND ohapost = 'Y'",
                        "    AND oha09 = '3'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
            PREPARE sel_oha_pre75 FROM g_sql
            EXECUTE sel_oha_pre75 INTO l_cnt1
            LET g_cnt = g_cnt + l_cnt1
         END FOR
         IF g_cnt > 0 THEN 
            FOR l_i = 1 TO l_count
                #LET li_dbs = l_azw[l_i].azw05 CLIPPED,"."
                LET g_plant_new = l_azw[l_i].azw01   #FUN-A50102
                #LET g_sql = " UPDATE ",li_dbs CLIPPED,"oha_file",
                LET g_sql = " UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                            "    SET oha10 = '' ",
                            "  WHERE ohaconf = 'Y'",
                            "    AND ohapost = 'Y'",
                            "    AND oha09 = '3'",
                            "    AND oha10='",g_oma.oma01,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
                PREPARE upd_oha_pre76 FROM g_sql
                EXECUTE upd_oha_pre76
                IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                   CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1)
                   LET g_success = 'N'
                END IF
             END FOR
         END IF
   UPDATE oma_file SET omavoid='Y',
       omavoid2=g_oma.omavoid2,
       oma64 = '9'
  WHERE oma01=g_oma.oma01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd ogbvoid",1)  #No.FUN-660116
      LET g_success = 'N' RETURN
   END IF
END FUNCTION
 
#FUN-810070 --------------start-----------------
FUNCTION t300_s2()
   DEFINE l_cnt   LIKE type_file.num5     #No.FUN-680123 SMALLINT
   DEFINE l_oga10 LIKE oga_file.oga10 
   DEFINE l_omb38 LIKE omb_file.omb38     #MOD-B50234
   
   SELECT COUNT(*) INTO l_cnt FROM oga_file WHERE oga01 = g_oma.oma16 
   IF l_cnt > 0 THEN
      IF g_oma.oma00='12' THEN
         LET g_sql = "SELECT DISTINCT omb38,omb31 ",   #MOD-B50234 add omb38
                     "  FROM oma_file,omb_file",
                     " WHERE oma01 = omb01",
                     "   AND oma00 = '12'",
                     "   AND omavoid != 'N'",  
                     "   AND omb01 = '",g_oma.oma01,"'",      
                     " ORDER BY omb31" 
         PREPARE t300_oga10_p3 FROM g_sql                                       
         DECLARE t300_oga10_c3 CURSOR FOR t300_oga10_p3                         
         FOREACH t300_oga10_c3 INTO l_omb38,m_omb31  #出貨單/銷退單 #MOD-B50234 add omb38
            IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
            LET m_oma01 = ''  LET m_oma05 = ''                                  
            SELECT MAX(oma01) INTO m_oma01 FROM oma_file,omb_file               
             WHERE oma01 = omb01                                                
               AND oma00 = '12'
               AND omavoid != 'Y'                                               
               AND oma01 != g_oma.oma01                                         
               AND omb31 = m_omb31
            IF l_omb38 = '2' THEN   #MOD-B50234
              #找出對應的出貨單單頭oga10帳號編號，如果為空白者才需要回寫目前oma01
              #避免出貨單頭帳款編號為空白造成重複產生帳款  
              SELECT oga10 INTO l_oga10                                           
                 FROM oga_file                                                     
                WHERE oga01 = m_omb31                                              
               IF cl_null(l_oga10) THEN                                            
                   UPDATE oga_file SET oga10=g_oma.oma01,oga05=g_oma.oma05         
                    WHERE oga01=m_omb31                                            
                  IF STATUS OR SQLCA.SQLERRD[3]=0 THEN 
                     CALL cl_err3("upd","oga_file",m_omb31,"",SQLCA.sqlcode,"","upd oga10:",1)
                     LET g_success = 'N'                                          
                  END IF                                                           
               END IF                                                              
           #-MOD-B50234-add-
            ELSE
               SELECT oha10 INTO l_oga10 
                 FROM oha_file 
                WHERE oha01 = m_omb31
               IF cl_null(l_oga10) THEN 
                   UPDATE oha_file SET oha10=g_oma.oma01
                    WHERE oha01=m_omb31
                  IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
                      CALL cl_err3("upd","oha_file",m_omb31,"",SQLCA.sqlcode,"","upd oha10:",1) 
                      LET g_success = 'N'
                  END IF
               END IF
            END IF
           #-MOD-B50234-end-
         END FOREACH                                                            
      END IF
    END IF
    IF g_oma.oma00='21' THEN                                                     
      LET l_cnt = 0                                                             
      SELECT COUNT(*) INTO l_cnt FROM oha_file                                  
        WHERE oha01=g_oma.oma16                                                 
      IF l_cnt > 0 THEN                                                         
         LET g_sql = "SELECT DISTINCT omb31 FROM oma_file,omb_file",            
                     " WHERE oma01 = omb01",                                    
                     "   AND oma00 = '21'",                                     
                     "   AND omavoid != 'N'",                                   
                     "   AND omb01 = '",g_oma.oma01,"'",                        
                     " ORDER BY omb31"                                          
         PREPARE t300_oga10_p5 FROM g_sql                                       
         DECLARE t300_oga10_c5 CURSOR FOR t300_oga10_p5                         
         LET m_omb31 = ''                                                       
         FOREACH t300_oga10_c5 INTO m_omb31  #出货单                            
             IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
             UPDATE oha_file SET oha10=g_oma.oma01 WHERE oha01=m_omb31          
             IF STATUS OR SQLCA.SQLERRD[3]=0 THEN           
                CALL cl_err3("upd","oha_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oha10:",1) 
                LET g_success = 'N'                                             
             END IF                                                             
         END FOREACH                                                            
      END IF                                                                    
   END IF                                                                       
END FUNCTION   
#FUN-810070------------------end-----------------------------

FUNCTION t300_j(p_row,p_col,p_key)
 DEFINE ls_tmp STRING
       DEFINE      p_row,p_col  LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
       p_key            LIKE omb_file.omb03,
    l_begin_key      LIKE omb_file.omb03,
       l_omb DYNAMIC ARRAY OF RECORD
    omb03     LIKE omb_file.omb03,
    omb38     LIKE omb_file.omb38,   #TQC-740130
    omb31     LIKE omb_file.omb31,
    omb32     LIKE omb_file.omb32,
    omb39     LIKE omb_file.omb39,   #TQC-740130
    omb04     LIKE omb_file.omb04,
    omb06     LIKE omb_file.omb06,
    omb40     LIKE omb_file.omb40,  #No.FUN-660073
    omb05     LIKE omb_file.omb05,
    omb12     LIKE omb_file.omb12,
    omb41     LIKE omb_file.omb41,
    omb42     LIKE omb_file.omb42,
    omb33     LIKE omb_file.omb33,
    omb331    LIKE omb_file.omb331, #FUN-670047
    omb13     LIKE omb_file.omb13,
    omb14     LIKE omb_file.omb14,
    omb14t    LIKE omb_file.omb14t,
    omb15     LIKE omb_file.omb15,
    omb16     LIKE omb_file.omb16,
    omb16t    LIKE omb_file.omb16t,
    omb17     LIKE omb_file.omb17,
    omb18     LIKE omb_file.omb18,
    omb18t    LIKE omb_file.omb18t,
    omb34     LIKE omb_file.omb34,
    omb35     LIKE omb_file.omb35
  END RECORD,
    l_maxac            LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
    l_n,l_ac,l_sl      LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
    l_wc               STRING,                   #MOD-870237 mod
    l_sql              STRING,                   #MOD-870237 mod
    l_priv             LIKE cre_file.cre08,      #No.FUN-680123 VARCHAR(10),
l_time         LIKE type_file.chr8,      #No.FUN-680123 VARCHAR(8),
l_allow_insert LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #可新增否
l_allow_delete LIKE type_file.num5       #No.FUN-680123 SMALLINT               #可刪除否
 
     LET p_row = 2 LET p_col = 2
     OPEN WINDOW q_omb_w AT p_row,p_col
  WITH FORM "axr/42f/axrt300d1"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
     CALL cl_ui_locale("axrt300d1")
 
     CALL cl_opmsg('q')
     CONSTRUCT l_wc ON omb03,omb38,omb31,omb32,omb39,omb04,omb06,omb40,omb05   #No.FUN-660073          #No.FUN-670026 --add omb38,omb39
  FROM s_omb[1].omb03,s_omb[1].omb38,s_omb[1].omb31,s_omb[1].omb32,   #No.FUN-670026 --add omb38,omb39
       s_omb[1].omb39,s_omb[1].omb04,s_omb[1].omb06,s_omb[1].omb40,s_omb[1].omb05    #No.FUN-670026 --add omb38,omb39  #No.FUN-660073
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
 
 
 ON ACTION qbe_select
   CALL cl_qbe_select()
 ON ACTION qbe_save
   CALL cl_qbe_save()
     END CONSTRUCT
     IF INT_FLAG THEN LET INT_FLAG=0 END IF
 
     CALL cl_opmsg('w')
     LET l_sql =
"SELECT omb03,omb38,omb31,omb32,omb39,omb04,omb06,omb40,omb05,omb12,omb41,omb42,omb33,omb331,", #FUN-670047    #No.FUN-670026--add omb38,omb39  #No.FUN-660073 #FUN-810045
"       omb13,omb14,omb14t,omb15,omb16,omb16t,omb17,omb18,omb18t,",
"       omb34,omb35 ",
" FROM omb_file ",
" WHERE omb01 ='",g_oma.oma01,"'"   #單頭
     IF NOT cl_null(p_key) THEN
LET l_sql = l_sql CLIPPED ," AND omb03 = ",p_key
     END IF
     LET l_sql = l_sql CLIPPED, " AND ",l_wc CLIPPED,               #單身
 " ORDER BY 2"
 
     PREPARE t300_j_prepare FROM l_sql
     DECLARE t300omb_curs CURSOR FOR t300_j_prepare
     LET l_ac = 1
     FOREACH t300omb_curs INTO l_omb[l_ac].*
IF SQLCA.sqlcode != 0 THEN
   CALL cl_err('foreach:',SQLCA.sqlcode,1) EXIT FOREACH
END IF
      LET l_ac = l_ac + 1
     END FOREACH
     LET l_maxac = l_ac - 1
 
     DISPLAY ARRAY l_omb TO s_omb.* ATTRIBUTE(COUNT=l_maxac,UNBUFFERED)
ON IDLE g_idle_seconds
   CALL cl_on_idle()
   CONTINUE DISPLAY
    
ON ACTION about         
   CALL cl_about()      
    
ON ACTION help          
   CALL cl_show_help()  
    
ON ACTION controlg      
   CALL cl_cmdask()     
     END DISPLAY
 
     LET l_allow_insert = cl_detail_input_auth("insert")
     LET l_allow_delete = cl_detail_input_auth("delete")
 
     INPUT ARRAY l_omb WITHOUT DEFAULTS FROM s_omb.*
   ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
  BEFORE INPUT
      CALL fgl_set_arr_curr(l_ac)
 
  BEFORE ROW
     LET l_ac = ARR_CURR()
     IF l_omb[l_ac].omb03 IS NOT NULL AND l_ac <= l_maxac THEN
DISPLAY l_omb[l_ac].omb03 TO omb03
     END IF
     CALL cl_show_fld_cont()     #FUN-550037(smin)
 
  AFTER ROW
     DISPLAY l_omb[l_ac].omb03 TO omb03
 
  ON ACTION CONTROLN
     CLEAR FORM
     CALL l_omb.clear()
     EXIT INPUT
 
  ON ACTION other_data
     CALL t300_d()
 
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
 
     IF INT_FLAG THEN LET INT_FLAG = 0 END IF
     CLOSE WINDOW q_omb_w
END FUNCTION
 
FUNCTION t300_d()
  DEFINE i      LIKE type_file.num5      #No.FUN-680123 SMALLINT
  DEFINE oob09_t      LIKE oob_file.oob09
  DEFINE oob10_t      LIKE oob_file.oob10
  DEFINE x      DYNAMIC ARRAY OF RECORD
       oob15      LIKE oob_file.oob15,
       ooa01      LIKE ooa_file.ooa01,
       oob02      LIKE oob_file.oob02,
       ooa02      LIKE ooa_file.ooa02,
       oob08      LIKE oob_file.oob08,
       oob09      LIKE oob_file.oob09,
       oob10      LIKE oob_file.oob10
    END RECORD
  DEFINE ls_tmp STRING
  DEFINE p_row,p_col      LIKE type_file.num5       #No.FUN-680123 SMALLINT
 
  LET p_row = 6 LET p_col = 9
  OPEN WINDOW t300_d_w AT p_row,p_col WITH FORM "axr/42f/axrt300d"
   ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
  CALL cl_ui_locale("axrt300d")
 
  CALL x.clear()
 IF g_oma.oma00 MATCHES "1*" THEN          #MOD-940419  add     
  DECLARE t300_d_c CURSOR FOR
  SELECT oob15,ooa01,oob02,ooa02,oob08,oob09,oob10
    FROM oob_file,ooa_file
     WHERE oob06=g_oma.oma01 AND oob01=ooa01 AND ooaconf='Y'
           AND oob03='2' AND oob04='1'  
  ELSE
     IF g_oma.oma00 MATCHES "2*" THEN 
        DECLARE t300_d_c_1 CURSOR FOR
         SELECT oob15,ooa01,oob02,ooa02,oob08,oob09,oob10
           FROM oob_file,ooa_file
          WHERE oob06=g_oma.oma01 AND oob01=ooa01 AND ooaconf='Y'  
            AND oob03='1' AND oob04='3'            
      END IF   
  END IF 
     
LET i=1 LET oob09_t=0 LET oob10_t=0
IF g_oma.oma00 MATCHES "1*" THEN          #MOD-940419  add       
  FOREACH t300_d_c INTO x[i].*
    IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
    IF cl_null(x[i].oob09) THEN LET x[i].oob09 = 0 END IF
    IF cl_null(x[i].oob10) THEN LET x[i].oob10 = 0 END IF
    LET oob09_t=oob09_t+x[i].oob09
    LET oob10_t=oob10_t+x[i].oob10
    LET i=i+1
  END FOREACH
ELSE
IF g_oma.oma00 MATCHES "2*" THEN 
    FOREACH t300_d_c_1 INTO x[i].*
      IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
      IF cl_null(x[i].oob09) THEN LET x[i].oob09 = 0 END IF
      IF cl_null(x[i].oob10) THEN LET x[i].oob10 = 0 END IF
      LET oob09_t=oob09_t+x[i].oob09
      LET oob10_t=oob10_t+x[i].oob10
      LET i=i+1
    END FOREACH
  END IF 
END IF 
  
  DISPLAY BY NAME oob09_t,oob10_t
  CALL cl_set_act_visible("accept,cancel", TRUE)
  DISPLAY ARRAY x TO s_oob.* ATTRIBUTE(COUNT=i)
     ON IDLE g_idle_seconds
CALL cl_on_idle()
CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
 CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
 CALL cl_cmdask()     #MOD-4C0121
 
 
  END DISPLAY
  CLOSE WINDOW t300_d_w
END FUNCTION
 
#多角貿易在確認後允許設修改會計科目
FUNCTION t300_w()
DEFINE l_aag02    LIKE   aag_file.aag02    #TQC-790124
DEFINE l_aag02a   LIKE   aag_file.aag02    #TQC-790124
DEFINE l_aag05    LIKE   aag_file.aag05    #FUN-8C0089 add
DEFINE l_aag05a   LIKE   aag_file.aag05    #FUN-8C0089 add
 
   IF g_oma.oma00 <> '12' THEN
      CALL cl_err('','tri-019',1)
      LET g_success='N'
      RETURN
   END IF
   #No.8161 取消axrt301 直接寫在 axrt300，以免維護困難
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
   IF g_oma.omavoid = 'Y' THEN
      CALL cl_err('','axr-103',0)
      LET g_success='N'
      RETURN
   END IF
   IF NOT cl_null(g_oma.oma33) THEN
      CALL cl_err('','agl-892',0)
      LET g_success='N'
      RETURN
   END IF
   IF cl_null(g_oma.oma99) THEN
      CALL cl_err('','tri-019',1)
      LET g_success='N'
      RETURN
   END IF
   #修改會計科目並產生分錄底稿, 只針對三角貿易才可修改
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_oma_o.* = g_oma.*
   BEGIN WORK
 
   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      LET g_success='N'
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      LET g_success='N'
      CLOSE t300_cl ROLLBACK WORK RETURN
   END IF
 
   CALL t300_show()
 
   INPUT BY NAME
       g_oma.oma18,g_oma.oma181,g_oma.omamodu,g_oma.omadate #FUN-670047
          WITHOUT DEFAULTS HELP 1
 
      AFTER FIELD oma18
         IF g_oma.oma00 MATCHES "1*" AND cl_null(g_oma.oma18) THEN
            NEXT FIELD oma18
         END IF
         LET l_aag05=''   #FUN-8C0089 add
         IF NOT cl_null(g_oma.oma18) THEN
            SELECT aag02,aag05 INTO l_aag02,l_aag05  #FUN-8C0089 add aag05,l_aag05 #TQC-790124   
              FROM aag_file
             WHERE aag01=g_oma.oma18
         AND aag00=g_bookno1  #No.FUN-730073
               AND aag07 IN ('2','3')   #MOD-920035 add
               AND aag03 IN ('2')       #FUN-B10053 add
    IF STATUS THEN
        #No.FUN-B10053  --Begin
        #CALL cl_err3("sel","aag_file",g_oma.oma18,"",STATUS,"","select aag",1)  #No.FUN-660116
        CALL cl_err3("sel","aag_file",g_oma.oma18,"",STATUS,"","select aag",0)
        CALL cl_init_qry_var()
        LET g_qryparam.form = "q_aag"
        LET g_qryparam.construct = 'N'
        LET g_qryparam.default1 = g_oma.oma18
        LET g_qryparam.arg1=g_bookno1
        LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2') AND aagacti = 'Y' AND aag01 LIKE '",g_oma.oma18 CLIPPED,"%'"             
        CALL cl_create_qry() RETURNING g_oma.oma18
        DISPLAY BY NAME g_oma.oma18
        #No.FUN-B10053  --End
       NEXT FIELD oma18
    END IF
 
           #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
            LET g_errno = ' '   
            IF l_aag05 = 'Y' THEN
              #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
               IF g_aaz.aaz90 ='Y' THEN
                  IF NOT cl_null(g_oma.oma930) THEN 
                     CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma930,g_bookno1)  
                                   RETURNING g_errno
                  END IF
               ELSE
                  IF NOT cl_null(g_oma.oma15) THEN 
                     CALL s_chkdept(g_aaz.aaz72,g_oma.oma18,g_oma.oma15,g_bookno1)  
                                   RETURNING g_errno
                  END IF 
               END IF
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD oma18
               END IF
            END IF
 
    DISPLAY l_aag02 TO aag02    #TQC-790124
         END IF
 
      AFTER FIELD oma181
 IF g_oma.oma00 MATCHES "1*" AND cl_null(g_oma.oma181) THEN
    NEXT FIELD oma181
 END IF
         LET l_aag05a=''   #FUN-8C0089 add
 IF NOT cl_null(g_oma.oma181) THEN
            SELECT aag02,aag05 INTO l_aag02a,l_aag05a  #FUN-8C0089 add aag05,l_aag05a #TQC-790124
              FROM aag_file
             WHERE aag01=g_oma.oma181
       AND aag00=g_bookno2   #No.FUN-730073 
               AND aag07 IN ('2','3')   #MOD-920035 add
    IF STATUS THEN
       #No.FUN-B10053  --Begin
       #CALL cl_err3("sel","aag_file",g_oma.oma181,"",STATUS,"","select aag",1)  #No.FUN-660116
       CALL cl_err3("sel","aag_file",g_oma.oma181,"",STATUS,"","select aag",0)
       CALL cl_init_qry_var()
       LET g_qryparam.form = "q_aag"
       LET g_qryparam.construct = 'N'
       LET g_qryparam.default1 = g_oma.oma181
       LET g_qryparam.arg1 = g_bookno2
       LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2') AND aagacti = 'Y' AND aag01 LIKE '",g_oma.oma181 CLIPPED,"%'"
       CALL cl_create_qry() RETURNING g_oma.oma181
       DISPLAY BY NAME g_oma.oma181
       #No.FUN-B10053  --End
       NEXT FIELD oma181
    END IF
           #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
            LET g_errno = ' '   
            IF l_aag05a = 'Y' THEN
              #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
               IF g_aaz.aaz90 ='Y' THEN
                  IF NOT cl_null(g_oma.oma930) THEN 
                     CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma930,g_bookno2)  
                                   RETURNING g_errno
                  END IF
               ELSE
                  IF NOT cl_null(g_oma.oma15) THEN 
                     CALL s_chkdept(g_aaz.aaz72,g_oma.oma181,g_oma.oma15,g_bookno2)  
                                   RETURNING g_errno
                  END IF 
               END IF
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err('',g_errno,0)
                  NEXT FIELD oma181
               END IF
            END IF
    DISPLAY l_aag02a TO aag02_2    #TQC-790124
         END IF
 
      AFTER INPUT
         IF INT_FLAG THEN EXIT INPUT END IF
      
      ON ACTION  CONTROLP
         CASE
            WHEN INFIELD(oma18)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_aag"
              LET g_qryparam.default1 = g_oma.oma18
              LET g_qryparam.where = " aag07 IN ('2','3') AND ",
             " aag03 IN ('2') "
              LET g_qryparam.arg1=g_bookno1                 #No.FUN-730073
              CALL cl_create_qry() RETURNING g_oma.oma18
              DISPLAY BY NAME g_oma.oma18
              NEXT FIELD oma18
 
            WHEN INFIELD(oma181)
              CALL cl_init_qry_var()
              LET g_qryparam.form = "q_aag"
              LET g_qryparam.default1 = g_oma.oma181
              LET g_qryparam.where = " aag07 IN ('2','3') AND ",
             " aag03 IN ('2') "
              LET g_qryparam.arg1=g_bookno2                      #No.FUN-730073
              CALL cl_create_qry() RETURNING g_oma.oma181
              DISPLAY BY NAME g_oma.oma181
              NEXT FIELD oma181
         END CASE
 
      ON ACTION  CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
 CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
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
       LET g_oma.*=g_oma_t.*
       CALL t300_show()
       CALL cl_err('','9001',0)
       ROLLBACK WORK RETURN
   END IF
   UPDATE oma_file
      SET oma18  = g_oma.oma18,
          oma181 = g_oma.oma181, #FUN-670047
          omauser= g_oma.omauser,
          omadate= g_oma.omadate
         WHERE oma01 = g_oma.oma01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("upd","oma_file",g_oma_o.oma01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
      ROLLBACK WORK RETURN
   END IF
   CLOSE t300_cl
   COMMIT WORK
END FUNCTION
 
#CHI-A80056 add --start--
FUNCTION t300_modi_mul_tra_inv()
  DEFINE l_cnt       LIKE type_file.num5

   IF g_oma.oma00 <> '12' THEN
      CALL cl_err('','tri-019',1)
      LET g_success='N'
      RETURN
   END IF
   #取消axrt301 直接寫在 axrt300，以免維護困難
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
   IF g_oma.omavoid = 'Y' THEN
      CALL cl_err('','axr-103',0)
      LET g_success='N'
      RETURN
   END IF
   IF NOT cl_null(g_oma.oma33) THEN
      CALL cl_err('','agl-892',0)
      LET g_success='N'
      RETURN
   END IF
   IF cl_null(g_oma.oma99) THEN
      CALL cl_err('','tri-019',1)
      LET g_success='N'
      RETURN
   END IF
   #只針對三角貿易才可修改
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_oma_o.* = g_oma.*
   BEGIN WORK

   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl:", STATUS, 1)
      LET g_success='N'
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t300_cl INTO g_oma.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)     # 資料被他人LOCK
      LET g_success='N'
      CLOSE t300_cl ROLLBACK WORK RETURN
   END IF

   CALL t300_show()

   INPUT BY NAME
       g_oma.oma67,g_oma.omamodu,g_oma.omadate 
          WITHOUT DEFAULTS HELP 1

      AFTER INPUT
         IF INT_FLAG THEN EXIT INPUT END IF
      
      ON ACTION  CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) 
  
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
       LET g_oma.*=g_oma_t.*
       CALL t300_show()
       CALL cl_err('','9001',0)
       ROLLBACK WORK RETURN
   END IF
   UPDATE oma_file
      SET oma67  = g_oma.oma67,
          omauser= g_oma.omauser,
          omadate= g_oma.omadate
         WHERE oma01 = g_oma.oma01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("upd","oma_file",g_oma_o.oma01,"",SQLCA.sqlcode,"","",1) 
      ROLLBACK WORK RETURN
   END IF
   CLOSE t300_cl
   COMMIT WORK
END FUNCTION
#CHI-A80056 add --end--

FUNCTION t300_chk_ohb(p_cmd)
  DEFINE p_cmd    LIKE type_file.chr1      #No.FUN-680123  VARCHAR(01)
  DEFINE l_oha09  LIKE oha_file.oha09      #MOD-940155 add
 
  LET g_errno=' '  LET g_flag='Y'
 
 #應收待抵確認
  SELECT SUM(abs(omb12)),SUM(abs(omb14t)),SUM(abs(omb14)) INTO g_omb12,g_omb14t,g_omb14     #No.TQC-740350
    FROM oma_file,omb_file
   WHERE oma01=omb01  AND omavoid='N' AND omaconf='Y'                 #MOD-8C0192
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND omb44=g_omb[l_ac].omb44   #FUN-9C0013
 #應收待抵未確認(不含本項次異動):g_omb12_n,g_omb14t_n,g_omb14_t
  SELECT SUM(abs(omb12)),SUM(abs(omb14t)),SUM(abs(omb14))      #No.TQC-740350
    INTO g_omb12_n,g_omb14t_n,g_omb14_n
    FROM oma_file,omb_file
   WHERE oma01=omb01  AND omavoid='N' AND omaconf!='Y'                 #MOD-8C0192
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND oma01 !=g_oma.oma01
     AND omb44=g_omb[l_ac].omb44   #FUN-9C0013

 #本次異動
  SELECT SUM(abs(omb12)),SUM(abs(omb14t)),SUM(abs(omb14))      #No.TQC-740350
    INTO g_omb12_b,g_omb14t_b,g_omb14_b
    FROM oma_file,omb_file
   WHERE oma01=omb01  AND omavoid='N' AND omaconf!='Y'                 #MOD-8C0192
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND oma01=g_oma.oma01 AND omb03 !=g_omb[l_ac].omb03
     AND omb44 = g_omb[l_ac].omb44   #FUN-9C0013 

  IF cl_null(g_omb12)    THEN LET g_omb12   =0 END IF
  IF cl_null(g_omb12_n)  THEN LET g_omb12_n =0 END IF
  IF cl_null(g_omb12_b)  THEN LET g_omb12_b =0 END IF
  IF cl_null(g_omb14)    THEN LET g_omb14   =0 END IF
  IF cl_null(g_omb14_n)  THEN LET g_omb14_n =0 END IF
  IF cl_null(g_omb14_b)  THEN LET g_omb14_b =0 END IF
  IF cl_null(g_omb14t)   THEN LET g_omb14t  =0 END IF
  IF cl_null(g_omb14t_b) THEN LET g_omb14t_b=0 END IF
  IF cl_null(g_omb14t_n) THEN LET g_omb14t_n=0 END IF
 
  #LET l_sql ="SELECT oha09 FROM ",li_dbs CLIPPED,"oha_file",
  LET l_sql ="SELECT oha09 FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
             " WHERE oha01='",g_omb[l_ac].omb31,"' "
  CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
  CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102           
  PREPARE sel_oha09_pre3 FROM l_sql
  EXECUTE sel_oha09_pre3 INTO l_oha09
  IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
  IF p_cmd='a' THEN
     IF l_oha09='5' THEN        #MOD-940155
        LET g_omb[l_ac].omb12 = 0
     ELSE
        LET g_omb[l_ac].omb12 = g_ohb.ohb917 - (g_omb12+g_omb12_n+g_omb12_b)   #FUN-560070
        IF cl_null(g_omb[l_ac].omb12) OR g_omb[l_ac].omb12 <0 THEN
           LET g_omb[l_ac].omb12 = 0
        END IF
     END IF
     DISPLAY g_omb[l_ac].omb12  TO omb12
  END IF
 #show原銷退量/已確認的應收待抵量/其他未確認應收待抵量
  CALL cl_getmsg('axr-285',g_lang) RETURNING l_msg1
  CALL cl_getmsg('axr-282',g_lang) RETURNING l_msg2
  CALL cl_getmsg('axr-283',g_lang) RETURNING l_msg3
  LET g_msg1=g_ohb.ohb31,'+',g_ohb.ohb32 USING '###',':',
     l_msg1 CLIPPED,g_ohb.ohb917 USING '#####&.##',' ',   #FUN-560070
     l_msg2 CLIPPED,g_omb12 USING '#####&.##',' ',
     l_msg3 CLIPPED,g_omb12_n USING '#####&.##'
  DISPLAY g_msg1 CLIPPED AT 2,1
  LET g_msg1=' '
 #銷退方式: 1-4: 數量不可為0  5:數量一定為0
 #IF g_oma.oma34 !='5' AND g_omb[l_ac].omb12  =0 THEN   #MOD-940155 mark
  IF l_oha09 !='5' AND g_omb[l_ac].omb12  =0 THEN       #MOD-940155
     LET g_flag='N'
     LET g_msg1=g_omb[l_ac].omb31
     LET g_errno='axm-607' RETURN
  END IF
  IF l_oha09  ='5' AND g_omb[l_ac].omb12 !=0 THEN       #MOD-940155
     LET g_flag='N'
     LET g_msg1=g_omb[l_ac].omb31
     LET g_errno='axm-606' RETURN
  END IF
 #己確認應收待抵量+未確認應收待抵量+本次異動量不可大於銷退單+項次量
  IF (g_omb12+g_omb12_n+g_omb12_b+g_omb[l_ac].omb12) > g_ohb.ohb917 THEN   #FUN-560070
     LET g_flag='N'
     CALL cl_getmsg('axr-282',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-283',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-277',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb12 USING '######&.##',' ',
                l_msg2 CLIPPED,g_omb12_n USING '######&.##',' ',
                l_msg3 CLIPPED,g_omb[l_ac].omb12+g_omb12_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
 #此項次的應收待抵量不可大於銷退單+項次量
  IF (g_omb[l_ac].omb12+g_omb12_b) > g_ohb.ohb917 THEN   #FUN-560070
     LET g_flag='N'
     CALL cl_getmsg('axr-285',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-282',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-277',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_ohb.ohb917 USING '######&.##','+',   #FUN-560070
l_msg2 CLIPPED,g_omb12     USING '#####&.##','+',
l_msg3 CLIPPED,g_omb[l_ac].omb12+g_omb12_b USING '#####&.##'
     LET g_errno='aap-999' RETURN
  END IF
 #此項次的應收待抵未稅金額不可大於銷退單+項次未稅金額
  IF (g_omb[l_ac].omb14+g_omb14_b) > g_ohb.ohb14 THEN
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-281',g_lang) RETURNING l_msg2
     LET g_msg1=l_msg1 CLIPPED,
g_omb[l_ac].omb14+g_omb14_b USING '#####&.##','>',
l_msg2 CLIPPED,g_ohb.ohb14 USING '######&.##'
     LET g_errno='axr-276' RETURN
  END IF
 #此項次的應收待抵含稅金額不可大於銷退單+項次含稅金額
  IF (g_omb[l_ac].omb14t+g_omb14t_b) > g_ohb.ohb14t THEN
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-281',g_lang) RETURNING l_msg2
     LET g_msg1=l_msg1 CLIPPED,
g_omb[l_ac].omb14t+g_omb14t_b USING '#####&.##','>',
l_msg2 CLIPPED,g_ohb.ohb14t USING '######&.##'
     LET g_errno='axr-276' RETURN
  END IF
 #(已確認應收待抵未稅金額+已確認應收待抵含稅金額+此次異動銷退金額)
 # 不可大於銷退單+項次銷退未稅金額
  IF g_ohb14 - (g_omb14+g_omb14_n+g_omb14_b+g_omb[l_ac].omb14) < 0 THEN
     CALL cl_getmsg('axr-286',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-287',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb14 USING '######&.##',' ',
       l_msg2 CLIPPED,g_omb14_n USING '######&.##',' ',
       l_msg3 CLIPPED,g_omb[l_ac].omb14+g_omb14_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
 #(已確認應收待抵含稅金額+已確認應收待抵含稅金額+此次異動銷退金額)
 # 不可大於銷退單+項次銷退含稅金額
  IF g_ohb.ohb14t - (g_omb14t+g_omb14t_n+g_omb14t_b+g_omb[l_ac].omb14t) < 0 THEN
     LET g_flag='N'
     CALL cl_getmsg('axr-286',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-287',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb14t USING '######&.##',' ',
l_msg2 CLIPPED,g_omb14t_n USING '######&.##',' ',
l_msg3 CLIPPED,g_omb[l_ac].omb14t+g_omb14t_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
END FUNCTION
 
FUNCTION t300_s()
   DEFINE i       LIKE type_file.num5         #No.FUN-680123 SMALLINT
   DEFINE l_oot   DYNAMIC ARRAY OF RECORD
     oot01   LIKE oot_file.oot01,
     oot02   LIKE oot_file.oot02,
     oot06   LIKE oot_file.oot06,
     oot04   LIKE oot_file.oot04,
     oot04x  LIKE oot_file.oot04x,
     oot04t  LIKE oot_file.oot04t,
     oot05   LIKE oot_file.oot05,
     oot05x  LIKE oot_file.oot05x,
     oot05t  LIKE oot_file.oot05t
  END RECORD
   DEFINE p_row,p_col     LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_sql           STRING                   #No.FUN-680123 VARCHAR(500)
   DEFINE ls_tmp          STRING
 
   LET p_row = 6 LET p_col = 1
   OPEN WINDOW t300d3_w AT p_row,p_col
     WITH FORM "gxr/42f/gxrt300d3"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("gxrt300d3")
 
   IF g_oma.oma00 MATCHES '1*' THEN
      LET l_sql =" SELECT oot01,oot02,oot06,oot04,oot04x,oot04t,",
 "        oot05,oot05x,oot05t ",
 "   FROM oot_file ",
 "  WHERE oot03 = '",g_oma.oma01,"'"
   ELSE
      LET l_sql =" SELECT oma01,oma10,oma23,oma54,oma54x,oma54t,",
 "        oma56,oma56x,oma56t ",
 "   FROM oma_file,oot_file ",
 "  WHERE oma01 = oot03 ",
 "    AND oot01 = '",g_oma.oma01,"'"
   END IF
   PREPARE t300s_pre FROM l_sql
   IF STATUS THEN
      CALL cl_err('t300s_pre',STATUS,0)
      RETURN
   END IF
   DECLARE t300s_curs CURSOR FOR t300s_pre
 
   CALL l_oot.clear()
   LET i = 1
   FOREACH t300s_curs INTO l_oot[i].*
      IF SQLCA.sqlcode THEN
 CALL cl_err('',SQLCA.sqlcode,0)
 EXIT FOREACH
      END IF
      LET i = i + 1
   END FOREACH
   CALL cl_set_act_visible("accept,cancel", TRUE)
   DISPLAY ARRAY l_oot TO s_oot.* ATTRIBUTE(COUNT=i)
      ON IDLE g_idle_seconds
 CALL cl_on_idle()
 CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
 CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
 CALL cl_cmdask()     #MOD-4C0121
 
 
   END DISPLAY
   CLOSE WINDOW t300d3_w
END FUNCTION
 
FUNCTION t300_k()
   DEFINE l_totf,l_amtf     LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)
   DEFINE l_unrec1,l_unrec2 LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)
   DEFINE l_tot,l_amt       LIKE type_file.chr1      #No.FUN-680123 DEC(20,6)
   DEFINE l_oov04       LIKE oov_file.oov04
   DEFINE cnt1,cnt2     LIKE type_file.num5          #No.FUN-680123 SMALLINT
   DEFINE i,j,k     LIKE type_file.num5              #No.FUN-680123 SMALLINT
   DEFINE l_sql     STRING                           #No.FUN-680123 VARCHAR(600)
   DEFINE p_cmd     LIKE type_file.chr1              #No.FUN-680123 VARCHAR(01)
   DEFINE g_oov     DYNAMIC ARRAY OF RECORD
    oov02     LIKE oov_file.oov02,
    oov03     LIKE oov_file.oov03,
    oma032    LIKE oma_file.oma032,
    oma10     LIKE oma_file.oma10,
    oma24     LIKE oma_file.oma24,
    oov05     LIKE oov_file.oov05,    #No.FUN-680022
    omc08     LIKE omc_file.omc08,    #No.FUN-680022
    omc09     LIKE omc_file.omc09,    #No.FUN-680022
    un_recf   LIKE oov_file.oov04,
    un_rec    LIKE oov_file.oov04,
    oov04f    LIKE oov_file.oov04,
    oov04     LIKE oov_file.oov04
    END RECORD
   DEFINE g_oov_t   RECORD
    oov02     LIKE oov_file.oov02,
    oov03     LIKE oov_file.oov03,
    oma032    LIKE oma_file.oma032,
    oma10     LIKE oma_file.oma10,
    oma24     LIKE oma_file.oma24,
    oov05     LIKE oov_file.oov05,    #No.FUN-680022
    omc08     LIKE omc_file.omc08,    #No.FUN-680022
    omc09     LIKE omc_file.omc09,    #No.FUN-680022
    un_recf   LIKE oov_file.oov04,
    un_rec    LIKE oov_file.oov04,
    oov04f    LIKE oov_file.oov04,
    oov04     LIKE oov_file.oov04
    END RECORD
   DEFINE l_oma23   LIKE oma_file.oma23
   DEFINE l_omaconf LIKE oma_file.omaconf
   DEFINE l_oov04f  LIKE oov_file.oov04f
   DEFINE l_oma     RECORD LIKE oma_file.*
   DEFINE l_omc     RECORD LIKE omc_file.*         #No.
   DEFINE l_oma55,l_oma57  LIKE oma_file.oma55
   DEFINE l_difff,l_diff   LIKE oma_file.oma56t
   DEFINE l_sumf,l_sum     LIKE oma_file.oma56t
   DEFINE l_sumf_h,l_sum_h LIKE oma_file.oma56t
   DEFINE l_total   LIKE oma_file.oma56t
   DEFINE l_lock_sw       LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
   DEFINE l_modify_flag   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
   DEFINE l_k,l_over      LIKE type_file.num5,     #No.FUN-680123 SMALLINT,
   l_allow_insert  LIKE type_file.num5,      #No.FUN-680123 SMALLINT,              #可新增否
   l_allow_delete  LIKE type_file.num5       #No.FUN-680123 SMALLINT               #可刪除否
   DEFINE ls_rec_b        LIKE type_file.num10     #No.FUN-680123 INTEGER
   DEFINE l_oma03  LIKE oma_file.oma03
   DEFINE l_omc02  LIKE omc_file.omc02    #No.FUN-680022
   DEFINE l_omc14  LIKE omc_file.omc14    #No.FUN-680022
   DEFINE l_omc15  LIKE omc_file.omc15    #No.FUN-680022
   DEFINE l_omc13  LIKE omc_file.omc13    #No.TQC-6B0067
   DEFINE l_oma61  LIKE oma_file.oma61    #No.TQC-6B0067
   DEFINE l_i      LIKE type_file.num5    #No.TQC-6B0067
   DEFINE l_omc13f LIKE omc_file.omc13    #No.TQC-6B0067
 
   SELECT * INTO g_oma.* FROM oma_file
    WHERE oma01=g_oma.oma01
 
   IF g_aza.aza26 != '2' OR g_oma.oma00[1,1]!='2' OR g_ooy.ooydmy2!='Y' THEN
      RETURN
   END IF

   IF g_oma.omaconf = 'Y' THEN
      CALL cl_err(g_oma.oma01,'aap-005',0)
      RETURN
   END IF
 
   LET g_success='Y'
   LET g_oma_t.* = g_oma.*
   BEGIN WORK

   OPEN t300_cl USING g_oma.oma01
   IF STATUS THEN
      CALL cl_err("OPEN t300_cl k:", STATUS, 1)
      CLOSE t300_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH t300_cl INTO g_oma.*            # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_oma.oma01,SQLCA.sqlcode,0)      # 資料被他人LOCK
       CLOSE t300_cl
       ROLLBACK WORK
       RETURN
   END IF
 
   OPEN WINDOW t300_kkk_w AT 12,2 WITH FORM "axr/42f/axrt300_e"
                ATTRIBUTE (STYLE = g_win_style CLIPPED)
 
   CALL cl_ui_locale("axrt300_e")
 
   SELECT COUNT(*) INTO cnt1 FROM oov_file WHERE oov01 = g_oma.oma01
 
   IF cnt1 = 0 THEN
      IF g_ooz.ooz07 = 'N' THEN
         LET l_sql = "SELECT oma01,oma032,oma10,oma24, ",                                                                           
             "       omc02,omc08,(omc08-omc10),0,",#No.FUN-680022                                                                          
             "       omc09,(omc09-omc11),0  ",     #No.FUN-680022 
             "  FROM oma_file,omc_file ",          #No.FUN-680022 mark                                                                         
             " WHERE oma03 = '",g_oma.oma03,"' ",                                                                           
             "   AND oma032= '",g_oma.oma032,"' ",                                                                          
             "   AND oma00 MATCHES '1*'  ",                                                                                 
             "   AND oma23 = '",g_oma.oma23,"' ",       # 幣別必須相同                                                      
             "   AND (oma10 is null ",
             "    OR (oma10 is not null AND oma10 != '",g_oma.oma01,"'))  ",           # 不可衝自已產生的預付                                                     
             "   AND omaconf = 'Y' AND omavoid != 'Y' ",                                                                    
             "   AND omc09>omc11 AND omc01=oma01 " #No.FUN-680022                                                                                      
      ELSE
         LET l_sql = "SELECT oma01,oma032,oma10,oma24, ",                                                                           
             "       omc02,omc08,(omc08-omc10),0,",#No.FUN-680022                                                                         
             "       omc09,omc13,0  ",             #No.FUN-680022                                                                         
             "  FROM oma_file,omc_file ",          #No.FUN-680022                                                                              
             " WHERE oma03 = '",g_oma.oma03,"' ",                                                                           
             "   AND oma032= '",g_oma.oma032,"' ",                                                                          
             "   AND oma00 MATCHES '1*'  ",                                                                                 
             "   AND oma23 = '",g_oma.oma23,"' ",       # 幣別必須相同                                                      
             "   AND (oma10 is null ",                                                                                      
             "    OR (oma10 is not null AND oma10 != '",g_oma.oma01,"'))  ",           # 不可衝自已產生的預付                                                    
             "   AND omaconf = 'Y' AND omavoid != 'Y' ",                                                                    
             "   AND omc13>0 AND omc01=oma01 "     #No.FUN-680022                                                                         
      END IF                                                                                                                        

      PREPARE t300_k2_p0 FROM l_sql                                                                                                 

      DECLARE t300_k2_c0 CURSOR FOR t300_k2_p0                                                                                      

      CALL g_oov.clear()
      LET i = 1
 
      FOREACH t300_k2_c0 INTO g_oov[i].oov03,g_oov[i].oma032,g_oov[i].oma10,
                              g_oov[i].oma24,
                              g_oov[i].oov05,g_oov[i].omc08,     #No.FUN-680022
                              g_oov[i].un_recf,g_oov[i].oov04f,
                              g_oov[i].omc09,    #No.FUN-680022
                              g_oov[i].un_rec,g_oov[i].oov04
         IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
 
         IF cl_null(g_oov[i].oov03) THEN
            EXIT FOREACH
         END IF
         LET g_oov[i].oov02 = i
         
         INSERT INTO oov_file(oov01,oov02,oov03,oov04f,oov04,oov05,oovlegal)#No.FUN-680022 add oov05 #FUN-980011 add
           VALUES (g_oma.oma01,i,g_oov[i].oov03,0,0,g_oov[i].oov05,g_legal)#No.FUN-680022 add oov05 #FUN-980011 add
         LET i = i + 1
         IF i > g_max_rec THEN     #No.MOD-480131
            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_oov.deleteElement(i)
      LET ls_rec_b = i - 1
   END IF
 
   IF cnt1 > 0 THEN
      IF g_ooz.ooz07 = 'N' THEN                                                                                                     
 LET l_sql = "SELECT oov02,oov03,oma032,oma10,oma24,oov05,omc08,omc09, ",      #No.TQC-6B0067 
     "      (omc08-omc10),(omc09-omc11 ),oov04f,oov04 ",               #MOD-4A0288  #No.TQC-6B0067 
     "  FROM oov_file LEFT OUTER JOIN oma_file ON oov_file.oov03=oma_file.oma01 LEFT OUTER JOIN omc_file ON omc_file.omc01=oov_file.oov03 AND omc_file.omc02=oov_file.oov05 ",                                                                            
     " WHERE oov01 = '",g_oma.oma01,"' ",                                                                           
     " ORDER BY oov02 "                                                                                             
      ELSE                                                                                                                          
 LET l_sql = "SELECT oov02,oov03,oma032,oma10,oma24,oov05,omc08,omc09, ",                #No.TQC-6B0067  
     "      (omc08-omc10),omc13,oov04f,oov04 ",  #MOD-4A0288                     #No.TQC-6B0067    
     "  FROM oov_file LEFT OUTER JOIN oma_file ON oov_file.oov03=oma_file.oma01 LEFT OUTER JOIN omc_file ON omc_file.omc01=oov_file.oov03 AND omc_file.omc02=oov_file.oov05 ",                                                                            
     " WHERE oov01 = '",g_oma.oma01,"' ",                                                                           
     " ORDER BY oov02 "                                                                                             
      END IF                                                                                                                        
      PREPARE t300_k2_p FROM l_sql                                                                                                  
      DECLARE t300_k2_c CURSOR FOR t300_k2_p                                                                                        
 
      CALL g_oov.clear()
      LET k = 1
      LET g_oma.oma55 = 0
      LET g_oma.oma57 = 0
 
      FOREACH t300_k2_c INTO g_oov[k].*
         IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
         LET g_oma.oma55 = g_oma.oma55 + g_oov[k].oov04f
         LET g_oma.oma57 = g_oma.oma57 + g_oov[k].oov04
         LET k = k + 1
         IF k > g_max_rec THEN         #No.MOD-480131
            EXIT FOREACH
         END IF
      END FOREACH
      CALL g_oov.deleteElement(k)
      LET ls_rec_b = k - 1
   END IF
 
   LET l_sumf_h = g_oma.oma55
   LET l_sum_h  = g_oma.oma57
 
   DISPLAY BY NAME g_oma.oma55,g_oma.oma57
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   LET i = 1
   INPUT ARRAY g_oov WITHOUT DEFAULTS FROM s_oov.*
 ATTRIBUTE(COUNT=ls_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
      BEFORE INSERT
 LET i = ARR_CURR()
 LET p_cmd='a'
 INITIALIZE g_oov[i].* TO NULL
 LET g_oov_t.* = g_oov[i].*
 NEXT FIELD oov02
 
      AFTER INSERT
 IF INT_FLAG THEN
    CALL cl_err('',9001,0)
    LET INT_FLAG = 0
    CANCEL INSERT
 END IF
 IF g_oov[i].oov03 IS NULL THEN
    CALL g_oov.deleteElement(i)
    NEXT FIELD oov02
    CANCEL INSERT
 END IF 
 INSERT INTO oov_file(oov01,oov02,oov03,oov04f,oov04,oov05,
                              oovlegal)  #No.FUN-680022 add oov05 #FUN-980011 add
  VALUES(g_oma.oma01,g_oov[i].oov02,g_oov[i].oov03,
 g_oov[i].oov04f,g_oov[i].oov04,g_oov[i].oov05,      #No.FUN-680022 add oov05 
                 g_legal) #FUN-980011 add
 IF SQLCA.sqlcode THEN
    CALL cl_err3("ins","oov_file",g_oma.oma01,g_oov[i].oov03,SQLCA.sqlcode,"","ins oov:",1)  #No.FUN-660116
    LET g_success = 'N'
    CANCEL INSERT
 ELSE
    LET ls_rec_b = ls_rec_b + 1
    MESSAGE "insert ok"
    IF g_success = 'Y' THEN
       SELECT SUM(oov04f),SUM(oov04) INTO g_oma.oma55,g_oma.oma57
 FROM oov_file WHERE oov01=g_oma.oma01
 
       IF cl_null(g_oma.oma55) THEN
  LET g_oma.oma55 = 0
       END IF
 
       IF cl_null(g_oma.oma57 ) THEN
  LET g_oma.oma57 = 0
       END IF
       LET g_oma.oma61=g_oma.oma56t-g_oma.oma57                                                                             
       CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                         
       LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                
 
       DISPLAY BY NAME g_oma.oma55,g_oma.oma57
       UPDATE oma_file SET oma55=g_oma.oma55,oma57=g_oma.oma57,
   oma61=oma61-g_oma.oma57     #No.TQC-5B0175 更新本幣未衝金額
WHERE oma01 = g_oma.oma01
       IF STATUS OR SQLCA.SQLCODE THEN
  CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma1:",1)  #No.FUN-660116
  LET g_success='N'
  IF p_cmd = 'u' THEN
     LET g_oov[i].*=g_oov_t.*
  END IF
       END IF
 
       SELECT SUM(oov04f),SUM(oov04) INTO g_amt2f,g_amt2
 FROM oov_file Where oov03=g_oov[i].oov03
 
       IF g_amt2f IS NULL THEN
  LET g_amt2f = 0
  LET g_amt2 = 0
       END IF
 
       SELECT * INTO l_oma.* FROM oma_file
WHERE oma01 = g_oov[i].oov03
       LET l_oma.oma56t= l_oma.oma56 + l_oma.oma56x- g_amt2     #No.MOD-6B0113 alter g_amt1 ->g_amt2  
       LET l_oma.oma54t= l_oma.oma54 + l_oma.oma54x- g_amt2f    #No.MOD-6B0113 alter g_amt1f->g_amt2f 
       LET l_oma.oma60=l_oma.oma24
       LET l_oma.oma61=l_oma.oma56t-l_oma.oma57
       CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
       LET l_oma.oma61 = l_oma.oma61+g_net
       UPDATE oma_file SET oma51f= g_amt2f,                     #No.MOD-6B0113 alter g_amt1 ->g_amt2 
   oma51 = g_amt2,
   oma56t= l_oma.oma56t,
   oma54t= l_oma.oma54t,
   oma61 = l_oma.oma61
WHERE oma01 = g_oov[i].oov03
#No.TQC-7B0043 --begin    #類型是2*時，子帳期只有1筆，否則可以為多筆子帳期
       IF g_oma.oma00 MATCHES '2*'   THEN
  UPDATE omc_file set omc10 =g_oma.oma55,                                                                             
      omc11 =g_oma.oma57,                                                                              
      omc13 =g_oma.oma61
   WHERE omc01 = g_oma.oma01                                                                                      
     AND omc02 = 1        
       END IF                
       SELECT * INTO l_omc.* FROM omc_file 
WHERE omc01=g_oov[i].oov03 AND omc02=g_oov[i].oov05
       LET l_omc.omc08 = l_omc.omc08 - g_oov[i].oov04f
       LET l_omc.omc09 = l_omc.omc09 - g_oov[i].oov04
       LET l_omc.omc13 = l_omc.omc13 - g_oov[i].oov04
       UPDATE omc_file SET omc14 = g_amt2f,
   omc15 = g_amt2,
   omc08 = l_omc.omc08,
   omc09 = l_omc.omc09,
   omc13 = l_omc.omc09     #No.TQC-7B0043
WHERE omc01 = g_oov[i].oov03 AND omc02 = g_oov[i].oov05
 
    END IF
 END IF
 
      BEFORE INPUT
 IF ls_rec_b != 0 THEN
    CALL fgl_set_arr_curr(i)
 END IF
 LET g_before_input_done = FALSE
 CALL t300_set_entry_oov('a')
 CALL t300_set_no_entry_oov('a')
 LET g_before_input_done = TRUE
 
      BEFORE ROW
 LET p_cmd = ''
 LET i = ARR_CURR()
 LET l_lock_sw = 'N'
 IF ls_rec_b >= i THEN
    LET p_cmd='u'
    LET g_oov_t.* = g_oov[i].*
    #-->鎖住待抵沖帳資料
    IF cl_null(g_oov[i].oov05) THEN      #No.FUN-680022 
       IF g_ooz.ooz07 = 'N' THEN
  LET g_forupd_sql = "SELECT oma032,oma10,oma24,oma54t,(oma54t-oma55),",
     "       oma56t,(oma56t-oma57) FROM oma_file",
     " WHERE oma01=? FOR UPDATE"
       ELSE                                                                                                                    
  LET g_forupd_sql = "SELECT oma032,oma10,oma24,oma54t,(oma54t-oma55),",                                                    
     "       oma56t,oma61 FROM oma_file",                                                              
     " WHERE oma01=? FOR UPDATE"                                                                       
       END IF                                                                                                                  
        LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
       DECLARE t300_k2_cr CURSOR FROM g_forupd_sql
 
       OPEN t300_k2_cr USING g_oov_t.oov03
       IF STATUS THEN
  CALL cl_err("OPEN t300_k2_cr:", STATUS, 1)
  LET l_lock_sw = "Y"
       END IF
 
       FETCH t300_k2_cr INTO g_oov[i].oma032,g_oov[i].oma10,g_oov[i].oma24,
     g_oov[i].omc08,g_oov[i].un_recf,   #No.FUN-680022
     g_oov[i].omc09,g_oov[i].un_rec     #No.FUN-680022
       IF SQLCA.sqlcode THEN
  CALL cl_err(g_oov_t.oov02,SQLCA.sqlcode,1)
  LET l_lock_sw = "Y"
       END IF
       LET g_oov[i].omc08 = g_oov[i].omc08 + g_oov[i].oov04f    #No.FUN-680022
       LET g_oov[i].omc09 = g_oov[i].omc09 + g_oov[i].oov04     #No.FUN-680022
       LET g_oov[i].un_recf= g_oov[i].un_recf + g_oov[i].oov04f
       LET g_oov[i].un_rec = g_oov[i].un_rec + g_oov[i].oov04
       CALL cl_show_fld_cont()
    END IF                               #No.FUN-680022
 END IF
 CALL t300_set_entry_oov(p_cmd)
 CALL t300_set_no_entry_oov(p_cmd)
 
      BEFORE FIELD oov02
 IF cl_null(g_oov[i].oov02) OR g_oov[i].oov02 = 0 THEN
    SELECT MAX(oov02)+1 INTO g_oov[i].oov02 FROM oov_file
     WHERE oov01 = g_oma.oma01
    IF cl_null(g_oov[i].oov02)  THEN
       LET g_oov[i].oov02 = 1
    END IF
    LET g_oov[i].oov04f= 0
    LET g_oov[i].oov04 = 0
 END IF
 CALL t300_set_entry_oov(p_cmd)  #MOD-4A0288
 
      AFTER FIELD oov02
 IF g_oov_t.oov02 IS NULL OR
    g_oov_t.oov02 != g_oov[i].oov02 THEN
    SELECT COUNT(*) INTO k FROM oov_file
WHERE oov01 = g_oma.oma01 AND oov02 = g_oov[i].oov02
    IF k > 0 THEN
       CALL cl_err('',-239,0)
       NEXT FIELD oov02
    END IF
 END IF
 CALL t300_set_no_entry_oov(p_cmd)
 
 
      AFTER FIELD oov03
 IF g_oov_t.oov03 IS NULL OR
    g_oov_t.oov03 != g_oov[i].oov03 THEN
   #若oma00LIKE1*的單據，其omc資料僅為1筆時，對oov05自動賦值為1
    SELECT COUNT(*) INTO l_i FROM omc_file
     WHERE omc01=g_oov[i].oov03 
    IF l_i=1 THEN
       LET g_oov[i].oov05=1
    END IF
 END IF
 IF NOT cl_null(g_oov[i].oov03) THEN
 
    SELECT oma03 INTO l_oma03 FROM oma_file
       WHERE oma01= g_oov[i].oov03
    IF g_oma.oma03 <> l_oma03 THEN
       CALL cl_err('','aap-090',1)
    END IF
 END IF
 
      AFTER FIELD oov05
 IF NOT cl_null(g_oov[i].oov05) THEN
    IF g_oov[i].oov05 != g_oov_t.oov05
       OR cl_null(g_oov_t.oov05) THEN                
       IF NOT cl_null(g_oov[i].oov03) THEN
  SELECT COUNT(*) INTO k FROM oov_file
   WHERE oov01 = g_oma.oma01 AND oov03 = g_oov[i].oov03 AND oov05=g_oov[i].oov05
  IF k > 0 THEN  
     CALL cl_err('',-239,0)
     LET g_oov[i].oov05= NULL
     NEXT FIELD oov03 
  END IF
       END IF
       IF g_ooz.ooz07 = 'N' THEN
  LET g_forupd_sql = "SELECT oma032,oma10,oma23,oma24,omc08,",
     "       (omc08-omc10),omc09,(omc09-omc11),",
     "       omaconf FROM oma_file,omc_file",
     "   WHERE oma01 = ? AND oma00 MATCHES '1*' ",
     "   AND oma01=omc01 AND omc02= ? ",                       #No.TQC-6B0067
     "   AND omaconf = 'Y' AND omavoid != 'Y' "   #MOD-820032
       ELSE                                                                                                                    
  LET g_forupd_sql = "SELECT oma032,oma10,oma23,oma24,omc08,",                                                        
     "       (omc08-omc10),omc09,omc13, ",                                                           
     "       omaconf FROM oma_file,omc_file",                                                                   
     "   WHERE oma01 = ? AND oma00 MATCHES '1*' ",
     "   AND oma01=omc01 AND omc02=? ",                        #No.TQC-6B0067
     "   AND omaconf = 'Y' AND omavoid != 'Y' "    #MOD-820032                                                  
       END IF                                                                                                                  
        LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
       DECLARE t300_k22_cr CURSOR FROM g_forupd_sql
 
       OPEN t300_k22_cr USING g_oov[i].oov03,g_oov[i].oov05    #No.TQC-6B0067 add oov05
       IF STATUS THEN
  CALL cl_err("OPEN t300_k22_cr:", STATUS, 1)
  CLOSE t300_k22_cr
  ROLLBACK WORK
  RETURN
       END IF
 
       FETCH t300_k22_cr INTO g_oov[i].oma032,g_oov[i].oma10,l_oma23,
      g_oov[i].oma24,g_oov[i].omc08,l_amtf, 
      g_oov[i].omc09,l_amt,l_omaconf  
       IF SQLCA.sqlcode THEN
  CALL cl_err(g_oov[i].oov03,SQLCA.sqlcode,0)
  LET g_oov[i].oov03 = g_oov_t.oov03
  CLOSE t300_k22_cr
  NEXT FIELD oov03
       END IF
 
       #-->此帳款尚未確認
       IF l_omaconf != 'Y' THEN
  CALL cl_err(g_oov[i].oov03,'aap-141',0)
  NEXT FIELD oov03
       END IF
 
       #-->不可沖不同幣別
       IF l_oma23 != g_oma.oma23 THEN
  CALL cl_err(g_oov[i].oov03,'aap-014',0)
  NEXT FIELD oov03
       END IF
       #-->無金額可沖帳
       IF l_amtf <=0 AND l_amt <=0 THEN
  CALL cl_err(g_oov[i].oov03,'aap-203',0)
  NEXT FIELD oov03
       END IF
       LET g_oov[i].un_recf= l_amtf
       LET g_oov[i].un_rec = l_amt
    END IF                               #No.FUN-680022
 END IF
 
      AFTER FIELD oov04f
 IF NOT cl_null(g_oov[i].oov04f) THEN
       IF g_oov[i].oov04f < 0 THEN
       NEXT FIELD oov04f
    END IF
    LET l_oov04 = g_oov[i].oov04f * g_oov[i].oma24
    CALL cl_digcut(l_oov04,g_azi04)  RETURNING l_oov04  #No.FUN-680022  #No.TQC-750093 t_azi -> g_azi
    LET g_oov[i].oov04 = l_oov04
 END IF
 
      AFTER FIELD oov04
 IF NOT cl_null(g_oov[i].oov04) THEN
    IF g_oov[i].oov04 < 0 THEN
       NEXT FIELD oov04
    END IF
 
    #-->check 沖帳金額是否超過
    LET l_sum = 0
    LET l_sumf = 0
    LET l_over = 0
    FOR l_k =1 TO g_oov.getLength()   #No.MOD-480131
       IF cl_null(g_oov[l_k].oov03) THEN
    EXIT FOR
       END IF
       LET l_sumf= l_sumf+ g_oov[l_k].oov04f
       LET l_sum = l_sum + g_oov[l_k].oov04
       IF l_sumf > g_oma.oma54t OR l_sum > g_oma.oma56t THEN     
  LET g_oov[i].oov04f= 0
  LET g_oov[i].oov04 = 0
  CALL cl_err(g_oma.oma56t,'axr-209',0)
  LET l_over = 1
  EXIT FOR
       END IF
    END FOR
 
    IF l_over=1 THEN
       NEXT FIELD oov04f
    END IF
 
#No.TQC-7B0062 --begin    #使用omc13來判斷金額是否超出對應的子帳期金額
     SELECT (omc08-omc10),omc13  INTO l_omc13f,l_omc13  FROM omc_file
      WHERE omc01 = g_oov[i].oov03
AND omc02 = g_oov[i].oov05
     IF  g_oov[i].oov04 > l_omc13 OR g_oov[i].oov04f > l_omc13f THEN
LET g_oov[i].oov04f = 0
LET g_oov[i].oov04 = 0
CALL cl_err(g_oma.oma01,'aap-194',0)
NEXT FIELD oov04f
     END IF
 END IF
 
      ON ACTION CONTROLP
   CASE
      WHEN INFIELD(oov03)
 CALL cl_init_qry_var()
 LET g_qryparam.form = "q_oma3"
 LET g_qryparam.default1 = g_oov[i].oov03
 CALL cl_create_qry() RETURNING g_oov[i].oov03
 DISPLAY BY NAME g_oov[i].oov03
 NEXT FIELD oov03
      OTHERWISE EXIT CASE
   END CASE
 
BEFORE DELETE                            #是否取消單身
   IF g_oov_t.oov03 IS NOT NULL THEN
      IF NOT cl_delb(0,0) THEN
    INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
    LET g_doc.column1 = "oma01"         #No.FUN-9B0098 10/02/24
    LET g_doc.value1 = g_oma.oma01      #No.FUN-9B0098 10/02/24
    CALL cl_del_doc()                                                 #No.FUN-9B0098 10/02/24
 CANCEL DELETE
      END IF
      DELETE FROM oov_file
       WHERE oov01 = g_oma.oma01 AND oov03 = g_oov_t.oov03
      IF SQLCA.sqlcode THEN
 CALL cl_err3("del","oov_file",g_oma.oma01,g_oov_t.oov03,SQLCA.sqlcode,"","",1)  #No.FUN-660116
 CANCEL DELETE
      END IF
      LET ls_rec_b = ls_rec_b - 1
      MESSAGE "delete ok"
      IF g_success = 'Y' THEN
 SELECT SUM(oov04f),SUM(oov04) INTO g_oma.oma55,g_oma.oma57
   FROM oov_file WHERE oov01=g_oma.oma01
 IF cl_null(g_oma.oma55) THEN LET g_oma.oma55 = 0 END IF
 IF cl_null(g_oma.oma57) THEN LET g_oma.oma57 = 0 END IF
 DISPLAY BY NAME g_oma.oma55,g_oma.oma57
 LET g_oma.oma61=g_oma.oma56t-g_oma.oma57                                                                           
 CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                       
 LET g_oma.oma61 = g_oma.oma61 + g_net                                                                              
 UPDATE oma_file SET oma55=g_oma.oma55,oma57=g_oma.oma57,
     oma61=g_oma.oma61  #No.TQC-5B0175 更新本幣未衝金額  No.TQC-5C0086
  WHERE oma01 = g_oma.oma01
 IF STATUS OR SQLCA.SQLCODE THEN
    CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma1:",1)  #No.FUN-660116
    LET g_success='N'      
 END IF
 
 UPDATE omc_file SET omc10=g_oma.oma55,
     omc11=g_oma.oma57,
     omc13=g_oma.oma61
  WHERE omc01=g_oma.oma01 AND omc02=1
 IF SQLCA.sqlcode THEN
    CALL cl_err3("upd","omc_file",g_oma.oma01,"1",SQLCA.sqlcode,"","",1)
    LET g_success='N'
 END IF
 SELECT SUM(oov04f),SUM(oov04) INTO g_amt2f,g_amt2
   FROM oov_file Where oov03=g_oov[i].oov03
 IF g_amt2f IS NULL THEN
    LET g_amt2f = 0
    LET g_amt2 = 0
 END IF

 SELECT * INTO l_oma.* FROM oma_file
  WHERE oma01 = g_oov_t.oov03
 IF SQLCA.sqlcode THEN
    CALL cl_err3("sel","oma_file",g_oov_t.oov03,"",SQLCA.sqlcode,"","",1)
    LET g_success='N'
 END IF
 LET l_oma.oma56t= l_oma.oma56 + l_oma.oma56x- g_amt2      #No.MOD-6B0113 alter g_amt1 ->g_amt2  
 LET l_oma.oma54t= l_oma.oma54 + l_oma.oma54x- g_amt2f     #No.MOD-6B0113 alter g_amt1f->g_amt2f  
 LET l_oma.oma60 = l_oma.oma24
 LET l_oma.oma61 = l_oma.oma56t- l_oma.oma57
 CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
 LET l_oma.oma61 = l_oma.oma61 + g_net
 UPDATE oma_file SET oma51f= g_amt2f,                      #No.MOD-6B0113 alter g_amt1f->g_amt2f 
     oma51 = g_amt2,                       #No.MOD-6B0113 alter g_amt1 ->g_amt2  
     oma56t= l_oma.oma56t,
     oma54t= l_oma.oma54t,
     oma61 = l_oma.oma61
  WHERE oma01 = g_oov_t.oov03
 IF SQLCA.sqlcode THEN
    CALL cl_err3("upd","oma_file",g_oov_t.oov03,"",SQLCA.sqlcode,"","",1)
    LET g_success='N'
 END IF
 SELECT * INTO l_omc.* FROM omc_file 
  WHERE omc01=g_oov_t.oov03 AND omc02=g_oov_t.oov05
 LET l_omc.omc08 = l_omc.omc08 + g_oov_t.oov04f
 LET l_omc.omc09 = l_omc.omc09 + g_oov_t.oov04
 LET l_omc.omc13 = l_omc.omc13 + g_oov_t.oov04
 UPDATE omc_file SET omc08=l_omc.omc08,
     omc09=l_omc.omc09,
     omc13=l_omc.omc13,
     omc14=g_amt2f,
     omc15=g_amt2
  WHERE omc01=g_oov_t.oov03 AND omc02=g_oov_t.oov05
 IF SQLCA.sqlcode THEN
    CALL cl_err3("upd","omc_file",g_oov_t.oov03,g_oov_t.oov05,SQLCA.sqlcode,"","",1)
    LET g_success='N'
 END IF
      END IF
   END IF
 
      ON ROW CHANGE
  IF INT_FLAG THEN
     CALL cl_err('',9001,0)
     LET INT_FLAG = 0
     LET g_oov[l_ac].* = g_oov_t.*
     CLOSE t300_k22_cr
     LET g_success = 'N'
     EXIT INPUT
  END IF
  IF l_lock_sw = 'Y' THEN
     CALL cl_err(g_oov[l_ac].oov02,-263,1)
     LET g_oov[l_ac].* = g_oov_t.*
  ELSE
     UPDATE oov_file SET oov02 = g_oov[i].oov02,
 oov03 = g_oov[i].oov03,
 oov04f= g_oov[i].oov04f,
 oov04 = g_oov[i].oov04,
 oov05 = g_oov[i].oov05    #No.FUN-680022
      WHERE oov01 = g_oma.oma01
AND oov03 = g_oov_t.oov03
AND oov05 = g_oov_t.oov05        #No.FUN-680022
     IF STATUS OR SQLCA.SQLCODE THEN
CALL cl_err3("upd","oov_file",g_oma.oma01,g_oov_t.oov03,SQLCA.sqlcode,"","upd oov:",1)  #No.FUN-660116
LET g_success = 'N'
LET g_oov[i].* = g_oov_t.*
ELSE MESSAGE "update ok"
     END IF
     IF g_success = 'Y' THEN
SELECT SUM(oov04f),SUM(oov04) INTO g_oma.oma55,g_oma.oma57
  FROM oov_file WHERE oov01=g_oma.oma01
 
IF cl_null(g_oma.oma55) THEN
   LET g_oma.oma55 = 0
END IF
 
IF cl_null(g_oma.oma57 ) THEN
   LET g_oma.oma57 = 0
END IF
 
DISPLAY BY NAME g_oma.oma55,g_oma.oma57
LET g_oma.oma61=g_oma.oma56t-g_oma.oma57                                                                            
CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                        
LET g_oma.oma61 = g_oma.oma61 + g_net                                                                               
UPDATE oma_file SET oma55=g_oma.oma55,oma57=g_oma.oma57,
    oma61=g_oma.oma61  #No.TQC-5B0175 更新本幣未衝金額 No.TQC-5C0086
 WHERE oma01 = g_oma.oma01
IF STATUS OR SQLCA.SQLCODE THEN
   CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma1:",1)  #No.FUN-660116
   LET g_success='N'
   IF p_cmd = 'u' THEN
      LET g_oov[i].*=g_oov_t.*
   END IF
END IF
 
UPDATE omc_file SET omc10=g_oma.oma55,
    omc11=g_oma.oma57,
    omc13=g_oma.oma61
 WHERE omc01=g_oma.oma01 AND omc02=1
IF SQLCA.sqlcode THEN
   CALL cl_err3("upd","omc_file",g_oma.oma01,"1",SQLCA.sqlcode,"","",1)
   LET g_success='N'
END IF
 
SELECT SUM(oov04f),SUM(oov04) INTO g_amt2f,g_amt2
  FROM oov_file Where oov03=g_oov[i].oov03
 
IF g_amt2f IS NULL THEN
   LET g_amt2f = 0
   LET g_amt2 = 0
END IF
 
SELECT * INTO l_oma.* FROM oma_file
 WHERE oma01 = g_oov[i].oov03
LET l_oma.oma56t= l_oma.oma56 + l_oma.oma56x- g_amt2      #No.MOD-6B0113 alter g_amt1 ->g_amt2     
LET l_oma.oma54t= l_oma.oma54 + l_oma.oma54x- g_amt2f     #No.MOD-6B0113 alter g_amt1f->g_amt2f   
LET l_oma.oma60 = l_oma.oma24
LET l_oma.oma61 = l_oma.oma56t- l_oma.oma57
CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
LET l_oma.oma61 = l_oma.oma61 + g_net
UPDATE oma_file SET oma51f= g_amt2f,                      #No.MOD-6B0113 alter g_amt1f->g_amt2f  
    oma51 = g_amt2,                       #No.MOD-6B0113 alter g_amt1 ->g_amt2    
    oma56t= l_oma.oma56t,
    oma54t= l_oma.oma54t,
    oma61 = l_oma.oma61
 WHERE oma01 = g_oov[i].oov03
IF SQLCA.sqlcode THEN
   CALL cl_err3("upd","oma_file",g_oov[i].oov03,"",SQLCA.sqlcode,"","",1)
   LET g_success='N'
END IF
SELECT * INTO l_omc.* FROM omc_file 
 WHERE omc01=g_oov_t.oov03 AND omc02=g_oov_t.oov05
LET l_omc.omc08 = l_omc.omc08 + g_oov_t.oov04f - g_oov[i].oov04f
LET l_omc.omc09 = l_omc.omc09 + g_oov_t.oov04  - g_oov[i].oov04
LET l_omc.omc13 = l_omc.omc13 + g_oov_t.oov04  - g_oov[i].oov04     #No.TQC-7B0035
UPDATE omc_file SET omc08 = l_omc.omc08,
    omc09 = l_omc.omc09,
    omc13 = l_omc.omc13,
    omc14 = g_amt2f,
    omc15 = g_amt2
 WHERE omc01=g_oov_t.oov03 AND omc02=g_oov_t.oov05
IF SQLCA.sqlcode THEN
   CALL cl_err3("upd","omc_file",g_oov_t.oov03,g_oov_t.oov05,SQLCA.sqlcode,"","",1)
   LET g_success='N'
END IF
    END IF
  END IF
 
      AFTER ROW
  LET l_ac = ARR_CURR()
  IF INT_FLAG THEN
     CALL cl_err('',9001,0)
     LET INT_FLAG = 0
     IF p_cmd = 'u' THEN
LET g_oov[l_ac].* = g_oov_t.*
     END IF
     CLOSE t300_k22_cr
     LET g_success = 'N'
     EXIT INPUT
  END IF
  CLOSE t300_k22_cr
 
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
      LET g_success='N'
      LET INT_FLAG = 0
   END IF
 
   IF g_success = 'Y' THEN
      COMMIT WORK
      MESSAGE "Commit"
   ELSE
      ROLLBACK WORK
      MESSAGE "RollBack"
   END IF
 
   SELECT SUM(oov04f),SUM(oov04) INTO g_oma.oma55,g_oma.oma57
     FROM oov_file WHERE oov01=g_oma.oma01
 
   IF cl_null(g_oma.oma55) THEN
      LET g_oma.oma55 = 0
   END IF
 
   IF cl_null(g_oma.oma57 ) THEN
      LET g_oma.oma57 = 0
   END IF
 
   DISPLAY BY NAME g_oma.oma55,g_oma.oma57
   LET g_oma.oma61=g_oma.oma56t-g_oma.oma57                                                                                         
   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                     
   LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                            
 
   UPDATE oma_file SET oma55=g_oma.oma55,oma57=g_oma.oma57,
       oma61=g_oma.oma61     #No.TQC-5B0175  更新本幣未衝金額 No.TQC-5C0086
    WHERE oma01 = g_oma.oma01
 
   IF STATUS OR SQLCA.SQLCODE THEN
      CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma51:",1)  #No.FUN-660116
   END IF
 
   CLOSE WINDOW t300_kkk_w
 
   DISPLAY BY NAME g_oma.oma55,g_oma.oma57
   CLOSE t300_k2_cr
   CLOSE t300_k22_cr
 
   IF l_lock_sw = 'Y' THEN
      RETURN
   END IF
 
 
   LET g_oma.oma60 = g_oma.oma24
   LET g_oma.oma61 = g_oma.oma56t - g_oma.oma57
   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                     
   LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                            
 
   UPDATE oma_file set * = g_oma.* WHERE oma01 = g_oma.oma01
 
   CALL t300_show_rec_amt()
   DELETE FROM oov_file WHERE oov01 = g_oma.oma01 AND oov04 = 0
 
END FUNCTION
 
FUNCTION t300_set_entry_oov(p_cmd)
   DEFINE p_cmd  LIKE type_file.chr1      #No.FUN-680123  VARCHAR(01)
 
   CALL cl_set_comp_entry("oov03",TRUE)
 
END FUNCTION
 
FUNCTION t300_set_no_entry_oov(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
 
   IF p_cmd = 'u' THEN
      CALL cl_set_comp_entry("oov03",FALSE)
   END IF
 
END FUNCTION
 
FUNCTION t300_rec_record()
   DEFINE i,j          LIKE type_file.num5       #No.FUN-680123  SMALLINT
   DEFINE l_amtf,l_amt LIKE type_file.num20_6,   #No.FUN-680123 DEC(20,6),  #FUN-4B0079
  tmp_prog     LIKE type_file.chr1000    #No.FUN-680123 VARCHAR(100)
   DEFINE l_ape     RECORD
    no          LIKE oea_file.oea01,    #No.FUN-680123 VARCHAR(16),
    sq          LIKE type_file.num5,    #No.FUN-680123 SMALLINT,
    amtf        LIKE type_file.num20_6, #No.FUN-680123 DEC(20,6),
    amt         LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)
    END RECORD
 
   CALL g_ape.clear()
   IF g_oma.oma01 IS NULL THEN
      RETURN
   END IF
 
   OPEN WINDOW t300_rec_record_w WITH FORM "axr/42f/axrt300_4"
ATTRIBUTE(STYLE = g_win_style)
 
   CALL cl_ui_locale('axrt300_4')
 
   LET l_amtf = 0 LET l_amt  = 0
   LET i = 1
 
   IF g_oma.oma00 MATCHES '1*' THEN
      DECLARE t300_rec_c11 CURSOR FOR
   SELECT oov01,'',oov04f,oov04
     FROM oov_file
    WHERE oov03=g_oma.oma01
    ORDER BY oov01
 
      FOREACH t300_rec_c11 INTO g_ape[i].*
         IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
         LET l_amtf = l_amtf + g_ape[i].amtf
         LET l_amt  = l_amt  + g_ape[i].amt
         LET g_ape[i].sq = i
         LET i = i + 1
         IF i > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
 
   IF g_oma.oma00 MATCHES '2*' THEN
      DECLARE t300_rec_c21 CURSOR FOR
   SELECT oov03,'',oov04f,oov04
     FROM oov_file
    WHERE oov01=g_oma.oma01
    ORDER BY oov01
 
      FOREACH t300_rec_c21 INTO g_ape[i].*
         IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
         LET l_amtf = l_amtf + g_ape[i].amtf
         LET l_amt  = l_amt  + g_ape[i].amt
         LET g_ape[i].sq = i
         LET i = i + 1
         IF i > g_max_rec THEN
            EXIT FOREACH
         END IF
      END FOREACH
   END IF
   LET g_rec_b = i - 1
   DISPLAY l_amtf TO FORMONLY.totf
   DISPLAY l_amt  TO FORMONLY.tot
   DISPLAY ARRAY g_ape TO s_ape.* ATTRIBUTE(COUNT=g_rec_b)
      ON IDLE g_idle_seconds
 CALL cl_on_idle()
 CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
 CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
 CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
 CALL cl_cmdask()     #MOD-4C0121
 
 
   END DISPLAY
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
 
   CLOSE WINDOW t300_rec_record_w
END FUNCTION
 
FUNCTION t300_show_rec_amt()
DEFINE l_oma55_u    LIKE oma_file.oma55,
       l_oma57_u    LIKE oma_file.oma57
 
   DISPLAY BY NAME g_oma.oma65
 
   LET l_oma55_u = g_oma.oma54t - g_oma.oma55
   LET l_oma57_u = g_oma.oma56t - g_oma.oma57
   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                     
   LET l_oma57_u = l_oma57_u + g_net            #MOD-950088                                                                                  
 
   IF cl_null(l_oma55_u) THEN LET l_oma55_u = 0 END IF
   IF cl_null(l_oma57_u) THEN LET l_oma57_u = 0 END IF
 
   IF l_oma55_u < 0 THEN LET l_oma55_u = 0 END IF
   IF l_oma57_u < 0 THEN LET l_oma57_u = 0 END IF
 
   DISPLAY l_oma55_u, l_oma57_u TO FORMONLY.oma55_u, FORMONLY.oma57_u
END FUNCTION
 
#判斷g_ooz.ooz65(應收系統參數出貨應收可包含銷退折讓)
FUNCTION t300_ooz65()
 
  IF g_ooz.ooz65 !='Y' THEN
     CALL cl_set_comp_entry("omb38,omb39",FALSE)
     CASE 
       WHEN g_oma.oma00='11'
 LET g_omb[l_ac].omb38 = '1'
 LET g_omb[l_ac].omb39 = 'N'
       WHEN g_oma.oma00='12'
 LET g_omb[l_ac].omb38 = '2'
 LET g_omb[l_ac].omb39 = 'N'
       WHEN g_oma.oma00='13'
#LET g_omb[l_ac].omb38 = '2'    #CHI-A50040 mark
 LET g_omb[l_ac].omb38 = '1'    #CHI-A50040
 LET g_omb[l_ac].omb39 = 'N'
       WHEN g_oma.oma00='21'
 LET g_omb[l_ac].omb38 = '3'
 LET g_omb[l_ac].omb39 = 'N'
       OTHERWISE 
 LET g_omb[l_ac].omb38 = '99'
 LET g_omb[l_ac].omb39 = 'N'
     END CASE
  END IF
END FUNCTION
 
FUNCTION t300_g_b2_detail_1()
   DEFINE l_omb14      LIKE omb_file.omb14    #No:7682
 
   LET b_omb.omb31 = g_ogb.ogb01
   LET b_omb.omb32 = g_ogb.ogb03
   LET b_omb.omb04 = " " 
   LET b_omb.omb05 = " "
   LET b_omb.omb06 = " "
   LET b_omb.omb39 = g_ogb.ogb1012  #FUN-670026
#No.FUN-AB0034 --begin
   LET b_omb.omb45 = g_ogb.ogb49
   IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
      SELECT ool36,ool361 INTO b_omb.omb33,b_omb.omb331  FROM ool_file
       WHERE ool01 = g_oma.oma13
   END IF
#No.FUN-AB0034 --end
   IF cl_null(b_omb.omb39) THEN
      LET b_omb.omb39 = 'N'
   END IF
   SELECT SUM(omb14) INTO l_omb14
     FROM omb_file,oma_file
    WHERE oma00 = '12'
      AND oma01 = omb01
      AND omavoid = 'N'
       AND omaconf = 'N'                            #NO.MOD-530692
      AND omb31 = g_ogb.ogb01
      AND omb32 = g_ogb.ogb03
      AND omb44 = g_omb[l_ac].omb44   #FUN-9C0013 

   #LET l_sql = "SELECT SUM(ohb14) FROM ",li_dbs CLIPPED,"oha_file,",
   #                                      li_dbs CLIPPED,"ohb_file ",
    LET l_sql = "SELECT SUM(ohb14) FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                                          cl_get_target_table(g_plant_new,'ohb_file'),     #FUN-A50102                                 
               " WHERE oha09='3' AND oha01=ohb01 ", 
               "   AND ohb31 = '",g_ogb.ogb01,"' ",
               "   AND ohb32 = '",g_ogb.ogb03,"' ",
               "   AND ohaconf='Y' AND ohapost='Y' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
   PREPARE sel_ohb14_pre FROM l_sql
   EXECUTE sel_ohb14_pre INTO g_ohb14_ret
 
   IF cl_null(l_omb14) THEN
      LET l_omb14 = 0
   END IF
 
   IF cl_null(g_ogb.ogb1013) THEN
      LET g_ogb.ogb1013 = 0
   END IF
 
   IF cl_null(g_ohb14_ret) THEN
      LET g_ohb14_ret = 0
   END IF
 
   LET b_omb.omb12 = 0
 
   LET b_omb.omb14 = (g_ogb.ogb14-g_ogb.ogb1013 - g_ohb14_ret)-l_omb14   #No:7682   #FUN-560070
 
   IF b_omb.omb14 < 0  THEN
      CALL cl_err(g_ogb.ogb01,'axr-607',1)
      LET b_omb.omb14=0
   END IF
 
   LET b_omb.omb13 = g_ogb.ogb13
 
   LET b_omb.omb14 =b_omb.omb14*(-1)
   LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
   IF b_omb.omb14=0 THEN
      LET b_omb.omb13=0
      LET b_omb.omb14=0
      LET b_omb.omb14t=0
      LET b_omb.omb15=0
      LET b_omb.omb16=0
      LET b_omb.omb16t=0
      LET b_omb.omb17=0
      LET b_omb.omb18=0
      LET b_omb.omb18t=0
      LET b_omb.omb34=0
      LET b_omb.omb35=0
   ELSE
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
      IF cl_null(b_omb.omb14)  THEN LET b_omb.omb14=0  END IF
      IF cl_null(b_omb.omb14t) THEN LET b_omb.omb14t=0 END IF
      IF cl_null(b_omb.omb15)  THEN LET b_omb.omb15=0  END IF
      IF cl_null(b_omb.omb16)  THEN LET b_omb.omb16=0  END IF
      IF cl_null(b_omb.omb16t) THEN LET b_omb.omb16t=0 END IF
      IF cl_null(b_omb.omb17)  THEN LET b_omb.omb17=0  END IF
      IF cl_null(b_omb.omb18)  THEN LET b_omb.omb18=0  END IF
      IF cl_null(b_omb.omb34)  THEN LET b_omb.omb34=0  END IF
      IF cl_null(b_omb.omb35)  THEN LET b_omb.omb35=0  END IF
      IF cl_null(b_omb.omb13)  THEN LET b_omb.omb13=0  END IF
   END IF
   ##
 
   CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13    #No.TQC-750093 g_azi -> t_azi
 
   LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
   LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
   LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
   LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
 
 
   CALL cl_digcut(b_omb.omb14,t_azi04) RETURNING b_omb.omb14   #No.TQC-740350
   CALL cl_digcut(b_omb.omb14t,t_azi04)RETURNING b_omb.omb14t  #No.TQC-740350
   CALL cl_digcut(b_omb.omb15,g_azi03)  RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16,g_azi04)  RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16t,g_azi04) RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb17,g_azi03)  RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18,g_azi04)  RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18t,g_azi04) RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
 
   LET b_omb.omb34 = 0
   LET b_omb.omb35 = 0
   LET b_omb.omblegal = g_legal #FUN-980011 add
#No.FUN-AB0034 --begin
   IF g_oma.oma74 ='2' THEN 
      LET b_omb.omb14 = b_omb.omb14t
      LET b_omb.omb16 = b_omb.omb16t
      LET b_omb.omb18 = b_omb.omb18t
   END IF 
#No.FUN-AB0034 --end  
   MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb14
 
END FUNCTION
 
 
FUNCTION t300_chk_ohb_1(p_cmd)
  DEFINE p_cmd    LIKE type_file.chr1      #No.FUN-680123 VARCHAR(01)
 
  LET g_errno=' '  LET g_flag='Y'
 #應收待抵確認
  SELECT SUM(abs(omb14t)),SUM(abs(omb14)) INTO g_omb14t,g_omb14    #No.FUN-670026 --modify add(abs)
    FROM oma_file,omb_file
   WHERE oma00='21' AND oma01=omb01  AND omavoid='N' AND omaconf='Y'
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND omb44=g_omb[l_ac].omb44    #FUN-9C0013

 #應收待抵未確認(不含本項次異動):g_omb14t_n,g_omb14_t
  SELECT SUM(abs(omb14t)),SUM(abs(omb14))     #No.TQC-740350
    INTO g_omb14t_n,g_omb14_n
    FROM oma_file,omb_file
   WHERE oma00='21' AND oma01=omb01  AND omavoid='N' AND omaconf!='Y'
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND oma01 !=g_oma.oma01
     AND omb44=g_omb[l_ac].omb44    #FUN-9C0013
 #本次異動
  SELECT SUM(abs(omb14t)),SUM(abs(omb14))     #No.TQC-740350
    INTO g_omb14t_b,g_omb14_b
    FROM oma_file,omb_file
   WHERE oma00='21' AND oma01=omb01  AND omavoid='N' AND omaconf!='Y'
     AND omb31=g_omb[l_ac].omb31 AND omb32=g_omb[l_ac].omb32
     AND oma01=g_oma.oma01 AND omb03 !=g_omb[l_ac].omb03
     AND omb44=g_omb[l_ac].omb44    #FUN-9C0013 
  IF cl_null(g_omb14)    THEN LET g_omb14   =0 END IF
  IF cl_null(g_omb14_n)  THEN LET g_omb14_n =0 END IF
  IF cl_null(g_omb14_b)  THEN LET g_omb14_b =0 END IF
  IF cl_null(g_omb14t)   THEN LET g_omb14t  =0 END IF
  IF cl_null(g_omb14t_b) THEN LET g_omb14t_b=0 END IF
  IF cl_null(g_omb14t_n) THEN LET g_omb14t_n=0 END IF
  IF p_cmd='a' THEN
     LET g_omb[l_ac].omb14 = g_ohb.ohb1012 - (g_omb14+g_omb14_n+g_omb14_b) 
     IF cl_null(g_omb[l_ac].omb14) OR g_omb[l_ac].omb14 <0 THEN
LET g_omb[l_ac].omb14= 0
     END IF
  END IF
 #show原銷退量/已確認的應收待抵量/其他未確認應收待抵量
  CALL cl_getmsg('axr-608',g_lang) RETURNING l_msg1
  CALL cl_getmsg('axr-282',g_lang) RETURNING l_msg2
  CALL cl_getmsg('axr-283',g_lang) RETURNING l_msg3
  LET g_msg1=g_ohb.ohb31,'+',g_ohb.ohb32 USING '###',':',
    l_msg1 CLIPPED,g_ohb.ohb917 USING '#####&.##',' '    #FUN-560070
  DISPLAY g_msg1 CLIPPED AT 2,1
  LET g_msg1=' '
 #己確認應收待抵量+未確認應收待抵量+本次異動量不可大於銷退單+項次量
  IF (g_omb14+g_omb14_n+g_omb14_b+g_omb[l_ac].omb14) > g_ohb.ohb917 THEN   #FUN-560070
     LET g_flag='N'
     CALL cl_getmsg('axr-282',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-283',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-277',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb14 USING '######&.##',' ',
       l_msg2 CLIPPED,g_omb14_n USING '######&.##',' ',
       l_msg3 CLIPPED,g_omb[l_ac].omb14+g_omb14_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
 #此項次的應收待抵未稅金額不可大於銷退單+項次未稅金額
  IF (g_omb[l_ac].omb14+g_omb14_b) > g_ohb.ohb14 THEN
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-281',g_lang) RETURNING l_msg2
     LET g_msg1=l_msg1 CLIPPED,
g_omb[l_ac].omb14+g_omb14_b USING '#####&.##','>',
l_msg2 CLIPPED,g_ohb.ohb14 USING '######&.##'
     LET g_errno='axr-276' RETURN
  END IF
 #此項次的應收待抵含稅金額不可大於銷退單+項次含稅金額
  IF (g_omb[l_ac].omb14t+g_omb14t_b) > g_ohb.ohb14t THEN
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-281',g_lang) RETURNING l_msg2
     LET g_msg1=l_msg1 CLIPPED,
g_omb[l_ac].omb14t+g_omb14t_b USING '#####&.##','>',
l_msg2 CLIPPED,g_ohb.ohb14t USING '######&.##'
     LET g_errno='axr-276' RETURN
  END IF
 #(已確認應收待抵未稅金額+已確認應收待抵含稅金額+此次異動銷退金額)
 # 不可大於銷退單+項次銷退未稅金額
  IF g_ohb14 - (g_omb14+g_omb14_n+g_omb14_b+g_omb[l_ac].omb14) < 0 THEN
     CALL cl_getmsg('axr-286',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-287',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb14 USING '######&.##',' ',
       l_msg2 CLIPPED,g_omb14_n USING '######&.##',' ',
       l_msg3 CLIPPED,g_omb[l_ac].omb14+g_omb14_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
 #(已確認應收待抵含稅金額+已確認應收待抵含稅金額+此次異動銷退金額)
 # 不可大於銷退單+項次銷退含稅金額
  IF g_ohb.ohb14t - (g_omb14t+g_omb14t_n+g_omb14t_b+g_omb[l_ac].omb14t) < 0 THEN
     LET g_flag='N'
     CALL cl_getmsg('axr-286',g_lang) RETURNING l_msg1
     CALL cl_getmsg('axr-287',g_lang) RETURNING l_msg2
     CALL cl_getmsg('axr-278',g_lang) RETURNING l_msg3
     LET g_msg1=l_msg1 CLIPPED,g_omb14t USING '######&.##',' ',
l_msg2 CLIPPED,g_omb14t_n USING '######&.##',' ',
l_msg3 CLIPPED,g_omb[l_ac].omb14t+g_omb14t_b USING '######&.##'
     LET g_errno='aap-999' RETURN
  END IF
END FUNCTION
 
FUNCTION t300_g_b4_detail_1()
   DEFINE l_omb12  LIKE omb_file.omb12
 
   SELECT SUM(omb12) INTO l_omb12 FROM oma_file,omb_file
    WHERE oma00='21' AND oma01=omb01 AND omavoid='N'
      AND omb31=g_ohb.ohb01 AND omb32=g_ohb.ohb03
      AND omb44=g_omb[l_ac].omb44   #FUN-9C0013
   IF cl_null(l_omb12) THEN LET l_omb12=0 END IF
   LET b_omb.omb00 = g_oma.oma00  #plum
   LET b_omb.omb01 = g_oma.oma01
   LET b_omb.omb03 = g_ohb.ohb03
   LET b_omb.omb31 = g_ohb.ohb01
   LET b_omb.omb32 = g_ohb.ohb03
   LET b_omb.omb04 = " "
   LET b_omb.omb05 = " "
   LET b_omb.omb06 = " "
   LET b_omb.omb12 = 0
   LET b_omb.omb13 = 0
   LET b_omb.omb15 = 0
   LET b_omb.omb17 = 0
   LET b_omb.omb38 = '5'                       #銷退返利   #MOD-B20044
   LET b_omb.omb39 = g_ohb.ohb1004   #No.FUN-670026 --add
   LET b_omb.omb40 = g_ohb.ohb50     #MOD-B20044
#No.FUN-AB0034 --begin
   LET b_omb.omb45 = g_ohb.ohb70
   IF g_azw.azw04 = '2' AND g_oma.oma00='12' THEN
          SELECT ool36,ool361 INTO b_omb.omb33,b_omb.omb331  FROM ool_file
                 WHERE ool01 = g_oma.oma13
   END IF 
#No.FUN-AB0034 --end
   IF cl_null(b_omb.omb39) THEN
      LET b_omb.omb39 = 'N'
   END IF
   IF b_omb.omb14<0 THEN
      CALL cl_err("","axr-607",1)
   END IF
   LET b_omb.omb14t=b_omb.omb14*(1+g_oma.oma211/100)
   LET b_omb.omb16 =b_omb.omb14 *g_oma.oma24
   LET b_omb.omb16t=b_omb.omb14t*g_oma.oma24
   LET b_omb.omb18 =b_omb.omb14 *g_oma.oma58
   LET b_omb.omb18t=b_omb.omb14t*g_oma.oma58
   IF g_oma.oma00 MATCHES '[1*]' THEN
      LET b_omb.omb14  =b_omb.omb14 * (-1)
      LET b_omb.omb14t =b_omb.omb14t* (-1)
      LET b_omb.omb16  =b_omb.omb16 * (-1)
      LET b_omb.omb16t =b_omb.omb16t* (-1)
      LET b_omb.omb18  =b_omb.omb18 * (-1)
      LET b_omb.omb18t =b_omb.omb18t* (-1)
   END IF 
   CALL cl_digcut(b_omb.omb13,t_azi03) RETURNING b_omb.omb13  #No.TQC-750093 g_azi -> t_azi
   CALL cl_digcut(b_omb.omb15,g_azi03) RETURNING b_omb.omb15  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16,g_azi04) RETURNING b_omb.omb16  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb16t,g_azi04)RETURNING b_omb.omb16t #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb17,g_azi03) RETURNING b_omb.omb17  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18,g_azi04) RETURNING b_omb.omb18  #No.TQC-750093 t_azi -> g_azi
   CALL cl_digcut(b_omb.omb18t,g_azi04)RETURNING b_omb.omb18t #No.TQC-750093 t_azi -> g_azi
   LET b_omb.omb34=0 LET b_omb.omb35=0
 
   LET b_omb.omblegal = g_legal #FUN-980011 add
#No.FUN-AB0034 --begin
   IF g_oma.oma74 ='2' THEN 
      LET b_omb.omb14 = b_omb.omb14t
      LET b_omb.omb16 = b_omb.omb16t
      LET b_omb.omb18 = b_omb.omb18t
   END IF 
#No.FUN-AB0034 --end  
   MESSAGE b_omb.omb03,' ',b_omb.omb04,' ',b_omb.omb14
END FUNCTION
 
FUNCTION abs1(p_cmd)
   DEFINE p_cmd LIKE omb_file.omb14
 
   IF p_cmd >= 0 THEN
      RETURN p_cmd
   ELSE
      RETURN p_cmd * (-1)
   END IF
END FUNCTION
 
 
FUNCTION t300_gen_glcr(p_oma,p_ooy)
   DEFINE p_oma     RECORD LIKE oma_file.*
   DEFINE p_ooy     RECORD LIKE ooy_file.*
 
   IF cl_null(p_ooy.ooygslp) THEN
      CALL s_errmsg("oma01",p_oma.oma01,"","axr-070",1)
      LET g_success = 'N'
      RETURN
   END IF       
   CALL t300_v0()
   IF g_success = 'N' THEN RETURN END IF
 
END FUNCTION
 
FUNCTION t300_carry_voucher()
   DEFINE l_ooygslp    LIKE ooy_file.ooygslp
   DEFINE li_result    LIKE type_file.num5      #No.FUN-680123 SMALLINT 
   DEFINE l_dbs        STRING 
   DEFINE l_sql        STRING                                                                                                        
   DEFINE l_n          LIKE type_file.num5      #No.FUN-680123 SMALLINT  
   DEFINE l_buser      LIKE type_file.chr10     #No.MOD-920343 
   DEFINE l_euser      LIKE type_file.chr10     #No.MOD-920343 
 
   CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1
   SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
   IF g_ooy.ooydmy1 = 'N' THEN RETURN END IF
   IF g_ooy.ooyglcr = 'Y' OR (g_ooy.ooyglcr ='N' AND NOT cl_null(g_ooy.ooygslp)) THEN
      #LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new                                                                
      #LET l_sql = " SELECT COUNT(aba00) FROM ",l_dbs,"aba_file",
      LET l_sql = " SELECT COUNT(aba00) FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102      
          "  WHERE aba00 = '",g_ooz.ooz02b,"'",                                                                               
          "    AND aba01 = '",g_oma.oma33,"'"                                                                                 
  CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
  CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql #FUN-A50102
      PREPARE aba_pre2 FROM l_sql                                                                                                     
      DECLARE aba_cs2 CURSOR FOR aba_pre2                                                                                             
      OPEN aba_cs2                                                                                                                    
      FETCH aba_cs2 INTO l_n                                                                                                          
      IF l_n > 0 THEN                                                                                                                 
         CALL cl_err(g_oma.oma33,'aap-991',1)                                                                                         
         RETURN                                                                                                                       
      END IF   
   
      LET l_ooygslp = g_ooy.ooygslp
   ELSE
      CALL cl_err('','aap-936',1)                                                                                                  
      RETURN 
 
   END IF
   IF cl_null(l_ooygslp) THEN
      CALL cl_err(g_oma.oma01,'axr-070',1)
      RETURN
   END IF
   IF NOT cl_null(g_oma.oma99) THEN  
      LET l_buser = '0' 
      LET l_euser = 'z'  
   ELSE                 
      LET l_buser = g_oma.omauser  
      LET l_euser = g_oma.omauser  
   END IF                
   LET g_wc_gl = 'npp01 = "',g_oma.oma01,'" AND npp011 = 1'
   LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",l_buser,"' '",l_euser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",g_oma.oma02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"   #No.MOD-840608 add  #No.MOD-860075  #MOD-910250  #No.MOD-920343
   CALL cl_cmdrun_wait(g_str)
   SELECT oma33 INTO g_oma.oma33 FROM oma_file
    WHERE oma01 = g_oma.oma01
   DISPLAY BY NAME g_oma.oma33
    
END FUNCTION
 
FUNCTION t300_undo_carry_voucher() 
    DEFINE l_aba19    LIKE aba_file.aba19
    DEFINE l_dbs      STRING 
    DEFINE l_sql      STRING
 
    IF NOT cl_confirm('aap-988') THEN RETURN END IF
    
    CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1                                                                                   
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1                                                                          
    IF g_ooy.ooyglcr = 'N' AND cl_null(g_ooy.ooygslp)THEN
       CALL cl_err('','aap-936',1)                                                                                                  
       RETURN                                                                                                                       
    END IF 
    #LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new
    #LET l_dbs=l_dbs.trimRight()                                                                                                    
    #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
    LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102
        "  WHERE aba00 = '",g_ooz.ooz02b,"'",
        "    AND aba01 = '",g_oma.oma33,"'"
  CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
  CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql #FUN-A50102
    PREPARE aba_pre1 FROM l_sql
    DECLARE aba_cs1 CURSOR FOR aba_pre1
    OPEN aba_cs1
    FETCH aba_cs1 INTO l_aba19
    IF l_aba19 = 'Y' THEN
       CALL cl_err(g_oma.oma33,'axr-071',1)
       RETURN
    END IF
    LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_oma.oma33,"' 'Y'"
    CALL cl_cmdrun_wait(g_str)
    SELECT oma33 INTO g_oma.oma33 FROM oma_file
     WHERE oma01 = g_oma.oma01
    DISPLAY BY NAME g_oma.oma33
END FUNCTION
 
FUNCTION t300_multi_account()
   DEFINE l_omc DYNAMIC ARRAY OF RECORD
           omc02 LIKE omc_file.omc02,
           omc03 LIKE omc_file.omc03,
           oag02 LIKE oag_file.oag02,
           omc04 LIKE omc_file.omc04,
           omc05 LIKE omc_file.omc05,
           omc06 LIKE omc_file.omc06,
           omc07 LIKE omc_file.omc07,
           omc08 LIKE omc_file.omc08,
           omc09 LIKE omc_file.omc09,
           omc10 LIKE omc_file.omc10,
           omc11 LIKE omc_file.omc11,
           omc12 LIKE omc_file.omc12
   END RECORD,
   l_omc_t RECORD
           omc02 LIKE omc_file.omc02,
           omc03 LIKE omc_file.omc03,
           oag02 LIKE oag_file.oag02,
           omc04 LIKE omc_file.omc04,
           omc05 LIKE omc_file.omc05,
           omc06 LIKE omc_file.omc06,
           omc07 LIKE omc_file.omc07,
           omc08 LIKE omc_file.omc08,
           omc09 LIKE omc_file.omc09,
           omc10 LIKE omc_file.omc10,
           omc11 LIKE omc_file.omc11,
           omc12 LIKE omc_file.omc12
   END RECORD,
        l_omaconf         LIKE oma_file.omaconf,
        l_oag02           LIKE oag_file.oag02,
        l_oas02           LIKE oas_file.oas02,
        l_oas05           LIKE oas_file.oas05,
        l_omc08           LIKE omc_file.omc08,
        l_omc09           LIKE omc_file.omc09,
        l_omc04           LIKE omc_file.omc04,     
        l_omc05           LIKE omc_file.omc05,     
        l_omc13           LIKE omc_file.omc13,      #MOD-970296 add
        p_row,p_col       LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
        l_allow_insert    LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(01),
        l_allow_delete    LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(01),
        p_cmd             LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(01),
        l_rec_b           LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
        i,l_ac,l_ac_t,l_n LIKE type_file.num5       #No.FUN-680123 SMALLINT
DEFINE  l_max_rec         LIKE type_file.num10      #No.TQC-6B0067
 
   IF cl_null(g_oma.oma01) THEN                                                                                                         
      CALL cl_err('',-400,0)                                                                                                        
      RETURN                                                                                                                        
   END IF                                                                                                                           

   IF g_oma.oma64 matches '[Ss]' THEN      
       RETURN
   END IF
      
   LET p_row = 11 LET p_col = 3
   OPEN WINDOW t300_m AT p_row,p_col WITH FORM "axr/42f/axrt300_m"
     ATTRIBUTE (STYLE = g_win_style CLIPPED)
 
   CALL cl_ui_locale("axrt300_m")
   CALL l_omc.clear()
   LET g_sql = " SELECT omc02,omc03,'',omc04,omc05,omc06,",
       "        omc07,omc08,omc09,omc10,omc11,omc12 ",
       "   FROM omc_file",
       "  WHERE omc01 = '",g_oma.oma01,"' "
   PREPARE t300_multi FROM g_sql
   DECLARE omc_curs CURSOR FOR t300_multi
  
   LET i = 1
   LET l_rec_b = 0
   FOREACH omc_curs INTO l_omc[i].*
      IF SQLCA.sqlcode THEN    #No.TQC-7B0043
         CALL cl_err('foreach omc',STATUS,0) 
         EXIT FOREACH 
      END IF 
      IF NOT cl_null(l_omc[i].omc03) THEN
         SELECT oag02 INTO l_omc[i].oag02 FROM oag_file 
          WHERE oag01=l_omc[i].omc03
      END IF
      LET i = i + 1
      IF i > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
   END FOREACH
   CALL l_omc.deleteElement(i)
   LET l_rec_b = i-1
   DISPLAY l_rec_b TO FORMONLY.cn2
   SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
    WHERE omc01 =g_oma.oma01                                                                                                  
   IF cl_null(l_omc08) THEN LET l_omc08 = 0 END IF
   IF cl_null(l_omc09) THEN LET l_omc09 = 0 END IF
   IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                    
      CALL cl_getmsg('aap-984',g_lang) RETURNING g_msg
      WHILE TRUE
         LET g_chr=' '
         LET INT_FLAG = 0
     
         PROMPT g_msg CLIPPED FOR CHAR g_chr
     
            ON IDLE g_idle_seconds
               CALL cl_on_idle() 
     
         END PROMPT
     
         IF INT_FLAG THEN LET INT_FLAG = 0 EXIT WHILE END IF
     
         IF g_chr ='2' THEN
            CALL t300_ins_omc('1')                                                                                               
            CALL l_omc.clear()
            LET i =1
            FOREACH omc_curs INTO l_omc[i].*
               IF STATUS THEN 
                  CALL cl_err('foreach omc',STATUS,0) 
                  EXIT FOREACH 
               END IF 
               IF NOT cl_null(l_omc[i].omc03) THEN
                  SELECT oag02 INTO l_omc[i].oag02 FROM oag_file 
                   WHERE oag01=l_omc[i].omc03
               END IF
               LET i = i + 1
               IF i > g_max_rec THEN
                  CALL cl_err( '', 9035, 0 )
                  EXIT FOREACH
               END IF
            END FOREACH
     
            CALL l_omc.deleteElement(i)
            LET l_rec_b = i-1
            DISPLAY l_rec_b TO FORMONLY.cn2
            EXIT WHILE
         END IF                                                                                                                                 
     
         IF g_chr MATCHES "[12]" THEN EXIT WHILE END IF
     
      END WHILE
   END IF                                                                                                                                 
 
   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY l_omc TO s_omc.* ATTRIBUTE(COUNT=l_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         LET l_ac = ARR_CURR() 
 
      ON ACTION detail
         IF g_oma.omavoid = 'Y' THEN             
            CALL cl_err('','9024',1)
            LET g_success ='N'
         END IF
         
         IF g_oma.omaconf ='Y' THEN             
            CALL cl_err(g_oma.oma01,'axr-101',1)
            LET g_success ='N'
         END IF
         IF g_oma.omavoid != 'Y' AND g_oma.omaconf !='Y' THEN 
           WHILE TRUE   #MOD-920134 add
    CALL cl_set_act_visible("accept,cancel", TRUE)
    LET g_forupd_sql = " SELECT omc02,omc03,'',omc04,omc05,omc06,",
       "        omc07,omc08,omc09,omc10,omc11,omc12 ",
       "   FROM omc_file ",
       "  WHERE omc01 = '",g_oma.oma01,"' ",
       "    AND omc02 = ? ",
       "    AND omc03 = ? ",
       "  FOR UPDATE "
     LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t300_m_bc1 CURSOR FROM g_forupd_sql 
    
    IF g_oma.oma00[1,1]='1'  THEN                             #No.TQC-6B0067        
       LET l_max_rec=g_max_rec
    END IF                                                    #No.TQC-6B0067
    IF g_oma.oma00[1,1]='2'  THEN                             #No.TQC-6B0067       
       LET l_max_rec = 1                                      #No.TQC-6B0067
    END IF                                                    #No.TQC-6B0067
    LET l_allow_delete = cl_detail_input_auth("delete")
    LET l_allow_insert = cl_detail_input_auth("insert")
    INPUT ARRAY l_omc WITHOUT DEFAULTS FROM s_omc.* 
       ATTRIBUTE(COUNT=l_rec_b,MAXCOUNT=l_max_rec,UNBUFFERED, #No.TQC-6B0067
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
          LET l_omc_t.* = l_omc[l_ac].* 
          OPEN t300_m_bc1 USING l_omc_t.omc02,l_omc_t.omc03
          IF STATUS THEN
             CALL cl_err("OPEN t300_m_bc1:", STATUS, 1)
          ELSE
             FETCH t300_m_bc1 INTO l_omc[l_ac].*
             IF SQLCA.sqlcode THEN
                CALL cl_err(l_omc_t.omc02,SQLCA.sqlcode,1)
             END IF
             IF NOT cl_null(l_omc[l_ac].omc03) THEN
                SELECT oag02 INTO l_omc[l_ac].oag02 FROM oag_file 
                 WHERE oag01=l_omc[l_ac].omc03
             END IF
          END IF
       END IF
 
    BEFORE INSERT
       LET p_cmd = 'a'
       INITIALIZE l_omc[l_ac].* TO NULL
       LET l_omc[l_ac].omc10 = 0
       LET l_omc[l_ac].omc11 = 0
       LET l_omc_t.* = l_omc[l_ac].* 
       NEXT FIELD omc02 
 
    AFTER INSERT
       IF INT_FLAG THEN
          CALL cl_err('',9001,0)
          LET INT_FLAG = 0
          CANCEL INSERT
       END IF

       LET l_omc13 = l_omc[l_ac].omc09 - l_omc[l_ac].omc11  #MOD-970296 add

       INSERT INTO omc_file(omc01,omc02,omc03,omc04,omc05,omc06,omc07,
                            omc08,omc09,omc10,omc11,omc12,omc13,   #MOD-970296 add
                            omclegal) #FUN-980011 add
                     VALUES(g_oma.oma01,l_omc[l_ac].omc02,l_omc[l_ac].omc03,
                            l_omc[l_ac].omc04,l_omc[l_ac].omc05,l_omc[l_ac].omc06,
                            l_omc[l_ac].omc07,l_omc[l_ac].omc08,l_omc[l_ac].omc09,
                            l_omc[l_ac].omc10,l_omc[l_ac].omc11,l_omc[l_ac].omc12,
                            l_omc13,g_legal) #MOD-970296 add l_omc13  #FUN-980011 add
       IF SQLCA.sqlcode THEN
          CALL cl_err3("ins","omc_file",g_oma.oma01,l_omc[l_ac].omc02,SQLCA.sqlcode,"","",1)  
          CANCEL INSERT
       ELSE
          MESSAGE 'INSERT O.K'
          LET l_rec_b=l_rec_b+1
          DISPLAY l_rec_b TO FORMONLY.cn2  
          COMMIT WORK
       END IF
       SELECT MAX(omc04) INTO l_omc04 FROM omc_file 
        WHERE omc01=g_oma.oma01
       UPDATE oma_file SET oma11 = l_omc04
        WHERE oma01=g_oma.oma01
       IF SQLCA.sqlcode THEN
          CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc04,SQLCA.sqlcode,"","",1) 
       END IF
       SELECT MAX(omc05) INTO l_omc05 FROM omc_file 
        WHERE omc01=g_oma.oma01
       UPDATE oma_file SET oma12 = l_omc05
        WHERE oma01=g_oma.oma01
       IF SQLCA.sqlcode THEN
          CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc05,SQLCA.sqlcode,"","",1) 
       END IF
    
    ON ROW CHANGE
       IF INT_FLAG THEN
          CALL cl_err('',9001,0)
          LET INT_FLAG = 0
          LET l_omc[l_ac].* = l_omc_t.*
          CLOSE t300_m_bc1
          ROLLBACK WORK
          EXIT INPUT
       END IF
 
       UPDATE omc_file SET omc02 = l_omc[l_ac].omc02, 
                           omc03 = l_omc[l_ac].omc03,
                           omc04 = l_omc[l_ac].omc04,
                           omc05 = l_omc[l_ac].omc05,
                           omc06 = l_omc[l_ac].omc06,
                           omc07 = l_omc[l_ac].omc07,
                           omc08 = l_omc[l_ac].omc08,
                           omc09 = l_omc[l_ac].omc09,
                           omc10 = l_omc[l_ac].omc10,
                           omc11 = l_omc[l_ac].omc11,
                           omc12 = l_omc[l_ac].omc12,
                           omc13 = l_omc[l_ac].omc09-l_omc[l_ac].omc11
        WHERE omc01 = g_oma.oma01
          AND omc02 = l_omc_t.omc02
          AND omc03 = l_omc_t.omc03
       IF SQLCA.sqlcode THEN
          CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc_t.omc02,SQLCA.sqlcode,"","",1)  
          LET l_omc[l_ac].* = l_omc_t.*
       ELSE
          MESSAGE 'UPDATE O.K'
          COMMIT WORK
       END IF
 
       IF l_omc[l_ac].omc04 != l_omc_t.omc04 THEN #如果omc日期,更新oma日期 
          SELECT MAX(omc04) INTO l_omc04 FROM omc_file 
           WHERE omc01=g_oma.oma01
          UPDATE oma_file SET oma11 = l_omc04
           WHERE oma01 = g_oma.oma01
          IF SQLCA.sqlcode THEN
             CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc04,SQLCA.sqlcode,"","",1) 
          END IF
       END IF

       IF l_omc[l_ac].omc05 != l_omc_t.omc05 THEN 
          SELECT MAX(omc05) INTO l_omc05 FROM omc_file 
           WHERE omc01=g_oma.oma01
          UPDATE oma_file SET oma12 = l_omc05
           WHERE oma01 = g_oma.oma01
          IF SQLCA.sqlcode THEN
             CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc05,SQLCA.sqlcode,"","",1) 
          END IF
       END IF
   
    AFTER ROW
       LET l_ac = ARR_CURR()
       LET l_ac_t = l_ac 
       IF INT_FLAG THEN 
          CALL cl_err('',9001,0)
          LET INT_FLAG = 0
          IF p_cmd = 'u' THEN
             LET l_omc[l_ac].* = l_omc_t.*
          END IF
          CLOSE t300_m_bc1 
          ROLLBACK WORK 
          EXIT INPUT
       END IF
       CLOSE t300_m_bc1 
       COMMIT WORK
    
    BEFORE DELETE                            #是否取消單身
       IF l_omc_t.omc02 IS NOT NULL THEN
          IF NOT cl_delete() THEN
            INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
            LET g_doc.column1 = "oma01"         #No.FUN-9B0098 10/02/24
            LET g_doc.value1 = g_oma.oma01      #No.FUN-9B0098 10/02/24
            CALL cl_del_doc()                                             #No.FUN-9B0098 10/02/24
             CANCEL DELETE
          END IF
          DELETE FROM omc_file 
           WHERE omc01 = g_oma.oma01
             AND omc02 = l_omc_t.omc02
             AND omc03 = l_omc_t.omc03
          IF SQLCA.sqlcode THEN
             CALL cl_err3("del","omc_file",g_oma.oma01,l_omc_t.omc02,
           SQLCA.sqlcode,"","",1) 
             EXIT INPUT
          END IF
          LET l_rec_b=l_rec_b-1
          DISPLAY l_rec_b TO FORMONLY.cn2  
          COMMIT WORK
       END IF
 
    BEFORE FIELD omc02
       IF cl_null(l_omc[l_ac].omc02) OR l_omc[l_ac].omc02 = 0 THEN
          SELECT MAX(omc02)+1 INTO l_omc[l_ac].omc02
            FROM omc_file
           WHERE omc01 = g_oma.oma01
          IF cl_null(l_omc[l_ac].omc02) THEN
             LET l_omc[l_ac].omc02 = 1
          END IF
       END IF
 
    AFTER FIELD omc02
       IF NOT cl_null(l_omc[l_ac].omc02) THEN
  IF l_omc[l_ac].omc02 != l_omc_t.omc02 OR cl_null(l_omc_t.omc02) THEN
     SELECT COUNT(*) INTO l_n
       FROM omc_file
      WHERE omc01 = g_oma.oma01
AND omc02 = l_omc[l_ac].omc02
AND omc03 = l_omc[l_ac].omc03
     IF l_n > 0 THEN
CALL cl_err('',-239,0)
LET l_omc[l_ac].omc02 = l_omc_t.omc02
NEXT FIELD omc02
     END IF
  END IF
       END IF
 
    AFTER FIELD omc03
       IF NOT cl_null(l_omc[l_ac].omc03) THEN                                                       
  IF l_omc[l_ac].omc03 != l_omc_t.omc03                                                                                
OR cl_null(l_omc_t.omc03) THEN                                                                         
     SELECT COUNT(*) INTO l_n                                                                                          
       FROM omc_file                                                                                                   
      WHERE omc01 = g_oma.oma01                                                   
AND omc03 = l_omc[l_ac].omc03
     IF l_n > 0 THEN                                                                                                   
CALL cl_err(l_omc[l_ac].omc03,-239,0)                                                                                         
LET l_omc[l_ac].omc03 = l_omc_t.omc03                                                                          
NEXT FIELD omc03                                                                                               
     END IF                                                                                                            
     SELECT oag02 INTO l_omc[l_ac].oag02 FROM oag_file 
      WHERE oag01=l_omc[l_ac].omc03                                                          
     IF STATUS THEN                                                                                                      
CALL cl_err3("sel","oag_file",l_omc[l_ac].omc02,"",
      STATUS,"","select oag",1)                                                     
NEXT FIELD omc03                                                                                 
     END IF                                                                                                                 
 
                     IF NOT cl_null(g_oma.oma66) THEN
                        LET g_plant2=g_oma.oma66
                     ELSE
                        LET g_plant2 = g_plant
                     END IF
     CALL s_rdatem(g_oma.oma03,l_omc[l_ac].omc03 ,g_oma.oma02,
   g_oma.oma09,g_oma.oma02,g_plant2) #No.FUN-980020
     RETURNING l_omc[l_ac].omc04,l_omc[l_ac].omc05                                                                          
     LET l_omc[l_ac].omc06 = g_oma.oma24
     LET l_omc[l_ac].omc07 = g_oma.oma60
 
     SELECT oas02,oas05 INTO l_oas02,l_oas05 FROM oas_file
      WHERE oas01 = g_oma.oma32
AND oas04 = l_omc[l_ac].omc03
     IF l_oas02 = '1' AND NOT cl_null(l_oas05) THEN
LET l_omc[l_ac].omc08 = g_oma.oma54t * l_oas05 / 100
LET l_omc[l_ac].omc09 = g_oma.oma54  * l_oas05 / 100
     END IF
  END IF                       
       END IF    
 
    AFTER FIELD omc08
       IF NOT cl_null(l_omc[l_ac].omc08) THEN                                                       
  IF l_omc[l_ac].omc08 != l_omc_t.omc08                                                                                
     OR cl_null(l_omc_t.omc08) THEN                                                                         
     LET l_omc[l_ac].omc09 = l_omc[l_ac].omc08 * l_omc[l_ac].omc07
     CALL cl_digcut(l_omc[l_ac].omc09,g_azi04) RETURNING l_omc[l_ac].omc09  #No.TQC-750093 t_azi -> g_azi
  END IF
       END IF
 
    ON ACTION controlp
       CASE
  WHEN INFIELD(omc03)                                                                                                  
       CALL cl_init_qry_var()                                                                                          
       LET g_qryparam.form ="q_oag"                                                                                    
       LET g_qryparam.default1 = l_omc[l_ac].omc03
       CALL cl_create_qry() RETURNING l_omc[l_ac].omc03
       DISPLAY BY NAME l_omc[l_ac].omc03
       NEXT FIELD omc03
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
       CALL cl_set_focus_form(ui.Interface.getRootNode()) 
  RETURNING g_fld_name,g_frm_name
       CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
    ON ACTION CONTROLZ 
       CALL cl_show_req_fields() 
 
    ON ACTION exit
       EXIT INPUT
 
 AFTER INPUT      
    SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
     WHERE omc01 =g_oma.oma01                                                                                                  
    IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                    
       CALL cl_err('','axr-025',1)                                                                                                    
       NEXT FIELD omc08                                                                                                        
    END IF                
 END INPUT
 SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
  WHERE omc01 =g_oma.oma01                                                                                                  
 IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                    
    CALL cl_err('','axr-025',1)                                                                                                    
    CONTINUE WHILE
         ELSE
            EXIT WHILE
 END IF                
        END WHILE
      END IF
 
      ON ACTION accept
 IF g_oma.omavoid = 'Y' THEN           
    CALL cl_err('','9024',1)
    LET g_success ='N'
 END IF
 
 IF g_oma.omaconf ='Y' THEN           
    CALL cl_err(g_oma.oma01,'axr-101',1)
    LET g_success ='N'
 END IF
 
 IF g_oma.omavoid != 'Y' AND g_oma.omaconf !='Y' THEN 
           WHILE TRUE   #MOD-920134 add
    CALL cl_set_act_visible("accept,cancel", TRUE)
    LET g_forupd_sql = " SELECT omc02,omc03,'',omc04,omc05,omc06,",
       "        omc07,omc08,omc09,omc10,omc11,omc12 ",
       "   FROM omc_file ",
       "  WHERE omc01 = '",g_oma.oma01,"' ",
       "    AND omc02 = ? ",
       "    AND omc03 = ? ",
       "  FOR UPDATE "
     LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t300_m_bc2 CURSOR FROM g_forupd_sql 
 
    IF g_oma.oma00[1,1]='1' THEN                              #No.TQC-6B0067        
       LET l_max_rec=g_max_rec
    END IF                                                    #No.TQC-6B0067
    IF g_oma.oma00[1,1]='2' THEN                              #No.TQC-6B0067       
       LET l_max_rec=1                                        #No.TQC-6B0067 
    END IF                                                    #No.TQC-6B0067 
    LET l_allow_insert = cl_detail_input_auth("insert")           
    LET l_allow_delete = cl_detail_input_auth("delete")
    INPUT ARRAY l_omc WITHOUT DEFAULTS FROM s_omc.* 
       ATTRIBUTE(COUNT=l_rec_b,MAXCOUNT=l_max_rec,UNBUFFERED,  #No.TQC-6B0067
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
  LET l_omc_t.* = l_omc[l_ac].* 
  OPEN t300_m_bc2 USING l_omc_t.omc02,l_omc_t.omc03
  IF STATUS THEN
     CALL cl_err("OPEN t300_m_bc2:", STATUS, 1)
  ELSE
     FETCH t300_m_bc2 INTO l_omc[l_ac].*
     IF SQLCA.sqlcode THEN
CALL cl_err(l_omc_t.omc02,SQLCA.sqlcode,1)
     END IF
     IF NOT cl_null(l_omc[l_ac].omc03) THEN
SELECT oag02 INTO l_omc[l_ac].oag02 FROM oag_file 
 WHERE oag01=l_omc[l_ac].omc03
     END IF
  END IF
       END IF
 
    BEFORE INSERT
       LET p_cmd = 'a'
       INITIALIZE l_omc[l_ac].* TO NULL
       LET l_omc[l_ac].omc10 = 0
       LET l_omc[l_ac].omc11 = 0
       LET l_omc_t.* = l_omc[l_ac].* 
       NEXT FIELD omc02 
 
    AFTER INSERT
       IF INT_FLAG THEN
  CALL cl_err('',9001,0)
  LET INT_FLAG = 0
  CANCEL INSERT
       END IF
               LET l_omc13 = l_omc[l_ac].omc09 - l_omc[l_ac].omc11  #MOD-970296 add
       INSERT INTO omc_file(omc01,omc02,omc03,omc04,omc05,omc06,omc07,
    omc08,omc09,omc10,omc11,omc12,omc13,   #MOD-970296 add
                                    omclegal) #FUN-980011 add
       VALUES(g_oma.oma01,l_omc[l_ac].omc02,l_omc[l_ac].omc03,
      l_omc[l_ac].omc04,l_omc[l_ac].omc05,l_omc[l_ac].omc06,
      l_omc[l_ac].omc07,l_omc[l_ac].omc08,l_omc[l_ac].omc09,
      l_omc[l_ac].omc10,l_omc[l_ac].omc11,l_omc[l_ac].omc12,
                      l_omc13,g_legal) #MOD-970296 add l_omc13  #FUN-980011 add
  IF SQLCA.sqlcode THEN
     CALL cl_err3("ins","omc_file",g_oma.oma01,
   l_omc[l_ac].omc02,SQLCA.sqlcode,"","",1)  
     CANCEL INSERT
  ELSE
     MESSAGE 'INSERT O.K'
     LET l_rec_b=l_rec_b+1
     DISPLAY l_rec_b TO FORMONLY.cn2  
     COMMIT WORK
  END IF
    
    ON ROW CHANGE
       IF INT_FLAG THEN
  CALL cl_err('',9001,0)
  LET INT_FLAG = 0
  LET l_omc[l_ac].* = l_omc_t.*
  CLOSE t300_m_bc2
  ROLLBACK WORK
  EXIT INPUT
       END IF
 
       UPDATE omc_file SET omc02 = l_omc[l_ac].omc02, 
   omc03 = l_omc[l_ac].omc03,
   omc04 = l_omc[l_ac].omc04,
   omc05 = l_omc[l_ac].omc05,
   omc06 = l_omc[l_ac].omc06,
   omc07 = l_omc[l_ac].omc07,
   omc08 = l_omc[l_ac].omc08,
   omc09 = l_omc[l_ac].omc09,
   omc10 = l_omc[l_ac].omc10,
   omc11 = l_omc[l_ac].omc11,
   omc12 = l_omc[l_ac].omc12,
   omc13 = l_omc[l_ac].omc09-l_omc[l_ac].omc11    
     WHERE omc01 = g_oma.oma01
       AND omc02 = l_omc_t.omc02
       AND omc03 = l_omc_t.omc03
       IF SQLCA.sqlcode THEN
  CALL cl_err3("upd","omc_file",g_oma.oma01,
       l_omc_t.omc02,SQLCA.sqlcode,"","",1)  
  LET l_omc[l_ac].* = l_omc_t.*
       ELSE
  MESSAGE 'UPDATE O.K'
  COMMIT WORK
       END IF
 
       IF l_omc[l_ac].omc04 != l_omc_t.omc04 THEN #如果omc日期,更新oma日期 
  SELECT MAX(omc04) INTO l_omc04 FROM omc_file 
   WHERE omc01=g_oma.oma01
  UPDATE oma_file SET oma11 = l_omc04
   WHERE oma01 = g_oma.oma01
  IF SQLCA.sqlcode THEN
     CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc04,SQLCA.sqlcode,"","",1) 
  END IF
       END IF
       IF l_omc[l_ac].omc05 != l_omc_t.omc05 THEN 
  SELECT MAX(omc05) INTO l_omc05 FROM omc_file 
   WHERE omc01=g_oma.oma01
  UPDATE oma_file SET oma12 = l_omc05
   WHERE oma01 = g_oma.oma01
  IF SQLCA.sqlcode THEN
     CALL cl_err3("upd","oma_file",g_oma.oma01,l_omc05,SQLCA.sqlcode,"","",1) 
  END IF
       END IF
 
    AFTER ROW
       LET l_ac = ARR_CURR()
       LET l_ac_t = l_ac 
       IF INT_FLAG THEN 
  CALL cl_err('',9001,0)
  LET INT_FLAG = 0
  IF p_cmd = 'u' THEN
     LET l_omc[l_ac].* = l_omc_t.*
  END IF
  CLOSE t300_m_bc2 
  ROLLBACK WORK 
  EXIT INPUT
       END IF
       CLOSE t300_m_bc2 
       COMMIT WORK
    
    BEFORE DELETE                            #是否取消單身
       IF l_omc_t.omc02 IS NOT NULL THEN
  IF NOT cl_delete() THEN
    INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
    LET g_doc.column1 = "oma01"         #No.FUN-9B0098 10/02/24
    LET g_doc.value1 = g_oma.oma01      #No.FUN-9B0098 10/02/24
    CALL cl_del_doc()                                             #No.FUN-9B0098 10/02/24
     CANCEL DELETE
  END IF
  DELETE FROM omc_file 
   WHERE omc01 = g_oma.oma01
     AND omc02 = l_omc_t.omc02
     AND omc03 = l_omc_t.omc03
  IF SQLCA.sqlcode THEN
     CALL cl_err3("del","omc_file",g_oma.oma01,l_omc_t.omc02,
   SQLCA.sqlcode,"","",1) 
     EXIT INPUT
  END IF
  LET l_rec_b=l_rec_b-1
  DISPLAY l_rec_b TO FORMONLY.cn2  
  COMMIT WORK
       END IF
 
    BEFORE FIELD omc02
       IF cl_null(l_omc[l_ac].omc02) OR l_omc[l_ac].omc02 = 0 THEN
  SELECT MAX(omc02)+1 INTO l_omc[l_ac].omc02
    FROM omc_file
   WHERE omc01 = g_oma.oma01
  IF cl_null(l_omc[l_ac].omc02) THEN
     LET l_omc[l_ac].omc02 = 1
  END IF
       END IF
 
    AFTER FIELD omc02
       IF NOT cl_null(l_omc[l_ac].omc02) THEN
  IF l_omc[l_ac].omc02 != l_omc_t.omc02
OR cl_null(l_omc_t.omc02) THEN
     SELECT COUNT(*) INTO l_n
       FROM omc_file
      WHERE omc01 = g_oma.oma01
AND omc02 = l_omc[l_ac].omc02
AND omc03 = l_omc[l_ac].omc03
     IF l_n > 0 THEN
CALL cl_err('',-239,0)
LET l_omc[l_ac].omc02 = l_omc_t.omc02
NEXT FIELD omc02
     END IF
  END IF
       END IF
 
    AFTER FIELD omc03
       IF NOT cl_null(l_omc[l_ac].omc03) THEN                                                       
  IF l_omc[l_ac].omc03 != l_omc_t.omc03                                                                                
OR cl_null(l_omc_t.omc03) THEN                                                                         
     SELECT COUNT(*) INTO l_n                                                                                          
       FROM omc_file                                                                                                   
      WHERE omc01 = g_oma.oma01                                                   
AND omc03 = l_omc[l_ac].omc03
     IF l_n > 0 THEN                                                                                                   
CALL cl_err(l_omc[l_ac].omc03,-239,0)                                                                                         
LET l_omc[l_ac].omc03 = l_omc_t.omc03                                                                          
NEXT FIELD omc03                                                                                               
     END IF                                                                                                            
     SELECT oag02 INTO l_omc[l_ac].oag02 FROM oag_file 
      WHERE oag01=l_omc[l_ac].omc03                                                          
     IF STATUS THEN                                                                                                      
CALL cl_err3("sel","oag_file",l_omc[l_ac].omc02,"",
      STATUS,"","select oag",1)                                                     
NEXT FIELD omc03                                                                                 
     END IF                                                                                                                 
 
                     IF NOT cl_null(g_oma.oma66) THEN
                        LET g_plant2=g_oma.oma66
                     ELSE
                        LET g_plant2 = g_plant
                     END IF
     CALL s_rdatem(g_oma.oma03,l_omc[l_ac].omc03 ,g_oma.oma02,
   g_oma.oma09,g_oma.oma02,g_plant2) #No.FUN-980020
     RETURNING l_omc[l_ac].omc04,l_omc[l_ac].omc05                                                                          
     LET l_omc[l_ac].omc06 = g_oma.oma24
     LET l_omc[l_ac].omc07 = g_oma.oma60
 
     SELECT oas02,oas05 INTO l_oas02,l_oas05 FROM oas_file
      WHERE oas01 = g_oma.oma32
AND oas04 = l_omc[l_ac].omc03
     IF l_oas02 = '1' AND NOT cl_null(l_oas05) THEN
LET l_omc[l_ac].omc08 = g_oma.oma54t * l_oas05 / 100
LET l_omc[l_ac].omc09 = g_oma.oma54  * l_oas05 / 100
     END IF
  END IF                       
       END IF    
 
    AFTER FIELD omc08
       IF NOT cl_null(l_omc[l_ac].omc08) THEN                                                       
  IF l_omc[l_ac].omc08 != l_omc_t.omc08                                                                                
     OR cl_null(l_omc_t.omc08) THEN                                                                         
     LET l_omc[l_ac].omc09 = l_omc[l_ac].omc08 * l_omc[l_ac].omc07
     CALL cl_digcut(l_omc[l_ac].omc09,g_azi04) RETURNING l_omc[l_ac].omc09  #No.TQC-750093 t_azi -> g_azi
  END IF
       END IF
 
 
    ON ACTION controlp
       CASE
  WHEN INFIELD(omc03)                                                                                                  
       CALL cl_init_qry_var()                                                                                          
       LET g_qryparam.form ="q_oag"                                                                                    
       LET g_qryparam.default1 = l_omc[l_ac].omc03
       CALL cl_create_qry() RETURNING l_omc[l_ac].omc03
       DISPLAY BY NAME l_omc[l_ac].omc03
       NEXT FIELD omc03
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
       CALL cl_set_focus_form(ui.Interface.getRootNode()) 
  RETURNING g_fld_name,g_frm_name
       CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
    ON ACTION CONTROLZ 
       CALL cl_show_req_fields() 
 
    ON ACTION exit
       EXIT INPUT
 
    AFTER INPUT      
       SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
        WHERE omc01 =g_oma.oma01                                                                                                  
       IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                    
          CALL cl_err('','axr-025',1)                                                                                                    
          NEXT FIELD omc08                                                                                                        
       END IF                
 END INPUT
 SELECT SUM(omc08),SUM(omc09) INTO l_omc08,l_omc09 FROM omc_file                                                            
  WHERE omc01 =g_oma.oma01                                                                                                  
 IF l_omc08 <>g_oma.oma54t OR l_omc09 <>g_oma.oma56t THEN                                                                    
    CALL cl_err('','axr-025',1)                                                                                                    
    CONTINUE WHILE
         ELSE
            EXIT WHILE
 END IF                
        END WHILE
      END IF                
 
      CLOSE t300_m_bc2                                                                                                              
      COMMIT WORK                                                                                                                   
    
      CALL cl_set_act_visible("accept,cancel", FALSE)
     #CONTINUE DISPLAY #MOD-AC0265 mark
 
      ON ACTION exit                                                                                                                
 EXIT DISPLAY

     #MOD-AC0265 add --start--
      ON ACTION close                                                                                            
         EXIT DISPLAY
     #MOD-AC0265 add --end--
    
      ON ACTION controlg                                                                                                            
 CALL cl_cmdask()                                                                                                           

      ON IDLE g_idle_seconds
 CALL cl_on_idle()
 CONTINUE DISPLAY
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   LET INT_FLAG=0
   CLOSE WINDOW t300_m
END FUNCTION 
 
FUNCTION t300_ins_omc(p_cmd)  ##TQC-750177
   DEFINE p_cmd        LIKE type_file.chr1   ##TQC-750177
   DEFINE l_cnt        LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_omc        RECORD LIKE omc_file.*
   DEFINE g_oas        RECORD LIKE oas_file.*
   DEFINE l_omc08      LIKE omc_file.omc08          #No.TQC-740278                
   DEFINE l_omc09      LIKE omc_file.omc09          #No.TQC-740278                 
   DEFINE l_omc02      LIKE omc_file.omc02          #No.TQC-740278
 
   IF g_oma.omaconf='Y' AND p_cmd <> '3' THEN   #No.FUN-840213
      RETURN 
   END IF

   SELECT COUNT(omc01) INTO l_cnt 
     FROM omc_file
    WHERE omc01 = g_oma.oma01    
 
   IF (l_cnt >0) THEN
      IF p_cmd = '1' THEN
         DELETE FROM omc_file
          WHERE omc01 = g_oma.oma01 
         IF SQLCA.sqlcode THEN
            CALL cl_err3("del","omc_file",g_oma.oma01,'',SQLCA.sqlcode,"","",1)  
            RETURN
         END IF
         LET pb_cmd='Y'      #FUN-960140
      ELSE
         CALL cl_err('','aap-919',0)
         RETURN
      END IF
   END IF

   #LET g_sql = "SELECT COUNT(oas04) FROM ",li_dbs CLIPPED,"oas_file ",
   LET g_sql = "SELECT COUNT(oas04) FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
               " WHERE oas01 = '",g_oma.oma32,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
   PREPARE sel_oas_pre20 FROM g_sql
   EXECUTE sel_oas_pre20 INTO l_cnt

   IF l_cnt >= 1 THEN                            #有子收款條件
      SELECT UNIQUE(oas02) INTO g_oas.oas02
        FROM oas_file
       WHERE oas01 = g_oma.oma32

      #LET g_sql = "SELECT UNIQUE(oas02) FROM ",li_dbs CLIPPED,"oas_file ",
      LET g_sql = "SELECT UNIQUE(oas02) FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
                  " WHERE oas01 = '",g_oma.oma32,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102                
      PREPARE sel_oas_pre21 FROM g_sql
      EXECUTE sel_oas_pre21 INTO g_oas.oas02
   END IF
 
   #無子收款條件或收款條件類型為自定義或為待扺單據時，均產生一筆多帳期資料
  #IF l_cnt = 0 OR g_oas.oas02 = '2' OR g_oma.oma00[1,1] ='2' THEN  #No.TQC-6B0067 
   IF l_cnt = 0 OR g_oas.oas02 = '2' OR g_oma.oma00[1,1] ='2'    #No:FUN-A50103
      OR g_oma.oma00='11' OR g_oma.oma00='13' THEN    #No:FUN-A50103
      LET l_omc.omc01 = g_oma.oma01
      LET l_omc.omc02 = 1
      LET l_omc.omc03 = g_oma.oma32
      LET l_omc.omc04 = g_oma.oma11
      LET l_omc.omc05 = g_oma.oma12
      LET l_omc.omc06 = g_oma.oma24
      LET l_omc.omc07 = g_oma.oma60
      LET l_omc.omc08 = g_oma.oma54t
      LET l_omc.omc09 = g_oma.oma56t
      LET l_omc.omc10 = 0
      LET l_omc.omc11 = 0
      LET l_omc.omc12 = g_oma.oma10
      LET l_omc.omc13 = l_omc.omc09-l_omc.omc11+g_net
      LET l_omc.omc14 = 0
      LET l_omc.omc15 = 0
      LET l_omc.omclegal = g_legal #FUN-980011 add
 
      CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08  #No.TQC-750093 g_azi -> t_azi
      CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09  #No.TQC-750093 t_azi -> g_azi
      CALL cl_digcut(l_omc.omc13,g_azi04) RETURNING l_omc.omc13  #No.TQC-750093 t_azi -> g_azi
 
      INSERT INTO omc_file VALUES(l_omc.*)
 
      IF cl_sql_dup_value(SQLCA.SQLCODE) THEN  #已存在多帳期資料,更新發票號碼
         UPDATE omc_file SET omc12=l_omc.omc12
          WHERE omc01=l_omc.omc01 
            AND omc02=l_omc.omc02 
            AND (omc12=' ' OR omc12='' OR omc12 IS NULL) #發票號碼為空才更新
         IF SQLCA.sqlcode OR (SQLCA.sqlerrd[3]=0) THEN
            CALL cl_err3("upd","omc_file",l_omc.omc01,l_omc.omc02,"9050","","",1)
            LET g_success ='N'
         END IF
      ELSE
         IF SQLCA.sqlcode <> '0' THEN  #TQC-750177
            CALL cl_err3("ins","omc_file",l_omc.omc01,l_omc.omc02,SQLCA.sqlcode,"","",1)
            LET g_success ='N'
            RETURN
         END IF
      END IF
   ELSE
      LET g_sql = " SELECT oas01,oas02,oas03,oas04,oas05",
                  #"   FROM ",li_dbs CLIPPED,"oas_file ", #No.FUN-9C0014
                  "   FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102 
                  "  WHERE oas01 = '",g_oma.oma32,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102             
      PREPARE p300_p1 FROM g_sql
      DECLARE p300_c1 CURSOR FOR p300_p1

      FOREACH p300_c1 INTO g_oas.oas01,g_oas.oas02,g_oas.oas03,g_oas.oas04,g_oas.oas05
         IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
         LET l_omc.omc01 = g_oma.oma01
         LET l_omc.omc02 = g_oas.oas03
         LET l_omc.omc03 = g_oas.oas04
         IF NOT cl_null(g_oma.oma66) THEN
            LET g_plant2=g_oma.oma66
         ELSE
            LET g_plant2 = g_plant
         END IF
         CALL s_rdatem(g_oma.oma03,l_omc.omc03,g_oma.oma02,g_oma.oma09,g_oma.oma02,g_plant2) #NO.FUN-980020
             RETURNING l_omc.omc04,l_omc.omc05
         LET l_omc.omc06 = g_oma.oma24
         LET l_omc.omc07 = g_oma.oma60
         LET l_omc.omc08 = g_oma.oma54t*g_oas.oas05/100
         LET l_omc.omc09 = g_oma.oma56t*g_oas.oas05/100
         LET l_omc.omc10 = 0
         LET l_omc.omc11 = 0
         LET l_omc.omc12 = g_oma.oma10
         LET l_omc.omc13 = l_omc.omc09-l_omc.omc11
         LET l_omc.omc14 = 0
         LET l_omc.omc15 = 0
         LET l_omc.omclegal = g_legal #FUN-980011 add
 
         CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08  #No.TQC-750093 g_azi -> t_azi
         CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09  #No.TQC-750093 t_azi -> g_azi
         CALL cl_digcut(l_omc.omc13,g_azi04) RETURNING l_omc.omc13  #No.TQC-750093 t_azi -> g_azi
         
         INSERT INTO omc_file VALUES(l_omc.*)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","omc_file","omc01","omc02",SQLCA.sqlcode,"","",1)
            LET g_success ='N'
            RETURN
         END IF
      END FOREACH
   END IF

   #No.TQC-740278 --start-- 為了消除小數位數四舍五入引起的誤差，將產生的誤差加入最后一筆數據
   SELECT SUM(omc08),SUM(omc09),MAX(omc02) INTO l_omc08,l_omc09,l_omc02
     FROM omc_file
    WHERE omc01 = g_oma.oma01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","omc_file",g_oma.oma01,"",SQLCA.sqlcode,"","",1)
      LET g_success ='N'
      RETURN
   END IF

   IF cl_null(l_omc08) THEN
      LET l_omc08 = 0
   END IF

   IF cl_null(l_omc09) THEN
      LET l_omc09 = 0
   END IF

   IF l_omc08 <> g_oma.oma54t THEN
      UPDATE omc_file SET omc08 = omc08-(l_omc08-g_oma.oma54t)
       WHERE omc01 = g_oma.oma01
         AND omc02 = l_omc02
      IF SQLCA.sqlcode THEN
         CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc02,SQLCA.sqlcode,"","",1)
         LET g_success ='N'
         RETURN
      END IF
   END IF       

   IF l_omc09 <> g_oma.oma56t THEN
      UPDATE omc_file SET omc09 = omc09-(l_omc09-g_oma.oma56t), 
                          omc13 = omc13-(l_omc09-g_oma.oma56t)   #MOD-970296 add
       WHERE omc01 = g_oma.oma01
         AND omc02 = l_omc02
      IF SQLCA.sqlcode THEN
         CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc02,SQLCA.sqlcode,"","",1)
         LET g_success ='N'
         RETURN
      END IF
   END IF

   SELECT MAX(omc04),MAX(omc05) INTO g_oma.oma11,g_oma.oma12 FROM omc_file 
    WHERE omc01 = g_oma.oma01  

   UPDATE oma_file SET oma11 = g_oma.oma11,
                       oma12 = g_oma.oma12
    WHERE oma01 = g_oma.oma01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("upd","oma_file",g_oma.oma11,g_oma.oma12,SQLCA.sqlcode,"","",1)
   END IF

END FUNCTION
 
#此函數的功能是：在刪除帳款單據前，判斷此單據是否存在待扺單據，若存在待扺單據則彈出警告后退出刪除功能。
#                若要刪除帳款單據，必須先刪除待扺單據或不存在待扺單據的情況下才有刪除功能。
FUNCTION t300_checkoov(p_oma00,p_oma01)
DEFINE p_oma00    LIKE oma_file.oma00
DEFINE p_oma01    LIKE oma_file.oma01
DEFINE l_n        LIKE type_file.num5
DEFINE l_flag     LIKE type_file.chr1
 
    LET l_flag = 'Y'
    LET l_n=0
    IF p_oma00[1,1] = '2' THEN
       SELECT count(*) INTO l_n FROM oov_file WHERE oov01=p_oma01
       IF l_n>0 THEN
  CALL cl_err("","axr-032",1)
  LET l_flag='N'
       END IF
    END IF
    IF p_oma00[1,1] = '1' THEN
       SELECT count(*) INTO l_n FROM oov_file WHERE oov03=p_oma01
       IF l_n>0 THEN
  CALL cl_err("","axr-032",1)
  LET l_flag='N'
       END IF
    END IF
 
    RETURN l_flag
END FUNCTION
 
FUNCTION t300_count_amount(p_cmd)
DEFINE p_cmd    LIKE type_file.chr1
DEFINE l_tot1   LIKE omb_file.omb16,    #FUN-720038
       l_tot2   LIKE omb_file.omb16t    #FUN-720038
   IF cl_null(p_cmd) THEN
    SELECT SUM(omb16),SUM(omb16t) INTO l_tot1,l_tot2
      FROM omb_file
     WHERE omb01 = g_oma.oma01
    IF cl_null(l_tot1) THEN LET l_tot1 = 0 END IF
    IF cl_null(l_tot2) THEN LET l_tot2 = 0 END IF
   ELSE
    SELECT SUM(omb16),SUM(omb16t) INTO l_tot1,l_tot2
      FROM omb_file
     WHERE omb01 = g_oma.oma01
       AND omb03 <> g_omb[l_ac].omb03
    IF cl_null(l_tot1) THEN LET l_tot1 = 0 END IF
    IF cl_null(l_tot2) THEN LET l_tot2 = 0 END IF
    LET l_tot1 = l_tot1 + g_omb[l_ac].omb16
    LET l_tot2 = l_tot2 + g_omb[l_ac].omb16t
   END IF
    DISPLAY l_tot1 TO FORMONLY.tot_amt1
    DISPLAY l_tot2 TO FORMONLY.tot_amt2
END FUNCTION
 
FUNCTION t300_oma66(p_cmd)
DEFINE   p_cmd      LIKE type_file.chr1
DEFINE   l_azp02    LIKE azp_file.azp02
 
    LET g_errno = ''
    LET l_azp02 = NULL
   
    SELECT azp02 INTO l_azp02 FROM azp_file,azw_file
     WHERE azp01 = azw01 AND azp01 = g_oma.oma66
       AND azw02 = g_legal 
    CASE WHEN SQLCA.SQLCODE = 100  #LET g_errno = 'aap-025'   #FUN-990031
                                   LET g_errno = 'agl-171'    #FUN-990031
   LET l_azp02 = NULL
 OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
    END CASE
 
    IF cl_null(g_errno) OR p_cmd = 'd' THEN
       DISPLAY l_azp02 TO FORMONLY.azp02
    END IF
 
END FUNCTION
 
FUNCTION t300_omc_check()
   DEFINE l_sql     STRING    
   DEFINE l_amt     LIKE omc_file.omc08
   DEFINE l_amtf    LIKE omc_file.omc09    
   DEFINE l_sum,l_sumf  LIKE  omc_file.omc08     
   DEFINE l_omc     DYNAMIC ARRAY OF RECORD   
          omc02 LIKE omc_file.omc02,
          omc08 LIKE omc_file.omc08,
          omc09 LIKE omc_file.omc09,
          omc10 LIKE omc_file.omc10,
          omc11 LIKE omc_file.omc11,
          omc13 LIKE omc_file.omc13
          END RECORD
   DEFINE l_cnt     LIKE type_file.num10
 
   CALL l_omc.clear()
   LET l_cnt =1
 
   LET l_sql ="SELECT omc02,omc08,omc09,omc10,omc11,omc13",
      "  FROM omc_file",
      " WHERE omc01 = ?",
      " ORDER BY omc02"
   PREPARE t300_omc_p FROM l_sql                                                                                                       
   DECLARE omc_curs_c CURSOR FOR t300_omc_p
 
   LET l_sumf =0
   LET l_sum =0
   SELECT oma55,oma57 INTO l_amtf,l_amt FROM oma_file
     WHERE oma01=g_oma.oma01
   UPDATE omc_file SET omc10=0,omc11=0,omc13=0 WHERE omc01=g_oma.oma01
   FOREACH omc_curs_c USING g_oma.oma01 INTO l_omc[l_cnt].* 
      IF SQLCA.sqlcode THEN                                                                                                         
         CALL cl_err('foreach:',SQLCA.sqlcode,1)                                                                                    
         LET g_success='N'
         EXIT FOREACH                                                                                                               
      END IF      
      IF cl_null(l_omc[l_cnt].omc08) THEN
         LET l_omc[l_cnt].omc08 =0
      END IF
      IF cl_null(l_omc[l_cnt].omc09) THEN
         LET l_omc[l_cnt].omc09 =0
      END IF
      IF cl_null(l_omc[l_cnt].omc10) THEN
         LET l_omc[l_cnt].omc10 =0
      END IF
      IF cl_null(l_omc[l_cnt].omc11) THEN
         LET l_omc[l_cnt].omc11 =0
      END IF
      IF cl_null(l_omc[l_cnt].omc13) THEN
         LET l_omc[l_cnt].omc13 =0
      END IF
      LET l_sumf=l_sumf+ l_omc[l_cnt].omc08
      LET l_sum =l_sum + l_omc[l_cnt].omc09
      IF l_amtf <= l_omc[l_cnt].omc08 THEN   
         UPDATE omc_file SET omc10=l_amtf,
                             omc11=l_amt,
                             omc13=l_omc[l_cnt].omc09-l_amt
          WHERE omc01 = g_oma.oma01
            AND omc02 = l_omc[l_cnt].omc02
         IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc[l_cnt].omc02,SQLCA.sqlcode,"","",1)  
            LET g_success='N'
            RETURN
         END IF
         LET l_amtf = 0 #MOD-B30690  #既表示此筆沖漲以全數歸在此項次之中,因此後續無須計算 
         LET l_amt  = 0 #MOD-B30690
      ELSE
         IF l_amt >=l_omc[l_cnt].omc09 THEN
            UPDATE omc_file SET omc10=l_omc[l_cnt].omc08,
                                omc11=l_omc[l_cnt].omc09,
                                omc13= 0
             WHERE omc01=g_oma.oma01
               AND omc02 = l_omc[l_cnt].omc02
            IF SQLCA.sqlcode THEN
               CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc[l_cnt].omc02,SQLCA.sqlcode,"","",1)  
               LET g_success='N'
               RETURN
            END IF
            LET l_amtf = l_amtf - l_omc[l_cnt].omc08  
            LET l_amt  = l_amt  - l_omc[l_cnt].omc09    
         ELSE
            UPDATE omc_file SET omc10=l_omc[l_cnt].omc08,
                                omc11=l_amt,
                                omc13=l_omc[l_cnt].omc09-l_amt
             WHERE omc01=g_oma.oma01
               AND omc02 = l_omc[l_cnt].omc02
            IF SQLCA.sqlcode THEN
               CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc[l_cnt].omc02,SQLCA.sqlcode,"","",1)  
               LET g_success='N'
               RETURN
            END IF
            LET l_amtf = l_amtf - l_omc[l_cnt].omc08  
            LET l_amt =0
         END IF
      END IF
      LET l_cnt = l_cnt + 1                                                                                                         
   END FOREACH
   CALL l_omc.deleteElement(l_cnt)                                                                                                  
END FUNCTION
 
FUNCTION t300_date()
    DEFINE l_date      LIKE type_file.num5
    DEFINE l_flag      LIKE type_file.chr1
    DEFINE l_paydate   LIKE type_file.dat
 
    IF s_shut(0) THEN
       RETURN
    END IF
 
    IF g_oma.oma01 IS NULL THEN
       CALL cl_err('',-400,0)
       RETURN
    END IF
    
    IF g_oma.oma64 matches '[Ss]' THEN 
        RETURN 
    END IF
    
    SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
 
    IF g_oma.omavoid ='Y' THEN
       CALL cl_err(g_oma.oma01,'axr-103',0)
       RETURN
    END IF
 
    IF g_oma.omaconf='N' THEN
       CALL cl_err(g_oma.oma01,'aap-717',0)
       RETURN
    END IF
 
    IF g_oma.omaconf = "Y" AND g_oma.oma65 = "2" THEN
       CALL cl_err(g_oma.oma01,'axr-997',0)
       RETURN
    END IF

    LET li_dbs = ''
    IF NOT cl_null(g_oma.oma66) THEN
       LET g_plant_new = g_oma.oma66
    ELSE
       LET g_plant_new = g_plant
    END IF
    #CALL s_gettrandbs()
    #LET li_dbs = g_dbs_tra
 
    BEGIN WORK
    OPEN t300_cl USING g_oma.oma01
    IF STATUS THEN
       CALL cl_err("OPEN t300_cl date:", STATUS, 1)
       CLOSE t300_cl
       ROLLBACK WORK
       RETURN
    END IF
 
    FETCH t300_cl INTO g_oma.*
    IF STATUS THEN
       CALL cl_err('Lock oma:',STATUS,0)
       ROLLBACK WORK
       RETURN
    END IF
 
    LET g_oma_t.*=g_oma.*
    LET g_oma_o.*=g_oma.*
 
   WHILE TRUE
      CALL cl_set_head_visible("","YES")
 
      INPUT BY NAME g_oma.oma32,g_oma.oma11,g_oma.oma12
            WITHOUT DEFAULTS
 
         AFTER FIELD oma32
           #IF NOT cl_null(g_oma.oma32) THEN                                   #TQC-B10014 amrk
            IF NOT cl_null(g_oma.oma32) AND g_oma.oma32 <> g_oma_o.oma32  THEN #TQC-B10014
               IF g_oma.oma00[1,1] = '1' AND g_oma.oma32 IS NOT NULL THEN
                 #-MOD-AC0127-add-
                  IF g_oma.oma55 > 0 OR g_oma.oma57 > 0 THEN
                     CALL cl_err('','axr-082',1)
                     LET g_oma.oma32 = g_oma_o.oma32
                     DISPLAY BY NAME g_oma.oma32                               #TQC-B10014
                     NEXT FIELD oma11
                  END IF
                 #-MOD-AC0127-end-
                  #LET g_sql = " SELECT * FROM ",li_dbs CLIPPED,"oag_file",
                  LET g_sql = " SELECT * FROM ",cl_get_target_table(g_plant_new,'oag_file'), #FUN-A50102
                              "  WHERE oag01='",g_oma.oma32,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102              
                  PREPARE sel_oag_pre45 FROM g_sql
                  EXECUTE sel_oag_pre45
                  IF STATUS THEN
                     CALL cl_err3("sel","oag_file",g_oma.oma01,"",STATUS,"","sel oag:",1)
                     NEXT FIELD oma32
                  END IF
                  IF NOT cl_null(g_oma.oma66) THEN
                     LET g_plant2=g_oma.oma66
                  ELSE
                     LET g_plant2 = g_plant
                  END IF
                  CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                                g_oma.oma02,g_plant2)  #FUN-980020
                                                      RETURNING g_oma.oma11,g_oma.oma12
                  DISPLAY BY NAME g_oma.oma11,g_oma.oma12
                  DELETE FROM omc_file WHERE omc01 =g_oma.oma01
                  CALL t300_ins_omc('3')
               END IF
               LET g_oma_o.oma32 = g_oma.oma32
            END IF
        
         AFTER INPUT
            LET l_flag='N'
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_oma.*=g_oma_t.*
               DISPLAY BY NAME g_oma.oma32,g_oma.oma11,
                       g_oma.oma12
               CALL cl_err('',9001,0)
               EXIT WHILE
            END IF
        
            IF cl_null(g_oma.oma32) THEN
               LET l_flag='Y'
               DISPLAY BY NAME g_oma.oma32
            END IF
        
            IF cl_null(g_oma.oma11) THEN
               LET l_flag='Y'
               DISPLAY BY NAME g_oma.oma11
            END IF
        
            IF cl_null(g_oma.oma12) THEN
               LET l_flag='Y'
               DISPLAY BY NAME g_oma.oma12
            END IF
        
            IF l_flag='Y' THEN
               CALL cl_err('','9033',0)
               NEXT FIELD oma32
            END IF
        
            UPDATE oma_file SET oma32=g_oma.oma32,
                                oma11=g_oma.oma11,
                                oma12=g_oma.oma12,
                                oma71 = g_oma.oma71,    #FUN-970108
                                omamodu=g_user,
                                omadate=g_today
             WHERE oma01=g_oma.oma01
            IF STATUS OR SQLCA.SQLERRD[3]=0 THEN
               CALL cl_err3("upd","oma_file",g_oma.oma01,"",STATUS,"","upd oma01",1)
               LET g_oma.*=g_oma_t.*
               DISPLAY BY NAME g_oma.oma11,g_oma.oma12
               ROLLBACK WORK
               RETURN
            ELSE
               LET g_oma_o.*=g_oma.*
               LET g_oma_t.*=g_oma.*
            END IF
           #修正了oma11/oma12,應一併更新多帳期裡的omc04/omc05
            LET g_cnt = 0
            SELECT COUNT(*) INTO g_cnt FROM omc_file
             WHERE omc01 = g_oma.oma01
            IF g_cnt = 1 THEN 
               UPDATE omc_file SET omc04 = g_oma.oma11,
                                   omc05 = g_oma.oma12
                WHERE omc01 = g_oma.oma01
               IF STATUS THEN 
                  CALL cl_err3("upd","omc_file",g_oma.oma11,g_oma.oma12,STATUS,"","",1)  
               END IF
            END IF
        
         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(oma32)
          CALL cl_init_qry_var()
          LET g_qryparam.form ="q_oag"
          LET g_qryparam.default1 =g_oma.oma32
          CALL cl_create_qry() RETURNING g_oma.oma32
          DISPLAY BY NAME g_oma.oma32
          NEXT FIELD oma32
               OTHERWISE EXIT CASE
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
 
      EXIT WHILE
   END WHILE
 
   COMMIT WORK
 
END FUNCTION
 
FUNCTION t300_chk_omb31_32(p_oma01)
DEFINE   p_oma01   LIKE oma_file.oma01
DEFINE   l_omb38   LIKE omb_file.omb38
DEFINE   l_omb31   LIKE omb_file.omb31
DEFINE   l_omb32   LIKE omb_file.omb32
DEFINE   l_omb03   LIKE omb_file.omb03
DEFINE   l_cnt     LIKE type_file.num5
DEFINE   l_msg     STRING 
DEFINE   l_err     STRING
DEFINE   l_conf    LIKE type_file.chr1   
DEFINE   l_omb44   LIKE omb_file.omb44   #FUN-9C0041
DEFINE   p_dbs     LIKE type_file.chr21  #FUN-9C0041  
DEFINE   l_oha09   LIKE oha_file.oha09      #MOD-A80073
DEFINE   l_ohb12   LIKE ohb_file.ohb12      #MOD-A80073

   LET l_err   = NULL 

   IF cl_null(p_oma01) THEN 
      RETURN l_err
   END IF 

   DECLARE sel_omb_cs CURSOR FOR 
    SELECT omb44,omb38,omb31,omb32,omb03 FROM omb_file    #FUN-9C0041  add omb44
     WHERE omb01 = p_oma01

   FOREACH sel_omb_cs INTO l_omb44,l_omb38,l_omb31,l_omb32,l_omb03   #FUN-9C0041 add omb44
      IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
      LET l_msg   = NULL 

      IF cl_null(l_omb38) OR l_omb38 = '99' THEN   
         CONTINUE FOREACH
      END IF 
      #LET g_plant_new = l_omb44
      #CALL s_gettrandbs()
      #LET p_dbs = g_dbs_tra
      CASE 
         WHEN l_omb38='1'
            #LET g_sql = "SELECT COUNT(*) FROM ",p_dbs CLIPPED,"oeb_file ",
            LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_omb44,'oeb_file'), #FUN-A50102
                        " WHERE oeb01 = '",l_omb31,"' ",
                        "   AND oeb03 = '",l_omb32,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102             
            PREPARE sel_cou_oeb FROM g_sql
            EXECUTE sel_cou_oeb INTO l_cnt
            IF l_cnt = 0 THEN 
               LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
               LET l_msg = l_msg,'|',cl_getmsg('axs-002',g_lang),':',l_omb31,'-',l_omb32,'\n'
               LET l_err = l_msg
            ELSE
               #LET g_sql = "SELECT oeaconf FROM ",p_dbs CLIPPED,"oea_file ",
               LET g_sql = "SELECT oeaconf FROM ",cl_get_target_table(l_omb44,'oea_file'), #FUN-A50102
                           " WHERE oea01 = '",l_omb31,"' "
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102             
               PREPARE sel_oeaconf_pre FROM g_sql
               EXECUTE sel_oeaconf_pre INTO l_conf
               IF l_conf != 'Y' THEN 
                  LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
                  LET l_msg = l_msg,'|',cl_getmsg('axs-002',g_lang),':',l_omb31,'-',l_omb32,'\n'
                  LET l_err = l_msg
               END IF 
            END IF
         WHEN l_omb38='2' OR l_omb38='4'
            #LET g_sql = "SELECT COUNT(*) FROM ",p_dbs CLIPPED,"ogb_file ",
            LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_omb44,'ogb_file'), #FUN-A50102
                        " WHERE ogb01 = '",l_omb31,"' ",
                        "   AND ogb03 = '",l_omb32,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102             
            PREPARE sel_cou_ogb FROM g_sql
            EXECUTE sel_cou_ogb INTO l_cnt
            IF l_cnt = 0 THEN 
               LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
               LET l_msg = l_msg,'|',cl_getmsg('aqc-991',g_lang),':',l_omb31,'-',l_omb32,'\n'
               LET l_err = l_msg
            ELSE 
               #LET g_sql = "SELECT ogapost FROM ",p_dbs CLIPPED,"oga_file ",
               LET g_sql = "SELECT ogapost FROM ",cl_get_target_table(l_omb44,'oga_file'), #FUN-A50102
                           " WHERE oga01 = '",l_omb31,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102              
               PREPARE sel_ogapost_pre FROM g_sql
               EXECUTE sel_ogapost_pre INTO l_conf
               IF l_conf != 'Y' THEN 
                  LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
                  LET l_msg = l_msg,'|',cl_getmsg('aqc-991',g_lang),':',l_omb31,'-',l_omb32,'\n'
                  LET l_err = l_msg
               END IF
            END IF
         WHEN l_omb38='3' OR l_omb38='5'
            #LET g_sql = "SELECT COUNT(*) FROM ",p_dbs CLIPPED,"ohb_file ",
            LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_omb44,'ohb_file'), #FUN-A50102
                        " WHERE ohb01 = '",l_omb31,"' ",
                        "   AND ohb03 = '",l_omb32,"' "
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102                 
            PREPARE sel_cou_ohb FROM g_sql
            EXECUTE sel_cou_ohb INTO l_cnt
            IF l_cnt = 0 THEN 
               LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
               LET l_msg = l_msg,'|',cl_getmsg('axm-113',g_lang),':',l_omb31,'-',l_omb32,'\n'
               LET l_err = l_msg
            ELSE 
               #LET g_sql = "SELECT ohapost FROM ",p_dbs CLIPPED,"oha_file ",
              #LET g_sql = "SELECT ohapost FROM ",cl_get_target_table(l_omb44,'oha_file'), #FUN-A50102            #MOD-A80073 mark
               LET g_sql = "SELECT oha09,ohapost FROM ",cl_get_target_table(l_omb44,'oha_file'), #FUN-A50102      #MOD-A80073
                           " WHERE oha01 = '",l_omb31,"' "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102							
                  CALL cl_parse_qry_sql(g_sql,l_omb44) RETURNING g_sql #FUN-A50102             
               PREPARE sel_ohapost_pre FROM g_sql
              #EXECUTE sel_ohapost_pre INTO l_conf               #MOD-A80073 mark
               EXECUTE sel_ohapost_pre INTO l_oha09,l_conf       #MOD-A80073
               IF l_conf != 'Y' THEN 
                  LET l_msg = cl_getmsg('aap-417',g_lang),':',l_omb03 USING '#####&'
                  LET l_msg = l_msg,'|',cl_getmsg('axm-113',g_lang),':',l_omb31,'-',l_omb32,'\n'
                  LET l_err = l_msg
               END IF 
              #-MOD-A80073-add-
               IF l_omb38 = '3' THEN
                  LET l_sql = "SELECT ohb12  FROM ",cl_get_target_table(l_omb44,'ohb_file'), 
                              " WHERE ohb01='",l_omb31,"' AND ohb03='",l_omb32,"' ",
                              "   AND ohb1005 !='2' "
                  CALL cl_replace_sqldb(l_sql) RETURNING l_sql             
                  CALL cl_parse_qry_sql(l_sql,l_omb44) RETURNING l_sql                 
                  PREPARE sel_ohb_pre2 FROM l_sql
                  EXECUTE sel_ohb_pre2 INTO l_ohb12 
                  IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF
                  LET l_cnt = 0 
                  SELECT count(*) INTO l_cnt
                    FROM omb_file
                   WHERE omb01 <> p_oma01 AND omb31 = l_omb31 
                     AND omb32 = l_omb32
                  SELECT abs(SUM(omb12)) INTO l_omb12 FROM oma_file,omb_file
                   WHERE oma01=omb01 AND omavoid='N'
                     AND omb31=l_omb31 AND omb32=l_omb32
                  IF cl_null(l_omb12) THEN LET l_omb12=0 END IF
                 #IF (l_oha09 = '5' AND l_cnt > 0) OR (l_oha09!='5' AND l_omb12 = l_ohb12) THEN     #MOD-A80163 mark 
                  IF (l_oha09 = '5' AND l_cnt > 0) OR (l_oha09!='5' AND l_omb12 > l_ohb12) THEN     #MOD-A80163
                     LET l_msg = cl_getmsg('axr-390',g_lang),':',l_omb03 USING '#####&'
                     LET l_msg = l_msg,'|',cl_getmsg('axm-113',g_lang),':',l_omb31,'-',l_omb32,'\n'
                     LET l_err = l_msg
                  END IF   
               END IF   
              #-MOD-A80073-end-
            END IF
      END CASE 
   END FOREACH
  
   RETURN l_err
   
END FUNCTION
 
FUNCTION t300_omb31_takeb()                       #產生單身
   DEFINE l_omb12   LIKE omb_file.omb12
   DEFINE l_omb14   LIKE omb_file.omb14
   DEFINE l_oeaa08 LIKE oeaa_file.oeaa08  #CHI-B90025 add
   DEFINE l_oea01  LIKE oea_file.oea01    #CHI-B90025 add   
 
   #LET l_sql = "SELECT ogb_file.* FROM ",li_dbs CLIPPED,"oga_file,",
   #                                      li_dbs CLIPPED,"ogb_file ",
   LET l_sql = "SELECT ogb_file.* FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                                         cl_get_target_table(g_plant_new,'ogb_file'),     # FUN-A50102
               " WHERE ogb01 = '",g_omb[l_ac].omb31,"' ",
               "   AND ogb01 = oga01 AND ogb1005 != '2' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102              
   PREPARE sel_omb31_takeb FROM l_sql
   DECLARE t300_omb31_takeb CURSOR FOR sel_omb31_takeb
   FOREACH t300_omb31_takeb INTO g_ogb.*
      IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
      SELECT SUM(omb12) INTO l_omb12
        FROM omb_file,oma_file
       WHERE oma00 = '12'
         AND oma01 = omb01
         AND omavoid = 'N'
         AND omaconf = 'N'
         AND omb31 = g_ogb.ogb01
         AND omb32 = g_ogb.ogb03
         AND omb44 = g_omb[l_ac].omb44    #FUN-9C0130
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      IF cl_null(l_omb12) THEN
         LET l_omb12 = 0
      END IF
 
      IF g_ogb.ogb917-l_omb12 <= 0 THEN   #判斷出貨數量<=AR數量則不產生
         CONTINUE FOREACH                #單身部分
      END IF
 
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb01 = g_oma.oma01
      SELECT MAX(omb03) INTO b_omb.omb03
        FROM omb_file
       WHERE omb01 = g_oma.oma01
      IF cl_null(b_omb.omb03) THEN
         LET b_omb.omb03 = 0
      END IF
      LET b_omb.omb03 = b_omb.omb03+1
      LET b_omb.omb38 = '2'
 
      CALL t300_g_b2_detail()
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36 = g_oma.oma24
         LET b_omb.omb37 = b_omb.omb16t - b_omb.omb35
      END IF
 
 
      INSERT INTO omb_file VALUES(b_omb.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf3',SQLCA.SQLCODE,1)
      END IF
   END FOREACH
 
   IF cl_null(g_ohb14_ret) THEN
      LET g_ohb14_ret = 0
   END IF
 
   #LET l_sql = "SELECT ogb_file.* FROM ",li_dbs CLIPPED,"oga_file,",
   #                                      li_dbs CLIPPED,"ogb_file ",
   LET l_sql = "SELECT ogb_file.* FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                                         cl_get_target_table(g_plant_new,'ogb_file'),     # FUN-A50102
               " WHERE ogb01 = '",g_omb[l_ac].omb31,"' ",
               "   AND ogb01 = oga01 AND ogb1005 = '2' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102             
   PREPARE t300_omb31_pre1 FROM l_sql
   DECLARE t300_omb31_takeb2 CURSOR FOR t300_omb31_pre1
 
   FOREACH t300_omb31_takeb2 INTO g_ogb.*
      IF STATUS THEN EXIT FOREACH END IF     #MOD-AC0233
      SELECT SUM(abs(omb14)) INTO l_omb14
        FROM omb_file,oma_file
       WHERE oma00 = '12'
         AND oma01 = omb01
         AND omavoid = 'N'
         AND omaconf = 'N'
         AND omb31 = g_ogb.ogb01
         AND omb32 = g_ogb.ogb03
         AND omb44 = g_omb[l_ac].omb44    #FUN-9C0013
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      IF cl_null(l_omb12) THEN
         LET l_omb12 = 0
      END IF
 
      IF g_ogb.ogb14-l_omb14<= 0 THEN
         CONTINUE FOREACH                #單身部分 
      END IF
 
      IF STATUS THEN
         EXIT FOREACH
      END IF
 
      INITIALIZE b_omb.* TO NULL
      LET b_omb.omb01 = g_oma.oma01
      SELECT MAX(omb03) INTO b_omb.omb03
        FROM omb_file
       WHERE omb01 = g_oma.oma01
      IF cl_null(b_omb.omb03) THEN
         LET b_omb.omb03 = 0
      END IF
      LET b_omb.omb03 = b_omb.omb03+1
      LET b_omb.omb38 = '4'
 
      CALL t300_g_b2_detail_1()
 
      IF g_oma.oma00 MATCHES '1*' AND g_ooz.ooz62='Y' THEN
         LET b_omb.omb36 = g_oma.oma24
         LET b_omb.omb37 = b_omb.omb16t - b_omb.omb35
      END IF
 
      INSERT INTO omb_file VALUES(b_omb.*)
 
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('ins ombf3',SQLCA.SQLCODE,1)
      END IF
 
   END FOREACH
 
  #-------------------------------No.CHI-B90025----------------------------------start
   IF g_oma.oma00='11' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '1'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   IF g_oma.oma00='13' THEN
      SELECT oeaa08,oea01 INTO l_oeaa08,l_oea01 FROM oeaa_file,oea_file
       WHERE oeaa01 = g_oma.oma16
         AND oeaa02 = '2'
         AND oeaa03 = g_oma.oma165
         AND oeaa01 = oea01
   END IF
   CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,l_oeaa08) RETURNING g_oma.*
  #CALL t300_bu()
  #-------------------------------No.CHI-B90025----------------------------------end
 
   CALL s_up_omb(g_oma.oma01)

   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01

   CALL t300_ins_omc('0')
 
   SELECT * INTO g_oma.* FROM oma_file WHERE oma01=g_oma.oma01
 
   CALL t300_show()
   CALL t300_count_amount('')
 
END FUNCTION
 
 
FUNCTION t300_oma71()

   SELECT oom13 INTO g_oma.oma71 FROM oom_file
    WHERE oom07 <= g_oma.oma10
      AND oom08 >= g_oma.oma10
      AND oom03  = g_oma.oma05 
 
  #IF SQLCA.sqlcode THEN                             #MOD-AB0164 mark
   IF SQLCA.sqlcode AND cl_null(g_oma.oma71) THEN    #MOD-AB0164
      LET g_oma.oma71 = NULL 
   END IF 
 
   DISPLAY BY NAME g_oma.oma71     

END FUNCTION
 
FUNCTION t300_set_no_required()
 
   CALL cl_set_comp_required("oma71",FALSE)
 
END FUNCTION
 
FUNCTION t300_set_required()
 
   IF g_aza.aza94 = 'Y' THEN
      CALL cl_set_comp_required("oma71",TRUE)
   END IF

END FUNCTION 

FUNCTION t300_omb44()
   LET g_errno = ''

   SELECT * FROM azp_file,azw_file
    WHERE azp01 = azw01
      AND azp01 = g_omb[l_ac].omb44
      AND azw02 = g_legal

   CASE WHEN SQLCA.SQLCODE = 100  LET g_errno = 'agl-171'
        OTHERWISE                 LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE

   LET g_plant_new = g_omb[l_ac].omb44
   #CALL s_gettrandbs()
   #LET li_dbs = g_dbs_tra

END FUNCTION

#FUN-9C0072 精簡程式碼
#No.FUN-A30106 --begin                                                          
FUNCTION t300_drill_down()                                                      
                                                                                
   IF cl_null(g_oma.oma33) THEN RETURN END IF                                   

   LET g_msg = "aglt110 '",g_oma.oma33,"'"                                      

   CALL cl_cmdrun(g_msg)                                                        

END FUNCTION                                                                    
#No.FUN-A30106 --end

#-----MOD-A40078---------
FUNCTION t300_chk_it(l_no)
DEFINE l_sql      STRING, 
       l_no       LIKE oga_file.oga01,
       l_oga99    LIKE oga_file.oga99,
       l_oga99_1  STRING,
       i,j        INTEGER,
       l_poz19    LIKE poz_file.poz19,
       l_poz18    LIKE poz_file.poz18 

  LET g_errno = ''
  #LET l_sql = "SELECT oga99 FROM ",li_dbs CLIPPED,"oga_file ",
  LET l_sql = "SELECT oga99 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
              " WHERE oga01='",l_no,"' "
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102							
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102            
  PREPARE sel_oga99_pre FROM l_sql
  EXECUTE sel_oga99_pre INTO l_oga99

  LET l_oga99_1 = l_oga99
  LET i = l_oga99_1.getIndexOf('-',1)
  LET j = l_oga99_1.getIndexOf(' ',1)

  IF i > j THEN 
     LET l_oga99 = l_oga99_1.subString(1,j-1)
  ELSE
     LET l_oga99 = l_oga99_1.subString(1,i-1)
  END IF

  SELECT poz19,poz18 INTO l_poz19,l_poz18 FROM poz_file
   WHERE poz01=l_oga99

  IF NOT STATUS THEN 
     IF l_poz19 = 'N' OR (l_poz19 = 'Y' AND g_plant <> l_poz18) THEN
        LET g_errno = 'axr-080'
     END IF
  END IF

END FUNCTION
#-----END MOD-A40078-----

###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
###-實際交易稅別明細-###
FUNCTION t300_trans_tax()
DEFINE  l_sql     LIKE type_file.chr1000
DEFINE  g_rec_b   LIKE type_file.num5,
        g_cnt     LIKE type_file.num5
DEFINE  l_omk    DYNAMIC ARRAY OF RECORD     #--定義一個動態數組
         omk02     LIKE omk_file.omk02,
         omk03     LIKE omk_file.omk03,
         gec02     LIKE gec_file.gec02,
         omk04     LIKE omk_file.omk04,
         omk05     LIKE omk_file.omk05,
         omk06     LIKE omk_file.omk06,
         omk07     LIKE omk_file.omk07,
         omk07t    LIKE omk_file.omk07t,
         omk08     LIKE omk_file.omk08,
         omk09     LIKE omk_file.omk09
         END RECORD

   LET l_sql ="SELECT omk02,omk03,'',omk04,omk05,omk06,omk07,",
              " omk07t,omk08,omk09 ",
              "  FROM omk_file,oma_file ",
              " WHERE omk01 = oma01 ",
              "   AND oma01 = '",g_oma.oma01,"'",
              " ORDER BY omk02 "
   PREPARE t300_omk_pre1 FROM l_sql
      IF SQLCA.sqlcode THEN
         CALL cl_err('t300_omk_pre1:',SQLCA.sqlcode,1)
         RETURN
      END IF
   DECLARE t300_omk_cs1 CURSOR WITH HOLD FOR t300_omk_pre1
   CALL l_omk.clear()
   LET g_cnt = 1
   FOREACH t300_omk_cs1 INTO l_omk[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      SELECT gec02 INTO l_omk[g_cnt].gec02 FROM gec_file
       WHERE gec01 = l_omk[g_cnt].omk03
         AND gec011 = '2'
      LET g_cnt = g_cnt + 1
   END FOREACH
   CALL l_omk.deleteElement(g_cnt)
   LET g_cnt=g_cnt-1
   OPEN WINDOW axrt300_trans_w WITH FORM "axr/42f/axrt300_trans"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
   CALL cl_ui_locale("axrt300_trans")
   DISPLAY g_cnt TO FORMONLY.cn2
   DISPLAY ARRAY l_omk TO s_omk.*  ATTRIBUTE(COUNT=g_rec_b)
      ON ACTION controlg
         CALL cl_cmdask() 
   END DISPLAY    
   IF INT_FLAG THEN
      LET INT_FLAG = 0  
      CLOSE WINDOW axrt300_trans_w
   END IF          
   CLOSE WINDOW axrt300_trans_w
END FUNCTION

###-單身稅別明細-###
FUNCTION t300_detail_tax()
DEFINE  l_sql     LIKE type_file.chr1000
DEFINE  g_rec_b   LIKE type_file.num5,
        g_cnt     LIKE type_file.num5
DEFINE  l_oml    DYNAMIC ARRAY OF RECORD     #--定義一個動態數組
         oml02     LIKE oml_file.oml02,
         oml03     LIKE oml_file.oml03,
         gec02     LIKE gec_file.gec02,
         oml04     LIKE oml_file.oml04,
         oml05     LIKE oml_file.oml05,
         oml06     LIKE oml_file.oml06,
         oml07     LIKE oml_file.oml07,
         oml08     LIKE oml_file.oml08,
         oml08t    LIKE oml_file.oml08t,
         oml09     LIKE oml_file.oml09
         END RECORD

   LET l_sql ="SELECT oml02,oml03,'',oml04,oml05,oml06,oml07,",
              " oml08,oml08t,oml09 ", 
              "  FROM oml_file,oma_file ", 
              " WHERE oml01 = oma01 ", 
              "   AND oma01 = '",g_oma.oma01,"'",
              " ORDER BY oml02 "
   PREPARE t300_oml_pre1 FROM l_sql
      IF SQLCA.sqlcode THEN
         CALL cl_err('t300_oml_pre1:',SQLCA.sqlcode,1)
         RETURN
      END IF 
   DECLARE t300_oml_cs1 CURSOR WITH HOLD FOR t300_oml_pre1
   CALL l_oml.clear()
   LET g_cnt = 1
   FOREACH t300_oml_cs1 INTO l_oml[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF 
      SELECT gec02 INTO l_oml[g_cnt].gec02 FROM gec_file
       WHERE gec01 = l_oml[g_cnt].oml03
         AND gec011 = '2'
      LET g_cnt = g_cnt + 1
   END FOREACH
   CALL l_oml.deleteElement(g_cnt)
   LET g_cnt=g_cnt-1
   OPEN WINDOW axrt300_detai_w WITH FORM "axr/42f/axrt300_detai"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
   CALL cl_ui_locale("axrt300_detai")
   DISPLAY g_cnt TO FORMONLY.cn2
   DISPLAY ARRAY l_oml TO s_oml.*  ATTRIBUTE(COUNT=g_rec_b)
      ON ACTION controlg
         CALL cl_cmdask()
   END DISPLAY    
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW axrt300_detai_w
   END IF          
   CLOSE WINDOW axrt300_detai_w
END FUNCTION
###-FUN-B40032- ADD -  END  ---------------------------------------------------
