# Prog. Version..: '5.10.03-08.08.20(00009)'     #
# Pattern name...: cimp003.4gl
# Descriptions...: 簽核人員
# Date & Author..: 16/11/10 zhengq
# 定时执行数据更新



DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE g_head  RECORD
  jcth_check   LIKE type_file.chr1  #分销 ERP 集成退货
END RECORD

DEFINE g_sql1,g_sql,g_forupd_sql    STRING
DEFINE g_before_input_done   LIKE type_file.num5          #判斷是否已執行 Before Input指令
DEFINE g_chr                 VARCHAR(1)
DEFINE g_cnt,l_ac,g_cnt1     LIKE type_file.num10
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
DEFINE g_yy,g_mm       SMALLINT,
       b_imn   RECORD  LIKE imn_file.*,
       g_debit,g_credit    LIKE img_file.img26,
       g_ima25,g_ima25_2   LIKE ima_file.ima25,
       g_ima86,g_ima86_2   LIKE ima_file.ima86,
       g_img10,g_img10_2   LIKE img_file.img10
DEFINE  l_show_msg      DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
        imn01       LIKE imn_file.imn01,   #
        imn02       LIKE imn_file.imn02,
        imn10       LIKE imn_file.imn10,
        tc_rec05    LIKE tc_rec_file.tc_rec05
                   END RECORD
DEFINE g_msg2       LIKE type_file.chr1000

DEFINE g_argv1     LIKE type_file.chr1
DEFINE g_argv2     LIKE type_file.chr2
DEFINE g_argv3     LIKE type_file.chr3
DEFINE g_argv4     LIKE type_file.chr4
DEFINE g_argv5     LIKE type_file.chr5
DEFINE g_argv6     LIKE type_file.chr6
DEFINE g_argv7     LIKE type_file.chr7
DEFINE g_having    LIKE type_file.num5
DEFINE g_in_work   LIKE type_file.chr1         #add by leo 130320
DEFINE g_imm       DYNAMIC ARRAY OF RECORD
        imm01      LIKE imm_file.imm01,
        immud02    LIKE imm_file.immud02,
        imm13      LIKE imm_file.imm13,
        imm09      LIKE imm_file.imm09,
        immuser    LIKE imm_file.immuser,
        immgrup    LIKE imm_file.immgrup
            END RECORD,
      g_imn    DYNAMIC ARRAY OF RECORD
        imn01     LIKE imn_file.imn01,
        imn02     LIKE imn_file.imn02,
        imn03     LIKE imn_file.imn03,
        imn04     LIKE imn_file.imn04,
        imn05     LIKE imn_file.imn05,
        imn06     LIKE imn_file.imn06,
        imn09     LIKE imn_file.imn09,
        imn10     LIKE imn_file.imn10,
        imn15     LIKE imn_file.imn15,
        imn16     LIKE imn_file.imn16,
        imn17     LIKE imn_file.imn17,
        imn20     LIKE imn_file.imn20,
        imn28     LIKE imn_file.imn28,
        imnud04   LIKE imn_file.imnud04
            END RECORD,
      g_mid       LIKE tc_fxcs_file.tc_fxcs01,
      g_imm01     LIKE imm_file.imm01
DEFINE g_imm_t RECORD  LIKE imm_file.*
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
   LET g_argv3=ARG_VAL(3)
   LET g_argv4=ARG_VAL(4)
   LET g_argv5=ARG_VAL(5)
   LET g_argv6=ARG_VAL(6)
   LET g_argv7=ARG_VAL(7)
	 INITIALIZE g_head.* TO NULL

   LET g_date = g_today USING "YYYYMMDD"

   #CALL autoUpdate()

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

   DISPLAY BY NAME
   g_head.jcth_check

   INPUT BY NAME
     g_head.jcth_check
      WITHOUT DEFAULTS

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

FUNCTION autoUpdate()
DEFINE li_result  LIKE type_file.num5

IF g_head.jcth_check !='Y' THEN
    RETURN
END IF

LET g_sql1 = "SELECT UNIQUE tc_fxcs01 FROM tc_fxcs_file"

PREPARE i001_tc_fxcs01 FROM g_sql1
IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
DECLARE tc_fxcs_curs CURSOR FOR i001_tc_fxcs01

LET g_mid = ''
FOREACH tc_fxcs_curs INTO g_mid
    IF SQLCA.sqlcode THEN
       CALL cl_err('foreach:',SQLCA.sqlcode,1)
       EXIT FOREACH
    END IF
    LET g_sql1 = "SELECT UNIQUE fx_dbd_no FROM ",g_mid,".E_FX_E_DBD"

    PREPARE i001_imm01 FROM g_sql1
    IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
    DECLARE i001_get_imm01 CURSOR FOR i001_imm01

    LET g_sql =  "select unique '',dbdate,occ04,fx_dbd_no,'tiptop',gen03",
                  " FROM ",g_mid,".E_FX_E_DBD",
                  " left join occ_file on stockware_bc =occ01",
                  " left join gen_file on gen01='tiptop'",
                  " WHERE status = 0 AND dbd_type = 'TH' AND fx_dbd_no='DBM-1708000004'"
    PREPARE i001_imm FROM g_sql
    IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
    DECLARE i001_get_imm CURSOR FOR i001_imm

    LET g_sql =  "SELECT UNIQUE '',SEQ,ITEM_NO,STOCKWARE_BC,NVL(STOCKWARE_BCKW,' '),' ',ITEM_UNIT,to_number(ITEM_QTY) ",
                 " ,STOCKWARE_BR ,NVL(STOCKWARE_BRKW,' '),' ',NVL(IMA25,' '),'XST1' ,'2'",
                 " FROM ",g_mid,".E_FX_E_DBD",
                 " LEFT JOIN IMA_FILE ON IMA01   =   ITEM_NO",
                 " WHERE  FX_DBD_NO = ? AND status = 0 AND dbd_type = 'TH' ORDER BY SEQ"
    PREPARE i001_imn FROM g_sql
    IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
    DECLARE i001_get_imn CURSOR FOR i001_imn

    LET g_sql = " UPDATE ",g_mid,".E_FX_E_DBD  SET status = ? ,errmess = ? ",
                " WHERE fx_dbd_no = ? and seq =? "
    PREPARE i001_upd FROM g_sql
    IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF

    LET g_sql = " UPDATE ",g_mid,".E_FX_E_DBD  SET status = ? ,errmess = ? ",
                " WHERE fx_dbd_no = ? "
    PREPARE i001_upd2 FROM g_sql
    IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF
    DECLARE i001_upde_fx_e_dbd2 CURSOR FOR i001_upd2

    LET g_imm01 = ''
    # 单头
    LET g_cnt = 1
    CALL g_imm.clear()
    FOREACH i001_get_imm INTO g_imm[g_cnt].*
        IF SQLCA.sqlcode THEN
           CALL cl_err('foreach:',SQLCA.sqlcode,1)
           EXIT FOREACH
        END IF
        LET g_cnt = g_cnt + 1
    END FOREACH
    CALL g_imm.deleteElement(g_cnt)

    FOR g_cnt =1 TO g_imm.getLength()
        BEGIN WORK
        LET g_cnt1 = 1
        CALL g_imn.clear()

        CALL s_auto_assign_no("aim","DB8",g_today,"","imm_file","imm01",
                "","","")
        RETURNING li_result,g_imm01

        IF (NOT li_result) THEN
          CONTINUE FOR
        END IF
        LET g_imm[g_cnt].imm01 = g_imm01

        FOREACH i001_get_imn USING g_imm[g_cnt].imm09 INTO g_imn[g_cnt1].*
            IF SQLCA.sqlcode THEN
               CALL cl_err('foreach:',SQLCA.sqlcode,1)
               EXIT FOREACH
            END IF
            LET g_imn[g_cnt1].imn01 = g_imm01
            IF  cl_null(g_imn[g_cnt1].imn15) THEN
                IF g_imn[g_cnt1].imn03[1,1] = '1' THEN
                    LET g_imn[g_cnt1].imn15 = 'ZPS03'
                ELSE
                    LET g_imn[g_cnt1].imn15 = 'ZPS07'
                END IF
            END IF
            INSERT INTO imn_file (imn01,imn02,imn03,imn04,
                                  imn05,imn06,imn09,imn10,imn15,
                                  imn16,imn17,imn20,imn28,imnud04,imnplant,imnlegal)
                   VALUES (g_imn[g_cnt1].imn01,g_imn[g_cnt1].imn02,g_imn[g_cnt1].imn03,g_imn[g_cnt1].imn04,
                          g_imn[g_cnt1].imn05,g_imn[g_cnt1].imn06,g_imn[g_cnt1].imn09,g_imn[g_cnt1].imn10,g_imn[g_cnt1].imn15,
                          g_imn[g_cnt1].imn16,g_imn[g_cnt1].imn17,g_imn[g_cnt1].imn20,g_imn[g_cnt1].imn28,g_imn[g_cnt1].imnud04,
                          g_plant,g_plant)
            IF SQLCA.sqlcode THEN
                CALL cl_err('ins imn',SQLCA.sqlcode,1)
                ROLLBACK WORK


                #EXECUTE i001_upde_fx_e_dbd1

                IF SQLCA.sqlcode THEN
                    CALL cl_err('upd e_fx_e_dbd',SQLCA.sqlcode,1)
                END IF
                EXIT FOREACH
            END IF
            #LET g_sql = " UPDATE ",g_mid,".E_FX_E_DBD  SET status = 2 ,errmess = 'success' ",
            #                " WHERE fx_dbd_no = '",g_imm[g_cnt].imm09,"' and seq = ",g_imn[g_cnt1].imn02
            #PREPARE i001_upd1 FROM g_sql
            #IF STATUS THEN CALL cl_err('per',STATUS,1) RETURN END IF

            EXECUTE i001_upd USING '1','SUCCESS',g_imm[g_cnt].imm09,g_imn[g_cnt].imn02
            IF SQLCA.sqlcode THEN
                CALL cl_err('upd e_fx_e_dbd',SQLCA.sqlcode,1)
            END IF
        END FOREACH
        INSERT INTO imm_file(imm01,immud02,imm13,imm09,immuser,immgrup,
                         immplant,immlegal,imm10,imm03,imm04)
           VALUES (g_imm[g_cnt].imm01,g_imm[g_cnt].immud02,g_imm[g_cnt].imm13,
                   g_imm[g_cnt].imm09,g_imm[g_cnt].immuser,g_imm[g_cnt].immgrup,g_plant,g_plant,'1','N','N')
        IF SQLCA.sqlcode THEN
            CALL cl_err('ins imm',SQLCA.sqlcode,1)
            ROLLBACK WORK
            EXECUTE i001_upde_fx_e_dbd2 USING '2',SQLCA.sqlcode,g_imm[g_cnt].imm09
            IF SQLCA.sqlcode THEN
                CALL cl_err('upd e_fx_e_dbd2',SQLCA.sqlcode,1)
            END IF
            COMMIT WORK
            EXIT FOREACH
        END IF
        COMMIT WORK
        # 审核
        CALL p005_confirm(g_imm[g_cnt].imm01)
        # 过账
        CALL p005_s(g_imm[g_cnt].imm01)
    END FOR
END FOREACH



END FUNCTION

FUNCTION p005_confirm(p_imm01)
DEFINE p_imm01    LIKE imm_file.imm01

   LET g_forupd_sql = "SELECT * FROM imm_file WHERE imm01 = ? FOR UPDATE NOWAIT"
   DECLARE t324_cl CURSOR FROM g_forupd_sql

   SELECT * INTO g_imm_t.* FROM imm_file WHERE imm01=p_imm01
   IF g_imm_t.imm03 != 'N' THEN
      CALL cl_err("退货单已经过账或作废,不可取消审核","!",0)
   END IF

   IF g_imm_t.immud19 != 'Y' THEN
      CALL cl_err("不是电商渠道退货单,不需审核可直接过账","!",0)
      RETURN
   END IF

   #IF cl_null(g_imm_t.immud20) THEN
   #   CALL cl_err("请维护好渠道平台的退货单号再进行审核","!",0)
   #   RETURN
   #END IF

   IF g_imm_t.immconf='Y' THEN
      CALL cl_err("此退货单已审核","!",0)
      RETURN
   END IF

   BEGIN WORK
   OPEN t324_cl USING p_imm01
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_imm_t.imm01,SQLCA.sqlcode,0)
      CLOSE t324_cl
      ROLLBACK WORK
      RETURN
   ELSE
      FETCH t324_cl INTO g_imm_t.*                   # 锁住将被更改或取消的资料
      IF SQLCA.sqlcode THEN
         CALL cl_err(g_imm_t.imm01,SQLCA.sqlcode,0)  # 资料被他人LOCK
         CLOSE t324_cl
         ROLLBACK WORK
         RETURN
      END IF
   END IF
   LET g_imm_t.immconf='Y'
   UPDATE imm_file SET immconf=g_imm_t.immconf WHERE imm01=g_imm_t.imm01
   IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3]=0 THEN
      CALL cl_err('up imm: ',SQLCA.SQLCODE,1)
      CLOSE t324_cl
      ROLLBACK WORK
   ELSE
      CLOSE t324_cl
      COMMIT WORK
   END IF
END FUNCTION

FUNCTION p005_s(p_imm01)
DEFINE l_cnt  INTEGER
DEFINE l_imn01  LIKE imn_file.imn01   #add by zhangbo120703
DEFINE l_imn02  LIKE imn_file.imn02   #add by zhangbo120703
DEFINE l_tc_rec05   LIKE  tc_rec_file.tc_rec05  #add by zhangbo120703
DEFINE l_sql   STRING                           #add by zhangbo120703
DEFINE l_imn10 LIKE imn_file.imn10              #add by zhangbo120703
DEFINE i       LIKE type_file.num5              #add by zhangbo120727
DEFINE p_imm01    LIKE imm_file.imm01

   IF s_shut(0) THEN RETURN END IF
    SELECT * INTO g_imm_t.* FROM imm_file WHERE imm01= p_imm01
   IF g_imm_t.imm03 = 'Y' THEN CALL cl_err('',9023,0) RETURN END IF
   IF g_imm_t.imm03 = 'X' THEN CALL cl_err('',9024,0) RETURN END IF
   #No.160718----------BEGIN----------#
   IF g_imm_t.immud19='Y' THEN
      IF g_imm_t.immconf='N' THEN
         CALL cl_err("渠道退货单还未审核,不可过账","!",0)
         RETURN
      END IF
      LET g_imm_t.imm02=g_today
   END IF
   #No.160718-----------END-----------#
   IF g_imm_t.imm01 IS NULL THEN CALL cl_err('',-400,0) RETURN END IF
   IF g_sma.sma53 IS NOT NULL AND g_imm_t.imm02 <= g_sma.sma53 THEN
     CALL cl_err('','mfg9999',0) RETURN
   END IF
        CALL s_yp(g_imm_t.imm02) RETURNING g_yy,g_mm
        IF g_yy > g_sma.sma51     # 与目前会计年度,期间比较
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
    WHERE imn01=g_imm_t.imm01
   IF l_cnt=0 OR l_cnt IS NULL THEN
      CALL cl_err('','mfg-009',0)
      RETURN
   END IF
   #No.+022 end---
   IF NOT cl_confirm('mfg0176') THEN RETURN END IF

   DECLARE t324_s1_c CURSOR FOR
     SELECT * FROM imn_file WHERE imn01=g_imm_t.imm01

   BEGIN WORK
    OPEN t324_cl USING p_imm01
    IF SQLCA.sqlcode THEN
       CALL cl_err(g_imm_t.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
       CLOSE t324_cl
       ROLLBACK WORK
       RETURN
    ELSE
       FETCH t324_cl INTO g_imm_t.*          # 锁住将被更改或取消的资料
       IF SQLCA.sqlcode THEN
          CALL cl_err(g_imm_t.imm01,SQLCA.sqlcode,0)     # 资料被他人LOCK
          CLOSE t324_cl
          ROLLBACK WORK
          RETURN
       END IF
    END IF

    #No.160718----------BEGIN----------#
    IF g_imm_t.immud19='Y' THEN
       LET g_imm_t.imm02=g_today
       UPDATE imm_file SET imm02=g_imm_t.imm02 WHERE imm01=g_imm_t.imm01
       IF SQLCA.sqlcode THEN
          CALL cl_err("更新退货日期失败","!",0)
          CLOSE t324_cl
          ROLLBACK WORK
          RETURN
       END IF
    END IF
    #No.160718-----------END-----------#

    LET g_success = 'Y'

    CALL p005_expend(g_imm_t.imm01)  #xf add 120408

    FOREACH t324_s1_c INTO b_imn.*
         IF STATUS THEN EXIT FOREACH END IF
         MESSAGE 's_ read parts:',b_imn.imn03
         IF cl_null(b_imn.imn04) THEN CONTINUE FOREACH END IF

         #-->拨出更新
         IF p005_t(b_imn.*) THEN LET g_success = 'N' EXIT FOREACH END IF

         #-->拨入更新
         IF p005_t2(b_imn.*) THEN  LET g_success ='N' EXIT FOREACH END IF
     END FOREACH

#add by zhangbo120727-----------------------begin---------------------
     IF g_success='Y' THEN

        LET l_cnt=0
        SELECT COUNT(*) INTO l_cnt FROM imm_file,imn_file,imd_file WHERE imm01=imn01 AND imn04=imd01 AND imd07='Y' AND imm01=g_imm_t.imm01
        IF l_cnt>0 THEN
        LET l_sql=" SELECT imn01,imn02,imn10 FROM imn_file,imd_file WHERE imn01='",g_imm_t.imm01,"'",
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
   # UPDATE imm_file SET imm03 = 'Y',imm04='Y'  WHERE imm01 = g_imm_t.imm01
     UPDATE imm_file SET imm03 = 'Y',imm04='Y',immconf = 'Y'  WHERE imm01 = g_imm_t.imm01  #add by xumin 101230
     IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0
     THEN CALL cl_err('up imm_file',SQLCA.sqlcode,0)
          LET g_success = 'N'
     END IF
     IF g_success = 'Y'
      THEN
         COMMIT WORK
         CALL cl_flow_notify(g_imm_t.imm01,'S')
         CALL cl_cmmsg(4)
      ELSE
         ROLLBACK WORK
         CALL cl_rbmsg(4)
     END IF
   SELECT imm03 INTO g_imm_t.imm03 FROM imm_file WHERE imm01 = g_imm_t.imm01
   #DISPLAY BY NAME g_imm_t.imm03
#  MESSAGE ''
END FUNCTION



FUNCTION p005_t(p_imn)
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
     CALL s_upimg(p_imn.imn03,p_imn.imn04,p_imn.imn05,p_imn.imn06,-1,p_imn.imn10,g_imm_t.imm02,
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

FUNCTION p005_t2(p_imn)
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
    CALL s_upimg(p_imn.imn03,p_imn.imn15,p_imn.imn16,p_imn.imn17,+1,p_imn.imn22,g_imm_t.imm02,
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

FUNCTION p005_expend(p_imm01)

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
   DEFINE p_imm01   LIKE imm_file.imm01

   SELECT * INTO g_imm_t.* FROM imm_file WHERE imm01 = p_imm01

   IF g_imm_t.imm03 = 'Y' THEN CALL cl_err('资料已过账','!',0) RETURN END IF
   IF g_imm_t.imm03 = 'X' THEN CALL cl_err('资料已作废','!',0) RETURN END IF

   LET l_success = 'Y'
   LET l_sql = "SELECT imn_file.* FROM imn_file,imm_file,imd_file ",
               " WHERE imm01 = imn01 ",
               "   AND imn01 = '",g_imm_t.imm01,"' ",
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
             "      AND imm01='",g_imm_t.imm01,"'", #调拨单号
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

FUNCTION t324_log_2(p_stdc,p_reason,p_code,p_imn)
DEFINE
    p_stdc          SMALLINT,    #是否需取得标准成本
    p_reason        SMALLINT,    #是否需取得异动原因
    p_code          VARCHAR(01),            #出/入库
    p_imn           RECORD LIKE imn_file.*
DEFINE l_imd07      LIKE   imd_file.imd07    #add by zhangbo150403
DEFINE l_price      LIKE   imn_file.imnud07  #add by zhangbo150403
DEFINE l_type       LIKE   imn_file.imnud02  #add by zhangbo150403

#----来源----
    LET g_tlf.tlf01=p_imn.imn03           #异动料件编号
    LET g_tlf.tlf02=50                    #来源为仓库(拨出)
    LET g_tlf.tlf020=g_plant                    #工厂别
    LET g_tlf.tlf021=p_imn.imn04            #仓库别
    LET g_tlf.tlf022=p_imn.imn05          #储位别
    LET g_tlf.tlf023=p_imn.imn06          #批号
    LET g_tlf.tlf024=g_img10 - p_imn.imn10      #异动后库存数量
    LET g_tlf.tlf025=p_imn.imn09                #库存单位(ima_file or img_file)
    LET g_tlf.tlf026=p_imn.imn01                #调拨单号
    LET g_tlf.tlf027=p_imn.imn02                #项次
#----目的----
    LET g_tlf.tlf03=50                          #资料目的为(拨入)
    LET g_tlf.tlf030=g_plant                    #工厂别
    LET g_tlf.tlf031=p_imn.imn15                #仓库别
    LET g_tlf.tlf032=p_imn.imn16                #储位别
    LET g_tlf.tlf033=p_imn.imn17            #批号
    LET g_tlf.tlf034=g_img10_2 + p_imn.imn22    #异动后库存量
    LET g_tlf.tlf035=p_imn.imn20              #库存单位(ima_file or img_file)
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
    LET g_tlf.tlf06=g_imm_t.imm02                 #发料日期
    LET g_tlf.tlf07=g_today                     #异动资料产生日期
    LET g_tlf.tlf08=TIME                        #异动资料产生时:分:秒
    LET g_tlf.tlf09=g_user                      #产生人
    LET g_tlf.tlf13='aimt324'                   #异动命令代号
    LET g_tlf.tlf14=p_imn.imn28                 #异动原因
    LET g_tlf.tlf15=g_debit                     #借方会计科目
    LET g_tlf.tlf16=g_credit                    #贷方会计科目
    LET g_tlf.tlf17=g_imm_t.imm09                 #remark
    CALL s_imaQOH(p_imn.imn03)
         RETURNING g_tlf.tlf18                  #异动后总库存量
    LET g_tlf.tlf19= ' '                        #异动厂商/客户编号
    LET g_tlf.tlf20= ' '                        #project no.
    LET g_tlf.tlf61= g_ima86
    CALL s_tlf(p_stdc,p_reason)
END FUNCTION