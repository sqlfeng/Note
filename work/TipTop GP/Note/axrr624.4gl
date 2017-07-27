# Prog. Version..: '5.30.06-13.04.16(00010)'     #
#
# Pattern name...: axrr624.4gl
# Descriptions...: 客戶應收帳齡分析表
# Date & Author..: 98/11/11 by Jimmy
# Modify.........:No.9017 04/12/13 By Kitty 改長度
# Modify.........: No.FUN-4C0100 05/03/02 By Smapmin 放寬金額欄位
# Modify.........: No.FUN-560239 05/07/12 By Nicola 多工廠資料欄位輸入開窗
# Modify.........: No.FUN-580010 05/08/11 By yoyo 憑証類報表原則修改
# Modify.........: No.MOD-5C0069 05/12/14 By Carrier ooz07='N'-->oma56t-oma57
#                                                    ooz07='Y'-->oma61
# Modify.........: No.TQC-650131 06/06/01 by rainy 報表名稱應在第一行
# Modify.........: No.TQC-610059 06/06/05 By Smapmin 修改外部參數接收
# Modify.........: No.FUN-680123 06/08/29 By hongmei 欄位類型轉換
# Modify.........: No.FUN-690127 06/10/16 By baogui cl_used位置調整及EXIT PROGRAM后加cl_used
# Modify.........: No.FUN-6A0095 06/10/25 By xumin l_time轉g_time
# Modify.........: No.CHI-830003 08/11/03 By xiaofeizhu 依程式畫面上的〔截止基准日〕回抓當月重評價匯率, 
# Modify.........:                                      若當月未產生重評價則往回抓前一月資料，若又抓不到再往上一個月找，找到有值為止
# Modify.........: No.FUN-940102 09/04/27 BY destiny 檢查使用者的資料庫使用權限
# Modify.........: No.TQC-950020 09/05/13 By mike 跨庫的SQL語句一律使用s_dbstring()的寫法 
# Modify.........: No.FUN-980030 09/08/31 By Hiko 加上GP5.2的相關設定
# Modify.........: No.FUN-A50102 10/06/21 By lixia 跨庫寫法統一改為用cl_get_target_table()來實現
# Modify.........: No.FUN-A70084 10/07/22 By lutingting 拿掉INPUT 營運中心,原本跨庫寫法改為不跨庫 
# Modify.........: No.TQC-B10083 11/01/19 By yinhy l_oma24應給予預設值'',抓不到值不應為'1'
# Modify.........: No.FUN-B20033 11/02/17 By lilingyu SQL增加ooa37='1'的條件
# Modify.........: No.MOD-B70194 11/07/25 By Polly 調整l_sql改用STRING 和修正l_sql條件
# Modify.........: No.FUN-C40001 12/04/13 By SunLM 增加開窗功能
# Modify.........: No.MOD-C90207 12/10/23 By Polly 增加依人員編號做群組

DATABASE ds
 
GLOBALS "../../config/top.global"
 
   DEFINE tm  RECORD                         # Print condition RECORD
              wc      LIKE type_file.chr1000,        #No.FUN-680123 VARCHAR(1000),             # Where condition
                      a1   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a2   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a3   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a4   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a5   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a6   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                      a7   LIKE type_file.num5,      #No.FUN-680123 SMALLINT,
                     #FUN-A70084--mark--str--
                     #p1   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p2   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p3   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p4   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p5   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p6   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p7   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #p8   LIKE azp_file.azp01,      #No.FUN-680123 VARCHAR(10),
                     #FUN-A70084--mark--end
                      type LIKE type_file.chr1,      #No.FUN-680123 VARCHAR(01),
                      edate LIKE type_file.dat,      #No.FUN-680123 DATE,
              more    LIKE type_file.chr1            #No.FUN-680123 VARCHAR(01)               # Input more condition(Y/N)
              END RECORD
     DEFINE     g_title  LIKE type_file.chr1000      #No.FUN-680123 VARCHAR(160)
DEFINE   g_i             LIKE type_file.num5         #No.FUN-680123 SMALLINT   #count/index for any purpose
 
MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                        # Supress DEL key function
 
   #-----TQC-610059---------
   LET g_pdate=ARG_VAL(1)
   LET g_towhom=ARG_VAL(2)
   LET g_rlang=ARG_VAL(3)
   LET g_bgjob=ARG_VAL(4)
   LET g_prtway=ARG_VAL(5)
   LET g_copies=ARG_VAL(6)
   LET tm.wc = ARG_VAL(7)
   LET tm.a1 = ARG_VAL(8)
   LET tm.a2 = ARG_VAL(9)
   LET tm.a3 = ARG_VAL(10)
   LET tm.a4 = ARG_VAL(11)
   LET tm.a5 = ARG_VAL(12)
   LET tm.a6 = ARG_VAL(13)
#FUN-A70084--mod--str--
#  LET tm.p1 = ARG_VAL(14)
#  LET tm.p2 = ARG_VAL(15)
#  LET tm.p3 = ARG_VAL(16)
#  LET tm.p4 = ARG_VAL(17)
#  LET tm.p5 = ARG_VAL(18)
#  LET tm.p6 = ARG_VAL(19)
#  LET tm.p7 = ARG_VAL(20)
#  LET tm.p8 = ARG_VAL(21)
#  LET tm.type = ARG_VAL(22)
#  LET tm.edate = ARG_VAL(23)
#  #-----END TQC-610059-----
#  #No.FUN-570264 --start--
#  LET g_rep_user = ARG_VAL(24)
#  LET g_rep_clas = ARG_VAL(25)
#  LET g_template = ARG_VAL(26)
   LET tm.type = ARG_VAL(14)
   LET tm.edate = ARG_VAL(15)
   LET g_rep_user = ARG_VAL(16)
   LET g_rep_clas = ARG_VAL(17)
   LET g_template = ARG_VAL(18)
#FUN-A70084--mod--end
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("AXR")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-690127
 
   #No.FUN-570264 ---end---
   IF cl_null(tm.wc)
      THEN CALL r624_tm(0,0)             # Input print condition
   ELSE 
      CALL r624()                   # Read data and create out-file
   END IF
   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
END MAIN
 
FUNCTION r624_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01   #No.FUN-580031
   DEFINE p_row,p_col LIKE type_file.num5,           #No.FUN-680123   SMALLINT,
          l_cmd       LIKE type_file.chr1000        #No.FUN-680123 VARCHAR(1000)
   DEFINE l_n         LIKE type_file.num5           #No.FUN-680123 SMALLINT
 
   OPEN WINDOW r624_w WITH FORM "axr/42f/axrr624"
       ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
    CALL cl_ui_init()
 
   CALL cl_opmsg('p')
   INITIALIZE tm.* TO NULL            # Default condition
   LET tm.a1 = 30
   LET tm.a2 = 60
   LET tm.a3 = 90
   LET tm.a4 = 120
   LET tm.a5 = 150
   LET tm.a6 = 180
   LET tm.a7 = 210
  #LET tm.p1 = g_plant    #FUN-A70084
   LET tm.type = '3'
   LET tm.more = 'N'
   LET g_pdate = g_today
   LET g_rlang = g_lang
   LET g_bgjob = 'N'
   LET g_copies = '1'
   LET tm.edate=g_today
WHILE TRUE
   CONSTRUCT BY NAME tm.wc ON oma03,oma14,oma15,oma00,oma18
         #No.FUN-580031 --start--
         BEFORE CONSTRUCT
             CALL cl_qbe_init()
         #No.FUN-580031 ---end---
 
       ON ACTION locale
           #CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         LET g_action_choice = "locale"
         EXIT CONSTRUCT
 
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE CONSTRUCT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controlg      #MOD-4C0121
         CALL cl_cmdask()     #MOD-4C0121
 
 
           ON ACTION exit
           LET INT_FLAG = 1
           EXIT CONSTRUCT
         #No.FUN-580031 --start--
         ON ACTION qbe_select
            CALL cl_qbe_select()
         #No.FUN-580031 ---end---
      #No.FUN-C40001  --Begin
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(oma15)#部門
                 CALL cl_init_qry_var()
                  LET g_qryparam.form = "q_gem1"   #No.MOD-530272
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oma15
                 NEXT FIELD oma15
            WHEN INFIELD(oma03)#賬款客戶編號
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_occ"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oma03
                 NEXT FIELD oma03
            WHEN INFIELD(oma14)#人員編號
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gen"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oma14
                 NEXT FIELD oma14
            WHEN INFIELD(oma18)#科目編號
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_aag"
                 LET g_qryparam.state = "c"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oma18
                 NEXT FIELD oma18
            END CASE
      #No.FUN-C40001  --End  
  END CONSTRUCT
       IF g_action_choice = "locale" THEN
          LET g_action_choice = ""
          CALL cl_dynamic_locale()
          CONTINUE WHILE
       END IF
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW r624_w 
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
      EXIT PROGRAM
         
   END IF
   INPUT BY NAME  tm.a1,tm.a2,tm.a3,tm.a4,tm.a5,tm.a6,tm.type,tm.edate
        #,tm.p1,tm.p2,tm.p3,tm.p4,tm.p5,tm.p6,tm.p7,tm.p8      #FUN-A70084
         ,tm.more
                WITHOUT DEFAULTS
         #No.FUN-580031 --start--
         BEFORE INPUT
             CALL cl_qbe_display_condition(lc_qbe_sn)
         #No.FUN-580031 ---end---
 
      AFTER FIELD edate
         IF tm.edate IS NULL THEN NEXT FIELD edate END IF
   #     IF MONTH(tm.edate)=MONTH(tm.edate+1) THEN
   #        ERROR "請輸入月底日期!" NEXT FIELD edate
   #     END IF
 
#FUN-A70084--mark--str--
#     #No.FUN-940102--begin  
#     AFTER FIELD p1
#        IF NOT cl_null(tm.p1) THEN 
#           IF NOT s_chk_demo(g_user,tm.p1) THEN              
#              NEXT FIELD p1          
#           END IF  
#        ELSE 
#           NEXT FIELD p1
#        END IF           
#
#     AFTER FIELD p2                                                                                                                
#        IF NOT cl_null(tm.p2) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p2) THEN                                                                                    
#              NEXT FIELD p2                                                                                                        
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p3                                                                                                                
#        IF NOT cl_null(tm.p3) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p3) THEN                                                                                    
#              NEXT FIELD p3                                                                                                        
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p4                                                                                                                
#        IF NOT cl_null(tm.p4) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p4) THEN                                                                                    
#              NEXT FIELD p4                                                                                                       
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p5                                                                                                                
#        IF NOT cl_null(tm.p5) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p5) THEN                                                                                    
#              NEXT FIELD p5                                                                                                        
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p6                                                                                                                
#        IF NOT cl_null(tm.p6) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p6) THEN                                                                                    
#              NEXT FIELD p6                                                                                                        
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p7                                                                                                                
#        IF NOT cl_null(tm.p7) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p7) THEN                                                                                    
#              NEXT FIELD p7                                                                                                        
#           END IF                                                                                                                  
#        END IF    
#
#     AFTER FIELD p8                                                                                                                
#        IF NOT cl_null(tm.p8) THEN                                                                                                 
#           IF NOT s_chk_demo(g_user,tm.p8) THEN                                                                                    
#              NEXT FIELD p8                                                                                                       
#           END IF                                                                                                                  
#        END IF    
#     #No.FUN-940102--end     
#FUN-A70084--mark--end

      AFTER FIELD more
         IF tm.more = 'Y'
            THEN CALL cl_repcon(0,0,g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies)
                      RETURNING g_pdate,g_towhom,g_rlang,
                                g_bgjob,g_time,g_prtway,g_copies
         END IF
 
#FUN-A70084--mark--str--
#     #-----No.FUN-560239-----
#     ON ACTION CONTROLP
#        CASE
#           WHEN INFIELD(p1)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p1
#              CALL cl_create_qry() RETURNING tm.p1
#              DISPLAY BY NAME tm.p1
#              NEXT FIELD p1
#           WHEN INFIELD(p2)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p2
#              CALL cl_create_qry() RETURNING tm.p2
#              DISPLAY BY NAME tm.p2
#              NEXT FIELD p2
#           WHEN INFIELD(p3)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p3
#              CALL cl_create_qry() RETURNING tm.p3
#              DISPLAY BY NAME tm.p3
#              NEXT FIELD p3
#           WHEN INFIELD(p4)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p4
#              CALL cl_create_qry() RETURNING tm.p4
#              DISPLAY BY NAME tm.p4
#              NEXT FIELD p4
#           WHEN INFIELD(p5)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p5
#              CALL cl_create_qry() RETURNING tm.p5
#              DISPLAY BY NAME tm.p5
#              NEXT FIELD p5
#           WHEN INFIELD(p6)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p6
#              CALL cl_create_qry() RETURNING tm.p6
#              DISPLAY BY NAME tm.p6
#              NEXT FIELD p6
#           WHEN INFIELD(p7)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p7
#              CALL cl_create_qry() RETURNING tm.p7
#              DISPLAY BY NAME tm.p7
#              NEXT FIELD p7
#           WHEN INFIELD(p8)
#              CALL cl_init_qry_var()
#             #LET g_qryparam.form = 'q_azp'               #No.FUN-940102
#              LET g_qryparam.form = "q_zxy"               #No.FUN-940102
#              LET g_qryparam.arg1 = g_user                #No.FUN-940102
#              LET g_qryparam.default1 = tm.p8
#              CALL cl_create_qry() RETURNING tm.p8
#              DISPLAY BY NAME tm.p8
#              NEXT FIELD p8
#        END CASE
#     #-----No.FUN-560239 END-----
#FUN-A70084--mark--end
 
################################################################################
# START genero shell script ADD
   ON ACTION CONTROLR
      CALL cl_show_req_fields()
# END genero shell script ADD
################################################################################
      ON ACTION CONTROLG CALL cl_cmdask()    # Command execution
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
 
          ON ACTION exit
          LET INT_FLAG = 1
          EXIT INPUT
         #No.FUN-580031 --start--
         ON ACTION qbe_save
            CALL cl_qbe_save()
         #No.FUN-580031 ---end---
 
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0 CLOSE WINDOW r624_w 
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
      EXIT PROGRAM
         
   END IF
   IF g_bgjob = 'Y' THEN
      SELECT zz08 INTO l_cmd FROM zz_file    #get exec cmd (fglgo xxxx)
             WHERE zz01='axrr624'
      IF SQLCA.sqlcode OR l_cmd IS NULL THEN
         CALL cl_err('axrr624','9031',1)
      ELSE
         LET tm.wc=cl_replace_str(tm.wc, "'", "\"")
         LET l_cmd = l_cmd CLIPPED,        #(at time fglgo xxxx p1 p2 p3)
                         " '",g_pdate CLIPPED,"'",
                         " '",g_towhom CLIPPED,"'",
                         " '",g_lang CLIPPED,"'",
                         " '",g_bgjob CLIPPED,"'",
                         " '",g_prtway CLIPPED,"'",
                         " '",g_copies CLIPPED,"'",
                         " '",tm.wc CLIPPED,"'" ,
                         " '",tm.a1 CLIPPED,"'" ,
                         " '",tm.a2 CLIPPED,"'" ,
                         " '",tm.a3 CLIPPED,"'" ,
                         " '",tm.a4 CLIPPED,"'" ,
                         " '",tm.a5 CLIPPED,"'" ,
                         " '",tm.a6 CLIPPED,"'" ,
                        #FUN-A70084--mark--str--
                        #" '",tm.p1 CLIPPED,"'" ,
                        #" '",tm.p2 CLIPPED,"'" ,
                        #" '",tm.p3 CLIPPED,"'" ,
                        #" '",tm.p4 CLIPPED,"'" ,
                        #" '",tm.p5 CLIPPED,"'" ,
                        #" '",tm.p6 CLIPPED,"'" ,
                        #" '",tm.p7 CLIPPED,"'" ,
                        #" '",tm.p8 CLIPPED,"'" ,
                        #FUN-A70084--mark--end
                         " '",tm.type CLIPPED,"'" ,
                         " '",tm.edate CLIPPED,"'" ,
                         " '",g_rep_user CLIPPED,"'",           #No.FUN-570264
                         " '",g_rep_clas CLIPPED,"'",           #No.FUN-570264
                         " '",g_template CLIPPED,"'"            #No.FUN-570264
         CALL cl_cmdat('axrr624',g_time,l_cmd)    # Execute cmd at later time
      END IF
      CLOSE WINDOW r624_w
      CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
      EXIT PROGRAM
   END IF
   CALL cl_wait()
   CALL r624()
   ERROR ""
END WHILE
   CLOSE WINDOW r624_w
END FUNCTION
 
FUNCTION r624()
   DEFINE l_name    LIKE type_file.chr20,          #No.FUN-680123 VARCHAR(20),        # External(Disk) file name
#       l_time          LIKE type_file.chr8        #No.FUN-6A0095
         #l_sql     LIKE type_file.chr1000,        #No.FUN-680123 VARCHAR(1000),      #No.MOD-B70194 mark
          l_sql     STRING,                        #No.MOD-B70194 add
          amt1,amt2 LIKE type_file.num20_6,        #No.FUN-680123 DEC(20,6),
          l_za05    LIKE za_file.za05,             #No.FUN-680123 VARCHAR(40),
          l_omavoid     LIKE oma_file.omavoid,
          l_omaconf     LIKE oma_file.omaconf,
          l_bucket      LIKE type_file.num5,       #No.FUN-680123 SMALLINT,
          l_day         LIKE type_file.num5,       #No.FUN-680123 SMALLINT,
          l_oma00       LIKE oma_file.oma00,
          l_order   ARRAY[5] OF LIKE cre_file.cre08,   #No.FUN-680123 VARCHAR(10),
          sr        RECORD
                        oma14     LIKE oma_file.oma14,  #業務員編號
                        gen02     LIKE gen_file.gen02,  #業務員name
                        oma15     LIKE oma_file.oma15,  #部門
                        oma03     LIKE oma_file.oma03,  #客戶
                        oma032    LIKE oma_file.oma032, #簡稱
                        oma02     LIKE oma_file.oma02,  #Date
                        oma01     LIKE oma_file.oma01,
                        oma11     LIKE oma_file.oma11,
                        occ02     LIKE occ_file.occ02,
                        num       LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num1      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num2      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num3      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num4      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num5      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
         {}             num6      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
         {}             num7      LIKE type_file.num20_6 #No.FUN-680123 DEC(20,6)
                    END RECORD
     DEFINE l_i      LIKE type_file.num5    #No.FUN-680123 SMALLINT
    #DEFINE l_plant  LIKE type_file.chr20   #No.FUN-680123 VARCHAR(20) #No:9017   #FUN-A70084
    #DEFINE l_p      LIKE azp_file.azp01    #No.FUN-680123 VARCHAR(10)            #FUN-A70084
     DEFINE l_oox01   STRING                #CHI-830003 add
     DEFINE l_oox02   STRING                #CHI-830003 add
     DEFINE l_sql_1   STRING                #CHI-830003 add
     DEFINE l_sql_2   STRING                #CHI-830003 add
     DEFINE l_omb03_1 LIKE omb_file.omb03   #CHI-830003 add
     DEFINE l_count   LIKE type_file.num5   #CHI-830003 add
     DEFINE l_oma24   LIKE oma_file.oma24   #CHI-830003 add     
 
     SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_rlang
     #====>資料權限的檢查
     #Begin:FUN-980030
     #     IF g_priv2='4' THEN#只能使用自己的資料
     #         LET tm.wc = tm.wc clipped," AND omauser = '",g_user,"'"
     #     END IF
     #     IF g_priv3='4' THEN                           #只能使用相同群的資料
     #         LET tm.wc = tm.wc clipped," AND omagrup MATCHES '",g_grup CLIPPED,"*'"
     #     END IF
 
     #     IF g_priv3 MATCHES "[5678]" THEN    #TQC-5C0134群組權限
     #         LET tm.wc = tm.wc clipped," AND omagrup IN ",cl_chk_tgrup_list()
     #     END IF
     LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('omauser', 'omagrup')
     #End:FUN-980030
 
     #TQC-650131 remark
     #CASE
     #   WHEN tm.type='1'
     #         LET g_title = g_x[1]
     #   WHEN tm.type='2'
     #         LET g_title = g_x[20]
     #   OTHERWISE
     #         LET g_title = g_x[21]
     #END CASE
 
     CALL cl_outnam('axrr624') RETURNING l_name
     
     #TQC-650131 --start-
     CASE
        WHEN tm.type='1'
              LET g_title = g_x[1]
        WHEN tm.type='2'
              LET g_title = g_x[20]
        OTHERWISE
              LET g_title = g_x[21]
     END CASE
     #TQC-650131 --end--
 
     START REPORT r624_rep TO l_name
     LET g_pageno = 0
#FUN-A70084--mark--str--
# FOR l_i = 1 to 8
#    CASE
#         WHEN l_i=1  LET l_p=tm.p1
#         WHEN l_i=2  LET l_p=tm.p2
#         WHEN l_i=3  LET l_p=tm.p3
#         WHEN l_i=4  LET l_p=tm.p4
#         WHEN l_i=5  LET l_p=tm.p5
#         WHEN l_i=6  LET l_p=tm.p6
#         WHEN l_i=7  LET l_p=tm.p7
#         WHEN l_i=8  LET l_p=tm.p8
#    END CASE
#    LET l_plant=''
#    IF cl_null(l_p) THEN CONTINUE FOR END IF
#    SELECT azp03 INTO l_plant FROM azp_file WHERE azp01=l_p
#    IF STATUS THEN CONTINUE FOR END IF
#   #LET l_plant = s_dbstring(l_plant CLIPPED)   #TQC-950020 
#    LET l_plant = s_dbstring(l_plant CLIPPED) #TQC-950020  
#FUN-A70084--mark--end
     #No.B396 010423 by plum
     #No.MOD-5C0069  --Begin
     IF g_ooz.ooz07 = 'N' THEN
        LET l_sql="SELECT oma14, gen02, oma15, ",
                  "       oma03, oma032,oma02, oma01,oma11,occ02,",
                  "       oma56t-oma57,0,0,0,0,0,0,0,oma00 ",
                 #FUN-A70084--mod--str--跨庫改為不跨庫
                 ##" FROM ",l_plant CLIPPED,"oma_file,",l_plant CLIPPED,
                 ##"occ_file ,OUTER ", l_plant CLIPPED ,"gen_file",
                 #" FROM ",cl_get_target_table(l_p,'oma_file'),",",cl_get_target_table(l_p,'occ_file'), #FUN-A50102
                 #" ,OUTER ", cl_get_target_table(l_p,'gen_file') ,   #FUN-A50102
                 #" WHERE oma_file.oma14=gen_file.gen01 AND occ01=oma03",
                  "  FROM oma_file LEFT OUTER JOIN gen_file ON oma_file.oma14 = gen_file.gen01,occ_file ", 
                  " WHERE occ01=oma03 ", 
                 #FUN-A70084--mod--end
                  "   AND ",tm.wc CLIPPED,                #No.MOD-B70194 remark
                  "   AND omaconf='Y' AND omavoid='N'",   #No.B396 by linda mod
                  "   AND oma02 <= '",tm.edate,"'",
                  "   AND (oma56t>oma57 OR  ",
                  "    oma01 IN (SELECT oob06 FROM ooa_file,oob_file ",
                  "        WHERE ooa01=oob01 AND ooaconf !='X' ", #010804 增
                 #"          AND ooa37 = '1'",            #FUN-B20033 #mark by pane 170524
                  "          AND ooa02 > '",tm.edate,"')) "
     ELSE
        LET l_sql="SELECT oma14, gen02, oma15, ",
                  "       oma03, oma032,oma02, oma01,oma11,occ02,",
                  "       oma61,0,0,0,0,0,0,0,oma00 ",                  #No.A057
                 #FUN-A70084--mod--str--
                 ##" FROM ",l_plant CLIPPED,"oma_file,",l_plant CLIPPED,
                 ##"occ_file ,OUTER ", l_plant CLIPPED ,"gen_file",
                 #" FROM ",cl_get_target_table(l_p,'oma_file'),",",cl_get_target_table(l_p,'occ_file'),  #FUN-A50102
                 #" ,OUTER ", cl_get_target_table(l_p,'gen_file') ,                           #FUN-A50102
                 #" WHERE oma_file.oma14=gen_file.gen01 AND occ01=oma03",
                  "  FROM oma_file LEFT OUTER JOIN gen_file ON oma_file.oma14 = gen_file.gen01,occ_file  ",
                  " WHERE occ01 = oma03 ",
                 #FUN-A70084--mod--end
                  "   AND ",tm.wc CLIPPED,
                  "   AND omaconf='Y' AND omavoid='N'",   #No.B396 by linda mod
                  "   AND oma02 <= '",tm.edate,"'",
                  "   AND (oma61 > 0    OR  ",
                  "    oma01 IN (SELECT oob06 FROM ooa_file,oob_file ",
                  "        WHERE ooa01=oob01 AND ooaconf !='X' ", #010804 增
                # "          AND ooa37 = '1'",         #FUN-B20033 #mark by pane 170524
                  "          AND ooa02 > '",tm.edate,"')) "
     END IF
     #No.MOD-5C0069  --End
 
     IF  tm.type ='1' THEN
         LET l_sql = l_sql CLIPPED," AND occ37 = 'Y' "
     END IF
     IF  tm.type ='2' THEN
         LET l_sql = l_sql CLIPPED," AND occ37 = 'N' "
     END IF
   # CALL cl_replace_sqldb(l_sql) RETURNING l_sql              #FUN-A50102 #FUN-A70084							
   # CALL cl_parse_qry_sql(l_sql,l_p) RETURNING l_sql          #FUN-A50102 #FUN-A70084	
     PREPARE r624_prepare1 FROM l_sql
     IF STATUS THEN CALL cl_err('prepare:',STATUS,1) 
        CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
        EXIT PROGRAM 
     END IF
     DECLARE r624_curs1 CURSOR FOR r624_prepare1
     FOREACH r624_curs1 INTO sr.*,l_oma00
       IF STATUS THEN CALL cl_err('Foreach:',STATUS,1) 
          CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690127
          EXIT PROGRAM 
       END IF
       
      #CHI-830003--Add--Begin--#    
      IF g_ooz.ooz07 = 'Y' THEN
         LET l_oox01 = YEAR(tm.edate)
         LET l_oox02 = MONTH(tm.edate)                      	 
         LET l_oma24 = ''    #TQC-B10083 add
         WHILE cl_null(l_oma24)
            IF g_ooz.ooz62 = 'N' THEN
               LET l_sql_2 = "SELECT COUNT(*) FROM oox_file",
                             " WHERE oox00 = 'AR' AND oox01 <= '",l_oox01,"'",
                             "   AND oox02 <= '",l_oox02,"'",
                             "   AND oox03 = '",sr.oma01,"'",
                             "   AND oox04 = '0'"
               PREPARE r624_prepare7 FROM l_sql_2
               DECLARE r624_oox7 CURSOR FOR r624_prepare7
               OPEN r624_oox7
               FETCH r624_oox7 INTO l_count
               CLOSE r624_oox7                       
               IF l_count = 0 THEN
                  #LET l_oma24 = '1'   #TQC-B10083 mark 
                  EXIT WHILE           #TQC-B10083 add
               ELSE                  
                  LET l_sql_1 = "SELECT oox07 FROM oox_file",             
                                " WHERE oox00 = 'AR' AND oox01 = '",l_oox01,"'",
                                "   AND oox02 = '",l_oox02,"'",
                                "   AND oox03 = '",sr.oma01,"'",
                                "   AND oox04 = '0'"
               END IF                 
            ELSE
               LET l_sql_2 = "SELECT COUNT(*) FROM oox_file",
                             " WHERE oox00 = 'AR' AND oox01 <= '",l_oox01,"'",
                             "   AND oox02 <= '",l_oox02,"'",
                             "   AND oox03 = '",sr.oma01,"'",
                             "   AND oox04 <> '0'"
               PREPARE r624_prepare8 FROM l_sql_2
               DECLARE r624_oox8 CURSOR FOR r624_prepare8
               OPEN r624_oox8
               FETCH r624_oox8 INTO l_count
               CLOSE r624_oox8                       
               IF l_count = 0 THEN
                  #LET l_oma24 = '1'    #TQC-B10083 mark
                  EXIT WHILE            #TQC-B10083 add
               ELSE            
                  SELECT MIN(omb03) INTO l_omb03_1 FROM omb_file
                   WHERE omb01 = sr.oma01
                  IF cl_null(l_omb03_1) THEN
                     LET l_omb03_1 = 0
                  END IF       
                  LET l_sql_1 = "SELECT oox07 FROM oox_file",             
                                " WHERE oox00 = 'AR' AND oox01 = '",l_oox01,"'",
                                "   AND oox02 = '",l_oox02,"'",
                                "   AND oox03 = '",sr.oma01,"'",
                                "   AND oox04 = '",l_omb03_1,"'"                                      
               END IF
            END IF   
            IF l_oox02 = '01' THEN
               LET l_oox02 = '12'
               LET l_oox01 = l_oox01-1
            ELSE    
               LET l_oox02 = l_oox02-1
            END IF            
            
            IF l_count <> 0 THEN        
               PREPARE r624_prepare07 FROM l_sql_1
               DECLARE r624_oox07 CURSOR FOR r624_prepare07
               OPEN r624_oox07
               FETCH r624_oox07 INTO l_oma24
               CLOSE r624_oox07
            END IF              
         END WHILE                       
      END IF
      #CHI-830003--Add--End--#        
       
       #LET amt1=sr.num1+amt1 LET sr.num1=0
       #   LET l_bucket=YEAR(tm.edate)*12+MONTH(tm.edate)-
       #               (YEAR(sr.oma02)*12+MONTH(sr.oma02))+1
       #   CASE WHEN l_bucket<=tm.a1/30 LET sr.num1=amt1
       #        WHEN l_bucket<=tm.a2/30 LET sr.num2=amt1
       #        WHEN l_bucket<=tm.a3/30 LET sr.num3=amt1
       #        WHEN l_bucket<=tm.a4/30 LET sr.num4=amt1
       #        WHEN l_bucket<=tm.a5/30 LET sr.num5=amt1
       #        OTHERWISE               LET sr.num6=amt1
       #No.B396 010423 add by linda
       IF l_oma00 MATCHES '1*' THEN
          LET amt1=0 LET amt2=0
          SELECT SUM(oob09),SUM(oob10) INTO amt1,amt2
               FROM oob_file, ooa_file
              WHERE oob06=sr.oma01 AND oob03='2' AND oob04='1' AND ooaconf='Y'
                AND ooa01=oob01 AND ooa02 > tm.edate
              # AND ooa37 = '1'             #FUN-B20033  #mark by pane 170524
          IF amt1 IS NULL THEN LET amt1=0 END IF
          IF amt2 IS NULL THEN LET amt2=0 END IF
          #CHI-830003--Begin--#
          #IF g_ooz.ooz07 = 'Y' AND l_count <> 0 THEN          #TQC-B10083 mark
          IF g_ooz.ooz07 = 'Y' AND NOT cl_null(l_oma24) THEN   #TQC-B10083 mod
             LET amt2 = amt1 * l_oma24
          END IF    
          #CHI-830003--End--#          
          LET sr.num=sr.num+amt2
       ELSE
          LET amt1=0 LET amt2=0
          SELECT SUM(oob09),SUM(oob10) INTO amt1,amt2
               FROM oob_file, ooa_file
              WHERE oob06=sr.oma01 AND oob03='1' AND oob04='3' AND ooaconf='Y'
                AND ooa01=oob01 AND ooa02 > tm.edate
               #AND ooa37 = '1'             #FUN-B20033  #mark by pane 170524
          IF amt1 IS NULL THEN LET amt1=0 END IF
          IF amt2 IS NULL THEN LET amt2=0 END IF
          #CHI-830003--Begin--#
          #IF g_ooz.ooz07 = 'Y' AND l_count <> 0 THEN           #TQC-B10083 mark
          IF g_ooz.ooz07 = 'Y' AND NOT cl_null(l_oma24) THEN    #TQC-B10083 mod
             LET amt2 = amt1 * l_oma24
          END IF    
          #CHI-830003--End--#          
          LET sr.num=sr.num+amt2
          LET sr.num=sr.num*-1
       END IF
       #No.B396 end --------
           LET l_day = tm.edate - sr.oma02
           CASE WHEN l_day   <=tm.a1 LET sr.num1= sr.num
                WHEN l_day   <=tm.a2 LET sr.num2= sr.num
                WHEN l_day   <=tm.a3 LET sr.num3= sr.num
                WHEN l_day   <=tm.a4 LET sr.num4= sr.num
                WHEN l_day   <=tm.a5 LET sr.num5= sr.num
                WHEN l_day   <=tm.a6 LET sr.num6= sr.num
                OTHERWISE            LET sr.num7= sr.num
           END CASE
       OUTPUT TO REPORT r624_rep(sr.*)
     END FOREACH
 #END FOR     #FUN-A70084
 
     FINISH REPORT r624_rep
 
     CALL cl_prt(l_name,g_prtway,g_copies,g_len)
END FUNCTION
 
REPORT r624_rep(sr)
   DEFINE l_last_sw    LIKE type_file.chr1,   #No.FUN-680123 VARCHAR(1),
          l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_amt7  LIKE type_file.num20_6,#No.FUN-680123    DEC(20,6),
          l_amt_tot    LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),  
          sr        RECORD
                        oma14     LIKE oma_file.oma14,  #業務員編號
                        gen02     LIKE gen_file.gen02,  #業務員name
                        oma15     LIKE oma_file.oma15,  #部門
                        oma03     LIKE oma_file.oma03,  #客戶
                        oma032    LIKE oma_file.oma032, #簡稱
                        oma02     LIKE oma_file.oma02,  #Date
                        oma01     LIKE oma_file.oma01,
                        oma11     LIKE oma_file.oma11,
                        occ02     LIKE occ_file.occ02,
                        num       LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num1      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num2      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num3      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num4      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
                        num5      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
         {}             num6      LIKE type_file.num20_6,#No.FUN-680123 DEC(20,6),
         {}             num7      LIKE type_file.num20_6 #No.FUN-680123 DEC(20,6)
                    END RECORD
 
  OUTPUT TOP MARGIN g_top_margin LEFT MARGIN g_left_margin BOTTOM MARGIN g_bottom_margin PAGE LENGTH g_page_line
  ORDER BY sr.oma03,sr.oma14                      #MOD-C90207 add oma14
  FORMAT
   PAGE HEADER
#NO.FUN-580010--start
      PRINT COLUMN ((g_len-FGL_WIDTH(g_company CLIPPED))/2)+1,g_company CLIPPED
      PRINT COLUMN ((g_len-FGL_WIDTH(g_title))/2)+1,g_title #TQC-650131
      LET g_pageno=g_pageno+1
      LET pageno_total=PAGENO USING '<<<',"/pageno"
      PRINT g_head CLIPPED,pageno_total
      #PRINT COLUMN ((g_len-FGL_WIDTH(g_title))/2)+1,g_title #TQC-650131 remark
      PRINT COLUMN 96,g_x[14] CLIPPED,tm.edate
      PRINT g_dash[1,g_len]
      LET g_zaa[34].zaa08=tm.a1 USING '###',g_x[11]
      LET g_zaa[35].zaa08=tm.a2 USING '###',g_x[11]
      LET g_zaa[36].zaa08=tm.a3 USING '###',g_x[11]
      LET g_zaa[37].zaa08=tm.a4 USING '###',g_x[11]
      LET g_zaa[38].zaa08=tm.a5 USING '###',g_x[11]
      LET g_zaa[39].zaa08=tm.a6 USING '###',g_x[11]
      LET g_zaa[40].zaa08=tm.a6 USING '###',g_x[12]
      PRINT g_x[31],g_x[32],g_x[33],g_x[34],g_x[35],g_x[36],g_x[37],g_x[38],g_x[39],g_x[40],g_x[41]
      PRINT g_dash1
#No.FUN-580010--end
   AFTER GROUP OF sr.oma03
         LET l_amt1= GROUP SUM(sr.num1)
         LET l_amt2= GROUP SUM(sr.num2)
         LET l_amt3= GROUP SUM(sr.num3)
         LET l_amt4= GROUP SUM(sr.num4)
         LET l_amt5= GROUP SUM(sr.num5)
         LET l_amt6= GROUP SUM(sr.num6)
         LET l_amt7= GROUP SUM(sr.num7)
         IF cl_null(l_amt1) THEN LET l_amt1 =0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2 =0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3 =0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4 =0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5 =0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6 =0 END IF
         IF cl_null(l_amt7) THEN LET l_amt7 =0 END IF
 
         LET l_amt_tot = l_amt1+l_amt2+l_amt3+l_amt4+l_amt5+l_amt6+l_amt7
#No.FUN-580010--start
         PRINT COLUMN g_c[31],sr.oma03,
               COLUMN g_c[32],sr.occ02[1,20],
               COLUMN g_c[33],sr.gen02,
               COLUMN g_c[34],cl_numfor(l_amt1,34,g_azi05),
               COLUMN g_c[35],cl_numfor(l_amt2,35,g_azi05),
               COLUMN g_c[36],cl_numfor(l_amt3,36,g_azi05),
               COLUMN g_c[37],cl_numfor(l_amt4,37,g_azi05),
               COLUMN g_c[38],cl_numfor(l_amt5,38,g_azi05),
               COLUMN g_c[39],cl_numfor(l_amt6,39,g_azi05),
               COLUMN g_c[40],cl_numfor(l_amt7,40,g_azi05),
               COLUMN g_c[41],cl_numfor(l_amt_tot,41,g_azi05)
#No.FUN-580010--end
 
  #---------------------------MOD-C90207-----------------------(S)
   BEFORE GROUP OF sr.oma03
      PRINT COLUMN g_c[31],sr.oma03,
            COLUMN g_c[32],sr.occ02[1,20]

   BEFORE GROUP OF sr.oma14
      PRINT COLUMN g_c[33],sr.gen02

   AFTER GROUP OF sr.oma14
         LET l_amt1= GROUP SUM(sr.num1)
         LET l_amt2= GROUP SUM(sr.num2)
         LET l_amt3= GROUP SUM(sr.num3)
         LET l_amt4= GROUP SUM(sr.num4)
         LET l_amt5= GROUP SUM(sr.num5)
         LET l_amt6= GROUP SUM(sr.num6)
         LET l_amt7= GROUP SUM(sr.num7)
         IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
         IF cl_null(l_amt7) THEN LET l_amt7 = 0 END IF

         LET l_amt_tot = l_amt1 + l_amt2 + l_amt3 + l_amt4 + l_amt5 + l_amt6 + l_amt7
         PRINT COLUMN g_c[34],cl_numfor(l_amt1,34,g_azi05),
               COLUMN g_c[35],cl_numfor(l_amt2,35,g_azi05),
               COLUMN g_c[36],cl_numfor(l_amt3,36,g_azi05),
               COLUMN g_c[37],cl_numfor(l_amt4,37,g_azi05),
               COLUMN g_c[38],cl_numfor(l_amt5,38,g_azi05),
               COLUMN g_c[39],cl_numfor(l_amt6,39,g_azi05),
               COLUMN g_c[40],cl_numfor(l_amt7,40,g_azi05),
               COLUMN g_c[41],cl_numfor(l_amt_tot,41,g_azi05)
  #---------------------------MOD-C90207-----------------------(E)
   ON LAST ROW
         LET l_amt1= SUM(sr.num1)
         LET l_amt2= SUM(sr.num2)
         LET l_amt3= SUM(sr.num3)
         LET l_amt4= SUM(sr.num4)
         LET l_amt5= SUM(sr.num5)
         LET l_amt6= SUM(sr.num6)
         LET l_amt7= SUM(sr.num7)
         IF cl_null(l_amt1) THEN LET l_amt1 =0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2 =0 END IF
         IF cl_null(l_amt3) THEN LET l_amt3 =0 END IF
         IF cl_null(l_amt4) THEN LET l_amt4 =0 END IF
         IF cl_null(l_amt5) THEN LET l_amt5 =0 END IF
         IF cl_null(l_amt6) THEN LET l_amt6 =0 END IF
         IF cl_null(l_amt7) THEN LET l_amt7 =0 END IF
 
         LET l_amt_tot=l_amt1+l_amt2+l_amt3+l_amt4+l_amt5+l_amt6+l_amt7
#No.FUN-580010--start
         PRINT g_dash2[1,g_len]
         PRINTX name=S1 g_x[17] CLIPPED,
               COLUMN  g_c[34],cl_numfor(l_amt1,34,g_azi05),
               COLUMN  g_c[35],cl_numfor(l_amt2,35,g_azi05),
               COLUMN  g_c[35],cl_numfor(l_amt3,36,g_azi05),
               COLUMN  g_c[36],cl_numfor(l_amt4,37,g_azi05),
               COLUMN  g_c[38],cl_numfor(l_amt5,38,g_azi05),
               COLUMN  g_c[39],cl_numfor(l_amt6,39,g_azi05),
               COLUMN  g_c[40],cl_numfor(l_amt7,40,g_azi05),
               COLUMN  g_c[41],cl_numfor(l_amt_tot,41,g_azi05)
         PRINTX name=S1 g_x[18] CLIPPED,
               COLUMN  g_c[34],cl_numfor(l_amt1/l_amt_tot*100,34,2),
               COLUMN  g_c[35],cl_numfor(l_amt2/l_amt_tot*100,35,2),
               COLUMN  g_c[36],cl_numfor(l_amt3/l_amt_tot*100,36,2),
               COLUMN  g_c[37],cl_numfor(l_amt4/l_amt_tot*100,37,2),
               COLUMN  g_c[38],cl_numfor(l_amt5/l_amt_tot*100,38,2),
               COLUMN  g_c[39],cl_numfor(l_amt6/l_amt_tot*100,39,2),
               COLUMN  g_c[40],cl_numfor(l_amt7/l_amt_tot*100,40,2),
               COLUMN  g_c[41],cl_numfor(100.00,41,2)
#No.FUN-580010--end
   PAGE TRAILER
         PRINT '(axrr624)'
         PRINT g_dash[1,g_len]
         PRINT COLUMN 01,g_x[04] CLIPPED,COLUMN 41,g_x[05] CLIPPED
END REPORT
#Patch....NO.TQC-610037 <> #
