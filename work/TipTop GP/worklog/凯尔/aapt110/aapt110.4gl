# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#
# Pattern name...: aapt110.4gl
# Descriptions...: 進貨發票請款
# Date & Author..: 92/11/26 BY Roger
# Modify.........: No.FUN-630010 06/03/09 By saki 流程訊息通知功能
# Modify.........: No.FUN-640240 06/05/16 By Echo 自動執行確認功能
 
# Modify.........: No.FUN-690028 06/09/07 By flowld 欄位型態用LIKE定義
# Modify.........: No.FUN-6A0055 06/10/26 By douzh l_time轉g_time
# Modify.........: No.FUN-880095 08/08/28 By xiaofeizhu 增加參數定義
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
 
DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE   g_msg           LIKE type_file.chr1000 #No.FUN-690028 VARCHAR(72)
DEFINE   g_argv1         LIKE type_file.chr20       # No.FUN-690028 VARCHAR(16)         #No.FUN-630010 單號
DEFINE   g_argv2         STRING           #No.FUN-630010 執行功能
DEFINE   g_argv3         STRING           #No.FUN-880095
DEFINE   g_argv4         STRING           #No.FUN-880095
MAIN
#     DEFINE  l_time LIKE type_file.chr8            #No.FUN-6A0055
 
    #FUN-640240
    IF FGL_GETENV("FGLGUI") <> "0" THEN
       OPTIONS
           INPUT NO WRAP
    END IF
    #END FUN-640240
 
   DEFER INTERRUPT
 
   LET g_argv1 = ARG_VAL(1)               #No.FUN-630010
   LET g_argv2 = ARG_VAL(2)               #No.FUN-630010
   LET g_argv3 = ARG_VAL(3)               #No.FUN-880095
   LET g_argv4 = ARG_VAL(4)               #No.FUN-880095
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("AAP")) THEN
      EXIT PROGRAM
   END IF
 
   CALL  cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0055
         RETURNING g_time    #No.FUN-6A0055
 
#  LET g_msg=ARG_VAL(1)                #No.FUN-630010
   CALL t110('11',g_argv1,g_argv2,g_argv3,g_argv4)     #No.FUN-630010  #FUN-880095 add g_argv3,g_argv4
   CALL  cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0055
         RETURNING g_time    #No.FUN-6A0055
END MAIN
 
