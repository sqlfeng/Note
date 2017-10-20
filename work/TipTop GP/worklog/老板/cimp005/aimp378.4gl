# Prog. Version..: '5.20.02-10.08.05(00010)'     #
#
# Pattern name...: aimp378.4gl
# Descriptions...: 庫存調撥異動過帳還原(for aimt324)
# Date & Author..: 95/05/20 By Roger
# Modify.........: No:9377 04/07/08 By Mandy 作完aimt325及aimt326撥出及撥入確認後,還可使用aimp378!,p_ze增加'aim-209'
# Modify.........: NO.MOD-490217 04/09/10 by yiting 料號欄位放大
# Modify.........: NO.FUN-4A0042 04/10/11 by Carol 異動單號開窗查詢
# Modify.........: No.MOD-530179 05/03/22 By Mandy 將DEFINE 用DEC(),DECIMAL()方式的改成用LIKE方式
# Modify.........: No.FUN-540025 05/04/22 By Carrier  #雙單位修改
# Modify.........: No.FUN-550011 05/05/24 By kim GP2.0功能 庫存單據不同期要check庫存是否為負
# Modify.........: No.FUN-550029 05/05/30 By vivien 單據編號格式放大
# Modify.........: No.MOD-570028 05/07/12 By pengu 進行過帳時，考慮單位換算率
# Modify.........: No.FUN-570122 06/02/16 By yiting 批次背景執行
# Modify.........: NO.TQC-620156 06/03/10 By kim GP3.0過帳錯誤統整顯示功能新增
# Modify.........: NO.FUN-640266 06/04/26 BY yiting 更改cl_err
# Modify.........: NO.FUN-660029 06/06/13 BY kim 新增immconf欄位
# Modify.........: No.FUN-660078 06/06/14 By rainy aim系統中，用char定義的變數，改為用LIKE
# Modify.........: No.MOD-650117 06/06/20 By Pengu 修改(p4)長度定義為 varchar2(24)
# Modify.........: NO.FUN-660156 06/06/22 By Tracy cl_err -> cl_err3 
# Modify.........: No.TQC-690001 06/09/03 By pengu CALL s_stkminus CHECK負庫存時,應帶入撥入的料倉儲批,而非撥出的料倉儲批.
# Modify.........: No.FUN-690026 06/09/15 By Carrier 欄位型態用LIKE定義
# Modify.........: No.FUN-690115 06/10/13 By dxfwo cl_used位置調整及EXIT PROGRAM后加cl_used
# Modify.........: No.FUN-6A0074 06/10/26 By johnray l_time轉g_time
# Modify.........: No.TQC-6B0057 06/11/14 By Ray 修正語言別切換無效
# Modify.........: No.FUN-6C0083 07/01/08 By Nicola 錯誤訊息彙整
# Modify.........: No.MOD-710059 07/03/06 By pengu p378_u_img之lock img_fail此錯誤訊息加強
# Modify.........: No.FUN-860045 08/06/12 By Nicola 批/序號傳入值修改及開窗詢問使用者是否回寫單身數量
# Modify.........: No.FUN-8C0084 08/12/22 By jan s_upimg相關改以 料倉儲批為參數傳入 ,不使用 ROWID
# Modify.........: No.FUN-930038 09/03/06 By kim 借貨單的刻號/BIN資料過帳時要拋轉至調撥單，調撥單刪除時要拋轉回借貨單
# Modify.........: No.TQC-930155 09/03/26 By Sunyanchun Lock img_file,imgg_file時，若報錯，不要rollback ，要放g_success ='N'
 
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-A20044 10/03/23 By vealxu ima26x 調整
# Modify.........: No:FUN-8C0131 10/04/07 by dxfwo  過帳還原時的呆滯日期異動
# Modify.........: No:MOD-A70117 10/07/15 By Sarah 多單位執行aimt324過帳還原,img10計算有誤
# Modify.........: No:MOD-A70150 10/07/21 By Smapmin 延續MOD-A70117的修改
 
DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"
 
DEFINE g_imm            RECORD LIKE imm_file.*
DEFINE b_imn            RECORD LIKE imn_file.*
DEFINE g_wc,g_wc2,g_sql string                 #No.FUN-580092 HCN
DEFINE u_flag           LIKE type_file.num5    #No.FUN-690026 SMALLINT
DEFINE g_argv1          LIKE imm_file.imm01    #No.FUN-550029 #No.FUN-690026 VARCHAR(16)
DEFINE g_cnt            LIKE type_file.num10   #No.FUN-690026 INTEGER
DEFINE g_change_lang    LIKE type_file.chr1    #是否有做語言切換 No.FUN-570122  #No.FUN-690026 VARCHAR(1)
DEFINE g_msg            LIKE type_file.chr1000 #No.FUN-690026 VARCHAR(72)
DEFINE g_forupd_sql     STRING                 #SELECT ... FOR UPDATE SQL
 
MAIN
   DEFINE l_flag        LIKE type_file.chr1    #No.FUN-570122  #No.FUN-690026 VARCHAR(1)
 
   OPTIONS                                #改變一些系統預設值
      INPUT NO WRAP
   DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   #No.FUN-570122 ----start----
   INITIALIZE g_bgjob_msgfile TO NULL
   LET g_argv1=ARG_VAL(1)
   LET g_bgjob = ARG_VAL(2)
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   LET g_imm.imm01=g_argv1
 
#  SELECT * INTO g_sma.* FROM sma_file WHERE sma00='0'
   #No.FUN-570122 ----end----
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("CIM")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-690115 BY dxfwo 
 
  #No.FUN-570122 ----start----
  #LET g_argv1=ARG_VAL(1)
  #LET g_imm.imm01=g_argv1
  #SELECT * INTO g_sma.* FROM sma_file WHERE sma00='0'
 
  # OPEN WINDOW p378_w AT p_row,p_col
  #      WITH FORM "aim/42f/aimp378"
  #      ATTRIBUTE (STYLE = g_win_style)
 
  # CALL cl_ui_init()
  #No.FUN-570122 ----end----
 
  #No.FUN-570122 ----start----
   WHILE TRUE
      LET g_success = 'Y'
      IF g_bgjob = 'N' THEN
         CALL p378_p1()
         IF cl_sure(0,0) THEN
            BEGIN WORK
            CALL p378_p2()
            CALL cl_end(0,0)
            IF g_success='Y' THEN
               COMMIT WORK
               CALL s_barcode_move(g_imm.imm01,'u') #过账还原 条码资料更新2015-09-09 10:56:49 shenran
               CALL cl_end2(1) RETURNING l_flag        #批次作業正確結束
            ELSE
               ROLLBACK WORK
               CALL cl_end2(2) RETURNING l_flag        #批次作業失敗
            END IF
            IF l_flag THEN
               CONTINUE WHILE
            ELSE
               CLOSE WINDOW p378_w
               EXIT WHILE
            END IF
         ELSE
            CONTINUE WHILE
         END IF
      ELSE
         BEGIN WORK
         CALL p378_p2()
         IF g_success = "Y" THEN
            COMMIT WORK
            CALL s_barcode_move(g_imm.imm01,'u') #过账还原 条码资料更新2015-09-09 10:56:49 shenran
         ELSE
            ROLLBACK WORK
         END IF
         CALL cl_batch_bg_javamail(g_success)
         EXIT WHILE
      END IF
 
 END WHILE
#    CLOSE WINDOW p378_w
 #No.FUN-570122 ----end----
 CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690115 BY dxfwo 
END MAIN
 
FUNCTION p378_p1()
#DEFINE l_flag       LIKE type_file.chr1    #No.FUN-570122  #No.FUN-690026 VARCHAR(1)
DEFINE lc_cmd        LIKE type_file.chr1000 #No.FUN-570122  #No.FUN-690026 VARCHAR(500)
DEFINE p_row,p_col   LIKE type_file.num5    #No.FUN-570122  #No.FUN-690026 SMALLINT
 
 #No.FUN-570122 ----Start----
 OPEN WINDOW p378_w AT p_row,p_col
      WITH FORM "aim/42f/aimp378"
      ATTRIBUTE (STYLE = g_win_style)
 
 CALL cl_ui_init()
 
 LET g_bgjob = 'N'
 #No.FUN-570122 ----End----
 
 WHILE TRUE
   CALL cl_opmsg('z')
 
#   INPUT BY NAME g_imm.imm01 WITHOUT DEFAULTS 
   INPUT BY NAME g_imm.imm01,g_bgjob WITHOUT DEFAULTS  #NO.FUN-570122
 
   AFTER FIELD imm01
        SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
        IF STATUS THEN 
#        CALL cl_err('sel imm:',STATUS,0) NEXT FIELD imm01 END IF
            CALL cl_err3("sel","imm_file",g_imm.imm01,"",STATUS,"","sel imm:",0)   #NO.FUN-640266
            NEXT FIELD imm01 
        END IF
        #IF g_imm.imm03='X' THEN #01/08/24 mandy #FUN-660029
        IF g_imm.immconf='X' THEN #FUN-660029
           CALL cl_err('imm03=X:','9024',0) NEXT FIELD imm01
        END IF
        IF g_imm.imm03='N' THEN
           CALL cl_err('imm03=N:','aim-206',0) NEXT FIELD imm01
        END IF
        IF g_imm.imm10='3' THEN
           CALL cl_err('imm10=3:','aim-208',0) NEXT FIELD imm01
        END IF
        #No:9377
        #該單據為二階段倉庫調撥,不可在此作業過帳還原!
        IF g_imm.imm10='2' THEN
           CALL cl_err('imm10=2:','aim-209',0) NEXT FIELD imm01
        END IF
        #No:9377(end)
	IF g_sma.sma53 IS NOT NULL AND g_imm.imm02 <= g_sma.sma53 THEN
	   CALL cl_err('','mfg9999',0) NEXT FIELD imm01
	END IF
   
#FUN-4A0042
   #No.FUN-570122 ----Start----
   AFTER FIELD g_bgjob
        IF g_bgjob NOT MATCHES "[YN]"  OR cl_null(g_bgjob) THEN
           NEXT FIELD g_bgjob
        END IF
   #No.FUN-570122 ----End----
 
      ON ACTION CONTROLP
         CALL cl_init_qry_var()
         LET g_qryparam.form ="q_imm"
         CALL cl_create_qry() RETURNING g_imm.imm01
         DISPLAY BY NAME g_imm.imm01
         NEXT FIELD imm01
##
 
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
   
      ON ACTION locale
         #->No.FUN-570122--end---
        #  LET g_action_choice='locale'
        #  CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
           LET g_change_lang = TRUE
           #->No.FUN-570122--end---
         EXIT INPUT
      
         #No.FUN-580031 --start--
         BEFORE INPUT
             CALL cl_qbe_init()
         #No.FUN-580031 ---end---
 
         #No.FUN-580031 --start--
         ON ACTION qbe_select
            CALL cl_qbe_select()
         #No.FUN-580031 ---end---
 
         #No.FUN-580031 --start--
         ON ACTION qbe_save
            CALL cl_qbe_save()
         #No.FUN-580031 ---end---
 
   END INPUT
      
   #No.TQC-6B0057 --begin
#  IF g_action_choice = "locale" THEN
#     LET g_action_choice = ""
#     CALL cl_dynamic_locale()
#     CONTINUE WHILE
#  END IF
   IF g_change_lang THEN
      LET g_change_lang = FALSE
      CALL cl_dynamic_locale()
      CALL cl_show_fld_cont()
      CONTINUE WHILE
   END IF
   #No.TQC-6B0057 --end
  #No.FUN-570122 ----Start----
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      CLOSE WINDOW p378_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690115 BY dxfwo 
      EXIT PROGRAM
   END IF
  #No.FUN-570122 ----End----
  #IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
 
  #No.FUN-570122 ----mark----
#   IF cl_sure(0,0) THEN 
#      CALL p378_p2() 
# Prog. Version..: '5.20.02-10.08.05(0,0)    #010409 by plum
#      IF g_success='Y' THEN
#         COMMIT WORK
#         CALL cl_end2(1) RETURNING l_flag        #批次作業正確結束
#      ELSE
#         ROLLBACK WORK
#         CALL cl_end2(2) RETURNING l_flag        #批次作業失敗
#      END IF
#      
#      IF l_flag THEN
#         CONTINUE WHILE
#      ELSE
#         EXIT WHILE
#      END IF
#   END IF
#
#   IF NOT cl_null(g_argv1) THEN RETURN END IF
  #No.FUN-570122 ----Start----
     IF g_bgjob = "Y" THEN
        SELECT zz08 INTO lc_cmd FROM zz_file
         WHERE zz01 = "aimp378"
        IF SQLCA.sqlcode OR lc_cmd IS NULL THEN
           CALL cl_err('aimp378','9031',1)
        ELSE
           LET lc_cmd = lc_cmd CLIPPED,
                        " '",g_imm.imm01 CLIPPED,"'",
                        " '",g_bgjob CLIPPED,"'"
           CALL cl_cmdat('aimp378',g_time,lc_cmd CLIPPED)
        END IF
        CLOSE WINDOW p378_w
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690115 BY dxfwo 
        EXIT PROGRAM
     END IF
     EXIT WHILE
  #No.FUN-570122 ----End----
 
 END WHILE
 
END FUNCTION
 
FUNCTION p378_p2()
   BEGIN WORK
   LET g_success='Y'
   CALL p378_s1()
#  IF g_success = 'Y'
#     THEN CALL cl_cmmsg(1) COMMIT WORK
#     ELSE CALL cl_rbmsg(1) ROLLBACK WORK
#  END IF
END FUNCTION
 
FUNCTION p378_s1()
 #---No.MOD-570028 add
  DEFINE l_img09      LIKE img_file.img09,
         l_factor     LIKE ima_file.ima31_fac  #No.FUN-690026 DECIMAL(16,8)
  DEFINE l_imn22      LIKE imn_file.imn22
  DEFINE l_cnt        LIKE type_file.num10     #No.FUN-690026 INTEGER
#--end
  DEFINE l_flag       LIKE type_file.num5      #FUN-930038
  DEFINE l_imn10      LIKE imn_file.imn10      #MOD-A70117 add
  DEFINE l_tlf13      LIKE tlf_file.tlf13      #add by zhangbo120906
  DEFINE l_tc_rec     RECORD LIKE tc_rec_file.* #add by zhangbo120906
  DEFINE l_n          LIKE type_file.num5       #add by zhangbo120906
  DEFINE l_sql        STRING                    #add by zhangbo120906 

  CALL p378_u_imm()
 
  CALL s_showmsg_init()   #No.FUN-6C0083 
 
  DECLARE p378_s1_c CURSOR FOR SELECT * FROM imn_file WHERE imn01=g_imm.imm01
  FOREACH p378_s1_c INTO b_imn.*
      IF STATUS THEN LET g_success='N' RETURN END IF
     #No.FUN-570122 ----Start----
      IF g_bgjob = 'N' THEN
         MESSAGE '_s1() read imn:',b_imn.imn02
      END IF
     #MESSAGE '_s1() read imn:',b_imn.imn02
     #No.FUN-570122 ----End----
      MESSAGE '_s1() read imn:',b_imn.imn02 
      CALL ui.Interface.refresh()
      IF cl_null(b_imn.imn03) THEN CONTINUE FOREACH END IF
 
 #--No.MOD-570028 add
      SELECT img09 INTO l_img09 FROM img_file
         WHERE img01=b_imn.imn03 AND img02=b_imn.imn15
           AND img03=b_imn.imn16 AND img04=b_imn.imn17
      CALL s_umfchk(b_imn.imn03,b_imn.imn20,l_img09) RETURNING l_cnt,l_factor
      IF l_cnt = 1 THEN
         CALL cl_err('','mfg3075',1)
         LET g_success = 'N'
         RETURN 1
      END IF
      LET l_imn22 = b_imn.imn22 * l_factor
#--end
     #str MOD-A70117 add
      SELECT img09 INTO l_img09 FROM img_file   #MOD-A70150
         WHERE img01=b_imn.imn03 AND img02=b_imn.imn04   #MOD-A70150
           AND img03=b_imn.imn05 AND img04=b_imn.imn06   #MOD-A70150
      LET l_cnt = 0   LET l_factor = 0
      CALL s_umfchk(b_imn.imn03,b_imn.imn09,l_img09) RETURNING l_cnt,l_factor
      IF l_cnt = 1 THEN
         CALL cl_err('','mfg3075',1)
         LET g_success = 'N'
         RETURN 1
      END IF
      LET l_imn10 = b_imn.imn10 * l_factor
     #end MOD-A70117 add
 
    #No.+046 010409 by plum modi
     
    # CALL p378_u_img(b_imn.imn10,b_imn.imn03,b_imn.imn04,
    #                             b_imn.imn05,b_imn.imn06)
    # IF g_success='N' THEN RETURN END IF
    # CALL p378_u_img(b_imn.imn22*-1,b_imn.imn03,b_imn.imn15,
    #                                b_imn.imn16,b_imn.imn17)
    # IF g_success='N' THEN RETURN END IF
 
      #FUN-930038...................begin
      IF s_industry('icd') THEN
         #入庫
         CALL s_icdpost(1,b_imn.imn03,b_imn.imn15,b_imn.imn16,
                        b_imn.imn17,b_imn.imn20,b_imn.imn22,
                        b_imn.imn01,b_imn.imn02,g_imm.imm02,'N',
                        '','')
              RETURNING l_flag
         IF l_flag = 0 THEN
            LET g_success = 'N'
            RETURN
         END IF
         #出庫
         CALL s_icdpost(-1,b_imn.imn03,b_imn.imn04,b_imn.imn05,
                        b_imn.imn06,b_imn.imn09,b_imn.imn10, 
                        b_imn.imn01,b_imn.imn02,g_imm.imm02,'N',
                        '','')
              RETURNING l_flag
         IF l_flag = 0 THEN
            LET g_success = 'N'
            RETURN
         END IF
      END IF
      #FUN-930038...................end
 
      #FUN-540025  --begin
      CALL p378_u_imgg()      
      #FUN-540025  --end
      #TQC-620156...............begin
      IF g_success='N' THEN   #No.FUN-6C0083
         LET g_totsuccess="N"
         LET g_success="Y"
         CONTINUE FOREACH
      END IF
      #TQC-620156...............end
     #CALL p378_u_img(b_imn.imn10,+1,b_imn.imn03,b_imn.imn04,  #MOD-A70117 mark
      CALL p378_u_img(l_imn10,+1,b_imn.imn03,b_imn.imn04,      #MOD-A70117
                                # b_imn.imn05,b_imn.imn06,b_imn.imn02)   #No.MOD-710059 modify
                                  b_imn.imn05,b_imn.imn06,b_imn.imn02,1)   #mod by xumin 101129
      IF g_success='N' THEN    #No.FUN-6C0083
         #TQC-620156...............begin
         LET g_totsuccess="N"
         LET g_success="Y"
         CONTINUE FOREACH
         #RETURN
         #TQC-620156...............end
      END IF
       CALL p378_u_img(l_imn22,-1,b_imn.imn03,b_imn.imn15,     #MOD-570028 modify
                   #  b_imn.imn16,b_imn.imn17,b_imn.imn02) #No.MOD-710059 modify
                      b_imn.imn16,b_imn.imn17,b_imn.imn02,2) #mod by xumin 101129
 
      IF g_success='N' THEN    #No.FUN-6C0083
         #TQC-620156...............begin
         LET g_totsuccess="N"
         LET g_success="Y"
         CONTINUE FOREACH
         #RETURN
         #TQC-620156...............end
      END IF 
    #NO.+046..end

#add by zhangbo120906---------------------begin-------------------------
#取消过账删除核销档并且更新tlf931
      SELECT tlf13 INTO l_tlf13 FROM tlf_file WHERE tlf905=b_imn.imn01 AND tlf906=b_imn.imn02
      IF l_tlf13 !='axmt650' THEN
         LET l_n=0
         SELECT COUNT(*) INTO l_n FROM tc_rec_file WHERE tc_rec01=b_imn.imn01 AND tc_rec02=b_imn.imn02
         IF l_n>0 THEN
            LET l_sql="SELECT * FROM tc_rec_file WHERE tc_rec01='",b_imn.imn01,"' AND tc_rec02='",b_imn.imn02,"'"
            PREPARE rec_pb1 FROM l_sql
            DECLARE rec_cs1 CURSOR FOR rec_pb1
            FOREACH rec_cs1 INTO l_tc_rec.*

              UPDATE tlf_file  SET tlf931 = nvl(tlf931,0) - l_tc_rec.tc_rec05
               WHERE tlf905 = l_tc_rec.tc_rec03
                 AND tlf906 = l_tc_rec.tc_rec04
               IF SQLCA.sqlcode THEN
                  CALL cl_err3("upd","tlf_file",l_tc_rec.tc_rec04,"",SQLCA.sqlcode,"","",1)
                  LET g_success = 'N'
                  EXIT FOREACH
               END IF

      
             END FOREACH

             DELETE FROM tc_rec_file WHERE tc_rec01=b_imn.imn01 AND tc_rec02=b_imn.imn02
         END IF
      END IF
           
#add by zhangbo120906-----------------------end-------------------------
#     CALL p378_u_ima()                   #No.FUN-A20044
#     IF g_success='N' THEN RETURN END IF #No.FUN-A20044
      CALL p378_u_tlf()
      IF g_success='N' THEN    #No.FUN-6C0083
         #TQC-620156...............begin
         LET g_totsuccess="N"
         LET g_success="Y"
         CONTINUE FOREACH
         #RETURN
         #TQC-620156...............end
      END IF
 
     #-----No.FUN-860045-----
     CALL p378_u_tlfs()
     IF g_success='N' THEN
        LET g_totsuccess="N"
        LET g_success="Y"
        CONTINUE FOREACH
     END IF
     #-----No.FUN-860045 END-----
 
     #xf add 120326  --begin
     #DELETE FROM tc_rec_file WHERE tc_rec01=b_imn.imn01 AND tc_rec02=b_imn.imn02
     #IF STATUS THEN
     #   CALL cl_err('删除核销档错误','!',1)
     #   LET g_success='N'
     #END IF
     #xf add 120326  --end

  END FOREACH
 
  #TQC-620156...............begin
  IF g_totsuccess="N" THEN
     LET g_success="N"
  END IF
  CALL s_showmsg()   #No.FUN-6C0083
  #TQC-620156...............end
  
END FUNCTION
 
#No.FUN-540025  --begin
FUNCTION p378_u_imgg()
  DEFINE l_ima906     LIKE ima_file.ima906
  DEFINE l_ima25      LIKE ima_file.ima25
  
    IF g_sma.sma115 = 'N' THEN RETURN END IF
    SELECT ima906 INTO l_ima906 FROM ima_file WHERE ima01=b_imn.imn03
    IF l_ima906 = '1' THEN RETURN END IF
    IF cl_null(l_ima906) THEN LET g_success = 'N' RETURN END IF
    SELECT ima25 INTO l_ima25 FROM ima_file
     WHERE ima01=b_imn.imn03
    IF SQLCA.sqlcode THEN
       LET g_success='N' RETURN
    END IF
    IF l_ima906 = '2' THEN  #子母單位
       #source
       IF NOT cl_null(b_imn.imn33) THEN
          CALL p378_upd_imgg('1',b_imn.imn03,b_imn.imn04,b_imn.imn05,
                             b_imn.imn06,b_imn.imn33,b_imn.imn35,
                             b_imn.imn34,+1,'2')
          IF g_success='N' THEN RETURN END IF
       END IF
       IF NOT cl_null(b_imn.imn30) THEN
          CALL p378_upd_imgg('1',b_imn.imn03,b_imn.imn04,b_imn.imn05,
                             b_imn.imn06,b_imn.imn30,b_imn.imn32,
                             b_imn.imn31,+1,'1')
          IF g_success='N' THEN RETURN END IF
       END IF
       #destination
       IF NOT cl_null(b_imn.imn43) THEN
          CALL p378_upd_imgg('1',b_imn.imn03,b_imn.imn15,b_imn.imn16,
                             b_imn.imn17,b_imn.imn43,b_imn.imn45,
                             b_imn.imn44,-1,'2')
          IF g_success='N' THEN RETURN END IF
       END IF
       IF NOT cl_null(b_imn.imn40) THEN
          CALL p378_upd_imgg('1',b_imn.imn03,b_imn.imn15,b_imn.imn16,
                             b_imn.imn17,b_imn.imn40,b_imn.imn42,
                             b_imn.imn41,-1,'1')
          IF g_success='N' THEN RETURN END IF
       END IF
       CALL p378_tlff()
       IF g_success='N' THEN RETURN END IF
    END IF
    IF l_ima906 = '3' THEN  #參考單位
       #source
       IF NOT cl_null(b_imn.imn33) THEN
          CALL p378_upd_imgg('2',b_imn.imn03,b_imn.imn04,b_imn.imn05,
                             b_imn.imn06,b_imn.imn33,b_imn.imn35,
                             b_imn.imn34,+1,'2')
          IF g_success = 'N' THEN RETURN END IF
       END IF
       #destination
       IF NOT cl_null(b_imn.imn43) THEN
          CALL p378_upd_imgg('2',b_imn.imn03,b_imn.imn15,b_imn.imn16,
                             b_imn.imn17,b_imn.imn43,b_imn.imn45,
                             b_imn.imn44,-1,'2')
          IF g_success = 'N' THEN RETURN END IF
       END IF
       CALL p378_tlff()
       IF g_success='N' THEN RETURN END IF
    END IF
 
END FUNCTION
 
FUNCTION p378_upd_imgg(p_imgg00,p_imgg01,p_imgg02,p_imgg03,p_imgg04,
                       p_imgg09,p_imgg10,p_imgg211,p_flag,p_no)
 DEFINE p_imgg00   LIKE imgg_file.imgg00,
        p_imgg01   LIKE imgg_file.imgg01,
        p_imgg02   LIKE imgg_file.imgg02,
        p_imgg03   LIKE imgg_file.imgg03,
        p_imgg04   LIKE imgg_file.imgg04,
        p_imgg09   LIKE imgg_file.imgg09,
        p_imgg10   LIKE imgg_file.imgg10,
        p_imgg211  LIKE imgg_file.imgg211,
        l_ima25    LIKE ima_file.ima25,
        l_ima906   LIKE ima_file.ima906,
        l_imgg21   LIKE imgg_file.imgg21,
        p_flag     LIKE type_file.num5,    #No.FUN-690026 SMALLINT
        p_no       LIKE type_file.chr1    #No.FUN-690026 VARCHAR(1)
 
  #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "update imgg_file ..."
   END IF
   #MESSAGE "update imgg_file ..."
   #No.FUN-570122 ----End----
 
   CALL ui.Interface.refresh()
 
   LET g_forupd_sql =
       "SELECT imgg01,imgg02,imgg03,imgg04,imgg09 FROM imgg_file ",
       "   WHERE imgg01= ? AND imgg02= ? AND imgg03= ? AND imgg04= ? ",
       "   AND imgg09= ? FOR UPDATE "
 
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE imgg_lock CURSOR FROM g_forupd_sql
 
   OPEN imgg_lock USING p_imgg01,p_imgg02,p_imgg03,p_imgg04,p_imgg09
   IF STATUS THEN
      CALL cl_err("OPEN imgg_lock:", STATUS, 1)
      LET g_success='N'
      CLOSE imgg_lock
      #ROLLBACK WORK        #NO.TQC-930155---mark----
      RETURN
   END IF
   FETCH imgg_lock INTO p_imgg01,p_imgg02,p_imgg03,p_imgg04,p_imgg09
   IF STATUS THEN
      CALL cl_err('lock imgg fail',STATUS,1)
      LET g_success='N'
      CLOSE imgg_lock
      #ROLLBACK WORK        #NO.TQC-930155---mark----
      RETURN
   END IF
 
    SELECT ima25,ima906 INTO l_ima25,l_ima906
      FROM ima_file WHERE ima01=p_imgg01
    IF SQLCA.sqlcode OR l_ima25 IS NULL THEN
#      CALL cl_err('ima25 null',SQLCA.sqlcode,0)   #No.FUN-660156 MARK
       CALL cl_err3("sel","ima_file",p_imgg01,"",SQLCA.sqlcode,"","ima25 null",0)  #No.FUN-660156
       LET g_success = 'N' RETURN 
    END IF
    
    CALL s_umfchk(p_imgg01,p_imgg09,l_ima25)
          RETURNING g_cnt,l_imgg21
    IF g_cnt = 1 AND NOT (l_ima906='3' AND p_no = '2') THEN 
       CALL cl_err('','mfg3075',0)
       LET g_success = 'N' RETURN 
    END IF
 
  #CALL s_upimgg(' ',p_flag,p_imgg10,g_imm.imm02, #FUN-8C0083
   CALL s_upimgg(p_imgg01,p_imgg02,p_imgg03,p_imgg04,p_imgg09,p_flag,p_imgg10,g_imm.imm02,#FUN-8C0083
          p_imgg01,p_imgg02,p_imgg03,p_imgg04,'','','','',p_imgg09,'',l_imgg21,'','','','','','','',p_imgg211)
   IF g_success = 'N' THEN
      CALL cl_err('u_upimgg(-1)','9050',0) RETURN
   END IF
 
END FUNCTION
 
FUNCTION p378_tlff()
 
   #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "d_tlff!"
   END IF
   #MESSAGE "d_tlff!"
   #No.FUN-570122 ----End----
    CALL ui.Interface.refresh()
 
    DELETE FROM tlff_file
     WHERE tlff01 =b_imn.imn03
       AND ((tlff026=g_imm.imm01 AND tlff027=b_imn.imn02) OR
            (tlff036=g_imm.imm01 AND tlff037=b_imn.imn02)) #異動單號/項次 
       AND tlff06 =g_imm.imm02 #異動日期
          
    IF STATUS THEN
#       CALL cl_err('del tlff:',STATUS,1) LET g_success='N' RETURN
       CALL cl_err3("del","tlff_file",g_imm.imm02,"",STATUS,"","del tlff:",1)   #NO.FUN-640266
       LET g_success='N' RETURN
    END IF
END FUNCTION
#FUN-540025  --end   
 
FUNCTION p378_u_imm()
   #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "u_imm!"
   END IF
   #MESSAGE "u_imm!"
   #No.FUN-570122 ----End----
    CALL ui.Interface.refresh()
    UPDATE imm_file SET imm03='N' WHERE imm01=g_imm.imm01
    IF STATUS THEN
#       CALL cl_err('upd imm03:',STATUS,1) LET g_success='N' RETURN
       CALL cl_err3("upd","imm_file",g_imm.imm01,"",SQLCA.sqlcode,"","upd imm03",1)   #NO.FUN-640266 #No.FUN-660156
       LET g_success='N' RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
#       CALL cl_err('upd imm03:','mfg0177',1) LET g_success='N' RETURN
        CALL cl_err3("upd","imm_file",g_imm.imm01,"","mfg0177","","upd imm03",1)  #NO.FUN-640266  #No.FUN-660156
        LET g_success = 'N'
        RETURN
    END IF
END FUNCTION
 
#FUNCTION p378_u_img(qty,p_type,p1,p2,p3,p4,p5) # Update img_file  #No.MOD-710059 modify
FUNCTION p378_u_img(qty,p_type,p1,p2,p3,p4,p5,p6) # Update img_file  #No.MOD-710059 modify
    DEFINE qty		LIKE img_file.img10  #MOD-530179
    DEFINE p1           LIKE img_file.img01, #NO.MOD-490217
         #----------------No.MOD-650117 modify
          #p2,p3,p4 VARCHAR(20),
           p2           LIKE img_file.img02,
           p3           LIKE img_file.img03,
           p4           LIKE img_file.img04,
           p5           LIKE imn_file.imn02,    #No.MOD-710059 add
           p6           SMALLINT,  #add by xumin 101129
         #----------------No.MOD-650117 end
           l_str        STRING,                 #No.MOD-710059 add
           p_type       LIKE type_file.num5    #No.FUN-690026 SMALLINT
    DEFINE l_rowid      VARCHAR(18)  #add by xumin 101129
 
   #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "u_img!"
   END IF
   #MESSAGE "u_img!"
   #No.FUN-570122 ----End----
    CALL ui.Interface.refresh()
    IF p2 IS NULL THEN LET p2=' ' END IF
    IF p3 IS NULL THEN LET p3=' ' END IF
    IF p4 IS NULL THEN LET p4=' ' END IF
 
  #No.3443 01/09/04 By Carol add lock img_file .......................
{
    SELECT img01,img02,img03,img04 INTO p1,p2,p3,p4 FROM img_file
     WHERE img01=p1 AND img02=p2 AND img03=p3 AND img04=p4
    IF STATUS THEN
       CALL cl_err('sel img:',STATUS,1) LET g_success='N' RETURN
    END IF
}
   #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "update img_file ..."
   END IF
   #MESSAGE "update img_file ..."
   #No.FUN-570122 ----End----
    CALL ui.Interface.refresh()
    LET g_forupd_sql =
    # " SELECT img01,img02,img03,img04 FROM img_file ",
      " SELECT rowid,img01,img02,img03,img04 FROM img_file ", #mod by xumin 101129
      "    WHERE img01= ? ", 
      "    AND img02= ? ",
      "    AND img03= ? ",
      "    AND img04= ? ",
      " FOR UPDATE "
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE img_lock CURSOR FROM g_forupd_sql 
    OPEN img_lock USING p1,p2,p3,p4
    #NO.TQC-930155------begin-----          
    IF STATUS THEN                           
       CALL cl_err("Open img_lock",STATUS,1)  
       CLOSE img_lock            
       LET g_success = 'N'        
       RETURN                      
    END IF                          
    #NO.TQC-930155------end-------------- 
    FETCH img_lock INTO l_rowid,p1,p2,p3,p4 #add l_rowid by xumin 101129
   #-------------------No.MOD-710059 modify
   #IF STATUS THEN
   #   CALL cl_err('lock img fail',STATUS,1) LET g_success='N' RETURN
   #END IF
    IF STATUS THEN
       LET l_str = "lock img fail, Line No:",p5 CLIPPED
       CALL cl_err(l_str,STATUS,1) LET g_success='N' RETURN
    END IF
   #-------------------No.MOD-710059 end
  #No.3443 end .......................................................
 
   #No.+046 010409 by plum mark 改統一由s_upimg去判斷庫存不足(sma894)來控管
   {
    IF qty < 0 AND l_img10 + qty < 0    ## 庫存為負時
       THEN
       LET g_sql=p1 clipped,'/',p2 clipped,'/',p3 clipped,'/',p4 clipped
       CALL cl_err(g_sql,'asf-375',1)
       LET g_success = 'N'
       RETURN
    END IF
 
    UPDATE img_file SET img10=img10+qty
           WHERE img01=p1 AND img02=p2 AND img03=p3 AND img04=p4
    IF STATUS THEN
#       CALL cl_err('upd img10:',STATUS,1) LET g_success='N' RETURN
       CALL cl_err3("upd","img_file",p1,p2,STATUS,"","upd img10",1)      #NO.FUN-640266  #No.FUN-660156
       LET g_success='N' RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
        CALL cl_err3("upd","img_file",p1,p2,"mfg0177","","upd img10",1)      #NO.FUN-640266
        LET g_success='N' RETURN
#       CALL cl_err('upd img10:','mfg0177',1) LET g_success='N' RETURN
    END IF
   #No.+046..end}
  
 
   #FUN-550011................begin
   IF p_type='-1' THEN
     #------------No.TQC-690001 modify
     #IF NOT s_stkminus(b_imn.imn03,b_imn.imn04,b_imn.imn05,b_imn.imn06,
     #                  b_imn.imn10,1,g_imm.imm02,g_sma.sma894[4,4]) THEN
      IF NOT s_stkminus(b_imn.imn03,b_imn.imn15,b_imn.imn16,b_imn.imn17,
                        b_imn.imn22,1,g_imm.imm02,g_sma.sma894[4,4]) THEN
     #------------No.TQC-690001 end
         LET g_success='N'
         RETURN
      END IF
   END IF
   #FUN-550011................end
 
  #No.+046 010409 by plum add 改統一由s_upimg去判斷庫存不足(sma894)來控管
  #CALL s_upimg(' ',p_type,qty,g_today,'','','','',       #FUN-8C0084
   IF p6 = 2 THEN
   
     #xf mod 120428  --begin
     
     #不允许负库存
     
     #CALL cs_upimg2(l_rowid,p_type,qty,g_today, #xf mark 120428
     #           '','','','','','','','','','','','','','',0,0,'','') #add by xumin 101129  #xf mark 120428
     
     CALL s_upimg(p1,p2,p3,p4,p_type,qty,g_today,'','','','',   #FUN-8C0084
                b_imn.imn01,b_imn.imn02,'','','','','','','','',0,0,'','')   #No.FUN-860045
     #xf mod 120428  --end
   ELSE
     CALL s_upimg(p1,p2,p3,p4,p_type,qty,g_today,'','','','',   #FUN-8C0084
                b_imn.imn01,b_imn.imn02,'','','','','','','','',0,0,'','')   #No.FUN-860045
   END IF
   IF g_success = 'N' THEN
      LET g_msg='parts: ',p1 CLIPPED,' ',p2 CLIPPED,' ',p3 CLIPPED,
                ' ',p4 CLIPPED
      CALL cl_err(g_msg,'9050',1) RETURN
   END IF
  #No.+046..end
END FUNCTION
 
#No.FUN-A20044 ---mark----start
#FUNCTION p378_u_ima() #------------------------------------ Update ima_file
#    DEFINE l_ima26,l_ima261,l_ima262	LIKE ima_file.ima26  
# 
#   #No.FUN-570122 ----Start----
#   IF g_bgjob = 'N' THEN
#      MESSAGE "u_ima!"
#   END IF
#   #MESSAGE "u_ima!"
#   #No.FUN-570122 ----End----
#    CALL ui.Interface.refresh()
#    LET l_ima26=0 LET l_ima261=0 LET l_ima262=0
#    SELECT SUM(img10*img21) INTO l_ima26  FROM img_file
#           WHERE img01=b_imn.imn03 AND img23='Y' AND img24='Y'
#    IF STATUS THEN #CALL cl_err('sel sum1:',STATUS,1) LET g_success='N' END IF
#       CALL cl_err3("sel","img_file",b_imn.imn03,"",SQLCA.sqlcode,"","sel sum1",1)   #NO.FUN-640266 #No.FUN-660156
#       LET g_success='N' 
#    END IF
#    IF l_ima26 IS NULL THEN LET l_ima26=0 END IF
#    SELECT SUM(img10*img21) INTO l_ima261 FROM img_file
#           WHERE img01=b_imn.imn03 AND img23='N'
#    IF STATUS THEN #CALL cl_err('sel sum2:',STATUS,1) LET g_success='N' END IF
#       CALL cl_err3("sel","img_file",b_imn.imn03,"",SQLCA.sqlcode,"","sel sum2",1)   #No.FUN-660156
#    LET g_success='N' END IF
#    IF l_ima261 IS NULL THEN LET l_ima261=0 END IF
#    SELECT SUM(img10*img21) INTO l_ima262 FROM img_file
#           WHERE img01=b_imn.imn03 AND img23='Y'
#    IF STATUS THEN #CALL cl_err('sel sum3:',STATUS,1) LET g_success='N' END IF
#       CALL cl_err3("sel","img_file",b_imn.imn03,"",SQLCA.sqlcode,"","sel sum3",1)   #No.FUN-660156
#    LET g_success='N' END IF
#    IF l_ima262 IS NULL THEN LET l_ima262=0 END IF
#    UPDATE ima_file SET 
#                    ima26=l_ima26,ima261=l_ima261,ima262=l_ima262
#               WHERE ima01= b_imn.imn03
#    IF STATUS THEN
##       CALL cl_err('upd ima26*:',STATUS,1) LET g_success='N' RETURN
#       CALL cl_err3("upd","ima_file",b_imn.imn03,"",SQLCA.sqlcode,"","upd ima26*",1)   #NO.FUN-640266 #No.FUN-660156
#       LET g_success='N' RETURN
#    END IF
#    IF SQLCA.SQLERRD[3]=0 THEN
##       CALL cl_err('upd ima26*:','mfg0177',1) 
#        CALL cl_err3("upd","ima_file",b_imn.imn03,"","mfg0177","","upd ima26*",1)      #NO.FUN-640266 #No.FUN-660156
#        LET g_success='N' RETURN
#    END IF
#END FUNCTION
#No.FUN-A20044 ---mark---end 
 
FUNCTION p378_u_tlf() #------------------------------------ Update tlf_file
  DEFINE la_tlf  DYNAMIC ARRAY OF RECORD LIKE tlf_file.*   #NO.FUN-8C0131 
  DEFINE l_sql   STRING                                    #NO.FUN-8C0131 
  DEFINE l_i     LIKE type_file.num5                       #NO.FUN-8C0131 
   #No.FUN-570122 ----Start----
   IF g_bgjob = 'N' THEN
      MESSAGE "d_tlf!"
   END IF
   #MESSAGE "d_tlf!"
   #No.FUN-570122 ----End----
    CALL ui.Interface.refresh()
  ##NO.FUN-8C0131   add--begin   
    LET l_sql =  " SELECT  * FROM tlf_file ", 
                 "  WHERE  tlf01 = '",b_imn.imn03,"'",
                 "    AND ((tlf026='",g_imm.imm01,"' AND tlf027=",b_imn.imn02,") OR ",
                 "        (tlf036='",g_imm.imm01,"' AND tlf037=",b_imn.imn02,")) ",
                 "   AND tlf06 ='",g_imm.imm02,"'"     
    DECLARE p378_u_tlf_c CURSOR FROM l_sql
    LET l_i = 0 
    CALL la_tlf.clear()
    FOREACH p378_u_tlf_c INTO g_tlf.*
       LET l_i = l_i + 1
       LET la_tlf[l_i].* = g_tlf.*
    END FOREACH     

  ##NO.FUN-8C0131   add--end  
    DELETE FROM tlf_file
           WHERE tlf01 =b_imn.imn03
             AND ((tlf026=g_imm.imm01 AND tlf027=b_imn.imn02) OR
                  (tlf036=g_imm.imm01 AND tlf037=b_imn.imn02)) #異動單號/項次 
             AND tlf06 =g_imm.imm02 #異動日期
    IF STATUS THEN
#      CALL cl_err('del tlf:',STATUS,1) 
       CALL cl_err3("del","tlf_file",g_imm.imm02,"",STATUS,"","del tlf:",1)   #NO.FUN-640266 #No.FUN-660156
       LET g_success='N' RETURN
       LET g_success='N' RETURN
    END IF
    IF SQLCA.SQLERRD[3]=0 THEN
#      CALL cl_err('del tlf:','mfg0177',1) 
       CALL cl_err3("del","tlf_file",g_imm.imm02,"","mfg0177","","del tlf:",1)   #NO.FUN-640266 #No.FUN-660156
       LET g_success='N' RETURN
       LET g_success='N' RETURN
    END IF
  ##NO.FUN-8C0131   add--begin
    FOR l_i = 1 TO la_tlf.getlength()
       LET g_tlf.* = la_tlf[l_i].*
       IF NOT s_untlf1('') THEN 
          LET g_success='N' RETURN
       END IF 
    END FOR       
  ##NO.FUN-8C0131   add--end    
END FUNCTION
 
#-----No.FUN-860045-----
FUNCTION p378_u_tlfs() #------------------------------------ Update tlfs_file
   DEFINE l_ima918   LIKE ima_file.ima918
   DEFINE l_ima921   LIKE ima_file.ima921
 
   SELECT ima918,ima921 INTO l_ima918,l_ima921 
     FROM ima_file
    WHERE ima01 = b_imn.imn03
      AND imaacti = "Y"
   
   IF cl_null(l_ima918) THEN
      LET l_ima918='N'
   END IF
                                                                                
   IF cl_null(l_ima921) THEN
      LET l_ima921='N'
   END IF
 
   IF l_ima918 = "N" AND l_ima921 = "N" THEN
      RETURN
   END IF
 
   IF g_bgjob = 'N' THEN
      MESSAGE "d_tlfs!"
   END IF
 
   CALL ui.Interface.refresh()
 
   DELETE FROM tlfs_file
    WHERE tlfs01 = b_imn.imn03
      AND tlfs10 = b_imn.imn01
      AND tlfs11 = b_imn.imn02
      AND tlfs111 = g_imm.imm02 
 
   IF STATUS THEN
      IF g_bgerr THEN
         LET g_showmsg = b_imn.imn03,'/',g_imm.imm02
         CALL s_errmsg('tlfs01,tlfs111',g_showmsg,'del tlfs:',STATUS,1)
      ELSE
         CALL cl_err3("del","tlfs_file",g_imm.imm01,"",STATUS,"","del tlfs",1)
      END IF
      LET g_success='N'
      RETURN
   END IF
 
   IF SQLCA.SQLERRD[3]=0 THEN
      IF g_bgerr THEN
         LET g_showmsg = b_imn.imn03,'/',g_imm.imm02
         CALL s_errmsg('tlfs01,tlfs111',g_showmsg,'del tlfs:','mfg0177',1)
      ELSE
         CALL cl_err3("del","tlfs_file",g_imm.imm01,"","mfg0177","","del tlfs",1) 
      END IF
      LET g_success='N'
      RETURN
   END IF
 
END FUNCTION
#-----No.FUN-810036 END-----
 
