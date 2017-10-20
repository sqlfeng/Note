# Prog. Version..: '1.10.02-05.03.31(00000)'     #
#
# Pattern name...: aimt324.4gl
# Descriptions...: 库存直接调拨作业
# Date & Author..: 95/04/25 by Nick
# Modify.........: 单阶调拨
#                  By Melody    新增'是否立即列印'功能    
# Modify.......... 97/06/20 By Melody  调拨作业改为 insert 两笔至 tlf_file     
#                                      且来源目的码分别为 50:99, 99:50
# Modify.........: 97/07/24 By Melody CHECK sma894 是否库存可扣至负数           
# Modify.........: No:7698 03/08/06 By Mandy 在修改拨出仓库时未重算拨入的换算率,拨入量,导致库存错误!
# Modify.........: No:BUG-490218 04/09/13 by yiting ima02,ima021定义方式使用like
# Modify.........: No.BUG-490371 04/09/22 By Yuna Controlp 未加display
# Modify.........: No.FUN-4A0052 04/10/06 By Yuna 单据编号开窗
# Modify.........: No.BUG-4A0054 04/10/07 By Nicola 当拨入仓库为新的料+仓时,于拨入仓栏时,使用 [往下键]会跳开 insert img动作!
# Modify.........: No.FUN-4B0002 04/11/02 By Mandy 新增Array转Excel档功能
# Modify.........: No:BUG-4B0071 04/11/19 By Smapmin 新增拨入仓库与拨出仓库开窗功能
# Modify.........: No:BUG-4B0249 04/11/26 By Mandy 用上下笔游标,到下一笔(此笔是没资料的没新增)又往上移时会出县mfg1401 message
# Modify.........: No:FUN-4C0053 04/12/08 By Mandy Q,U,R 加入权限控管处理
# Modify.........: No:BUG-530705 05/03/29 By kim 仓库间直接调拨应可进行非成本仓间之调拨
# Modify.........: Modified By Johnson 06/03/01 增加部门(借用拨入人员栏位imm13)
# Modify.........: Modified By xf 120408 增加核销逻辑
# Modify.........: No:120425     12/04/25 By yangjian 使用字段immud05 ,退货类型
# Modify.........: No.160406 16/04/06 By zhangbo 根据A1价格条件取厂价,取不到再用W1取一次
# Modify.........: No.160416 16/04/16 By zhangbo 增加电商渠道退货原因
# Modify.........: No.160718 16/07/18 By zhangbo 渠道退货流程重新梳理,增加渠道退货类型immud19和渠道平台的单号immud20,
#                                                以及申请退货数量imnud08

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

#模组变数(Module Variables)
DEFINE 
    g_imm   RECORD  LIKE imm_file.*,
    g_imm_t RECORD  LIKE imm_file.*,
    g_imm_o RECORD  LIKE imm_file.*,
    b_imn   RECORD  LIKE imn_file.*,
    g_imm_rowid CHAR(18),               #ROWID
    g_yy,g_mm       SMALLINT,              #
    g_imn03_t       LIKE imn_file.imn03,
    t_imn04         LIKE imn_file.imn04,
    t_imn05         LIKE imn_file.imn05,
    t_imn15         LIKE imn_file.imn15,
    t_imn16         LIKE imn_file.imn16,
    t_imf04         LIKE imf_file.imf04,
    t_imf05         LIKE imf_file.imf05,
    g_imn           DYNAMIC ARRAY OF RECORD    #程式变数(Prinram Variables)
	            imn02     LIKE imn_file.imn02,
	            imnud04   LIKE imn_file.imnud04,   #No:120425    
                    imn03     LIKE imn_file.imn03,
                    ima02     LIKE ima_file.ima02, #No:BUG-490218
                    ima021    LIKE ima_file.ima021, #No:BUG-490218
                    imn28     LIKE imn_file.imn28,
                    imn04     LIKE imn_file.imn04,
                    imn05     LIKE imn_file.imn05,
                    imn06     LIKE imn_file.imn06,
                    imn09     LIKE imn_file.imn09,
                    imn15     LIKE imn_file.imn15,
                    imn16     LIKE imn_file.imn16,
                    imn17     LIKE imn_file.imn17,
                    imn20     LIKE imn_file.imn20,
                    imnud08   LIKE imn_file.imnud08,       #No.160718
                    imn10     LIKE imn_file.imn10,
                    imn22     LIKE imn_file.imn22,
                    imn21     LIKE imn_file.imn21,
                    imnud21   LIKE imn_file.imnud21        #No.160416 
                    END RECORD,
    g_imn_t   RECORD
	            imn02     LIKE imn_file.imn02,
	            imnud04   LIKE imn_file.imnud04,   #No:120425    
                    imn03     LIKE imn_file.imn03,
                    ima02     LIKE ima_file.ima02, #No:BUG-490218
                    ima021    LIKE ima_file.ima021, #No:BUG-490218
                    imn28     LIKE imn_file.imn28,
                    imn04     LIKE imn_file.imn04,
                    imn05     LIKE imn_file.imn05,
                    imn06     LIKE imn_file.imn06,
                    imn09     LIKE imn_file.imn09,
                    imn15     LIKE imn_file.imn15,
                    imn16     LIKE imn_file.imn16,
                    imn17     LIKE imn_file.imn17,
                    imn20     LIKE imn_file.imn20,
                    imnud08   LIKE imn_file.imnud08,       #No.160718
                    imn10     LIKE imn_file.imn10,
                    imn22     LIKE imn_file.imn22,
                    imn21     LIKE imn_file.imn21,
                    imnud21   LIKE imn_file.imnud21        #No.160416 
                    END RECORD,
    g_x ARRAY[25] OF    VARCHAR(40),
    g_wc,g_wc2,g_sql    VARCHAR(300),
	h_qty			LIKE ima_file.ima271,
    g_t1            VARCHAR(3),
    g_buf           VARCHAR(20),
    sn1,sn2         SMALLINT,
    l_code          SMALLINT,
    g_rec_b         SMALLINT,              #单身笔数
    g_void          VARCHAR(1),
    l_ac            SMALLINT,              #目前处理的ARRAY CNT
    g_debit,g_credit    LIKE img_file.img26,
    g_ima25,g_ima25_2   LIKE ima_file.ima25,
    g_ima86,g_ima86_2   LIKE ima_file.ima86,
    g_img10,g_img10_2   LIKE img_file.img10,
    g_argv1	 VARCHAR(10),	   #单号
    g_cmd               VARCHAR(100)
DEFINE p_row,p_col      SMALLINT
DEFINE g_forupd_sql         STRING   #SELECT ... FOR UPDATE NOWAIT SQL
DEFINE g_before_input_done  SMALLINT

DEFINE   g_chr           VARCHAR(1)
DEFINE   g_cnt           INTEGER   
DEFINE   g_i             SMALLINT   #count/index for any purpose
DEFINE   g_msg           LIKE type_file.chr1000


DEFINE   g_row_count    INTEGER
DEFINE   g_curs_index   INTEGER
DEFINE   g_jump         INTEGER
DEFINE   mi_no_ask       SMALLINT

#add by zhangbo120709----------------begin-----------------------
DEFINE  l_show_msg      DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
        imn01       LIKE imn_file.imn01,   #
        imn02       LIKE imn_file.imn02,
        imn10       LIKE imn_file.imn10,
        tc_rec05    LIKE tc_rec_file.tc_rec05
                   END RECORD
DEFINE g_msg2       LIKE type_file.chr1000
#add by zhangbo120709------------------end-----------------------

MAIN
DEFINE
    l_time        VARCHAR(8)                  #计算被使用时间

    OPTIONS                                #改变一些系统预设值
        FORM LINE       FIRST + 2,         #画面开始的位置
        MESSAGE LINE    LAST,              #讯息显示的位置
        PROMPT LINE     LAST,              #提示讯息的位置
        INPUT NO WRAP                      #输入的方式: 不打转
    DEFER INTERRUPT                        #撷取中断键, 由程式处理

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("CIM")) THEN
      EXIT PROGRAM
   END IF

    LET g_argv1=ARG_VAL(1)
    LET g_wc2=' 1=1'

    LET g_forupd_sql = "SELECT * FROM imm_file WHERE ROWID = ? FOR UPDATE NOWAIT"
    DECLARE t324_cl CURSOR FROM g_forupd_sql 

    CALL cl_used('cimt332',l_time,1)       #计算使用时间 (进入时间)
        RETURNING l_time

    INITIALIZE g_imm.* TO NULL
    INITIALIZE g_imm_t.* TO NULL
    INITIALIZE g_imm_o.* TO NULL

    LET p_row = 2 LET p_col = 6
  # OPEN WINDOW t324_w AT p_row,p_col WITH FORM "cim/42f/aimt324_1"
  #  OPEN WINDOW t332_w AT p_row,p_col WITH FORM "cim/42f/cimt332"
   OPEN WINDOW t332_w AT p_row,p_col WITH FORM "cim/42f/cimt332_zb"    #add by zhangbo140914
    ATTRIBUTE (STYLE = g_win_style)

    CALL cl_ui_init()

    #CALL cl_set_comp_visible("immud19,immud20,immconf,imnud08",FALSE)  #No.160718---for test 先将新增的字段隐藏

    IF NOT cl_null(g_argv1) THEN CALL t324_q() END IF

    CALL t324_menu()

    CLOSE WINDOW t332_w                    #结束画面
    CALL cl_used('cimt332',l_time,2)       #计算使用时间 (退出使间)
         RETURNING l_time
END MAIN

FUNCTION t324_cs()
   DEFINE   l_imn03   LIKE imn_file.imn03 

    IF cl_null(g_argv1) THEN
       CLEAR FORM                             #清除画面
       CALL g_imn.clear()

       CONSTRUCT BY NAME g_wc ON                     # 萤幕上取单头条件
                    imm01,imm02,imm13,immud16,imm09,imm03,                #add by zhangbo140915
                    immud13,immud19,immud20,immconf,                      #No.160718 
                    immuser,immgrup,immmodu,immdate   
       
        BEFORE CONSTRUCT
               INITIALIZE g_imm.* TO NULL

        ON ACTION controlp                  
          CASE WHEN INFIELD(imm01) #查询单据
                 #--No.FUN-4A0052----
                 CALL cl_init_qry_var()
                 LET g_qryparam.state= "c"
  	         LET g_qryparam.form = "q_imm103"
 	         CALL cl_create_qry() RETURNING g_qryparam.multiret
                 #--END--------------
                # LET g_t1=g_imm.imm01[1,3]
                # CALL q_smy(TRUE,FALSE,g_t1,'aim','4') RETURNING g_qryparam.multiret
                # LET g_imm.imm01[1,3]=g_qryparam.multiret
                 DISPLAY g_qryparam.multiret to imm01
                 NEXT FIELD imm01
                WHEN INFIELD(imm13) # 查询部门
                    CALL cl_init_qry_var()
                    LET g_qryparam.state= "c"
                      LET g_qryparam.form ="q_gem"
                      LET g_qryparam.default1 = g_imm.imm13
                      CALL cl_create_qry() RETURNING g_qryparam.multiret
#                      CALL FGL_DIALOG_SETBUFFER( g_imm.imm13 )
                      DISPLAY g_qryparam.multiret TO imm13
                      NEXT FIELD imm13
               OTHERWISE EXIT CASE
            END CASE
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
       
       END CONSTRUCT
       IF INT_FLAG THEN RETURN END IF

       CONSTRUCT g_wc2 ON imn02,imnud04,imn03,imn28,imn04,imn05,imn06,imn09,   #No:120425
                          imn15,imn16,imn17,imn20,imn10,imn22,imn21,imnud21    #No.160416
            FROM s_imn[1].imn02,s_imn[1].imnud04,s_imn[1].imn03,s_imn[1].imn28,s_imn[1].imn04,   #No:120425
                 s_imn[1].imn05,s_imn[1].imn06,s_imn[1].imn09,
                 s_imn[1].imn15,s_imn[1].imn16,s_imn[1].imn17,
                 s_imn[1].imn20,s_imn[1].imn10,s_imn[1].imn22,
                 s_imn[1].imn21,s_imn[1].imnud21                               #No.160416

        BEFORE CONSTRUCT
           CALL g_imn.clear()

        ON ACTION controlp
           CASE WHEN INFIELD(imn03)
                     CALL cl_init_qry_var()
                     LET g_qryparam.form ="q_ima"
                     LET g_qryparam.state = "c"
                     CALL cl_create_qry() RETURNING g_qryparam.multiret
                     DISPLAY g_qryparam.multiret TO imn03
                     NEXT FIELD imn03

               WHEN INFIELD(imn28) #理由
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_azf"
                    LET g_qryparam.state    = "c"
                    LET g_qryparam.default1 = g_imn[1].imn28
                    LET g_qryparam.arg1     = "2"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO imn28
                    NEXT FIELD imn28
#BUG-4B0071
               WHEN INFIELD(imn04)  
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_imn3"
                    LET g_qryparam.state    = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret 
                    DISPLAY g_qryparam.multiret TO imn04
                    NEXT FIELD imn04 
               WHEN INFIELD(imn15)
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_imn4"
                    LET g_qryparam.state    = "c"
                    CALL cl_create_qry() RETURNING g_qryparam.multiret
                    DISPLAY g_qryparam.multiret TO imn15
                    NEXT FIELD imn15
#BUG-4B0071
           END CASE
          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             CONTINUE CONSTRUCT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
       
       END CONSTRUCT

       IF INT_FLAG THEN LET INT_FLAG=0 RETURN END IF
      ELSE
       LET g_wc=" imm01='",g_argv1,"'"
       LET g_wc2=" 1=1"
    END IF
    #资料权限的检查
    IF g_priv2='4' THEN                           #只能使用自己的资料
        LET g_wc = g_wc clipped," AND immuser = '",g_user,"'"
    END IF
    IF g_priv3='4' THEN                           #只能使用相同群的资料
        LET g_wc = g_wc clipped," AND immgrup MATCHES '",g_grup CLIPPED,"*'"
    END IF
    IF g_wc2 = " 1=1" THEN			# 若单身未输入条件
       LET g_sql = "SELECT ROWID, imm01 FROM imm_file",
                   " WHERE imm10 = '1' AND ", g_wc CLIPPED,
                   " ORDER BY 2"
     ELSE					# 若单身有输入条件
       LET g_sql = "SELECT UNIQUE imm_file.ROWID, imm01 ",
                   "  FROM imm_file, imn_file",
                   " WHERE imm01 = imn01",
                   "   AND imm10 = '1'  ",
                   "   AND ", g_wc CLIPPED, " AND ",g_wc2 CLIPPED,
                   " ORDER BY 2"
    END IF

    PREPARE t324_prepare FROM g_sql
    DECLARE t324_cs                         #SCROLL CURSOR
        SCROLL CURSOR WITH HOLD FOR t324_prepare

    IF g_wc2 = " 1=1" THEN			# 取合乎条件笔数
        LET g_sql="SELECT COUNT(*) FROM imm_file ",
                  "WHERE imm10 = '1' AND ",g_wc CLIPPED
    ELSE
        LET g_sql="SELECT COUNT(DISTINCT imm01) FROM imm_file,imn_file ",
                  " WHERE imm10 = '1' AND ",
                  "imm01=imn01 AND ",g_wc CLIPPED," AND ",g_wc2 CLIPPED
    END IF
    PREPARE t324_precount FROM g_sql
    DECLARE t324_count CURSOR FOR t324_precount
END FUNCTION

FUNCTION t324_menu()

   WHILE TRUE
      CALL t324_bp("G")
      CASE g_action_choice
         WHEN "insert"  
            IF cl_chk_act_auth() THEN
               CALL t324_a() 
            END IF
         WHEN "query"  
            IF cl_chk_act_auth() THEN 
               CALL t324_q()
            END IF
         WHEN "delete" 
            IF cl_chk_act_auth() THEN
               CALL t324_r() 
            END IF
         WHEN "modify" 
            IF cl_chk_act_auth() THEN 
               CALL t324_u() 
            END IF
         WHEN "detail" 
            IF cl_chk_act_auth() THEN
               CALL t324_b() 
            ELSE
               LET g_action_choice = NULL
            END IF
         WHEN "output" 
            IF cl_chk_act_auth() THEN 
               CALL t324_out() 
            END IF
         WHEN "help"  
            CALL cl_show_help()
         WHEN "exit" 
            EXIT WHILE
         WHEN "controlg"  
            CALL cl_cmdask()
         WHEN "post"	
            IF cl_chk_act_auth() THEN 
               CALL t324_s()
               CALL t324_show()                       #No.160718 
               IF g_imm.imm03 = 'X' THEN
                  LET g_void = 'Y'
               ELSE
                  LET g_void = 'N'
               END IF
               #CALL cl_set_field_pic("","",g_imm.imm03,"",g_void,"")
               CALL cl_set_field_pic(g_imm.immconf,"",g_imm.imm03,"",g_void,"")    #No.160718
            END IF
         WHEN "undo_post"
            IF cl_chk_act_auth() THEN
               LET g_msg="aimp378 '",g_imm.imm01,"'"
               CALL cl_cmdrun_wait(g_msg)
               SELECT imm03 INTO g_imm.imm03 FROM imm_file
               WHERE imm01=g_imm.imm01
               DISPLAY g_imm.imm03 TO imm03
#add by chentao 150917------begin       
               IF g_imm.imm03 <> 'Y' THEN
                    DELETE FROM tc_jxc_file WHERE tc_jxc07 = g_imm.imm01
               END IF
#add by chentao 150917--------end                 
               #xf add 120408  --begin
               IF g_imm.imm03 ='N' THEN
                  #更新tlf931
                  LET g_sql="UPDATE tlf_file SET tlf931=nvl(tlf931,0)-(SELECT SUM(tc_rec05) ", 
                            "  FROM tc_rec_file ",
                            " WHERE tc_rec03=tlf905 ",
                            "   AND tc_rec04=tlf906 ",
                            "   AND tc_rec01=?) ",
                            " WHERE tlf905||tlf906 IN(SELECT tc_rec03||tc_rec04 ",
                            "  FROM tc_rec_file ",
                            " WHERE tc_rec01=?) ",
                            "   AND tlf907='1'"
                  PREPARE upd_tlf931_pre FROM g_sql
                  EXECUTE upd_tlf931_pre USING g_imm.imm01,g_imm.imm01
                           
                  DELETE FROM tc_rec_file WHERE tc_rec01=g_imm.imm01  #xf add 111216
                  
                  #No.160718----------BEGIN----------#
                  IF g_imm.immud19 != 'Y' THEN
                     UPDATE imm_file SET immconf='N' WHERE imm01=g_imm.imm01
                     CALL t324_show()
                  END IF       
                  #No.160718-----------END-----------# 
               END IF
               #xf add 120408  --end
               
               IF g_imm.imm03 = 'X' THEN
                  LET g_void = 'Y'
               ELSE
                  LET g_void = 'N'
               END IF
               #CALL cl_set_field_pic("","",g_imm.imm03,"",g_void,"")
               CALL cl_set_field_pic(g_imm.immconf,"",g_imm.imm03,"",g_void,"")      #No.160718
            END IF
         WHEN "void" 
        #   IF cl_smuchk(g_imm.imm01,'X')THEN
            IF cl_chk_act_auth() THEN
               CALL t324_x() 
               IF g_imm.imm03 = 'X' THEN
                  LET g_void = 'Y'
               ELSE
                  LET g_void = 'N'
               END IF
               #CALL cl_set_field_pic("","",g_imm.imm03,"",g_void,"")
               CALL cl_set_field_pic(g_imm.immconf,"",g_imm.imm03,"",g_void,"")      #No.160718
            END IF
        #   END IF
        
         #No.160718----------BEGIN----------#
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
            	 CALL t332_confirm()
            	 CALL t324_show()
            END IF
         WHEN "undo_confirm"
            IF cl_chk_act_auth() THEN
            	 CALL t332_undo_confirm()
            	 CALL t324_show()
            END IF
         WHEN "maintain_return"
            IF cl_chk_act_auth() THEN
            	 CALL t332_maintain_return()
            	 CALL t324_show()
            END IF
         WHEN "quantity_confirm"
            IF cl_chk_act_auth() THEN
            	 CALL t332_quantity_confirm()
            END IF    		      		
         #No.160718-----------END-----------#
          
         WHEN "exporttoexcel" #FUN-4B0002
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_imn),'','')
            END IF
      END CASE
   END WHILE
END FUNCTION

FUNCTION t324_g()
    DEFINE a VARCHAR(1)

    LET p_row = 4 LET p_col = 5
    OPEN WINDOW t324g_w AT p_row,p_col WITH FORM "aim/42f/aimt324g"
         ATTRIBUTE (STYLE = g_win_style)

    CALL cl_ui_locale("aimt324g")
         
    INPUT BY NAME a WITHOUT DEFAULTS
       AFTER FIELD a
          IF a IS NULL THEN NEXT FIELD a END IF
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
    
    END INPUT
    IF INT_FLAG THEN 
       LET INT_FLAG=0
       CLOSE WINDOW t324g_w
       RETURN
    END IF

    IF a = '1' THEN CALL t324_g1() END IF

    CLOSE WINDOW t324g_w

    CALL t324_b_fill(' 1=1')
END FUNCTION

FUNCTION t324_g1()
    DEFINE l_wc,l_sql	 VARCHAR(400)
    DEFINE t_img02,t_img03,t_img04 VARCHAR(10)
    DEFINE l_img RECORD LIKE img_file.*
    OPEN WINDOW t324g_w AT 5,5 WITH FORM "aim/42f/aimt324g"
         ATTRIBUTE (STYLE = g_win_style)

    CALL cl_ui_locale("aimt324g")

    CONSTRUCT BY NAME l_wc ON img01,img02,img03,img04
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
    
    END CONSTRUCT
    IF INT_FLAG THEN
       LET INT_FLAG=0
       CLOSE WINDOW t324g_w
       RETURN
    END IF

    INPUT BY NAME t_img02,t_img03,t_img04
    IF INT_FLAG THEN
       LET INT_FLAG=0
       CLOSE WINDOW t324g_w
       RETURN
    END IF

    LET l_sql="SELECT * FROM img_file WHERE ",l_wc CLIPPED,
              " AND img10 > 0",
              " ORDER BY img01,img02,img03,img04"
    PREPARE t324_g1_p FROM l_sql
    DECLARE t324_g1_c CURSOR FOR t324_g1_p
    INITIALIZE b_imn.* TO NULL

    SELECT MAX(imn02) INTO b_imn.imn02 FROM imn_file 
     WHERE imn01=g_imm.imm01
    IF cl_null(b_imn.imn02) THEN LET b_imn.imn02=0 END IF

    FOREACH t324_g1_c INTO l_img.*
       IF STATUS THEN EXIT FOREACH END IF
       LET b_imn.imn01 = g_imm.imm01
       LET b_imn.imn02 = b_imn.imn02 + 1
       LET b_imn.imn03 = l_img.img01
       LET b_imn.imn04 = l_img.img02
       LET b_imn.imn05 = l_img.img03
       LET b_imn.imn06 = l_img.img04
       LET b_imn.imn09 = l_img.img09
       LET b_imn.imn10 = l_img.img10
       IF t_img02 IS NULL
          THEN LET b_imn.imn15 = l_img.img02
          ELSE LET b_imn.imn15 = t_img02
       END IF
       IF t_img03 IS NULL
          THEN LET b_imn.imn16 = l_img.img03
          ELSE LET b_imn.imn16 = t_img03
       END IF
       IF t_img04 IS NULL
          THEN LET b_imn.imn17 = l_img.img04
          ELSE LET b_imn.imn17 = t_img04
       END IF

       CALL t324_b_move_to()

       LET b_imn.imn20=NULL LET b_imn.imn21=NULL
       SELECT img09,img21 INTO b_imn.imn20,b_imn.imn21
	FROM img_file WHERE img01=b_imn.imn03 AND img02=b_imn.imn15
			AND img03=b_imn.imn16 AND img04=b_imn.imn17
       IF STATUS=100 THEN
           CALL s_add_img(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                          g_imn[l_ac].imn16,g_imn[l_ac].imn17,
                          g_imm.imm01      ,g_imn[l_ac].imn02,
                          g_imm.imm02)
           SELECT img09,img21 INTO b_imn.imn20,b_imn.imn21
	   FROM img_file WHERE img01=b_imn.imn03 AND img02=b_imn.imn15
			   AND img03=b_imn.imn16 AND img04=b_imn.imn17
       END IF
       LET b_imn.imn21 = b_imn.imn21 / l_img.img21
       LET b_imn.imn22 = b_imn.imn10 * b_imn.imn21
       LET b_imn.imn27 = 'N'
       # Add by zm 06/01/17
       IF cl_null(b_imn.imn06) THEN LET b_imn.imn06='' END IF
       IF cl_null(b_imn.imn17) THEN LET b_imn.imn17='' END IF
       # End.
       LET b_imn.imnlegal = g_plant
       LET b_imn.imnplant = g_plant
       INSERT INTO imn_file VALUES (b_imn.*)
       MESSAGE 'Insert seq no:',b_imn.imn02,' status:',SQLCA.SQLCODE
    END FOREACH
    CLOSE WINDOW t324g_w
    CALL t324_b_fill(' 1=1')
END FUNCTION

FUNCTION t324_a()
DEFINE li_result  LIKE type_file.num5

    IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
    CALL g_imn.clear()
    INITIALIZE g_imm.* TO NULL
    LET g_imm_o.* = g_imm.*
    CALL cl_opmsg('a')
    WHILE TRUE
        LET g_imm.immud01 = 'cimt332'       #add by zhangbo140709
        LET g_imm.imm02  =g_today
        LET g_imm.imm03  = 'N'    
        LET g_imm.immconf  = 'N'     #add by xumin 101230
        LET g_imm.imm10  = '1'
        LET g_imm.immud05 = 'N'      #add by lijun 120925    
        LET g_imm.immuser=g_user
        LET g_imm.immgrup=g_grup
        LET g_imm.immdate=g_today
        LET g_imm.immud19='N'        #No.160718
        BEGIN WORK
        CALL t324_i("a")                #输入单头
        IF INT_FLAG THEN
           INITIALIZE g_imm.* TO NULL
           LET INT_FLAG=0
           CALL cl_err('',9001,0) 
           ROLLBACK WORK 
           RETURN
        END IF
        LET g_imm.immlegal = g_plant
        LET g_imm.immplant = g_plant
        IF g_imm.imm01 IS NULL THEN CONTINUE WHILE END IF
        IF g_smy.smyauno='Y' THEN
	#   CALL s_smyauno(g_imm.imm01,g_imm.imm02) RETURNING g_i,g_imm.imm01
  #         IF g_i THEN CONTINUE WHILE END IF	#有问题
          CALL s_auto_assign_no("aim",g_imm.imm01,g_imm.imm02,"","imm_file","imm01",
                "","","")
           RETURNING li_result,g_imm.imm01
           IF (NOT li_result) THEN
             CONTINUE WHILE
           END IF
	   DISPLAY BY NAME g_imm.imm01
        END IF
        INSERT INTO imm_file VALUES (g_imm.*) 
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN 
           ROLLBACK WORK
           CALL cl_err('ins imm: ',SQLCA.SQLCODE,1) 
           CONTINUE WHILE 
        ELSE
            COMMIT WORK
            CALL cl_flow_notify(g_imm.imm01,'I')
        END IF
      

        SELECT ROWID INTO g_imm_rowid FROM imm_file 
         WHERE imm01 = g_imm.imm01
        LET g_imm_t.* = g_imm.*

        CALL g_imn.clear()
        LET g_rec_b = 0 

        CALL t324_b()                   #输入单身

        SELECT COUNT(*) INTO g_i FROM imn_file 
         WHERE imn01=g_imm.imm01
        IF g_i>0 THEN
           IF g_smy.smyprint='Y' THEN
              IF cl_confirm('mfg9392') THEN CALL t324_out() END IF
           END IF
           IF g_smy.smydmy4='Y' THEN CALL t324_s() END IF
        END IF
        EXIT WHILE

    END WHILE

END FUNCTION

FUNCTION t324_u()
    IF s_shut(0) THEN RETURN END IF
    IF cl_null(g_imm.imm01) THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
    IF g_imm.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
    IF g_imm.imm03 = 'X' THEN CALL cl_err('',9024,0) RETURN END IF
    MESSAGE ""
    CALL cl_opmsg('u')
    LET g_imm_o.* = g_imm.*
    BEGIN WORK
    OPEN t324_cl USING g_imm_rowid
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
       CLOSE t324_cl
       ROLLBACK WORK
       RETURN
    ELSE 
       FETCH t324_cl INTO g_imm.*                   # 锁住将被更改或取消的资料
       IF SQLCA.sqlcode THEN
          CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)  # 资料被他人LOCK
          CLOSE t324_cl 
          ROLLBACK WORK 
          RETURN
       END IF
    END IF
    CALL t324_show()
    WHILE TRUE
        LET g_imm.immmodu=g_user
        LET g_imm.immdate=g_today
        CALL t324_i("u")                      #栏位更改
        IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_imm.*=g_imm_t.*
            CALL t324_show()
            CALL cl_err('','9001',0)
            EXIT WHILE
        END IF
        UPDATE imm_file SET * = g_imm.* WHERE ROWID = g_imm_rowid
        IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
           CALL cl_err('up imm: ',SQLCA.SQLCODE,1)
           CONTINUE WHILE
        END IF
        IF g_imm.imm01 != g_imm_t.imm01 THEN CALL t324_chkkey() END IF
        EXIT WHILE
    END WHILE
    CLOSE t324_cl
    COMMIT WORK
    CALL cl_flow_notify(g_imm.imm01,'U')
END FUNCTION

FUNCTION t324_chkkey()
      UPDATE imn_file SET imn01=g_imm.imm01 WHERE imn01=g_imm_t.imm01
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
         CALL cl_err('upd imn01: ',SQLCA.SQLCODE,1)
         LET g_imm.*=g_imm_t.* CALL t324_show() ROLLBACK WORK RETURN
      END IF
END FUNCTION

FUNCTION t324_i(p_cmd)
  DEFINE p_cmd           VARCHAR(1)               #a:输入 u:更改
  DEFINE l_flag          VARCHAR(1)               #判断必要栏位是否有输入
  DEFINE l_gem01   LIKE gem_file.gem01 
  DEFINE l_gem02   LIKE gem_file.gem02
  DEFINE l_n       LIKE type_file.num5           #add by zhangbo140915

    DISPLAY BY NAME
	      g_imm.imm01,g_imm.imm02,
	      g_imm.immud13,                                        #No.160718   
	      g_imm.imm13,g_imm.imm09,
        g_imm.immud16,                                        #add by zhangbo140914
        g_imm.immud19,g_imm.immud20,g_imm.immconf,            #No.160718 
        g_imm.imm03,
        g_imm.immuser,g_imm.immgrup,
	      g_imm.immmodu,g_imm.immdate
    INPUT BY NAME g_imm.imm01,g_imm.imm02,
                  g_imm.immud13,                                        #No.160718
                  g_imm.imm13,                                          
                  g_imm.immud16,                                        #add by zhangbo140914 
                  g_imm.imm09,
                  g_imm.immud19,g_imm.immud20,g_imm.immconf,            #No.160718
                  g_imm.imm03,g_imm.immuser,g_imm.immgrup,   
	                g_imm.immmodu,g_imm.immdate
           WITHOUT DEFAULTS 

        BEFORE INPUT
            LET g_before_input_done = FALSE
            CALL t324_set_entry(p_cmd)
            CALL t324_set_no_entry(p_cmd)
            LET g_before_input_done = TRUE 

        AFTER FIELD imm01  
            IF NOT cl_null(g_imm.imm01) THEN 
               LET g_t1=g_imm.imm01[1,3]
               CALL s_mfgslip(g_t1,'aim','4')
               IF NOT cl_null(g_errno) THEN          #抱歉, 有问题
                  CALL cl_err(g_t1,g_errno,0) NEXT FIELD imm01
               END IF
               IF p_cmd = 'a' AND cl_null(g_imm.imm01[5,10]) 
                  AND g_smy.smyauno = 'N' THEN 
                  NEXT FIELD imm01
               END IF
               IF g_imm.imm01 != g_imm_t.imm01 OR g_imm_t.imm01 IS NULL THEN
                   IF g_smy.smyauno = 'Y' AND NOT cl_chk_data_continue(g_imm.imm01[5,10]) THEN
                      CALL cl_err('','9056',0) NEXT FIELD imm01
                   END IF
                   SELECT count(*) INTO g_cnt FROM imm_file
                       WHERE imm01 = g_imm.imm01
                   IF g_cnt > 0 THEN   #资料重复
                       CALL cl_err(g_imm.imm01,-239,0)
                       LET g_imm.imm01 = g_imm_t.imm01
                       DISPLAY BY NAME g_imm.imm01
                       NEXT FIELD imm01
                   END IF
               END IF
            END IF

        AFTER FIELD imm02
           IF NOT cl_null(g_imm.imm02) THEN 
	      IF g_sma.sma53 IS NOT NULL AND g_imm.imm02 <= g_sma.sma53 THEN
	         CALL cl_err('','mfg9999',0) NEXT FIELD imm02
	      END IF
              CALL s_yp(g_imm.imm02) RETURNING g_yy,g_mm
              IF (g_yy*12+g_mm)>(g_sma.sma51*12+g_sma.sma52)THEN #不可大于现行年月
                 CALL cl_err('','mfg6091',0) NEXT FIELD imm02
              END IF
           END IF

         #add by zhangbo140915---begin
         AFTER FIELD immud16
            IF NOT cl_null(g_imm.immud16) THEN
               LET l_n=0
               SELECT COUNT(*) INTO l_n FROM imm_file,imn_file
                WHERE imm01=imn01 AND imm10='2'
                  AND imn24='Y'
               IF l_n=0 THEN
                  CALL cl_err("无此电商出货单号或者此单号还未有一笔确认入库","!",0)
                  NEXT FIELD immud16
               END IF
               
               #检查单身退货数量
               IF NOT cl_null(g_imm_t.imm01) THEN 
                  CALL t332_chk_immud16()
                  IF g_success='N' THEN
                     NEXT FIELD immud16
                  END IF
               END IF

            END IF
         #add by zhangbo140915---end
         AFTER FIELD imm13 
           IF NOT cl_null(g_imm.imm13) THEN 
               SELECT gem01,gem02 INTO l_gem01,l_gem02 FROM gem_file 
                WHERE gem01=g_imm.imm13
                  AND gemacti='Y'   #NO:6950
               IF STATUS THEN 
                  CALL cl_err('select gem',STATUS,0) 
                  NEXT FIELD imm13
               END IF
               DISPLAY l_gem02 TO gem02
           END IF
            	
        #No.160718----------BEGIN----------#
        AFTER FIELD immud19
           IF NOT cl_null(g_imm.immud19) THEN
              IF g_imm.immud19='Y' THEN
                 CALL cl_set_comp_entry("immud13,immud20",TRUE)
                 IF cl_null(g_imm.immud13) THEN
                    LET g_imm.immud13=g_today
                    DISPLAY BY NAME g_imm.immud13
                 END IF
              ELSE
           	 CALL cl_set_comp_entry("immud13,immud20",FALSE)
           	 LET g_imm.immud13=NULL
           	 LET g_imm.immud20=NULL
           	 DISPLAY BY NAME g_imm.immud13,g_imm.immud20
              END IF
           END IF	  		 	 
        #No.160718-----------END-----------#    	
            
        ON ACTION controlp                  
          CASE WHEN INFIELD(imm01) #查询单据
                    LET g_t1=g_imm.imm01[1,3]
                    CALL q_smy(FALSE,FALSE,g_t1,'aim','4') RETURNING g_t1
#                    CALL FGL_DIALOG_SETBUFFER( g_t1 )
                    LET g_imm.imm01[1,3]=g_t1
                    DISPLAY BY NAME g_imm.imm01
                    NEXT FIELD imm01
               WHEN INFIELD(imm13) # 查询部门
                    CALL cl_init_qry_var()
                      LET g_qryparam.form ="q_gem"
                      LET g_qryparam.default1 = g_imm.imm13
                      CALL cl_create_qry() RETURNING g_imm.imm13
#                      CALL FGL_DIALOG_SETBUFFER( g_imm.imm13 )
                      DISPLAY BY NAME g_imm.imm13
                      NEXT FIELD imm13
               #add by zhangbo140914---begin
               WHEN INFIELD(immud16)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form = "cq_imm01"
                  LET g_qryparam.default1 = g_imm.immud16
                  CALL cl_create_qry() RETURNING g_imm.immud16
                  DISPLAY BY NAME g_imm.immud16
                  NEXT FIELD immud16
               #add by zhangbo140914---begin

               OTHERWISE EXIT CASE
            END CASE

        ON ACTION CONTROLF                  #栏位说明
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
          

        ON ACTION CONTROLO                        # 沿用所有栏位
            IF INFIELD(imm01) THEN
                LET g_imm.* = g_imm_t.*
                CALL t324_show()
                NEXT FIELD imm01
            END IF

        ON ACTION CONTROLZ
           CALL cl_show_req_fields()

        ON ACTION CONTROLG CALL cl_cmdask()
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
    
    END INPUT
END FUNCTION

FUNCTION t324_set_entry(p_cmd) 
  DEFINE p_cmd   VARCHAR(01)

    IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN 
       CALL cl_set_comp_entry("imm01",TRUE)
       CALL cl_set_comp_entry("immud13,immud19,immud20",TRUE)      #No.160718
    END IF 

END FUNCTION

FUNCTION t324_set_no_entry(p_cmd) 
  DEFINE p_cmd   VARCHAR(01)

    IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN 
       CALL cl_set_comp_entry("imm01",FALSE)
       CALL cl_set_comp_entry("immud13,immud19,immud20",FALSE)     #No.160718 
    END IF 

END FUNCTION

FUNCTION t324_q()

    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    MESSAGE ""
    CALL cl_opmsg('q')
    DISPLAY '   ' TO FORMONLY.cnt
    CALL t324_cs()
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_imm.* TO NULL
       RETURN
    END IF
    MESSAGE " SEARCHING ! " 
    OPEN t324_cs               # 从DB产生合乎条件TEMP(0-30秒)
    IF SQLCA.sqlcode THEN
        CALL cl_err('',SQLCA.sqlcode,0)
        INITIALIZE g_imm.* TO NULL
    ELSE
        OPEN t324_count
        FETCH t324_count INTO g_row_count
        DISPLAY g_row_count TO FORMONLY.cnt
        CALL t324_fetch('F')                  # 读出TEMP第一笔并显示
    END IF
    MESSAGE ""
END FUNCTION

FUNCTION t324_fetch(p_flag)
DEFINE
    p_flag          VARCHAR(1)                #处理方式

    CASE p_flag
        WHEN 'N' FETCH NEXT     t324_cs INTO g_imm_rowid,g_imm.imm01
        WHEN 'P' FETCH PREVIOUS t324_cs INTO g_imm_rowid,g_imm.imm01
        WHEN 'F' FETCH FIRST    t324_cs INTO g_imm_rowid,g_imm.imm01
        WHEN 'L' FETCH LAST     t324_cs INTO g_imm_rowid,g_imm.imm01
        WHEN '/'
            IF (NOT mi_no_ask) THEN
                 CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
                LET INT_FLAG = 0  ######add for prompt bug
                 PROMPT g_msg CLIPPED,': ' FOR g_jump
                    ON IDLE g_idle_seconds
                       CALL cl_on_idle()
#                       CONTINUE PROMPT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
                 
                 END PROMPT
                IF INT_FLAG THEN
                    LET INT_FLAG = 0
                    EXIT CASE
                END IF
            END IF
            FETCH ABSOLUTE g_jump t324_cs INTO g_imm_rowid,g_imm.imm01
            LET mi_no_ask = FALSE
    END CASE

    IF SQLCA.sqlcode THEN
        CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
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
    END IF
    SELECT * INTO g_imm.* FROM imm_file WHERE ROWID = g_imm_rowid
    IF SQLCA.sqlcode THEN
        CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
        INITIALIZE g_imm.* TO NULL
        RETURN
    ELSE
        LET g_data_owner = g_imm.immuser #FUN-4C0053
        LET g_data_group = g_imm.immgrup #FUN-4C0053
    END IF
    CALL t324_show()
END FUNCTION

FUNCTION t324_show()

    SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01        #No.160718
    LET g_imm_t.* = g_imm.*                #保存单头旧值
    DISPLAY BY NAME g_imm.imm01,g_imm.imm02,g_imm.imm13,g_imm.imm09,g_imm.imm03,
                    g_imm.immud16,                                  #add by zhangbo140914
                    g_imm.immud13,g_imm.immud19,g_imm.immud20,g_imm.immconf,       #No.160718 
	                  g_imm.immuser,g_imm.immgrup,g_imm.immmodu,g_imm.immdate
    LET g_buf = g_imm.imm01[1,3]
    CALL t324_imm13('d')
    IF g_imm.imm03 = 'X' THEN
       LET g_void = 'Y'
    ELSE
       LET g_void = 'N'
    END IF
    #CALL cl_set_field_pic("","",g_imm.imm03,"",g_void,"")
    CALL cl_set_field_pic(g_imm.immconf,"",g_imm.imm03,"",g_void,"")   #No.160718
    #No.160718----------BEGIN----------#
    IF g_imm.immud19='Y' THEN
       CALL cl_set_comp_visible("imnud08",TRUE)
       CALL cl_set_comp_required("imnud08",TRUE)  
    ELSE
       CALL cl_set_comp_visible("imnud08",FALSE)
       CALL cl_set_comp_required("imnud08",FALSE)
    END IF
    #No.160718-----------END-----------#	
    CALL t324_b_fill(g_wc2) 
# genero  script marked     LET g_imn_pageno = 0 
END FUNCTION

FUNCTION t324_imm13(p_cmd)
DEFINE p_cmd VARCHAR(1)
DEFINE l_gem02 LIKE gem_file.gem02
  LET g_errno = ""
  SELECT gem02 INTO l_gem02 FROM gem_file WHERE gem01=g_imm.imm13 
  DISPLAY l_gem02 TO FORMONLY.gem02
END FUNCTION 

FUNCTION t324_r()
    DEFINE l_chr,l_sure VARCHAR(1)

    IF s_shut(0) THEN RETURN END IF
    IF g_imm.imm01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
    SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
    IF g_imm.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
    IF g_imm.imm03 = 'X' THEN CALL cl_err('',9024,0) RETURN END IF
    
    #No.160718----------BEGIN----------#
    IF g_imm.immud19='Y' AND g_imm.immconf='Y' THEN 
       CALL cl_err("渠道退货单已审核,请取消审核再删除","!",0)
       RETURN
    END IF
    #No.160718-----------END-----------#   

    BEGIN WORK

    OPEN t324_cl USING g_imm_rowid
    IF SQLCA.sqlcode THEN 
       CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
       ROLLBACK WORK
       RETURN 
    ELSE 
       FETCH t324_cl INTO g_imm.*
       IF SQLCA.sqlcode THEN 
          CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
          ROLLBACK WORK
          RETURN 
       END IF
    END IF
    CALL t324_show()
    IF cl_delh(20,16) THEN
        MESSAGE "Delete imm,imn!"
        DELETE FROM imm_file WHERE imm01 = g_imm.imm01
        IF SQLCA.SQLERRD[3]=0
           THEN CALL cl_err('No imm deleted',SQLCA.SQLCODE,0)
                ROLLBACK WORK RETURN
        END IF
        DELETE FROM imn_file WHERE imn01 = g_imm.imm01
        LET g_msg=TIME
        INSERT INTO azo_file(azo01,azo02,azo03,azo04,azo05,azo06)
           VALUES ('aimt324',g_user,g_today,g_msg,g_imm.imm01,'delete')
        CLEAR FORM
        CALL g_imn.clear()
    	INITIALIZE g_imm.* TO NULL
        CALL g_imn.clear() 
        MESSAGE ""
         OPEN t324_count
         FETCH t324_count INTO g_row_count
         DISPLAY g_row_count TO FORMONLY.cnt
         OPEN t324_cs
         IF g_curs_index = g_row_count + 1 THEN
            LET g_jump = g_row_count
            CALL t324_fetch('L')
         ELSE
            LET g_jump = g_curs_index
            LET mi_no_ask = TRUE
            CALL t324_fetch('/')
         END IF
    END IF
    CLOSE t324_cl
    COMMIT WORK
    CALL cl_flow_notify(g_imm.imm01,'D')
     
END FUNCTION

FUNCTION t324_b()
DEFINE
    l_ac_t          SMALLINT,              #未取消的ARRAY CNT
    l_n,l_cnt       SMALLINT,              #检查重复用
    l_lock_sw       VARCHAR(1),               #单身锁住否
    p_cmd           VARCHAR(1),               #处理状态
    l_img10         LIKE img_file.img10,
    l_ima02         LIKE ima_file.ima02,
    l_allow_insert  SMALLINT,              #可新增否
    l_allow_delete  SMALLINT,               #可删除否
    l_imgcy         LIKE img_file.img10

#add by zhangbo140914----begin
DEFINE l_imm08     LIKE  imm_file.imm08
DEFINE l_sum1      LIKE  imn_file.imn10        #电商调拨单拨出总数量
DEFINE l_sum2      LIKE  imn_file.imn10        #电商调拨单拨入总数量
DEFINE l_sum3      LIKE  imn_file.imn10        #电商调拨单已退货数量(未作废)
#add by zhangbo140914----end

    LET g_action_choice = ""
    IF cl_null(g_imm.imm01) THEN RETURN END IF

    SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
    IF g_imm.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
    IF g_imm.imm03 = 'X' THEN CALL cl_err('',9024,0) RETURN END IF
    	
    IF g_imm.immconf = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF       #No.160718
    	
    #No.160718----------BEGIN----------#
    IF g_imm.immud19='Y' THEN
       CALL cl_set_comp_visible("imnud08",TRUE)
       CALL cl_set_comp_required("imnud08",TRUE)
    ELSE
       CALL cl_set_comp_visible("imnud08",FALSE)
       CALL cl_set_comp_required("imnud08",FALSE)
    END IF
    #No.160718-----------END-----------#		
    		 	 		
    CALL cl_opmsg('b')
    LET g_forupd_sql = "SELECT * FROM imn_file ",
                       " WHERE imn01= ? AND imn02= ?  FOR UPDATE NOWAIT "
    DECLARE t324_bcl CURSOR FROM g_forupd_sql

    LET l_ac_t = 0

    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    INPUT ARRAY g_imn WITHOUT DEFAULTS FROM s_imn.* 
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)

        BEFORE INPUT
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF

        BEFORE ROW
            LET p_cmd=''
            LET l_ac = ARR_CURR() 
            LET l_lock_sw = 'N'                   #DEFAULT
            LET l_n  = ARR_COUNT()

            BEGIN WORK

            OPEN t324_cl USING g_imm_rowid
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
               CLOSE t324_cl 
               ROLLBACK WORK 
               RETURN
            ELSE 
               FETCH t324_cl INTO g_imm.*  
               IF SQLCA.sqlcode THEN
                  CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
                  CLOSE t324_cl 
                  ROLLBACK WORK 
                  RETURN
               END IF
            END IF
            IF g_rec_b >= l_ac THEN
                LET p_cmd='u'
                LET g_imn_t.* = g_imn[l_ac].*  #BACKUP
                OPEN t324_bcl USING g_imm.imm01,g_imn_t.imn02  #表示更改状态
                FETCH t324_bcl INTO b_imn.* 
                IF SQLCA.sqlcode THEN
                   CALL cl_err('lock imn',SQLCA.sqlcode,1)
                   LET l_lock_sw = "Y"
                ELSE
                   CALL t324_b_move_to()
                END IF
                #No.160416----------BEGIN----------#
                #电商渠道仓库退货才允许输入退货理由
                IF NOT cl_null(g_imn[l_ac].imn04) THEN
                   LET l_n=0
                   SELECT COUNT(*) INTO l_n FROM tc_jhj_file 
                    WHERE tc_jhj002='2' AND tc_jhj004=g_imn[l_ac].imn04
                   IF l_n>0 THEN
                      CALL cl_set_comp_entry("imnud21",TRUE)
                   ELSE
                      LET g_imn[l_ac].imnud21=NULL 
                      CALL cl_set_comp_entry("imnud21",FALSE)
                   END IF
                END IF 
                #No.160416-----------END-----------#
            END IF

        BEFORE INSERT
           LET l_n = ARR_COUNT()
           LET p_cmd='a'
           INITIALIZE g_imn[l_ac].* TO NULL      #900423
           INITIALIZE g_imn_t.* TO NULL  
           LET b_imn.imn01=g_imm.imm01
          #LET g_imn[l_ac].imn10=0 #mandy test MARK 05/01/19
	  #LET g_imn[l_ac].imn22=0
           LET g_imn[l_ac].imn21=1
           LET g_imn[l_ac].imnud04='1'   #No:120425
           NEXT FIELD imn02

        AFTER INSERT
           IF INT_FLAG THEN
              CALL cl_err('',9001,0)
              LET INT_FLAG = 0
              CANCEL INSERT
           END IF

           CALL t324_b_move_back()
           LET b_imn.imnlegal = g_plant
           LET b_imn.imnplant = g_plant
           INSERT INTO imn_file VALUES(b_imn.*)
           IF SQLCA.sqlcode THEN
              CALL cl_err('ins imn',SQLCA.sqlcode,1)
              CANCEL INSERT
           ELSE
              MESSAGE 'INSERT O.K'
              LET g_rec_b=g_rec_b+1
              DISPLAY g_rec_b TO FORMONLY.cn2
           END IF

        BEFORE FIELD imn02                            #default 序号 
            IF g_imn[l_ac].imn02 IS NULL OR g_imn[l_ac].imn02 = 0 THEN
               SELECT max(imn02)+1 INTO g_imn[l_ac].imn02
                 FROM imn_file WHERE imn01 = g_imm.imm01
               IF g_imn[l_ac].imn02 IS NULL THEN
                  LET g_imn[l_ac].imn02 = 1
               END IF
            END IF
            IF p_cmd = 'u' THEN 
               SELECT ima02 INTO l_ima02 FROM ima_file 
                WHERE ima01 = g_imn[l_ac].imn03
               IF SQLCA.sqlcode THEN LET l_ima02 = ' ' END IF
               ERROR l_ima02
            END IF

       #   NEXT FIELD imn02    no cancel 

        AFTER FIELD imn02                        #check 序号是否重复
            IF NOT cl_null(g_imn[l_ac].imn02) THEN 
               IF g_imn[l_ac].imn02 != g_imn_t.imn02 OR
                  g_imn_t.imn02 IS NULL THEN
                   SELECT count(*) INTO l_n FROM imn_file
                    WHERE imn01 = g_imm.imm01 AND imn02 = g_imn[l_ac].imn02
                   IF l_n > 0 THEN
                       LET g_imn[l_ac].imn02 = g_imn_t.imn02
                       CALL cl_err('',-239,0) NEXT FIELD imn02
                   END IF
               END IF
            END IF
        BEFORE FIELD imn03
            IF g_sma.sma60 = 'Y' THEN # 若须分段输入
	       CALL s_inp5(9,14,g_imn[l_ac].imn03) 
                    RETURNING g_imn[l_ac].imn03
               IF INT_FLAG THEN LET INT_FLAG = 0 END IF
      	   END IF

        AFTER FIELD imn03  #PART
           IF NOT cl_null(g_imn[l_ac].imn03) THEN
              
              #add by zhangbo140914---begin
              IF NOT cl_null(g_imm.immud16) THEN
                 LET l_imm08=''
                 SELECT imm08 INTO l_imm08 FROM imm_file WHERE imm01=g_imm.immud16
                 LET g_imn[l_ac].imn04=l_imm08
                 LET g_imn[l_ac].imn05=' '
                 LET g_imn[l_ac].imn06=' '
                 SELECT img09,img10 INTO g_imn[l_ac].imn09,l_img10 FROM img_file
                  WHERE img01=g_imn[l_ac].imn03 AND
                        img02=g_imn[l_ac].imn04 AND
                        img03=g_imn[l_ac].imn05 AND
                        img04=g_imn[l_ac].imn06
                 IF NOT cl_null(g_imn[l_ac].imn10) THEN
                    LET l_sum1=0
                    LET l_sum2=0
                    LET l_sum3=0
                    SELECT SUM(imn10) INTO l_sum1 FROM imm_file,imn_file
                     WHERE imm01=imn01 AND imn03=g_imn[l_ac].imn03
                       AND imm01=g_imm.immud16 
                       AND imn24='Y'      #已拨入过账
                    SELECT SUM(imn22) INTO l_sum2 FROM imm_file,imn_file
                     WHERE imm01=imn01 AND imn03=g_imn[l_ac].imn03
                       AND imm01=g_imm.immud16 
                       AND imn24='Y'
                    IF NOT cl_null(g_imn_t.imn02) THEN
                       SELECT SUM(imn10) INTO l_sum3 FROM imn_file,imm_file
                        WHERE imn01=imm01 AND imn03=g_imn[l_ac].imn03
                          AND immud16=g_imm.immud16 
                          AND imn04=l_imm08
                          AND imm03<>'X'
                          AND (imm01<>g_imm.imm01
                           OR (imm01=g_imm.imm01 AND imn02<>g_imn_t.imn02))
                    ELSE
                       SELECT SUM(imn10) INTO l_sum3 FROM imn_file,imm_file
                        WHERE imn01=imm01 AND imn03=g_imn[l_ac].imn03
                          AND immud16=g_imm.immud16
                          AND imn04=l_imm08
                          AND imm03<>'X'
                    END IF
                    IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
                    IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
                    IF cl_null(l_sum3) THEN LET l_sum3=0 END IF 
                    IF l_sum1-l_sum2-l_sum3<g_imn[l_ac].imn10 THEN
                       CALL cl_err("此料件退货数量大于可退货数量,请检查","!",0)
                       NEXT FIELD imn03
                    END IF                    

                 END IF
                 
                 CALL cl_set_comp_entry("imn04,imn05,imn06",FALSE)
              ELSE
                 CALL cl_set_comp_entry("imn04,imn05,imn06",TRUE)
              END IF
              #add by zhangbo140914---end

              SELECT ima02,ima021 INTO g_imn[l_ac].ima02,g_imn[l_ac].ima021
                FROM ima_file 
               WHERE ima01=g_imn[l_ac].imn03 AND imaacti = 'Y'  #genero add
              IF STATUS THEN
              #  CALL cl_err('sel ima:',STATUS,0) NEXT FIELD imn03
                 CALL cl_err(g_imn[l_ac].imn03,'mfg0016',0)     #genero add
              END IF
           END IF

        AFTER FIELD imn28
           IF NOT g_imn[l_ac].imn28 IS NULL THEN
              SELECT azf03 INTO g_buf FROM azf_file 
               WHERE azf01=g_imn[l_ac].imn28 AND azf02='2' #6818
              IF STATUS THEN 
                 CALL cl_err('select azf',STATUS,0) NEXT FIELD imn28
              END IF
              MESSAGE g_buf 
           END IF

     #  BEFORE FIELD imn04          
     #     IF g_imn[l_ac].imn03 IS NULL THEN NEXT FIELD imn03 END IF
     #     IF g_imn_t.imn03 IS NULL OR g_imn_t.imn03 = ' ' OR 
     #        g_imn_t.imn03 != g_imn[l_ac].imn03 THEN 
     #        SELECT ima02 INTO l_ima02 FROM ima_file 
     #         WHERE ima01 = g_imn[l_ac].imn03 AND imaacti = 'Y'
     #        IF SQLCA.sqlcode THEN 
     #           CALL cl_err(g_imn[l_ac].imn03,'mfg0016',0)
     #           NEXT FIELD imn03
     #        END IF
     #       #ERROR l_ima02
     #     END IF

        AFTER FIELD imn04  #仓库
           IF NOT cl_null(g_imn[l_ac].imn04) THEN 
              IF NOT s_stkchk(g_imn[l_ac].imn04,'A') THEN
                 CALL cl_err(g_imn[l_ac].imn04,'mfg6076',0)
                 NEXT FIELD imn04
              END IF
              CALL  s_swyn(g_imn[l_ac].imn04) RETURNING sn1,sn2
    	      IF sn1=1 AND g_imn[l_ac].imn04!=t_imn04
              THEN CALL cl_err(g_imn[l_ac].imn04,'mfg6080',0) 
                   LET t_imn04=g_imn[l_ac].imn04
                   NEXT FIELD imn04
              ELSE IF sn2=2 AND g_imn[l_ac].imn04!=t_imn04
                   THEN CALL cl_err(g_imn[l_ac].imn04,'mfg6085',0) 
                        LET t_imn04=g_imn[l_ac].imn04
                        NEXT FIELD imn04
                   END IF
              END IF

              #add by zhangbo141029---begin
              #未录入原发货单号,仓库不可为D18
              IF cl_null(g_imm.immud16) AND g_imn[l_ac].imn04='D18' THEN
                 CALL cl_err("未录入原发货单号,退货仓库不可为D18","!",0)
                 NEXT FIELD imn04
              END IF
              #add by zhangbo141029---end
 
              #No.160416----------BEGIN----------#
              #电商渠道仓库退货才允许输入退货理由
              LET l_n=0
              SELECT COUNT(*) INTO l_n FROM tc_jhj_file
               WHERE tc_jhj002='2' AND tc_jhj004=g_imn[l_ac].imn04
              IF l_n>0 THEN
                 CALL cl_set_comp_entry("imnud21",TRUE)
              ELSE
                 LET g_imn[l_ac].imnud21=NULL
                 CALL cl_set_comp_entry("imnud21",FALSE)
              END IF
              #No.160416-----------END-----------#
              
              #No.160718----------BEGIN----------#
              IF g_imm.immud19='Y' AND l_n=0 THEN
                 CALL cl_err("渠道退货仓库必须是电商渠道仓库","!",0)
                 NEXT FIELD imn04
              END IF	 
              #No.160718-----------END-----------#

              LET sn1=0 LET sn2=0
              #BUG-530705
              #----- 成本不计仓库不可直接做调拨
#             SELECT COUNT(*) INTO g_cnt FROM jce_file 
#               WHERE jce02=g_imn[l_ac].imn04
#             IF g_cnt>0 THEN 
#                CALL cl_err(g_imn[l_ac].imn04,'aim-802',0) 
#                NEXT FIELD imn04
#             END IF
#             IF p_cmd = 'u' THEN 
#                CALL t324_chk_out() RETURNING g_i
#                IF g_i THEN
#                    NEXT FIELD imn04
#                END IF
#             END IF
           END IF 
           ### 060317 by ryf
           IF cl_null(g_imn[l_ac].imn05) THEN LET g_imn[l_ac].imn05=' ' END IF 
           IF cl_null(g_imn[l_ac].imn06) THEN LET g_imn[l_ac].imn06=' ' END IF 
           ### end ryf

        AFTER FIELD imn05  #储位
           IF cl_null(g_imn[l_ac].imn05) THEN 
              LET g_imn[l_ac].imn05=' '
           END IF
           #------------------------------------ 检查料号预设仓储及单别预设仓储

           #--------------------------------------------检查储位是否为全形空白
           IF g_imn[l_ac].imn05 ='　' THEN
              LET g_imn[l_ac].imn05 =' ' 
           END IF
         
           #---------------------------------------------020813 alexlin  
           IF NOT s_chksmz(g_imn[l_ac].imn03, g_imm.imm01,
                           g_imn[l_ac].imn04, g_imn[l_ac].imn05) THEN
              NEXT FIELD imn04
           END IF
           #------------------------------------------------------ 970715 roger
            #---->需存在仓库/储位档中
            IF g_imn[l_ac].imn05 IS NOT NULL THEN
	      IF sn1=1 AND g_imn[l_ac].imn05!=t_imn05
               THEN CALL cl_err(g_imn[l_ac].imn05,'mfg6081',0)
                       LET t_imn05=g_imn[l_ac].imn05
                       NEXT FIELD imn05
               ELSE IF sn2=2 AND g_imn[l_ac].imn05!=t_imn05
                    THEN CALL cl_err(g_imn[l_ac].imn05,'mfg6086',0)
                         LET t_imn05=g_imn[l_ac].imn05
                    NEXT FIELD imn05
                    END IF
               END IF
			   LET sn1=0 LET sn2=0
           END IF
        IF g_imn[l_ac].imn05 IS NULL THEN LET g_imn[l_ac].imn05=' ' END IF

        IF p_cmd = 'u' THEN 
           CALL t324_chk_out() RETURNING g_i
           IF g_i THEN
               NEXT FIELD imn05
           END IF
        END IF
        ##

        AFTER FIELD imn06  #批号
            IF cl_null(g_imn[l_ac].imn06) THEN 
               LET g_imn[l_ac].imn06=' ' 
            END IF
            SELECT img09,img10  INTO g_imn[l_ac].imn09,l_img10 FROM img_file 
             WHERE img01=g_imn[l_ac].imn03 AND
                   img02=g_imn[l_ac].imn04 AND
                   img03=g_imn[l_ac].imn05 AND
                   img04=g_imn[l_ac].imn06
          LET  g_imn[l_ac].imn09='PCS' 
       {     IF SQLCA.sqlcode THEN 
                LET l_img10 = 0
                CALL cl_err(g_imn[l_ac].imn06,'mfg6101',0)
                NEXT FIELD imn04
            END IF}
            #-->有效日期
      {      IF NOT s_actimg(g_imn[l_ac].imn03,g_imn[l_ac].imn04,
                            g_imn[l_ac].imn05,g_imn[l_ac].imn06)
            THEN CALL cl_err('inactive','mfg6117',1) #BugNo:4895
                 NEXT FIELD imn04
            END IF}

            IF p_cmd = 'u' THEN 
               CALL t324_chk_out() RETURNING g_i
               IF g_i THEN
                   NEXT FIELD imn06
               END IF
            END IF
        
        #No.160718----------BEGIN----------#
        AFTER FIELD imnud08
           IF NOT cl_null(g_imn[l_ac].imnud08) THEN
           	  IF g_imn[l_ac].imnud08<0 THEN
           	  	 CALL cl_err("申请退货数量必须大于0","!",0)
           	  	 NEXT FIELD imnud08
           	  END IF
           	  IF cl_null(g_imn[l_ac].imn10) THEN
           	  	 LET g_imn[l_ac].imn10=g_imn[l_ac].imnud08
           	  END IF
           	  IF cl_null(g_imn[l_ac].imn22) THEN
           	  	 LET g_imn[l_ac].imn22=g_imn[l_ac].imnud08
           	  END IF
           	  DISPLAY BY NAME g_imn[l_ac].imn10,g_imn[l_ac].imn22	
           END IF	  		 
        #No.160718-----------END-----------#
        
        AFTER FIELD imn10  #调拨数量
           IF NOT cl_null(g_imn[l_ac].imn10) THEN 
              IF g_imn[l_ac].imn10 <= 0 THEN 
                 CALL cl_err('','mfg9105',0)
                 NEXT FIELD imn10
              END IF
              IF p_cmd = 'u' THEN 
                 LET g_imn[l_ac].imn22 = g_imn[l_ac].imn10 * g_imn[l_ac].imn21
              END IF
               
              #add by zhangbo140914---begin
              IF NOT cl_null(g_imm.immud16) THEN
                 IF NOT cl_null(g_imn[l_ac].imn04) AND 
                    NOT cl_null(g_imn[l_ac].imn03) THEN
                    LET l_sum1=0
                    LET l_sum2=0
                    LET l_sum3=0
                    SELECT SUM(imn10) INTO l_sum1 FROM imm_file,imn_file
                     WHERE imm01=imn01 AND imn03=g_imn[l_ac].imn03
                       AND imm01=g_imm.immud16
                       AND imn24='Y'      #已拨入过账
                    SELECT SUM(imn22) INTO l_sum2 FROM imm_file,imn_file
                     WHERE imm01=imn01 AND imn03=g_imn[l_ac].imn03
                       AND imm01=g_imm.immud16
                       AND imn24='Y'
                    IF NOT cl_null(g_imn_t.imn02) THEN
                       SELECT SUM(imn10) INTO l_sum3 FROM imn_file,imm_file
                        WHERE imn01=imm01 AND imn03=g_imn[l_ac].imn03
                          AND immud16=g_imm.immud16
                          AND imn04=g_imn[l_ac].imn04
                          AND imm03<>'X'
                          AND (imm01<>g_imm.imm01
                           OR (imm01=g_imm.imm01 AND imn02<>g_imn_t.imn02))
                    ELSE
                       SELECT SUM(imn10) INTO l_sum3 FROM imn_file,imm_file
                        WHERE imn01=imm01 AND imn03=g_imn[l_ac].imn03
                          AND immud16=g_imm.immud16
                          AND imn04=g_imn[l_ac].imn04
                          AND imm03<>'X'
                    END IF
                    IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
                    IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
                    IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
                    IF l_sum1-l_sum2-l_sum3<g_imn[l_ac].imn10 THEN
                       CALL cl_err("此料件退货数量大于可退货数量,请检查","!",0)
                       NEXT FIELD imn10
                    END IF 
                 END IF              
              END IF
              #add by zhangbo140914---end
            {   IF g_imn[l_ac].imn10 > l_img10 THEN
                  IF g_sma.sma894[4,4]='N' OR g_sma.sma894[4,4] IS NULL THEN    
                     CALL cl_err(l_img10,'mfg3471',0)
                     NEXT FIELD imn10
                  ELSE}
                  
                  IF g_imn[l_ac].imn10 > l_img10 THEN
                  LET l_imgcy= l_img10-g_imn[l_ac].imn10                 
                  
                  update ze_file set ze03=g_imn[l_ac].imn03||'料号'||'('||g_imn[l_ac].ima02||')'||'在"'||g_imn[l_ac].imn04||'"库，当前库存为：'||l_img10||'目前库存量不足，若执行会使"'||g_imn[l_ac].imn04||'"库存变为'||l_imgcy||'请慎重操作,您确认要操作吗((Y/N)?' where ze01='cimt332' and ze02='2'
                  update ze_file set ze03='Inventory not enough, sure to run(Y/N) ?' where ze01='cimt332' and ze02='1'
                  update ze_file set ze03=g_imn[l_ac].imn03||'料号'||'('||g_imn[l_ac].ima02||')'||'在"'||g_imn[l_ac].imn04||'"库，当前库存为：'||l_img10||'目前库存量不足，若执行会使"'||g_imn[l_ac].imn04||'"库存变为'||l_imgcy||'请慎重操作,您确认要操作吗(Y/N)?' where ze01='cimt332' and ze02='0'
                 ELSE
                 LET l_imgcy= l_img10-g_imn[l_ac].imn10 
                 update ze_file set ze03=g_imn[l_ac].imn03||'料号'||'('||g_imn[l_ac].ima02||')'||'在"'||g_imn[l_ac].imn04||'"库，当前库存为：'||l_img10||'若执行会使"'||g_imn[l_ac].imn04||'"库存变为'||l_imgcy||'请慎重操作,您确认要操作吗((Y/N)?' where ze01='cimt332' and ze02='2'
                 update ze_file set ze03='Inventory not enough, sure to run(Y/N) ?' where ze01='cimt332' and ze02='1'
                 update ze_file set ze03=g_imn[l_ac].imn03||'料号'||'('||g_imn[l_ac].ima02||')'||'在"'||g_imn[l_ac].imn04||'"库，当前库存为：'||l_img10||'若执行会使"'||g_imn[l_ac].imn04||'"库存变为'||l_imgcy||'请慎重操作,您确认要操作吗((Y/N)?' where ze01='cimt332' and ze02='0'
                  END IF
                     IF NOT cl_confirm('cimt332') THEN 
                        NEXT FIELD imn10
                     END IF 
       #           END IF 
      #         END IF
               LET g_imn[l_ac].imn22=g_imn[l_ac].imn10*g_imn[l_ac].imn21
           END IF

#------目的仓库------------------------------------------------
        AFTER FIELD imn15  #仓库
            IF NOT cl_null(g_imn[l_ac].imn15) THEN
               #------>check-1
               IF NOT s_imfchk1(g_imn[l_ac].imn03,g_imn[l_ac].imn15)
                  THEN CALL cl_err(g_imn[l_ac].imn15,'mfg9036',0)
                       NEXT FIELD imn15
               END IF
               #------>check-2
               CALL  s_stkchk(g_imn[l_ac].imn15,'A') RETURNING l_code
               IF NOT l_code THEN 
                  CALL cl_err(g_imn[l_ac].imn15,'mfg1100',1)
                  NEXT FIELD imn15
               END IF
               CALL  s_swyn(g_imn[l_ac].imn15) RETURNING sn1,sn2
	           	IF sn1=1 AND g_imn[l_ac].imn15!=t_imn15
                  THEN CALL cl_err(g_imn[l_ac].imn15,'mfg6080',1)
                       LET t_imn15=g_imn[l_ac].imn15
                       NEXT FIELD imn15
                   ELSE IF sn2=2 AND g_imn[l_ac].imn15!=t_imn15
                          THEN CALL cl_err(g_imn[l_ac].imn15,'mfg6085',0)
                               LET t_imn15=g_imn[l_ac].imn15
                               NEXT FIELD imn15
                        END IF
               END IF
              #----- 成本不计仓库不可直接做调拨
              SELECT COUNT(*) INTO g_cnt FROM jce_file 
                WHERE jce02=g_imn[l_ac].imn15
              IF g_cnt>0 THEN 
                 CALL cl_err(g_imn[l_ac].imn15,'aim-802',0) 
                 NEXT FIELD imn15
              END IF

             #IF p_cmd = 'u' THEN  #mandy test MARK 05/01/19
             #   CALL t324_chk_in() RETURNING g_i
             #   IF g_i THEN
             #       NEXT FIELD imn15
             #   END IF
             #END IF
           END IF  
           ### 060317 by ryf
           IF cl_null(g_imn[l_ac].imn16) THEN LET g_imn[l_ac].imn16=' ' END IF 
           IF cl_null(g_imn[l_ac].imn17) THEN LET g_imn[l_ac].imn17=' ' END IF 
           ### end ryf
           NEXT FIELD imn16

        AFTER FIELD imn16  #储位
           #BugNo:5626 控管是否为全型空白
           IF g_imn[l_ac].imn16 = '　' THEN #全型空白
              LET g_imn[l_ac].imn16 = ' ' 
           END IF

            #------>chk-1
            IF NOT s_imfchk(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
					g_imn[l_ac].imn16)
               THEN CALL cl_err(g_imn[l_ac].imn16,'mfg6095',0)
                    NEXT FIELD imn16
            END IF
            CALL s_hqty(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                        g_imn[l_ac].imn16)
                    RETURNING g_cnt,t_imf04,t_imf05
                LET h_qty=t_imf04
            CALL  s_lwyn(g_imn[l_ac].imn15,g_imn[l_ac].imn16) 
					RETURNING sn1,sn2
			   IF sn1=1 AND g_imn[l_ac].imn16!=t_imn16
                  THEN CALL cl_err(g_imn[l_ac].imn16,'mfg6081',0)
                       LET t_imn16=g_imn[l_ac].imn16
                       NEXT FIELD imn16
                  ELSE IF sn2=2 AND g_imn[l_ac].imn16!=t_imn16
                          THEN CALL cl_err(g_imn[l_ac].imn16,'mfg6086',0)
                               LET t_imn16=g_imn[l_ac].imn16
                       NEXT FIELD imn16
                       END IF
               END IF
			LET sn1=0 LET sn2=0
            IF cl_null(g_imn[l_ac].imn16) THEN LET g_imn[l_ac].imn16=' ' END IF
            #No:7698 
           #IF p_cmd = 'u' THEN  #mandy test MARK 05/01/19
           #   CALL t324_chk_in() RETURNING g_i
           #   IF g_i THEN
           #       NEXT FIELD imn15
           #   END IF
           #END IF
           ###
           NEXT FIELD imn17
        AFTER FIELD imn17  
           #BugNo:5626 控管是否为全型空白
           IF g_imn[l_ac].imn17 = '　' THEN #全型空白
               LET g_imn[l_ac].imn17 = ' ' 
           END IF
           IF cl_null(g_imn[l_ac].imn17) THEN 
              LET g_imn[l_ac].imn17 = ' ' 
           END IF
           IF g_imn[l_ac].imn04=g_imn[l_ac].imn15 AND 
              g_imn[l_ac].imn05=g_imn[l_ac].imn16 THEN 
              IF ( g_imn[l_ac].imn06=g_imn[l_ac].imn17) OR 
                 ( g_imn[l_ac].imn06 IS NULL AND g_imn[l_ac].imn17 IS NULL) THEN 
                  CALL cl_err('','mfg6103',0)
                  NEXT FIELD imn17
              END IF
           END IF
           SELECT *
             FROM img_file WHERE img01=g_imn[l_ac].imn03 AND
                                 img02=g_imn[l_ac].imn15 AND
                                 img03=g_imn[l_ac].imn16 AND
                                 img04=g_imn[l_ac].imn17
           IF SQLCA.sqlcode THEN 
              IF NOT cl_confirm('mfg1401') THEN NEXT FIELD imn15 END IF
                 CALL s_add_img(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                                g_imn[l_ac].imn16,g_imn[l_ac].imn17,
                                g_imm.imm01      ,g_imn[l_ac].imn02,
                                g_imm.imm02)
              IF g_errno='N' THEN 
                  NEXT FIELD imn17 
              END IF
              IF cl_null(g_imn[l_ac].imn20) THEN
                 SELECT img09  INTO g_imn[l_ac].imn20
                   FROM img_file WHERE img01=g_imn[l_ac].imn03 AND
                                       img02=g_imn[l_ac].imn15 AND
                                       img03=g_imn[l_ac].imn16 AND
                                       img04=g_imn[l_ac].imn17
              END IF
           ELSE
              IF cl_null(g_imn[l_ac].imn20) THEN
                 SELECT img09  INTO g_imn[l_ac].imn20
                   FROM img_file WHERE img01=g_imn[l_ac].imn03 AND
                                       img02=g_imn[l_ac].imn15 AND
                                       img03=g_imn[l_ac].imn16 AND
                                       img04=g_imn[l_ac].imn17
              END IF
              CALL s_umfchk(g_imn[l_ac].imn03,
                            g_imn[l_ac].imn09,g_imn[l_ac].imn20)
                       RETURNING g_cnt,g_imn[l_ac].imn21
              IF g_cnt = 1 THEN 
                 CALL cl_err('','mfg3075',1)
                 NEXT FIELD imn17
              END IF
           END IF
           IF g_imn[l_ac].imn04 = g_imn[l_ac].imn15 AND 
              g_imn[l_ac].imn05 = g_imn[l_ac].imn16 AND 
              g_imn[l_ac].imn06 = g_imn[l_ac].imn17 
           THEN CALL cl_err('','mfg9090',1)
                NEXT FIELD imn15
           END IF
{           IF NOT s_actimg(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                           g_imn[l_ac].imn16,g_imn[l_ac].imn17)
           THEN CALL cl_err('inactive','mfg6117',0)
                NEXT FIELD imn15
           END IF}
           LET g_imn[l_ac].imn22=g_imn[l_ac].imn10*g_imn[l_ac].imn21

          #IF p_cmd = 'u' THEN  #mandy test MARK 05/01/19
          #   CALL t324_chk_in() RETURNING g_i
          #   IF g_i THEN
          #       NEXT FIELD imn17
          #   END IF
          #END IF

        AFTER FIELD imn20  
            CALL s_umfchk(g_imn[l_ac].imn03,
                          g_imn[l_ac].imn09,g_imn[l_ac].imn20)
                 RETURNING g_cnt,g_imn[l_ac].imn21
            IF g_cnt = 1 THEN 
               CALL cl_err('','mfg3075',1)
               NEXT FIELD imn20
            END IF
            LET g_imn[l_ac].imn22=g_imn[l_ac].imn10*g_imn[l_ac].imn21

        #No.160416----------BEGIN----------#
        #电商渠道仓库退货才允许输入退货理由
        BEFORE FIELD imnud21 
           IF NOT cl_null(g_imn[l_ac].imn04) THEN
              LET l_n=0
              SELECT COUNT(*) INTO l_n FROM tc_jhj_file
               WHERE tc_jhj002='2' AND tc_jhj004=g_imn[l_ac].imn04
              IF l_n>0 THEN
                 CALL cl_set_comp_entry("imnud21",TRUE)
              ELSE
                 LET g_imn[l_ac].imnud21=NULL
                 CALL cl_set_comp_entry("imnud21",FALSE)
              END IF
            END IF
        
        AFTER FIELD imnud21
           IF NOT cl_null(g_imn[l_ac].imnud21) THEN
              LET l_n=0
              SELECT COUNT(*) INTO l_n FROM azf_file
               WHERE azf01=g_imn[l_ac].imnud21
                 AND azf02='2' AND azf09='X'
              IF l_n=0 THEN
                 CALL cl_err("无此渠道退货理由","!",0)
                 NEXT FIELD imnud21
              END IF
           END IF
        #No.160416-----------END-----------#

        BEFORE DELETE                            #是否取消单身
            IF g_imn_t.imn02 > 0 AND g_imn_t.imn02 IS NOT NULL THEN
                IF NOT cl_delb(0,0) THEN
                     CANCEL DELETE
                END IF
                IF l_lock_sw = "Y" THEN 
                   CALL cl_err("", -263, 1) 
                   CANCEL DELETE 
                END IF 
                DELETE FROM imn_file
                    WHERE imn01 = g_imm.imm01 AND imn02 = g_imn_t.imn02
                IF SQLCA.sqlcode THEN
                    CALL cl_err(g_imn_t.imn02,SQLCA.sqlcode,0)
                    ROLLBACK WORK
                    CANCEL DELETE
                END IF
                LET g_rec_b=g_rec_b-1
                DISPLAY g_rec_b TO FORMONLY.cn2
		COMMIT WORK
            END IF

        ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_imn[l_ac].* = g_imn_t.*
               CLOSE t324_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            
            IF l_lock_sw = 'Y' THEN
               CALL cl_err(g_imn[l_ac].imn02,-263,1)
               LET g_imn[l_ac].* = g_imn_t.*
            ELSE
               CALL t324_b_move_back()
               #-----No:BUG-4A0054-----
                   IF NOT cl_null(g_imn[l_ac].imn03) THEN #BUG-4B0249(多包此IF 判断)
                      SELECT * FROM img_file
                       WHERE img01=g_imn[l_ac].imn03
                         AND img02=g_imn[l_ac].imn15
                         AND img03=g_imn[l_ac].imn16
                         AND img04=g_imn[l_ac].imn17
                      IF STATUS=100 THEN 
                         IF NOT cl_confirm('mfg1401') THEN
                            NEXT FIELD imn15
                         END IF
                         CALL s_add_img(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                                        g_imn[l_ac].imn16,g_imn[l_ac].imn17,
                                        g_imm.imm01,g_imn[l_ac].imn02,g_imm.imm02)
                         IF g_errno='N' THEN 
                             NEXT FIELD imn17 
                         END IF
                      END IF
                   END IF #BUG-4B0249
               #-----No:BUG-4A0054 END-----
               # Add by zm 06/01/17
               IF cl_null(b_imn.imn06) THEN LET b_imn.imn06=' ' END IF
               IF cl_null(b_imn.imn17) THEN LET b_imn.imn17=' ' END IF
               # End.
               UPDATE imn_file SET * = b_imn.*
                  WHERE imn01=g_imm.imm01 AND imn02=g_imn_t.imn02
               IF SQLCA.sqlcode THEN
                  CALL cl_err('upd imn',SQLCA.sqlcode,0)
                  LET g_imn[l_ac].* = g_imn_t.*
               ELSE
                  MESSAGE 'UPDATE O.K'
	          COMMIT WORK
               END IF
            END IF

        AFTER ROW
           LET l_ac = ARR_CURR()         # 新增
           LET l_ac_t = l_ac  

           IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd='u' THEN
                  LET g_imn[l_ac].* = g_imn_t.*
               END IF
               CLOSE t324_bcl
               ROLLBACK WORK
               EXIT INPUT
          #BUG-4C0090
          ##-----No:BUG-4A0054-----
          #ELSE
          #    IF NOT cl_null(g_imn[l_ac].imn03) THEN #BUG-4B0249(多包此IF 判断)
          #       SELECT * FROM img_file
          #        WHERE img01=g_imn[l_ac].imn03
          #          AND img02=g_imn[l_ac].imn15
          #          AND img03=g_imn[l_ac].imn16
          #          AND img04=g_imn[l_ac].imn17
          #       IF STATUS=100 THEN 
          #          IF NOT cl_confirm('mfg1401') THEN
          #             NEXT FIELD imn15
          #          END IF
          #          CALL s_add_img(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
          #                         g_imn[l_ac].imn16,g_imn[l_ac].imn17,
          #                         g_imm.imm01,g_imn[l_ac].imn02,g_imm.imm02)
          #          IF g_errno='N' THEN 
          #              NEXT FIELD imn17 
          #          END IF
          #       END IF
          #    END IF #BUG-4B0249
          ##-----No:BUG-4A0054 END-----
           END IF
           CLOSE t324_bcl
           COMMIT WORK

        ON ACTION gen_detail
           CALL t324_g1()
           EXIT INPUT

#       ON ACTION CONTROLN
#          CALL t324_b_askkey()
#          LET l_exit_sw = "n"
#          EXIT INPUT

        ON ACTION CONTROLO                        #沿用所有栏位
           IF INFIELD(imn02) AND l_ac > 1 THEN
              LET g_imn[l_ac].* = g_imn[l_ac-1].*
              LET g_imn[l_ac].imn02 = NULL
              NEXT FIELD imn02
           END IF

        ON ACTION controlp
           CASE WHEN INFIELD(imn03)
                     CALL cl_init_qry_var()
                     LET g_qryparam.form ="q_ima"
                     LET g_qryparam.default1 = g_imn[l_ac].imn03
                     CALL cl_create_qry() RETURNING g_imn[l_ac].imn03
                     DISPLAY BY NAME g_imn[l_ac].imn03  #No:BUG-490371
                     NEXT FIELD imn03
                WHEN INFIELD(imn04) OR INFIELD(imn05) OR INFIELD(imn06)
                   CALL q_img4(FALSE,FALSE,g_imn[l_ac].imn03,g_imn[l_ac].imn04,
                                   g_imn[l_ac].imn05,g_imn[l_ac].imn06,'A')
                      RETURNING    g_imn[l_ac].imn04,
                                   g_imn[l_ac].imn05,g_imn[l_ac].imn06
                   #No.BUG-490028
                   DISPLAY g_imn[l_ac].imn04 TO imn04
                   DISPLAY g_imn[l_ac].imn05 TO imn05
                   DISPLAY g_imn[l_ac].imn06 TO imn06
                   #No.BUG-490028(end)
                   IF cl_null(g_imn[l_ac].imn05) THEN LET g_imn[l_ac].imn05 = ' ' END IF
                   IF cl_null(g_imn[l_ac].imn06) THEN LET g_imn[l_ac].imn06 = ' ' END IF
                   IF INFIELD(imn04) THEN NEXT FIELD imn04 END IF
                   IF INFIELD(imn05) THEN NEXT FIELD imn05 END IF
                   IF INFIELD(imn06) THEN NEXT FIELD imn06 END IF
                WHEN INFIELD(imn15) OR INFIELD(imn16) OR INFIELD(imn17)
                   CALL q_img4(FALSE,FALSE,g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                                   g_imn[l_ac].imn16,g_imn[l_ac].imn17,'A')
                      RETURNING    g_imn[l_ac].imn15,
                                   g_imn[l_ac].imn16,g_imn[l_ac].imn17
                   #No.BUG-490028
                   DISPLAY g_imn[l_ac].imn15 TO imn15
                   DISPLAY g_imn[l_ac].imn16 TO imn16
                   DISPLAY g_imn[l_ac].imn17 TO imn17
                   #No.BUG-490028(end)
                   IF cl_null(g_imn[l_ac].imn16) THEN LET g_imn[l_ac].imn16 = ' ' END IF
                   IF cl_null(g_imn[l_ac].imn17) THEN LET g_imn[l_ac].imn17 = ' ' END IF
                   IF INFIELD(imn15) THEN NEXT FIELD imn15 END IF
                   IF INFIELD(imn16) THEN NEXT FIELD imn16 END IF
                   IF INFIELD(imn17) THEN NEXT FIELD imn17 END IF
               WHEN INFIELD(imn28) #理由
                    CALL cl_init_qry_var()
                    LET g_qryparam.form     = "q_azf"
                    LET g_qryparam.default1 = g_imn[l_ac].imn28
                    LET g_qryparam.arg1     = "2"
                    CALL cl_create_qry() RETURNING g_imn[l_ac].imn28
#                    CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn28 )
                    DISPLAY BY NAME g_imn[l_ac].imn28   #No:BUG-490371
                    NEXT FIELD imn28

               #No.160416----------BEGIN----------#
               WHEN INFIELD(imnud21)
                  CALL cl_init_qry_var()
                  LET g_qryparam.form ="q_azf02"
                  LET g_qryparam.arg1="2"
                  LET g_qryparam.arg2="X"
                  CALL cl_create_qry() RETURNING g_imn[l_ac].imnud21
                  DISPLAY BY NAME g_imn[l_ac].imnud21
                  NEXT FIELD imnud21
               #No.160416-----------END-----------#
           END CASE


      ON ACTION mntn_reason #理由
                   CALL cl_cmdrun("aooi301")
      ON ACTION mntn_stock #建立仓库别
                   LET g_cmd = 'aimi200 x'
                   CALL cl_cmdrun(g_cmd)
      ON ACTION mntn_loc  #建立储位别
                   LET g_cmd = "aimi201 '",g_imn[l_ac].imn16,"'" #BugNo:6598
                   CALL cl_cmdrun(g_cmd)

      ON ACTION qry_tro_imf #预设仓库/ 储位
                CASE
                   WHEN INFIELD(imn04)
                        CALL cl_init_qry_var()
                        LET g_qryparam.form     = "q_imf"
                        LET g_qryparam.default1 = g_imn[l_ac].imn04
                        LET g_qryparam.default2 = g_imn[l_ac].imn05
                        LET g_qryparam.arg1     = g_imn[l_ac].imn03
                        LET g_qryparam.arg2     = "A"
                        CALL cl_create_qry() RETURNING g_imn[l_ac].imn04,g_imn[l_ac].imn05
#                        CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn04 )
#                        CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn05 )
                        NEXT FIELD imn04
                   WHEN INFIELD(imn15)
                        CALL cl_init_qry_var()
                        LET g_qryparam.form     = "q_imf"
                        LET g_qryparam.default1 = g_imn[l_ac].imn15
                        LET g_qryparam.default2 = g_imn[l_ac].imn16
                        LET g_qryparam.arg1     = g_imn[l_ac].imn03
                        LET g_qryparam.arg2     = "A"
                        CALL cl_create_qry() RETURNING g_imn[l_ac].imn15,g_imn[l_ac].imn16
#                        CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn15 )
#                        CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn16 )
                        NEXT FIELD imn15
                END CASE
							
#      ON ACTION qry_tri_imf  #预设仓库/ 储位
#                  CALL cl_init_qry_var()
#                  LET g_qryparam.form     = "q_imf"
#                  LET g_qryparam.default1 = g_imn[l_ac].imn15
#                  LET g_qryparam.default2 = g_imn[l_ac].imn16
#                  LET g_qryparam.arg1     = g_imn[l_ac].imn03
#                  LET g_qryparam.arg2     = "A"
#                  CALL cl_create_qry() RETURNING g_imn[l_ac].imn15,g_imn[l_ac].imn16
#                  CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn15 )
#                  CALL FGL_DIALOG_SETBUFFER( g_imn[l_ac].imn16 )
#                  NEXT FIELD imn15

        ON ACTION CONTROLZ
           CALL cl_show_req_fields()

        ON ACTION CONTROLG CALL cl_cmdask()

        ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name #Add on 040913
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
          
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE INPUT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
    
    END INPUT

    UPDATE imm_file SET immmodu=g_usesr,immdate=g_today
     WHERE imm01=g_imm.imm01

    SELECT COUNT(*) INTO g_cnt FROM imn_file WHERE imn01=g_imm.imm01

    CLOSE t324_bcl
    COMMIT WORK
END FUNCTION
   
FUNCTION t324_b_move_to()
	LET g_imn[l_ac].imn02=b_imn.imn02
	LET g_imn[l_ac].imnud04=b_imn.imnud04   #No:120425
	LET g_imn[l_ac].imn03=b_imn.imn03
	LET g_imn[l_ac].imn28=b_imn.imn28
	LET g_imn[l_ac].imn04=b_imn.imn04
	LET g_imn[l_ac].imn05=b_imn.imn05
	LET g_imn[l_ac].imn06=b_imn.imn06
	LET g_imn[l_ac].imn09=b_imn.imn09
	LET g_imn[l_ac].imn10=b_imn.imn10
	LET g_imn[l_ac].imn15=b_imn.imn15
	LET g_imn[l_ac].imn16=b_imn.imn16
	LET g_imn[l_ac].imn17=b_imn.imn17
	LET g_imn[l_ac].imn20=b_imn.imn20
	LET g_imn[l_ac].imn21=b_imn.imn21
	LET g_imn[l_ac].imn22=b_imn.imn22
  LET g_imn[l_ac].imnud21=b_imn.imnud21       #No.160416
  LET g_imn[l_ac].imnud08=b_imn.imnud08       #No.160718
END FUNCTION
   
FUNCTION t324_b_move_back()
	LET b_imn.imn02=g_imn[l_ac].imn02
	LET b_imn.imnud04=g_imn[l_ac].imnud04   #No:120425
	LET b_imn.imn03=g_imn[l_ac].imn03
	LET b_imn.imn28=g_imn[l_ac].imn28
	LET b_imn.imn04=g_imn[l_ac].imn04
	LET b_imn.imn05=g_imn[l_ac].imn05
	LET b_imn.imn06=g_imn[l_ac].imn06
	LET b_imn.imn09=g_imn[l_ac].imn09
	LET b_imn.imn10=g_imn[l_ac].imn10
	LET b_imn.imn15=g_imn[l_ac].imn15
	LET b_imn.imn16=g_imn[l_ac].imn16
	LET b_imn.imn17=g_imn[l_ac].imn17
	LET b_imn.imn20=g_imn[l_ac].imn20
	LET b_imn.imn21=g_imn[l_ac].imn21
	LET b_imn.imn22=g_imn[l_ac].imn22
	LET b_imn.imn14=''
	LET b_imn.imn26=''
  LET b_imn.imnud21=g_imn[l_ac].imnud21   #No.160416
  LET b_imn.imnud08=g_imn[l_ac].imnud08   #No.160718
END FUNCTION
   
FUNCTION t324_b_askkey()
DEFINE l_wc2           VARCHAR(200)

    CONSTRUCT l_wc2 ON imn03,imn28,imn04,imn05,imn17,imn09,imn10,
                       imn15,imn16,imn17,imn20,imn21,imn22
            FROM s_imn[1].imn02,s_imn[1].imn03,s_imn[1].imn28,s_imn[1].imn04,
				 s_imn[1].imn05,s_imn[1].imn09,s_imn[1].imn10,
                 s_imn[1].imn15,s_imn[1].imn16,s_imn[1].imn17,
                 s_imn[1].imn20,s_imn[1].imn21,s_imn[1].imn22
       ON IDLE g_idle_seconds
          CALL cl_on_idle()
          CONTINUE CONSTRUCT
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
    
    END CONSTRUCT
    IF INT_FLAG THEN LET INT_FLAG = 0 RETURN END IF
    CALL t324_b_fill(l_wc2)
END FUNCTION

FUNCTION t324_b_fill(p_wc2)              #BODY FILL UP
DEFINE p_wc2           VARCHAR(200)

    LET g_sql =
        "SELECT imn02,imnud04,imn03,ima02,ima021,imn28,imn04,imn05,imn06,imn09,",    #No:120425
        "       imn15,imn16,imn17,imn20,imnud08,imn10,imn22,imn21,imnud21 ",                 #No.160416   #No.160718
        " FROM imn_file, OUTER ima_file ",
        " WHERE imn01 ='",g_imm.imm01,"'",  #单头
        "   AND imn03 = ima_file.ima01 AND ",p_wc2 CLIPPED,                     #单身
        " ORDER BY imn02"

    PREPARE t324_pb FROM g_sql
    DECLARE imn_curs CURSOR FOR t324_pb

    CALL g_imn.clear()

    LET g_cnt = 1
    FOREACH imn_curs INTO g_imn[g_cnt].*   #单身 ARRAY 填充
        IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
        LET g_cnt = g_cnt + 1
      # genero shell add g_max_rec check START
      IF g_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
	 EXIT FOREACH
      END IF
      # genero shell add g_max_rec check END
    END FOREACH
    CALL g_imn.deleteElement(g_cnt)
    LET g_rec_b=g_cnt - 1

    DISPLAY g_rec_b TO FORMONLY.cn2
END FUNCTION

FUNCTION t324_bp(p_ud)
   DEFINE   p_ud   VARCHAR(1)

   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)

   DISPLAY ARRAY g_imn TO s_imn.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)

      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )

      BEFORE ROW
         LET l_ac = ARR_CURR()

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
         CALL t324_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
                              
      ON ACTION previous
         CALL t324_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
                              
      ON ACTION jump
         CALL t324_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF

      ON ACTION next
         CALL t324_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF
                              
      ON ACTION last
         CALL t324_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   ###add in 040517
           IF g_rec_b != 0 THEN
         CALL fgl_set_arr_curr(1)  ######add in 040505
           END IF

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
         IF g_imm.imm03 = 'X' THEN
            LET g_void = 'Y'
         ELSE
            LET g_void = 'N'
         END IF
         #CALL cl_set_field_pic("","",g_imm.imm03,"",g_void,"")
         CALL cl_set_field_pic(g_imm.immconf,"",g_imm.imm03,"",g_void,"")    #No.160718

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DISPLAY
   #@ ON ACTION 过帐
      ON ACTION post
         LET g_action_choice="post"
         EXIT DISPLAY
   #@ ON ACTION 过帐还原
      ON ACTION undo_post
         LET g_action_choice="undo_post"
         EXIT DISPLAY
   #@ ON ACTION 作废
      ON ACTION void
         LET g_action_choice="void"
         EXIT DISPLAY
         
      #No.160718----------BEGIN----------#
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DISPLAY
         
      ON ACTION undo_confirm
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY
         
      ON ACTION maintain_return
         LET g_action_choice="maintain_return"
         EXIT DISPLAY
      
      ON ACTION quantity_confirm
         LET g_action_choice="quantity_confirm"
         EXIT DISPLAY         
      #No.160718-----------END-----------#   

      ON ACTION accept
         LET g_action_choice="detail"
         LET l_ac = ARR_CURR()
         EXIT DISPLAY
   
      ON ACTION cancel
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION exporttoexcel #FUN-4B0002
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
   
   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
display 'i324_bp ok'
   CALL cl_set_act_visible("accept,cancel", TRUE)

END FUNCTION
	
FUNCTION t324_bp_refresh()
   DISPLAY ARRAY g_imn TO s_imn.* ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
     ON ACTION about         #BUG-4C0121
        CALL cl_about()      #BUG-4C0121
 
     ON ACTION help          #BUG-4C0121
        CALL cl_show_help()  #BUG-4C0121
 
     ON ACTION controlg      #BUG-4C0121
        CALL cl_cmdask()     #BUG-4C0121
 
   
   END DISPLAY
END FUNCTION


FUNCTION t324_out()
    DEFINE l_wc,l_wc2   VARCHAR(100),
           l_prog       LIKE zz_file.zz01,
           l_prtway     LIKE zz_file.zz22
           
    IF g_imm.imm01 IS NULL THEN RETURN END IF

    #mod by xumin 101230--begin
#   LET g_msg = "aimr512 '",g_imm.imm01,"' '1'"
    LET g_msg = 'imm01="',g_imm.imm01,'" '
    LET g_msg = "aimr512 '",g_today,"' '",g_user,"' '",g_lang,"' ",
                " 'Y' ' ' '1' ",
                " '",g_msg CLIPPED,"' '1' "
    #mod by xumin 101230--end
    CALL cl_cmdrun(g_msg)
END FUNCTION

FUNCTION t324_s()
DEFINE l_cnt  INTEGER
DEFINE l_imn01  LIKE imn_file.imn01   #add by zhangbo120703
DEFINE l_imn02  LIKE imn_file.imn02   #add by zhangbo120703
DEFINE l_tc_rec05   LIKE  tc_rec_file.tc_rec05  #add by zhangbo120703
DEFINE l_sql   STRING                           #add by zhangbo120703
DEFINE l_imn10 LIKE imn_file.imn10              #add by zhangbo120703
DEFINE i       LIKE type_file.num5              #add by zhangbo120727

   IF s_shut(0) THEN RETURN END IF
    SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
   IF g_imm.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   IF g_imm.imm03 = 'X' THEN CALL cl_err('',9024,0) RETURN END IF
   #No.160718----------BEGIN----------#
   IF g_imm.immud19='Y' THEN
   	  IF g_imm.immconf='N' THEN 
   	  	 CALL cl_err("渠道退货单还未审核,不可过账","!",0)
   	  	 RETURN
   	  END IF
   	  LET g_imm.imm02=g_today	 
   END IF		
   #No.160718-----------END-----------#	
   IF g_imm.imm01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
	 IF g_sma.sma53 IS NOT NULL AND g_imm.imm02 <= g_sma.sma53 THEN
	   CALL cl_err('','mfg9999',0) RETURN
	 END IF
        CALL s_yp(g_imm.imm02) RETURNING g_yy,g_mm
        IF g_yy > g_sma.sma51			# 与目前会计年度,期间比较
        THEN CALL cl_err(g_yy,'mfg6090',0) RETURN
     #  ELSE IF g_mm > g_sma.sma52
        ELSE IF g_yy=g_sma.sma51 AND g_mm > g_sma.sma52
             THEN CALL cl_err(g_mm,'mfg6091',0) RETURN
             END IF
        END IF
   #No.+022 010328 by linda add 无单身不可确认
   LET l_cnt=0 
   SELECT COUNT(*) INTO l_cnt
     FROM imn_file
    WHERE imn01=g_imm.imm01
   IF l_cnt=0 OR l_cnt IS NULL THEN
      CALL cl_err('','mfg-009',0)
      RETURN
   END IF
   #No.+022 end---
   IF NOT cl_confirm('mfg0176') THEN RETURN END IF

   DECLARE t324_s1_c CURSOR FOR 
     SELECT * FROM imn_file WHERE imn01=g_imm.imm01

   BEGIN WORK 
    OPEN t324_cl USING g_imm_rowid
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
       CLOSE t324_cl
       ROLLBACK WORK 
       RETURN
    ELSE 
       FETCH t324_cl INTO g_imm.*          # 锁住将被更改或取消的资料
       IF SQLCA.sqlcode THEN
          CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
          CLOSE t324_cl
          ROLLBACK WORK 
          RETURN
       END IF
    END IF
    
    #No.160718----------BEGIN----------#
    IF g_imm.immud19='Y' THEN
    	 LET g_imm.imm02=g_today 
    	 UPDATE imm_file SET imm02=g_imm.imm02 WHERE imm01=g_imm.imm01
    	 IF SQLCA.sqlcode THEN
    	 	  CALL cl_err("更新退货日期失败","!",0)
    	 	  CLOSE t324_cl
          ROLLBACK WORK 
          RETURN
       END IF   
    END IF	
    #No.160718-----------END-----------#
    
    LET g_success = 'Y'
    
    CALL t332_expend()  #xf add 120408

#add by zhangbo120703---------------begin--------------
 {
  LET l_cnt=0
  SELECT COUNT(*) INTO l_cnt FROM imm_file,imn_file,imd_file WHERE imm01=imn01 AND imn04=imd01 AND imd07='Y' AND imm01=g_imm.imm01
  IF l_cnt>0 THEN
     LET l_sql=" SELECT imn01,imn02,imn10 FROM imn_file,imd_file WHERE imn01='",g_imm.imm01,"'",
               "                                                   AND imn04=imd01",
               "                                                   AND imd07='Y' "
     PREPARE t324_cpre FROM l_sql
     DECLARE t324_ccs CURSOR FOR t324_cpre

 
     FOREACH t324_ccs INTO l_imn01,l_imn02,l_imn10

        SELECT SUM(tc_rec05) INTO l_tc_rec05 FROM tc_rec_file WHERE tc_rec01=l_imn01 AND tc_rec02=l_imn02

        IF cl_null(l_tc_rec05) THEN LET l_tc_rec05=0 END IF

        IF l_imn10 <> l_tc_rec05 THEN
           CALL cl_err(l_imn02,"cim-333",1)
           ROLLBACK WORK
           RETURN
        END IF
    END FOREACH
  END IF
}
#add by zhangbo120703-----------------end--------------

    
    FOREACH t324_s1_c INTO b_imn.*
         IF STATUS THEN EXIT FOREACH END IF
         MESSAGE 's_ read parts:',b_imn.imn03 
         IF cl_null(b_imn.imn04) THEN CONTINUE FOREACH END IF

         #-->拨出更新
         IF t324_t(b_imn.*) THEN LET g_success = 'N' EXIT FOREACH END IF 

         #-->拨入更新
         IF t324_t2(b_imn.*) THEN  LET g_success ='N' EXIT FOREACH END IF
     END FOREACH
     
#add by zhangbo120727-----------------------begin---------------------
     IF g_success='Y' THEN
      
        LET l_cnt=0
        SELECT COUNT(*) INTO l_cnt FROM imm_file,imn_file,imd_file WHERE imm01=imn01 AND imn04=imd01 AND imd07='Y' AND imm01=g_imm.imm01
        IF l_cnt>0 THEN
        LET l_sql=" SELECT imn01,imn02,imn10 FROM imn_file,imd_file WHERE imn01='",g_imm.imm01,"'",
               "                                                   AND imn04=imd01",
               "                                                   AND imd07='Y' "
        PREPARE t324_cpre FROM l_sql
        DECLARE t324_ccs CURSOR FOR t324_cpre
        
        CALL l_show_msg.clear()
        LET i=1
 
        FOREACH t324_ccs INTO l_imn01,l_imn02,l_imn10

        SELECT SUM(tc_rec05) INTO l_tc_rec05 FROM tc_rec_file WHERE tc_rec01=l_imn01 AND tc_rec02=l_imn02

        IF cl_null(l_tc_rec05) THEN LET l_tc_rec05=0 END IF

        IF l_imn10 <> l_tc_rec05 THEN
            LET l_show_msg[i].imn01=l_imn01
            LET l_show_msg[i].imn02=l_imn02
            LET l_show_msg[i].imn10=l_imn10
            LET l_show_msg[i].tc_rec05=l_tc_rec05
            LET i=i+1
        END IF
        END FOREACH
        END IF
       
       IF i>1 THEN
          LET g_msg=NULL
          LET g_msg2 = '调拨单号' CLIPPED,'|','项次' CLIPPED,'|','调拨数量' CLIPPED,'|','核销数量'
          CALL cl_show_array(base.TypeInfo.create(l_show_msg),g_msg         ,g_msg2)
          LET g_success='N'
       END IF

     END IF   
#add by zhangbo120727-------------------------end---------------------     
   # UPDATE imm_file SET imm03 = 'Y',imm04='Y'  WHERE imm01 = g_imm.imm01
     UPDATE imm_file SET imm03 = 'Y',imm04='Y',immconf = 'Y'  WHERE imm01 = g_imm.imm01  #add by xumin 101230
     IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 
     THEN CALL cl_err('up imm_file',SQLCA.sqlcode,0)
          LET g_success = 'N'
     END IF
     IF g_success = 'Y'
      THEN 
         COMMIT WORK
         CALL cl_flow_notify(g_imm.imm01,'S')
         CALL cl_cmmsg(4)
      ELSE 
         ROLLBACK WORK
         CALL cl_rbmsg(4)
     END IF
   SELECT imm03 INTO g_imm.imm03 FROM imm_file WHERE imm01 = g_imm.imm01
   DISPLAY BY NAME g_imm.imm03 
#  MESSAGE ''
END FUNCTION

#-->拨出更新
FUNCTION t324_t(p_imn)      
DEFINE
    p_imn   RECORD LIKE imn_file.*,
    l_img   RECORD 
            rowid      VARCHAR(18),
            img16      LIKE img_file.img16,
            img23      LIKE img_file.img23,
            img24      LIKE img_file.img24,
            img09      LIKE img_file.img09,
            img21      LIKE img_file.img21
            END RECORD,
    l_qty   LIKE img_file.img10

    MESSAGE "update img_file ..."
    IF cl_null(p_imn.imn05) THEN LET p_imn.imn05=' ' END IF
    IF cl_null(p_imn.imn06) THEN LET p_imn.imn06=' ' END IF

    LET g_forupd_sql = 
        "SELECT rowid,img16,img23,img24,img09,img21,img26,img10 FROM img_file ",
        " WHERE img01= ? AND img02=  ? AND img03= ? AND img04=  ? FOR UPDATE NOWAIT "

    DECLARE img_lock CURSOR FROM g_forupd_sql
                  
    OPEN img_lock USING p_imn.imn03,p_imn.imn04,p_imn.imn05,p_imn.imn06
    IF SQLCA.sqlcode THEN
       CALL cl_err(p_imn.imn02,"cim-334",1)   #add by zhangbo120727
       LET g_success = 'N'
       RETURN 1
    ELSE 
       FETCH img_lock INTO l_img.*,g_debit,g_img10
       IF SQLCA.sqlcode THEN 
          CALL cl_err(p_imn.imn02,"cim-334",1)   #add by zhangbo120727
          LET g_success = 'N'
          RETURN 1
       END IF
    END IF 

   #No.+058 改成统一由s_upimg 去判断库存不足(sma894)的参数
   {
    IF g_img10 < p_imn.imn10 THEN
       IF g_sma.sma894[4,4]='N' THEN
          CALL cl_err(p_imn.imn03,'mfg3471',0)
          LET g_success = 'N'
          RETURN 1 
       END IF
    END IF
   }

#-->更新仓库库存明细资料
#                1           2  3           4
 #  CALL s_upimg(l_img.rowid,-1,p_imn.imn10,l_img.img16,
 #No.+435 010718  mod 
 #   CALL s_upimg(l_img.rowid,-1,p_imn.imn10,g_imm.imm02,
     CALL s_upimg(p_imn.imn03,p_imn.imn04,p_imn.imn05,p_imn.imn06,-1,p_imn.imn10,g_imm.imm02,
#       5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 
        '','','','','','','','','','','','','','','','','','')
    IF g_success = 'N' THEN RETURN 1 END IF

#-->若库存异动后其库存量小于等于零时将该笔资料删除
   # CALL s_delimg(l_img.rowid) 
    CALL s_delimg(p_imn.imn03,p_imn.imn04,p_imn.imn05,p_imn.imn06) 
 
#-->更新库存主档之库存数量 (单位为主档之库存单位)
    MESSAGE "update ima_file ..."

    LET g_forupd_sql = 
        "SELECT ima25,ima86 FROM ima_file WHERE ima01= ?  FOR UPDATE NOWAIT"
    DECLARE ima_lock CURSOR FROM g_forupd_sql

    OPEN ima_lock USING p_imn.imn03
    IF STATUS THEN
       CALL cl_err('lock ima fail',STATUS,1)
        LET g_success='N' RETURN  1
    END IF

    FETCH ima_lock INTO g_ima25,g_ima86
    IF STATUS THEN
       CALL cl_err('lock ima fail',STATUS,1)
        LET g_success='N' RETURN  1
    END IF

#-->料件库存单位数量
    LET l_qty=p_imn.imn10 * l_img.img21
	IF cl_null(l_qty)  THEN RETURN 1 END IF

    IF s_udima(p_imn.imn03,             #料件编号
			   l_img.img23,             #是否可用仓储
			   l_img.img24,             #是否为MRP可用仓储
			   l_qty,                   #调拨数量(换算为料件库存单位)
			   l_img.img16,             #最近一次拨出日期
			   -1)                      #表拨出
    	THEN RETURN 1 
	END IF
    IF g_success = 'N' THEN RETURN 1 END IF

#-->将已锁住之资料释放出来
    CLOSE img_lock  
    
	RETURN 0
END FUNCTION
   
FUNCTION t324_t2(p_imn)
DEFINE
    p_imn  RECORD LIKE imn_file.*,
    l_img   RECORD 
            rowid      VARCHAR(18),
            img16      LIKE img_file.img16,
            img23      LIKE img_file.img23,
            img24      LIKE img_file.img24,
            img09      LIKE img_file.img09,
            img21      LIKE img_file.img21,
            img19      LIKE img_file.img19,
            img27      LIKE img_file.img27,
            img28      LIKE img_file.img28,
            img35      LIKE img_file.img35,
            img36      LIKE img_file.img36
            END RECORD,
    l_factor   DECIMAL(16,8),
    l_qty LIKE img_file.img10

    LET g_forupd_sql = 
        "SELECT rowid,img16,img23,img24,img09,img21,img19,img27,",
               "img28,img35,img36,img26,img10 FROM img_file ",
        " WHERE img01= ? AND img02= ? AND img03= ? AND img04= ? ",
        " FOR UPDATE NOWAIT"
    DECLARE img2_lock CURSOR FROM g_forupd_sql

    OPEN img2_lock USING p_imn.imn03,p_imn.imn15,p_imn.imn16,p_imn.imn17
    IF SQLCA.sqlcode THEN 
       CALL cl_err('lock img2 fail',STATUS,1)
       LET g_success = 'N' RETURN 1
    END IF

    FETCH img2_lock INTO l_img.*,g_credit,g_img10_2
    IF SQLCA.sqlcode THEN 
       CALL cl_err('lock img2 fail',STATUS,1)
       LET g_success = 'N' RETURN 1
    END IF

#-->更新库存主档之库存数量 (单位为主档之库存单位)
    MESSAGE "update ima2_file ..."
    LET g_forupd_sql = 
        "SELECT ima25,ima86 FROM ima_file WHERE ima01= ? FOR UPDATE NOWAIT "
    DECLARE ima2_lock CURSOR FROM g_forupd_sql

    OPEN ima2_lock USING p_imn.imn03
    IF SQLCA.sqlcode THEN 
       CALL cl_err('lock ima fail',STATUS,1)
        LET g_success='N' RETURN  1
    END IF
    FETCH ima2_lock INTO g_ima25_2,g_ima86_2
    IF SQLCA.sqlcode THEN 
       CALL cl_err('lock ima fail',STATUS,1)
        LET g_success='N' RETURN  1
    END IF
    IF cl_null(g_ima86_2) THEN LET g_ima86_2 = 1 END IF

## No:2508 modify 1998/10/07 -------
    CALL s_umfchk(p_imn.imn03,p_imn.imn09,l_img.img09) RETURNING g_cnt,l_factor
{    IF g_cnt = 1 THEN 
       CALL cl_err('','mfg3075',1)
       LET g_success = 'N' 
       RETURN 1
    END IF}
    LET l_qty = p_imn.imn10 * l_factor
## ----------------------------------

  #  CALL s_upimg(l_img.rowid,+1,p_imn.imn22,g_imm.imm02,
  # CALL s_upimg(p_imn.imn03,p_imn.imn04,p_imn.imn05,p_imn.imn06,+1,p_imn.imn22,g_imm.imm02,
    CALL s_upimg(p_imn.imn03,p_imn.imn15,p_imn.imn16,p_imn.imn17,+1,p_imn.imn22,g_imm.imm02,
#       5           6           7           8         
        p_imn.imn03,p_imn.imn15,p_imn.imn16,p_imn.imn17,
#       9           10          11          12          13
#       p_imn.imn01,p_imn.imn02,l_img.img09,p_imn.imn22,l_img.img09,  
        p_imn.imn01,p_imn.imn02,l_img.img09,l_qty,      l_img.img09,  
#       14  15          16
        1,  l_img.img21,1,        
#       17          18          19          20          21
        g_credit,l_img.img35,l_img.img27,l_img.img28,l_img.img19,
        l_img.img36)

    IF g_success = 'N' THEN RETURN 1 END IF

#-->更新库存主档之库存数量 (单位为主档之库存单位)
    LET l_qty = p_imn.imn22 * l_img.img21
    IF s_udima(p_imn.imn03,            #料件编号
			   l_img.img23,            #是否可用仓储
			   l_img.img24,            #是否为MRP可用仓储
			   l_qty,                  #发料数量(换算为料件库存单位)
			   l_img.img16,            #最近一次发料日期
			   +1)                     #表收料
         THEN RETURN  1 END IF 
    IF g_success = 'N' THEN RETURN 1 END IF
#-->产生异动记录档
    #---- 97/06/20 insert 两笔至 tlf_file 一出一入
    CALL t324_log_2(1,0,'1',p_imn.*) #RETURN 0
    CALL t324_log_2(1,0,'0',p_imn.*) RETURN 0
END FUNCTION

#--------------------------------------------------------------------
#处理异动记录
FUNCTION t324_log_2(p_stdc,p_reason,p_code,p_imn)
DEFINE
    p_stdc          SMALLINT,		 #是否需取得标准成本
    p_reason        SMALLINT,		 #是否需取得异动原因
    p_code          VARCHAR(01),            #出/入库
    p_imn           RECORD LIKE imn_file.*  
DEFINE l_imd07      LIKE   imd_file.imd07    #add by zhangbo150403
DEFINE l_price      LIKE   imn_file.imnud07  #add by zhangbo150403
DEFINE l_type       LIKE   imn_file.imnud02  #add by zhangbo150403

#----来源----
    LET g_tlf.tlf01=p_imn.imn03 	        #异动料件编号
    LET g_tlf.tlf02=50         	 	        #来源为仓库(拨出)
    LET g_tlf.tlf020=g_plant                    #工厂别
    LET g_tlf.tlf021=p_imn.imn04   	        #仓库别
    LET g_tlf.tlf022=p_imn.imn05	        #储位别
    LET g_tlf.tlf023=p_imn.imn06         	#批号
    LET g_tlf.tlf024=g_img10 - p_imn.imn10      #异动后库存数量
    LET g_tlf.tlf025=p_imn.imn09                #库存单位(ima_file or img_file)
    LET g_tlf.tlf026=p_imn.imn01                #调拨单号
    LET g_tlf.tlf027=p_imn.imn02                #项次
#----目的----
    LET g_tlf.tlf03=50         	                #资料目的为(拨入)
    LET g_tlf.tlf030=g_plant                    #工厂别
    LET g_tlf.tlf031=p_imn.imn15                #仓库别
    LET g_tlf.tlf032=p_imn.imn16                #储位别
    LET g_tlf.tlf033=p_imn.imn17  	        #批号
    LET g_tlf.tlf034=g_img10_2 + p_imn.imn22    #异动后库存量
    LET g_tlf.tlf035=p_imn.imn20             	#库存单位(ima_file or img_file)
    LET g_tlf.tlf036=p_imn.imn01                #参考号码
    LET g_tlf.tlf037=p_imn.imn02                #项次      

    #---- 97/06/20 调拨作业来源目的码
    IF p_code='1' THEN #-- 出
       LET g_tlf.tlf02=50         	 	
       LET g_tlf.tlf03=99         	 	
       LET g_tlf.tlf030=' '                    
       LET g_tlf.tlf031=' '                   
       LET g_tlf.tlf032=' '                   
       LET g_tlf.tlf033=' '          	       
       LET g_tlf.tlf034=0 
       LET g_tlf.tlf035=' '                     
       LET g_tlf.tlf036=' '                    
       LET g_tlf.tlf037=0                     
       LET g_tlf.tlf10=p_imn.imn10                 #调拨数量
       LET g_tlf.tlf11=p_imn.imn09                 #拨出单位
       LET g_tlf.tlf12=1                           #拨出/拨入库存转换率
    ELSE               #-- 入
       LET g_tlf.tlf02=99         	 	
       LET g_tlf.tlf03=50         	 	
       LET g_tlf.tlf020=' '                    
       LET g_tlf.tlf021=' '                  
       LET g_tlf.tlf022=' '                  
       LET g_tlf.tlf023=' '                  
       LET g_tlf.tlf024=0 
       LET g_tlf.tlf025=' '                    
       LET g_tlf.tlf026=' '                   
       LET g_tlf.tlf027=0                    
       LET g_tlf.tlf10=p_imn.imn22                 #调拨数量
       LET g_tlf.tlf11=p_imn.imn20                 #拨入单位
       LET g_tlf.tlf12=1                           #拨入/拨出库存转换率
       #add by zhangbo150403---begin
       #厂价管理仓库需要记录厂价 
       LET l_imd07=''
       SELECT imd07 INTO l_imd07 FROM imd_file WHERE imd=p_imn.imn15
       IF l_imd07='Y' THEN
          SELECT xmf07,ta_xmf02 INTO l_price,l_type FROM xmf_file
           WHERE xmf03 = p_imn.imn03
             AND xmf01 = 'A1'       #No.160406
             AND xmf05 IN (SELECT MAX(xmf05) FROM xmf_file WHERE xmf03 = p_imn.imn03 AND xmf01 = 'A1')
          #No.160406----------BEGIN----------#
          #取不到价格,可能是服务营销赠品,那么再取一遍杂发单价
          IF STATUS = 100 THEN
             SELECT ta_xmf01,ta_xmf02 INTO l_price,l_type FROM xmf_file
              WHERE xmf03 = p_imn.imn03
                AND xmf01 = 'W1'
                AND xmf05 IN (SELECT MAX(xmf05) FROM xmf_file WHERE xmf03 = p_imn.imn03 AND xmf01 = 'W1')
          END IF 
          #No.160406-----------END-----------#
          LET g_tlf.tlf151=l_price
          LET g_tlf.tlf161=l_type
       END IF 
       #add by zhangbo150403---end 
    END IF

#--->异动数量
    LET g_tlf.tlf04=' '                         #工作站
    LET g_tlf.tlf05=' '                         #作业序号
    LET g_tlf.tlf06=g_imm.imm02                 #发料日期
    LET g_tlf.tlf07=g_today                     #异动资料产生日期  
    LET g_tlf.tlf08=TIME                        #异动资料产生时:分:秒
    LET g_tlf.tlf09=g_user                      #产生人
    LET g_tlf.tlf13='aimt324'                   #异动命令代号
    LET g_tlf.tlf14=p_imn.imn28                 #异动原因
    LET g_tlf.tlf15=g_debit                     #借方会计科目
    LET g_tlf.tlf16=g_credit                    #贷方会计科目
    LET g_tlf.tlf17=g_imm.imm09                 #remark
    CALL s_imaQOH(p_imn.imn03)
         RETURNING g_tlf.tlf18                  #异动后总库存量
    LET g_tlf.tlf19= ' '                        #异动厂商/客户编号
    LET g_tlf.tlf20= ' '                        #project no.      
    LET g_tlf.tlf61= g_ima86
    CALL s_tlf(p_stdc,p_reason)
END FUNCTION

FUNCTION t324_x()
   IF s_shut(0) THEN RETURN END IF
   SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
   IF g_imm.imm01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_imm.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   IF g_imm.immconf='Y' THEN CALL cl_err('',9023,0) RETURN END IF      #No.160718
   
   BEGIN WORK

   OPEN t324_cl USING g_imm_rowid
   IF SQLCA.sqlcode THEN 
      CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0) 
      CLOSE t324_cl
      ROLLBACK WORK
      RETURN 
   ELSE 
      FETCH t324_cl INTO g_imm.*
      IF SQLCA.sqlcode THEN 
         CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0) 
         CLOSE t324_cl
         ROLLBACK WORK
         RETURN 
      END IF
   END IF
   IF cl_void(0,0,g_imm.imm03) THEN
       LET g_chr=g_imm.imm03
       IF g_imm.imm03 = 'N' THEN
           LET g_imm.imm03 = 'X'
       ELSE
           LET g_imm.imm03 = 'N'
       END IF
       UPDATE imm_file 
           SET imm03   = g_imm.imm03,
               immmodu = g_user,
               immdate = g_today
           WHERE imm01 = g_imm.imm01
       IF SQLCA.sqlcode OR SQLCA.SQLERRD[3]=0 THEN
           CALL cl_err('up imm03:',SQLCA.sqlcode,0)
           LET g_imm.imm03 = g_chr
       END IF
       DISPLAY BY NAME g_imm.imm03 
   END IF
   CLOSE t324_cl
   COMMIT WORK
   CALL cl_flow_notify(g_imm.imm01,'V')
END FUNCTION
#No:7698
#check 拨出:料/仓/储/批 
#(1)数量是否大于0 
#(2)是否有效
#(3)重算拨出/入的换算率 及拨入数量
FUNCTION t324_chk_out()
  DEFINE l_img10 LIKE img_file.img10
    SELECT img09,img10  
      INTO g_imn[l_ac].imn09,l_img10
      FROM img_file 
     WHERE img01=g_imn[l_ac].imn03 
       AND img02=g_imn[l_ac].imn04 
       AND img03=g_imn[l_ac].imn05 
       AND img04=g_imn[l_ac].imn06
{    IF SQLCA.sqlcode THEN 
        LET l_img10 = 0
        #在库存明细资料查无该笔, 请重新输入!!
        CALL cl_err(g_imn[l_ac].imn06,'mfg6101',1)
        RETURN 1
    END IF
    IF l_img10 <=0 THEN
        #库存不足是否许调拨出库='N'
        IF g_sma.sma894[4,4]='N' OR g_sma.sma894[4,4] IS NULL THEN    
            #目前已无库存量无法执行调拨动作
            CALL cl_err(l_img10,'mfg3471',1)
            RETURN 1
        END IF
    END IF}
    #-->有效日期
 {   IF NOT s_actimg(g_imn[l_ac].imn03,g_imn[l_ac].imn04,
                    g_imn[l_ac].imn05,g_imn[l_ac].imn06) THEN
        CALL cl_err('inactive','mfg6117',1) 
        RETURN 1
    END IF}
    CALL s_umfchk(g_imn[l_ac].imn03,g_imn[l_ac].imn09,g_imn[l_ac].imn20)
             RETURNING g_cnt,g_imn[l_ac].imn21
{    IF g_cnt = 1 THEN 
        CALL cl_err('','mfg3075',1)
        RETURN 1
    END IF}
    LET g_imn[l_ac].imn22=g_imn[l_ac].imn10*g_imn[l_ac].imn21
    IF g_imn[l_ac].imn09 <> g_imn_t.imn09 THEN
        #拨出:仓/储/批的单位已变了,请注意拨出数量是否正确
        CALL cl_err('','aim-324',0)
    END IF
    RETURN 0
END FUNCTION

#No:7698
#check 拨入:料/仓/储/批 
#(1)是否有效
#(2)重算拨出/入的换算率 及拨入数量
FUNCTION t324_chk_in()
    SELECT img09  INTO g_imn[l_ac].imn20
      FROM img_file 
     WHERE img01=g_imn[l_ac].imn03 
       AND img02=g_imn[l_ac].imn15 
       AND img03=g_imn[l_ac].imn16 
       AND img04=g_imn[l_ac].imn17
    IF SQLCA.sqlcode THEN 
        RETURN 1
    END IF
{    IF NOT s_actimg(g_imn[l_ac].imn03,g_imn[l_ac].imn15,
                    g_imn[l_ac].imn16,g_imn[l_ac].imn17) THEN
        CALL cl_err('inactive','mfg6117',1)
        RETURN 1 
    END IF}
    CALL s_umfchk(g_imn[l_ac].imn03,g_imn[l_ac].imn09,g_imn[l_ac].imn20)
                  RETURNING g_cnt,g_imn[l_ac].imn21
 {   IF g_cnt = 1 THEN 
        CALL cl_err('','mfg3075',1)
        RETURN 1
    END IF}
    LET g_imn[l_ac].imn22=g_imn[l_ac].imn10*g_imn[l_ac].imn21
    RETURN 0
END FUNCTION

#xf add 120408  --begin
FUNCTION t332_expend()
   
   DEFINE l_imn RECORD LIKE imn_file.*
   DEFINE l_tlf RECORD LIKE tlf_file.*
   DEFINE l_sql    STRING
   DEFINE l_success LIKE type_file.chr1
   DEFINE l_num     LIKE imn_file.imn10
   DEFINE l_cnt     LIKE type_file.num5 
   DEFINE l_sum     LIKE type_file.num5
   DEFINE l_tlf151_bak,l_tlf161_bak  LIKE tlf_file.tlf151  #xf add 120326
   DEFINE l_countx  SMALLINT #xf add 120326
   DEFINE l_tc_rec05 LIKE tc_rec_file.tc_rec05 #xf add 120408
   DEFINE l_imn02    LIKE imn_file.imn02  #xf add 120408
   DEFINE l_tlf931  LIKE tlf_file.tlf931        #add by liudong 130904
   
   SELECT * INTO g_imm.* FROM imm_file WHERE imm01 = g_imm.imm01
   
   IF g_imm.imm03 = 'Y' THEN CALL cl_err('资料已过账','!',0) RETURN END IF
   IF g_imm.imm03 = 'X' THEN CALL cl_err('资料已作废','!',0) RETURN END IF
  
   LET l_success = 'Y'
   LET l_sql = "SELECT imn_file.* FROM imn_file,imm_file,imd_file ",
               " WHERE imm01 = imn01 ",
               "   AND imn01 = '",g_imm.imm01,"' ", 
               "   AND imn04=imd01 ",
               "   AND imd07='Y'"   #出货仓库是分销商仓库 
   PREPARE imn_pb1 FROM l_sql
   DECLARE imn_cs1 CURSOR FOR imn_pb1
   FOREACH imn_cs1 INTO l_imn.*
       
       IF STATUS THEN
          CALL cl_err('foreach:',STATUS,1)
          LET l_success = 'N'
          EXIT FOREACH
       END IF
       
       #需要调拨数据
       LET l_num = l_imn.imn10 
       
       #                    单号，项次，单据日期，数量，厂价，厂价类型
       LET l_sql = " SELECT tlf905,tlf906,tlf06,tlf10,tlf151,tlf161 ",
                   "   FROM tlf_file ", 
                   "  WHERE tlf907 = '1'  ",
                   "    AND tlf902 = '",l_imn.imn04,"' ",  #仓库
                   "    AND tlf01 = '",l_imn.imn03,"' ",   #料号
                   " ORDER BY tlf06,tlf905,tlf906"  
       PREPARE tlf_pb1 FROM l_sql
       DECLARE tlf_cs1 CURSOR FOR tlf_pb1
       
       LET l_countx=0
       LET l_tlf151_bak=NULL
       LET l_tlf161_bak=NULL
       
       FOREACH tlf_cs1 INTO l_tlf.tlf905,l_tlf.tlf906,l_tlf.tlf06,l_tlf.tlf10,l_tlf.tlf151,l_tlf.tlf161
          IF STATUS THEN
             CALL cl_err('foreach:',STATUS,1)
             LET l_success = 'N'
             EXIT FOREACH
          END IF
       
          #已核销数量
          SELECT SUM(tc_rec05) INTO l_sum 
            FROM tc_rec_file
           WHERE tc_rec03 = l_tlf.tlf905
             AND tc_rec04 = l_tlf.tlf906
          IF cl_null(l_sum) THEN 
          	 LET l_sum = 0
          END IF
          
          #如果批次已核销数量<批次总数量
          IF l_sum < l_tlf.tlf10 THEN 
          	 LET l_tlf.tlf10 = l_tlf.tlf10 - l_sum  #算出批次未核销数量
          ELSE 
          	 CONTINUE FOREACH 
          END IF    	
          
          #如果出厂价格和价格类型不一致，则不能异动成功
          IF l_countx <>0 THEN
             IF l_tlf.tlf151 <> l_tlf151_bak OR l_tlf.tlf161 <>l_tlf161_bak THEN
                
                #已核销数量
                SELECT SUM(tc_rec05) INTO l_tc_rec05
                  FROM tc_rec_file
                 WHERE tc_rec01=l_imn.imn01
                   AND tc_rec02=l_imn.imn02
                LET g_msg="第 ",l_imn.imn02 USING '<<<'," 项次，",l_imn.imn03," 料号的拨出数量包括多个厂价，请将调拨数量分开录入!",
                          "其中先第一部分的数量是:",l_tc_rec05
                CALL cl_err(g_msg,'!',1)
                LET g_success='N'                
                EXIT FOREACH
             END IF
          END IF
          
          #未核销数量   	
          LET l_imn.imnud11 = l_tlf.tlf10
          
          #未核销数量 <= 需求数量 --> 未核销数量全部核销,同时减少”需要数量“
          IF l_imn.imnud11 <= l_num THEN
             
             INSERT INTO tc_rec_file(tc_rec01,tc_rec02,tc_rec03,tc_rec04,tc_rec05)
                 VALUES (l_imn.imn01,l_imn.imn02,l_tlf.tlf905,l_tlf.tlf906,l_imn.imnud11)
             IF STATUS THEN
                CALL cl_err('插入tc_rec_file失败','!',0)
                LET g_success='N'
             END IF
             
             #更新tlf931
             #重新取已匹配数量  add by liudong 130904
             SELECT SUM(tc_rec05) INTO l_tlf931
               FROM tc_rec_file
              WHERE tc_rec03 = l_tlf.tlf905
                AND tc_rec04 = l_tlf.tlf906
             IF cl_null(l_tlf931) THEN
                CALL cl_err('取已匹配数量失败','!',0)
                LET g_success='N'
             ELSE
             #更新tlf931
             #UPDATE tlf_file SET tlf931=nvl(tlf931,0)+l_imn.imnud11
             UPDATE tlf_file SET tlf931=l_tlf931
              WHERE tlf905=l_tlf.tlf905
                AND tlf906=l_tlf.tlf906
             END IF    
             #减少需要数量
             LET l_num = l_num - l_imn.imnud11
             
          #未核销数量 > 需求数量 --> 核销数量=需求数量，同时需要数量置为0
          ELSE 
          	
             INSERT INTO tc_rec_file(tc_rec01,tc_rec02,tc_rec03,tc_rec04,tc_rec05)
                 VALUES (l_imn.imn01,l_imn.imn02,l_tlf.tlf905,l_tlf.tlf906,l_num)
             IF STATUS THEN
                CALL cl_err('插入tc_rec_file失败','!',0)
                LET g_success='N'
             END IF
             
             #更新tlf931
             #重新取已匹配数量  add by liudong 130904
             SELECT SUM(tc_rec05) INTO l_tlf931
               FROM tc_rec_file
              WHERE tc_rec03 = l_tlf.tlf905
                AND tc_rec04 = l_tlf.tlf906
             IF cl_null(l_tlf931) THEN
                CALL cl_err('取已匹配数量失败','!',0)
                LET g_success='N'
             ELSE
             #更新tlf931
             #UPDATE tlf_file SET tlf931=nvl(tlf931,0)+l_num
             UPDATE tlf_file SET tlf931=l_tlf931
              WHERE tlf905=l_tlf.tlf905
                AND tlf906=l_tlf.tlf906
             END IF    
             #需求数量置为0    
             LET l_num = 0
             
          END IF 
          
          IF l_num = 0 THEN 
             EXIT FOREACH
          END IF
       
          #执行完备份 出厂价格和价格类型
          LET l_tlf151_bak=l_tlf.tlf151
          LET l_tlf161_bak=l_tlf.tlf161
          
          LET l_countx=l_countx+1
          
       END FOREACH

       #记录出厂价格和价格类型 ==》拨入仓库取厂价的来源
       UPDATE imn_file SET imnud07=l_tlf.tlf151,
                           imnud02=l_tlf.tlf161
       WHERE imn01=l_imn.imn01
         AND imn02=l_imn.imn02
       IF STATUS THEN
          CALL cl_err('更新单身的出厂价格和价格类型 失败','!',0)
          LET g_success='N'
       END IF
       
   END FOREACH 

   #检查有没有核销数量和调拨数量不一致的项次
   LET g_sql="SELECT imn02 FROM (",
             "   SELECT imm01,imn02,imn10,nvl(SUM(tc_rec05),0) tc_rec05",
             "     FROM imm_file,imn_file, tc_rec_file, imd_file ",
             "    WHERE imm01=imn01 ",
             "      AND imm01='",g_imm.imm01,"'", #调拨单号
             "      AND imn01 = tc_rec01(+) ",
             "      AND imn02 = tc_rec02(+) ",
             "      AND imn04 = imd01 ",
             "      AND imd07 = 'Y' ",
             "      AND imm03 ='Y' ",
             "    GROUP BY imm01,imn02,imn10 ",
             "    ORDER BY imm01,imn02) A ",
             " WHERE A.imn10 <>A.tc_rec05"
   PREPARE check_num_pre FROM g_sql
   DECLARE check_num_cur CURSOR FOR check_num_pre
   
   LET g_msg=NULL
   FOREACH check_num_cur INTO l_imn02
   
      IF g_msg IS NULL THEN
         LET g_msg=l_imn02
      ELSE
      	  LET g_msg=g_msg,",",l_imn02
      END IF
      
      #成功码置为“否”
      LET g_success='N'
      
   END FOREACH
   
   IF NOT cl_null(g_msg) THEN
      LET g_msg="第",g_msg,"项次的核销数量和调拨数量不一致，请检查是否是因为库存不足!"
      CALL cl_err(g_msg,'!',1)
   END IF
   
END FUNCTION 
#xf add 120408  --end

#add by zhangbo140915---begin
FUNCTION t332_chk_immud16()
DEFINE l_sql   STRING
DEFINE l_imm08 LIKE   imm_file.imm08
DEFINE l_imn03 LIKE   imn_file.imn03
DEFINE l_sum1  LIKE   imn_file.imn10
DEFINE l_sum2  LIKE   imn_file.imn10
DEFINE l_sum3  LIKE   imn_file.imn10
DEFINE l_sum4  LIKE   imn_file.imn10
DEFINE l_msg   LIKE   type_file.chr1000

       
       LET g_success='Y' 

       LET l_sql=" SELECT imn03,SUM(imn10) FROM imn_file ",
                 "  WHERE imm01='",g_imm_t.imm01,"'",
                 "  GROUP BY imn03 "  
       PREPARE t332_chk_immud16_pre FROM l_sql
       DECLARE t332_chk_immud16 CURSOR FOR t332_chk_immud16_pre
       
       FOREACH t332_chk_immud16 INTO l_imn03,l_sum4
          
          LET l_sum1=0
          LET l_sum2=0
          LET l_sum3=0
          SELECT SUM(imn10),SUM(imn22) INTO l_sum1,l_sum2 FROM imm_file,imn_file
           WHERE imm01=imn01
             AND imm10='2'
             AND imn24='Y'
             AND imn03=l_imn03
             AND imm01=g_imm.immud16
          SELECT SUM(immn10) INTO l_sum3 FROM imm_file,imn_file
           WHERE imm01=imn01
             AND immud16=g_imm.immud16
             AND imm01<>g_imm_t.imm01
             AND imm02<>'X'
             AND imn03=l_imn03
          IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
          IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
          IF cl_null(l_sum3) THEN LET l_sum3=0 END IF
  
          IF l_sum1-l_sum2-l_sum3<l_sum4 THEN
             LET g_success='N'
             LET l_msg=l_imn03 CLIPPED,"可退货数量大于已退货数量加上此次退货数量 "
             CALL cl_err(l_msg,"!",0)
             EXIT FOREACH
          END IF
       END FOREACH
       
END FUNCTION
#add by zhangbo140915---end

#No.160718----------BEGIN----------#
FUNCTION t332_maintain_return()
	
	 LET g_action_choice = ""
   IF cl_null(g_imm.imm01) THEN RETURN END IF
    	
	 SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
	 IF g_imm.immud19 != 'Y' THEN
	 	  CALL cl_err("不是电商渠道退货单,不可维护渠道退货单号","!",0)
	 	  RETURN
	 END IF
   
   IF g_imm.immconf='Y' THEN
   	  CALL cl_err("渠道退货单已审核不可再维护对方平台退货单号","!",0)
   	  RETURN
   END IF

   BEGIN WORK
   OPEN t324_cl USING g_imm_rowid
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
      CLOSE t324_cl
      ROLLBACK WORK
      RETURN
   ELSE
      FETCH t324_cl INTO g_imm.*                   # 锁住将被更改或取消的资料
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)  # 资料被他人LOCK
         CLOSE t324_cl
         ROLLBACK WORK
         RETURN
      END IF
   END IF
   		  
   INPUT BY NAME g_imm.immud20 WITHOUT DEFAULTS
      AFTER FIELD immud20
         IF cl_null(g_imm.immud20) THEN
         	  CALL cl_err("渠道退货单号不可为空","!",0)
         	  NEXT FIELD immud20         
         END IF
         	     
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLG 
         CALL cl_cmdask()
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 
      ON ACTION about
         CALL cl_about()
 
      ON ACTION help
         CALL cl_show_help()
      
   END INPUT

   IF INT_FLAG THEN
      LET INT_FLAG=0
      CLOSE t324_cl
      ROLLBACK WORK
   END IF
   	
   UPDATE imm_file SET immud20=g_imm.immud20 WHERE imm01=g_imm.imm01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err('up imm: ',SQLCA.SQLCODE,1)
      CLOSE t324_cl
      ROLLBACK WORK
   ELSE
      CLOSE t324_cl
      COMMIT WORK  
   END IF
   	
END FUNCTION
	
FUNCTION t332_confirm()
	
	 LET g_action_choice = ""
   IF cl_null(g_imm.imm01) THEN RETURN END IF
    	
	 SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
	 IF g_imm.imm03 != 'N' THEN
	 	  CALL cl_err("退货单已经过账或作废,不可取消审核","!",0)
	 END IF
	 	
	 IF g_imm.immud19 != 'Y' THEN
	 	  CALL cl_err("不是电商渠道退货单,不需审核可直接过账","!",0)
	 	  RETURN
	 END IF
	 	
	 IF cl_null(g_imm.immud20) THEN
	 	  CALL cl_err("请维护好渠道平台的退货单号再进行审核","!",0)
	 	  RETURN
	 END IF
	 	
	 IF g_imm.immconf='Y' THEN
	 	  CALL cl_err("此退货单已审核","!",0)
	 	  RETURN
	 END IF			  	 
	 
   BEGIN WORK
   OPEN t324_cl USING g_imm_rowid
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
      CLOSE t324_cl
      ROLLBACK WORK
      RETURN
   ELSE 
      FETCH t324_cl INTO g_imm.*                   # 锁住将被更改或取消的资料
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)  # 资料被他人LOCK
         CLOSE t324_cl 
         ROLLBACK WORK 
         RETURN
      END IF
   END IF
   
   CALL t324_show()
   LET g_imm.immconf='Y'	
   UPDATE imm_file SET immconf=g_imm.immconf WHERE imm01=g_imm.imm01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err('up imm: ',SQLCA.SQLCODE,1)
      CLOSE t324_cl
      ROLLBACK WORK
   ELSE
      CLOSE t324_cl
      COMMIT WORK  
   END IF
	  
END FUNCTION
	
FUNCTION t332_undo_confirm()
	
	 LET g_action_choice = ""
   IF cl_null(g_imm.imm01) THEN RETURN END IF
	 
	 SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
	 IF g_imm.imm03 != 'N' THEN
	 	  CALL cl_err("退货单已经过账或作废,不可取消审核","!",0)
	 END IF
	 	
	 IF g_imm.immud19 != 'Y' THEN
	 	  CALL cl_err("不是电商渠道退货单,不需审核可直接过账","!",0)
	 	  RETURN
	 END IF
	 	
	 IF g_imm.immconf='N' THEN
	 	  CALL cl_err("此退货单还未审核","!",0)
	 	  RETURN
	 END IF			  	 
	 
   BEGIN WORK
   OPEN t324_cl USING g_imm_rowid
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)
      CLOSE t324_cl
      ROLLBACK WORK
      RETURN
   ELSE 
      FETCH t324_cl INTO g_imm.*                   # 锁住将被更改或取消的资料
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)  # 资料被他人LOCK
         CLOSE t324_cl 
         ROLLBACK WORK 
         RETURN
      END IF
   END IF
   
   CALL t324_show()
   LET g_imm.immconf='N'	
   UPDATE imm_file SET immconf=g_imm.immconf WHERE imm01=g_imm.imm01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err('up imm: ',SQLCA.SQLCODE,1)
      CLOSE t324_cl
      ROLLBACK WORK
   ELSE
      CLOSE t324_cl
      COMMIT WORK  
   END IF
	
END FUNCTION
	
FUNCTION t332_quantity_confirm()
DEFINE
    l_ac_t          SMALLINT,              #未取消的ARRAY CNT
    l_n,l_cnt       SMALLINT,              #检查重复用
    l_lock_sw       VARCHAR(1),               #单身锁住否
    p_cmd           VARCHAR(1),               #处理状态
    l_img10         LIKE img_file.img10,
    l_ima02         LIKE ima_file.ima02,
    l_allow_insert  SMALLINT,              #可新增否
    l_allow_delete  SMALLINT,               #可删除否
    l_imgcy         LIKE img_file.img10
    
    	 
	 SELECT * INTO g_imm.* FROM imm_file WHERE imm01=g_imm.imm01
	 
	 IF g_imm.imm03 != 'N' THEN
	 	  CALL cl_err("退货单已经过账或作废,不可确认退货数量","!",0)
	 END IF
	 	
	 IF g_imm.immud19 != 'Y' THEN
	 	  CALL cl_err("不是电商渠道退货单,不可确认退货数量","!",0)
	 	  RETURN
	 END IF
	 	
	 IF g_imm.immconf='N' THEN
	 	  CALL cl_err("此退货单还未审核,不可确认退货数量","!",0)
	 	  RETURN
	 END IF
	 	
	 CALL cl_set_comp_entry("imn02,imnud04,imn03,imn28,imn04,imn05,imn06",FALSE)
	 CALL cl_set_comp_entry("imn15,imn16,imn17,imn20,imnud08,imn21,imnud21",FALSE)	
	 
	 CALL cl_opmsg('b')
   LET g_forupd_sql = "SELECT * FROM imn_file ",
                       " WHERE imn01= ? AND imn02= ?  FOR UPDATE NOWAIT "
   DECLARE t324_bcl2 CURSOR FROM g_forupd_sql

   LET l_ac_t = 0

   INPUT ARRAY g_imn WITHOUT DEFAULTS FROM s_imn.* 
         ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_rec_b,UNBUFFERED,
                   INSERT ROW=FALSE,DELETE ROW=FALSE,
                   APPEND ROW=FALSE)
                    	
	    BEFORE INPUT
         IF g_rec_b != 0 THEN
            CALL fgl_set_arr_curr(l_ac)
         END IF
      
      BEFORE ROW
         LET p_cmd=''
         LET l_ac = ARR_CURR() 
         LET l_lock_sw = 'N'                   #DEFAULT
         LET l_n  = ARR_COUNT()

         BEGIN WORK

         OPEN t324_cl USING g_imm_rowid
         IF SQLCA.sqlcode THEN
            CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
            CLOSE t324_cl 
            ROLLBACK WORK 
            RETURN
         ELSE 
            FETCH t324_cl INTO g_imm.*  
            IF SQLCA.sqlcode THEN
               CALL cl_err(g_imm.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
               CLOSE t324_cl 
               ROLLBACK WORK 
               RETURN
            END IF
         END IF
         IF g_rec_b >= l_ac THEN
            LET p_cmd='u'
            LET g_imn_t.* = g_imn[l_ac].*  #BACKUP
            OPEN t324_bcl2 USING g_imm.imm01,g_imn_t.imn02  #表示更改状态
            FETCH t324_bcl2 INTO b_imn.* 
            IF SQLCA.sqlcode THEN
               CALL cl_err('lock imn',SQLCA.sqlcode,1)
               LET l_lock_sw = "Y"
            ELSE
               CALL t324_b_move_to()
            END IF
         END IF
         	
      AFTER FIELD imn10
         IF NOT cl_null(g_imn[l_ac].imn10) THEN
         	  IF g_imn[l_ac].imn10<0 THEN
         	  	 CALL cl_err("实际退货数量不能小于0","!",0)
         	  	 NEXT FIELD imn10
         	  END IF
         	  LET g_imn[l_ac].imn22=g_imn[l_ac].imn10
         	  DISPLAY BY NAME g_imn[l_ac].imn22		 
         END IF
         	
      AFTER FIELD imn22
         IF NOT cl_null(g_imn[l_ac].imn22) THEN
         	  IF g_imn[l_ac].imn22<0 THEN
         	  	 CALL cl_err("实际退货数量不能小于0","!",0)
         	  	 NEXT FIELD imn22
         	  END IF
         	  LET g_imn[l_ac].imn10=g_imn[l_ac].imn22
         	  DISPLAY BY NAME g_imn[l_ac].imn10		 
         END IF   		  	    	     	
	    
	    ON ROW CHANGE
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            LET g_imn[l_ac].* = g_imn_t.*
            CLOSE t324_bcl2
            ROLLBACK WORK
            EXIT INPUT
         END IF
            
         IF l_lock_sw = 'Y' THEN
            CALL cl_err(g_imn[l_ac].imn02,-263,1)
            LET g_imn[l_ac].* = g_imn_t.*
         ELSE
            CALL t324_b_move_back()
            UPDATE imn_file SET * = b_imn.*
             WHERE imn01=g_imm.imm01 AND imn02=g_imn_t.imn02
            IF SQLCA.sqlcode THEN
               CALL cl_err('upd imn',SQLCA.sqlcode,0)
               LET g_imn[l_ac].* = g_imn_t.*
            ELSE
               MESSAGE 'UPDATE O.K'
	             COMMIT WORK
            END IF
         END IF
        	
	    AFTER ROW
         LET l_ac = ARR_CURR()
         LET l_ac_t = l_ac  
         IF INT_FLAG THEN
            CALL cl_err('',9001,0)
            LET INT_FLAG = 0
            IF p_cmd='u' THEN
               LET g_imn[l_ac].* = g_imn_t.*
            END IF
            CLOSE t324_bcl2
            ROLLBACK WORK
            EXIT INPUT
         END IF
         CLOSE t324_bcl2
         COMMIT WORK
         
      ON ACTION CONTROLZ
         CALL cl_show_req_fields()

      ON ACTION CONTROLG 
         CALL cl_cmdask()

      ON ACTION CONTROLF
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
    
    CALL cl_set_comp_entry("imn02,imnud04,imn03,imn28,imn04,imn05,imn06",TRUE)
    CALL cl_set_comp_entry("imn15,imn16,imn17,imn20,imnud08,imn21,imnud21",TRUE)
	     
    CLOSE t324_bcl2
    COMMIT WORK			
	
END FUNCTION						   	       
#No.160718-----------END-----------#
