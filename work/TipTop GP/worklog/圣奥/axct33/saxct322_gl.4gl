# Prog. Version..: '5.30.07-13.05.31(00010)'     #
#
# Pattern name...: axcp322.4gl
# Descriptions...: 销货成本分录底稿整批生成作业
# Date & Author..: 10/07/08 By elva   #No.FUN-AA0025
# Modify.........:
# Modify.........: No:FUN-B40056 11/05/13 By guoch 刪除資料時一併刪除tic_file的資料
# Modify.........: No:TQC-B70021 11/07/19 By wujie 抛转tic_file资料
# Modify.........: No:TQC-BB0046 11/11/04 By yinhy 分錄底稿根據幣種取位
# Modify.........: No:FUN-BB0038 11/11/21 By elva 成本改善
# Modify.........: No.FUN-C80094 12/08/27 By xuxz 添加傳參l_prog判斷來源作業
# Modify.........: No.FUN-CB0061 12/11/20 By wujie 产生分录时为关系人客户增加核算项
# Modify.........: No.TQC-D20046 13/02/25 By xuxz 發出商品問題修改
# Modify.........: No:MOD-D50164 13/05/20 By bart g_success預設為Y
# Modify.........: No:FUN-D40118 13/05/21 By lujh 若科目npq03有做核算控管aag44=Y,但agli122作業沒有維護，則科目給空
# Modify.........: No.FUN-D60025 13/06/05 by yuhuabao 根據系統設置自動帶摘要已經核算項

DATABASE ds   

#No.FUN-AA0025
GLOBALS "../../config/top.global"

FUNCTION p322_gl(tm,l_prog)  #FUN-BB0038#FUN-C80094 add l_prog
DEFINE l_npp       RECORD LIKE npp_file.*
DEFINE l_npq       RECORD LIKE npq_file.*
DEFINE l_cdj       RECORD LIKE cdj_file.*
DEFINE l_date      LIKE type_file.dat
DEFINE l_sql       STRING
DEFINE l_ccz12     LIKE ccz_file.ccz12 
DEFINE l_ccz21     LIKE ccz_file.ccz21
DEFINE l_wc        STRING
DEFINE l_npq02     LIKE npq_file.npq02
DEFINE l_cdj01     LIKE cdj_file.cdj01
DEFINE l_cdj02     LIKE cdj_file.cdj02
DEFINE l_cdj03     LIKE cdj_file.cdj03
DEFINE l_cdj04     LIKE cdj_file.cdj04
DEFINE l_cdj08     LIKE cdj_file.cdj08
DEFINE l_cdj09     LIKE cdj_file.cdj09
DEFINE l_cdj12     LIKE cdj_file.cdj12
DEFINE g_wc        STRING 
DEFINE b           LIKE aaa_file.aaa01
DEFINE l_n         LIKE type_file.num5
DEFINE l_sumc      LIKE npq_file.npq07
DEFINE l_sumd      LIKE npq_file.npq07
DEFINE l_sumfc     LIKE npq_file.npq07f
DEFINE l_sumfd     LIKE npq_file.npq07f  
DEFINE l_prog      LIKE type_file.chr1 #FUN-C80094 add
#FUN-BB0038 --begin
DEFINE tm          RECORD 
                   tlfctype    LIKE tlfc_file.tlfctype,
                   yy          LIKE type_file.num5,
                   mm          LIKE type_file.num5,
                   b           LIKE aaa_file.aaa01
                   END RECORD 
DEFINE l_cdj14     LIKE cdj_file.cdj14
DEFINE l_cdj142    LIKE cdj_file.cdj142
DEFINE l_cdj15     LIKE cdj_file.cdj15
#FUN-BB0038 --end                   
DEFINE l_cdj00     LIKE cdj_file.cdj00   #FUN-C80094 add
DEFINE l_flag      LIKE type_file.chr1   #FUN-D40118 add
#DEFINE g_aag44     LIKE aag_file.aag44   #FUN-D40118 add #mark by dengsy170620
DEFINE l_bookno1   LIKE aza_file.aza81   #FUN-D60025
DEFINE l_bookno2   LIKE aza_file.aza82   #FUN-D60025
DEFINE l_bookno3   LIKE aza_file.aza81   #FUN-D60025

   WHENEVER ERROR CALL cl_err_msg_log
   INITIALIZE l_cdj.* TO NULL

   #LET g_success = 'N'   #MOD-D50164
   LET g_success = 'Y'  #MOD-D50164
#FUN-BB0038 --begin   
#  LET l_wc = cl_replace_str(g_wc,"ccc07","cdj04")
#  LET l_wc = cl_replace_str(l_wc,"ccc02","cdj02")
#  LET l_wc = cl_replace_str(l_wc,"ccc03","cdj03")   
   #FUN-C80094 add--str
   IF l_prog = '1' THEN LET l_cdj00 = '1' END IF
   IF l_prog = '2' THEN LET l_cdj00 = '2' END IF 
   IF l_prog = '3' THEN LET l_cdj00 = '3' END IF 
   #FUN-C80094--add--end
   
   SELECT ccz12,ccz21 INTO l_ccz12,l_ccz21 FROM ccz_file 
   
   LET l_sql = "SELECT DISTINCT cdj01,cdj02,cdj03,cdj04 ",
               "  FROM cdj_file ",
           #    " WHERE ",l_wc CLIPPED   
               " WHERE cdj01 ='",tm.b CLIPPED,"'",               
               "   AND cdj02 = '",tm.yy CLIPPED,"'",
               "   AND cdj03 = '",tm.mm CLIPPED,"'", 
               "   AND cdj04 = '",tm.tlfctype CLIPPED,"'"
               ,"   AND cdj00 = '",l_cdj00,"'" #FUN-C80094 add
#FUN-BB0038 --end                 

   PREPARE p322_p3 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      LET g_success ='N'
      RETURN
   END IF
   DECLARE p322_c3 CURSOR FOR p322_p3

   #FUN-BB0038 --begin
#  LET l_sql = "SELECT cdj01,cdj02,cdj03,cdj04,cdj08,SUM(cdj12) ",
#              "  FROM cdj_file ",
#              " WHERE cdj01 =? ",
#              "   AND cdj02 =? ",
#              "   AND cdj03 =? ",
#              "   AND cdj04 =? ",
#              "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj08 ",
#              "ORDER BY cdj01,cdj02,cdj03,cdj04,cdj08 " 
   LET l_sql = "SELECT cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142,cdj15,SUM(cdj12) ",
               "  FROM cdj_file,aag_file ",
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj04 =? ", 
               "   AND cdj08 =aag01 AND cdj01=aag00", 
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add
               "   AND aag05 = 'Y' ",
               "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142,cdj15 ",
               " UNION ",
               "SELECT cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142,' ',SUM(cdj12) ",
               "  FROM cdj_file,aag_file ",
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj04 =? ",  
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add 
               "   AND cdj08 =aag01 AND cdj01=aag00", 
               "   AND (aag05 = 'N' OR aag05 IS null) ",
               "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142 ",
               " UNION ",
               "SELECT cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142,cdj15,SUM(cdj12) ",
               "  FROM cdj_file",#aag_file ",#FUN-C80094 mark aag_file
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj04 =? ",  
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add
               "   AND cdj08 is null",
               " GROUP BY cdj01,cdj02,cdj03,cdj04,cdj08,cdj14,cdj142,cdj15 "                                                                         
   #FUN-BB0038 --end

   PREPARE p322_p4 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      LET g_success ='N'
      RETURN
   END IF
   DECLARE p322_c4 CURSOR FOR p322_p4

   #FUN-BB0038 --begin
#  LET l_sql = "SELECT cdj01,cdj02,cdj03,cdj04,cdj09,SUM(cdj12) ",
#              "  FROM cdj_file ",
#              " WHERE cdj01 =? ",
#              "   AND cdj02 =? ",
#              "   AND cdj03 =? ",
#              "   AND cdj04 =? ",
#              "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj09 ",
#              "ORDER BY cdj01,cdj02,cdj03,cdj04,cdj09 " 
   LET l_sql = "SELECT cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142,cdj15,SUM(cdj12) ",
               "  FROM cdj_file,aag_file ",
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add
               "   AND cdj04 =? ", 
               "   AND cdj09 =aag01 AND cdj01=aag00", 
               "   AND aag05 = 'Y' ",               
               "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142,cdj15 ",
               " UNION ",
               "SELECT cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142,'',SUM(cdj12) ",
               "  FROM cdj_file,aag_file ",
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj04 =? ",  
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add
               "   AND cdj09 =aag01 AND cdj01=aag00", 
               "   AND (aag05 = 'N' OR aag05 IS null) ",
               "GROUP BY cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142 ",
               " UNION ",
               "SELECT cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142,cdj15,SUM(cdj12) ",
               "  FROM cdj_file",#aag_file ",#FUN-C80094 mark aag_file
               " WHERE cdj01 =? ",
               "   AND cdj02 =? ",
               "   AND cdj03 =? ",
               "   AND cdj04 =? ",  
               "   AND cdj00 = '",l_cdj00,"'", #FUN-C80094 add
               "   AND cdj09 is null",
               " GROUP BY cdj01,cdj02,cdj03,cdj04,cdj09,cdj14,cdj142,cdj15 "
               
   #FUN-BB0038 --end

   PREPARE p322_p5 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1) 
      LET g_success ='N'
      RETURN
   END IF
   DECLARE p322_c5 CURSOR FOR p322_p5
   
   FOREACH p322_c3 INTO l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04  
      IF SQLCA.sqlcode THEN
         CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
         LET g_success ='N'
         RETURN 
      END IF 
      INITIALIZE l_npp.* TO NULL
      IF l_cdj.cdj01 = l_ccz12 THEN 
         LET l_npp.npptype =0
      ELSE
         LET l_npp.npptype =1
      END IF  
      LET l_date = MDY(l_cdj.cdj03,1,l_cdj.cdj02)
      LET l_npp.nppsys   = 'CA'
      LET l_npp.npp00    = 4
      LET l_npp.npp01    = 'C',l_cdj.cdj04 CLIPPED,l_cdj.cdj01 CLIPPED,'-',l_cdj.cdj02 USING '&&&&',l_cdj.cdj03 CLIPPED USING '&&','0001'
      #FUN-C80094 add--str
      IF l_cdj00 = '2' THEN 
         LET l_npp.npp01    = 'C',l_cdj.cdj04 CLIPPED,l_cdj.cdj01 CLIPPED,'-',l_cdj.cdj02 USING '&&&&',l_cdj.cdj03 CLIPPED USING '&&','0002'
      ELSE
         IF l_cdj00 = '3' THEN 
            LET l_npp.npp01    = 'C',l_cdj.cdj04 CLIPPED,l_cdj.cdj01 CLIPPED,'-',l_cdj.cdj02 USING '&&&&',l_cdj.cdj03 CLIPPED USING '&&','0003'
         END IF 
      END IF 
      #FUN-C80094 add--end
      LET l_npp.npp011   = 1
      LET l_npp.npp02    = s_last(l_date)
      LET l_npp.npp03    = NULL
      SELECT DISTINCT cdjlegal INTO l_npp.npplegal 
        FROM cdj_file 
       WHERE cdj01 = l_cdj.cdj01
         AND cdj02 = l_cdj.cdj02
         AND cdj03 = l_cdj.cdj03
         AND cdj04 = l_cdj.cdj04
         
      LET l_npp.nppglno  = NULL
      LET l_npp.npp07 = l_cdj.cdj01
      LET l_npp.npp06 = g_plant
      SELECT COUNT(*) INTO l_n FROM npp_file
       WHERE nppsys  = 'CA'
         AND npp00   = 4
         AND npp01   = l_npp.npp01
         AND npp011  = 1
         AND npptype = l_npp.npptype
         AND nppglno IS NOT NULL 
         
      IF l_n >0 THEN  
         CALL cl_err(l_npp.npp01,'axm-275',1)
         LET g_success ='N' 
         RETURN 
      END IF 
                
      DELETE FROM npp_file
       WHERE nppsys  = 'CA'
         AND npp00   = 4
         AND npp01   = l_npp.npp01
         AND npp011  = 1
         AND npptype = l_npp.npptype
      
      INSERT INTO npp_file VALUES(l_npp.*)
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL s_errmsg('nppsys','CA','insert npp_file',SQLCA.sqlcode,1)
         LET g_success = 'N'
         RETURN
      END IF

#抓取帐套
#FUN-D60025 ------------ begin by yuhuabao 13/06/05
       CALL s_get_bookno(YEAR(l_npp.npp02)) RETURNING l_flag,l_bookno1,l_bookno2
       IF l_flag =  '1' THEN  #抓不到帳別
         CALL cl_err(l_npp.npp02,'aoo-081',1)
         LET g_success = 'N'
         RETURN
       END IF
       IF l_npp.npptype = '0' THEN
         LET l_bookno3 = l_bookno1
       ELSE
         LET l_bookno3 = l_bookno2
       END IF
#FUN-D60025 ------------ end by yuhuabao 13/06/05

   #insert npq_file 單身
      DELETE FROM npq_file
       WHERE npqsys  = 'CA'
         AND npq00   = 4
         AND npq01   = l_npp.npp01
         AND npq011  = 1
         AND npqtype = l_npp.npptype

    #FUN-B40056 --begin
      DELETE FROM tic_file
       WHERE tic04 = l_npp.npp01
    #FUN-B40056 --end
      LET l_npq02 = 1
      INITIALIZE l_npq.* TO NULL
      FOREACH p322_c4 USING  l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04,l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04,l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04 #FUN-BB0038
                       INTO l_cdj01,l_cdj02,l_cdj03,l_cdj04,l_cdj08,l_cdj14,l_cdj142,l_cdj15,l_cdj12   #FUN-BB0038                 
         IF STATUS THEN LET g_success = 'N' RETURN END IF
         INITIALIZE l_npq.* TO NULL
         LET l_npq.npqsys ='CA'
         LET l_npq.npq00  = 4
         LET l_npq.npq01  =l_npp.npp01
         LET l_npq.npq011 = 1
         LET l_npq.npq02 = l_npq02
         LET l_npq.npq03 = l_cdj08
         LET l_npq.npq04 = ''
         LET l_npq.npq05 = l_cdj15 #FUN-BB0038 
         LET l_npq.npq06 = '1'
         LET l_npq.npq07f = l_cdj12  
         LET l_npq.npq07  = l_cdj12  
         #No.TQC-BB0046  --Begin
         #LET l_npq.npq07f = cl_digcut(l_npq.npq07f,2)  #TQC-BB0046
         #LET l_npq.npq07  = cl_digcut(l_npq.npq07,2)   #TQC-BB0046
         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
         LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04) #No.TQC-BB0246 modify: g_azi->t_azi
         #No.TQC-BB0046  --End 
         LET l_npq.npq08 = NULL
         LET l_npq.npq11 = ' '
         LET l_npq.npq12 = ' '
         LET l_npq.npq13 = ' '
         LET l_npq.npq14 = ' '
         LET l_npq.npq15 = NULL
         LET l_npq.npq21 = l_cdj14  #FUN-BB0038
         LET l_npq.npq22 = l_cdj142 #FUN-BB0038
         LET l_npq.npq24 = g_aza.aza17
         LET l_npq.npq25 = 1
         LET l_npq.npq30 = l_npp.npp06
         LET l_npq.npq31 = ' '
         LET l_npq.npq32 = ' '
         LET l_npq.npq33 = ' '
         LET l_npq.npq34 = ' '
         LET l_npq.npq35 = ' '
         LET l_npq.npq36 = ' '
         CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',l_bookno3)       #FUN-D60025 add by yuhuabao130605
           RETURNING l_npq.*                                                   #FUN-D60025 add by yuhuabao130605
#No.FUN-CB0061 --begin
#         LET l_npq.npq37 = ' '
         CALL p322_set_npq37(l_cdj.cdj01,l_npq.*)
          RETURNING  l_npq.npq11,l_npq.npq37
#No.FUN-CB0061 --end
         LET l_npq.npqtype = l_npp.npptype
         LET l_npq.npqlegal =l_npp.npplegal
         #str----- mark by dengsy170620
         ##FUN-D40118--add--str--
         #SELECT aag44 INTO g_aag44 FROM aag_file
         # WHERE aag00 = tm.b
         #   AND aag01 = l_npq.npq03
         #IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
         #   CALL s_chk_ahk(l_npq.npq03,tm.b) RETURNING l_flag
         #   IF l_flag = 'N'   THEN
         #      LET l_npq.npq03 = ''
         #   END IF
         #END IF
         ##FUN-D40118--add--end--
         #end----- mark by dengsy170620
         INSERT INTO npq_file VALUES(l_npq.*)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
            CALL s_errmsg('npq03',l_npq.npq03,'insert npq_file',SQLCA.sqlcode,1)
            LET g_success = 'N'
            RETURN
         END IF
         LET l_npq02 = l_npq02 + 1 
         LET g_success ='Y'
      END FOREACH 

      INITIALIZE l_npq.* TO NULL
      FOREACH p322_c5 USING  l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04,l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04,l_cdj.cdj01,l_cdj.cdj02,l_cdj.cdj03,l_cdj.cdj04 #FUN-BB0038
                       INTO l_cdj01,l_cdj02,l_cdj03,l_cdj04,l_cdj09,l_cdj14,l_cdj142,l_cdj15,l_cdj12 #FUN-BB0038                  
         IF STATUS THEN LET g_success = 'N' RETURN END IF
         INITIALIZE l_npq.* TO NULL
         LET l_npq.npqsys ='CA'
         LET l_npq.npq00  = 4
         LET l_npq.npq01  =l_npp.npp01
         LET l_npq.npq011 = 1
         LET l_npq.npq02 = l_npq02
         LET l_npq.npq03 = l_cdj09
         LET l_npq.npq04 = ''
         LET l_npq.npq05 = l_cdj15 #FUN-BB0038 
         LET l_npq.npq06 = '2'
         LET l_npq.npq07f = l_cdj12
         LET l_npq.npq07  = l_cdj12
         #No.TQC-BB0046  --Begin
         #LET l_npq.npq07f = cl_digcut(l_npq.npq07f,2)  #TQC-BB0046
         #LET l_npq.npq07  = cl_digcut(l_npq.npq07,2)   #TQC-BB0046

         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
         LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04) #No.TQC-BB0246 modify: g_azi->t_azi
         #No.TQC-BB0046  --End
         LET l_npq.npq08 = NULL
         LET l_npq.npq11 = ' '
         LET l_npq.npq12 = ' '
         LET l_npq.npq13 = ' '
         LET l_npq.npq14 = ' '
         LET l_npq.npq15 = NULL
         LET l_npq.npq21 = l_cdj14  #FUN-BB0038
         LET l_npq.npq22 = l_cdj142 #FUN-BB0038
         LET l_npq.npq24 = g_aza.aza17
         LET l_npq.npq25 = 1
         LET l_npq.npq30 = l_npp.npp06
         LET l_npq.npq31 = ' '
         LET l_npq.npq32 = ' '
         LET l_npq.npq33 = ' '
         LET l_npq.npq34 = ' '
         LET l_npq.npq35 = ' '
         LET l_npq.npq36 = ' '
         CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',l_bookno3)       #FUN-D60025 add by yuhuabao130605
           RETURNING l_npq.*                                                   #FUN-D60025 add by yuhuabao130605
#No.FUN-CB0061 --begin
#         LET l_npq.npq37 = ' '
         CALL p322_set_npq37(l_cdj.cdj01,l_npq.*)
          RETURNING  l_npq.npq11,l_npq.npq37
#No.FUN-CB0061 --end
         LET l_npq.npqtype = l_npp.npptype
         LET l_npq.npqlegal =l_npp.npplegal
         #str----- mark by dengsy170620
         ##FUN-D40118--add--str--
         #SELECT aag44 INTO g_aag44 FROM aag_file
         # WHERE aag00 = tm.b
         #   AND aag01 = l_npq.npq03
         #IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
         #   CALL s_chk_ahk(l_npq.npq03,tm.b) RETURNING l_flag
         #   IF l_flag = 'N'   THEN
         #      LET l_npq.npq03 = ''
         #   END IF
         #END IF
         ##FUN-D40118--add--end--
         #end----- mark by dengsy170620
         INSERT INTO npq_file VALUES(l_npq.*)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
            CALL s_errmsg('npq03',l_npq.npq03,'insert npq_file',SQLCA.sqlcode,1)
            LET g_success = 'N'
            RETURN
         END IF
         LET l_npq02 = l_npq02 + 1 
         LET g_success ='Y'      
      END FOREACH 
   END FOREACH 
   IF NOT cl_null(l_npp.npp01) THEN
      LET l_cdj.cdj13 = l_npp.npp01
      UPDATE cdj_file SET cdj13 = l_cdj.cdj13
       WHERE cdj01 = l_cdj.cdj01
         AND cdj02 = l_cdj.cdj02
         AND cdj03 = l_cdj.cdj03
         AND cdj04 = l_cdj.cdj04
         AND cdj00 = l_cdj00      #luttb FUN-C80094 120905-add

   END IF   
    SELECT SUM(npq07) INTO l_sumc FROM npq_file 
       WHERE npqsys  = 'CA'
         AND npq00   = 4
         AND npq01   = l_npp.npp01
         AND npq011  = 1
         AND npqtype = l_npp.npptype 
         AND npq06   = '1'

    SELECT SUM(npq07) INTO l_sumd FROM npq_file 
       WHERE npqsys  = 'CA'
         AND npq00   = 4
         AND npq01   = l_npp.npp01
         AND npq011  = 1
         AND npqtype = l_npp.npptype 
         AND npq06   = '2'

    SELECT SUM(npq07f) INTO l_sumfc FROM npq_file 
       WHERE npqsys  = 'CA'
         AND npq00   = 4
         AND npq01   = l_npp.npp01
         AND npq011  = 1
         AND npqtype = l_npp.npptype 
         AND npq06   = '1'

    SELECT SUM(npq07f) INTO l_sumfd FROM npq_file 
       WHERE npqsys  = 'CA'
         AND npq00   = 4
         AND npq01   = l_npp.npp01
         AND npq011  = 1
         AND npqtype = l_npp.npptype 
         AND npq06   = '2'

   IF cl_null(l_sumc) THEN LET l_sumc =0 END IF 
   IF cl_null(l_sumd) THEN LET l_sumd =0 END IF 
   IF cl_null(l_sumfc) THEN LET l_sumfc =0 END IF 
   IF cl_null(l_sumfd) THEN LET l_sumfd =0 END IF 

   IF g_success ='Y' AND l_sumc <> l_sumd THEN 
         INITIALIZE l_npq.* TO NULL
         LET l_npq.npqsys ='CA'
         LET l_npq.npq00  = 4
         LET l_npq.npq01  =l_npp.npp01
         LET l_npq.npq011 = 1
         LET l_npq.npq02 = l_npq02
         LET l_npq.npq03 = l_ccz21         
         LET l_npq.npq04 = ''
         LET l_npq.npq05 = NULL  
         IF l_sumc - l_sumd >0 THEN
            LET l_npq.npq06 = '2'
            LET l_npq.npq07f = l_sumfc - l_sumfd 
            LET l_npq.npq07  = l_sumc  - l_sumd         
         ELSE 
            LET l_npq.npq06 = '1'          	
            LET l_npq.npq07f = l_sumfd - l_sumfc 
            LET l_npq.npq07  = l_sumd  - l_sumc
         END IF 
         #No.TQC-BB0046  --Begin
         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
         LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04) #No.TQC-BB0246 modify: g_azi->t_azi
         #No.TQC-BB0046  --End
         LET l_npq.npq08 = NULL
         LET l_npq.npq11 = ' '
         LET l_npq.npq12 = ' '
         LET l_npq.npq13 = ' '
         LET l_npq.npq14 = ' '
         LET l_npq.npq15 = NULL
         LET l_npq.npq21 = NULL
         LET l_npq.npq22 = NULL
         LET l_npq.npq24 = g_aza.aza17
         LET l_npq.npq25 = 1
         LET l_npq.npq30 = l_npp.npp06
         LET l_npq.npq31 = ' '
         LET l_npq.npq32 = ' '
         LET l_npq.npq33 = ' '
         LET l_npq.npq34 = ' '
         LET l_npq.npq35 = ' '
         LET l_npq.npq36 = ' '
          CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',l_bookno3)       #FUN-D60025 add by yuhuabao130605
           RETURNING l_npq.*                                                   #FUN-D60025 add by yuhuabao130605
#No.FUN-CB0061 --begin
#         LET l_npq.npq37 = ' '
         CALL p322_set_npq37(l_cdj.cdj01,l_npq.*)
          RETURNING  l_npq.npq11,l_npq.npq37
#No.FUN-CB0061 --end
         LET l_npq.npqtype = l_npp.npptype
         LET l_npq.npqlegal =l_npp.npplegal
         #str------ mark by dengsy170620
         ##FUN-D40118--add--str--
         #SELECT aag44 INTO g_aag44 FROM aag_file
         # WHERE aag00 = tm.b
         #   AND aag01 = l_npq.npq03
         #IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
         #   CALL s_chk_ahk(l_npq.npq03,tm.b) RETURNING l_flag
         #   IF l_flag = 'N'   THEN
         #      LET l_npq.npq03 = ''
         #   END IF
         #END IF
         ##FUN-D40118--add--end--
         #end------ mark by dengsy170620
         INSERT INTO npq_file VALUES(l_npq.*)
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
            CALL s_errmsg('npq03',l_npq.npq03,'insert npq_file',SQLCA.sqlcode,1)
            LET g_success = 'N'
            RETURN
         END IF
         LET l_npq02 = l_npq02 + 1   
   END IF 
   CALL s_flows('3','',l_npq.npq01,l_npp.npp02,'N',l_npq.npqtype,TRUE)   #No.TQC-B70021  
   IF g_success ='Y' AND g_prog ='axct322' THEN CALL cl_err('','abm-019',0) END IF 
   IF g_success ='N' THEN CALL cl_err('','aap-129',0) END IF 
END FUNCTION
#No.FUN-CB0061 --begin
FUNCTION p322_set_npq37(p_bookno,p_npq)
DEFINE p_bookno    LIKE aag_file.aag00
DEFINE p_npq       RECORD LIKE npq_file.*
DEFINE l_occ37     LIKE occ_file.occ37
DEFINE l_aag37     LIKE aag_file.aag37
#DEFINE l_aag43     LIKE aag_file.aag43 #mark by dengsy170620
DEFINE l_aag151    LIKE aag_file.aag151

    IF cl_null(p_npq.npq21) THEN 
       RETURN ' ',' '
    END IF 
    SELECT occ37 INTO l_occ37 FROM occ_file WHERE occ01 = p_npq.npq21#TQC-D20046 mod l_npq.np21 --->p_npq.npp21
    IF l_occ37 = 'N' THEN RETURN ' ',' ' END IF 
    #SELECT aag37,aag43,aag151 INTO l_aag37,l_aag43,l_aag151 #mark by dengsy170620
   SELECT aag37,aag151 INTO l_aag37,l_aag151  #add by dengsy170620 
    FROM aag_file WHERE aag00 = p_bookno AND aag01 = p_npq.npq03
    IF cl_null(l_aag37) THEN CALL cl_err(p_npq.npq03,'axc-920','0') RETURN ' ',' ' END IF 
    LET p_npq.npq37 = p_npq.npq21
    #str----- mark by dengsy170620
    #IF l_aag43 ='Y' AND l_aag151 IS NOT NULL THEN 
    #	 LET p_npq.npq11 = p_npq.npq21
    #END IF 
    #end----- mark by dengsy170620
    RETURN p_npq.npq11,p_npq.npq37
END FUNCTION 
#No.FUN-CB0061 --end
