# Prog. Version..: '5.30.06-13.04.19(00004)'     #
#
# Pattern name...: axcq761.4gl
# Descriptions...: 銷貨毛利查詢
# Date & Author..: 12/08/04 By Lanhang
# Modify.........: No.FUN-C80092 12/09/12 By lixh1 增加寫入日誌功能
# Modify.........: No.FUN-C80092 12/09/18 By fengrui 增加axcq100串查功能,傳入參數改為年度/期別,關閉背景執行開窗
# Modify.........: No.FUN-C80092 12/10/5  By zm 增加插入明细资料功能以便比对axcq100销货收入差异
# Modify.........: No.FUN-D10022 13/02/21 By xianghui 優化性能
# Modify.........: No.MOD-D30160 13/03/15 By wujie 关联smy，排除不计入成本的资料
# Modify.........: No.FUN-CC0157 13/03/20 By zm 修正使用发出商品后销货收入问题
# Modify.........: No.TQC-D50098 13/05/21 By fengrui g_filter_wc赋值为' 1=1'
# Modify.........: No.TQC-D90012 13/09/12 By wujie 立账类型是出货的，单身销退金额本身就是负数，不用乘以-1
# Modify.........: No.MOD-D90121 13/09/23 By suncx 計算銷貨收入時加上開票單號作為關聯條件
# Modify.........: No.MOD-D90159 13/09/27 By suncx 销退单金额应显示负数
# Modify.........: No.160924     16/09/24 By pulf  调整KR库销货收入金额抓取不到问题,由于开票不产生tlf档，故可以mark开票单号=tlf905逻辑

DATABASE ds

GLOBALS "../../config/top.global"

DEFINE tm  RECORD
           wc      STRING,   #TQC-B70104
           bdate   LIKE type_file.dat,           #No.FUN-680122DATE
           edate   LIKE type_file.dat,           #No.FUN-680122DATE
           type    LIKE tlfc_file.tlfctype,      #No.FUN-7C0101 add
           cb1     LIKE type_file.chr1,
           cb2     LIKE type_file.chr1,
           cb3     LIKE type_file.chr1,
           cb4     LIKE type_file.chr1,
           a       LIKE type_file.chr1,          #No.FUN-680122CHAR(1)
           b       LIKE type_file.chr1,          #No.FUN-680122CHAR(1)
           c       LIKE type_file.chr1,          #No.FUN-8A0065 VARCHAR(1)
           d       LIKE type_file.chr1,          #FUN-C10015
           p1      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p2      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p3      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p4      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p5      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p6      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p7      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           p8      LIKE azp_file.azp01,          #No.FUN-8A0065 VARCHAR(10)
           more    LIKE type_file.chr1           #No.FUN-680122CHAR(1)
 		   END RECORD
DEFINE g_ckk       RECORD LIKE ckk_file.*
DEFINE g_i         LIKE type_file.num5     #count/index for any purpose
DEFINE l_table     STRING
DEFINE g_sql       STRING
DEFINE g_str       STRING
DEFINE m_plant     ARRAY[10] OF LIKE azp_file.azp01   #FUN-A70084
DEFINE m_legal     ARRAY[10] OF LIKE azw_file.azw02   #FUN-A70084
DEFINE g_rec_b     LIKE type_file.num10
DEFINE g_cnt       LIKE type_file.num10
DEFINE g_rec_b1    LIKE type_file.num10
DEFINE g_tot       LIKE tlf_file.tlf10
DEFINE g_sum1      LIKE tlf_file.tlf21
DEFINE g_sum2      LIKE tlf_file.tlf21
DEFINE g_sum3      LIKE tlf_file.tlf21
DEFINE g_rate      LIKE type_file.num20_6
DEFINE g_tlfa      DYNAMIC ARRAY OF RECORD
                   tlf01a         LIKE tlf_file.tlf01,        #料号
                   ima02a         LIKE ima_file.ima02,
                   ima021a        LIKE ima_file.ima021,
                   oma08a         LIKE oma_file.oma08,        #销售类型
                   occ03a         LIKE occ_file.occ03,
                   ima131a        LIKE ima_file.ima131,       #产品分类
                   area_namea     LIKE oab_file.oab02,        #销售区域
                   gem01a         LIKE gem_file.gem01,
                   gem02a         LIKE gem_file.gem02,        #部门
                   occ04a         LIKE occ_file.occ04,
                   gen02a         LIKE gen_file.gen02,        #业务员
                   tlf19a         LIKE tlf_file.tlf19,
                   occ02a         LIKE occ_file.occ02,
                   tlf10a         LIKE tlf_file.tlf10,        #异动数量
                   tlfc21a        LIKE tlfc_file.tlfc21,
                   saleamta       LIKE type_file.num20_6,
                   salerata       LIKE type_file.num20_6,
                   tlfc221a       LIKE tlfc_file.tlfc221,
                   tlfc222a       LIKE tlfc_file.tlfc222,
                   tlfc2231a      LIKE tlfc_file.tlfc2231,
                   tlfc224a       LIKE tlfc_file.tlfc224,
                   tlfc2241a      LIKE tlfc_file.tlfc2241,
                   tlfc2242a      LIKE tlfc_file.tlfc2242,
                   tlfc2243a      LIKE tlfc_file.tlfc2243,
                   tlfc2232a      LIKE tlfc_file.tlfc2232,
                   wsale_tlf21a   LIKE tlf_file.tlf21,
                   raterata       LIKE type_file.num20_6,
                   ratea          LIKE type_file.num20_6
                   END RECORD
DEFINE g_tlfc      DYNAMIC ARRAY OF RECORD
                   tlfc221a       LIKE tlfc_file.tlfc221,
                   tlfc222a       LIKE tlfc_file.tlfc222,
                   tlfc2231a      LIKE tlfc_file.tlfc2231,
                   tlfc224a       LIKE tlfc_file.tlfc224,
                   tlfc2241a      LIKE tlfc_file.tlfc2241,
                   tlfc2242a      LIKE tlfc_file.tlfc2242,
                   tlfc2243a      LIKE tlfc_file.tlfc2243,
                   tlfc2232a      LIKE tlfc_file.tlfc2232
                   END RECORD
DEFINE g_tlf       DYNAMIC ARRAY OF RECORD
                   tlf026        LIKE tlf_file.tlf026,       #出货单号
                   tlf027        LIKE tlf_file.tlf027,       #出货单项次
                   tlf01         LIKE tlf_file.tlf01,        #料号
                   ima02         LIKE ima_file.ima02,
                   ima021        LIKE ima_file.ima021,
                   tlf19         LIKE tlf_file.tlf19,
                   wocc02        LIKE occ_file.occ02,        #客户简称
                   tlf10         LIKE tlf_file.tlf10,        #异动数量
                   tlfc21        LIKE tlfc_file.tlfc21,      #成本  #No.FUN-7C0101 tlf21->tlfc21
                   wsaleamt      LIKE type_file.num20_6,     #销售收入 #FUN-A20044
                   l_wsale_tlf21 LIKE tlf_file.tlf21,        #毛利
                   l_rate        LIKE type_file.num20_6,     #毛利率
                   salerat       LIKE type_file.num20_6,
                   raterat       LIKE type_file.num20_6,
                   occ04         LIKE occ_file.occ04,
                   gen02         LIKE gen_file.gen02,        #业务员
                   gem01         LIKE gem_file.gem01,
                   gem02         LIKE gem_file.gem02,        #部门
                   oma08         LIKE oma_file.oma08,        #销售类型
                   oab01         LIKE oab_file.oab01,
                   occ03         LIKE occ_file.occ03,
                   warea_name    LIKE oab_file.oab02,        #销售区域
                   ima131        LIKE ima_file.ima131,       #产品分类
                   tlf036        LIKE tlf_file.tlf036,       #订单单号
                   occ37         LIKE occ_file.occ37         #关系人否
                   END RECORD
#FUN-C80092--add--str--
DEFINE g_tlf_excel DYNAMIC ARRAY OF RECORD
                   tlf026        LIKE tlf_file.tlf026,       #出货单号
                   tlf027        LIKE tlf_file.tlf027,       #出货单项次
                   tlf01         LIKE tlf_file.tlf01,        #料号
                   ima02         LIKE ima_file.ima02,
                   ima021        LIKE ima_file.ima021,
                   tlf19         LIKE tlf_file.tlf19,
                   wocc02        LIKE occ_file.occ02,        #客户简称
                   tlf10         LIKE tlf_file.tlf10,        #异动数量
                   tlfc21        LIKE tlfc_file.tlfc21,      #成本  #No.FUN-7C0101 tlf21->tlfc21
                   wsaleamt      LIKE type_file.num20_6,     #销售收入 #FUN-A20044
                   l_wsale_tlf21 LIKE tlf_file.tlf21,        #毛利
                   l_rate        LIKE type_file.num20_6,     #毛利率
                   salerat       LIKE type_file.num20_6,
                   raterat       LIKE type_file.num20_6,
                   occ04         LIKE occ_file.occ04,
                   gen02         LIKE gen_file.gen02,        #业务员
                   gem01         LIKE gem_file.gem01,
                   gem02         LIKE gem_file.gem02,        #部门
                   oma08         LIKE oma_file.oma08,        #销售类型
                   oab01         LIKE oab_file.oab01,
                   occ03         LIKE occ_file.occ03,
                   warea_name    LIKE oab_file.oab02,        #销售区域
                   ima131        LIKE ima_file.ima131,       #产品分类
                   tlf036        LIKE tlf_file.tlf036,       #订单单号
                   occ37         LIKE occ_file.occ37         #关系人否
                   END RECORD
#FUN-C80092--add--end--
DEFINE g_msg          LIKE type_file.chr1000
DEFINE g_row_count    LIKE type_file.num10
DEFINE g_curs_index   LIKE type_file.num10
DEFINE g_jump         LIKE type_file.num10
DEFINE mi_no_ask      LIKE type_file.num5
DEFINE l_ac           LIKE type_file.num5
DEFINE g_abb24        LIKE abb_file.abb24
DEFINE g_bdate,g_edate   LIKE type_file.dat            #No.FUN-680122DATE
DEFINE g_cka00        LIKE cka_file.cka00              #FUN-C80092
DEFINE g_argv8        LIKE type_file.num5               #No.FUN-C80092
DEFINE g_argv9        LIKE type_file.num5              #No.FUN-C80092
DEFINE g_argv13       LIKE type_file.chr1              #No.FUN-C80092
DEFINE g_action_flag  LIKE type_file.chr100
DEFINE g_filter_wc    STRING
DEFINE   w    ui.Window
DEFINE   f    ui.Form
DEFINE   page om.DomNode
#**************************************
DEFINE g_sql_li   STRING
DEFINE g_li         LIKE type_file.num5
DEFINE g_tlf_li DYNAMIC ARRAY OF RECORD
                    tlf905        LIKE tlf_file.tlf905,       #出货单号   #主SQL捞出的tlf026,tlf027是tlf905,tlf906赋值的，故这里可以改成tlf905,tlf906
                   tlf906        LIKE tlf_file.tlf906,       #出货单项次
                   tlf01         LIKE tlf_file.tlf01,        #料号
                   tlf13         LIKE tlf_file.tlf13,
                   tlf10         LIKE tlf_file.tlf10,        #异动数量
                   tlfc21        LIKE tlfc_file.tlfc21,      #成本  #No.FUN-7C0101 tlf21->tlfc21
                   wsaleamt      LIKE type_file.num20_6,     #销售收入 #FUN-A20044
                   ogb01         LIKE ogb_file.ogb01,        #FUN-CC0157 add
                   ogb03         LIKE ogb_file.ogb03,        #FUN-CC0157 add
                   tlf907        LIKE tlf_file.tlf907       #MOD-D90159 add
                   END RECORD

#**************************************
MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT

   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF

   WHENEVER ERROR CALL cl_err_msg_log

   IF (NOT cl_setup("AXC")) THEN
      EXIT PROGRAM
   END IF
   CALL cl_used(g_prog,g_time,1) RETURNING g_time

   LET g_pdate = ARG_VAL(1)
   LET g_towhom = ARG_VAL(2)
   LET g_rlang = ARG_VAL(3)
   LET g_bgjob = ARG_VAL(4)
   LET g_prtway = ARG_VAL(5)
   LET g_copies = ARG_VAL(6)
   LET tm.wc = ARG_VAL(7)
   LET g_argv8  = ARG_VAL(8)
   LET g_argv9  = ARG_VAL(9)
   IF NOT cl_null(g_argv8) AND NOT cl_null(g_argv9) THEN
      CALL s_azn01(g_argv8,g_argv9) RETURNING tm.bdate,tm.edate
   END IF
   LET tm.a = ARG_VAL(10)
   LET tm.b = ARG_VAL(11)
   LET tm.c = ARG_VAL(12)
   LET tm.type=ARG_VAL(13)
   LET g_argv13=tm.type   #xj add
   LET g_rep_user = ARG_VAL(14)
   LET g_rep_clas = ARG_VAL(15)
   LET g_template = ARG_VAL(16)
   LET g_rpt_name = ARG_VAL(17)
   LET tm.p1    = ARG_VAL(18)
   LET tm.p2    = ARG_VAL(19)
   LET tm.p3    = ARG_VAL(20)
   LET tm.p4    = ARG_VAL(21)
   LET tm.p5    = ARG_VAL(22)
   LET tm.p6    = ARG_VAL(23)
   LET tm.p7    = ARG_VAL(24)
   LET tm.p8    = ARG_VAL(25)

   IF cl_null(g_bgjob) or g_bgjob = 'N'THEN
      OPEN WINDOW q761_w AT 5,10  #FUN-C80092 add
           WITH FORM "axc/42f/axcq761" ATTRIBUTE(STYLE = g_win_style)  #FUN-C80092 add
      CALL cl_ui_init()           #FUN-C80092 add
      CALL cl_set_act_visible("revert_filter",FALSE)
      CALL axcq761_tm(0,0)
      CALL q761_menu()            #FUN-C80092 add
      DROP TABLE axcq761_tmp;     #FUN-C80092 add
      CLOSE WINDOW q761_w         #FUN-C80092 add
   ELSE
      CALL axcq761()
   END IF

   CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION q761_menu()
   DEFINE   l_cmd   LIKE type_file.chr1000

   WHILE TRUE
      CALL q761_bp("G")
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               CALL axcq761_tm(0,0)
            END IF
         WHEN "data_filter"       #資料過濾
            IF cl_chk_act_auth() THEN
               CALL q761_filter_askkey()
               CALL axcq761()        #重填充新臨時表
            END IF

         WHEN "revert_filter"     # 過濾還原
            IF cl_chk_act_auth() THEN
               LET g_filter_wc = ''
               CALL cl_set_act_visible("revert_filter",FALSE)
               CALL axcq761()        #重填充新臨時表
            END IF
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
         WHEN "exporttoexcel"
            IF cl_chk_act_auth() THEN
               LET w = ui.Window.getCurrent()
               LET f = w.getForm()
               CASE g_action_flag
                  WHEN 'page2'
                     LET page = f.FindNode("Page","page2")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_tlfa),'','')
                  WHEN 'page3'
                     LET page = f.FindNode("Page","page3")
                     CALL cl_export_to_excel(page,base.TypeInfo.create(g_tlf_excel),'','')
               END CASE
            END IF
         WHEN "related_document"
            IF cl_chk_act_auth() THEN
               CALL cl_doc()
            END IF
      END CASE
   END WHILE
END FUNCTION

FUNCTION axcq761_tm(p_row,p_col)
DEFINE lc_qbe_sn      LIKE gbm_file.gbm01   #No.FUN-580031
   DEFINE p_row,p_col       LIKE type_file.num5,          #No.FUN-680122 SMALLINT
          l_flag            LIKE type_file.chr1,          #No.FUN-680122 VARCHAR(1)
          l_cmd             LIKE type_file.chr1000       #No.FUN-680122 VARCHAR(400)
   DEFINE l_cnt             LIKE type_file.num5          #FUN-A70084

   CALL cl_opmsg('p')
   CALL q761_set_entry() RETURNING l_cnt    #FUN-A70084
   CALL s_azm(g_ccz.ccz01,g_ccz.ccz02)
      RETURNING l_flag,g_bdate,g_edate
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   LET g_filter_wc=''
   CALL g_tlfa.clear()
   IF cl_null(tm.bdate) THEN LET tm.bdate= g_bdate END IF        #xj add
   IF cl_null(tm.edate) THEN LET tm.edate= g_edate END IF        #xj add
   IF cl_null(tm.type)  THEN LET tm.type = g_ccz.ccz28 END IF    #xj add
   LET tm.cb1    ='1'
   LET tm.cb2    =''
   LET tm.cb3    =''
   LET tm.cb4    =''
   LET tm.a    ='3'
   LET tm.b    ='3'
   LET tm.c    ='Y'
   LET tm.d    ='N'
   LET g_pdate= g_today
   LET g_rlang= g_lang
   LET g_bgjob= 'N'
   LET g_copies= '1'
   LET tm.p1=g_plant
   DISPLAY BY NAME tm.c
   CALL q761_set_entry_1()
   CALL q761_set_no_entry_1()
   CALL q761_set_visible()
   CALL q761_set_cb_visible()


   DIALOG ATTRIBUTE(UNBUFFERED)
      INPUT BY NAME tm.bdate,tm.edate,tm.type,
                    tm.cb1,tm.cb2,tm.cb3,tm.cb4,
                    tm.a,tm.b,tm.c,tm.d,
                    tm.p1,tm.p2,tm.p3,tm.p4,
                    tm.p5,tm.p6,tm.p7,tm.p8
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
             CALL cl_qbe_display_condition(lc_qbe_sn)
         BEFORE FIELD bdate
            CALL cl_set_comp_entry("c",TRUE)
         AFTER FIELD bdate
            IF cl_null(tm.bdate) THEN NEXT FIELD bdate END IF
            CALL q761_set_entry_1()
            CALL q761_set_no_entry_1()
            CALL q761_set_no_entry()
            DISPLAY tm.c TO c

         BEFORE FIELD edate
            CALL cl_set_comp_entry("c",TRUE)
         AFTER FIELD edate
            IF cl_null(tm.edate) OR tm.edate<tm.bdate THEN NEXT FIELD edate END IF
            CALL q761_set_entry_1()
            CALL q761_set_no_entry_1()
            CALL q761_set_no_entry()
            DISPLAY tm.c TO c
         ON CHANGE bdate
            IF tm.bdate <> g_bdate THEN
               LET tm.c = 'N'
               DISPLAY tm.c TO c
               CALL q761_set_no_entry()
            END IF
         ON CHANGE edate
            IF tm.edate <> g_edate THEN
               LET tm.c = 'N'
               DISPLAY tm.c TO c
               CALL q761_set_no_entry()
            END IF
         AFTER FIELD type
            IF tm.type NOT MATCHES '[12345]' THEN NEXT FIELD type END IF

         AFTER FIELD a
            IF cl_null(tm.a) OR tm.a NOT MATCHES '[123]' THEN
               NEXT FIELD a
            END IF

         AFTER FIELD b
            IF cl_null(tm.b) OR tm.b NOT MATCHES '[123]' THEN
               NEXT FIELD b
            END IF

         AFTER FIELD c
            IF NOT cl_null(tm.c)  THEN
               IF tm.c NOT MATCHES "[YN]" THEN
                  NEXT FIELD c
               END IF
            END IF

         AFTER FIELD d
            IF NOT cl_null(tm.d)  THEN
               IF tm.d NOT MATCHES "[YN]" THEN
                  NEXT FIELD d
               END IF
            END IF

         ON CHANGE d
            CALL q761_set_visible()

         ON CHANGE cb1,cb2,cb3,cb4
            CALL q761_set_cb_visible()

         AFTER FIELD p1
            IF cl_null(tm.p1) THEN NEXT FIELD p1 END IF
               SELECT azp01 FROM azp_file WHERE azp01 = tm.p1
               IF STATUS THEN
                  CALL cl_err3("sel","azp_file",tm.p1,"",STATUS,"","sel azp",1)
                  NEXT FIELD p1
               END IF
               IF NOT cl_null(tm.p1) THEN
                  IF NOT s_chk_demo(g_user,tm.p1) THEN
                  NEXT FIELD p1
               ELSE
                  SELECT azw02 INTO m_legal[1] FROM azw_file WHERE azw01 = tm.p1
               END IF
            END IF
         AFTER FIELD p2
            IF NOT cl_null(tm.p2) THEN
               SELECT azp01 FROM azp_file WHERE azp01 = tm.p2
               IF STATUS THEN
                  CALL cl_err3("sel","azp_file",tm.p2,"",STATUS,"","sel azp",1)
                  NEXT FIELD p2
               END IF
            #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
               SELECT azw02 INTO m_legal[2] FROM azw_file WHERE azw01 = tm.p2
               IF NOT q761_chklegal(m_legal[2],1) THEN
                  CALL cl_err(tm.p2,g_errno,0)
                  NEXT FIELD p2
               END IF
            #FUN-A70084--add--end
               IF NOT s_chk_demo(g_user,tm.p2) THEN
                  NEXT FIELD p2
               END IF
            END IF

         AFTER FIELD p3
            IF NOT cl_null(tm.p3) THEN
               SELECT azp01 FROM azp_file WHERE azp01 = tm.p3
               IF STATUS THEN
                  CALL cl_err3("sel","azp_file",tm.p3,"",STATUS,"","sel azp",1)
                  NEXT FIELD p3
               END IF
               #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
               SELECT azw02 INTO m_legal[3] FROM azw_file WHERE azw01 = tm.p3
               IF NOT q761_chklegal(m_legal[3],2) THEN
                  CALL cl_err(tm.p3,g_errno,0)
                  NEXT FIELD p3
               END IF
               #FUN-A70084--add--end
               IF NOT s_chk_demo(g_user,tm.p3) THEN
                  NEXT FIELD p3
               END IF
            END IF

         AFTER FIELD p4
            IF NOT cl_null(tm.p4) THEN
               SELECT azp01 FROM azp_file WHERE azp01 = tm.p4
               IF STATUS THEN
                  CALL cl_err3("sel","azp_file",tm.p4,"",STATUS,"","sel azp",1)
                  NEXT FIELD p4
               END IF
               #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
               SELECT azw02 INTO m_legal[4] FROM azw_file WHERE azw01 = tm.p4
               IF NOT q761_chklegal(m_legal[4],3) THEN
                  CALL cl_err(tm.p4,g_errno,0)
                  NEXT FIELD p4
               END IF
               #FUN-A70084--add--end
               IF NOT s_chk_demo(g_user,tm.p4) THEN
                  NEXT FIELD p4
               END IF
            END IF

      AFTER FIELD p5
         IF NOT cl_null(tm.p5) THEN
            SELECT azp01 FROM azp_file WHERE azp01 = tm.p5
            IF STATUS THEN
               CALL cl_err3("sel","azp_file",tm.p5,"",STATUS,"","sel azp",1)
               NEXT FIELD p5
            END IF
            #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
            SELECT azw02 INTO m_legal[5] FROM azw_file WHERE azw01 = tm.p5
            IF NOT q761_chklegal(m_legal[5],4) THEN
               CALL cl_err(tm.p5,g_errno,0)
               NEXT FIELD p5
            END IF
            #FUN-A70084--add--end
            IF NOT s_chk_demo(g_user,tm.p5) THEN
               NEXT FIELD p5
            END IF
         END IF

      AFTER FIELD p6
         IF NOT cl_null(tm.p6) THEN
            SELECT azp01 FROM azp_file WHERE azp01 = tm.p6
            IF STATUS THEN
               CALL cl_err3("sel","azp_file",tm.p6,"",STATUS,"","sel azp",1)
               NEXT FIELD p6
            END IF
            #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
            SELECT azw02 INTO m_legal[6] FROM azw_file WHERE azw01 = tm.p6
            IF NOT q761_chklegal(m_legal[6],5) THEN
               CALL cl_err(tm.p6,g_errno,0)
               NEXT FIELD p6
            END IF
            #FUN-A70084--add--end
            IF NOT s_chk_demo(g_user,tm.p6) THEN
               NEXT FIELD p6
            END IF
         END IF

      AFTER FIELD p7
         IF NOT cl_null(tm.p7) THEN
            SELECT azp01 FROM azp_file WHERE azp01 = tm.p7
            IF STATUS THEN
               CALL cl_err3("sel","azp_file",tm.p7,"",STATUS,"","sel azp",1)
               NEXT FIELD p7
            END IF
            #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
            SELECT azw02 INTO m_legal[7] FROM azw_file WHERE azw01 = tm.p7
            IF NOT q761_chklegal(m_legal[7],6) THEN
               CALL cl_err(tm.p7,g_errno,0)
               NEXT FIELD p7
            END IF
            #FUN-A70084--add--end
            IF NOT s_chk_demo(g_user,tm.p7) THEN
               NEXT FIELD p7
            END IF
         END IF

      AFTER FIELD p8
         IF NOT cl_null(tm.p8) THEN
            SELECT azp01 FROM azp_file WHERE azp01 = tm.p8
            IF STATUS THEN
               CALL cl_err3("sel","azp_file",tm.p8,"",STATUS,"","sel azp",1)
               NEXT FIELD p8
            END IF
            #FUN-A70084--add--str--檢查所錄入PLANT在同一法人下
            SELECT azw02 INTO m_legal[8] FROM azw_file WHERE azw01 = tm.p8
            IF NOT q761_chklegal(m_legal[8],7) THEN
               CALL cl_err(tm.p8,g_errno,0)
               NEXT FIELD p8
            END IF
            #FUN-A70084--add--end
            IF NOT s_chk_demo(g_user,tm.p8) THEN
               NEXT FIELD p8
            END IF
         END IF
      END INPUT

      CONSTRUCT tm.wc ON tlf01,occ03,ima131,occ04,tlf19
                            FROM s_tlfa[1].tlf01a,s_tlfa[1].occ03a,s_tlfa[1].ima131a,s_tlfa[1].occ04a,s_tlfa[1].tlf19a
         BEFORE CONSTRUCT
            CALL cl_qbe_init()

      END CONSTRUCT
      ON ACTION controlp
         CASE
            WHEN INFIELD(tlf01a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_ima"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tlf01a
               NEXT FIELD tlf01a
            WHEN INFIELD(occ03a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_oca"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ03a
               NEXT FIELD occ03a
            WHEN INFIELD(occ04a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_gen"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ04a
               NEXT FIELD occ04a
            WHEN INFIELD(ima131a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_oba"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO ima131a
               NEXT FIELD ima131a
            WHEN INFIELD(tlf19a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_occ02"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tlf19a
               NEXT FIELD tlf19a
            WHEN INFIELD(p1)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p1
               CALL cl_create_qry() RETURNING tm.p1
               DISPLAY BY NAME tm.p1
               NEXT FIELD p1
            WHEN INFIELD(p2)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p2
               CALL cl_create_qry() RETURNING tm.p2
               DISPLAY BY NAME tm.p2
               NEXT FIELD p2
            WHEN INFIELD(p3)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p3
               CALL cl_create_qry() RETURNING tm.p3
               DISPLAY BY NAME tm.p3
               NEXT FIELD p3
            WHEN INFIELD(p4)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p4
               CALL cl_create_qry() RETURNING tm.p4
               DISPLAY BY NAME tm.p4
               NEXT FIELD p4
            WHEN INFIELD(p5)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p5
               CALL cl_create_qry() RETURNING tm.p5
               DISPLAY BY NAME tm.p5
               NEXT FIELD p5
            WHEN INFIELD(p6)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p6
               CALL cl_create_qry() RETURNING tm.p6
               DISPLAY BY NAME tm.p6
               NEXT FIELD p6
            WHEN INFIELD(p7)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p7
               CALL cl_create_qry() RETURNING tm.p7
               DISPLAY BY NAME tm.p7
               NEXT FIELD p7
            WHEN INFIELD(p8)
               CALL cl_init_qry_var()
               LET g_qryparam.form = "q_zxy"               #No.FUN-940102
               LET g_qryparam.arg1 = g_user                #No.FUN-940102
               LET g_qryparam.default1 = tm.p8
               CALL cl_create_qry() RETURNING tm.p8
               DISPLAY BY NAME tm.p8
               NEXT FIELD p8
         END CASE

      ON ACTION CONTROLG
         CALL cl_cmdask()    # Command execution

      ON ACTION locale
         CALL cl_show_fld_cont()
         LET g_action_choice = "locale"
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121

      ON ACTION help          #MOD-4C0121
         CALL cl_show_help()  #MOD-4C0121

      ON ACTION ACCEPT
         ACCEPT DIALOG

      ON ACTION CANCEL
         LET INT_FLAG=1
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = 1
         EXIT DIALOG

      ON ACTION qbe_save
         CALL cl_qbe_save()

   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      INITIALIZE tm.* TO NULL
      RETURN
   END IF

   LET tm.wc = tm.wc CLIPPED,cl_get_extra_cond('imauser', 'imagrup') #FUN-980030

   IF g_bgjob = 'Y' THEN
      SELECT zz08 INTO l_cmd FROM zz_file    #get exec cmd (fglgo xxxx)
             WHERE zz01='axcq761'
      IF SQLCA.sqlcode OR l_cmd IS NULL THEN
          CALL cl_err('axcq761','9031',1)
      ELSE
         LET l_cmd = l_cmd CLIPPED,
                         " '",g_pdate CLIPPED,"'",
                         " '",g_towhom CLIPPED,"'",
                         " '",g_rlang CLIPPED,"'", #No.FUN-7C0078
                         " '",g_bgjob CLIPPED,"'",
                         " '",g_prtway CLIPPED,"'",
                         " '",g_copies CLIPPED,"'",
                         " '",tm.wc CLIPPED,"'",
                         " '",tm.bdate CLIPPED,"'",
                         " '",tm.edate CLIPPED,"'",
                         " '",tm.type CLIPPED,"'" ,             #No.FUN-7C0101 add
                         " '",tm.cb1 CLIPPED,"'",                 #TQC-610051
                         " '",tm.cb2 CLIPPED,"'",                 #TQC-610051
                         " '",tm.cb3 CLIPPED,"'",
                         " '",tm.cb4 CLIPPED,"'",
                         " '",tm.a CLIPPED,"'",
                         " '",tm.b CLIPPED,"'",
                         " '",tm.c CLIPPED,"'",
                         " '",tm.d CLIPPED,"'",
                         " '",tm.p1 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p2 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p3 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p4 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p5 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p6 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p7 CLIPPED,"'" ,     #FUN-8A0065
                         " '",tm.p8 CLIPPED,"'" ,     #FUN-8A0065
                         " '",g_rep_user CLIPPED,"'",           #No.FUN-570264
                         " '",g_rep_clas CLIPPED,"'",           #No.FUN-570264
                         " '",g_template CLIPPED,"'",           #No.FUN-570264
                         " '",g_rpt_name CLIPPED,"'"            #No.FUN-7C0078

         CALL cl_cmdat('axcq761',g_time,l_cmd)    # Execute cmd at later time
      END IF
   END IF
   CALL axcq761()
END FUNCTION

FUNCTION q761_filter_askkey()
DEFINE l_wc   STRING
   CLEAR FORM
   CONSTRUCT l_wc ON tlf01,occ03,ima131,occ04,tlf19
                 FROM s_tlfa[1].tlf01a,s_tlfa[1].occ03a,s_tlfa[1].ima131a,s_tlfa[1].occ04a,s_tlfa[1].tlf19a
      BEFORE CONSTRUCT
         CALL cl_qbe_init()


      ON ACTION controlp
         CASE
            WHEN INFIELD(tlf01a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_ima"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tlf01a
               NEXT FIELD tlf01a
            WHEN INFIELD(occ03a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_oca"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ03a
               NEXT FIELD occ03a
            WHEN INFIELD(occ04a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_gen"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO occ04a
               NEXT FIELD occ04a
            WHEN INFIELD(ima131a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_oba"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO ima131a
               NEXT FIELD ima131a
            WHEN INFIELD(tlf19a)
               CALL cl_init_qry_var()
               LET g_qryparam.state = "c"
               LET g_qryparam.form ="q_occ02"
               CALL cl_create_qry() RETURNING g_qryparam.multiret
               DISPLAY g_qryparam.multiret TO tlf19a
               NEXT FIELD tlf19a
         END CASE

      ON ACTION locale
         CALL cl_show_fld_cont()
         LET g_action_choice = "locale"
         EXIT CONSTRUCT

      ON ACTION CONTROLZ
         CALL cl_show_req_fields()
      ON ACTION CONTROLG
         CALL cl_cmdask()

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE CONSTRUCT

      ON ACTION about
         CALL cl_about()

      ON ACTION HELP
         CALL cl_show_help()

      ON ACTION EXIT
         LET INT_FLAG = 1
         EXIT CONSTRUCT

      ON ACTION qbe_save
         CALL cl_qbe_save()

      ON ACTION qbe_select
         CALL cl_qbe_select()

      ON ACTION ACCEPT
         ACCEPT CONSTRUCT

      ON ACTION CANCEL
         LET INT_FLAG=1
         EXIT CONSTRUCT
   END CONSTRUCT
   IF INT_FLAG THEN
      LET g_filter_wc = ''
      CALL cl_set_act_visible("revert_filter",FALSE)
      LET INT_FLAG = 0
      RETURN
   END IF
   IF cl_null(l_wc) THEN LET l_wc =" 1=1" END IF
   IF l_wc !=" 1=1" THEN
      CALL cl_set_act_visible("revert_filter",TRUE)
   END IF
   IF cl_null(g_filter_wc) THEN LET g_filter_wc = " 1=1" END IF
   LET g_filter_wc = g_filter_wc CLIPPED," AND ",l_wc CLIPPED
END FUNCTION

FUNCTION axcq761()
   DEFINE l_name    LIKE type_file.chr20,         #No.FUN-680122CHAR(20)        # External(Disk) file name
          l_sql     STRING,                       #No.TQC-970188
          l_chr     LIKE type_file.chr1,          #No.FUN-680122 VARCHAR(1)
          l_za05    LIKE type_file.chr1000        #No.FUN-680122 VARCHAR(40)
  DEFINE wima201    LIKE type_file.chr2           #No.FUN-680122 VARCHAR( 2)
  DEFINE l_ogb01 LIKE tlf_file.tlf905       #No.FUN-CC0157
  DEFINE l_ogb03 LIKE tlf_file.tlf906       #No.FUN-CC0157
  DEFINE l_oga00    LIKE oga_file.oga00           #No.MOD-940270 add
  DEFINE l_oha09    LIKE oha_file.oha09
  DEFINE l_oga65    LIKE oga_file.oga65           #No.MOD-C30566 add
  DEFINE warea      LIKE type_file.chr4           #No.FUN-680122CHAR(4)
  DEFINE warea_name LIKE oab_file.oab01,          #No.FUN-680122CHAR(10)
    sr  RECORD
        ima01   LIKE ima_file.ima01,
        ima02   LIKE ima_file.ima02,
        ima021  LIKE ima_file.ima021,
        ima131  LIKE ima_file.ima131,
        occ02   LIKE occ_file.occ02,
        occ03   LIKE occ_file.occ03,
        occ04   LIKE occ_file.occ04,
        occ37   LIKE occ_file.occ37,
        tlf026  LIKE tlf_file.tlf026,
        tlf027  LIKE tlf_file.tlf027,
        tlf036  LIKE tlf_file.tlf036,
        tlf01   LIKE tlf_file.tlf01,
        tlf10   LIKE tlf_file.tlf10,
        tlfc21  LIKE tlfc_file.tlfc21,
        tlf13   LIKE tlf_file.tlf13,
        tlf19   LIKE tlf_file.tlf19,
        tlf66   LIKE tlf_file.tlf66,
        tlf902 LIKE tlf_file.tlf902,
        tlf903 LIKE tlf_file.tlf903,
        tlf904 LIKE tlf_file.tlf904,
        tlf905  LIKE tlf_file.tlf905,
        tlf906  LIKE tlf_file.tlf906,
        tlf907    LIKE tlf_file.tlf907,
        tlfc221   LIKE tlfc_file.tlfc221,    #材料金額   amt01
        tlfc222   LIKE tlfc_file.tlfc222,    #人工金額   amt02
        tlfc2231  LIKE tlfc_file.tlfc2231,   #製造費用一 amt03
        tlfc2232  LIKE tlfc_file.tlfc2232,   #委外加工費 amt_d
        tlfc224   LIKE tlfc_file.tlfc224,    #製造費用二 amt05
        tlfc2241  LIKE tlfc_file.tlfc2241,   #製造費用三 amt06
        tlfc2242  LIKE tlfc_file.tlfc2242,   #製造費用四 amt06
        tlfc2243  LIKE tlfc_file.tlfc2243,   #製造費用五 amt08
        wsaleamt  LIKE type_file.num20_6
        END RECORD
   DEFINE wtlf01  LIKE ahe_file.ahe01           #No.FUN-680122CHAR(3)
   DEFINE l_tlf905 LIKE tlf_file.tlf905       #MOD-710150 mod
   DEFINE l_tlf906 LIKE tlf_file.tlf906       #MOD-710150 mod
   DEFINE l_tlf905_1 LIKE tlf_file.tlf905       #No:TQC-A60085 add
   DEFINE l_tlf906_1 LIKE tlf_file.tlf906       #No:TQC-A60085 add
   DEFINE l_wsale_tlf21 LIKE tlf_file.tlf21
   DEFINE l_rate        LIKE type_file.num20_6
   DEFINE wocc02        LIKE occ_file.occ02
   DEFINE wticket       LIKE oma_file.oma33
   DEFINE l_i           LIKE type_file.num5                 #No.FUN-8A0065 SMALLINT
   DEFINE l_cnt         LIKE type_file.num5                 #No.MOD-8C0092 add
   DEFINE l_dbs         LIKE azp_file.azp03                 #No.FUN-8A0065
   DEFINE l_azp03       LIKE azp_file.azp03                 #No.FUN-8A0065
   DEFINE l_occ04       LIKE occ_file.occ04
   DEFINE l_gen02       LIKE gen_file.gen02
   DEFINE l_gem02       LIKE gem_file.gem02
   DEFINE l_occ37       LIKE occ_file.occ37                 #No.FUN-8A0065
   DEFINE i             LIKE type_file.num5                 #No.FUN-8A0065
   DEFINE l_oma00       LIKE oma_file.oma00                 #No:TQC-A60085
   DEFINE l_oma08       LIKE oma_file.oma08
   DEFINE l_omb16       LIKE omb_file.omb16                 #No:TQC-A60085
   DEFINE l_omb38       LIKE omb_file.omb38                 #No:TQC-A60085
   DEFINE l_saleamt     LIKE omb_file.omb16                 #No:TQC-A60085
   DEFINE l_oct12       LIKE oct_file.oct12                 #No:FUN-9B0017
   DEFINE l_oct14       LIKE oct_file.oct14                 #No:FUN-9B0017
   DEFINE l_oct15       LIKE oct_file.oct15                 #No:FUN-9B0017
   DEFINE l_byear       LIKE type_file.num5                 #No:FUN-9B0017
   DEFINE l_bmonth      LIKE type_file.num5                 #No:FUN-9B0017
   DEFINE l_bdate       LIKE type_file.num10                #No:FUN-9B0017
   DEFINE l_eyear       LIKE type_file.num5                 #No:FUN-9B0017
   DEFINE l_emonth      LIKE type_file.num5                 #No:FUN-9B0017
   DEFINE l_edate       LIKE type_file.num10                #No:FUN-9B0017
   DEFINE l_flag        LIKE type_file.chr1                 #MOD-B10194 add
   DEFINE l_n           LIKE type_file.num10                #free 5->10
   DEFINE l_msg         STRING
   DEFINE l_azf08       LIKE azf_file.azf08                 #FUN-C10015
   DEFINE l_num1,l_num2,l_num3  LIKE tlf_file.tlf10
   DEFINE l_cost1,l_cost2,l_cost3,l_wsaleamt,l_wsaleamt1,l_wsaleamt2 LIKE tlf_file.tlf21  #FUN-D10022 add l_wsaleamt1,l_wsaleamt2
   DEFINE l_gem01       LIKE gem_file.gem01,
          l_occ03       LIKE occ_file.occ03,
          l_ima02       LIKE ima_file.ima02,
          l_ima021      LIKE ima_file.ima021,
          l_omf10       LIKE omf_file.omf10
#wujie 130904 --begin
   DEFINE l_sql1        STRING
   DEFINE l_sql2        STRING
#wujie 130904 --end


#FUN-C80092 -----------Begin-------------
   LET l_msg = "tm.bdate = '",tm.bdate,"'",";","tm.edate = '",tm.edate,"'",";",
               "tm.type = '",tm.type,"'",";",
               "tm.cb1 = '",tm.cb1,"'",";","tm.cb2 = '",tm.cb2,"'",";",
               "tm.cb3 = '",tm.cb2,"'",";","tm.cb4 = '",tm.cb3,"'",";",
               "tm.a = '",tm.a,"'",";","tm.b = '",tm.b,"'",";",
               "tm.c = '",tm.c,"'",";","tm.d = '",tm.d,"'",";",
               "tm.p1 = '",tm.p1,"'",";","tm.p2 = '",tm.p2,"'",";",
               "tm.p3 = '",tm.p3,"'",";","tm.p4 = '",tm.p4,"'",";",
               "tm.p5 = '",tm.p5,"'",";","tm.p6 = '",tm.p6,"'",";",
               "tm.p7 = '",tm.p7,"'",";","tm.p8 = '",tm.p8,"'"
   CALL s_log_ins(g_prog,'','',tm.wc,l_msg)
        RETURNING g_cka00
#FUN-C80092 -----------End--------------
   IF cl_null(g_filter_wc) THEN LET g_filter_wc =' 1=1' END IF  #TQC-D50098
   CALL axcq761_table()

   IF tm.c='Y' THEN
      DELETE FROM ckl_file WHERE ckl07=g_ccz.ccz01 AND ckl08=g_ccz.ccz02 AND ckl01='312'
   END IF

   FOR i = 1 TO 8 LET m_plant[i] = NULL END FOR
   #FUN-C80092--add--str--
   IF cl_null(tm.p1) AND cl_null(tm.p2) AND cl_null(tm.p3) AND cl_null(tm.p4) AND
      cl_null(tm.p5) AND cl_null(tm.p6) AND cl_null(tm.p7) AND cl_null(tm.p8) THEN
      LET tm.p1 = g_plant
   END IF

   LET m_plant[1]=tm.p1
   LET m_plant[2]=tm.p2
   LET m_plant[3]=tm.p3
   LET m_plant[4]=tm.p4
   LET m_plant[5]=tm.p5
   LET m_plant[6]=tm.p6
   LET m_plant[7]=tm.p7
   LET m_plant[8]=tm.p8

   LET l_n = 1
   FOR l_i = 1 to 8
      SELECT azp03 INTO l_dbs FROM azp_file WHERE azp01=m_plant[l_i]
      LET l_dbs = s_dbstring(l_dbs CLIPPED)
      IF cl_null(m_plant[l_i]) THEN CONTINUE FOR END IF
      CALL q761_set_entry() RETURNING l_cnt
      IF l_cnt>1 THEN LET m_plant[1] = g_plant END IF   #Single DB
#FUN-D10022---------mark----------str----------------
-----------------------------------------------------
#   #   LET l_sql = "SELECT DISTINCT ima01,ima02,ima021,ima131,occ02,occ03,occ04,occ37,tlf026,tlf027,",
#   #               "       tlf036,tlf01,tlf10*tlf60,tlfc21,tlf13,tlf19,tlf66,tlf902,tlf903,tlf904,tlf905,tlf906,",
#   #               "       tlf907,tlfc221,tlfc222,tlfc2231,tlfc2232,tlfc224,tlfc2241,tlfc2242,tlfc2243,0,azf08",
#      LET l_sql = "SELECT ima01,ima02,ima021,ima131,occ02,occ03,occ04,occ37,'','',",
#                  "       '',tlf01,SUM(tlf10*tlf60*tlf907),SUM(tlfc21*tlf907),tlf13,tlf19,tlf66,'','','',tlf905,tlf906,",
#                  "       '',SUM(tlfc221*tlf907),SUM(tlfc222*tlf907),SUM(tlfc2231*tlf907),SUM(tlfc2232*tlf907),SUM(tlfc224*tlf907),SUM(tlfc2241*tlf907),",
#                  "       SUM(tlfc2242*tlf907),SUM(tlfc2243*tlf907),0,azf08 ",
#                  "  FROM ",cl_get_target_table(m_plant[l_i],'ima_file'),",",cl_get_target_table(m_plant[l_i],'tlf_file'),
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'occ_file')," ON tlf19=occ01 ",
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'azf_file')," ON tlf14=azf01 AND azf02='2' ",
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'tlfc_file')," ON tlfc01 = tlf01 ",
#                  "   AND tlfc06 = tlf06  AND tlfc02 = tlf02  AND tlfc03 = tlf03 AND ",
#                  "  tlfc13 = tlf13  AND tlfc902= tlf902 AND tlfc903= tlf903 AND ",
#                  "  tlfc904= tlf904 AND tlfc907= tlf907 AND ",
#                  "  tlfc905= tlf905 AND tlfc906= tlf906 AND ",
#                  "  tlfctype = '",tm.type,"'",
#                  " WHERE ima01 = tlf01",
#                  "   AND (tlf13 LIKE 'axmt%' OR tlf13 LIKE 'aomt%')",
#                  "   AND ",tm.wc CLIPPED,
#                  "   AND ",g_filter_wc CLIPPED,
#                  "   AND tlf902 not in (SELECT jce02 from ",cl_get_target_table(m_plant[l_i],'jce_file'),")",
#                  "   AND (tlf06 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
#                  " GROUP BY ima01,ima02,ima021,ima131,occ02,occ03,occ04,occ37,tlf01,tlf13,tlf19,tlf66,tlf905,tlf906,azf08 ",
#                  "   ORDER BY ima01,tlf905,tlf906 "
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#      PREPARE axcq761_prepare1 FROM l_sql
#      IF STATUS THEN CALL cl_err('prepare:',STATUS,1)
#         CALL s_log_upd(g_cka00,'N')             #更新日誌  #FUN-C80092
#         CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-690125 BY dxfwo
#         EXIT PROGRAM
#      END IF
#      DECLARE axcq761_curs1 CURSOR FOR axcq761_prepare1
#
#      LET g_pageno = 0
#
#      LET l_num1 = 0
#      LET l_num2 = 0
#      LET l_num3 = 0
#      LET l_cost1 = 0
#      LET l_cost2 = 0
#      LET l_cost3 = 0
#      LET l_wsaleamt = 0
#
#      FOREACH axcq761_curs1 INTO sr.*,l_azf08
#         IF STATUS THEN CALL cl_err('foreach:',STATUS,1) EXIT FOREACH END IF
#         LET l_oga00 = NULL
#         LET l_oga65 = NULL
#         IF sr.tlf13 MATCHES 'axmt*' THEN
#            SELECT oga00,oga65 INTO l_oga00,l_oga65 FROM oga_file WHERE oga01=sr.tlf905
#            IF l_oga00 = '3' OR l_oga00 ='A' OR l_oga00 = '7' OR l_oga65 = 'Y'  THEN
#               CONTINUE FOREACH
#            END IF
#         END IF
#
#         IF cl_null(l_azf08) THEN LET l_azf08='N' END IF
#         IF  cl_null(sr.tlfc221)  THEN LET sr.tlfc221=0  END IF
#         IF  cl_null(sr.tlfc222)  THEN LET sr.tlfc222=0  END IF
#         IF  cl_null(sr.tlfc2231) THEN LET sr.tlfc2231=0 END IF
#         IF  cl_null(sr.tlfc2232) THEN LET sr.tlfc2232=0 END IF
#         IF  cl_null(sr.tlfc224)  THEN LET sr.tlfc224=0  END IF
#         IF  cl_null(sr.tlfc2241) THEN LET sr.tlfc2241=0 END IF
#         IF  cl_null(sr.tlfc2242) THEN LET sr.tlfc2242=0 END IF
#         IF  cl_null(sr.tlfc2243) THEN LET sr.tlfc2243=0 END IF
#         IF  cl_null(sr.tlfc21) THEN LET sr.tlfc21=0 END IF
#       #-->退料時為正值
#    {   IF sr.tlf907 = 1 THEN
#          LET sr.tlf026 = sr.tlf036
#       ELSE
#          LET sr.tlf10= sr.tlf10 * -1
#          LET sr.tlfc221 = sr.tlfc221  * -1
#          LET sr.tlfc222 = sr.tlfc222  * -1
#          LET sr.tlfc2231= sr.tlfc2231 * -1
#          LET sr.tlfc2232= sr.tlfc2232 * -1
#          LET sr.tlfc224 = sr.tlfc224  * -1
#          LET sr.tlfc2241= sr.tlfc2241 * -1
#          LET sr.tlfc2242= sr.tlfc2242 * -1
#          LET sr.tlfc2243= sr.tlfc2243 * -1
#       END IF
#}  #Mark by zm 121106
#       LET sr.tlf026=sr.tlf905 LET sr.tlf027=sr.tlf906     #Add by zm 121106
#
#       LET sr.wsaleamt = 0
#       IF (sr.tlf905 <> l_tlf905 OR sr.tlf906 <> l_tlf906 OR sr.tlf66 = 'X') THEN
#   #Mark by zm 121106
#   #     IF sr.tlf66 = 'X' THEN
#   #        CALL s_ogc_amt_1(sr.tlf01,sr.tlf905,sr.tlf906,sr.tlf902,sr.tlf903,sr.tlf904,l_dbs) RETURNING sr.wsaleamt
#   #        LET l_flag = 'Y'
#   #     ELSE
#   #End by zm 121106
#           LET l_sql = "SELECT oma00,oma08,omb16,omb38 ",
#                      "  FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
#                                cl_get_target_table(m_plant[l_i],'omb_file'),
#                      " WHERE omb31 = '",sr.tlf905,"'",
#                      "   AND omb32 = '",sr.tlf906,"'",
#                      "   AND oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
#                      "   AND omaconf = 'Y' AND omavoid != 'Y'"
# 	      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#          PREPARE q761_prepare3 FROM l_sql
#          DECLARE q761_c3  CURSOR FOR q761_prepare3
#          LET l_saleamt = 0
#          LET l_flag = 'N'
#          LET l_oma08 =''
#          FOREACH q761_c3 INTO l_oma00,l_oma08,l_omb16,l_omb38
#             IF cl_null(l_omb16) THEN LET l_omb16 = 0 END IF
#             IF l_oma00 MATCHES '1*' AND l_omb38 = '3' THEN
#             #   IF sr.tlf907='1' THEN  #銷退
#                IF sr.tlf10>0  THEN  #銷退    #Modi by zm 121106
#                  #總遞延收入
#                   SELECT oct12 INTO l_oct12 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05 =sr.tlf906
#		              AND oct16 = '3'
#                      AND oct00 = '0'
#                   IF cl_null(l_oct12) THEN LET l_oct12 = 0 END IF
#                  #每期折讓金額
#                   LET l_byear=YEAR(tm.bdate)
#                   LET l_bmonth=MONTH(tm.bdate)
#                   LET l_bdate=(l_byear*12)+l_bmonth
#                   LET l_eyear=YEAR(tm.edate)
#                   LET l_emonth=MONTH(tm.edate)
#                   LET l_edate=(l_eyear*12)+l_emonth
#                   SELECT SUM(oct15) INTO l_oct15 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05=sr.tlf906
#                      AND oct16 = '4'
#                      AND (oct09*12)+oct10 BETWEEN l_bdate AND l_edate
#                      AND oct00 = '0'  #FUN-A60007
#                   IF cl_null(l_oct15) THEN LET l_oct15 = 0 END IF
#                  #退貨時要將原本銷貨收入 + 總遞延收入 - 每期折讓金額
#                   LET l_saleamt = l_saleamt + (l_omb16 * -1)
#                   LET l_saleamt = l_saleamt  - l_oct12 + l_oct15
#                ELSE #出貨
#                  #總遞延收入
#                   SELECT oct12 INTO l_oct12 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05 =sr.tlf906
#                      AND oct16 = '1'
#                      AND oct00 = '0'
#                   IF cl_null(l_oct12) THEN LET l_oct12 = 0 END IF
#                  #每期遞延收入
#                   LET l_byear=YEAR(tm.bdate)
#                   LET l_bmonth=MONTH(tm.bdate)
#                   LET l_bdate=(l_byear*12)+l_bmonth
#                   LET l_eyear=YEAR(tm.edate)
#                   LET l_emonth=MONTH(tm.edate)
#                   LET l_edate=(l_eyear*12)+l_emonth
#                   SELECT SUM(oct14) INTO l_oct14 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05 =sr.tlf906
#                      AND oct16 = '2'
#                      AND (oct09*12)+oct10 BETWEEN l_bdate AND l_edate
#                      AND oct00 = '0'
#                   IF cl_null(l_oct14) THEN LET l_oct14 = 0 END IF
#                  #銷貨時要將原本銷貨收入 - 總遞延收入 + 每期折讓金額
#                   LET l_saleamt = l_saleamt + (l_omb16 * -1)
#                   LET l_saleamt = l_saleamt  - l_oct12 + l_oct14
#                END IF
#             ELSE
#               # IF sr.tlf907='1' THEN  #銷退
#                IF sr.tlf10>0 THEN  #銷退    #Modi by zm 121106
#                  #總遞延收入
#                   SELECT oct12 INTO l_oct12 FROM oct_file
#                    WHERE oct06 = sr.tlf905 AND oct07 =sr.tlf906
#                      AND oct16 = '3'
#                      AND oct00 = '0'  #FUN-A60007
#                   IF cl_null(l_oct12) THEN LET l_oct12 = 0 END IF
#                  #每期折讓金額
#                   LET l_byear=YEAR(tm.bdate)
#                   LET l_bmonth=MONTH(tm.bdate)
#                   LET l_bdate=(l_byear*12)+l_bmonth
#                   LET l_eyear=YEAR(tm.edate)
#                   LET l_emonth=MONTH(tm.edate)
#                   LET l_edate=(l_eyear*12)+l_emonth
#                   SELECT SUM(oct15) INTO l_oct15 FROM oct_file
#                    WHERE oct06 = sr.tlf905 AND oct07=sr.tlf906
#                      AND oct16 = '4'
#                      AND (oct09*12)+oct10 BETWEEN l_bdate AND l_edate
#                      AND oct00 = '0'  #FUN-A60007
#                   IF cl_null(l_oct15) THEN LET l_oct15 = 0 END IF
#                  #退貨時要將原本銷貨收入 + 總遞延收入 - 每期折讓金額
#                   LET l_saleamt = l_saleamt + l_omb16
#                   LET l_saleamt = l_saleamt - l_oct12 - l_oct15
#                ELSE #出貨
#                  #總遞延收入
#                   SELECT oct12 INTO l_oct12 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05 =sr.tlf906
#		              AND oct16 = '1'
#                      AND oct00 = '0'  #FUN-A60007
#                   IF cl_null(l_oct12) THEN LET l_oct12 = 0 END IF
#                  #每期遞延收入
#                   LET l_byear=YEAR(tm.bdate)
#                   LET l_bmonth=MONTH(tm.bdate)
#                   LET l_bdate=(l_byear*12)+l_bmonth
#                   LET l_eyear=YEAR(tm.edate)
#                   LET l_emonth=MONTH(tm.edate)
#                   LET l_edate=(l_eyear*12)+l_emonth
#                   SELECT SUM(oct14) INTO l_oct14 FROM oct_file
#                    WHERE oct04 = sr.tlf905 AND oct05 =sr.tlf906
#     	              AND oct16 = '2'
#                      AND (oct09*12)+oct10 BETWEEN l_bdate AND l_edate
#                      AND oct00 = '0'  #FUN-A60007
#                   IF cl_null(l_oct14) THEN LET l_oct14 = 0 END IF
#                  #銷貨時要將原本銷貨收入-總遞延收入+每期遞延收入
#                   LET l_saleamt = l_saleamt + l_omb16
#                   LET l_saleamt = l_saleamt  - l_oct12 + l_oct14
#                END IF
#             END IF
#             LET l_flag = 'Y'
#          END FOREACH
#       #  END IF
#          LET sr.wsaleamt = l_saleamt
#     {     IF l_flag = 'N' THEN
#            IF sr.tlf13[1,4] = 'aomt' THEN
#               SELECT (ohb14*oha24) INTO sr.wsaleamt
#                 FROM oha_file,ohb_file
#                WHERE oha01 = ohb01 AND oha01 = sr.tlf905
#                  AND ohb03 = sr.tlf906
#            ELSE
#               SELECT (ogb14*oga24) INTO sr.wsaleamt
#                 FROM oga_file,ogb_file
#                WHERE oga01 = ogb01 AND oga01 = sr.tlf905
#                  AND ogb03 = sr.tlf906
#                  AND oga00!='2'
#            END IF
#          END IF
#}   #Mark by zm 121106
#          IF  cl_null(sr.wsaleamt)  THEN LET sr.wsaleamt=0 END IF
#        ## 保留舊值
#          LET l_tlf905 = sr.tlf905
#          LET l_tlf906 = sr.tlf906
#       END IF
#
#       LET sr.tlf10= sr.tlf10 * -1
#       LET sr.tlfc21  = sr.tlfc21 * -1     #add by zhangym 121121
#    #   IF sr.tlf907 = 1 then
##mark by zhangym 121114 begin-----
##       IF sr.tlf10 >0 then
##          LET sr.tlfc21  = sr.tlfc21 * -1
##          LET sr.wsaleamt = sr.wsaleamt * -1
##       END IF
##mark by zhangym 121114 end-----
#  #     IF (sr.tlf905 <> l_tlf905_1 OR sr.tlf906 <> l_tlf906_1) THEN
#  #        IF sr.tlf907 = 1 then
#  #           LET  sr.wsaleamt = sr.wsaleamt * -1
#  #        END IF
#  #        SELECT SUM(tlfc21*tlfc907*-1) INTO sr.tlfc21 FROM tlfc_file
#  #         WHERE tlfc01 = sr.ima01
#  #           AND tlfc905 = sr.tlf905
#  #           AND tlfc906 = sr.tlf906
#  #           AND (tlfc06 BETWEEN tm.bdate AND tm.edate)
#  #        IF cl_null(sr.tlfc21) THEN
#  ##           LET sr.tlfc21 = 0
#  #        END IF
#  #        LET l_tlf905_1 = sr.tlf905
#  #        LET l_tlf906_1 = sr.tlf906
#  #     ELSE
#  #        LET sr.tlfc21 = 0
#  #        LET sr.wsaleamt = 0
#  #     END IF
#       IF sr.tlf13[1,4] = 'aomt' THEN
#          LET l_sql = "SELECT oha25 ",
#                      "  FROM ",cl_get_target_table(m_plant[l_i],'oha_file'),  #FUN-A10098   #FUN-A70084 m_dbs-->m_plant
#                      " WHERE oha01 = '",sr.tlf905,"'"
#       ELSE
#          LET l_sql = "SELECT oga25 ",
#                      "  FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),   #FUN-A10098  #FUN-A70084 m_dbs-->m_plant
#                      " WHERE oga01 = '",sr.tlf905,"'",
#                      "   AND oga00 NOT IN ('A','3','7') "    #No.MOD-950210 modify
#       END IF
#       CALL cl_replace_sqldb(l_sql) RETURNING l_sql        #FUN-920032
#       PREPARE oga25_prepare3 FROM l_sql
#       DECLARE oga25_c3  CURSOR FOR oga25_prepare3
#       OPEN oga25_c3
#       FETCH oga25_c3 INTO warea
#       LET l_sql = "SELECT oab02 ",
#                   "  FROM ",cl_get_target_table(m_plant[l_i],'oab_file'),
#                   " WHERE oab01 = '",warea,"'"
#       CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#       PREPARE oab02_prepare3 FROM l_sql
#       DECLARE oab02_c3  CURSOR FOR oab02_prepare3
#       OPEN oab02_c3
#       FETCH oab02_c3 INTO warea_name
#
#      LET l_wsale_tlf21 = 0
#      IF cl_null(sr.wsaleamt) THEN LET sr.wsaleamt = 0 END IF
#      IF cl_null(sr.tlfc21)    THEN LET sr.tlfc21 = 0    END IF
#      LET l_wsale_tlf21 = sr.wsaleamt - sr.tlfc21
#      IF sr.wsaleamt <> 0 THEN
#         LET l_rate = l_wsale_tlf21/sr.wsaleamt
#      ELSE
#         LET l_rate = 0
#      END IF
#      #Add by zm 121106
#      IF sr.tlf10=0 AND sr.wsaleamt=0 AND sr.tlfc21=0 THEN
#         CONTINUE FOREACH
#      END IF
#      #End by zm 121106
#      LET wocc02  = ' '
#      LET wticket = ' '
#      LET wima201 =  sr.tlf01
#      LET l_sql = "SELECT occ02,occ03,occ04,occ37 ",
#                  "  FROM ",cl_get_target_table(m_plant[l_i],'occ_file'),
#                  " WHERE occ01= '",sr.tlf19,"'"
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#      PREPARE occ_prepare3 FROM l_sql
#      DECLARE occ_c3  CURSOR FOR occ_prepare3
#      OPEN occ_c3
#      FETCH occ_c3 INTO wocc02,l_occ03,l_occ04,l_occ37
#      IF cl_null(l_occ37) THEN LET l_occ37 = 'N' END IF
#      IF tm.b = '1' THEN
#         IF l_occ37  = 'N' THEN  CONTINUE FOREACH END IF
#      END IF
#      IF tm.b = '2' THEN   #非關係人
#         IF l_occ37  = 'Y' THEN  CONTINUE FOREACH END IF
#      END IF
#      IF cl_null(l_oma08) THEN
#         IF sr.tlf13 ='axmt670' THEN
#            SELECT omf10 INTO l_omf10 FROM omf_file
#             WHERE omf00 = sr.tlf026 AND omf21 = sr.tlf027
#            IF l_omf10 = '1' THEN
#               LET l_sql = "SELECT oga08 ",
#                           "  FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),
#                           " ,",cl_get_target_table(m_plant[l_i],'omf_file'),
#                           " WHERE omf00 = '",sr.tlf026,"'",
#                           "   AND omf21 = '",sr.tlf027,"'",
#                           "   AND omf11 = oga01 ",
#                           "   AND oga00 NOT IN ('A','3','7') "
#            END IF
#            IF l_omf10 = '2' THEN
#               LET l_sql = "SELECT oha08 ",
#                           "  FROM ",cl_get_target_table(m_plant[l_i],'oha_file'),
#                           " ,",cl_get_target_table(m_plant[l_i],'omf_file'),
#                           " WHERE omf00 = '",sr.tlf026,"'",
#                           "   AND omf21 = '",sr.tlf027,"'",
#                           "   AND omf11 = oha01 "
#            END IF
#         ELSE
#            IF sr.tlf13[1,4] = 'aomt' THEN
#               LET l_sql = "SELECT oha08 ",
#                           "  FROM ",cl_get_target_table(m_plant[l_i],'oha_file'),
#                           " WHERE oha01 = '",sr.tlf026,"'"
#            ELSE
#               LET l_sql = "SELECT oga08 ",
#                           "  FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),
#                           " WHERE oga01 = '",sr.tlf026,"'",
#                           "   AND oga00 NOT IN ('A','3','7') "
#            END IF
#         END IF
#         CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#         PREPARE oga08_prepare  FROM l_sql
#         DECLARE oga08_cs  CURSOR FOR oga08_prepare
#         OPEN oga08_cs
#         FETCH oga08_cs INTO l_oma08
#      END IF
#      IF tm.a = '1' THEN
#         IF l_oma08  <> '1' THEN  CONTINUE FOREACH END IF
#      END IF
#      IF tm.a = '2' THEN
#         IF l_oma08  <> '2' THEN  CONTINUE FOREACH END IF
#      END IF
#      LET l_sql="SELECT gen02,gem01,gem02 ",
#                "  FROM ",cl_get_target_table(m_plant[l_i],'gen_file'),",",cl_get_target_table(m_plant[l_i],'gem_file'),
#                " WHERE gen01 = '",l_occ04,"'",
#                "   AND gen03 = gem01"
#      CALL cl_replace_sqldb(l_sql) RETURNING l_sql
#      PREPARE gen_prepare3 FROM l_sql
#      DECLARE gen_c3  CURSOR FOR gen_prepare3
#      OPEN gen_c3
#      FETCH gen_c3 INTO l_gen02,l_gem01,l_gem02
#      SELECT ima02,ima021 INTO l_ima02,l_ima021 FROM ima_file
#       WHERE ima01 = sr.tlf01
#      LET g_tlf_excel[l_n].tlf026 = sr.tlf026
#      LET g_tlf_excel[l_n].tlf027 = sr.tlf027
#      LET g_tlf_excel[l_n].tlf01 = sr.tlf01
#      LET g_tlf_excel[l_n].ima02 = l_ima02
#      LET g_tlf_excel[l_n].ima021 = l_ima021
#      LET g_tlf_excel[l_n].tlf19 = sr.tlf19
#      LET g_tlf_excel[l_n].wocc02 = wocc02
#      LET g_tlf_excel[l_n].tlf10 = sr.tlf10
#      LET g_tlf_excel[l_n].tlfc21 = sr.tlfc21
#      LET g_tlf_excel[l_n].wsaleamt = sr.wsaleamt
#      LET g_tlf_excel[l_n].l_wsale_tlf21 = l_wsale_tlf21
#      LET g_tlf_excel[l_n].l_rate = l_rate
#      LET g_tlf_excel[l_n].salerat = 1
#      LET g_tlf_excel[l_n].raterat = 1
#      LET g_tlf_excel[l_n].occ04 = l_occ04
#      LET g_tlf_excel[l_n].gen02 = l_gen02
#      LET g_tlf_excel[l_n].gem01 = l_gem01
#      LET g_tlf_excel[l_n].gem02 = l_gem02
#      LET g_tlf_excel[l_n].oma08 = l_oma08
#      LET g_tlf_excel[l_n].oab01 = warea
#      LET g_tlf_excel[l_n].occ03= l_occ03
#      LET g_tlf_excel[l_n].warea_name = warea_name
#      LET g_tlf_excel[l_n].ima131 = sr.ima131
#      LET g_tlf_excel[l_n].ima02 = sr.ima02
#      LET g_tlf_excel[l_n].tlf036 = sr.tlf036
#      LET g_tlf_excel[l_n].occ37 = l_occ37
#      LET g_tlfc[l_n].tlfc221a = sr.tlfc221
#      LET g_tlfc[l_n].tlfc222a = sr.tlfc222
#      LET g_tlfc[l_n].tlfc2231a = sr.tlfc2231
#      LET g_tlfc[l_n].tlfc2232a = sr.tlfc2232
#      LET g_tlfc[l_n].tlfc224a = sr.tlfc224
#      LET g_tlfc[l_n].tlfc2241a = sr.tlfc2241
#      LET g_tlfc[l_n].tlfc2242a = sr.tlfc2242
#      LET g_tlfc[l_n].tlfc2243a = sr.tlfc2243
#      INSERT INTO axcq761_tmp VALUES (g_tlf_excel[l_n].*,g_tlfc[l_n].*)
#
#        LET l_n = l_n + 1
#        IF sr.tlf13 LIKE 'axmt%' THEN        #出货
#           LET l_num1 = l_num1 + sr.tlf10    #销货数量
#           LET l_cost1 = l_cost1 + sr.tlfc21 #销货成本
#           LET l_wsaleamt = l_wsaleamt + sr.wsaleamt  #销货收入
#           IF l_azf08 = 'Y' THEN             #样品
#              LET l_num2 = l_num2 + sr.tlf10    #样品数量
#              LET l_cost2 = l_cost2 + sr.tlfc21 #样品销货成本
#           END IF
#        ELSE   #销退
#           LET l_num3 = l_num3 + sr.tlf10     #销退数量
#           LET l_cost3 = l_cost3 + sr.tlfc21  #销退金额
#           LET l_wsaleamt = l_wsaleamt + sr.wsaleamt  #销退收入
#        END IF
#
#        IF tm.c='Y' THEN
#           INSERT INTO ckl_file VALUES('312',sr.tlf905,sr.tlf906,sr.tlf01,sr.tlf10,sr.wsaleamt,g_ccz.ccz01,g_ccz.ccz02)
#        END IF
#     END FOREACH
-----------------------------------------------------
#FUN-D10022---------mark----------str----------------
#FUN-D10022----------------add-------------end-----------------------
#wujie 130904 --begin
#      LET l_sql = "SELECT tlf905,tlf906,tlf01,ima02,ima021,tlf19,occ02,NVL(SUM(tlf10*tlf60*tlf907),0),NVL(SUM(tlfc21*tlf907),0),",
#                  "        0 wsaleamt,0 l_wsale_tlf21,0 l_rate,1 salerat,1 raterat,occ04,'' gen02,'' gem01,'' gem02,",
#                  "        '' oma08,'' oab01,occ03,'' warea_name,ima131,tlf036,NVL(occ37,'N'),",
#                  "       NVL(SUM(tlfc221*tlf907),0),NVL(SUM(tlfc222*tlf907),0),NVL(SUM(tlfc2231*tlf907),0),NVL(SUM(tlfc2232*tlf907),0),",
#                  "       NVL(SUM(tlfc224*tlf907),0),NVL(SUM(tlfc2241*tlf907),0),NVL(SUM(tlfc2242*tlf907),0),NVL(SUM(tlfc2243*tlf907),0),tlf13,tlf66,NVL(azf08,'N'),' ' ogb01,0 ogb03 ",      #FUN-CC0157 add ogb01,ogb03
#                  "  FROM ",cl_get_target_table(m_plant[l_i],'ima_file'),",",cl_get_target_table(m_plant[l_i],'tlf_file'),
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'occ_file')," ON tlf19=occ01 ",
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'azf_file')," ON tlf14=azf01 AND azf02='2' ",
#                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'tlfc_file')," ON tlfc01 = tlf01 ",
#                  "   AND tlfc06 = tlf06  AND tlfc02 = tlf02  AND tlfc03 = tlf03 AND ",
#                  "  tlfc13 = tlf13  AND tlfc902= tlf902 AND tlfc903= tlf903 AND ",
#                  "  tlfc904= tlf904 AND tlfc907= tlf907 AND ",
#                  "  tlfc905= tlf905 AND tlfc906= tlf906 AND ",
#                  "  tlfctype = '",tm.type,"'",
#                  "  ,",cl_get_target_table(m_plant[l_i],'smy_file'),      #No.MOD-D30160
#                  " WHERE ima01 = tlf01",
#                  "   AND (tlf13 LIKE 'axmt%' OR tlf13 LIKE 'aomt%')",
#                  "   AND ",tm.wc CLIPPED,
#                  "   AND ",g_filter_wc CLIPPED,
#                  "   AND tlf902 not in (SELECT jce02 from ",cl_get_target_table(m_plant[l_i],'jce_file'),")",
#                  "   AND tlf920='Y' ",    #FUN-CC0157 add
#                  "   AND (tlf06 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
#                  "   AND tlf905 LIKE TRIM(smyslip)||'-%' AND smydmy1 ='Y' ",    #No.MOD-D30160
#                  " GROUP BY tlf01,ima02,ima021,ima131,occ02,occ03,occ04,occ37,tlf036,tlf13,tlf19,tlf66,tlf905,tlf906,azf08 ",
#                  "   ORDER BY tlf01,tlf905,tlf906 "


      LET l_sql = "SELECT tlf905,tlf906,tlf01,ima02,ima021,tlf19,occ02,NVL(SUM(tlf10*tlf60*tlf907),0),NVL(SUM(tlfc21*tlf907),0),",
                  "        0 wsaleamt,0 l_wsale_tlf21,0 l_rate,1 salerat,1 raterat,occ04,'' gen02,'' gem01,'' gem02,",
                  "        '' oma08,'' oab01,occ03,'' warea_name,ima131,tlf036,NVL(occ37,'N'),",
                  "       NVL(SUM(tlfc221*tlf907),0),NVL(SUM(tlfc222*tlf907),0),NVL(SUM(tlfc2231*tlf907),0),NVL(SUM(tlfc2232*tlf907),0),",
                  "       NVL(SUM(tlfc224*tlf907),0),NVL(SUM(tlfc2241*tlf907),0),NVL(SUM(tlfc2242*tlf907),0),NVL(SUM(tlfc2243*tlf907),0),tlf13,tlf66,NVL(azf08,'N'),' ' ogb01,0 ogb03,tlf907 ",      #FUN-CC0157 add ogb01,ogb03  #MOD-D90159 add tlf907
                  "  FROM ",cl_get_target_table(m_plant[l_i],'ima_file'),",",cl_get_target_table(m_plant[l_i],'tlf_file'),
                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'occ_file')," ON tlf19=occ01 ",
                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'azf_file')," ON tlf14=azf01 AND azf02='2' ",
                  "  LEFT OUTER JOIN ",cl_get_target_table(m_plant[l_i],'tlfc_file')," ON tlfc01 = tlf01 ",
                  "   AND tlfc06 = tlf06  AND tlfc02 = tlf02  AND tlfc03 = tlf03 AND ",
                  "  tlfc13 = tlf13  AND tlfc902= tlf902 AND tlfc903= tlf903 AND ",
                  "  tlfc904= tlf904 AND tlfc907= tlf907 AND ",
                  "  tlfc905= tlf905 AND tlfc906= tlf906 AND ",
                  "  tlfctype = '",tm.type,"'",
                  "  ,",cl_get_target_table(m_plant[l_i],'smy_file'),      #No.MOD-D30160
                  " WHERE ima01 = tlf01"
     SELECT * INTO g_oaz.* FROM oaz_file
      IF g_oaz.oaz92 <>'Y' THEN
         LET l_sql1 ="   AND (tlf13 LIKE 'axmt%' OR tlf13 LIKE 'aomt%')"
      ELSE
         LET l_sql1 ="   AND (tlf13 = 'axmt670' OR ((tlf13 LIKE 'axmt%' OR tlf13 LIKE 'aomt%') ))"
       #  LET l_sql1 ="   AND (tlf13 = 'axmt670' OR ((tlf13 LIKE 'axmt%' OR tlf13 LIKE 'aomt%') AND tlf99 IS NOT NULL))"     make by  quan
      END IF
      LET l_sql2 ="   AND ",tm.wc CLIPPED,
                  "   AND ",g_filter_wc CLIPPED,
                  "   AND tlf902 not in (SELECT jce02 from ",cl_get_target_table(m_plant[l_i],'jce_file'),")",
                 # "   AND tlf920='Y' ",    #FUN-CC0157 add
                  "   AND (tlf06 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "   AND tlf905 LIKE TRIM(smyslip)||'-%' AND smydmy1 ='Y' ",    #No.MOD-D30160
                  " GROUP BY tlf01,ima02,ima021,ima131,occ02,occ03,occ04,occ37,tlf036,tlf13,tlf19,tlf66,tlf905,tlf906,azf08,tlf907 ", #MOD-D90159 add tlf907
                  "   ORDER BY tlf01,tlf905,tlf906 "
      LET l_sql = l_sql,l_sql1,l_sql2
#wujie 130904 --end
      LET l_sql = " INSERT INTO axcq761_tmp ",
                  "    SELECT x.*,ROW_NUMBER() OVER (PARTITION BY tlf905,tlf906 ORDER BY tlf01,tlf905,tlf906) ",
                  "   FROM (",l_sql CLIPPED,") x "
      PREPARE axcq761_ins FROM l_sql
      EXECUTE axcq761_ins
      #**********************************
      LET g_sql_li = "SELECT tlf905,tlf906,tlf01,tlf13,tlf10,tlfc21,wsaleamt,ogb01 ogb03,tlf907 FROM axcq761_tmp WHERE tlf13 = 'axmt670' "
      PREPARE axcq761_li FROM g_sql_li
      DECLARE cur_li  CURSOR FOR axcq761_li

      LET g_li=1
      CALL g_tlf_li.clear()
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET g_pageno = 0
      LET l_num1 = 0
      LET l_num2 = 0
      LET l_num3 = 0
      LET l_cost1 = 0
      LET l_cost2 = 0
      LET l_cost3 = 0
      LET l_wsaleamt = 0

      LET l_sql = " DELETE FROM axcq761_tmp ",
                  "  WHERE tlf905 IN (SELECT oga01 FROM oga_file WHERE oga00 IN ('3','A','7') OR oga65 = 'Y')"
      PREPARE axcq761_del FROM l_sql
      EXECUTE axcq761_del

      LET l_byear=YEAR(tm.bdate)
      LET l_bmonth=MONTH(tm.bdate)
      LET l_bdate=(l_byear*12)+l_bmonth
      LET l_eyear=YEAR(tm.edate)
      LET l_emonth=MONTH(tm.edate)
      LET l_edate=(l_eyear*12)+l_emonth
      LET sr.wsaleamt = 0

      LET l_sql = "MERGE INTO axcq761_tmp o",
                  "  USING( SELECT DISTINCT oma08,omb31,omb32 ",
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND omaconf = 'Y' AND omavoid != 'Y') x ",
                  "  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.oma08 = x.oma08 ",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X')"
      PREPARE q761_oma0801 FROM l_sql
      EXECUTE q761_oma0801

      UPDATE axcq761_tmp SET ogb01 = tlf905,
                             ogb03 = tlf906

       LET g_li=1
       CALL g_tlf_li.clear()
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET l_sql = "MERGE INTO axcq761_tmp o",
                  " USING (SELECT omf00,omf21,omf11,omf12 ",
                  "           FROM ",cl_get_target_table(m_plant[l_i],'omf_file'),") x ",
                  "  ON (o.tlf905 = x.omf00 AND o.tlf905 = x.omf21) ",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.ogb01 = x.omf11,",
                  "          o.ogb03 = x.omf12 ",
                  "   WHERE tlf13 ='axmt670' "
      PREPARE q761_ogb FROM l_sql
      EXECUTE q761_ogb

      LET g_li=1
      CALL g_tlf_li.clear()
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET l_sql = "MERGE INTO axcq761_tmp o",
                 #"  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32 ",         #MOD-D90121 mark
                  "  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32,oma76 ",   #MOD-D90121 add
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND omaconf = 'Y' AND omavoid != 'Y' AND oma00 LIKE '1%' AND omb38 ='3' ) x ",
                 #"  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )",  #FUN-CC0157 mod                           #MOD-D90121 mark
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 AND (o.tlf905 = x.oma76 OR x.oma76 IS NULL))", #MOD-D90121 add  #No.160924 mark
                  "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )", #MOD-D90121 add  #No.160924 add
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 *(-1) ",
#                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 ",      #No.TQC-D90012
                  "                       -(SELECT NVL(SUM(oct12),0) FROM oct_file ",
                  "                             WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                                   AND oct16='3' AND oct00='0') ",
                  "                       + (SELECT NVL(SUM(oct15),0) FROM oct_file ",
                  "                               WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                               AND oct16 = '4' ",
                  "                               AND (oct09*12)+oct10 BETWEEN ",l_bdate," AND ",l_edate,
                  "                               AND oct00 = '0')",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X')  AND o.tlf10 >0 "
      PREPARE q761_wsaleamt01 FROM l_sql
      EXECUTE q761_wsaleamt01

      LET g_li=1
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET l_sql = "MERGE INTO axcq761_tmp o",
                 #"  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32 ",         #MOD-D90121 mark
                  "  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32,oma76 ",   #MOD-D90121 add
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND omaconf = 'Y' AND omavoid != 'Y' AND oma00 LIKE '1%' AND omb38 ='3' ) x ",
                 #"  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )",  #FUN-CC0157 mod                           #MOD-D90121 mark
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 AND (o.tlf905 = x.oma76 OR x.oma76 IS NULL))", #MOD-D90121 add  ##No.160924 mark
                  "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32)", #MOD-D90121 add #No.160924 add
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 *(-1) ",
                  "                       -(SELECT NVL(SUM(oct12),0) FROM oct_file ",
                  "                             WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                                   AND oct16='1' AND oct00='0') ",
                  "                       + (SELECT NVL(SUM(oct14),0) FROM oct_file ",
                  "                               WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                               AND oct16 = '2' ",
                  "                               AND (oct09*12)+oct10 BETWEEN ",l_bdate," AND ",l_edate,
                  "                               AND oct00 = '0')",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X') AND o.tlf10 <=0 "
      PREPARE q761_wsaleamt02 FROM l_sql
      EXECUTE q761_wsaleamt02

      LET g_li=1
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET l_sql = "MERGE INTO axcq761_tmp o",
                 #"  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32 ",         #MOD-D90121 mark
                  "  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32,oma76 ",   #MOD-D90121 add
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND omaconf = 'Y' AND omavoid != 'Y' AND (oma00 NOT LIKE '1%' OR omb38 <> '3') ) x ",
                 #"  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )",  #FUN-CC0157 mod                           #MOD-D90121 mark
                 # "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 AND (o.tlf905 = x.oma76 OR x.oma76 IS NULL))", #MOD-D90121 add #No.160924 mark
                  "  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )", #MOD-D90121 add #No.160924 add
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 ",
                  "                       -(SELECT NVL(SUM(oct12),0) FROM oct_file ",
                  "                             WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                                   AND oct16='3' AND oct00='0') ",
                  "                       + (SELECT NVL(SUM(oct15),0) FROM oct_file ",
                  "                               WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                               AND oct16 = '4' ",
                  "                               AND (oct09*12)+oct10 BETWEEN ",l_bdate," AND ",l_edate,
                  "                               AND oct00 = '0')",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X')  AND o.tlf10 >0 "
      PREPARE q761_wsaleamt03 FROM l_sql
      EXECUTE q761_wsaleamt03

      LET g_li=1
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      LET l_sql = "MERGE INTO axcq761_tmp o",
                 #"  USING( SELECT DISTINCT oma00,NVL(omb16,0) omb16,omb38,omb31,omb32 ",         #MOD-D90121 mark
                  "  USING( SELECT DISTINCT oma00,NVL(sum(omb16),0) omb16,omb38,omb31,omb32,oma76 ",   #MOD-D90121 add
                  "           FROM ",cl_get_target_table(m_plant[l_i],'oma_file'),",",
                                     cl_get_target_table(m_plant[l_i],'omb_file'),
                  "          WHERE oma01=omb01 AND (oma02 BETWEEN '",tm.bdate,"' AND '",tm.edate,"')",
                  "                AND rownum=1  AND omaconf = 'Y' AND omavoid != 'Y' AND (oma00 NOT LIKE '1%' OR omb38 <> '3') ",
                  "           GROUP BY oma00,omb38,omb31,omb32,oma76 ) x ",
                 #"  ON (o.tlf905=x.omb31 AND o.tlf906=x.omb32 )",
                 #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )",  #FUN-CC0157 mod                           #MOD-D90121 mark
                  #"  ON (o.tlf905 =x.omb31 AND o.tlf906 =x.omb32 AND (o.ogb01 = x.oma76 OR x.oma76 IS NULL))", #MOD-D90121 add  #No.160924 mark
                  #"  ON (o.ogb01 =x.omb31 AND o.ogb03 =x.omb32 )", #MOD-D90121 add  #No.160924 add
                  "  ON (o.tlf905 =x.omb31 AND o.tlf906 =x.omb32 )", #MOD-D90121 add  #No.160924 mark
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.wsaleamt = o.wsaleamt+ x.omb16 ",
                  "                       -(SELECT NVL(SUM(oct12),0) FROM oct_file ",
                  "                             WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                                   AND oct16='1' AND oct00='0') ",
                  "                       + (SELECT NVL(SUM(oct14),0) FROM oct_file ",
                  "                               WHERE oct04 = o.tlf905 AND oct05 = o.tlf906 ",
                  "                               AND oct16 = '2' ",
                  "                               AND (oct09*12)+oct10 BETWEEN ",l_bdate," AND ",l_edate,
                  "                               AND oct00 = '0')",
                  "    WHERE (o.rowno=1 OR o.tlf66 = 'X') AND o.tlf10 <=0 "
      PREPARE q761_wsaleamt04 FROM l_sql
      EXECUTE q761_wsaleamt04

      LET g_li=1
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      UPDATE axcq761_tmp SET wsaleamt=wsaleamt*-1 WHERE tlf907='1'  #MOD-D90159 add

      LET g_li=1
      FOREACH cur_li INTO g_tlf_li[g_li].*
          LET g_li = g_li+1
      END FOREACH
      #**********************************

      UPDATE axcq761_tmp SET tlf10 = tlf10 * -1,
                             tlfc21= tlfc21* -1

      LET l_sql = "UPDATE axcq761_tmp o",
                  "   SET o.oab01 = (SELECT oha25 FROM ",cl_get_target_table(m_plant[l_i],'oha_file'),
                  "                 WHERE oha01 = o.tlf905 )",
                  " WHERE o.tlf13[1,4] LIKE 'aomt' "
      PREPARE upd_oab0101 FROM l_sql
      EXECUTE upd_oab0101

      LET l_sql = "UPDATE axcq761_tmp o",
                   "   SET o.oab01 = (SELECT oga25 FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),
                   "                 WHERE oga01 = o.tlf905 AND oga00 NOT IN ('A','3','7') )",
                   " WHERE o.tlf13[1,4] NOT LIKE 'aomt' "
      PREPARE upd_oab0102 FROM l_sql
      EXECUTE upd_oab0102

      LET l_sql = "UPDATE axcq761_tmp o",
                   "   SET o.warea_name = (SELECT DISTINCT oab02 FROM ",cl_get_target_table(m_plant[l_i],'oab_file'),
                   "                        WHERE oab01 = o.oab01 AND rownum=1)"
      PREPARE upd_warea_name FROM l_sql
      EXECUTE upd_warea_name

      UPDATE axcq761_tmp SET l_wsale_tlf21 = wsaleamt - tlfc21

      LET l_sql = "UPDATE axcq761_tmp SET l_rate = l_wsale_tlf21/wsaleamt " ,
                  "WHERE wsaleamt <> 0"
      PREPARE upd_l_rate FROM l_sql
      EXECUTE upd_l_rate

      DELETE FROM axcq761_tmp WHERE tlf10 = 0 AND wsaleamt= 0 AND (tlfc21=0 OR tlfc21 IS NULL)

      IF tm.b = '1' THEN
         DELETE FROM axcq761_tmp WHERE occ37 ='N'
      END IF
      IF tm.b = '2' THEN   #非關係人
         DELETE FROM axcq761_tmp WHERE occ37 ='Y'
      END IF

      LET l_sql = "MERGE INTO axcq761_tmp o ",
                  "USING (SELECT oga08,omf00,omf21 FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),
                  "       ,",cl_get_target_table(m_plant[l_i],'omf_file'),
                  "       WHERE omf11 = oga01  AND oga00 NOT IN ('A','3','7') AND omf10 ='1') x ",
                  "   ON (o.tlf905 = x.omf00 AND o.tlf906 = x.omf21)",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.oma08 = x.oga08 ",
                  "    WHERE o.oma08 IS NULL AND o.tlf13 ='axmt670' "
      PREPARE upd_oma081 FROM l_sql
      EXECUTE upd_oma081

      LET l_sql = "MERGE INTO axcq761_tmp o ",
                  "USING (SELECT oha08,omf00,omf21 FROM ",cl_get_target_table(m_plant[l_i],'oha_file'),
                  "       ,",cl_get_target_table(m_plant[l_i],'omf_file'),
                  "       WHERE omf11 = oha01  AND omf10 ='2' ) x ",
                  "   ON (o.tlf905 = x.omf00 AND o.tlf906 = x.omf21)",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.oma08 = x.oha08 ",
                  "    WHERE trim(o.oma08) IS NULL AND o.tlf13 ='axmt670' "
      PREPARE upd_oma082 FROM l_sql
      EXECUTE upd_oma082

      LET l_sql = "MERGE INTO axcq761_tmp o ",
                  "USING (SELECT oha08,oha01 FROM ",cl_get_target_table(m_plant[l_i],'oha_file')," ) x ",
                  "   ON (o.tlf905 = x.oha01 )",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.oma08 = x.oha08 ",
                  "    WHERE o.oma08 IS NULL AND o.tlf13[1,4] LIKE 'aomt' "
      PREPARE upd_oma083 FROM l_sql
      EXECUTE upd_oma083

      LET l_sql = "MERGE INTO axcq761_tmp o ",
                  "USING (SELECT oga08,oga01 FROM ",cl_get_target_table(m_plant[l_i],'oga_file'),
                  "        WHERE oga00 NOT IN ('A','3','7')) x ",
                  "   ON (o.tlf905 = x.oga01 )",
                  " WHEN MATCHED ",
                  " THEN ",
                  "   UPDATE ",
                  "      SET o.oma08 = x.oga08 ",
                  "    WHERE o.oma08 IS NULL AND o.tlf13[1,4] NOT LIKE 'aomt' AND o.tlf13<>'axmt670' "
      PREPARE upd_oma084 FROM l_sql
      EXECUTE upd_oma084

      IF tm.a = '1' THEN
         DELETE FROM axcq761_tmp WHERE oma08 <>'1'
      END IF
      IF tm.a = '2' THEN
         DELETE FROM axcq761_tmp WHERE oma08 <>'2'
      END IF

      LET l_sql = " MERGE INTO axcq761_tmp o ",
                  " USING (SELECT DISTINCT gen01,gen02,gem01,gem02 FROM ",cl_get_target_table(m_plant[l_i],'gen_file'),",",cl_get_target_table(m_plant[l_i],'gem_file'),
                  "          WHERE gen03 = gem01) x ",
                  "    ON (o.occ04 = x.gen01) " ,
                  " WHEN MATCHED ",
                  " THEN ",
                  "    UPDATE ",
                  "       SET o.gen02 = x.gen02,",
                  "           o.gem01 = x.gem01,",
                  "           o.gem02 = x.gem02 "
      PREPARE upd_genm FROM l_sql
      EXECUTE upd_genm

      IF tm.c='Y' THEN
         #INSERT INTO ckl_file VALUES('312',sr.tlf905,sr.tlf906,sr.tlf01,sr.tlf10,sr.wsaleamt,g_ccz.ccz01,g_ccz.ccz02) #FUN-D10022 mark
         LET l_sql = "INSERT INTO ckl_file ",
                     "  SELECT '312',tlf905,tlf906,tlf01,tlf10,wsaleamt,",g_ccz.ccz01,",",g_ccz.ccz02,
                     "   FROM axcq761_tmp"
         PREPARE q761_ckl FROM l_sql
         EXECUTE q761_ckl
      END IF
#FUN-D10022----------------add-------------end-----------------------
   END FOR

   #写入ckk_file
   IF tm.c = 'Y' THEN
      #FUN-D10022--add--str--
      SELECT SUM(tlf10),SUM(tlfc21),SUM(wsaleamt)
        INTO l_num1,l_cost1,l_wsaleamt1
       FROM axcq761_tmp WHERE tlf13 LIKE 'axmt%'

      SELECT SUM(tlf10),SUM(tlfc21)
        INTO l_num2,l_cost2
       FROM axcq761_tmp WHERE tlf13 LIKE 'axmt%' AND azf08 ='Y'

      SELECT SUM(tlf10),SUM(tlfc21),SUM(wsaleamt)
        INTO l_num3,l_cost3,l_wsaleamt2
       FROM axcq761_tmp WHERE tlf13 NOT LIKE 'axmt%'

      LET l_wsaleamt = l_wsaleamt1 + l_wsaleamt2
      #FUN-D10022--add--end--

      #销货成本
      CALL s_ckk_fill('','310','axc-458',g_ccz.ccz01,g_ccz.ccz02,g_prog,tm.type,-1*l_num1,-1*l_cost1,-1*l_cost1,0,0,   #Modi by zm 120915
                      0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')
           RETURNING g_ckk.*
      IF NOT s_ckk(g_ckk.*,'') THEN END IF
      #销货成本-样品
      INITIALIZE g_ckk.* TO NULL
      CALL s_ckk_fill('','321','axc-459',g_ccz.ccz01,g_ccz.ccz02,g_prog,tm.type,-1*l_num2,-1*l_cost2,-1*l_cost2,0,0,   #Modi by zm 120915
                      0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')
           RETURNING g_ckk.*
      IF NOT s_ckk(g_ckk.*,'') THEN END IF
      #销退成本
      INITIALIZE g_ckk.* TO NULL
      CALL s_ckk_fill('','311','axc-460',g_ccz.ccz01,g_ccz.ccz02,g_prog,tm.type,-1*l_num3,-1*l_cost3,-1*l_cost3,0,0,   #Modi by zm 120915
                      0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')
           RETURNING g_ckk.*
      IF NOT s_ckk(g_ckk.*,'') THEN END IF
      #销货收入
      INITIALIZE g_ckk.* TO NULL
      CALL s_ckk_fill('','312','axc-461',g_ccz.ccz01,g_ccz.ccz02,g_prog,tm.type,l_num1+l_num3,l_wsaleamt,l_wsaleamt,0,0,0,0,0,0,0,l_msg,g_user,g_today,g_time,'Y')
           RETURNING g_ckk.*
      IF NOT s_ckk(g_ckk.*,'') THEN END IF
   END IF

   #CALL axcq761_b_fill()
   CALL axcq761_show()
   CALL s_log_upd(g_cka00,'Y')             #更新日誌

END FUNCTION

FUNCTION axcq761_table()
     DROP TABLE axcq761_tmp;
     CREATE TEMP TABLE axcq761_tmp(
                   tlf905        LIKE tlf_file.tlf905,       #出货单号   #主SQL捞出的tlf026,tlf027是tlf905,tlf906赋值的，故这里可以改成tlf905,tlf906
                   tlf906        LIKE tlf_file.tlf906,       #出货单项次
                   tlf01         LIKE tlf_file.tlf01,        #料号
                   ima02         LIKE ima_file.ima02,
                   ima021        LIKE ima_file.ima021,
                   tlf19         LIKE tlf_file.tlf19,
                   wocc02        LIKE occ_file.occ02,        #客户简称
                   tlf10         LIKE tlf_file.tlf10,        #异动数量
                   tlfc21        LIKE tlfc_file.tlfc21,      #成本  #No.FUN-7C0101 tlf21->tlfc21
                   wsaleamt      LIKE type_file.num20_6,     #销售收入 #FUN-A20044
                   l_wsale_tlf21 LIKE tlf_file.tlf21,        #毛利
                   l_rate        LIKE type_file.num20_6,     #毛利率
                   salerat       LIKE type_file.num20_6,
                   raterat       LIKE type_file.num20_6,
                   occ04         LIKE occ_file.occ04,
                   gen02         LIKE gen_file.gen02,        #业务员
                   gem01         LIKE gem_file.gem01,
                   gem02         LIKE gem_file.gem02,        #部门
                   oma08         LIKE oma_file.oma08,        #销售类型
                   oab01         LIKE oab_file.oab01,        #FUN-D10022 oab02->oab01
                   occ03         LIKE occ_file.occ03,
                   warea_name    LIKE oab_file.oab02,        #销售区域
                   ima131        LIKE ima_file.ima131,       #产品分类
                   tlf036        LIKE tlf_file.tlf036,       #订单单号
                   occ37         LIKE occ_file.occ37,        #关系人否
                   tlfc221a      LIKE tlfc_file.tlfc221,
                   tlfc222a      LIKE tlfc_file.tlfc222,
                   tlfc2231a     LIKE tlfc_file.tlfc2231,
                   tlfc224a      LIKE tlfc_file.tlfc224,
                   tlfc2241a     LIKE tlfc_file.tlfc2241,
                   tlfc2242a     LIKE tlfc_file.tlfc2242,
                   tlfc2243a     LIKE tlfc_file.tlfc2243,
                   tlfc2232a     LIKE tlfc_file.tlfc2232,
                   tlf13         LIKE tlf_file.tlf13,        #FUN-D10022 add
                   tlf66         LIKE tlf_file.tlf66,        #FUN-D10022 add
                   azf08         LIKE azf_file.azf08,        #FUN-D10022 add
                   ogb01         LIKE ogb_file.ogb01,        #FUN-CC0157 add
                   ogb03         LIKE ogb_file.ogb03,        #FUN-CC0157 add
                   tlf907        LIKE tlf_file.tlf907,       #MOD-D90159 add
                   rowno         LIKE type_file.num5);       #FUN-D10022 add

END FUNCTION

FUNCTION q761_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1


   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
   LET g_action_flag = 'page2'
   DISPLAY g_rec_b  TO FORMONLY.cn
   DISPLAY g_rec_b1 TO FORMONLY.cnt
   DISPLAY g_tot TO FORMONLY.tot
   DISPLAY g_sum1 TO FORMONLY.sum1
   DISPLAY g_sum2 TO FORMONLY.sum2
   DISPLAY g_sum3 TO FORMONLY.sum3
   DISPLAY g_rate TO FORMONLY.a_rate

   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel", FALSE)
   DIALOG ATTRIBUTES(UNBUFFERED)

      DISPLAY ARRAY g_tlfa TO s_tlfa.* ATTRIBUTE(COUNT=g_rec_b)
       #  BEFORE DISPLAY
       #     CALL cl_navigator_setting( g_curs_index, g_row_count )
       #     IF g_rec_b != 0 AND l_ac != 0 THEN
       #        CALL fgl_set_arr_curr(l_ac)
       #     END IF
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL cl_show_fld_cont()
      END DISPLAY

      DISPLAY ARRAY g_tlf TO s_tlf.* ATTRIBUTE(COUNT=g_rec_b)
      #  BEFORE DISPLAY
      #     CALL cl_navigator_setting( g_curs_index, g_row_count )
      #     IF g_rec_b != 0 AND l_ac != 0 THEN
      #        CALL fgl_set_arr_curr(l_ac)
      #     END IF
         BEFORE ROW
            LET l_ac = ARR_CURR()
            CALL cl_show_fld_cont()
      END DISPLAY


      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG

      ON ACTION output
         LET g_action_choice="output"
         EXIT DIALOG

      ON ACTION data_filter
         LET g_action_choice="data_filter"
         EXIT DIALOG

      ON ACTION revert_filter
         LET g_action_choice="revert_filter"
         EXIT DIALOG

      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG

      ON ACTION locale
         CALL cl_dynamic_locale()
         CALL cl_show_fld_cont()

      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DIALOG

      ON ACTION page2
         LET g_action_flag ="page2"

      ON ACTION page3
         LET g_action_flag ="page3"

      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG=FALSE
         LET g_action_choice="exit"
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about
         CALL cl_about()

      ON ACTION exporttoexcel
         LET g_action_choice = 'exporttoexcel'
         EXIT DIALOG

      ON ACTION related_document
         LET g_action_choice="related_document"
         EXIT DIALOG

      AFTER DIALOG
         CONTINUE DIALOG

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

   END DIALOG
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION axcq761_show()
   DISPLAY tm.type,tm.bdate,tm.edate,tm.cb1,tm.cb2,
           tm.cb3,tm.cb4,tm.a,tm.b,tm.c,tm.d
        TO type,bdate,edate,cb1,cb2,cb3,cb4,a,b,c,d
   LET g_tot = 0
   LET g_sum1 = 0
   LET g_sum2 = 0
   LET g_sum3 = 0

   SELECT SUM(tlf10),SUM(tlfc21),SUM(wsaleamt),SUM(l_wsale_tlf21)
     INTO g_tot,g_sum1,g_sum2,g_sum3                       #總數量,異動成本合計,銷售收入合計,毛利合計,
     FROM axcq761_tmp
   LET g_rate = g_sum3/g_sum2 * 100
   CALL axcq761_b_fill()
   CALL axcq761_b_fill_2()
   CALL cl_show_fld_cont()
END FUNCTION

FUNCTION axcq761_b_fill()
DEFINE l_str  STRING
DEFINE l_str1 STRING
DEFINE l_str2 STRING   #FUN-D10022 add
DEFINE l_cb  ARRAY[5] OF LIKE type_file.chr1
DEFINE i     LIKE type_file.num5

   LET l_cb[1] = tm.cb1
   LET l_cb[2] = tm.cb2
   LET l_cb[3] = tm.cb3
   LET l_cb[4] = tm.cb4
   #LET g_sql = "SELECT w1,'','',w2,w3,w4,w5,w6,'',w7,'',w8,'' "   #FUN-D10022
   LET g_sql = "SELECT w1,wi,wb,w2,w3,w4,w5,w6,wc,w7,wd,w8,we "    #FUN-D10022 add
   FOR i=1 TO 4
      IF NOT cl_null(l_cb[i]) THEN
         IF i=1 THEN
            LET l_str = " GROUP BY "
            LET l_str1= " ORDER BY "
         ELSE
            LET l_str = l_str CLIPPED,","
            LET l_str1= l_str1 CLIPPED,","
         END IF
         CASE l_cb[i]
            #FUN-D10022--mark--str--
            #WHEN '1' LET l_str = l_str," tlf01"
            #         LET l_str1= l_str1," tlf01"
            #         LET g_sql = cl_replace_str(g_sql,'w1','tlf01')
            #WHEN '2' LET l_str = l_str," tlf19"
            #         LET l_str1= l_str1," tlf19"
            #         LET g_sql = cl_replace_str(g_sql,'w8','tlf19')
            #WHEN '3' LET l_str = l_str," occ04"
            #         LET l_str1= l_str1," occ04"
            #         LET g_sql = cl_replace_str(g_sql,'w7','occ04')
            #WHEN '4' LET l_str = l_str," gem01"
            #         LET l_str1= l_str1," gem01"
            #         LET g_sql = cl_replace_str(g_sql,'w6','gem01')
            #WHEN '5' LET l_str = l_str," warea_name"
            #         LET l_str1= l_str1," warea_name"
            #         LET g_sql = cl_replace_str(g_sql,'w5','warea_name')
            #WHEN '6' LET l_str = l_str," ima131"
            #         LET l_str1= l_str1," ima131"
            #         LET g_sql = cl_replace_str(g_sql,'w4','ima131')
            #WHEN '7' LET l_str = l_str," occ03"
            #         LET l_str1= l_str1," occ03"
            #         LET g_sql = cl_replace_str(g_sql,'w3','occ03')
            #WHEN '8' LET l_str = l_str," oma08"
            #         LET l_str1= l_str1," oma08"
            #         LET g_sql = cl_replace_str(g_sql,'w2','oma08')
            #FUN-D10022--mark--end--
            #FUN-D10022--add--str--
            WHEN '1' LET l_str = l_str," tlf01,a.ima02,a.ima021"
                     LET l_str1= l_str1," tlf01"
                     LET l_str2= l_str2," LEFT OUTER JOIN ima_file a ON a.ima01 = x.tlf01 "
                     LET g_sql = cl_replace_str(g_sql,'w1','tlf01')
                     LET g_sql = cl_replace_str(g_sql,'wi','a.ima02')
                     LET g_sql = cl_replace_str(g_sql,'wb','a.ima021')
            WHEN '2' LET l_str = l_str," tlf19,d.occ02"
                     LET l_str1= l_str1," tlf19"
                     LET l_str2= l_str2," LEFT OUTER JOIN occ_file d ON d.occ01 = x.tlf19 "
                     LET g_sql = cl_replace_str(g_sql,'w8','tlf19')
                     LET g_sql = cl_replace_str(g_sql,'we','d.occ02')
            WHEN '3' LET l_str = l_str," x.occ04,c.gen02"
                     LET l_str1= l_str1," x.occ04"
                     LET l_str2= l_str2,"  LEFT OUTER JOIN gen_file c ON c.gen01 = x.occ04 "
                     LET g_sql = cl_replace_str(g_sql,'w7','x.occ04')
                     LET g_sql = cl_replace_str(g_sql,'wd','c.gen02')
            WHEN '4' LET l_str = l_str," x.gem01,b.gem02"
                     LET l_str1= l_str1," x.gem01"
                     LET l_str2= l_str2,"  LEFT OUTER JOIN gem_file b ON b.gem01 = x.gem01 "
                     LET g_sql = cl_replace_str(g_sql,'w6','x.gem01')
                     LET g_sql = cl_replace_str(g_sql,'wc','b.gem02')
            WHEN '5' LET l_str = l_str," warea_name"
                     LET l_str1= l_str1," warea_name"
                     LET g_sql = cl_replace_str(g_sql,'w5','warea_name')
            WHEN '6' LET l_str = l_str," x.ima131"
                     LET l_str1= l_str1," x.ima131"
                     LET g_sql = cl_replace_str(g_sql,'w4','x.ima131')
            WHEN '7' LET l_str = l_str," x.occ03"
                     LET l_str1= l_str1," x.occ03"
                     LET g_sql = cl_replace_str(g_sql,'w3','x.occ03')
            WHEN '8' LET l_str = l_str," oma08"
                     LET l_str1= l_str1," oma08"
                     LET g_sql = cl_replace_str(g_sql,'w2','oma08')
            #FUN-D10022--add--end--
         END CASE
      END IF
   END FOR
   LET g_sql = cl_replace_str(g_sql,"w1","''")
   LET g_sql = cl_replace_str(g_sql,"w2","''")
   LET g_sql = cl_replace_str(g_sql,"w3","''")
   LET g_sql = cl_replace_str(g_sql,"w4","''")
   LET g_sql = cl_replace_str(g_sql,"w5","''")
   LET g_sql = cl_replace_str(g_sql,"w6","''")
   LET g_sql = cl_replace_str(g_sql,"w7","''")
   LET g_sql = cl_replace_str(g_sql,"w8","''")
   #FUN-D10022--add--str--
   LET g_sql = cl_replace_str(g_sql,"wi","''")
   LET g_sql = cl_replace_str(g_sql,"wb","''")
   LET g_sql = cl_replace_str(g_sql,"wc","''")
   LET g_sql = cl_replace_str(g_sql,"wd","''")
   LET g_sql = cl_replace_str(g_sql,"we","''")
   #FUN-D10022--add--end--

   CALL g_tlfa.clear()
   LET g_cnt =1
   #FUN-D10022--mark--str--
   #LET g_sql = g_sql CLIPPED,",SUM(tlf10),SUM(tlfc21),",
   #            "       SUM(wsaleamt),'',SUM(tlfc221a),SUM(tlfc222a),SUM(tlfc2231a),SUM(tlfc224a),SUM(tlfc2241a),",
   #            "       SUM(tlfc2242a),SUM(tlfc2243a),SUM(tlfc2232a),SUM(l_wsale_tlf21),'',''",
   #            "  FROM axcq761_tmp ",l_str,l_str1
   #FUN-D10022--mark--end--
   #FUN-D10022--add--str--
   LET g_sql = g_sql CLIPPED,",NVL(SUM(tlf10),0),NVL(SUM(tlfc21),0),",
               "       NVL(SUM(wsaleamt),0),'',NVL(SUM(tlfc221a),0),NVL(SUM(tlfc222a),0),",
               "       NVL(SUM(tlfc2231a),0),NVL(SUM(tlfc224a),0),NVL(SUM(tlfc2241a),0),",
               "       NVL(SUM(tlfc2242a),0),NVL(SUM(tlfc2243a),0),NVL(SUM(tlfc2232a),0),",
               "       NVL(SUM(l_wsale_tlf21),0),'',''",
               "  FROM axcq761_tmp x ",l_str2,l_str,l_str1
   #FUN-D10022--add--end--
   PREPARE axcq761_pb1 FROM g_sql
   DECLARE tlfa_curs  CURSOR FOR axcq761_pb1
   FOREACH tlfa_curs INTO g_tlfa[g_cnt].*
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      #FUN-D10022--mark--str--
      #SELECT ima02,ima021 INTO g_tlfa[g_cnt].ima02a,g_tlfa[g_cnt].ima021a
      #  FROM ima_file
      # WHERE ima01= g_tlfa[g_cnt].tlf01a
      #SELECT gem02 INTO g_tlfa[g_cnt].gem02a
      #  FROM gem_file
      # WHERE gem01 = g_tlfa[g_cnt].gem01a
      #SELECT gen02 INTO g_tlfa[g_cnt].gen02a
      #  FROM gen_file
      # WHERE gen01 = g_tlfa[g_cnt].occ04a
      #SELECT occ02 INTO g_tlfa[g_cnt].occ02a
      #  FROM occ_file
      # WHERE occ01 = g_tlfa[g_cnt].tlf19a
      #FUN-D10022--mark--end--
      LET g_tlfa[g_cnt].salerata = g_tlfa[g_cnt].saleamta / g_sum2
      LET g_tlfa[g_cnt].salerata = cl_digcut(g_tlfa[g_cnt].salerata,5)
      LET g_tlfa[g_cnt].salerata = g_tlfa[g_cnt].salerata * 100
      LET g_tlfa[g_cnt].raterata = g_tlfa[g_cnt].wsale_tlf21a / g_sum3
      LET g_tlfa[g_cnt].raterata = cl_digcut(g_tlfa[g_cnt].raterata,5)
      LET g_tlfa[g_cnt].raterata = g_tlfa[g_cnt].raterata *100
      LET g_tlfa[g_cnt].ratea = g_tlfa[g_cnt].wsale_tlf21a/g_tlfa[g_cnt].saleamta
      LET g_tlfa[g_cnt].ratea = cl_digcut(g_tlfa[g_cnt].ratea,5)
      LET g_tlfa[g_cnt].ratea = g_tlfa[g_cnt].ratea * 100

      LET g_cnt = g_cnt + 1
   END FOREACH
   CALL g_tlfa.deleteElement(g_cnt)
   CALL cl_show_fld_cont()
   LET g_cnt=g_cnt-1
   LET g_rec_b1 = g_cnt
END FUNCTION

FUNCTION axcq761_b_fill_2()
#FUN-D10022--add--str--
DEFINE l_tlf13         LIKE tlf_file.tlf13,
       l_tlf66         LIKE tlf_file.tlf66,
       l_azf08         LIKE azf_file.azf08,
       l_rowno         LIKE type_file.num5,
#FUN-D10022--add--end--
       l_ogb01         LIKE ogb_file.ogb01, #FUN-CC0157
       l_ogb03         LIKE ogb_file.ogb03  #FUN-CC0157
DEFINE l_tlf907        LIKE tlf_file.tlf907 #MOD-D90159 add
   #LET g_sql = "SELECT DISTINCT * ", #FUN-C80092 mark 121225
   LET g_sql = "SELECT * ",           #FUN-C80092 add  121225
               #"  FROM axcq761_tmp ORDER BY tlf026 "  #FUN-D10022
               "  FROM axcq761_tmp ORDER BY tlf905 "   #FUN-D10022

   PREPARE axcq761_pb FROM g_sql
   DECLARE tlf_curs  CURSOR FOR axcq761_pb

   CALL g_tlf.clear()
   CALL g_tlfc.clear()
   CALL g_tlf_excel.clear()
   LET g_cnt = 1
   LET g_rec_b = 0

   FOREACH tlf_curs INTO g_tlf_excel[g_cnt].*,g_tlfc[g_cnt].*,l_tlf13,l_tlf66,l_azf08,l_ogb01,l_ogb03,l_tlf907,l_rowno  #FUN-D10022 add l_tlf13,l_tlf66,l_azf08,l_rowno #FUN-CC0157 add ogb01,ogb03  ##MOD-D90159 add l_tlf907
      IF SQLCA.sqlcode THEN
         CALL cl_err('foreach:',SQLCA.sqlcode,1)
         EXIT FOREACH
      END IF
      LET g_tlf_excel[g_cnt].l_rate = cl_digcut(g_tlf_excel[g_cnt].l_rate,5)
      LET g_tlf_excel[g_cnt].l_rate = g_tlf_excel[g_cnt].l_rate * 100
      LET g_tlf_excel[g_cnt].salerat = g_tlf_excel[g_cnt].wsaleamt / g_sum2
      LET g_tlf_excel[g_cnt].salerat =cl_digcut(g_tlf_excel[g_cnt].salerat,5)
      LET g_tlf_excel[g_cnt].salerat = g_tlf_excel[g_cnt].salerat *100
      LET g_tlf_excel[g_cnt].raterat = g_tlf_excel[g_cnt].l_wsale_tlf21 / g_sum3
      LET g_tlf_excel[g_cnt].raterat = cl_digcut(g_tlf_excel[g_cnt].raterat,5)
      LET g_tlf_excel[g_cnt].raterat = g_tlf_excel[g_cnt].raterat * 100
      IF g_cnt <= g_max_rec THEN
         LET g_tlf[g_cnt].* =  g_tlf_excel[g_cnt].*
      END IF
      LET g_cnt = g_cnt + 1
   END FOREACH

   IF g_cnt <= g_max_rec THEN
      CALL g_tlf.deleteElement(g_cnt)
   END IF
   CALL g_tlf_excel.deleteElement(g_cnt)
   #FUN-C80092--add--end--
   CALL cl_show_fld_cont()
   LET g_cnt=g_cnt-1
   LET g_rec_b = g_cnt
   #FUN-C80092--add--str--
   IF g_rec_b > g_max_rec AND (g_bgjob='N' OR g_bgjob is null) THEN
      CALL cl_err_msg(NULL,"axc-131",g_rec_b||"|"||g_max_rec,10)
      LET g_rec_b = g_max_rec
   END IF
   #FUN-C80092--add--end--

END FUNCTION

FUNCTION q761_set_no_entry()
   IF NOT cl_null(tm.bdate) AND NOT cl_null(tm.edate) THEN
      IF tm.bdate <> g_bdate OR tm.edate <> g_edate THEN
         LET tm.c = 'N'
         CALL cl_set_comp_entry("c",FALSE)
      END IF
   END IF
END FUNCTION

FUNCTION q761_set_entry_1()
    CALL cl_set_comp_entry("p1,p2,p3,p4,p5,p6,p7,p8",FALSE)
    CALL cl_set_comp_visible("group07",FALSE)
    CALL cl_set_comp_entry("c",TRUE)
    CALL cl_set_comp_entry('bdate,edate,type',TRUE)
END FUNCTION
FUNCTION q761_set_no_entry_1()

    #FUN-C80092--add--by--free--
    IF NOT cl_null(g_argv8) AND NOT cl_null(g_argv9) AND NOT cl_null(g_argv13) THEN
       CALL s_azn01(g_argv8,g_argv9) RETURNING tm.bdate,tm.edate
       LET tm.type  = g_argv13
       DISPLAY BY NAME tm.*
       CALL cl_set_comp_entry('bdate,edate,type',FALSE)
   END IF
   #FUN-C80092--add--by--free--
    IF tm.bdate <> g_bdate OR tm.edate <> g_edate THEN
       CALL cl_set_comp_entry("g_auto_gen",FALSE)
       LET tm.c = 'N'
       DISPLAY BY NAME tm.c
    END IF
END FUNCTION


FUNCTION q761_set_entry()
DEFINE l_cnt    LIKE type_file.num5
DEFINE l_azw05  LIKE azw_file.azw05

  SELECT azw05 INTO l_azw05 FROM azw_file WHERE azw01 = g_plant
  SELECT count(*) INTO l_cnt FROM azw_file
   WHERE azw05 = l_azw05

  IF l_cnt > 1 THEN
     CALL cl_set_comp_visible("group07",FALSE)
  END IF
  RETURN l_cnt
END FUNCTION
FUNCTION q761_set_visible()
   IF tm.d = 'Y' THEN
      CALL cl_set_comp_visible("tlfc221a,tlfc222a,tlfc2231a,tlfc224a,
                                tlfc2241a,tlfc2242a,tlfc2243a,tlfc2232a",TRUE)
   ELSE
      CALL cl_set_comp_visible("tlfc221a,tlfc222a,tlfc2231a,tlfc224a,
                                tlfc2241a,tlfc2242a,tlfc2243a,tlfc2232a",FALSE)
   END IF
END FUNCTION
FUNCTION q761_set_cb_visible()
DEFINE l_cb  ARRAY[5] OF LIKE type_file.chr1
DEFINE i     LIKE type_file.num5

   LET l_cb[1] = tm.cb1
   LET l_cb[2] = tm.cb2
   LET l_cb[3] = tm.cb3
   LET l_cb[4] = tm.cb4
   CALL cl_set_comp_visible("tlf01a,ima02a,ima021a,oma08a,occ03a,ima131a,
                            area_namea,gem01a,gem02a,occ04a,gen02a,tlf19a,occ02a",FALSE)
   FOR i=1 TO 4
      CASE l_cb[i]
         WHEN '1' CALL cl_set_comp_visible("tlf01a,ima02a,ima021a",TRUE)
         WHEN '2' CALL cl_set_comp_visible("tlf19a,occ02a",TRUE)
         WHEN '3' CALL cl_set_comp_visible("occ04a,gen02a",TRUE)
         WHEN '4' CALL cl_set_comp_visible("gem01a,gem02a",TRUE)
         WHEN '5' CALL cl_set_comp_visible("area_namea",TRUE)
         WHEN '6' CALL cl_set_comp_visible("ima131a",TRUE)
         WHEN '7' CALL cl_set_comp_visible("occ03a",TRUE)
         WHEN '8' CALL cl_set_comp_visible("oma08a",TRUE)
      END CASE
   END FOR
END FUNCTION

FUNCTION q761_chklegal(l_legal,n)
DEFINE l_legal  LIKE azw_file.azw02
DEFINE l_idx,n  LIKE type_file.num5

   FOR l_idx = 1 TO n
       IF m_legal[l_idx]! = l_legal THEN
          LET g_errno = 'axc-600'
          RETURN 0
       END IF
   END FOR
   RETURN 1
END FUNCTION









