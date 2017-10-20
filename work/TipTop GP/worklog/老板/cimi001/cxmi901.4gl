# Prog_ Version..: '5.20.02-10.08.05(00010)'     #
#
DATABASE ds
 
GLOBALS "../../config/top.global"
 
#模組變數(Module Variables)
DEFINE
		g_tc_cb01         LIKE tc_cb_file.tc_cb01,
    g_tc_cb01_t       LIKE tc_cb_file.tc_cb01,

    g_tc_cb           DYNAMIC ARRAY OF RECORD
        tc_cb02       LIKE tc_cb_file.tc_cb02,
        gen02       LIKE gen_file.gen02,
        tc_cb03       LIKE tc_cb_file.tc_cb03,
        tc_cb04       LIKE tc_cb_file.tc_cb04
                    END RECORD,
    g_tc_cb_o         RECORD
        tc_cb02       LIKE tc_cb_file.tc_cb02,
        gen02       LIKE gen_file.gen02,
        tc_cb03       LIKE tc_cb_file.tc_cb03,
        tc_cb04       LIKE tc_cb_file.tc_cb04
                    END RECORD,
    g_tc_cb_t         RECORD
        tc_cb02       LIKE tc_cb_file.tc_cb02,
        gen02       LIKE gen_file.gen02,
        tc_cb03       LIKE tc_cb_file.tc_cb03,
        tc_cb04       LIKE tc_cb_file.tc_cb04
     END RECORD,
   #g_wc,g_wc2,g_sql    LIKE type_file.chr1000,  #No.FUN-680137 VARCHAR(800)
    g_wc,g_wc2,g_sql    STRING,   #TQC-630166  
    g_wd                LIKE type_file.chr1,     #No.FUN-680137 VARCHAR(1)
    g_rec_b         LIKE type_file.num5,         #單身筆數     #No.FUN-680137 SMALLINT
    l_ac            LIKE type_file.num5          #目前處理的ARRAY CNT   #No.FUN-680137 SMALLINT

DEFINE p_row,p_col  LIKE type_file.num5          #No.FUN-680137 SMALLINT
 
#主程式開始
DEFINE g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL   
DEFINE g_sql_tmp    STRING   #No.TQC-720019
DEFINE   g_cnt           LIKE type_file.num10    #No.FUN-680137 INTEGER
DEFINE   g_i             LIKE type_file.num5     #count/index for any purpose  #No.FUN-680137 SMALLINT
DEFINE   g_msg           LIKE type_file.chr1000  #No.FUN-680137 VARCHAR(72)
DEFINE   g_before_input_done LIKE type_file.num5    #No.FUN-680137 SMALLINT
 
# 2004/02/06 by Hiko : 為了上下筆資料的控制而加的變數.
DEFINE   g_row_count    LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   g_curs_index   LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   g_jump         LIKE type_file.num10         #No.FUN-680137 INTEGER
DEFINE   mi_no_ask       LIKE type_file.num5         #No.FUN-680137 SMALLINT
 
MAIN
#   DEFINE l_time        LIKE type_file.chr8          #No.FUN-680137 VARCHAR(8) #NO.FUN-6A0094 
 
   OPTIONS
      INPUT NO WRAP
   DEFER INTERRUPT
 
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF
 
   CALL cl_used(g_prog,g_time,1)     #No.MOD-580088  HCN 20050818   #NO.FUN-6A0094
      RETURNING g_time                            #NO.FUN-6A0094 
 
   LET g_wd = " "
 
  {
   LET g_forupd_sql = "SELECT * FROM tc_cb_file WHERE tc_cb01=? FOR UPDATE"  #FUN-9C0163 ADD 
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i901_cl CURSOR FROM g_forupd_sql
   }
 
   LET p_row = 3 LET p_col = 3
   OPEN WINDOW i901_w AT p_row,p_col
     WITH FORM "cxm/42f/cxmi901" ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
 
   CALL cl_ui_init()
  
   CALL i901_menu()
 
   CLOSE WINDOW i901_w                 #結束畫面
 
   CALL cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818 #NO.FUN-6A0094 
      RETURNING g_time                                  #NO.FUN-6A0094 
END MAIN
 
FUNCTION i901_cs()
   DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
   DEFINE l_sql STRING
 
   CLEAR FORM                             #清除畫面
   CALL g_tc_cb.clear()
   CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
   INITIALIZE g_tc_cb01 TO NULL      #No.FUN-750051
   CONSTRUCT BY NAME g_wc ON tc_cb01
            
     BEFORE CONSTRUCT
        CALL cl_qbe_init()
            
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
		   CALL cl_qbe_list() RETURNING lc_qbe_sn
		   CALL cl_qbe_display_condition(lc_qbe_sn)
		#No.FUN-580031 --end--       HCN
   END CONSTRUCT
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
   CONSTRUCT g_wc2 ON tc_cb02,gen02,tc_cb03,tc_cb04
           FROM s_tc_cb[1].tc_cb02,s_tc_cb[1].gen02,s_tc_cb[1].tc_cb03,s_tc_cb[1].tc_cb04
 
		#No.FUN-580031 --start--     HCN
		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(tc_cb02)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_gen"
               LET g_qryparam.state = 'c'
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tc_cb02
               NEXT FIELD tc_cb02
        
            OTHERWISE
               EXIT CASE
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
 
      ON ACTION qbe_save
		       CALL cl_qbe_save()
   END CONSTRUCT
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
   IF g_wc2 = " 1=1" THEN
      LET g_sql = " FROM tc_cb_file WHERE ",g_wc CLIPPED
   ELSE
      LET g_sql = "  FROM tc_cb_file,gen_file",
                  " WHERE tc_cb02 = gen01 AND",g_wc CLIPPED,
                  " AND ",g_wc2 CLIPPED
   END IF
   
   LET l_sql = "select count(*) ",g_sql
   LET g_sql_tmp= l_sql
      
   LET g_sql = "select tc_cb01 ",g_sql," ORDER BY tc_cb01"
   PREPARE i901_prepare FROM g_sql
   IF STATUS THEN
      CALL cl_err('pre',STATUS,1)
   END IF
 
   DECLARE i901_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR i901_prepare
 
   PREPARE i901_precount FROM l_sql
   IF STATUS THEN
      CALL cl_err('pre',STATUS,1)
   END IF
 
   DECLARE i901_count CURSOR FOR i901_precount
 
END FUNCTION
 
FUNCTION i901_menu()
   WHILE TRUE
      CALL i901_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i901_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i901_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i901_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i901_u()
            END IF
    #------------------No.FUN-620009 add
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL i901_copy()
            END IF
    #------------------No.FUN-620009 end
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i901_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
              # CALL i901_out()
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_cb),'','')
            END IF
            
        WHEN "notice"
						CALL notice()
      END CASE
   END WHILE
END FUNCTION
 
FUNCTION i901_q()
 
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   INITIALIZE g_tc_cb01 TO NULL              #No.FUN-6A0020  
 
   CALL cl_opmsg('q')
   MESSAGE ""
   CLEAR FORM
   DISPLAY '   ' TO FORMONLY.cnt
   CALL g_tc_cb.clear()
 
   CALL i901_cs()
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
 
   OPEN i901_cs                            # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_tc_cb01 TO NULL
   ELSE
      OPEN i901_count
      FETCH i901_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
      CALL i901_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF
 
END FUNCTION
 
FUNCTION i901_fetch(p_flag)
   DEFINE p_flag          LIKE type_file.chr1                  #處理方式        #No.FUN-680137 VARCHAR(1)
 
   CASE p_flag
      WHEN 'N' FETCH NEXT     i901_cs INTO g_tc_cb01
      WHEN 'P' FETCH PREVIOUS i901_cs INTO g_tc_cb01
      WHEN 'F' FETCH FIRST    i901_cs INTO g_tc_cb01
      WHEN 'L' FETCH LAST     i901_cs INTO g_tc_cb01
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
        FETCH ABSOLUTE g_jump i901_cs INTO g_tc_cb01
        LET mi_no_ask = FALSE
   END CASE
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_cb01,SQLCA.sqlcode,0)
      INITIALIZE g_tc_cb01 TO NULL  #TQC-6B0105
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump          --改g_jump
      END CASE
 
      CALL cl_navigator_setting( g_curs_index, g_row_count )
   END IF

   CALL i901_show()
 
END FUNCTION
 
FUNCTION i901_show()

   LET g_tc_cb01_t = g_tc_cb01                #保存單頭舊值
   DISPLAY g_tc_cb01 to FORMONLY.tc_cb01

	 IF cl_null(g_wc2) THEN 
	    CALL i901_b_fill("1=1")
	 ELSE
	   CALL i901_b_fill(g_wc2)                 #單身
	 END IF
 
   CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
END FUNCTION
 
FUNCTION i901_a()
 
   IF s_shut(0) THEN RETURN END IF
 
   MESSAGE ""
   CLEAR FORM
   CALL g_tc_cb.clear()
   LET g_tc_cb01 = NULL
   LET g_tc_cb01_t = NULL
   CALL cl_opmsg('a')
 
   WHILE TRUE
  
      CALL i901_i("a")                   #輸入單頭
 
      IF INT_FLAG THEN                   #使用者不玩了
         LET INT_FLAG = 0
         CALL cl_err('',9001,0)
         EXIT WHILE
      END IF
 
      IF cl_null(g_tc_cb01) THEN    # KEY 不可空白
         CONTINUE WHILE
      END IF
 
      LET g_tc_cb01_t = g_tc_cb01
      CALL g_tc_cb.clear()
      LET g_rec_b=0                   #No.FUN-680064
      CALL i901_b()                   #輸入單身
 
      EXIT WHILE
   END WHILE
 
END FUNCTION
 
FUNCTION i901_i(p_cmd)
   DEFINE p_cmd           LIKE type_file.chr1,          #No.FUN-680137 VARCHAR(1)
          l_oah02         LIKE oah_file.oah02,
          l_n             LIKE type_file.num5,          #No.FUN-680137 SMALLINT
          nyStr STRING
   CALL cl_set_head_visible("","YES")       #No.FUN-6A0092
 
   INPUT g_tc_cb01 WITHOUT DEFAULTS FROM tc_cb01
 
      BEFORE INPUT
         LET g_before_input_done = FALSE
         CALL i901_set_entry(p_cmd)
         CALL i901_set_no_entry(p_cmd)
         LET g_before_input_done = TRUE
 
      AFTER FIELD tc_cb01
        IF NOT cl_null(g_tc_cb01) THEN
            IF p_cmd = 'a' OR
              (p_cmd = 'u' AND g_tc_cb01 != g_tc_cb01_t) THEN
               #必须为年月格式
               LET nyStr = g_tc_cb01
               IF nyStr.getLength()<>6 THEN
          				Message "长度必须为6位"
                  NEXT FIELD tc_cb01
               END IF 
            END IF
         END IF
 
     
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
 
   END INPUT
 
END FUNCTION
 
FUNCTION i901_u()
 
   IF s_shut(0) THEN RETURN END IF
 
   IF g_tc_cb01 IS NULL THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
 
   MESSAGE ""
   CALL cl_opmsg('u')
   LET g_tc_cb01_t = g_tc_cb01
 
   LET g_success = 'Y'
   BEGIN WORK
 
 {
   OPEN i901_cl USING g_tc_cb01
   IF STATUS THEN
      CALL cl_err("OPEN i901_cl:", STATUS, 1)
      CLOSE i901_cl
      ROLLBACK WORK
      RETURN
   END IF
   }
 
   CALL i901_show()
 
   WHILE TRUE
      LET g_tc_cb01_t = g_tc_cb01

      CALL i901_i("u")                      #欄位更改
 
      IF INT_FLAG THEN
         LET INT_FLAG = 0
          LET g_tc_cb01 = g_tc_cb01_t
         CALL i901_show()
         CALL cl_err('','9001',0)
         EXIT WHILE
      END IF
 
      IF g_tc_cb01 != g_tc_cb01_t  THEN
         UPDATE tc_cb_file SET tc_cb01 = g_tc_cb01 WHERE tc_cb01 = g_tc_cb01_t
         IF SQLCA.sqlcode THEN
            CALL cl_err3("upd","tc_cb_file",g_tc_cb01_t,"",SQLCA.sqlcode,"","upd tc_cb",1)  #No.FUN-660167
            ROLLBACK WORK
            RETURN
         END IF
      END IF
      EXIT WHILE
   END WHILE
 
   #CLOSE i901_cl
 
   IF g_success = 'Y' THEN
      COMMIT WORK
   END IF
 
END FUNCTION
 
#删除 
FUNCTION i901_r()
   DEFINE l_chr LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF s_shut(0) THEN RETURN END IF
 
   IF cl_null(g_tc_cb01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF
   
   LET g_success = 'Y'
   BEGIN WORK

   CALL i901_show()
 
   IF cl_delh(20,16) THEN
      
      DELETE FROM tc_cb_file WHERE tc_cb01 = g_tc_cb01

      IF SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("del","tc_cb_file",g_tc_cb01,"",SQLCA.sqlcode,"","No tc_cb_file deleted",1)
         ROLLBACK WORK
         RETURN
      END IF
 
      CLEAR FORM
      CALL g_tc_cb.clear()
      INITIALIZE g_tc_cb01 TO NULL
 
   
      PREPARE i901_precount_x2 FROM g_sql_tmp  #No.TQC-720019
      EXECUTE i901_precount_x2                 #No.TQC-720019
      OPEN i901_count
      FETCH i901_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
 
      OPEN i901_cs
      IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL i901_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET mi_no_ask = TRUE
         CALL i901_fetch('/')
      END IF
 
      MESSAGE ""
   END IF
   COMMIT WORK  
END FUNCTION
 
FUNCTION i901_b()
DEFINE l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT #No.FUN-680137 SMALLINT
       l_n             LIKE type_file.num5,                #檢查重複用        #No.FUN-680137 SMALLINT
       l_lock_sw       LIKE type_file.chr1,                #單身鎖住否        #No.FUN-680137 VARCHAR(1)
       p_cmd           LIKE type_file.chr1,                #處理狀態          #No.FUN-680137 VARCHAR(1)
       l_cmd           LIKE type_file.chr1000,             #No.FUN-680137  VARCHAR(60)
       l_flag          LIKE type_file.num5,                #No.FUN-680137 SMALLINT 
       l_i,l_cnt       LIKE type_file.num5,                #No.FUN-680137 SMALLINT
       l_s             LIKE type_file.num5,                #No.FUN-680137 SMALLINT
       l_allow_insert  LIKE type_file.num5,                #可新增否        #No.FUN-680137 SMALLINT
       l_allow_delete  LIKE type_file.num5                 #可刪除否        #No.FUN-680137 SMALLINT
#FUN-9C0163 ADD START--------------------
DEFINE
    l_ima31         LIKE ima_file.ima31,
    t_flag          LIKE type_file.chr1,
    l_fac           LIKE type_file.num20_6,
    l_msg           LIKE type_file.chr1000
#FUN-9C0163 ADD END-----------------------

 
   LET g_action_choice = ""
 
   IF s_shut(0) THEN RETURN END IF
 
   IF g_tc_cb01 IS NULL  THEN
      RETURN
   END IF
 

   CALL cl_opmsg('b')
 
   LET g_forupd_sql = "SELECT tc_cb02,'',tc_cb03,tc_cb04",   #No.MOD-5A0455
     " FROM tc_cb_file ",
     " WHERE tc_cb01 = ? ",
     " WHERE tc_cb02 = ? ",
     " FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i901_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   LET l_ac_t = 0
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
 
   INPUT ARRAY g_tc_cb WITHOUT DEFAULTS FROM s_tc_cb.*
         ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                   APPEND ROW=l_allow_insert)
 
      BEFORE INPUT
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
         LET l_lock_sw = 'N'            #DEFAULT
         LET l_n  = ARR_COUNT()
         LET g_success = 'Y'
 
         IF g_rec_b >= l_ac THEN
            LET p_cmd='u'
            LET g_tc_cb_t.* = g_tc_cb[l_ac].*  #BACKUP
            LET g_tc_cb_o.* = g_tc_cb[l_ac].*  #BACKUP
            BEGIN WORK
 
 						{
            OPEN i901_bcl USING g_tc_cb01,g_tc_cb[l_ac].tc_cb02
            IF STATUS THEN
               CALL cl_err("OPEN i901_bcl:", STATUS, 1)
               LET l_lock_sw = "Y"
            ELSE
               FETCH i901_bcl INTO g_tc_cb[l_ac].*
               IF SQLCA.sqlcode THEN
                  CALL cl_err(g_tc_cb_t.tc_cb03,SQLCA.sqlcode,1)
                  RETURN
                  LET l_lock_sw = "Y"
               END IF
              
            END IF
            }
            CALL cl_show_fld_cont()     #FUN-550037(smin)
         END IF
         LET g_before_input_done = FALSE
         CALL i901_set_entry_b(p_cmd)
         CALL i901_set_no_entry_b(p_cmd)
         LET g_before_input_done = TRUE
 
      AFTER INSERT
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         IF cl_null(g_tc_cb01) THEN LET g_tc_cb01=' ' END IF #FUN-790001 add
         INSERT INTO tc_cb_file (tc_cb01,tc_cb02,tc_cb03,tc_cb04)
                        VALUES(g_tc_cb01,
                               g_tc_cb[l_ac].tc_cb02,g_tc_cb[l_ac].tc_cb03,
                               g_tc_cb[l_ac].tc_cb04)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","tc_cb_file",g_tc_cb01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
            CANCEL INSERT
            LET g_success = 'N'
         ELSE
            MESSAGE 'INSERT O.K'
            IF g_success = 'Y' THEN
               COMMIT WORK
            END IF
            LET g_rec_b=g_rec_b+1
            DISPLAY g_rec_b TO FORMONLY.cn2
         END IF
 
      BEFORE INSERT
         LET l_n = ARR_COUNT()
         LET p_cmd='a'
         INITIALIZE g_tc_cb[l_ac].* TO NULL      #900423
         LET g_tc_cb_t.* = g_tc_cb[l_ac].*         #新輸入資料
         LET g_tc_cb_o.* = g_tc_cb[l_ac].*         #新輸入資料
     
         LET g_before_input_done = FALSE
         CALL i901_set_entry_b(p_cmd)
         CALL i901_set_no_entry_b(p_cmd)
         LET g_before_input_done = TRUE
         CALL cl_show_fld_cont()     #FUN-550037(smin)
         NEXT FIELD tc_cb02
 
    
 
      AFTER FIELD tc_cb02
         IF NOT cl_null(g_tc_cb[l_ac].tc_cb02) THEN
         	 SELECT COUNT(*) into l_n from gen_file where gen01=g_tc_cb[l_ac].tc_cb02
         	 IF l_n=0 THEN
         	 	  Message "该工号不存在"
         	 	  NEXT FIELD tc_cb02
         	 ELSE
         	    SELECT GEN02 into g_tc_cb[l_ac].gen02 from gen_file where gen01=g_tc_cb[l_ac].tc_cb02
           END IF
         ELSE
         	 NEXT FIELD tc_cb02
         END IF
 
      BEFORE DELETE                            #是否取消單身
         IF g_tc_cb_t.tc_cb02 IS NOT NULL  THEN
            IF NOT cl_delete() THEN
               CANCEL DELETE
            END IF
            IF l_lock_sw = "Y" THEN
               CALL cl_err("", -263, 1)
               CANCEL DELETE
            END IF
            DELETE FROM tc_cb_file                 #刪除單身
             WHERE tc_cb01 = g_tc_cb01 AND tc_cb02 = g_tc_cb[l_ac].tc_cb02
           
            IF SQLCA.sqlcode THEN
               CALL cl_err3("del","tc_cb_file",g_tc_cb01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
               ROLLBACK WORK
               CANCEL DELETE
            END IF

            LET g_rec_b=g_rec_b-1
            DISPLAY g_rec_b TO FORMONLY.cn2
         END IF
         IF g_success ='Y' THEN COMMIT WORK END IF
 
      ON ROW CHANGE
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            LET g_tc_cb[l_ac].* = g_tc_cb_t.*
            #CLOSE i901_cl
            ROLLBACK WORK
            EXIT INPUT
         END IF
 
         IF l_lock_sw = 'Y' THEN
            CALL cl_err(g_tc_cb[l_ac].tc_cb03,-263,1)
            LET g_tc_cb[l_ac].* = g_tc_cb_t.*
         ELSE
            UPDATE tc_cb_file SET tc_cb02=g_tc_cb[l_ac].tc_cb02,
                                tc_cb03=g_tc_cb[l_ac].tc_cb03,
                                tc_cb04=g_tc_cb[l_ac].tc_cb04
                              
             WHERE tc_cb01 = g_tc_cb01
               AND tc_cb02 = g_tc_cb_t.tc_cb02
              
            IF SQLCA.sqlcode THEN
#              CALL cl_err(g_tc_cb[l_ac].tc_cb03,-239,0)   #No.FUN-660167
               CALL cl_err3("upd","tc_cb_file",g_tc_cb01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
               LET g_tc_cb[l_ac].* = g_tc_cb_t.*
               LET g_success = 'N'
            ELSE
               MESSAGE 'UPDATE O.K'
               IF g_success = 'Y' THEN COMMIT WORK END IF
            END IF
         END IF
 
      AFTER ROW
         LET l_ac = ARR_CURR()
         LET l_ac_t = l_ac
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            IF p_cmd = 'u' THEN
               LET g_tc_cb[l_ac].* = g_tc_cb_t.*
            END IF
          #  CLOSE i901_cl
            ROLLBACK WORK
            EXIT INPUT
         END IF
        # CLOSE i901_cl
         COMMIT WORK
 
      ON ACTION CONTROLP
         CASE
            WHEN INFIELD(tc_cb02)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form = "q_gen"
                 LET g_qryparam.default1 = g_tc_cb[l_ac].tc_cb02
                 CALL cl_create_qry() RETURNING g_tc_cb[l_ac].tc_cb02
                  DISPLAY BY NAME g_tc_cb[l_ac].tc_cb03          #No.MOD-490371
           
            OTHERWISE
                EXIT CASE
         END CASE
 
      #BugNo:6638
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
 
      ON ACTION CONTROLO                        #沿用所有欄位
         IF INFIELD(tc_cb02) AND l_ac > 1 THEN
            LET g_tc_cb[l_ac].* = g_tc_cb[l_ac-1].*
            NEXT FIELD tc_cb03
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
 
   
   CLOSE i901_bcl
 
   IF g_success = 'Y' THEN
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF
 
   CALL i901_show()
 
END FUNCTION
 
FUNCTION i901_b_askkey()
DEFINE l_wc2           LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)
 
   CONSTRUCT l_wc2 ON tc_cb03,gen02,tc_cb03,tc_cb04
              FROM s_tc_cb[1].tc_cb02,s_tc_cb[1].gen02,s_tc_cb[1].tc_cb03,s_tc_cb[1].tc_cb04
              #No.FUN-580031 --start--     HCN
              BEFORE CONSTRUCT
                 CALL cl_qbe_init()
              #No.FUN-580031 --end--       HCN
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
 
   IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
 
   CALL i901_b_fill(l_wc2)
 
END FUNCTION
 
FUNCTION i901_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)
 
   LET g_sql =
       "SELECT tc_cb02,gen02,tc_cb03,tc_cb04", #FUN-560193
       "  FROM tc_cb_file LEFT OUTER JOIN gen_file ON tc_cb02=gen01",
       " WHERE tc_cb01 = '",g_tc_cb01, "'",
       " AND ", p_wc2 CLIPPED,                     #單身
       " ORDER BY 1"
   PREPARE i901_pb FROM g_sql
   IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
   DECLARE tc_cb_curs CURSOR FOR i901_pb
 
   CALL g_tc_cb.clear()
   LET g_cnt = 1
   LET g_rec_b = 0
 
   FOREACH tc_cb_curs INTO g_tc_cb[g_cnt].*   #單身 ARRAY 填充
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
 
   CALL g_tc_cb.deleteElement(g_cnt)
   LET g_rec_b=g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0
 
END FUNCTION
 
FUNCTION i901_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_cb TO s_tc_cb.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
 
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
 
      BEFORE ROW
         LET l_ac = ARR_CURR()
      CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
 
      ON ACTION insert
         LET g_action_choice="insert"
         EXIT DISPLAY
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DISPLAY
    #------------------No.FUN-620009 add
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DISPLAY
    #------------------No.FUN-620009 end
      ON ACTION first
         CALL i901_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION previous
         CALL i901_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION jump
         CALL i901_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION next
         CALL i901_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
      ON ACTION last
         CALL i901_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST
 
 
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
 
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
 
      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY
 
      ON ACTION cancel
         LET INT_FLAG=FALSE                 #MOD-570244 mars
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092
 
      ON ACTION exporttoexcel       #FUN-4B0038
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
       
      ON ACTION notice                #No.FUN-6A0020  相關文件
         LET g_action_choice="notice"          
         EXIT DISPLAY 
 
      # No.FUN-530067 --start--
      AFTER DISPLAY
         CONTINUE DISPLAY
      # No.FUN-530067 ---end---
 
 
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION
 
 
FUNCTION i901_set_entry(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF (NOT g_before_input_done) THEN
       CALL cl_set_comp_entry("tc_cb01",TRUE)
   END IF
 
END FUNCTION
 
FUNCTION i901_set_no_entry(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF (NOT g_before_input_done) THEN
      IF p_cmd = 'u' AND g_chkey = 'N' THEN
         CALL cl_set_comp_entry("tc_cb01",FALSE)
      END IF
   END IF
 
END FUNCTION
 
FUNCTION i901_set_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("tc_cb02",TRUE)
   END IF
 
END FUNCTION
 
FUNCTION i901_set_no_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)
 
   IF (NOT g_before_input_done) THEN
      IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry("gen02",FALSE)
      END IF
   END IF
 
END FUNCTION
 

FUNCTION i901_copy()

END FUNCTION

{
	未领取的人员，进行am通知
}
FUNCTION notice()
	DEFINE l_msg   STRING,
				 l_ac_t  LIKE type_file.num10,
				 l_tc_cb02 LIKE tc_cb_file.tc_cb02,
				 l_count LIKE type_file.num10
  DEFINE am_status,am_result    STRING  

	LET l_count=0
	FOR l_ac_t=1 TO g_rec_b
  		IF cl_null(g_tc_cb[l_ac_t].tc_cb04) or g_tc_cb[l_ac_t].tc_cb04="N" then
	 			 LET l_msg= "亲爱的",g_tc_cb[l_ac_t].gen02," ",g_tc_cb01,
	 			 	"您有一笔",g_tc_cb[l_ac_t].tc_cb03,"的油补金额，请及时领取，下月将自动作废"
	 			 LET l_tc_cb02=g_tc_cb[l_ac_t].tc_cb02
      	 #CALL pdmSendToAM2(l_tc_cb02,l_msg,"ERP","1") RETURNING am_status,am_result
      	 CALL IDDSendMessage('text',l_tc_cb02,l_msg) RETURNING am_status,am_result
      	 LET l_count=l_count+1
    	END IF
  END FOR	
  
  MESSAGE l_count
END FUNCTION