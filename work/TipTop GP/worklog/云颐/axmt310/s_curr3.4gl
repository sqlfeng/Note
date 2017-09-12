# Prog. Version..: '5.30.06-13.03.12(00000)'     #
#
# Pattern name...: s_curr3.4gl
# Descriptions...: 取得該幣別在該日期或該月份的買入或賣出匯率
# Date & Author..: 91/06/11 By LEE
# Usage..........: LET l_rate=s_curr3(p_curr,p_date,p_bs)
# Input Parameter: p_curr    幣別
#                  p_date    日期
#                  p_bs      B:銀行買入 /S:銀行賣出 /C:海關買入 /D:海關賣出
# Return code....: l_rate    匯率
# Memo...........: 若g_chr='E'則無幣別資料或無每月匯率資料或無每日匯率資料
# Modify.........: No.MOD-530630 05/04/19 By Nicola 當系統參數設定為採用月平均匯率時, 如果銷售系統參數設定的匯率不為B.銀行買入 S.銀行賣出時, 匯率就直接取B/S的匯率
# Modify.........: No.MOD-570377 05/08/04 By Dido 增加匯率選項:R-月底重評價匯率
# Modify.........: No.FUN-640012 06/04/07 By kim GP3.0 匯率參數功能改善
# Modify.........: No.FUN-680147 06/09/01 By hongmei 欄位類型轉換
# Modify.........: No.FUN-710014 07/01/11 By Carrier 錯誤訊息彙整
# Modify.........: No.TQC-7B0107 06/11/29 By claire cl_err功能改寫為 cl_getmsg 避免串EasyFlow簽核時錯誤時不顯示繼續完成
# Modify.........: No.FUN-7C0053 07/12/17 By alex 修改說明only
# Modify.........: No.FUN-840210 08/04/25 By kim 若該幣別的匯率檔取不到匯率資料，應該設定錯誤訊息
# Modify.........: No.MOD-8A0097 08/10/13 By claire 訊息於unicode環境顯示不完整
 
DATABASE ds
 
GLOBALS "../../config/top.global"  #No.FUN-710056  #FUN-7C0053
 
GLOBALS
    DEFINE g_chr   LIKE type_file.chr1                 #No.FUN-680147 VARCHAR(01)
    DEFINE g_currflag LIKE type_file.num5              #FUN-840210 WHEN TRUE  =>匯率檔取不到匯率資料 ,則匯率回傳1, 並將錯誤訊息回傳給g_errno,由呼叫的程式判斷g_errno,並決定如何處理
                                                       #           WHEN FALSE =>匯率檔取不到匯率資料 ,則匯率回傳1, 不回傳任何訊息給g_errno,依照原有程式的處理方式
END GLOBALS
 
FUNCTION s_curr3(p_curr,p_date,p_bs)
   DEFINE p_curr           LIKE aza_file.aza17,        # Prog. Version..: '5.30.06-13.03.12(04)    #幣別
          p_date           LIKE type_file.dat,         #No.FUN-680147 DATE         #日期
          p_bs             LIKE type_file.chr1,        #No.FUN-680147 VARCHAR(1)     #B:買入/S:賣出
          l_rate           LIKE azj_file.azj03,
          l_r1,l_r2        LIKE azj_file.azj03,
          l_r3,l_r4        LIKE azj_file.azj03,
          l_r5,l_r6        LIKE azj_file.azj03,
          l_r7             LIKE azj_file.azj07,        #No.MOD-570377
          l_ym             LIKE azj_file.azj02,        #No.FUN-680147 VARCHAR(6) # YYYYMM
          l_msg            LIKE type_file.chr200,      #TQC-7B0107  #MOD-8A0097 50->200
          l_buf            LIKE type_file.chr200       #No.FUN-680147 VARCHAR(20)  #MOD-8A0097 50->200
 
   WHENEVER ERROR CALL cl_err_msg_log
   IF p_date IS NULL THEN
      LET p_date = MDY(12,31,9999)
   END IF
#-----> Modify By Jones   -------92/12/02---------
# 捉出整體系統參數
   SELECT * INTO g_aza.* FROM aza_file WHERE aza01 = '0'
   IF p_curr = g_aza.aza17 THEN
      RETURN 1
   END IF
#------------------------------------------------
   CASE
      WHEN g_aza.aza19 = '1'            #取每月匯率
         LET l_ym = p_date USING 'yyyymm'
          #FUN-640012...............begin
          #SELECT azj04,azj03,azj04,azj03,azj04,azj04    #No.MOD-530630
          SELECT azj03,azj04,azj051,azj052,azj041,azj05
          #FUN-640012...............end
           INTO l_r1,l_r2,l_r3,l_r4,l_r5,l_r6
           FROM azj_file
          WHERE azj01 = p_curr AND azj02 = l_ym
         IF SQLCA.sqlcode THEN #取不到時, 取最近匯率
            #FUN-640012...............begin
            SELECT azj03,azj04,azj051,azj052,azj041,azj05
            INTO l_r1,l_r2,l_r3,l_r4,l_r5,l_r6
               FROM azj_file
            WHERE azj01 = p_curr
              AND azj02 = (SELECT MAX(azj02) FROM azj_file
                             WHERE azj01 = p_curr 
                               AND azj02 <= l_ym)
            #FUN-640012...............end
            IF SQLCA.sqlcode THEN
               LET l_buf = p_curr,'+',l_ym
               #FUN-840210.............begin
               IF g_currflag THEN
                  LET g_errno="aoo-056"
                  RETURN 1
               END IF
               #FUN-840210.............end
               #No.FUN-710014  --Begin
               IF g_bgerr THEN
                  CALL s_errmsg("azj01",p_curr,"","aoo-056",0)
               ELSE
                 #TQC-7B0107-begin-modify
                 #CALL cl_err(l_buf,'aoo-056',0)
                  CALL cl_getmsg('aoo-056',g_lang) RETURNING l_msg
                  LET l_msg=l_buf CLIPPED, " ",l_msg CLIPPED
                  CALL cl_msgany(1,1,l_msg)
              #TQC-7B0107-end-modify
               END IF
               #No.FUN-710014  --End  
               LET l_r1 = 1.0
               LET l_r2 = 1.0
               LET l_r3 = 1.0    #No.MOD-530630
               LET l_r4 = 1.0    #No.MOD-530630
               LET l_r5 = 1.0    #No.MOD-530630
               LET l_r6 = 1.0    #No.MOD-530630
            END IF
         END IF
      WHEN g_aza.aza19 = '2'            #取每日匯率
         SELECT azk03,azk04,azk051,azk052,azk041,azk05
           INTO l_r1,l_r2,l_r3,l_r4,l_r5,l_r6
           FROM azk_file
          WHERE azk01 = p_curr
            AND azk02 = p_date
         IF SQLCA.sqlcode THEN      #每日取不到時, 取最近匯率
            SELECT azk03,azk04,azk051,azk052,azk041,azk05
              INTO l_r1,l_r2,l_r3,l_r4,l_r5,l_r6
              FROM azk_file
             WHERE azk01 = p_curr
               AND azk02 = (SELECT MAX(azk02) FROM azk_file
                             WHERE azk01 = p_curr 
                               AND azk02 <= p_date)
            IF SQLCA.sqlcode THEN      #無最近匯率, 則設為一
               LET l_buf = p_curr CLIPPED,'+',p_date
               #FUN-840210.............begin
               IF g_currflag THEN
                  LET g_errno="aoo-057"
                  RETURN 1
               END IF
               #FUN-840210.............end
               #No.FUN-710014  --Begin
               IF g_bgerr THEN
                  CALL s_errmsg("azk01",p_curr,"","aoo-057",0)
               ELSE
                 #TQC-7B0107-begin-modify
                 #CALL cl_err(l_buf,'aoo-057',0)
                  CALL cl_getmsg('aoo-057',g_lang) RETURNING l_msg
                  LET l_msg=l_buf CLIPPED, " ",l_msg CLIPPED
                  CALL cl_msgany(1,1,l_msg)
                 #TQC-7B0107-end-modify
               END IF
               #No.FUN-710014  --End  
               LET l_r1 = 1.0
               LET l_r2 = 1.0
               LET l_r3 = 1.0
               LET l_r4 = 1.0
               LET l_r5 = 1.0   #No.MOD-530630
               LET l_r6 = 1.0   #No.MOD-530630
            END IF
         END IF
      OTHERWISE 
         LET l_r1 = 1
         LET l_r2 = 1
         LET l_r3 = 1
         LET l_r4 = 1
         LET l_r5 = 1   #No.MOD-530630
         LET l_r6 = 1   #No.MOD-530630
   END CASE
 
   CASE
      WHEN p_bs = 'B' LET l_rate = l_r1
      WHEN p_bs = 'S' LET l_rate = l_r2
      WHEN p_bs = 'C' LET l_rate = l_r3
      WHEN p_bs = 'D' LET l_rate = l_r4
      WHEN p_bs = 'M' LET l_rate = l_r5
      #WHEN p_bs = 'T' LET l_rate = l_r6 #FUN-640012 mark
      WHEN p_bs = 'R'                    #No.MOD-570377 Begin
         LET l_ym = p_date USING 'yyyymm'
         SELECT azj07
         INTO l_r7
         FROM azj_file
         WHERE azj01 = p_curr AND azj02 = l_ym
         IF SQLCA.sqlcode THEN
            LET l_r7 = 1.0    
         END IF
          LET l_rate = l_r7               #No.MOD-570377 End       
      OTHERWISE       LET l_rate = 1
   END CASE
 
   RETURN l_rate
 
END FUNCTION
 
#FUN-840210 #考慮到s_curr3 由許多程式呼叫共用,當有開啟flag時,才做錯誤訊息攔截動作,否則可能會造成其他程式發生問題
FUNCTION s_curr3_flagon()
   LET g_currflag=TRUE
END FUNCTION
 
#FUN-840210
FUNCTION s_curr3_flagoff()
   LET g_currflag=FALSE
END FUNCTION
