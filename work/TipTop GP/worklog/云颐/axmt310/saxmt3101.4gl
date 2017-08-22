# Prog. Version..: '5.30.06-13.03.12(00007)'     #
#
# Pattern name...: saxmt3101.4gl
# Descriptions...: 人工/製費估價資料維護  
# Date & Author..: 00/03/03 By Melody
 # Modify.........: 04/07/19 By Wiky Bugno.MOD-470041 修改INSERT INTO...
 # Modify.........: No.MOD-490371 04/09/23 By Kitty Controlp 未加display
# Modify.........: No.FUN-550070 05/05/26 By Will 單據編號放大
# Modify.........: No.FUN-660167 06/06/26 By wujie cl_err --> cl_err3
# Modify.........: No.FUN-680137 06/09/04 By flowld 欄位型態定義,改為LIKE
# Modify.........: No.CHI-6A0004 06/10/23 By hongmei g_azixx(本幣取位)與t_azixx(原幣取位)變數定義問題修改
# Modify.........: No.TQC-6B0117 06/11/21 By day 欄位加控管 
# Modify.........: No.FUN-710046 07/01/31 By cheunl 錯誤訊息匯整
# Modify.........: No.MOD-860041 08/06/04 By chenl  修正全局變量重復定義的錯誤。
# Modify.........: No.FUN-980010 09/08/25 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
#
 
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-AA0059 10/10/25 By chenying 料號開窗控管 
 
DATABASE ds              #No.FUN-710046
 
GLOBALS "../../config/top.global"
 
DEFINE p_row,p_col     LIKE type_file.num5          #No.FUN-680137 SMALLINT
FUNCTION saxmt3101(p_no,p_cmd,l_oqa09)
   DEFINE ls_tmp        STRING
#   DEFINE p_no	 VARCHAR(10)
   DEFINE p_no		LIKE oea_file.oea01        # No.FUN-680137 VARCHAR(16)   #No.FUN-550070
   DEFINE p_cmd		LIKE type_file.chr1  		# u:update d:display only        #No.FUN-680137 VARCHAR(1)
   DEFINE i,j,s,l_i     LIKE type_file.num5          #No.FUN-680137 SMALLINT
   DEFINE l_oqc     DYNAMIC ARRAY OF RECORD
                    oqc02		LIKE oqc_file.oqc02,
                    oqc03		LIKE oqc_file.oqc03,
                    oqc031		LIKE oqc_file.oqc031,
                    oqc04		LIKE oqc_file.oqc04,
                    oqc05		LIKE oqc_file.oqc05,
                    oqc06		LIKE oqc_file.oqc06,
                    oqc07		LIKE oqc_file.oqc07,
                    oqc08		LIKE oqc_file.oqc08,
                    oqc09		LIKE oqc_file.oqc09,
                    oqc10		LIKE oqc_file.oqc10,
                    oqc11		LIKE oqc_file.oqc11,
                    oqc12		LIKE oqc_file.oqc12,
                    oqc13		LIKE oqc_file.oqc13,
                    oqc14		LIKE oqc_file.oqc14,
                    oqc15		LIKE oqc_file.oqc15
                    END RECORD,
          l_n         LIKE type_file.num5,          #No.FUN-680137 SMALLINT
          l_oqa09     LIKE oqa_file.oqa09,
          l_oqc02_t   LIKE oqc_file.oqc02,
          l_oqc03_t   LIKE oqc_file.oqc03,
          l_oqc04_t   LIKE oqc_file.oqc04,
          l_oqc05_t   LIKE oqc_file.oqc05,
          l_oqc06_t   LIKE oqc_file.oqc06,
          l_oqc07_t   LIKE oqc_file.oqc07, 
          l_oqc08_t   LIKE oqc_file.oqc08, 
          l_oqc09_t   LIKE oqc_file.oqc09,
          l_oqc10_t   LIKE oqc_file.oqc10,
          l_ima571    LIKE ima_file.ima571,
          l_ima94     LIKE ima_file.ima94, 
          l_ecb18     LIKE ecb_file.ecb18,
          l_ecb19     LIKE ecb_file.ecb19,
          l_ecb20     LIKE ecb_file.ecb20,
          l_ecb21     LIKE ecb_file.ecb21,
         #g_azi04     LIKE azi_file.azi04,        #本幣幣別   #No.CHI-6A0004   #No.MOD-860041 mark
          l_allow_insert   LIKE type_file.num5,                #可新增否        #No.FUN-680137 SMALLINT
          l_allow_delete   LIKE type_file.num5                 #可刪除否        #No.FUN-680137 SMALLINT
 
   WHENEVER ERROR CONTINUE
   IF p_no IS NULL THEN RETURN END IF
 
   LET p_row = 2 LET p_col = 2
 
   LET ls_tmp = g_prog CLIPPED           #在OPEN WIN附窗加這三行   
   LET g_prog='axmt310_1'
   OPEN WINDOW s_t3101_w AT p_row,p_col WITH FORM "axm/42f/axmt310_1"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_locale("axmt310_1")
 
 
 #  SELECT azi04 INTO g_azi04  #本幣幣別   #No.CHI-6A0004
 #    FROM azi_file                        #No.CHI-6A0004
 #   WHERE azi01 = g_aza.aza17             #No.CHI-6A0004 
 
   DECLARE s_t3101_c CURSOR FOR
           SELECT oqc02,oqc03,oqc031,oqc04,oqc05,oqc06,oqc07,oqc08,oqc09,
                  oqc10,oqc11,oqc12,oqc13,oqc14,oqc15
             FROM oqc_file
            WHERE oqc01 = p_no 
            ORDER BY oqc02
 
   CALL l_oqc.clear()
 
   LET i = 1
   LET l_i = 0
   FOREACH s_t3101_c INTO l_oqc[i].*
      IF STATUS THEN CALL cl_err('foreach oqc',STATUS,0) EXIT FOREACH END IF 
      LET i = i + 1
      IF i > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
   END FOREACH
   CALL l_oqc.deleteElement(i)
   LET l_i = i-1
 
   IF p_cmd = 'd' THEN
      CALL cl_set_act_visible("accept,cancel", FALSE)
      DISPLAY ARRAY l_oqc TO s_oqc.*  ATTRIBUTE(COUNT=l_i)
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
      CLOSE WINDOW s_t3101_w
      LET g_prog = ls_tmp 
      RETURN
   END IF
 
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   LET i = 1
   INPUT ARRAY l_oqc WITHOUT DEFAULTS FROM s_oqc.* 
         ATTRIBUTE(COUNT=l_i,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
     BEFORE INPUT
         IF l_i != 0 THEN
            CALL fgl_set_arr_curr(i)
         END IF
 
     BEFORE ROW
        LET p_cmd = ''
        LET i=ARR_CURR()
        IF l_i >= i THEN
           LET p_cmd = 'u'
           LET l_oqc02_t=l_oqc[i].oqc02
           LET l_oqc03_t=l_oqc[i].oqc03
           LET l_oqc04_t=l_oqc[i].oqc04
           LET l_oqc05_t=l_oqc[i].oqc05
           LET l_oqc06_t=l_oqc[i].oqc06
           LET l_oqc07_t=l_oqc[i].oqc07
           LET l_oqc08_t=l_oqc[i].oqc08
           LET l_oqc09_t=l_oqc[i].oqc09
           LET l_oqc10_t=l_oqc[i].oqc10
        END IF
        CALL cl_show_fld_cont()     #FUN-550037(smin)
 
     BEFORE INSERT
        LET p_cmd = 'a'
        LET l_oqc02_t = ''
        LET l_oqc03_t = ''
        LET l_oqc04_t = ''
        LET l_oqc05_t = ''
        LET l_oqc06_t = ''
        LET l_oqc07_t = ''
        LET l_oqc08_t = ''
        LET l_oqc09_t = ''
        LET l_oqc10_t = ''
        CALL cl_show_fld_cont()     #FUN-550037(smin)
        NEXT FIELD oqc02
 
     AFTER INSERT
        LET l_i = l_i + 1
 
     BEFORE FIELD oqc02                        #default 序號
        IF cl_null(l_oqc[i].oqc02) OR l_oqc[i].oqc02 = 0 THEN
           IF i=1 THEN 
              LET l_oqc[i].oqc02 = g_oaz.oaz25
           ELSE
              LET l_oqc[i].oqc02=l_oqc[i-1].oqc02+g_oaz.oaz25
           END IF
        END IF
 
     AFTER FIELD oqc02
        IF NOT cl_null(l_oqc[i].oqc02) THEN
           IF l_oqc[i].oqc02 != l_oqc02_t OR l_oqc02_t IS NULL THEN
              FOR j = 1 TO l_oqc.getLength()
                  IF j !=i THEN
                     IF l_oqc[i].oqc02=l_oqc[j].oqc02 THEN
                        LET l_oqc[i].oqc02 = l_oqc02_t      
                        CALL cl_err('',-239,0) NEXT FIELD oqc02
                     END IF
                  END IF
              END FOR 
           END IF
        END IF
 
     BEFORE FIELD oqc03
        CALL t3101_set_entry_b(p_cmd)
 
     AFTER FIELD oqc03
        IF NOT cl_null(l_oqc[i].oqc03) THEN 
           IF l_oqc[i].oqc03[1,4] !='MISC' THEN
              SELECT ecd02 INTO l_oqc[i].oqc031 FROM ecd_file 
               WHERE ecd01=l_oqc[i].oqc03
              IF STATUS THEN
#                CALL cl_err(l_oqc[i].oqc03,'mfg4009',0)   #No.FUN-660167
                 CALL cl_err3("sel","ecd_file",l_oqc[i].oqc03,"","mfg4009","","",1)  #No.FUN-660167
                 NEXT FIELD oqc03
              END IF
           END IF
           CALL t3101_set_no_entry_b(p_cmd,l_oqc[i].oqc03)
        END IF
 
     AFTER FIELD oqc04
        IF NOT cl_null(l_oqc[i].oqc04) THEN 
#FUN-AA0059 ---------------------start----------------------------
            IF NOT s_chk_item_no(l_oqc[i].oqc04,"") THEN
               CALL cl_err('',g_errno,1)
               LET l_oqc[i].oqc04= l_oqc04_t
               NEXT FIELD oqc04
            END IF
#FUN-AA0059 ---------------------end-------------------------------
           SELECT ima571,ima94 INTO l_ima571,l_ima94 FROM ima_file
            WHERE ima01=l_oqc[i].oqc04
           IF STATUS THEN
#             CALL cl_err(l_oqc[i].oqc04,'mfg0002',0)   #No.FUN-660167
              CALL cl_err3("sel","ima_file",l_oqc[i].oqc04,"","mfg0002","","",1)  #No.FUN-660167
              NEXT FIELD oqc04
           END IF
           SELECT ecb08,ecb18,ecb19,ecb20,ecb21
             INTO l_oqc[i].oqc06,l_ecb18,l_ecb19,l_ecb20,l_ecb21
             FROM ecb_file 
            WHERE ecb01=l_ima571        
              AND ecb02=l_ima94
              AND ecb06=l_oqc[i].oqc03
           IF STATUS THEN
              LET l_ecb18=0   
              LET l_ecb19=0   
              LET l_ecb20=0   
              LET l_ecb21=0   
           END IF
 
           IF p_cmd='a' OR (l_oqc[i].oqc03!=l_oqc03_t OR
                            l_oqc[i].oqc04!=l_oqc04_t) THEN
              SELECT oqf02,oqf03 INTO l_oqc[i].oqc09,l_oqc[i].oqc10
                FROM oqf_file WHERE oqf01=l_oqc[i].oqc06
              IF STATUS THEN 
                 IF l_oqc[i].oqc09 IS NULL THEN LET l_oqc[i].oqc09=0 END IF
                 IF l_oqc[i].oqc10 IS NULL THEN LET l_oqc[i].oqc10=0 END IF
              END IF
           END IF
 
           LET l_oqc06_t=l_oqc[i].oqc06
           IF l_ecb18 IS NULL THEN LET l_ecb18=0 END IF
           IF l_ecb19 IS NULL THEN LET l_ecb19=0 END IF
           IF l_ecb20 IS NULL THEN LET l_ecb20=0 END IF
           IF l_ecb21 IS NULL THEN LET l_ecb21=0 END IF
        END IF
 
     AFTER FIELD oqc05
        IF NOT cl_null(l_oqc[i].oqc05) THEN 
           IF l_oqc[i].oqc05<=0 THEN 
              CALL cl_err(l_oqc[i].oqc05,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc05 
           END IF
           IF p_cmd='a' OR l_oqc[i].oqc05!=l_oqc05_t THEN
              LET l_oqc[i].oqc07=l_ecb18/3600+(l_oqc[i].oqc05*l_ecb19/3600)  
              LET l_oqc[i].oqc08=l_ecb20/3600+(l_oqc[i].oqc05*l_ecb21/3600)  
           END IF
           
           IF p_cmd='a' OR (l_oqc[i].oqc07!=l_oqc07_t OR
                            l_oqc[i].oqc09!=l_oqc09_t ) THEN
              #本幣金額
              LET l_oqc[i].oqc11=l_oqc[i].oqc07*l_oqc[i].oqc09
              LET l_oqc[i].oqc11 = cl_numfor(l_oqc[i].oqc11,7,g_azi04)    #No.CHI-6A0004
              #估價金額
              LET l_oqc[i].oqc13=l_oqc[i].oqc11/l_oqa09
              LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
           
           END IF
           
           IF p_cmd='a' OR (l_oqc[i].oqc08!=l_oqc08_t OR
                            l_oqc[i].oqc10!=l_oqc10_t ) THEN
              #本幣金額
              LET l_oqc[i].oqc12=l_oqc[i].oqc08*l_oqc[i].oqc10
              LET l_oqc[i].oqc12 = cl_numfor(l_oqc[i].oqc12,7,g_azi04)     #No.CHI-6A0004
              #估價金額
              LET l_oqc[i].oqc14=l_oqc[i].oqc12/l_oqa09
              LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
           
           END IF
        END IF
 
     AFTER FIELD oqc06
        IF NOT cl_null(l_oqc[i].oqc06) THEN 
           IF l_oqc[i].oqc06 != l_oqc06_t OR l_oqc06_t IS NULL THEN
              SELECT oqf02,oqf03 INTO l_oqc[i].oqc09,l_oqc[i].oqc10
                FROM oqf_file WHERE oqf01=l_oqc[i].oqc06
              IF STATUS THEN 
#                CALL cl_err(l_oqc[i].oqc06,'mfg4011',0)   #No.FUN-660167
                 CALL cl_err3("sel","oqf_file",l_oqc[i].oqc06,"","mfg4011","","",1)  #No.FUN-660167
                 NEXT FIELD oqc06
              ELSE
                 IF l_oqc[i].oqc09 IS NULL THEN LET l_oqc[i].oqc09=0 END IF
                 IF l_oqc[i].oqc10 IS NULL THEN LET l_oqc[i].oqc10=0 END IF
              END IF
          
              IF p_cmd='a' OR (l_oqc[i].oqc07!=l_oqc07_t OR
                               l_oqc[i].oqc09!=l_oqc09_t ) THEN
                 #本幣金額
                 LET l_oqc[i].oqc11=l_oqc[i].oqc07*l_oqc[i].oqc09
                 LET l_oqc[i].oqc11 = cl_numfor(l_oqc[i].oqc11,7,g_azi04)    #No.CHI-6A0004
                 #估價金額
                 LET l_oqc[i].oqc13=l_oqc[i].oqc11/l_oqa09
                 LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
          
              END IF
              IF p_cmd='a' OR (l_oqc[i].oqc08!=l_oqc08_t OR
                               l_oqc[i].oqc10!=l_oqc10_t ) THEN
                 #本幣金額
                 LET l_oqc[i].oqc12=l_oqc[i].oqc08*l_oqc[i].oqc10
                 LET l_oqc[i].oqc12 = cl_numfor(l_oqc[i].oqc12,7,g_azi04)   #No.CHI-6A0004  
                 #估價金額
                 LET l_oqc[i].oqc14=l_oqc[i].oqc12/l_oqa09
                 LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
          
              END IF 
           END IF
        END IF
 
     AFTER FIELD oqc07
        IF NOT cl_null(l_oqc[i].oqc07) THEN
           IF l_oqc[i].oqc07<=0 THEN 
              CALL cl_err(l_oqc[i].oqc07,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc07 
           END IF
           IF p_cmd='a' OR l_oqc[i].oqc07!=l_oqc07_t THEN
              #本幣金額
              LET l_oqc[i].oqc11=l_oqc[i].oqc07*l_oqc[i].oqc09
              LET l_oqc[i].oqc11 = cl_numfor(l_oqc[i].oqc11,7,g_azi04)    #No.CHI-6A0004
              #估價金額
              LET l_oqc[i].oqc13=l_oqc[i].oqc11/l_oqa09
              LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
          
           END IF
        END IF
 
     AFTER FIELD oqc08
        IF NOT cl_null(l_oqc[i].oqc08) THEN 
           IF l_oqc[i].oqc08<=0 THEN 
              CALL cl_err(l_oqc[i].oqc08,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc08 
           END IF
           IF p_cmd='a' OR l_oqc[i].oqc08!=l_oqc08_t THEN
              #本幣金額
              LET l_oqc[i].oqc12=l_oqc[i].oqc08*l_oqc[i].oqc10
              LET l_oqc[i].oqc12 = cl_numfor(l_oqc[i].oqc12,7,g_azi04)    #No.CHI-6A0004  
              #估價金額
              LET l_oqc[i].oqc14=l_oqc[i].oqc12/l_oqa09
              LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
          
           END IF 
        END IF
 
     AFTER FIELD oqc09
        IF NOT cl_null(l_oqc[i].oqc09) THEN 
           IF l_oqc[i].oqc09<=0 THEN 
              CALL cl_err(l_oqc[i].oqc09,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc09 
           END IF
           IF p_cmd='a' OR l_oqc[i].oqc09!=l_oqc09_t THEN
              #本幣金額
              LET l_oqc[i].oqc11=l_oqc[i].oqc07*l_oqc[i].oqc09
              LET l_oqc[i].oqc11 = cl_numfor(l_oqc[i].oqc11,7,g_azi04)   #No.CHI-6A0004
              #估價金額
              LET l_oqc[i].oqc13=l_oqc[i].oqc11/l_oqa09
              LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
          
           END IF
        END IF
 
     AFTER FIELD oqc10
        IF NOT cl_null(l_oqc[i].oqc10) THEN 
           IF l_oqc[i].oqc10<=0 THEN 
              CALL cl_err(l_oqc[i].oqc10,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc10 
           END IF
           IF p_cmd='a' OR l_oqc[i].oqc10!=l_oqc10_t THEN
              #本幣金額
              LET l_oqc[i].oqc12=l_oqc[i].oqc08*l_oqc[i].oqc10
              LET l_oqc[i].oqc12 = cl_numfor(l_oqc[i].oqc12,7,g_azi04)    #No.CHI-6A0004 
              #估價金額
              LET l_oqc[i].oqc14=l_oqc[i].oqc12/l_oqa09
              LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
          
           END IF 
        END IF 
 
     AFTER FIELD oqc11
        IF NOT cl_null(l_oqc[i].oqc11) THEN
           IF l_oqc[i].oqc11<=0 THEN 
              CALL cl_err(l_oqc[i].oqc11,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc11 
           END IF
           #本幣金額
           LET l_oqc[i].oqc11 = cl_numfor(l_oqc[i].oqc11,7,g_azi04)   #No.CHI-6A0004 
          
           #估價金額
           LET l_oqc[i].oqc13=l_oqc[i].oqc11/l_oqa09
           LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
        END IF
 
     AFTER FIELD oqc12
        IF NOT cl_null(l_oqc[i].oqc12) THEN  
           IF l_oqc[i].oqc12<=0 THEN 
              CALL cl_err(l_oqc[i].oqc12,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc12 
           END IF
           #本幣金額
           LET l_oqc[i].oqc12 = cl_numfor(l_oqc[i].oqc12,7,g_azi04)   #No.CHI-6A0004 
          
           #估價金額
           LET l_oqc[i].oqc14=l_oqc[i].oqc12/l_oqa09
           LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
        END IF
 
     AFTER FIELD oqc13
        IF NOT cl_null(l_oqc[i].oqc13) THEN
           IF l_oqc[i].oqc13<=0 THEN 
              CALL cl_err(l_oqc[i].oqc13,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc13 
           END IF
           LET l_oqc[i].oqc13 = cl_numfor(l_oqc[i].oqc13,7,t_azi04)
        END IF
 
     AFTER FIELD oqc14
        IF NOT cl_null(l_oqc[i].oqc14) THEN 
           IF l_oqc[i].oqc14<=0 THEN 
              CALL cl_err(l_oqc[i].oqc14,'afa-037',0) #No.TQC-6B0117
              NEXT FIELD oqc14 
           END IF
           LET l_oqc[i].oqc14 = cl_numfor(l_oqc[i].oqc14,7,t_azi04)
        END IF
 
     AFTER DELETE
        LET l_i = l_i - 1
    
     ON ACTION controlp
        CASE 
           WHEN INFIELD(oqc03)
                CALL q_ecd( FALSE, TRUE,l_oqc[i].oqc03) RETURNING l_oqc[i].oqc03
#                CALL FGL_DIALOG_SETBUFFER( l_oqc[i].oqc03 )
                 DISPLAY BY NAME l_oqc[i].oqc03        #No.MOD-490371
                NEXT FIELD oqc03
           WHEN INFIELD(oqc04)
#FUN-AA0059---------mod------------str-----------------           
#                CALL cl_init_qry_var()
#                LET g_qryparam.form ="q_ima"
#                LET g_qryparam.default1 = l_oqc[i].oqc04
#                CALL cl_create_qry() RETURNING l_oqc[i].oqc04
                 CALL q_sel_ima(FALSE, "q_ima","",l_oqc[i].oqc04,"","","","","",'' ) 
                      RETURNING  l_oqc[i].oqc04
#                CALL FGL_DIALOG_SETBUFFER( l_oqc[i].oqc04 )
                 

#FUN-AA0059---------mod------------end-----------------
                 DISPLAY BY NAME l_oqc[i].oqc04        #No.MOD-490371
                NEXT FIELD oqc04
           WHEN INFIELD(oqc06)
                CALL cl_init_qry_var()
                LET g_qryparam.form ="q_oqf"
                LET g_qryparam.default1 = l_oqc[i].oqc06
                CALL cl_create_qry() RETURNING l_oqc[i].oqc06
#                CALL FGL_DIALOG_SETBUFFER( l_oqc[i].oqc06 )
                 DISPLAY BY NAME l_oqc[i].oqc06        #No.MOD-490371
                NEXT FIELD oqc06
        END CASE
 
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
   CLOSE WINDOW s_t3101_w
   LET g_prog = ls_tmp 
   IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
 
   LET g_success ='Y' 
 
   BEGIN WORK
 
   DELETE FROM oqc_file WHERE oqc01 = p_no
   CALL s_showmsg_init()                #No.FUN-710046
   FOR i = 1 TO l_oqc.getLength()
#No.FUN-710046 ---------Begin-----------------------                                                                                
     IF g_success = "N" THEN                                                                                                        
        LET g_totsuccess = "N"                                                                                                      
        LET g_success = "Y"                                                                                                         
     END IF                                                                                                                         
#No.FUN-710046 ----------End----------------------- 
       IF cl_null(l_oqc[i].oqc02) THEN CONTINUE FOR END IF
       IF cl_null(l_oqc[i].oqc03) THEN CONTINUE FOR END IF
       INSERT INTO oqc_file(oqc01,oqc02,oqc03,oqc031,oqc04,oqc05,
                            oqc06,oqc07,oqc08,oqc09,oqc10,oqc11,
                             oqc12,oqc13,oqc14,oqc15,  #No.MOD-470041
                            oqcplant,oqclegal)   #FUN-980010 add plant & legal 
                     VALUES(p_no,l_oqc[i].oqc02,l_oqc[i].oqc03,l_oqc[i].oqc031,
                            l_oqc[i].oqc04,l_oqc[i].oqc05,l_oqc[i].oqc06,
                            l_oqc[i].oqc07,l_oqc[i].oqc08,l_oqc[i].oqc09,
                            l_oqc[i].oqc10,l_oqc[i].oqc11,l_oqc[i].oqc12,
                            l_oqc[i].oqc13,l_oqc[i].oqc14,l_oqc[i].oqc15,
                            g_plant,g_legal) 
       IF SQLCA.sqlcode THEN
#         CALL cl_err(l_oqc[i].oqc02,SQLCA.sqlcode,1)   #No.FUN-660167
#         CALL cl_err3("ins","oqc_file",p_no,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167  #No.FUN-710046
          CALL s_errmsg("oqc01",p_no,"INS oqc_file",SQLCA.sqlcode,0)    #No.FUN-710046
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
 
FUNCTION t3101_set_entry_b(p_cmd)
  DEFINE p_cmd   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
    IF INFIELD(oqc03) THEN
       CALL cl_set_comp_entry("oqc031",TRUE)
    END IF
 
END FUNCTION
 
FUNCTION t3101_set_no_entry_b(p_cmd,p_oqc03)
  DEFINE p_cmd   LIKE type_file.chr1,          #No.FUN-680137 VARCHAR(1)
         p_oqc03 LIKE oqc_file.oqc03,
         p_ac    LIKE type_file.num5          # No.FUN-680137 SMALLINT
 
    IF INFIELD(oqc03) THEN
       IF p_oqc03[1,4] !='MISC' THEN
          CALL cl_set_comp_entry("oqc031",FALSE)
       END IF 
    END IF
 
END FUNCTION
