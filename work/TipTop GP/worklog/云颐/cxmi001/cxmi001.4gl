# Prog. Version..: '5.10.03-08.08.20(00009)'     #
# Pattern name...: cxmi001.4gl
# Descriptions...: 簽核人員i
# Date & Author..: 17/09/30 lixwz
# USD料件价格维护作业

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE
	  g_tc_ohi01         LIKE tc_ohi_file.tc_ohi01,
    g_tc_ohi01_t       LIKE tc_ohi_file.tc_ohi01,

    g_tc_ohi DYNAMIC ARRAY OF RECORD LIKE tc_ohi_file.*,
          #tc_ohi01    LIKE tc_ohi_file.tc_ohi01,
          #tc_ohi02    LIKE tc_ohi_file.tc_ohi02,
          #tc_ohi021   LIKE tc_ohi_file.tc_ohi021,
          #tc_ohi03    LIKE tc_ohi_file.tc_ohi03,
          #tc_ohi04    LIKE tc_ohi_file.tc_ohi04,
          #tc_ohi05    LIKE tc_ohi_file.tc_ohi05,
          #tc_ohi06    LIKE tc_ohi_file.tc_ohi06,
          #tc_ohi07    LIKE tc_ohi_file.tc_ohi07,
          #tc_ohi08    LIKE tc_ohi_file.tc_ohi08,
          #tc_ohi09    LIKE tc_ohi_file.tc_ohi09,
          #tc_ohi10    LIKE tc_ohi_file.tc_ohi10,
          #tc_ohi11    LIKE tc_ohi_file.tc_ohi11,
          #tc_ohi13    LIKE tc_ohi_file.tc_ohi13,
          #tc_ohi14    LIKE tc_ohi_file.tc_ohi14,
          #tc_ohi15    LIKE tc_ohi_file.tc_ohi15
          #      END RECORD,
    g_tc_ohi_o         RECORD LIKE tc_ohi_file.*,
    g_tc_ohi_t         RECORD LIKE tc_ohi_file.*,
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
   LET g_forupd_sql = "SELECT * FROM tc_ohi_file WHERE tc_ohi01=? FOR UPDATE"  #FUN-9C0163 ADD
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i001_cl CURSOR FROM g_forupd_sql
   }

   LET p_row = 3 LET p_col = 3
   OPEN WINDOW i001_w AT p_row,p_col
     WITH FORM "cxm/42f/cxmi001" ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN

   CALL cl_ui_init()
   CALL i001_show()
   CALL i001_menu()

   CLOSE WINDOW i001_w                 #結束畫面

   CALL cl_used(g_prog,g_time,2)       #計算使用時間 (退出使間) #No.MOD-580088  HCN 20050818 #NO.FUN-6A0094
      RETURNING g_time                                  #NO.FUN-6A0094
END MAIN

FUNCTION i001_cs()
   DEFINE  lc_qbe_sn       LIKE    gbm_file.gbm01    #No.FUN-580031  HCN
   DEFINE l_sql STRING

   CLEAR FORM                             #清除畫面
   CALL g_tc_ohi.clear()
   CALL cl_set_head_visible("","YES")       #No.FUN-6A0092

   #INITIALIZE g_tc_ohi01 TO NULL      #No.FUN-750051


   CONSTRUCT g_wc ON tc_ohi01,tc_ohi02,tc_ohi021,tc_ohi03,tc_ohi04,tc_ohi05,
   				      tc_ohi06,tc_ohi07,tc_ohi08,tc_ohi09,tc_ohi10,
   				      tc_ohi11,tc_ohi12,tc_ohi13,tc_ohi14,tc_ohi15
           FROM s_tc_ohi[1].tc_ohi01,s_tc_ohi[1].tc_ohi02,s_tc_ohi[1].tc_ohi021,s_tc_ohi[1].tc_ohi03,
           	    s_tc_ohi[1].tc_ohi04,s_tc_ohi[1].tc_ohi05,s_tc_ohi[1].tc_ohi06,
           	    s_tc_ohi[1].tc_ohi07,s_tc_ohi[1].tc_ohi08,s_tc_ohi[1].tc_ohi09,
           	    s_tc_ohi[1].tc_ohi10,s_tc_ohi[1].tc_ohi11,s_tc_ohi[1].tc_ohi12,
           	    s_tc_ohi[1].tc_ohi13,s_tc_ohi[1].tc_ohi14,s_tc_ohi[1].tc_ohi15

		#No.FUN-580031 --start--     HCN
		BEFORE CONSTRUCT
		   CALL cl_qbe_display_condition(lc_qbe_sn)
      #ON ACTION CONTROLP
      #   CASE
      #      WHEN INFIELD(tc_ohi02)
      #         CALL cl_init_qry_var()
      #         LET g_qryparam.form = "q_gen"
      #         LET g_qryparam.state = 'c'
      #         CALL cl_create_qry() RETURNING g_qryparam.multiret
      #         DISPLAY g_qryparam.multiret TO tc_ohi02
      #         NEXT FIELD tc_ohi02
#
      #      OTHERWISE
      #         EXIT CASE
      #   END CASE

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

   LET g_sql = " FROM tc_ohi_file WHERE ",g_wc CLIPPED

   LET l_sql = "select count(*) ",g_sql
   LET g_sql_tmp= l_sql

   LET g_sql = "select tc_ohi01 ",g_sql," ORDER BY tc_ohi01"
   PREPARE i001_prepare FROM g_sql
   IF STATUS THEN
      CALL cl_err('pre',STATUS,1)
   END IF

   DECLARE i001_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR i001_prepare

   PREPARE i001_precount FROM l_sql
   IF STATUS THEN
      CALL cl_err('pre',STATUS,1)
   END IF

   DECLARE i001_count CURSOR FOR i001_precount

END FUNCTION

FUNCTION i001_menu()
   WHILE TRUE
      CALL i001_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL i001_a()
            END IF
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL i001_q()
            END IF
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL i001_r()
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               #CALL i001_u()
            END IF
    #------------------No.FUN-620009 add
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL i001_copy()
            END IF
    #------------------No.FUN-620009 end
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CALL i001_b()
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output"
            IF cl_chk_act_auth() THEN
              # CALL i001_out()
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"     #FUN-4B0038
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_tc_ohi),'','')
            END IF

        WHEN "notice"
						CALL notice()
      END CASE
   END WHILE
END FUNCTION

FUNCTION i001_q()

   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   #INITIALIZE g_tc_ohi01 TO NULL              #No.FUN-6A0020

   CALL cl_opmsg('q')
   MESSAGE ""
   CLEAR FORM
   DISPLAY '   ' TO FORMONLY.cnt
   CALL g_tc_ohi.clear()

   CALL i001_cs()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   OPEN i001_cs                            # 從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_tc_ohi01 TO NULL
   ELSE
      OPEN i001_count
      FETCH i001_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
      CALL i001_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF

END FUNCTION

FUNCTION i001_fetch(p_flag)
   DEFINE p_flag          LIKE type_file.chr1                  #處理方式        #No.FUN-680137 VARCHAR(1)

   CASE p_flag
      WHEN 'N' FETCH NEXT     i001_cs INTO g_tc_ohi01
      WHEN 'P' FETCH PREVIOUS i001_cs INTO g_tc_ohi01
      WHEN 'F' FETCH FIRST    i001_cs INTO g_tc_ohi01
      WHEN 'L' FETCH LAST     i001_cs INTO g_tc_ohi01
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
        FETCH ABSOLUTE g_jump i001_cs INTO g_tc_ohi01
        LET mi_no_ask = FALSE
   END CASE

   IF SQLCA.sqlcode THEN
      CALL cl_err(g_tc_ohi01,SQLCA.sqlcode,0)
      INITIALIZE g_tc_ohi01 TO NULL  #TQC-6B0105
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

   CALL i001_show()

END FUNCTION

FUNCTION i001_show()

   #LET g_tc_ohi01_t = g_tc_ohi01                #保存單頭舊值
   #DISPLAY g_tc_ohi01 to FORMONLY.tc_ohi01

	 IF cl_null(g_wc) THEN
	    CALL i001_b_fill("1=1")
	 ELSE
	   CALL i001_b_fill(g_wc)                 #單身
	 END IF

   CALL cl_show_fld_cont()                   #No.FUN-550037 hmf

END FUNCTION

FUNCTION i001_a()

   IF s_shut(0) THEN RETURN END IF

   MESSAGE ""
   CLEAR FORM
   #CALL g_tc_ohi.clear()
   CALL cl_opmsg('a')

   #LET g_rec_b = g_rec_b+1         #No.FUN-680064
   CALL i001_b()                   #輸入單身

END FUNCTION


#删除
FUNCTION i001_r()
   DEFINE l_chr LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF s_shut(0) THEN RETURN END IF

   IF cl_null(g_tc_ohi01) THEN
      CALL cl_err('',-400,0)
      RETURN
   END IF

   LET g_success = 'Y'
   BEGIN WORK

   CALL i001_show()

   IF cl_delh(20,16) THEN

      DELETE FROM tc_ohi_file WHERE tc_ohi01 = g_tc_ohi01

      IF SQLCA.SQLERRD[3] = 0 THEN
         CALL cl_err3("del","tc_ohi_file",g_tc_ohi01,"",SQLCA.sqlcode,"","No tc_ohi_file deleted",1)
         ROLLBACK WORK
         RETURN
      END IF

      CLEAR FORM
      CALL g_tc_ohi.clear()
      INITIALIZE g_tc_ohi01 TO NULL


      PREPARE i001_precount_x2 FROM g_sql_tmp  #No.TQC-720019
      EXECUTE i001_precount_x2                 #No.TQC-720019
      OPEN i001_count
      FETCH i001_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt

      OPEN i001_cs
      IF g_curs_index = g_row_count + 1 THEN
         LET g_jump = g_row_count
         CALL i001_fetch('L')
      ELSE
         LET g_jump = g_curs_index
         LET mi_no_ask = TRUE
         CALL i001_fetch('/')
      END IF

      MESSAGE ""
   END IF
   COMMIT WORK
END FUNCTION

FUNCTION i001_b()
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

   #IF g_tc_ohi01 IS NULL  THEN
   #   RETURN
   #END IF


   CALL cl_opmsg('b')

   LET g_forupd_sql = "SELECT * ",   #No.MOD-5A0455
     " FROM tc_ohi_file ",
     " WHERE tc_ohi01 = ? ",
     #" WHERE tc_ohi02 = ? ",
     " FOR UPDATE "
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i001_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR

   LET l_ac_t = 0
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")

   INPUT ARRAY g_tc_ohi WITHOUT DEFAULTS FROM s_tc_ohi.*
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
            LET g_tc_ohi_t.* = g_tc_ohi[l_ac].*  #BACKUP
            LET g_tc_ohi_o.* = g_tc_ohi[l_ac].*  #BACKUP
            BEGIN WORK

            CALL cl_show_fld_cont()     #FUN-550037(smin)
         END IF
         LET g_before_input_done = FALSE
         CALL i001_set_entry_b(p_cmd)
         CALL i001_set_no_entry_b(p_cmd)
         LET g_before_input_done = TRUE

      #AFTER FIELD tc_ohi01

      #******************

      AFTER INSERT
         IF cl_null(g_tc_ohi[l_ac].tc_ohi01) THEN
            NEXT FIELD tc_ohi01
         END IF
         LET g_i = 0
         SELECT COUNT(*) INTO g_i FROM tc_ohi_file
            WHERE tc_ohi01 = g_tc_ohi[l_ac].tc_ohi01
         IF g_i > 0 THEN
         CALL cl_err("违反唯一主键限制，请重新输入","!","1")
            NEXT FIELD tc_ohi01
         END IF
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            CANCEL INSERT
         END IF
         IF cl_null(g_tc_ohi01) THEN LET g_tc_ohi01=' ' END IF #FUN-790001 add
         INSERT INTO tc_ohi_file (tc_ohi01,tc_ohi02,tc_ohi021,tc_ohi03,tc_ohi04,tc_ohi05,
         						   tc_ohi06,tc_ohi07,tc_ohi08,tc_ohi09,tc_ohi10,
         						   tc_ohi11,tc_ohi12,tc_ohi13,tc_ohi14,tc_ohi15)
                        VALUES(g_tc_ohi[l_ac].tc_ohi01,g_tc_ohi[l_ac].tc_ohi02,g_tc_ohi[l_ac].tc_ohi021,g_tc_ohi[l_ac].tc_ohi03,
                               g_tc_ohi[l_ac].tc_ohi04,g_tc_ohi[l_ac].tc_ohi05,g_tc_ohi[l_ac].tc_ohi06,
                               g_tc_ohi[l_ac].tc_ohi07,g_tc_ohi[l_ac].tc_ohi08,g_tc_ohi[l_ac].tc_ohi09,
                               g_tc_ohi[l_ac].tc_ohi10,g_tc_ohi[l_ac].tc_ohi11,g_tc_ohi[l_ac].tc_ohi12,
                               g_tc_ohi[l_ac].tc_ohi13,g_tc_ohi[l_ac].tc_ohi14,g_tc_ohi[l_ac].tc_ohi15)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","tc_ohi_file",g_tc_ohi01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
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
         INITIALIZE g_tc_ohi[l_ac].* TO NULL      #900423
         LET g_tc_ohi_t.* = g_tc_ohi[l_ac].*         #新輸入資料
         LET g_tc_ohi_o.* = g_tc_ohi[l_ac].*         #新輸入資料

         LET g_before_input_done = FALSE
         CALL i001_set_entry_b(p_cmd)
         CALL i001_set_no_entry_b(p_cmd)
         LET g_before_input_done = TRUE
         CALL cl_show_fld_cont()     #FUN-550037(smin)
         NEXT FIELD tc_ohi02

      AFTER FIELD tc_ohi01
         #判断是否主键冲突
         LET g_i = 0
         IF NOT cl_null(g_tc_ohi[l_ac].tc_ohi01) THEN
           IF g_tc_ohi[l_ac].tc_ohi01 != g_tc_ohi_t.tc_ohi01 OR
              g_tc_ohi_t.tc_ohi01 IS NULL THEN
              SELECT COUNT(*) INTO g_i FROM tc_ohi_file
                WHERE tc_ohi01 = g_tc_ohi[l_ac].tc_ohi01
             IF g_i > 0 THEN
             CALL cl_err("违反唯一主键限制，请重新输入","!","1")
                NEXT FIELD tc_ohi01
             END IF
           END IF
           SELECT ima02,ima021,ima25
                INTO g_tc_ohi[l_ac].tc_ohi02,g_tc_ohi[l_ac].tc_ohi021,g_tc_ohi[l_ac].tc_ohi03
                FROM ima_file WHERE ima01=g_tc_ohi[l_ac].tc_ohi01
           DISPLAY BY NAME  g_tc_ohi[l_ac].tc_ohi02,g_tc_ohi[l_ac].tc_ohi021,g_tc_ohi[l_ac].tc_ohi03
        END IF

      BEFORE DELETE                            #是否取消單身
         IF g_tc_ohi_t.tc_ohi01 IS NOT NULL  THEN
            IF NOT cl_delete() THEN
               CANCEL DELETE
            END IF
            IF l_lock_sw = "Y" THEN
               CALL cl_err("", -263, 1)
               CANCEL DELETE
            END IF
            DELETE FROM tc_ohi_file                 #刪除單身
             WHERE  tc_ohi01 = g_tc_ohi[l_ac].tc_ohi01

            IF SQLCA.sqlcode THEN
               CALL cl_err3("del","tc_ohi_file",g_tc_ohi01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
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
            LET g_tc_ohi[l_ac].* = g_tc_ohi_t.*
            #CLOSE i001_cl
            ROLLBACK WORK
            EXIT INPUT
         END IF

         IF l_lock_sw = 'Y' THEN
            CALL cl_err(g_tc_ohi[l_ac].tc_ohi01,-263,1)
            LET g_tc_ohi[l_ac].* = g_tc_ohi_t.*
         ELSE
            UPDATE tc_ohi_file SET tc_ohi01=g_tc_ohi[l_ac].tc_ohi01,
            						           tc_ohi02=g_tc_ohi[l_ac].tc_ohi02,
                                   tc_ohi021=g_tc_ohi[l_ac].tc_ohi021,
                                	tc_ohi03=g_tc_ohi[l_ac].tc_ohi03,
                                	tc_ohi04=g_tc_ohi[l_ac].tc_ohi04,
                                  tc_ohi05=g_tc_ohi[l_ac].tc_ohi05
             WHERE tc_ohi01 = g_tc_ohi_t.tc_ohi01

            IF SQLCA.sqlcode THEN
#              CALL cl_err(g_tc_ohi[l_ac].tc_ohi03,-239,0)   #No.FUN-660167
               CALL cl_err3("upd","tc_ohi_file",g_tc_ohi01,"",SQLCA.sqlcode,"","",1)  #No.FUN-660167
               LET g_tc_ohi[l_ac].* = g_tc_ohi_t.*
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
               LET g_tc_ohi[l_ac].* = g_tc_ohi_t.*
            END IF
          #  CLOSE i001_cl
            ROLLBACK WORK
            EXIT INPUT
         END IF
        # CLOSE i001_cl
         COMMIT WORK

      ON ACTION CONTROLP
        CASE
           WHEN INFIELD(tc_ohi01)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "cq_ima1"
                LET g_qryparam.default1 = g_tc_ohi[l_ac].tc_ohi01
                CALL cl_create_qry() RETURNING  g_tc_ohi[l_ac].tc_ohi01,g_tc_ohi[l_ac].tc_ohi02,g_tc_ohi[l_ac].tc_ohi021
                 DISPLAY BY NAME g_tc_ohi[l_ac].tc_ohi01,g_tc_ohi[l_ac].tc_ohi02,g_tc_ohi[l_ac].tc_ohi021          #No.MOD-490371
            WHEN INFIELD(tc_ohi03)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_gfe"
                LET g_qryparam.default1 = g_tc_ohi[l_ac].tc_ohi03
                CALL cl_create_qry() RETURNING  g_tc_ohi[l_ac].tc_ohi03
                 DISPLAY BY NAME g_tc_ohi[l_ac].tc_ohi03          #No.MOD-490371
            WHEN INFIELD(tc_ohi04)
                CALL cl_init_qry_var()
                LET g_qryparam.form = "q_azi"
                LET g_qryparam.default1 = g_tc_ohi[l_ac].tc_ohi04
                CALL cl_create_qry() RETURNING  g_tc_ohi[l_ac].tc_ohi04
                 DISPLAY BY NAME g_tc_ohi[l_ac].tc_ohi04          #No.MOD-490371
           OTHERWISE
               EXIT CASE
        END CASE

      #BugNo:6638
      ON ACTION controls                             #No.FUN-6A0092
         CALL cl_set_head_visible("","AUTO")           #No.FUN-6A0092

      ON ACTION CONTROLO                        #沿用所有欄位
         IF INFIELD(tc_ohi02) AND l_ac > 1 THEN
            LET g_tc_ohi[l_ac].* = g_tc_ohi[l_ac-1].*
            NEXT FIELD tc_ohi03
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


   CLOSE i001_bcl

   IF g_success = 'Y' THEN
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF

   CALL i001_show()

END FUNCTION

FUNCTION i001_b_askkey()
DEFINE l_wc2           LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)

   CONSTRUCT l_wc2 ON tc_ohi01,tc_ohi02,tc_ohi021,tc_ohi03,tc_ohi04,tc_ohi05
              FROM s_tc_ohi[1].tc_ohi02,s_tc_ohi[1].tc_ohi021,s_tc_ohi[1].gen02,s_tc_ohi[1].tc_ohi03,s_tc_ohi[1].tc_ohi04
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

   CALL i001_b_fill(l_wc2)

END FUNCTION

FUNCTION i001_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           LIKE type_file.chr1000       #No.FUN-680137  VARCHAR(200)

   LET g_sql =
       "SELECT * ", #FUN-560193
       "  FROM tc_ohi_file ",
       " WHERE ", p_wc2 CLIPPED,                     #單身
       " ORDER BY 1"
   PREPARE i001_pb FROM g_sql
   IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
   DECLARE tc_ohi_curs CURSOR FOR i001_pb

   CALL g_tc_ohi.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH tc_ohi_curs INTO g_tc_ohi[g_cnt].*   #單身 ARRAY 填充
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

   CALL g_tc_ohi.deleteElement(g_cnt)
   LET g_rec_b=g_cnt-1
   DISPLAY g_rec_b TO FORMONLY.cn2
   LET g_cnt = 0

END FUNCTION

FUNCTION i001_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DISPLAY ARRAY g_tc_ohi TO s_tc_ohi.* ATTRIBUTE(COUNT=g_rec_b)

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
         CALL i001_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
           ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST

      ON ACTION previous
         CALL i001_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION jump
         CALL i001_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION next
         CALL i001_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
        ACCEPT DISPLAY                   #No.FUN-530067 HCN TEST


      ON ACTION last
         CALL i001_fetch('L')
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


      # No.FUN-530067 --start--
      AFTER DISPLAY
         CONTINUE DISPLAY
      # No.FUN-530067 ---end---


   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION


FUNCTION i001_set_entry(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF (NOT g_before_input_done) THEN
       CALL cl_set_comp_entry("tc_ohi01",TRUE)
   END IF

END FUNCTION

FUNCTION i001_set_no_entry(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF (NOT g_before_input_done) THEN
      IF p_cmd = 'u' AND g_chkey = 'N' THEN
         CALL cl_set_comp_entry("tc_ohi01",FALSE)
      END IF
   END IF

END FUNCTION

FUNCTION i001_set_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF (NOT g_before_input_done) THEN
      CALL cl_set_comp_entry("tc_ohi02",TRUE)
   END IF

END FUNCTION

FUNCTION i001_set_no_entry_b(p_cmd)
DEFINE   p_cmd     LIKE type_file.chr1          #No.FUN-680137 VARCHAR(1)

   IF (NOT g_before_input_done) THEN
      IF p_cmd = 'u' THEN
         CALL cl_set_comp_entry("gen02",FALSE)
      END IF
   END IF

END FUNCTION


FUNCTION i001_copy()

END FUNCTION

{
	未领取的人员，进行am通知
}
FUNCTION notice()
#	DEFINE l_msg   STRING,
#				 l_ac_t  LIKE type_file.num10,
#				 l_tc_ohi02 LIKE tc_ohi_file.tc_ohi02,
#				 l_count LIKE type_file.num10
#  DEFINE am_status,am_result    STRING
#
#	LET l_count=0
#	FOR l_ac_t=1 TO g_rec_b
#  		IF cl_null(g_tc_ohi[l_ac_t].tc_ohi04) or g_tc_ohi[l_ac_t].tc_ohi04="N" then
#	 			 LET l_msg= "亲爱的",g_tc_ohi[l_ac_t].gen02," ",g_tc_ohi01,
#	 			 	"您有一笔",g_tc_ohi[l_ac_t].tc_ohi03,"的油补金额，请及时领取，下月将自动作废"
#	 			 LET l_tc_ohi02=g_tc_ohi[l_ac_t].tc_ohi02
#      	 #CALL pdmSendToAM2(l_tc_ohi02,l_msg,"ERP","1") RETURNING am_status,am_result
#      	 CALL IDDSendMessage('text',l_tc_ohi02,l_msg) RETURNING am_status,am_result
#      	 LET l_count=l_count+1
#    	END IF
#  END FOR
#
#  MESSAGE l_count
END FUNCTION