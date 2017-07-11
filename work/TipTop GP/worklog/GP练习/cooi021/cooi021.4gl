# Prog. Version..: '5.30.06-1.0'     #
#
# Pattern name...: cooi021.4gl
# Descriptions...: TOP161011员工刷卡信息查询
# Date & Author..: 16/10/25 By TOP161011
# Modify.........: 16/10/25 建立程序

DATABASE ds
GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"

#定义所有单头、单身和系统需要的变量
		
										 
DEFINE g_stf   		   RECORD LIKE tc_stf_file.*,       
       g_stf_t       RECORD LIKE tc_stf_file.*,      
       g_stf_o       RECORD LIKE tc_stf_file.*,       
       g_stf01_t     LIKE tc_stf_file.tc_stf01,	

				g_spc         DYNAMIC ARRAY OF RECORD       		#员工刷卡（单身）
					tc_spc02				LIKE tc_spc_file.tc_spc02,			#序号
					tc_spc03				LIKE tc_spc_file.tc_spc03,			#日期
					tc_spc04				LIKE tc_spc_file.tc_spc04,			#时间
					tc_spc05				LIKE tc_spc_file.tc_spc05				#资料有效否
					              END RECORD,
				g_spc_t        RECORD									       		#员工刷卡（旧值）
					tc_spc02				LIKE tc_spc_file.tc_spc02,			#序号
					tc_spc03				LIKE tc_spc_file.tc_spc03,			#日期
					tc_spc04				LIKE tc_spc_file.tc_spc04,			#时间
					tc_spc05				LIKE tc_spc_file.tc_spc05				#资料有效否
					              END RECORD,
	      g_sql					STRING,                       		
	      g_wc          STRING,                     		  #单头CONSTRUCT结果
	      g_wc2         STRING,                       		#单身CONSTRUCT结果
	      g_rec_b       LIKE type_file.num5,         		  #单身笔数
	      l_ac          LIKE type_file.num5           		#目前处理的ARRAY CNT
	      
	      
DEFINE g_forupd_sql        STRING                  #SELECT ... FOR UPDATE  SQL
DEFINE g_curs_index        LIKE type_file.num10  	 #当前笔数
DEFINE g_row_count         LIKE type_file.num10    #总笔数 
DEFINE g_before_input_done LIKE type_file.num5   
DEFINE g_msg               LIKE ze_file.ze03      
DEFINE g_jump              LIKE type_file.num10    #查詢指定的筆數
DEFINE g_no_ask            LIKE type_file.num5     #是否開啟指定筆視窗  
DEFINE g_cnt               LIKE type_file.num10   
DEFINE g_chr               LIKE type_file.chr1  

MAIN
  OPTIONS                               
         INPUT NO WRAP
      DEFER INTERRUPT                       
   IF (NOT cl_user()) THEN                
      EXIT PROGRAM                        
   END IF
 
   WHENEVER ERROR CALL cl_err_msg_log    
 
   IF (NOT cl_setup("COO")) THEN          
      EXIT PROGRAM                       
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time           
   
   LET g_forupd_sql = "SELECT * FROM tc_stf_file WHERE tc_stf01 = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)           
   DECLARE i021_cl CURSOR FROM g_forupd_sql   
   
   OPEN WINDOW i021_w WITH FORM "coo/42f/cooi021"
         ATTRIBUTE (STYLE = g_win_style CLIPPED) 
   CALL cl_set_locale_frm_name("cooi021")          
   
   CALL cl_ui_init() 
   
   CALL i021_menu()
   
   CLOSE WINDOW i021
   
   CALL cl_used(g_prog,g_time,2) RETURNING g_time     #计算使用时间
   
   
END MAIN

FUNCTION i021_menu()	#菜单函数

	WHILE TRUE
		CALL i021_bp("G")
		CASE g_action_choice
				 WHEN "insert"
						IF cl_chk_act_auth() THEN
								CALL i021_a()
						END IF
				 WHEN "query"
						IF cl_chk_act_auth() THEN
								CALL i021_q()
						END IF
				 WHEN "delete"
						IF cl_chk_act_auth() THEN
								CALL i021_r()
						END IF
							
 				 WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL i021_u()
            END IF
 
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i021_b()
            ELSE
               LET g_action_choice = NULL
            END IF
 
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         WHEN "exporttoexcel"                       
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_spc),'','')
            END IF
 
      END CASE					
							
	END WHILE
END FUNCTION


FUNCTION i021_bp(p_ud)		#循环等待输入 
	DEFINE p_ud		LIKE type_file.chr1
	
	IF p_ud <> "G" OR g_action_choice = "detail" THEN
		RETURN
	END IF
	
	LET g_action_choice = " "
	
	CALL cl_set_act_visible("accept,cancel",FALSE)  #确认和取消按钮
	
	DISPLAY ARRAY g_spc TO s_spc.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
		
	BEFORE DISPLAY
		CALL cl_navigator_setting(g_curs_index,g_row_count)
		
	BEFORE ROW
		LET l_ac=ARR_CURR()
		CALL cl_show_fld_cont()
			
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
       
    ON ACTION first
    	CALL i021_fetch('F')
    	CALL cl_navigator_setting(g_curs_index,g_row_count)
    	CALL fgl_set_arr_curr(1)
    	ACCEPT DISPLAY
    	
		ON ACTION previous
       CALL i021_fetch('P')
       CALL cl_navigator_setting(g_curs_index, g_row_count)
       CALL fgl_set_arr_curr(1)
       ACCEPT DISPLAY   #FUN-530067(smin)

    ON ACTION jump
       CALL i021_fetch('/')
       CALL cl_navigator_setting(g_curs_index, g_row_count)
       CALL fgl_set_arr_curr(1)
       ACCEPT DISPLAY   #FUN-530067(smin)

    ON ACTION next
       CALL i021_fetch('N')
       CALL cl_navigator_setting(g_curs_index, g_row_count)
       CALL fgl_set_arr_curr(1)
       ACCEPT DISPLAY   #FUN-530067(smin)

    ON ACTION last
       CALL i021_fetch('L')
       CALL cl_navigator_setting(g_curs_index, g_row_count)
       CALL fgl_set_arr_curr(1)
       ACCEPT DISPLAY   #FUN-530067(smin)      

    ON ACTION detail
       LET g_action_choice="detail"
       LET l_ac = 1
       EXIT DISPLAY

    ON ACTION help
       LET g_action_choice="help"
       EXIT DISPLAY
 	
	  ON ACTION locale
       CALL cl_dynamic_locale()
       CALL cl_show_fld_cont()                    

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
       LET INT_FLAG=FALSE                         
       LET g_action_choice="exit"
       EXIT DISPLAY

    ON IDLE g_idle_seconds
       CALL cl_on_idle()
       CONTINUE DISPLAY
       
	  ON ACTION about         
	     CALL cl_about()    

	  ON ACTION exporttoexcel                             
       LET g_action_choice = 'exporttoexcel'
       EXIT DISPLAY
       
    AFTER DISPLAY
   		CONTINUE DISPLAY 
   		
   	ON ACTION controls                            
       CALL cl_set_head_visible("","AUTO")      

    ON ACTION related_document                    
       LET g_action_choice="related_document"          
       EXIT DISPLAY   
       
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION i021_a()	#录入

	CLEAR FORM
	CALL g_spc.clear()
	LET g_wc = NULL
	LET g_wc2 = NULL
	
	IF s_shut(0) THEN
      RETURN
  END IF
  
  INITIALIZE g_stf.* LIKE tc_stf_file.*	#***初始化
  
  LET g_stf01_t = NULL
  
  LET g_stf_t.* = g_stf.*
  CALL cl_opmsg('a')
  
   WHILE TRUE
    	LET g_stf.tc_stfuser=g_user
    	LET g_stf.tc_stfgrup=g_grup
    	LET g_stf.tc_stfdate=g_today
    	LET g_stf.tc_stfacti='Y'              

	    CALL i021_i("a")                   

	    IF INT_FLAG THEN                   
	       INITIALIZE g_stf.* TO NULL
	       LET INT_FLAG = 0
	       CALL cl_err('',9001,0)
	       EXIT WHILE
	    END IF

	   { IF cl_null(g_stf.tc_stf01) THEN       
	       CONTINUE WHILE
	    END IF ***}
	    
			INSERT INTO tc_stf_file VALUES (g_stf.*)
			IF SQLCA.sqlcode THEN
				CALL cl_err3("ins","tc_stf_file",g_stf.tc_stf01,"",SQLCA.sqlcode,"","",0)	
				CONTINUE WHILE
			ELSE
				SELECT tc_stf01 INTO g_stf.tc_stf01 FROM tc_stf_file WHERE tc_stf01 = g_stf.tc_stf01
			END IF

	    LET g_rec_b = 0  
	    CALL i021_b()                                     #单身
      EXIT WHILE
   END WHILE 
END FUNCTION

FUNCTION i021_i(p_cmd)	#单头
 	 DEFINE l_n         LIKE type_file.num5    
   DEFINE p_cmd       LIKE type_file.chr1     #a是输入，u是更改 
   
   IF s_shut(0) THEN
      RETURN
   END IF
   
   DISPLAY BY NAME 
   g_stf.tc_stfacti,
   g_stf.tc_stfuser,
   g_stf.tc_stfgrup,
   g_stf.tc_stfmodu,
   g_stf.tc_stfdate
   
   CALL cl_set_head_visible("","YES") 
   
   INPUT BY NAME
    g_stf.tc_stf01,
   	g_stf.tc_stf02,
   	g_stf.tc_stf03,
		g_stf.tc_stf04,
		g_stf.tc_stf05,
		g_stf.tc_stf06
       WITHOUT DEFAULTS
       
     BEFORE INPUT
         LET g_before_input_done = FALSE
         CALL i021_set_entry(p_cmd)
         CALL i021_set_no_entry(p_cmd)
         LET g_before_input_done = TRUE
     
     AFTER FIELD tc_stf01  #带出姓名
     
     IF NOT cl_null(g_stf.tc_stf01) THEN
     	IF p_cmd = "a" OR (p_cmd = "u" AND g_stf.tc_stf01 != g_stf01_t) THEN   #新增或者修改的时候
						SELECT count(*) INTO l_n FROM tc_stf_file WHERE tc_stf01 = g_stf.tc_stf01
						IF  l_n > 0 THEN 
							CALL cl_err(g_stf.tc_stf01,-239,1)
							NEXT FIELD tc_stf01 	
     	                  END IF
     	                  CALL i021_tc_stf012gen02('d')
     	                  NEXT FIELD tc_stf02
       END IF
      END IF
     
     AFTER FIELD tc_stf03	 #大于0
     
     IF g_stf.tc_stf03<=0 THEN
     	CALL cl_err(g_stf.tc_stf03,19876,1)
     	NEXT FIELD tc_stf03
     END IF
     
     AFTER FIELD tc_stf05	 #卡号不为空
				IF NOT cl_null(g_stf.tc_stf04) THEN
					IF cl_null(g_stf.tc_stf05) THEN
						CALL cl_err(g_stf.tc_stf05,-100,1)
						NEXT FIELD tc_stf05
					END IF
				END IF		
				
     AFTER INPUT 
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLG
         CALL cl_cmdask()
 
    {  ON ACTION CONTROLF                  
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name 
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) }
 
      ON ACTION controlp		#开窗
         CASE
					WHEN INFIELD(tc_stf01)
						CALL cl_init_qry_var()
						LET g_qryparam.form = "cq_gen2"
						LET g_qryparam.default1 = g_stf.tc_stf01
						CALL cl_create_qry() RETURNING g_stf.tc_stf01
						DISPLAY BY NAME g_stf.tc_stf01
						NEXT FIELD tc_stf01
            OTHERWISE EXIT CASE
          END CASE
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121  
         
   END INPUT
END FUNCTION

FUNCTION i021_cs()  #抓取查询条件
   DEFINE lc_qbe_sn   LIKE gbm_file.gbm01
   
   CLEAR FORM
   CALL g_spc.clear()
   		
       INITIALIZE g_stf.* TO NULL 
       
      CONSTRUCT BY NAME g_wc 		#*** 将查询条件（单头输入的内容）放到g_wc中
      	ON tc_stf01,tc_stf02,tc_stf03,tc_stf04,tc_stf05,tc_stf06			# 单头查询条件
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
 
         ON ACTION controlp
            CASE
               WHEN INFIELD(tc_stf01) #员工编号   开窗
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="cq_gen2"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO tc_stf01
                  NEXT FIELD tc_stf01
      
               OTHERWISE EXIT CASE
            END CASE
      
         ON IDLE g_idle_seconds                         
            CALL cl_on_idle()                           
            CONTINUE CONSTRUCT
      
         ON ACTION about       
            CALL cl_about()   
      
         ON ACTION help         
            CALL cl_show_help() 
      
         ON ACTION controlg    
            CALL cl_cmdask()
      
         ON ACTION qbe_select                           
            CALL cl_qbe_list() RETURNING lc_qbe_sn      
            CALL cl_qbe_display_condition(lc_qbe_sn)    
 
      END CONSTRUCT
      
      

      IF INT_FLAG THEN
         RETURN
      END IF
 
       CONSTRUCT g_wc2 ON tc_spc02,tc_spc03,tc_spc04,tc_spc05			#抓取单身条件
              FROM s_spc[1].tc_spc02,s_spc[1].tc_spc03,s_spc[1].tc_spc04,s_spc[1].tc_spc05  #FUN-650191
 
         BEFORE CONSTRUCT
            CALL cl_qbe_display_condition(lc_qbe_sn)    #
   
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
 
 
   IF g_wc2 = " 1=1" THEN                  # 未输入查询条件
      LET g_sql = "SELECT  tc_stf01 FROM tc_stf_file ",
                  " WHERE ", g_wc CLIPPED,
                  " ORDER BY tc_stf01"			
   ELSE                                   #输入查询条件
      LET g_sql = "SELECT UNIQUE tc_stf_file. tc_stf01 ",
                  "  FROM tc_stf_file, tc_spc_file ",
                  " WHERE tc_stf01 = tc_spc01",
                  "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                  " ORDER BY tc_stf01"
                  
   END IF
 
   PREPARE i021_prepare FROM g_sql
   DECLARE i021_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR i021_prepare
 
   IF g_wc2 = " 1=1" THEN                  # 查询资料笔数
      LET g_sql="SELECT COUNT(*) FROM tc_stf_file WHERE ",g_wc CLIPPED
   ELSE
      LET g_sql="SELECT COUNT(DISTINCT tc_stf01) FROM tc_stf_file,tc_spc_file WHERE ",
                "tc_spc01=tc_stf01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
   END IF
 
   PREPARE i021_precount FROM g_sql
   DECLARE i021_count CURSOR FOR i021_precount
END FUNCTION

FUNCTION i021_q() #查询

   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   MESSAGE ""
   CALL cl_opmsg('q')
   CLEAR FORM 
   CALL g_spc.clear()
   DISPLAY ' ' TO FORMONLY.cnt        #清空总笔数
   
   CALL i021_cs()
   
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE g_stf.* TO NULL
      RETURN
   END IF
   
   OPEN i021_cs                            # 
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_stf.* TO NULL
   ELSE
      OPEN i021_count
      FETCH i021_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
 
      CALL i021_fetch('F')                  # 回到第一笔
   END IF
   
END FUNCTION

FUNCTION i021_r()	#删除
   IF s_shut(0) THEN
      RETURN
   END IF
   IF g_stf.tc_stf01 IS NULL THEN
      CALL cl_err("",-400,0)
      RETURN
   END IF

   SELECT * INTO g_stf.* FROM tc_stf_file
   WHERE stf01=g_stf.tc_stf01

 BEGIN WORK
      OPEN i021_cl USING g_stf.tc_stf01

    IF STATUS THEN
        CALL cl_err("OPEN i252_cl:", STATUS, 1)
        CLOSE i021_cl
        ROLLBACK WORK
        RETURN
   END IF
   
   FETCH i021_cl INTO g_stf.* #锁住将被更改或取消的数据

   IF SQLCA.sqlcode THEN
      CALL cl_err(g_stf.tc_stf01,SQLCA.sqlcode,0)#资料被他人LOCK
      ROLLBACK WORK
      RETURN
   END IF

   CALL i021_show()

  IF cl_delh(0,0) THEN          #询问是否删除此笔资料
      INITIALIZE g_doc.* TO NULL
      LET g_doc.column1 = " tc_stf01"
      LET g_doc.value1 = g_stf.tc_stf01 

       CALL cl_del_doc()

      DELETE FROM tc_stf_file WHERE tc_stf01 =g_stf.tc_stf01  #单头单身数据一并删除
      DELETE FROM tc_spc_file  WHERE tc_spc01 = g_stf.tc_stf01

      CLEAR FORM   #删除后将画面清空
      CALL g_spc.clear()

      OPEN i021_count  #重新计算总笔数      
      
       IF STATUS THEN
         CLOSE i021_cs
         CLOSE i021_count
         COMMIT WORK
         RETURN
      END IF
            
      FETCH i021_count INTO g_row_count
      
      IF STATUS OR (cl_null(g_row_count) OR  g_row_count = 0 ) THEN
         CLOSE i021_cs
         CLOSE i021_count
         COMMIT WORK
         RETURN
      END IF
      
      DISPLAY g_row_count TO FORMONLY.cnt

      OPEN i021_cs
      
      IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL i021_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET g_no_ask = TRUE
         CALL i021_fetch('/')
      END IF
   END IF
   
   CLOSE i021_cl
   COMMIT WORK
   CALL cl_flow_notify(g_stf.tc_stf01,'D')     # 透过JavaMail 传送工作流程通知

END FUNCTION

FUNCTION i021_u()	#修改 	
  IF s_shut(0) THEN
       RETURN
   END IF

   IF cl_null(g_stf.tc_stf01) THEN
       CALL cl_err('',-400,0)
       RETURN
   END IF

   SELECT * INTO g_stf.* FROM tc_stf_file
   WHERE tc_stf01=g_stf.tc_stf01

   IF g_stf.tc_stfacti ='N' THEN                     #检查资料是否为无效
       CALL cl_err(g_stf.tc_stf01,'mfg1000',0)
       RETURN
   END IF

   MESSAGE " "
   CALL cl_opmsg('u')
   LET g_stf01_t = g_stf.tc_stf01

   BEGIN WORK

   OPEN i021_cl USING g_stf.tc_stf01
   IF STATUS THEN
      CALL cl_err("OPEN i021cl:", STATUS, 1)
      CLOSE i021_cl
      ROLLBACK WORK
      RETURN
   END IF

   FETCH i021_cl INTO g_stf.*                # 锁住将被更改或取消的数据
   IF SQLCA.sqlcode THEN
       CALL cl_err(g_stf.tc_stf01,SQLCA.sqlcode,0)# 资料被他人LOCK
       CLOSE i021_cl
       ROLLBACK WORK
       RETURN
   END IF

   CALL i021_show()
   
   WHILE TRUE
      LET g_stf01_t = g_stf.tc_stf01
      LET g_stf_o.* = g_stf.*
     LET g_stf.tc_stfuser=g_user
    	LET g_stf.tc_stfgrup=g_grup
    	LET g_stf.tc_stfdate=g_today
    	LET g_stf.tc_stfacti='Y'   
      #LET g)pmw.pmw07 = g_pmw07
      

      CALL i021_i("u")                      #字段更改

      IF INT_FLAG THEN
          LET INT_FLAG = 0
          LET g_stf.*=g_stf_t.*
          CALL i021_show()
          CALL cl_err('','9001',0)
          EXIT WHILE
      END IF
      
      IF g_stf.tc_stf01 != g_stf01_t THEN            # 更改单号
         UPDATE tc_spc_file SET tc_spc01 = g_stf.tc_stf01
          WHERE tc_spc01 = g_stf01_t
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
            CALL cl_err3("upd","tc_spc_file",g_stf01_t,"",SQLCA.sqlcode,"","tc_spc",1)  #No.FUN-660129
            CONTINUE WHILE
         END IF
      END IF

      UPDATE tc_stf_file SET tc_stf_file.* = g_stf.*
       WHERE tc_stf01 = g_stf01_t  
    
    IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
       CALL cl_err3("upd","tc_stf_file","","",SQLCA.sqlcode,"","",1)
       CONTINUE WHILE
    END IF
    EXIT WHILE
     {WHERE ROWID = g_pmw_rowid         #***?
    IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
       CALL cl_err3("upd","tc_stf_file","","",SQLCA.sqlcode,"","",1)
       CONTINUE WHILE
    END IF
    EXIT WHILE}
 END WHILE

 CLOSE i021_cl
 COMMIT WORK
 CALL cl_flow_notify(g_stf.tc_stf01,'U')
 CALL i021_b_fill("1=1")

END FUNCTION

FUNCTION i021_fetch(p_flag)  #调到指定笔数
DEFINE p_flag          LIKE type_file.chr1

   CASE p_flag
      WHEN 'N' FETCH NEXT     i021_cs INTO g_stf.tc_stf01
      WHEN 'P' FETCH PREVIOUS i021_cs INTO g_stf.tc_stf01
      WHEN 'F' FETCH FIRST    i021_cs INTO g_stf.tc_stf01
      WHEN 'L' FETCH LAST     i021_cs INTO g_stf.tc_stf01
      WHEN '/'
            IF (NOT g_no_ask) THEN      #No.FUN-6A0067
                CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0
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
            FETCH ABSOLUTE g_jump i021_cs INTO g_stf.tc_stf01
            LET g_no_ask = FALSE     #No.FUN-6A0067
   END CASE
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_stf.tc_stf01,SQLCA.sqlcode,0)
      INITIALIZE g_stf.* TO NULL               #No.FUN-6A0162
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
      CALL cl_navigator_setting( g_curs_index, g_row_count )
      DISPLAY g_curs_index TO FORMONLY.idx                    #No.FUN-4A0089
   END IF
 
   SELECT * INTO g_stf.* FROM tc_stf_file WHERE tc_stf01 = g_stf.tc_stf01
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","tc_stf_file","","",SQLCA.sqlcode,"","",1)  #No.FUN-660129
      INITIALIZE g_stf.* TO NULL
      RETURN
   END IF
 
   LET g_data_owner = g_stf.tc_stfuser      #FUN-4C0056 add
   LET g_data_group = g_stf.tc_stfgrup      #FUN-4C0056 add
 
   CALL i021_show() 
END FUNCTION


FUNCTION i021_show()  #显示查询的数据 

LET g_stf_t.* = g_stf.*                #保存單頭舊值
#   DISPLAY BY NAME g_stf.*			# 显示该record的所有值显示到画面，用*代替了
   DISPLAY BY NAME 						# 显示该record的所有值显示到画面
   	g_stf.tc_stf01,
   	g_stf.tc_stf02,
   	g_stf.tc_stf03,
   	g_stf.tc_stf04,
   	g_stf.tc_stf05,
   	g_stf.tc_stf06,
   	g_stf.tc_stfacti,
   	g_stf.tc_stfuser,
   	g_stf.tc_stfgrup,
   	g_stf.tc_stfmodu,
   	g_stf.tc_stfdate   	
 
   CALL i021_tc_stf012gen02('d')		# 显示出tc_stf01 带出来的gen02的值
   CALL i021_b_fill(g_wc2)                 #單身 
   CALL cl_show_fld_cont()
END FUNCTION



FUNCTION i021_b_fill(p_wc2)                 #單身SHOW，单身填充/显示函数
DEFINE p_wc2   STRING
 
   LET g_sql = "SELECT tc_spc02,tc_spc03,tc_spc04,tc_spc05 FROM tc_spc_file",    #No.FUN-550019
               " WHERE tc_spc01 ='",g_stf.tc_stf01,"' "   #單頭
 
   IF NOT cl_null(p_wc2) THEN
      LET g_sql=g_sql CLIPPED," AND ",p_wc2 CLIPPED
   END IF
   LET g_sql=g_sql CLIPPED," ORDER BY tc_spc02"
#   DISPLAY g_sql
 
   PREPARE i021_pb FROM g_sql
   DECLARE i021_spc_cs CURSOR FOR i021_pb
 
   CALL g_spc.clear()
   LET g_cnt = 1
 
   FOREACH i021_spc_cs INTO g_spc[g_cnt].*   #單身 ARRAY 填充
       IF SQLCA.sqlcode THEN
          CALL cl_err('foreach:',SQLCA.sqlcode,1)
          EXIT FOREACH
       END IF
       LET g_cnt = g_cnt + 1
        IF g_cnt > g_max_rec THEN
            CALL cl_err("", 9035, 1)
            EXIT FOREACH
        END IF
  END FOREACH
   CALL g_spc.deleteElement(g_cnt)
 
   LET g_rec_b=g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0

END FUNCTION

FUNCTION i021_b()	#单身！！！
DEFINE
    l_ac_t          LIKE type_file.num5,                #未取消的ARRAY CNT  
    l_n             LIKE type_file.num5,                #檢查重複用  
    l_n1            LIKE type_file.num5,        
    l_n2            LIKE type_file.num5,        
    l_n3            LIKE type_file.num5,         
    l_cnt           LIKE type_file.num5,                #檢查重複用 
    l_lock_sw       LIKE type_file.chr1,                #單身鎖住否 
    p_cmd           LIKE type_file.chr1,                #處理狀態  
    l_allow_insert  LIKE type_file.num5,                #可新增否  
    l_allow_delete  LIKE type_file.num5                #可刪除否  
 
 		LET g_action_choice = ""
		
    IF s_shut(0) THEN			# 判斷目前系統是否可使用
       RETURN
    END IF
 
    IF g_stf.tc_stf01 IS NULL THEN
       RETURN
    END IF
 
    SELECT * INTO g_stf.* FROM tc_stf_file
     WHERE tc_stf01=g_stf.tc_stf01		#重新抓取数据
 
    IF g_stf.tc_stfacti ='N' THEN    #檢查資料是否為無效
       CALL cl_err(g_stf.tc_stf01,'mfg1000',0)
       RETURN
    END IF
 
    CALL cl_opmsg('b')		#告诉程序现在正在执行单身
 
    LET g_forupd_sql = "SELECT tc_spc02,tc_spc03,tc_spc04,tc_spc05",#No.FUN-930061 add ''
                       " FROM tc_spc_file",
                       " WHERE tc_spc01 = ?"," AND tc_spc02 = ?"," FOR UPDATE"  
    LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
    DECLARE i021_bcl CURSOR FROM g_forupd_sql      # 单身资料LOCK CURSOR
 
    LET l_allow_insert = cl_detail_input_auth("insert") #单身新增权限设定
    LET l_allow_delete = cl_detail_input_auth("delete") #单身删除权限设定
 
    INPUT ARRAY g_spc WITHOUT DEFAULTS FROM s_spc.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)
 
        BEFORE INPUT
#           DISPLAY "BEFORE INPUT!"
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac) #将光标定位到l_ac
           END IF
 
        BEFORE ROW
#           DISPLAY "BEFORE ROW!"
           LET p_cmd = ''									#清空p_cmd
           LET l_ac = ARR_CURR()					#光标位置给行标
           LET l_lock_sw = 'N'            #DEFAULT
           LET l_n  = ARR_COUNT()					#总笔数
 
           BEGIN WORK
 
           OPEN i021_cl USING g_stf.tc_stf01		# 锁定单头
# i021_cl  SELECT * FROM tc_stf_file WHERE tc_stf01 = ? FOR UPDATE          
           IF STATUS THEN
              CALL cl_err("OPEN i021_cl:", STATUS, 1)
              CLOSE i021_cl
              ROLLBACK WORK
              RETURN
           END IF						#如果没有问题就继续，有问题就ROLLBACK
 
           FETCH i021_cl INTO g_stf.*            # 鎖住將被更改或取消的資料
           IF SQLCA.sqlcode THEN
              CALL cl_err(g_stf.tc_stf01,SQLCA.sqlcode,0)      # 資料被他人LOCK
              CLOSE i021_cl					#关闭cursor
              ROLLBACK WORK					#回滚
              RETURN								#返回上一级
           END IF
 
           IF g_rec_b >= l_ac THEN		#总笔数>=当前笔数 说明是更改！
              LET p_cmd = 'u'
              LET g_spc_t.* = g_spc[l_ac].*  #BACKUP
              OPEN i021_bcl USING g_stf.tc_stf01,g_spc_t.tc_spc02
              IF STATUS THEN
                 CALL cl_err("OPEN i021_bcl:", STATUS, 1)
                 LET l_lock_sw = "Y"
              ELSE
                 FETCH i021_bcl INTO g_spc[l_ac].*
                 IF SQLCA.sqlcode THEN
                    CALL cl_err(g_spc_t.tc_spc02,SQLCA.sqlcode,1)
                    LET l_lock_sw = "Y"
                 END IF
 
             END IF
              CALL cl_show_fld_cont()     #FUN-550037(smin)
              CALL i021_set_entry_b(p_cmd)    #No.FUN-610018
              CALL i021_set_no_entry_b(p_cmd) #No.FUN-610018
           END IF
 
        BEFORE INSERT
#          DISPLAY "BEFORE INSERT!"
           LET l_n = ARR_COUNT()
           LET p_cmd = 'a'
           INITIALIZE g_spc[l_ac].* TO NULL      #900423
           LET g_spc_t.* = g_spc[l_ac].*         #新輸入資料
           LET g_spc[l_ac].tc_spc05 = 1
           
           CALL cl_show_fld_cont()         #FUN-550037(smin)
           CALL i021_set_entry_b(p_cmd)    #No.FUN-610018
           CALL i021_set_no_entry_b(p_cmd) #No.FUN-610018
           NEXT FIELD tc_spc02
 
        AFTER INSERT
#           DISPLAY "AFTER INSERT!"
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)		#此笔资料放弃录入或更改
              LET INT_FLAG = 0
              CANCEL INSERT
           END IF
           
           INSERT INTO tc_spc_file(tc_spc01,tc_spc02,tc_spc03,tc_spc04,tc_spc05)
          		 VALUES(g_stf.tc_stf01,
          		 				g_spc[l_ac].tc_spc02,
          		 				g_spc[l_ac].tc_spc03,
          		 				g_spc[l_ac].tc_spc04,
          		 				g_spc[l_ac].tc_spc05)         		 				
           IF SQLCA.sqlcode THEN
              CALL cl_err3("ins","tc_spc_file",g_stf.tc_stf01,g_spc[l_ac].tc_spc02,SQLCA.sqlcode,"","",1)  #No.FUN-660129
              CANCEL INSERT
           ELSE
   #           MESSAGE 'INSERT O.K'
              COMMIT WORK
              LET g_rec_b=g_rec_b+1
              DISPLAY g_rec_b TO FORMONLY.cn2
           END IF
 
        BEFORE FIELD tc_spc02
        	IF (g_spc[l_ac].tc_spc02 IS NULL) OR (g_spc[l_ac].tc_spc02 = 0) THEN
        		SELECT MAX(tc_spc02) + 1 INTO g_spc[l_ac].tc_spc02 
        		FROM tc_spc_file WHERE tc_spc01 = g_stf.tc_stf01
        		IF g_spc[l_ac].tc_spc02 IS NULL THEN
        			LET g_spc[l_ac].tc_spc02 = 1
        		END IF
        	END IF                      

        AFTER FIELD tc_spc02
        	IF NOT cl_null(g_spc[l_ac].tc_spc02) THEN
						IF (g_spc[l_ac].tc_spc02 != g_spc_t.tc_spc02)
							OR (g_spc_t.tc_spc02 IS NULL) THEN
                    SELECT COUNT(*) INTO l_n FROM tc_spc_file WHERE tc_spc01 = g_stf.tc_stf01 AND tc_spc02 = g_spc[l_ac].tc_spc02
                    IF l_n > 0 THEN
                        LET g_spc[l_ac].tc_spc02 = g_spc_t.tc_spc02
                        CALL cl_err("", -239, 0)
                        NEXT FIELD tc_spc02
                    END IF
                END IF
					END IF
					
				AFTER FIELD tc_spc03
						IF cl_null(g_spc[l_ac].tc_spc03) THEN
							CALL cl_err(g_spc[l_ac].tc_spc03,-100,1)
							NEXT FIELD tc_spc03
						END IF
					
				AFTER FIELD tc_spc04
						IF cl_null(g_spc[l_ac].tc_spc04) THEN
							CALL cl_err(g_spc[l_ac].tc_spc04,-100,1)
							NEXT FIELD tc_spc04
						END IF
						
        BEFORE DELETE
            IF (g_spc_t.tc_spc02 > 0) AND (g_spc_t.tc_spc02 IS NOT NULL) THEN
                IF NOT cl_delb(0, 0) THEN
                    CANCEL DELETE
                END IF
                IF l_lock_sw == "Y" THEN
                    CALL cl_err("", -263, 1) #资料已经被锁住, 无法更改!请离开程序,稍后再进行资料处理!
                    CANCEL DELETE
                END IF
                DELETE FROM tc_spc_file WHERE tc_spc01 = g_stf.tc_stf01 AND tc_spc02 = g_spc_t.tc_spc02
                IF SQLCA.SQLCODE THEN
                    CALL cl_err3("del", "tc_spc_file", g_stf.tc_stf01, g_spc_t.tc_spc02, SQLCA.SQLCODE, "", "", 1)
                    ROLLBACK WORK
                    CANCEL DELETE
                END IF
                LET g_rec_b = g_rec_b - 1
                DISPLAY g_rec_b TO cn2
            END IF
            COMMIT WORK
            
        ON ROW CHANGE
            IF INT_FLAG THEN
                LET INT_FLAG = FALSE
                LET g_spc[l_ac].* = g_spc_t.*
                CLOSE i021_bcl
                ROLLBACK WORK
                CALL cl_err("", 9001, 0) #此笔资料放弃录入或更改 !
                EXIT INPUT
            END IF
            IF l_lock_sw = "Y" THEN
                CALL cl_err(g_spc[l_ac].tc_spc02, -263, 1) #资料已经被锁住, 无法更改!请离开程序,稍后再进行资料处理!
                LET g_spc[l_ac].* = g_spc_t.*
            ELSE
                UPDATE tc_spc_file SET tc_spc02 = g_spc[l_ac].tc_spc02,
                                       tc_spc03 = g_spc[l_ac].tc_spc03,
                                       tc_spc04 = g_spc[l_ac].tc_spc04,
                                       tc_spc05 = g_spc[l_ac].tc_spc05
                    WHERE tc_spc01 = g_stf.tc_stf01 AND tc_spc02 = g_spc_t.tc_spc02
                IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] == 0 THEN
                    LET g_spc[l_ac].* = g_spc_t.*
                    CALL cl_err3("upd", "tc_spc_file", g_stf.tc_stf01, g_spc_t.tc_spc02, SQLCA.SQLCODE, "", "", 1)
                ELSE
                    COMMIT WORK
                END IF
            END IF
            
        AFTER ROW
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
                LET INT_FLAG = FALSE
                CALL cl_err("", 9001, 0)
                IF p_cmd == "u" THEN
                    LET g_spc[l_ac].* = g_spc_t.*
                ELSE
                    CALL g_spc.deleteElement(l_ac)
                    IF g_rec_b != 0 THEN
                        LET g_action_choice = "detail"
                        LET l_ac = l_ac_t
                    END IF
                END IF
                CLOSE i021_bcl
                ROLLBACK WORK
                EXIT INPUT
            END IF
            LET l_ac_t = l_ac
            CLOSE i021_bcl
            COMMIT WORK							
				 
        ON ACTION CONTROLO                        #沿用所有欄位
           IF INFIELD(tc_spc02) AND l_ac > 1 THEN
              LET g_spc[l_ac].* = g_spc[l_ac-1].*
              LET g_spc[l_ac].tc_spc02 = g_rec_b + 1
              NEXT FIELD tc_spc02
           END IF
 
        ON ACTION CONTROLR
           CALL cl_show_req_fields()
 
        ON ACTION CONTROLG
           CALL cl_cmdask()
  
     { ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913}
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121
 
      ON ACTION controls                           #No.FUN-6B0032             
         CALL cl_set_head_visible("","AUTO")       #No.FUN-6B0032
    END INPUT
 
    LET g_stf.tc_stfmodu = g_user
    LET g_stf.tc_stfdate = g_today
    UPDATE tc_stf_file SET tc_stfmodu = g_stf.tc_stfmodu,tc_stfdate = g_stf.tc_stfdate
     WHERE tc_stf01 = g_stf.tc_stf01
    DISPLAY BY NAME g_stf.tc_stfmodu,g_stf.tc_stfdate
 
    CLOSE i021_bcl
    COMMIT WORK
END FUNCTION

FUNCTION i021_set_entry(p_cmd)
	DEFINE p_cmd				LIKE type_file.chr1
	
	IF p_cmd = 'a' AND (NOT g_before_input_done) THEN
		CALL cl_set_comp_entry("tc_stf01",TRUE)
	END IF
END FUNCTION

FUNCTION i021_set_no_entry(p_cmd)
	DEFINE p_cmd				LIKE type_file.chr1
	
	IF p_cmd = 'u' AND g_chkey = 'N' THEN			# g——chkey #是否允許更改KEY
		CALL cl_set_comp_entry("tc_stf01",FALSE)
	END IF	
END FUNCTION

FUNCTION i021_set_entry_b(p_cmd)    
    DEFINE p_cmd LIKE type_file.chr1
END FUNCTION


FUNCTION i021_set_no_entry_b(p_cmd) 
    DEFINE p_cmd LIKE type_file.chr1
END FUNCTION


FUNCTION i021_tc_stf012gen02(p_cmd)  #带出员工姓名
DEFINE l_gen02   LIKE gen_file.gen02,
               p_cmd     LIKE type_file.chr1

    SELECT gen02 INTO l_gen02 FROM gen_file
        WHERE gen01=g_stf.tc_stf01
        
    IF p_cmd ='d' THEN
    	    DISPLAY l_gen02 TO FORMONLY.gen02
    END IF

END FUNCTION