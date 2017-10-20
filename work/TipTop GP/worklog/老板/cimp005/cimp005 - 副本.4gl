# Prog. Version..: '5.10.03-08.08.20(00009)'     #
# Pattern name...: cimp005.4gl
# Descriptions...: 簽核人員
# Date & Author..: 17/09/26 zhengq
# 分销 ERP 集成退货

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE g_head  RECORD
  jcth_check   LIKE type_file.chr1  #分销 ERP 集成退货
END RECORD
DEFINE g_forupd_sql STRING
DEFINE g_sql    STRING
DEFINE g_before_input_done   LIKE type_file.num5          #判斷是否已執行 Before Input指令
DEFINE g_chr                 VARCHAR(1)
DEFINE g_cnt,l_ac            LIKE type_file.num10
DEFINE g_i                   LIKE type_file.num5
DEFINE g_msg                 LIKE type_file.chr1000
DEFINE g_curs_index          LIKE type_file.num10
DEFINE g_row_count           LIKE type_file.num10         #總筆數
DEFINE g_jump                LIKE type_file.num10         #查詢指定的筆數
DEFINE mi_no_ask             LIKE type_file.num5          #是否開啟指定筆視窗
DEFINE g_posdbs              LIKE type_file.chr10
DEFINE g_auto_storage_cost   LIKE imn_file.imn15   #成本仓库
DEFINE g_auto_storage_uncost LIKE imn_file.imn15   #非成本仓库
DEFINE g_date                LIKE type_file.chr10

DEFINE g_argv1     LIKE type_file.chr1
DEFINE g_argv2     LIKE type_file.chr2
DEFINE g_argv3     LIKE type_file.chr3
DEFINE g_argv4     LIKE type_file.chr4
DEFINE g_argv5     LIKE type_file.chr5
DEFINE g_argv6     LIKE type_file.chr6
DEFINE g_argv7     LIKE type_file.chr7
DEFINE g_having    LIKE type_file.num5
DEFINE g_in_work   LIKE type_file.chr1         #add by leo 130320

MAIN
    OPTIONS
        FORM LINE     FIRST + 2,               #畫面開始的位置
        MESSAGE LINE  LAST,                    #訊息顯示的位置
        PROMPT LINE   LAST,                    #提示訊息的位置
        INPUT NO WRAP                          #輸入的方式: 不打轉
    DEFER INTERRUPT                            #擷取中斷鍵

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CIM")) THEN
      EXIT PROGRAM
   END IF

   CALL  cl_used(g_prog,g_time,1) RETURNING g_time
   LET g_bgjob=ARG_VAL(1)
   LET g_argv2=ARG_VAL(2)
	 INITIALIZE g_head.* TO NULL

   LET g_date = g_today USING "YYYYMMDD"

   IF g_bgjob = 'Y' THEN
	   LET g_head.jcth_check = g_argv2
	   #直接运行更新函数
	   CALL autoUpdate()
   ELSE
	   OPEN WINDOW p005_w  WITH FORM "cim/42f/cimp005"
	       ATTRIBUTE (STYLE = g_win_style CLIPPED)
	   CALL cl_ui_init()
	   LET g_action_choice = ""
	   #初始化全局变量
	   LET g_head.jcth_check = 'N'
	   CALL p005_menu()
	   CLOSE WINDOW p005_w
	 END IF
   CALL  cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION p005_menu()
   DEFINE l_cmd  LIKE type_file.chr1000
    MENU ""
        BEFORE MENU
           CALL cl_navigator_setting(g_curs_index, g_row_count)

        ON ACTION modify
             CALL p005_i()

        ON ACTION  download_up
             IF cl_sure(18,20) THEN
             		CALL autoUpdate()
             END IF
        ON ACTION close
            LET INT_FLAG=FALSE
            EXIT MENU

        ON ACTION help
           CALL cl_show_help()
        ON ACTION exit
           EXIT MENU
        ON ACTION controlg
           CALL cl_cmdask()
        ON ACTION locale
           CALL cl_dynamic_locale()
           CALL cl_show_fld_cont()
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE MENU
    END MENU
END FUNCTION

{负责从界面构造g_head}
FUNCTION p005_i()
   DEFINE   p_cmd     LIKE type_file.chr1,
            l_n       LIKE type_file.num5

   LET g_head.jcth_check = 'N'

   DISPLAY BY NAME g_head.jcth_check

   INPUT BY NAME g_head.jcth_check WITHOUT DEFAULTS

      BEFORE INPUT

      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLG
         CALL cl_cmdask()

      ON ACTION CONTROLF                        # 欄位說明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      ON ACTION about
         CALL cl_about()

      ON ACTION help
         CALL cl_show_help()

   END INPUT
END FUNCTION

{
	desc:自动执行的核心函数，
	1.根据参数判断对应的功能是否执行
	2.g_msg在对应的子函数中进行设置
	3.将g_msg保存到日志表中
	author:zhengq
	date:2016/11/11
	input:null
	return:null
}
FUNCTION autoUpdate()
# 分销 ERP 集成退货

END FUNCTION