# Prog. Version..: '5.30.06-13.04.22(00010)'     #
#
# Pattern name...: cpmp300.4gl
# Descriptions...: 包装单维护作業
# Date & Author..: 00/12/20 BY lanhang

DATABASE ds
 
GLOBALS "../../../tiptop/config/top.global"

DEFINE
         g_argv1   LIKE   oea_file.oea01,  #TQC-730022
         g_argv2   LIKE   smy_file.smyslip,  #TQC-730022
         g_argv3   LIKE   type_file.chr1,    #TQC-730022
         g_ima     RECORD LIKE ima_file.*,
         g_oea     RECORD LIKE oea_file.*,
         g_sfb     RECORD LIKE sfb_file.*,
         g_flag    LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(1)
         sfc_sw    LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(1),
         lot       LIKE type_file.num10,   #No.FUN-680121 INTEGER, 
#        lota      LIKE ima_file.ima26,    #No.FUN-680121 DEC(15,3), 
         lota      LIKE type_file.num15_3, ###GP5.2  #NO.FUN-A20044 
         l_mod     LIKE type_file.num10,   #No.FUN-680121 INTEGER, 
         g_cmd,g_sql,g_sql_smy  STRING,  #No.FUN-580092 HCN
         g_t1      LIKE smy_file.smyslip,                     #No.FUN-550067        #No.FUN-680121 VARCHAR(05)
         g_sw      LIKE type_file.chr1,    #No.FUN-680121 VARCHAR(01),
         mm_sfb08  LIKE sfb_file.sfb08,
         l_ima60   LIKE ima_file.ima60,
         l_ima601  LIKE ima_file.ima601,   #No.FUN-840194 
         l_oeb05   LIKE oeb_file.oeb05,
         l_ima55   LIKE ima_file.ima55,
         l_ima562  LIKE ima_file.ima562,
 
         g_oeb_l DYNAMIC ARRAY OF RECORD
                oeb01         LIKE oeb_file.oeb01,    #No.FUN-810014
                oeb03         LIKE oeb_file.oeb03,
                oeb04         LIKE ima_file.ima01,    #No.MOD-490217
                ima02         LIKE ima_file.ima02,
                ima021        LIKE ima_file.ima021,   #No.FUN-940103
                oeb912        LIKE oeb_file.oeb912,
                oebud07       LIKE oeb_file.oebud07
                 END RECORD,
         g_tc_oec DYNAMIC ARRAY OF RECORD
                tc_oec03      LIKE tc_oec_file.tc_oec03,
                ima02_1       LIKE ima_file.ima02,
                ima021_1      LIKE ima_file.ima021,
                tc_oec04      LIKE tc_oec_file.tc_oec04,
                ecd02         LIKE ecd_file.ecd02,
                tc_oec05      LIKE tc_oec_file.tc_oec05,
                tc_oec06      LIKE tc_oec_file.tc_oec06,
                tc_oec07      LIKE tc_oec_file.tc_oec07,
                tc_oec08      LIKE tc_oec_file.tc_oec08,
                tc_oec09      LIKE tc_oec_file.tc_oec09,
                tc_oec10      LIKE tc_oec_file.tc_oec10
                  END RECORD,
         g_tc_oec_t  RECORD
                tc_oec03      LIKE tc_oec_file.tc_oec03,
                ima02_1       LIKE ima_file.ima02,
                ima021_1      LIKE ima_file.ima021,
                tc_oec04      LIKE tc_oec_file.tc_oec04,
                ecd02         LIKE ecd_file.ecd02,
                tc_oec05      LIKE tc_oec_file.tc_oec05,
                tc_oec06      LIKE tc_oec_file.tc_oec06,
                tc_oec07      LIKE tc_oec_file.tc_oec07,
                tc_oec08      LIKE tc_oec_file.tc_oec08,
                tc_oec09      LIKE tc_oec_file.tc_oec09,
                tc_oec10      LIKE tc_oec_file.tc_oec10
                    END RECORD,
         g_tc_oed DYNAMIC ARRAY OF RECORD
                tc_oed05      LIKE tc_oed_file.tc_oed05,
                tc_oed06      LIKE tc_oed_file.tc_oed06,
                sfb13         LIKE sfb_file.sfb13, #add by wy20150312
                pmc03         LIKE pmc_file.pmc03, #add by wy20150313
                sfb08         LIKE sfb_file.sfb08,
                tc_oed07      LIKE tc_oed_file.tc_oed07,
                tc_oed08      LIKE tc_oed_file.tc_oed08,
                tc_oed04      LIKE tc_oed_file.tc_oed04,
                ecd02_2       LIKE ecd_file.ecd02,
                tc_oed09      LIKE tc_oed_file.tc_oed09,
                tc_oed10      LIKE tc_oed_file.tc_oed10,
                tc_oed11      LIKE tc_oed_file.tc_oed11
                  END RECORD,
         g_tc_oed_t RECORD
                tc_oed05      LIKE tc_oed_file.tc_oed05,
                tc_oed06      LIKE tc_oed_file.tc_oed06,
                sfb13         LIKE sfb_file.sfb13, #add by wy20150312
                pmc03         LIKE pmc_file.pmc03, #add by wy20150313
                sfb08         LIKE sfb_file.sfb08,
                tc_oed07      LIKE tc_oed_file.tc_oed07,
                tc_oed08      LIKE tc_oed_file.tc_oed08,
                tc_oed04      LIKE tc_oed_file.tc_oed04,
                ecd02_2       LIKE ecd_file.ecd02,
                tc_oed09      LIKE tc_oed_file.tc_oed09,
                tc_oed10      LIKE tc_oed_file.tc_oed10,
                tc_oed11      LIKE tc_oed_file.tc_oed11
                    END RECORD,
         g_pml    DYNAMIC ARRAY OF RECORD
                x             LIKE type_file.chr1,
                pml42         LIKE pml_file.pml42,
                pml24         LIKE pml_file.pml24,
                sfa08         LIKE sfa_file.sfa08,
                pml04         LIKE pml_file.pml04,
                pml041        LIKE pml_file.pml041,
                pmlud02       LIKE pml_file.pmlud02,
                pml06         LIKE pml_file.pml06,
                pml08         LIKE pml_file.pml08,
                pml07         LIKE pml_file.pml07,
                pml09         LIKE pml_file.pml09,
                pml20         LIKE pml_file.pml20,
                pml35         LIKE pml_file.pml35
                  END RECORD,
         tm     RECORD
                oeb01         LIKE oeb_file.oeb01,
                oeb03         LIKE oeb_file.oeb03,
                oeb04         LIKE ima_file.ima01,
                ima02         LIKE ima_file.ima02,
                ima021        LIKE ima_file.ima021,
                oeb912        LIKE oeb_file.oeb912,
                oebud07       LIKE oeb_file.oebud07,
                sfb01         LIKE type_file.chr1000
                END RECORD
DEFINE   g_rec_b     LIKE type_file.num10
DEFINE   g_rec_b1    LIKE type_file.num10
DEFINE   g_rec_b2    LIKE type_file.num10
DEFINE   g_rec_b3    LIKE type_file.num10
DEFINE   l_ac,l_ac1,l_ac2,l_ac3 LIKE type_file.num5
DEFINE   g_bp_flag   LIKE type_file.chr10
DEFINE   g_b_flag    LIKE type_file.chr10
DEFINE   g_forupd_sql STRING
DEFINE   l_slip      LIKE pmk_file.pmk01   #00-12-26 
DEFINE   l_max_no    LIKE pmk_file.pmk01         #No.MOD-960317 add
DEFINE   l_min_no    LIKE pmk_file.pmk01         #No.MOD-960317 add
DEFINE   g_chr       LIKE type_file.chr1     #No.FUN-680121 VARCHAR(1)
DEFINE   g_cnt       LIKE type_file.num10    #No.FUN-680121 INTEGER
DEFINE   g_i         LIKE type_file.num5     #count/index for any purpose  #No.FUN-680121 SMALLINT
DEFINE   g_msg       LIKE type_file.chr1000  #No.FUN-680121 VARCHAR(72)
DEFINE   g_wc        STRING                  #FUN-920088
DEFINE   l_barcode_yn    LIKE ima_file.ima930    #DEV-D30026 add      #條碼使用否 
DEFINE   g_row_count     LIKE type_file.num10    #No.FUN-680096 INTEGER
DEFINE   g_curs_index    LIKE type_file.num10
DEFINE   p_row,p_col,i   LIKE type_file.num5    #No.FUN-680121 SMALLINT
DEFINE   l_pmk  RECORD LIKE pmk_file.*
DEFINE   l_pml  RECORD LIKE pml_file.*

MAIN
   OPTIONS
       INPUT NO WRAP
   DEFER INTERRUPT                              # Supress DEL key function
 
   LET g_argv1  = ARG_VAL(1)
   LET g_argv2  = ARG_VAL(2)
   LET g_argv3  = ARG_VAL(3)
   IF cl_null(g_argv3) THEN
     LET g_argv3 = 'N'
   END IF
   LET g_bgjob  = ARG_VAL(4)
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = "N"
   END IF
   IF (NOT cl_user()) THEN
      EXIT PROGRAM
   END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
   IF (NOT cl_setup("CPM")) THEN
      EXIT PROGRAM
   END IF
 
   CALL cl_used(g_prog,g_time,1) RETURNING g_time   #No:MOD-A70028 add
   
   LET p_row = 2 
   LET p_col = 4 
 
   OPEN WINDOW p300_w AT p_row,p_col
       WITH FORM "cpm/42f/cpmp300"  ATTRIBUTE (STYLE = g_win_style CLIPPED) #No.FUN-580092 HCN
    
   CALL cl_ui_init()

   CALL cl_opmsg('z')

   MESSAGE ''
   CLEAR FORM 
   INITIALIZE g_oea.* TO NULL
   INITIALIZE tm.*    TO NULL
   CALL g_oeb_l.clear()
   CALL g_tc_oec.clear()
   CALL g_tc_oed.clear()
   LET g_action_choice = ''
   CALL p300_menu()
   --IF g_bgjob = 'N' THEN
      --CALL p300_tm()
   --ELSE
      --LET g_oea.oea01 = g_argv1 CLIPPED
      --LET g_sfb.sfb81 = TODAY
      --CALL p300_fill_b_data(g_grup)
      --LET g_success='Y'
      --CALL cpmp300()
      --
      --IF g_success='Y' THEN
         --MESSAGE "Success!"
      --END IF
   --END IF
   CLOSE WINDOW p300_w
   CALL cl_used(g_prog,g_time,2) RETURNING g_time   #No:MOD-A70028 add
END MAIN

FUNCTION p300_menu()
DEFINE l_cmd   STRING

   WHILE TRUE
      IF cl_null(g_bp_flag) OR g_bp_flag <> 'info_list' THEN
         CALL p300_bp()
      ELSE
         CALL p300_bp1()
      END IF
      CASE g_action_choice
         WHEN "query"
            IF cl_chk_act_auth() THEN
               LET g_wc=''
               CALL p300_tm()     #FUN-CB0078 add
            END IF
         WHEN "to_po"
            IF cl_chk_act_auth() THEN
               IF g_tc_oec.getLength()>0 AND g_tc_oed.getLength()>0 THEN
                  CALL p300_po()     #FUN-CB0078 add
               END IF
            END IF

         WHEN "po"
            IF cl_chk_act_auth() THEN
               LET l_ac2=ARR_CURR()
               IF NOT cl_null(g_tc_oed[l_ac2].tc_oed11) THEN
                  LET l_cmd=" apmt420 '",g_tc_oed[l_ac2].tc_oed11,"'"
                  CALL cl_cmdrun(l_cmd)
               END IF
            END IF

         WHEN "asfi301"
            IF cl_chk_act_auth() THEN
               LET l_ac2=ARR_CURR()
               IF NOT cl_null(g_tc_oed[l_ac2].tc_oed06) THEN
                  LET l_cmd=" asfi301 '",g_tc_oed[l_ac2].tc_oed06,"'"
                  CALL cl_cmdrun(l_cmd)
               END IF
            END IF
         WHEN "detail"
            IF cl_chk_act_auth() THEN
               CASE g_b_flag
                  WHEN '1'
                     CALL p300_b1()     #FUN-CB0078 add
                  WHEN '2'   
                     CALL p300_b2()
                  OTHERWISE
                     CALL p300_b1()
               END CASE
            END IF
         WHEN "exit"
            EXIT WHILE
      END CASE
   END WHILE
END FUNCTION

FUNCTION p300_tm()
#  DEFINE   mm_qty,mm_qty1   LIKE ima_file.ima26    #No.FUN-680121 DEC(15,3)
   DEFINE   mm_qty,mm_qty1   LIKE type_file.num15_3 ###GP5.2  #NO.FUN-A20044
   DEFINE   l_cnt,s_date     LIKE type_file.num5    #No.FUN-680121 SMALLINT  
   DEFINE   l_time           LIKE ima_file.ima58    #No.FUN-680121 DEC(15,3)
   DEFINE   l_sfb08          LIKE sfb_file.sfb08
   DEFINE   l_flag           LIKE type_file.chr1                  #No.FUN-680121 VARCHAR(1)
   DEFINE   l_cn             LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE   l_ima55_fac      LIKE ima_file.ima55_fac
   DEFINE   l_check          LIKE type_file.num5    #No.FUN-680121 SMALLINT
   DEFINE   l_ima59          LIKE ima_file.ima59
   DEFINE   l_ima61          LIKE ima_file.ima61
   DEFINE   l_oea00          LIKE oea_file.oea00    #No.MOD-940349 add
   DEFINE   l_costcenter     LIKE gem_file.gem01   #FUN-670103
   DEFINE   l_gem02c         LIKE gem_file.gem02   #FUN-670103
   IF s_shut(0) THEN
      RETURN
   END IF
   CLEAR FORM
   CALL g_tc_oec.clear()
   CALL g_tc_oec.clear()
   CALL g_oeb_l.clear()
   CONSTRUCT BY NAME g_wc ON oeb01,oeb03,oeb04,oeb912,oebud07
 
         BEFORE CONSTRUCT 
             CALL cl_qbe_init()
    
         ON ACTION CONTROLP
            CASE
              WHEN INFIELD(oeb01)
# HOT CODE....有問題請找saki
                 CALL q_oea4(TRUE,TRUE,'',' ')
                 RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO oeb01
                 NEXT FIELD oeb01
              WHEN INFIELD(oeb04)
                 CALL cl_init_qry_var()
                 LET g_qryparam.state = "c"
                 LET g_qryparam.form ="q_ima" 
                 CALL cl_create_qry() RETURNING g_qryparam.multiret 
                 DISPLAY g_qryparam.multiret TO oeb04
                 NEXT FIELD oeb04
            END CASE
          ON ACTION exit                                                                                                            
             LET INT_FLAG = 1                                                                                                       
             EXIT CONSTRUCT                                                                                                         
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
             CALL cl_qbe_select()
 
   END CONSTRUCT

   IF INT_FLAG THEN 
      LET INT_FLAG = 0 
   RETURN END IF

   CALL p300_list_fill(g_wc)
   
   LET g_bp_flag='info_list'
      #CALL p300_fill_b_data(tm.gem01)
      #CALL p300_show()
      --LET g_success='Y'
      --LET g_flag='Y'
      --CALL cpmp300()
      --CALL cl_confirm('lib-005') RETURNING l_flag
      --IF l_flag THEN
         --CONTINUE WHILE
      --ELSE
         --EXIT WHILE
      --END IF
      --ERROR ""
   --END WHILE

END FUNCTION

FUNCTION p300_list_fill(p_wc)
DEFINE p_wc   STRING
DEFINE l_sql  STRING
   CALL g_oeb_l.clear()
   LET l_sql="SELECT oeb01,oeb03,oeb04,ima02,ima021,oeb912,oebud07",
             "  FROM oeb_file",
             "  LEFT JOIN ima_file ON ima01=oeb04",
             " WHERE ",p_wc," ORDER BY oeb01,oeb03"
   PREPARE p300_list_prep FROM l_sql          
   DECLARE p300_list_curs CURSOR FOR p300_list_prep
   LET g_cnt=1
   FOREACH p300_list_curs INTO g_oeb_l[g_cnt].*
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_oeb_l.deleteElement(g_cnt)
END FUNCTION

FUNCTION p300_bp()

   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)
   DIALOG ATTRIBUTE(UNBUFFERED)

      DISPLAY ARRAY g_tc_oec TO s_tc_oec.* ATTRIBUTE(COUNT=g_rec_b1)
         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW
            LET l_ac1 = ARR_CURR()
            CALL cl_show_fld_cont()
            CALL p300_b2_fill(l_ac1)
      END DISPLAY
      
      DISPLAY ARRAY g_tc_oed TO s_tc_oed.* ATTRIBUTE(COUNT=g_rec_b2)
         BEFORE DISPLAY
            CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW
            LET l_ac2 = ARR_CURR()
            CALL cl_show_fld_cont()
      END DISPLAY

      --DISPLAY ARRAY g_oeb_l TO s_oeb_l.* ATTRIBUTE(COUNT=g_rec_b)
         --BEFORE DISPLAY
            --CALL cl_navigator_setting( g_curs_index, g_row_count )
         --BEFORE ROW
            --LET l_ac = ARR_CURR()
            --CALL cl_show_fld_cont()
      --END DISPLAY

      ON ACTION query
         LET g_action_choice='query'
         EXIT DIALOG

      ON ACTION to_po
         LET g_action_choice='to_po'
         EXIT DIALOG

      ON ACTION detail
         LET g_action_choice='detail'
         EXIT DIALOG

      ON ACTION act1
         LET g_b_flag='1'
         LET g_action_choice='detail'
         EXIT DIALOG

      ON ACTION act2
         LET g_b_flag='2'
         LET g_action_choice='detail'
         EXIT DIALOG

      ON ACTION info_list
         LET g_bp_flag='info_list'
         EXIT DIALOG

      ON ACTION po
         LET g_action_choice='po'
         EXIT DIALOG

      ON ACTION asfi301
         LET g_action_choice='asfi301'
         EXIT DIALOG
         
      ON ACTION controlg
         CALL cl_cmdask()

      ON ACTION EXIT
         LET g_action_choice='exit'
         EXIT DIALOG
         
      ON ACTION CANCEL
         LET INT_FLAG=FALSE
         LET g_action_choice='exit'
         EXIT DIALOG
         
   END DIALOG
   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

FUNCTION p300_bp1()
   LET g_action_choice = " "

   CALL cl_set_act_visible("accept,cancel",TRUE)
   DISPLAY ARRAY g_oeb_l TO s_oeb_l.* ATTRIBUTE(COUNT=g_rec_b)
      BEFORE DISPLAY
         CALL cl_navigator_setting( g_curs_index, g_row_count )
      BEFORE ROW
         LET l_ac = ARR_CURR()
         CALL cl_show_fld_cont()

      ON ACTION MAIN
         LET l_ac = 1
         LET g_bp_flag = NULL
         CALL p300_show(g_oeb_l[l_ac].oeb01,g_oeb_l[l_ac].oeb03)
         CALL cl_set_comp_visible("page1", FALSE)
         CALL cl_set_comp_visible("page1", TRUE)
         CALL cl_set_comp_visible("page5", FALSE)   #NO.FUN-840018 ADD
         CALL ui.interface.refresh()                #NO.FUN-840018 ADD
         CALL cl_set_comp_visible("page5", TRUE)
         EXIT DISPLAY

      ON ACTION ACCEPT
         LET l_ac = ARR_CURR()
         LET g_bp_flag = NULL
         CALL p300_show(g_oeb_l[l_ac].oeb01,g_oeb_l[l_ac].oeb03)
         CALL cl_set_comp_visible("page1", FALSE)
         CALL cl_set_comp_visible("page1", TRUE)
         CALL cl_set_comp_visible("page5", FALSE)   #NO.FUN-840018 ADD
         CALL ui.interface.refresh()                #NO.FUN-840018 ADD
         CALL cl_set_comp_visible("page5", TRUE)
         EXIT DISPLAY
         
      ON ACTION query
         LET g_action_choice='query'
         EXIT DISPLAY
         
      ON ACTION EXIT
         LET g_action_choice='exit'
         EXIT DISPLAY
      ON ACTION CANCEL
         LET g_action_choice='exit'
         EXIT DISPLAY

   END DISPLAY
   CALL cl_set_act_visible("accept,cancel",TRUE)
END FUNCTION

FUNCTION p300_show(p_oeb01,p_oeb03)
DEFINE p_oeb01 LIKE oeb_file.oeb01,
       p_oeb03 LIKE oeb_file.oeb03
DEFINE l_sfb01 LIKE sfb_file.sfb01
DEFINE l_sfb04 LIKE sfb_file.sfb04 #add by liufang161222

   SELECT oeb01,oeb03,oeb04,ima02,ima021,oeb912,oebud07,''
     INTO tm.*
     FROM oeb_file
     LEFT JOIN ima_file ON ima01=oeb04
    WHERE oeb01=p_oeb01 AND oeb03=p_oeb03

   DECLARE sfb01_cs CURSOR FOR
    #  SELECT sfb01 FROM sfb_file WHERE sfb22=p_oeb01 AND sfb221=p_oeb03 AND sfb05=tm.oeb04 #mark by liufang161222
    SELECT sfb01,sfb04 FROM sfb_file WHERE sfb22=p_oeb01 AND sfb221=p_oeb03 AND sfb05=tm.oeb04 #add by liufang161222
    CALL s_showmsg_init()   #add by liufang161222
   #FOREACH  sfb01_cs INTO l_sfb01 #mark by liufang161222
   FOREACH  sfb01_cs INTO l_sfb01,l_sfb04 #add by liufang161222
      IF l_sfb04 = 8 THEN                 #add by liufang161222
      CALL s_errmsg('sfb01',l_sfb01,'','asf-lf',1)  #add by liufang161222
      CONTINUE FOREACH                    #add by liufang161222
      END IF                              #add by liufang161222
      IF tm.sfb01 IS NULL THEN LET tm.sfb01=l_sfb01 ELSE LET tm.sfb01=tm.sfb01,'|',l_sfb01 END IF
   END FOREACH
   CALL s_showmsg() #add by liufang161222
   DISPLAY BY NAME tm.*
   CALL p300_b1_fill()
   CALL p300_b2_fill(1) 
END FUNCTION

FUNCTION p300_b1_fill()
   CALL g_tc_oec.clear()
   DECLARE p300_b1_curs CURSOR FOR
      SELECT tc_oec03,ima02,ima021,tc_oec04,ecd02,tc_oec05,
             tc_oec06,tc_oec07,tc_oec08,tc_oec09,tc_oec10
        FROM tc_oec_file
        LEFT JOIN ima_file ON ima01=tc_oec03
        LEFT JOIN ecd_file ON ecd01=tc_oec04
       WHERE tc_oec01=tm.oeb01 AND tc_oec02=tm.oeb03
   LET g_cnt=1
   FOREACH p300_b1_curs INTO g_tc_oec[g_cnt].*
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_tc_oec.deleteElement(g_cnt)
   LET g_rec_b1=g_cnt-1
   DISPLAY g_rec_b1 TO cn2
   LET g_cnt=0
END FUNCTION

FUNCTION p300_b2_fill(p_ac1)
DEFINE p_ac1 LIKE type_file.num5

   CALL g_tc_oed.clear()
   DECLARE p300_b2_curs CURSOR FOR
      #SELECT tc_oed05,tc_oed06,sfb08,tc_oed07,tc_oed08, #mark by wy20150312
      #SELECT tc_oed05,tc_oed06,sfb13,sfb08,tc_oed07,tc_oed08, #add by wy20150312 #mark by wy20150313
       SELECT tc_oed05,tc_oed06,sfb13,sfb82,sfb08,tc_oed07,tc_oed08, #add by wy20150313
             tc_oed04,ecd02,tc_oed09,tc_oed10,tc_oed11
        FROM tc_oed_file
        LEFT JOIN sfb_file ON sfb01=tc_oed06
        LEFT JOIN ecd_file ON ecd01=tc_oed04
       WHERE tc_oed01=tm.oeb01 AND tc_oed02=tm.oeb03
         AND tc_oed03=g_tc_oec[p_ac1].tc_oec03 AND tc_oed04=g_tc_oec[p_ac1].tc_oec04
         AND sfb87='Y' #add by wy20151228
   LET g_cnt=1
   FOREACH p300_b2_curs INTO g_tc_oed[g_cnt].*
      #add by wy20150313 begin
      select pmc03 INTO g_tc_oed[g_cnt].pmc03 FROM pmc_file 
      WHERE pmc01=g_tc_oed[g_cnt].pmc03
      #add by wy20150313 end`
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_tc_oed.deleteElement(g_cnt)
   LET g_rec_b2=g_cnt-1
   DISPLAY g_rec_b2 TO cn3
   LET g_cnt=0
   DISPLAY ARRAY g_tc_oed TO s_tc_ged.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION 

FUNCTION p300_b1()
DEFINE l_ac1_t LIKE type_file.num5
DEFINE l_allow_insert LIKE type_file.num5,
       l_allow_delete LIKE type_file.num5
DEFINE p_cmd       LIKE type_file.chr1
DEFINE l_lock_sw   LIKE type_file.chr1
DEFINE l_i         LIKE type_file.num5
DEFINE l_n         LIKE type_file.num5
DEFINE l_sfa06     LIKE sfa_file.sfa06

   LET g_action_choice = ""
   IF s_shut(0) THEN RETURN END IF
   IF cl_null(tm.oeb01) THEN
       RETURN
   END IF

   IF s_shut(0) THEN RETURN END IF

   LET g_forupd_sql="SELECT tc_oec03,ima02,ima021,tc_oec04,ecd02,tc_oec05,",
                    "       tc_oec06,tc_oec07,tc_oec08,tc_oec09,tc_oec10",
                    "  FROM tc_oec_file",
                    "  LEFT JOIN ecd_file ON ecd01=tc_oec04",
                    "  LEFT JOIN ima_file ON ima01=tc_oec03",
                    " WHERE tc_oec01=? AND tc_oec02=? AND tc_oec03=? AND tc_oec04=?",
                    "   FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)          
   DECLARE p300_bcl CURSOR FROM g_forupd_sql
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
      INPUT ARRAY g_tc_oec WITHOUT DEFAULTS FROM s_tc_oec.*
         ATTRIBUTE(COUNT=g_rec_b1,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
         BEFORE INPUT
            IF g_rec_b1 != 0 THEN
               CALL fgl_set_arr_curr(l_ac1)
            END IF

         BEFORE ROW
            LET p_cmd=''
            LET l_ac1 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n  = ARR_COUNT()
            BEGIN WORK

            LET g_success = 'Y'
            IF g_rec_b1 >= l_ac1 THEN
               LET p_cmd='u'
               CALL cl_set_comp_required("tc_oec03,tc_oec04",FALSE)
               CALL cl_set_comp_entry("tc_oec03,tc_oec04",FALSE)
               LET g_tc_oec_t.* = g_tc_oec[l_ac1].*  #BACKUP
               OPEN p300_bcl USING tm.oeb01,tm.oeb03,g_tc_oec_t.tc_oec03,g_tc_oec_t.tc_oec04
               IF STATUS THEN
                  CALL cl_err("OPEN p300_bcl:", STATUS, 1)
               ELSE
                  FETCH p300_bcl INTO g_tc_oec[l_ac1].* #FUN-730075
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_oec_t.tc_oec03,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"                     
                  END IF
               END IF
               CALL cl_show_fld_cont()
            END IF
            
         AFTER INSERT
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               ROLLBACK WORK
               CANCEL INSERT
            END IF
            INSERT INTO tc_oec_file(tc_oec01,tc_oec02,tc_oec03,tc_oec04,tc_oec05,tc_oec06,
                                    tc_oec07,tc_oec08,tc_oec09,tc_oec10)
                            VALUES (tm.oeb01,tm.oeb03,g_tc_oec[l_ac1].tc_oec03,g_tc_oec[l_ac1].tc_oec04,
                                    g_tc_oec[l_ac1].tc_oec05,g_tc_oec[l_ac1].tc_oec06,g_tc_oec[l_ac1].tc_oec07,
                                    g_tc_oec[l_ac1].tc_oec08,g_tc_oec[l_ac1].tc_oec09,g_tc_oec[l_ac1].tc_oec10)
            IF SQLCA.sqlcode AND sqlca.sqlcode<> -268 THEN
               CALL cl_err3("ins","tc_oec_file",tm.oeb01||tm.oeb03,g_tc_oec[l_ac1].tc_oec03,SQLCA.sqlcode,"","",1)  #No.TQC-660046
               ROLLBACK WORK
               CANCEL INSERT
            ELSE
               LET g_rec_b1=g_rec_b1+1   
            END IF

         BEFORE INSERT
            LET l_n = ARR_COUNT()
            LET p_cmd = 'a'
            CALL cl_set_comp_entry("tc_oec03,tc_oec04",TRUE)
            CALL cl_set_comp_required("tc_oec03,tc_oec04",TRUE)
            INITIALIZE g_tc_oec[l_ac1].* TO NULL
            LET g_tc_oec[l_ac1].tc_oec05=1
            LET g_tc_oec[l_ac1].tc_oec06=1
            LET g_tc_oec[l_ac1].tc_oec08='P'
            LET g_tc_oec[l_ac1].tc_oec09=0
            LET g_tc_oec_t.* = g_tc_oec[l_ac1].*
            CALL cl_show_fld_cont()
            NEXT FIELD tc_oec03
            
         AFTER FIELD tc_oec03
            IF NOT cl_null(g_tc_oec[l_ac1].tc_oec03) THEN
               SELECT ima02,ima021,ima25,ima08 
                 INTO g_tc_oec[l_ac1].ima02_1,g_tc_oec[l_ac1].ima021_1,g_tc_oec[l_ac1].tc_oec07,g_tc_oec[l_ac1].tc_oec08
                 FROM ima_file WHERE ima01=g_tc_oec[l_ac1].tc_oec03
               IF sqlca.sqlcode THEN
                  CALL cl_err(g_tc_oec[l_ac1].tc_oec03,sqlca.sqlcode,0)
                  NEXT FIELD tc_oec03
               ELSE
                  LET g_tc_oec[l_ac1].tc_oec04='0004' 
               END IF
            END IF
         AFTER FIELD tc_oec04
            IF NOT cl_null(g_tc_oec[l_ac1].tc_oec04) THEN
               SELECT ecd02 INTO g_tc_oec[l_ac1].ecd02
                 FROM ecd_file WHERE ecd01=g_tc_oec[l_ac1].tc_oec04
               IF sqlca.sqlcode THEN
                  CALL cl_err(g_tc_oec[l_ac1].tc_oec04,sqlca.sqlcode,0)
                  NEXT FIELD tc_oec04
               END IF
            END IF
         BEFORE DELETE
            SELECT COUNT(*) INTO l_i FROM tc_oed_file 
             WHERE tc_oed01=tm.oeb01 AND tc_oed02=tm.oeb03
               AND tc_oed03=g_tc_oec[l_ac1].tc_oec03
               AND tc_oed04=g_tc_oec[l_ac1].tc_oec04
               AND tc_oed10='Y'
            IF l_i>0 THEN
               CALL cl_err('','cpm-001',1)
               CANCEL DELETE
            END IF   
            SELECT MAX(sfa06) INTO l_sfa06 FROM sfa_file
             WHERE sfa01 IN(SELECT sfb01 FROM sfb_file
                              WHERE sfb22 =tm.oeb01
                                AND sfb221=tm.oeb03
                                AND sfb05 =tm.oeb04)
               AND sfa03=g_tc_oec_t.tc_oec03
               AND sfa08=g_tc_oec_t.tc_oec04
            IF l_sfa06>0 THEN 
               CALL cl_err('','cpm-003',1)
               CANCEL DELETE
            END IF
            IF NOT cl_delb(0,0) THEN
               CANCEL DELETE
            END IF
            DELETE FROM tc_oec_file
             WHERE tc_oec01=tm.oeb01
               AND tc_oec02=tm.oeb03
               AND tc_oec03=g_tc_oec_t.tc_oec03
               AND tc_oec04=g_tc_oec_t.tc_oec04
            IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 OR g_success='N' THEN
               CALL cl_err('del tc_oed',SQLCA.sqlcode,0)
               ROLLBACK WORK
               CANCEL DELETE
            END IF
            DELETE FROM tc_oed_file
             WHERE tc_oed01=tm.oeb01
               AND tc_oed02=tm.oeb03
               AND tc_oed03=g_tc_oec_t.tc_oec03
               AND tc_oed04=g_tc_oec_t.tc_oec04
            IF SQLCA.sqlcode OR g_success='N' THEN
               CALL cl_err('del tc_oed',SQLCA.sqlcode,0)
               ROLLBACK WORK
               CANCEL DELETE
            END IF
            DELETE FROM sfa_file
             WHERE sfa01 IN (SELECT sfb01 FROM sfb_file
                              WHERE sfb22 =tm.oeb01
                                AND sfb221=tm.oeb03
                                AND sfb05 =tm.oeb04)                                
               AND sfa03=g_tc_oec_t.tc_oec03
               AND sfa08=g_tc_oec_t.tc_oec04
            IF SQLCA.sqlcode OR g_success='N' THEN
               CALL cl_err('del sfa',SQLCA.sqlcode,0)
               ROLLBACK WORK
               CANCEL DELETE
            END IF
            DELETE FROM tc_sfa_file
             WHERE tc_sfa01 IN (SELECT sfb01 FROM sfb_file
                                 WHERE sfb22 =tm.oeb01
                                   AND sfb221=tm.oeb03
                                   AND sfb05 =tm.oeb04)
               AND tc_sfa02=g_tc_oec_t.tc_oec03
               AND tc_sfa03=g_tc_oec_t.tc_oec04
            IF SQLCA.sqlcode OR g_success='N' THEN
               CALL cl_err('del tc_sfa',SQLCA.sqlcode,0)
               ROLLBACK WORK
               CANCEL DELETE
            END IF
            LET g_rec_b1=g_rec_b1-1
            COMMIT WORK
         AFTER ROW
            LET l_ac1 = ARR_CURR()
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd='u' THEN
                  LET g_tc_oec[l_ac1].* = g_tc_oec_t.*
               ELSE
                  CALL g_tc_oec.deleteElement(l_ac1)
                  IF g_rec_b1 != 0 THEN
                     LET g_action_choice = "detail"
                     LET l_ac1 = l_ac1_t
                  END IF
               END IF
               CLOSE p300_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF   
            LET l_ac1_t = l_ac1
            IF cl_null(g_tc_oec[l_ac1].tc_oec03) OR
               cl_null(g_tc_oec[l_ac1].tc_oec04) THEN
               CALL g_tc_oec.deleteElement(l_ac1)
            END IF
            CLOSE p300_bcl
            COMMIT WORK
            
      
       
         ON ACTION ins_wo    #带入工单逻辑
            CALL p300_inswo()  
            CALL p300_b2_fill(l_ac1)

         ON ACTION act2
            CALL p300_b2()
            EXIT INPUT

         ON ACTION controlp
            CASE
               WHEN INFIELD(tc_oec03)
                    CALL cl_init_qry_var()
                    CALL q_sel_ima(FALSE, "q_ima_1", "",g_tc_oec[l_ac1].tc_oec03, "", "", "", "" ,"",'' )  RETURNING g_tc_oec[l_ac1].tc_oec03
                    NEXT FIELD tc_oec03
               WHEN INFIELD(tc_oec04)
                    CALL cl_init_qry_var()
                    CALL q_ecd(FALSE,TRUE,g_tc_oec[l_ac1].tc_oec04) RETURNING g_tc_oec[l_ac1].tc_oec04
                    NEXT FIELD tc_oec04
            END CASE

      END INPUT
    CALL p300_b1_fill()
    
END FUNCTION

FUNCTION p300_b2()
DEFINE l_ac2_t LIKE type_file.num5
DEFINE l_sfa04       LIKE sfa_file.sfa04,
       l_sfa05       LIKE sfa_file.sfa05,
       l_sfa12       LIKE sfa_file.sfa12,
       l_sfa16       LIKE sfa_file.sfa16,
       l_sfa25       LIKE sfa_file.sfa25,
       l_sfaud02     LIKE sfa_file.sfaud02,
       l_sfaud07     LIKE sfa_file.sfaud07,
       l_sfb08       LIKE sfb_file.sfb08,
       l_flag1       LIKE type_file.num5,
       l_fac         LIKE type_file.num20_6
DEFINE l_allow_insert LIKE type_file.num5,
       l_allow_delete LIKE type_file.num5
DEFINE p_cmd       LIKE type_file.chr1
DEFINE l_lock_sw   LIKE type_file.chr1
DEFINE l_n         LIKE type_file.num5
DEFINE l_sfa06     LIKE sfa_file.sfa06

   LET g_action_choice = ""
   IF s_shut(0) THEN RETURN END IF
   IF cl_null(tm.oeb01) THEN
       RETURN
   END IF

   #LET g_forupd_sql="SELECT tc_oed05,tc_oed06,sfb08,tc_oed07,tc_oed08,", #mark by wy20150312
   # LET g_forupd_sql="SELECT tc_oed05,tc_oed06,sfb13,sfb08,tc_oed07,tc_oed08,", #add sfb13 by wy20150312 #mark by wy20150313
    LET g_forupd_sql="SELECT tc_oed05,tc_oed06,sfb13,pmc03,sfb08,tc_oed07,tc_oed08,", #add sfb13 by wy20150313
                    "       tc_oed04,ecd02,tc_oed09,tc_oed10",
                    "  FROM tc_oed_file",
                    "  LEFT JOIN sfb_file ON sfb01=tc_oed06",
                    "  LEFT JOIN ecd_file ON ecd01=tc_oed04",
                    "  LEFT JOIN pmc_file ON pmc01=sfb82",  #add by wy20150313
                    " WHERE tc_oed01=? AND tc_oed02=? AND tc_oed03=?", 
                    "   AND tc_oed04=? AND tc_oed05=? ",
                    "   FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)          
   DECLARE p300_b2cl CURSOR FROM g_forupd_sql
   LET l_allow_insert = cl_detail_input_auth("insert")
   LET l_allow_delete = cl_detail_input_auth("delete")
      INPUT ARRAY g_tc_oed WITHOUT DEFAULTS FROM s_tc_oed.*
         ATTRIBUTE(COUNT=g_rec_b2,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)
         BEFORE INPUT
            IF g_rec_b2 != 0 THEN
               CALL fgl_set_arr_curr(l_ac2)
            END IF
            
         BEFORE ROW
            LET p_cmd=''
            LET l_ac2 = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            BEGIN WORK

            LET g_success = 'Y'
            IF g_rec_b2 >= l_ac2 THEN
               LET p_cmd='u'
               LET g_tc_oed_t.* = g_tc_oed[l_ac2].*  #BACKUP
               OPEN p300_b2cl USING tm.oeb01,tm.oeb03,g_tc_oec[l_ac1].tc_oec03,
                                    g_tc_oec[l_ac1].tc_oec04,g_tc_oed_t.tc_oed05
               IF STATUS THEN
                  CALL cl_err("OPEN p300_b2cl:", STATUS, 1)
               ELSE
                  FETCH p300_b2cl INTO g_tc_oed[l_ac2].* #FUN-730075
                  IF SQLCA.sqlcode THEN
                     CALL cl_err(g_tc_oed_t.tc_oed05,SQLCA.sqlcode,1)
                     LET l_lock_sw = "Y"                     
                  END IF
               END IF
               CALL cl_show_fld_cont()     #FUN-550037(smin)
            END IF
         AFTER FIELD tc_oed07
            IF NOT cl_null(g_tc_oed[l_ac2].tc_oed07) THEN
               SELECT sfa06+sfa062 INTO l_sfa06 FROM sfa_file
                WHERE sfa01=g_tc_oed[l_ac2].tc_oed06
                  AND sfa03=g_tc_oec[l_ac1].tc_oec03
                  AND sfa08=g_tc_oed[l_ac2].tc_oed04
               IF g_tc_oed[l_ac2].tc_oed07<l_sfa06 THEN
                  CALL cl_err('','cpm-004',1)
                  LET g_tc_oed[l_ac2].tc_oed07=g_tc_oed_t.tc_oed07
                  NEXT FIELD tc_oed07
               END IF
            END IF
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               LET g_tc_oed[l_ac2].* = g_tc_oed_t.*
               CLOSE p300_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            IF l_lock_sw = 'Y' THEN
               CALL cl_err('',-263,1)
               LET g_tc_oed[l_ac2].* = g_tc_oed_t.*
            END IF
            UPDATE tc_oed_file
               SET tc_oed07=g_tc_oed[l_ac2].tc_oed07,
                   tc_oed08=g_tc_oed[l_ac2].tc_oed08,
                   tc_oed09=g_tc_oed[l_ac2].tc_oed09
             WHERE tc_oed01=tm.oeb01 AND tc_oed02=tm.oeb03
               AND tc_oed03=g_tc_oec[l_ac1].tc_oec03 AND tc_oed04=g_tc_oec[l_ac1].tc_oec04
               AND tc_oed05=g_tc_oed[l_ac2].tc_oed05
            IF sqlca.sqlcode THEN
               CALL cl_err('',sqlca.sqlcode,1)
               LET g_tc_oed[l_ac2].* = g_tc_oed_t.*
               ROLLBACK WORK
               EXIT INPUT
            END IF
            SELECT sfb08,sfa12,sfaud02 INTO l_sfb08,l_sfa12,l_sfaud02 FROM sfb_file,sfa_file 
             WHERE sfa01=g_tc_oed[l_ac2].tc_oed06 
               AND sfa03=g_tc_oec[l_ac1].tc_oec03
               AND sfa08=g_tc_oec[l_ac1].tc_oec04
               AND sfa01=sfb01
            LET l_sfa04 = s_digqty(g_tc_oed[l_ac2].tc_oed07,l_sfa12)
            LET l_sfa05 = s_digqty(g_tc_oed[l_ac2].tc_oed07,l_sfa12)
            LET l_sfa25 = s_digqty(g_tc_oed[l_ac2].tc_oed07,l_sfa12)
            CALL s_umfchk(g_tc_oec[l_ac1].tc_oec03,l_sfa12,l_sfaud02) RETURNING l_flag1,l_fac
            LET l_sfaud07=l_sfa05*l_fac
            LET l_sfa16 = l_sfa05/l_sfb08
            UPDATE sfa_file SET sfa04=l_sfa04,
                                sfa05=l_sfa05,
                                sfa25=l_sfa25,
                                sfaud07=l_sfaud07,
                                sfa16=l_sfa16,
                                sfa161=l_sfa16
                          WHERE sfa01=g_tc_oed[l_ac2].tc_oed06 
                            AND sfa03=g_tc_oec[l_ac1].tc_oec03
                            AND sfa08=g_tc_oec[l_ac1].tc_oec04
            UPDATE tc_sfa_file SET tc_sfa06=l_sfa04,
                                   tc_sfa08=l_sfaud07,
                                   tc_sfa12=l_sfa16,
                                   tc_sfa13=l_sfa16
                             WHERE tc_sfa01=g_tc_oed[l_ac2].tc_oed06 
                               AND ta_sfa02=g_tc_oec[l_ac1].tc_oec03
                               AND ta_sfa03=g_tc_oec[l_ac1].tc_oec04
            COMMIT WORK
            
         AFTER ROW
            LET l_ac2 = ARR_CURR()
            IF INT_FLAG THEN
               CALL cl_err('',9001,0)
               LET INT_FLAG = 0
               IF p_cmd='u' THEN
                  LET g_tc_oed[l_ac2].* = g_tc_oed_t.*
               ELSE
                  CALL g_tc_oed.deleteElement(l_ac2)
                  IF g_rec_b2 != 0 THEN
                     LET g_action_choice = "detail"
                     LET l_ac2 = l_ac2_t
                  END IF
               END IF
               CLOSE p300_bcl
               ROLLBACK WORK
               EXIT INPUT
            END IF
            
         ON ACTION act1
            CALL p300_b1()
            EXIT INPUT

      END INPUT
      CALL p300_b2_fill(1)
END FUNCTION

FUNCTION p300_inswo()
DEFINE i LIKE type_file.num10
DEFINE l_tc_oed RECORD LIKE tc_oed_file.*
DEFINE l_sfa    RECORD LIKE sfa_file.*
DEFINE l_tc_sfa RECORD LIKE tc_sfa_file.*
DEFINE l_sfb01  LIKE sfb_file.sfb01
DEFINE l_n LIKE type_file.num10
#--add by ganlh170731--STAR
DEFINE l_tc_sfb08 LIKE tc_sfb_file.tc_sfb08
DEFINE l_tc_sfb06 LIKE tc_sfb_file.tc_sfb06
DEFINE l_sfb02    LIKE sfb_file.sfb02
DEFINE l_sfb13    LIKE sfb_file.sfb13
   SELECT tc_sfb08,tc_sfb06 INTO l_tc_sfb08,l_tc_sfb06 FROM tc_sfb_file WHERE tc_sfb01=0
   
#--add by ganlh170731--END
   DECLARE p300_inswo_curs CURSOR FOR
   SELECT sfb01 FROM sfb_file WHERE sfb22=tm.oeb01 AND sfb221=tm.oeb03 AND sfb05=tm.oeb04
   LET l_tc_oed.tc_oed01=tm.oeb01
   LET l_tc_oed.tc_oed02=tm.oeb03
   FOR i=1 TO g_tc_oec.getLength()
      INSERT INTO tc_oec_file(tc_oec01,tc_oec02,tc_oec03,tc_oec04,tc_oec05,tc_oec06,
                              tc_oec07,tc_oec08,tc_oec09,tc_oec10)
                      VALUES (tm.oeb01,tm.oeb03,g_tc_oec[i].tc_oec03,g_tc_oec[i].tc_oec04,
                              g_tc_oec[i].tc_oec05,g_tc_oec[i].tc_oec06,g_tc_oec[i].tc_oec07,
                              g_tc_oec[i].tc_oec08,g_tc_oec[i].tc_oec09,g_tc_oec[i].tc_oec10)
      LET l_tc_oed.tc_oed03=g_tc_oec[i].tc_oec03
      LET l_tc_oed.tc_oed04=g_tc_oec[i].tc_oec04
      FOREACH p300_inswo_curs INTO l_sfb01
         SELECT COUNT(*) INTO l_n FROM sfa_file
          WHERE sfa01=l_sfb01 AND sfa03=l_tc_oed.tc_oed03
            AND sfa08=l_tc_oed.tc_oed04
         IF l_n>0 THEN CONTINUE FOREACH END IF   
         SELECT MAX(tc_oed05)+1 INTO l_tc_oed.tc_oed05
           FROM tc_oed_file
          WHERE tc_oed01 =l_tc_oed.tc_oed01
            AND tc_oed02 =l_tc_oed.tc_oed02
            AND tc_oed03 =l_tc_oed.tc_oed03
            AND tc_oed04 =l_tc_oed.tc_oed04
         IF l_tc_oed.tc_oed05 IS NULL THEN LET l_tc_oed.tc_oed05=1 END IF
         LET l_tc_oed.tc_oed06=l_sfb01
         LET l_tc_oed.tc_oed07=0
         #--add by ganlh170731--STAR
         SELECT sfb02,sfb13 INTO l_sfb02,l_sfb13 FROM sfb_file WHERE sfb01=l_sfb01
         LET l_tc_oed.tc_oed08 = l_sfb13
         IF l_sfb02='1' THEN
         LET l_tc_oed.tc_oed08 = l_sfb13 + l_tc_sfb08
         END IF
         IF l_sfb02='7' THEN
         LET l_tc_oed.tc_oed08 = l_sfb13+l_tc_sfb06
         END IF
         #--add by ganlh170731--END
       #  LET l_tc_oed.tc_oed08=g_today
         LET l_tc_oed.tc_oed09=tm.oeb01||tm.oeb03||' '||tm.oeb04
         LET l_tc_oed.tc_oed10='N'
         LET l_tc_oed.tc_oed11=''
         INSERT INTO tc_oed_file VALUES(l_tc_oed.*)
         IF sqlca.sqlerrd[3]=0 THEN 
            CONTINUE FOREACH
         END IF
         LET l_sfa.sfa01=l_sfb01
         SELECT sfb02 INTO l_sfa.sfa02 FROM sfb_file WHERE sfb01=l_sfb01
         LET l_sfa.sfa03=l_tc_oed.tc_oed03
         LET l_sfa.sfa04=l_tc_oed.tc_oed07
         LET l_sfa.sfa05=l_tc_oed.tc_oed07
         LET l_sfa.sfa06 =0
         LET l_sfa.sfa061=0
         LET l_sfa.sfa062=0
         LET l_sfa.sfa063=0
         LET l_sfa.sfa064=0
         LET l_sfa.sfa065=0
         LET l_sfa.sfa066=0
         LET l_sfa.sfa08=l_tc_oed.tc_oed04
         IF cl_null(l_sfa.sfa08) THEN LET l_sfa.sfa08=' ' END IF
         LET l_sfa.sfa09=0
         LET l_sfa.sfa11 ='N'
         SELECT ima55,ima55_fac,ima86,ima86_fac,ima907 
           INTO l_sfa.sfa12,l_sfa.sfa13,l_sfa.sfa14,l_sfa.sfa15,l_sfa.sfaud02
           FROM ima_file WHERE ima01=l_tc_oed.tc_oed03
         LET l_sfa.sfaud07=0
         LET l_sfa.sfa25 =l_tc_oed.tc_oed07
         LET l_sfa.sfa26 ='0'
         LET l_sfa.sfa27 =l_tc_oed.tc_oed03
         LET l_sfa.sfa28 =1
         LET l_sfa.sfa29 =l_tc_oed.tc_oed03
         LET l_sfa.sfaacti ='Y'
         LET l_sfa.sfaplant=g_plant #FUN-980012 add
         LET l_sfa.sfalegal=g_legal
         LET l_sfa.sfa04 = s_digqty(l_sfa.sfa04,l_sfa.sfa12)
         LET l_sfa.sfa05 = s_digqty(l_sfa.sfa05,l_sfa.sfa12)
         LET l_sfa.sfa25 = s_digqty(l_sfa.sfa25,l_sfa.sfa12)
         IF cl_null(l_sfa.sfa100) THEN
            LET l_sfa.sfa100 = 0 
         END IF
         IF cl_null(l_sfa.sfa04) THEN LET l_sfa.sfa04 = 0 END IF
         IF cl_null(l_sfa.sfa05) THEN LET l_sfa.sfa05 = 0 END IF
         SELECT l_sfa.sfa05/sfb08 INTO l_sfa.sfa161 FROM sfb_file WHERE sfb01=l_sfb01
         LET l_sfa.sfa16 =l_sfa.sfa161
         IF cl_null(l_sfa.sfa012) THEN LET l_sfa.sfa012=' ' END IF  #MOD-A50107 add
         IF cl_null(l_sfa.sfa013) THEN LET l_sfa.sfa013=0   END IF
         INSERT INTO sfa_file VALUES(l_sfa.*)
         LET l_tc_sfa.tc_sfa01=l_sfb01
         LET l_tc_sfa.tc_sfa02=l_tc_oed.tc_oed03
         LET l_tc_sfa.tc_sfa03=l_tc_oed.tc_oed04
         LET l_tc_sfa.tc_sfa04=1
         LET l_tc_sfa.tc_sfa05=l_sfa.sfa12
         LET l_tc_sfa.tc_sfa06=l_sfa.sfa05
         LET l_tc_sfa.tc_sfa07=l_sfa.sfaud02
         LET l_tc_sfa.tc_sfa08=l_sfa.sfaud07
         LET l_tc_sfa.tc_sfa09=''
         LET l_tc_sfa.tc_sfa10=''
         LET l_tc_sfa.tc_sfa11=''
         LET l_tc_sfa.tc_sfa12=l_sfa.sfa16
         LET l_tc_sfa.tc_sfa13=l_sfa.sfa161
         LET l_tc_sfa.tc_sfa14=''
         INSERT INTO tc_sfa_file VALUES(l_tc_sfa.*)
      END FOREACH   
   END FOR
END FUNCTION

FUNCTION p300_po()
DEFINE i,l_flag LIKE type_file.num10
DEFINE l_pmk01 LIKE pmk_file.pmk01,
       l_pmk02 LIKE pmk_file.pmk02,
       l_pmk04 LIKE pmk_file.pmk04
DEFINE li_result LIKE type_file.num5
DEFINE l_ima01     LIKE ima_file.ima01,
       l_ima02     LIKE ima_file.ima02,
       l_ima05     LIKE ima_file.ima05,
       l_ima25     LIKE ima_file.ima25,
       l_avl_stk   LIKE type_file.num15_3,
       l_ima27     LIKE ima_file.ima27,
       l_ima44     LIKE ima_file.ima44,
       l_ima44_fac LIKE ima_file.ima44_fac,
       l_ima45     LIKE ima_file.ima45,
       l_ima46     LIKE ima_file.ima46,
       l_ima49     LIKE ima_file.ima49,
       l_ima491    LIKE ima_file.ima491,
       l_ima906    LIKE ima_file.ima906,
       l_ima907    LIKE ima_file.ima907,
       l_ima908    LIKE ima_file.ima908
DEFINE l_seq,l_cnt LIKE type_file.num5
DEFINE l_factor    LIKE type_file.num20_6
DEFINE l_prog      LIKE type_file.chr10
DEFINE l_sw        LIKE type_file.chr1

   INITIALIZE l_pmk.* TO NULL
   INITIALIZE l_pml.* TO NULL
   CALL g_pml.clear()

   OPEN WINDOW p300p_w AT p_row,p_col
       WITH FORM "cpm/42f/cpmp300p"  ATTRIBUTE (STYLE = g_win_style CLIPPED)
   CALL cl_ui_locale("cpmp300p")
   CALL cl_opmsg('z')
   DECLARE p300_po_curs CURSOR FOR
   SELECT 'N',sfa26,tc_oed06,tc_oed04,tc_oed03,ima02,tc_oed01||'_'||tc_oed02,
          tc_oed09,ima25,ima44,ima44_fac,SUM(tc_oed07),tc_oed08
     FROM tc_oed_file
     LEFT JOIN ima_file ON ima01=tc_oed03
     LEFT JOIN sfa_file ON sfa01=tc_oed06 AND sfa03=tc_oed03 AND sfa08=tc_oed04
    WHERE tc_oed01=tm.oeb01 AND tc_oed02=tm.oeb03 AND tc_oed10='N' AND tc_oed11 IS NULL
     GROUP BY sfa26,tc_oed06,tc_oed04,tc_oed03,ima02,tc_oed01,tc_oed02,
              tc_oed09,ima25,ima44,ima44_fac,tc_oed08
   LET g_cnt=1 
   FOREACH p300_po_curs INTO g_pml[g_cnt].*
      LET g_cnt=g_cnt+1
   END FOREACH
   CALL g_pml.deleteElement(g_cnt)
   DISPLAY ARRAY g_pml TO s_pml.* ATTRIBUTE(COUNT=g_rec_b3,UNBUFFERED)
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   INPUT l_pmk01,l_pmk02,l_pmk04 WITHOUT DEFAULTS FROM pmk01,pmk02,pmk04
      BEFORE INPUT 
         LET l_pmk02='REG'
         LET l_pmk04=g_today
         DISPLAY l_pmk02 TO pmk02
         DISPLAY l_pmk04 TO pmk04

      AFTER FIELD pmk01
         CALL s_check_no("apm",l_pmk01,"","1","pmk_file","pmk01","") RETURNING li_result,l_pmk01
         DISPLAY l_pmk01 TO pmk01
         IF (NOT li_result) THEN
            NEXT FIELD pmk01
         END IF

      AFTER FIELD pmk04
         SELECT azn02,azn04 INTO l_pmk.pmk31,l_pmk.pmk32 FROM azn_file
          WHERE azn01 = l_pmk04
         IF SQLCA.sqlcode THEN
            CALL cl_err3("sel","azn_file",l_pmk04,"","mfg0027","","",1)
            NEXT FIELD pmk04
         END IF

      AFTER INPUT
         CALL s_auto_assign_no("apm",l_pmk01,l_pmk04,"","pmk_file","pmk01","","","")
            RETURNING li_result,l_pmk.pmk01
         IF (NOT li_result) THEN
            NEXT FIELD pmk01
         END IF
         DISPLAY l_pmk.pmk01 TO pmk01

      ON ACTION controlp
         IF INFIELD(pmk01) THEN
             LET l_pmk01 = s_get_doc_no(l_pmk.pmk01)    #No.MOD-540182
             CALL q_smy(FALSE,FALSE,l_pmk01,'APM','1') RETURNING g_t1
             LET l_pmk01=g_t1
             LET l_pmk.pmk01 = l_pmk01
             DISPLAY BY NAME l_pmk.pmk01
             NEXT FIELD pmk01
         END IF
      ON ACTION EXIT
         LET INT_FLAG =1
         EXIT INPUT

      ON ACTION CANCEL
         LET INT_FLAG =1
         EXIT INPUT
   END INPUT
   
   IF INT_FLAG THEN
      LET INT_FLAG=0
      CLOSE WINDOW p300p_w
      RETURN
   END IF
   
   INPUT ARRAY g_pml WITHOUT DEFAULTS FROM s_pml.*
      ATTRIBUTE(COUNT=g_rec_b3,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)
         BEFORE INPUT

      ON ACTION sel_all
         FOR i=1 TO g_pml.getLength()
            LET g_pml[i].x='Y'
         END FOR
      ON ACTION sel_no_all
         FOR i=1 TO g_pml.getLength()
            LET g_pml[i].x='N'
         END FOR
      
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG=0
      CLOSE WINDOW p300p_w
      RETURN
   END IF
   LET g_success='Y'
   
   BEGIN WORK
      LET l_pmk.pmk04=l_pmk04
      LET l_pmk.pmk02=l_pmk02
      CALL p300_init_pmk()
      LET l_seq=1
      LET l_sw='N'
      FOR i=1 TO g_pml.getLength()
         IF g_pml[i].x='N' THEN CONTINUE FOR END IF
         SELECT ima01,ima02,ima05,ima25,0,ima27,ima44,ima44_fac, #FUN-A20044
                ima45,ima46,ima49,ima491,ima908   #No.MOD-6B0157 modify
           INTO l_ima01,l_ima02,l_ima05,l_ima25,l_avl_stk,l_ima27,  #No.TQC-6B0124 add ima908
                l_ima44,l_ima44_fac,l_ima45,l_ima46,
                l_ima49,l_ima491,l_ima908    #No.MOD-6B0157 modify
           FROM ima_file
          WHERE ima01 = g_pml[i].pml04
         
         IF SQLCA.sqlcode THEN
            CALL cl_err3("sel","ima_file",g_pml[i].pml04,"",SQLCA.sqlcode,"","sel ima",1)  #No.FUN-660129
            LET g_success = 'N'
            CLOSE WINDOW p300p_w
            RETURN
         END IF
         LET l_pml.pml01 = l_pmk.pmk01
         LET l_pml.pml011= l_pmk.pmk02
         LET l_pml.pml12 = l_pmk.pmk05	#MOD-980213
         LET l_pml.pml16 = l_pmk.pmk25
         LET l_pml.pml14 = g_sma.sma886[1,1]     
         LET l_pml.pml15  =g_sma.sma886[2,2]
         LET l_pml.pml23 = 'Y'                   
         LET l_pml.pml38 = l_pmk.pmk45   #FUN-690047
         LET l_pml.pml43 = 0                     
         LET l_pml.pml431 = 0
         LET l_pml.pml11 = 'N'                   
         LET l_pml.pml13  = 0
         LET l_pml.pml21  = 0                    
         LET l_pml.pml16 = l_pmk.pmk25
         LET l_pml.pml30 = 0                     
         LET l_pml.pml32 = 0
         LET l_pml.pml18 = ' '
         LET l_pml.pml24 = g_pml[i].pml24 #TQC-CC0119 add
         LET l_pml.pml02 = l_seq
         LET l_pml.pml04 = l_ima01
         LET l_pml.pml041= l_ima02
         LET l_pml.pml05 = NULL  #no.4649
         LET l_pml.pml07 = l_ima44
         LET l_pml.pml08 = l_ima25
         CALL s_umfchk(l_pml.pml04,l_pml.pml07,l_ima25) RETURNING l_cnt,l_pml.pml09
         IF l_cnt = 1 THEN LET l_pml.pml09=1 END IF
         LET l_pml.pml42 = g_pml[i].pml42
         IF l_pml.pml42  = '2' THEN LET l_pml.pml42 = '1' END IF
         IF l_pml.pml42  = 'S' THEN LET l_pml.pml42 = '0' END IF
         IF l_pml.pml42  = 'U' THEN LET l_pml.pml42 = '0' END IF
         LET l_pml.pmlud02 = g_pml[i].pmlud02
         LET l_pml.pml20 = g_pml[i].pml20
 
         CALL s_umfchk(l_pml.pml04,l_ima25,l_pml.pml07) RETURNING l_flag,l_factor    
         IF l_flag THEN
            CALL cl_err(l_pml.pml07,'mfg1206',0)
         ELSE
            LET l_pml.pml20=l_pml.pml20*l_factor
         END IF
         LET l_pml.pml20 = s_digqty(l_pml.pml20,l_pml.pml07)   #FUN-910088--add--

         LET l_pml.pml35 = g_pml[i].pml35                             #FUN-AB0030  
         CALL s_aday(l_pml.pml35,-1,l_ima491) RETURNING l_pml.pml34
         CALL s_aday(l_pml.pml34,-1,l_ima49) RETURNING l_pml.pml33

         IF g_sma.sma115 = 'Y' THEN
            SELECT ima44,ima906,ima907 INTO l_ima44,l_ima906,l_ima907
              FROM ima_file 
             WHERE ima01 = l_pml.pml04
            LET l_pml.pml80 = l_pml.pml07
            LET l_factor = 1
            CALL s_umfchk(l_pml.pml04,l_pml.pml80,l_ima44)
                RETURNING l_cnt,l_factor
            IF l_cnt = 1 THEN
               LET l_factor = 1
            END IF
            LET l_pml.pml81=l_factor
            LET l_pml.pml82=l_pml.pml20
            LET l_pml.pml83=l_ima907
            LET l_factor = 1
            CALL s_umfchk(l_pml.pml04,l_pml.pml83,l_ima44)
                 RETURNING l_cnt,l_factor
            IF l_cnt = 1 THEN
               LET l_factor = 1
            END IF
            LET l_pml.pml84=l_factor
            LET l_pml.pml85=0
            IF l_ima906 = '3' THEN
               LET l_pml.pml84=l_factor
               LET l_factor = 1
               CALL s_umfchk(l_pml.pml04,l_pml.pml80,l_pml.pml83)
                    RETURNING l_cnt,l_factor
               IF l_cnt = 1 THEN
                  LET l_factor = 1
               END IF
               LET l_pml.pml85=l_pml.pml82*l_factor
               LET l_pml.pml85 = s_digqty(l_pml.pml85,l_pml.pml83)   #FUN-910088--add--
            END IF
         END IF
         IF cl_null(l_ima908) THEN LET l_ima908 = l_pml.pml07 END IF

         IF g_sma.sma116 NOT MATCHES '[13]' THEN
            LET l_pml.pml86 = l_pml.pml07
         ELSE
            LET l_pml.pml86 = l_ima908
         END IF
         CALL p470_set_pml87(l_pml.pml04,l_pml.pml07,
                             l_pml.pml86,l_pml.pml20) RETURNING l_pml.pml87
         LET l_pml.pml87 = s_digqty(l_pml.pml87,l_pml.pml86)    #FUN-910088--add--
         IF cl_null(l_pml.pml190) THEN
            SELECT ima913,ima914 INTO l_pml.pml190,l_pml.pml191    #NO.CHI-6A0016
              FROM ima_file
             WHERE ima01 = l_pml.pml04
            IF STATUS = 100 THEN
               LET l_pml.pml190 = 'N' #TQC-6A0011
            END IF
         END IF
         LET l_pml.pml930=s_costcenter(l_pmk.pmk13)
         LET l_pml.pml192 = 'N'         #NO.CHI-6A0016  #拋轉否
         INITIALIZE l_pml.pml25 TO NULL  #No.MOD-870161
         LET l_pml.pmlplant = g_plant #FUN-980006 add
         LET l_pml.pmllegal = g_legal #FUN-980006 add
         IF cl_null(l_pml.pml91) THEN LET l_pml.pml91 = 'N' END IF   #TQC-980136 #TQC-AB0397 add 'N'
         LET l_pml.pml49 = '1' #No.FUN-870007
         LET l_pml.pml50 = '1' #No.FUN-870007
         LET l_pml.pml54 = '2' #No.FUN-870007
         LET l_pml.pml56 = '1' #No.FUN-870007
         LET l_pml.pml92 = 'N' #FUN-9B0023
         LET l_pml.pml06 = g_pml[i].pml06
         LET l_pml.pml16 = '0'
         INSERT INTO pml_file VALUES(l_pml.*)
         IF SQLCA.sqlcode THEN
            CALL cl_err3("ins","pml_file",l_pml.pml01,"",SQLCA.sqlcode,"","ins pml",1)  #No.FUN-660129
            LET g_success = 'N'
         ELSE
            LET l_seq=l_seq+1
            LET l_sw='Y'   
         END IF
         
      END FOR
   IF g_success='N' OR l_sw='N' THEN
      ROLLBACK WORK
   ELSE
      INSERT INTO pmk_file VALUES(l_pmk.*)
      IF sqlca.sqlcode THEN
         CALL cl_err(l_pmk.pmk01,sqlca.sqlcode,0)
         ROLLBACK WORK
         CLOSE WINDOW p300p_w
         RETURN
      END IF
      LET l_prog=g_prog
      LET g_prog='apmt420'
      LET g_action_choice='insert'
      CALL t420sub_y_chk(l_pmk.pmk01)
      IF g_success='Y' THEN
         CALL t420sub_y_upd(l_pmk.pmk01,g_action_choice)      #CALL 原確認的 update 段
         #回写请购单号和标志位逻辑begin
         FOR i=1 TO g_pml.getLength()
            IF g_pml[i].x='Y' THEN
               UPDATE tc_oed_file SET tc_oed10='Y',tc_oed11=l_pmk.pmk01
                WHERE tc_oed01=tm.oeb01 AND tc_oed02=tm.oeb03
                  AND tc_oed03=g_pml[i].pml04 AND tc_oed04=g_pml[i].sfa08
                  AND tc_oed06=g_pml[i].pml24
            END IF   
         END FOR
         #回写请购单号和标志位逻辑end
         COMMIT WORK
      ELSE
         ROLLBACK WORK   
      END IF
      LET g_action_choice=''
      LET g_prog=l_prog
   END IF
   CLOSE WINDOW p300p_w
END FUNCTION

FUNCTION p300_init_pmk()

   LET l_pmk.pmk03 = '0'
   LET l_pmk.pmk12 = g_user
   LET l_pmk.pmk13 = g_grup
   CALL t420_peo('d','1',l_pmk.pmk12)
   IF NOT cl_null(g_errno) THEN
      LET l_pmk.pmk12 = ''
   END IF
   CALL t420_dep('d','1',l_pmk.pmk13)
   IF NOT cl_null(g_errno) THEN
      LET l_pmk.pmk13 = ''
   END IF
   LET l_pmk.pmk18 = 'N'
   LET l_pmk.pmk25 = '0'         #開立
   LET l_pmk.pmk27 = g_today
   LET l_pmk.pmk30 = 'Y'
   LET l_pmk.pmk40 = 0           #總金額
   LET l_pmk.pmk401= 0           #總金額
   LET l_pmk.pmk43 = 0           #稅率
   LET l_pmk.pmk45 = 'Y'         #可用
   LET l_pmk.pmkdays = 0         #簽核天數
   LET l_pmk.pmkprno = 0         #列印次數
   LET l_pmk.pmksmax = 0         #己簽順序
   LET l_pmk.pmksseq = 0         #應簽順序
   CALL cl_opmsg('a')
   LET l_pmk.pmk05   =''      #No.MOD-590269 Move
   LET l_pmk.pmk12   = g_user               #請購員  #No.MOD-590269 Move
   LET l_pmk.pmkplant = g_plant
   LET l_pmk.pmklegal = g_legal
   LET l_pmk.pmk46 = '1'
   LET l_pmk.pmk47 = g_plant
   LET l_pmk.pmk50 = NULL    #FUN-CC0057 add
   LET l_pmk.pmk48 = TIME
   LET l_pmk.pmkacti ='Y'                   #有效的資料
   LET l_pmk.pmkuser = g_user
   LET l_pmk.pmkoriu = g_user #FUN-980030
   LET l_pmk.pmkorig = g_grup #FUN-980030
   LET l_pmk.pmkgrup = g_grup               #使用者所屬群
   LET l_pmk.pmkcrat = g_today           #資料創建日 #No.FUN-870007
   LET l_pmk.pmkplant = g_plant          #FUN-980006 add
   LET l_pmk.pmklegal = g_legal
   SELECT smyapr INTO l_pmk.pmkmksg FROM smy_file WHERE smyslip=g_t1
   IF cl_null(l_pmk.pmkmksg) THEN
      LET  l_pmk.pmkmksg = 'N'
   END IF
   IF cl_null(l_pmk.pmk46) THEN 
      LET l_pmk.pmk46 = '1'
   END IF 
END FUNCTION
#No.FUN-9C0072 精簡程式碼


