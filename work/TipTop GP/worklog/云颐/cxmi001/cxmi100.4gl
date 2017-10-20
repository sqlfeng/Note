# Prog. Version..: '5.25.02-11.03.23(00000)'     #
#
# Pattern name...: axmi920.4gl   tc_tc_pmc_file
# Descriptions...:  原料进口
# Date & Author..: 16/03/21 By gaozk



DATABASE ds
 
 # GLOBALS "../../config/top.global"
 
GLOBALS "../../../tiptop/config/top.global"


 
DEFINE 
    g_tc_pmc           DYNAMIC ARRAY OF RECORD   #程式變數(Program Variables)
        tc_pmc01       LIKE tc_pmc_file.tc_pmc01,  
        tc_pmc02       LIKE tc_pmc_file.tc_pmc02,
        tc_pmc03       LIKE tc_pmc_file.tc_pmc03
    
                    END RECORD,
    g_tc_pmc_t         RECORD                 #程式變數 (舊值)
        tc_pmc01       LIKE tc_pmc_file.tc_pmc01,  
        tc_pmc02       LIKE tc_pmc_file.tc_pmc02,
        tc_pmc03       LIKE tc_pmc_file.tc_pmc03
        
                    END RECORD,
    g_wc2,g_sql     string,  #No.FUN-580092 HCN   
    g_rec_b         LIKE type_file.num5,                #單身筆數        #No.FUN-680137 SMALLINT
    l_ac            LIKE type_file.num5                 #目前處理的ARRAY CNT        #No.FUN-680137 SMALLINT
DEFINE p_row,p_col     LIKE type_file.num5          #No.FUN-680137 SMALLINT
 
DEFINE g_forupd_sql  string   #SELECT ... FOR UPDATE SQL   
DEFINE   g_cnt           LIKE type_file.num10            #No.FUN-680137 INTEGER
DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose        #No.FUN-680137 SMALLINT
DEFINE   g_before_input_done    LIKE type_file.num5     #No.FUN-570109         #No.FUN-680137 SMALLINT
 
MAIN
#     DEFINEl_time LIKE type_file.chr8            #No.FUN-6A0094
 
    OPTIONS                                #改變一些系統預設值
        INPUT NO WRAP
    DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF
 
 
      CALL  cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0094
         RETURNING g_time    #No.FUN-6A0094
    LET p_row = 3 LET p_col = 16
 
    OPEN WINDOW i030_w AT p_row,p_col WITH FORM "cxm/42f/cxmi100"
          ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
    
    CALL cl_ui_init()
 
        
    LET g_wc2 = '1=1' CALL i030_b_fill(g_wc2)
    CALL i030_menu()
    CLOSE WINDOW i030_w                 #結束畫面
      CALL  cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818  #No.FUN-6A0094
         RETURNING g_time    #No.FUN-6A0094
END MAIN
 
FUNCTION i030_menu()
   WHILE TRUE
      CALL i030_bp("G")
      CASE g_action_choice
         WHEN "query" 
            IF cl_chk_act_auth() THEN
               CALL i030_q()
            END IF
         WHEN "detail" 
            IF cl_chk_act_auth() THEN
               CALL i030_b() 
            ELSE
               LET g_action_choice = NULL
            END IF
      {   WHEN "output" 
            IF cl_chk_act_auth() THEN
               CALL i030_out() 
            END IF
       }
         WHEN "help" 
            CALL cl_show_help()
         WHEN "exit" 
            EXIT WHILE
         WHEN "controlg" 
            CALL cl_cmdask()
         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_pmc),'','')
            END IF
 
      END CASE
   END WHILE
END FUNCTION
 
FUNCTION i030_q()
   CALL i030_b_askkey()
END FUNCTION
 
FUNCTION i030_b()
DEFINE
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT        #No.FUN-680137 SMALLINT
    l_n             LIKE type_file.num5,                #檢查重複用        #No.FUN-680137 SMALLINT
    l_lock_sw       LIKE type_file.chr1,                 #單身鎖住否        #No.FUN-680137 VARCHAR(1)
    p_cmd           LIKE type_file.chr1,                 #處理狀態        #No.FUN-680137 VARCHAR(1)
    l_allow_insert  LIKE type_file.num5,                #可新增否        #No.FUN-680137 SMALLINT
    l_allow_delete  LIKE type_file.num5,                 #可刪除否        #No.FUN-680137 SMALLINT
    l_gcnt01        LIKE type_file.num5,
    l_ima02         LIKE ima_file.ima02,
    l_ima021        LIKE ima_file.ima021
    
    LET g_action_choice = ""
    IF s_shut(0) THEN RETURN END IF
    CALL cl_opmsg('b')
 
    LET g_forupd_sql = "SELECT tc_pmc01,tc_pmc02,tc_pmc03 FROM tc_pmc_file WHERE tc_pmc01=? AND tc_pmc02=? FOR UPDATE"
 
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i030_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
        LET l_allow_insert = cl_detail_input_auth("insert")
        LET l_allow_delete = cl_detail_input_auth("delete")
 
        INPUT ARRAY g_tc_pmc WITHOUT DEFAULTS FROM s_tc_pmc.*
              ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                        APPEND ROW=l_allow_insert)
            
        BEFORE INPUT
        
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
 
        BEFORE ROW
            LET p_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()
           
 
            IF g_rec_b >= l_ac THEN
               LET p_cmd='u'
               LET g_tc_pmc_t.* = g_tc_pmc[l_ac].*  #BACKUP
#No.FUN-570109 --start--                                                                                                            
               LET g_before_input_done = FALSE                                                                                      
        #       CALL i030_set_entry_b(p_cmd)                                                                                         
       #        CALL i030_set_no_entry_b(p_cmd)                                                                                      
               LET g_before_input_done = TRUE                                                                                       
#No.FUN-570109 --end--   
               BEGIN WORK
 
               OPEN i030_bcl USING g_tc_pmc_t.tc_pmc01,g_tc_pmc_t.tc_pmc02
               IF STATUS THEN
                  CALL cl_err("OPEN i030_bcl:", STATUS, 1)
                  LET l_lock_sw = "Y"
               ELSE  
                  FETCH i030_bcl INTO g_tc_pmc[l_ac].* 
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_pmc_t.tc_pmc01,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"
                  END IF
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF
         
 
        AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            INSERT INTO tc_pmc_file(tc_pmc01,tc_pmc02,tc_pmc03 )
             VALUES(g_tc_pmc[l_ac].tc_pmc01,g_tc_pmc[l_ac].tc_pmc02,g_tc_pmc[l_ac].tc_pmc03)
            IF SQLCA.sqlcode THEN
#               CALL cl_err(g_tc_pmc[l_ac].tc_pmc01,SQLCA.sqlcode,0)   #No.FUN-660167
                CALL cl_err3("ins","tc_pmc_file",g_tc_pmc[l_ac].tc_pmc01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
                CANCEL INSERT
            ELSE
                MESSAGE 'INSERT O.K'
                LET g_rec_b=g_rec_b+1
                DISPLAY g_rec_b TO FORMONLY.cn2  
            END IF
            #--Move original INSERT block from AFTER ROW to here
 
        BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd='a'
#No.FUN-570109 --start--                                                                                                            
            LET g_before_input_done = FALSE                                                                                      
     #       CALL i030_set_entry_b(p_cmd)                                                                                         
     #       CALL i030_set_no_entry_b(p_cmd)                                                                                      
            LET g_before_input_done = TRUE                                                                                       
#No.FUN-570109 --end--   
            INITIALIZE g_tc_pmc[l_ac].* TO NULL      #900423
            LET g_tc_pmc_t.* = g_tc_pmc[l_ac].*         #新輸入資料
            CALL cl_show_fld_cont()     #FUN-550037(smin)
            NEXT FIELD tc_pmc01
 
 
       BEFORE FIELD tc_pmc01 
              LET g_tc_pmc[l_ac].tc_pmc01='1'
              DISPLAY BY NAME g_tc_pmc[l_ac].tc_pmc01
 {
        AFTER FIELD tc_pmc01                      
        IF g_tc_pmc[l_ac].tc_pmc01 IS NOT NULL THEN
      
           LET l_gcnt01=0 
            SELECT count(*) into l_gcnt01 from ima_file where ima01==g_tc_pmc[l_ac].tc_pmc01
           IF l_gcnt01=0 THEN 
           	   CALL cl_err("",'cxm-901',0)
           	   NEXT FIELD tc_pmc01
           END IF 
      
            select ima02,ima021 into l_ima02,l_ima021 from ima_file
                           where ima01=g_tc_pmc[l_ac].tc_pmc01 
                   LET g_tc_pmc[l_ac].tc_pmc02 =l_ima02
                   LET g_tc_pmc[l_ac].tc_pmc03 =l_ima021
                DISPLAY BY NAME g_tc_pmc[l_ac].tc_pmc02
                DISPLAY BY NAME g_tc_pmc[l_ac].tc_pmc03
         END IF
    
         
       AFTER FIELD tc_pmc06                        #金额字段
        IF g_tc_pmc[l_ac].tc_pmc06 IS NOT NULL THEN  
          LET g_tc_pmc[l_ac].tc_pmc07=g_tc_pmc[l_ac].tc_pmc04*g_tc_pmc[l_ac].tc_pmc06
          DISPLAY BY NAME g_tc_pmc[l_ac].tc_pmc07
        END IF 
        
        AFTER FIELD tc_pmc07                        #金额字段
        IF g_tc_pmc[l_ac].tc_pmc07 IS NOT NULL THEN  
          LET g_tc_pmc[l_ac].tc_pmc07=g_tc_pmc[l_ac].tc_pmc04*g_tc_pmc[l_ac].tc_pmc06
          DISPLAY BY NAME g_tc_pmc[l_ac].tc_pmc07
        END IF 
        
  }
        BEFORE DELETE                            #是否取消單身
            IF g_tc_pmc_t.tc_pmc01 IS NOT NULL AND g_tc_pmc_t.tc_pmc02 IS NOT NULL THEN
                IF NOT cl_delete() THEN
                   CANCEL DELETE
                END IF
                
                IF l_lock_sw = "Y" THEN 
                   CALL cl_err("", -263, 1) 
                   CANCEL DELETE 
                END IF 
                
                DELETE FROM tc_pmc_file WHERE tc_pmc01 = g_tc_pmc_t.tc_pmc01 AND tc_pmc02 = g_tc_pmc_t.tc_pmc02
                IF SQLCA.sqlcode THEN
#                  CALL cl_err(g_tc_pmc_t.tc_pmc01,SQLCA.sqlcode,0)   #No.FUN-660167
                   CALL cl_err3("del","tc_pmc_file",g_tc_pmc_t.tc_pmc01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
                   ROLLBACK WORK
                   CANCEL DELETE 
                END IF
                LET g_rec_b=g_rec_b-1
                DISPLAY g_rec_b TO FORMONLY.cn2  
                MESSAGE "Delete OK"
                CLOSE i030_bcl
                COMMIT WORK
            END IF
 
        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_tc_pmc[l_ac].* = g_tc_pmc_t.*
               CLOSE i030_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_tc_pmc[l_ac].tc_pmc01,-263,1)
               LET g_tc_pmc[l_ac].* = g_tc_pmc_t.*
            ELSE
               UPDATE tc_pmc_file SET tc_pmc01=g_tc_pmc[l_ac].tc_pmc01,
                                   tc_pmc02=g_tc_pmc[l_ac].tc_pmc02,tc_pmc03=g_tc_pmc[l_ac].tc_pmc03
                WHERE tc_pmc01 = g_tc_pmc_t.tc_pmc01 AND tc_pmc02 = g_tc_pmc_t.tc_pmc02
               IF SQLCA.sqlcode THEN
#                  CALL cl_err(g_tc_pmc[l_ac].tc_pmc01,SQLCA.sqlcode,0)   #No.FUN-660167
                   CALL cl_err3("upd","tc_pmc_file",g_tc_pmc_t.tc_pmc01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
                   LET g_tc_pmc[l_ac].* = g_tc_pmc_t.*
               ELSE
                   MESSAGE 'UPDATE O.K'
                   COMMIT WORK
               END IF
            #--Move original UPDATE block from AFTER ROW to here
            END IF
 
        #--New AFTER ROW block
        AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd = 'u' THEN
                  LET g_tc_pmc[l_ac].* = g_tc_pmc_t.*
               END IF
               CLOSE i030_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            CLOSE i030_bcl
            COMMIT WORK
            
    {        
       ON ACTION CONTROLP
         CASE
           WHEN INFIELD(tc_pmc01)
              CALL cl_init_qry_var()       
            #  LET g_qryparam.state ="c"
              LET g_qryparam.form ="q_ima01"
              LET g_qryparam.default1 = g_tc_pmc[l_ac].tc_pmc01
              CALL cl_create_qry() RETURNING g_tc_pmc[l_ac].tc_pmc01              
              NEXT FIELD tc_pmc01        
           
           WHEN INFIELD(tc_pmc05)
              CALL cl_init_qry_var()       
             # LET g_qryparam.state ="c"
              LET g_qryparam.form ="q_gfe"
             LET g_qryparam.default1 = g_tc_pmc[l_ac].tc_pmc05
              CALL cl_create_qry() RETURNING g_tc_pmc[l_ac].tc_pmc05              
              NEXT FIELD tc_pmc05    
              
         END CASE
      }
 
        ON ACTION CONTROLN
            CALL i030_b_askkey()
            EXIT INPUT
 
        ON ACTION CONTROLO                        #沿用所有欄位
            IF INFIELD(tc_pmc01) AND l_ac > 1 THEN
                LET g_tc_pmc[l_ac].* = g_tc_pmc[l_ac-1].*
                NEXT FIELD tc_pmc01
            END IF
 
        ON ACTION CONTROLZ
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
            CALL cl_cmdask()
 
        ON ACTION CONTROLF
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
 
    CLOSE i030_bcl
    COMMIT WORK
END FUNCTION
 
FUNCTION i030_b_askkey()
    CLEAR FORM
    CALL g_tc_pmc.clear()
    CONSTRUCT g_wc2 ON tc_pmc01,tc_pmc02,tc_pmc03
            FROM s_tc_pmc[1].tc_pmc01,s_tc_pmc[1].tc_pmc02,s_tc_pmc[1].tc_pmc03
            
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
              #No.FUN-580031 --end--       HCN
     {         
      ON ACTION CONTROLP
         CASE
           WHEN INFIELD(tc_pmc01)
              CALL cl_init_qry_var()       
              LET g_qryparam.state ="c"
              LET g_qryparam.form ="q_ima01"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO tc_pmc01
              NEXT FIELD tc_pmc01 
              
             WHEN INFIELD(tc_pmc05)
              CALL cl_init_qry_var()       
              LET g_qryparam.state ="c"
              LET g_qryparam.form ="q_gfe"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO tc_pmc05
              NEXT FIELD tc_pmc05 
                     
         END CASE
         }
         
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
    LET g_wc2 = g_wc2 CLIPPED,cl_get_extra_cond(null, null) #FUN-980030
#No.TQC-710076 -- begin --
#    IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET g_wc2 = NULL
      RETURN
   END IF
#No.TQC-710076 -- end --
    CALL i030_b_fill(g_wc2)
END FUNCTION
 
FUNCTION i030_b_fill(p_wc2)              #BODY FILL UP
DEFINE
    p_wc2           LIKE type_file.chr1000       #No.FUN-680137
 
    LET g_sql =
        "SELECT tc_pmc01,tc_pmc02,tc_pmc03 ",
        " FROM tc_pmc_file",
        " WHERE ", p_wc2 CLIPPED,                     #單身
        " ORDER BY 1"
    PREPARE i030_pb FROM g_sql
    DECLARE tc_pmc_curs CURSOR FOR i030_pb
 
    CALL g_tc_pmc.clear()
    LET g_cnt = 1
    MESSAGE "Searching!" 
    FOREACH tc_pmc_curs INTO g_tc_pmc[g_cnt].*   #單身 ARRAY 填充
      IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
      LET g_cnt = g_cnt + 1
      
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
     
    END FOREACH
    CALL g_tc_pmc.deleteElement(g_cnt)
    MESSAGE ""
 
    LET g_rec_b = g_cnt-1
    DISPLAY g_rec_b TO FORMONLY.cn2  
    LET g_cnt = 0
 
END FUNCTION
 
FUNCTION i030_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_pmc TO s_tc_pmc.* ATTRIBUTE(COUNT=g_rec_b)
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ##########################################################################
      # Standard 4ad ACTION
      ##########################################################################
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
      ON ACTION output
         LET g_action_choice="output"
         EXIT DISPLAY
      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      ON ACTION controlg 
         LET g_action_choice="controlg"
         EXIT DISPLAY
 
   ON ACTION accept
      LET g_action_choice="detail"
      LET l_ac = ARR_CURR()
      EXIT DISPLAY
 
   ON ACTION cancel
             LET INT_FLAG=FALSE 		#MOD-570244	mars
      LET g_action_choice="exit"
      EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
   
   ON ACTION exporttoexcel       #FUN-4B0038
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
 
      # No.FUN-530067 --start--
      AFTER DISPLAY
         CONTINUE DISPLAY
      # No.FUN-530067 ---end---
 
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
#NO.FUN-7C0043---BEGIN

{
FUNCTION i030_out()
#   DEFINE
#       l_tc_pmc           RECORD LIKE tc_pmc_file.*,
#       l_i             LIKE type_file.num5,          #No.FUN-680137 SMALLINT
#       l_name          LIKE type_file.chr20                  # External(Disk) file name        #No.FUN-680137 VARCHAR(20)
  
    DEFINE l_cmd  LIKE type_file.chr1000
    IF g_wc2 IS NULL THEN                                                       
       CALL cl_err('','9057',0)                                                 
       RETURN                                                                   
    END IF                                                                      
    LET l_cmd = 'p_query "axmi030" "',g_wc2 CLIPPED,'"'                         
    CALL cl_cmdrun(l_cmd)
  
#   IF g_wc2 IS NULL THEN 
#      CALL cl_err('','9057',0) RETURN END IF
#   CALL cl_wait()
#   SELECT zo02 INTO g_company FROM zo_file WHERE zo01 = g_lang
#   FOR g_i = 1 TO g_len LET g_dash[g_i,g_i] = '=' END FOR
 
#   LET g_sql="SELECT * FROM tc_pmc_file ",          # 組合出 SQL 指令
#             " WHERE ",g_wc2 CLIPPED
#   PREPARE i030_p1 FROM g_sql                # RUNTIME 編譯
#   DECLARE i030_co                         # CURSOR
#       CURSOR FOR i030_p1
 
#   LET g_rlang = g_lang                               #FUN-4C0096 add
#   CALL cl_outnam('axmi030') RETURNING l_name         #FUN-4C0096 add
#   START REPORT i030_rep TO l_name
 
#   FOREACH i030_co INTO l_tc_pmc.*
#       IF SQLCA.sqlcode THEN
#           CALL cl_err('foreach:',SQLCA.sqlcode,1) 
#           EXIT FOREACH
#           END IF
#       OUTPUT TO REPORT i030_rep(l_tc_pmc.*)
#   END FOREACH
 
#   FINISH REPORT i030_rep
 
#   CLOSE i030_co
#   ERROR ""
#   CALL cl_prt(l_name,' ','1',g_len)
END FUNCTION
 
#REPORT i030_rep(sr)
#   DEFINE
#       l_trailer_sw    LIKE type_file.chr1,     #No.FUN-680137 VARCHAR(1)
#       sr RECORD LIKE tc_pmc_file.*
 
#  OUTPUT
#      TOP MARGIN g_top_margin
#      LEFT MARGIN g_left_margin
#      BOTTOM MARGIN g_bottom_margin
#      PAGE LENGTH g_page_line
 
#   ORDER BY sr.tc_pmc01
 
#   FORMAT
#       PAGE HEADER
#           PRINT COLUMN ((g_len-FGL_WIDTH(g_company CLIPPED))/2)+1,g_company CLIPPED
#           PRINT COLUMN ((g_len-FGL_WIDTH(g_x[1]))/2)+1,g_x[1]
#           LET g_pageno = g_pageno + 1
#           LET pageno_total = PAGENO USING '<<<','/pageno'
#           PRINT g_head CLIPPED, pageno_total
#           PRINT ''
 
#           PRINT g_dash[1,g_len]
#           PRINT g_x[31],
#                 g_x[32]
#           PRINT g_dash1
#           LET l_trailer_sw = 'y'
 
#       ON EVERY ROW
#           PRINT COLUMN g_c[31],sr.tc_pmc01,
#                 COLUMN g_c[32],sr.tc_pmc02 
 
#       ON LAST ROW
#           PRINT g_dash[1,g_len]
#           PRINT g_x[4] CLIPPED, COLUMN (g_len-9), g_x[7] CLIPPED #TQC-650082
#           LET l_trailer_sw = 'n'
 
#       PAGE TRAILER
#           IF l_trailer_sw = 'y' THEN
#               PRINT g_dash[1,g_len]
#               PRINT g_x[4] CLIPPED, COLUMN (g_len-9), g_x[6] CLIPPED #TQC-650082
#           ELSE
#               SKIP 2 LINE
#           END IF
#END REPORT
#NO.FUN-7C0043----END
#No.FUN-570109 --start--                                                                                                            
FUNCTION i030_set_entry_b(p_cmd)                                                                                                    
                                                                                                                                    
  DEFINE p_cmd   LIKE type_file.chr1                        #No.FUN-680137 VARCHAR(1)
                                                                                                                                    
  IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN                                                                               
     CALL cl_set_comp_entry("tc_pmc01",TRUE)                                                                                           
  END IF                                                                                                                            
                                                                                                                                    
END FUNCTION                                                                                                                        
                                                                                                                            
                                                                                                                                    
FUNCTION i030_set_no_entry_b(p_cmd)                                                                                                 
                                                                                                                                    
  DEFINE p_cmd   LIKE type_file.chr1                       #No.FUN-680137 VARCHAR(1)
                                                                                                                                    
   IF p_cmd = 'u' AND ( NOT g_before_input_done ) AND g_chkey='N' THEN                                                              
     CALL cl_set_comp_entry("tc_pmc01",FALSE)                                                                                          
   END IF                                                                                                                           
                                                                                                                                    
END FUNCTION  

}                                                                                                                         
#No.FUN-570109 --end--  
