# Prog. Version..: '5.30.06-13.04.18(00010)'     #
#
# Pattern name...: saxrp310_bu.4gl
# Descriptions...: 自動產生應收帳款副程式
# Date & Author..: 11/09/11 CHI-B90025 By Dido
# Remark ........:
# Modify.........: No.MOD-BA0227 11/11/01 By Dido 出貨應收之訂金金額應採用金額比率方式計算
# Modify.........: No.MOD-BB0082 11/11/07 By Dido 發票金額應與本幣金額一樣有差異調整
# Modify.........: No.MOD-BB0077 11/11/08 By Polly 調整撈取訂金資料條件
# Modify.........: No.MOD-BC0294 11/12/29 By Polly 調整axmp800拋轉時,當oea261/oea262/oea263為null時，給予0
# Modify.........: No.FUN-C10055 12/01/18 By fanbj 調整應收賬款oma70（來源類型）欄位值
# Modify.........: No.MOD-C20078 12/02/10 By Polly 調整尾款金額計算的判斷
# Modify.........: No.MOD-C20141 12/02/20 By Polly 類別為「非應收發票」單身總計金額應回寫oma55、oma57
# Modify.........: No.MOD-C30415 12/03/13 By zhangweib 若業態為零售(azw04 = '2')且客戶設置了'按交款金額產生應收'(occ73 = 'Y')，則按照實際交款金額產生應收,
#                                                      而不是按照訂金比例；且稅額為零
#                                                      saxrp310_bu()計算稅額時給l_occ73賦值
# Modify.........: No.TQC-C30309 12/03/27 By Dido 無訂單出貨單時,原幣未稅金額有誤
# Modify.........: No.FUN-C30296 12/03/28 By xuxz LINE 790 g_mTax = TRUE --->g_mTax = FALSE
# Modify.........: No.TQC-C40180 12/04/19 By lutingting 修正TQC-C30415 bug
# Modify.........: No.TQC-BB0019 12/04/30 By Elise 因未給予l_occ73,應改用g_occ73,在此程式共用即可
# Modify.........: No.CHI-C10018 12/05/15 By Polly 出貨合併折讓邏輯調整
# Modify.........: No.FUN-C60036 12/06/29 By xuxz 增加大陸版且走開票時數額計算方式
# Modify.........: No.MOD-C60229 12/06/29 By Polly 調整更改立帳匯率後原幣金額會變成0的錯誤
# Modify.........: No.MOD-C70122 12/07/12 By Polly 改抓單身的訂單編號抓取原幣幣金額
# Modify.........: No.TQC-C70227 12/09/11 By yinhy 流通版本訂金應收比例為100%時，產生應收賬款錯誤
# Modify.........: No.MOD-C80007 12/08/06 By Polly oea262出貨金額為0，不需計算尾差
# Modify.........: No.MOD-C90145 12/09/18 By Polly 增加oea162判斷，若oea262=0 and oea162=100時，比照無訂單出貨方式抓取
# Modify.........: No.FUN-C90105 12/10/16 By xuxz 根據是否認列收入，來重新計算訂金，出貨時候的金額
# Modify.........: No.CHI-CB0016 12/11/08 By Dido axrp330 彙總問題處理
# Modify.........: No:MOD-CC0042 12/12/06 By Polly 修正銷退方式為"折讓"時單價及含稅金額
# Modify.........: No:MOD-CC0189 12/12/21 By Polly 當含稅時，訂金金額不可反推計算，應以訂單總未稅金額計算
# Modify.........: No.MOD-C90173 13/01/22 By apo 出貨應收時部分尾款比率計算調整
# Modify.........: No.TQC-D40007 13/01/22 By pauline 流通業並且功能別為台灣時,含稅金額/未稅金額必須要由含稅否欄位回推計算
# Modify.........: No.MOD-D60020 13/06/04 By yinhy oaz92為Y並且為大陸版時oma54不可為0
# Modify.........: No.MOD-D60156 13/06/19 By SunLM t_azi04未取到值
# Modify.........: No.161226     16/12/26 By pulf  外币原币税前金额、原币应收金额未参考azi04,导致冲账数额有误
# Modify.........: No.170405     17/04/05 By pulf  修正出货开票直接更新预收的oma55，oma57有误，导致出货应收审核之后又冲预收的oma55,oma57，并且正常冲抵omc，导致预收显示负数问题
# Modify.........: No.170417     17/04/17 By pulf  预收还未冲完，出货应收可以冲预收
# Modify.........: No.170503     17/05/03 By pulf  修正No.170417
# Modify.........: No.170509     17/05/09 By pulf  修正重复冲预收问题

DATABASE ds

GLOBALS "../../config/top.global"
GLOBALS "../../sub/4gl/s_g_ar.global"

DEFINE g_oma RECORD LIKE oma_file.*
DEFINE g_ogb RECORD LIKE ogb_file.*
DEFINE g_check      LIKE type_file.chr1
DEFINE g_sql        STRING
DEFINE g_net        LIKE oox_file.oox10
DEFINE g_mTax       LIKE type_file.chr1    # FUN-C10055 add
DEFINE g_occ73      LIKE occ_file.occ73  #TQC-BB0019
DEFINE g_oaz92      LIKE oaz_file.oaz92  #MOD-D60020
DEFINE l_count1     LIKE type_file.num5    #add by dengsy10328
DEFINE l_count2     LIKE type_file.num5    #add by dengsy160328
DEFINE l_omc08,l_omc09,l_omc10,l_omc11 LIKE omc_file.omc10  #add by dengsy161028

#由訂單或出貨單產生應收
#----------------------------(單身更新單頭)----------------------------
FUNCTION saxrp310_bu(p_oma,p_ogb,p_oea01,p_oeaa08)
   DEFINE p_oma     RECORD LIKE oma_file.*
   DEFINE p_ogb     RECORD LIKE ogb_file.*
   DEFINE p_oea01   LIKE oea_file.oea01
   DEFINE p_oeaa08  LIKE oeaa_file.oeaa08
   DEFINE l_oea01   LIKE oea_file.oea01
   DEFINE l_oea01x  LIKE oea_file.oea01   #MOD-BA0227
   DEFINE l_oeaa08  LIKE oeaa_file.oeaa08
   DEFINE l_oea61   LIKE oea_file.oea61   #訂單總未稅金額
   DEFINE l_oea1008 LIKE oea_file.oea1008 #訂單總含稅金額
   DEFINE l_oea162  LIKE oea_file.oea162      #MOD-C90145
   DEFINE l_oea261  LIKE oea_file.oea261    #訂金未稅
   DEFINE l_oea261t LIKE oea_file.oea261    #訂金含稅   #MOD-BA0227
   DEFINE l_oea262  LIKE oea_file.oea262
   DEFINE l_oea263  LIKE oea_file.oea263    #尾款未稅
   DEFINE l_oea263t LIKE oea_file.oea263    #尾款含稅   #MOD-BA0227
   DEFINE l_sumoea261  LIKE oea_file.oea261 #訂金未稅金額
   DEFINE l_sumoea263  LIKE oea_file.oea263 #尾款未稅金額
   DEFINE l_sumoea263t LIKE oea_file.oea263 #尾款含稅金額  #MOD-BA0227
   DEFINE l_n      LIKE type_file.num5
   DEFINE l_occ73  LIKE occ_file.occ73
   DEFINE l_rxx00  LIKE rxx_file.rxx00
   DEFINE l_oma54  LIKE oma_file.oma54      #待抵預收淨額未稅
   DEFINE l_oma56  LIKE oma_file.oma56
   DEFINE l_oma56t LIKE oma_file.oma56t
   DEFINE l_oma59  LIKE oma_file.oma59      #MOD-BB0082
   DEFINE l_oma59t LIKE oma_file.oma59t     #MOD-BB0082
   DEFINE l_rxx04  LIKE rxx_file.rxx04
   DEFINE l_12_oma52  LIKE oma_file.oma52   #分批訂金金額(未稅)
   DEFINE l_13_oma54  LIKE oma_file.oma54   #尾款金額(未稅)
   DEFINE l_13_oma54t LIKE oma_file.oma54t  #尾款金額(含稅)
   DEFINE l_13_oma56  LIKE oma_file.oma56
   DEFINE l_13_oma56t LIKE oma_file.oma56
   DEFINE l_13_oma59  LIKE oma_file.oma59   #MOD-BB0082
   DEFINE l_13_oma59t LIKE oma_file.oma59   #MOD-BB0082
   DEFINE l_oeb917    LIKE oeb_file.oeb917
   DEFINE l_ogb917    LIKE ogb_file.ogb917
   DEFINE l_sumogb917 LIKE ogb_file.ogb917  #出貨總數量
   DEFINE l_sumomb16  LIKE omb_file.omb16   #出貨總金額(未稅)
   DEFINE l_sumomb16t LIKE omb_file.omb16t  #出貨總金額(含稅)
   DEFINE l_sumomb18  LIKE omb_file.omb18   #MOD-BB0082
   DEFINE l_sumomb18t LIKE omb_file.omb18t  #MOD-BB0082
   DEFINE l_oea263_1  LIKE oea_file.oea263
   DEFINE l_oea263_1t LIKE oea_file.oea263
   DEFINE l_oea263_2  LIKE oea_file.oea263
   DEFINE l_oea263_2t LIKE oea_file.oea263
   DEFINE l_oma52     LIKE oma_file.oma52
   DEFINE l_oma52t    LIKE oma_file.oma52
   DEFINE l_oma53t    LIKE oma_file.oma53   #MOD-BA0227
   DEFINE l_sumoma54  LIKE oma_file.oma54
   DEFINE l_sumoma54t LIKE oma_file.oma54t
   DEFINE l_sumoma56  LIKE oma_file.oma56
   DEFINE l_sumoma56t LIKE oma_file.oma56t
   DEFINE li_count    LIKE type_file.num10    #FUN-C30296 add
   DEFINE l_cnt       LIKE type_file.num5     #CHI-C10018 add
   DEFINE l_21_omb14  LIKE omb_file.omb14         #MOD-CC0042
   DEFINE l_21_omb14t LIKE omb_file.omb14t        #MOD-CC0042
   DEFINE l_21_omb16  LIKE omb_file.omb16         #MOD-CC0042
   DEFINE l_21_omb16t LIKE omb_file.omb16t        #MOD-CC0042
   DEFINE l_21_omb18  LIKE omb_file.omb18         #MOD-CC0042
   DEFINE l_21_omb18t LIKE omb_file.omb18t        #MOD-CC0042
   DEFINE l_14_oma54  LIKE oma_file.oma54    #yinhy131211  #尾款金額(未稅)
   DEFINE l_14_oma54t LIKE oma_file.oma54t   #yinhy131211  #尾款金額(含稅)
   DEFINE l_14_oma54x LIKE oma_file.oma54x   #yinhy131211
   DEFINE l_14_oma56  LIKE oma_file.oma56    #yinhy131211
   DEFINE l_14_oma56t LIKE oma_file.oma56    #yinhy131211
   DEFINE l_14_oma56x LIKE oma_file.oma56x   #yinhy131211
   DEFINE l_14_oma59  LIKE oma_file.oma59    #yinhy131211
   DEFINE l_14_oma59t LIKE oma_file.oma59    #yinhy131211
   DEFINE l_sumomb18_1  LIKE omb_file.omb18    #yinhy131211
   DEFINE l_sumomb18t_1 LIKE omb_file.omb18t   #yinhy131211
   DEFINE l_omf19t  LIKE omf_file.omf19t  #zhouxm151217
   DEFINE l_omf29t  LIKE omf_file.omf29t  #zhouxm151217
   DEFINE l_dj      LIKE omf_file.omf19t   #zhouxm151217
   DEFINE l_omc13   LIKE omc_file.omc13   #No.170503 add
   DEFINE l_oma61   LIKE oma_file.oma61   #No.170503 add

   LET g_oma.*  = p_oma.*
   LET g_ogb.*  = p_ogb.*
   LET l_oea01  = p_oea01
   LET l_oeaa08 = p_oeaa08

  #計數交易單號是否存在於交款匯總檔
   LET l_n = 0
   IF g_oma.oma16 <> ' ' THEN  #CHI-CB0016
      LET g_sql = "SELECT COUNT(*)",
                  "  FROM ",cl_get_target_table(g_plant_new,'rxx_file'),
                  " WHERE rxx01 = '",g_oma.oma16,"'",
                  "   AND rxxplant = '",g_oma.oma66,"'"
  #-CHI-CB0016-add-
   ELSE
      LET g_sql = "SELECT COUNT(*)",
                  "  FROM ",cl_get_target_table(g_plant_new,'rxx_file'),
                  " WHERE rxx01 IN (SELECT omb31 FROM omb_file ",
                  "                  WHERE omb01 = '",g_oma.oma01,"')",
                  "   AND rxxplant = '",g_oma.oma66,"'"
   END IF
  #-CHI-CB0016-end-
   CASE
      WHEN g_oma.oma00 = '11' OR g_oma.oma00 = '13'
         LET g_sql = g_sql
         LET l_rxx00 = '01'
      WHEN g_oma.oma00 = '12' OR g_oma.oma00 = '19'
         LET g_sql = g_sql
         LET l_rxx00 = '02'
      WHEN g_oma.oma00 = '21' OR g_oma.oma00 = '28'
        LET g_sql = g_sql
        LET l_rxx00 = '03'
   END CASE
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_rxx_pre FROM g_sql
   EXECUTE sel_rxx_pre INTO l_n

  #抓取收款客戶的按交款金額產生應收欄位
   LET g_sql = "SELECT occ73 ",
               "  FROM ",cl_get_target_table(g_plant_new,'occ_file'),
               " WHERE occ01 = '",g_oma.oma68,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_occ_pre49 FROM g_sql
   EXECUTE sel_occ_pre49 INTO g_occ73  #TQC-BB0019 l_occ73->g_occ73
   IF cl_null(g_occ73) THEN LET g_occ73 = 'N' END IF   #TQC-BB0019 l_occ73->g_occ73

   IF l_n > 0 AND g_occ73 ='Y' THEN  #TQC-BB0019 l_occ73->g_occ73
      LET g_check = 'Y'
   ELSE
      LET g_check = 'N'
   END IF
   SELECT oaz92 INTO g_oaz92 FROM oaz_file             #MOD-D60020
  #預設值
   LET g_oma.oma50 = 0   LET g_oma.oma50t = 0
   LET g_oma.oma52 = 0   LET g_oma.oma53  = 0   #訂金原幣/本幣
   LET g_oma.oma56 = 0   LET g_oma.oma56t = 0
   LET g_oma.oma59 = 0   LET g_oma.oma59t = 0

   SELECT SUM(omb14),SUM(omb14t),SUM(omb16),SUM(omb16t),SUM(omb18),SUM(omb18t)
     INTO g_oma.oma50,g_oma.oma50t,g_oma.oma56,g_oma.oma56t,g_oma.oma59,g_oma.oma59t
     FROM omb_file
    WHERE omb01 = g_oma.oma01
   #-----------------------MOD-CC0042----------------(S)
   SELECT SUM(omb14)*-1,SUM(omb14t)*-1,SUM(omb16)*-1,SUM(omb16t)*-1,SUM(omb18)*-1,SUM(omb18t)*-1
     INTO l_21_omb14,l_21_omb14t,l_21_omb16,l_21_omb16t,l_21_omb18,l_21_omb18t
     FROM omb_file
    WHERE omb01 = g_oma.oma01
     AND omb38 = '3'
   #-----------------------MOD-CC0042----------------(E)
   IF g_oma.oma50  IS NULL THEN LET g_oma.oma50  = 0 END IF
   IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t = 0 END IF
   IF g_oma.oma56  IS NULL THEN LET g_oma.oma56  = 0 END IF
   IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t = 0 END IF
   IF g_oma.oma59  IS NULL THEN LET g_oma.oma59  = 0 END IF
   IF g_oma.oma59t IS NULL THEN LET g_oma.oma59t = 0 END IF
   IF cl_null(l_21_omb14) THEN LET l_21_omb14 = 0 END IF          #MOD-CC0042
   IF cl_null(l_21_omb14t) THEN LET l_21_omb14t = 0 END IF        #MOD-CC0042
   IF cl_null(l_21_omb16) THEN LET l_21_omb16 = 0 END IF          #MOD-CC0042
   IF cl_null(l_21_omb16t) THEN LET l_21_omb16t = 0 END IF        #MOD-CC0042
   IF cl_null(l_21_omb18) THEN LET l_21_omb18 = 0 END IF          #MOD-CC0042
   IF cl_null(l_21_omb18t) THEN LET l_21_omb18t = 0 END IF        #MOD-CC0042

   LET g_oma.oma73 = 0   LET g_oma.oma73f = 0   #原幣代收/本幣代收
   IF g_oma.oma74 = '2' AND (g_oma.oma00 ='28' OR g_oma.oma00 ='19') THEN
      SELECT SUM(omb14t),SUM(omb16t) INTO g_oma.oma73f,g_oma.oma73
        FROM omb_file
       WHERE omb01=g_oma.oma01
      IF g_oma.oma73 IS NULL THEN LET g_oma.oma73=0 END IF
      IF g_oma.oma73f IS NULL THEN LET g_oma.oma73f=0 END IF
   END IF

  #累計已出貨訂單的訂金金額與尾款金額
   IF g_oma.oma16 <> ' ' THEN   #CHI-CB0016
      LET g_sql = "SELECT SUM(oea261),SUM(oea263) ",
                  "  FROM ",cl_get_target_table(g_plant_new,'oea_file'),
                  " WHERE oea01 IN (",
                  " SELECT ogb31 ",
                  " FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                  "  WHERE ogb01 = '",g_oma.oma16,"')"
  #-CHI-CB0016-add-
   ELSE
      LET g_sql = "SELECT oea261,oea263 ",
                  "  FROM ",cl_get_target_table(g_plant_new,'oea_file'),
                  " WHERE oea01 = '",l_oea01,"'"
   END IF
  #-CHI-CB0016-end-
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_oea26x_pre FROM g_sql

  #非本張出貨訂單的單身金額
  #-MOD-BB0077-mark-
  #LET g_sql = "SELECT SUM(omb14)-SUM(oma52)-SUM(oma54),",
  #            "       SUM(omb14t)-SUM(oma52*(1+oma211/100))-SUM(oma54t),",
  #            "       SUM(omb16)-SUM(oma53)-SUM(oma56),",
  #            "       SUM(omb16t)-SUM(oma53*(1+oma211/100))-SUM(oma56t),",
  #            "       SUM(oma52) ",
  #-MOD-BB0077-end-
   LET g_sql = "SELECT SUM(omb14),SUM(omb14t),SUM(omb16),SUM(omb16t) ",  #MOD-BB0077
               "  FROM oma_file,omb_file,",cl_get_target_table(g_plant_new,'ogb_file'),
               " WHERE oma01=omb01 AND omb31=ogb01",
              #"   AND ogb31 IN (SELECT ogb31 FROM ",cl_get_target_table(g_plant_new,'ogb_file'), #CHI-CB0016 mark
              #"                  WHERE ogb01 = '",g_ogb.ogb01,"')",                              #CHI-CB0016 mark
               "   AND ogb31 IN (SELECT omb31 FROM omb_file ",        #CHI-CB0016
               "                  WHERE omb01 = '",g_oma.oma01,"')",  #CHI-CB0016
              #"   AND ogb01!='",g_ogb.ogb01,"'",                     #CHI-CB0016 mark
               "   AND oma01 != '",g_oma.oma01,"'",                   #CHI-CB0016
               "   AND (oma00 = '12' OR oma00 = '19')",
               "   AND omavoid= 'N'",
               "   AND omb32 = ogb03"                                    #MOD-BB0077
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_oea26x_1_pre FROM g_sql

  #-MOD-BB0077-add-
  #非本張出貨訂單的單頭金額
   IF g_oma.oma16 <> ' ' THEN  #CHI-CB0016
      LET g_sql = "SELECT SUM(oma52)+SUM(oma54),SUM(oma52*(1+oma211/100))+SUM(oma54t),",
                  "       SUM(oma53)+SUM(oma56),SUM(oma53*(1+oma211/100))+SUM(oma56t),",
                  "       SUM(oma52) ",
                  "  FROM oma_file ",
                  " WHERE oma19 IN (SELECT ogb31 FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                  "                  WHERE ogb01 = '",g_ogb.ogb01,"')",
                  "   AND oma16 != '",g_ogb.ogb01,"'",
                  "   AND (oma00 = '12' OR oma00 = '19')",
                  "   AND omavoid= 'N'"
  #-CHI-CB0016-add-
   ELSE
      LET g_sql = "SELECT SUM(oma52)+SUM(oma54),SUM(oma52*(1+oma211/100))+SUM(oma54t),",
                  "       SUM(oma53)+SUM(oma56),SUM(oma53*(1+oma211/100))+SUM(oma56t),",
                  "       SUM(oma52) ",
                  "  FROM oma_file ",
                  " WHERE oma19 IN (SELECT ogb31 FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                  "                  WHERE ogb01 IN (SELECT omb31 FROM omb_file ",
                  "                                   WHERE omb01 = '",g_oma.oma01,"'))",
                  "   AND oma16 NOT IN (SELECT omb31 FROM omb_file ",
                  "                      WHERE omb01 = '",g_oma.oma01,"')",
                  "   AND (oma00 = '12' OR oma00 = '19')",
                  "   AND omavoid= 'N'"
   END IF
  #-CHI-CB0016-end-
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_oea26x_2_pre FROM g_sql
  #-MOD-BB0077-end-

  #-MOD-BA0227-add-
  #抓取訂單資料
   CASE
      WHEN g_oma.oma00 = '12' OR g_oma.oma00 = '19'
       #-----------------MOD-C70122-----------(S)
       #------MOD-C70122----mark
       ##-----------------MOD-C60229-----------(S)
       # SELECT oga16 INTO g_ogb.ogb31
       #   FROM oga_file
       #  WHERE oga01 = g_oma.oma16
       ##-----------------MOD-C60229-----------(E)
       #------MOD-C70122----mark
         DECLARE t620_ogb31 SCROLL CURSOR FOR
                 SELECT ogb31 FROM ogb_file,oga_file
                  WHERE ogb01 = g_oma.oma16
                    AND oga01 = ogb01
                    AND ogaconf = 'Y'
         OPEN t620_ogb31
         FETCH FIRST t620_ogb31 INTO g_ogb.ogb31
         CLOSE t620_ogb31
        #-CHI-CB0016-add-
         IF cl_null(g_ogb.ogb01) AND NOT cl_null(l_oea01) THEN
            LET g_ogb.ogb31 = l_oea01
         END IF
        #-CHI-CB0016-end-
       #-----------------MOD-C70122-----------(E)
         LET l_oea01x = g_ogb.ogb31
      WHEN g_oma.oma00 = '13'
         LET l_oea01x = g_oma.oma16
   END CASE
  #LET g_sql = "SELECT oea61,oea261,oea262,oea263 ",                    #MOD-C90145 mark
   LET g_sql = "SELECT oea61,oea162,oea261,oea262,oea263 ",             #MOD-C90145
               "  FROM ",cl_get_target_table(g_plant_new,'oea_file'),
               " WHERE oea01 = '",l_oea01x,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_oea_pre FROM g_sql
  #-MOD-BA0227-end-

  #-CHI-CB0016-add-
   LET g_sql = "SELECT oga162 ",
               "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),
               " WHERE oga01 IN (SELECT omb31 FROM omb_file ",
               "                  WHERE omb01 = '",g_oma.oma01,"')"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE p310_oga_pre2 FROM g_sql
   DECLARE p310_oga_cs2 SCROLL CURSOR FOR p310_oga_pre2
  #-CHI-CB0016-end-

   CASE
     #-訂金-
      WHEN g_oma.oma00 = '11'
         LET l_rxx04 = 0
         LET g_sql = "SELECT SUM(rxx04) ",
                     "  FROM ",cl_get_target_table(g_plant_new,'rxx_file'),
                     " WHERE rxx01 = '",l_oea01,"' AND rxx03 = '1'",
                     "   AND rxx00 = '01'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_rxx_pre48 FROM g_sql
         EXECUTE sel_rxx_pre48 INTO l_rxx04
         IF cl_null(l_rxx04) THEN LET l_rxx04 = 0 END IF
        #原幣計算
        #IF l_occ73 = 'N' THEN       #No.MOD-C30415   Mark
        #IF l_occ73 = 'N' AND g_azw.azw04 = '2' THEN   #No.MOD-C30415   Add   #TQC-C40180
         IF g_occ73 = 'N' AND g_azw.azw04 <> '2' THEN   #TQC-C40180  #TQC-BB0019 l_occ73->g_occ73
            IF g_oma.oma213 = 'Y' THEN
               LET g_oma.oma54t = l_oeaa08
               LET g_oma.oma54  = g_oma.oma54t/(1+ g_oma.oma211/100)
               #FUN-C90105--add--str
               IF g_ooz.ooz33 = 'N' AND g_aza.aza26 ='2' THEN
                  LET g_oma.oma54 = g_oma.oma54t
               END IF
               #FUN-C90105--add--end
            ELSE
               LET g_oma.oma54  = l_oeaa08
               LET g_oma.oma54t = g_oma.oma54*(1+ g_oma.oma211/100)
               #FUN-C90105--add--str
               IF g_ooz.ooz33 = 'N' AND g_aza.aza26 ='2'   THEN
                  LET g_oma.oma54 = g_oma.oma54t
               END IF
               #FUN-C90105--add--end
            END IF
         ELSE
           #流通業但是功能別不為台灣時,含稅金額 = 未稅金額
            IF g_aza.aza26 <> '0' THEN    #TQC-D40007 add
               LET g_oma.oma54t = l_rxx04
               LET g_oma.oma54 = l_rxx04
           #TQC-D40007 add START
           #流通業並且功能別為台灣時,含稅金額/未稅金額必須要由含稅否欄位回推計算
            ELSE
               IF g_oma.oma213 = 'Y' THEN
                  LET g_oma.oma54t = l_rxx04
                  LET g_oma.oma54 = g_oma.oma54t/(1+ g_oma.oma211/100)
                  LET g_oma.oma54x = g_oma.oma54t - g_oma.oma54
               ELSE
                  LET g_oma.oma54 = l_rxx04
                  LET g_oma.oma54t = g_oma.oma54t*(1+ g_oma.oma211/100)
                  LET g_oma.oma54x = g_oma.oma54t - g_oma.oma54
               END IF
            END IF
           #TQC-D40007 add END
         END IF
        #原幣稅額計算
        #IF l_occ73 = 'N' AND g_azw.azw04 = '2' THEN   #No.MOD-C30415   Add  #TQC-C40180
        #IF g_occ73 = 'N' AND g_azw.azw04 <> '2' THEN   #TQC-C40180  #TQC-BB0019 l_occ73->g_occ73 #FUN-C90105 mark
         IF g_occ73 = 'N' AND g_azw.azw04 <> '2' AND (g_ooz.ooz33 = 'Y' OR g_aza.aza26 !='2')THEN #FUN-C90105 add
            CALL saxrp310_tax(g_oma.oma54,g_oma.oma54t,'A')
                 RETURNING g_oma.oma54,g_oma.oma54t,g_oma.oma54x
         END IF                                        #No.MOD-C30415   Add
        #本幣計算
        #IF l_occ73 = 'N' THEN    #No.MOD-C30415   Mark
        #IF l_occ73 = 'N' AND g_azw.azw04 = '2' THEN   #No.MOD-C30415   Add   #TQC-C40180
         IF g_occ73 = 'N' AND g_azw.azw04 <> '2' THEN   #TQC-C40180  #TQC-BB0019 l_occ73->g_occ73
            LET g_oma.oma56  = g_oma.oma54 * g_oma.oma24
            LET g_oma.oma56t = g_oma.oma54t* g_oma.oma24
         ELSE
           #流通業但是功能別不為台灣時,含稅金額 = 未稅金額
            IF g_aza.aza26 <> '0' THEN    #TQC-D40007 add
               LET g_oma.oma56t  = l_rxx04 * g_oma.oma24
               LET g_oma.oma56 = l_rxx04 * g_oma.oma24
           #TQC-D40007 add START
           #流通業並且功能別為台灣時,含稅金額/未稅金額必須要由含稅否欄位回推計算
            ELSE
               IF g_oma.oma213 = 'Y' THEN
                  LET g_oma.oma56t = l_rxx04
                  LET g_oma.oma56 = g_oma.oma56t/(1+ g_oma.oma211/100)
                  LET g_oma.oma56x = g_oma.oma56t - g_oma.oma56
               ELSE
                  LET g_oma.oma56 = l_rxx04
                  LET g_oma.oma56t = g_oma.oma56t*(1+ g_oma.oma211/100)
                  LET g_oma.oma56x = g_oma.oma56t - g_oma.oma56
               END IF
            END IF
           #TQC-D40007 add END
         END IF
        #本幣稅額計算
        #IF l_occ73 = 'N' AND g_azw.azw04 = '2' THEN   #No.MOD-C30415   Add  #TQC-C40180
        #IF g_occ73 = 'N' AND g_azw.azw04 <> '2' THEN   #TQC-C40180  #TQC-BB0019 l_occ73->g_occ73#FUN-C90105 mark
         IF g_occ73 = 'N' AND g_azw.azw04 <> '2' AND (g_ooz.ooz33 = 'Y' OR g_aza.aza26 !='2')THEN #FUN-C90105 add
            CALL saxrp310_tax(g_oma.oma56,g_oma.oma56t,'B')
                 RETURNING g_oma.oma56,g_oma.oma56t,g_oma.oma56x
         END IF                                        #No.MOD-C30415   Add
        #發票計算
         LET g_oma.oma59  = g_oma.oma54 * g_oma.oma58
         LET g_oma.oma59t = g_oma.oma54t* g_oma.oma58
        #發票稅額計算
         IF g_ooz.ooz33 = 'Y' OR g_aza.aza26 !='2' THEN #FUN-C90105 add
            CALL saxrp310_tax(g_oma.oma59,g_oma.oma59t,'C')
                    RETURNING g_oma.oma59,g_oma.oma59t,g_oma.oma59x
         END IF #FUN-C90105 add

     #-出貨/代收-
      WHEN g_oma.oma00 = '12' OR g_oma.oma00 = '19'
        #累計出貨訂單計價數量
         LET l_oeb917 = 0
         LET g_sql = "SELECT SUM(oeb917) ",
                     "  FROM ",cl_get_target_table(g_plant_new,'oeb_file'),
                     " WHERE oeb01 = '",g_ogb.ogb31,"'"
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_oeb_pre02 FROM g_sql
         EXECUTE sel_oeb_pre02 INTO l_oeb917
         IF l_oeb917 IS NULL THEN LET l_oeb917 = 0 END IF
        #累計存在於其他出貨單的訂單計價數量
         LET l_ogb917 = 0
         IF g_oma.oma16 <> ' ' THEN  #CHI-CB0016
            LET g_sql = "SELECT SUM(ogb917)",
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                                  cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 <> '",g_ogb.ogb01,"' AND ogb31 = '",g_ogb.ogb31,"'",
                        "   AND (oga10 IS NOT NULL AND oga10 <> ' ' ) ",
                        "   AND oga01 = ogb01 ",
                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "
        #-CHI-CB0016-add-
         ELSE
            LET g_sql = "SELECT SUM(ogb917)",
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                                  cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 NOT IN (SELECT omb31 FROM omb_file ",
                        "                      WHERE omb01 = '",g_oma.oma01,"')",
                        "   AND ogb31 = '",l_oea01,"'",
                        "   AND (oga10 IS NOT NULL AND oga10 <> ' ' ) ",
                        "   AND oga01 = ogb01 ",
                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "
         END IF
        #-CHI-CB0016-end-
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_ogb_pre01 FROM g_sql
         EXECUTE sel_ogb_pre01 INTO l_ogb917
         IF l_ogb917 IS NULL THEN LET l_ogb917 = 0 END IF
        #累計本張出貨單的訂單計價數量
         LET l_sumogb917 = 0
         IF g_oma.oma16 <> ' ' THEN #CHI-CB0016
            LET g_sql = "SELECT SUM(ogb917)",
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                                  cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 = '",g_ogb.ogb01,"' AND ogb31 = '",g_ogb.ogb31,"'",
                        "   AND oga01 = ogb01 ",
                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "
        #-CHI-CB0016-add-
         ELSE
            LET g_sql = "SELECT SUM(ogb917)",
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),",",
                                  cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 IN (SELECT omb31 FROM omb_file ",
                        "                  WHERE omb01 = '",g_oma.oma01,"')",
                        "   AND ogb31 = '",l_oea01,"'",
                        "   AND oga01 = ogb01 ",
                        "   AND ((oga09 = '2' AND oga65 = 'N') OR (oga09 IN ('3','4','8','A'))) "
         END IF
        #-CHI-CB0016-end-
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_ogb_pre08 FROM g_sql
         EXECUTE sel_ogb_pre08 INTO l_sumogb917
         IF l_sumogb917  IS NULL THEN LET l_sumogb917 = 0 END IF
        #累計存在於其他出貨單的出貨訂金金額
         LET l_12_oma52 = 0
         IF g_oma.oma16 <> ' ' THEN  #CHI-CB0016
            LET g_sql = " SELECT SUM(oma52) ",
                        "   FROM oma_file ",
                        "  WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),
                        "  WHERE oma16 = ogb01 ",
                        "    AND oma16 <> '",g_ogb.ogb01,"'",
                        "    AND (oma00 = '12' OR oma00 = '19')",
                        "    AND omavoid = 'N' ",
                        "    AND ogb31 = '",g_ogb.ogb31,"' AND omaconf = 'N')"
        #-CHI-CB0016-add-
         ELSE
            LET g_sql = " SELECT SUM(oma52) ",
                        "   FROM oma_file ",
                        "  WHERE oma01 IN (SELECT oma01 FROM oma_file,",cl_get_target_table(g_plant_new,'ogb_file'),
                        "                   WHERE oma16 = ogb01 ",
                        "                     AND oma16 NOT IN (SELECT omb31 FROM omb_file ",
                        "                                        WHERE omb01 = '",g_oma.oma01,"')",
                        "                     AND (oma00 = '12' OR oma00 = '19')",
                        "                     AND omavoid = 'N' ",
                        "                     AND ogb31 = '",l_oea01,"' AND omaconf = 'N')"
         END IF
        #-CHI-CB0016-end-
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_ogb_pre09 FROM g_sql
         EXECUTE sel_ogb_pre09 INTO l_12_oma52
         IF l_12_oma52  IS NULL THEN LET l_12_oma52 = 0 END IF
        #-MOD-BA0227-add-
        #EXECUTE sel_oea_pre INTO l_oea61,l_oea261,l_oea262,l_oea263          #MOD-C90145 mark
         EXECUTE sel_oea_pre INTO l_oea61,l_oea162,l_oea261,l_oea262,l_oea263 #MOD-C90145
        #----------------------MOD-BC0294----------------------start
         IF STATUS THEN     #找不到訂單，表無訂單出貨  #CHI-CB0016 remark
            LET l_oea61 = 0                            #CHI-CB0016 remark
            LET l_oea261 = 0                           #CHI-CB0016 remark
            LET l_oea262 = 0                           #CHI-CB0016 remark
            LET l_oea263 = 0                           #CHI-CB0016 remark
           #-CHI-CB0016-add-
            OPEN p310_oga_cs2
            FETCH FIRST p310_oga_cs2 INTO l_oea162
            CLOSE p310_oga_cs2
           #-CHI-CB0016-end-
         END IF          #CHI-CB0016 remark
        #FUN-C30296--add--str
         LET li_count = 0
         IF g_oma.oma16 <> ' ' THEN  #CHI-CB0016
            LET g_sql = " SELECT COUNT(ogb31) ",
                        "  FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 = '",g_ogb.ogb01,"'",
                        "   AND ogb31 IS NOT NULL"
        #-CHI-CB0016-add-
         ELSE
            LET g_sql = " SELECT COUNT(ogb31) ",
                        "  FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                        " WHERE ogb01 IN (SELECT omb31 FROM omb_file ",
                        "                  WHERE omb01 = '",g_oma.oma01,"')",
                        "   AND ogb31 IS NOT NULL"
         END IF
        #-CHI-CB0016-end-
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_ogb31_pre FROM g_sql
         EXECUTE sel_ogb31_pre INTO li_count
        #IF li_count < 1 THEN                                       #MOD-C90145 mark
         IF li_count < 1 OR (l_oea262 = 0 AND l_oea162 = 100) THEN  #MOD-C90145
        #FUN-C30296--add--end
           #-TQC-C30309-add-
           #LET g_sql = "SELECT oga53 ",        #CHI-CB0016 mark
            LET g_sql = "SELECT SUM(oga53) ",   #CHI-CB0016
                        "  FROM ",cl_get_target_table(g_plant_new,'oga_file'),
                       #" WHERE oga01 = '",g_ogb.ogb01,"'",                    #CHI-CB0016 mark
                        " WHERE oga01 IN (SELECT omb31 FROM omb_file ",        #CHI-CB0016
                        "                  WHERE omb01 = '",g_oma.oma01,"')",  #CHI-CB0016
                        "   AND (oga09 = '3' OR oga09 = '2' OR oga09 = '8')"   #FUN-C60036 add '8'
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
            PREPARE sel_oga_pre FROM g_sql
            EXECUTE sel_oga_pre INTO l_oea262
        #-TQC-C30309-end-
            #FUN-C60036--add--st
            IF cl_null(l_oea262) THEN
               LET g_sql = "SELECT oha53 ",
                           "  FROM ",cl_get_target_table(g_plant_new,'oha_file'),
                           " WHERE oha01 = '",g_ogb.ogb01,"'",
                           "   AND oha09 IN ('1','4','5') "
               CALL cl_replace_sqldb(g_sql) RETURNING g_sql
               CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
               PREPARE sel_oga_pre_1 FROM g_sql
               EXECUTE sel_oga_pre_1 INTO l_oea262
            END IF
            SELECT oaz92 INTO g_oaz.oaz92 FROM oaz_file
            IF cl_null(l_oea262) AND g_aza.aza26 = '2' AND g_oaz.oaz92 = 'Y' THEN
               LET l_oea262 = g_ogb.ogb14
            END IF
         END IF #FUN-C30296 add--end
         IF cl_null(l_oea61) THEN LET l_oea61 = 0 END IF
         IF cl_null(l_oea261) THEN LET l_oea261 = 0 END IF
         IF cl_null(l_oea262) THEN LET l_oea262 = 0 END IF
         IF cl_null(l_oea263) THEN LET l_oea263 = 0 END IF
        #----------------------MOD-BC0294------------------------end
         LET l_oea1008 = l_oea261+l_oea262+l_oea263
         IF g_oma.oma213 = 'Y' THEN
            LET l_oea261t = l_oea261
            LET l_oea263t = l_oea263
            LET l_13_oma54t = (g_oma.oma50t +l_21_omb14t) * l_oea263t / l_oea1008  #MOD-CC0042 add
            LET l_13_oma54  = l_13_oma54t / (1+g_oma.oma211/100)
           #LET l_oea261  = l_oea261t / (1+g_oma.oma211/100)  #MOD-CC0189 mark
            LET l_oea261  = l_oea61                           #MOD-CC0189
            LET l_oea263  = l_oea263t / (1+g_oma.oma211/100)
            CALL cl_digcut(l_oea261,t_azi04) RETURNING l_oea261
            CALL cl_digcut(l_oea263,t_azi04) RETURNING l_oea263
         ELSE
            LET l_13_oma54  = (g_oma.oma50 + l_21_omb14) * l_oea263 / l_oea61   #MOD-CC0042 add
            LET l_13_oma54t = l_13_oma54 * (1+g_oma.oma211/100)
            LET l_oea261t = l_oea261 * (1+g_oma.oma211/100)
            LET l_oea263t = l_oea263 * (1+g_oma.oma211/100)
            CALL cl_digcut(l_oea261t,t_azi04) RETURNING l_oea261t
            CALL cl_digcut(l_oea263t,t_azi04) RETURNING l_oea263t
         END IF
        #FUN-C90105--mod--str
        #LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61   #訂金金額一律以未稅計算
         IF g_ooz.ooz33 = 'N' THEN
            #LET g_oma.oma52 = g_oma.oma50t * l_oea261t /(l_oea61*(1+g_oma.oma211/100))   #訂金金額一律以含稅計算
            LET g_oma.oma52 = 0   #yinhy131211
         ELSE
            LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61   #訂金金額一律以未稅計算
         END IF
        #FUN-C90105--mod--end
         CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52
        #-MOD-BA0227-end-
         CALL cl_digcut(l_13_oma54,t_azi04) RETURNING l_13_oma54
         CALL cl_digcut(l_13_oma54t,t_azi04) RETURNING l_13_oma54t
        #累計出貨訂單的預收待抵淨額
         LET l_oma54  = 0
         IF g_oma.oma16 <> ' ' THEN #CHI-CB0016
            LET g_sql = "SELECT SUM(oma54t-oma55)",
                        "  FROM oma_file ",
                        " WHERE oma16 IN (SELECT ogb31 FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                        "                  WHERE ogb01 = '",g_ogb.ogb01,"')",
                        "   AND oma00='23'"
        #-CHI-CB0016-add-
         ELSE
            LET g_sql = "SELECT SUM(oma54t-oma55)",
                        "  FROM oma_file ",
                        " WHERE oma16 IN (SELECT ogb31 FROM ",cl_get_target_table(g_plant_new,'ogb_file'),
                        "                  WHERE ogb01 IN (SELECT omb31 FROM omb_file ",
                        "                                   WHERE omb01 = '",g_oma.oma01,"'))",
                        "   AND oma00='23'"
         END IF
        #-CHI-CB0016-end-
         CALL cl_replace_sqldb(g_sql) RETURNING g_sql
         CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
         PREPARE sel_oma_23_pre FROM g_sql
         EXECUTE sel_oma_23_pre INTO l_oma54
         IF l_oma54 IS NULL THEN LET l_oma54 = 0 END IF

         IF l_oma54 < g_oma.oma52 OR l_oeb917 <= l_sumogb917+l_ogb917 THEN
            LET g_oma.oma52 = l_oma54 - l_12_oma52    #原幣訂金
         END IF
         LET l_sumoea261 = 0   LET l_sumoea263   =0
         EXECUTE sel_oea26x_pre INTO l_sumoea261,l_sumoea263
         IF cl_null(l_sumoea261) THEN LET l_sumoea261=0 END IF
         IF cl_null(l_sumoea263) THEN LET l_sumoea263=0 END IF
        #-MOD-BA0227-add-
         IF g_oma.oma213 = 'Y' THEN
            LET l_sumoea263t = l_sumoea263
            LET l_sumoea263  = l_sumoea263t / (1+g_oma.oma211/100)
         ELSE
            LET l_sumoea263t = l_sumoea263 * (1+g_oma.oma211/100)
         END IF
         CALL cl_digcut(l_sumoea263,t_azi04) RETURNING l_sumoea263
         CALL cl_digcut(l_sumoea263t,t_azi04) RETURNING l_sumoea263t
        #-MOD-BA0227-end-

         LET l_oea263_1 = 0   LET l_oea263_1t = 0
         LET l_oea263_2 = 0   LET l_oea263_2t = 0
         LET l_oma52    = 0
        #出貨單->訂單,再查這張訂單分幾張出貨單出貨,扣掉之前出貨所佔的尾款,剩下的歸最後一次出貨單
        #ex:原始訂單金額5800,尾款比率10%=>所以尾款金額是580
        #   第一次出貨金額5000,其中尾款佔5000*10%=500
        #   第二次出貨金額1000(有超交),此時尾款應該是580-第一次出貨單的尾款500=80
        #EXECUTE sel_oea26x_1_pre INTO l_oea263_1,l_oea263_1t,l_oea263_2,l_oea263_2t,l_oma52 #MOD-BB0077 mark
         EXECUTE sel_oea26x_1_pre INTO l_oea263_1,l_oea263_1t,l_oea263_2,l_oea263_2t         #MOD-BB0077
         IF cl_null(l_oea263_1)  THEN LET l_oea263_1  = 0 END IF
         IF cl_null(l_oea263_1t) THEN LET l_oea263_1t = 0 END IF
         IF cl_null(l_oea263_2)  THEN LET l_oea263_2  = 0 END IF
         IF cl_null(l_oea263_2t) THEN LET l_oea263_2t = 0 END IF
        #IF cl_null(l_oma52) THEN LET l_oma52=0 END IF   #MOD-BB0077 mark
        #-MOD-C90173-add-
         IF g_oma.oma213 = 'Y' THEN
            LET l_oea263_1t = l_oea263_1t * l_oea263t / l_oea1008
            LET l_oea263_2t = l_oea263_2t * l_oea263t / l_oea1008
            LET l_oea263_1  = l_oea263_1t / (1+g_oma.oma211/100)
            LET l_oea263_2  = l_oea263_2t / (1+g_oma.oma211/100)
         ELSE
            LET l_oea263_1 = l_oea263_1 * l_oea263 / l_oea61
            LET l_oea263_2 = l_oea263_2 * l_oea263 / l_oea61
            LET l_oea263_1t = l_oea263_1 * (1+g_oma.oma211/100)
            LET l_oea263_2t = l_oea263_2 * (1+g_oma.oma211/100)
         END IF
         CALL cl_digcut(l_oea263_1t,t_azi04) RETURNING l_oea263_1t
         CALL cl_digcut(l_oea263_1,t_azi04) RETURNING l_oea263_1
         CALL cl_digcut(l_oea263_2t,g_azi04) RETURNING l_oea263_2t
         CALL cl_digcut(l_oea263_2,g_azi04) RETURNING l_oea263_2
        #-MOD-C90173-end-
        #-MOD-BB0077-add-
         LET l_sumoma54 = 0   LET l_sumoma54t = 0
         LET l_sumoma56 = 0   LET l_sumoma56t = 0
         EXECUTE sel_oea26x_2_pre INTO l_sumoma54,l_sumoma54t,l_sumoma56,l_sumoma56t,l_oma52
         IF cl_null(l_sumoma54)  THEN LET l_sumoma54  = 0 END IF
         IF cl_null(l_sumoma54t) THEN LET l_sumoma54t = 0 END IF
         IF cl_null(l_sumoma56)  THEN LET l_sumoma56  = 0 END IF
         IF cl_null(l_sumoma56t) THEN LET l_sumoma56t = 0 END IF
         IF cl_null(l_oma52) THEN LET l_oma52 = 0 END IF
         LET l_oea263_1  = l_oea263_1  - l_sumoma54
         LET l_oea263_1t = l_oea263_1t - l_sumoma54t
         LET l_oea263_2  = l_oea263_2  - l_sumoma56
         LET l_oea263_2t = l_oea263_2t - l_sumoma56t
        #-MOD-BB0077-end-
         IF l_oea263 > 0 THEN   #MOD-BB0077
           #IF l_sumoea263-l_oea263_1 < cl_digcut((g_oma.oma50*g_oma.oma163/100),t_azi04) THEN  #MOD-BA0227 mark
            IF l_sumoea263-l_oea263_1 < cl_digcut((g_oma.oma50*l_oea263/l_oea61),t_azi04) THEN  #MOD-BA0227
               LET l_13_oma54 = l_sumoea263-l_oea263_1
            ELSE
               LET l_13_oma54 = cl_digcut(((g_oma.oma50+l_21_omb14)*l_oea263/l_oea61),t_azi04)  #MOD-CC0042 add
            END IF
            IF l_sumoea263t-l_oea263_1t < cl_digcut((g_oma.oma50t*l_oea263t/l_oea1008),t_azi04) THEN #MOD-BA0227
               LET l_13_oma54t = l_sumoea263t-l_oea263_1t
            ELSE
               LET l_13_oma54t = cl_digcut(((g_oma.oma50t+l_21_omb14t)*l_oea263t/l_oea1008),t_azi04)  #MOD-CC0042 add
            END IF
         END IF   #MOD-BB0077
         IF cl_null(l_13_oma54)  THEN LET l_13_oma54  = 0 END IF   #MOD-BA0227
         IF cl_null(l_13_oma54t) THEN LET l_13_oma54t = 0 END IF   #MOD-BA0227
        #IF l_sumoea261-l_oma52 < cl_digcut((g_oma.oma50*g_oma.oma161/100),t_azi04) THEN #MOD-BA0227 mark
         IF l_sumoea261-l_oma52 < cl_digcut((g_oma.oma50*l_oea261/l_oea61),t_azi04) THEN #MOD-BA0227
            IF l_sumoea261-l_oma52 < l_oma54 - l_12_oma52 THEN
               LET g_oma.oma52 = l_sumoea261-l_oma52    #原幣訂金
            ELSE
               LET g_oma.oma52 = l_oma54 - l_12_oma52
            END IF
         ELSE
           #LET g_oma.oma52 = g_oma.oma50 * g_oma.oma161/100    #MOD-BA0227 mark
           #LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61  #MOD-BA0227 mark by lixwz 171019 订金判断错误
         END IF
         IF g_check = 'Y' THEN
            LET g_oma.oma52 = 0
         END IF
         CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52
        #--------------------------------CHI-C10018----------------------------------(S)
         IF g_ooz.ooz65 = 'Y' THEN
            LET l_cnt = 0
            IF g_oma.oma16 <> ' ' THEN #CHI-CB0016
               LET g_sql = "SELECT COUNT(*) ",
                      "       FROM ",cl_get_target_table(g_plant_new,'oha_file'),",",
                                     cl_get_target_table(g_plant_new,'ohb_file'),",",
                                     cl_get_target_table(g_plant_new,'oay_file'),
                      "      WHERE oha01 = '",g_ogb.ogb01,"'",
                      "        AND oha01=ohb01 ",
                      "        AND ohaconf='Y' ",
                      "        AND oha01 LIKE trim(oayslip)||'-%' AND oay11='Y'",
                      "        AND oha09 IN ('1','4','5') AND ohapost='Y'"
           #-CHI-CB0016-add-
            ELSE
	       LET g_sql = "SELECT COUNT(*) ",
                      "       FROM ",cl_get_target_table(g_plant_new,'oha_file'),",",
                                     cl_get_target_table(g_plant_new,'ohb_file'),",",
                                     cl_get_target_table(g_plant_new,'oay_file'),
                      "      WHERE oha01 IN (SELECT omb31 FROM omb_file ",
                      "                       WHERE omb01 = '",g_oma.oma01,"')",
                      "        AND oha01=ohb01 ",
                      "        AND ohaconf='Y' ",
                      "        AND oha01 LIKE trim(oayslip)||'-%' AND oay11='Y'",
                      "        AND oha09 IN ('1','4','5') AND ohapost='Y'"
            END IF
           #-CHI-CB0016-end-
            CALL cl_replace_sqldb(g_sql) RETURNING g_sql              #FUN-A50102
            CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql  #FUN-A50102
            PREPARE p310bu_21_p FROM g_sql
            EXECUTE p310bu_21_p INTO l_cnt
            IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
         END IF
        #--------------------------------CHI-C10018----------------------------------(E)
       #IF g_oma.oma00 = '12' THEN                                      #MOD-C20078 mark
       #IF g_oma.oma00 = '12' AND l_oea262 <> 0 THEN                    #MOD-C20078 add          #TQC-C70227 mark
       #IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR (g_azw.azw04 = '2' AND g_occ73 = 'Y')) THEN  #TQC-C70227#CHI-C10018 mark
        #IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR (g_azw.azw04 = '2' AND g_occ73 = 'Y')        #CHI-C10018 add
        #IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR (g_oaz92 = 'Y' AND g_aza.aza26 = '2')        #MOD-D60020
        IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR g_aza.aza26 = '2'        #MOD-D60020   #yinhy130823
                                   OR l_cnt > 0)  THEN                                           #CHI-C10018 add
            IF g_ooz.ooz33 = 'N' AND g_aza.aza26 = '2' AND g_oma.oma161 > 0 THEN      #yinhy131216
            	 #No.yinhy131211  -- Begin
               #LET g_oma.oma52 = g_oma.oma50t * l_oea261t /(l_oea61*(1+g_oma.oma211/100))   #yinhy131211 mark
               #CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52                    #yinhy131211 mark
               #LET g_oma.oma54x = g_oma.oma52 +g_oma.oma54t - ((g_oma.oma52 +g_oma.oma54t)/(1+g_oma.oma211/100))
               #CALL cl_digcut(g_oma.oma54x,t_azi04) RETURNING g_oma.oma54x
               #LET g_oma.oma54 = g_oma.oma54t-g_oma.oma54x
               #CALL cl_digcut(g_oma.oma54,t_azi04) RETURNING g_oma.oma54
               SELECT SUM(omb14),SUM(omb14t),SUM(omb16),SUM(omb16t),SUM(omb18),SUM(omb18t)
                 INTO g_oma.oma50,g_oma.oma50t,g_oma.oma56,g_oma.oma56t,g_oma.oma59,g_oma.oma59t
                 FROM omb_file
                WHERE omb01 = g_oma.oma01
               #yinhy131216  --Begin
               SELECT SUM(omb14)*-1,SUM(omb14t)*-1,SUM(omb16)*-1,SUM(omb16t)*-1,SUM(omb18)*-1,SUM(omb18t)*-1
                 INTO l_21_omb14,l_21_omb14t,l_21_omb16,l_21_omb16t,l_21_omb18,l_21_omb18t
                 FROM omb_file
                WHERE omb01 = g_oma.oma01
                 AND omb38 = '3'
               ##yinhy131216  --End
               IF g_oma.oma50  IS NULL THEN LET g_oma.oma50  = 0 END IF
               IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t = 0 END IF
               IF g_oma.oma56  IS NULL THEN LET g_oma.oma56  = 0 END IF
               IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t = 0 END IF
               IF g_oma.oma59  IS NULL THEN LET g_oma.oma59  = 0 END IF
               IF g_oma.oma59t IS NULL THEN LET g_oma.oma59t = 0 END IF
               IF cl_null(l_21_omb14) THEN LET l_21_omb14 = 0 END IF          #yinhy131216
               IF cl_null(l_21_omb14t) THEN LET l_21_omb14t = 0 END IF        #yinhy131216
               IF cl_null(l_21_omb16) THEN LET l_21_omb16 = 0 END IF          #yinhy131216
               IF cl_null(l_21_omb16t) THEN LET l_21_omb16t = 0 END IF        #yinhy131216
               IF cl_null(l_21_omb18) THEN LET l_21_omb18 = 0 END IF          #yinhy131216
               IF cl_null(l_21_omb18t) THEN LET l_21_omb18t = 0 END IF        #yinhy131216
               LET g_oma.oma52 = 0
               #zhouxm151217 add start
               LET l_n=0
               LET l_dj=0
               SELECT COUNT(*) INTO l_n FROM oma_file
                WHERE oma00 = '23' AND omaud02 = g_oma.omaud02 AND omaconf='Y' AND oma64 = '1'
                IF l_n >0 THEN
                   SELECT SUM(omf29t) INTO l_omf29t
                   FROM omf_file
                   WHERE omf01 = g_oma.oma10 AND omf25= g_oma.omaud02
                   SELECT SUM(oma54t-oma55) INTO l_dj
                    FROM oma_file
                    WHERE oma00 = '23' AND omaud02 = g_oma.omaud02
                    IF l_omf29t >=l_dj THEN
                        LET g_oma.oma51f = l_dj
                    ELSE
                        LET g_oma.oma51f = l_omf29t
                    END IF
                    #UPDATE oma_file SET oma55=oma55 + g_oma.oma51f
                    #WHERE oma00 = '23' AND omaud02 = g_oma.omaud02   #mark by dengsy160328

                   #LET g_oma.oma51f = (g_oma.oma50t+l_21_omb14t) * l_oea261t /(l_oea61*(1+g_oma.oma211/100))
                ELSE
                 LET  g_oma.oma51f =0
                END IF
               #zhouxm151217 add end

               #No:170509 mark begin---------------
               #yinhy131217  --Begin
               #IF g_oma.oma51f = 0 THEN
               #   IF NOT cl_null(g_oma.oma19) THEN
               #      SELECT oma54t,oma56 INTO g_oma.oma51f,g_oma.oma51
               #        FROM oma_file
               #       WHERE oma00 = '11'
               #         AND oma16 = g_oma.oma19
               #    END IF
               #END IF
               #yinhy131217  --End
               #No:170509 mark end---------------
               CALL cl_digcut(g_oma.oma51f,t_azi04) RETURNING g_oma.oma51f
               LET l_14_oma54 =(((g_oma.oma50t+l_21_omb14t) *((g_oma.oma161+g_oma.oma162)/100))+l_21_omb14t)/(1+g_oma.oma211/100)
               LET l_14_oma54x = l_14_oma54 * (g_oma.oma211/100)
               CALL cl_digcut(l_14_oma54,t_azi04) RETURNING l_14_oma54
               CALL cl_digcut(l_14_oma54x,t_azi04) RETURNING l_14_oma54x
               LET l_14_oma54t = l_14_oma54 +  l_14_oma54x - g_oma.oma51f
             #No.yinhy131211  --End
            #FUN-C90105--add--str
            ELSE
           #FUN-C90105--add--end
           #原幣稅額計算
               LET g_oma.oma54 = g_oma.oma50 - g_oma.oma52 - l_13_oma54
               LET l_oma52t = g_oma.oma52 * (1+g_oma.oma211/100)
               CALL cl_digcut(l_oma52t,t_azi04) RETURNING l_oma52t
               LET g_oma.oma54t= g_oma.oma50t - l_oma52t - l_13_oma54t
           #    CALL saxrp310_tax(g_oma.oma54,g_oma.oma54t,'A')    #MOD-BA0227 mod 'B' -> 'A' #150228wudj mark
            #           RETURNING g_oma.oma54,g_oma.oma54t,g_oma.oma54x   #150228wudj mark
               LET g_oma.oma54x= g_oma.oma54t-g_oma.oma54 #150228wudj add
            END IF #FUN-C90105 add
         ELSE
            LET g_oma.oma54 = 0
            LET g_oma.oma54x = 0
            LET g_oma.oma54t = g_oma.oma73f
         END IF
        #本幣計算
         LET g_oma.oma53 = g_oma.oma52 * g_oma.oma24
         #FUN-C90105--add--str
         IF g_ooz.ooz33 = 'N' AND g_aza.aza26 = '2' THEN
         	  #No.yinhy131211  --Begin
            #LET g_oma.oma53 = g_oma.oma53/(1+g_oma.oma211/100)
            #IF g_oma.oma213 = 'N' THEN
            #   LET g_oma.oma53 = g_oma.oma53/(1+g_oma.oma211/100)
            #END IF
            LET g_oma.oma53 = 0
            #No.yinhy131211  --End
         END IF
         #FUN-C90105--add--end
        #-MOD-BA0227-add-
         LET l_oma53t = 0
         LET l_oma53t = g_oma.oma53 * (1+g_oma.oma211/100)
         IF cl_null(l_oma53t) THEN LET l_oma53t = 0 END IF
        #-MOD-BA0227-end-
         IF g_check = 'Y' THEN
            LET g_oma.oma53 = 0
            LET l_oma53t = 0      #MOD-BA0227
         END IF
         CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53
         CALL cl_digcut(l_oma53t,g_azi04) RETURNING l_oma53t          #MOD-BA0227
        #單頭本幣與單身本幣尾差調整
         LET l_sumomb16 = 0    LET l_sumomb16t = 0
         SELECT SUM(omb16),SUM(omb16t) INTO l_sumomb16,l_sumomb16t
           FROM omb_file
          WHERE omb01 = g_oma.oma01
         IF l_sumomb16  IS NULL THEN LET l_sumomb16  = 0 END IF
         IF l_sumomb16t IS NULL THEN LET l_sumomb16t = 0 END IF

        #-MOD-BB0082-mark-可省略,此變數可沿用不須重新抓取
        #LET l_sumoea261  =0   LET l_sumoea263   =0
        #EXECUTE sel_oea26x_pre INTO l_sumoea261,l_sumoea263
        #IF cl_null(l_sumoea261) THEN LET l_sumoea261=0 END IF
        #IF cl_null(l_sumoea263) THEN LET l_sumoea263=0 END IF
        #LET l_sumoea263 = cl_digcut(l_sumoea263*g_oma.oma24,g_azi04)
        #
        #LET l_oea263_1 = 0   LET l_oea263_1t = 0
        #LET l_oea263_2 = 0   LET l_oea263_2t = 0
        #LET l_oma52    = 0
        #出貨單->訂單,再查這張訂單分幾張出貨單出貨,扣掉之前出貨所佔的尾款,剩下的歸最後一次出貨單
        #ex:原始訂單金額5800,尾款比率10%=>所以尾款金額是580
        #   第一次出貨金額5000,其中尾款佔5000*10%=500
        #   第二次出貨金額1000(有超交),此時尾款應該是580-第一次出貨單的尾款500=80
        #EXECUTE sel_oea26x_1_pre INTO l_oea263_1,l_oea263_1t,l_oea263_2,l_oea263_2t,l_oma52
        #IF cl_null(l_oea263_1) THEN LET l_oea263_1=0 END IF
        #IF cl_null(l_oea263_1t) THEN LET l_oea263_1t=0 END IF
        #IF cl_null(l_oea263_2) THEN LET l_oea263_2=0 END IF
        #IF cl_null(l_oea263_2t) THEN LET l_oea263_2t=0 END IF
        #IF cl_null(l_oma52) THEN LET l_oma52=0 END IF
        #-MOD-BB0082-end-
         LET l_sumoea263  = cl_digcut(l_sumoea263*g_oma.oma24,g_azi04)  #MOD-BB0082
         #LET l_sumoea263t = cl_digcut(l_sumoea263*(1+g_oma.oma211/100),g_azi04)  #MOD-BA0227  #yinhy131216 mark

         IF l_oea263 > 0 THEN   #MOD-BB0077
           #l_sumomb16跟l_sumomb16t要考慮有使用尾款使用比率的情況
           #IF l_sumoea263-l_oea263_2 < cl_digcut((l_sumomb16*g_oma.oma163/100),g_azi04) THEN #MOD-BA0227 mark
            IF l_sumoea263-l_oea263_2 < cl_digcut((l_sumomb16*l_oea263/l_oea61),g_azi04) THEN #MOD-BA0227
               LET l_13_oma56 = l_sumoea263-l_oea263_2
            ELSE
              #LET l_13_oma56 = cl_digcut((l_sumomb16*g_oma.oma163/100),g_azi04) #MOD-BA0227 mark
              #LET l_13_oma56 = cl_digcut((l_sumomb16*l_oea263/l_oea61),g_azi04)               #MOD-BA0227 #MOD-CC0042 mark
               LET l_13_oma56 = cl_digcut(((l_sumomb16+l_21_omb16)*l_oea263/l_oea61),g_azi04)  #MOD-CC0042 add
            END IF
           #IF l_sumoea263-l_oea263_2t < cl_digcut((l_sumomb16t*g_oma.oma163/100),g_azi04) THEN     #MOD-BA0227 mark
            IF l_sumoea263t-l_oea263_2t < cl_digcut((l_sumomb16t*l_oea263t/l_oea1008),g_azi04) THEN #MOD-BA0227
               LET l_13_oma56t = l_sumoea263t-l_oea263_2t
            ELSE
              #LET l_13_oma56t = cl_digcut((l_sumomb16t*g_oma.oma163/100),g_azi04)    #MOD-BA0227 mark
              #LET l_13_oma56t = cl_digcut((l_sumomb16t*l_oea263t/l_oea1008),g_azi04)                 #MOD-BA0227 #MOD-CC0042 mark
               LET l_13_oma56t = cl_digcut(((l_sumomb16t+l_21_omb16t)*l_oea263t/l_oea1008),g_azi04)   #MOD-CC0042 add
            END IF
         END IF    #MOD-BB0077
         IF cl_null(l_13_oma56)  THEN LET l_13_oma56  = 0 END IF   #MOD-BA0227
         IF cl_null(l_13_oma56t) THEN LET l_13_oma56t = 0 END IF   #MOD-BA0227
         LET g_oma.oma56 = cl_digcut(g_oma.oma54*g_oma.oma24,g_azi04)
         LET l_oma56 = g_oma.oma53 + g_oma.oma56 + l_13_oma56
         CALL cl_digcut(l_oma56,g_azi04) RETURNING l_oma56
         LET l_oma56 = l_oma56 - l_sumomb16
         IF l_oma56 <> 0 THEN
            LET g_oma.oma56 = g_oma.oma56 - l_oma56
         END IF
         LET g_oma.oma56t= cl_digcut(g_oma.oma54t*g_oma.oma24,g_azi04)
        #LET l_oma56t = g_oma.oma53*(1+g_oma.oma211/100) + g_oma.oma56t + l_13_oma56t #MOD-BA0227 mark
         LET l_oma56t = l_oma53t + g_oma.oma56t + l_13_oma56t  #MOD-BA0227
         CALL cl_digcut(l_oma56t,g_azi04) RETURNING l_oma56t
         LET l_oma56t = l_oma56t - l_sumomb16t
         IF l_oma56t <> 0 THEN
            LET g_oma.oma56t = g_oma.oma56t - l_oma56t
         END IF
         #FUN-C90105--add--str
          IF g_ooz.ooz33 = 'N' AND g_aza.aza26 = '2' AND g_oma.oma161 > 0 THEN
          	 #No.yinhy131211  --Begin
             #LET g_oma.oma53 = g_oma.oma53*(1+g_oma.oma211/100)
             #CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53
             #LET g_oma.oma56x = g_oma.oma53+ g_oma.oma56t - ((g_oma.oma53+ g_oma.oma56t)/(1+g_oma.oma211/100))
             #CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x
             #LET g_oma.oma56 = g_oma.oma56t- g_oma.oma56x
             #CALL cl_digcut(g_oma.oma56,g_azi04) RETURNING g_oma.oma56
             #IF g_oma.oma213 = 'N' THEN
             #   LET g_oma.oma56 = g_oma.oma56 - (g_oma.oma53*( g_oma.oma211/100))
             #   CALL cl_digcut(g_oma.oma56,g_azi04) RETURNING g_oma.oma56
             #   LET g_oma.oma56t = g_oma.oma56t - (g_oma.oma53*( g_oma.oma211/100))
             #   CALL cl_digcut(g_oma.oma56x,g_azi04) RETURNING g_oma.oma56x
             #END IF
             SELECT SUM(omb14),SUM(omb14t),SUM(omb16),SUM(omb16t),SUM(omb18),SUM(omb18t)
                 INTO g_oma.oma50,g_oma.oma50t,g_oma.oma56,g_oma.oma56t,g_oma.oma59,g_oma.oma59t
                 FROM omb_file
                WHERE omb01 = g_oma.oma01
             #yinhy131216  --Begin
             SELECT SUM(omb14)*-1,SUM(omb14t)*-1,SUM(omb16)*-1,SUM(omb16t)*-1,SUM(omb18)*-1,SUM(omb18t)*-1
               INTO l_21_omb14,l_21_omb14t,l_21_omb16,l_21_omb16t,l_21_omb18,l_21_omb18t
               FROM omb_file
              WHERE omb01 = g_oma.oma01
               AND omb38 = '3'

             IF g_oma.oma50  IS NULL THEN LET g_oma.oma50  = 0 END IF
             IF g_oma.oma50t IS NULL THEN LET g_oma.oma50t = 0 END IF
             IF g_oma.oma56  IS NULL THEN LET g_oma.oma56  = 0 END IF
             IF g_oma.oma56t IS NULL THEN LET g_oma.oma56t = 0 END IF
             IF g_oma.oma59  IS NULL THEN LET g_oma.oma59  = 0 END IF
             IF g_oma.oma59t IS NULL THEN LET g_oma.oma59t = 0 END IF
             IF cl_null(l_21_omb14) THEN LET l_21_omb14 = 0 END IF
             IF cl_null(l_21_omb14t) THEN LET l_21_omb14t = 0 END IF
             IF cl_null(l_21_omb16) THEN LET l_21_omb16 = 0 END IF
             IF cl_null(l_21_omb16t) THEN LET l_21_omb16t = 0 END IF
             IF cl_null(l_21_omb18) THEN LET l_21_omb18 = 0 END IF
             IF cl_null(l_21_omb18t) THEN LET l_21_omb18t = 0 END IF
             #yinhy131216  --End
             LET g_oma.oma53 = 0

             #zhouxm151217 add start
               LET l_n=0
               LET l_dj=0
               SELECT COUNT(*) INTO l_n FROM oma_file
                WHERE oma00 = '23' AND omaud02 = g_oma.omaud02 AND omaconf='Y' AND oma64 = '1'
                IF l_n >0 THEN
                   SELECT SUM(omf19t) INTO l_omf19t
                   FROM omf_file
                   WHERE omf01 = g_oma.oma10 AND omf25= g_oma.omaud02
                   SELECT SUM(oma56t-oma57) INTO l_dj
                    FROM oma_file
                    WHERE oma00 = '23' AND omaud02 = g_oma.omaud02
                    IF l_omf19t >=l_dj THEN
                        LET g_oma.oma51 = l_dj
                    ELSE
                        LET g_oma.oma51 = l_omf19t
                    END IF
                    #UPDATE oma_file SET oma57=oma57 + g_oma.oma51    #mark by dengsy160328
                    #WHERE oma00 = '23' AND omaud02 = g_oma.omaud02   #mark by dengsy160328

                ELSE
                 LET  g_oma.oma51 =0
                END IF
               #zhouxm151217 add end
             #LET g_oma.oma51 = (g_oma.oma56t+l_21_omb16t) * l_oea261t /(l_oea61*(1+g_oma.oma211/100))
             #No:170509 mark begin--------------
             #yinhy131217  --Begin
             #IF g_oma.oma51 = 0 THEN
             #   IF NOT cl_null(g_oma.oma19) THEN
             #      SELECT oma54t,oma56 INTO g_oma.oma51f,g_oma.oma51
             #        FROM oma_file
             #       WHERE oma00 = '11'
             #         AND oma16 = g_oma.oma19
             #    END IF
             #END IF
             #yinhy131217  --End
             #No:170509 mark end---------------
             CALL cl_digcut(g_oma.oma51,g_azi04) RETURNING g_oma.oma51
             LET l_14_oma56 = (((g_oma.oma56t+l_21_omb16t) *((g_oma.oma161+g_oma.oma162)/100))+l_21_omb16t)/(1+g_oma.oma211/100)
             LET l_14_oma56x = l_14_oma56 * (g_oma.oma211/100)
             CALL cl_digcut(l_14_oma56,g_azi04) RETURNING l_14_oma56
             CALL cl_digcut(l_14_oma56x,g_azi04) RETURNING l_14_oma56x
             LET l_14_oma56t = l_14_oma56 +  l_14_oma56x - g_oma.oma51
             #No.yinhy131211  --End
          ELSE
         #FUN-C90105--add--end
        #本幣稅額計算
          #  CALL saxrp310_tax(g_oma.oma56,g_oma.oma56t,'B')  #150228wudj mark
           #         RETURNING g_oma.oma56,g_oma.oma56t,g_oma.oma56x  #150228wudj mark
                  LET g_oma.oma56x= g_oma.oma56t-g_oma.oma56 #150228wudj add
          END IF #FUN-C90105 add
        #IF g_oma.oma00='19' THEN                                                              #MOD-C80007 mark
         #IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR l_cnt > 0) THEN                           #MOD-C80007 add
         #IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR l_cnt > 0 OR (g_oaz92 = 'Y' AND g_aza.aza26 = '2')) THEN      #MOD-D60020
         IF g_oma.oma00 = '12' AND (l_oea262 <> 0 OR l_cnt > 0 OR (g_aza.aza26 = '2')) THEN      #yinhy130823
         ELSE                                                                                  #MOD-C80007 add
            LET g_oma.oma56 = 0
            LET g_oma.oma56x = 0
            LET g_oma.oma56t = g_oma.oma73
         END IF
        #發票計算
        #LET g_oma.oma59 = g_oma.oma54 *g_oma.oma58  #MOD-BB0082 mark
        #LET g_oma.oma59t= g_oma.oma54t*g_oma.oma58  #MOD-BB0082 mark
        #-MOD-BB0082-add-
        #單頭發票與單身發票尾差調整
         LET l_sumomb18 = 0    LET l_sumomb18t = 0
         SELECT SUM(omb18),SUM(omb18t) INTO l_sumomb18,l_sumomb18t
           FROM omb_file
          WHERE omb01 = g_oma.oma01
         IF l_sumomb18  IS NULL THEN LET l_sumomb18  = 0 END IF
         IF l_sumomb18t IS NULL THEN LET l_sumomb18t = 0 END IF

         #No.yinhy131216  --Begin
         LET l_sumomb18_1 = 0    LET l_sumomb18t_1 = 0
         SELECT SUM(omb18),SUM(omb18t) INTO l_sumomb18_1,l_sumomb18t_1
           FROM omb_file
          WHERE omb01 = g_oma.oma01
            AND omb38 = '3'
         IF l_sumomb18_1  IS NULL THEN LET l_sumomb18_1  = 0 END IF
         IF l_sumomb18t_1 IS NULL THEN LET l_sumomb18t_1 = 0 END IF
         #No.yinhy131216  --End


         IF l_oea263 > 0 THEN   #MOD-BB0077
           #l_sumomb18跟l_sumomb18t要考慮有使用尾款使用比率的情況
            IF l_sumoea263-l_oea263_2 < cl_digcut((l_sumomb18*l_oea263/l_oea61),g_azi04) THEN
               LET l_13_oma59 = l_sumoea263-l_oea263_2
            ELSE
              #LET l_13_oma59 = cl_digcut((l_sumomb18*l_oea263/l_oea61),g_azi04)               #MOD-CC0042 mark
               LET l_13_oma59 = cl_digcut(((l_sumomb18+l_21_omb18)*l_oea263/l_oea61),g_azi04)  #MOD-CC0042 add
            END IF
            IF l_sumoea263t-l_oea263_2t < cl_digcut((l_sumomb18t*l_oea263t/l_oea1008),g_azi04) THEN
               LET l_13_oma59t = l_sumoea263t-l_oea263_2t
            ELSE
              #LET l_13_oma59t = cl_digcut((l_sumomb18t*l_oea263t/l_oea1008),g_azi04)                #MOD-CC0042 mark
               LET l_13_oma59t = cl_digcut(((l_sumomb18t+l_21_omb18t)*l_oea263t/l_oea1008),g_azi04)  #MOD-CC0042 add
            END IF
         END IF    #MOD-BB0077
         IF cl_null(l_13_oma59)  THEN LET l_13_oma59  = 0 END IF
         IF cl_null(l_13_oma59t) THEN LET l_13_oma59t = 0 END IF
         LET g_oma.oma59 = cl_digcut(g_oma.oma54*g_oma.oma58,g_azi04)
         LET l_oma59 = g_oma.oma53 + g_oma.oma59 + l_13_oma59
         CALL cl_digcut(l_oma59,g_azi04) RETURNING l_oma59
         #LET l_oma59 = l_oma59 - l_sumomb18                 #yinhy131216 mark
         LET l_oma59 = l_oma59 - l_sumomb18 + l_sumomb18_1 + l_sumomb18_1   #yinhy131216
         IF l_oma59 <> 0 THEN
            LET g_oma.oma59 = g_oma.oma59 - l_oma59
         END IF
         LET g_oma.oma59t= cl_digcut(g_oma.oma54t*g_oma.oma58,g_azi04)
         LET l_oma59t = g_oma.oma53*(1+g_oma.oma211/100) + g_oma.oma59t + l_13_oma59t
         CALL cl_digcut(l_oma59t,g_azi04) RETURNING l_oma59t
         #LET l_oma59t = l_oma59t - l_sumomb18t                  #yinhy131216 mark
         LET l_oma59t = l_oma59t - l_sumomb18t + l_sumomb18t_1 +l_sumomb18t_1  #yinhy131216
         IF l_oma59t <> 0 THEN
            LET g_oma.oma59t = g_oma.oma59t - l_oma59t
         END IF
        #-MOD-BB0082-end-
        #發票稅額計算
        # CALL saxrp310_tax(g_oma.oma59,g_oma.oma59t,'C') #150228wudj mark
         #        RETURNING g_oma.oma59,g_oma.oma59t,g_oma.oma59x #150228wudj mark
                     LET g_oma.oma59x= g_oma.oma59t-g_oma.oma59 #150228wudj add
         #FUN-C90105--add--str
        IF g_oma.oma213 = 'N' AND g_ooz.ooz33 = 'N' AND g_aza.aza26 = '2' THEN
           #No.yinhy131211  --Begin
           #LET g_oma.oma53 = g_oma.oma53*(1+g_oma.oma211/100)
           #CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53
            LET g_oma.oma53 = 0
           #No.yinhy131211  --End
        END IF
        #FUN-C90105--add-end
     #-尾款-
      WHEN g_oma.oma00 = '13'        #FUN-B10058
        #-MOD-BA0227-mark-
        #SELECT oea61,oea1008,oea261,oea262,oea263
        #  INTO l_oea61,l_oea1008,l_oea261,l_oea262,l_oea263
        #  FROM oea_file
        # WHERE oea01 = g_oma.oma16
        #EXECUTE sel_oea_pre INTO l_oea61,l_oea1008,l_oea261,l_oea262,l_oea263
        #-MOD-BA0227-end-
        #EXECUTE sel_oea_pre INTO l_oea61,l_oea261,l_oea262,l_oea263          #MOD-BA0227#MOD-C90145 mark
         EXECUTE sel_oea_pre INTO l_oea61,l_oea162,l_oea261,l_oea262,l_oea263 #MOD-C90145
        #----------------------MOD-BC0294-----------------------start
        #IF STATUS THEN     #找不到訂單，表無訂單出貨
        #   LET l_oea61 = 100
        #  #LET l_oea1008 = 100  #MOD-BA0227 mark
        #   LET l_oea261 = 0
        #   LET l_oea262 = 0
        #   LET l_oea263 = 0
        #END IF
         IF cl_null(l_oea61) THEN LET l_oea61 = 0 END IF
         IF cl_null(l_oea261) THEN LET l_oea261 = 0 END IF
         IF cl_null(l_oea262) THEN LET l_oea262 = 0 END IF
         IF cl_null(l_oea263) THEN LET l_oea263 = 0 END IF
        #----------------------MOD-BC0294------------------------end
         LET l_oea1008 = l_oea261+l_oea262+l_oea263   #MOD-BA0227
        #原幣計算
         IF l_oea262=0 AND l_oea263 >0 AND NOT cl_null(g_oma.oma19) THEN
            IF g_oma.oma213 = 'Y' THEN
               LET g_oma.oma52 = g_oma.oma50t * l_oea261 / l_oea1008
            ELSE
              #LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea61   #MOD-BA0227 mark
               LET g_oma.oma52 = g_oma.oma50 * l_oea261 / l_oea1008 #MOD-BA0227
            END IF
            CALL cl_digcut(g_oma.oma52,t_azi04) RETURNING g_oma.oma52
         END IF

         IF g_oma.oma213 = 'Y' THEN
            LET g_oma.oma54t = l_oeaa08
            LET g_oma.oma54  = g_oma.oma54t/(1+ g_oma.oma211/100)
         ELSE
            LET g_oma.oma54  = l_oeaa08
            LET g_oma.oma54t = g_oma.oma54*(1+ g_oma.oma211/100)
         END IF
        #稅額計算
         CALL saxrp310_tax(g_oma.oma54,g_oma.oma54t,'A')    #MOD-BA0227 mod 'B' -> 'A'
                 RETURNING g_oma.oma54,g_oma.oma54t,g_oma.oma54x
        #本幣計算
         LET g_oma.oma56  = g_oma.oma54 * g_oma.oma24
         LET g_oma.oma56t = g_oma.oma54t* g_oma.oma24
         IF l_oea262 = 0 AND l_oea263 > 0 THEN
            LET g_oma.oma53  = g_oma.oma52 * g_oma.oma24
            CALL cl_digcut(g_oma.oma53,g_azi04) RETURNING g_oma.oma53
         END IF
        #本幣稅額計算
         CALL saxrp310_tax(g_oma.oma56,g_oma.oma56t,'B')
                 RETURNING g_oma.oma56,g_oma.oma56t,g_oma.oma56x
        #發票計算
         LET g_oma.oma59  = g_oma.oma54 * g_oma.oma58
         LET g_oma.oma59t = g_oma.oma54t* g_oma.oma58
        #發票稅額計算
         CALL saxrp310_tax(g_oma.oma59,g_oma.oma59t,'C')
                 RETURNING g_oma.oma59,g_oma.oma59t,g_oma.oma59x

     #-代退-
      WHEN g_oma.oma00 = '28'
         LET g_oma.oma54 = 0
         LET g_oma.oma54x = 0
         LET g_oma.oma54t = g_oma.oma73f
         LET g_oma.oma56 = 0
         LET g_oma.oma56x = 0
         LET g_oma.oma56t = g_oma.oma73

     #----------------------MOD-C20141----------start
     #非應收發票
      WHEN g_oma.oma00 = '31'
        LET g_oma.oma54 = g_oma.oma50
        LET g_oma.oma54t= g_oma.oma50t
        LET g_oma.oma55=g_oma.oma54t
        LET g_oma.oma57=g_oma.oma56t
       #原幣稅額計算
        CALL saxrp310_tax(g_oma.oma54,g_oma.oma54t,'A')
                RETURNING g_oma.oma54,g_oma.oma54t,g_oma.oma54x
       #本幣稅額計算
        CALL saxrp310_tax(g_oma.oma56,g_oma.oma56t,'B')
                RETURNING g_oma.oma56,g_oma.oma56t,g_oma.oma56x
       #發票稅額計算
        CALL saxrp310_tax(g_oma.oma59,g_oma.oma59t,'C')
                RETURNING g_oma.oma59,g_oma.oma59t,g_oma.oma59x
     #----------------------MOD-C20141------------end

#150228wudj-str
      WHEN g_oma.oma00 = '21'
         LET g_oma.oma54 = g_oma.oma50
         LET g_oma.oma54t= g_oma.oma50t
         LET g_oma.oma54x= g_oma.oma54t-g_oma.oma54
         LET g_oma.oma56x= g_oma.oma56t-g_oma.oma56
         LET g_oma.oma59x= g_oma.oma59t-g_oma.oma59
#150228wudj-end

      OTHERWISE
        #原幣金額
         LET g_oma.oma54 = g_oma.oma50
         LET g_oma.oma54t= g_oma.oma50t
        #原幣稅額計算
         CALL saxrp310_tax(g_oma.oma54,g_oma.oma54t,'A')
                 RETURNING g_oma.oma54,g_oma.oma54t,g_oma.oma54x
        #本幣稅額計算
         CALL saxrp310_tax(g_oma.oma56,g_oma.oma56t,'B')
                 RETURNING g_oma.oma56,g_oma.oma56t,g_oma.oma56x
        #發票稅額計算
         CALL saxrp310_tax(g_oma.oma59,g_oma.oma59t,'C')
                 RETURNING g_oma.oma59,g_oma.oma59t,g_oma.oma59x

   END CASE

   LET g_oma.oma61 = g_oma.oma56t-g_oma.oma57
   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net
   LET g_oma.oma61 = g_oma.oma61+g_net
   IF cl_null(g_oma.oma53) THEN LET g_oma.oma53 = 0 END IF #FUN-C60036 add
   IF cl_null(g_oma.oma56x) THEN LET g_oma.oma56x = 0 END IF #FUN-C60036 add
   IF cl_null(g_oma.oma54x) THEN LET g_oma.oma54x = 0 END IF #FUN-C60036 add
   #str------ add by dengsy160328
   LET l_count1=0
   LET l_count2=0
   SELECT count(*) INTO l_count1 FROM omb_file WHERE omb01=g_oma.oma01
   SELECT count(*) INTO l_count2 FROM omb_file WHERE omb01=g_oma.oma01 AND omb38='3'
        LET g_oma.oma56x = g_oma.oma56t -g_oma.oma56
#--mark by lifang 170828 begin# 造成单头与单身合计符
#      LET g_oma.oma54=g_oma.oma56/g_oma.oma24
#      LET g_oma.oma54t=g_oma.oma56t/g_oma.oma24
#      LET g_oma.oma54x=g_oma.oma56x/g_oma.oma24
#--mark by lifang 170828 end#
       #No.161226 add begin------
       CALL cl_digcut(g_oma.oma54,g_azi04) RETURNING g_oma.oma54
       CALL cl_digcut(g_oma.oma54t,g_azi04) RETURNING g_oma.oma54t
       CALL cl_digcut(g_oma.oma54x,g_azi04) RETURNING g_oma.oma54x
       #No.161226 add end--------
   IF l_count2<1 THEN
   #end------ add by dengsy160328
   #No.yinhy131211  --Begin
   IF g_oma.oma00 = '12' AND g_ooz.ooz33 = 'N' AND g_aza.aza26 ='2' AND g_oma.oma161 >0  THEN  #yinhy131216
    	LET g_oma.oma54t = l_14_oma54t
    	LET g_oma.oma54x = l_14_oma54x
    	LET g_oma.oma54 = l_14_oma54
      LET g_oma.oma56t = l_14_oma56t
      LET g_oma.oma56x = l_14_oma56x
      LET g_oma.oma56 = l_14_oma56
   END IF
   END IF #add by dengsy160413
   IF cl_null(g_oma.oma51) THEN LET g_oma.oma51 = 0 END IF
   IF cl_null(g_oma.oma51f) THEN LET g_oma.oma51f = 0 END IF
   #str------ add by dengsy161028
   IF g_prog='axrp330' OR g_prog='axmt670' THEN
   LET l_omc08=0
   LET l_omc09=0
   LET l_omc10=0
   LET l_omc11=0
   #SELECT nvl(sum(omc08),0),nvl(sum(omc09),0),nvl(sum(omc10),0),nvl(sum(omc11),0)  #No.170503 mark
   #INTO l_omc08,l_omc09,l_omc10,l_omc11                                            #No.170503 mark
   #No.170503 add begin----------
   SELECT nvl(sum(omc08),0),nvl(sum(omc09),0),nvl(sum(omc10),0),nvl(sum(omc11),0),nvl(sum(omc13),0),nvl(sum(oma61),0)
   INTO l_omc08,l_omc09,l_omc10,l_omc11,l_omc13,l_oma61
   #No.170503 add end------------
   FROM omc_file,oma_file WHERE oma01=omc01 AND omaud02=g_oma.omaud02
   AND oma00='23' AND omavoid<>'Y'
   #No.170417 mark begin-----------
#   #LET g_oma.oma51f=g_oma.oma51f -(l_omc08-l_omc10)
#   LET g_oma.oma51f=g_oma.oma51f -(l_omc10)
#   #LET g_oma.oma51 = g_oma.oma51  -(l_omc09-l_omc11)
#   LET g_oma.oma51 = g_oma.oma51  -(l_omc11)
#   IF g_oma.oma51f<0 THEN
#     LET g_oma.oma51f=0
#   END IF
#   IF g_oma.oma51<0 THEN
#     LET g_oma.oma51=0
#   END IF
   #No.170417 mark end-----------
   #No.170503 mark begin--------
#  #No.170417 add begin----------
#   IF g_oma.oma51f > l_omc10 THEN
#   	  LET g_oma.oma51f = l_omc10
#   END IF
#   IF g_oma.oma51 > l_omc11 THEN
#   	  LET g_oma.oma51 = l_omc11
#   END IF
#   #No.170417 add end------------
   #No.170503 mark end-----------
   #No.170503 add begin---------
   IF l_omc13 >0 AND l_oma61 >0 AND g_oma.oma51f > (l_omc08-l_omc10) THEN
   	  LET g_oma.oma51f = l_omc08-l_omc10
   ELSE
   #	  LET g_oma.oma51f = 0
   END IF
   IF l_omc13 >0 AND l_oma61 >0 AND g_oma.oma51 > (l_omc09-l_omc11) THEN
   	  LET g_oma.oma51 = l_omc09-l_omc11
   ELSE
   #	  LET g_oma.oma51 = 0
   END IF
   #No.170503 add end-----------
  CALL cl_digcut(g_oma.oma51,g_azi04) RETURNING g_oma.oma51
 CALL cl_digcut(g_oma.oma51f,g_azi04) RETURNING g_oma.oma51f
 END IF
   #end------ add by dengsy161028

   #No.yinhy131211  --End
   #str------ add by dengsy160328
   #IF g_oma.oma51f<0 OR g_oma.oma51<0 THEN
   LET g_oma.oma54t=g_oma.oma54+g_oma.oma54x
   LET g_oma.oma56t=g_oma.oma56+g_oma.oma56x
   IF g_oma.oma51f>g_oma.oma54t THEN
     LET g_oma.oma51f=g_oma.oma54t
   END IF
   IF g_oma.oma51>g_oma.oma56t THEN
      LET g_oma.oma51=g_oma.oma56t
   END IF
   LET g_oma.oma54t=g_oma.oma54t-g_oma.oma51f
   LET g_oma.oma56t=g_oma.oma56t-g_oma.oma51
   #END IF
   #No.170417 add begin------------
   LET g_oma.oma61 = g_oma.oma56t-g_oma.oma57
   CALL s_ar_oox03(g_oma.oma01) RETURNING g_net
   LET g_oma.oma61 = g_oma.oma61+g_net
   #No.170417 add end------------
   #No.170405 mark begin-------
#   UPDATE oma_file SET oma55=oma55 + g_oma.oma51f,oma57=oma57 + g_oma.oma51
#                    WHERE oma00 = '23' AND omaud02 = g_oma.omaud02
   #No.170405 mark end----------
   #end------ add by dengsy160328

   UPDATE oma_file SET
          oma50=g_oma.oma50,oma50t=g_oma.oma50t,
          oma73=g_oma.oma73,oma73f=g_oma.oma73f,
          oma52=g_oma.oma52,oma53=g_oma.oma53,
          oma54=g_oma.oma54,oma54x=g_oma.oma54x,oma54t=g_oma.oma54t,
          oma56=g_oma.oma56,oma56x=g_oma.oma56x,oma56t=g_oma.oma56t,
          oma59=g_oma.oma59,oma59x=g_oma.oma59x,oma59t=g_oma.oma59t,
          oma55=g_oma.oma55,oma57=g_oma.oma57,oma61=g_oma.oma61,
          oma51=g_oma.oma51,oma51f=g_oma.oma51f                               #yinhy131211
          WHERE oma01=g_oma.oma01
   IF STATUS OR SQLCA.SQLCODE THEN
      IF g_bgerr THEN
         CALL s_errmsg('oma01',g_oma.oma11,'upd oma50',SQLCA.SQLCODE,1)
      ELSE
         CALL cl_err3("upd","oma_file",g_oma.oma01,"",SQLCA.sqlcode,"","upd oma50",1)
      END IF
      LET g_success='N' RETURN
   END IF
   RETURN g_oma.*
END FUNCTION

FUNCTION saxrp310_tax(p_amt,p_amt_t,p_flag)
   DEFINE p_amt   LIKE oma_file.oma54
   DEFINE p_amt_t lIKE oma_file.oma54t
   DEFINE p_flag  LIKE type_file.chr1
   DEFINE l_amt   LIKE oma_file.oma54
   DEFINE l_amt_t LIKE oma_file.oma54t
   DEFINE l_amtx  LIKE oma_file.oma54
   DEFINE l_amx   LIKE oma_file.oma54x
   DEFINE l_flag  LIKE type_file.chr1
   DEFINE l_azi04 LIKE azi_file.azi04
   DEFINE l_occ73 LIKE occ_file.occ73
   DEFINE l_cnt   LIKE type_file.num10     #FUN-C10055 add
   #FUN-C60036--ad--str
   DEFINE l_oaz92 LIKE oaz_file.oaz92
   DEFINE l_flag1  LIKE type_file.chr1
   #FUN-C60036--ad--end

   LET l_amt = p_amt
   LET l_amt_t = p_amt_t
   LET l_flag = p_flag

  #No.MOD-C30415   ---start---   Add
  #抓取收款客戶的按交款金額產生應收欄位
   LET g_sql = "SELECT occ73 ",
               "  FROM ",cl_get_target_table(g_plant_new,'occ_file'),
               " WHERE occ01 = '",g_oma.oma68,"'"
   CALL cl_replace_sqldb(g_sql) RETURNING g_sql
   CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
   PREPARE sel_occ_prep FROM g_sql
   EXECUTE sel_occ_prep INTO g_occ73  #TQC-BB0019 l_occ73->g_occ73
  #No.MOD-C30415   ---end---     Add

   #MOD-D60156 add begin-------------
   IF cl_null(t_azi04) THEN
      LET g_sql = "SELECT azi04 ",
                  "  FROM ",cl_get_target_table(g_plant_new,'azi_file'),
                  " WHERE azi01 = '",g_oma.oma23,"'"
      CALL cl_replace_sqldb(g_sql) RETURNING g_sql
      CALL cl_parse_qry_sql(g_sql,g_plant_new) RETURNING g_sql
      PREPARE sel_azi04_prep FROM g_sql
      EXECUTE sel_azi04_prep INTO t_azi04
   END IF
   #MOD-D60156 add end-------------
  #l_flag 說明: A-原幣 ; B-本幣 ; C-發票
   IF l_flag = 'A' THEN
      LET l_azi04 = t_azi04
   ELSE
      LET l_azi04 = g_azi04
   END IF

   #FUN-C10055--start add-----------------------------
   IF g_oma.oma70 = '3' THEN
      LET g_mTax = TRUE
   END IF

   IF g_oma.oma70 = '2' THEN
      LET g_mTax = FALSE
   END IF

  #IF g_mTax = TRUE THEN  #FUN-C30296 mark
   IF g_mTax = FALSE THEN #FUN-C30296 add
      IF g_oma.oma00 = '11' OR g_oma.oma00 = '13' THEN
         SELECT COUNT(*) INTO l_cnt
           FROM oeg_file
          WHERE oeg01 = g_oma.oma16
         IF l_cnt > 0 THEN
            LET g_mTax = TRUE
         END IF
      END IF
      IF g_oma.oma00 = '12' THEN
         SELECT COUNT(*) INTO l_cnt
           FROM ogi_file
          WHERE ogi01 = g_oma.oma16
         IF l_cnt > 0 THEN
            LET g_mTax = TRUE
         END IF
      END IF
   END IF
   #FUN-C10055--end add-------------------------------

   #IF g_oma.oma70 = '3' THEN       #FUN-C10055 mark
   #FUN-C60036--ad--str
   LET l_flag1 = 'N'
   SELECT oaz92 INTO l_oaz92 FROM oaz_file
   IF (g_oma.oma00 = '12' OR g_oma.oma00 = '19' OR g_oma.oma00 = '21' OR g_oma.oma00 = '28') AND l_oaz92 = 'Y'
      AND g_aza.aza26 = '2' AND g_oma.oma70 <> '2' THEN   #yinhy130624 add oma70
      LET g_mTax = TRUE
      LET l_flag1 = 'Y'
   END IF
   #FUN-C60036--ad--end
   IF g_mTax = TRUE THEN            #FUN-C10055 add
      LET l_amt = 0   LET l_amt_t = 0
      CASE l_flag
         WHEN 'A'
            SELECT SUM(omb14),SUM(omb14t) INTO l_amt,l_amt_t
              FROM omb_file
             WHERE omb01 = g_oma.oma01
            IF l_amt   IS NULL THEN LET l_amt   = 0 END IF
            IF l_amt_t IS NULL THEN LET l_amt_t = 0 END IF
            #FUN-C60036--add--str--
            IF l_flag1 = 'Y' THEN
               SELECT ABS(SUM(omf29x)) INTO l_amtx FROM omf_file
                WHERE omf04 = g_oma.oma01
            END IF
            #FUN-C60036--add--end
         WHEN 'B'
            SELECT SUM(omb16),SUM(omb16t) INTO l_amt,l_amt_t
              FROM omb_file
             WHERE omb01 = g_oma.oma01
            IF l_amt   IS NULL THEN LET l_amt   = 0 END IF
            IF l_amt_t IS NULL THEN LET l_amt_t = 0 END IF
            #FUN-C60036--add--str--
            IF l_flag1 = 'Y' THEN
               SELECT ABS(SUM(omf19x)) INTO l_amtx FROM omf_file
                WHERE omf04 = g_oma.oma01
            END IF
            #FUN-C60036--add--end
         WHEN 'C'
            SELECT SUM(omb18),SUM(omb18t) INTO l_amt,l_amt_t
              FROM omb_file
             WHERE omb01 = g_oma.oma01
            IF l_amt   IS NULL THEN LET l_amt   = 0 END IF
            IF l_amt_t IS NULL THEN LET l_amt_t = 0 END IF
            #FUN-C60036--add--str--
            IF l_flag1 = 'Y' THEN
               SELECT ABS(SUM(omf19x)) INTO l_amtx FROM omf_file
                WHERE omf04 = g_oma.oma01
            END IF
            #FUN-C60036--add--end
      END CASE

      IF l_flag1 = 'N' THEN #FUN-C60036
         IF g_azw.azw04 = '2' AND g_oma.oma00 = '11' AND g_check = 'Y' AND g_occ73 = 'Y' THEN  #TQC-BB0019 l_occ73->g_occ73
            LET l_amtx = 0
            LET l_amt = l_amt_t
         ELSE
            LET l_amtx = l_amt_t-l_amt
         END IF
      END IF   #FUN-C60036
      CALL cl_digcut(l_amt,l_azi04) RETURNING l_amt
      CALL cl_digcut(l_amt_t,l_azi04) RETURNING l_amt_t
      CALL cl_digcut(l_amtx,l_azi04) RETURNING l_amtx
   ELSE
      IF g_oma.oma213 = 'N'   THEN
         CALL cl_digcut(l_amt,l_azi04) RETURNING l_amt
         IF g_azw.azw04 = '2' AND g_oma.oma00 = '11' AND g_check = 'Y' AND g_occ73 = 'Y' THEN  #TQC-BB0019 l_occ73->g_occ73
            LET l_amtx = 0
         ELSE
            LET l_amtx = l_amt * g_oma.oma211/100
         END IF
         CALL cl_digcut(l_amtx,l_azi04) RETURNING l_amtx
         LET l_amt_t = l_amt + l_amtx
      ELSE
         CALL cl_digcut(l_amt_t,l_azi04) RETURNING l_amt_t
         IF g_azw.azw04 = '2' AND g_oma.oma00 = '11' AND g_check = 'Y' AND g_occ73 = 'Y' THEN  #TQC-BB0019 l_occ73->g_occ73
            LET l_amtx = 0
         ELSE
            LET l_amtx = l_amt_t * g_oma.oma211/(100+g_oma.oma211)
         END IF
         CALL cl_digcut(l_amtx,l_azi04) RETURNING l_amtx
         LET l_amt = l_amt_t - l_amtx
      END IF
   END IF
   RETURN l_amt,l_amt_t,l_amtx
END FUNCTION
#CHI-B90025
