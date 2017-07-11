# Prog. Version..: '5.30.06-1.0'     #
#
# Pattern name...: cpmq021.4gl
# Descriptions...: TOP170618采购价格分析表
# Date & Author..: 17/06/18 By TOP170618
# Modify.........: 17/06/18 建立程序

DATABASE ds

GLOBALS "../../config/top.global"


DEFINE  g_pmm   DYNAMIC ARRAY OF RECORD   #单身2
          ima06_1   LIKE ima_file.ima06,
          imz02_1   LIKE imz_file.imz02,
          pmn04_1   LIKE pmn_file.pmn04,
          pmn041_1  LIKE pmn_file.pmn041,
          ima021_1  LIKE ima_file.ima021,
          pmm09_1     LIKE pmm_file.pmm09,
          pmc03_1     LIKE pmc_file.pmc03,
          pmc081    LIKE pmc_file.pmc081,
          pmn01     LIKE pmn_file.pmn01,
          pmn31t     LIKE pmn_file.pmn31t,
          pmn88t_1  LIKE pmn_file.pmn88t
              END RECORD,
        g_tmc      RECORD
          ima06   LIKE ima_file.ima06,
          pmn04   LIKE pmn_file.pmn04,
          pmn041  LIKE pmn_file.pmn041,
          pmm09   LIKE pmm_file.pmm09,
          pmc03   LIKE pmc_file.pmc03,
          bdate     LIKE pmn_file.pmn33,
          edate     LIKE pmn_file.pmn33
              END RECORD,
        g_tmh          RECORD
          bdate     LIKE type_file.dat,
          edate     LIKE type_file.dat
                END RECORD,
        g_pmn   DYNAMIC ARRAY OF RECORD   #单身1
                  ima06       LIKE ima_file.ima06,
                  imz02         LIKE imz_file.imz02,
                  pmn04       LIKE pmn_file.pmn04,
                  pmn041      LIKE pmn_file.pmn041,
                  ima021        LIKE ima_file.ima021,
                  pmn20         LIKE pmn_file.pmn20,
                  pmn88t         LIKE pmn_file.pmn88t,
                  lowestpmn31t      LIKE pmn_file.pmn31t,
                  mostpmn31t        LIKE pmn_file.pmn31t,
                  averagepmn31t     LIKE pmn_file.pmn31t
                      END RECORD,
        g_ima06       DYNAMIC ARRAY OF RECORD
                        ima06   LIKE ima_file.ima06
                        END RECORD
DEFINE   l_bdate         LIKE type_file.dat
DEFINE   l_edate         LIKE type_file.dat
DEFINE g_wc                STRING
DEFINE g_sql                STRING
DEFINE g_wc1               STRING
DEFINE g_wc2               STRING
DEFINE g_forupd_sql        STRING
DEFINE l_ac             LIKE type_file.num5
DEFINE l_ac1             LIKE type_file.num5
DEFINE g_rec_b             LIKE type_file.num5
DEFINE g_rec_b2             LIKE type_file.num5                 #SELECT ... FOR UPDATE  SQL
DEFINE g_curs_index        LIKE type_file.num10  	 #当前笔数
DEFINE g_row_count         LIKE type_file.num10    #总笔数
DEFINE g_before_input_done LIKE type_file.num5
DEFINE g_msg               LIKE ze_file.ze03
DEFINE g_jump              LIKE type_file.num10    #查詢指定的筆數
DEFINE g_no_ask            LIKE type_file.num5     #是否開啟指定筆視窗
DEFINE g_cnt               LIKE type_file.num10
DEFINE g_chr               LIKE type_file.chr1
DEFINE g_b_flag            LIKE type_file.chr1

MAIN
  OPTIONS
     INPUT NO WRAP
  DEFER INTERRUPT

  IF (NOT cl_user()) THEN
     EXIT PROGRAM
  END IF

  WHENEVER ERROR CALL cl_err_msg_log

  IF (NOT cl_setup("CPM")) THEN
     EXIT PROGRAM
  END IF

  CALL cl_used(g_prog,g_time,1) RETURNING g_time


  OPEN WINDOW t021_w WITH FORM "cpm/42f/cpmq021"
    ATTRIBUTE (STYLE = g_win_style CLIPPED)
  CALL cl_set_locale_frm_name("cpmq021")

  CALL cl_ui_init()

  LET l_bdate='14/03/01'
  LET l_edate='14/03/01'

  CALL q021_menu()

  CLOSE WINDOW t021_w

  CALL cl_used(g_prog,g_time,2) RETURNING g_time
END MAIN

FUNCTION q021_cs()
DEFINE   l_type      LIKE apa_file.apa00
DEFINE   l_dbs       LIKE type_file.chr21
DEFINE   lc_qbe_sn   LIKE gbm_file.gbm01

  CLEAR FORM
  CALL cl_opmsg('p')
  CALL g_pmn.clear()

  CALL cl_set_head_visible("","YES")
  INITIALIZE g_tmc.* TO NULL
  #IF cl_null(g_wc1) THEN

  LET g_tmh.bdate=l_bdate
  LET g_tmh.edate=l_edate

  INPUT BY NAME g_tmh.bdate,g_tmh.edate  ATTRIBUTE(WITHOUT DEFAULTS)
  BEFORE INPUT
      CALL cl_qbe_init()

  AFTER INPUT
    IF INT_FLAG THEN
       EXIT INPUT
    END IF
    IF g_tmh.edate < g_tmh.bdate THEN
       CALL cl_err('','agl-031',0)
       NEXT FIELD edate
    END IF

    ON IDLE g_idle_seconds                         #每個交談指令必備以下四個功能
       CALL cl_on_idle()                           #idle、about、help、controlg
       CONTINUE INPUT

    ON ACTION about
       CALL cl_about()

    ON ACTION help
       CALL cl_show_help()

    ON ACTION controlg
       CALL cl_cmdask()

  END INPUT

  IF INT_FLAG THEN
      RETURN
  END IF

  CONSTRUCT g_wc ON ima06,pmn04,pmn041
      FROM s_pmn[1].ima06,s_pmn[1].pmn04,s_pmn[1].pmn041

  BEFORE CONSTRUCT
      CALL cl_qbe_display_condition(lc_qbe_sn)

  ON ACTION controlp
     CASE
        WHEN INFIELD(ima06)
            CALL cl_init_qry_var()
            LET g_qryparam.form ="cq_ima06"
            CALL cl_create_qry() RETURNING g_qryparam.multiret
            DISPLAY g_qryparam.multiret TO ima06
            NEXT FIELD pmn04

        WHEN INFIELD(pmn04)
            CALL cl_init_qry_var()
            LET g_qryparam.form ="cq_pmn04"
            CALL cl_create_qry() RETURNING g_qryparam.multiret
            DISPLAY g_qryparam.multiret TO pmn04
            NEXT FIELD pmn041

        OTHERWISE EXIT CASE

     END CASE

  ON IDLE g_idle_seconds                         #每個交談指令必備以下四個功能
     CALL cl_on_idle()                           #idle、about、help、controlg
     CONTINUE CONSTRUCT

  ON ACTION about
     CALL cl_about()

  ON ACTION help
     CALL cl_show_help()

  ON ACTION controlg
     CALL cl_cmdask()

  END CONSTRUCT

  IF INT_FLAG THEN
      RETURN
  END IF

  CONSTRUCT g_wc1 ON pmm09,pmc03
      FROM s_pmm[1].pmm09,s_pmm[1].pmc03

  BEFORE CONSTRUCT
      CALL cl_qbe_display_condition(lc_qbe_sn)

  ON ACTION controlp
     CASE

        WHEN INFIELD(pmm09)
            CALL cl_init_qry_var()
            LET g_qryparam.form ="cq_pmm09"
            CALL cl_create_qry() RETURNING g_qryparam.multiret
            DISPLAY g_qryparam.multiret TO pmm09
            NEXT FIELD pmc03

        OTHERWISE EXIT CASE
     END CASE

  ON IDLE g_idle_seconds                         #每個交談指令必備以下四個功能
     CALL cl_on_idle()                           #idle、about、help、controlg
     CONTINUE CONSTRUCT

  ON ACTION about
     CALL cl_about()

  ON ACTION help
     CALL cl_show_help()

  ON ACTION controlg
     CALL cl_cmdask()



  END CONSTRUCT

  IF INT_FLAG THEN
      RETURN
  END IF
      {  ON ACTION controlp
           CASE
              WHEN INFIELD(ima06) #员工编号
                 CALL cl_init_qry_var()
                 LET g_qryparam.form ="cq_ima06"
                 CALL cl_create_qry() RETURNING g_qryparam.multiret
                 DISPLAY g_qryparam.multiret TO ima06
                 NEXT FIELD pmn04

              WHEN INFIELD(pmn04)
                CALL cl_init_qry_var()
                LET g_qryparam.form ="cq_pmn04"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO pmn04
                NEXT FIELD pmn041

              WHEN INFIELD(pmm09)
                CALL cl_init_qry_var()
                LET g_qryparam.form ="cq_pmm09"
                CALL cl_create_qry() RETURNING g_qryparam.multiret
                DISPLAY g_qryparam.multiret TO pmm09
                NEXT FIELD pmc03

              OTHERWISE EXIT CASE
           END CASE}

  IF cl_null(g_wc) THEN
     LET g_wc =' 1=1'
  END IF

  IF cl_null(g_wc1) THEN
     LET g_wc1 = '1=1'
  END IF



  LET g_sql="SELECT UNIQUE ima06,imz02,pmn04,pmn041,ima021,'','','','',''",
            " FROM ima_file,pmm_file,pmn_file,pmc_file,imz_file",
            " WHERE pmm01=pmn01 AND pmn04=ima01 AND pmm09=pmc01 AND ima06=imz01",
            " AND ",g_wc CLIPPED," AND ",#g_wc1 CLIPPED,
            " (pmn33 BETWEEN '",g_tmh.bdate,"' AND '",g_tmh.edate,"') ",
            " AND pmm18='Y'"
  {IF l_bdate OR l_edate THEN
  ELSE
      LET g_sql=g_sql," AND pmn33 between to_date('",l_bdate,
                  "','yyyy-mm-dd hh24:mi:ss') and to_date('",l_edate,
                  "','yyyy-mm-dd hh24:mi:ss')"
  END IF}
  PREPARE q021_prepare FROM g_sql
  DECLARE q021_cs
      SCROLL CURSOR WITH HOLD FOR q021_prepare

  LET g_sql="SELECT  COUNT(DISTINCT pmn04) ",
            " FROM ima_file,pmm_file,pmn_file,pmc_file",
            " WHERE pmm01=pmn01 AND pmn04=ima01 AND pmm09=pmc01",
            " AND ",g_wc CLIPPED," AND ",#g_wc1 CLIPPED,
            " (pmn33 BETWEEN '",g_tmh.bdate,"' AND '",g_tmh.edate,"')",
            " AND pmm18='Y'"
  {IF l_bdate OR l_edate THEN
  ELSE
      LET g_sql=g_sql," AND pmn33 between to_date('",l_bdate,
                  "','yyyy-mm-dd hh24:mi:ss') and to_date('",l_edate,
                  "','yyyy-mm-dd hh24:mi:ss')"
  END IF}
  PREPARE q021_precount FROM g_sql
  DECLARE q021_count CURSOR FOR q021_precount

END FUNCTION

FUNCTION q021_menu()

  WHILE TRUE
     CALL q021_bp("G")

     CASE g_action_choice
        WHEN "query"
          IF cl_chk_act_auth() THEN
             CALL q021_q()
          END IF

        WHEN "help"
          IF cl_chk_act_auth() THEN
             CALL cl_show_help()
          END IF

        WHEN "exit"
          EXIT WHILE

        WHEN "controlg"
          IF cl_chk_act_auth() THEN
             CALL cl_cmdask()
          END IF

        WHEN "output"
          IF cl_chk_act_auth() THEN
             IF cl_null(g_wc2) THEN LET g_wc2 = " 1=1" END IF

             LET g_msg='p_query "tqrcpm3630" "',g_wc2 CLIPPED,'"'
             CALL cl_cmdrun(g_msg)

          END IF

      END CASE

  END WHILE

END FUNCTION

FUNCTION q021_bp(p_ud)
  DEFINE		p_ud		LIKE type_file.chr1
  IF p_ud <> "G" OR g_action_choice = "detail" THEN
    RETURN
  END IF

  LET g_action_choice=" "

  CAll cl_set_act_visible("accept,cancel",FALSE)

  CALL cl_show_fld_cont()

  DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY g_pmn TO s_pmn.* ATTRIBUTE(COUNT=g_rec_b)

          BEFORE DISPLAY
              CALL cl_show_fld_cont()
              CALL cl_navigator_setting(g_curs_index,g_row_count)
              LET g_b_flag='1'

          BEFORE ROW
              LET l_ac = ARR_CURR()
              LET l_ac1 = l_ac
              CALL cl_show_fld_cont()
              LET g_tmc.ima06 = g_pmn[l_ac].ima06
              LET g_tmc.pmn04 = g_pmn[l_ac].pmn04
              CALL q021_b2_fill()
          AFTER DISPLAY
              CONTINUE DIALOG
      END DISPLAY

      DISPLAY ARRAY g_pmm TO s_pmm.* ATTRIBUTE(COUNT=g_rec_b2)
          BEFORE DISPLAY
              CALL cl_navigator_setting(g_curs_index,g_row_count)
              CALL cl_show_fld_cont()
              LET g_b_flag='2'

          BEFORE ROW
              LET l_ac = ARR_CURR()

          AFTER DISPLAY
              CONTINUE DIALOG
      END DISPLAY

      ON ACTION query
          LET g_action_choice = "query"
          EXIT DIALOG

      ON ACTION help
          LET g_action_choice = "help"
          EXIT DIALOG

      ON ACTION exit
          LET g_action_choice = "exit"
          EXIT DIALOG

      ON ACTION output
          LET g_action_choice = "output"
          EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG=FALSE                         #利用單身驅動menu時，cancel代表右上角的"X"
         LET g_action_choice="exit"
         EXIT DIALOG

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG

      ON ACTION about
         CALL cl_about()

      ON ACTION controls                            #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭區塊
         CALL cl_set_head_visible("","AUTO")

      ON ACTION controlg
          LET g_action_choice = "controlg"
          EXIT DIALOG
  END DIALOG
  CALL cl_set_act_visible("accept,cancel",TRUE)

END FUNCTION

FUNCTION q021_q()

   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting( g_curs_index, g_row_count )
   #INITIALIZE g_单头初始化
   INITIALIZE g_tmc.* TO NULL

   CALL cl_msg("")

   CALL cl_opmsg('q')
   CLEAR FORM

   CALL g_pmn.clear()
   CALL g_pmm.clear()

   DISPLAY '   ' TO FORMONLY.cnt

   CALL q021_cs()

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

   CALL cl_msg(" SEARCHING ! ")

   OPEN q021_cs

   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      #INITIALIZE g_cdg_h.* TO NULL单头初始化
   ELSE
      OPEN q021_count
      FETCH q021_count INTO g_row_count
      DISPLAY g_row_count TO FORMONLY.cnt
      #CALL t021_fetch('F')
      CALL q021_show()
   END IF
   CALL cl_msg("")

END FUNCTION

FUNCTION q021_b2_fill()

  LET g_wc2=" pmm01=pmn01 AND pmn04=ima01 AND ima06=imz01 AND pmm09=pmc01",
            " AND ima06='",g_tmc.ima06,"'",
            " AND pmn04='",g_tmc.pmn04, "' AND ",g_wc1 CLIPPED," ORDER BY pmn04"

  LET g_sql="SELECT ima06,imz02,pmn04,pmn041,ima021,pmm09,pmc03,pmc081,pmn01,pmn31t,pmn88t",
            " FROM ima_file,imz_file,pmn_file,pmm_file,pmc_file",
            " WHERE ",g_wc2 CLIPPED


  PREPARE q021_pb2 FROM g_sql
  DECLARE pmn_curs CURSOR FOR q021_pb2

  CALL g_pmm.clear()

  LET g_cnt = 1

  FOREACH pmn_curs INTO g_pmm[g_cnt].*
    IF STATUS THEN
        CALL cl_err('foreach.',STATUS,1)
        EXIT FOREACH
    END IF

    LET g_cnt=g_cnt+1
  END FOREACH
  CALL g_pmm.deleteElement(g_cnt)
  LET g_rec_b2 = g_cnt-1
  DISPLAY g_rec_b2 TO FORMONLY.cn4
END FUNCTION

FUNCTION q021_b_fill()

  LET g_cnt = 1
  FOREACH q021_cs INTO g_pmn[g_cnt].*
    IF STATUS THEN CALL cl_err('foreach.',STATUS,1) EXIT FOREACH END IF
    SELECT sum(pmn20),sum(pmn88t),min(pmn31t),max(pmn31t),avg(pmn31t)
      INTO g_pmn[g_cnt].pmn20,g_pmn[g_cnt].pmn88t,g_pmn[g_cnt].lowestpmn31t,g_pmn[g_cnt].mostpmn31t,g_pmn[g_cnt].averagepmn31t
      FROM ima_file,pmn_file
      WHERE ima01=pmn04 and ima06=g_pmn[g_cnt].ima06 AND pmn04=g_pmn[g_cnt].pmn04

    LET g_cnt = g_cnt + 1
    IF g_cnt > g_max_rec THEN
       CALL cl_err( '', 9035, 0 )
       EXIT FOREACH
    END IF
  END FOREACH

  CALL g_pmn.deleteElement(g_cnt)
  LET g_rec_b = g_cnt-1

  IF g_cnt>0 THEN
      LET g_tmc.ima06=g_pmn[1].ima06
      LET g_tmc.pmn04=g_pmn[1].pmn04
  END IF

END FUNCTION


FUNCTION q021_show()


  CALL q021_b_fill()
  CALL q021_b2_fill()
END FUNCTION
