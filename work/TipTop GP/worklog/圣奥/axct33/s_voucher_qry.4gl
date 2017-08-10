# Prog. Version..: '5.30.06-13.04.25(00001)'     #
#
# Program name...: s_voucher_qry.4gl
# Descriptions...: 调用aglt110查询所选的凭证单号+账套
# Date & Author..: 2012/11/29 By wujie  FUN-CC0001
# Usage..........: s_voucher_qry(p_voucher_no)


 
DATABASE ds
 
GLOBALS "../../config/top.global"   #FUN-CC0001
DEFINE g_cmd            STRING
DEFINE g_voucher_no     LIKE apa_file.apa01
 
FUNCTION s_voucher_qry(p_voucher_no)
   DEFINE p_voucher_no	 LIKE aba_file.aba01     #凭证编号

 
   WHENEVER ERROR CALL cl_err_msg_log
   IF cl_null(p_voucher_no) THEN
      CALL cl_err('','-400',0) 
      RETURN
   END IF
   LET g_voucher_no = p_voucher_no 
   LET g_cmd = NULL 
   IF g_aza.aza63 = 'N' THEN 
   	  LET g_cmd = "aglt110 ",g_voucher_no," ",g_aza.aza81," query"
   ELSE 
      OPEN WINDOW s_voucher_qry_w AT 10,20 WITH FORM "sub/42f/s_voucher_qry"
      ATTRIBUTE(STYLE=g_win_style)
      CALL cl_ui_locale("s_voucher_qry") 
      CALL s_voucher_qry_tm()
      CLOSE WINDOW s_voucher_qry_w
   END IF  
   IF NOT cl_null(g_cmd) THEN 
      CALL cl_cmdrun_wait(g_cmd)
   END IF 
END FUNCTION

FUNCTION s_voucher_qry_tm()
DEFINE l_aaaacti       LIKE aaa_file.aaaacti
DEFINE tm                  RECORD 
                           bookno     LIKE aaa_file.aaa01
                           END RECORD 

   CLEAR FORM
   ERROR ''
   WHILE TRUE   
   DISPLAY BY NAME tm.bookno
     
   INPUT BY NAME
      tm.bookno      
      WITHOUT DEFAULTS 
 
      AFTER FIELD bookno
         IF tm.bookno IS NULL THEN
            NEXT FIELD bookno
         ELSE
            SELECT aaaacti INTO l_aaaacti FROM aaa_file
             WHERE aaa01=tm.bookno
            IF SQLCA.SQLCODE=100 THEN
               CALL cl_err3("sel","aaa_file",tm.bookno,"",100,"","",1)
               NEXT FIELD bookno
            END IF
            IF l_aaaacti='N' THEN
               CALL cl_err(tm.bookno,"9028",1)
               NEXT FIELD bookno
            END IF
         END IF
 
 
      AFTER INPUT
         IF INT_FLAG THEN
            CLOSE WINDOW s_voucher_qry_w
         END IF
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
      
      ON ACTION help          #MOD-4C0121
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
            WHEN INFIELD(bookno)
               CALL cl_init_qry_var()
               LET g_qryparam.form ="q_aaa"
               CALL cl_create_qry() RETURNING tm.bookno
               DISPLAY BY NAME tm.bookno
               NEXT FIELD bookno
         END case
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW s_voucher_qry_w
      EXIT WHILE 
   ELSE 
      LET g_cmd = "aglt110 ",g_voucher_no," ",tm.bookno," query"
   END IF
   
   EXIT WHILE
END WHILE
END FUNCTION  
