# Prog. Version..: '5.30.06-13.04.22(00010)'     #
#
# Pattern name...: axrt400.4gl
# Descriptions...: 收款沖帳單維護作業
# Date & Author..: 95/01/12 By Roger
# modify.........: 95/07/10 by nick 當單身借貸間原幣相同但本幣不符時(匯兌損
#                  益),原本不論損或益,display都放在借方.今display時將匯兌損
#                  失放在貸方.notice!只是改本單單身而已,原本的科目就是對的,
#                  並未修改!s_oob04.4gl 也一併加入.
# Modify.........: 95/08/24 by nick 1.擷取nmh,nmg,oma到單身時考慮單頭部門
#                                   2.沖帳金額寫回nmh17(原本nmh放沖帳單號)
#                                   3.可輸入不同客戶的應收帳款及支票
# Modify.....v2.0: 95/11/10 by danny 1.<^P>查詢單別

#                                    2.由TT產生單身時,本幣金額應為nmg25
# Modify....v2.01: 95/12/14 by danny 1.由應收票據產生單身時,若此票據未確認,
#                                      則不可產生於單身
#                                    2.在參考單號後判斷此單據是否已確認
#                                    3.收款沖帳確認時,判斷此單據是否已確認
# Modify.....v3.0: 97/01/23 by roger 增加自動沖帳:3.開窗選擇
# Modify.....v3.0: 97/01/24 by roger 增加 A/P 沖 A/R
# Modify.........: 97/08/08 By Sophia 溢收時確認,取消確認應將參考單號show or
#                                     清為NULL
# Modify.........: 97/08/08 By Sophia 2.其他資料功能取消
# Modify.........: 97/08/26 By Sophia nmg24已改為已沖金額
# Modify.........: No:7837 03/08/19 By Wiky 呼叫自動取單號時應在 Transction中
# Modify.........: No:9046 04/01/12 Kammy No.A058 Let b_oob.oob09 = l_nmh.hmh02 - l_nmh.nmh17 - l_oob09
#                                         所以 line 556 b_oob.oob09 = l_nmh.nmh02 - l_nmh.nmh17 應該 mark掉
# Modify.........: No:9047 04/01/12 Kammy Line 4109條件應多加 and oob04 = '3'
# Modify.........: No:9443 04/04/15 Kitty AR 沖AP 更新apa73有問題
# Modify.........: No:9638 04/06/08 By Kitty 在確認時t400_bu_13: select sum(oob09) 未加上排除已作廢的
# Modify.........: No:9775 04/07/30 ching s_g_np項次傳0得整張未沖
# Modify.........: No.MOD-490095 04/09/06 ching 自動沖帳依開窗挑選default 'N'
# Modify.........: No.MOD-490344 04/09/20 By Kitty Controlp 未加display
# Modify.........: No.MOD-4A0119 04/10/08 ching 新增時,科目分類以 ooz08 default
# Modify.........: No.FUN-4B0017 04/11/02 By ching add '轉Excel檔' action
# Modify.........: No.FUN-4B0056 04/11/24 By ching add 匯率開窗 call s_rate
# Modify ........: No.FUN-4C0013 04/12/01 By ching 單價,金額改成 DEC(20,6)
# Modify.........: No.FUN-4C0049 04/12/09 By Nicola 權限控管修改
# Modify.........: No.MOD-4C0141 04/12/27 ching 取消中文寫死
# Modify.........: No.FUN-4C0100 05/01/10 By Smapmin 報表轉XML格式
# Modify.........: No.MOD-510070 05/03/09 By Kitty TT收款,客戶與axrt400的帳款客戶不同,出現axr-138的錯誤,錯誤訊息寫可以通過但實際確不能過
# Modify.........: No.FUN-530015 05/03/15 By Nicola 匯率自由格式設定
# Modify.........: No.MOD-530225 05/03/24 By Nicola 進入分錄底槁時，lock住單頭資料
# Modify.........: No.MOD-530302 04/03/25 by saki 回傳變數更改
# Modify.........: No.MOD-530346 04/03/28 By Nicola 4.輸入本幣重算原幣應算至原幣小數位數
#                                                   (1)查詢應收賬款時，Ln#2481：CALL q_oma1(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02,g_ooa.ooa01,g_ooa.ooa03,'2*')
#                                                                        應改為 CALL q_oma1(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02,g_ooa.ooa01,g_ooa.ooa03,'1*')
#                                                   (3)查詢收支單時，ln# 2452：LET g_qryparam.where = "" nmg18 ='"",g_ooa.ooa03,""'""
#                                                                         改為 LET g_qryparam.arg1 = g_ooa.ooa03 "
# Modify.........: No.MOD-530820 04/03/29 By Nicola 當離開單身時, 差異處理做為轉溢收, 確認後, 轉預收款 的參考單號沒有顯示在畫面上
# Modify.........: No.FUN-540046 05/04/21 By Nicola TIPTOP與EasyFlow整合
# Modify.........: No.FUN-550037 05/05/13 By saki   欄位comment顯示
# Modify.........: No.FUN-550071 05/05/31 By wujie  單據編號加大
# Modify.........: No.FUN-550131 05/06/03 By Lifeng 料件多屬性修改（1個地方而已）
# Modify.........: No.MOD-560005 05/06/08 By ching fix oob11輸入
# Modify.........: No.FUN-550049 05/06/11 By Echo 新增 TIPTOP 與 EasyFlow 整合
# Modify.........: No.MOD-560007 05/06/11 By Echo 重新定義整合FUN名稱
# Modify.........: No.FUN-560074 05/06/16 By pengu  CREATE TEMP TABLE 欄位放大
# Modify ........: No.FUN-560060 05/06/15 By vivien 單據編號加大返工				
# Modify.........: No.MOD-560077 05/06/17 By ching fix本幣取位
# Modify.........: No.FUN-560095 05/06/18 By ching  2.0功能修改
# Modify.........: No.FUN-560099 05/06/19 By Smapmin 單號未改
# Modify.........: No.FUN-560122 05/07/07 By Nicola 新增修改人員重新帶出部門
# Modify.........: No.MOD-570198 05/08/03 By Yiting AFTER FIELD oob06漏失判斷
# Modify.........: No.FUN-580154 05/08/27 By Dido 以EF為backend engine,由TIPTOP處理前端簽核動作
# Modify.........: No.MOD-580270 05/08/29 By Smapmin 將CONTROLP 之 WHEN INFIELD(ooa15),
#                                            NEXT FIELD ooa15a改為NEXT FIELD ooa15才對
# Modify.........: No.FUN-570099 05/07/26 By Elva 新增欄位ooa00
# Modify.........: No.MOD-590452 05/09/29 By Smapmin 單身類別開窗
# Modify.........: No.FUN-5A0124 05/10/20 By elva 刪除帳款資料時刪除oov_file
# Modify.........: No.MOD-5A0024 05/10/24 By Smapmin 已排除本身資料,故修改時不用再扣掉自己本身的值
# Modify.........: No.TQC-5A0089 05/10/27 By Smapmin 單別寫死
# Modify.........: No.MOD-590440 05/11/03 By ice 依月底重評價對AP未付金額調整,修正未付金額apa73的計算方法
# Modify.........: No.MOD-5B0012 05/11/11 By Smapmin 科目做部門管理才輸入部門欄
# Modify.........: No.MOD-5B0108 05/11/21 By Smapmin 新增參考單號開窗功能
# Modify.........: No.TQC-5B0171 05/11/28 By ice 確認&取消確認更新已收金額時,應考慮發票待扺&直接收款&收款衝帳三部分的異動
# Modify.........: No.MOD-5B0292 05/11/30 By kim 如借貸方項次緊接在一起,則無法產生壞帳沖銷資料
# Modify.........: No.MOD-5C0159 05/12/28 By Smapmin 產生差異時,不需要再連帶判斷借貸方
# Modify.........: No.MOD-610050 06/01/12 By Smapmin 輸入不存在類別時要出現錯誤訊息
# Modify.........: No.MOD-610124 06/01/20 By Smapmin 查詢時沖帳單號開窗有誤
# Modify.........: No.MOD-620011 06/02/09 By Smapmin 單身部門,幣別開窗顯示資料位置有誤
# Modify.........: No.TQC-620114 06/02/23 By Smapmin 新增DROP TABLE
# Modify.........: No.TQC-630066 06/03/07 By Kevin 流程訊息通知功能修改
# Modify.........: No.FUN-630043 06/03/14 By Melody 多工廠帳務中心功能修改
# Modify.........: No.TQC-630086 06/03/30 By Smapmin 借方類別若設定為 1(支票),且nmydmy3 = 'Y' 時取消 axr-066 訊息,將 nmh27 科目放入 oob11
# Modify.........: No.MOD-630069 06/03/30 By Smapmin 修改T.T沖到細項等問題
# Modify.........: No.MOD-640190 06/04/09 By Smapmin 修正MOD-630069
# Modify.........: No.FUN-640246 06/05/02 By Echo 自動執行確認功能
# Modify.........: No.TQC-5C0086 05/12/29 By ice AR月底重評修改 
# Modify.........: No.FUN-5C0014 06/05/29 By rainy 新增欄位oma67存放INVOICE NO.
# Modify.........: No.TQC-660010 06/06/02 By Smapmin 報表列印有誤
# Modify.........: No.FUN-660035 06/06/12 By rainy 產生單身資料及單身after field的check均不可大於單頭 '沖帳日期'
# Modify.........: No.FUN-660116 06/06/19 By ice cl_err --> cl_err3
# Modify.........: No.FUN-660152 06/06/27 By rainy CREATE TEMP TABLE 單號改為char(16)
# Modify.........: No.TQC-670008 06/07/05 By rainy 權限修正
# Modify.........: No.FUN-660216 06/07/11 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.TQC-670085 06/07/24 By cl 1.單身本幣金額、原幣金額檢查時，根據系統參數設置"衝帳至項次"來區別對待.
# Modify.........:                              2.修正單身控制錯誤。
# Modify.........: No.FUN-670026 06/07/26 By Tracy 應收銷退合并
# Modify.........: No.MOD-670042 06/07/26 By Smapmin 修改控管oob15是否輸入的條件
# Modify.........: No.FUN-680006 06/08/03 By kim GP3.5 利潤中心
# Modify.........: No.FUN-670060 06/08/07 By Rayven 新增"直接拋轉總帳"功能
# Modify.........: No.FUN-680022 06/08/14 By cl 多帳期處理
# Modify.........: No.FUN-670047 06/08/21 By cl 多帳套處理
# Modify.........: No.FUN-680123 06/08/29 By hongmei 欄位類型轉換
# Modify.........: No.FUN-6A0095 06/10/27 By xumin l_time轉g_time 
# Modify.........: No.CHI-6A0004 06/10/30 By hongmei g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.FUN-690090 06/11/02 By cl      增加欄位ooa992
# Modify.........: No.FUN-6A0092 06/11/14 By Jackho 新增動態切換單頭隱藏的功能
# Modify.........: No.FUN-6B0042 06/11/17 By jamie 1.FUNCTION _q() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modify.........: No.TQC-6B0067 06/11/30 By chenl 對于貸方帳款,若單據omc_file僅有一筆資料，那在多帳期項次欄位中自動給 1 值
# Modify.........: No.MOD-6A0091 06/12/08 By Smapmin apf13應改帶pmc24
# Modify.........: No.MOD-6B0136 06/12/12 By Smapmin g_dbs_new不應被更改
# Modify.........: No.TQC-6C0072 06/12/13 By chenl 修正分錄底稿報錯后還能通過審核。
# Modify.........: No.FUN-710050 07/01/30 By yjkhero 錯誤訊息匯整
# Modify.........: No.MOD-730023 07/03/07 By Smapmin 調整變數定義大小
# Modify.........: No.TQC-6B0105 07/03/08 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.MOD-730022 07/03/07 By Smapmin 部門編號依據科目是否要做部門管理才產生
# Modify.........: No.MOD-720129 07/03/15 By Smapmin 由T.T產生至單身時,要處理到項次
# Modify.........: No.MOD-730060 07/03/15 By Smapmin 調整COMMIT WORK,ROLLBACK WORK
# Modify.........: No.FUN-730073 07/04/02 By sherry  會計科目加帳套
# Modify.........: No.MOD-740029 07/04/10 By Smapmin 作廢時應刪除分錄
# Modify.........: No.TQC-740094 07/04/16 By Carrier 錯誤匯總功能-修改
# Modify.........: No.TQC-740156 07/04/22 By claire 拋轉傳票,傳票還原拋轉串EF時,action要隱藏
# Modify.........: No.TQC-740145 07/04/23 By johnray s_chknpq傳參錯誤
# Modify.........: No.FUN-740184 07/04/24 By Carrier 生成帳款時,根據收款日期,做新舊科目參照
# Modify.........: No.MOD-740406 07/04/25 By Ray 單身建置借方/類別1支票收款時,項次應為noentry
# Modify.........: No.MOD-740395 07/04/28 By Judy 單身新增時，科目欄位報錯,過原幣金額欄位后不會自動計算本幣金額
# Modify.........: No.MOD-750063 07/05/16 By Smapmin 未沖金額檢核
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.TQC-750177 07/05/29 By rainy   單身自動沖帳，選沖帳至借貸相符，如原本借貸已相等，會產生一筆0的資料
#                                                    單身新增 無法輸入 2.TT收款資料 
#                                                    取消確認未將產生的 預收待抵單號清空
# Modify.........: No.MOD-760119 07/06/27 By Smapmin 抓取應收待抵時,條件必須加上確認碼為'Y'
# Modify.........: No.TQC-770025 07/07/05 By Rayven 衝帳單別為無效時,錄入此單別無控管
# Modify.........: No.MOD-770022 07/07/06 By Smapmin 修改開窗所帶的變數
# Modify.........: No.MOD-780261 07/08/28 By Smapmin 自動帶入單身摘要
# Modify.........: No.MOD-790016 07/09/10 By Smapmin WHERE 條件錯誤
# Modify.........: No.TQC-7B0028 07/11/06 By Carrier q_ooc查詢出重復資料,加入aag00的條件
# Modify.........: No.FUN-7B0055 07/11/14 By Carrier CALL _oox()/s_g_np時考慮多帳期
# Modify.........: No.MOD-7B0254 07/11/29 By Smapmin 收款沖帳類別為1支票時,未帶出科目
# Modify.........: No.MOD-7C0088 07/12/13 By Smapmin 自動產生axrt300待抵資料時,金額抓取方式應與單身輸入時一致.
# Modify.........: No.TQC-810034 08/01/09 By chenl   增加單身控制，同一參考單號及項次，不可同時存在。
# Modify.........: No.CHI-810010 08/01/09 By Sarah   子帳期衝帳時訊息改成用axr-189
# Modify.........: No.FUN-7C0050 08/01/15 By johnray 串查程序代碼添加共用 ACTION 的引用
# Modify.........: No.TQC-810086 08/01/29 By chenl   修正審核時雖報錯，但還能過的錯誤。
# Modify.........: No.FUN-810074 08/01/31 By Smapmin 自動沖帳開窗多加Invoice No欄位
# Modify.........: No.MOD-810222 08/01/31 By Smapmin 判斷已沖帳金額時,應過濾作廢單據
# Modify.........: No.MOD-820134 08/02/27 By Smapmin 自動產生單身沖帳資料,針對應付帳款金額的預設值有誤
# Modify.........: No.MOD-830047 08/03/06 By Smapmin axr-405的錯誤需卡關
# Modify.........: No.MOD-830097 08/03/12 By Smapmin 借方/待抵帳款,確認時回寫多帳期的已沖金額有誤
# Modify.........: No.MOD-840084 08/04/14 By Smapmin 借方類別為4.雜項時,子帳期項次可不必輸入
# Modify.........: No.MOD-830186 08/03/24 By chenl   修正t400_oob09_12()內變量錯誤。
# Modify.........: No.TQC-840066 08/04/28 By Mandy AXD系統欲刪,原使用 AXD 模組相關欄位的程式進行調整
# Modify.........: No.CHI-840051 08/04/28 By Smapmin 抓取應收帳款單身金額時,要依訂金/出貨/尾款的比率來計算
# Modify.........: No.MOD-850039 08/05/06 By Smapmin 產生溢收帳款檔,oma211預設0
# Modify.........: No.MOD-850008 08/05/06 By Smapmin t400_bu_13()/t400_bu_21()確認時回寫多帳期的已沖金額錯誤
# Modify.........: No.MOD-850027 08/05/06 By Smapmin t400_omc()回寫已沖金額時,要加上oob03/oob04的條件
# Modify.........: No.MOD-850006 08/05/06 By Smapmin 修正TQC-810034
# Modify.........: No.FUN-850038 08/05/09 By TSD.lucasyeh 自定欄位功能修改
# Modify.........: No.MOD-850228 08/05/26 By Sarah t400_oob06_11()中,增加判斷若nmh38='N'則提示錯誤訊息axr-194
# Modify.........: No.MOD-850229 08/05/26 By Sarah t400_oob09_12(),t400_oob09_19()中,增加串ooaconf<> 'X'
# Modify.........: No.MOD-850246 08/05/28 By Sarah 進入單身後輸入資料又馬上刪除,移到別筆單身資料時,項次會亂掉
# Modify.........: No.MOD-860078 08/06/10 BY yiting ON IDLE處理
# Modify.........: No.MOD-860075 08/06/10 By Carrier 直接拋轉總帳時，aba07(來源單號)沒有取得值
# Modify.........: No.MOD-860002 08/07/08 By Sarah 轉預收時(oma00='24'),重新讀取g_ooa.*變數
# Modify.........: No.MOD-850161 08/05/15 By chenl   增加更改借貸后對類型的控制.
# Modify.........: No.MOD-870147 08/07/21 By Smapmin 單身修改時,單頭的修改者與修改日期未update
# Modify.........: No.FUN-850143 08/06/02 By lutingting報表轉為使用CR
# Modify.........: No.MOD-880174 08/08/22 By Sarah 判斷axr-371訊息時,直接以oma02與ooa02比較
# Modify.........: No.MOD-880177 08/08/22 By Sarah t400_oob09_19()段,以oob09/oob10與apc08-apc10/apc09-apc11比較判斷axr-185訊息,修改成只以這次要沖金額去比較,不需累計之前沖帳金額
# Modify.........: No.MOD-890104 08/09/17 By Sarah t400_bu_22()段,oma32改用ooa03抓取occ45帶入
# Modify.........: No.MOD-8A0009 08/10/02 By clover 輸入完參考單號後並調整金額B，按下確認，進入差異金額處理選項金額會使用新值
# Modify.........: No.MOD-8A0111 08/10/14 By chenl  修正本幣金額大于立賬本幣金額不報錯的問題。
# Modify.........: No.FUN-8A0086 08/10/21 By dongbg 修正FUN-710050錯誤
# Modify.........: No.MOD-8A0254 08/10/29 By Sarah apz27(月底重評價當月認列匯差,次月不回轉)為N時oob08=apa14,為Y時oob08=apa72
# Modify.........: No.MOD-8A0256 08/10/29 By Sarah 當匯率調整後需重新計算本幣金額(oob10)
# Modify.........: No.FUN-8A0075 08/11/04 By jan S.送簽時，可再修改以下內容：單頭：科目類別(ooa13)、幣別(ooa23)。/單身：部門(oob13)、科目(oob11、oob111)、類別(oob04)
#                                                并可執行以下功能：【分錄底稿產生、分錄底稿、傳票拋轉、傳票拋轉還原、確認、備注、單身】
# Modify.........: No.MOD-8B0100 08/11/10 By Sarah 單別設成自動編號,但要補之前的單據資料,無法接受
# Modify.........: No.TQC-8B0032 08/11/14 By Sarah CALL s_auto_assign_no()傳入的table請改為ooa_file
# Modify.........: No.MOD-8B0213 08/11/20 By clover axr-405錯誤訊息應該是在輸入日期小於重評價年月時才出現
# Modify.........: No.MOD-8B0210 08/11/21 By Sarah 1.t400_oob09_19()計算l_oob09,l_oob10的SQL應抓ooaconf='N'的資料
#                                                  2.若oob04='9'時,oob15預設值為0,無須維護
# Modify.........: No.MOD-8C0102 08/12/11 By Sarah 將MOD-8A0256增加抓t_azi04的程式段mark
# Modify.........: No.FUN-8C0089 09/01/05 By jamie 依參數控管,檢查會科/部門/成本中心 AFTER FIELD 
# Modify.........: No.MOD-910070 09/01/13 By sherry 單身匯率沒有按幣別檔設置取位人工輸入和自動衝賬都不會進行取位
# Modify.........: No.MOD-910126 09/01/12 By chenl 若應收票據當月不認列匯差或為本幣時，調整nmh40計算方式。
# Modify.........: No.MOD-910107 09/01/14 By Sarah 若沖帳時是沖anmt302,應先以nmg11到部門主檔抓其成本中心(gem10),若有則應代入成本中心,若無則代入部門
# Modify.........: No.MOD-920163 09/02/12 By Sarah 當科目不做部門管理時,應將部門欄位清空,並不允許進入部門欄位
# Modify.........: No.MOD-920178 09/02/16 By chenyu 查詢單據時，單身的原幣金額，本幣金額和摘要這三個欄位無法錄入
# Modify.........: No.MOD-930140 09/03/23 By chenl 更新omc檔時，未考慮月底重評價。
# Modify.........: No.MOD-940156 09/04/10 By Sarah 輸入支票收款類別的參考單號後,檢查該單別是否要拋傳票(nmydmy3),若為N才允許輸入
# Modify.........: No.MOD-940238 09/04/17 By lilingyu 將MOD-910070修改部分還原
# Modify.........: No.MOD-940262 09/04/20 By Sarah 當原幣沖完但本幣未沖時,請提示訊息
# Modify.........: No.MOD-940277 09/04/22 By lilingyu 1.自動衝賬需排除已經衝賬完畢的賬款
# Modify..............................................2.4gl里在給予oob08值時,根據apz27的值來決定是抓匯率還是抓重估匯率
# Modify.........: NO.MOD-940291 09/04/24 By lilingyu 收款衝賬,項次會造成跳號
# Modify.........: NO.MOD-940355 09/04/27 By lilingyu 若已有先做一筆衝賬,還有余額未衝,再做第二筆衝賬時會出現axr-185的錯誤信息
# Modify.........: NO.MOD-940420 09/05/05 By lilingyu 單身人工輸入參考單號時,應予選擇的類別進行檢核,性質不同不應該可以存檔,且在確認段應檢核
# Modify.........: NO.MOD-950129 09/05/13 By lilingyu 當單身資料是有來源單據時,在按下確認新增之前,應控管其"參考項次oob15"不可為空值
# Modify.........: NO.MOD-950132 09/05/13 By wujie    計算未稅前，oob15沒有清空
# Modify.........: No.TQC-950020 09/05/13 By mike 跨庫的SQL語句一律使用s_dbstring()的寫法 
# Modify.........: No.MOD-950237 09/05/22 By lilingyu 單身第2個項次,如果更新項次一直tab到原幣金額會出現錯誤訊息
# Modify.........: No.FUN-960141 09/06/23 By dongbg GP5.2修改
# Modify.........: No.MOD-960345 09/06/29 By Sarah 將MOD-940156修改調回
# Modify.........: No.MOD-970197 09/07/22 By mike 請款單在axrt400衝帳后,在aapt120右邊衝帳查詢點開后目前是查不到資料的,              
#                                                 應該要可以查詢的到axrt400衝銷的資料.  
# Modify.........: No.MOD-970255 09/07/29 By mike 當應收參數設定為衝至應收細項，於axrt400的自動衝帳功能，會將oob19設為null，        
#                                                 導致axrt400確認時沒有回寫omc多帳期的資料，使AR帳齡相關報表皆抓不出正確的值。      
# Modify.........: No.FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.TQC-810036 09/08/19 By xiaofeizhu 拋轉憑証時，傳入參數內的user應為資料所有者
# Modify.........: No.MOD-980263 09/08/31 By mike 在INSERT INTO oma_file前,給予oma64預設值"0"    
# Modify.........: No.MOD-980216 09/09/09 By liuxqa 修正TT衝向細項問題。
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-980020 09/09/10 By douzh GP5.2集團架構sub相關修改
# Modify.........: No.TQC-970232 09/07/23 By baofei 修改新增完后列印簡表報錯  
# Modify.........: No.MOD-990040 09/09/04 By Sarah 修正MOD-950129,改成判斷g_ooz.ooz62='Y'時將oob15設為required欄位
# Modify.........: No.MOD-980159 09/10/14 By sabrina 已撤票或退票票況的應收票據應不可作應收沖帳
# Modify.........: No.MOD-9A0001 09/10/14 By sabrina 不同幣別沖帳，有溢收產生時，原幣金額為負數，造成日後無法沖帳
# Modify.........: No.FUN-990031 09/10/26 By lutingting GP5.2營運中心調整，拿掉單身營運中心欄位,因為立帳會丟到dsall所以不需要去不同得營運中心抓資料
# Modify.........: No:MOD-9A0189 09/11/02 By Sarah 更新omc_file後請判斷SQLCA.SQLCODE與SQLCA.SQLERRD[3]看是否更新成功
# Modify.........: No:MOD-9A0204 09/11/02 By Sarah 單身沒有輸入資料的時候,單頭的"帳款客戶"欄位應該要可以修改
# Modify.........: No.FUN-9B0044 09/11/06 By wujie   5.2SQL转标准语法
# Modify.........: NO:MOD-9B0046 09/11/09 By Sarah 單身人工輸入參考單號時,待抵帳款應可輸入25類帳款
# Modify.........: No.FUN-9B0106 09/11/19 By kevin 用s_dbstring(l_dbs CLIPPED) 判斷跨資料庫
# Modify.........: No.FUN-9B0130 09/11/30 By lutingting 賬款可輸入15類賬款
# Modify.........: NO:MOD-9C0022 09/12/03 By Dido 差異幣別為本幣時 oob09 應與 oob10 相同 
# Modify.........: No:TQC-9C0057 09/12/09 By Carrier 状况码赋值
# Modify.........: No.FUN-9C0061 09/12/11 By lutingting 單身人工輸入參考單號時,待抵帳款應可輸入26類帳款
# Modify.........: No:TQC-9C0099 09/12/16 By jan 程序調整
# Modify.........: No:MOD-9C0320 09/12/21 By Sarah 自動產生單身選3.開窗挑選,挑完確定後回到單身發現產生出來的資料不只挑選的那幾筆
# Modify.........: No.TQC-9C0179 09/12/29 By tsai_yen EXECUTE裡不可有擷取字串的中括號[]
# Modify.........: No.FUN-9C0072 10/01/07 By vealxu 精簡程式碼
# Modify.........: No:MOD-A10084 10/01/14 By Sarah 同一筆應收帳款不同的子帳期應能在同一張收款沖帳做沖帳
# Modify.........: No.FUN-A10086 10/01/18 By wujie  axrt4004增加开窗
# Modify.........: No:MOD-A10120 10/01/22 By sabrina axr-206應多判斷單頭ooaconf條件 
# Modify.........: No:MOD-9C0436 10/02/04 By sabrina 拋轉傳票判斷修改
# Modify.........: No:TQC-A20009 10/02/22 By lutingting 賬款可輸入17類賬款 
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No.MOD-A30106 10/03/17 by sabrina 待抵自動沖帳時不應抓出帳款類別25且oma16為空的單據
# Modify.........: No.MOD-A30146 10/03/23 by sabrina apa_file增加apa02 <= ooa02條件
# Modify.........: No.CHI-A30007 10/03/25 by Dido 折讓差異時,增加產生一筆匯兌損益 
# Modify.........: No.FUN-A30106 10/03/30 by wujie   增加凭证联查功能
# Modify.........: No.FUN-A40001 10/04/01 By lutingting 科目類型新增借方:E聯盟卡 Q券 貸方：B轉收入
# Modify.........: No.MOD-A40023 10/04/07 by sabrina 單身選擇1：借方 3：待抵帳款，在AFTER FIELD oob06後並未將子帳期項次帶出
# Modify.........: No.TQC-A40132 10/04/27 By lilingyu 應收退款功能拆至axrt410作業,移除相關判斷
# Modify.........: No.MOD-A50027 10/05/06 by sabrina 新增單身勾選T/T/及待抵帳款產生沖帳資料，待抵帳款沒有摘要但卻寫入收支單的摘要
# Modify.........: No.MOD-A50047 10/05/06 by sabrina axr-993應包含l_apa00!='13'之判斷 
# Modify.........: No.FUN-A40076 10/05/10 by xiaofeizhu 應收調帳
# Modify.........: No.MOD-A50055 10/05/12 by sabrina 當aza63='N'時才傳where 條件 
# Modify.........: No.MOD-A50074 10/05/12 by sabrina FUNCTION t400_acct_code()不應判斷金額>0 
# Modify.........: No.MOD-A50061 10/05/14 by sabrina 執行單身再執行"自動沖帳"，選擇開窗挑選，勾選帳款時，欲沖帳原幣/本幣合計未即時更新 
# Modify.........: No.MOD-A50085 10/05/14 by sabrina 新增時，單頭「科目類別」應優先取客戶基本資料中的科目類別才合理 
#                                                    取用順序：1.客戶基本資料  2.應收系統參數設定(ooz08)
# Modify.........: No.MOD-A40182 10/06/21 by wujie  oob06_13()中mark axr-353的判断
# Modify.........: No.FUN-A50102 10/06/22 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:FUN-A50103 10/06/03 By Nicola 訂單多帳期 
# Modify.........: No.MOD-A60193 10/06/29 by Dido 取消 oma16 條件 
# Modify.........: No.MOD-A70047 10/07/06 by Dido 調整清空 oob12 即可 
# Modify.........: No:CHI-A70015 10/07/06 By Nicola 需考慮無訂單出貨
# Modify.........: No.MOD-A70074 10/07/09 by Dido 產生溢收時,需更新分錄底稿的 npq23 
# Modify.........: No.FUN-A60056 10/07/09 By lutingting GP5.2財務串前段問題整批調整
# Modify.........: No.MOD-A70114 10/07/27 by sabrina 判斷子帳期資料是否存在，錯誤訊息應用"aap-777"
# Modify.........: No.MOD-A50200 10/07/27 by sabrina 按確認後，確認碼及狀態碼沒有及時更新顯示在畫面上 
# Modify.........: No.MOD-A80012 10/08/03 by Dido 支票自動產生抓取變數調整 
# Modify.........: No.TQC-A80060 10/08/12 by xiaofeizhu 修改axrt400的SQL錯誤
# Modify.........: No.MOD-A80144 10/08/20 by Dido 錯誤時調整關閉視窗與 cursor  
# Modify.........: No.MOD-A80164 10/08/23 by Dido 收支資料自動產生時oob14應為null  
# Modify.........: No.MOD-A80175 10/08/25 by Dido 匯兌損益幣別應為本國幣別  
# Modify.........: No.MOD-A80195 10/08/26 by Dido 自動產生應排除金額為 0 的單據  
# Modify.........: No.FUN-A40078 10/08/27 By vealxu 提供整批沖帳確認功能
# Modify.........: No.MOD-A80219 10/08/30 by Dido 輸入參考單號後,若ooz62 = 'Y'時應跳至參考項次中  
# Modify.........: No.FUN-A90003 10/09/01 by xiaofeizhu 改成雙單身
# Modify.........: No.MOD-A80247 10/09/01 by Dido 當 ooz07 = 'Y' 應使用 omc13 判斷上 
# Modify.........: No:TQC-A90057 10/09/20 By Carrier q_ooa 加传参
# Modify.........: No:MOD-A20006 10/10/11 By sabrina 收款沖帳取消確認時，應判斷其應收帳款若為「訂金應收」，其產生之預收待抵
# Modify.........: No:MOD-AA0119 10/10/20 By wujie  审核回写应收帐款时，没有将发票待抵维护的金额回写到omc中
# Modify.........: No:MOD-AA0154 10/10/26 By Dido 增加作廢判斷 
# Modify.........: No:MOD-AB0062 10/11/05 By Dido 勾選取消應重新計算單身合計 
# Modify.........: No:CHI-A80031 10/11/25 By Summer 整批確認時,其他單號的資料也需檢查 
# Modify.........: No:FUN-AB0034 10/12/16 By wujie   oma73/oma73f预设0
# Modify.........: No:MOD-AC0152 10/12/17 By Carrier 自动产生借方单身时,把nmydmy3='N'的限制拿掉
# Modify.........: No:MOD-AC0166 10/12/20 By Dido t400_diff 函式中若為 RETURN 需有回傳值
# Modify.........: No:MOD-AC0302 11/01/05 By lixia 修改t400_bu_22(p_sw,p_cnt)中oma68的值
# Modify.........: No:MOD-B10081 11/01/11 By Dido 自動產生應付帳款時 oob01,oob02 未給值 
# Modify.........: No:MOD-B10083 11/01/12 By Dido 相關應收參數應用 ooz07,應付才為 apz27 
# Modify.........: No:FUN-AA0088 11/01/12 By wujie 调帐修改 & yinhy 科目查询自动过滤
# Modify.........: No:CHI-B10042 11/02/09 By Summer 將upd()段判斷狀況碼要為1.已核准才可以確認的段落往上搬到chk()段 
# Modify.........: No:MOD-B20108 11/02/22 By Dido axr-995應包含l_apa00!='25'之判斷 
# Modify.........: No:CHI-B20040 11/02/25 By Dido 若沖應付帳款,應檢核收款日是否小於應付關帳日 
# Modify.........: No.MOD-B30259 11/03/15 By lutingting 贷方单身类型显示错误
# Modify.........: No.FUN-B30057 11/03/15 By zhangweib 增加功能鍵控制第一單身及第二單身
# Modify.........: No.MOD-B30565 11/03/17 By lutingting 重新過單
# Modify.........: No:MOD-B30579 11/03/16 By Sarah 自動沖帳開窗勾選,按放棄時資料還是會寫入oob_file
# Modify.........: No:TQC-B30221 11/03/31 By yinhy 調整只有借貸方都有資料的時候才會差異處理
# Modify.........: No:TQC-B40004 11/04/01 By yinhy 刪除一筆資料，畫面單身二的資料未清空掉
# Modify.........: No:CHI-B30061 11/04/07 By zhangweib 去掉單身中的借方、貸方欄位，直接給預設值
# Modify.........: No:MOD-B40033 11/04/08 By Dido 多幣別沖帳時,單身幣別控制調整 
# Modify.........: No.FUN-B40029 11/04/13 By xianghui 修改substr
# Modify.........: No:CHI-8A0018 11/04/25 By Dido 若訂單結案則可沖預收待抵 
# Modify.........: No:MOD-B40214 11/04/27 By Sarah 自動產生完單身後,CALL b_fill()重新顯示單身資料
# Modify.........: No:MOD-B40253 11/04/28 By Dido oob10調整後若匯率不可異動者不須重算匯率 
# Modify.........: No:MOD-B50053 11/05/06 By wujie oma68被错误的赋值0
# Modify.........: No:MOD-B50045 11/05/10 By Dido 更改後新增時,ooa03無法輸入 
# Modify.........: No:FUN-B40056 11/05/12 By guoch 刪除資料時一併刪除tic_file的資料
# Modify.........: No:MOD-B50156 11/05/18 By Dido 貸方類別資料有誤 
# Modify.........: No.FUN-B50090 11/05/18 By suncx 財務關帳日期加嚴控管修正
# Modify.........: No.MOD-B60017 11/06/02 By wujie 查询第二单身时查不到资料
# Modify.........: No.MOD-B60022 11/06/03 By Dido 有異動時才需要提示重新產生分錄 
# Modify.........: No.FUN-B50064 11/06/07 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No.MOD-B60058 11/06/08 By wujie 贷方检查待抵金额是否超限有错
# Modify.........: No.MOD-B60078 11/06/09 By wujie BEFORE FIELD oob09_1的检查只有axrt401才走
# Modify.........: No:MOD-B50248 11/06/10 By wujie    修改对axr-995的判断条件
# Modify.........: No:MOD-B60135 11/06/17 By Dido 自動產生時項次需連號 
# Modify.........: No.MOD-B60228 11/06/27 By Sarah 將MOD-A20006增加的檢查段mark
# Modify.........: No.MOD-B60257 11/06/30 By wujie tot5-->tot6
# Modify.........: No.MOD-B60182 11/06/23 By Polly 依FUNCTION t400_oob06_11增加單別是否拋轉傳票再決定使用nmh27或nmh26
# Modify.........: No.MOD-B70009 11/07/04 By Dido 自動產生待抵時,l_ooydmy1變數未給值 
# Modify.........: No.MOD-B70102 11/07/12 By Dido 檢核 t400_oob06_item 應限定條件 
# Modify.........: No:MOD-B70242 11/08/26 By yinhy 單身參考單號欄位應可以錄入單據性質為27,28單據
# Modify.........: No:MOD-B70289 11/08/29 By yinhy 審核生成益收款時未對oma25賦值
# Modify.........: No:FUN-B80072 11/08/08 By Lujh 模組程序撰寫規範修正
# Modify.........: No.MOD-B80099 11/08/11 By johung 進單身時，omc_file有多筆才NEXT FIELD oob19
#                                                   在AFTER ROW有用到g_oob[l_ac]判斷的部分，先判斷l_ac <= g_oob.getLength()
# Modify.........: No.MOD-B80122 11/08/15 By Polly 1.帳款類別為23，取消確認時，需將已收帳款沖回
#                                                  2.修正axr-188應停留在NEXT FIELD oob06 
# Modify.........: No.MOD-B80292 11/08/29 By Polly 調整oob15設為required的條件
# Modify.........: No.MOD-B90075 11/09/09 By wujie update ooaconf =Y后移，避免回写待抵帐款已冲金额错误
# Modify.........: No.TQC-B90160 11/09/22 By wujie 修正MOD-B90075
# Modify.........: No.MOD-B90129 11/09/22 By Polly FUNCTION t400_b2() 時，如果貸方筆數>=0就跳出差異處理(axrt4001視窗)
# Modify.........: No.MOD-BA0089 11/10/12 By yinhy 更改時再進入到單身編輯狀態，單身過參考單號欄位的時候，原幣金額就會被改變
# Modify.........: No.CHI-BA0037 11/10/17 By Dido 寫入 s_omab 後再刪除不屬於本次 s_omab 範圍內的 omab_tmp 資料 
# Modify.........: No.TQC-BA0089 11/10/17 By yinhy axrt401未提供打印
# Modify.........: No.MOD-BA0195 11/10/26 By yinhy 第二單身科目編號未能帶出
# Modify.........: No.MOD-BA0189 11/10/30 By Dido 新增輸入段給予帳別改在 BEFORE INPUT
# Modify.........: No.MOD-BB0016 11/11/03 By Polly 新增檢核axrt-413和取位
# Modify.........: No.MOD-BB0086 11/11/08 By Polly 1.增加判斷ooa15為null，才帶預設值
#                                                  2.CALL t400_oob06_1_2()如有錯誤NEXT FIELD oob06_1
# Modify.........: No.MOD-BB0149 11/11/15 By Dido 取消確認段待抵回寫處理邏輯調整
# Modify.........: No.MOD-BB0208 11/11/17 By Polly 調整axr-193、mfg-012不控卡，不可修改本幣金額
# Modify.........: No.MOD-BA0225 11/10/31 By yinhy 收款單身參考單號欄位開窗，選擇單號后，确定，作業死循環
# Modify.........: No.TQC-BB0003 11/11/09 By yinhy 查詢時，資料建立者，資料建立部門無法下查詢條件
# Modify.........: No.MOD-BB0332 11/12/01 By Dido 抓取單身時若 g_wc2/g_wc3 為null時應給予 1=1 
# Modify.........: No.MOD-BC0094 11/12/12 By Polly 產生溢收時，自動給予oma70=1值(系統自動產生)
# Modify.........: No.MOD-BC0248 11/12/27 By Polly 確認時未設定溢收帳款單別，提示錯誤mfg-059
# Modify.........: No.MOD-BC0274 11/12/28 By Polly 寫入omab_tmp排除沖帳日之後的應收帳款
# Modify.........: No.TQC-BC0211 11/12/31 By wujie 自动产生AP来源单身时与手工录入一样生成参考单据二 
# Modify.........: No:FUN-C10039 12/02/02 by Hiko 整批修改資料歸屬設定
# Modify.........: No.FUN-C20018 12/02/03 By wangrr 提供待抵帳款變更
# Modify.........: No.FUN-C20063 12/02/12 By wangrr 修改ooa40字段長度
# Modify.........: No:FUN-C20030 12/02/14 By Abby EF功能調整-客戶不以整張單身資料送簽問題
# Modify.........: No.TQC-C20174 12/02/14 By wangrr 當axrt401確認時判斷ooz30是否有值
# Modify.........: No.TQC-C20269 12/02/20 By wangrr 審核判斷單別時更具不同情況進行判斷
# Modify.........: No:MOD-C10214 12/02/02 By Polly 調整順序，先show出錯誤訊息後再RETURN
# Modify.........: No:MOD-C20036 12/02/07 By Polly 應付帳款部分需增加扣 apc14(原幣)/apc15(本幣) 部分
# Modify.........: No:TQC-C20416 12/02/23 By yinhy AFTER FIELD及自动产生单身控卡nmh24為5.转付类型的
# Modify.........: No.TQC-C20346 12/02/23 By lutingting 待抵調賬修改
# Modify.........: No.TQC-C20430 12/02/24 By wangrr 刪除操作時更新對應單據的財務編號
# Modify.........: No.TQC-C20464 12/02/24 By minpp 第二單身的oob11應該顯示為科目，只有axrt401 走中間過渡科目時才顯示科目分類碼
# Modify.........: No:MOD-C20199 12/02/23 By yinhy 當貸方單身選擇應收賬款單據後，出現報錯axr-193
# Modify.........: No:MOD-C30058 12/03/06 By yinhy 修正MOD-C20199
# Modify.........: No:TQC-C30134 12/03/08 By yinhy 轉付類型單據可以沖帳
# Modify.........: No:FUN-C30140 12/03/12 By Mandy (1)TIPTOP端簽核時,以下ACTION應隱藏[收款單身,detail_b2]
#                                                  (2)送簽中,應不可執行ACTION[更改,收款單身,帳款單身,產生分錄底稿]
# Modify.........: No:MOD-C30616 12/03/13 By Polly 增加確認控卡，需要產生分錄的單別，在尚未產生分錄前不可確認
# Modify.........: No:MOD-C30667 12/03/16 By wangrr axrt401中間過帳時oob11_1顯示為科目分類碼 
# Modify.........: No:FUN-C30029 12/03/19 By wangrr 增加來源類型ooa38字段，當爲零售業時顯示
# Modify.........: No:MOD-C30743 12/04/11 By yinhy BEFORE FIELD oob19_1段會產生死循環
# Modify.........: No:MOD-C30853 12/03/26 By Polly 貸方類別 9 時,匯率不可修改
# Modify.........: No:MOD-C40139 12/04/19 By Elise 增加判斷,若匯率為 1 時,則原幣與本幣如果不同則提示 agl-926 錯誤訊息
# Modify.........: No.FUN-C10024 12/05/21 By minpp 帳套取歷年主會計帳別檔tna_file
# Modify.........: No.CHI-C30107 12/06/12 By yuhuabao  整批修改將確認的詢問窗口放到chk段的前面
# Modify.........: No.FUN-C30085 12/07/06 By lixiang 改CR報表串GR報表
# Modify.........: No.TQC-C70059 12/07/09 By lujh oob_file中沒有oob09_1等的字段,只是程序畫面上區分借貸別的 
# Modify.........: No.FUN-BB0100 12/07/20 By yinhy axrt401提供列印報表
# Modify.........: No.MOD-C80092 12/08/04 By Polly 調整axr-204控卡條件
# Modify.........: No:TQC-C20026 12/09/05 By wangwei axrt400中第二單身oob11_1欄位應顯示科目
# Modify.........: No.MOD-C90154 12/09/21 By Polly axr-204應以原幣要無差異才做匯兌損益、agl-926應排除匯兌損益
# Modify.........: No:MOD-C90151 12/09/21 By Polly 調整批次產生分錄時，只詢問一次是否產生分錄即可
# Modify.........: No:MOD-C90201 12/09/24 By Polly 調整沖帳號確認後，不需產生雜項應收款分錄
# Modify.........: No.CHI-C90052 12/10/02 By Lori 取消確認需在傳票拋轉還原成功後才執行
# Modify.........: No.MOD-CA0093 12/10/17 By Polly 1.調整詢問是否產生分錄只需詢問一次2.自動沖帳增加項次條件選項
# Modify.........: No.FUN-CB0019 12/11/06 By Carrier 新增时,若符合条件的单别只有一个,则自动带出此单别,不做开窗挑选
# Modify.........: No.MOD-CA0044 12/10/05 by Polly 調整無貸方直接確認會有當掉錯誤
# Modify.........: No.MOD-CA0169 12/10/26 By Polly 自動沖帳時，如有二筆金額存入時，已沖金額只需扣除一次即可
# Modify.........: No.MOD-CA0236 12/11/06 By Polly 調整判斷詢問是否要重新產生分錄底稿
# Modify.........: No.MOD-CC0005 12/12/03 By yinhy 點"列印"按鈕后，增加退出功能
# Modify.........: No.MOD-CB0277 12/12/05 By Polly 相關呼叫s_get_bookno傳入變數改用沖帳日期(ooa02)
# Modify.........: No.MOD-CB0284 12/12/05 By Polly 抓取筆數前統一先將l_cnt歸零
# Modify.........: No.MOD-CC0054 12/12/07 By yinhy 單身二賬款日期默認為單頭沖帳日期
# Modify.........: No.MOD-CC0090 12/12/14 By Polly 單身【類別】輸入axri040的常用科目，則不可開放參考單號oob06輸入
# Modify.........: No.FUN-CB0080 13/01/10 By wangrr 9主機追單到30主機31區, 增加资料清单
# Modify.........: No.MOD-D10071 13/01/10 By apo 單身二增加抓取幣別、匯率預設值
# Modify.........: No.MOD-D10102 13/01/11 By yinhy 產生應收賬款oma16未賦值
# Modify.........: No.CHI-D10042 13/01/22 By apo 修改人員後應該重新取得部門，取消ooa15為null的判斷
# Modify.........: No.CHI-D10049 13/01/29 By apo 新帳款部分的"科目"(oob11_1),在"科目型態"(oob26_1)選完後自動帶出
# Modify.........: No.FUN-D10098 13/02/04 By lujh 大陸版本用gxrg440
# Modify.........: No.FUN-D20035 13/02/19 By nanbing 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No.FUN-D10058 13/03/07 By lujh aza69不勾選時，隱藏oma992
# Modify.........: No.FUN-D10057 13/03/07 By wangrr 增加ACTION"雜項應查詢"
# Modify.........: No:FUN-D30032 13/04/02 By fengrui 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No.FUN-D40089 13/04/23 By zhangweib 批次審核的報錯,加show單據編號
# Modify.........: No:MOD-D60149 13/06/19 By yinhy q_oma4增加币种传参
# Modify.........: No.FUN-D70029 13/07/29 By wangrr 借方類型oob04增加'H:帳扣費用'
# Modify.........: NO:FUN-D80031 13/08/13 By yuhuabao 添加H類型的可維護 axrt300中的類型為20.待抵扣帳費用單
# Modify.........: NO:TQC-D80042 13/08/30 By yuhuabao 類型為H的時候 更新應收前，應該判斷參考單號是否為空
# Modify.........: NO:FUN-D90016 13/09/05 By yangtt 如果為外幣，更改狀態下，沖帳日期更改時不允許跨月
# Modify.........: NO:TQC-DA0003 13/10/08 By zhangweib 沖帳扣待抵單選擇類型應該是3而不是H
# Modify.........: NO:MOD-DA0183 13/10/28 By yinhy 貸方類型為應收增加10類型

DATABASE ds
 
GLOBALS "../../config/top.global"
 
#模組變數(Module Variables)
DEFINE g_ooa            RECORD LIKE ooa_file.*,
       g_ooa_t          RECORD LIKE ooa_file.*,
       g_ooa_o          RECORD LIKE ooa_file.*,
       g_ooa01_t        LIKE ooa_file.ooa01,   #(舊值) #CHI-A80031 add
       g_artype         LIKE type_file.chr2,               #No.FUN-680123 VARCHAR(2),
       b_oob            RECORD LIKE oob_file.*,
       g_oob            DYNAMIC ARRAY OF RECORD            #程式變數(Program Variables)
                           oob02     LIKE oob_file.oob02,
                           oob03     LIKE oob_file.oob03,
                           oob04     LIKE oob_file.oob04,
                           oob04_d   LIKE type_file.chr20,                            #No.FUN-680022 add
                           oob06     LIKE oob_file.oob06,
                           oob19     LIKE oob_file.oob19,   #No.FUN-680022 add
                           oob15     LIKE oob_file.oob15,
                           oob11     LIKE oob_file.oob11,
                           oob111    LIKE oob_file.oob111,  #No.FUN-670047 add
                           oob13     LIKE oob_file.oob13,
                           oob14     LIKE oob_file.oob14,
                           oob07     LIKE oob_file.oob07,
                           oob08     LIKE oob_file.oob08,
                           oob09     LIKE oob_file.oob09,
                           oob10     LIKE oob_file.oob10,
                           oob12     LIKE oob_file.oob12,
                           oobud01   LIKE oob_file.oobud01,
                           oobud02   LIKE oob_file.oobud02,
                           oobud03   LIKE oob_file.oobud03,
                           oobud04   LIKE oob_file.oobud04,
                           oobud05   LIKE oob_file.oobud05,
                           oobud06   LIKE oob_file.oobud06,
                           oobud07   LIKE oob_file.oobud07,
                           oobud08   LIKE oob_file.oobud08,
                           oobud09   LIKE oob_file.oobud09,
                           oobud10   LIKE oob_file.oobud10,
                           oobud11   LIKE oob_file.oobud11,
                           oobud12   LIKE oob_file.oobud12,
                           oobud13   LIKE oob_file.oobud13,
                           oobud14   LIKE oob_file.oobud14,
                           oobud15   LIKE oob_file.oobud15
                        END RECORD,
       g_oob_t          RECORD
                           oob02     LIKE oob_file.oob02,
                           oob03     LIKE oob_file.oob03,
                           oob04     LIKE oob_file.oob04,
                           oob04_d   LIKE type_file.chr20,                             #No.FUN-680022 add
                           oob06     LIKE oob_file.oob06,
                           oob19     LIKE oob_file.oob19,  #No.FUN-680022 add
                           oob15     LIKE oob_file.oob15,
                           oob11     LIKE oob_file.oob11,
                           oob111    LIKE oob_file.oob111, #No.FUN-670047 add
                           oob13     LIKE oob_file.oob13,
                           oob14     LIKE oob_file.oob14,
                           oob07     LIKE oob_file.oob07,
                           oob08     LIKE oob_file.oob08,
                           oob09     LIKE oob_file.oob09,
                           oob10     LIKE oob_file.oob10,
                           oob12     LIKE oob_file.oob12,
                           oobud01   LIKE oob_file.oobud01,
                           oobud02   LIKE oob_file.oobud02,
                           oobud03   LIKE oob_file.oobud03,
                           oobud04   LIKE oob_file.oobud04,
                           oobud05   LIKE oob_file.oobud05,
                           oobud06   LIKE oob_file.oobud06,
                           oobud07   LIKE oob_file.oobud07,
                           oobud08   LIKE oob_file.oobud08,
                           oobud09   LIKE oob_file.oobud09,
                           oobud10   LIKE oob_file.oobud10,
                           oobud11   LIKE oob_file.oobud11,
                           oobud12   LIKE oob_file.oobud12,
                           oobud13   LIKE oob_file.oobud13,
                           oobud14   LIKE oob_file.oobud14,
                           oobud15   LIKE oob_file.oobud15
                        END RECORD,
#FUN-A90003--Add--Begin--#                        
       g_oob_d          DYNAMIC ARRAY OF RECORD            
                           oob02_1     LIKE oob_file.oob02,
                           oob03_d     LIKE oob_file.oob03,
                           oob04_1     LIKE oob_file.oob04,
                           oob04_1_d   LIKE type_file.chr20,                            
                           oob06_1     LIKE oob_file.oob06,
                           oob19_1     LIKE oob_file.oob19,   
                           oob15_1     LIKE oob_file.oob15,
#No.FUN-AA0088 --begin
                           oob24_1     LIKE oob_file.oob24,
                           occ02       LIKE occ_file.occ02,
                           oob27_1     LIKE oob_file.oob27,
                           oob25_1     LIKE oob_file.oob25,
                           oob26_1     LIKE oob_file.oob26,
                           ooc02       LIKE ooc_file.ooc02,
#No.FUN-AA0088 --end
                           oob11_1     LIKE oob_file.oob11,
                           oob111_1    LIKE oob_file.oob111,  
                           oob13_1     LIKE oob_file.oob13,
                           oob14_1     LIKE oob_file.oob14,
                           oob07_1     LIKE oob_file.oob07,
                           oob08_1     LIKE oob_file.oob08,
                           oob09_1     LIKE oob_file.oob09,
                           oob10_1     LIKE oob_file.oob10,
                           oob12_1     LIKE oob_file.oob12,
                           oobud01_1   LIKE oob_file.oobud01,
                           oobud02_1   LIKE oob_file.oobud02,
                           oobud03_1   LIKE oob_file.oobud03,
                           oobud04_1   LIKE oob_file.oobud04,
                           oobud05_1   LIKE oob_file.oobud05,
                           oobud06_1   LIKE oob_file.oobud06,
                           oobud07_1   LIKE oob_file.oobud07,
                           oobud08_1   LIKE oob_file.oobud08,
                           oobud09_1   LIKE oob_file.oobud09,
                           oobud10_1   LIKE oob_file.oobud10,
                           oobud11_1   LIKE oob_file.oobud11,
                           oobud12_1   LIKE oob_file.oobud12,
                           oobud13_1   LIKE oob_file.oobud13,
                           oobud14_1   LIKE oob_file.oobud14,
                           oobud15_1   LIKE oob_file.oobud15
                        END RECORD,
       g_oob_d_t        RECORD            
                           oob02_1     LIKE oob_file.oob02,
                           oob03_d     LIKE oob_file.oob03,
                           oob04_1     LIKE oob_file.oob04,
                           oob04_1_d   LIKE type_file.chr20,                            
                           oob06_1     LIKE oob_file.oob06,
                           oob19_1     LIKE oob_file.oob19,   
                           oob15_1     LIKE oob_file.oob15,
#No.FUN-AA0088 --begin
                           oob24_1     LIKE oob_file.oob24,
                           occ02       LIKE occ_file.occ02,
                           oob27_1     LIKE oob_file.oob27,
                           oob25_1     LIKE oob_file.oob25,
                           oob26_1     LIKE oob_file.oob26,
                           ooc02       LIKE ooc_file.ooc02,
#No.FUN-AA0088 --end
                           oob11_1     LIKE oob_file.oob11,
                           oob111_1    LIKE oob_file.oob111,  
                           oob13_1     LIKE oob_file.oob13,
                           oob14_1     LIKE oob_file.oob14,
                           oob07_1     LIKE oob_file.oob07,
                           oob08_1     LIKE oob_file.oob08,
                           oob09_1     LIKE oob_file.oob09,
                           oob10_1     LIKE oob_file.oob10,
                           oob12_1     LIKE oob_file.oob12,
                           oobud01_1   LIKE oob_file.oobud01,
                           oobud02_1   LIKE oob_file.oobud02,
                           oobud03_1   LIKE oob_file.oobud03,
                           oobud04_1   LIKE oob_file.oobud04,
                           oobud05_1   LIKE oob_file.oobud05,
                           oobud06_1   LIKE oob_file.oobud06,
                           oobud07_1   LIKE oob_file.oobud07,
                           oobud08_1   LIKE oob_file.oobud08,
                           oobud09_1   LIKE oob_file.oobud09,
                           oobud10_1   LIKE oob_file.oobud10,
                           oobud11_1   LIKE oob_file.oobud11,
                           oobud12_1   LIKE oob_file.oobud12,
                           oobud13_1   LIKE oob_file.oobud13,
                           oobud14_1   LIKE oob_file.oobud14,
                           oobud15_1   LIKE oob_file.oobud15
                        END RECORD,
#FUN-A90003--Add--End--#                                                
       g_oma            RECORD LIKE oma_file.*,
        g_wc,g_wc2,g_sql string,                         #No.FUN-580092 HCN
       g_t1             LIKE ooy_file.ooyslip,           #No.FUN-680123 VARCHAR(5),        #No.FUN-550071
       g_buf            LIKE type_file.chr20,            #No.FUN-680123 VARCHAR(20),
       g_buf1           LIKE type_file.chr20,            #No.FUN-680123 VARCHAR(20),
       g_ooa31_diff     LIKE ooa_file.ooa31d,
       g_ooa32_diff     LIKE ooa_file.ooa32d,
       g_argv1          LIKE ooa_file.ooa01,              # FUN-580154 沖帳單號
       tot,tot1,tot2    LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       tot3             LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       un_pay1,un_pay2  LIKE type_file.num20_6,           #No.FUN-680123 DEC(20,6),  #FUN-4C0013
       g_yy             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,
       g_mm             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,
       diff_flag        LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),    # 差異處理方式
       g_rec_b          LIKE type_file.num5,              #No.FUN-680123 SMALLINT,   #單身筆數
       l_ac             LIKE type_file.num5,              #No.FUN-680123 SMALLINT,   #目前處理的ARRAY CNT
       p_row,p_col      LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_net            LIKE apv_file.apv04               #MOD-590440
#主程式開始
DEFINE g_forupd_sql     STRING                            #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done   LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_chr            LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
DEFINE g_chr2           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
DEFINE g_chr3           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1) #FUN-580154
DEFINE g_laststage      LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1) #FUN-580154
DEFINE g_change         LIKE type_file.chr1               #MOD-B60022 #檢核是否異動
DEFINE g_cnt            LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_i              LIKE type_file.num5               #No.FUN-680123 SMALLINT   #count/index for any purpose
DEFINE g_msg            LIKE type_file.chr1000            #No.FUN-680123 VARCHAR(72)
DEFINE g_msg1           LIKE type_file.chr1000            #FUN-A40078 
DEFINE g_msg2           LIKE type_file.chr1000            #FUN-A40078
DEFINE g_msg3           LIKE type_file.chr1000            #FUN-A40078
DEFINE g_str            STRING                            #No.FUN-670060
DEFINE g_wc_gl          STRING                            #No.FUN-670060
DEFINE g_dbs_gl         LIKE type_file.chr21              #No.FUN-680123 VARCHAR(21)   #No.FUN-670060
DEFINE l_dbs_new        LIKE type_file.chr21              #No.FUN-680123 VARCHAR(21)   #No.FUN-670060
DEFINE g_row_count      LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_curs_index     LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE g_jump           LIKE type_file.num10              #No.FUN-680123 INTEGER
DEFINE mi_no_ask        LIKE type_file.num5               #No.FUN-680123 SMALLINT
DEFINE g_argv2          STRING                            #No.TQC-630066
DEFINE g_bookno1        LIKE aza_file.aza81               #NO.FUN-730073   
DEFINE g_bookno2        LIKE aza_file.aza82               #NO.FUN-730073   
DEFINE g_flag           LIKE type_file.chr1               #NO.FUN-730073 
DEFINE l_sql            STRING                            #No.FUN-850143
DEFINE l_str            STRING                            #No.FUN-850143
DEFINE l_table          STRING                            #No.FUN-850143
DEFINE g_dbs2           LIKE type_file.chr30  
DEFINE li_result        LIKE type_file.num5
DEFINE g_plant2         LIKE type_file.chr10              #FUN-980020
#No.FUN-A40076 --begin
DEFINE g_oof  DYNAMIC ARRAY OF RECORD                                                                                            
              oof02  LIKE oof_file.oof02,                                                                                         
              oof03  LIKE oof_file.oof03,
              oof032 LIKE oof_file.oof032,
              oof04  LIKE oof_file.oof04,
              oof042 LIKE oof_file.oof042,                                                                                                        
              oof05  LIKE oof_file.oof05,                                                                                         
              oof06  LIKE oof_file.oof06,
              oof10  LIKE oof_file.oof10,
              oof101 LIKE oof_file.oof101,
              oof07  LIKE oof_file.oof07,
              oof08  LIKE oof_file.oof08,
              oof09f LIKE oof_file.oof09f,
              oof09  LIKE oof_file.oof09              
              END RECORD                                                                                                         
DEFINE g_oof_t   RECORD                                                                                            
              oof02  LIKE oof_file.oof02,                                                                                         
              oof03  LIKE oof_file.oof03,
              oof032 LIKE oof_file.oof032,
              oof04  LIKE oof_file.oof04,
              oof042 LIKE oof_file.oof042,                                                                                                        
              oof05  LIKE oof_file.oof05,                                                                                         
              oof06  LIKE oof_file.oof06,
              oof10  LIKE oof_file.oof10,
              oof101 LIKE oof_file.oof101,
              oof07  LIKE oof_file.oof07,
              oof08  LIKE oof_file.oof08,
              oof09f LIKE oof_file.oof09f,
              oof09  LIKE oof_file.oof09                                                                                         
              END RECORD 
DEFINE l_ac1  LIKE type_file.num5
DEFINE g_upd_ok         LIKE type_file.num5               #FUN-A40078 add       
DEFINE g_change_lang    LIKE type_file.chr1               #FUN-A40078 add 
#No.FUN-A40076 --end
DEFINE l_ac2            LIKE type_file.num5               #FUN-A90003 Add
DEFINE g_rec_b2         LIKE type_file.num5               #FUN-A90003 Add
DEFINE g_wc3            STRING                            #FUN-A90003 Add
DEFINE g_b_flag         STRING                            #FUN-A90003 Add
DEFINE g_argv3          STRING                            #No.FUN-AA0088
#No.FUN-AA0088 --begin
DEFINE lwin_curr        ui.Window
DEFINE lfrm_curr        ui.Form
DEFINE lnode_item       om.DomNode
DEFINE ls_msg           LIKE type_file.chr1000
#No.FUN-AA0088 --end
DEFINE g_chkins         LIKE type_file.chr1               #MOD-B60135    #檢核是否新增
DEFINE cb               ui.ComboBox              #TQC-C20430
DEFINE g_flag1          LIKE type_file.chr1               #MOD-CA0093 add
#FUN-CB0080-----add----str
DEFINE g_rec_b1     LIKE type_file.num5
DEFINE g_ooa_1      DYNAMIC ARRAY OF RECORD
                    ooa01     LIKE ooa_file.ooa01,
                    ooa02     LIKE ooa_file.ooa02,
                    ooa03     LIKE ooa_file.ooa03,
                    ooa032    LIKE ooa_file.ooa032,
                    ooa14     LIKE ooa_file.ooa14,
                    gen02     LIKE gen_file.gen02,
                    ooa15     LIKE ooa_file.ooa15,
                    gem02     LIKE gem_file.gem02,
                    ooa23     LIKE ooa_file.ooa23,
                    ooa33     LIKE ooa_file.ooa33,
                    ooaconf   LIKE ooa_file.ooaconf,
                    ooa34     LIKE ooa_file.ooa34
                    END RECORD
DEFINE  l_ac3         LIKE type_file.num5
DEFINE  g_action_flag  STRING
DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode
#FUN-CB0080--add----end---

MAIN
   IF FGL_GETENV("FGLGUI") <> "0" THEN
      OPTIONS                               #改變一些系統預設值
         INPUT NO WRAP
#         FIELD ORDER FORM   #No.FUN-AA0088
   END IF
 
   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("AXR")) THEN
      EXIT PROGRAM
   END IF
 
  #-CHI-B20040-add-
   IF (NOT cl_set_apz_param()) THEN
      RETURN FALSE
   END IF
  #-CHI-B20040-add-

   LET g_artype = ARG_VAL(3)        #No.FUN-AA0088 1-->3
   LET g_argv1 = ARG_VAL(1)
   LET g_argv2=ARG_VAL(2)           #No.TQC-630066
   LET g_argv3=ARG_VAL(3)           #No.FUN-AA0088
#No.FUN-AA0088 --begin
   IF g_artype ='33' THEN LET g_prog ='axrt401' END IF 
#No.FUN-AA0088 --end 
   ### axr_stup : 造成後面程式段以 g_dbs_new 為主(總帳)--前端有多工廠,總帳一套
   LET g_dbs_new = s_dbstring(g_dbs CLIPPED) #TQC-950020    
   LET g_flag1 = 'N'                                     #MOD-CA0093 add
   LET g_wc2=' 1=1'
   LET l_dbs_new = g_dbs_new  #No.FUN-670060 add
 
 
      CALL cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
        RETURNING g_time     #No.FUN-6A0095
 
    LET l_sql = "ooa01.ooa_file.ooa01,", 
                "ooa02.ooa_file.ooa02,", 
                "ooa03.ooa_file.ooa03,", 
                "ooa032.ooa_file.ooa032,",
                "ooa15.ooa_file.ooa15,", 
                "gem02.gem_file.gem02,", 
                "ooa23.ooa_file.ooa23,", 
                "ooa31d.ooa_file.ooa31d,",
                "ooa32d.ooa_file.ooa32d,",
                "ooa13.ooa_file.ooa13,", 
                "aag02.aag_file.aag02,", 
                "azi04.azi_file.azi04,",
                "l_n.type_file.num5" 
#    LET l_table = cl_prt_temptable('axrt400',l_sql) CLIPPED
    LET l_table = cl_prt_temptable(g_prog,l_sql) CLIPPED   #No.FUN-AA0088
    IF l_table=-1 THEN EXIT PROGRAM END IF
    
    LET l_sql = "INSERT INTO ",g_cr_db_str CLIPPED,l_table CLIPPED,
                " VALUES(?,?,?,?,?,?,?,?,?,?, ?,?,?)"
    PREPARE insert_prep FROM l_sql
    IF STATUS THEN
       CALL cl_err('insert_prep:',STATUS,1) EXIT PROGRAM 
    END IF            
   
    LET g_forupd_sql = "SELECT * FROM ooa_file WHERE ooa01 = ? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t400_cl CURSOR FROM g_forupd_sql
 
   
    IF fgl_getenv('EASYFLOW') = "1" THEN
       LET g_argv1 = aws_efapp_wsk(1)   #參數:key-1
    END IF
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      LET p_row = 2 LET p_col = 3

      OPEN WINDOW t400_w AT p_row,p_col
        WITH FORM "axr/42f/axrt400"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
     
      CALL cl_ui_init() 
      CALL cl_set_act_visible("adjust_charge", FALSE)   #FUN-A40076 Mark 調帳功能不開放使用
      CALL cl_set_comp_visible("ooa33d",FALSE)          #FUN-A40076 Mark 調帳功能不開放使用
      CALL cl_set_comp_visible("oob03,oob03_d",FALSE)   #No.CHI-B30061 add
      #TQC-C20430--add--begin
      IF g_azw.azw04 != '2' THEN
         CALL cl_set_comp_visible("ooa35,ooa36,ooa38",FALSE) #FUN-C30029 add ooa38
      END IF
      #TQC-C20430--add--end
#No.FUN-AA0088 --begin
      IF g_prog ='axrt400' THEN 
         CALL cl_set_comp_visible("ooa40,oob24_1,oob25_1,oob26_1,oob27_1,occ02,ooc02",FALSE) #FUN-C20018 add ooa40
      END IF 
      IF g_prog ='axrt401' THEN 
         LET lwin_curr = ui.Window.getCurrent() 
         LET lfrm_curr = lwin_curr.getForm()
         LET lnode_Item = lfrm_curr.findNode("Group","group1")
         IF lnode_item IS NOT NULL THEN
            #LET g_msg = cl_getmsg('ggl-212',g_lang) #FUN-C20018 mark--
            LET g_msg = cl_getmsg('axr117',g_lang)   #FUN-C20018
            CALL lnode_item.setAttribute("text",g_msg)
         END IF
         LET lnode_Item = lfrm_curr.findNode("Group","group2")
         IF lnode_item IS NOT NULL THEN
            #LET g_msg = cl_getmsg('ggl-211',g_lang) #FUN-C20018 mark--
            LET g_msg = cl_getmsg('axr118',g_lang)   #FUN-C20018
            CALL lnode_item.setAttribute("text",g_msg)
         END IF
         #TQC-C20430--add--begin
         IF g_azw.azw04='2' THEN
            LET cb = ui.ComboBox.forName("ooa35")
            CALL cb.removeItem('1')
            CALL cb.removeItem('2')
            CALL cb.clear() 
            LET g_msg = cl_getmsg('axr122',g_lang)   
            CALL cb.addItem(1,g_msg)
         END IF
         #TQC-C20430--add--end
         CALL cl_set_comp_visible("oob03,oob04,oob14,oob03_d,oob04_1,oob06_1,oob19_1,oob15_1,oob14_1",FALSE)
         CALL cl_set_comp_entry("oob11",FALSE)
         #TQC-C20464--add--str
         #IF g_ooz.ooz29 ='Y' THEN  #TQC-C20430 mark--
         #IF g_ooz.ooz29 ='Y' AND g_ooa.ooa35!='1' THEN  #TQC-C20430 #MOD-C30667 mark--
         IF g_ooz.ooz29 ='Y' THEN  #MOD-C30667
            SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-551' AND ze02 = g_lang
            CALL cl_set_comp_att_text("oob11_1",ls_msg CLIPPED)
            CALL cl_set_comp_visible("oob111_1",FALSE)
         END IF 
         #TQC-C20464--add--end
     END IF   #TQC-C20026
    #TQC-C20464--MARK--STR 
    #IF g_ooz.ooz29 ='Y' THEN 
    #   SELECT ze03 INTO ls_msg FROM ze_file WHERE ze01 = 'axr-551' AND ze02 = g_lang
    #   CALL cl_set_comp_att_text("oob11_1",ls_msg CLIPPED)
    #   CALL cl_set_comp_visible("oob111_1",FALSE)
    #END IF 
    ##TQC-C20464--MARK--END
#No.FUN-AA0088 --end
      CALL t400_set_comb_oob04()                        #FUN-A90003 Add
      CALL t400_set_comb_oob04_1()                      #FUN-A90003 Add
   END IF
   CALL cl_set_act_visible("payable_sel",g_aza.aza26='2' AND g_prog ='axrt401') #FUN-D10057
   #FUN-D10058--add--str--
   IF g_aza.aza26 = '2' AND g_aza.aza69 = 'N' THEN
      CALL cl_set_comp_visible("ooa992",FALSE)
   END IF
   #FUN-D10058--add--end-- 

   IF g_aza.aza63='N' THEN
      CALL cl_set_comp_visible("oob111,oob111_1",FALSE)
   END IF
   LET g_chkins = 'N'              #MOD-B60135 
 
    #如果由表單追蹤區觸發程式, 此參數指定為何種資料匣
    #當為 EasyFlow 簽核時, 加入 EasyFlow 簽核 toolbar icon
    CALL aws_efapp_toolbar()    #FUN-580154
    IF NOT cl_null(g_argv1) THEN
      CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t400_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t400_a()
            END IF
          WHEN "efconfirm"
             CALL t400_q()
             CALL s_showmsg_init() #CHI-A80031 add
             CALL t400_y_chk()          #CALL 原確認的 check 段
             IF g_success = "Y" THEN
                CALL t400_y_upd()       #CALL 原確認的 update 段
             END IF
             CALL s_showmsg()  #CHI-A80031 add
             EXIT PROGRAM
          OTHERWISE
             CALL t400_q()
      END CASE
    END IF
    SELECT * INTO g_apz.* FROM apz_file WHERE apz00='0'
 
    #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
    CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, undo_void,confirm, undo_confirm, 
                               easyflow_approval,gen_entry,entry_sheet,
                               detail_b1,detail_b2, 
                               carry_voucher,undo_carry_voucher")  #TQC-740156 modify #FUN-C30140 #FUN-D20035 add undo_void
         RETURNING g_laststage
 
    CALL t400_menu()
 
    CLOSE WINDOW t400_w                 #結束畫面
 
      CALL cl_used(g_prog,g_time,2)    #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818   #No.FUN-6A0095
        RETURNING g_time     #No.FUN-6A0095
 
END MAIN



FUNCTION t400_cs2()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01   
 
   CLEAR FORM                             #清除畫面
   CALL g_oob.clear()
   CALL g_oob_d.clear()
 
   IF NOT cl_null(g_argv1) THEN     
      LET g_wc=" ooa01='",g_argv1,"'"
      LET g_wc2=" 1=1"
      LET g_wc3=" 1=1" 
   ELSE
      CALL cl_set_head_visible("","YES")      
   INITIALIZE g_ooa.* TO NULL   
      DIALOG ATTRIBUTES(UNBUFFERED)                                                 
      CONSTRUCT BY NAME g_wc ON ooa01,ooa02,ooa03,ooa35,ooa36,ooa032,ooa14,ooa15,ooa23,ooa38,#TQC-C20430 add ooa35,ooa36 #FUN-C30029 add ooa38
                                ooa13,ooa33,ooa992,ooa40,ooaconf,ooamksg,ooa34,ooa31d, #FUN-C20018 add ooa40     
                                ooa31c,ooauser,ooagrup,ooamodu,ooadate,
                                ooaud01,ooaud02,ooaud03,ooaud04,ooaud05,
                                ooaud06,ooaud07,ooaud08,ooaud09,ooaud10,
                                ooaud11,ooaud12,ooaud13,ooaud14,ooaud15,
                                ooaoriu,ooaorig                              #TQC-BB0003
                                
         BEFORE CONSTRUCT
             CALL cl_qbe_init()                
                            
      END CONSTRUCT

      CONSTRUCT g_wc2 ON oob02,oob03,oob04,oob06,oob19,oob15,oob11,oob111,           
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12         
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
              FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,     
                   s_oob[1].oob06,s_oob[1].oob19,                
                   s_oob[1].oob15,s_oob[1].oob11,s_oob[1].oob111,    
                   s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                   s_oob[1].oob08 
                  ,s_oob[1].oob09,s_oob[1].oob10,s_oob[1].oob12  
                  ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                  ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                  ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                  ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                  ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
                  
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)
                                    
      END CONSTRUCT

      CONSTRUCT g_wc3 ON oob02,oob03,oob04,oob06,oob19,oob15,oob24,oob27,oob25,oob26,oob11,oob111,      #No.FUN-AA0088 add oob24,oob27,oob25,oob26  
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12        
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
              FROM s_oob_d[1].oob02_1,s_oob_d[1].oob03_d,s_oob_d[1].oob04_1,     
                   s_oob_d[1].oob06_1,s_oob_d[1].oob19_1,                
                   s_oob_d[1].oob15_1,s_oob_d[1].oob24_1,s_oob_d[1].oob27_1,s_oob_d[1].oob25_1,s_oob_d[1].oob26_1,s_oob_d[1].oob11_1,s_oob_d[1].oob111_1,   #No.FUN-AA0088
                   s_oob_d[1].oob13_1,s_oob_d[1].oob14_1,s_oob_d[1].oob07_1,
                   s_oob_d[1].oob08_1 
                  ,s_oob_d[1].oob09_1,s_oob_d[1].oob10_1,s_oob_d[1].oob12_1   
                  ,s_oob_d[1].oobud01_1,s_oob_d[1].oobud02_1,s_oob_d[1].oobud03_1
                  ,s_oob_d[1].oobud04_1,s_oob_d[1].oobud05_1,s_oob_d[1].oobud06_1
                  ,s_oob_d[1].oobud07_1,s_oob_d[1].oobud08_1,s_oob_d[1].oobud09_1
                  ,s_oob_d[1].oobud10_1,s_oob_d[1].oobud11_1,s_oob_d[1].oobud12_1
                  ,s_oob_d[1].oobud13_1,s_oob_d[1].oobud14_1,s_oob_d[1].oobud15_1
                  
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)                  
                  
       END CONSTRUCT
       
#        BEFORE CONSTRUCT
#          CALL cl_qbe_init()
          
          ON ACTION CONTROLP
             CASE
                WHEN INFIELD(ooa01)
                   CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooa"
#No.FUN-AA0088 --begin  
                  IF g_prog ='axrt400' THEN                 
                      LET g_qryparam.arg1 = "1"       #No.TQC-A90057
                  END IF 
                  IF g_prog ='axrt401' THEN                 
                      LET g_qryparam.arg1 = "3"       #No.TQC-A90057
                  END IF                   
#No.FUN-AA0088 --end 
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO ooa01
                NEXT FIELD ooa01
 
                WHEN INFIELD(ooa03)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa03
                   NEXT FIELD ooa03
                WHEN INFIELD(ooa13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ool"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa13
                   NEXT FIELD ooa13
                WHEN INFIELD(ooa14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gen"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa14
                   NEXT FIELD ooa14
                WHEN INFIELD(ooa15)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gem"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa15
                   NEXT FIELD ooa15
                WHEN INFIELD(ooa23)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azi"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa23
                   NEXT FIELD ooa23
               WHEN INFIELD(oob04)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04
              WHEN INFIELD(oob06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = " oob07=",g_ooa.ooa23   #yinhy130615
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06
               WHEN INFIELD(oob11)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11
                  NEXT FIELD oob11
               WHEN INFIELD(oob111)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111
                  NEXT FIELD oob111
               WHEN INFIELD(oob13)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13   #MOD-620011
                  NEXT FIELD oob13
               WHEN INFIELD(oob07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07   #MOD-620011
                  NEXT FIELD oob07
               WHEN INFIELD(oob04_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04_1
              WHEN INFIELD(oob06_1)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = "c"
                 LET g_qryparam.where = "oob07 "
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06_1
               WHEN INFIELD(oob11_1)
                  CALL cl_init_qry_var()
#No.FUN-AA0088 --begin
                  IF g_ooz.ooz29 ='Y' AND g_prog ='axrt401' THEN 
                     LET g_qryparam.form ='q_ool01'
                  ELSE 
                     LET g_qryparam.form ='q_aag'
                  END IF 
#No.FUN-AA0088 --end
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11_1
                  NEXT FIELD oob11_1
               WHEN INFIELD(oob111_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111_1
                  NEXT FIELD oob111_1
               WHEN INFIELD(oob13_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13_1   
                  NEXT FIELD oob13_1
               WHEN INFIELD(oob07_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07_1   
                  NEXT FIELD oob07_1
#No.FUN-AA0088 --begin
                WHEN INFIELD(oob24_1)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_occ11" 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oob24_1
                   NEXT FIELD oob24_1
                WHEN INFIELD(oob27_1)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ooa"             
                   LET g_qryparam.arg1 = "1"       
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oob27_1
                   NEXT FIELD oob27_1
                WHEN INFIELD(oob26_1)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ooc" 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oob26_1
                   NEXT FIELD oob26_1
#No.FUN-AA0088 --end
                  OTHERWISE EXIT CASE
            END CASE
 
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG
 
          ON ACTION about         
             CALL cl_about()      
 
          ON ACTION help          
             CALL cl_show_help()  
 
          ON ACTION controlg      
             CALL cl_cmdask()     
 
          ON ACTION qbe_save
		       CALL cl_qbe_save()
		       
          ON ACTION accept
             EXIT DIALOG

          ON ACTION cancel
             LET INT_FLAG = TRUE
             EXIT DIALOG		       
      END DIALOG
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         RETURN
      END IF
                 
   END IF

   IF cl_null(g_wc2) THEN
      LET g_wc2 =' 1=1' 
   END IF  
   IF cl_null(g_wc3) THEN
      LET g_wc3 =' 1=1' 
   END IF
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('ooauser', 'ooagrup')

#No.FUN-AA0088 --begin
   IF g_prog ='axrt400' THEN 
      IF g_wc3=" 1=1" THEN
         IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
            LET g_sql = "SELECT ooa01 FROM ooa_file",
                        " WHERE ", g_wc CLIPPED,
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '1' ",  
                        " ORDER BY 1"
         ELSE                              # 若單身有輸入條件
            LET g_sql = "SELECT UNIQUE ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '1' ", 
                        " ORDER BY 1"
         END IF
      ELSE
         IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
            LET g_sql = "SELECT ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '1' ",  
                        " ORDER BY 1"
         ELSE                              # 若單身有輸入條件
            LET g_sql = "SELECT UNIQUE ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                        "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '1' ",  
                        " ORDER BY 1"
         END IF
      END IF
   END IF 
   IF g_prog ='axrt401' THEN 
      IF g_wc3=" 1=1" THEN
         IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
            LET g_sql = "SELECT ooa01 FROM ooa_file",
                        " WHERE ", g_wc CLIPPED,
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '3' ",  
                        " ORDER BY 1"
         ELSE                              # 若單身有輸入條件
            LET g_sql = "SELECT UNIQUE ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc2 CLIPPED," AND oob03='2')",    #MOD-B60017 oob03 1-->2
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '3' ", 
                        " ORDER BY 1"
         END IF
      ELSE
         IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
            LET g_sql = "SELECT ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc3 CLIPPED," AND oob03='1')",    #MOD-B60017 oob03 2-->1
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '3' ",  
                        " ORDER BY 1"
         ELSE                              # 若單身有輸入條件
            LET g_sql = "SELECT UNIQUE ooa01 ",
                        "  FROM ooa_file, oob_file",
                        " WHERE ooa01 = oob01",
                        "   AND ", g_wc CLIPPED,
                        "   AND (",g_wc2 CLIPPED," AND oob03='2')",   #MOD-B60017 oob03 1-->2
                        "   AND (",g_wc3 CLIPPED," AND oob03='1')",   #MOD-B60017 oob03 2-->1
                        "   AND ooa00 = '1' ",  
                        "   AND ooa37 = '3' ",  
                        " ORDER BY 1"
         END IF
      END IF
   END IF 
#No.FUN-AA0088 --end 
   PREPARE t400_prepare FROM g_sql
   DECLARE t400_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR t400_prepare
   DECLARE t400_fill_cs CURSOR FOR t400_prepare  #FUN-CB0080
#No.FUN-AA0088 --begin
   IF g_prog ='axrt400' THEN 
      IF g_wc3=" 1=1" THEN
         IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
            LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                      "   AND ooa00 = '1' ", 
                      "   AND ooa37 = '1' " 
         ELSE
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                      "   AND ooa00 = '1' ",
                      "   AND ooa37 = '1' "  
         END IF
      ELSE
         IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND ooa00 = '1' ", 
                      "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                      "   AND ooa37 = '1' "  
         ELSE
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND (",g_wc2 CLIPPED," AND oob03='1')",
                      "   AND (",g_wc3 CLIPPED," AND oob03='2')",
                      "   AND ooa00 = '1' ", 
                      "   AND ooa37 = '1' " 
         END IF
      END IF
   END IF 

   IF g_prog ='axrt401' THEN 
      IF g_wc3=" 1=1" THEN
         IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
            LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                      "   AND ooa00 = '1' ", 
                      "   AND ooa37 = '3' " 
         ELSE
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND (",g_wc2 CLIPPED," AND oob03='2')",  #MOD-B60017 oob03 2-->1
                      "   AND ooa00 = '1' ",
                      "   AND ooa37 = '3' "  
         END IF
      ELSE
         IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND ooa00 = '1' ", 
                      "   AND (",g_wc3 CLIPPED," AND oob03='1')",  #MOD-B60017 oob03 2-->1
                      "   AND ooa37 = '3' "  
         ELSE
            LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file",
                      " WHERE oob01=ooa01 ",
                      "   AND ",g_wc CLIPPED,
                      "   AND (",g_wc2 CLIPPED," AND oob03='2')",  #MOD-B60017 oob03 1-->2
                      "   AND (",g_wc3 CLIPPED," AND oob03='1')",  #MOD-B60017 oob03 2-->1
                      "   AND ooa00 = '1' ", 
                      "   AND ooa37 = '3' " 
         END IF
      END IF
   END IF 
#No.FUN-AA0088 --end 
   PREPARE t400_precount FROM g_sql
   DECLARE t400_count CURSOR FOR t400_precount
 
END FUNCTION

 #FUN-A90003--Mark--Begin--#
{  
FUNCTION t400_cs()
DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
 
   CLEAR FORM                             #清除畫面
   CALL g_oob.clear()
 
#FUN-580154
   IF NOT cl_null(g_argv1) THEN
      LET g_wc=" ooa01='",g_argv1,"'"
      LET g_wc2=" 1=1"  #No.TQC-630066
   ELSE
      CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
   INITIALIZE g_ooa.* TO NULL    #No.FUN-750051
      CONSTRUCT BY NAME g_wc ON ooa01,ooa02,ooa03,ooa032,ooa14,ooa15,ooa23,
                                ooa13,ooa33,ooa992,ooaconf,ooamksg,ooa34,ooa31d,     #No.FUN-540046  #No.FUN-690090 add ooa992
                                ooa31c,ooauser,ooagrup,ooamodu,ooadate,
                                ooaud01,ooaud02,ooaud03,ooaud04,ooaud05,
                                ooaud06,ooaud07,ooaud08,ooaud09,ooaud10,
                                ooaud11,ooaud12,ooaud13,ooaud14,ooaud15
 
               BEFORE CONSTRUCT
                  CALL cl_qbe_init()
          ON ACTION CONTROLP
             CASE
                WHEN INFIELD(ooa01)
                   CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooa"
                  LET g_qryparam.arg1 = "1"       #No.TQC-A90057
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO ooa01
                NEXT FIELD ooa01
 
                WHEN INFIELD(ooa03)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa03
                   NEXT FIELD ooa03
                WHEN INFIELD(ooa13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ool"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa13
                   NEXT FIELD ooa13
                WHEN INFIELD(ooa14)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gen"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa14
                   NEXT FIELD ooa14
                WHEN INFIELD(ooa15)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_gem"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa15
                   NEXT FIELD ooa15
                WHEN INFIELD(ooa23)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azi"
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ooa23
                   NEXT FIELD ooa23
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
   END IF                                                                           
 
   LET g_wc = g_wc CLIPPED,cl_get_extra_cond('ooauser', 'ooagrup')
 
 
   IF cl_null(g_argv1) THEN                                                         
      CONSTRUCT g_wc2 ON #oob02,oob05,oob03,oob04,oob06,oob19,oob15,oob11,oob111,        #No.FUN-670047  add oob111   #No.FUN-680022 add oob19  #No.FUN-690090  add oob05   #FUN-990031 mark
                         oob02,oob03,oob04,oob06,oob19,oob15,oob11,oob111,         #FUN-990031 del oob05
                         oob13,oob14,oob07,oob08
                        ,oob09,oob10,oob12         #No.MOD-920178 add
                        ,oobud01,oobud02,oobud03,oobud04,oobud05
                        ,oobud06,oobud07,oobud08,oobud09,oobud10
                        ,oobud11,oobud12,oobud13,oobud14,oobud15
              FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,     #FUN-990031 del oob05
                   s_oob[1].oob06,s_oob[1].oob19,                 #No.FUN-680022 add s_oob[1].oob19
                   s_oob[1].oob15,s_oob[1].oob11,s_oob[1].oob111, #No.FUN-670047 add s_oob[1].oob111
                   s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                   s_oob[1].oob08 
                  ,s_oob[1].oob09,s_oob[1].oob10,s_oob[1].oob12   #No.MOD-920178 add 
                  ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                  ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                  ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                  ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                  ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
 
		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
 
         ON ACTION CONTROLP    #ok
            CASE
               WHEN INFIELD(oob04)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc"
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob04
              WHEN INFIELD(oob06)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_oob"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oob06
               WHEN INFIELD(oob11)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob11
                  NEXT FIELD oob11
               WHEN INFIELD(oob111)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_aag'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob111
                  NEXT FIELD oob111
               WHEN INFIELD(oob13)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = 'q_gem'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob13   #MOD-620011
                  NEXT FIELD oob13
               WHEN INFIELD(oob07)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ='q_azi'
                  LET g_qryparam.state = "c"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO oob07   #MOD-620011
                  NEXT FIELD oob07
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
 
          ON ACTION qbe_save
		       CALL cl_qbe_save()
		       
      END CONSTRUCT
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         RETURN
      END IF

                 
   END IF
#No.FUN-AA0088 --begin
   IF g_prog ='axrt400' THEN 
      IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
         LET g_sql = "SELECT ooa01 FROM ooa_file",
                     " WHERE ", g_wc CLIPPED,
                     "   AND ooa00 = '1' ",  #FUN-570099
#                    "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                     "   AND ooa37 = '1' ",                 #FUN-A40076  Add
                     " ORDER BY 1"
      ELSE                              # 若單身有輸入條件
         LET g_sql = "SELECT UNIQUE ooa01 ",
                     "  FROM ooa_file, oob_file",
                     " WHERE ooa01 = oob01",
                     "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                     "   AND ooa00 = '1' ",  #FUN-570099 
#                    "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                     "   AND ooa37 = '1' ",                 #FUN-A40076  Add                  
                     " ORDER BY 1"
      END IF
   END IF 
   IF g_prog ='axrt401' THEN 
      IF g_wc2 = " 1=1" THEN                  # 若單身未輸入條件
         LET g_sql = "SELECT ooa01 FROM ooa_file",
                     " WHERE ", g_wc CLIPPED,
                     "   AND ooa00 = '1' ",  #FUN-570099
#                    "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                     "   AND ooa37 = '3' ",                 #FUN-A40076  Add
                     " ORDER BY 1"
      ELSE                              # 若單身有輸入條件
         LET g_sql = "SELECT UNIQUE ooa01 ",
                     "  FROM ooa_file, oob_file",
                     " WHERE ooa01 = oob01",
                     "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                     "   AND ooa00 = '1' ",  #FUN-570099 
#                    "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                     "   AND ooa37 = '3' ",                 #FUN-A40076  Add                  
                     " ORDER BY 1"
      END IF
   END IF
#No.FUN-AA0088 --end

 
   PREPARE t400_prepare FROM g_sql                                 
   DECLARE t400_c11s                         #SCROLL CURSOR          
       SCROLL CURSOR WITH HOLD FOR t400_prepare

#No.FUN-AA0088 --begin 
   IF g_prog ='axrt400' THEN 
      IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
         LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                   "   AND ooa00 = '1' ", #FUN-570099
#                  "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                   "   AND ooa37 = '1' "                  #FUN-A40076  Add
                   
      ELSE
         LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file WHERE ",
                   "oob01=ooa01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
                   "   AND ooa00 = '1' ", #FUN-570099
#                  "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                   "   AND ooa37 = '1' "                  #FUN-A40076  Add
                   
      END IF
   END IF 
   IF g_prog ='axrt401' THEN 
      IF g_wc2 = " 1=1" THEN                  # 取合乎條件筆數
         LET g_sql="SELECT COUNT(*) FROM ooa_file WHERE ",g_wc CLIPPED,
                   "   AND ooa00 = '1' ", #FUN-570099
#                  "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                   "   AND ooa37 = '3' "                  #FUN-A40076  Add
                   
      ELSE
         LET g_sql="SELECT COUNT(DISTINCT ooa01) FROM ooa_file,oob_file WHERE ",
                   "oob01=ooa01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED,
                   "   AND ooa00 = '1' ", #FUN-570099
#                  "   AND ooa37 = 'N' ",  #FUN-960141    #FUN-A40076  Mark
                   "   AND ooa37 = '3' "                  #FUN-A40076  Add
                   
      END IF
   END IF 
#No.FUN-AA0088 --end 
   PREPARE t400_precount FROM g_sql                               
   DECLARE t400_coun11t CURSOR FOR t400_precount                   
 
END FUNCTION
}
 #FUN-A90003--Mark--End--#

 
FUNCTION t400_menu()
   DEFINE l_creator  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINe l_flowuser LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1) # 是否有指定加簽人員      #FUN-580154
 
   LET l_flowuser = "N"
 
   WHILE TRUE
      IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN   #FUN-CB0080 add
      CALL t400_bp("G")
      #FUN-CB0080------add---str
      ELSE
         CALL t400_list_fill()
         CALL t400_bp2("G")
         IF NOT cl_null(g_action_choice) AND l_ac3>0 THEN #將清單的資料回傳到主畫面
            SELECT ooa_file.* INTO g_ooa.*
              FROM ooa_file
             WHERE ooa01=g_ooa_1[l_ac3].ooa01
         END IF
         IF g_action_choice!= "" THEN
            LET g_action_flag = "page_main"
            LET l_ac3 = ARR_CURR()
            LET g_jump = l_ac3
            LET mi_no_ask = TRUE
            IF g_rec_b1 >0 THEN
               CALL t400_fetch('/')
            END IF
            CALL cl_set_comp_visible("page_info", FALSE)
            CALL cl_set_comp_visible("info", FALSE)
            CALL ui.interface.refresh()
            CALL cl_set_comp_visible("page_info", TRUE)
            CALL cl_set_comp_visible("info", TRUE)
          END IF
      END IF
      #FUN-CB0080-----add----end
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL t400_a()
            END IF
 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL t400_q()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t400_r()
            END IF
 
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL t400_u()
            END IF

#No.FUN-B30057---Mark-BEGIN---- 
#        WHEN "detail"
#           IF cl_chk_act_auth() THEN
##             CALL t400_b()                  #FUN-A90003 Mark
#              CASE g_b_flag                  #FUN-A90003 Add
#                   WHEN '1' CALL t400_b()    #FUN-A90003 Add
#                   WHEN '2' CALL t400_b2()   #FUN-A90003 Add 
#              END CASE                       #FUN-A90003 Add
#           ELSE
#              LET g_action_choice = NULL
#           END IF
#No.FUN-B30057---Mark-END------ 
#No.FUN-B30057---add-BEGIN---- 
         WHEN "detail_b1"
            IF cl_chk_act_auth() THEN
               CALL t400_b()
            ELSE
               LET g_action_choice = NULL
            END IF 

         WHEN "detail_b2" 
            IF cl_chk_act_auth() THEN
               CALL t400_b2()
            ELSE
               LET g_action_choice = NULL
            END IF 
#No.FUN-B30057---add-END------ 

         WHEN "output"
            IF cl_chk_act_auth() THEN
               #IF g_artype !='33' THEN  #TQC-BA0089  #FUN-BB0100
                  CALL t400_out()
               #END IF #TQC-BA0089  #FUN-BB0100
            END IF
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         WHEN "exporttoexcel"
            #FUN-CB0080----add---str
            LET w = ui.Window.getCurrent()
            LET f = w.getForm()
            IF cl_null(g_action_flag) OR g_action_flag = "page_main" THEN
               LET page = f.FindNode("Page","page_main")
           #FUN-CB0080----add----end
             IF cl_chk_act_auth() THEN
                CALL cl_export_to_excel
                (ui.Interface.getRootNode(),base.TypeInfo.create(g_oob),'','')
             END IF
            #FUN-CB0080----add---str
           END IF
            IF g_action_flag = "page_info" THEN
               LET page = f.FindNode("Page","page_info")
               IF cl_chk_act_auth() THEN
                  CALL cl_export_to_excel(page,base.TypeInfo.create(g_ooa_1),'','')
               END IF
            END IF
           #FUN-CB0080----add----end
 
         #FUN-D10057--add--str--
         WHEN "payable_sel"
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf='Y' THEN
                  IF g_prog='axrt401' THEN
                     LET g_str=" axrt300 ",g_str
                     CALL cl_cmdrun(g_str)
                  END IF
               ELSE
                  CALL cl_err('','axr-205',0)
               END IF
            ELSE
               LET g_action_choice = NULL
            END IF
         #FUN-D10057--add--end--

         WHEN "gen_entry"
            CALL t400_v()
 
         WHEN "entry_sheet"
            IF cl_chk_act_auth() THEN
               CALL t400_3()
               CALL t400_npp02() #No.+085 010426 by plum
            END IF
 
         WHEN "entry_sheet2"
            IF cl_chk_act_auth() THEN
               CALL t400_3_1()
               CALL t400_npp02() #No.+085 010426 by plum
            END IF
 
         WHEN "memo"
            IF cl_chk_act_auth() THEN
               CALL t400_m()
            END IF
 
         WHEN "carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf = 'Y' THEN
                  CALL t400_carry_voucher()
               ELSE
                  CALL cl_err('','atm-402',1)
               END IF
            END IF
 
         WHEN "undo_carry_voucher"
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf = 'Y' THEN
                  CALL t400_undo_carry_voucher() 
               ELSE
                  CALL cl_err('','atm-403',1)
               END IF
            END IF
 
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
               CALL s_showmsg_init() #CHI-A80031 add
               CALL t400_y_chk()          #CALL 原確認的 check 段
               IF g_success = "Y" THEN
                  CALL t400_y_upd()       #CALL 原確認的 update 段
               END IF
               CALL s_showmsg()  #CHI-A80031 add
            END IF
 
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t400_z()
            END IF
 
         WHEN "void"
            IF cl_chk_act_auth() THEN
               #CALL t400_x() #FUN-D20035 mark
               CALL t400_x(1) #FUN-D20035 add
            END IF
         #FUN-D20035 add
         WHEN "undo_void"
            IF cl_chk_act_auth() THEN
               CALL t400_x(2)
            END IF
         #FUN-D20035 add
         #@WHEN "准"
         WHEN "agree"
            IF g_laststage = "Y" AND l_flowuser = "N" THEN  #最後一關並且沒有加>
               CALL t400_y_upd()      #CALL 原確認的 update 段
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
                          CALL t400_q()
                         #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void, undo_void,confirm, undo_confirm, 
                                                     easyflow_approval,gen_entry,entry_sheet,
                                                     detail_b1,detail_b2, 
                                                     carry_voucher,undo_carry_voucher")  #TQC-740156 modify #FUN-C30140 #FUN-D20035 add undo_void
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
            IF ( l_creator := aws_efapp_backflow() ) IS NOT NULL THEN #退回關卡
               IF aws_efapp_formapproval() THEN
                  IF l_creator = "Y" THEN
                     LET g_ooa.ooa34= 'R'
                     DISPLAY BY NAME g_ooa.ooa34
                  END IF
                  IF cl_confirm('aws-081') THEN     #詢問是否繼續下一筆資料的簽>
                     IF aws_efapp_getnextforminfo() THEN #取得下一筆簽核單號
                       LET l_flowuser = "N"
                       LET g_argv1 = aws_efapp_wsk(1)    #取得單號
                       IF NOT cl_null(g_argv1) THEN      #自動 query 帶出資料
                          CALL t400_q()
                        #設定簽核功能及哪些 action 在簽核狀態時是不可被執行的
                          CALL aws_efapp_flowaction("insert, modify, delete, reproduce, detail, query,locale, void,undo_void, confirm, undo_confirm, 
                                                     easyflow_approval,gen_entry,entry_sheet,
                                                     detail_b1,detail_b2, 
                                                     carry_voucher,undo_carry_voucher")  #TQC-740156 modify #FUN-C30140 #FUN-D20035 add undo_void
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
 
         ##EasyFlow送簽
         WHEN "easyflow_approval"     #FUN-550049
           IF cl_chk_act_auth() THEN
             #FUN-C20030 add str---
              SELECT * INTO g_ooa.* FROM ooa_file
               WHERE ooa01 = g_ooa.ooa01
              CALL t400_show()
              CALL t400_b_fill(' 1=1')
              CALL t400_b_fill_2(' 1=1')
             #FUN-C20030 add end---
              CALL t400_ef()
              CALL t400_show()  #FUN-C20030 add
           END IF
 
         #@WHEN "簽核狀況"
         WHEN "approval_status"
            IF cl_chk_act_auth() THEN        #DISPLAY ONLY
               IF aws_condition2() THEN                #FUN-550049
                   CALL aws_efstat2()                  #MOD-560007
               END IF
            END IF
 
         WHEN "related_document"  #相關文件
              IF cl_chk_act_auth() THEN
                 IF g_ooa.ooa01 IS NOT NULL THEN
                 LET g_doc.column1 = "ooa01"
                 LET g_doc.value1 = g_ooa.ooa01
                 CALL cl_doc()
               END IF
         END IF
#No.FUN-A30106 --begin                                                          
         WHEN "drill_down"                                                      
            IF cl_chk_act_auth() THEN                                           
               CALL t400_drill_down()                                           
            END IF                                                              
#No.FUN-A30106 --end 

#FUN-A40076--Add--Begin
         WHEN "adjust_charge"                                                      
            IF cl_chk_act_auth() THEN
               IF g_ooa.ooaconf = 'Y' THEN
                  CALL t400_oof_b_fill()
               ELSE                                              
                  CALL t400_diff1()
               END IF                                              
            END IF
#FUN-A40076--Add--End

     END CASE
   END WHILE
END FUNCTION
 
FUNCTION t400_a()
   DEFINE l_ooymxno LIKE ooy_file.ooymxno,
          l_stra    LIKE type_file.chr4,             #No.FUN-680123 VARCHAR(4), #TQC-840066
          l_strb    LIKE aba_file.aba18,             #No.FUN-680123 VARCHAR(2),
          l_strc    LIKE type_file.chr3,             #No.FUN-680123 VARCHAR(3),
          l_ooa_b   LIKE ooa_file.ooa03,             #No.FUN-680123 HAR(10),
          l_ooa_e   LIKE ooa_file.ooa03              #No.FUN-680123 VARCHAR(10)
 
   IF s_shut(0) THEN RETURN END IF
 
   MESSAGE ""
   CLEAR FORM
   CALL g_oob.clear()
   CALL g_oob_d.clear()                              #FUN-A90003 Add
   INITIALIZE g_ooa.* TO NULL
   LET g_ooa_o.* = g_ooa.*
   CALL cl_opmsg('a')
 
   WHILE TRUE
      IF NOT cl_null(g_argv1) AND (g_argv2 = "insert") THEN
         LET g_ooa.ooa01 = g_argv1
      END IF     
      LET g_ooa.ooa00 = '1'   #FUN-570099
      LET g_ooa.ooa02 = g_today
      LET g_ooa.ooa021 = g_today
      LET g_ooa.ooa13 = g_ooz.ooz08 #MOD-4A0119
      LET g_ooa.ooa14 = g_user
      LET g_ooa.ooa15 = g_grup
      LET g_ooa.ooa20 = 'Y'
#     LET g_ooa.ooa37 = 'N'             #FUN-960141   #FUN-A40076 Mark
#No.FUN-AA0088 --begin
      IF g_prog ='axrt400' THEN 
         LET g_ooa.ooa37 = '1'                           #FUN-A40076 Add
      END IF 
      IF g_prog ='axrt401' THEN 
         LET g_ooa.ooa37 = '3'                           #FUN-A40076 Add
      END IF
#No.FUN-AA0088 --end
      LET g_ooa.ooa38 = '2'             #FUN-960141
      LET g_ooa.ooalegal = g_azw.azw02  #FUN-960141
      LET g_ooa.ooa31d = 0
      LET g_ooa.ooa31c = 0
      LET g_ooa.ooa32d = 0
      LET g_ooa.ooa32c = 0
      #FUN-C20018--add--begin
      IF g_prog ='axrt401' THEN 
         #LET g_ooa.ooa40 = '1'   #FUN-C20063 mark--
         LET g_ooa.ooa40 = '01'   #FUN-C20063 
      END IF
      #FUN-C20018--add--end
      LET g_ooa.ooaconf = 'N'
      LET g_ooa.ooaprsw = 0
      LET g_ooa.ooauser = g_user
      LET g_ooa.ooaoriu = g_user #FUN-980030
      LET g_ooa.ooaorig = g_grup #FUN-980030
      LET g_ooa.ooagrup = g_grup
      LET g_ooa.ooadate = g_today
      LET g_ooa.ooamksg = "N"     #No.FUN-540046
      LET g_ooa.ooa34 = "0"       #No.FUN-540046
      LET g_ooa.ooalegal = g_legal #FUN-980011 add
      LET g_ooa.ooa38='2'  #FUN-C30029
   
      CALL t400_i("a")                #輸入單頭
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         INITIALIZE g_ooa.* TO NULL
         EXIT WHILE   #MOD-730060
      END IF
 
      BEGIN WORK
#No.FUN-AA0088 --begin
      IF g_prog ='axrt400' THEN 
         CALL s_auto_assign_no("axr",g_ooa.ooa01,g_ooa.ooa02,"30","ooa_file","ooa01","","","")   #MOD-8B0100 #TQC-8B0032 mod
              RETURNING g_cnt,g_ooa.ooa01
      END IF  
      IF g_prog ='axrt401' THEN 
         CALL s_auto_assign_no("axr",g_ooa.ooa01,g_ooa.ooa02,"33","ooa_file","ooa01","","","")   #MOD-8B0100 #TQC-8B0032 mod
              RETURNING g_cnt,g_ooa.ooa01
      END IF 
#No.FUN-AA0088 --end
      IF (NOT g_cnt) THEN
         ROLLBACK WORK
         CONTINUE WHILE
      END IF
      DISPLAY BY NAME g_ooa.ooa01
 
      INSERT INTO ooa_file VALUES (g_ooa.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err3("ins","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","ins ooa",1)  #No.MOD-B70289
         ROLLBACK WORK  #No:7837
         #CALL cl_err3("ins","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","ins ooa",1)  #No.FUN-660116
         CONTINUE WHILE
      ELSE
         COMMIT WORK   #No:7837
         CALL cl_flow_notify(g_ooa.ooa01,'I')
      END IF
 
      SELECT ooa01 INTO g_ooa.ooa01 FROM ooa_file
       WHERE ooa01 = g_ooa.ooa01
 
      LET g_ooa_t.* = g_ooa.*
      CALL g_oob.clear()
      LET g_rec_b=0
      CALL g_oob_d.clear()            #FUN-A90003 Add
      LET g_rec_b2=0                  #FUN-A90003 Add
 
      CALL t400_input_nr()            #詢問是否先輸入支票資料
 
      LET l_ac=1
      LET g_chkins = 'Y'              #MOD-B60135 
 
      CALL t400_b()                   #輸入單身
      LET g_change = 'Y'              #MOD-B60022
      CALL t400_b2()                  #FUN-A90003 Add 
       
      EXIT WHILE
   END WHILE
   LET g_wc = ''                  #TQC-970232  
END FUNCTION
 
FUNCTION t400_input_nr()
    
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
   
   IF g_prog ='axrt401' THEN RETURN END IF    #No.FUN-AA0088
    
   IF g_ooz.ooz23 = 'N' AND g_ooz.ooz24 = 'N' THEN
      RETURN
   END IF
 
   IF g_ooz.ooz23 = 'Y' THEN             #NO:4181
      IF cl_confirm('axr-200') THEN
         CALL cl_cmdrun_wait('anmt200')  #FUN-660216 add
      END IF
   END IF
 
   IF g_ooz.ooz24 = 'Y' THEN
      IF NOT cl_confirm('axr-201') THEN
         RETURN
      END IF
      CALL cl_cmdrun_wait('anmt302')  #FUN-660216 add
   END IF
 
END FUNCTION
 
FUNCTION t400_g_b()                       #先由應收票據或TT自動產生借方單身

   IF g_prog ='axrt401' THEN RETURN END IF   #No.FUN-AA0088
    
   SELECT COUNT(*) INTO g_cnt FROM oob_file
    WHERE oob01 = g_ooa.ooa01
 
   IF g_cnt > 0 THEN
      RETURN
   END IF            #已有單身則不可再產生
 
   CALL t400_g_b1()
 
   CALL t400_g_b2()
 
   CALL t400_b_fill('1=1')
   CALL t400_b_fill_2('1=1') #FUN-A90003 Add
 
END FUNCTION
 
FUNCTION t400_g_b1()
   DEFINE sw1,sw2,sw3,sw4  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh            RECORD LIKE nmh_file.*
   DEFINE l_nmg            RECORD LIKE nmg_file.*
   DEFINE l_npk            RECORD LIKE npk_file.*
   DEFINE l_oma            RECORD LIKE oma_file.*
   DEFINE l_omc            RECORD LIKE omc_file.*    #No.FUN-680022
   DEFINE l_apc            RECORD LIKE apc_file.*    #No.FUN-680022 add
   DEFINE l_apa            RECORD LIKE apa_file.*
   DEFINE l_oob09          LIKE oob_file.oob09
   DEFINE l_oob10          LIKE oob_file.oob10
   DEFINE l_ooydmy1        LIKE ooy_file.ooydmy1
   DEFINE g_t1             LIKE type_file.chr5       #No.FUN-680123 VARCHAR(03)   #MOD-730023
   DEFINE l_ool            RECORD LIKE ool_file.*,
          l_sql            LIKE type_file.chr1000    #No.FUN-680123 VARCHAR(1300)
   DEFINE l_apz27          LIKE apz_file.apz27
   DEFINE l_nmz20          LIKE nmz_file.nmz20
   DEFINE l_nmz59          LIKE nmz_file.nmz59
   DEFINE ls_tmp           STRING
   DEFINE l_aag05          LIKE aag_file.aag05   #MOD-730022
   DEFINE l_bookno         LIKE aag_file.aag00   #No.FUN-740184
   DEFINE p05f             LIKE apg_file.apg05f  #MOD-820134
   DEFINE p05              LIKE apg_file.apg05   #MOD-820134
   DEFINE l_gem10          LIKE gem_file.gem10   #MOD-910107 add
   DEFINE l_ombcnt         LIKE type_file.num5   #CHI-8A0018
   DEFINE l_chkcnt         LIKE type_file.num5   #CHI-8A0018
   DEFINE l_nmydmy3        LIKE nmy_file.nmydmy3 #MOD-B60182 add
   DEFINE l_cnt            LIKE type_file.num5   #MOD-B70009
   DEFINE l_nmg00          LIKE nmg_file.nmg00   #MOD-CA0169 add
   DEFINE l_nmg24          LIKE nmg_file.nmg24   #MOD-CA0169 add

   LET p_row = 8 LET p_col = 27
   OPEN WINDOW t4003_w AT p_row,p_col
     WITH FORM "axr/42f/axrt4003"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   CALL cl_ui_locale("axrt4003")
 
   LET sw1 = 'Y'
   LET sw2 = 'Y'
   LET sw3 = 'Y'
   LET sw4 = 'N'
 
   IF g_ooz.ooz04 = 'N' THEN
      LET sw1 = 'N'
      LET sw2 = 'N'
   END IF
 
   INPUT BY NAME sw1,sw2,sw3,sw4 WITHOUT DEFAULTS
 
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
 
   CLOSE WINDOW t4003_w
 
   IF sw4 = 'Y' THEN
      WHILE TRUE
         LET p_row = 8 LET p_col = 27
         OPEN WINDOW t4004_w AT p_row,p_col
           WITH FORM "axr/42f/axrt4004"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
         CALL cl_ui_locale("axrt4004")
 
         CONSTRUCT g_wc ON apa06,apa07,apa01,apa02 FROM apa06,apa07,apa01,apa02
 
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
#No.FUN-A10086 --begin
             ON ACTION CONTROLP
               CASE
                  WHEN INFIELD(apa06)
                     CALL cl_init_qry_var()
                     LET g_qryparam.state = "c"
                     LET g_qryparam.form ="q_pmc"
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO apa06
                  WHEN INFIELD(apa01)
                     CALL q_apa4(TRUE, TRUE, ' ')
                         RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO apa01

                  OTHERWISE EXIT CASE
               END CASE
#No.FUN-A10086 --end
 
                 ON ACTION qbe_select
         	   CALL cl_qbe_select()
                 ON ACTION qbe_save
		   CALL cl_qbe_save()
         END CONSTRUCT
 
         IF g_wc = " 1=1" THEN
            CALL cl_err('','9046',0)
            CONTINUE WHILE
         END IF
 
         EXIT WHILE
      END WHILE
   END IF
 
   CLOSE WINDOW t4004_w
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   SELECT * INTO l_ool.* FROM ool_file
    WHERE ool01 = g_ooa.ooa13
 
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
   LET b_oob.oob02=0
 
   #----------------------------------- #由支票產生單身(取客戶編號,簡稱相同者)
   IF sw1='Y' THEN
      LET l_sql=
        #" SELECT * FROM nmh_file,nmy_file ",              #MOD-A80012 mark
         " SELECT nmh_file.* FROM nmh_file,nmy_file ",     #MOD-A80012
#        "  WHERE nmh11 = ",g_ooa.ooa03,                   #TQC-A80060 Mark
#        "    AND nmh30 = ",g_ooa.ooa032,                  #TQC-A80060 Mark
         "  WHERE nmh11 = '",g_ooa.ooa03,"' ",             #TQC-A80060 Add                                                
         "    AND nmh30 = '",g_ooa.ooa032,"' ",            #TQC-A80060 Add 
         "    AND nmh17 < nmh02 ",
         "    AND nmh38 = 'Y' ",
         "    AND nmh24 != '6' AND nmh24 != '7'  ",         #MOD-980159 add
#        "    AND nmh01[1,",g_doc_len CLIPPED,"] = nmyslip  ",  #NO.MOD-560077 #TQC-A80060 Mark
        #"    AND SUBSTR(nmh01,1,",g_doc_len CLIPPED,") = nmyslip "            #TQC-A80060 Add
         "    AND nmh01[1,",g_doc_len CLIPPED,"] = nmyslip "       #FUN-B40029
#        "    AND nmydmy3 = 'N' "                                              #No.MOD-AC0152 mark
      PREPARE t400_g_b_c11_pre FROM l_sql
      DECLARE t400_g_b_c11 CURSOR FOR  t400_g_b_c11_pre
 
      FOREACH t400_g_b_c11 INTO l_nmh.*
       #INITIALIZE b_oob.* TO NULL    #MOD-A50027 add     #MOD-A70047 mark
        IF STATUS THEN
           EXIT FOREACH
        END IF
 
        IF l_nmh.nmh04 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
           CONTINUE FOREACH
        END IF
                                 
        IF g_ooa.ooa23 IS NOT NULL AND l_nmh.nmh03 != g_ooa.ooa23 THEN
           CONTINUE FOREACH
        END IF
 
        #95/12/14 by danny 若此收票單號未確認,則不可產生於沖帳單身
        IF l_nmh.nmh38 != 'Y' THEN CONTINUE FOREACH END IF
        #須考慮未確認沖帳資料
        SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file,ooa_file
         WHERE oob06 = l_nmh.nmh01 AND oob01 = ooa01 AND ooaconf = 'N'
        IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
        IF cl_null(l_oob10) THEN LET l_oob10=0 END IF
#No.FUN-AA0088 --begin                                                          
        IF NOT cl_null(l_npk.npk01) THEN                                        
           SELECT SUM(oob09) INTO l_nmg.nmg24 FROM oob_file, ooa_file           
            WHERE oob06 = l_nmg.nmg00 AND oob01 = ooa01 AND ooaconf = 'Y'        
              AND ooa01 != g_ooa.ooa01 AND oob15 = l_npk.npk01   #MOD-720129    
              AND oob03='1'         AND oob04 = '2'                             
           IF cl_null(l_nmg.nmg24) THEN LET l_nmg.nmg24 =0 END IF               
        END IF                                                                  
#No.FUN-AA0088 --end 
       #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
        LET b_oob.oob03='1'
        LET b_oob.oob04='1'
        LET b_oob.oob06=l_nmh.nmh01
        LET b_oob.oob14=l_nmh.nmh31
        LET b_oob.oob07=l_nmh.nmh03
        LET b_oob.oob08=l_nmh.nmh32/l_nmh.nmh02     
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077     #No.CHI-6A0004 #MOD-940238 recuva
        LET b_oob.oob09=l_nmh.nmh02-l_nmh.nmh17-l_oob09   #原幣入帳金額
        LET b_oob.oob10=b_oob.oob09*b_oob.oob08                              
       #modify 95/08/24 by nick 金額算法(原幣)=票面金額-已沖金額
       #modify 97/07/23 By sophia 當原幣金額=票面金額
        IF b_oob.oob09 = l_nmh.nmh02 THEN
           LET b_oob.oob10 = l_nmh.nmh32
        ELSE
           LET b_oob.oob10=b_oob.oob09*b_oob.oob08                              
        END IF
        SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
       #-MOD-B10083-add-
        IF l_nmz59 = 'Y' THEN      
           LET b_oob.oob08 = l_nmh.nmh39 
        ELSE                                
           LET b_oob.oob08 = l_nmh.nmh28     
        END IF 	                          
       #-MOD-B10083-end-
        IF l_nmz59 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
          #-MOD-B10083-mark- 
          #IF g_apz.apz27 = 'Y' THEN              #MOD-940277
          #   LET b_oob.oob08 = l_nmh.nmh39
          #ELSE                                   #MOD-940277
          #	  LET b_oob.oob08 = l_nmh.nmh28       #MOD-940277
          #END IF                                 #MOD-940277	   
          #-MOD-B10083-end- 
           IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
              LET b_oob.oob08 = l_nmh.nmh28
           END IF
           CALL s_g_np('4','1',b_oob.oob06,b_oob.oob15) RETURNING tot3
           IF (b_oob.oob09+l_nmh.nmh17+l_oob09) = l_nmh.nmh02 THEN
              LET b_oob.oob10 = tot3 - l_oob10
           END IF
        END IF
 
        CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004 
        CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004
       #modify 95/08/24 by nick 金額算法(本幣)=原幣金額*匯率
       #LET b_oob.oob11=l_nmh.nmh26        #No.MOD-B60182 mark
#----------------------------No.MOD-B60182------------------------------add
        LET l_sql="SELECT nmydmy3 FROM nmh_file,nmy_file ",
                  " WHERE nmh01= '",b_oob.oob06,"'",
                  " AND nmh01[1,",g_doc_len,"]=nmyslip"
        PREPARE nmy_p FROM l_sql
        DECLARE nmy_c CURSOR FOR nmy_p
        OPEN nmy_c
        FETCH nmy_c INTO l_nmydmy3
        IF STATUS THEN CALL cl_err('sel nmh',STATUS,1) LET g_errno='N' END IF

        IF l_nmydmy3='Y' THEN
           LET b_oob.oob11 = l_nmh.nmh27
        ELSE
           LET b_oob.oob11 = l_nmh.nmh26
        END IF
#----------------------------No.MOD-B60182------------------------------end
        IF g_aza.aza63='Y' THEN            #No.FUN-670047 add 
           IF l_nmydmy3='Y' THEN              #No.MOD-B60182 add
              LET b_oob.oob111= l_nmh.nmh271  #No.MOD-B60182 add
           ELSE                               #No.MOD-B60182 add
              LET b_oob.oob111=l_nmh.nmh261   #No.FUN-670047 add 
           END IF
        END IF                             #No.FUN-670047 add   
       #CALL s_get_bookno(YEAR(l_nmh.nmh04)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
        CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
        IF g_flag='1' THEN
           CALL cl_err(l_nmh.nmh04,'aoo-081',1)
        END IF
        LET l_aag05 = ''
        SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                  AND aag00=g_bookno1      #No.FUN-730073
        IF l_aag05 = 'Y' THEN
           LET b_oob.oob13 = l_nmh.nmh15
        ELSE
           LET b_oob.oob13 = ''
        END IF
        IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN                    #MOD-A80195
           LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
           IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                   RETURNING l_bookno,b_oob.oob11
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                   RETURNING l_bookno,b_oob.oob111
           END IF
           LET b_oob.oob12 = l_nmh.nmh18   #MOD-780261
           LET b_oob.ooblegal = g_ooa.ooalegal
           INSERT INTO oob_file VALUES (b_oob.*)
        END IF                                                      #MOD-A80195
      END FOREACH
   END IF
   #----------------------------------- #由TT產生單身
   # 96-10-23 By Charis 配合票據3.0版修改
   IF sw2='Y' THEN
      LET l_nmg00 = ''                  #MOD-CA0169 add
      DECLARE t400_g_b_c12 CURSOR FOR
       SELECT nmg_file.*,npk_file.* FROM nmg_file,npk_file
        WHERE nmg00=npk00 AND nmg18=g_ooa.ooa03 AND nmg19=g_ooa.ooa032
          AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
          AND (nmg23-nmg24>0) AND nmgconf='Y'
      FOREACH t400_g_b_c12 INTO l_nmg.*,l_npk.*
       #INITIALIZE b_oob.* TO NULL    #MOD-A50027 add     #MOD-A70047 mark
        LET b_oob.oob12 = ''                              #MOD-A70047
        IF STATUS THEN EXIT FOREACH END IF
        
        IF l_nmg.nmg01 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
           CONTINUE FOREACH
        END IF
 
        IF g_ooa.ooa23 IS NOT NULL AND l_npk.npk05 != g_ooa.ooa23 THEN
           CONTINUE FOREACH
        END IF
        #須考慮未確認沖帳資料
        SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file,ooa_file
         WHERE oob06 = l_nmg.nmg00 AND oob01 = ooa01 AND ooaconf = 'N'
               AND ooa01 != g_ooa.ooa01 AND oob15 = l_npk.npk01   #MOD-720129
        IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
        IF cl_null(l_oob10) THEN LET l_oob10=0 END IF
 
       #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
        LET b_oob.oob03='1'
        LET b_oob.oob04='2'
        LET b_oob.oob06=l_nmg.nmg00
       #LET b_oob.oob14=l_nmg.nmg01    #MOD-A80164 mark
        LET b_oob.oob14=NULL           #MOD-A80164
        LET b_oob.oob07=l_npk.npk05    #幣別
        LET b_oob.oob08=l_npk.npk06    #匯率
        LET b_oob.oob15=l_npk.npk01    #No.FUN-680022 add 
       #-----------------MOD-CA0169---------(S)
        IF  l_nmg00 = b_oob.oob06 THEN
            LET l_nmg.nmg24 = l_nmg24
        END IF
       #-----------------MOD-CA0169---------(E)
       #modify 030422 NO.A058  原幣是否應再扣除已沖金額
        LET b_oob.oob09=l_npk.npk08 - l_nmg.nmg24 - l_oob09   #原幣入帳金額
       #-----------------MOD-CA0169---------(S)
        IF  l_nmg00 <> b_oob.oob06  OR cl_null(l_nmg00) THEN
            IF l_nmg.nmg24 > l_npk.npk08 THEN
               LET l_nmg24 = l_nmg.nmg24 - l_npk.npk08
            ELSE
               LET l_nmg24 = 0
            END IF
        END IF
       #-----------------MOD-CA0169---------(E)
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 #MOD-560077   #No.CHI-6A0004 #MOD-940238 recuva
        LET b_oob.oob10=l_npk.npk09-(l_nmg.nmg24*l_npk.npk06)-l_oob10  #本幣入帳金額
 
        SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
       #-MOD-B10083-add-
        IF l_nmz20 = 'Y' THEN      
           LET b_oob.oob08 = l_nmg.nmg09
        ELSE                                
           LET b_oob.oob08 = l_npk.npk06  
        END IF 	                          
       #-MOD-B10083-end-
        IF l_nmz20 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
          #-MOD-B10083-mark-
          #IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
          #   LET b_oob.oob08 = l_nmg.nmg09
          #ELSE                                       #MOD-940277
          #	  LET b_oob.oob08 = l_npk.npk06           #MOD-940277
          #END IF                                     #MOD-940277	   
          #-MOD-B10083-end-
           IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
              LET b_oob.oob08 = l_npk.npk06
           END IF
           CALL s_g_np('3','2',b_oob.oob06,b_oob.oob15)
                RETURNING tot3
           IF (l_oob09+b_oob.oob09+l_nmg.nmg24) = l_nmg.nmg23 THEN
              LET b_oob.oob10 = tot3 - l_oob10
           END IF
        END IF
 
        CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09    #No.CHI-6A0004 
        CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10    #No.CHI-6A0004
        IF l_nmg.nmg29='Y' THEN
           LET b_oob.oob11=l_npk.npk071   #會計科目
           IF g_aza.aza63='Y' THEN           #No.FUN-670047
              LET b_oob.oob111=l_npk.npk072  #No.FUN-670047
           END IF                            #No.FUN-670047
        ELSE
           LET b_oob.oob11=l_npk.npk07    #會計科目
           IF g_aza.aza63='Y' THEN           #No.FUN-670047
              LET b_oob.oob111=l_npk.npk073  #No.FUN-670047
           END IF                            #No.FUN-670047
        END IF
       #CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
        CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
        IF g_flag='1' THEN
           CALL cl_err(l_nmg.nmg01,'aoo-081',1)
        END IF
        LET l_aag05 = ''
        SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                  AND aag00=g_bookno1      #No.FUN-730073
        IF l_aag05 = 'Y' THEN
           LET l_gem10=s_costcenter(l_nmg.nmg11)
           IF NOT cl_null(l_gem10) THEN
              LET b_oob.oob13 = l_gem10
           ELSE
              LET b_oob.oob13 = l_nmg.nmg11
           END IF   #MOD-910107 add
        ELSE
           LET b_oob.oob13 = ''
        END IF
        LET b_oob.oob12 = l_npk.npk10   #MOD-780261
        LET b_oob.ooblegal = g_ooa.ooalegal
        LET l_nmg00 = b_oob.oob06                              #MOD-CA0169 add
        IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN
           LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
           IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg01) THEN
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                   RETURNING l_bookno,b_oob.oob11
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                   RETURNING l_bookno,b_oob.oob111
           END IF
           INSERT INTO oob_file VALUES (b_oob.*)
        END IF
      END FOREACH
   END IF
   #----------------------------------- #由待抵產生單身
   IF sw3='Y' THEN
      IF g_ooz.ooz07 = 'N' THEN                                                                                                     
         LET l_sql = "SELECT * FROM oma_file,omc_file ",    
                     " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
                     "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
                     "   AND oma01 = omc01 ",              #No.FUN-680022 add
                     "   AND (omc08>omc10 OR omc09 >omc11) ", #No.FUN-680022 
                     "   AND oma00 LIKE '2%' ",                                                                                  
                     "   AND omavoid = 'N' ",                                                                                       
                     "   AND omaconf = 'Y' "    #MOD-760119
                    #"   AND oma00 != '23' "              #CHI-8A0018 mark                                                                          
                    #"   AND oma16 IS NOT NULL "          #MOD-A30106 add    #MOD-A60193 mark
      ELSE                                                                                                                          
         LET l_sql = "SELECT * FROM oma_file ,omc_file ",                                                                                     
                     " WHERE oma68 = '",g_ooa.ooa03,"' ",  #No.FUN-670026                                                                         
                     "   AND oma69 = '",g_ooa.ooa032,"' ", #No.FUN-670026                                                                         
                     "   AND oma01 = omc01 ",              #No.FUN-680022 add
                     "   AND (omc08>omc10 OR omc13 >0) ", #No.FUN-680022 
                     "   AND oma00 LIKE '2%' ",                                                                                  
                     "   AND omavoid = 'N' ",                                                                                       
                     "   AND omaconf = 'Y' "    #MOD-760119
                    #"   AND oma00 != '23' "              #CHI-8A0018 mark 
                    #"   AND oma16 IS NOT NULL "          #MOD-A30106 add    #MOD-A60193 mark
      END IF                                                                                                                        
      PREPARE t400_g_b_p13 FROM l_sql                                                                                               
      DECLARE t400_g_b_c13 CURSOR FOR t400_g_b_p13                                                                                  
      FOREACH t400_g_b_c13 INTO l_oma.*,l_omc.*    #No.FUN-680022 add omc
       #INITIALIZE b_oob.* TO NULL    #MOD-A50027 add     #MOD-A70047 mark
        LET b_oob.oob12 = ''                              #MOD-A70047
        IF STATUS THEN EXIT FOREACH END IF
 
        IF l_oma.oma02 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
           CONTINUE FOREACH
        END IF
 
        IF g_ooa.ooa23 IS NOT NULL AND l_oma.oma23 != g_ooa.ooa23 THEN
           CONTINUE FOREACH
        END IF
        IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277             

       #-CHI-8A0018-add-
        IF l_oma.oma00 = '23' THEN
           LET l_ombcnt = 0
           SELECT COUNT(*) INTO l_ombcnt
             FROM oma_file,omb_file
            WHERE oma01 = omb01 
              AND oma19 = l_oma.oma01
           IF cl_null(l_ombcnt) THEN LET l_ombcnt = 0 END IF

           LET l_chkcnt = 0
           LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_oma.oma66,'oeb_file'),",",
                       "   oma_file,omb_file ",
                       " WHERE oma01 = omb01 ",
                       "   AND oma19 = '",l_oma.oma01,"'",
                       "   AND omb31 = oeb01 ",
                       "   AND omb32 = oeb03 ",
                       "   AND oeb70 = 'Y' "
           CALL cl_replace_sqldb(g_sql) RETURNING g_sql
           CALL cl_parse_qry_sql(g_sql,l_oma.oma66) RETURNING g_sql
           PREPARE sel_oeb FROM g_sql
           EXECUTE sel_oeb INTO l_chkcnt 
           IF cl_null(l_chkcnt) THEN LET l_ombcnt = 0 END IF

           IF l_ombcnt <> l_chkcnt THEN
              CONTINUE FOREACH
           END IF 
        END IF
       #-CHI-8A0018-end-
       #-MOD-B70009-add-
        LET l_cnt = 0                               #MOD-CB0284 add
        IF l_oma.oma00 = '24' THEN
          #LET l_cnt = 0                            #MOD-CB0284 mark
           SELECT COUNT(*) INTO l_cnt
             FROM nmg_file 
            WHERE nmg00 = l_oma.oma01 
           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
        END IF
       #-MOD-B70009-end-
       #--- 970421 須考慮未確認沖帳資料
        SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
         WHERE oob06=l_omc.omc01 AND ooa01=oob01 AND ooaconf='N' AND oob19=l_omc.omc02  #No.FUN-680022  #No.FUN-7B0055
        IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
        IF cl_null(l_oob10) THEN LET l_oob10=0 END IF
       #-MOD-B70009-add-
        LET g_t1 = s_get_doc_no(l_omc.omc01)
        SELECT ooydmy1 INTO l_ooydmy1 
          FROM ooy_file  
         WHERE ooyslip=g_t1                     
        IF l_ooydmy1 = 'Y' OR l_cnt > 0 THEN
       #-MOD-B70009-end-
           LET b_oob.oob09=l_omc.omc08 -l_omc.omc10 - l_oob09  #No.FUN-680022
           LET b_oob.oob10=l_omc.omc09 -l_omc.omc11 - l_oob10  #No.FUN-680022
       #-MOD-B70009-add-
        ELSE  
           LET b_oob.oob09=l_oma.oma54-l_oma.oma55 - l_oob09   
           LET b_oob.oob10=l_oma.oma56-l_oma.oma57 - l_oob10 
        END IF       
       #-MOD-B70009-end-
        CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net  #No.FUN-680022  #No.FUN-7B0055
        LET b_oob.oob10 = b_oob.oob10 + g_net 
       #---------------------------- 先作未稅
       #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
        LET b_oob.oob03='1'
        LET b_oob.oob04='3'
        LET b_oob.oob06=l_omc.omc01        #No.FUN-680022
        LET b_oob.oob14=NULL
        LET b_oob.oob15=NULL               #No.MOD-950132
        LET b_oob.oob07=l_oma.oma23
        LET b_oob.oob08=l_oma.oma24
 
       #-MOD-B10083-add- 
        IF g_ooz.ooz07 = 'Y' THEN       
           LET b_oob.oob08 = l_omc.omc07   
        ELSE                                       
           LET b_oob.oob08 = l_oma.oma24    
        END IF                                   
       #-MOD-B10083-end- 
        IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
          #-MOD-B10083-mark-
          #IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
          #   LET b_oob.oob08 = l_omc.omc07   #No.FUN-680022 --modify
          #ELSE                                       #MOD-940277
          #	  LET b_oob.oob08 = l_oma.oma24           #MOD-940277
          #END IF                                     #MOD-940277     
          #-MOD-B10083-end- 
           IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
              LET b_oob.oob08 = l_oma.oma24
           END IF
           CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob15)
                RETURNING tot3
           IF (l_oob09+b_oob.oob09+l_omc.omc10) = l_omc.omc08  THEN  #No.FUN-680022 
              LET b_oob.oob10 = tot3 - l_oob10
           END IF
        END IF
 
         SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 #MOD-560077   #No.CHI-6A0004 #MOD-940238 mark
        CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09    #No.CHI-6A0004 
        CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10    #No.CHI-6A0004
        LET b_oob.oob11=l_oma.oma18
        IF g_aza.aza63='Y' THEN           #No.FUN-670047
           LET b_oob.oob111=l_oma.oma181  #No.FUN-670047
        END IF                            #No.FUN-670047
        LET b_oob.oob19 = l_omc.omc02     #No.FUN-680022 add
 
        IF b_oob.oob09<=0 THEN CONTINUE FOREACH END IF   #no:6252
       #CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
        CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
        IF g_flag='1' THEN
           CALL cl_err(l_oma.oma02,'aoo-081',1)
        END IF
        LET l_aag05 = ''
        SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                  AND aag00=g_bookno1      #No.FUN-730073
        IF l_aag05 = 'Y' THEN
           LET b_oob.oob13 = l_oma.oma15
        ELSE
           LET b_oob.oob13 = ''
        END IF
        IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN                    #MOD-A80195
           LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
           IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                   RETURNING l_bookno,b_oob.oob11
              CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                   RETURNING l_bookno,b_oob.oob111
           END IF
           LET b_oob.ooblegal = l_oma.omalegal
           INSERT INTO oob_file VALUES (b_oob.*)
        END IF                                                      #MOD-A80195
       #---------------------------- 再作稅額
       #若'2*'己在axrt300產生分錄,因稅額已在前端立過了,故在此不用再立
        IF l_ooydmy1='N' AND l_oma.oma54x != 0 THEN
          #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
           LET b_oob.oob09=l_oma.oma54x LET b_oob.oob10=l_oma.oma56x
           LET b_oob.oob11=l_ool.ool14
           IF g_aza.aza63='Y' THEN           #No.FUN-670047
              LET b_oob.oob111=l_ool.ool141  #No.FUN-670047          
           END IF                            #No.FUN-670047
           CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09      #No.CHI-6A0004
           CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10      #No.CHI-6A0004
           IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN                    #MOD-A80195
              LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
              IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
                 CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                      RETURNING l_bookno,b_oob.oob11
                 CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                      RETURNING l_bookno,b_oob.oob111
              END IF
              INSERT INTO oob_file VALUES (b_oob.*)
           END IF                                                      #MOD-A80195
        END IF
      END FOREACH
   END IF
   #----------------------------------- #由應付系統產生單身
   IF sw4='Y' THEN
      #FUN-B50090 add begin-------------------------
      #重新抓取關帳日期
      SELECT apz57 INTO g_apz.apz57 FROM apz_file WHERE apz00='0'
      #FUN-B50090 add -end--------------------------
     #-CHI-B20040-add-
      IF g_ooa.ooa02 <= g_apz.apz57 THEN   #立帳日期不可小於關帳日期
         CALL cl_err('','axr-084',1)
         RETURN
      END IF
     #-CHI-B20040-end-
      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
      LET l_sql = " SELECT apa_file.*,apc_file.* FROM apa_file,apc_file ",
        "  WHERE ",g_wc clipped,
        "  AND apa41 = 'Y' and apa42 = 'N' AND apa00 matches '1*' ",
        "  AND apa01 = apc01 ",
        "  AND apa02 <= '",g_ooa.ooa02 CLIPPED,"'"        #MOD-A30146 add
 
       PREPARE t400_prec14 FROM l_sql
       DECLARE t400_g_b_c14 CURSOR FOR t400_prec14
 
       FOREACH t400_g_b_c14 INTO l_apa.*,l_apc.*  #No.FUN-680022 apc
        #INITIALIZE b_oob.* TO NULL    #MOD-A50027 add     #MOD-B10081 mark
         LET b_oob.oob12 = ''                              #MOD-B10081
         IF STATUS THEN EXIT FOREACH END IF
 
         IF l_apa.apa02 > g_ooa.ooa02 THEN #單身立帳日期不可大於單頭沖帳日期
            CONTINUE FOREACH
         END IF
 
        #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
         LET b_oob.oob03='1'
         LET b_oob.oob04='9'
         LET b_oob.oob06=l_apa.apa01
         LET b_oob.oob07=l_apa.apa13
         #apz27(月底重評價當月認列匯差,次月不回轉)為N時抓apa14,為Y時抓apa72
         IF g_apz.apz27 = 'N' THEN   #MOD-8A0254 add
            LET b_oob.oob08=l_apa.apa14   #匯率
         ELSE
            LET b_oob.oob08=l_apa.apa72   #重估匯率
         END IF
#         LET b_oob.oob14=' '
         LET b_oob.oob14=l_apa.apa08    #No.TQC-BC0211 
         LET b_oob.oob15=0   #MOD-8B0210 add
         LET b_oob.oob19=l_apc.apc02   #No.FUN-680022 add
         SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 recuva
        #LET b_oob.oob09 = l_apc.apc08 - l_apc.apc10 - l_apc.apc16     #MOD-820134 #MOD-C20036 mark  
         LET b_oob.oob09 = l_apc.apc08 - l_apc.apc10 - l_apc.apc16 - l_apc.apc14   #MOD-C20036 add
         IF g_apz.apz27 = 'N' THEN
           #LET b_oob.oob10 = l_apc.apc09 - l_apc.apc11 - (l_apc.apc16*l_apc.apc06)    #MOD-820134 #MOD-C20036 mark
            LET b_oob.oob10 = l_apc.apc09 - l_apc.apc11 - (l_apc.apc16*l_apc.apc06) - l_apc.apc15  #MOD-C20036 add
         ELSE
            LET b_oob.oob10=l_apc.apc13-(l_apc.apc16 * l_apc.apc07)   #MOD-820134
         END IF
 
         #須考慮未確認沖帳資料
         SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10
           FROM oob_file,ooa_file
          WHERE oob06 = l_apa.apa01 AND oob01 = ooa01 AND ooaconf = 'N'
            AND oob03='1' AND oob04='9'   #MOD-820134
            AND oob19 = l_apc.apc02   #MOD-820134
         IF cl_null(l_oob09) THEN LET l_oob09=0 END IF
         IF cl_null(l_oob10) THEN LET l_oob10=0 END IF
         SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
           FROM apg_file,apf_file
          WHERE apg04=l_apa.apa01
            AND apg06=l_apc.apc02
            AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
         IF cl_null(p05f) THEN LET p05f=0 END IF
         IF cl_null(p05) THEN LET p05=0 END IF
         LET b_oob.oob09 = b_oob.oob09 - l_oob09 - p05f
         LET b_oob.oob10 = b_oob.oob10 - l_oob10 - p05
 
         CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004
         CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004
         LET b_oob.oob11=l_apa.apa54
         IF g_aza.aza63='Y' THEN            #No.FUN-670047
            LET b_oob.oob111=l_apa.apa541   #No.FUN-670047
         END IF                             #No.FUN-670047
        #CALL s_get_bookno(YEAR(l_apa.apa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
         CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
         IF g_flag='1' THEN
            CALL cl_err(l_apa.apa02,'aoo-081',1)
         END IF
         LET l_aag05 = ''
         SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                   AND aag00=g_bookno1      #No.FUN-730073
         IF l_aag05 = 'Y' THEN
            LET b_oob.oob13 = l_apa.apa22
         ELSE
            LET b_oob.oob13 = ''
         END IF
         IF b_oob.oob09 =0 THEN  #no:6612
            CONTINUE FOREACH
         END IF
         LET b_oob.oob12 = l_apa.apa25   #MOD-780261
         LET b_oob.ooblegal = g_ooa.ooalegal
         IF b_oob.oob09 >0 OR b_oob.oob10 > 0 THEN                    #MOD-A80195
            LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
            IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
               CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                    RETURNING l_bookno,b_oob.oob11
               CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                    RETURNING l_bookno,b_oob.oob111
            END IF
            INSERT INTO oob_file VALUES (b_oob.*)
         END IF                                                      #MOD-A80195
       END FOREACH
   END IF
   CALL t400_bu()   #MOD-630069
 
END FUNCTION
 
FUNCTION t400_g_b2()
   DEFINE gen_sw        LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)
   DEFINE l_sql         LIKE type_file.chr1000            #No.FUN-680123 VARCHAR(300)
   DEFINE g_wc          string                            #No.FUN-580092 HCN
   DEFINE g_sql         string                            #No.FUN-580092 HCN
   DEFINE l_oma            RECORD LIKE oma_file.*
   DEFINE l_omb            RECORD LIKE omb_file.*
   DEFINE l_omc            RECORD LIKE omc_file.*         #No.FUN-680022 --add
   DEFINE debit_tot,credit_tot    LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6) #FUN-4C0013
   DEFINE t14t,p14t      LIKE omb_file.omb14
   DEFINE t16t,p16t      LIKE omb_file.omb16
   DEFINE l_apa  RECORD LIKE apa_file.*
   DEFINE s_omab DYNAMIC ARRAY OF RECORD
                        sel       LIKE type_file.chr1,    #No.FUN-680123 VARCHAR(1),
                        omb01     LIKE omb_file.omb01,
                        omc02     LIKE omc_file.omc02,    #No.FUN-680022 --add
                        omb04     LIKE omb_file.omb04,
                        omb06     LIKE omb_file.omb06,
                        omb03     LIKE omb_file.omb03,
                        oma10     LIKE oma_file.oma10,
                        oma67     LIKE oma_file.oma67,   #FUN-810074
                        oma23     LIKE oma_file.oma23,
                        omb14t    LIKE omb_file.omb14,
                        omb16t    LIKE omb_file.omb16
                        END RECORD
   DEFINE i,j,k         LIKE type_file.num5           #No.FUN-680123 SMALLINT   #MOD-B30579 add k
   DEFINE un_conf_amt1  LIKE oma_file.oma54
   DEFINE un_conf_amt2  LIKE oma_file.oma56
   DEFINE l_oma00       LIKE oma_file.oma00
   DEFINE l_omb34       LIKE omb_file.omb34
   DEFINE l_omb14t      LIKE omb_file.omb14t
   DEFINE ls_tmp STRING
   DEFINE l_allow_insert  LIKE type_file.num5    #No.FUN-680123 SMALLINT               #可新增否
   DEFINE l_allow_delete  LIKE type_file.num5    #No.FUN-680123 SMALLINT               #可刪除否
   DEFINE tot4,tot4t      LIKE type_file.num20_6 #No.FUN-680123 DEC(20,6)              #TQC-5B0171
   DEFINE l_aag05         LIKE aag_file.aag05   #MOD-730022
   DEFINE l_bookno        LIKE aag_file.aag00   #No.FUN-740184
   DEFINE l_omc02         LIKE omc_file.omc02    #MOD-970255      
 
   ### 自動沖帳開窗勾選資料產生步驟:
   ### 1.將符合條件的資料放到Temptable
   ### 2.將Temptable資料撈到array準備給user勾選，順便將不符合條件的資料從temp中刪除
   ### 3.開窗給user勾選
   ### 4.輸入完後，將array中的資料『沒有勾選』的從Temptable中刪除
   ### 5.將Temptable資料塞入oob_file

   SELECT COUNT(*) INTO i FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
   IF i=0 THEN RETURN END IF

   LET p_row = 11 LET p_col = 27
   OPEN WINDOW t4008_w AT p_row,p_col WITH FORM "axr/42f/axrt4008"
        ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   CALL cl_ui_locale("axrt4008")
 
   INPUT BY NAME gen_sw
      AFTER FIELD gen_sw
          IF gen_sw NOT MATCHES "[0123]" THEN NEXT FIELD gen_sw END IF

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
   CLOSE WINDOW t4008_w
   IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
   IF gen_sw=0 THEN RETURN END IF
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
   #-------借:
   SELECT SUM(oob09) INTO debit_tot FROM oob_file
    WHERE oob01=b_oob.oob01 AND oob03='1'
   IF cl_null(debit_tot) THEN LET debit_tot= 0 END IF
   IF gen_sw='2' AND debit_tot <= 0 THEN RETURN END IF
   #-------貸:
   SELECT SUM(oob09) INTO credit_tot FROM oob_file
    WHERE oob01=b_oob.oob01 AND oob03='2'
   IF cl_null(credit_tot) THEN LET credit_tot= 0 END IF
   LET debit_tot = debit_tot - credit_tot
   IF gen_sw = 2 AND debit_tot = 0 THEN 
      RETURN 
   END IF

   SELECT MAX(oob02) INTO b_oob.oob02 FROM oob_file WHERE oob01=b_oob.oob01
   IF cl_null(b_oob.oob02) THEN 
      LET b_oob.oob02 = 0 
   END IF 	       
 
   MESSAGE "WAITING ....."
   DROP TABLE omab_tmp
   ### 1.將符合條件的資料放到Temptable
   IF g_ooz.ooz62='N' THEN    #不衝賬至項次
      IF g_ooz.ooz07 = 'N' THEN
         SELECT oma_file.*,omc_file.* FROM oma_file,omc_file #No.FUN-680022 --add omc_file 
          WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
            AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
            AND (omc08 >omc10 OR omc09 >omc11) AND oma00 LIKE "1%"   #No.FUN-680022 --modify--
            AND oma01=omc01                                             #No.FUN-680022 --add
            AND omaconf='Y'
            AND omavoid = 'N'
            AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
           INTO TEMP omab_tmp
      ELSE                                                                                                                       
         SELECT oma_file.*,omc_file.* FROM oma_file,omc_file      #No.FUN-680022 --add omc_file
          WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
            AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
            AND (omc08 >omc10 OR omc13>0) AND oma00 LIKE "1%"     #No.FUN-680022 --modify--    #MOD-790016
            AND oma01=omc01                                          #No.FUN-680022 --add
            AND omaconf='Y'    
            AND omavoid = 'N' 
            AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
           INTO TEMP omab_tmp                                                                                                    
      END IF                                                                                                                     
   ELSE                      #衝賬至項次
      IF g_ooz.ooz07 = 'N' THEN
         SELECT oma_file.*,omb_file.*,omc02 FROM oma_file,omb_file,omc_file #MOD-970255 add omc   
          WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
            AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
            AND oma01 = omc01 #MOD-970255   
            AND omaconf='Y' AND oma01=omb01 AND omavoid='N'
            AND (oma54t>oma55 OR oma56t>oma57) AND oma00 MATCHES "1*"
            AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
           INTO TEMP omab_tmp
      ELSE                                                                                                                       
         SELECT oma_file.*,omb_file.*,omc02 FROM oma_file,omb_file,omc_file #MOD-970255 add omc                                                                       
          WHERE oma68 = g_ooa.ooa03           #No.FUN-670026                                                                         
            AND oma69 = g_ooa.ooa032          #No.FUN-670026                                                                         
            AND oma01 = omc01 #MOD-970255   
            AND omaconf='Y' AND oma01=omb01 AND omavoid='N'                                                                      
            AND (oma54t>oma55 OR oma61>0) AND oma00 MATCHES "1*"                                                                 
            AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
           INTO TEMP omab_tmp                                                                                                    
      END IF                                                                                                                     
   END IF
   IF STATUS THEN CALL cl_err('ins omab_tmp:',STATUS,1) RETURN END IF

   IF gen_sw='3' THEN     #開窗挑選
      LET p_row = 6 LET p_col = 3
      OPEN WINDOW t4007_w AT p_row,p_col WITH FORM "axr/42f/axrt4007"
            ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
      CALL cl_ui_locale("axrt4007")
 
      IF g_ooz.ooz62='N' THEN        #是否沖到應收單身
         IF g_ooz.ooz07 = 'N' THEN
            LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma67,oma23,",   #FUN-810074
                      " omc08-omc10,omc09-omc11,oma00,omc10,omc08",
                      " FROM omab_tmp",
                      " ORDER BY omc01,omc02"
         ELSE                                                                                                                       
            LET l_sql="SELECT 'N',omc01,omc02,'','','',oma10,oma67,oma23,",   #FUN-810074
                      " omc08-omc10,omc13,oma00,omc10,omc08",
                      " FROM omab_tmp",
                      " ORDER BY omc01,omc02"
         END IF                                                                                                                     
      ELSE
         IF g_ooz.ooz07 = 'N' THEN
            LET l_sql="SELECT 'N',omb01,omc02,omb04,omb06,omb03,oma10,oma67,oma23,", #MOD-970255   
                      " omb14t-omb34,omb16t-omb35,oma00,omb34,omb14t",
                      " FROM omab_tmp",
                      " ORDER BY omb01,omb03"
         ELSE                                                                                                                       
            LET l_sql="SELECT 'N',omb01,omc02,omb04,omb06,omb03,oma10,oma67,oma23,",  #MOD-970255          
                      " omb14t-omb34,omb37,oma00,omb34,omb14t",
                      " FROM omab_tmp",   
                      " ORDER BY omb01,omb03"  
         END IF                                                                                                                     
      END IF
      PREPARE t400_tmp FROM l_sql
      DECLARE omab_tmp_c CURSOR FOR t400_tmp
      LET i=1
      CALL s_omab.clear()
   ### 2.將Temptable資料撈到array準備給user勾選，順便將不符合條件的資料從temp中刪除
      FOREACH omab_tmp_c INTO s_omab[i].*,l_oma00,l_omb34,l_omb14t
       #str MOD-B30579 add
       ###當資料>最大筆數時，將後面的資料刪除(因為畫面出不來)
        IF i > g_max_rec THEN
           IF g_ooz.ooz62='N' THEN
              DELETE FROM omab_tmp
               WHERE oma01=s_omab[i].omb01
                 AND omc02=s_omab[i].omc02   #MOD-9C0320 add
           ELSE
              DELETE FROM omab_tmp
               WHERE omb01=s_omab[i].omb01
                 AND omb03=s_omab[i].omb03
                 AND omc02=s_omab[i].omc02   #MOD-9C0320 add
           END IF
           INITIALIZE s_omab[i].* TO NULL
           LET i = i + 1
           CONTINUE FOREACH
        END IF
       #end MOD-B30579 add
        IF s_omab[i].oma23 != g_ooa.ooa23 THEN
           IF g_ooz.ooz62='N' THEN
             DELETE FROM omab_tmp
              WHERE oma01=s_omab[i].omb01
               #AND omb19=s_omab[i].omc02   #MOD-B30579 mark
                AND omc02=s_omab[i].omc02   #MOD-9C0320 add
           ELSE
             DELETE FROM omab_tmp
              WHERE omb01=s_omab[i].omb01
                AND omb03=s_omab[i].omb03
                AND omc02=s_omab[i].omc02   #MOD-9C0320 add
           END IF
           INITIALIZE s_omab[i].* TO NULL
           CONTINUE FOREACH
        END IF
        #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
        LET un_conf_amt1=0 LET un_conf_amt2=0
        IF g_ooz.ooz62='Y' THEN
           SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
             FROM oob_file, ooa_file
            WHERE oob06=s_omab[i].omb01 AND oob15=s_omab[i].omb03
              AND oob03='2' AND oob09 IS NOT NULL
              AND oob01=ooa01 AND ooaconf='N'
        ELSE
           SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
             FROM oob_file, ooa_file
            WHERE oob06=s_omab[i].omb01 AND oob19=s_omab[i].omc02       #No.FUN-680022 --modify
              AND oob03='2' AND oob09 IS NOT NULL
              AND oob01=ooa01 AND ooaconf='N'
        END IF
        IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
        IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
        LET s_omab[i].omb14t=s_omab[i].omb14t-un_conf_amt1
        LET s_omab[i].omb16t=s_omab[i].omb16t-un_conf_amt2
 
        IF g_ooz.ooz07 = 'Y' AND s_omab[i].oma23 != g_aza.aza17 THEN
           IF g_ooz.ooz62='Y' THEN      #No.FUN-680022 --add
              CALL s_g_np('1',l_oma00,s_omab[i].omb01,s_omab[i].omb03)
                   RETURNING tot3
              #取得衝帳單的待扺金額
              CALL t400_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
              CALL cl_digcut(tot4,t_azi04) RETURNING tot4       #No.CHI-6A0004
              CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
              #未衝金額扣除待扺
              LET tot3 = tot3 - tot4t
              IF (un_conf_amt1+s_omab[i].omb14t+l_omb34) = l_omb14t THEN
                 LET s_omab[i].omb16t = tot3 - un_conf_amt2
              END IF
           END IF      #No.FUN-680022 --add
        END IF
 
        IF s_omab[i].omb14t<=0 THEN
          IF g_ooz.ooz62='Y' THEN
           DELETE FROM omab_tmp
            WHERE omb01=s_omab[i].omb01 AND omb03=s_omab[i].omb03
              AND omc02=s_omab[i].omc02   #MOD-9C0320 add
          ELSE
           DELETE FROM omab_tmp
            WHERE oma01=s_omab[i].omb01 #AND omb03=s_omab[i].omc02   #NO.FUN-680022 --add  #MOD-9C0320 mod
              AND omc02=s_omab[i].omc02   #MOD-9C0320 add
          END IF
           INITIALIZE s_omab[i].* TO NULL
           CONTINUE FOREACH
        END IF
        LET i=i+1
        IF i > g_max_rec THEN     #CHI-BA0037
           EXIT FOREACH           #CHI-BA0037
        END IF                    #CHI-BA0037
      END FOREACH
 
     #str MOD-B30579 add
      ###當資料>最大筆數時，將後面的ARRAY清除
      IF i > g_max_rec THEN
         FOR k = g_max_rec+1 TO i
             CALL s_omab.deleteElement(k)
         END FOR
         LET i = g_max_rec
      ELSE
     #end MOD-B30579 add
         #MOD-490095
         CALL s_omab.deleteElement(i)
         LET i = i - 1
         #--
      END IF   #MOD-B30579 add
 
      DROP TABLE omab_tmp  #CHI-BA0037

   ### 3.開窗給user勾選
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")
 
      INPUT ARRAY s_omab WITHOUT DEFAULTS FROM s_omab.*
            ATTRIBUTE(COUNT=i,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
         BEFORE FIELD sel
           LET t14t=0 LET t16t=0
           LET p14t=0 LET p16t=0
 
         ON CHANGE sel      #MOD-A50061 add
           LET t14t=0 LET t16t=0                            #MOD-AB0062
           LET p14t=0 LET p16t=0                            #MOD-AB0062
           FOR g_cnt=1 TO i
              IF s_omab[g_cnt].omb01 IS NULL THEN CONTINUE FOR END IF
              LET t14t=t14t+s_omab[g_cnt].omb14t
              LET t16t=t16t+s_omab[g_cnt].omb16t
             #IF s_omab[g_cnt].sel='Y' AND s_omab[g_cnt].sel IS NOT NULL   #MOD-AB0062 mark
             #   AND s_omab[g_cnt].sel <>' ' THEN                          #MOD-AB0062 mark
              IF s_omab[g_cnt].sel='Y' THEN                                #MOD-AB0062 
                 LET p14t=p14t+s_omab[g_cnt].omb14t
                 LET p16t=p16t+s_omab[g_cnt].omb16t
              END IF
           END FOR
           DISPLAY BY NAME t14t,t16t,p14t,p16t
 
         AFTER INPUT
           FOR g_cnt=1 TO i
             #IF s_omab[g_cnt].sel='Y' AND s_omab[g_cnt].sel IS NOT NULL #CHI-BA0037 mark
             #   AND s_omab[i].sel <>' ' THEN                            #CHI-BA0037 mark
             #-CHI-BA0037-add-
              IF s_omab[g_cnt].sel='Y' THEN  
                 IF g_ooz.ooz62='N' THEN
                    SELECT oma_file.*,omc_file.* 
                      FROM oma_file,omc_file 
                     WHERE oma01 = s_omab[g_cnt].omb01 
                       AND oma01 = omc01 
                       AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
                       AND omc02 = s_omab[g_cnt].omc02                    #MOD-CA0093 add
                      INTO TEMP omab_tmp 
                 ELSE
                    SELECT oma_file.*,omb_file.*,omc02 
                      FROM oma_file,omb_file,omc_file 
                     WHERE oma01 = s_omab[g_cnt].omb01 
                       AND omb03 = s_omab[g_cnt].omb03 
                       AND oma01 = omc01 
                       AND oma01 = omb01
                       AND oma02 <= g_ooa.ooa02                                    #MOD-BC0274 add
                       AND omc02 = s_omab[g_cnt].omc02                    #MOD-CA0093 add
                      INTO TEMP omab_tmp 
                 END IF
             #-CHI-BA0037-end-
                 CONTINUE FOR
              END IF
              IF s_omab[g_cnt].omb01 IS NULL THEN CONTINUE FOR END IF
   ### 4.輸入完後，將array中的資料『沒有勾選』的從Temptable中刪除
             #-CHI-BA0037-mark-
             #IF g_ooz.ooz62='Y' THEN
             #   DELETE FROM omab_tmp
             #    WHERE omb01=s_omab[g_cnt].omb01
             #      AND omb03=s_omab[g_cnt].omb03
             #      AND omc02=s_omab[g_cnt].omc02   #MOD-9C0320 add
             #ELSE
             #   DELETE FROM omab_tmp
             #    WHERE oma01=s_omab[g_cnt].omb01
             #      AND omc02=s_omab[g_cnt].omc02   #No.FUN-680022 --add
             #END IF
             #-CHI-BA0037-end-
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
 
      IF INT_FLAG THEN 
         LET INT_FLAG=0
         ###放棄時，將Temptable資料刪除
         DELETE FROM omab_tmp   #MOD-B30579 add
      END IF
      CLOSE WINDOW t4007_w
   END IF

   ### 5.將Temptable資料塞入oob_file
   IF g_ooz.ooz62='N' THEN
     DECLARE t400_g_b_c211 CURSOR FOR                       #由應收產生單身
      SELECT * FROM omab_tmp ORDER BY oma01,omc02    #No.FUN-680022 --add
     FOREACH t400_g_b_c211 INTO l_oma.*,l_omc.*
       IF STATUS THEN EXIT FOREACH END IF
      #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
       SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
         FROM oob_file, ooa_file
        WHERE oob06=l_oma.oma01 AND oob03='2' AND oob09 IS NOT NULL
          AND oob19=l_omc.omc02 AND oob01=ooa01 AND ooaconf='N'  #No.FUN-680022 --add
       IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
       IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
       LET l_omc.omc08 =l_omc.omc08 -un_conf_amt1         #No.FUN-680022 --add
       LET l_omc.omc09 =l_omc.omc09 -un_conf_amt2         #No.FUN-680022 --add 
       IF l_omc.omc08 <=0 THEN CONTINUE FOREACH END IF    #No.FUN-680022 --add
       IF l_oma.oma23 != g_ooa.ooa23 THEN CONTINUE FOREACH END IF
       IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277            
      #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
       LET b_oob.oob03='2'
       LET b_oob.oob04='1'
       LET b_oob.oob06=l_omc.omc01      #No.FUN-680022 --add
       LET b_oob.oob19=l_omc.omc02      #No.FUN-680022 --add
       LET b_oob.oob14=l_oma.oma10
       LET b_oob.oob07=l_oma.oma23
       LET b_oob.oob08=l_oma.oma24
       LET b_oob.oob09=l_omc.omc08 -l_omc.omc10     #No.FUN-680022 --add
       LET b_oob.oob10=l_omc.omc09 -l_omc.omc11     #No.FUN-680022 --add
       LET b_oob.ooblegal = g_ooa.ooalegal
       CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net #No.FUN-680022 --add #No.FUN-7B0055 
       LET b_oob.oob10 = b_oob.oob10 + g_net                                                                                        
       LET b_oob.oob11=l_oma.oma18
       IF g_aza.aza63='Y' THEN          #No.FUN-670047
          LET b_oob.oob111=l_oma.oma181 #No.FUN-670047
       END IF                           #No.FUN-670047
      #CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
       CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
       IF g_flag='1' THEN
          CALL cl_err(l_oma.oma02,'aoo-081',1)
       END IF
       LET l_aag05 = ''
       SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                 AND aag00=g_bookno1      #No.FUN-730073
       IF l_aag05 = 'Y' THEN
          LET b_oob.oob13 = l_oma.oma15
       ELSE
          LET b_oob.oob13 = ''
       END IF
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 recuva
       IF gen_sw='2' AND debit_tot < b_oob.oob09 THEN
          LET b_oob.oob09 = debit_tot
         IF b_oob.oob09 = l_omc.omc08  THEN
            LET b_oob.oob10 = l_omc.omc09 
         ELSE
            LET b_oob.oob10 = debit_tot * b_oob.oob08
         END IF
       END IF
      #-MOD-B10083-add- 
       IF g_ooz.ooz07 = 'Y' THEN       
          LET b_oob.oob08 = l_omc.omc07   
       ELSE                                       
          LET b_oob.oob08 = l_oma.oma24    
       END IF                                   
      #-MOD-B10083-end- 
       IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
         #-MOD-B10083-mark-
         #IF g_apz.apz27 = 'Y' THEN                 #MOD-940277
         #  LET b_oob.oob08 = l_omc.omc07
         #ELSE                                      #MOD-940277
         #	 LET b_oob.oob08 = l_oma.oma24           #MOD-940277
         #END IF                                    #MOD-940277	   
         #-MOD-B10083-end- 
          IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
             LET b_oob.oob08 = l_oma.oma24
          END IF
#         CALL s_g_np1('1',l_oma.oma00,b_oob.oob06,'',b_oob.oob19)  #No.FUN-7B0055
          CALL s_g_np1('1',l_oma.oma00,b_oob.oob06,b_oob.oob15,b_oob.oob19)  #No.FUN-7B0055 FUN-AB0034
               RETURNING tot3
          #發票待扺針對整張衝帳單,先不考慮ooz62='Y'的情形
          #取得衝帳單的待扺金額
          CALL t400_mntn_offset_inv(s_omab[i].omb01) RETURNING tot4,tot4t
          CALL cl_digcut(tot4,t_azi04) RETURNING tot4    #No.CHI-6A0004
          CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t  #No.CHI-6A0004
          #未衝金額扣除待扺
          LET tot3 = tot3 - tot4t
          IF (un_conf_amt1+b_oob.oob09+l_omc.omc10) = l_omc.omc08  THEN
             LET b_oob.oob10 = tot3 - un_conf_amt2
          END IF
       END IF
 
       CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004
       CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004 
       IF b_oob.oob09 > 0 OR b_oob.oob10 > 0 THEN                    #MOD-A80195
          LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
          IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
             CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                  RETURNING l_bookno,b_oob.oob11
             CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                  RETURNING l_bookno,b_oob.oob111
          END IF
          INSERT INTO oob_file VALUES (b_oob.*)
       END IF                                                       #MOD-A80195
       LET debit_tot=debit_tot - b_oob.oob09
       IF gen_sw='2' AND debit_tot <= 0 THEN EXIT FOREACH END IF
     END FOREACH
  ELSE
     DECLARE t400_g_b_c212 CURSOR FOR                       #由應收產生單身
      SELECT * FROM omab_tmp ORDER BY omb01,omb03
     FOREACH t400_g_b_c212 INTO l_oma.*,l_omb.*,l_omc02 #MOD-970255 add omc       
       IF STATUS THEN EXIT FOREACH END IF
      #------------- 970123 roger 檢查其他未確認沖帳資料, 以免重複
       SELECT SUM(oob09),SUM(oob10) INTO un_conf_amt1, un_conf_amt2
         FROM oob_file, ooa_file
        WHERE oob06=l_omb.omb01 AND oob15=l_omb.omb03
          AND oob03='2' AND oob09 IS NOT NULL
          AND oob01=ooa01 AND ooaconf='N'
       IF un_conf_amt1 IS NULL THEN LET un_conf_amt1 = 0 END IF
       IF un_conf_amt2 IS NULL THEN LET un_conf_amt2 = 0 END IF
       LET l_omb.omb14t=l_omb.omb14t-un_conf_amt1
       LET l_omb.omb16t=l_omb.omb16t-un_conf_amt2
       IF l_omb.omb14t<=0 THEN CONTINUE FOREACH END IF
       IF l_oma.oma23 != g_ooa.ooa23 THEN CONTINUE FOREACH END IF
       IF l_oma.oma54t <= l_oma.oma55 THEN CONTINUE FOREACH END IF      #MOD-940277            
      #LET b_oob.oob02=b_oob.oob02+1   #MOD-B60135 mark
       LET b_oob.oob03='2'
       LET b_oob.oob04='1'
       LET b_oob.oob06=l_oma.oma01
       LET b_oob.oob14=l_oma.oma10
       LET b_oob.oob07=l_oma.oma23
       LET b_oob.oob08=l_oma.oma24
       LET b_oob.oob09=l_omb.omb14t-l_omb.omb34
       LET b_oob.oob10=l_omb.omb16t-l_omb.omb35
       LET b_oob.oob11=l_oma.oma18
       IF g_aza.aza63='Y' THEN          #No.FUN-670047
          LET b_oob.oob111=l_oma.oma181 #No.FUN-670047
       END IF                           #No.FUN-670047
      #CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
       CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
       IF g_flag='1' THEN
          CALL cl_err(l_oma.oma02,'aoo-081',1)
       END IF
       LET l_aag05 = ''
       SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                                 AND aag00=g_bookno1      #No.FUN-730073
       IF l_aag05 = 'Y' THEN
          LET b_oob.oob13 = l_oma.oma15
       ELSE
          LET b_oob.oob13 = ''
       END IF
       LET b_oob.oob15=l_omb.omb03
       SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 recuva
       IF gen_sw='2' AND debit_tot < b_oob.oob09 THEN
          LET b_oob.oob09 = debit_tot
          IF b_oob.oob09 = l_omb.omb14t THEN
             LET b_oob.oob10 = l_omb.omb16t
          ELSE
             LET b_oob.oob10 = debit_tot * b_oob.oob08
          END IF
       END IF
      #-MOD-B10083-add- 
       IF g_ooz.ooz07 = 'Y' THEN       
          LET b_oob.oob08 = l_oma.oma60
       ELSE                                       
          LET b_oob.oob08 = l_oma.oma24     
       END IF                                   
      #-MOD-B10083-end- 
       IF g_ooz.ooz07 = 'Y' AND b_oob.oob07 != g_aza.aza17 THEN
         #-MOD-B10083-mark-
         #IF g_apz.apz27 = 'Y' THEN                #MOD-940277
         #   LET b_oob.oob08 = l_oma.oma60
         #ELSE                                     #MOD-940277
         #	 LET b_oob.oob08 = l_oma.oma24         #MOD-940277
         #END IF                                   #MOD-940277	    
         #-MOD-B10083-mark-
          IF cl_null(b_oob.oob08) OR b_oob.oob08 = 0 THEN
             LET b_oob.oob08 = l_oma.oma24
          END IF
          CALL s_g_np('1',l_oma.oma00,b_oob.oob06,b_oob.oob15)
               RETURNING tot3
          IF (un_conf_amt1+b_oob.oob09+l_omb.omb34) = l_omb.omb14t THEN
             LET b_oob.oob10 = tot3 - un_conf_amt2
          END IF
       END IF
 
       CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09      #No.CHI-6A0004
       CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10      #No.CHI-6A0004
       IF b_oob.oob09 > 0 OR b_oob.oob10 > 0 THEN                     #MOD-A80195
          LET b_oob.oob02=b_oob.oob02+1           #MOD-B60135
          IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
             CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,b_oob.oob11)
                  RETURNING l_bookno,b_oob.oob11
             CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,b_oob.oob111)
                  RETURNING l_bookno,b_oob.oob111
          END IF
          LET b_oob.ooblegal = g_ooa.ooalegal
          LET b_oob.oob19 = l_omc02 #MOD-970255 
          INSERT INTO oob_file VALUES (b_oob.*)
       END IF                                                        #MOD-A80195
       LET debit_tot=debit_tot - b_oob.oob09
       IF gen_sw='2' AND debit_tot <= 0 THEN EXIT FOREACH END IF
     END FOREACH
  END IF
   DROP TABLE omab_tmp   #TQC-620114
   CALL t400_bu()
   CALL t400_b_fill(' 1=1')
   CALL t400_b_fill_2('1=1') #FUN-A90003 Add
END FUNCTION
 
FUNCTION t400_u()
   DEFINE l_yy,l_mm   LIKE type_file.num5        #No.FUN-680123 SMALLINT
   DEFINE l_occ       RECORD LIKE occ_file.*     #MOD-9A0204 add
 
   IF s_shut(0) THEN RETURN END IF
   IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0) RETURN
   END IF
   IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
   #FUN-C30140---add----str---
   IF g_ooa.ooa34 matches '[Ss]' THEN
       CALL cl_err('','apm-030',0)
       RETURN
   END IF
   #FUN-C30140---add----end---
   #FUN-C30029--add--str
   IF g_azw.azw04='2' AND g_ooa.ooa38<>'2' THEN
      CALL cl_err('','aap-829',0)
      RETURN
   END IF
   #FUN-C30029--add--end 

    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_ooa_o.* = g_ooa.*
    LET g_success = 'Y'   #MOD-730060
    BEGIN WORK
 
    OPEN t400_cl USING g_ooa.ooa01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
        CLOSE t400_cl ROLLBACK WORK RETURN
    END IF
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
    CALL t400_show()
    WHILE TRUE
       LET g_ooa.ooamodu=g_user                # 不可改單號,客戶...
       LET g_ooa.ooadate=g_today
       IF g_ooa.ooa34 matches '[Ss]' THEN
          CALL cl_set_comp_entry("ooa14,ooa02,ooa15,ooa03",FALSE)
       ELSE
          CALL cl_set_comp_entry("ooa14,ooa02,ooa15,ooa03",TRUE) 
       END IF
       LET g_cnt = 0
       SELECT COUNT(*) INTO g_cnt FROM oob_file WHERE oob01=g_ooa.ooa01
       IF cl_null(g_cnt) THEN LET g_cnt=0 END IF
       CALL cl_set_comp_entry("ooa03",g_cnt=0)
       INPUT BY NAME g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa13,g_ooa.ooa14,   #MOD-9A0204 add ooa03
                     g_ooa.ooa15,g_ooa.ooa23,g_ooa.ooa40,    #FUC-C20018 add ooa40
                     g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,
                     g_ooa.ooaud04,g_ooa.ooaud05,g_ooa.ooaud06,
                     g_ooa.ooaud07,g_ooa.ooaud08,g_ooa.ooaud09,
                     g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
                     g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15 
                     WITHOUT DEFAULTS
 
           AFTER FIELD ooa02
             IF g_ooa.ooa34 NOT matches '[Ss]' THEN    #FUN-8A0075
             #FUN-B50090 add begin-------------------------
             #重新抓取關帳日期
             SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
             #FUN-B50090 add -end--------------------------
             IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
                CALL cl_err('','axr-164',0) NEXT FIELD ooa02
             END IF
             IF g_ooz.ooz07 = 'Y' THEN
                LET l_yy = YEAR(g_ooa.ooa02)
                LET l_mm = MONTH(g_ooa.ooa02)
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) < 1 THEN  #MOD-8B0213
                   CALL cl_err(g_ooa.ooa02,'axr-405',0)
                   NEXT FIELD ooa02   #MOD-830047
                END IF
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) = 0 THEN
                   CALL cl_err(g_ooa.ooa02,'axr-406',0) NEXT FIELD ooa02
                END IF
             END IF
            #FUN-D90016---add--str---
             IF g_ooa.ooa23 != g_aza.aza17 THEN
                IF YEAR(g_ooa.ooa02) = YEAR(g_ooa_t.ooa02) THEN
                   IF g_ooa.ooa02 < s_first(g_ooa_t.ooa02) OR
                      g_ooa.ooa02 > s_last(g_ooa_t.ooa02) THEN
                      CALL cl_err(g_ooa.ooa02,'axr-841',0)
                      NEXT FIELD ooa02
                   END IF
                ELSE
                   CALL cl_err(g_ooa.ooa02,'axr-842',0)
                   NEXT FIELD ooa02
                END IF
             END IF
            #FUN-D90016---add--end---
             LET g_cnt=0
             SELECT COUNT(*) INTO g_cnt FROM oob_file,oma_file
              WHERE oma02 > g_ooa.ooa02
                AND oob03='2' AND oob04='1' AND oob06=oma01
                AND oob06 IS NOT NULL
                AND oob01=g_ooa.ooa01
             IF g_cnt >0 AND g_cnt IS NOT NULL THEN
                CALL cl_err('','axr-371',0)
                LET g_ooa.ooa02 = g_ooa_t.ooa02
                DISPLAY BY NAME g_ooa.ooa02
                NEXT FIELD ooa02
                 CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                                   
                      RETURNING g_flag,g_bookno1,g_bookno2                                                                              
                 IF g_flag = '1' THEN     #抓不到帳別                                                                                   
                    CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                                 
                    NEXT FIELD ooa02                                                                                                     
                 END IF                                                                                                                 
             END IF
             END IF    #FUN-8A0075
           AFTER FIELD ooa03
              IF NOT cl_null(g_ooa.ooa03) THEN
                 SELECT * INTO l_occ.* FROM occ_file
                  WHERE occ01=g_ooa.ooa03 AND occacti='Y'
                    AND (occ06='1' OR occ06='3')
                 IF STATUS THEN
                    CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","select occ",1)  #No.FUN-660116
                    NEXT FIELD ooa03 
                 END IF
                 IF l_occ.occacti = 'N' THEN
                    CALL cl_err(l_occ.occ01,'9028',0) NEXT FIELD ooa03
                 END IF
                 LET g_ooa.ooa23 = l_occ.occ42 DISPLAY BY NAME g_ooa.ooa23
                 IF g_ooa.ooa03 != 'MISC' THEN
                    LET g_ooa.ooa032 = l_occ.occ02 DISPLAY BY NAME g_ooa.ooa032
                 END IF
              END IF
           AFTER FIELD ooa13
                 IF NOT cl_null(g_ooa.ooa13) THEN
                    SELECT COUNT(*) INTO g_cnt FROM ool_file WHERE ool01=g_ooa.ooa13
                    IF g_cnt=0 THEN
                       CALL cl_err('ool_file',100,0) NEXT FIELD ooa13
                    END IF
                 END IF
           AFTER FIELD ooa14
                 IF NOT cl_null(g_ooa.ooa14) THEN
                    SELECT gen03 INTO g_buf FROM gen_file
                           WHERE gen01=g_ooa.ooa14
                    IF STATUS THEN
                       CALL cl_err3("sel","gen_file",g_ooa.ooa14,"",STATUS,"","select gen",1)  #No.FUN-660116
                       NEXT FIELD ooa14
                    END IF
                   #IF cl_null(g_ooa.ooa15) THEN                                  #MOD-BB0086 ADD   #CHI-D10042 mark
                       LET g_ooa.ooa15=g_buf  DISPLAY By NAME g_ooa.ooa15
                   #END IF                                                        #MOD-BB0086 ADD   #CHI-D10042 mark
                 END IF
          AFTER FIELD ooa15
                IF NOT cl_null(g_ooa.ooa15) THEN
                   SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_ooa.ooa15
                         AND gemacti='Y'   #NO:6950
                   IF STATUS THEN
                      CALL cl_err3("sel","gem_file",g_ooa.ooa15,"",STATUS,"","select gem",1)  #No.FUN-660116
                      NEXT FIELD ooa15 
                   END IF
                END IF
         AFTER FIELD ooa23
                IF NOT cl_null(g_ooa.ooa23) THEN
                   SELECT azi02,azi03,azi04 INTO g_buf,t_azi03,t_azi04   #No.CHI-6A0004
                          FROM azi_file WHERE azi01=g_ooa.ooa23
                   IF STATUS THEN
                      CALL cl_err3("sel","azi_file",g_ooa.ooa23,"",STATUS,"","select azi",1)  #No.FUN-660116
                      NEXT FIELD ooa23
                   END IF
                END IF
 
        AFTER FIELD ooaud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(ooa03)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                    LET g_qryparam.default1 = g_ooa.ooa03
                    CALL cl_create_qry() RETURNING g_ooa.ooa03
                    DISPLAY BY NAME g_ooa.ooa03
                    NEXT FIELD ooa03
               WHEN INFIELD(ooa13)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_ool"
                    LET g_qryparam.default1 = g_ooa.ooa13
                    CALL cl_create_qry() RETURNING g_ooa.ooa13
                    DISPLAY BY NAME g_ooa.ooa13
                    NEXT FIELD ooa13
               WHEN INFIELD(ooa14)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_ooa.ooa14
                    CALL cl_create_qry() RETURNING g_ooa.ooa14
                    DISPLAY BY NAME g_ooa.ooa14
                    NEXT FIELD ooa14
               WHEN INFIELD(ooa15)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem"
                    LET g_qryparam.default1 = g_ooa.ooa15
                    CALL cl_create_qry() RETURNING g_ooa.ooa15
                    DISPLAY BY NAME g_ooa.ooa15
                    NEXT FIELD ooa15   #MOD-580270 
               WHEN INFIELD(ooa23)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_ooa.ooa23
                    CALL cl_create_qry() RETURNING g_ooa.ooa23
                    DISPLAY BY NAME g_ooa.ooa23
                    NEXT FIELD ooa23                    
               OTHERWISE    EXIT CASE
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
 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
 
        END INPUT
 
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_ooa.*=g_ooa_t.*
            CALL t400_show()
            CALL cl_err('','9001',0)
            LET g_success = 'N' #MOD-730060
            EXIT WHILE
        END IF
 
        IF g_ooa.ooa34 NOT matches '[Ss]' THEN
           LET g_ooa.ooa34 = '0'          #FUN-550049
        END IF
        UPDATE ooa_file SET * = g_ooa.* WHERE ooa01 = g_ooa_t.ooa01
        IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","ooa_file",g_ooa_o.ooa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
            CONTINUE WHILE
        END IF
        DISPLAY BY NAME g_ooa.ooa34
        IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
        IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
        CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
 
        EXIT WHILE
    END WHILE
    CLOSE t400_cl
    IF g_success = 'Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF   #MOD-730060
    CALL cl_flow_notify(g_ooa.ooa01,'U')
     LET g_t1=s_get_doc_no(g_ooa.ooa01)   #NO.FUN-560060  #MOD-560077
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF STATUS THEN
       RETURN
    END IF
    IF g_ooy.ooyprit='Y' THEN CALL t400_out() END IF   #單據需立即列印
    IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
       THEN RETURN
    ELSE
       LET g_action_choice = "insert"        #FUN-640246
       CALL s_showmsg_init() #CHI-A80031 add
       CALL t400_y_chk()          #CALL 原確認的 check 段
       IF g_success = "Y" THEN
          CALL t400_y_upd()       #CALL 原確認的 update 段
       END IF
       CALL s_showmsg()  #CHI-A80031 add
    END IF
END FUNCTION
 
FUNCTION t400_npp02()
   IF cl_null(g_ooa.ooa33) THEN
      UPDATE npp_file SET npp02 = g_ooa.ooa02
       WHERE npp01 = g_ooa.ooa01
         AND npp011 = 1
         AND npp00 = 3
         AND nppsys = 'AR'
      IF STATUS THEN
         CALL cl_err3("upd","npp_file",g_ooa.ooa01,"",STATUS,"","upd npp02:",1)  #No.FUN-660116 
      END IF
   END IF
 
END FUNCTION
 
#處理INPUT
FUNCTION t400_i(p_cmd)
  DEFINE p_cmd           LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)                #a:輸入 u:更改
  DEFINE l_flag          LIKE type_file.chr1               #No.FUN-680123 VARCHAR(1)               #判斷必要欄位是否有輸入
  DEFINE l_n1            LIKE type_file.num5               #No.FUN-680123 SMALLINT
  DEFINE l_occ           RECORD LIKE occ_file.*
  DEFINE x                         RECORD LIKE oob_file.*
  DEFINE l_yy,l_mm       LIKE type_file.num5               #No.FUN-680123 SMALLINT
  DEFINE l_ooyacti       LIKE ooy_file.ooyacti             #No.TQC-770025
  DEFINE l_ooytype       LIKE ooy_file.ooytype             #No.FUN-CB0019
 
    CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
    INPUT BY NAME g_ooa.ooaoriu,g_ooa.ooaorig,
        g_ooa.ooa01,g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa032,
        g_ooa.ooa14,g_ooa.ooa15,g_ooa.ooa23,g_ooa.ooa38,g_ooa.ooa13,g_ooa.ooa40,  #FUN-C20018 add ooa40 #FUN-C30029 add ooa38
        g_ooa.ooa33,g_ooa.ooa992,g_ooa.ooaconf,g_ooa.ooa31d,g_ooa.ooa31c,  #No.FUN-690090 add ooa992
        g_ooa.ooauser,g_ooa.ooagrup, g_ooa.ooamodu,g_ooa.ooadate,
        g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,g_ooa.ooaud04,
        g_ooa.ooaud05,g_ooa.ooaud06,g_ooa.ooaud07,g_ooa.ooaud08,
        g_ooa.ooaud09,g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
        g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15
        WITHOUT DEFAULTS
 
        BEFORE INPUT
          LET g_before_input_done = FALSE
          IF NOT cl_null(g_ooa.ooa02) THEN               #MOD-BA0189 
             CALL s_get_bookno(YEAR(g_ooa.ooa02))        #MOD-BA0189
                  RETURNING g_flag,g_bookno1,g_bookno2   #MOD-BA0189
          END IF                                         #MOD-BA0189
          CALL t400_set_entry(p_cmd)
          CALL t400_set_no_entry(p_cmd)
          LET g_before_input_done = TRUE
 
        #NO.FUN-CB0019  --Begin
        BEFORE FIELD ooa01
          IF cl_null(g_ooa.ooa01) THEN
             CASE g_prog
                  WHEN 'axrt400' LET l_ooytype = '30'
                  WHEN 'axrt401' LET l_ooytype = '33'
             END CASE
             CALL s_get_slip('axr','ooy_file','ooyslip','ooytype','ooyacti',l_ooytype,'')
                  RETURNING g_ooa.ooa01
             DISPLAY BY NAME g_ooa.ooa01
          END IF
        #NO.FUN-CB0019  --End

        AFTER FIELD ooa01
            IF NOT cl_null(g_ooa.ooa01) THEN
                LET g_t1=s_get_doc_no(g_ooa.ooa01) #MOD-560077
                LET l_ooyacti = NULL
                SELECT ooyacti INTO l_ooyacti FROM ooy_file
                 WHERE ooyslip = g_t1
                IF l_ooyacti <> 'Y' THEN
                   CALL cl_err(g_t1,'axr-956',1)
                   NEXT FIELD ooa01
                END IF
#No.FUN-AA0088 --begin   
                IF g_prog ='axrt400' THEN              
                   CALL s_check_no('axr',g_ooa.ooa01,"",'30',"ooa_file","ooa01","")  #MOD-460077  #MOD-8B0100
                        RETURNING g_cnt,g_ooa.ooa01
                END IF 
                IF g_prog ='axrt401' THEN              
                   CALL s_check_no('axr',g_ooa.ooa01,"",'33',"ooa_file","ooa01","")  #MOD-460077  #MOD-8B0100
                        RETURNING g_cnt,g_ooa.ooa01
                END IF 
#No.FUN-AA0088 --end
                IF NOT g_cnt  THEN
                   LET g_ooa.ooa01=g_ooa_t.ooa01
                   NEXT FIELD ooa01
                ELSE
                   SELECT ooyapr,'0' INTO g_ooa.ooamksg,g_ooa.ooa34
                     FROM ooy_file
                    WHERE ooyslip = g_t1
                   DISPLAY BY NAME g_ooa.ooamksg,g_ooa.ooa34
                END IF
            END IF
 
        AFTER FIELD ooa02
          IF NOT cl_null(g_ooa.ooa01) THEN
             IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
                CALL cl_err('','axr-164',0) NEXT FIELD ooa02
             END IF
             IF g_ooz.ooz07 = 'Y' THEN
                LET l_yy = YEAR(g_ooa.ooa02)
                LET l_mm = MONTH(g_ooa.ooa02)
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) < 1 THEN  #MOD-8B0213
                   CALL cl_err(g_ooa.ooa02,'axr-405',0)
                   NEXT FIELD ooa02   #MOD-830047
                END IF
                IF (l_yy*12+l_mm) - (g_ooz.ooz05*12+g_ooz.ooz06) = 0 THEN
                   CALL cl_err(g_ooa.ooa02,'axr-406',0) NEXT FIELD ooa02
                END IF
             END IF
             CALL s_get_bookno(YEAR(g_ooa.ooa02))
                  RETURNING g_flag,g_bookno1,g_bookno2
             IF g_flag = '1' THEN     #抓不到帳別
               CALL cl_err(g_ooa.ooa02,'aoo-081',1)
               NEXT FIELD ooa02   
             END IF
         END IF
 
       BEFORE FIELD ooa03
          CALL t400_set_entry(p_cmd)
 
       AFTER FIELD ooa03
          IF NOT cl_null(g_ooa.ooa03) THEN
             SELECT * INTO l_occ.* 
               FROM occ_file 
              WHERE occ01=g_ooa.ooa03
                AND occacti='Y'                  #No.FUN-670026
                AND (occ06 = '1' or occ06 = '3') #No.FUN-670026
             IF STATUS THEN
                CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","select occ",1)  #No.FUN-660116
                NEXT FIELD ooa03 
             END IF
            #MOD-A50085---add---start---
             IF NOT cl_null(l_occ.occ67) THEN
                LET g_ooa.ooa13 = l_occ.occ67
             ELSE
                LET g_ooa.ooa13 = g_ooz.ooz08
             END IF
             DISPLAY BY NAME g_ooa.ooa13
            #MOD-A50085---add---end---
             IF l_occ.occacti = 'N' THEN
                CALL cl_err(l_occ.occ01,'9028',0) NEXT FIELD ooa03
             END IF
             IF g_ooa.ooa23 IS NULL THEN
                LET g_ooa.ooa23 = l_occ.occ42 DISPLAY BY NAME g_ooa.ooa23
             END IF
             IF g_ooa.ooa03 != 'MISC' THEN
                LET g_ooa.ooa032 = l_occ.occ02 DISPLAY BY NAME g_ooa.ooa032
             END IF
          END IF
          CALL t400_set_no_entry(p_cmd)
 
 
       AFTER FIELD ooa13
          IF NOT cl_null(g_ooa.ooa13) THEN
             SELECT COUNT(*) INTO g_cnt FROM ool_file  WHERE ool01=g_ooa.ooa13
             IF g_cnt=0 THEN
                CALL cl_err('ool_file',100,0) NEXT FIELD ooa13
             END IF
          END IF
 
       AFTER FIELD ooa14
          IF NOT cl_null(g_ooa.ooa14) THEN
             SELECT gen03 INTO g_buf FROM gen_file WHERE gen01=g_ooa.ooa14
             IF STATUS THEN
                CALL cl_err3("sel","gen_file",g_ooa.ooa14,"",STATUS,"","select gen",1)  #No.FUN-660116
                NEXT FIELD ooa14
             END IF
            #IF cl_null(g_ooa.ooa15) THEN                                  #MOD-BB0086 ADD       #CHI-D10042 mark 
                LET g_ooa.ooa15=g_buf  DISPLAY By NAME g_ooa.ooa15
            #END IF                                                        #MOD-BB0086 ADD       #CHI-D10042 mark
          END IF
 
       AFTER FIELD ooa15
          IF NOT cl_null(g_ooa.ooa15) THEN
             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_ooa.ooa15
                AND gemacti='Y'   #NO:6950
             IF STATUS THEN
                CALL cl_err3("sel","gem_file",g_ooa.ooa15,"",STATUS,"","select gem",1)  #No.FUN-660116
                NEXT FIELD ooa15
             END IF
          END IF
 
       AFTER FIELD ooa23
          IF NOT cl_null(g_ooa.ooa23) THEN
             SELECT azi02,azi03,azi04 INTO g_buf,t_azi03,t_azi04    #No.CHI-6A0004
                 FROM azi_file WHERE azi01=g_ooa.ooa23
             IF STATUS THEN
                CALL cl_err3("sel","azi_file",g_ooa.ooa23,"",STATUS,"","select azi",1)  #No.FUN-660116
                NEXT FIELD ooa23
             END IF
          END IF
 
        AFTER FIELD ooaud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD ooaud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
       AFTER INPUT   #97/05/22 modify
          LET g_ooa.ooauser = s_get_data_owner("ooa_file") #FUN-C10039
          LET g_ooa.ooagrup = s_get_data_group("ooa_file") #FUN-C10039
          IF INT_FLAG THEN EXIT INPUT END IF
 
         ON ACTION CONTROLP     #ok
            CASE
               WHEN INFIELD(ooa01)
#No.FUN-AA0088 --begin
                    IF g_prog = 'axrt400' THEN 
                       CALL q_ooy( FALSE, TRUE, g_ooa.ooa01,'30','AXR')   #TQC-670008
                       RETURNING g_t1
                    END IF  
                    IF g_prog = 'axrt401' THEN
                       CALL q_ooy( FALSE, TRUE, g_ooa.ooa01,'33','AXR')   #TQC-670008
                       RETURNING g_t1
                    END IF 
#No.FUN-AA0088 --end
                     LET g_ooa.ooa01 = g_t1  #MOD-560077
                    DISPLAY BY NAME g_ooa.ooa01
                    NEXT FIELD ooa01
               WHEN INFIELD(ooa03)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_occ11"   #No.FUN-670026 
                    LET g_qryparam.default1 = g_ooa.ooa03
                    CALL cl_create_qry() RETURNING g_ooa.ooa03
                    DISPLAY BY NAME g_ooa.ooa03
                    NEXT FIELD ooa03
               WHEN INFIELD(ooa13)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_ool"
                    LET g_qryparam.default1 = g_ooa.ooa13
                    CALL cl_create_qry() RETURNING g_ooa.ooa13
                    DISPLAY BY NAME g_ooa.ooa13
                    NEXT FIELD ooa13
               WHEN INFIELD(ooa14)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gen"
                    LET g_qryparam.default1 = g_ooa.ooa14
                    CALL cl_create_qry() RETURNING g_ooa.ooa14
                    DISPLAY BY NAME g_ooa.ooa14
                    NEXT FIELD ooa14
               WHEN INFIELD(ooa15)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_gem"
                    LET g_qryparam.default1 = g_ooa.ooa15
                    CALL cl_create_qry() RETURNING g_ooa.ooa15
                    DISPLAY BY NAME g_ooa.ooa15
                    NEXT FIELD ooa15
               WHEN INFIELD(ooa23)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_ooa.ooa23
                    CALL cl_create_qry() RETURNING g_ooa.ooa23
                    DISPLAY BY NAME g_ooa.ooa23
                    NEXT FIELD ooa23
            END CASE
 
        ON ACTION CONTROLF                  #欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
    END INPUT
END FUNCTION
 
FUNCTION t400_set_entry(p_cmd)
 DEFINE p_cmd   LIKE type_file.chr1               #No.FUN-680123 VARCHAR(01)
 
   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL cl_set_comp_entry("ooa01,ooa03",TRUE)     #MOD-B50045 add ooa03
   END IF
   IF INFIELD(ooa03) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("ooa032",TRUE)
   END IF
   IF INFIELD(aba02) OR (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("abauser,aba11,aba10",TRUE)
   END IF
END FUNCTION
 
FUNCTION t400_set_no_entry(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1               #No.FUN-680123 VARCHAR(01)
 
    IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
    CALL cl_set_comp_entry("ooa01",FALSE)
    END IF
 
    IF INFIELD(ooa03) OR (NOT g_before_input_done) THEN
        IF g_ooa.ooa03 != 'MISC' THEN
           CALL cl_set_comp_entry("ooa032",FALSE)
        END IF
    END IF
END FUNCTION
 
FUNCTION t400_set_entry_1()
   CALL cl_set_comp_entry("ooa01,ooa14,ooa02,ooa15,ooa03,ooa032",TRUE)
END FUNCTION
 
FUNCTION t400_set_no_entry_1()
  IF g_ooa.ooa34 matches '[Ss]' THEN
     CALL cl_set_comp_entry("ooa01,ooa14,ooa02,ooa15,ooa03,ooa032",FALSE)
  END IF
END FUNCTION
FUNCTION t400_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_ooa.* TO NULL               #No.FUN-6B0042
    CALL cl_msg("")                          #FUN-640246
 
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
#   CALL t400_cs()                           #FUN-A90003 Mark
    CALL t400_cs2()                          #FUN-A90003 Add 
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_ooa.* TO NULL RETURN 
    END IF
    CALL cl_msg(" SEARCHING ! ")                              #FUN-640246
 
    OPEN t400_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_ooa.* TO NULL
    ELSE
        OPEN t400_count
        FETCH t400_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL t400_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
    CALL cl_msg("")                              #FUN-640246
 
END FUNCTION
 
FUNCTION t400_fetch(p_flag)
DEFINE
    p_flag          LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),               #處理方式
    l_abso          LIKE type_file.num10              #No.FUN-680123 INTEGER                #絕對的筆數
 
    CASE p_flag
        WHEN 'N' FETCH NEXT     t400_cs INTO g_ooa.ooa01
        WHEN 'P' FETCH PREVIOUS t400_cs INTO g_ooa.ooa01
        WHEN 'F' FETCH FIRST    t400_cs INTO g_ooa.ooa01
        WHEN 'L' FETCH LAST     t400_cs INTO g_ooa.ooa01
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
            FETCH ABSOLUTE g_jump t400_cs INTO g_ooa.ooa01
            LET mi_no_ask = FALSE
    END CASE
 
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)
        INITIALIZE g_ooa.* TO NULL  #TQC-6B0105
        RETURN
    ELSE
       CASE p_flag
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
       DISPLAY g_curs_index TO FORMONLY.idx           #FUN-CB0080
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF
    SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
    IF SQLCA.sqlcode THEN
       CALL cl_err3("sel","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660116
       INITIALIZE g_ooa.* TO NULL
       RETURN
    ELSE
       LET g_data_owner = g_ooa.ooauser     #No.FUN-4C0049
       LET g_data_group = g_ooa.ooagrup     #No.FUN-4C0049
       CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                               
       RETURNING g_flag,g_bookno1,g_bookno2                                                                          
       IF g_flag = '1' THEN     #抓不到帳別                                                                               
       CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                            
       END IF                                                                                                             
       CALL t400_show()
    END IF
END FUNCTION
 
FUNCTION t400_show()
    LET g_ooa_t.* = g_ooa.*                #保存單頭舊值
 
    DISPLAY BY NAME g_ooa.ooa01,g_ooa.ooa02,g_ooa.ooa03,g_ooa.ooa35,g_ooa.ooa36,g_ooa.ooa032, g_ooa.ooaoriu,g_ooa.ooaorig, #TQC-C20430 add ooa35,ooa36
                    g_ooa.ooa14,g_ooa.ooa15,g_ooa.ooa23,g_ooa.ooa38,g_ooa.ooa13,g_ooa.ooa40, #FUN-C20018 add ooa40  #FUN-C30029 add ooa38
                    g_ooa.ooa33,g_ooa.ooa992,g_ooa.ooaconf,g_ooa.ooamksg,g_ooa.ooa34,     #No.FUN-540046  #No.FUN-690090 add ooa992
                    g_ooa.ooa31d,g_ooa.ooa31c,g_ooa.ooauser,g_ooa.ooagrup,
                    g_ooa.ooamodu,g_ooa.ooadate,
                    g_ooa.ooaud01,g_ooa.ooaud02,g_ooa.ooaud03,g_ooa.ooaud04,
                    g_ooa.ooaud05,g_ooa.ooaud06,g_ooa.ooaud07,g_ooa.ooaud08,
                    g_ooa.ooaud09,g_ooa.ooaud10,g_ooa.ooaud11,g_ooa.ooaud12,
                    g_ooa.ooaud13,g_ooa.ooaud14,g_ooa.ooaud15
 
    IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
    CALL t400_show2()
    CALL t400_show_amt()
    LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    CALL t400_b_fill(g_wc2)
    CALL t400_b_fill_2(g_wc3) #FUN-A90003 Add
    IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
    IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
    CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
 
END FUNCTION
 
FUNCTION t400_show2()
     SELECT azi03,azi04 INTO t_azi03,t_azi04  #MOD-560077  #No.CHI-6A0004
                     FROM azi_file WHERE azi01=g_ooa.ooa23
END FUNCTION
FUNCTION t400_show_amt()
   #FUN-A40076-Add--Begin
   IF cl_null(g_ooa.ooa33d) THEN
      LET g_ooa.ooa33d = 0
   END IF   
   #FUN-A40076-Add--End
   LET g_ooa31_diff=g_ooa.ooa31c-g_ooa.ooa31d
#  LET g_ooa32_diff=g_ooa.ooa32c-g_ooa.ooa32d                #FUN-A40076 Mark
   LET g_ooa32_diff=g_ooa.ooa32c-g_ooa.ooa32d-g_ooa.ooa33d   #FUN-A40076 Add
   DISPLAY BY NAME g_ooa.ooa31d,g_ooa.ooa31c,g_ooa.ooa32c,g_ooa.ooa32d,
                   g_ooa31_diff,g_ooa32_diff
                  ,g_ooa.ooa33d   #FUN-A40076 Add
END FUNCTION
 
FUNCTION t400_r()
    DEFINE l_chr,l_sure LIKE type_file.chr1,              #No.FUN-680123 VARCHAR(1),
           l_n          LIKE type_file.num5               #No.FUN-680123 SMALLINT
   #TQC-C20430--add--begin
    DEFINE l_oob        RECORD LIKE oob_file.*     
    DEFINE l_nmgconf    LIKE nmg_file.nmgconf      
    DEFINE l_oob06      LIKE oob_file.oob06
   #TQC-C20430--add--end 

    IF s_shut(0) THEN RETURN END IF
    IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooa34 matches '[Ss1]' THEN          #FUN-550049
       CALL cl_err('','mfg3557',0)
       RETURN
    END IF
   #FUN-C30029--add--str
   IF g_azw.azw04='2' AND g_ooa.ooa38<>'2' THEN
      CALL cl_err('','aap-829',0)
      RETURN
   END IF
   #FUN-C30029--add--end
 
   #-----97/05/26 modify 傳票編號不為空白,show警告訊息
    IF NOT cl_null(g_ooa.ooa33) THEN
       CALL cl_err(g_ooa.ooa01,'axr-310',0)
       RETURN
    END IF
    BEGIN WORK
    OPEN t400_cl USING g_ooa.ooa01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_ooa.*
    IF STATUS THEN 
       CALL cl_err('sel ooa',STATUS,0) 
       ROLLBACK WORK 
       RETURN 
    END IF
    CALL t400_show()
    IF cl_delh(20,16) THEN
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "ooa01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_ooa.ooa01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                            #No.FUN-9B0098 10/02/24
        MESSAGE "Delete ooa,oob,oao,npp,npp!"
        #TQC-C20430--add--begin
        IF NOT cl_null(g_ooa.ooa35) AND NOT cl_null(g_ooa.ooa36) THEN
           IF g_prog='axrt400' AND g_ooa.ooa35='1' THEN
              UPDATE lui_file SET lui14=NULL WHERE lui01=g_ooa.ooa36
              IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
                 CALL cl_err3("upd","lui_file",g_ooa.ooa36,"",STATUS,"","",1)
                 LET g_success='N'
              END IF
           END IF
          IF g_prog='axrt400' AND g_ooa.ooa35='2' THEN
             UPDATE luc_file SET luc28=NULL WHERE luc01=g_ooa.ooa36
             IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
                CALL cl_err3("upd","luc_file",g_ooa.ooa36,"",STATUS,"","",1)
                LET g_success='N'
             END IF
             #更新帳款單號
             UPDATE lud_file SET lud06=NULL WHERE lud01=g_ooa.ooa36 AND lud06=g_ooa.ooa01
             IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
                CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)
                LET g_success='N' 
             END IF
             #更新待抵單號
             LET l_sql ="SELECT oob06 FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2' AND oob04 = '2'"
             PREPARE t400_upd_lud_pr FROM l_sql
             DECLARE t400_upd_lud_r CURSOR FOR t400_upd_lud_pr
             FOREACH t400_upd_lud_r INTO l_oob06
                IF STATUS THEN EXIT FOREACH END IF
                UPDATE lud_file SET lud10=NULL WHERE lud01 = g_ooa.ooa36 AND lud10 = l_oob06
                IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
                   CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)
                   LET g_success='N'
                END IF
             END FOREACH
          END IF
          IF g_prog='axrt401'AND g_ooa.ooa35='1' THEN
              UPDATE lum_file SET lum17=NULL WHERE lum01=g_ooa.ooa36
              IF STATUS OR SQlCA.sqlerrd[3]=0 THEN   
                 CALL cl_err3("upd","lum_file",g_ooa.ooa36,"",STATUS,"","",1)
                 LET g_success = 'N'
              END IF 
           END IF
        END IF
        IF g_prog='axrt400' AND g_ooa.ooa35='1' THEN
           LET l_sql = " SELECT * FROM oob_file WHERE oob01='",g_ooa.ooa01,"'",
                       " AND oob03='1'"
           PREPARE t400_del_pr FROM l_sql
           DECLARE t400_del_r CURSOR FOR t400_del_pr
           FOREACH t400_del_r INTO l_oob.*
             IF STATUS THEN EXIT FOREACH END IF
             IF l_oob.oob04='1' THEN
                DELETE FROM nmh_file WHERE nmh01=l_oob.oob06
             END IF
             IF l_oob.oob04='2' THEN
                SELECT nmgconf INTO l_nmgconf FROM nmg_file
                 WHERE nmg00=l_oob.oob06
                IF l_nmgconf='Y' THEN
                   DELETE FROM nme_file WHERE nme12=l_oob.oob06
                END IF
                DELETE FROM npk_file WHERE npk00=l_oob.oob06
                DELETE FROM nmg_file WHERE nmg00=l_oob.oob06
             END IF
           END FOREACH
        END IF
      #TQC-C20430--add--end
        DELETE FROM ooa_file WHERE ooa01 = g_ooa.ooa01
        IF SQLCA.SQLERRD[3]=0
             THEN CALL cl_err3("del","ooa_file",g_ooa.ooa01,"","","","No ooa deleted",1)  #No.FUN-660116
                ROLLBACK WORK RETURN
        END IF
        DELETE FROM oob_file WHERE oob01 = g_ooa.ooa01
        DELETE FROM npp_file WHERE npp01 = g_ooa.ooa01 AND nppsys = 'AR'
                               AND npp00 = 3  AND npp011 = 1
        DELETE FROM npq_file WHERE npq01 = g_ooa.ooa01 AND npqsys = 'AR'
                               AND npq00 = 3 AND npq011 = 1
      #FUN-B40056--add--str--
        DELETE FROM tic_file WHERE tic04 = g_ooa.ooa01
      #FUN-B40056--add--end--
        LET g_msg=TIME
        INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06,azoplant,azolegal)     #FUN-980011 add
           VALUES ('axrt400',g_user,g_today,g_msg,g_ooa.ooa01,'delete',g_plant,g_legal) #FUN-980011 add
        CLEAR FORM
        CALL g_oob.clear()
        CALL g_oob.clear()
        CALL g_oob_d.clear()   #TQC-B40004 add
          INITIALIZE g_ooa.* TO NULL
        MESSAGE ""
        OPEN t400_count
        #FUN-B50064-add-start--
        IF STATUS THEN
           CLOSE t400_cs
           CLOSE t400_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end-- 
        FETCH t400_count INTO g_row_count
        #FUN-B50064-add-start--
        IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
           CLOSE t400_cs
           CLOSE t400_count
           COMMIT WORK
           RETURN
        END IF
        #FUN-B50064-add-end-- 
        DISPLAY g_row_count TO FORMONLY.cnt
        OPEN t400_cs
        IF g_curs_index = g_row_count + 1 THEN
           LET g_jump = g_row_count
           CALL t400_fetch('L')
        ELSE
           LET g_jump = g_curs_index
           LET mi_no_ask = TRUE
           CALL t400_fetch('/')
        END IF
 
    END IF
    CLOSE t400_cl
    COMMIT WORK
    CALL cl_flow_notify(g_ooa.ooa01,'D')
END FUNCTION
 
FUNCTION t400_b()
DEFINE l_oma55      LIKE oma_file.oma55    #No.FUN-960141
DEFINE l_oma57      LIKE oma_file.oma57    #No.FUN-960141
DEFINE l_oma55_o    LIKE oma_file.oma55    #No.FUN-960141
DEFINE l_oma57_o    LIKE oma_file.oma57    #No.FUN-960141
DEFINE l_oma16      LIKE oma_file.oma16    #No.FUN-960141
DEFINE l_ac_t          LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #未取消的ARRAY CNT
       l_row,l_col     LIKE type_file.num5,   #No.FUN-680123 SMALLINT,                     #分段輸入之行,列數
       l_n,l_cnt       LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #檢查重複用
       l_lock_sw       LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #單身鎖住否
       p_cmd           LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #處理狀態
       l_possible      LIKE type_file.num5,   #No.FUN-680123 SMALLINT, #用來設定判斷重複的可能性
       l_b2            LIKE type_file.chr1000,#No.FUN-680123 VARCHAR(30),
      #l_flag          LIKE type_file.num10,  #No.FUN-680123 INTEGER, #CHI-A30007 mark
       l_flag          LIKE type_file.chr1,                           #CHI-A30007 
       oob10_t         LIKE oob_file.oob10,
       l_nmh32         LIKE nmh_file.nmh32,
       l_aag07         LIKE aag_file.aag07,
       oob08_t         LIKE oob_file.oob08,  #FUN-4C0013
       oob09_t         LIKE oob_file.oob09,  #FUN-4C0013
       l_allow_insert  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可新增否
       l_allow_delete  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可刪除否
       ls_tmp          STRING,
       l_ooa34         LIKE ooa_file.ooa34,
       l_aag05         LIKE aag_file.aag05   #MOD-5B0012
DEFINE l_nmh04         LIKE nmh_file.nmh04   #FUN-660035
DEFINE l_i             LIKE type_file.num5   #TQC-6B0067
DEFINE l_oma00         LIKE oma_file.oma00   #MOD-940420
DEFINE l_apa00         LIKE apa_file.apa00   #MOD-940420
DEFINE l_count1        LIKE type_file.num5   #TQC-B30221 #第一单身是否有资料
DEFINE l_count2        LIKE type_file.num5   #TQC-B30221 #第二单身是否有资料
DEFINE l_amt           LIKE oma_file.oma55   #FUN-C20018
 
    LET l_ooa34 = g_ooa.ooa34      #FUN-550049
 
    LET g_action_choice = ""      
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    #FUN-C30140---add----str---
    IF g_ooa.ooa34 matches '[Ss]' THEN
        CALL cl_err('','apm-030',0)
        RETURN
    END IF
    #FUN-C30140---add----end---
 
    CALL t400_g_b()                 #先由應收票據或TT自動產生借方單身
    CALL t400_b_fill(g_wc2)
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = " SELECT * FROM oob_file WHERE oob01=? AND oob02=? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t400_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
      LET l_ac_t = 0
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")


      INPUT ARRAY g_oob WITHOUT DEFAULTS FROM s_oob.*
            ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
 
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            DISPLAY l_ac TO FORMONLY.cn2
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()
            LET g_success = 'Y'   #MOD-730060
            BEGIN WORK
 
            OPEN t400_cl USING g_ooa.ooa01
            IF STATUS THEN
               CALL cl_err("OPEN t400_cl:", STATUS, 1)
               CLOSE t400_cl
               ROLLBACK WORK
               RETURN
            END IF
            FETCH t400_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE t400_cl 
               ROLLBACK WORK 
               RETURN
            END IF
            IF g_rec_b>=l_ac THEN
               LET p_cmd='u'
               LET g_oob_t.* = g_oob[l_ac].*  #BACKUP
               OPEN t400_bcl USING g_ooa.ooa01,g_oob_t.oob02
               IF STATUS THEN
                  CALL cl_err("OPEN t400_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
                  CLOSE t400_bcl
                  ROLLBACK WORK
               ELSE





                  FETCH t400_bcl INTO b_oob.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      CALL t400_b_move_to()
                  END IF
               END IF
               CALL t400_set_entry_b()
               CALL t400_set_entry_b_1()    #FUN-8A0075
               CALL t400_set_no_entry_b()
               CALL t400_set_no_entry_b1()
               CALL t400_set_entry_b1()
               CALL t400_set_no_entry_b_1()    #FUN-8A0075
               CALL t400_set_no_required_b()   #MOD-990040 add
               CALL t400_set_required_b()      #MOD-990040 add
               CALL cl_show_fld_cont()               #No.FUN-550037
               CALL cl_show_fld_cont()     #FUN-550037(smin)
               LET g_change = 'N'          #MOD-B60022
            END IF
 
        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_success = 'N'   #MOD-730060
               CANCEL INSERT
            END IF
            CALL t400_b_move_back()
            SELECT COUNT(*) INTO l_n FROM oob_file
             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob[l_ac].oob02
            IF NOT cl_null(g_oob[l_ac].oob10) THEN
               IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                  (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                  IF NOT t400_oob09_13('2',p_cmd) THEN
                  END IF
               END IF
            END IF
            INSERT INTO oob_file VALUES(b_oob.*)
            IF SQLCA.sqlcode THEN
               LET g_success = 'N'   #MOD-730060
               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  #No.FUN-660116
               CANCEL INSERT
            END IF
            CALL t400_mlog('A')
            CALL t400_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'INSERT O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                  LET l_ooa34 = '0'
               END IF                                   #No.FUN-8A0075
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cn2
               COMMIT WORK
            ELSE
               MESSAGE 'INSERT ERR'
               ROLLBACK WORK
            END IF
        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oob[l_ac].* TO NULL      #900423
            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
                LET g_oob[l_ac].oob07=g_ooa.ooa23
            END IF
            LET b_oob.oob01=g_ooa.ooa01
            LET b_oob.ooblegal = g_ooa.ooalegal
            LET g_oob[l_ac].oob08=1
            LET g_oob[l_ac].oob09=0
            LET g_oob[l_ac].oob10=0
            LET g_oob_t.* = g_oob[l_ac].*             #新輸入資料
            LET g_oob[l_ac].oob03 = '1'               #新輸入資料
            LET g_oob[l_ac].oob04 = '1'               #新輸入資料
#No.FUN-AA0088 --begin
            IF g_prog ='axrt401' THEN 
               #LET g_oob[l_ac].oob03 = '2'   #FUN-C20018 mark--
               #LET g_oob[l_ac].oob04 = '1'   #FUN-C20018 mark--
            #FUN-C20018--add--begin
               #IF g_ooa.ooa40='1' THEN  #FUN-C20063 mark--
               IF g_ooa.ooa40='01' THEN  #FUN-C20063 
                  LET g_oob[l_ac].oob03 = '2' 
                  LET g_oob[l_ac].oob04 = '1'
               ELSE
                  LET g_oob[l_ac].oob03 = '1' 
                  LET g_oob[l_ac].oob04 = '3'
               END IF
            #FUN-C20018--add--end
            END IF 
#No.FUN-AA0088 --end            
            LET g_oob_t.* = g_oob[l_ac].*             #新輸入資料   #MOD-850246 add
            CALL t400_set_entry_b()
            CALL t400_set_entry_b_1()   #FUN-8A0075
            CALL t400_set_no_entry_b()
            CALL t400_set_no_required_b()   #MOD-990040 add
            CALL t400_set_required_b()      #MOD-990040 add
            CALL cl_show_fld_cont()     #FUN-550037(smin)
 
            NEXT FIELD oob02
 
        BEFORE FIELD oob02                            #default 序號
           IF g_oob[l_ac].oob02 IS NULL OR g_oob[l_ac].oob02 = 0 THEN
                IF l_ac>1 THEN LET g_chr=g_oob[l_ac-1].oob03 END IF
                SELECT MAX(oob02)+1 INTO g_oob[l_ac].oob02 FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 #AND oob03<=g_chr
                IF g_oob[l_ac].oob02 IS NULL THEN
                    LET g_oob[l_ac].oob02 = 1
                END IF
           END IF
 
        AFTER FIELD oob02                        #check 序號是否重複
            IF NOT cl_null(g_oob[l_ac].oob02) THEN
               IF g_oob[l_ac].oob02 != g_oob_t.oob02 OR g_oob_t.oob02 IS NULL THEN
                  SELECT count(*) INTO l_n FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob[l_ac].oob02
                  IF l_n > 0 THEN
                     LET g_oob[l_ac].oob02 = g_oob_t.oob02
                     CALL cl_err('',-239,0) NEXT FIELD oob02
                  END IF
               END IF
            END IF
 
        AFTER FIELD oob03
           IF NOT cl_null(g_oob[l_ac].oob03) THEN
              IF g_oob[l_ac].oob03 NOT MATCHES "[12]" THEN NEXT FIELD oob03 END IF
                 IF NOT cl_null(g_oob[l_ac].oob04) THEN                                                                             
                    LET l_cnt = 0                                                                                                   
                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
                       WHERE ooc01 = g_oob[l_ac].oob04                                                                              
                    IF l_cnt = 0 THEN                                                                                               
                       IF g_oob[l_ac].oob03='1' THEN                                                                                
                          IF g_oob[l_ac].oob04 NOT MATCHES '[1-9,E,Q]' THEN    #FUN-A40001 add EQ   
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04                                                                                       
                          END IF                                                                                                    
                       ELSE                                                                                                         
                          IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,B]' THEN   #FUN-A40001 add B                                                    
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04                                                                                       
                          END IF                                                                                                    
                       END IF                                                                                                       
                    END IF                                                                                                          
                 END IF                                                                                                             
           END IF
 
        BEFORE FIELD oob04
           CALL t400_set_entry_b()
           CALL t400_set_no_required_b()   #MOD-990040 add
 
        AFTER FIELD oob04
           IF NOT cl_null(g_oob[l_ac].oob04) THEN
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM ooc_file
                 WHERE ooc01 = g_oob[l_ac].oob04
              IF l_cnt = 0 THEN
                 IF g_oob[l_ac].oob03='1' THEN
                    IF g_oob[l_ac].oob04 NOT MATCHES '[1-9,E,F,H,Q]' THEN        #FUN-A40001 add EQ #FUN-D70029 add FH
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04
                    END IF
                 ELSE
                    IF g_oob[l_ac].oob04 NOT MATCHES '[1,2,4,7,9,B]' THEN    #FUN-A40001 add B
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04
                    END IF
                 END IF
              END IF
              SELECT azi04 INTO t_azi04 FROM azi_file                 #MOD-940238
               WHERE azi01 = g_oob[l_ac].oob07  
             #若oob04='9'時,oob15預設值為0,無須維護
              IF g_oob[l_ac].oob04='9' THEN
                 LET g_oob[l_ac].oob15=0
                 DISPLAY BY NAME g_oob[l_ac].oob15
              END IF
              #FUN-D70029--add--str--
              IF g_oob[l_ac].oob04='H' THEN
                 CALL cl_set_comp_entry("oob06,oob19,oob15,oob14",FALSE)  #FUN-D80031 mark   #No.TQC-DA0003 Remark
                #CALL cl_set_comp_entry("oob19,oob15,oob14",FALSE)  #FUN-D80031 add          #No.TQC-DA0003 Mark
                #IF p_cmd ='a' THEN    #FUN-D80031 add   #No.TQC-DA0003   Mark
                 LET g_oob[l_ac].oob06=NULL
                 LET g_oob[l_ac].oob19=NULL
                 LET g_oob[l_ac].oob15=NULL
                #END IF                #FUN-D80031 add   #No.TQC-DA0003   Mark
              END IF
              #FUN-D70029--add--end
              CALL s_oob04(g_oob[l_ac].oob03,g_oob[l_ac].oob04)
                   RETURNING g_oob[l_ac].oob04_d
              CALL t400_acct_code()
              IF g_oob[l_ac].oob11 IS NULL THEN
                 SELECT ooc03 INTO g_oob[l_ac].oob11 FROM ooc_file
                  WHERE ooc01=g_oob[l_ac].oob04
                 DISPLAY BY NAME g_oob[l_ac].oob11   #NO.MOD-5A0095
              END IF
              IF g_aza.aza63='Y' THEN
                 IF g_oob[l_ac].oob111 IS NULL THEN
                    SELECT ooc04 INTO g_oob[l_ac].oob111 FROM ooc_file
                     WHERE ooc01=g_oob[l_ac].oob04
                    DISPLAY BY NAME g_oob[l_ac].oob111
                 END IF
              END IF
              IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = "7" AND
                #g_ooa32_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN        #MOD-C80092 g_ooa31_diff mode g_ooa32_diff #MOD-C90154 mark
                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN        #MOD-C90154 add
                 CALL cl_err('','axr-204',0) NEXT FIELD oob04
              END IF
              IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 MATCHES "[567]" AND
                 g_oob[l_ac].oob09 = 0   AND g_oob[l_ac].oob10 = 0 THEN
                 LET g_oob[l_ac].oob07 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob[l_ac].oob08 = 1
                    ELSE LET g_oob[l_ac].oob08 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob[l_ac].oob09 = g_ooa31_diff
                 LET g_oob[l_ac].oob10 = g_ooa32_diff
                 LET g_oob[l_ac].oob09 = cl_digcut(g_oob[l_ac].oob09,t_azi04)  #MOD-910070 add 
                 LET g_oob[l_ac].oob10 = cl_digcut(g_oob[l_ac].oob10,g_azi04)  #No.CHI-6A0004
		 DISPLAY BY NAME g_oob[l_ac].oob08   #NO.MOD-5A0095
		 DISPLAY BY NAME g_oob[l_ac].oob09   #NO.MOD-5A0095
		 DISPLAY BY NAME g_oob[l_ac].oob10   #NO.MOD-5A0095
              END IF
              IF g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 MATCHES "[23]" AND
                 g_oob[l_ac].oob09 = 0   AND g_oob[l_ac].oob10 = 0 THEN
                 LET g_oob[l_ac].oob07 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob[l_ac].oob08 = 1
                    ELSE LET g_oob[l_ac].oob08 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob[l_ac].oob09 = -g_ooa31_diff
                 LET g_oob[l_ac].oob10 = -g_ooa32_diff
                 LET g_oob[l_ac].oob09 = cl_digcut(g_oob[l_ac].oob09,t_azi04)  #MOD-910070 add 
                 LET g_oob[l_ac].oob10 = cl_digcut(g_oob[l_ac].oob10,g_azi04)  #No.CHI-6A0004
	         DISPLAY BY NAME g_oob[l_ac].oob08   #NO.MOD-5A0095
	         DISPLAY BY NAME g_oob[l_ac].oob09   #NO.MOD-5A0095
	         DISPLAY BY NAME g_oob[l_ac].oob10   #NO.MOD-5A0095
              END IF
             #-MOD-A80175-add-
              IF g_oob[l_ac].oob04='7' THEN
                 LET g_oob[l_ac].oob07 = g_aza.aza17 
                 DISPLAY BY NAME g_oob[l_ac].oob07
              END IF
             #-MOD-A80175-end-
         END IF
         CALL t400_set_no_entry_b()
         CALL t400_set_no_entry_b1()           #No.FUN-680022  
         CALL t400_set_entry_b1()              #No.FUN-680022  
         CALL t400_set_required_b()      #MOD-990040 add
 
        AFTER FIELD oob06
           IF NOT cl_null(g_oob[l_ac].oob06) THEN
              #FUN-C20018--add--begin
              IF g_prog ='axrt401' THEN
                 SELECT oma00,oma54t-oma55 INTO l_oma00,l_amt FROM oma_file 
                  WHERE oma01 = g_oob[l_ac].oob06 
                 #IF g_ooa.ooa40  = '1' AND l_oma00[1,1]!='1' THEN #FUN-C20063 mark--
                 IF g_ooa.ooa40  = '01' AND l_oma00[1,1]!='1' THEN #FUN-C20063 
                    CALL cl_err('','axr113',1)
                    NEXT FIELD oob06
                 END IF
                 #IF g_ooa.ooa40 = '2' AND l_oma00[1,1]!='2' THEN #FUN-C20063 mark--
                 IF g_ooa.ooa40 = '02' AND l_oma00[1,1]!='2' THEN #FUN-C20063 
                    CALL cl_err('','axr114',1)
                    NEXT FIELD oob06
                 END IF
                 #IF g_ooa.ooa40  = '2' AND g_oob[l_ac].oob03 = '1' #FUN-C20063 mark--
                 IF g_ooa.ooa40  = '02' AND g_oob[l_ac].oob03 = '1' #FUN-C20063 
                    AND g_oob[l_ac].oob04 = '3' THEN
                    IF l_amt<=0 THEN
                       CALL cl_err('','axr115',1)
                       NEXT FIELD oob03
                    END IF
                 END IF
              END IF 
              #FUN-C20018--add--end
             #若為借方，且非待扺
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 != '3' THEN
                 IF (p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06 OR
                       g_oob_t.oob04 != g_oob[l_ac].oob04) THEN   #No.MOD-530346
                    CALL t400_oob06()
 
                    IF g_errno = 'N' THEN
                       NEXT FIELD oob06
                    END IF
                 END IF
              END IF
 
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
                  WHERE nmh01 = g_oob[l_ac].oob06
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob[l_ac].oob06
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE oma00 MATCHES '2*'
                    AND oma01 = g_oob[l_ac].oob06 
              END IF
              IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'1*'
                    AND apa01 = g_oob[l_ac].oob06
                    AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
              END IF
              IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE  oma00 MATCHES '1*'
                    AND oma01 = g_oob[l_ac].oob06 
              END IF
              IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'2*'
                    AND apa01 = g_oob[l_ac].oob06
                    AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
              END IF 
  
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("sel","nmh_file",g_oob[l_ac].oob06,"",SQLCA.sqlcode,"","",0) 
              ELSE
                 IF l_nmh04 > g_ooa.ooa02 THEN
                    CALL cl_err('','axr-371',0)
                    NEXT FIELD oob06
                 END IF 
              END IF
 
             #CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2          #MOD-CB0277 mark
              CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
              IF g_flag='1' THEN
                 CALL cl_err(l_nmh04,'aoo-081',1)
                 NEXT FIELD oob06
              END IF        
 
             IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[39]" THEN                         
                IF p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06  THEN 
                   IF g_oob[l_ac].oob04 = '3' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob[l_ac].oob06
                      IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND
                         (l_oma00!='24') AND (l_oma00!='25') AND (l_oma00!='26') AND   #MOD-9B0046 add 25   #FUN-9C0061 add 26
                         (l_oma00!='20') AND   #No.TQC-DA0003  Add
                         (l_oma00!='27') AND (l_oma00!='28') THEN   #MOD-B70242 add 27,28
                         CALL cl_err('','axr-992',0)
                         NEXT FIELD oob06
                      END IF 
                     #MOD-A40023---add---start---
                      SELECT COUNT(*) INTO l_i FROM omc_file 
                       WHERE omc01=g_oob[l_ac].oob06
                      IF l_i=1 THEN
                         LET g_oob[l_ac].oob19=1
                         CALL t400_oob06()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19            #MOD-B80122 mark
                            NEXT FIELD oob06            #MOD-B80122 add
                         ELSE 
                           #NEXT FIELD oob11            #MOD-A80219 mark
                           #-MOD-A80219-add-
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15
                            ELSE
                               NEXT FIELD oob11
                            END IF
                           #-MOD-A80219-end-
                         END IF
                      END IF 
                     #MOD-A40023---add---end---
                   END IF 
                   IF g_oob[l_ac].oob04 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob[l_ac].oob06
                         AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') AND (l_apa00!='13') THEN   #MOD-A50047 add l_apa00!='13'
                         CALL cl_err('','axr-993',0)
                         NEXT FIELD oob06 
                      END IF   
                   END IF 
                END IF                 
             END IF 
             
             IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN
                IF p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06  THEN 
                   IF g_oob[l_ac].oob04 = '1' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob[l_ac].oob06
                      IF (l_oma00!='11') AND (l_oma00!='12') AND
                         (l_oma00!='13') AND (l_oma00!='14') AND (l_oma00 !='15') AND
                         (l_oma00!='17') AND (l_oma00!='10') THEN   #FUN-9B0130 add 15   #TQC-A20009 add 17   #MOD-DA0183 add 10
                         CALL cl_err('','axr-994',0)
                         NEXT FIELD oob06
                      END IF 
                   END IF 
                   IF g_oob[l_ac].oob04 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob[l_ac].oob06
                         AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
#No.MOD-B50248 --begin
                      IF l_apa00 NOT MATCHES '2*' THEN 
#                      IF (l_apa00!='21') AND (l_apa00!='22') AND
#                         (l_apa00!='23') AND (l_apa00!='24') AND (l_apa00!='25') THEN  #MOD-B20108 add 25
#No.MOD-B50248 --end
                         CALL cl_err('','axr-995',0)
                         NEXT FIELD oob06 
                      END IF   
                   END IF                    
                   IF NOT cl_null(g_oob[l_ac].oob19) THEN   #MOD-A10084 add
                      CALL t400_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,g_oob[l_ac].oob19,l_ac)  #MOD-A10084 add oob19
                      IF NOT cl_null(g_errno) THEN 
                         CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                         NEXT FIELD oob19   #MOD-A10084 mod oob06->oob19
                      END IF 
                   END IF   #MOD-A10084 add
                   IF g_oob[l_ac].oob04='1' THEN 
#No.FUN-AB0034 --begin
                     IF g_ooz.ooz62='Y' THEN                                    
                        CALL cl_set_comp_required("oob15",TRUE)                 
                     END IF
#No.FUN-AB0034 --end
                      SELECT COUNT(*) INTO l_i FROM omc_file 
                       WHERE omc01=g_oob[l_ac].oob06
                      IF l_i=1 THEN
                         LET g_oob[l_ac].oob19=1
                         CALL t400_oob06()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19            #MOD-B80122 mark 
                            NEXT FIELD oob06            #MOD-B80122 add                          
                         ELSE 
                           #NEXT FIELD oob11            #MOD-A80219 mark
                           #-MOD-A80219-add-
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15
                            ELSE
                               NEXT FIELD oob11
                            END IF
                           #-MOD-A80219-end-
                         END IF
                      END IF 
                   END IF
                   IF g_oob[l_ac].oob04='9' THEN 
                      SELECT COUNT(*) INTO l_i FROM apc_file
                       WHERE apc01=g_oob[l_ac].oob06
                      IF l_i=1 THEN
                         LET g_oob[l_ac].oob19=1
                         CALL t400_oob06()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19            #MOD-B80122 mark
                            NEXT FIELD oob06            #MOD-B80122 add
                         ELSE 
                           #NEXT FIELD oob11            #MOD-A80219 mark
                           #-MOD-A80219-add-
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15
                            ELSE
                               NEXT FIELD oob11
                            END IF
                           #-MOD-A80219-end-
                         END IF
                      END IF 
                   END IF                   
                END IF 
              END IF
           END IF
 
 
        BEFORE FIELD oob19
           CALL t400_set_no_entry_b1()
           CALL t400_set_entry_b1()
           #No.MOD-BA0089  --Begin
           IF (p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06 OR
               g_oob_t.oob04 != g_oob[l_ac].oob04) THEN
           #No.MOD-BA0089  --End
#MOD-B80099 -- begin --
              SELECT COUNT(*) INTO l_i FROM omc_file
                 WHERE omc01=g_oob[l_ac].oob06
              IF l_i=1 THEN
                 LET g_oob[l_ac].oob19=1
                 CALL t400_oob06()
                 IF g_errno = 'N' THEN
                   #NEXT FIELD oob19         #MOD-B80122 mark
                    NEXT FIELD oob06         #MOD-B80122 add
                 ELSE
                    IF g_ooz.ooz62 = 'Y' THEN
                       NEXT FIELD oob15
                    ELSE
                       NEXT FIELD oob11
                    END IF
                 END IF
              END IF
#MOD-B80099 -- end --
          END IF  #MOD-BA0089
 
        AFTER FIELD oob19
           IF cl_null(g_oob[l_ac].oob19) AND 
              NOT (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='4') THEN   #MOD-840084
              CALL cl_err("","axr-411",1)
              NEXT FIELD oob06 
           END IF 
           IF NOT cl_null(g_oob[l_ac].oob19) THEN
             #若為待扺，或為貸方
             #IF (p_cmd= 'a' OR g_oob_t.oob06 != g_oob[l_ac].oob06 OR    #MOD-A30106 mark
              IF (g_oob_t.oob06 != g_oob[l_ac].oob06 OR                  #MOD-A30106 add
                  g_oob_t.oob04 != g_oob[l_ac].oob04 OR 
                 #g_oob_t.oob19 != g_oob[l_ac].oob19 ) THEN                          #MOD-B40033 mark
                  g_oob_t.oob19 != g_oob[l_ac].oob19 OR cl_null(g_oob_t.oob19)) THEN #MOD-B40033 
                 CALL t400_oob06()
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob19
                 END IF
                #str MOD-A10084 add
                 CALL t400_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,g_oob[l_ac].oob19,l_ac)
                 IF NOT cl_null(g_errno) THEN 
                    CALL cl_err(g_oob[l_ac].oob19,g_errno,0)
                    NEXT FIELD oob19
                 END IF 
                #end MOD-A10084 add
              END IF
           END IF
           
        
        BEFORE FIELD oob15
           CALL t400_set_no_entry_b1() 
           CALL t400_set_entry_b1()
 
 
        AFTER FIELD oob15
           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
           END IF
 
           IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]" THEN   #MOD-850006
              IF NOT cl_null(g_oob[l_ac].oob15) THEN 
                 CALL t400_oob06_chk(g_oob[l_ac].oob06,g_oob[l_ac].oob15,g_oob[l_ac].oob19,l_ac)  #MOD-A10084 add oob19
                 IF NOT cl_null(g_errno) THEN 
                    CALL cl_err(g_oob[l_ac].oob06,g_errno,0)
                    NEXT FIELD oob06
                 END IF 
              END IF 
           END IF   #MOD-850006
           IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2' THEN
              IF cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06 = g_oob[l_ac].oob06 AND
                      oob15 = g_oob[l_ac].oob15 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15
                 END IF
              END IF
              IF g_oob_t.oob15 <> g_oob[l_ac].oob15 OR
                 g_oob_t.oob15 IS NULL THEN
                 CALL t400_oob06_12()
                 DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                                 g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                                 g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                                 g_oob[l_ac].oob13,g_oob[l_ac].oob14  #MOD-8A0009
   
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06
                 END IF
              END IF
           ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob[l_ac].oob15) THEN
                 CALL t400_oob06_item()
              END IF
           END IF 
 
        BEFORE FIELD oob07
           IF cl_null(g_oob[l_ac].oob07) AND NOT cl_null(g_ooa.ooa23) THEN
              LET g_oob[l_ac].oob07=g_ooa.ooa23
           END IF
           # 971021 TT/NR/CN/AR 不允許修改幣別
           IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[1239]") OR
              (g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[1]") THEN
           END IF
 
        AFTER FIELD oob07
           IF g_oob[l_ac].oob07 IS NULL THEN NEXT FIELD oob07 END IF  #No.TQC-670085
## No.2693 modify 1998/10/31 至少需判斷幣別為正確值
           IF NOT cl_null(g_oob[l_ac].oob07) THEN
              CALL t400_oob07('a')
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_oob[l_ac].oob07,g_errno,0)
                 LET g_oob[l_ac].oob07 = g_oob_t.oob07
                 DISPLAY BY NAME g_oob[l_ac].oob07
                 NEXT FIELD oob07
              END IF
            END IF
 
        BEFORE FIELD oob08
           CALL cl_set_comp_entry("oob08",TRUE)
           CALL t400_set_no_entry_b()
           LET oob08_t=g_oob[l_ac].oob08   #No.+010
           # 971021 TT/NR/CN/AR 不允許修改匯率
           IF g_oob[l_ac].oob08 = 0 OR g_oob[l_ac].oob08 = 1 OR
              cl_null(g_oob[l_ac].oob08) THEN
              CALL s_curr3(g_oob[l_ac].oob07,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob[l_ac].oob08
              DISPLAY BY NAME g_oob[l_ac].oob08
           END IF
           LET oob08_t=g_oob[l_ac].oob08
 
        AFTER FIELD oob08
           CALL cl_set_comp_entry("oob08",TRUE)
           IF (oob08_t!=g_oob[l_ac].oob08) THEN
              LET g_oob[l_ac].oob10 = g_oob[l_ac].oob08 * g_oob[l_ac].oob09
              CALL cl_digcut(g_oob[l_ac].oob10,g_azi04)
                   RETURNING g_oob[l_ac].oob10
           END IF
 
        BEFORE FIELD oob09
           LET oob09_t=g_oob[l_ac].oob09
 
        AFTER FIELD oob09
#TQC-A40132 --begin--
#           IF NOT cl_null(g_oob[l_ac].oob09) THEN 
#           #若借方充預收賬款時,若已收金額<衝預收賬款金額,則提示,但不影響錄入
#              IF g_oob[l_ac].oob04 = '3' THEN
#                 SELECT oma00,oma16,oma55,oma57
#                   INTO l_oma00,l_oma16,l_oma55,l_oma57  
#                   FROM oma_file WHERE oma01 = g_oob[l_ac].oob06                  
#                 IF cl_null(l_oma55) THEN LET l_oma55 = 0 END IF 
#                 IF cl_null(l_oma57) THEN LET l_oma57 = 0 END IF 
#                 IF NOT cl_null(l_oma16) THEN
#                    SELECT oma55,oma57 INTO l_oma55_o,l_oma57_o
#                     FROM oma_file WHERE oma01 = l_oma16
#                    IF cl_null(l_oma55_o) THEN LET l_oma55_o = 0 END IF
#                    IF cl_null(l_oma57_o) THEN LET l_oma57_o = 0 END IF
#                    IF g_oob[l_ac].oob09 >(l_oma55_o-l_oma55) THEN
#                       IF NOT cl_confirm('axr-701') THEN
#                          NEXT FIELD oob09
#                        END IF  
#                    END IF
#                 END IF  
#              END IF
#           END IF
#TQC-A40132 --end--
## No.2694 modify 1998/10/31 判斷金額是否沖過頭
           IF NOT cl_null(g_oob[l_ac].oob09) THEN
              IF g_oob_t.oob09 != g_oob[l_ac].oob09 OR
                 g_oob_t.oob09 IS NOT NULL THEN
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN
                    IF NOT t400_oob09_11('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2') THEN
                    IF NOT t400_oob09_12('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                    (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                    IF NOT t400_oob09_13('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t400_oob09_19('1',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob09
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t400_oob09_19('1',p_cmd,'2') THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
                #No.TQC-DA0003 ---Mark--- Start
                ##FUN-D80031 ---------- add ------------ begin
                #IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = 'H') THEN
                #   IF NOT t400_oob09_20(1,p_cmd) THEN
                #      NEXT FIELD oob09
                #   END IF
                #END IF
                ##FUN-D80031 ---------- add ------------ end
                #No.TQC-DA0003 ---Mark--- End
              END IF
              IF (oob08_t!=g_oob[l_ac].oob08) OR (oob09_t!=g_oob[l_ac].oob09) OR oob09_t IS NULL THEN #MOD-740395
                  SELECT azi04 INTO t_azi04 FROM azi_file  #MOD-560077  #No.CHI-6A0004
                  WHERE azi01 = g_oob[l_ac].oob07
                  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) #BUG-530346 MOD-560077   #No.CHI-6A0004
                 RETURNING g_oob[l_ac].oob09
                 LET g_oob[l_ac].oob10 = g_oob[l_ac].oob08 * g_oob[l_ac].oob09
                  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) #BUG-530346 MOD-560077  #No.CHI-6A0004
                 RETURNING g_oob[l_ac].oob10
              END IF
              IF g_oob[l_ac].oob09 <= 0 THEN
                 IF g_oob[l_ac].oob04 <> '7' THEN
                    NEXT FIELD oob09
                 END IF
              END IF
              #add by danny 020311 期末調匯(A008)
              IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') OR
                    (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') THEN
                    IF NOT t400_oob09_13('1',p_cmd) THEN
                       NEXT FIELD oob09
                    END IF
                 END IF
              END IF
           END IF
 
        BEFORE FIELD oob10
           LET oob10_t=g_oob[l_ac].oob10
 
        AFTER FIELD oob10
#TQC-A40132 --begin--
#           IF NOT cl_null(g_oob[l_ac].oob10) THEN 
#           #若借方充預收賬款時,若已收金額<衝預收賬款金額,則提示,但不影響錄入
#              IF g_oob[l_ac].oob04 = '3' THEN
#                 SELECT oma00,oma16,oma55,oma57
#                   INTO l_oma00,l_oma16,l_oma55,l_oma57  
#                   FROM oma_file WHERE oma01 = g_oob[l_ac].oob06                  
#                 IF cl_null(l_oma55) THEN LET l_oma55 = 0 END IF 
#                 IF cl_null(l_oma57) THEN LET l_oma57 = 0 END IF 
#                 IF NOT cl_null(l_oma16) THEN
#                    SELECT oma55,oma57 INTO l_oma55_o,l_oma57_o
#                     FROM oma_file WHERE oma01 = l_oma16
#                    IF cl_null(l_oma55_o) THEN LET l_oma55_o = 0 END IF
#                    IF cl_null(l_oma57_o) THEN LET l_oma57_o = 0 END IF
#                    IF g_oob[l_ac].oob10 >(l_oma57_o-l_oma57) THEN
#                       IF NOT cl_confirm('axr-701') THEN
#                          NEXT FIELD oob10
#                        END IF  
#                    END IF
#                 END IF  
#              END IF
#           END IF
#TQC-A40132 --end--
           IF NOT cl_null(g_oob[l_ac].oob10) THEN
              IF g_oob_t.oob10 != g_oob[l_ac].oob10 OR g_oob_t.oob10 IS NOT NULL THEN
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN
                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
                     WHERE nmh01 = g_oob[l_ac].oob06
                       AND nmh38 <> 'X'
                       AND nmh24 != '6' AND nmh24 != '7'          #MOD-980159 add
                    IF cl_null(l_nmh32) THEN
                       LET l_nmh32 = 0
                    END IF
                    IF g_oob[l_ac].oob10 > l_nmh32 THEN
                       NEXT FIELD oob10
                    END IF
                    IF NOT t400_oob09_11('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2') THEN
                    IF NOT t400_oob09_12('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3') OR
                    (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '1') THEN
                    IF NOT t400_oob09_13('2',p_cmd) THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t400_oob09_19('2',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob10
                    END IF
                 END IF
                 IF (g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '9') THEN
                    IF NOT t400_oob09_19('2',p_cmd,'2') THEN
                       NEXT FIELD oob10
                    END IF
                 END IF
                #No.TQC-DA0003 ---Mark--- Start
                ##FUN-D80031 ---------- add ------------ begin
                #IF (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = 'H') THEN
                #   IF NOT t400_oob09_20(2,p_cmd) THEN
                #      NEXT FIELD oob10
                #   END IF
                #END IF
                ##FUN-D80031 ---------- add ------------ end
                #No.TQC-DA0003 ---Mark--- End
              END IF
              IF oob10_t <> g_oob[l_ac].oob10 AND g_oob[l_ac].oob07 <> g_aza.aza17 THEN
                 IF cl_confirm('axr-320') THEN
                    SELECT azi04 INTO t_azi04 FROM azi_file #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 RECUVA
                     WHERE azi01 = g_oob[l_ac].oob07
                    CALL cl_digcut(g_oob[l_ac].oob10,g_azi04)  #BUG-530346 MOD-560077  #No.CHI-6A0004
                         RETURNING g_oob[l_ac].oob10
                    LET g_oob[l_ac].oob09 = g_oob[l_ac].oob10 / g_oob[l_ac].oob08
                    CALL cl_digcut(g_oob[l_ac].oob09,t_azi04)  #BUG-530346 MOD-560077  #No.CHI-6A0004
                         RETURNING g_oob[l_ac].oob09
                 ELSE
                   #LET g_oob[l_ac].oob08 = g_oob[l_ac].oob10 / g_oob[l_ac].oob09 #MOD-B40253 mark
                   #-MOD-B40253-add-
                    IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[45678]" THEN 
                       LET g_oob[l_ac].oob08 = g_oob[l_ac].oob10 / g_oob[l_ac].oob09
                    END IF
                   #-MOD-B40253-end-
                 END IF
              END IF
              IF g_oob[l_ac].oob08 = 1 AND g_oob[l_ac].oob07 <> g_aza.aza17 THEN
                 LET g_oob[l_ac].oob08 = g_oob[l_ac].oob10 / g_oob[l_ac].oob09
             #MOD-C40139---str---
             #IF g_oob[l_ac].oob08 = 1 THEN                               #MOD-C90154 mark
              IF g_oob[l_ac].oob08 = 1 AND g_oob[l_ac].oob04 <> '7' THEN  #MOD-C90154
                 IF g_oob[l_ac].oob09 <> g_oob[l_ac].oob10 THEN
                    CALL cl_err('','agl-926',0)
                    NEXT FIELD oob10
                 END IF
              END IF
             #MOD-C40139---end---
              END IF
              IF g_oob[l_ac].oob10 <= 0 THEN
                 NEXT FIELD oob10
              END IF
           END IF
 
        AFTER FIELD oob11
           #IF g_oob[l_ac].oob11 IS NULL THEN NEXT FIELD oob11 END IF    #No.TQC-670085 #MOD-BA0225 mark
           LET l_aag05=''   #FUN-8C0089 add
           IF NOT cl_null(g_oob[l_ac].oob11) THEN
              SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05   #FUN-8C0089 add aag05,l_aag05
                FROM aag_file
               WHERE aag01=g_oob[l_ac].oob11
                 AND aag00=g_bookno1            #No.FUN-730073   
              IF STATUS THEN
                 #No.FUN-AA0088 yinhy --Begin
                 #CALL cl_err3("sel","aag_file",g_oob[l_ac].oob11,"",STATUS,"","select aag",1)  #No.FUN-660116
                 CALL cl_err3("sel","aag_file",g_oob[l_ac].oob11,"",STATUS,"","select aag",0)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ='q_aag'
                 LET g_qryparam.construct = 'N'
                 LET g_qryparam.default1 =g_oob[l_ac].oob11
                 LET g_qryparam.arg1 = g_bookno1 
                 LET g_qryparam.where = "  aag01 LIKE '",g_oob[l_ac].oob11 CLIPPED,"%'"                
                 CALL cl_create_qry() RETURNING g_oob[l_ac].oob11
                 DISPLAY BY NAME g_oob[l_ac].oob11
                 #No.FUN-AA0088 yinhy --End
                 NEXT FIELD oob11
              END IF
              IF l_aag07='1' THEN #統制帳戶
                 CALL cl_err(g_oob[l_ac].oob11,'agl-015',0) NEXT FIELD oob11
              END IF
             #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
              LET g_errno = ' '   
              IF l_aag05 = 'Y' THEN
                #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                 IF g_aaz.aaz90 !='Y' THEN
                    IF NOT cl_null(g_oob[l_ac].oob13) THEN 
                       CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob11,g_oob[l_ac].oob13,g_bookno1)  
                                     RETURNING g_errno
                    END IF
                 END IF
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err('',g_errno,0)
                    NEXT FIELD oob11
                 END IF
              ELSE                                  #MOD-920163 add
                 LET g_oob[l_ac].oob13=''           #MOD-920163 add
                 DISPLAY BY NAME g_oob[l_ac].oob13  #MOD-920163 add
              END IF
              CALL t400_set_no_entry_b1()   #MOD-920163 add
              CALL t400_set_entry_b1()      #MOD-920163 add
           END IF
 
        AFTER FIELD oob111
           IF g_oob[l_ac].oob111 IS NULL THEN NEXT FIELD oob111 END IF   
           IF NOT cl_null(g_oob[l_ac].oob111) THEN
              SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05  #FUN-8C0089 add aag05,l_aag05
                FROM aag_file
               WHERE aag01=g_oob[l_ac].oob111
                 AND aag00=g_bookno2      # No.FUN-730073
                 AND aag07 IN ('2','3')   #No.FUN-AA0088 yinhy 
                 AND aag03 = '2'          #No.FUN-AA0088 yinhy
              IF STATUS THEN
                 #No.FUN-AA0088 yinhy --Begin
                 #CALL cl_err3("sel","aag_file",g_oob[l_ac].oob111,"",STATUS,"","select aag",1)  
                 CALL cl_err3("sel","aag_file",g_oob[l_ac].oob111,"",STATUS,"","select aag",0)  
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ='q_aag'
                 LET g_qryparam.construct = 'N'
                 LET g_qryparam.default1 =g_oob[l_ac].oob111
                 LET g_qryparam.arg1 = g_bookno2
                 LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob[l_ac].oob111 CLIPPED,"%'"                 
                 CALL cl_create_qry() RETURNING g_oob[l_ac].oob111
                 DISPLAY BY NAME g_oob[l_ac].oob111   
                 #No.FUN-AA0088 yinhy --End                
                 NEXT FIELD oob111
              END IF
              IF l_aag07='1' THEN #統制帳戶
                 CALL cl_err(g_oob[l_ac].oob111,'agl-015',0) NEXT FIELD oob111
              END IF
 
             #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
              LET g_errno = ' '   
              IF l_aag05 = 'Y' THEN
                #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                 IF g_aaz.aaz90 !='Y' THEN
                    IF NOT cl_null(g_oob[l_ac].oob13) THEN 
                       CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob111,g_oob[l_ac].oob13,g_bookno2)  
                                     RETURNING g_errno
                    END IF
                 END IF
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err('',g_errno,0)
                    NEXT FIELD oob111
                 END IF
              END IF
           END IF
 
        BEFORE FIELD oob13
           LET l_aag05=''
           SELECT aag05 INTO l_aag05 FROM aag_file
            WHERE aag01=g_oob[l_ac].oob11
              AND aag00=g_bookno1          #No.FUN-730073
           IF l_aag05='N' THEN
              LET g_oob[l_ac].oob13=''
              DISPLAY BY NAME g_oob[l_ac].oob13
           END IF
           CALL t400_set_no_entry_b1()   #MOD-920163 add
           CALL t400_set_entry_b1()      #MOD-920163 add
 
        AFTER FIELD oob13
           IF NOT cl_null(g_oob[l_ac].oob13) THEN
              SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob[l_ac].oob13
                 AND gemacti='Y'   #NO:6950
              IF STATUS THEN
                 CALL cl_err3("sel","gem_file",g_oob[l_ac].oob13,"",STATUS,"","select gem",1)  #No.FUN-660116
                 NEXT FIELD oob13
              END IF
             #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
              LET l_aag05=''   
              SELECT aag05 INTO l_aag05 FROM aag_file
               WHERE aag01 = g_oob[l_ac].oob11
                 AND aag00 = g_bookno1      
             
              LET g_errno = ' '   
              IF l_aag05 = 'Y' AND NOT cl_null(g_oob[l_ac].oob11) THEN
                #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                 IF g_aaz.aaz90 !='Y' THEN    
                    CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob11,g_oob[l_ac].oob13,g_bookno1)
                                  RETURNING g_errno
                 END IF
                 IF NOT cl_null(g_errno) THEN
                    CALL cl_err('',g_errno,0)
                    NEXT FIELD oob13
                 END IF
              END IF
             
              IF g_aza.aza63='Y' THEN 
                 LET l_aag05=''   
                 SELECT aag05 INTO l_aag05 FROM aag_file
                  WHERE aag01 = g_oob[l_ac].oob111
                    AND aag00 = g_bookno2      
                 
                 LET g_errno = ' '   
                 IF l_aag05 = 'Y' AND NOT cl_null(g_oob[l_ac].oob111) THEN
                   #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                    IF g_aaz.aaz90 !='Y' THEN  
                       CALL s_chkdept(g_aaz.aaz72,g_oob[l_ac].oob111,g_oob[l_ac].oob13,g_bookno2)
                                     RETURNING g_errno
                    END IF
                    IF NOT cl_null(g_errno) THEN
                       CALL cl_err('',g_errno,0)
                       NEXT FIELD oob13
                    END IF
                 END IF
              END IF  
           END IF
           LET l_aag05=''
           SELECT aag05 INTO l_aag05 FROM aag_file
            WHERE aag01=g_oob[l_ac].oob11  
              AND aag00=g_bookno1        #No.FUN-730073
           IF l_aag05='Y' AND cl_null(g_oob[l_ac].oob13) THEN
              CALL cl_err('','aap-099',0)
              NEXT FIELD oob13
           END IF

        AFTER FIELD oobud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        BEFORE DELETE                            #是否取消單身
           DISPLAY "g_oob_t.oob02=",g_oob_t.oob02
           IF g_oob_t.oob02 > 0 AND g_oob_t.oob02 IS NOT NULL THEN
              IF NOT cl_delb(0,0) THEN
                 LET g_success = 'N'   #MOD-730060
                 CANCEL DELETE
              END IF
              IF l_lock_sw = "Y" THEN
                 CALL cl_err("", -263, 1)
                 LET g_success = 'N'   #MOD-730060
                 CANCEL DELETE
              END IF
              # genero shell add end
              DELETE FROM oob_file
               WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_t.oob02
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_t.oob02,SQLCA.sqlcode,"","",1)  #No.FUN-660116
                 LET g_success = 'N'   #MOD-730060
                 CANCEL DELETE
              END IF
              CALL t400_mlog('R')
              IF g_success = 'Y' THEN
                 IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                    LET l_ooa34 = '0'
                 END IF                                   #No.FUN-8A0075
                 LET g_rec_b=g_rec_b-1
                 DISPLAY g_rec_b TO FORMONLY.cn2
                 IF cl_null(g_oob_t.oob02) THEN
                    LET g_rec_b=g_rec_b-1
                 END IF
                 COMMIT WORK
              ELSE
                 ROLLBACK WORK
              END IF
           END IF   #MOD-850246 add
           CALL t400_bu()
 
        ON ROW CHANGE
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              LET g_oob[l_ac].* = g_oob_t.*
              CLOSE t400_bcl
              ROLLBACK WORK
              EXIT INPUT
           END IF
           IF l_lock_sw = 'Y' THEN
              CALL cl_err(g_oob[l_ac].oob02,-263,1)
              LET g_oob[l_ac].* = g_oob_t.*
              LET g_success='N'   #MOD-730060
           ELSE
              CALL t400_b_move_back()
              SELECT COUNT(*) INTO l_n FROM oob_file
               WHERE oob01=g_ooa.ooa01  AND oob02=g_oob[l_ac].oob02
              IF l_n = 0 THEN                                   #<-NO:0352--
                 IF g_oob[l_ac].oob09 = 0 AND g_oob[l_ac].oob10 = 0 THEN
                    INITIALIZE g_oob[l_ac].* TO NULL  #重要欄位空白,無效
                    LET g_success='N'   #MOD-730060
                 END IF
              END IF
              UPDATE oob_file SET * = b_oob.*
                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_t.oob02
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_t.oob02,SQLCA.sqlcode,"","upd oob",1)  #No.FUN-660116
                 LET g_oob[l_ac].* = g_oob_t.*
                 LET g_success='N'   #MOD-730060
              ELSE 
                 UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
                  WHERE ooa01 = g_ooa.ooa01 
                 IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                    CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
                    LET g_oob[l_ac].* = g_oob_t.*
                    LET g_success='N'   
                 END IF
                 DISPLAY g_user TO ooamodu
                 DISPLAY g_today TO ooadate
               END IF
           END IF
           CALL t400_mlog('U')
           CALL t400_bu()
           IF g_success = 'Y' THEN
              MESSAGE 'UPDAET O.K'
              IF g_ooa.ooa34 NOT matches '[Ss]' THEN   #No.FUN-8A0075
                 LET l_ooa34 = '0'
              END IF                                   #No.FUN-8A0075
              COMMIT WORK
              LET g_change = 'Y'    #MOD-B60022
           ELSE
              MESSAGE 'UPDATE ERR'
              ROLLBACK WORK
           END IF
 
        AFTER ROW
           LET l_ac = ARR_CURR()
           #LET l_ac_t = l_ac   #FUN-D30032
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              IF p_cmd = 'u' THEN
                 LET g_oob[l_ac].* = g_oob_t.*
              #FUN-D30032--add--str--
              ELSE
                 CALL g_oob.deleteElement(l_ac)
                 IF g_rec_b != 0 THEN
                    LET g_action_choice = "detail_b1"
                    LET l_ac = l_ac_t
                 END IF
              #FUN-D30032--add--end--
              END IF
              CLOSE t400_bcl
              ROLLBACK WORK
              EXIT INPUT             
           END IF
           IF l_ac <= g_oob.getLength() THEN   #MOD-B80099 add
#No.FUN-AB0034 --begin
              IF g_ooz.ooz62='Y' AND g_oob[l_ac].oob03 ='2' AND g_oob[l_ac].oob04 ='1' AND cl_null(g_oob[l_ac].oob15) THEN
                 NEXT FIELD oob15                                                 
              END IF    
#No.FUN-AB0034 --end
           END IF   #MOD-B80099 add
           LET l_ac_t = l_ac   #FUN-D30032
           CLOSE t400_bcl
           COMMIT WORK
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(oob02) AND l_ac > 1 THEN
                LET g_oob[l_ac].* = g_oob[l_ac-1].*
                LET g_oob[l_ac].oob02 = NULL
                NEXT FIELD oob02
            END IF

        ON ACTION controls                             #No.FUN-6A0092
           CALL cl_set_head_visible("","AUTO")         #No.FUN-6A0092
 
        ON ACTION CONTROLP
           CASE
#MOD-590452 將原本mark的部份取消
              WHEN INFIELD(oob04)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_ooc"
                   LET g_qryparam.default1 = g_oob[l_ac].oob04
                   IF g_aza.aza63 = 'N' THEN     #MOD-A50055 add
                      LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  #No.TQC-7B0028
                   END IF         #MOD-A50055  add
                   CALL cl_create_qry() RETURNING g_oob[l_ac].oob04
                   DISPLAY BY NAME g_oob[l_ac].oob04         #No.MOD-490344
                   NEXT FIELD oob04
              #--- 970421 新增
              WHEN INFIELD(oob06)
                  #No.TQC-DA0003 ---Mark--- Start
                  ##FUN-D80031 -------- add ----- begin #开窗oma_file的20类型的资料
                  #IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='H' THEN
                  #CALL cl_init_qry_var()
                  #LET g_qryparam.form = "q_oma01_20"
                  #LET g_qryparam.default1 = g_oob[l_ac].oob06
                  #CALL cl_create_qry() RETURNING g_oob[l_ac].oob06
                  #DISPLAY BY NAME g_oob[l_ac].oob06
                  #NEXT FIELD oob06
                  #END IF
                  ##FUN-D80031 -------- add ----- end
                  #No.TQC-DA0003 ---Mark--- End
                   IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
                      CALL cl_init_qry_var()
                      LET g_qryparam.form = "q_nmh5"
                      LET g_qryparam.arg1 = g_ooa.ooa03
                      LET g_qryparam.arg2 = g_doc_len   #MOD-770022
                      CALL cl_create_qry() RETURNING g_oob[l_ac].oob06
                      NEXT FIELD oob06
                   END IF
                   IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
                      CALL cl_init_qry_var()
                      LET g_qryparam.form = "q_nmg"
                      LET g_qryparam.default1 = g_oob[l_ac].oob06
                       LET g_qryparam.arg1 = g_ooa.ooa03   #No.MOD-530346
                      CALL cl_create_qry() RETURNING g_oob[l_ac].oob06
                      NEXT FIELD oob06
                   END IF
                   IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
                      CALL q_oma4(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, 
                                  g_ooa.ooa01,g_ooa.ooa03,'2*',g_ooa.ooa23)        #MOD-D60149 add ooa23                
                           RETURNING b_oob.oob06,b_oob.oob09,       #No.FUN-680022-- add oob19
                                     b_oob.oob10,b_oob.oob19
                      IF b_oob.oob06 IS NOT NULL THEN
                         LET g_oob[l_ac].oob06 = b_oob.oob06
                         LET g_oob[l_ac].oob19 = b_oob.oob19   #No.FUN-680022 --add
                         LET g_oob[l_ac].oob09 = b_oob.oob09
                         LET g_oob[l_ac].oob10 = b_oob.oob10
                      END IF
                      NEXT FIELD oob06
                   END IF
                   IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='9' THEN
                      CALL q_apa4( FALSE, TRUE, ' ')
                      RETURNING b_oob.oob06
                      IF b_oob.oob06 IS NOT NULL THEN
                         LET g_oob[l_ac].oob06 = b_oob.oob06
                      END IF
                      NEXT FIELD oob06
                   END IF
                   IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
                      IF g_ooz.ooz62='N' THEN
                         CALL q_oma4(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02, #No.FUN-670026 
                                     g_ooa.ooa01,g_ooa.ooa03,'1*',g_ooa.ooa23)       #No.FUN-670026  #MOD-D60149 add ooa23
                              RETURNING b_oob.oob06,b_oob.oob09,  #No.FUN-680022 --add oob19
                                        b_oob.oob10,b_oob.oob19
                      ELSE
                         CALL q_omb(FALSE,TRUE,g_oob[l_ac].oob06,g_oob[l_ac].oob02,
                                    g_ooa.ooa01, g_ooa.ooa03,'1%') #No.FUN-550131 1* -> 1%
                          RETURNING b_oob.oob06,b_oob.oob15,
                                    b_oob.oob09,b_oob.oob10
                      END IF
                      IF b_oob.oob06 IS NOT NULL THEN
                         LET g_oob[l_ac].oob06 = b_oob.oob06
                         LET g_oob[l_ac].oob09 = b_oob.oob09
                         LET g_oob[l_ac].oob10 = b_oob.oob10
                         IF g_ooz.ooz62='Y' THEN
                            LET g_oob[l_ac].oob15 = b_oob.oob15
                         ELSE
                            LET g_oob[l_ac].oob19 = b_oob.oob19
                         END IF
                      END IF
                      NEXT FIELD oob06
                   END IF
                   IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='9' THEN
                      CALL q_apa5( FALSE, TRUE, ' ')
                           RETURNING b_oob.oob06
                      IF b_oob.oob06 IS NOT NULL THEN
                         LET g_oob[l_ac].oob06 = b_oob.oob06
                      END IF
                      NEXT FIELD oob06
                   END IF
                   DISPLAY BY NAME g_oob[l_ac].oob06     #No.MOD-490344
                   DISPLAY BY NAME g_oob[l_ac].oob09     #No.MOD-490344
                   DISPLAY BY NAME g_oob[l_ac].oob10     #No.MOD-490344
                   DISPLAY BY NAME g_oob[l_ac].oob15     #No.MOD-490344
              WHEN INFIELD(oob11)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_aag'
                   LET g_qryparam.default1 =g_oob[l_ac].oob11
                   LET g_qryparam.arg1 = g_bookno1      #No.FUN-730073 
                   CALL cl_create_qry() RETURNING g_oob[l_ac].oob11
                   DISPLAY BY NAME g_oob[l_ac].oob11
                   NEXT FIELD oob11
              WHEN INFIELD(oob111)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_aag'
                   LET g_qryparam.default1 =g_oob[l_ac].oob111
                   LET g_qryparam.arg1 = g_bookno2      #No.FUN-730073 
                   CALL cl_create_qry() RETURNING g_oob[l_ac].oob111
                   DISPLAY BY NAME g_oob[l_ac].oob111
                   NEXT FIELD oob111
              WHEN INFIELD(oob13)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = 'q_gem'
                   LET g_qryparam.default1 = g_oob[l_ac].oob13
                   CALL cl_create_qry() RETURNING g_oob[l_ac].oob13
                   DISPLAY BY NAME g_oob[l_ac].oob13
                   NEXT FIELD oob13
              WHEN INFIELD(oob07)
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_azi'
                   LET g_qryparam.default1 =g_oob[l_ac].oob07
                   CALL cl_create_qry() RETURNING g_oob[l_ac].oob07
                   DISPLAY BY NAME g_oob[l_ac].oob07
                   NEXT FIELD oob07
              WHEN INFIELD(oob08)
                   CALL s_rate(g_oob[l_ac].oob07,g_oob[l_ac].oob08)
                   RETURNING g_oob[l_ac].oob08
                   DISPLAY BY NAME g_oob[l_ac].oob08
                   NEXT FIELD oob08
              OTHERWISE EXIT CASE
           END CASE
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION receive_notes
           IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1' THEN
              CALL cl_cmdrun_wait('anmt200')  #FUN-660216 add
           END IF

        ON ACTION bank_income_expense
           IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2' THEN
              CALL cl_cmdrun_wait('anmt302')  #FUN-660216 add
           END IF

        ON ACTION maintain_accounts
           IF g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='3' THEN
              CALL cl_cmdrun_wait('axrt300')  #FUN-660216 add
           END IF
           IF g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04='1' THEN
              CALL cl_cmdrun_wait('axrt300')  #FUN-660216 add
           END IF

        ON ACTION ar_account_category
           CALL cl_cmdrun('axri040')
 
        ON ACTION auto_contra
           CALL t400_g_b2()
           CALL t400_b_fill_2('1=1')   #MOD-B40214 add
           EXIT INPUT         
 
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
      
#      #FUN-A90003--Add--Begin--#
#      INPUT ARRAY g_oob_d FROM s_oob_d.*
#            ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED,
#                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
# 
#        BEFORE INPUT
#            IF g_rec_b2 != 0 THEN
#               CALL fgl_set_arr_curr(l_ac2)
#            END IF
# 
#        BEFORE ROW
#            LET p_cmd = ''
#            LET l_ac2 = ARR_CURR()
#            DISPLAY l_ac2 TO FORMONLY.cn4
#            LET l_lock_sw = 'N'                   #DEFAULT
#            LET l_n  = ARR_COUNT()
#            LET g_success = 'Y'  
#            BEGIN WORK
# 
#            OPEN t400_cl USING g_ooa.ooa01
#            IF STATUS THEN
#               CALL cl_err("OPEN t400_cl:", STATUS, 1)
#               CLOSE t400_cl
#               ROLLBACK WORK
#               RETURN
#            END IF
#            FETCH t400_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
#            IF SQLCA.sqlcode THEN
#               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
#               CLOSE t400_cl 
#               ROLLBACK WORK 
#               RETURN
#            END IF
#            IF g_rec_b2>=l_ac2 THEN
#               LET p_cmd='u'
#               LET g_oob_d_t.* = g_oob_d[l_ac2].*  #BACKUP
#               OPEN t400_bcl USING g_ooa.ooa01,g_oob_d_t.oob02_1
#               IF STATUS THEN
#                  CALL cl_err("OPEN t400_bcl:", STATUS, 1)
#                  LET l_lock_sw = "Y"
#                  CLOSE t400_bcl
#                  ROLLBACK WORK
#               ELSE
#                  FETCH t400_bcl INTO b_oob.*
#                  IF SQLCA.sqlcode THEN
#                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
#                      LET l_lock_sw = "Y"
#                  ELSE
#                      CALL t400_b_move_to_2()
#                  END IF
#               END IF
#               CALL t400_set_entry_b_2()
#               CALL t400_set_entry_b_1_2()    
#               CALL t400_set_no_entry_b_2()
#               CALL t400_set_no_entry_b1_2()
#               CALL t400_set_entry_b1_2()
#               CALL t400_set_no_entry_b_1_2()    
#               CALL t400_set_no_required_b_2()   
#               CALL t400_set_required_b_2()      
#               CALL cl_show_fld_cont()             
#               CALL cl_show_fld_cont()    
#            END IF
# 
#        AFTER INSERT
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               LET g_success = 'N'   
#               CANCEL INSERT
#            END IF
#            CALL t400_b_move_back_2()
#            SELECT COUNT(*) INTO l_n FROM oob_file
#             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
#            IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
#               IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                  (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                  IF NOT t400_oob09_1_13_2('2',p_cmd) THEN
#                  END IF
#               END IF
#            END IF
#            INSERT INTO oob_file VALUES(b_oob.*)
#            IF SQLCA.sqlcode THEN
#               LET g_success = 'N'   
#               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  
#               CANCEL INSERT
#            END IF
#            CALL t400_mlog('A')
#            CALL t400_bu()
#            IF g_success = 'Y' THEN
#               MESSAGE 'INSERT O.K'
#               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
#                  LET l_ooa34 = '0'
#               END IF                                   
#               LET g_rec_b2=g_rec_b2+1
#               DISPLAY g_rec_b2 TO FORMONLY.cn3
#               COMMIT WORK
#            ELSE
#               MESSAGE 'INSERT ERR'
#               ROLLBACK WORK
#            END IF
#        BEFORE INSERT
#            LET l_n = ARR_COUNT()
#            LET p_cmd='a'
#            INITIALIZE g_oob_d[l_ac2].* TO NULL      
#            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
#                LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
#            END IF
#            LET b_oob.oob01=g_ooa.ooa01
#            LET b_oob.ooblegal = g_ooa.ooalegal
#            LET g_oob_d[l_ac2].oob08_1=1
#            LET g_oob_d[l_ac2].oob09_1=0
#            LET g_oob_d[l_ac2].oob10_1=0
#            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料
#            LET g_oob_d[l_ac2].oob03_d = '2'               #新輸入資料
#            LET g_oob_d[l_ac2].oob04_1 = '1'               #新輸入資料
#            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料   
#            CALL t400_set_entry_b_2()
#            CALL t400_set_entry_b_1_2()   
#            CALL t400_set_no_entry_b_2()
#            CALL t400_set_no_required_b_2()  
#            CALL t400_set_required_b_2()     
#            CALL cl_show_fld_cont()     
# 
#            NEXT FIELD oob02_1
# 
#        BEFORE FIELD oob02_1                            #default 序號
#           IF g_oob_d[l_ac2].oob02_1 IS NULL OR g_oob_d[l_ac2].oob02_1 = 0 THEN
#                IF l_ac2>1 THEN LET g_chr=g_oob_d[l_ac2-1].oob03_d END IF
#                SELECT MAX(oob02)+1 INTO g_oob_d[l_ac2].oob02_1 FROM oob_file
#                   WHERE oob01 = g_ooa.ooa01
#                IF g_oob_d[l_ac2].oob02_1 IS NULL THEN
#                    LET g_oob_d[l_ac2].oob02_1 = 1
#                END IF
#           END IF
# 
#        AFTER FIELD oob02_1                        #check 序號是否重複
#            IF NOT cl_null(g_oob_d[l_ac2].oob02_1) THEN
#               IF g_oob_d[l_ac2].oob02_1 != g_oob_d_t.oob02_1 OR g_oob_d_t.oob02_1 IS NULL THEN
#                  SELECT count(*) INTO l_n FROM oob_file
#                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob_d[l_ac2].oob02_1
#                  IF l_n > 0 THEN
#                     LET g_oob_d[l_ac2].oob02_1 = g_oob_d_t.oob02_1
#                     CALL cl_err('',-239,0) NEXT FIELD oob02_1
#                  END IF
#               END IF
#            END IF
# 
#        AFTER FIELD oob03_d
#           IF NOT cl_null(g_oob_d[l_ac2].oob03_d) THEN
#              IF g_oob_d[l_ac2].oob03_d NOT MATCHES "[12]" THEN NEXT FIELD oob03_d END IF
#                 IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN                                                                             
#                    LET l_cnt = 0                                                                                                   
#                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
#                       WHERE ooc01 = g_oob_d[l_ac2].oob04_1                                                                              
#                    IF l_cnt = 0 THEN                                                                                               
#                       IF g_oob_d[l_ac2].oob03_d='1' THEN                                                                                
#                          IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,E,Q]' THEN     
#                             CALL cl_err('','axr-917',0)                                                                            
#                             NEXT FIELD oob04_1                                                                                       
#                          END IF                                                                                                    
#                       ELSE                                                                                                         
#                          IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,B]' THEN                                                    
#                             CALL cl_err('','axr-917',0)                                                                            
#                             NEXT FIELD oob04_1                                                                                       
#                          END IF                                                                                                    
#                       END IF                                                                                                       
#                    END IF                                                                                                          
#                 END IF                                                                                                             
#           END IF
# 
#        BEFORE FIELD oob04_1
#           CALL t400_set_entry_b_2()
#           CALL t400_set_no_required_b_2()   
# 
#        AFTER FIELD oob04_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM ooc_file
#                 WHERE ooc01 = g_oob_d[l_ac2].oob04_1
#              IF l_cnt = 0 THEN
#                 IF g_oob_d[l_ac2].oob03_d='1' THEN
#                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,E,Q]' THEN       
#                       CALL cl_err('','axr-917',0)
#                       NEXT FIELD oob04_1
#                    END IF
#                 ELSE
#                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,B]' THEN    
#                       CALL cl_err('','axr-917',0)
#                       NEXT FIELD oob04_1
#                    END IF
#                 END IF
#              END IF
#              SELECT azi04 INTO t_azi04 FROM azi_file               
#               WHERE azi01 = g_oob_d[l_ac2].oob07_1  
#             #若oob04_1='9'時,oob15_1預設值為0,無須維護
#              IF g_oob_d[l_ac2].oob04_1='9' THEN
#                 LET g_oob_d[l_ac2].oob15_1=0
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob15_1
#              END IF
#              CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
#                   RETURNING g_oob_d[l_ac2].oob04_1_d
#              CALL t400_acct_code_2()
#              IF g_oob_d[l_ac2].oob11_1 IS NULL THEN
#                 SELECT ooc03 INTO g_oob_d[l_ac2].oob11_1 FROM ooc_file
#                  WHERE ooc01=g_oob_d[l_ac2].oob04_1
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1  
#              END IF
#              IF g_aza.aza63='Y' THEN
#                 IF g_oob_d[l_ac2].oob111_1 IS NULL THEN
#                    SELECT ooc04 INTO g_oob_d[l_ac2].oob111_1 FROM ooc_file
#                     WHERE ooc01=g_oob_d[l_ac2].oob04_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                 END IF
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = "7" AND
#                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN
#                 CALL cl_err('','axr-204',0) NEXT FIELD oob04_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[567]" AND
#                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
#                 IF g_ooa31_diff = 0
#                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
#                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
#                 END IF
#                 LET g_oob_d[l_ac2].oob09_1 = g_ooa31_diff
#                 LET g_oob_d[l_ac2].oob10_1 = g_ooa32_diff
#                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
#                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#		 DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
#		 DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
#		 DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
#              END IF
#              IF g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[23]" AND
#                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
#                 IF g_ooa31_diff = 0
#                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
#                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
#                 END IF
#                 LET g_oob_d[l_ac2].oob09_1 = -g_ooa31_diff
#                 LET g_oob_d[l_ac2].oob10_1 = -g_ooa32_diff
#                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) 
#                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#	         DISPLAY BY NAME g_oob_d[l_ac2].oob08_1  
#	         DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
#	         DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
#              END IF
#
#              IF g_oob_d[l_ac2].oob04_1='7' THEN
#                 LET g_oob_d[l_ac2].oob07_1 = g_aza.aza17 
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
#              END IF
#
#         END IF
#         CALL t400_set_no_entry_b_2()
#         CALL t400_set_no_entry_b1_2()            
#         CALL t400_set_entry_b1_2()            
#         CALL t400_set_required_b_2()      
# 
#        AFTER FIELD oob06_1
#           IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
#             #若為借方，且非待扺
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 != '3' THEN
#                 IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
#                       g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN   
#                    CALL t400_oob06_1_2()
# 
#                    IF g_errno = 'N' THEN
#                       NEXT FIELD oob06_1
#                    END IF
#                 END IF
#              END IF
# 
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
#                  WHERE nmh01 = g_oob_d[l_ac2].oob06_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
#                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
#                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                 SELECT oma02 INTO l_nmh04 FROM oma_file
#                  WHERE oma00 MATCHES '2*'
#                    AND oma01 = g_oob_d[l_ac2].oob06_1 
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                 SELECT apa02 INTO l_nmh04 FROM apa_file
#                  WHERE apa00 matches'1*'
#                    AND apa01 = g_oob_d[l_ac2].oob06_1
#                    AND apa02 <= g_ooa.ooa02        
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                 SELECT oma02 INTO l_nmh04 FROM oma_file
#                  WHERE  oma00 MATCHES '1*'
#                    AND oma01 = g_oob_d[l_ac2].oob06_1 
#              END IF
#              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                 SELECT apa02 INTO l_nmh04 FROM apa_file
#                  WHERE apa00 matches'2*'
#                    AND apa01 = g_oob_d[l_ac2].oob06_1
#                    AND apa02 <= g_ooa.ooa02        
#              END IF 
#  
#              IF SQLCA.sqlcode THEN
#                 CALL cl_err3("sel","nmh_file",g_oob_d[l_ac2].oob06_1,"",SQLCA.sqlcode,"","",0) 
#              ELSE
#                 IF l_nmh04 > g_ooa.ooa02 THEN
#                    CALL cl_err('','axr-371',0)
#                    NEXT FIELD oob06_1
#                 END IF 
#              END IF
# 
#              CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2
#              IF g_flag='1' THEN
#                 CALL cl_err(l_nmh04,'aoo-081',1)
#                 NEXT FIELD oob06_1
#              END IF        
# 
#             IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[39]" THEN                         
#                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
#                   IF g_oob_d[l_ac2].oob04_1 = '3' THEN 
#                      SELECT oma00 INTO l_oma00 FROM oma_file
#                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND
#                         (l_oma00!='24') AND (l_oma00!='25') AND (l_oma00!='26') THEN   
#                         CALL cl_err('','axr-992',0)
#                         NEXT FIELD oob06_1
#                      END IF 
#                     #---add---start---
#                      SELECT COUNT(*) INTO l_i FROM omc_file 
#                       WHERE omc01=g_oob_d[l_ac2].oob06_1
#                      IF l_i=1 THEN
#                         LET g_oob_d[l_ac2].oob19_1=1
#                         CALL t400_oob06_1_2()
#                         IF g_errno = 'N' THEN
#                            NEXT FIELD oob19_1
#                         ELSE 
#                            IF g_ooz.ooz62 = 'Y' THEN
#                               NEXT FIELD oob15_1
#                            ELSE
#                               NEXT FIELD oob11_1
#                            END IF
#                         END IF
#                      END IF 
#                   END IF 
#                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
#                      SELECT apa00 INTO l_apa00 FROM apa_file
#                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
#                         AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
#                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') AND (l_apa00!='13') THEN   #MOD-A50047 add l_apa00!='13'
#                         CALL cl_err('','axr-993',0)
#                         NEXT FIELD oob06_1 
#                      END IF   
#                   END IF 
#                END IF                 
#             END IF 
#             
#             IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN
#                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
#                   IF g_oob_d[l_ac2].oob04_1 = '1' THEN 
#                      SELECT oma00 INTO l_oma00 FROM oma_file
#                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
#                      IF (l_oma00!='11') AND (l_oma00!='12') AND
#                         (l_oma00!='13') AND (l_oma00!='14') AND (l_oma00 !='15') AND
#                         (l_oma00!='17') THEN      
#                         CALL cl_err('','axr-994',0)
#                         NEXT FIELD oob06_1
#                      END IF 
#                   END IF 
#                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
#                      SELECT apa00 INTO l_apa00 FROM apa_file
#                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
#                         AND apa02 <= g_ooa.ooa02        
#                      IF (l_apa00!='21') AND (l_apa00!='22') AND
#                         (l_apa00!='23') AND (l_apa00!='24') THEN 
#                         CALL cl_err('','axr-995',0)
#                         NEXT FIELD oob06_1 
#                      END IF   
#                   END IF                    
#                   IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN   #MOD-A10084 add
#                      CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)  
#                      IF NOT cl_null(g_errno) THEN 
#                         CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                         NEXT FIELD oob19_1   
#                      END IF 
#                   END IF   
#                   IF g_oob_d[l_ac2].oob04_1='1' THEN 
#                      SELECT COUNT(*) INTO l_i FROM omc_file 
#                       WHERE omc01=g_oob_d[l_ac2].oob06_1
#                      IF l_i=1 THEN
#                         LET g_oob_d[l_ac2].oob19_1=1
#                         CALL t400_oob06_1_2()
#                         IF g_errno = 'N' THEN
#                            NEXT FIELD oob19_1
#                         ELSE 
#                            IF g_ooz.ooz62 = 'Y' THEN
#                               NEXT FIELD oob15_1
#                            ELSE
#                               NEXT FIELD oob11_1
#                            END IF
#                         END IF
#                      END IF 
#                   END IF
#                   IF g_oob_d[l_ac2].oob04_1='9' THEN 
#                      SELECT COUNT(*) INTO l_i FROM apc_file
#                       WHERE apc01=g_oob_d[l_ac2].oob06_1
#                      IF l_i=1 THEN
#                         LET g_oob_d[l_ac2].oob19_1=1
#                         CALL t400_oob06_1_2()
#                         IF g_errno = 'N' THEN
#                            NEXT FIELD oob19_1
#                         ELSE 
#                            IF g_ooz.ooz62 = 'Y' THEN
#                               NEXT FIELD oob15_1
#                            ELSE
#                               NEXT FIELD oob11_1
#                            END IF
#                         END IF
#                      END IF 
#                   END IF                   
#                END IF 
#              END IF
#           END IF
# 
# 
#        BEFORE FIELD oob19_1
#           CALL t400_set_no_entry_b1_2()
#           CALL t400_set_entry_b1_2()
# 
#        AFTER FIELD oob19_1
#           IF cl_null(g_oob_d[l_ac2].oob19_1) AND 
#              NOT (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='4') THEN  
#              CALL cl_err("","axr-411",1)
#              NEXT FIELD oob06_1 
#           END IF 
#           IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN
#             #若為待扺，或為貸方
#              IF (g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR                
#                  g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1 OR 
#                  g_oob_d_t.oob19_1 != g_oob_d[l_ac2].oob19_1 ) THEN  
#                 CALL t400_oob06_1_2()
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob19_1
#                 END IF
#                 CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)
#                 IF NOT cl_null(g_errno) THEN 
#                    CALL cl_err(g_oob_d[l_ac2].oob19_1,g_errno,0)
#                    NEXT FIELD oob19_1
#                 END IF 
#              END IF
#           END IF
#           
#        
#        BEFORE FIELD oob15_1
#           CALL t400_set_no_entry_b1_2() 
#           CALL t400_set_entry_b1_2()
# 
# 
#        AFTER FIELD oob15_1
#           IF g_ooz.ooz62 = 'Y' THEN  
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#           END IF
# 
#            IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN  
#               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
#                  CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)  #MOD-A10084 add oob19_1
#                  IF NOT cl_null(g_errno) THEN 
#                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
#                     NEXT FIELD oob06_1
#                  END IF 
#               END IF 
#            END IF   
#           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
#              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 NEXT FIELD oob15_1
#              END IF
#              LET l_cnt = 0
#              SELECT COUNT(*) INTO l_cnt FROM oob_file
#                WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND
#                      oob15_1 = g_oob_d[l_ac2].oob15_1 AND
#                      oob01 = g_ooa.ooa01
#              IF p_cmd = 'a' THEN
#                 IF l_cnt > 0 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              ELSE
#                 IF l_cnt > 1 THEN
#                    NEXT FIELD oob15_1
#                 END IF
#              END IF
#              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
#                 g_oob_d_t.oob15_1 IS NULL THEN
#                 CALL t400_oob06_1_12_2()
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
#                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
#                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
#                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
#   
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob06_1
#                 END IF
#              END IF
#          ELSE
#              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
#                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
#                 CALL t400_oob06_1_item_2()
#              END IF
#          END IF 
# 
#        BEFORE FIELD oob07_1
#           IF cl_null(g_oob_d[l_ac2].oob07_1) AND NOT cl_null(g_ooa.ooa23) THEN
#              LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
#           END IF
#           # 971021 TT/NR/CN/AR 不允許修改幣別
#           IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
#              (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
#           END IF
# 
#        AFTER FIELD oob07_1
#           IF g_oob_d[l_ac2].oob07_1 IS NULL THEN NEXT FIELD oob07_1 END IF  
### No.2693 modify 1998/10/31 至少需判斷幣別為正確值
#           IF NOT cl_null(g_oob_d[l_ac2].oob07_1) THEN
#              CALL t400_oob07_1_2('a')
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err(g_oob_d[l_ac2].oob07_1,g_errno,0)
#                 LET g_oob_d[l_ac2].oob07_1 = g_oob_d_t.oob07_1
#                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
#                 NEXT FIELD oob07_1
#              END IF
#            END IF
# 
#        BEFORE FIELD oob08_1
#           CALL cl_set_comp_entry("oob08_1",TRUE)
#           CALL t400_set_no_entry_b_2()
#           LET oob08_t=g_oob_d[l_ac2].oob08_1   #No.+010
#           # 971021 TT/NR/CN/AR 不允許修改匯率
#           IF g_oob_d[l_ac2].oob08_1 = 0 OR g_oob_d[l_ac2].oob08_1 = 1 OR
#              cl_null(g_oob_d[l_ac2].oob08_1) THEN
#              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
#                   RETURNING g_oob_d[l_ac2].oob08_1
#              DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
#           END IF
#           LET oob08_t=g_oob_d[l_ac2].oob08_1
# 
#        AFTER FIELD oob08_1
#           CALL cl_set_comp_entry("oob08_1",TRUE)
#           IF (oob08_t!=g_oob_d[l_ac2].oob08_1) THEN
#              LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
#              CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)
#                   RETURNING g_oob_d[l_ac2].oob10_1
#           END IF
# 
#        BEFORE FIELD oob09_1
#           LET oob09_t=g_oob_d[l_ac2].oob09_1
# 
#        AFTER FIELD oob09_1
#
### No.2694 modify 1998/10/31 判斷金額是否沖過頭
#           IF NOT cl_null(g_oob_d[l_ac2].oob09_1) THEN
#              IF g_oob_d_t.oob09_1 != g_oob_d[l_ac2].oob09_1 OR
#                 g_oob_d_t.oob09_1 IS NOT NULL THEN
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
#                    IF NOT t400_oob09_1_11_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
#                    IF NOT t400_oob09_1_12_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                    IF NOT t400_oob09_1_13_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t400_oob09_1_19_2('1',p_cmd,'1') THEN   #MOD-750063
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t400_oob09_1_19_2('1',p_cmd,'2') THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#              END IF
#              IF (oob08_t!=g_oob_d[l_ac2].oob08_1) OR (oob09_t!=g_oob_d[l_ac2].oob09_1) OR oob09_t IS NULL THEN #MOD-740395
#                  SELECT azi04 INTO t_azi04 FROM azi_file  #MOD-560077  #No.CHI-6A0004
#                  WHERE azi01 = g_oob_d[l_ac2].oob07_1
#                  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) #BUG-530346 MOD-560077   #No.CHI-6A0004
#                 RETURNING g_oob_d[l_ac2].oob09_1
#                 LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
#                  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) #BUG-530346 MOD-560077  #No.CHI-6A0004
#                 RETURNING g_oob_d[l_ac2].oob10_1
#              END IF
#              IF g_oob_d[l_ac2].oob09_1 <= 0 THEN
#                 IF g_oob_d[l_ac2].oob04_1 <> '7' THEN
#                    NEXT FIELD oob09_1
#                 END IF
#              END IF
#              #add by danny 020311 期末調匯(A008)
#              IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') OR
#                    (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') THEN
#                    IF NOT t400_oob09_1_13_2('1',p_cmd) THEN
#                       NEXT FIELD oob09_1
#                    END IF
#                 END IF
#              END IF
#           END IF
# 
#        BEFORE FIELD oob10_1
#           LET oob10_t=g_oob_d[l_ac2].oob10_1
# 
#        AFTER FIELD oob10_1
#
#           IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
#              IF g_oob_d_t.oob10_1 != g_oob_d[l_ac2].oob10_1 OR g_oob_d_t.oob10_1 IS NOT NULL THEN
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
#                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
#                     WHERE nmh01 = g_oob_d[l_ac2].oob06_1
#                       AND nmh38 <> 'X'
#                       AND nmh24 != '6' AND nmh24 != '7'         
#                    IF cl_null(l_nmh32) THEN
#                       LET l_nmh32 = 0
#                    END IF
#                    IF g_oob_d[l_ac2].oob10_1 > l_nmh32 THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                    IF NOT t400_oob09_1_11_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
#                    IF NOT t400_oob09_1_12_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
#                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
#                    IF NOT t400_oob09_1_13_2('2',p_cmd) THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t400_oob09_1_19_2('2',p_cmd,'1') THEN   #MOD-750063
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
#                    IF NOT t400_oob09_1_19_2('2',p_cmd,'2') THEN
#                       NEXT FIELD oob10_1
#                    END IF
#                 END IF
#              END IF
#              IF oob10_t <> g_oob_d[l_ac2].oob10_1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
#                 IF cl_confirm('axr-320') THEN
#                    SELECT azi04 INTO t_azi04 FROM azi_file 
#                     WHERE azi01 = g_oob_d[l_ac2].oob07_1
#                    CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
#                         RETURNING g_oob_d[l_ac2].oob10_1
#                    LET g_oob_d[l_ac2].oob09_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob08_1
#                    CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
#                         RETURNING g_oob_d[l_ac2].oob09_1
#                 ELSE
#                    LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
#                 END IF
#              END IF
#              IF g_oob_d[l_ac2].oob08_1 = 1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
#                 LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
#              END IF
#              IF g_oob_d[l_ac2].oob10_1 <= 0 THEN
#                 NEXT FIELD oob10_1
#              END IF
#           END IF
# 
#        AFTER FIELD oob11_1
#          IF g_oob_d[l_ac2].oob11_1 IS NULL THEN NEXT FIELD oob11_1 END IF   
#          LET l_aag05=''   
#          IF NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
#             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1   
#                                                                   AND aag00=g_bookno1           
#             IF STATUS THEN
#                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",1)  
#                NEXT FIELD oob11_1
#             END IF
#             IF l_aag07='1' THEN #統制帳戶
#                CALL cl_err(g_oob_d[l_ac2].oob11_1,'agl-015',0) NEXT FIELD oob11_1
#             END IF
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN
#                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)  
#                                    RETURNING g_errno
#                   END IF
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob11_1
#                END IF
#             ELSE                                  
#                LET g_oob_d[l_ac2].oob13_1=''          
#                DISPLAY BY NAME g_oob_d[l_ac2].oob13_1  
#             END IF
#             CALL t400_set_no_entry_b1_2()   
#             CALL t400_set_entry_b1_2()     
#          END IF
# 
#        AFTER FIELD oob111_1
#          IF g_oob_d[l_ac2].oob111_1 IS NULL THEN NEXT FIELD oob111_1 END IF   
#          IF NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
#             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob111_1   
#                                                                   AND aag00=g_bookno2     
#             IF STATUS THEN
#                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",1)  
#                NEXT FIELD oob111_1
#             END IF
#             IF l_aag07='1' THEN #統制帳戶
#                CALL cl_err(g_oob_d[l_ac2].oob111_1,'agl-015',0) NEXT FIELD oob111_1
#             END IF
# 
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN
#                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)  
#                                    RETURNING g_errno
#                   END IF
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob111_1
#                END IF
#             END IF
#          END IF
# 
#          BEFORE FIELD oob13_1
#            LET l_aag05=''
#            SELECT aag05 INTO l_aag05 FROM aag_file
#             WHERE aag01=g_oob_d[l_ac2].oob11_1
#               AND aag00=g_bookno1          
#            IF l_aag05='N' THEN
#               LET g_oob_d[l_ac2].oob13_1=''
#               DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
#            END IF
#            CALL t400_set_no_entry_b1_2()  
#            CALL t400_set_entry_b1_2()      
# 
#        AFTER FIELD oob13_1
#          IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN
#             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob_d[l_ac2].oob13_1
#                AND gemacti='Y'   #NO:6950
#             IF STATUS THEN
#                CALL cl_err3("sel","gem_file",g_oob_d[l_ac2].oob13_1,"",STATUS,"","select gem",1)  
#                NEXT FIELD oob13_1
#             END IF
#            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
#             LET l_aag05=''   
#             SELECT aag05 INTO l_aag05 FROM aag_file
#              WHERE aag01 = g_oob_d[l_ac2].oob11_1
#                AND aag00 = g_bookno1      
#            
#             LET g_errno = ' '   
#             IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
#               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                IF g_aaz.aaz90 !='Y' THEN    
#                   CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)
#                                 RETURNING g_errno
#                END IF
#                IF NOT cl_null(g_errno) THEN
#                   CALL cl_err('',g_errno,0)
#                   NEXT FIELD oob13_1
#                END IF
#             END IF
#            
#             IF g_aza.aza63='Y' THEN 
#                LET l_aag05=''   
#                SELECT aag05 INTO l_aag05 FROM aag_file
#                 WHERE aag01 = g_oob_d[l_ac2].oob111_1
#                   AND aag00 = g_bookno2      
#                
#                LET g_errno = ' '   
#                IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
#                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
#                   IF g_aaz.aaz90 !='Y' THEN  
#                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)
#                                    RETURNING g_errno
#                   END IF
#                   IF NOT cl_null(g_errno) THEN
#                      CALL cl_err('',g_errno,0)
#                      NEXT FIELD oob13_1
#                   END IF
#                END IF
#             END IF  
#          END IF
#            LET l_aag05=''
#            SELECT aag05 INTO l_aag05 FROM aag_file
#               WHERE aag01=g_oob_d[l_ac2].oob11_1  
#                 AND aag00=g_bookno1        
#            IF l_aag05='Y' AND cl_null(g_oob_d[l_ac2].oob13_1) THEN
#               CALL cl_err('','aap-099',0)
#               NEXT FIELD oob13_1
#            END IF
# 
#        AFTER FIELD oobud01_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud02_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud03_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud04_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud05_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud06_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud07_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud08_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud09_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud10_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud11_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud12_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud13_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud14_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        AFTER FIELD oobud15_1
#           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
# 
#        BEFORE DELETE                            #是否取消單身
#            DISPLAY "g_oob_d_t.oob02_1=",g_oob_d_t.oob02_1
#            IF g_oob_d_t.oob02_1 > 0 AND g_oob_d_t.oob02_1 IS NOT NULL THEN
#                IF NOT cl_delb(0,0) THEN
#                   LET g_success = 'N'   #MOD-730060
#                   CANCEL DELETE
#                END IF
#                IF l_lock_sw = "Y" THEN
#                   CALL cl_err("", -263, 1)
#                   LET g_success = 'N'   #MOD-730060
#                   CANCEL DELETE
#                END IF
#                # genero shell add end
#                DELETE FROM oob_file
#                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
#                IF SQLCA.sqlcode THEN
#                    CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","",1) 
#                    LET g_success = 'N'   
#                    CANCEL DELETE
#                END IF
#                CALL t400_mlog('R')
#                IF g_success = 'Y' THEN
#                   IF g_ooa.ooa34 NOT matches '[Ss]' THEN  
#                      LET l_ooa34 = '0'
#                   END IF                                   
#                   LET g_rec_b2=g_rec_b2-1
#                   DISPLAY g_rec_b2 TO FORMONLY.cn3
#                   IF cl_null(g_oob_d_t.oob02_1) THEN
#                      LET g_rec_b2=g_rec_b2-1
#                   END IF
#                   COMMIT WORK
#                ELSE
#                   ROLLBACK WORK
#                END IF
#            END IF   
#            CALL t400_bu()
# 
#        ON ROW CHANGE
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               CLOSE t400_bcl
#               ROLLBACK WORK
#               EXIT INPUT
#            END IF
#            IF l_lock_sw = 'Y' THEN
#               CALL cl_err(g_oob_d[l_ac2].oob02_1,-263,1)
#               LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               LET g_success='N'  
#            ELSE
#               CALL t400_b_move_back_2()
#               SELECT COUNT(*) INTO l_n FROM oob_file
#                WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
#               IF l_n = 0 THEN                                  
#                  IF g_oob_d[l_ac2].oob09_1 = 0 AND g_oob_d[l_ac2].oob10_1 = 0 THEN
#                     INITIALIZE g_oob_d[l_ac2].* TO NULL  #重要欄位空白,無效
#                     LET g_success='N'   
#                  END IF
#               END IF
#               UPDATE oob_file SET * = b_oob.*
#                  WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
#               IF SQLCA.sqlcode THEN
#                  CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","upd oob",1)  #No.FUN-660116
#                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
#                  LET g_success='N'   
#               ELSE 
#                  UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
#                   WHERE ooa01 = g_ooa.ooa01 
#                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
#                     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
#                     LET g_oob_d[l_ac2].* = g_oob_d_t.*
#                     LET g_success='N'   
#                  END IF
#                  DISPLAY g_user TO ooamodu
#                  DISPLAY g_today TO ooadate
#                END IF
#            END IF
#            CALL t400_mlog('U')
#            CALL t400_bu()
#            IF g_success = 'Y' THEN
#               MESSAGE 'UPDAET O.K'
#               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
#                  LET l_ooa34 = '0'
#               END IF                                  
#               COMMIT WORK
#            ELSE
#               MESSAGE 'UPDATE ERR'
#               ROLLBACK WORK
#            END IF
# 
#        AFTER ROW
#            LET l_ac2 = ARR_CURR()
##           LET l_ac2_t = l_ac2
#            IF INT_FLAG THEN
#               CALL cl_err('',9001,0)
#               LET INT_FLAG = 0
#               IF p_cmd = 'u' THEN
#                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
#               END IF
#               CLOSE t400_bcl
#               ROLLBACK WORK
#               EXIT INPUT              
#            END IF
#            CLOSE t400_bcl
#            COMMIT WORK
# 
#        ON ACTION CONTROLO                        #沿用所有欄位
#            IF INFIELD(oob02_1) AND l_ac2 > 1 THEN
#                LET g_oob_d[l_ac2].* = g_oob_d[l_ac2-1].*
#                LET g_oob_d[l_ac2].oob02_1 = NULL
#                NEXT FIELD oob02_1
#            END IF
#        ON ACTION controls                             
#         CALL cl_set_head_visible("","AUTO")          
# 
#        ON ACTION CONTROLP
#            CASE
#
#                WHEN INFIELD(oob04_1)
#                     CALL cl_init_qry_var()
#                     LET g_qryparam.form = "q_ooc"
#                     LET g_qryparam.default1 = g_oob_d[l_ac2].oob04_1
#                     IF g_aza.aza63 = 'N' THEN     
#                        LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  
#                     END IF         
#                     CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob04_1
#                     DISPLAY BY NAME g_oob_d[l_ac2].oob04_1        
#                     NEXT FIELD oob04_1
#                 
#                 WHEN INFIELD(oob06_1)
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                          CALL cl_init_qry_var()
#                          LET g_qryparam.form = "q_nmh5"
#                          LET g_qryparam.arg1 = g_ooa.ooa03
#                          LET g_qryparam.arg2 = g_doc_len   
#                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
#                          NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
#                          CALL cl_init_qry_var()
#                          LET g_qryparam.form = "q_nmg"
#                          LET g_qryparam.default1 = g_oob_d[l_ac2].oob06_1
#                           LET g_qryparam.arg1 = g_ooa.ooa03   
#                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
#                          NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                         CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
#                                     g_ooa.ooa01,g_ooa.ooa03,'2*')                   
#                              RETURNING b_oob.oob06,b_oob.oob09,       
#                                        b_oob.oob10,b_oob.oob19
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                            LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19   
#                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
#                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                         CALL q_apa4( FALSE, TRUE, ' ')
#                         RETURNING b_oob.oob06
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                         IF g_ooz.ooz62='N' THEN
#                            CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
#                                        g_ooa.ooa01,g_ooa.ooa03,'1*')                  
#                                 RETURNING b_oob.oob06,b_oob.oob09,  
#                                           b_oob.oob10,b_oob.oob19
#                         ELSE
#                            CALL q_omb(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1,
#                                       g_ooa.ooa01, g_ooa.ooa03,'1%') 
#                             RETURNING b_oob.oob06,b_oob.oob15,
#                                       b_oob.oob09,b_oob.oob10
#                         END IF
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
#                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
#                            IF g_ooz.ooz62='Y' THEN
#                               LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
#                            ELSE
#                               LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19
#                            END IF
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
#                         CALL q_apa5( FALSE, TRUE, ' ')
#                              RETURNING b_oob.oob06
#                         IF b_oob.oob06 IS NOT NULL THEN
#                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
#                         END IF
#                         NEXT FIELD oob06_1
#                      END IF
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob06_1     
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob09_1     
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob10_1     
#                       DISPLAY BY NAME g_oob_d[l_ac2].oob15_1     
#               WHEN INFIELD(oob11_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_aag'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
#                    LET g_qryparam.arg1 = g_bookno1     
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
#                    NEXT FIELD oob11_1
#               WHEN INFIELD(oob111_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_aag'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
#                    LET g_qryparam.arg1 = g_bookno2      
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
#                    NEXT FIELD oob111_1
#               WHEN INFIELD(oob13_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form = 'q_gem'
#                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob13_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob13_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
#                    NEXT FIELD oob13_1
#               WHEN INFIELD(oob07_1)
#                    CALL cl_init_qry_var()
#                    LET g_qryparam.form ='q_azi'
#                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob07_1
#                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob07_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
#                    NEXT FIELD oob07_1
#               WHEN INFIELD(oob08_1)
#                    CALL s_rate(g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1)
#                    RETURNING g_oob_d[l_ac2].oob08_1
#                    DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
#                    NEXT FIELD oob08_1
#               OTHERWISE EXIT CASE
#            END CASE
# 
#        ON ACTION CONTROLR
#           CALL cl_show_req_fields()
# 
#        ON ACTION CONTROLG
#           CALL cl_cmdask()
# 
#        ON ACTION receive_notes
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                    CALL cl_cmdrun_wait('anmt200')  
#                 END IF
#        ON ACTION bank_income_expense
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
#                    CALL cl_cmdrun_wait('anmt302')  
#                 END IF
#        ON ACTION maintain_accounts
#                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
#                    CALL cl_cmdrun_wait('axrt300')  
#                 END IF
#                 IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
#                    CALL cl_cmdrun_wait('axrt300')  
#                 END IF
#        ON ACTION ar_account_category
#                    CALL cl_cmdrun('axri040')
# 
#        ON ACTION auto_contra
#           CALL t400_g_b2()
#           EXIT INPUT          
# 
#        ON ACTION CONTROLF
#         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
#         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
# 
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
# 
#      ON ACTION about         
#         CALL cl_about()      
# 
#      ON ACTION help          
#         CALL cl_show_help()  
#  
#      END INPUT
#     #FUN-A90003--Add--End--#
 
     IF g_ooa.ooaconf <> 'Y' THEN            #FUN-640246
        UPDATE ooa_file SET ooa34=l_ooa34 WHERE ooa01 = g_ooa.ooa01
        LET g_ooa.ooa34 = l_ooa34
        DISPLAY BY NAME g_ooa.ooa34
     END IF
     IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
     IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
     CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")

#FUN-A40076-Mark--Begin 
#      IF (g_ooa.ooa23 IS NULL AND g_ooa.ooa32d != g_ooa.ooa32c) OR
#         (g_ooa.ooa23 IS NOT NULL AND
#         (g_ooa.ooa31d != g_ooa.ooa31c OR g_ooa.ooa32d != g_ooa.ooa32c)) THEN
#FUN-A40076-Mark--End
       #No.TQC-B30221  --Begin
       SELECT COUNT(*) INTO l_count1 FROM ooa_file,oob_file 
        WHERE ooa01 = oob01 
          AND ooa01 = g_ooa.ooa01
          AND oob03 = '1'
       SELECT COUNT(*) INTO l_count2 FROM ooa_file,oob_file 
        WHERE ooa01 = oob01 
          AND ooa01 = g_ooa.ooa01
          AND oob03 = '2'   
       #No.TQC-B30221  --End
       #FUN-A40076-Add--Begin
       IF cl_null(g_ooa.ooa33d) THEN
          LET g_ooa.ooa33d = 0
       END IF
       #FUN-A40076-Add-End 
     IF l_count1 <> 0 AND l_count2 <> 0 THEN       #TQC-B30221 add
        IF g_ooa.ooa32d != g_ooa.ooa32c - g_ooa.ooa33d THEN      #FUN-A40076-Add
          #-MOD-B60022-mark-
          #LET p_row = 10 LET p_col = 27
#No.FUN-AA0088 --begin
          #IF g_prog ='axrt400' THEN 
          #   OPEN WINDOW t4001_w AT p_row,p_col WITH FORM "axr/42f/axrt4001"
          #     ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN 
          #   CALL cl_ui_locale("axrt4001") 
#No.FUN-AA0088 --end 
          #   INPUT BY NAME diff_flag
       
          #      AFTER FIELD diff_flag
          #         IF diff_flag NOT MATCHES "[56780E]" THEN NEXT FIELD diff_flag END IF   #FUN-A40076 Mark
          #         IF diff_flag MATCHES '[8]'  AND g_ooa.ooa32d < g_ooa.ooa32c THEN
          #            CALL cl_err('','axr-304',0) NEXT FIELD diff_flag
          #         END IF
          #         IF diff_flag MATCHES "[56]" AND g_ooa.ooa32d > g_ooa.ooa32c THEN
          #            CALL cl_err('','axr-302',0) NEXT FIELD diff_flag
          #         END IF
          #         #FUN-A40076-Add--Begin
          #         IF diff_flag MATCHES '[1]' AND g_ooa.ooa32d > g_ooa.ooa32c THEN
          #            CALL cl_err('','axr-328',0) NEXT FIELD diff_flag
          #         END IF 
          #  
          #     #FUN-A40076-Add--End          
          #      ON IDLE g_idle_seconds
          #         CALL cl_on_idle()
          #         CONTINUE INPUT
          #     
          #      ON ACTION about         #MOD-4C0121
          #         CALL cl_about()      #MOD-4C0121
          #      
          #      ON ACTION help          #MOD-4C0121
          #         CALL cl_show_help()  #MOD-4C0121
          #      
          #      ON ACTION controlg      #MOD-4C0121
          #         CALL cl_cmdask()     #MOD-4C0121
          #   END INPUT
          #END IF    #No.FUN-AA0088
          #IF INT_FLAG THEN LET INT_FLAG=0 LET diff_flag='0' END IF
          #CLOSE WINDOW t4001_w
          #IF diff_flag='0' THEN 
          #   CALL t400_b()
          #-MOD-B60022-end-
           IF g_chkins = 'N' THEN                     #MOD-B60135  
              CALL t400_b2()                  #FUN-A90003 Add  
           END IF #GENERO 再進單身時 #MOD-B60022 mark #MOD-B60135 remark
        END IF
       #-MOD-B60022-mark- 
       #CLOSE t400_bcl
       #COMMIT WORK
       #IF diff_flag MATCHES "[5678]" THEN
       #  #-CHI-A30007-add
       #  #CALL t400_diff()
       #   CALL t400_diff() RETURNING l_flag
       #   IF l_flag = 'Y' THEN
       #      LET diff_flag = '7'
       #      CALL t400_diff() RETURNING l_flag
       #   END IF
       #  #-CHI-A30007-end
       #   CALL t400_b_fill('1=1')         #FOR GENERO BUG調整
       #   CALL t400_b_fill_2('1=1') #FUN-A90003 Add
       #   LET diff_flag='0'               #MOD-A80175 若無此段第二次進入單身會當出
       #END IF  
       ##FUN-A40076-Add--Begin
       #IF diff_flag MATCHES '[1]' THEN
       #   CALL t400_diff1()
       #-MOD-B60022-end- 
           
#          SELECT ooa33d INTO g_ooa.ooa33d
#            FROM ooa_file
#           WHERE ooa01 = g_ooa.ooa01    
#          #FUN-A40076-Add--Begin
#          IF cl_null(g_ooa.ooa33d) THEN
#             LET g_ooa.ooa33d = 0
#          END IF
#          #FUN-A40076-Add-End 
#          DISPLAY BY NAME g_ooa.ooa33d
#          
#          CALL t400_show_amt()   
#          CALL t400_b_fill('1=1')
       #END IF  #MOD-B60022 mark 
        #FUN-A40076-Add--End    
     END IF   #TQC-B30221 add  
# 新增自動確認功能 Modify by Charis 96-09-23
     LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
     SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
     IF STATUS THEN
        RETURN
     END IF
     #-----97/05/26 modify 詢問是否產生分錄底稿
#    IF g_ooa.ooa31d>0 AND g_ooa.ooa31d=g_ooa.ooa31c AND g_ooy.ooydmy1='Y' THEN                 #FUN-A40076 Mark
     #FUN-A40076-Add--Begin
     IF cl_null(g_ooa.ooa33d) THEN
        LET g_ooa.ooa33d = 0
     END IF
     #FUN-A40076-Add-End
    #--------------------MOD-CA0093------------mark
    #IF g_change = 'Y' THEN   #MOD-B60022 
    #   IF g_ooa.ooa32d>0 AND (g_ooa.ooa32d=g_ooa.ooa32c-g_ooa.ooa33d) AND g_ooy.ooydmy1='Y' THEN  #FUN-A40076 Add
    #      IF cl_confirm('axr-309') THEN
    #         CALL t400_v()
    #      END IF
    #   END IF
    #END IF                   #MOD-B60022
    #--------------------MOD-CA0093------------mark
     IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
        THEN RETURN
     ELSE
        LET g_action_choice = "insert"        #FUN-640246
        CALL s_showmsg_init() #CHI-A80031 add
        CALL t400_y_chk()          #CALL 原確認的 check 段
        IF g_success = "Y" THEN
           CALL t400_y_upd()       #CALL 原確認的 update 段
        END IF
        CALL s_showmsg()  #CHI-A80031 add
     END IF
     IF g_ooy.ooyprit='Y' THEN CALL t400_out() END IF   #單據需立即列印
END FUNCTION
 
FUNCTION t400_set_entry_b()
 
    MESSAGE ''
 
    CALL cl_set_comp_entry("oob07,oob08",TRUE)
    CALL cl_set_comp_entry("oob15",TRUE)
 
END FUNCTION
 
FUNCTION t400_set_no_entry_b()
 
    MESSAGE ''
    IF NOT cl_null(g_ooa.ooa23) THEN
       CALL cl_set_comp_entry("oob07",FALSE)
    END IF
    IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[1239]") OR  #FUN-D80031   #No.TQC-DA0003   Remark
   #IF (g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[1239H]") OR #FUN-D80031   #No.TQC-DA0003   Mark
      #(g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[1]") THEN   #MOD-B40033 mark
       (g_oob[l_ac].oob03='2' AND g_oob[l_ac].oob04 MATCHES "[19]") THEN  #MOD-B40033
       CALL cl_set_comp_entry("oob07,oob08",FALSE)
    END IF
    IF INFIELD(oob04) THEN
       IF NOT (g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '2') THEN   #MOD-670042
          IF g_ooz.ooz62 <> 'Y' OR g_oob[l_ac].oob03<>'2' OR
             g_oob[l_ac].oob04<>'1' THEN
             CALL cl_set_comp_entry("oob15",FALSE)
          END IF
       END IF   #MOD-630069
      #若oob04='9'時,oob15預設值為0,無須維護
       IF g_oob[l_ac].oob04 = '9' THEN
          CALL cl_set_comp_entry("oob15",FALSE)
       END IF
       #FUN-D70029--add--str--
       IF g_oob[l_ac].oob04='H' THEN
          CALL cl_set_comp_entry("oob06,oob19,oob15,oob14",FALSE) #FUN-D80031 mark   #No.TQC-DA0003   Remark
          CALL cl_set_comp_entry("oob19,oob15,oob14",FALSE) #FUN-D80031 add          #No.TQC-DA0003   Mark
       END IF
       #FUN-D70029--add--end
    END IF
    IF g_oob[l_ac].oob07=g_aza.aza17 THEN
       CALL cl_set_comp_entry("oob08",FALSE)
       LET g_oob[l_ac].oob08=1.0
       DISPLAY BY NAME g_oob[l_ac].oob08
    END IF
END FUNCTION
 
FUNCTION t400_set_entry_b_1()
   CALL cl_set_comp_entry("oob02,oob03,oob06,oob19,oob15,oob14,oob07,
                           oob08,oob09,oob10,oob12",TRUE)
END FUNCTION
 
FUNCTION t400_set_no_entry_b_1()
 IF g_ooa.ooa34 matches '[Ss]' THEN
   CALL cl_set_comp_entry("oob02,oob03,oob06,oob19,oob15,oob14,oob07, 
                           oob08,oob09,oob10,oob12",FALSE)
 END IF
END FUNCTION
 
FUNCTION t400_set_entry_b1()
    DEFINE l_aag05  LIKE aag_file.aag05   #MOD-920163 add
    DEFINE l_cnt    LIKE type_file.num5   #MOD-CC0090 add
 
    IF g_oob[l_ac].oob03='1' THEN
       IF g_oob[l_ac].oob04='3' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04='4' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04 NOT MATCHES '[349H]' AND   #MOD-8B0210 #FUN-D70029 add 'H'
          NOT(g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='1') THEN  #No.MOD-740406
          CALL cl_set_comp_entry("oob15",TRUE)
       END IF
    END IF
    IF g_oob[l_ac].oob03='2' THEN
       IF g_oob[l_ac].oob04='1' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04='9' THEN
          CALL cl_set_comp_entry("oob19",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15",TRUE)
          END IF
       END IF
       IF g_oob[l_ac].oob04 NOT MATCHES '[19]' THEN
          CALL cl_set_comp_entry("oob15",TRUE)
       END IF
    END IF
 
    LET l_aag05=''
    SELECT aag05 INTO l_aag05 FROM aag_file
     WHERE aag01=g_oob[l_ac].oob11  
       AND aag00=g_bookno1        #No.FUN-730073
    IF l_aag05='Y' THEN
       CALL cl_set_comp_entry("oob13",TRUE)
    END IF
 
   #------------------MOD-CC0090-------------------(S)
    SELECT COUNT(*) INTO l_cnt FROM ooc_file
     WHERE ooc01 = g_oob[l_ac].oob04
    IF l_cnt = 0 THEN
       CALL cl_set_comp_entry("oob06",TRUE)
    END IF
   #------------------MOD-CC0090-------------------(E)

END FUNCTION
 
FUNCTION t400_set_no_entry_b1()
    DEFINE l_cnt    LIKE type_file.num5   #MOD-CC0090 add

    CALL cl_set_comp_entry("oob15,oob19",FALSE)
    CALL cl_set_comp_entry("oob13",FALSE)   #MOD-920163 add
   #------------------MOD-CC0090-------------------(S)
    SELECT COUNT(*) INTO l_cnt FROM ooc_file
     WHERE ooc01 = g_oob[l_ac].oob04
    IF l_cnt > 0 THEN
       CALL cl_set_comp_entry("oob06",FALSE)
    END IF
   #------------------MOD-CC0090-------------------(E)

END FUNCTION
 
FUNCTION t400_set_required_b()
  #IF g_ooz.ooz62='Y' OR                                                                      #No.MOD-B80292 mark
   IF(g_ooz.ooz62='Y' AND g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04 MATCHES "[239]") OR     #No.MOD-B80292 add
     (g_ooz.ooz62='N' AND g_oob[l_ac].oob03='1' AND g_oob[l_ac].oob04='2') THEN
      CALL cl_set_comp_required("oob15",TRUE)
   END IF
END FUNCTION
 
FUNCTION t400_set_no_required_b()
   CALL cl_set_comp_required("oob15",FALSE)
END FUNCTION
 
FUNCTION t400_b_move_to()
   LET g_oob[l_ac].oob02 = b_oob.oob02
   LET g_oob[l_ac].oob03 = b_oob.oob03
   LET g_oob[l_ac].oob04 = b_oob.oob04
   CALL s_oob04(g_oob[l_ac].oob03,g_oob[l_ac].oob04)
                RETURNING g_oob[l_ac].oob04_d
   LET g_oob[l_ac].oob06 = b_oob.oob06
   LET g_oob[l_ac].oob15 = b_oob.oob15
   LET g_oob[l_ac].oob07 = b_oob.oob07
   LET g_oob[l_ac].oob08 = b_oob.oob08
   LET g_oob[l_ac].oob09 = b_oob.oob09
   LET g_oob[l_ac].oob10 = b_oob.oob10
   LET g_oob[l_ac].oob11 = b_oob.oob11
   IF g_aza.aza63='Y' THEN                  #No.FUN-670047 add
      LET g_oob[l_ac].oob111 = b_oob.oob111 #No.FUN-670047 add
   END IF                                   #No.FUN-670047 add
   LET g_oob[l_ac].oob12 = b_oob.oob12
   LET g_oob[l_ac].oob13 = b_oob.oob13
   LET g_oob[l_ac].oob14 = b_oob.oob14
   LET g_oob[l_ac].oobud01 = b_oob.oobud01
   LET g_oob[l_ac].oobud02 = b_oob.oobud02
   LET g_oob[l_ac].oobud03 = b_oob.oobud03
   LET g_oob[l_ac].oobud04 = b_oob.oobud04
   LET g_oob[l_ac].oobud05 = b_oob.oobud05
   LET g_oob[l_ac].oobud06 = b_oob.oobud06
   LET g_oob[l_ac].oobud07 = b_oob.oobud07
   LET g_oob[l_ac].oobud08 = b_oob.oobud08
   LET g_oob[l_ac].oobud09 = b_oob.oobud09
   LET g_oob[l_ac].oobud10 = b_oob.oobud10
   LET g_oob[l_ac].oobud11 = b_oob.oobud11
   LET g_oob[l_ac].oobud12 = b_oob.oobud12
   LET g_oob[l_ac].oobud13 = b_oob.oobud13
   LET g_oob[l_ac].oobud14 = b_oob.oobud14
   LET g_oob[l_ac].oobud15 = b_oob.oobud15
END FUNCTION
 
FUNCTION t400_b_move_back()
   LET b_oob.oob02 = g_oob[l_ac].oob02
   LET b_oob.oob03 = g_oob[l_ac].oob03
   LET b_oob.oob04 = g_oob[l_ac].oob04
   LET b_oob.oob06 = g_oob[l_ac].oob06
   LET b_oob.oob15 = g_oob[l_ac].oob15
   LET b_oob.oob07 = g_oob[l_ac].oob07
   LET b_oob.oob08 = g_oob[l_ac].oob08
   LET b_oob.oob09 = g_oob[l_ac].oob09
   LET b_oob.oob10 = g_oob[l_ac].oob10
   LET b_oob.oob11 = g_oob[l_ac].oob11
   IF g_aza.aza63='Y' THEN                   #No.FUN-670047 add
      LET b_oob.oob111 =  g_oob[l_ac].oob111 #No.FUN-670047 add
   END IF                                    #No.FUN-670047 add
   LET b_oob.oob12 = g_oob[l_ac].oob12
   LET b_oob.oob13 = g_oob[l_ac].oob13
   LET b_oob.oob14 = g_oob[l_ac].oob14
   LET b_oob.oob19 = g_oob[l_ac].oob19       #No.FUN-680022 add
   LET b_oob.oobud01 = g_oob[l_ac].oobud01
   LET b_oob.oobud02 = g_oob[l_ac].oobud02
   LET b_oob.oobud03 = g_oob[l_ac].oobud03
   LET b_oob.oobud04 = g_oob[l_ac].oobud04
   LET b_oob.oobud05 = g_oob[l_ac].oobud05
   LET b_oob.oobud06 = g_oob[l_ac].oobud06
   LET b_oob.oobud07 = g_oob[l_ac].oobud07
   LET b_oob.oobud08 = g_oob[l_ac].oobud08
   LET b_oob.oobud09 = g_oob[l_ac].oobud09
   LET b_oob.oobud10 = g_oob[l_ac].oobud10
   LET b_oob.oobud11 = g_oob[l_ac].oobud11
   LET b_oob.oobud12 = g_oob[l_ac].oobud12
   LET b_oob.oobud13 = g_oob[l_ac].oobud13
   LET b_oob.oobud14 = g_oob[l_ac].oobud14
   LET b_oob.oobud15 = g_oob[l_ac].oobud15
   LET b_oob.ooblegal = g_legal #FUN-980011 add
END FUNCTION
 
FUNCTION t400_acct_code()
   DEFINE l_ool RECORD LIKE ool_file.*
   SELECT * INTO l_ool.* FROM ool_file WHERE ool01=g_ooa.ooa13
   CASE WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '5'
             LET b_oob.oob11 = l_ool.ool54
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool541    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '6'
             LET b_oob.oob11 = l_ool.ool51
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool511    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '7' #AND    #MOD-A50074 mark AND
            #g_oob[l_ac].oob10 > 0      #MOD-A50074 mark
             LET b_oob.oob11 = l_ool.ool52
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool521    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '7'
             LET b_oob.oob11 = l_ool.ool53
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool531    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '8'
             LET b_oob.oob11 = l_ool.ool23
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool231    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        WHEN g_oob[l_ac].oob03 = '2' AND g_oob[l_ac].oob04 = '2'
             LET b_oob.oob11 = l_ool.ool25
             IF g_aza.aza63='Y' THEN               #No.FUN-670047 add
                LET b_oob.oob111 = l_ool.ool251    #No.FUN-670047 add 
             END IF                                #No.FUN-670047 add
        #FUN-D70029--add--str--
        WHEN g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = 'H'
             SELECT ool_file.* INTO l_ool.* FROM ool_file,occ_file
             WHERE ool01=occ67 AND occ01=g_ooa.ooa03
             LET g_oob[l_ac].oob11 = l_ool.ool56
             IF g_aza.aza63='Y' THEN
                LET g_oob[l_ac].oob111 = l_ool.ool561
             END IF
        #FUN-D70029--add--end
        OTHERWISE
           IF b_oob.oob04 != g_oob[l_ac].oob04 THEN
              LET b_oob.oob11 = null
              LET b_oob.oob111= null     #No.FUN-670047 add
           END IF
           LET g_oob[l_ac].oob11 = null
           LET g_oob[l_ac].oob111= null  #No.FUN-670047 add
          
   END CASE
   IF cl_null(g_oob[l_ac].oob11) THEN
      LET g_oob[l_ac].oob11 = b_oob.oob11
      LET g_oob[l_ac].oob111= b_oob.oob111  #No.FUN-670047 add
      DISPLAY BY NAME g_oob[l_ac].oob11
      DISPLAY BY NAME g_oob[l_ac].oob111    #No.FUN-670047 add
   ELSE
      LET b_oob.oob11 =g_oob[l_ac].oob11
      LET b_oob.oob111=g_oob[l_ac].oob111   #No.FUN-670047 add 
   END IF
END FUNCTION
 
FUNCTION t400_oob06()
DEFINE l_nmg  RECORD LIKE nmg_file.*  #MDO-740395
  LET g_errno=' '
  IF g_oob[l_ac].oob03='1' THEN
     IF g_oob[l_ac].oob04='1' THEN CALL t400_oob06_11() END IF
     IF g_oob[l_ac].oob04='3' THEN CALL t400_oob06_13('2') END IF
     IF g_oob[l_ac].oob04='9' THEN CALL t400_oob06_19('1') END IF   #MOD-750063
    #IF g_oob[l_ac].oob04='H' THEN CALL t400_oob06_20() END IF      #FUN-D80031   #No.TQC-DA0003   Mark
  END IF
  IF g_oob[l_ac].oob03='2' THEN
     IF g_oob[l_ac].oob04='1' THEN CALL t400_oob06_13('1') END IF
     IF g_oob[l_ac].oob04='9' THEN CALL t400_oob06_19('2') END IF   #MOD-750063
  END IF
  
  DISPLAY BY NAME g_oob[l_ac].oob07,g_oob[l_ac].oob08,
                  g_oob[l_ac].oob09,g_oob[l_ac].oob10,
                  g_oob[l_ac].oob11,g_oob[l_ac].oob12,
                  g_oob[l_ac].oob13,g_oob[l_ac].oob14   #MOD-8A0009
 
END FUNCTION
 
 
FUNCTION t400_oob09_11(l_sw,l_cmd)                # 借方檢查 : 支票
   DEFINE l_sw      LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd     LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh02   LIKE nmh_file.nmh02
   DEFINE l_nmh32   LIKE nmh_file.nmh32
   DEFINE l_nmydmy3 LIKE nmy_file.nmydmy3
   DEFINE l_oob09,l_oob10 LIKE oob_file.oob09
   DEFINE tot1,tot2,tot3  LIKE oob_file.oob09
   DEFINE l_nmz59         LIKE nmz_file.nmz59
   DEFINE l_sql           LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(500)   #TQC-5A0089
 
   IF g_ooz.ooz04='N' THEN RETURN TRUE END IF
 
   LET l_sql=
   " SELECT nmh02,nmh32,nmydmy3 ",
   "  FROM nmh_file,nmy_file ",
   " WHERE nmh01= '",g_oob[l_ac].oob06,"' AND nmh01[1,",g_doc_len,"]=nmyslip ",
   "   AND nmh38 <> 'X' ",
   "   AND nmh24 != '6' AND nmh24 != '7'"          #MOD-980159 add
   PREPARE nmh_p FROM l_sql
   DECLARE nmh_c CURSOR FOR nmh_p
   OPEN nmh_c
   FETCH nmh_c INTO l_nmh02,l_nmh32,l_nmydmy3
   IF STATUS THEN
      LET l_nmh02 = 0
   END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file   #MOD-810222
    WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '1'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
      AND oob01 = ooa01 AND ooaconf <> 'X'   #MOD-810222
      AND ooa34 <> '9'   #MOD-810222
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
 
   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
   IF l_sw = '1' THEN
         IF (l_oob09+g_oob[l_ac].oob09) > l_nmh02 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
   ELSE
      SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz59 = 'N' THEN    #不做月底重評時, 依原判斷
         IF (l_oob10+g_oob[l_ac].oob10) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('4','1',g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
         IF (tot2+g_oob[l_ac].oob10) > tot3 THEN
            CALL cl_err('','axr-185',1)
            LET g_oob[l_ac].oob10 = tot3 - tot2
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION

#No.TQC-DA0003 ---Mark--- Start
##FUN-D80031--------------- add --------------- begin
#FUNCTION t400_oob09_20(l_sw,l_cmd)  # 檢查
#  DEFINE l_sw           LIKE type_file.chr1
#  DEFINE l_cmd          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
#  DEFINE l_oma          RECORD LIKE oma_file.*
#  DEFINE l_omc          RECORD LIKE omc_file.*
#  DEFINE l_message      LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(70)
#  DEFINE tot1,tot2      LIKE oob_file.oob09
#  DEFINE tot5,tot6      LIKE oob_file.oob09    #No.TQC-670085
#  DEFINE tot7,tot8      LIKE oob_file.oob09    #No.FUN-680022 --add
#  DEFINE l_oob09        LIKE oob_file.oob09
#  DEFINE l_diff         LIKE oob_file.oob10
#  DEFINE l_msg1,l_msg2  LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(40)
#  DEFINE l_omb          RECORD LIKE omb_file.*     #No.MOD-B60058

#  LET tot1 = 0
#  LET tot2 = 0

#  SELECT * INTO l_oma.* FROM oma_file
#   WHERE oma01=g_oob[l_ac].oob06 AND omavoid='N'
#  IF STATUS THEN
#     LET l_oma.oma54t = 0
#     LET l_oma.oma56t = 0
#     LET l_oma.oma55  = 0
#     LET l_oma.oma57  = 0
#     LET l_oma.oma61  = 0    #No.TQC-5C0086
#  END IF

#  IF NOT cl_null(g_oob_t.oob02) THEN
#     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06
#        AND ((oob01 <> g_ooa.ooa01) OR (oob01=g_ooa.ooa01 AND oob02 <> g_oob_t.oob02))      #MOD-950237
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  ELSE
#     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  END IF

#  IF tot1 IS NULL THEN LET tot1=0 END IF   #No.FUN-68002 add
#  IF tot2 IS NULL THEN LET tot2=0 END IF   #No.FUN-68002 add

#  IF NOT cl_null(g_oob_t.oob02) THEN
#     SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06 AND oob15 = g_oob[l_ac].oob15
#        AND ((oob01 <> g_ooa.ooa01) OR(oob01=g_ooa.ooa01 AND  oob02 <> g_oob_t.oob02))      #MOD-950237
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  ELSE
#     SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06 AND oob15 = g_oob[l_ac].oob15
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  END IF
#  IF tot5 IS NULL THEN LET tot5=0 END IF
#  IF tot6 IS NULL THEN LET tot6=0 END IF

#  #待扺或貸方
#  IF NOT cl_null(g_oob_t.oob02) THEN
#     SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06 AND oob19 = g_oob[l_ac].oob19
#        AND ((oob01 <> g_ooa.ooa01) OR (oob01=g_ooa.ooa01 AND oob02 <> g_oob_t.oob02))     #MOD-950237
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  ELSE
#     SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file
#      WHERE oob06 = g_oob[l_ac].oob06 AND oob19 = g_oob[l_ac].oob19
#        AND oob01 = ooa01 AND ooaconf = 'N'
#        AND oob03 = g_oob[l_ac].oob03
#        AND oob04 = g_oob[l_ac].oob04
#  END IF
#  IF tot7 IS NULL THEN LET tot7=0 END IF
#  IF tot8 IS NULL THEN LET tot8=0 END IF

#  SELECT * INTO l_omc.* FROM omc_file
#   WHERE omc01=g_oob[l_ac].oob06 AND omc02=g_oob[l_ac].oob19
#  IF SQLCA.sqlcode THEN
#    #No.FUN-D20041 ---Add--- Start
#     IF g_bgerr THEN
#        CALL s_errmsg('sel','omc_file',g_oob[l_ac].oob06,SQLCA.sqlcode,1)
#     ELSE
#    #No.FUN-D20041 ---Add--- End
#        CALL cl_err3("sel","omc_file",g_oob[l_ac].oob06,g_oob[l_ac].oob19,SQLCA.sqlcode,"","select omc_file",1)
#     END IF   #No.FUN-D20041   Add
#  END IF

#  IF tot1 IS NULL THEN LET tot1 = 0 END IF
#  IF tot2 IS NULL THEN LET tot2 = 0 END IF

#  IF l_sw = '1' THEN
#        IF (tot7+g_oob[l_ac].oob09) > (l_omc.omc08 - l_omc.omc10) THEN
#           IF g_bgerr THEN
#              CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-185',1)
#           ELSE
#              CALL cl_err('','axr-185',1)
#           END IF   #No.FUN-D20041   Add
#           LET g_oob[l_ac].oob09=g_oob_t.oob09
#           DISPLAY g_oob[l_ac].oob09 TO oob09
#           RETURN FALSE
#        END IF
#  ELSE
#     IF g_ooz.ooz07 = 'N' OR g_oob[l_ac].oob07 = g_aza.aza17 THEN
#           IF (tot8+g_oob[l_ac].oob10) > (l_omc.omc09  - l_omc.omc11) THEN  #No.FUN-680022 --add
#              IF g_bgerr THEN
#                 CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-185',1)
#              ELSE
#                 CALL cl_err('','axr-185',1)
#              END IF   #No.FUN-D20041   Add
#              LET g_oob[l_ac].oob10=g_oob_t.oob10     #No.FUN-680022
#              DISPLAY g_oob[l_ac].oob10 TO oob10      #No.FUN-680022
#              RETURN FALSE
#           END IF
#          #原幣沖完但本幣未沖完
#           IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
#              (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11) THEN
#              IF g_bgerr THEN
#                 CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-193',1)
#              ELSE
#             #No.FUN-D20041 ---Add--- End
#                 CALL cl_err('','axr-193',1)
#              END IF   #No.FUN-D20041   Add
#              RETURN FALSE                    #MOD-BB0208 add
#           END IF
#     END IF
#     #判斷本幣金額是否超過
#     IF g_ooz.ooz07 = 'Y' THEN   #有做月底重評時, 需判斷不可超過未沖金額
#           IF g_ooz.ooz62 ='Y' THEN
#              CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
#           ELSE
#              CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net
#           END IF
#           IF cl_null(g_net) THEN LET g_net =0 END IF
#           IF (tot8+g_oob[l_ac].oob10) > l_omc.omc13-g_net  THEN
#              IF g_bgerr THEN
#                 CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-185',1)
#              ELSE
#                 CALL cl_err('','axr-185',1)
#              END IF   #No.FUN-D20041   Add
#              LET g_oob[l_ac].oob10 = l_omc.omc13 - tot8 #No.FUN-680022 --add
#              DISPLAY g_oob[l_ac].oob10 TO oob10         #No.FUN-680022 --add
#              RETURN FALSE
#           END IF
#          #原幣沖完但本幣未沖完
#           IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
#              (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11) THEN   #MOD-A80247 Mark
#              (tot8+g_oob[l_ac].oob10)!= l_omc.omc13 THEN                    #MOD-A80247 Add
#             #No.FUN-D20041 ---Add--- Start
#              IF g_bgerr THEN
#                 CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-193',1)
#              ELSE
#             #No.FUN-D20041 ---Add--- End
#                 CALL cl_err('','axr-193',1)
#              END IF   #No.FUN-D20041   Add
#              RETURN FALSE                    #MOD-BB0208 add
#           END IF
#     END IF
#  END IF

#  RETURN TRUE
#END FUNCTION
##FUN-D80031 -------------- add ------------- end
#No.TQC-DA0003 ---Mark--- End

 
FUNCTION t400_oob09_12(l_sw,l_cmd)                # 借方檢查 : TT
   DEFINE l_sw    LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd   LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_nmh02,l_nmh32 LIKE nmh_file.nmh02
   DEFINE l_oob09,l_oob10 LIKE oob_file.oob09
   DEFINE l_nmz20         LIKE nmz_file.nmz20
 
   SELECT SUM(npk08),SUM(npk09) INTO l_nmh02,l_nmh32 FROM nmg_file,npk_file
    WHERE nmg00=npk00 AND nmg00= g_oob[l_ac].oob06
      AND npk01=g_oob[l_ac].oob15   #MOD-630069
      AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
      AND nmgconf <> 'X'
 
   IF cl_null(l_nmh02) THEN LET l_nmh02 = 0 LET l_nmh32 = 0 END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file   #MOD-850229 add 串ooa_file
    WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '2'
      AND oob01 = ooa01 AND ooaconf <> 'X'   #MOD-850229 add
      AND oob01 <> g_ooa.ooa01    #MOD-630069
      AND oob15 = g_oob[l_ac].oob15   #MOD-630069
 
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
 
   IF l_sw = '1' THEN
      IF (l_oob09+g_oob[l_ac].oob09) > l_nmh02 THEN
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz20 = 'N' THEN      #不做月底重評時, 依原判斷
         IF (l_oob10+g_oob[l_ac].oob10) > l_nmh32 THEN
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('3','2',g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
          IF g_oob[l_ac].oob10 > tot3 THEN               #MOD-940355
            CALL cl_err('','axr-185',1)
            LET g_oob[l_ac].oob10 = tot3 - tot2         #No.MOD-830186 mark
            LET g_oob[l_ac].oob10 = tot3 - l_oob10      #No.MOD-830186
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob09_13(l_sw,l_cmd)  # 檢查 :3:取待抵 1:取應收
   DEFINE l_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omc          RECORD LIKE omc_file.*
   DEFINE l_message      LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(70)
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE tot5,tot6      LIKE oob_file.oob09    #No.TQC-670085
   DEFINE tot7,tot8      LIKE oob_file.oob09    #No.FUN-680022 --add
   DEFINE l_oob09        LIKE oob_file.oob09
   DEFINE l_diff         LIKE oob_file.oob10
   DEFINE l_msg1,l_msg2  LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(40)
   DEFINE l_omb          RECORD LIKE omb_file.*     #No.MOD-B60058
 
   LET tot1 = 0
   LET tot2 = 0
 
   SELECT * INTO l_oma.* FROM oma_file
    WHERE oma01=g_oob[l_ac].oob06 AND omavoid='N'
   IF STATUS THEN
      LET l_oma.oma54t = 0
      LET l_oma.oma56t = 0
      LET l_oma.oma55  = 0
      LET l_oma.oma57  = 0
      LET l_oma.oma61  = 0    #No.TQC-5C0086
   END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot1 IS NULL THEN LET tot1=0 END IF   #No.FUN-68002 add
   IF tot2 IS NULL THEN LET tot2=0 END IF   #No.FUN-68002 add
 
   SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06 AND oob15 = g_oob[l_ac].oob15
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot5 IS NULL THEN LET tot5=0 END IF
   IF tot6 IS NULL THEN LET tot6=0 END IF
 
   #待扺或貸方
   SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06 AND oob19 = g_oob[l_ac].oob19
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot7 IS NULL THEN LET tot7=0 END IF
   IF tot8 IS NULL THEN LET tot8=0 END IF
 
   SELECT * INTO l_omc.* FROM omc_file
    WHERE omc01=g_oob[l_ac].oob06 AND omc02=g_oob[l_ac].oob19
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","omc_file",g_oob[l_ac].oob06,g_oob[l_ac].oob19,SQLCA.sqlcode,"","select omc_file",1)
   END IF

   IF tot1 IS NULL THEN LET tot1 = 0 END IF
   IF tot2 IS NULL THEN LET tot2 = 0 END IF
 
   IF l_sw = '1' THEN
      IF g_ooz.ooz62 = 'Y' THEN #衝帳至項次   #No.FUN-680022 --add
#No.MOD-B60058 --begin 
         SELECT * INTO l_omb.* FROM omb_file WHERE omb01 = l_oma.oma01 AND omb03 = g_oob[l_ac].oob15
#        IF (tot1+g_oob[l_ac].oob09) > (l_oma.oma54t - l_oma.oma55) THEN
         IF (tot5+g_oob[l_ac].oob09) > (l_omb.omb14t - l_omb.omb34) THEN
#No.MOD-B60058 --end 
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
         IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
#No.MOD-B60058 --begin
#           IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t - l_oma.oma55) THEN
            IF (tot5+g_oob[l_ac].oob09) = (l_omb.omb14t - l_omb.omb34) THEN
#No.MOD-B60058 --end
              IF g_ooz.ooz62 = 'Y' THEN
                 CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
                      RETURNING tot3                  # MOD-530302
                 #判斷本幣金額是否超過
#                IF (tot5+g_oob[l_ac].oob09) > tot3 THEN
                 IF (tot6+g_oob[l_ac].oob09) > tot3 THEN   #No.MOD-B60257
                    CALL cl_err('','axr-189',1)   #CHI-810010
                    LET g_oob[l_ac].oob10 = tot3 - tot2
                 END IF
              END IF
            END IF
         END IF
      ELSE    #不衝賬至項次
         IF (tot7+g_oob[l_ac].oob09) > (l_omc.omc08 - l_omc.omc10) THEN
            CALL cl_err('','axr-185',1) 
            LET g_oob[l_ac].oob09=g_oob_t.oob09
            DISPLAY g_oob[l_ac].oob09 TO oob09
            RETURN FALSE
         END IF
      END IF
   ELSE
      IF g_ooz.ooz07 = 'N' OR g_oob[l_ac].oob07 = g_aza.aza17 THEN
            IF (tot8+g_oob[l_ac].oob10) > (l_omc.omc09  - l_omc.omc11) THEN  #No.FUN-680022 --add
               CALL cl_err('','axr-185',1) 
               LET g_oob[l_ac].oob10=g_oob_t.oob10     #No.FUN-680022     
               DISPLAY g_oob[l_ac].oob10 TO oob10      #No.FUN-680022 
               RETURN FALSE
            END IF
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11) THEN
               CALL cl_err('','axr-193',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
         #(怕因匯差問題)
         IF g_aza.aza17 != g_oob[l_ac].oob07 THEN
            LET l_diff= (l_omc.omc09  - l_omc.omc11)- (tot8+g_oob[l_ac].oob10)  #No.FUN-680022 --add
            IF l_diff <=3 AND l_diff >0 THEN
               CALL cl_getmsg('mfg-030',g_lang) RETURNING l_msg1
               CALL cl_getmsg('mfg-031',g_lang) RETURNING l_msg2
               LET g_msg=l_msg1 CLIPPED,l_omc.omc09  USING '#######&',  #No.FUN-680022 --add
                         " ",l_msg2 CLIPPED,
                        (l_omc.omc11+tot8+g_oob[l_ac].oob10) USING '#######&'  #No.FUN-680022 --add
               CALL cl_err(g_msg,'mfg-012',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
         END IF
      END IF
      #判斷本幣金額是否超過
      IF g_ooz.ooz07 = 'Y' THEN   #有做月底重評時, 需判斷不可超過未沖金額
#No.FUN-AB0034 --begin
            IF g_ooz.ooz62 ='Y' THEN
               CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
            ELSE
               CALL s_ar_oox03_1(l_omc.omc01,l_omc.omc02) RETURNING g_net
            END IF
            IF cl_null(g_net) THEN LET g_net =0 END IF
            IF (tot8+g_oob[l_ac].oob10) > l_omc.omc13-g_net  THEN 
#No.FUN-AB0034 --end
               CALL cl_err('','axr-185',1)
               LET g_oob[l_ac].oob10 = l_omc.omc13 - tot8 #No.FUN-680022 --add
               DISPLAY g_oob[l_ac].oob10 TO oob10         #No.FUN-680022 --add  
               RETURN FALSE
            END IF
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob[l_ac].oob09) = (l_oma.oma54t-l_oma.oma55)   AND
#              (tot8+g_oob[l_ac].oob10)!= (l_omc.omc09  - l_omc.omc11) THEN   #MOD-A80247 Mark
               (tot8+g_oob[l_ac].oob10)!= l_omc.omc13 THEN                    #MOD-A80247 Add 
               CALL cl_err('','axr-193',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob09_19(l_sw,l_cmd,l_sw2)           # 借/貸方檢查 : A/P   #MOD-750063
   DEFINE l_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_cmd          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
   DEFINE l_apa          RECORD LIKE apa_file.*
   DEFINE l_apc          RECORD LIKE apc_file.*   #MOD-750063
   DEFINE p05,p05f       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_oob09,l_oob10        LIKE oob_file.oob09
   DEFINE l_apz27        LIKE apz_file.apz27
   DEFINE l_sw2          LIKE type_file.chr1   #MOD-750063
   DEFINE l_amt16      LIKE type_file.num20_6     #No.MOD-BB0016
 
   SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file
     WHERE apa01=g_oob[l_ac].oob06
       AND apa01=apc01 
       AND apc02=g_oob[l_ac].oob19  
       AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
   IF STATUS THEN
      LET l_apc.apc10 = 0
      LET l_apc.apc11  = 0
   END IF
 
   LET p05f = 0 LET p05 = 0
 
   IF l_sw2 = '1' THEN
      SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05 FROM apg_file,apf_file
       WHERE apg04=g_oob[l_ac].oob06              ## 尚未確認也視同已付,須扣除
         AND apg06=g_oob[l_ac].oob19
         AND apg01=apf01 AND apf41='N' AND apg01 <> g_ooa.ooa01
   ELSE
      SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05 FROM aph_file,apf_file
       WHERE aph04=g_oob[l_ac].oob06              ## 尚未確認也視同已付,須扣除
         AND aph17=g_oob[l_ac].oob19
         AND aph01=apf01 AND apf41='N' AND aph01 <> g_ooa.ooa01
   END IF
 
   IF p05f IS NULL THEN LET p05f=0 END IF
   IF p05  IS NULL THEN LET p05 =0 END IF
 
   LET l_apc.apc10=l_apc.apc10+p05f
   LET l_apc.apc11=l_apc.apc11+p05
 
   IF l_sw2 = '1' THEN
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
       WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '1' AND oob04 = '9'
         AND oob19 = g_oob[l_ac].oob19
         AND oob01 = ooa01 AND ooaconf = 'N'     #1999/12/21 modify  #MOD-850229 mark  #MOD-8B0210 mark回復
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
   ELSE
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM ooa_file,oob_file
       WHERE oob06 = g_oob[l_ac].oob06 AND oob03 = '2' AND oob04 = '9'
         AND oob19 = g_oob[l_ac].oob19
         AND oob01 = ooa01 AND ooaconf = 'N'     #1999/12/21 modify  #MOD-850229 mark  #MOD-8B0210 mark回復
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)        #MOD-950237
   END IF
   IF STATUS OR l_oob09 IS NULL THEN
      LET l_oob09 = 0
      LET l_oob10 = 0
   END IF
   IF l_sw = '1' THEN
     #IF g_oob[l_ac].oob09 > (l_apc.apc08-l_apc.apc10) THEN   #MOD-750063             #MOD-880177  #MOD-BB0016 mark
      IF g_oob[l_ac].oob09 > (l_apc.apc08-l_apc.apc10-l_apc.apc16) THEN   #MOD-750063 #MOD-880177  #MOD-BB0016 mod
         LET g_oob[l_ac].oob09 = l_apc.apc08-l_apc.apc10-l_apc.apc16-p05f-l_oob09   #MOD-BB0016 add
         DISPLAY BY NAME g_oob[l_ac].oob09                                          #MOD-BB0016 add
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'   #MOD-750063
      #判斷本幣金額是否超過
      IF l_apz27 = 'N' THEN      #不做月底重評時, 依原判斷
         LET l_amt16 = l_apc.apc16*l_apc.apc06               #MOD-BB0016 add
         CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16   #MOD-BB0016 add
        #IF g_oob[l_ac].oob10 > (l_apc.apc09-l_apc.apc11) THEN           #MOD-750063  #MOD-880177     #MOD-BB0016 mark
         IF g_oob[l_ac].oob10 > (l_apc.apc09-l_apc.apc11-l_amt16) THEN   #MOD-BB0016 mod
            CALL cl_err('','axr-185',1) RETURN FALSE
            LET g_oob[l_ac].oob10 = l_apc.apc09-l_apc.apc11-l_amt16-p05-l_oob10   #MOD-BB0016 add
            DISPLAY BY NAME g_oob[l_ac].oob10                                     #MOD-BB0016 add
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         LET l_amt16 = l_apc.apc16*l_apc.apc07               #MOD-BB0016 add
         CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16   #MOD-BB0016 add
         CALL s_g_np('2',l_apa.apa00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
              RETURNING tot3
        #IF (l_oob10+g_oob[l_ac].oob10) > tot3 - p05 THEN  #MOD-750063            #MOD-BB0016 mark
         IF (l_oob10+g_oob[l_ac].oob10) > tot3 - p05 - l_amt16 THEN  #MOD-750063  #MOD-BB0016 mod
            CALL cl_err('','axr-185',1)
           #LET g_oob[l_ac].oob10 = tot3 - p05 - l_oob10   #MOD-750063            #MOD-BB0016 mark
            LET g_oob[l_ac].oob10 = tot3 - l_amt16 - p05 - l_oob10                #MOD-BB0016 add 
            DISPLAY BY NAME g_oob[l_ac].oob10
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob06_11()            # 借方檢查 : 支票
  DEFINE l_nmh            RECORD LIKE nmh_file.*
  DEFINE l_nmydmy3             LIKE nmy_file.nmydmy3
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_sql          LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(500)   #TQC-5A0089
  DEFINE l_aag05        LIKE aag_file.aag05   #MOD-730022
  DEFINE l_bookno       LIKE aag_file.aag00   #No.FUN-740184
 
  IF g_ooz.ooz04='N' THEN RETURN END IF
  #No.+093 010427 by plum #若收票單別其拋轉傳票為Y,不可用來沖AR
  LET l_sql="SELECT nmh_file.*,nmydmy3 FROM nmh_file,nmy_file ",
            " WHERE nmh01= '",g_oob[l_ac].oob06,"'",
            "   AND nmh01[1,",g_doc_len,"]=nmyslip"
   PREPARE nmh_p2 FROM l_sql
   DECLARE nmh_c2 CURSOR FOR nmh_p2
   OPEN nmh_c2
   FETCH nmh_c2 INTO l_nmh.*,l_nmydmy3
   IF STATUS THEN CALL cl_err('sel nmh',STATUS,1) LET g_errno='N' END IF
 
  #CALL s_get_bookno(YEAR(l_nmh.nmh04)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
   IF g_flag='1' THEN
      CALL cl_err(l_nmh.nmh04,'aoo-081',1)
   END IF
   #IF l_nmh.nmh24='5' OR l_nmh.nmh24='6' OR l_nmh.nmh24='7' THEN   #TQC-C20416 add '5' 
   IF l_nmh.nmh24='6' OR l_nmh.nmh24='7' THEN   #TQC-C30134 
      CALL cl_err('','axr-115',0)
      LET g_errno = 'N'
      RETURN
   END IF
 
   IF l_nmydmy3='Y' THEN
      LET g_oob[l_ac].oob11 = l_nmh.nmh27
      DISPLAY BY NAME g_oob[l_ac].oob11
      LET g_oob[l_ac].oob111= l_nmh.nmh271    #No.FUN-670047 add
      DISPLAY BY NAME g_oob[l_ac].oob111      #No.FUN-670047 add
   ELSE  
      LET g_oob[l_ac].oob11 = l_nmh.nmh26   
      DISPLAY BY NAME g_oob[l_ac].oob11   
      LET g_oob[l_ac].oob111 = l_nmh.nmh261   
      DISPLAY BY NAME g_oob[l_ac].oob111   
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
           RETURNING l_bookno,g_oob[l_ac].oob11
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
           RETURNING l_bookno,g_oob[l_ac].oob111
   END IF
   IF l_nmh.nmh38 = 'N' THEN
      CALL cl_err(g_oob[l_ac].oob06,'axr-194',0) LET g_errno='N' RETURN
   END IF
   IF l_nmh.nmh38 = 'X' THEN
      CALL cl_err(g_oob[l_ac].oob06,'9024',0) LET g_errno = 'N' RETURN
   END IF
 
   #須考慮未確認沖帳資料
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237 
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  IF l_nmh.nmh11!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh30!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh03!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_nmh.nmh17>=l_nmh.nmh02 THEN
     CALL cl_err('','axr-185',1) LET g_errno='N' END IF
  #95/12/14 by danny 判斷此參考單號之單據是否已確認
  IF l_nmh.nmh38 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  LET g_oob[l_ac].oob07=l_nmh.nmh03
  LET g_oob[l_ac].oob08=l_nmh.nmh32/l_nmh.nmh02
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
  LET g_oob[l_ac].oob09=l_nmh.nmh02-l_nmh.nmh17
  LET g_oob[l_ac].oob09=l_nmh.nmh02-l_nmh.nmh17-tot1
  LET g_oob[l_ac].oob10=g_oob[l_ac].oob09*g_oob[l_ac].oob08
 
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
 #-MOD-B10083-add-
  IF l_nmz59 = 'Y' THEN      
     LET b_oob.oob08 = l_nmh.nmh39 
  ELSE                                
     LET b_oob.oob08 = l_nmh.nmh28     
  END IF 	                          
 #-MOD-B10083-end-
  IF l_nmz59 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
    #-MOD-B10083-mark-
    #IF g_apz.apz27 = 'Y' THEN                       #MOD-940277
    #   LET g_oob[l_ac].oob08 = l_nmh.nmh39
    #ELSE                                            #MOD-940277
    #	  LET g_oob[l_ac].oob08 = l_nmh.nmh28          #MOD-940277
    #END IF                                          #MOD-940277	     
    #-MOD-B10083-end-
     IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
        LET g_oob[l_ac].oob08 = l_nmh.nmh28
     END IF
     CALL s_g_np('4','1',g_oob[l_ac].oob06,g_oob[l_ac].oob15) RETURNING tot3
     IF (g_oob[l_ac].oob09+tot1+l_nmh.nmh17) = l_nmh.nmh02 THEN
        LET g_oob[l_ac].oob10 = tot3 - tot2
     END IF
  END IF
 
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09  #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10  #No.CHI-6A0004
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1       #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_nmh.nmh15
  ELSE
     LET g_oob[l_ac].oob13=''
  END IF
  LET g_oob[l_ac].oob14=l_nmh.nmh31
  LET g_oob[l_ac].oob12=l_nmh.nmh18   #MOD-780261
END FUNCTION
 
FUNCTION t400_oob06_12()            # 借方檢查 : TT
  DEFINE l_nmg           RECORD LIKE nmg_file.*
  DEFINE l_npk           RECORD LIKE npk_file.*
  DEFINE l_cnt           LIKE type_file.num5        #No.FUN-680123 SMALLINT
  DEFINE l_sql           LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(300)
  DEFINE l_nmz20         LIKE nmz_file.nmz20
  DEFINE tot1,tot2,tot3  LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_aag05         LIKE aag_file.aag05        #MOD-730022
  DEFINE l_bookno        LIKE aag_file.aag00        #No.FUN-740184
  DEFINE l_gem10         LIKE gem_file.gem10        #MOD-910107 add
 
   IF g_ooz.ooz04='N' THEN RETURN END IF
 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob[l_ac].oob06
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 ='Y')    #NO:4181
  IF NOT STATUS AND g_oob[l_ac].oob04<>'3' THEN  
     CALL cl_err('','axr-202',0)  #MOD-740395
     LET g_errno='N' 
     RETURN  #MOD-740395
  END IF 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob[l_ac].oob06
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 !='Y')    #NO:4181
  IF STATUS  THEN                                  #TQC-750177
     CALL cl_err('sel nmg',STATUS,0)  
     LET g_errno='N' 
     RETURN  
  END IF 
 
  #CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
   IF g_flag='1' THEN
      CALL cl_err(l_nmg.nmg01,'aoo-081',1)
   END IF
   IF l_nmg.nmgconf='N' THEN 
      CALL cl_err('','axr-194',0) 
      LET g_errno='N' 
      RETURN  #MOD-740395
   END IF
   IF l_nmg.nmgconf='X' THEN 
      CALL cl_err('','9024',0) 
      LET g_errno='N' 
      RETURN  #MOD-740395
   END IF
   IF l_nmg.nmg18 !=g_ooa.ooa03 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          #No.MOD-510070
   IF l_nmg.nmg19 !=g_ooa.ooa032 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          #No.MOD-510070
   IF l_nmg.nmg23-l_nmg.nmg24 = 0 THEN
      CALL cl_err('','axr-184',1) 
      LET g_errno='N' 
      RETURN 
   END IF
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf != 'X'   #No.MOD-980216 mod
      AND oob01 <> g_ooa.ooa01    #MOD-630069
      AND oob15 = g_oob[l_ac].oob15   #MOD-630069
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                             AND aag00=g_bookno1    #	No.FUN-730073             
   IF l_aag05 = 'Y' THEN
      LET l_gem10=s_costcenter(l_nmg.nmg11)
      IF NOT cl_null(l_gem10) THEN
         LET g_oob[l_ac].oob13=l_gem10
      ELSE
         LET g_oob[l_ac].oob13=l_nmg.nmg11
      END IF   #MOD-910107 add
   ELSE
      LET g_oob[l_ac].oob13=''
   END IF
   #---->為防止收支單輸入兩筆單身
   LET l_sql = "SELECT npk_file.* FROM npk_file ",
               " WHERE npk00= '",g_oob[l_ac].oob06,"'",
               "       AND npk01 ='",g_oob[l_ac].oob15,"'"   #MOD-630069
   PREPARE t400_oob06_npk FROM l_sql
   DECLARE t400_oob06_npk_c1 CURSOR FOR t400_oob06_npk
   FOREACH t400_oob06_npk_c1 INTO l_npk.*
     IF SQLCA.sqlcode THEN
        CALL cl_err('t400_oob06_npk_c1',SQLCA.sqlcode,0)
        LET g_errno = 'N' EXIT FOREACH
     END IF
     IF l_npk.npk05!=g_ooa.ooa23 THEN    #幣別與沖帳不一致
        CALL cl_err('','axr-144',1) LET g_errno='N' EXIT FOREACH
     END IF
     LET g_oob[l_ac].oob07=l_npk.npk05   #幣別
     LET g_oob[l_ac].oob08=l_npk.npk06   #匯率
#No.FUN-AA0088 --begin
     SELECT sum(oob09) INTO l_nmg.nmg24 FROM oob_file,ooa_file
      WHERE oob06=l_npk.npk00
        AND oob01=ooa01 AND ooaconf='Y'
        AND oob15=l_npk.npk01 
        AND oob03='1'
        AND oob04='2'
        IF cl_null(l_nmg.nmg24) THEN LET l_nmg.nmg24 =0 END IF
#No.FUN-AA0088 --end
     LET g_oob[l_ac].oob09=l_npk.npk08 - tot1   #原幣入帳金額               #No.MOD-980216 mod
     LET g_oob[l_ac].oob10=l_npk.npk09 - tot2  #本幣入帳金額                          #No.MOD-980216 mod
     SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
     CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
     CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10      #No.CHI-6A0004
     IF l_nmg.nmg29='Y' THEN
        LET g_oob[l_ac].oob11=l_npk.npk071  #科目編號        
        IF g_aza.aza63='Y' THEN                                #No.FUN-670047 add
           LET g_oob[l_ac].oob111=l_npk.npk073  #科目二編號   #No.FUN-670047 add
        END IF                                                #No.FUN-670047 add
     ELSE
        LET g_oob[l_ac].oob11=l_npk.npk07   #科目編號
        IF g_aza.aza63='Y' THEN                               #No.FUN-670047 add
           LET g_oob[l_ac].oob111=l_npk.npk072  #科目二編號   #No.FUN-670047 add
        END IF                                                #No.FUN-670047 add
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
             RETURNING l_bookno,g_oob[l_ac].oob11
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
             RETURNING l_bookno,g_oob[l_ac].oob111
     END IF
     SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
    #-MOD-B10083-add-
     IF l_nmz20 = 'Y' THEN      
        LET b_oob.oob08 = l_nmg.nmg09
     ELSE                                
        LET b_oob.oob08 = l_npk.npk06  
     END IF 	                          
    #-MOD-B10083-end-
     IF l_nmz20 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
       #-MOD-B10083-mark-
       #IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
       #   LET g_oob[l_ac].oob08 = l_nmg.nmg09
       #ELSE                                       #MOD-940277
       #	 LET g_oob[l_ac].oob08 = l_npk.npk06     #MOD-940277
       #END IF                                     #MOD-940277     	    
       #-MOD-B10083-end-
        IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
           LET g_oob[l_ac].oob08 = l_npk.npk06
        END IF
        CALL s_g_np('3','2',g_oob[l_ac].oob06,g_oob[l_ac].oob15) RETURNING tot3
        IF (tot1+g_oob[l_ac].oob09) = l_nmg.nmg23 THEN   #No.MOD-980216 mod
            LET g_oob[l_ac].oob10 = tot3 - tot2
        END IF
     END IF
     LET g_oob[l_ac].oob12=l_npk.npk10   #MOD-780261
     EXIT FOREACH
  END FOREACH
END FUNCTION
 
FUNCTION t400_oob06_item()      # 檢查待抵/應收帳款
   DEFINE p_sw           LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)                  # 2:取待抵 1:取應收
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omb          RECORD LIKE omb_file.*
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE l_omb14t       LIKE omb_file.omb14t   #CHI-840051
   DEFINE l_omb16t       LIKE omb_file.omb16t   #CHI-840051
   DEFINE l_oea61        LIKE oea_file.oea61    #No:FUN-A50103
   DEFINE l_oea1008      LIKE oea_file.oea1008  #No:FUN-A50103
   DEFINE l_per          LIKE oea_file.oea261   #No:FUN-A50103
 
  #-MOD-B70102-add-
   IF g_oob[l_ac].oob03 = '1' AND g_oob[l_ac].oob04 = '3' THEN 
   ELSE
      RETURN
   END IF
  #-MOD-B70102-end-

   #LET g_sql="SELECT * FROM ",g_dbs_new CLIPPED,"oma_file WHERE oma01=?"
   #LET g_sql="SELECT * FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
   LET g_sql="SELECT * FROM oma_file ", #FUN-A50102
             " WHERE oma01=?"
   #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
   #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
   PREPARE t400_oob06_item_p1 FROM g_sql
   DECLARE t400_oob06_item_c1 CURSOR FOR t400_oob06_item_p1
   OPEN t400_oob06_item_c1 USING g_oob[l_ac].oob06
   FETCH t400_oob06_item_c1 INTO l_oma.*
   IF STATUS THEN CALL cl_err('sel oma',STATUS,1) LET g_errno='N' END IF
   IF l_oma.omavoid = 'Y' THEN
      CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
   END IF
   IF l_oma.omaconf='N' THEN
      CALL cl_err('','axr-194',1) LET g_errno='N'
   END IF
   LET tot1 = 0
   LET tot2 = 0
   SELECT * INTO l_omb.* FROM omb_file
    WHERE omb01 = g_oob[l_ac].oob06 AND omb03 = g_oob[l_ac].oob15
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob15 = g_oob[l_ac].oob15
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)      #MOD-950237
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF

   #-----No:FUN-A50103-----
   IF l_oma.oma00='11' OR l_oma.oma00='12' OR l_oma.oma00='13' THEN
      CASE l_oma.oma00
        WHEN 11
           SELECT oea61,oea1008,oea261
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
        WHEN 12
           SELECT oea61,oea1008,oea262
             INTO l_oea61,l_oea1008,l_per 
             FROM oga_file,oea_file
            WHERE oga01 = l_oma.oma16
             AND oga16 = oea01
        WHEN 13
           SELECT oea61,oea1008,oea263
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
      END CASE

      #-----No:CHI-A70015-----
      IF cl_null(l_per) THEN
         LET l_per = 100
      END IF

      IF cl_null(l_oea1008) THEN
         LET l_oea1008 = 100
      END IF

      IF cl_null(l_oea61) THEN
         LET l_oea61 = 100
      END IF
      #-----No:CHI-A70015 END-----

      IF g_oma.oma213 = 'Y' THEN
         LET l_omb14t = l_omb.omb14t * l_per / l_oea1008
         LET l_omb16t = l_omb.omb16t * l_per / l_oea1008
      ELSE
         LET l_omb14t = l_omb.omb14t * l_per / l_oea61
         LET l_omb16t = l_omb.omb16t * l_per / l_oea61
      END IF
   ELSE
      LET l_omb14t = l_omb.omb14t
      LET l_omb16t = l_omb.omb16t
   END IF

  #CASE l_oma.oma00
  #  WHEN 11
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma161/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma161/100
  #  WHEN 12
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma162/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma162/100
  #  WHEN 13
  #    LET l_omb14t = l_omb.omb14t*l_oma.oma163/100
  #    LET l_omb16t = l_omb.omb16t*l_oma.oma163/100
  #  OTHERWISE  
  #    LET l_omb14t = l_omb.omb14t
  #    LET l_omb16t = l_omb.omb16t
  #END CASE
  ##-----No:FUN-A50103 END-----

   #當多帳期的應收金額>單身的應收金額,應以單身的應收金額為帶出的金額
   IF g_oob[l_ac].oob09 > l_omb14t - l_omb.omb34 - tot1 THEN   #MOD-A10084 add
      LET g_oob[l_ac].oob09 = l_omb14t - l_omb.omb34 - tot1
      LET g_oob[l_ac].oob10 = l_omb16t - l_omb.omb35 - tot2
   END IF   #MOD-A10084 add
  #-MOD-B10083-add- 
   IF g_ooz.ooz07 = 'Y' THEN       
      LET g_oob[l_ac].oob08 = l_omb.omb36
   ELSE                                       
      LET g_oob[l_ac].oob08 = l_oma.oma24       
   END IF                                   
  #-MOD-B10083-end- 
   IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     #-MOD-B10083-mark-
     #IF g_apz.apz27 = 'Y' THEN                 #MOD-940277
     #   LET g_oob[l_ac].oob08 = l_omb.omb36
     #ELSE                                      #MOD-940277
     #	 LET g_oob[l_ac].oob08 = l_oma.oma24    #MOD-940277
     #END IF                                    #MOD-940277 	    
     #-MOD-B10083-end- 
      IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
         LET g_oob[l_ac].oob08 = l_oma.oma24
         DISPLAY BY NAME g_oob[l_ac].oob08
      END IF
      CALL s_g_np('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
                  RETURNING tot3
      IF (tot1+g_oob[l_ac].oob09+l_omb.omb34) = l_omb14t THEN   #CHI-840051
         LET g_oob[l_ac].oob10 = tot3 - tot2
         DISPLAY BY NAME g_oob[l_ac].oob10
      END IF
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file                 #MOD-940238
   WHERE azi01 = g_oob[l_ac].oob07
   CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09    #No.CHI-6A0004
   CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10    #No.CHI-6A0004
   DISPLAY BY NAME g_oob[l_ac].oob09
   DISPLAY BY NAME g_oob[l_ac].oob10
END FUNCTION
 
FUNCTION t400_oob06_13(p_sw)            # 檢查待抵/應收帳款
  DEFINE p_sw             LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)                  # 2:取待抵 1:取應收
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*   #No.FUn-680022 --add
  DEFINE tot1,tot2,tot3   LIKE oob_file.oob09
  DEFINE l_oox10          LIKE oox_file.oox10
  DEFINE l_aag05          LIKE aag_file.aag05   #MOD-5B0012
  DEFINE tot4,tot4t       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)             #TQC-5B0171
  DEFINE l_bookno         LIKE aag_file.aag00   #No.FUN-740184
  DEFINE l_ombcnt         LIKE type_file.num5   #CHI-8A0018
  DEFINE l_chkcnt         LIKE type_file.num5   #CHI-8A0018
 
  LET g_sql="SELECT oma_file.*,omc_file.* ",   #No.FUN-680022 --add
            #"  FROM ",g_dbs_new CLIPPED,"omc_file ,",g_dbs_new CLIPPED,"oma_file ",  #No.FUN-680022 --add
            #"  FROM ",cl_get_target_table(g_plant,'omc_file'), #FUN-A50102
            #"    ,  ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
            "  FROM omc_file,oma_file  ", #FUN-A50102
            " WHERE oma01=omc01 AND omc01=? AND omc02=?"   #No.FUN-680022 --add
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t400_oob06_13_p1 FROM g_sql
  DECLARE t400_oob06_13_c1 CURSOR FOR t400_oob06_13_p1
  OPEN t400_oob06_13_c1 USING g_oob[l_ac].oob06,g_oob[l_ac].oob19
  FETCH t400_oob06_13_c1 INTO l_oma.*,l_omc.*    #No.FUN-680022 --add
 #IF STATUS THEN CALL cl_err('sel omc',"axr-031",1) LET g_errno='N' END IF   #No.FUN-680022 --add   #MOD-A70114 mark
  IF STATUS THEN CALL cl_err('sel omc',"aap-777",1) LET g_errno='N' END IF   #MOD-A70114 add
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  IF l_oma.omaconf='N' THEN   #MOD-760119
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
  IF p_sw='2' AND l_oma.oma00[1,1]!='2' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF p_sw='1' AND l_oma.oma00[1,1]!='1' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF l_oma.oma00='23' THEN
    #CALL cl_err('','axr-188',1) LET g_errno='N' END IF #CHI-8A0018 mark
 #-CHI-8A0018-add-
     LET l_ombcnt = 0
     SELECT COUNT(*) INTO l_ombcnt
       FROM oma_file,omb_file
      WHERE oma01 = omb01 
        AND oma19 = l_oma.oma01
     IF cl_null(l_ombcnt) THEN LET l_ombcnt = 0 END IF

     LET l_chkcnt = 0
     LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_oma.oma66,'oeb_file'),",",
                 "   oma_file,omb_file ",
                 " WHERE oma01 = omb01 ",
                 "   AND oma19 = '",l_oma.oma01,"'",
                 "   AND omb31 = oeb01 ",
                 "   AND omb32 = oeb03 ",
                 "   AND oeb70 = 'Y' "
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql
     CALL cl_parse_qry_sql(g_sql,l_oma.oma66) RETURNING g_sql
     PREPARE sel_oeb2 FROM g_sql
     EXECUTE sel_oeb2 INTO l_chkcnt 
     IF cl_null(l_chkcnt) THEN LET l_ombcnt = 0 END IF

     IF l_ombcnt <> l_chkcnt THEN
        CALL cl_err('','axr-188',1) 
        LET g_errno='N' 
     END IF
  END IF 
 #-CHI-8A0018-end-
  IF l_oma.oma68 != g_ooa.ooa03 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma69 != g_ooa.ooa032 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma23!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_oma.oma54t<=l_oma.oma55 THEN
     CALL cl_err('','axr-190',1) LET g_errno='N' END IF
 #原幣沖完但本幣未沖完
  IF l_oma.oma54t=l_oma.oma55 AND l_oma.oma56t!=l_oma.oma57 THEN
     CALL cl_err('','axr-193',1) LET g_errno='N' END IF
## No.2723 modify 1998/11/05 立帳日不可比沖款日小
  IF l_oma.oma02 > g_ooa.ooa02 THEN
     CALL cl_err('','axr-371',0) LET g_errno = 'N'
  END IF
 #CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 mark
  CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
  IF g_flag='1' THEN
     CALL cl_err(l_oma.oma02,'aoo-081',1)
  END IF
  LET g_oob[l_ac].oob07=l_oma.oma23
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #MOD-940238 RECUVA
  LET g_oob[l_ac].oob08=l_oma.oma24
## No.2694 modify 1998/10/31 不可沖超過
   LET tot1 = 0
   LET tot2 = 0
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file 
    WHERE oob06 = g_oob[l_ac].oob06
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob19 = g_oob[l_ac].oob19   #No.FUN-680022 --add
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)       #MOD-950237
      AND oob03 = g_oob[l_ac].oob03
      AND oob04 = g_oob[l_ac].oob04
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF
   LET g_oob[l_ac].oob09 = l_omc.omc08  - l_omc.omc10 - tot1 #No.FUN-680022 --add
   LET g_oob[l_ac].oob10 = l_omc.omc09  - l_omc.omc11 - tot2 #No.FUN-680022 --ad2
  #-MOD-B10083-add- 
   IF g_ooz.ooz07 = 'Y' THEN       
      LET g_oob[l_ac].oob08 = l_oma.oma60  
   ELSE                                       
      LET g_oob[l_ac].oob08 = l_oma.oma24       
   END IF                                   
  #-MOD-B10083-end- 
   IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     #-MOD-B10083-mark-
     #IF g_apz.apz27 = 'Y' THEN                        #MOD-940277
     #   LET g_oob[l_ac].oob08 = l_oma.oma60   #No.FUN-680022 --add
     #ELSE                                             #MOD-940277
     #	 LET g_oob[l_ac].oob08 = l_oma.oma24           #MOD-940277
     #END IF                                           #MOD-940277	    
     #-MOD-B10083-end- 
      IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
         LET g_oob[l_ac].oob08 = l_oma.oma24
      END IF
#     CALL s_g_np1('1',l_oma.oma00,g_oob[l_ac].oob06,'',g_oob[l_ac].oob19)     #No.FUN-680022   #No.FUN-7B0055
      CALL s_g_np1('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15,g_oob[l_ac].oob19)     #No.FUN-680022   #No.FUN-7B0055 FUN-AB0034
           RETURNING tot3
      #取得衝帳單的待扺金額
      CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
      CALL cl_digcut(tot4,t_azi04) RETURNING tot4              #No.CHI-6A0004
      CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
      #未衝金額扣除待扺
      LET tot3 = tot3 - tot4t
      IF (tot1+g_oob[l_ac].oob09+l_omc.omc10) = l_omc.omc08  THEN  #No.FUN-680022 --add
         LET g_oob[l_ac].oob10 = tot3 - tot2
      END IF
   END IF
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10     #No.CHI-6A0004
  LET g_oob[l_ac].oob11=l_oma.oma18
  IF g_aza.aza63='Y' THEN                 #No.FUN-670047 add
     LET g_oob[l_ac].oob111=l_oma.oma181  #No.FUN-670047 add
  END IF                                  #No.FUN-670047 add
 LET l_aag05=''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1     #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_oma.oma15
  ELSE   #MOD-730022
     LET g_oob[l_ac].oob13=''   #MOD-730022
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
          RETURNING l_bookno,g_oob[l_ac].oob11
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
          RETURNING l_bookno,g_oob[l_ac].oob111
  END IF
 
  IF p_sw = '2' THEN
     LET g_oob[l_ac].oob14=l_oma.oma16
  ELSE
     LET g_oob[l_ac].oob14=l_oma.oma10
  END IF
##No.2878 modify 1998/12/01 oma00='25'要判斷輸入時其oma00='12'之值亦須存在
#No.MOD-A40182 --begin
#  IF p_sw = '2' THEN   #待抵
#     IF l_oma.oma00 = '25' THEN
#        SELECT COUNT(*) INTO g_cnt FROM oob_file
#         WHERE oob06 = g_oob[l_ac].oob14
#           AND oob03 = '2'
#           AND oob01 = g_ooa.ooa01
#        IF g_cnt <= 0 THEN
#           CALL cl_err(g_oob[l_ac].oob06,'axr-353',1)
#           LET g_errno = 'N'
#        END IF
#     END IF
#  END IF
#No.MOD-A40182 --end
END FUNCTION
 
FUNCTION t400_oob06_19(l_sw)         # 借/貸方檢查 : A/P   #MOD-750063
  DEFINE l_apa            RECORD LIKE apa_file.*
  DEFINE l_apc            RECORD LIKE apc_file.*   #No.FUN-680022 add
  DEFINE p05,p05f       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_apz27        LIKE apz_file.apz27
  DEFINE l_amt3         LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_amtf,l_amt   LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_amt16        LIKE type_file.num20_6     #No.MOD-BB0016
  DEFINE l_aag05        LIKE aag_file.aag05        #MOD-730022
  DEFINE l_bookno       LIKE aag_file.aag00        #No.FUN-740184
  DEFINE l_sw           LIKE type_file.chr1        #MOD-750063
 
  IF cl_null(g_oob[l_ac].oob19) THEN LET g_oob[l_ac].oob19 = '1' END IF 
  SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file 
   WHERE apa01= g_oob[l_ac].oob06 
     AND apa01=apc01 
     AND apc02= g_oob[l_ac].oob19    
     AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
  IF STATUS THEN 
     CALL cl_err3("sel","apa_file",g_oob[l_ac].oob06,"",STATUS,"","sel apa",1)  #No.FUN-660116  
     LET g_errno='N' 
  END IF
  IF l_apa.apa06!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當付款廠商!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa07!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當廠商名稱!=客戶名稱時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa13!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_apa.apa41 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  #FUN-B50090 add begin-------------------------
  #重新抓取關帳日期
  SELECT apz57 INTO g_apz.apz57 FROM apz_file WHERE apz00='0'
  #FUN-B50090 add -end--------------------------
 #-CHI-B20040-add-
  IF g_ooa.ooa02 <= g_apz.apz57 THEN   #立帳日期不可小於關帳日期
     CALL cl_err('','axr-084',1)
     LET g_errno='N' 
  END IF
 #-CHI-B20040-end-
 #CALL s_get_bookno(YEAR(l_apa.apa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 mark
  CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
  IF g_flag='1' THEN
     CALL cl_err(l_apa.apa02,'aoo-081',1)
  END IF
  #須考慮未確認沖帳資料
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
   WHERE oob06 = g_oob[l_ac].oob06 AND oob19=g_oob[l_ac].oob19   #No.FUN-680022 add
     AND oob01 = ooa01 AND ooaconf = 'N'
     AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_t.oob02)        #MOD-950237
     AND oob03 = g_oob[l_ac].oob03
     AND oob04 = g_oob[l_ac].oob04
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  LET p05f = 0 LET p05 = 0
  IF l_sw = '1' THEN
     SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
       FROM apg_file,apf_file
      WHERE apg04=g_oob[l_ac].oob06
        AND apg06=g_oob[l_ac].oob19
        AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
  ELSE
     SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05
       FROM aph_file,apf_file
      WHERE aph04=g_oob[l_ac].oob06
        AND aph17=g_oob[l_ac].oob19
        AND aph01=apf01 AND apf41='N' AND aph01<>g_ooa.ooa01
  END IF
  IF p05f IS NULL THEN LET p05f=0 END IF
  IF p05  IS NULL THEN LET p05 =0 END IF
 #LET l_amtf = l_apc.apc08-l_apc.apc10-l_apc.apc16-tot1-p05f                     #MOD-C20036 mark
  LET l_amtf = l_apc.apc08-l_apc.apc10-l_apc.apc16-tot1-p05f-l_apc.apc14         #MOD-C20036 add
  IF g_apz.apz27 = 'N' THEN
    #----------------------------------MOD-BB0016-------------------------start
     LET l_amt16 = l_apc.apc16*l_apc.apc06
     CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16
    #IF l_apc.apc09 -l_apc.apc11 -tot2-p05 = l_amt16 THEN
     IF l_apc.apc09 -l_apc.apc11 -tot2-p05 = l_amt16  and l_amt16>0 THEN
        CALL cl_err('','axr-413',1) LET g_errno='N'
     END IF
    #LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_apc.apc16*l_apc.apc06)-tot2-p05
    #LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_amt16)-tot2-p05                   #MOD-C20036 mark
     LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_amt16)-tot2-p05-l_apc.apc15       #MOD-C20036 add
    #----------------------------------MOD-BB0016---------------------------end
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  ELSE
    #----------------------------------MOD-BB0016-------------------------start
     LET l_amt16 = l_apc.apc16*l_apc.apc07
     CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16
     IF l_apc.apc13 -tot2-p05 = l_amt16  and l_amt16>0 THEN
        CALL cl_err('','axr-413',1) LET g_errno='N'
     END IF
    #LET l_amt  = l_apc.apc13 -(l_apc.apc16*l_apc.apc07)-tot2-p05
     LET l_amt  = l_apc.apc13 -(l_amt16)-tot2-p05
    #----------------------------------MOD-BB0016---------------------------end
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  END IF
  LET g_oob[l_ac].oob07=l_apa.apa13
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077 #No.CHI-6A0004 #MOD-940238 RECUVA
  LET g_oob[l_ac].oob08=l_apc.apc06   #MOD-750063
  LET g_oob[l_ac].oob09=l_amtf
  LET g_oob[l_ac].oob10=l_amt
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10     #No.CHI-6A0004
  LET g_oob[l_ac].oob11=l_apa.apa54
  IF g_aza.aza63='Y' THEN                 #No.FUN-670047 add
     LET g_oob[l_ac].oob111=l_apa.apa541  #No.FUN-670047 add
  END IF                                  #No.FUN-670047 add
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1          #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_apa.apa22
  ELSE
     LET g_oob[l_ac].oob13=''
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)
          RETURNING l_bookno,g_oob[l_ac].oob11
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)
          RETURNING l_bookno,g_oob[l_ac].oob111
  END IF
  LET g_oob[l_ac].oob14=l_apa.apa08
  LET g_oob[l_ac].oob12=l_apa.apa25   #MOD-780261
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
  IF l_apz27 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                  #MOD-940277
        LET g_oob[l_ac].oob08 = l_apa.apa72
     ELSE                                       #MOD-940277
     	  LET g_oob[l_ac].oob08 = l_apc.apc06     #MOD-940277
     END IF                                     #MOD-940277	     
     IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
        LET g_oob[l_ac].oob08 = l_apc.apc06   #MOD-750063
     END IF
     CALL s_g_np('2',l_apa.apa00,g_oob[l_ac].oob06,g_oob[l_ac].oob15)
                 RETURNING l_amt3
     #未付金額-已KEY未確認-留置金額
     IF (tot1+g_oob[l_ac].oob09+p05f+l_apc.apc10) = l_apc.apc08 THEN   #MOD-750063
        LET g_oob[l_ac].oob10 = l_amt3-tot2-p05-(l_apc.apc16*l_apc.apc06)   #MOD-750063
     END IF
     CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10  #No.CHI-6A0004
  END IF
END FUNCTION
 

#FUN-D80031 --------- add ---------- begin
FUNCTION t400_oob06_20()            # 檢查20:待抵帐扣费用
  DEFINE p_sw             LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)                  # 2:取待抵 1:取應收
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*   #No.FUn-680022 --add
  DEFINE tot1,tot2,tot3   LIKE oob_file.oob09
  DEFINE l_oox10          LIKE oox_file.oox10
  DEFINE l_aag05          LIKE aag_file.aag05   #MOD-5B0012
  DEFINE tot4,tot4t       LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)             #TQC-5B0171
  DEFINE l_bookno         LIKE aag_file.aag00   #No.FUN-740184
  DEFINE l_ombcnt         LIKE type_file.num5   #CHI-8A0018
  DEFINE l_chkcnt         LIKE type_file.num5   #CHI-8A0018

  LET g_oob[l_ac].oob19 = '1'
  DISPLAY BY NAME g_oob[l_ac].oob19
  LET g_sql="SELECT oma_file.*,omc_file.* ",   #No.FUN-680022 --add
            "  FROM omc_file,oma_file  ", #FUN-A50102
            " WHERE oma01=omc01 AND oma00 = '20' AND omc01=? AND omc02=? "
  PREPARE t400_oob06_H_p1 FROM g_sql
  DECLARE t400_oob06_H_c1 CURSOR FOR t400_oob06_H_p1
  OPEN t400_oob06_H_c1 USING g_oob[l_ac].oob06,g_oob[l_ac].oob19
  FETCH t400_oob06_H_c1 INTO l_oma.*,l_omc.*    #
  IF STATUS THEN
     IF g_bgerr THEN
        CALL s_errmsg('','',g_oob[l_ac].oob06,'aap-777',1)
     ELSE
        CALL cl_err('sel omc',"aap-777",1)
     END IF
     LET g_errno='N'
  END IF
  IF l_oma.omavoid = 'Y' THEN
     IF g_bgerr THEN
        CALL s_errmsg('','',l_oma.oma01,'axr-103',1)
     ELSE
        CALL cl_err(l_oma.oma01,'axr-103',0)
     END IF   #No.FUN-D20041   Add
     LET g_errno = 'N'
  END IF
  IF l_oma.omaconf='N' THEN   #MOD-760119
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-194',1)
      ELSE
        CALL cl_err('','axr-194',1)
      END IF   #No.FUN-D20041   Add
     LET g_errno='N'
  END IF
  IF l_oma.oma68 != g_ooa.ooa03 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-140',1)
      ELSE
         CALL cl_err('','axr-140',1)
      END IF
  END IF
  IF l_oma.oma69 != g_ooa.ooa032 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-140',1)
      ELSE
         CALL cl_err('','axr-140',1)
      END IF
  END IF
  IF l_oma.oma23!=g_ooa.ooa23 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-144',1)
      ELSE
         CALL cl_err('','axr-144',1)
      END IF
     LET g_errno='N' END IF
  IF l_oma.oma54t<=l_oma.oma55 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-190',1)
      ELSE
         CALL cl_err('','axr-190',1)
      END IF
     LET g_errno='N' END IF
 #原幣沖完但本幣未沖完
  IF l_oma.oma54t=l_oma.oma55 AND l_oma.oma56t!=l_oma.oma57 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-193',1)
      ELSE
         CALL cl_err('','axr-193',1)
      END IF
     LET g_errno='N' END IF
  IF l_oma.oma02 > g_ooa.ooa02 THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',g_oob[l_ac].oob06,'axr-371',1)
      ELSE
         CALL cl_err('','axr-371',0)
      END IF   #No.FUN-D20041   Add
     LET g_errno = 'N'
  END IF
  CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
  IF g_flag='1' THEN
      IF g_bgerr THEN
         CALL s_errmsg('','',l_oma.oma02,'aoo-081',1)
      ELSE
     #No.FUN-D20041 ---Add--- End
         CALL cl_err(l_oma.oma02,'aoo-081',1)
      END IF   #No.FUN-D20041   Add
  END IF
  LET g_oob[l_ac].oob07=l_oma.oma23
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob[l_ac].oob07 #MOD-910070 mark #MOD-560077  #No.CHI-6A0004 #M
  LET g_oob[l_ac].oob08=l_oma.oma24
  LET tot1 = 0
  LET tot2 = 0
  IF NOT cl_null(g_oob_t.oob02) THEN
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
      WHERE oob06 = g_oob[l_ac].oob06
        AND oob01 = ooa01 AND ooaconf = 'N'
        AND oob19 = g_oob[l_ac].oob19
        AND ((oob01 <> g_ooa.ooa01) OR (oob01=g_ooa.ooa01 AND oob02 <> g_oob_t.oob02))       #MOD-950237
        AND oob03 = g_oob[l_ac].oob03
        AND oob04 = g_oob[l_ac].oob04
   ELSE
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
      WHERE oob06 = g_oob[l_ac].oob06
        AND oob01 = ooa01 AND ooaconf = 'N'
        AND oob19 = g_oob[l_ac].oob19
        AND oob03 = g_oob[l_ac].oob03
        AND oob04 = g_oob[l_ac].oob04
   END IF
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF
   LET g_oob[l_ac].oob09 = l_omc.omc08  - l_omc.omc10 - tot1
   LET g_oob[l_ac].oob10 = l_omc.omc09  - l_omc.omc11 - tot2
   IF g_ooz.ooz07 = 'Y' THEN
      LET g_oob[l_ac].oob08 = l_oma.oma60
   ELSE
      LET g_oob[l_ac].oob08 = l_oma.oma24
   END IF
   IF g_ooz.ooz07 = 'Y' AND g_oob[l_ac].oob07 != g_aza.aza17 THEN
      IF cl_null(g_oob[l_ac].oob08) OR g_oob[l_ac].oob08 = 0 THEN
         LET g_oob[l_ac].oob08 = l_oma.oma24
      END IF
      CALL s_g_np1('1',l_oma.oma00,g_oob[l_ac].oob06,g_oob[l_ac].oob15,g_oob[l_ac].oob19)     #No.FUN-680022   #No.FUN-7B
           RETURNING tot3
      #取得衝帳單的待扺金額
      CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
      CALL cl_digcut(tot4,t_azi04) RETURNING tot4              #No.CHI-6A0004
      CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
      #未衝金額扣除待扺
      LET tot3 = tot3 - tot4t
      IF (tot1+g_oob[l_ac].oob09+l_omc.omc10) = l_omc.omc08  THEN  #No.FUN-680022 --add
         LET g_oob[l_ac].oob10 = tot3 - tot2
      END IF
   END IF
  CALL cl_digcut(g_oob[l_ac].oob09,t_azi04) RETURNING g_oob[l_ac].oob09     #No.CHI-6A0004
  CALL cl_digcut(g_oob[l_ac].oob10,g_azi04) RETURNING g_oob[l_ac].oob10     #No.CHI-6A0004
  LET g_oob[l_ac].oob11=l_oma.oma18
  IF g_aza.aza63='Y' THEN                 #No.FUN-670047 add
     LET g_oob[l_ac].oob111=l_oma.oma181  #No.FUN-670047 add
  END IF                                  #No.FUN-670047 add
 LET l_aag05=''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob[l_ac].oob11
                                            AND aag00=g_bookno1     #No.FUN-730073
  IF l_aag05 = 'Y' THEN
     LET g_oob[l_ac].oob13=l_oma.oma15
  ELSE   #MOD-730022
     LET g_oob[l_ac].oob13=''   #MOD-730022
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN 
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob[l_ac].oob11)  
          RETURNING l_bookno,g_oob[l_ac].oob11
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob[l_ac].oob111)   
          RETURNING l_bookno,g_oob[l_ac].oob111
  END IF

  LET g_oob[l_ac].oob14=l_oma.oma16
END FUNCTION
#FUN-D80031 --------- add ---------- end

FUNCTION t400_diff()
   DEFINE l_oob10d  LIKE oob_file.oob10
   DEFINE l_oob10c  LIKE oob_file.oob10
   DEFINE l_cnt     LIKE type_file.num10       #No.FUN-680123 INTEGER #MOD-5B0292
   DEFINE l_msg     LIKE type_file.chr20       #No.FUN-680123 VARCHAR(20)
   DEFINE l_aag05   LIKE aag_file.aag05   #MOD-730022
   DEFINE l_flag    LIKE type_file.chr1        #CHI-A30007 
   DEFINE l_ool     RECORD LIKE ool_file.*     #MOD-CA0044
 
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2
   IF g_flag='1' THEN
      CALL cl_err(g_ooa.ooa02,'aoo-081',1)
   END IF
  #IF g_ooa.ooa32d = g_ooa.ooa32c THEN RETURN END IF #MOD-AC0166 mark
  #-MOD-AC0166-add-
   LET l_flag = 'N' 
   IF g_ooa.ooa32d = g_ooa.ooa32c THEN 
      RETURN l_flag                     
   END IF
  #-MOD-AC0166-add-
   INITIALIZE b_oob.* TO NULL
   LET b_oob.oob01=g_ooa.ooa01
   LET b_oob.oob07=g_ooa.ooa23
   IF b_oob.oob07 IS NULL THEN
      WHILE b_oob.oob07 IS NULL
         LET l_msg=cl_getmsg('axr-030',g_lang)  #MOD-4C0141
        PROMPT l_msg FOR b_oob.oob07
              ON IDLE g_idle_seconds
                 CALL cl_on_idle()
 
               ON ACTION about         #MOD-4C0121
                  CALL cl_about()      #MOD-4C0121
 
               ON ACTION help          #MOD-4C0121
                  CALL cl_show_help()  #MOD-4C0121
 
               ON ACTION controlg      #MOD-4C0121
                  CALL cl_cmdask()     #MOD-4C0121
        END PROMPT
        IF INT_FLAG THEN LET INT_FLAG=0 EXIT WHILE END IF
      END WHILE
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-910070 mark #MOD-560077   #No.CHI-6A0004 #MOD-940238 RECUVA
   IF diff_flag='8' THEN
      LET b_oob.oob03='2'
      LET b_oob.oob04='2'
      CALL s_curr3(b_oob.oob07,g_ooa.ooa02,g_ooz.ooz17) RETURNING b_oob.oob08
      LET b_oob.oob09= g_ooa.ooa31d - g_ooa.ooa31c
      IF b_oob.oob08 IS NOT NULL THEN
         IF b_oob.oob08 = 1 THEN                              #MOD-9C0022 
            LET b_oob.oob09= g_ooa.ooa32d - g_ooa.ooa32c      #MOD-9C0022
            LET b_oob.oob10= g_ooa.ooa32d - g_ooa.ooa32c
         ELSE
            LET b_oob.oob10= b_oob.oob08 * b_oob.oob09
         END IF
      ELSE
         LET b_oob.oob10= g_ooa.ooa32d - g_ooa.ooa32c
         LET b_oob.oob08= b_oob.oob10/b_oob.oob09
      END IF
      LET b_oob.oob09 = b_oob.oob10 / b_oob.oob08    #MOD-9A0001 add
   ELSE 
      LET b_oob.oob03='1'
      LET b_oob.oob04=diff_flag
      LET b_oob.oob10= g_ooa.ooa32c - g_ooa.ooa32d
      IF b_oob.oob10<0 THEN 
         LET b_oob.oob10=-b_oob.oob10 
      END IF
     #CHI-A30007-add-
     #LET l_flag = 'N'    #MOD-AC0166 mark 
      IF diff_flag='6' AND b_oob.oob07 <> g_aza.aza17 THEN
        LET g_cnt = 0 
        SELECT COUNT(*) INTO g_cnt
          FROM oob_file
          WHERE oob01 = b_oob.oob01 AND oob07 <> b_oob.oob07
        IF g_cnt = 0 AND g_ooa.ooa31d <> g_ooa.ooa31c THEN
           CALL s_curr3(b_oob.oob07,g_ooa.ooa02,g_ooz.ooz17) RETURNING b_oob.oob08
           LET b_oob.oob09 = g_ooa.ooa31c - g_ooa.ooa31d
           LET b_oob.oob10 = b_oob.oob09 * b_oob.oob08   
           LET l_flag = 'Y' 
        END IF  
      END IF
     #CHI-A30007-end-
      IF diff_flag='7' OR g_ooa.ooa31d = g_ooa.ooa31c THEN
         LET b_oob.oob07= g_aza.aza17                        #MOD-A80175
         LET b_oob.oob08= 1
         LET b_oob.oob09= 0
         IF g_ooa.ooa32d>g_ooa.ooa32c THEN #匯兌收入
            LET b_oob.oob03='2'
         ELSE
            LET b_oob.oob03='1'                   #匯兌損失
         END IF
         LET l_flag = 'N'            #CHI-A30007 
      ELSE 
         LET b_oob.oob09= g_ooa.ooa31c - g_ooa.ooa31d
         LET b_oob.oob08= b_oob.oob10/b_oob.oob09
      END IF
   END IF
   CALL cl_digcut(b_oob.oob09,t_azi04) RETURNING b_oob.oob09     #No.CHI-6A0004
   CALL cl_digcut(b_oob.oob10,g_azi04) RETURNING b_oob.oob10     #No.CHI-6A0004
 
   SELECT SUM(oob10) INTO l_oob10d FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03 ='1'
   SELECT SUM(oob10) INTO l_oob10c FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03 ='2'
   IF cl_null(l_oob10d) THEN LET l_oob10d=0 END IF
   IF cl_null(l_oob10c) THEN LET l_oob10c=0 END IF
   IF diff_flag='8' THEN
      IF l_oob10d <> l_oob10c+b_oob.oob10 THEN
         LET b_oob.oob10=l_oob10d - l_oob10c
      END IF
   ELSE
     #IF l_oob10d +b_oob.oob10 <> l_oob10c THEN                   #CHI-A30007 mark
      IF l_oob10d +b_oob.oob10 <> l_oob10c AND l_flag = 'N' THEN  #CHI-A30007
         LET b_oob.oob10=l_oob10d - l_oob10c
      END IF
   END IF
  SELECT MAX(oob02)+1 INTO b_oob.oob02 FROM oob_file
         WHERE oob01=g_ooa.ooa01
   IF STATUS OR b_oob.oob02 IS NULL THEN
      IF b_oob.oob03='1' THEN LET b_oob.oob02=1 ELSE LET b_oob.oob02=5 END IF
   END IF
  #CALL t400_b_move_to()                      #MOD-CA0044 mark
  #CALL t400_acct_code()                      #MOD-CA0044 mark
  #-MOD-CA0044-add-
   SELECT * INTO l_ool.* 
     FROM ool_file 
    WHERE ool01 = g_ooa.ooa13
   CASE WHEN b_oob.oob03 = '1' AND b_oob.oob04 = '5'
           LET b_oob.oob11 = l_ool.ool54
           IF g_aza.aza63='Y' THEN              
              LET b_oob.oob111 = l_ool.ool541    
           END IF                              
        WHEN b_oob.oob03 = '1' AND b_oob.oob04 = '6'
           LET b_oob.oob11 = l_ool.ool51
           IF g_aza.aza63='Y' THEN             
              LET b_oob.oob111 = l_ool.ool511   
           END IF                            
        WHEN b_oob.oob03 = '1' AND b_oob.oob04 = '7' 
           LET b_oob.oob11 = l_ool.ool52
           IF g_aza.aza63='Y' THEN              
              LET b_oob.oob111 = l_ool.ool521   
           END IF                             
        WHEN b_oob.oob03 = '2' AND b_oob.oob04 = '7'
           LET b_oob.oob11 = l_ool.ool53
           IF g_aza.aza63='Y' THEN            
              LET b_oob.oob111 = l_ool.ool531  
           END IF                             
        WHEN b_oob.oob03 = '1' AND b_oob.oob04 = '8'
           LET b_oob.oob11 = l_ool.ool23
           IF g_aza.aza63='Y' THEN      
              LET b_oob.oob111 = l_ool.ool231   
           END IF                              
        WHEN b_oob.oob03 = '2' AND b_oob.oob04 = '2'
           LET b_oob.oob11 = l_ool.ool25
           IF g_aza.aza63='Y' THEN   
              LET b_oob.oob111 = l_ool.ool251   
           END IF                            
        OTHERWISE
           LET b_oob.oob11 = null
           LET b_oob.oob111= null   
   END CASE
  #-MOD-CA0044-end-
   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=b_oob.oob11
                                             AND aag00=g_bookno1      #No.FUN-730073
   IF l_aag05 = 'Y' THEN
      LET b_oob.oob13= g_ooa.ooa15
   ELSE
      LET b_oob.oob13= ''
   END IF
   LET b_oob.ooblegal = g_ooa.ooalegal
   INSERT INTO oob_file VALUES(b_oob.*)
   IF STATUS THEN
      CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,STATUS,"","ins oob",1)  #No.FUN-660116
      BEGIN WORK LET g_success='Y'
 
      OPEN t400_cl USING g_ooa.ooa01
      IF STATUS THEN
         CALL cl_err("OPEN t400_cl:", STATUS, 1)  
         CLOSE t400_cl
         ROLLBACK WORK
        #RETURN                #MOD-AC0166 mark
         RETURN l_flag         #MOD-AC0166            
      END IF
      FETCH t400_cl INTO g_ooa.*       # 鎖住將被更改或取消的資料
      IF SQLCA.sqlcode THEN
          CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
         #CLOSE t400_cl ROLLBACK WORK RETURN           #MOD-AC0166 mark
          CLOSE t400_cl ROLLBACK WORK                  #MOD-AC0166
          RETURN l_flag                                #MOD-AC0166            
      END IF
      CALL t400_sortb() RETURNING b_oob.oob02
      IF g_success='Y' THEN COMMIT WORK
         INSERT INTO oob_file VALUES(b_oob.*)
      ELSE
         ROLLBACK WORK
         CALL cl_err('ins oob',STATUS,1)
      END IF
   END IF
   CALL t400_bu()
   RETURN l_flag                       #CHI-A30007
END FUNCTION
 
FUNCTION t400_sortb()
DEFINE p_i,p_rnum  LIKE type_file.num5,       #No.FUN-680123 SMALLINT,
         p_oob03_t LIKE oob_file.oob03,
         p_a       LIKE type_file.chr1,       #No.FUN-680123 VARCHAR(1),
         p_oob       RECORD LIKE oob_file.*,
         x_oob      DYNAMIC ARRAY OF RECORD like oob_file.*
CREATE TEMP TABLE sort_file(
oob01 LIKE oob_file.oob01,
oob02 LIKE oob_file.oob02,
oob03 LIKE oob_file.oob03,
oob04 LIKE oob_file.oob04,
oob06 LIKE oob_file.oob06,
oob07 LIKE oob_file.oob07,
oob08 LIKE oob_file.oob08 NOT NULL,
oob09 LIKE oob_file.oob09 NOT NULL,
oob10 LIKE oob_file.oob10 NOT NULL,
oob11 LIKE oob_file.oob11,
oob12 LIKE oob_file.oob12,
oob13 LIKE oob_file.oob13,
oob14 LIKE oob_file.oob14,
oob15 LIKE oob_file.oob15,
oob16 LIKE oob_file.oob16)
 
       INITIALIZE p_oob.* TO NULL
       DECLARE t400_sortb_cur CURSOR FOR
        SELECT * FROM oob_file WHERE oob01=g_ooa.ooa01
        ORDER BY oob03
 
      LET p_i=1
      FOREACH t400_SORTB_CUR INTO p_oob.*
          IF STATUS THEN LET g_success='N' RETURN 0 END IF
        INSERT INTO sort_file VALUES(p_oob.*)
          IF STATUS THEN LET g_success='N' RETURN 0 END IF
      END FOREACH
            LET INT_FLAG = 0  ######add for prompt bug
        PROMPT 'any key continue...' FOR CHAR p_a
           ON IDLE g_idle_seconds
              CALL cl_on_idle()
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
        END PROMPT
        DELETE FROM oob_file WHERE oob01=g_ooa.ooa01
      IF STATUS THEN
            LET g_success='N' RETURN 0
        END IF
      LET p_i=1
      DECLARE t400_sortc_cur CURSOR FOR
         SELECT * FROM sort_file WHERE oob01=g_ooa.ooa01 ORDER BY oob03
      LET p_oob03_t=1
      FOREACH t400_SORTC_CUR INTO p_oob.*
        IF p_oob.oob03<>p_oob03_t THEN
           LET p_rnum=p_i
           LET p_i=p_i+1
          END IF
        LET p_oob.oob02=p_i
        INSERT INTO oob_file VALUES(p_oob.*)
        IF STATUS THEN LET g_success='N' RETURN 0 END IF
          LET p_oob03_t=p_oob.oob03
        LET p_i=p_i+1
      END FOREACH
      DROP TABLE sort_file
      RETURN p_rnum
END FUNCTION
 
FUNCTION t400_mlog(p_cmd)      # Transaction Modify Log (存入 oem_file)
   DEFINE p_cmd        LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
END FUNCTION
 
FUNCTION t400_bu()

   LET g_ooa.ooa31d = 0 LET g_ooa.ooa31c = 0
   LET g_ooa.ooa32d = 0 LET g_ooa.ooa32c = 0
#No.FUN-AA0088 --begin
   IF g_prog <>'axrt401' THEN 
      SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31d,g_ooa.ooa32d
        FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
      SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31c,g_ooa.ooa32c
        FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
   ELSE 
      #IF g_ooa.ooa40='1' THEN #FUN-C20019 #FUN-C20063 mark--
      IF g_ooa.ooa40='01' THEN #FUN-C20063
         SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31d,g_ooa.ooa32d
           FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
         SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31c,g_ooa.ooa32c
           FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
      #FUN-C20018--add--begin
      ELSE
         SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31d,g_ooa.ooa32d
           FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
         SELECT SUM(oob09),SUM(oob10) INTO g_ooa.ooa31c,g_ooa.ooa32c
           FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
      END IF
      #FUN-C20018--add--end
   END IF 
#No.FUN-aa0088 --end
   IF cl_null(g_ooa.ooa31d) THEN LET g_ooa.ooa31d=0 END IF
   IF cl_null(g_ooa.ooa32d) THEN LET g_ooa.ooa32d=0 END IF
   IF cl_null(g_ooa.ooa31c) THEN LET g_ooa.ooa31c=0 END IF
   IF cl_null(g_ooa.ooa32c) THEN LET g_ooa.ooa32c=0 END IF
   #no.A010依幣別取位
   LET g_ooa.ooa32d = cl_digcut(g_ooa.ooa32d,g_azi04)  #No.CHI-6A0004
   LET g_ooa.ooa32c = cl_digcut(g_ooa.ooa32c,g_azi04)  #No.CHI-6A0004
   UPDATE ooa_file SET
          ooa31d=g_ooa.ooa31d,ooa31c=g_ooa.ooa31c,
          ooa32d=g_ooa.ooa32d,ooa32c=g_ooa.ooa32c
          WHERE ooa01=g_ooa.ooa01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.SQLCODE,"","upd ood31,32",1)  #No.FUN-660116
   END IF
 
   CALL t400_show_amt()
END FUNCTION
 
FUNCTION t400_delall()
    SELECT COUNT(*) INTO g_cnt FROM oob_file WHERE oob01=g_ooa.ooa01
    IF g_cnt = 0 THEN                   # 未輸入單身資料, 則取消單頭資料
       CALL cl_getmsg('9044',g_lang) RETURNING g_msg
       ERROR g_msg CLIPPED
       DELETE FROM ooa_file WHERE ooa01 = g_ooa.ooa01
    END IF
END FUNCTION
 
FUNCTION t400_b_askkey()
DEFINE l_wc2           LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(200)
    CLEAR oob04_d
    CONSTRUCT l_wc2 ON oob02,oob03,oob04,oob06,oob19,oob11,oob111,    #FUN-990031 del oob05
                       oob13,oob14,oob07,oob08,oob09,oob10
                      ,oobud01,oobud02,oobud03,oobud04,oobud05
                      ,oobud06,oobud07,oobud08,oobud09,oobud10
                      ,oobud11,oobud12,oobud13,oobud14,oobud15
            FROM s_oob[1].oob02,s_oob[1].oob03,s_oob[1].oob04,   #FUN-990031   del oob05
                 s_oob[1].oob06,s_oob[1].oob19,s_oob[1].oob11,s_oob[1].oob111,    #No.FUN-680022  add oob19
                 s_oob[1].oob13,s_oob[1].oob14,s_oob[1].oob07,
                 s_oob[1].oob08,s_oob[1].oob09,s_oob[1].oob10
                ,s_oob[1].oobud01,s_oob[1].oobud02,s_oob[1].oobud03
                ,s_oob[1].oobud04,s_oob[1].oobud05,s_oob[1].oobud06
                ,s_oob[1].oobud07,s_oob[1].oobud08,s_oob[1].oobud09
                ,s_oob[1].oobud10,s_oob[1].oobud11,s_oob[1].oobud12
                ,s_oob[1].oobud13,s_oob[1].oobud14,s_oob[1].oobud15
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
    CALL t400_b_fill(l_wc2)
END FUNCTION
 
FUNCTION t400_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(200)
DEFINE l_n             LIKE type_file.chr1      #No.FUN-AA0088       
 
    IF cl_null(p_wc2) THEN LET p_wc2 = '1=1' END IF   #MOD-BB0332 
    LET g_sql =
       "SELECT oob02,oob03,oob04,'',oob06,oob19,oob15,oob11,oob111,oob13,oob14,",  #FUN-990031 del oob05  
        "       oob07,oob08,oob09,oob10,oob12,",
        "       oobud01,oobud02,oobud03,oobud04,oobud05,",
        "       oobud06,oobud07,oobud08,oobud09,oobud10,",
        "       oobud11,oobud12,oobud13,oobud14,oobud15 ",
        " FROM oob_file ",
        " WHERE oob01 ='",g_ooa.ooa01,"'",  #單頭
        " AND oob03 = ? ",                #FUN-A90003 Add   FUN-AA0088
        " AND ",p_wc2 CLIPPED,                     #單身
        " ORDER BY 1"
 
    PREPARE t400_pb FROM g_sql
    DECLARE oob_curs                       #SCROLL CURSOR
        CURSOR FOR t400_pb
    CALL g_oob.clear()
    LET g_rec_b = 0
    LET g_cnt = 1
#No.FUN-AA0088 --begin  
    IF g_prog ='axrt400' THEN LET l_n =1 END IF 
    #IF g_prog ='axrt401' THEN LET l_n =2 END IF #FUN-C20018 mark--
    #FUN-C20018--add--begin
    IF g_prog ='axrt401' THEN
       #IF g_ooa.ooa40=1 THEN   #FUN-C20063 mark--
       IF g_ooa.ooa40='01' THEN #FUN-C20063
          LET l_n=2
       ELSE
          LET l_n=1
       END IF   
    END IF
    #FUN-C20018--add--end 
    FOREACH oob_curs USING l_n INTO g_oob[g_cnt].*   #單身 ARRAY 填充
#    FOREACH oob_curs INTO g_oob[g_cnt].*   #單身 ARRAY 填充
#No.FUN-AA0088 --end
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        CALL s_oob04(g_oob[g_cnt].oob03,g_oob[g_cnt].oob04)
                RETURNING g_oob[g_cnt].oob04_d
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_oob.deleteElement(g_cnt)
    LET g_rec_b=g_cnt - 1
    DISPLAY g_rec_b TO FORMONLY.cn2
#   LET g_cnt = 0 DISPLAY g_cnt TO FORMONLY.cn3      #FUN-A90003 Mark
     CALL t400_bp_refresh() #MOD-4A0036
END FUNCTION
 
FUNCTION t400_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
 
   #IF p_ud <> "G" OR g_action_choice = "detail" THEN                                     #FUN-D30032 mark
   IF p_ud <> "G" OR g_action_choice = "detail_b1" OR g_action_choice = "detail_b2" THEN  #FUN-D30032 add
      RETURN
   END IF
 
   LET g_action_choice = " "
 
    IF g_aza.aza63 = 'N' THEN
       CALL cl_set_act_visible("entry_sheet2", FALSE)
    ELSE
       CALL cl_set_act_visible("entry_sheet2", TRUE)
    END IF
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   DIALOG ATTRIBUTES(UNBUFFERED)                                           #FUN-A90003 Add
      
   DISPLAY ARRAY g_oob TO s_oob.* ATTRIBUTE(COUNT=g_rec_b)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         LET g_b_flag='1'                         #FUN-A90003 Add   
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()                  #No.FUN-550037
 
      AFTER DISPLAY                               #FUN-A90003 Add
        CONTINUE DIALOG                           #FUN-A90003 Add
        
      #FUN-D10057--add--str--
      ON ACTION payable_sel #雜項應收/待抵查詢
         LET g_action_choice="payable_sel"
         LET g_str="'",g_ooa.ooa01,"' 'payable_sel' '' "
         EXIT DIALOG
      #FUN-D10057--add--end--
   END DISPLAY                                    
   #FUN-A90003 Add--Begin
   DISPLAY ARRAY g_oob_d TO s_oob_d.* ATTRIBUTE(COUNT=g_rec_b2)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
         LET g_b_flag='2'                         #FUN-A90003 Add
 
      BEFORE ROW
         LET l_ac2 = ARR_CURR()
         CALL cl_show_fld_cont()                  
 
#      AFTER DISPLAY                              
#        CONTINUE DIALOG                           
        
      #FUN-D10057--add--str--
      ON ACTION payable_sel #雜項應收/待抵查詢
         LET g_action_choice="payable_sel"
         LET g_str="'",g_oob_d[l_ac].oob27_1,"' 'query' '' "
         EXIT DIALOG
      #FUN-D10057--add--end
   END DISPLAY                                    
   #FUN-A90003 Add--End
      ON ACTION page_info                 #FUN-CB0080 add
         LET g_action_flag = "page_info"  #FUN-CB0080 add
         EXIT DIALOG                      #FUN-CB0080 add
         
      ON ACTION insert
         LET g_action_choice="insert"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION query
         LET g_action_choice="query"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION delete
         LET g_action_choice="delete"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION modify
         LET g_action_choice="modify"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add

#FUN-A90003--Mark--Begin--# 
#      ON ACTION first
#         CALL t400_fetch('F')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#         ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION previous
#         CALL t400_fetch('P')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION jump
#         CALL t400_fetch('/')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION next
#         CALL t400_fetch('N')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#         IF g_rec_b != 0 THEN
#            CALL fgl_set_arr_curr(1)  ######add in 040505
#         END IF
#   	 ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
# 
#      ON ACTION last
#         CALL t400_fetch('L')
#         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
#           IF g_rec_b != 0 THEN
#         CALL fgl_set_arr_curr(1)  ######add in 040505
#           END IF
#	ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
#FUN-A90003--Mark--End--#

#FUN-A90003--Add--Begin--#
      ON ACTION first
         CALL t400_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count) 
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
         EXIT DIALOG
 
      ON ACTION previous
         CALL t400_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)
         END IF
	       EXIT DIALOG
 
      ON ACTION jump
         CALL t400_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
	       EXIT DIALOG
 
      ON ACTION next
         CALL t400_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
   	     EXIT DIALOG
 
      ON ACTION last
         CALL t400_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         IF g_rec_b != 0 THEN
            CALL DIALOG.setCurrentRow("s_oob",1)  
         END IF
	       EXIT DIALOG 
#FUN-A90003--Add--End--#

#No.FUN-B30057--Mark-BEGIN--
#     ON ACTION detail
#        LET g_action_choice="detail"
##       EXIT DISPLAY                       #FUN-A90003 Mark
#        EXIT DIALOG                        #FUN-A90003 Add
#        LET l_ac = 1
#No.FUN-B30057--Mark-END--
#No.FUN-B30057--add-BEGIN--
      ON ACTION detail_b1
         LET g_action_choice="detail_b1"
         EXIT DIALOG

      ON ACTION detail_b2
         LET g_action_choice="detail_b2"
         EXIT DIALOG
#No.FUN-B30057--add-END--
 
      ON ACTION output
         LET g_action_choice="output"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION help
         LET g_action_choice="help"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION exit
         LET g_action_choice="exit"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION controlg
         LET g_action_choice="controlg"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION void  #作廢
         LET g_action_choice="void"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
#FUN-D20035 add
      ON ACTION undo_void  #取消作廢
         LET g_action_choice="undo_void"
         EXIT DIALOG
#FUN-D20035 add     
      ON ACTION gen_entry #會計分錄產生
         LET g_action_choice="gen_entry"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION entry_sheet #分錄底稿
         LET g_action_choice="entry_sheet"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION entry_sheet2 #分錄底稿
         LET g_action_choice="entry_sheet2"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION memo  #備註
         LET g_action_choice="memo"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION easyflow_approval           #FUN-550049
         LET g_action_choice="easyflow_approval"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION carry_voucher #傳票拋轉
         LET g_action_choice="carry_voucher"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
    
      ON ACTION undo_carry_voucher #傳票拋轉還原
         LET g_action_choice="undo_carry_voucher"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
    
      ON ACTION confirm #確認
         LET g_action_choice="confirm"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION undo_confirm #取消確認
         LET g_action_choice="undo_confirm"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION agree
         LET g_action_choice = 'agree'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION deny
         LET g_action_choice = 'deny'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION modify_flow
         LET g_action_choice = 'modify_flow'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION withdraw
         LET g_action_choice = 'withdraw'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION org_withdraw
         LET g_action_choice = 'org_withdraw'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION phrase
         LET g_action_choice = 'phrase'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION accept
         #No.FUN-B30057--mod--str-- By luttb
         LET g_action_choice="detail"
         IF g_b_flag = '1' THEN
            LET g_action_choice="detail_b1"
         ELSE
            LET g_action_choice="detail_b2"
         END IF
         #No.FUN-B30057--mod--end
         LET l_ac = ARR_CURR()
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add

 
      ON ACTION cancel
             LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
         CALL t400_set_comb_oob04()         #FUN-A90003 Add  
         CALL t400_set_comb_oob04_1()       #FUN-A90003 Add
#        EXIT DISPLAY                       #FUN-A90003 Mark
         #FUN-C20018--add--begin
         IF g_prog ='axrt401' THEN 
            LET lwin_curr = ui.Window.getCurrent() 
            LET lfrm_curr = lwin_curr.getForm()
            LET lnode_Item = lfrm_curr.findNode("Group","group1")
            IF lnode_item IS NOT NULL THEN
               LET g_msg = cl_getmsg('axr117',g_lang)
               CALL lnode_item.setAttribute("text",g_msg)
            END IF
            LET lnode_Item = lfrm_curr.findNode("Group","group2")
            IF lnode_item IS NOT NULL THEN
               LET g_msg = cl_getmsg('axr118',g_lang)
               CALL lnode_item.setAttribute("text",g_msg)
            END IF
            #TQC-C20430--add--begin
            IF g_azw.azw04='2' THEN
               CALL cb.removeItem('1') 
               CALL cb.clear()
               LET g_msg = cl_getmsg('axr122',g_lang)
               CALL cb.addItem(1,g_msg)
            END IF
            #TQC-C20430--add--end
         END IF
         #FUN-C20018--add--end
         EXIT DIALOG                        #FUN-A90003 Add
 
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
#        CONTINUE DISPLAY                       #FUN-A90003 Mark
         CONTINUE DIALOG                        #FUN-A90003 Add 
         
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
  
      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION approval_status                    #FUN-550049
         LET g_action_choice="approval_status"
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
 
      ON ACTION related_document                #No.FUN-6B0042  相關文件
         LET g_action_choice="related_document"          
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add 
      &include "qry_string.4gl"
#No.FUN-A30106 --begin                                                          
      ON ACTION drill_down                                                      
         LET g_action_choice="drill_down"                                       
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add                                                           
#No.FUN-A30106 --end 

#FUN-A40076--Add--Begin
      ON ACTION adjust_charge                                                         
         LET g_action_choice="adjust_charge"                                       
#        EXIT DISPLAY                       #FUN-A90003 Mark
         EXIT DIALOG                        #FUN-A90003 Add
#FUN-A40076--Add--End
 
#  END DISPLAY                       #FUN-A90003 Mark
   END DIALOG                        #FUN-A90003 Add
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
FUNCTION t400_bp_refresh()
 
   IF g_bgjob = 'Y' THEN
      RETURN
   END IF
 
   DISPLAY ARRAY g_oob TO s_oob.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
   
      BEFORE DISPLAY
         EXIT DISPLAY
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
END FUNCTION
 
 
FUNCTION t400_out()
    DEFINE l_wc                LIKE type_file.chr1000   #No.FUN-680123  VARCHAR(100)
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    MENU ""
       ON ACTION brief_report_print
          CALL t400_out1()
 
       ON ACTION print_this_pay_slip
         #LET g_msg = "axrr400 '' '' '",g_lang,"' 'Y' '' '' ",  #FUN-C30085
          #No.FUN-BB0100  --Begin
          IF g_artype ='33' THEN
             #FUN-D10098--add--str--
             IF g_aza.aza26 = '2' THEN
                LET g_msg = "gxrg440 '' '' '",g_lang,"' 'Y' '' '' ",
                            "'ooa01 =\"",g_ooa.ooa01,"\"' 'g_ooa.ooaconf' "
             ELSE
             #FUN-D10098--add--end--
                LET g_msg = "axrg440 '' '' '",g_lang,"' 'Y' '' '' ", 
                         "'ooa01 =\"",g_ooa.ooa01,"\"' 'g_ooa.ooaconf' " 
             END IF   #FUN-D10098 add
          ELSE
             LET g_msg = "axrg400 '' '' '",g_lang,"' 'Y' '' '' ",  #FUN-C30085
                         "'ooa01 =\"",g_ooa.ooa01,"\"' 'g_ooa.ooaconf' " 
          END IF
          #No.FUN-BB0100  --End
          CALL cl_cmdrun(g_msg)
 
       ON ACTION exit
          EXIT MENU
 
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE MENU
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121

      ON ACTION cancel      #No.MOD-CC0005
         EXIT MENU          #No.MOD-CC0005
 
 
 
        -- for Windows close event trapped
        ON ACTION close   #COMMAND KEY(INTERRUPT) #FUN-9B0145  
             LET INT_FLAG=FALSE 		#MOD-570244	mars
            LET g_action_choice = "exit"
            EXIT MENU
 
    END MENU
END FUNCTION
 
FUNCTION t400_out1()
DEFINE
    l_i             LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
    sr              RECORD LIKE ooa_file.*,
    l_name          LIKE type_file.chr20,     #No.FUN-680123 VARCHAR(20),              #External(Disk) file name
    l_za05          LIKE type_file.chr1000    #No.FUN-680123 VARCHAR(40)               #
 
   DEFINE   l_gem02         LIKE gem_file.gem02
   DEFINE   l_aag02         LIKE aag_file.aag02
   DEFINE   l_n             LIKE type_file.num5
   DEFINE   l_ooa03         LIKE ooa_file.ooa03   #TQC-9C0179
   
   CALL cl_del_data(l_table)
   
#   SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = 'axrt400'
    SELECT zz05 INTO g_zz05 FROM zz_file WHERE zz01 = g_prog    #No.FUN-AA0088
    IF cl_null(g_wc) THEN LET g_wc = "ooa01 = '",g_ooa.ooa01,"'" END IF  #TQC-970232 
    CALL cl_wait()
    SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
    LET g_sql="SELECT * FROM ooa_file",
              " WHERE ",g_wc CLIPPED,
              "   AND ooa00 = '1' ",  #FUN-570099
              " ORDER BY 1"
    PREPARE t400_p1 FROM g_sql                # RUNTIME 編譯
    DECLARE t400_co                         # SCROLL CURSOR
        CURSOR FOR t400_p1
 
 
    FOREACH t400_co INTO sr.*
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        CALL s_get_bookno(YEAR(g_ooa.ooa02))                                                                               
        RETURNING g_flag,g_bookno1,g_bookno2                                                                          
        IF g_flag = '1' THEN     #抓不到帳別                                                                               
           CALL cl_err(g_ooa.ooa02,'aoo-081',1)                                                                            
        END IF                                                                                                             
            
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = sr.ooa23 
        SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01 = sr.ooa15
        SELECT aag02 INTO l_aag02 FROM aag_file WHERE aag01 = sr.ooa13
                                                  AND aag00 = g_bookno1  #FUN-C10024  
        SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01=sr.ooa23  
        
        LET l_n = l_n +1
        LET l_ooa03 = sr.ooa03[1,6]   #TQC-9C0179
        EXECUTE insert_prep USING
              sr.ooa01,sr.ooa02,l_ooa03,sr.ooa032,sr.ooa15,l_gem02,  #TQC-9C0179
              sr.ooa23,sr.ooa31d,sr.ooa32d,sr.ooa13,l_aag02,t_azi04,l_n         
    END FOREACH
 
    LET l_sql = "SELECT * FROM ",g_cr_db_str CLIPPED,l_table CLIPPED
    
    IF g_zz05 = 'Y' THEN 
       CALL cl_wcchp(g_str,'ooa01,ooa02,ooa03,ooa032,ooa14,ooa15,ooa23,     
                     ooa13,ooa33,ooa992,ooaconf,ooamksg,ooa34,ooa31d,
                     ooa31c,ooauser,ooagrup,ooamodu,ooadate,oob02,oob03,    #FUN-990031 del oob05
                     oob04,oob06,oob19,oob15,oob11,oob111,oob13,oob14,oob07,
                     oob08')
       RETURNING g_wc
    END IF
    
    LET l_str = g_wc,";",g_azi04
    
#    CALL cl_prt_cs3('axrt400','axrt400',l_sql,l_str)
    CALL cl_prt_cs3(g_prog,'axrt400',l_sql,l_str)   #No.FUN-AA0088
    CLOSE t400_co
    ERROR ""
END FUNCTION
 
FUNCTION t400_2()
   DEFINE  l_oap   RECORD LIKE oap_file.*
   DEFINE ls_tmp STRING
 
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    LET p_row = 10 LET p_col = 10
    OPEN WINDOW t4002_w AT p_row,p_col WITH FORM "axr/42f/axrt4002"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4002")
 
    LET g_buf=NULL
 
    LET g_action_choice="modify"
    IF NOT cl_chk_act_auth() THEN
       DISPLAY BY NAME g_ooa.ooaprsw,g_ooa.ooa20
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
       CLOSE WINDOW t4002_w
       RETURN
    END IF
    INPUT BY NAME      g_ooa.ooaprsw,g_ooa.ooa20
         WITHOUT DEFAULTS
 
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
   IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t4002_w RETURN END IF
   CLOSE WINDOW t4002_w
    UPDATE ooa_file SET * = g_ooa.* WHERE ooa01 = g_ooa.ooa01
    IF SQLCA.SQLCODE THEN
       CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","update ooa",1)  #No.FUN-660116
    END IF
END FUNCTION
 
FUNCTION t400_3()
 
   IF g_ooa.ooa01 IS NULL THEN
      RETURN
   END IF
 
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
 
   IF NOT cl_chk_act_auth() THEN
      LET g_chr='D'
   ELSE
      LET g_chr='U'
   END IF
 
   BEGIN WORK
   OPEN t400_cl USING g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN            
   END IF
   FETCH t400_cl INTO g_ooa.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0) 
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
   CALL s_showmsg_init()             #NO.FUN-710050   
   CALL s_fsgl('AR',3,g_ooa.ooa01,0,g_ooz.ooz02b,1,g_ooa.ooaconf,'0',g_ooz.ooz02p) #No.FUN-680022 add
   CALL s_showmsg()                  #NO.FUN-710050
 
   CLOSE t400_cl
   COMMIT WORK
 
END FUNCTION
 
FUNCTION t400_v()
   DEFINE l_wc    LIKE type_file.chr1000   #No.FUN-680123 VARCHAR(100)
   DEFINE l_ooa01 LIKE ooa_file.ooa01
   DEFINE l_t1    LIKE ooy_file.ooyslip,   #No.FUN-680123 VARCHAR(5),  #FUN-560095
          l_ooydmy1   LIKE ooy_file.ooydmy1,
          l_ooaconf   LIKE ooa_file.ooaconf
   DEFINE only_one         LIKE type_file.chr1      #No.FUN-680123  VARCHAR(1)
   DEFINE ls_tmp      STRING
   DEFINE l_cnt  LIKE type_file.num5                #MOD-C90151 add
 
   IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
   END IF
   #FUN-C30140---add----str---
   IF g_ooa.ooa34 matches '[Ss]' THEN
       CALL cl_err('','apm-030',0)
       RETURN
   END IF
   #FUN-C30140---add----end---
   LET p_row = 8 LET p_col = 11
   OPEN WINDOW t4009_w AT p_row,p_col WITH FORM "axr/42f/axrt4009"
    ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4009")
 
   LET only_one = '1'
   INPUT BY NAME only_one WITHOUT DEFAULTS
     AFTER FIELD only_one
      IF NOT cl_null(only_one) THEN
         IF only_one NOT MATCHES "[12]" THEN NEXT FIELD only_one END IF
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
   IF INT_FLAG THEN LET INT_FLAG = 0 CLOSE WINDOW t4009_w RETURN END IF
   IF only_one = '1'
      THEN LET l_wc = " ooa01 = '",g_ooa.ooa01,"' "
   ELSE
      CONSTRUCT BY NAME l_wc ON ooa01,ooa02,ooa15
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
           IF INT_FLAG THEN LET INT_FLAG=0 CLOSE WINDOW t4009_w RETURN END IF
   END IF
   IF NOT cl_null(g_ooz.ooz09) THEN
      LET g_sql = g_sql CLIPPED," AND ooa02 >'",g_ooz.ooz09,"'"
   END IF
   CLOSE WINDOW t4009_w
   MESSAGE "WORKING !"
   LET g_sql = "SELECT ooa01,ooa20,ooaconf FROM ooa_file WHERE ",l_wc CLIPPED,
               "   AND ooa00 = '1' "   #FUN-570099
   PREPARE t400_v_p FROM g_sql
   DECLARE t400_v_c CURSOR FOR t400_v_p
   LET g_success='Y' #no.5573
   BEGIN WORK  #no.5573
   CALL s_showmsg_init()              #NO.FUN-710050
   LET l_cnt = 0                      #MOD-C90151 add
   FOREACH t400_v_c INTO l_ooa01,g_chr,l_ooaconf
      IF STATUS THEN LET g_success = 'N' EXIT FOREACH END IF   #No.FUN-8A0086
      IF g_success='N' THEN                                                    
       LET g_totsuccess='N'                                                   
       LET g_success='Y' 
      END IF                                                     
      IF g_chr='N' THEN CONTINUE FOREACH END IF
      IF l_ooaconf = 'Y' THEN CONTINUE FOREACH END IF
    LET l_t1 = s_get_doc_no(l_ooa01)  #FUN-560095
    LET l_ooydmy1= ''
    SELECT ooydmy1 INTO l_ooydmy1 FROM ooy_file
     WHERE ooyslip = l_t1
    IF STATUS THEN 
       CALL s_errmsg('ooyslip',l_t1,'sel ooy',STATUS,0)            #NO.FUN-710050   #No.TQC-740094
    END IF
     IF l_ooydmy1 = 'Y' THEN
        IF l_cnt = 0 THEN                                   #MOD-C90151 add
          #------------------------MOD-CA0236--------------(S)
           LET l_cnt = 0
           SELECT COUNT(*) INTO l_cnt FROM npq_file
            WHERE npq01 = l_ooa01
              AND npq00= 3
              AND npqsys = 'AR'
              AND npq011 = 1
           IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
           IF l_cnt > 0 THEN
              IF NOT s_ask_entry(l_ooa01) THEN RETURN END IF
           END IF
          #------------------------MOD-CA0236--------------(E)
          #IF NOT s_ask_entry(l_ooa01) THEN RETURN END IF   #MOD-C90151 add #MOD-CA0236 mark
           CALL s_t400_gl(l_ooa01,'0')                      #No.FUN-670047 add
           IF g_aza.aza63='Y' THEN                          #No.FUN-670047 add
              CALL s_t400_gl(l_ooa01,'1')                   #No.FUN-670047 add
           END IF                                           #No.FUN-670047 add
           LET l_cnt = l_cnt + 1                            #MOD-C90151 add
        ELSE                                                #MOD-C90151 add
           CALL s_t400_gl(l_ooa01,'0')                      #MOD-C90151 add
           IF g_aza.aza63='Y' THEN                          #MOD-C90151 add
              CALL s_t400_gl(l_ooa01,'1')                   #MOD-C90151 add
           END IF                                           #MOD-C90151 add
        END IF                                              #MOD-C90151 add
     END IF
   END FOREACH
   IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
   END IF                                                                          
   CALL s_showmsg()               
   IF g_success='Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF #no.5573
   MESSAGE ""
END FUNCTION
 
FUNCTION t400_b_more()
  DEFINE l_ima25          LIKE ima_file.ima25   #No.FUN-680123  VARCHAR(4)
  DEFINE ls_tmp           STRING
    LET p_row = 12 LET p_col = 10
    OPEN WINDOW t4005_w AT p_row,p_col WITH FORM "axr/42f/axrt4005"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axrt4005")
 
    INPUT BY NAME b_oob.oob11,b_oob.oob111,b_oob.oob12,b_oob.oob13    #No.FUN-670047 add
                  WITHOUT DEFAULTS
    CLOSE WINDOW t4005_w                 #結束畫面
    IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
END FUNCTION
 
FUNCTION t400_m()
   IF g_ooa.ooa01 IS NULL THEN RETURN END IF
   IF NOT cl_chk_act_auth()
      THEN LET g_chr='d'
      ELSE LET g_chr='u'
   END IF
   CALL s_axm_memo(g_ooa.ooa01,0,g_chr)
END FUNCTION
 
FUNCTION t400_y_chk()                # when g_ooa.ooaconf='N' (Turn to 'Y')
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123  SMALLINT
   DEFINE l_oma00    LIKE oma_file.oma00   
   DEFINE l_apa00    LIKE apa_file.apa00   
   DEFINE l_sql      STRING               
   DEFINE l_oob      RECORD      
             oob03    LIKE oob_file.oob03,
             oob04    LIKE oob_file.oob04,
             oob06    LIKE oob_file.oob06
                     END RECORD  
   
   LET g_success = 'Y'
 
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
   IF g_ooa.ooaconf = 'X' THEN
     #CALL cl_err('','9024',0) #CHI-A80031 mark
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','9024',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
 
   IF g_ooa.ooaconf = 'Y' THEN
     #CALL cl_err('','axr-101',0) #CHI-A80031 mark
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr-101',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF

   #FUN-A40076-Add--Begin
    IF cl_null(g_ooa.ooa33d) THEN
       LET g_ooa.ooa33d = 0
    END IF
   #FUN-A40076-Add-End 
   IF g_ooa.ooa32d != g_ooa.ooa32c - g_ooa.ooa33d THEN   #FUN-A40076 Add g_ooa.ooa33d
     #CALL cl_err('','axr-203',0) #CHI-A80031 mark
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr-203',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
   #TQC-C20174--add--begin
   IF g_prog ='axrt401' THEN #TQC-C20269
      IF g_ooa.ooa40='01' THEN
         IF cl_null(g_ooz.ooz26) THEN
            CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr120',1)
            LET g_success = 'N'

         END IF
      ELSE
         IF cl_null(g_ooz.ooz30) THEN
            CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr121',1)
            LET g_success = 'N'

         END IF
      END IF
   END IF   #TQC-C20269
   #TQC-C20174--add--end

   #FUN-B50090 add begin-------------------------
   #重新抓取關帳日期
   SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
   #FUN-B50090 add -end-------------------------- 
   IF g_ooa.ooa02 <= g_ooz.ooz09 THEN
     #CALL cl_err('','axr-164',0) #CHI-A80031 mark
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr-164',1) #CHI-A80031
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
 
   IF g_ooa.ooaconf = 'Y' THEN
      LET g_success = 'N'
     #RETURN #CHI-A80031 mark
   END IF
 
   SELECT COUNT(*) INTO l_cnt FROM oob_file
    WHERE oob01 = g_ooa.ooa01
   IF l_cnt = 0 THEN
     #CALL cl_err('','mfg-009',0) #CHI-A80031 mark
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','mfg-009',1) #CHI-A80031
      LET g_success = 'N'                      #FUN-640246
     #RETURN #CHI-A80031 mark
   END IF
 
   #CHI-A80031 add --start--
   LET l_cnt = 0
   IF g_ooz.ooz62='Y' THEN
      SELECT COUNT(*) INTO l_cnt FROM oob_file
       WHERE oob01 = g_ooa.ooa01
         AND oob03 = '2'
         AND oob04 = '1'
         AND (oob06 IS NULL OR oob06 = ' ' OR oob15 IS NULL OR oob15 <= 0 )

      IF cl_null(l_cnt) THEN
         LET l_cnt = 0
      END IF

      IF l_cnt > 0 THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr-900',1)
         LET g_success = 'N'
      END IF
   END IF

   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM oob_file,oma_file
    WHERE oma02 > g_ooa.ooa02
      AND oob03 = '2'
      AND oob04 = '1'
      AND oob06 = oma01
      AND oob01 = g_ooa.ooa01

   IF l_cnt >0 THEN
      CALL s_errmsg('ooa01',g_ooa.ooa01,'','axr-371',1)
      LET g_success = 'N'
   END IF
   #CHI-A80031 add --end--

   LET l_sql = "SELECT oob03,oob04,oob06 FROM oob_file",
               " WHERE oob01 = '",g_ooa.ooa01,"'",
               "   AND ((oob03 = '1' AND (oob04='3' OR oob04='9'))",   
               "    OR  (oob03 = '2' AND (oob04='1' OR oob04='9')))"   
   PREPARE oob06_pb FROM l_sql
   DECLARE oob06_cl CURSOR FOR oob06_pb                                 
                        
   #FUN-B50090 add begin-------------------------
   #重新抓取關帳日期
   SELECT apz57 INTO g_apz.apz57 FROM apz_file WHERE apz00='0'
   #FUN-B50090 add -end--------------------------
   FOREACH oob06_cl INTO l_oob.*
      IF STATUS THEN 
        #CALL cl_err('Foreach:',STATUS,1) #CHI-A80031 mark
        #CALL s_errmsg('','','','Foreach',1) #CHI-A80031   #No.FUN-D40089   Mark
         CALL s_errmsg('ooa01',g_ooa.ooa01,'','Foreach',1) #No.FUN-D40089   Add 
         LET g_success = 'N'
        #EXIT FOREACH #CHI-A80031 mark
      END IF
  
      IF l_oob.oob03='1' THEN                         
         IF l_oob.oob04 = '3' THEN 
            SELECT oma00 INTO l_oma00 FROM oma_file
             WHERE oma01 = l_oob.oob06
            IF (l_oma00 != '21') AND (l_oma00 != '22') AND (l_oma00 != '23') AND
               (l_oma00 != '24') AND (l_oma00 != '25') AND (l_oma00 != '26') AND   #MOD-9B0046 add 25 #FUN-9C0061 add 26 
               (l_oma00 != '20') AND   #No.TQC-DA0003  Add
               (l_oma00 != '27') AND (l_oma00 != '28') THEN   #MOD-B70242 add 27,28
              #CALL cl_err(l_oob.oob06,'axr-992',0) #CHI-A80031 mark
              #CALL s_errmsg('',l_oob.oob06,'','axr-992',1) #CHI-A80031  #No.FUN-D40089   Mark
               CALL s_errmsg('',l_oob.oob06,g_ooa.ooa01,'axr-992',1)     #No.FUN-D40089   Add
               LET g_success = 'N'
              #EXIT FOREACH #CHI-A80031 mark
            END IF 
         END IF 
         IF l_oob.oob04 = '9' THEN 
           #-CHI-B20040-add-
            IF g_ooa.ooa02 <= g_apz.apz57 THEN   #立帳日期不可小於關帳日期
               CALL cl_err('','axr-084',1)
               LET g_errno='N' 
            END IF
           #-CHI-B20040-end-
            SELECT apa00 INTO l_apa00 FROM apa_file
             WHERE apa01 = l_oob.oob06 
               AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
            IF (l_apa00 != '11') AND (l_apa00 != '12') AND (l_apa00 != '15') AND (l_apa00 != '13') THEN   #MOD-A50047 add l_apa00!='13'
              #CALL cl_err(l_oob.oob06,'axr-993',0) #CHI-A80031 mark
              #CALL s_errmsg('',l_oob.oob06,'','axr-993',1) #CHI-A80031  #No.FUN-D40089   Mark
               CALL s_errmsg('',l_oob.oob06,g_ooa.ooa01,'axr-993',1)     #No.FUN-D40089   Add
               LET g_success = 'N'
              #EXIT FOREACH #CHI-A80031 mark
            END IF   
         END IF                
      END IF      
              
      IF l_oob.oob03='2' THEN
         IF l_oob.oob04 = '1' THEN 
            SELECT oma00 INTO l_oma00 FROM oma_file
             WHERE oma01 = l_oob.oob06
            IF (l_oma00 !='11') AND (l_oma00 !='12') AND
               (l_oma00 !='13') AND (l_oma00 !='14') AND (l_oma00 !='15') AND (l_oma00 !='17')   #FUN-9B0130 add 15  #TQC-A20009 add 17
               AND (l_oma00 !='10')  THEN         #yinhy131018 add 10 
              #CALL cl_err(l_oob.oob06,'axr-994',0) #CHI-A80031 mark
              #CALL s_errmsg('',l_oob.oob06,'','axr-994',1) #CHI-A80031  #No.FUN-D40089   Mark
               CALL s_errmsg('',l_oob.oob06,g_ooa.ooa01,'axr-994',1)     #No.FUN-D40089   Add
               LET g_success = 'N'
              #EXIT FOREACH #CHI-A80031 mark
            END IF 
         END IF 
         IF l_oob.oob04 = '9' THEN 
           #-CHI-B20040-add-
            IF g_ooa.ooa02 <= g_apz.apz57 THEN   #立帳日期不可小於關帳日期
               CALL cl_err('','axr-084',1)
               LET g_errno='N' 
            END IF
           #-CHI-B20040-end-
            SELECT apa00 INTO l_apa00 FROM apa_file
             WHERE apa01 = l_oob.oob06
               AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
#No.MOD-B50248 --begin
             IF l_apa00 NOT MATCHES '2*' THEN 
#            IF (l_apa00!='21') AND (l_apa00!='22') AND
#               (l_apa00!='23') AND (l_apa00!='24') AND (l_apa00!='25') THEN  #MOD-B20108 add 25
#No.MOD-B50248 --end
              #CALL cl_err(l_oob.oob06,'axr-995',0) #CHI-A80031 mark
              #CALL s_errmsg('',l_oob.oob06,'','axr-995',1) #CHI-A80031  #No.FUN-D40089   Mark
               CALL s_errmsg('',l_oob.oob06,g_ooa.ooa01,'axr-995',1)     #No.FUN-D40089   Add
               LET g_success = 'N'
              #EXIT FOREACH #CHI-A80031 mark
            END IF   
         END IF                    
      END IF    
   END FOREACH 

   #CHI-B10042 add --start--
   IF g_action_choice CLIPPED = "confirm"  #執行 "確認" 功能(非簽核模式呼叫)
      OR g_action_choice CLIPPED = "insert"  
   THEN
      IF g_action_choice="confirm" THEN 
         IF g_ooa.ooamksg='Y' THEN
            IF g_ooa.ooa34 NOT matches '[Ss1]' THEN
               CALL s_errmsg('ooa01',g_ooa.ooa01,'','aws-045',1)
               LET g_success = 'N'
            END IF
         END IF
      ELSE
         IF g_ooa.ooamksg='Y' THEN       #若簽核碼為 'Y' 且狀態碼不為 '1' 已同意
            IF g_ooa.ooa34 != '1' THEN
               CALL s_errmsg('ooa01',g_ooa.ooa01,'','aws-078',1)
               LET g_success = 'N'
            END IF
         END IF
      END IF
   END IF
   #CHI-B10042 add --end--
   #---------------------MOD-C30616--------------start
   IF g_ooy.ooydmy1='Y' THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM npq_file
       WHERE npq01 = g_ooa.ooa01
         AND npq011 =  1
         AND npqsys = 'AR'
         AND npq00 = 3
         AND npqtype = '0'
      IF l_cnt = 0 THEN
        #CALL s_errmsg('','','','aap-995',1)   #No.FUN-D40089   Mark
         CALL s_errmsg('ooa',g_ooa.ooa01,'','aap-995',1)   #No.FUN-D40089   Add
         LET g_success = 'N'
      END IF
   END IF
   #---------------------MOD-C30616----------------end

   IF g_success = 'N' THEN RETURN END IF

END FUNCTION
 
FUNCTION t400_y_upd()
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123  SMALLINT
   DEFINE only_one    LIKE type_file.chr1     #FUN-A40078
  
   LET g_success = 'Y'
   LET g_totsuccess='Y' #CHI-A80031 add
   LET only_one = '1'         #FUN-A40078                                       
   LET g_upd_ok = 0           #FUN-A40078
 
   IF g_action_choice CLIPPED = "confirm"  #執行 "確認" 功能(非簽核模式呼叫)
   OR g_action_choice CLIPPED = "insert"   #FUN-640246
   THEN
      #CHI-B10042 mark --start--
      #IF g_action_choice="confirm" THEN 
      #   IF g_ooa.ooamksg='Y' THEN
      #      IF g_ooa.ooa34 NOT matches '[Ss1]' THEN
      #            CALL cl_err('','aws-045',1)
      #            LET g_success = 'N'
      #            RETURN
      #      END IF
      #   END IF
      #ELSE
      #CHI-B10042 mark --end-- 
       IF g_action_choice CLIPPED = "insert"   THEN #CHI-B10042 add
         IF g_ooa.ooamksg='Y' THEN       #若簽核碼為 'Y' 且狀態碼不為 '1' 已同意
             IF g_ooa.ooa34 != '1' THEN
                CALL cl_err('','aws-078',1)
                LET g_success = 'N'
                RETURN
             END IF
         END IF
       END IF  #FUN-8A0075
#FUN-A40078 ---------------------------------------add 開窗詢問確認畫面---------------------------
       OPEN WINDOW t400_w6 AT 8,18 WITH FORM "axr/42f/axrt400_6"                
       ATTRIBUTE (STYLE = g_win_style)                                          
                                                                                
       CALL cl_ui_locale("axrt400_6")                                           
                                                                                
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
                                                                                
          ON ACTION about                                                       
             CALL cl_about()                                                    
                                                                                
          ON ACTION help                                                        
             CALL cl_show_help()                                                
                                                                                
          ON ACTION controlg                                                    
             CALL cl_cmdask()                                                   
       END INPUT                                                                
                                                                                
       IF INT_FLAG THEN                                                         
          LET INT_FLAG = 0                                                      
          LET g_success = 'N'                                                   
          CLOSE WINDOW t400_w6 
          RETURN    #No.FUN-AA0088                                                 
       END IF
#FUN-A40078 -----------------------------add end-------------------------------

#FUN-A40078 --------------------------mark start--------------------------------
#      IF NOT cl_confirm('axr-108') THEN
#         LET g_success = 'N'
#         RETURN
#      END IF #詢問是否執行確認功能
#FUN-A40078 -------------------------mark end----------------------------------
   END IF
 
#FUN-A40078 -------------------------add start--------------------------------
   IF only_one = '1' THEN                                                       
      LET g_wc = " ooa01 = '",g_ooa.ooa01,"' "                                  
   ELSE                                                                         
      CONSTRUCT BY NAME g_wc ON ooa01,ooa02,ooa03                               
                                                                                
        BEFORE CONSTRUCT                                                        
           CALL cl_qbe_init()                                                   
                                                                                
        ON ACTION CONTROLR                                                      
           CALL cl_show_req_fields()                                            
                                                                                
        ON ACTION CONTROLG CALL cl_cmdask()                                     
                                                                                
        ON IDLE g_idle_seconds                                                  
           CALL cl_on_idle()                                                    
           CONTINUE CONSTRUCT

        ON ACTION about                                                         
           CALL cl_about()                                                      
                                                                                
        ON ACTION help                                                          
           CALL cl_show_help()                                                  
                                                                                
        ON ACTION locale                                                        
           LET g_change_lang = TRUE                                             
           EXIT CONSTRUCT                                                       
                                                                                
        ON ACTION exit                            #加离开功能                   
            LET INT_FLAG = 1                                                    
            EXIT CONSTRUCT                                                      
                                                                                
        ON ACTION qbe_select                                                    
           CALL cl_qbe_select()                                                 
                                                                                
        ON ACTION qbe_save                                                      
           CALL cl_qbe_save() 

        ON ACTION CONTROLP                                                      
           CASE                                                                 
              WHEN INFIELD(ooa01)                                               
                CALL cl_init_qry_var()                                          
                LET g_qryparam.form = "q_ooa"
#No.FUN-AA0088 --begin
                IF g_prog ='axrt400' THEN 
                   LET g_qryparam.arg1 = "1"       #No.TQC-A90057  
                END IF                                   
                IF g_prog ='axrt401' THEN 
                   LET g_qryparam.arg1 = "3"       #No.TQC-A90057  
                END IF
#No.FUN-AA0088 --end 
                LET g_qryparam.state = "c"                                      
                CALL cl_create_qry() RETURNING g_qryparam.multiret              
                DISPLAY g_qryparam.multiret TO ooa01                            
                NEXT FIELD ooa01                                                
              WHEN INFIELD(ooa03)                                               
                 CALL cl_init_qry_var()                                         
                 LET g_qryparam.form = "q_occ11"                                
                 LET g_qryparam.state = "c"                                     
                 CALL cl_create_qry() RETURNING g_qryparam.multiret             
                 DISPLAY g_qryparam.multiret TO ooa03                           
                 NEXT FIELD ooa03                                               
           END CASE                                                             
                                                                                
       END CONSTRUCT
       
       IF INT_FLAG THEN                                                         
          LET INT_FLAG = 0                                                      
          CLOSE WINDOW t400_w6                                                  
       END IF                                                                   
   END IF 
#FUN-A40078 ---------------------------add end---------------------------------------

#CHI-A80031 移到chk段 mark --start--
#  IF g_ooz.ooz62='Y' THEN
#     #03/07/16 By Wiky #No:7616 oob15 = ' '為數值type,要拿掉oracle會產生錯!
#     SELECT COUNT(*) INTO l_cnt FROM oob_file
#      WHERE oob01 = g_ooa.ooa01
#        AND oob03 = '2'
#        AND oob04 = '1'
#        AND (oob06 IS NULL OR oob06 = ' ' OR oob15 IS NULL OR oob15 <= 0 )
#
#     IF cl_null(l_cnt) THEN
#        LET l_cnt = 0
#     END IF
#
#     IF l_cnt > 0 THEN
#        CALL cl_err('','axr-900',0)
#        LET g_success = 'N'
#        CLOSE t400_cl                    #MOD-A80144
#        CLOSE WINDOW t400_w6             #MOD-A80144
#        RETURN
#     END IF
#  END IF
#
#  LET g_cnt = 0
#
#  SELECT COUNT(*) INTO g_cnt
#    FROM oob_file,oma_file
#   WHERE oma02 > g_ooa.ooa02
#     AND oob03 = '2'
#     AND oob04 = '1'
#     AND oob06 = oma01
#     AND oob01 = g_ooa.ooa01
#
#  IF g_cnt >0 THEN
#     CALL cl_err(g_ooa.ooa01,'axr-371',1)
#     LET g_success = 'N'
#     CLOSE t400_cl                    #MOD-A80144
#     CLOSE WINDOW t400_w6             #MOD-A80144
#     RETURN
#  END IF
#CHI-A80031 移到chk段 mark --end--
 
#CHI-A80031 mark --start--
#  #---97/05/26 modify 檢查存在且平衡
#  IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'N' THEN  #No.FUN-670060
#     CALL s_chknpq(g_ooa.ooa01,'AR',1,'0',g_bookno1)       #No.FUN-730073
#     IF g_aza.aza63='Y' AND g_success='Y' THEN             #No.FUN-670047 add  #No.TQC-6C0072 add g_success
#        CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno2)    #No.TQC-740145 
#     END IF                                                #No.FUN-670047 add
#     LET g_dbs_new = s_dbstring(g_dbs CLIPPED)  #TQC-950020    
#  END IF
#
#  IF g_success = 'N' THEN
#     CLOSE t400_cl                    #MOD-A80144
#     CLOSE WINDOW t400_w6             #MOD-A80144
#     RETURN
#  END IF
#CHI-A80031 mark --end--

#FUN-A40078 ---------------------------add start--------------------------------
   IF g_action_choice CLIPPED = "confirm" #按「确认」时                         
   OR g_action_choice CLIPPED = "insert"                                        
   THEN                                                                         
      IF NOT cl_confirm('aap-222') THEN   #是否进行确认                         
          LET g_success = 'N'                                                   
          CLOSE WINDOW t400_w6                                                  
          RETURN                                                                
      END IF                                                                    
      IF only_one = '1' THEN           #CHI-C30107 add
         SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01 #CHI-C30107 add
         CALL t400_y_chk()                           #CHI-C30107 add
      END IF                                         #CHI-C30107 add
   END IF           
                                                                                
   CALL cl_msg("WORKING !")                                                     
   LET g_sql="SELECT * FROM ooa_file WHERE ",g_wc CLIPPED,                      
             "  AND ooaconf='N'",                                               
             "    AND (ooamksg = 'N' OR (ooamksg = 'Y' AND ooa34 = '1')) "      
   PREPARE t400_p3 FROM g_sql                                                   
   DECLARE t400_c3 CURSOR WITH HOLD FOR t400_p3                                 
  #CALL s_showmsg_init() #CHI-A80031 mark
#FUN-A40078 -------------------------add end--------------------------------------
 
   BEGIN WORK
 
   OPEN t400_cl USING g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      LET g_success = 'N'
      CLOSE t400_cl
      ROLLBACK WORK
      CLOSE WINDOW t400_w6             #MOD-A80144
      RETURN
   END IF
 
   FETCH t400_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       LET g_success = 'N'
       CLOSE t400_cl
       ROLLBACK WORK
       CLOSE WINDOW t400_w6             #MOD-A80144
       RETURN
   END IF
 
#FUN-A40078 ------------------------add start--------------------------
   LET g_ooa01_t = g_ooa.ooa01     #保留舊值 #CHI-A80031 add
   FOREACH t400_c3 INTO g_ooa.*                                                 
     #CHI-A80031 mark --start--
     #IF STATUS THEN                                                             
     #    LET g_success = 'N'                                                    
     #    CALL s_errmsg('','','t400_c3(foreach):',STATUS,1)                      
     #    EXIT FOREACH                                                           
     #END IF                                                                     
     #CHI-A80031 mark --end--                                                                                                                       
     LET g_t1=s_get_doc_no(g_ooa.ooa01)                                         
     SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
#FUN-A40078 ----------------------add end---------------------------------- 
     #CHI-A80031 add --start--
     CALL t400_y_chk()
     IF g_success='N' THEN
        LET g_totsuccess='N'
        LET g_success="Y"
        CONTINUE FOREACH
     END IF
     #CHI-A80031 add --end--

        LET g_ooa.ooa34 = '1'

      UPDATE ooa_file SET ooa34 = g_ooa.ooa34 WHERE ooa01 = g_ooa.ooa01
      IF STATUS THEN
         LET g_success = 'N'
         LET g_totsuccess='N' #CHI-A80031 add
      END IF
  
      CALL t400_y1()

     #CHI-A80031 add --start--
     IF g_success='N' THEN
        LET g_totsuccess='N'
        LET g_success="Y"
        CONTINUE FOREACH
     END IF
     #CHI-A80031 add --end--

      CALL t400_ins_oma()                 #FUN-A40076 Add
      CALL t401_ins_oma()
    #FUN-D70029--add--str--
    SELECT COUNT(*) INTO l_cnt FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03='1' AND oob04='H'
      AND oob06 IS NULL   #FUN-D80031 add
    IF l_cnt>0 THEN
       CALL t400_ins_oma_10()
    END IF
    #FUN-D70029--add--end
 
    #IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN #CHI-A80031 mark
     IF g_ooy.ooydmy1 = 'Y' THEN #CHI-A80031
          SELECT COUNT(*) INTO l_cnt FROM npq_file 
           WHERE npq01= g_ooa.ooa01
             AND npq00= 3  
             AND npqsys= 'AR'  
             AND npq011= 1
          IF l_cnt = 0 THEN
             CALL t400_gen_glcr(g_ooa.*,g_ooy.*)
          END IF
          IF g_success = 'Y' THEN 
             CALL s_chknpq(g_ooa.ooa01,'AR',1,'0',g_bookno1)       #No.FUN-730073
             IF g_aza.aza63='Y' AND g_success='Y' THEN             #No.FUN-670047 add  #No.TQC-6C0072 add g_success
                CALL s_chknpq(g_ooa.ooa01,'AR',1,'1',g_bookno2)    #No.TQC-740145
             END IF                                                #No.FUN-670047 add
             LET g_dbs_new = s_dbstring(g_dbs CLIPPED) #TQC-950020   
          END IF
          IF g_success = 'N' THEN 
           #CHI-A80031 mark --start--
           # ROLLBACK WORK   #No.TQC-810086
           # CLOSE t400_cl                      #MOD-A80144 
           # CLOSE WINDOW t400_w6               #MOD-A80144 
           # RETURN 
           #CHI-A80031 mark --end--
             CONTINUE FOREACH #CHI-A80031                         
          END IF  #No.FUN-670047
       END IF
 
#FUN-A40078 -----------------------------add start-------------------------
# 更新成功之後將本次確認單據筆數合計
       IF g_success = 'Y' THEN                                                    
            LET g_upd_ok = g_upd_ok +  1                                           
        END IF 
#FUN-A40078 ----------------------------add end-----------------------------

#CHI-A80031 程式搬移 mark --start--
#      IF g_success = 'Y' THEN
#         IF g_ooa.ooamksg = 'Y' THEN #簽核模式
#            CASE aws_efapp_formapproval()#呼叫 EF 簽核功能
#                 WHEN 0  #呼叫 EasyFlow 簽核失敗
#                      LET g_ooa.ooaconf="N"
#                      LET g_success = "N"
#                      ROLLBACK WORK
#                      CLOSE t400_cl                      #MOD-A80144 
#                      CLOSE WINDOW t400_w6               #MOD-A80144 
#                      RETURN
#                 WHEN 2  #當最後一關有兩個以上簽核者且此次簽核完成後尚未結案
#                      LET g_ooa.ooaconf="N"
#                      ROLLBACK WORK
#                      CLOSE t400_cl                      #MOD-A80144 
#                      CLOSE WINDOW t400_w6               #MOD-A80144 
#                      RETURN
#            END CASE
#         END IF
#         IF g_success='Y' THEN
#            LET g_ooa.ooa34='1'              #執行成功, 狀態值顯示為 '1' 已核准
#            LET g_ooa.ooaconf='Y'              #執行成功, 確認碼顯示為 'Y' 已確認
#           #DISPLAY BY NAME g_ooa.ooaconf     #MOD-A50200 mark      #別的視窗還沒關掉，在這邊顯示會有-1102的錯誤
#           #DISPLAY BY NAME g_ooa.ooa34       #MOD-A50200 mark
#            COMMIT WORK
#            CALL cl_flow_notify(g_ooa.ooa01,'Y')
#         ELSE
#             LET g_ooa.ooaconf='N'
#            LET g_success = 'N'
#            ROLLBACK WORK
#         END IF
#      ELSE
#         LET g_ooa.ooaconf='N'
#         LET g_success = 'N'
#         ROLLBACK WORK
#      END IF
#
#      CALL t400_b_fill('1=1')   #No.MOD-530820
#      CALL t400_b_fill_2('1=1') #FUN-A90003 Add
#
#      SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
#
#       IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
#       LET g_wc_gl = 'npp01 = "',g_ooa.ooa01,'" AND npp011 = 1'
#       LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_ooa.ooauser,"' '",g_ooa.ooauser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",g_ooa.ooa02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"     #No.TQC-810036
#       CALL cl_cmdrun_wait(g_str)
#       SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
#        WHERE ooa01 = g_ooa.ooa01
#       DISPLAY BY NAME g_ooa.ooa33
#    END IF
#    CLOSE t400_cl                     #FUN-A40078 
#CHI-A80031 程式搬移 mark --end--
  END FOREACH                          #FUN-A40078 
   #CHI-A80031 add --start--
   LET g_ooa.ooa01 = g_ooa01_t
   IF g_totsuccess="N" THEN                                                                                                         
      LET g_success="N"                                                                                                             
   END IF
   #CHI-A80031 add --end--
  
#FUN-A40078 --------------------add start---------------------------------------
  #CALL s_showmsg() #CHI-A80031 mark  
   IF g_action_choice CLIPPED = "confirm"  #执行 "确认" 功能(非签核模式呼叫)    
   OR g_action_choice CLIPPED = "insert"                                        
   THEN                                                                         
       CALL cl_getmsg('axr104',g_lang) RETURNING g_msg1                         
       CALL cl_getmsg('asf-489',g_lang) RETURNING g_msg2                        
       LET g_msg3 = g_msg1 CLIPPED,g_upd_ok,' ,',g_msg2                         
       IF cl_confirm(g_msg3) THEN                                               
          CLOSE WINDOW t400_w6                                                  
       ELSE                                                                     
          CLOSE WINDOW t400_w6                                                  
       END IF                                                                   
   END IF
#FUN-A40078 -----------------add end---------------------------------------------     

   #CHI-A80031 程式搬移 --start--
     IF g_success = 'Y' THEN
         IF g_ooa.ooamksg = 'Y' THEN #簽核模式
            CASE aws_efapp_formapproval()#呼叫 EF 簽核功能
                 WHEN 0  #呼叫 EasyFlow 簽核失敗
                      LET g_ooa.ooaconf="N"
                      LET g_success = "N"
                      LET g_totsuccess='N' #CHI-A80031 add
                      ROLLBACK WORK
                      CLOSE t400_cl                      #MOD-A80144 
                      CLOSE WINDOW t400_w6               #MOD-A80144 
                      RETURN
                 WHEN 2  #當最後一關有兩個以上簽核者且此次簽核完成後尚未結案
                      LET g_ooa.ooaconf="N"
                      LET g_totsuccess='N' #CHI-A80031 add
                      ROLLBACK WORK
                      CLOSE t400_cl                      #MOD-A80144 
                      CLOSE WINDOW t400_w6               #MOD-A80144 
                      RETURN
            END CASE
         END IF
         IF g_success='Y' THEN
            LET g_ooa.ooa34='1'              #執行成功, 狀態值顯示為 '1' 已核准
            LET g_ooa.ooaconf='Y'              #執行成功, 確認碼顯示為 'Y' 已確認
           #DISPLAY BY NAME g_ooa.ooaconf   #MOD-A50200 mark #別的視窗還沒關掉，在這邊顯示會有-1102的錯誤 
           #DISPLAY BY NAME g_ooa.ooa34     #MOD-A50200 mark 
            COMMIT WORK
            CALL t401_carry_voucher()        #No.FUN-AA0088
            CALL cl_flow_notify(g_ooa.ooa01,'Y')
         ELSE
            LET g_ooa.ooaconf='N'
            LET g_success = 'N'
            LET g_totsuccess='N' #CHI-A80031 add
            ROLLBACK WORK
         END IF
     ELSE
         LET g_ooa.ooaconf='N'
         LET g_success = 'N'
         LET g_totsuccess='N' #CHI-A80031 add
         ROLLBACK WORK
     END IF

     CALL t400_b_fill('1=1')   #No:MOD-530820
     CALL t400_b_fill_2('1=1') #FUN-A90003 Add

     SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01

     IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
        LET g_wc_gl = 'npp01 = "',g_ooa.ooa01,'" AND npp011 = 1'
        LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_ooa.ooauser,"' '",g_ooa.ooauser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooy.ooygslp,"' '",g_ooa.ooa02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"     #No.TQC-810036
        CALL cl_cmdrun_wait(g_str)
        SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
         WHERE ooa01 = g_ooa.ooa01
        DISPLAY BY NAME g_ooa.ooa33
     END IF
     CLOSE t400_cl  #FUN-A40078
   #CHI-A80031 程式搬移 --end--
  DISPLAY BY NAME g_ooa.ooaconf   #MOD-A50200 add                               
  DISPLAY BY NAME g_ooa.ooa34     #MOD-A50200 add
  IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
  IF g_ooa.ooa34='1' OR
     g_ooa.ooa34='2' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  IF g_ooa.ooa34='6' THEN LET g_chr3='Y' ELSE LET g_chr3='N' END IF
  CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"",g_chr3,g_chr,"")
 
END FUNCTION
 
FUNCTION t400_ef()
   CALL s_showmsg_init() #CHI-A80031 add
   CALL t400_y_chk()          #CALL 原確認段的 check 段後在執行送簽
   CALL s_showmsg()           #MOD-C10214 add
   IF g_success = "N" THEN
       RETURN
   END IF
  #CALL s_showmsg()            #CHI-A80031 add #MOD-C10214 mark 
   CALL aws_condition()#判斷送簽資料
   IF g_success = 'N' THEN
         RETURN
   END IF
##########
# CALL aws_efcli2()
# 傳入參數: (1)單頭資料, (2-6)單身資料
# 回傳值  : 0 開單失敗; 1 開單成功
##########
 
   IF aws_efcli2(base.TypeInfo.create(g_ooa),base.TypeInfo.create(g_oob),'','','','')
   THEN
      LET g_success = 'Y'
      LET g_ooa.ooa34 = 'S'
      DISPLAY BY NAME g_ooa.ooa34
   ELSE
      LET g_success = 'N'
   END IF
 
END FUNCTION
 
 
FUNCTION t400_z()                   # when g_ooa.ooaconf='Y' (Turn to 'N')
 DEFINE  l_n            LIKE type_file.num5      #No.FUN-680123 SMALLINT
 DEFINE  l_aba19        LIKE aba_file.aba19   #No.FUN-670060
 DEFINE  l_dbs          STRING                #No.FUN-670060
 DEFINE  l_sql          STRING                #No.FUN-670060
#DEFINE  l_oob06        LIKE oob_file.oob06   #MOD-A20006 add   #MOD-B60228 mark
#DEFINE  l_oma00        LIKE oma_file.oma00   #MOD-A20006 add   #MOD-B60228 mark
#DEFINE  l_oma19        LIKE oma_file.oma19   #MOD-A20006 add   #MOD-B60228 mark
#DEFINE  l_cnt          LIKE type_file.num5   #MOD-A20006 add   #MOD-B60228 mark
 
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01 = g_ooa.ooa01
 
   IF g_ooa.ooa34 = "S" THEN
      CALL cl_err("","mfg3557",0)
      RETURN
   END IF
 
   IF g_ooa.ooaconf='N' THEN RETURN END IF
   #FUN-C30029--add--str
   IF g_azw.azw04='2' AND g_ooa.ooa38<>'2' THEN
      CALL cl_err('','aap-829',0)
      RETURN
   END IF
   #FUN-C30029--add--end
 
   #FUN-B50090 add begin-------------------------
   #重新抓取關帳日期
   SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
   #FUN-B50090 add -end--------------------------
   IF g_ooa.ooa02<=g_ooz.ooz09 THEN CALL cl_err('','axr-164',0) RETURN END IF
   IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
   END IF
   IF NOT cl_null(g_ooa.ooa992) THEN
      CALL cl_err('','axr-950',1)
      LET g_success='N'
      RETURN
   END IF
 
 #str MOD-B60228 mark
 ##MOD-A20006---add---start---
 # LET l_cnt = 0
 # DECLARE oob06_cs CURSOR FOR SELECT oob06,oma19 FROM oob_file,oma_file 
 #                              WHERE oob01 = g_ooa.ooa01
 #                                AND oob03 = '2' AND oob04 = '1'
 #                                AND oob06 = oma01
 #                                AND oma00 = '11'
 #                                AND oma19 IS NOT NULL
 # FOREACH oob06_cs INTO l_oob06,l_oma19
 #    SELECT count(*) INTO l_cnt FROM oma_file
 #     WHERE oma00 = '12' AND oma19 = l_oma19
 #       AND omavoid = 'N'                   #MOD-AA0154
 #    IF l_cnt > 0 THEN
 #       CALL cl_err('','axr-078',1)
 #       LET g_success = 'N'
 #       RETURN
 #    END IF
 # END FOREACH
 ##MOD-A20006---add---end---
 #end MOD-B60228 mark

   #取消確認時，若單據別設為"系統自動拋轉總帳",則可自動拋轉還原
   CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1 
   SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
   IF NOT cl_null(g_ooa.ooa33) THEN
      IF NOT (g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y') THEN
         CALL cl_err(g_ooa.ooa01,'axr-370',0) RETURN
      END IF
   END IF
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN
      LET g_plant_new=g_ooz.ooz02p 
      #CALL s_getdbs() 
      #LET l_dbs=g_dbs_new
      #LET g_dbs_new = l_dbs_new
      #LET l_dbs=l_dbs.trimRight()                                                                                                    
      #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
      LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                  "  WHERE aba00 = '",g_ooz.ooz02b,"'",
                  "    AND aba01 = '",g_ooa.ooa33,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
      PREPARE aba_pre FROM l_sql
      DECLARE aba_cs CURSOR FOR aba_pre
      OPEN aba_cs
      FETCH aba_cs INTO l_aba19
      IF l_aba19 = 'Y' THEN
         CALL cl_err(g_ooa.ooa33,'axr-071',1)
         RETURN
      END IF
   END IF
 
   #FUN-D70029--add--str--
   SELECT COUNT(*) INTO l_n FROM oob_file
    WHERE oob01=g_ooa.ooa01 AND oob03='1' AND oob04='H'
#     AND oob06 IS NULL   #FUN-D80031 add  #TQC-D80042 mark
   IF l_n>0 THEN
      SELECT COUNT(*) INTO l_n FROM oma_file,oob_file
      WHERE oma01=oob06 AND oob03='1' AND oob04='H'
        AND (oma55>0 OR oma56>0) AND oob01=g_ooa.ooa01
        AND oma00 = '10'               #TQC-D80042 add
      IF l_n>0 THEN
         CALL cl_err(g_ooa.ooa01,'axr-207',1)
         RETURN
      END IF
   END IF
   #FUN-D70029--add--end

   IF NOT cl_confirm('axr-109') THEN RETURN END IF
   #-----97/05/26 modify 傳票編號不為空白,show警告訊息

   #CHI-C90052 add begin---
   IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' THEN
      LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooa.ooa33,"' 'Y'"
      CALL cl_cmdrun_wait(g_str)
      SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
       WHERE ooa01 = g_ooa.ooa01
      IF NOT cl_null(g_ooa.ooa33) THEN
         CALL cl_err(g_ooa.ooa33,'aap-929',1)
         RETURN
      END IF
      DISPLAY BY NAME g_ooa.ooa33
   END IF
   #CHI-C90052 add end-----
 
   BEGIN WORK LET g_success = 'Y'
   OPEN t400_cl USING g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t400_cl INTO g_ooa.*          # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
       CLOSE t400_cl ROLLBACK WORK RETURN
   END IF
   CALL t400_z1()
   
   CALL t400_del_oma()                 #FUN-A40076 Add
   CALL t401_del_oma()                 #No.FUN-AA0088 
 
   #FUN-D70029--add--str--
   SELECT COUNT(*) INTO l_n FROM oob_file
   WHERE oob01=g_ooa.ooa01 AND oob03='1' AND oob04='H'
#    AND oob06 IS NULL   #FUN-D80031 add #TQC-D80042  mark
   IF l_n>0 THEN
      CALL t400_del_oma_10()
   END IF
   #FUN-D70029--add--end

   UPDATE ooa_file SET ooa34 = '0' WHERE ooa01 = g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",STATUS,"","upd ooa",1)  #No.FUN-660116
      LET g_success='N'
   END IF
   CALL s_showmsg()                 #NO.FUN-710050
   IF g_success = 'Y' THEN
      LET g_ooa.ooaconf = 'N'
      LET g_ooa.ooa34 = "0"
      DISPLAY BY NAME g_ooa.ooaconf
      DISPLAY BY NAME g_ooa.ooa34
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF
 
   #CHI-C90052 mark begin---
   #IF g_ooy.ooydmy1 = 'Y' AND g_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
   #   LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooa.ooa33,"' 'Y'"
   #   CALL cl_cmdrun_wait(g_str)
   #   SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
   #    WHERE ooa01 = g_ooa.ooa01
   #   DISPLAY BY NAME g_ooa.ooa33
   #END IF
   #CHI-C90052 mark end-----
 
  IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
  IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
  CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
  CALL t400_show()  #TQC-750177
END FUNCTION
 
FUNCTION t400_y1()
   DEFINE n       LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_cnt   LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_flag  LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
 
   UPDATE ooa_file SET ooaconf = 'Y',ooa34 = '1' WHERE ooa01 = g_ooa.ooa01  #No.TQC-9C0057
   IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
     #CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)  #No.FUN-660116   #No.FUN-D40089   Mark
     #No.FUN-D40089 ---start--- Add
      IF g_bgerr THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,'',SQLCA.sqlcode,1)
      ELSE
         CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)
      END IF
      #No.FUN-D40089 ---end  --- Add
      LET g_success = 'N'
      RETURN
   END IF
 
   CALL t400_hu2()
 
   IF g_success = 'N' THEN
      RETURN
   END IF      #更新 ??/??
 
   DECLARE t400_y1_c CURSOR FOR SELECT * FROM oob_file
                                 WHERE oob01 = g_ooa.ooa01
                                 ORDER BY oob02
 
   LET l_cnt = 1
   LET l_flag = '0'
  #CALL s_showmsg_init()                     #NO.FUN-710050 #CHI-A80031 mark
   FOREACH t400_y1_c INTO b_oob.*         
      IF STATUS THEN
         CALL s_errmsg('oob01',g_ooa.ooa01,'y1 foreach',STATUS,1)  #NO.FUN-710050
         LET g_success = 'N'
         RETURN
      END IF 
       IF g_success='N' THEN                                                    
         LET g_totsuccess='N'                                                   
         LET g_success='Y' 
       END IF                                                     
 
      IF l_flag = '0' THEN
         LET l_flag = b_oob.oob03
      END IF
 
      IF l_flag != b_oob.oob03 THEN
         LET l_cnt = l_cnt + 1
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '1' THEN
         CALL t400_bu_11('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '2' THEN
         CALL t400_bu_12('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '3' THEN
         CALL t400_bu_13('+')
      END IF
 
      IF b_oob.oob03 = '1' AND b_oob.oob04 = '9' THEN
         CALL t400_bu_19('+')
      END IF

     #No.TQC-DA0003 ---Mark--- Start
     ##FUN-D80031 ------ add ---- begin
#    #IF b_oob.oob03 = '1' AND b_oob.oob04 = 'H' THEN  #TQC-D80042 mark
     #IF b_oob.oob03 = '1' AND b_oob.oob04 = 'H' AND NOT cl_null(b_oob.oob06) THEN #TQC-D80042 add
     #   CALL t400_bu_20('+')
     #END IF
     ##FUN-D80031 ------ add ---- end
     #No.TQC-DA0003 ---Mark--- End
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '1' THEN
         CALL t400_bu_21('+')
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '9' THEN
         CALL t400_bu_19('+')
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
         CALL t400_bu_22('+',l_cnt)
      END IF
 
      IF b_oob.oob03 = '2' AND b_oob.oob04 = 'C' THEN
         CALL t400_bu_2C('+')
      END IF
 
      LET l_cnt = l_cnt + 1
 
   END FOREACH
  IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
  END IF                                                                          
 
   SELECT COUNT(*) INTO n FROM oob_file
    WHERE oob01 = g_ooa.ooa01
      AND oob04 = '9'
 
   IF n > 0 THEN
      CALL ins_apf()
   END IF
   #--------------------------------------------------------------------
  #CALL s_showmsg()     #No.TQC-740094 #CHI-A80031 mark
 
END FUNCTION
 
FUNCTION t400_z1()
   DEFINE n      LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_cnt  LIKE type_file.num5      #No.FUN-680123 SMALLINT
   DEFINE l_flag LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)
#No.TQC-B90160 --begin
#No.MOD-B90075 --begin
    UPDATE ooa_file SET ooaconf = 'N',ooa34 = '0' WHERE ooa01 = g_ooa.ooa01  #No.TQC-9C0057
    IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
       CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)  #No.FUN-660116
       LET g_success = 'N'
       RETURN
    END IF
#No.MOD-B90075 --end
#No.TQC-B90160 --end
 
   #因為在s_g_np時, 會取apf_file已確認的資料, 故在此應先將之還原
   SELECT COUNT(*) INTO n FROM oob_file
     WHERE oob01 = g_ooa.ooa01 AND oob04='9'
   IF n>0 THEN
      UPDATE apf_file SET apf41 = 'N' WHERE apf01 = g_ooa.ooa01
      IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_err3("upd","apf_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd apf41",1)  #No.FUN-660116
         LET g_success = 'N' 
         RETURN 
      END IF
   END IF
 
   DECLARE t400_z1_c CURSOR FOR
         SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 ORDER BY oob02
   LET l_cnt = 1
   LET l_flag = '0'
   CALL s_showmsg_init()                #NO.FUN-710050
   FOREACH t400_z1_c INTO b_oob.*
    IF STATUS THEN
       CALL s_errmsg('oob01',g_ooa.ooa01,'z1 foreach',STATUS,1) 
       LET g_success = 'N' RETURN 
    END IF
    IF g_success='N' THEN                                                    
      LET g_totsuccess='N'                                                   
      LET g_success='Y' 
    END IF                                                     
    IF l_flag = '0' THEN LET l_flag = b_oob.oob03 END IF
    IF l_flag != b_oob.oob03 THEN
       LET l_cnt = l_cnt + 1
    END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '1' THEN CALL t400_bu_11('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '2' THEN CALL t400_bu_12('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '3' THEN CALL t400_bu_13('-') END IF
    IF b_oob.oob03 = '1' AND b_oob.oob04 = '9' THEN CALL t400_bu_19('-') END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '1' THEN CALL t400_bu_21('-') END IF
   #No.TQC-DA0003 ---Mark--- Start
   # #FUN-D80031 ------ add ---- begin
#  #IF b_oob.oob03 = '1' AND b_oob.oob04 = 'H' THEN  #TQC-D80042 mark
   #IF b_oob.oob03 = '1' AND b_oob.oob04 = 'H' AND NOT cl_null(b_oob.oob06) THEN #TQC-D80042 add
   #    CALL t400_bu_20('-')
   #END IF
   # #FUN-D80031 ------ add ---- end
   #No.TQC-DA0003 ---Mark--- End
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '9' THEN CALL t400_bu_19('-') END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
       CALL t400_bu_22('-',l_cnt)
    END IF
    IF b_oob.oob03 = '2' AND b_oob.oob04 = 'C' THEN CALL t400_bu_2C('-') END IF
    LET l_cnt = l_cnt + 1
   END FOREACH
   IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
   END IF                                                                          
   #---------------------------------- 970124 roger A/P對沖->需自動刪除apf,g,h
   #No.B184 010502 by plum mod 只要類別為9,就都INS AP:apf,g,h
   SELECT COUNT(*) INTO n FROM oob_file
     WHERE oob01 = g_ooa.ooa01 AND oob04='9'
   IF n>0 THEN CALL del_apf() END IF
   #--------------------------------------------------------------------
#No.TQC-B90160 --begin
#No.MOD-B90075 --begin
#  UPDATE ooa_file SET ooaconf = 'N',ooa34 = '0' WHERE ooa01 = g_ooa.ooa01  #No.TQC-9C0057
#  IF STATUS OR SQLCA.sqlerrd[3] = 0 THEN
#     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooaconf",1)  #No.FUN-660116
#     LET g_success = 'N'
#     RETURN
#  END IF
#No.MOD-B90075 --end
#No.TQC-B90160 --end

END FUNCTION
 
FUNCTION t400_hu2()            #最近交易日
   DEFINE l_occ RECORD LIKE occ_file.*
   SELECT * INTO l_occ.* FROM occ_file WHERE occ01=g_ooa.ooa03
   IF STATUS THEN 
      CALL cl_err3("sel","occ_file",g_ooa.ooa03,"",STATUS,"","s ccc",1)  #No.FUN-660116
      LET g_success='N' 
      RETURN 
   END IF
   IF l_occ.occ16 IS NULL THEN LET l_occ.occ16=g_ooa.ooa02 END IF
   IF l_occ.occ174 IS NULL OR l_occ.occ174 < g_ooa.ooa02 THEN
      LET l_occ.occ174=g_ooa.ooa02
   END IF
   UPDATE occ_file SET * = l_occ.* WHERE occ01=g_ooa.ooa03
  IF STATUS THEN 
     CALL cl_err3("upd","occ_file",g_ooa.ooa03,"",SQLCA.sqlcode,"","u ccc",1)  #No.FUN-660116
     LET g_success='N' 
     RETURN
   END IF
END FUNCTION
 
FUNCTION t400_bu_11(p_sw)                   #更新應收票據檔 (nmh_file)
  DEFINE p_sw       LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),            # +:更新 -:還原
       l_nmh17      LIKE  nmh_file.nmh17,
       l_nmh38      LIKE  nmh_file.nmh38
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE l_amt1,l_amt2 LIKE nmg_file.nmg25    #No.MOD-910126
 
  #95/12/14 by danny 確認時,判斷此參考單號之單據是否已確認
  SELECT nmh17,nmh38 INTO l_nmh17,l_nmh38 FROM nmh_file WHERE nmh01=b_oob.oob06
  IF STATUS THEN LET l_nmh38 = 'N' END IF
  IF l_nmh38 != 'Y' THEN
    #CALL s_errmsg('nmh01',b_oob.oob06,' ','axr-194',1)   #NO.FUN-710050   #No.FUN-D40089   Mark
     CALL s_errmsg('nmh01',b_oob.oob06,g_ooa.ooa01,'axr-194',1)   #NO.FUN-710050
  END IF
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz59 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     CALL s_g_np('4','1',b_oob.oob06,b_oob.oob15) RETURNING tot3
  ELSE
    SELECT nmh32 INTO l_amt1 FROM nmh_file WHERE nmh01 = b_oob.oob06
    IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF 
    CALL cl_digcut(l_amt1,g_azi04) RETURNING l_amt1
    SELECT SUM(oob10) INTO l_amt2 FROM oob_file,ooa_file 
     WHERE ooa01 = oob01 AND ooaconf = 'Y' AND oob03 = '1' AND oob04 = '1'
       AND oob06 = b_oob.oob06
    IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
    LET tot3 = l_amt1 - l_amt2
    IF cl_null(tot3) THEN LET tot3 = 0 END IF
  END IF
 
  #@@@
  IF p_sw = '-' THEN
     UPDATE nmh_file SET nmh17=nmh17-b_oob.oob09 ,nmh40 = tot3
      WHERE nmh01= b_oob.oob06
     IF STATUS THEN
       #CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17',STATUS,1)          #NO.FUN-710050  #No.FUN-D40089   Mark
        CALL s_errmsg('nmh01',b_oob.oob06,g_ooa.ooa01,STATUS,1)      #No.FUN-D40089   Add
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
       #CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17','axr-198',1) LET g_success = 'N' RETURN      #NO.FUN-710050   #No.FUN-D40089   Mark
        CALL s_errmsg('nmh01',b_oob.oob06,g_ooa.ooa01,'axr-198',1) LET g_success = 'N' RETURN      #No.FUN-D40089   Add
     END IF
  END IF
  IF p_sw = '+' THEN
     UPDATE nmh_file SET nmh17=nmh17+b_oob.oob09 ,nmh40 = tot3
      WHERE nmh01= b_oob.oob06
     IF STATUS THEN
       #CALL s_errmsg('nmh01',b_oob.oob06,'unp nmh17',STATUS,1)     #NO.FUN-710050   #No.FUN-D40089   Mark
        CALL s_errmsg('nmh01',b_oob.oob06,g_ooa.ooa01,STATUS,1)     #No.FUN-D40089   Add
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
       #CALL s_errmsg('nmh01',b_oob.oob06,'upd nmh17','axr-198',1)  LET g_success = 'N' RETURN    #NO.FUN-710050  #No.FUN-D40089   Mark
        CALL s_errmsg('nmh01',b_oob.oob06,g_ooa.ooa01,'axr-198',1)  LET g_success = 'N' RETURN    #NO.FUN-D40089   Add
     END IF
  END IF
END FUNCTION
 
FUNCTION t400_bu_12(p_sw)             #更新TT檔 (nmg_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_nmg23        LIKE nmg_file.nmg23
  DEFINE l_nmg24        LIKE nmg_file.nmg24,
         l_nmg25        LIKE nmg_file.nmg25,        #bug NO:A053 by plum
         l_nmgconf      LIKE nmg_file.nmgconf,
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  DEFINE tot1,tot3,tot2 LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013 #bug NO:A053 by plum
  DEFINE l_nmz20        LIKE nmz_file.nmz20
  DEFINE l_str          STRING                      #FUN-640246
 
  LET l_str = "bu_12:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04
  CALL cl_msg(l_str) 
 
##No.2724 modify 1998/11/05 確認時,判斷此參考單號之單據是否已確認
  LET l_nmgconf = ' '
  SELECT nmg25,nmgconf INTO l_nmg25,l_nmgconf
    FROM nmg_file WHERE nmg00= b_oob.oob06
  IF STATUS THEN LET l_nmgconf= 'N' END IF
  IF l_nmgconf != 'Y' THEN
    #CALL s_errmsg('nmg00',b_oob.oob06,'','axr-194',1)  LET g_success = 'N' RETURN    #NO.FUN-710050  #No.FUN-D40089   Mark
     CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,'axr-194',1)  LET g_success = 'N' RETURN    #No.FUN-D40089   Add
  END IF
  IF cl_null(l_nmg25) THEN LET l_nmg25=0 END IF   #bug NO:A053 by plum
##--------------------------------------------------
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  SELECT COUNT(*) INTO l_cnt FROM oob_file
          WHERE oob01=b_oob.oob01
            AND oob02<b_oob.oob02
            AND oob03='1'
            AND oob04='2'
            AND oob06=b_oob.oob06
  IF l_cnt>0 THEN RETURN END IF
 
  LET tot1 = 0 LET tot2 = 0  #bug NO:A053 by plum
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
          WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
            AND oob03='1'         AND oob04 = '2'
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF    #bug no:A053 by plum
  SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz20 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     CALL s_g_np('3','',b_oob.oob06,b_oob.oob15) RETURNING tot3
  ELSE
     LET tot3 = 0
  END IF
 
  IF p_sw = '-' THEN
     UPDATE nmg_file SET nmg24 = tot1, nmg10 = tot3
      WHERE nmg00= b_oob.oob06
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24',SQLCA.SQLCODE,0)      #NO.FUN-710050  #No.FUN-D40089   Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,SQLCA.SQLCODE,0)      #No.FUN-D40089   Add
       RETURN
    END IF
    RETURN
  END IF
  LET l_nmg24 =0
  SELECT nmg23,nmg23-nmg24 INTO l_nmg23,l_nmg24
    FROM nmg_file WHERE nmg00= b_oob.oob06
    IF STATUS THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'sel nmg24',STATUS,1)   #NO.FUN-710050  #No.FUN-D40089  Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,STATUS,1)   #No.FUN-D40089  Add
       LET g_success = 'N' 
       RETURN
    END IF
    IF l_nmg24 = 0  THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'nmg24=0','axr-185',1) LET g_success='N' RETURN             #NO.FUN-710050  #No.FUN-D40089   Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,'axr-185',1) LET g_success='N' RETURN           #No.FUN-D40089   Add
    END IF
# check 是否沖過頭了 ------------
    IF tot1>l_nmg23  THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'','axr-258',1) LET g_success='N' RETURN    #NO.FUN-710050  #No.FUN-D40089   Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,'axr-258',1) LET g_success='N' RETURN      #No.FUN-D40089   Add
    END IF
    UPDATE nmg_file SET nmg24=tot1, nmg10 = tot3
     WHERE nmg00= b_oob.oob06
    IF STATUS THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24',STATUS,1)      #NO.FUN-710050   #NoF.FUN-D40089   Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,STATUS,1)      #NoF.FUN-D40089   Add
       LET g_success = 'N' 
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
      #CALL s_errmsg('nmg00',b_oob.oob06,'upd nmg24','axr-198',1) LET g_success = 'N' RETURN  #NO.FUN-710050  #No.FUN-D40089   Mark
       CALL s_errmsg('nmg00',b_oob.oob06,g_ooa.ooa01,'axr-198',1) LET g_success = 'N' RETURN  #No.FUN-D40089   Mark
    END IF
END FUNCTION
 
FUNCTION t400_bu_13(p_sw)                  #更新待抵帳款檔 (oma_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_omaconf      LIKE oma_file.omaconf,   #No.FUN-680123 VARCHAR(1),            #
         l_omavoid      LIKE oma_file.omavoid,   #No.FUN-680123 VARCHAR(1),
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  DEFINE l_oma00        LIKE oma_file.oma00,
         l_oma55        LIKE oma_file.oma55,     #No.MOD-B80122 add
         l_oma57        LIKE oma_file.oma57      #No.MOD-B80122 add
  DEFINE tot4,tot4t     LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #TQC-5B0171
  DEFINE tot5,tot6      LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #No.FUN-680022 add
  DEFINE tot8           LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #No.FUN-680022 add
  DEFINE l_omc10        LIKE omc_file.omc10,#No.FUN-680022 add
         l_omc11        LIKE omc_file.omc11,#No.FUN-680022 add
         l_omc13        LIKE omc_file.omc13 #No.FUN-680022 add
 
   IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      DISPLAY "bu_13:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
   END IF
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  SELECT COUNT(*) INTO l_cnt FROM oob_file
          WHERE oob01=b_oob.oob01
            AND oob02<b_oob.oob02
            AND oob03='1'
            AND oob04='3'  #No.9047 add
            AND oob06=b_oob.oob06
  IF l_cnt>0 THEN RETURN END IF
 
 #預防在收款沖帳確認前,多沖待抵貨款
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
   WHERE oob06=b_oob.oob06 AND oob01=ooa01
     AND oob03='1'  AND oob04 = '3' AND ooaconf='Y'     #No:9638
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  IF p_sw='+' THEN
     SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND oob19=b_oob.oob19
        AND oob03='1'  AND oob04 = '3' AND ooaconf='Y'     #No:9638
       IF cl_null(tot5) THEN LET tot5 = 0 END IF
       IF cl_null(tot6) THEN LET tot6 = 0 END IF
  END IF
 
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-560077 #No.CHI-6A0004
  CALL cl_digcut(tot1,t_azi04) RETURNING tot1    #No.CHI-6A0004
  CALL cl_digcut(tot2,g_azi04) RETURNING tot2    #No.CHI-6A0004
 
 #LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t ",                  #No.MOD-B80122 mark
  LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t,oma55,oma57 ",      #No.MOD-B80122 add 
            #"  FROM ",g_dbs_new CLIPPED,"oma_file",
            #"  FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
            "  FROM oma_file ", #FUN-A50102
            " WHERE oma01=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t400_bu_13_p1 FROM g_sql
  DECLARE t400_bu_13_c1 CURSOR FOR t400_bu_13_p1
  OPEN t400_bu_13_c1 USING b_oob.oob06
 #FETCH t400_bu_13_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2                          #No.MOD-B80122 mark
  FETCH t400_bu_13_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2,l_oma55,l_oma57          #No.MOD-B80122 add
    IF p_sw='+' AND l_omavoid='Y' THEN
       CALL s_errmsg('ooa01',g_ooa.ooa01,'b_oob.oob06','axr-103',1) LET g_success = 'N' RETURN #NO.FUN-710050 #No.FUN-D40089 Mod ' ',' ' --> 'ooa01',g_ooa.ooa01
    END IF
    IF p_sw='+' AND l_omaconf='N' THEN
       CALL s_errmsg('ooa01',g_ooa.ooa01,'b_oob.oob06','axr-104',1) LET g_success = 'N' RETURN   #NO.FUN-710050 #No.FUN-D40089 Mod ' ',' ' --> 'ooa01',g_ooa.ooa01
    END IF
    IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
    IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
    #取得衝帳單的待扺金額
    CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4      #No.CHI-6A0004
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t    #No.CHI-6A0004
 
    IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
       IF p_sw='+' AND (un_pay1 < tot1+tot4 OR un_pay2 < tot2+tot4t) THEN   #TQC-5B0171
       CALL s_errmsg('ooa01',g_ooa.ooa01,'un_pay<pay#1','axr-196',1) LET g_success = 'N' RETURN   #NO.FUN-710050 #No.FUN-D40089 Mod ' ',' ' --> 'ooa01',g_ooa.ooa01
       END IF
    END IF
 
 #--------------------------------No.MOD-B80122----------------------------start
  IF l_oma00 = '23' THEN
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf <> 'X'  #MOD-BB0149 add ooaconf <> 'X'  
        AND oob03='1'  AND oob04 = '3' 
        AND ooa01=g_ooa.ooa01
      IF cl_null(tot1) THEN LET tot1 = 0 END IF
      IF cl_null(tot2) THEN LET tot2 = 0 END IF
  ELSE
#--------------------------------No.MOD-B80122-----------------------------end
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01  AND ooaconf = 'Y'
        AND oob03='1'  AND oob04 = '3'
     IF cl_null(tot1) THEN LET tot1 = 0 END IF
     IF cl_null(tot2) THEN LET tot2 = 0 END IF
     LET l_oma55 = 0  #MOD-BB0149
     LET l_oma57 = 0  #MOD-BB0149
  END IF                                  #No.MOD-B80122 add
    	
  IF p_sw='+' THEN
     SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND oob19=b_oob.oob19
        AND ooaconf = 'Y' AND oob03='1'  AND oob04 = '3'
     IF cl_null(tot5) THEN LET tot5 = 0 END IF
     IF cl_null(tot6) THEN LET tot6 = 0 END IF
     
     SELECT omc10,omc11,omc13 INTO l_omc10,l_omc11,l_omc13 FROM omc_file 
      WHERE omc01=b_oob.oob06 AND omc02 = b_oob.oob19
     IF cl_null(l_omc10) THEN LET l_omc10=0 END IF
     IF cl_null(l_omc11) THEN LET l_omc11=0 END IF
     IF cl_null(l_omc13) THEN LET l_omc13=0 END IF
   #---------------------------No.MOD-B80122-----------------start
     LET tot1 = tot1 + l_oma55
     LET tot2 = tot2 + l_oma57
  ELSE
#No.MOD-B90075 --begin 
    #-MOD-BB0149-mark-
    #SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
    # WHERE oob06=b_oob.oob06 AND oob01=ooa01  AND ooa01 = g_ooa.ooa01   
    #   AND oob03='1'  AND oob04 = '3'
    #IF cl_null(tot1) THEN LET tot1 = 0 END IF
    #IF cl_null(tot2) THEN LET tot2 = 0 END IF
#No.MOD-B90075 --end
    #LET tot1 = l_oma55 - tot1   
    #LET tot2 = l_oma57 - tot2 
    #-MOD-BB0149-add-
     IF l_oma00 = '23' THEN 
        LET tot1 = un_pay1 - tot1 
        LET tot2 = un_pay2 - tot2
     END IF
    #-MOD-BB0149-end-
   #-------------------------- No.MOD-B80122-------------------end
  END IF
 
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       CALL s_g_np('1',l_oma00,b_oob.oob06,0          ) RETURNING tot3
       LET tot3 = tot3 - tot4t
    ELSE
       LET tot3 = un_pay2 - tot2 - tot4t
    END IF
    #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"oma_file SET oma55=?,oma57=?,oma61=? ",
    #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
    LET g_sql="UPDATE oma_file ", #FUN-A50102
                " SET oma55=?,oma57=?,oma61=? ",
              " WHERE oma01=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
    PREPARE t400_bu_13_p2 FROM g_sql
    LET tot1 = tot1 + tot4
    LET tot2 = tot2 + tot4t
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1        #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2        #No.CHI-6A0004
    EXECUTE t400_bu_13_p2 USING tot1, tot2, tot3, b_oob.oob06  #NO.A048
    IF STATUS THEN
       CALL s_errmsg('oma01',b_oob.oob06,g_ooa.ooa01,STATUS,1)    #NO.FUN-710050   #No.FUN-D40089 Mod 'upd oma55,57' --> g_ooa.ooa01
       LET g_success = 'N' 
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
       CALL s_errmsg('oma01',b_oob.oob06,g_ooa.ooa01,'axr-198',1) LET g_success = 'N' RETURN   #NO.FUN-710050 #No.FUN-D40089 Mod 'upd oma55,57' --> g_ooa.ooa01
    END IF
    IF SQLCA.sqlcode = 0 THEN
      #CALL t400_omc(l_oma00)   #No.MOD-930140   #No.MOD-B80122 mark
       CALL t400_omc(l_oma00,p_sw)   #No.MOD-B80122 add
    END IF
END FUNCTION
 
FUNCTION t400_bu_19(p_sw)                   #更新 A/P 檔 (apa_file)
  DEFINE p_sw        LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_apa       RECORD LIKE apa_file.*
  DEFINE l_apc       RECORD LIKE apc_file.*   #No.FUN-680022 add
  DEFINE l_apz27     LIKE apz_file.apz27
  DEFINE l_tot       LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
 
  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
     DISPLAY "bu_11:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
  END IF
 
  SELECT * INTO l_apa.* FROM apa_file WHERE apa01=b_oob.oob06
                                        AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
  IF STATUS THEN 
     CALL s_errmsg('apa01',b_oob.oob06,g_ooa.ooa01,STATUS,1)    #NO.FUN-710050   #NO.FUN-710050 #No.FUN-D40089 Mod 'sel apa' --> g_ooa.ooa01
     LET g_success ='N' 
     RETURN 
  END IF
  IF l_apa.apa41 != 'Y' THEN
     CALL s_errmsg('apa01',b_oob.oob06,g_ooa.ooa01,'axr-194',1) LET g_success ='N' RETURN   #NO.FUN-710050 #NO.FUN-710050 #No.FUN-D40089 Mod 'apa41<>Y' --> g_ooa.ooa01
  END IF
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
  IF l_apz27 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
     #取得未沖金額
     CALL s_g_np('2',l_apa.apa00,b_oob.oob06,b_oob.oob15) RETURNING tot
  ELSE
  END IF
  IF p_sw = '-' THEN
     LET l_apa.apa35f=l_apa.apa35f-b_oob.oob09
     LET l_apa.apa35 =l_apa.apa35 -b_oob.oob10
     CALL t400_comp_oox(b_oob.oob06) RETURNING g_net
     LET tot = l_apa.apa34 - l_apa.apa35 + g_net    #No:9443
     UPDATE apa_file SET apa35f=l_apa.apa35f,
                         apa35 =l_apa.apa35,
                         apa73 = tot
               WHERE apa01= b_oob.oob06
                 AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
     IF STATUS THEN
        CALL s_errmsg('apa01',b_oob.oob06,g_ooa.ooa01,STATUS,1)   #NO.FUN-710050   #No.FUN-D40089 Mod 'upd apa35,35f' --> g_ooa.ooa01
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
        CALL s_errmsg('apa01',b_oob.oob06,g_ooa.ooa01,'axr-198',1) LET g_success = 'N' RETURN    #NO.FUN-710050 #No.FUN-D40089 Mod 'upd apa35,35f' --> g_ooa.ooa01
     END IF
     IF SQLCA.sqlcode = 0  THEN
        CALL t400_apc(p_sw)
     END IF
  END IF
  IF p_sw = '+' THEN
     LET l_apa.apa35f=l_apa.apa35f+b_oob.oob09
     LET l_apa.apa35 =l_apa.apa35 +b_oob.oob10
     CALL t400_comp_oox(b_oob.oob06) RETURNING g_net
     LET tot = l_apa.apa34 - l_apa.apa35 + g_net    #No:9443
     IF l_apz27 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
        IF l_apa.apa35f>l_apa.apa34f OR l_apa.apa35 >l_apa.apa34 THEN
           CALL s_errmsg("apa35",l_apa.apa35,b_oob.oob01,"axr-190",1)   #No.FUN-D40089 Mod "apa35>apa34" --> b_oob.oob01
           LET g_success = 'N'
           RETURN          
        END IF
     END IF
     UPDATE apa_file SET apa35f=l_apa.apa35f,
                         apa35 =l_apa.apa35,
                         apa73 = tot
               WHERE apa01= b_oob.oob06
                 AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
     IF STATUS THEN
        CALL s_errmsg('apa01',b_oob.oob06,b_oob.oob01,STATUS,1) #NO.FUN-710050 #No.FUN-D40089 Mod "upd apa35f,35" --> b_oob.oob01
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
       #CALL cl_err('upd apa35f,35','axr-198',1) LET g_success = 'N' RETURN   #No.FUN-D40089   Mark
        CALL s_errmsg('apa01',b_oob.oob06,b_oob.oob01,'axr-198',1) LET g_success = 'N' RETURN #NO.FUN-710050 #No.FUN-D40089 Mod "upd apa35f,35" --> b_oob.oob01
     END IF
     IF SQLCA.sqlcode = 0  THEN
        CALL t400_apc(p_sw)
     END IF
  END IF
END FUNCTION
 
#FUN-D80031 ------------- add ------------- begin
#更新應收帳款檔 (oma_file) 类型为20.待抵帐扣费用单
FUNCTION t400_bu_20(p_sw)                  #更新應收帳款檔 (oma_file)
  DEFINE p_sw           LIKE type_file.chr1                   # +:更新 -:還原
  DEFINE l_omaconf      LIKE oma_file.omaconf,               #
         l_omavoid      LIKE oma_file.omavoid,
         l_cnt          LIKE type_file.num5
  DEFINE l_oma00        LIKE oma_file.oma00
  DEFINE l_omc   RECORD LIKE omc_file.*
  DEFINE l_omc10        LIKE omc_file.omc10
  DEFINE l_omc11        LIKE omc_file.omc11
  DEFINE l_omc13        LIKE omc_file.omc13
  DEFINE l_oob10        LIKE oob_file.oob10
  DEFINE l_oob09        LIKE oob_file.oob09
  DEFINE tot4,tot4t     LIKE type_file.num20_6
  DEFINE tot5,tot6      LIKE type_file.num20_6

  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      DISPLAY "bu_20:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
  END IF

# 同參考單號若有一筆以上僅沖款一次即可 --------------
  IF g_ooz.ooz62='Y' THEN
     SELECT COUNT(*) INTO l_cnt FROM oob_file
      WHERE oob01=b_oob.oob01
        AND oob02<b_oob.oob02
        AND oob03='1'
        AND oob04='H'
        AND oob06=b_oob.oob06
        AND oob15=b_oob.oob15
        AND oob19=b_oob.oob19
  ELSE
     SELECT COUNT(*) INTO l_cnt FROM oob_file
      WHERE oob01=b_oob.oob01
        AND oob02<b_oob.oob02
        AND oob03='1'
        AND oob04='H'
        AND oob19=b_oob.oob19
        AND oob06=b_oob.oob06
  END IF
  IF l_cnt>0 THEN   #no:6100
      LET g_showmsg=b_oob.oob06,"/",b_oob.oob01
      CALL s_errmsg('oob06,oob01',g_showmsg,b_oob.oob01,'axr-409',1)
      LET g_success = 'N'
      RETURN
  END IF

  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
          WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
            AND oob03='1'
            AND oob04='H'
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF

    SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2
  LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t ",
            "  FROM oma_file ",
            " WHERE oma01=?"
  PREPARE t400_bu_20_p1 FROM g_sql
  DECLARE t400_bu_20_c1 CURSOR FOR t400_bu_20_p1
  OPEN t400_bu_20_c1 USING b_oob.oob06
  FETCH t400_bu_20_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2
    IF p_sw='+' AND l_omavoid='Y' THEN
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-103',1) LET g_success='N' RETURN
    END IF
    IF p_sw='+' AND l_omaconf='N' THEN
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN
    END IF
    IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
    IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
    #取得衝帳單的待扺金額
    CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t
    #add by danny 020309 期末調匯(A008)
    IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
       IF p_sw='+' AND (un_pay1 < tot1+tot4 OR un_pay2 < tot2+tot4t) THEN
       CALL s_errmsg('oma01',b_oob.oob06,'un_pay<pay','axr-196',1) LET g_success='N' RETURN
       END IF
    END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       CALL s_g_np('1',l_oma00,b_oob.oob06,0          ) RETURNING tot3
       IF tot3 <0 THEN
         IF g_bgerr THEN
            CALL s_errmsg('ooa01',b_oob.oob01,'','axr-185',1)
         ELSE
            CALL cl_err('','axr-185',1)
         END IF
          LET g_success ='N'
          RETURN
       END IF
       LET tot3 = tot3 - tot4t
    ELSE
       LET tot3 = un_pay2 - tot2 - tot4t
    END IF
    LET g_sql="UPDATE oma_file ",
                " SET oma55=?,oma57=?,oma61=? ",
               " WHERE oma01=? "
    PREPARE t400_bu_20_p2 FROM g_sql
    LET tot1 = tot1 + tot4
    LET tot2 = tot2 + tot4t
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2
    EXECUTE t400_bu_20_p2 USING tot1, tot2, tot3, b_oob.oob06
    IF STATUS THEN
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57',STATUS,1)
       LET g_success = 'N'
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57','axr-198',1) LET g_success = 'N' RETURN
    END IF
    IF SQLCA.sqlcode = 0 THEN
       CALL t400_omc(l_oma00,p_sw)
    END IF
  # 若有指定沖帳項次, 則對項次再次檢查及更新已沖金額
  IF NOT cl_null(b_oob.oob15) AND g_ooz.ooz62='Y' THEN
     LET tot1 = 0 LET tot2 = 0
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
        AND oob03='1' AND oob15 = b_oob.oob15
        AND oob04='H'
     IF cl_null(tot1) THEN LET tot1 = 0 END IF
     IF cl_null(tot2) THEN LET tot2 = 0 END IF
     LET g_sql="SELECT oma00,omaconf,omb14t,omb16t ",
               "  FROM omb_file,oma_file ",
               " WHERE oma01=omb01 AND omb01=? AND omb03 = ? "
     PREPARE t400_bu_20_p1b FROM g_sql
     DECLARE t400_bu_20_c1b CURSOR FOR t400_bu_20_p1b
     OPEN t400_bu_20_c1b USING b_oob.oob06,b_oob.oob15
     FETCH t400_bu_20_c1b INTO l_oma00,l_omaconf,un_pay1,un_pay2
     IF p_sw='+' AND l_omaconf='N' THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15
        CALL s_errmsg('omb01,omb03',g_showmsg,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN
     END IF
     IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
     IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
     IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
        IF p_sw='+' AND (un_pay1 < tot1 OR un_pay2 < tot2) THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15
        CALL s_errmsg('omb01,omb03',g_showmsg,'un_pay<pay','axr-196',1)  LET g_success='N' RETURN
        END IF
     END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       #取得未沖金額
       CALL s_g_np('1',l_oma00,b_oob.oob06,b_oob.oob15) RETURNING tot3
    ELSE
       LET tot3 = un_pay2  - tot2
    END IF
     #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"omb_file SET omb34=?,omb35=?,omb37=? ",
     #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'omb_file'),
     LET g_sql="UPDATE omb_file ",
                 " SET omb34=?,omb35=?,omb37=? ",
               " WHERE omb01=? AND omb03=?"
     PREPARE t400_bu_20_p2b FROM g_sql
     EXECUTE t400_bu_20_p2b USING tot1, tot2, tot3, b_oob.oob06,b_oob.oob15
     IF STATUS THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35',STATUS,1)
        LET g_success = 'N'
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
       #CALL cl_err('upd omb34,35','axr-198',3) LET g_success = 'N' RETURN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35','axr-198',1) LET g_success = 'N' RETURN
     END IF
  END IF
END FUNCTION
#FUN-D80031 ------------- add ------------- end

FUNCTION t400_bu_21(p_sw)                  #更新應收帳款檔 (oma_file)
  DEFINE p_sw           LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:更新 -:還原
  DEFINE l_omaconf      LIKE oma_file.omaconf,   #No.FUN-680123 VARCHAR(1),            #
         l_omavoid      LIKE oma_file.omavoid,   #No.FUN-680123 VARCHAR(1),
         l_cnt          LIKE type_file.num5      #No.FUN-680123 smallint
  DEFINE l_oma00        LIKE oma_file.oma00
  DEFINE l_omc   RECORD LIKE omc_file.*         #No.FUN-680022 add
  DEFINE l_omc10        LIKE omc_file.omc10     #No.FUN-680022 add
  DEFINE l_omc11        LIKE omc_file.omc11     #No.FUN-680022 add
  DEFINE l_omc13        LIKE omc_file.omc13     #No.FUN-680022 add
  DEFINE l_oob10        LIKE oob_file.oob10     #No.FUN-680022 add
  DEFINE l_oob09        LIKE oob_file.oob09     #No.FUN-680022 add
  DEFINE tot4,tot4t     LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)           #TQC-5B0171
  DEFINE tot5,tot6      LIKE type_file.num20_6  #No.FUN-680123 DEC(20,6)           #No.FUN-680022 add
 
  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
      DISPLAY "bu_21:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
  END IF
 
# 同參考單號若有一筆以上僅沖款一次即可 --------------
  IF g_ooz.ooz62='Y' THEN
     SELECT COUNT(*) INTO l_cnt FROM oob_file
      WHERE oob01=b_oob.oob01
        AND oob02<b_oob.oob02
        AND oob03='2'
        AND oob04='1'   #98/07/23 modify
        AND oob06=b_oob.oob06
        AND oob15=b_oob.oob15
        AND oob19=b_oob.oob19       #MOD-B60228 add
  ELSE
     SELECT COUNT(*) INTO l_cnt FROM oob_file
      WHERE oob01=b_oob.oob01
        AND oob02<b_oob.oob02
        AND oob03='2'
        AND oob04='1'               #MOD-B60228 add
        AND oob19=b_oob.oob19       #No.FUN-680022
        AND oob06=b_oob.oob06
  END IF
  IF l_cnt>0 THEN   #no:6100
      LET g_showmsg=b_oob.oob06,"/",b_oob.oob01                           #NO.FUN-710050 
      CALL s_errmsg('oob06,oob01',g_showmsg,b_oob.oob01,'axr-409',1)      #NO.FUN-710050
      LET g_success = 'N'
      RETURN
  END IF
 
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
          WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
            AND oob03='2'
            AND oob04='1'   #98/07/23 modify
    IF cl_null(tot1) THEN LET tot1 = 0 END IF
    IF cl_null(tot2) THEN LET tot2 = 0 END IF
    	
    SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07 #MOD-560077 #No.CHI-6A0004
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1         #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2         #No.CHI-6A0004
  LET g_sql="SELECT oma00,omavoid,omaconf,oma54t,oma56t ",
            #"  FROM ",g_dbs_new,"oma_file",
            #"  FROM ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
            "  FROM oma_file ", #FUN-A50102
            " WHERE oma01=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t400_bu_21_p1 FROM g_sql
  DECLARE t400_bu_21_c1 CURSOR FOR t400_bu_21_p1
  OPEN t400_bu_21_c1 USING b_oob.oob06
  FETCH t400_bu_21_c1 INTO l_oma00,l_omavoid,l_omaconf,un_pay1,un_pay2
    IF p_sw='+' AND l_omavoid='Y' THEN
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-103',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
    END IF
    IF p_sw='+' AND l_omaconf='N' THEN
       CALL s_errmsg('oma01',b_oob.oob06,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
    END IF
    IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
    IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
    #取得衝帳單的待扺金額
    CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4       #No.CHI-6A0004
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004
    #add by danny 020309 期末調匯(A008)
    IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
       IF p_sw='+' AND (un_pay1 < tot1+tot4 OR un_pay2 < tot2+tot4t) THEN   #TQC-5B0171
       CALL s_errmsg('oma01',b_oob.oob06,'un_pay<pay','axr-196',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
       END IF
    END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       CALL s_g_np('1',l_oma00,b_oob.oob06,0          ) RETURNING tot3
#No.FUN-AA0088 --begin                                                          
       IF tot3 <0 THEN                                                          
        #No.FUN-D40089 ---start--- Add
         IF g_bgerr THEN
            CALL s_errmsg('ooa01',b_oob.oob01,'','axr-185',1)
         ELSE
            CALL cl_err('','axr-185',1)                                           
         END IF
         #No.FUN-D40089 ---end  --- Add                                        
          LET g_success ='N'                                                    
          RETURN                                                                
       END IF                                                                   
#No.FUN-AA0088 --end 
       LET tot3 = tot3 - tot4t
    ELSE
       LET tot3 = un_pay2 - tot2 - tot4t
    END IF
    #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"oma_file SET oma55=?,oma57=?,oma61=? ",
    #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'oma_file'), #FUN-A50102
    LET g_sql="UPDATE oma_file ",#FUN-A50102
                " SET oma55=?,oma57=?,oma61=? ",
               " WHERE oma01=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
    PREPARE t400_bu_21_p2 FROM g_sql
    LET tot1 = tot1 + tot4
    LET tot2 = tot2 + tot4t
    CALL cl_digcut(tot1,t_azi04) RETURNING tot1         #No.CHI-6A0004
    CALL cl_digcut(tot2,g_azi04) RETURNING tot2         #No.CHI-6A0004
    EXECUTE t400_bu_21_p2 USING tot1, tot2, tot3, b_oob.oob06
    IF STATUS THEN
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57',STATUS,1)              #NO.FUN-710050
       LET g_success = 'N'
       RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
       CALL s_errmsg('oma01',b_oob.oob06,'upd oma55,57','axr-198',1) LET g_success = 'N' RETURN  #NO.FUN-710050
    END IF
    IF SQLCA.sqlcode = 0 THEN
      #CALL t400_omc(l_oma00)  #No.MOD-930140  #No.MOD-B80122 mark
       CALL t400_omc(l_oma00,p_sw)  #No.MOD-B80122 add
    END IF
  # 若有指定沖帳項次, 則對項次再次檢查及更新已沖金額
  IF NOT cl_null(b_oob.oob15) AND g_ooz.ooz62='Y' THEN
     LET tot1 = 0 LET tot2 = 0
     SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file, ooa_file
      WHERE oob06=b_oob.oob06 AND oob01=ooa01 AND ooaconf='Y'
        AND oob03='2' AND oob15 = b_oob.oob15
        AND oob04='1'
     IF cl_null(tot1) THEN LET tot1 = 0 END IF
     IF cl_null(tot2) THEN LET tot2 = 0 END IF
     LET g_sql="SELECT oma00,omaconf,omb14t,omb16t ",
               #"  FROM ",g_dbs_new CLIPPED,"omb_file,",g_dbs_new CLIPPED,"oma_file ",
               #"  FROM ",cl_get_target_table(g_plant,'omb_file'),",", #FUN-A50102
               #          cl_get_target_table(g_plant,'oma_file'),     #FUN-A50102
               "  FROM omb_file,oma_file ", #FUN-A50102
               " WHERE oma01=omb01 AND omb01=? AND omb03 = ? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t400_bu_21_p1b FROM g_sql
     DECLARE t400_bu_21_c1b CURSOR FOR t400_bu_21_p1b
     OPEN t400_bu_21_c1b USING b_oob.oob06,b_oob.oob15
     FETCH t400_bu_21_c1b INTO l_oma00,l_omaconf,un_pay1,un_pay2
     IF p_sw='+' AND l_omaconf='N' THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                     #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,b_oob.oob06,'axr-194',1) LET g_success='N' RETURN #NO.FUN-710050  #No.TQC-740094
     END IF
     IF cl_null(un_pay1) THEN LET un_pay1 = 0 END IF
     IF cl_null(un_pay2) THEN LET un_pay2 = 0 END IF
     IF g_ooz.ooz07 ='N' OR b_oob.oob07 = g_aza.aza17 THEN
        IF p_sw='+' AND (un_pay1 < tot1 OR un_pay2 < tot2) THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'un_pay<pay','axr-196',1)  LET g_success='N' RETURN #NO.FUN-710050
        END IF
     END IF
    IF g_ooz.ooz07 ='Y' AND b_oob.oob07 != g_aza.aza17 THEN
       #取得未沖金額
       CALL s_g_np('1',l_oma00,b_oob.oob06,b_oob.oob15) RETURNING tot3
    ELSE
       LET tot3 = un_pay2  - tot2
    END IF
     #LET g_sql="UPDATE ",g_dbs_new CLIPPED,"omb_file SET omb34=?,omb35=?,omb37=? ",
     #LET g_sql="UPDATE ",cl_get_target_table(g_plant,'omb_file'),     #FUN-A50102
     LET g_sql="UPDATE omb_file ",    #FUN-A50102
                 " SET omb34=?,omb35=?,omb37=? ",
               " WHERE omb01=? AND omb03=?"
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t400_bu_21_p2b FROM g_sql
     EXECUTE t400_bu_21_p2b USING tot1, tot2, tot3, b_oob.oob06,b_oob.oob15
     IF STATUS THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35',STATUS,1)   #NO.FUN-710050
        LET g_success = 'N' 
        RETURN
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
       #CALL cl_err('upd omb34,35','axr-198',3) LET g_success = 'N' RETURN   #No.FUN-D40089   Mark
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob15                        #NO.FUN-710050   
        CALL s_errmsg('omb01,omb03',g_showmsg,'upd omb34,35','axr-198',1) LET g_success = 'N' RETURN   #NO.FUN-710050  #No.TQC-740094
     END IF
  END IF
END FUNCTION
 
FUNCTION t400_bu_22(p_sw,p_cnt)                  # 產生溢收帳款檔 (oma_file)
  DEFINE p_sw            LIKE type_file.chr1      #No.FUN-680123 VARCHAR(1)                  # +:產生 -:刪除
  DEFINE p_cnt           LIKE type_file.num5      #No.FUN-680123 SMALLINT
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*
  DEFINE li_result       LIKE type_file.num5      #No.FUN-680123 SMALLINT   #FUN-560099
  DEFINE l_cnt           LIKE type_file.num5      #MOD-A70074

  IF g_bgjob='N' OR cl_null(g_bgjob) THEN
     IF g_gui_type MATCHES "[13]" AND fgl_getenv('GUI_VER') = '6' THEN
        MESSAGE "bu_22:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04
     ELSE
        DISPLAY "bu_22:",b_oob.oob02,' ',b_oob.oob03,' ',b_oob.oob04 AT 2,1
     END IF
  END IF
  INITIALIZE l_oma.* TO NULL
  IF p_sw = '-' THEN
## No.2695 modify 1998/10/31 若溢收款在後已被沖帳,則不可取消確認
     IF b_oob.oob03 = '2' AND b_oob.oob04 = '2' THEN
        SELECT COUNT(*) INTO g_cnt FROM oob_file,ooa_file                  #MOD-A10120 add ooa_file
         WHERE oob06 = b_oob.oob06
           AND oob03 = '1' AND oob04 = '3'
           AND ooa01 = oob01 AND ooaconf!='X'                              #MOD-A10120 add
        IF g_cnt > 0 THEN
           LET g_showmsg=b_oob.oob06,"/",'1',"/",'3'                       #NO.FUN-710050
           CALL s_errmsg('oob06,oob03,oob04',g_showmsg,b_oob.oob06,'axr-206',1) #NO.FUN-710050
           LET g_success = 'N' RETURN                                           #NO.FUN-710050      
        END IF
     END IF
     SELECT * INTO l_oma.* FROM oma_file WHERE oma01=b_oob.oob06
                                           AND omavoid = 'N'
     IF l_oma.oma55 > 0 OR l_oma.oma57 > 0 THEN
          LET g_showmsg=b_oob.oob06,"/",'N'                                #NO.FUN-710050
          CALL s_errmsg('oma01,omavoid',g_showmsg,b_oob.oob06,'axr-206',1)#NO.FUN-710050 #No.FUN-D40089 Mod "upd apa35f,35" --> b_oob.oob06
           LET g_success = 'N' RETURN                                      #NO.FUN-710050      
     END IF
     DELETE FROM oma_file WHERE oma01 = b_oob.oob06
     IF STATUS THEN
        CALL s_errmsg('oma01','b_oob.oob06','del oma',STATUS,1)              #NO.FUN-710050
        LET g_success = 'N' 
        RETURN 
     END IF
     IF SQLCA.SQLERRD[3]=0 THEN
        CALL s_errmsg('oma01','b_oob.oob06','del oma','axr-199',1)           #NO.FUN-710050
        LET g_success = 'N' RETURN
     END IF
     DELETE FROM omc_file WHERE omc01=b_oob.oob06 AND omc02=b_oob.oob19
     IF STATUS THEN
        LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                    #NO.FUN-710050
        CALL s_errmsg('omc01,omc02',g_showmsg,"del omc",STATUS,1)                    #NO.FUN-710050
        LET g_success ='N'
        RETURN
     END IF 
     DELETE FROM oov_file WHERE oov01 = b_oob.oob06
     IF SQLCA.sqlcode THEN
        CALL s_errmsg('oov01','b_oob.oob06','del oov',STATUS,1)              #NO.FUN-710050
        LET g_success='N'
     END IF

     #TQC-C20430--add--str--
     #更新退款單待抵單號
     IF g_prog = 'axrt400' AND g_ooa.ooa35 = '2' THEN
        UPDATE lud_file SET lud10=NULL 
         WHERE lud01 = g_ooa.ooa36 AND lud10 = b_oob.oob06
        IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
          #CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)   #No.FUN-D40089   Mark
          #No.FUN-D40089 ---start--- Add
           IF g_bgerr THEN
              CALL s_errmsg('ooa36',g_ooa.ooa36,g_ooa.ooa01,STATUS,1)
           ELSE
              CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)
           END IF
           #No.FUN-D40089 ---end  --- Add
           LET g_success='N'
        END IF
        UPDATE luk_file SET luk16 = NULL WHERE luk04 = '2' AND luk05 = g_ooa.ooa36
        IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
          #CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",STATUS,"","",1)   #No.FUN-D40089   Mark
          #No.FUN-D40089 ---start--- Add
           IF g_bgerr THEN
              CALL s_errmsg('ooa36',g_ooa.ooa36,g_ooa.ooa01,STATUS,1)
           ELSE
              CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",STATUS,"","",1)
           END IF
           #No.FUN-D40089 ---end  --- Add
           LET g_success='N'
        END IF
     END IF  
     #TQC-C20430--add--end
     UPDATE oob_file SET oob06=NULL
       WHERE oob01=b_oob.oob01 AND oob02=b_oob.oob02
     IF STATUS OR SQLCA.SQLCODE THEN
       LET g_showmsg=b_oob.oob01,"/",b_oob.oob02                                    #NO.FUN-710050
       CALL s_errmsg('oob01,oob02',g_showmsg,'upd oob06',SQLCA.SQLCODE,1)           #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
     ELSE        #97/08/08 modify 畫面清為空白
        LET b_oob.oob06 = NULL
     END IF
    #-MOD-A70074-add-
     LET l_cnt = 0
     SELECT count(*) INTO l_cnt
       FROM npq_file
      WHERE npq01 = b_oob.oob01 AND npq02 = b_oob.oob02
     IF l_cnt > 0 THEN
        UPDATE npq_file SET npq23=NULL
          WHERE npq01=b_oob.oob01 AND npq02=b_oob.oob02
        IF STATUS OR SQLCA.SQLCODE THEN
          LET g_showmsg=b_oob.oob01,"/",b_oob.oob02     
          CALL s_errmsg('npq01,npq02',g_showmsg,'upd npq23',SQLCA.SQLCODE,1)   
          LET g_success = 'N' 
          RETURN
        END IF
     END IF
    #-MOD-A70074-add-
  END IF
  IF p_sw = '+' THEN
     IF cl_null(b_oob.oob06)
        THEN LET l_oma.oma01 = g_ooz.ooz22    #FUN-560099
        ELSE LET l_oma.oma01 = b_oob.oob06
     END IF
     CALL s_auto_assign_no("axr",l_oma.oma01,g_ooa.ooa02,"24","","","","","")
     RETURNING li_result,l_oma.oma01
     IF (NOT li_result) THEN
        CALL s_errmsg('ooa01',g_ooa.ooa01,l_oma.oma01,'mfg-059',1)     #MOD-BC0248 add #No.FUN-D40089 Mod '','' --> g_ooa.ooa01
        LET g_success='N'
        RETURN                                           #MOD-BC0248 add
     END IF
     CALL cl_msg(l_oma.oma01)          #FUN-640246
 
     #轉預收時(oma00='24'),重新讀取g_ooa.*變數
     SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01=b_oob.oob01   #MOD-860002 add
 
     LET l_oma.oma00 = '24'
     LET l_oma.oma02 = g_ooa.ooa02
     LET l_oma.oma03 = g_ooa.ooa03
     LET l_oma.oma032= g_ooa.ooa032
     LET l_oma.oma13 = g_ooa.ooa13
     LET l_oma.oma14 = g_ooa.ooa14
     LET l_oma.oma15 = g_ooa.ooa15
     LET l_oma.oma16 = g_ooa.ooa01
     LET l_oma.oma18 = b_oob.oob11
     IF g_aza.aza63='Y' THEN             #No.FUN-670047 add
        LET l_oma.oma181 = b_oob.oob111  #No.FUN-670047 add
     END IF                              #No.FUN-670047 add
     LET l_oma.oma211= 0   #MOD-850039
     LET l_oma.oma23 = b_oob.oob07
     LET l_oma.oma24 = b_oob.oob08
     SELECT occ43 INTO l_oma.oma25  FROM occ_file WHERE occ01 = l_oma.oma03   #MOD-B70289
     LET l_oma.oma50 = 0
     LET l_oma.oma50t= 0
     LET l_oma.oma52 = 0
     LET l_oma.oma53 = 0
     LET l_oma.oma54 = b_oob.oob09
     LET l_oma.oma54t= b_oob.oob09
     LET l_oma.oma56 = b_oob.oob10
     LET l_oma.oma56t= b_oob.oob10
     LET l_oma.oma54x= 0
     LET l_oma.oma55 = 0
     LET l_oma.oma56x= 0
     LET l_oma.oma57 = 0
     LET l_oma.oma58 = 0
     LET l_oma.oma59 = 0
     LET l_oma.oma59x= 0
     LET l_oma.oma59t= 0
     LET l_oma.oma60 = b_oob.oob08
     LET l_oma.oma61 = b_oob.oob10
     LET l_oma.omaconf='Y'
     LET l_oma.oma64 = '1'          #No.TQC-9C0057
     LET l_oma.omavoid='N'
     LET l_oma.omauser=g_user
     LET l_oma.omagrup=g_grup
     LET l_oma.omadate=g_today
     LET l_oma.oma12 = l_oma.oma02
     LET l_oma.oma11 = l_oma.oma02
     LET l_oma.oma65 = '1'  #FUN-5A0124
     LET l_oma.oma66 = g_plant  #FUN-630043
     #LET l_oma.oma68 = g_ooa.ooa03  #MOD-AC0302              
#    LET l_oma.oma68 = 0             #MOD-AC0302                                                         
     LET l_oma.oma68 = g_ooa.ooa03  #MOD-B50053              
     LET l_oma.oma69 = g_ooa.ooa032                                                                         
     LET l_omc.omc01=l_oma.oma01
     LET l_omc.omc02=1
     SELECT occ45 INTO l_oma.oma32 FROM occ_file WHERE occ01=g_ooa.ooa03
     IF cl_null(l_oma.oma32) THEN LET l_oma.oma32 = ' ' END IF
     LET l_omc.omc03=l_oma.oma32
     LET l_omc.omc04=l_oma.oma11
     LET l_omc.omc05=l_oma.oma12
     LET l_omc.omc06=l_oma.oma24
     LET l_omc.omc07=l_oma.oma60
     LET l_omc.omc08=l_oma.oma54t
     LET l_omc.omc09=l_oma.oma56t
     LET l_omc.omc10=l_oma.oma55
     LET l_omc.omc11=l_oma.oma57
     LET l_omc.omc12=l_oma.oma10
     LET l_omc.omc13=l_omc.omc09-l_omc.omc11
     LET l_omc.omc14=l_oma.oma51f
     LET l_omc.omc15=l_oma.oma51
     LET l_oma.oma70='1'                       #MOD-BC0094 add
    #FUN-A60056--mod--str-- 
    #SELECT oga27 INTO l_oma.oma67 FROM oga_file WHERE oga01=l_oma.oma16
     LET g_sql = "SELECT oga27 FROM ",cl_get_target_table(l_oma.oma66,'oga_file'),
                 " WHERE oga01='",l_oma.oma16,"'"
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql
     CALL cl_parse_qry_sql(g_sql,l_oma.oma66) RETURNING g_sql
     PREPARE sel_oga27 FROM g_sql
     EXECUTE sel_oga27 INTO l_oma.oma67
    #FUN-A60056--mod-end
     LET l_oma.oma930=s_costcenter(l_oma.oma15) #FUN-680006
     LET l_oma.omalegal = g_ooa.ooalegal
     LET l_omc.omclegal = g_ooa.ooalegal
     LET l_oma.omaoriu = g_user      #No.FUN-980030 10/01/04
     LET l_oma.omaorig = g_grup      #No.FUN-980030 10/01/04
#No.FUN-AB0034 --begin
    IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
    IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
    IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
     INSERT INTO oma_file VALUES(l_oma.*)
     IF STATUS OR SQLCA.SQLCODE THEN
        CALL s_errmsg('oma02','g_ooa.ooa02',g_ooa.ooa01,SQLCA.SQLCODE,1) #NO.FUN-710050#No.FUN-D40089 Mod "ins oma" --> g_ooa.ooa01
        LET g_success='N' 
        RETURN
     END IF
     
     INSERT INTO omc_file VALUES(l_omc.*)
     IF SQLCA.sqlcode THEN
        CALL s_errmsg('omc01','l_oma.oma01',g_ooa.ooa01,SQLCA.SQLCODE,1)   #NO.FUN-710050 #No.FUN-D40089 Mod "ins oma" --> g_ooa.ooa01
        LET g_success='N'
        RETURN
     END IF
     UPDATE oob_file SET oob06=l_oma.oma01,oob19=l_omc.omc02   #No.FUN-680022 add
       WHERE oob01=b_oob.oob01 AND oob02=b_oob.oob02
     IF STATUS OR SQLCA.SQLCODE THEN
      #CALL cl_err3("upd","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","upd oob06",1)  #No.FUN-660116   #No.FUN-D40089  Mark
       LET g_showmsg=b_oob.oob01,"/",b_oob.oob02                                      #NO.FUN-710050 
       CALL s_errmsg('oob01,oob02',g_showmsg,'upd oob06',SQLCA.SQLCODE,1)             #NO.FUN-710050
       LET g_success = 'N' 
       RETURN
     END IF
     #TQC-C20430--add--str--
     #更新退款單待抵單號
     IF g_prog = 'axrt400' AND g_ooa.ooa35 = '2' THEN
        UPDATE lud_file SET lud10=l_oma.oma01
         WHERE lud01 = g_ooa.ooa36 
        IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
          #CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)   #No.FUN-D40089   Mark
        #No.FUN-D40089 ---start--- Add
         IF g_bgerr THEN
            CALL s_errmsg('ooa36',g_ooa.ooa36,g_ooa.ooa01,STATUS,1)
         ELSE
            CALL cl_err3("upd","lud_file",g_ooa.ooa36,"",STATUS,"","",1)
         END IF
         #No.FUN-D40089 ---end  --- Add
           LET g_success='N'
        END IF
        UPDATE luk_file SET luk16 = l_oma.oma01 WHERE luk04 = '2' AND luk05 = g_ooa.ooa36
        IF STATUS OR SQlCA.sqlerrd[3]=0 THEN
          #CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",STATUS,"","",1)  #No.FUN-D40089   Mark
        #No.FUN-D40089 ---start--- Add
         IF g_bgerr THEN
            CALL s_errmsg('ooa36',g_ooa.ooa36,g_ooa.ooa01,STATUS,1)
         ELSE
            CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",STATUS,"","",1)
         END IF
         #No.FUN-D40089 ---end  --- Add
           LET g_success='N'
        END IF
     END IF
     #TQC-C20430--add--end
    #-MOD-A70074-add-
     LET l_cnt = 0
     SELECT count(*) INTO l_cnt
       FROM npq_file
      WHERE npq01 = b_oob.oob01 AND npq02 = b_oob.oob02
     IF l_cnt > 0 THEN
        UPDATE npq_file SET npq23=l_oma.oma01
          WHERE npq01=b_oob.oob01 AND npq02=b_oob.oob02
        IF STATUS OR SQLCA.SQLCODE THEN
          LET g_showmsg=b_oob.oob01,"/",b_oob.oob02     
          CALL s_errmsg('npq01,npq02',g_showmsg,'upd npq23',SQLCA.SQLCODE,1)   
          LET g_success = 'N' 
          RETURN
        END IF
     END IF
    #-MOD-A70074-add-
  END IF
END FUNCTION
 
FUNCTION ins_apf()
  DEFINE b_oob      RECORD LIKE oob_file.*
  DEFINE l_apf      RECORD LIKE apf_file.*
  DEFINE l_apg      RECORD LIKE apg_file.*
  DEFINE l_aph      RECORD LIKE aph_file.*
  DEFINE l_amt      LIKE type_file.num20_6   #No.FUN-680123 DEC(20,6)  #FUN-4C0013
  DEFINE l_apz27    LIKE apz_file.apz27
 
  INITIALIZE l_apf.* TO NULL
  LET l_apf.apf00='33'
  LET l_apf.apf01 =g_ooa.ooa01
  LET l_apf.apf02 =g_ooa.ooa02
  LET l_apf.apf03 =g_ooa.ooa03
  LET l_apf.apf12 =g_ooa.ooa032
  LET l_apf.apf04 =g_ooa.ooa14
  LET l_apf.apf05 =g_ooa.ooa15
  LET l_apf.apf06 =g_ooa.ooa23
  LET l_apf.apf07 =1
  LET l_apf.apf08f=g_ooa.ooa31d
  LET l_apf.apf08 =g_ooa.ooa32d
  LET l_apf.apf09f=0
  LET l_apf.apf09 =0
  LET l_apf.apf10f=g_ooa.ooa31c
  LET l_apf.apf10 =g_ooa.ooa32c
  LET l_apf.apf13 = ''
  SELECT pmc24 INTO l_apf.apf13 FROM pmc_file
    WHERE pmc01 = g_ooa.ooa03
  LET l_apf.apf41 ='Y'
  LET l_apf.apf44 =g_ooa.ooa33
  LET l_apf.apfinpd =TODAY
  LET l_apf.apfmksg ='N'
  LET l_apf.apfacti ='Y'
  LET l_apf.apfuser =g_user
  LET l_apf.apfgrup =g_grup
  LET l_apf.apflegal = g_ooa.ooalegal
  LET l_apf.apforiu = g_user      #No.FUN-980030 10/01/04
  LET l_apf.apforig = g_grup      #No.FUN-980030 10/01/04
  INSERT INTO apf_file VALUES(l_apf.*)
  IF STATUS OR SQLCA.SQLCODE THEN
     CALL s_errmsg('apf01','g_ooa.ooa01','ins apf',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
  DECLARE ins_apf_c CURSOR FOR
    SELECT * FROM oob_file WHERE oob01=g_ooa.ooa01 ORDER BY 1,2
  FOREACH ins_apf_c INTO b_oob.*
       IF g_success='N' THEN                                                    
         LET g_totsuccess='N'                                                   
         LET g_success='Y' 
       END IF                                                     
    IF b_oob.oob03='1' THEN
       INITIALIZE l_apg.* TO NULL
       LET l_apg.apg01 =g_ooa.ooa01
       LET l_apg.apg02 =b_oob.oob02
       LET l_apg.apg03 = g_plant #MOD-970197  
       LET l_apg.apg04 =b_oob.oob06
       LET l_apg.apg05f=b_oob.oob09
       LET l_apg.apg05 =b_oob.oob10
       LET l_apg.apg06 =b_oob.oob19  #No.FUN-680022 add
       LET l_apg.apglegal = g_ooa.ooalegal
       INSERT INTO apg_file VALUES(l_apg.*)
       IF STATUS OR SQLCA.SQLCODE THEN
          LET g_showmsg=g_ooa.ooa01,"/",b_oob.oob02 
          CALL s_errmsg('apg01,apg02',g_showmsg,'ins apg',SQLCA.SQLCODE,1)   #NO.FUN-710050    #NO.FUN-710050
          LET g_success = 'N'
       END IF

    END IF
    IF b_oob.oob03='2' THEN
       INITIALIZE l_aph.* TO NULL
       LET l_aph.aph01 =g_ooa.ooa01
       LET l_aph.aph02 =b_oob.oob02
       LET l_aph.aph03 ='0'
      #No.B592 010525 by plum 若抓科目,到時aapt230,240會無法查到此沖帳記錄
       LET l_aph.aph04 =b_oob.oob06
       LET l_aph.aph05f=b_oob.oob09
       LET l_aph.aph05 =b_oob.oob10
       LET l_aph.aph13 =b_oob.oob07
       LET l_aph.aph14 =b_oob.oob08
       LET l_aph.aph17 =b_oob.oob19  #No.FUN-680022 add
       LET l_aph.aphlegal = g_ooa.ooalegal
       INSERT INTO aph_file VALUES(l_aph.*)
       IF STATUS OR SQLCA.SQLCODE THEN
          LET g_showmsg=g_ooa.ooa01,"/",b_oob.oob02                          #NO.FUN-710050    
          CALL s_errmsg('aph01,aph02',g_showmsg,'ins aph',SQLCA.SQLCODE,1)   #NO.FUN-710050  
          LET g_success = 'N'
       END IF
    END IF
  END FOREACH
  IF g_totsuccess="N" THEN                                                        
     LET g_success="N"                                                           
  END IF                                                                          
END FUNCTION
 
FUNCTION del_apf()
  DELETE FROM apf_file WHERE apf01=g_ooa.ooa01
  IF STATUS OR SQLCA.SQLCODE THEN
     CALL s_errmsg('apf01','g_ooa.ooa01','del apf',SQLCA.SQLCODE,1)   #NO.FUN-710050
     LET g_success = 'N'
  END IF
  DELETE FROM apg_file WHERE apg01=g_ooa.ooa01
  IF STATUS OR SQLCA.SQLCODE THEN
     CALL s_errmsg('apg01','g_ooa.ooa01','del apg',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
  DELETE FROM aph_file WHERE aph01=g_ooa.ooa01
  IF STATUS OR SQLCA.SQLCODE THEN
     CALL s_errmsg('aph01','g_ooa.ooa01','del aph',SQLCA.SQLCODE,1)              #NO.FUN-710050
     LET g_success = 'N'
  END IF
END FUNCTION
 
FUNCTION t400_oob07(p_cmd)
DEFINE
      p_cmd        LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(1),
      l_azi01      LIKE azi_file.azi01,
      l_aziacti    LIKE azi_file.aziacti
 
      LET g_errno = ' '
      SELECT azi01,aziacti INTO l_azi01,l_aziacti
        FROM azi_file
       WHERE azi01 = g_oob[l_ac].oob07
      CASE
          WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aap-002'
                                   LET l_azi01 = NULL
                                   LET l_aziacti = NULL
          WHEN l_aziacti = 'N' LET g_errno = '9028'
          OTHERWISE            LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
END FUNCTION
 
#FUNCTION t400_x() #FUN-D20035 mark
FUNCTION t400_x(p_type) #FUN-D20035 add
   DEFINE p_type    LIKE type_file.chr1  #FUN-D20035 add   
 
   IF s_shut(0) THEN RETURN END IF
 
   SELECT * INTO g_ooa.* FROM ooa_file WHERE ooa01=g_ooa.ooa01
 
  IF g_ooa.ooa34 MATCHES '[Ss1]' THEN          #FUN-550049
     CALL cl_err("","mfg3557",0)
     RETURN
  END IF
 
   IF g_ooa.ooa01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   #FUN-D20035---begin 
   IF p_type = 1 THEN 
      IF g_ooa.ooaconf='X' THEN RETURN END IF
   ELSE
      IF g_ooa.ooaconf<>'X' THEN RETURN END IF
   END IF 
   #FUN-D20035---end  
   #FUN-C30029--add--str
   IF g_azw.azw04='2' AND g_ooa.ooa38<>'2' THEN
      CALL cl_err('','aap-829',0)
      RETURN
   END IF
   #FUN-C30029--add--end   

   BEGIN WORK
   LET g_success='Y'
 
   OPEN t400_cl USING g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
 
   FETCH t400_cl INTO g_ooa.* #鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)#資料被他人LOCK
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
 
  #-->作廢轉換01/08/02
   IF cl_void(0,0,g_ooa.ooaconf) THEN
      LET g_chr = g_ooa.ooaconf
      IF g_ooa.ooaconf ='N' THEN
         LET g_ooa.ooaconf='X'
         LET g_ooa.ooa34 = '9'    #No.FUN-540046
      ELSE
         LET g_ooa.ooaconf='N'
         LET g_ooa.ooa34 = '0'    #No.FUN-540046
      END IF
 
      UPDATE ooa_file SET ooaconf = g_ooa.ooaconf,
                          ooa34 = g_ooa.ooa34,    #No.FUN-540046
                          ooamodu = g_user,
                          ooadate = TODAY
       WHERE ooa01 = g_ooa.ooa01
 
      IF STATUS THEN
         CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",STATUS,"","upd ooaconf:",1)  #No.FUN-660116
         LET g_success='N'
      END IF
      DELETE FROM npp_file WHERE npp01 = g_ooa.ooa01 AND nppsys = 'AR'
                             AND npp00 = 3  AND npp011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npp_file",g_ooa.ooa01,"",STATUS,"","del npp_file",1) 
         LET g_success='N'
      END IF
      DELETE FROM npq_file WHERE npq01 = g_ooa.ooa01 AND npqsys = 'AR'
                             AND npq00 = 3 AND npq011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npq_file",g_ooa.ooa01,"",STATUS,"","del npq_file",1)
         LET g_success='N'
      END IF
  #FUN-B40056--add--str--
      DELETE FROM tic_file WHERE tic04 = g_ooa.ooa01
      IF STATUS THEN
         CALL cl_err3("del","tic_file",g_ooa.ooa01,"",STATUS,"","del tic:",1)
         LET g_success='N'
      END IF
  #FUN-B40056--add--end--
 
      IF g_success='Y' THEN
         COMMIT WORK
 
         IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
 
         CALL cl_flow_notify(g_ooa.ooa01,'V')
      ELSE
         ROLLBACK WORK
      END IF
 
      SELECT ooaconf,ooa34 INTO g_ooa.ooaconf,g_ooa.ooa34 FROM ooa_file   #No.FUN-540046
       WHERE ooa01 = g_ooa.ooa01
      DISPLAY BY NAME g_ooa.ooaconf,g_ooa.ooa34     #No.FUN-540046
   END IF
 
END FUNCTION
 
FUNCTION t400_comp_oox(p_apv03)
DEFINE l_net     LIKE apv_file.apv04
DEFINE p_apv03   LIKE apv_file.apv03
DEFINE l_apa00   LIKE apa_file.apa00
 
    LET l_net = 0
    IF g_apz.apz27 = 'Y' THEN
       SELECT SUM(oox10) INTO l_net FROM oox_file
        WHERE oox00 = 'AP' AND oox03 = p_apv03
       IF cl_null(l_net) THEN
          LET l_net = 0
       END IF
    END IF
    SELECT apa00 INTO l_apa00 FROM apa_file WHERE apa01=p_apv03
                                              AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
    IF l_apa00 MATCHES '1*' THEN LET l_net = l_net * ( -1) END IF
 
    RETURN l_net
END FUNCTION
 
#取得衝帳單的待扺金額
FUNCTION t400_mntn_offset_inv(p_oob06)
   DEFINE p_oob06   LIKE oob_file.oob06,
          l_oot04t  LIKE oot_file.oot04t,
          l_oot05t  LIKE oot_file.oot05t
 
   SELECT SUM(oot04t),SUM(oot05t) INTO l_oot04t,l_oot05t
     FROM oot_file
    WHERE oot03 = p_oob06
   IF cl_null(l_oot04t) THEN LET l_oot04t = 0 END IF
   IF cl_null(l_oot05t) THEN LET l_oot05t = 0 END IF
   RETURN l_oot04t,l_oot05t
END FUNCTION
 
FUNCTION t400_gen_glcr(p_ooa,p_ooy)
  DEFINE p_ooa     RECORD LIKE ooa_file.*
  DEFINE p_ooy     RECORD LIKE ooy_file.*
  DEFINE l_cnt     LIKE type_file.num5   #MOD-C90151
 
    IF cl_null(p_ooy.ooygslp) THEN
       CALL cl_err(p_ooa.ooa01,'axr-070',1)
       LET g_success = 'N'
       RETURN
    END IF       
   #------------------------MOD-C90151----------------S
    LET l_cnt = 0
    SELECT COUNT(*) INTO l_cnt FROM npq_file
     WHERE npq01 = p_ooa.ooa01 AND npq00= 3
       AND npqsys = 'AR'  AND npq011=1
    IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
    IF l_cnt > 0 THEN
       IF NOT s_ask_entry(p_ooa.ooa01) THEN RETURN END IF
    END IF
   #------------------------MOD-C90151----------------E
    CALL s_t400_gl(p_ooa.ooa01,'0')     #No.FUN-670047 add
    IF g_aza.aza63='Y' THEN         #No.FUN-670047 add
       CALL s_t400_gl(p_ooa.ooa01,'1')  #No.FUN-670047 add
    END IF                          #No.FUN-670047 add
    IF g_success = 'N' THEN RETURN END IF
 
END FUNCTION
 
FUNCTION t400_carry_voucher()
  DEFINE l_ooygslp    LIKE ooy_file.ooygslp
  DEFINE li_result    LIKE type_file.num5      #No.FUN-680123 SMALLINT 
  DEFINE l_dbs        STRING                                                                                                        
  DEFINE l_sql        STRING                                                                                                        
  DEFINE l_n          LIKE type_file.num5      #No.FUN-680123 SMALLINT 
 
    IF NOT cl_confirm('aap-989') THEN RETURN END IF
 
    CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF g_ooy.ooydmy1 = 'N' THEN RETURN END IF
   #IF g_ooy.ooyglcr = 'Y' THEN              #MOD-9C0436 mark
    IF g_ooy.ooyglcr = 'Y' OR (g_ooy.ooyglcr ='N' AND NOT cl_null(g_ooy.ooygslp)) THEN    #MOD-9C0436 add
       LET g_plant_new=g_ooz.ooz02p 
       #CALL s_getdbs() LET l_dbs=g_dbs_new                                                                
       #LET l_sql = " SELECT COUNT(aba00) FROM ",l_dbs,"aba_file",
       LET l_sql = " SELECT COUNT(aba00) FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102        
                   "  WHERE aba00 = '",g_ooz.ooz02b,"'",                                                                               
                   "    AND aba01 = '",g_ooa.ooa33,"'"                                                                                 
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
       PREPARE aba_pre2 FROM l_sql                                                                                                     
       DECLARE aba_cs2 CURSOR FOR aba_pre2                                                                                             
       OPEN aba_cs2                                                                                                                    
       FETCH aba_cs2 INTO l_n                                                                                                          
       IF l_n > 0 THEN                                                                                                                 
          CALL cl_err(g_ooa.ooa33,'aap-991',1)                                                                                         
          RETURN                                                                                                                       
       END IF
 
       LET l_ooygslp = g_ooy.ooygslp
    ELSE
       CALL cl_err('','aap-936',1)     #MOD-9C0436 aap-992 modify aap-936                                                                                                 
       RETURN
       CLOSE WINDOW t200p  
    END IF
    IF cl_null(l_ooygslp) THEN
       CALL cl_err(g_ooa.ooa01,'axr-070',1)
       RETURN
    END IF
    IF g_aza.aza63 = 'Y' AND cl_null(g_ooy.ooygslp1) THEN
       CALL cl_err(g_ooa.ooa01,'axr-070',1)
       RETURN
    END IF
    LET g_wc_gl = 'npp01 = "',g_ooa.ooa01,'" AND npp011 = 1'
    LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",g_ooa.ooauser,"' '",g_ooa.ooauser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",g_ooa.ooa02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",g_ooy.ooygslp1,"'"  #No.TQC-810036
    CALL cl_cmdrun_wait(g_str)
    SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
     WHERE ooa01 = g_ooa.ooa01
    DISPLAY BY NAME g_ooa.ooa33
    
END FUNCTION
 
FUNCTION t400_undo_carry_voucher() 
  DEFINE l_aba19    LIKE aba_file.aba19
  DEFINE l_dbs      STRING 
  DEFINE l_sql      STRING
 
    IF NOT cl_confirm('aap-988') THEN RETURN END IF
 
    CALL s_get_doc_no(g_ooa.ooa01) RETURNING g_t1                                                                                   
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1                                                                          
   #MOD-9C0436---modify---start---
   #IF g_ooy.ooyglcr = 'N' THEN                                                                                                     
   #   CALL cl_err('','aap-990',1)                                                                                                  
    IF g_ooy.ooyglcr = 'N' AND cl_null(g_ooy.ooygslp)THEN
       CALL cl_err('','aap-936',1)
   #MOD-9C0436---modify---end---                                                                                                  
       RETURN                                                                                                                       
    END IF  
    LET g_plant_new=g_ooz.ooz02p 
    #CALL s_getdbs() LET l_dbs=g_dbs_new
    #LET g_dbs_new = l_dbs_new
    #LET l_dbs=l_dbs.trimRight()                                                                                                    
    #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
    LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_plant_new,'aba_file'), #FUN-A50102
                "  WHERE aba00 = '",g_ooz.ooz02b,"'",
                "    AND aba01 = '",g_ooa.ooa33,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql #FUN-A50102
    PREPARE aba_pre1 FROM l_sql
    DECLARE aba_cs1 CURSOR FOR aba_pre1
    OPEN aba_cs1
    FETCH aba_cs1 INTO l_aba19
    IF l_aba19 = 'Y' THEN
       CALL cl_err(g_ooa.ooa33,'axr-071',1)
       RETURN
    END IF
    LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",g_ooa.ooa33,"' 'Y'"
    CALL cl_cmdrun_wait(g_str)
    SELECT ooa33 INTO g_ooa.ooa33 FROM ooa_file
     WHERE ooa01 = g_ooa.ooa01
    DISPLAY BY NAME g_ooa.ooa33
END FUNCTION
 
 
FUNCTION t400_3_1()
 
   IF g_ooa.ooa01 IS NULL THEN
      RETURN
   END IF
 
   IF g_ooa.ooaconf = 'X' THEN
      CALL cl_err('','9024',0)
      RETURN
   END IF
 
   IF NOT cl_chk_act_auth() THEN
      LET g_chr='D'
   ELSE
      LET g_chr='U'
   END IF
 
   BEGIN WORK
   OPEN t400_cl USING g_ooa.ooa01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t400_cl INTO g_ooa.*
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0) 
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
   CALL s_showmsg_init()                   #NO.FUN-710050 
   CALL s_fsgl('AR',3,g_ooa.ooa01,0,g_ooz.ooz02c,1,g_ooa.ooaconf,'1',g_ooz.ooz02p) #No.FUN-680022 add
   CALL s_showmsg()                         #NO.FUN-710050
   CLOSE t400_cl 
   COMMIT WORK
 
END FUNCTION
 
#FUNCTION t400_omc(p_oma00)  #No.MOD-930140         #No.MOD-B80122 mark
FUNCTION t400_omc(p_oma00,p_sw)  #No.MOD-B80122 add
DEFINE   l_omc10           LIKE omc_file.omc10
DEFINE   l_omc11           LIKE omc_file.omc11
DEFINE   l_omc13           LIKE omc_file.omc13
DEFINE   l_oob09           LIKE oob_file.oob09   #MOD-830097
DEFINE   l_oob10           LIKE oob_file.oob10   #MOD-830097
DEFINE   l_oox10           LIKE oox_file.oox10   #No.MOD-930140
DEFINE   p_oma00           LIKE oma_file.oma00   #No.MOD-930140
DEFINE   tot4,tot4t        LIKE type_file.num20_6 #No.MOD-AA0119 
DEFINE   p_sw              LIKE type_file.chr1    #No.MOD-B80122  add 
 
   LET l_oox10 = 0 
   SELECT SUM(oox10) INTO l_oox10 FROM oox_file 
    WHERE oox00 = 'AR'
      AND oox03 = b_oob.oob06 
      AND oox041 = b_oob.oob19
   IF cl_null(l_oox10) THEN LET l_oox10 = 0 END IF 
   IF p_oma00 MATCHES '2*' THEN 
      LET l_oox10 = l_oox10 * -1
   END IF 
 
 #--------------------------------No.MOD-B80122----------------------------start
   IF p_oma00 = '23' THEN
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file, ooa_file
       WHERE oob06=b_oob.oob06 AND oob19 = b_oob.oob19
         AND oob01=ooa01 AND ooa01=g_ooa.ooa01  
         AND ((oob03='1' AND oob04='3') OR (oob03='2' AND oob04='1'))   #FUN-D80031 mark    #No.TQC-DA0003
        #AND ((oob03='1' AND oob04='3') OR (oob03='2' AND oob04='1') OR (oob03='1' AND oob04='H'))  #FUN-D80031 add #No.TQC-DA0003   Mark
      IF cl_null(l_oob09) THEN LET l_oob09 = 0 END IF
      IF cl_null(l_oob10) THEN LET l_oob10 = 0 END IF
     
      SELECT omc10,omc11 INTO l_omc10,l_omc11 FROM omc_file
       WHERE omc01 = b_oob.oob06
         AND omc02 = b_oob.oob19 

      IF p_sw='+' THEN
         LET l_oob09 = l_omc10 + l_oob09 
         LET l_oob10 = l_omc11 + l_oob10
      ELSE
         LET l_oob09 = l_omc10 - l_oob09 
         LET l_oob10 = l_omc11 - l_oob10
      END IF
   ELSE
#--------------------------------No.MOD-B80122-----------------------------end 
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file, ooa_file
       WHERE oob06=b_oob.oob06 AND oob19 = b_oob.oob19 
         AND oob01=ooa01  AND ooaconf = 'Y'
         AND ((oob03='1' AND oob04='3') OR (oob03='2' AND oob04='1'))   #MOD-850027
      IF cl_null(l_oob09) THEN LET l_oob09 = 0 END IF
      IF cl_null(l_oob10) THEN LET l_oob10 = 0 END IF
   END IF                                                   #No.MOD-B80122 add
#No.MOD-AA0119 --begin                                                          
    #取得冲帐单的待抵金额                                                       
    CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t                 
    CALL cl_digcut(tot4,t_azi04) RETURNING tot4       #No.CHI-6A0004            
    CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t     #No.CHI-6A0004            
    LET l_oob09 = l_oob09 +tot4                                                 
    LET l_oob10 = l_oob10 +tot4t                                                
#No.MOD-AA0119 --end
     #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc10=?,omc11=? ",   #MOD-850008
     #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'omc_file'), #FUN-A50102
     LET g_sql=" UPDATE omc_file ", #FUN-A50102
                  " SET omc10=?,omc11=? ",
               " WHERE omc01=? AND omc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t400_bu_13_p3 FROM g_sql
     EXECUTE t400_bu_13_p3 USING l_oob09,l_oob10,b_oob.oob06,b_oob.oob19
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        CALL s_errmsg('omc01',b_oob.oob06,'upd omc10,11','axr-198',1)
        LET g_success = 'N' RETURN
     END IF
     #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"omc_file SET omc13=omc09-omc11+ ",l_oox10,   #No.MOD-930140
     #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'omc_file'), #FUN-A50102
     LET g_sql=" UPDATE omc_file ", #FUN-A50102
                 " SET omc13=omc09-omc11+ ",l_oox10, 
               " WHERE omc01=? AND omc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
     PREPARE t400_bu_13_p4 FROM g_sql
     EXECUTE t400_bu_13_p4 USING b_oob.oob06,b_oob.oob19
     IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
        CALL s_errmsg('omc01',b_oob.oob06,'upd omc13','axr-198',1)
        LET g_success = 'N' RETURN
     END IF
END FUNCTION
 
FUNCTION t400_apc(p_sw)
DEFINE   l_apc10           LIKE apc_file.apc10
DEFINE   l_apc11           LIKE apc_file.apc11
DEFINE   l_apc13           LIKE apc_file.apc13
DEFINE   p_sw              LIKE type_file.chr1  
 
  #LET g_sql=" UPDATE ",g_dbs_new CLIPPED,"apc_file SET apc10=?,apc11=?,apc13=? ",
  #LET g_sql=" UPDATE ",cl_get_target_table(g_plant,'apc_file'), #FUN-A50102
  LET g_sql=" UPDATE apc_file ", #FUN-A50102
               " SET apc10=?,apc11=?,apc13=? ",
            " WHERE apc01=? AND apc02=? "
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql #FUN-A50102
  PREPARE t400_bu_19_p3 FROM g_sql
 
  SELECT apc10,apc11,apc13 INTO l_apc10,l_apc11,l_apc13
    FROM apc_file WHERE apc01=b_oob.oob06 AND apc02=b_oob.oob19
  IF l_apc10 IS NULL THEN LET l_apc10=0 END IF
  IF l_apc11 IS NULL THEN LET l_apc11=0 END IF
  IF l_apc13 IS NULL THEN LET l_apc13=0 END IF
  IF p_sw='+' THEN
     LET l_apc10 = l_apc10 + b_oob.oob09
     LET l_apc11 = l_apc11 + b_oob.oob10
     LET l_apc13 = l_apc13 - b_oob.oob10
     IF NOT cl_null(b_oob.oob19) THEN 
        EXECUTE t400_bu_19_p3 USING l_apc10,l_apc11,l_apc13,b_oob.oob06,b_oob.oob19
        IF STATUS THEN
           LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                            #NO.FUN-710050 
           CALL s_errmsg('apc01,apc02',g_showmsg,'upd apc10,11,13',STATUS,1)                    #NO.FUN-710050
           LET g_success='N'
           RETURN
        END IF
     END IF
  END IF
  IF p_sw='-' THEN
     LET l_apc10 = l_apc10 - b_oob.oob09
     LET l_apc11 = l_apc11 - b_oob.oob10
     LET l_apc13 = l_apc13 + b_oob.oob10
     IF NOT cl_null(b_oob.oob19) THEN 
        EXECUTE t400_bu_19_p3 USING l_apc10,l_apc11,l_apc13,b_oob.oob06,b_oob.oob19
        IF STATUS THEN
           LET g_showmsg=b_oob.oob06,"/",b_oob.oob19                                            #NO.FUN-710050 
           CALL s_errmsg('apc01,apc02',g_showmsg,'upd apc10,11,13',STATUS,1)                    #NO.FUN-710050
           LET g_success='N'
           RETURN
        END IF
     END IF
  END IF
END FUNCTION
 
FUNCTION t400_oob06_chk(p_oob06,p_oob15,p_oob19,p_n)   #MOD-A10084 add oob19
DEFINE p_n           LIKE type_file.num5
DEFINE i             LIKE type_file.num5
DEFINE p_oob06       LIKE oob_file.oob06 
DEFINE p_oob15       LIKE oob_file.oob15
DEFINE p_oob19       LIKE oob_file.oob19      #MOD-A10084 add
 
   LET g_errno = ''
   IF p_n > 1 THEN
      FOR i = 1 TO p_n-1
         IF g_ooz.ooz62 = 'N' THEN
            IF g_oob[i].oob06 = p_oob06 AND
               g_oob[i].oob19 = p_oob19 THEN  #MOD-A10084 add
               LET g_errno = 'atm-310'
               EXIT FOR
            END IF
         ELSE
            IF g_oob[i].oob06 = p_oob06 AND
               g_oob[i].oob19 = p_oob19 AND   #MOD-A10084 add
               g_oob[i].oob15 = p_oob15 THEN
               LET g_errno = 'atm-310'
               EXIT FOR
            END IF
         END IF
      END FOR
   END IF 
    
END FUNCTION
 
FUNCTION t400_bu_2C(p_sw)
   DEFINE p_sw     LIKE type_file.chr1
   DEFINE l_occ    RECORD LIKE occ_file.*
   DEFINE l_omc    RECORD LIKE omc_file.*
   DEFINE l_oma    RECORD LIKE oma_file.*
 
   SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = b_oob.oob07
   INITIALIZE l_occ.* TO NULL
   INITIALIZE l_omc.* TO NULL
   INITIALIZE l_oma.* TO NULL
   IF p_sw = '+'  THEN
      LET l_oma.oma00 = '24' 
      LET l_oma.oma02 = g_ooa.ooa02 
      LET l_oma.oma03 = g_ooa.ooa03
      LET l_oma.oma032 = g_ooa.ooa032
      LET l_oma.oma16 = g_ooa.ooa01
      SELECT * INTO l_occ.* FROM occ_file WHERE occ01=l_oma.oma03
      LET l_oma.oma68 = l_occ.occ07
      SELECT occ02 INTO l_oma.oma69 FROM occ_file WHERE occ01 = l_oma.oma68
      LET l_oma.oma04 = l_oma.oma03
      LET l_oma.oma05 = l_occ.occ08
      LET l_oma.oma21 = l_occ.occ41
      LET l_oma.oma23 = l_occ.occ42
      LET l_oma.oma40 = l_occ.occ37
      LET l_oma.oma25 = l_occ.occ43
      LET l_oma.oma32 = l_occ.occ45
      LET l_oma.oma042= l_occ.occ11
      LET l_oma.oma043= l_occ.occ18
      LET l_oma.oma044= l_occ.occ231
      LET g_plant2 = g_plant     #FUN-980020
      LET g_dbs2 = s_dbstring(g_dbs CLIPPED)   #FUN-9B0106
      CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,l_oma.oma02,g_plant2)  #FUN-980020 mark #TQC-9C0099
           RETURNING l_oma.oma11,l_oma.oma12
      SELECT gec04,gec05,gec07 INTO l_oma.oma211,l_oma.oma212,l_oma.oma213
        FROM gec_file WHERE gec01=l_oma.oma21 AND gec011='2'
      LET l_oma.oma08  = '1'
      IF l_oma.oma23=g_aza.aza17 THEN
         LET l_oma.oma24=1
         LET l_oma.oma58=1
      ELSE
         CALL s_curr3(l_oma.oma23,l_oma.oma02,g_ooz.ooz17) RETURNING l_oma.oma24
         CALL s_curr3(l_oma.oma23,l_oma.oma09,g_ooz.ooz17) RETURNING l_oma.oma58
      END IF
      LET l_oma.oma13 = g_ooa.ooa13
      LET l_oma.oma18 = b_oob.oob11
      IF g_aza.aza63 = 'Y' THEN
         LET l_oma.oma181 = b_oob.oob111
      END IF
      LET l_oma.oma60 = b_oob.oob08
      LET l_oma.oma61 = b_oob.oob10
      LET l_oma.oma70 = '1'
      LET l_oma.oma50 = 0
      LET l_oma.oma50t = 0
      LET l_oma.oma52 = 0
      LET l_oma.oma53 = 0
      LET l_oma.oma54t = b_oob.oob09
      LET l_oma.oma56t=b_oob.oob09*l_oma.oma24
      IF cl_null(l_oma.oma213) THEN LET  l_oma.oma213 = 'N' END IF
      IF cl_null(l_oma.oma211) THEN LET l_oma.oma211 = 0 END IF
      IF l_oma.oma213 = 'N' THEN
         LET l_oma.oma54 = l_oma.oma54t
         LET l_oma.oma56 = l_oma.oma56t
      ELSE
         LET l_oma.oma54 = l_oma.oma54t/(1+l_oma.oma211/100)
         LET l_oma.oma56 = l_oma.oma56t/(1+l_oma.oma211/100)
      END IF
      LET l_oma.oma54x = l_oma.oma54t - l_oma.oma54
      LET l_oma.oma56x = l_oma.oma56t - l_oma.oma56
      CALL cl_digcut(l_oma.oma54,t_azi04) RETURNING l_oma.oma54
      CALL cl_digcut(l_oma.oma54x,t_azi04) RETURNING l_oma.oma54x
      CALL cl_digcut(l_oma.oma54t,t_azi04) RETURNING l_oma.oma54t
      CALL cl_digcut(l_oma.oma56,g_azi04) RETURNING l_oma.oma56
      CALL cl_digcut(l_oma.oma56x,g_azi04) RETURNING l_oma.oma56x
      CALL cl_digcut(l_oma.oma56t,g_azi04) RETURNING l_oma.oma56t
      LET l_oma.oma55 = 0
      LET l_oma.oma57 = 0
      LET l_oma.oma51f= 0
      LET l_oma.oma51 = 0
      LET l_oma.omaconf = 'Y'
      LET l_oma.omavoid = 'N'
      LET l_oma.omauser = g_user
      LET l_oma.omagrup = g_grup
      LET l_oma.oma64 = '1'
      LET l_oma.oma65 = '1' 
      CALL s_auto_assign_no("axr",g_ooz.ooz22,g_ooa.ooa02,"24","oma_file","oma01","","","")
           RETURNING li_result,l_oma.oma01
      IF (NOT li_result) THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,l_oma.oma01,'mfg-059',1)   #No.FUN-D40089  Mod '','' --> 'ooa01',g_ooa.ooa01
         LET g_success = 'N'
         RETURN
      END IF 
 
      CALL s_ar_oox03(l_oma.oma01) RETURNING g_net
      LET l_omc.omc01 = l_oma.oma01
      LET l_omc.omc02 = 1
      LET l_omc.omc03 = l_oma.oma32
      LET l_omc.omc04 = l_oma.oma11
      LET l_omc.omc05 = l_oma.oma12
      LET l_omc.omc06 = l_oma.oma24
      LET l_omc.omc07 = l_oma.oma60
      LET l_omc.omc08 = l_oma.oma54t
      LET l_omc.omc09 = l_oma.oma56t
      LET l_omc.omc10 = 0
      LET l_omc.omc11 = 0
      LET l_omc.omc12 = l_oma.oma10
      LET l_omc.omc13 = l_omc.omc09-l_omc.omc11+g_net
      LET l_omc.omc14 = 0
      LET l_omc.omc15 = 0
      CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08
      CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09
      CALL cl_digcut(l_omc.omc13,g_azi04) RETURNING l_omc.omc13
      LET l_oma.omalegal = g_ooa.ooalegal
      LET l_omc.omclegal = g_ooa.ooalegal
 
      LET l_oma.omaoriu = g_user      #No.FUN-980030 10/01/04
      LET l_oma.omaorig = g_grup      #No.FUN-980030 10/01/04
#No.FUN-AB0034 --begin
    IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
    IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
    IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
      INSERT INTO oma_file VALUES(l_oma.*)
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,'ins oma err',SQLCA.sqlcode,1)    #No.FUN-D40089  Mod '','' --> 'ooa01',g_ooa.ooa01
         LET g_success = 'N'
      END IF
      INSERT INTO omc_file VALUES(l_omc.*)
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,'ins omc err',SQLCA.sqlcode,1)     #No.FUN-D40089  Mod '','' --> 'ooa01',g_ooa.ooa01
         LET g_success = 'N'
      END IF
      UPDATE oob_file SET oob06 = l_oma.oma01
       WHERE oob01 = b_oob.oob01 AND oob02 = b_oob.oob02
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('ooa01',g_ooa.ooa01,'upd oob err',SQLCA.sqlcode,1)    #No.FUN-D40089  Mod '','' --> 'ooa01',g_ooa.ooa01
         LET g_success = 'N'
      END IF
   END IF
 
   IF p_sw = '-' THEN
      INITIALIZE l_oma.* TO NULL
      SELECT oma33,oma55,oma57 
        INTO l_oma.oma33,l_oma.oma55,l_oma.oma57 
        FROM oma_file
       WHERE oma01 = b_oob.oob06
      IF NOT cl_null(l_oma.oma33) THEN
         CALL s_errmsg('oob06',b_oob.oob06,b_oob.oob01,'axr-417',1)    #No.FUN-D40089  Mod '',b_oob.oob06 --> b_oob.oob06,b_oob.oob01
         LET g_success = 'N'
      END IF
      IF l_oma.oma55>0 OR l_oma.oma57>0 THEN 
         CALL s_errmsg('oob06',b_oob.oob06,b_oob.oob01,'alm-915',1)    #No.FUN-D40089  Mod '',b_oob.oob06 --> b_oob.oob06,b_oob.oob01 
         LET g_success = 'N'
      END IF 
      DELETE FROM oma_file WHERE oma01 = b_oob.oob06
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06',b_oob.oob06,b_oob.oob01,SQLCA.sqlcode,1)   #No.FUN-D40089  Mod '','del oma' --> b_oob.oob06,b_oob.oob01
         LET g_success = 'N'
      END IF
      DELETE FROM omc_file WHERE omc01 = b_oob.oob06 
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06',b_oob.oob06,b_oob.oob01,SQLCA.sqlcode,1)   #No.FUN-D40089  Mod '','del omc' --> b_oob.oob06,b_oob.oob01
         LET g_success = 'N'
      END IF
      UPDATE oob_file SET oob06 = NULL
       WHERE oob01 = b_oob.oob01 AND oob02 = b_oob.oob02
      IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
         CALL s_errmsg('oob06',b_oob.oob06,b_oob.oob01,SQLCA.sqlcode,1)   #No.FUN-D40089  Mod '','upd oob' --> b_oob.oob06,b_oob.oob01
         LET g_success = 'N'
      END IF
   END IF
END FUNCTION
#No.FUN-9C0072 精簡程式碼
#No.FUN-A30106 --begin                                                          
FUNCTION t400_drill_down()                                                      
                                                                                
   IF cl_null(g_ooa.ooa33) THEN RETURN END IF                                   
   LET g_msg = "aglt110 '",g_ooa.ooa33,"'"                                      
   CALL cl_cmdrun(g_msg)                                                        
END FUNCTION                                                                    
#No.FUN-A30106 --end 
 
#No.FUN-A40076 --begin
FUNCTION t400_oof_b_fill()
   DEFINE l_sql           STRING     
   DEFINE l_rec_ape_b     LIKE type_file.num10    
 
  
   OPEN WINDOW t400_axr_w1 AT 12,2 WITH FORM "axr/42f/axrt400_c"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) 
 
    CALL cl_ui_locale("axrt400_c")
      
   IF g_aza.aza63 = 'Y' THEN
      CALL cl_set_comp_visible("oof101",TRUE)
   ELSE
      CALL cl_set_comp_visible("oof101",FALSE)
   END IF
 
   CALL g_oof.clear()
   LET g_cnt =1
   
   LET l_sql ="SELECT oof02,oof03,oof032,oof04,oof042,oof05,oof06,oof10,oof101,oof07,oof08,oof09f,oof09 ",
              "  FROM oof_file",
              " WHERE oof01 = ?",
              " ORDER BY oof02"
   PREPARE t400_oof_pb1 FROM l_sql                                                                                                       
   DECLARE oof_curs1 CURSOR FOR t400_oof_pb1
 
   CALL g_oof.clear()
   FOREACH oof_curs1 USING g_ooa.ooa01 INTO g_oof[g_cnt].*      
      IF SQLCA.sqlcode THEN                                                                                                         
         CALL cl_err('foreach:',SQLCA.sqlcode,1)                                                                                    
         EXIT FOREACH                                                                                                               
      END IF
      IF cl_null(g_oof[g_cnt].oof09f) THEN
         LET g_oof[g_cnt].oof09f =0
      END IF
      IF cl_null(g_oof[g_cnt].oof09) THEN
         LET g_oof[g_cnt].oof09 =0
      END IF

      LET g_cnt = g_cnt + 1                                                                                                         
      IF g_cnt > g_max_rec THEN                                                                                                     
         CALL cl_err( '', 9035, 0 )                                                                                                 
         EXIT FOREACH                                                                                                               
      END IF                                                                                                                        
   END FOREACH
   CALL g_oof.deleteElement(g_cnt)                                                                                                  

   LET l_rec_ape_b = g_cnt -1                                                                                       
   DISPLAY l_rec_ape_b TO FORMONLY.cnk

   DISPLAY ARRAY g_oof TO s_oof.* ATTRIBUTE(COUNT=l_rec_ape_b,UNBUFFERED)

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about        
         CALL cl_about()     
 
      ON ACTION help         
         CALL cl_show_help() 
 
      ON ACTION controlg     
         CALL cl_cmdask()     

    #  ON ACTION accept     
    #     EXIT DISPLAY

    #  ON ACTION cancel     
    #     EXIT DISPLAY

      IF INT_FLAG THEN
         CALL cl_err('',9001,0)
         LET INT_FLAG = 0
         EXIT DISPLAY
      END IF
  
   END DISPLAY

   CLOSE WINDOW t400_axr_w1
   
END FUNCTION 

FUNCTION t400_diff1()
   DEFINE l_sql           STRING   
   DEFINE p_cmd           LIKE type_file.chr1    
   DEFINE l_amt,l_net     LIKE oof_file.oof07
   DEFINE l_lock_sw       LIKE type_file.chr1     
   DEFINE l_modify_flag   LIKE type_file.chr1   
   DEFINE g_temp          STRING  
   DEFINE
          l_allow_insert  LIKE type_file.num5,  
          l_allow_delete  LIKE type_file.num5,   
          l_allow_update  LIKE type_file.num5    
   DEFINE l_rec_ape_b     LIKE type_file.num10    
   DEFINE l_n,l_i         LIKE type_file.num10    
   DEFINE l_sum,l_sumf    LIKE oof_file.oof09
   DEFINE i               LIKE type_file.num5
   DEFINE li_result       LIKE type_file.num5
   DEFINE l_sumoof09      LIKE oof_file.oof09
   DEFINE l_ooyacti       LIKE ooy_file.ooyacti
   DEFINE l_cnt           LIKE type_file.num5
   DEFINE l_smu02         LIKE smu_file.smu02
   DEFINE l_smv02         LIKE smv_file.smv02
   DEFINE g_flag1         LIKE type_file.chr1
   DEFINE l_aag05         LIKE aag_file.aag05
   DEFINE l_aag05a        LIKE aag_file.aag05
 
  
   OPEN WINDOW t400_axr_w AT 12,2 WITH FORM "axr/42f/axrt400_c"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) 
 
    CALL cl_ui_locale("axrt400_c")
      
   IF g_aza.aza63 = 'Y' THEN
      CALL cl_set_comp_visible("oof101",TRUE)
   ELSE
      CALL cl_set_comp_visible("oof101",FALSE)
   END IF
 
   CALL g_oof.clear()
   LET g_cnt =1
 
   LET l_sql ="SELECT oof02,oof03,oof032,oof04,oof042,oof05,oof06,oof10,oof101,oof07,oof08,oof09f,oof09 ",
              "  FROM oof_file",
              " WHERE oof01 = ?",
              "   AND oof02 = ?",
              " ORDER BY oof02"
   PREPARE t400_oof_pb_bcl FROM l_sql                                                                                                       
   DECLARE oof_curs_bcl CURSOR FOR t400_oof_pb_bcl
   
   LET l_sql ="SELECT oof02,oof03,oof032,oof04,oof042,oof05,oof06,oof10,oof101,oof07,oof08,oof09f,oof09 ",
              "  FROM oof_file",
              " WHERE oof01 = ?",
              " ORDER BY oof02"
   PREPARE t400_oof_pb FROM l_sql                                                                                                       
   DECLARE oof_curs CURSOR FOR t400_oof_pb
 
   CALL g_oof.clear()
   FOREACH oof_curs USING g_ooa.ooa01 INTO g_oof[g_cnt].*      
      IF SQLCA.sqlcode THEN                                                                                                         
         CALL cl_err('foreach:',SQLCA.sqlcode,1)                                                                                    
         EXIT FOREACH                                                                                                               
      END IF
      IF cl_null(g_oof[g_cnt].oof09f) THEN
         LET g_oof[g_cnt].oof09f =0
      END IF
      IF cl_null(g_oof[g_cnt].oof09) THEN
         LET g_oof[g_cnt].oof09 =0
      END IF

      LET g_cnt = g_cnt + 1                                                                                                         
      IF g_cnt > g_max_rec THEN                                                                                                     
         CALL cl_err( '', 9035, 0 )                                                                                                 
         EXIT FOREACH                                                                                                               
      END IF                                                                                                                        
   END FOREACH
   CALL g_oof.deleteElement(g_cnt)                                                                                                  
                                                                                                                                    
   LET l_rec_ape_b = g_cnt -1                                                                                       
   DISPLAY l_rec_ape_b TO FORMONLY.cnk


   LET l_ac1= 1
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")

   INPUT ARRAY g_oof WITHOUT DEFAULTS FROM s_oof.*
         ATTRIBUTE(COUNT=l_rec_ape_b,MAXCOUNT=g_max_rec,UNBUFFERED,             
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
      BEFORE INSERT
         LET l_ac1 = ARR_CURR()
         LET p_cmd='a'
         INITIALIZE g_oof[l_ac1].* TO NULL
         LET g_oof_t.* = g_oof[l_ac1].*
         LET g_oof[l_ac1].oof06 = g_today
         LET g_oof[l_ac1].oof09f = 0 
         LET g_oof[l_ac1].oof09  = 0
         LET g_oof[l_ac1].oof05  = g_ooz.ooz26 
         NEXT FIELD oof02
 
      AFTER INSERT
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         INSERT INTO oof_file(oof01,oof02,oof03,oof032,oof04,oof042,oof05,oof06,oof10,oof101,oof07,oof08,oof09f,oof09,ooflegal,ooforiu,ooforig) 
          VALUES(g_ooa.ooa01,g_oof[l_ac1].oof02,g_oof[l_ac1].oof03,g_oof[l_ac1].oof032,
                 g_oof[l_ac1].oof04,g_oof[l_ac1].oof042,g_oof[l_ac1].oof05,
                 g_oof[l_ac1].oof06,g_oof[l_ac1].oof10,g_oof[l_ac1].oof101,
                 g_oof[l_ac1].oof07,g_oof[l_ac1].oof08,
                 g_oof[l_ac1].oof09f,g_oof[l_ac1].oof09,g_legal,g_user,g_grup) 
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","oof_file",g_ooa.ooa01,g_oof[l_ac1].oof02,SQLCA.sqlcode,"","ins oof:",1)  
            LET g_success = 'N'
            CANCEL INSERT
         ELSE
            LET l_rec_ape_b = l_rec_ape_b + 1
            MESSAGE "insert ok"
            DISPLAY l_rec_ape_b TO FORMONLY.cnk
         END IF 
 
      BEFORE INPUT
         IF l_rec_ape_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac1)
         END IF
 
      BEFORE ROW
         LET p_cmd = ''
         LET l_ac1 = ARR_CURR()
         LET l_lock_sw = 'N'
         IF l_rec_ape_b >= l_ac1 THEN
            LET p_cmd='u'
            LET g_oof_t.* = g_oof[l_ac1].*
            OPEN oof_curs_bcl USING g_ooa.ooa01,g_oof_t.oof02                                                                          
            IF STATUS THEN                                                                                                          
               CALL cl_err("OPEN i010_bcl:", STATUS, 1)                                                                             
               LET l_lock_sw = "Y"                                                                                                  
            ELSE                                                                                                                    
               FETCH oof_curs_bcl INTO g_oof[l_ac1].*                                                                                    
               IF SQLCA.sqlcode THEN                                                                                                
                  CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,1)                                                                      
                  LET l_lock_sw = "Y"                                                                                               
               END IF
            END IF        
         END IF
 
      BEFORE FIELD oof02
         IF cl_null(g_oof[l_ac1].oof02) OR g_oof[l_ac1].oof02 = 0 THEN
            SELECT MAX(oof02)+1 INTO g_oof[l_ac1].oof02 FROM oof_file
             WHERE oof01 = g_ooa.ooa01
            IF cl_null(g_oof[l_ac1].oof02)  THEN
               LET g_oof[l_ac1].oof02 = 1
            END IF
         END IF
 
      AFTER FIELD oof02
         IF g_oof_t.oof02 IS NULL OR
            g_oof_t.oof02 != g_oof[l_ac1].oof02 THEN
            SELECT COUNT(*) INTO g_cnt FROM oof_file
                WHERE oof01 = g_ooa.ooa01 AND oof02 = g_oof[l_ac1].oof02
            IF g_cnt > 0 THEN
               CALL cl_err('',-239,0)
               NEXT FIELD oof02
            END IF
         END IF
 
 
      AFTER FIELD oof03
         IF NOT cl_null(g_oof[l_ac1].oof03) THEN
            IF g_oof_t.oof03 IS NULL OR g_oof[l_ac1].oof03 != g_oof_t.oof03 THEN
               CALL t400_oof03(l_ac1) RETURNING g_oof[l_ac1].oof032
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_oof[l_ac1].oof03,g_errno,0)
                  LET g_oof[l_ac1].oof03 = g_oof_t.oof03
                  DISPLAY BY NAME g_oof[l_ac1].oof03
                  NEXT FIELD oof03
               END IF
               DISPLAY BY NAME g_oof[l_ac1].oof03
            END IF
            LET g_oof_t.oof03 = g_oof[l_ac1].oof03
         END IF
 
      AFTER FIELD oof04
         IF NOT cl_null(g_oof[l_ac1].oof04) THEN
            IF g_oof_t.oof04 IS NULL OR g_oof[l_ac1].oof04 != g_oof_t.oof04 THEN
               CALL t400_oof04('a')
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_oof[l_ac1].oof04,g_errno,0)
                  LET g_oof[l_ac1].oof04 = g_oof_t.oof04
                  NEXT FIELD oof04
               END IF
            END IF
         END IF
         LET g_oof_t.oof04 = g_oof[l_ac1].oof04    
         

      AFTER FIELD oof05             
         IF NOT cl_null(g_oof[l_ac1].oof05) THEN   
            IF p_cmd = 'a' OR (p_cmd = 'u' AND g_oof[l_ac1].oof05 != g_oof_t.oof05) THEN
              LET l_ooyacti = NULL
              SELECT ooyacti INTO l_ooyacti FROM ooy_file
               WHERE ooyslip = g_oof[l_ac1].oof05
              IF l_ooyacti <> 'Y' THEN
                 CALL cl_err(g_oof[l_ac1].oof05,'axr-956',1)
                 NEXT FIELD oof05
              END IF
              LET l_cnt=0
              LET g_sql = " SELECT count(*) FROM smu_file",
                          "  WHERE smu01 = '",g_oof[l_ac1].oof05,"'",
                          "    AND upper(smu03) = 'AXR'"
              PREPARE sel_smu_pre46 FROM g_sql
              EXECUTE sel_smu_pre46 INTO l_cnt
              IF l_cnt > 0 THEN
                 LET g_sql = " SELECT smu02 FROM smu_file",
                             "  WHERE smu01 = '",g_oof[l_ac1].oof05,"'",
                             "    AND upper(smu03) = 'AXR'"
                 DECLARE smu_c CURSOR FROM g_sql
                 FOREACH smu_c INTO l_smu02
                    IF l_smu02 <> g_user THEN
                       CONTINUE FOREACH
                    ELSE
                       EXIT FOREACH
                    END IF
                 END FOREACH
                 IF l_smu02 <> g_user THEN
                    CALL cl_err('','axr-011',0)
                    NEXT FIELD oof05
                 END IF
              END IF
              LET l_cnt=0
              LET g_sql = " SELECT count(*) FROM smv_file",
                          "  WHERE smv01 = '",g_oof[l_ac1].oof05,"'",
                          "    AND upper(smv03) = 'AXR'"
              PREPARE sel_smv_pre47 FROM g_sql
              EXECUTE sel_smv_pre47 INTO l_cnt
              IF l_cnt > 0 THEN
                 LET g_sql = " SELECT smv02 FROM smv_file",
                             "  WHERE smv01 = '",g_oof[l_ac1].oof05,"'",
                             "    AND upper(smv03) = 'AXR'"
                 DECLARE smv_c CURSOR FROM g_sql
                 FOREACH smv_c INTO l_smv02
                    IF l_smv02 <> g_grup THEN
                       CONTINUE FOREACH
                    ELSE
                       EXIT FOREACH
                    END IF
                 END FOREACH
                 IF l_smv02 <> g_grup THEN
                    CALL cl_err('','axr-012',0)
                    NEXT FIELD oof05
                 END IF
              END IF            
               CALL s_check_no("axr",g_oof[l_ac1].oof05,g_oof_t.oof05,'14',"oma_file","oma01","")
               RETURNING li_result,g_oof[l_ac1].oof05
               IF (NOT li_result) THEN
                  LET g_oof[l_ac1].oof05=g_oof_t.oof05
                  NEXT FIELD oof05
               END IF               
            END IF
         END IF   
 
         
      AFTER FIELD oof06
         IF NOT cl_null(g_oof[l_ac1].oof06) THEN  
            IF g_oof_t.oof06 IS NULL OR g_oof[l_ac1].oof06 != g_oof_t.oof06 THEN           
               IF g_oof[l_ac1].oof06 <= g_ooz.ooz09 THEN
                  CALL cl_err('','axr-164',0) NEXT FIELD oof06
               END IF
              #CALL s_get_bookno(year(g_oof[l_ac1].oof06))   #MOD-CB0277 mark
              #     RETURNING g_flag1,g_bookno1,g_bookno2    #MOD-CB0277 mark
               CALL s_get_bookno(YEAR(g_ooa.ooa02))          #MOD-CB0277 add
                    RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
               IF g_flag1='1' THEN 
                  CALL cl_err(g_oof[l_ac1].oof06,'aoo-081',1)
                  NEXT FIELD oof06
               END IF
            END IF 
         END IF       
 
      AFTER FIELD oof07
         IF NOT cl_null(g_oof[l_ac1].oof07) THEN
            IF g_oof_t.oof07 IS NULL OR g_oof[l_ac1].oof07 != g_oof_t.oof07 THEN
               CALL t400_oof07('a')
               IF NOT cl_null(g_errno) THEN
                  CALL cl_err(g_oof[l_ac1].oof07,g_errno,0)
                  LET g_oof[l_ac1].oof07 = g_oof_t.oof07
                  NEXT FIELD oof07
               END IF
            END IF
         END IF
         LET g_oof_t.oof07 = g_oof[l_ac1].oof07   

      AFTER FIELD oof08
          IF g_oof[l_ac1].oof07 =g_aza.aza17 THEN
             LET g_oof[l_ac1].oof08=1
          END IF
          IF NOT cl_null(g_oof[l_ac1].oof08) THEN
             IF g_oof_t.oof08 IS NULL OR g_oof[l_ac1].oof08 != g_oof_t.oof08 THEN 
                IF g_oof[l_ac1].oof08 < 0 THEN
                   CALL cl_err('','aec-020',0)
                   LET g_oof[l_ac1].oof08 = g_oof_t.oof08
                   NEXT FIELD oof08
                END IF
                IF g_oof[l_ac1].oof08 = 0 THEN
                   CALL cl_err('oof08 is null ','aap-099',0)
                   LET g_oof[l_ac1].oof08 = g_oof_t.oof08
                   NEXT FIELD oof08
                END IF
                LET g_oof[l_ac1].oof09 = g_oof[l_ac1].oof09f * g_oof[l_ac1].oof08
             END IF
          END IF
          LET g_oof_t.oof08 = g_oof[l_ac1].oof08 

      AFTER FIELD oof09f
          SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oof[l_ac1].oof07
          LET g_oof[l_ac1].oof09f = cl_digcut(g_oof[l_ac1].oof09f,t_azi04)   
          IF g_oof[l_ac1].oof09f<>g_oof_t.oof09f OR cl_null(g_oof_t.oof09f) THEN            
             CALL t400_oof09f()
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_oof[l_ac1].oof07,g_errno,0)
                LET g_oof[l_ac1].oof09f = g_oof_t.oof09f
                NEXT FIELD oof09f
             END IF
          END IF

      AFTER FIELD oof09
          SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oof[l_ac1].oof07
          LET g_oof[l_ac1].oof09 = cl_digcut(g_oof[l_ac1].oof09,t_azi04)   
          IF g_oof[l_ac1].oof09<>g_oof_t.oof09 OR cl_null(g_oof_t.oof09) THEN            
             CALL t400_oof09()
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_oof[l_ac1].oof07,g_errno,0)
                LET g_oof[l_ac1].oof09 = g_oof_t.oof09
                NEXT FIELD oof09
             END IF
          END IF 

       AFTER FIELD oof10
          LET l_aag05=''  
          IF NOT cl_null(g_oof[l_ac1].oof10) THEN
             SELECT aag05 INTO l_aag05  
               FROM aag_file
              WHERE aag01=g_oof[l_ac1].oof10
                AND aag00=g_bookno1  
                AND aag07 IN ('2','3') 
                AND aag03 = '2'   #No.FUN-AA0088 yinhy
             IF STATUS THEN
                #No.FUN-AA0088 yinhy --Begin
                #CALL cl_err3("sel","aag_file",g_oof[l_ac1].oof10,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oof[l_ac1].oof10,"",STATUS,"","select aag",0)  
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_aag"
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 = g_oof[l_ac1].oof10
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2') AND aagacti = 'Y' AND aag01 LIKE '",g_oof[l_ac1].oof10 CLIPPED,"%'"
                LET g_qryparam.arg1=g_bookno1                  
                CALL cl_create_qry() RETURNING g_oof[l_ac1].oof10
                #No.FUN-AA0088 yinhy --End
                NEXT FIELD oof10
             END IF 
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
                IF NOT cl_null(g_ooa.ooa15) THEN 
                   CALL s_chkdept(g_aaz.aaz72,g_oof[l_ac1].oof10,g_ooa.ooa15,g_bookno1)  
                                 RETURNING g_errno
                END IF 
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oof10
                END IF
             END IF 
          END IF          
          
       AFTER FIELD oof101
          LET l_aag05a=''       
          IF NOT cl_null(g_oof[l_ac1].oof101) THEN
             SELECT aag05 INTO l_aag05a    
               FROM aag_file
              WHERE aag01=g_oof[l_ac1].oof101
                AND aag00=g_bookno2   
                AND aag07 IN ('2','3') 
                AND aag03 = '2'    #No.FUN-AA0088 yinhy
             IF STATUS THEN
                #No.FUN-AA0088 yinhy --Begin
                #CALL cl_err3("sel","aag_file",g_oof[l_ac1].oof101,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oof[l_ac1].oof101,"",STATUS,"","select aag",0)  
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_aag"
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 = g_oof[l_ac1].oof101
                LET g_qryparam.arg1 = g_bookno2   
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 IN ('2')  AND aagacti = 'Y' AND aag01 LIKE '",g_oof[l_ac1].oof101 CLIPPED,"%'"                                  
                CALL cl_create_qry() RETURNING g_oof[l_ac1].oof101
                #No.FUN-AA0088 yinhy --End
                NEXT FIELD oof101
             END IF 
             LET g_errno = ' '   
             IF l_aag05a = 'Y' THEN
                IF NOT cl_null(g_ooa.ooa15) THEN 
                   CALL s_chkdept(g_aaz.aaz72,g_oof[l_ac1].oof101,g_ooa.ooa15,g_bookno2)  
                                 RETURNING g_errno
                END IF 
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oof101
                END IF
             END IF
          END IF
         
      ON ACTION CONTROLP
           CASE
               WHEN INFIELD(oof03)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_occ"
                    LET g_qryparam.default1 = g_oof[l_ac1].oof03
                    CALL cl_create_qry() RETURNING g_oof[l_ac1].oof03
                    NEXT FIELD oof03
               WHEN INFIELD(oof04)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ="q_occ11"
                    LET g_qryparam.default1 = g_oof[l_ac1].oof04
                    CALL cl_create_qry() RETURNING g_oof[l_ac1].oof04
                    NEXT FIELD oof04
               WHEN INFIELD(oof05)
                    CALL s_get_doc_no(g_oof[l_ac1].oof05) RETURNING g_t1          
                    CALL cl_init_qry_var()
                    CALL q_ooy( FALSE, FALSE, g_t1,'14','AXR') RETURNING g_t1    
                     LET g_oof[l_ac1].oof05=g_t1                              
                     NEXT FIELD oof05  
               WHEN INFIELD(oof10)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_aag"
                    LET g_qryparam.default1 = g_oof[l_ac1].oof10
                    LET g_qryparam.where = " aag07 IN ('2','3') AND ",
                                           " aag03 IN ('2') "
                    LET g_qryparam.arg1=g_bookno1                  
                    CALL cl_create_qry() RETURNING g_oof[l_ac1].oof10
                    NEXT FIELD oof10
               WHEN INFIELD(oof101)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_aag"
                    LET g_qryparam.default1 = g_oof[l_ac1].oof101
                    LET g_qryparam.where = " aag07 IN ('2','3') AND ",
                                           " aag03 IN ('2') "
                    LET g_qryparam.arg1 = g_bookno2                      
                    CALL cl_create_qry() RETURNING g_oof[l_ac1].oof101
                    NEXT FIELD oof101
               WHEN INFIELD(oof07)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azi"
                    LET g_qryparam.default1 = g_oof[l_ac1].oof07
                    CALL cl_create_qry() RETURNING g_oof[l_ac1].oof07
                    NEXT FIELD oof07
           END CASE
 
        BEFORE DELETE                          
           IF g_oof[l_ac1].oof02 > 0 AND g_oof_t.oof02 IS NOT NULL THEN
              IF NOT cl_delb(0,0) THEN
                 CANCEL DELETE
              END IF
              DELETE FROM oof_file
               WHERE oof01 = g_ooa.ooa01 AND oof02 = g_oof_t.oof02
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("del","oof_file",g_ooa.ooa01,g_oof_t.oof02,SQLCA.sqlcode,"","",1)  
                 CANCEL DELETE
              END IF
              DELETE FROM oma_file WHERE oma01 = g_oof[l_ac1].oof05
              LET l_rec_ape_b = l_rec_ape_b - 1
              MESSAGE "delete ok"
           END IF
 
 
      ON ROW CHANGE
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             LET g_oof[l_ac1].* = g_oof_t.*
             LET g_success = 'N'
             EXIT INPUT
          END IF
          IF l_lock_sw = 'Y' THEN
             CALL cl_err(g_oof[l_ac].oof02,-263,1)
             LET g_oof[l_ac].* = g_oof_t.*
          ELSE
             UPDATE oof_file SET oof02 = g_oof[l_ac1].oof02,
                                 oof03 = g_oof[l_ac1].oof03,
                                 oof032 = g_oof[l_ac1].oof032,
                                 oof04 = g_oof[l_ac1].oof04,
                                 oof042 = g_oof[l_ac1].oof042,
                                 oof05 = g_oof[l_ac1].oof05,
                                 oof06 = g_oof[l_ac1].oof06,
                                 oof07 = g_oof[l_ac1].oof07,
                                 oof08 = g_oof[l_ac1].oof08,
                                 oof09f = g_oof[l_ac1].oof09f,
                                 oof09 = g_oof[l_ac1].oof09,
                                 oof10 = g_oof[l_ac1].oof10,
                                 oof101 = g_oof[l_ac1].oof101                                 
             WHERE oof01 = g_ooa.ooa01
               AND oof02 = g_oof_t.oof02 
             IF STATUS OR SQLCA.SQLCODE THEN
                CALL cl_err3("upd","oof_file",g_ooa.ooa01,g_oof_t.oof02,SQLCA.sqlcode,"","upd ape:",1)   
                LET g_success = 'N'
                LET g_oof[l_ac1].* = g_oof_t.*
             ELSE 
                MESSAGE "update ok"
                IF g_oof[l_ac1].oof05 != g_oof_t.oof05 THEN
                   DELETE FROM oma_file WHERE oma01 = g_oof_t.oof05
                END IF   
             END IF 
          END IF
 
      AFTER ROW
          LET l_ac = ARR_CURR()
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             IF p_cmd = 'u' THEN
                LET g_oof[l_ac].* = g_oof_t.*
             #FUN-D30032--add--str--
             ELSE
                CALL g_oof.deleteElement(l_ac)
             #FUN-D30032--add--end--
             END IF
             LET g_success = 'N'
             EXIT INPUT
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
  
      ON ACTION controls                       #No.FUN-6B0033                                                                       
         CALL cl_set_head_visible("","AUTO")   #No.FUN-6B0033
 
   END INPUT

   IF INT_FLAG THEN
      LET g_success='N'
      LET INT_FLAG = 0
   END IF
 
   LET l_sumoof09 = 0
   SELECT SUM(oof09) INTO l_sumoof09
     FROM oof_file
    WHERE oof01 = g_ooa.ooa01
   IF cl_null(l_sumoof09) THEN
      LET l_sumoof09 = 0
   END IF
   UPDATE ooa_file
      SET ooa33d = l_sumoof09
    WHERE ooa01 = g_ooa.ooa01    
  
   CLOSE WINDOW t400_axr_w

   SELECT ooa33d INTO g_ooa.ooa33d
     FROM ooa_file
    WHERE ooa01 = g_ooa.ooa01    
   IF cl_null(g_ooa.ooa33d) THEN
      LET g_ooa.ooa33d = 0
   END IF
   DISPLAY BY NAME g_ooa.ooa33d
       
   CALL t400_show_amt()   
   
   CALL t400_b_fill('1=1')
   CALL t400_b_fill_2('1=1') #FUN-A90003 Add

END FUNCTION 

FUNCTION t400_oof03(l_n)
   DEFINE l_n       LIKE type_file.num5     
   DEFINE l_occ02   LIKE occ_file.occ02
   DEFINE l_occacti LIKE occ_file.occacti

 
   LET g_errno = ''
   SELECT occ02,occacti
     INTO l_occ02,l_occacti
     FROM occ_file WHERE occ01 = g_oof[l_n].oof03
 
   LET g_errno = ''
 
   CASE
       WHEN l_occacti = 'N'   LET g_errno = '9028'
       WHEN STATUS=100        LET g_errno = 'aom-061'  
       WHEN SQLCA.SQLCODE != 0
         LET g_errno = SQLCA.SQLCODE USING '-----'
   END CASE 
 
   IF cl_null(g_errno)  THEN
      RETURN l_occ02
   ELSE 
      RETURN ' '
   END IF
 
END FUNCTION

FUNCTION t400_oof04(p_cmd)
   DEFINE p_cmd   LIKE type_file.chr1     
   DEFINE l_occ02 LIKE occ_file.occ02
   DEFINE l_occ06 LIKE occ_file.occ06
   DEFINE l_occ42 LIKE occ_file.occ42
   DEFINE l_occacti LIKE occ_file.occacti
 
   LET l_occ02 = ''
   LET g_errno = ''
 
   SELECT occ02,occ06,occ42,occacti
     INTO l_occ02,l_occ06,l_occ42,l_occacti
     FROM occ_file
    WHERE occ01 = g_oof[l_ac1].oof04
 
 
   CASE
      WHEN SQLCA.SQLCODE = 100         LET g_errno = 'aom-061'
      WHEN l_occacti = 'N'             LET g_errno = '9028'
      WHEN l_occ06 NOT MATCHES '[1,3]' LET g_errno = 'axr-604'
      WHEN SQLCA.SQLCODE != 0
         LET g_errno = SQLCA.SQLCODE USING '-----'
   END CASE
 
   IF NOT cl_null(g_errno) THEN
      LET g_oof[l_ac1].oof042 = '' 
      LET g_oof[l_ac1].oof07 = ''
      RETURN
   END IF
 
   IF p_cmd = 'd' THEN
      RETURN
   END IF
 
   LET g_oof[l_ac1].oof042 = l_occ02 
 
   LET g_oof[l_ac1].oof07 = l_occ42
 
   CALL t400_oof07(p_cmd)   

 
END FUNCTION

FUNCTION t400_oof07(p_cmd)
   DEFINE p_cmd     LIKE type_file.chr1   
   DEFINE l_aziacti LIKE azi_file.aziacti 

 
   LET g_errno = ''
   SELECT azi03,azi04,azi07,aziacti INTO t_azi03,t_azi04,t_azi07,l_aziacti   
     FROM azi_file  WHERE azi01 = g_oof[l_ac1].oof07  
 
 
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET g_errno = 'aap-002'
      WHEN l_aziacti = 'N'    
         LET g_errno = '9028'
      WHEN SQLCA.SQLCODE != 0
         LET g_errno = SQLCA.SQLCODE USING '-----'
   END CASE
 
   CALL s_curr3(g_oof[l_ac1].oof07,g_oof[l_ac1].oof06,g_apz.apz33) RETURNING g_oof[l_ac1].oof08  
 
 
   IF g_oof[l_ac1].oof07 =g_aza.aza17 THEN
      LET g_oof[l_ac1].oof08=1
   END IF

   IF g_oof[l_ac1].oof08 <> g_oof_t.oof08 THEN 
      LET g_oof[l_ac1].oof09 = g_oof[l_ac1].oof09f * g_oof[l_ac1].oof08
   END IF
END FUNCTION

FUNCTION t400_oof09()
   DEFINE l_sum,l_sumf LIKE  oof_file.oof09
   DEFINE l_n          LIKE  type_file.num5
   DEFINE l_ooa31d     LIKE  ooa_file.ooa31d
   DEFINE l_ooa32d     LIKE  ooa_file.ooa32d
   DEFINE l_ooa31c     LIKE  ooa_file.ooa31c
   DEFINE l_ooa32c     LIKE  ooa_file.ooa32c

   LET g_errno = ''
   LET l_sum = 0
   LET l_sumf= 0   
   FOR l_n = 1 TO  g_oof.getlength()
      LET l_sum =l_sum + g_oof[l_n].oof09
      LET l_sumf=l_sumf+ g_oof[l_n].oof09f
   END FOR 
   SELECT SUM(oob09),SUM(oob10) INTO l_ooa31d,l_ooa32d
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
   SELECT SUM(oob09),SUM(oob10) INTO l_ooa31c,l_ooa32c
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
   IF cl_null(l_ooa31d) THEN LET l_ooa31d=0 END IF
   IF cl_null(l_ooa32d) THEN LET l_ooa32d=0 END IF
   IF cl_null(l_ooa31c) THEN LET l_ooa31c=0 END IF
   IF cl_null(l_ooa32c) THEN LET l_ooa32c=0 END IF 
   
   IF l_ooa32c - l_ooa32d -l_sum < 0 THEN 
      LET g_errno = 'aap-828'
      RETURN 
   END IF 
END FUNCTION

FUNCTION t400_oof09f()
   DEFINE l_sum,l_sumf LIKE  oof_file.oof09
   DEFINE l_n          LIKE  type_file.num5
   DEFINE l_ooa31d     LIKE  ooa_file.ooa31d
   DEFINE l_ooa32d     LIKE  ooa_file.ooa32d
   DEFINE l_ooa31c     LIKE  ooa_file.ooa31c
   DEFINE l_ooa32c     LIKE  ooa_file.ooa32c

  { LET g_errno = ''
   LET l_sum = 0
   LET l_sumf= 0   
   FOR l_n = 1 TO  g_oof.getlength()
      LET l_sum =l_sum + g_oof[l_n].oof09
      LET l_sumf=l_sumf+ g_oof[l_n].oof09f
   END FOR 
   
   SELECT SUM(oob09),SUM(oob10) INTO l_ooa31d,l_ooa32d
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='1'
   SELECT SUM(oob09),SUM(oob10) INTO l_ooa31c,l_ooa32c
          FROM oob_file WHERE oob01=g_ooa.ooa01 AND oob03='2'
   IF cl_null(l_ooa31d) THEN LET l_ooa31d=0 END IF
   IF cl_null(l_ooa32d) THEN LET l_ooa32d=0 END IF
   IF cl_null(l_ooa31c) THEN LET l_ooa31c=0 END IF
   IF cl_null(l_ooa32c) THEN LET l_ooa32c=0 END IF   
   
   IF l_ooa31c - l_ooa31d -l_sumf < 0 THEN 
      LET g_errno = 'aap-828'
      RETURN 
   END IF
  }
      
   LET g_oof[l_ac1].oof09 = g_oof[l_ac1].oof09f * g_oof[l_ac1].oof08
END FUNCTION

FUNCTION t400_ins_oma()
DEFINE  i     LIKE  type_file.num5
DEFINE  l_oma RECORD LIKE oma_file.*
DEFINE  l_occ RECORD LIKE occ_file.*
DEFINE  l_oof RECORD LIKE oof_file.*
DEFINE  li_result    LIKE type_file.num5

   IF g_success ='N' THEN RETURN END IF  
   DECLARE t400_sel_oof CURSOR  FOR 
      SELECT * FROM oof_file WHERE oof01 = g_ooa.ooa01
   
   
   FOREACH t400_sel_oof INTO l_oof.*
      IF STATUS THEN 
        #CALL cl_err('sel oof',STATUS,1)   #No.FUN-D40089   Mark
        #No.FUN-D40089 ---add--- str
         IF g_bgerr THEN
            CALL s_errmsg('ooa',g_ooa.ooa01,"",STATUS,1)
         ELSE
            CALL cl_err('sel oof',STATUS,1)
         END IF
        #No.FUN-D40089 ---add--- end
         EXIT FOREACH 
      END IF   
         LET l_oma.oma00  = '14'
         CALL s_auto_assign_no("axr",l_oof.oof05,l_oof.oof06,"14","oma_file","oma01","","","")
              RETURNING li_result,l_oof.oof05
         IF  li_result THEN
             LET l_oma.oma01  = l_oof.oof05 
             UPDATE oof_file SET oof05 = l_oof.oof05
              WHERE oof01 = g_ooa.ooa01
                AND oof02 = l_oof.oof02
         ELSE
            #CALL s_errmsg('','',l_oma.oma01,'mfg-059',1)     #MOD-BC0248 add   #No.FUN-D40089   Mark
             CALL s_errmsg('ooa',g_ooa.ooa01,l_oma.oma01,'mfg-059',1)           #No.FUN-D40089   Add 
             LET g_success = 'N'
             RETURN 
         END IF
          
         LET l_oma.oma02   = l_oof.oof06
         LET l_oma.oma03   = l_oof.oof03
         LET l_oma.oma032  = l_oof.oof032
         LET l_oma.oma68   = l_oof.oof04
         LET l_oma.oma69   = l_oof.oof042
         LET l_oma.oma18   = l_oof.oof10
         LET l_oma.oma181  = l_oof.oof101
         
         SELECT * INTO l_occ.*
           FROM occ_file
          WHERE occ01 = l_oof.oof03
                  
         LET l_oma.oma05   = l_occ.occ08
         LET l_oma.oma14   = g_ooa.ooa14
         LET l_oma.oma15   = g_ooa.ooa15
         LET l_oma.oma930  = s_costcenter(g_ooa.ooa15)
         LET l_oma.oma21   = l_occ.occ41
         LET l_oma.oma23   = l_oof.oof07
         LET l_oma.oma24   = l_oof.oof08
         LET l_oma.oma25   = l_occ.occ43
         LET l_oma.oma32   = l_occ.occ45
         LET l_oma.oma042  = l_occ.occ11
         LET l_oma.oma043  = l_occ.occ18
         LET l_oma.oma044  = l_occ.occ231
         LET l_oma.oma09   = l_oma.oma02
         
         CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,l_oma.oma02,g_plant)
              RETURNING l_oma.oma11,l_oma.oma12
              
         SELECT gec04,gec05,gec07
           INTO l_oma.oma211,l_oma.oma212,l_oma.oma213
           FROM gec_file 
          WHERE gec01=l_oma.oma21
            AND gec011='2'
            
         SELECT occ67 INTO l_oma.oma13 FROM occ_file
          WHERE occ01 = l_oof.oof03
         IF cl_null(l_oma.oma13) THEN
            LET l_oma.oma13 = g_ooz.ooz08
         END IF
         
         LET l_oma.oma66  = g_plant
         LET l_oma.omalegal = g_legal
         LET l_oma.omaconf = 'Y'
         LET l_oma.omavoid = 'N'
         LET l_oma.omaprsw = 0
         LET l_oma.omauser = g_user
         LET l_oma.omagrup = g_grup
         LET l_oma.omadate = g_today
         LET l_oma.omamksg = 'N'
         LET l_oma.oma64 = '0'
         LET l_oma.oma70 = '1'
         LET l_oma.oma65 = '1'
         LET l_oma.oma54t = l_oof.oof09f
         LET l_oma.oma56t = l_oof.oof09

         IF cl_null(l_oma.oma50) THEN
            LET l_oma.oma50 = 0
         END IF   
         IF cl_null(l_oma.oma50t) THEN
            LET l_oma.oma50t = 0
         END IF
         IF cl_null(l_oma.oma51) THEN
            LET l_oma.oma51 = 0
         END IF
         IF cl_null(l_oma.oma51f) THEN
            LET l_oma.oma51f = 0
         END IF                  
         IF cl_null(l_oma.oma52) THEN
            LET l_oma.oma52 = 0
         END IF         
         IF cl_null(l_oma.oma53) THEN
            LET l_oma.oma53 = 0
         END IF
         IF cl_null(l_oma.oma54) THEN
            LET l_oma.oma54 = 0
         END IF
         IF cl_null(l_oma.oma54x) THEN
            LET l_oma.oma54x = 0
         END IF
         IF cl_null(l_oma.oma54t) THEN
            LET l_oma.oma54t = 0
         END IF
         IF cl_null(l_oma.oma55) THEN
            LET l_oma.oma55 = 0
         END IF
         IF cl_null(l_oma.oma56) THEN
            LET l_oma.oma56 = 0
         END IF
         IF cl_null(l_oma.oma56x) THEN
            LET l_oma.oma56x = 0
         END IF
         IF cl_null(l_oma.oma56t) THEN
            LET l_oma.oma56t = 0
         END IF
         IF cl_null(l_oma.oma57) THEN
            LET l_oma.oma57 = 0
         END IF
            
#No.FUN-AB0034 --begin
    IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
    IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
    IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
#No.FUN-AB0034 --end
         INSERT INTO oma_file VALUES(l_oma.*)  
         IF SQLCA.sqlcode THEN                    
           #CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1) 
           #No.FUN-D40089 ---start--- Add
            IF g_bgerr THEN
               CALL s_errmsg('ooa01',g_ooa.ooa01,'',SQLCA.sqlcode,1)
            ELSE
               CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1)
            END IF
           #No.FUN-D40089 ---end  --- Add
            LET g_success = 'N'
            EXIT FOREACH 
         ELSE
            LET g_success ='Y'
         END IF
   END FOREACH 
END FUNCTION

FUNCTION t400_del_oma()
DEFINE  l_oof RECORD LIKE oof_file.*

   IF g_success ='N' THEN RETURN END IF 
   DECLARE t400_sel_oma1 CURSOR FOR 
      SELECT * FROM oof_file WHERE oof01 = g_ooa.ooa01
   
   FOREACH t400_sel_oma1 INTO l_oof.*
      IF STATUS THEN CALL cl_err('sel oma',STATUS,1) EXIT FOREACH END IF   
      DELETE FROM oma_file WHERE oma01 = l_oof.oof05
      IF SQLCA.sqlcode THEN                    
         CALL cl_err3("del","oma_file",l_oof.oof05,"",SQLCA.sqlcode,"","",1) 
         LET g_success = 'N'
         EXIT FOREACH 
      ELSE
         LET g_success ='Y'
      END IF
   END FOREACH 
END FUNCTION

#No.FUN-A40076 --end 
       
#FUN-A90003--Add--Begin--#
FUNCTION t400_b_move_to_2()
   LET g_oob_d[l_ac2].oob02_1 = b_oob.oob02
   LET g_oob_d[l_ac2].oob03_d = b_oob.oob03
   LET g_oob_d[l_ac2].oob04_1 = b_oob.oob04
   CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
                RETURNING g_oob_d[l_ac2].oob04_1_d
   LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
   LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
   LET g_oob_d[l_ac2].oob07_1 = b_oob.oob07
   LET g_oob_d[l_ac2].oob08_1 = b_oob.oob08
   LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
   LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
   LET g_oob_d[l_ac2].oob11_1 = b_oob.oob11
   IF g_aza.aza63='Y' THEN                  
      LET g_oob_d[l_ac2].oob111_1 = b_oob.oob111 
   END IF                                   
   LET g_oob_d[l_ac2].oob12_1 = b_oob.oob12
   LET g_oob_d[l_ac2].oob13_1 = b_oob.oob13
   LET g_oob_d[l_ac2].oob14_1 = b_oob.oob14
   LET g_oob_d[l_ac2].oobud01_1 = b_oob.oobud01
   LET g_oob_d[l_ac2].oobud02_1 = b_oob.oobud02
   LET g_oob_d[l_ac2].oobud03_1 = b_oob.oobud03
   LET g_oob_d[l_ac2].oobud04_1 = b_oob.oobud04
   LET g_oob_d[l_ac2].oobud05_1 = b_oob.oobud05
   LET g_oob_d[l_ac2].oobud06_1 = b_oob.oobud06
   LET g_oob_d[l_ac2].oobud07_1 = b_oob.oobud07
   LET g_oob_d[l_ac2].oobud08_1 = b_oob.oobud08
   LET g_oob_d[l_ac2].oobud09_1 = b_oob.oobud09
   LET g_oob_d[l_ac2].oobud10_1 = b_oob.oobud10
   LET g_oob_d[l_ac2].oobud11_1 = b_oob.oobud11
   LET g_oob_d[l_ac2].oobud12_1 = b_oob.oobud12
   LET g_oob_d[l_ac2].oobud13_1 = b_oob.oobud13
   LET g_oob_d[l_ac2].oobud14_1 = b_oob.oobud14
   LET g_oob_d[l_ac2].oobud15_1 = b_oob.oobud15
#No.FUN-AA0088 --begin
   LET g_oob_d[l_ac2].oob24_1 = b_oob.oob24
   LET g_oob_d[l_ac2].oob25_1 = b_oob.oob25
   LET g_oob_d[l_ac2].oob26_1 = b_oob.oob26
   LET g_oob_d[l_ac2].oob27_1 = b_oob.oob27
#No.FUN-AA0088 --end
END FUNCTION

FUNCTION t400_b_move_back_2()
   LET b_oob.oob02 = g_oob_d[l_ac2].oob02_1
   LET b_oob.oob03 = g_oob_d[l_ac2].oob03_d
   LET b_oob.oob04 = g_oob_d[l_ac2].oob04_1
   LET b_oob.oob06 = g_oob_d[l_ac2].oob06_1
   LET b_oob.oob15 = g_oob_d[l_ac2].oob15_1
   LET b_oob.oob07 = g_oob_d[l_ac2].oob07_1
   LET b_oob.oob08 = g_oob_d[l_ac2].oob08_1
   LET b_oob.oob09 = g_oob_d[l_ac2].oob09_1
   LET b_oob.oob10 = g_oob_d[l_ac2].oob10_1
   LET b_oob.oob11 = g_oob_d[l_ac2].oob11_1
   IF g_aza.aza63='Y' THEN                   
      LET b_oob.oob111 =  g_oob_d[l_ac2].oob111_1 
   END IF                                    
   LET b_oob.oob12 = g_oob_d[l_ac2].oob12_1
   LET b_oob.oob13 = g_oob_d[l_ac2].oob13_1
   LET b_oob.oob14 = g_oob_d[l_ac2].oob14_1
   LET b_oob.oob19 = g_oob_d[l_ac2].oob19_1      
   LET b_oob.oobud01 = g_oob_d[l_ac2].oobud01_1
   LET b_oob.oobud02 = g_oob_d[l_ac2].oobud02_1
   LET b_oob.oobud03 = g_oob_d[l_ac2].oobud03_1
   LET b_oob.oobud04 = g_oob_d[l_ac2].oobud04_1
   LET b_oob.oobud05 = g_oob_d[l_ac2].oobud05_1
   LET b_oob.oobud06 = g_oob_d[l_ac2].oobud06_1
   LET b_oob.oobud07 = g_oob_d[l_ac2].oobud07_1
   LET b_oob.oobud08 = g_oob_d[l_ac2].oobud08_1
   LET b_oob.oobud09 = g_oob_d[l_ac2].oobud09_1
   LET b_oob.oobud10 = g_oob_d[l_ac2].oobud10_1
   LET b_oob.oobud11 = g_oob_d[l_ac2].oobud11_1
   LET b_oob.oobud12 = g_oob_d[l_ac2].oobud12_1
   LET b_oob.oobud13 = g_oob_d[l_ac2].oobud13_1
   LET b_oob.oobud14 = g_oob_d[l_ac2].oobud14_1
   LET b_oob.oobud15 = g_oob_d[l_ac2].oobud15_1
   LET b_oob.ooblegal = g_legal 
#No.FUN-AA0088 --begin
   LET b_oob.oob24 = g_oob_d[l_ac2].oob24_1
   LET b_oob.oob25 = g_oob_d[l_ac2].oob25_1
   LET b_oob.oob26 = g_oob_d[l_ac2].oob26_1
   LET b_oob.oob27 = g_oob_d[l_ac2].oob27_1
#No.FUN-AA0088 --end
END FUNCTION

FUNCTION t400_set_entry_b_2()
 
    MESSAGE ''
 
    CALL cl_set_comp_entry("oob07_1,oob08_1",TRUE)
    CALL cl_set_comp_entry("oob15_1",TRUE)
 
END FUNCTION
 
FUNCTION t400_set_no_entry_b_2()
 
    MESSAGE ''
    IF NOT cl_null(g_ooa.ooa23) THEN
       CALL cl_set_comp_entry("oob07_1",FALSE)
    END IF
    IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
       (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
       CALL cl_set_comp_entry("oob07_1,oob08_1",FALSE)
    END IF
    IF INFIELD(oob04_1) THEN
       IF NOT (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2') THEN   
          IF g_ooz.ooz62 <> 'Y' OR g_oob_d[l_ac2].oob03_d<>'2' OR
             g_oob_d[l_ac2].oob04_1<>'1' THEN
             CALL cl_set_comp_entry("oob15_1",FALSE)
          END IF
       END IF   
      #若oob04_1='9'時,oob15_1預設值為0,無須維護
       IF g_oob_d[l_ac2].oob04_1 = '9' THEN
          CALL cl_set_comp_entry("oob15_1",FALSE)
          CALL cl_set_comp_entry("oob08_1",FALSE)     #MOD-C30853 add
       END IF
    END IF
    IF g_oob_d[l_ac2].oob07_1=g_aza.aza17 THEN
       CALL cl_set_comp_entry("oob08_1",FALSE)
       LET g_oob_d[l_ac2].oob08_1=1.0
       DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
    END IF
END FUNCTION
 
FUNCTION t400_set_entry_b_1_2()
   CALL cl_set_comp_entry("oob02_1,oob03_d,oob06_1,oob19_1,oob15_1,oob14_1,oob07_1,
                           oob08_1,oob09_1,oob10_1,oob12_1",TRUE)
END FUNCTION
 
FUNCTION t400_set_no_entry_b_1_2()
 IF g_ooa.ooa34 matches '[Ss]' THEN
   CALL cl_set_comp_entry("oob02_1,oob03_d,oob06_1,oob19_1,oob15_1,oob14_1,oob07_1, 
                           oob08_1,oob09_1,oob10_1,oob12_1",FALSE)
 END IF
END FUNCTION
 
FUNCTION t400_set_entry_b1_2()
    DEFINE l_aag05  LIKE aag_file.aag05  
    DEFINE l_cnt    LIKE type_file.num5   #MOD-CC0090 add
 
    IF g_oob_d[l_ac2].oob03_d='1' THEN
       IF g_oob_d[l_ac2].oob04_1='3' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1='4' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62='Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[349]' AND   
          NOT(g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN  
          CALL cl_set_comp_entry("oob15_1",TRUE)
       END IF
    END IF
    IF g_oob_d[l_ac2].oob03_d='2' THEN
       IF g_oob_d[l_ac2].oob04_1='1' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1='9' THEN
          CALL cl_set_comp_entry("oob19_1",TRUE)
          IF g_ooz.ooz62 = 'Y' THEN
             CALL cl_set_comp_entry("oob15_1",TRUE)
          END IF
       END IF
       IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[19]' THEN
          CALL cl_set_comp_entry("oob15_1",TRUE)
       END IF
    END IF
 
    LET l_aag05=''
    SELECT aag05 INTO l_aag05 FROM aag_file
     WHERE aag01=g_oob_d[l_ac2].oob11_1  
       AND aag00=g_bookno1       
    IF l_aag05='Y' THEN
       CALL cl_set_comp_entry("oob13_1",TRUE)
    END IF
   #------------------MOD-CC0090-------------------(S)
    SELECT COUNT(*) INTO l_cnt FROM ooc_file
     WHERE ooc01 = g_oob_d[l_ac2].oob04_1
    IF l_cnt = 0 THEN
       CALL cl_set_comp_entry("oob06_1",TRUE)
    END IF
   #------------------MOD-CC0090-------------------(E)

 
END FUNCTION
 
FUNCTION t400_set_no_entry_b1_2()
    DEFINE l_cnt    LIKE type_file.num5   #MOD-CC0090 add

    CALL cl_set_comp_entry("oob15_1,oob19_1",FALSE)
    CALL cl_set_comp_entry("oob13_1",FALSE)   

   #------------------MOD-CC0090-------------------(S)
    SELECT COUNT(*) INTO l_cnt FROM ooc_file
     WHERE ooc01 = g_oob_d[l_ac2].oob04_1
    IF l_cnt > 0 THEN
       CALL cl_set_comp_entry("oob06_1",FALSE)
    END IF
   #------------------MOD-CC0090-------------------(E)

END FUNCTION
 
FUNCTION t400_set_required_b_2()
  #IF g_ooz.ooz62='Y' OR                                                                             #No.MOD-B80292 mark
   IF (g_ooz.ooz62='Y' AND g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]") OR  #No.MOD-B80292 add
     (g_ooz.ooz62='N' AND g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
      CALL cl_set_comp_required("oob15_1",TRUE)
   END IF
END FUNCTION
 
FUNCTION t400_set_no_required_b_2()
   CALL cl_set_comp_required("oob15_1",FALSE)
END FUNCTION

FUNCTION t400_acct_code_2()
   DEFINE l_ool RECORD LIKE ool_file.*
   SELECT * INTO l_ool.* FROM ool_file WHERE ool01=g_ooa.ooa13
   CASE WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '5'
             LET b_oob.oob11 = l_ool.ool54
             IF g_aza.aza63='Y' THEN              
                LET b_oob.oob111 = l_ool.ool541    
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '6'
             LET b_oob.oob11 = l_ool.ool51
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool511     
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '7' 
             LET b_oob.oob11 = l_ool.ool52
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool521    
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '7'
             LET b_oob.oob11 = l_ool.ool53
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool531    
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '8'
             LET b_oob.oob11 = l_ool.ool23
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool231     
             END IF                                
        WHEN g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '2'
             LET b_oob.oob11 = l_ool.ool25
             IF g_aza.aza63='Y' THEN               
                LET b_oob.oob111 = l_ool.ool251    
             END IF                                
        OTHERWISE
           IF b_oob.oob04 != g_oob_d[l_ac2].oob04_1 THEN
              LET b_oob.oob11 = null
              LET b_oob.oob111= null     
           END IF
           LET g_oob_d[l_ac2].oob11_1 = null
           LET g_oob_d[l_ac2].oob111_1= null  
          
   END CASE
   IF cl_null(g_oob_d[l_ac2].oob11_1) THEN
      LET g_oob_d[l_ac2].oob11_1 = b_oob.oob11
      LET g_oob_d[l_ac2].oob111_1= b_oob.oob111  
      DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
      DISPLAY BY NAME g_oob_d[l_ac2].oob111_1    
   ELSE
      LET b_oob.oob11 =g_oob_d[l_ac2].oob11_1
      LET b_oob.oob111=g_oob_d[l_ac2].oob111_1   
   END IF
END FUNCTION

FUNCTION t400_oob06_1_2()
DEFINE l_nmg  RECORD LIKE nmg_file.*  
  LET g_errno=' '
  IF g_oob_d[l_ac2].oob03_d='1' THEN
     IF g_oob_d[l_ac2].oob04_1='1' THEN CALL t400_oob06_1_11_2() END IF
     IF g_oob_d[l_ac2].oob04_1='3' THEN CALL t400_oob06_1_13_2('2') END IF
     IF g_oob_d[l_ac2].oob04_1='9' THEN CALL t400_oob06_1_19_2('1') END IF  
  END IF
  IF g_oob_d[l_ac2].oob03_d='2' THEN
     IF g_oob_d[l_ac2].oob04_1='1' THEN CALL t400_oob06_1_13_2('1') END IF
     IF g_oob_d[l_ac2].oob04_1='9' THEN CALL t400_oob06_1_19_2('2') END IF   
  END IF
  
  DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                  g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                  g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                  g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
 
END FUNCTION
 
 
FUNCTION t400_oob09_1_11_2(l_sw,l_cmd)                # 借方檢查 : 支票
   DEFINE l_sw      LIKE type_file.chr1       
   DEFINE l_cmd     LIKE type_file.chr1        
   DEFINE l_nmh02   LIKE nmh_file.nmh02
   DEFINE l_nmh32   LIKE nmh_file.nmh32
   DEFINE l_nmydmy3 LIKE nmy_file.nmydmy3
   DEFINE l_oob09_1,l_oob10_1 LIKE oob_file.oob09     
   DEFINE tot1,tot2,tot3  LIKE oob_file.oob09
   DEFINE l_nmz59         LIKE nmz_file.nmz59
   DEFINE l_sql           LIKE type_file.chr1000     
 
   IF g_ooz.ooz04='N' THEN RETURN TRUE END IF
 
   LET l_sql=
   " SELECT nmh02,nmh32,nmydmy3 ",
   "  FROM nmh_file,nmy_file ",
   " WHERE nmh01= '",g_oob_d[l_ac2].oob06_1,"' AND nmh01[1,",g_doc_len,"]=nmyslip ",
   "   AND nmh38 <> 'X' ",
   "   AND nmh24 != '6' AND nmh24 != '7'"         
   PREPARE nmh_p11 FROM l_sql
   DECLARE nmh_c11 CURSOR FOR nmh_p11
   OPEN nmh_c11
   FETCH nmh_c11 INTO l_nmh02,l_nmh32,l_nmydmy3
   IF STATUS THEN
      LET l_nmh02 = 0
   END IF

   #TQC-C70059--mark--str-- 
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file     
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND oob03_d = '1' AND oob04_1 = '1'          
   #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)                        
   #   AND oob01 = ooa01 AND ooaconf <> 'X'  
   #   AND ooa34 <> '9'   
   #TQC-C70059--mark--end--
   
   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = g_oob_d[l_ac2].oob03_d AND oob04 = g_oob_d[l_ac2].oob04_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      AND oob01 = ooa01 AND ooaconf <> 'X'
      AND ooa34 <> '9'
   #TQC-C70059--add--end--

   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0      
      LET l_oob10_1 = 0      
   END IF
 
   #須考慮未確認沖帳資料
   #TQC-C70059--mark--str--
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file               
    #WHERE oob06_1 = g_oob_d[l_ac2].oob06_1                                              
    #  AND oob01 = ooa01 AND ooaconf = 'N'
    #  AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)      
    #  AND oob03_d = g_oob_d[l_ac2].oob03_d
    #  AND oob04_1 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--mark--end--  

   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--add--end-- 

   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
   IF l_sw = '1' THEN
         IF (l_oob09_1+g_oob_d[l_ac2].oob09_1) > l_nmh02 THEN         
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
   ELSE
      SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz59 = 'N' THEN    #不做月底重評時, 依原判斷
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > l_nmh32 THEN         
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('4','1',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
         IF (tot2+g_oob_d[l_ac2].oob10_1) > tot3 THEN
            CALL cl_err('','axr-185',1)
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob09_1_12_2(l_sw,l_cmd)                # 借方檢查 : TT
   DEFINE l_sw    LIKE type_file.chr1        
   DEFINE l_cmd   LIKE type_file.chr1        
   DEFINE l_nmh02,l_nmh32 LIKE nmh_file.nmh02
   DEFINE l_oob09_1,l_oob10_1 LIKE oob_file.oob09      
   DEFINE l_nmz20         LIKE nmz_file.nmz20
 
   SELECT SUM(npk08),SUM(npk09) INTO l_nmh02,l_nmh32 FROM nmg_file,npk_file
    WHERE nmg00=npk00 AND nmg00= g_oob_d[l_ac2].oob06_1
      AND npk01=g_oob_d[l_ac2].oob15_1   #MOD-630069
      AND (nmg20='21' OR nmg20='22') AND npk04 IS NOT NULL
      AND nmgconf <> 'X'
 
   IF cl_null(l_nmh02) THEN LET l_nmh02 = 0 LET l_nmh32 = 0 END IF

   #TQC-C70059--mark--str-- 
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file     
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND oob03_d = '1' AND oob04_1 = '2'          
   #   AND oob01 = ooa01 AND ooaconf <> 'X' 
   #   AND oob01 <> g_ooa.ooa01   
   #   AND oob15_1 = g_oob_d[l_ac2].oob15_1                                              
   #TQC-C70059--mark--end--

   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file 
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = g_oob_d[l_ac2].oob03_d AND oob04 = g_oob_d[l_ac2].oob04_1
      AND oob01 = ooa01 AND ooaconf <> 'X'
      AND oob01 <> g_ooa.ooa01
      AND oob15 = g_oob_d[l_ac2].oob15_1 
   #TQC-C70059--add--end--

   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0   
      LET l_oob10_1 = 0   
   END IF
 
   IF l_sw = '1' THEN
      IF (l_oob09_1+g_oob_d[l_ac2].oob09_1) > l_nmh02 THEN     
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
      #判斷本幣金額是否超過
      IF l_nmz20 = 'N' THEN      #不做月底重評時, 依原判斷
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > l_nmh32 THEN   #TQC-C70059  mark 
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         CALL s_g_np('3','2',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
          IF g_oob_d[l_ac2].oob10_1 > tot3 THEN               
            CALL cl_err('','axr-185',1)
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2        
            LET g_oob_d[l_ac2].oob10_1 = tot3 - l_oob10_1      
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob09_1_13_2(l_sw,l_cmd)  # 檢查 :3:取待抵 1:取應收
   DEFINE l_sw           LIKE type_file.chr1        
   DEFINE l_cmd          LIKE type_file.chr1        
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omc          RECORD LIKE omc_file.*
   DEFINE l_message      LIKE type_file.chr1000     
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE tot5,tot6      LIKE oob_file.oob09    
   DEFINE tot7,tot8      LIKE oob_file.oob09    
   DEFINE l_oob09_1        LIKE oob_file.oob09
   DEFINE l_diff         LIKE oob_file.oob10
   DEFINE l_msg1,l_msg2  LIKE type_file.chr1000   
   DEFINE l_omb          RECORD LIKE omb_file.*     #No.MOD-B60058  
   DEFINE l_net          LIKE oox_file.oox10        #No.MOD-C30058
 
   LET tot1 = 0
   LET tot2 = 0
 
   SELECT * INTO l_oma.* FROM oma_file
    WHERE oma01=g_oob_d[l_ac2].oob06_1 AND omavoid='N'
   IF STATUS THEN
      LET l_oma.oma54t = 0
      LET l_oma.oma56t = 0
      LET l_oma.oma55  = 0
      LET l_oma.oma57  = 0
      LET l_oma.oma61  = 0   
   END IF
 
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file   #No.MOD-B60058
    WHERE oob06 = g_oob_d[l_ac2].oob06_1                            #No.MOD-B60058
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)      #No.MOD-B60058 
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d                            #No.MOD-B60058 
      AND oob04 = g_oob_d[l_ac2].oob04_1                            #No.MOD-B60058 
   IF tot1 IS NULL THEN LET tot1=0 END IF   
   IF tot2 IS NULL THEN LET tot2=0 END IF   
 
   SELECT SUM(oob09),SUM(oob10) INTO tot5,tot6 FROM oob_file,ooa_file   #No.MOD-B60058
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob15 = g_oob_d[l_ac2].oob15_1  #No.MOD-B60058
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)      #No.MOD-B60058 
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d                            #No.MOD-B60058 
      AND oob04 = g_oob_d[l_ac2].oob04_1                            #No.MOD-B60058 
   IF tot5 IS NULL THEN LET tot5=0 END IF
   IF tot6 IS NULL THEN LET tot6=0 END IF
 
   #待扺或貸方
   SELECT SUM(oob09),SUM(oob10) INTO tot7,tot8 FROM oob_file,ooa_file   #No.MOD-B60058
    WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob19 = g_oob_d[l_ac2].oob19_1   #No.MOD-B60058
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)       #No.MOD-B60058 
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob03 = g_oob_d[l_ac2].oob03_d                            #No.MOD-B60058 
      AND oob04 = g_oob_d[l_ac2].oob04_1                            #No.MOD-B60058 
   IF tot7 IS NULL THEN LET tot7=0 END IF
   IF tot8 IS NULL THEN LET tot8=0 END IF
 
   SELECT * INTO l_omc.* FROM omc_file
    WHERE omc01=g_oob_d[l_ac2].oob06_1 AND omc02=g_oob_d[l_ac2].oob19_1
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","omc_file",g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob19_1,SQLCA.sqlcode,"","select omc_file",1)
   END IF
 
   IF tot1 IS NULL THEN LET tot1 = 0 END IF
   IF tot2 IS NULL THEN LET tot2 = 0 END IF
 
   IF l_sw = '1' THEN
      IF g_ooz.ooz62 = 'Y' THEN #衝帳至項次   
#No.MOD-B60058 --begin 
         SELECT * INTO l_omb.* FROM omb_file WHERE omb01 = l_oma.oma01 AND omb03 = g_oob_d[l_ac2].oob15_1
#        IF (tot1+g_oob[l_ac].oob09) > (l_oma.oma54t - l_oma.oma55) THEN
         IF (tot5+g_oob_d[l_ac2].oob09_1) > (l_omb.omb14t - l_omb.omb34) THEN
#No.MOD-B60058 --end
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
         IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
#No.MOD-B60058 --begin 
#           IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55) THEN
            IF (tot5+g_oob_d[l_ac2].oob09_1) = (l_omb.omb14t - l_omb.omb34) THEN
#No.MOD-B60058 --end
              IF g_ooz.ooz62 = 'Y' THEN
                 CALL s_g_np('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                      RETURNING tot3                 
                 #判斷本幣金額是否超過
                 IF (tot5+g_oob_d[l_ac2].oob09_1) > tot3 THEN
                    CALL cl_err('','axr-189',1)   
                    LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
                 END IF
              END IF
            END IF
         END IF
      ELSE    #不衝賬至項次
         IF (tot7+g_oob_d[l_ac2].oob09_1) > (l_omc.omc08 - l_omc.omc10) THEN
            CALL cl_err('','axr-185',1) 
            LET g_oob_d[l_ac2].oob09_1=g_oob_d_t.oob09_1
            DISPLAY g_oob_d[l_ac2].oob09_1 TO oob09_1
            RETURN FALSE
         END IF
      END IF
   ELSE
      IF g_ooz.ooz07 = 'N' OR g_oob_d[l_ac2].oob07_1 = g_aza.aza17 THEN
            IF (tot8+g_oob_d[l_ac2].oob10_1) > (l_omc.omc09  - l_omc.omc11) THEN  
               CALL cl_err('','axr-185',1) 
               LET g_oob_d[l_ac2].oob10_1=g_oob_d_t.oob10_1         
               DISPLAY g_oob_d[l_ac2].oob10_1 TO oob10_1      
               RETURN FALSE
            END IF
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob_d[l_ac2].oob10_1)!= (l_omc.omc09  - l_omc.omc11) THEN
               CALL cl_err('','axr-193',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
         #(怕因匯差問題)
         IF g_aza.aza17 != g_oob_d[l_ac2].oob07_1 THEN
            LET l_diff= (l_omc.omc09  - l_omc.omc11)- (tot8+g_oob_d[l_ac2].oob10_1)  
            IF l_diff <=3 AND l_diff >0 THEN
               CALL cl_getmsg('mfg-030',g_lang) RETURNING l_msg1
               CALL cl_getmsg('mfg-031',g_lang) RETURNING l_msg2
               LET g_msg=l_msg1 CLIPPED,l_omc.omc09  USING '#######&',  
                         " ",l_msg2 CLIPPED,
                        (l_omc.omc11+tot8+g_oob_d[l_ac2].oob10_1) USING '#######&' 
               CALL cl_err(g_msg,'mfg-012',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
         END IF
      END IF
      #判斷本幣金額是否超過
      IF g_ooz.ooz07 = 'Y' THEN   #有做月底重評時, 需判斷不可超過未沖金額
            IF (tot8+g_oob_d[l_ac2].oob10_1) > l_omc.omc13 THEN  
               CALL cl_err('','axr-185',1)
               LET g_oob_d[l_ac2].oob10_1 = l_omc.omc13 - tot8 
               DISPLAY g_oob_d[l_ac2].oob10_1 TO oob10_1         
               RETURN FALSE
            END IF
            #No.MOD-C30058  --Begin
            #CALL t400_comp_oox(l_omc.omc01) RETURNING g_net                                #MOD-C20199
            LET l_net = 0
            SELECT SUM(oox10) INTO l_net FROM oox_file
             WHERE oox03 = l_omc.omc01
            IF cl_null(l_net) THEN
               LET l_net = 0
            END IF
            #No.MOD-C30058  --End 
           #原幣沖完但本幣未沖完
            IF (tot1+g_oob_d[l_ac2].oob09_1) = (l_oma.oma54t-l_oma.oma55)   AND
               (tot8+g_oob_d[l_ac2].oob10_1)!= (l_omc.omc09  - l_omc.omc11 + l_net) THEN   #MOD-C20199 add g_net  #MOD-C30058
               CALL cl_err('','axr-193',1)
               RETURN FALSE                    #MOD-BB0208 add
            END IF
      END IF
   END IF
 
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob09_1_19_2(l_sw,l_cmd,l_sw2)           # 借/貸方檢查 : A/P   
   DEFINE l_sw           LIKE type_file.chr1       
   DEFINE l_cmd          LIKE type_file.chr1       
   DEFINE l_apa          RECORD LIKE apa_file.*
   DEFINE l_apc          RECORD LIKE apc_file.*   
   DEFINE p05,p05f       LIKE type_file.num20_6     
   DEFINE l_oob09_1,l_oob10_1        LIKE oob_file.oob09
   DEFINE l_apz27        LIKE apz_file.apz27
   DEFINE l_sw2          LIKE type_file.chr1  
   DEFINE l_amt16        LIKE type_file.num20_6     #No.MOD-BB0016 
 
   SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file
     WHERE apa01=g_oob_d[l_ac2].oob06_1
       AND apa01=apc01 
       AND apc02=g_oob_d[l_ac2].oob19_1  
       AND apa02 <= g_ooa.ooa02       
   IF STATUS THEN
      LET l_apc.apc10 = 0
      LET l_apc.apc11  = 0
   END IF
 
   LET p05f = 0 LET p05 = 0
 
   IF l_sw2 = '1' THEN
      SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05 FROM apg_file,apf_file
       WHERE apg04=g_oob_d[l_ac2].oob06_1              ## 尚未確認也視同已付,須扣除
         AND apg06=g_oob_d[l_ac2].oob19_1
         AND apg01=apf01 AND apf41='N' AND apg01 <> g_ooa.ooa01
   ELSE
      SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05 FROM aph_file,apf_file
       WHERE aph04=g_oob_d[l_ac2].oob06_1              ## 尚未確認也視同已付,須扣除
         AND aph17=g_oob_d[l_ac2].oob19_1
         AND aph01=apf01 AND apf41='N' AND aph01 <> g_ooa.ooa01
   END IF
 
   IF p05f IS NULL THEN LET p05f=0 END IF
   IF p05  IS NULL THEN LET p05 =0 END IF
 
   LET l_apc.apc10=l_apc.apc10+p05f
   LET l_apc.apc11=l_apc.apc11+p05
 
   IF l_sw2 = '1' THEN
      #TQC-C70059--mark---str--
      #SELECT SUM(oob09_1),SUM(oob10_1) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
      # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND oob03_d = '1' AND oob04_1 = '9'
      #   AND oob19_1 = g_oob_d[l_ac2].oob19_1
      #   AND oob01 = ooa01 AND ooaconf = 'N'    
      #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)  
      #TQC-C70059--mark---end--
      #TQC-C70059--add--str--
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
       WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03 = g_oob_d[l_ac2].oob03_d AND oob04 = g_oob_d[l_ac2].oob04_1
         AND oob19 = g_oob_d[l_ac2].oob19_1
         AND oob01 = ooa01 AND ooaconf = 'N'
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)  
      #TQC-C70059--add--end-- 
   ELSE
      #TQC-C70059--mark---str--
      #SELECT SUM(oob09_1),SUM(oob10_1) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
      # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND oob03_d = '2' AND oob04_1 = '9'
      #   AND oob19_1 = g_oob_d[l_ac2].oob19_1
      #   AND oob01 = ooa01 AND ooaconf = 'N'     
      #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)     
      #TQC-C70059--mark---end--

      #TQC-C70059--add--str--
      SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM ooa_file,oob_file
       WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob03_d = g_oob_d[l_ac2].oob03_d AND oob04 = g_oob_d[l_ac2].oob04_1
         AND oob19 = g_oob_d[l_ac2].oob19_1
         AND oob01 = ooa01 AND ooaconf = 'N'
         AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      #TQC-C70059--add--end--
   
   END IF
   IF STATUS OR l_oob09_1 IS NULL THEN
      LET l_oob09_1 = 0
      LET l_oob10_1 = 0
   END IF
   IF l_sw = '1' THEN
     #IF g_oob_d[l_ac2].oob09_1 > (l_apc.apc08-l_apc.apc10) THEN                           #MOD-BB0016 mark
      IF g_oob_d[l_ac2].oob09_1 > (l_apc.apc08-l_apc.apc10-l_apc.apc16) THEN               #MOD-BB0016 add 
         LET g_oob_d[l_ac2].oob09_1 = l_apc.apc08-l_apc.apc10-l_apc.apc16-p05f-l_oob09_1   #MOD-BB0016 add
         DISPLAY BY NAME g_oob_d[l_ac2].oob09_1                                            #MOD-BB0016 add
         CALL cl_err('','axr-185',1) RETURN FALSE
      END IF
   ELSE
      SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'  
      #判斷本幣金額是否超過
      IF l_apz27 = 'N' THEN      #不做月底重評時, 依原判斷
         LET l_amt16 = l_apc.apc16*l_apc.apc06               #MOD-BB0016 add
         CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16   #MOD-BB0016 add
        #IF g_oob_d[l_ac2].oob10_1 > (l_apc.apc09-l_apc.apc11) THEN          #MOD-BB0016 mark
         IF g_oob_d[l_ac2].oob10_1 > (l_apc.apc09-l_apc.apc11-l_amt16) THEN  #MOD-BB0016 mod 
            LET g_oob_d[l_ac2].oob10_1 = l_apc.apc09-l_apc.apc11-l_amt16-p05-l_oob10_1   #MOD-BB0016 add
            DISPLAY BY NAME g_oob_d[l_ac2].oob10_1                                       #MOD-BB0016 add
            CALL cl_err('','axr-185',1) RETURN FALSE
         END IF
      ELSE    #有做月底重評時, 需判斷不可超過未沖金額
         LET l_amt16 = l_apc.apc16*l_apc.apc07               #MOD-BB0016 add
         CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16   #MOD-BB0016 add
         CALL s_g_np('2',l_apa.apa00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
              RETURNING tot3
        #IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > tot3 - p05 THEN              #MOD-BB0016 mark
         IF (l_oob10_1+g_oob_d[l_ac2].oob10_1) > tot3 - p05 - l_amt16 THEN    #MOD-BB0016 add 
            CALL cl_err('','axr-185',1)
           #LET g_oob_d[l_ac2].oob10_1 = tot3 - p05 - l_oob10_1               #MOD-BB0016 mark
            LET g_oob_d[l_ac2].oob10_1 = tot3 - l_amt16 - p05 - l_oob10_1     #MOD-BB0016 mod
            DISPLAY BY NAME g_oob_d[l_ac2].oob10_1
            RETURN FALSE
         END IF
      END IF
   END IF
   RETURN TRUE
END FUNCTION
 
FUNCTION t400_oob06_1_11_2()            # 借方檢查 : 支票
  DEFINE l_nmh            RECORD LIKE nmh_file.*
  DEFINE l_nmydmy3             LIKE nmy_file.nmydmy3
  DEFINE l_nmz59        LIKE nmz_file.nmz59
  DEFINE tot1,tot2,tot3 LIKE type_file.num20_6    
  DEFINE l_sql          LIKE type_file.chr1000     
  DEFINE l_aag05        LIKE aag_file.aag05   
  DEFINE l_bookno       LIKE aag_file.aag00  
 
  IF g_ooz.ooz04='N' THEN RETURN END IF
  #No.+093 010427 by plum #若收票單別其拋轉傳票為Y,不可用來沖AR
  LET l_sql="SELECT nmh_file.*,nmydmy3 FROM nmh_file,nmy_file ",
            " WHERE nmh01= '",g_oob_d[l_ac2].oob06_1,"'",
            "   AND nmh01[1,",g_doc_len,"]=nmyslip"
   PREPARE nmh_p21 FROM l_sql
   DECLARE nmh_c21 CURSOR FOR nmh_p21
   OPEN nmh_c21
   FETCH nmh_c21 INTO l_nmh.*,l_nmydmy3
   IF STATUS THEN CALL cl_err('sel nmh',STATUS,1) LET g_errno='N' END IF
 
  #CALL s_get_bookno(YEAR(l_nmh.nmh04)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
   IF g_flag='1' THEN
      CALL cl_err(l_nmh.nmh04,'aoo-081',1)
   END IF
   IF l_nmh.nmh24='5' OR l_nmh.nmh24='6' OR l_nmh.nmh24='7' THEN   #TQC-C20416 add '5' 
      CALL cl_err('','axr-115',0)
      LET g_errno = 'N'
      RETURN
   END IF
 
   IF l_nmydmy3='Y' THEN
      LET g_oob_d[l_ac2].oob11_1 = l_nmh.nmh27
      DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
      LET g_oob_d[l_ac2].oob111_1= l_nmh.nmh271   
      DISPLAY BY NAME g_oob_d[l_ac2].oob111_1      
   ELSE  
      LET g_oob_d[l_ac2].oob11_1 = l_nmh.nmh26   
      DISPLAY BY NAME g_oob_d[l_ac2].oob11_1   
      LET g_oob_d[l_ac2].oob111_1 = l_nmh.nmh261   
      DISPLAY BY NAME g_oob_d[l_ac2].oob111_1   
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
           RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
   END IF
   IF YEAR(g_ooa.ooa02) <> YEAR(l_nmh.nmh04) THEN
      CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
           RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
   END IF
   IF l_nmh.nmh38 = 'N' THEN
      CALL cl_err(g_oob_d[l_ac2].oob06_1,'axr-194',0) LET g_errno='N' RETURN
   END IF
   IF l_nmh.nmh38 = 'X' THEN
      CALL cl_err(g_oob_d[l_ac2].oob06_1,'9024',0) LET g_errno = 'N' RETURN
   END IF
 
   #須考慮未確認沖帳資料
   #TQC-C70059--mark--str--
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1
   #   AND oob01 = ooa01 AND ooaconf = 'N'
   #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)      
   #   AND oob03_d = g_oob_d[l_ac2].oob03_d
   #   AND oob04_1 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--mark--end--
   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--add--end--
   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  IF l_nmh.nmh11!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh30!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當票據客戶!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_nmh.nmh03!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_nmh.nmh17>=l_nmh.nmh02 THEN
     CALL cl_err('','axr-185',1) LET g_errno='N' END IF
  # 判斷此參考單號之單據是否已確認
  IF l_nmh.nmh38 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
  LET g_oob_d[l_ac2].oob07_1=l_nmh.nmh03
  LET g_oob_d[l_ac2].oob08_1=l_nmh.nmh32/l_nmh.nmh02
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
  LET g_oob_d[l_ac2].oob09_1=l_nmh.nmh02-l_nmh.nmh17
  LET g_oob_d[l_ac2].oob09_1=l_nmh.nmh02-l_nmh.nmh17-tot1
  LET g_oob_d[l_ac2].oob10_1=g_oob_d[l_ac2].oob09_1*g_oob_d[l_ac2].oob08_1
 
  SELECT nmz59 INTO l_nmz59 FROM nmz_file WHERE nmz00 = '0'
  IF l_nmz59 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                       
        LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh39
     ELSE                                            
     	  LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh28          
     END IF                                               
     IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
        LET g_oob_d[l_ac2].oob08_1 = l_nmh.nmh28
     END IF
     CALL s_g_np('4','1',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1) RETURNING tot3
     IF (g_oob_d[l_ac2].oob09_1+tot1+l_nmh.nmh17) = l_nmh.nmh02 THEN
        LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
     END IF
  END IF
 
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1  
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1  
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1       
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_nmh.nmh15
  ELSE
     LET g_oob_d[l_ac2].oob13_1=''
  END IF
  LET g_oob_d[l_ac2].oob14_1=l_nmh.nmh31
  LET g_oob_d[l_ac2].oob12_1=l_nmh.nmh18  
END FUNCTION
 
FUNCTION t400_oob06_1_12_2()            # 借方檢查 : TT
  DEFINE l_nmg           RECORD LIKE nmg_file.*
  DEFINE l_npk           RECORD LIKE npk_file.*
  DEFINE l_cnt           LIKE type_file.num5        
  DEFINE l_sql           LIKE type_file.chr1000     
  DEFINE l_nmz20         LIKE nmz_file.nmz20
  DEFINE tot1,tot2,tot3  LIKE type_file.num20_6     
  DEFINE l_aag05         LIKE aag_file.aag05        
  DEFINE l_bookno        LIKE aag_file.aag00       
  DEFINE l_gem10         LIKE gem_file.gem10       
 
   IF g_ooz.ooz04='N' THEN RETURN END IF
 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob_d[l_ac2].oob06_1
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 ='Y')    #NO:4181
  IF NOT STATUS AND g_oob_d[l_ac2].oob04_1<>'3' THEN  
     CALL cl_err('','axr-202',0)  #MOD-740395
     LET g_errno='N' 
     RETURN  #MOD-740395
  END IF 
  SELECT nmg_file.* INTO l_nmg.*  FROM nmg_file
         WHERE nmg00= g_oob_d[l_ac2].oob06_1
           AND (nmg20='21' OR nmg20='22')
           AND (nmg29 !='Y')    #NO:4181
  IF STATUS  THEN                                 
     CALL cl_err('sel nmg',STATUS,0)  
     LET g_errno='N' 
     RETURN  
  END IF 
 
  #CALL s_get_bookno(YEAR(l_nmg.nmg01)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 mark
   CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag, g_bookno1,g_bookno2     #MOD-CB0277 add
   IF g_flag='1' THEN
      CALL cl_err(l_nmg.nmg01,'aoo-081',1)
   END IF
   IF l_nmg.nmgconf='N' THEN 
      CALL cl_err('','axr-194',0) 
      LET g_errno='N' 
      RETURN 
   END IF
   IF l_nmg.nmgconf='X' THEN 
      CALL cl_err('','9024',0) 
      LET g_errno='N' 
      RETURN  
   END IF
   IF l_nmg.nmg18 !=g_ooa.ooa03 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF          
   IF l_nmg.nmg19 !=g_ooa.ooa032 THEN
       CALL cl_err('','axr-138',1) {LET g_errno='N' RETURN} END IF        
   IF l_nmg.nmg23-l_nmg.nmg24 = 0 THEN
      CALL cl_err('','axr-184',1) 
      LET g_errno='N' 
      RETURN 
   END IF
   #TQC-C70059--mark--str--
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1
   #   AND oob01 = ooa01 AND ooaconf != 'X'   
   #   AND oob01 <> g_ooa.ooa01    
   #   AND oob15_1 = g_oob_d[l_ac2].oob15_1   
   #   AND oob03_d = g_oob_d[l_ac2].oob03_d
   #   AND oob04_1 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--mark--end--
   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf != 'X'
      AND oob01 <> g_ooa.ooa01
      AND oob15 = g_oob_d[l_ac2].oob15_1
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--add--end--

   IF cl_null(tot1) THEN LET tot1 = 0 END IF
   IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
   LET l_aag05 = ''
   SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                             AND aag00=g_bookno1              
   IF l_aag05 = 'Y' THEN
      LET l_gem10=s_costcenter(l_nmg.nmg11)
      IF NOT cl_null(l_gem10) THEN
         LET g_oob_d[l_ac2].oob13_1=l_gem10
      ELSE
         LET g_oob_d[l_ac2].oob13_1=l_nmg.nmg11
      END IF   
   ELSE
      LET g_oob_d[l_ac2].oob13_1=''
   END IF
   #---->為防止收支單輸入兩筆單身
   LET l_sql = "SELECT npk_file.* FROM npk_file ",
               " WHERE npk00= '",g_oob_d[l_ac2].oob06_1,"'",
               "       AND npk01 ='",g_oob_d[l_ac2].oob15_1,"'"   
   PREPARE t400_oob06_1_npk FROM l_sql
   DECLARE t400_oob06_1_npk_c1 CURSOR FOR t400_oob06_1_npk
   FOREACH t400_oob06_1_npk_c1 INTO l_npk.*
     IF SQLCA.sqlcode THEN
        CALL cl_err('t400_oob06_1_npk_c1',SQLCA.sqlcode,0)
        LET g_errno = 'N' EXIT FOREACH
     END IF
     IF l_npk.npk05!=g_ooa.ooa23 THEN    #幣別與沖帳不一致
        CALL cl_err('','axr-144',1) LET g_errno='N' EXIT FOREACH
     END IF
     LET g_oob_d[l_ac2].oob07_1=l_npk.npk05   #幣別
     LET g_oob_d[l_ac2].oob08_1=l_npk.npk06   #匯率
     LET g_oob_d[l_ac2].oob09_1=l_npk.npk08 - tot1   #原幣入帳金額               
     LET g_oob_d[l_ac2].oob10_1=l_npk.npk09 - tot2  #本幣入帳金額                         
     SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1   
     CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1    
     CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1      
     IF l_nmg.nmg29='Y' THEN
        LET g_oob_d[l_ac2].oob11_1=l_npk.npk071  #科目編號        
        IF g_aza.aza63='Y' THEN                               
           LET g_oob_d[l_ac2].oob111_1=l_npk.npk073  #科目二編號   
        END IF                                               
     ELSE
        LET g_oob_d[l_ac2].oob11_1=l_npk.npk07   #科目編號
        IF g_aza.aza63='Y' THEN                               
           LET g_oob_d[l_ac2].oob111_1=l_npk.npk072  #科目二編號   
        END IF                                                
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
             RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
     END IF
     IF YEAR(g_ooa.ooa02) <> YEAR(l_nmg.nmg02) THEN
        CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
             RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
     END IF
     SELECT nmz20 INTO l_nmz20 FROM nmz_file WHERE nmz00 = '0'
     IF l_nmz20 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
        IF g_apz.apz27 = 'Y' THEN                 
           LET g_oob_d[l_ac2].oob08_1 = l_nmg.nmg09
        ELSE                                       
        	 LET g_oob_d[l_ac2].oob08_1 = l_npk.npk06     
        END IF                                         	    
        IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
           LET g_oob_d[l_ac2].oob08_1 = l_npk.npk06
        END IF
        CALL s_g_np('3','2',g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1) RETURNING tot3
        IF (tot1+g_oob_d[l_ac2].oob09_1) = l_nmg.nmg23 THEN   
            LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
        END IF
     END IF
     LET g_oob_d[l_ac2].oob12_1=l_npk.npk10   
     EXIT FOREACH
  END FOREACH
END FUNCTION
 
FUNCTION t400_oob06_1_item_2()      # 檢查待抵/應收帳款
   DEFINE p_sw           LIKE type_file.chr1        # 2:取待抵 1:取應收
   DEFINE l_oma          RECORD LIKE oma_file.*
   DEFINE l_omb          RECORD LIKE omb_file.*
   DEFINE tot1,tot2      LIKE oob_file.oob09
   DEFINE l_omb14t       LIKE omb_file.omb14t   
   DEFINE l_omb16t       LIKE omb_file.omb16t   
   DEFINE l_oea61        LIKE oea_file.oea61    
   DEFINE l_oea1008      LIKE oea_file.oea1008  
   DEFINE l_per          LIKE oea_file.oea261   
 
  #-MOD-B70102-add-
   IF g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1' THEN
   ELSE
      RETURN
   END IF
  #-MOD-B70102-end-

   #LET g_sql="SELECT * FROM ",g_dbs_new CLIPPED,"oma_file WHERE oma01=?"
   #LET g_sql="SELECT * FROM ",cl_get_target_table(g_plant,'oma_file'),
   LET g_sql="SELECT * FROM oma_file ",#FUN-A50102
             " WHERE oma01=?"
   #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        
   #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql 
   PREPARE t400_oob06_1_item_p1_2 FROM g_sql
   DECLARE t400_oob06_1_item_c12 CURSOR FOR t400_oob06_1_item_p1_2
   OPEN t400_oob06_1_item_c12 USING g_oob_d[l_ac2].oob06_1
   FETCH t400_oob06_1_item_c12 INTO l_oma.*
   IF STATUS THEN CALL cl_err('sel oma',STATUS,1) LET g_errno='N' END IF
   IF l_oma.omavoid = 'Y' THEN
      CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
   END IF
   IF l_oma.omaconf='N' THEN
      CALL cl_err('','axr-194',1) LET g_errno='N'
   END IF
   LET tot1 = 0
   LET tot2 = 0
   SELECT * INTO l_omb.* FROM omb_file
    WHERE omb01 = g_oob_d[l_ac2].oob06_1 AND omb03 = g_oob_d[l_ac2].oob15_1
   #TQC-C70059--mark--str--
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1
   #   AND oob15_1 = g_oob_d[l_ac2].oob15_1
   #   AND oob01 = ooa01 AND ooaconf = 'N'
   #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)      
   #   AND oob03_d = g_oob_d[l_ac2].oob03_d
   #   AND oob04_1 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--mark--end--
 
   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob15 = g_oob_d[l_ac2].oob15_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--add--end--

   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF

   IF l_oma.oma00='11' OR l_oma.oma00='12' OR l_oma.oma00='13' THEN
      CASE l_oma.oma00
        WHEN 11
           SELECT oea61,oea1008,oea261
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
        WHEN 12
           SELECT oea61,oea1008,oea262
             INTO l_oea61,l_oea1008,l_per 
             FROM oga_file,oea_file
            WHERE oga01 = l_oma.oma16
             AND oga16 = oea01
        WHEN 13
           SELECT oea61,oea1008,oea263
             INTO l_oea61,l_oea1008,l_per 
             FROM oea_file
            WHERE oea01 = l_oma.oma16
      END CASE

      IF cl_null(l_per) THEN
         LET l_per = 100
      END IF

      IF cl_null(l_oea1008) THEN
         LET l_oea1008 = 100
      END IF

      IF cl_null(l_oea61) THEN
         LET l_oea61 = 100
      END IF

      IF g_oma.oma213 = 'Y' THEN
         LET l_omb14t = l_omb.omb14t * l_per / l_oea1008
         LET l_omb16t = l_omb.omb16t * l_per / l_oea1008
      ELSE
         LET l_omb14t = l_omb.omb14t * l_per / l_oea61
         LET l_omb16t = l_omb.omb16t * l_per / l_oea61
      END IF
   ELSE
      LET l_omb14t = l_omb.omb14t
      LET l_omb16t = l_omb.omb16t
   END IF

   #當多帳期的應收金額>單身的應收金額,應以單身的應收金額為帶出的金額
   IF g_oob_d[l_ac2].oob09_1 > l_omb14t - l_omb.omb34 - tot1 THEN   
      LET g_oob_d[l_ac2].oob09_1 = l_omb14t - l_omb.omb34 - tot1
      LET g_oob_d[l_ac2].oob10_1 = l_omb16t - l_omb.omb35 - tot2
   END IF   
   IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
      IF g_apz.apz27 = 'Y' THEN                
         LET g_oob_d[l_ac2].oob08_1 = l_omb.omb36
      ELSE                                     
      	 LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24   
      END IF                                   	    
      IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24
         DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
      END IF
      CALL s_g_np('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                  RETURNING tot3
      IF (tot1+g_oob_d[l_ac2].oob09_1+l_omb.omb34) = l_omb14t THEN   
         LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
         DISPLAY BY NAME g_oob_d[l_ac2].oob10_1
      END IF
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file                 
   WHERE azi01 = g_oob_d[l_ac2].oob07_1
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1   
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1    
  DISPLAY BY NAME g_oob_d[l_ac2].oob09_1
  DISPLAY BY NAME g_oob_d[l_ac2].oob10_1
END FUNCTION
 
FUNCTION t400_oob06_1_13_2(p_sw)            # 檢查待抵/應收帳款
  DEFINE p_sw             LIKE type_file.chr1        # 2:取待抵 1:取應收
  DEFINE l_oma            RECORD LIKE oma_file.*
  DEFINE l_omc            RECORD LIKE omc_file.*   
  DEFINE tot1,tot2,tot3 LIKE oob_file.oob09
  DEFINE l_oox10        LIKE oox_file.oox10
  DEFINE l_aag05        LIKE aag_file.aag05   
  DEFINE tot4,tot4t     LIKE type_file.num20_6    
  DEFINE l_bookno       LIKE aag_file.aag00   
 
 
  LET g_sql="SELECT oma_file.*,omc_file.* ",  
            #"  FROM ",cl_get_target_table(g_plant,'omc_file'), 
            #"    ,  ",cl_get_target_table(g_plant,'oma_file'), 
            "  FROM omc_file,oma_file ",#FUN-A50102
            " WHERE oma01=omc01 AND omc01=? AND omc02=?"   
 	 #CALL cl_replace_sqldb(g_sql) RETURNING g_sql        
     #CALL cl_parse_qry_sql(g_sql,g_plant) RETURNING g_sql 
  PREPARE t400_oob06_1_13_p1 FROM g_sql
  DECLARE t400_oob06_1_13_c1 CURSOR FOR t400_oob06_1_13_p1
  OPEN t400_oob06_1_13_c1 USING g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob19_1
  FETCH t400_oob06_1_13_c1 INTO l_oma.*,l_omc.*    
  IF STATUS THEN CALL cl_err('sel omc',"aap-777",1) LET g_errno='N' END IF  
  IF l_oma.omavoid = 'Y' THEN
     CALL cl_err(l_oma.oma01,'axr-103',0) LET g_errno = 'N'
  END IF
  IF l_oma.omaconf='N' THEN  
     CALL cl_err('','axr-194',1) LET g_errno='N'
  END IF
  IF p_sw='2' AND l_oma.oma00[1,1]!='2' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF p_sw='1' AND l_oma.oma00[1,1]!='1' THEN
     CALL cl_err('','axr-186',1) LET g_errno='N' END IF
  IF l_oma.oma00='23' THEN
     CALL cl_err('','axr-188',1) LET g_errno='N' END IF
  IF l_oma.oma68 != g_ooa.ooa03 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma69 != g_ooa.ooa032 THEN
     CALL cl_err('','axr-140',1) 
  END IF
  IF l_oma.oma23!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_oma.oma54t<=l_oma.oma55 THEN
     CALL cl_err('','axr-190',1) LET g_errno='N' END IF
 #原幣沖完但本幣未沖完
  IF l_oma.oma54t=l_oma.oma55 AND l_oma.oma56t!=l_oma.oma57 THEN
     CALL cl_err('','axr-193',1) LET g_errno='N' END IF
## No.2723 modify 1998/11/05 立帳日不可比沖款日小
  IF l_oma.oma02 > g_ooa.ooa02 THEN
     CALL cl_err('','axr-371',0) LET g_errno = 'N'
  END IF
 #CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 mark
  CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
  IF g_flag='1' THEN
     CALL cl_err(l_oma.oma02,'aoo-081',1)
  END IF
  LET g_oob_d[l_ac2].oob07_1=l_oma.oma23
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
  LET g_oob_d[l_ac2].oob08_1=l_oma.oma24
## No.2694 modify 1998/10/31 不可沖超過
   LET tot1 = 0
   LET tot2 = 0
   #TQC-C70059--mark--str--
   #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file 
   # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1
   #   AND oob01 = ooa01 AND ooaconf = 'N'
   #   AND oob19_1 = g_oob_d[l_ac2].oob19_1   
   #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)     
   #   AND oob03_d = g_oob_d[l_ac2].oob03_d
   #   AND oob04_1 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--mark--str--

   #TQC-C70059--add--str--
   SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
    WHERE oob06 = g_oob_d[l_ac2].oob06_1
      AND oob01 = ooa01 AND ooaconf = 'N'
      AND oob19 = g_oob_d[l_ac2].oob19_1
      AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
      AND oob03 = g_oob_d[l_ac2].oob03_d
      AND oob04 = g_oob_d[l_ac2].oob04_1
   #TQC-C70059--add--end--
 
   IF tot1 IS NULL THEN
      LET tot1 = 0
   END IF
   IF tot2 IS NULL THEN
      LET tot2 = 0
   END IF
   LET g_oob_d[l_ac2].oob09_1 = l_omc.omc08  - l_omc.omc10 - tot1 
   LET g_oob_d[l_ac2].oob10_1 = l_omc.omc09  - l_omc.omc11 - tot2 
   IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
      IF g_apz.apz27 = 'Y' THEN                        
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma60   
      ELSE                                             
      	 LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24          
      END IF                                               
      IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
         LET g_oob_d[l_ac2].oob08_1 = l_oma.oma24
      END IF
#     CALL s_g_np1('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,'',g_oob_d[l_ac2].oob19_1)     
      CALL s_g_np1('1',l_oma.oma00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1)     #No.FUN-AB0034
           RETURNING tot3
      #取得衝帳單的待扺金額
      CALL t400_mntn_offset_inv(b_oob.oob06) RETURNING tot4,tot4t
      CALL cl_digcut(tot4,t_azi04) RETURNING tot4              
      CALL cl_digcut(tot4t,g_azi04) RETURNING tot4t    
      #未衝金額扣除待扺
      LET tot3 = tot3 - tot4t
      IF (tot1+g_oob_d[l_ac2].oob09_1+l_omc.omc10) = l_omc.omc08  THEN  
         LET g_oob_d[l_ac2].oob10_1 = tot3 - tot2
      END IF
   END IF
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1     
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1     
  LET g_oob_d[l_ac2].oob11_1=l_oma.oma18
  IF g_aza.aza63='Y' THEN                 
     LET g_oob_d[l_ac2].oob111_1=l_oma.oma181 
  END IF                                  
 LET l_aag05=''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1     
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_oma.oma15
  ELSE   #MOD-730022
     LET g_oob_d[l_ac2].oob13_1=''   
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_oma.oma02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
  END IF
 
  IF p_sw = '2' THEN
     LET g_oob_d[l_ac2].oob14_1=l_oma.oma16
  ELSE
     LET g_oob_d[l_ac2].oob14_1=l_oma.oma10
  END IF
END FUNCTION
 
FUNCTION t400_oob06_1_19_2(l_sw)         # 借/貸方檢查 : A/P  
  DEFINE l_apa            RECORD LIKE apa_file.*
  DEFINE l_apc            RECORD LIKE apc_file.*   
  DEFINE p05,p05f         LIKE type_file.num20_6    
  DEFINE l_apz27          LIKE apz_file.apz27
  DEFINE l_amt3           LIKE type_file.num20_6     
  DEFINE l_amtf,l_amt     LIKE type_file.num20_6     
  DEFINE tot1,tot2,tot3   LIKE type_file.num20_6     
  DEFINE l_aag05          LIKE aag_file.aag05   
  DEFINE l_bookno         LIKE aag_file.aag00   
  DEFINE l_sw             LIKE type_file.chr1 
  DEFINE l_amt16          LIKE type_file.num20_6     #No.MOD-BB0016 
 
  IF cl_null(g_oob_d[l_ac2].oob19_1) THEN LET g_oob_d[l_ac2].oob19_1 = '1' END IF 
  SELECT apa_file.*,apc_file.* INTO l_apa.*,l_apc.* FROM apa_file,apc_file 
   WHERE apa01= g_oob_d[l_ac2].oob06_1 
     AND apa01=apc01 
     AND apc02= g_oob_d[l_ac2].oob19_1    
     AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
  IF STATUS THEN 
     CALL cl_err3("sel","apa_file",g_oob_d[l_ac2].oob06_1,"",STATUS,"","sel apa",1)    
     LET g_errno='N' 
  END IF
  IF l_apa.apa06!=g_ooa.ooa03 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當付款廠商!=帳款客戶時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa07!=g_ooa.ooa032 THEN
     CALL cl_err('','axr-138',1) {LET g_errno='N'} END IF
     #當廠商名稱!=客戶名稱時,警告但允許!(要回頭改axr-138之警句!!!)
  IF l_apa.apa13!=g_ooa.ooa23 THEN
     CALL cl_err('','axr-144',1) LET g_errno='N' END IF
  IF l_apa.apa41 != 'Y' THEN CALL cl_err('','axr-194',1) LET g_errno='N' END IF
 #CALL s_get_bookno(YEAR(l_apa.apa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 mark
  CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
  IF g_flag='1' THEN
     CALL cl_err(l_apa.apa02,'aoo-081',1)
  END IF
  #須考慮未確認沖帳資料
  #TQC-C70059--mark--str--
  #SELECT SUM(oob09_1),SUM(oob10_1) INTO tot1,tot2 FROM oob_file,ooa_file
  # WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND oob19_1=g_oob_d[l_ac2].oob19_1   
  #   AND oob01 = ooa01 AND ooaconf = 'N'
  #   AND (oob01 <> g_ooa.ooa01 OR oob02_1 <> g_oob_d_t.oob02_1)        
  #   AND oob03_d = g_oob_d[l_ac2].oob03_d
  #   AND oob04_1 = g_oob_d[l_ac2].oob04_1
  #TQC-C70059--mark--end--
  #TQC-C70059--add--str--
  SELECT SUM(oob09),SUM(oob10) INTO tot1,tot2 FROM oob_file,ooa_file
   WHERE oob06 = g_oob_d[l_ac2].oob06_1 AND oob19_1=g_oob_d[l_ac2].oob19_1
     AND oob01 = ooa01 AND ooaconf = 'N'
     AND (oob01 <> g_ooa.ooa01 OR oob02 <> g_oob_d_t.oob02_1)
     AND oob03 = g_oob_d[l_ac2].oob03_d
     AND oob04 = g_oob_d[l_ac2].oob04_1
  #TQC-C70059--add--end--
  IF cl_null(tot1) THEN LET tot1 = 0 END IF
  IF cl_null(tot2) THEN LET tot2 = 0 END IF
 
  LET p05f = 0 LET p05 = 0
  IF l_sw = '1' THEN
     SELECT SUM(apg05f),SUM(apg05) INTO p05f,p05
       FROM apg_file,apf_file
      WHERE apg04=g_oob_d[l_ac2].oob06_1
        AND apg06=g_oob_d[l_ac2].oob19_1
        AND apg01=apf01 AND apf41='N' AND apg01<>g_ooa.ooa01
  ELSE
     SELECT SUM(aph05f),SUM(aph05) INTO p05f,p05
       FROM aph_file,apf_file
      WHERE aph04=g_oob_d[l_ac2].oob06_1
        AND aph17=g_oob_d[l_ac2].oob19_1
        AND aph01=apf01 AND apf41='N' AND aph01<>g_ooa.ooa01
  END IF
  IF p05f IS NULL THEN LET p05f=0 END IF
  IF p05  IS NULL THEN LET p05 =0 END IF
  LET l_amtf = l_apc.apc08-l_apc.apc10-l_apc.apc16-tot1-p05f
  IF g_apz.apz27 = 'N' THEN
    #----------------------------------MOD-BB0016-------------------------start
     LET l_amt16 = l_apc.apc16*l_apc.apc06
     CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16
     IF l_apc.apc09 -l_apc.apc11 -tot2-p05 = l_amt16  and l_amt16>0 THEN
        CALL cl_err('','axr-413',1) LET g_errno='N'
     END IF
    #LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_apc.apc16*l_apc.apc06)-tot2-p05
     LET l_amt  = l_apc.apc09 -l_apc.apc11 -(l_amt16)-tot2-p05
    #----------------------------------MOD-BB0016---------------------------end
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  ELSE
    #----------------------------------MOD-BB0016-------------------------start
     LET l_amt16 = l_apc.apc16*l_apc.apc07
     CALL cl_digcut(l_amt16,t_azi04) RETURNING l_amt16
     IF l_apc.apc13 -tot2-p05 = l_amt16  and l_amt16>0 THEN
        CALL cl_err('','axr-413',1) LET g_errno='N'
     END IF
    #LET l_amt  = l_apc.apc13 -(l_apc.apc16*l_apc.apc07)-tot2-p05
     LET l_amt  = l_apc.apc13 -(l_amt16)-tot2-p05
    #----------------------------------MOD-BB0016---------------------------end
     IF l_amtf <=0 OR l_amt <=0 THEN
        CALL cl_err('','axr-185',1) LET g_errno='N'
     END IF
  END IF
  LET g_oob_d[l_ac2].oob07_1=l_apa.apa13
  SELECT azi04 INTO t_azi04 FROM azi_file WHERE azi01 = g_oob_d[l_ac2].oob07_1 
  LET g_oob_d[l_ac2].oob08_1=l_apc.apc06   
  LET g_oob_d[l_ac2].oob09_1=l_amtf
  LET g_oob_d[l_ac2].oob10_1=l_amt
  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) RETURNING g_oob_d[l_ac2].oob09_1    
  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1     
  LET g_oob_d[l_ac2].oob11_1=l_apa.apa54
  IF g_aza.aza63='Y' THEN                 
     LET g_oob_d[l_ac2].oob111_1=l_apa.apa541 
  END IF                                 
  LET l_aag05 = ''
  SELECT aag05 INTO l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1
                                            AND aag00=g_bookno1         
  IF l_aag05 = 'Y' THEN
     LET g_oob_d[l_ac2].oob13_1=l_apa.apa22
  ELSE
     LET g_oob_d[l_ac2].oob13_1=''
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno1,g_oob_d[l_ac2].oob11_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob11_1
  END IF
  IF YEAR(g_ooa.ooa02) <> YEAR(l_apa.apa02) THEN
     CALL s_tag(YEAR(g_ooa.ooa02),g_bookno2,g_oob_d[l_ac2].oob111_1)
          RETURNING l_bookno,g_oob_d[l_ac2].oob111_1
  END IF
  LET g_oob_d[l_ac2].oob14_1=l_apa.apa08
  LET g_oob_d[l_ac2].oob12_1=l_apa.apa25   
  SELECT apz27 INTO l_apz27 FROM apz_file WHERE apz00 = '0'
  IF l_apz27 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
     IF g_apz.apz27 = 'Y' THEN                 
        LET g_oob_d[l_ac2].oob08_1 = l_apa.apa72
     ELSE                                      
     	  LET g_oob_d[l_ac2].oob08_1 = l_apc.apc06     
     END IF                                          
     IF cl_null(g_oob_d[l_ac2].oob08_1) OR g_oob_d[l_ac2].oob08_1 = 0 THEN
        LET g_oob_d[l_ac2].oob08_1 = l_apc.apc06   
     END IF
     CALL s_g_np('2',l_apa.apa00,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1)
                 RETURNING l_amt3
     #未付金額-已KEY未確認-留置金額
     IF (tot1+g_oob_d[l_ac2].oob09_1+p05f+l_apc.apc10) = l_apc.apc08 THEN  
        LET g_oob_d[l_ac2].oob10_1 = l_amt3-tot2-p05-(l_apc.apc16*l_apc.apc06)   
     END IF
     CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) RETURNING g_oob_d[l_ac2].oob10_1  
  END IF
END FUNCTION
 
FUNCTION t400_oob06_1_chk_2(p_oob06_1,p_oob15_1,p_oob19_1,p_n) 
DEFINE p_n           LIKE type_file.num5
DEFINE i             LIKE type_file.num5
DEFINE p_oob06_1       LIKE oob_file.oob06 
DEFINE p_oob15_1       LIKE oob_file.oob15
DEFINE p_oob19_1       LIKE oob_file.oob19      
 
   LET g_errno = ''
   IF p_n > 1 THEN
      FOR i = 1 TO p_n-1
         IF g_ooz.ooz62 = 'N' THEN
            IF g_oob_d[i].oob06_1 = p_oob06_1 AND
               g_oob_d[i].oob19_1 = p_oob19_1 THEN  
               LET g_errno = 'atm-310'
               EXIT FOR
            END IF
         ELSE
            IF g_oob_d[i].oob06_1 = p_oob06_1 AND
               g_oob_d[i].oob19_1 = p_oob19_1 AND   
               g_oob_d[i].oob15_1 = p_oob15_1 THEN
               LET g_errno = 'atm-310'
               EXIT FOR
            END IF
         END IF
      END FOR
   END IF 
    
END FUNCTION 

FUNCTION t400_oob07_1_2(p_cmd)
DEFINE
      p_cmd        LIKE type_file.chr1,     
      l_azi01      LIKE azi_file.azi01,
      l_aziacti    LIKE azi_file.aziacti
 
      LET g_errno = ' '
      SELECT azi01,aziacti INTO l_azi01,l_aziacti
        FROM azi_file
       WHERE azi01 = g_oob_d[l_ac2].oob07_1
      CASE
          WHEN SQLCA.SQLCODE = 100 LET g_errno = 'aap-002'
                                   LET l_azi01 = NULL
                                   LET l_aziacti = NULL
          WHEN l_aziacti = 'N' LET g_errno = '9028'
          OTHERWISE            LET g_errno = SQLCA.SQLCODE USING '-------'
      END CASE
END FUNCTION

FUNCTION t400_bp_refresh_2()  
   DEFINE p_cmd        LIKE type_file.chr1   

   IF g_bgjob = 'Y' THEN
      RETURN
   END IF

   DISPLAY ARRAY g_oob_d TO s_oob_d.* ATTRIBUTE(COUNT=g_rec_b2,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
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

END FUNCTION

FUNCTION t400_b_fill_2(p_wc3)              #BODY FILL UP
DEFINE p_wc3           LIKE type_file.chr1000   
DEFINE l_n             LIKE type_file.chr1      #No.FUN-AA0088  
 
    IF cl_null(p_wc3) THEN LET p_wc3 = '1=1' END IF   #MOD-BB0332 
    LET g_sql =
       "SELECT oob02,oob03,oob04,'',oob06,oob19,oob15,oob24,'',oob27,oob25,oob26,'',oob11,oob111,oob13,oob14,",    #FUN-AA0088 oob24-oob26
        "       oob07,oob08,oob09,oob10,oob12,",
        "       oobud01,oobud02,oobud03,oobud04,oobud05,",
        "       oobud06,oobud07,oobud08,oobud09,oobud10,",
        "       oobud11,oobud12,oobud13,oobud14,oobud15 ",
        " FROM oob_file ",
        " WHERE oob01 ='",g_ooa.ooa01,"'",  #單頭
        "   AND oob03 = ? ",   #No.FUN-AA0088
        "   AND ",p_wc3 CLIPPED,                     #單身
        " ORDER BY 1"
 
    PREPARE t400_pb2 FROM g_sql
    DECLARE oob_curs2                       #SCROLL CURSOR
        CURSOR FOR t400_pb2
    CALL g_oob_d.clear()
    LET g_rec_b2 = 0
    LET g_cnt = 1
#No.FUN-AA0088 --begin  
    IF g_prog ='axrt400' THEN LET l_n =2 END IF 
    #IF g_prog ='axrt401' THEN LET l_n =1 END IF #FUN-C20018 mark--
    #FUN-C20018--add--begin
    IF g_prog ='axrt401' THEN
       #IF g_ooa.ooa40=1 THEN   #FUN-C20063 mark--
       IF g_ooa.ooa40='01' THEN #FUN-C20063
          LET l_n=1
       ELSE
          LET l_n=2
       END IF   
    END IF
    #FUN-C20018--add--end     
    FOREACH oob_curs2 USING l_n INTO g_oob_d[g_cnt].*   #單身 ARRAY 填充
#    FOREACH oob_curs2 INTO g_oob_d[g_cnt].*   #單身 ARRAY 填充
#No.FUN-AA0088 --end
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
#No.FUN-AA0088 --begin
        SELECT occ02 INTO g_oob_d[g_cnt].occ02 FROM occ_file WHERE occ01 = g_oob_d[g_cnt].oob24_1
        SELECT ooc02 INTO g_oob_d[g_cnt].ooc02 FROM ooc_file WHERE ooc01 = g_oob_d[g_cnt].oob26_1 
#No.FUN-AA0088 --end
        CALL s_oob04(g_oob_d[g_cnt].oob03_d,g_oob_d[g_cnt].oob04_1)
                RETURNING g_oob_d[g_cnt].oob04_1_d
        LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
           CALL cl_err( '', 9035, 0 )
           EXIT FOREACH
        END IF
    END FOREACH
    CALL g_oob_d.deleteElement(g_cnt)
    LET g_rec_b2=g_cnt - 1
    DISPLAY g_rec_b2 TO FORMONLY.cn3
#   LET g_cnt = 0 DISPLAY g_cnt TO FORMONLY.cn3
     CALL t400_bp_refresh_2() 
END FUNCTION

FUNCTION t400_set_comb_oob04()
  DEFINE l_ooc      RECORD LIKE ooc_file.*
  DEFINE comb_value STRING
  DEFINE comb_item  LIKE type_file.chr1000    
                                                                                                           
    LET comb_value = '1,2,3,4,5,6,7,8,9,E,F,H,Q'        #FUN-D70029 add 'H'                                                                               
                                                                                                         
    SELECT ze03 INTO comb_item FROM ze_file                                                                                      
     WHERE ze01='axr-218' AND ze02=g_lang                                                                                       

    DECLARE ooc_cs CURSOR FOR
     SELECT * FROM ooc_file
    FOREACH ooc_cs INTO l_ooc.*
        LET comb_value = comb_value CLIPPED,',',l_ooc.ooc01
        LET comb_item  = comb_item  CLIPPED,',',l_ooc.ooc01 CLIPPED,'.',
                                                l_ooc.ooc02
    END FOREACH
    CALL cl_set_combo_items('oob04',comb_value,comb_item)
END FUNCTION

FUNCTION t400_set_comb_oob04_1()
  DEFINE l_ooc      RECORD LIKE ooc_file.*
  DEFINE comb_value STRING
  DEFINE comb_item  LIKE type_file.chr1000    
                                                                                                           
#No.FUN-AA0088 -begin
   #LET comb_value = '1,2,3,4,7,B'   #MOD-B50156 mark
    LET comb_value = '1,2,4,7,9,B'   #MOD-B50156
                                                                                                      
    SELECT ze03 INTO comb_item FROM ze_file                                                                                      
     #WHERE ze01='axr-323' AND ze02=g_lang    #MOD-B30259                                                                                
     WHERE ze01='axr-324' AND ze02=g_lang     #MOD-B30259                                                                               
#No.FUN-AA0088 --end
    DECLARE ooc_cs1 CURSOR FOR
     SELECT * FROM ooc_file
    FOREACH ooc_cs1 INTO l_ooc.*
        LET comb_value = comb_value CLIPPED,',',l_ooc.ooc01
        LET comb_item  = comb_item  CLIPPED,',',l_ooc.ooc01 CLIPPED,'.',
                                                l_ooc.ooc02
    END FOREACH
    CALL cl_set_combo_items('oob04_1',comb_value,comb_item)
END FUNCTION

FUNCTION t400_b2()
DEFINE l_oma55      LIKE oma_file.oma55    #No.FUN-960141
DEFINE l_oma57      LIKE oma_file.oma57    #No.FUN-960141
DEFINE l_oma55_o    LIKE oma_file.oma55    #No.FUN-960141
DEFINE l_oma57_o    LIKE oma_file.oma57    #No.FUN-960141
DEFINE l_oma16      LIKE oma_file.oma16    #No.FUN-960141
DEFINE l_ac_t          LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #未取消的ARRAY CNT
       l_ac2_t         LIKE type_file.num5,   #No.FUN-D30032
       l_row,l_col     LIKE type_file.num5,   #No.FUN-680123 SMALLINT,                     #分段輸入之行,列數
       l_n,l_cnt       LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #檢查重複用
       l_lock_sw       LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #單身鎖住否
       p_cmd           LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),               #處理狀態
       l_possible      LIKE type_file.num5,   #No.FUN-680123 SMALLINT, #用來設定判斷重複的可能性
       l_b2            LIKE type_file.chr1000,#No.FUN-680123 VARCHAR(30),
      #l_flag          LIKE type_file.num10,  #No.FUN-680123 INTEGER, #CHI-A30007 mark
       l_flag          LIKE type_file.chr1,                           #CHI-A30007 
       oob10_t         LIKE oob_file.oob10,
       l_nmh32         LIKE nmh_file.nmh32,
       l_aag07         LIKE aag_file.aag07,
       oob08_t         LIKE oob_file.oob08,  #FUN-4C0013
       oob09_t         LIKE oob_file.oob09,  #FUN-4C0013
       l_allow_insert  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可新增否
       l_allow_delete  LIKE type_file.num5,   #No.FUN-680123 SMALLINT,              #可刪除否
       ls_tmp          STRING,
       l_ooa34         LIKE ooa_file.ooa34,
       l_aag05         LIKE aag_file.aag05   #MOD-5B0012
DEFINE l_nmh04         LIKE nmh_file.nmh04   #FUN-660035
DEFINE l_i             LIKE type_file.num5   #TQC-6B0067
DEFINE l_oma00         LIKE oma_file.oma00   #MOD-940420
DEFINE l_apa00         LIKE apa_file.apa00   #MOD-940420
#No.FUN-AA0088 --begin
DEFINE l_oob09         LIKE oob_file.oob09
DEFINE l_oob10         LIKE oob_file.oob10
DEFINE l_oob09_1       LIKE oob_file.oob09
DEFINE l_oob10_1       LIKE oob_file.oob10
#No.FUN-AA0088 --end
DEFINE l_count1        LIKE type_file.num5   #TQC-B30221
DEFINE l_count2        LIKE type_file.num5   #TQC-B30221 
 
    LET l_ooa34 = g_ooa.ooa34      #FUN-550049
 
    LET g_action_choice = ""
    IF g_ooa.ooa01 IS NULL THEN RETURN END IF
    IF g_ooa.ooaconf = 'Y' THEN CALL cl_err('','axr-101',0) RETURN END IF
    IF g_ooa.ooaconf = 'X' THEN
       CALL cl_err('','9024',0) RETURN
    END IF
    #FUN-C30140---add----str---
    IF g_ooa.ooa34 matches '[Ss]' THEN
        CALL cl_err('','apm-030',0)
        RETURN
    END IF
    #FUN-C30140---add----end---
 
    CALL t400_g_b()                 #先由應收票據或TT自動產生借方單身
    CALL t400_b_fill_2(g_wc3)
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = " SELECT * FROM oob_file WHERE oob01=? AND oob02=? FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t400_bcl1 CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
      LET l_ac_t = 0
      LET l_ac2_t = 0  #FUN-D30032
      LET l_allow_insert = cl_detail_input_auth("insert")
      LET l_allow_delete = cl_detail_input_auth("delete")

      INPUT ARRAY g_oob_d WITHOUT DEFAULTS FROM s_oob_d.*
            ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
 
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac2 = ARR_CURR()
            DISPLAY l_ac2 TO FORMONLY.cn4
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()
            LET g_success = 'Y'  
            BEGIN WORK
 
            OPEN t400_cl USING g_ooa.ooa01
            IF STATUS THEN
               CALL cl_err("OPEN t400_cl:", STATUS, 1)
               CLOSE t400_cl
               ROLLBACK WORK
               RETURN
            END IF
            FETCH t400_cl INTO g_ooa.*   # 鎖住將被更改或取消的資料
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_ooa.ooa01,SQLCA.sqlcode,0)     # 資料被他人LOCK
               CLOSE t400_cl 
               ROLLBACK WORK 
               RETURN
            END IF
            IF g_rec_b2>=l_ac2 THEN
               LET p_cmd='u'
               LET g_oob_d_t.* = g_oob_d[l_ac2].*  #BACKUP
               OPEN t400_bcl1 USING g_ooa.ooa01,g_oob_d_t.oob02_1
               IF STATUS THEN
                  CALL cl_err("OPEN t400_bcl1:", STATUS, 1)
                  LET l_lock_sw = "Y"
                  CLOSE t400_bcl1
                  ROLLBACK WORK
               ELSE




                  FETCH t400_bcl1 INTO b_oob.*
                  IF SQLCA.sqlcode THEN
                      CALL cl_err('lock oob',SQLCA.sqlcode,1)
                      LET l_lock_sw = "Y"
                  ELSE
                      CALL t400_b_move_to_2()
                  END IF
               END IF
               CALL t400_set_entry_b_2()
               CALL t400_set_entry_b_1_2()    
               CALL t400_set_no_entry_b_2()
               CALL t400_set_no_entry_b1_2()
               CALL t400_set_entry_b1_2()
               CALL t400_set_no_entry_b_1_2()    
               CALL t400_set_no_required_b_2()   
               CALL t400_set_required_b_2()      
               CALL cl_show_fld_cont()             
               CALL cl_show_fld_cont()    
               LET g_change = 'N'          #MOD-B60022
            END IF
 
        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_success = 'N'   
               CANCEL INSERT
            END IF
            CALL t400_b_move_back_2()
            SELECT COUNT(*) INTO l_n FROM oob_file
             WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
            IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
               IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                  (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                  IF NOT t400_oob09_1_13_2('2',p_cmd) THEN
                  END IF
               END IF
            END IF
            INSERT INTO oob_file VALUES(b_oob.*)
            IF SQLCA.sqlcode THEN
               LET g_success = 'N'   
               CALL cl_err3("ins","oob_file",b_oob.oob01,b_oob.oob02,SQLCA.sqlcode,"","ins oob",1)  
               CANCEL INSERT
            END IF
            CALL t400_mlog('A')
            CALL t400_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'INSERT O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
                  LET l_ooa34 = '0'
               END IF                                   
               LET g_rec_b2=g_rec_b2+1
               DISPLAY g_rec_b2 TO FORMONLY.cn3
               COMMIT WORK
            ELSE
               MESSAGE 'INSERT ERR'
               ROLLBACK WORK
            END IF
        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
            INITIALIZE g_oob_d[l_ac2].* TO NULL      
            IF NOT cl_null(g_ooa.ooa23) THEN      #單頭有輸入幣別單身要DEFAULT
                LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
            END IF
            LET b_oob.oob01=g_ooa.ooa01
            LET b_oob.ooblegal = g_ooa.ooalegal
            LET g_oob_d[l_ac2].oob08_1=1
            LET g_oob_d[l_ac2].oob09_1=0
            LET g_oob_d[l_ac2].oob10_1=0
            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料
            LET g_oob_d[l_ac2].oob03_d = '2'               #新輸入資料
            LET g_oob_d[l_ac2].oob04_1 = '1'               #新輸入資料
#No.FUN-AA0088 --begin
            CALL t401_oob_def()
#No.FUN-AA0088 --end
            LET g_oob_d_t.* = g_oob_d[l_ac2].*             #新輸入資料   
            CALL t400_set_entry_b_2()
            CALL t400_set_entry_b_1_2()   
            CALL t400_set_no_entry_b_2()
            CALL t400_set_no_required_b_2()  
            CALL t400_set_required_b_2()     
            CALL cl_show_fld_cont()     
 
            NEXT FIELD oob02_1
 
        BEFORE FIELD oob02_1                            #default 序號
           IF g_oob_d[l_ac2].oob02_1 IS NULL OR g_oob_d[l_ac2].oob02_1 = 0 THEN
                IF l_ac2>1 THEN LET g_chr=g_oob_d[l_ac2-1].oob03_d END IF
                SELECT MAX(oob02)+1 INTO g_oob_d[l_ac2].oob02_1 FROM oob_file
                   WHERE oob01 = g_ooa.ooa01
                IF g_oob_d[l_ac2].oob02_1 IS NULL THEN
                    LET g_oob_d[l_ac2].oob02_1 = 1
                END IF
           END IF
 
        AFTER FIELD oob02_1                        #check 序號是否重複
            IF NOT cl_null(g_oob_d[l_ac2].oob02_1) THEN
               IF g_oob_d[l_ac2].oob02_1 != g_oob_d_t.oob02_1 OR g_oob_d_t.oob02_1 IS NULL THEN
                  SELECT count(*) INTO l_n FROM oob_file
                   WHERE oob01 = g_ooa.ooa01 AND oob02 = g_oob_d[l_ac2].oob02_1
                  IF l_n > 0 THEN
                     LET g_oob_d[l_ac2].oob02_1 = g_oob_d_t.oob02_1
                     CALL cl_err('',-239,0) NEXT FIELD oob02_1
                  END IF
               END IF
            END IF
 
        AFTER FIELD oob03_d
           IF NOT cl_null(g_oob_d[l_ac2].oob03_d) THEN
              IF g_oob_d[l_ac2].oob03_d NOT MATCHES "[12]" THEN NEXT FIELD oob03_d END IF
                 IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN                                                                             
                    LET l_cnt = 0                                                                                                   
                    SELECT COUNT(*) INTO l_cnt FROM ooc_file                                                                        
                       WHERE ooc01 = g_oob_d[l_ac2].oob04_1                                                                              
                    IF l_cnt = 0 THEN                                                                                               
                       IF g_oob_d[l_ac2].oob03_d='1' THEN                                                                                
                          IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,E,Q]' THEN     
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04_1                                                                                       
                          END IF                                                                                                    
                       ELSE                                                                                                         
                          IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,B]' THEN                                                    
                             CALL cl_err('','axr-917',0)                                                                            
                             NEXT FIELD oob04_1                                                                                       
                          END IF                                                                                                    
                       END IF                                                                                                       
                    END IF                                                                                                          
                 END IF                                                                                                             
           END IF
 
        BEFORE FIELD oob04_1
           CALL t400_set_entry_b_2()
           CALL t400_set_no_required_b_2()   
 
        AFTER FIELD oob04_1
           IF NOT cl_null(g_oob_d[l_ac2].oob04_1) THEN
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM ooc_file
                 WHERE ooc01 = g_oob_d[l_ac2].oob04_1
              IF l_cnt = 0 THEN
                 IF g_oob_d[l_ac2].oob03_d='1' THEN
                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1-9,E,Q]' THEN       
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04_1
                    END IF
                 ELSE
                    IF g_oob_d[l_ac2].oob04_1 NOT MATCHES '[1,2,4,7,9,B]' THEN    
                       CALL cl_err('','axr-917',0)
                       NEXT FIELD oob04_1
                    END IF
                 END IF
              END IF
              SELECT azi04 INTO t_azi04 FROM azi_file               
               WHERE azi01 = g_oob_d[l_ac2].oob07_1  
             #若oob04_1='9'時,oob15_1預設值為0,無須維護
              IF g_oob_d[l_ac2].oob04_1='9' THEN
                 LET g_oob_d[l_ac2].oob15_1=0
                 DISPLAY BY NAME g_oob_d[l_ac2].oob15_1
              END IF
              CALL s_oob04(g_oob_d[l_ac2].oob03_d,g_oob_d[l_ac2].oob04_1)
                   RETURNING g_oob_d[l_ac2].oob04_1_d
              CALL t400_acct_code_2()
              IF g_oob_d[l_ac2].oob11_1 IS NULL THEN
                 SELECT ooc03 INTO g_oob_d[l_ac2].oob11_1 FROM ooc_file
                  WHERE ooc01=g_oob_d[l_ac2].oob04_1
                 DISPLAY BY NAME g_oob_d[l_ac2].oob11_1  
              END IF
              IF g_aza.aza63='Y' THEN
                 IF g_oob_d[l_ac2].oob111_1 IS NULL THEN
                    SELECT ooc04 INTO g_oob_d[l_ac2].oob111_1 FROM ooc_file
                     WHERE ooc01=g_oob_d[l_ac2].oob04_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                 END IF
              END IF
              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = "7" AND
                #g_ooa32_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN           #MOD-C80092 g_ooa31_diff mode g_ooa32_diff #MOD-C90154 mark
                 g_ooa31_diff != 0 AND NOT cl_null(g_ooa.ooa23) THEN           #MOD-C90154 add
                 CALL cl_err('','axr-204',0) NEXT FIELD oob04_1
              END IF
              IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[567]" AND
                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob_d[l_ac2].oob09_1 = g_ooa31_diff
                 LET g_oob_d[l_ac2].oob10_1 = g_ooa32_diff
                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
		 DISPLAY BY NAME g_oob_d[l_ac2].oob08_1   
		 DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
		 DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
              END IF
              IF g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[23]" AND
                 g_oob_d[l_ac2].oob09_1 = 0   AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                 LET g_oob_d[l_ac2].oob07_1 = g_ooa.ooa23
                 IF g_ooa31_diff = 0
                    THEN LET g_oob_d[l_ac2].oob08_1 = 1
                    ELSE LET g_oob_d[l_ac2].oob08_1 = g_ooa32_diff/g_ooa31_diff
                 END IF
                 LET g_oob_d[l_ac2].oob09_1 = -g_ooa31_diff
                 LET g_oob_d[l_ac2].oob10_1 = -g_ooa32_diff
                 LET g_oob_d[l_ac2].oob09_1 = cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) 
                 LET g_oob_d[l_ac2].oob10_1 = cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
	         DISPLAY BY NAME g_oob_d[l_ac2].oob08_1  
	         DISPLAY BY NAME g_oob_d[l_ac2].oob09_1   
	         DISPLAY BY NAME g_oob_d[l_ac2].oob10_1   
              END IF

              IF g_oob_d[l_ac2].oob04_1='7' THEN
                 LET g_oob_d[l_ac2].oob07_1 = g_aza.aza17 
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
              END IF

         END IF
         CALL t400_set_no_entry_b_2()
         CALL t400_set_no_entry_b1_2()            
         CALL t400_set_entry_b1_2()            
         CALL t400_set_required_b_2()      
 
        AFTER FIELD oob06_1
           IF NOT cl_null(g_oob_d[l_ac2].oob06_1) THEN
             #若為借方，且非待扺
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 != '3' THEN
                 IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
                       g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN   
                    CALL t400_oob06_1_2()
 
                    IF g_errno = 'N' THEN
                       NEXT FIELD oob06_1
                    END IF
                 END IF
              END IF
 
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                 SELECT nmh04 INTO l_nmh04 FROM nmh_file
                  WHERE nmh01 = g_oob_d[l_ac2].oob06_1
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
                 SELECT nmg01 INTO l_nmh04 FROM nmg_file
                  WHERE nmg00 = g_oob_d[l_ac2].oob06_1
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE oma00 MATCHES '2*'
                    AND oma01 = g_oob_d[l_ac2].oob06_1 
              END IF
              IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'1*'
                    AND apa01 = g_oob_d[l_ac2].oob06_1
                    AND apa02 <= g_ooa.ooa02        
              END IF
              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                 SELECT oma02 INTO l_nmh04 FROM oma_file
                  WHERE  oma00 MATCHES '1*'
                    AND oma01 = g_oob_d[l_ac2].oob06_1 
              END IF
              IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
                 SELECT apa02 INTO l_nmh04 FROM apa_file
                  WHERE apa00 matches'2*'
                    AND apa01 = g_oob_d[l_ac2].oob06_1
                    AND apa02 <= g_ooa.ooa02        
              END IF 
  
              IF SQLCA.sqlcode THEN
                 CALL cl_err3("sel","nmh_file",g_oob_d[l_ac2].oob06_1,"",SQLCA.sqlcode,"","",0) 
              ELSE
                 IF l_nmh04 > g_ooa.ooa02 THEN
                    CALL cl_err('','axr-371',0)
                    NEXT FIELD oob06_1
                 END IF 
              END IF
 
             #CALL s_get_bookno(YEAR(l_nmh04)) RETURNING g_flag,g_bookno1,g_bookno2         #MOD-CB0277 mark
              CALL s_get_bookno(YEAR(g_ooa.ooa02)) RETURNING g_flag,g_bookno1,g_bookno2     #MOD-CB0277 add
              IF g_flag='1' THEN
                 CALL cl_err(l_nmh04,'aoo-081',1)
                 NEXT FIELD oob06_1
              END IF        
 
             IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[39]" THEN                         
                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
                   IF g_oob_d[l_ac2].oob04_1 = '3' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
                      IF (l_oma00!='21') AND (l_oma00!='22') AND (l_oma00!='23') AND
                         (l_oma00!='24') AND (l_oma00!='25') AND (l_oma00!='26') AND
                         (l_oma00!='20') AND   #No.TQC-DA0003  Add
                         (l_oma00!='27') AND (l_oma00!='28') THEN   #MOD-B70242 add 27,28
                         CALL cl_err('','axr-992',0)
                         NEXT FIELD oob06_1
                      END IF 
                     #---add---start---
                      SELECT COUNT(*) INTO l_i FROM omc_file 
                       WHERE omc01=g_oob_d[l_ac2].oob06_1
                      IF l_i=1 THEN
                         LET g_oob_d[l_ac2].oob19_1=1
                         CALL t400_oob06_1_2()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19_1         #MOD-BB0086 mark
                            NEXT FIELD oob06_1         #MOD-BB0086 add
                         ELSE 
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15_1
                            ELSE
                               NEXT FIELD oob11_1
                            END IF
                         END IF
                      END IF 
                   END IF 
                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
                         AND apa02 <= g_ooa.ooa02        #MOD-A30146 add
                      IF (l_apa00!='11') AND (l_apa00!='12') AND (l_apa00!='15') AND (l_apa00!='13') THEN   #MOD-A50047 add l_apa00!='13'
                         CALL cl_err('','axr-993',0)
                         NEXT FIELD oob06_1 
                      END IF   
                   END IF 
                END IF                 
             END IF 
             
             IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN
                IF p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1  THEN 
                   IF g_oob_d[l_ac2].oob04_1 = '1' THEN 
                      SELECT oma00 INTO l_oma00 FROM oma_file
                       WHERE oma01 = g_oob_d[l_ac2].oob06_1
                      IF (l_oma00!='11') AND (l_oma00!='12') AND
                         (l_oma00!='13') AND (l_oma00!='14') AND (l_oma00 !='15') AND
                         (l_oma00!='17') AND (l_oma00 != '10') THEN       #MOD-DA0183 add 10
                         CALL cl_err('','axr-994',0)
                         NEXT FIELD oob06_1
                      END IF 
                   END IF 
                   IF g_oob_d[l_ac2].oob04_1 = '9' THEN 
                      SELECT apa00 INTO l_apa00 FROM apa_file
                       WHERE apa01 = g_oob_d[l_ac2].oob06_1
                         AND apa02 <= g_ooa.ooa02        
#No.MOD-B50248 --begin
                      IF l_apa00 NOT MATCHES '2*' THEN 
#                      IF (l_apa00!='21') AND (l_apa00!='22') AND
#                         (l_apa00!='23') AND (l_apa00!='24') AND (l_apa00!='25') THEN  #MOD-B20108 add 25
#No.MOD-B50248 --end
                         CALL cl_err('','axr-995',0)
                         NEXT FIELD oob06_1 
                      END IF   
                   END IF                    
                   IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN   #MOD-A10084 add
                      CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)  
                      IF NOT cl_null(g_errno) THEN 
                         CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                        #NEXT FIELD oob19_1         #MOD-BB0086 mark
                         NEXT FIELD oob06_1         #MOD-BB0086 add 
                      END IF 
                   END IF   
                   IF g_oob_d[l_ac2].oob04_1='1' THEN 
                      SELECT COUNT(*) INTO l_i FROM omc_file 
                       WHERE omc01=g_oob_d[l_ac2].oob06_1
                      IF l_i=1 THEN
                         LET g_oob_d[l_ac2].oob19_1=1
                         CALL t400_oob06_1_2()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19_1         #MOD-BB0086 mark
                            NEXT FIELD oob06_1         #MOD-BB0086 add
                         ELSE 
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15_1
                            ELSE
                               NEXT FIELD oob11_1
                            END IF
                         END IF
                      END IF 
                   END IF
                   IF g_oob_d[l_ac2].oob04_1='9' THEN 
                      SELECT COUNT(*) INTO l_i FROM apc_file
                       WHERE apc01=g_oob_d[l_ac2].oob06_1
                      IF l_i=1 THEN
                         LET g_oob_d[l_ac2].oob19_1=1
                         CALL t400_oob06_1_2()
                         IF g_errno = 'N' THEN
                           #NEXT FIELD oob19_1         #MOD-BB0086 mark
                            NEXT FIELD oob06_1         #MOD-BB0086 add
                         ELSE 
                            IF g_ooz.ooz62 = 'Y' THEN
                               NEXT FIELD oob15_1
                            ELSE
                               NEXT FIELD oob11_1
                            END IF
                         END IF
                      END IF 
                   END IF                   
                END IF 
              END IF
           END IF
 
 
        BEFORE FIELD oob19_1
           CALL t400_set_no_entry_b1_2()
           CALL t400_set_entry_b1_2()
#No.MOD-C30743  --Mark Begin
           #No.MOD-BA0089  --Begin
#           IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
#                 g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN
#           #No.MOD-BA0089  --End
##MOD-B80099 -- begin --
#              SELECT COUNT(*) INTO l_i FROM omc_file
#                 WHERE omc01=g_oob_d[l_ac2].oob06_1
#              IF l_i=1 THEN
#                 LET g_oob_d[l_ac2].oob19_1 = 1
#                 CALL t400_oob06_1_2()
#                 IF g_errno = 'N' THEN
#                    NEXT FIELD oob19_1
#                 ELSE
#                    IF g_ooz.ooz62 = 'Y' THEN
#                       NEXT FIELD oob15_1
#                    ELSE
#                       NEXT FIELD oob11_1
#                    END IF
#                 END IF
#              END IF
##MOD-B80099 -- end --
#          END IF    #MOD-BA0089
#No.MOD-C30743  --Mark End
 
        AFTER FIELD oob19_1
           #No.MOD-C30743  --Begin
           #IF cl_null(g_oob_d[l_ac2].oob19_1) AND
           #   NOT (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='4') THEN
           #   CALL cl_err("","axr-411",1)
           #   NEXT FIELD oob06_1
           #END IF
           IF cl_null(g_oob_d[l_ac2].oob19_1) THEN
                  IF NOT (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='4') THEN
                     CALL cl_err("","axr-411",1)
                     NEXT FIELD oob06_1
                  END IF
                  IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR
                 g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1) THEN
                  SELECT COUNT(*) INTO l_i FROM omc_file
                  WHERE omc01=g_oob_d[l_ac2].oob06_1
                  IF l_i=1 THEN
                     LET g_oob_d[l_ac2].oob19_1 = 1
                     CALL t400_oob06_1_2()
                     IF g_errno = 'N' THEN
                        NEXT FIELD oob19_1
                     ELSE
                        IF g_ooz.ooz62 = 'Y' THEN
                           NEXT FIELD oob15_1
                        ELSE
                           NEXT FIELD oob11_1
                        END IF
                     END IF
                  END IF
               END IF
           END IF
           #No.MOD-C30743  --End
           IF NOT cl_null(g_oob_d[l_ac2].oob19_1) THEN
             #若為待扺，或為貸方
              IF (p_cmd= 'a' OR g_oob_d_t.oob06_1 != g_oob_d[l_ac2].oob06_1 OR       #MOD-BA0195 add p_cmd='a'
                  g_oob_d_t.oob04_1 != g_oob_d[l_ac2].oob04_1 OR 
                  g_oob_d_t.oob19_1 != g_oob_d[l_ac2].oob19_1 ) THEN  
                 CALL t400_oob06_1_2()
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob19_1
                 END IF
                 CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)
                 IF NOT cl_null(g_errno) THEN 
                    CALL cl_err(g_oob_d[l_ac2].oob19_1,g_errno,0)
                    NEXT FIELD oob19_1
                 END IF 
              END IF
           END IF
           
        
        BEFORE FIELD oob15_1
           CALL t400_set_no_entry_b1_2() 
           CALL t400_set_entry_b1_2()
 
 
        AFTER FIELD oob15_1
           IF g_ooz.ooz62 = 'Y' THEN  
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
           END IF
 
            IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[19]" THEN  
               IF NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN 
                  CALL t400_oob06_1_chk_2(g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob15_1,g_oob_d[l_ac2].oob19_1,l_ac2)  #MOD-A10084 add oob19_1
                  IF NOT cl_null(g_errno) THEN 
                     CALL cl_err(g_oob_d[l_ac2].oob06_1,g_errno,0)
                     NEXT FIELD oob06_1
                  END IF 
               END IF 
            END IF   
           IF g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '2' THEN
              IF cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 NEXT FIELD oob15_1
              END IF
              LET l_cnt = 0
              SELECT COUNT(*) INTO l_cnt FROM oob_file
                WHERE oob06_1 = g_oob_d[l_ac2].oob06_1 AND
                      oob15_1 = g_oob_d[l_ac2].oob15_1 AND
                      oob01 = g_ooa.ooa01
              IF p_cmd = 'a' THEN
                 IF l_cnt > 0 THEN
                    NEXT FIELD oob15_1
                 END IF
              ELSE
                 IF l_cnt > 1 THEN
                    NEXT FIELD oob15_1
                 END IF
              END IF
              IF g_oob_d_t.oob15_1 <> g_oob_d[l_ac2].oob15_1 OR
                 g_oob_d_t.oob15_1 IS NULL THEN
                 CALL t400_oob06_1_12_2()
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1,
                                 g_oob_d[l_ac2].oob09_1,g_oob_d[l_ac2].oob10_1,
                                 g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob12_1,
                                 g_oob_d[l_ac2].oob13_1,g_oob_d[l_ac2].oob14_1  
   
                 IF g_errno = 'N' THEN
                    NEXT FIELD oob06_1
                 END IF
              END IF
          ELSE
              IF g_ooz.ooz62 = 'Y' AND p_cmd = 'a' AND
                 NOT cl_null(g_oob_d[l_ac2].oob15_1) THEN
                 CALL t400_oob06_1_item_2()
              END IF
          END IF 
 
        BEFORE FIELD oob07_1
           IF cl_null(g_oob_d[l_ac2].oob07_1) AND NOT cl_null(g_ooa.ooa23) THEN
              LET g_oob_d[l_ac2].oob07_1=g_ooa.ooa23
           END IF
           # 971021 TT/NR/CN/AR 不允許修改幣別
           IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1239]") OR
              (g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[1]") THEN
           END IF
 
        AFTER FIELD oob07_1
           IF g_oob_d[l_ac2].oob07_1 IS NULL THEN NEXT FIELD oob07_1 END IF  
## No.2693 modify 1998/10/31 至少需判斷幣別為正確值
           IF NOT cl_null(g_oob_d[l_ac2].oob07_1) THEN
              CALL t400_oob07_1_2('a')
              IF NOT cl_null(g_errno) THEN
                 CALL cl_err(g_oob_d[l_ac2].oob07_1,g_errno,0)
                 LET g_oob_d[l_ac2].oob07_1 = g_oob_d_t.oob07_1
                 DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
                 NEXT FIELD oob07_1
              END IF
            END IF
 
        BEFORE FIELD oob08_1
           CALL cl_set_comp_entry("oob08_1",TRUE)
           CALL t400_set_no_entry_b_2()
           LET oob08_t=g_oob_d[l_ac2].oob08_1   #No.+010
           # 971021 TT/NR/CN/AR 不允許修改匯率
#No.FUN-AA0088 --begin
           IF g_oob_d_t.oob07_1 IS NULL OR g_oob_d_t.oob07_1 <> g_oob_d[l_ac2].oob07_1 THEN 
#           IF g_oob_d[l_ac2].oob08_1 = 0 OR g_oob_d[l_ac2].oob08_1 = 1 OR
#              cl_null(g_oob_d[l_ac2].oob08_1) THEN
#No.FUN-AA0088 --end
              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob_d[l_ac2].oob08_1
              DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
           END IF
           LET oob08_t=g_oob_d[l_ac2].oob08_1
 
        AFTER FIELD oob08_1
           CALL cl_set_comp_entry("oob08_1",TRUE)
           IF (oob08_t!=g_oob_d[l_ac2].oob08_1) THEN
              LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
              CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)
                   RETURNING g_oob_d[l_ac2].oob10_1
           END IF
 
        BEFORE FIELD oob09_1
           LET oob09_t=g_oob_d[l_ac2].oob09_1
#No.FUN-AA0088 --begin
           IF (p_cmd ='a' OR g_oob_d[l_ac2].oob08_1 <> g_oob_d_t.oob08_1 OR g_oob_d[l_ac2].oob07_1 <> g_oob_d_t.oob07_1) AND g_prog ='axrt401'  THEN   #No.MOD-B60078
              SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file WHERE  oob01 = g_ooa.ooa01 AND oob03 ='2' AND oob07 = g_oob_d[l_ac2].oob07_1 AND oob08 = g_oob_d[l_ac2].oob08_1
              IF cl_null(l_oob09) THEN LET l_oob09 =0 END IF 
              IF cl_null(l_oob10) THEN LET l_oob10 =0 END IF
              SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM oob_file WHERE  oob01 = g_ooa.ooa01 AND oob03 ='1' AND oob07 = g_oob_d[l_ac2].oob07_1 AND oob08 = g_oob_d[l_ac2].oob08_1
              IF cl_null(l_oob09_1) THEN LET l_oob09_1 =0 END IF 
              IF cl_null(l_oob10_1) THEN LET l_oob10_1 =0 END IF
              #LET g_oob_d[l_ac2].oob09_1  = l_oob09 - l_oob09_1 #FUN-C20018 mark--
              #LET g_oob_d[l_ac2].oob10_1  = l_oob10 - l_oob10_1 #FUN-C20018 mark--
              #FUN-C20018--add--begin
              #IF g_ooa.ooa40='1' THEN #FUN-C20063 mark--
              IF g_ooa.ooa40='01' THEN #FUN-C20063
                 LET g_oob_d[l_ac2].oob09_1  = l_oob09 - l_oob09_1
                 LET g_oob_d[l_ac2].oob10_1  = l_oob10 - l_oob10_1
              ELSE
                 LET g_oob_d[l_ac2].oob09_1  = l_oob09_1 - l_oob09
                 LET g_oob_d[l_ac2].oob10_1  = l_oob10_1 - l_oob10
              END IF
              #FUN-C20018--add--end
           END IF 
#No.FUN-AA0088 --end
 
        AFTER FIELD oob09_1

## No.2694 modify 1998/10/31 判斷金額是否沖過頭
           IF NOT cl_null(g_oob_d[l_ac2].oob09_1) THEN
              IF g_oob_d_t.oob09_1 != g_oob_d[l_ac2].oob09_1 OR
                 g_oob_d_t.oob09_1 IS NOT NULL THEN
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
                    IF NOT t400_oob09_1_11_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
                    IF NOT t400_oob09_1_12_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                    IF NOT t400_oob09_1_13_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t400_oob09_1_19_2('1',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob09_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t400_oob09_1_19_2('1',p_cmd,'2') THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
#No.FUN-AA0088 --begin
                 IF g_prog = 'axrt401' THEN 
                    #IF g_oob_d[l_ac2].oob09_1  > l_oob09 - l_oob09_1 THEN #FUN-C20018 mark--
                    #FUN-C20018--add--begin
                    #IF (g_ooa.ooa40='1' AND g_oob_d[l_ac2].oob09_1  > (l_oob09 - l_oob09_1))         #FUN-C20063 mark--
                    #  OR (g_ooa.ooa40='2' AND g_oob_d[l_ac2].oob09_1  > (l_oob09_1 - l_oob09)) THEN  #FUN-C20063 mark--
                    IF (g_ooa.ooa40='01' AND g_oob_d[l_ac2].oob09_1  > (l_oob09 - l_oob09_1))         #FUN-C20063
                       OR (g_ooa.ooa40='02' AND g_oob_d[l_ac2].oob09_1  > (l_oob09_1 - l_oob09)) THEN #FUN-C20063
                    #FUN-C20018--add--end   
                       CALL cl_err('','axr-323',1)
                       LET g_oob_d[l_ac2].oob09_1 =0
                       NEXT FIELD oob09_1
                    END IF 
                 END IF 
#No.FUN-AA0088 --end
              END IF
              IF (oob08_t!=g_oob_d[l_ac2].oob08_1) OR (oob09_t!=g_oob_d[l_ac2].oob09_1) OR oob09_t IS NULL THEN #MOD-740395
                  SELECT azi04 INTO t_azi04 FROM azi_file  #MOD-560077  #No.CHI-6A0004
                  WHERE azi01 = g_oob_d[l_ac2].oob07_1
                  CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04) #BUG-530346 MOD-560077   #No.CHI-6A0004
                 RETURNING g_oob_d[l_ac2].oob09_1
                 LET g_oob_d[l_ac2].oob10_1 = g_oob_d[l_ac2].oob08_1 * g_oob_d[l_ac2].oob09_1
                  CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04) #BUG-530346 MOD-560077  #No.CHI-6A0004
                 RETURNING g_oob_d[l_ac2].oob10_1
              END IF
              IF g_oob_d[l_ac2].oob09_1 <= 0 THEN
                 IF g_oob_d[l_ac2].oob04_1 <> '7' THEN
                    NEXT FIELD oob09_1
                 END IF
              END IF
              #add by danny 020311 期末調匯(A008)
              IF g_ooz.ooz07 = 'Y' AND g_oob_d[l_ac2].oob07_1 != g_aza.aza17 THEN
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') OR
                    (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') THEN
                    IF NOT t400_oob09_1_13_2('1',p_cmd) THEN
                       NEXT FIELD oob09_1
                    END IF
                 END IF
              END IF
           END IF
 
        BEFORE FIELD oob10_1
           LET oob10_t=g_oob_d[l_ac2].oob10_1
 
        AFTER FIELD oob10_1
           IF NOT cl_null(g_oob_d[l_ac2].oob10_1) THEN
              IF g_oob_d_t.oob10_1 != g_oob_d[l_ac2].oob10_1 OR g_oob_d_t.oob10_1 IS NOT NULL THEN
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1') THEN
                    SELECT nmh32 INTO l_nmh32 FROM nmh_file
                     WHERE nmh01 = g_oob_d[l_ac2].oob06_1
                       AND nmh38 <> 'X'
                       AND nmh24 != '6' AND nmh24 != '7'         
                    IF cl_null(l_nmh32) THEN
                       LET l_nmh32 = 0
                    END IF
                    IF g_oob_d[l_ac2].oob10_1 > l_nmh32 THEN
                       NEXT FIELD oob10_1
                    END IF
                    IF NOT t400_oob09_1_11_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2') THEN
                    IF NOT t400_oob09_1_12_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '3') OR
                    (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '1') THEN
                    IF NOT t400_oob09_1_13_2('2',p_cmd) THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '1' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t400_oob09_1_19_2('2',p_cmd,'1') THEN   #MOD-750063
                       NEXT FIELD oob10_1
                    END IF
                 END IF
                 IF (g_oob_d[l_ac2].oob03_d = '2' AND g_oob_d[l_ac2].oob04_1 = '9') THEN
                    IF NOT t400_oob09_1_19_2('2',p_cmd,'2') THEN
                       NEXT FIELD oob10_1
                    END IF
                 END IF
#No.FUN-AA0088 --begin
                 IF g_prog = 'axrt401' THEN 
                    #IF g_oob_d[l_ac2].oob10_1  > l_oob10 - l_oob10_1 THEN  #FUN-C20018 mark--
                    #FUN-C20018--add--begin
                    #IF (g_ooa.ooa40='1' AND g_oob_d[l_ac2].oob10_1  > (l_oob10 - l_oob10_1))         #FUN-C20063 mark--
                    #   OR (g_ooa.ooa40='2' AND g_oob_d[l_ac2].oob10_1  > (l_oob10_1 - l_oob10)) THEN #FUN-C20063 mark--
                    IF (g_ooa.ooa40='01' AND g_oob_d[l_ac2].oob10_1  > (l_oob10 - l_oob10_1))         #FUN-C20063
                       OR (g_ooa.ooa40='02' AND g_oob_d[l_ac2].oob10_1  > (l_oob10_1 - l_oob10)) THEN #FUN-C20063
                    #FUN-C20018--add--end
                       CALL cl_err('','axr-323',1)
                       LET g_oob_d[l_ac2].oob10_1 =0
                       NEXT FIELD oob10_1
                    END IF 
                 END IF 
#No.FUN-AA0088 --end
              END IF
              IF oob10_t <> g_oob_d[l_ac2].oob10_1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
                 IF cl_confirm('axr-320') THEN
                    SELECT azi04 INTO t_azi04 FROM azi_file 
                     WHERE azi01 = g_oob_d[l_ac2].oob07_1
                    CALL cl_digcut(g_oob_d[l_ac2].oob10_1,g_azi04)  
                         RETURNING g_oob_d[l_ac2].oob10_1
                    LET g_oob_d[l_ac2].oob09_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob08_1
                    CALL cl_digcut(g_oob_d[l_ac2].oob09_1,t_azi04)  
                         RETURNING g_oob_d[l_ac2].oob09_1
                 ELSE
                   #LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1 #MOD-B40253 mark
                   #-MOD-B40253-add-
                    IF g_oob_d[l_ac2].oob03_d ='2' AND g_oob_d[l_ac2].oob04_1 MATCHES "[247]" THEN  
                       LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1 
                    END IF
                   #-MOD-B40253-end-
                 END IF
              END IF
              IF g_oob_d[l_ac2].oob08_1 = 1 AND g_oob_d[l_ac2].oob07_1 <> g_aza.aza17 THEN
                 LET g_oob_d[l_ac2].oob08_1 = g_oob_d[l_ac2].oob10_1 / g_oob_d[l_ac2].oob09_1
             #MOD-C40139---str---
             #IF g_oob_d[l_ac2].oob08_1 = 1 THEN                                    #MOD-C90154 mark
              IF g_oob_d[l_ac2].oob08_1 = 1 AND g_oob_d[l_ac2].oob04_1 <> '7' THEN  #MOD-C90154
                 IF g_oob_d[l_ac2].oob09_1 <> g_oob_d[l_ac2].oob10_1 THEN
                    CALL cl_err('','agl-926',0)
                    NEXT FIELD oob10_1
                 END IF
              END IF
             #MOD-C40139---end---
              END IF
              IF g_oob_d[l_ac2].oob10_1 <= 0 THEN
                 NEXT FIELD oob10_1
              END IF
           END IF
 
        AFTER FIELD oob11_1
          IF g_oob_d[l_ac2].oob11_1 IS NULL THEN NEXT FIELD oob11_1 END IF   
          LET l_aag05=''   
          IF NOT cl_null(g_oob_d[l_ac2].oob11_1) AND g_ooz.ooz29 ='N' THEN  #No.FUN-AA0088 add ooz29
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob11_1   
                                                                   AND aag00=g_bookno1
 
             IF STATUS THEN
                #No.FUN-AA0088 yinhy --Begin
                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob11_1,"",STATUS,"","select aag",0)  
                IF g_ooz.ooz29 ='N' THEN 
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ='q_aag'
                   LET g_qryparam.construct = 'N'
                   LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
                   LET g_qryparam.arg1 = g_bookno1     
                   LET g_qryparam.where = "  aag01 LIKE '",g_oob_d[l_ac2].oob11_1 CLIPPED,"%'"                
                   CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
                END IF 
                DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                #No.FUN-AA0088 yinhy --End
                NEXT FIELD oob11_1
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob_d[l_ac2].oob11_1,'agl-015',0) NEXT FIELD oob11_1
             END IF
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob11_1
                END IF
             ELSE                                  
                LET g_oob_d[l_ac2].oob13_1=''          
                DISPLAY BY NAME g_oob_d[l_ac2].oob13_1  
             END IF
             CALL t400_set_no_entry_b1_2()   
             CALL t400_set_entry_b1_2()     
          END IF
#No.FUN-AA0088 --begin
          IF NOT cl_null(g_oob_d[l_ac2].oob11_1) AND g_ooz.ooz29 ='Y' AND g_prog = 'axrt401' THEN
            IF g_oob_d_t.oob11_1 != g_oob_d[l_ac2].oob11_1 OR g_oob_d_t.oob11_1 IS NOT NULL THEN
               SELECT COUNT(*) INTO l_n FROM ool_file WHERE ool01 = g_oob_d[l_ac2].oob11_1
               IF l_n =0 THEN
                  CALL cl_err(g_oob_d[l_ac2].oob11_1,"axr-668",1)
                  LET g_oob_d[l_ac2].oob11_1 = g_oob_d_t.oob11_1
                  NEXT FIELD oob11_1 
               END IF 
            END IF     
          END IF 
#No.FUN-AA0088 --end
 
        AFTER FIELD oob111_1
          IF g_oob_d[l_ac2].oob111_1 IS NULL THEN NEXT FIELD oob111_1 END IF   
          IF NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
             SELECT aag02,aag07,aag05 INTO g_buf,l_aag07,l_aag05 FROM aag_file WHERE aag01=g_oob_d[l_ac2].oob111_1   
                                                                   AND aag00=g_bookno2
                                                                   AND aag07 IN ('2','3')  #No.FUN-AA0088 yinhy
                                                                   AND aag03 = '2'         #No.FUN-AA0088 yinhy
             IF STATUS THEN
                #No.FUN-AA0088 yinhy --Begin
                #CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",1)  
                CALL cl_err3("sel","aag_file",g_oob_d[l_ac2].oob111_1,"",STATUS,"","select aag",0)  
                CALL cl_init_qry_var()
                LET g_qryparam.form ='q_aag'
                LET g_qryparam.construct = 'N'
                LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
                LET g_qryparam.arg1 = g_bookno2    
                LET g_qryparam.where = " aag07 IN ('2','3') AND aag03 = '2' AND aagacti = 'Y' AND aag01 LIKE '",g_oob_d[l_ac2].oob111_1 CLIPPED,"%'"                  
                CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
                DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                #No.FUN-AA0088 yinhy --End
                NEXT FIELD oob111_1
             END IF
             IF l_aag07='1' THEN #統制帳戶
                CALL cl_err(g_oob_d[l_ac2].oob111_1,'agl-015',0) NEXT FIELD oob111_1
             END IF
 
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET g_errno = ' '   
             IF l_aag05 = 'Y' THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN
                   IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN 
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)  
                                    RETURNING g_errno
                   END IF
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob111_1
                END IF
             END IF
          END IF
 
          BEFORE FIELD oob13_1
            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
             WHERE aag01=g_oob_d[l_ac2].oob11_1
               AND aag00=g_bookno1          
            IF l_aag05='N' THEN
               LET g_oob_d[l_ac2].oob13_1=''
               DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
            END IF
            CALL t400_set_no_entry_b1_2()  
            CALL t400_set_entry_b1_2()      
 
        AFTER FIELD oob13_1
          IF NOT cl_null(g_oob_d[l_ac2].oob13_1) THEN
             SELECT gem02 INTO g_buf FROM gem_file WHERE gem01=g_oob_d[l_ac2].oob13_1
                AND gemacti='Y'   #NO:6950
             IF STATUS THEN
                CALL cl_err3("sel","gem_file",g_oob_d[l_ac2].oob13_1,"",STATUS,"","select gem",1)  
                NEXT FIELD oob13_1
             END IF
            #防止User只修改部門欄位時,未再次檢查會科與允許/拒絕部門關係
             LET l_aag05=''   
             SELECT aag05 INTO l_aag05 FROM aag_file
              WHERE aag01 = g_oob_d[l_ac2].oob11_1
                AND aag00 = g_bookno1      
            
             LET g_errno = ' '   
             IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob11_1) THEN
               #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                IF g_aaz.aaz90 !='Y' THEN    
                   CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob13_1,g_bookno1)
                                 RETURNING g_errno
                END IF
                IF NOT cl_null(g_errno) THEN
                   CALL cl_err('',g_errno,0)
                   NEXT FIELD oob13_1
                END IF
             END IF
            
             IF g_aza.aza63='Y' THEN 
                LET l_aag05=''   
                SELECT aag05 INTO l_aag05 FROM aag_file
                 WHERE aag01 = g_oob_d[l_ac2].oob111_1
                   AND aag00 = g_bookno2      
                
                LET g_errno = ' '   
                IF l_aag05 = 'Y' AND NOT cl_null(g_oob_d[l_ac2].oob111_1) THEN
                  #當使用利潤中心時(aaz90=Y),允許/拒絕部門的判斷請改用會科+成本中心
                   IF g_aaz.aaz90 !='Y' THEN  
                      CALL s_chkdept(g_aaz.aaz72,g_oob_d[l_ac2].oob111_1,g_oob_d[l_ac2].oob13_1,g_bookno2)
                                    RETURNING g_errno
                   END IF
                   IF NOT cl_null(g_errno) THEN
                      CALL cl_err('',g_errno,0)
                      NEXT FIELD oob13_1
                   END IF
                END IF
             END IF  
          END IF
            LET l_aag05=''
            SELECT aag05 INTO l_aag05 FROM aag_file
               WHERE aag01=g_oob_d[l_ac2].oob11_1  
                 AND aag00=g_bookno1        
            IF l_aag05='Y' AND cl_null(g_oob_d[l_ac2].oob13_1) THEN
               CALL cl_err('','aap-099',0)
               NEXT FIELD oob13_1
            END IF
#No.FUN-AA0088 --begin
        AFTER FIELD oob24_1
           IF NOT cl_null(g_oob_d[l_ac2].oob24_1) THEN 
              #SELECT occ02 INTO g_oob_d[l_ac2].occ02 FROM occ_file WHERE occ01 =g_oob_d[l_ac2].oob24_1   #MOD-D10071 mark
              #MOD-D10071
              SELECT occ02,occ42 INTO g_oob_d[l_ac2].occ02,g_oob_d[l_ac2].oob07_1 FROM occ_file   
                 WHERE occ01 =g_oob_d[l_ac2].oob24_1
              CALL s_curr3(g_oob_d[l_ac2].oob07_1,g_ooa.ooa02,g_ooz.ooz17)
                   RETURNING g_oob_d[l_ac2].oob08_1
              #MOD-D10071
              IF SQLCA.sqlcode =100 THEN 
                 CALL cl_err(g_oob_d[l_ac2].oob24_1,SQLCA.sqlcode,0)
                 LET g_oob_d[l_ac2].oob24_1 = NULL 
                 NEXT FIELD oob24_1
              END IF 
           END IF 
        AFTER FIELD oob26_1
           IF NOT cl_null(g_oob_d[l_ac2].oob26_1) THEN 
              SELECT ooc02 INTO g_oob_d[l_ac2].ooc02 FROM ooc_file WHERE ooc01 = g_oob_d[l_ac2].oob26_1 
              SELECT ooc03 INTO g_oob_d[l_ac2].oob11_1 FROM ooc_file WHERE ooc01 = g_oob_d[l_ac2].oob26_1   #CHI-D10049
              IF SQLCA.sqlcode =100 THEN 
                 CALL cl_err(g_oob_d[l_ac2].oob26_1,SQLCA.sqlcode,0)
                 LET g_oob_d[l_ac2].oob26_1 = NULL 
                 NEXT FIELD oob26_1
              END IF 
              LET g_oob_d[l_ac2].oob04_1 =g_oob_d[l_ac2].oob26_1
           END IF 
#No.FUN-AA0088 --end

        AFTER FIELD oobud01_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud02_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud03_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud04_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud05_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud06_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud07_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud08_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud09_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud10_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud11_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud12_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud13_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud14_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        AFTER FIELD oobud15_1
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
 
        BEFORE DELETE                            #是否取消單身
            DISPLAY "g_oob_d_t.oob02_1=",g_oob_d_t.oob02_1
            IF g_oob_d_t.oob02_1 > 0 AND g_oob_d_t.oob02_1 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                   LET g_success = 'N'   #MOD-730060
                   CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN
                   CALL cl_err("", -263, 1)
                   LET g_success = 'N'   #MOD-730060
                   CANCEL DELETE
                END IF
                # genero shell add end
                DELETE FROM oob_file
                 WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
                IF SQLCA.sqlcode THEN
                    CALL cl_err3("del","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","",1) 
                    LET g_success = 'N'   
                    CANCEL DELETE
                END IF
                CALL t400_mlog('R')
                IF g_success = 'Y' THEN
                   IF g_ooa.ooa34 NOT matches '[Ss]' THEN  
                      LET l_ooa34 = '0'
                   END IF                                   
                   LET g_rec_b2=g_rec_b2-1
                   DISPLAY g_rec_b2 TO FORMONLY.cn3
                   IF cl_null(g_oob_d_t.oob02_1) THEN
                      LET g_rec_b2=g_rec_b2-1
                   END IF
                   COMMIT WORK
                ELSE
                   ROLLBACK WORK
                END IF
            END IF   
            CALL t400_bu()
 
        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_oob_d[l_ac2].* = g_oob_d_t.*
               CLOSE t400_bcl1
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_oob_d[l_ac2].oob02_1,-263,1)
               LET g_oob_d[l_ac2].* = g_oob_d_t.*
               LET g_success='N'  
            ELSE
               CALL t400_b_move_back_2()
               SELECT COUNT(*) INTO l_n FROM oob_file
                WHERE oob01=g_ooa.ooa01  AND oob02=g_oob_d[l_ac2].oob02_1
               IF l_n = 0 THEN                                  
                  IF g_oob_d[l_ac2].oob09_1 = 0 AND g_oob_d[l_ac2].oob10_1 = 0 THEN
                     INITIALIZE g_oob_d[l_ac2].* TO NULL  #重要欄位空白,無效
                     LET g_success='N'   
                  END IF
               END IF
               UPDATE oob_file SET * = b_oob.*
                  WHERE oob01=g_ooa.ooa01 AND oob02=g_oob_d_t.oob02_1
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","oob_file",g_ooa.ooa01,g_oob_d_t.oob02_1,SQLCA.sqlcode,"","upd oob",1)  #No.FUN-660116
                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
                  LET g_success='N'   
               ELSE 
                  UPDATE ooa_file SET ooamodu = g_user,ooadate = g_today 
                   WHERE ooa01 = g_ooa.ooa01 
                  IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
                     CALL cl_err3("upd","ooa_file",g_ooa.ooa01,"",SQLCA.sqlcode,"","upd ooa",1)  
                     LET g_oob_d[l_ac2].* = g_oob_d_t.*
                     LET g_success='N'   
                  END IF
                  DISPLAY g_user TO ooamodu
                  DISPLAY g_today TO ooadate
                END IF
            END IF
            CALL t400_mlog('U')
            CALL t400_bu()
            IF g_success = 'Y' THEN
               MESSAGE 'UPDAET O.K'
               IF g_ooa.ooa34 NOT matches '[Ss]' THEN   
                  LET l_ooa34 = '0'
               END IF                                  
               COMMIT WORK
               LET g_change = 'Y'    #MOD-B60022
            ELSE
               MESSAGE 'UPDATE ERR'
               ROLLBACK WORK
            END IF
 
        AFTER ROW
            LET l_ac2 = ARR_CURR()
#           LET l_ac2_t = l_ac2
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_oob_d[l_ac2].* = g_oob_d_t.*
               #FUN-D30032--add--str--
               ELSE
                  CALL g_oob_d.deleteElement(l_ac2)
                  IF g_rec_b2 != 0 THEN
                     LET g_action_choice = "detail_b2"
                     LET l_ac2 = l_ac2_t
                  END IF
               #FUN-D30032--add--end--
               END IF
               CLOSE t400_bcl1
               ROLLBACK WORK
               EXIT INPUT              
            END IF
            LET l_ac2_t = l_ac2  #FUN-D30032
            CLOSE t400_bcl1
            COMMIT WORK
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(oob02_1) AND l_ac2 > 1 THEN
                LET g_oob_d[l_ac2].* = g_oob_d[l_ac2-1].*
                LET g_oob_d[l_ac2].oob02_1 = NULL
                NEXT FIELD oob02_1
            END IF
        ON ACTION controls                             
         CALL cl_set_head_visible("","AUTO")          
 
        ON ACTION CONTROLP
            CASE

                WHEN INFIELD(oob04_1)
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_ooc"
                     LET g_qryparam.default1 = g_oob_d[l_ac2].oob04_1
                     IF g_aza.aza63 = 'N' THEN     
                        LET g_qryparam.where = " aag_file.aag00 = '",g_bookno1,"'"  
                     END IF         
                     CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob04_1
                     DISPLAY BY NAME g_oob_d[l_ac2].oob04_1        
                     NEXT FIELD oob04_1
                 
                 WHEN INFIELD(oob06_1)
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmh5"
                          LET g_qryparam.arg1 = g_ooa.ooa03
                          LET g_qryparam.arg2 = g_doc_len   
                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
                          NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
                          CALL cl_init_qry_var()
                          LET g_qryparam.form = "q_nmg"
                          LET g_qryparam.default1 = g_oob_d[l_ac2].oob06_1
                           LET g_qryparam.arg1 = g_ooa.ooa03   
                          CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob06_1
                          NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                         CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
                                     g_ooa.ooa01,g_ooa.ooa03,'2*',g_ooa.ooa23)      #MOD-D60149 add ooa23              
                              RETURNING b_oob.oob06,b_oob.oob09,       
                                        b_oob.oob10,b_oob.oob19
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                            LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19   
                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='9' THEN
                         CALL q_apa4( FALSE, TRUE, ' ')
                         RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                         IF g_ooz.ooz62='N' THEN
                            CALL q_oma4(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1, 
                                        g_ooa.ooa01,g_ooa.ooa03,'1*',g_ooa.ooa23)    #MOD-D60149 add ooa23              
                                 RETURNING b_oob.oob06,b_oob.oob09,  
                                           b_oob.oob10,b_oob.oob19
                         ELSE
                            CALL q_omb(FALSE,TRUE,g_oob_d[l_ac2].oob06_1,g_oob_d[l_ac2].oob02_1,
                                       g_ooa.ooa01, g_ooa.ooa03,'1%') 
                             RETURNING b_oob.oob06,b_oob.oob15,
                                       b_oob.oob09,b_oob.oob10
                         END IF
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                            LET g_oob_d[l_ac2].oob09_1 = b_oob.oob09
                            LET g_oob_d[l_ac2].oob10_1 = b_oob.oob10
                            IF g_ooz.ooz62='Y' THEN
                               LET g_oob_d[l_ac2].oob15_1 = b_oob.oob15
                            ELSE
                               LET g_oob_d[l_ac2].oob19_1 = b_oob.oob19
                            END IF
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                      IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='9' THEN
                         CALL q_apa5( FALSE, TRUE, ' ')
                              RETURNING b_oob.oob06
                         IF b_oob.oob06 IS NOT NULL THEN
                            LET g_oob_d[l_ac2].oob06_1 = b_oob.oob06
                         END IF
                         NEXT FIELD oob06_1
                      END IF
                       DISPLAY BY NAME g_oob_d[l_ac2].oob06_1     
                       DISPLAY BY NAME g_oob_d[l_ac2].oob09_1     
                       DISPLAY BY NAME g_oob_d[l_ac2].oob10_1     
                       DISPLAY BY NAME g_oob_d[l_ac2].oob15_1     
               WHEN INFIELD(oob11_1)
#No.FUN-AA0088 --begin
                    IF g_ooz.ooz29 ='Y' AND g_prog ='axrt401' THEN 
                       CALL cl_init_qry_var()
                       LET g_qryparam.form ='q_ool01'
                       LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1  
                       CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
                       DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                       NEXT FIELD oob11_1
                    ELSE 
                       CALL cl_init_qry_var()
                       LET g_qryparam.form ='q_aag'
                       LET g_qryparam.default1 =g_oob_d[l_ac2].oob11_1
                       LET g_qryparam.arg1 = g_bookno1     
                       CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob11_1
                       DISPLAY BY NAME g_oob_d[l_ac2].oob11_1
                       NEXT FIELD oob11_1
                    END IF 
#No.FUN-AA0088 --end
               WHEN INFIELD(oob111_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_aag'
                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob111_1
                    LET g_qryparam.arg1 = g_bookno2      
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob111_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob111_1
                    NEXT FIELD oob111_1
               WHEN INFIELD(oob13_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = 'q_gem'
                    LET g_qryparam.default1 = g_oob_d[l_ac2].oob13_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob13_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob13_1
                    NEXT FIELD oob13_1
               WHEN INFIELD(oob07_1)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form ='q_azi'
                    LET g_qryparam.default1 =g_oob_d[l_ac2].oob07_1
                    CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob07_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob07_1
                    NEXT FIELD oob07_1
               WHEN INFIELD(oob08_1)
                    CALL s_rate(g_oob_d[l_ac2].oob07_1,g_oob_d[l_ac2].oob08_1)
                    RETURNING g_oob_d[l_ac2].oob08_1
                    DISPLAY BY NAME g_oob_d[l_ac2].oob08_1
                    NEXT FIELD oob08_1
#No.FUN-AA0088 --begin
               WHEN INFIELD(oob24_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_occ11" 
                  LET g_qryparam.default1 =g_oob_d[l_ac2].oob24_1
                  CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob24_1
                  DISPLAY BY NAME g_oob_d[l_ac2].oob24_1
                  NEXT FIELD oob24_1
               WHEN INFIELD(oob27_1)
                   CALL q_ooy( FALSE, TRUE, g_oob_d[l_ac2].oob27_1,'30','AXR')   #TQC-670008
                   RETURNING g_oob_d[l_ac2].oob27_1
                   DISPLAY BY NAME g_oob_d[l_ac2].oob27_1
                   NEXT FIELD oob27_1
               WHEN INFIELD(oob26_1)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_ooc" 
                  LET g_qryparam.default1 =g_oob_d[l_ac2].oob26_1
                  CALL cl_create_qry() RETURNING g_oob_d[l_ac2].oob26_1
                  DISPLAY BY NAME g_oob_d[l_ac2].oob26_1
                  NEXT FIELD oob26_1
#No.FUN-AA0088 --end
               OTHERWISE EXIT CASE
            END CASE
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
 
        ON ACTION receive_notes
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='1' THEN
                    CALL cl_cmdrun_wait('anmt200')  
                 END IF
        ON ACTION bank_income_expense
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='2' THEN
                    CALL cl_cmdrun_wait('anmt302')  
                 END IF
        ON ACTION maintain_accounts
                 IF g_oob_d[l_ac2].oob03_d='1' AND g_oob_d[l_ac2].oob04_1='3' THEN
                    CALL cl_cmdrun_wait('axrt300')  
                 END IF
                 IF g_oob_d[l_ac2].oob03_d='2' AND g_oob_d[l_ac2].oob04_1='1' THEN
                    CALL cl_cmdrun_wait('axrt300')  
                 END IF
        ON ACTION ar_account_category
                    CALL cl_cmdrun('axri040')
 
        ON ACTION auto_contra
           CALL t400_g_b2()
           EXIT INPUT          
 
        ON ACTION CONTROLF
           CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
           CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE INPUT
 
        ON ACTION about         
           CALL cl_about()      
        
        ON ACTION help          
           CALL cl_show_help()  
  
      END INPUT

      IF g_action_choice = 'detail_b2' THEN RETURN END IF  #FUN-D30032
      IF g_ooa.ooaconf <> 'Y' THEN            #FUN-640246
         UPDATE ooa_file SET ooa34=l_ooa34 WHERE ooa01 = g_ooa.ooa01
         LET g_ooa.ooa34 = l_ooa34
         DISPLAY BY NAME g_ooa.ooa34
      END IF
      IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
      IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
      CALL cl_set_field_pic(g_oma.omaconf,g_chr2,"","",g_oma.omavoid,"")

#FUN-A40076-Mark--Begin 
#      IF (g_ooa.ooa23 IS NULL AND g_ooa.ooa32d != g_ooa.ooa32c) OR
#         (g_ooa.ooa23 IS NOT NULL AND
#         (g_ooa.ooa31d != g_ooa.ooa31c OR g_ooa.ooa32d != g_ooa.ooa32c)) THEN
#FUN-A40076-Mark--End
       #No.TQC-B30221  --Begin
       SELECT COUNT(*) INTO l_count1 FROM ooa_file,oob_file 
        WHERE ooa01 = oob01 
          AND ooa01 = g_ooa.ooa01
          AND oob03 = '1'
       SELECT COUNT(*) INTO l_count2 FROM ooa_file,oob_file 
        WHERE ooa01 = oob01 
          AND ooa01 = g_ooa.ooa01
          AND oob03 = '2'   
       #No.TQC-B30221  --End
       #FUN-A40076-Add--Begin
       IF cl_null(g_ooa.ooa33d) THEN
          LET g_ooa.ooa33d = 0
       END IF
       #FUN-A40076-Add-End 
      #IF l_count1 <> 0 AND l_count2 <> 0 THEN #TQC-B30221 add  #MOD-B90129 mark
       IF l_count1 <> 0 AND l_count2 >= 0 THEN #MOD-B90129 add
          IF g_ooa.ooa32d != g_ooa.ooa32c - g_ooa.ooa33d THEN      #FUN-A40076-Add
             LET p_row = 10 LET p_col = 27
#No.FUN-AA0088 --begin
             IF g_prog ='axrt400' THEN 
                OPEN WINDOW t4001_w AT p_row,p_col WITH FORM "axr/42f/axrt4001"
                  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN 
                CALL cl_ui_locale("axrt4001") 
#No.FUN-AA0088 --end          
 
             INPUT BY NAME diff_flag
              AFTER FIELD diff_flag
#                IF diff_flag NOT MATCHES "[56780E]" THEN NEXT FIELD diff_flag END IF   #FUN-A40076 Mark
                 IF diff_flag NOT MATCHES "[156780E9]" THEN NEXT FIELD diff_flag END IF  #FUN-A40076 Add  FUN-AA0088 add 9
                 IF diff_flag MATCHES '[8]'  AND g_ooa.ooa32d < g_ooa.ooa32c THEN
                    CALL cl_err('','axr-304',0) NEXT FIELD diff_flag
                 END IF
                 IF diff_flag MATCHES "[56]" AND g_ooa.ooa32d > g_ooa.ooa32c THEN
                    CALL cl_err('','axr-302',0) NEXT FIELD diff_flag
                 END IF
                 #FUN-A40076-Add--Begin
                 IF diff_flag MATCHES '[1]' AND g_ooa.ooa32d > g_ooa.ooa32c THEN
                    CALL cl_err('','axr-328',0) NEXT FIELD diff_flag
                 END IF 
                 #FUN-A40076-Add--End          
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
             IF INT_FLAG THEN LET INT_FLAG=0 LET diff_flag='0' END IF
             CLOSE WINDOW t4001_w
             IF diff_flag='0' THEN 
                LET g_flag1 = 'Y'               #MOD-CA0093 add
                CALL t400_b()                                     
                LET g_flag1 = 'N'               #MOD-CA0093 add
               #CALL t400_b2()                  #FUN-A90003 Add MOD-CA0093 mark
             END IF #GENERO 再進單身時
          END IF   #No.FUN-AA0088
       END IF
    CLOSE t400_bcl1
    COMMIT WORK
    IF diff_flag MATCHES "[5678]" THEN
      #-CHI-A30007-add
      #CALL t400_diff()
       CALL t400_diff() RETURNING l_flag
       IF l_flag = 'Y' THEN
          LET diff_flag = '7'
          CALL t400_diff() RETURNING l_flag
       END IF
      #-CHI-A30007-end
       CALL t400_b_fill('1=1')         #FOR GENERO BUG調整
       CALL t400_b_fill_2('1=1') #FUN-A90003 Add
       LET diff_flag='0'               #MOD-A80175 若無此段第二次進入單身會當出
    END IF 
    #FUN-A40076-Add--Begin
    IF diff_flag MATCHES '[1]' THEN
       CALL t400_diff1()
       
#      SELECT ooa33d INTO g_ooa.ooa33d
#        FROM ooa_file
#       WHERE ooa01 = g_ooa.ooa01    
#      #FUN-A40076-Add--Begin
#      IF cl_null(g_ooa.ooa33d) THEN
#         LET g_ooa.ooa33d = 0
#      END IF
#      #FUN-A40076-Add-End 
#      DISPLAY BY NAME g_ooa.ooa33d
#      
#      CALL t400_show_amt()   
#      CALL t400_b_fill('1=1')
    END IF   
    #FUN-A40076-Add--End    
   END IF  #TQC-B30221 add  
# 新增自動確認功能 Modify by Charis 96-09-23
    LET g_t1=s_get_doc_no(g_ooa.ooa01)   #TQC-5A0089
    SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip=g_t1
    IF STATUS THEN
       RETURN
    END IF
    #-----97/05/26 modify 詢問是否產生分錄底稿
#   IF g_ooa.ooa31d>0 AND g_ooa.ooa31d=g_ooa.ooa31c AND g_ooy.ooydmy1='Y' THEN                 #FUN-A40076 Mark
    #FUN-A40076-Add--Begin
    IF cl_null(g_ooa.ooa33d) THEN
       LET g_ooa.ooa33d = 0
    END IF
    #FUN-A40076-Add-End
    IF g_change = 'Y' THEN   #MOD-B60022 
       IF g_ooa.ooa32d>0 AND (g_ooa.ooa32d=g_ooa.ooa32c-g_ooa.ooa33d) AND g_ooy.ooydmy1='Y' THEN  #FUN-A40076 Add
         #IF cl_confirm('axr-309') THEN                                                           #MOD-CA0093 mark
          IF g_flag1 = 'N' THEN                                                                   #MOD-CA0093 add
             CALL t400_v()
          END IF
       END IF
    END IF                   #MOD-B60022
    IF (g_ooa.ooaconf='Y' OR g_ooy.ooyconf='N' OR g_ooy.ooyapr='Y' ) #單據已確認或單據不需自動確認,或需簽核  #FUN-640246 
       THEN RETURN
    ELSE
       LET g_action_choice = "insert"        #FUN-640246
       CALL t400_y_chk()          #CALL 原確認的 check 段
       IF g_success = "Y" THEN
          CALL t400_y_upd()       #CALL 原確認的 update 段
       END IF
    END IF
    IF g_ooy.ooyprit='Y' THEN CALL t400_out() END IF   #單據需立即列印
END FUNCTION    
#No.FUN-AA0088 --begin
FUNCTION t401_oob_def()                #create aph_file
DEFINE l_oob09       LIKE oob_file.oob09
DEFINE l_oob10       LIKE oob_file.oob10
DEFINE l_oob09_1     LIKE oob_file.oob09
DEFINE l_oob10_1     LIKE oob_file.oob10
DEFINE l_oob07       LIKE oob_file.oob07
DEFINE l_oob08       LIKE oob_file.oob08
DEFINE i             LIKE type_file.num5
DEFINE l_oma13       LIKE oma_file.oma13
DEFINE l_oma18       LIKE oma_file.oma18
DEFINE l_oma181      LIKE oma_file.oma181


    IF g_prog <> 'axrt401' THEN RETURN END IF  
    LET g_success ='Y'

    LET l_oma13 = NULL 
    LET l_oma18 = NULL 

    FOR i =1 TO g_oob.getlength()
       SELECT oma13,oma18,oma181 INTO l_oma13,l_oma18,l_oma181 FROM oma_file WHERE oma01 = g_oob[i].oob06
       IF cl_null(l_oma13) OR cl_null(l_oma18) THEN 
          LET l_oma13 = NULL 
          LET l_oma18 = NULL 
       END IF 
       IF NOT cl_null(l_oma13) AND NOT cl_null(l_oma18) THEN
          LET l_oob07 = g_oob[i].oob07
          LET l_oob08 = g_oob[i].oob08
          EXIT FOR 
       END IF 
       LET i = i + 1     
    END FOR    
    
       INITIALIZE g_oob_d[l_ac2].* TO NULL
       #FUN-C20018--add--begin
       #LET g_oob_d[l_ac2].oob03_d  = '1' #FUN-C20018 mark--
       #IF g_ooa.ooa40='1' THEN #FUN-C20063 mark--
       IF g_ooa.ooa40='01' THEN #FUN-C20063
          LET g_oob_d[l_ac2].oob03_d  = '1'
       ELSE
           LET g_oob_d[l_ac2].oob03_d  = '2'
       END IF
       #FUN-C20018--add--end
       LET g_oob_d[l_ac2].oob04_1  = g_ooz.ooz27
       LET g_oob_d[l_ac2].oob26_1  = g_ooz.ooz27
       SELECT ooc02 INTO g_oob_d[l_ac2].ooc02 FROM ooc_file WHERE ooc01 = g_oob_d[l_ac2].oob26_1 
       IF g_ooz.ooz29 ='Y' THEN  
           LET  g_oob_d[l_ac2].oob11_1 = g_ooz.ooz28
 
       ELSE 
          SELECT ooc03,ooc04 INTO g_oob_d[l_ac2].oob11_1,g_oob_d[l_ac2].oob111_1
            FROM ooc_file WHERE ooc01 = g_ooz.ooz27
          IF cl_null(g_oob_d[l_ac2].oob11_1) THEN 
             LET g_oob_d[l_ac2].oob11_1  = l_oma18
             LET g_oob_d[l_ac2].oob111_1 = l_oma181
          END IF 
       END IF
       #FUN-C20018--add--begin
       #LET g_oob_d[l_ac2].oob27_1  = g_ooz.ooz26 #FUN-C20018 mark--
       #IF g_ooa.ooa40 = '1' THEN #FUN-C20063 mark--
       IF g_ooa.ooa40='01' THEN #FUN-C20063
          LET g_oob_d[l_ac2].oob27_1  = g_ooz.ooz26
       ELSE
          LET g_oob_d[l_ac2].oob27_1  = g_ooz.ooz30
       END IF
       #FUN-C20018--add--end
       #LET g_oob_d[l_ac2].oob25_1  = g_today      #MOD-CC0054 mark
       LET g_oob_d[l_ac2].oob25_1  = g_ooa.ooa02   #MOD-CC0054
       LET g_oob_d[l_ac2].oob07_1  = l_oob07
       LET g_oob_d[l_ac2].oob08_1  = l_oob08
       SELECT SUM(oob09),SUM(oob10) INTO l_oob09,l_oob10 FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03 ='2' AND oob07 = l_oob07 AND oob08 = l_oob08
       IF cl_null(l_oob09) THEN LET l_oob09 =0 END IF 
       IF cl_null(l_oob10) THEN LET l_oob10 =0 END IF
       SELECT SUM(oob09),SUM(oob10) INTO l_oob09_1,l_oob10_1 FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03 ='1' AND oob07 = l_oob07 AND oob08 = l_oob08
       IF cl_null(l_oob09_1) THEN LET l_oob09_1 =0 END IF 
       IF cl_null(l_oob10_1) THEN LET l_oob10_1 =0 END IF
       #LET g_oob_d[l_ac2].oob09_1  = l_oob09 - l_oob09_1 #FUN-C20018 mark--
       #LET g_oob_d[l_ac2].oob10_1  = l_oob10 - l_oob10_1 #FUN-C20018 mark--
       #FUN-C20018--add--begin
       #IF g_ooa.ooa40='1' THEN #FUN-C20063 mark--
       IF g_ooa.ooa40='01' THEN #FUN-C20063
          LET g_oob_d[l_ac2].oob09_1  = l_oob09 - l_oob09_1
          LET g_oob_d[l_ac2].oob10_1  = l_oob10 - l_oob10_1
       ELSE
          LET g_oob_d[l_ac2].oob09_1  = l_oob09_1 - l_oob09
          LET g_oob_d[l_ac2].oob10_1  = l_oob10_1 - l_oob10
       END IF
       #FUN-C20018--add--end
END FUNCTION


FUNCTION t401_ins_oma()
DEFINE  l_oob RECORD LIKE oob_file.*
DEFINE  l_oma RECORD LIKE oma_file.*
DEFINE  l_omc RECORD LIKE omc_file.*
DEFINE  l_occ RECORD LIKE occ_file.*
DEFINE  li_result    LIKE type_file.num5
DEFINE  l_cnt        LIKE type_file.num5
DEFINE  i            LIKE type_file.num5 
DEFINE  l_oma13      LIKE oma_file.oma13
DEFINE  l_oma18      LIKE oma_file.oma18
DEFINE  l_oma181     LIKE oma_file.oma181 
DEFINE  exT          LIKE type_file.chr1 
DEFINE  l_ooy        RECORD LIKE ooy_file.*
#FUN-C20018--add--begin
DEFINE l_oob03       LIKE oob_file.oob03    #借貸別
DEFINE l_type        LIKE type_file.chr100  #單據別
#FUN-C20018--add--end
DEFINE l_oob27       LIKE oob_file.oob27 #账款编号 #TQC-C20174
DEFINE l_ooydmy1     LIKE ooy_file.ooydmy1         #TQC-C20346

   IF g_success ='N' THEN RETURN END IF
   IF g_prog<> 'axrt401' THEN RETURN END IF 
   #FUN-C20018--add--begin
   #IF g_ooa.ooa40='1' THEN #FUN-C20063 mark--
   IF g_ooa.ooa40='01' THEN #FUN-C20063
      LET l_oob03='1'
      LET l_type='14'
      LET l_oob27=g_ooz.ooz26 #TQC-C20174
   ELSE
      LET l_oob03='2'
      LET l_type='22'
      LET l_oob27=g_ooz.ooz30 #TQC-C20174
   END IF
   #FUN-C20018--add--end

   FOR i =1 TO g_oob.getlength()
     IF cl_null(g_oob[i].oob09) THEN LET g_oob[i].oob09 = 0 END IF 
     IF cl_null(g_oob[i].oob10) THEN LET g_oob[i].oob10 = 0 END IF 

      IF cl_null(l_oma13) AND cl_null(l_oma18) THEN 
         SELECT oma13,oma18,oma181 INTO l_oma13,l_oma18,l_oma181 FROM oma_file WHERE oma01 = g_oob[i].oob06
         IF cl_null(l_oma13) OR cl_null(l_oma18) THEN 
            LET l_oma13 = NULL 
            LET l_oma18 = NULL 
         END IF 
      END IF   
      LET i = i + 1     
   END FOR

   DECLARE t401_sel_oob CURSOR  FOR 
      #SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03 ='1'    #FUN-C20018 mark--
      SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03 =l_oob03 #FUN-C20018 
       
   FOREACH t401_sel_oob INTO l_oob.*
      IF STATUS THEN 
        #CALL cl_err('sel oob',STATUS,1)   #No.FUN-D40089   Mark 
        #No.FUN-D40089 ---start--- Add
         IF g_bgerr THEN
            CALL s_errmsg('ooa01',g_ooa.ooa01,'',STATUS,1)
         ELSE
            CALL cl_err('sel oob',STATUS,1) 
         END IF
         #No.FUN-D40089 ---end  --- Add
         EXIT FOREACH 
      END IF  
         LET l_oma.oma02  = l_oob.oob25 
         LET l_oma.oma09  = l_oma.oma02 
         #LET l_oma.oma00  = '14'  #FUN-C20018 mark--
         LET l_oma.oma00=l_type    #FUN-C20018
         #CALL s_auto_assign_no("AXR",l_oob.oob27,l_oob.oob25,"14","oma_file","oma01","","","") #FUN-C20018 mark--
         #CALL s_auto_assign_no("AXR",l_oob.oob27,l_oob.oob25,l_type,"oma_file","oma01","","","")#FUN-C20018 #TQC-C20174 mark--
         CALL s_auto_assign_no("AXR",l_oob27,l_oob.oob25,l_type,"oma_file","oma01","","","")  #TQC-C20174 
              RETURNING li_result,l_oob.oob27
         IF  li_result THEN
             LET l_oma.oma01  = l_oob.oob27             
             UPDATE oob_file SET oob27 = l_oob.oob27
              WHERE oob01 = g_ooa.ooa01
                AND oob02 = l_oob.oob02
                #AND oob03 = '1'  #FUN-C20018 mark--
                AND oob03=l_oob03 #FUN-C20018
         ELSE
            #CALL s_errmsg('','',l_oma.oma01,'mfg-059',1)     #MOD-BC0248 add   #No.FUN-D40089   Mark
             CALL s_errmsg('ooa',g_ooa.ooa01,l_oma.oma01,'mfg-059',1)           #No.FUN-D40089   Add
             LET g_success = 'N'
             RETURN 
         END IF 
         
         #TQC-C20430--add--str--
         IF g_ooa.ooa35 = '1' AND NOT cl_null(g_ooa.ooa36) THEN
            UPDATE luk_file SET luk16 = l_oob.oob27 
             WHERE  luk01 = (SELECT lum09 FROM lum_file WHERE lum01 = g_ooa.ooa36)
            IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN
              #CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",SQLCA.sqlcode,"","",1)
              #No.FUN-D40089 ---start--- Add
               IF g_bgerr THEN
                  CALL s_errmsg('ooa36',g_ooa.ooa36,g_ooa.ooa01,SQLCA.sqlcode,1)
               ELSE
                  CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",SQLCA.sqlcode,"","",1)
               END IF
               #No.FUN-D40089 ---end  --- Add
               LET g_success ='N'
            END IF
         END IF
         #TQC-C20430--add--end
         SELECT ooydmy1 INTO l_ooydmy1 FROM ooy_file WHERE ooyslip = l_oob27   #TQC-C20346
         LET l_oma.oma03  = l_oob.oob24
         SELECT occ02 INTO l_oma.oma032 FROM occ_file WHERE occ01 = l_oma.oma03
         LET l_oma.oma04  = l_oob.oob24
         LET l_oma.oma08  = '1'
         SELECT * INTO l_occ.*  FROM occ_file WHERE occ01 = l_oma.oma03
         LET l_oma.oma23  = l_oob.oob07
         LET l_oma.oma24  = l_oob.oob08
        #TQC-C20346--add--str--
         IF g_ooz.ooz29 = 'Y' THEN
            LET l_oma.oma13 = l_oob.oob11
         ELSE
        #TQC-C20346--add--end
            LET l_oma.oma13  = g_ooz.ooz28 
         END IF   #TQC-C20346
         #IF g_ooz.ooz29 = 'N' THEN  #TQC-C20430 mark--
         IF g_ooz.ooz29 = 'N' OR g_ooa.ooa40 = '02' THEN  #TQC-C20430
            LET l_oma.oma18  = l_oob.oob11
            LET l_oma.oma181 = l_oob.oob111   
         ELSE
            #TQC-C20346--add--str--
            #TQC-C20430--mark--str
            #IF g_ooa.ooa40 = '02' THEN  ###待抵調帳
            #   IF l_ooydmy1 = 'Y' THEN
            #      SELECT ool26,ool261 INTO l_oma.oma18,l_oma.oma181 FROM ool_file WHERE ool01 = l_oma.oma13
            #   ELSE
            #      SELECT ool25,ool251 INTO l_oma.oma18,l_oma.oma181 FROM ool_file WHERE ool01 = l_oma.oma13
            #   END IF 
            #ELSE
            #TQC-C20430--mark--end
            #TQC-C20346--add--end
               SELECT ool11,ool111 INTO l_oma.oma18,l_oma.oma181 FROM ool_file WHERE ool01=l_oma.oma13
            #END IF   #TQC-C20346  #TQC-C20430 mark--
         END IF   
         SELECT occ45 INTO l_oma.oma32 FROM occ_file WHERE occ01 = l_oma.oma03 
         LET l_oma.oma04 = l_oma.oma03
         LET l_oma.oma05 = l_occ.occ08 
         LET l_oma.oma14 = l_occ.occ04 
         SELECT gen03 INTO l_oma.oma15 FROM gen_file
          WHERE gen01=l_oma.oma14
         #TQC-C20430--add--str
         IF g_ooa.ooa40 = '02' THEN
            LET l_oma.oma16=l_oob.oob01
         END IF
         #TQC-C20430--add--end
         LET l_oma.oma930=s_costcenter(l_oma.oma15)
         LET l_oma.oma16 = g_ooa.ooa01                     #MOD-D10102
         LET l_oma.oma21 = l_occ.occ41 
         LET l_oma.oma40 = l_occ.occ37 
         LET l_oma.oma25 = l_occ.occ43
         LET l_oma.oma32 = l_occ.occ45
         LET l_oma.oma042= l_occ.occ11
         LET l_oma.oma043= l_occ.occ18
         LET l_oma.oma044= l_occ.occ231
         CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,
                       l_oma.oma02,g_plant)
                     RETURNING l_oma.oma11,l_oma.oma12  
         SELECT gec04,gec05,gec07
           INTO l_oma.oma211,l_oma.oma212,l_oma.oma213
           FROM gec_file 
          WHERE gec01=l_oma.oma21
            AND gec011='2' 

         IF l_oma.oma08='1' THEN
            LET exT=g_ooz.ooz17
         ELSE
            LET exT=g_ooz.ooz63
         END IF
         IF l_oma.oma23=g_aza.aza17 THEN
            LET l_oma.oma24=1
            LET l_oma.oma58=1
         ELSE
            IF l_oma.oma24=0 OR l_oma.oma24=1 THEN
               CALL s_curr3(l_oma.oma23,l_oma.oma02,exT)
                           RETURNING l_oma.oma24
            END IF
            CALL s_curr3(l_oma.oma23,l_oma.oma09,exT)
                 RETURNING l_oma.oma58
         END IF
         LET l_oma.oma66  = g_plant   
         LET l_oma.oma50 = 0
         LET l_oma.oma51 = 0
         LET l_oma.oma51f= 0
         LET l_oma.oma50t= 0
         LET l_oma.oma52 = 0
         LET l_oma.oma53 = 0
         LET l_oma.oma54 = l_oob.oob09
         LET l_oma.oma54t= l_oob.oob09
         LET l_oma.oma56 = l_oob.oob10
         LET l_oma.oma56t= l_oob.oob10
         LET l_oma.oma54x= 0
         LET l_oma.oma55 = 0
         LET l_oma.oma56x= 0
         LET l_oma.oma57 = 0
         LET l_oma.oma58 = 0
         LET l_oma.oma59 = 0
         LET l_oma.oma59x= 0
         LET l_oma.oma59t= 0
         LET l_oma.oma60 = l_oob.oob08
         LET l_oma.oma61 = l_oob.oob10
         LET l_oma.omaconf='Y'
         LET l_oma.oma64 = '1'         
         LET l_oma.omavoid='N'
         LET l_oma.oma65 = '1'  
         LET l_oma.oma66 = g_plant           
         LET l_oma.oma68 = l_oma.oma03                                                                   
         LET l_oma.oma69 = l_oma.oma032  
         LET l_oma.oma70 = '1' 
         LET l_oma.omauser= g_user
         LET l_oma.omagrup= g_grup
         LET l_oma.omadate= g_today
         LET l_oma.omaoriu= g_user
         LET l_oma.omaorig= g_grup
         LET l_oma.omalegal=g_legal
         IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
         IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
         IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
         INSERT INTO oma_file VALUES(l_oma.*)  
         IF SQLCA.sqlcode THEN                    
           #CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1)  #No.FUN-D40089   Mark
           #No.FUN-D40089 ---start--- Add
            IF g_bgerr THEN
               CALL s_errmsg('ooa01',g_ooa.ooa01,'',SQLCA.sqlcode,1)
            ELSE
               CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1)
            END IF
            #No.FUN-D40089 ---end  --- Add
            LET g_success = 'N'
            EXIT FOREACH 
         ELSE
            LET g_success ='Y'
            SELECT azi04 INTO t_azi04 FROM azi_file                                                                                          
             WHERE azi01 = l_oma.oma23 
            LET l_omc.omc01 = l_oma.oma01
            LET l_omc.omc02 = 1
            LET l_omc.omc03 = l_oma.oma32
            LET l_omc.omc04 = l_oma.oma11
            LET l_omc.omc05 = l_oma.oma12
            LET l_omc.omc06 = l_oma.oma24
            LET l_omc.omc07 = l_oma.oma60
            LET l_omc.omc08 = l_oma.oma54t
            LET l_omc.omc09 = l_oma.oma56t
            LET l_omc.omc10 = 0
            LET l_omc.omc11 = 0
            LET l_omc.omc12 = l_oma.oma10
            LET l_omc.omc13 = l_omc.omc09-l_omc.omc11
            LET l_omc.omc14 = 0
            LET l_omc.omc15 = 0
            CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08
            CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09
            CALL cl_digcut(l_omc.omc13,g_azi04) RETURNING l_omc.omc13
            LET l_omc.omclegal = g_ooa.ooalegal
            INSERT INTO omc_file VALUES(l_omc.*)
            IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
              #CALL s_errmsg('','','ins omc err',SQLCA.sqlcode,1)   #No.FUN-D40089   Mark
               CALL s_errmsg('ooa',g_ooa.ooa01,'ins omc err',SQLCA.sqlcode,1)   #No.FUN-D40089   Add
               LET g_success = 'N'
            END IF
           
           #-MOD-C90201-mark-
           #CALL s_get_doc_no(l_oma.oma01) RETURNING g_t1
           #SELECT * INTO l_ooy.* FROM ooy_file WHERE ooyslip=g_t1
           #IF l_ooy.ooydmy1 = 'Y' THEN
           #   CALL s_t300_gl(l_oma.oma01,'0')     #No.FUN-A10104
           #   IF g_aza.aza63='Y' AND g_success='Y' THEN 
           #      CALL s_t300_gl(l_oma.oma01,'1')  #No.FUN-A10104
           #   END IF
           #END IF 
           #-MOD-C90201-mark-
           #-test-start-
           CALL s_get_doc_no(l_oma.oma01) RETURNING g_t1
           SELECT * INTO l_ooy.* FROM ooy_file WHERE ooyslip=g_t1
           IF l_ooy.ooydmy1 = 'Y' THEN
              CALL s_t300_gl(l_oma.oma01,'0')     #No.FUN-A10104
              IF g_aza.aza63='Y' AND g_success='Y' THEN
                 CALL s_t300_gl(l_oma.oma01,'1')  #No.FUN-A10104
              END IF
           END IF
           #test-
            IF g_success ='N' THEN RETURN END IF           
            CALL t400_b_fill_2(" 1=1")
         END IF
   END FOREACH 
END FUNCTION 

FUNCTION t401_del_oma()
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
 DEFINE l_oob      RECORD LIKE oob_file.*
 DEFINE l_oma      RECORD LIKE oma_file.*
 DEFINE l_ooy      RECORD LIKE ooy_file.*
 #FUN-C20018--add--begin 
 DEFINE l_oob03    LIKE oob_file.oob03
 #ooa40：1應收帳款，單身二借方oob03=1；2待抵帳款，單身二貸方oob03=2
   #IF g_ooa.ooa40='1' THEN #FUN-C20063 mark--
   IF g_ooa.ooa40='01' THEN #FUN-C20063
      LET l_oob03='1'
   ELSE
      LET l_oob03='2'
   END IF   
 #FUN-C20018--add--end
   IF g_prog <> 'axrt401' THEN RETURN END IF 
  
   DECLARE  t401_sel_oma1 CURSOR FOR 
    SELECT oma_file.* FROM oma_file,oob_file 
    WHERE oma01 = oob27 
      AND oob01 = g_ooa.ooa01 
     #AND oob03 ='1'   #FUN-C20018
      AND oob03=l_oob03
      
   FOREACH t401_sel_oma1 INTO l_oma.* 
      IF STATUS THEN CALL cl_err('sel aph',STATUS,1) EXIT FOREACH END IF
      IF NOT cl_null(l_oma.oma992) THEN
         CALL cl_err('','axr-950',1) 
         LET g_success='N'
         RETURN
      END IF

      IF l_oma.oma64 = "S" THEN
         CALL cl_err("","mfg3557",0)
         LET g_success='N'
         RETURN
      END IF
      
      SELECT COUNT(*) INTO l_cnt2 FROM ooa_file,oob_file
       WHERE ooa01=oob01 AND oob06=l_oma.oma01 AND ooaconf<>'X'
         AND ooa00 != '2'      
      IF l_cnt2 > 0 THEN
         CALL cl_err('','axr-014',0)
         LET g_success ='N'
         RETURN
      END IF
      
      IF l_oma.omaconf='N' THEN RETURN END IF
      #---97/10/20 由axrt400產生的溢收單應不可作確認取消
      IF l_oma.oma00 = '24' THEN
         CALL cl_err('','axr-010',0)    #MOD-5A0318
         LET g_success='N'
         RETURN
      END IF
      #FUN-B50090 add begin-------------------------
      #重新抓取關帳日期
      SELECT ooz09 INTO g_ooz.ooz09 FROM ooz_file WHERE ooz00='0'
      #FUN-B50090 add -end--------------------------
      IF l_oma.oma02<=g_ooz.ooz09 THEN
         CALL cl_err('','axr-164',0)
         LET g_success='N'
         RETURN
      END IF
      IF g_ooz.ooz07 = 'Y' AND l_oma.oma23 != g_aza.aza17 THEN
         CALL s_yp(l_oma.oma02) RETURNING l_yy,l_mm
         SELECT COUNT(*) INTO l_cnt FROM oox_file WHERE (oox01*12+oox02) >=(l_yy*12+l_mm)
            AND oox03 =l_oma.oma01
         IF l_cnt >0 THEN
            CALL cl_err(l_mm,'axr-407',0)
            LET g_success='N'
            RETURN
         END IF
      END IF
      IF g_ooz.ooz20 = 'Y' THEN   
         IF (g_aza.aza26='2' AND l_oma.oma00='21' AND NOT cl_null(l_oma.oma10)) OR
            ( (l_oma.oma00 MATCHES '1*' OR l_oma.oma00='31') AND #No:8519
            (l_oma.oma10 IS NOT NULL AND l_oma.oma10 !=' ')
            ) THEN #已開發票不可取消確認
            CALL cl_err(l_oma.oma10,'axr-904',0)
            LET g_success='N'
            RETURN
         END IF
      END IF   #MOD-840129
      SELECT COUNT(*) INTO l_cnt FROM oot_file WHERE oot03 = l_oma.oma01
      SELECT oma65 INTO l_oma.oma65 FROM oma_file WHERE oma01=l_oma.oma01
      IF g_aza.aza26 != '2' OR l_oma.oma00[1,1]!='2' OR l_ooy.ooydmy2!='Y' THEN
         IF l_oma.oma65 != '2' AND l_cnt=0 AND  #FUN-570099 若是直接收款，則不需考慮
            l_oma.oma55 != 0 AND l_oma.oma00!='31' THEN   #No:8519
       CALL cl_err(l_oma.oma01,'axr-160',0)
       LET g_success='N'
       RETURN
         END IF
      END IF
      
      #已有銷項發票底稿資料(不為作廢)時,則不可取消確認
      IF g_aza.aza26 = '2' AND g_aza.aza47 = 'Y' THEN
         SELECT COUNT(*) INTO l_cnt
           FROM isa_file
          WHERE isa04 = l_oma.oma01
            AND isa07 != 'V'
         IF l_cnt > 0 THEN
            CALL cl_err(l_oma.oma01,'axr-016',1)
            LET g_success ='N'
            RETURN
         END IF
      END IF
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt FROM npn_file
         WHERE npn01 = l_oma.oma16
      IF l_cnt > 0 THEN
         CALL cl_err('','aap-425',0)
         RETURN
      END IF 
      #取消確認時，若單據別設為"系統自動拋轉總帳",則可自動拋轉還原
      CALL s_get_doc_no(l_oma.oma01) RETURNING g_t1
      SELECT * INTO l_ooy.* FROM ooy_file WHERE ooyslip=g_t1
      IF NOT cl_null(l_oma.oma33) THEN
         IF NOT (l_ooy.ooydmy1 = 'Y' AND l_ooy.ooyglcr = 'Y') THEN
         CALL cl_err(l_oma.oma01,'axr-370',0) 
         LET g_success ='N'
         RETURN
         END IF
      END If
      IF l_ooy.ooydmy1 = 'Y' AND l_ooy.ooyglcr = 'Y' THEN
         LET g_plant_new=g_ooz.ooz02p CALL s_getdbs() LET l_dbs=g_dbs_new
         LET l_dbs=l_dbs.trimRight()                                                                                                    
         #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
         LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_plant_new,'aba_file'), 
                     "  WHERE aba00 = '",g_ooz.ooz02b,"'",
                     "    AND aba01 = '",l_oma.oma33,"'"
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql      
         CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
         PREPARE aba_pre22 FROM l_sql
         DECLARE aba_cs22 CURSOR FOR aba_pre22
         OPEN aba_cs22
         FETCH aba_cs22 INTO l_aba19
         IF l_aba19 = 'Y' THEN
            CALL cl_err(l_oma.oma33,'axr-071',1)
            LET g_success ='N'
            RETURN
         END IF
      END IF
      
      IF l_ooy.ooydmy1 = 'Y' AND l_ooy.ooyglcr = 'Y' AND g_success = 'Y' THEN
         LET g_str="axrp591 '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_oma.oma33,"' 'Y'"
         CALL cl_cmdrun_wait(g_str)
      END IF

      MESSAGE 'del npp !'
      DELETE FROM npp_file
       WHERE npp01 = l_oma.oma01
         AND nppsys = 'AR'
         AND npp00 = 2
         AND npp011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npp_file",l_oma.oma01,"",STATUS,"","del npp:",1) 
         LET g_success ='N'
         EXIT FOREACH 
      END IF
 
      MESSAGE 'del npq !'
      DELETE FROM npq_file
       WHERE npq01 = l_oma.oma01
         AND npqsys = 'AR'
         AND npq00 = 2
         AND npq011 = 1
      IF STATUS THEN
         CALL cl_err3("del","npq_file",l_oma.oma01,"",STATUS,"","del npq:",1)  
         LET g_success ='N'
         EXIT FOREACH 
      END IF
  #FUN-B40056--add--str--
      DELETE FROM tic_file WHERE tic04 = l_oma.oma01
      IF STATUS THEN
         CALL cl_err3("del","tic_file",l_oma.oma01,"",STATUS,"","del tic:",1)
         LET g_success='N'
      END IF
  #FUN-B40056--add--end--
 
      DELETE FROM omc_file WHERE omc01 = l_oma.oma01
      IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN                    
         CALL cl_err3("del","omc_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1) 
         LET g_success ='N'
         EXIT FOREACH 
      END IF 

      DELETE FROM oma_file WHERE oma01 = l_oma.oma01
      IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN                    
         CALL cl_err3("del","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1) 
         LET g_success ='N'
         EXIT FOREACH 
      ELSE
         UPDATE oob_file SET oob27 = g_ooz.ooz26 WHERE oob01 = g_ooa.ooa01 AND oob27 = l_oma.oma01
         IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_err3("upd","oob_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1) 
            LET g_success ='N'
            EXIT FOREACH 
         END IF 
         #TQC-C20430--add--str--
         IF g_ooa.ooa35 = '1' AND NOT cl_null(g_ooa.ooa36) THEN
            UPDATE luk_file SET luk16 = NULL WHERE luk16 = l_oma.oma01 
               AND luk01 = (SELECT lum09 FROM lum_file WHERE lum01 = g_ooa.ooa36)
            IF SQLCA.sqlcode AND SQLCA.sqlerrd[3] = 0 THEN
               CALL cl_err3("upd","luk_file",g_ooa.ooa36,"",SQLCA.sqlcode,"","",1)
               LET g_success ='N'
               EXIT FOREACH
            END IF 
         END IF 
         #TQC-C20430--add--end
      END IF
   END FOREACH 
 
   CALL t400_b_fill_2(" 1=1")
END FUNCTION 

FUNCTION t401_carry_voucher()
   DEFINE l_ooygslp    LIKE ooy_file.ooygslp
   DEFINE li_result    LIKE type_file.num5     
   DEFINE l_dbs        STRING 
   DEFINE l_sql        STRING                                                                                                        
   DEFINE l_n          LIKE type_file.num5       
   DEFINE l_buser      LIKE type_file.chr10   
   DEFINE l_euser      LIKE type_file.chr10
   DEFINE l_ooy        RECORD LIKE ooy_file.*   
   DEFINE l_oma        RECORD LIKE oma_file.*
 
   IF g_prog <> 'axrt401' THEN RETURN END IF 
   DECLARE  t401_sel_oma CURSOR FOR SELECT oma_file.* FROM oma_file,oob_file WHERE oma01 = oob27 AND oob01 = g_ooa.ooa01 AND oob03 ='1'
   FOREACH t401_sel_oma INTO l_oma.* 
      CALL s_get_doc_no(l_oma.oma01) RETURNING g_t1
      SELECT * INTO l_ooy.* FROM ooy_file WHERE ooyslip=g_t1
      IF NOT(l_ooy.ooydmy1 = 'Y' AND l_ooy.ooyglcr = 'Y') THEN RETURN END IF
      IF l_ooy.ooyglcr = 'Y' THEN
         LET l_sql = " SELECT COUNT(aba00) FROM ",cl_get_target_table(g_ooz.ooz02p,'aba_file'), #FUN-A50102      
             "  WHERE aba00 = '",g_ooz.ooz02b,"'",                                                                               
             "    AND aba01 = '",l_oma.oma33,"'"                                                                                 
         CALL cl_replace_sqldb(l_sql) RETURNING l_sql       
         CALL cl_parse_qry_sql(l_sql,g_ooz.ooz02p) RETURNING l_sql 
         PREPARE aba_pre21 FROM l_sql                                                                                                     
         DECLARE aba_cs21 CURSOR FOR aba_pre21                                                                                             
         OPEN aba_cs21                                                                                                                    
         FETCH aba_cs21 INTO l_n                                                                                                          
         IF l_n > 0 THEN                                                                                                                 
            CALL cl_err(l_oma.oma33,'aap-991',1) 
            LET g_success ='N'                                                                                        
            RETURN                                                                                                                       
         END IF   
      
         LET l_ooygslp = l_ooy.ooygslp
      ELSE                                                                                             
         RETURN       
      END IF
      IF cl_null(l_ooygslp) THEN
         CALL cl_err(l_oma.oma01,'axr-070',1)
         LET g_success ='N'
         RETURN
      END IF
      IF NOT cl_null(l_oma.oma99) THEN  
         LET l_buser = '0' 
         LET l_euser = 'z'  
      ELSE                 
         LET l_buser = l_oma.omauser  
         LET l_euser = l_oma.omauser  
      END IF                
      LET g_wc_gl = 'npp01 = "',l_oma.oma01,'" AND npp011 = 1'
      LET g_str="axrp590 '",g_wc_gl CLIPPED,"' '",l_buser,"' '",l_euser,"' '",g_ooz.ooz02p,"' '",g_ooz.ooz02b,"' '",l_ooygslp,"' '",l_oma.oma02,"' 'Y' '1' 'Y' '",g_ooz.ooz02c,"' '",l_ooy.ooygslp1,"'"   #No.MOD-840608 add  #No.MOD-860075  #MOD-910250  #No.MOD-920343
      CALL cl_cmdrun_wait(g_str)
   END FOREACH 
    
END FUNCTION
#No.FUN-AA0088 --end
#No.No.MOD-B30565--重新过单
#FUN-B80072
#FUN-CB0080-----add---str
FUNCTION t400_list_fill()
DEFINE l_ooa01          LIKE ooa_file.ooa01
DEFINE l_i              LIKE type_file.num10

    CALL g_ooa_1.clear()
    LET l_i = 1
    FOREACH t400_fill_cs INTO l_ooa01
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach item_cur',SQLCA.sqlcode,1)
          CONTINUE FOREACH
       END IF
       SELECT ooa01,ooa02,ooa03,ooa032,ooa14,gen02,ooa15,gem02,ooa23,ooa33,ooaconf,ooa34 
         INTO g_ooa_1[l_i].*
         FROM ooa_file
              LEFT OUTER JOIN gen_file ON ooa14 = gen01
              LEFT OUTER JOIN gem_file ON ooa15 = gem01
        WHERE ooa01=l_ooa01 
       LET l_i = l_i + 1
       IF l_i > g_max_rec THEN
          IF g_action_choice ="query"  THEN
            CALL cl_err( '', 9035, 0 )
          END IF
          EXIT FOREACH
       END IF
    END FOREACH
    LET g_rec_b1 = l_i - 1
    DISPLAY ARRAY g_ooa_1 TO s_ooa.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)
       BEFORE DISPLAY
          EXIT DISPLAY
    END DISPLAY

END FUNCTION

FUNCTION t400_bp2(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1         

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_ooa_1 TO s_ooa.* ATTRIBUTE(COUNT=g_rec_b1,UNBUFFERED)

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
         LET mi_no_ask = TRUE
         IF g_rec_b1 >0 THEN
            CALL t400_fetch('/')
         END IF
         CALL cl_set_comp_visible("page_info", FALSE)
         CALL cl_set_comp_visible("info", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_info", TRUE)
         CALL cl_set_comp_visible("info", TRUE)
         EXIT DISPLAY

      ON ACTION ACCEPT
         LET g_action_flag = "page_main"
         LET l_ac3 = ARR_CURR()
         LET g_jump = l_ac3
         LET mi_no_ask = TRUE
         CALL t400_fetch('/')
         CALL cl_set_comp_visible("info", FALSE)
         CALL cl_set_comp_visible("info", TRUE)
         CALL cl_set_comp_visible("page_info", FALSE)
         CALL ui.interface.refresh()
         CALL cl_set_comp_visible("page_info", TRUE)
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
         CALL t400_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
           IF g_rec_b1 != 0 THEN
         CALL fgl_set_arr_curr(g_curs_index)  
           END IF
           ACCEPT DISPLAY   
      
       ON ACTION previous
         CALL t400_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
           IF g_rec_b1 != 0 THEN
         CALL fgl_set_arr_curr(g_curs_index) 
           END IF
        ACCEPT DISPLAY                  


      ON ACTION jump
         CALL t400_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)
           IF g_rec_b1 != 0 THEN
         CALL fgl_set_arr_curr(g_curs_index)
           END IF
        ACCEPT DISPLAY       


      ON ACTION next
         CALL t400_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
           IF g_rec_b1 != 0 THEN
         CALL fgl_set_arr_curr(g_curs_index) 
           END IF
        ACCEPT DISPLAY              


      ON ACTION last
         CALL t400_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count) 
           IF g_rec_b1 != 0 THEN
         CALL fgl_set_arr_curr(g_curs_index) 
           END IF
        ACCEPT DISPLAY                  

      ON ACTION detail_b1
         LET g_action_choice="detail_b1"
         EXIT DISPLAY

      ON ACTION detail_b2
         LET g_action_choice="detail_b2"
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

      ON ACTION void  #作廢
         LET g_action_choice="void"
         EXIT DISPLAY                        
#FUN-D20035 add
      ON ACTION undo_void  #取消作廢
         LET g_action_choice="undo_void"
         EXIT DISPLAY  
#FUN-D20035 add         
      ON ACTION gen_entry #會計分錄產生
         LET g_action_choice="gen_entry"
         EXIT DISPLAY                       

      ON ACTION entry_sheet #分錄底稿
         LET g_action_choice="entry_sheet"
         EXIT DISPLAY                       

      ON ACTION entry_sheet2 #分錄底稿
         LET g_action_choice="entry_sheet2"
         EXIT DISPLAY                       

      ON ACTION memo  #備註
         LET g_action_choice="memo"
         EXIT DISPLAY                       

      ON ACTION easyflow_approval           
         LET g_action_choice="easyflow_approval"
         EXIT DISPLAY                        

      ON ACTION carry_voucher #傳票拋轉
         LET g_action_choice="carry_voucher"
         EXIT DISPLAY                        

      ON ACTION undo_carry_voucher #傳票拋轉還原
         LET g_action_choice="undo_carry_voucher"
         EXIT DISPLAY                       

      ON ACTION confirm #確認
         LET g_action_choice="confirm"
         EXIT DISPLAY                        

      ON ACTION undo_confirm #取消確認
         LET g_action_choice="undo_confirm"
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

      ON ACTION cancel
         LET INT_FLAG=FALSE              
         LET g_action_choice="exit"
         EXIT DISPLAY                        

      ON ACTION locale
         CALL cl_dynamic_locale()
         IF g_ooa.ooaconf='X' THEN LET g_chr='Y' ELSE LET g_chr='N' END IF
         IF g_ooa.ooa34 = '1' THEN LET g_chr2='Y' ELSE LET g_chr2='N' END IF
         CALL cl_set_field_pic(g_ooa.ooaconf,g_chr2,"","",g_chr,"")
         CALL t400_set_comb_oob04()        
         CALL t400_set_comb_oob04_1()      


      ON IDLE g_idle_seconds
         CALL cl_on_idle()

      ON ACTION about      
         CALL cl_about()   

      ON ACTION controls                         
         CALL cl_set_head_visible("","AUTO")     

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY                     

      ON ACTION approval_status            
         LET g_action_choice="approval_status"
         EXIT DISPLAY                      

      ON ACTION related_document                #相關文件
         LET g_action_choice="related_document"
         EXIT DISPLAY                     
      &include "qry_string.4gl"

      ON ACTION drill_down
         LET g_action_choice="drill_down"
         EXIT DISPLAY                      

      ON ACTION adjust_charge
         LET g_action_choice="adjust_charge"
         EXIT DISPLAY                    

    END DISPLAY  
    CALL cl_set_act_visible("accept,cancel", TRUE) 
END FUNCTION
#FUN-CB0080----add----end

#FUN-D70029--add--str--
FUNCTION t400_ins_oma_10()
DEFINE  l_oma RECORD LIKE oma_file.*
DEFINE  l_omc RECORD LIKE omc_file.*
DEFINE  l_occ RECORD LIKE occ_file.*
DEFINE  l_oob RECORD LIKE oob_file.*
DEFINE  li_result    LIKE type_file.num5
DEFINE  l_ooyslip    LIKE ooy_file.ooyslip
DEFINE  l_oma01      LIKE oma_file.oma01

   IF g_success ='N' THEN RETURN END IF
   DECLARE t400_sel_oob CURSOR  FOR
    SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03='1' AND oob04='H'

   FOREACH t400_sel_oob INTO l_oob.*
      IF STATUS THEN
         IF g_bgerr THEN
            CALL s_errmsg('ooa',g_ooa.ooa01,"",STATUS,1)
         ELSE
            CALL cl_err('sel oob',STATUS,1)
         END IF
         EXIT FOREACH
      END IF
      LET l_oma.oma00  = '10'
      SELECT ooyslip INTO l_ooyslip FROM ooy_file WHERE ooytype='10' AND ooyacti='Y'
      CALL s_auto_assign_no("axr",l_ooyslip,g_ooa.ooa02,"10","oma_file","oma01","","","")
           RETURNING li_result,l_oma01
      IF li_result THEN
         LET l_oma.oma01  = l_oma01
      ELSE
         CALL s_errmsg('ooa',g_ooa.ooa01,l_oma.oma01,'mfg-059',1)
          LET g_success = 'N'
          RETURN
      END IF
      LET l_oma.oma02   = g_ooa.ooa02
      LET l_oma.oma03   = g_ooa.ooa03
      LET l_oma.oma032  = g_ooa.ooa032
      LET l_oma.oma68   = g_ooa.ooa03
      LET l_oma.oma69   = g_ooa.ooa032
      LET l_oma.oma18   = l_oob.oob11
      LET l_oma.oma181  = l_oob.oob111

      SELECT * INTO l_occ.* FROM occ_file WHERE occ01 = g_ooa.ooa03

      LET l_oma.oma05   = l_occ.occ08
      LET l_oma.oma14   = g_ooa.ooa14
      LET l_oma.oma15   = g_ooa.ooa15
      LET l_oma.oma930  = s_costcenter(g_ooa.ooa15)
      LET l_oma.oma21   = l_occ.occ41
      LET l_oma.oma23   = l_oob.oob07
      LET l_oma.oma24   = l_oob.oob08
      LET l_oma.oma25   = l_occ.occ43
      LET l_oma.oma32   = l_occ.occ45
      LET l_oma.oma042  = l_occ.occ11
      LET l_oma.oma043  = l_occ.occ18
      LET l_oma.oma044  = l_occ.occ231
      LET l_oma.oma09   = l_oma.oma02
      LET l_oma.oma60   = l_oob.oob08

      CALL s_rdatem(l_oma.oma03,l_oma.oma32,l_oma.oma02,l_oma.oma09,l_oma.oma02,g_plant)
           RETURNING l_oma.oma11,l_oma.oma12

      SELECT gec04,gec05,gec07
        INTO l_oma.oma211,l_oma.oma212,l_oma.oma213
        FROM gec_file
       WHERE gec01=l_oma.oma21
         AND gec011='2'

      SELECT occ67 INTO l_oma.oma13 FROM occ_file
       WHERE occ01 = g_ooa.ooa03
      IF cl_null(l_oma.oma13) THEN
         LET l_oma.oma13 = g_ooz.ooz08
      END IF

      LET l_oma.oma66  = g_plant
      LET l_oma.omalegal = g_legal
      LET l_oma.omaconf = 'Y'
      LET l_oma.omavoid = 'N'
      LET l_oma.omaprsw = 0
      LET l_oma.omauser = g_user
      LET l_oma.omagrup = g_grup
      LET l_oma.omadate = g_today
      LET l_oma.omamksg = 'N'
      LET l_oma.oma64 = '0'
      LET l_oma.oma70 = '1'
      LET l_oma.oma65 = '1'
      LET l_oma.oma54t= l_oob.oob09
      LET l_oma.oma56t= l_oob.oob10
      LET l_oma.oma54 = l_oob.oob09
      LET l_oma.oma56 = l_oob.oob10

      IF cl_null(l_oma.oma50) THEN
         LET l_oma.oma50 = 0
      END IF
      IF cl_null(l_oma.oma50t) THEN
         LET l_oma.oma50t = 0
      END IF
      IF cl_null(l_oma.oma51) THEN
         LET l_oma.oma51 = 0
      END IF
      IF cl_null(l_oma.oma51f) THEN
         LET l_oma.oma51f = 0
      END IF
      IF cl_null(l_oma.oma52) THEN
         LET l_oma.oma52 = 0
      END IF
      IF cl_null(l_oma.oma53) THEN
         LET l_oma.oma53 = 0
      END IF
      IF cl_null(l_oma.oma54) THEN
         LET l_oma.oma54 = 0
      END IF
      IF cl_null(l_oma.oma54x) THEN
         LET l_oma.oma54x = 0
      END IF
      IF cl_null(l_oma.oma54t) THEN
         LET l_oma.oma54t = 0
      END IF
      IF cl_null(l_oma.oma55) THEN
         LET l_oma.oma55 = 0
      END IF
      IF cl_null(l_oma.oma56) THEN
         LET l_oma.oma56 = 0
      END IF
      IF cl_null(l_oma.oma56x) THEN
         LET l_oma.oma56x = 0
      END IF
      IF cl_null(l_oma.oma56t) THEN
         LET l_oma.oma56t = 0
      END IF
      IF cl_null(l_oma.oma57) THEN
         LET l_oma.oma57 = 0
      END IF

      IF cl_null(l_oma.oma73) THEN LET l_oma.oma73 =0 END IF
      IF cl_null(l_oma.oma73f) THEN LET l_oma.oma73f =0 END IF
      IF cl_null(l_oma.oma74) THEN LET l_oma.oma74 ='1' END IF
      LET l_oma.oma08='1'
      LET l_oma.oma16=l_oob.oob01

      INSERT INTO oma_file VALUES(l_oma.*)
      IF SQLCA.sqlcode THEN
         IF g_bgerr THEN
            CALL s_errmsg('ooa01',g_ooa.ooa01,'',SQLCA.sqlcode,1)
         ELSE
            CALL cl_err3("ins","oma_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1)
         END IF
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      LET l_omc.omc01=l_oma.oma01
      LET l_omc.omc02=1
      SELECT occ45 INTO l_omc.omc03 FROM occ_file WHERE occ01=g_ooa.ooa03
      IF cl_null(l_omc.omc03) THEN LET l_omc.omc03 = ' ' END IF
      LET l_omc.omc04=l_oma.oma11
      LET l_omc.omc05=l_oma.oma12
      LET l_omc.omc06=l_oma.oma24
      LET l_omc.omc07=l_oma.oma60
      LET l_omc.omc08=l_oma.oma54t
      LET l_omc.omc09=l_oma.oma56t
      LET l_omc.omc10=l_oma.oma55
      LET l_omc.omc11=l_oma.oma57
      LET l_omc.omc12=l_oma.oma10
      LET l_omc.omc13=l_omc.omc09-l_omc.omc11
      LET l_omc.omc14=l_oma.oma51f
      LET l_omc.omc15=l_oma.oma51
      LET l_omc.omclegal = g_ooa.ooalegal
      INSERT INTO omc_file VALUES(l_omc.*)
      IF SQLCA.sqlcode THEN
         IF g_bgerr THEN
            CALL s_errmsg('omc01','l_oma.oma01',g_ooa.ooa01,SQLCA.SQLCODE,1)
         ELSE
            CALL cl_err3("ins","omc_file",l_oma.oma01,"",SQLCA.sqlcode,"","",1)
         END IF
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      UPDATE oob_file SET oob06=l_oma.oma01,oob19=l_omc.omc02
       WHERE oob01=l_oob.oob01 AND oob02=l_oob.oob02
      IF STATUS OR SQLCA.SQLCODE THEN
        LET g_showmsg=l_oob.oob01,"/",l_oob.oob02
        IF g_bgerr THEN
           CALL s_errmsg('oob01,oob02',g_showmsg,'upd oob06',SQLCA.SQLCODE,1)
        ELSE
            CALL cl_err3("upd oob06","oob_file",g_showmsg,"",SQLCA.sqlcode,"","",1)
         END IF
         LET g_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH
END FUNCTION
FUNCTION t400_del_oma_10()
DEFINE  l_oob RECORD LIKE oob_file.*
DEFINE  l_oma RECORD LIKE oma_file.*

   IF g_success ='N' THEN RETURN END IF
   DECLARE t400_sel_omb2 CURSOR FOR
      SELECT * FROM oob_file WHERE oob01 = g_ooa.ooa01 AND oob03='1' AND oob04='H'

   FOREACH t400_sel_omb2 INTO l_oob.*
      IF STATUS THEN CALL cl_err('sel oob',STATUS,1) EXIT FOREACH END IF
      SELECT * INTO l_oma.* FROM oma_file
       WHERE oma01=l_oob.oob06 AND omavoid = 'N'
      IF l_oma.oma00 <> '10' THEN CONTINUE FOREACH END IF #TQC-D80042 add #排除20的情况
      IF l_oma.oma55 > 0 OR l_oma.oma57 > 0 THEN
         LET g_showmsg=l_oob.oob06,"/",'N'
         CALL cl_err3('sel oma','oma_file',g_showmsg,'','axr-206','','',1)
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      DELETE FROM oma_file WHERE oma01 = l_oob.oob06
      IF STATUS THEN
         CALL cl_err3('del oma','oma_file',l_oob.oob06,'',STATUS,'','',1)
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      IF SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err3('del oma','oma_file',l_oob.oob06,'','axr-199','','',1)
         LET g_success = 'N'
         EXIT FOREACH
      END IF
      DELETE FROM omc_file WHERE omc01=l_oob.oob06 AND omc02=l_oob.oob19
      IF STATUS THEN
         LET g_showmsg=l_oob.oob06,"/",l_oob.oob19
         CALL cl_err3('del omc','omc_file',g_showmsg,"",STATUS,'','',1)
         LET g_success ='N'
         EXIT FOREACH
      END IF
      UPDATE oob_file SET oob06=NULL,oob19=NULL
       WHERE oob01=l_oob.oob01 AND oob02=l_oob.oob02
      IF STATUS OR SQLCA.SQLCODE THEN
         LET g_showmsg=l_oob.oob01,"/",l_oob.oob02
         CALL cl_err3('upd oob06','oob_file',g_showmsg,'',SQLCA.SQLCODE,'','',1)
         LET g_success = 'N'
         EXIT FOREACH
      END IF
   END FOREACH
END FUNCTION
#FUN-D70029--add--end
