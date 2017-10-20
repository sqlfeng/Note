# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#
# Pattern name...: apmt420.4gl
# Descriptions...: 請購單單頭資料維護作業
# Date & Author..: 92/11/17 By Apple
#        Modify  : By David Wang 93/02/17
#                : For Subcontract Work Order
# Modify.........: No.FUN-4C0074 04/12/14 By pengu  匯率幣別欄位修改，與aoos010的azi17做判斷，
                                                    #如果二個幣別相同時，匯率強制為 1
# Modify.........: No.FUN-630010 06/03/08 By saki 流程訊息通知功能
# Modify.........: No.FUN-640184 06/04/19 By Echo 自動執行確認功能
# Modify.........: No.FUN-680136 06/09/07 By Jackho 欄位類型修改
# Modify.........: No.FUN-730068 07/03/30 By kim 行業別架構
# Modify.........: No.TQC-740246 07/04/30 By rainy 過單用
# Modify.........: No.FUN-810017 08/02/25 By jan 新增服飾作業
# Modify.........: No.FUN-960007 09/06/02 By chenmoyan global檔內沒有定義rowid變量
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.TQC-C60219 12/06/26 By wuxj 只過單，未修改程序
 
DATABASE ds
 
GLOBALS "../../config/top.global"
GLOBALS "../4gl/sapmt420.global"
 
MAIN
#    IF FGL_GETENV("FGLGUI") <> "0" THEN
#       OPTIONS                                #改變一些系統預設值
#           INPUT NO WRAP,
#           FIELD ORDER FORM                   #整個畫面欄位輸入會依照p_per所設定的順序(忽略4gl寫的順序)  #FUN-730068
#       DEFER INTERRUPT
#    END IF
 
    LET g_argv1 = ARG_VAL(1)           #參數-1(請購單號)
    LET g_argv2 = "0"                  #參數-2(狀況碼)(開立)
    #No.FUN-630010 --start--
#   LET g_argv3 = ARG_VAL(2)           #參數-3(性質)
    LET g_argv4 = ARG_VAL(2)
    LET g_argv3 = ARG_VAL(3)
    #No.FUN-630010 ---end---
 
 
    IF (NOT cl_user()) THEN
       EXIT PROGRAM
    END IF
   
    WHENEVER ERROR CALL cl_err_msg_log
   
    IF (NOT cl_setup("APM")) THEN
       EXIT PROGRAM
    END IF
 
    CALL cl_used(g_prog,g_time,1) RETURNING g_time 

    CALL t420(g_argv1,g_argv2,g_argv3,g_argv4)   #No.FUN-630010

    CALL cl_used(g_prog,g_time,2) RETURNING g_time 
END MAIN
 
#TQC-740246
#TQC-C60219 ---add--
