# Prog. Version..: '5.30.06-13.03.12(00001)'     #
#
# Pattern name...: axcp331.4gl
# Descriptions...: 发出商品分录底稿整批生成作业
# Date & Author..: 12/08/29 By minpp #No.FUN-C80094
# Modify.........: No.FUN-D70068 13/07/11 By zhangweib 由於主營業務成本會科的取值邏輯為:優先取理由碼對應的成本科目,然後取產品大類中成本科目,
#                                                      最後取axri090中的成本科目
#                                                      cfc_file已經是匯總表,取不到理由碼,所以程式改取cfb_file


DATABASE ds

GLOBALS "../../config/top.global"

#No.FUN-C80094
#模組變數(Module Variables)
DEFINE g_cdj               RECORD LIKE cdj_file.*
DEFINE g_wc                STRING
DEFINE g_sql               STRING
DEFINE g_rec_b             LIKE type_file.num5                #單身筆數
DEFINE l_ac                LIKE type_file.num5                #目前處理的ARRAY CNT
DEFINE g_argv1             LIKE type_file.chr1
DEFINE tm                  RECORD
                           tlfctype    LIKE tlfc_file.tlfctype,
                           yy          LIKE type_file.num5,
                           mm          LIKE type_file.num5,
                           b    LIKE aaa_file.aaa01
                           END RECORD
#主程式開始
DEFINE g_flag              LIKE type_file.chr1
DEFINE l_flag              LIKE type_file.chr1
DEFINE g_change_lang       LIKE type_file.chr1
DEFINE g_cfc03    LIKE cfc_file.cfc03
DEFINE g_cfc04    LIKE cfc_file.cfc04
DEFINE g_cfc10    LIKE cfc_file.cfc10

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT


   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CONTINUE

   IF (NOT cl_setup("AXC")) THEN
      EXIT PROGRAM
   END IF

   LET g_time = TIME
     CALL  cl_used(g_prog,g_time,1) RETURNING g_time

   #立帳方式走開票流程，並且發出商品不納入成本計算才可運行此作業!
   SELECT oaz92,oaz93 INTO g_oaz.oaz92,g_oaz.oaz93 FROM oaz_file WHERE oaz00='0'
   IF NOT(g_oaz.oaz92='Y' AND g_oaz.oaz93='N') THEN
       CALL cl_err('','axc-889',1)
       EXIT PROGRAM
   END IF
   IF cl_null(tm.b) THEN LET tm.b = g_aza.aza81 END IF
   WHILE TRUE
      LET g_success = 'Y'
      IF g_bgjob = "N" THEN
         CALL p331_tm()
         IF cl_sure(18,20) THEN
            CALL p331_p()
             IF g_success ='Y' THEN
                CALL cl_end2(1) RETURNING l_flag
                IF l_flag THEN
                   CONTINUE WHILE
                ELSE
                   CLOSE WINDOW p331_w
                   EXIT WHILE
                END IF
             ELSE
                CALL cl_end2(2) RETURNING l_flag
                IF l_flag THEN
                   CONTINUE WHILE
                ELSE
                   CLOSE WINDOW p331_w
                   EXIT WHILE
                END IF

             END IF
          ELSE
            CONTINUE WHILE
         END IF
         CLOSE WINDOW p331_w
      ELSE
         CALL p331_p()
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
   CALL  cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION p331_tm()
DEFINE p_row,p_col    LIKE type_file.num5

   LET p_row = 4 LET p_col = 20
   OPEN WINDOW p331_w AT p_row,p_col WITH FORM "axc/42f/axcp323"
      ATTRIBUTE (STYLE = g_win_style)

   CALL cl_ui_init()
   CALL cl_opmsg('q')

   CLEAR FORM
   ERROR ''
   #lixwz 20171017  --Begin
   LET tm.yy = g_ccz.ccz01
   LET tm.mm = g_ccz.ccz02
   #lixwz 20171017  --End

   DISPLAY BY NAME tm.tlfctype,tm.yy,tm.mm,tm.b

  #  SELECT sma51,sma52 INTO tm.yy,tm.mm FROM sma_file mark lixwz 20171017
   LET g_bgjob = 'N'
   INPUT BY NAME
      tm.tlfctype,tm.yy,tm.mm,tm.b
      WITHOUT DEFAULTS

      BEFORE INPUT
        LET tm.tlfctype = g_ccz.ccz28

      AFTER FIELD b
         IF tm.b IS NULL THEN
            NEXT FIELD b
         END IF

      AFTER FIELD tlfctype
         IF tm.tlfctype NOT MATCHES '[12345]' THEN
            LET tm.tlfctype =NULL
            NEXT FIELD tlfctype
         END IF

      AFTER INPUT
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            CLOSE WINDOW p331_w
            CALL cl_used(g_prog,g_time,2) RETURNING g_time
            EXIT PROGRAM
         END IF
         IF cl_null(tm.tlfctype)THEN
            NEXT FIELD tlfctype
         END IF
         IF cl_null(tm.yy) THEN
            NEXT FIELD yy
         END IF
         IF cl_null(tm.mm) THEN
            NEXT FIELD mm
         END IF
         IF cl_null(tm.b) THEN
            NEXT FIELD b
         END IF

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION HELP          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121

      ON ACTION exit  #加離開功能genero
           LET INT_FLAG = 1
           EXIT INPUT
      ON ACTION qbe_save
           CALL cl_qbe_save()
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(b)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_aaa"
               CALL cl_create_qry() RETURNING tm.b
               DISPLAY BY NAME tm.b
               NEXT FIELD b
         END CASE
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p331_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time
      EXIT PROGRAM
   END IF


END FUNCTION

FUNCTION p331_p()

   BEGIN WORK
   CALL p331_chk()
   IF g_flag ='N' THEN LET g_success = 'N' ROLLBACK WORK RETURN END IF   #FUN-BB0038
   CALL p331_ins_cdj()
   IF g_success ='N' THEN
      ROLLBACK WORK
      RETURN
   END IF

   CALL p322_gl(tm.*,'3')
   IF g_success ='N' THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF
END FUNCTION

FUNCTION p331_ins_cdj()
DEFINE l_sql      STRING
DEFINE l_ccz12    LIKE ccz_file.ccz12
DEFINE l_ccz07    LIKE ccz_file.ccz07  #FUN-BB0038
DEFINE actno_c1   LIKE cdj_file.cdj08   #FUN-BB0038
DEFINE actno_c2   LIKE cdj_file.cdj08   #FUN-BB0038
DEFINE actno_d1   LIKE cdj_file.cdj08   #FUN-BB0038
DEFINE actno_d2   LIKE cdj_file.cdj08   #FUN-BB0038
DEFINE l_ool01    LIKE ool_file.ool01   #FUN-BB0038
DEFINE l_ooz08    LIKE ooz_file.ooz08   #FUN-BB0038
DEFINE l_cdj      RECORD LIKE cdj_file.*
DEFINE l_ccc02    LIKE ccc_file.ccc02   #luttb
DEFINE l_ccc03    LIKE ccc_file.ccc03   #luttb
DEFINE l_yy       LIKE type_file.num5   #luttb
DEFINE l_mm       LIKE type_file.num5   #luttb
DEFINE l_n        LIKE type_file.num5   #No.FUN-D70068   Add
DEFINE l_cfc18    LIKE cfc_file.cfc18   #No.FUN-D70068   Add
DEFINE l_cfb11    LIKE cfb_file.cfb11   #No.FUN-D70068   Add
DEFINE l_cfb12    LIKE cfb_file.cfb12   #No.FUN-D70068   Add

   DROP TABLE X
   SELECT * FROM cdj_file WHERE 1=2 INTO TEMP x

   DECLARE p331_c1 CURSOR  FOR
   #SELECT cfc03,cfc04,cfc15 FROM cfc_file WHERE cfc01=-1 AND cfc05=tm.yy AND cfc06=tm.mm  #luttb add cfc15   #No.FUN-D70068   Mark
   SELECT cfb04,cfb05,cfb15 FROM cfb_file
    WHERE cfb01=-1 AND YEAR(cfb061)=tm.yy
      AND MONTH(cfb061)=tm.mm
      AND cfb11<>'MISC' #add lisq 不应该存在MISC，紧急在此出来，应该在生成cfb处理

#No.FUN-D70068   Add
   LET g_cdj.cdj17=0
   FOREACH p331_c1 INTO g_cfc03,g_cfc04,g_cdj.cdj10   #luttb add cdj10
      #No.FUN-D70068 ---Mark--- Start
     ##luttb add--str--
     ##本月出貨開票的在axcp322處理
     #SELECT cfc05,cfc06 INTO l_yy,l_mm FROM cfc_file WHERE cfc03 = g_cfc03 AND cfc04 = g_cfc04
     #   AND cfc01 =1
     #IF l_yy = tm.yy AND l_mm = tm.mm THEN CONTINUE FOREACH END IF
     ##luttb add--end
     #No.FUN-D70068 ---Mark--- End
      LET l_sql= "SELECT tlflegal,'1',tlfcost,tlf01,tlf930,tlf16,tlf14,tlf19",
        " FROM tlf_file ",
      " WHERE tlf905='",g_cfc03,"' AND tlf906='",g_cfc04,"'",
 #    AND tlfc01=tlf01   AND tlfc06=tlf06 AND tlfc02=tlf02",
 #     "   AND tlfc03=tlf03   AND tlfc13=tlf13   AND tlfc902=tlf902 AND tlfc903=tlf903",
 #     "   AND tlfc904=tlf904 AND tlfc907=tlf907 AND tlfc905=tlf905 AND tlfc906=tlf906",
     #"   AND YEAR(tlf06)='",tm.yy,"' AND MONTH(tlf06)='",tm.mm,"'", #luttb mark
  #    "   AND tlfctype='",tm.tlfctype,"'",
      "   AND (tlf13 LIKE 'axmt6%' or tlf13='aomt800') AND tlf13<>'axmt670'",
      "   AND tlf902 <> '",g_oaz.oaz95,"'",    #No.FUN-D70068   Mod   g_oaz.oaz93 --> g_oaz.oaz95
      "   AND tlf902 not in (select jce02 from jce_file)"
      PREPARE p331_p1 FROM l_sql
#151109wudj-str
let g_cdj.cdj04=null
let g_cdj.cdj05=null
let g_cdj.cdj06=null
#151109wudj-mark
      EXECUTE p331_p1 INTO g_cdj.cdjlegal,g_cdj.cdj04,g_cdj.cdj05,g_cdj.cdj06,
                           g_cdj.cdj16,g_cdj.cdj09,g_cdj.cdj07,g_cdj.cdj14
     #IF cl_null(g_cdj.cdj04) OR cl_null(g_cdj.cdj05) OR cl_null(g_cdj.cdj06) THEN  #luttb mark
      IF cl_null(g_cdj.cdj04) AND cl_null(g_cdj.cdj05) AND cl_null(g_cdj.cdj06) THEN  #luttb add
         CONTINUE FOREACH
      END IF
     #No.FUN-D70068 ---Mod--- Start
     #SELECT cfc10 INTO g_cfc10  #部门
     #  FROM cfc_file WHERE cfc03=g_cfc03 and cfc04=g_cfc04 and cfc01=1
      SELECT cfb10 INTO g_cfc10  #部门
        FROM cfb_file WHERE cfb04=g_cfc03 and cfb05=g_cfc04 and cfb01=1
     #No.FUN-D70068 ---Mod--- End

     IF cl_null(g_cdj.cdj10) THEN LET g_cdj.cdj10 = 0 END IF #luttb add
     #luttb--mod--str--
     #SELECT tlfc21 INTO g_cdj.cdj12 FROM tlfc_file WHERE tlfc905=g_cfc03
     #                                                AND tlfc906=g_cfc04
     #                                                AND tlfctype=tm.tlfctype
     #                                                AND tlfc902<>g_oaz.oaz93
     #No.FUN-D70068 ---Mod--- Start
     #SELECT cfc05,cfc06 INTO l_ccc02,l_ccc03 FROM cfc_file WHERE cfc01 = 1  #出貨年月
     #   AND cfc03 = g_cfc03 AND cfc04 = g_cfc04
      LET l_ccc02=''#	zhouxm160808 add
      LET l_ccc03='' #   zhouxm160808 add
      LET l_cfb12=''#   zhouxm160808 add
      LET l_cfb11=''#   zhouxm160808 add
      SELECT YEAR(cfb06),MONTH(cfb06),cfb12,cfb11 INTO l_ccc02,l_ccc03,l_cfb12,l_cfb11 FROM cfb_file
       WHERE #cfb01 = 1  #出貨年月
         #AND #zhouxm160808 mark
         cfb04 = g_cfc03 AND cfb05 = g_cfc04
      SELECT cfc18 INTO l_cfc18 FROM cfc_file WHERE cfc01=-1 AND cfc05=tm.yy AND cfc06=tm.mm AND cfc11 = l_cfb11 AND cfc12 = l_cfb12
      IF cl_null(l_cfc18) THEN LET l_cfc18 = 1 END IF
     #No.FUN-D70068 ---Mod--- End
      LET g_cdj.cdj11 = '' #zhouxm160808 add
      SELECT ccc23 INTO g_cdj.cdj11 FROM ccc_file
       WHERE ccc01 = g_cdj.cdj06 AND ccc02 = l_ccc02 AND ccc03 = l_ccc03
         AND ccc07 = tm.tlfctype AND ccc08 = g_cdj.cdj05
      IF cl_null(g_cdj.cdj11) THEN LET g_cdj.cdj11 = 0 END IF
      LET g_cdj.cdj12 = g_cdj.cdj11*g_cdj.cdj10 * l_cfc18   #No.FUN-D70068  Add l_cfc18
     #luttb--mod--end

      LET g_cdj.cdj15=g_cfc10
      LET g_cdj.cdj00='3'
      LET g_cdj.cdj01=tm.b
      LET g_cdj.cdj02=tm.yy
      LET g_cdj.cdj03=tm.mm
      LET g_cdj.cdj17=g_cdj.cdj17+1

     #IF cl_null(g_cdj.cdj10) THEN LET g_cdj.cdj10 = 0 END IF  #luttb mark
     #IF cl_null(g_cdj.cdj11) THEN LET g_cdj.cdj11 = 0 END IF  #luttb mark
     #IF cl_null(g_cdj.cdj12) THEN LET g_cdj.cdj12 = 0 END IF  #luttb mark
      LET g_cdj.cdj11 = cl_digcut(g_cdj.cdj11,g_azi03)
      LET g_cdj.cdj12 = cl_digcut(g_cdj.cdj12,g_azi04)
      LET g_cdj.cdjconf = 'N'
LET actno_d1=null #150218wudj
      #借方科目优先根据tlf15抓取,若为空则根据以下顺序抓取
      #1.根据理由码抓销货费用科目azf14
      #2.产品分类码抓销货成本科目oba16
      #3.axri090抓ool43
      #借方
         IF NOT cl_null(g_cdj.cdj07) THEN
            SELECT azf14,azf141 INTO actno_d1,actno_d2 FROM azf_file
             WHERE azf01=g_cdj.cdj07 AND azf02='2' and azfacti='Y'
         END IF
         IF cl_null(actno_d1) THEN
           SELECT oba16,oba161 INTO actno_d1,actno_d2 FROM oba_file
            WHERE oba01 IN (SELECT ima131 FROM ima_file,tlf_file WHERE ima01=tlf01)   #No.TQC-D80012   Add tlf_file
         END IF
         IF cl_null(actno_d1) THEN
            SELECT occ67 INTO l_ool01 FROM occ_file WHERE occ01=g_cdj.cdj14
            SELECT ooz08 INTO l_ooz08 FROM ooz_file WHERE ooz00='0'
             IF NOT cl_null(l_ool01) THEN
                SELECT ool43,ool431 INTO actno_d1,actno_d2 FROM ool_file WHERE ool01 = l_ool01
             ELSE
                SELECT ool43,ool431 INTO actno_d1,actno_d2 FROM ool_file WHERE ool01 =l_ooz08
             END IF
         END IF
         IF g_cdj.cdj01 = g_aza.aza82 THEN
            LET g_cdj.cdj08=actno_d2
         ELSE
            LET g_cdj.cdj08=actno_d1
         END IF
         #贷方:發出商品

         #luttb--add--str--
         SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file
         IF g_cdj.cdj01 = l_ccz12 THEN
            CASE
               WHEN l_ccz07='2'
                  SELECT imz163 INTO g_cdj.cdj09
                    FROM ima_file,imz_file
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01
               OTHERWISE
                  #SELECT ima163 INTO g_cdj.cdj09 FROM ima_file  #mark by dengsy170212
                  SELECT ima39 INTO g_cdj.cdj09 FROM ima_file  #add by dengsy170212
                   WHERE ima01=g_cdj.cdj06
            END CASE
         ELSE
            CASE
               WHEN l_ccz07='2'
                  SELECT imz1631 INTO g_cdj.cdj09
                    FROM ima_file,imz_file
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01
               OTHERWISE
                  SELECT ima1631 INTO g_cdj.cdj09 FROM ima_file
                   WHERE ima01=g_cdj.cdj06
            END CASE
         END IF
         #luttb -add--end
         #zhouxm170926 add start
           SELECT ima163 INTO g_cdj.cdj09 FROM ima_file
                   WHERE ima01=g_cdj.cdj06
         #zhouxm170926 add  end
        #luttb--mark--str--
        #SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file
        #IF g_cdj.cdj01 = l_ccz12 THEN
        #   IF l_ccz07 = '2' THEN
        #         SELECT imz39 INTO g_cdj.cdj09
        #           FROM ima_file,imz_file
        #          WHERE ima01 = g_cdj.cdj06
        #            AND ima12 = imz01
        #   ELSE
        #         SELECT ima39 INTO g_cdj.cdj09
        #           FROM ima_file
        #          WHERE ima01 = g_cdj.cdj06
        #   END IF
        #ELSE
        #   IF l_ccz07 = '2' THEN
        #         SELECT imz391 INTO g_cdj.cdj09
        #           FROM ima_file,imz_file
        #          WHERE ima01 = g_cdj.cdj06
        #            AND ima12 = imz01
        #   ELSE
        #         SELECT ima391 INTO g_cdj.cdj09
        #           FROM ima_file
        #          WHERE ima01 = g_cdj.cdj06
        #   END IF
        #END IF
        #luttb--mark--end

      INSERT INTO X VALUES(g_cdj.*)
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         CALL cl_err('ins X',SQLCA.sqlcode,1)
         LET g_success ='N'
         EXIT FOREACH
      END IF
   END FOREACH

   IF g_success='Y' THEN
      DECLARE p331_c2 CURSOR  FOR
      SELECT cdj01,cdj02,cdj03,cdj04,cdj05,cdj06,cdj07,cdj08,cdj09,
       #cdj10,cdj11,sum(cdj12),'',cdjconf,cdjlegal,cdj14,cdj15,'','',cdj17,cdj00    #No.FUN-D70068   Mark
       SUM(cdj10),cdj11,sum(cdj12),'',cdjconf,cdjlegal,cdj14,cdj15,'','','',cdj00       #No.FUN-D70068   Add
       FROM X
       #GROUP BY cdj15,cdj06,cdj01,cdj02,cdj03,cdj04,cdj05,cdj07,cdj08,cdj09,cdj10,cdj11,
       GROUP BY cdj15,cdj06,cdj01,cdj02,cdj03,cdj04,cdj05,cdj07,cdj08,cdj09,cdj11, #zhouxm160808 add
        #cdjconf,cdjlegal,cdj14,cdj17,cdj00      #No.FUN-D70068   Mark
                cdjconf,cdjlegal,cdj14,cdj00            #No.FUN-D70068   Add
       ORDER BY cdj01,cdj02,cdj03,cdj04
       LET l_n = 1   #No.FUN-D70068   Add
       FOREACH p331_c2 INTO l_cdj.*
       		LET l_cdj.cdj17 = l_n   #No.FUN-D70068   Add
 #150706wudj-str
 select occ02 into l_cdj.cdj142 from occ_file where occ01=l_cdj.cdj14
  IF cl_null(l_cdj.cdj142) THEN
  	 select pmc03 into l_cdj.cdj142 from pmc_file where pmc01=l_cdj.cdj14
  END IF
 #150706wudj-end
          INSERT INTO cdj_file VALUES(l_cdj.*)
          IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
             CALL cl_err('ins cdj',SQLCA.sqlcode,1)
             LET g_success ='N'
             EXIT FOREACH
          END IF
           LET l_n = l_n + 1   #No.FUN-D70068   Add
       END FOREACH
   END IF
END FUNCTION

FUNCTION p331_chk()
DEFINE l_wc        STRING
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_file.num5
DEFINE l_cdjconf   LIKE cdj_file.cdjconf #FUN-BB0038



   LET l_sql = "SELECT count(*) ",
               "  FROM cdj_file ",
               " WHERE cdj00 = '3'",
               "   AND cdj01 ='",tm.b CLIPPED,"'",
               "   AND cdj02 = '",tm.yy CLIPPED,"'",
               "   AND cdj03 = '",tm.mm CLIPPED,"'",
               "   AND cdj04 = '",tm.tlfctype CLIPPED,"'"


   PREPARE p331_p6 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      RETURN
   END IF
   DECLARE p331_c6 CURSOR FOR p331_p6
   LET l_sql = "DELETE ",
               "  FROM cdj_file ",
               " WHERE cdj00 = '3'",
               "   AND cdj01 ='",tm.b CLIPPED,"'",
               "   AND cdj02 = '",tm.yy CLIPPED,"'",
               "   AND cdj03 = '",tm.mm CLIPPED,"'",
               "   AND cdj04 = '",tm.tlfctype CLIPPED,"'"


   PREPARE p331_p7 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      RETURN
   END IF

   OPEN p331_c6
   FETCH p331_c6 INTO l_cnt
   IF l_cnt >0 THEN
      SELECT UNIQUE cdjconf INTO l_cdjconf FROM cdj_file
       WHERE cdj00 = '3'
         AND cdj01=tm.b
         AND cdj02=tm.yy
         AND cdj03=tm.mm
         AND cdj04=tm.tlfctype
      IF l_cdjconf='Y' THEN
         CALL cl_err('','afa-364',1)
         LET g_flag='N'
      ELSE
         IF cl_confirm('mfg8002') THEN
            LET g_flag ='Y'
            EXECUTE p331_p7
         ELSE
            LET g_flag ='N'
         END IF
      END IF
   ELSE
         LET g_flag ='Y'
   END IF
   CLOSE p331_c6
END FUNCTION
