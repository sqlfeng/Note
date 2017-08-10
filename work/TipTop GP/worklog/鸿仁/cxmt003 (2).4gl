# Prog. Version..: '5.20.01-10.05.01(00000)'     #
#
# Pattern name...: cxmt001.4gl
# Descriptions...: 订单快速导入
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
DEFINE g_oeb       DYNAMIC ARRAY OF RECORD
            oea03   LIKE oea_file.oea03,
            oea02   LIKE oea_file.oea02,
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
DEFINE g_b1       DYNAMIC ARRAY OF RECORD
                  oea01   LIKE oea_file.oea01
                  END RECORD



MAIN
    OPTIONS
        INPUT NO WRAP
    DEFER INTERRUPT                            #擷取中斷鍵

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("CXM")) THEN
      EXIT PROGRAM
   END IF

   CALL  cl_used(g_prog,g_time,1) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0081

   OPEN WINDOW t001_w WITH FORM "cxm/42f/cxmt001"
       ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_init()


   LET g_action_choice = ""
   CALL t001_i()
   CLOSE WINDOW t001_w

   CALL  cl_used(g_prog,g_time,2) RETURNING g_time #No.MOD-580088  HCN 20050818  #No.FUN-6A0081
END MAIN

FUNCTION t001_i()
DEFINE p_cmd   LIKE type_file.chr1
DEFINE g_buf   LIKE type_file.chr1000
DEFINE g_t1    LIKE type_file.chr1000
DEFINE l_allow_insert  LIKE type_file.num5                 #可新增否  #No.FUN-680137 SMALLINT
DEFINE l_allow_delete  LIKE type_file.num5
DEFINE l_poy04     LIKE poy_file.poy04
DEFINE l_plant     LIKE type_file.chr1000

WHILE TRUE

       LET g_action_choice=""        #初始化Action执行标示
       IF s_shut(0) THEN RETURN END IF                                #判断目前系统是否可用
       CALL cl_opmsg('b')

       CLEAR FORM
       LET l_allow_insert = cl_detail_input_auth("insert")
       LET l_allow_delete = cl_detail_input_auth("delete")
       LET g_oea01=""
       CALL g_oeb.clear()



       DIALOG ATTRIBUTE(UNBUFFERED)
       INPUT g_oea01,g_oea904 FROM oea01,oea904

       BEFORE INPUT
          LET g_oea01=''

#       AFTER INPUT
#          IF INT_FLAG THEN
#             LET INT_FLAG = 0
#             LET g_success = 'N'
#             EXIT INPUT
#          END IF

#       ON ACTION CONTROLR
#          CALL cl_show_req_fields()
       AFTER FIELD oea904
          LET l_plant=g_plant
          SELECT poy04 INTO l_poy04 FROM poy_file WHERE poy01=g_oea904 AND poy02=0
          IF l_poy04 <> l_plant THEN
             CALL cl_err(g_oea904,'t001-01',0)
             NEXT FIELD oea904
          END IF

       ON ACTION controlp      #单别开窗
          CASE
             WHEN INFIELD(oea01)
                LET g_t1=s_get_doc_no(g_oea01)
                LET g_buf='30'
                CALL q_oay(FALSE,FALSE,g_t1,g_buf,'AXM') RETURNING g_t1  #FUN-610055
                LET g_oea01=g_t1
                DISPLAY g_t1 TO oea01
                NEXT FIELD oea01
             WHEN INFIELD(oea904)
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="q_poz1"
                 LET g_qryparam.default1 = g_oea904
                 LET g_qryparam.arg1 = '1'
                 CALL cl_create_qry() RETURNING g_oea904
                 DISPLAY g_oea904 TO oea904
                 NEXT FIELD oea904
             OTHERWISE
                EXIT CASE
          END CASE

       END INPUT

       INPUT ARRAY g_oeb FROM s_oeb.*
          ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS,
                    INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,
                    APPEND ROW=l_allow_insert)

          BEFORE INPUT
             DISPLAY "BEFORE INPUT!"
             IF g_rec_b != 0 THEN
                CALL fgl_set_arr_curr(l_ac)
             END IF

          BEFORE ROW
             LET l_ac = ARR_CURR()

       END INPUT

       ON IDLE g_idle_seconds
          CALL cl_on_idle()                                       #程序闲置时间管控
          CONTINUE DIALOG

       ON ACTION controlg
          CALL cl_cmdask()                                        #运行Ctrl+G窗口

       ON ACTION about
          CALL cl_about()                                         #程序信息

       ON ACTION HELP
          CALL cl_show_help()

       ON ACTION ACCEPT
          ACCEPT DIALOG

       ON ACTION EXIT
          LET INT_FLAG = 1
          EXIT DIALOG

       ON ACTION CANCEL
          LET INT_FLAG = 1
          EXIT DIALOG

       ON ACTION CLOSE
          LET INT_FLAG = 1
          EXIT DIALOG

       END DIALOG

       IF INT_FLAG THEN    #退出
          LET INT_FLAG = 0
          EXIT WHILE
       ELSE
          IF cl_null(g_oea01) THEN
             CALL cl_err('','t001_1',1)
             CONTINUE WHILE
          ELSE
              IF cl_confirm('i542_2') THEN
                 CALL t001_ins_oea()
                 CALL s_showmsg()      #清单式报错
                 CLEAR FORM
                 CALL g_oeb.clear()
                 CONTINUE WHILE
              ELSE
                 CONTINUE WHILE
              END IF
          END IF
       END IF
END  WHILE

END FUNCTION

FUNCTION t001_ins_oea()      #新增订单单头
DEFINE i    LIKE type_file.num5
DEFINE j    LIKE type_file.num5
DEFINE l_tc_oeu04 LIKE tc_oeu_file.tc_oeu04   #add by ryan 161213
DEFINE l_ta_oea     RECORD
       oea03     LIKE oea_file.oea03,
       oea02     LIKE oea_file.oea02,
       oea10     LIKE oea_file.oea10
                 END RECORD
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
              #oen03   LIKE tc_oen_file.tc_oen03      #mark by zl 170429
              oen03    LIKE type_file.chr500               #add by zl 170429
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
DEFINE l_bmb06_2    LIKE bmb_file.bmb06
DEFINE l_bmb06_1    LIKE bmb_file.bmb06
DEFINE ll_occ03     LIKE occ_file.occ03
DEFINE ll_oca02     LIKE oca_file.oca02
DEFINE l_ta_oeb21   STRING
DEFINE l_tc_oet05   LIKE tc_oet_file.tc_oet05
DEFINE l_tc_oet06   LIKE tc_oet_file.tc_oet06
DEFINE l_tc_oep02   LIKE tc_oep_file.tc_oep02
DEFINE l_tc_oer02   LIKE tc_oer_file.tc_oer02
DEFINE l_tc_oeq02   LIKE tc_oeq_file.tc_oeq02
DEFINE l_tc_oes02   LIKE tc_oes_file.tc_oes02
DEFINE l_tc_oes03   LIKE tc_oes_file.tc_oes03
DEFINE l_lian_num   LIKE type_file.num15_3
DROP TABLE ta_oeb_temp
CREATE TABLE ta_oeb_temp(
            oea03   VARCHAR(10),
            oea02   DATE,
            oea10   VARCHAR(30),
            ta_oeb01   VARCHAR(100),
            oeb03      DECIMAL(5),
            ta_oeb02   VARCHAR(100),
            ta_oeb03   VARCHAR(100),
            ta_oeb04   VARCHAR(100),
            ta_oeb05   VARCHAR(100),
            ta_oeb06   VARCHAR(100),
            ta_oeb07   VARCHAR(100),
            ta_oeb08   VARCHAR(100),
            oeb13      DECIMAL(20,6),
            oeb12      DECIMAL(15,3),
            oeb14t     DECIMAL(20,6),
            ta_oeb09   VARCHAR(100),
            ta_oeb10   VARCHAR(100),
            ta_oeb11   VARCHAR(100),
            ta_oeb12   VARCHAR(100),
            ta_oeb13   VARCHAR(100),
            ta_oeb14   VARCHAR(100),
            ta_oeb15   VARCHAR(100),
            ta_oeb16   VARCHAR(100),
            ta_oeb17   VARCHAR(100),
            ta_oeb18   VARCHAR(100),
            ta_oeb19   VARCHAR(100),
            ta_oeb20   VARCHAR(100),
            ta_oeb21   VARCHAR(100),
            ta_oeb22   VARCHAR(100),
            ta_oeb23   VARCHAR(100),
            ta_oeb24   VARCHAR(100),
            ta_oeb25   VARCHAR(100),
            ta_oeb26   VARCHAR(100),
            ta_oeb27   VARCHAR(100),
            ta_oeb28   VARCHAR(100),
            ta_oeb29   VARCHAR(100),
            ta_oeb30   VARCHAR(100),
            ta_oeb31   VARCHAR(100),
            ta_oeb32   VARCHAR(100),
            oeb15      DATE,
            ta_oeb33   VARCHAR(100),
            ta_oeb34   VARCHAR(100),
            ta_oeb35   VARCHAR(100),
            ta_oeb36   VARCHAR(100),
            ta_oeb37   VARCHAR(100),
            ta_oeb38   VARCHAR(100),
            ta_oeb39   VARCHAR(100),
            ta_oeb40   VARCHAR(100),
            ta_oeb41   VARCHAR(100),
            ta_oeb42   VARCHAR(100),
            ta_oeb43   VARCHAR(100),
            ta_oeb44   VARCHAR(100),
            ta_oeb45   VARCHAR(100),
            ta_oeb46   VARCHAR(100),
            ta_oeb47   VARCHAR(100),
            ta_oeb48   VARCHAR(100)
       )
   LET m=1
   LET i=g_oeb.getLength()
   FOR j=1 TO i
      INSERT INTO ta_oeb_temp VALUES (g_oeb[j].*)
   END FOR
   LET l_sql=" SELECT distinct oea03,oea02,oea10 FROM ta_oeb_temp "
   PREPARE l_pre FROM l_sql
   DECLARE l_cur CURSOR FOR l_pre
   CALL s_showmsg_init()             #清单式报错
   BEGIN WORK
   INITIALIZE l_ta_oea.* TO NULL
   LET g_success = 'Y'
   FOREACH l_cur INTO l_ta_oea.*    333333333333333333333333
      IF STATUS THEN
         CALL cl_err('foreach:',STATUS,1)
         EXIT FOREACH
      END IF
      ############生成订单单头#######################
      INITIALIZE l_oea.* TO NULL
      LET l_oea.oea00 = "1"
      LET l_oea.oea02 = l_ta_oea.oea02
      #生成订单号
      LET g_buf = '30'
      CALL s_auto_assign_no("axm",g_oea01,l_oea.oea02,g_buf,"oea_file","oea01","","","")
                  RETURNING li_result,l_oea.oea01
      #----记录oea01--------
      LET g_b1[m].oea01=l_oea.oea01
      LET m=m+1
      #----记录oea01--------
      SELECT occ01 INTO l_oea.oea03 FROM occ_file WHERE occ02=l_ta_oea.oea03 #账款客户
      LET l_oea.oea04 = l_oea.oea03     #送货客户
      LET l_oea.oea17 = l_oea.oea03     #收款客户
      SELECT occ08 INTO l_oea.oea05 FROM occ_file WHERE occ01=l_oea.oea03         #发票别
      LET l_oea.oea14 = g_user          #人员
      SELECT gen03 INTO  l_oea.oea15 FROM gen_file WHERE gen01=l_oea.oea14        #部门编号
      LET l_oea.oea10 = l_ta_oea.oea10  #客户订单号
      SELECT occ42,occ41,occ44,occ45
         INTO l_oea.oea23,            #币种
              l_oea.oea21,            #税种
              l_oea.oea31,            #价格条件
              l_oea.oea32             #收款条件
         FROM occ_file WHERE occ01=l_oea.oea03
      SELECT oaz70 INTO l_oaz70 FROM oaz_file
      CALL s_curr3(l_oea.oea23,l_oea.oea02,l_oaz70) RETURNING l_oea.oea24  #汇率   #可能抓不到（客户要设置惯用币别才可以）
      SELECT gec04,gec05,gec07
        INTO l_oea.oea211,            #税率值
             l_oea.oea212,            #联数
             l_oea.oea213             #含税否
        FROM gec_file WHERE gec01=l_oea.oea21 AND gec011='2'
      LET l_oea.oea11 = '1'           #订单来源
      LET l_oea.oea27 = 'N'           #样品
      LET l_oea.oea37 = 'N'           #订单分配否
      LET l_oea.oeamksg = 'N'         #是否签核
      LET l_oea.oea50 = 'N'           #是否做CSD展开
      LET l_oea.oeaconf = 'N'         #审核否
      LET l_oea.oea49 = '0'           #状况码
      SELECT occ241,occ48,occ49,occ47,occ46,occ43,occ68,occ69,occ71
        INTO l_oea.oea044,            #送货地址
             l_oea.oea41,             #起运地
             l_oea.oea42,             #送达地
             l_oea.oea43,             #交运方式
             l_oea.oea33,             #其他条件
             l_oea.oea25,             #销售分类一
             l_oea.oea80,             #订金收款条件
             l_oea.oea81,             #尾款收款条件
             l_oea.oea85              #结算方式
        FROM occ_file WHERE occ01=l_oea.oea03
      SELECT oaz201 INTO l_oea.oea09 FROM oaz_file  #允许超交率
      LET l_oea.oeaplant = g_plant                  #所属营运中心
      LET l_oea.oealegal = g_legal                  #所属法人
      LET l_oea.oea161 = 0                          #订金应收比率
      LET l_oea.oea162 = 100                        #出货应收比率
      LET l_oea.oea163 = 0                          #尾款应收比率
      LET l_oea.oea261 = 0                          #订金金额
      LET l_oea.oea262 = 0                          #出货金额 (单身含税金额)
      LET l_oea.oea263 = 0                          #尾款金额
      LET l_oea.oea18 = 'N'                         #是否采用订单汇率立账
      LET l_oea.oea07 = 'N'                         #出货是否计入未开发票的销货待验收入
      LET l_oea.oea65 = 'N'                         #客户出货签收否
      LET l_oea.oea61 = 0                           #订单总未税金额
      LET l_oea.oea62 = 0                           #已出货税前金额
      LET l_oea.oea63 = 0                           #被结案税前金额
      LET l_oea.oea72 = ''                          #审核日期
      LET l_oea.oeaud13 = ''
      LET l_oea.oeaud14 = ''
      LET l_oea.oeaud15 = ''
      LET l_oea.oea901 = "Y"                        #多角贸易否
      LET l_oea.oea08="2"               #订单性质（2外销）
      LET l_oea.oea902 = 'N'            #最终订单否
      LET l_oea.oea905 = 'N'            #多角贸易抛砖否
      LET l_oea.oea904 = g_oea904       #多角贸易流程代码
      SELECT occ02 INTO l_oea.oea032 FROM occ_file WHERE occ01=l_oea.oea03  #简称
      LET l_oea.oeauser = g_user
      LET l_oea.oeaoriu = g_user
      LET l_oea.oeaorig = g_grup
      #------检查是否重复导入---str--add by jixf 20150506
      LET l_count=0
      SELECT COUNT(*) INTO l_count FROM oea_file WHERE oea10=l_ta_oea.oea10
      IF l_count > 0 THEN
         LET g_showmsg=l_ta_oea.oea10
         CALL s_errmsg("oea10",g_showmsg,"",'t001-2',1)
         LET g_success = 'N'
         ROLLBACK WORK
         RETURN
      END IF
      #------检查是否重复导入----end--add by jixf 20150506
      INSERT INTO oea_file VALUES (l_oea.*)
      IF STATUS THEN
         LET g_showmsg=l_oea.oea10
         CALL s_errmsg("oea10",g_showmsg,"",SQLCA.sqlcode,1)
         LET g_success = 'N'
         ROLLBACK WORK
         RETURN
      END IF
      ############生成订单单头#######################
      ############生成订单单身#######################
      LET l_sql=" SELECT oea10,ta_oeb01,oeb03,ta_oeb02,ta_oeb03,ta_oeb04,ta_oeb05,ta_oeb06,ta_oeb07,ta_oeb08, ",
                "       oeb13,oeb12,oeb14t,ta_oeb09,ta_oeb10,ta_oeb11,ta_oeb12,ta_oeb13,ta_oeb14,ta_oeb15,ta_oeb16,ta_oeb17,ta_oeb18,  ",
                "       ta_oeb19,ta_oeb20,ta_oeb21,ta_oeb22,ta_oeb23,ta_oeb24,ta_oeb25,ta_oeb26,ta_oeb27,ta_oeb28,",
                "       ta_oeb29,ta_oeb30,ta_oeb31,ta_oeb32,oeb15,ta_oeb33,ta_oeb34,ta_oeb35,ta_oeb36,ta_oeb37,ta_oeb38,",
                "       ta_oeb39,ta_oeb40,ta_oeb41,ta_oeb42,ta_oeb43,ta_oeb44,ta_oeb45,ta_oeb46,ta_oeb47,ta_oeb48 ",
                " FROM  ta_oeb_temp WHERE oea10 = '",l_ta_oea.oea10,"'"
      PREPARE l_pre1 FROM l_sql
      DECLARE l_cur1 CURSOR FOR l_pre1
      INITIALIZE l_ta_oeb.* TO NULL
      FOREACH l_cur1 INTO l_ta_oeb.*
         IF STATUS THEN
            CALL cl_err('foreach:',STATUS,1)
            EXIT FOREACH
         END IF
         #str---mark by jixf 20150506---放在单头做检查
         #------检查是否重复导入
         #SELECT COUNT(*) INTO l_count FROM oea_file WHERE oea10=l_ta_oea.oea10  # AND oeb03=l_ta_oeb.oeb03 #mark by liuyya150504
         #IF l_count > 0 THEN
         #   LET g_showmsg=l_ta_oea.oea10,';',l_ta_oeb.oeb03
         #   CALL s_errmsg("oea10,oeb03",g_showmsg,"",'t001-2',1)
         #   LET g_success = 'N'
         #   ROLLBACK WORK
         #   RETURN
         #END IF
         #---------------------------------------add by ryan 161213 begin
         IF l_ta_oeb.ta_oeb06 >0 OR l_ta_oeb.ta_oeb07>0 THEN            #add by zl 170429  2 on 1 簾取用左右簾的寬度 -begin-
           SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
             WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_ta_oeb.ta_oeb04
               AND tc_oeu02 <l_ta_oeb.ta_oeb06 AND tc_oeu03 >=l_ta_oeb.ta_oeb06
         ELSE                                                           #add by zl 170429  2 on 1 簾取用左右簾的寬度 -end-
          SELECT tc_oeu04 INTO l_tc_oeu04 FROM tc_oeu_file,tc_oeo_file
             WHERE tc_oeu01 = tc_oeo01 AND tc_oeo03 = l_ta_oeb.ta_oeb04 # 花板号
               AND tc_oeu02 <l_ta_oeb.ta_oeb05 AND tc_oeu03 >=l_ta_oeb.ta_oeb05
         END IF
         #---------------------------------------add by ryan 161213 end
         #------检查是否重复导入
         #end---mark by jixf 20150506---放在单头做检查
         INITIALIZE l_oeb.* TO NULL
         LET l_oeb.oeb01=l_oea.oea01     #订单单号
         LET l_oeb.oeb03=l_ta_oeb.oeb03  #项次
         SELECT MAX(ima01) INTO l_oeb04 FROM ima_file WHERE length(ima01)=10
         CALL s_code_stream("cxmt001","oeb04",l_oeb04,"10","1","","") RETURNING l_oeb.oeb04  #生成十位流水码为料号
         #-----------生成料件基本档------------#
         INITIALIZE l_ima.* TO NULL
         SELECT tc_ima01 INTO l_tc_ima01 FROM tc_ima_file
         LET l_sql="SELECT * FROM ima_file WHERE ima01='",l_tc_ima01,"'"
         PREPARE l_pre2 FROM l_sql
         EXECUTE l_pre2 INTO l_ima.*
         LET l_ima.ima01=l_oeb.oeb04
         LET l_ima.ima02=l_oea.oea10   #品名是 客户订单号
         LET l_str1=l_ta_oeb.ta_oeb04
         LET l_str2=l_ta_oeb.ta_oeb05
         LET l_str3=l_ta_oeb.ta_oeb08
         LET l_ima.ima021=l_str1 CLIPPED,'/',l_str2 CLIPPED,'*',l_str3 CLIPPED #规格：花板 订单宽*订单长
         # add by zhangyu 150812----str--------
         # 增加ima39，ima58的赋值
         LET l_ima.ima58=1
         SELECT imz39 INTO l_ima.ima39 FROM DW.imz_file WHERE imz01=l_ima.ima06
         # add by zhangyu 150812----end--------
         INSERT INTO ima_file VALUES (l_ima.*)
         IF STATUS THEN
            LET g_showmsg=l_ima.ima01
            CALL s_errmsg("ima01",g_showmsg,"",SQLCA.sqlcode,1)
            LET g_success = 'N'
            ROLLBACK WORK
            RETURN
         ELSE
            INSERT INTO fh.ima_file VALUES (l_ima.*)  #抛砖到各个营运中心
            INSERT INTO bl.ima_file VALUES (l_ima.*)
            INSERT INTO pd.ima_file VALUES (l_ima.*)
            INSERT INTO dw.ima_file VALUES (l_ima.*)
         END IF
          #-----------生成料件基本档------------#
         SELECT ima02 INTO l_oeb.oeb06 FROM ima_file WHERE ima01=l_oeb.oeb04    #品名
         LET l_oeb.oeb906 = "N"
         #-----取销售单位----#
         SELECT ohi04 INTO l_ohi04 FROM ohi_file WHERE ohi01=l_oea.oea31
         IF l_ohi04="A5" THEN
            SELECT obk07 INTO l_obk07 FROM obk_file WHERE obk01= l_oeb.oeb04 AND obk02=l_oea.oea03 AND obk05=l_oea.oea23
            IF cl_null(l_obk07) THEN
               SELECT ima31 INTO l_oeb.oeb05 FROM ima_file WHERE ima01=l_oeb.oeb04
            ELSE
               LET l_oeb.oeb05=l_obk07
            END IF
         ELSE
            SELECT ima31 INTO l_oeb.oeb05 FROM ima_file WHERE ima01=l_oeb.oeb04
         END IF
         #----取销售单位----#
         #----销售/库存单位换算率----#
         SELECT ima25 INTO l_ima25 FROM ima_file WHERE ima01=l_oeb.oeb04
         CALL s_umfchk(l_oeb.oeb04,l_oeb.oeb05,l_ima25)
               RETURNING l_check,l_oeb.oeb05_fac
         IF l_check="1" THEN
            SELECT ima31_fac INTO l_oeb.oeb05_fac FROM ima_file WHERE ima01=l_oeb.oeb04
         END IF
         #----销售/库存单位换算率----#
         IF cl_null(l_ta_oeb.oeb12) THEN
            LET l_oeb.oeb12=0
            LET l_oeb.oeb912=0
         ELSE
            LET l_oeb.oeb12=l_ta_oeb.oeb12    #数量
            LET l_oeb.oeb912=l_ta_oeb.oeb12
         END IF
         LET l_today=g_today
         IF l_ta_oeb.ta_oeb33 < l_today THEN
            LET g_showmsg=l_ta_oeb.oeb15
            CALL s_errmsg("oeb15",g_showmsg,"","t001-11",1)
            LET g_success = 'N'
            ROLLBACK WORK
            RETURN
         END IF
         LET l_oeb.oeb15=l_ta_oeb.ta_oeb33    #约定交货日
         LET l_oeb.oeb24=0                 #出货数量
         LET l_oeb.oeb28=0                 #已转请购量
         IF cl_null(l_ta_oeb.oeb14t) THEN   #画面上写的含税金额栏位 应该是 obu单价
            LET l_oeb.oeb13=0+(nvl(l_ta_oeb.ta_oeb09,0)/l_oeb.oeb12)  #单价+运费 总和记为单价  #运费按数量平摊
         ELSE
            LET l_oeb.oeb13=l_ta_oeb.oeb14t+(nvl(l_ta_oeb.ta_oeb09,0)/l_oeb.oeb12)   #单价
         END IF
         LET l_oeb.oeb14t=l_oeb.oeb13*l_oeb.oeb12
         LET l_oea.oea262=l_oeb.oeb14t+nvl(l_oea.oea262,0)  #单头出货金额
         LET l_oeb.oeb14=l_oeb.oeb14t/(1+l_oea.oea211/100) #税前金额
         LET l_oea.oea61=l_oeb.oeb14+nvl(l_oea.oea61,0)    #单头税前总金额
         LET l_oea.oea1008=l_oeb.oeb14t+nvl(l_oea.oea1008,0) #单头含税总金额
         LET l_oeb.oeb19="N"               #备至否
         LET l_oeb.oeb70="N"               #结案否
         LET l_oeb.oeb16=l_oeb.oeb15           #排定交货日=约定交货日
         LET l_oeb.oeb23=0                 #待出货数量
         LET l_oeb.oeb25=0                 #已销退数量
         LET l_oeb.oeb26=0                 #被结案数量
         LET l_oeb.oeb44="1"               #经营方式
         LET l_oeb.oeb47=0                 #分摊折价=全部折价字段值的合计
         LET l_oeb.oeb48="2"               #出货方式 1.订货 2.现货
         LET l_oeb.oeb37=l_oeb.oeb13       #基础单价
         LET l_oeb.oebplant=g_plant        #所属营运中心
         LET l_oeb.oeblegal=g_legal        #所属法人
         LET l_oeb.oeb70d = ''             #结案日期
         LET l_oeb.oeb72 = ''              #产品结构指定有效日期
         LET l_oeb.oeb902= ''              #包装日期
         LET l_oeb.oeb30 = ''              #预计规还日期
         LET l_oeb.oebud10 = ''            #NO USE
         LET l_oeb.oebud11 = ''            #NO USE
         LET l_oeb.oebud12 = ''            #NO USE
         LET l_oeb.oebud13 = ''            #NO USE
         LET l_oeb.oebud14 = ''            #NO USE
         LET l_oeb.oebud15 = ''            #NO USE
         LET l_oeb.oeb32 = ''              #截止日期
#         LET l_oeb.oeb09 =                 #出货仓库
         LET l_oeb.oeb17 = 0               #取出单价
         LET l_oeb.oeb901 = 0              #已包装数
         LET l_oeb.oeb905 = 0              #已备置量
         LET l_oeb.oeb910 = l_oeb.oeb05    #单位一
         LET l_oeb.oeb911 = 1              #单位一换算率
         LET l_oeb.oeb916 = l_oeb.oeb05    #计价单位
         LET l_oeb.oeb917 = l_oeb.oeb12    #计价数量
         LET l_oeb.oeb1003 = '1'           #作业方式
         LET l_oeb.oeb1006 = 100           #折扣率
         LET l_oeb.oeb1012 = 'N'           #搭赠
         LET l_oeb.oeb29 = 0               #偿价数量
         LET l_oeb.oeb51 = '00:00:00'      #交货时间
         LET l_oeb.ta_oeb01=l_ta_oeb.ta_oeb01
         LET l_oeb.ta_oeb02=l_ta_oeb.ta_oeb02
         LET l_oeb.ta_oeb03=l_ta_oeb.ta_oeb03
         LET l_oeb.ta_oeb04=l_ta_oeb.ta_oeb04
         LET l_oeb.ta_oeb05=l_ta_oeb.ta_oeb05
         LET l_oeb.ta_oeb06=l_ta_oeb.ta_oeb06
         LET l_oeb.ta_oeb07=l_ta_oeb.ta_oeb07
         LET l_oeb.ta_oeb08=l_ta_oeb.ta_oeb08
         LET l_oeb.ta_oeb09=l_ta_oeb.ta_oeb09
         LET l_oeb.ta_oeb10=l_ta_oeb.ta_oeb10
         LET l_oeb.ta_oeb11=l_ta_oeb.ta_oeb11
         LET l_oeb.ta_oeb12=l_ta_oeb.ta_oeb12
         LET l_oeb.ta_oeb13=l_ta_oeb.ta_oeb13
         LET l_oeb.ta_oeb14=l_ta_oeb.ta_oeb14
         LET l_oeb.ta_oeb15=l_ta_oeb.ta_oeb15
         LET l_oeb.ta_oeb16=l_ta_oeb.ta_oeb16
         LET l_oeb.ta_oeb17=l_ta_oeb.ta_oeb17
         LET l_oeb.ta_oeb18=l_ta_oeb.ta_oeb18
         LET l_oeb.ta_oeb20=l_ta_oeb.ta_oeb20
         LET l_oeb.ta_oeb21=l_ta_oeb.ta_oeb21
         LET l_oeb.ta_oeb22=l_ta_oeb.ta_oeb22
         LET l_oeb.ta_oeb23=l_ta_oeb.ta_oeb23
         IF cl_null(l_oeb.ta_oeb23) THEN
            LET l_oeb.ta_oeb23='N'
         END IF
         LET l_oeb.ta_oeb24=l_ta_oeb.ta_oeb24
         LET l_oeb.ta_oeb25=l_ta_oeb.ta_oeb25
         LET l_oeb.ta_oeb26=l_ta_oeb.ta_oeb26
         LET l_oeb.ta_oeb27=l_ta_oeb.ta_oeb27
         LET l_oeb.ta_oeb28=l_ta_oeb.ta_oeb28
         LET l_oeb.ta_oeb29=l_ta_oeb.ta_oeb29
         LET l_oeb.ta_oeb30=l_ta_oeb.ta_oeb30
         LET l_oeb.ta_oeb31=l_ta_oeb.ta_oeb31
         LET l_oeb.ta_oeb32=l_ta_oeb.ta_oeb32
         LET l_oeb.ta_oeb33=l_ta_oeb.ta_oeb33
         LET l_oeb.ta_oeb34=l_ta_oeb.ta_oeb34
         LET l_oeb.ta_oeb35=l_ta_oeb.ta_oeb35
         LET l_oeb.ta_oeb36=l_ta_oeb.ta_oeb36
         LET l_oeb.ta_oeb37=l_ta_oeb.ta_oeb37
         LET l_oeb.ta_oeb38=l_ta_oeb.ta_oeb38
         LET l_oeb.ta_oeb39=l_ta_oeb.ta_oeb39
         LET l_oeb.ta_oeb40=l_ta_oeb.ta_oeb40
         LET l_oeb.ta_oeb41=l_ta_oeb.ta_oeb41
         SELECT occ03,oca02 INTO ll_occ03,ll_oca02
           FROM occ_file LEFT JOIN oca_file ON occ03=oca01 WHERE occ01=l_oea.oea03
         #----两个栏位值调换
         IF ll_oca02 = '中小' THEN
            LET l_oeb.ta_oeb42=l_ta_oeb.ta_oeb19
            LET l_oeb.ta_oeb19=l_ta_oeb.ta_oeb42
         ELSE
            LET l_oeb.ta_oeb42=l_ta_oeb.ta_oeb42
            LET l_oeb.ta_oeb19=l_ta_oeb.ta_oeb19
         END IF
         #------
         LET l_oeb.ta_oeb43=l_ta_oeb.ta_oeb43
         LET l_oeb.ta_oeb44=l_ta_oeb.ta_oeb44
         LET l_oeb.ta_oeb45=l_ta_oeb.ta_oeb45
         LET l_oeb.ta_oeb46=l_ta_oeb.ta_oeb46
         LET l_oeb.ta_oeb47=l_ta_oeb.ta_oeb47
         LET l_oeb.ta_oeb48=l_ta_oeb.ta_oeb48
         #str----add by jixf 20141219
         IF NOT cl_null(l_oeb.oeb12) THEN
             LET l_oeb.oebud03 = 'RS'
             SELECT smd04,smd06 INTO l_smd04,l_smd06 FROM smd_file
               WHERE smd01=l_oeb.oeb04 AND smd02=l_oeb.oeb05 AND smd03='RS'
             LET l_oeb.oebud08=l_oeb.oeb12*l_smd06/l_smd04
          END IF
         #end----add by jixf 20141219

         INSERT INTO oeb_file VALUES (l_oeb.*)
         IF STATUS THEN
            LET g_showmsg=l_oeb.oeb01,"/",l_oeb.oeb03
            CALL s_errmsg("ima01",g_showmsg,"",SQLCA.sqlcode,1)
            LET g_success = 'N'
            ROLLBACK WORK
            RETURN
         END IF
         ######插入单身##########
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
            SELECT oca02 INTO l_oca02 FROM oca_file,occ_file WHERE oca01=occ03 AND occ02=l_ta_oea.oea03
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
            SELECT oca02 INTO l_oca02 FROM oca_file,occ_file WHERE oca01=occ03 AND occ02=l_ta_oea.oea03
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
         FOREACH l_cur3 INTO l_tc_oeh.*   11111111
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
                  IF l_oeb.ta_oeb18 ='2281' OR l_oeb.ta_oeb18='2275' THEN   # 挂布
                     LET l_tc_oeh.tc_oeh09='P-0102'# 梯绳
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
         END FOREACH   11111111111
         LET l_sql=" SELECT tc_oen01,tc_oen02,tc_oen03 FROM tc_oen_file WHERE "  #零件属性维护档  序号、料号、公式
         IF cl_null(l_oca02) THEN             # 客户分类名称
            LET l_sql=l_sql CLIPPED," tc_oen04 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," (tc_oen04='",l_oca02,"' OR tc_oen04 IS NULL) "  # 客户分类名称
         END IF
#-----梯绳------------
         IF NOT cl_null(l_tc_oeh09) THEN   # 双层帘 Y
            IF cl_null(l_tc_oeh.tc_oeh09) THEN
               LET l_sql=l_sql CLIPPED," AND (tc_oen19='",l_tc_oeh09,"' OR tc_oen19 IS NULL) "
            END IF
            IF NOT cl_null(l_tc_oeh.tc_oeh09) THEN   # 安全梯绳 不为空
               LET l_sql=l_sql CLIPPED," AND (tc_oen19='",l_tc_oeh09,"' OR tc_oen19 ='",l_tc_oeh.tc_oeh09,"' OR tc_oen19 IS NULL) "  #  梯绳颜色
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
        IF l_ta_oeb21.getLength() < 7 THEN  #长度小于7，表明维护的不是無拉/，则按原逻辑走  # 拉珠系统
           IF cl_null(l_oeb.ta_oeb21) THEN # 拉珠系统
              LET l_sql=l_sql CLIPPED," AND (tc_oen06 IS NULL  OR tc_oen06='<>CORDLESS/')"
           ELSE
              IF l_oeb.ta_oeb21<>'CORDLESS/' THEN
                 LET l_sql=l_sql CLIPPED," AND (tc_oen06='",l_oeb.ta_oeb21,"' OR tc_oen06 IS NULL OR tc_oen06='<>CORDLESS/')"    # 拉珠系统
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
        IF l_oeb.ta_oeb21='N' OR l_oeb.ta_oeb21='N/' THEN   # 拉珠系统
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='N' OR tc_oen06='N/' OR tc_oen06 IS NULL )" # 拉珠系统
        END IF

        IF l_oeb.ta_oeb21='無拉' OR l_oeb.ta_oeb21='無拉/' OR l_oeb.ta_oeb21='CORDLESS/' OR l_oeb.ta_oeb21='CORDLESS' THEN
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='無拉' OR tc_oen06='無拉/' OR tc_oen06='CORDLESS/' OR tc_oen06='CORDLESS' OR tc_oen06 IS NULL )"
        END IF

        IF l_oeb.ta_oeb21='Y' OR l_oeb.ta_oeb21='Y-CORD/' OR l_oeb.ta_oeb21='Y-CORD' THEN
           LET l_sql=l_sql CLIPPED," AND (tc_oen06='Y' OR tc_oen06='Y-CORD/' OR tc_oen06='Y-CORD' OR tc_oen06 IS NULL )"
        END IF
        #end---add by jixf 160922

         IF cl_null(l_oeb.ta_oeb20) THEN # 上下拉
            LET l_sql=l_sql CLIPPED," AND tc_oen07 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen07='",l_oeb.ta_oeb20,"' OR tc_oen07 IS NULL) " # 上下拉TDBU
         END IF

         IF cl_null(l_oeb.ta_oeb23) THEN  # 双层帘
            LET l_sql=l_sql CLIPPED," AND tc_oen08 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen08='",l_oeb.ta_oeb23,"' OR tc_oen08 IS NULL) " # 双层帘DUAL
         END IF

         IF cl_null(l_oeb.ta_oeb18) THEN # 挂布
            LET l_sql=l_sql CLIPPED," AND tc_oen09 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen09='",l_oeb.ta_oeb18,"' OR tc_oen09 IS NULL) " # 挂布
         END IF

         IF cl_null(l_oeb.ta_oeb22) THEN  # 布边
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
         IF cl_null(l_oeb.ta_oeb42) THEN # HD
            LET l_sql=l_sql CLIPPED," AND (tc_oen10 IS NULL OR tc_oen10='<>Y')"
         ELSE
                IF l_oeb.ta_oeb42<>'Y' THEN  # HD
                    LET l_sql=l_sql CLIPPED," AND (tc_oen10='",l_oeb.ta_oeb42,"' OR tc_oen10 IS NULL OR tc_oen10='<>Y') "  # 下摆固定座
                ELSE
                    LET l_sql=l_sql CLIPPED," AND (tc_oen10='",l_oeb.ta_oeb42,"' OR tc_oen10 IS NULL) "
                END IF
         END IF
        #end add by liuyya 150127

         IF cl_null(l_oeb.ta_oeb43) THEN # MOUNT
            LET l_sql=l_sql CLIPPED," AND tc_oen11 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen11='",l_oeb.ta_oeb43,"' OR tc_oen11 IS NULL) " # 内外框安装MOUNT
         END IF
#-----订单宽 2on1 用左帘宽 否则用订单款
         IF l_oeb.ta_oeb06 >0 OR l_oeb.ta_oeb07>0 THEN  #2on1   # 2合1-左帘 2合1-右帘
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
            LET l_sql=l_sql CLIPPED," AND (tc_oen12<=",l_oeb.ta_oeb05," OR tc_oen12 IS NULL) "  # 订单宽下限< 订单宽
         END IF

         IF cl_null(l_oeb.ta_oeb05) THEN # 订单宽
            LET l_sql=l_sql CLIPPED," AND tc_oen13 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen13>=",l_oeb.ta_oeb05," OR tc_oen13 IS NULL) " # 订单宽上限>=订单宽
         END IF
         END IF
#------订单宽
         IF cl_null(l_oeb.ta_oeb08) THEN # 订单长
            LET l_sql=l_sql CLIPPED," AND tc_oen31 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen31<=",l_oeb.ta_oeb08," OR tc_oen31 IS NULL) " # 订单长下限<订单长
         END IF

         IF cl_null(l_oeb.ta_oeb08) THEN # 订单长
            LET l_sql=l_sql CLIPPED," AND tc_oen32 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen32>=",l_oeb.ta_oeb08," OR tc_oen32 IS NULL) " # 订单长上限>订单长
         END IF
         #---
         #---加长型固定座
         IF cl_null(l_oeb.ta_oeb32) THEN   # 加长型固定座
            LET l_sql=l_sql CLIPPED," AND tc_oen23 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen23='",l_oeb.ta_oeb32,"' OR tc_oen23 IS NULL) " # 加长型固定座
         END IF
         #---加长型固定座
         #---帘身样式
         IF cl_null(l_oeb.ta_oeb02) THEN
            LET l_sql=l_sql CLIPPED," AND tc_oen24 IS NULL "
         #str---mark by jixf 160922
         #ELSE
         #   LET l_sql=l_sql CLIPPED," AND (tc_oen24='",l_oeb.ta_oeb02,"' OR tc_oen24 IS NULL) "
         #end---mark by jixf 160922
         END IF

         #str---add by jixf 160922
         IF l_oeb.ta_oeb02='HOBBLED' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='HOBBLED' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='WATERFALL' THEN  # 帘身样式
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='WATERFALL' OR tc_oen24='<>HOBBLED' ", # 帘身样式
                      " OR tc_oen24='<>Flat Fold' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "
         END IF
         IF l_oeb.ta_oeb02='Flat Fold' THEN
            LET l_sql=l_sql CLIPPED," AND (tc_oen24='Flat Fold' OR tc_oen24='<>WATERFALL' ",
                      " OR tc_oen24='<>HOBBLED' OR tc_oen24='<>Waterfall' OR tc_oen24='<>NW_TAL' OR tc_oen24 IS NULL) "  #
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


         IF cl_null(l_tc_oeh.tc_oeh11) THEN # 空心扁铝
            LET l_sql=l_sql CLIPPED," AND tc_oen14 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen14='",l_tc_oeh.tc_oeh11,"' OR tc_oen14 IS NULL) " # 空心扁铝
         END IF

         IF cl_null(l_tc_oeh.tc_oeh10) THEN # PVC
            LET l_sql=l_sql CLIPPED," AND tc_oen15 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen15='",l_tc_oeh.tc_oeh10,"' OR tc_oen15 IS NULL) " #PVC
         END IF

         IF cl_null(l_tc_oeh.tc_oeh12) THEN # 上轨颜色
            LET l_sql=l_sql CLIPPED," AND tc_oen16 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen16='",l_tc_oeh.tc_oeh12,"' OR tc_oen16 IS NULL) "  # 上轨颜色
         END IF

         IF cl_null(l_tc_oeh.tc_oeh07) THEN  #  垂穗套颜色
            LET l_sql=l_sql CLIPPED," AND tc_oen17 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen17='",l_tc_oeh.tc_oeh07,"' OR tc_oen17 IS NULL) "  #  垂穗套颜色
         END IF
         #add by zl 170527  拉伸颜色根据是否双层帘判断
       #  IF l_oeb.ta_oeb23='Y' THEN #双层帘                    #先mark，預留雙層簾後面處理
       #
       #  ELSE        #非双层帘
       #     IF NOT cl_null(l_oeb.ta_oeb18) THEN #有挂布
       #
       #     ELSE    #无挂布
       #
       #     END IF
       #  END  IF
         #add by zl 170527 拉伸颜色根据是否双层帘判断
         IF cl_null(l_tc_oeh.tc_oeh08) THEN # 拉绳颜色
            LET l_sql=l_sql CLIPPED," AND tc_oen18 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen18='",l_tc_oeh.tc_oeh08,"' OR tc_oen18 IS NULL) " # 拉绳颜色
         END IF

         IF cl_null(l_tc_oeh.tc_oeh05) THEN  # LOOP循环拉绳颜色
            LET l_sql=l_sql CLIPPED," AND tc_oen20 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen20='",l_tc_oeh.tc_oeh05,"' OR tc_oen20 IS NULL) " # 循环拉绳颜色
         END IF

         IF cl_null(l_tc_oeh.tc_oeh06) THEN # LOOP安全装置颜色
            LET l_sql=l_sql CLIPPED," AND tc_oen21 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen21='",l_tc_oeh.tc_oeh06,"' OR tc_oen21 IS NULL) " # 安全装置颜色
         END IF

         #----客户类
         SELECT occ19 INTO l_occ19 FROM occ_file WHERE occ02=l_ta_oea.oea03 # 公司全名(2)  客戶簡稱 = 帳款客戶編號
         IF cl_null(l_occ19) THEN  # 公司全名(2)
            LET l_sql=l_sql CLIPPED," AND tc_oen05 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen05='",l_occ19,"' OR tc_oen05 IS NULL) " # 客户类别
         END IF
         #----客户类
         #---竖式上轨-----
         IF cl_null(l_oeb.ta_oeb17) THEN # 竖式上轨
            LET l_sql=l_sql CLIPPED," AND tc_oen25 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen25='",l_oeb.ta_oeb17,"' OR tc_oen25 IS NULL) " # 竖式上轨
         END IF
         #---竖式上轨-----

         #str---add by jixf 160621
         IF cl_null(l_tc_oeh.tc_oeh14) THEN # 无拉系统特强拉绳
            LET l_sql=l_sql CLIPPED," AND tc_oen26 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen26='",l_tc_oeh.tc_oeh14,"' OR tc_oen26 IS NULL) " # 无拉系统特强拉绳
         END IF

         IF cl_null(l_tc_oeh.tc_oeh15) THEN # 罗马帘下梁
            LET l_sql=l_sql CLIPPED," AND tc_oen27 IS NULL "
         ELSE
            LET l_sql=l_sql CLIPPED," AND (tc_oen27='",l_tc_oeh.tc_oeh15,"' OR tc_oen27 IS NULL) " # 罗马帘下梁
         END IF

         #IF cl_null(l_tc_oeh.tc_oeh16) THEN    #mark by jixf 160624增加了花板栏位，不需要维护面料软硬度了。
         #   LET l_sql=l_sql CLIPPED," AND tc_oen28 IS NULL "
         #ELSE
         #   LET l_sql=l_sql CLIPPED," AND (tc_oen28='",l_tc_oeh.tc_oeh16,"' OR tc_oen28 IS NULL) "
         #END IF

         LET l_sql=l_sql CLIPPED," AND (tc_oen29='",l_tc_oeh.tc_oeh04,"' OR tc_oen29 IS NULL) "  #add by jixf 160624滑輪 / 雞眼 / 圓環的用量与花板号有关  # 花板号
         #end---add by jixf 160621
         IF l_tc_oeu04 >= 4 THEN    # 根据花板号取得拉绳数量  ！！！
            LET l_sql=l_sql CLIPPED," AND (tc_oen33='1' OR tc_oen33 IS NULL) "  #add by zl 170425 增加拉绳数量匹配关系
         ELSE
         	  LET l_sql=l_sql CLIPPED," AND (tc_oen33='0' OR tc_oen33 IS NULL) " # 拉绳数量
         END IF
         PREPARE l_pre4 FROM l_sql
         DECLARE l_cur4 CURSOR FOR l_pre4
         INITIALIZE l_oen.* TO NULL
         INITIALIZE l_bmb.* TO NULL
         FOREACH l_cur4 INTO l_oen.*     22222222222222222222
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
            LET l_oen.oen03=cl_replace_str(l_oen.oen03,'LSS',l_tc_oeu04)  #add by ryan 161213
            LET l_sql=" select ",l_oen.oen03," from dual"
            PREPARE l_pre5 FROM l_sql
            EXECUTE l_pre5 INTO l_bmb.bmb06
            #str---add by jixf 20150116
            LET l_ima02=''
            SELECT ima02 INTO l_ima02 FROM ima_file WHERE ima01=l_bmb.bmb03
            IF l_bmb.bmb03 LIKE '407%' OR l_bmb.bmb03 LIKE '807%' OR l_ima02 LIKE '4.0拉繩%' THEN
                IF l_oeb.ta_oeb23='Y' AND NOT cl_null(l_tc_oeh09) AND NOT cl_null(l_tc_oeh.tc_oeh09)
                  AND l_tc_oeh09 = l_tc_oeh.tc_oeh09 THEN
                    LET l_bmb.bmb06=l_bmb.bmb06*2
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
         END FOREACH      2222222222
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
            EXECUTE l_pre66 INTO l_tc_oet05,l_tc_oet06  # 拉绳数 单双系统
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
         LET l_sql=" SELECT tc_oes02,tc_oes03 FROM tc_oes_file WHERE tc_oes05< ",l_lian_num,
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
         END FOREACH    333333333333
        END IF  #增加一层判断，只有当类型为无拉时才抓取弹簧  add by zl 170523  -end-
         #---

         #end---add by jixf 160630
         #--------将BOM资料抛砖到其他营运中心
         INSERT INTO dw.bma_file SELECT * FROM he2.bma_file WHERE bma01=l_bma.bma01
         INSERT INTO dw.bmb_file SELECT * FROM he2.bmb_file WHERE bmb01=l_bma.bma01
         #--------将BOM资料抛砖到其他营运中心

      END FOREACH    4444444444444
      #----更新单头税前金额,含税总金额-----
      UPDATE oea_file SET oea61=l_oea.oea61,oea1008=l_oea.oea1008 WHERE oea01=l_oea.oea01
      UPDATE oea_file SET oea262=l_oea.oea262 WHERE oea01=l_oea.oea01
   END FOREACH
   IF g_success = 'Y' THEN
      COMMIT WORK
      CALL g_b1.deleteElement(m)
      LET m=m-1
      IF m>0 THEN
         CALL t001_show_oea01(m)
      END IF
   END IF
END FUNCTION
FUNCTION t001_show_oea01(n)
DEFINE n   LIKE type_file.num5

OPEN WINDOW t001p WITH FORM "cxm/42f/cxmt001p"
         ATTRIBUTE (STYLE = g_win_style CLIPPED)
#   DIALOG ATTRIBUTE(UNBUFFERED)

   DISPLAY ARRAY g_b1 TO s_b1.* ATTRIBUTE (COUNT=n)

   ON ACTION  exporttoexcel
   LET ll_win = ui.Window.getCurrent()
      LET ll_str = dialog.getCurrentItem()
      IF ll_str.equals('s_b1') THEN
         LET ll_om = ll_win.findNode("Table","table1")
         CALL cl_export_to_excel(ll_om,base.TypeInfo.create(g_b1),'','')
      END IF

   END DISPLAY

CLOSE WINDOW t001p
END FUNCTION
