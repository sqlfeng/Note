# Prog. Version..: '5.25.03-11.08.03(00010)'     #
#
# Modify ........: No.FUN-4C0013 04/12/01 By ching 單價,金額改成 DEC(20,6)
# Modify ........: No.FUN-590100 05/09/01 By elva 新增紅衝功能
# Modify.........: No.TQC-5B0080 05/11/28 By ice  生成分錄底稿時,貸項也應考慮oot_file
# Modify.........: NO.FUN-5C0015 05/12/20 By TSD.Sideny call s_def_npq:抓取異動碼default值
# Modify.........: No.FUN-660116 06/06/19 By ice cl_err --> cl_err3
# Modify.........: No.FUN-680001 06/08/01 By kim GP3.5 利潤中心
# Modify.........: No.FUN-670047 06/08/09 By Ray 增加兩帳套功能
# Modify.........: No.FUN-680123 06/09/18 By hongmei 欄位類型轉換
# Modify.........: No.FUN-660073 06/11/24 By Nicola 訂單樣品修改
# Modify.........: No.MOD-690136 06/12/08 By Smapmin 已立待驗收入分錄者必須加以沖銷
# Modify.........: No.FUN-710050 07/01/20 By Jackho 增加批處理錯誤統整功能
# Modify.........: No.MOD-730062 07/03/19 By Smapmin 關係人代碼已改為npq37
# Modify.........: No.FUN-740009 07/04/03 By Elva   會計科目加帳套
# Modify.........: No.TQC-740309 07/04/25 By Rayven 生成分錄底稿時分錄底稿二的銷項稅金科目錯誤,取的是科目一的銷項稅金科目
# Modify.........: No.MOD-750132 07/05/30 By Smapmin 調整關係人異動碼相關程式段
# Modify.........: No.MOD-780052 07/08/09 By Smapmin 將摘要(npq04)的舊值清空
# Modify.........: No.TQC-7B0035 07/11/06 By wujie   生成的分錄底稿二收入科目取錯，取的是科目一中的科目
# Modify.........: No.MOD-820056 08/02/14 By Smapmin 分錄金額不可為0
# Modify.........: No.FUN-810045 08/03/06 By Rainy  項目管理:WBS編碼放入異動碼9，費用原因(apb31)放入異動碼10
# Modify.........: No.MOD-840523 08/04/22 By Carrier 對樣品單身生成npq_file時,加上過濾條件單價為0的
# Modify.........: No.CHI-840048 08/05/05 By Smapmin 增加預收匯差的分錄
# Modify.........: No.TQC-860031 08/06/18 By lumx 將預收款 的貸方npq23的賦值調整到賬款審核之后，因為oma19會在審核之后才會產生
# Modify.........: No.MOD-860185 08/07/01 By Sarah IF NOT cl_null(g_oma.oma19)時,npq07f與npq07的金額應該與此次入庫金額做比例計算
# Modify.........: No.MOD-890196 08/10/09 By Sarah 若出貨單已在出貨時產生暫估應收分錄,axrt300產生分錄時,也要做沖暫估匯兌損益的處理
# Modify.........: No.CHI-830037 08/10/17 By jan 請調整將目前財務架構中使用關系人的地方,請統一使用"代碼",而非"簡稱"
# Modify.........: No.MOD-8C0161 08/12/18 By Sarah 依單身會科產生底稿者,單身又有維護成本中心欄位,部門應帶入單身的成本中心
# Modify.........: No.MOD-8C0223 08/12/29 By Sarah l_oga07='Y'段計算分錄金額時未扣除oot_file的金額,造成分錄有誤
# Modify.........: No.MOD-910005 09/01/05 By Nicola 借方科目預設改為ool47銷貨折讓會科
# Modify.........: No.MOD-920066 09/02/05 By Sarah 產生暫估應收分錄時,金額應做取位,匯兌損益改為抓借貸方差額
# Modify.........: No.MOD-940085 09/04/08 By lilingyu npq05的給值應該判斷該科目是否需做部門管理
# Modify.........: No.MOD-950096 09/05/12 By lilingyu 判斷當科目有做預算管理時,才需將費用原因寫入npq36
# Modify.........: No.FUN-960141 09/06/26 By dongbg GP5.2修改:增加oma00 = '15'等類別的處理
# Modify.........: No.FUN-980011 09/08/25 By TSD.apple    GP5.2架構重整，修改 INSERT INTO 語法

# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.MOD-970129 09/09/21 By baofei 修改如果出貨已產生過發票,則在axr300產生分錄底稿時會多產生一個貸方金額
# Modify.........: No:FUN-9C0014 09/12/03 By shiwuying axrp310改為可從同法人下不同DB抓資料
# Modify.........: No.FUN-9C0109 09/12/29 By lutingting 賬款類型為15以及18產生得分錄貸方科目應抓預收科目
# Modify.........: No:FUN-A10104 10/01/19 By shiwuying 函數傳參部份修改
# Modify.........: No.MOD-A20056 10/03/04 By sabrina 如果要做專案管理，需將專案編號的值帶給npq08
# Modify.........: No.MOD-A30083 10/03/15 By sabrina 若oga07='Y'，產生應收時，分錄底稿會多產生一個貸方金額
# Modify.........: No.MOD-A30196 10/03/25 By Summer 產生分錄底稿關係人異動碼資料時，邏輯應一致
# Modify.........: No.FUN-A30077 10/03/23 By Carrier 按余额类型产生分录aag24='Y'时,分录方向要按设定来处理
# Modify.........: No.CHI-A50040 10/06/02 By 尾款貸方產生銷貨收入
# Modify.........: No:FUN-A50103 10/06/03 By Nicola 訂單多帳期
# Modify.........: No.FUN-A50102 10/07/02 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No.FUN-A60056 10/07/08 By lutingting GP5.2財務串前段問題整批調整
# Modify.........: No.FUN-9A0036 10/08/04 By chenmoyan 勾選二套帳，分錄底稿二的匯率及本幣金額，應依帳別二進行換算
# Modify.........: No.FUN-A40033 10/08/04 By chenmoyan 二套帳時如果第二套帳幣別和本幣不相同，借貸不平衡產生匯損益時要切立科目
# Modify.........: No.FUN-A40067 10/08/04 By chenmoyan 處理二套帳中本幣金額取位
# Modify.........: No.FUN-A60007 10/08/15 By chenmoyan 遞延分錄在AR分錄產生
# Modify.........: No.FUN-950053 10/08/18 By vealxu 廠商基本資料的關係人設定搭配異動碼彈性設定
# Modify.........: No.MOD-A90028 10/09/06 By Dido 若單身有銷貨收入時,會影響遞延收入重複產生
# Modify.........: NO.MOD-AC0033 10/12/07 BY Dido 若出貨單有產生待驗分錄者,不須再產生預收分錄
# Modify.........: NO.FUN-AC0027 10/12/13 By zhangll 流通整合之財務
# Modify.........: NO.MOD-AC0407 10/12/29 BY Dido 銷貨收入單身若有科目應以 oma162 > 0 為主
# Modify.........: NO.TQC-B10024 11/01/06 BY Dido 取消 transation 架構
# Modify.........: NO.TQC-B10108 11/01/13 By zhangll 修正分录底稿客户栏位发生未赋值的情况
# Modify.........: NO.MOD-B10123 11/01/18 BY Dido 若有預收訂金時,單身銷貨收入需扣除訂金金額
# Modify.........: No.FUN-AB0110 11/01/25 By chenmoyan 銷貨折讓類應收于分錄產生時不再移除分割遞延收入科目,但單據確認時要寫入oct_file
# Modify.........: NO.MOD-B10210 11/01/26 BY Dido 在 s_t300_chk_ocs 函式後增加清空 g_sql 動作
# Modify.........: No.FUN-B10058 11/01/25 By lutingting 流通财务改善
# Modify.........: No.FUN-AA0087 11/01/30 By chenmoyan 異動碼類型設定改善
# Modify.........:               11/02/09 By chenmoyan 因FUN-B10058先行過單,MARK FUN-AB0110,FUN-AA0087
# Modify.........:               11/02/09 By chenmoyan 因FUN-B10058先行過單,MARK FUN-AB0110,FUN-AA0087,現做REMARK
# Modify.........: No.FUN-B40032 11/04/14 By baogc 增加健康捐等部份的邏輯
# Modify.........: No:CHI-B50018 11/05/10 By Sarah 當oma00='12'時才做MOD-B10123處理,oma00='14'時做原處理
# Modify.........: No:FUN-B40056 11/05/12 By guoch 刪除資料時一併刪除tic_file的資料
# Modify.........: No:TQC-B50087 11/05/17 By Dido 出貨預收訂金取消貸方銷貨收入,原MOD-B10123取消
# Modify.........: No:MOD-B60021 11/06/03 By Dido 匯差匯率與幣別應在實際發生時再給予
# Modify.........: No:MOD-B60059 11/06/08 By Dido 預收若為100%則需產生銷貨收入分錄
# Modify.........: No:TQC-B60089 11/06/15 By Dido 出貨預收若有超交時,應依倒扣方式計算
# Modify.........: No:CHI-B60028 11/06/30 By Sarah 2*類帳款也可依單身科目產生分錄
# Modify.........: No:TQC-B70021 11/07/19 By wujie 抛转tic_file资料
# Modify.........: No:FUN-B70059 11/07/19 by belle 增加條件選項-客戶
# Modify.........: No:TQC-B80021 11/08/02 by Dido 檢核匯差時,分錄二應需轉換匯率

DATABASE ds

#GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"   #mod by zhangym 120717
   DEFINE g_oma		RECORD LIKE oma_file.*
   DEFINE g_ool		RECORD LIKE ool_file.*
   DEFINE g_npp		RECORD LIKE npp_file.*
   DEFINE g_npq		RECORD LIKE npq_file.*
   DEFINE g_trno	LIKE oma_file.oma01
   DEFINE g_type	LIKE npp_file.npptype  #FUN-670047
   DEFINE g_t1    	LIKE ooy_file.ooyslip  #FUN-590100 #No.FUN-680123 VARCHAR(5)
   DEFINE g_ooydmy2     LIKE ooy_file.ooydmy2  #FUN-590100
   DEFINE g_aag05       LIKE aag_file.aag05
   #DEFINE l_aag181      LIKE aag_file.aag181   #No:9189   #MOD-750132
   DEFINE l_aag371      LIKE aag_file.aag371   #No:9189   #MOD-750132
   DEFINE g_aag23       LIKE aag_file.aag23
   DEFINE l_occ02       LIKE occ_file.occ02
   DEFINE l_occ37       LIKE occ_file.occ37
   DEFINE g_chr         LIKE type_file.chr1    #No.FUN-680123 VARCHAR(1)
   DEFINE g_msg         LIKE type_file.chr1000 #No.FUN-680123 VARCHAR(72)
   DEFINE g_bookno1     LIKE aza_file.aza81      #No.FUN-740009
   DEFINE g_bookno2     LIKE aza_file.aza82      #No.FUN-740009
   DEFINE g_bookno3     LIKE aza_file.aza82      #No.FUN-740009
   DEFINE g_flag        LIKE type_file.chr1      #No.FUN-740009
   DEFINE l_dbs         LIKE type_file.chr21     #No.FUN-9C0014 Add
 # DEFINE g_sql         LIKE type_file.chr1000   #No.FUN-9C0014 Add      #FUN-950053 mark
   DEFINE g_npq25       LIKE npq_file.npq25      #FUN-9A0036
   DEFINE g_def         LIKE oct_file.oct12      #NO.FUN-A60007
   DEFINE g_def_f       LIKE oct_file.oct12f     #NO.FUN-A60007
   DEFINE g_sql         string                   #NO.FUN-A60007
  ##NO.FUN-A60007   --begin
   DEFINE g_omb RECORD LIKE omb_file.*
   DEFINE g_dbs_gl      LIKE type_file.chr20
   DEFINE g_oct01       LIKE oct_file.oct01
   DEFINE g_oct02       LIKE oct_file.oct02
   DEFINE g_oct12       LIKE oct_file.oct12
   DEFINE g_ohb31       LIKE ohb_file.ohb31
   DEFINE g_ohb32       LIKE ohb_file.ohb32
   DEFINE g_oma54t      LIKE oma_file.oma54t
   DEFINE g_omb01       LIKE oma_file.oma01
   DEFINE g_omb03       LIKE oma_file.oma03
   DEFINE g_oma02       LIKE oma_file.oma02
   DEFINE g_ocs         RECORD  LIKE ocs_file.*
   DEFINE g_oct09_s    LIKE oct_file.oct09
   DEFINE g_oct09_e    LIKE oct_file.oct10
   DEFINE g_oct10_s    LIKE oct_file.oct09
   DEFINE g_oct10_e    LIKE oct_file.oct10
   DEFINE g_oct01_o    LIKE oct_file.oct01
   DEFINE g_oct02_o    LIKE oct_file.oct01
   DEFINE g_omb14_n    LIKE omb_file.omb14
   DEFINE g_omb16_n    LIKE omb_file.omb16
   DEFINE g_omb16      LIKE omb_file.omb16
   DEFINE g_oct12_o    LIKE oct_file.oct12
   DEFINE g_cnt1       LIKE type_file.num5
   DEFINE g_cnt2       LIKE type_file.num5
   DEFINE g_cnt3       LIKE type_file.num5
   DEFINE g_cnt4       LIKE type_file.num5
   DEFINE g_cnt5       LIKE type_file.num5  #FUN-B70059
   DEFINE g_sales      LIKE npq_file.npq07
   DEFINE g_salesf     LIKE npq_file.npq07f
   DEFINE g_tot_oct12  LIKE oct_file.oct12
   DEFINE g_tot_oct12f LIKE oct_file.oct12f
##NO.FUN-A60007   --end

FUNCTION s_t300_gl(p_trno,p_npptype)    #No.FUN-A10104
DEFINE l_aag15      LIKE aag_file.aag15
  #DEFINE p_dbs         LIKE type_file.chr21     #No.FUN-9C0014 Add #No.FUN-A10104
   DEFINE p_trno	LIKE oma_file.oma01
   DEFINE p_npptype	LIKE npp_file.npptype  #No.FUN-670047
   DEFINE l_buf		LIKE type_file.chr1000 #No.FUN-680123 VARCHAR(70)
   DEFINE l_n  	 	LIKE type_file.num5    #No.FUN-680123 SMALLINT
   WHENEVER ERROR CONTINUE
   LET g_trno = p_trno
   LET g_type = p_npptype     #No.FUN-670047
   IF g_trno IS NULL THEN RETURN END IF
   SELECT oma_file.*,ool_file.* INTO g_oma.*,g_ool.*
     FROM oma_file LEFT OUTER JOIN ool_file ON oma_file.oma13=ool_file.ool01
    WHERE oma01 = g_trno
   IF STATUS THEN
#     CALL cl_err('sel oma+ool',STATUS,1)    #No.FUN-660116
#No.FUN-710050--begin
      IF g_bgerr THEN
         CALL s_errmsg('oma01',g_trno,'sel oma+ool',STATUS,0)
      ELSE
         CALL cl_err3("sel","oma_file,ool_file",g_trno,"",STATUS,"","sel oma+ool",1)   #No.FUN-660116
      END IF
#No.FUN-710050--end
   END IF
  #MOD-A20056---add---start---
   LET g_aag23 = NULL
   SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
    WHERE aag01 = g_npq.npq03
      AND aag00 = g_bookno3
   IF g_aag23 = 'Y' THEN
      LET g_npq.npq08 = g_oma.oma63    # 專案
   ELSE
      LET g_npq.npq08 = null
   END IF
  #MOD-A20056---add---end---
#No.FUN-A10104 -BEGIN-----
#  LET l_dbs = p_dbs          #No.FUN-9C0014 Add
   IF cl_null(g_oma.oma66) THEN
      LET l_dbs = ''
   ELSE
      LET g_plant_new = g_oma.oma66
      CALL s_gettrandbs()
      LET l_dbs = g_dbs_tra
   END IF
#No.FUN-A10104 -END-------
   IF g_oma.oma02 <= g_ooz.ooz09 THEN
#No.FUN-710050--begin
      IF g_bgerr THEN
         CALL s_errmsg('','','','axr-164',0)
      ELSE
         CALL cl_err('','axr-164',0)
      END IF
#No.FUN-710050--end
      RETURN
   END IF
   # 97/05/15 modify 判斷已拋轉傳票不可再產生
   SELECT COUNT(*) INTO l_n FROM npp_file
    WHERE npp01 = g_trno
      AND nppglno IS NOT NULL
      AND npp00=2
      AND nppsys = 'AR'
      AND npp011 = 1   #異動序號
      AND npptype = g_type     #No.FUN-670047
   IF l_n > 0 THEN
#No.FUN-710050--begin
      IF g_bgerr THEN
         CALL s_errmsg('','','','axr-122',0)
      ELSE
         CALL cl_err('sel npp','aap-122',0)
      END IF
#No.FUN-710050--end
      RETURN
   END IF
   SELECT COUNT(*) INTO l_n FROM npq_file
    WHERE npq01 = g_trno
      AND npq00 = 2
      AND npqsys = 'AR'
      AND npq011 = 1   #異動序號
      AND npqtype = g_type     #No.FUN-670047
   IF l_n > 0 THEN
      IF NOT s_ask_entry(p_trno) THEN RETURN END IF #Genero
   END IF
   DELETE FROM npp_file WHERE npp01 = g_trno AND npp00 = 2
                          AND nppsys = 'AR'  AND npp011 = 1   #異動序號
                          AND npptype = g_type     #No.FUN-670047
   DELETE FROM npq_file WHERE npq01 = g_trno AND npq00 = 2
                          AND npqsys = 'AR'  AND npq011 = 1   #異動序號
                          AND npqtype = g_type     #No.FUN-670047
   #FUN-B40056--add--str--
   DELETE FROM tic_file WHERE tic04 = g_trno
   #FUN-B40056--add--end--
   #-----MOD-750132---------
   ##LET g_npq.npq14=''   #MOD-730062
   #LET g_npq.npq37=''   #MOD-730062
   ##-->for 合併報表-關係人
   #SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
   # WHERE occ01=g_oma.oma03
   ##IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
   #IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
   #-----END MOD-750132-----
   #FUN-590100  --begin
   CALL s_get_doc_no(g_oma.oma01) RETURNING g_t1
   SELECT ooydmy2 INTO g_ooydmy2 FROM ooy_file WHERE ooyslip=g_t1
   #FUN-590100  --end

   #No.FUN-740009  --Begin
   CALL s_get_bookno(YEAR(g_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
   IF g_flag =  '1' THEN  #抓不到帳別
      CALL cl_err(g_oma.oma02,'aoo-081',1)
      LET g_success = 'N'
      RETURN
   END IF
   IF p_npptype = '0' THEN
      LET g_bookno3 = g_bookno1
   ELSE
      LET g_bookno3 = g_bookno2
   END IF
   #No.FUN-740009  --End

   CASE WHEN g_oma.oma00='11' CALL s_t300_gl_11()
        WHEN g_oma.oma00='12' CALL s_t300_gl_12()
       #WHEN g_oma.oma00='13' CALL s_t300_gl_12()    #CHI-A50040 mark
        WHEN g_oma.oma00='13' CALL s_t300_gl_11()    #CHI-A50040
        WHEN g_oma.oma00='14' CALL s_t300_gl_12()
       #No.+009 010416 by plum add
       #FUN-960141 add begin
        WHEN g_oma.oma00='15' CALL s_t300_gl_15('15')   #FUN-9C0109 add 參數
        WHEN g_oma.oma00='16' CALL s_t300_gl_15('16')   #FUN-9C0109 add 參數
        WHEN g_oma.oma00='17' CALL s_t300_gl_15('17')   #FUN-9C0109 add 參數
        WHEN g_oma.oma00='18' CALL s_t300_gl_15('18')   #FUN-9C0109 add 參數
       #FUN-960141 add end
        WHEN g_oma.oma00='19' CALL s_t300_gl_12()       #FUN-B10058
       #FUN-590100  --begin
        WHEN g_oma.oma00 MATCHES '2[1,2,5]'  #FUN-B10058
             IF g_aza.aza26='2' AND g_ooydmy2='Y' THEN
                CALL s_t300_gl_12()
             ELSE
                CALL s_t300_gl_21()
             END IF
        WHEN g_oma.oma00 ='28' CALL s_t300_gl_28()  #FUN-B10058 by elva
       #FUN-590100  --end
       #No.+009 ..end
   END CASE
   CALL s_t300_gen_diff()                                     #FUN-A40033 Add
   DELETE FROM npq_file WHERE npq01=g_trno AND npq03='-' AND npq00 = 2
                          AND npqsys = 'AR' AND npq011 = 1   #異動序號
   #FUN-B40056--add--str--
   DELETE FROM tic_file WHERE tic04 = g_trno
   #FUN-B40056--add--end--
   CALL s_flows('3','',g_npq.npq01,g_npp.npp02,'N',g_npq.npqtype,TRUE)   #No.TQC-B70021
   CALL cl_getmsg('axr-055',g_lang) RETURNING g_msg
   MESSAGE g_msg CLIPPED
END FUNCTION

FUNCTION s_t300_gl_11()
   DEFINE l_cnt                 LIKE type_file.num5    #CHI-A50040
   DEFINE l_oot04               LIKE oot_file.oot04    #CHI-A50040
   DEFINE l_oot05               LIKE oot_file.oot05    #CHI-A50040
   DEFINE l_aaa03   LIKE aaa_file.aaa03 #FUN-A40067
   DEFINE l_azi04_2 LIKE azi_file.azi04 #FUN-A40067
   DEFINE l_aag15      LIKE aag_file.aag15

#FUN-A40067 --Begin
   SELECT aaa03 INTO l_aaa03 FROM aaa_file
    WHERE aaa01 = g_bookno2
   SELECT azi04 INTO l_azi04_2 FROM azi_file
    WHERE azi01 = l_aaa03
#FUN-A40067 --End
   LET g_npp.nppsys = 'AR'
   LET g_npp.npplegal = g_legal     #FUN-980011 add
   LET g_npp.npp00 = 2
   LET g_npp.npp01 = g_oma.oma01
   LET g_npp.npp011 =  1
   LET g_npp.npp02 = g_oma.oma02
   LET g_npp.npp03 = NULL
   LET g_npp.npptype = g_type     #No.FUN-670047
   INSERT INTO npp_file VALUES(g_npp.*)
  #No.+041 010330 by plum
  #IF STATUS THEN CALL cl_err('ins npp',STATUS,1) LET g_success = 'N' END IF
   IF STATUS OR SQLCA.SQLCODE THEN
#     CALL cl_err('ins npp',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
      IF g_bgerr THEN
         LET g_showmsg=g_npp.npp01,"/",g_npp.npp011,"/",g_npp.nppsys,"/",g_npp.npp00
         CALL s_errmsg('npp01,npp011,nppsys,npp00',g_showmsg,'ins npp',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("ins","npp_file",g_npp.nppsys,g_npp.npp01,SQLCA.sqlcode,"","ins npp",1)   #No.FUN-660116
      END IF
#No.FUN-710050--end
      LET g_success='N'
   END IF
  #No.+041..end

   LET g_npq.npqsys = 'AR'
   LET g_npq.npqlegal = g_legal     #FUN-980011 add
   LET g_npq.npq00 = 2
   LET g_npq.npq01 = g_oma.oma01
   LET g_npq.npq011 = 1
   LET g_npq.npq02 = 0
   LET g_npq.npqtype = g_type     #No.FUN-670047
   LET g_npq.npq04 = NULL        LET g_npq.npq05 = g_oma.oma15
  #LET g_npq.npq10 = g_oma.oma02
   LET g_npq.npq21 = g_oma.oma03 LET g_npq.npq22 = g_oma.oma032
   LET g_npq.npq24 = g_oma.oma23 LET g_npq.npq25 = g_oma.oma24
   LET g_npq25 = g_npq.npq25   #FUN-9A0036
#--------------- (Dr:應收 Cr:預收, 稅) --------------
      #----------------------------------- (Dr:應收) --------
      LET g_npq.npq02 = g_npq.npq02 + 1
      #No.FUN-670047 --begin
      IF g_npq.npqtype = '0' THEN
         LET g_npq.npq03 = g_oma.oma18
      ELSE
         LET g_npq.npq03 = g_oma.oma181
      END IF
      #No.FUN-670047 --end
##1999/07/26 modify by sophia  若不作部門管理
      LET g_aag05 = NULL
      LET g_aag23 = NULL
      SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
       WHERE aag01 = g_npq.npq03
         AND aag00 = g_bookno3   #No.FUN-740009
      IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
         LET g_npq.npq05 = ' '
      END IF
      #FUN-680001...............begin
      IF g_aag05='Y' THEN
         LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
      END IF
      #FUN-680001...............end
##----------------------------
      LET g_npq.npq06 = '1'
      LET g_npq.npq07f = g_oma.oma54t
      LET g_npq.npq07 = g_oma.oma56t
      IF g_aag23 = 'Y' THEN
         LET g_npq.npq08 = g_oma.oma63    # 專案
      ELSE
         LET g_npq.npq08 = null
      END IF
    # LET g_npq.npq10 = g_oma.oma02
      LET g_npq.npq23 = g_oma.oma01
      #No:9189
      #-----MOD-750132---------
      LET l_aag371=' '
      LET g_npq.npq37=''
      SELECT aag371 INTO l_aag371 FROM aag_file
       WHERE aag01=g_npq.npq03
         AND aag00 = g_bookno3
      #LET l_aag181=' '
      ##LET g_npq.npq14=''   #MOD-730062
      #LET g_npq.npq37=''   #MOD-730062
      #SELECT aag181 INTO l_aag181 FROM aag_file
      # WHERE aag01=g_npq.npq03
      #   AND aag00 = g_bookno3   #No.FUN-740009
      #IF l_aag181 MATCHES '[23]' THEN
      #   #-->for 合併報表-關係人
      #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
      #    WHERE occ01=g_oma.oma03
      #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
      #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
      #END IF
      #-----END MOD-750132-----
      #End
      MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
      IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      # NO.FUN-5C0015 --start--
     #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
      CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
       RETURNING  g_npq.*
      CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
       RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
      # NO.FUN-5C0015 ---end---
      #-----MOD-750132---------
    # IF l_aag371 MATCHES '[23]' THEN             #FUN-950053 mark
      IF l_aag371 MATCHES '[234]' THEN            #FUN-950053 add
         #-->for 合併報表-關係人
      #No.FUN-9C0014 BEGIN -----
      #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
      #   WHERE occ01=g_oma.oma03
         IF cl_null(l_dbs) THEN
            SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
          WHERE occ01=g_oma.oma03
         ELSE
            #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
            LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        " WHERE occ01='",g_oma.oma03,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
	    CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE sel_occ_pre01 FROM g_sql
            EXECUTE sel_occ_pre01 INTO l_occ02,l_occ37
         END IF
      #No.FUN-9C0014 END -------
         IF cl_null(g_npq.npq37) THEN
            IF l_occ37='Y' THEN
#             LET g_npq.npq37=l_occ02 CLIPPED   #No.CHI-830037
              LET g_npq.npq37=g_oma.oma03 CLIPPED     #No.CHI-830037
            END IF
         END IF
      END IF
      #-----END MOD-750132-----
      IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
      IF g_type = '1' THEN
         CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                        g_npq25,g_npp.npp02)
         RETURNING g_npq.npq25
         LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#        LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
         LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
      ELSE
         LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
      END IF
#No.FUN-9A0036 --End
         #No.FUN-A30077  --Begin
         CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                     g_npq.npq07,g_npq.npq07f)
              RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
         #No.FUN-A30077  --End
      LET g_npq.npq30 = g_oma.oma66    #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
      INSERT INTO npq_file VALUES (g_npq.*)
     #No.+041 010330 by plum
       #IF STATUS THEN CALL cl_err('ins npq#1',STATUS,1) LET g_success = 'N'
      IF STATUS OR SQLCA.SQLCODE THEN
#        CALL cl_err('ins npq#1',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
         IF g_bgerr THEN
            LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
            CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
         ELSE
            CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#1",1)   #No.FUN-660116
         END IF
#No.FUN-710050--end
         LET g_success='N'
      END IF
      END IF   #MOD-820056
     #No.+041..end
      IF g_oma.oma00 = '11' THEN   #CHI-A50040
      #----------------------------------- (Cr:預收) --------
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL   #MOD-780052
         #No.FUN-670047 --begin
#        LET g_npq.npq03 = g_ool.ool21
         IF g_npq.npqtype = '0' THEN
            LET g_npq.npq03 = g_ool.ool21
         ELSE
            LET g_npq.npq03 = g_ool.ool211
         END IF
         #No.FUN-670047 --end
         LET g_npq.npq06 = '2'
         LET g_npq.npq07f = g_oma.oma54
         LET g_npq.npq07 = g_oma.oma56
       # LET g_npq.npq10 = g_oma.oma02
       # LET g_npq.npq23 = g_oma.oma19     #TQC-860031
         LET g_npq.npq23 = ''              #TQC-860031
        ##No.+095 010427 by plum 若不作部門管理
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         END IF
        ##No.+095..end----------------------------
         #FUN-680001...............begin
         IF g_aag05='Y' THEN
            LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
         END IF
         #FUN-680001...............end
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00=g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
         #End
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         # NO.FUN-5C0015 --start--
       # CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
          RETURNING  g_npq.*
         CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
          RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
         # NO.FUN-5C0015 ---end---
         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN        #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN       #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
             WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
	       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre02 FROM g_sql
               EXECUTE sel_occ_pre02 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED    #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
        #No.+041 010330 by plum
          #IF STATUS THEN CALL cl_err('ins npq#2',STATUS,1) LET g_success = 'N'
         IF STATUS OR SQLCA.SQLCODE THEN
#           CALL cl_err('ins npq#2',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#2",1)   #No.FUN-660116
            END IF
#No.FUN-710050--end
            LET g_success='N'
         END IF
      END IF   #MOD-820056
      END IF   #CHI-A50040
     #No.+041..end
     #-CHI-A50040-add-
     #----------------------------------- (Cr:銷貨收入) ----
      IF g_oma.oma56 > 0 AND g_oma.oma00 = '13' THEN
         LET l_cnt = 0
         SELECT COUNT(*),SUM(oot04),SUM(oot05)
           INTO l_cnt,l_oot04,l_oot05
           FROM oot_file
          WHERE oot03 = g_oma.oma01
         IF cl_null(l_oot04) THEN LET l_oot04  = 0 END IF
         IF cl_null(l_oot05) THEN LET l_oot05 = 0 END IF

         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL
         IF g_npq.npqtype = '0' THEN
            LET g_npq.npq03 = g_ool.ool41
         ELSE
            LET g_npq.npq03 = g_ool.ool411
         END IF
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
         END IF
         LET g_npq.npq06 = '2'
         IF l_cnt > 0 THEN
            LET g_npq.npq07f= g_oma.oma54 - l_oot04
            LET g_npq.npq07 = g_oma.oma56 - l_oot05
         ELSE
            LET g_npq.npq07f= g_oma.oma54
            LET g_npq.npq07 = g_oma.oma56
         END IF
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         LET g_npq.npq23 = g_oma.oma01
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         IF g_oma.oma00 MATCHES '2*' THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq07f= (-1)*g_npq.npq07f
         END IF
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
         RETURNING  g_npq.*
         CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
          RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
       # IF l_aag371 MATCHES '[23]' THEN            #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN           #FUN-950053 add
            #-->for 合併報表-關係人
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
	       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre21 FROM g_sql
               EXECUTE sel_occ_pre21 INTO l_occ02,l_occ37
            END IF
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
                  LET g_npq.npq37=g_oma.oma03 CLIPPED
               END IF
            END IF
         END IF
         IF g_npq.npq07 <> 0 THEN
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
         IF STATUS OR SQLCA.SQLCODE THEN
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#5',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#5",1)
            END IF
            LET g_success='N'
         END IF
         END IF
      END IF
     #-CHI-A50040-add-
      #----------------------------------- (Cr:稅) ----------
      IF g_oma.oma54x > 0 THEN
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL   #MOD-780052
         IF g_npq.npqtype = '0' THEN   #No.TQC-740309
            LET g_npq.npq03 = g_ool.ool28
         #No.TQC-740309 --start--
         ELSE
            LET g_npq.npq03 = g_ool.ool281
         END IF
         #No.TQC-740309 --end--
         LET g_npq.npq06 = '2'
         LET g_npq.npq07f = g_oma.oma54x
         LET g_npq.npq07 = g_oma.oma56x
        #LET g_npq.npq10 = g_oma.oma02
         LET g_npq.npq23 = g_oma.oma01
        ##No.+095 010427 by plum 若不作部門管理
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         END IF
        ##No.+095..end----------------------------
         #FUN-680001...............begin
         IF g_aag05='Y' THEN
            LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
         END IF
         #FUN-680001...............end
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00=g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
      #End

         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
        #NO.FUN-5C0015 --start--
        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
         CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
          RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
        #NO.FUN-5C0015 ---end---
         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN                 #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN                #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
	       CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre03 FROM g_sql
               EXECUTE sel_occ_pre03 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED    #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
        #No.+041 010330 by plum
          #IF STATUS THEN CALL cl_err('ins npq#3',STATUS,1) LET g_success = 'N'
         IF STATUS OR SQLCA.SQLCODE THEN
#           CALL cl_err('ins npq#3',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#3',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#3",1)   #No.FUN-660116
            END IF
#No.FUN-710050--end
            LET g_success='N'
         END IF
         END IF   #MOD-820056
        #No.+041..end
      END IF
END FUNCTION

FUNCTION s_t300_gl_12()
DEFINE l_aag15      LIKE aag_file.aag15
   DEFINE l_omb33           LIKE omb_file.omb33   #No.FUN-680123 VARCHAR(20)
   DEFINE l_omb930          LIKE omb_file.omb930  #MOD-8C0161 add
   DEFINE l_omb40           LIKE omb_file.omb40   #No.FUN-660073
   DEFINE l_azf14           LIKE azf_file.azf14   #No.FUN-660073
   DEFINE l_omb14,l_omb16   LIKE omb_file.omb14   #FUN-4C0013 #No.FUN-680123 DEC(20,6)
   DEFINE l_omb14t,l_omb16t   LIKE omb_file.omb14   #FUN-4C0013 #No.FUN-680123 DEC(20,6)  #by elva
   #add 030625 NO.A083
   DEFINE l_cnt             LIKE type_file.num5   #No.FUN-680123 SMALLINT
   DEFINE l_cnt2            LIKE type_file.num5   #MOD-B10123
   DEFINE l_cnt3            LIKE type_file.num5   #MOD-B10123
   DEFINE l_11_cnt          LIKE type_file.num5   #TQC-B60089
   DEFINE l_ocs_cnt         LIKE type_file.num10  #MOD-B60059
   DEFINE l_oot04           LIKE oot_file.oot04
   DEFINE l_oot04x          LIKE oot_file.oot04x
   DEFINE l_oot04t          LIKE oot_file.oot04t
   DEFINE l_oot05           LIKE oot_file.oot05
   DEFINE l_oot05x          LIKE oot_file.oot05x
   DEFINE l_oot05t          LIKE oot_file.oot05t
   DEFINE l_n               LIKE type_file.num5   #No.FUN-680123 SMALLINT #No.TQC-5B0080
   DEFINE l_sql             LIKE type_file.chr1000#No.FUN-680123 VARCHAR(1000)            #No.FUN-670047
   #-----MOD-690136---------
   DEFINE l_omb03           LIKE omb_file.omb03
   DEFINE l_omb31           LIKE omb_file.omb31
   DEFINE s_omb31           LIKE omb_file.omb31   #MOD-970129 add
   DEFINE l_oga07           LIKE oga_file.oga07
   DEFINE l_omb14_2         LIKE omb_file.omb14
   DEFINE l_omb16_2         LIKE omb_file.omb16
   DEFINE s_omb14           LIKE omb_file.omb14
   DEFINE s_omb16           LIKE omb_file.omb16
   #-----END MOD-690136-----
  #FUN-810045 add begin
   DEFINE l_omb41           LIKE omb_file.omb41,   #專案　
          l_omb42           LIKE omb_file.omb42    #WBS
  #FUN-810045 add end
   DEFINE l_oma54           LIKE oma_file.oma54   #MOD-860185 add
   DEFINE l_sumoma54        LIKE oma_file.oma54   #MOD-B10123
   DEFINE l_oma56           LIKE oma_file.oma56   #MOD-860185 add
   DEFINE l_sumoma56        LIKE oma_file.oma56   #MOD-B10123
   DEFINE l_oga24           LIKE oga_file.oga24   #MOD-890196 add
   DEFINE l_diff            LIKE oga_file.oga24   #MOD-890196 add
   DEFINE l_npq07_d         LIKE npq_file.npq07   #MOD-920066 add
   DEFINE l_npq07_c         LIKE npq_file.npq07   #MOD-920066 add
   DEFINE l_aag21           LIKE aag_file.aag21   #MOD-950096
  #No.FUN-9C0014 -BEGIN-----
   DEFINE l_omb44           LIKE omb_file.omb44
   DEFINE l_oga19           LIKE oga_file.oga19
   DEFINE l_dbs1            LIKE type_file.chr21
   DEFINE l_occ73           LIKE occ_file.occ73
  #No.FUN-9C0014 -END-------
   DEFINE l_oga16           LIKE oga_file.oga16    #No:FUN-A50103
   DEFINE l_oma19           LIKE oma_file.oma19    #No:FUN-A50103
   DEFINE l_oea61           LIKE oea_file.oea61    #No:FUN-A50103
   DEFINE l_oea261          LIKE oea_file.oea261   #TQC-B60089
   DEFINE l_omb14tot        LIKE omb_file.omb14    #No:FUN-A50103
   DEFINE l_aaa03   LIKE aaa_file.aaa03 #FUN-A40067
   DEFINE l_azi04_2 LIKE azi_file.azi04 #FUN-A40067
  #DEFINE l_type                LIKE type_file.chr2   #NO.FUN-A60007 #MOD-A90028 mark
   DEFINE l_type                LIKE omb_file.omb33   #MOD-A90028
   DEFINE l_npq07               LIKE npq_file.npq07   #NO.FUN-A60007
   DEFINE l_npq07f              LIKE npq_file.npq07f  #NO.FUN-A60007
   DEFINE l_omb45               LIKE omb_file.omb45   #FUN-AC0027
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
   DEFINE t_ITEM                LIKE npq_file.npq02
   DEFINE t_T                   LIKE npq_file.npq07f
   DEFINE t_HAL                 LIKE npq_file.npq07f
   DEFINE t_rxy05t              LIKE rxy_file.rxy05
   DEFINE t_rxy05               LIKE rxy_file.rxy05
   DEFINE t_rxy05x              LIKE rxy_file.rxy05
###-FUN-B40032- ADD -  END  ---------------------------------------------------
   DEFINE l_oma53               LIKE oma_file.oma53   #MOD-B60021
   DEFINE l_omb                 RECORD LIKE omb_file.* #MOD-B60059
   DEFINE l_tc_ool41              LIKE tc_ool_file.tc_ool41    # add by lixwz 20170802
   DEFINE l_tc_ool28              LIKE tc_ool_file.tc_ool28     # add by lixwz 20170802

#FUN-A40067 --Begin
   SELECT aaa03 INTO l_aaa03 FROM aaa_file
    WHERE aaa01 = g_bookno2
   SELECT azi04 INTO l_azi04_2 FROM azi_file
    WHERE azi01 = l_aaa03
#FUN-A40067 --End

   #add 030625 NO.A083
   SELECT COUNT(*),SUM(oot04),SUM(oot04x),SUM(oot04t),
          SUM(oot05),SUM(oot05x),SUM(oot05t)
     INTO l_cnt,l_oot04,l_oot04x,l_oot04t,l_oot05,l_oot05x,l_oot05t
     FROM oot_file
    WHERE oot03 = g_oma.oma01
   IF cl_null(l_oot04)  THEN LET l_oot04  = 0 END IF
   IF cl_null(l_oot04x) THEN LET l_oot04x = 0 END IF
   IF cl_null(l_oot04t) THEN LET l_oot04t = 0 END IF
   IF cl_null(l_oot05)  THEN LET l_oot05  = 0 END IF
   IF cl_null(l_oot05x) THEN LET l_oot05x = 0 END IF
   IF cl_null(l_oot05t) THEN LET l_oot05t = 0 END IF

   LET l_npq07 = 0   #NO.FUN-A60007
   LET l_npq07f = 0  #NO.FUN-A60007
   LET g_npp.nppsys = 'AR'
   LET g_npp.npplegal = g_legal     #FUN-980011 add
   LET g_npp.npp00 = 2
   LET g_npp.npp01 = g_oma.oma01
   LET g_npp.npp011 =  1
   LET g_npp.npp02 = g_oma.oma02
   LET g_npp.npp03 = NULL
   LET g_npp.npptype = g_type     #No.FUN-670047
   INSERT INTO npp_file VALUES(g_npp.*)
  #No.+041 010330 by plum
    #IF STATUS THEN CALL cl_err('ins npp',STATUS,1) LET g_success = 'N'
   IF STATUS OR SQLCA.SQLCODE THEN
#     CALL cl_err('ins npp',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
      IF g_bgerr THEN
         LET g_showmsg=g_npp.npp01,"/",g_npp.npp011,"/",g_npp.nppsys,"/",g_npp.npp00
         CALL s_errmsg('npp01,npp011,nppsys,npp00',g_showmsg,'ins npp',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("ins","npp_file",g_npp.nppsys,g_npp.npp01,SQLCA.sqlcode,"","ins npp",1)   #No.FUN-660116
      END IF
#No.FUN-710050--end
      LET g_success='N'
   END IF
  #No.+041..end

   LET g_npq.npqsys = 'AR'
   LET g_npq.npqlegal = g_legal     #FUN-980011 add
   LET g_npq.npq00 = 2
   LET g_npq.npq01 = g_oma.oma01
   LET g_npq.npq011 =  1
   LET g_npq.npq02 = 0
   LET g_npq.npqtype = g_type     #No.FUN-670047
   LET g_npq.npq04 = NULL        LET g_npq.npq05 = g_oma.oma15
 # LET g_npq.npq10 = g_oma.oma02

   LET g_npq.npq21 = g_oma.oma03         #FUN-AC0027  #No.TQC-B10108 Cancel mark

   LET g_npq.npq22 = g_oma.oma032
   LET g_npq.npq24 = g_oma.oma23 LET g_npq.npq25 = g_oma.oma24
   LET g_npq25 = g_npq.npq25   #FUN-9A0036

#--------------- (如有預收發票訂金時 Dr:預收 Cr:銷貨收入) -------------------
 #No.FUN-9C0014 -BEGIN-----
  #IF NOT cl_null(g_oma.oma19) THEN
   DECLARE conf_cs CURSOR FOR
    SELECT DISTINCT omb44,omb31
      FROM oma_file,omb_file      #TQC-B60089 add oma_file
     WHERE omb01 = g_oma.oma01
       AND oma01 = omb01          #TQC-B60089
       AND oma53 > 0              #TQC-B60089

   FOREACH conf_cs INTO l_omb44,l_omb31
      IF NOT cl_null(l_omb44) THEN
         LET g_plant_new = l_omb44
      ELSE
         LET g_plant_new = g_plant
      END IF
      CALL s_gettrandbs()
      LET l_dbs1 = g_dbs_tra
     #LET g_sql = " SELECT oga19 FROM ",l_dbs1,"oga_file",
     #LET g_sql = " SELECT oga16 FROM ",l_dbs1,"oga_file",    #No:FUN-A50103
     #LET g_sql = " SELECT oga16 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102       #MOD-AC0033 mark
      LET g_sql = " SELECT oga07,oga16 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102 #MOD-AC0033
                  "  WHERE oga01 = '",l_omb31,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE sel_oga_pre68 FROM g_sql
     #executE sel_oga_pre68 INTO l_oga19
     #EXECUTE sel_oga_pre68 INTO l_oga16    #No:FUN-A50103         #MOD-AC0033 mark
      EXECUTE sel_oga_pre68 INTO l_oga07,l_oga16    #No:FUN-A50103 #MOD-AC0033
     #IF l_oga19 IS NULL OR l_oga19 = ' ' THEN CONTINUE FOREACH END IF #沒有預售單
      IF l_oga07 = 'Y' THEN CONTINUE FOREACH END IF                #MOD-AC0033
      IF l_oga16 IS NULL OR l_oga16 = ' ' THEN CONTINUE FOREACH END IF #沒有預售單    #No:FUN-A50103

      #LET g_sql = " SELECT occ73 FROM ",l_dbs1,"occ_file",
      LET g_sql = " SELECT occ73 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                  "  WHERE occ01 = '",g_oma.oma68,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE sel_occ_pre69 FROM g_sql
      EXECUTE sel_occ_pre69 INTO l_occ73
      IF l_occ73 = 'Y' THEN EXIT FOREACH END IF

      #-----No:FUN-A50103-----
      SELECT SUM(omb14) INTO l_omb14tot FROM omb_file
       WHERE omb01 = g_oma.oma01
         AND omb31 = l_omb31

      #LET g_sql = " SELECT oea61 FROM ",l_dbs1,"oea_file",
      LET g_sql = " SELECT oea61,oea261 FROM ",cl_get_target_table(g_plant_new,'oea_file'), #FUN-A50102 #TQC-B60089 add oea261
                  "  WHERE oea01 = '",l_oga16,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE sel_oea_pre68 FROM g_sql
      EXECUTE sel_oea_pre68 INTO l_oea61,l_oea261  #TQC-B60089 add oea261

     #-TQC-B60089-add-
      LET l_diff =0
      LET l_sumoma54 = 0
      LET l_cnt3 = 0
      LET l_11_cnt = 0
      SELECT COUNT(*) INTO l_cnt3
        FROM oma_file
       WHERE oma16 = l_oga16
         AND oma00 = '11'
      IF cl_null(l_cnt3) THEN LET l_cnt3 = 0 END IF
     #-TQC-B60089-end-

      #LET g_sql = " SELECT oma19 FROM ",l_dbs1,"oma_file",
      LET g_sql = " SELECT oma19 FROM ",cl_get_target_table(g_plant_new,'oma_file'), #FUN-A50102
                  "  WHERE oma16 = '",l_oga16,"'",
                  "    AND oma00 = '11'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
      PREPARE sel_oma_pre19 FROM g_sql
      DECLARE sel_oma_19 CURSOR FOR sel_oma_pre19

      FOREACH sel_oma_19 INTO l_oma19
      #-----No:FUN-A50103 END-----
         LET l_cnt2 = 0                              #TQC-B60089 mod l_cnt -> l_cnt2
         SELECT COUNT(*) INTO l_cnt2 FROM npq_file   #TQC-B60089 mod l_cnt -> l_cnt2
          WHERE npq01 = g_oma.oma01
           #AND npq23 = l_oga19
            AND npq23 = l_oma19    #No:FUN-A50103
         IF l_cnt2 > 0 THEN CONTINUE FOREACH END IF   #已存在此筆預收單的分錄 #TQC-B60089 mod l_cnt -> l_cnt2
         #-----No:FUN-A50103-----
         #LET g_sql = " SELECT oma54,oma56 FROM ",l_dbs1,"oma_file",
         LET g_sql = " SELECT oma54,oma56 FROM ",cl_get_target_table(g_plant_new,'oma_file'), #FUN-A50102
                     "  WHERE oma01 = '",l_oma19,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
         PREPARE sel_oga_pre69 FROM g_sql
        #EXECUTE sel_oga_pre69 INTO g_oma.oma52,g_oma.oma53 #TQC-B60089 mark
         EXECUTE sel_oga_pre69 INTO l_oma54,l_oma56         #TQC-B60089

        #LET g_sql = " SELECT SUM(omb14),SUM(omb16)",
        #            "   FROM omb_file,",l_dbs1,"oga_file",
        #            "  WHERE omb01 = '",g_oma.oma01,"'",
        #            "    AND omb44 = '",l_omb44,"'",
        #            "    AND omb31 = oga01",
        #            "    AND oga19 = '",l_oga19,"'"
        #PREPARE sel_oga_pre69 FROM g_sql
        #EXECUTE sel_oga_pre69 INTO g_oma.oma50,g_oma.oma56

        #LET g_oma.oma52 = g_oma.oma50 *g_oma.oma161/100
        #LET g_oma.oma53 = g_oma.oma56 *g_oma.oma161/100
        ##-----No:FUN-A50103 END-----
         #No.FUN-9C0014 -END-------

         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq03 = g_ool.ool21
         LET g_npq.npq05 = g_oma.oma15
         ##1999/07/26 modify by sophia  若不作部門管理
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
         END IF

         ##借方----------------------------
         LET g_npq.npq06 = '1'
         #-----CHI-840048---------
         #LET g_npq.npq07f = g_oma.oma52
         #LET g_npq.npq07 = g_oma.oma53     # 必為本幣
         #-----END CHI-840048-----
       # LET g_npq.npq10 = g_oma.oma02
         LET g_npq.npq21 = g_oma.oma03
         LET g_npq.npq22 = g_oma.oma032
        #LET g_npq.npq23 = g_oma.oma19 #No.FUN-9C0014
        #LET g_npq.npq23 = l_oga19     #No.FUN-9C0014
         LET g_npq.npq23 = l_oma19    #No:FUN-A50103
         #-----CHI-840048---------
         #LET g_npq.npq24 = g_oma.oma23
         #LET g_npq.npq25 = g_oma.oma24

         #預收的金額
        #FUN-A60056--mark--str--
        #IF cl_null(l_dbs1) THEN  #No.FUN-9C0014 Add
        #  #SELECT SUM(oma54),SUM(oma56) INTO g_npq.npq07f,g_npq.npq07  #MOD-860185 mark
        #   SELECT SUM(oma54),SUM(oma56) INTO l_oma54,l_oma56           #MOD-860185
        #     FROM oma_file
        #  # WHERE oma19=g_oma.oma19 #No.FUN-9C0014
        #  # WHERE oma19=l_oga19     #No.FUN-9C0014
        #    WHERE oma19=l_oma19     #No:FUN-A50103
        #      AND oma16 IN (SELECT oga16 FROM oga_file WHERE oga01 = g_oma.oma16)
        #      AND oma00='11' AND omaconf='Y' AND omavoid='N'
        ##No.FUN-9C0014 BEGIN -----
        #ELSE
        #FUN-A60056--mark--end
           #-TQC-B60089-mark-
           #LET g_sql = "SELECT SUM(oma54),SUM(oma56) ",
           #            "  FROM oma_file",
           #          # " WHERE oma19='",l_oga19,"'",
           #            " WHERE oma19='",l_oma19,"'",    #No:FUN-A50103
           #            #"   AND oma16 IN (SELECT oga16 FROM ",l_dbs1 CLIPPED,"oga_file ",
           #            "   AND oma16 IN (SELECT oga16 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
           #            "                  WHERE oga01 = '",l_omb31,"')",
           #            "   AND oma00='11' AND omaconf='Y' AND omavoid='N'"
           #CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
           #CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
           #PREPARE sel_oga_pre20 FROM g_sql
           #EXECUTE sel_oga_pre20 INTO l_oma54,l_oma56
           #-TQC-B60089-end-
        #END IF    #FUN-A60056

         #No.FUN-9C0014 END -------
         #str MOD-860185 add
         #npq07f與npq07的金額應該以此次入庫金額與預收金額做比例計算
         #-----No:FUN-A50103-----
        #LET g_npq.npq07f= g_oma.oma52 * l_omb14tot / l_oea61  #TQC-B60089 mark
        #LET g_npq.npq07 = g_npq.npq07f/l_oma54*l_oma56        #TQC-B60089 mark

        #LET g_npq.npq07f= g_oma.oma52
        #LET g_npq.npq07 = g_oma.oma52/l_oma54*l_oma56
        ##-----No:FUN-A50103 END-----
         #end MOD-860185 add

        #FUN-A60056--mark--str--
        #IF cl_null(l_dbs1) THEN  #No.FUN-9C0014 Add
        #   SELECT oma23,oma24 INTO g_npq.npq24,g_npq.npq25 FROM oma_file
        #    WHERE oma19=g_oma.oma19
        #      AND oma16 IN (SELECT oga16 FROM oga_file WHERE oga01 = g_oma.oma16)
        #      AND oma00='11' AND omaconf='Y' AND omavoid='N'
        ##No.FUN-9C0014 BEGIN -----
        #ELSE
        #FUN-A60056--mark--end
            LET g_sql = "SELECT oma23,oma24 FROM oma_file ",
                       #" WHERE oma19='",l_oga19,"'",
                        " WHERE oma19='",l_oma19,"'",    #No:FUN-A50103
                        #"   AND oma16 IN (SELECT oga16 FROM ",l_dbs1 CLIPPED,"oga_file",
                        "   AND oma16 IN (SELECT oga16 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                        "                  WHERE oga01 = '",l_omb31,"')",
                        "   AND oma00='11' AND omaconf='Y' AND omavoid='N'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE sel_oga_pre21 FROM g_sql
            EXECUTE sel_oga_pre21 INTO g_npq.npq24,g_npq.npq25
            LET g_npq25 = g_npq.npq25   #FUN-9A0036
        #END IF    #FUN-A60056
         LET g_npq.npq07f= g_oma.oma52 * l_oma54 / l_oea261    #TQC-B60089
         LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25          #TQC-B60089

        #No.FUN-9C0014 END -------
        #-----END CHI-840048-----
        #str MOD-890196 add
        #若是該出貨單已在出貨時產生暫估應收分錄,axrt300產生分錄時,
        #預收匯率應抓出貨單匯率
        #No.FUN-9C0014 BEGIN -----
        #SELECT oga24 INTO g_npq.npq25 FROM oga_file WHERE oga01=g_oma.oma19
       #FUN-A60056--mark-str--
       # IF cl_null(l_dbs1) THEN
       #    SELECT oga24 INTO g_npq.npq25 FROM oga_file WHERE oga01=g_oma.oma19
       # ELSE
       #FUN-A60056--mark--end
            #LET g_sql = "SELECT oga24 FROM ",l_dbs1 CLIPPED,"oga_file WHERE oga01='",l_omb31,"'"
           #-MOD-B60021-mark-
           #LET g_sql = "SELECT oga24 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
           #            " WHERE oga01='",l_omb31,"'"
           #CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
           #CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
           #PREPARE sel_oga_pre22 FROM g_sql
           #EXECUTE sel_oga_pre22 INTO g_npq.npq25
           #-MOD-B60021-end-
            LET g_npq25 = g_npq.npq25   #FUN-9A0036
       # END IF    #FUN-A60056
        #No.FUN-9C0014 END -------
        #end MOD-890196 add
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00=g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
         #End
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         #FUN-590100  --begin
         IF g_oma.oma00 MATCHES '2*' THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq07f= (-1)*g_npq.npq07f
         END IF
         #FUN-590100  --end

        #NO.FUN-5C0015 --start--
        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
             RETURNING  g_npq.*
         CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
          RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
        #NO.FUN-5C0015 ---end---

         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN       #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN      #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs1) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs1 CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre04 FROM g_sql
               EXECUTE sel_occ_pre04 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED   #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED    #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----

         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                              RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#1",1)   #No.FUN-660116
               END IF
               LET g_success='N'
            END IF
         END IF   #MOD-820056
        #No.+041..end

         #-----CHI-840048---------
         #處理預收匯差分錄
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL
        #LET g_npq.npq07 = g_oma.oma24 * g_npq.npq07f     #MOD-B60021 #TQC-B60089 mark
        #LET g_npq.npq07 = cl_digcut(l_npq07,g_azi04)     #MOD-B60021 #TQC-B60089 mark
        #-TQC-B60089-add-
         LET l_npq07 = g_oma.oma24 * g_npq.npq07f
         LET l_diff = l_diff + l_npq07
         LET l_npq07 = cl_digcut(l_npq07,g_azi04)
         LET l_sumoma54 = l_sumoma54 + l_npq07
         LET l_11_cnt = l_11_cnt + 1
         IF l_11_cnt = l_cnt3 THEN
            LET l_diff = cl_digcut(l_diff,g_azi04)
            LET l_diff = l_sumoma54 - l_diff
            LET g_npq.npq07 = g_npq.npq07 + l_diff
         END IF
        #-TQC-B60089-end-
         LET g_npq.npq07f = 0
         #-----No:FUN-A50103-----
        #LET g_npq.npq07 = g_npq.npq07 - (g_oma.oma53 * l_omb14tot / l_oea61) #MOD-B60021 mark
        #LET g_npq.npq07 = (g_oma.oma53 * l_omb14tot / l_oea61) - g_npq.npq07 #MOD-B60021 #TQC-B60089 mark
         LET g_npq.npq07 = g_npq.npq07 - l_npq07          #TQC-B60089
        #LET g_npq.npq07 = g_npq.npq07 - g_oma.oma53
         #-----No:FUN-A50103 END-----
        #LET g_npq.npq24 = g_aza.aza17                    #MOD-B60021 mark
        #LET g_npq.npq25 = 1                              #MOD-B60021 mark
        #LET g_npq25 = g_npq.npq25   #FUN-9A0036          #MOD-B60021 mark
         IF g_npq.npq07 < 0 THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq06 = '1'
            IF g_npq.npqtype = '0' THEN
               LET g_npq.npq03 = g_ool.ool52
            ELSE
               LET g_npq.npq03 = g_ool.ool521
            END IF
         ELSE
            LET g_npq.npq06 = '2'
            IF g_npq.npqtype = '0' THEN
               LET g_npq.npq03 = g_ool.ool53
            ELSE
               LET g_npq.npq03 = g_ool.ool531
            END IF
         END IF
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
         END IF
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63
         ELSE
            LET g_npq.npq08 = null
         END IF
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
             RETURNING  g_npq.*
         CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
          RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
       # IF l_aag371 MATCHES '[23]' THEN            #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN           #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs1) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs1 CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre20 FROM g_sql
               EXECUTE sel_occ_pre20 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
                  LET g_npq.npq37=g_oma.oma03 CLIPPED
               END IF
            END IF
         END IF
        #IF g_npq.npq07 <> 0 THEN    #MOD-B60021 mark
#No.FUN-9A0036 --Begin
         IF g_type = '1' THEN
            CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                           g_npq25,g_npp.npp02)
            RETURNING g_npq.npq25
            LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#           LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
         ELSE
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
         END IF
#No.FUN-9A0036 --End
         #No.FUN-A30077  --Begin
         CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                     g_npq.npq07,g_npq.npq07f)
                           RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
         #No.FUN-A30077  --End
        #-MOD-B60021-add-
         IF g_npq.npq07 <> 0 THEN
            LET g_npq.npq24 = g_aza.aza17
            LET g_npq.npq25 = 1
            LET g_npq25 = g_npq.npq25
           #-MOD-B60021-end-
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#2",1)   #No.FUN-660116
               END IF
               LET g_success='N'
            END IF
         END IF
         #-----END CHI-840048-----

        #-TQC-B50087-mark-
        #-MOD-B60059-add-
         LET l_ocs_cnt = 0
         LET g_sql = "SELECT * FROM omb_file ",
                     " WHERE omb01 = '",g_oma.oma01,"'",
                     "   AND omb00 = '",g_oma.oma00,"'"
         PREPARE s_t300_def_pre FROM g_sql
         DECLARE s_t300_def_cs CURSOR WITH HOLD FOR s_t300_def_pre
         FOREACH s_t300_def_cs INTO l_omb.*
            CALL s_t300_chk_ocs(g_oma.*,l_omb.*) RETURNING l_ocs_cnt #檢查是否有設定售貨基本資料
         END FOREACH
         IF cl_null(l_ocs_cnt) THEN LET l_ocs_cnt = 0 END IF
        #IF g_oma.oma161 = 100 AND l_ocs_cnt = 0 THEN    #TQC-B60089 mark
         IF g_oma.oma161 = 100 AND g_oma.oma56 = 0 THEN  #TQC-B60089
            #貸方------------------------
            LET g_npq.npq02 = g_npq.npq02 + 1
            LET g_npq.npq04 = NULL   #MOD-780052
            #No.TQC-7B0035 --begin
#           LET g_npq.npq03 = g_ool.ool41
            IF g_npq.npqtype = '0' THEN
               LET g_npq.npq03 = g_ool.ool41
            ELSE
               LET g_npq.npq03 = g_ool.ool411
            END IF
            #No.TQC-7B0035 --end
            ##1999/07/26 modify by sophia  若不作部門管理
            LET g_aag05 = NULL
            LET g_aag23 = NULL
            SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
             WHERE aag01 = g_npq.npq03
               AND aag00 = g_bookno3   #No.FUN-740009
            IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
               LET g_npq.npq05 = ' '
            ELSE
               #FUN-680001...............begin
               #LET g_npq.npq05 = g_oma.oma15
               IF g_aag05='Y' THEN
                  LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
               END IF
               #FUN-680001...............end
            END IF

            IF g_aag23 = 'Y' THEN
               LET g_npq.npq08 = g_oma.oma63    # 專案
            ELSE
               LET g_npq.npq08 = null
            END IF
            ##-------------------------------
            LET g_npq.npq06 = '2'
            LET g_npq.npq23 = g_oma.oma01
            #-----CHI-840048---------
            #-----No:FUN-A50103-----
           #LET g_npq.npq07 = g_oma.oma53 * l_omb14tot / l_oea61  #TQC-B60089 mark
           #LET g_npq.npq07f= g_oma.oma52 * l_omb14tot / l_oea61  #TQC-B60089 mark
           #LET g_npq.npq07f = g_oma.oma52
            #LET g_npq.npq07 = g_oma.oma53
            ##-----No:FUN-A50103 END-----
            LET g_npq.npq24 = g_oma.oma23
            LET g_npq.npq25 = g_oma.oma24
            LET g_npq25 = g_npq.npq25   #FUN-9A0036
            #-----END CHI-840048-----
            LET g_npq.npq07f= g_oma.oma52 * l_oma54 / l_oea261    #TQC-B60089
            LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25          #TQC-B60089
            #No:9189
            #-----MOD-750132---------
            LET l_aag371=' '
            LET g_npq.npq37=''
            SELECT aag371 INTO l_aag371 FROM aag_file
             WHERE aag01=g_npq.npq03
               AND aag00 = g_bookno3
            #LET l_aag181=' '
            ##LET g_npq.npq14=''   #MOD-730062
            #LET g_npq.npq37=''   #MOD-730062
            #SELECT aag181 INTO l_aag181 FROM aag_file
            # WHERE aag01=g_npq.npq03
            #   AND aag00 = g_bookno3   #No.FUN-740009
            #IF l_aag181 MATCHES '[23]' THEN
            #   #-->for 合併報表-關係人
            #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
            #    WHERE occ01=g_oma.oma03
            #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
            #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
            #END IF
            #-----END MOD-750132-----
            #End
            MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
            IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
            #FUN-590100  --begin
            IF g_oma.oma00 MATCHES '2*' THEN
               LET g_npq.npq07 = (-1)*g_npq.npq07
               LET g_npq.npq07f= (-1)*g_npq.npq07f
            END IF
            #FUN-590100  --end
            #NO.FUN-5C0015 --start--
            #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
            CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
                 RETURNING g_npq.*
            #NO.FUN-5C0015 ---end---
            CALL s_def_npq31_npq34(g_npq.*,g_bookno3)                  #FUN-AA0087
             RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087
            #-----MOD-750132---------
       #    IF l_aag371 MATCHES '[23]' THEN          #FUN-950053 mark
            IF l_aag371 MATCHES '[234]' THEN         #FUN-950053 add
               #-->for 合併報表-關係人
            #No.FUN-9C0014 BEGIN -----
            #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
            #   WHERE occ01=g_oma.oma03
               IF cl_null(l_dbs1) THEN
                  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                   WHERE occ01=g_oma.oma03
               ELSE
                  #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs1 CLIPPED,"occ_file",
                  LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                              " WHERE occ01='",g_oma.oma03,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                  PREPARE sel_occ_pre05 FROM g_sql
                  EXECUTE sel_occ_pre05 INTO l_occ02,l_occ37
               END IF
            #No.FUN-9C0014 END -------
               IF cl_null(g_npq.npq37) THEN
                  IF l_occ37='Y' THEN
#                    LET g_npq.npq37=l_occ02 CLIPPED        #No.CHI-830037
                     LET g_npq.npq37=g_oma.oma03 CLIPPED    #No.CHI-830037
                  END IF
               END IF
            END IF
            #-----END MOD-750132-----
            IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
               IF g_type = '1' THEN
                  CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                                 g_npq25,g_npp.npp02)
                  RETURNING g_npq.npq25
                  LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#                 LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
               ELSE
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               END IF
#No.FUN-9A0036 --End
               #No.FUN-A30077  --Begin
               CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                           g_npq.npq07,g_npq.npq07f)
                                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
               #No.FUN-A30077  --End
               LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
               INSERT INTO npq_file VALUES (g_npq.*)
               IF STATUS OR SQLCA.SQLCODE THEN
                  IF g_bgerr THEN
                     LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                     CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
                  ELSE
                     CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#2",1)   #No.FUN-660116
                  END IF
                  LET g_success='N'
               END IF
            END IF   #MOD-820056
         END IF
        #-MOD-B60059-end
        #-TQC-B50087-end-
     #No.+041..end
  #END IF       #No.FUN-9C0014
     END FOREACH    #No:FUN-A50103
  END FOREACH   #No.FUN-9C0014

  SELECT * INTO g_oma.* FROM oma_file WHERE oma01 = g_oma.oma01
#--------------- (Dr:應收 Cr:銷貨收入,稅) -------------------
      #----------------------------------- (Dr:應收) --------
      LET g_npq.npq02 = g_npq.npq02 + 1
      LET g_npq.npq04 = NULL   #MOD-780052
      #FUN-670047  --begin
     #LET g_npq.npq03 = g_oma.oma18
      IF g_type = '0' THEN
         LET g_npq.npq03 = g_oma.oma18
      ELSE
         LET g_npq.npq03 = g_oma.oma181
      END IF
      #FUN-670047  --end
##1999/07/26 modify by sophia  若不作部門管理
      LET g_aag05 = NULL
      LET g_aag23 = NULL
      SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
       WHERE aag01 = g_npq.npq03
         AND aag00 = g_bookno3   #No.FUN-740009
      IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
         LET g_npq.npq05 = ' '
      ELSE
         #FUN-680001...............begin
         #LET g_npq.npq05 = g_oma.oma15
         IF g_aag05='Y' THEN
            LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
         END IF
         #FUN-680001...............end
      END IF
##----------------------------
      LET g_npq.npq06 = '1'
      #modify 030625 NO.A083
      IF l_cnt > 0 THEN
         LET g_npq.npq07f= g_oma.oma54t - l_oot04t
         LET g_npq.npq07 = g_oma.oma56t - l_oot05t
      ELSE
         LET g_npq.npq07f= g_oma.oma54t
         LET g_npq.npq07 = g_oma.oma56t
      END IF
      IF g_aag23 = 'Y' THEN
         LET g_npq.npq08 = g_oma.oma63    # 專案
      ELSE
         LET g_npq.npq08 = null
      END IF
    # LET g_npq.npq10 = g_oma.oma02
      LET g_npq.npq23 = g_oma.oma01
      #No:9189
      #-----MOD-750132---------
      LET l_aag371=' '
      LET g_npq.npq37=''
      SELECT aag371 INTO l_aag371 FROM aag_file
       WHERE aag01=g_npq.npq03
         AND aag00 = g_bookno3
      #LET l_aag181=' '
      ##LET g_npq.npq14=''   #MOD-730062
      #LET g_npq.npq37=''   #MOD-730062
      #SELECT aag181 INTO l_aag181 FROM aag_file
      # WHERE aag01=g_npq.npq03
      #   AND aag00 = g_bookno3   #No.FUN-740009
      #IF l_aag181 MATCHES '[23]' THEN
      #   #-->for 合併報表-關係人
      #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
      #    WHERE occ01=g_oma.oma03
      #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
      #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
      #END IF
      #-----END MOD-750132-----
      #End
      MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
      IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      #FUN-590100  --begin
      IF g_oma.oma00 MATCHES '2*' THEN
         LET g_npq.npq07 = (-1)*g_npq.npq07
         LET g_npq.npq07f= (-1)*g_npq.npq07f
      END IF
      #FUN-590100  --end
     #NO.FUN-5C0015 --start--
     #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
      CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
      RETURNING  g_npq.*
     #NO.FUN-5C0015 ---end---
      #-----MOD-750132---------
    # IF l_aag371 MATCHES '[23]' THEN              #FUN-950053 mark
      IF l_aag371 MATCHES '[234]' THEN             #FUN-950053 add
         #-->for 合併報表-關係人
      #No.FUN-9C0014 BEGIN -----
      #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
      #   WHERE occ01=g_oma.oma03
         IF cl_null(l_dbs) THEN
            SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
          WHERE occ01=g_oma.oma03
         ELSE
            #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
            LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        " WHERE occ01='",g_oma.oma03,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE sel_occ_pre06 FROM g_sql
            EXECUTE sel_occ_pre06 INTO l_occ02,l_occ37
         END IF
      #No.FUN-9C0014 END -------
         IF cl_null(g_npq.npq37) THEN
            IF l_occ37='Y' THEN
#              LET g_npq.npq37=l_occ02 CLIPPED     #No.CHI-830037
               LET g_npq.npq37=g_oma.oma03 CLIPPED  #No.CHI-830037
            END IF
         END IF
      END IF
      #-----END MOD-750132-----
      LET g_npq.npq24 = g_oma.oma23   #MOD-B60021
      LET g_npq.npq25 = g_oma.oma24   #MOD-B60021
      LET g_npq25 = g_npq.npq25       #MOD-B60021
      IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
         IF g_type = '1' THEN
            CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                           g_npq25,g_npp.npp02)
            RETURNING g_npq.npq25
            LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#           LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
         ELSE
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
         END IF
#No.FUN-9A0036 --End
         #No.FUN-A30077  --Begin
         CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                     g_npq.npq07,g_npq.npq07f)
              RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
         #No.FUN-A30077  --End
      LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
      INSERT INTO npq_file VALUES (g_npq.*)
     #No.+041 010330 by plum
#      #IF STATUS THEN CALL cl_err('ins npq#3',STATUS,1) LET g_success = 'N'
      IF STATUS OR SQLCA.SQLCODE THEN
#        CALL cl_err('ins npq#3',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
         IF g_bgerr THEN
            LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
            CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#3',SQLCA.SQLCODE,1)
         ELSE
            CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#3",1)   #No.FUN-660116
         END IF
#No.FUN-710050--end
         LET g_success='N'
      END IF
      END IF   #MOD-820056
     #No.+041..end
     #MOD-A30083---add---start---
     #已立待驗收入分錄者必須加以沖銷
      LET l_oga07 = ''
      LET l_oga24 = ''
      DECLARE omb_c CURSOR FOR
        SELECT omb03,omb31,omb44 FROM omb_file WHERE omb01=g_oma.oma01
      LET s_omb14=0
      LET s_omb16=0
      LET l_diff =0   #MOD-890196 add
      LET s_omb31=''  #MOD-970129 add
      FOREACH omb_c INTO l_omb03,l_omb31,l_omb44
         LET l_dbs1 = ''
         IF NOT cl_null(l_omb44) THEN
            LET g_plant_new = l_omb44
         ELSE
            LET g_plant_new = g_plant
         END IF
         CALL s_gettrandbs()
         LET l_dbs1 = g_dbs_tra
         #LET g_sql = "SELECT oga07,oga24 FROM ",l_dbs1 CLIPPED,"oga_file",
         LET g_sql = "SELECT oga07,oga24 FROM ",cl_get_target_table(g_plant_new,'oga_file'), #FUN-A50102
                     " WHERE oga01='",l_omb31,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
         PREPARE sel_oga_pre23 FROM g_sql
         EXECUTE sel_oga_pre23 INTO l_oga07,l_oga24
         IF l_oga07 = 'Y' THEN
            SELECT omb14,omb16 INTO l_omb14_2,l_omb16_2
               FROM omb_file WHERE omb03=l_omb03 AND omb01=g_oma.oma01
           #-MOD-AC0033-add-
            IF g_oma.oma162 < 100 THEN
               LET l_omb14_2 = l_omb14_2 * (g_oma.oma162/100)
            END IF
           #-MOD-AC0033-end-
            LET s_omb14=s_omb14+l_omb14_2
            LET s_omb16=s_omb16+l_omb16_2
            LET s_omb31=l_omb31
         END IF
        #-TQC-B80021-add-
         IF g_type = '1' THEN
            CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,l_oga24,g_npp.npp02) RETURNING l_oga24
         END IF
        #-TQC-B80021-end-
         LET l_diff = l_oga24 - g_npq.npq25
      END FOREACH
      IF l_oga07 = 'Y' THEN
         LET s_omb14=s_omb14-l_oot04
         LET s_omb16=s_omb16-l_oot05
         IF s_omb14>0 THEN
            #--FUN-A60007 start--

            #--切立銷貨收入分錄前,先計算是否有遞延收入金額,並切立分錄
            LET g_tot_oct12 = 0
            LET g_tot_oct12f = 0
           #LET l_type = '12'   #MOD-A90028 mark
            LET l_type = NULL   #MOD-A90028
            #呼叫s_t300_deferred計算oma00 = "12.出貨或21.折讓"之總遞延收入金額
#           CALL s_t300_deferred(l_type) RETURNING g_tot_oct12,g_tot_oct12f  #FUN-AB0110 mark
            #--FUN-A60007 end---------------------------------------------

            LET g_npq.npq02 = g_npq.npq02 + 1
            LET g_npq.npq04 = NULL
            SELECT npq03 INTO g_npq.npq03 FROM npq_file
            WHERE npqsys='AR' AND npq00  ='1' AND npq01=s_omb31
              AND npq011='1'  AND npqtype='0' AND npq06='1'
            LET g_aag05 = NULL
            SELECT aag05 INTO g_aag05 FROM aag_file
             WHERE aag01 = g_npq.npq03
               AND aag00 = g_bookno3
            IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
              LET g_npq.npq05 = ' '
            ELSE
              IF g_aag05='Y' THEN
                 LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
              END IF
            END IF

            LET g_npq.npq06 = '2'
            LET g_npq.npq07f= s_omb14
            LET g_npq.npq07 = s_omb14 * l_oga24
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)
            LET g_npq.npq08 = ' '
            LET g_npq.npq23 = ' '
            LET g_npq.npq25 = l_oga24
            LET g_npq25 = g_npq.npq25   #FUN-9A0036

          # NO.MOD-A30196 ---START----------
           LET l_aag371=''
           LET g_npq.npq37=''
           SELECT aag371 INTO l_aag371 FROM aag_file
            WHERE aag01=g_npq.npq03
              AND aag00 = g_bookno3
          # NO.MOD-A30196 ---END----------

            CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
            RETURNING  g_npq.*
          # NO.MOD-A30196 mark---START----------
          #  LET l_aag371=''
          #  LET g_npq.npq37=''
          #  SELECT aag371 INTO l_aag371 FROM aag_file
          #   WHERE aag01=g_npq.npq03
          #     AND aag00 = g_bookno3
          # NO.MOD-A30196 mark---END----------
          # IF l_aag371 MATCHES '[23]' THEN     #FUN-950053 mark
            IF l_aag371 MATCHES '[234]' THEN    #FUN-950053 add
               #-->for 合併報表-關係人
               IF cl_null(l_dbs) THEN
                  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                   WHERE occ01=g_oma.oma03
               ELSE
                  #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
                  LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                              " WHERE occ01='",g_oma.oma03,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                  PREPARE sel_occ_pre08 FROM g_sql
                  EXECUTE sel_occ_pre08 INTO l_occ02,l_occ37
               END IF
               IF cl_null(g_npq.npq37) THEN
                  IF l_occ37='Y' THEN
                     LET g_npq.npq37=g_oma.oma03 CLIPPED
                  END IF
               END IF
            END IF
            IF g_npq.npq07 <> 0 THEN
#No.FUN-9A0036 --Begin
               IF g_type = '1' THEN
                  CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                                 g_npq25,g_npp.npp02)
                  RETURNING g_npq.npq25
                  LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#                 LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
               ELSE
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               END IF
#No.FUN-9A0036 --End
               #No.FUN-A30077  --Begin
               CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                           g_npq.npq07,g_npq.npq07f)
                    RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
               #No.FUN-A30077  --End
               LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
  ##NO.FUN-A60007   --begin
               #--如有取得總遞延收入金額,原本已計算出的銷貨收入npq07要扣掉g_tot_oct12
               IF (g_tot_oct12 > 0 OR g_tot_oct12f > 0 )THEN
                   LET g_npq.npq07 = g_npq.npq07 - g_tot_oct12     #銷貨收入(本幣)
                   LET g_npq.npq07f = g_npq.npq07f - g_tot_oct12f #銷貨收入(原幣)
               END IF
  ##NO.FUN-A60007   --end
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
               INSERT INTO npq_file VALUES (g_npq.*)
               IF STATUS OR SQLCA.SQLCODE THEN
                  IF g_bgerr THEN
                     LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                     CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#7',SQLCA.SQLCODE,1)
                  ELSE
                     CALL cl_err('ins npq#7',SQLCA.SQLCODE,1)
                  END IF
                  LET g_success='N'
               END IF
            END IF
            LET g_oma.oma54 = g_oma.oma54-s_omb14
            LET g_oma.oma56 = g_oma.oma56-s_omb16

           #匯差分錄
            IF l_diff != 0 THEN
               LET g_npq.npq02 = g_npq.npq02 + 1
               LET g_npq.npq04 = NULL
              #匯兌損益改為抓借貸方差額
               LET l_npq07_d = 0   LET l_npq07_c = 0
               SELECT SUM(npq07) INTO l_npq07_d FROM npq_file
                WHERE npqsys = g_npq.npqsys  AND npq00  = g_npq.npq00
                  AND npq01  = g_npq.npq01   AND npq011 = g_npq.npq011
                  AND npqtype= g_npq.npqtype AND npq06 = '1'
               SELECT SUM(npq07) INTO l_npq07_c FROM npq_file
                WHERE npqsys = g_npq.npqsys  AND npq00  = g_npq.npq00
                  AND npq01  = g_npq.npq01   AND npq011 = g_npq.npq011
                  AND npqtype= g_npq.npqtype AND npq06 = '2'
               LET g_npq.npq07 = l_npq07_c - l_npq07_d
               LET g_npq.npq07f= 0
               LET g_npq.npq24 = g_aza.aza17
               LET g_npq.npq25 = 1
               LET g_npq25 = g_npq.npq25   #FUN-9A0036
               IF g_npq.npq07 < 0 THEN
                  LET g_npq.npq07 = (-1)*g_npq.npq07
                  LET g_npq.npq06 = '2'
                  IF g_npq.npqtype = '0' THEN
                     LET g_npq.npq03 = g_ool.ool53
                  ELSE
                     LET g_npq.npq03 = g_ool.ool531
                  END IF
               ELSE
                  LET g_npq.npq06 = '1'
                  IF g_npq.npqtype = '0' THEN
                     LET g_npq.npq03 = g_ool.ool52
                  ELSE
                     LET g_npq.npq03 = g_ool.ool521
                  END IF
               END IF
               LET g_aag05 = NULL
               LET g_aag23 = NULL
               SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
                WHERE aag01 = g_npq.npq03
                  AND aag00 = g_bookno3
               IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
                  LET g_npq.npq05 = ' '
               ELSE
                  IF g_aag05='Y' THEN
                     LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
                  END IF
               END IF
               IF g_aag23 = 'Y' THEN
                  LET g_npq.npq08 = g_oma.oma63
               ELSE
                  LET g_npq.npq08 = null
               END IF
               LET l_aag371=' '
               LET g_npq.npq37=''
               SELECT aag371 INTO l_aag371 FROM aag_file
                WHERE aag01=g_npq.npq03
                  AND aag00 = g_bookno3
               CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
               RETURNING  g_npq.*
             # IF l_aag371 MATCHES '[23]' THEN         #FUN-A50053 mark
               IF l_aag371 MATCHES '[234]' THEN        #FUN-A50053 add
                  #-->for 合併報表-關係人
                  IF cl_null(l_dbs) THEN
                     SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                      WHERE occ01=g_oma.oma03
                  ELSE
                     #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
                     LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                                 " WHERE occ01='",g_oma.oma03,"'"
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
                     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                     PREPARE sel_occ_pre09 FROM g_sql
                     EXECUTE sel_occ_pre09 INTO l_occ02,l_occ37
                  END IF
                  IF cl_null(g_npq.npq37) THEN
                     IF l_occ37='Y' THEN
                        LET g_npq.npq37=g_oma.oma03 CLIPPED
                     END IF
                  END IF
               END IF
               IF g_npq.npq07 <> 0 THEN
#No.FUN-9A0036 --Begin
                  IF g_type = '1' THEN
                     CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                                    g_npq25,g_npp.npp02)
                     RETURNING g_npq.npq25
                     LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#                    LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                     LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
                  ELSE
                     LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                  END IF
#No.FUN-9A0036 --End
                  #No.FUN-A30077  --Begin
                  CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                              g_npq.npq07,g_npq.npq07f)
                       RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
                  #No.FUN-A30077  --End
                  LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
                  INSERT INTO npq_file VALUES (g_npq.*)
                  IF STATUS OR SQLCA.SQLCODE THEN
                     IF g_bgerr THEN
                        LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                        CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
                     ELSE
                        CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#2",1)
                     END IF
                     LET g_success='N'
                  END IF
               END IF
            END IF
         END IF
      ELSE
     #MOD-A30083---add---end---
      #----------------------------------- (Cr:銷貨收入) ----
      #No.FUN-670047 --begin
         IF g_oma.oma162 > 0 THEN       #MOD-AC0407
            IF g_type = '0' THEN
              #LET l_sql = "SELECT omb45,omb33,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930,COUNT(*) ", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930 #MOD-B10123 add count #by elva
              #LET l_sql = "SELECT omb45,omb33,omb40,omb41,omb42,SUM(omb14),SUM(omb16),SUM(omb14t),SUM(omb16t),omb930,COUNT(*) ", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930 #MOD-B10123 add count #by elva #TQC-B50087 mark
               LET l_sql = "SELECT omb45,omb33,omb40,omb41,omb42,SUM(omb14),SUM(omb16),SUM(omb14t),SUM(omb16t),omb930 ",          #TQC-B50087
                                       #FUN-AC0027 add omb45
                           "  FROM omb_file",
                           " WHERE omb01='",g_oma.oma01,"'",
                           "   AND omb33 IS NOT NULL",
                           "   AND omb13 <> 0 ",   #No.MOD-840523
                           "  GROUP BY omb45,omb33,omb40,omb41,omb42,omb930"   #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
                                  #FUN-AC0027 add omb45
            ELSE
              #LET l_sql = "SELECT omb45,omb331,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930,COUNT(*) ", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930 #MOD-B10123 add count #by elva
              #LET l_sql = "SELECT omb45,omb331,omb40,omb41,omb42,SUM(omb14),SUM(omb16),SUM(omb14t),SUM(omb16t),omb930,COUNT(*) ", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930 #MOD-B10123 add count #by elva #TQC-B50087 mark
               LET l_sql = "SELECT omb45,omb331,omb40,omb41,omb42,SUM(omb14),SUM(omb16),SUM(omb14t),SUM(omb16t),omb930 ",          #TQC-B50087
                                  #FUN-AC0027 add omb45
                           "  FROM omb_file",
                           " WHERE omb01='",g_oma.oma01,"'",
                           "   AND omb331 IS NOT NULL",
                           "   AND omb13 <> 0 ",   #No.MOD-840523
                           "  GROUP BY omb45,omb331,omb40,omb41,omb42,omb930"   #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
                                  #FUN-AC0027 add omb45
            END IF
            PREPARE s_t300_gl_p2 FROM l_sql
            DECLARE s_t300_gl_c2 CURSOR FOR s_t300_gl_p2
            #No.FUN-670047 --end
            #No.TQC-5B0080 --start--
            #若有退貨折讓待扺,把金額平均分攤
            IF l_cnt > 0 THEN
               #No.FUN-670047 --begin
               IF g_type = '0' THEN
                  SELECT COUNT(DISTINCT(omb33)) INTO l_n FROM omb_file
                   WHERE omb01=g_oma.oma01 AND omb33 IS NOT NULL
               ELSE
                  SELECT COUNT(DISTINCT(omb331)) INTO l_n FROM omb_file
                   WHERE omb01=g_oma.oma01 AND omb331 IS NOT NULL
               END IF
               #No.FUN-670047 --end
               IF l_n > 0 THEN
                  LET  l_oot04t = l_oot04t / l_n
                  LET  l_oot05t = l_oot05t / l_n
               END IF
            END IF
            #No.TQC-5B0080 --end--
           #-TQC-B50087-mark-
           #LET l_cnt2 = 0         #MOD-B10123
           #LET l_cnt3 = 1         #MOD-B10123
           #LET l_sumoma54 = 0     #MOD-B10123
           #LET l_sumoma56 = 0     #MOD-B10123
           #-TQC-B50087-end-
           #FOREACH s_t300_gl_c2 INTO l_omb45,l_omb33,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb930,l_cnt2  #FUN-810045 add omb40/41/42  #MOD-8C0161 add l_omb930 #MOD-B10123 add l_cnt2 #by elva
           #FOREACH s_t300_gl_c2 INTO l_omb45,l_omb33,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb14t,l_omb16t,l_omb930,l_cnt2  #FUN-810045 add omb40/41/42  #MOD-8C0161 add l_omb930 #MOD-B10123 add l_cnt2 #by elva #TQC-B50087 mark
            FOREACH s_t300_gl_c2 INTO l_omb45,l_omb33,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb14t,l_omb16t,l_omb930         #TQC-B50087
                                           #FUN-AC0027 add omb45
               IF STATUS THEN EXIT FOREACH END IF

##NO.FUN-A60007   --begin
               LET g_tot_oct12 = 0
               LET g_tot_oct12f = 0
              #LET l_type = '12'      #MOD-A90028 mark
               LET l_type = l_omb33   #MOD-A90028
               #呼叫s_t300_deferred計算oma00 = "12.出貨 或 21.折讓"之總遞延收入金額,並切立分錄
               CALL s_t300_deferred(l_type) RETURNING g_tot_oct12,g_tot_oct12f
##NO.FUN-A60007   --end
               LET g_npq.npq02 = g_npq.npq02 + 1
               LET g_npq.npq04 = NULL   #MOD-780052
              ##  LET g_npq.npq03 = l_omb33  # mark by lixwz 20170717
              LET g_npq.npq03 = g_ool.ool41   # add by lixwz 20170717
              ##1999/07/26 modify by sophia  若不作部門管理
               LET g_aag05 = NULL
               LET g_aag23 = NULL
               SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
                WHERE aag01 = g_npq.npq03
                  AND aag00 = g_bookno3   #No.FUN-740009
               IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
                  LET g_npq.npq05 = ' '
               ELSE
                  LET g_npq.npq05 = g_oma.oma15
                  #FUN-680001...............begin
                  IF g_aag05='Y' THEN
                    #LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)   #MOD-8C0161 mark
                     LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,l_omb930)       #MOD-8C0161
                  END IF
                  #FUN-680001...............end
               END IF
              ##----------------------------
               LET g_npq.npq06 = '2'
              #FUN-B10058--add--str--
              IF g_oma.oma00 = '19' THEN
              ELSE
              #FUN-B10058--add--end
                #-TQC-B50087-mark-
                #IF g_oma.oma00 = '12' THEN   #CHI-B50018 add
                # #-MOD-B10123-add-
                #   LET l_omb14 = l_omb14 * (g_oma.oma162/100)
                #   LET l_omb14 = cl_digcut(l_omb14,t_azi04)
                #   LET l_sumoma54 = l_sumoma54 + l_omb14
                #   LET l_omb16 = l_omb16 * (g_oma.oma162/100)
                #   IF g_type = '0' THEN
                #      LET l_omb16 = cl_digcut(l_omb16,g_azi04)
                #   ELSE
                #      LET l_omb16 = cl_digcut(l_omb16,l_azi04_2)
                #   END IF
                #   LET l_sumoma56 = l_sumoma56 + l_omb16
                #   IF l_cnt2 = l_cnt3 THEN
                #      LET l_omb14 = l_omb14 + (l_sumoma54 - g_oma.oma54)
                #      LET l_omb16 = l_omb16 + (l_sumoma56 - g_oma.oma56)
                #   END IF
                # #-MOD-B10123-end-
                #END IF                       #CHI-B50018 add
                #-TQC-B50087-end-
              END IF    #FUN-B10058
               #No.TQC-5B0080 --start--
               #by elva begin # 代收科目取含税金额
               IF g_oma.oma00 = '19' THEN
                  IF l_cnt > 0 THEN
                     LET g_npq.npq07f = l_omb14t - l_oot04t
                     LET g_npq.npq07 = l_omb16t - l_oot05t
                  ELSE
                     LET g_npq.npq07f = l_omb14t
                     LET g_npq.npq07 = l_omb16t
                  END IF
               ELSE
                  IF l_cnt > 0 THEN
                     LET g_npq.npq07f = l_omb14 - l_oot04t
                     LET g_npq.npq07 = l_omb16 - l_oot05t
                  ELSE
                     LET g_npq.npq07f = l_omb14
                     LET g_npq.npq07 = l_omb16
                  END IF
               END IF
               #by elva end
              #LET l_cnt3 = l_cnt3 + 1  #MOD-B10123 #TQC-B50087 mark
               #No.TQC-5B0080 --end--
               #FUN-810045 remark begin
               #IF g_aag23 = 'Y' THEN
               #   LET g_npq.npq08 = g_oma.oma63    # 專案
               #ELSE
               #   LET g_npq.npq08 = null
               #END IF
               #FUN-810045 end
             # LET g_npq.npq10 = g_oma.oma02
               LET g_npq.npq23 = g_oma.oma01
               #No:9189
               #-----MOD-750132---------
               LET l_aag371=' '
               LET g_npq.npq37=''
               SELECT aag371 INTO l_aag371 FROM aag_file
                WHERE aag01=g_npq.npq03
                  AND aag00 = g_bookno3
               #LET l_aag181=' '
               ##LET g_npq.npq14=''   #MOD-730062
               #LET g_npq.npq37=''   #MOD-730062
               #SELECT aag181 INTO l_aag181 FROM aag_file
               # WHERE aag01=g_npq.npq03
               #   AND aag00 = g_bookno3   #No.FUN-740009
               #IF l_aag181 MATCHES '[23]' THEN
               #   #-->for 合併報表-關係人
               #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
               #    WHERE occ01=g_oma.oma03
               #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
               #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
               #END IF
               #-----END MOD-750132-----
               #End
               MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
               IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
               #FUN-590100  --begin
               IF g_oma.oma00 MATCHES '2*' THEN
                  LET g_npq.npq07 = (-1)*g_npq.npq07
                  LET g_npq.npq07f= (-1)*g_npq.npq07f
               END IF
               #FUN-590100  --end
              #NO.FUN-5C0015 --start--
              #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
               CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
               RETURNING  g_npq.*
              #NO.FUN-5C0015 ---end---
              #-----MOD-750132---------
            # IF l_aag371 MATCHES '[23]' THEN           #FUN-A50053 mark
              IF l_aag371 MATCHES '[234]' THEN          #FUN-A50053 add
                 #-->for 合併報表-關係人
              #No.FUN-9C0014 BEGIN -----
              #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
              #   WHERE occ01=g_oma.oma03
                  IF cl_null(l_dbs) THEN
                     SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                   WHERE occ01=g_oma.oma03
                  ELSE
                     #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
                     LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                                 " WHERE occ01='",g_oma.oma03,"'"
                     CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
                     CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                     PREPARE sel_occ_pre07 FROM g_sql
                     EXECUTE sel_occ_pre07 INTO l_occ02,l_occ37
                  END IF
               #No.FUN-9C0014 END -------
                 IF cl_null(g_npq.npq37) THEN
                    IF l_occ37='Y' THEN
      #                LET g_npq.npq37=l_occ02 CLIPPED    #No.CHI-830037
                       LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
                    END IF
                 END IF
              END IF
              #-----END MOD-750132-----
               #FUN-810045 add begin
                IF g_aag23 = 'Y' THEN     #MOD-A20056 add
                   LET g_npq.npq08 = l_omb41  #專案
                   LET g_npq.npq35 = l_omb42  #WBS
               #MOD-A20056---add---start---
                ELSE
                   LET g_npq.npq08 = null
                   LET g_npq.npq35 = null
                END IF
               #MOD-A20056---add---end---
               #MOD-950096  --begin--
                SELECT aag21 INTO l_aag21 FROM aag_file
                 WHERE aag00 = g_bookno3
                   AND aag01 = g_npq.npq03
               #MOD-950096  --end--
                IF l_aag21 = 'Y' THEN                         #MOD-950096
                    LET g_npq.npq36 = l_omb40  #費用原因
                END IF                                        #MOD-950096
               #FUN-810045 add end
               IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
                  IF g_type = '1' THEN
                     CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                                    g_npq25,g_npp.npp02)
                     RETURNING g_npq.npq25
                     LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#                    LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                     LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
                  ELSE
                     LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                  END IF
#No.FUN-9A0036 --End
                  #No.FUN-A30077  --Begin
                  CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                              g_npq.npq07,g_npq.npq07f)
                       RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
                  #No.FUN-A30077  --End
                LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
##NO.FUN-A60007   --begin
               LET g_sales = g_npq.npq07
               LET g_salesf = g_npq.npq07f
               #--取得總遞延收入金額後,原本已計算出的銷貨收入npq07要扣掉g_deferred--#
               IF (g_tot_oct12 > 0 OR g_tot_oct12f > 0 )THEN
                   LET g_npq.npq07 = g_sales - g_tot_oct12     #銷貨收入(本幣)
                   LET g_npq.npq07f = g_salesf - g_tot_oct12f  #銷貨收入(原幣)
               END IF
##NO.FUN-A60007   --end

#FUN-AC0027 --begin--
               IF g_oma.oma74 = '2' THEN  #代收
                  LET g_npq.npq21 = l_omb45  #客户赋值
                  SELECT lne05 INTO g_npq.npq22
                    FROM lne_file
                   WHERE lne01 = g_npq.npq21
               END IF
#FUN-AC0027 --end--
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
               INSERT INTO npq_file VALUES (g_npq.*)
              #No.+041 010330 by plum
                #IF STATUS THEN CALL cl_err('ins npq#4',STATUS,1) LET g_success = 'N'
               IF STATUS OR SQLCA.SQLCODE THEN
     #           CALL cl_err('ins npq#4',SQLCA.SQLCODE,1)   #No.FUN-660116
                 #No.FUN-710050--begin
                  IF g_bgerr THEN
                     LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                     CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#4',SQLCA.SQLCODE,1)
                  ELSE
                     CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#4",1)   #No.FUN-660116
                  END IF
                 #No.FUN-710050--end
                  LET g_success='N'
               END IF

               LET g_npq.npq21 = g_oma.oma03   #FUN-AC0027  客户重新赋默认值
               LET g_npq.npq22 = g_oma.oma032  #FUN-AC0027  客户重新赋默认值

              END IF   #MOD-820056
              #No.+041..end
               LET g_oma.oma54=g_oma.oma54-l_omb14
               LET g_oma.oma56=g_oma.oma56-l_omb16
               #No.TQC-5B0080 --start--
               IF l_cnt > 0 THEN
                  LET g_oma.oma54=g_oma.oma54+l_oot04t
                  LET g_oma.oma56=g_oma.oma56+l_oot05t
               END IF
               #No.TQC-5B0080 --end--
            END FOREACH
         END IF                         #MOD-AC0407
      END IF          #MOD-A30083 add
#MOD-A30083---mark---start---             #整段往上移
#        #-----MOD-690136---------已立待驗收入分錄者必須加以沖銷
#        DECLARE omb_c CURSOR FOR
#          SELECT omb03,omb31,omb44 FROM omb_file WHERE omb01=g_oma.oma01 #No.FUN-9C0014 Add omb44
#        LET s_omb14=0
#        LET s_omb16=0
#        LET l_diff =0   #MOD-890196 add
#        LET s_omb31=''  #MOD-970129 add
#        FOREACH omb_c INTO l_omb03,l_omb31,l_omb44   #No.FUN-9C0014 Add omb44
#          #No.FUN-9C0014 -BEGIN-----
#           LET l_dbs1 = ''
#           IF NOT cl_null(l_omb44) THEN
#              LET g_plant_new = l_omb44
#           ELSE
#              LET g_plant_new = g_plant
#           END IF
#           CALL s_gettrandbs()
#           LET l_dbs1 = g_dbs_tra
#          #SELECT oga07,oga24 INTO l_oga07,l_oga24   #MOD-890196 add oga24
#          #  FROM oga_file
#          #  WHERE oga01=l_omb31
#           LET g_sql = "SELECT oga07,oga24 FROM ",l_dbs1 CLIPPED,"oga_file",
#                       " WHERE oga01='",l_omb31,"'"
#           PREPARE sel_oga_pre23 FROM g_sql
#           EXECUTE sel_oga_pre23 INTO l_oga07,l_oga24
#          #No.FUN-9C0014 END -------
#           IF l_oga07 = 'Y' THEN
#              SELECT omb14,omb16 INTO l_omb14_2,l_omb16_2
#                 FROM omb_file WHERE omb03=l_omb03 AND omb01=g_oma.oma01
#              LET s_omb14=s_omb14+l_omb14_2
#              LET s_omb16=s_omb16+l_omb16_2
#              LET s_omb31=l_omb31   #MOD-970129 add
#           END IF
#           LET l_diff = l_oga24 - g_npq.npq25   #MOD-890196 add
#        END FOREACH
#        LET s_omb14=s_omb14-l_oot04   #MOD-8C0223 add
#        LET s_omb16=s_omb16-l_oot05   #MOD-8C0223 add
#        IF s_omb14>0 THEN
#           LET g_npq.npq02 = g_npq.npq02 + 1
#           LET g_npq.npq04 = NULL   #MOD-780052
#  #MOD-970129---begin
#  #         LET g_npq.npq03 = g_ool.ool15
#            SELECT npq03 INTO g_npq.npq03 FROM npq_file
#            WHERE npqsys='AR' AND npq00  ='1' AND npq01=s_omb31
#              AND npq011='1'  AND npqtype='0' AND npq06='1'
#  #MOD-970129---end
#  #NO.MOD-940085  --begin
#  #         LET g_npq.npq05 = ' '
#            LET g_aag05 = NULL
#            SELECT aag05 INTO g_aag05 FROM aag_file
#             WHERE aag01 = g_npq.npq03
#               AND aag00 = g_bookno3
#            IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
#              LET g_npq.npq05 = ' '
#            ELSE
#              IF g_aag05='Y' THEN
#                 LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
#              END IF
#            END IF
#  #NO.MOD-940085  --end
#
#           LET g_npq.npq06 = '2'
#           LET g_npq.npq07f= s_omb14
#          #LET g_npq.npq07 = s_omb16              #MOD-890196 mark
#           LET g_npq.npq07 = s_omb14 * l_oga24    #MOD-890196
#           LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)   #MOD-920066 add
#           LET g_npq.npq08 = ' '
#           LET g_npq.npq23 = ' '
#           LET g_npq.npq25 = l_oga24   #MOD-890196 add
#           #-----MOD-780052---------
#           CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
#           RETURNING  g_npq.*
#           LET l_aag371=''
#           LET g_npq.npq37=''
#           SELECT aag371 INTO l_aag371 FROM aag_file
#            WHERE aag01=g_npq.npq03
#              AND aag00 = g_bookno3
#           IF l_aag371 MATCHES '[23]' THEN
#              #-->for 合併報表-關係人
#           #No.FUN-9C0014 BEGIN -----
#           #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#           #   WHERE occ01=g_oma.oma03
#              IF cl_null(l_dbs) THEN
#                 SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#                  WHERE occ01=g_oma.oma03
#              ELSE
#                 LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
#                             " WHERE occ01='",g_oma.oma03,"'"
#                 PREPARE sel_occ_pre08 FROM g_sql
#                 EXECUTE sel_occ_pre08 INTO l_occ02,l_occ37
#              END IF
#           #No.FUN-9C0014 END -------
#              IF cl_null(g_npq.npq37) THEN
#                 IF l_occ37='Y' THEN
#  #                 LET g_npq.npq37=l_occ02 CLIPPED      #No.CHI-830037
#                    LET g_npq.npq37=g_oma.oma03 CLIPPED  #No.CHI-830037
#                 END IF
#              END IF
#           END IF
#           #-----END MOD-780052-----
#           IF g_npq.npq07 <> 0 THEN   #MOD-820056
#           INSERT INTO npq_file VALUES (g_npq.*)
#           IF STATUS OR SQLCA.SQLCODE THEN
#  #No.FUN-710050--begin
#              IF g_bgerr THEN
#                 LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
#                 CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#7',SQLCA.SQLCODE,1)
#              ELSE
#                 CALL cl_err('ins npq#7',SQLCA.SQLCODE,1)
#              END IF
#  #No.FUN-710050--end
#              LET g_success='N'
#           END IF
#           END IF   #MOD-820056
#           LET g_oma.oma54 = g_oma.oma54-s_omb14
#           LET g_oma.oma56 = g_oma.oma56-s_omb16
#
#          #str MOD-890196 add
#          #匯差分錄
#           IF l_diff != 0 THEN
#              LET g_npq.npq02 = g_npq.npq02 + 1
#              LET g_npq.npq04 = NULL
#             #str MOD-920066 mod
#             #匯兌損益改為抓借貸方差額
#             #LET g_npq.npq07 = g_npq.npq07f * l_diff
#             #LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)
#              LET l_npq07_d = 0   LET l_npq07_c = 0
#              SELECT SUM(npq07) INTO l_npq07_d FROM npq_file
#               WHERE npqsys = g_npq.npqsys  AND npq00  = g_npq.npq00
#                 AND npq01  = g_npq.npq01   AND npq011 = g_npq.npq011
#                 AND npqtype= g_npq.npqtype AND npq06 = '1'
#              SELECT SUM(npq07) INTO l_npq07_c FROM npq_file
#               WHERE npqsys = g_npq.npqsys  AND npq00  = g_npq.npq00
#                 AND npq01  = g_npq.npq01   AND npq011 = g_npq.npq011
#                 AND npqtype= g_npq.npqtype AND npq06 = '2'
#              LET g_npq.npq07 = l_npq07_c - l_npq07_d
#             #end MOD-920066 mod
#              LET g_npq.npq07f= 0
#              LET g_npq.npq24 = g_aza.aza17
#              LET g_npq.npq25 = 1
#              IF g_npq.npq07 < 0 THEN
#                 LET g_npq.npq07 = (-1)*g_npq.npq07
#                 LET g_npq.npq06 = '2'
#                 IF g_npq.npqtype = '0' THEN
#                    LET g_npq.npq03 = g_ool.ool53
#                 ELSE
#                    LET g_npq.npq03 = g_ool.ool531
#                 END IF
#              ELSE
#                 LET g_npq.npq06 = '1'
#                 IF g_npq.npqtype = '0' THEN
#                    LET g_npq.npq03 = g_ool.ool52
#                 ELSE
#                    LET g_npq.npq03 = g_ool.ool521
#                 END IF
#              END IF
#              LET g_aag05 = NULL
#              LET g_aag23 = NULL
#              SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
#               WHERE aag01 = g_npq.npq03
#                 AND aag00 = g_bookno3
#              IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
#                 LET g_npq.npq05 = ' '
#              ELSE
#                 IF g_aag05='Y' THEN
#                    LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
#                 END IF
#              END IF
#              IF g_aag23 = 'Y' THEN
#                 LET g_npq.npq08 = g_oma.oma63
#              ELSE
#                 LET g_npq.npq08 = null
#              END IF
#              LET l_aag371=' '
#              LET g_npq.npq37=''
#              SELECT aag371 INTO l_aag371 FROM aag_file
#               WHERE aag01=g_npq.npq03
#                 AND aag00 = g_bookno3
#              CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
#              RETURNING  g_npq.*
#              IF l_aag371 MATCHES '[23]' THEN
#                 #-->for 合併報表-關係人
#              #No.FUN-9C0014 BEGIN -----
#              #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#              #   WHERE occ01=g_oma.oma03
#                 IF cl_null(l_dbs) THEN
#                    SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#                     WHERE occ01=g_oma.oma03
#                 ELSE
#                    LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
#                                " WHERE occ01='",g_oma.oma03,"'"
#                    PREPARE sel_occ_pre09 FROM g_sql
#                    EXECUTE sel_occ_pre09 INTO l_occ02,l_occ37
#                 END IF
#              #No.FUN-9C0014 END -------
#                 IF cl_null(g_npq.npq37) THEN
#                    IF l_occ37='Y' THEN
#                       LET g_npq.npq37=g_oma.oma03 CLIPPED
#                    END IF
#                 END IF
#              END IF
#              IF g_npq.npq07 <> 0 THEN
#                 INSERT INTO npq_file VALUES (g_npq.*)
#                 IF STATUS OR SQLCA.SQLCODE THEN
#                    IF g_bgerr THEN
#                       LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
#                       CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
#                    ELSE
#                       CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#2",1)   #No.FUN-660116
#                    END IF
#                    LET g_success='N'
#                 END IF
#              END IF
#           END IF
#          #end MOD-890196 add
#        END IF
#        #-----END MOD-690136-----
#MOD-A30083---mark---end---

      LET g_npq.npq24 = g_oma.oma23   #MOD-B60021
      LET g_npq.npq25 = g_oma.oma24   #MOD-B60021
      LET g_npq25 = g_npq.npq25       #MOD-B60021
      #-----No.FUN-660073-----
    # LET l_sql = "SELECT omb45,omb40,omb41,omb42,SUM(omb14),SUM(omb16),azf14", #FUN-810045 add omb41/42  FUN-AC0027 acc omb45
      LET l_sql = "SELECT omb45,omb40,omb41,omb42,SUM(omb14),SUM(omb16),SUM(omb14t),SUM(omb16t),azf14", #FUN-810045 add omb41/42  FUN-AC0027 acc omb45 #by elva
                  "  FROM omb_file,azf_file",
                  " WHERE omb01='",g_oma.oma01,"'",
                  "   AND omb40 IS NOT NULL",
                  "   AND omb40 = azf01",
                  "   AND azf08 = 'Y'",
                  "   AND omb13 = 0 ",   #No.MOD-840523
                  "  GROUP BY omb45,omb40,omb41,omb42,azf14"   #FUN-810045 add omb41/42  FUN-AC0027 add omb45
      PREPARE s_t300_gl_p3 FROM l_sql
      DECLARE s_t300_gl_c3 CURSOR FOR s_t300_gl_p3

     #FOREACH s_t300_gl_c3 INTO l_omb45,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_azf14   #FUN-810045 add omb41/42  FUN-AC0027 add omb45
      FOREACH s_t300_gl_c3 INTO l_omb45,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb14t,l_omb16t,l_azf14   #FUN-810045 add omb41/42  FUN-AC0027 add omb45 #by elva
         IF STATUS THEN
            EXIT FOREACH
         END IF

         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL   #MOD-780052
         LET g_npq.npq03 = l_azf14
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
         END IF
         LET g_npq.npq06 = '2'
         #by elva begin 代收取含税
         IF g_oma.oma00='19' THEN
            IF l_cnt > 0 THEN
               LET g_npq.npq07f= l_omb14t - l_oot04
               LET g_npq.npq07 = l_omb16t - l_oot05
            ELSE
               LET g_npq.npq07f= l_omb14t
               LET g_npq.npq07 = l_omb16t
            END IF
         ELSE
            IF l_cnt > 0 THEN
               LET g_npq.npq07f= l_omb14 - l_oot04
               LET g_npq.npq07 = l_omb16 - l_oot05
            ELSE
               LET g_npq.npq07f= l_omb14
               LET g_npq.npq07 = l_omb16
            END IF
         END IF
         #by elva end
       #FUN-810045 remark begin
         #IF g_aag23 = 'Y' THEN
         #   LET g_npq.npq08 = g_oma.oma63    # 專案
         #ELSE
         #   LET g_npq.npq08 = null
         #END IF
       #FUN-810045 remark end
         LET g_npq.npq23 = g_oma.oma01
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00 = g_bookno3   #No.FUN-740009
         #
         #IF l_aag181 MATCHES '[23]' THEN
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----

         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03

         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF

         IF g_oma.oma00 MATCHES '2*' THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq07f= (-1)*g_npq.npq07f
         END IF

        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
              RETURNING g_npq.*

         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN              #FUN-A50053 mark
         IF l_aag371 MATCHES '[234]' THEN             #FUN-A50053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre10 FROM g_sql
               EXECUTE sel_occ_pre10 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED       #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
        #FUN-810045 add begin
         IF g_aag23 = 'Y' THEN     #MOD-A20056 add
            LET g_npq.npq08 = l_omb41  #專案
            LET g_npq.npq35 = l_omb42  #WBS
        #MOD-A20056---add---start---
         ELSE
            LET g_npq.npq08 = null
            LET g_npq.npq35 = null
         END IF
        #MOD-A20056---add---end---
#MOD-950096  --begin--
         SELECT aag21 INTO l_aag21 FROM aag_file
          WHERE aag00 = g_bookno3
            AND aag01 = g_npq.npq03
#MOD-950096  --end--
         IF l_aag21 = 'Y' THEN                           #MOD-950096
            LET g_npq.npq36 = l_omb40　#費用原因
         END IF                                          #MOD-950096
        #FUN-810045 add end
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
#FUN-AC0027 --begin--
            IF g_oma.oma74 = '2' THEN  #代收
               LET g_npq.npq21 = l_omb45  #客户赋值
               SELECT lne05 INTO g_npq.npq22
                 FROM lne_file
                WHERE lne01 = g_npq.npq21
            END IF
#FUN-AC0027 --end--
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
#No.FUN-710050--begin
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#5',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#5",1)   #No.FUN-660116
               END IF
#No.FUN-710050--end
               LET g_success='N'
            END IF
            LET g_npq.npq21 = g_oma.oma03   #Add No.TQC-B10108  客户重新赋默认值
            LET g_npq.npq22 = g_oma.oma032  #Add No.TQC-B10108  客户重新赋默认值
         END IF   #MOD-820056

         LET g_oma.oma54 = g_oma.oma54-l_omb14
         LET g_oma.oma56 = g_oma.oma56-l_omb16
         IF l_cnt > 0 THEN
            LET g_oma.oma54 = g_oma.oma54+l_oot04t
            LET g_oma.oma56 = g_oma.oma56+l_oot05t
         END IF

      END FOREACH
      #-----No.FUN-660073 END-----

      IF g_oma.oma56 > 0 THEN
  ##NO.FUN-A60007   --begin
         LET g_tot_oct12 = 0
         LET g_tot_oct12f = 0
        #LET l_type = '12'   #MOD-A90028 mark
         LET l_type = NULL   #MOD-A90028
         #呼叫新增FUNCTION,計算oma00 = "12.出貨 或 21.折讓"之總遞延收入金額
         CALL s_t300_deferred(l_type) RETURNING g_tot_oct12,g_tot_oct12f
  ##NO.FUN-A60007   --end
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET t_ITEM = g_npq.npq02    # 先將銷貨收入的項次記錄下, 後面要扣除稅額時可 Update 到該筆資料.  #FUN-B40032 ADD
         LET g_npq.npq04 = NULL   #MOD-780052
#No.TQC-7B0035 --begin
#        LET g_npq.npq03 = g_ool.ool41
         IF g_npq.npqtype = '0' THEN
         # add by lixwz 20170802  s
            SELECT unique tc_ool41 INTO l_tc_ool41
                  FROM tc_ool_file,omb_file
                  WHERE tc_ool03=omb04  AND omb01=g_oma.oma01
            IF cl_null(l_tc_ool41)  THEN
                  SELECT unique  tc_ool41  INTO l_tc_ool41 FROM tc_ool_file
                          WHERE tc_ool04 in
                                (SELECT unique ima08    FROM omb_file,ima_file
                                    WHERE ima01=omb04 AND omb01=g_oma.oma01)
                  IF cl_null(l_tc_ool41) THEN
                        LET g_npq.npq03 = g_ool.ool41
                  ELSE
                        LET g_npq.npq03 = l_tc_ool41
                  END IF
            ELSE
                  LET g_npq.npq03 = l_tc_ool41
            END IF
            # add by lixwz 20170802  e
            # LET g_npq.npq03 = g_ool.ool41  mark by lixwz 20170802
         ELSE
            LET g_npq.npq03 = g_ool.ool411
         END IF
#No.TQC-7B0035 --end
         ##1999/07/26 modify by sophia  若不作部門管理
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
         END IF
         ##----------------------------
         LET g_npq.npq06 = '2'
         #modify 030625 NO.A083
         LET l_oma53 = g_oma.oma24 * g_oma.oma52             #MOD-B60021
         CALL cl_digcut(l_oma53,g_azi04) RETURNING l_oma53   #MOD-B60021
         IF l_cnt > 0 THEN
            LET g_npq.npq07f= g_oma.oma54 - l_oot04 + g_oma.oma52 #TQC-B50087 add oma52
            LET g_npq.npq07 = g_oma.oma56 - l_oot05 + l_oma53 #TQC-B50087 add oma53 #MOD-B60021 mod g_oma.oma53 -> l_oma53
         ELSE
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
            #當 oma70(來源類型) = '3' 時, 銷貨收入所扣除的稅額要以應收實際交易稅別明細資料檔(omk_file)的資料為準.
            #因此當 oma70 = '3' 時, g_npq.npg07f 及 g_npq.npg07 要先維持為應收含稅總金額.
            #IF g_oma.oma70 <> '3' THEN
            IF g_oma.oma70 <> '3' OR cl_null(g_oma.oma70) THEN     #mod by zhangym 121203
###-FUN-B40032- ADD -  END  ---------------------------------------------------
               LET g_npq.npq07f= g_oma.oma54 + g_oma.oma52 #TQC-B50087 add oma52
               LET g_npq.npq07 = g_oma.oma56 + l_oma53 #TQC-B50087 add oma53           #MOD-B60021 mod g_oma.oma53 -> l_oma53
            END IF             #FUN-B40032 ADD
         END IF
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
       # LET g_npq.npq10 = g_oma.oma02
         LET g_npq.npq23 = g_oma.oma01
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00 = g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
         #End
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         #FUN-590100  --begin
         IF g_oma.oma00 MATCHES '2*' THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq07f= (-1)*g_npq.npq07f
         END IF
         #FUN-590100  --end
        #NO.FUN-5C0015 --start--
        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
        #NO.FUN-5C0015 ---end---
         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN         #FUN-A50053 mark
         IF l_aag371 MATCHES '[234]' THEN        #FUN-A50053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre11 FROM g_sql
               EXECUTE sel_occ_pre11 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
##NO.FUN-A60007   --begin
         LET g_sales = g_npq.npq07   #先把銷貨收入金額備份
         LET g_salesf = g_npq.npq07f   #先把銷貨收入金額備份
         #--取得總遞延收入金額後,原本已計算出的銷貨收入npq07要扣掉g_deferred--#
         IF (g_tot_oct12 > 0 OR g_tot_oct12f > 0 )THEN
             LET g_npq.npq07 = g_sales - g_tot_oct12    #銷貨收入(本幣)
             LET g_npq.npq07f = g_salesf - g_tot_oct12f #銷貨收入(原幣)
         END IF
##NO.FUN-A60007   --end
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
        #No.+041 010330 by plum
          #IF STATUS THEN CALL cl_err('ins npq#5',STATUS,1) LET g_success = 'N'
         IF STATUS OR SQLCA.SQLCODE THEN
#           CALL cl_err('ins npq#5',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#5',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#5",1)   #No.FUN-660116
            END IF
#No.FUN-710050--end
            LET g_success='N'
         END IF
         END IF   #MOD-820056
        #No.+041..end
      END IF
    #FUN-B10058--add--str--代收分录没有税
    IF g_oma.oma00 = '19' THEN
    ELSE
    #FUN-B10058--add--end
      #----------------------------------- (Cr:稅) ----------
      IF g_oma.oma54x > 0 THEN
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL   #MOD-780052
         IF g_npq.npqtype = '0' THEN   #No.TQC-740309
            # add by lixwz 20170802  s
            SELECT unique tc_ool28 INTO l_tc_ool28
                  FROM tc_ool_file,omb_file
                  WHERE tc_ool03=omb04  AND omb01=g_oma.oma01
            IF cl_null(l_tc_ool28)  THEN
                  SELECT unique  tc_ool28  INTO l_tc_ool28 FROM tc_ool_file
                          WHERE tc_ool04 in
                                (SELECT unique ima08    FROM omb_file,ima_file
                                    WHERE ima01=omb04 AND omb01=g_oma.oma01)
                  IF cl_null(l_tc_ool28) THEN
                        LET g_npq.npq03 = g_ool.ool28
                  ELSE
                        LET g_npq.npq03 = l_tc_ool28
                  END IF
            ELSE
                  LET g_npq.npq03 = l_tc_ool28
            END IF
            # add by lixwz 20170802  e
            # LET g_npq.npq03 = g_ool.ool28 mark by lixwz 20170802
         #No.TQC-740309 --start--
         ELSE
            LET g_npq.npq03 = g_ool.ool281
         END IF
         #No.TQC-740309 --end--
##1999/07/26 modify by sophia  若不作部門管理
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
         END IF
##----------------------------
         LET g_npq.npq06 = '2'
         #modify 030625 NO.A083
         IF l_cnt > 0 THEN
            LET g_npq.npq07f= g_oma.oma54x - l_oot04x
            LET g_npq.npq07 = g_oma.oma56x - l_oot05x
         ELSE
###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
            # 當 oma70(來源類型) = '3' 時, 銷貨稅額要以應收實際交易稅別明細資料檔(omk_file)的資料為準.
            IF g_oma.oma70 = '3' THEN
               SELECT SUM(omk08) INTO g_npq.npq07f FROM omk_file
                WHERE omk01 = g_oma.oma01 AND omk04 > 0
               LET g_npq.npq07 = g_npq.npq07f
               LET t_T = g_npq.npq07f
            ELSE
###-FUN-B40032- ADD -  END  ---------------------------------------------------
               LET g_npq.npq07f= g_oma.oma54x
               LET g_npq.npq07 = g_oma.oma56x
            END IF             #FUN-B40032 ADD
         END IF
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
       # LET g_npq.npq10 = g_oma.oma02
         LET g_npq.npq23 = g_oma.oma01
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00 = g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
         #End
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         #FUN-590100  --begin
         IF g_oma.oma00 MATCHES '2*' THEN
            LET g_npq.npq07 = (-1)*g_npq.npq07
            LET g_npq.npq07f= (-1)*g_npq.npq07f
         END IF
         #FUN-590100  --end
        #NO.FUN-5C0015 --start--
        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
        #NO.FUN-5C0015 ---end---
         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN         #FUN-A50053 mark
         IF l_aag371 MATCHES '[234]' THEN        #FUN-A50053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre12 FROM g_sql
               EXECUTE sel_occ_pre12 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED       #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
        LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
        #No.+041 010330 by plum
          #IF STATUS THEN CALL cl_err('ins npq#6',STATUS,1) LET g_success = 'N'
         IF STATUS OR SQLCA.SQLCODE THEN
#           CALL cl_err('ins npq#6',SQLCA.SQLCODE,1)   #No.FUN-660116
#No.FUN-710050--begin
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#6',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#6",1)   #No.FUN-660116
            END IF
#No.FUN-710050--end
            LET g_success='N'
         END IF
         END IF   #MOD-820056
        #No.+041..end
      END IF

###-FUN-B40032- ADD - BEGIN ---------------------------------------------------
      #----------------------------------- (Cr:健康捐) ----------
      IF g_oma.oma54x > 0 AND g_oma.oma70 = '3' THEN
         SELECT SUM(omk08) INTO g_npq.npq07f FROM omk_file WHERE omk01 = g_oma.oma01 AND omk05 > 0
         IF (g_npq.npq07f > 0) THEN
            LET g_npq.npq02 = g_npq.npq02 + 1
            LET g_npq.npq04 = NULL
            IF g_npq.npqtype = '0' THEN
               LET g_npq.npq03 = g_ool.ool55
            ELSE
               LET g_npq.npq03 = g_ool.ool551
            END IF
            LET g_aag05 = NULL
            LET g_aag23 = NULL
            SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
             WHERE aag01 = g_npq.npq03
               AND aag00 = g_bookno3
            IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
               LET g_npq.npq05 = ' '
            ELSE
               IF g_aag05='Y' THEN
                  LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
               END IF
            END IF
            LET g_npq.npq06 = '2'
            LET g_npq.npq07 = g_npq.npq07f
            LET t_HAL = g_npq.npq07f
            IF g_aag23 = 'Y' THEN
               LET g_npq.npq08 = g_oma.oma63    # 專案
            ELSE
               LET g_npq.npq08 = null
            END IF
            LET g_npq.npq23 = g_oma.oma01
            LET l_aag371=' '
            LET g_npq.npq37=''
            SELECT aag371 INTO l_aag371 FROM aag_file
             WHERE aag01=g_npq.npq03
               AND aag00 = g_bookno3
            MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
            IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
            IF g_oma.oma00 MATCHES '2*' THEN
               LET g_npq.npq07 = (-1)*g_npq.npq07
               LET g_npq.npq07f= (-1)*g_npq.npq07f
            END IF
            CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
            RETURNING  g_npq.*
            IF l_aag371 MATCHES '[234]' THEN
               #-->for 合併報表-關係人
               IF cl_null(l_dbs) THEN
                  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                   WHERE occ01=g_oma.oma03
               ELSE
                  LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'),
                              " WHERE occ01='",g_oma.oma03,"'"
                  CALL cl_replace_sqldb(g_sql) RETURNING g_sql
                  CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
                  PREPARE sel_occ_pre13 FROM g_sql
                  EXECUTE sel_occ_pre13 INTO l_occ02,l_occ37
               END IF
               IF cl_null(g_npq.npq37) THEN
                  IF l_occ37='Y' THEN
                     LET g_npq.npq37=g_oma.oma03 CLIPPED
                  END IF
               END IF
            END IF
            IF g_npq.npq07 <> 0 THEN
               IF g_type = '1' THEN
                  CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                                 g_npq25,g_npp.npp02)
                  RETURNING g_npq.npq25
                  LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)
               ELSE
                  LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)
               END IF
               CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                           g_npq.npq07,g_npq.npq07f)
               RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
               LET g_npq.npq30 = g_oma.oma66
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
               INSERT INTO npq_file VALUES (g_npq.*)
               IF STATUS OR SQLCA.SQLCODE THEN
                  IF g_bgerr THEN
                     LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                     CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#6',SQLCA.SQLCODE,1)
                  ELSE
                     CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#6",1)
                  END IF
                  LET g_success='N'
               END IF
            END IF
         END IF
      END IF
      #------------貸方：券的稅額-----------------#
      IF (g_oma.oma54x > 0) AND (g_oma.oma70 = '3') THEN
         LET t_rxy05t = 0
         LET t_rxy05 = 0
         LET t_rxy05x = 0
         LET g_sql = "SELECT SUM(rxy05) ",
                     "  FROM ",cl_get_target_table(g_plant_new,'rxy_file'),
                     " WHERE rxy00 = '02' ",
                     "   AND rxy01 IN (SELECT DISTINCT omb31 ",
                     "                   FROM ",cl_get_target_table(g_plant_new,'omb_file'),
                     "                  WHERE omb01 = '",g_oma.oma01,"')",
                     "                    AND rxy03 = '04'"
         PREPARE sel_rxy_pre FROM g_sql
         EXECUTE sel_rxy_pre INTO t_rxy05t
         IF (t_rxy05t IS NOT NULL) AND (t_rxy05t > 0) THEN
            IF g_aza.aza26 = '0' THEN
               LET t_rxy05 = cl_digcut((t_rxy05t / 1.05),g_azi04)
               LET t_rxy05x = t_rxy05t - t_rxy05
            ELSE
               LET t_rxy05 = t_rxy05t
               LET t_rxy05x = 0
            END IF
         END IF
      END IF
      #貸方 : 更新銷貨收入金額, 銷貨收入金額 = 銷貨收入 - 銷項稅額 - 健康捐 - 禮券的稅額#
      IF (g_oma.oma54x > 0) AND (g_oma.oma70 = '3') THEN
         IF cl_null(t_T) THEN LET t_T = 0 END IF
         IF cl_null(t_HAL) THEN LET t_HAL = 0 END IF
         IF cl_null(t_rxy05x) THEN LET t_rxy05x = 0 END IF
         UPDATE npq_file
            SET npq07f = (npq07f - t_T - t_HAL - t_rxy05x),
                npq07  = (npq07f - t_T - t_HAL - t_rxy05x)
          WHERE npq00 = 2 AND npq01 = g_trno
            AND npq02 = t_ITEM AND npq011 = 1
            AND npqsys = 'AR' AND npqtype = g_type AND npq06 = '2'
      END IF

###-FUN-B40032- ADD -  END  ---------------------------------------------------
    END IF    #FUN-B10058
END FUNCTION

#No.+009 010416 by plum add for oma00='2*'可產生分錄 ->  貸 oma18
FUNCTION s_t300_gl_21()
DEFINE l_aag15      LIKE aag_file.aag15
   DEFINE l_omb33               LIKE omb_file.omb33    #No.FUN-680123 VARCHAR(20)
   DEFINE l_omb40               LIKE omb_file.omb40    #CHI-B60028 add
   DEFINE l_omb41               LIKE omb_file.omb41    #CHI-B60028 add
   DEFINE l_omb42               LIKE omb_file.omb42    #CHI-B60028 add
   DEFINE l_omb930              LIKE omb_file.omb930   #CHI-B60028 add
   DEFINE l_omb14,l_omb16       LIKE omb_file.omb14    #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_aaa03               LIKE aaa_file.aaa03    #FUN-A40067
   DEFINE l_azi04_2             LIKE azi_file.azi04    #FUN-A40067
   DEFINE l_type                LIKE type_file.chr2    #NO.FUN-A60007
   DEFINE l_sql                 STRING                 #CHI-B60028 add
   DEFINE l_flag                LIKE type_file.chr1    #CHI-B60028 add

#FUN-A40067 --Begin
   SELECT aaa03 INTO l_aaa03 FROM aaa_file
    WHERE aaa01 = g_bookno2
   SELECT azi04 INTO l_azi04_2 FROM azi_file
    WHERE azi01 = l_aaa03
#FUN-A40067 --End

   LET g_npp.nppsys = 'AR'
   LET g_npp.npplegal = g_legal     #FUN-980011 add
   LET g_npp.npp00 = 2
   LET g_npp.npp01 = g_oma.oma01
   LET g_npp.npp011 =  1
   LET g_npp.npp02 = g_oma.oma02
   LET g_npp.npp03 = NULL
   LET g_npp.npptype = g_type     #No.FUN-670047
   INSERT INTO npp_file VALUES(g_npp.*)
   IF STATUS THEN
#     CALL cl_err('ins npp',STATUS,1)   #No.FUN-660116
#No.FUN-710050--begin
      IF g_bgerr THEN
         LET g_showmsg=g_npp.npp01,"/",g_npp.npp011,"/",g_npp.nppsys,"/",g_npp.npp00
         CALL s_errmsg('npp01,npp011,nppsys,npp00',g_showmsg,'ins npp',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("ins","npp_file",g_npp.nppsys,g_npp.npp01,STATUS,"","ins npp",1)   #No.FUN-660116
      END IF
#No.FUN-710050--end
      LET g_success='N'
   END IF

   LET g_npq.npqsys = 'AR'
   LET g_npq.npqlegal = g_legal     #FUN-980011 add
   LET g_npq.npq00 = 2
   LET g_npq.npq01 = g_oma.oma01
   LET g_npq.npq011 =  1
   LET g_npq.npq02 = 0
   LET g_npq.npqtype = g_type     #No.FUN-670047
   LET g_npq.npq04 = NULL        LET g_npq.npq05 = g_oma.oma15
   LET g_npq.npq21 = g_oma.oma03 LET g_npq.npq22 = g_oma.oma032
   LET g_npq.npq24 = g_oma.oma23 LET g_npq.npq25 = g_oma.oma24
   LET g_npq25 = g_npq.npq25   #FUN-9A0036

##NO.FUN-A60007   --begin
   LET g_tot_oct12 = 0
   LET g_tot_oct12f = 0
  #LET l_type = '21'   #MOD-A90028 mark
   LET l_type = NULL   #MOD-A90028
   #<---呼叫新增FUNCTION,計算oma00 = "21.折讓"之總遞延收入金額
   CALL s_t300_deferred(l_type)  RETURNING g_tot_oct12,g_tot_oct12f
   #--取得總遞延收入金額後,原本已計算出的銷貨退回npq07要扣掉g_deferred--#
##NO.FUN-A60007   --end
  #Dr:oma34=1,4->ool42;=5->ool47,稅   Cr:oma18(ool26)
  ##借方:ool42,ool47 貸方:oma18
  #-(Dr:銷退) ----------
  #str CHI-B60028 add
  #當帳款單身有設定科目時,應依單身科目產生Dr:銷退
   IF g_type = '0' THEN
      LET l_sql = "SELECT omb33,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930 ",
                  "  FROM omb_file",
                  " WHERE omb01='",g_oma.oma01,"'",
                  "   AND omb33 IS NOT NULL",
                  " GROUP BY omb33,omb40,omb41,omb42,omb930"
   ELSE
      LET l_sql = "SELECT omb331,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930 ",
                  "  FROM omb_file",
                  " WHERE omb01='",g_oma.oma01,"'",
                  "   AND omb331 IS NOT NULL",
                  " GROUP BY omb331,omb40,omb41,omb42,omb930"
   END IF
   PREPARE s_t300_gl_p21 FROM l_sql
   DECLARE s_t300_gl_c21 CURSOR FOR s_t300_gl_p21
   LET l_flag = 'N'
   FOREACH s_t300_gl_c21 INTO l_omb33,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb930
      IF STATUS THEN EXIT FOREACH END IF
      LET l_flag = 'Y'

      LET g_npq.npq06 = '1'
      LET g_npq.npq02 = g_npq.npq02 + 1
      LET g_npq.npq03 = l_omb33
      LET g_npq.npq05 = g_oma.oma15
      LET g_aag05 = NULL
      LET g_aag23 = NULL
      SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
       WHERE aag01 = g_npq.npq03
         AND aag00 = g_bookno3   #No.FUN-740009
      IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
         LET g_npq.npq05 = ' '
      ELSE
         IF g_aag05='Y' THEN
            LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,l_omb930)
         END IF
      END IF
      LET g_npq.npq07f= l_omb14
      LET g_npq.npq07 = l_omb16
      IF g_aag23 = 'Y' THEN
         LET g_npq.npq08 = g_oma.oma63    # 專案
      ELSE
         LET g_npq.npq08 = null
      END IF
      LET g_npq.npq23 = g_oma.oma01
      LET l_aag371=' '
      LET g_npq.npq37=''
      SELECT aag371 INTO l_aag371 FROM aag_file
       WHERE aag01=g_npq.npq03 AND aag00=g_bookno3
      MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
      IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
           RETURNING  g_npq.*
      CALL s_def_npq31_npq34(g_npq.*,g_bookno3) RETURNING g_npq.npq31,g_npq.npq32,g_npq.npq33,g_npq.npq34 #FUN-AA0087 add
      IF l_aag371 MATCHES '[234]' THEN   #No.FUN-950053 add 4
         #-->for 合併報表-關係人
         IF cl_null(g_plant_new) THEN
            SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
             WHERE occ01=g_oma.oma03
         ELSE
            LET l_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'),
                        " WHERE occ01='",g_oma.oma03,"'"
            CALL cl_replace_sqldb(l_sql) RETURNING l_sql
            CALL cl_parse_qry_sql(l_sql,g_plant_new) RETURNING l_sql
            PREPARE sel_occ_pre13_1 FROM l_sql
            EXECUTE sel_occ_pre13_1 INTO l_occ02,l_occ37
         END IF
         IF cl_null(g_npq.npq37) THEN
            IF l_occ37='Y' THEN
               LET g_npq.npq37=g_oma.oma03 CLIPPED
            END IF
         END IF
      END IF
      IF g_npq.npq07 <> 0 THEN
         IF g_type = '1' THEN
            CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                           g_npq25,g_npp.npp02)
            RETURNING g_npq.npq25
            LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)
         ELSE
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)
         END IF
         CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                     g_npq.npq07,g_npq.npq07f)
              RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f

      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
         IF STATUS THEN
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#1",1)
            END IF
            LET g_success='N'
         END IF
      END IF
   END FOREACH

   IF l_flag = 'N' THEN   #表示單身沒有設定科目,依照原本的規則產生Dr:銷退
  #end CHI-B60028 add
       LET g_npq.npq06 = '1'
       LET g_npq.npq02 = g_npq.npq02 + 1
       CASE WHEN g_oma.oma00='21'
                 IF g_oma.oma34 ='5' THEN
                    LET g_npq.npq03=g_ool.ool47
                 ELSE
                    LET g_npq.npq03=g_ool.ool42
                 END IF
            WHEN g_oma.oma00='22'
                 IF g_oma.oma13 = '99' THEN
                    LET g_npq.npq03=g_ool.ool25    #cancel mark by zhangym 120927
                   #LET g_npq.npq03=g_ool.ool47   #No.MOD-910005  #mark by zhangym 120927
                 ELSE
                   #LET g_npq.npq03=g_ool.ool25
                    LET g_npq.npq03=g_ool.ool47   #No.MOD-910005
                 END IF
            WHEN g_oma.oma00='25'
                 LET g_npq.npq03=g_ool.ool51
            #FUN-B10058--add--str--
            #by elva oma00='28'的处理移至s_t300_gl_28(),故此段mark
           # WHEN g_oma.oma00='28'
           #      IF g_oma.oma34 ='5' THEN
           #         LET g_npq.npq03=g_ool.ool47
           #      ELSE
           #         LET g_npq.npq03=g_ool.ool42
           #      END IF
            #FUN-B10058--add--end
       END CASE
       LET g_npq.npq05 = g_oma.oma15
       LET g_aag05 = NULL
       LET g_aag23 = NULL
       SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
        WHERE aag01 = g_npq.npq03
          AND aag00 = g_bookno3   #No.FUN-740009
       IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
          LET g_npq.npq05 = ' '
       ELSE
          #FUN-680001...............begin
          #LET g_npq.npq05 = g_oma.oma15
          IF g_aag05='Y' THEN
             LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
          END IF
          #FUN-680001...............end
       END IF
       #FUN-B10058--add--str--
       IF g_oma.oma00 = '28' THEN
          LET g_npq.npq07f = g_oma.oma54t
          LET g_npq.npq07 = g_oma.oma56t
       ELSE
       #FUN-B10058--add--end
          LET g_npq.npq07f= g_oma.oma54
          LET g_npq.npq07 = g_oma.oma56
       END IF   #FUN-B10058
       IF g_aag23 = 'Y' THEN
          LET g_npq.npq08 = g_oma.oma63    # 專案
       ELSE
          LET g_npq.npq08 = null
       END IF
       LET g_npq.npq23 = g_oma.oma01
       #No:9189
       #-----MOD-750132---------
       LET l_aag371=' '
       LET g_npq.npq37=''
       SELECT aag371 INTO l_aag371 FROM aag_file
        WHERE aag01=g_npq.npq03
          AND aag00 = g_bookno3
       #LET l_aag181=' '
       ##LET g_npq.npq14=''   #MOD-730062
       #LET g_npq.npq37=''   #MOD-730062
       #SELECT aag181 INTO l_aag181 FROM aag_file
       # WHERE aag01=g_npq.npq03
       #   AND aag00 = g_bookno3   #No.FUN-740009
       #IF l_aag181 MATCHES '[23]' THEN
       #   #-->for 合併報表-關係人
       #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #    WHERE occ01=g_oma.oma03
       #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
       #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
       #END IF
       #-----END MOD-750132-----
       #End
       MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
       IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      #NO.FUN-5C0015 --start--
      #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
       CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
       RETURNING  g_npq.*
      #NO.FUN-5C0015 ---end---
       #-----MOD-750132---------
     # IF l_aag371 MATCHES '[23]' THEN   #FUN-A50053 mark
       IF l_aag371 MATCHES '[234]' THEN  #FUN-A50053 add
          #-->for 合併報表-關係人
       #No.FUN-9C0014 BEGIN -----
       #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #   WHERE occ01=g_oma.oma03
          IF cl_null(l_dbs) THEN
             SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
              WHERE occ01=g_oma.oma03
          ELSE
             #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
             LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                         " WHERE occ01='",g_oma.oma03,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel_occ_pre22 FROM g_sql
             EXECUTE sel_occ_pre22 INTO l_occ02,l_occ37
          END IF
       #No.FUN-9C0014 END -------
          IF cl_null(g_npq.npq37) THEN
             IF l_occ37='Y' THEN
#               LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
             END IF
          END IF
       END IF
       #-----END MOD-750132-----
       IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
          IF g_type = '1' THEN
             CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                            g_npq25,g_npp.npp02)
             RETURNING g_npq.npq25
             LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
          ELSE
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
          END IF
#No.FUN-9A0036 --End
          #No.FUN-A30077  --Begin
          CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                      g_npq.npq07,g_npq.npq07f)
               RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
          #No.FUN-A30077  --End
       LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
  ##NO.FUN-A60007   --begin
#        LET g_sales = g_npq.npq07     #CHI-B60028 mark
#        LET g_salesf = g_npq.npq07f   #CHI-B60028 mark
#FUN-AB0110 --Begin mark
#        #--取得總遞延收入金額後,原本已計算出的銷貨退回npq07要扣掉g_deferred--#
#        IF (g_tot_oct12 OR g_tot_oct12f )> 0 THEN
#            LET g_npq.npq07 = g_sales - g_tot_oct12     #本幣
#            LET g_npq.npq07f = g_salesf - g_tot_oct12f  #原幣
#        END IF
#FUN-AB0110 --End mark
  ##NO.FUN-A60007   --end
        #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
       INSERT INTO npq_file VALUES (g_npq.*)
       IF STATUS THEN
#         CALL cl_err('ins npq#1',STATUS,1)      #No.FUN-660116
#No.FUN-710050--begin
          IF g_bgerr THEN
             LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
             CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
          ELSE
             CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#1",1)   #No.FUN-660116
          END IF
#No.FUN-710050--end
          LET g_success='N'
       END IF
       END IF   #MOD-820056
   END IF   #CHI-B60028 add

     LET g_npq.npq04=NULL
     #-(Dr:稅) ----------
     #FUN-B10058--add--str--   #代退分录不含税
#    IF g_oma.oma00 = '28' THEN
#    ELSE
     #fun-b10058--add--end
       IF g_oma.oma54x > 0 THEN
         LET g_npq.npq02 = g_npq.npq02 + 1
         IF g_npq.npqtype = '0' THEN   #No.TQC-740309
            LET g_npq.npq03 = g_ool.ool28
         #No.TQC-740309 --start--
         ELSE
            LET g_npq.npq03 = g_ool.ool281
         END IF
         #No.TQC-740309 --end--
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3   #No.FUN-740009
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
         END IF
         LET g_npq.npq06 = '1'
         LET g_npq.npq07f= g_oma.oma54x
         LET g_npq.npq07 = g_oma.oma56x
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         LET g_npq.npq23 = g_oma.oma01
         #No:9189
         #-----MOD-750132---------
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         #LET l_aag181=' '
         ##LET g_npq.npq14=''   #MOD-730062
         #LET g_npq.npq37=''   #MOD-730062
         #SELECT aag181 INTO l_aag181 FROM aag_file
         # WHERE aag01=g_npq.npq03
         #   AND aag00 = g_bookno3   #No.FUN-740009
         #IF l_aag181 MATCHES '[23]' THEN
         #   #-->for 合併報表-關係人
         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #    WHERE occ01=g_oma.oma03
         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
         #END IF
         #-----END MOD-750132-----
         #End
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
        #NO.FUN-5C0015 --start--
        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
        #NO.FUN-5C0015 ---end---
         #-----MOD-750132---------
       # IF l_aag371 MATCHES '[23]' THEN            #FUN-A50053 mark
         IF l_aag371 MATCHES '[234]' THEN           #FUN-A50053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre14 FROM g_sql
               EXECUTE sel_occ_pre14 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
#                 LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                  LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
               END IF
            END IF
         END IF
         #-----END MOD-750132-----
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
         IF STATUS THEN
#           CALL cl_err('ins npq#2',STATUS,1)     #No.FUN-660116
#No.FUN-710050--begin
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#2",1)   #No.FUN-660116
            END IF
#No.FUN-710050--end
            LET g_success='N'
         END IF
         END IF   #MOD-820056
      END IF
#    END IF  #FUN-B10058
      LET g_npq.npq04=NULL
     #-(Cr:oma18) ----------
       LET g_npq.npq06 = '2'
       LET g_npq.npq02 = g_npq.npq02 + 1
       #No.FUN-670047 --begin
       IF g_npq.npqtype = '0' THEN
          LET g_npq.npq03 = g_oma.oma18
       ELSE
          LET g_npq.npq03 = g_oma.oma181
       END IF
       #No.FUN-670047 --end
       LET g_npq.npq05 = g_oma.oma15
       LET g_aag05 = NULL
       LET g_aag23 = NULL
       SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
        WHERE aag01 = g_npq.npq03
          AND aag00 = g_bookno3   #No.FUN-740009
       IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
          LET g_npq.npq05 = ' '
       ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
       END IF
       LET g_npq.npq07f= g_oma.oma54t
       LET g_npq.npq07 = g_oma.oma56t
       IF g_aag23 = 'Y' THEN
          LET g_npq.npq08 = g_oma.oma63    # 專案
       ELSE
          LET g_npq.npq08 = null
       END IF
       LET g_npq.npq23 = g_oma.oma01
       #No:9189
       #-----MOD-750132---------
       LET l_aag371=' '
       LET g_npq.npq37=''
       SELECT aag371 INTO l_aag371 FROM aag_file
        WHERE aag01=g_npq.npq03
          AND aag00 = g_bookno3
       #LET l_aag181=' '
       ##LET g_npq.npq14=''   #MOD-730062
       #LET g_npq.npq37=''   #MOD-730062
       #SELECT aag181 INTO l_aag181 FROM aag_file
       # WHERE aag01=g_npq.npq03
       #   AND aag00 = g_bookno3   #No.FUN-740009
       #IF l_aag181 MATCHES '[23]' THEN
       #   #-->for 合併報表-關係人
       #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #    WHERE occ01=g_oma.oma03
       #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
       #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
       #END IF
       #-----END MOD-750132-----
       #End
       MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
       IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      #NO.FUN-5C0015 --start--
      #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
       CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
       RETURNING  g_npq.*
      #NO.FUN-5C0015 ---end---
       #-----MOD-750132---------
     # IF l_aag371 MATCHES '[23]' THEN              #FUN-A50053 mark
       IF l_aag371 MATCHES '[234]' THEN             #FUN-A50053 add
          #-->for 合併報表-關係人
       #No.FUN-9C0014 BEGIN -----
       #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #   WHERE occ01=g_oma.oma03
          IF cl_null(l_dbs) THEN
             SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
              WHERE occ01=g_oma.oma03
          ELSE
             #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
             LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                         " WHERE occ01='",g_oma.oma03,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel_occ_pre15 FROM g_sql
             EXECUTE sel_occ_pre15 INTO l_occ02,l_occ37
          END IF
       #No.FUN-9C0014 END -------
          IF cl_null(g_npq.npq37) THEN
             IF l_occ37='Y' THEN
#               LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
             END IF
          END IF
       END IF
       #-----END MOD-750132-----
       IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
          IF g_type = '1' THEN
             CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                            g_npq25,g_npp.npp02)
             RETURNING g_npq.npq25
             LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
          ELSE
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
          END IF
#No.FUN-9A0036 --End
          #No.FUN-A30077  --Begin
          CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                      g_npq.npq07,g_npq.npq07f)
               RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
          #No.FUN-A30077  --End
       LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
       INSERT INTO npq_file VALUES (g_npq.*)
       IF STATUS THEN
#          CALL cl_err('ins npq#3',STATUS,1)      #No.FUN-660116
#No.FUN-710050--begin
           IF g_bgerr THEN
              LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
              CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#3',SQLCA.SQLCODE,1)
           ELSE
              CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#3",1)   #No.FUN-660116
           END IF
#No.FUN-710050--end
          LET g_success='N'
       END IF
       END IF   #MOD-820056
END FUNCTION

#FUN-B10058 -begin by elva
FUNCTION s_t300_gl_28()
DEFINE l_aag15      LIKE aag_file.aag15
   DEFINE l_omb                 RECORD LIKE omb_file.* #by elva
   DEFINE l_omb33               LIKE omb_file.omb33    #No.FUN-680123 VARCHAR(20)
   DEFINE l_omb14,l_omb16       LIKE omb_file.omb14    #No.FUN-680123 DEC(20,6)  #FUN-4C0013
   DEFINE l_aaa03               LIKE aaa_file.aaa03    #FUN-A40067
   DEFINE l_azi04_2             LIKE azi_file.azi04    #FUN-A40067
   DEFINE l_type                LIKE type_file.chr2    #NO.FUN-A60007

#FUN-A40067 --Begin
   SELECT aaa03 INTO l_aaa03 FROM aaa_file
    WHERE aaa01 = g_bookno2
   SELECT azi04 INTO l_azi04_2 FROM azi_file
    WHERE azi01 = l_aaa03
#FUN-A40067 --End

   LET g_npp.nppsys = 'AR'
   LET g_npp.npplegal = g_legal     #FUN-980011 add
   LET g_npp.npp00 = 2
   LET g_npp.npp01 = g_oma.oma01
   LET g_npp.npp011 =  1
   LET g_npp.npp02 = g_oma.oma02
   LET g_npp.npp03 = NULL
   LET g_npp.npptype = g_type     #No.FUN-670047
   INSERT INTO npp_file VALUES(g_npp.*)
   IF STATUS THEN
#     CALL cl_err('ins npp',STATUS,1)   #No.FUN-660116
#No.FUN-710050--begin
      IF g_bgerr THEN
         LET g_showmsg=g_npp.npp01,"/",g_npp.npp011,"/",g_npp.nppsys,"/",g_npp.npp00
         CALL s_errmsg('npp01,npp011,nppsys,npp00',g_showmsg,'ins npp',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("ins","npp_file",g_npp.nppsys,g_npp.npp01,STATUS,"","ins npp",1)   #No.FUN-660116
      END IF
#No.FUN-710050--end
      LET g_success='N'
   END IF

   LET g_npq.npqsys = 'AR'
   LET g_npq.npqlegal = g_legal     #FUN-980011 add
   LET g_npq.npq00 = 2
   LET g_npq.npq01 = g_oma.oma01
   LET g_npq.npq011 =  1
   LET g_npq.npq02 = 0
   LET g_npq.npqtype = g_type     #No.FUN-670047
   LET g_npq.npq04 = NULL        LET g_npq.npq05 = g_oma.oma15
#  LET g_npq.npq21 = g_oma.oma03 LET g_npq.npq22 = g_oma.oma032 #by elva
   LET g_npq.npq24 = g_oma.oma23 LET g_npq.npq25 = g_oma.oma24
   LET g_npq25 = g_npq.npq25   #FUN-9A0036

##NO.FUN-A60007   --begin
   LET g_tot_oct12 = 0
   LET g_tot_oct12f = 0
  #LET l_type = '21'   #MOD-A90028 mark
   LET l_type = NULL   #MOD-A90028
   #<---呼叫新增FUNCTION,計算oma00 = "21.折讓"之總遞延收入金額
   CALL s_t300_deferred(l_type)  RETURNING g_tot_oct12,g_tot_oct12f
   #--取得總遞延收入金額後,原本已計算出的銷貨退回npq07要扣掉g_deferred--#
##NO.FUN-A60007   --end
  #Dr:oma34=1,4->ool42;=5->ool47,稅   Cr:oma18(ool26)
  ##借方:ool42,ool47 貸方:oma18
     #-(Dr:銷退) ----------
       LET g_npq.npq06 = '1'
       LET g_npq.npq05 = g_oma.oma15
       #by elva --begin
       LET g_sql = "SELECT * FROM omb_file WHERE omb01='",g_oma.oma01,"'"
       PREPARE s_pre_omb FROM g_sql
       DECLARE s_omb_cur CURSOR FOR s_pre_omb
       FOREACH s_omb_cur INTO l_omb.*
          LET g_npq.npq02 = g_npq.npq02 + 1
          LET g_npq.npq03 = l_omb.omb33
          LET g_npq.npq21 = l_omb.omb45
          SELECT lne05 INTO g_npq.npq22
            FROM lne_file
           WHERE lne01 = g_npq.npq21
          LET g_aag05 = NULL
          LET g_aag23 = NULL
          SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
           WHERE aag01 = g_npq.npq03
             AND aag00 = g_bookno3   #No.FUN-740009
          IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
             LET g_npq.npq05 = ' '
          ELSE
             #FUN-680001...............begin
             #LET g_npq.npq05 = g_oma.oma15
             IF g_aag05='Y' THEN
                LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
             END IF
             #FUN-680001...............end
          END IF
          #FUN-B10058--add--str--
         #LET g_npq.npq07f = g_oma.oma54t
         #LET g_npq.npq07 = g_oma.oma56t
          IF g_aag23 = 'Y' THEN
             LET g_npq.npq08 = g_oma.oma63    # 專案
          ELSE
             LET g_npq.npq08 = null
          END IF
          LET g_npq.npq23 = g_oma.oma01
          #No:9189
          #-----MOD-750132---------
          LET l_aag371=' '
          LET g_npq.npq37=''
          SELECT aag371 INTO l_aag371 FROM aag_file
           WHERE aag01=g_npq.npq03
             AND aag00 = g_bookno3
          #LET l_aag181=' '
          ##LET g_npq.npq14=''   #MOD-730062
          #LET g_npq.npq37=''   #MOD-730062
          #SELECT aag181 INTO l_aag181 FROM aag_file
          # WHERE aag01=g_npq.npq03
          #   AND aag00 = g_bookno3   #No.FUN-740009
          #IF l_aag181 MATCHES '[23]' THEN
          #   #-->for 合併報表-關係人
          #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
          #    WHERE occ01=g_oma.oma03
          #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
          #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
          #END IF
          #-----END MOD-750132-----
          #End
          MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
          IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         #NO.FUN-5C0015 --start--
         #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
          CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
          RETURNING  g_npq.*
         #NO.FUN-5C0015 ---end---
          #-----MOD-750132---------
        # IF l_aag371 MATCHES '[23]' THEN   #FUN-A50053 mark
          IF l_aag371 MATCHES '[234]' THEN  #FUN-A50053 add
             #-->for 合併報表-關係人
          #No.FUN-9C0014 BEGIN -----
          #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
          #   WHERE occ01=g_oma.oma03
             IF cl_null(l_dbs) THEN
                SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                 WHERE occ01=g_oma.oma03
             ELSE
                #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
                LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                            " WHERE occ01='",g_oma.oma03,"'"
                CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
                CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
                PREPARE sel1_occ_pre13 FROM g_sql
                EXECUTE sel1_occ_pre13 INTO l_occ02,l_occ37
             END IF
          #No.FUN-9C0014 END -------
             IF cl_null(g_npq.npq37) THEN
                IF l_occ37='Y' THEN
   #               LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                   LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
                END IF
             END IF
          END IF
          #-----END MOD-750132-----
          LET g_npq.npq07f = l_omb.omb14t
          LET g_npq.npq07 = l_omb.omb16t
          IF g_npq.npq07 <> 0 THEN   #MOD-820056
   #No.FUN-9A0036 --Begin
             IF g_type = '1' THEN
                CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                               g_npq25,g_npp.npp02)
                RETURNING g_npq.npq25
                LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
   #            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
                LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
             ELSE
                LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
             END IF
   #No.FUN-9A0036 --End
             #No.FUN-A30077  --Begin
             CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                         g_npq.npq07,g_npq.npq07f)
                  RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
             #No.FUN-A30077  --End
          LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
     ##NO.FUN-A60007   --begin
#           LET g_sales = g_npq.npq07     #CHI-B60028 mark
#           LET g_salesf = g_npq.npq07f   #CHI-B60028 mark
   #FUN-AB0110 --Begin mark
   #        #--取得總遞延收入金額後,原本已計算出的銷貨退回npq07要扣掉g_deferred--#
   #        IF (g_tot_oct12 OR g_tot_oct12f )> 0 THEN
   #            LET g_npq.npq07 = g_sales - g_tot_oct12     #本幣
   #            LET g_npq.npq07f = g_salesf - g_tot_oct12f  #原幣
   #        END IF
   #FUN-AB0110 --End mark
     ##NO.FUN-A60007   --end
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
          INSERT INTO npq_file VALUES (g_npq.*)
          IF STATUS THEN
   #         CALL cl_err('ins npq#1',STATUS,1)      #No.FUN-660116
   #No.FUN-710050--begin
             IF g_bgerr THEN
                LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
             ELSE
                CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#1",1)   #No.FUN-660116
             END IF
   #No.FUN-710050--end
             LET g_success='N'
          END IF
          END IF   #MOD-820056
       END FOREACH
       #by elva --end

       LET g_npq.npq04=NULL
     #-(Dr:稅) ----------
     #FUN-B10058--add--str--   #代退分录不含税
#mark by elva --begin
#     IF g_oma.oma00 = '28' THEN
#     ELSE
#     #fun-b10058--add--end
#       IF g_oma.oma54x > 0 THEN
#         LET g_npq.npq02 = g_npq.npq02 + 1
#         IF g_npq.npqtype = '0' THEN   #No.TQC-740309
#            LET g_npq.npq03 = g_ool.ool28
#         #No.TQC-740309 --start--
#         ELSE
#            LET g_npq.npq03 = g_ool.ool281
#         END IF
#         #No.TQC-740309 --end--
#         LET g_aag05 = NULL
#         LET g_aag23 = NULL
#         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
#          WHERE aag01 = g_npq.npq03
#            AND aag00 = g_bookno3   #No.FUN-740009
#         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
#            LET g_npq.npq05 = ' '
#         ELSE
#            #FUN-680001...............begin
#            #LET g_npq.npq05 = g_oma.oma15
#            IF g_aag05='Y' THEN
#               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
#            END IF
#            #FUN-680001...............end
#         END IF
#         LET g_npq.npq06 = '1'
#         LET g_npq.npq07f= g_oma.oma54x
#         LET g_npq.npq07 = g_oma.oma56x
#         IF g_aag23 = 'Y' THEN
#            LET g_npq.npq08 = g_oma.oma63    # 專案
#         ELSE
#            LET g_npq.npq08 = null
#         END IF
#         LET g_npq.npq23 = g_oma.oma01
#         #No:9189
#         #-----MOD-750132---------
#         LET l_aag371=' '
#         LET g_npq.npq37=''
#         SELECT aag371 INTO l_aag371 FROM aag_file
#          WHERE aag01=g_npq.npq03
#            AND aag00 = g_bookno3
#         #LET l_aag181=' '
#         ##LET g_npq.npq14=''   #MOD-730062
#         #LET g_npq.npq37=''   #MOD-730062
#         #SELECT aag181 INTO l_aag181 FROM aag_file
#         # WHERE aag01=g_npq.npq03
#         #   AND aag00 = g_bookno3   #No.FUN-740009
#         #IF l_aag181 MATCHES '[23]' THEN
#         #   #-->for 合併報表-關係人
#         #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#         #    WHERE occ01=g_oma.oma03
#         #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
#         #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
#         #END IF
#         #-----END MOD-750132-----
#         #End
#         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
#         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
#        #NO.FUN-5C0015 --start--
#        #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
#         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
#         RETURNING  g_npq.*
#        #NO.FUN-5C0015 ---end---
#         #-----MOD-750132---------
#       # IF l_aag371 MATCHES '[23]' THEN            #FUN-A50053 mark
#         IF l_aag371 MATCHES '[234]' THEN           #FUN-A50053 add
#            #-->for 合併報表-關係人
#         #No.FUN-9C0014 BEGIN -----
#         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#         #   WHERE occ01=g_oma.oma03
#            IF cl_null(l_dbs) THEN
#               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
#                WHERE occ01=g_oma.oma03
#            ELSE
#               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
#               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
#                           " WHERE occ01='",g_oma.oma03,"'"
#               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
#               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#               PREPARE sel_occ_pre14 FROM g_sql
#               EXECUTE sel_occ_pre14 INTO l_occ02,l_occ37
#            END IF
#         #No.FUN-9C0014 END -------
#            IF cl_null(g_npq.npq37) THEN
#               IF l_occ37='Y' THEN
##                 LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
#                  LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
#               END IF
#            END IF
#         END IF
#         #-----END MOD-750132-----
#         IF g_npq.npq07 <> 0 THEN   #MOD-820056
##No.FUN-9A0036 --Begin
#            IF g_type = '1' THEN
#               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
#                              g_npq25,g_npp.npp02)
#               RETURNING g_npq.npq25
#               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
##              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
#               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
#            ELSE
#               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
#            END IF
##No.FUN-9A0036 --End
#            #No.FUN-A30077  --Begin
#            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
#                                        g_npq.npq07,g_npq.npq07f)
#                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
#            #No.FUN-A30077  --End
#         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
#         INSERT INTO npq_file VALUES (g_npq.*)
#         IF STATUS THEN
##           CALL cl_err('ins npq#2',STATUS,1)     #No.FUN-660116
##No.FUN-710050--begin
#            IF g_bgerr THEN
#               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
#               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#2',SQLCA.SQLCODE,1)
#            ELSE
#               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#2",1)   #No.FUN-660116
#            END IF
##No.FUN-710050--end
#            LET g_success='N'
#         END IF
#         END IF   #MOD-820056
#      END IF
#     END IF  #FUN-B10058
#mark by elva --end
      LET g_npq.npq04=NULL
     #-(Cr:oma18) ----------
       LET g_npq.npq06 = '2'
       LET g_npq.npq02 = g_npq.npq02 + 1
       #No.FUN-670047 --begin
       IF g_npq.npqtype = '0' THEN
          LET g_npq.npq03 = g_oma.oma18
       ELSE
          LET g_npq.npq03 = g_oma.oma181
       END IF
       #No.FUN-670047 --end
       LET g_npq.npq21 = g_oma.oma03 LET g_npq.npq22 = g_oma.oma032 #FUN-B10058 by elva
       LET g_npq.npq05 = g_oma.oma15
       LET g_aag05 = NULL
       LET g_aag23 = NULL
       SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
        WHERE aag01 = g_npq.npq03
          AND aag00 = g_bookno3   #No.FUN-740009
       IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
          LET g_npq.npq05 = ' '
       ELSE
            #FUN-680001...............begin
            #LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
            #FUN-680001...............end
       END IF
       LET g_npq.npq07f= g_oma.oma54t
       LET g_npq.npq07 = g_oma.oma56t
       IF g_aag23 = 'Y' THEN
          LET g_npq.npq08 = g_oma.oma63    # 專案
       ELSE
          LET g_npq.npq08 = null
       END IF
       LET g_npq.npq23 = g_oma.oma01
       #No:9189
       #-----MOD-750132---------
       LET l_aag371=' '
       LET g_npq.npq37=''
       SELECT aag371 INTO l_aag371 FROM aag_file
        WHERE aag01=g_npq.npq03
          AND aag00 = g_bookno3
       #LET l_aag181=' '
       ##LET g_npq.npq14=''   #MOD-730062
       #LET g_npq.npq37=''   #MOD-730062
       #SELECT aag181 INTO l_aag181 FROM aag_file
       # WHERE aag01=g_npq.npq03
       #   AND aag00 = g_bookno3   #No.FUN-740009
       #IF l_aag181 MATCHES '[23]' THEN
       #   #-->for 合併報表-關係人
       #   SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #    WHERE occ01=g_oma.oma03
       #   #IF l_occ37='Y' THEN LET g_npq.npq14=l_occ02 CLIPPED  END IF   #MOD-730062
       #   IF l_occ37='Y' THEN LET g_npq.npq37=l_occ02 CLIPPED  END IF   #MOD-730062
       #END IF
       #-----END MOD-750132-----
       #End
       MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
       IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      #NO.FUN-5C0015 --start--
      #CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','') #No.FUN-740009
       CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
       RETURNING  g_npq.*
      #NO.FUN-5C0015 ---end---
       #-----MOD-750132---------
     # IF l_aag371 MATCHES '[23]' THEN              #FUN-A50053 mark
       IF l_aag371 MATCHES '[234]' THEN             #FUN-A50053 add
          #-->for 合併報表-關係人
       #No.FUN-9C0014 BEGIN -----
       #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
       #   WHERE occ01=g_oma.oma03
          IF cl_null(l_dbs) THEN
             SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
              WHERE occ01=g_oma.oma03
          ELSE
             #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
             LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                         " WHERE occ01='",g_oma.oma03,"'"
             CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
             CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
             PREPARE sel1_occ_pre15 FROM g_sql
             EXECUTE sel1_occ_pre15 INTO l_occ02,l_occ37
          END IF
       #No.FUN-9C0014 END -------
          IF cl_null(g_npq.npq37) THEN
             IF l_occ37='Y' THEN
#               LET g_npq.npq37=l_occ02 CLIPPED  #No.CHI-830037
                LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
             END IF
          END IF
       END IF
       #-----END MOD-750132-----
       IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
          IF g_type = '1' THEN
             CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                            g_npq25,g_npp.npp02)
             RETURNING g_npq.npq25
             LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
          ELSE
             LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
          END IF
#No.FUN-9A0036 --End
          #No.FUN-A30077  --Begin
          CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                      g_npq.npq07,g_npq.npq07f)
               RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
          #No.FUN-A30077  --End
       LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
       INSERT INTO npq_file VALUES (g_npq.*)
       IF STATUS THEN
#          CALL cl_err('ins npq#3',STATUS,1)      #No.FUN-660116
#No.FUN-710050--begin
           IF g_bgerr THEN
              LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
              CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#3',SQLCA.SQLCODE,1)
           ELSE
              CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,STATUS,"","ins npq#3",1)   #No.FUN-660116
           END IF
#No.FUN-710050--end
          LET g_success='N'
       END IF
       END IF   #MOD-820056
END FUNCTION
#FUN-B10058 --by elva end

#FUN-680001...............begin
FUNCTION s_t300_gl_set_npq05(p_dept,p_omb930)
DEFINE l_aag15      LIKE aag_file.aag15
DEFINE p_dept   LIKE gem_file.gem01,
       p_omb930 LIKE omb_file.omb930

   IF g_aaz.aaz90='Y' THEN
      RETURN p_omb930
   ELSE
      RETURN p_dept
   END IF
END FUNCTION
#FUN-680001...............end

#FUN-960141 add
#FUNCTION s_t300_gl_15()        #FUN-9C0109
FUNCTION s_t300_gl_15(p_cmd)   #FUN-9C0109
   DEFINE l_omb33               LIKE omb_file.omb33
   DEFINE l_omb930              LIKE omb_file.omb930
   DEFINE l_omb40               LIKE omb_file.omb40
   DEFINE l_azf14               LIKE azf_file.azf14
   DEFINE l_omb14,l_omb16       LIKE omb_file.omb14
   DEFINE l_cnt                 LIKE type_file.num5
   DEFINE l_n                   LIKE type_file.num5
   DEFINE l_sql                 LIKE type_file.chr1000
   DEFINE l_omb03               LIKE omb_file.omb03
   DEFINE l_omb31               LIKE omb_file.omb31
   DEFINE l_oga07               LIKE oga_file.oga07
   DEFINE l_omb14_2             LIKE omb_file.omb14
   DEFINE l_omb16_2             LIKE omb_file.omb16
   DEFINE s_omb14               LIKE omb_file.omb14
   DEFINE s_omb16               LIKE omb_file.omb16
   DEFINE l_omb41               LIKE omb_file.omb41,   #專案　
          l_omb42               LIKE omb_file.omb42    #WBS
   DEFINE l_oma54               LIKE oma_file.oma54
   DEFINE l_oma56               LIKE oma_file.oma56
   DEFINE l_oga24               LIKE oga_file.oga24
   DEFINE l_diff                LIKE oga_file.oga24
   DEFINE l_npq07_d             LIKE npq_file.npq07
   DEFINE l_npq07_c             LIKE npq_file.npq07
   DEFINE l_aag21               LIKE aag_file.aag21
   DEFINE p_cmd                 LIKE type_file.num5   #FUN-9C0109
   DEFINE l_aaa03   LIKE aaa_file.aaa03 #FUN-A40067
   DEFINE l_azi04_2 LIKE azi_file.azi04 #FUN-A40067
   DEFINE l_aag15      LIKE aag_file.aag15
#FUN-A40067 --Begin
   SELECT aaa03 INTO l_aaa03 FROM aaa_file
    WHERE aaa01 = g_bookno2
   SELECT azi04 INTO l_azi04_2 FROM azi_file
    WHERE azi01 = l_aaa03
#FUN-A40067 --End

   LET g_npp.nppsys = 'AR'
   LET g_npp.npplegal = g_legal    #FUN-980011 add
   LET g_npp.npp00 = 2
   LET g_npp.npp01 = g_oma.oma01
   LET g_npp.npp011 =  1
   LET g_npp.npp02 = g_oma.oma02
   LET g_npp.npp03 = NULL
   LET g_npp.npptype = g_type
   INSERT INTO npp_file VALUES(g_npp.*)
   IF STATUS OR SQLCA.SQLCODE THEN
      IF g_bgerr THEN
         LET g_showmsg=g_npp.npp01,"/",g_npp.npp011,"/",g_npp.nppsys,"/",g_npp.npp00
         CALL s_errmsg('npp01,npp011,nppsys,npp00',g_showmsg,'ins npp',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("ins","npp_file",g_npp.nppsys,g_npp.npp01,SQLCA.sqlcode,"","ins npp",1)   #No.FUN-660116
      END IF
      LET g_success='N'
   END IF

   LET g_npq.npqsys = 'AR'
   LET g_npq.npqlegal = g_legal    #FUN-980011 add
   LET g_npq.npq00 = 2
   LET g_npq.npq01 = g_oma.oma01
   LET g_npq.npq011 =  1
   LET g_npq.npq02 = 0
   LET g_npq.npqtype = g_type
   LET g_npq.npq04 = NULL        LET g_npq.npq05 = g_oma.oma15
   LET g_npq.npq21 = g_oma.oma03 LET g_npq.npq22 = g_oma.oma032
   LET g_npq.npq24 = g_oma.oma23 LET g_npq.npq25 = g_oma.oma24
   LET g_npq25 = g_npq.npq25   #FUN-9A0036
      #----------------------------------- (Dr:應收) --------
      LET g_npq.npq02 = g_npq.npq02 + 1
      LET g_npq.npq04 = NULL   #MOD-780052
      IF g_type = '0' THEN
         LET g_npq.npq03 = g_oma.oma18
      ELSE
         LET g_npq.npq03 = g_oma.oma181
      END IF
      LET g_aag05 = NULL
      LET g_aag23 = NULL
      SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
       WHERE aag01 = g_npq.npq03
         AND aag00 = g_bookno3
      IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
         LET g_npq.npq05 = ' '
      ELSE
         IF g_aag05='Y' THEN
            LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
         END IF
      END IF
      LET g_npq.npq06 = '1'
      LET g_npq.npq07f= g_oma.oma54t
      LET g_npq.npq07 = g_oma.oma56t
      IF g_aag23 = 'Y' THEN
         LET g_npq.npq08 = g_oma.oma63
      ELSE
         LET g_npq.npq08 = null
      END IF
      LET g_npq.npq23 = g_oma.oma01
      LET l_aag371=' '
      LET g_npq.npq37=''
      SELECT aag371 INTO l_aag371 FROM aag_file
       WHERE aag01=g_npq.npq03
         AND aag00 = g_bookno3
      MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
      IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
      CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
      RETURNING  g_npq.*
    # IF l_aag371 MATCHES '[23]' THEN         #FUN-A50053 mark
      IF l_aag371 MATCHES '[234]' THEN        #FUN-A50053 add
         #-->for 合併報表-關係人
      #No.FUN-9C0014 BEGIN -----
      #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
      #   WHERE occ01=g_oma.oma03
         IF cl_null(l_dbs) THEN
            SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
          WHERE occ01=g_oma.oma03
         ELSE
            #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
            LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                        " WHERE occ01='",g_oma.oma03,"'"
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
            PREPARE sel_occ_pre16 FROM g_sql
            EXECUTE sel_occ_pre16 INTO l_occ02,l_occ37
         END IF
      #No.FUN-9C0014 END -------
         IF cl_null(g_npq.npq37) THEN
            IF l_occ37='Y' THEN
               LET g_npq.npq37=g_oma.oma03 CLIPPED
            END IF
         END IF
      END IF
      IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
         IF g_type = '1' THEN
            CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                           g_npq25,g_npp.npp02)
            RETURNING g_npq.npq25
            LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#           LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
         ELSE
            LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
         END IF
#No.FUN-9A0036 --End
         #No.FUN-A30077  --Begin
         CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                     g_npq.npq07,g_npq.npq07f)
              RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
         #No.FUN-A30077  --End
         LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES (g_npq.*)
         IF STATUS OR SQLCA.SQLCODE THEN
            IF g_bgerr THEN
               LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#3',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#3",1)   #No.FUN-660116
            END IF
            LET g_success='N'
         END IF
      END IF
      #----------------------------------- (Cr:銷貨收入) ----
      IF g_type = '0' THEN
         LET l_sql = "SELECT omb33,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
                     "  FROM omb_file",
                     " WHERE omb01='",g_oma.oma01,"'",
                     "   AND omb33 IS NOT NULL",
                     "   AND omb13 <> 0 ",   #No.MOD-840523
                     "  GROUP BY omb33,omb40,omb41,omb42,omb930"   #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
      ELSE
         LET l_sql = "SELECT omb331,omb40,omb41,omb42,SUM(omb14),SUM(omb16),omb930", #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
                     "  FROM omb_file",
                     " WHERE omb01='",g_oma.oma01,"'",
                     "   AND omb331 IS NOT NULL",
                     "   AND omb13 <> 0 ",   #No.MOD-840523
                     "  GROUP BY omb331,omb40,omb41,omb42,omb930"   #FUN-810045 add omb40/41/42  #MOD-8C0161 add omb930
      END IF
      PREPARE s_t300_gl_p5 FROM l_sql
      DECLARE s_t300_gl_c5 CURSOR FOR s_t300_gl_p5
      FOREACH s_t300_gl_c5 INTO l_omb33,l_omb40,l_omb41,l_omb42,l_omb14,l_omb16,l_omb930  #FUN-810045 add omb40/41/42  #MOD-8C0161 add l_omb930
         IF STATUS THEN EXIT FOREACH END IF
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL
         LET g_npq.npq03 = l_omb33
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            LET g_npq.npq05 = g_oma.oma15
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,l_omb930)       #MOD-8C0161
            END IF
         END IF
         LET g_npq.npq06 = '2'
         LET g_npq.npq07f = l_omb14
         LET g_npq.npq07 = l_omb16
         LET g_npq.npq23 = g_oma.oma01
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
      # IF l_aag371 MATCHES '[23]' THEN      #FUN-950053 mark
        IF l_aag371 MATCHES '[234]' THEN     #FUN-950053
           #-->for 合併報表-關係人
        #No.FUN-9C0014 BEGIN -----
        #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
        #   WHERE occ01=g_oma.oma03
           IF cl_null(l_dbs) THEN
              SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
               WHERE occ01=g_oma.oma03
           ELSE
              #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
              LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                          " WHERE occ01='",g_oma.oma03,"'"
              CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
              CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
              PREPARE sel_occ_pre17 FROM g_sql
              EXECUTE sel_occ_pre17 INTO l_occ02,l_occ37
           END IF
        #No.FUN-9C0014 END -------
           IF cl_null(g_npq.npq37) THEN
              IF l_occ37='Y' THEN
                 LET g_npq.npq37=g_oma.oma03 CLIPPED   #No.CHI-830037
              END IF
           END IF
        END IF
        IF g_aag23 = 'Y' THEN     #MOD-A20056 add
           LET g_npq.npq08 = l_omb41  #專案
           LET g_npq.npq35 = l_omb42  #WBS
       #MOD-A20056---add---start---
        ELSE
           LET g_npq.npq08 = null
           LET g_npq.npq35 = null
        END IF
       #MOD-A20056---add---end---
          SELECT aag21 INTO l_aag21 FROM aag_file
           WHERE aag00 = g_bookno3
             AND aag01 = g_npq.npq03
          IF l_aag21 = 'Y' THEN                         #MOD-950096
              LET g_npq.npq36 = l_omb40  #費用原因
          END IF                                        #MOD-950096
         IF g_npq.npq07 <> 0 THEN
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#4',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#4",1)   #No.FUN-660116
               END IF
               LET g_success='N'
            END IF
         END IF
         LET g_oma.oma54=g_oma.oma54-l_omb14
         LET g_oma.oma56=g_oma.oma56-l_omb16
      END FOREACH

      IF g_oma.oma56 > 0 THEN
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL
         IF g_npq.npqtype = '0' THEN
            #FUN-9C0109--add--str--
            IF p_cmd = '15' OR p_cmd = '18' THEN
               LET g_npq.npq03 = g_ool.ool21
            ELSE
            #FUN-9C0109--add--end
               LET g_npq.npq03 = g_ool.ool41
            END IF   #FUN-9C0109
         ELSE
            #FUN-9C0109--add--str--
            IF p_cmd = '15' OR p_cmd = '18' THEN
               LET g_npq.npq03 = g_ool.ool211
            ELSE
            #FUN-9C0109--add--end
               LET g_npq.npq03 = g_ool.ool411
            END IF   #FUN-9C0109
         END IF
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
         END IF
         LET g_npq.npq06 = '2'
         LET g_npq.npq07f= g_oma.oma54
         LET g_npq.npq07 = g_oma.oma56
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         LET g_npq.npq23 = g_oma.oma01
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
       # IF l_aag371 MATCHES '[23]' THEN         #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN        #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre18 FROM g_sql
               EXECUTE sel_occ_pre18 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
                  LET g_npq.npq37=g_oma.oma03 CLIPPED
               END IF
            END IF
         END IF
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#5',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#5",1)   #No.FUN-660116
               END IF
               LET g_success='N'
            END IF
         END IF
      END IF
      #----------------------------------- (Cr:稅) ----------
      IF g_oma.oma54x > 0 THEN
         LET g_npq.npq02 = g_npq.npq02 + 1
         LET g_npq.npq04 = NULL
         IF g_npq.npqtype = '0' THEN
            LET g_npq.npq03 = g_ool.ool28
         ELSE
            LET g_npq.npq03 = g_ool.ool281
         END IF
         LET g_aag05 = NULL
         LET g_aag23 = NULL
         SELECT aag05,aag23 INTO g_aag05,g_aag23 FROM aag_file
          WHERE aag01 = g_npq.npq03
            AND aag00 = g_bookno3
         IF NOT cl_null(g_aag05) AND g_aag05 = 'N' THEN
            LET g_npq.npq05 = ' '
         ELSE
            IF g_aag05='Y' THEN
               LET g_npq.npq05=s_t300_gl_set_npq05(g_oma.oma15,g_oma.oma930)
            END IF
         END IF
         LET g_npq.npq06 = '2'
         LET g_npq.npq07f= g_oma.oma54x
         LET g_npq.npq07 = g_oma.oma56x
         IF g_aag23 = 'Y' THEN
            LET g_npq.npq08 = g_oma.oma63    # 專案
         ELSE
            LET g_npq.npq08 = null
         END IF
         LET g_npq.npq23 = g_oma.oma01
         LET l_aag371=' '
         LET g_npq.npq37=''
         SELECT aag371 INTO l_aag371 FROM aag_file
          WHERE aag01=g_npq.npq03
            AND aag00 = g_bookno3
         MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
         IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
         CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3) #No.FUN-740009
         RETURNING  g_npq.*
       # IF l_aag371 MATCHES '[23]' THEN            #FUN-950053 mark
         IF l_aag371 MATCHES '[234]' THEN           #FUN-950053 add
            #-->for 合併報表-關係人
         #No.FUN-9C0014 BEGIN -----
         #  SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
         #   WHERE occ01=g_oma.oma03
            IF cl_null(l_dbs) THEN
               SELECT occ02,occ37 INTO l_occ02,l_occ37 FROM occ_file
                WHERE occ01=g_oma.oma03
            ELSE
               #LET g_sql = "SELECT occ02,occ37 FROM ",l_dbs CLIPPED,"occ_file",
               LET g_sql = "SELECT occ02,occ37 FROM ",cl_get_target_table(g_plant_new,'occ_file'), #FUN-A50102
                           " WHERE occ01='",g_oma.oma03,"'"
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
               PREPARE sel_occ_pre19 FROM g_sql
               EXECUTE sel_occ_pre19 INTO l_occ02,l_occ37
            END IF
         #No.FUN-9C0014 END -------
            IF cl_null(g_npq.npq37) THEN
               IF l_occ37='Y' THEN
                  LET g_npq.npq37=g_oma.oma03 CLIPPED
               END IF
            END IF
         END IF
         IF g_npq.npq07 <> 0 THEN   #MOD-820056
#No.FUN-9A0036 --Begin
            IF g_type = '1' THEN
               CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                              g_npq25,g_npp.npp02)
               RETURNING g_npq.npq25
               LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
#              LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)#FUN-A40067
            ELSE
               LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)  #FUN-A40067
            END IF
#No.FUN-9A0036 --End
            #No.FUN-A30077  --Begin
            CALL s_t300_entry_direction(g_bookno3,g_npq.npq03,g_npq.npq06,
                                        g_npq.npq07,g_npq.npq07f)
                 RETURNING g_npq.npq06,g_npq.npq07,g_npq.npq07f
            #No.FUN-A30077  --End
            LET g_npq.npq30 = g_oma.oma66   #FUN-A60056
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
            INSERT INTO npq_file VALUES (g_npq.*)
            IF STATUS OR SQLCA.SQLCODE THEN
               IF g_bgerr THEN
                  LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                  CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#6',SQLCA.SQLCODE,1)
               ELSE
                  CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#6",1)   #No.FUN-660116
               END IF
               LET g_success='N'
            END IF
         END IF
      END IF
END FUNCTION
#FUN-960141 end

#No.FUN-A30077  --Begin
FUNCTION s_t300_entry_direction(p_bookno,p_npq03,p_npq06,p_npq07,p_npq07f)
   DEFINE p_bookno  LIKE aag_file.aag00
   DEFINE p_npq03   LIKE npq_file.npq03
   DEFINE p_npq06   LIKE npq_file.npq06
   DEFINE p_npq07   LIKE npq_file.npq07
   DEFINE p_npq07f  LIKE npq_file.npq07f
   DEFINE l_aag06   LIKE aag_file.aag06
   DEFINE l_aag42   LIKE aag_file.aag42
   DEFINE l_aag15      LIKE aag_file.aag15

   IF cl_null(p_npq03) THEN
      RETURN p_npq06,p_npq07,p_npq07f
   END IF
   IF cl_null(p_npq06) OR p_npq06 NOT MATCHES '[12]' THEN
      RETURN p_npq06,p_npq07,p_npq07f
   END IF

   IF cl_null(p_npq07)  THEN LET p_npq07  = 0 END IF
   IF cl_null(p_npq07f) THEN LET p_npq07f = 0 END IF
   IF p_npq07 = 0 AND p_npq07f = 0 THEN
      RETURN p_npq06,p_npq07,p_npq07f
   END IF

   SELECT aag06,aag42 INTO l_aag06,l_aag42
     FROM aag_file
    WHERE aag00 = p_bookno
      AND aag01 = p_npq03
   IF cl_null(l_aag42) OR l_aag42 = 'N' THEN
      RETURN p_npq06,p_npq07,p_npq07f
   END IF
   IF l_aag06 = '1' AND p_npq06 = '1' OR
      l_aag06 = '2' AND p_npq06 = '2' THEN
      RETURN p_npq06,p_npq07,p_npq07f
   END IF
   IF p_npq06 = '1' THEN
      LET p_npq06 = '2'
   ELSE
      LET p_npq06 = '1'
   END IF
   LET p_npq07 = p_npq07 * -1
   LET p_npq07f= p_npq07f* -1

   RETURN p_npq06,p_npq07,p_npq07f
END FUNCTION
#No.FUN-A30077  --End
#FUN-A40033 --Begin
FUNCTION s_t300_gen_diff()
DEFINE l_aaa   RECORD LIKE aaa_file.*
DEFINE l_npq1           RECORD LIKE npq_file.*
DEFINE l_sum_cr         LIKE npq_file.npq07
DEFINE l_sum_dr         LIKE npq_file.npq07
DEFINE l_aag15      LIKE aag_file.aag15
   IF g_npp.npptype = '1' THEN
      CALL s_get_bookno(YEAR(g_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
      IF g_flag =  '1' THEN
         CALL cl_err(g_oma.oma02,'aoo-081',1)
         RETURN
      END IF
      LET g_bookno3 = g_bookno2
      SELECT * INTO l_aaa.* FROM aaa_file WHERE aaa01 = g_bookno3
      LET l_sum_cr = 0
      LET l_sum_dr = 0
      SELECT SUM(npq07) INTO l_sum_dr
        FROM npq_file
       WHERE npqtype = '1'
         AND npq00 = g_npp.npp00
         AND npq01 = g_npp.npp01
         AND npq011= g_npp.npp011
         AND npqsys= g_npp.nppsys
         AND npq06 = '1'
      SELECT SUM(npq07) INTO l_sum_cr
        FROM npq_file
       WHERE npqtype = '1'
         AND npq00 = g_npp.npp00
         AND npq01 = g_npp.npp01
         AND npq011= g_npp.npp011
         AND npqsys= g_npp.nppsys
         AND npq06 = '2'
      IF l_sum_dr <> l_sum_cr THEN
         SELECT MAX(npq02)+1 INTO l_npq1.npq02
           FROM npq_file
          WHERE npqtype = '1'
            AND npq00 = g_npp.npp00
            AND npq01 = g_npp.npp01
            AND npq011= g_npp.npp011
            AND npqsys= g_npp.nppsys
         LET l_npq1.npqtype = g_npp.npptype
         LET l_npq1.npq00 = g_npp.npp00
         LET l_npq1.npq01 = g_npp.npp01
         LET l_npq1.npq011= g_npp.npp011
         LET l_npq1.npqsys= g_npp.nppsys
         LET l_npq1.npq07 = l_sum_dr-l_sum_cr
         LET l_npq1.npq24 = l_aaa.aaa03
         LET l_npq1.npq25 = 1
         IF l_npq1.npq07 < 0 THEN
            LET l_npq1.npq03 = l_aaa.aaa11
            LET l_npq1.npq07 = l_npq1.npq07 * -1
            LET l_npq1.npq06 = '1'
         ELSE
            LET l_npq1.npq03 = l_aaa.aaa12
            LET l_npq1.npq06 = '2'
         END IF
         LET l_npq1.npq07f = l_npq1.npq07
         LET l_npq1.npqlegal=g_legal
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = l_npq1.npq03
      IF NOT cl_null(l_aag15) THEN
         LET l_npq1.npq11 = l_npq1.npq21
      END IF
      #add by zhangym 120522 end-----
         INSERT INTO npq_file VALUES(l_npq1.*)
         IF STATUS OR SQLCA.SQLCODE THEN
            IF g_bgerr THEN
               LET g_showmsg=l_npq1.npq01,"/",l_npq1.npq011,"/",l_npq1.npqsys,"/",l_npq1.npq00
               CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#1',SQLCA.SQLCODE,1)
            ELSE
               CALL cl_err3("ins","npq_file",l_npq1.npq01,l_npq1.npq02,SQLCA.sqlcode,"","ins npq#1",1)
            END IF
            LET g_success='N'
         END IF
      END IF
   END IF
END FUNCTION
#FUN-A60007 --End
FUNCTION s_t300_deferred(p_type)
#DEFINE p_type       LIKE type_file.chr1     #MOD-A90028 mark
DEFINE p_type       LIKE omb_file.omb33      #MOD-A90028
DEFINE l_omb        RECORD LIKE omb_file.*
DEFINE l_oma        RECORD LIKE oma_file.*
DEFINE l_ocs_cnt    LIKE type_file.num10
DEFINE l_tot_oct12  LIKE oct_file.oct12
DEFINE l_oct12      LIKE oct_file.oct12
DEFINE l_tot_oct12f LIKE oct_file.oct12
DEFINE l_oct12f     LIKE oct_file.oct12
DEFINE l_aag15      LIKE aag_file.aag15

    LET l_tot_oct12 = 0
    LET l_tot_oct12f = 0
    LET l_oct12 = 0
    LET l_oct12f= 0

   #-MOD-A90028-add-
    IF NOT cl_null(p_type) THEN
       LET g_sql = "SELECT * FROM oma_file,omb_file ",
                   " WHERE oma01 = omb01 ",
                   "   AND oma01 = '",g_oma.oma01,"'",
                   "   AND oma00 = '",g_oma.oma00,"'",   #12.出貨 21.折讓
                   "   AND omb33 = '",p_type,"'"
    ELSE
       LET g_sql = "SELECT * FROM oma_file,omb_file ",
                   " WHERE oma01 = omb01 ",
                   "   AND oma01 = '",g_oma.oma01,"'",
                   "   AND oma00 = '",g_oma.oma00,"'"    #12.出貨 21.折讓
    END IF
   #-MOD-A90028-end-
    PREPARE s_t300_def_pre1 FROM g_sql
    DECLARE s_t300_def_cs1 CURSOR WITH HOLD FOR s_t300_def_pre1
    LET l_tot_oct12 = 0
    LET l_tot_oct12f = 0
    FOREACH s_t300_def_cs1 INTO l_oma.*,l_omb.*
        CALL s_t300_chk_ocs(l_oma.*,l_omb.*) RETURNING l_ocs_cnt #檢查是否有設定售貨基本資料
        LET g_sql = ''                    #MOD-B10210
        IF l_ocs_cnt > 0 THEN
            CALL s_t300_def_ocs(l_oma.*,l_omb.*) RETURNING l_oct12,l_oct12f #取axmi110設定值
        END IF
        LET l_tot_oct12 = l_tot_oct12 + l_oct12
        LET l_tot_oct12f = l_tot_oct12f + l_oct12f
     END FOREACH
     RETURN l_tot_oct12,l_tot_oct12f
END FUNCTION

FUNCTION s_t300_chk_ocs(l_oma,l_omb)
DEFINE l_omb RECORD LIKE omb_file.*
DEFINE l_oma RECORD LIKE oma_file.*
DEFINE l_ocs_cnt  LIKE type_file.num10
DEFINE l_aag15      LIKE aag_file.aag15

    LET l_ocs_cnt = 0
    #判斷此料件是否已經建立售貨動作資料
    LET g_sql="SELECT COUNT(*) FROM ocs_file",
              " WHERE ocs012='",l_omb.omb04,"'",   #料號
              "   AND ocs011='",l_oma.oma03,"'",   #客戶編號
              "   AND (ocs01 IS NULL OR ocs01 = ' ')"
    PREPARE s_t300_gl_ocs_pre1 FROM g_sql
    DECLARE s_t300_gl_ocs_cs1 CURSOR FOR s_t300_gl_ocs_pre1
    OPEN s_t300_gl_ocs_cs1
    FETCH s_t300_gl_ocs_cs1 INTO g_cnt1
    LET l_ocs_cnt = g_cnt1
    CLOSE s_t300_gl_ocs_cs1
    IF g_cnt1 = 0 THEN
       #1.客戶編號+料號>2.客戶編號+產品類別>3.料號>4.產品編號
       LET g_sql="SELECT COUNT(*) FROM ocs_file,ima_file ",
                " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",  #產品類別
                "   AND ocs011='",l_oma.oma03,"'",                   #客戶編號
               #"   AND (ocs012 IS NULL OR ocs12 = ' ')"             #料號     #MOD-AC0033 mark
                "   AND (ocs012 IS NULL OR ocs012 = ' ')"            #料號     #MOD-AC0033
       PREPARE s_t300_gl_ocs_pre4 FROM g_sql
       DECLARE s_t300_gl_ocs_cs4 CURSOR FOR s_t300_gl_ocs_pre4
       OPEN s_t300_gl_ocs_cs4
       FETCH s_t300_gl_ocs_cs4 INTO g_cnt4
       LET l_ocs_cnt = g_cnt4
       CLOSE s_t300_gl_ocs_cs4
       IF g_cnt4 = 0 THEN
          LET g_sql="SELECT COUNT(*) FROM ocs_file",
                    " WHERE ocs012='",l_omb.omb04,"'",  #料號
                    "   AND (ocs011 IS NULL OR ocs011=' ')",
                    "   AND (ocs01 IS NULL OR ocs01 = ' ')"
          PREPARE s_t300_gl_ocs_pre2 FROM g_sql
          DECLARE s_t300_gl_ocs_cs2 CURSOR FOR s_t300_gl_ocs_pre2
          OPEN s_t300_gl_ocs_cs2
          FETCH s_t300_gl_ocs_cs2 INTO g_cnt2
          LET l_ocs_cnt = g_cnt2
          CLOSE s_t300_gl_ocs_cs2
          IF g_cnt2 = 0 THEN   #依產品類別
             LET g_sql="SELECT COUNT(*) FROM ocs_file,ima_file ",
                    " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",
                    "   AND (ocs011 IS NULL OR ocs011=  ' ')",
                    "   AND (ocs012 IS NULL OR ocs012 = ' ')"
             PREPARE s_t300_gl_ocs_pre3 FROM g_sql
             DECLARE s_t300_gl_ocs_cs3 CURSOR FOR s_t300_gl_ocs_pre3
             OPEN s_t300_gl_ocs_cs3
             FETCH s_t300_gl_ocs_cs3 INTO g_cnt3
             LET l_ocs_cnt = g_cnt3
             CLOSE s_t300_gl_ocs_cs3
            #FUN-B70059--begin--
             IF g_cnt3 = 0 THEN   #依客戶
                LET g_sql="SELECT COUNT(*) FROM ocs_file",
                       " WHERE ocs011='",l_oma.oma03,"'",            #客戶編號
                       "   AND (ocs012 IS NULL OR ocs012 = ' ')" ,   #料號
                       "   AND (ocs01 IS NULL OR ocs01 = ' ')"       #產品分類碼
                PREPARE s_t300_gl_ocs_pre5 FROM g_sql
                DECLARE s_t300_gl_ocs_cs5 CURSOR FOR s_t300_gl_ocs_pre5
                OPEN s_t300_gl_ocs_cs5
                FETCH s_t300_gl_ocs_cs5 INTO g_cnt5
                LET l_ocs_cnt = g_cnt5
                CLOSE s_t300_gl_ocs_cs5　       　
             END IF
            #FUN-B70059---end---
          END IF
       END IF
    END IF
    RETURN l_ocs_cnt
END FUNCTION

FUNCTION s_t300_def_ocs(l_oma,l_omb)
DEFINE l_omb RECORD LIKE omb_file.*
DEFINE l_oma RECORD LIKE oma_file.*
DEFINE l_def LIKE npq_file.npq07
DEFINE l_def_f LIKE npq_file.npq07f
DEFINE l_azi04_2 LIKE azi_file.azi04
DEFINE l_tot_oct12  LIKE oct_file.oct12
DEFINE l_tot_oct12f LIKE oct_file.oct12
DEFINE l_aaa03      LIKE aaa_file.aaa03
DEFINE l_aag15      LIKE aag_file.aag15

    SELECT aaa03 INTO l_aaa03 FROM aaa_file
     WHERE aaa01 = g_bookno2
    SELECT azi04 INTO l_azi04_2 FROM azi_file
     WHERE azi01 = l_aaa03
    LET l_tot_oct12 = 0
    LET l_tot_oct12f = 0
    #找出此料件所對應的售貨動作有哪些
    CASE
       WHEN g_cnt1 > 0
         LET g_sql="SELECT * FROM ocs_file",
                   " WHERE ocs012='",l_omb.omb04,"'",   #料號
                   "   AND ocs011='",l_oma.oma03,"'",   #客戶編號
                   "   AND (ocs01 IS NULL OR ocs01 = ' ')"
       WHEN g_cnt4 > 0
         LET g_sql="SELECT * FROM ocs_file,ima_file ",
                   " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",  #產品類別
                   "   AND ocs011='",l_oma.oma03,"'",                   #客戶編號
                   "   AND (ocs012 IS NULL OR ocs12 = ' ')"             #料號
       WHEN g_cnt2 > 0
         LET g_sql="SELECT * FROM ocs_file",
                   " WHERE ocs012='",l_omb.omb04,"'",   #料號
                   "   AND (ocs011 IS NULL OR ocs011=' ')",
                   "   AND (ocs01 IS NULL OR ocs01 = ' ')"
       WHEN g_cnt3 > 0
         LET g_sql="SELECT * FROM ocs_file,ima_file ",
                   " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",  #產品類別
                   "   AND ocs011=  ' ' and ocs012 = ' '"
      #FUN-B70059--begin--
       WHEN g_cnt5 > 0 #客戶
         LET g_sql="SELECT * FROM ocs_file",
                   " WHERE ocs011='",l_oma.oma03,"'",           #客戶編號
                   "   AND (ocs012 IS NULL OR ocs012 = ' ')",   #料號
                   "   AND (ocs01 IS NULL OR ocs01 = ' ')"
      #FUN-B70059---end---
    END CASE
    CALL cl_replace_sqldb(g_sql) RETURNING g_sql
    PREPARE s_t300_gl_pre1 FROM g_sql
    DECLARE s_t300_gl_cs1 CURSOR WITH HOLD FOR s_t300_gl_pre1

    INITIALIZE g_ocs.* TO NULL
    LET l_def = 0
    LET l_def_f = 0
    FOREACH s_t300_gl_cs1 INTO g_ocs.*
        IF SQLCA.sqlcode THEN
           CALL s_errmsg('','','s_t300_gl_cs1:',STATUS,1)
           LET g_success = 'N'
        END IF
        CALL s_t300_def_cnt(l_oma.*,l_omb.*)
        RETURNING l_def,l_def_f #計算每一個AR單身料件遞延收入(本幣未稅)/(原幣未稅)

#FUN-AB0110 --Begin mark
#       IF l_oma.oma00 MATCHES '2*' THEN
#           IF l_def < 0 THEN
#               LET l_def  = l_def * (-1)
#           END IF
#           IF l_def_f < 0 THEN
#               LET l_def_f = l_def_f * (-1)
#           END IF
#       END IF
#FUN-AB0110 --End mark
#FUN-AB0110 --Begin
        IF l_oma.oma00 MATCHES '2*' THEN  #折讓類應收不于分錄中直接拆遞延收入科目
            IF (l_def > 0 OR l_def_f > 0)  THEN
               LET l_tot_oct12 = l_tot_oct12 + l_def
               LET l_tot_oct12f = l_tot_oct12f + l_def_f
            END IF
        ELSE
#FUN-AB0110 --End

           IF (l_def > 0 OR l_def_f > 0)  THEN  #如果有計算出遞延收入,則必需切立分錄
              LET g_npq.npq02 = g_npq.npq02 + 1
              LET g_npq.npq04 = NULL
              IF g_type = '0' THEN
                 LET g_npq.npq03 = g_ocs.ocs03  #科目取axmi1101設定
              ELSE
                 LET g_npq.npq03 = g_ocs.ocs031
              END IF
              LET g_aag05 = NULL
              LET g_aag23 = NULL
              LET g_npq.npq05 = ' '
              IF l_oma.oma00 = '12' THEN
                  LET g_npq.npq06 = '2'
              ELSE
                  LET g_npq.npq06 = '1'
              END IF
              LET g_npq.npq07f= l_def_f
              LET g_npq.npq07 = l_def
              LET g_npq.npq08 = null
              LET g_npq.npq23 = l_oma.oma01
              LET l_aag371=' '
              LET g_npq.npq37=''
              SELECT aag371 INTO l_aag371 FROM aag_file
               WHERE aag01=g_npq.npq03
                 AND aag00 = g_bookno3
              MESSAGE '>',g_npq.npq02,' ',g_npq.npq03
              IF cl_null(g_npq.npq03) THEN LET g_npq.npq03='-' END IF
              CALL s_def_npq(g_npq.npq03,g_prog,g_npq.*,g_npq.npq01,'','',g_bookno3)
              RETURNING  g_npq.*
              LET g_npq.npq27 = g_ocs.ocs05
              LET g_npq.npq28 = g_ocs.ocs02
              LET g_npq.npq29 = l_omb.omb03
              IF g_npq.npq07 <> 0 THEN
                 IF g_type = '1' THEN
                    CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,g_npq25,g_npp.npp02)
                    RETURNING g_npq.npq25
                    LET g_npq.npq07 = g_npq.npq07f * g_npq.npq25
                    LET g_npq.npq07 = cl_digcut(g_npq.npq07,l_azi04_2)
                 ELSE
                    LET g_npq.npq07 = cl_digcut(g_npq.npq07,g_azi04)
                 END IF
              END IF
      #add by zhangym 120522 begin-----
      SELECT aag15 INTO l_aag15 FROM aag_file
       WHERE aag00 = g_bookno3
         AND aag01 = g_npq.npq03
      IF NOT cl_null(l_aag15) THEN
         LET g_npq.npq11 = g_npq.npq21
      END IF
      #add by zhangym 120522 end-----
              INSERT INTO npq_file VALUES (g_npq.*)
              IF STATUS OR SQLCA.SQLCODE THEN
                 IF g_bgerr THEN
                    LET g_showmsg=g_npq.npq01,"/",g_npq.npq011,"/",g_npq.npqsys,"/",g_npq.npq00
                    CALL s_errmsg('npq01,npq011,npqsys,npq00',g_showmsg,'ins npq#6',SQLCA.SQLCODE,1)
                 ELSE
                    CALL cl_err3("ins","npq_file",g_npq.npq01,g_npq.npq02,SQLCA.sqlcode,"","ins npq#6",1)
                 END IF
                 LET g_success='N'
              ELSE
                 LET l_tot_oct12 = l_tot_oct12 + l_def
                 LET l_tot_oct12f = l_tot_oct12f + l_def_f
              END IF
           END IF
        END IF         #FUN-AB0110 add
     END FOREACH
     LET g_npq.npq27 = ''
     LET g_npq.npq28 = ''
     LET g_npq.npq29 = ''
     RETURN l_tot_oct12,l_tot_oct12f   #同一個料件可能有多種售貨動作,所以要把所有售貨動作計算出的遞延收入金額合計
END FUNCTION

FUNCTION s_t300_def_cnt(l_oma,l_omb)
DEFINE l_aag15      LIKE aag_file.aag15
DEFINE l_omb     RECORD LIKE omb_file.*
DEFINE l_oma     RECORD LIKE oma_file.*
DEFINE l_omb16   LIKE omb_file.omb16
DEFINE l_omb14   LIKE omb_file.omb14
DEFINE l_def     LIKE oct_file.oct12
DEFINE l_def_f   LIKE oct_file.oct12
DEFINE l_azi04_2 LIKE azi_file.azi04

    SELECT azi04 INTO l_azi04_2 FROM azi_file
     WHERE azi01 = l_aaa03

    LET l_def = 0
    LET l_def_f = 0
    LET g_sql="SELECT azi04 FROM azi_file ",
              " WHERE azi01='",l_oma.oma23,"' AND aziacti = 'Y' "
    PREPARE s_t300_gl_azi_pre FROM g_sql
    DECLARE s_t300_gl_azi_cs CURSOR FOR s_t300_gl_azi_pre
    OPEN s_t300_gl_azi_cs
    FETCH s_t300_gl_azi_cs INTO t_azi04
    IF STATUS THEN
       LET t_azi04 = 0
    END IF
    CLOSE s_t300_gl_azi_cs

    #依售貨動作不同,所設定的百分比及期數做遞延收入計算
    LET g_sql="SELECT SUM(omb16),SUM(omb14) ",
              "  FROM omb_file ",
              " WHERE omb01='",l_omb.omb01,"' ",
              "   AND omb03='",l_omb.omb03,"' "
    PREPARE s_t300_gl_omb_1_pre FROM g_sql
    DECLARE s_t300_gl_omb_1_cs CURSOR FOR s_t300_gl_omb_1_pre
    OPEN s_t300_gl_omb_1_cs
    FETCH s_t300_gl_omb_1_cs INTO l_omb16,l_omb14  #本幣未稅/原幣未稅
    CLOSE s_t300_gl_omb_1_cs

    IF g_type = '1' THEN
       CALL s_newrate(g_bookno1,g_bookno2,g_npq.npq24,
                      g_npq25,g_npp.npp02)
       RETURNING g_npq.npq25
       LET l_omb16 = l_omb14 * g_npq.npq25
       LET l_omb16 = cl_digcut(l_omb16,l_azi04_2)
    END IF

    IF l_omb16 <> 0 THEN
       IF l_oma.oma00 = '12' AND l_omb.omb38 = '2' THEN
           LET l_def= (l_omb16*g_ocs.ocs04)/100   #總遞延收入=銷貨金額*百分比
           LET l_def_f= (l_omb14*g_ocs.ocs04)/100
       ELSE
           LET l_def = ((l_omb16*-1)* g_ocs.ocs04)/100   #總遞延收入=銷貨金額*百分比
           LET l_def_f= ((l_omb14*-1)* g_ocs.ocs04)/100
       END IF
       LET l_def   = cl_digcut(l_def,g_azi04)
       LET l_def_f = cl_digcut(l_def_f,t_azi04)
    END IF
    RETURN l_def,l_def_f
END FUNCTION

#依應收單項次,比對分錄(npq01+ npq29)
#遞延收入科目,寫入oct_file
FUNCTION s_t300_ins_oct(p_oma01,p_oma00,p_type)
DEFINE l_aag15      LIKE aag_file.aag15
DEFINE p_oma01   LIKE oma_file.oma01
DEFINE p_oma00   LIKE oma_file.oma00
DEFINE l_oma     RECORD LIKE oma_file.*
DEFINE l_omb     RECORD LIKE omb_file.*
DEFINE p_type    LIKE type_file.chr1
DEFINE l_npq03   LIKE npq_file.npq03
DEFINE l_npq07   LIKE npq_file.npq07
DEFINE l_npq07f  LIKE npq_file.npq07f
DEFINE l_npq27   LIKE npq_file.npq27
DEFINE l_npq28   LIKE npq_file.npq28
DEFINE l_oma02   LIKE oma_file.oma02
DEFINE l_oct     RECORD LIKE oct_file.*
DEFINE l_def     LIKE npq_file.npq07     #FUN-AB0110
DEFINE l_def_f   LIKE npq_file.npq07f    #FUN-AB0110
DEFINE l_ocs_cnt LIKE type_file.num10    #FUN-AB0110
DEFINE l_aaa03   LIKE aaa_file.aaa03     #FUN-AB0110
DEFINE l_azi04_2 LIKE azi_file.azi04     #FUN-AB0110
DEFINE i         LIKE type_file.chr1     #FUN-AB0110

   #BEGIN WORK   #TQC-B10024 mark
    LET g_success = 'Y'
    LET g_sql = "SELECT * FROM oma_file,omb_file ",
                " WHERE oma01 = omb01 ",
                "   AND oma01 = '",p_oma01,"'",
                "   AND oma00 = '",p_oma00,"'"    #12.出貨21.折讓
    PREPARE s_t300_ins_oct_p1 FROM g_sql
    DECLARE s_t300_ins_oct_c1 CURSOR WITH HOLD FOR s_t300_ins_oct_p1
    FOREACH s_t300_ins_oct_c1 INTO l_oma.*,l_omb.*
        IF SQLCA.SQLCODE THEN
            CALL s_errmsg('oma01',p_oma01,'s_t300_ins_oct_c1',SQLCA.SQLCODE,1)
            LET g_success = 'N'
            EXIT FOREACH
        END IF

#FUN-AB0110 --Begin
        IF l_oma.oma00 MATCHES '2*' THEN  #折讓類應收不于分錄中直接拆遞延收入科目所以不能取npq資料
            CALL s_t300_chk_ocs(l_oma.*,l_omb.*) RETURNING l_ocs_cnt #檢查是否有設定售貨基本資料
            LET g_sql = ''                    #MOD-B10210
            IF l_ocs_cnt > 0 THEN             #MOD-B10210
               #找出此料件所對應的售貨動作有哪些
               CASE
                  WHEN g_cnt1 > 0
                    LET g_sql="SELECT * FROM ocs_file",
                              " WHERE ocs012='",l_omb.omb04,"'",   #料號
                              "   AND ocs011='",l_oma.oma03,"'",   #客戶編號
                              "   AND (ocs01 IS NULL OR ocs01 = ' ')"
                  WHEN g_cnt4 > 0
                    LET g_sql="SELECT * FROM ocs_file,ima_file ",
                              " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",        #產品類別
                              "   AND ocs011='",l_oma.oma03,"'",                         #客戶編號
                              "   AND (ocs012 IS NULL OR ocs12 = ' ')"                   #料號
                  WHEN g_cnt2 > 0
                    LET g_sql="SELECT * FROM ocs_file",
                              " WHERE ocs012='",l_omb.omb04,"'",   #料號
                              "   AND (ocs011 IS NULL OR ocs011=' ')",
                              "   AND (ocs01 IS NULL OR ocs01 = ' ')"
                  WHEN g_cnt3 > 0
                    LET g_sql="SELECT * FROM ocs_file,ima_file ",
                              " WHERE ima01='",l_omb.omb04,"' AND ima131=ocs01 ",        #產品類別
                              "   AND ocs011=  ' ' and ocs012 = ' '"
                 #FUN-B70059--begin--
                  WHEN g_cnt5 > 0 #客戶
                    LET g_sql="SELECT * FROMocs_file",
                              " WHERE ocs011='",l_oma.oma03,"'",           #客戶編號
                              "   AND (ocs012 IS NULL OR ocs012 = ' ')",   #料號
                              "   AND (ocs01 IS NULL OR ocs01 = ' ')"
                 #FUN-B70059---end---
               END CASE
               PREPARE s_t300_gl_pre2 FROM g_sql
               DECLARE s_t300_gl_cs2 CURSOR WITH HOLD FOR s_t300_gl_pre2

               INITIALIZE g_ocs.* TO NULL
               LET l_def = 0
               LET l_def_f = 0
               FOREACH s_t300_gl_cs2 INTO g_ocs.*   #同一顆料可能分多种售貨動作,寫入oct_file時一張AR會對應不同仿佛動作寫入
                   IF SQLCA.sqlcode THEN
                      CALL s_errmsg('','','s_t300_gl_cs2:',STATUS,1)
                      LET g_success = 'N'
                   END IF
                   CALL s_t300_def_cnt(l_oma.*,l_omb.*)
                   RETURNING l_def,l_def_f #計算每一個AR單身料件遞延收入(本幣未稅)/(原幣未稅)

                   IF l_oma.oma00 MATCHES '2*' THEN
                       IF l_def < 0 THEN
                           LET l_def  = l_def * (-1)
                       END IF
                       IF l_def_f < 0 THEN
                           LET l_def_f = l_def_f * (-1)
                       END IF
                   END IF
                   IF p_type = '0' THEN
                      LET l_npq03 = g_ocs.ocs03  #科目取axmi1101設定
                   ELSE
                      LET l_npq03 = g_ocs.ocs031
                   END IF
                   LET l_npq07f= l_def_f
                   LET l_npq07 = l_def     #總遞延收入本幣
                   LET l_npq27 = g_ocs.ocs05
                   LET l_npq28 = g_ocs.ocs02
                   IF l_npq07 <> 0 THEN
                      IF p_type = '1' THEN
                          CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
                          SELECT aaa03 INTO l_aaa03 FROM aaa_file
                           WHERE aaa01 = g_bookno2
                          SELECT azi04 INTO l_azi04_2 FROM azi_file
                           WHERE azi01 = l_aaa03
                         CALL s_newrate(g_bookno1,g_bookno2,l_oma.oma23,l_oma.oma24,l_oma.oma02)
                         RETURNING g_npq.npq25
                         LET l_npq07 = l_npq07f * g_npq.npq25
                         LET l_npq07 = cl_digcut(l_npq07,l_azi04_2)
                      ELSE
                         LET l_npq07 = cl_digcut(l_npq07,g_azi04)
                      END IF
                   END IF
                   CALL t300_ins_oct1(p_type,l_oma.*,l_omb.*,l_npq03,l_npq07,l_npq07f,l_npq27,l_npq28)  #FUN-AB0110
               END FOREACH
            END IF                            #MOD-B10210
        ELSE
#FUN-AB0110 --End
       #依帳款單身項次+單號SELECT 分錄中不同售貨動作遞延收入科目資料
       LET g_sql = "SELECT UNIQUE npq03,npq07,npq07f,npq27,npq28 FROM npp_file,npq_file",
                   " WHERE npp01 = npq01 ",
                   "   AND npp01 = '",l_oma.oma01,"'",
                   "   AND npp00 = 2 ",
                   "   AND nppsys = 'AR' ",
                   "   AND npp011 = 1  ",
                   "   AND npq29 = '",l_omb.omb03,"'" ,
                   "   AND npqtype = '",p_type,"'"
       PREPARE s_t300_npq_p1 FROM g_sql
       DECLARE s_t300_npq_c1 CURSOR WITH HOLD FOR s_t300_npq_p1
       FOREACH s_t300_npq_c1 INTO l_npq03,l_npq07,l_npq07f,l_npq27,l_npq28
           IF SQLCA.SQLCODE THEN
               CALL s_errmsg('oma01',p_oma01,'s_t300_npq_c1',SQLCA.SQLCODE,1)
               LET g_success = 'N'
               EXIT FOREACH
           END IF

           CALL t300_ins_oct1(p_type,l_oma.*,l_omb.*,l_npq03,l_npq07,l_npq07f,l_npq27,l_npq28) #FUN-AB0110
#FUN-AB0110 --Begin mark
#          LET l_oct.oct00 = p_type
#          LET l_oct.oct01 = l_omb.omb01    #AR NO.
#          LET l_oct.oct02 = l_omb.omb03    #項次
#          LET l_oct.oct03 = l_omb.omb04    #料號
#          IF l_oma.oma00 = '12' THEN
#             LET l_oct.oct04 = l_omb.omb31   #出貨單號
#             LET l_oct.oct05 = l_omb.omb32   #出貨項次
#             LET l_oct.oct06 = ''
#             LET l_oct.oct07 = ''
#          ELSE
#             LET g_sql="SELECT ohb31,ohb32 ", #出貨單號/項次
#                       "  FROM ohb_file ",
#                       " WHERE ohb01 = '",l_omb.omb31,"' ",    #銷退單號
#                       "   AND ohb03 = '",l_omb.omb32,"' "     #銷退項次
#             PREPARE s_t300_gl_ohb_1_pre FROM g_sql
#             DECLARE s_t300_gl_ohb_1_cs CURSOR FOR s_t300_gl_ohb_1_pre
#             OPEN s_t300_gl_ohb_1_cs
#             FETCH s_t300_gl_ohb_1_cs INTO l_oct.oct04,l_oct.oct05
#             CLOSE s_t300_gl_ohb_1_cs
#             LET l_oct.oct06 = l_omb.omb31
#             LET l_oct.oct07 = l_omb.omb32
#          END IF
#          LET l_oct.oct08 = ''

#          #依AR單據日期產生年度月份
#          LET g_sql="SELECT oma02 ",
#                    "  FROM oma_file,omb_file ",
#                    " WHERE omb01 = '",l_oct.oct01,"' ",
#                    "   AND omb03 = '",l_oct.oct02,"' ",
#                    "   AND oma01 = omb01  "
#          PREPARE s_t300_gl_oma_pre FROM g_sql
#          DECLARE s_t300_gl_oma_cs CURSOR FOR s_t300_gl_oma_pre
#          OPEN s_t300_gl_oma_cs
#          FETCH s_t300_gl_oma_cs INTO l_oma02
#          CLOSE s_t300_gl_oma_cs
#          LET l_oct.oct09 = YEAR(l_oma02)
#          LET l_oct.oct10 = MONTH(l_oma02)
#          LET l_oct.oct11 = l_npq28
#          LET l_oct.oct12 = 0
#          LET l_oct.oct12f = 0
#
#          LET l_oct.oct13 = l_npq03     #遞延收入科目一

#          LET l_oct.oct12  = l_npq07
#          LET l_oct.oct12f = l_npq07f

#          LET l_oct.oct14 = 0
#          LET l_oct.oct14f= 0
#          LET l_oct.oct15 = 0
#          LET l_oct.oct15f= 0
#          IF l_oma.oma00 = '12' AND l_omb.omb38 = '2' THEN
#             LET l_oct.oct16 = '1'   #總遞延收入
#          ELSE
#             LET l_oct.oct16 = '3'   #折讓
#          END IF
#          LET l_oct.oct17 = g_plant_new
#          LET l_oct.oct18 = l_oma.oma23
#          LET l_oct.oct19 = l_oma.oma58
#          LET l_oct.octlegal = l_oma.omalegal

#          INSERT INTO oct_file VALUES(l_oct.*)
#          IF SQLCA.SQLCODE THEN
#              CALL s_errmsg('oma01',l_oma.oma01,'INSERT INTO oct_file',SQLCA.SQLCODE,1)
#              LET g_success = 'N'
#             #ROLLBACK WORK   #TQC-B10024 mark
#          ELSE
#              CALL s_t300_defr_detail(l_oma.*,l_omb.*,l_oct.*,l_npq27,p_type)  #­pºâ¨C¤@´Á¨RÂà»¼©µ¦¬¤J¼g¤Joct_file
#          END IF
#FUN-AB0110 --End mark
       END FOREACH
      END IF    #FUN-AB0110
   END FOREACH
   #--FUN-AB0110 start-
   IF g_success ='Y' THEN
       LET i = 1
   ELSE
       LET i = 0
   END IF
   RETURN i
   #---FUN-AB0110 end---
END FUNCTION

FUNCTION s_t300_defr_detail(l_oma,l_omb,l_oct1,l_ocs05,l_type)
DEFINE l_aag15      LIKE aag_file.aag15
DEFINE    l_sql,l_sql1    LIKE type_file.chr1000
DEFINE    l_oma           RECORD LIKE oma_file.*
DEFINE    l_omb           RECORD LIKE omb_file.*
DEFINE    l_oct           RECORD LIKE oct_file.*
DEFINE    l_oct1          RECORD LIKE oct_file.*
DEFINE    l_oct08         LIKE oct_file.oct08
DEFINE    l_dbs           LIKE type_file.chr20
DEFINE    l_azp03         LIKE azp_file.azp03
DEFINE    l_oma02         LIKE oma_file.oma02
DEFINE    l_msg,l_msg1    LIKE type_file.chr1000
DEFINE    i,l_cnt         LIKE type_file.num5
DEFINE    l_oct14         LIKE type_file.num20
DEFINE    l_oct15         LIKE type_file.num20
DEFINE    l_oct14f        LIKE type_file.num20
DEFINE    l_oct15f        LIKE type_file.num20
DEFINE    l_cnt1          LIKE type_file.num5
DEFINE    l_cnt2          LIKE type_file.num5
DEFINE    l_c1_c2         LIKE type_file.num5
DEFINE    j               LIKE type_file.num5
DEFINE    l_ocs05         LIKE ocs_file.ocs05
DEFINE    l_type          LIKE type_file.chr1
DEFINE    l_aaa03         LIKE aaa_file.aaa03
DEFINE    l_azi04_2       LIKE azi_file.azi04
DEFINE    l_amt2,l_amt2_f   LIKE oct_file.oct14

   LET l_oct.* = l_oct1.*
   IF l_oct.oct16='1' THEN
      LET l_oct.oct16='2'
   ELSE
      LET l_oct.oct16='4'
   END IF
   SELECT azi04 INTO t_azi04 FROM azi_file
    WHERE azi01=l_oct1.oct18 AND aziacti = 'Y'
   IF STATUS THEN
      LET t_azi04 = 0
   END IF

   IF l_oma.oma00 = '21' THEN
       LET l_oct15  = (l_oct1.oct12 / l_ocs05)
       LET l_oct15f = (l_oct1.oct12f / l_ocs05)
       LET l_oct15  = cl_digcut(l_oct15,g_azi04)
       LET l_oct15f = cl_digcut(l_oct15f,t_azi04)

       SELECT oct01,oct02,oct09,oct10,oct12
         INTO g_oct01_o,g_oct02_o,g_oct09_s,g_oct10_s,g_oct12_o  #來源AR立帳年度/月份/總遞延金額
         FROM oct_file
        WHERE oct04 = l_oct1.oct04
          AND oct05 = l_oct1.oct05
          AND oct16 = '1'

       #---沖轉截止年度期別---#
       LET i = 0
       FOR i = 1 TO l_ocs05
           IF i = 1 THEN
               LET g_oct09_e = g_oct09_s
               LET g_oct10_e = g_oct10_s
               IF g_oct10_e >12 THEN
                   LET g_oct09_e = g_oct09_e + 1
                   LET g_oct10_e = 1
               END IF
           ELSE
               LET g_oct09_e = g_oct09_e
               LET g_oct10_e = g_oct10_e + 1
               IF g_oct10_e >12 THEN
                   LET g_oct09_e = g_oct09_e + 1
                   LET g_oct10_e = 1
               END IF
           END IF
       END FOR
       LET l_cnt1 = (g_oct09_e *12 ) + g_oct10_e
       LET l_cnt2 = (l_oct1.oct09 * 12) + l_oct1.oct10
       LET l_c1_c2 = (l_cnt1 - l_cnt2 )   #折讓期別~截止期別差距期數
       LET j = 0
       FOR j = 1 TO l_c1_c2 +1
           IF j = 1 THEN
               LET l_oct.oct09 = l_oct1.oct09
               LET l_oct.oct10 = l_oct1.oct10
               LET l_oct.oct15 = l_oct1.oct12 - (l_c1_c2 * l_oct15)
               LET l_oct.oct15f = l_oct1.oct12f - (l_c1_c2 * l_oct15f)
           ELSE
               IF l_oct.oct10 <> 12 THEN
                  LET l_oct.oct10 = l_oct.oct10 + 1
                  LET l_oct.oct09 = l_oct.oct09
               ELSE
                  LET l_oct.oct10 = 1
                  LET l_oct.oct09 = l_oct.oct09 + 1
               END IF
               LET l_oct.oct15 = l_oct15
               LET l_oct.oct15f = l_oct15f
           END IF
           LET l_oct.oct15  = cl_digcut(l_oct.oct15,g_azi04)
           LET l_oct.oct15f = cl_digcut(l_oct.oct15,t_azi04)
           LET l_cnt = 0
           INSERT INTO oct_file VALUES(l_oct.*)
           IF SQLCA.SQLCODE THEN
              CALL s_errmsg('oct01,oct02,oct09,oct10,oct11','ins oct','',SQLCA.SQLCODE,1)
              LET g_success = 'N'   #TQC-B10024
             #ROLLBACK WORK         #TQC-B10024 mark
           END IF
       END FOR
   ELSE    #出貨類oct16 = '1' or l_oma00 = '12' AND l_omb38 = '3'銷退
       LET i = 0
       FOR i = 1 TO l_ocs05
          IF i = 1 THEN
             LET l_oct.oct10 = l_oct1.oct10
             LET l_oct.oct09 = l_oct1.oct09
          ELSE
             IF l_oct.oct10 <> 12 THEN
                LET l_oct.oct10 = l_oct.oct10 + 1
                LET l_oct.oct09 = l_oct.oct09
             ELSE
                LET l_oct.oct10 = 1
                LET l_oct.oct09 = l_oct.oct09 + 1
             END IF
          END IF

         IF i = l_ocs05 THEN     #最後一期
             IF l_oma.oma00 = '12' AND l_omb.omb38 = '2' THEN
                 SELECT SUM(oct14),SUM(oct14f) INTO l_amt2,l_amt2_f
                   FROM oct_file
                  WHERE oct01 = l_oct1.oct01
                    AND oct02 = l_oct1.oct02
                    AND oct11 = l_oct1.oct11
                    AND (oct16 <> '1' AND oct16 <> '3')
                    AND oct00 = l_type
                 LET l_oct.oct14 = l_oct1.oct12 - l_amt2
                 LET l_oct.oct14f = l_oct1.oct12f - l_amt2_f
             ELSE
                 SELECT SUM(oct15),SUM(oct15f) INTO l_amt2,l_amt2_f
                   FROM oct_file
                  WHERE oct01 = l_oct1.oct01
                    AND oct02 = l_oct1.oct02
                    AND oct11 = l_oct1.oct11
                    AND (oct16 <> '1' AND oct16 <> '3')
                    AND oct00 = l_type
                 LET l_oct.oct15 = l_oct1.oct12 - l_amt2
                 LET l_oct.oct15f = l_oct1.oct12f - l_amt2_f
             END IF
         ELSE
             IF l_oma.oma00 = '12' AND l_omb.omb38 = '2' THEN
                 LET l_oct.oct14 = (l_oct1.oct12 / l_ocs05)
                 LET l_oct.oct14f = (l_oct1.oct12f / l_ocs05)
             ELSE
                 LET l_oct.oct15 = (l_oct1.oct12 / l_ocs05)
                 LET l_oct.oct15f = (l_oct1.oct12f / l_ocs05)
             END IF
         END IF
         IF l_type = '1' THEN
             CALL s_get_bookno(YEAR(l_oma.oma02)) RETURNING g_flag,g_bookno1,g_bookno2
             SELECT aaa03 INTO l_aaa03 FROM aaa_file
              WHERE aaa01 = g_bookno2
             SELECT azi04 INTO l_azi04_2 FROM azi_file
              WHERE azi01 = l_aaa03
             LET l_oct.oct14  = cl_digcut(l_oct.oct14,l_azi04_2)
             LET l_oct.oct15  = cl_digcut(l_oct.oct15,l_azi04_2)
         ELSE
             LET l_oct.oct14  = cl_digcut(l_oct.oct14,g_azi04)
             LET l_oct.oct15  = cl_digcut(l_oct.oct15,g_azi04)
         END IF
         LET l_oct.oct14f = cl_digcut(l_oct.oct14f,t_azi04)
         LET l_oct.oct15f = cl_digcut(l_oct.oct15f,t_azi04)
         INSERT INTO oct_file VALUES(l_oct.*)
         IF SQLCA.SQLCODE THEN
            CALL s_errmsg('oct01,oct02,oct09,oct10,oct11','ins oct','',SQLCA.SQLCODE,1)
            LET g_success = 'N'
           #ROLLBACK WORK   #TQC-B10024 mark
         END IF
     END FOR
   END IF
  #IF g_success = 'Y' THEN COMMIT WORK END IF  #TQC-B10024 mark
END FUNCTION

#FUNCTION s_t300_del_oct(p_oma01,p_type)         #FUN-AB0110
 FUNCTION s_t300_del_oct(p_oma00,p_oma01,p_type)  #FUN-AB0110
 DEFINE l_aag15      LIKE aag_file.aag15
DEFINE p_oma01   LIKE oma_file.oma01
DEFINE p_type    LIKE type_file.chr1
DEFINE p_oma00   LIKE oma_file.oma00  #FUN-AB0110
DEFINE l_cnt     LIKE type_file.num5  #FUN-AB0110
DEFINE i         LIKE type_file.num5  #FUN-AB0110

   #BEGIN WORK   #TQC-B10024 mark
    LET g_success = 'Y'
    LET g_plant_new = g_ooz.ooz02p  #總帳所在營運中心編號
    #CALL s_getdbs()
    #LET g_dbs_gl = g_dbs_new

#FUN-AB0110 --Begin
#   #--在INSERT之前先DELETE--
#   #LET g_sql =" DELETE FROM ",g_dbs_gl," oct_file",
#   LET g_sql =" DELETE FROM ",cl_get_target_table(g_plant_new,'oct_file'), #FUN-A50102
#               "  WHERE oct01 = '",p_oma01,"'",
#               "  AND oct17 = '",g_plant_new,"'",
#               "  AND oct08 IS NULL ",
#               "  AND oct00 = '",p_type,"'"
#   CALL cl_replace_sqldb(g_sql) RETURNING g_sql  #FUN-A50102
#   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql #FUN-A50102
#   PREPARE t300_pre12 FROM g_sql
#   EXECUTE t300_pre12
#   IF SQLCA.SQLCODE THEN
#       CALL s_errmsg('oma01',p_oma01,'delete oct_file',STATUS,1)
#       LET g_success = 'N'
#      #ROLLBACK WORK   #TQC-B10024 mark
#   ELSE
#      #COMMIT WORK     #TQC-B10024 mark
#   END IF
#FUN-AB0110 --End

     #---FUN-AB0110 start--
     #在刪除時應先check遞延收入是否已拋轉傳票,已拋轉者要先執行沖轉遞延還原
     SELECT COUNT(*) INTO l_cnt
       FROM oct_file
      WHERE oct01 =p_oma01
        AND oct17 =g_plant_new
        AND oct09 =YEAR(oma02)
        AND oct10 =MONTH(oma02)
        AND oct08 IS NOT NULL
        AND oct00 =p_type
     IF l_cnt > 0 THEN
        LET g_showmsg = p_oma00,"/",p_oma01
        CALL s_errmsg('oma00,oma01',g_showmsg,'','axr105',1)
        LET g_success = 'N'
     ELSE
         DELETE FROM oct_file
           WHERE oct01 = p_oma01
           AND oct17 =g_plant_new
           AND oct00 =p_type
         IF SQLCA.SQLCODE THEN
             CALL s_errmsg('oma01',p_oma01,'delete oct_file',STATUS,1)
             LET g_success = 'N'
            #ROLLBACK WORK   #TQC-B10024 mark
         ELSE
            #COMMIT WORK     #TQC-B10024 mark
         END IF
     END IF

     IF g_success ='Y' THEN
         LET i = 1
     ELSE
         LET i = 0
     END IF
     RETURN i
     #---FUN-AB0110 end---

END FUNCTION
#--FUN-A60007 end---

#---FUN-AB0110 start--
FUNCTION t300_ins_oct1(p_type,l_oma,l_omb,l_npq03,l_npq07,l_npq07f,l_npq27,l_npq28)
DEFINE l_aag15      LIKE aag_file.aag15
DEFINE l_oma     RECORD LIKE oma_file.*
DEFINE l_omb     RECORD LIKE omb_file.*
DEFINE p_type    LIKE type_file.chr1
DEFINE l_npq03   LIKE npq_file.npq03
DEFINE l_npq07   LIKE npq_file.npq07
DEFINE l_npq07f  LIKE npq_file.npq07f
DEFINE l_npq27   LIKE npq_file.npq27
DEFINE l_npq28   LIKE npq_file.npq28
DEFINE l_oma02   LIKE oma_file.oma02
DEFINE l_oct     RECORD LIKE oct_file.*
DEFINE l_omb33   LIKE omb_file.omb33
DEFINE l_ool41   LIKE ool_file.ool41

    LET l_oct.oct00 = p_type
    LET l_oct.oct01 = l_omb.omb01    #AR NO.
    LET l_oct.oct02 = l_omb.omb03    #項次
    LET l_oct.oct03 = l_omb.omb04    #料號
    IF l_oma.oma00 = '12' THEN
       LET l_oct.oct04 = l_omb.omb31   #出貨單號
       LET l_oct.oct05 = l_omb.omb32   #出貨項次
       LET l_oct.oct06 = ''
       LET l_oct.oct07 = ''
    ELSE
       LET g_sql="SELECT ohb31,ohb32 ", #出貨單號/項次
                 "  FROM ohb_file ",
                 " WHERE ohb01 = '",l_omb.omb31,"' ",    #銷退單號
                 "   AND ohb03 = '",l_omb.omb32,"' "     #銷退項次
       PREPARE s_t300_gl_ohb_1_pre FROM g_sql
       DECLARE s_t300_gl_ohb_1_cs CURSOR FOR s_t300_gl_ohb_1_pre
       OPEN s_t300_gl_ohb_1_cs
       FETCH s_t300_gl_ohb_1_cs INTO l_oct.oct04,l_oct.oct05
       CLOSE s_t300_gl_ohb_1_cs
       LET l_oct.oct06 = l_omb.omb31
       LET l_oct.oct07 = l_omb.omb32
    END IF
    LET l_oct.oct08 = ''

    #--依AR單據日期產生年度/月份
    LET g_sql="SELECT oma02 ",
              "  FROM oma_file,omb_file ",
              " WHERE omb01 = '",l_oct.oct01,"' ",
              "   AND omb03 = '",l_oct.oct02,"' ",
              "   AND oma01 = omb01  "
    PREPARE s_t300_gl_oma_pre FROM g_sql
    DECLARE s_t300_gl_oma_cs CURSOR FOR s_t300_gl_oma_pre
    OPEN s_t300_gl_oma_cs
    FETCH s_t300_gl_oma_cs INTO l_oma02
    CLOSE s_t300_gl_oma_cs
    LET l_oct.oct09 = YEAR(l_oma02)
    LET l_oct.oct10 = MONTH(l_oma02)
    LET l_oct.oct11 = l_npq28
    LET l_oct.oct12 = 0
    LET l_oct.oct12f = 0

    LET l_oct.oct13 = l_npq03     #遞延收入科目一

    LET l_oct.oct12  = l_npq07
    LET l_oct.oct12f = l_npq07f

    LET l_oct.oct14 = 0
    LET l_oct.oct14f= 0
    LET l_oct.oct15 = 0
    LET l_oct.oct15f= 0
    IF l_oma.oma00 = '12' AND l_omb.omb38 = '2' THEN
       LET l_oct.oct16 = '1'   #總遞延收入
    ELSE
       LET l_oct.oct16 = '3'   #折讓
    END IF
    LET l_oct.oct17 = g_plant_new
    LET l_oct.oct18 = l_oma.oma23
    LET l_oct.oct19 = l_oma.oma58

    IF l_oma.oma00 = '12' THEN
        IF p_type = '0' THEN
            SELECT omb33 INTO l_omb33
              FROM omb_file
             WHERE omb01= l_oct.oct01
               AND omb03= l_oct.oct02
            IF cl_null(l_omb33) THEN
                SELECT ool41 INTO l_ool41
                  FROM ool_file,oma_file
                 WHERE oma01 = l_oct.oct01
                   AND oma13 = ool01
                LET l_omb33 = l_ool41
            END IF
        ELSE
            SELECT omb331 INTO l_omb33
              FROM omb_file
             WHERE omb01= l_oct.oct01
               AND omb03= l_oct.oct02
            IF cl_null(l_omb33) THEN
                SELECT ool411 INTO l_ool41
                  FROM ool_file,oma_file
                 WHERE oma01 = l_oct.oct01
                   AND oma13 = ool01
                LET l_omb33 = l_ool41
            END IF
        END IF
    ELSE    #折讓類遞延反向科目以帳別+齣貨單號+項次+售貨動作取12類應收的oct20
        SELECT oct20 INTO l_omb33
          FROM oct_file
         WHERE oct00 = p_type
           AND oct04 = l_oct.oct04   #出貨單號
           AND oct05 = l_oct.oct05   #出貨項次
           AND oct11 = l_oct.oct11
           AND oct16 = '1'
    END IF

    LET l_oct.oct20 = l_omb33
    LET l_oct.oct23 = l_oma.oma03
    LET l_oct.oct24 = l_oma.oma15
    LET l_oct.octlegal=l_oma.omalegal

    INSERT INTO oct_file VALUES(l_oct.*)
    IF SQLCA.SQLCODE THEN
        CALL s_errmsg('oma01',l_oma.oma01,'INSERT INTO oct_file',SQLCA.SQLCODE,1)
        LET g_success = 'N'
       #ROLLBACK WORK   #TQC-B10024 mark
    ELSE
        CALL s_t300_defr_detail(l_oma.*,l_omb.*,l_oct.*,l_npq27,p_type)  #計算每一期沖轉遞延收入寫入oct_file
    END IF
END FUNCTION
#----FUN-AB0110 end------------
