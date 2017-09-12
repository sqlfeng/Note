# Prog. Version..: '5.30.07-13.05.31(00010)'     #
#
# Pattern name...: anmt400.4gl
# Descriptions...: 外匯交易維護作業
# Date & Author..: 99/05/07 By Iceman FOR TIPTOP 4.00
# Modify.........: No.7875 03/08/21 By Kammy 呼叫自動取單號時應在 Transction中
# Modify.........: No.8144 03/10/14 By Kitty 加上Help說明功能
# Modify.........: No.8138 03/10/20 By Kitty 已key-in anmt420後就不可以確認還原
# Modify.........: No.MOD-480399 Kammy 金額不可小於零
# Modify.........: No.MOD-4A0245 04/10/18 By Yuna 會計分錄產生,若存改原為prompt輸入1 or 2改為用cl_conf,問是否要重新產生
# Modify.........: No.FUN-4B0052 04/11/24 By Nicola 加入"匯率計算"功能
# Modify.........: No.FUN-4C0010 04/12/06 By Nicola 單價、金額欄位改為DEC(20,6)
# Modify.........: NO.FUN-550057 05/05/28 By jackie 單據編號加大
# Modify.........: NO.FUN-5C0015 05/12/20 By TSD.Sideny call s_def_npq:抓取異動碼default值
# Modify.........: No.TQC-620082 06/02/20 By Smapmin 幣別匯率轉換
# Modify.........: No.FUN-630020 06/03/08 By pengu 流程訊息通知功能
# Modify.........: No.MOD-650015 06/05/05 By rainy 取消輸入時的"預設上筆"功能
# Modify.........: No.TQC-660054 06/06/12 By Smapmin 查詢時交易單號開窗有誤
# Modify.........: No.FUN-660148 06/06/21 By Hellen cl_err --> cl_err3
# Modify.........: No.TQC-670008 06/07/05 By rainy 權限修正
# Modify.........: No.FUN-660216 06/07/10 By Rainy CALL cl_cmdrun()中的程式如果是"p"或"t"，則改成CALL cl_cmdrun_wait()
# Modify.........: No.FUN-670060 06/08/03 By Rayven 新增"直接拋轉總帳"功能
# Modify.........: No.MOD-680039 06/08/11 By Smapmin 產生分錄與否應依據anmi100單據性質檔
# Modify.........: No.FUN-680088 06/08/28 By Rayven 新增多帳套功能
# Modify.........: No.FUN-680107 06/09/08 By Hellen 欄位類型修改
# Modify.........: No.FUN-6A0082 06/11/06 By dxfwo l_time轉g_time
# Modify.........: No.FUN-6A0011 06/11/12 By jamie 1.FUNCTION _q() 一開始應清空key值
#                                                  2.新增action"相關文件"
# Modify.........: No.TQC-6C0090 06/12/25 By Smapmin 調整分錄
# Modify.........: No.TQC-6B0105 07/03/07 By carrier 連續兩次查詢,第二次查不到資料,做修改等操作會將當前筆停在上次查詢到的資料上
# Modify.........: No.FUN-740028 07/04/10 By lora    會計科目加帳套
# Modify.........: No.TQC-740093 07/04/17 By lora    會計科目加帳套(日期控制）
# Modify.........: No.FUN-750051 07/05/22 By johnray 連續二次查詢key值時,若第二次查詢不到key值時,會顯示錯誤key值
# Modify.........: No.MOD-760075 07/06/15 By Smapmin 借方幣別一律為買入幣別,貸方幣別一律為賣出幣別
# Modify.........: No.MOD-760142 07/06/29 By Smapmin 延續MOD-760075修改
# Modify.........: No.MOD-770018 07/07/16 By Smapmin 修改分錄摘要
# Modify.........: No.FUN-7C0050 08/01/15 By johnray 串查程序代碼添加共用 ACTION 的引用
# Modify.........: No.FUN-850038 08/05/12 By TSD.odyliao 自定欄位功能修改
# Modify.........: No.FUN-860040 09/01/14 By jan 直接拋轉總帳時，(來源單號)沒有取得值 
# Modify.........: No.FUN-940036 09/04/06 By jan 當其單據性質之【傳票單別】非空白者,即可有ACTION 【拋轉總帳】及【傳票拋轉還原】功能
# Modify.........: No.FUN-980005 09/08/12 By TSD.Martin GP5.2架構重整，修改 INSERT INTO 語法
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-9B0098 10/02/24 by tommas delete cl_doc
# Modify.........: No.FUN-A50102 10/07/12 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No.FUN-9A0036 10/07/28 By chenmoyan 勾選二套帳，分錄底稿二的匯率及本幣金額，應依帳別二進行換算
# Modify.........: No.FUN-A40033 10/07/28 By chenmoyan 二套帳時如果第二套帳幣別和本幣不相同，借貸不平衡產生匯損益時要切立科目
# Modify.........: No.FUN-A40067 10/07/28 By chenmoyan 處理二套帳中本幣金額取位
# Modify.........: No.TQC-AB0414 10/12/03 By lixh1 增加對gxc08,gxc09,gxc10,gxc11輸入負數的控管
# Modify.........: No.MOD-AC0073 10/12/09 By Dido 立即確認時,確認圖示調整
# Modify.........: No.FUN-AA0087 11/01/30 By Mengxw 
# Modify.........: No:FUN-B40056 11/05/11 By lixia 刪除資料時一併刪除tic_file的資料
# Modify.........: No.FUN-B50090 11/06/01 By suncx 財務關帳日期加嚴控管修正
# Modify.........: No.FUN-B50065 11/06/09 By xianghui BUG修改，刪除時提取資料報400錯誤
# Modify.........: No:TQC-B70021 11/07/19 By wujie 抛转tic_file资料 
# Modify.........: No.FUN-B80067 11/08/05 By fengrui  程式撰寫規範修正
# Modify.........: No:FUN-C30085 12/06/20 By lixiang 串CR報表改GR報表
# Modify.........: No:CHI-C90051 12/09/08 By Polly 將拋轉還原程式移至更新確認碼/過帳碼前處理，並判斷傳票編號如不為null時，則RETURN
# Modify.........: No:FUN-D20035 13/02/22 By minpp 將作廢功能分成作廢與取消作廢2個action
# Modify.........: No.FUN-D10065 13/03/07 By wangrr 所有npq04的给值统一放在s_def_npq3（s_def_npq,s_def_npq5等）的后面
#                                                   判断若npq04 为空.则依原给值方式给值
# Modify.........: No:FUN-D40118 13/05/21 By lujh 若科目npq03有做核算控管aag44=Y,但agli122作業沒有維護，則科目給空

DATABASE ds
 
GLOBALS "../../config/top.global"
 
DEFINE
    g_gxc       RECORD LIKE gxc_file.*,
    g_gxc_t     RECORD LIKE gxc_file.*,
    g_gxc_o     RECORD LIKE gxc_file.*,
    g_wc,g_sql  string,                 #No.FUN-580092 HCN
    g_buf       LIKE type_file.chr1000, #No.FUN-680107 VARCHAR(40)
#   g_trno      VARCHAR(12),
    g_trno      LIKE gxc_file.gxc01,    #No.FUN-680107 VARCHAR(16) #No.FUN-550057
    l_n         LIKE type_file.chr1,    #No.FUN-680107 VARCHAR(1)
    g_nmydmy1   LIKE nmy_file.nmydmy1,  #MOD-AC0073
    g_nmydmy3   LIKE nmy_file.nmydmy3,  #MOD-AC0073
#   g_t1        VARCHAR(3),
    g_t1        LIKE nmy_file.nmyslip   #No.FUN-550057  #No.FUN-680107 VARCHAR(5)
 
DEFINE g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done   STRING
DEFINE g_chr                 LIKE type_file.chr1    #No.FUN-680107 VARCHAR(1)
DEFINE g_cnt                 LIKE type_file.num10   #No.FUN-680107 INTEGER
DEFINE g_i                   LIKE type_file.num5    #count/index for any purpose  #No.FUN-680107 SMALLINT
DEFINE g_msg                 LIKE type_file.chr1000 #No.FUN-680107 VARCHAR(72)
DEFINE g_str                 STRING                 #No.FUN-670060
DEFINE g_wc_gl               STRING                 #No.FUN-670060
DEFINE g_dbs_gl              LIKE type_file.chr21   #No.FUN-680107 VARCHAR(21)        #No.FUN-670060
DEFINE g_row_count           LIKE type_file.num10   #No.FUN-680107 INTEGER
DEFINE g_curs_index          LIKE type_file.num10   #No.FUN-680107 INTEGER
DEFINE g_jump                LIKE type_file.num10   #No.FUN-680107 INTEGER
DEFINE mi_no_ask             LIKE type_file.num5    #No.FUN-680107 SMALLINT
DEFINE g_void                LIKE type_file.chr1    #No.FUN-680107 VARCHAR(01)
DEFINE g_argv1               LIKE gxc_file.gxc01    #No.FUN-680107 VARCHAR(16) #No.FUN-630020 add
DEFINE g_argv2               STRING                 #No.FUN-630020 add
DEFINE g_bookno1    LIKE aza_file.aza81    #No.FUN-740028                                                                           
DEFINE g_bookno2    LIKE aza_file.aza82    #No.FUN-740028
DEFINE g_bookno3    LIKE aza_file.aza82    #No.FUN-740028                                                                            
DEFINE g_flag       LIKE type_file.chr1    #No.FUN-740028 
DEFINE g_npq25      LIKE npq_file.npq25    #No.FUN-9A0036
DEFINE g_azi04_2    LIKE azi_file.azi04    #FUN-A40067
DEFINE g_aag44      LIKE aag_file.aag44    #FUN-D40118 add
MAIN
#     DEFINE    l_time LIKE type_file.chr8                #No.FUN-6A0082
    DEFINE p_row,p_col       LIKE type_file.num5    #No.FUN-680107 SMALLINT
 
    OPTIONS
        INPUT NO WRAP
    DEFER INTERRUPT
 
    IF (NOT cl_user()) THEN
       EXIT PROGRAM
    END IF
    WHENEVER ERROR CALL cl_err_msg_log
    IF (NOT cl_setup("ANM")) THEN
       EXIT PROGRAM
    END IF
    LET g_argv1=ARG_VAL(1)          #No.FUN-630020 add
    LET g_argv2=ARG_VAL(2)          #No.FUN-630020 add
      CALL  cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0082
 
    INITIALIZE g_gxc.* TO NULL
    INITIALIZE g_gxc_t.* TO NULL
    INITIALIZE g_gxc_o.* TO NULL
    LET g_forupd_sql = "SELECT * FROM gxc_file WHERE gxc01 = ? FOR UPDATE"
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE t400_cl CURSOR FROM g_forupd_sql              # LOCK CURSOR
    LET p_row = 4 LET p_col = 5
    OPEN WINDOW t400_w AT p_row,p_col
        WITH FORM "anm/42f/anmt400"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_init()
 
    WHILE TRUE
   # No.FUN-630020--start--
   # 先以g_argv2判斷直接執行哪種功能，執行Q時，g_argv1是出貨單號(oga01)
   # 執行I時，g_argv1是單號(gxf011)
   IF NOT cl_null(g_argv1) THEN
      CASE g_argv2
         WHEN "query"
            LET g_action_choice = "query"
            IF cl_chk_act_auth() THEN
               CALL t400_q()
            END IF
         WHEN "insert"
            LET g_action_choice = "insert"
            IF cl_chk_act_auth() THEN
               CALL t400_a()
            END IF
         OTHERWISE
                CALL t400_q()
      END CASE
   END IF
   #No.FUN-630020 ----end---
      LET g_action_choice = ""
      CALL t400_menu()
      IF g_action_choice = "exit" THEN
         EXIT WHILE
      END IF
    END WHILE
    CLOSE WINDOW t400_w
      CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0082
END MAIN
 
FUNCTION t400_cs()
    CLEAR FORM
    IF cl_null(g_argv1) THEN         #No.FUN-630020 add
   INITIALIZE g_gxc.* TO NULL    #No.FUN-750051
       CONSTRUCT BY NAME g_wc ON                    # 螢幕上取條件
                         gxc01,gxc02,gxc03,gxc04,gxc041,gxc05,gxc06,gxc07,
                         gxc08,gxc09,gxc10,gxc11,gxc12,gxc13,gxc14,gxc141
                 #No.FUN-580031 --start--     HCN
                         #FUN-850038   ---start---
                         ,gxcud01,gxcud02,gxcud03,gxcud04,gxcud05,
                         gxcud06,gxcud07,gxcud08,gxcud09,gxcud10,
                         gxcud11,gxcud12,gxcud13,gxcud14,gxcud15
                         #FUN-850038    ----end----
                 BEFORE CONSTRUCT
                    CALL cl_qbe_init()
                 #No.FUN-580031 --end--       HCN
      
           ON ACTION CONTROLP
               CASE
                  WHEN INFIELD(gxc01) #單號
                  #-----TQC-660054---------
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gxc"
                  LET g_qryparam.state = "c"
                  LET g_qryparam.default1 = g_gxc.gxc01
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO gxc01
                  NEXT FIELD gxc01
                  #LET g_t1 = g_gxc.gxc01[1,3]
                  #CALL q_nmy(6,15,g_t1,'9',g_sys) RETURNING g_t1
                  #CALL q_nmy(TRUE,FALSE,g_t1,'9',g_sys) RETURNING g_t1
                  #LET g_gxc.gxc01[1,3] = g_t1
                  #DISPLAY BY NAME g_gxc.gxc01 NEXT FIELD gxc01
                  #-----END TQC-660054-----
                  WHEN INFIELD(gxc05) #幣別
#                    CALL q_azi(05,10,g_gxc.gxc05) RETURNING g_gxc.gxc05
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_azi"
                     LET g_qryparam.state = "c"
                     LET g_qryparam.default1 = g_gxc.gxc05
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO gxc05
                     NEXT FIELD gxc05
                  WHEN INFIELD(gxc06) #幣別
#                    CALL q_azi(05,10,g_gxc.gxc06) RETURNING g_gxc.gxc06
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_azi"
                     LET g_qryparam.state = "c"
                     LET g_qryparam.default1 = g_gxc.gxc06
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO gxc06
                     NEXT FIELD gxc06
                  WHEN INFIELD(gxc07) #全省銀行
#                    CALL q_alg(5,10,g_gxc.gxc07) RETURNING g_gxc.gxc07
                     CALL cl_init_qry_var()
                     LET g_qryparam.form = "q_alg"
                     LET g_qryparam.state = "c"
                     LET g_qryparam.default1 = g_gxc.gxc07
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO gxc07
                     NEXT FIELD gxc07
               END CASE
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
      
         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121
      
         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121
      
         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121
      
      
           	#No.FUN-580031 --start--     HCN
                   ON ACTION qbe_select
            	   CALL cl_qbe_select()
                   ON ACTION qbe_save
           	   CALL cl_qbe_save()
           	#No.FUN-580031 --end--       HCN
       END CONSTRUCT
       LET g_wc = g_wc CLIPPED,cl_get_extra_cond(null, null) #FUN-980030
       IF INT_FLAG THEN RETURN END IF
  #No.FUN-630020-begin
     ELSE
        LET g_wc =" gxc01 = '",g_argv1,"'"
     END IF
  #No.FUN-630020-end
    LET g_sql="SELECT gxc01 FROM gxc_file ", # 組合出 SQL 指令
              " WHERE ",g_wc CLIPPED," ORDER BY gxc01"
    PREPARE t400_pre FROM g_sql           # RUNTIME 編譯
    DECLARE t400_cs                       # SCROLL CURSOR
        SCROLL CURSOR WITH HOLD FOR t400_pre
    LET g_sql="SELECT COUNT(*) FROM gxc_file WHERE ",g_wc CLIPPED
    PREPARE t400_precount FROM g_sql
    DECLARE t400_count CURSOR FOR t400_precount
END FUNCTION
 
FUNCTION t400_menu()
    MESSAGE ''
    MENU ""
 
        BEFORE MENU
            CALL cl_navigator_setting( g_curs_index, g_row_count )
 
            #No.FUN-680029 --start--
            IF g_aza.aza63 = 'N' THEN
               CALL cl_set_act_visible("entry_sheet2",FALSE)
            END IF
            #No.FUN-680029 --end--
 
        ON ACTION insert
            LET g_action_choice="insert"
            IF cl_chk_act_auth() THEN
               CALL t400_a()
            END IF
        ON ACTION query
            LET g_action_choice="query"
            IF cl_chk_act_auth() THEN
               CALL t400_q()
            END IF
        ON ACTION next      
           CALL t400_fetch('N')
        ON ACTION previous  
           CALL t400_fetch('P')
        ON ACTION modify
            LET g_action_choice="modify"
            IF cl_chk_act_auth() THEN
               CALL t400_u()
            END IF
        ON ACTION void
           LET g_action_choice="void"
           IF cl_chk_act_auth() THEN
             #CALL t400_x()                        #FUN-D20035
              CALL t400_x(1)                       #FUN-D20035
              IF g_gxc.gxc13 = 'X' THEN
                 LET g_void = 'Y'
              ELSE
                 LET g_void = 'N'
              END IF
              CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
           END IF
         #FUN-D20035----add---str
         ON ACTION undo_void
           LET g_action_choice="void"
           IF cl_chk_act_auth() THEN
              CALL t400_x(2)            
              IF g_gxc.gxc13 = 'X' THEN
                 LET g_void = 'Y'
              ELSE
                 LET g_void = 'N'
              END IF
              CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
           END IF
         #FUN-D20035----add---end
        ON ACTION confirm
            LET g_action_choice="confirm"
            IF cl_chk_act_auth() THEN
               CALL t400_y()
               IF g_gxc.gxc13 = 'X' THEN
                  LET g_void = 'Y'
               ELSE
                  LET g_void = 'N'
               END IF
               CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
            END IF
        ON ACTION undo_confirm
            LET g_action_choice="undo_confirm"
            IF cl_chk_act_auth() THEN
               CALL t400_z()
               IF g_gxc.gxc13 = 'X' THEN
                  LET g_void = 'Y'
               ELSE
                  LET g_void = 'N'
               END IF
               CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
            END IF
        ON ACTION delete
            LET g_action_choice="delete"
            IF cl_chk_act_auth() THEN
               CALL t400_r()
            END IF
        ON ACTION output
           LET g_action_choice="output"
           IF cl_chk_act_auth() THEN
              CALL t400_out('o')
           END IF
        ON ACTION gen_entry
           LET g_action_choice="gen_entry"
           IF cl_chk_act_auth() THEN
              CALL t400_v('0')  #No.FUN-680088 add '0'
              #No.FUN-680088 --start--
              IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
                 CALL t400_v('1') 
              END IF
              #No.FUN-680088 --end--
           END IF
        ON ACTION entry_sheet
            LET g_action_choice="entry_sheet"
            IF cl_chk_act_auth() AND g_gxc.gxc13 != 'X' THEN
               CALL s_fsgl('NM',9,g_gxc.gxc01,0,g_nmz.nmz02b,0,g_gxc.gxc13,'0',g_nmz.nmz02p)  #No.FUN-680088 add '0',g_nmz.nmz02p
               CALL cl_navigator_setting( g_curs_index, g_row_count )  #No.FUN-680088
               CALL t400_npp02('0')  #No.+086 010502 by plum  #No.FUN-680088
            END IF
 
        #No.FUN-680088 --start--
        ON ACTION entry_sheet2
            LET g_action_choice="entry_sheet2"
            IF cl_chk_act_auth() AND g_gxc.gxc13 != 'X' THEN
               CALL s_fsgl('NM',9,g_gxc.gxc01,0,g_nmz.nmz02c,0,g_gxc.gxc13,'1',g_nmz.nmz02p)
               CALL cl_navigator_setting( g_curs_index, g_row_count )
               CALL t400_npp02('1')
            END IF
        #No.FUN-680088 --end--
 
#No.FUN-670060 --start--
#       ON ACTION carry_voucher
#           #CALL cl_cmdrun('anmp100')       #FUN-660216 remark
#           CALL cl_cmdrun_wait('anmp100')   #FUN-660216 add
#       ON ACTION undo_carry                 #FUN-660216 remark
#           CALL cl_cmdrun_wait('anmp110')   #FUN-660216 add
        ON ACTION carry_voucher                                                                                                     
           IF cl_chk_act_auth() THEN
              IF g_gxc.gxc13 = 'Y' THEN                                                                                              
                 CALL t400_carry_voucher()                                                                                             
               ELSE 
                  CALL cl_err('','atm-402',1)
              END IF                                                                                                                   
           END IF
        ON ACTION undo_carry_voucher                                                                                                
           IF cl_chk_act_auth() THEN
              IF g_gxc.gxc13 = 'Y' THEN                                                                                              
                 CALL t400_undo_carry_voucher()                                                                                        
               ELSE 
                  CALL cl_err('','atm-403',1)
              END IF
           END IF
#No.FUN-670060 --end--
        ON ACTION locale
            CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
            CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
        ON ACTION exit
           LET g_action_choice = "exit"
           EXIT MENU
 
        ON ACTION jump CALL t400_fetch('/')
        ON ACTION first CALL t400_fetch('F')
        ON ACTION last CALL t400_fetch('L')
        ON ACTION CONTROLG  CALL cl_cmdask()
 
        ON ACTION help    #No.8144
           CALL cl_show_help()
 
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
 
        ON ACTION about         #MOD-4C0121
           CALL cl_about()      #MOD-4C0121
 
        #No.FUN-6A0011--------add----------str----
        ON ACTION related_document       #相關文件
           LET g_action_choice="related_document"
           IF cl_chk_act_auth() THEN
               IF g_gxc.gxc01 IS NOT NULL THEN
                  LET g_doc.column1 = "gxc01"
                  LET g_doc.value1 = g_gxc.gxc01
                  CALL cl_doc()
               END IF
           END IF
        #No.FUN-6A0011--------add----------end----
            LET g_action_choice = "exit"
           CONTINUE MENU
 
         -- for Windows close event trapped
         ON ACTION close   #COMMAND KEY(INTERRUPT) #FUN-9B0145  
             LET INT_FLAG=FALSE 		#MOD-570244	mars
             LET g_action_choice = "exit"
             EXIT MENU
 
      #No.FUN-7C0050 add
      &include "qry_string.4gl"
    END MENU
    CLOSE t400_cs
END FUNCTION
 
FUNCTION t400_a()
DEFINE li_result   LIKE type_file.num5        #No.FUN-550057  #No.FUN-680107 SMALLINT
 
    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM                                   # 清螢墓欄位內容
    INITIALIZE g_gxc.* LIKE gxc_file.*
    LET g_gxc.gxc02 = '1'
    LET g_gxc.gxc03 = g_today
    LET g_gxc.gxc04 = g_today
    LET g_gxc.gxc041 = g_today
    LET g_gxc.gxc141 = ''
    LET g_gxc.gxc08 = 0
    LET g_gxc.gxc09 = 1
    LET g_gxc.gxc10 = 1
    LET g_gxc.gxc11 = 1
    LET g_gxc.gxc13 = 'N'
    CALL cl_opmsg('a')
    WHILE TRUE
        CALL t400_i("a")                      # 各欄位輸入
        IF INT_FLAG THEN                         # 若按了DEL鍵
           LET INT_FLAG = 0
           CALL cl_err('',9001,0)
           CLEAR FORM
           EXIT WHILE
        END IF
         #No.MOD-480399
        IF g_gxc.gxc08 <= 0 THEN
           CALL cl_err('','aap-201',1)
           CONTINUE WHILE
        END IF
         #No.MOD-480399 (end)
        BEGIN WORK  #No.7875
#No.FUN-550057 --start--
        CALL s_auto_assign_no("anm",g_gxc.gxc01,g_gxc.gxc03,"9","gxc_file","gxc01","","","")
             RETURNING li_result,g_gxc.gxc01
        IF (NOT li_result) THEN
           CONTINUE WHILE
        END IF
        DISPLAY BY NAME g_gxc.gxc01
#        IF g_nmy.nmyauno='Y' THEN
#           CALL s_nmyauno(g_gxc.gxc01,g_gxc.gxc03,'9')
#                   RETURNING g_i,g_gxc.gxc01
#           IF g_i THEN CONTINUE WHILE END IF
#           DISPLAY BY NAME g_gxc.gxc01
#	END IF
#No.FUN-550057 ---end--
 
        IF cl_null(g_gxc.gxc01) THEN                # KEY 不可空白
           CONTINUE WHILE
        END IF
        
        #FUN-980005 add legal 
        LET g_gxc.gxclegal = g_legal 
        #FUN-980005 end legal 
 
        INSERT INTO gxc_file VALUES(g_gxc.*)       # DISK WRITE
        IF SQLCA.sqlcode THEN
           CALL cl_err3("ins","gxc_file",g_gxc.gxc01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660148 #No.FUN-B80067---調整至回滾事務前---
           ROLLBACK WORK #No.7875
#          CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)   #No.FUN-660148
           CONTINUE WHILE
        ELSE
          #-MOD-AC0073-add-
           #---判斷是否立即confirm-----
           LET g_t1 = s_get_doc_no(g_gxc.gxc01)    
           SELECT nmydmy1,nmydmy3 INTO g_nmydmy1,g_nmydmy3
             FROM nmy_file
            WHERE nmyslip = g_t1 AND nmyacti = 'Y'
           IF g_nmydmy3 = 'Y' THEN
              IF cl_confirm('axr-309') THEN
                 CALL t400_v('0')  
                 IF g_aza.aza63 = 'Y' THEN
                    CALL t400_v('1')
                 END IF
              END IF
           END IF
           IF g_nmydmy1 = 'Y' AND g_nmydmy3='N' THEN CALL t400_y() END IF
          #-MOD-AC0073-end-
           COMMIT WORK   #No.7875
           CALL cl_flow_notify(g_gxc.gxc01,'I')
           LET g_gxc_t.* = g_gxc.*                # 保存上筆資料
           SELECT gxc01 INTO g_gxc.gxc01 FROM gxc_file
            WHERE gxc01 = g_gxc.gxc01
        END IF
        EXIT WHILE
    END WHILE
END FUNCTION
 
FUNCTION t400_i(p_cmd)
    DEFINE p_cmd    LIKE type_file.chr1,    #No.FUN-680107 VARCHAR(1)
           l_cnt    LIKE type_file.num5,    #No.FUN-680107 SMALLINT
           l_buf    LIKE type_file.chr6,    #No.FUN-680107 VARCHAR(06)
           l_mxno   LIKE type_file.chr4,    #No.FUN-680107 VARCHAR(04)
           l_gxc01  LIKE gxc_file.gxc01,    #No.FUN-680107 VARCHAR(08)
           l_aag01  LIKE aag_file.aag01,
           l_aag02  LIKE aag_file.aag02
    DEFINE li_result LIKE type_file.num5    #No.FUN-550057  #No.FUN-680107 SMALLINT
 
    INPUT BY NAME g_gxc.gxc01,g_gxc.gxc02,g_gxc.gxc03,g_gxc.gxc04,
                  g_gxc.gxc041,
                  g_gxc.gxc05,g_gxc.gxc06,g_gxc.gxc07,g_gxc.gxc08,
                  g_gxc.gxc09,g_gxc.gxc10,g_gxc.gxc11,g_gxc.gxc12,
                  g_gxc.gxc13,g_gxc.gxc14,g_gxc.gxc141
                  #FUN-850038     ---start---
                  ,g_gxc.gxcud01,g_gxc.gxcud02,g_gxc.gxcud03,g_gxc.gxcud04,
                  g_gxc.gxcud05,g_gxc.gxcud06,g_gxc.gxcud07,g_gxc.gxcud08,
                  g_gxc.gxcud09,g_gxc.gxcud10,g_gxc.gxcud11,g_gxc.gxcud12,
                  g_gxc.gxcud13,g_gxc.gxcud14,g_gxc.gxcud15 
                  #FUN-850038     ----end----
                  WITHOUT DEFAULTS
 
        BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL t400_set_entry(p_cmd)
            CALL t400_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE
#No.FUN-550057 --start--
         CALL cl_set_docno_format("gxc01")
#No.FUN-550057 ---end---
 
        AFTER FIELD gxc01
           IF NOT cl_null(g_gxc.gxc01) AND (g_gxc.gxc01 != g_gxc_t.gxc01) THEN
#No.FUN-550057 --start--
            CALL s_check_no("anm",g_gxc.gxc01,g_gxc_t.gxc01,"9","gxc_file","gxc01","")
               RETURNING li_result,g_gxc.gxc01
            DISPLAY BY NAME g_gxc.gxc01
            IF (NOT li_result) THEN
               NEXT FIELD gxc01
            END IF
#              IF NOT cl_null(g_gxc.gxc01[5,10]) THEN
#                 IF p_cmd = 'a' OR
#                    (p_cmd = 'u' AND THEN
#    g_t1        VARCHAR(3),
#                     SELECT COUNT(*) INTO l_cnt FROM gxc_file
#                      WHERE gxc01 = g_gxc.gxc01
#                     IF l_cnt > 0 THEN
#                        CALL cl_err(g_gxc.gxc01,'-239',1)
#                        LET g_gxc.gxc01 = g_gxc_t.gxc01
#                        DISPLAY BY NAME g_gxc.gxc01
#                        NEXT FIELD gxc01
#                     END IF
#                 END IF
#              END IF
#              LET g_t1=g_gxc.gxc01[1,3]
#              CALL s_nmyslip(g_t1,'9',g_sys)  #單別,單據性質-外匯交易單號NO:6842
#              IF NOT cl_null(g_errno) THEN
#                 CALL cl_err(g_t1,g_errno,0)
#                 NEXT FIELD gxc01
#              END IF
#              IF g_nmy.nmyauno MATCHES '[nN]' THEN
#                 IF cl_null(g_gxc.gxc01[5,10]) THEN
#                    CALL cl_err(g_gxc.gxc01,'anm-108',0)
#                    NEXT FIELD gxc01
#                 END IF
#              END IF
#No.FUN-550057 ---end---
           END IF
 
        AFTER FIELD gxc02
           IF g_gxc.gxc02 NOT MATCHES '[12]' THEN
              NEXT FIELD gxc02
           END IF
         #No.TQC-740028  --Begin
         #No.FUN-740028  --Begin
     #   AFTER FIELD gxc03
                                                                                                   
     #    CALL s_get_bookno(YEAR(g_gxc.gxc03)) RETURNING g_flag,g_bookno1,g_bookno2                                                     
     #   IF g_flag =  '1' THEN  #抓不到帳別                                                                                            
     #   CALL cl_err(g_gxc.gxc03,'aoo-081',1)                                                                                          
     #    END IF                                                                                                                        
     #No.FUN-740028  --End     
     #No.TQC-740093 --Begin         
        AFTER FIELD gxc04
           #FUN-B50090 add begin-------------------------
           #重新抓取關帳日期
           SELECT nmz10 INTO g_nmz.nmz10 FROM nmz_file WHERE nmz00='0'
           #FUN-B50090 add -end--------------------------
           IF g_gxc.gxc04 <= g_nmz.nmz10 THEN  #no.5261
              CALL cl_err('','aap-176',1) NEXT FIELD gxc04
           END IF
        AFTER FIELD gxc041
           IF g_gxc.gxc04 > g_gxc.gxc041 THEN
              CALL cl_err('','aap-100',0) NEXT FIELD gxc041
           END IF
        AFTER FIELD gxc05
           IF NOT cl_null(g_gxc.gxc05) THEN
              SELECT COUNT(*) INTO l_n  FROM azi_file WHERE azi01 = g_gxc.gxc05
              IF l_n = 0 THEN CALL cl_err('','aap-002',0) NEXT FIELD gxc05
              END IF
           END IF
        AFTER FIELD gxc06
           IF NOT cl_null(g_gxc.gxc06) THEN
              SELECT COUNT(*) INTO l_n  FROM azi_file WHERE azi01 = g_gxc.gxc06
              IF l_n = 0 THEN CALL cl_err('','aap-002',0) NEXT FIELD gxc06
              END IF
           END IF
        AFTER FIELD gxc07
           IF NOT cl_null(g_gxc.gxc01) THEN
               SELECT COUNT(*) INTO l_n FROM alg_file WHERE alg01 = g_gxc.gxc07
               IF l_n = 0 THEN CALL cl_err('','aap-007',0)
                   NEXT FIELD gxc07
               END IF
               SELECT alg021 INTO g_buf FROM alg_file
                WHERE alg01 = g_gxc.gxc07
               DISPLAY g_buf TO alg021
              LET l_aag01 = '2110-',g_gxc.gxc07[2,3]
              LET l_aag02 = ''
               SELECT aag02 INTO l_aag02 FROM aag_file WHERE aag01 = l_aag01
                                                         AND aag00 = g_bookno1   #No.FUN-740028
           END IF
        AFTER FIELD gxc08
           IF cl_null(g_gxc.gxc08) THEN LET g_gxc.gxc08 = 0 END IF
#TQC-AB0414 -----------------------------Begin-----------------------------
           IF g_gxc.gxc08 < 0 THEN
              CALL cl_err(g_gxc.gxc08,'anmt002',0)
              NEXT FIELD gxc08
           END IF
#TQC-AB0414 -----------------------------End------------------------------
        AFTER FIELD gxc09
           IF cl_null(g_gxc.gxc09) THEN LET g_gxc.gxc09 = 1 END IF
#TQC-AB0414 -----------------------------Begin-----------------------------
           IF g_gxc.gxc09 < 0 THEN
              CALL cl_err(g_gxc.gxc09,'anmt002',0)
              NEXT FIELD gxc09
           END IF
#TQC-AB0414 -----------------------------End------------------------------
        AFTER FIELD gxc10
           IF cl_null(g_gxc.gxc10) THEN LET g_gxc.gxc10 = 1 END IF
#TQC-AB0414 -----------------------------Begin-----------------------------
           IF g_gxc.gxc10 < 0 THEN
              CALL cl_err(g_gxc.gxc10,'anmt002',0)
              NEXT FIELD gxc10
           END IF
#TQC-AB0414 -----------------------------End------------------------------
        AFTER FIELD gxc11
           IF cl_null(g_gxc.gxc11) THEN LET g_gxc.gxc11 = 1 END IF
#TQC-AB0414 -----------------------------Begin-----------------------------
           IF g_gxc.gxc11 < 0 THEN
              CALL cl_err(g_gxc.gxc11,'anmt002',0)
              NEXT FIELD gxc11
           END IF
#TQC-AB0414 -----------------------------End------------------------------
 
        #FUN-850038     ---start---
        AFTER FIELD gxcud01
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud02
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud03
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud04
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud05
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud06
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud07
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud08
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud09
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud10
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud11
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud12
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud13
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud14
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        AFTER FIELD gxcud15
           IF NOT cl_validate() THEN NEXT FIELD CURRENT END IF
        #FUN-850038     ----end----
 
 
        AFTER INPUT
           IF INT_FLAG THEN EXIT INPUT END IF
 
        #MOD-650015 --start 
        #ON ACTION CONTROLO                        # 沿用所有欄位
        #   IF INFIELD(gxc01) THEN
        #      LET g_gxc.* = g_gxc_t.*
        #      DISPLAY BY NAME g_gxc.*
        #      NEXT FIELD gxc01
        #   END IF
        #MOD-650015 --start 
 
        ON ACTION CONTROLP
            CASE
               WHEN INFIELD(gxc01) #單號
#                  LET g_t1 = g_gxc.gxc01[1,3]
                  LET g_t1 = s_get_doc_no(g_gxc.gxc01)       #No.FUN-550057
#                 CALL q_nmy(6,15,g_t1,'9',g_sys) RETURNING g_t1
                 #CALL q_nmy(FALSE,FALSE,g_t1,'9',g_sys) RETURNING g_t1  #TQC-670008
                  CALL q_nmy(FALSE,FALSE,g_t1,'9','ANM') RETURNING g_t1  #TQC-670008
#                  CALL FGL_DIALOG_SETBUFFER( g_t1 )
   #               LET g_gxc.gxc01[1,3] = g_t1
                  LET g_gxc.gxc01 = g_t1        #No.FUN-550057
                  DISPLAY BY NAME g_gxc.gxc01 NEXT FIELD gxc01
               WHEN INFIELD(gxc05) #幣別
#                 CALL q_azi(05,10,g_gxc.gxc05) RETURNING g_gxc.gxc05
#                 CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc05 )
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_azi"
                  LET g_qryparam.default1 = g_gxc.gxc05
                  CALL cl_create_qry() RETURNING g_gxc.gxc05
#                  CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc05 )
                  DISPLAY BY NAME g_gxc.gxc05
                  NEXT FIELD gxc05
               WHEN INFIELD(gxc06) #幣別
#                 CALL q_azi(05,10,g_gxc.gxc06) RETURNING g_gxc.gxc06
#                 CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc06 )
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_azi"
                  LET g_qryparam.default1 = g_gxc.gxc06
                  CALL cl_create_qry() RETURNING g_gxc.gxc06
#                  CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc06 )
                  DISPLAY BY NAME g_gxc.gxc06
                  NEXT FIELD gxc06
               WHEN INFIELD(gxc07) #全省銀行
#                 CALL q_alg(5,10,g_gxc.gxc07) RETURNING g_gxc.gxc07
#                 CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc07 )
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_alg"
                  LET g_qryparam.default1 = g_gxc.gxc07
                  CALL cl_create_qry() RETURNING g_gxc.gxc07
#                  CALL FGL_DIALOG_SETBUFFER( g_gxc.gxc07 )
                  DISPLAY BY NAME g_gxc.gxc07
                  NEXT FIELD gxc07
              #-----No.FUN-4B0052-----
              WHEN INFIELD(gxc09)
                   CALL s_rate(g_gxc.gxc05,g_gxc.gxc09) RETURNING g_gxc.gxc09
                   DISPLAY BY NAME g_gxc.gxc09
                   NEXT FIELD gxc09
              WHEN INFIELD(gxc10)
                   CALL s_rate(g_gxc.gxc06,g_gxc.gxc10) RETURNING g_gxc.gxc10
                   DISPLAY BY NAME g_gxc.gxc10
                   NEXT FIELD gxc10
              #-----No.FUN-4B0052 END-----
            END CASE
 
        ON ACTION CONTROLR
            CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
            CALL cl_cmdask()
 
        ON ACTION CONTROLF                        # 欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
    END INPUT
END FUNCTION
 
FUNCTION t400_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_gxc.* TO NULL              #No.FUN-6A0011
    MESSAGE ""
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL t400_cs()                          # 宣告 SCROLL CURSOR
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       CLEAR FORM
       RETURN
    END IF
    MESSAGE " SEARCHING ! "
    OPEN t400_count
    FETCH t400_count INTO g_row_count
    DISPLAY g_row_count TO FORMONLY.cnt
    OPEN t400_cs                            # 從DB產生合乎條件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)
       INITIALIZE g_gxc.* TO NULL
    ELSE
       CALL t400_fetch('F')                  # 讀出TEMP第一筆並顯示
    END IF
    MESSAGE ""
END FUNCTION
 
FUNCTION t400_fetch(p_flgxc)
    DEFINE
        p_flgxc  LIKE type_file.chr1,    #No.FUN-680107 VARCHAR(1)
        l_abso   LIKE type_file.num10    #No.FUN-680107 INTEGER
 
    CASE p_flgxc
        WHEN 'N' FETCH NEXT     t400_cs INTO g_gxc.gxc01
        WHEN 'P' FETCH PREVIOUS t400_cs INTO g_gxc.gxc01
        WHEN 'F' FETCH FIRST    t400_cs INTO g_gxc.gxc01
        WHEN 'L' FETCH LAST     t400_cs INTO g_gxc.gxc01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
               CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
               LET INT_FLAG = 0  ######add for prompt bug
               PROMPT g_msg CLIPPED,': ' FOR g_jump
                  ON IDLE g_idle_seconds
                     CALL cl_on_idle()
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
               END PROMPT
               IF INT_FLAG THEN
                   LET INT_FLAG = 0
                   EXIT CASE
               END IF
            END IF
            FETCH ABSOLUTE g_jump t400_cs INTO g_gxc.gxc01
            LET mi_no_ask = FALSE
    END CASE
 
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)
        INITIALIZE g_gxc.* TO NULL  #TQC-6B0105
        RETURN
    ELSE
       CASE p_flgxc
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
 
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF
      #No.FUN-740028  --Begin                                                                                                          
      CALL s_get_bookno(YEAR(g_gxc.gxc03)) RETURNING g_flag,g_bookno1,g_bookno2                                         
      IF g_flag =  '1' THEN  #抓不到帳別                                                                                               
      CALL cl_err(g_gxc.gxc03,'aoo-081',1)                                                                                          
      END IF                                                                                                                           
   #No.FUN-740028  --End  
 
    SELECT * INTO g_gxc.* FROM gxc_file            # 重讀DB,因TEMP有不被更新特性
     WHERE gxc01 = g_gxc.gxc01
    IF SQLCA.sqlcode THEN
#      CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)   #No.FUN-660148
       CALL cl_err3("sel","gxc_file",g_gxc.gxc01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660148
    ELSE
 
       CALL t400_show()                           # 重新顯示
    END IF
END FUNCTION
 
FUNCTION t400_show()
    LET g_gxc_t.* = g_gxc.*
    DISPLAY BY NAME g_gxc.gxc01,g_gxc.gxc02,g_gxc.gxc03,g_gxc.gxc04,
                    g_gxc.gxc041,g_gxc.gxc141,
                    g_gxc.gxc05,g_gxc.gxc06,g_gxc.gxc07,g_gxc.gxc08,
                    g_gxc.gxc09,g_gxc.gxc10,g_gxc.gxc11,g_gxc.gxc12,
                    g_gxc.gxc13,g_gxc.gxc14
                    #FUN-850038     ---start---
                    ,g_gxc.gxcud01,g_gxc.gxcud02,g_gxc.gxcud03,g_gxc.gxcud04,
                    g_gxc.gxcud05,g_gxc.gxcud06,g_gxc.gxcud07,g_gxc.gxcud08,
                    g_gxc.gxcud09,g_gxc.gxcud10,g_gxc.gxcud11,g_gxc.gxcud12,
                    g_gxc.gxcud13,g_gxc.gxcud14,g_gxc.gxcud15 
                    #FUN-850038     ----end----
    SELECT alg021 INTO g_buf FROM alg_file WHERE alg01 = g_gxc.gxc07
    IF SQLCA.sqlcode THEN LET g_buf = ' ' END IF
    DISPLAY g_buf TO alg021
    IF g_gxc.gxc13 = 'X' THEN
       LET g_void = 'Y'
    ELSE
       LET g_void = 'N'
    END IF
    CALL cl_set_field_pic(g_gxc.gxc13,"","","",g_void,"")
    CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
END FUNCTION
 
FUNCTION t400_u()
    IF s_shut(0) THEN RETURN END IF
    SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01 = g_gxc.gxc01
    IF cl_null(g_gxc.gxc01) THEN CALL cl_err('',-400,0) RETURN END IF
    IF g_gxc.gxc13 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    IF g_gxc.gxc13 = 'Y' THEN CALL cl_err('','9023',0) RETURN END IF
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_gxc_t.* =g_gxc.*
    BEGIN WORK
    OPEN t400_cl USING g_gxc.gxc01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_gxc.*               # 對DB鎖定
    IF STATUS THEN CALL cl_err(g_gxc.gxc01,STATUS,0) RETURN END IF
    CALL t400_show()                          # 顯示最新資料
    WHILE TRUE
        CALL t400_i("u")                      # 欄位更改
        IF INT_FLAG THEN
           LET INT_FLAG = 0
           LET g_gxc.*=g_gxc_t.*
           CALL t400_show()
           CALL cl_err('',9001,0)
           EXIT WHILE
        END IF
         #No.MOD-480399
        IF g_gxc.gxc08 <= 0 THEN
           CALL cl_err('','aap-201',1)
           CONTINUE WHILE
        END IF
         #No.MOD-480399 (end)
        UPDATE gxc_file SET gxc_file.* = g_gxc.*    # 更新DB
         WHERE gxc01 = g_gxc.gxc01             # COLAUTH?
        IF SQLCA.sqlcode THEN
#          CALL cl_err('(t400_u:gxc)',SQLCA.sqlcode,1)   #No.FUN-660148
           CALL cl_err3("upd","gxc_file",g_gxc.gxc01,"",SQLCA.sqlcode,"","(t400_u:gxc)",1)  #No.FUN-660148
           CONTINUE WHILE
        END IF
       #No.+086 010502 by plum
        IF g_gxc.gxc03 != g_gxc_t.gxc03 THEN            # 更改單號
           UPDATE npp_file SET npp02=g_gxc.gxc03
            WHERE npp01=g_gxc.gxc01 AND npp00=9 AND npp011=0
              AND nppsys = 'NM'
           IF STATUS THEN 
#             CALL cl_err('upd npp02:',STATUS,1) #No.FUN-660148
              CALL cl_err3("upd","npp_file",g_gxc.gxc01,"",STATUS,"","upd npp02:",1)  #No.FUN-660148
           END IF
        END IF
       #No.+086..end
        EXIT WHILE
    END WHILE
    CLOSE t400_cl
    COMMIT WORK
    CALL cl_flow_notify(g_gxc.gxc01,'U')
END FUNCTION
 
#No.+086 010502 by plum
FUNCTION t400_npp02(p_npptype)  #No.FUN-680088 add p_npptype
 DEFINE p_npptype  LIKE npp_file.npptype  #No.FUN-680088
 
  IF g_gxc.gxc14 IS NULL OR g_gxc.gxc14=' ' THEN
     UPDATE npp_file SET npp02=g_gxc.gxc03
        WHERE npp01=g_gxc.gxc01 AND npp00=9 AND npp011=0
        AND nppsys = 'NM'
        AND npptype = p_npptype  #No.FUN-680088
     IF STATUS THEN 
#       CALL cl_err('upd npp02:',STATUS,1) #No.FUN-660148
        CALL cl_err3("upd","npp_file",g_gxc.gxc01,"",STATUS,"","upd npp02:",1)  #No.FUN-660148
     END IF
  END IF
END FUNCTION
#No.+086..end
 
FUNCTION t400_r()
    IF s_shut(0) THEN RETURN END IF
    SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01 = g_gxc.gxc01
    IF cl_null(g_gxc.gxc01) THEN CALL cl_err('',-400,0) RETURN END IF
    IF g_gxc.gxc13 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    IF g_gxc.gxc13 = 'Y' THEN CALL cl_err('','9023',0) RETURN END IF
    BEGIN WORK
    OPEN t400_cl USING g_gxc.gxc01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_gxc.*
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)
       RETURN
    END IF
    CALL t400_show()
    IF cl_delete() THEN
        INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
        LET g_doc.column1 = "gxc01"         #No.FUN-9B0098 10/02/24
        LET g_doc.value1 = g_gxc.gxc01      #No.FUN-9B0098 10/02/24
        CALL cl_del_doc()                                         #No.FUN-9B0098 10/02/24
       DELETE FROM gxc_file WHERE gxc01 = g_gxc.gxc01
       IF SQLCA.sqlcode THEN
#         CALL cl_err('(t400_r:delete gxc)',SQLCA.sqlcode,1)   #No.FUN-660148
          CALL cl_err3("del","gxc_file",g_gxc.gxc01,"",SQLCA.sqlcode,"","(t400_r:delete gxc)",1)  #No.FUN-660148
       END IF
       CLEAR FORM
       OPEN t400_count
       #FUN-B50065-add-start--
       IF STATUS THEN
          CLOSE t400_cl
          CLOSE t400_count
          COMMIT WORK
          RETURN
       END IF
       #FUN-B50065-add-end-- 
       FETCH t400_count INTO g_row_count
       #FUN-B50065-add-start--
       IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
          CLOSE t400_cl
          CLOSE t400_count
          COMMIT WORK
          RETURN
       END IF
       #FUN-B50065-add-end--
       DISPLAY g_row_count TO FORMONLY.cnt
       OPEN t400_cs
       IF g_curs_index = g_row_count + 1 THEN
          LET g_jump = g_row_count
          CALL t400_fetch('L')
       ELSE
          LET g_jump = g_curs_index
          LET mi_no_ask = TRUE
          CALL t400_fetch('/')
       END IF
    END IF
    CLOSE t400_cl
    COMMIT WORK
    CALL cl_flow_notify(g_gxc.gxc01,'D')
END FUNCTION
 
FUNCTION t400_y()
    DEFINE l_cnt      LIKE type_file.num5    #No.FUN-680107 SMALLINT
    DEFINE l_d_npq07  LIKE npq_file.npq07    #No.FUN-4C0010
    DEFINE l_c_npq07  LIKE npq_file.npq07    #No.FUN-4C0010
    DEFINE ii         LIKE type_file.num5    #No.FUN-680107 SMALLINT
    DEFINE l_n        LIKE type_file.num5    #No.FUN-670060 #No.FUN-680107 SMALLINT
 
    IF s_shut(0) THEN RETURN END IF
    IF g_gxc.gxc13 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    IF cl_null(g_gxc.gxc01) THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01 = g_gxc.gxc01
    #-->已confirm
    IF g_gxc.gxc13 = 'Y' THEN CALL cl_err('','9023',0) RETURN END IF
    #FUN-B50090 add begin-------------------------
    #重新抓取關帳日期
    SELECT nmz10 INTO g_nmz.nmz10 FROM nmz_file WHERE nmz00='0'
    #FUN-B50090 add -end--------------------------
    #-->立帳日期不可小於關帳日期
    IF g_gxc.gxc04 <= g_nmz.nmz10 THEN #no.5261
       CALL cl_err(g_gxc.gxc01,'aap-176',1) RETURN
    END IF
    IF NOT cl_confirm('axr-108') THEN RETURN END IF
    #No.FUN-740028  --Begin                                                                                                        
    CALL s_get_bookno(YEAR(g_gxc.gxc03)) RETURNING g_flag,g_bookno1,g_bookno2                                                        
    IF g_flag =  '1' THEN  #抓不到帳別                                                                                               
    CALL cl_err(g_gxc.gxc03,'aoo-081',1)                                                                                          
    END IF  
    #No.FUN-740028  --End             
    LET g_success='Y'
    #No.FUN-670060 --start--  
    LET g_t1=''
    INITIALIZE g_nmy.* TO NULL 
    LET g_t1 = s_get_doc_no(g_gxc.gxc01)
    SELECT * INTO g_nmy.* FROM nmy_file WHERE nmyslip=g_t1
    IF g_nmy.nmyglcr = 'N' THEN
    #No.FUN-670060  --end--
    #CALL s_chknpq2(g_gxc.gxc01,'NM',9,0)   #MOD-680039
      CALL s_chknpq(g_gxc.gxc01,'NM',0,'0',g_bookno1)   #MOD-680039 #No.FUN-680088 add '0' #No.FUN-740028
      #No.FUN-680088 --start--
      IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
         CALL s_chknpq(g_gxc.gxc01,'NM',0,'1',g_bookno2)  #No.FUN-740028
      END IF
      #No.FUN-680088 --end--
    END IF  #No.FUN-670060
    IF g_success = 'N' THEN RETURN END IF
    BEGIN WORK
    OPEN t400_cl USING g_gxc.gxc01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_gxc.*#鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)#資料被他人LOCK
       CLOSE t400_cl ROLLBACK WORK RETURN
    END IF
 
    #No.FUN-670060 --begin-- 
    IF g_nmy.nmyglcr = 'Y' THEN 
       SELECT COUNT(*) INTO l_n FROM npq_file
        WHERE npqsys= 'NM'
          AND npq00=9 
          AND npq01 = g_gxc.gxc01 
          AND npq011=0 
       IF l_n = 0 THEN
          CALL t400_gen_glcr(g_gxc.*,g_nmy.*) 
       END IF 
       IF g_success = 'Y' THEN 
          #No.FUN-680088 --start--
#         CALL s_chknpq2(g_gxc.gxc01,'NM',9,0)
          CALL s_chknpq(g_gxc.gxc01,'NM',0,'0',g_bookno1)   #No.FUN-740028
          IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
             CALL s_chknpq(g_gxc.gxc01,'NM',0,'1',g_bookno2)  #No.FUN-740028
          END IF
          IF g_success ='N' THEN RETURN END IF  #No.FUN-680088
          #No.FUN-680088 --end--
       END IF
    END IF
    #No.FUN-670060 --end--
 
    UPDATE gxc_file SET gxc13 = 'Y' WHERE gxc01 = g_gxc.gxc01
    IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
#      CALL cl_err('upd gxc13',STATUS,1)    #No.FUN-660148
       CALL cl_err3("upd","gxc_file",g_gxc.gxc01,"",STATUS,"","upd gxc13",1)  #No.FUN-660148
       LET g_success='N'
    ELSE
       LET g_gxc.gxc13 = 'Y'
    END IF
    DISPLAY BY NAME g_gxc.gxc13
    IF g_success='Y' THEN
        COMMIT WORK
        CALL cl_flow_notify(g_gxc.gxc01,'Y')
    ELSE
        ROLLBACK WORK
    END IF
 
    #No.FUN-670060 --begin--
    IF g_nmy.nmyglcr = 'Y' AND g_success = 'Y' THEN
       LET g_wc_gl = 'npp01 = "',g_gxc.gxc01,'" AND npp011 = 0'
      #LET g_str="anmp100 '",g_wc_gl CLIPPED,"' '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",g_nmy.nmygslp,"' '",g_gxc.gxc03,"' 'Y' '0' 'Y' '",g_nmz.nmz02c,"' '",g_nmy.nmygslp1,"'"  #No.FUN-680088#FUN-860040
       LET g_str="anmp100 '",g_wc_gl CLIPPED,"' '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",g_nmy.nmygslp,"' '",g_gxc.gxc03,"' 'Y' '1' 'Y' '",g_nmz.nmz02c,"' '",g_nmy.nmygslp1,"'"  #No.FUN-680088#FUN-860040
       CALL cl_cmdrun_wait(g_str) 
       SELECT gxc14,gxc141 INTO g_gxc.gxc14,g_gxc.gxc141 FROM gxc_file                                                                 
        WHERE gxc01 = g_gxc.gxc01                                                                                                    
       DISPLAY BY NAME g_gxc.gxc14                                                                                                   
       DISPLAY BY NAME g_gxc.gxc141                                                                                                  
    END IF                                                                                                                           
    #No.FUN-670060 --end--
    CALL cl_set_field_pic(g_gxc.gxc13,"","","","N","")   #MOD-AC0073
 
END FUNCTION
 
FUNCTION t400_z()
   DEFINE l_aba19      LIKE aba_file.aba19     #No.FUN-670060
   DEFINE l_dbs        STRING                  #No.FUN-670060
   DEFINE l_sql        STRING                  #No.FUN-670060
 
    IF s_shut(0) THEN RETURN END IF
    SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01 = g_gxc.gxc01
    IF cl_null(g_gxc.gxc01) THEN CALL cl_err('',-400,0) RETURN END IF
    #-->未confirm
    IF g_gxc.gxc13 = 'N' THEN CALL cl_err('','9025',0) RETURN END IF
    IF g_gxc.gxc13 = 'X' THEN CALL cl_err('','9024',0) RETURN END IF
    #FUN-B50090 add begin-------------------------
    #重新抓取關帳日期
    SELECT nmz10 INTO g_nmz.nmz10 FROM nmz_file WHERE nmz00='0'
    #FUN-B50090 add -end--------------------------
    #-->立帳日期不可小於關帳日期
    IF g_gxc.gxc04 <= g_nmz.nmz10 THEN #no.5261
       CALL cl_err(g_gxc.gxc01,'aap-176',1) RETURN
    END IF
    #-->已拋轉總帳
 
#No.FUN-670060 --start-- mark
#   IF NOT cl_null(g_gxc.gxc14) THEN
#      CALL cl_err(g_gxc.gxc01,'axr-310',0) RETURN
#   END IF
#No.FUN-670060 --end-- 
 
    #-->已輸入anmt420 No:8138
    SELECT count(*) INTO g_cnt FROM gxe_file
     WHERE gxe01=g_gex.gxc01
    IF g_cnt > 0 THEN
       CALL cl_err(g_gxc.gxc01,'anm-501',0) RETURN
    END IF
    #--No:8138 end
 
    #No.FUN-670060 --begin--
    #取消確認時，若單據別設為"系統自動拋轉總帳",則可自動拋轉還原 
    CALL s_get_doc_no(g_gxc.gxc01) RETURNING g_t1
    SELECT * INTO g_nmy.* FROM nmy_file WHERE nmyslip=g_t1
    IF NOT cl_null(g_gxc.gxc14) OR NOT cl_null(g_gxc.gxc141) THEN
       IF g_nmy.nmyglcr = 'N' THEN
          CALL cl_err(g_gxc.gxc01,'axr-370',0) RETURN 
       END IF 
    END IF 
    IF g_nmy.nmyglcr = 'Y' THEN                                                                              
       #LET g_plant_new=g_nmz.nmz02p CALL s_getdbs() LET l_dbs=g_dbs_new  #FUN-A50102
       #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
       LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_nmz.nmz02p,'aba_file'), #FUN-A50102
                   "  WHERE aba00 = '",g_nmz.nmz02b,"'",
                   "    AND aba01 = '",g_gxc.gxc14,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_nmz.nmz02p) RETURNING l_sql #FUN-A50102
       PREPARE aba_pre FROM l_sql
       DECLARE aba_cs CURSOR FOR aba_pre
       OPEN aba_cs
       FETCH aba_cs INTO l_aba19
       IF l_aba19 = 'Y' THEN
          CALL cl_err(g_gxc.gxc14,'axr-071',1)
          RETURN                                                                                                                     
       END IF                                                                                                                        
    END IF                                                                                                                           
    #No.FUN-670060 --end--
 
    IF NOT cl_confirm('axr-109') THEN RETURN END IF
    LET g_success='Y'
  #-------------------------------CHI-C90051---------------------------(S)
    IF g_nmy.nmyglcr = 'Y' AND g_nmy.nmydmy3 = 'Y' THEN
       LET g_str="anmp110 '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",g_gxc.gxc14,"' 'Y'"
       CALL cl_cmdrun_wait(g_str)
       SELECT gxc14,gxc141 INTO g_gxc.gxc14,g_gxc.gxc141 FROM gxc_file
        WHERE gxc01 = g_gxc.gxc01
       DISPLAY BY NAME g_gxc.gxc14
       DISPLAY BY NAME g_gxc.gxc141
       IF NOT cl_null(g_gxc.gxc14) THEN
          CALL cl_err('','aap-929',0)
          RETURN
       END IF
    END IF
  #-------------------------------CHI-C90051---------------------------(E)
    BEGIN WORK
    OPEN t400_cl USING g_gxc.gxc01
    IF STATUS THEN
       CALL cl_err("OPEN t400_cl:", STATUS, 1)
       CLOSE t400_cl
       ROLLBACK WORK
       RETURN
    END IF
    FETCH t400_cl INTO g_gxc.*#鎖住將被更改或取消的資料
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)#資料被他人LOCK
       CLOSE t400_cl ROLLBACK WORK RETURN
    END IF
    UPDATE gxc_file SET gxc13 = 'N' WHERE gxc01 = g_gxc.gxc01
    IF STATUS OR SQLCA.SQLERRD[3] = 0 THEN
#      CALL cl_err('upd gxc13',STATUS,1)   #No.FUN-660148
       CALL cl_err3("upd","gxc_file",g_gxc.gxc01,"",STATUS,"","upd gxc13",1)  #No.FUN-660148
       LET g_success='N' 
    ELSE
       LET g_gxc.gxc13 = 'N'
    END IF
    DISPLAY BY NAME g_gxc.gxc13
    IF g_success='Y' THEN COMMIT WORK ELSE ROLLBACK WORK END IF
 
   #-------------------------------CHI-C90051---------------------------mark
   ##No.FUN-670060 --begin--  
   #IF g_nmy.nmyglcr = 'Y' AND g_success = 'Y' THEN 
   #   LET g_str="anmp110 '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",g_gxc.gxc14,"' 'Y'"
   #   CALL cl_cmdrun_wait(g_str) 
   #   SELECT gxc14,gxc141 INTO g_gxc.gxc14,g_gxc.gxc141 FROM gxc_file 
   #    WHERE gxc01 = g_gxc.gxc01
   #   DISPLAY BY NAME g_gxc.gxc14
   #   DISPLAY BY NAME g_gxc.gxc141
   #END IF 
   ##No.FUN-670060 --end--
   #-------------------------------CHI-C90051---------------------------mark
 
END FUNCTION
 
FUNCTION t400_v(p_npptype)  #No.FUN-680088 add p_npptype
    DEFINE l_npp   RECORD LIKE npp_file.*,
           l_npq   RECORD LIKE npq_file.*,
           l_gxd   RECORD LIKE gxd_file.*,
           l_n     LIKE type_file.num5,    #No.FUN-680107 SMALLINT
           l_damt  LIKE type_file.num20_6, #No.FUN-680107 dec(20,6) # Thomas 98/08/31 折溢價直接加減
           l_damtf LIKE type_file.num20_6, #No.FUN-680107 dec(20,6)
           l_camt  LIKE type_file.num20_6, #No.FUN-680107 dec(20,6)
           l_camtf LIKE type_file.num20_6, #No.FUN-680107 dec(20,6)
           l_alg02 LIKE alg_file.alg02,
           l_buf   LIKE type_file.chr1000, #No.FUN-680107 VARCHAR(80)
           l_nmydmy3 LIKE nmy_file.nmydmy3,#MOD-680039
           l_t     LIKE nmy_file.nmyslip   #No.FUN-680107 VARCHAR(5) #MOD-680039
    DEFINE p_npptype LIKE npp_file.npptype #No.FUN-680088
    DEFINE l_aaa03 LIKE aaa_file.aaa03     #FUN-A40067
    DEFINE l_flag  LIKE type_file.chr1     #FUN-D40118 add
 
    LET g_success = 'Y'   #No.FUN-680088
    #-----MOD-680039---------
    LET l_t = g_gxc.gxc01[1,g_doc_len]
    SELECT nmydmy3 INTO l_nmydmy3 FROM nmy_file WHERE nmyslip = l_t
    IF l_nmydmy3 = 'N' THEN
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    #-----END MOD-680039-----
 
    IF g_gxc.gxc13 = 'X' THEN CALL cl_err('','9024',0)
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    IF g_gxc.gxc13 = 'Y' THEN
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF  #已confirm
    IF NOT cl_null(g_gxc.gxc14) THEN  #已拋轉總帳
       CALL cl_err(g_gxc.gxc01,'aap-122',0)
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    MESSAGE ''
    IF s_shut(0) THEN
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    LET l_damt = 0 LET l_camt = 0
    LET l_damtf = 0 LET l_camtf = 0
    SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01 = g_gxc.gxc01
    IF cl_null(g_gxc.gxc01) THEN CALL cl_err('',-400,0)
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    IF g_gxc.gxc13 = 'Y' THEN CALL cl_err('','9023',0)
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF  #已confirm
    LET g_trno = g_gxc.gxc01
    SELECT COUNT(*) INTO l_n FROM npp_file    #已拋轉總帳
     WHERE nppsys= 'NM' AND npp00=9 AND npp01 = g_trno AND npp011=0
       AND nppglno != ' ' AND nppglno IS NOT NULL
       AND npptype = p_npptype  #No.FUN-680088
    IF l_n > 0 THEN CALL cl_err(g_trno,'aap-122',1)
       LET g_success = 'N'  #No.FUN-680088
       RETURN
    END IF
    SELECT COUNT(*) INTO l_n FROM npq_file
           WHERE npqsys='NM' AND npq00=9 AND npq01=g_trno AND npq011=0
             AND npqtype = p_npptype  #No.FUN-680088
    #-----MOD-680039---------
    IF l_n > 0 THEN
       IF NOT s_ask_entry(g_trno) THEN
          RETURN
          LET g_success = 'N'  #No.FUN-680088
       END IF
    END IF
    #No.FUN-740028 --begin                                                                                                         
   CALL s_get_bookno(YEAR(g_gxc.gxc03)) RETURNING g_flag,g_bookno1,g_bookno2                                                        
   IF g_flag = '1' THEN                                                                                                             
      CALL cl_err(YEAR(g_gxc.gxc03),'aoo-081',1)                                                                                    
      LET g_success = 'N'                                                                                                           
   END IF                                                                                                                           
   IF l_npq.npqtype = '0' THEN                                                                                                      
      LET g_bookno3 = g_bookno1                                                                                                     
   ELSE                                                                                                                             
      LET g_bookno3 = g_bookno2                                                                                                     
   END IF                                                                                                                           
   #No.FUN-740028 --end  
    
    SELECT COUNT(*) INTO l_n FROM npp_file
           WHERE nppsys='NM' AND npp00=9 AND npp01=g_trno AND npp011=0
             AND npptype = p_npptype  #No.FUN-680088
    #-----END MOD-680039-----
    IF l_n > 0 THEN
      #--No.MOD-4A0245----------#
     #  CALL cl_getmsg('anm-500',g_lang) RETURNING g_msg
     #  LET l_buf = '(',g_trno CLIPPED,')',g_msg CLIPPED
     #  WHILE TRUE
     #       LET INT_FLAG = 0  ######add for prompt bug
#        PROMPT l_buf CLIPPED,' ' FOR CHAR g_chr
         # Modify By Raymon
     #    CALL cl_choice(l_buf) RETURNING g_chr
     #    IF g_chr MATCHES "[12]" THEN EXIT WHILE END IF
     # END WHILE
     # IF g_chr = '1' THEN RETURN END IF
     #  IF NOT s_ask_entry(g_trno) THEN RETURN END IF   #MOD-680039
     #------END-----------------#
      DELETE FROM npp_file
       WHERE nppsys= 'NM' AND npp00=9 AND npp01 = g_trno AND npp011=0
         AND npptype = p_npptype  #No.FUN-680088
      #No.FUN-680088 --start--
      IF STATUS THEN
         CALL cl_err3("del","npp_file",'','',STATUS,'','',1)
         LET g_success = 'N'
      END IF
      #No.FUN-680088 --end--
      DELETE FROM npq_file
       WHERE npqsys= 'NM' AND npq00=9 AND npq01 = g_trno AND npq011=0
         AND npqtype = p_npptype  #No.FUN-680088
      #No.FUN-680088 --start--
      IF STATUS THEN
         CALL cl_err3("del","npq_file",'','',STATUS,'','',1)
         LET g_success = 'N'
      END IF
      #No.FUN-680088 --end--

      #FUN-B40056--add--str--
      DELETE FROM tic_file WHERE tic04 = g_trno
      IF STATUS THEN
         CALL cl_err3("del","tic_file",'','',STATUS,'','',1)
         LET g_success = 'N'
      END IF
      #FUN-B40056--add--end--

    END IF
 
    SELECT * INTO l_gxd.* FROM gxd_file WHERE gxd00 = '0'
    INITIALIZE l_npp.* TO NULL
    LET l_npp.nppsys= 'NM'
    LET l_npp.npp00 = 9
    LET l_npp.npp01 = g_gxc.gxc01
    LET l_npp.npp011= 0
    LET l_npp.npp02 = g_gxc.gxc03
    LET l_npp.npp03 = NULL
    LET l_npp.npptype = p_npptype  #No.FUN-680088
    #FUN-980005 add legal 
    LET l_npp.npplegal = g_legal 
    #FUN-980005 end legal 
    INSERT INTO npp_file VALUES(l_npp.*)
    IF STATUS THEN 
#      CALL cl_err('ins npp',STATUS,1)  #No.FUN-660148
       CALL cl_err3("ins","npp_file",l_npp.npp00,l_npp.npp01,STATUS,"","ins npp",1)  #No.FUN-660148
       LET g_success = 'N'  #No.FUN-680088
    END IF
 
    INITIALIZE l_npq.* TO NULL
    LET l_npq.npqsys= 'NM'
    LET l_npq.npq00 = 9
    LET l_npq.npq01 = g_gxc.gxc01
    LET l_npq.npq011= 0
    LET l_npq.npq02 = 0
    LET l_npq.npqtype = p_npptype  #No.FUN-680088
#----------------預購遠匯----------------------------------------------
    IF g_gxc.gxc02 = '1' THEN                       #預購遠匯
       LET l_npq.npq02 = l_npq.npq02 + 1
       IF p_npptype = '0' THEN  #No.FUN-680088
          LET l_npq.npq03 = l_gxd.gxd01
       #No.FUN-680088 --start--
       ELSE
          LET l_npq.npq03 = l_gxd.gxd011
       END IF
       #No.FUN-680088 --end--
       LET l_npq.npq06 = '1'   #借方
#-----TQC-620082---------
       #-----TQC-6C0090---------
       #LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10  #本幣
       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10 * g_gxc.gxc11 #本幣
       #-----END TQC-6C0090
       LET l_npq.npq24 = g_gxc.gxc05
       IF g_gxc.gxc05 = g_aza.aza17 THEN
          LET l_npq.npq07f = l_npq.npq07
          LET l_npq.npq25 = 1
       ELSE
          LET l_npq.npq07f = g_gxc.gxc08
          #-----TQC-6C0090---------
          #LET l_npq.npq07f = l_npq.npq07f USING '############'
          #LET l_npq.npq25 = g_gxc.gxc09
          LET l_npq.npq25 = g_gxc.gxc10 * g_gxc.gxc11
          #-----END TQC-6C0090-----
       END IF
       LET g_npq25 = l_npq.npq25             #No.FUN-9A0036
 
#       # 借方金額:承作金額*交割匯率
#       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10  #本幣
#       LET l_npq.npq07 = l_npq.npq07 USING '############'
#       LET l_npq.npq07f= l_npq.npq07
#       LET l_npq.npq24 = g_aza.aza17                #原幣幣別
#       LET l_npq.npq25 = 1                          #匯率
#-----END TQC-620082-----
       IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
       IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
       #-----TQC-6C0090---------
       #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
       SELECT azi04 INTO t_azi04 FROM azi_file
        WHERE azi01 = l_npq.npq24
       LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
       LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
       #-----END TQC-6C0090-----
       #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
       LET l_npq.npq04 = NULL #FUN-D10065 add
       LET l_damt = l_npq.npq07
       LET l_damtf = l_npq.npq07f
       IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
       # NO.FUN-5C0015 --start--
       CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   #No.FUN-740028
          RETURNING  l_npq.*
       #FUN-D10065--add--str--
       IF cl_null(l_npq.npq04) THEN
          LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
       END IF
       #FUN-D10065--add--end
       CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
       # NO.FUN-5C0015 ---end---
 
       #FUN-980005 add legal 
       LET l_npq.npqlegal = g_legal 
       #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
       #FUN-D40118--add--str--
       SELECT aag44 INTO g_aag44 FROM aag_file
        WHERE aag00 = g_bookno3
          AND aag01 = l_npq.npq03
       IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
          CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
          IF l_flag = 'N'   THEN
             LET l_npq.npq03 = ''
          END IF
       END IF
       #FUN-D40118--add--end--
       INSERT INTO npq_file VALUES(l_npq.*)
       IF STATUS THEN 
#         CALL cl_err('ins npq #11',STATUS,1)  #No.FUN-660148
          CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #11",1)  #No.FUN-660148
          LET g_success = 'N'  #No.FUN-680088
       END IF
#-------------------------貸方----------------------------------------------
       LET l_npq.npq02 = l_npq.npq02 + 1
       IF p_npptype = '0' THEN  #No.FUN-680088
          LET l_npq.npq03 = l_gxd.gxd02        #科目:應付購入遠匯
       #No.FUN-680088 --start--
       ELSE
          LET l_npq.npq03 = l_gxd.gxd021
       END IF
       #No.FUN-680088 --end--
       #LET l_npq.npq04 = g_gxc.gxc05 CLIPPED,   #TQC-6C0090
       #-----MOD-770018--------- 
       #LET l_npq.npq04 = g_gxc.gxc06 CLIPPED,   #TQC-6C0090
       #                  g_gxc.gxc08 USING '<<,<<<,<<<','*',
       #                  g_gxc.gxc09*g_gxc.gxc11 USING '<<<<<.<<<<'
       #-----END MOD-770018----- 
       LET l_npq.npq06 = '2'   #貸方
#-----TQC-620082---------
       #-----TQC-6C0090---------
       #LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10
       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc09 * g_gxc.gxc11
       #LET l_npq.npq07 = l_npq.npq07 USING '############'
       #-----END TQC-6C0090-----
       LET l_npq.npq24 = g_gxc.gxc06
       IF g_gxc.gxc06 = g_aza.aza17 THEN
          LET l_npq.npq07f = l_npq.npq07
          LET l_npq.npq25 = 1
       ELSE
          LET l_npq.npq07f = g_gxc.gxc08
          #-----TQC-6C0090---------
          #LET l_npq.npq07f = l_npq.npq07f USING '############'
          #LET l_npq.npq25 = g_gxc.gxc10
          LET l_npq.npq25 = g_gxc.gxc09 * g_gxc.gxc11
          #-----END TQC-6C0090-----
       END IF
       LET g_npq25 = l_npq.npq25           #No.FUN-9A0036
 
#                  金額:承作金額＊即期匯率
#       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc09
#       LET l_npq.npq07 = l_npq.npq07 USING '############'
#       LET l_npq.npq07f= l_npq.npq07
#-----END TQC-620082-----
       IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
       IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
       #-----TQC-6C0090---------
       #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
       SELECT azi04 INTO t_azi04 FROM azi_file
        WHERE azi01 = l_npq.npq24
       LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
       LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
       #-----END TQC-6C0090-----
       #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018#FUN-D10065 mark
       LET l_npq.npq04=NULL  #FUN-D10065
       LET l_camt = l_npq.npq07
       LET l_camtf = l_npq.npq07f
       IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
       # NO.FUN-5C0015 --start--
       CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   #No.FUN-740028
        RETURNING  l_npq.*
       #FUN-D10065--add--str--
       IF cl_null(l_npq.npq04) THEN
          LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
       END IF
       #FUN-D10065--add--end
         
       CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
       # NO.FUN-5C0015 ---end---
 
       #FUN-980005 add legal 
       LET l_npq.npqlegal = g_legal 
       #FUN-980005 end legal 
 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
       #FUN-D40118--add--str--
       SELECT aag44 INTO g_aag44 FROM aag_file
        WHERE aag00 = g_bookno3
          AND aag01 = l_npq.npq03
       IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
          CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
          IF l_flag = 'N'   THEN
             LET l_npq.npq03 = ''
          END IF
       END IF
       #FUN-D40118--add--end--
       INSERT INTO npq_file VALUES(l_npq.*)
       IF STATUS THEN 
#         CALL cl_err('ins npq #12',STATUS,1) #No.FUN-660148
          CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #12",1)  #No.FUN-660148
          LET g_success = 'N'  #No.FUN-680088
       END IF
 
#------購入溢/折價--------------------------------------------------------
#IF 交割匯率 > 即期匯率
#   貸方:購入遠匯溢價=承作金額＊(交割匯率-即期匯率)
#ELSE
#  借方:購入遠匯折價=承作金額＊(即期匯率-交割匯率)
 
       IF g_gxc.gxc10 > g_gxc.gxc09 THEN     #TQC-620082   #TQC-6C0090  取消mark
       #IF g_gxc.gxc10 < g_gxc.gxc09 THEN     #TQC-620082   #TQC-6C0090 mark
          LET l_npq.npq02 = l_npq.npq02 + 1
  #----------------------------------------------------------------------
          #  貸方:購入遠匯溢價=承作金額＊(交割匯率-即期匯率)
 
          IF p_npptype = '0' THEN  #No.FUN-680088
             LET l_npq.npq03 = l_gxd.gxd03
          #No.FUN-680088 --start--
          ELSE
             LET l_npq.npq03 = l_gxd.gxd031
          END IF
          #No.FUN-680088 --end--
          #LET l_npq.npq04 = g_gxc.gxc05 CLIPPED,   #TQC-6C0090
#-----MOD-770018---------
{
          LET l_npq.npq04 = g_aza.aza17 CLIPPED,   #TQC-6C0090
                            g_gxc.gxc08 USING '<<,<<<,<<<','*(',
#-----TQC-6C0090---------
#-----TQC-620082---------
#                            (g_gxc.gxc09) USING '<<<<<.<<<<','-',
#                           (g_gxc.gxc10) USING '<<<<<.<<<<',')'
                            (g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            (g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<',')'
#-----END TQC-620082-----
#-----END TQC-6C0090-----
}
#-----END MOD-770018-----
          LET l_npq.npq06 = '2'   #貸方
          LET l_npq.npq24 = g_aza.aza17 #TQC-620082
          LET l_npq.npq25 = 1 #TQC-620082
          LET g_npq25 = l_npq.npq25           #No.FUN-9A0036
  #      金額=承作金額＊(交割匯率-即期匯率)
 
          #-----TQC-6C0090---------
          #LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc10-g_gxc.gxc09)
          LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc10-g_gxc.gxc09)*g_gxc.gxc11
          #LET l_npq.npq07 = l_npq.npq07 USING '############'
          #LET l_npq.npq07 = l_damt - l_camt # Thomas 98/08/31
          #-----END TQC-6C0090-----
          LET l_npq.npq07f= l_npq.npq07
          IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
          IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
          #-----TQC-6C0090---------
          #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
          SELECT azi04 INTO t_azi04 FROM azi_file
           WHERE azi01 = l_npq.npq24
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
          LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
          #-----END TQC-6C0090-----
          #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018#FUN-D10065 mark
          LET l_npq.npq04 = NULL  #FUN-D10065
          IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
          # NO.FUN-5C0015 --start--
          CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3) #No.FUN-740028
           RETURNING  l_npq.*

          #FUN-D10065--add--str--
          IF cl_null(l_npq.npq04) THEN
             LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
          END IF
          #FUN-D10065--add--end
           
          CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
  
          # NO.FUN-5C0015 ---end---
 
          #FUN-980005 add legal 
          LET l_npq.npqlegal = g_legal 
          #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
          #FUN-D40118--add--str--
          SELECT aag44 INTO g_aag44 FROM aag_file
           WHERE aag00 = g_bookno3
             AND aag01 = l_npq.npq03
          IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
             CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
             IF l_flag = 'N'   THEN
                LET l_npq.npq03 = ''
             END IF
          END IF
          #FUN-D40118--add--end--
          INSERT INTO npq_file VALUES(l_npq.*)
          IF STATUS THEN 
#            CALL cl_err('ins npq #13',STATUS,1) #No.FUN-660148
             CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #13",1)  #No.FUN-660148
             LET g_success = 'N'  #No.FUN-680088
          END IF
       END IF
       IF g_gxc.gxc10 < g_gxc.gxc09 THEN     #TQC-620082   #TQC-6C0090 取消mark
       #IF g_gxc.gxc10 > g_gxc.gxc09 THEN     #TQC-620082   #TQC-6C0090 mark
          LET l_npq.npq02 = l_npq.npq02 + 1
  #----------------------------------------------------------------------
          #  借方:購入遠匯折價=承作金額＊(即期匯率-交割匯率)
 
          IF p_npptype = '0' THEN  #No.FUN-680088
             LET l_npq.npq03 = l_gxd.gxd04
          #No.FUN-680088 --start--
          ELSE
             LET l_npq.npq03 = l_gxd.gxd041
          #No.FUN-680088 --start--
          END IF
          #No.FUN-680088 --end--
          #LET l_npq.npq04 = g_gxc.gxc05 CLIPPED,   #TQC-6C0090
#-----MOD-770018---------
{
          LET l_npq.npq04 = g_aza.aza17 CLIPPED,   #TQC-6C0090
                            g_gxc.gxc08 USING '<<,<<<,<<<','*(',
#-----TQC-6C0090---------
#-----TQC-620082---------
#                            (g_gxc.gxc10) USING '<<<<<.<<<<','-',
#                            (g_gxc.gxc09) USING '<<<<<.<<<<',')'
                            (g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            (g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<',')'
#-----END TQC-620082-----
#-----END TQC-6C0090-----
}
#-----END MOD-770018-----
          LET l_npq.npq06 = '1'
          LET l_npq.npq24 = g_aza.aza17 #TQC-620082
          LET l_npq.npq25 = 1   #TQC-620082
          LET g_npq25 = l_npq.npq25           #No.FUN-9A0036
  #      金額=承作金額＊(即期匯率-交割匯率)
 
          #-----TQC-6C0090---------
          #LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc09-g_gxc.gxc10)
          LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc09-g_gxc.gxc10)*g_gxc.gxc11
          #LET l_npq.npq07 = l_npq.npq07 USING '############'
          #LET l_npq.npq07 = l_camt - l_damt # Thomas 98/08/31
          #-----END TQC-6C0090-----
          LET l_npq.npq07f= l_npq.npq07
          IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
          IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
          #-----TQC-6C0090---------
          #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
          SELECT azi04 INTO t_azi04 FROM azi_file
           WHERE azi01 = l_npq.npq24
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
          LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
          #-----END TQC-6C0090-----
          #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
          LET l_npq.npq04 = NULL   #FUN-D10065
          IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
          # NO.FUN-5C0015 --start--
          CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)    #No.FUN-740028
           RETURNING  l_npq.*
           

          #FUN-D10065--add--str--
          IF cl_null(l_npq.npq04) THEN
             LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
          END IF
          #FUN-D10065--add--end
          CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
          # NO.FUN-5C0015 ---end---
 
          #FUN-980005 add legal 
          LET l_npq.npqlegal = g_legal 
          #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
          #FUN-D40118--add--str--
          SELECT aag44 INTO g_aag44 FROM aag_file
           WHERE aag00 = g_bookno3
             AND aag01 = l_npq.npq03
          IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
             CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
             IF l_flag = 'N'   THEN
                LET l_npq.npq03 = ''
             END IF
          END IF
          #FUN-D40118--add--end--
          INSERT INTO npq_file VALUES(l_npq.*)
          IF STATUS THEN 
#            CALL cl_err('ins npq #13',STATUS,1) #No.FUN-660148
             CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #13",1)  #No.FUN-660148
             LET g_success = 'N'  #No.FUN-680088
          END IF
       END IF
    ELSE
#----------------預售遠匯----------------------------------------------
       #------------------------借方--------------------------
       #應收出售遠匯款:承作金額＊交割匯率＊換匯標準
       LET l_npq.npq02 = l_npq.npq02 + 1
       IF p_npptype = '0' THEN  #No.FUN-680088
          LET l_npq.npq03 = l_gxd.gxd05
       #No.FUN-680088 --start--
       ELSE
          LET l_npq.npq03 = l_gxd.gxd051
       END IF
       #No.FUN-680088 --end--
       #-----MOD-770018---------
       {
       LET l_npq.npq04 = g_gxc.gxc06 CLIPPED,
                         g_gxc.gxc08 USING '<<,<<<,<<<','*',
                         #-----TQC-6C0090---------
                         #g_gxc.gxc10*g_gxc.gxc11 USING '<<<<<.<<<<'
                         g_gxc.gxc09*g_gxc.gxc11 USING '<<<<<.<<<<'
                         #-----END TQC-6C0090-----
       }
       #-----END MOD-770018-----
       LET l_npq.npq06 = '1'   #借方
       # 借方金額:承作金額*交割匯率＊換匯標準
       #-----TQC-6C0090---------
       #LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10 * g_gxc.gxc11
       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc09 * g_gxc.gxc11
       #LET l_npq.npq07 = l_npq.npq07 USING '############'
       #-----END TQC-6C0090-----
#-----TQC-620082---------
       #LET l_npq.npq24 = g_gxc.gxc06   #MOD-760075
       LET l_npq.npq24 = g_gxc.gxc05   #MOD-760075
       #IF g_gxc.gxc06 = g_aza.aza17 THEN   #MOD-760142
       IF g_gxc.gxc05 = g_aza.aza17 THEN   #MOD-760142
          LET l_npq.npq07f = l_npq.npq07
          LET l_npq.npq25 = 1
       ELSE
          LET l_npq.npq07f = g_gxc.gxc08
          #-----TQC-6C0090---------
          #LET l_npq.npq07f = l_npq.npq07f USING '############'
          #LET l_npq.npq25 = g_gxc.gxc10
          LET l_npq.npq25 = g_gxc.gxc09 * g_gxc.gxc11
          #-----END TQC-6C0090-----
       END IF
          LET g_npq25 = l_npq.npq25           #No.FUN-9A0036
 
#       LET l_npq.npq07f= l_npq.npq07
#       LET l_npq.npq24 = g_aza.aza17
#       LET l_npq.npq25 = 1
#-----END TQC-620082-----
       IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
       IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
       #-----TQC-6C0090---------
       #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
       SELECT azi04 INTO t_azi04 FROM azi_file
        WHERE azi01 = l_npq.npq24
       LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
       LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
       #-----END TQC-6C0090-----
       #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
       LET l_npq.npq04 = NULL #FUN-D10065
       LET l_damt = l_npq.npq07
       LET l_damtf = l_npq.npq07f
       IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
       # NO.FUN-5C0015 --start--
       CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   #No.FUN-740028
        RETURNING  l_npq.*
        
       #FUN-D10065--add--str--
       IF cl_null(l_npq.npq04) THEN
          LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
       END IF
       #FUN-D10065--add--end
       CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
       # NO.FUN-5C0015 ---end---
       #FUN-980005 add legal 
       LET l_npq.npqlegal = g_legal 
       #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
       #FUN-D40118--add--str--
       SELECT aag44 INTO g_aag44 FROM aag_file
        WHERE aag00 = g_bookno3
          AND aag01 = l_npq.npq03
       IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
          CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
          IF l_flag = 'N'   THEN
             LET l_npq.npq03 = ''
          END IF
       END IF
       #FUN-D40118--add--end--
       INSERT INTO npq_file VALUES(l_npq.*)
       IF STATUS THEN 
#         CALL cl_err('ins npq #11',STATUS,1) #No.FUN-660148
          CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #11",1)  #No.FUN-660148
          LET g_success = 'N'  #No.FUN-680088
       END IF
 
       #--------------------貸方---------------------------------------
       #   科目:應付遠匯款-->承作金額＊即期匯率＊換匯標準
       LET l_npq.npq02 = l_npq.npq02 + 1
       IF p_npptype = '0' THEN  #No.FUN-680088
          LET l_npq.npq03 = l_gxd.gxd06
       #No.FUN-680088 --start--
       ELSE
          LET l_npq.npq03 = l_gxd.gxd061
       END IF
       #No.FUN-680088 --end--
       #LET l_npq.npq04 = g_gxc.gxc06 CLIPPED,   #TQC-6C0090
       #-----MOD-770018---------
       {
       LET l_npq.npq04 = g_gxc.gxc05 CLIPPED,   #TQC-6C0090
                         g_gxc.gxc08 USING '<<,<<<,<<<','*',
                         #g_gxc.gxc09*g_gxc.gxc11 USING '<<<<<.<<<<'   #TQC-6C0090
                         g_gxc.gxc10*g_gxc.gxc11 USING '<<<<<.<<<<'   #TQC-6C0090
       }
       #-----END MOD-770018-----
       LET l_npq.npq06 = '2'
       # 金額=承作金額＊即期匯率＊換匯標準
 
       #-----TQC-6C0090---------
       #LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc09 * g_gxc.gxc11
       LET l_npq.npq07 = g_gxc.gxc08 * g_gxc.gxc10 * g_gxc.gxc11
       #LET l_npq.npq07 = l_npq.npq07 USING '############'
       #LET l_npq.npq07f= l_npq.npq07
       #-----END TQC-6C0090-----
#-----TQC-620082---------
       #LET l_npq.npq24 = g_gxc.gxc05       #MOD-760075
       LET l_npq.npq24 = g_gxc.gxc06        #MOD-760075
       #IF g_gxc.gxc05 = g_aza.aza17 THEN   #MOD-760142
       IF g_gxc.gxc06 = g_aza.aza17 THEN   #MOD-760142
          LET l_npq.npq07f= l_npq.npq07   #原幣=本幣
          LET l_npq.npq25 = 1
       ELSE
          #-----TQC-6C0090---------
          LET l_npq.npq07f= g_gxc.gxc08   #原幣=承作金額
          #LET l_npq.npq07 = g_gxc.gxc08   #原幣=承作金額
          #LET l_npq.npq07 = l_npq.npq07 USING '############'
          #LET l_npq.npq25 = g_gxc.gxc09
          LET l_npq.npq25 = g_gxc.gxc10*g_gxc.gxc11
          #-----END TQC-6C0090-----
       END IF
#-----END TQC-620082-----
       LET g_npq25 = l_npq.npq25             #No.FUN-9A0036
       IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
       IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
       #-----TQC-6C0090---------
       #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
       SELECT azi04 INTO t_azi04 FROM azi_file
        WHERE azi01 = l_npq.npq24
       LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
       LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
       #-----END TQC-6C0090-----
       #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
       LET l_npq.npq04 = NULL #FUN-D10065
       LET l_camt = l_npq.npq07
       LET l_camtf = l_npq.npq07f
       IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
       # NO.FUN-5C0015 --start--
       CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   #No.FUN-740028
        RETURNING  l_npq.*
       #FUN-D10065--add--str--
       IF cl_null(l_npq.npq04) THEN
          LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
       END IF
       #FUN-D10065--add--end

         
       CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
       # NO.FUN-5C0015 ---end---
       #FUN-980005 add legal 
       LET l_npq.npqlegal = g_legal 
       #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
       #FUN-D40118--add--str--
       SELECT aag44 INTO g_aag44 FROM aag_file
        WHERE aag00 = g_bookno3
          AND aag01 = l_npq.npq03
       IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
          CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
          IF l_flag = 'N'   THEN
             LET l_npq.npq03 = ''
          END IF
       END IF
       #FUN-D40118--add--end--
       INSERT INTO npq_file VALUES(l_npq.*)
       IF STATUS THEN 
#         CALL cl_err('ins npq #12',STATUS,1) #No.FUN-660148
          CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #12",1)  #No.FUN-660148
          LET g_success = 'N'  #No.FUN-680088
       END IF
#------出售溢/折價--------------------------------------------------------
#IF 交割匯率 > 即期匯率
#   貸方:出售遠匯溢價=承作金額＊(交割匯率-即期匯率)
#ELSE
#  借方:出售遠匯折價=承作金額＊(即期匯率-交割匯率)
 
       #IF g_gxc.gxc10 > g_gxc.gxc09 THEN    #交割匯率 > 即期匯率   #TQC-6C0090
       IF g_gxc.gxc10 < g_gxc.gxc09 THEN    #交割匯率 > 即期匯率   #TQC-6C0090
       #--------------------貸方------------------------------------------
          LET l_npq.npq02 = l_npq.npq02 + 1
          #貸方:出售遠匯溢價=承作金額＊(交割匯率-即期匯率)＊換匯標準
          IF p_npptype = '0' THEN  #No.FUN-680088
             LET l_npq.npq03 = l_gxd.gxd07
          #No.FUN-680088 --start--
          ELSE
             LET l_npq.npq03 = l_gxd.gxd071
          END IF
          #No.FUN-680088 --end--
          #LET l_npq.npq04 = g_gxc.gxc06 CLIPPED,   #TQC-6C0090
          #-----MOD-770018---------
          {
          LET l_npq.npq04 = g_aza.aza17 CLIPPED,   #TQC-6C0090
                            g_gxc.gxc08 USING '<<,<<<,<<<','*(',
                            #-----TQC-6C0090---------
                            #(g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            #(g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<',')'
                            (g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            (g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<',')'
                            #-----END TQC-6C0090-----
          }
          #-----END MOD-770018-----
          LET l_npq.npq06 = '2'
#-----TQC-620082---------
          LET l_npq.npq24 = g_aza.aza17
          LET l_npq.npq25 = 1
#-----END TQC-620082-----
          LET g_npq25 = l_npq.npq25             #No.FUN-9A0036
 
          #-----TQC-6C0090---------
          #LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc10-g_gxc.gxc09)*g_gxc.gxc11
          LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc09-g_gxc.gxc10)*g_gxc.gxc11
          #LET l_npq.npq07 = l_npq.npq07 USING '############'
          #LET l_npq.npq07 = l_damt - l_camt # Thomas 98/08/31
          #-----END TQC-6C0090-----
          LET l_npq.npq07f= l_npq.npq07
          IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
          IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
          #-----TQC-6C0090---------
          #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
          SELECT azi04 INTO t_azi04 FROM azi_file
           WHERE azi01 = l_npq.npq24
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
          LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
          #-----END TQC-6C0090-----
          #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
          LET l_npq.npq04 = NULL #FUN-D10065
          IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
          # NO.FUN-5C0015 --start--
          CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   # No.FUN-740028
           RETURNING  l_npq.*
          
          #FUN-D10065--add--str--
          IF cl_null(l_npq.npq04) THEN
             LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
          END IF
          #FUN-D10065--add--end
          CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
          # NO.FUN-5C0015 ---end---
          #FUN-980005 add legal 
          LET l_npq.npqlegal = g_legal 
          #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
          #FUN-D40118--add--str--
          SELECT aag44 INTO g_aag44 FROM aag_file
           WHERE aag00 = g_bookno3
             AND aag01 = l_npq.npq03
          IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
             CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
             IF l_flag = 'N'   THEN
                LET l_npq.npq03 = ''
             END IF
          END IF
          #FUN-D40118--add--end--
          INSERT INTO npq_file VALUES(l_npq.*)
          IF STATUS THEN 
#            CALL cl_err('ins npq #13',STATUS,1) #No.FUN-660148
             CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #13",1)  #No.FUN-660148
             LET g_success = 'N'  #No.FUN-680088
          END IF
      END IF
      #IF g_gxc.gxc10 < g_gxc.gxc09 THEN    #交割匯率 > 即期匯率   #TQC-6C0090
      IF g_gxc.gxc10 > g_gxc.gxc09 THEN    #交割匯率 > 即期匯率   #TQC-6C0090
      #--------------------借方------------------------------------------
          #借方:出售遠匯折價=承作金額＊(即期匯率-交割匯率)＊換匯標準
          LET l_npq.npq02 = l_npq.npq02 + 1
          IF p_npptype = '0' THEN  #No.FUN-680088
             LET l_npq.npq03 = l_gxd.gxd08
          #No.FUN-680088 --start--
          ELSE
             LET l_npq.npq03 = l_gxd.gxd081
          END IF
          #No.FUN-680088 --end--
          #LET l_npq.npq04 = g_gxc.gxc06 CLIPPED,   #TQC-6C0090
          #-----MOD-770018---------
          {
          LET l_npq.npq04 = g_aza.aza17 CLIPPED,   #TQC-6C0090
                            g_gxc.gxc08 USING '<<,<<<,<<<','*(',
                            #-----TQC-6C0090---------
                            #(g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            #(g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<',')'
                            (g_gxc.gxc10*g_gxc.gxc11) USING '<<<<<.<<<<','-',
                            (g_gxc.gxc09*g_gxc.gxc11) USING '<<<<<.<<<<',')'
                            #-----END TQC-6C0090-----
          }
          #-----END MOD-770018-----
          LET l_npq.npq06 = '1'
#-----TQC-620082---------
          LET l_npq.npq24 = g_aza.aza17
          LET l_npq.npq25 = 1
#-----END TQC-620082-----
          LET g_npq25 = l_npq.npq25             #No.FUN-9A0036
          #-----TQC-6C0090---------
          #LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc09-g_gxc.gxc10)*g_gxc.gxc11
          LET l_npq.npq07 = g_gxc.gxc08*(g_gxc.gxc10-g_gxc.gxc09)*g_gxc.gxc11
          #LET l_npq.npq07 = l_npq.npq07 USING '############'
          #LET l_npq.npq07 = l_camt - l_damt # Thomas 98/08/31
          #-----END TQC-6C0090-----
          LET l_npq.npq07f= l_npq.npq07
          IF cl_null(l_npq.npq07) THEN LET l_npq.npq07 = 0 END IF
          IF cl_null(l_npq.npq07f) THEN LET l_npq.npq07f = 0 END IF
          #-----TQC-6C0090---------
          #CALL cl_digcut(l_npq.npq07,0) RETURNING l_npq.npq07
          SELECT azi04 INTO t_azi04 FROM azi_file
           WHERE azi01 = l_npq.npq24
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)
          LET l_npq.npq07f = cl_digcut(l_npq.npq07f,t_azi04)
          #-----END TQC-6C0090-----
          #LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25   #MOD-770018 #FUN-D10065 mark
          LET l_npq.npq04 = NULL #FUN-D10065
          #FUN-740028.....begin                                                                                                               
          CALL s_get_bookno(YEAR(g_gxc.gxc03)) RETURNING g_flag,g_bookno1,g_bookno2                                                        
          IF g_flag = '1' THEn                                                                                                             
          CALL cl_err(YEAR(g_gxc.gxc03),'aoo-081',1)                                                                                    
          LET g_success = 'N'                                                                                                           
          END IF                                                                                                                           
          #FUN-740028.....end        
          IF l_npq.npq05 IS NULL THEN LET l_npq.npq05 = ' ' END IF
          # NO.FUN-5C0015 --start--
          CALL s_def_npq(l_npq.npq03,g_prog,l_npq.*,l_npq.npq01,'','',g_bookno3)   #No.FUN-740028
           RETURNING  l_npq.*
          
          #FUN-D10065--add--str--
          IF cl_null(l_npq.npq04) THEN
             LET l_npq.npq04 = l_npq.npq24 CLIPPED,l_npq.npq07f,'*',l_npq.npq25
          END IF
          #FUN-D10065--add--end
          CALL s_def_npq31_npq34(l_npq.*,g_bookno3) RETURNING l_npq.npq31,l_npq.npq32,l_npq.npq33,l_npq.npq34  #FUN-AA0087	
          # NO.FUN-5C0015 ---end---
          #FUN-980005 add legal 
          LET l_npq.npqlegal = g_legal 
          #FUN-980005 end legal 
#No.FUN-9A0036 --Begin
       IF p_npptype = '1' THEN
#FUN-A40067 --Begin
          SELECT aaa03 INTO l_aaa03 FROM aaa_file
           WHERE aaa01 = g_bookno2
          SELECT azi04 INTO g_azi04_2 FROM azi_file
           WHERE azi01 = l_aaa03
#FUN-A40067 --End
          CALL s_newrate(g_bookno1,g_bookno2,
                         l_npq.npq24,g_npq25,l_npp.npp02)
          RETURNING l_npq.npq25
          LET l_npq.npq07 = l_npq.npq07f * l_npq.npq25
#         LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04_2)#FUN-A40067
       ELSE
          LET l_npq.npq07 = cl_digcut(l_npq.npq07,g_azi04)  #FUN-A40067
       END IF
#No.FUN-9A0036 --End
          #FUN-D40118--add--str--
          SELECT aag44 INTO g_aag44 FROM aag_file
           WHERE aag00 = g_bookno3
             AND aag01 = l_npq.npq03
          IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
             CALL s_chk_ahk(l_npq.npq03,g_bookno3) RETURNING l_flag
             IF l_flag = 'N'   THEN
                LET l_npq.npq03 = ''
             END IF
          END IF
          #FUN-D40118--add--end--
          INSERT INTO npq_file VALUES(l_npq.*)
          IF STATUS THEN 
#            CALL cl_err('ins npq #13',STATUS,1) #No.FUN-660148
             CALL cl_err3("ins","npq_file",l_npq.npq00,l_npq.npq01,STATUS,"","ins npq #13",1)  #No.FUN-660148
             LET g_success = 'N'  #No.FUN-680088
          END IF
       END IF
    END IF
    CALL t400_gen_diff(l_npp.*)          #No.FUN-A40033
    CALL s_flows('3','',l_npq.npq01,l_npp.npp02,'N',l_npq.npqtype,TRUE)   #No.TQC-B70021  
    CALL cl_getmsg('axr-055',g_lang) RETURNING g_msg
    MESSAGE g_msg CLIPPED
END FUNCTION
 
FUNCTION t400_out(p_cmd)
   DEFINE l_cmd	        LIKE type_file.chr1000, #No.FUN-680107 VARCHAR(400)
          l_wc,l_wc2    LIKE type_file.chr1000, #No.FUN-680107 VARCHAR(300)
          l_prtway      LIKE zz_file.zz22,
          p_cmd         LIKE type_file.chr1     #No.FUN-680107 VARCHAR(1)
 
   CALL cl_wait()
   LET l_wc = 'gxc01="',g_gxc.gxc01,'"' 		
   SELECT zz22 INTO l_prtway FROM zz_file WHERE zz01 = g_prog
 # LET l_cmd = "anmr411 ",    #FUN-C30085 mark
   LET l_cmd = "anmg411 ",    #FUN-C30085 add
               " '",g_today CLIPPED,"' ''",
               " '",g_lang CLIPPED,"' 'Y' '",l_prtway,"' '1'",' ',
               "'",l_wc CLIPPED,"'"
   CALL cl_cmdrun(l_cmd)
   ERROR ' '
END FUNCTION
 
#FUNCTION t400_x()                       #FUN-D20035
FUNCTION t400_x(p_type)                  #FUN-D20035
   DEFINE p_type    LIKE type_file.chr1  #FUN-D20035
   DEFINE l_flag    LIKE type_file.chr1  #FUN-D20035

   IF s_shut(0) THEN RETURN END IF
   SELECT * INTO g_gxc.* FROM gxc_file WHERE gxc01=g_gxc.gxc01
   IF g_gxc.gxc01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_gxc.gxc13 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF

   #FUN-D20035---begin
   IF p_type = 1 THEN
      IF g_gxc.gxc13 ='X' THEN RETURN END IF
   ELSE
      IF g_gxc.gxc13 <>'X' THEN RETURN END IF
   END IF
   #FUN-D20035---end

   BEGIN WORK
   LET g_success='Y'
   OPEN t400_cl USING g_gxc.gxc01
   IF STATUS THEN
      CALL cl_err("OPEN t400_cl:", STATUS, 1)
      CLOSE t400_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t400_cl INTO g_gxc.*#鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_gxc.gxc01,SQLCA.sqlcode,0)#資料被他人LOCK
      CLOSE t400_cl ROLLBACK WORK RETURN
   END IF
   #-->void轉換01/08/15
  #IF cl_void(0,0,g_gxc.gxc13)   THEN                     #FUN-D20035
   IF p_type = 1 THEN LET l_flag = 'N' ELSE LET l_flag = 'X' END IF    #FUN-D20035
   IF cl_void(0,0,l_flag) THEN                                         #FUN-D20035
      LET g_chr=g_gxc.gxc13
     #IF g_gxc.gxc13 ='N' THEN                                       #FUN-D20035
      IF p_type = 1 THEN                                              #FUN-D20035
         LET g_gxc.gxc13='X'
      ELSE
         LET g_gxc.gxc13='N'
      END IF
    UPDATE gxc_file SET gxc13 =g_gxc.gxc13
           WHERE gxc01 = g_gxc.gxc01
    IF STATUS THEN 
#      CALL cl_err('upd gxc13:',STATUS,1) #No.FUN-660148
       CALL cl_err3("upd","gxc_file",g_gxc.gxc01,"",STATUS,"","upd gxc13:",1)  #No.FUN-660148
       LET g_success='N' 
    END IF
    IF g_success='Y' THEN
        COMMIT WORK
        CALL cl_flow_notify(g_gxc.gxc01,'V')
    ELSE
        ROLLBACK WORK
    END IF
    SELECT gxc13 INTO g_gxc.gxc13 FROM gxc_file
     WHERE gxc01 = g_gxc.gxc01
    DISPLAY BY NAME g_gxc.gxc13
   END IF
END FUNCTION
 
FUNCTION t400_set_entry(p_cmd)
DEFINE   p_cmd   LIKE type_file.chr1    #No.FUN-680107 VARCHAR(1)
 
   IF p_cmd = 'a' AND (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("gxc01",TRUE)
   END IF
END FUNCTION
 
FUNCTION t400_set_no_entry(p_cmd)
DEFINE   p_cmd   LIKE type_file.chr1    #No.FUN-680107 VARCHAR(1)
 
   IF p_cmd = 'u' AND g_chkey MATCHES '[Nn]' AND (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("gxc01",FALSE)
   END IF
END FUNCTION
 
#No.FUN-670060 --begin--
FUNCTION t400_gen_glcr(p_gxc,p_nmy)
  DEFINE p_gxc     RECORD LIKE gxc_file.*
  DEFINE p_nmy     RECORD LIKE nmy_file.*
 
    IF cl_null(p_nmy.nmygslp) THEN
       CALL cl_err(p_gxc.gxc01,'axr-070',1)
       LET g_success = 'N'
       RETURN
    END IF       
    CALL t400_v('0')  #No.FUN-680088 add '0'
    #No.FUN-680088 --start--
    IF g_aza.aza63 = 'Y' AND g_success = 'Y' THEN
       CALL t400_v('1')
    END IF
    #No.FUN-680088 --end--
    IF g_success = 'N' THEN RETURN END IF
 
END FUNCTION
 
FUNCTION t400_carry_voucher()
  DEFINE l_nmygslp    LIKE nmy_file.nmygslp
  DEFINE li_result    LIKE type_file.num5    #No.FUN-680107 SMALLINT
  DEFINE l_dbs        STRING
  DEFINE l_sql        STRING
  DEFINE l_n          LIKE type_file.num5    #No.FUN-680107 SMALLINT
 
    #FUN-940036--begin--add-- 
    IF NOT cl_null(g_gxc.gxc14) OR g_gxc.gxc14 IS NOT NULL THEN 
       CALL cl_err(g_gxc.gxc14,'aap-618',1)
       RETURN
    END IF
    #FUN-940036--end--add--
    IF NOT cl_confirm('aap-989') THEN RETURN END IF
 
    CALL s_get_doc_no(g_gxc.gxc01) RETURNING g_t1
    SELECT * INTO g_nmy.* FROM nmy_file WHERE nmyslip=g_t1
   #IF g_nmy.nmyglcr = 'Y' THEN  #FUN-940036
    IF g_nmy.nmyglcr = 'Y' OR (g_nmy.nmyglcr = 'N' AND NOT cl_null(g_nmy.nmygslp)) THEN #FUN-940036
       LET l_nmygslp = g_nmy.nmygslp
       #LET g_plant_new=g_nmz.nmz02p CALL s_getdbs() LET l_dbs=g_dbs_new
       #LET l_sql = " SELECT COUNT(aba00) FROM ",l_dbs,"aba_file",
       LET l_sql = " SELECT COUNT(aba00) FROM ",cl_get_target_table(g_nmz.nmz02p,'aba_file'), #FUN-A50102
                   "  WHERE aba00 = '",g_nmz.nmz02b,"'",
                   "    AND aba01 = '",g_gxc.gxc14,"'"
 	   CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
       CALL cl_parse_qry_sql(l_sql,g_nmz.nmz02p) RETURNING l_sql #FUN-A50102
       PREPARE aba_pre5 FROM l_sql
       DECLARE aba_cs5 CURSOR FOR aba_pre5
       OPEN aba_cs5
       FETCH aba_cs5 INTO l_n
       IF l_n > 0 THEN
          CALL cl_err(g_gxc.gxc14,'aap-991',1)
          RETURN
       END IF
    ELSE
      #CALL cl_err('','aap-992',1) #FUN-940036
       CALL cl_err('','aap-936',1) #FUN-940036 
       RETURN
       #開窗作業
#      LET g_plant_new= g_nmz.nmz02p
#      CALL s_getdbs()
#      LET g_dbs_gl=g_dbs_new      # 得資料庫名稱
 
#      OPEN WINDOW t200p AT 5,10 WITH FORM "axr/42f/axrt200_p" 
#           ATTRIBUTE (STYLE = g_win_style CLIPPED)
#      CALL cl_ui_locale("axrt200_p")
#       
#      INPUT l_nmygslp WITHOUT DEFAULTS FROM FORMONLY.gl_no
#   
#         AFTER FIELD gl_no
#            CALL s_check_no("agl",l_nmygslp,"","1","aac_file","aac01",g_dbs_gl) #No.FUN-560190
#                  RETURNING li_result,l_nmygslp
#            IF (NOT li_result) THEN
#               NEXT FIELD gl_no
#            END IF
#    
#         AFTER INPUT
#            IF INT_FLAG THEN
#               EXIT INPUT 
#            END IF
#            IF cl_null(l_nmygslp) THEN
#               CALL cl_err('','9033',0)
#               NEXT FIELD gl_no  
#            END IF
#   
#         ON ACTION CONTROLR
#            CALL cl_show_req_fields()
#         ON ACTION CONTROLG
#            CALL cl_cmdask()
#         ON ACTION CONTROLP
#            IF INFIELD(gl_no) THEN
#               CALL q_m_aac(FALSE,TRUE,g_dbs_gl,l_nmygslp,'1',' ',' ','AGL') 
#               RETURNING l_nmygslp
#               DISPLAY l_nmygslp TO FORMONLY.gl_no
#               NEXT FIELD gl_no
#            END IF
#   
#         ON IDLE g_idle_seconds
#            CALL cl_on_idle()
#            CONTINUE INPUT
#    
#         ON ACTION about         #MOD-4C0121
#            CALL cl_about()      #MOD-4C0121
#    
#         ON ACTION help          #MOD-4C0121
#            CALL cl_show_help()  #MOD-4C0121
#    
#         ON ACTION exit  #加離開功能genero
#            LET INT_FLAG = 1
#            EXIT INPUT
 
#      END INPUT
#      CLOSE WINDOW t200p  
    END IF
    IF cl_null(l_nmygslp) OR (cl_null(g_nmy.nmygslp1) AND g_aza.aza63 = 'Y') THEN  #No.FUN-680088
       CALL cl_err(g_gxc.gxc01,'axr-070',1)
       RETURN
    END IF
    LET g_wc_gl = 'npp01 = "',g_gxc.gxc01,'" AND npp011 = 0'
   #LET g_str="anmp100 '",g_wc_gl CLIPPED,"' '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",l_nmygslp,"' '",g_gxc.gxc03,"' 'Y' '0' 'Y' '",g_nmz.nmz02c,"' '",g_nmy.nmygslp1,"'"  #No.FUN-680088#FUN-860040
    LET g_str="anmp100 '",g_wc_gl CLIPPED,"' '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",l_nmygslp,"' '",g_gxc.gxc03,"' 'Y' '1' 'Y' '",g_nmz.nmz02c,"' '",g_nmy.nmygslp1,"'"  #No.FUN-680088#FUN-860040
    CALL cl_cmdrun_wait(g_str) 
    SELECT gxc14,gxc141 INTO g_gxc.gxc14,g_gxc.gxc141 FROM gxc_file                                                                 
     WHERE gxc01 = g_gxc.gxc01                                                                                                    
    DISPLAY BY NAME g_gxc.gxc14                                                                                                   
    DISPLAY BY NAME g_gxc.gxc141                                                                                                  
END FUNCTION
 
FUNCTION t400_undo_carry_voucher() 
  DEFINE l_aba19    LIKE aba_file.aba19
  DEFINE l_dbs      STRING 
  DEFINE l_sql      STRING
 
    #FUN-940036--begin--add-- 
    IF cl_null(g_gxc.gxc14) OR g_gxc.gxc14 IS NULL THEN
       CALL cl_err(g_gxc.gxc14,'aap-619',1)
       RETURN 
    END IF
    #FUN-940036--end--add-- 
    IF NOT cl_confirm('aap-988') THEN RETURN END IF
 
    CALL s_get_doc_no(g_gxc.gxc01) RETURNING g_t1
    SELECT * INTO g_nmy.* FROM nmy_file WHERE nmyslip=g_t1
   #IF g_nmy.nmyglcr = 'N' THEN  #FUN-940036
    IF g_nmy.nmyglcr = 'N' AND cl_null(g_nmy.nmygslp) THEN   #FUN-940036
      #CALL cl_err('','aap-990',1)   #FUN-940036
       CALL cl_err('','aap-936',1)   #FUN-940036 
       RETURN
    END IF
    #LET g_plant_new=g_nmz.nmz02p CALL s_getdbs() LET l_dbs=g_dbs_new
    #LET l_sql = " SELECT aba19 FROM ",l_dbs,"aba_file",
    LET l_sql = " SELECT aba19 FROM ",cl_get_target_table(g_nmz.nmz02p,'aba_file'), #FUN-A50102
                "  WHERE aba00 = '",g_nmz.nmz02b,"'",
                "    AND aba01 = '",g_gxc.gxc14,"'"
 	 CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
     CALL cl_parse_qry_sql(l_sql,g_nmz.nmz02p) RETURNING l_sql #FUN-A50102
    PREPARE aba_pre1 FROM l_sql
    DECLARE aba_cs1 CURSOR FOR aba_pre1
    OPEN aba_cs1
    FETCH aba_cs1 INTO l_aba19
    IF l_aba19 = 'Y' THEN
       CALL cl_err(g_gxc.gxc14,'axr-071',1)
       RETURN
    END IF
    LET g_str="anmp110 '",g_nmz.nmz02p,"' '",g_nmz.nmz02b,"' '",g_gxc.gxc14,"' 'Y'"
    CALL cl_cmdrun_wait(g_str) 
    SELECT gxc14,gxc141 INTO g_gxc.gxc14,g_gxc.gxc141 FROM gxc_file 
     WHERE gxc01 = g_gxc.gxc01
    DISPLAY BY NAME g_gxc.gxc14
    DISPLAY BY NAME g_gxc.gxc141
END FUNCTION
#No.FUN-670060 --end--
#FUN-A40033 --Begin
FUNCTION t400_gen_diff(p_npp)
DEFINE p_npp   RECORD LIKE npp_file.*
DEFINE l_aaa   RECORD LIKE aaa_file.*
DEFINE l_npq1           RECORD LIKE npq_file.*
DEFINE l_sum_cr         LIKE npq_file.npq07
DEFINE l_sum_dr         LIKE npq_file.npq07
DEFINE l_flag           LIKE type_file.chr1    #FUN-D40118 add
   IF p_npp.npptype = '1' THEN
      CALL s_get_bookno(YEAR(p_npp.npp02)) RETURNING g_flag,g_bookno1,g_bookno2                                         
      IF g_flag =  '1' THEN
         CALL cl_err(p_npp.npp02,'aoo-081',1)                                                                                          
         RETURN
      END IF                                                                                                                           
      LET g_bookno3 = g_bookno2
      SELECT * INTO l_aaa.* FROM aaa_file WHERE aaa01 = g_bookno3
      LET l_sum_cr = 0
      LET l_sum_dr = 0
      SELECT SUM(npq07) INTO l_sum_dr
        FROM npq_file
       WHERE npqtype = '1'
         AND npq00 = p_npp.npp00
         AND npq01 = p_npp.npp01
         AND npq011= p_npp.npp011
         AND npqsys= p_npp.nppsys
         AND npq06 = '1'
      SELECT SUM(npq07) INTO l_sum_cr
        FROM npq_file
       WHERE npqtype = '1'
         AND npq00 = p_npp.npp00
         AND npq01 = p_npp.npp01
         AND npq011= p_npp.npp011
         AND npqsys= p_npp.nppsys
         AND npq06 = '2'
      IF l_sum_dr <> l_sum_cr THEN
         SELECT MAX(npq02)+1 INTO l_npq1.npq02
           FROM npq_file
          WHERE npqtype = '1'
            AND npq00 = p_npp.npp00
            AND npq01 = p_npp.npp01
            AND npq011= p_npp.npp011
            AND npqsys= p_npp.nppsys
         LET l_npq1.npqtype = p_npp.npptype
         LET l_npq1.npq00 = p_npp.npp00
         LET l_npq1.npq01 = p_npp.npp01
         LET l_npq1.npq011= p_npp.npp011
         LET l_npq1.npqsys= p_npp.nppsys
         LET l_npq1.npq07 = l_sum_dr-l_sum_cr
         LET l_npq1.npq24 = l_aaa.aaa03
         LET l_npq1.npq25 = 1
         IF l_npq1.npq07 < 0 THEN
            LET l_npq1.npq03 = l_aaa.aaa11
            LET l_npq1.npq07 = l_npq1.npq07 * -1
            LET l_npq1.npq06 = '1'
         ELSE
            LET l_npq1.npq03 = l_aaa.aaa12
            LET l_npq1.npq06 = '2'
         END IF
         LET l_npq1.npq07f = l_npq1.npq07
         LET l_npq1.npqlegal = g_legal
         #FUN-D40118--add--str--
         SELECT aag44 INTO g_aag44 FROM aag_file
          WHERE aag00 = g_bookno3
            AND aag01 = l_npq1.npq03
         IF g_aza.aza26 = '2' AND g_aag44 = 'Y' THEN
            CALL s_chk_ahk(l_npq1.npq03,g_bookno3) RETURNING l_flag
            IF l_flag = 'N'   THEN
               LET l_npq1.npq03 = ''
            END IF
         END IF
         #FUN-D40118--add--end--
         INSERT INTO npq_file VALUES(l_npq1.*)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","npq_file",p_npp.npp01,"",STATUS,"","",1)
            LET g_success = 'N'
         END IF
      END IF
   END IF   
END FUNCTION
#No.FUN-A40033 --End

#Patch....NO:TQC-610036 <> #
 
#Patch....NO.TQC-610036 <> #
