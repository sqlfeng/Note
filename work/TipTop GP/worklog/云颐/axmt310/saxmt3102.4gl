# Prog. Version..: '5.30.06-13.03.12(00006)'     #
#
# Pattern name...: saxmt3102.4gl
# Descriptions...: 其他資料維護  
# Date & Author..: 00/03/03 By Melody
 # Modify.........: 04/07/19 By Wiky Bugno.MOD-470041 修改INSERT INTO...
# Modify.........: No.FUN-550070 05/05/26 By Will 單據編號放大
# Modify.........: No.FUN-660167 06/06/26 By wujie cl_err --> cl_err3
# Modify.........: No.FUN-680137 06/09/04 By flowld 欄位型態定義,改為LIKE
#
# Modify.........: No.CHI-6A0004 06/10/23 By hongmei g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.TQC-6B0117 06/11/21 By day 欄位加控管 
# Modify.........: No.FUN-710046 07/01/31 By cheunl 錯誤訊息匯整
# Modify.........: No.FUN-980010 09/08/25 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
 
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
 
DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE p_row,p_col     LIKE type_file.num5          #No.FUN-680137 SMALLINT
FUNCTION saxmt3102(p_no,p_cmd)
   DEFINE ls_tmp        STRING
#   DEFINE p_no	 VARCHAR(10)
   DEFINE p_no		LIKE oea_file.oea01        # No.FUN-680137 VARCHAR(16)      #No.FUN-550070
   DEFINE p_cmd		LIKE type_file.chr1  		# u:update d:display only        #No.FUN-680137 VARCHAR(1)
   DEFINE i,j,s,l_i     LIKE type_file.num5          #No.FUN-680137 SMALLINT
   DEFINE l_oqd     DYNAMIC ARRAY OF RECORD
                    oqd02		LIKE oqd_file.oqd02,
                    oqd03		LIKE oqd_file.oqd03,
                    oqd04		LIKE oqd_file.oqd04
                    END RECORD,
          l_n         LIKE type_file.num5,          #No.FUN-680137 SMALLINT
          l_oqd02_t   LIKE oqd_file.oqd02,
#          t_azi04     LIKE azi_file.azi04,          #No.CHI-6A0004  
          l_allow_insert   LIKE type_file.num5,                #可新增否        #No.FUN-680137 SMALLINT
          l_allow_delete   LIKE type_file.num5                 #可刪除否        #No.FUN-680137 SMALLINT
 
   WHENEVER ERROR CONTINUE
   IF p_no IS NULL THEN RETURN END IF
   
   LET ls_tmp = g_prog CLIPPED           #在OPEN WIN附窗加這三行   
   LET g_prog='axmt310_2'
   LET p_row = 2 
   LET p_col = 2
   OPEN WINDOW s_t3102_w AT p_row,p_col WITH FORM "axm/42f/axmt310_2"
       ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axmt310_2")
 
       
   DECLARE s_t3102_c CURSOR FOR
      SELECT oqd02,oqd03,oqd04
        FROM oqd_file
       WHERE oqd01 = p_no 
       ORDER BY oqd02
 
   CALL l_oqd.clear()
   LET i = 1
   LET l_i = 1
   FOREACH s_t3102_c INTO l_oqd[i].*
      IF STATUS THEN CALL cl_err('foreach oqd',STATUS,0) EXIT FOREACH END IF 
      LET i = i + 1
      IF i > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
   END FOREACH
   CALL l_oqd.deleteElement(i)
   LET l_i= i-1
   IF p_cmd = 'd' THEN
      CALL cl_set_act_visible("accept,cancel", FALSE)
      DISPLAY ARRAY l_oqd TO s_oqd.* ATTRIBUTE(COUNT=l_i)
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
      CLOSE WINDOW s_t3102_w
      LET g_prog = ls_tmp 
      RETURN 
   END IF
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   LET i = 1
   INPUT ARRAY l_oqd WITHOUT DEFAULTS FROM s_oqd.* 
         ATTRIBUTE(COUNT=l_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                   APPEND ROW=l_allow_insert)
 
     BEFORE INPUT
         IF l_i != 0 THEN
            CALL fgl_set_arr_curr(i)
         END IF
 
     BEFORE ROW
        LET i=ARR_CURR()
        IF l_i >= i THEN
           LET l_oqd02_t=l_oqd[i].oqd02
        END IF
     BEFORE INSERT
        LET l_oqd02_t = ''
        NEXT FIELD oqd02
     AFTER INSERT
        LET l_i = l_i + 1
 
     BEFORE FIELD oqd02                        #default 序號
        IF l_oqd[i].oqd02 IS NULL OR l_oqd[i].oqd02 = 0 THEN
           IF i=1 THEN 
              LET l_oqd[i].oqd02 = 1
           ELSE
              LET l_oqd[i].oqd02=l_oqd[i-1].oqd02+1
           END IF
        END IF
 
     AFTER FIELD oqd02
        IF NOT cl_null(l_oqd[i].oqd02) THEN 
           IF l_oqd[i].oqd02 != l_oqd02_t OR l_oqd02_t IS NULL THEN
              FOR j=1 TO l_oqd.getLength()
                  IF j!=i THEN
                     IF l_oqd[i].oqd02=l_oqd[j].oqd02 THEN
                        LET l_oqd[i].oqd02 = l_oqd02_t      
                        CALL cl_err('',-239,0) NEXT FIELD oqd02
                     END IF
                  END IF
              END FOR 
           END IF
        END IF
 
     AFTER FIELD oqd04
        IF NOT cl_null(l_oqd[i].oqd04) THEN 
           IF l_oqd[i].oqd04<=0 THEN 
              CALL cl_err(l_oqd[i].oqd04,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqd04 
           END IF
           SELECT azi04 INTO t_azi04  #估價幣別     #No.CHI-6A0004
             FROM azi_file,oqa_file 
            WHERE oqa01 = p_no
              AND azi01 = oqa08
           LET l_oqd[i].oqd04 = cl_numfor(l_oqd[i].oqd04,9,t_azi04)    #No.CHI-6A0004 
        END IF
 
     AFTER DELETE
        LET l_i = l_i - 1
 
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
 
   CLOSE WINDOW s_t3102_w
   LET g_prog = ls_tmp 
   
   IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
 
   LET g_success ='Y' 
 
   BEGIN WORK
 
   DELETE FROM oqd_file WHERE oqd01 = p_no
   CALL s_showmsg_init()                  #No.FUN-710046
   FOR i = 1 TO l_oqd.getLength()
#No.FUN-710046 ---------Begin-----------------------                                                                                
     IF g_success = "N" THEN                                                                                                        
        LET g_totsuccess = "N"                                                                                                      
        LET g_success = "Y"                                                                                                         
     END IF                                                                                                                         
#No.FUN-710046 ----------End-----------------------
       IF cl_null(l_oqd[i].oqd02) THEN CONTINUE FOR END IF
       IF cl_null(l_oqd[i].oqd03) THEN CONTINUE FOR END IF
        INSERT INTO oqd_file(oqd01,oqd02,oqd03,oqd04,  #No.MOD-470041
                             oqdplant,oqdlegal)  #FUN-980010 add plant & legal 
                     VALUES(p_no,l_oqd[i].oqd02,l_oqd[i].oqd03,l_oqd[i].oqd04, 
                            g_plant,g_legal) 
       IF SQLCA.sqlcode THEN
#         CALL cl_err('INS-oqd',SQLCA.sqlcode,0)   #No.FUN-660167
#         CALL cl_err3("ins","oqd_file",p_no,"",SQLCA.sqlcode,"","INS-oqd",1)  #No.FUN-660167  
          CALL s_errmsg("oqd01",p_no,"INS oqd_file",SQLCA.sqlcode,1)       #No.FUN-710046
          LET g_success = 'N' EXIT FOR            #No.FUN-710046
#         LET g_success = 'N' CONTINUE FOR        #No.FUN-710046     
       END IF
    END FOR
#No.FUN-710046------------------BEGIN---------                                                                                      
     IF g_totsuccess="N" THEN                                                                                                       
        LET g_success="N"                                                                                                           
     END IF                                                     
     CALL s_showmsg()                                                                    
#No.FUN-710046-------------------END-------------
    IF g_success='Y' THEN 
       COMMIT WORK
    ELSE 
       ROLLBACK WORK
    END IF
 
END FUNCTION
