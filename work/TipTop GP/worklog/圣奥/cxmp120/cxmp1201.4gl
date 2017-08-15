# Prog. Version..: '5.25.02-11.04.26(00010)'     #
#
# Pattern name...: cxmp12.4gl
# Descriptions...: 客戶出货應收回款统计更新作业
# Date & Author..: 16/12/17 BY pane

IMPORT os   #No.FUN-9C0009
DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE g_wc,g_sql	string                     #No.FUN-580092 HCN
DEFINE g_yy,g_mm	LIKE type_file.num5        #No.FUN-680123 SMALLINT
DEFINE b_date,e_date	LIKE type_file.dat         #No.FUN-680123 DATE
DEFINE g_dc		LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
DEFINE g_amt1,g_amt2	LIKE type_file.num20_6     #No.FUN-680123 DEC(20,6)  #FUN-4C0013
DEFINE p_row,p_col      LIKE type_file.num5        #No.FUN-680123 SMALLINT
DEFINE   g_chr          LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
DEFINE   g_cnt          LIKE type_file.num10       #No.FUN-680123 INTEGER
DEFINE   g_change_lang  LIKE type_file.chr1        #No.FUN-680123 VARCHAR(01)   #是否有做語言切換 No.FUN-570156
DEFINE   g_tc_khy       RECORD LIKE tc_khy_file.*

MAIN
   DEFINE l_flag        LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)   #No.FUN-570156

   OPTIONS
        MESSAGE   LINE  LAST-1,
        INPUT NO WRAP
   DEFER INTERRUPT

   #No.FUN-570156 --start--
   INITIALIZE g_bgjob_msgfile TO NULL
   LET g_yy     = ARG_VAL(1)             #結帳年度
   LET g_mm     = ARG_VAL(2)             #期別
   LET g_bgjob = ARG_VAL(3)     #背景作業
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
   #No.FUN-570156 ---end---

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF

   #No.FUN-570156 --start--
   CALL  cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0095
   WHILE TRUE
      IF g_bgjob = "N" THEN
         CALL p120()
         IF cl_sure(18,20) THEN
            LET g_success = 'Y'
            BEGIN WORK
            CALL p120_process()
            CALL s_showmsg()    #No.FUN-710050
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
               CLOSE WINDOW p120_w
               EXIT WHILE
            END IF
         ELSE
            CONTINUE WHILE
         END IF
      ELSE
         LET g_success = 'Y'
         BEGIN WORK
         CALL p120_process()
         CALL s_showmsg()    #No.FUN-710050
         IF g_success = "Y" THEN
            COMMIT WORK
         ELSE
            ROLLBACK WORK
         END IF
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
   #No.FUN-570156 ---end---
   CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0095
END MAIN

FUNCTION p120()
DEFINE l_flag LIKE type_file.chr1        #No.FUN-680123 VARCHAR(1)
DEFINE lc_cmd LIKE type_file.chr1000     #No.FUN-680123 VARCHAR(500)     #No.FUN-570156

   #No.FUN-570156 --start--
   OPEN WINDOW p120_w AT p_row,p_col WITH FORM "cxm/42f/cxmp120"
      ATTRIBUTE (STYLE = g_win_style)

   CALL cl_ui_init()
   #No.FUN-570156 ---end---

   CLEAR FORM
#  SELECT azn02,azn04 INTO g_yy,g_mm FROM azn_file WHERE azn01 = g_ooz.ooz09
   SELECT sma51,sma52 INTO g_yy,g_mm FROM sma_file

   WHILE TRUE
      CALL cl_opmsg('z')

      LET g_bgjob = "N"       #No.FUN-570156
      INPUT BY NAME g_yy,g_mm,g_bgjob WITHOUT DEFAULTS    #No.FUN-570156

         #No.FUN-580031 --start--
         BEFORE INPUT
             CALL cl_qbe_init()
         #No.FUN-580031 ---end---

         AFTER FIELD g_yy
            IF g_yy IS NULL OR g_yy=0 THEN
               NEXT FIELD g_yy
            END IF

         AFTER FIELD g_mm
#No.TQC-720032 -- begin --
         IF NOT cl_null(g_mm) THEN
            SELECT azm02 INTO g_azm.azm02 FROM azm_file
              WHERE azm01 = g_yy
            IF g_azm.azm02 = 1 THEN
               IF g_mm > 12 OR g_mm < 1 THEN
                  CALL cl_err('','agl-020',0)
                  NEXT FIELD g_mm
               END IF
            ELSE
               IF g_mm > 13 OR g_mm < 1 THEN
                  CALL cl_err('','agl-020',0)
                  NEXT FIELD g_mm
               END IF
            END IF
         END IF
#No.TQC-720032 -- end --
            IF g_mm IS NULL OR g_mm=0 THEN
               NEXT FIELD g_mm
            END IF

         ON ACTION CONTROLZ
            CALL cl_show_req_fields()
         ON ACTION CONTROLG
            call cl_cmdask()
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE INPUT

         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121

         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121

         ON ACTION exit    #加離開功能genero
            LET INT_FLAG = 1
            EXIT INPUT
         ON ACTION locale #genero
            #No.FUN-570156 --start--
#           LET g_action_choice = "locale"
#           CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
            LET g_change_lang = TRUE
            #No.FUN-570156 ---end---
            EXIT INPUT

         #No.FUN-580031 --start--
         ON ACTION qbe_select
            CALL cl_qbe_select()
         #No.FUN-580031 ---end---

         #No.FUN-580031 --start--
         ON ACTION qbe_save
            CALL cl_qbe_save()
         #No.FUN-580031 ---end---

      END INPUT
      #No.FUN-570156 --start--
#     IF g_action_choice = "locale" THEN  #genero
      IF g_change_lang THEN
#        LET g_action_choice = ""
         LET g_change_lang = FALSE
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()
         CONTINUE WHILE
      END IF
      #No.FUN-570156 ---end---

      IF INT_FLAG THEN
         #No.FUN-570156 --start--
         LET INT_FLAG = 0
         CLOSE WINDOW p120_w
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
         EXIT PROGRAM
#        RETURN
         #No.FUN-570156 ---end---
      END IF

      #No.FUN-570156 --start--
      IF g_bgjob = "Y" THEN
         SELECT zz08 INTO lc_cmd FROM zz_file
          WHERE zz01 = "cxmp120"
         IF SQLCA.sqlcode OR lc_cmd IS NULL THEN
            CALL cl_err('cxmp120','9031',1)
         ELSE
            LET lc_cmd = lc_cmd CLIPPED,
                         " '",g_yy    CLIPPED,"'",
                         " '",g_mm    CLIPPED,"'",
                         " '",g_bgjob CLIPPED,"'"
            CALL cl_cmdat('cxmp120',g_time,lc_cmd CLIPPED)
         END IF
         CLOSE WINDOW p120_w
         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211
         EXIT PROGRAM
      END IF
      EXIT WHILE

   END WHILE
END FUNCTION

#No.FUN-570156 --start--
FUNCTION p120_process()
  DEFINE l_occ01     LIKE occ_file.occ01,
         l_omaconf   LIKE oma_file.omaconf,
         l_azi01     LIKE azi_file.azi01,
         l_flag      LIKE type_file.chr1,        #No.FUN-680123 VARCHAR(1),
         l_name      LIKE type_file.chr20,       #No.FUN-680123 VARCHAR(10),
         l_sql       STRING,
         l_cnt       LIKE type_file.num10,
         l_cn        LIKE type_file.num10,
         l_oga51     LIKE oga_file.oga51,
         l_oga511    LIKE oga_file.oga511,
         l_oha50     LIKE oha_file.oha50,
         l_oha511    LIKE oha_file.oha50,
         l_npk08     LIKE npk_file.npk08,
         l_npk09     LIKE npk_file.npk09,
         l_tc_nme13  LIKE tc_nme_file.tc_nme13,
         l_tc_nme05  LIKE tc_nme_file.tc_nme05,
         l_a1        LIKE oea_file.oea1008,
         l_a2        LIKE oea_file.oea1008,
         l_a3        LIKE oea_file.oea1008,
         l_a4        LIKE oea_file.oea1008,
         l_a5        LIKE oea_file.oea1008,
         l_a6        LIKE oea_file.oea1008,
         l_a7        LIKE oea_file.oea1008,
         l_a8        LIKE oea_file.oea1008,
         l_a9        LIKE oea_file.oea1008,
         l_a10       LIKE oea_file.oea1008,
         l_a11       LIKE oea_file.oea1008,
         l_a12       LIKE oea_file.oea1008,
         l_a13       LIKE oea_file.oea1008,
         l_a14       LIKE oea_file.oea1008,
         l_a15       LIKE oea_file.oea1008,
         l_a16       LIKE oea_file.oea1008,
         l_a17       LIKE oea_file.oea1008,
         l_a18       LIKE oea_file.oea1008,
         l_a19       LIKE oea_file.oea1008,
         l_a20       LIKE oea_file.oea1008,
         l_a21       LIKE oea_file.oea1008,
         l_a22       LIKE oea_file.oea1008,
         l_a23       LIKE oea_file.oea1008,
         l_a24       LIKE oea_file.oea1008,
         l_a25       LIKE oea_file.oea1008,
         l_a26       LIKE oea_file.oea1008,
         l_a27       LIKE oea_file.oea1008,
         l_a28       LIKE oea_file.oea1008,
         l_a29       LIKE oea_file.oea1008,
         l_a30       LIKE oea_file.oea1008,
         l_a31       LIKE oea_file.oea1008,
         l_a32       LIKE oea_file.oea1008,
         l_oob24     LIKE oob_file.oob24,
         l_oob09     LIKE oob_file.oob09,
         l_oob10     LIKE oob_file.oob10,
         l_yy        LIKE type_file.num5,
         l_mm        LIKE type_file.num5

        IF g_mm = 1 THEN
           LET l_yy = g_yy -1
           LET l_mm = 12
        ELSE
           LET l_yy = g_yy
           LET l_mm = g_mm -1
        END IF
        LET l_azi01 = ' '
        LET l_occ01 = ' '
        DECLARE p120_azi CURSOR FOR
          SELECT tc_khy03,tc_khy04 FROM tc_khy_file
           WHERE tc_khy01 = l_yy
             AND tc_khy02 = l_mm
          ORDER BY tc_khy03,tc_khy04
        CALL s_showmsg_init()
        FOREACH p120_azi INTO l_occ01,l_azi01
          IF STATUS THEN
             LET g_success = 'N'
             CALL s_errmsg('','','foreach:',STATUS,1)
          END IF
          # add by lixwz 20170814 s
          # 删除本期数据中没有的数据
          LET l_cn = 0
          SELECT COUNT(*) from oma_file
          WHERE oma03=l_occ01 AND omaconf='Y'
          LET l_cnt = 0
          SELECT COUNT(*) FROM oea_file
          WHERE oea03=l_occ01 AND oeaconf='Y'
          IF l_cn = 0 AND l_cnt = 0 THEN
                DELETE FROM tc_khy_file
                    WHERE tc_khy01 = g_yy
                        AND tc_khy02 = g_mm
                        AND tc_khy03 = l_occ01
                        AND tc_khy04 = l_azi01
                IF STATUS THEN
                   LET g_success = 'N'
                   CALL s_errmsg('','','DELETE:',STATUS,1)
                END IF
                CONTINUE FOREACH
          END IF
          # add by lixwz 20170814 e
          LET l_a1 = 0
          LET l_a2 = 0
          LET l_a3 = 0
          LET l_a4 = 0
          LET l_a5 = 0
          LET l_a6 = 0
          LET l_a7 = 0
          LET l_a8 = 0
          LET l_a9 = 0
          LET l_a10 = 0
          LET l_a11 = 0
          LET l_a12 = 0
          LET l_a13 = 0
          LET l_a14 = 0
          LET l_a15 = 0
          LET l_a16 = 0
          LET l_a17 = 0
          LET l_a18 = 0
          LET l_a19 = 0
          LET l_a20 = 0
          LET l_a21 = 0
          LET l_a22 = 0
          LET l_a23 = 0
          LET l_a24 = 0
          LET l_a25 = 0
          LET l_a26 = 0
          LET l_a27 = 0
          LET l_a28 = 0
          LET l_a29 = 0
          LET l_a30 = 0
          LET l_a31 = 0
          LET l_a32 = 0

         #DECLARE p120_occ CURSOR FOR
         #  SELECT occ01 FROM occ_file WHERE occ1004<>'0'
         #FOREACH p120_occ INTO l_occ01
         #   IF STATUS THEN
         #      LET g_success = 'N'
         #      CALL s_errmsg('','','foreach:',STATUS,1)
         #   END IF
             #写入期初数据
             IF g_mm = 1 THEN
                SELECT tc_khy05+tc_khy21,tc_khy06+tc_khy22,tc_khy07+tc_khy23,
                       tc_khy08+tc_khy24,tc_khy09+tc_khy25,tc_khy10+tc_khy26,
                       tc_khy11+tc_khy27,tc_khy12+tc_khy28,tc_khy13+tc_khy29,
                       tc_khy14+tc_khy30,tc_khy15+tc_khy31,tc_khy16+tc_khy32,
                       tc_khy17+tc_khy33,tc_khy18+tc_khy34,tc_khy19+tc_khy35,tc_khy20+tc_khy36
                  INTO l_a1,l_a2,l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,l_a15,l_a16
                  FROM tc_khy_file
                 WHERE tc_khy01 = g_yy -1
                   AND tc_khy02 = 12
                   AND tc_khy03 = l_occ01
                   AND tc_khy04 = l_azi01
             ELSE
                SELECT tc_khy05+tc_khy21,tc_khy06+tc_khy22,tc_khy07+tc_khy23,
                       tc_khy08+tc_khy24,tc_khy09+tc_khy25,tc_khy10+tc_khy26,
                       tc_khy11+tc_khy27,tc_khy12+tc_khy28,tc_khy13+tc_khy29,
                       tc_khy14+tc_khy30,tc_khy15+tc_khy31,tc_khy16+tc_khy32,
                       tc_khy17+tc_khy33,tc_khy18+tc_khy34,tc_khy19+tc_khy35,tc_khy20+tc_khy36
                  INTO l_a1,l_a2,l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,l_a15,l_a16
                  FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm -1
                   AND tc_khy03 = l_occ01
                   AND tc_khy04 = l_azi01
             END IF
             IF cl_null(l_a1) THEN
                LET l_a1 = 0
             END IF
             IF cl_null(l_a2) THEN
                LET l_a2 = 0
             END IF
             IF cl_null(l_a3) THEN
                LET l_a3 = 0
             END IF
             IF cl_null(l_a4) THEN
                LET l_a4 = 0
             END IF
             IF cl_null(l_a5) THEN
                LET l_a5 = 0
             END IF
             IF cl_null(l_a6) THEN
                LET l_a6 = 0
             END IF
             IF cl_null(l_a7) THEN
                LET l_a7 = 0
             END IF
             IF cl_null(l_a8) THEN
                LET l_a8 = 0
             END IF
             IF cl_null(l_a9) THEN
                LET l_a9 = 0
             END IF
             IF cl_null(l_a10) THEN
                LET l_a10 = 0
             END IF
             IF cl_null(l_a11) THEN
                LET l_a11 = 0
             END IF
             IF cl_null(l_a12) THEN
                LET l_a12 = 0
             END IF
             IF cl_null(l_a13) THEN
                LET l_a13 = 0
             END IF
             IF cl_null(l_a14) THEN
                LET l_a14 = 0
             END IF
             IF cl_null(l_a15) THEN
                LET l_a15 = 0
             END IF
             IF cl_null(l_a16) THEN
                LET l_a16 = 0
             END IF
             #本期订单数据
             SELECT SUM(oea1008),SUM(oea1008*oea24) INTO l_a17,l_a18 FROM oea_file
              WHERE MONTH(oea02)= g_mm
                AND YEAR(oea02) = g_yy
                AND oeaconf = 'Y'
                AND oea03 = l_occ01
                AND oea23 = l_azi01
              IF cl_null(l_a17) THEN
                 LET l_a17 = 0
              END IF
              IF cl_null(l_a18) THEN
                 LET l_a18 = 0
              END IF

             #本期出货数据
             SELECT SUM(oga51),SUM(oga511) INTO l_oga51,l_oga511 FROM oga_file
              WHERE MONTH(oga02) = g_mm
                AND YEAR(oga02) = g_yy
                AND oga03 = l_occ01
                AND oga23 = l_azi01
                AND ogapost = 'Y'

             SELECT SUM(oha50*(1+oha211)),SUM(oha50*(1+oha211)*oha24) INTO l_oha50,l_oha511 FROM oha_file
              WHERE MONTH(oha02) = g_mm
                AND YEAR(oha02) = g_yy
                AND oha03 = l_occ01
                AND oha23 = l_azi01
                AND ohapost = 'Y'

             IF l_oga51 IS NULL THEN LET l_oga51 = 0 END IF
             IF l_oga511 IS NULL THEN LET l_oga511 = 0 END IF
             IF l_oha50 IS NULL THEN LET l_oha50 = 0   END IF
             IF l_oha511 IS NULL THEN LET l_oha511 = 0 END IF

             LET l_a19 = l_oga51 - l_oha50
             LET l_a20 = l_oga511 - l_oha511

             #本期开票数据
             SELECT SUM(oma54t),SUM(oma56t) INTO l_a21,l_a22 FROM oma_file
              WHERE YEAR(oma02) = g_yy
                AND MONTH(oma02) = g_mm
                AND oma03 = l_occ01
                AND oma23 = l_azi01
                AND omaconf = 'Y'
                AND oma00 IN ('12','14','21','22')

             IF cl_null(l_a21) THEN
                LET l_a21 = 0
             END IF
             IF cl_null(l_a22) THEN
                LET l_a22 = 0
             END IF

            #本期回款数据
            SELECT SUM(tc_nme13),SUM(tc_nme05) INTO l_a23,l_a24 FROM tc_nme_file,tc_nmg_file
             WHERE tc_nme01 = tc_nmg01
               AND tc_nmg02 = l_occ01
               AND tc_nmg14 = l_azi01
               AND tc_nmg05 = 'Y'
               AND tc_nmg04 = 'Y'
               AND YEAR(tc_nmg11) = g_yy
               AND MONTH(tc_nmg11) = g_mm
               AND tc_nmg09 = 'A'
            IF cl_null(l_a23) THEN
               LET l_a23 = 0
            END IF
            IF cl_null(l_a24) THEN
               LET l_a24 = 0
            END IF

            #本期收款未回款数据
            SELECT SUM(npk08),SUM(npk09) INTO l_npk08,l_npk09 FROM npk_file,nmg_file
               WHERE nmg00 = npk00
                 AND YEAR(nmg01) = g_yy
                 AND MONTH(nmg01) = g_mm
                 AND nmg20 = '21'
                 AND nmgconf= 'Y'
                 AND nmg13 IS NOT NULL
                 AND nmg18 = l_occ01
                 AND npk05 = l_azi01

            SELECT SUM(tc_nme13),SUM(tc_nme05) INTO l_tc_nme13,l_tc_nme05 FROM tc_nme_file,tc_nmg_file
             WHERE tc_nme01 = tc_nmg01
                AND YEAR(tc_nmg11) = g_yy
                AND MONTH(tc_nmg11) = g_mm
                AND tc_nme06 IN (SELECT UNIQUE nmg00 FROM nmg_file,npk_file WHERE MONTH(nmg01) = g_mm AND YEAR(nmg01) = g_yy
                AND nmg20 = '21' AND nmgconf = 'Y' AND nmg13 IS NOT NULL AND nmg18 = l_occ01
                AND nmg00=npk00 AND npk05 = l_azi01)
                AND tc_nmg09 = 'A'
                AND tc_nmg05 = 'Y'
                AND tc_nmg04 = 'Y'
                AND tc_nmg02 = l_occ01
                AND tc_nmg14 = l_azi01

            IF l_npk08 IS NULL THEN LET l_npk08=0 END IF
            IF l_npk09 IS NULL THEN LET l_npk09 =0 END IF
            IF l_tc_nme13 IS NULL THEN LET l_tc_nme13 = 0 END IF
            IF l_tc_nme05 IS NULL THEN LET l_tc_nme05 = 0 END IF
            LET l_a25 = l_npk08 - l_tc_nme13
            LET l_a26 = l_npk09 - l_tc_nme05

            #本期退款数据
            SELECT SUM(ooa31c),SUM(ooa32c) INTO l_a27,l_a28 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '2'
            IF cl_null(l_a27) THEN
               LET l_a27 = 0
            END IF
            IF cl_null(l_a28) THEN
               LET l_a28 = 0
            END IF


             #本期应收调整数据
            SELECT SUM(ooa31c)*-1,SUM(ooa32c)*-1 INTO l_a29,l_a30 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '3'
               AND ooa40 = '1'

            LET l_sql = "SELECT oob24,SUM(oob09),SUM(oob10) FROM ooa_file,oob_file ",
                        " WHERE oob01 = ooa01 ",
                        "   AND YEAR(ooa02) = '",g_yy,"' ",
                        "   AND MONTH(ooa02) = '",g_mm,"' ",
                        "   AND ooaconf = 'Y' ",
                        "   AND ooa33 IS NOT NULL ",
                        "   AND ooa03 = '",l_occ01,"' ",
                        "   AND ooa23 = '",l_azi01,"' ",
                        "   AND ooa37 = '3' ",
                        "   AND ooa40 = '1' ",
                        "   AND oob24 <> '",l_occ01,"' ",
                        "   GROUP BY oob24 ",
                        "   ORDER BY oob24 "
            PREPARE p120_oob24_1 FROM l_sql
            DECLARE  p120_oob24 CURSOR FOR p120_oob24_1

            FOREACH p120_oob24 INTO l_oob24,l_oob09,l_oob10
                IF STATUS THEN
                   CALL cl_err('p120_oob24',STATUS,1)
                 # LET g_success = 'N'
                   EXIT FOREACH
                END IF
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm
                   AND tc_khy03 = l_oob24
                   AND tc_khy03 = l_azi01
                IF cl_null(l_cnt) THEN
                   LET l_cnt = 0
                END IF
                IF l_cnt = 0 THEN
                   IF g_mm  = 1 THEN
                      LET l_mm = 12
                      LET l_yy = g_yy -1
                   ELSE
                      LET l_mm = g_mm -1
                   END IF

                   INITIALIZE g_tc_khy.* TO NULL
                   SELECT COUNT(*) INTO l_cn FROM tc_khy_file
                    WHERE tc_khy01 = l_yy
                      AND tc_khy02 = l_mm
                      AND tc_khy03 = l_oob24
                      AND tc_khy04 = l_azi01
                   IF cl_null(l_cn) THEN
                      LET l_cn = 0
                   END IF
                   IF l_cn = 0 THEN
                      LET g_tc_khy.tc_khy01 = g_yy
                      LET g_tc_khy.tc_khy02 = g_mm
                      LET g_tc_khy.tc_khy03 = l_oob24
                      LET g_tc_khy.tc_khy04 = l_azi01
                      LET g_tc_khy.tc_khy05 = 0
                      LET g_tc_khy.tc_khy06 = 0
                      LET g_tc_khy.tc_khy07 = 0
                      LET g_tc_khy.tc_khy08 = 0
                      LET g_tc_khy.tc_khy09 = 0
                      LET g_tc_khy.tc_khy10 = 0
                      LET g_tc_khy.tc_khy11 = 0
                      LET g_tc_khy.tc_khy12 = 0
                      LET g_tc_khy.tc_khy13 = 0
                      LET g_tc_khy.tc_khy14 = 0
                      LET g_tc_khy.tc_khy15 = 0
                      LET g_tc_khy.tc_khy16 = 0
                      LET g_tc_khy.tc_khy17 = 0
                      LET g_tc_khy.tc_khy18 = 0
                      LET g_tc_khy.tc_khy19 = 0
                      LET g_tc_khy.tc_khy20 = 0
                      LET g_tc_khy.tc_khy21 = 0
                      LET g_tc_khy.tc_khy22 = 0
                      LET g_tc_khy.tc_khy23 = 0
                      LET g_tc_khy.tc_khy24 = 0
                      LET g_tc_khy.tc_khy25 = 0
                      LET g_tc_khy.tc_khy26 = 0
                      LET g_tc_khy.tc_khy27 = 0
                      LET g_tc_khy.tc_khy28 = 0
                      LET g_tc_khy.tc_khy29 = 0
                      LET g_tc_khy.tc_khy30 = 0
                      LET g_tc_khy.tc_khy31 = 0
                      LET g_tc_khy.tc_khy32 = 0
                      LET g_tc_khy.tc_khy33 = l_oob09
                      LET g_tc_khy.tc_khy34 = l_oob10
                      LET g_tc_khy.tc_khy35 = 0
                      LET g_tc_khy.tc_khy36 = 0
                      INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                              tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                              tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                              tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                              tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                              tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                         VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                                g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                                g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                                g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                                g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                                g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                                g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                                g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                                g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                                g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                                g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                                g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                       IF STATUS THEN
                          LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                          CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                          LET g_success = 'N'
                          CONTINUE FOREACH
                       END IF
                  ELSE
                    SELECT * INTO g_tc_khy.* FROM tc_khy_file
                      WHERE tc_khy01 = l_yy
                        AND tc_khy02 = l_mm
                        AND tc_khy03 = l_oob24
                        AND tc_khy04 = l_azi01
                     LET g_tc_khy.tc_khy01 =g_yy
                     LET g_tc_khy.tc_khy02 = g_mm
                     LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05+ g_tc_khy.tc_khy21
                     LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06+ g_tc_khy.tc_khy22
                     LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07+ g_tc_khy.tc_khy23
                     LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08+ g_tc_khy.tc_khy24
                     LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09+ g_tc_khy.tc_khy25
                     LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10+ g_tc_khy.tc_khy26
                     LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11+ g_tc_khy.tc_khy27
                     LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12+ g_tc_khy.tc_khy28
                     LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13+ g_tc_khy.tc_khy29
                     LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14+ g_tc_khy.tc_khy30
                     LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15+ g_tc_khy.tc_khy31
                     LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16+ g_tc_khy.tc_khy32
                     LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17+ g_tc_khy.tc_khy33
                     LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18+ g_tc_khy.tc_khy34
                     LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19+ g_tc_khy.tc_khy35
                     LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20+ g_tc_khy.tc_khy36
                     LET g_tc_khy.tc_khy21 = 0
                     LET g_tc_khy.tc_khy22 = 0
                     LET g_tc_khy.tc_khy23 = 0
                     LET g_tc_khy.tc_khy24 = 0
                     LET g_tc_khy.tc_khy25 = 0
                     LET g_tc_khy.tc_khy26 = 0
                     LET g_tc_khy.tc_khy27 = 0
                     LET g_tc_khy.tc_khy28 = 0
                     LET g_tc_khy.tc_khy29 = 0
                     LET g_tc_khy.tc_khy30 = 0
                     LET g_tc_khy.tc_khy31 = 0
                     LET g_tc_khy.tc_khy32 = 0
                     LET g_tc_khy.tc_khy33 = l_oob09
                     LET g_tc_khy.tc_khy34 = l_oob10
                     LET g_tc_khy.tc_khy35 = 0
                     LET g_tc_khy.tc_khy36 = 0
                     INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                             tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                             tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                             tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                             tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                             tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                        VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                               g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                               g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                               g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                               g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                               g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                               g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                               g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                               g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                               g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                               g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                               g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                     IF STATUS THEN
                        LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                        CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                        CONTINUE FOREACH
                     END IF
                  END IF
               ELSE
                     UPDATE tc_khy_file SET tc_khy33 = tc_khy33 + l_oob09,
                                            tc_khy34 = tc+khy34 + l_oob10
                                      WHERE tc_khy01 = g_yy
                                        AND tc_khy02 = g_mm
                                        AND tc_khy03 = l_oob24
                                        AND tc_khy04 = l_azi01
                      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                         LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                         CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                         LET g_success = 'N'
                        CONTINUE FOREACH
                      END IF
               END IF
            END FOREACH

            #本期待抵调整数据
            SELECT SUM(ooa31c),SUM(ooa32c) INTO l_a31,l_a32 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '3'
               AND ooa40 = '2'

            LET l_sql = "SELECT oob24,SUM(oob09),SUM(oob10) FROM ooa_file,oob_file ",
                        " WHERE oob01 = ooa01 ",
                        "   AND YEAR(ooa02) = '",g_yy,"' ",
                        "   AND MONTH(ooa02) = '",g_mm,"' ",
                        "   AND ooaconf = 'Y' ",
                        "   AND ooa33 IS NOT NULL ",
                        "   AND ooa03 = '",l_occ01,"' ",
                        "   AND ooa23 = '",l_azi01,"' ",
                        "   AND ooa37 = '3' ",
                        "   AND ooa40 = '2' ",
                        "   AND oob24 <> '",l_occ01,"' ",
                        "   GROUP BY oob24 ",
                        "   ORDER BY oob24 "
            PREPARE p120_oob24_2 FROM l_sql
            DECLARE  p120_oob24_11 CURSOR FOR p120_oob24_2

            LET l_oob24 = NULL
            LET l_oob09 = 0
            LET l_oob10 = 0

            FOREACH p120_oob24_11 INTO l_oob24,l_oob09,l_oob10
                IF STATUS THEN
                   CALL cl_err('p120_oob24',STATUS,1)
                 # LET g_success = 'N'
                   EXIT FOREACH
                END IF
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm
                   AND tc_khy03 = l_oob24
                   AND tc_khy03 = l_azi01
                IF cl_null(l_cnt) THEN
                   LET l_cnt = 0
                END IF
                IF l_cnt = 0 THEN
                   IF g_mm  = 1 THEN
                      LET l_mm = 12
                      LET l_yy = g_yy -1
                   ELSE
                      LET l_mm = g_mm -1
                   END IF

                   INITIALIZE g_tc_khy.* TO NULL
                   SELECT COUNT(*) INTO l_cn FROM tc_khy_file
                    WHERE tc_khy01 = l_yy
                      AND tc_khy02 = l_mm
                      AND tc_khy03 = l_oob24
                      AND tc_khy04 = l_azi01
                   IF cl_null(l_cn) THEN
                      LET l_cn = 0
                   END IF
                   IF l_cn = 0 THEN
                      LET g_tc_khy.tc_khy01 = g_yy
                      LET g_tc_khy.tc_khy02 = g_mm
                      LET g_tc_khy.tc_khy03 = l_oob24
                      LET g_tc_khy.tc_khy04 = l_azi01
                      LET g_tc_khy.tc_khy05 = 0
                      LET g_tc_khy.tc_khy06 = 0
                      LET g_tc_khy.tc_khy07 = 0
                      LET g_tc_khy.tc_khy08 = 0
                      LET g_tc_khy.tc_khy09 = 0
                      LET g_tc_khy.tc_khy10 = 0
                      LET g_tc_khy.tc_khy11 = 0
                      LET g_tc_khy.tc_khy12 = 0
                      LET g_tc_khy.tc_khy13 = 0
                      LET g_tc_khy.tc_khy14 = 0
                      LET g_tc_khy.tc_khy15 = 0
                      LET g_tc_khy.tc_khy16 = 0
                      LET g_tc_khy.tc_khy17 = 0
                      LET g_tc_khy.tc_khy18 = 0
                      LET g_tc_khy.tc_khy19 = 0
                      LET g_tc_khy.tc_khy20 = 0
                      LET g_tc_khy.tc_khy21 = 0
                      LET g_tc_khy.tc_khy22 = 0
                      LET g_tc_khy.tc_khy23 = 0
                      LET g_tc_khy.tc_khy24 = 0
                      LET g_tc_khy.tc_khy25 = 0
                      LET g_tc_khy.tc_khy26 = 0
                      LET g_tc_khy.tc_khy27 = 0
                      LET g_tc_khy.tc_khy28 = 0
                      LET g_tc_khy.tc_khy29 = 0
                      LET g_tc_khy.tc_khy30 = 0
                      LET g_tc_khy.tc_khy31 = 0
                      LET g_tc_khy.tc_khy32 = 0
                      LET g_tc_khy.tc_khy33 = 0
                      LET g_tc_khy.tc_khy34 = 0
                      LET g_tc_khy.tc_khy35 = l_oob09
                      LET g_tc_khy.tc_khy36 = l_oob10
                      INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                              tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                              tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                              tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                              tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                              tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                         VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                                g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                                g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                                g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                                g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                                g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                                g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                                g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                                g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                                g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                                g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                                g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                       IF STATUS THEN
                          LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                          CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                          LET g_success = 'N'
                          CONTINUE FOREACH
                       END IF
                  ELSE
                    SELECT * INTO g_tc_khy.* FROM tc_khy_file
                      WHERE tc_khy01 = l_yy
                        AND tc_khy02 = l_mm
                        AND tc_khy03 = l_oob24
                        AND tc_khy04 = l_azi01
                     LET g_tc_khy.tc_khy01 =g_yy
                     LET g_tc_khy.tc_khy02 = g_mm
                     LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05+ g_tc_khy.tc_khy21
                     LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06+ g_tc_khy.tc_khy22
                     LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07+ g_tc_khy.tc_khy23
                     LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08+ g_tc_khy.tc_khy24
                     LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09+ g_tc_khy.tc_khy25
                     LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10+ g_tc_khy.tc_khy26
                     LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11+ g_tc_khy.tc_khy27
                     LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12+ g_tc_khy.tc_khy28
                     LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13+ g_tc_khy.tc_khy29
                     LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14+ g_tc_khy.tc_khy30
                     LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15+ g_tc_khy.tc_khy31
                     LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16+ g_tc_khy.tc_khy32
                     LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17+ g_tc_khy.tc_khy33
                     LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18+ g_tc_khy.tc_khy34
                     LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19+ g_tc_khy.tc_khy35
                     LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20+ g_tc_khy.tc_khy36
                     LET g_tc_khy.tc_khy21 = 0
                     LET g_tc_khy.tc_khy22 = 0
                     LET g_tc_khy.tc_khy23 = 0
                     LET g_tc_khy.tc_khy24 = 0
                     LET g_tc_khy.tc_khy25 = 0
                     LET g_tc_khy.tc_khy26 = 0
                     LET g_tc_khy.tc_khy27 = 0
                     LET g_tc_khy.tc_khy28 = 0
                     LET g_tc_khy.tc_khy29 = 0
                     LET g_tc_khy.tc_khy30 = 0
                     LET g_tc_khy.tc_khy31 = 0
                     LET g_tc_khy.tc_khy32 = 0
                     LET g_tc_khy.tc_khy33 = 0
                     LET g_tc_khy.tc_khy34 = 0
                     LET g_tc_khy.tc_khy35 = l_oob09
                     LET g_tc_khy.tc_khy36 = l_oob10
                     INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                             tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                             tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                             tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                             tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                             tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                        VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                               g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                               g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                               g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                               g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                               g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                               g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                               g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                               g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                               g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                               g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                               g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                     IF STATUS THEN
                        LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                        CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                        CONTINUE FOREACH
                     END IF
                  END IF
               ELSE
                     UPDATE tc_khy_file SET tc_khy35 = tc_khy35 + l_oob09,
                                            tc_khy36 = tc+khy36 + l_oob10
                                      WHERE tc_khy01 = g_yy
                                        AND tc_khy02 = g_mm
                                        AND tc_khy03 = l_oob24
                                        AND tc_khy04 = l_azi01
                      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                         LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                         CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                         LET g_success = 'N'
                        CONTINUE FOREACH
                      END IF
               END IF
            END FOREACH

          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
           WHERE tc_khy01 = g_yy
             AND tc_khy02 = g_mm
             AND tc_khy03 = l_occ01
             AND tc_khy04 = l_azi01

          IF cl_null(l_cnt) THEN
             LET l_cnt = 0
          END IF
          IF l_cnt = 0 THEN
             INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                     tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                     tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                     tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                     tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                     tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                               VALUES(g_yy,g_mm,l_occ01,l_azi01,l_a1,l_a2,
                                      l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,
                                      l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,
                                      l_a15,l_a16,l_a17,l_a18,l_a19,l_a20,
                                      l_a21,l_a22,l_a23,l_a24,l_a25,l_a26,
                                      l_a27,l_a28,l_a29,l_a30,l_a31,l_a32)
             IF STATUS THEN
                LET g_showmsg=g_yy,"/",g_mm,"/",l_occ01,"/",l_azi01
                CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                LET g_success = 'N'
                CONTINUE FOREACH
             END IF
          ELSE
            UPDATE tc_khy_file SET tc_khy05 = l_a1,
                                   tc_khy06 = l_a2,
                                   tc_khy07 = l_a3,
                                   tc_khy08 = l_a4,
                                   tc_khy09 = l_a5,
                                   tc_khy10 = l_a6,
                                   tc_khy11 = l_a7,
                                   tc_khy12 = l_a8,
                                   tc_khy13 = l_a9,
                                   tc_khy14 = l_a10,
                                   tc_khy15 = l_a11,
                                   tc_khy16 = l_a12,
                                   tc_khy17 = l_a13,
                                   tc_khy18 = l_a14,
                                   tc_khy19 = l_a15,
                                   tc_khy20 = l_a16,
                                   tc_khy21 = l_a17,
                                   tc_khy22 = l_a18,
                                   tc_khy23 = l_a19,
                                   tc_khy24 = l_a20,
                                   tc_khy25 = l_a21,
                                   tc_khy26 = l_a22,
                                   tc_khy27 = l_a23,
                                   tc_khy28 = l_a24,
                                   tc_khy29 = l_a25,
                                   tc_khy30 = l_a26,
                                   tc_khy31 = l_a27,
                                   tc_khy32 = l_a28,
                                   tc_khy33 = l_a29,
                                   tc_khy34 = l_a30,
                                   tc_khy35 = l_a31,
                                   tc_khy36 = l_a32
                             WHERE tc_khy01 = g_yy
                               AND tc_khy02 = g_mm
                               AND tc_khy03 = l_occ01
                               AND tc_khy04 = l_azi01

               IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                  LET g_showmsg=g_yy,"/",g_mm,"/",l_occ01,"/",l_azi01
                  CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                  LET g_success = 'N'
                  CONTINUE FOREACH
               END IF
           END IF
           #下期数据
           INITIALIZE g_tc_khy.* TO NULL
           SELECT * INTO g_tc_khy.* FROM tc_khy_file
             WHERE tc_khy01 = g_yy
               AND tc_khy02 = g_mm
               AND tc_khy03 = l_occ01
               AND tc_khy04 = l_azi01
           IF g_tc_khy.tc_khy02 = 12 THEN
               LET g_tc_khy.tc_khy01 = g_tc_khy.tc_khy01 + 1
               LET g_tc_khy.tc_khy02 = 1
           ELSE
                LET g_tc_khy.tc_khy02 = g_tc_khy.tc_khy02 +1
           END IF
           LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05 + g_tc_khy.tc_khy21
           LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06 + g_tc_khy.tc_khy22
           LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07 + g_tc_khy.tc_khy23
           LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08 + g_tc_khy.tc_khy24
           LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09 + g_tc_khy.tc_khy25
           LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10 + g_tc_khy.tc_khy26
           LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11 + g_tc_khy.tc_khy27
           LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12 + g_tc_khy.tc_khy28
           LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13 + g_tc_khy.tc_khy29
           LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14 + g_tc_khy.tc_khy30
           LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15 + g_tc_khy.tc_khy31
           LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16 + g_tc_khy.tc_khy32
           LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17 + g_tc_khy.tc_khy33
           LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18 + g_tc_khy.tc_khy34
           LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19 + g_tc_khy.tc_khy35
           LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20 + g_tc_khy.tc_khy36
           LET  g_tc_khy.tc_khy21 = 0
           LET  g_tc_khy.tc_khy22 = 0
           LET  g_tc_khy.tc_khy23 = 0
           LET  g_tc_khy.tc_khy24 = 0
           LET  g_tc_khy.tc_khy25 = 0
           LET  g_tc_khy.tc_khy26 = 0
           LET  g_tc_khy.tc_khy27 = 0
           LET  g_tc_khy.tc_khy28 = 0
           LET  g_tc_khy.tc_khy29 = 0
           LET  g_tc_khy.tc_khy30 = 0
           LET  g_tc_khy.tc_khy31 = 0
           LET  g_tc_khy.tc_khy32 = 0
           LET  g_tc_khy.tc_khy33 = 0
           LET  g_tc_khy.tc_khy34 = 0
           LET  g_tc_khy.tc_khy35 = 0
           LET  g_tc_khy.tc_khy36 = 0
           # add by lixwz 20170804 s
           LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
           WHERE tc_khy01 = g_tc_khy.tc_khy01
             AND tc_khy02 = g_tc_khy.tc_khy02
             AND tc_khy03 = g_tc_khy.tc_khy03
             AND tc_khy04 = g_tc_khy.tc_khy04
            IF  l_cnt > 0 THEN
                  UPDATE tc_khy_file SET tc_khy05 = g_tc_khy.tc_khy05,
                                         tc_khy06 = g_tc_khy.tc_khy06,
                                         tc_khy07 = g_tc_khy.tc_khy07,
                                         tc_khy08 = g_tc_khy.tc_khy08,
                                         tc_khy09 = g_tc_khy.tc_khy09,
                                         tc_khy10 = g_tc_khy.tc_khy10,
                                         tc_khy11 = g_tc_khy.tc_khy11,
                                         tc_khy12 = g_tc_khy.tc_khy12,
                                         tc_khy13 = g_tc_khy.tc_khy13,
                                         tc_khy14 = g_tc_khy.tc_khy14,
                                         tc_khy15 = g_tc_khy.tc_khy15,
                                         tc_khy16 = g_tc_khy.tc_khy16,
                                         tc_khy17 = g_tc_khy.tc_khy17,
                                         tc_khy18 = g_tc_khy.tc_khy18,
                                         tc_khy19 = g_tc_khy.tc_khy19,
                                         tc_khy20 = g_tc_khy.tc_khy20,
                                         tc_khy21 = g_tc_khy.tc_khy21,
                                         tc_khy22 = g_tc_khy.tc_khy22,
                                         tc_khy23 = g_tc_khy.tc_khy23,
                                         tc_khy24 = g_tc_khy.tc_khy24,
                                         tc_khy25 = g_tc_khy.tc_khy25,
                                         tc_khy26 = g_tc_khy.tc_khy26,
                                         tc_khy27 = g_tc_khy.tc_khy27,
                                         tc_khy28 = g_tc_khy.tc_khy28,
                                         tc_khy29 = g_tc_khy.tc_khy29,
                                         tc_khy30 = g_tc_khy.tc_khy30,
                                         tc_khy31 = g_tc_khy.tc_khy31,
                                         tc_khy32 = g_tc_khy.tc_khy32,
                                         tc_khy33 = g_tc_khy.tc_khy33,
                                         tc_khy34 = g_tc_khy.tc_khy34,
                                         tc_khy35 = g_tc_khy.tc_khy35,
                                         tc_khy36 = g_tc_khy.tc_khy36
                                   WHERE tc_khy01 =g_tc_khy.tc_khy01
                                     AND tc_khy02 = g_tc_khy.tc_khy02
                                     AND tc_khy03 = g_tc_khy.tc_khy03
                                     AND tc_khy04 =g_tc_khy.tc_khy04
                   IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                      LET g_showmsg=g_tc_khy.tc_khy01,"/",g_tc_khy.tc_khy02,"/",g_tc_khy.tc_khy03,"/",g_tc_khy.tc_khy04
                      CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                      LET g_success = 'N'
                      CONTINUE FOREACH
                   END IF
            ELSE
           # add by lixwz 20170804 e
                   INSERT INTO tc_khy_file VALUES (g_tc_khy.*)
                   IF STATUS THEN
                      LET g_showmsg=g_tc_khy.tc_khy01,"/",g_tc_khy.tc_khy02,"/",g_tc_khy.tc_khy03,"/",g_tc_khy.tc_khy04
                      CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                      LET g_success = 'N'
                      CONTINUE FOREACH
                   END IF
           END IF #  add by lixwz 20170804
     END FOREACH
     #上期没有本月新增的订单客户信息#
     LET l_occ01 = NULL
     LET l_azi01 = NULL
     DECLARE p120_oma CURSOR FOR
        SELECT oea03,oea23 FROM oea_file
           WHERE YEAR(oea02) = g_yy
             AND MONTH(oea02) = g_mm
             AND oea03||oea23 NOT IN (SELECT tc_khy03||tc_khy04 FROM tc_khy_file WHERE tc_khy01 =l_yy AND tc_khy02 =l_mm)
             AND oeaconf ='Y'
        UNION
        SELECT oma03,oma23 FROM oma_file
          WHERE YEAR(oma02) = g_yy
            AND MONTH(oma02) = g_mm
            AND oma00 IN ('24','14','22')
            AND oma70 = '1'
            AND omaconf = 'Y'
            AND oma03||oma23 NOT IN (SELECT tc_khy03||tc_khy04 FROM tc_khy_file WHERE tc_khy01 = l_yy AND tc_khy02= l_mm)
     FOREACH p120_oma INTO l_occ01,l_azi01
       IF STATUS THEN
             LET g_success = 'N'
             CALL s_errmsg('','','foreach:',STATUS,1)
          END IF
          LET l_a1 = 0
          LET l_a2 = 0
          LET l_a3 = 0
          LET l_a4 = 0
          LET l_a5 = 0
          LET l_a6 = 0
          LET l_a7 = 0
          LET l_a8 = 0
          LET l_a9 = 0
          LET l_a10 = 0
          LET l_a11 = 0
          LET l_a12 = 0
          LET l_a13 = 0
          LET l_a14 = 0
          LET l_a15 = 0
          LET l_a16 = 0
          LET l_a17 = 0
          LET l_a18 = 0
          LET l_a19 = 0
          LET l_a20 = 0
          LET l_a21 = 0
          LET l_a22 = 0
          LET l_a23 = 0
          LET l_a24 = 0
          LET l_a25 = 0
          LET l_a26 = 0
          LET l_a27 = 0
          LET l_a28 = 0
          LET l_a29 = 0
          LET l_a30 = 0
          LET l_a31 = 0
          LET l_a32 = 0

         #DECLARE p120_occ CURSOR FOR
         #  SELECT occ01 FROM occ_file WHERE occ1004<>'0'
         #FOREACH p120_occ INTO l_occ01
         #   IF STATUS THEN
         #      LET g_success = 'N'
         #      CALL s_errmsg('','','foreach:',STATUS,1)
         #   END IF
             #写入期初数据
             IF g_mm = 1 THEN
                SELECT tc_khy05+tc_khy21,tc_khy06+tc_khy22,tc_khy07+tc_khy23,
                       tc_khy08+tc_khy24,tc_khy09+tc_khy25,tc_khy10+tc_khy26,
                       tc_khy11+tc_khy27,tc_khy12+tc_khy28,tc_khy13+tc_khy29,
                       tc_khy14+tc_khy30,tc_khy15+tc_khy31,tc_khy16+tc_khy32,
                       tc_khy17+tc_khy33,tc_khy18+tc_khy34,tc_khy19+tc_khy35,tc_khy20+tc_khy36
                  INTO l_a1,l_a2,l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,l_a15,l_a16
                  FROM tc_khy_file
                 WHERE tc_khy01 = g_yy -1
                   AND tc_khy02 = 12
                   AND tc_khy03 = l_occ01
                   AND tc_khy04 = l_azi01
             ELSE
                SELECT tc_khy05+tc_khy21,tc_khy06+tc_khy22,tc_khy07+tc_khy23,
                       tc_khy08+tc_khy24,tc_khy09+tc_khy25,tc_khy10+tc_khy26,
                       tc_khy11+tc_khy27,tc_khy12+tc_khy28,tc_khy13+tc_khy29,
                       tc_khy14+tc_khy30,tc_khy15+tc_khy31,tc_khy16+tc_khy32,
                       tc_khy17+tc_khy33,tc_khy18+tc_khy34,tc_khy19+tc_khy35,tc_khy20+tc_khy36
                  INTO l_a1,l_a2,l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,l_a15,l_a16
                  FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm -1
                   AND tc_khy03 = l_occ01
                   AND tc_khy04 = l_azi01
             END IF
             IF cl_null(l_a1) THEN
                LET l_a1 = 0
             END IF
             IF cl_null(l_a2) THEN
                LET l_a2 = 0
             END IF
             IF cl_null(l_a3) THEN
                LET l_a3 = 0
             END IF
             IF cl_null(l_a4) THEN
                LET l_a4 = 0
             END IF
             IF cl_null(l_a5) THEN
                LET l_a5 = 0
             END IF
             IF cl_null(l_a6) THEN
                LET l_a6 = 0
             END IF
             IF cl_null(l_a7) THEN
                LET l_a7 = 0
             END IF
             IF cl_null(l_a8) THEN
                LET l_a8 = 0
             END IF
             IF cl_null(l_a9) THEN
                LET l_a9 = 0
             END IF
             IF cl_null(l_a10) THEN
                LET l_a10 = 0
             END IF
             IF cl_null(l_a11) THEN
                LET l_a11 = 0
             END IF
             IF cl_null(l_a12) THEN
                LET l_a12 = 0
             END IF
             IF cl_null(l_a13) THEN
                LET l_a13 = 0
             END IF
             IF cl_null(l_a14) THEN
                LET l_a14 = 0
             END IF
             IF cl_null(l_a15) THEN
                LET l_a15 = 0
             END IF
             IF cl_null(l_a16) THEN
                LET l_a16 = 0
             END IF
             #本期订单数据
             SELECT SUM(oea1008),SUM(oea1008*oea24) INTO l_a17,l_a18 FROM oea_file
              WHERE MONTH(oea02)= g_mm
                AND YEAR(oea02) = g_yy
                AND oeaconf = 'Y'
                AND oea03 = l_occ01
                AND oea23 = l_azi01
              IF cl_null(l_a17) THEN
                 LET l_a17 = 0
              END IF
              IF cl_null(l_a18) THEN
                 LET l_a18 = 0
              END IF

             #本期出货数据
             SELECT SUM(oga51),SUM(oga511) INTO l_oga51,l_oga511 FROM oga_file
              WHERE MONTH(oga02) = g_mm
                AND YEAR(oga02) = g_yy
                AND oga03 = l_occ01
                AND oga23 = l_azi01
                AND ogapost = 'Y'

             SELECT SUM(oha50*(1+oha211)),SUM(oha50*(1+oha211)*oha24) INTO l_oha50,l_oha511 FROM oha_file
              WHERE MONTH(oha02) = g_mm
                AND YEAR(oha02) = g_yy
                AND oha03 = l_occ01
                AND oha23 = l_azi01
                AND ohapost = 'Y'

             IF l_oga51 IS NULL THEN LET l_oga51 = 0 END IF
             IF l_oga511 IS NULL THEN LET l_oga511 = 0 END IF
             IF l_oha50 IS NULL THEN LET l_oha50 = 0   END IF
             IF l_oha511 IS NULL THEN LET l_oha511 = 0 END IF

             LET l_a19 = l_oga51 - l_oha50
             LET l_a20 = l_oga511 - l_oha511

             #本期开票数据
             SELECT SUM(oma54t),SUM(oma56t) INTO l_a21,l_a22 FROM oma_file
              WHERE YEAR(oma02) = g_yy
                AND MONTH(oma02) = g_mm
                AND oma03 = l_occ01
                AND oma23 = l_azi01
                AND omaconf = 'Y'
                AND oma00 IN ('12','14','21','22')

             IF cl_null(l_a21) THEN
                LET l_a21 = 0
             END IF
             IF cl_null(l_a22) THEN
                LET l_a22 = 0
             END IF

            #本期回款数据
            SELECT SUM(tc_nme13),SUM(tc_nme05) INTO l_a23,l_a24 FROM tc_nme_file,tc_nmg_file
             WHERE tc_nme01 = tc_nmg01
               AND tc_nmg02 = l_occ01
               AND tc_nmg14 = l_azi01
               AND tc_nmg05 = 'Y'
               AND tc_nmg04 = 'Y'
               AND YEAR(tc_nmg11) = g_yy
               AND MONTH(tc_nmg11) = g_mm
               AND tc_nmg09 = 'A'
            IF cl_null(l_a23) THEN
               LET l_a23 = 0
            END IF
            IF cl_null(l_a24) THEN
               LET l_a24 = 0
            END IF

            #本期收款未回款数据
            SELECT SUM(npk08),SUM(npk09) INTO l_npk08,l_npk09 FROM npk_file,nmg_file
               WHERE nmg00 = npk00
                 AND YEAR(nmg01) = g_yy
                 AND MONTH(nmg01) = g_mm
                 AND nmg20 = '21'
                 AND nmgconf= 'Y'
                 AND nmg13 IS NOT NULL
                 AND nmg18 = l_occ01
                 AND npk05 = l_azi01

            SELECT SUM(tc_nme13),SUM(tc_nme05) INTO l_tc_nme13,l_tc_nme05 FROM tc_nme_file,tc_nmg_file
             WHERE tc_nme01 = tc_nmg01
                AND YEAR(tc_nmg11) = g_yy
                AND MONTH(tc_nmg11) = g_mm
                AND tc_nme06 IN (SELECT UNIQUE nmg00 FROM nmg_file,npk_file WHERE MONTH(nmg01) = g_mm AND YEAR(nmg01) = g_yy
                AND nmg20 = '21' AND nmgconf = 'Y' AND nmg13 IS NOT NULL AND nmg18 = l_occ01
                AND nmg00=npk00 AND npk05 = l_azi01)
                AND tc_nmg09 = 'A'
                AND tc_nmg05 = 'Y'
                AND tc_nmg04 = 'Y'
                AND tc_nmg02 = l_occ01
                AND tc_nmg14 = l_azi01

            IF l_npk08 IS NULL THEN LET l_npk08=0 END IF
            IF l_npk09 IS NULL THEN LET l_npk09 =0 END IF
            IF l_tc_nme13 IS NULL THEN LET l_tc_nme13 = 0 END IF
            IF l_tc_nme05 IS NULL THEN LET l_tc_nme05 = 0 END IF
            LET l_a25 = l_npk08 - l_tc_nme13
            LET l_a26 = l_npk09 - l_tc_nme05

            #本期退款数据
            SELECT SUM(ooa31c),SUM(ooa32c) INTO l_a27,l_a28 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '2'
            IF cl_null(l_a27) THEN
               LET l_a27 = 0
            END IF
            IF cl_null(l_a28) THEN
               LET l_a28 = 0
            END IF


             #本期应收调整数据
            SELECT SUM(ooa31c)*-1,SUM(ooa32c)*-1 INTO l_a29,l_a30 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '3'
               AND ooa40 = '1'

            LET l_sql = "SELECT oob24,SUM(oob09),SUM(oob10) FROM ooa_file,oob_file ",
                        " WHERE oob01 = ooa01 ",
                        "   AND YEAR(ooa02) = '",g_yy,"' ",
                        "   AND MONTH(ooa02) = '",g_mm,"' ",
                        "   AND ooaconf = 'Y' ",
                        "   AND ooa33 IS NOT NULL ",
                        "   AND ooa03 = '",l_occ01,"' ",
                        "   AND ooa23 = '",l_azi01,"' ",
                        "   AND ooa37 = '3' ",
                        "   AND ooa40 = '1' ",
                        "   AND oob24 <> '",l_occ01,"' ",
                        "   GROUP BY oob24 ",
                        "   ORDER BY oob24 "
            PREPARE p120_oob24_3 FROM l_sql
            DECLARE  p120_oob24_31 CURSOR FOR p120_oob24_3

            FOREACH p120_oob24_31 INTO l_oob24,l_oob09,l_oob10
                IF STATUS THEN
                   CALL cl_err('p120_oob24_31',STATUS,1)
                 # LET g_success = 'N'
                   EXIT FOREACH
                END IF
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm
                   AND tc_khy03 = l_oob24
                   AND tc_khy03 = l_azi01
                IF cl_null(l_cnt) THEN
                   LET l_cnt = 0
                END IF
                IF l_cnt = 0 THEN
                   IF g_mm  = 1 THEN
                      LET l_mm = 12
                      LET l_yy = g_yy -1
                   ELSE
                      LET l_mm = g_mm -1
                   END IF

                   INITIALIZE g_tc_khy.* TO NULL
                   SELECT COUNT(*) INTO l_cn FROM tc_khy_file
                    WHERE tc_khy01 = l_yy
                      AND tc_khy02 = l_mm
                      AND tc_khy03 = l_oob24
                      AND tc_khy04 = l_azi01
                   IF cl_null(l_cn) THEN
                      LET l_cn = 0
                   END IF
                   IF l_cn = 0 THEN
                      LET g_tc_khy.tc_khy01 = g_yy
                      LET g_tc_khy.tc_khy02 = g_mm
                      LET g_tc_khy.tc_khy03 = l_oob24
                      LET g_tc_khy.tc_khy04 = l_azi01
                      LET g_tc_khy.tc_khy05 = 0
                      LET g_tc_khy.tc_khy06 = 0
                      LET g_tc_khy.tc_khy07 = 0
                      LET g_tc_khy.tc_khy08 = 0
                      LET g_tc_khy.tc_khy09 = 0
                      LET g_tc_khy.tc_khy10 = 0
                      LET g_tc_khy.tc_khy11 = 0
                      LET g_tc_khy.tc_khy12 = 0
                      LET g_tc_khy.tc_khy13 = 0
                      LET g_tc_khy.tc_khy14 = 0
                      LET g_tc_khy.tc_khy15 = 0
                      LET g_tc_khy.tc_khy16 = 0
                      LET g_tc_khy.tc_khy17 = 0
                      LET g_tc_khy.tc_khy18 = 0
                      LET g_tc_khy.tc_khy19 = 0
                      LET g_tc_khy.tc_khy20 = 0
                      LET g_tc_khy.tc_khy21 = 0
                      LET g_tc_khy.tc_khy22 = 0
                      LET g_tc_khy.tc_khy23 = 0
                      LET g_tc_khy.tc_khy24 = 0
                      LET g_tc_khy.tc_khy25 = 0
                      LET g_tc_khy.tc_khy26 = 0
                      LET g_tc_khy.tc_khy27 = 0
                      LET g_tc_khy.tc_khy28 = 0
                      LET g_tc_khy.tc_khy29 = 0
                      LET g_tc_khy.tc_khy30 = 0
                      LET g_tc_khy.tc_khy31 = 0
                      LET g_tc_khy.tc_khy32 = 0
                      LET g_tc_khy.tc_khy33 = l_oob09
                      LET g_tc_khy.tc_khy34 = l_oob10
                      LET g_tc_khy.tc_khy35 = 0
                      LET g_tc_khy.tc_khy36 = 0
                      INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                              tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                              tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                              tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                              tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                              tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                         VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                                g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                                g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                                g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                                g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                                g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                                g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                                g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                                g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                                g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                                g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                                g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                       IF STATUS THEN
                          LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                          CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                          LET g_success = 'N'
                          CONTINUE FOREACH
                       END IF
                  ELSE
                    SELECT * INTO g_tc_khy.* FROM tc_khy_file
                      WHERE tc_khy01 = l_yy
                        AND tc_khy02 = l_mm
                        AND tc_khy03 = l_oob24
                        AND tc_khy04 = l_azi01
                     LET g_tc_khy.tc_khy01 =g_yy
                     LET g_tc_khy.tc_khy02 = g_mm
                     LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05+ g_tc_khy.tc_khy21
                     LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06+ g_tc_khy.tc_khy22
                     LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07+ g_tc_khy.tc_khy23
                     LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08+ g_tc_khy.tc_khy24
                     LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09+ g_tc_khy.tc_khy25
                     LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10+ g_tc_khy.tc_khy26
                     LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11+ g_tc_khy.tc_khy27
                     LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12+ g_tc_khy.tc_khy28
                     LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13+ g_tc_khy.tc_khy29
                     LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14+ g_tc_khy.tc_khy30
                     LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15+ g_tc_khy.tc_khy31
                     LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16+ g_tc_khy.tc_khy32
                     LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17+ g_tc_khy.tc_khy33
                     LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18+ g_tc_khy.tc_khy34
                     LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19+ g_tc_khy.tc_khy35
                     LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20+ g_tc_khy.tc_khy36
                     LET g_tc_khy.tc_khy21 = 0
                     LET g_tc_khy.tc_khy22 = 0
                     LET g_tc_khy.tc_khy23 = 0
                     LET g_tc_khy.tc_khy24 = 0
                     LET g_tc_khy.tc_khy25 = 0
                     LET g_tc_khy.tc_khy26 = 0
                     LET g_tc_khy.tc_khy27 = 0
                     LET g_tc_khy.tc_khy28 = 0
                     LET g_tc_khy.tc_khy29 = 0
                     LET g_tc_khy.tc_khy30 = 0
                     LET g_tc_khy.tc_khy31 = 0
                     LET g_tc_khy.tc_khy32 = 0
                     LET g_tc_khy.tc_khy33 = l_oob09
                     LET g_tc_khy.tc_khy34 = l_oob10
                     LET g_tc_khy.tc_khy35 = 0
                     LET g_tc_khy.tc_khy36 = 0
                     INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                             tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                             tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                             tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                             tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                             tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                        VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                               g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                               g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                               g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                               g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                               g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                               g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                               g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                               g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                               g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                               g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                               g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                     IF STATUS THEN
                        LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                        CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                        CONTINUE FOREACH
                     END IF
                  END IF
               ELSE
                     UPDATE tc_khy_file SET tc_khy33 = tc_khy33 + l_oob09,
                                            tc_khy34 = tc+khy34 + l_oob10
                                      WHERE tc_khy01 = g_yy
                                        AND tc_khy02 = g_mm
                                        AND tc_khy03 = l_oob24
                                        AND tc_khy04 = l_azi01
                      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                         LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                         CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                         LET g_success = 'N'
                        CONTINUE FOREACH
                      END IF
               END IF
            END FOREACH

            #本期待抵调整数据
            SELECT SUM(ooa31c),SUM(ooa32c) INTO l_a31,l_a32 FROM ooa_file
             WHERE YEAR(ooa02) = g_yy
               AND MONTH(ooa02) = g_mm
               AND ooaconf = 'Y'
               AND ooa33 IS NOT NULL
               AND ooa03 = l_occ01
               AND ooa23 = l_azi01
               AND ooa37 = '3'
               AND ooa40 = '2'

            LET l_sql = "SELECT oob24,SUM(oob09),SUM(oob10) FROM ooa_file,oob_file ",
                        " WHERE oob01 = ooa01 ",
                        "   AND YEAR(ooa02) = '",g_yy,"' ",
                        "   AND MONTH(ooa02) = '",g_mm,"' ",
                        "   AND ooaconf = 'Y' ",
                        "   AND ooa33 IS NOT NULL ",
                        "   AND ooa03 = '",l_occ01,"' ",
                        "   AND ooa23 = '",l_azi01,"' ",
                        "   AND ooa37 = '3' ",
                        "   AND ooa40 = '2' ",
                        "   AND oob24 <> '",l_occ01,"' ",
                        "   GROUP BY oob24 ",
                        "   ORDER BY oob24 "
            PREPARE p120_oob24_4 FROM l_sql
            DECLARE  p120_oob24_41 CURSOR FOR p120_oob24_4

            LET l_oob24 = NULL
            LET l_oob09 = 0
            LET l_oob10 = 0

            FOREACH p120_oob24_41 INTO l_oob24,l_oob09,l_oob10
                IF STATUS THEN
                   CALL cl_err('p120_oob24_41',STATUS,1)
                 # LET g_success = 'N'
                   EXIT FOREACH
                END IF
                LET l_cnt = 0
                SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
                 WHERE tc_khy01 = g_yy
                   AND tc_khy02 = g_mm
                   AND tc_khy03 = l_oob24
                   AND tc_khy03 = l_azi01
                IF cl_null(l_cnt) THEN
                   LET l_cnt = 0
                END IF
                IF l_cnt = 0 THEN
                   IF g_mm  = 1 THEN
                      LET l_mm = 12
                      LET l_yy = g_yy -1
                   ELSE
                      LET l_mm = g_mm -1
                   END IF

                   INITIALIZE g_tc_khy.* TO NULL
                   SELECT COUNT(*) INTO l_cn FROM tc_khy_file
                    WHERE tc_khy01 = l_yy
                      AND tc_khy02 = l_mm
                      AND tc_khy03 = l_oob24
                      AND tc_khy04 = l_azi01
                   IF cl_null(l_cn) THEN
                      LET l_cn = 0
                   END IF
                   IF l_cn = 0 THEN
                      LET g_tc_khy.tc_khy01 = g_yy
                      LET g_tc_khy.tc_khy02 = g_mm
                      LET g_tc_khy.tc_khy03 = l_oob24
                      LET g_tc_khy.tc_khy04 = l_azi01
                      LET g_tc_khy.tc_khy05 = 0
                      LET g_tc_khy.tc_khy06 = 0
                      LET g_tc_khy.tc_khy07 = 0
                      LET g_tc_khy.tc_khy08 = 0
                      LET g_tc_khy.tc_khy09 = 0
                      LET g_tc_khy.tc_khy10 = 0
                      LET g_tc_khy.tc_khy11 = 0
                      LET g_tc_khy.tc_khy12 = 0
                      LET g_tc_khy.tc_khy13 = 0
                      LET g_tc_khy.tc_khy14 = 0
                      LET g_tc_khy.tc_khy15 = 0
                      LET g_tc_khy.tc_khy16 = 0
                      LET g_tc_khy.tc_khy17 = 0
                      LET g_tc_khy.tc_khy18 = 0
                      LET g_tc_khy.tc_khy19 = 0
                      LET g_tc_khy.tc_khy20 = 0
                      LET g_tc_khy.tc_khy21 = 0
                      LET g_tc_khy.tc_khy22 = 0
                      LET g_tc_khy.tc_khy23 = 0
                      LET g_tc_khy.tc_khy24 = 0
                      LET g_tc_khy.tc_khy25 = 0
                      LET g_tc_khy.tc_khy26 = 0
                      LET g_tc_khy.tc_khy27 = 0
                      LET g_tc_khy.tc_khy28 = 0
                      LET g_tc_khy.tc_khy29 = 0
                      LET g_tc_khy.tc_khy30 = 0
                      LET g_tc_khy.tc_khy31 = 0
                      LET g_tc_khy.tc_khy32 = 0
                      LET g_tc_khy.tc_khy33 = 0
                      LET g_tc_khy.tc_khy34 = 0
                      LET g_tc_khy.tc_khy35 = l_oob09
                      LET g_tc_khy.tc_khy36 = l_oob10
                      INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                              tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                              tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                              tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                              tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                              tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                         VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                                g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                                g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                                g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                                g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                                g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                                g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                                g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                                g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                                g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                                g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                                g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                       IF STATUS THEN
                          LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                          CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                          LET g_success = 'N'
                          CONTINUE FOREACH
                       END IF
                  ELSE
                    SELECT * INTO g_tc_khy.* FROM tc_khy_file
                      WHERE tc_khy01 = l_yy
                        AND tc_khy02 = l_mm
                        AND tc_khy03 = l_oob24
                        AND tc_khy04 = l_azi01
                     LET g_tc_khy.tc_khy01 =g_yy
                     LET g_tc_khy.tc_khy02 = g_mm
                     LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05+ g_tc_khy.tc_khy21
                     LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06+ g_tc_khy.tc_khy22
                     LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07+ g_tc_khy.tc_khy23
                     LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08+ g_tc_khy.tc_khy24
                     LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09+ g_tc_khy.tc_khy25
                     LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10+ g_tc_khy.tc_khy26
                     LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11+ g_tc_khy.tc_khy27
                     LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12+ g_tc_khy.tc_khy28
                     LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13+ g_tc_khy.tc_khy29
                     LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14+ g_tc_khy.tc_khy30
                     LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15+ g_tc_khy.tc_khy31
                     LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16+ g_tc_khy.tc_khy32
                     LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17+ g_tc_khy.tc_khy33
                     LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18+ g_tc_khy.tc_khy34
                     LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19+ g_tc_khy.tc_khy35
                     LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20+ g_tc_khy.tc_khy36
                     LET g_tc_khy.tc_khy21 = 0
                     LET g_tc_khy.tc_khy22 = 0
                     LET g_tc_khy.tc_khy23 = 0
                     LET g_tc_khy.tc_khy24 = 0
                     LET g_tc_khy.tc_khy25 = 0
                     LET g_tc_khy.tc_khy26 = 0
                     LET g_tc_khy.tc_khy27 = 0
                     LET g_tc_khy.tc_khy28 = 0
                     LET g_tc_khy.tc_khy29 = 0
                     LET g_tc_khy.tc_khy30 = 0
                     LET g_tc_khy.tc_khy31 = 0
                     LET g_tc_khy.tc_khy32 = 0
                     LET g_tc_khy.tc_khy33 = 0
                     LET g_tc_khy.tc_khy34 = 0
                     LET g_tc_khy.tc_khy35 = l_oob09
                     LET g_tc_khy.tc_khy36 = l_oob10
                     INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                             tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                             tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                             tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                             tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                             tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                                        VALUES(g_tc_khy.tc_khy01,g_tc_khy.tc_khy02,g_tc_khy.tc_khy03,
                                               g_tc_khy.tc_khy04,g_tc_khy.tc_khy05,g_tc_khy.tc_khy06,
                                               g_tc_khy.tc_khy07,g_tc_khy.tc_khy08,g_tc_khy.tc_khy09,
                                               g_tc_khy.tc_khy10,g_tc_khy.tc_khy11,g_tc_khy.tc_khy12,
                                               g_tc_khy.tc_khy13,g_tc_khy.tc_khy14,g_tc_khy.tc_khy15,
                                               g_tc_khy.tc_khy16,g_tc_khy.tc_khy17,g_tc_khy.tc_khy18,
                                               g_tc_khy.tc_khy19,g_tc_khy.tc_khy20,g_tc_khy.tc_khy21,
                                               g_tc_khy.tc_khy22,g_tc_khy.tc_khy23,g_tc_khy.tc_khy24,
                                               g_tc_khy.tc_khy25,g_tc_khy.tc_khy26,g_tc_khy.tc_khy27,
                                               g_tc_khy.tc_khy28,g_tc_khy.tc_khy29,g_tc_khy.tc_khy30,
                                               g_tc_khy.tc_khy31,g_tc_khy.tc_khy32,g_tc_khy.tc_khy33,
                                               g_tc_khy.tc_khy34,g_tc_khy.tc_khy35,g_tc_khy.tc_khy36)
                     IF STATUS THEN
                        LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                        CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                        LET g_success = 'N'
                        CONTINUE FOREACH
                     END IF
                  END IF
               ELSE
                     UPDATE tc_khy_file SET tc_khy35 = tc_khy35 + l_oob09,
                                            tc_khy36 = tc+khy36 + l_oob10
                                      WHERE tc_khy01 = g_yy
                                        AND tc_khy02 = g_mm
                                        AND tc_khy03 = l_oob24
                                        AND tc_khy04 = l_azi01
                      IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                         LET g_showmsg=g_yy,"/",g_mm,"/",l_oob24,"/",l_azi01
                         CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                         LET g_success = 'N'
                        CONTINUE FOREACH
                      END IF
               END IF
            END FOREACH

          LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
           WHERE tc_khy01 = g_yy
             AND tc_khy02 = g_mm
             AND tc_khy03 = l_occ01
             AND tc_khy04 = l_azi01

          IF cl_null(l_cnt) THEN
             LET l_cnt = 0
          END IF
          IF l_cnt = 0 THEN
             INSERT INTO tc_khy_file(tc_khy01,tc_khy02,tc_khy03,tc_khy04,tc_khy05,tc_khy06,
                                     tc_khy07,tc_khy08,tc_khy09,tc_khy10,tc_khy11,tc_khy12,
                                     tc_khy13,tc_khy14,tc_khy15,tc_khy16,tc_khy17,tc_khy18,
                                     tc_khy19,tc_khy20,tc_khy21,tc_khy22,tc_khy23,tc_khy24,
                                     tc_khy25,tc_khy26,tc_khy27,tc_khy28,tc_khy29,tc_khy30,
                                     tc_khy31,tc_khy32,tc_khy33,tc_khy34,tc_khy35,tc_khy36)
                               VALUES(g_yy,g_mm,l_occ01,l_azi01,l_a1,l_a2,
                                      l_a3,l_a4,l_a5,l_a6,l_a7,l_a8,
                                      l_a9,l_a10,l_a11,l_a12,l_a13,l_a14,
                                      l_a15,l_a16,l_a17,l_a18,l_a19,l_a20,
                                      l_a21,l_a22,l_a23,l_a24,l_a25,l_a26,
                                      l_a27,l_a28,l_a29,l_a30,l_a31,l_a32)
             IF STATUS THEN
                LET g_showmsg=g_yy,"/",g_mm,"/",l_occ01,"/",l_azi01
                CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                LET g_success = 'N'
                CONTINUE FOREACH
             END IF
          ELSE
            UPDATE tc_khy_file SET tc_khy05 = l_a1,
                                   tc_khy06 = l_a2,
                                   tc_khy07 = l_a3,
                                   tc_khy08 = l_a4,
                                   tc_khy09 = l_a5,
                                   tc_khy10 = l_a6,
                                   tc_khy11 = l_a7,
                                   tc_khy12 = l_a8,
                                   tc_khy13 = l_a9,
                                   tc_khy14 = l_a10,
                                   tc_khy15 = l_a11,
                                   tc_khy16 = l_a12,
                                   tc_khy17 = l_a13,
                                   tc_khy18 = l_a14,
                                   tc_khy19 = l_a15,
                                   tc_khy20 = l_a16,
                                   tc_khy21 = l_a17,
                                   tc_khy22 = l_a18,
                                   tc_khy23 = l_a19,
                                   tc_khy24 = l_a20,
                                   tc_khy25 = l_a21,
                                   tc_khy26 = l_a22,
                                   tc_khy27 = l_a23,
                                   tc_khy28 = l_a24,
                                   tc_khy29 = l_a25,
                                   tc_khy30 = l_a26,
                                   tc_khy31 = l_a27,
                                   tc_khy32 = l_a28,
                                   tc_khy33 = l_a29,
                                   tc_khy34 = l_a30,
                                   tc_khy35 = l_a31,
                                   tc_khy36 = l_a32
                             WHERE tc_khy01 = g_yy
                               AND tc_khy02 = g_mm
                               AND tc_khy03 = l_occ01
                               AND tc_khy04 = l_azi01

               IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                  LET g_showmsg=g_yy,"/",g_mm,"/",l_occ01,"/",l_azi01
                  CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                  LET g_success = 'N'
                  CONTINUE FOREACH
               END IF
           END IF
           #下期数据
           INITIALIZE g_tc_khy.* TO NULL
           SELECT * INTO g_tc_khy.* FROM tc_khy_file
             WHERE tc_khy01 = g_yy
               AND tc_khy02 = g_mm
               AND tc_khy03 = l_occ01
               AND tc_khy04 = l_azi01
           IF g_tc_khy.tc_khy02 = 12 THEN
               LET g_tc_khy.tc_khy01 = g_tc_khy.tc_khy01 + 1
               LET g_tc_khy.tc_khy02 = 1
           ELSE
                LET g_tc_khy.tc_khy02 = g_tc_khy.tc_khy02 +1
           END IF
           LET g_tc_khy.tc_khy05 = g_tc_khy.tc_khy05 + g_tc_khy.tc_khy21
           LET g_tc_khy.tc_khy06 = g_tc_khy.tc_khy06 + g_tc_khy.tc_khy22
           LET g_tc_khy.tc_khy07 = g_tc_khy.tc_khy07 + g_tc_khy.tc_khy23
           LET g_tc_khy.tc_khy08 = g_tc_khy.tc_khy08 + g_tc_khy.tc_khy24
           LET g_tc_khy.tc_khy09 = g_tc_khy.tc_khy09 + g_tc_khy.tc_khy25
           LET g_tc_khy.tc_khy10 = g_tc_khy.tc_khy10 + g_tc_khy.tc_khy26
           LET g_tc_khy.tc_khy11 = g_tc_khy.tc_khy11 + g_tc_khy.tc_khy27
           LET g_tc_khy.tc_khy12 = g_tc_khy.tc_khy12 + g_tc_khy.tc_khy28
           LET g_tc_khy.tc_khy13 = g_tc_khy.tc_khy13 + g_tc_khy.tc_khy29
           LET g_tc_khy.tc_khy14 = g_tc_khy.tc_khy14 + g_tc_khy.tc_khy30
           LET g_tc_khy.tc_khy15 = g_tc_khy.tc_khy15 + g_tc_khy.tc_khy31
           LET g_tc_khy.tc_khy16 = g_tc_khy.tc_khy16 + g_tc_khy.tc_khy32
           LET g_tc_khy.tc_khy17 = g_tc_khy.tc_khy17 + g_tc_khy.tc_khy33
           LET g_tc_khy.tc_khy18 = g_tc_khy.tc_khy18 + g_tc_khy.tc_khy34
           LET g_tc_khy.tc_khy19 = g_tc_khy.tc_khy19 + g_tc_khy.tc_khy35
           LET g_tc_khy.tc_khy20 = g_tc_khy.tc_khy20 + g_tc_khy.tc_khy36
           LET  g_tc_khy.tc_khy21 = 0
           LET  g_tc_khy.tc_khy22 = 0
           LET  g_tc_khy.tc_khy23 = 0
           LET  g_tc_khy.tc_khy24 = 0
           LET  g_tc_khy.tc_khy25 = 0
           LET  g_tc_khy.tc_khy26 = 0
           LET  g_tc_khy.tc_khy27 = 0
           LET  g_tc_khy.tc_khy28 = 0
           LET  g_tc_khy.tc_khy29 = 0
           LET  g_tc_khy.tc_khy30 = 0
           LET  g_tc_khy.tc_khy31 = 0
           LET  g_tc_khy.tc_khy32 = 0
           LET  g_tc_khy.tc_khy33 = 0
           LET  g_tc_khy.tc_khy34 = 0
           LET  g_tc_khy.tc_khy35 = 0
           LET  g_tc_khy.tc_khy36 = 0

            # add by lixwz 20170804 s
           LET l_cnt = 0
          SELECT COUNT(*) INTO l_cnt FROM tc_khy_file
           WHERE tc_khy01 = g_tc_khy.tc_khy01
             AND tc_khy02 = g_tc_khy.tc_khy02
             AND tc_khy03 = g_tc_khy.tc_khy03
             AND tc_khy04 = g_tc_khy.tc_khy04
            IF  l_cnt > 0 THEN
                  UPDATE tc_khy_file SET tc_khy05 = g_tc_khy.tc_khy05,
                                         tc_khy06 = g_tc_khy.tc_khy06,
                                         tc_khy07 = g_tc_khy.tc_khy07,
                                         tc_khy08 = g_tc_khy.tc_khy08,
                                         tc_khy09 = g_tc_khy.tc_khy09,
                                         tc_khy10 = g_tc_khy.tc_khy10,
                                         tc_khy11 = g_tc_khy.tc_khy11,
                                         tc_khy12 = g_tc_khy.tc_khy12,
                                         tc_khy13 = g_tc_khy.tc_khy13,
                                         tc_khy14 = g_tc_khy.tc_khy14,
                                         tc_khy15 = g_tc_khy.tc_khy15,
                                         tc_khy16 = g_tc_khy.tc_khy16,
                                         tc_khy17 = g_tc_khy.tc_khy17,
                                         tc_khy18 = g_tc_khy.tc_khy18,
                                         tc_khy19 = g_tc_khy.tc_khy19,
                                         tc_khy20 = g_tc_khy.tc_khy20,
                                         tc_khy21 = g_tc_khy.tc_khy21,
                                         tc_khy22 = g_tc_khy.tc_khy22,
                                         tc_khy23 = g_tc_khy.tc_khy23,
                                         tc_khy24 = g_tc_khy.tc_khy24,
                                         tc_khy25 = g_tc_khy.tc_khy25,
                                         tc_khy26 = g_tc_khy.tc_khy26,
                                         tc_khy27 = g_tc_khy.tc_khy27,
                                         tc_khy28 = g_tc_khy.tc_khy28,
                                         tc_khy29 = g_tc_khy.tc_khy29,
                                         tc_khy30 = g_tc_khy.tc_khy30,
                                         tc_khy31 = g_tc_khy.tc_khy31,
                                         tc_khy32 = g_tc_khy.tc_khy32,
                                         tc_khy33 = g_tc_khy.tc_khy33,
                                         tc_khy34 = g_tc_khy.tc_khy34,
                                         tc_khy35 = g_tc_khy.tc_khy35,
                                         tc_khy36 = g_tc_khy.tc_khy36
                                   WHERE tc_khy01 =g_tc_khy.tc_khy01
                                     AND tc_khy02 = g_tc_khy.tc_khy02
                                     AND tc_khy03 = g_tc_khy.tc_khy03
                                     AND tc_khy04 =g_tc_khy.tc_khy04
                   IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
                      LET g_showmsg=g_tc_khy.tc_khy01,"/",g_tc_khy.tc_khy02,"/",g_tc_khy.tc_khy03,"/",g_tc_khy.tc_khy04
                      CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#2):',SQLCA.sqlcode,1)
                      LET g_success = 'N'
                      CONTINUE FOREACH
                   END IF
            ELSE
           # add by lixwz 20170804 e
                   INSERT INTO tc_khy_file VALUES (g_tc_khy.*)
                   IF STATUS THEN
                      LET g_showmsg=g_tc_khy.tc_khy01,"/",g_tc_khy.tc_khy02,"/",g_tc_khy.tc_khy03,"/",g_tc_khy.tc_khy04
                      CALL s_errmsg('tc_khy01,tc_khy02,tc_khy03,tc_khy04',g_showmsg,'p120(ckp#4):',SQLCA.sqlcode,1)
                      LET g_success = 'N'
                      CONTINUE FOREACH
                   END IF
           END IF # add by lixwz 20170804
     END FOREACH
END FUNCTION

