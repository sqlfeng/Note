# Prog. Version..: '5.30.06-13.03.12(00002)'     #
#
# Pattern name...: axcp330.4gl
# Descriptions...: 發出商品分录底稿整批生成作业
# Date & Author..: 12/08/27 By xuxz  No:FUN-C80094
# Modify.........: No:FUN-C90002 12/09/07 By minpp 成本计算类型也给默认值ccz28
# Modify.........: No:MOD-CB0205 12/11/21 By wujie FOREACH循环时要清空cdj
# Modify.........: No.MOD-D50131 13/05/15 By wujie 不产生金额为0的cdj资料
# Modify.........: No.FUN-D70068 13/07/11 By zhangweib 修改不納入成本計算oaz93 = N的邏輯,將本月cfc轉入的資料都轉入發出商品科目

DATABASE ds   

GLOBALS "../../config/top.global"
#No:FUN-C80094 add
#模組變數(Module Variables)
DEFINE g_cdj               RECORD LIKE cdj_file.* 
DEFINE g_cfc               RECORD LIKE cfc_file.*
DEFINE g_sum               LIKE type_file.num15_3
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
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("AXC")) THEN
      EXIT PROGRAM
   END IF
   SELECT oaz92,oaz93,oaz107 INTO g_oaz.oaz92,g_oaz.oaz93,g_oaz.oaz107 FROM oaz_file
   IF (g_oaz.oaz92='Y' AND g_oaz.oaz93='Y' AND g_oaz.oaz107='Y') or (g_oaz.oaz92='Y' AND g_oaz.oaz93='N') THEN 
   ELSE
      CALL cl_err('','axc-911',1)
      EXIT PROGRAM
   END IF 
   IF cl_null(tm.b) THEN LET tm.b = g_aza.aza81 END IF
   LET g_time = TIME   
     CALL  cl_used(g_prog,g_time,1) RETURNING g_time 
 
   WHILE TRUE
      LET g_success = 'Y'
      IF g_bgjob = "N" THEN
         CALL p330_tm()
         IF cl_sure(18,20) THEN 
            CALL p330_p() 
             IF g_success ='Y' THEN 
                CALL cl_end2(1) RETURNING l_flag
                IF l_flag THEN 
                   CONTINUE WHILE 
                ELSE 
                   CLOSE WINDOW p330_w
                   EXIT WHILE 
                END IF
             ELSE
                CALL cl_end2(2) RETURNING l_flag
                IF l_flag THEN 
                   CONTINUE WHILE 
                ELSE 
                   CLOSE WINDOW p330_w
                   EXIT WHILE 
                END IF

             END IF  
          ELSE
            CONTINUE WHILE
         END IF
         CLOSE WINDOW p330_w
      ELSE
         CALL p330_p()
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
   END WHILE
   CALL  cl_used(g_prog,g_time,2) RETURNING g_time   
END MAIN

FUNCTION p330_tm()
DEFINE p_row,p_col    LIKE type_file.num5  
 
   LET p_row = 4 LET p_col = 20
   OPEN WINDOW p330_w AT p_row,p_col WITH FORM "axc/42f/axcp323" 
      ATTRIBUTE (STYLE = g_win_style)
    
   CALL cl_ui_init() 
   CALL cl_opmsg('q')

   CLEAR FORM
   ERROR '' 
 
   
   #carrier 20130619  --Begin
   SELECT sma51,sma52 INTO tm.yy,tm.mm FROM sma_file
   LET tm.yy = g_ccz.ccz01
   LET tm.mm = g_ccz.ccz02
   #carrier 20130619  --End  
   DISPLAY BY NAME tm.tlfctype,tm.yy,tm.mm,tm.b
   LET g_bgjob = 'N'   
   INPUT BY NAME
      tm.tlfctype,tm.yy,tm.mm,tm.b       
      WITHOUT DEFAULTS 

      BEFORE INPUT                            #FUN-C90002
         LET tm.tlfctype = g_ccz.ccz28        #FUN-C90002

      AFTER FIELD b
         IF NOT cl_null(tm.b) THEN
            CALL p330_bookno(tm.b)
            IF NOT cl_null(g_errno) THEN
               CALL cl_err(tm.b,g_errno,0)
               LET tm.b = g_aza.aza81
               DISPLAY BY NAME tm.b
               NEXT FIELD b
            END IF
         END IF
 
      AFTER FIELD tlfctype
         IF tm.tlfctype NOT MATCHES '[12345]' THEN 
            LET tm.tlfctype =NULL 
            NEXT FIELD tlfctype
         END IF  
 
      AFTER INPUT
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            CLOSE WINDOW p330_w
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
 
      ON ACTION about         
         CALL cl_about()      
      
      ON ACTION HELP          
         CALL cl_show_help()  
      
      ON ACTION controlg      
            CALL cl_cmdask()     
      
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
      CLOSE WINDOW p330_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time 
      EXIT PROGRAM
   END IF
END FUNCTION

FUNCTION p330_p()
   
   CALL s_showmsg_init()
   BEGIN WORK 
   LET g_success = 'Y'
   CALL p330_chk()
   IF g_flag ='N' THEN LET g_success = 'N' ROLLBACK WORK RETURN END IF   
   CALL p330_ins_cdj()
   IF g_success ='N' THEN 
      ROLLBACK WORK 
      RETURN 
   END IF 
   CALL p322_gl(tm.*,'2')   
   IF g_success ='N' THEN 
      ROLLBACK WORK 
   ELSE       
      COMMIT WORK 
   END IF 
   CALL s_showmsg()
END FUNCTION 

FUNCTION p330_ins_cdj()
   DEFINE l_ccz07 LIKE ccz_file.ccz07
   DEFINE l_ccz12 LIKE ccz_file.ccz12
   DEFINE l_oga02 LIKE oga_file.oga02
   DEFINE l_cdj    RECORD LIKE cdj_file.*
   DEFINE l_sql   STRING
   DEFINE l_n     LIKE type_file.num10

   #纳入成本计算时
   IF g_oaz.oaz92='Y' AND g_oaz.oaz93='Y' THEN
      DECLARE p330_c1 CURSOR  FOR
        SELECT * FROM cfc_file 
         WHERE cfc01=1 
           AND cfc05*12+cfc06<=tm.yy*12+tm.mm
#No.MOD-CB0205 --begin      
#      LET g_cdj.cdj00='2'	
#      LET g_cdj.cdj01=tm.b
#      LET g_cdj.cdj02=tm.yy
#      LET g_cdj.cdj03=tm.mm
#      LET g_cdj.cdj04=tm.tlfctype
#      LET g_cdj.cdj17 = 1  
#No.MOD-CB0205 --end    
   
      FOREACH p330_c1 INTO g_cfc.*	
#No.MOD-CB0205 --begin      
         INITIALIZE g_cdj.* TO NULL
         LET g_cdj.cdj00='2'	
         LET g_cdj.cdj01=tm.b
         LET g_cdj.cdj02=tm.yy
         LET g_cdj.cdj03=tm.mm
         LET g_cdj.cdj04=tm.tlfctype
         SELECT MAX(cdj17)+1 INTO g_cdj.cdj17 FROM cdj_file
          WHERE cdj00 = '2' AND cdj01 = tm.b
            AND cdj02 = tm.yy
            AND cdj03 = tm.mm
            AND cdj04 = tm.tlfctype
         IF cl_null(g_cdj.cdj17) THEN LET g_cdj.cdj17 = 1 END IF 
				#No.MOD-CB0205 --end
         SELECT SUM(cfc15) INTO g_sum FROM cfc_file
        #FUN-D70068--mod--str--
         #WHERE cfc01=-1 AND cfc05*12+cfc06<=tm.yy*12+tm.mm
         #  AND cfc03=g_cfc.cfc03 AND cfc04=g_cfc.cfc04     
          WHERE cfc01=-1 AND cfc21*12+cfc22<=tm.yy*12+tm.mm  
            AND cfc00 = g_cfc.cfc00 AND cfc02 = g_cfc.cfc02 AND cfc07  =g_cfc.cfc07
            AND cfc11 = g_cfc.cfc11 AND cfc12 = g_cfc.cfc12 AND cfc17 = g_cfc.cfc17 
            AND cfc19 = g_cfc.cfc19 AND cfc05 = g_cfc.cfc05 AND cfc06 = g_cfc.cfc06
        #FUN-D70068--mod--end
         IF cl_null(g_sum) THEN LET g_sum = 0 END IF
         IF g_sum=g_cfc.cfc15  THEN CONTINUE FOREACH END IF
         #开票数量<>出货数量时，转入发出商品		
         LET g_cdj.cdj06=g_cfc.cfc11
         LET g_cdj.cdj07=' '	
         LET g_cdj.cdj14=g_cfc.cfc07	
         LET g_cdj.cdj142=g_cfc.cfc08
         LET g_cdj.cdj15=g_cfc.cfc10
         LET g_cdj.cdjconf = 'N' 
         LET g_cdj.cdjlegal = g_legal
      
         #借方：发出商品														
         SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file
         IF g_cdj.cdj01 = l_ccz12 THEN 			
            CASE  
               WHEN l_ccz07='2'			
                  SELECT imz163 INTO g_cdj.cdj08
                    FROM ima_file,imz_file
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01
               OTHERWISE				
                  SELECT ima163 INTO g_cdj.cdj08 FROM ima_file
                   WHERE ima01=g_cdj.cdj06  
            END CASE                
         ELSE				
            CASE
               WHEN l_ccz07='2'	
                  SELECT imz1631 INTO g_cdj.cdj08
                    FROM ima_file,imz_file	
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01
               OTHERWISE				
                  SELECT ima1631 INTO g_cdj.cdj08 FROM ima_file
                   WHERE ima01=g_cdj.cdj06 
            END CASE                
         END IF	
            
         #贷方：库存商品	     
            SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file
            IF g_cdj.cdj01 = l_ccz12 THEN 	
               CASE  
                  WHEN l_ccz07='2'														
                     SELECT imz39 INTO g_cdj.cdj09	
                       FROM ima_file,imz_file
                       WHERE ima01=g_cdj.cdj06 AND ima12=imz01
                  OTHERWISE														
                     SELECT ima39 INTO g_cdj.cdj09 FROM ima_file	
                      WHERE ima01=g_cdj.cdj06 
               END CASE                   
            ELSE														
               CASE 
                  WHEN l_ccz07='2'														
                     SELECT imz391 INTO g_cdj.cdj09		
                       FROM ima_file,imz_file	
                      WHERE ima01=g_cdj.cdj06 AND ima12=imz01
                  OTHERWISE														
                     SELECT ima391 INTO g_cdj.cdj09 FROM ima_file	
                      WHERE ima01=g_cdj.cdj06 
               END CASE                   
            END IF		  												
    													
         DECLARE p330_c2 CURSOR  FOR														
          SELECT ccc08,ccc23  FROM ccc_file 
           WHERE ccc01=g_cfc.cfc11
            #luttb 120905--mod--str--
            #AND ccc02=g_cfc.cfc05 
            #AND ccc03=g_cfc.cfc06
             AND ccc02=tm.yy
             AND ccc03=tm.mm
            #luttb 120905--mod--end 
             AND ccc07=tm.tlfctype 														
         FOREACH p330_c2 INTO g_cdj.cdj05,g_cdj.cdj11		
            LET g_cdj.cdj10=g_cfc.cfc15-g_sum		
            LET g_cdj.cdj12=g_cdj.cdj10*g_cdj.cdj11 * g_cfc.cfc18   #No.FUN-D70068   Add g_cfc.cfc18
            IF g_cdj.cdj12 = 0 OR cl_null(g_cdj.cdj12) THEN CONTINUE FOREACH END IF     #No.MOD-D50131   #wujie 130615
            LET l_n = 0 
            SELECT COUNT(*) INTO l_n  FROM cdj_file
             WHERE cdj00 = '2' AND cdj01 = tm.b
               AND cdj02 = tm.yy
               AND cdj03 = tm.mm
               AND cdj04 = tm.tlfctype
               AND cdj05 = g_cdj.cdj05
               AND cdj06 = g_cdj.cdj06
               AND cdj15 = g_cdj.cdj15
            IF l_n = 0 THEN 
               INSERT INTO cdj_file VALUES g_cdj.*	
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
                  LET g_showmsg=g_cdj.cdj00,"/",g_cdj.cdj01,"/",g_cdj.cdj02,
                                "/",g_cdj.cdj03,"/",g_cdj.cdj04,"/",g_cdj.cdj05
                  CALL s_errmsg('cdj00,cdj01,cdj02,cdj03,cdj04,cdj05',g_showmsg,'ins_cdj',SQLCA.sqlcode,1)
                  LET g_success='N'
               ELSE
                  LET g_cdj.cdj17 = g_cdj.cdj17 + 1            
               END IF 
            ELSE
               UPDATE cdj_file SET cdj10 = cdj10 +g_cdj.cdj10,
                                   cdj12 = cdj12 +g_cdj.cdj12 
                WHERE cdj00 = '2' AND cdj01 = tm.b
                  AND cdj02 = tm.yy
                  AND cdj03 = tm.mm
                  AND cdj04 = tm.tlfctype
                  AND cdj05 = g_cdj.cdj05
                  AND cdj06 = g_cdj.cdj06
                  AND cdj15 = g_cdj.cdj15
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
                  LET g_showmsg=g_cdj.cdj00,"/",g_cdj.cdj01,"/",g_cdj.cdj02,
                                "/",g_cdj.cdj03,"/",g_cdj.cdj04,"/",g_cdj.cdj05
                  CALL s_errmsg('cdj00,cdj01,cdj02,cdj03,cdj04,cdj05',g_showmsg,'upd_cdj',SQLCA.sqlcode,1)
                  LET g_success='N'
               END IF
            END IF 
         END FOREACH
      END FOREACH          
   END IF														
   #不纳入成本计算时，成本单价抓出货月														 
   IF g_oaz.oaz92='Y' AND g_oaz.oaz93='N' THEN
      DECLARE p330_c12 CURSOR  FOR														
        SELECT * FROM cfc_file 
         WHERE cfc01=1 
           AND cfc05 = tm.yy AND cfc06 = tm.mm
           AND cfc21 = 0   #No.FUN-D70068   Add
           AND cfc22 = 0   #No.FUN-D70068   Add
      LET g_cdj.cdj00='2'														
      LET g_cdj.cdj01=tm.b														
      LET g_cdj.cdj02=tm.yy														
      LET g_cdj.cdj03=tm.mm														
      LET g_cdj.cdj04=tm.tlfctype
      LET g_cdj.cdj17 = 1    
   
      FOREACH p330_c12 INTO g_cfc.*														
         #No.FUN-D70068 ---Mark--- Start
        #SELECT SUM(cfc15) INTO g_sum FROM cfc_file
        # WHERE cfc01=-1 
        #   AND cfc03=g_cfc.cfc03 AND cfc04=g_cfc.cfc04	
        #   AND cfc05=tm.yy AND cfc06=tm.mm   #luttb
        #IF cl_null(g_sum) THEN LET g_sum = 0 END IF
        #IF g_sum=g_cfc.cfc15  THEN CONTINUE FOREACH END IF		
        #No.FUN-D70068 ---Mark--- End	
         #开票数量<>出货数量时，转入发出商品
         LET g_cdj.cdj06=g_cfc.cfc11														
         LET g_cdj.cdj07=' '														
         LET g_cdj.cdj14=g_cfc.cfc07														
         LET g_cdj.cdj142=g_cfc.cfc08														
         LET g_cdj.cdj15=g_cfc.cfc10	
         LET g_cdj.cdjconf = 'N' 
         LET g_cdj.cdjlegal = g_legal
      
         #借方：发出商品														
         SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file	
         IF g_cdj.cdj01 = l_ccz12 THEN 														
            CASE  
               WHEN l_ccz07='2'														
                  SELECT imz163 INTO g_cdj.cdj08	
                    FROM ima_file,imz_file
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01	
               OTHERWISE		
                   #str by lixiaa20170108												
                 # SELECT ima163 INTO g_cdj.cdj08 FROM ima_file
                 #  WHERE ima01=g_cdj.cdj06
                  SELECT  ool43 INTO g_cdj.cdj08 FROM ool_file,occ_file 
                 WHERE ool01=occ67 AND occ01=g_cdj.cdj14
                   #end by lixiaa20170108
            END CASE                
         ELSE														
            CASE 
               WHEN l_ccz07='2'														
                  SELECT imz1631 INTO g_cdj.cdj08
                    FROM ima_file,imz_file
                   WHERE ima01=g_cdj.cdj06 AND ima12=imz01
               OTHERWISE														
                  SELECT ima1631 INTO g_cdj.cdj08 FROM ima_file	
                   WHERE ima01=g_cdj.cdj06 
            END CASE                
         END IF				
         #贷方：库存商品	     
            SELECT ccz07,ccz12 INTO l_ccz07,l_ccz12 FROM ccz_file
            IF g_cdj.cdj01 = l_ccz12 THEN
               CASE  
                  WHEN l_ccz07='2'														
                     SELECT imz39 INTO g_cdj.cdj09		
                       FROM ima_file,imz_file		
                       WHERE ima01=g_cdj.cdj06 AND ima12=imz01
                  OTHERWISE														
                     SELECT ima39 INTO g_cdj.cdj09 FROM ima_file
                      WHERE ima01=g_cdj.cdj06 
               END CASE                   
            ELSE														
               CASE 
                  WHEN l_ccz07='2'														
                     SELECT imz391 INTO g_cdj.cdj09	
                       FROM ima_file,imz_file	
                      WHERE ima01=g_cdj.cdj06 AND ima12=imz01
                  OTHERWISE														
                     SELECT ima391 INTO g_cdj.cdj09 FROM ima_file  
                      WHERE ima01=g_cdj.cdj06 
               END CASE                   
            END IF		  												
         #zhouxm170926 add start 取aimi100料件主档
         SELECT ima163,ima39 INTO g_cdj.cdj08,g_cdj.cdj09 FROM ima_file
                   WHERE ima01=g_cdj.cdj06  
         #zhouxm170926 add end 											
         DECLARE p330_c22 CURSOR  FOR														
          SELECT ccc08,ccc23  FROM ccc_file 
           WHERE ccc01=g_cfc.cfc11 AND ccc02=tm.yy
             AND ccc03=tm.mm														
             AND ccc07=tm.tlfctype 														
         FOREACH p330_c22 INTO g_cdj.cdj05,g_cdj.cdj11		
             #LET g_cdj.cdj10=g_cfc.cfc15-g_sum   #No.FUN-D70068   Mark
            LET g_cdj.cdj10=g_cfc.cfc15         #No.FUN-D70068   Add
            LET g_cdj.cdj12=g_cdj.cdj10*g_cdj.cdj11 * g_cfc.cfc18   #No.FUN-D70068   Add	
            IF g_cdj.cdj12 = 0 OR cl_null(g_cdj.cdj12) THEN CONTINUE FOREACH END IF     #No.MOD-D50131  #wujie 130615
            LET l_n = 0             
            SELECT COUNT(*) INTO l_n  FROM cdj_file
             WHERE cdj00 = '2' AND cdj01 = tm.b
               AND cdj02 = tm.yy
               AND cdj03 = tm.mm
               AND cdj04 = tm.tlfctype
               AND cdj05 = g_cdj.cdj05
               AND cdj06 = g_cdj.cdj06
               AND cdj15 = g_cdj.cdj15
            IF l_n = 0 THEN 
               INSERT INTO cdj_file VALUES g_cdj.*	
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
                  LET g_showmsg=g_cdj.cdj00,"/",g_cdj.cdj01,"/",g_cdj.cdj02,
                                "/",g_cdj.cdj03,"/",g_cdj.cdj04,"/",g_cdj.cdj05
                  CALL s_errmsg('cdj00,cdj01,cdj02,cdj03,cdj04,cdj05',g_showmsg,'ins_cdj',SQLCA.sqlcode,1)
                  LET g_success='N'
               ELSE
                  LET g_cdj.cdj17 = g_cdj.cdj17 + 1            
               END IF 
            ELSE
               UPDATE cdj_file SET cdj10 = cdj10 +g_cdj.cdj10,
                                   cdj12 = cdj12 +g_cdj.cdj12 
                WHERE cdj00 = '2' AND cdj01 = tm.b
                  AND cdj02 = tm.yy
                  AND cdj03 = tm.mm
                  AND cdj04 = tm.tlfctype
                  AND cdj05 = g_cdj.cdj05
                  AND cdj06 = g_cdj.cdj06
                  AND cdj15 = g_cdj.cdj15
               IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
                  LET g_showmsg=g_cdj.cdj00,"/",g_cdj.cdj01,"/",g_cdj.cdj02,
                                "/",g_cdj.cdj03,"/",g_cdj.cdj04,"/",g_cdj.cdj05
                  CALL s_errmsg('cdj00,cdj01,cdj02,cdj03,cdj04,cdj05',g_showmsg,'upd_cdj',SQLCA.sqlcode,1)
                  LET g_success='N'
               END IF
            END IF
         END FOREACH
      END FOREACH          
   END IF    
END FUNCTION 

FUNCTION p330_chk()
DEFINE l_wc        STRING
DEFINE l_sql       STRING
DEFINE l_cnt       LIKE type_file.num5
DEFINE l_cdjconf   LIKE cdj_file.cdjconf 

   LET l_sql = "SELECT count(*) ",
               "  FROM cdj_file ",
               " WHERE cdj00 = '2' AND cdj01 ='",tm.b CLIPPED,"'",
               "   AND cdj02 = '",tm.yy CLIPPED,"'",
               "   AND cdj03 = '",tm.mm CLIPPED,"'", 
               "   AND cdj04 = '",tm.tlfctype CLIPPED,"'"

   PREPARE p330_p6 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      RETURN
   END IF
   DECLARE p330_c6 CURSOR FOR p330_p6
   LET l_sql = "DELETE ",
               "  FROM cdj_file ",
               " WHERE cdj00 = '2' AND cdj01 ='",tm.b CLIPPED,"'",
               "   AND cdj02 = '",tm.yy CLIPPED,"'",
               "   AND cdj03 = '",tm.mm CLIPPED,"'", 
               "   AND cdj04 = '",tm.tlfctype CLIPPED,"'"

   PREPARE p330_p7 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err('FILL PREPARE:',SQLCA.SQLCODE,1)
      RETURN
   END IF

   OPEN p330_c6 
   FETCH p330_c6 INTO l_cnt
   IF l_cnt >0 THEN 
      SELECT UNIQUE cdjconf INTO l_cdjconf FROM cdj_file
       WHERE cdj00 = '2' AND cdj01=tm.b 
         AND cdj02=tm.yy
         AND cdj03=tm.mm
         AND cdj04=tm.tlfctype
      IF l_cdjconf='Y' THEN
         CALL cl_err('','afa-364',1)
         LET g_flag='N'
      ELSE 
         IF cl_confirm('mfg8002') THEN 
            LET g_flag ='Y'
            EXECUTE p330_p7
         ELSE 
            LET g_flag ='N'
         END IF 
      END IF  
   ELSE 
      LET g_flag ='Y'
   END IF 
   CLOSE p330_c6 
END FUNCTION 
FUNCTION p330_bookno(p_bookno)
  DEFINE p_bookno   LIKE aaa_file.aaa01,
         l_aaaacti  LIKE aaa_file.aaaacti

    LET g_errno = ' '
    SELECT aaaacti INTO l_aaaacti FROM aaa_file WHERE aaa01=p_bookno
    CASE
        WHEN l_aaaacti = 'N' LET g_errno = '9028'
        WHEN STATUS=100      LET g_errno = 'anm-062' 
        OTHERWISE LET g_errno = SQLCA.sqlcode USING'-------'
        END CASE
END FUNCTION
