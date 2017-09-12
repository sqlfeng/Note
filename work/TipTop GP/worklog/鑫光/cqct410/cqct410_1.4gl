# Prog. Version..: '5.30.18-15.05.12(00000)'     #
#
# Pattern name...: cqct410_1.4gl
# Descriptions...: 金相組織圖片維護作業
# Date & Author..: No.0000685690_06_M025 16/05/23 By TSD.james
# Modify.........: No.0000685690_06_M049 16/12/16 By TSD.Jay 呼叫圖檔SUB傳遞參數修正
 
DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
 
DEFINE g_tc_qce01              LIKE tc_qce_file.tc_qce01,
       g_tc_qce01_t            LIKE tc_qce_file.tc_qce01,
       g_tc_qce                DYNAMIC ARRAY OF RECORD  
           tc_qce02            LIKE tc_qce_file.tc_qce02,
           tc_qce03            LIKE tc_qce_file.tc_qce03,
           tc_qce04            LIKE tc_qce_file.tc_qce04
                               END RECORD,
       g_tc_qce_t              RECORD    #程式變數(Program Variables)
           tc_qce02            LIKE tc_qce_file.tc_qce02,
           tc_qce03            LIKE tc_qce_file.tc_qce03,
           tc_qce04            LIKE tc_qce_file.tc_qce04
                               END RECORD,
       g_tc_qce05              LIKE tc_qce_file.tc_qce05,
       g_wc2,g_sql             STRING,    
       g_wc                    STRING,   
       g_rec_b                 LIKE type_file.num5,    
       l_ac                    LIKE type_file.num5,   
       g_ss                    LIKE type_file.chr1,    
       l_flag                  LIKE type_file.chr1     
DEFINE p_row,p_col             LIKE type_file.num5     
DEFINE g_forupd_sql            STRING                 
DEFINE g_before_input_done     LIKE type_file.num5   
DEFINE g_cnt                   LIKE type_file.num10  
DEFINE g_msg                   LIKE type_file.chr1000 
DEFINE g_row_count             LIKE type_file.num10  
DEFINE g_curs_index            LIKE type_file.num10 
DEFINE g_jump                  LIKE type_file.num10
DEFINE mi_no_ask               LIKE type_file.num5
DEFINE g_tc_qca                RECORD LIKE tc_qca_file.*
 
FUNCTION t410_1_main_pic(p_tc_qce01)
   DEFINE p_tc_qce01   LIKE tc_qce_file.tc_qce01

   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(S)
   #OPTIONS
   #    INPUT NO WRAP
   #DEFER INTERRUPT
 
   #IF (NOT cl_user()) THEN
   #   EXIT PROGRAM
   #END IF
   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(E)
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(S)
   #IF (NOT cl_setup("CQC")) THEN
   #   EXIT PROGRAM
   #END IF
 
   #CALL cl_used(g_prog,g_time,1) RETURNING g_time
   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(E)
   LET g_tc_qce01 = p_tc_qce01
 
   INITIALIZE g_tc_qce_t.* TO NULL
   LET p_row = 4 LET p_col = 21
 
   OPEN WINDOW t410_1_w AT p_row,p_col WITH FORM "cqc/42f/cqct410_1"
      ATTRIBUTE (STYLE = g_win_style CLIPPED) 
 
   CALL cl_ui_locale("cqct410_1")
 
   IF NOT cl_null(g_tc_qce01) THEN 
      CALL t410_1_show() 
   END IF

   #M025 161201 By TSD.Lynn mod ----(E)
   IF g_tc_qca.tc_qcaconf = 'Y' THEN
      CALL cl_set_act_visible("pic_upl,detail", FALSE)
   END IF
   #M025 161201 By TSD.Lynn mod ----(E)
  

   LOCATE g_tc_qce05 IN MEMORY 
   CALL t410_1_menu()
   FREE g_tc_qce05
 
   CLOSE WINDOW t410_1_w
   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(S)
   #CALL cl_used(g_prog,g_time,2) RETURNING g_time 
   #M025 160615 By TSD.Lynn mark function 不應有這些區段 ---(E)
 
END FUNCTION
 
FUNCTION t410_1_menu()
   WHILE TRUE
      CALL t410_1_bp("G")
      CASE g_action_choice
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL t410_1_b()
            ELSE
               LET g_action_choice = NULL
            END IF

         #上傳金相組織圖
         WHEN "pic_upl"
            IF cl_chk_act_auth() THEN
               CALL t410_1_pic_upl()
               CALL t410_1_b_fill(" 1=1")   #M025 161014 By TSD.Lynn add 
            END IF
 
         WHEN "exit"
            EXIT WHILE

         WHEN "controlg"
            CALL cl_cmdask()
   

      END CASE
   END WHILE
END FUNCTION
 
#將資料顯示在畫面上
FUNCTION t410_1_show()
    DISPLAY g_tc_qce01 TO tc_qce01
    CALL t410_1_b_fill(' 1=1')  
    CALL cl_show_fld_cont()
END FUNCTION
 
FUNCTION t410_1_b()
   DEFINE l_ac_t          LIKE type_file.num5,
          l_n             LIKE type_file.num5,  
          l_lock_sw       LIKE type_file.chr1, 
          p_cmd           LIKE type_file.chr1,
          l_allow_insert  LIKE type_file.num5,
          l_allow_delete  LIKE type_file.num5
 
   LET g_action_choice = ""
   IF s_shut(0) THEN 
      RETURN 
   END IF

   IF cl_null(g_tc_qce01) THEN 
      RETURN 
   END IF
 
   CALL cl_opmsg('b')
 
 
   LET g_forupd_sql = "SELECT tc_qce02,tc_qce03,tc_qce04 ",
                      "  FROM tc_qce_file ",
                      " WHERE tc_qce01 = ? ",
                      "   AND tc_qce02 = ? FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t410_1_bcl CURSOR FROM g_forupd_sql 
 
   LET l_ac_t = 0
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   INPUT ARRAY g_tc_qce WITHOUT DEFAULTS FROM s_tc_qce.*
      ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
 
      BEFORE INPUT
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF

      BEFORE ROW
         LET p_cmd = ''
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'  
         LET l_n  = ARR_COUNT()
 
         IF g_rec_b >= l_ac THEN
            BEGIN WORK
            LET p_cmd='u'
            LET g_tc_qce_t.* = g_tc_qce[l_ac].* 
 
            OPEN t410_1_bcl USING g_tc_qce01,g_tc_qce[l_ac].tc_qce02
            IF SQLCA.sqlcode THEN
               CALL cl_err("OPEN t410_1_bcl:", SQLCA.sqlcode, 1)
               LET l_lock_sw = 'Y'
            ELSE
               FETCH t410_1_bcl INTO g_tc_qce[l_ac].*
               IF SQLCA.sqlcode THEN
                  CALL cl_err(g_tc_qce_t.tc_qce02,SQLCA.sqlcode,1)
                  LET l_lock_sw = 'Y'
               END IF
               LET g_tc_qce_t.tc_qce02= g_tc_qce[l_ac].tc_qce02
            END IF
            CALL cl_show_fld_cont()  
         END IF
 
      BEFORE INSERT
         LET l_n = ARR_COUNT()
         LET p_cmd='a'
         LET g_tc_qce_t.* = g_tc_qce[l_ac].* 
         INITIALIZE g_tc_qce[l_ac].* TO NULL 
         LET g_tc_qce[l_ac].tc_qce04 = 'N'
         CALL cl_show_fld_cont()   
 
      AFTER INSERT
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF

         LET l_n = 0
         SELECT COUNT(*)
           INTO l_n
           FROM tc_qce_file
          WHERE tc_qce01 = g_tc_qce01
            AND tc_qce02 = g_tc_qce[l_ac].tc_qce02
         IF l_n > 0 THEN
            CALL cl_err('','-239',0)
            LET g_tc_qce[l_ac].tc_qce02 = g_tc_qce_t.tc_qce02
            NEXT FIELD tc_qce02
         END IF

         INSERT INTO tc_qce_file(tc_qce01,tc_qce02,tc_qce03,tc_qce04)
         VALUES(g_tc_qce01,g_tc_qce[l_ac].tc_qce02,g_tc_qce[l_ac].tc_qce03,g_tc_qce[l_ac].tc_qce04)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","tc_qce_file",g_tc_qce01,g_tc_qce[l_ac].tc_qce02,SQLCA.sqlcode,"","",1) 
            CANCEL INSERT
         ELSE
            MESSAGE 'INSERT O.K'
            LET g_rec_b=g_rec_b+1
            DISPLAY g_rec_b TO FORMONLY.cn2
         END IF

      BEFORE FIELD tc_qce02
         IF cl_null(g_tc_qce[l_ac].tc_qce02) OR g_tc_qce[l_ac].tc_qce02 = 0 THEN
            SELECT MAX(tc_qce02)+ 1
              INTO g_tc_qce[l_ac].tc_qce02
              FROM tc_qce_file
             WHERE tc_qce01 = g_tc_qce01
            
            IF cl_null(g_tc_qce[l_ac].tc_qce02) OR  g_tc_qce[l_ac].tc_qce02= 0 THEN
               LET g_tc_qce[l_ac].tc_qce02 = 1
            END IF
         END IF 
 
      AFTER FIELD tc_qce02            
         IF NOT cl_null(g_tc_qce[l_ac].tc_qce02) THEN
            IF p_cmd = 'a' OR (p_cmd = 'u' AND g_tc_qce[l_ac].tc_qce02 <> g_tc_qce_t.tc_qce02 )THEN
                LET l_n = 0
                SELECT COUNT(*) 
                  INTO l_n 
                  FROM tc_qce_file
                 WHERE tc_qce01 = g_tc_qce01
                   AND tc_qce02 = g_tc_qce[l_ac].tc_qce02
                IF l_n > 0 THEN
                   CALL cl_err('','-239',0)
                   LET g_tc_qce[l_ac].tc_qce02 = g_tc_qce_t.tc_qce02
                   NEXT FIELD tc_qce02
                END IF
            END IF
         END IF
 
      BEFORE DELETE                            #是否取消單身
         IF NOT cl_null(g_tc_qce_t.tc_qce02) THEN
            IF NOT cl_delete() THEN
               CANCEL DELETE
            END IF
 
            IF l_lock_sw = "Y" THEN
               CALL cl_err("", -263, 1)
               CANCEL DELETE
            END IF
 
            DELETE FROM tc_qce_file
              WHERE tc_qce01 = g_tc_qce01
                AND tc_qce02 = g_tc_qce_t.tc_qce02
            IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
               IF SQLCA.sqlcode = 0 THEN
                  LET SQLCA.sqlcode = 9051
               END IF 
               CALL cl_err3("del","tc_qce_file",g_tc_qce01,g_tc_qce_t.tc_qce03,SQLCA.sqlcode,"","",1) 
               ROLLBACK WORK
               CANCEL DELETE
            END IF
            LET g_rec_b=g_rec_b-1
            DISPLAY g_rec_b TO FORMONLY.cn2
            COMMIT WORK
         END IF
 
      ON ROW CHANGE
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             LET g_tc_qce[l_ac].* = g_tc_qce_t.*
             CLOSE t410_1_bcl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          IF l_lock_sw = 'Y' THEN
             CALL cl_err(g_tc_qce[l_ac].tc_qce03,-263,1)
             LET g_tc_qce[l_ac].* = g_tc_qce_t.*
          ELSE
             LET l_n = 0
             SELECT COUNT(*)
               INTO l_n
               FROM tc_qce_file
              WHERE tc_qce01 = g_tc_qce01
                AND tc_qce02 = g_tc_qce[l_ac].tc_qce02
             IF l_n > 0 THEN
                CALL cl_err('','-239',0)
                LET g_tc_qce[l_ac].tc_qce02 = g_tc_qce_t.tc_qce02
                NEXT FIELD tc_qce02
             END IF

             UPDATE tc_qce_file 
                SET tc_qce01 = g_tc_qce01,
                    tc_qce02 = g_tc_qce[l_ac].tc_qce02,
                    tc_qce03 = g_tc_qce[l_ac].tc_qce03,
                    tc_qce04 = g_tc_qce[l_ac].tc_qce04
              WHERE tc_qce01 = g_tc_qce01
                AND tc_qce02 = g_tc_qce_t.tc_qce02
             IF SQLCA.sqlcode OR SQLCA.SQLERRD[3] = 0 THEN
                IF SQLCA.sqlcode = 0 THEN
                   LET SQLCA.sqlcode = 9050
                END IF
                CALL cl_err3("upd","tc_qce_file",g_tc_qce01,g_tc_qce_t.tc_qce02,SQLCA.sqlcode,"","",1)
                LET g_tc_qce[l_ac].* = g_tc_qce_t.*
             ELSE
                MESSAGE 'UPDATE O.K'
                COMMIT WORK
             END IF
          END IF
 
      AFTER ROW
          LET l_ac = ARR_CURR()
          LET l_ac_t = l_ac
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             IF p_cmd = 'u' THEN
                LET g_tc_qce[l_ac].* = g_tc_qce_t.*
             END IF
             CLOSE t410_1_bcl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          CLOSE t410_1_bcl
          COMMIT WORK
 
 
      ON ACTION CONTROLO                        #沿用所有欄位
          IF INFIELD(tc_qce02) AND l_ac > 1 THEN
              LET g_tc_qce[l_ac].* = g_tc_qce[l_ac-1].*
              NEXT FIELD tc_qce02
          END IF
 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about    
         CALL cl_about() 
 
      ON ACTION help    
         CALL cl_show_help()
 
      ON ACTION controls   
         CALL cl_set_head_visible("","AUTO")  
 
   END INPUT
   CLOSE t410_1_bcl
   COMMIT WORK
END FUNCTION
 
FUNCTION t410_1_b_fill(p_wc2)
   DEFINE p_wc2           LIKE type_file.chr1000 
 
   LET g_sql = "SELECT tc_qce02,tc_qce03,tc_qce04 ",
               "  FROM tc_qce_file ",
               " WHERE tc_qce01='",g_tc_qce01,"'",
               " ORDER BY 1"
   PREPARE t410_1_pb FROM g_sql
   DECLARE t410_1_cs CURSOR FOR t410_1_pb
 
   CALL g_tc_qce.clear()
   LET g_cnt = 1
 
   FOREACH t410_1_cs INTO g_tc_qce[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN 
          CALL cl_err('foreach:',SQLCA.sqlcode,1) 
          EXIT FOREACH 
       END IF

       LET g_cnt = g_cnt + 1
       IF g_cnt > g_max_rec THEN
          CALL cl_err( '', 9035, 0 )
          EXIT FOREACH
       END IF
   END FOREACH
   CALL g_tc_qce.deleteElement(g_cnt)
   MESSAGE ""
 
   LET g_rec_b = g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0
END FUNCTION
 
 
FUNCTION t410_1_bp(p_ud)
   DEFINE p_ud   LIKE type_file.chr1   
 
   IF p_ud <> "G"  OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_qce TO s_tc_qce.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
         #M049 161216 By TSD.Jay ---(S)---
         #CALL cs_get_fld_doc('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02)
         CALL cs_get_fld_doc('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02,'')
         #M049 161216 By TSD.Jay ---(E)---

      ON ACTION detail
         LET g_action_choice="detail"
         EXIT DISPLAY

      #上傳金相組織圖
      ON ACTION pic_upl
         LET g_action_choice="pic_upl"
         EXIT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
 
      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()   
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY 
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about    
         CALL cl_about()
 
      ON ACTION cancel
         LET INT_FLAG=FALSE 	
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON ACTION controls                      
         CALL cl_set_head_visible("","AUTO")  
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

#上傳金相組織圖
FUNCTION t410_1_pic_upl()
   IF l_ac < 1 THEN
      CALL cl_err('','-400',1)
      RETURN
   END IF

   IF cl_null(g_tc_qce01) OR cl_null(g_tc_qce[l_ac].tc_qce02) THEN
      CALL cl_err('','-400',1)
      RETURN
   END IF 
   #M049 161216 By TSD.Jay ---(S)---
   #CALL cs_qc_pic('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02,'1')
   #CALL cs_get_fld_doc('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02)
   CALL cs_qc_pic('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02,'','1')
   CALL cs_get_fld_doc('3',g_tc_qce01,g_tc_qce[l_ac].tc_qce02,'')
   #M049 161216 By TSD.Jay ---(E)---
   CALL t410_1_b_fill(" 1=1") 
END FUNCTION
