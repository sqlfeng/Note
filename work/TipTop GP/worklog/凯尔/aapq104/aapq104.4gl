# Prog. Version..: '5.30.06-13.03.19(00003)'     #
#
# Pattern name...: aapq104.4gl
# Descriptions...: 入庫金額明細
# Date & Author..: 12/07/26  By Jiangxt
# Modify.........: No.FUN-C80092 12/09/12 By lixh1 增加寫入日誌功能
# Modify.........: No.FUN-C80092 12/09/27 By fengrui 最大筆數控制與excel導出處理
# Modify.........: No.FUN-C80092 12/10/5  By zm 增加插入明细资料功能以便比对axcq100采购入库金额差异
# Modify.........: No.FUN-CA0108 12/10/19 By zhangweib 增加接收背景參數邏輯段,接收:起始日期、截止日期、是否寫入勾稽檔、g_bgjob
# Modify.........: No.FUN-D10022 13/02/21 By xianghui 優化性能
# Modify.........: No.TQC-D30024 13/03/07 By xianghui 動態顯示aqc_amt欄位的名稱
# Modify.........: No.MOD-DC0111 13/12/17 By suncx 修改將本幣金額寫入ckk08
# Modify.........: No.MOD-E10159 14/01/22 By suncx 沒有考慮單位轉化率

DATABASE ds

GLOBALS "../../config/top.global"
DEFINE g_bma DYNAMIC ARRAY OF RECORD
         rvu00    LIKE rvu_file.rvu00,
         rvu01    LIKE rvu_file.rvu01,
         rvu03    LIKE rvu_file.rvu03,
         rvu04    LIKE rvu_file.rvu04,
         pmc03    LIKE pmc_file.pmc03,
         rvv31    LIKE rvv_file.rvv31,
         rvv031   LIKE rvv_file.rvv031,
         ima021   LIKE ima_file.ima021,
         rvv87    LIKE rvv_file.rvv87,
         rvv86    LIKE rvv_file.rvv86,
         rvv38    LIKE rvv_file.rvv38,
         rvv39f   LIKE rvv_file.rvv39,
         rvv39    LIKE rvv_file.rvv39,
         aqc_amt  LIKE type_file.chr1,
         rvb22    LIKE rvb_file.rvb22,
         alow     LIKE type_file.chr1
             END RECORD,
     #FUN-C80092--add--str--
     g_bma_excel  DYNAMIC ARRAY OF RECORD
         rvu00    LIKE rvu_file.rvu00,
         rvu01    LIKE rvu_file.rvu01,
         rvu03    LIKE rvu_file.rvu03,
         rvu04    LIKE rvu_file.rvu04,
         pmc03    LIKE pmc_file.pmc03,
         rvv31    LIKE rvv_file.rvv31,
         rvv031   LIKE rvv_file.rvv031,
         ima021   LIKE ima_file.ima021,
         rvv87    LIKE rvv_file.rvv87,
         rvv86    LIKE rvv_file.rvv86,
         rvv38    LIKE rvv_file.rvv38,
         rvv39f   LIKE rvv_file.rvv39,
         rvv39    LIKE rvv_file.rvv39,
         aqc_amt  LIKE type_file.chr1,
         rvb22    LIKE rvb_file.rvb22,
         alow     LIKE type_file.chr1
             END RECORD,
     #FUN-C80092--add--end--
     g_ckk   RECORD LIKE ckk_file.*,
     g_bma_t DYNAMIC ARRAY OF RECORD
         rvu00    LIKE rvu_file.rvu00,
         rvu01    LIKE rvu_file.rvu01,
         rvu03    LIKE rvu_file.rvu03,
         rvu04    LIKE rvu_file.rvu04,
         pmc03    LIKE pmc_file.pmc03,
         rvv31    LIKE rvv_file.rvv31,
         rvv031   LIKE rvv_file.rvv031,
         ima021   LIKE ima_file.ima021,
         rvv87    LIKE rvv_file.rvv87,
         rvv86    LIKE rvv_file.rvv86,
         rvv38    LIKE rvv_file.rvv38,
         rvv39f   LIKE rvv_file.rvv39,
         rvv39    LIKE rvv_file.rvv39,
         aqc_amt  LIKE type_file.chr1,
         rvb22    LIKE rvb_file.rvb22,
         alow     LIKE type_file.chr1
            END RECORD
DEFINE tm,tm_t  RECORD   #FUN-D10022 add tm_t
           wc       LIKE type_file.chr1000,  #FUN-D10022
           bdate    LIKE type_file.dat,
           edate    LIKE type_file.dat,
           amt_sw   LIKE type_file.chr1,
           allo_sw  LIKE type_file.chr1,
           auto_gen LIKE type_file.chr1
       END RECORD
DEFINE   g_cnt           LIKE type_file.num10
DEFINE   g_sma115        LIKE sma_file.sma115
DEFINE   g_i             LIKE type_file.num5
DEFINE g_sql     STRING
DEFINE g_str     STRING
DEFINE total1    LIKE rvv_file.rvv39
DEFINE total2    LIKE rvv_file.rvv39
#FUN-D10022--add--str--
DEFINE g_rec_b   LIKE type_file.num10
DEFINE g_num     LIKE rvv_file.rvv87
DEFINE g_total1  LIKE rvv_file.rvv39
DEFINE g_total2  LIKE rvv_file.rvv39
#FUN-D10022--add--end--
DEFINE g_cka00   LIKE cka_file.cka00    #FUN-C80092
DEFINE l_flag    LIKE type_file.chr1
DEFINE g_bdate   DATE
DEFINE g_edate   DATE
DEFINE g_msg     STRING   #TQC-D30024

MAIN
DEFINE l_time	     LIKE type_file.chr8
DEFINE l_sl          LIKE type_file.num5
DEFINE p_row,p_col   LIKE type_file.num5

   OPTIONS
      INPUT NO WRAP
   DEFER INTERRUPT

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AAP")) THEN
      EXIT PROGRAM
   END IF

   CALL  cl_used(g_prog,g_time,1) RETURNING g_time

  #No.FUN-CA0108   ---start--- Add
   LET g_bgjob  = ARG_VAL(1)
   LET tm.bdate = ARG_VAL(2)
   LET tm.edate = ARG_VAL(3)
   LET tm.auto_gen = ARG_VAL(4)
  #No.FUN-CA0108   ---end  --- Add

  #No.FUN-CA0108   ---start--- Add
   IF NOT cl_null(g_bgjob) AND g_bgjob = 'Y' THEN
      CALL q104_cs()
   ELSE
  #No.FUN-CA0108   ---end  --- Add
      LET p_row = 2 LET p_col = 18
      OPEN WINDOW aapq104_w AT p_row,p_col
        WITH FORM "aap/42f/aapq104"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

      CALL cl_ui_init()
      CALL q104_menu()
      CLOSE WINDOW q104_w
   END IF   #No.FUN-CA0108   Add
   CALL cl_used(g_prog,g_time,2) RETURNING g_time      #計算使用時間 (退出時間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0055
END MAIN

#FUN-D10022--mark--str--
#FUNCTION q104_cs()
#   DEFINE   l_sql        STRING
#   DEFINE   l_last_sw     LIKE type_file.chr1,    #No.FUN-690028 VARCHAR(1)
#          rvu           RECORD LIKE rvu_file.*,
#          rvv           RECORD LIKE rvv_file.*,
#          l_pmm22       LIKE pmm_file.pmm22,
#          sr           RECORD
#          rva04   LIKE rva_file.rva04,
#          rvb22   LIKE rvb_file.rvb22,
#          rvw05   LIKE rvw_file.rvw05,
#          pmc03   LIKE pmc_file.pmc03,
#          pmm22   LIKE pmm_file.pmm22,
#          ima021  LIKE ima_file.ima021,
#          rvv80   LIKE rvv_file.rvv80,      #FUN-580003
#          rvv82   LIKE rvv_file.rvv82,      #FUN-580003
#          rvv83   LIKE rvv_file.rvv83,      #FUN-580003
#          rvv85   LIKE rvv_file.rvv85       #FUN-580003
#                 END RECORD
#   DEFINE l_i,l_cnt          LIKE type_file.num5
#   DEFINE alow               LIKE type_file.chr1
#   DEFINE l_ima906           LIKE ima_file.ima906
#   DEFINE l_rvv85            STRING
#   DEFINE l_rvv82            STRING
#   DEFINE l_str              STRING
#   DEFINE l_flag             LIKE type_file.chr1   #FUN-750117 add
#   DEFINE l_aqc06            LIKE aqc_file.aqc06   #FUN-750117 add   #分攤前金額
#   DEFINE l_aqc08            LIKE aqc_file.aqc08   #FUN-750117 add   #分攤後金額
#   DEFINE l_aqc_amt          LIKE aqc_file.aqc06   #FUN-750117 add
#   DEFINE l_azw01            LIKE azw_file.azw01   #FUN-A60056
#   DEFINE l_pmm42            LIKE pmm_file.pmm42   #CHI-B30020
#   DEFINE l_num              LIKE rvv_file.rvv87
#   DEFINE l_total1           LIKE rvv_file.rvv39
#   DEFINE l_total2           LIKE rvv_file.rvv39
#   DEFINE  j,k               LIKE type_file.num5,              # No.FUN-690028 SMALLINT
#           i                 LIKE type_file.num10,      #Modi by zm 121207
#           amtf              LIKE apb_file.apb24,              #CHI-B30020
#           amt1,amt11,amt12  LIKE apb_file.apb10,
#           amt2              LIKE apb_file.apb08,   #MOD-840069
#           qty1              LIKE apb_file.apb09
#   DEFINE  l_msg             STRING                 #FUN-C80092
#   CALL cl_opmsg('q')
#
#   SELECT ccz01,ccz02,ccz28 INTO g_ccz.ccz01,g_ccz.ccz02,g_ccz.ccz28 FROM ccz_file
#   CALL s_azm(g_ccz.ccz01,g_ccz.ccz02) RETURNING l_flag,g_bdate,g_edate
#
#   IF cl_null(g_bgjob) OR g_bgjob = 'N' THEN   #No.FUN-CA0108   Add
#   INITIALIZE tm.* TO NULL
#   LET tm.amt_sw = '1'
#   LET tm.allo_sw= '1'
#   LET tm.auto_gen = 'Y'
#   LET tm.bdate = g_bdate
#   LET tm.edate = g_edate
#
#   CALL cl_set_head_visible("","YES")
#
#
#   CALL q104_set_entry_1()
#   CALL q104_set_no_entry_1()
#
#     INPUT BY NAME tm.bdate,tm.edate,tm.amt_sw,tm.allo_sw,tm.auto_gen
#         WITHOUT DEFAULTS
#
#     BEFORE INPUT
#        CALL cl_qbe_init()
#
#         AFTER FIELD bdate
#           CALL q104_set_entry_1()
#           CALL q104_set_no_entry_1()
#
#         AFTER FIELD edate
#           CALL q104_set_entry_1()
#           CALL q104_set_no_entry_1()
#
#         AFTER FIELD amt_sw    #收料金額/AP立帳金額
#            IF tm.amt_sw IS NULL OR tm.amt_sw NOT MATCHES "[12]" THEN
#               NEXT FIELD amt_sw
#            END IF
#
#         AFTER FIELD allo_sw   #分攤前/分攤後
#            IF tm.allo_sw IS NULL OR tm.allo_sw NOT MATCHES "[12]" THEN
#               NEXT FIELD allo_sw
#            END IF
#
#
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
#
#         ON ACTION about
#            CALL cl_about()
#
#         ON ACTION help
#            CALL cl_show_help()
#
#         ON ACTION controlg      #MOD-4C0121
#            CALL cl_cmdask()
#         ON ACTION qbe_select
#      END INPUT
#
#      IF INT_FLAG THEN
#         RETURN
#      END IF
#      CALL cl_set_head_visible("","YES")
#  #No.FUN-CA0108   ---start--- Add
#   ELSE
#      LET tm.amt_sw = '1'
#      LET tm.allo_sw= '1'
#   END IF
#  #No.FUN-CA0108   ---end  --- Add
##FUN-C80092 -----------Begin-------------
#      LET l_msg = "tm.bdate = '",tm.bdate,"'",";","tm.edate = '",tm.edate,"'",";","tm.amt_sw = '",tm.amt_sw,"'",";",
#                  "tm.allo_sw = '",tm.allo_sw,"'",";","tm.auto_gen = '",tm.auto_gen,"'"
#      CALL s_log_ins(g_prog,'','','',l_msg)
#           RETURNING g_cka00
##FUN-C80092 -----------End--------------
#      LET i=1
#      LET l_num = 0
#      LET l_total1=0
#      LET l_total2=0
#      IF tm.auto_gen = 'Y' THEN
#         DELETE FROM ckl_file WHERE ckl07=g_ccz.ccz01 AND ckl08=g_ccz.ccz02 AND ckl01='318'
#      END IF
#      LET l_sql = "SELECT azw01 FROM azw_file ",
#                  " WHERE azwacti = 'Y'",
#                  " AND azw02 = '",g_legal,"'"
#      PREPARE sel_azw FROM l_sql
#      DECLARE sel_azw_cs CURSOR FOR sel_azw
#      FOREACH sel_azw_cs INTO l_azw01
#
#      LET l_sql = "SELECT rvu_file.*, rvv_file.*,",
#                  " rva04, rvb22, '', pmc03,'','',rvv80,rvv82,rvv83,rvv85 ",
#                  " FROM ",cl_get_target_table(l_azw01,'rvu_file'),
#                  " JOIN ",cl_get_target_table(l_azw01,'rvv_file')," ON rvu01=rvv01 ",
#                  " LEFT OUTER JOIN ",cl_get_target_table(l_azw01,'rva_file')," ON rvv04=rva01 ",
#                  " LEFT OUTER JOIN ",cl_get_target_table(l_azw01,'rvb_file')," ON rvv04=rvb01 AND rvv05=rvb02 ",
#                  " LEFT OUTER JOIN pmc_file ON rvu04=pmc01   ",
#                  " WHERE rvu03 BETWEEN '",tm.bdate,"' AND '",tm.edate, "'",
#                  "   AND rvu00 <> '2' ",
#                  "   AND rvuconf !='X'",
#                  " ORDER BY rvu01 "
#        CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#        CALL cl_parse_qry_sql(l_sql,l_azw01) RETURNING l_sql
#        PREPARE aapq104_prepare1 FROM l_sql
#        IF STATUS THEN
#          CALL s_log_upd(g_cka00,'N')             #更新日誌  #FUN-C80092
#          CALL cl_err('prepare:',STATUS,1)
#          CALL cl_used(g_prog,g_time,2) RETURNING g_time
#          EXIT PROGRAM
#        END IF
#        DECLARE aapq104_curs1 CURSOR FOR aapq104_prepare1
#        FOREACH aapq104_curs1 INTO rvu.*,rvv.*,sr.*
#        SELECT ima021 INTO sr.ima021 FROM ima_file
#          WHERE ima01 = rvv.rvv31
#
#         IF cl_null(sr.rvb22) THEN
#            LET sr.rvb22 = rvv.rvv22
#         END IF
#
#	 LET sr.rvw05 = 0
#         SELECT rvw05 INTO sr.rvw05 FROM rvw_file
#           WHERE rvw01=sr.rvb22 AND rvw08=rvv.rvv04 AND rvw09=rvv.rvv05
#         IF sr.rvw05 IS NULL THEN
#            LET sr.rvw05 = 0
#         END IF
#         IF sr.rva04 IS NULL THEN
#            LET sr.rva04 = 'N'
#         END IF
#
#
#          IF tm.amt_sw='1' THEN
#            LET l_sql = "SELECT pmm22,pmm42 ",
#                        "  FROM ",cl_get_target_table(l_azw01,'pmm_file'),
#                        " WHERE pmm01 = '",rvv.rvv36,"'"
#            CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#            CALL cl_parse_qry_sql(l_sql,l_azw01) RETURNING l_sql
#            PREPARE sel_pmm22 FROM l_sql
#            EXECUTE sel_pmm22 INTO sr.pmm22,l_pmm42
#
#            IF SQLCA.sqlcode THEN
#               LET sr.pmm22 = ''
#            END IF
#            LET amtf = rvv.rvv39
#            LET amt1 = rvv.rvv39 * l_pmm42
#            LET amt1 = cl_digcut(amt1,g_azi04)
#         END IF
#         IF tm.amt_sw='2' THEN
#            LET sr.pmm22 = g_aza.aza17
#            IF rvu.rvu00='1' THEN
#               SELECT ABS(SUM(apb24)),ABS(SUM(apb101)),AVG(apb08),ABS(SUM(apb09)) INTO amtf,amt1,amt2,qty1
#                 FROM apa_file,apb_file
#                WHERE apa01=apb01
#                  AND apa00 MATCHES '1*'   #MOD-880112 mark   #MOD-8B0071 mark回復
#                  AND apa42 <> 'Y'         #No.MOD-8B0089
#                  AND apb21=rvv.rvv01
#                  AND apb22=rvv.rvv02
#                  AND apb34= 'N'       #TQC-870027
#               IF cl_null(amtf) THEN LET amtf = 0 END IF   #CHI-B30020
#               IF cl_null(amt1) THEN LET amt1 = 0 END IF
#               IF cl_null(amt2) THEN LET amt2 = 0 END IF   #MOD-840069
#               IF cl_null(qty1) THEN LET qty1 = 0 END IF   #MOD-840069
#            ELSE
#               SELECT SUM(apb24)*-1,SUM(apb101)*-1,AVG(apb08),SUM(apb09)*-1 INTO amtf,amt1,amt2,qty1  #MOD-B60246
#                 FROM apa_file,apb_file   #TQC-620032   #MOD-840069
#                WHERE apa01=apb01
#                  AND apa00 MATCHES '2*' AND apa58!='1'                      #MOD-B60246
#                  AND apa42 <> 'Y'         #No.MOD-8B0089
#                  AND apb21=rvv.rvv01
#                  AND apb22=rvv.rvv02
#                  AND apb34= 'N'       #TQC-870027
#               IF cl_null(amtf) THEN LET amtf = 0 END IF   #CHI-B30020
#               IF cl_null(amt1) THEN LET amt1 = 0 END IF
#               IF cl_null(amt2) THEN LET amt2 = 0 END IF   #MOD-840069
#               IF cl_null(qty1) THEN LET qty1 = 0 END IF   #MOD-840069
#
#               IF amtf = 0 THEN
#                  SELECT SUM(apb24),SUM(apb101),AVG(apb08),SUM(apb09) INTO amtf,amt1,amt2,qty1
#                    FROM apa_file,apb_file
#                   WHERE apa01=apb01
#                     AND apa00 = '11'
#                     AND apa42 <> 'Y'
#                     AND apb21=rvv.rvv01
#                     AND apb22=rvv.rvv02
#                     AND apb34= 'N'
#               END IF
#            END IF
#            LET rvv.rvv38=amt2
#            LET rvv.rvv87=qty1
#            IF cl_null(rvv.rvv87) THEN
#               LET rvv.rvv87 = 0
#            END IF
#
#          END IF
#          LET alow=' '
#           IF rvu.rvu00 MATCHES '[23]' THEN
#             IF rvu.rvu10='Y' THEN
#               LET alow='Y'
#             ELSE
#               LET alow='N'
#             END IF
#           END IF
#
#	 IF cl_null(rvv.rvv031) THEN
#            SELECT ima02 INTO rvv.rvv031 FROM ima_file
#               WHERE ima01 = rvv.rvv31
#            IF SQLCA.SQLCODE THEN
#               LET rvv.rvv031 = ' '
#            END IF
#         END IF
#
#         SELECT ima906 INTO l_ima906 FROM ima_file WHERE ima01=rvv.rvv31
#         LET l_str = ""
#         IF g_sma115 = "Y" THEN
#            CASE l_ima906
#               WHEN "2"
#                   CALL cl_remove_zero(sr.rvv85) RETURNING l_rvv85
#                   LET l_str = l_rvv85 , sr.rvv83 CLIPPED
#                   IF cl_null(sr.rvv85) OR sr.rvv85 = 0 THEN
#                       CALL cl_remove_zero(sr.rvv82) RETURNING l_rvv82
#                       LET l_str = l_rvv82, sr.rvv80 CLIPPED
#                   ELSE
#                      IF NOT cl_null(sr.rvv82) AND sr.rvv82 > 0 THEN
#                         CALL cl_remove_zero(sr.rvv82) RETURNING l_rvv82
#                         LET l_str = l_str CLIPPED,',',l_rvv82, sr.rvv80 CLIPPED
#                      END IF
#                   END IF
#               WHEN "3"
#                   IF NOT cl_null(sr.rvv85) AND sr.rvv85 > 0 THEN
#                       CALL cl_remove_zero(sr.rvv85) RETURNING l_rvv85
#                       LET l_str = l_rvv85 , sr.rvv83 CLIPPED
#                   END IF
#            END CASE
#         END IF
#	  LET l_sql = "SELECT aqc06,aqc08 ",
#                     "  FROM apa_file,apb_file,aqc_file,aqa_file ",  #MOD-BA0019 add
#                     "  WHERE apa01 = apb01 ",
#                     "   AND apb21='",rvv.rvv01,"'",
#                     "   AND apb22= ",rvv.rvv02,
#                     "   AND (apb34 IS NULL OR apb34='N') ",
#                     "   AND (apa00='11' OR (apa00='16' AND apb21 IS NOT NULL)) ",
#                     "   AND apb01=aqc02 ",
#                     "   AND apb02=aqc03 ",    #MOD-880150 mod apb03->apb02
#                     "   AND aqa01 = aqc01 ",  #MOD-BA0019 add
#                     "   AND aqaconf <> 'X' ", #MOD-BA0019 add
#                     " ORDER BY aqc02,aqc03"
# 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
#         PREPARE aapq104_aqc_prep FROM l_sql
#         IF STATUS THEN
#            CALL s_log_upd(g_cka00,'N')             #更新日誌  #FUN-C80092
#            CALL cl_err('aapq104_aqc_prep:',STATUS,1)
#            CALL cl_used(g_prog,g_time,2) RETURNING g_time  #FUN-B80105    ADD
#            EXIT PROGRAM
#         END IF
#         DECLARE aapq104_aqc_cs CURSOR FOR aapq104_aqc_prep
#
#         LET l_flag='N'
#         FOREACH aapq104_aqc_cs INTO l_aqc06,l_aqc08
#            LET l_flag='Y'
#            LET l_aqc_amt = 0   #MOD-8A0102 add
#            IF tm.allo_sw='1' THEN    #分攤前
#               LET l_aqc_amt = l_aqc06
#            ELSE                      #分攤後
#               LET l_aqc_amt = l_aqc08
#            END IF
#            IF cl_null(l_aqc_amt) THEN LET l_aqc_amt = 0 END IF
#         END FOREACH
#
#	  IF l_flag='N' THEN
#            LET l_aqc_amt = 0
#	    IF STATUS THEN
#               CALL cl_err("execute insert_prep:",STATUS,1)
#               EXIT FOREACH
#           END IF
#	  END IF
#           #FUN-C80092--modify--str--  #g_bma->g_bma_excel
#           LET g_bma_excel[i].rvu00 = rvu.rvu00
#           LET g_bma_excel[i].rvu01 = rvu.rvu01
#           LET g_bma_excel[i].rvu03 = rvu.rvu03
#      	   LET g_bma_excel[i].rvu04 = rvu.rvu04
#           LET g_bma_excel[i].pmc03 = sr.pmc03
#           LET g_bma_excel[i].rvv31 = rvv.rvv31
#           LET g_bma_excel[i].rvv031= rvv.rvv031
#           LET g_bma_excel[i].ima021= sr.ima021
#           LET g_bma_excel[i].rvv87 = rvv.rvv87
#           LET g_bma_excel[i].rvv86 = rvv.rvv86
#           LET g_bma_excel[i].rvv38 = rvv.rvv38
#           LET g_bma_excel[i].rvv39f= amtf
#           LET g_bma_excel[i].rvv39 = amt1
#           LET g_bma_excel[i].aqc_amt=l_aqc_amt
#           LET g_bma_excel[i].rvb22 = sr.rvb22
#           LET g_bma_excel[i].alow = alow
#           IF cl_null(g_bma_excel[i].rvv87) THEN LET g_bma_excel[i].rvv87 = 0 END IF
#           IF cl_null(g_bma_excel[i].rvv38) THEN LET g_bma_excel[i].rvv38 = 0 END IF
#           IF cl_null(g_bma_excel[i].rvv39) THEN LET g_bma_excel[i].rvv39 = 0 END IF
#           IF cl_null(g_bma_excel[i].rvv39f) THEN LET g_bma_excel[i].rvv39f = 0 END IF
#           LET l_num =l_num + g_bma_excel[i].rvv87
#           LET l_total1=l_total1+g_bma_excel[i].rvv39f
#           LET l_total2=l_total2+g_bma_excel[i].rvv39
#           IF tm.auto_gen = 'Y' THEN
#              INSERT INTO ckl_file VALUES('318',rvu.rvu01,0,'',g_bma_excel[i].rvv87,g_bma_excel[i].rvv39,g_ccz.ccz01,g_ccz.ccz02)
#           END IF
#           #FUN-C80092--modify--end--
#           #FUN-C80092--add--str--
#           IF i <= g_max_rec THEN
#              LET g_bma[i].* = g_bma_excel[i].*
#           END IF
#           #FUN-C80092--add--end--
#           LET i=i+1
#     END FOREACH
#   END FOREACH
#   #FUN-C80092--add--str--
#   IF i <= g_max_rec THEN
#      CALL g_bma.deleteElement(i)
#   END IF
#   CALL g_bma_excel.deleteElement(i)
#   LET i = i - 1
#   IF i > g_max_rec AND (g_bgjob='N' OR g_bgjob is null) THEN
#      CALL cl_err_msg(NULL,"axc-131",i||"|"||g_max_rec,10)
#      LET i = g_max_rec
#   END IF
#   #FUN-C80092--add--end--
#   IF cl_null(g_bgjob) OR g_bgjob = 'N' THEN #No.FUN-CA0108   Add
#   DISPLAY i TO cn2
#   DISPLAY l_num TO num
#   DISPLAY l_total1 TO total1
#   DISPLAY l_total2 TO total2
#   END IF                                    #No.FUN-CA0108   Add
#
#   IF tm.auto_gen = 'Y' THEN
#      CALL s_ckk_fill('','318','axc-463',g_ccz.ccz01,g_ccz.ccz02,g_prog,g_ccz.ccz28,l_num,l_total2,l_total2,0,0,0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')
#            RETURNING g_ckk.*
#      IF NOT s_ckk(g_ckk.*,'') THEN END IF
#   END IF
#
#   CALL s_log_upd(g_cka00,'Y')             #更新日誌  #FUN-C80092
#END FUNCTION
#FUN-D10022--mark--end--
#FUN-D10022--add--str--
FUNCTION q104_cs()
DEFINE l_sql        STRING
DEFINE l_flag       LIKE type_file.chr1


   CALL cl_opmsg('q')
   SELECT ccz01,ccz02,ccz28 INTO g_ccz.ccz01,g_ccz.ccz02,g_ccz.ccz28 FROM ccz_file
   CALL s_azm(g_ccz.ccz01,g_ccz.ccz02) RETURNING l_flag,g_bdate,g_edate
   LET tm_t.* = tm.*
   CLEAR FORM   #清除畫面
   CALL cl_opmsg('q')
   INITIALIZE tm.* TO NULL
   LET tm.amt_sw = '1'
   LET tm.allo_sw= '1'
   CALL cl_getmsg('aap-783',g_lang) RETURNING g_msg     #TQC-D30024
   CALL cl_set_comp_att_text("aqc_amt",g_msg CLIPPED)   #TQC-D30024
   LET tm.auto_gen = 'Y'
   LET tm.bdate = g_bdate
   LET tm.edate = g_edate
   CALL cl_set_head_visible("","YES")
   CALL q104_set_entry_1()
   CALL q104_set_no_entry_1()

   DIALOG ATTRIBUTE(UNBUFFERED)
      INPUT BY NAME tm.bdate,tm.edate,tm.amt_sw,tm.allo_sw,tm.auto_gen ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL cl_qbe_init()

         AFTER FIELD bdate
           CALL q104_set_entry_1()
           CALL q104_set_no_entry_1()
           IF NOT cl_null(tm.bdate) AND NOT cl_null(tm.edate) THEN
              IF tm.edate < tm.bdate THEN
                 CALL cl_err('','agl-031',0)
              END IF
           END IF

         AFTER FIELD edate
           CALL q104_set_entry_1()
           CALL q104_set_no_entry_1()
           IF NOT cl_null(tm.bdate) AND NOT cl_null(tm.edate) THEN
              IF tm.edate < tm.bdate THEN
                 CALL cl_err('','agl-031',0)
              END IF
           END IF

         AFTER FIELD amt_sw    #收料金額/AP立帳金額
            IF tm.amt_sw IS NULL OR tm.amt_sw NOT MATCHES "[12]" THEN
               NEXT FIELD amt_sw
            END IF

         AFTER FIELD allo_sw   #分攤前/分攤後
            IF tm.allo_sw IS NULL OR tm.allo_sw NOT MATCHES "[12]" THEN
               NEXT FIELD allo_sw
            END IF
         #TQC-D30024--add--str--
         ON CHANGE allo_sw
            IF tm.allo_sw ='1' THEN
               CALL cl_getmsg('aap-783',g_lang) RETURNING g_msg
               CALL cl_set_comp_att_text("aqc_amt",g_msg CLIPPED)
            ELSE
               CALL cl_getmsg('aap-784',g_lang) RETURNING g_msg
               CALL cl_set_comp_att_text("aqc_amt",g_msg CLIPPED)
            END IF
         #TQC-D30024--add--end--

      END INPUT
      CONSTRUCT tm.wc ON rvu00,rvu01,rvu03,rvu04,rvv31,rvv86,rvb22
                    FROM s_bma[1].rvu00,s_bma[1].rvu01,s_bma[1].rvu03,
                         s_bma[1].rvu04,s_bma[1].rvv31,s_bma[1].rvv86,s_bma[1].rvb22
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
      END CONSTRUCT

      ON ACTION controlp
         CASE
            WHEN INFIELD(rvu01)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_rvu01_2"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvu01
               NEXT FIELD rvu01
            WHEN INFIELD(rvu04)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_rvu04"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvu04
               NEXT FIELD rvu04
            WHEN INFIELD(rvv31)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_ima"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvv31
               NEXT FIELD rvv31
            WHEN INFIELD(rvv86)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gfe"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvv86
               NEXT FIELD rvv86
            WHEN INFIELD(rvb22)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_rvb2"
               LET g_qryparam.state = "c"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO rvb22
               NEXT FIELD rvb22
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

      ON ACTION ACCEPT
         ACCEPT DIALOG

      ON ACTION CANCEL
         LET INT_FLAG = 1
         EXIT DIALOG
   END DIALOG
   LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('imauser', 'imagrup')
   IF INT_FLAG THEN
      LET tm.* = tm_t.*
      LET INT_FLAG = 0
   END IF
   CALL q104()
END FUNCTION
#FUN-D10022--add--end--

FUNCTION q104_menu()
    WHILE TRUE
      CALL q104_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL q104_q()
            END IF
         WHEN "locale"                 #FUN-D10022
            CALL cl_dynamic_locale()   #FUN-D10022
            CALL cl_show_fld_cont()    #FUN-D10022
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"
            IF cl_chk_act_auth() THEN
            CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_bma_excel),'','')
            END IF
     END CASE
   END WHILE
END FUNCTION

FUNCTION q104_q()
    MESSAGE ""
    CALL cl_opmsg('q')
    CALL q104_cs()
    #FUN-D10022--add--str--
    IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
    MESSAGE "SERCHING!"
    MESSAGE ""
    CALL q104_show()
    #FUN-D10022--add--end--
END FUNCTION

#FUN-D10022--add--str--
FUNCTION q104()
DEFINE  l_msg     STRING,
        l_sql     STRING,
        l_azw01   LIKE azw_file.azw01

   IF NOT cl_null(g_bgjob) AND g_bgjob = 'Y' THEN
      LET tm.amt_sw = '1'
      LET tm.allo_sw= '1'
      CALL cl_getmsg('aap-783',g_lang) RETURNING g_msg    #TQC-D30024
      CALL cl_set_comp_att_text("aqc_amt",g_msg CLIPPED)  #TQC-D30024
   END IF

   CALL q104_table()

   LET l_msg = "tm.bdate = '",tm.bdate,"'",";","tm.edate = '",tm.edate,"'",";","tm.amt_sw = '",tm.amt_sw,"'",";",
               "tm.allo_sw = '",tm.allo_sw,"'",";","tm.auto_gen = '",tm.auto_gen,"'"
   CALL s_log_ins(g_prog,'','','',l_msg) RETURNING g_cka00


   LET g_num = 0
   LET g_total1=0
   LET g_total2=0
   IF tm.auto_gen = 'Y' THEN
      DELETE FROM ckl_file WHERE ckl07=g_ccz.ccz01 AND ckl08=g_ccz.ccz02 AND ckl01='318'
   END IF
   LET l_sql = "SELECT azw01 FROM azw_file ",
               " WHERE azwacti = 'Y'",
               " AND azw02 = '",g_legal,"'"
   PREPARE sel_azw FROM l_sql
   DECLARE sel_azw_cs CURSOR FOR sel_azw
   FOREACH sel_azw_cs INTO l_azw01
      LET l_sql = "SELECT rvu00,rvu01,rvu03,rvu04,pmc03,rvv31,rvv031,ima021,",
                  "       (CASE WHEN rvu00=1 THEN rvv87 ELSE rvv87*-1 END),rvv86,rvv38,(CASE WHEN rvu00=1 THEN rvv39 ELSE rvv39*-1 END) rvv39f,(CASE WHEN rvu00=1 THEN rvv39 ELSE rvv39*-1  END) rvv39,0,rvb22,'',rvv02,'",l_azw01,"'",      #yinhy130711
                  ",ima25",    #MOD-E10159 add
                  " FROM ",cl_get_target_table(l_azw01,'rvu_file'),
                  " LEFT OUTER JOIN pmc_file ON rvu04=pmc01 ,",cl_get_target_table(l_azw01,'rvv_file'),
                  " LEFT OUTER JOIN ",cl_get_target_table(l_azw01,'rva_file')," ON rvv04=rva01 ",
                  " LEFT OUTER JOIN ",cl_get_target_table(l_azw01,'rvb_file')," ON rvv04=rvb01 AND rvv05=rvb02 ",
                  " LEFT OUTER JOIN ima_file ON rvv31=ima01 ",
                  " WHERE rvu01=rvv01 AND rvu03 BETWEEN '",tm.bdate,"' AND '",tm.edate, "'",
                  "   AND ",tm.wc CLIPPED,
                  "   AND rvu00 <> '2' ",
                  "   AND rvuconf !='X'",
                  " ORDER BY rvu01 "

      LET l_sql = " INSERT INTO q104_tmp  ",l_sql CLIPPED
      PREPARE q104_ins FROM l_sql
      EXECUTE q104_ins

      IF tm.amt_sw='1' THEN
         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT pmm42,rvv01,rvv02 FROM ",cl_get_target_table(l_azw01,'pmm_file')," a,",
                                                            cl_get_target_table(l_azw01,'rvv_file')," b ",
                     "             WHERE a.pmm01 = b.rvv36 ) x ",
                     "    ON (o.rvu01=x.rvv01 AND o.rvv02=x.rvv02 )",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET o.rvv39 = o.rvv39 * x.pmm42 ",
                     "     WHERE o.azw01 = '",l_azw01,"'"
         PREPARE upd_rvv39_01 FROM l_sql
         EXECUTE upd_rvv39_01
      END IF

      IF tm.amt_sw='2' THEN
         UPDATE q104_tmp
            SET rvv87 = 0,
                rvv38 = 0
          WHERE azw01 = l_azw01
         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT apb21,apb22,ABS(SUM(apb24)) amtf,ABS(SUM(apb101)) amt,",
                     "                   AVG(apb08) amt2,ABS(SUM(apb09)) qty1 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),
                     "             WHERE apa01=apb01 AND apa00 LIKE '1%' ",
                     # ************************
                     "                   AND apa42 <> 'Y' AND apb34= 'N' GROUP BY apb21,apb22 ) x",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET rvv39f = x.amtf," ,
                     "           rvv39  = x.amt,",
                     "           rvv38  = x.amt2,",
                     "           rvv87  = x.qty1",
                     "     WHERE o.rvu00 ='1' AND o.azw01='",l_azw01,"'"
         PREPARE upd_rvv39_02 FROM l_sql
         EXECUTE upd_rvv39_02

         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT apb21,apb22,SUM(apb24)*-1 amtf,SUM(apb101)*-1 amt,",
                     "                   AVG(apb08) amt2,SUM(apb09)*-1 qty1 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),
                     "             WHERE apa01=apb01 AND apa00 LIKE '2%' AND apa58!='1' ",
                     "                   AND apa42 <> 'Y' AND apb34= 'N' GROUP BY apb21,apb22  ) x",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET rvv39f = x.amtf," ,          #yinhy130711
                     "           rvv39  = x.amt,",            #yinhy130711
                     "           rvv38  = x.amt2,",
                     "           rvv87  = x.qty1",            #yinhy130711
                     "     WHERE o.rvu00 <>'1' AND o.azw01 = '",l_azw01,"'"
         PREPARE upd_rvv39_03 FROM l_sql
         EXECUTE upd_rvv39_03

         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT apb21,apb22,SUM(apb24) amtf,SUM(apb101) amt,",
                     "                   AVG(apb08) amt2,SUM(apb09) qty1 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),
                     "             WHERE apa01=apb01 AND apa00 ='11'",
                     "                   AND apa42 <> 'Y' AND apb34= 'N' GROUP BY apb21,apb22 ) x",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET rvv39f = x.amtf * -1," ,    #yinhy130711
                     "           rvv39  = x.amt * -1,",      #yinhy130711
                     "           rvv38  = x.amt2,",
                     "           rvv87  = x.qty1 * -1",      #yinhy130711
                     "     WHERE o.rvu00 <>'1' AND rvv39f = 0 AND o.azw01='",l_azw01,"'"
         PREPARE upd_rvv39_04 FROM l_sql
         EXECUTE upd_rvv39_04

         # add by lixwz 20171015 s
         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT apb21,apb22,SUM(apb24) amtf,SUM(apb101) amt,",
                     "                   AVG(apb08) amt2,SUM(apb09) qty1 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),
                     "             WHERE apa01=apb01 AND apa00 ='11' AND apb29 ='3'",
                     "                   AND apa42 <> 'Y' AND apb34= 'N' GROUP BY apb21,apb22 ) x",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET rvv39f = x.amtf ," ,    #yinhy130711
                     "           rvv39  = x.amt ,",      #yinhy130711
                     "           rvv38  = x.amt2,",
                     "           rvv87  = x.qty1 ",      #yinhy130711
                     "     WHERE o.rvu00 <>'1'  AND o.azw01='",l_azw01,"'"
         PREPARE upd_rvv39_05 FROM l_sql
         EXECUTE upd_rvv39_05
         # add by lixwz 20171915 e
      END IF

      LET l_sql = "MERGE INTO q104_tmp o ",
                  "     USING (SELECT rvu01,rvu10 ",
                  "              FROM ",cl_get_target_table(l_azw01,'rvu_file'),") x ",
                  "        ON (o.rvu01 = x.rvu01)",
                  " WHEN MATCHED ",
                  " THEN ",
                  "    UPDATE ",
                  "       SET o.alow = x.rvu10 " ,
                  "     WHERE o.rvu00 IN( '2','3') AND o.azw01='",l_azw01,"'"
      PREPARE upd_alow FROM l_sql
      EXECUTE upd_alow

      LET l_sql = "UPDATE q104_tmp o",
                  "   SET rvv031 = (SELECT ima02 FROM ",cl_get_target_table(l_azw01,'ima_file')," WHERE ima01 = o.rvv31)",
                  " WHERE rvv031 IS NULL  AND azw01='",l_azw01,"'"
      PREPARE upd_rvv031 FROM l_sql
      EXECUTE upd_rvv031

      IF tm.allo_sw='1' THEN
         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT aqc06,apb21,apb22 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),",",
                                           cl_get_target_table(l_azw01,'aqc_file'),",",
                                           cl_get_target_table(l_azw01,'aqa_file'),
                     "             WHERE apa01=apb01 AND (apa00='11' OR (apa00='16' AND apb21 IS NOT NULL)) ",
                     "               AND (apb34 IS NULL OR apb34='N') ",
                     "               AND apb01=aqc02 ",
                     "               AND apb02=aqc03 ",
                     "               AND aqa01 = aqc01 ",
                     "               AND aqaconf <> 'X' ",
                     "               ORDER BY aqc02,aqc03 ) x",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET o.aqc_amt = x.aqc06 ",
                     "     WHERE o.azw01='",l_azw01,"'"
         PREPARE upd_aqc_amt01 FROM l_sql
         EXECUTE upd_aqc_amt01
      ELSE
         LET l_sql = "MERGE INTO q104_tmp o ",
                     "     USING (SELECT aqc08,apb21,apb22 ",
                     "              FROM ",cl_get_target_table(l_azw01,'apa_file'),",",
                                           cl_get_target_table(l_azw01,'apb_file'),",",
                                           cl_get_target_table(l_azw01,'aqc_file'),",",
                                           cl_get_target_table(l_azw01,'aqa_file'),
                     "             WHERE apa01=apb01 AND (apa00='11' OR (apa00='16' AND apb21 IS NOT NULL)) ",
                     "               AND (apb34 IS NULL OR apb34='N') ",
                     "               AND apb01=aqc02 ",
                     "               AND apb02=aqc03 ",
                     "               AND aqa01 = aqc01 ",
                     "               AND aqaconf <> 'X') x ",
                     "        ON (o.rvu01 = x.apb21 AND o.rvv02 = x.apb22)",
                     " WHEN MATCHED ",
                     " THEN ",
                     "    UPDATE ",
                     "       SET o.aqc_amt = x.aqc08 ",
                     "     WHERE o.azw01='",l_azw01,"'"
         PREPARE upd_aqc_amt02 FROM l_sql
         EXECUTE upd_aqc_amt02
      END IF
   END FOREACH


   SELECT SUM(rvv87),SUM(rvv39f),SUM(rvv39) INTO g_num,g_total1,g_total2
     FROM q104_tmp

   IF tm.auto_gen = 'Y' THEN
     #CALL s_ckk_fill('','318','axc-463',g_ccz.ccz01,g_ccz.ccz02,g_prog,g_ccz.ccz28,g_num,g_total1,g_total2,0,0,0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')  #MOD-DC0111 mark
      CALL s_ckk_fill('','318','axc-463',g_ccz.ccz01,g_ccz.ccz02,g_prog,g_ccz.ccz28,g_num,g_total2,g_total1,0,0,0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')  #MOD-DC0111 add
            RETURNING g_ckk.*
      IF NOT s_ckk(g_ckk.*,'') THEN END IF
   END IF

   CALL s_log_upd(g_cka00,'Y')
END FUNCTION

FUNCTION q104_b_fill()
DEFINE l_sql    STRING,
       l_rvv02  LIKE rvv_file.rvv02,
       l_azw01  LIKE azw_file.azw01
DEFINE l_qty    LIKE ckl_file.ckl05,    #MOD-E10159
       l_ima25  LIKE ima_file.ima25,    #MOD-E10159
       l_flag   LIKE type_file.num5,    #MOD-E10159
       l_factor LIKE type_file.num26_10 #MOD-E10159

   CALL g_bma.clear()
   CALL g_bma_excel.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   LET l_sql = " SELECT * FROM q104_tmp "
   PREPARE q104_cs FROM l_sql
   DECLARE q104_cr CURSOR FOR q104_cs
  #FOREACH q104_cr INTO g_bma_excel[g_cnt].*,l_rvv02,l_azw01
   FOREACH q104_cr INTO g_bma_excel[g_cnt].*,l_rvv02,l_azw01,l_ima25 #MOD-E10159 add l_ima25
      IF cl_null(g_bma_excel[g_cnt].rvv87)  THEN LET g_bma_excel[g_cnt].rvv87 = 0 END IF
      IF cl_null(g_bma_excel[g_cnt].rvv38)  THEN LET g_bma_excel[g_cnt].rvv38 = 0 END IF
      IF cl_null(g_bma_excel[g_cnt].rvv39)  THEN LET g_bma_excel[g_cnt].rvv39 = 0 END IF
      IF cl_null(g_bma_excel[g_cnt].rvv39f) THEN LET g_bma_excel[g_cnt].rvv39f = 0 END IF

      IF tm.auto_gen = 'Y' THEN
         #MOD-E10159 add begin-----------------------
         CALL s_umfchk(g_bma_excel[g_cnt].rvv31,g_bma_excel[g_cnt].rvv86,l_ima25) RETURNING l_flag,l_factor
         IF l_flag THEN
            LET l_factor = 1
         END IF
         LET l_qty = g_bma_excel[g_cnt].rvv87 * l_factor
         #MOD-E10159 add end-------------------------
         INSERT INTO ckl_file VALUES('318',g_bma_excel[g_cnt].rvu01,0,'',
                                #g_bma_excel[g_cnt].rvv87,g_bma_excel[g_cnt].rvv39,g_ccz.ccz01,g_ccz.ccz02)
                                 l_qty,g_bma_excel[g_cnt].rvv39,g_ccz.ccz01,g_ccz.ccz02)  #MOD-E10159 g_bma_excel[g_cnt].rvv87 -> l_qty
      END IF
      IF g_cnt <= g_max_rec THEN
         LET g_bma[g_cnt].* = g_bma_excel[g_cnt].*
      END IF
      LET g_cnt=g_cnt+1
   END FOREACH
   IF g_cnt <= g_max_rec THEN
      CALL g_bma.deleteElement(g_cnt)
   END IF
   CALL g_bma_excel.deleteElement(g_cnt)
   LET g_cnt = g_cnt - 1
   LET g_rec_b = g_cnt
   IF g_cnt > g_max_rec AND (g_bgjob='N' OR g_bgjob is null) THEN
      CALL cl_err_msg(NULL,"axc-131",g_cnt||"|"||g_max_rec,10)
      LET g_cnt = g_max_rec
   END IF
END FUNCTION

FUNCTION q104_table()
   DROP TABLE q104_tmp;
   CREATE TEMP TABLE q104_tmp(
         rvu00    LIKE rvu_file.rvu00,
         rvu01    LIKE rvu_file.rvu01,
         rvu03    LIKE rvu_file.rvu03,
         rvu04    LIKE rvu_file.rvu04,
         pmc03    LIKE pmc_file.pmc03,
         rvv31    LIKE rvv_file.rvv31,
         rvv031   LIKE rvv_file.rvv031,
         ima021   LIKE ima_file.ima021,
         rvv87    LIKE rvv_file.rvv87,
         rvv86    LIKE rvv_file.rvv86,
         rvv38    LIKE rvv_file.rvv38,
         rvv39f   LIKE rvv_file.rvv39,
         rvv39    LIKE rvv_file.rvv39,
         aqc_amt  LIKE type_file.chr1,
         rvb22    LIKE rvb_file.rvb22,
         alow     LIKE type_file.chr1,
         rvv02    LIKE rvv_file.rvv02,
         azw01    LIKE azw_file.azw01,
         ima25    LIKE ima_file.ima25)  #MOD-E10159
END FUNCTION

FUNCTION q104_show()

   CALL q104_b_fill()
   DISPLAY g_rec_b TO cn2
   DISPLAY g_num TO num
   DISPLAY g_total1 TO total1
   DISPLAY g_total2 TO total2
   CALL cl_show_fld_cont()
END FUNCTION
#FUN-D10022--add--end--

FUNCTION q104_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-690028 VARCHAR(1)

   IF p_ud <> "G" THEN
      RETURN
   END IF

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_bma TO s_bma.*

      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY

      ON ACTION locale
         LET g_action_choice="locale"  #FUN-D10022
         #CALL cl_dynamic_locale()                                      #FUN-D10022
         #CALL cl_show_fld_cont()                   #No.FUN-550037 hmf  #FUN-D10022
         EXIT DISPLAY

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION cancel
         LET INT_FLAG=FALSE 		#MOD-570244	mars
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      AFTER DISPLAY
         CONTINUE DISPLAY
      END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
#No.FUN-9C0077 程式精簡

FUNCTION q104_set_entry_1()
    CALL cl_set_comp_entry("auto_gen",TRUE)
END FUNCTION

FUNCTION q104_set_no_entry_1()
    IF tm.bdate <> g_bdate OR tm.edate <> g_edate  THEN
       CALL cl_set_comp_entry("auto_gen",FALSE)
       LET tm.auto_gen = 'N'
       DISPLAY BY NAME tm.auto_gen
    END IF
END FUNCTION
