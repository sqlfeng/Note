# Prog. Version..: '5.20.01-10.05.01(00000)'     #
#
# Pattern name...: cxmt001.4gl
# Descriptions...: BOM重新生成
# Date & Author..: 20141031 by jixf


DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE g_oea01        LIKE oea_file.oea01,
       g_wc        STRING,
       g_wc2       STRING,                       #單身CONSTRUCT結果
       g_rec_b     LIKE type_file.num5,
       l_ac        LIKE type_file.num5,
       l_ac_t      LIKE type_file.num5,
       g_success   STRING ,
       g_sql       STRING
DEFINE g_forupd_sql          STRING         #SELECT ... FOR UPDATE  SQL        #No.FUN-680102
DEFINE g_before_input_done   LIKE type_file.num5          #判斷是否已執行 Before Input指令        #No.FUN-680102 SMALLINT
DEFINE g_chr                 LIKE azb_file.azbacti        #No.FUN-680102 VARCHAR(1)
DEFINE g_cnt                 LIKE type_file.num10         #No.FUN-680102 INTEGER
DEFINE g_i                   LIKE type_file.num5          #count/index for any purpose        #No.FUN-680102 SMALLINT
DEFINE g_msg                 LIKE type_file.chr1000       #No.FUN-680102 VARCHAR(72)
DEFINE g_curs_index          LIKE type_file.num10         #No.FUN-680102 INTEGER
DEFINE g_row_count           LIKE type_file.num10         #總筆數        #No.FUN-680102 INTEGER
DEFINE g_jump                LIKE type_file.num10         #查詢指定的筆數        #No.FUN-680102 INTEGER
DEFINE g_sma19               LIKE sma_file.sma19
DEFINE mi_no_ask             LIKE type_file.num5
DEFINE ll_str              STRING
DEFINE ll_win              ui.Window
DEFINE ll_om               om.DomNode
DEFINE g_oea904            LIKE oea_file.oea904
DEFINE g_argv1    LIKE type_file.chr1000


MAIN
    OPTIONS
        INPUT NO WRAP
    DEFER INTERRUPT                            #擷取中斷鍵

    LET g_argv1 = ARG_VAL(1)

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF

   CALL  cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0081

   OPEN WINDOW t001_w WITH FORM "cxm/42f/cxmt002"
       ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_init()


   LET g_action_choice = ""

   CALL t001_cs()

   CLOSE WINDOW t001_w

   CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0081
END MAIN

FUNCTION t001_cs()
DEFINE p_cmd   LIKE type_file.chr1
DEFINE g_buf   LIKE type_file.chr1000
DEFINE g_t1    LIKE type_file.chr1000
DEFINE l_allow_insert  LIKE type_file.num5                 #可新增否  #No.FUN-680137 SMALLINT
DEFINE l_allow_delete  LIKE type_file.num5


       LET g_action_choice=""        #初始化Action执行标示
       IF s_shut(0) THEN RETURN END IF                                #判断目前系统是否可用
       CALL cl_opmsg('b')

       CLEAR FORM

       CONSTRUCT BY NAME g_wc ON oea01
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

         ON ACTION CONTROLP
         CASE
            WHEN INFIELD(oea01)
              CALL cl_init_qry_var()
              LET g_qryparam.form ="cq_oea01"
              LET g_qryparam.state = "c"
              CALL cl_create_qry() RETURNING g_qryparam.multiret
              DISPLAY g_qryparam.multiret TO oea01
              NEXT FIELD oea01

         END CASE

         ON ACTION about
            CALL cl_about()

         ON ACTION HELP
            CALL cl_show_help()

         ON ACTION controlg
            CALL cl_cmdask()


         ON ACTION EXIT
            LET INT_FLAG = 1
            EXIT CONSTRUCT

         ON ACTION qbe_select
            CALL cl_qbe_select()

  END CONSTRUCT
   IF NOT cl_null(g_wc) THEN
       IF cl_confirm('t002-12') THEN
           CALL t001_ins_bom()
           CALL s_showmsg()
       END IF
   END IF
END FUNCTION

FUNCTION t001_ins_bom()      #新增订单单头
DEFINE i    LIKE type_file.num5
DEFINE j    LIKE type_file.num5
DEFINE l_tc_oeu04 LIKE tc_oeu_file.tc_oeu04   #add by ryan 161213
DEFINE l_tc_oeu04_t LIKE tc_oeu_file.tc_oeu04   #add by lixwz 170810
DEFINE l_ta_oeb04_t STRING   #add by lixwz 170810
DEFINE l_tc_oen08   LIKE tc_oen_file.tc_oen08  # add by lixwz 20170808

DEFINE l_ta_oeb    RECORD
            oea10   LIKE oea_file.oea10,
            ta_oeb01   LIKE oeb_file.ta_oeb01,
            oeb03      LIKE oeb_file.oeb03,
            ta_oeb02   LIKE oeb_file.ta_oeb02,
            ta_oeb03   LIKE oeb_file.ta_oeb03,
            ta_oeb04   LIKE oeb_file.ta_oeb04,
            ta_oeb05   LIKE oeb_file.ta_oeb05,
            ta_oeb06   LIKE oeb_file.ta_oeb06,
            ta_oeb07   LIKE oeb_file.ta_oeb07,
            ta_oeb08   LIKE oeb_file.ta_oeb08,
            oeb13      LIKE oeb_file.oeb13,
            oeb12      LIKE oeb_file.oeb12,
            oeb14t     LIKE oeb_file.oeb14t,
            ta_oeb09   LIKE oeb_file.ta_oeb09,
            ta_oeb10   LIKE oeb_file.ta_oeb10,
            ta_oeb11   LIKE oeb_file.ta_oeb11,
            ta_oeb12   LIKE oeb_file.ta_oeb12,
            ta_oeb13   LIKE oeb_file.ta_oeb13,
            ta_oeb14   LIKE oeb_file.ta_oeb14,
            ta_oeb15   LIKE oeb_file.ta_oeb15,
            ta_oeb16   LIKE oeb_file.ta_oeb16,
            ta_oeb17   LIKE oeb_file.ta_oeb17,
            ta_oeb18   LIKE oeb_file.ta_oeb18,
            ta_oeb19   LIKE oeb_file.ta_oeb19,
            ta_oeb20   LIKE oeb_file.ta_oeb20,
            ta_oeb21   LIKE oeb_file.ta_oeb21,
            ta_oeb22   LIKE oeb_file.ta_oeb22,
            ta_oeb23   LIKE oeb_file.ta_oeb23,
            ta_oeb24   LIKE oeb_file.ta_oeb24,
            ta_oeb25   LIKE oeb_file.ta_oeb25,
            ta_oeb26   LIKE oeb_file.ta_oeb26,
            ta_oeb27   LIKE oeb_file.ta_oeb27,
            ta_oeb28   LIKE oeb_file.ta_oeb28,
            ta_oeb29   LIKE oeb_file.ta_oeb29,
            ta_oeb30   LIKE oeb_file.ta_oeb30,
            ta_oeb31   LIKE oeb_file.ta_oeb31,
            ta_oeb32   LIKE oeb_file.ta_oeb32,
            oeb15      LIKE oeb_file.oeb15,
            ta_oeb33   LIKE oeb_file.ta_oeb33,
            ta_oeb34   LIKE oeb_file.ta_oeb34,
            ta_oeb35   LIKE oeb_file.ta_oeb35,
            ta_oeb36   LIKE oeb_file.ta_oeb36,
            ta_oeb37   LIKE oeb_file.ta_oeb37,
            ta_oeb38   LIKE oeb_file.ta_oeb38,
            ta_oeb39   LIKE oeb_file.ta_oeb39,
            ta_oeb40   LIKE oeb_file.ta_oeb40,
            ta_oeb41   LIKE oeb_file.ta_oeb41,
            ta_oeb42   LIKE oeb_file.ta_oeb42,
            ta_oeb43   LIKE oeb_file.ta_oeb43,
            ta_oeb44   LIKE oeb_file.ta_oeb44,
            ta_oeb45   LIKE oeb_file.ta_oeb45,
            ta_oeb46   LIKE oeb_file.ta_oeb46,
            ta_oeb47   LIKE oeb_file.ta_oeb47,
            ta_oeb48   LIKE oeb_file.ta_oeb48
                   END RECORD
DEFINE l_oea     RECORD  LIKE oea_file.*
DEFINE l_oeb     RECORD  LIKE oeb_file.*
DEFINE l_ima     RECORD  LIKE ima_file.*
DEFINE l_bma     RECORD  LIKE bma_file.*
DEFINE l_bmb     RECORD  LIKE bmb_file.*
DEFINE l_tc_oem  RECORD  LIKE tc_oem_file.*
DEFINE l_tc_oeh  RECORD  LIKE tc_oeh_file.*
DEFINE l_sql     STRING
DEFINE g_buf     LIKE type_file.chr10
DEFINE li_result   STRING
DEFINE l_oeb04   LIKE type_file.chr10
DEFINE l_tc_ima01   LIKE tc_ima_file.tc_ima01
DEFINE l_ohi04    LIKE ohi_file.ohi04
DEFINE l_obk07    LIKE obk_file.obk07
DEFINE l_ima25    LIKE ima_file.ima25
DEFINE l_check    LIKE type_file.chr1000
DEFINE l_oaz70    LIKE oaz_file.oaz70
DEFINE m          LIKE type_file.num5
DEFINE l_count    LIKE type_file.num5
DEFINE l_occ03    LIKE occ_file.occ03
DEFINE l_oca02    LIKE oca_file.oca02
DEFINE l_oen03    STRING
DEFINE l_oen      RECORD
              oen01   LIKE tc_oen_file.tc_oen01,
              oen02   LIKE tc_oen_file.tc_oen02,
            #  oen03   LIKE tc_oen_file.tc_oen03  #MARK BY zl 170429
              oen03   LIKE type_file.chr500         #add by zl 170429
                  END RECORD
DEFINE l_occ19    LIKE occ_file.occ19
DEFINE l_ima02    LIKE ima_file.ima02
DEFINE l_ima021   LIKE ima_file.ima021
DEFINE l_lang     LIKE type_file.chr1
DEFINE l_smd04    LIKE smd_file.smd04
DEFINE l_smd06    LIKE smd_file.smd06
DEFINE l_today    LIKE type_file.dat
DEFINE l_str1     LIKE type_file.chr1000
DEFINE l_str2     LIKE type_file.chr1000
DEFINE l_str3     LIKE type_file.chr1000
DEFINE l_tc_oeh09   LIKE tc_oeh_file.tc_oeh09
DEFINE l_bmb06_1    LIKE bmb_file.bmb06
DEFINE l_bmb06_2    LIKE bmb_file.bmb06
DEFINE l_ta_oeb21   STRING
DEFINE l_tc_oet05   LIKE tc_oet_file.tc_oet05
DEFINE l_tc_oet06   LIKE tc_oet_file.tc_oet06
DEFINE l_tc_oep02   LIKE tc_oep_file.tc_oep02
DEFINE l_tc_oer02   LIKE tc_oer_file.tc_oer02
DEFINE l_tc_oeq02   LIKE tc_oeq_file.tc_oeq02
DEFINE l_tc_oes02   LIKE tc_oes_file.tc_oes02
DEFINE l_tc_oes03   LIKE tc_oes_file.tc_oes03
DEFINE l_lian_num   LIKE type_file.num15_3
   IF cl_null(g_wc) THEN
      CALL cl_err('','t002-13',0)
      RETURN
   END IF

   LET l_sql="select * from oeb_file where oeb01 IN (SELECT oea01 FROM oea_file WHERE ",g_wc,")"
   PREPARE l_pre FROM l_sql
   DECLARE l_cur CURSOR FOR l_pre
   BEGIN WORK
   CALL s_showmsg_init()             #清单式报错
   LET g_success='Y'
   FOREACH l_cur INTO l_oeb.*
      IF STATUS THEN
         CALL cl_err('foreach:',STATUS,1)
         EXIT FOREACH
      END IF
      SELECT * INTO l_oea.* FROM oea_file WHERE oea01=l_oeb.oeb01
      DELETE FROM he2.bma_file WHERE bma01 = l_oeb.oeb04
      DELETE FROM he2.bmb_file WHERE bmb01 = l_oeb.oeb04
      DELETE FROM dw.bma_file WHERE bma01 = l_oeb.oeb04
      DELETE FROM dw.bmb_file WHERE bmb01 = l_oeb.oeb04
         INITIALIZE l_bma.* TO NULL
         #------产生BOM---------
         LET l_bma.bma01=l_oeb.oeb04   #主件料件编号
         LET l_bma.bma06=' '           #特性代码
         LET l_bma.bma10='2'           #状态码
         LET l_bma.bma05=g_today       #发放日期
         LET l_bma.bma08=g_plant       #资料来源
         LET l_bma.bmaoriu=g_user      #资料建立者
         LET l_bma.bmaorig=g_grup      #资料建立部门
         LET l_bma.bmauser=g_user
         LET l_bma.bmaacti='Y'
         LET l_bma.bmadate=g_today
         LET l_bma.bma09=0             #抛砖次数
         INSERT INTO bma_file VALUES (l_bma.*)
         IF STATUS THEN
            LET g_showmsg=l_bma.bma01
            CALL s_errmsg("bma01",g_showmsg,"",SQLCA.sqlcode,1)
            LET g_success = 'N'
            ROLLBACK WORK
            RETURN
         END IF
         #---卷料-----
         INITIALIZE l_bmb.* TO NULL
         LET l_bmb.bmb01=l_bma.bma01
         SELECT sma19 INTO g_sma19 FROM sma_file
         SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
           WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
         IF l_bmb.bmb02 IS NULL THEN
            LET l_bmb.bmb02 = 0
         END IF
         LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
         INITIALIZE l_tc_oem.* TO NULL
         SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='1' AND tc_oem03=l_oeb.ta_oeb04
         LET l_bmb.bmb03=l_tc_oem.tc_oem02   # 元料件
         LET l_bmb.bmb04 = g_today           #生效日期
         LET l_bmb.bmb06 = (l_oeb.ta_oeb05+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
         LET l_bmb.bmb07 = 1                 #主件底数
         LET l_bmb.bmb08 = 0                 #损耗率
         SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
         LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
         LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
         LET l_bmb.bmb14 = '0'               #元件使用特性
         LET l_bmb.bmb15 = 'Y'               #元件消耗特性
         LET l_bmb.bmb16 = '0'               #元件取替代特性
         LET l_bmb.bmb17 = 'N'               #特性旗标
         LET l_bmb.bmb18 = 0                 #元件投料时距
         LET l_bmb.bmb19 = '1'               #工单开立展开选项
         LET l_bmb.bmb23 = 100               #选中率
         LET l_bmb.bmb27 = 'N'               #元件是否软体物件
         LET l_bmb.bmb28 = 0                 #发料误差允许率
         LET l_bmb.bmbdate = g_today
         LET l_bmb.bmbcomm = 'abmi600'
         LET l_bmb.bmb29 = ' '
         LET l_bmb.bmb31 = 'N'
         LET l_bmb.bmb33 = 0
         LET l_bmb.bmb081 = 0
         LET l_bmb.bmb082 = 1
         LET l_bmb.bmb34 = ' '
         #----2on1--用量*2
         LET l_bmb06_1=0
         LET l_bmb06_2=0
         IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
            LET l_bmb06_1 = (l_oeb.ta_oeb06+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
            LET l_bmb06_2 = (l_oeb.ta_oeb07+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
            LET l_bmb.bmb06 = l_bmb06_1 + l_bmb06_2
         END IF
         #----2on1--用量*2
         INSERT INTO bmb_file VALUES (l_bmb.*)
         IF STATUS THEN
            LET g_showmsg="PO号：",l_oea.oea10,"/","花板号：",l_oeb.ta_oeb04
            CALL s_errmsg("cxmi001作业中无此花板号对应的ERP料号(卷料)",g_showmsg,"",SQLCA.sqlcode,1)
            LET g_success = 'N'
            ROLLBACK WORK
            RETURN
         END IF
         #---卷料-----
         #---挂布-----
         INITIALIZE l_bmb.* TO NULL
         IF l_oeb.ta_oeb18 <> 'N' THEN
            LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            INITIALIZE l_tc_oem.* TO NULL
            SELECT oca02 INTO l_oca02 FROM oca_file,occ_file WHERE oca01=occ03 AND occ01=l_oea.oea03
            SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='2' AND tc_oem03=l_oeb.ta_oeb18 AND tc_oem04=nvl(l_oeb.ta_oeb23,'N')
                                                         AND (tc_oem11=l_oca02 OR tc_oem11 IS NULL)
            LET l_bmb.bmb03= l_tc_oem.tc_oem02   # 元料件
            LET l_bmb.bmb04 = g_today           #生效日期
            LET l_bmb.bmb06 = (l_oeb.ta_oeb05+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
            LET l_bmb.bmb07 = 1                 #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
            #----2on1--用量*2
            LET l_bmb06_1=0
            LET l_bmb06_2=0
            IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
               LET l_bmb06_1 = (l_oeb.ta_oeb06+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
               LET l_bmb06_2 = (l_oeb.ta_oeb07+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07*(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09/144*l_tc_oem.tc_oem10
               LET l_bmb.bmb06 = l_bmb06_1 + l_bmb06_2
            END IF
            #----2on1--用量*2
            INSERT INTO bmb_file VALUES (l_bmb.*)
            IF STATUS THEN
               LET g_showmsg="PO号：",l_oea.oea10,"/","挂布号：",l_oeb.ta_oeb18
               CALL s_errmsg("cxmi001作业中无此挂布号对应的ERP料号(挂布)",g_showmsg,"",SQLCA.sqlcode,1)
               LET g_success = 'N'
               ROLLBACK WORK
               RETURN
            END IF
         END IF
         #---挂布-----
         #---布边-----
         INITIALIZE l_bmb.* TO NULL
         IF NOT cl_null(l_oeb.ta_oeb22) AND l_oeb.ta_oeb22 <> 'N' THEN
            LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            INITIALIZE l_tc_oem.* TO NULL
            SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='3' AND tc_oem03=l_oeb.ta_oeb22
            LET l_bmb.bmb03=l_tc_oem.tc_oem02   # 元料件
            LET l_bmb.bmb04 = g_today           #生效日期
            LET l_bmb.bmb06 = ((l_oeb.ta_oeb05+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07+(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09)*l_tc_oem.tc_oem10
            LET l_bmb.bmb07 = 1                 #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
            #----2on1--用量*2
            LET l_bmb06_1=0
            LET l_bmb06_2=0
            IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
               LET l_bmb06_1 = ((l_oeb.ta_oeb06+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07+(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09)*l_tc_oem.tc_oem10
               LET l_bmb06_2 = ((l_oeb.ta_oeb07+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem07+(l_oeb.ta_oeb08+l_tc_oem.tc_oem08)*l_tc_oem.tc_oem09)*l_tc_oem.tc_oem10
               LET l_bmb.bmb06 = l_bmb06_1 + l_bmb06_2
            END IF
            #----2on1--用量*2
            INSERT INTO bmb_file VALUES (l_bmb.*)
            IF STATUS THEN
               LET g_showmsg="PO号：",l_oea.oea10,"/","布边号：",l_oeb.ta_oeb22
               CALL s_errmsg("cxmi001作业中无此布边号对应的ERP料号(布边)",g_showmsg,"",SQLCA.sqlcode,1)
               LET g_success = 'N'
               ROLLBACK WORK
               RETURN
            END IF
         END IF
         #---布边-----
         #---封板布---
         INITIALIZE l_bmb.* TO NULL
         IF NOT cl_null(l_oeb.ta_oeb14) AND l_oeb.ta_oeb14 <> 'N' AND l_oeb.ta_oeb14 <> 'STD' THEN
            LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            INITIALIZE l_tc_oem.* TO NULL
            SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='4' AND tc_oem03=l_oeb.ta_oeb22
            LET l_bmb.bmb03=l_tc_oem.tc_oem02   # 元料件
            LET l_bmb.bmb04 = g_today           #生效日期
            LET l_bmb.bmb06 = (l_oeb.ta_oeb05+l_tc_oem.tc_oem06)*l_tc_oem.tc_oem10
            LET l_bmb.bmb07 = 1                 #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
#            #----2on1--用量*2
#            IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
#               LET l_bmb.bmb06=l_bmb.bmb06*2
#            END IF
#            #----2on1--用量*2
            INSERT INTO bmb_file VALUES (l_bmb.*)
            IF STATUS THEN
               LET g_showmsg="PO号：",l_oea.oea10,"/","布边号：",l_oeb.ta_oeb22
               CALL s_errmsg("cxmi001作业中无此布边号对应的ERP料号(封板布)",g_showmsg,"",SQLCA.sqlcode,1)
               LET g_success = 'N'
               ROLLBACK WORK
               RETURN
            END IF
         END IF
         #---封板布---
         #---零件包---
         INITIALIZE l_bmb.* TO NULL
         LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            INITIALIZE l_tc_oem.* TO NULL
            SELECT oca02 INTO l_oca02 FROM oca_file,occ_file WHERE oca01=occ03 AND occ01=l_oea.oea03
            IF NOT cl_null(l_oca02) THEN
               SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='5' AND tc_oem03=l_oeb.ta_oeb13 AND (tc_oem11=l_oca02 OR tc_oem11 IS NULL)
            ELSE
               SELECT * INTO l_tc_oem.* FROM tc_oem_file WHERE tc_oem01='5' AND tc_oem03=l_oeb.ta_oeb13 AND tc_oem11 IS NULL
            END IF
            LET l_bmb.bmb03=l_tc_oem.tc_oem02   # 元料件
            LET l_bmb.bmb04 = g_today           #生效日期
            LET l_bmb.bmb06 = 1                 #组成用量
            LET l_bmb.bmb07 = 1                 #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
#            #----2on1--用量*2
#            IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
#               LET l_bmb.bmb06=l_bmb.bmb06*2
#            END IF
#            #----2on1--用量*2
            INSERT INTO bmb_file VALUES (l_bmb.*)
             #mark begin by liuyya 150116 没有零件包，不报错
         #   IF STATUS THEN
         #      LET g_showmsg="PO号：",l_oea.oea10,"/","零件包代号：",l_oeb.ta_oeb13
         #      CALL s_errmsg("cxmi001作业中无此零件包代号：对应的ERP料号(零件包)",g_showmsg,"",SQLCA.sqlcode,1)
         #      LET g_success = 'N'
         #      ROLLBACK WORK
         #      RETURN
         #   END IF
             #mark end 150116
         #---零件包---
         #---零件----
         SELECT occ03,oca02 INTO l_occ03,l_oca02 FROM occ_file LEFT JOIN oca_file ON occ03=oca01 WHERE occ01=l_oea.oea03
         LET l_sql=" SELECT * FROM tc_oeh_file WHERE tc_oeh04='",l_oeb.ta_oeb04,"'"
         IF cl_null(l_oca02) THEN
            LET l_sql=l_sql CLIPPED," AND  tc_oeh02 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND  (tc_oeh02='",l_oca02,"' OR tc_oeh02 IS NULL) "
         END IF
         SELECT occ19 INTO l_occ19 FROM occ_file WHERE occ01=l_oea.oea03
         IF cl_null(l_occ19) THEN
            LET l_sql=l_sql CLIPPED," AND  tc_oeh03 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oeh03='",l_occ19,"' OR tc_oeh03 IS NULL) "
         END IF
         PREPARE l_pre3 FROM l_sql
         DECLARE l_cur3 CURSOR FOR l_pre3
         INITIALIZE l_tc_oeh.* TO NULL
         FOREACH l_cur3 INTO l_tc_oeh.*
            IF STATUS THEN
               CALL cl_err('foreach:',STATUS,1)
               EXIT FOREACH
            END IF
            LET l_tc_oeh09=''
            IF l_oeb.ta_oeb23='Y' THEN #双层帘
               LET l_tc_oeh09 = l_tc_oeh.tc_oeh09
               IF l_oca02='SN' THEN
                   IF l_oeb.ta_oeb18='2274' OR l_oeb.ta_oeb18='2276' OR l_oeb.ta_oeb18='2277' OR l_oeb.ta_oeb18='13278' THEN
                      LET l_tc_oeh.tc_oeh09='100 White'
                   END IF
                   IF l_oeb.ta_oeb18='13223' OR l_oeb.ta_oeb18='2275' THEN
                      LET l_tc_oeh.tc_oeh09='5111 Khaki'
                   END IF
               END IF
               IF l_oca02='中小' THEN
                  IF l_oeb.ta_oeb18 ='2290' OR l_oeb.ta_oeb18 ='2291' OR l_oeb.ta_oeb18 ='2292' OR l_oeb.ta_oeb18 ='2276'
                    OR l_oeb.ta_oeb18 ='2277' OR l_oeb.ta_oeb18 ='2280' OR l_oeb.ta_oeb18 ='2274' THEN
                     LET l_tc_oeh.tc_oeh09='P-0101'
                  END IF
                  IF l_oeb.ta_oeb18 ='2281' OR l_oeb.ta_oeb18='2275' THEN
                     LET l_tc_oeh.tc_oeh09='P-0102'
                  END IF
               END IF
            ELSE        #非双层帘
               IF NOT cl_null(l_oeb.ta_oeb18) THEN #有挂布
                  IF l_oca02='SN' THEN
                      IF l_oeb.ta_oeb18='2274' OR l_oeb.ta_oeb18='2276' OR l_oeb.ta_oeb18='2277' OR l_oeb.ta_oeb18='13278' THEN
                         LET l_tc_oeh.tc_oeh09='100 White'
                      END IF
                      IF l_oeb.ta_oeb18='13223' OR l_oeb.ta_oeb18='2275' THEN
                         LET l_tc_oeh.tc_oeh09='5111 Khaki'
                      END IF
                  END IF
                  IF l_oca02='中小' THEN
                     IF l_oeb.ta_oeb18 ='2290' OR l_oeb.ta_oeb18 ='2291' OR l_oeb.ta_oeb18 ='2292' OR l_oeb.ta_oeb18 ='2276'
                       OR l_oeb.ta_oeb18 ='2277' OR l_oeb.ta_oeb18 ='2280' OR l_oeb.ta_oeb18 ='2274' THEN
                        LET l_tc_oeh.tc_oeh09='P-0101'
                     END IF
                     IF l_oeb.ta_oeb18 ='2281' OR l_oeb.ta_oeb18='2275' THEN
                        LET l_tc_oeh.tc_oeh09='P-0102'
                     END IF
                  END IF
               ELSE    #无挂布
                  LET l_tc_oeh.tc_oeh09=l_tc_oeh.tc_oeh09
               END IF
            END  IF
         END FOREACH
         LET l_sql=" SELECT tc_oen01,tc_oen02,tc_oen03,tc_oen08 FROM tc_oen_file WHERE "
         IF cl_null(l_oca02) THEN
            LET l_sql=l_sql CLIPPED," tc_oen04 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," (tc_oen04='",l_oca02,"' OR tc_oen04 IS NULL) "
         END IF
         # add by lixwz 20170811 s  當簾子是一般簾子+掛布時, 料號 407001~407007安全拉繩的配色要根據掛布屬性配色
         IF l_oeb.ta_oeb23='Y'  AND  l_oeb.ta_oeb18!='N' THEN #双层帘
            IF l_oeb.ta_oeb21='N' OR l_oeb.ta_oeb21='N/'  THEN
                  SELECT tc_oeh09 INTO l_tc_oeh.tc_oeh09 FROM tc_oeh_file
                    WHERE tc_oeh04=l_oeb.ta_oeb18
                  LET l_tc_oeh09 = l_tc_oeh.tc_oeh09
            END IF
         END IF
         # add by lixwz 20170811 e
         #-----梯绳------------
         IF NOT cl_null(l_tc_oeh09) THEN
            IF cl_null(l_tc_oeh.tc_oeh09) THEN
               LET l_sql=l_sql CLIPPED," AND (tc_oen19='",l_tc_oeh09,"' OR tc_oen19 IS NULL) "
            END IF
            IF NOT cl_null(l_tc_oeh.tc_oeh09) THEN
               LET l_sql=l_sql CLIPPED," AND (tc_oen19='",l_tc_oeh09,"' OR tc_oen19 ='",l_tc_oeh.tc_oeh09,"' OR tc_oen19 IS NULL) "
            END IF
         END IF
         IF cl_null(l_tc_oeh09) THEN
            IF cl_null(l_tc_oeh.tc_oeh09) THEN
               LET l_sql=l_sql CLIPPED," AND tc_oen19 IS NULL "
            ELSE
               LET l_sql=l_sql CLIPPED," AND (tc_oen19='",l_tc_oeh.tc_oeh09,"' OR tc_oen19 IS NULL) "
            END IF
         END IF
#-----梯绳-----------------

         #begin mark by liuyya 150127
       #  IF cl_null(l_oeb.ta_oeb21) THEN
      #      LET l_sql=l_sql CLIPPED," AND tc_oen06 IS NULL "
       #  ELSE
      #      LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL) "
       #  END IF
        #end mark by liuyya 150127

        #begin add by liuyya 150127
		LET l_ta_oeb21=l_oeb.ta_oeb21
        IF l_ta_oeb21.getLength() < 7 THEN  #长度小于7，表明维护的不是無拉/，则按原逻辑走
           IF cl_null(l_oeb.ta_oeb21) THEN
              LET l_sql=l_sql CLIPPED," AND (tc_oen06 IS NULL  OR tc_oen06='<>CORDLESS/')"
           ELSE
              IF l_oeb.ta_oeb21<>'CORDLESS/' THEN
                 LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL OR tc_oen06='<>CORDLESS/')"
              ELSE
                LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL) "
              END IF
           END IF
        END IF

        IF l_ta_oeb21.getLength() >= 7 THEN
           LET l_ta_oeb21=l_ta_oeb21.subString(1,7)
           IF cl_null(l_oeb.ta_oeb21) THEN
              LET l_sql=l_sql CLIPPED," AND (tc_oen06 IS NULL  OR tc_oen06='<>CORDLESS/')"
           ELSE
              IF l_oeb.ta_oeb21<>'CORDLESS/' THEN
			     IF l_ta_oeb21 <> '無拉/' THEN
                    LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL OR tc_oen06='<>CORDLESS/')"
			     END IF
              ELSE
			     IF l_ta_oeb21 <> '無拉/' THEN
                    LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL) "
			     END IF
              END IF
           END IF
        END IF
        #end add by liuyya 150127

        #str---add by jixf 160615
        LET l_ta_oeb21=l_oeb.ta_oeb21
        IF l_ta_oeb21.getLength() >=7 THEN
           LET l_ta_oeb21=l_ta_oeb21.subString(1,7)
           IF l_ta_oeb21 = '無拉/' THEN
                LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL OR tc_oen06='無拉/')"
           END IF
        END IF
        #end---add by jixf 160615

        #str---add by jixf 160922 几种维护值合并，代表一种意义
        IF l_oeb.ta_oeb21='N' OR l_oeb.ta_oeb21='N/' THEN
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='N' OR tc_oen06='N/' OR tc_oen06 IS NULL )"
        END IF

        IF l_oeb.ta_oeb21='無拉' OR l_oeb.ta_oeb21='無拉/' OR l_oeb.ta_oeb21='CORDLESS/' OR l_oeb.ta_oeb21='CORDLESS' THEN
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='無拉' OR tc_oen06='無拉/' OR tc_oen06='CORDLESS/' OR tc_oen06='CORDLESS' OR tc_oen06 IS NULL )"
        END IF

        IF l_oeb.ta_oeb21='Y' OR l_oeb.ta_oeb21='Y-CORD/' OR l_oeb.ta_oeb21='Y-CORD' THEN
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='Y' OR tc_oen06='Y-CORD/' OR tc_oen06='Y-CORD' OR tc_oen06 IS NULL )"
        END IF
        #end---add by jixf 160922

         IF cl_null(l_oeb.ta_oeb20) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen07 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen07='",l_oeb.ta_oeb20,"' OR tc_oen07 IS NULL) "
         END IF

         IF cl_null(l_oeb.ta_oeb23) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen08 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen08='",l_oeb.ta_oeb23,"' OR tc_oen08 IS NULL) "
         END IF

         IF cl_null(l_oeb.ta_oeb18) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen09 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen09='",l_oeb.ta_oeb18,"' OR tc_oen09 IS NULL) "
         END IF

         IF cl_null(l_oeb.ta_oeb22) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen22 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen22='",l_oeb.ta_oeb22,"' OR tc_oen22 IS NULL) "
         END IF

        #begin mark by liuyya 150127
       #  IF cl_null(l_oeb.ta_oeb42) THEN
      #      LET l_sql=l_sql CLIPPED," AND tc_oen10 IS NULL "
       #  ELSE
      #      LET l_sql=l_sql CLIPPED," AND (tc_oen10='",l_oeb.ta_oeb42,"' OR tc_oen10 IS NULL) "
       #  END IF
        #end mark by liuyya 150127

        #begin add by liuyya 150127
         IF cl_null(l_oeb.ta_oeb42) THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen10 IS NULL OR tc_oen10='<>Y')"
         ELSE
                IF l_oeb.ta_oeb42<>'Y' THEN
                    LET l_sql=l_sql CLIPPED," AND (tc_oen10='",l_oeb.ta_oeb42,"' OR tc_oen10 IS NULL OR tc_oen10='<>Y') "
                ELSE
                    LET l_sql=l_sql CLIPPED," AND (tc_oen10='",l_oeb.ta_oeb42,"' OR tc_oen10 IS NULL) "
                END IF
         END IF
        #end add by liuyya 150127

         IF cl_null(l_oeb.ta_oeb43) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen11 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen11='",l_oeb.ta_oeb43,"' OR tc_oen11 IS NULL) "
         END IF
#-----订单宽 2on1 用左帘宽 否则用订单款
         IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN  #2on1
            IF cl_null(l_oeb.ta_oeb06) THEN
               LET l_sql=l_sql CLIPPED," AND tc_oen12 IS NULL "
            ELSE
               LET l_sql=l_sql CLIPPED," AND (tc_oen12<=",l_oeb.ta_oeb06," OR tc_oen12 IS NULL) "
            END IF

            IF cl_null(l_oeb.ta_oeb06) THEN
               LET l_sql=l_sql CLIPPED," AND tc_oen13 IS NULL "
            ELSE
               LET l_sql=l_sql CLIPPED," AND (tc_oen13>=",l_oeb.ta_oeb06," OR tc_oen13 IS NULL) "
            END IF
         ELSE
            IF cl_null(l_oeb.ta_oeb05) THEN  #非2on1
               LET l_sql=l_sql CLIPPED," AND tc_oen12 IS NULL "
            ELSE
               LET l_sql=l_sql CLIPPED," AND (tc_oen12<=",l_oeb.ta_oeb05," OR tc_oen12 IS NULL) "
            END IF

            IF cl_null(l_oeb.ta_oeb05) THEN
               LET l_sql=l_sql CLIPPED," AND tc_oen13 IS NULL "
            ELSE
               LET l_sql=l_sql CLIPPED," AND (tc_oen13>=",l_oeb.ta_oeb05," OR tc_oen13 IS NULL) "
            END IF
         END IF
#------订单宽
         IF cl_null(l_oeb.ta_oeb08) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen31 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen31<=",l_oeb.ta_oeb08," OR tc_oen31 IS NULL) "
         END IF

         IF cl_null(l_oeb.ta_oeb08) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen32 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen32>=",l_oeb.ta_oeb08," OR tc_oen32 IS NULL) "
         END IF
         #---
         #---加长型固定座
         IF cl_null(l_oeb.ta_oeb32) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen23 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen23='",l_oeb.ta_oeb32,"' OR tc_oen23 IS NULL) "
         END IF
         #---加长型固定座
         #---帘身样式
         IF cl_null(l_oeb.ta_oeb02) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen24 IS NULL "
         #ELSE
         #   LET l_sql=l_sql CLIPPED," AND (tc_oen24='",l_oeb.ta_oeb02,"' OR tc_oen24 IS NULL) "
         END IF
         #str---add by jixf 160922
         IF l_oeb.ta_oeb02='HOBBLED' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='HOBBLED' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='WATERFALL' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='WATERFALL' OR tc_oen24='<>HOBBLED' ",
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='Flat Fold' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='Flat Fold' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>HOBBLED' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='Waterfall' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='Waterfall' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>HOBBLED' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='NW_TAL' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='NW_TAL' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>Waterfall' OR tc_oen24='<>HOBBLED' OR tc_oen24 IS NULL) "
         END IF
         #end---add by jixf 160922
         #---帘身样式


         IF cl_null(l_tc_oeh.tc_oeh11) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen14 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen14='",l_tc_oeh.tc_oeh11,"' OR tc_oen14 IS NULL) "
         END IF

         IF cl_null(l_tc_oeh.tc_oeh10) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen15 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen15='",l_tc_oeh.tc_oeh10,"' OR tc_oen15 IS NULL) "
         END IF

         IF cl_null(l_tc_oeh.tc_oeh12) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen16 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen16='",l_tc_oeh.tc_oeh12,"' OR tc_oen16 IS NULL) "
         END IF

         IF cl_null(l_tc_oeh.tc_oeh07) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen17 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen17='",l_tc_oeh.tc_oeh07,"' OR tc_oen17 IS NULL) "
         END IF
          # add by lixwz 20170811 s  當簾子是loop (Y-CORD)+掛布時, 料號807019~807016 1.2拉繩的配色也是根據掛布屬性配色
         IF l_oeb.ta_oeb23='Y'  AND  l_oeb.ta_oeb18!='N' THEN #双层帘
              IF l_oeb.ta_oeb21='Y-CORD'  THEN
                    SELECT tc_oeh08 INTO l_tc_oeh.tc_oeh08 FROM tc_oeh_file
                      WHERE tc_oeh04=l_ta_oeb.ta_oeb18
              END IF
         END IF
         # add by lixwz 29170811 e
         IF cl_null(l_tc_oeh.tc_oeh08) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen18 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen18='",l_tc_oeh.tc_oeh08,"' OR tc_oen18 IS NULL) "
         END IF

         IF cl_null(l_tc_oeh.tc_oeh05) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen20 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen20='",l_tc_oeh.tc_oeh05,"' OR tc_oen20 IS NULL) "
         END IF

         IF cl_null(l_tc_oeh.tc_oeh06) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen21 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen21='",l_tc_oeh.tc_oeh06,"' OR tc_oen21 IS NULL) "
         END IF

         #----客户类
         SELECT occ19 INTO l_occ19 FROM occ_file WHERE occ01=l_oea.oea03
         IF cl_null(l_occ19) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen05 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen05='",l_occ19,"' OR tc_oen05 IS NULL) "
         END IF
         #----客户类
         #---竖式上轨-----
         IF cl_null(l_oeb.ta_oeb17) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen25 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen25='",l_oeb.ta_oeb17,"' OR tc_oen25 IS NULL) "
         END IF
         #---竖式上轨-----
         #str---add by jixf 160621
         # add by lixwz 20170811 s 當簾子是無拉簾子+掛布時, 料號 807034~807037 無拉特強拉繩的配色要根據掛布屬性配色
         IF l_oeb.ta_oeb23='Y'  AND  l_oeb.ta_oeb18!='N' THEN #双层帘
            IF l_oeb.ta_oeb21='無拉' OR l_oeb.ta_oeb21='無拉/' THEN
                  SELECT tc_oeh14 INTO l_tc_oeh.tc_oeh14 FROM tc_oeh_file
                    WHERE tc_oeh04=l_ta_oeb.ta_oeb18
            END IF
         END IF
         # add by lixwz 20170811 e
         IF cl_null(l_tc_oeh.tc_oeh14) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen26 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen26='",l_tc_oeh.tc_oeh14,"' OR tc_oen26 IS NULL) "
         END IF
         IF cl_null(l_tc_oeh.tc_oeh15) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen27 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen27='",l_tc_oeh.tc_oeh15,"' OR tc_oen27 IS NULL) "
         END IF
         #IF cl_null(l_tc_oeh.tc_oeh16) THEN   #mark by jixf 160624增加了花板栏位，不需要维护面料软硬度了。
         #   LET l_sql=l_sql CLIPPED," AND tc_oen28 IS NULL "
         #ELSE
         #   LET l_sql=l_sql CLIPPED," AND (tc_oen28='",l_tc_oeh.tc_oeh16,"' OR tc_oen28 IS NULL) "
         #END IF

         LET l_sql=l_sql CLIPPED," AND (tc_oen29='",l_tc_oeh.tc_oeh04,"' OR tc_oen29 IS NULL) "  #add by jixf 160624滑輪 / 雞眼 / 圓環的用量与花板号有关
         #end---add by jixf 160621
          # add by lixwz 20170810 s
          IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN                       #add by zl 170429  2 on 1 簾取用左右簾的寬度 -begin-
                  SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
                  WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb04
                    AND tc_oeu02 <l_oeb.ta_oeb06 AND tc_oeu03 >=l_oeb.ta_oeb06
          ELSE                                                                #add by zl 170429  2 on 1 簾取用左右簾的寬度 -end-
                 SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
                  WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb04
                    AND tc_oeu02 <l_oeb.ta_oeb05 AND tc_oeu03 >=l_oeb.ta_oeb05
          END IF
            # add by lixwz 20170810 e
         IF l_tc_oeu04 >= 4 THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen33='1' OR tc_oen33 IS NULL ) "  #add by zl 170425 增加拉绳数量匹配关系
         ELSE
         	  LET l_sql=l_sql CLIPPED," AND (tc_oen33='0' OR tc_oen33 IS NULL ) "
         END IF
         PREPARE l_pre4 FROM l_sql
         DECLARE l_cur4 CURSOR FOR l_pre4
         INITIALIZE l_oen.* TO NULL
         INITIALIZE l_bmb.* TO NULL
         FOREACH l_cur4 INTO l_oen.*,l_tc_oen08
            IF STATUS THEN
               CALL cl_err('foreach:',STATUS,1)
               EXIT FOREACH
            END IF
            LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            LET l_bmb.bmb03=l_oen.oen02         # 元料件
            LET l_bmb.bmb04 = g_today           #生效日期
            #------组成用量--------
            LET l_oen.oen03=cl_replace_str(l_oen.oen03,'W',l_oeb.ta_oeb05)
            LET l_oen.oen03=cl_replace_str(l_oen.oen03,'H',l_oeb.ta_oeb08)
            LET l_ta_oeb04_t=l_oen.oen03 # add by lixwz 20170810
            # mark by lixwz 20170810 s
            #---------------------------------------add by ryan 161213 begin
            #IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN                       #add by zl 170429  2 on 1 簾取用左右簾的寬度 -begin-
            #      SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
            #      WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb04
            #        AND tc_oeu02 <l_oeb.ta_oeb06 AND tc_oeu03 >=l_oeb.ta_oeb06
           # ELSE                                                                #add by zl 170429  2 on 1 簾取用左右簾的寬度 -end-
            #     SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
            #      WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb04
            #        AND tc_oeu02 <l_oeb.ta_oeb05 AND tc_oeu03 >=l_oeb.ta_oeb05
           # END IF
         #---------------------------------------add by ryan 161213 end
         # mark by lixwz 20170810 e
            LET l_oen.oen03=cl_replace_str(l_oen.oen03,'LSS',l_tc_oeu04)  #add by ryan 161213
            LET l_sql=" select ",l_oen.oen03," from dual"
            PREPARE l_pre5 FROM l_sql
            EXECUTE l_pre5 INTO l_bmb.bmb06
            # add by lixwz 20170810 s
            IF l_oeb.ta_oeb23 = 'Y'  AND l_oeb.ta_oeb18 != 'N' THEN
                  IF l_tc_oen08 ='Y' THEN
                        IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN                       #add by zl 170429  2 on 1 簾取用左右簾的寬度 -begin-
		                  SELECT tc_oeu04 INTO l_tc_oeu04_t FROM tc_oeu_file,tc_oeo_file
		                  WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb18
		                    AND tc_oeu02 <l_oeb.ta_oeb06 AND tc_oeu03 >=l_oeb.ta_oeb06
		          ELSE                                                                #add by zl 170429  2 on 1 簾取用左右簾的寬度 -end-
		                 SELECT tc_oeu04 INTO l_tc_oeu04_t FROM tc_oeu_file,tc_oeo_file
		                  WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_oeb.ta_oeb18
		                    AND tc_oeu02 <l_oeb.ta_oeb05 AND tc_oeu03 >=l_oeb.ta_oeb05
		          END IF
                      LET l_ta_oeb04_t=cl_replace_str(l_ta_oeb04_t,'LSS',l_tc_oeu04_t)  #add by ryan 161213
                      LET l_sql=" select ",l_ta_oeb04_t," from dual"
                      PREPARE l_pre8 FROM l_sql
                      EXECUTE l_pre8 INTO l_bmb.bmb06
                  END IF
            END IF
            # add by lixwz 20170810 e
            #str---add by jixf 20150116
            LET l_ima02=''
            SELECT ima02 INTO l_ima02 FROM ima_file WHERE ima01=l_bmb.bmb03
            IF l_bmb.bmb03 LIKE '407%' OR l_bmb.bmb03 LIKE '807%' OR l_ima02 LIKE '4.0拉繩%' THEN
                IF l_oeb.ta_oeb23='Y' AND NOT cl_null(l_tc_oeh09) AND NOT cl_null(l_tc_oeh.tc_oeh09)
                  AND l_tc_oeh09 = l_tc_oeh.tc_oeh09 THEN
                        IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN      # add by lixwz 20170811
                              LET l_bmb.bmb06=l_bmb.bmb06*2
                        END IF # add by lixwz 20170811
                END IF
            END IF
            #end---add by jixf 20150116
            #------组成用量-------
            LET l_bmb.bmb07 = 1                 #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
            #----2on1--用量*2
            IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN
               LET l_ima02=''
               SELECT ima02 INTO l_ima02 FROM ima_file WHERE ima01=l_bmb.bmb03
               IF l_ima02 LIKE '%绕线板%' OR l_ima02 LIKE '%膠帶%' OR l_ima02 LIKE '%锁具%' OR l_ima02 LIKE '%螺丝%'
                  OR l_ima02 LIKE '%U型釘%' OR l_ima02 LIKE '%吊卡%' OR l_ima02 LIKE '%PC扣%' OR l_ima02 LIKE '%垂穗套%'
                  OR l_ima02 LIKE '%圆环%'  OR l_ima02 LIKE '388热熔胶条' OR l_ima02 LIKE '%滑轮%' OR l_ima02 LIKE '%鸡眼%'
                  OR l_bmb.bmb03 LIKE '407%' OR l_bmb.bmb03 LIKE '807%' OR l_ima02 LIKE '4.0拉繩%' THEN
                  LET l_bmb.bmb06=l_bmb.bmb06*2
               END IF
            END IF
            #----2on1--用量*2
            #str---add by jixf 160621 修改说明书的用量：订单数量<3，则为1；订单数量>3，则为订单数量/3，小数无条件进1
            IF l_bmb.bmb03='805011' OR l_bmb.bmb03='805012' OR l_bmb.bmb03='805013' OR l_bmb.bmb03='805014' THEN
               IF l_oeb.oeb12<=3 THEN
                  LET l_bmb.bmb07=l_oeb.oeb12
                  LET l_bmb.bmb06=1
               ELSE
                  LET l_bmb.bmb07=l_oeb.oeb12
                  SELECT ceil(l_oeb.oeb12/3) INTO l_bmb.bmb06 FROM dual
               END IF
            END IF
            #end---add by jixf 160621
            INSERT INTO bmb_file VALUES (l_bmb.*)
            IF STATUS THEN
               LET g_showmsg="PO号:",l_oea.oea10,"/",l_bmb.bmb01,"/",l_bmb.bmb03,"/",l_oen.oen01,"/",l_oen.oen02
               CALL s_errmsg("零件BOM生成失败",g_showmsg,"",SQLCA.sqlcode,1)
               LET g_success = 'N'
               ROLLBACK WORK
               RETURN
            END IF
         END FOREACH
         #---零件----
         #------产生BOM---------

         #str---add by jixf 160630 更新bom，增加弹簧
         INITIALIZE l_tc_oet05 TO NULL
         INITIALIZE l_tc_oet06 TO NULL
         INITIALIZE l_tc_oep02 TO NULL
         INITIALIZE l_tc_oer02 TO NULL
         INITIALIZE l_tc_oeq02 TO NULL
         INITIALIZE l_tc_oes02 TO NULL
         INITIALIZE l_tc_oes03 TO NULL
         #---拉绳数计算
         LET l_count=0
         SELECT COUNT(*) INTO l_count FROM bmb_file WHERE bmb01=l_bma.bma01 AND bmb03='802018'
         IF l_count>0 THEN    #空心扁铝Y
            LET l_sql=" SELECT tc_oet05,tc_oet06 FROM tc_oet_file where tc_oet01='Y' AND tc_oet03 < ",l_oeb.ta_oeb05,
                      " AND tc_oet04>=",l_oeb.ta_oeb05
            PREPARE l_pre66 FROM l_sql
            EXECUTE l_pre66 INTO l_tc_oet05,l_tc_oet06
         END IF

         IF l_count=0 THEN
            LET l_sql=" SELECT tc_oet05,tc_oet06 FROM tc_oet_file where tc_oet01='N' AND tc_oet03 < ",l_oeb.ta_oeb05,
                      " AND tc_oet04>=",l_oeb.ta_oeb05
            PREPARE l_pre67 FROM l_sql
            EXECUTE l_pre67 INTO l_tc_oet05,l_tc_oet06
         END IF
         #---拉绳数计算

         #---挂布基重
         LET l_sql="SELECT tc_oem15 FROM tc_oem_file WHERE tc_oem01='2' AND tc_oem03='",l_oeb.ta_oeb18,"' AND tc_oem15 >0 AND rownum=1"
         PREPARE l_pre68 FROM l_sql
         EXECUTE l_pre68 INTO l_tc_oep02

         IF cl_null(l_tc_oep02) THEN
            LET l_tc_oep02=0
         END IF
         #----

         #---花板基重
         LET l_sql="SELECT tc_oeh21 FROM tc_oeh_file WHERE tc_oeh04='",l_oeb.ta_oeb04,"' AND tc_oeh21>0 AND rownum=1 "
         PREPARE l_pre69 FROM l_sql
         EXECUTE l_pre69 INTO l_tc_oer02

         IF cl_null(l_tc_oer02) THEN
            LET l_tc_oer02=0
         END IF
         #----

         #----下摆基重
         LET l_count=0
         SELECT COUNT(*) INTO l_count FROM bmb_file WHERE bmb01=l_bma.bma01 AND bmb03='818005'
         IF l_count>0 THEN
            LET l_sql="SELECT tc_oem15 FROM tc_oem_file WHERE tc_oem01='6' AND tc_oem02='818005' AND tc_oem15 >0 AND rownum=1 "
            PREPARE l_pre70 FROM l_sql
            EXECUTE l_pre70 INTO l_tc_oeq02
         END IF

         IF cl_null(l_tc_oeq02) THEN
            LET l_tc_oeq02=0
         END IF

         SELECT COUNT(*) INTO l_count FROM bmb_file WHERE bmb01=l_bma.bma01 AND bmb03='818024'
         IF l_count>0 THEN
            LET l_sql="SELECT tc_oem15 FROM tc_oem_file WHERE tc_oem01='6' AND tc_oem02='818024' AND tc_oem15 >0 AND rownum=1 "
            PREPARE l_pre71 FROM l_sql
            EXECUTE l_pre71 INTO l_tc_oeq02
         END IF

         IF cl_null(l_tc_oeq02) THEN
            LET l_tc_oeq02=0
         END IF
         #----

         #----计算帘子重量 帘子重量=（花板基重+挂布基重）*（订单长*订单宽/144）+（下摆基重*订单宽）
         LET l_lian_num=(l_tc_oer02+l_tc_oep02)*(l_oeb.ta_oeb08*l_oeb.ta_oeb05/144)+(l_tc_oeq02*l_oeb.ta_oeb05)
         #------
         #增加一层判断，只有当类型为无拉时才抓取弹簧  add by zl 170523  -begin-
        IF l_oeb.ta_oeb21='無拉' OR l_oeb.ta_oeb21='無拉/' OR l_ta_oeb21 ='無拉' OR l_ta_oeb21 ='無拉/' THEN
         #--从cmxi009中抓取弹簧以及用量
         LET l_sql=" SELECT tc_oes02,tc_oes03 FROM tc_oes_file WHERE  tc_oes05< ",l_lian_num,
                   " AND tc_oes06 >=",l_lian_num
         PREPARE l_pre72 FROM l_sql
         DECLARE l_cur72 CURSOR FOR l_pre72
         FOREACH l_cur72 INTO l_tc_oes02,l_tc_oes03
            LET l_bmb.bmb01=l_bma.bma01
            SELECT sma19 INTO g_sma19 FROM sma_file
            SELECT MAX(bmb02) INTO l_bmb.bmb02 FROM bmb_file
              WHERE bmb01 = l_bma.bma01 AND bmb29 = l_bma.bma06
            IF l_bmb.bmb02 IS NULL THEN
               LET l_bmb.bmb02 = 0
            END IF
            LET l_bmb.bmb02 = l_bmb.bmb02 + g_sma19    #项次
            LET l_bmb.bmb03=l_tc_oes02         # 元料件
            LET l_bmb.bmb04 = g_today
            LET l_bmb.bmb06=l_tc_oes03
            LET l_bmb.bmb07 =  l_oeb.oeb12      #主件底数
            LET l_bmb.bmb08 = 0                 #损耗率
            SELECT ima63 INTO l_bmb.bmb10 FROM ima_file WHERE ima01=l_bmb.bmb03  #发料单位
            LET l_bmb.bmb10_fac = 1             #*“发料”对“料件库存单位” 换算率
            LET l_bmb.bmb10_fac2 = 1            # /*“发料”对“料件成本单位” 换算率
            LET l_bmb.bmb14 = '0'               #元件使用特性
            LET l_bmb.bmb15 = 'Y'               #元件消耗特性
            LET l_bmb.bmb16 = '0'               #元件取替代特性
            LET l_bmb.bmb17 = 'N'               #特性旗标
            LET l_bmb.bmb18 = 0                 #元件投料时距
            LET l_bmb.bmb19 = '1'               #工单开立展开选项
            LET l_bmb.bmb23 = 100               #选中率
            LET l_bmb.bmb27 = 'N'               #元件是否软体物件
            LET l_bmb.bmb28 = 0                 #发料误差允许率
            LET l_bmb.bmbdate = g_today
            LET l_bmb.bmbcomm = 'abmi600'
            LET l_bmb.bmb29 = ' '
            LET l_bmb.bmb31 = 'N'
            LET l_bmb.bmb33 = 0
            LET l_bmb.bmb081 = 0
            LET l_bmb.bmb082 = 1
            LET l_bmb.bmb34 = ' '
            INSERT INTO bmb_file VALUES (l_bmb.*)
         END FOREACH
         #---
        END IF  #增加一层判断，只有当类型为无拉时才抓取弹簧  add by zl 170523  -end-
         #end---add by jixf 160630
         #--------将BOM资料抛砖到其他营运中心
         INSERT INTO dw.bma_file SELECT * FROM he2.bma_file WHERE bma01=l_bma.bma01
         INSERT INTO dw.bmb_file SELECT * FROM he2.bmb_file WHERE bmb01=l_bma.bma01
         #--------将BOM资料抛砖到其他营运中心

      END FOREACH
   IF g_success = 'Y' AND NOT cl_null(g_wc) THEN
      CALL cl_err(g_oea01,'t002-11',1)
      COMMIT WORK
   END IF
END FUNCTION
