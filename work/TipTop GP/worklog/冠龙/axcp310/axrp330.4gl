# Prog. Version..: '5.30.06-13.04.18(00010)'     #
#
# Pattern name...: axrp330.4gl
# Descriptions...: 應收帳款彙總自動產生作業
# Date & Author..: 97/06/23 By Sophia
# Modify.........: 97/09/11 By Sophia彙總產生時應考慮預計收款日相同才能彙總
# Date & Modify..: 03/08/11 By Wiky #No:7781 彙總項目default原'23'改'45'
# Modify.........: No:7837 03/08/19 By Wiky 呼叫自動取單號時應在 Transction中
# Modify.........: No:8829 03/12/04 By Kitty g_sql裡oga00寫死要1
# Modify ........: No.MOD-540136 05/05/05 By ching fix限額問題
# Modify.........: No.FUN-550071 05/05/25 By vivien 單據編號格式放大 
# Modify.........: NO.FUN-560002 05/06/06 By jackie 單據編號修改
# Modify.........: No.FUN-560070 05/06/16 By Smapmin 單位數量改抓計價單位計價數量
# Modify.........: NO.FUN-540059 05/06/19 By wujie  單據編號修改
# Modify.........: NO.MOD-570274 05/07/27 By Nicola SQL條件修改
# Modify.........: No.MOD-580113 05/08/18 By Smapmin 匯總項目只有[12]沒有[45]
# Modify.........: No.MOD-590094 05/09/29 By Carrier 拆分時數量計算錯誤
# Modify.........: No.MOD-590114 05/10/20 By Smapmin add oga08外銷出貨單判斷
# Modify.........: No.FUN-5A0124 05/10/20 By elva insert帳款資料時加oma65欄位
# Modify.........: No.FUN-610020 06/01/09 By Carrier 出貨驗收功能 -- 修改oga09的判斷
# Modify.........: No.FUN-570156 06/03/09 By saki 批次背景執行
# Modify.........: NO.FUN-630043 06/03/14 By Melody 多工廠帳務中心功能修改
# Modify.........: NO.FUN-640191 06/04/19 By kim GP3.0匯率參數功能改善
# Modify.........: No.TQC-5C0086 05/12/19 By Carrier AR月底重評修改 
# Modify.........: NO.FUN-630015 06/05/25 BY yiting s_rdate2 改s_rdatem 
# Modify.........: No.FUN-650198 06/06/13 By cl  增加開窗查詢功能
# Modify.........: No.FUN-660116 06/06/22 By ice cl_err --> cl_err3
# Modify.........: No.TQC-670008 06/07/05 By rainy 權限修正
# Modify.........: No.FUN-670026 06/07/26 By Tracy 應收銷退合并  
# Modify.........: No.FUN-680001 06/08/02 By kim GP3.5 利潤中心
# Modify.........: No.FUN-670047 06/08/16 By Ray 增加兩帳套功能
# Modify.........: No.FUN-680022 06/08/23 By cl  多帳期處理
# Modify.........: No.FUN-680022 06/08/29 By Tracy s_rdatem()增加一個參數 
# Modify.........: No.FUN-680123 06/09/07 By hongmei 欄位類型轉換
# Modify.........: No.FUN-660073 06/09/08 By Nicola 訂單樣品修改
# Modify.........: No.MOD-690110 06/09/20 By cl     修改了AR產生的sql,原先會產生重復現象。
# Modify.........: NO.FUN-690012 06/10/30 BY rainy  omb33<--oba11
# Modify.........: No.MOD-690028 06/11/03 By Smapmin 已開發票數量應抓取計價數量
# Modify.........: No.MOD-690049 06/11/03 By Smapmin Default g_oma.*的值時,先清空g_oma.*
# Modify.........: No.TQC-6B0003 06/12/07 By Smapmin 發票限額的處理僅限於大陸版
# Modify.........: No.TQC-680074 06/12/27 By Smapmin 為因應s_rdatem.4gl程式內對於dbname的處理,故LET g_dbs2=g_dbs,'.'
# Modify.........: No.FUN-710050 07/01/15 By hongmei 錯誤訊息匯總顯示修改
# Modify.........: No.TQC-740047 07/04/17 By Rayven 若客戶簽收數量為0，立帳時會沒有數量，但是有金額
# Modify.........: No.MOD-740437 07/04/24 By Smapmin 依設定檔抓取格式與課稅別
# Modify.........: No.MOD-740428 07/04/29 By wujie   增加子帳期尾差的處理
# Modify.........: No.MOD-760069 07/06/15 By Smapmin 依oaz67參數決定檢查INVOIC條件
# Modify.........: No.MOD-760078 07/06/20 By Smapmin g_azi<->t_azi
# Modify.........: No.MOD-790093 07/09/19 By Smapmin 修改檢查是否有INVOICE的判斷
# Modify.........: No.MOD-7B0217 07/11/26 By claire ogb1012,omb39 != 'Y' 應包含 IS NULL
# Modify.........: No.TQC-7B0144 07/11/27 By chenl   1.oma51,oma64未賦值
# Modify.........:                                   2.未生成分錄底稿。
# Modify.........: No.MOD-810171 08/01/23 By Smapmin 調貨出貨單oga00='6'，也要可以使用axrp330拋轉至axrt300
# Modify.........: No.FUN-810045 08/03/23 By rainy 項目管理，專案相關欄位代入omb
# Modify.........: No.MOD-850009 08/05/05 By Smapmin 抓取已立帳的數量,應排除帳款已作廢的單據
# Modify.........: NO.MOD-860078 08/06/09 by Yiting ON IDLE處理 
# Modify.........: No.TQC-870024 08/07/16 By lutingting  將單號為TQC-810037由21區追單到31區： 應收金額應考慮折扣率
# Modify.........: No.MOD-890155 08/09/16 By chenl   修正sql錯誤。
# Modify.........: No.MOD-890187 08/10/01 By Sarah p330_g_oma_default()段,oma09預設值改為g_date
# Modify.........: No.MOD-8A0053 08/10/08 By Sarah 當訂金應收比例為100%,產生axrt300時,oma56,oma56x需為0,金額漏做取位動作
# Modify.........: No.FUN-920166 09/02/20 By alex g_dbs2改為使用s_dbstring
# Modify.........: No.MOD-920331 09/02/25 By liuxqa如果出貨單同時使用了多倉批和料號替代的功能，
#                                            在INSERT omb_file時沒有考慮多倉ogc_file的資料，
#                                            會造成立賬單身料號和真正的異動料號不一致。
# Modify.........: No.TQC-940147 09/04/24 By liuxqa mark MOD-920331 
# Modify.........: No.MOD-950027 09/05/06 By lilingyu 單價的抓取應該直接抓ogb13
# Modify.........: No.FUN-960141 09/06/30 By dongbg GP5.2修改:增加門店編號的QBE,出貨單若有收款,直接產生AR的直接收款
# Modify.........: No.MOD-970198 09/07/22 By mike 出貨單開窗挑選時建議過濾掉出貨通知單相關單據 
# Modify.........: No.TQC-960421 09/08/13 By liuxqa 若立賬日期不為空白時，check單據日期及立賬日期要同年月。
# Modify.........: No.FUN-980011 09/08/18 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-980020 09/09/10 By douzh GP5.2集團架構sub相關修改
# Modify.........: No.FUN-990069 09/09/27 By baofei 修改GP5.2的相關設定
# Modify.........: No.FUN-980025 09/09/27 By dxfwo p_qry 跨資料庫查詢
# Modify.........: No.FUN-990031 09/10/21 By lutingtingGP5.2財務營運中心欄位調整,營運中心要控制在同一法人下
# Modify.........: No.FUN-9A0093 09/10/30 By lutingting 拋轉AR時給omb44賦值 
# Modify.........: No:FUN-9A0027 09/10/10 By Carrier 销退单与出货单合并生成
# Modify.........: No.FUN-9C0002 09/12/01 By lutingting若出貨單沒有直接收款,則應收不需要生成直接收款
# Modify.........: No:FUN-9C0014 09/12/03 By shiwuying QBE門店編號改為來源營運中心,實現可由當前法人下的不同DB抓資料
# Modify.........: No:MOD-9B0097 09/12/22 By sabrina axrp330與axrp310抓取條件不一致, oga00條件要多加"B" 
# Modify.........: No:MOD-9C0442 09/12/28 By Dido 語法修改
# Modify.........: No.FUN-9C0072 10/01/06 By vealxu 精簡程式碼
# Modify.........: No:FUN-A10104 10/01/20 By shiwuying 傳參修改
# Modify.........: No:CHI-A50023 10/05/21 By Summer 增加"單價為0立帳"選項
# Modify.........: No.FUN-A60056 10/06/25 By lutingting GP5.2財務串前段問題整批調整
# Modify.........: No.FUN-A50102 10/07/07 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No:MOD-A80024 10/08/04 By Dido 如無資料產生應提示訊息 aap-129
# Modify.........: No:MOD-AA0141 10/10/25 By Dido 刪除單頭時,應清空 g_start 變數 
# Modify.........: No:MOD-AA0141 10/10/25 By Dido 刪除單頭時,應清空 g_start 變數 
# Modify.........: No:MOD-AA0156 10/10/25 By Elva 增加occ73的判断
# Modify.........: No:MOD-AA0185 10/10/29 By Dido 若客戶為 MISC 則 oma042/oma044 預設值調整為 occm02/occm04 
# Modify.........: No:MOD-AB0006 10/11/01 By Dido 增加尾差函式 
# Modify.........: No:MOD-AB0079 10/11/12 By wujie mark掉ohb1012的条件
# Modify.........: No:FUN-AC0027 10/12/09 By lilingyu 流通整合之財務
# Modify.........: No:MOD-AC0085 10/12/10 By Dido DROP 語法調整至 transtion 之前 
# Modify.........: No:TQC-B10107 11/01/14 By Dido 傳遞變數應為 plant 
# Modify.........: No.FUN-B10058 11/01/25 By lutingting 流通财务改善
# Modify.........: No:MOD-B10206 11/02/14 By wujie oha09 =5的销退单也要抓进去
# Modify.........: No:FUN-B30211 11/04/01 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No:FUN-B40005 11/04/19 By baogc BUG和分錄底稿邏輯的修改
# Modify.........: No:MOD-B50245 11/05/30 By wujie 抛转时不同月份的资料不用卡 
# Modify.........: No:TQC-B60121 11/06/16 By yinhy l_sql更改
# Modify.........: No:MOD-B60148 11/06/16 By wujie 1-oma163 -->100-oma163
# Modify.........: No.TQC-B70009 11/07/01 By wujie 抛转应收帐款时单身科目取值改变
# Modify.........: No:MOD-B70094 11/07/12 By Dido oma02 需檢核 ooz09 
# Modify.........: No:MOD-B70125 11/07/13 By Dido 抓取不到 oha09 時,給予空白 
# Modify.........: No:MOD-B70278 11/07/29 By yinhy 銷退方式為5時，產生應收賬款單身應為負
# Modify.........: No.FUN-B80058 11/08/05 By lixia 兩套帳內容修改，新增azf141
# Modify.........: No:MOD-B90021 11/09/05 By Polly 1.將g_wc1型態改為STRING，修正g_wc1字串取代方式
# Modify.........: No:TQC-B90044 11/09/06 By guoch 营运中心编号设置默认值
# Modify.........: No:MOD-B80346 11/08/31 By Polly 依據axms100的參數oaz67來判斷應以出通單貨出貨單來檢核ofa011
# Modify.........: No:MOD-B90218 11/09/26 By yinhy POS上傳出貨單項次5出貨數量为负，沒有生成應收賬款單身
# Modify.........: No:MOD-BA0159 11/10/21 By Dido 訂單彙總時邏輯調整;oha33 改為 ohb33 
# Modify.........: No:TQC-BA0172 11/11/01 By Dido 與 saxrp310_bu 整合 
# Modify.........: No:FUN-BA0109 11/11/22 By yinhy 更改omb33取值
# Modify.........: No.MOD-BB0246 11/11/24 By Polly 判斷若單身有多筆出貨單時，則將oma16清空
# Modify.........: No:FUN-BB0083 11/12/19 By xujing 增加數量欄位小數取位
# Modify.........: No:FUN-C10055 12/01/19 By fanbj 調整應收賬款的oma70（來源類型）欄位值
# Modify.........: No:TQC-C20565 12/03/01 By zhangweib 若單身有分攤折價時，則歸入到直接收款轉費用類型
# Modify.........: No:MOD-C30721 12/03/16 By xuxz 調整抓取出貨單銷退單的SQL的ORDER By段
# Modify.........: No:TQC-C40071 12/04/11 By Polly 調整撈單身的sql語法
# Modify.........: No:MOD-C40096 12/04/12 by yinhy 當出貨單的oga13為空，科目類型oma13的賦值應該優先找axmi221的occ67
# Modify.........: No:CHI-C10018 12/05/14 By Polly ooz65出貨應收包含銷退折讓的參數不受限大陸版
# Modify.........: No:MOD-C60076 12/06/11 By Polly 調整p330_prepare SQL 判斷
# Modify.........: No:FUN-C60036 12/06/14 By xuxz oaz92 = 'Y' and aza26 = '2'
# Modify.........: No:MOD-C60196 12/06/27777777mpire CALL s_rdatem的第二個參數l_omc03調整為l_omc.omc03
# Modify.........: No:FUN-C60036 12/06/2  By minpp  增加omf00查询条件
# Modify.........: No:MOD-C70120 12/07/11 By Elise IF g_oma.oma00='12' OR g_oma.oma00 = '19'THEN進入後先清空g_omb.omb33
# Modify.........: No:MOD-C70289 12/07/30 By yinhy 流通版本若有收款金額，oob09收款金額不應為0
# Modify.........: No:MOD-C80014 12/08/21 By Carrier 发票限额设定后，生成的帐款没有按限额拆分
# Modify.........: No:MOD-C80253 12/09/03 By Polly 增加判斷，多角的出貨單不產生應收
# Modify.........: No:FUN-C90068 12/09/17 By pauline 判斷g_mTax應直接使用oga01
# Modify.........: No:MOD-CA0083 12/10/12 By yinhy 給omb33賦值前先清空g_omb.omb33的值
# Modify.........: No:FUN-C90078 12/09/19 By minpp  抓科目时加判断，oma08=1时按原逻辑，否则给外销科目
# Modify.........: No:FUN-CA0084 12/10/25 By xuxz  發出商品改良
# Modify.........: No:CHI-CB0016 12/11/08 By Dido 重記金額改至產生分錄段處理 
# Modify.........: No:FUN-CB0057 12/11/14 By xuxz 添加oma76的內容
# Modify.........: No:TQC-CB0041 12/11/26 By yuhuabao 修改批量轉應收的時候,生成的axrt300資料審核的時候會報'axr-025'的bug
# Modify.........: No:MOD-CB0278 12/12/04 By Polly 當 ooz65 = Y 時，置換出貨單號為oha16值
# Modify.........: No:TQC-D10093 13/01/25 By xuxz 走開票流程時無需按限額拆分
# Modify.........: No:TQC-D20046 13/02/28 By qiull 修改發出商品測試相關問題
# Modify.........: No:MOD-D30026 13/03/05 By apo 修正MOD-B50245
# Modify.........: No.FUN-D10101 13/03/07 By wangrr 9主機追單到30主機,axrt300單身新增已開票數量欄位，賦默認值0
# Modify.........: No:MOD-CC0028 13/04/03 By apo 增加抓取「需簽核」欄位值寫入omamksg欄位
# Modify.........: No:MOD-D50119 13/05/14 By yinhy 默認oma16為100
# Modify.........: No:CHI-D50042 13/05/28 By yinhy 開票單號開窗修改
# Modify.........: No:FUN-D50008 13/06/05 By lixiang axmt670拋轉時oma09字段來源omf31發票日期
# Modify.........: No.MOD-D60122 13/06/15 By yinhy 沒有出貨單時，oma08按照幣種區分內銷，外銷
# Modify.........: No.MOD-D60123 13/06/15 By yinhy 修正產生omc_file時oma54還沒有賦值，所以產生omc08，omc09為0
# Modify.........: No.MOD-D60125 13/06/15 By yinhy oaz92欄位值為Y時，axrp330中QBE條件二中的信息隱藏
# Modify.........: No.MOD-D60154 13/06/15 By SunLM 通过axmt670抛转应收，单据类型为其他，axrp330中的date检查程序有问题，需要添加新的逻辑
# Modify.........: No:FUN-D60075 13/07/02 By zhuhao axmt670審核時去除開窗內容
# Modify.........: No:MOD-D90014 13/09/03 By SunLM oha09='5'時候產生應收金額錯誤
# Modify.........: No:MOD-D90122 13/09/26 By SunLM omc13賦值
# Modify.........: No:MOD-DA0056 13/10/12 By yinhy 有訂金的情況下，oma19賦值為訂單單號
# Modify.........: No:FUN-D90048 13/10/21 By yangtt 1.LET g_wc1=cl_replace_str(g_wc1, "oga01", "oha16")--->oha16改為oha01
#                                                   2.若oma54 OR oma56<=0,則報錯
# Modify.........: No:MOD-DA0161 13/10/23 By SunLM 判断合并的时候，l_oga11和sr.oga11取会计年期再比较,产生应收时汇总条件取消发票别
# Modify.........: No:MOD-DA0814 15/08/14 By jiangln axmt670销退点抛转应时，抓取销货退回科目及外销退回科目

DATABASE ds
 
GLOBALS "../../config/top.global"
GLOBALS "../../sub/4gl/s_g_ar.global"      #CHI-A50023 add
 
DEFINE g_wc,g_sql       STRING                       #No.FUN-580092 HCN
#DEFINE g_wc1           LIKE type_file.chr1000       #No.FUN-9A0027 #No.TQC-B60121 #No.MOD-B90021 mark
DEFINE g_wc1            STRING                       #No.MOD-B90021 add
DEFINE g_wc3            STRING                       #FUN-C60036 add
DEFINE source           LIKE azp_file.azp01          #No.FUN-680123 VARCHAR(10)     #FUN-630043
DEFINE g_date           LIKE type_file.dat           #No.FUN-680123 DATE         # 應收立帳日
DEFINE ar_sum           LIKE type_file.chr4          #No.FUN-680123 VARCHAR(4)      # 彙總項目 
DEFINE noin_sw          LIKE type_file.chr1          #No.FUN-680123 VARCHAR(1)      # NO INVOICE         
DEFINE g_no1            LIKE oay_file.oayslip        #No.FUN-680123 VARCHAR(5)      # 單別       #No.FUN-550071              
DEFINE g_no2            LIKE oay_file.oayslip        #No.FUN-B10058
DEFINE g_date2          LIKE type_file.dat           #No.FUN-680123 DATE         # 開立發票日期
DEFINE g_oma05          LIKE oma_file.oma05          #No.FUN-680123 VARCHAR(1)      # 發票別
DEFINE g_oga021         LIKE oga_file.oga021 
DEFINE g_oga            RECORD LIKE oga_file.*       # 出貨單號
DEFINE g_ogb            RECORD LIKE ogb_file.*       # 出貨單號
DEFINE g_ofb            RECORD LIKE ofb_file.*       # 出貨單號
DEFINE g_oma            RECORD LIKE oma_file.*
DEFINE g_omb            RECORD LIKE omb_file.*
DEFINE begin_no         LIKE oma_file.oma01          #No.FUN-680123 VARCHAR(16)    #No.FUN-560002 
DEFINE g_start,g_end    LIKE oma_file.oma01          #No.FUN-680123 VARCHAR(16)    #No.FUN-560002
DEFINE exT              LIKE type_file.chr1          #No.FUN-680123 VARCHAR(01)
DEFINE g_net            LIKE oox_file.oox10          #No.TQC-5C0086
DEFINE g_i            LIKE type_file.num5          #No.FUN-680123 SMALLINT   #count/index for any purpose
DEFINE g_msg          LIKE type_file.chr1000       #No.FUN-680123 VARCHAR(72)
DEFINE g_change_lang  LIKE type_file.chr1          #No.FUN-680123 VARCHAR(01)   #是否有做語言切換 No.FUN-570156
DEFINE g_dbs2         LIKE type_file.chr30   #TQC-680074
DEFINE g_bookno1      LIKE aza_file.aza81      #No.TQC-7B0144
DEFINE g_bookno2      LIKE aza_file.aza82      #No.TQC-7B0144
DEFINE i              LIKE type_file.num5      #No.TQC-7B0144
DEFINE g_flag         LIKE type_file.chr1      #No.TQC-7B0144
DEFINE l_flag1        LIKE type_file.chr1      #No.TQC-960421 add
DEFINE g_plant2       LIKE type_file.chr10     #FUN-980020
DEFINE g_type         LIKE type_file.chr1         #No.FUN-9A0027
DEFINE l_dbs          LIKE type_file.chr21     #No.FUN-9C0014 Add
#DEFINE g_wc2          LIKE type_file.chr1000   #No.FUN-9C0014 Add  #No.TQC-B60121
DEFINE g_wc2          STRING                   #No.TQC-B60121
DEFINE g_start1       LIKE oma_file.oma01      #No.FUN-9C0014 Add
DEFINE g_cnt          LIKE type_file.num10     #CHI-A50023 add
DEFINE g_occ73        LIKE occ_file.occ73      #MOD-AA0156 add
DEFINE g_oga01        LIKE oga_file.oga01      #FUN-B40005 ADD
DEFINE g_oga01_t      LIKE oga_file.oga01      #FUN-B40005 ADD
DEFINE g_oml_n        LIKE type_file.num5      #FUN-B40005 ADD
DEFINE g_omK_n        LIKE type_file.num5      #FUN-B40005 ADD
DEFINE g_mTax         LIKE type_file.chr1      #FUN-C10055 add
#FUN-C60036 add--str
DEFINE g_omf21      LIKE omf_file.omf21#FUN-C60036 add
DEFINE g_prog_type   STRING
DEFINE g_oaz92    LIKE oaz_file.oaz92      
DEFINE g_oaz93    LIKE oaz_file.oaz93    
DEFINE g_omf00    LIKE omf_file.omf00  #minpp add 
DEFINE g_omf01    LIKE omf_file.omf01
DEFINE g_omf02    LIKE omf_file.omf02
#FUN-C60036 add--end
DEFINE l_omf03    LIKE omf_file.omf03 #MOD-D60154 add

MAIN
   DEFINE ls_date       STRING                       #No.FUN-570156 
   DEFINE l_flag        LIKE type_file.dat           #No.FUN-680123 VARCHAR(1)   #No.FUN-570156 
 
   OPTIONS
        INPUT NO WRAP
   DEFER INTERRUPT
 
   INITIALIZE g_bgjob_msgfile TO NULL
   LET g_wc     = ARG_VAL(1)             #QBE條件
   LET ar_sum   = ARG_VAL(2)             #彙總項目
   LET ls_date  = ARG_VAL(3)             #應收立帳日期
   LET g_date   = cl_batch_bg_date_convert(ls_date)
   LET l_omf03 = g_date #MOD-D60154
   LET noin_sw  = ARG_VAL(4)             #無invoice者應產生應收帳款
   LET g_enter_account  = ARG_VAL(5)    #單價為0立帳否   #CHI-A50023 add
   LET g_no1    = ARG_VAL(6)            #應收帳款單別    #CHI-A50023 mod 5->6
   LET g_bgjob = ARG_VAL(7)             #背景作業        #CHI-A50023 mod 6->7
   LET g_no2    = ARG_VAL(8)            #FUN-B10058
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
   LET g_wc3    = ARG_VAL(9)  #FUN-C60036 add
   LET g_wc3    = cl_replace_str(g_wc3, "\\\"", "'") #FUN-C60036 add   
   LET g_prog_type = ARG_VAL(10) #FUN-C60036 add
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("AXR")) THEN
      EXIT PROGRAM
   END IF
 
   #FUN-C60036--add--str
   SELECT oaz92,oaz93 INTO g_oaz92,g_oaz93 FROM oaz_file
   #FUN-C60036--add--end

   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818
 
   LET g_plant2 = g_plant                    #FUN-980020
   LET g_dbs2 = s_dbstring(g_dbs CLIPPED)    #FUN-920166
 
   WHILE TRUE
      IF g_bgjob = "N" THEN
         CALL p330()
         IF cl_sure(18,20) THEN 
            LET g_success = 'Y'
            CALL p330_process()
            CALL s_showmsg()           #NO.FUN-710050
            IF g_success = 'Y' THEN
               COMMIT WORK
               CALL cl_end2(1) RETURNING l_flag
            ELSE
               ROLLBACK WORK
               CALL cl_end2(2) RETURNING l_flag
            END IF
            IF l_flag THEN
               CONTINUE WHILE
            ELSE
               CLOSE WINDOW p330_w
               EXIT WHILE
            END IF
         ELSE
            CONTINUE WHILE
         END IF
      ELSE
         LET g_success = 'Y'
         #FUN-C60036--ad--str
         SELECT oaz92 INTO g_oaz.oaz92 FROM oaz_file
        #IF g_oaz.oaz92 = 'Y' AND g_aza.aza26 = '2' AND cl_null(g_no1) THEN#FUN-CA0084 mark xuxz 20121031
#FUN-D60075 -------- mark ---------- begin --------------
#        IF g_oaz.oaz92 = 'Y' AND g_aza.aza26 = '2' THEN #FUN-CA0084 add xuxz 20121031
#           CALL p330_axrt320()
#        END IF 
#FUN-D60075 -------- mark ---------- end ----------------
         IF cl_null(g_wc2) THEN LET g_wc2 = ' 1=1' END IF
         IF cl_null(g_wc1) THEN LET g_wc1 = ' 1=1' END IF
         #FUN-C60036--add--end
         CALL p330_process() 
         CALL s_showmsg()           #NO.FUN-710050
         IF g_success = "Y" THEN
            CALL cl_err('','abm-019',1)#FUN-CA0084 add 20121031
            COMMIT WORK
         ELSE
            CALL cl_err('','axm-093',1)#FUN-CA0084 add 20121031
            ROLLBACK WORK
         END IF
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
   IF g_aza.aza52='Y' AND source!=g_plant THEN
      DATABASE g_dbs      
      CALL cl_ins_del_sid(1,g_plant) #FUN-980030  #FUN-990069
   END IF
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818
END MAIN
 
FUNCTION p330()
   DEFINE li_result  LIKE type_file.num5          #No.FUN-680123 SMALLINT  #No.FUN-560002
   DEFINE lc_cmd     LIKE type_file.chr1000       #No.FUN-680123 VARCHAR(500) #No.FUN-570156
   DEFINE l_azp02    LIKE azp_file.azp02          #FUN-630043
   DEFINE l_azp03    LIKE azp_file.azp03          #FUN-630043
   DEFINE l_i        LIKE type_file.num5          #No.FUN-9A0027
   DEFINE l_msg      STRING,
          l_msg1,l_msg2,l_msg3,l_msg4,l_msg5 STRING
            
   OPEN WINDOW p330_w WITH FORM "axr/42f/axrp330"
      ATTRIBUTE (STYLE = g_win_style CLIPPED)
   CALL cl_ui_init()
 
   CALL cl_set_comp_visible("group03", FALSE)   #FUN-990031
   CALL cl_set_comp_visible("ogaplant",FALSE)   #No.FUN-9C0014
   #FUN-C60036--add--str
    
   IF g_oaz92 !='Y' OR g_aza.aza26 != '2'  THEN
      CALL cl_set_comp_visible("group04", FALSE)
   ELSE
      CALL cl_getmsg('axr-211',g_lang) RETURNING l_msg1
      CALL cl_getmsg('axr-212',g_lang) RETURNING l_msg2
      CALL cl_getmsg('axr-213',g_lang) RETURNING l_msg3
      CALL cl_getmsg('axr-214',g_lang) RETURNING l_msg4
      CALL cl_getmsg('axr-215',g_lang) RETURNING l_msg5
      LET l_msg = '1:',l_msg1 CLIPPED,',2:',l_msg2 CLIPPED,',3:',l_msg3 CLIPPED,',4:',l_msg4 CLIPPED,',5:',l_msg5 CLIPPED
      CALL cl_set_combo_items('s1','1,2,3,4,5',l_msg)
      CALL cl_set_combo_items('s2','1,2,3,4,5',l_msg)
   END IF 
   #FUN-C60036--add--end
   #FUN-B10058--add--str--
   IF g_azw.azw04 <> '2' THEN
      CALL cl_set_comp_visible("g_no2",FALSE)
   END IF 
   #FUN-B10058--add--end
   
   #No.MOD-D60125  --Begin
   IF g_oaz92='Y' AND g_aza.aza26='2' THEN
     CALL cl_set_comp_visible("group01",FALSE)
   ELSE
      CALL cl_set_comp_visible("group04",FALSE)
   END IF
   #No.MOD-D60125  --End

   CLEAR FORM
 
      LET source=g_plant 
      LET l_azp03=g_dbs    #No.FUN-650198
      LET l_azp02=''
      DISPLAY BY NAME source
      SELECT azp02 INTO l_azp02 FROM azp_file WHERE azp01=source
      DISPLAY l_azp02 TO FORMONLY.azp02
      IF g_aza.aza52='Y' THEN
         INPUT BY NAME source WITHOUT DEFAULTS
         AFTER FIELD source 
            LET l_azp02=''
            SELECT azp02 INTO l_azp02 FROM azp_file
               WHERE azp01=source
            IF STATUS THEN
               CALL cl_err3("sel","azp_file",source,"","100","","",0)   #No.FUN-660116
               NEXT FIELD source
            END IF
            DISPLAY l_azp02 TO FORMONLY.azp02
 
         AFTER INPUT
            IF INT_FLAG THEN EXIT INPUT END IF  
 
         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(source)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form = "q_azp"
                    LET g_qryparam.default1 = source
                    CALL cl_create_qry() RETURNING source 
                    DISPLAY BY NAME source
                    NEXT FIELD source
            END CASE
 
            ON ACTION exit              #加離開功能genero
               LET INT_FLAG = 1
               EXIT INPUT
 
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
            CLOSE WINDOW p330_w 
            CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
            EXIT PROGRAM
         END IF
         IF source!=g_plant OR (NOT cl_null(g_plant)) THEN     #NO.FUN-650198
            SELECT azp03 INTO l_azp03 FROM azp_file WHERE azp01=source
            IF STATUS THEN LET l_azp03=g_dbs END IF
            DATABASE l_azp03    
            CALL cl_ins_del_sid(1,source) #FUN-980030  #FUN-990069
         END IF
      END IF

   WHILE TRUE
      CALL cl_opmsg('w')
      MESSAGE  ""
      CONSTRUCT BY NAME g_wc2 ON azp01
         BEFORE CONSTRUCT                 #TQC-B90044 add
            DISPLAY g_plant TO azp01      #TQC-B90044 add

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

         ON ACTION about
            CALL cl_about()

         ON ACTION help
            CALL cl_show_help()

         ON ACTION controlg
            CALL cl_cmdask()

         ON ACTION locale          #genero
            LET g_change_lang = TRUE
            EXIT CONSTRUCT

         ON ACTION exit              #加離開功能genero
              LET INT_FLAG = 1
              EXIT CONSTRUCT

         ON ACTION CONTROLP
            CASE
              WHEN INFIELD(azp01)  #機構別
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_azw"
                 LET g_qryparam.where = "azw02 = '",g_legal,"' "
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO azp01
                 NEXT FIELD azp01
            END CASE
      END CONSTRUCT
      IF g_change_lang THEN
         LET g_change_lang = FALSE
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
         CONTINUE WHILE
      END IF
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CLOSE WINDOW p330_w
         CALL cl_used(g_prog,g_time,2) RETURNING g_time
         EXIT PROGRAM
      END IF
      IF g_wc2 = ' 1=1' THEN
         CALL cl_err('','9046',0)
         CONTINUE WHILE
      END IF
      EXIT WHILE
   END WHILE
 
   WHILE TRUE
      CALL cl_opmsg('w')
      MESSAGE  ""
      IF g_oaz92 = 'N' OR cl_null(g_oaz92) THEN     #MOD-D60125
      CONSTRUCT BY NAME g_wc ON oga03,oga18,oga05,oga21,oga15,oga14, #No.FUN-670026 add oga18
                                oga23,oga02,oga01,ogb31,ogaplant     #No.FUN-650198 #FUN-960141 add ogaplant
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT
 
         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121
 
         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121
 
         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121
 
 
         ON ACTION locale          #genero
            LET g_change_lang = TRUE
            EXIT CONSTRUCT
 
         ON ACTION exit              #加離開功能genero
              LET INT_FLAG = 1
              EXIT CONSTRUCT
 
         ON ACTION CONTROLP
            CASE
              WHEN INFIELD(oga03)#客戶編號
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_occ02"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oga03
                   NEXT FIELD oga03
              WHEN INFIELD(oga21)#稅別
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gec3"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oga21
                   NEXT FIELD oga21
              WHEN INFIELD(oga15)#部門編號
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gem3"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oga15
                   NEXT FIELD oga15
 
              WHEN INFIELD(oga14)#業務人員
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_gen5"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oga14
                   NEXT FIELD oga14
 
              WHEN INFIELD(oga23)#幣種
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_azi2"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO oga23
                   NEXT FIELD oga23
 
              WHEN INFIELD(oga01)#出貨單單號
                   CALL cl_init_qry_var()
                   CALL q_oga_oha(TRUE,TRUE,'')                                 
                   RETURNING g_qryparam.multiret                                
                   DISPLAY g_qryparam.multiret TO oga01
                   NEXT FIELD oga01
 
              WHEN INFIELD(ogb31)#訂單單號
                   CALL cl_init_qry_var()
                   LET g_qryparam.form ="q_oea03"
                   LET g_qryparam.plant = source #No.FUN-980025 add 
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ogb31
                   NEXT FIELD ogb31
              
              WHEN INFIELD(ogaplant)#門店編號
                   CALL cl_init_qry_var()
                   LET g_qryparam.form = "q_azw"
                   LET g_qryparam.where = "azw02 = '",g_legal,"' "
                   LET g_qryparam.state = "c"
                   CALL cl_create_qry() RETURNING g_qryparam.multiret
                   DISPLAY g_qryparam.multiret TO ogaplant
                   NEXT FIELD ogaplant
              
            END CASE
      END CONSTRUCT
      LET g_wc = g_wc CLIPPED,cl_get_extra_cond('ogauser', 'ogagrup') #FUN-980030
      IF g_change_lang THEN
         LET g_change_lang = FALSE
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
         CONTINUE WHILE
      END IF
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CLOSE WINDOW p330_w 
         IF g_aza.aza52='Y' AND source!=g_plant THEN
            DATABASE g_dbs 
            CALL cl_ins_del_sid(1,g_plant) #FUN-980030  #FUN-990069
         END IF
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
         EXIT PROGRAM
      END IF
      IF g_wc = ' 1=1' THEN
         CALL cl_err('','9046',0) 
         CONTINUE WHILE
      END IF
      END IF  #MOD-D60125
 
  #IF g_aza.aza26 = '2' AND g_ooz.ooz65 = 'Y' THEN    #CHI-C10018 mark
   IF g_ooz.ooz65 = 'Y' THEN                          #CHI-C10018 add
      LET g_i = g_wc.getlength()                                          
      LET g_wc1 = g_wc                                                          
   #-----------------------------No.MOD-B90021------------------------------------------------start
     #FOR l_i = 1 TO g_i - 4                                                    
     #    CASE g_wc1[l_i,l_i+4]                                                 
     #         WHEN 'oga03'  LET g_wc1[l_i,l_i+4] = 'oha03'                     
     #         WHEN 'oga18'  LET g_wc1[l_i,l_i+4] = 'oha04'                     
     #         WHEN 'oga05'  LET g_wc1[l_i,l_i+4] = 'oha05'  #无法对应,若不对应后续会出-201的错误
     #         WHEN 'oga21'  LET g_wc1[l_i,l_i+4] = 'oha21'                     
     #         WHEN 'oga15'  LET g_wc1[l_i,l_i+4] = 'oha15'                     
     #         WHEN 'oga14'  LET g_wc1[l_i,l_i+4] = 'oha14'                     
     #         WHEN 'oga23'  LET g_wc1[l_i,l_i+4] = 'oha23'                     
     #         WHEN 'oga02'  LET g_wc1[l_i,l_i+4] = 'oha02'                     
     #         WHEN 'oga01'  LET g_wc1[l_i,l_i+4] = 'oha01'                     
     #         WHEN 'ogb31'  LET g_wc1[l_i,l_i+4] = 'oha33'                     
     #    END CASE                                                              
     #END FOR                                                                  
      LET g_wc1=cl_replace_str(g_wc1, "oga03", "oha03")
      LET g_wc1=cl_replace_str(g_wc1, "oga18", "oha04")
      LET g_wc1=cl_replace_str(g_wc1, "oga05", "oha05")
      LET g_wc1=cl_replace_str(g_wc1, "oga21", "oha21")
      LET g_wc1=cl_replace_str(g_wc1, "oga15", "oha15")
      LET g_wc1=cl_replace_str(g_wc1, "oga14", "oha14")
      LET g_wc1=cl_replace_str(g_wc1, "oga23", "oha23")
      LET g_wc1=cl_replace_str(g_wc1, "oga02", "oha02")
     #LET g_wc1=cl_replace_str(g_wc1, "oga01", "oha16")     #MOD-CB0278 mod oha01 -> oha16 #FUN-D90048
      LET g_wc1=cl_replace_str(g_wc1, "oga01", "oha01")     #FUN-D90048  
      LET g_wc1=cl_replace_str(g_wc1, "ogb31", "ohb33")     #MOD-BA0159 mod oha33 -> ohb33 
    #-----------------------------No.-MOD-B90021-------------------------------------------------end 
   END IF                                                                       
   #FUN-C60036--add--str
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
      CONSTRUCT BY NAME g_wc3 ON omf00,omf01,omf02  #minpp add
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE CONSTRUCT

         ON ACTION about         
            CALL cl_about()     

         ON ACTION help         
            CALL cl_show_help()  

         ON ACTION controlg      
            CALL cl_cmdask()    


         ON ACTION locale         
            LET g_change_lang = TRUE
            EXIT CONSTRUCT

         ON ACTION exit              
              LET INT_FLAG = 1
              EXIT CONSTRUCT
         ON ACTION controlp
            CASE
             #FUN-C60036--minpp--add--str
               WHEN INFIELD(omf00)
                  #No.CHI-D50042  --Begin
                  #CALL cl_init_qry_var()
                  #LET g_qryparam.state = "c"
                  #LET g_qryparam.form ="q_omf"
                  #CALL cl_create_qry() RETURNING g_qryparam.multiret
                  CALL q_omf1(TRUE,TRUE,'','1') RETURNING g_qryparam.multiret
                  #No.CHI-D50042  --End
                  DISPLAY g_qryparam.multiret TO omf00
                  NEXT FIELD omf00
             #FUN-C60036--minpp--add--end 
               WHEN INFIELD(omf01)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_omf01"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO omf01
                  NEXT FIELD omf01
               WHEN INFIELD(omf02)
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_omf02"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO omf02
                  NEXT FIELD omf02
            END CASE
      END CONSTRUCT
      IF g_change_lang THEN
         LET g_change_lang = FALSE
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()              
         CONTINUE WHILE
      END IF
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         CLOSE WINDOW gisp101_w
         CALL cl_used(g_prog,g_time,2) RETURNING g_time 
         EXIT PROGRAM
      END IF
   END IF
   #FUN-C60036--add--end
   LET g_date=g_today
   LET noin_sw='N'
   LET g_date2=NULL
   LET g_bgjob = "N"       #No.FUN-570156
   #LET g_enter_account = 'N'    #CHI-A50023 add
   LET g_enter_account = 'Y'     #MOD-D60125 
   CALL cl_opmsg('a')
 
      INPUT BY NAME tm2.s1,tm2.s2,g_date,noin_sw,g_enter_account,g_no1,g_no2,g_bgjob WITHOUT DEFAULTS    #No:FUN-570156 #CHI-A50023 add g_enter_account   #FUN-B10058 add g_no2
 
         AFTER FIELD g_date
            IF g_date IS NULL THEN
               NEXT FIELD g_date
            END IF
 
         AFTER FIELD noin_sw 
            IF noin_sw IS NULL THEN
               NEXT FIELD noin_sw
            END IF
            IF noin_sw NOT MATCHES "[YN]" THEN
               NEXT FIELD noin_sw
            END IF
 
         AFTER FIELD g_no1   
            IF cl_null(g_no1) THEN
               NEXT FIELD g_no1
            END IF
    CALL s_check_no("axr",g_no1,"","12","","","")
         RETURNING li_result,g_no1
         LET g_no1 = s_get_doc_no(g_no1)            #No.FUN-540059
         IF (NOT li_result) THEN
           NEXT FIELD g_no1
         END IF
     
         #FUN-B10058--add--str--
         AFTER FIELD g_no2
           IF NOT cl_null(g_no2) THEN
              CALL s_check_no("axr",g_no2,"","19","","","")
                 RETURNING li_result,g_no2
              LET g_no2 = s_get_doc_no(g_no2)     
              IF (NOT li_result) THEN
                  NEXT FIELD g_no2
              END IF
           END IF 
         #FUN-B10058--add--end
 
         #CHI-A50023 add --start--
         AFTER FIELD g_enter_account
            IF g_enter_account NOT MATCHES "[YN]" THEN
               NEXT FIELD g_enter_account
            END IF
         #CHI-A50023 add --end--

       ON ACTION CONTROLR
          CALL cl_show_req_fields()
       ON ACTION CONTROLG
          call cl_cmdask()
       ON ACTION CONTROLP
          CASE
             WHEN INFIELD(g_no1) # Class
                CALL q_ooy(FALSE,FALSE,g_no1,'12','AXR') RETURNING g_no1 #NO:6842   #TQC-670008
                DISPLAY BY NAME g_no1 
             #FUN-B10058--add--str--
             WHEN INFIELD(g_no2)
                CALL q_ooy(FALSE,FALSE,g_no2,'19','AXR') RETURNING g_no2
                DISPLAY BY NAME g_no2
             #FUN-B10058--add--end
            END CASE
       AFTER INPUT
          LET ar_sum = tm2.s1[1,1],tm2.s2[1,1]
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
       ON ACTION exit      #加離開功能genero
          LET INT_FLAG = 1
          EXIT INPUT
      END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p330_w 
         IF g_aza.aza52='Y' AND source!=g_plant THEN
            DATABASE g_dbs 
            CALL cl_ins_del_sid(1,g_plant) #FUN-980030  #FUN-990069
         END IF
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
      EXIT PROGRAM
   END IF
 
   IF g_bgjob = "Y" THEN
      SELECT zz08 INTO lc_cmd FROM zz_file
       WHERE zz01 = "axrp330"
      IF SQLCA.sqlcode OR lc_cmd IS NULL THEN
         CALL cl_err('axrp330','9031',1)
      ELSE
         LET g_wc=cl_replace_str(g_wc, "'", "\"")
         LET lc_cmd = lc_cmd CLIPPED,
                      " '",g_wc CLIPPED,"'",
                      " '",ar_sum CLIPPED,"'",
                      " '",g_date CLIPPED,"'",
                      " '",noin_sw CLIPPED,"'",
                      " '",g_enter_account CLIPPED,"'",  #CHI-A50023 add
                      " '",g_no1 CLIPPED,"'",
                      " '",g_bgjob CLIPPED,"'"
                     ," '",g_no2 CLIPPED,"'"      #FUN-B10058
         CALL cl_cmdat('axrp330',g_time,lc_cmd CLIPPED)
      END IF
      CLOSE WINDOW p330_w
         IF g_aza.aza52='Y' AND source!=g_plant THEN
            DATABASE g_dbs 
            CALL cl_ins_del_sid(1,g_plant) #FUN-980030  #FUN-990069
         END IF
     CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211 
     EXIT PROGRAM
   END IF
   EXIT WHILE
 
   END WHILE
END FUNCTION
 
FUNCTION p330_process()
   DEFINE   l_order    ARRAY[4] of LIKE oea_file.oea01, #No.FUN-680123 VARCHAR(16),  #No.FUN-650198
            l_ogb60    LIKE ogb_file.ogb60,
            l_ogb1013  LIKE ogb_file.ogb1013,           #No.FUN-670026
            l_oga      RECORD LIKE oga_file.*,
            l_ogb      RECORD LIKE ogb_file.*,
            l_oga03    LIKE oga_file.oga03,
            l_omf25    LIKE omf_file.omf25,  #150701wudj add omf25
            l_ta_omf01 LIKE omf_file.ta_omf01,   #add by zhaoxiangb 150722
            l_oga18    LIKE oga_file.oga18,             #No.FUN-670026
            l_oga11    LIKE oga_file.oga11,
            l_oga05    LIKE oga_file.oga05,
            l_oga21    LIKE oga_file.oga21,
            l_oga23    LIKE oga_file.oga23,
            l_oga27    LIKE oga_file.oga27,             #FUN-640191
            l_omb12    LIKE omb_file.omb12,
            l_omb14    LIKE omb_file.omb14,             #No.FUN-670026
            l_order1   LIKE oga_file.oga01,             #No.FUN-680123 VARCHAR(16),            #No.FUN-650198
            l_order2   LIKE oga_file.oga01,             #No.FUN-680123 VARCHAR(16),            #No.FUN-650198
            l_amt      LIKE ogb_file.ogb14t,
            l_ogaplant LIKE oga_file.ogaplant,          #FUN-960141
            sr         RECORD
            omf00      LIKE omf_file.omf00,             #FUN-C60036-minpp
            omf01      LIKE omf_file.omf01,             #FUN-C60036
            omf02      LIKE omf_file.omf02,             #FUN-C60036
            oga94      LIKE oga_file.oga94,             #FUN-B40005 ADD POS销售否
            ogb31      LIKE ogb_file.ogb31,             #FUN-650198
            order1     LIKE oga_file.oga01,             #No.FUN-680123 VARCHAR(16),            #No.FUN-650198
            order2     LIKE oga_file.oga01,             #No.FUN-680123 VARCHAR(16),            #No.FUN-650198
            oga01      LIKE oga_file.oga01,
            ogaplant   LIKE oga_file.ogaplant,          #FUN-960141 add
            oga011     LIKE oga_file.oga011,
            oga03      LIKE oga_file.oga03,
            oga18      LIKE oga_file.oga18,             #No.FUN-670026
            oga05      LIKE oga_file.oga05,
            oga21      LIKE oga_file.oga21,
            oga15      LIKE oga_file.oga15,
            oga14      LIKE oga_file.oga14,
            oga23      LIKE oga_file.oga23,
            oga02      LIKE oga_file.oga02, 
            oga11      LIKE oga_file.oga11,  
            oga27      LIKE oga_file.oga27,             #FUN-640191
            oga08      LIKE oga_file.oga08, #MOD-790093
            type       LIKE type_file.chr1,              #No.FUN-9A0027
            omf25      LIKE omf_file.omf25,  #150701wudj
            ta_omf01   LIKE omf_file.ta_omf01   #add by zhaoxiangb 150722
                       END RECORD
 
   DEFINE   l_slip   LIKE ooy_file.ooyslip
   DEFINE   l_flag   LIKE type_file.chr1          #No.FUN-680123 VARCHAR(01)
   DEFINE   l_qty    LIKE ogb_file.ogb12
   DEFINE   l_oaz67  LIKE oaz_file.oaz67   #MOD-760069
   DEFINE   l_used   LIKE ogb_file.ogb12   #No.TQC-7B0144
   DEFINE   l_n      LIKE type_file.num10  #No.TQC-7B0144
   DEFINE   l_ogb03  LIKE ogb_file.ogb03   #No.FUN-9A0027
   DEFINE   l_sum    LIKE rxx_file.rxx04   #FUN-960141
   DEFINE   l_sum1   LIKE rxx_file.rxx04   #No.FUN-9C0014
   DEFINE   l_cnt    LIKE type_file.num5   #No.FUN-9A0027
   DEFINE   l_rxx04  LIKE rxx_file.rxx04   #FUN-9C0002 
   DEFINE   l_azp01  LIKE azp_file.azp01   #No.FUN-9C0014
   DEFINE   l_oma66_t LIKE oma_file.oma66  #No.FUN-9C0014
   DEFINE   l_oma01_t LIKE oma_file.oma01  #No.FUN-9C0014
   DEFINE   l_end    LIKE oma_file.oma01   #MOD-AA0141
   DEFINE   l_oha09      LIKE oha_file.oha09   #No.MOD-B10206
   DEFINE   l_oga94_str1  LIKE type_file.chr1   #FUN-B40005 ADD
   DEFINE   l_oga94_str2  LIKE type_file.chr1   #FUN-B40005 ADD
   DEFINE   l_oga09       LIKE oga_file.oga09   #MOD-B80346 add
   DEFINE   l_wc2    STRING                #MOD-BA0159
   DEFINE   ls_n,ls_n2     LIKE type_file.num10 #FUN-C60036 add xuxz
   DEFINE   l_omf09,l_omf09_1 LIKE omf_file.omf09 #FUN-CA0084 add
   DEFINE   l_oay11   LIKE oay_file.oay11 #FUN-CA0084 add 20121031
   DEFINE   l_poz01  LIKE poz_file.poz01        #MOD-C80253 add
   DEFINE   l_poz18  LIKE poz_file.poz18        #MOD-C80253 add
   DEFINE   l_poz19  LIKE poz_file.poz18        #MOD-C80253 add
   DEFINE   l_oea01  LIKE oea_file.oea01        #CHI-CB0016 
   DEFINE l_yy,l_mm    LIKE type_file.num5  #MOD-D60154
   DEFINE   l_msg    STRING                     #FUN-D90048
   DEFINE   l_omb31  LIKE omb_file.omb31        #FUN-D90048

   #FUN-C60036--add--str--
   IF cl_null(g_wc3) THEN LET g_wc3 = " 1=1" END IF 
   LET ls_n = 0 
   LET g_sql = " SELECT COUNT(*) FROM omf_file ",
               "  WHERE omf10 = '9' ",
               "    AND ",g_wc3
   PREPARE omf10_per FROM g_sql
   EXECUTE omf10_per INTO ls_n
   LET ls_n2 = 0
   LET g_sql = " SELECT COUNT(*) FROM omf_file ",
               "  WHERE omf10! = '9' ",
               "    AND ",g_wc3
   PREPARE omf10_per2 FROM g_sql
   EXECUTE omf10_per2 INTO ls_n2
   #FUN-C60036--add--end
   DROP TABLE x                                    #MOD-AC0085
   SELECT * FROM npq_file WHERE 1=2 INTO TEMP x    #MOD-AC0085
   BEGIN WORK
   LET g_success = 'Y'
   LET g_start1 = ''
   CALL s_showmsg_init()
   LET l_ogb60 = 0
   LET l_omb12 = 0
   LET l_oga03 = ' '
   LET l_omf25=' ' #1507001wudj
   LET l_oga11 = g_today
   LET l_oga05 = ' '
   LET l_oga21 = ' '
   LET l_oga23 = ' '
   LET l_oga27 = ' '
   LET l_order1 = ' '
   LET l_order2 = ' '
   LET l_ogaplant = ' '

   LET g_sql = "SELECT azp01 FROM azp_file,azw_file ",
               " WHERE ",g_wc2 CLIPPED,
               "   AND azw01 = azp01 AND azw02 = '",g_legal,"'"
   PREPARE sel_azp01_pre FROM g_sql
   DECLARE sel_azp01_cs CURSOR FOR sel_azp01_pre
   FOREACH sel_azp01_cs INTO l_azp01
      IF STATUS THEN
         CALL cl_err('p310(ckp#1):',SQLCA.sqlcode,1)
         RETURN
      END IF
      LET g_plant_new = l_azp01
      CALL s_gettrandbs()
      LET l_dbs = g_dbs_tra

   LET l_flag1='N'
   IF NOT cl_null(g_date) THEN
      IF g_prog_type = 'axmt670' THEN #MOD-D60154 add beg----
         SELECT ccz01,ccz02 INTO g_ccz.ccz01,g_ccz.ccz02 FROM ccz_file
         CALL s_yp(l_omf03) RETURNING l_yy,l_mm
         IF l_yy < g_ccz.ccz01 OR (l_yy = g_ccz.ccz01 AND l_mm < g_ccz.ccz02) THEN
            LET l_flag1='Y'
         END IF      
      ELSE #MOD-D60154 add end----
         CALL p330_chkdate() 
      END IF #MOD-D60154 add
      IF l_flag1='X' THEN
         LET g_success = 'N'
         RETURN
      END IF
      IF l_flag1='Y' THEN
         CALL cl_err('','axr-065',1)
         LET g_success = 'N'
         RETURN
      END IF
    END IF
  #FUN-C60036--add-str
  IF g_oaz92 = 'Y' AND g_aza.aza26 = '2'  THEN
     IF cl_null(g_wc) THEN LET g_wc = ' 1=1' END IF #MOD-D90014
     IF cl_null(g_wc1) THEN LET g_wc1 = ' 1=1' END IF #MOD-D90014
    #LET g_sql= "SELECT DISTINCT omf01,omf02,oga94,ogb31,'','',oga01,ogaplant,oga011,oga03,oga18, ",     #minpp mark
     IF ls_n > 0 THEN 
        LET g_sql = " SELECT DISTINCT omf00,omf01,omf02,oga94,ogb31,'','',oga01,omf09,oga011,oga03,oga18, ",#FUN-CA0084 ogaplant--->omf09
                    "       oga05,oga21,oga15,oga14,oga23,oga02,oga11,oga27,oga08,'2' type,omf25,ta_omf01 ",  #150701wudj add omf25  #add ta_oma01 by zhaoxiangb 150722
                    "   FROM omf_file LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'oga_file'),
                    "  ON oga01 = omf11 AND ",g_wc CLIPPED,
                    "   AND ogaplant = '",l_azp01,"'",
                    "   AND ogaconf='Y' ",
                    "   AND oga00 IN ('1','4','5','6','B') ", # 出至境外倉(3)/BU間銷售(5)
                    "   AND oga09 NOT IN ('1','9') AND ogapost='Y'",
                    "   AND oga65 ='N' ",
                    "   AND oga01 IN (SELECT DISTINCT omf11 FROM omf_File ",
                               " WHERE omf08 = 'Y' AND omf10 = '1' ",
                               "   AND omf04 IS NULL ",
                               "   AND omf09 = '",l_azp01,"'",
                               "   AND ",g_wc3
        IF g_oaz93= 'Y' AND ls_n2 > 0 THEN LET g_sql = g_sql CLIPPED," AND omfpost = 'Y' " END IF
        LET g_sql = g_sql CLIPPED," )"
        LET g_sql = g_sql CLIPPED," LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'ogb_file'),
                    " ON oga01 = ogb01 " 
        IF g_enter_account = 'N' THEN
           LET g_sql = g_sql CLIPPED,
                    " AND ogb13 <> 0 "
        END IF      
        LET g_sql = g_sql CLIPPED," LEFT OUTER JOIN ",cl_get_target_table(g_plant_new,'oay_file'),
                           #" ON oga01 like ltrim(rtrim(oayslip))||'-%' AND oay11='Y'",           #TQC-D20046---mark---
                           " ON oga01 like ltrim(rtrim(oayslip))||'-%' ",                         #TQC-D20046---add---
                           " WHERE ",g_wc3,
                           "   AND omf04 IS NULL ",
                           "   AND omf08 = 'Y' ",
                           "   AND omf09 = '",l_azp01,"'"
     ELSE
     LET g_sql= "SELECT DISTINCT omf00,omf01,omf02,oga94,ogb31,'','',oga01,omf09,oga011,oga03,oga18, ",     #minpp add#FUN-CA0084 ogaplant--->omf09
              "       oga05,oga21,oga15,oga14,oga23,oga02,oga11,oga27,oga08,'2' type,omf25,ta_omf01 ",  #150701wudj add omf25   #add ta_omf01 by zhaoxiangb 150722
              "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", 
                        cl_get_target_table(g_plant_new,'ogb_file'),",", 
                        cl_get_target_table(g_plant_new,'oay_file'),",omf_file ",   
              " WHERE ",g_wc CLIPPED,
              "   AND ogaplant = '",l_azp01,"'",   
              "   AND oga01=ogb01 ", 
              "   AND ogaconf='Y' ",
              #"   AND oga01 like ltrim(rtrim(oayslip))||'-%' AND oay11='Y'",           #TQC-D20046---mark---
              "   AND oga01 like ltrim(rtrim(oayslip))||'-%' ",                         #TQC-D20046---add---
              "   AND oga00 IN ('1','4','5','6','B') ", # 出至境外倉(3)/BU間銷售(5)   
              "   AND oga09 NOT IN ('1','9') AND ogapost='Y'",
              "   AND oga65 ='N' ",
              "   AND oga01 = omf11 ",
              "   AND ",g_wc3,
              "   AND oga01 IN (SELECT DISTINCT omf11 FROM omf_File ",
                               " WHERE omf08 = 'Y' AND omf10 = '1' ",
                               "   AND omf04 IS NULL ",
                               "   AND omf09 = '",l_azp01,"'",
                               "   AND ",g_wc3
     IF g_oaz93= 'Y'  THEN LET g_sql = g_sql CLIPPED," AND omfpost = 'Y' " END IF 
     LET g_sql = g_sql CLIPPED," )"
                
     IF g_enter_account = 'N' THEN
         LET g_sql = g_sql CLIPPED,
                    " AND ogb13 <> 0 "
     END IF
     END IF 
    #IF g_aza.aza26 = '2' AND g_ooz.ooz65 = 'Y' THEN    #CHI-C10018 mark
     IF g_ooz.ooz65 = 'Y' THEN                          #CHI-C10018 add
        LET g_sql = g_sql CLIPPED," UNION ",
          #   "SELECT DISTINCT omf01,omf02,oha94,ohb33,'','',oha01,ohaplant,''    ,oha03,oha03, ",   #minpp--mark
              "SELECT DISTINCT omf00,omf01,omf02,oha94,ohb33,'','',oha01,omf09,''    ,oha03,oha03, ",  #minpp--add#FUN-CA0084 ohaplant--->omf09
              #"       ''   ,oha21,oha15,oha14,oha23,oha02,oha02,''   ,oha08,'3' type ",#MOD-DA0161 mark
              #"       ''   ,oha21,oha15,oha14,oha23,oha02,to_date('','yyyymmdd'),'',oha08,'3' type ",    #MOD-DA0161 add
              "       ''   ,oha21,oha15,oha14,oha23,oha02,CAST('' AS DATE),'',oha08,'3' type,omf25,ta_omf01 ",    #MOD-DA0161 add  #150701wudj add omf25  #add ta_omf01 by zhaoxiangb 150722
              "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", 
                        cl_get_target_table(g_plant_new,'ohb_file'),",", 
                        cl_get_target_table(g_plant_new,'oay_file'),",omf_file ",     
              " WHERE ",g_wc1 CLIPPED,
              "   AND ohaplant = '",l_azp01,"'",  
              "   AND oha01=ohb01 ", 
              "   AND ohaconf='Y' ",
              #"   AND oha01 like trim(oayslip)||'-%' AND oay11='Y'",   #TQC-D20046---mark---
              "   AND oha01 like trim(oayslip)||'-%' ",                 #TQC-D20046---add---
              "   AND oha09 IN ('1','4','5') AND ohapost='Y'",
              "   AND oha01 = omf11 ",
              "   AND ",g_wc3,
              "   AND oha01 IN (SELECT DISTINCT omf11 FROM omf_File ",
                               " WHERE omf08 = 'Y' AND omf10 = '2' ",
                               "   AND omf04 IS NULL ",
                               "   AND omf09 = '",l_azp01,"'",
                               "   AND ",g_wc3
        IF g_oaz93 = 'Y'  THEN LET g_sql = g_sql CLIPPED," AND omfpost = 'Y' "END IF 
        LET g_sql = g_sql CLIPPED," )"
        IF g_enter_account = 'N' THEN
           LET g_sql = g_sql CLIPPED,
                      " AND ohb13 <> 0 "
        END IF
     END IF
     LET g_sql = g_sql CLIPPED,
              " ORDER BY omf25,omf09,omf00,omf01,omf02,oga03,oga27,oga21,oga15,oga14,oga23,type,oga05 "  #minpp--add--omf00 #zhouxm151231 add omf25 
  ELSE   
  #FUN-C60036--add-end
  
  #DROP TABLE x                                   #MOD-AC0085 mark
  #SELECT * FROM npq_file WHERE 1=2 INTO TEMP x   #MOD-AC0085 mark

#  LET g_sql= "SELECT DISTINCT ogb31,'','',oga01,ogaplant,oga011,oga03,oga18, ",   #No.FUN-960141 add ogaplant  #MOD-9C0442 #FUN-B40005
   LET g_sql= "SELECT DISTINCT '','','',oga94,ogb31,'','',oga01,ogaplant,oga011,oga03,oga18, ",    #FUN-B40005 ADD  #FUN-C60036 add first '','','',
              "       oga05,oga21,oga15,oga14,oga23,oga02,oga11,oga27,oga08,'2' type,omf25,ta_omf01 ",     #150701wudj add omf25 #add ta_omf by zhaoxiangb 150722
              #"  FROM ",l_dbs CLIPPED,"oga_file,",l_dbs CLIPPED,"ogb_file,",l_dbs CLIPPED,"oay_file ",   #No.FUN-9C0014
              "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                        cl_get_target_table(g_plant_new,'ogb_file'),",", #FUN-A50102
                        cl_get_target_table(g_plant_new,'oay_file'),     #FUN-A50102
              " WHERE ",g_wc CLIPPED,
              "   AND ogaplant = '",l_azp01,"'",   #No.FUN-9C0014
              "   AND oga01=ogb01 ", 
              "   AND ogaconf='Y' ",
              #"   AND oga01 like ltrim(rtrim(oayslip))||'-%' AND oay11='Y'",   #TQC-D20046---mark---
              "   AND oga01 like ltrim(rtrim(oayslip))||'-%' ",                 #TQC-D20046---add---
              "   AND oga00 IN ('1','4','5','6','B') ", # 出至境外倉(3)/BU間銷售(5)   #MOD-9B0097 add B
              "   AND oga09 NOT IN ('1','9') AND ogapost='Y'",
              "   AND oga65 ='N' "
   
     #-------------------MOD-C60076----------------------(S)
      IF g_enter_account = 'N' THEN
         LET g_sql = g_sql CLIPPED,
                    " AND ogb13 <> 0 "
      END IF
     #-------------------MOD-C60076----------------------(E)
   #IF g_aza.aza26 = '2' AND g_ooz.ooz65 = 'Y' THEN    #CHI-C10018 mark 
    IF g_ooz.ooz65 = 'Y' THEN                          #CHI-C10018 add
       LET g_sql = g_sql CLIPPED," UNION ",
             #"SELECT DISTINCT ohb33,'','',oha01,ohaplant,''    ,oha03,oha03, ",  #No.FUN-960141 add ohaplant   #MOD-9C0442, #FUN-B40005 MARK
              "SELECT DISTINCT '','','',oha94,ohb33,'','',oha01,ohaplant,''    ,oha03,oha03, ", #FUN-B40005 ADD  #FUN-C60036 add first '','','',
              #"       ''   ,oha21,oha15,oha14,oha23,oha02,oha02,''   ,oha08,'3' type ", #MOD-DA0161 mark
              #"       ''   ,oha21,oha15,oha14,oha23,oha02,to_date('','yyyymmdd'),'',oha08,'3' type ",    #MOD-DA0161 add
              "       ''   ,oha21,oha15,oha14,oha23,oha02,CAST('' AS DATE),'',oha08,'3' type,omf25,ta_omf01  ",    #MOD-DA0161 add  #150701wudj add omf25  #add ta_omf01 by zhaoxiangb 150722
             #"  FROM ",l_dbs CLIPPED,"oha_file,",l_dbs CLIPPED,"ohb_file,",l_dbs CLIPPED,"oay_file ", #No.FUN-9C0014
              "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),",", #FUN-A50102
                        cl_get_target_table(g_plant_new,'ohb_file'),",", #FUN-A50102
                        cl_get_target_table(g_plant_new,'oay_file'),     #FUN-A50102
              " WHERE ",g_wc1 CLIPPED,
              "   AND ohaplant = '",l_azp01,"'",   #No.FUN-9C0014
              "   AND oha01=ohb01 ", 
              "   AND ohaconf='Y' ",
              #"   AND oha01 like trim(oayslip)||'-%' AND oay11='Y'",   #TQC-D20046---mark---
              "   AND oha01 like trim(oayslip)||'-%' ",                 #TQC-D20046---add---
              "   AND oha09 IN ('1','4','5') AND ohapost='Y'"
        #-------------------MOD-C60076----------------------(S)
         IF g_enter_account = 'N' THEN
            LET g_sql = g_sql CLIPPED,
                       " AND ohb13 <> 0 "
         END IF
        #-------------------MOD-C60076----------------------(E)
    END IF
    LET g_sql = g_sql CLIPPED,
           #  " ORDER BY ogaplant,oga03,oga27,oga05,oga21,oga15,oga14,oga23,type desc" #MOD-AA0156 
           #  " ORDER BY ogaplant,oga03,oga27,oga05,oga21,oga15,oga14,oga23,type" #MOD-AA0156 #MOD-C30721 mark
              " ORDER BY omf25,ogaplant,oga03,oga27,oga21,oga15,oga14,oga23,type,oga05,ta_omf01 " #MOD-C30721 add  #150701wudj add omf25 #add ta_omf01 by zhaoxiangb 150722
   END IF #FUN-C60036
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102	
   PREPARE p330_prepare FROM g_sql
   DECLARE p330_cs CURSOR FOR p330_prepare
   LET begin_no  = NULL
   LET g_start  = NULL   #No.TQC-9A0027
   INITIALIZE g_oga.* TO NULL
   INITIALIZE g_ogb.* TO NULL
   DECLARE omb_cs1 CURSOR FROM
      "SELECT DISTINCT(omb31) FROM omb_file WHERE omb01=?"
   LET l_oha09 = NULL   #No.MOD-B10206
   LET l_oga94_str1 = NULL  #FUN-B40005 ADD
   LET l_oga94_str2 = NULL  #FUN-B40005 ADD
   LET g_oga01_t    = NULL  #FUN-B40005 ADD
   LET g_oml_n      = NULL  #FUN-B40005 ADD
   LET g_omk_n      = NULL  #FUN-B40005 ADD
   
   FOREACH p330_cs INTO sr.*
      IF STATUS THEN
         CALL s_errmsg('','','p330(foreach):',STATUS,1)          #NO.FUN-710050
         LET g_success='N'
         EXIT FOREACH
      END IF
      #TQC-D20046---add---str---
         IF NOT cl_null(sr.oga01) THEN
            LET l_slip = s_get_doc_no(sr.oga01)
            LET g_sql = "SELECT oay11 ",
                        "  FROM ",cl_get_target_table(g_plant_new,'oay_file'),
                        " WHERE oayslip= '",l_slip,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
            PREPARE sel_oay11_pre FROM g_sql
            EXECUTE sel_oay11_pre INTO l_oay11
            IF l_oay11 != 'Y' THEN
               CALL s_errmsg('','',l_slip,'axr-422',1)
               LET g_success='N'
               EXIT FOREACH
            END IF
         END IF
         #TQC-D20046---add---end---
      IF g_success='N' THEN                                                                                                          
         LET g_totsuccess='N'                                                                                                       
         LET g_success="Y"                                                                                                          
      END IF                    
     #--------------------------MOD-C80253----------------------(S)
     #若非中斷點的出貨單要剔除
      LET l_poz01 = ''
      SELECT poz01,poz18,poz19 INTO l_poz01,l_poz18,l_poz19
        FROM ogb_file,oea_file,poz_file
       WHERE oea904 = poz01
         AND ogb01  = sr.oga01
         AND ogb31 = oea01

      IF NOT cl_null(l_poz01) THEN
         LET l_cnt = 0
         IF l_poz19 = 'Y'  AND g_plant = l_poz18 THEN        #已設立中斷點
            SELECT COUNT(*) INTO l_cnt                       #check poz18設定的中斷營運中心是否存在單身設定
              FROM poy_file
             WHERE poy01 = l_poz01
               AND poy04 = l_poz18
         END IF
         IF l_cnt = 0 THEN
            CALL s_errmsg('oga01',sr.oga01,'','axr-162',1)
            CONTINUE FOREACH                                 #表示出貨單為多角單據不可由此程式處理
         END IF
      END IF
     #--------------------------MOD-C80253----------------------(E)
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
   #FUN-CA0084--add--str--20121031
         IF NOT cl_null(sr.omf00) AND g_success = 'Y' THEN
            LET g_sql= "SELECT oay11 FROM oay_file,omf_file ",
                 " WHERE omf00 like ltrim(rtrim(oayslip))||'-%' AND omf00 = '",sr.omf00,"'"
            PREPARE p330_oay11_prepare FROM g_sql
            EXECUTE p330_oay11_prepare INTO l_oay11
            IF l_oay11 != 'Y' THEN
               CALL s_errmsg('omf00',sr.omf00,'','axr-372',1)
               LET g_success = 'N'
               CONTINUE FOREACH
            END IF
         END IF
        #FUN-CA0084--add--end--20121031
   IF sr.oga94 = 'Y' THEN
      LET l_oga94_str1 = 'Y'
   END IF
   IF sr.oga94 = 'N' OR cl_null(sr.oga94) THEN
      LET l_oga94_str2 = 'Y'
   END IF
   IF l_oga94_str1 = 'Y' THEN
      IF sr.oga94 = 'N' OR cl_null(sr.oga94) THEN
         CALL s_errmsg('oga94',sr.oga94,'','axr-085',1)                       
         #由POS銷售資料產生, 不允許和其它銷售類型合併產生應收帳款
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   IF l_oga94_str2 = 'Y' THEN
      IF sr.oga94 = 'Y' THEN
         CALL s_errmsg('oga94',sr.oga94,'','axr-085',1)                       
         #由POS銷售資料產生, 不允許和其它銷售類型合併產生應收帳款
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   LET g_oga01 = sr.oga01
###-FUN-B40005- ADD -  END  ---------------------------------------------------
 
   LET g_type = sr.type                                                         
   SELECT azi03,azi04,azi05 INTO t_azi03,t_azi04,t_azi05                        
     FROM azi_file                                                              
    WHERE azi01 = sr.oga23                                                      
   IF cl_null(t_azi03) THEN LET t_azi03 = 0 END IF                              
   IF cl_null(t_azi04) THEN LET t_azi04 = 0 END IF                              
   IF cl_null(t_azi05) THEN LET t_azi05 = 0 END IF                              

   IF g_bgjob = "N" THEN       #No.FUN-570156
      MESSAGE   '單號:',sr.oga01
      CALL ui.Interface.refresh() 
   END IF                      #No.FUN-570156
   #MOD-AA0156 by elva  --begin
   LET g_sql = "SELECT occ73 FROM ",g_dbs_tra CLIPPED,"occ_file",
               "  WHERE occ01 = '",sr.oga03,"'"
   PREPARE sel_occ8 FROM g_sql
   EXECUTE sel_occ8 INTO g_occ73
   IF cl_null(g_occ73) THEN LET g_occ73 = 'N' END IF
 # IF sr.type = '3' THEN    #销退
   IF g_occ73 = 'Y' AND sr.type = '3' THEN  
   #MOD-AA0156 by elva  --end
      LET l_cnt = 0
      #LET g_sql = "SELECT COUNT(*) FROM ",l_dbs CLIPPED,"rxx_file ",
      LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rxx_file'), #FUN-A50102
                  " WHERE rxx01 = '",sr.oga01,"'",
                  "   AND rxx00 = '03'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
      PREPARE sel_rxx_pre01 FROM g_sql
      EXECUTE sel_rxx_pre01 INTO l_cnt
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt > 0 THEN     #有直接退款的销退单不能做合并
         CONTINUE FOREACH
      END IF
   END IF

    #LET g_sql = "SELECT SUM(rxx04) FROM ",l_dbs CLIPPED,"rxx_file ",
    LET g_sql = "SELECT SUM(rxx04) FROM ",cl_get_target_table(g_plant_new,'rxx_file'), #FUN-A50102
                " WHERE rxx01 = '",sr.oga01,"'",
                "   AND rxx00 = '02'"
    CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
    PREPARE sel_rxx_pre02 FROM g_sql
    EXECUTE sel_rxx_pre02 INTO l_sum
   IF cl_null(l_sum) THEN LET l_sum = 0 END IF
   LET l_ogb60 = 0     LET l_omb12 = 0
   IF sr.type = '2' THEN
      #LET g_sql = "SELECT SUM(ogb917) FROM ",l_dbs CLIPPED,"ogb_file ",
      LET g_sql = "SELECT SUM(ogb917) FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  " WHERE ogb01='",sr.oga01,"'",
                  "   AND ogb1005 != '2' ",
                  "   AND (ogb1012 != 'Y' OR ogb1012 IS NULL)"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102              
      PREPARE sel_ogb_pre03 FROM g_sql
      EXECUTE sel_ogb_pre03 INTO l_ogb60
      SELECT SUM(omb12) INTO l_omb12 FROM oma_file,omb_file
       WHERE omb31 = sr.oga01
         AND omb01 = oma01
         AND omavoid = 'N'
         AND omb38 = '2'                            #No.FUN-670026
         AND (omb39!= 'Y' OR omb39 IS NULL)         #No.FUN-670026  #MOD-7B0217 modify 
         #AND oma00 = '12'                           #No.FUN-670026 #FUN-B10058
         AND (oma00 = '12' OR oma00 = '19')         #FUN-B10058                
      SELECT SUM(omb14) INTO l_omb14 FROM oma_file,omb_file 
       WHERE omb31 = sr.oga01
         AND omb01 = oma01 
         AND omavoid = 'N' 
         #AND oma00 = '12'    #FUN-B10058 
         AND (oma00 = '12' OR oma00 = '19')   #FUN-B10058
         AND omb38 = '4'
      #LET g_sql = "SELECT SUM(ogb14) FROM ",l_dbs CLIPPED,"ogb_file",
      LET g_sql = "SELECT SUM(ogb14) FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  " WHERE ogb01 = '",sr.oga01,"'",
                  "   AND ogb1005 = '2'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
      PREPARE sel_ogb_pre04 FROM g_sql
      EXECUTE sel_ogb_pre04 INTO l_ogb1013
   ELSE
      #LET g_sql = "SELECT SUM(ohb917) FROM ",l_dbs CLIPPED,"ohb_file",
      LET g_sql = "SELECT SUM(ohb917) FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                  " WHERE ohb01='",sr.oga01,"'",
                  "   AND ohb1005 != '2'"
#                 "   AND (ohb1012 != 'Y' OR ohb1012 IS NULL)"   #NO.MOD-AB0079 mark
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
      PREPARE sel_ohb_pre05 FROM g_sql
      EXECUTE sel_ohb_pre05 INTO l_ogb60
      SELECT SUM(ABS(omb12)) INTO l_omb12 FROM oma_file,omb_file
       WHERE omb31 = sr.oga01
         AND omb01 = oma01
         AND omavoid = 'N'
         AND omb38 IN ('2','3')
         AND (omb39!= 'Y' OR omb39 IS NULL)
         #AND oma00 IN ('12','21')  #FUN-B10058
         AND oma00 IN ('12','19','21','28')   #FUN-B10058
   END IF
   IF cl_null(l_ogb60) THEN LET l_ogb60 = 0 END IF

   IF l_omb12 IS NULL THEN
      LET l_omb12 = 0
   END IF
   LET l_ogb60 = l_ogb60 - l_omb12
#No.MOD-B10206 --begin  
#  IF l_ogb60 IS NULL OR l_ogb60<=0 THEN  #No.FUN-670026 mark
#   IF l_ogb60 IS NULL OR l_ogb60<=0 THEN  #No.MOD-690110 add
  #SELECT oha09 INTO l_oha09 FROM oha_file WHERE oha01 = sr.oga01  #MOD-B70125 mark 
  #-MOD-B70125-add-
   LET g_sql = "SELECT oha09 ", 
               "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),
               " WHERE oha01 = '",sr.oga01,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
   PREPARE p330_oha09_p FROM g_sql
   DECLARE p330_oha09_c SCROLL CURSOR FOR p330_oha09_p
   OPEN p330_oha09_c
   FETCH p330_oha09_c INTO l_oha09
   IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF 
  #-MOD-B70125-end-
   IF g_oaz92 != 'Y' OR g_aza.aza26 != '2' THEN #FUN-C60036 add
   IF (l_ogb60 IS NULL OR l_ogb60<=0) AND l_oha09 <> '5' THEN
#No.MOD-B10206 --end
      CONTINUE FOREACH                    #No.MOD-690110 add
   END IF                                 #No.MOD-690110 add 
   END IF #FUN-60036 add
   IF sr.oga08 <> '1' THEN   #MOD-590114   #MOD-790093
      LET l_oaz67 = ''
      #LET g_sql = "SELECT oaz67 FROM ",l_dbs CLIPPED,"oaz_file"
      LET g_sql = "SELECT oaz67 FROM ",cl_get_target_table(g_plant_new,'oaz_file') #FUN-A50102
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102 
      PREPARE sel_oaz_pre06 FROM g_sql
      EXECUTE sel_oaz_pre06 INTO l_oaz67
     #-----------------------------No.MOD-B80346---------------------------start
      LET g_sql = "SELECT oga09 FROM ",cl_get_target_table(g_plant_new,'oga_file'),
                  " WHERE oga01='",sr.oga01,"' AND oga09 NOT IN ('1','9','A')"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
      PREPARE sel_oeb_pre1 FROM g_sql
      EXECUTE sel_oeb_pre1 INTO l_oga09
     #-----------------------------No.MOD-B80346-----------------------------end
      IF l_oaz67='1' THEN
        #----------------------------------No.MOD-B80346---------------------------start
         IF l_oga09 IS NOT NULL AND l_oga09='8' THEN
            LET g_sql = "SELECT ofa01",
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file a'),",",
                                  cl_get_target_table(g_plant_new,'oga_file b'),",",
                                  cl_get_target_table(g_plant_new,'ofa_file'),
                        " WHERE a.oga01 ='",sr.oga01,"'",
                        "   AND a.oga011=b.oga01 AND b.oga011=ofa011 ",
                        "   AND ofaconf = 'Y'"
         ELSE
        #-----------------------------------No.MOD-B80346-----------------------------end
           #LET g_sql = "SELECT ofa01 FROM ",l_dbs CLIPPED,"oga_file,",l_dbs CLIPPED,"ofa_file",
            LET g_sql = "SELECT ofa01 FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                                             cl_get_target_table(g_plant_new,'ofa_file'),     #FUN-A50102
                        " WHERE oga01='",sr.oga01,"'",
                        "   AND oga011=ofa011",
                        "   AND ofaconf='Y'"
         END IF                                                           #No.MOD-B80346 add
      ELSE
         #LET g_sql = "SELECT ofa01 FROM ",l_dbs CLIPPED,"oga_file,",l_dbs CLIPPED,"ofa_file",
         LET g_sql = "SELECT ofa01 FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                                          cl_get_target_table(g_plant_new,'ofa_file'),     #FUN-A50102
                     " WHERE oga01='",sr.oga01,"'",
                     "   AND oga01=ofa011",
                     "   AND ofaconf='Y'"
      END IF
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102
      PREPARE sel_ofa_pre07 FROM g_sql
      EXECUTE sel_ofa_pre07
      IF STATUS AND noin_sw='N' THEN
         CONTINUE FOREACH
      END IF
   END IF   #MOD-590114
   FOR g_i = 1 TO 2
      CASE
          WHEN ar_sum[g_i,g_i] = '1'   #MOD-580113
            LET l_order[g_i] = sr.oga15
          WHEN ar_sum[g_i,g_i] = '2'    #MOD-580113
            LET l_order[g_i] = sr.oga14
          WHEN ar_sum[g_i,g_i] = '3'    #FUN-650198
            LET l_order[g_i] = sr.ogb31 #FUN-650198
          WHEN ar_sum[g_i,g_i] = '4'    #No.FUN-9C0014
            LET l_order[g_i] = l_azp01  #No.FUN-9C0014
          WHEN ar_sum[g_i,g_i] = '5' #FUN-C60036 add
            LET l_order[g_i] = sr.omf00 #FUN-C60036 add
         OTHERWISE
            LET l_order[g_i] = '-'
      END CASE
   END FOR
   LET sr.order1 = l_order[1]
   LET sr.order2 = l_order[2]
   
  # IF l_oga03 != sr.oga03 OR l_oga11 != sr.oga11 OR l_order1 != sr.order1 OR 
#No.MOD-DA0161 --begin   
   IF l_oga03 != sr.oga03  OR l_order1 != sr.order1            
            OR s_get_aznn(g_plant,g_aza.aza81,l_oga11,1) != s_get_aznn(g_plant,g_aza.aza81,sr.oga11,1) 
            OR s_get_aznn(g_plant,g_aza.aza81,l_oga11,3) != s_get_aznn(g_plant,g_aza.aza81,sr.oga11,3) OR                 
#No.MOD-DA0161 --end
      #l_order2 != sr.order2 OR l_oga05 != sr.oga05 OR l_oga18 != sr.oga18 OR #No.FUN-670026 add aga18 #.MOD-DA0161 mark
      l_order2 != sr.order2 OR l_oga18 != sr.oga18 OR #MOD-DA0161 add
      l_oga27 != sr.oga27 OR  #FUN-640191 add
      l_omf25 != sr.omf25 OR #150701wudj  #zhouxm151214 mark 
      #l_ta_omf01 ! =sr.ta_omf01 OR #add by zhaoxiangb 150722 #zhouxm151214 mark
      l_oga21 != sr.oga21 OR l_oga23 != sr.oga23 OR
      g_omf00 != sr.omf00 OR                            #FUN-C60036--minpp--add
      #g_omf01 ! = sr.omf01 OR g_omf02 ! = sr.omf02 THEN #依項目不同分別開立發票 #FUN-C60036 add omf01,omf02#.MOD-DA0161 mark
      g_omf01 ! = sr.omf01 THEN #.MOD-DA0161 add
      IF sr.type = '2' THEN                                                     
         #LET g_sql = "SELECT * FROM ",l_dbs CLIPPED,"oga_file WHERE oga01='",sr.oga01,"'"
         LET g_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                     " WHERE oga01='",sr.oga01,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102
         PREPARE sel_oga_pre08 FROM g_sql
         EXECUTE sel_oga_pre08 INTO g_oga.*
      ELSE                                                                      
         CALL p330_oha2oga(sr.oga01)                                            
      END IF   
      #FUN-C60036--add--str
      IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
         CALL p330_omf(l_azp01,sr.*)
      END IF 
      #FUN-C60036--add--end
     #FUN-CB0057 add-str
      IF g_aza.aza26 = '2' AND g_oaz92 = 'Y' THEN
         LET g_oma.oma76 = sr.omf00
      END IF     
     #FUN-CB0057 add--end
     LET g_oma.omaud02=sr.omf25 #150701wudj #zhouxm151218 mark
     LET g_oma.ta_oma01 = sr.ta_omf01  #add by zhaoxiangb 150722
      CALL p330_g_oma()
      #FUN-C60036 --add--str
      LET g_omf00 = sr.omf00  #minpp--add
      LET g_omf01 = sr.omf01
      LET g_omf02 = sr.omf02
      #FUN-C60036--add--end
      LET g_omb.omb03 = 0
      LET l_oma66_t = g_oma.oma66
      LET l_oma01_t = g_oma.oma01
      #FUN-CA0084--add--str
            IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
               LET g_sql = "SELECT omf09 FROM omf_file ",
                           "  WHERE omf00 = '",sr.omf00,"'"
               PREPARE p330_prepare_omf09 FROM g_sql
               DECLARE p330_omf09_cs CURSOR FOR p330_prepare_omf09
               FOREACH p330_omf09_cs INTO l_omf09
                  IF l_omf09_1 <> l_omf09 AND NOT cl_null(l_omf09) THEN
                     UPDATE oma_file SET oma66 = ''
                      WHERE oma01 = l_oma01_t
                     IF SQLCA.sqlcode THEN
                        CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma66,SQLCA.sqlcode,"","",1)
                        LET g_success ='N'
                     END IF
                     EXIT FOREACH
                  END IF
                  LET l_omf09_1 = l_omf09
                  UPDATE oma_file SET oma66 = l_omf09_1
                   WHERE oma01 = l_oma01_t
                  IF SQLCA.sqlcode THEN
                     CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma66,SQLCA.sqlcode,"","",1)
                     LET g_success ='N'
                  END IF
               END FOREACH

            END IF
            #FUN-CA0084--add--end
   ELSE
      IF sr.ogaplant <> l_oma66_t THEN
         UPDATE oma_file SET oma66 = ''
          WHERE oma01 = l_oma01_t
         IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma66,SQLCA.sqlcode,"","",1)
            LET g_success ='N'
         END IF
      END IF
      #FUN-CA0084--add--str
            IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
               LET g_sql = "SELECT omf09 FROM omf_file ",
                           "  WHERE omf00 = '",sr.omf00,"'"
               PREPARE p330_prepare_omf09_1 FROM g_sql             
               DECLARE p330_omf09_cs_1 CURSOR FOR p330_prepare_omf09_1
               FOREACH p330_omf09_cs_1 INTO l_omf09
                  IF l_omf09_1 <> l_omf09 AND NOT cl_null(l_omf09) THEN
                     UPDATE oma_file SET oma66 = ''
                      WHERE oma01 = l_oma01_t
                     IF SQLCA.sqlcode THEN
                        CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma66,SQLCA.sqlcode,"","",1)
                        LET g_success ='N'
                     END IF
                     EXIT FOREACH
                  END IF 
                  LET l_omf09_1 = l_omf09
                  UPDATE oma_file SET oma66 = l_omf09_1
                   WHERE oma01 = l_oma01_t
                  IF SQLCA.sqlcode THEN
                     CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma66,SQLCA.sqlcode,"","",1)
                     LET g_success ='N'
                  END IF
               END FOREACH
               
            END IF 
            #FUN-CA0084--add--end
   END IF  

   SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip = g_no1
  
   LET l_wc2 = ' '     #MOD-BA0159
   IF sr.type = '2' THEN     
      #-MOD-BA0159-add-
       IF tm2.s1 = '3' OR tm2.s2 = '3' THEN
          LET l_wc2 = " AND ogb31 = '",sr.ogb31,"'"
       END IF
      #-MOD-BA0159-end-
      #LET g_sql = "SELECT ogb03 FROM ",l_dbs CLIPPED,"ogb_file ",
      LET g_sql = "SELECT ogb03 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                 #" WHERE ogb01 =  '",sr.oga01,"'"         #MOD-BA0159 mark
                  " WHERE ogb01 =  '",sr.oga01,"'",l_wc2   #MOD-BA0159
      #FUN-C60036--add--str
      IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
         LET g_sql = g_sql CLIPPED ,
                    "   AND ogb03 IN ( SELECT omf12 FROM omf_file ",
                                   " WHERE omf08 = 'Y'  ",
                                   "   AND omf04 IS NULL ",
                                   "   AND omf09 = '",l_azp01,"'",
                                   "    AND omf00 = '",g_omf00,"'",     #FUN-C60036--minpp
                                   "    AND omf01 = '",g_omf01,"'",
                                   "    AND omf02 = '",g_omf02,"'",
                                   "    AND omf11 = '",sr.oga01,"'",
                                   "    AND omf10 = '1' "
                                   ,"   and omf25 = '",sr.omf25,"' "  #add by dengsy160506
        IF g_oaz93 = 'Y' THEN LET g_sql = g_sql CLIPPED," AND omfpost = 'Y' "END IF 
        LET g_sql = g_sql CLIPPED," )"
      END IF 
      #FUN-C60036--add--end
   ELSE                                                                         
      #-MOD-BA0159-add-
       IF tm2.s1 = '3' OR tm2.s2 = '3' THEN
          LET l_wc2 = " AND ohb33 = '",sr.ogb31,"'"
       END IF
      #-MOD-BA0159-end-
      #LET g_sql = "SELECT ohb03 FROM ",l_dbs CLIPPED,"ohb_file ",
      LET g_sql = "SELECT ohb03 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                 #" WHERE ohb01 =  '",sr.oga01,"'"        #MOD-BA0159 mark
                  " WHERE ohb01 =  '",sr.oga01,"'",l_wc2  #MOD-BA0159
      #FUN-C60036--add--str
      IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
         LET g_sql = g_sql CLIPPED ,
                    "   AND ohb03 IN ( SELECT omf12 FROM omf_file ",
                                   " WHERE omf08 = 'Y'  ",
                                   "   AND omf04 IS NULL ",
                                   "   AND omf09 = '",l_azp01,"'",
                                   "    AND omf00 = '",g_omf00,"'",     #FUN-C60036--minpp
                                   "    AND omf01 = '",g_omf01,"'",
                                   "    AND omf02 = '",g_omf02,"'",
                                   "    AND omf11 = '",sr.oga01,"'",
                                   "    AND omf10 = '2' "
                                   ,"   and omf25 = '",sr.omf25,"' "  #add by dengsy160506
         IF g_oaz93 = 'Y'   THEN LET g_sql = g_sql CLIPPED," AND omfpost = 'Y' "END IF 
         LET g_sql = g_sql CLIPPED," )"
      END IF 
      #FUN-C60036--add--end
   END IF 
   IF ls_n > 0 AND g_oaz92 = 'Y' THEN 
      LET g_sql = "SELECT omf21 FROM omf_file ",
                     " WHERE omf08 = 'Y'  ",
                     "   AND omf04 IS NULL ",
                   # "   AND omf09 = '",l_azp01,"'",#FUN-CA0084 mark
                     "    AND omf00 = '",g_omf00,"'",
                     "    AND omf01 = '",g_omf01,"'",
                     "    AND omf02 = '",g_omf02,"'",
                     "    AND omf25 = '",sr.omf25,"'", #zhouxm151218 add                   
                     "    AND omf11 = '",sr.oga01,"'"
   END IF 
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102   
   PREPARE p330_prepare_ogb FROM g_sql                                          
   DECLARE p330_ogb_cs CURSOR FOR p330_prepare_ogb                              
   FOREACH p330_ogb_cs INTO l_ogb03                                             
     IF STATUS THEN
        CALL s_errmsg('ogb01','sr.oga01','foreach ogb',STATUS,0)        #NO.FUN-710050
        EXIT FOREACH 
     END IF
     IF NOT cl_null(sr.oga01) THEN 
     IF sr.type = '2' THEN
        #LET g_sql = "SELECT * FROM ",l_dbs CLIPPED,"ogb_file",
        #FUN-C60036--add--str
        IF ls_n > 0 AND g_oaz92 = 'Y' THEN
           LET g_omf21 = l_ogb03
           SELECT omf12 INTO l_ogb03 FROM omf_file 
            WHERE omf00 = g_omf00
              AND omf21 = g_omf21
        END IF 
        #FUN-C60036 add--end
        LET g_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                    " WHERE ogb01 = '",sr.oga01,"' AND ogb03 = '",l_ogb03,"'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
        PREPARE sel_ogb_pre09 FROM g_sql
        EXECUTE sel_ogb_pre09 INTO g_ogb.*
        #FUN-C60036--add--str
        SELECT omf28,omf917,omf29,omf29t,omf21 INTO 
            g_ogb.ogb13,g_ogb.ogb917,g_ogb.ogb14,g_ogb.ogb14t,g_omf21 FROM omf_file
        WHERE omf08 = 'Y'  
          AND omf04 IS NULL 
          AND omf09 = l_azp01
          AND omf00 = g_omf00    ##minpp--add
          AND omf01 = g_omf01
          AND omf02 = g_omf02
          AND omf12 = l_ogb03
          AND omf11 = sr.oga01
          AND omf10 = '1' 
        #FUN-C60036--add--end
     ELSE
        #FUN-C60036--add--str
        IF ls_n > 0 AND g_oaz92 = 'Y' THEN
           LET g_omf21 = l_ogb03
           SELECT omf12 INTO l_ogb03 FROM omf_file
            WHERE omf00 = g_omf00
              AND omf21 = g_omf21
        END IF
        #FUN-C60036 add--end
        CALL p330_ohb2ogb(sr.oga01,l_ogb03)  
        #FUN-C60036--add--str
        SELECT omf28,omf917,omf29,omf29t,omf21 INTO 
            g_ogb.ogb13,g_ogb.ogb917,g_ogb.ogb14,g_ogb.ogb14t,g_omf21 FROM omf_file
        WHERE omf08 = 'Y'  
          AND omf04 IS NULL 
          AND omf09 = l_azp01
          AND omf00 = g_omf00    ##minpp--add
          AND omf01 = g_omf01
          AND omf02 = g_omf02
          AND omf12 = l_ogb03
          AND omf11 = sr.oga01
          AND omf10 = '2' 
        #FUN-C60036--add--end
     END IF                                                                     
     LET l_ogb03 = g_omf21
     END IF 
     #FUN-C60036 -add--str
     LET g_omf21 = l_ogb03
     SELECT oaz92 INTO g_oaz.oaz92 FROM oaz_file
     IF ls_n  > 0 AND  cl_null(sr.oga01) AND g_oaz.oaz92 = 'Y' THEN
        INITIALIZE g_ogb.* TO NULL
      
        SELECT omf11,omf12,omf13,omf916,omf14,' ',omf917,0,0,omf28,omf29,omf29t,' ',' ',' ',omf09
          INTO g_ogb.ogb01,g_ogb.ogb03,g_ogb.ogb04,g_ogb.ogb916,g_ogb.ogb06,g_ogb.ogb1001,g_ogb.ogb917,
               g_ogb.ogb47,g_ogb.ogb12,g_ogb.ogb13,g_ogb.ogb14,g_ogb.ogb14t,g_ogb.ogb41,g_ogb.ogb42,g_ogb.ogb930,
               g_ogb.ogbplant
          FROM omf_file
         WHERE omf00 = g_omf00
           AND omf21 = l_ogb03
        LET g_ogb.ogb1005 = '0'
  
     END IF 
     #FUN-C60036--add--end
    #---------------------------MOD-C60076---------------------------mark
    ##CHI-A50023 add --start--
    #IF sr.type = '2' THEN
    #   IF g_enter_account = 'N' THEN
    #     #FUN-A60056--mod--str--
    #     #SELECT COUNT(*) INTO g_cnt FROM ogb_file
    #     #   WHERE ogb01=sr.oga01 AND ogb13<>0 AND ogb03=g_ogb.ogb03
    #      LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_azp01,'ogb_file'),
    #                  " WHERE ogb01='",sr.oga01,"' AND ogb13<>0 ",
    #                  "   AND ogb03='",g_ogb.ogb03,"'"
    #      CALL cl_replace_sqldb(g_sql) RETURNING g_sql
    #      CALL cl_parse_qry_sql(g_sql,l_azp01) RETURNING g_sql
    #      PREPARE sel_cou_ogb FROM g_sql
    #      EXECUTE sel_cou_ogb INTO g_cnt
    #     #FUN-A60056--mod--end
    #      IF g_cnt=0 THEN
    #         CONTINUE FOREACH
    #      END IF
    #   END IF
    #ELSE
    #   IF g_enter_account = 'N' THEN
    #     #FUN-A60056--mod--str--
    #     #SELECT COUNT(*) INTO g_cnt FROM ohb_file
    #     #   WHERE ohb01=sr.oga01 AND ohb13<>0 AND ohb03=g_ogb.ogb03
    #      LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(l_azp01,'ohb_file'),
    #                  " WHERE ohb01='",sr.oga01,"' AND ohb13<>0",
    #                  "   AND ohb03='",g_ogb.ogb03,"'"
    #      CALL cl_replace_sqldb(g_sql) RETURNING g_sql
    #      CALL cl_parse_qry_sql(g_sql,l_azp01) RETURNING g_sql
    #      PREPARE sel_cou_ohb FROM g_sql
    #      EXECUTE sel_cou_ohb INTO g_cnt
    #     #FUN-A60056--mod--end
    #      IF g_cnt=0 THEN
    #         CONTINUE FOREACH
    #      END IF
    #   END IF
    #END IF
    ##CHI-A50023 add --end--
    #---------------------------MOD-C60076---------------------------mark
  
     SELECT SUM(ABS(omb12)) INTO l_used FROM omb_file,oma_file                  
      WHERE omb31= g_ogb.ogb01                                                  
        AND omb32= g_ogb.ogb03                                                  
        AND oma01= omb01                                                        
        AND omavoid='N'                                                         

     IF cl_null(l_used) THEN
        LET l_used = 0
     END IF
     IF g_oaz92 != 'Y' AND g_aza.aza26 != '2' THEN #FUN-C60036
     LET g_ogb.ogb917 = g_ogb.ogb917 - g_ogb.ogb64 - l_used     #去掉已用量
     IF g_oga.oga94 = 'N' THEN      #MOD-B90218
        IF g_ogb.ogb917 <= 0 AND l_oha09 <> '5' THEN   #No.MOD-B10206
           CONTINUE FOREACH
        END IF
     END IF                         #MOD-B90218
     END IF #FUN-C60036
     LET g_omb.omb03 = g_omb.omb03 + 1
    #FUN-960141 modify 只有當沒有直接收款時才需要考慮 
#    IF l_sum <= 0 THEN  #MOD-AA0156
     IF l_sum <= 0 OR g_occ73 <> 'Y' THEN  #MOD-AA0156
        IF (g_oma.oma08 = '1' AND g_omb.omb03 > g_ooz.ooz121) OR
           (g_oma.oma08 = '2' AND g_omb.omb03 > g_ooz.ooz122) THEN
           #CALL p330_g_bu()                                          #TQC-BA0172 mark 
           #FUN-C60036--add--str
            IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
               CALL p330_omf(l_azp01,sr.*)
            END IF 
            #FUN-C60036--add--end
           #CALL saxrp310_bu(g_oma.*,g_ogb.*,'','') RETURNING g_oma.* #TQC-BA0172      #CHI-CB0016 mark
            
           #FUN-CB0057 add-str
            IF g_aza.aza26 = '2' AND g_oaz92 = 'Y' THEN
               LET g_oma.oma76 = sr.omf00
            END IF
           #FUN-CB0057 add--end
            CALL p330_g_oma()
            #FUN-C60036 --add--str
            LET g_omf00 = sr.omf00      #minpp add
            LET g_omf01 = sr.omf01
            LET g_omf02 = sr.omf02
            #FUN-C60036--add--end
            LET g_omb.omb03 = 1
        END IF
     END IF
     LET l_qty = 0
     IF g_ogb.ogb1005 != '2' THEN                #對于出貨和返利分別處理
        CALL p330_g_omb(l_qty) 
        RETURNING l_flag,l_qty
     ELSE
        CALL p330_g_omb_1() 
     END IF 
 
     #FUN-B10058--add--str--
     IF g_oga.oga57 = '2' THEN
        SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip = g_no2
     END IF 
     #FUN-B10058--add--end
     WHILE TRUE           #MOD-540136
   # IF l_sum <= 0 AND g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' AND l_flag = 'Y' AND l_qty > 0 THEN   #TQC-6B0003  #FUN-960141 #MOD-AA0156
     IF (l_sum <= 0 OR g_occ73<>'Y')  #MOD-AA0156
        AND g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' AND l_flag = 'Y' AND l_qty > 0 THEN   #TQC-6B0003  #FUN-960141 #MOD-AA0156
       #CALL p330_g_bu()                                          #TQC-BA0172 mark 
        #FUN-C60036--add--str
         IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
            CALL p330_omf(l_azp01,sr.*)
         END IF 
        #FUN-C60036--add--end
       #CALL saxrp310_bu(g_oma.*,g_ogb.*,'','') RETURNING g_oma.* #TQC-BA0172      #CHI-CB0016 mark
       #FUN-CB0057 add-str
        IF g_aza.aza26 = '2' AND g_oaz92 = 'Y' THEN
           LET g_oma.oma76 = sr.omf00
        END IF
       #FUN-CB0057 add--end
        CALL p330_g_oma()
        LET g_omf00 = sr.omf00 #FUN-C60036-minpp
        LET g_omf01 = sr.omf01 #FUN-C60036
        LET g_omf02 = sr.omf02 #FUN-C60036
        LET g_omb.omb03 = 1
        CALL p330_g_omb(l_qty) RETURNING l_flag,l_qty  #FUN-960141 
       ELSE          #MOD-540136
        EXIT WHILE   #MOD-540136  
     END IF
     END WHILE          #MOD-540136
 
   END FOREACH
  #--------------------------------No.MOD-BB0246------------------------start
  #SELECT DISTINCT COUNT(omb31) INTO l_cnt     #TQC-C40071 mark
   SELECT COUNT(DISTINCT(omb31)) INTO l_cnt    #TQC-C40071 add
     FROM omb_file
    WHERE omb01=g_oma.oma01
   IF l_cnt >1 THEN
      UPDATE oma_file SET oma16=' '
      WHERE oma01=g_oma.oma01
   END IF
  #--------------------------------No.MOD-BB0246--------------------------end
    #LET g_sql = "SELECT * FROM ",l_dbs CLIPPED,"ofa_file,",l_dbs CLIPPED,"ofb_file",
     LET g_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ofa_file'),",", #FUN-A50102
                                  cl_get_target_table(g_plant_new,'ofb_file'),     #FUN-A50102
                 " WHERE ofa011= '",sr.oga011,"'",
                 "   AND ofa01 = ofb01",
                 "   AND ofb31 IS NULL",
                 "   AND ofaconf='Y'"
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
     PREPARE sel_ofb_pre10 FROM g_sql
     DECLARE p330_ofb_cs CURSOR FOR sel_ofb_pre10

     FOREACH p330_ofb_cs INTO g_ofb.*
       IF STATUS THEN 
          CALL s_errmsg('','','foreach ofb',STATUS,0)   #NO.FUN-710050
          EXIT FOREACH 
       END IF
       LET g_omb.omb03 = g_omb.omb03 + 1
       CALL p330_122_omb()
     END FOREACH
    #CALL p330_g_bu()                                          #TQC-BA0172 mark 
    #CALL saxrp310_bu(g_oma.*,g_ogb.*,'','') RETURNING g_oma.* #TQC-BA0172      #CHI-CB0016 mark
     LET l_oga03 = sr.oga03
     LET l_oga18 = sr.oga18                      #No.FUN-670026
     LET l_oga05 = sr.oga05
     LET l_oga21 = sr.oga21
     LET l_oga23 = sr.oga23
     LET l_oga27 = sr.oga27 #FUN-640191
     LET l_omf25 = sr.omf25 #add muping151217
     LET l_oga11 = sr.oga11
     LET l_order1 = sr.order1
     LET l_order2 = sr.order2
     LET l_ogaplant = sr.ogaplant  #FUN-960141 add
  
   END FOREACH
   IF g_totsuccess="N" THEN                                                                                                         
      LET g_success="N"                                                                                                             
   END IF 
 
   IF begin_no IS NULL THEN
      LET begin_no = g_start
   END IF
   IF cl_null(g_start1) AND NOT cl_null(g_start) THEN
      LET g_start1 = g_start
   END IF
  END FOREACH     #No.FUN-9C0014 Add
 
   LET begin_no = ''                              #MOD-AA0141
   LET l_end = ''                                 #MOD-AA0141
  #-CHI-CB0016-add-
   LET g_sql = "SELECT ogb31 ",
               "  FROM oma_file,omb_file,",cl_get_target_table(g_plant_new,'ogb_file'),
               " WHERE oma01 = ? ",
               "   AND oma01 = omb01 ",
               "   AND omb31 = ogb01 ",
               "   AND omb32 = ogb03 "
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE p330_oea_p FROM g_sql
   DECLARE p330_oeac SCROLL CURSOR FOR p330_oea_p
  #-CHI-CB0016-end-
  #生成分錄底稿
   DECLARE p330_cs01 CURSOR FOR
   # SELECT * FROM oma_file WHERE oma01 BETWEEN begin_no AND g_end #No.FUN-9C0014
     SELECT * FROM oma_file WHERE oma01 BETWEEN g_start1 AND g_end #No.FUN-9C0014
   FOREACH p330_cs01 INTO g_oma.*
     IF STATUS THEN
        EXIT FOREACH
     END IF
    # CALL p330_omc()               #TQC-CB0041 add   #MOD-D60123 mark
     #-MOD-B70094-add-
      IF g_oma.oma02 < g_ooz.ooz09 THEN
         CALL cl_err(g_oma.oma02,'axr-164',1)
         LET g_success = 'N'
         EXIT FOREACH
      END IF 
     #-MOD-B70094-end-
     IF g_oma.oma54 < 0 THEN                                                    
        CALL s_errmsg('oma01',g_oma.oma01,'','axr-899',1)                       
        LET g_success = 'N'                                                     
        EXIT FOREACH                                                            
     END IF                                                                     
     SELECT COUNT(*) INTO l_n FROM omb_file WHERE omb01=g_oma.oma01
     IF l_n=0 THEN
        DELETE FROM omc_file WHERE omc01=g_oma.oma01
        DELETE FROM oma_file WHERE oma01=g_oma.oma01
        CONTINUE FOREACH
     END IF
    #-MOD-AA0141-add-
     IF cl_null(begin_no) THEN
        LET begin_no = g_oma.oma01
     END IF
     LET l_end = g_oma.oma01
    #-MOD-AA0141-end-
    #-CHI-CB0016-add-
     OPEN p330_oeac USING g_oma.oma01
     FETCH FIRST p330_oeac INTO l_oea01
     CLOSE p330_oeac
     #INITIALIZE g_ogb.* TO NULL  #yinhy131217 mark
     CALL saxrp310_bu(g_oma.*,g_ogb.*,l_oea01,'') RETURNING g_oma.*
     INITIALIZE g_ogb.* TO NULL  #yinhy131217
     #FUN-D90048---add---str--
     #IF g_oma.oma54 <=0 OR g_oma.oma56 <= 0 THEN     #yinhy131216 mark
	 #zhouxm151231 mark start 
     #IF g_oma.oma54 <=0 OR g_oma.oma56 <= 0 OR g_oma.oma54t<0 OR g_oma.oma56<0 THEN  #yinhy131216
     #   DECLARE p330_err CURSOR FOR
     #      SELECT UNIQUE omb31 FROM omb_file,oma_file WHERE oma01 = omb01
     #       AND oma01 = g_oma.oma01 ORDER BY oma01
     #   LET l_msg = NULL
     #   FOREACH p330_err INTO l_omb31
     #      IF STATUS THEN
     #         EXIT FOREACH
     #      END IF
     #      IF l_msg IS NULL THEN
     #         LET l_msg = l_omb31
     #      ELSE
     #         LET l_msg = l_msg,'|',l_omb31
     #      END IF
     #   END FOREACH
     #   CALL s_errmsg('oga01|oha01',l_msg,'','axr-899',1)
     #   LET g_success = 'N'
     #END IF
	 #zhouxm151231 mark start 
     #FUN-D90048---add---end--
     CALL p330_omc()   #MOD-D60123
    #-CHI-CB0016-end-
     #FUN-960141 add begin  產生直接收款 
    #No.FUN-9C0014 -BEGIN-----
     DECLARE omb_cs2 CURSOR FROM
      "SELECT DISTINCT omb31,omb44 FROM omb_file WHERE omb01=?"
    #No.FUN-9C0014 -END-------
     FOREACH omb_cs2 USING g_oma.oma01 INTO g_omb.omb31,g_omb.omb44  #No.FUN-9C0014
        IF STATUS THEN
           CALL s_errmsg('ogb01','sr.oga01','foreach ogb',STATUS,0)
           LET g_success = 'N'
        END IF 
       #No.FUN-9C0014 -BEGIN-----
        IF cl_null(g_omb.omb44) THEN
           LET g_plant_new = g_plant
        ELSE
           LET g_plant_new = g_omb.omb44
        END IF
        CALL s_gettrandbs()
        LET l_dbs = g_dbs_tra
       #No.FUN-9C0014 -END-------
        #LET g_sql = "SELECT SUM(rxx04) FROM ",l_dbs CLIPPED,"rxx_file",
        LET g_sql = "SELECT SUM(rxx04) FROM ",cl_get_target_table(g_plant_new,'rxx_file'), #FUN-A50102
                    " WHERE rxx01 = '",g_omb.omb31,"'",
                    "   AND rxx00 = '02'",
                    "   AND rxx03 = '1'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
        PREPARE sel_rxx_pre11 FROM g_sql
        EXECUTE sel_rxx_pre11 INTO l_rxx04
      # IF cl_null(l_rxx04) OR l_rxx04 = 0 THEN  #沒有直接收款  #MOD-AA0156
        IF cl_null(l_rxx04) OR l_rxx04 = 0 OR g_occ73 <> 'Y' THEN   #MOD-AA0156
        ELSE
        #  CALL s_ins_w(g_oma.oma00,g_omb.omb31,g_oma.oma01,'1',l_dbs) RETURNING g_success #No.FUN-9C0014 #No.FUN-A10104
           CALL s_ins_w(g_oma.oma00,g_omb.omb31,g_oma.oma01,'1',g_omb.omb44) RETURNING g_success #No.FUN-A10104
        END IF    #FUN-9C0002
        IF g_success = 'N' THEN
           EXIT FOREACH
        END IF
     END FOREACH
    #No.FUN-9C0014 -BEGIN-----
    #LET g_sql = "SELECT SUM(rxx04) FROM ",l_dbs CLIPPED,"rxx_file",
    #            " WHERE rxx01 = '",g_omb.omb31,"'",
    #            "   AND rxx00 = '02'",
    #            "   AND rxxplant = '",g_oma.oma66,"'"
    #PREPARE sel_rxx_pre12 FROM g_sql
    #EXECUTE sel_rxx_pre12 INTO l_sum
    #IF cl_null(l_sum) THEN LET l_sum = 0 END IF
     FOREACH omb_cs2 USING g_oma.oma01 INTO g_omb.omb31,g_omb.omb44
        IF STATUS THEN
           CALL s_errmsg('ogb01','sr.oga01','foreach ogb',STATUS,0)
           LET g_success = 'N'
        END IF

        IF cl_null(g_omb.omb44) THEN
           LET g_plant_new = g_plant
        ELSE
           LET g_plant_new = g_omb.omb44
        END IF
        CALL s_gettrandbs()
        LET l_dbs = g_dbs_tra
        #LET g_sql = "SELECT SUM(rxx04) FROM ",l_dbs CLIPPED,"rxx_file",
        LET g_sql = "SELECT SUM(rxx04) FROM ",cl_get_target_table(g_plant_new,'rxx_file'), #FUN-A50102
                    " WHERE rxx01 = '",g_omb.omb31,"'",
                    "   AND rxx00 = '02'",
                    "   AND rxxplant = '",g_omb.omb44,"'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
        PREPARE sel_rxx_pre50 FROM g_sql
        EXECUTE sel_rxx_pre50 INTO l_sum1
        IF cl_null(l_sum) THEN LET l_sum = 0 END IF
        LET l_sum = l_sum + l_sum1
     END FOREACH
    #No.FUN-9C0014 -END-------
    #FUN-B10058--add--str--
     IF g_oga.oga57 = '2' THEN
        SELECT * INTO g_ooy.* FROM ooy_file WHERE ooyslip = g_no2
     END IF
    #FUN-B10058--add--end
     SELECT oma65 INTO g_oma.oma65 FROM oma_file WHERE oma01 = g_oma.oma01 #FUN-B40005 ADD 
   # IF l_sum > 0 THEN  #表示產生了oob_file  #MOD-AA0156
     #IF l_sum > 0 AND g_occ73 = 'Y' THEN   #MOD-AA0156          #MOD-C70289
     IF l_sum > 0 AND g_occ73 = 'Y' AND g_azw.azw04 <> '2' THEN  #MOD-C70289
       #No.TQC-C20565   ---start---   Mark
       #IF g_ooy.ooyconf='Y' THEN
       #   IF NOT (g_ooz.ooz13='1') THEN
       #      LET g_oma.oma65 = 1
       #   END IF 
       #ELSE
       #   LET g_oma.oma65 = 1
       #END IF
       #No.TQC-C20565   ---end---     Mark
        LET g_oma.oma65 = 2   #No.TQC-C20565   Add
        UPDATE oma_file SET oma65 = g_oma.oma65
         WHERE oma01 = g_oma.oma01
        IF SQLCA.sqlcode THEN  
           CALL cl_err3("upd","oma_file",g_oma.oma01,g_oma.oma65,SQLCA.sqlcode,"","",1)
           LET g_success ='N'
        END IF
        IF g_oma.oma65 = 1 THEN
           UPDATE oob_file SET oob09 = 0,
                               oob10 = 0 
            WHERE oob01 = g_oma.oma01
           UPDATE ooa_file SET ooa31d = 0,
                               ooa31c = 0,
                               ooa32d = 0,
                               ooa32c = 0
            WHERE ooa01 = g_oma.oma01
        END IF  
        IF g_success = 'N' THEN EXIT FOREACH END IF 
     END IF
     IF g_oma.oma65 != '2' THEN  #FUN-960141 add
        IF g_ooy.ooydmy1='Y' THEN 
           CALL s_t300_gl(g_oma.oma01,'0')
           IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
              CALL s_t300_gl(g_oma.oma01,'1')
           END IF
        END IF
     ELSE
        IF g_ooy.ooydmy1='Y' AND g_success='Y' THEN
           CALL s_t300_rgl(g_oma.oma01,'0')
           IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
              CALL s_t300_rgl(g_oma.oma01,'1')
           END IF
        END IF
     END IF
     CALL s_get_bookno(YEAR(g_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
     IF g_flag =  '1' THEN  
         CALL cl_err(g_oma.oma02,'aoo-081',1)
         LET g_success = 'N'
         EXIT FOREACH
     END IF
     IF g_ooy.ooyconf='Y' THEN
        IF g_ooz.ooz13='1' THEN  
           IF g_ooy.ooydmy1='Y' THEN
              CALL s_chknpq(g_oma.oma01,'AR',1,'0',g_bookno1) 
              IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
                 CALL s_chknpq(g_oma.oma01,'AR',1,'1',g_bookno2) 
              END IF
              IF g_success='N' THEN
                 EXIT FOREACH
              END IF
           END IF
          #IF l_sum > 0 THEN  #MOD-AA0156
           IF l_sum > 0 AND g_occ73 = 'Y' THEN  #MOD-AA0156
              CALL s_t300_confirm(g_oma.oma01,'') #No.FUN-9C0014
           END IF
           IF g_success = 'N' THEN EXIT FOREACH END IF 
           CALL s_ar_conf('y',g_oma.oma01,'') RETURNING i #No.FUN-9C0014
           IF i THEN
              LET g_success='N'
              EXIT FOREACH
           END IF
           CALL s_t300_w1('+',g_oma.oma01)         #FUN-AC0027
        END IF                  
     END IF

    IF g_oaz92 != 'Y' AND g_aza.aza26 != '2' THEN #FUN-C60036 add  MOD-D90014 mark  #zhouxm151103 add
        CALL s_up_omb(g_oma.oma01)  #MOD-AB0006 
     END IF #FUN-C60036 add MOD-D90014 mark  #zhouxm151103 add
   END FOREACH
   LET g_start1 = begin_no     #MOD-AA0141
   LET g_end = l_end           #MOD-AA0141

   IF g_bgjob = "N" THEN       #No.FUN-570156
      MESSAGE   'AR NO. from ',g_start1,' to ',g_end   #No.FUN-9C0014
      CALL ui.Interface.refresh() 
   END IF
   IF cl_null(g_start1) THEN    #No.FUN-9C0014
      CALL cl_err('','aap-129',1)               #MOD-A80024
      LET g_success = "N"       #批次作業失敗
   END IF
END FUNCTION
 
FUNCTION p330_g_oma()
   DEFINE li_result LIKE type_file.num5          #No.FUN-680123 SMALLINT    #No.FUN-550071
   DEFINE l_oma24   LIKE oma_file.oma24 #FUN-C60036 add 
 
   CALL p330_g_oma_default()
   #--- 輸入單別並自動編號
   #FUN-B10057--add--str--
   IF g_oga.oga57 = '2' THEN 
      CALL s_auto_assign_no("axr",g_no2,g_date,"19","","","","","")
           RETURNING li_result,g_oma.oma01
   ELSE 
   #FUN-B10058--add--end
      CALL  s_auto_assign_no("axr",g_no1,g_date,"12","","","","","")
            RETURNING li_result,g_oma.oma01
   END IF   #FUN-B10058
   IF (NOT li_result) THEN
         LET g_success = 'N'
   END IF
   LET g_oma.oma03 = g_oga.oga03 LET g_oma.oma032= g_oga.oga032
   LET g_oma.oma04 = g_oga.oga03
   #LET g_sql = "SELECT occ11,occ18,occ231 FROM ",l_dbs CLIPPED,"occ_file",
   LET g_sql = "SELECT occ11,occ18,occ231 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
               " WHERE occ01='",g_oma.oma04,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
   PREPARE sel_occ_pre13 FROM g_sql
   EXECUTE sel_occ_pre13 INTO g_oma.oma042,g_oma.oma043,g_oma.oma044
   LET g_oma.oma08 = g_oga.oga08
   LET g_oma.oma05 = g_oga.oga05
   IF g_oma05 IS NOT NULL THEN LET g_oma.oma05 = g_oma05 END IF
   LET g_oma.oma07 = g_oga.oga07
   LET g_oma.oma13 = g_oga.oga13
   #No.MOD-C40096  --Begin
   IF cl_null(g_oma.oma13) THEN   
      LET g_sql = "SELECT occ67 FROM ",cl_get_target_table(g_plant_new,'occ_file'),
                  " WHERE occ01='",g_oma.oma04,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql     
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  
      PREPARE sel_occ_pre67 FROM g_sql
      EXECUTE sel_occ_pre67 INTO g_oma.oma13
   END IF
   #No.MOD-C40096  --End
   IF cl_null(g_oma.oma13) THEN   #抓取參數預設值 NO:0873
      SELECT ooz08 INTO g_oma.oma13 FROM ooz_file 
       WHERE ooz00='0'
   END IF
   LET g_oma.oma14 = g_oga.oga14 LET g_oma.oma15 = g_oga.oga15
   LET g_oma.oma16 = g_oga.oga01   #MOD-8A0053 add
   IF NOT cl_null(g_oga.oga161) THEN   #MOD-D50119
      LET g_oma.oma161= g_oga.oga161
   END IF                              #MOD-D50119 
   IF NOT cl_null(g_oga.oga162) THEN   #MOD-D50119
      LET g_oma.oma162= g_oga.oga162
   END IF                              #MOD-D50119
   IF NOT cl_null(g_oga.oga163) THEN   #MOD-D50119
      LET g_oma.oma163= g_oga.oga163
   END IF                              #MOD-D50119
   SELECT ool11 INTO g_oma.oma18 FROM ool_file WHERE ool01=g_oma.oma13
   IF g_aza.aza63 = 'Y' THEN
      SELECT ool111 INTO g_oma.oma181 FROM ool_file WHERE ool01=g_oma.oma13
   END IF
   IF g_oma.oma161 > 0 THEN
      #SELECT oma19 INTO g_oma.oma19 FROM oma_file  #MOD-DA0056
      SELECT oma16 INTO g_oma.oma19 FROM oma_file   #MOD-DA0056
       WHERE oma16=g_oga.oga16 AND oma00='11'    #No.MOD-890155
   END IF
   LET g_oma.oma21 = g_oga.oga21
   SELECT gec08,gec06 INTO g_oma.oma171,g_oma.oma172
     FROM gec_file
      WHERE gec01=g_oma.oma21 AND gec011='2'
   LET g_oma.oma211= g_oga.oga211 LET g_oma.oma212= g_oga.oga212
   LET g_oma.oma213= g_oga.oga213 LET g_oma.oma23 = g_oga.oga23
   #LET g_sql = "SELECT oga021 FROM ",l_dbs CLIPPED,"oga_file ",
   LET g_sql = "SELECT oga021 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
               " WHERE oga01='",g_oga.oga01,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102              
   PREPARE sel_oga_pre14 FROM g_sql
   EXECUTE sel_oga_pre14 INTO g_oga021
   IF SQLCA.sqlcode THEN
      LET g_oga021=NULL
   END IF
 
   LET l_oma24 = g_oma.oma24 #FUN-C60036 add
   IF g_oma.oma23 = g_aza.aza17 THEN 
      LET g_oma.oma24 = 1
      LET g_oma.oma58 = 1
   ELSE 
      IF g_oma.oma08='1' THEN
         LET exT=g_ooz.ooz17 
      ELSE 
         LET exT=g_ooz.ooz63 
      END IF
      #FUN-640029...............begin #若出貨單有結關日,則抓結關日的匯率,否則抓立帳日的匯率
      IF (NOT cl_null(g_oga021)) AND (g_oga021>0) THEN
         CALL s_curr3(g_oma.oma23,g_oga021,exT) RETURNING g_oma.oma24
      ELSE
         CALL s_curr3(g_oma.oma23,g_oma.oma02,exT) RETURNING g_oma.oma24
      END IF

      CALL s_curr3(g_oma.oma23,g_oma.oma09,exT) RETURNING g_oma.oma58
      IF g_oma.oma58 IS NULL THEN
         #FUN-C60036--add--str
         IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
            LET g_oma.oma58=l_oma24
         ELSE
         #FUN-C60036--ad--end
            LET g_oma.oma58=g_oma.oma24
         END IF #FUN-C60036 add
      END IF
   END IF
   #FUN-C60036--add--str
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
      LET g_oma.oma24 = l_oma24
      LET g_oma.oma58 = l_oma24
   END IF 
   #FUN-C60036--add--end
   LET g_oma.oma60 = g_oma.oma24    #A060
   LET g_oma.oma25 = g_oga.oga25
   LET g_oma.oma26 = g_oga.oga26
   LET g_oma.oma32 = g_oga.oga32
   LET g_oma.oma11 = g_oma.oma02 LET g_oma.oma12  =g_oma.oma02
   
   IF cl_null(g_start) THEN LET g_start = g_oma.oma01 END IF
   LET g_end = g_oma.oma01
 
   CALL s_rdatem(g_oma.oma03,g_oma.oma32,g_oma.oma02,g_oma.oma09,
                 g_oma.oma02,g_plant2)  #NO.FUN-980020
                     RETURNING g_oma.oma11,g_oma.oma12
   #No.+074 010423 by linda add 外銷方式,經海關/非經海關等方式
   LET g_oma.oma35 = g_oga.oga35
   LET g_oma.oma36 = g_oga.oga36
   LET g_oma.oma37 = g_oga.oga37
   LET g_oma.oma38 = g_oga.oga38
   LET g_oma.oma39 = g_oga.oga39
   LET g_oma.oma65 = '1' #FUN-5A0124
   LET g_oma.oma67 = g_oga.oga27 #FUN-640191
 
   IF cl_null(g_oga.oga18) OR g_oga.oga18 = '' THEN   #如果出貨單中的收款客戶為空,則從客戶主檔抓取
      LET g_sql = "SELECT occ07 ",
                  #"  FROM ",l_dbs CLIPPED,"occ_file",
                  "  FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  " WHERE occ01='",g_oga.oga03,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
      PREPARE sel_occ_pre15 FROM g_sql
      EXECUTE sel_occ_pre15 INTO g_oma.oma68
   ELSE
      LET g_oma.oma68=g_oga.oga18                #出貨單中的收款客戶
   END IF
   IF NOT cl_null(g_oma.oma68) THEN         
      LET g_sql = "SELECT occ02 ",
                  #"  FROM ",l_dbs CLIPPED,"occ_file",
                  "  FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  " WHERE occ01='",g_oma.oma68,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
      PREPARE sel_occ_pre16 FROM g_sql
      EXECUTE sel_occ_pre16 INTO g_oma.oma69
   END IF
  #-MOD-AA0185-add-
   IF g_oma.oma03 = 'MISC' THEN
      LET g_oma.oma032 = g_oga.oga032
      IF NOT cl_null(g_oga.oga16) THEN
         LET g_oma.oma042 = g_oga.oga033
         LET g_sql = "SELECT occm04 ",
                     "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                     "       ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                     "       ",cl_get_target_table(g_plant_new,'occm_file'), 
                     " WHERE oga01='",g_oga.oga01,"'",
                     "   AND oga16 = oea01 AND oeaconf <> 'X' ",
                     "   AND oea01 = occm01 " 
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql              
         PREPARE sel_occm_pre FROM g_sql
         EXECUTE sel_occm_pre INTO g_oma.oma044
      ELSE
         LET g_sql = "SELECT occm02,occm04 ",
                     "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                     "       ",cl_get_target_table(g_plant_new,'ogb_file'),",", 
                     "       ",cl_get_target_table(g_plant_new,'oea_file'),",", 
                     "       ",cl_get_target_table(g_plant_new,'occm_file'), 
                     " WHERE oga01 = ogb01 ",
                     "   AND oga01='",g_oga.oga01,"' AND ogb03 = 1 ",
                     "   AND ogb31 = oea01 AND oeaconf <> 'X' ",
                     "   AND oea01 = occm01 " 
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql              
         PREPARE sel_occm_pre2 FROM g_sql
         EXECUTE sel_occm_pre2 INTO g_oma.oma042,g_oma.oma044
      END IF
   END IF
   IF g_oma.oma68 = 'MISC' THEN
      LET g_oma.oma69 = g_oga.oga032
   END IF
  #-MOD-AA0185-end-
   IF g_aaz.aaz90='Y' THEN
      #LET g_sql = "SELECT ogb930 FROM ",l_dbs CLIPPED,"ogb_file",
      LET g_sql = "SELECT ogb930 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #FUN-A50102
                  " WHERE ogb01='",g_oga.oga01,"'",
                  "   AND ogb930 IS NOT NULL",
                  " ORDER BY ogb03"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
      PREPARE sel_ogb_pre17 FROM g_sql
      DECLARE p330_g_oma_c CURSOR FOR sel_ogb_pre17
      OPEN p330_g_oma_c
      FETCH p330_g_oma_c INTO g_oma.oma930
      IF SQLCA.sqlcode THEN
         LET g_oma.oma930=NULL
      END IF
      CLOSE p330_g_oma_c
     #IF cl_null(g_oma.oma930) AND g_aza.aza26 = '2' AND g_ooz.ooz65 = 'Y' THEN         #CHI-C10018 mark
      IF cl_null(g_oma.oma930) AND g_ooz.ooz65 = 'Y' THEN                               #CHI-C10018 add
         #LET g_sql = "SELECT ohb930 FROM ",l_dbs CLIPPED,"ohb_file",
         LET g_sql = "SELECT ohb930 FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
                     " WHERE ohb01='",g_oga.oga01,"'",
                     "   AND ohb930 IS NOT NULL",
                     " ORDER BY ohb03"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
         PREPARE sel_ohb_pre18 FROM g_sql
         DECLARE p330_g_oma_c1 CURSOR FOR sel_ohb_pre18
         OPEN p330_g_oma_c1                                                     
         FETCH p330_g_oma_c1 INTO g_oma.oma930                                  
         IF SQLCA.sqlcode THEN                                                  
            LET g_oma.oma930=NULL                                               
         END IF                                                                 
         CLOSE p330_g_oma_c1                                                    
         END IF                                                                 
   END IF
   IF cl_null(g_oma.oma51) THEN
      LET g_oma.oma51 = 0
   END IF
   IF cl_null(g_oma.oma51f) THEN
      LET g_oma.oma51f = 0
   END IF
   LET g_oma.oma64 = '0'
   LET g_oma.oma66 = g_oga.ogaplant     #FUN-960141 090824 add 
   LET g_oma.omalegal = g_legal #FUN-980011 add
   LET g_oma.omaoriu = g_user      #No.FUN-980030 10/01/04
   LET g_oma.omaorig = g_grup      #No.FUN-980030 10/01/04
#FUN-AC0027 --begin--
   IF cl_null(g_oma.oma73) THEN
      LET g_oma.oma73 = 0 
   END IF 
   IF cl_null(g_oma.oma73f) THEN
      LET g_oma.oma73f = 0 
   END IF 
   LET g_oma.oma74 = g_oga.oga57
   IF cl_null(g_oma.oma74) THEN
      LET g_oma.oma74 = '1'
   END IF 
#FUN-AC0027 --end--
   #FUN-B10058--add--str--
   IF cl_null(g_no2) AND g_oga.oga57 = '2' THEN
      LET g_msg = 'g_no2 IS NULL'
      CALL s_errmsg('oga57',g_oga.oga57,g_msg,'axr-375',1)
      LET g_success = 'N'
   END IF 
  #-------------------------MOD-CC0028-----------(S)
   SELECT ooyapr INTO g_oma.omamksg FROM ooy_file
    WHERE ooyslip = g_no1
  #-------------------------MOD-CC0028-----------(E)
   #FUN-B10058--add--end
   #FUN-CA0084 --add--str
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
   	  #No.MOD-D60122  --Begin
      #IF cl_null(g_oma.oma08) THEN LET g_oma.oma08 = '1' END IF 
      IF cl_null(g_oma.oma08) THEN 
      	 IF g_oma.oma23 = g_aza.aza17 THEN
   	        LET g_oma.oma08 = '1'
         ELSE
   	        LET g_oma.oma08 = '2'
   	     END IF
   	  END IF
   	  #No.MOD-D60122  --End
      IF cl_null(g_oma.oma032) THEN 
         SELECT occ02 INTO g_oma.oma032 FROM occ_file
          WHERE occ01 = g_oma.oma03
      END IF 
      IF cl_null(g_oma.oma32) THEN 
         SELECT occ45 INTO g_oma.oma32 FROM occ_file
          WHERE occ01 = g_oma.oma03
      END IF 
   END IF 
   #FUN-CA0084--add--end
   SELECT ta_omf01 INTO g_oma.ta_oma01 FROM omf_file WHERE omf00 = sr.omf00 AND omf21 = sr.omf21 #add by zhaoxiangb 150722
   INSERT INTO oma_file VALUES(g_oma.*)
   IF SQLCA.SQLCODE OR STATUS=100 THEN
      LET g_msg='ins oma:(',g_oma.oma01,')'
      CALL s_errmsg('oma01',g_oma.oma01,g_msg,SQLCA.SQLCODE,1)                 #NO.FUN-710050
      LET g_success='N' 
   ELSE
 #    CALL p330_omc()    #TQC-CB0041 mark 
   END IF
END FUNCTION
 
FUNCTION p330_g_omb(p_qty)
   DEFINE   l_sum    LIKE rxx_file.rxx04   #FUN-960141
   DEFINE l_omb18t   LIKE omb_file.omb18t
   DEFINE l_amt      LIKE omb_file.omb18t
  #DEFINE l_qty      LIKE type_file.num10         #No.FUN-680123 INTEGER #CHI-A50023 mark
   DEFINE l_qty      LIKE omb_file.omb12                                 #CHI-A50023
   DEFINE p_flag     LIKE type_file.chr1          #No.FUN-680123 VARCHAR(01)
   DEFINE p_qty      LIKE omb_file.omb12
   DEFINE l_qty2     LIKE omb_file.omb12
   DEFINE l_oba11    LIKE oba_file.oba11   #FUN-690012
#No.MOD-B10206 --begin
   DEFINE l_oha09    LIKE oha_file.oha09
   DEFINE l_omb13    LIKE omb_file.omb13 
   DEFINE l_omb14    LIKE omb_file.omb14
   DEFINE l_omb14t   LIKE omb_file.omb14t
#No.MOD-B10206 --end
   DEFINE l_azf141   LIKE azf_file.azf141  #FUN-B80058
   DEFINE l_azf20    LIKE azf_file.azf20   #FUN-BA0109
   DEFINE l_azf201   LIKE azf_file.azf201  #FUN-BA0109
   DEFINE l_oba111   LIKE oba_file.oba111  #FUN-C90078
   DEFINE l_ogb47_p  LIKE ogb_file.ogb47         #No.TQC-C20565
     LET g_omb.omb33 = NULL            #MOD-CA0083
     LET g_omb.omb331 = NULL           #MOD-CA0083 
     LET g_omb.omb00 = g_oma.oma00     #no.5872
     LET g_omb.omb01 = g_oma.oma01
     LET g_omb.omb31 = g_ogb.ogb01
     LET g_omb.omb32 = g_ogb.ogb03
     LET g_omb.omb04 = g_ogb.ogb04
     LET g_omb.omb05 = g_ogb.ogb916   #FUN-560070
     LET g_omb.omb06 = g_ogb.ogb06
     LET g_omb.omb40 = g_ogb.ogb1001  #No.FUN-660073
     LET g_omb.omb12 = g_ogb.ogb917  #No.TQC-7B0144  #已去掉已用量
     IF g_type = '2' THEN                                                       
        LET g_omb.omb12 = g_ogb.ogb917  #No.TQC-7B0144  #已去掉已用量           
     ELSE                                                                       
        LET g_omb.omb12 = g_ogb.ogb917 * -1                                     
     END IF                                                                     
     IF g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' AND p_qty > 0 THEN   #TQC-6B0003
        LET g_omb.omb12 = p_qty
     END IF
     LET g_omb.omb12 = s_digqty(g_omb.omb12,g_omb.omb05) #FUN-BB0083 add
     
     IF cl_null(g_ogb.ogb1006) THEN 
        LET g_omb.omb13 = g_ogb.ogb13
     ELSE
       #No.TQC-C20565 ---start---   Add
        IF g_ogb.ogb04 = 'MISCCARD' THEN
           LET l_ogb47_p = g_ogb.ogb47/g_ogb.ogb12
           LET g_omb.omb13 = g_ogb.ogb13 + l_ogb47_p
        ELSE
       #No.TQC-C20565 ---start---   Add
           LET g_omb.omb13 = g_ogb.ogb13*(g_ogb.ogb1006/100)
        END IF #No.TQC-C20565   Add
     END IF
    
    #LET g_omb.omb13 = g_ogb.ogb13  #No.TQC-C20565   Mark
     IF g_omb.omb12 = 0 THEN
        LET l_omb13 = g_omb.omb13   #No.MOD-B10206
        LET g_omb.omb13 = 0
     END IF
     LET g_omb.omb14=0  LET g_omb.omb14t=0
     LET g_omb.omb15=0
     LET g_omb.omb16=0  LET g_omb.omb16t=0
     LET g_omb.omb17=0
     LET g_omb.omb18=0  LET g_omb.omb18t=0
     LET g_omb.omb34=0  LET g_omb.omb35=0
     LET g_omb.omb37 =0    #A060

 
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
     #IF g_oma.oma70 = '3' THEN        #FUN-C10055 mark
     IF g_mTax = TRUE THEN             #FUN-C10055 add
        LET g_omb.omb14 = g_ogb.ogb14
        LET g_omb.omb14t = g_ogb.ogb14t
     ELSE
###-FUN-B40005- ADD -  END  ---------------------------------------------------
        IF g_oma.oma213 = 'N' THEN 
           IF g_omb.omb12 != 0 THEN
              LET g_omb.omb14 =g_omb.omb12*g_omb.omb13
           END IF
#FUN-AC0027 --begin--        
#by elva --begin mark
#        IF g_oma.oma74 = '2' THEN
#          LET g_omb.omb14t = g_omb.omb14
#        ELSE  
#by elva --end
#FUN-AC0027 --end--        
             LET g_omb.omb14t=g_omb.omb14*(1+g_oma.oma211/100)
#       END IF        #FUN-AC0027  #by elva mark
        ELSE 
           IF g_omb.omb12 != 0 THEN
              LET g_omb.omb14t=g_omb.omb12*g_omb.omb13
           END IF
#FUN-AC0027 --begin--        
#by elva --begin mark
#        IF g_oma.oma74 = '2' THEN
#          LET g_omb.omb14 = g_omb.omb14t
#        ELSE  
#by elva --end   
#FUN-AC0027 --end--         
           LET g_omb.omb14 =g_omb.omb14t/(1+g_oma.oma211/100)
#       END IF       #FUN-AC0027  #by elva mark
        END IF
     END IF          #FUN-B40005 ADD 
#No.MOD-B10206 --begin  
     #FUN-C60036--add--str
     IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
        LET g_omb.omb14 = g_ogb.ogb14
        LET g_omb.omb14t = g_ogb.ogb14t
     END IF 
     #FUN-C60036--add--end
     IF g_type ='3' THEN 
        LET l_oha09 = NULL  
       #SELECT oha09 INTO l_oha09 FROM oha_file WHERE oha01 = g_ogb.ogb01  #MOD-B70125 mark 
       #-MOD-B70125-add-
        LET g_sql = "SELECT oha09 ", 
                    "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),
                    " WHERE oha01 = '",g_ogb.ogb01,"'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql             
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql 
        PREPARE p330_oha09_p2 FROM g_sql
        DECLARE p330_oha09_c2 SCROLL CURSOR FOR p330_oha09_p2
        OPEN p330_oha09_c2
        FETCH p330_oha09_c2 INTO l_oha09
        IF cl_null(l_oha09) THEN LET l_oha09=' ' END IF 
       #-MOD-B70125-end-
        IF l_oha09 = '5' THEN  
           SELECT SUM(omb14),SUM(omb14t)           #MOD-B70278 MOD-D90014
           #SELECT SUM(ABS(omb14)),SUM(ABS(omb14t))  #MOD-B70278 
             INTO l_omb14,l_omb14t 
             FROM omb_file,oma_file 
            WHERE omb33 = g_ogb.ogb01 
              AND omb01 <> g_oma.oma01 
              AND oma01 = omb01
              AND omavoid <> 'N' 
           IF cl_null(l_omb14) THEN
              LET l_omb14 = 0 
           END IF 
           IF cl_null(l_omb14t) THEN
              LET l_omb14t = 0 
           END IF
           IF g_oma.oma213 = 'N' THEN                      
              LET g_omb.omb14 =g_ogb.ogb14 - l_omb14              
              LET g_omb.omb14t=g_omb.omb14*(1+g_oma.oma211/100)
           ELSE                      
              LET g_omb.omb14t=g_ogb.ogb14t - l_omb14t              
              LET g_omb.omb14 =g_omb.omb14t/(1+g_oma.oma211/100)
           END IF 
           #No.MOD-B70278  --Begin
           LET g_omb.omb13 = l_omb13  #MOD-D90014
           #LET g_omb.omb13 = l_omb13 * -1  #MOD-D90014
           #LET g_omb.omb14 = g_omb.omb14 * -1  #MOD-D90014
           #LET g_omb.omb14t = g_omb.omb14t * -1  #MOD-D90014
           #No.MOD-B70278  --End
           IF g_omb.omb14 > 0 THEN LET g_omb.omb14 = g_omb.omb14 * -1 END IF       #yinhy131217
           IF g_omb.omb14t > 0 THEN LET g_omb.omb14t = g_omb.omb14t * -1 END IF    #yinhy131217
        END IF  
     END IF 
#No.MOD-B10206 --end
     CALL cl_digcut(g_omb.omb13,t_azi03) RETURNING g_omb.omb13   #MOD-760078
     CALL cl_digcut(g_omb.omb14,t_azi04) RETURNING g_omb.omb14   #MOD-760078
     CALL cl_digcut(g_omb.omb14t,t_azi04)RETURNING g_omb.omb14t  #MOD-760078
     LET g_omb.omb15 =g_omb.omb13 *g_oma.oma24
     LET g_omb.omb16 =g_omb.omb14 *g_oma.oma24
     LET g_omb.omb16t=g_omb.omb14t*g_oma.oma24
     LET g_omb.omb17 =g_omb.omb13 *g_oma.oma58
     LET g_omb.omb18 =g_omb.omb14 *g_oma.oma58
     LET g_omb.omb18t=g_omb.omb14t*g_oma.oma58
     CALL cl_digcut(g_omb.omb15,g_azi03) RETURNING g_omb.omb15   #MOD-760078
     CALL cl_digcut(g_omb.omb16,g_azi04) RETURNING g_omb.omb16   #MOD-760078
     CALL cl_digcut(g_omb.omb16t,g_azi04)RETURNING g_omb.omb16t  #MOD-760078
     CALL cl_digcut(g_omb.omb17,g_azi03) RETURNING g_omb.omb17   #MOD-760078
     CALL cl_digcut(g_omb.omb18,g_azi04) RETURNING g_omb.omb18   #MOD-760078
     CALL cl_digcut(g_omb.omb18t,g_azi04)RETURNING g_omb.omb18t  #MOD-760078
     #超過發票限額則拆數量
     LET p_flag = 'N'
     LET p_qty = 0
     #No.MOD-C80014  --Begin
    #IF g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' AND l_sum<= 0 THEN   #TQC-6B0003 #FUN-960141
    #IF g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' THEN   #TQC-6B0003#TQC-D10093 mark
     IF g_aza.aza26='2' AND g_ooy.ooy10 = 'Y' AND g_oaz92 != 'Y' THEN #TQC-D10093 add
     #No.MOD-C80014  --End
        SELECT SUM(omb18t) INTO l_omb18t FROM omb_file WHERE omb01=g_oma.oma01
        IF cl_null(l_omb18t) THEN LET l_omb18t = 0 END IF
        IF l_omb18t + g_omb.omb18t > g_ooy.ooy11 THEN
           LET p_flag = 'Y'
           LET l_amt = g_ooy.ooy11
        ELSE
          #LET p_flag = 'Y'  #CHI-A50023 mark
           LET p_flag = 'N'  #CHI-A50023
           LET l_amt = l_omb18t + g_omb.omb18t 
        END IF
        IF p_flag = 'Y' THEN      #CHI-A50023 add
           IF g_omb.omb12 > 1 THEN
              LET l_qty = (l_amt-l_omb18t) / (g_omb.omb18t / g_omb.omb12)
              LET p_qty = g_omb.omb12 - l_qty
              LET g_omb.omb12 = l_qty
           ELSE  
              LET l_qty2 = (l_amt-l_omb18t) / (g_omb.omb18t / g_omb.omb12)
              LET p_qty = g_omb.omb12 - l_qty2
              LET g_omb.omb12 = l_qty2
           END IF
           LET g_omb.omb12 = s_digqty(g_omb.omb12,g_omb.omb05) #FUN-BB0083 add
           IF g_oma.oma213 = 'N' THEN
              IF g_omb.omb12 != 0 THEN
                 LET g_omb.omb14 =g_omb.omb12*g_omb.omb13
              END IF
              CALL cl_digcut(g_omb.omb14,t_azi04) RETURNING g_omb.omb14   #MOD-760078
#FUN-AC0027 --begin--
               IF g_oma.oma74 = '2' THEN
                 LET g_omb.omb14t = g_omb.omb14
               ELSE  
#FUN-AC0027 --end--              
                 LET g_omb.omb14t=g_omb.omb14*(1+g_oma.oma211/100)
               END IF    #FUN-AC0027  
              CALL cl_digcut(g_omb.omb14t,t_azi04)RETURNING g_omb.omb14t   #MOD-760078
           ELSE 
              IF g_omb.omb12 != 0 THEN
                 LET g_omb.omb14t=g_omb.omb12*g_omb.omb13
              END IF
              CALL cl_digcut(g_omb.omb14t,t_azi04)RETURNING g_omb.omb14t   #MOD-760078
#FUN-AC0027 --begin--              
              IF g_oma.oma74 = '2' THEN
                 LET g_omb.omb14 = g_omb.omb14t
              ELSE   
#FUN-AC0027 --end--              
                 LET g_omb.omb14 =g_omb.omb14t/(1+g_oma.oma211/100)
              END IF    #FUN-AC0027    
              CALL cl_digcut(g_omb.omb14,t_azi04) RETURNING g_omb.omb14   #MOD-760078
           END IF
           #
           LET g_omb.omb15 =g_omb.omb13 *g_oma.oma24
           LET g_omb.omb16 =g_omb.omb14 *g_oma.oma24
           LET g_omb.omb16t=g_omb.omb14t*g_oma.oma24
           LET g_omb.omb17 =g_omb.omb13 *g_oma.oma58
           LET g_omb.omb18 =g_omb.omb14 *g_oma.oma58
           LET g_omb.omb18t=g_omb.omb14t*g_oma.oma58
           CALL cl_digcut(g_omb.omb15,g_azi03) RETURNING g_omb.omb15   #MOD-760078
           CALL cl_digcut(g_omb.omb16,g_azi04) RETURNING g_omb.omb16   #MOD-760078
           CALL cl_digcut(g_omb.omb16t,g_azi04)RETURNING g_omb.omb16t  #MOD-760078
           CALL cl_digcut(g_omb.omb17,g_azi03) RETURNING g_omb.omb17   #MOD-760078
           CALL cl_digcut(g_omb.omb18,g_azi04) RETURNING g_omb.omb18   #MOD-760078
           CALL cl_digcut(g_omb.omb18t,g_azi04)RETURNING g_omb.omb18t  #MOD-760078
        END IF  #CHI-A50023 add
     END IF
     LET g_omb.omb36 = g_oma.oma24                      #A060
     LET g_omb.omb37 = g_omb.omb16t - g_omb.omb35       #A060
     IF g_bgjob = "N" THEN          #No.FUN-570156
        MESSAGE   g_omb.omb03,' ',g_omb.omb04,' ',g_omb.omb12
        CALL ui.Interface.refresh() 
     END IF                         #No.FUN-570156
     LET g_omb.omb34 = 0 LET g_omb.omb35 = 0 
 
     IF g_type = '2' THEN                                                       
        LET g_omb.omb38 = '2'                    #出货单                        
     ELSE                                                                       
        LET g_omb.omb38 = '3'                    #销退单                        
     END IF                                                                     
     
     #FUN-C60036--add--str
     IF cl_null(g_ogb.ogb01) AND g_oaz.oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
        LET g_omb.omb38 = '99'
       #zhouxm151217 add start
        SELECT omf16,omf28 INTO g_omb.omb12,g_omb.omb13
         FROM omf_file
         WHERE omf00= g_omf00
           AND omf01= g_omf01
           AND omf21= g_omf21
        #zhouxm151217 add end  
     END IF 
      #FUN-C60036--ad--end
     LET g_omb.omb39 = g_ogb.ogb1012          #搭贈
     IF g_omb.omb39 = 'Y' THEN                #如為搭贈
        LET g_omb.omb14 = 0
        LET g_omb.omb14t= 0
        LET g_omb.omb16 = 0
        LET g_omb.omb16t= 0
        LET g_omb.omb18 = 0
        LET g_omb.omb18t= 0
     END IF
 
#No.TQC-B70009 --begin
    #IF g_oma.oma00='12' THEN   #FUN-B10058
#    IF g_oma.oma00='12' OR g_oma.oma00 = '19' THEN   #FUN-B10058
#      LET l_oba11 = NULL
#      LET g_sql = "SELECT oba11 ",
#                  #"  FROM ",l_dbs CLIPPED,"oba_file,",l_dbs CLIPPED,"ima_file",
#                  "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", #FUN-A50102
#                            cl_get_target_table(g_plant_new,'ima_file'),     #FUN-A50102
#                  " WHERE oba01 = ima_file.ima131",
#                  "   AND ima01 = '",g_omb.omb04,"'"
#      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
#      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102              
#      PREPARE sel_oba_pre19 FROM g_sql
#      EXECUTE sel_oba_pre19 INTO l_oba11
#      IF SQLCA.sqlcode THEN
#         LET l_oba11 = NULL
#         CALL s_errmsg('ima01',g_omb.omb04,"sel oba" ,STATUS,0)                       #NO.FUN-710050 
#      END IF
#      LET g_omb.omb33 = l_oba11
#    END IF
#    LET g_omb.omb41 = g_ogb.ogb41  #專案
#    LET g_omb.omb42 = g_ogb.ogb42  #WBS
#    IF NOT cl_null(g_omb.omb40) THEN
#       SELECT azf14 INTO g_omb.omb33
#         FROM azf_file
#        WHERE azf01=g_omb.omb40 AND azf02='2' AND azfacti='Y'
#    END IF
# 
#    IF g_aza.aza63='Y' AND cl_null(g_omb.omb331) THEN
#      LET g_omb.omb331 = g_omb.omb33
#    END IF
# 
#     LET g_omb.omb930=g_ogb.ogb930 #FUN-680001
#     LET g_omb.omblegal = g_legal #FUN-980011 add
#     LET g_omb.omb44 = g_ogb.ogbplant   #FUN-9A0093
#
##FUN-AC0027 --begin--
#     #IF g_oma.oma00 = '12' THEN   #FUN-B10058
#     IF g_oma.oma00 = '19' THEN    #FUN-B10058
#        SELECT ogb49 INTO g_omb.omb45
#          FROM ogb_file
#         WHERE ogb01 = g_ogb.ogb01
#           AND ogb03 = g_ogb.ogb03 
#        IF g_oma.oma74 = '2' THEN
#           SELECT ool36 INTO g_omb.omb33 
#             FROM ool_file
#            WHERE ool01 = g_oma.oma13
#           IF g_aza.aza63 = 'Y' THEN
#              SELECT ool361 INTO g_omb.omb331 
#                FROM ool_file
#               WHERE ool01 = g_oma.oma13
#           END IF               
#        END IF    
#     END IF    
#
#FUN-AC0027 --end--          

    IF g_oma.oma00='12' OR g_oma.oma00 = '19' THEN   #FUN-B10058
       LET g_omb.omb33 = ''      #MOD-C70120 add
       IF NOT cl_null(g_omb.omb40) THEN
          #LET l_azf141 = ''      #FUN-B80058
          LET l_azf20 = ''       #FUN-BA0109
          LET l_azf201 = ''      #FUN-BA0109
          IF g_oma.oma08 = '1' THEN       #FUN-C90078
             #SELECT azf14,azf141 INTO g_omb.omb33,l_azf141  #FUN-B80058 add azf141
             SELECT azf20,azf201 INTO l_azf20,l_azf201     #FUN-BA0109
               FROM azf_file
              WHERE azf01=g_omb.omb40 AND azf02='2' AND azfacti='Y'
          #FUN-C90078--add--str
          ELSE
             SELECT azf21,azf211 INTO l_azf20,l_azf201
               FROM azf_file
              WHERE azf01=g_omb.omb40 AND azf02='2' AND azfacti='Y'
          END IF
          #FUN-C90078--add--end
       END IF
       IF NOT cl_null(l_azf20) THEN LET g_omb.omb33=l_azf20 END IF     #FUN-BA0109 
       IF g_aza.aza63='Y' AND cl_null(g_omb.omb331) THEN
          #LET g_omb.omb331 = g_omb.omb33
          #LET g_omb.omb331 = l_azf141  #FUN-B80058                          #FUN-BA0109
          IF NOT cl_null(l_azf201) THEN LET g_omb.omb331=l_azf201 END IF     #FUN-BA0109
       END IF
 
      IF cl_null(g_omb.omb33) THEN 
         LET l_oba11 = NULL
         IF g_oma.oma08 = '1' THEN  #FUN-C90078
#add by jiangln 150814 start-------
            IF g_type = '3'   THEN   
                LET g_sql = "SELECT obaud01 ",
                            "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", 
                                      cl_get_target_table(g_plant_new,'ima_file'),    
                            " WHERE oba01 = ima_file.ima131",
                            "   AND ima01 = '",g_omb.omb04,"'"
            ELSE 
#add by jiangln 150814 end-----------
                LET g_sql = "SELECT oba11 ",
                            "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", 
                                      cl_get_target_table(g_plant_new,'ima_file'),    
                            " WHERE oba01 = ima_file.ima131",
                            "   AND ima01 = '",g_omb.omb04,"'"
            END IF   #add by jiangln 150814
         #FUN-C90078--add--str
         ELSE
#add by jiangln 150814 start-------
            IF g_type = '3'   THEN   
                LET g_sql = "SELECT obaud02 ",
                            "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",", 
                                      cl_get_target_table(g_plant_new,'ima_file'),    
                            " WHERE oba01 = ima_file.ima131",
                            "   AND ima01 = '",g_omb.omb04,"'"
            ELSE 
#add by jiangln 150814 end-----------
            LET g_sql = "SELECT oba17 ",
                        "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",",
                                  cl_get_target_table(g_plant_new,'ima_file'),
                        " WHERE oba01 = ima_file.ima131",
                        "   AND ima01 = '",g_omb.omb04,"'"
            END IF   #add by jiangln 150814
         END IF
          #FUN-C90078--ADD--END   
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102              
         PREPARE sel_oba_pre19 FROM g_sql
         EXECUTE sel_oba_pre19 INTO l_oba11
         IF SQLCA.sqlcode THEN
            LET l_oba11 = NULL
            CALL s_errmsg('ima01',g_omb.omb04,"sel oba" ,STATUS,0)                       #NO.FUN-710050 
         END IF
         LET g_omb.omb33 = l_oba11
         #FUN-C90078--add--str
         IF g_aza.aza63='Y' THEN
            IF g_oma.oma08 = '1' THEN       #FUN-C90078
               LET g_sql = "SELECT oba111 ",
                           "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",",
                                     cl_get_target_table(g_plant_new,'ima_file'),
                           " WHERE oba01 = ima_file.ima131",
                           "   AND ima01 = '",g_omb.omb04,"'"
            ELSE
               LET g_sql = "SELECT oba171 ",
                           "  FROM ",cl_get_target_table(g_plant_new,'oba_file'),",",
                                     cl_get_target_table(g_plant_new,'ima_file'),
                           " WHERE oba01 = ima_file.ima131",
                           "   AND ima01 = '",g_omb.omb04,"'"
            END IF
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
            PREPARE sel_oba_pre19_1 FROM g_sql
            EXECUTE sel_oba_pre19_1 INTO l_oba111 
            IF SQLCA.sqlcode THEN
               LET l_oba111 = NULL
               CALL s_errmsg('ima01',g_omb.omb04,"sel oba" ,STATUS,0)
            END IF
            LET g_omb.omb331 = l_oba111
         END IF
         #FUN-C90078--add--end
      END IF 
      
      IF g_oma.oma00 = '19' THEN   
         SELECT ogb49 INTO g_omb.omb45
           FROM ogb_file
          WHERE ogb01 = g_ogb.ogb01
            AND ogb03 = g_ogb.ogb03 
      END IF   
      IF cl_null(g_omb.omb33) THEN
         IF g_oma.oma08='1' THEN           #FUN-C90078
            SELECT ool41 INTO g_omb.omb33 
              FROM ool_file
             WHERE ool01 = g_oma.oma13
         #FUN-C90078--add--str
         ELSE
            SELECT ool40 INTO g_omb.omb33
              FROM ool_file
             WHERE ool01 = g_oma.oma13
            IF g_aza.aza63 = 'Y' THEN
               SELECT ool401 INTO g_omb.omb331
                 FROM ool_file
               WHERE ool01 = g_oma.oma13
            END IF  
         END IF
         #FUN-C90078--add--end
         IF g_aza.aza63 = 'Y' THEN
            SELECT ool411 INTO g_omb.omb331 
              FROM ool_file
             WHERE ool01 = g_oma.oma13
         END IF               
      END IF 
      IF g_oma.oma74 = '2' THEN
         SELECT ool36 INTO g_omb.omb33 
           FROM ool_file
          WHERE ool01 = g_oma.oma13
         IF g_aza.aza63 = 'Y' THEN
            SELECT ool361 INTO g_omb.omb331 
              FROM ool_file
             WHERE ool01 = g_oma.oma13
         END IF               
      END IF    
    END IF
    LET g_omb.omb41 = g_ogb.ogb41  #專案
    LET g_omb.omb42 = g_ogb.ogb42  #WBS
    LET g_omb.omb930=g_ogb.ogb930 #FUN-680001
    LET g_omb.omblegal = g_legal #FUN-980011 add
    LET g_omb.omb44 = g_ogb.ogbplant   #FUN-9A0093 
    #FUN-C60036--add--str
     IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
        SELECT omf19,omf19t INTO g_omb.omb16,g_omb.omb16t
          FROM omf_file
         WHERE omf01 = g_omf01
           AND omf00 = g_omf00
           AND omf02 = g_omf02
           AND omf12 = g_ogb.ogb03
           AND omf11 = g_ogb.ogb01
           AND omf21 = g_omf21   #zhouxm151229 add 
           AND omf04 IS NULL
        LET g_omb.omb18 = g_omb.omb16
        LET g_omb.omb18t = g_omb.omb16t
     END IF
     CALL cl_digcut(g_omb.omb16,g_azi04) RETURNING g_omb.omb16
     CALL cl_digcut(g_omb.omb16t,g_azi04)RETURNING g_omb.omb16t
     CALL cl_digcut(g_omb.omb18,g_azi04) RETURNING g_omb.omb18
     CALL cl_digcut(g_omb.omb18t,g_azi04)RETURNING g_omb.omb18t
     IF g_omb.omb32 = 0 THEN LET g_omb.omb32 = '' END IF 
     #FUN-C60036--add--end

#No.TQC-B70009 --end
     LET g_omb.omb48 = 0   #FUN-D10101 add
#zhouxm151217 add start
      IF g_omb.omb38='99' THEN
         LET g_omb.omb33='220304-00'
      END IF
#zhouxm151217 add end 
     INSERT INTO omb_file VALUES(g_omb.*)
     IF SQLCA.SQLCODE OR STATUS=100 THEN
        LET g_showmsg=g_omb.omb01,"/",g_omb.omb03                                             #NO.FUN-710050
        CALL s_errmsg('omb01,omb03',g_showmsg,'ins omb',SQLCA.SQLCODE,1)                      #NO.FUN-710050
        LET g_success='N' RETURN p_flag,p_qty 
#FUN-AC0027 --begin--
     ELSE
        #FUN-C60036 --add--str
        IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
        UPDATE omf_file SET omf04 = g_omb.omb01
        #WHERE omf01 = g_oma.oma10 AND omf02 = g_oma.oma75
        #  AND omf11 = g_ogb.ogb01 AND omf12 = g_ogb.ogb03
         WHERE omf21 = g_omf21
           AND omf00 = g_omf00
        IF STATUS OR SQLCA.SQLCODE THEN
           LET g_showmsg=g_oma.oma10,"/",g_oma.oma75                                             
           CALL s_errmsg('omf01,omf02',g_showmsg,"upd omf",SQLCA.SQLCODE,1)                       
           LET g_success='N'
        END IF 
        END if
        #FUN-C60036--add--end
        IF g_oma.oma74 ='2' THEN
#           SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#             FROM omb_file 
#            WHERE omb01=g_oma.oma01 
#              AND omb46 ='1'
#           IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#           IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
          #SELECT SUM(omb14),SUM(omb16) INTO g_oma.oma73f,g_oma.oma73 #by elva
           SELECT SUM(omb14t),SUM(omb16t) INTO g_oma.oma73f,g_oma.oma73 #by elva
             FROM omb_file 
            WHERE omb01=g_oma.oma01 
           IF g_oma.oma73 IS NULL THEN LET g_oma.oma73=0 END IF
           IF g_oma.oma73f IS NULL THEN LET g_oma.oma73f=0 END IF
           UPDATE oma_file SET  #oma50 = g_oma.oma50,
                                #oma50t= g_oma.oma50t,
                               oma73 = g_oma.oma73,
                               oma73f= g_oma.oma73f
            WHERE oma01 = g_oma.oma01                   
         ELSE
#            SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#              FROM omb_file 
#             WHERE omb01=g_oma.oma01
#            IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#            IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
            LET g_oma.oma73 = 0
            LET g_oma.oma73f= 0
            UPDATE oma_file SET #oma50 = g_oma.oma50,
                                #oma50t= g_oma.oma50t,
                                oma73 = g_oma.oma73,
                                oma73f= g_oma.oma73f
             WHERE oma01 = g_oma.oma01              
        END IF        
#FUN-AC0027 --end--            
     END IF

###-FUN-B40005- ADD - BEGIN -------------------------------------------
     #IF g_oma.oma70 = '3' THEN        #FUN-C10055  mark
     IF g_mTax = TRUE THEN             #FUN-C10055  add
        IF cl_null(g_oml_n) THEN
           LET g_oml_n = 1
        ELSE
           LET g_oml_n = g_oml_n + 1
        END IF
        LET g_sql =
           "INSERT INTO oml_file (oml01,oml02,oml03,oml04,oml05,oml06,oml07,  ",
           "                      oml08,oml08t,oml09,omldate,omlgrup,         ",
           "                      omllegal,omlmodu,omlorig,omloriu,omluser)   ",
           "SELECT '",g_oma.oma01,"','",g_oml_n,"'",",ogi03,ogi04,ogi05,ogi06,",
           "            ogi07,ogi08,ogi08t,ogi09,'','",g_grup,"','",g_legal,"'",
           "                        ,'','",g_grup,"','",g_user,"','",g_user,"'",
           "  FROM ",cl_get_target_table(g_plant_new,'ogi_file'), 
           " WHERE ogi01 = '",g_ogb.ogb01,"'",
           "   AND ogi02 = '",g_ogb.ogb03,"'"
        PREPARE ins_oml_pre2 FROM g_sql
        EXECUTE ins_oml_pre2
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
           IF g_bgerr THEN
              LET g_showmsg=g_oma.oma01
              CALL s_errmsg('oml01',g_showmsg,'ins oml',SQLCA.SQLCODE,1)
           ELSE
              CALL cl_err3("ins","oml_file",g_oma.oma01,"",SQLCA.sqlcode,"","ins oml",1)
           END IF
           LET g_success='N'
           RETURN p_flag,p_qty
        END IF
        IF cl_null(g_oga01_t) OR (g_oga01_t <> g_oga01) THEN
           LET g_oga01_t = g_oga01
           LET g_omk_n = 0 
           LET g_sql = " SELECT COUNT(*) FROM omk_file ",
                       "  WHERE omk01='",g_oma.oma01,"'"
           PREPARE sel_omk_pre FROM g_sql
           EXECUTE sel_omk_pre INTO g_omk_n
           LET g_sql =
              "INSERT INTO omk_file (omk01,omk02,omk03,omk04,omk05,omk06,omk07,   ",
              "                      omk07t,omk08,omk09,omkdate,omkgrup,          ",
              "                      omklegal,omkmodu,omkorig,omkoriu,omkuser)    ",
              "SELECT '",g_oma.oma01,"',ogh02+",g_omk_n,",ogh03,ogh04,ogh05,ogh06,",
              "            ogh07,ogh07t,ogh08,ogh09,'','",g_grup,"','",g_legal,"'",
              "                        ,'','",g_grup,"','",g_user,"','",g_user,"'",
              "  FROM ",cl_get_target_table(g_plant_new,'ogh_file'),
              " WHERE ogh01 = '",g_ogb.ogb01,"'"
           PREPARE ins_omk_pre3 FROM g_sql
           EXECUTE ins_omk_pre3
           IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
              IF g_bgerr THEN
                 LET g_showmsg=g_oma.oma01
                 CALL s_errmsg('omk01',g_showmsg,'ins omk',SQLCA.SQLCODE,1)
              ELSE
                 CALL cl_err3("ins","omk_file",g_oma.oma01,"",SQLCA.sqlcode,"","ins omk",1)
              END IF
              LET g_success='N'
              RETURN p_flag,p_qty
           END IF
        END IF 
     END IF
###-FUN-B40005- ADD -  END  -------------------------------------------
     
     IF g_type = '2' THEN
        #LET g_sql = "UPDATE ",l_dbs CLIPPED,"oga_file SET oga10='",g_omb.omb01,"' ",
        LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                    " SET oga10='",g_omb.omb01,"' ",
                    "  WHERE oga01='",g_ogb.ogb01,"'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
        PREPARE upd_oga_pre20 FROM g_sql
        EXECUTE upd_oga_pre20
        IF SQLCA.SQLCODE OR STATUS=100 THEN
           CALL s_errmsg('oga01',g_ogb.ogb01,'upd oga10: ',SQLCA.SQLCODE,1)               #NO.FUN-710050
           LET g_success='N' RETURN p_flag,p_qty
        END IF
     ELSE
        #LET g_sql = "UPDATE ",l_dbs CLIPPED,"oha_file SET oha10='",g_omb.omb01,"'",
        IF NOT cl_null(g_ogb.ogb01) THEN #FUN-C60036 add
        LET g_sql = "UPDATE ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
                    " SET oha10='",g_omb.omb01,"'",
                    " WHERE oha01='",g_ogb.ogb01,"'"
        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
        PREPARE upd_oga_pre21 FROM g_sql
        EXECUTE upd_oga_pre21
        IF SQLCA.SQLCODE OR STATUS=100 THEN
           CALL s_errmsg('oha01',g_ogb.ogb01,'upd oha10: ',SQLCA.SQLCODE,1)               #NO.FUN-710050
           LET g_success='N' RETURN p_flag,p_qty
        END IF
        END IF #FUN-C60036 add
     END IF
     RETURN p_flag,p_qty
END FUNCTION
 
FUNCTION p330_122_omb()
   DEFINE l_azf141    LIKE azf_file.azf141  #FUN-B80058

     LET g_omb.omb00 = g_oma.oma00     #no.5872
     LET g_omb.omb01 = g_oma.oma01
     LET g_omb.omb31 = NULL
     LET g_omb.omb32 = NULL
     LET g_omb.omb04 = g_ofb.ofb04
     LET g_omb.omb05 = g_ofb.ofb916   #FUN-560070
     LET g_omb.omb06 = g_ofb.ofb06
     LET g_omb.omb12 = g_ofb.ofb917   #FUN-560070
     LET g_omb.omb13 = g_ofb.ofb13
     IF g_oma.oma213 = 'N'
        THEN LET g_omb.omb14 =g_omb.omb12*g_omb.omb13
             LET g_omb.omb14t=g_omb.omb14*(1+g_oma.oma211/100)
        ELSE LET g_omb.omb14t=g_omb.omb12*g_omb.omb13
             LET g_omb.omb14 =g_omb.omb14t/(1+g_oma.oma211/100)
     END IF
     CALL cl_digcut(g_omb.omb13,t_azi03) RETURNING g_omb.omb13   #MOD-760078
     CALL cl_digcut(g_omb.omb14,t_azi04) RETURNING g_omb.omb14   #MOD-760078
     CALL cl_digcut(g_omb.omb14t,t_azi04)RETURNING g_omb.omb14t  #MOD-760078
     LET g_omb.omb15 =g_omb.omb13 *g_oma.oma24
     LET g_omb.omb16 =g_omb.omb14 *g_oma.oma24
     LET g_omb.omb16t=g_omb.omb14t*g_oma.oma24
     LET g_omb.omb17 =g_omb.omb13 *g_oma.oma58
     LET g_omb.omb18 =g_omb.omb14 *g_oma.oma58
     LET g_omb.omb18t=g_omb.omb14t*g_oma.oma58
     CALL cl_digcut(g_omb.omb15,g_azi03) RETURNING g_omb.omb15   #MOD-760078
     CALL cl_digcut(g_omb.omb16,g_azi04) RETURNING g_omb.omb16   #MOD-760078
     CALL cl_digcut(g_omb.omb16t,g_azi04)RETURNING g_omb.omb16t  #MOD-760078
     CALL cl_digcut(g_omb.omb17,g_azi03) RETURNING g_omb.omb17   #MOD-760078
     CALL cl_digcut(g_omb.omb18,g_azi04) RETURNING g_omb.omb18   #MOD-760078
     CALL cl_digcut(g_omb.omb18t,g_azi04)RETURNING g_omb.omb18t  #MOD-760078
     IF g_bgjob = "N" THEN       #No.FUN-570156
        MESSAGE   g_omb.omb03,' ',g_omb.omb04,' ',g_omb.omb12
        CALL ui.Interface.refresh() 
     END IF                      #No.FUN-570156
     LET g_omb.omb36 = g_oma.oma24                 #A060
     LET g_omb.omb37 = g_omb.omb16t - g_omb.omb35  #A060
     LET g_omb.omb34 = 0 LET g_omb.omb35 = 0 
     LET g_omb.omb930= g_oma.oma930 #FUN-680001
     LET g_sql = "SELECT oeb41,oeb42,oeb1001 ",
                 #"  FROM ",l_dbs CLIPPED,"oeb_file",
                 "  FROM ",cl_get_target_table(g_plant_new,'oeb_file'), #FUN-A50102
                 " WHERE oeb01 = '",g_ofb.ofb31,"' AND oeb03 = '",g_ofb.ofb32,"'"
     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
     PREPARE sel_oeb_pre22 FROM g_sql
     EXECUTE sel_oeb_pre22 INTO g_omb.omb41,g_omb.omb42,g_omb.omb40
     IF NOT cl_null(g_omb.omb40) THEN
        LET l_azf141 = ''      #FUN-B80058
        SELECT azf14,azf141 INTO g_omb.omb33,l_azf141  ##FUN-B80058 add azf141
          FROM azf_file
         WHERE azf01=g_omb.omb40 AND azf02='2' AND azfacti='Y'
     END IF
 
     IF g_aza.aza63='Y' AND cl_null(g_omb.omb331) THEN
        #LET g_omb.omb331 = g_omb.omb33
        LET g_omb.omb331 = l_azf141  ##FUN-B80058
     END IF
     LET g_omb.omblegal = g_legal #FUN-980011 add
     LET g_omb.omb44 = g_ofb.ofbplant    #FUN-9A0093

     #FUN-B10058--add--str--
     IF g_oma.oma00 = '19' AND g_oma.oma74 = '2' THEN
        SELECT ool36 INTO g_omb.omb33 FROM ool_file
         WHERE ool01=g_oma.oma13
        IF g_aza.aza63 = 'Y' THEN
           SELECT ool361 INTO g_omb.omb331 FROM ool_file
            WHERE ool01=g_oma.oma13
        END IF
     END IF
     #FUN-B10058--add--end
     IF g_omb.omb32 = 0 THEN LET g_omb.omb32 = '' END IF #FUN-C60036 add
     LET g_omb.omb48 = 0   #FUN-D10101 add
     INSERT INTO omb_file VALUES(g_omb.*)
     IF SQLCA.SQLCODE OR STATUS=100 THEN
        LET g_showmsg=g_omb.omb01,"/",g_omb.omb03                                             #NO.FUN-710050  
        CALL s_errmsg('omb01,omb03',g_showmsg,'ins omb',SQLCA.SQLCODE,1)                      #NO.FUN-710050  
        LET g_success='N'
     ELSE
        #FUN-C60036 --add--str
        IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
        UPDATE omf_file SET omf04 = g_omb.omb01
        #WHERE omf01 = g_oma.oma10 AND omf02 = g_oma.oma75
        #  AND omf11 = g_ogb.ogb01 AND omf12 = g_ogb.ogb03
         WHERE omf21 = g_omf21
           AND omf00 = g_omf00
        IF STATUS OR SQLCA.SQLCODE THEN
           LET g_showmsg=g_oma.oma10,"/",g_oma.oma75                                             
           CALL s_errmsg('omf01,omf02',g_showmsg,"upd omf",SQLCA.SQLCODE,1)                       
           LET g_success='N'
        END IF 
        END IF 
        #FUN-C60036--add--end
     END IF
END FUNCTION

#-TQC-BA0172-mark- 
#FUNCTION p330_g_bu()  
#DEFINE l_omc    RECORD LIKE omc_file.*           #No.FUN-680022  add 
#DEFINE l_oas02         LIKE oas_file.oas02       #No.FUN-680022  add 
#DEFINE l_oas05         LIKE oas_file.oas05       #No.FUN-680022  add
#DEFINE l_omc13_tot     LIKE omc_file.omc13       #No.FUN-680022  add 
##No.FUN-9C0014 -BEGIN-----
#DEFINE l_oma54         LIKE oma_file.oma54
#DEFINE l_oma54t        LIKE oma_file.oma54t
#DEFINE l_oma56         LIKE oma_file.oma56
#DEFINE l_oma56t        LIKE oma_file.oma56t
#DEFINE l_oma54_1       LIKE oma_file.oma54
#DEFINE l_oma54t_1      LIKE oma_file.oma54t
#DEFINE l_oma56_1       LIKE oma_file.oma56
#DEFINE l_oma56t_1      LIKE oma_file.oma56t
#DEFINE l_n             LIKE type_file.num5
#DEFINE l_check         LIKE type_file.chr1
#DEFINE l_omb44         LIKE omb_file.omb44
#DEFINE l_omb31         LIKE omb_file.omb31
#DEFINE l_dbs1          LIKE type_file.chr21
#No.FUN-9C0014 -END-------
#
# #No.FUN-9C0014 -BEGIN-----
#  DECLARE p330_omb_cs1 CURSOR FOR
#   SELECT DISTINCT omb44,omb31 FROM omb_file
#    WHERE omb01 = g_oma.oma01
#  LET l_oma54 = 0
#  LET l_oma54t = 0
#  LET l_oma56 = 0
#  LET l_oma56t = 0
#  FOREACH p330_omb_cs1 INTO l_omb44,l_omb31
#     LET l_dbs1 = ''
#     LET g_plant_new = l_omb44
#     CALL s_gettrandbs()
#     LET l_dbs1 = g_dbs_tra
#
#     #LET g_sql = "SELECT COUNT(*) FROM ",l_dbs CLIPPED,"rxx_file",
#     LET g_sql = "SELECT COUNT(*) FROM ",cl_get_target_table(g_plant_new,'rxx_file'), #FUN-A50102
#                 " WHERE rxx00 = '02' AND rxx01 = '",l_omb31,"'",
#                 "   AND rxxplant = '",l_omb44,"'"
#     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
#     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
#     PREPARE sel_rxx_pre13 FROM g_sql
#     EXECUTE sel_rxx_pre13 INTO l_n
#     IF l_n >0 THEN LET l_check='Y' ELSE LET l_check = 'N' END IF  #MOD-AA0156
#     IF l_n >0 AND g_occ73='Y' THEN LET l_check='Y' ELSE LET l_check = 'N' END IF  #MOD-AA0156
#  
#     LET g_sql = " SELECT (oma54t-oma55),oma54t,(oma56t-oma57),oma56t",
#                 #"   FROM oma_file,",l_dbs1 CLIPPED,"oga_file",
#                 "   FROM oma_file,",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
#                 "  WHERE oga01 = '",l_omb31,"'",
#                 "    AND oga19 = oma01"
#     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
#     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
#     PREPARE sel_oma_pre46 FROM g_sql
#     EXECUTE sel_oma_pre46 INTO l_oma54_1,l_oma54t_1,l_oma56_1,l_oma56t_1
#     IF cl_null(l_oma54_1) THEN LET l_oma54_1 = 0 END IF
#     IF cl_null(l_oma54t_1) THEN LET l_oma54t_1 = 0 END IF
#     IF cl_null(l_oma56_1) THEN LET l_oma56_1 = 0 END IF
#     IF cl_null(l_oma56t_1) THEN LET l_oma56t_1 = 0 END IF
#     LET l_oma54 = l_oma54 + l_oma54_1
#     LET l_oma54t = l_oma54t + l_oma54t_1
#     LET l_oma56 = l_oma56 + l_oma56_1
#     LET l_oma56t = l_oma56t + l_oma56t_1
#  END FOREACH
# #No.FUN-9C0014 -END------- 
#
#  LET g_oma.oma50 = 0 LET g_oma.oma50t= 0
#  SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#         FROM omb_file WHERE omb01=g_oma.oma01
#  IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#  IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
# #No.FUN-9C0014 -BEGIN-----
# #LET g_oma.oma52 = 0 
# #LET g_oma.oma53 = 0 
# #LET g_oma.oma54 = g_oma.oma50 *(1-g_oma.oma163/100)
# #LET g_oma.oma54t= g_oma.oma50t*(1-g_oma.oma163/100)
#  IF l_check = 'N' THEN   #出貨單沒有收款
#     LET g_oma.oma54 = g_oma.oma50 *g_oma.oma162/100
#     LET g_oma.oma54t= g_oma.oma50t*g_oma.oma162/100
#  ELSE
#     LET g_oma.oma54 = g_oma.oma50*(1-g_oma.oma163/100)
#     LET g_oma.oma54t = g_oma.oma50t*(1-g_oma.oma163/100)
#  END IF
#  IF g_oma.oma07='N' OR cl_null(g_oma.oma07) THEN
#  #有收款 訂單轉銷貨收入為0
#  #無收款 訂單轉銷貨收入實際計算
#     IF l_check = 'Y' THEN #有收款
#        LET g_oma.oma52 = 0
#     ELSE 
#        LET g_oma.oma52 = g_oma.oma50 *g_oma.oma161/100 
#     END IF
#     #判斷變更後金額是否超出原待抵金額,
#     #若是的話,oma52=原待抵金額,oma54=變更後金額-原待抵金額
#     IF NOT cl_null(g_oma.oma19) THEN    #待抵帳款單號不為空
#        IF l_oma54 < g_oma.oma52 THEN
#           LET g_oma.oma54 = g_oma.oma52 - l_oma54   #原幣未稅金額
#           LET g_oma.oma54t= g_oma.oma52 - l_oma54t  #原幣應收金額
#           LET g_oma.oma52 = l_oma54                 #原幣訂金
#        END IF
#     END IF
#  END IF
# #No.FUN-9C0014 -END-------
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
#  IF g_oma.oma70 = '3' THEN
#     SELECT SUM(omb14), SUM(omb14t) INTO g_oma.oma54,g_oma.oma54t FROM omb_file WHERE omb01 = g_omb.omb01
#     LET g_oma.oma54x = g_oma.oma54t - g_oma.oma54
#     CALL cl_digcut(g_oma.oma54,t_azi04) RETURNING g_oma.oma54
#     CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x
#  ELSE
###-FUN-B40005- ADD -  END  ---------------------------------------------------
#     IF g_oma.oma213='N'  
#        THEN CALL cl_digcut(g_oma.oma54,t_azi04) RETURNING g_oma.oma54   #MOD-760078
#             LET g_oma.oma54x=g_oma.oma54*g_oma.oma211/100
#             CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x   #MOD-760078
#             LET g_oma.oma54t=g_oma.oma54+g_oma.oma54x
#        ELSE CALL cl_digcut(g_oma.oma54t,t_azi04) RETURNING g_oma.oma54t   #MOD-760078
#             LET g_oma.oma54x=g_oma.oma54t*g_oma.oma211/(100+g_oma.oma211)
#             CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x   #MOD-760078
#             LET g_oma.oma54 =g_oma.oma54t-g_oma.oma54x
#     END IF
#  END IF          #FUN-B40005 ADD
#  
#  LET g_oma.oma56 = 0 LET g_oma.oma56t= 0
#  LET g_oma.oma53 = 0   #MOD-8A0053 add
#  SELECT SUM(omb16),SUM(omb16t) INTO g_oma.oma56,g_oma.oma56t
#         FROM omb_file WHERE omb01=g_oma.oma01
#  IF g_oma.oma56  IS NULL THEN LET g_oma.oma56 =0 END IF
#  IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t=0 END IF
#  LET g_oma.oma53 = 0
# #No.FUN-9C0014 -BEGIN-----
# #LET g_oma.oma56 = g_oma.oma56 * (1-g_oma.oma163/100)
# #LET g_oma.oma56t= g_oma.oma56t* (1-g_oma.oma163/100)
#  IF g_oma.oma07='N' OR cl_null(g_oma.oma07) THEN
#  #有收款 訂單轉銷貨收入為0
#  #無收款 訂單轉銷貨收入實際計算
#     IF l_check = 'Y' THEN  #有收款
#        LET g_oma.oma53 = 0
#     ELSE 
#        LET g_oma.oma53 = g_oma.oma56 *g_oma.oma161/100
#     END IF
#  END IF
#     IF l_check = 'N' THEN  #無收款
#        LET g_oma.oma56 = g_oma.oma56 *g_oma.oma162/100 
#        LET g_oma.oma56t= g_oma.oma56t*g_oma.oma162/100
#     ELSE                  #有收款
#        LET g_oma.oma56 = g_oma.oma56*(1-g_oma.oma163/100)
#        LET g_oma.oma56t = g_oma.oma56t*(1-g_oma.oma163/100)
#     END IF
#  #判斷變更後金額是否超出原待抵金額,
#  #若是的話,oma53=原待抵金額,oma54=變更後金額-原待抵金額
#  IF NOT cl_null(g_oma.oma19) THEN    #待抵帳款單號不為空
#     IF l_oma56 < g_oma.oma53 THEN
#        LET g_oma.oma56 = g_oma.oma53 - l_oma56   #本幣未稅金額
#        LET g_oma.oma56t= g_oma.oma53 - l_oma56t  #本幣應收金額
#        LET g_oma.oma53 = l_oma56                 #本幣訂金
#     END IF
#  END IF
# #No.FUN-9C0014 -END-------
#  IF g_oma.oma56  IS NULL THEN LET g_oma.oma56 =0 END IF   #MOD-8A0053 add
#  IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t=0 END IF   #MOD-8A0053 add
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
#  IF g_oma.oma70 = '3' THEN
#     SELECT SUM(omb16),SUM(omb16t) INTO g_oma.oma56,g_oma.oma56t FROM omb_file WHERE omb01 = g_omb.omb01
#     LET g_oma.oma56x = g_oma.oma56t - g_oma.oma56
#     CALL cl_digcut(g_oma.oma56,t_azi04) RETURNING g_oma.oma56
#     CALL cl_digcut(g_oma.oma56x,t_azi04) RETURNING g_oma.oma56x
#  ELSE
###-FUN-B40005- ADD -  END  ---------------------------------------------------
#     IF g_oma.oma213='N'
#        THEN CALL cl_digcut(g_oma.oma56,g_azi04) RETURNING g_oma.oma56   #MOD-760078
#             LET g_oma.oma56x=g_oma.oma56*g_oma.oma211/100
#             CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x   #MOD-760078
#             LET g_oma.oma56t=g_oma.oma56+g_oma.oma56x
#        ELSE CALL cl_digcut(g_oma.oma56t,g_azi04) RETURNING g_oma.oma56t   #MOD-760078
#             LET g_oma.oma56x=g_oma.oma56t*g_oma.oma211/(100+g_oma.oma211)
#             CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x   #MOD-760078
#             LET g_oma.oma56 =g_oma.oma56t-g_oma.oma56x
#     END IF
#  END IF     #FUN-B40005 ADD
#  LET g_oma.oma59 = 0 LET g_oma.oma59t= 0
#  SELECT SUM(omb18),SUM(omb18t) INTO g_oma.oma59,g_oma.oma59t
#         FROM omb_file WHERE omb01=g_oma.oma01
# #No.FUN-9C0014 -BEGIN-----
# #LET g_oma.oma59 = g_oma.oma59 *g_oma.oma162/100
#  IF l_check = 'N' THEN  #無收款
#     LET g_oma.oma59 = g_oma.oma59 *g_oma.oma162/100
#     LET g_oma.oma59t= g_oma.oma59t*g_oma.oma162/100
#  ELSE
#No.MOD-B60148 --begin
#     LET g_oma.oma59 = g_oma.oma59 *(100-g_oma.oma163)/100
#     LET g_oma.oma59t= g_oma.oma59t*(100-g_oma.oma163)/100
#     LET g_oma.oma59 = g_oma.oma59 *(1-g_oma.oma163)/100
#     LET g_oma.oma59t= g_oma.oma59t*(1-g_oma.oma163)/100
#No.MOD-B60148 --end
#  END IF
# #No.FUN-9C0014 -END-------
#  IF g_oma.oma59  IS NULL THEN LET g_oma.oma59 =0 END IF
#  IF g_oma.oma59t IS NULL THEN LET g_oma.oma59t=0 END IF
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
#  IF g_oma.oma70 = '3' THEN
#     SELECT SUM(omb16),SUM(omb16t) INTO g_oma.oma59,g_oma.oma59t FROM omb_file WHERE omb01 = g_omb.omb01
#     LET g_oma.oma59x = g_oma.oma59t - g_oma.oma59
#     CALL cl_digcut(g_oma.oma59,t_azi04) RETURNING g_oma.oma59
#     CALL cl_digcut(g_oma.oma59x,t_azi04) RETURNING g_oma.oma59x
#  ELSE
###-FUN-B40005- ADD -  END  ---------------------------------------------------
#     IF g_oma.oma213='N'
#        THEN CALL cl_digcut(g_oma.oma59,g_azi04) RETURNING g_oma.oma59   #MOD-760078
#             LET g_oma.oma59x=g_oma.oma59*g_oma.oma211/100
#             CALL cl_digcut(g_oma.oma59x,g_azi04) RETURNING g_oma.oma59x   #MOD-760078
#             LET g_oma.oma59t=g_oma.oma59+g_oma.oma59x
#        ELSE CALL cl_digcut(g_oma.oma59t,g_azi04) RETURNING g_oma.oma59t   #MOD-760078
#             LET g_oma.oma59x=g_oma.oma59t*g_oma.oma211/(100+g_oma.oma211)
#             CALL cl_digcut(g_oma.oma59x,g_azi04) RETURNING g_oma.oma59x   #MOD-760078
#             LET g_oma.oma59 =g_oma.oma59t-g_oma.oma59x
#     END IF
#  END IF     #FUN-B40005 ADD
#  LET g_oma.oma61=g_oma.oma56t-g_oma.oma57
#  CALL s_ar_oox03(g_oma.oma01) RETURNING g_net                                                                                     
#  LET g_oma.oma61 = g_oma.oma61 + g_net                                                                                            
#  #FUN-B10058 --begin by elva
#  IF g_oma.oma00='19' THEN
#     LET g_oma.oma54 = 0
#     LET g_oma.oma54x = 0
#     LET g_oma.oma56 = 0
#     LET g_oma.oma56x = 0
#     LET g_oma.oma54t = g_oma.oma73f
#     LET g_oma.oma56t = g_oma.oma73
#  END IF
#  #FUN-B10058 --end by elva
#  CALL cl_digcut(g_oma.oma54t,t_azi04) RETURNING g_oma.oma54t   #MOD-8A0053 add
#  CALL cl_digcut(g_oma.oma56t,g_azi04) RETURNING g_oma.oma56t   #MOD-8A0053 add
#  UPDATE oma_file SET
#         oma50=g_oma.oma50,oma50t=g_oma.oma50t,
#         oma52=g_oma.oma52,oma53=g_oma.oma53,
#         oma54=g_oma.oma54,oma54x=g_oma.oma54x,oma54t=g_oma.oma54t,
#         oma56=g_oma.oma56,oma56x=g_oma.oma56x,oma56t=g_oma.oma56t,
#         oma59=g_oma.oma59,oma59x=g_oma.oma59x,oma59t=g_oma.oma59t,
#         oma55=g_oma.oma55,oma57=g_oma.oma57,oma61=g_oma.oma61
#         WHERE oma01=g_oma.oma01
#  IF SQLCA.SQLCODE OR STATUS=100 THEN
#     CALL s_errmsg('oma01',g_oma.oma01,'upd oma:',SQLCA.SQLCODE,1)                 #NO.FUN-710050
#     LET g_success='N'
#  ELSE
#     #LET g_sql = "SELECT DISTINCT(oas02) FROM ",l_dbs CLIPPED,"oas_file ",
#     LET g_sql = "SELECT DISTINCT(oas02) FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
#                 " WHERE oas01='",g_oma.oma32,"'"
#     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
#     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
#     PREPARE sel_oas_pre23 FROM g_sql
#     EXECUTE sel_oas_pre23 INTO l_oas02
#     IF l_oas02='1' THEN
#        IF NOT cl_null(g_net) THEN
#           SELECT SUM(omc13) INTO l_omc13_tot FROM omc_file 
#            WHERE omc01=g_oma.oma01
#           IF SQLCA.sqlcode THEN
#              CALL s_errmsg('omc01',g_oma.oma01,"select sum(omc13)",SQLCA.sqlcode,1)                     #NO.FUN-710050
#              LET l_omc13_tot = NULL
#           END IF
#        END IF
#        LET g_sql = "SELECT omc_file.*,oas_file.oas05 ",
#                    #"  FROM omc_file,oma_file,",l_dbs CLIPPED,"oas_file",
#                    "  FROM omc_file,oma_file,",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
#                    " WHERE omc01= '",g_oma.oma01,"'",
#                    "   AND omc01=oma01 AND oma32=oas01 AND omc03=oas04"
#        CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
#        CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102               
#        PREPARE sel_oas_pre24 FROM g_sql
#        DECLARE p330_omc_cs1 CURSOR FOR sel_oas_pre24
#        FOREACH p330_omc_cs1 INTO l_omc.*,l_oas05
#          IF SQLCA.sqlcode THEN
#             CALL s_errmsg('omc',g_oma.oma01,"foreach omc",SQLCA.sqlcode,1)               #NO.FUN-710050
#             LET g_success='N'
#             EXIT FOREACH                                                   #NO.FUN-710050 
#          END IF
#          LET l_omc.omc08=g_oma.oma54t*(l_oas05/100)
#          CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08   #MOD-760078
#          LET l_omc.omc09=g_oma.oma56t*(l_oas05/100)
#          CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09
#          LET l_omc.omc13=l_omc.omc09-l_omc.omc11
#          IF NOT cl_null(g_oma.oma61) AND NOT cl_null(l_omc13_tot) THEN
#             LET l_omc.omc13 = l_omc.omc13+(l_omc.omc13/l_omc13_tot)*g_net
#          END IF
#          UPDATE omc_file SET omc08=l_omc.omc08,omc09=l_omc.omc09,omc13=l_omc.omc13
#           WHERE omc01=l_omc.omc01 AND omc02=l_omc.omc02
#          IF SQLCA.sqlcode THEN
#             LET g_showmsg=l_omc.omc01,"/",l_omc.omc02                                                       #NO.FUN-710050 
#             CALL s_errmsg('omc01,omc02',g_showmsg,"upd omc_file",SQLCA.sqlcode,1)                           #NO.FUN-710050
#             LET g_success='N'
#             EXIT FOREACH
#          END IF
#        END FOREACH
#     END IF
#     IF l_oas02='2' OR cl_null(l_oas02) THEN
#        SELECT * INTO l_omc.* FROM omc_file WHERE omc01=g_oma.oma01  #No.MOD-740428
#        LET l_omc.omc08=g_oma.oma54t
#        CALL cl_digcut(l_omc.omc08,t_azi04) RETURNING l_omc.omc08   #MOD-760078
#        LET l_omc.omc09=g_oma.oma56t
#        CALL cl_digcut(l_omc.omc09,g_azi04) RETURNING l_omc.omc09
#        LET l_omc.omc13=l_omc.omc09-l_omc.omc11
#        IF NOT cl_null(g_oma.oma61) THEN
#           LET l_omc.omc13=l_omc.omc13 + g_net
#        END IF
#        UPDATE omc_file SET omc08=l_omc.omc08,omc09=l_omc.omc09,omc13=l_omc.omc13
#         WHERE omc01=g_oma.oma01 AND omc02=l_omc.omc02               #No.MOD-740428
#        IF SQLCA.sqlcode THEN
#           LET g_showmsg=g_oma.oma32,"/",l_omc.omc02                                                        #NO.FUN-710050
#           CALL s_errmsg('omc01,omc02',g_showmsg,"upd omc_file",SQLCA.sqlcode,1)                            #NO.FUN-710050     
#           LET g_success='N'
#        END IF
#     END IF
#  END IF
#END FUNCTION
#-TQC-BA0172-end- 
 
FUNCTION p330_g_oma_default()
   DEFINE l_cnt    LIKE type_file.num10  #FUN-C10055 add
   #FUN-C60036--add--str
   DEFINE l_oma09 LIKE oma_file.oma09
   DEFINE l_oma10 LIKE oma_file.oma10
   DEFINE l_oma75 LIKE oma_file.oma75
   DEFINE l_oma24 LIKE oma_file.oma24
   DEFINE l_oma76 LIKE oma_file.oma76#FUN-CB0057 add
   DEFINE l_omaud02 LIKE oma_file.omaud02 
   DEFINE l_ta_oma01 LIKE oma_file.ta_oma01   #add by zhaoxiangb 150722
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
      LET l_oma09 = g_oma.oma09
      LET l_oma10 = g_oma.oma10
      LET l_oma75 = g_oma.oma75
      LET l_oma24 = g_oma.oma24
      LET l_oma76 = g_oma.oma76#FUN-CB0057 add
   END IF 
   #FUN-C60036--add--end
   LET l_omaud02=g_oma.omaud02 #150701wudj
   LET l_ta_oma01 = g_oma.ta_oma01  #add by zhaoxiangb 150722
   INITIALIZE g_oma.* LIKE oma_file.*    #MOD-690049
   #FUN-C60036--add--str
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
      LET g_oma.oma09 = l_oma09
      LET g_oma.oma10 = l_oma10
      LET g_oma.oma75 = l_oma75
      LET g_oma.oma24 = l_oma24
      LET g_oma.oma76 = l_oma76#FUN-CB0057 add
   END IF 
   LET g_oma.omaud02=l_omaud02  #150701wudj
   LET g_oma.ta_oma01 = l_ta_oma01  #add by zhaoxiangb 150722
   #FUN-C60036--add--end
   #FUN-B10058--add--str--
   IF g_oga.oga57 = '2' THEN
      LET g_oma.oma00 = '19'
   ELSE
   #FUN-B10058--add--end
      LET g_oma.oma00 = '12'
   END IF   #FUN-B10058
   LET g_oma.oma01  =NULL
   LET g_oma.oma02 = g_date
   IF cl_null(g_oma.oma09) THEN     #FUN-D50008 add
      LET g_oma.oma09  =g_date   #MOD-890187 mod NULL->g_date
   END IF  #FUN-D50008 add
   LET g_oma.oma08  ='1'
   LET g_oma.oma07  ='N'
   LET g_oma.oma17  ='1'
   LET g_oma.oma173 = YEAR(g_oma.oma02)
   LET g_oma.oma174 = MONTH(g_oma.oma02)
   LET g_oma.oma20  ='Y'
   LET g_oma.oma50  =0
   LET g_oma.oma50t =0
   LET g_oma.oma52  =0
   LET g_oma.oma53  =0
   LET g_oma.oma54  =0
   LET g_oma.oma54x =0
   LET g_oma.oma54t =0
   LET g_oma.oma55  =0
   LET g_oma.oma56  =0
   LET g_oma.oma56x =0
   LET g_oma.oma56t =0
   LET g_oma.oma57  =0
   LET g_oma.oma59  =0
   LET g_oma.oma59x =0
   LET g_oma.oma61  =0               #A060
   LET g_oma.oma59t =0
   LET g_oma.omaconf='N'
   LET g_oma.omavoid='N'
   LET g_oma.omaprsw=0
   LET g_oma.omauser=g_user
   LET g_oma.omagrup=g_grup
   LET g_oma.omadate=TODAY
#  LET g_oma.oma70 = '2'   #FUN-960141  #FUN-B40005 MARK
###-FUN-B40005- ADD - BEGIN ---------------------------------------------------
   IF g_oga.oga94 = 'Y' THEN
      LET g_oma.oma70 = '3'
      LET g_mTax = TRUE     #FUN-C10055 add
   ELSE
      LET g_oma.oma70 = '2'
      LET g_mTax = FALSE    #FUN-C10055 add   
   END IF

   #FUN-C10055--start add--------------------------------
   IF g_mTax = FALSE THEN
      SELECT COUNT(*) INTO l_cnt
        FROM ogi_file
      #WHERE ogi01 = g_oma.oma16
       WHERE ogi01 = g_oga01   #FUN-C90068 add
      IF l_cnt > 0 THEN
         LET g_mTax = TRUE
      END IF   
   END IF  
  ##FUN-C10055--end add----------------------------------
###-FUN-B40005- ADD -  END  ---------------------------------------------------
   LET g_oma.oma66 = g_plant     #FUN-960141 090824 mark
   LET g_oma.omalegal = g_legal #FUN-980011 add
   LET g_oma.oma161 = 0     #MOD-D50119
   LET g_oma.oma162 = 100   #MOD-D50119
   LET g_oma.oma163 = 0     #MOD-D50119
    
END FUNCTION
 
FUNCTION p330_g_omb_1()
  DEFINE l_ogb14_ret  LIKE ogb_file.ogb14
  DEFINE l_azf141     LIKE azf_file.azf141  #FUN-B80058
  LET g_omb.omb33 = NULL            #MOD-CA0083
  LET g_omb.omb331 = NULL           #MOD-CA0083 
  LET g_omb.omb38 = '4'                          #出貨返利
  LET g_omb.omb39 = 'N'
  LET g_omb.omb04 = ''
  LET g_omb.omb05 = ''
  LET g_omb.omb06 = ''
  LET g_omb.omb12 = 0
  LET g_omb.omb13 = 0
  LET g_omb.omb15 = 0
  LET g_omb.omb17 = 0
 
  LET g_omb.omb01 = g_oma.oma01
  LET g_omb.omb31 = g_ogb.ogb01
  LET g_omb.omb32 = g_ogb.ogb03

  #LET g_sql = "SELECT SUM(ohb14) FROM ",l_dbs CLIPPED,"ohb_file,",l_dbs CLIPPED,"oha_file ",
  LET g_sql = "SELECT SUM(ohb14) FROM ",cl_get_target_table(g_plant_new,'ohb_file'),",", #FUN-A50102
                                        cl_get_target_table(g_plant_new,'oha_file'),     #FUN-A50102
              " WHERE oha01 = ohb01 ",
              "   AND oha09 = '3'",
              "   AND ohb31 = '",g_ogb.ogb01,"'",
              "   AND ohb32 = '",g_ogb.ogb03,"'",
              "   AND ohaconf = 'Y'",
              "   AND ohapost = 'Y'"
  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
  PREPARE sel_oha_pre25 FROM g_sql
  EXECUTE sel_oha_pre25 INTO l_ogb14_ret
 
  #IF g_oma.oma00='12' THEN   #FUN-B10058
  IF g_oma.oma00='12' OR g_oma.oma00 = '19' THEN   #FUN-B10058
     LET g_omb.omb14 = g_ogb.ogb14 - g_ogb.ogb1013 - l_ogb14_ret
  ELSE
     LET g_omb.omb14 = g_ogb.ogb14 
  END IF
  CALL cl_digcut(g_omb.omb14,t_azi04) RETURNING g_omb.omb14   #MOD-760078
  LET g_omb.omb14 = g_omb.omb14 * (-1)
 
  IF g_oma.oma213 = 'N'  THEN
#FUN-AC0027 --begin--  
     IF g_oma.oma74='2' THEN   
        LET g_omb.omb14t = g_omb.omb14
     ELSE   
#FUN-AC0027 --end--     
        LET g_omb.omb14t = g_omb.omb14 * (1 + g_oma.oma211/100)
     END IF   #FUN-AC0027    
     CALL cl_digcut(g_omb.omb14t,t_azi04) RETURNING g_omb.omb14t   #MOD-760078
  ELSE 
     IF g_omb.omb12 != 0 THEN
        LET g_omb.omb14t = g_omb.omb12*g_omb.omb13
     END IF
     CALL cl_digcut(g_omb.omb14t,t_azi04)RETURNING g_omb.omb14t   #MOD-760078
  END IF
  #FUN-C60036--add--str
     IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
        LET g_omb.omb14 = g_ogb.ogb14
        LET g_omb.omb14t = g_ogb.ogb14t
     END IF 
     #FUN-C60036--add--end
  LET g_omb.omb16 =g_omb.omb14 *g_oma.oma24
  LET g_omb.omb16t=g_omb.omb14t*g_oma.oma24
  LET g_omb.omb18 =g_omb.omb14 *g_oma.oma58
  LET g_omb.omb18t=g_omb.omb14t*g_oma.oma58
  CALL cl_digcut(g_omb.omb16, g_azi04) RETURNING g_omb.omb16   #MOD-760078
  CALL cl_digcut(g_omb.omb16t,g_azi04) RETURNING g_omb.omb16t  #MOD-760078
  CALL cl_digcut(g_omb.omb18, g_azi04) RETURNING g_omb.omb18   #MOD-760078
  CALL cl_digcut(g_omb.omb18t,g_azi04) RETURNING g_omb.omb18t  #MOD-760078
 
  MESSAGE g_omb.omb03,' ',g_omb.omb14
  LET g_omb.omb36 = g_oma.oma24     
  LET g_omb.omb37 = g_omb.omb16t-g_omb.omb35  
  LET g_omb.omb34 = 0 
  LET g_omb.omb35 = 0 
  LET g_omb.omb930= g_ogb.ogb930 #FUN-680001
  LET g_omb.omblegal = g_legal #FUN-980011 add
  LET g_omb.omb41 = g_ogb.ogb41  #專案
  LET g_omb.omb42 = g_ogb.ogb42  #WBS
  IF NOT cl_null(g_omb.omb40) THEN
     LET l_azf141 = ''      #FUN-B80058
     SELECT azf14,azf141 INTO g_omb.omb33,l_azf141  #FUN-B80058 add azf141
       FROM azf_file
      WHERE azf01=g_omb.omb40 AND azf02='2' AND azfacti='Y'
  END IF
 
  IF g_aza.aza63='Y' AND cl_null(g_omb.omb331) THEN
     #LET g_omb.omb331 = g_omb.omb33
     LET g_omb.omb331 = l_azf141  #FUN-B80058 
  END IF
  LET g_omb.omb44= g_ogb.ogbplant   #FUN-9A0093  

#FUN-AC0027 --begin--
     #IF g_oma.oma00 = '12' THEN   #FUN-B10058
     IF g_oma.oma00 = '19' THEN    #FUN-B10058
        SELECT ogb49 INTO g_omb.omb45
          FROM ogb_file
         WHERE ogb01 = g_ogb.ogb01
           AND ogb03 = g_ogb.ogb03 
        IF g_oma.oma74 = '2' THEN
           SELECT ool36 INTO g_omb.omb33
             FROM ool_file
            WHERE ool01 = g_oma.oma13
            IF g_aza.aza63 = 'Y' THEN
               SELECT ool361 INTO g_omb.omb331 
                 FROM ool_file
                WHERE ool01 = g_oma.oma13 
            END IF 
        END IF    
     END IF    
#FUN-AC0027 --end--              
     #FUN-C60036--add--str
     IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
        SELECT omf19,omf19t INTO g_omb.omb16,g_omb.omb16t
          FROM omf_file
         WHERE omf01 = g_omf01
           AND omf00 = g_omf00
           AND omf02 = g_omf02
           AND omf12 = g_ogb.ogb03
           AND omf11 = g_ogb.ogb01
           AND omf04 IS NULL
           AND omf09 = l_azp01
        LET g_omb.omb18 = g_omb.omb16
        LET g_omb.omb18t = g_omb.omb16t
     END IF
     CALL cl_digcut(g_omb.omb16,g_azi04) RETURNING g_omb.omb16
     CALL cl_digcut(g_omb.omb16t,g_azi04)RETURNING g_omb.omb16t
     CALL cl_digcut(g_omb.omb18,g_azi04) RETURNING g_omb.omb18
     CALL cl_digcut(g_omb.omb18t,g_azi04)RETURNING g_omb.omb18t
     IF g_omb.omb32 = 0 THEN LET g_omb.omb32 = '' END IF
     #FUN-C60036--add--end
  LET g_omb.omb48 = 0   #FUN-D10101 add
  INSERT INTO omb_file VALUES(g_omb.*)
  IF STATUS OR SQLCA.SQLCODE THEN
     LET g_showmsg=g_omb.omb01,"/",g_omb.omb03                                              #NO.FUN-710050 
     CALL s_errmsg('omb01,omb03',g_showmsg,"ins omb",SQLCA.SQLCODE,1)                       #NO.FUN-710050  
     LET g_success='N' 
#FUN-AC0027 --begin--
  ELSE
     #FUN-C60036 --add--str
     IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN
     UPDATE omf_file SET omf04 = g_omb.omb01
      WHERE omf01 = g_oma.oma10 AND omf02 = g_oma.oma75
        AND omf11 = g_ogb.ogb01 AND omf12 = g_ogb.ogb03
        AND omf00 = g_omf00
     IF STATUS OR SQLCA.SQLCODE THEN
        LET g_showmsg=g_oma.oma10,"/",g_oma.oma75                                             
        CALL s_errmsg('omf01,omf02',g_showmsg,"upd omf",SQLCA.SQLCODE,1)                       
        LET g_success='N'
     END IF 
     END IF 
     #FUN-C60036--add--end
     IF g_oma.oma74 ='2' THEN
#        SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#          FROM omb_file 
#         WHERE omb01=g_oma.oma01 
#           AND omb46 ='1'
#        IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#        IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
       #SELECT SUM(omb14),SUM(omb16) INTO g_oma.oma73f,g_oma.oma73 #by elva
        SELECT SUM(omb14t),SUM(omb16t) INTO g_oma.oma73f,g_oma.oma73 #by elva
          FROM omb_file 
         WHERE omb01=g_oma.oma01 
        IF g_oma.oma73 IS NULL THEN LET g_oma.oma73=0 END IF
        IF g_oma.oma73f IS NULL THEN LET g_oma.oma73f=0 END IF
        UPDATE oma_file SET #oma50 = g_oma.oma50,
                            #oma50t= g_oma.oma50t,
                            oma73 = g_oma.oma73,
                            oma73f= g_oma.oma73f
         WHERE oma01 = g_oma.oma01                   
      ELSE
#         SELECT SUM(omb14),SUM(omb14t) INTO g_oma.oma50,g_oma.oma50t
#           FROM omb_file 
#          WHERE omb01=g_oma.oma01
#         IF g_oma.oma50 IS NULL THEN LET g_oma.oma50=0 END IF
#         IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t=0 END IF
         LET g_oma.oma73 = 0
         LET g_oma.oma73f= 0
         UPDATE oma_file SET #oma50 = g_oma.oma50,
                             #oma50t= g_oma.oma50t,
                             oma73 = g_oma.oma73,
                             oma73f= g_oma.oma73f
          WHERE oma01 = g_oma.oma01              
     END IF        
#FUN-AC0027 --end--                 
  END IF
END FUNCTION
 
 
FUNCTION p330_omc()
DEFINE l_omc        RECORD LIKE omc_file.*
DEFINE l_oas        RECORD LIKE oas_file.*
DEFINE l_omc03      LIKE omc_file.omc03
DEFINE l_oas02      LIKE oas_file.oas02
DEFINE l_sql        STRING
DEFINE l_n          LIKE type_file.num5          #No.FUN-680123 SMALLINT
DEFINE l_omc08      LIKE omc_file.omc08          #No.MOD-740428
DEFINE l_omc09      LIKE omc_file.omc09          #No.MOD-740428
DEFINE l_omc02      LIKE omc_file.omc02          #No.MOD-740428

  SELECT COUNT(*) INTO l_n FROM omc_file WHERE omc01 = g_oma.oma01  #TQC-CB0041 add
  IF l_n >0 THEN RETURN END IF   #TQC-CB0041  add
  #LET g_sql = "SELECT DISTINCT(oas02) FROM ",l_dbs CLIPPED,"oas_file ",
  LET g_sql = "SELECT DISTINCT(oas02) FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
              " WHERE oas01='",g_oma.oma32,"'"
  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102             
  PREPARE sel_oas_pre26 FROM g_sql
  EXECUTE sel_oas_pre26 INTO l_oas02
  INITIALIZE l_omc.* TO NULL
  IF l_oas02='1' THEN
     LET l_n=1
     #LET l_sql=" SELECT * FROM ",l_dbs CLIPPED,"oas_file WHERE oas01='",g_oma.oma32,"'" #No.FUN-9C0014 
     LET l_sql=" SELECT * FROM ",cl_get_target_table(g_plant_new,'oas_file'), #FUN-A50102
               " WHERE oas01='",g_oma.oma32,"'"
     CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102									
     CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  #FUN-A50102  
     PREPARE p300_omc_p  FROM l_sql   
     DECLARE p300_omc_cs CURSOR FOR p300_omc_p
     FOREACH p300_omc_cs INTO l_oas.*
       LET l_omc.omc01=g_oma.oma01
       LET l_omc.omc02=l_n
       LET l_omc.omc03=l_oas.oas04
      #CALL s_rdatem(g_oma.oma03,l_omc03,g_oma.oma02,g_oma.oma09,g_oma.oma02,g_dbs)    #TQC-B10107 mark
       #CALL s_rdatem(g_oma.oma03,l_omc03,g_oma.oma02,g_oma.oma09,g_oma.oma02,g_plant2) #TQC-B10107 #MOD-C60196 mark  
       CALL s_rdatem(g_oma.oma03,l_omc.omc03,g_oma.oma02,g_oma.oma09,g_oma.oma02,g_plant2) #MOD-C60196 add
            RETURNING l_omc.omc04,l_omc.omc05
       LET l_omc.omc06=g_oma.oma24
       LET l_omc.omc07=g_oma.oma60
       LET l_omc.omc08=0
       LET l_omc.omc09=0
       LET l_omc.omc10=0
       LET l_omc.omc11=0
       LET l_omc.omc12=g_oma.oma10
       LET l_omc.omc13=0
       LET l_omc.omc14=0
       LET l_omc.omc15=0
       LET l_omc.omclegal = g_legal #FUN-980011 add
       INSERT INTO omc_file VALUES(l_omc.*)
       IF SQLCA.sqlcode THEN
          CALL s_errmsg('oma01',l_omc.omc01,"insert omc_file",SQLCA.sqlcode,1)                                 #NO.FUN-710050  
          LET g_success='N'
          EXIT FOREACH
       ELSE
       	  LET l_n=l_n+1
       END IF       
     END FOREACH
  END IF
  IF l_oas02='2' OR cl_null(l_oas02) THEN
     LET l_omc.omc01=g_oma.oma01
     LET l_omc.omc02=1
     LET l_omc.omc03=g_oma.oma32
     LET l_omc.omc04=g_oma.oma11
     LET l_omc.omc05=g_oma.oma12
     LET l_omc.omc06=g_oma.oma24
     LET l_omc.omc07=g_oma.oma60
     LET l_omc.omc08=0
     LET l_omc.omc09=0
     LET l_omc.omc10=0
     LET l_omc.omc11=0
     LET l_omc.omc12=g_oma.oma10
     LET l_omc.omc13=0
     LET l_omc.omc14=0
     LET l_omc.omc15=0
     LET l_omc.omclegal = g_legal #FUN-980011 add
     INSERT INTO omc_file VALUES(l_omc.*)
     IF SQLCA.sqlcode THEN
        CALL s_errmsg('omc01',l_omc.omc01,"insert omc_file",SQLCA.sqlcode,1)                           #NO.FUN-710050   
        LET g_success='N'
     END IF
  END IF
   #No.MOD-740428 --start-- 為了消除小數位數四舍五入引起的誤差，將產生的誤差加入最后一筆數據
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
      UPDATE omc_file SET omc09 = omc09-(l_omc09-g_oma.oma56t),omc13=omc09-(l_omc09-g_oma.oma56t) #add omc13 MOD-D90122
       WHERE omc01 = g_oma.oma01
         AND omc02 = l_omc02
      IF SQLCA.sqlcode THEN
         CALL cl_err3("upd","omc_file",g_oma.oma01,l_omc02,SQLCA.sqlcode,"","",1)
         LET g_success ='N'
         RETURN
      END IF
   END IF
END FUNCTION
 
FUNCTION p330_chkdate()
   #DEFINE l_sql        LIKE type_file.chr1000  #No.TQC-B60121
   DEFINE l_sql        STRING                   #No.TQC-B60121
   DEFINE l_yy,l_mm    LIKE type_file.num5
   DEFINE l_where1,l_where2  STRING
   DEFINE l_where3  STRING                      #yinhy131216
   DEFINE l_wc      STRING                      #yinhy131216
 
#No.MOD-B50245 --begin
   LET l_where1 ="(oga07<>'Y' AND ",
                 "( YEAR(oga02) != YEAR('",g_date,"')",
                 "  OR  (YEAR(oga02) = YEAR('",g_date,"')",
                 "  AND MONTH(oga02) != MONTH('",g_date,"')))) "
#No.MOD-B50245 --end
   LET l_where2 ="(oga07='Y' AND ",
                 "(YEAR(oga02) > YEAR('",g_date,"')",
                 " OR  (YEAR(oga02) = YEAR('",g_date,"') ",
                 " AND MONTH(oga02) > MONTH('",g_date,"')))) "
 
   LET l_sql=
       "SELECT UNIQUE YEAR(oga02),MONTH(oga02) ",
       #"    FROM ",l_dbs CLIPPED,"oga_file,",l_dbs CLIPPED,"oay_file,",l_dbs CLIPPED,"azi_file",#No.FUN-9C0014
       "    FROM ",cl_get_target_table(g_plant_new,'oga_file'),",", #FUN-A50102
                   cl_get_target_table(g_plant_new,'oay_file'),",", #FUN-A50102
                   cl_get_target_table(g_plant_new,'azi_file'),     #FUN-A50102
       "   WHERE ",g_wc CLIPPED,
       "   AND oga_file.oga23=azi_file.azi01",
#No.MOD-B50245 --begin
#      "   AND (",l_where1," OR ",l_where2,") ",
      #"   AND (",l_where2,") ",    #MOD-D30026 mark
       "   AND (",l_where1," OR ",l_where2,") ",   #MOD-D30026
#No.MOD-B50245 --end
       "   AND ogaconf='Y' ",
       "   AND oga01 LIKE ltrim(rtrim(oayslip)) || '-%' AND oay11='Y'",
       "   AND oga00 IN ('1','4','5','6','B') ",          #MOD-9B0097 add B
       "   AND oga09 NOT IN ('1','9') AND ogapost='Y'",
       "   AND oga65 ='N' "
  #No.yinhy131216  --Beign
  IF g_aza.aza26 = '2' AND g_ooz.ooz65 = 'Y' THEN  
  	 LET l_wc=cl_replace_str(g_wc, "oga03", "oha03")
     LET l_wc=cl_replace_str(g_wc, "oga18", "oha04")
     LET l_wc=cl_replace_str(g_wc, "oga05", "oha05")
     LET l_wc=cl_replace_str(g_wc, "oga21", "oha21")
     LET l_wc=cl_replace_str(g_wc, "oga15", "oha15")
     LET l_wc=cl_replace_str(g_wc, "oga14", "oha14")
     LET l_wc=cl_replace_str(g_wc, "oga23", "oha23")
     LET l_wc=cl_replace_str(g_wc, "oga02", "oha02")
     LET l_wc=cl_replace_str(g_wc, "oga01", "oha01") 
  	 LET l_where3 = "(YEAR(oha02) > YEAR('",g_date,"')",
                    " OR  (YEAR(oha02) = YEAR('",g_date,"') ",
                    " AND MONTH(oha02) != MONTH('",g_date,"'))) "  
     LET l_sql = l_sql CLIPPED," UNION ",
         "SELECT UNIQUE YEAR(oha02),MONTH(oha02) ",
         "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),",",
                  cl_get_target_table(g_plant_new,'oay_file'),",",
                  cl_get_target_table(g_plant_new,'azi_file'),  
         "   WHERE ",l_wc CLIPPED,
         "   AND oha_file.oha23=azi_file.azi01",
         "   AND (",l_where3,") ", 
         "   AND ohaconf='Y' ",
         "   AND oha01 like trim(oayslip)||'-%' ",
         "   AND oha09 IN ('1','4','5') "
   END IF
   #No.yinhy131216  --End
   CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql  #FUN-A50102
   PREPARE p330_prechk FROM l_sql
   IF STATUS THEN CALL cl_err('p330_prechk',STATUS,1)
      LET g_success = 'N'
      LET l_flag1='X' RETURN
   END IF
   DECLARE p330_chkdate CURSOR WITH HOLD FOR p330_prechk
   FOREACH p330_chkdate INTO l_yy,l_mm
      LET g_success = 'N'
      LET l_flag1='Y'
      EXIT FOREACH
   END FOREACH
 
END FUNCTION
 
  
FUNCTION p330_oha2oga(p_oha01)
   DEFINE p_oha01     LIKE oha_file.oha01
   DEFINE l_oha       RECORD LIKE oha_file.*

   #LET g_sql = "SELECT * FROM ",l_dbs CLIPPED,"oha_file WHERE oha01 = '",p_oha01,"'"
   LET g_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'oha_file'), #FUN-A50102
               " WHERE oha01 = '",p_oha01,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102
   PREPARE sel_oha_pre27 FROM g_sql
   EXECUTE sel_oha_pre27 INTO l_oha.*
   IF SQLCA.sqlcode THEN
      CALL s_errmsg('oha01',p_oha01,'select oha',SQLCA.sqlcode,1)
      LET g_success = 'N'
      RETURN
   END IF

   INITIALIZE g_oga.* TO NULL

   LET g_oga.oga00   = '1'              #出貨別
   LET g_oga.oga01   = l_oha.oha01      #出貨單號
   LET g_oga.oga011  = ''               #出貨通知單號
   LET g_oga.oga02   = l_oha.oha02      #出貨日期
   LET g_oga.oga021  = NULL             #結關日期
   LET g_oga.oga022  = NULL             #裝船日期
   LET g_oga.oga03   = l_oha.oha03      #帳款客戶編號
   LET g_oga.oga032  = l_oha.oha032     #帳款客戶簡稱
   LET g_oga.oga033  = NULL             #帳款客戶稅號
   LET g_oga.oga04   = l_oha.oha04      #送貨客戶編號
   LET g_oga.oga044  = NULL             #送貨地址碼
#  LET g_oga.oga05   = NULL             #發票別 #MOD-AA0156
   LET g_oga.oga05   = '1'              #發票別 #MOD-AA0156
   LET g_oga.oga06   = NULL             #更改版本
   LET g_oga.oga07   = 'N'              #出貨是否計入未開發票的銷貨待驗收入
   LET g_oga.oga08   = l_oha.oha08      #1.內銷 2.外銷  3.視同外銷
   LET g_oga.oga09   = '2'              #單據別
   LET g_oga.oga10   = l_oha.oha10      #帳單編號
   LET g_oga.oga11   = g_date           #應收款日
   LET g_oga.oga12   = g_date           #容許票據到期日
   LET g_oga.oga13   = NULL             #科目分類碼
   LET g_oga.oga14   = l_oha.oha14      #人員編號
   LET g_oga.oga15   = l_oha.oha15      #部門編號
   #LET g_sql = "SELECT oga16 FROM ",l_dbs CLIPPED,"oga_file WHERE oga01 = '",l_oha.oha16,"'"
   LET g_sql = "SELECT oga16 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
               " WHERE oga01 = '",l_oha.oha16,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102
   PREPARE sel_oga_pre28 FROM g_sql
   EXECUTE sel_oga_pre28 INTO g_oga.oga16
   LET g_oga.oga161  = 0                #訂金應收比率
   LET g_oga.oga162  = 100              #出貨應收比率
   LET g_oga.oga163  = 0                #尾款應收比率
   LET g_oga.oga17   = NULL             #排貨模擬順序
   LET g_oga.oga18   = l_oha.oha04      #收款客戶編號
   LET g_oga.oga19   = NULL             #待抵帳款-預收單號
   LET g_oga.oga20   = 'Y'              #分錄底稿是否可重新生成
   LET g_oga.oga21   = l_oha.oha21      #稅種
   LET g_oga.oga211  = l_oha.oha211     #稅率
   LET g_oga.oga212  = l_oha.oha212     #聯數
   LET g_oga.oga213  = l_oha.oha213     #含稅否
   LET g_oga.oga23   = l_oha.oha23      #幣種
   LET g_oga.oga24   = l_oha.oha24      #匯率
   LET g_oga.oga25   = l_oha.oha25      #銷售分類一
   LET g_oga.oga26   = l_oha.oha26      #銷售分類二
   LET g_oga.oga27   = NULL             #Invoice No.
   LET g_oga.oga28   = NULL             #立帳時採用訂單匯率
   LET g_oga.oga29   = 0                #信用額度餘額
   LET g_oga.oga30   = 'N'              #包裝單審核碼
   LET g_oga.oga31   = l_oha.oha31      #價格條件編號
   LET g_oga.oga32   = NULL             #收款條件編號
   LET g_oga.oga33   = NULL             #其它條件
   LET g_oga.oga34   = 0                #佣金率
   LET g_oga.oga35   = NULL             #外銷方式
   LET g_oga.oga36   = NULL             #非經海關証明文件名稱
   LET g_oga.oga37   = NULL             #非經海關証明文件號碼
   LET g_oga.oga38   = NULL             #出口報單類型
   LET g_oga.oga39   = NULL             #出口報單號碼
   LET g_oga.oga40   = NULL             #NOTIFY
   LET g_oga.oga41   = NULL             #起運地
   LET g_oga.oga42   = NULL             #到達地
   LET g_oga.oga43   = NULL             #交運方式
   LET g_oga.oga44   = NULL             #嘜頭編號
   LET g_oga.oga45   = l_oha.oha14      #聯絡人
   LET g_oga.oga46   = NULL             #項目編號
   LET g_oga.oga47   = NULL             #船名/車號
   LET g_oga.oga48   = NULL             #航次
   LET g_oga.oga49   = NULL             #卸貨港
   LET g_oga.oga50   = l_oha.oha50      #原幣出貨金額
   LET g_oga.oga501  = l_oha.oha50      #本幣出貨金額
   LET g_oga.oga51   = l_oha.oha1008    #原幣出貨金額
   LET g_oga.oga511  = l_oha.oha1008    #本幣出貨金額
   LET g_oga.oga52   = 0                #原幣預收訂金轉銷貨收入金額
   LET g_oga.oga53   = l_oha.oha53      #原幣應開發票稅前金額
   LET g_oga.oga54   = l_oha.oha54      #原幣已開發票稅前金額
   LET g_oga.oga99   = l_oha.oha99      #多角貿易流程序號
   LET g_oga.oga901  = NULL             #post to abx system flag
   LET g_oga.oga902  = NULL             #信用超限留置代碼
   LET g_oga.oga903  = 'Y'              #信用檢查放行否
   LET g_oga.oga904  = NULL             #No Use
   LET g_oga.oga905  = l_oha.oha44      #已轉三角貿易出貨單否
   LET g_oga.oga906  = l_oha.oha43      #起始出貨單否
   LET g_oga.oga907  = NULL             #憑証號碼
   LET g_oga.oga908  = 'N'              #L/C NO
   LET g_oga.oga909  = l_oha.oha41      #三角貿易否
   LET g_oga.oga910  = ' '              #境外倉庫
   LET g_oga.oga911  = ' '              #境外庫位
   LET g_oga.ogaconf = l_oha.ohaconf    #審核否/作廢碼
   LET g_oga.ogapost = l_oha.ohapost    #出貨扣帳否
   LET g_oga.ogaprsw = l_oha.ohaprsw    #打印次數
   LET g_oga.ogauser = l_oha.ohauser    #資料所有者
   LET g_oga.ogagrup = l_oha.ohagrup    #資料所有部門
   LET g_oga.ogamodu = l_oha.ohamodu    #資料更改者
   LET g_oga.ogadate = l_oha.ohadate    #最近更改日
   LET g_oga.oga55   = l_oha.oha55      #狀況碼
   LET g_oga.ogamksg = l_oha.ohamksg    #簽核
   LET g_oga.oga65   = 'N'              #客戶出貨簽收否
   LET g_oga.oga66   = ' '              #出貨簽收在途/驗退倉庫
   LET g_oga.oga67   = ' '              #出貨簽收在途/驗退庫位
   LET g_oga.oga1001 = l_oha.oha1001    #收款客戶編號
   LET g_oga.oga1002 = l_oha.oha1002    #債權代碼
   LET g_oga.oga1003 = l_oha.oha1003    #業績歸屬方
   LET g_oga.oga1004 = l_oha.oha1004    #調貨客戶
   LET g_oga.oga1005 = l_oha.oha1005    #是否計算業績
   LET g_oga.oga1006 = l_oha.oha1006    #折扣金額(稅前)
   LET g_oga.oga1007 = l_oha.oha1007    #折扣金額(含稅)
   LET g_oga.oga1008 = l_oha.oha1008    #出貨總含稅金額
   LET g_oga.oga1009 = l_oha.oha1009    #客戶所屬渠道
   LET g_oga.oga1010 = l_oha.oha1010    #客戶所屬方
   LET g_oga.oga1011 = l_oha.oha1011    #開票客戶
   LET g_oga.oga1012 = l_oha.oha1012    #銷退單單號
   LET g_oga.oga1013 = 'Y'              #已打印提單否
   LET g_oga.oga1014 = 'N'              #調貨銷退單所自動生成否
   LET g_oga.oga1015 = l_oha.oha1017    #導物流狀況碼
   LET g_oga.oga1016 = l_oha.oha1014    #代送商
   LET g_oga.oga68   = NULL             #No Use
   LET g_oga.ogaspc  = NULL             #SPC拋轉碼 0/1/2
   LET g_oga.oga69   = NULL             #錄入日期
   LET g_oga.oga912  = l_oha.oha100     #保稅異動原因代碼
   LET g_oga.oga913  = l_oha.oha102     #保稅報單日期
   LET g_oga.oga914  = NULL             #入庫單號
   LET g_oga.oga70   = NULL             #調撥單號
   LET g_oga.ogaud01 = l_oha.ohaud01    #自訂欄位-Textedit
   LET g_oga.ogaud02 = l_oha.ohaud02    #自訂欄位-文字
   LET g_oga.ogaud03 = l_oha.ohaud03    #自訂欄位-文字
   LET g_oga.ogaud04 = l_oha.ohaud04    #自訂欄位-文字
   LET g_oga.ogaud05 = l_oha.ohaud05    #自訂欄位-文字
   LET g_oga.ogaud06 = l_oha.ohaud06    #自訂欄位-文字
   LET g_oga.ogaud07 = l_oha.ohaud07    #自訂欄位-數值
   LET g_oga.ogaud08 = l_oha.ohaud08    #自訂欄位-數值
   LET g_oga.ogaud09 = l_oha.ohaud09    #自訂欄位-數值
   LET g_oga.ogaud10 = l_oha.ohaud10    #自訂欄位-整數
   LET g_oga.ogaud11 = l_oha.ohaud11    #自訂欄位-整數
   LET g_oga.ogaud12 = l_oha.ohaud12    #自訂欄位-整數
   LET g_oga.ogaud13 = l_oha.ohaud13    #自訂欄位-日期
   LET g_oga.ogaud14 = l_oha.ohaud14    #自訂欄位-日期
   LET g_oga.ogaud15 = l_oha.ohaud15    #自訂欄位-日期
   LET g_oga.oga83   = NULL             #銷貨機構
   LET g_oga.oga84   = NULL             #取貨機構
   LET g_oga.oga85   = l_oha.oha85      #結算方式
   LET g_oga.oga86   = l_oha.oha86      #客層代碼
   LET g_oga.oga87   = l_oha.oha87      #會員卡號
   LET g_oga.oga88   = l_oha.oha88      #顧客姓名
   LET g_oga.oga89   = l_oha.oha89      #聯系電話
   LET g_oga.oga90   = l_oha.oha90      #證件類型
   LET g_oga.oga91   = l_oha.oha91      #證件號碼
   LET g_oga.oga92   = l_oha.oha92      #贈品發放單號
   LET g_oga.oga93   = l_oha.oha93      #返券發放單號
   LET g_oga.oga94   = l_oha.oha94      #POS銷售否 Y-是,N-否
   LET g_oga.oga95   = l_oha.oha95      #本次積分
   LET g_oga.oga96   = l_oha.oha96      #收銀機號
   LET g_oga.oga97   = l_oha.oha97      #交易序號
   LET g_oga.ogacond = l_oha.ohacond    #審核日期
   LET g_oga.ogaconu = l_oha.ohaconu    #審核人員
   LET g_oga.ogaplant= l_oha.ohaplant   #所屬工廠
   LET g_oga.ogalegal= l_oha.ohalegal   #所屬法人
   LET g_oga.oga71   = NULL             #申報統編
#No.FUN-AC0027 --begin
   LET g_oga.oga57 = l_oha.oha57
   IF cl_null(g_oga.oga57) THEN
      LET g_oga.oga57 = '1'
   END IF
#No.FUN-AC0027 --end

END FUNCTION

FUNCTION p330_ohb2ogb(p_ohb01,p_ohb03) 
   DEFINE p_ohb01     LIKE ohb_file.ohb01
   DEFINE p_ohb03     LIKE ohb_file.ohb03
   DEFINE l_ohb       RECORD LIKE ohb_file.*

   #LET g_sql = "SELECT * FROM ",l_dbs CLIPPED,"ohb_file",
   LET g_sql = "SELECT * FROM ",cl_get_target_table(g_plant_new,'ohb_file'), #FUN-A50102
               " WHERE ohb01 = '",p_ohb01,"'",
               "   AND ohb03 = '",p_ohb03,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102									
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102            
   PREPARE sel_oga_pre29 FROM g_sql
   EXECUTE sel_oga_pre29 INTO l_ohb.*
   IF SQLCA.sqlcode AND NOT cl_null(p_ohb01) THEN
      LET g_showmsg = p_ohb01,'/',p_ohb03
      CALL s_errmsg('ohb01,ohb03',g_showmsg,'select ohb',SQLCA.sqlcode,1)
      LET g_success = 'N'
      RETURN
   END IF

   LET g_ogb.ogb01     = l_ohb.ohb01         #出貨單號
   LET g_ogb.ogb03     = l_ohb.ohb03         #項次
   LET g_ogb.ogb04     = l_ohb.ohb04         #產品編號
   LET g_ogb.ogb05     = l_ohb.ohb05         #銷售單位
   LET g_ogb.ogb05_fac = l_ohb.ohb05_fac     #銷售/庫存彙總單位換算率
   LET g_ogb.ogb06     = l_ohb.ohb06         #品名規格
   LET g_ogb.ogb07     = l_ohb.ohb07         #額外品名編號
   LET g_ogb.ogb08     = l_ohb.ohb08         #出貨營運中心編號
   LET g_ogb.ogb09     = l_ohb.ohb09         #出貨倉庫編號
   LET g_ogb.ogb091    = l_ohb.ohb091        #出貨儲位編號
   LET g_ogb.ogb092    = l_ohb.ohb092        #出貨批號
   LET g_ogb.ogb11     = l_ohb.ohb11         #客戶產品編號
   LET g_ogb.ogb12     = l_ohb.ohb12         #實際出貨數量
   LET g_ogb.ogb13     = l_ohb.ohb13         #原幣單價
   LET g_ogb.ogb14     = l_ohb.ohb14         #原幣未稅金額
   LET g_ogb.ogb14t    = l_ohb.ohb14t        #原幣含稅金額
   LET g_ogb.ogb15     = l_ohb.ohb15         #庫存明細單位由廠/倉/儲/批自動得出
   LET g_ogb.ogb15_fac = l_ohb.ohb15_fac     #銷售/庫存明細單位換算率
   LET g_ogb.ogb16     = l_ohb.ohb16         #數量
   LET g_ogb.ogb17     = 'N'                 #多倉儲批出貨否
   LET g_ogb.ogb18     = 0                   #預計出貨數量
   LET g_ogb.ogb19     = l_ohb.ohb61         #檢驗否
   LET g_ogb.ogb20     = NULL                #No Use
   LET g_ogb.ogb21     = NULL                #No Use
   LET g_ogb.ogb22     = NULL                #No Use
   LET g_ogb.ogb31     = l_ohb.ohb33         #訂單單號
   LET g_ogb.ogb32     = l_ohb.ohb34         #訂單項次
   LET g_ogb.ogb60     = l_ohb.ohb60         #已開發票數量
   LET g_ogb.ogb63     = 0                   #銷退數量
   LET g_ogb.ogb64     = 0                   #銷退數量
   LET g_ogb.ogb901    = NULL                #No Use
   LET g_ogb.ogb902    = NULL                #No Use
   LET g_ogb.ogb903    = NULL                #No Use
   LET g_ogb.ogb904    = NULL                #No Use
   LET g_ogb.ogb905    = NULL                #No Use
   LET g_ogb.ogb906    = NULL                #No Use
   LET g_ogb.ogb907    = NULL                #No Use
   LET g_ogb.ogb908    = NULL                #手冊編號
   LET g_ogb.ogb909    = NULL                #No Use
   LET g_ogb.ogb910    = l_ohb.ohb910        #單位一
   LET g_ogb.ogb911    = l_ohb.ohb911        #單位一換算率(與銷售單位)
   LET g_ogb.ogb912    = l_ohb.ohb912        #單位一數量
   LET g_ogb.ogb913    = l_ohb.ohb913        #單位二
   LET g_ogb.ogb914    = l_ohb.ohb914        #單位二換算率(與銷售單位)
   LET g_ogb.ogb915    = l_ohb.ohb915        #單位二數量
   LET g_ogb.ogb916    = l_ohb.ohb916        #計價單位
   LET g_ogb.ogb917    = l_ohb.ohb917        #計價數量
   LET g_ogb.ogb65     = l_ohb.ohb50         #驗退理由碼
   LET g_ogb.ogb1001   = NULL                #原因碼
   LET g_ogb.ogb1002   = l_ohb.ohb1001       #訂價代號
   LET g_ogb.ogb1005   = l_ohb.ohb1005       #作業方式
   LET g_ogb.ogb1007   = l_ohb.ohb1007       #現金折扣單號
   LET g_ogb.ogb1008   = l_ohb.ohb1008       #稅別
   LET g_ogb.ogb1009   = l_ohb.ohb1009       #稅率
   LET g_ogb.ogb1010   = l_ohb.ohb1010       #含稅否
   LET g_ogb.ogb1011   = l_ohb.ohb1011       #非直營KAB
   LET g_ogb.ogb1003   = l_ohb.ohb1003       #預計出貨日期
   LET g_ogb.ogb1004   = l_ohb.ohb1002       #提案代號
   LET g_ogb.ogb1006   = l_ohb.ohb1003       #折扣率
   LET g_ogb.ogb1012   = l_ohb.ohb1004       #搭贈
   LET g_ogb.ogb930    = l_ohb.ohb930        #成本中心
   LET g_ogb.ogb1013   = 0                   #已開發票未稅金額
   LET g_ogb.ogb1014   = 'N'                 #保稅已放行否
   LET g_ogb.ogb41     = NULL                #專案代號
   LET g_ogb.ogb42     = NULL                #WBS編號
   LET g_ogb.ogb43     = NULL                #活動代號
   LET g_ogb.ogb931    = NULL                #包裝編號
   LET g_ogb.ogb932    = 0                   #包裝數量
   LET g_ogb.ogbud01   = l_ohb.ohbud01       #自訂欄位-Textedit
   LET g_ogb.ogbud02   = l_ohb.ohbud02       #自訂欄位-文字
   LET g_ogb.ogbud03   = l_ohb.ohbud03       #自訂欄位-文字
   LET g_ogb.ogbud04   = l_ohb.ohbud04       #自訂欄位-文字
   LET g_ogb.ogbud05   = l_ohb.ohbud05       #自訂欄位-文字
   LET g_ogb.ogbud06   = l_ohb.ohbud06       #自訂欄位-文字
   LET g_ogb.ogbud07   = l_ohb.ohbud07       #自訂欄位-數值
   LET g_ogb.ogbud08   = l_ohb.ohbud08       #自訂欄位-數值
   LET g_ogb.ogbud09   = l_ohb.ohbud09       #自訂欄位-數值
   LET g_ogb.ogbud10   = l_ohb.ohbud10       #自訂欄位-整數
   LET g_ogb.ogbud11   = l_ohb.ohbud11       #自訂欄位-整數
   LET g_ogb.ogbud12   = l_ohb.ohbud12       #自訂欄位-整數
   LET g_ogb.ogbud13   = l_ohb.ohbud13       #自訂欄位-日期
   LET g_ogb.ogbud14   = l_ohb.ohbud14       #自訂欄位-日期
   LET g_ogb.ogbud15   = l_ohb.ohbud15       #自訂欄位-日期
   LET g_ogb.ogb44     = l_ohb.ohb64         #經營方式
   LET g_ogb.ogb45     = l_ohb.ohb64         #原扣率
   LET g_ogb.ogb46     = l_ohb.ohb64         #新扣率
   LET g_ogb.ogb47     = l_ohb.ohb64         #分攤折價=全部折價字段值的和
   LET g_ogb.ogbplant  = l_ohb.ohbplant      #所屬工廠
   LET g_ogb.ogblegal  = l_ohb.ohblegal      #所屬法人
   #FUN-C60036--add--str
   IF g_oaz92 = 'Y' AND g_aza.aza26 = '2' THEN 
      SELECT omf28,omf917 INTO g_ogb.ogb13,g_ogb.ogb917 FROM omf_file 
       WHERE omf01 = g_omf01
         AND omf00 = g_omf00  #minpp
         AND omf02 = g_omf02
         AND omf12 = p_ohb03
         AND omf11 = p_ohb01
         AND omf04 IS NULL
         AND omf09 = g_plant_new
   END IF 
   #FUN-C60036--add--end
END FUNCTION
#No.FUN-9C0072 精簡程式碼  
#FUN-C60036--add--str
FUNCTION p330_omf(p_azp01,p_sr)
   DEFINE p_azp01 LIKE azp_file.azp01,
   p_sr         RECORD
            omf00      LIKE omf_file.omf00,   #minpp 
            omf01      LIKE omf_file.omf01,             
            omf02      LIKE omf_file.omf02,             
            oga94      LIKE oga_file.oga94,             
            ogb31      LIKE ogb_file.ogb31,             
            order1     LIKE oga_file.oga01,                        
            order2     LIKE oga_file.oga01,             
            oga01      LIKE oga_file.oga01,
            ogaplant   LIKE oga_file.ogaplant,         
            oga011     LIKE oga_file.oga011,
            oga03      LIKE oga_file.oga03,
            oga18      LIKE oga_file.oga18,            
            oga05      LIKE oga_file.oga05,
            oga21      LIKE oga_file.oga21,
            oga15      LIKE oga_file.oga15,
            oga14      LIKE oga_file.oga14,
            oga23      LIKE oga_file.oga23,
            oga02      LIKE oga_file.oga02, 
            oga11      LIKE oga_file.oga11,  
            oga27      LIKE oga_file.oga27,            
            oga08      LIKE oga_file.oga08, 
            type       LIKE type_file.chr1,
            omf25      LIKE omf_file.omf25,     #150701wudj
            ta_omf01   LIKE omf_file.ta_omf01  #add by zhaoxiangb 150722
                       END RECORD
   DEFINE l_omf07      LIKE omf_file.omf07
   LET l_omf07 = g_oga.oga23
   LET g_oga.oga23 = ''
  #SELECT DISTINCT omf03,omf01,omf02,omf05,omf06,omf07,omf22  #FUN-D50008 mark
   SELECT DISTINCT omf31,omf01,omf02,omf05,omf06,omf07,omf22  #FUN-D50008 add
     INTO g_oma.oma09,g_oma.oma10,g_oma.oma75,g_oga.oga03,g_oga.oga21,g_oga.oga23
          ,g_oma.oma24
     FROM omf_file
    WHERE omf01 = p_sr.omf01 AND omf02 = p_sr.omf02
      AND omf00 = p_sr.omf00                          #minpp
      AND omf08 = 'Y'
      AND omf04 IS NULL
     #AND omf09 = p_azp01
   SELECT gec04,gec05 INTO g_oga.oga211,g_oga.oga212 FROM gec_file 
    WHERE gec01 = g_oga.oga21 AND gec011= '2'
   IF cl_null(g_oga.oga23) THEN LET g_oga.oga23 = l_omf07 END IF 
END FUNCTION  

FUNCTION p330_axrt320()
   DEFINE l_ooyacti LIKE ooy_file.ooyacti
   DEFINE p_row,p_col      LIKE type_file.num5
   DEFINE   li_result LIKE type_file.num5
   OPEN WINDOW p330a_w AT p_row,p_col WITH FORM "axr/42f/axrp310a"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) 
   CALL cl_ui_locale("axrp310a")
   CALL cl_load_act_sys("axrp310a")
   CALL cl_load_act_list("axrp310a")
   CALL cl_set_comp_visible("oma05,oma10",FALSE)
   CLEAR FORM
   INPUT  g_no1  WITHOUT DEFAULTS FROM oma01 

      AFTER FIELD oma01
         IF NOT cl_null(g_no1) THEN
            LET l_ooyacti = NULL
            SELECT ooyacti INTO l_ooyacti FROM ooy_file
             WHERE ooyslip = g_no1
            IF l_ooyacti <> 'Y' THEN
               CALL cl_err(g_no1,'axr-956',1)
               NEXT FIELD oma01 
            END IF
            CALL s_check_no("axr",g_no1,"","12","","","")
            RETURNING li_result,g_no1

            IF (NOT li_result) THEN
               NEXT FIELD oma01 
            END IF
         ELSE
            NEXT FIELD oma01
         END IF
      ON ACTION CONTROLR
        CALL cl_show_req_fields()

      ON ACTION CONTROLG
        CALL cl_cmdask()
      ON ACTION CONTROLP
         CASE
             WHEN INFIELD(oma01)
                CALL q_ooy(FALSE,FALSE,g_no1,'12','AXR') RETURNING g_no1
                DISPLAY  g_no1  TO oma01
            END CASE
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT INPUT

   END INPUT

   IF INT_FLAG THEN
      CLOSE WINDOW p330a_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF
   CLOSE WINDOW p330a_w
   LET g_wc2 = ' 1=1'
   LET g_wc1 = ' 1=1'
END FUNCTION 
#FUN-C60036--add--end


