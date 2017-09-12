# Prog. Version..: '5.30.06-13.03.12(00007)'     #
#
# Program Name...: s_agl_missingno.4gl
# Descriptions...: 顯示總帳憑証缺號 并選用
# Date & Author..: 05/07/27 By Will
# Usage..........: CALL s_agl_missingno(p_plant,p_dbs,p_bookno,p_slipno,p_date,p_aac06)
# Input Parameter: p_plant  總帳營運中心編號
#                  p_dbs    總帳所在資料庫
#                  p_bookno 帳別
#                  p_slipno 單號 
#                  p_date   傳票日期
#                  p_aac06  編號方式
# Modify.........: No.FUN-570090 05/07/27 by wujie 168追單+單號碼數不同的修正
# Modify.........: No.MOD-580292 05/08/25 by wujie 去除infx下的空格
# Modify.........: No.TQC-5B0166 05/11/17 By Vivien 增加全選控件
# Modify.........: No.FUN-640004 06/04/05 By Tracy  賬別位數擴大到5碼 
# Modify.........: No.FUN-670068 06/07/24 By wujie  增加tmn06，帳套的處理
# Modify.........: No.FUN-680147 06/09/15 By czl 欄位型態定義,改為LIKE
# Modify.........: No.FUN-680029 06/09/28 By wujie 將按流水編號方式的缺號限制在2000筆內，太多的話，主機性能達不到，造成假死
# Modify.........: No.TQC-7A0051 07/10/18 By Smapmin 修改語法
# Modify.........: No.FUN-7C0053 07/12/17 By alex 修改說明only
# Modify.........: No.FUN-A50092 10/05/27 By wujie  按新的自动编码方式修改，增加法人code，acc06参数取消，改为p_cmd
#                                                   p_cmd = 0，原缺号使用方式
#                                                   p_cmd = 1，新增时自动选取第一笔缺号作为凭证号码
#                                                   增加s_get_first_missingno()配合p_cmd=1的情况使用
# Modify.........: No.FUN-A50102 10/06/24 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: NO.CHI-AC0010 10/12/16 By sabrina 調整temptable名稱，改成agl_tmp_file
 
DATABASE ds
 
GLOBALS "../../config/top.global"   #FUN-7C0053
    
    DEFINE g_allno2 	 LIKE aba_file.aba01     #No.FUN-680147 VARCHAR(16)   #滿足總帳憑証日期的所有編號   No.FUN-570090
    DEFINE g_allno3 	 LIKE aba_file.aba01     #No.FUN-680147 VARCHAR(16)  #滿足總帳憑証日期的條件   No.FUN-570090
    DEFINE g_allno4 	 LIKE aba_file.aba01     #No.FUN-680147 VARCHAR(16)   #滿足總帳憑証日期的條件,編號方式依流水號專用   No.FUN-570090
    DEFINE l_date 	 LIKE smh_file.smh01     #No.FUN-680147 VARCHAR(10)
    DEFINE g_sql 	 string  #No.FUN-580092 HCN
    DEFINE g_chr 	 LIKE type_file.chr1     #No.FUN-680147 VARCHAR(01)
#No.FUN-670068--begin
   DEFINE      g_tmp   DYNAMIC   ARRAY  OF   RECORD
               tc_tmp00   LIKE type_file.chr1,   #No.FUN-680147 VARCHAR(01)
               tc_tmp01   LIKE type_file.num5,         #No.FUN-680147 SMALLINT
               tc_tmp03   LIKE tmn_file.tmn06,   #No.FUN-680147 VARCHAR(5)       #No.FUN-670068
               tc_tmp02   LIKE tmn_file.tmn02    #No.FUN-680147 VARCHAR(20)
                       END RECORD                                                 
   DEFINE p_row,p_col     LIKE type_file.num5    #No.FUN-680147 SMALLINT
#No.FUN-670068--end
    
#No.FUN-670068--begin
#FUNCTION s_agl_missingno(g_plant,g_dbs,g_bookno,g_slipno,g_bookno1,g_slipno1,g_date,g_aac06)
FUNCTION s_agl_missingno(g_plant,g_dbs,g_bookno,g_slipno,g_bookno1,g_slipno1,g_date,g_cmd)       #No.FUN-A50092
  DEFINE       g_plant  LIKE tmn_file.tmn01,   #No.FUN-680147 VARCHAR(10) #總帳營運中心編號
               g_dbs    STRING,			        #總帳工廠 dbs name
               g_bookno LIKE aaa_file.aaa01,		#No.FUN-640004 
               g_slipno LIKE tmn_file.tmn02,   #No.FUN-680147 VARCHAR(16) #單號   No.FUN-570090
               g_bookno1 LIKE aaa_file.aaa01,		#No.FUN-640004 
               g_slipno1 LIKE tmn_file.tmn02,  #No.FUN-680147 VARCHAR(16) #單號   No.FUN-570090
               g_date   LIKE type_file.dat,          #No.FUN-680147 DATE #傳票日期
               g_aac06  LIKE aac_file.aac06    # Prog. Version..: '5.30.06-13.03.12(01) #編號方式(1.依流水 2.依年月 3.依年周 4.依年月日)       #No.FUN-570090
  DEFINE       g_cmd    LIKE type_file.chr1    #No.FUN-A50092
   
         CALL s_agl_missingno1(g_plant,g_dbs,g_bookno,g_slipno,g_date,g_cmd)                     #No.FUN-A50092 
         CALL s_agl_missingno1(g_plant,g_dbs,g_bookno1,g_slipno1,g_date,g_cmd)                   #No.FUN-A50092
         CALL s_agl_missingno_show(g_plant)
END FUNCTION 
#No.FUN-670068--end
 
#FUNCTION s_agl_missingno1(p_plant,p_dbs,p_bookno,p_slipno,p_date,p_aac06)
FUNCTION s_agl_missingno1(p_plant,p_dbs,p_bookno,p_slipno,p_date,p_cmd)           #No.FUN-A50092
  DEFINE       p_plant  LIKE tmn_file.tmn01,   #No.FUN-680147 VARCHAR(10) #總帳營運中心編號
               p_dbs    STRING,			        #總帳工廠 dbs name
#              p_bookno VARCHAR(2),			#帳別
               p_bookno LIKE aaa_file.aaa01,		#No.FUN-640004 
	       p_slipno LIKE tmn_file.tmn02,   #No.FUN-680147 VARCHAR(16) #單號   No.FUN-570090
	       p_date   LIKE type_file.dat,          #No.FUN-680147 DATE #傳票日期
	       p_aac06  LIKE aac_file.aac06,         # Prog. Version..: '5.30.06-13.03.12(01) #編號方式(1.依流水 2.依年月 3.依年周 4.依年月日)       #No.FUN-570090
	       l_aac06  LIKE aac_file.aac06,         # Prog. Version..: '5.30.06-13.03.12(01) #編號方式
	       l_cnt    LIKE type_file.num5,         #No.FUN-680147 SMALLINT
	       l_slip   LIKE oay_file.oayslip,       #No.FUN-680147 VARCHAR(5) #單別     #No.FUN-570090
	       l_no     LIKE aba_file.aba01,         #No.FUN-680147 VARCHAR(16)   #No.FUN-570090
	       l_bno    LIKE type_file.num5,         #No.FUN-680147 SMALLINT
	       l_no_8        LIKE aba_file.aba24,    #No.FUN-680147 VARCHAR(24)    #No.FUN-570090
               l_no_8_old    LIKE aba_file.aba24,    #No.FUN-680147 VARCHAR(24)   #No.FUN-570090
               l_aba01_old   LIKE aba_file.aba01
   DEFINE      i,l_j,l_k,l_ac,m    LIKE type_file.num5         #No.FUN-680147 SMALLINT 
# Prog. Version..: '5.30.06-13.03.12(01)            #No.FUN-670068           
#No.FUN-570090--begin
   DEFINE li_year  LIKE azn_file.azn02 
   DEFINE li_week  LIKE azn_file.azn05
   DEFINE li_doc_len      LIKE type_file.num5         #No.FUN-680147 SMALLINT   #單號前幾碼，不固定
   DEFINE li_i     LIKE type_file.num5         #No.FUN-680147 SMALLINT
   DEFINE li_format STRING
   DEFINE li_aza41 LIKE aza_file.aza41
   DEFINE li_aza42 LIKE aza_file.aza42
#No.FUN-570090--end    
#No.FUN-680029--begin
   DEFINE l_count  LIKE type_file.num5  
#No.FUN-680029--end
#No.FUN-A50092 --begin
   DEFINE li_aza99  LIKE aza_file.aza99
   DEFINE li_aza100 LIKE aza_file.aza100
   DEFINE li_aza102 LIKE aza_file.aza102
   DEFINE li_aza103 LIKE aza_file.aza103
   DEFINE li_aza104 LIKE aza_file.aza104
   DEFINE ls_plantcode   STRING
   DEFINE li_add_zero    LIKE type_file.num5
   DEFINE lc_legalcode   LIKE azw_file.azw02
   DEFINE p_cmd          LIKE type_file.chr1
#No.FUN-A50092 --end
 
       WHENEVER ERROR CALL cl_err_msg_log
#No.FUN-570090--begin
        LET g_plant_new = p_plant
        CALL s_getdbs()
        LET p_dbs = g_dbs_new
        LET p_dbs=p_dbs.trimRight()                                                                                                    
#No.FUN-570090--end    
#No.FUN-A50092 --begin
    IF cl_null(p_plant) THEN
       LET p_plant = g_plant
       LET p_dbs = g_dbs
    END IF
    
    LET ls_plantcode = p_plant
    SELECT azw02 INTO lc_legalcode FROM azw_file WHERE azw01 = p_plant
    IF (SQLCA.SQLCODE) THEN
       CALL cl_err_msg("", "lib-605", p_plant, 1)
    END IF

    LET ls_plantcode = lc_legalcode
    LET g_sql =  "SELECT aza99,aza100,aza102,aza103,aza104",
                 "  FROM ",cl_get_target_table(p_plant,"aza_file"),
                 " WHERE aza01 = '0'"
 	  CALL cl_replace_sqldb(g_sql) RETURNING g_sql
      CALL cl_parse_qry_sql(g_sql,p_plant) RETURNING g_sql #FUN-A50102      
    PREPARE aza_cur FROM g_sql                                                                                                  
    EXECUTE aza_cur INTO li_aza99,li_aza100,li_aza102,li_aza103,li_aza104 
    IF li_aza99 = "Y" THEN
       IF ls_plantcode.getLength() < li_aza100 THEN
          LET li_add_zero = li_aza100 - ls_plantcode.getLength()
          FOR li_i = 1 TO li_add_zero
              LET ls_plantcode = ls_plantcode,"0"
          END FOR
       ELSE
          LET ls_plantcode = ls_plantcode.subString(1,li_aza100)
       END IF
    ELSE
       LET ls_plantcode = ""
    END IF
    CASE li_aza102                                                                                                                
      WHEN '1'  LET  g_doc_len = '3'                                                                                            
      WHEN '2'  LET  g_doc_len = '4'                                                                                            
      WHEN '3'  LET  g_doc_len = '5'                                                                                            
    END CASE 
    CASE li_aza103                                                                                                                 
       WHEN "1"   LET g_no_ep = g_doc_len + 1 + 8                                                                                    
       WHEN "2"   LET g_no_ep = g_doc_len + 1 + 9                                                                                     
       WHEN "3"   LET g_no_ep = g_doc_len + 1 + 10                                                                                    
    END CASE  
   # 加入Plant Code以後的單號起訖調整
   IF li_aza99 = "Y" THEN
      LET g_no_sp = g_doc_len + 2
      LET g_sn_sp = g_doc_len + 2 + li_aza100
      LET g_no_ep = g_no_ep + li_aza100
   ELSE
      LET g_no_sp = g_doc_len + 2
      LET g_sn_sp = g_doc_len + 2
      LET li_aza100 = 0
   END IF
#No.FUN-A50092 --end
    LET l_slip=p_slipno[1,g_doc_len]             #No.FUN-570090
    IF cl_null(p_slipno[g_no_sp,g_no_ep]) THEN            
#No.FUN-A50092 --begin
#	  IF p_aac06 MATCHES "[1234]" THEN          #編號方式       No.FUN-570090
#	     LET l_aac06 = p_aac06
#	  ELSE 
#             LET g_sql = "SELECT aac06 FROM ",p_dbs CLIPPED,"aac_file",
#                         " WHERE aac01 = ? "
# 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#	     PREPARE s_agl_missingno_p1 FROM  g_sql
#	     DECLARE s_agl_missingno_c1 CURSOR  FOR   s_agl_missingno_p1 
#	        OPEN s_agl_missingno_c1  USING  l_slip
#	       FETCH s_agl_missingno_c1 INTO  l_aac06
#	     IF STATUS THEN LET l_aac06 = 1 END IF
#	  END IF
##No.FUN-570090--begin
#        LET g_sql = "SELECT aza41,aza42 FROM ",p_dbs CLIPPED,"aza_file"                                                            
# 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
#        PREPARE aza_cur FROM g_sql                                                                                                  
#        EXECUTE aza_cur INTO li_aza41,li_aza42                                                                                                
#        CASE li_aza41                                                                                                                
#          WHEN '1'  LET  g_doc_len = '3'                                                                                            
#          WHEN '2'  LET  g_doc_len = '4'                                                                                            
#          WHEN '3'  LET  g_doc_len = '5'                                                                                            
#        END CASE 
#        CASE li_aza42                                                                                                                 
#           WHEN "1"   LET g_no_ep = g_doc_len + 1 + 8                                                                                    
#           WHEN "2"   LET g_no_ep = g_doc_len + 1 + 9                                                                                    
#           WHEN "3"   LET g_no_ep = g_doc_len + 1 + 10                                                                                   
#        END CASE  
#          LET g_allno3=''
#          LET g_allno4=''
#	  IF l_aac06 = "1" THEN   #-->依流水號
#             LET g_allno4=p_slipno[1,g_doc_len],'-','%' 
#          END IF
#	  IF l_aac06 = "2" THEN   #-->依年月
#	     LET l_date=p_date USING "YYMMDD"
#	     LET g_allno3=p_slipno[1,g_doc_len],'-',l_date[1,4],'%'
#             LET li_doc_len = g_doc_len +5       #原先168上只要固定前八碼，現在66上需要動態抓碼數
#          END IF
#	  IF l_aac06 = "3" THEN   #-->依年周
#             SELECT azn02,azn05 INTO li_year,li_week                                                                           
#               FROM azn_file WHERE azn01 = p_date  
#             LET l_date =li_year USING '&&&&',li_week USING'&&'    
# #No.MOD-580292--begin
##            LET l_date = l_date[3,6]      
#             LET g_allno3 = p_slipno[1,g_doc_len],'-',l_date[3,6],'%'
# #No.MOD-580292--end   
#             LET li_doc_len = g_doc_len +5
#          END IF
#	  IF l_aac06 = "4" THEN       #-->依年月日
#	     LET l_date=p_date USING "YYYYMMDD"
# #No.MOD-580292--begin
##	     LET l_date=l_date[3,8]
#	     LET g_allno3=p_slipno[1,g_doc_len],'-',l_date[3,8],'%'
# #No.MOD-580292--end  
#             LET li_doc_len = g_doc_len +7
#	  END IF  
#No.FUN-570090--end  
	  IF li_aza104 = "1" THEN   #-->依流水號
             LET g_allno4=p_slipno[1,g_doc_len],'-',ls_plantcode,'%' 
          END IF
	  IF li_aza104 = "2" THEN   #-->依年月
	     LET l_date=p_date USING "YYMMDD"
	     LET g_allno3=p_slipno[1,g_doc_len],'-',ls_plantcode,l_date[1,4],'%'
       LET li_doc_len = g_doc_len +5 + li_aza100     
          END IF
	  IF li_aza104 = "3" THEN   #-->依年周
             SELECT azn02,azn05 INTO li_year,li_week                                                                           
               FROM azn_file WHERE azn01 = p_date  
             LET l_date =li_year USING '&&&&',li_week USING'&&'        
             LET g_allno3 = p_slipno[1,g_doc_len],'-',ls_plantcode,l_date[3,6],'%'  
             LET li_doc_len = g_doc_len +5 + li_aza100 
          END IF
	  IF li_aza104 = "4" THEN       #-->依年月日
	     LET l_date=p_date USING "YYYYMMDD"
	     LET g_allno3=p_slipno[1,g_doc_len],'-',ls_plantcode,l_date[3,8],'%'
       LET li_doc_len = g_doc_len +7 + li_aza100 
	  END IF  
#No.FUN-A50092 --end
	  
	  #LET g_sql = "SELECT aba01 FROM ",p_dbs CLIPPED,"aba_file",
      LET g_sql = "SELECT aba01 FROM ",cl_get_target_table(p_plant,'aba_file'), #FUN-A50102
                  " WHERE aba00=? AND aba01 LIKE  '",g_allno3 CLIPPED,"'"," ORDER BY aba01"
 	  CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
      CALL cl_parse_qry_sql(g_sql,p_plant) RETURNING g_sql #FUN-A50102
	  PREPARE s_agl_missingno_p5 FROM g_sql
	  DECLARE  s_agl_missingno_c5  CURSOR FOR   s_agl_missingno_p5 
	  #OPEN  s_agl_missingno_c5  USING p_bookno   #TQC-7A0051
	 
	  LET l_cnt    = 0 
          LET l_no_8_old = ' '
          LET g_allno2 = ' '
          
          #FOREACH s_agl_missingno_c5  INTO  g_allno2      # LOCK單據性質   #TQC-7A0051
          FOREACH s_agl_missingno_c5 USING p_bookno INTO  g_allno2      # LOCK單據性質   #TQC-7A0051
              IF SQLCA.sqlcode != 0 THEN 
                 CALL cl_err('foreach:',SQLCA.sqlcode,1)
                 EXIT FOREACH 
              END IF
 
          
               LET l_no_8 = g_allno2[1,li_doc_len]     #前8碼相同, 為一個GROUP 66上不是固定的前碼 No.FUN-570090
 
       #---->CHECK 前八碼若不同--------------------------------------# 
             IF l_no_8 != l_no_8_old THEN
#No.FUN-570090--begin
                LET l_no_8_old = g_allno2[1,li_doc_len]
                LET l_no = g_allno2[1,li_doc_len]
                FOR li_i = li_doc_len+1 TO g_no_ep
                    LET l_no[li_i,li_i] = '0'
                END FOR
#                LET l_no[9,12]=0000
#No.FUN-570090--end   
             END IF
       #--------------判斷缺號并插入表中------------------------------#
             IF l_no_8 = l_no_8_old THEN  
#No.FUN-570090--begin
                LET li_format = ''
                FOR li_i = li_doc_len+1 TO g_no_ep
                    LET li_format = li_format,"&"
                END FOR   
                LET l_bno = l_no[li_doc_len+1,g_no_ep] + 1 USING li_format
                LET l_no = l_no[1,li_doc_len],l_bno USING li_format
                IF g_allno2 != l_no THEN
                   LET l_j = 0 
                   LET l_aba01_old = g_allno2
                   WHILE TRUE
                        LET l_j = l_j + 1
                        IF l_j > 1 THEN  
                           LET l_bno = l_no[li_doc_len+1,g_no_ep] + 1 USING li_format
                           LET l_no = l_no[1,li_doc_len],l_bno USING li_format
#No.FUN-570090--end   
                            IF l_no = l_aba01_old THEN
                               EXIT WHILE
                            END IF
                        END IF
               
                        INITIALIZE g_allno2 TO NULL
                        LET g_allno2 = l_no  
                        LET l_k = 0
                        SELECT COUNT(*) INTO l_k FROM tmn_file
                         WHERE tmn01 = p_plant AND tmn02 = g_allno2 
                           AND tmn06 = p_bookno             #No.FUN-670068
                        IF l_k = 0 THEN 
                           LET l_cnt = l_cnt + 1                
                           INSERT INTO agl_tmp_file VALUES('N',l_cnt,g_allno2,p_bookno) #將缺號放到agl_tmp_file表里                 #No.FUN-670068 
                        END IF
                   END WHILE
                END IF
            END IF                       
          END FOREACH      
 
#No.FUN-570090--begin 編號方式依流水號時查找缺號與其它不同，故單獨FOREACH
          LET l_count =0
	  #LET g_sql = "SELECT aba01 FROM ",p_dbs CLIPPED,"aba_file",
      LET g_sql = "SELECT aba01 FROM ",cl_get_target_table(p_plant,'aba_file'), #FUN-A50102
              " WHERE aba00=? AND aba01 LIKE  '",g_allno4 CLIPPED,"'"," ORDER BY aba01"
 	 CALL cl_replace_sqldb(g_sql) RETURNING g_sql        #FUN-920032
     CALL cl_parse_qry_sql(g_sql,p_plant) RETURNING g_sql #FUN-A50102
	  PREPARE s_agl_missingno_p6 FROM g_sql
	  DECLARE  s_agl_missingno_c6  CURSOR FOR   s_agl_missingno_p6 
	  #OPEN  s_agl_missingno_c6  USING p_bookno   #TQC-7A0051
	 
	  LET l_cnt    = 0 
          LET l_no_8_old = ' '
          LET g_allno2 = ' '
          
          #FOREACH s_agl_missingno_c6  INTO  g_allno2      # LOCK單據性質   #TQC-7A0051
          FOREACH s_agl_missingno_c6 USING p_bookno INTO  g_allno2      # LOCK單據性質   #TQC-7A0051
              IF SQLCA.sqlcode != 0 THEN 
                 CALL cl_err('foreach:',SQLCA.sqlcode,1)
                 EXIT FOREACH 
              END IF
 
          
               LET l_no_8 = g_allno2[1,g_sn_sp-1]     #與其它編號方式不同,單別相同的為一個GROUP  #No.FUN-A50092 g_doc_len -->g_sn_sp
 
       #----選號從0000000開始--------------------------------# 
             IF l_no_8 != l_no_8_old THEN
                LET l_no_8_old = g_allno2[1,g_sn_sp-1]           #No.FUN-A50092 g_doc_len -->g_sn_sp
#                LET l_no = g_allno2[1,g_doc_len],'-'
                LET l_no = g_allno2[1,g_sn_sp-1]                 #No.FUN-A50092
#                FOR li_i = g_doc_len+2 TO g_no_ep
                FOR li_i = g_sn_sp TO g_no_ep                    #No.FUN-A50092
                    LET l_no[li_i,li_i] = '0'
                END FOR
             END IF
       #--------------判斷缺號并插入表中------------------------------#
             IF l_no_8 = l_no_8_old THEN  
                LET li_format = ''
                FOR li_i =g_sn_sp TO g_no_ep                     #No.FUN-A50092
                    LET li_format = li_format,"&"
                END FOR   
                LET l_bno = l_no[g_sn_sp,g_no_ep] + 1 USING li_format     #No.FUN-A50092
                LET l_no = l_no[1,g_sn_sp-1],l_bno USING li_format        #No.FUN-A50092
                IF g_allno2 != l_no THEN
                   LET l_j = 0 
                   LET l_aba01_old = g_allno2
                   FOR l_j = 1 TO 1000
                        IF l_j > 1 THEN  
                           LET l_bno = l_no[g_sn_sp,g_no_ep] + 1 USING li_format  #No.FUN-A50092
                           LET l_no = l_no[1,g_sn_sp-1],l_bno USING li_format     #No.FUN-A50092
                            IF l_no = l_aba01_old THEN
                               EXIT FOR  
                            END IF
                        END IF
               
                        INITIALIZE g_allno2 TO NULL
                        LET g_allno2 = l_no  
                        LET l_k = 0
                        SELECT COUNT(*) INTO l_k FROM tmn_file
                         WHERE tmn01 = p_plant AND tmn02 = g_allno2 
                           AND tmn06 = p_bookno             #No.FUN-670068
                        IF l_k = 0 THEN 
                           LET l_cnt = l_cnt + 1                
                           INSERT INTO agl_tmp_file VALUES('N',l_cnt,g_allno2,p_bookno) #將缺號放到agl_tmp_file表里            #No.RUN-670068      
#No.FUN-A50092 --begin
                           IF p_cmd = '1'  THEN
                              RETURN  
                           END IF 
#No.FUN-A50092 --end
                        END IF
#No.FUN-680029--begin
                        LET l_count = l_count +1
                        IF l_count >2000 THEN
                           CALL cl_err('','9035',1)
                           RETURN
                        END IF
#No.FUN-680029--end
                   END FOR   
                END IF
            END IF                       
          END FOREACH      
       END IF      #No.FUN-670068
#No.FUN-570090--end   
END FUNCTION      #No.FUN-670068
 
#No.FUN-670068--begin
FUNCTION s_agl_missingno_show(p_plant)           
DEFINE      p_plant             LIKE tmn_file.tmn01         #No.FUN-680147 VARCHAR(10) #總帳營運中心編號
DEFINE      l_cnt               LIKE type_file.num5         #No.FUN-680147 SMALLINT
DEFINE      i,l_j,l_k,l_ac,m    LIKE type_file.num5         #No.FUN-680147 SMALLINT
DEFINE      l_flag              LIKE type_file.chr1         #No.FUN-680147 VARCHAR(01)  
#No.FUN-670068--end
          #----------------------將缺號show到畫面上-------------------------#
          
          OPEN WINDOW s_agl_missingno_w AT 11,27  WITH FORM "sub/42f/s_agl_missingno"
               ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
          CALL cl_ui_locale("s_agl_missingno")
 
          CALL cl_load_act_sys(NULL)   #No.FUN-670068
          
          LET g_sql = "SELECT tc_tmp00,tc_tmp01,tc_tmp03,tc_tmp02  FROM agl_tmp_file ORDER BY tc_tmp02,tc_tmp03"  #No.FUN-670068
          PREPARE s_missingno_p   FROM  g_sql
          DECLARE s_missingno_cs  CURSOR     FOR   s_missingno_p      
              
          LET l_cnt = 1     
          CALL g_tmp.clear()         
          FOREACH  s_missingno_cs  INTO g_tmp[l_cnt].*
              IF SQLCA.sqlcode != 0 THEN 
                 CALL cl_err('foreach:',SQLCA.sqlcode,1)
                 EXIT FOREACH 
              END IF                           
              LET l_cnt = l_cnt + 1
              IF l_cnt > g_max_rec THEN
                 CALL cl_err( '', 9035, 0 )
                 EXIT FOREACH
              END IF
          END FOREACH
          
          CALL g_tmp.deleteElement(l_cnt)
          LET l_cnt = l_cnt - 1  
          
          DISPLAY l_cnt TO FORMONLY.cn
          
          DISPLAY ARRAY g_tmp TO s_tmp.*  ATTRIBUTE(COUNT=l_cnt,UNBUFFERED)
          
             BEFORE ROW
               EXIT DISPLAY
 
          END DISPLAY      
                      
          #----------------選用缺號------------------------------------------#
          WHILE TRUE     
          LET l_flag = 'Y'
          LET  m=0
                 
           INPUT ARRAY g_tmp WITHOUT DEFAULTS FROM s_tmp.*
            ATTRIBUTE(COUNT=l_cnt,MAXCOUNT=g_max_rec,UNBUFFERED,
                      INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=TRUE)                                       
              
              BEFORE INPUT
                 IF l_cnt != 0 THEN
                    CALL fgl_set_arr_curr(l_ac)
                 END IF                            
                            
              BEFORE ROW
                 LET l_ac = ARR_CURR()
 
              ON CHANGE tc_tmp00
                 IF g_tmp[l_ac].tc_tmp00='Y' THEN                                                                                 
                    SELECT COUNT(*) INTO l_j FROM tmn_file                                                                     
                     WHERE tmn01 = p_plant AND tmn02 = g_tmp[l_ac].tc_tmp02                                                                           
                       AND tmn06 = g_tmp[l_ac].tc_tmp03    #No.FUN-670068
                    IF l_j = 1 THEN                                                                                            
                       CALL cl_err(g_tmp[l_ac].tc_tmp02,'aap-503',0)                                                              
                       LET g_tmp[l_ac].tc_tmp00 = 'N'
                    END IF  
                 END IF
 
              AFTER INPUT 
                  FOR i =1 TO l_cnt
                      IF g_tmp[i].tc_tmp00='Y' THEN
                         SELECT COUNT(*) INTO l_j FROM tmn_file 
                          WHERE tmn01 = p_plant AND tmn02 = g_tmp[i].tc_tmp02
                            AND tmn06 = g_tmp[i].tc_tmp03    #No.FUN-670068
                         IF l_j = 1 THEN
                            CALL cl_err(g_tmp[i].tc_tmp02,'aap-503',0)
                            LET l_flag = 'N'
                            EXIT INPUT
                         END IF
                      END IF
                  END FOR
                  FOR i =1 TO l_cnt
                      IF g_tmp[i].tc_tmp00='N' THEN
                         DELETE FROM  agl_tmp_file
                          WHERE tc_tmp02=g_tmp[i].tc_tmp02
                            AND tc_tmp03=g_tmp[i].tc_tmp03 #No.FUN-670068
                      ELSE
                         LET m = m+1
                         UPDATE agl_tmp_file
                            SET tc_tmp00='Y', tc_tmp01=m                                   
                          WHERE tc_tmp02=g_tmp[i].tc_tmp02
                            AND tc_tmp03=g_tmp[i].tc_tmp03 #No.FUN-670068
                         INSERT INTO tmn_file (tmn01,tmn02,tmn06) VALUES (p_plant,g_tmp[i].tc_tmp02,g_tmp[i].tc_tmp03)   #No.FUN-670068
                      END IF                  
                  END FOR                  
          
             ON ACTION cancel #MOD-4B0193
               LET INT_FLAG = 1
               EXIT INPUT
 
#No.TQC-5B0166 --begin                                                                                                              
             ON ACTION select_all                                                                                                   
                 FOR i =1 TO l_cnt                                                                                                  
                     LET g_tmp[i].tc_tmp00='Y'                                                                                      
                 END FOR                                                                                                            
#No.TQC-5B0166 --end
          
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
             CLOSE WINDOW s_agl_missingno_w
             RETURN
          END IF
          
         IF l_flag = 'Y' THEN EXIT WHILE END IF
         END WHILE
 
         CLOSE WINDOW s_agl_missingno_w
         RETURN
                                  
#      END IF      #No.FUN-670068
                                       
END FUNCTION        
#No.FUN-A50092 --begin
FUNCTION s_get_first_missingno(g_plant,g_dbs,g_bookno,g_slipno,g_date,g_cmd)      
  DEFINE       g_plant  LIKE tmn_file.tmn01,   #No.FUN-680147 VARCHAR(10) #總帳營運中心編號
               g_dbs    STRING,			           #總帳工廠 dbs name
               g_bookno LIKE aaa_file.aaa01,	 #No.FUN-640004 
               g_slipno LIKE tmn_file.tmn02,   #No.FUN-680147 VARCHAR(16) #單號   
               g_date   LIKE type_file.dat     #No.FUN-680147 DATE #傳票日期
  DEFINE       g_cmd    LIKE type_file.chr1    #No.FUN-A50092
  DEFINE       l_aba01  LIKE aba_file.aba01

         IF g_cmd <> '1' THEN RETURN g_slipno  END IF  
         IF g_aaz.aaz115 <> 'Y' THEN RETURN g_slipno  END IF  
         DELETE FROM agl_tmp_file
         CALL s_agl_missingno1(g_plant,g_dbs,g_bookno,g_slipno,g_date,g_cmd)        
         SELECT tc_tmp02 INTO l_aba01 FROM agl_tmp_file ORDER BY tc_tmp02
         RETURN l_aba01
END FUNCTION 
#No.FUN-A50092 --end
#CHI-AC0010
