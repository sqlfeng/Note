# Prog. Version..: '5.30.06-13.03.12(00001)'     #
#
# Pattern name...: axct330.4gl
# Descriptions...: 費用分攤作業
# Date & Author..: NO.FUN-C80094 12/08/28  BY xuxz

 
DATABASE ds
 
GLOBALS "../../config/top.global"
 
MAIN
  DEFINE g_argv1       LIKE cdj_file.cdj00
                 
    OPTIONS
        INPUT NO WRAP
   DEFER INTERRUPT
 
   LET g_argv1=ARG_VAL(1)     
    
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("axc")) THEN
      EXIT PROGRAM
   END IF
 
 
     CALL  cl_used(g_prog,g_time,1)       
         RETURNING g_time    
   CALL t322('2')           
     CALL  cl_used(g_prog,g_time,2)       
         RETURNING g_time    
END MAIN
#NO.FUN-C80094
