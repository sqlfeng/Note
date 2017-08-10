# Prog. Version..: '5.30.06-13.04.25(00004)'     #
#
# Pattern name.... saxct322.4gl
# Descriptions.... 销货成本分录结转作业
# Date & Author... 2010/07/09 By elva #No.FUN-AA0025
# Modify.........: No:FUN-B30211 11/03/31 By lixiang  加cl_used(g_prog,g_time,2)
# Modify.........: No:FUN-B40056 11/05/13 By guoch  刪除資料時一併刪除tic_file的資料
# Modify.........: No:FUN-BB0038 11/11/18 By elva 成本改善
# Modify.........: No.CHI-C30107 12/06/12 By yuhuabao  整批修改將確認的詢問窗口放到chk段的前面
# Modify.........: No.FUN-C80009 12/08/07 By elva 串查改善
# Modify.........: No.FUN-C80094 12/10/16 By minpp 将axct322改为销货成本分录（cdj00='1'）和发出商品转出分录(cdj00='3')共同调用的作业，通过cdj00区分
# Modify.........: No.FUN-C80094 12/10/16 By xuxz axct330功能修改
# Modify.........: No.FUN-C80094 12/10/16 By minpp axct331调用该程式时，cdj09动态显示为发出商品科目
# Modify.........: No.FUN-CC0001 13/02/05 By wujie 增加串查凭证资料
# Modify.........: No.TQC-D20046 13/02/27 By qiull chenjing 修改發出商品測試問題
# Modify.........: No:FUN-D40030 13/04/09 By xumm 修改單身新增時按下放棄鍵未執行AFTER INSERT的問題
# Modify.........: No:FUN-D60095 13/06/24 By max1 增加傳參
# Modify.........: No:FUN-D60081 13/06/24 By lujh 增加excel匯出功能,修改查詢時程序down出的問題
# Modify.........: No:FUN-D90054 13/09/17 By yangtt axct332增加【銷貨成本】前加【銷售數量】(cdj10)欄位
# Modify.........: No:TQC-DB0065 13/11/26 By yuhuabao OPEN t322_b2cl處USING用值加上項次cdj17

DATABASE ds
 
#GLOBALS "../../config/top.global"
GLOBALS "../../../tiptop/config/top.global"   #mod by lili 151210
 
#No.FUN-AA0025
#模組變數(Module Variables)
DEFINE
    g_cdj_h         RECORD LIKE cdj_file.*,    #(假單頭)
    g_cdj           DYNAMIC ARRAY OF RECORD    #程式變數(Program Variables)
        #FUN-BB0038 --begin
        cdj17            LIKE cdj_file.cdj17,
        cdj14            LIKE cdj_file.cdj14,
        cdj142           LIKE cdj_file.cdj142,
        cdj15            LIKE cdj_file.cdj15,
        gem02            LIKE gem_file.gem02,
        #FUN-BB0038 --end
        cdj05            LIKE cdj_file.cdj05,
        cdj06            LIKE cdj_file.cdj06,
        ima02            LIKE ima_file.ima02,
        cdj07            LIKE cdj_file.cdj07,
        azf03            LIKE azf_file.azf03,
        cdj08            LIKE cdj_file.cdj08,  
        aag02            LIKE aag_file.aag02,
        cdj09            LIKE cdj_file.cdj09,
        aag021           LIKE aag_file.aag02,
        cdj10            LIKE cdj_file.cdj10,
        cdj11            LIKE cdj_file.cdj11,
        cdj12            LIKE cdj_file.cdj12
                    END RECORD,
    g_cdj_t         RECORD                 #程式變數 (舊值)
        #FUN-BB0038 --begin
        cdj17            LIKE cdj_file.cdj17,
        cdj14            LIKE cdj_file.cdj14,
        cdj142           LIKE cdj_file.cdj142,
        cdj15            LIKE cdj_file.cdj15,
        gem02            LIKE gem_file.gem02,
        #FUN-BB0038 --end
        cdj05            LIKE cdj_file.cdj05,
        cdj06            LIKE cdj_file.cdj06,
        ima02            LIKE ima_file.ima02,
        cdj07            LIKE cdj_file.cdj07,
        azf03            LIKE azf_file.azf03,
        cdj08            LIKE cdj_file.cdj08,  
        aag02            LIKE aag_file.aag02,
        cdj09            LIKE cdj_file.cdj09,
        aag021           LIKE aag_file.aag02,
        cdj10            LIKE cdj_file.cdj10,
        cdj11            LIKE cdj_file.cdj11,
        cdj12            LIKE cdj_file.cdj12
                    END RECORD,

    g_wcg_sql           string,  #No.FUN-580092 HCN
    g_rec_b             LIKE type_file.num5,            #單身筆數  #No.FUN-690028 SMALLINT
    m_cdj               RECORD LIKE cdj_file.*,
    l_ac,l_ac1          LIKE type_file.num5                 #目前處理的ARRAY CNT  #No.FUN-690028 SMALLINT
 
 
#主程式開始
DEFINE  g_forupd_sql STRING   #SELECT ... FOR UPDATE SQL
DEFINE  g_before_input_done  LIKE type_file.num5    #No.FUN-690028 SMALLINT
DEFINE  g_cnt           LIKE type_file.num10   #No.FUN-690028 INTEGER
DEFINE  g_str           STRING     #No.FUN-670060
DEFINE  g_msg           LIKE type_file.chr1000 #No.FUN-690028 VARCHAR(72) 
DEFINE  g_row_count     LIKE type_file.num10   #No.FUN-690028 INTEGER
DEFINE  g_curs_index    LIKE type_file.num10   #No.FUN-690028 INTEGER
DEFINE  g_jump          LIKE type_file.num10   #No.FUN-690028 INTEGER
DEFINE  mi_no_ask       LIKE type_file.num5    #No.FUN-690028 SMALLINT                                                                
DEFINE  g_wc,g_sql      string 
DEFINE  g_nppglno       LIKE npp_file.nppglno
DEFINE  g_cdj00         LIKE cdj_file.cdj00      #FUN-C80094
DEFINE  g_wc1           STRING    #FUN-D60095  add
 
#MAIN
FUNCTION t322(p_argv1)       #FUN-C80094
DEFINE l_time           LIKE type_file.chr8           
DEFINE p_row,p_col      LIKE type_file.num5 
DEFINE p_argv1          LIKE cdj_file.cdj00   #FUN-C80094
   #FUN-C80094--MARK--STR
   #OPTIONS                              
   #   INPUT NO WRAP                    
   #DEFER INTERRUPT                    

   #IF (NOT cl_user()) THEN
   #   EXIT PROGRAM
   #END IF
  
  # WHENEVER ERROR CONTINUE            
    
   #IF (NOT cl_setup("AXC")) THEN
   #   EXIT PROGRAM
   #END IFR
   #FUN-C80094--MARK--end
   
#   CALL cl_used(g_prog,l_time,1)       
#      RETURNING l_time

   #FUN-D60095--add--str--
   LET g_wc1 = ARG_VAL(1)
   LET g_wc1 = cl_replace_str(g_wc1, "\\\"", "'")
   #FUN-D60095--add--end--

   WHENEVER ERROR CALL cl_err_msg_log  #FUN-C80094
#  CALL cl_used(g_prog,g_time,1) RETURNING g_time #No.FUN-B30211  #FUN-C80094
   LET g_cdj00 = p_argv1                                         #FUN-C80094
   LET g_forupd_sql = "SELECT * FROM cdj_file WHERE  cdj00='",g_cdj00,"' AND cdj01 = ? AND cdj02 = ? AND cdj03 = ? AND cdj04 = ? FOR UPDATE"  #FUN-C80094-ADD--cdj00
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t322_cl CURSOR FROM g_forupd_sql

   LET p_row = 2 LET p_col = 9

   OPEN WINDOW t322_w AT p_row,p_col WITH FORM "axc/42f/axct322"
     ATTRIBUTE (STYLE = g_win_style CLIPPED)

   CALL cl_ui_init()


   IF p_argv1 = '1' THEN  #FUN-D90054
      CALL cl_set_comp_visible("cdj11",FALSE)  #FUN-D90054 add
   ELSE    #FUN-D90054 add
      CALL cl_set_comp_visible("cdj10,cdj11",FALSE)  #FUN-BB0038
   END IF  #FUN-D90054 add
   #FUN-C80094--add--str
   IF g_cdj00 = '2' THEN 
      CALL cl_set_comp_visible("cdj17,cdj14,cdj142,cdj07,azf03",FALSE)
      LET g_msg = cl_getmsg("axc-305",g_lang)
      CALL cl_set_comp_att_text("cdj08",g_msg)
   END IF 
   #FUN-C80094--add--end
 
   #FUN-C80094--minpp--12/09/06--str
   IF g_cdj00 = '3' THEN
      LET g_msg = cl_getmsg("axc-305",g_lang)
      CALL cl_set_comp_att_text("cdj09",g_msg)
   END IF
   #FUN-C80094--minpp--12/09/06--end

   #FUN-D60095--add--str--
   IF NOT cl_null(g_wc1) THEN
      CALL t322_q()
   END IF
   #FUN-D60095--add--end--

   CALL t322_menu()
   CLOSE WINDOW t322_w               

#   CALL cl_used(g_prog,l_time,2)       
#      RETURNING l_time
#   CALL cl_used(g_prog,g_time,2) RETURNING g_time #No.FUN-B30211  #FUN-C80094
#END MAIN   #FUN-C80094
END FUNCTION    #FUN-C80094

#QBE 查詢資料
FUNCTION t322_cs()
DEFINE   l_type      LIKE apa_file.apa00    
DEFINE   l_dbs       LIKE type_file.chr21  
DEFINE   lc_qbe_sn   LIKE gbm_file.gbm01  
 
   CLEAR FORM                             #清除畫面
   CALL g_cdj.clear()

 
      CALL cl_set_head_visible("","YES")          
      INITIALIZE g_cdj_h.* TO NULL    
       IF cl_null(g_wc1) THEN  #FUN-D60095 add 
      DIALOG ATTRIBUTES(UNBUFFERED) 
         CONSTRUCT BY NAME g_wc ON cdj04,cdj01,cdjlegal,cdj02,cdj03,cdj13
         BEFORE CONSTRUCT
             CALL cl_qbe_init()                    
         END CONSTRUCT  

         ON ACTION CONTROLP
            CASE
               WHEN INFIELD(cdj01) 
                  CALL cl_init_qry_var()
                  LET g_qryparam.state = "c"
                  LET g_qryparam.form ="q_cdj"
                  CALL cl_create_qry() RETURNING g_qryparam.multiret
                  DISPLAY g_qryparam.multiret TO cdj01
                  NEXT FIELD cdj01
               OTHERWISE EXIT CASE
            END CASE
         
         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG
         
         ON ACTION about         #MOD-4C0121
            CALL cl_about()      #MOD-4C0121
         
         ON ACTION help          #MOD-4C0121
            CALL cl_show_help()  #MOD-4C0121
         
         ON ACTION controlg      #MOD-4C0121
            CALL cl_cmdask()     #MOD-4C0121
         
         ON ACTION qbe_select
            CALL cl_qbe_list() RETURNING lc_qbe_sn
            CALL cl_qbe_display_condition(lc_qbe_sn)
         ON ACTION accept
               EXIT DIALOG
         
         ON ACTION EXIT
            LET INT_FLAG = TRUE
            EXIT DIALOG 
          
         ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG 
      END DIALOG  
      END IF    #FUN-D60095 add
 
   IF cl_null(g_wc) THEN
      LET g_wc =' 1=1' 
   END IF  

   #FUN-D60095--add--str--
   IF cl_null(g_wc1) THEN
      LET g_wc1 = '1=1'
   END IF
   #FUN-D60095--add--end--
 
   LET g_sql = "SELECT UNIQUE cdj01,cdj02,cdj03,cdj04 ",
               "  FROM cdj_file",
               " WHERE  ", g_wc CLIPPED,
               "    AND cdj00='",g_cdj00,"'",            #FUN-C80094
               "   AND ", g_wc1 CLIPPED,    #FUN-D60095 add
               " ORDER BY 1,2,3,4"

 
   PREPARE t322_prepare FROM g_sql
   DECLARE t322_cs                         #SCROLL CURSOR
       SCROLL CURSOR WITH HOLD FOR t322_prepare
 
END FUNCTION

FUNCTION t322_menu()
DEFINE l_ccz12    LIKE ccz_file.ccz12
DEFINE l_npptype  LIKE npp_file.npptype
 
   WHILE TRUE
      CALL t322_bp("G")
      CASE g_action_choice 
         WHEN "query"
            IF cl_chk_act_auth() THEN
               LET g_wc1 = NULL   #FUN-D60095 add
               CALL t322_q()
            END IF
 
         WHEN "delete"
            IF cl_chk_act_auth() THEN
               CALL t322_r()
            END IF
 
         WHEN "help"
            CALL cl_show_help()
 
         WHEN "exit"
            EXIT WHILE
 
         WHEN "controlg"
            CALL cl_cmdask()
 
         WHEN "detail" 
            CALL t322_b()

         WHEN "gen_entry"
            CALL t322_v()
 
         WHEN "entry_sheet" 
            SELECT ccz12 INTO l_ccz12 FROM ccz_file 
            IF g_cdj_h.cdj01 = l_ccz12 THEN 
               LET l_npptype =0
            ELSE
               LET l_npptype =1
            END IF            
            CALL s_fsgl('CA',4,g_cdj_h.cdj13,0,g_cdj_h.cdj01,'1',g_cdj_h.cdjconf,l_npptype,g_cdj_h.cdj13)  

         WHEN "drill_down1"
            IF cl_chk_act_auth() THEN
               CALL t322_drill_down()
            END IF

         WHEN "confirm"
            CALL t322_firm1_chk()                     
            IF g_success = "Y" THEN
               CALL t322_firm1_upd()                   
            END IF
            CALL t322_show()         
         WHEN "undo_confirm" 
            CALL t322_firm2()
            CALL t322_show()
         WHEN "process_qry"  
            #FUN-C80094-add--str
            IF g_cdj00 = '2' THEN 
               CALL cl_cmdrun_wait("axcp330")
            END IF  
            IF g_cdj00 = '3' THEN
               CALL cl_cmdrun_wait("axcp331")
            END IF
            IF g_cdj00 = '1' THEN
            #FUN-C80094--add--end
               CALL cl_cmdrun_wait("axcp322")
            END IF #FUN-C80094 add
         WHEN "carry_voucher"
            IF g_cdj_h.cdjconf ='Y' THEN
               LET g_msg ="axcp301 ",g_cdj_h.cdj13," '' '' '' ",
                          "'' '' '' 'N' '' ''"
               CALL cl_wait()
               CALL cl_cmdrun_wait(g_msg)
               ERROR ""                              #TQC-D20046---qiull---add---
               SELECT nppglno INTO g_nppglno FROM npp_file WHERE npp01 = g_cdj_h.cdj13 AND nppsys ='CA' AND npp00 =4 AND npp011 =1
               DISPLAY g_nppglno TO nppglno
            END IF


         WHEN "undo_carry_voucher"
            IF cl_null(g_nppglno) THEN EXIT CASE END IF
            LET g_msg ="axcp302 '",g_plant,"' '",g_cdj_h.cdj01,"' '",g_nppglno CLIPPED,"' 'Y'"
            CALL cl_wait()
            CALL cl_cmdrun_wait(g_msg)
            ERROR ""                              #TQC-D20046---qiull---add---
            SELECT nppglno INTO g_nppglno FROM npp_file WHERE npp01 = g_cdj_h.cdj13 AND nppsys ='CA' AND npp00 =4 AND npp011 =1
            DISPLAY g_nppglno TO nppglno

#No.FUN-CC0001 --begin
         WHEN "voucher_qry"
            IF cl_null(g_nppglno) THEN EXIT CASE END IF
            CALL s_voucher_qry(g_nppglno)
#No.FUN-CC0001 --end
         #FUN-D60081--add--str--
         WHEN "exporttoexcel"                       #單身匯出最多可匯三個Table資料
            IF cl_chk_act_auth() THEN
              CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(g_cdj),'','')
            END IF
         #FUN-D60081--add--end--

      END CASE
   END WHILE
END FUNCTION
 
FUNCTION t322_q()
 
    LET g_row_count = 0
    LET g_curs_index = 0
    CALL cl_navigator_setting( g_curs_index, g_row_count )
    INITIALIZE g_cdj_h.* TO NULL               
 
   CALL cl_msg("")                          
 
   CALL cl_opmsg('q')
   CLEAR FORM
   CALL g_cdj.clear()
   DISPLAY '   ' TO FORMONLY.cnt
   CALL t322_cs()
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF
   CALL cl_msg(" SEARCHING ! ")              #FUN-640240
 
   OPEN t322_cs                              #從DB產生合乎條件TEMP(0-30秒)
   IF SQLCA.sqlcode THEN
      CALL cl_err('',SQLCA.sqlcode,0)
      INITIALIZE g_cdj_h.* TO NULL
   ELSE
      CALL t322_count()
      DISPLAY g_row_count TO FORMONLY.cnt
      CALL t322_fetch('F')                  # 讀出TEMP第一筆並顯示
   END IF
   CALL cl_msg("")                              #FUN-640240
 
END FUNCTION
 
#處理資料的讀取
FUNCTION t322_fetch(p_flag)
DEFINE
   p_flag          LIKE type_file.chr1                  #處理方式  #No.FUN-690028 VARCHAR(1)
 
   CASE p_flag
      WHEN 'N' FETCH NEXT     t322_cs INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04
      WHEN 'P' FETCH PREVIOUS t322_cs INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04
      WHEN 'F' FETCH FIRST    t322_cs INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04
      WHEN 'L' FETCH LAST     t322_cs INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04
      WHEN '/'
         IF NOT mi_no_ask THEN
            CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
            LET INT_FLAG = 0
            PROMPT g_msg CLIPPED,'. ' FOR g_jump
               ON IDLE g_idle_seconds
                  CALL cl_on_idle()
 
               ON ACTION about         #MOD-4C0121
                  CALL cl_about()      #MOD-4C0121
 
               ON ACTION help          #MOD-4C0121
                  CALL cl_show_help()  #MOD-4C0121
 
               ON ACTION controlg      #MOD-4C0121
                  CALL cl_cmdask()     #MOD-4C0121
 
            END PROMPT
            IF INT_FLAG THEN LET INT_FLAG = 0 EXIT CASE END IF
         END IF
         FETCH ABSOLUTE g_jump t322_cs INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04  #TQC-D20046 cj add
         LET mi_no_ask = FALSE
   END CASE
 
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_cdj_h.cdj01,SQLCA.sqlcode,0)
      INITIALIZE g_cdj_h.* TO NULL  #TQC-6B0105
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
   SELECT  DISTINCT cdj01,cdj02,cdj03,cdj04,cdj13,cdjlegal,cdjconf
     INTO g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04,g_cdj_h.cdj13,g_cdj_h.cdjlegal,g_cdj_h.cdjconf
     FROM  cdj_file 
    WHERE cdj00 = g_cdj00 AND cdj01 = g_cdj_h.cdj01    #FUN-C80094
      AND cdj02 = g_cdj_h.cdj02 AND cdj03 = g_cdj_h.cdj03 AND cdj04 = g_cdj_h.cdj04 
   IF SQLCA.sqlcode THEN
      CALL cl_err3("sel","cdj_file",g_cdj_h.cdj01,"",SQLCA.sqlcode,"","",1)  
      INITIALIZE g_cdj_h.* TO NULL
      RETURN
   ELSE   
      CALL t322_show()
   END IF
END FUNCTION
 
#將資料顯示在畫面上
FUNCTION t322_show()
DEFINE l_azt02    LIKE azt_file.azt02

   DISPLAY BY NAME g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04,
          g_cdj_h.cdj13,g_cdj_h.cdjlegal,g_cdj_h.cdjconf
   SELECT azt02 INTO l_azt02 FROM azt_file WHERE azt01 = g_cdj_h.cdjlegal
   SELECT nppglno INTO g_nppglno FROM npp_file WHERE npp01 = g_cdj_h.cdj13 AND nppsys ='CA' AND npp00 =4 AND npp011 =1
   CALL cl_set_field_pic(g_cdj_h.cdjconf,"","","","","")
   DISPLAY l_azt02 TO azt02
   DISPLAY g_nppglno TO nppglno       
   CALL t322_b_fill()                 #單身
END FUNCTION
 
#取消整筆 (所有合乎單頭的資料)
FUNCTION t322_r()
DEFINE l_cnt            LIKE type_file.num5       
 
   IF NOT cl_null(g_nppglno) THEN CALL cl_err('','afa-973',1) RETURN END IF 
   IF g_cdj_h.cdj01 IS NULL THEN CALL cl_err("",-400,0) RETURN END IF
   IF g_cdj_h.cdjconf = 'Y' THEN
      CALL cl_err('','aap-086',0)
      RETURN
   END IF
   LET g_success = 'Y'
   BEGIN WORK
   OPEN t322_cl USING g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04 
   IF STATUS THEN
      CALL cl_err("OPEN t322_cl.", STATUS, 1)
      CLOSE t322_cl
      ROLLBACK WORK
      RETURN
   END IF
   FETCH t322_cl INTO g_cdj_h.*               # 鎖住將被更改或取消的資料
   IF SQLCA.sqlcode THEN
      CALL cl_err(g_cdj_h.cdj01,SQLCA.sqlcode,0)          #資料被他人LOCK
      ROLLBACK WORK
      RETURN
   END IF
   CALL t322_show()
   IF cl_delh(0,0) THEN                   #確認一下
      INITIALIZE g_doc.* TO NULL          #No.FUN-9B0098 10/02/24
      LET g_doc.column1 = "cdj01"         #No.FUN-9B0098 10/02/24
      LET g_doc.value1 =  g_cdj_h.cdj01      #No.FUN-9B0098 10/02/24
      CALL cl_del_doc()                #No.FUN-9B0098 10/02/24
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt 
        FROM cdj_file
       WHERE cdj00 = g_cdj00               #FUN-C80094
         AND cdj01 = g_cdj_h.cdj01 
         AND cdj02 = g_cdj_h.cdj02
         AND cdj03 = g_cdj_h.cdj03
         AND cdj04 = g_cdj_h.cdj04
      IF l_cnt > 0 THEN
         DELETE FROM cdj_file 
          WHERE cdj00 = g_cdj00               #FUN-C80094
            AND cdj01 = g_cdj_h.cdj01
            AND cdj02 = g_cdj_h.cdj02
            AND cdj03 = g_cdj_h.cdj03
            AND cdj04 = g_cdj_h.cdj04
            
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN   #CHI-850023
            CALL cl_err3("del","cdj_file",g_cdj_h.cdj01,"",SQLCA.sqlcode,"","del cdj.",1)  #No.FUN-660122
            ROLLBACK WORK
            RETURN
         END IF
      END IF   #MOD-870048 add

      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM npp_file
       WHERE npp01 = g_cdj_h.cdj13
         AND nppsys= 'CA'
         AND npp00 = 4
         AND npp011= 1
      IF l_cnt > 0 THEN
         DELETE FROM npp_file
          WHERE npp01 = g_cdj_h.cdj13
            AND nppsys= 'CA'
            AND npp00 = 4
            AND npp011= 1
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN   #CHI-850023
            CALL cl_err3("del","npp_file",g_cdj_h.cdj01,"",SQLCA.sqlcode,"","del npp.",1)  #No.FUN-660122
            ROLLBACK WORK
            RETURN
         END IF
      END IF   #MOD-870048 add
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM npq_file
       WHERE npq01 = g_cdj_h.cdj13
         AND npqsys= 'CA'
         AND npq00 = 4
         AND npq011= 1
      IF l_cnt > 0 THEN
         DELETE FROM npq_file
          WHERE npq01 = g_cdj_h.cdj13
            AND npqsys= 'CA'
            AND npq00 = 4
            AND npq011= 1
         IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN   #CHI-850023
            CALL cl_err3("del","npq_file",g_cdj_h.cdj01,"",SQLCA.sqlcode,"","del npq.",1)  #No.FUN-660122
            ROLLBACK WORK
            RETURN
         END IF
      END IF   #MOD-870048 add
      #FUN-B40056  --begin
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt FROM tic_file
       WHERE tic04 = g_cdj_h.cdj13
      IF l_cnt > 0 THEN
         DELETE FROM tic_file
          WHERE tic04 = g_cdj_h.cdj13
         IF SQLCA.sqlcode THEN
            CALL cl_err3("del","tic_file",g_cdj_h.cdj13,"",SQLCA.sqlcode,"","del tic.",1)
            ROLLBACK WORK
            RETURN
         END IF
      END IF
      #FUN-B40056  --end
      INITIALIZE g_cdj_h.* TO NULL
      CLEAR FORM
      CALL g_cdj.clear()
 #TQC-D20046--cj--mark--
 #    CALL t322_count()      
 #    DISPLAY g_row_count TO FORMONLY.cnt
 #    OPEN t322_cs
 #    IF g_curs_index = g_row_count + 1 THEN
 #       LET g_jump = g_row_count
 #       CALL t322_fetch('L')
 #    ELSE
 #       LET g_jump = g_curs_index
 #       LET mi_no_ask = TRUE
 #       CALL t322_fetch('/')
 #    END IF
 #TQC-D20046--cj--mark--
   END IF
   CLOSE t322_cl
   IF g_success = 'Y' THEN
      COMMIT WORK
      CALL cl_flow_notify(g_cdj_h.cdj01,'D')
     #TQC-D20046--add--str
      CALL t322_count()
      DISPLAY g_row_count TO FORMONLY.cnt
      OPEN t322_cs
      IF g_row_count >= 1 THEN          #TQC-D20046--cj--add
         IF g_curs_index = g_row_count + 1 THEN
            LET g_jump = g_row_count
         ELSE
            LET g_jump = g_curs_index
         END IF
         LET mi_no_ask = TRUE#TQC-D20046--cj--add
         CALL t322_fetch('/')#TQC-D20046--cj--add
      END IF
     #TQC-D20046--add--end
   ELSE
      ROLLBACK WORK
   END IF
END FUNCTION
  
FUNCTION t322_b()
DEFINE l_ac_t          LIKE type_file.num5,     #未取消的ARRAY CNT  #No.FUN-690028 SMALLINT
       l_n             LIKE type_file.num5,     #檢查重複用  #No.FUN-690028 SMALLINT
       l_lock_sw       LIKE type_file.chr1,     #單身鎖住否  #No.FUN-690028 VARCHAR(1)
       p_cmd           LIKE type_file.chr1,     #處理狀態  #No.FUN-690028 VARCHAR(1)
       l_exit_sw       LIKE type_file.chr1,     #No.FUN-690028 VARCHAR(1)
       l_allow_insert  LIKE type_file.num5,     #可新增否  #No.FUN-690028 SMALLINT
       l_allow_delete  LIKE type_file.num5,     #可刪除否  #No.FUN-690028 SMALLINT
       l_cnt           LIKE type_file.num5      #MOD-650097  #No.FUN-690028 SMALLINT
       

   LET g_action_choice = ""
   IF g_cdj_h.cdj01 IS NULL THEN RETURN END IF
   IF g_cdj_h.cdjconf = 'Y' THEN
      CALL cl_err('','aap-086',0)
      RETURN
   END IF

   CALL cl_opmsg('b')
 
   LET g_forupd_sql = "SELECT cdj17,cdj14,cdj142,cdj15,'',cdj05,cdj06,'',cdj07,'',cdj08,'',cdj09,'',cdj10,cdj11,cdj12", #FUN-BB0038
                      " FROM cdj_file",
                      " WHERE cdj00='",g_cdj00,"' AND cdj01=? AND cdj02=? AND cdj03 = ? AND cdj04 = ? AND cdj05 = ? AND cdj06 = ? AND cdj17 = ? FOR UPDATE"  #FUN-C80094 add--cdj00  #TQC-DB0065 add cdj17
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE t322_b2cl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
   LET l_exit_sw = 'y'
   INPUT ARRAY g_cdj WITHOUT DEFAULTS FROM s_cdj.*
         ATTRIBUTE(COUNT=g_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                   INSERT ROW=TRUE,DELETE ROW=FALSE,APPEND ROW=FALSE)
 
       BEFORE INPUT
           IF g_rec_b != 0 THEN
              CALL fgl_set_arr_curr(l_ac)
           END IF
 
       BEFORE ROW
          LET p_cmd=''
          LET l_ac = ARR_CURR()
          LET l_lock_sw = 'N'            #DEFAULT
          LET l_n  = ARR_COUNT()
          BEGIN WORK
          LET g_success = 'Y'
          IF g_rec_b >= l_ac THEN
             LET p_cmd='u'
             LET g_cdj_t.* = g_cdj[l_ac].*  #BACKUP
             OPEN t322_b2cl USING g_cdj_h.cdj01,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj04,g_cdj_t.cdj05,g_cdj_t.cdj06
                                 ,g_cdj_t.cdj17 #TQC-DB0065 add
             IF STATUS THEN
                CALL cl_err("OPEN t322_b2cl.", STATUS, 1)
                LET l_lock_sw = "Y"
             END IF
             FETCH t322_b2cl INTO g_cdj[l_ac].*
             IF SQLCA.sqlcode THEN
                CALL cl_err(g_cdj_h.cdj02,SQLCA.sqlcode,1)
                LET l_lock_sw = "Y"
             END IF 
             SELECT gem02 INTO g_cdj[l_ac].gem02 FROM gem_file WHERE gem01 = g_cdj[l_ac].cdj15 #FUN-BB0038
             SELECT ima02 INTO g_cdj[l_ac].ima02 FROM ima_file WHERE ima01 = g_cdj[l_ac].cdj06
             SELECT azf03 INTO g_cdj[l_ac].azf03 FROM azf_file WHERE azf01 = g_cdj[l_ac].cdj07 AND azf02='2'  #FUN-BB0038
             SELECT aag02 INTO g_cdj[l_ac].aag02 FROM aag_file WHERE aag01 = g_cdj[l_ac].cdj08 AND aag00 = g_cdj_h.cdj01
             SELECT aag02 INTO g_cdj[l_ac].aag021 FROM aag_file WHERE aag01 = g_cdj[l_ac].cdj09 AND aag00 = g_cdj_h.cdj01
             NEXT FIELD cdj08
          END IF

       BEFORE INSERT  
       
       AFTER INSERT 
         
       AFTER FIELD cdj08           
          IF g_cdj[l_ac].cdj08 IS NULL THEN
             LET g_cdj[l_ac].cdj08 = g_cdj_t.cdj08
             NEXT FIELD cdj08
          END IF
          IF g_cdj_t.cdj08 IS NULL OR g_cdj[l_ac].cdj08 <> g_cdj_t.cdj08 THEN 
             CALL t322_aag02(g_cdj[l_ac].cdj08) RETURNING g_cdj[l_ac].aag02
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_cdj[l_ac].cdj08,g_errno,0)
                LET g_cdj[l_ac].cdj08=g_cdj_t.cdj08
                LET g_cdj[l_ac].aag02=g_cdj_t.aag02
                NEXT FIELD cdj08
             END IF
          END IF 
          
       AFTER FIELD cdj09           
          IF g_cdj[l_ac].cdj09 IS NULL THEN
             LET g_cdj[l_ac].cdj09 = g_cdj_t.cdj09
             NEXT FIELD cdj09
          END IF
          IF g_cdj_t.cdj09 IS NULL OR g_cdj[l_ac].cdj09 <> g_cdj_t.cdj09 THEN 
             CALL t322_aag02(g_cdj[l_ac].cdj09) RETURNING g_cdj[l_ac].aag021
             IF NOT cl_null(g_errno) THEN
                CALL cl_err(g_cdj[l_ac].cdj09,g_errno,0)
                LET g_cdj[l_ac].cdj09=g_cdj_t.cdj09
                LET g_cdj[l_ac].aag021=g_cdj_t.aag021
                NEXT FIELD cdj09
             END IF
          END IF 
 

       AFTER ROW
          LET l_ac = ARR_CURR()
         #LET l_ac_t = l_ac      #FUN-D40030 Mark
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             #FUN-D40030--add--str--
             IF p_cmd = 'u' THEN
                LET g_cdj[l_ac].* = g_cdj_t.*
             ELSE
                CALL g_cdj.deleteElement(l_ac)
                IF g_rec_b != 0 THEN
                   LET g_action_choice = "detail"
                   LET l_ac = l_ac_t
                END IF
             END IF
             #FUN-D40030--add--end--
             CLOSE t322_b2cl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          LET l_ac_t = l_ac      #FUN-D40030 Add
          CLOSE t322_b2cl
          COMMIT WORK

 
       ON ROW CHANGE
          IF INT_FLAG THEN
             CALL cl_err('',9001,0)
             LET INT_FLAG = 0
             LET g_cdj[l_ac].* = g_cdj_t.*
             CLOSE t322_b2cl
             ROLLBACK WORK
             EXIT INPUT
          END IF
          IF l_lock_sw = 'Y' THEN
             CALL cl_err(g_cdj[l_ac].cdj06,-263,1)
             LET g_cdj[l_ac].* = g_cdj_t.*
          ELSE  
             UPDATE cdj_file SET cdj08 = g_cdj[l_ac].cdj08,
                                 cdj09 = g_cdj[l_ac].cdj09
              WHERE cdj00 = g_cdj00                      #FUN-C80094
                AND cdj01 = g_cdj_h.cdj01 
                AND cdj02 = g_cdj_h.cdj02
                AND cdj03 = g_cdj_h.cdj03
                AND cdj04 = g_cdj_h.cdj04 
                AND cdj05 = g_cdj_t.cdj05 
                AND cdj06 = g_cdj_t.cdj06

             IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN   #CHI-850023
                CALL cl_err3("upd","cdj_file",g_cdj_h.cdj01,g_cdj_h.cdj02,SQLCA.sqlcode,"","",1)  #No.FUN-660122
                LET g_cdj[l_ac].* = g_cdj_t.*
                ROLLBACK WORK
             ELSE
                MESSAGE 'UPDATE O.K'
                IF g_success='Y' THEN
                   COMMIT WORK
                ELSE
                   ROLLBACK WORK
                END IF
             END IF
          END IF

       ON ACTION CONTROLP
          IF INFIELD(cdj08) THEN 
             CALL cl_init_qry_var()
             LET g_qryparam.form ="q_aag02"   
             LET g_qryparam.arg1 = g_cdj_h.cdj01
             #FUN-C80094--add-s-tr
             IF g_cdj00 = '2' THEN 
                LET g_qryparam.where = "aag09 ='Y'"
             END IF
             #FUN-C80094--add--end
             LET g_qryparam.default1 = g_cdj[l_ac].cdj08
             CALL cl_create_qry() RETURNING g_cdj[l_ac].cdj08
             DISPLAY g_cdj[l_ac].cdj08 TO cdj08
             NEXT FIELD cdj08
          END IF  
          IF INFIELD(cdj09) THEN 
             CALL cl_init_qry_var()
             LET g_qryparam.form ="q_aag02"   
             LET g_qryparam.arg1 = g_cdj_h.cdj01
             #FUN-C80094--add-s-tr
             IF g_cdj00 = '2' THEN 
                LET g_qryparam.where = "aag09 ='Y'"
             END IF
             #FUN-C80094--add--end
             LET g_qryparam.default1 = g_cdj[l_ac].cdj09
             CALL cl_create_qry() RETURNING g_cdj[l_ac].cdj09
             DISPLAY g_cdj[l_ac].cdj09 TO cdj09
             NEXT FIELD cdj09
          END IF  
 
       ON ACTION CONTROLR
          CALL cl_show_req_fields()
 
       ON ACTION CONTROLG
          CALL cl_cmdask()
 
       ON ACTION CONTROLF
 
       ON IDLE g_idle_seconds
 
       ON ACTION about         #MOD-4C0121
          CALL cl_about()      #MOD-4C0121
 
       ON ACTION help          #MOD-4C0121
          CALL cl_show_help()  #MOD-4C0121
  
   END INPUT
  
   CLOSE t322_b2cl
 
END FUNCTION


 
FUNCTION t322_b_fill()
    
 
   LET g_sql =  "SELECT cdj17,cdj14,cdj142,cdj15,'',cdj05,cdj06,'',cdj07,'',cdj08,'',cdj09,'',cdj10,cdj11,cdj12 ", #FUN-BB0038
                "  FROM cdj_file",
                " WHERE cdj00 ='",g_cdj00,"'" ,      #FUN-C80094    
                "   AND cdj01 ='",g_cdj_h.cdj01,"'",
                "   AND cdj02 ='",g_cdj_h.cdj02,"'",
                "   AND cdj03 ='",g_cdj_h.cdj03,"'",
                "   AND cdj04 ='",g_cdj_h.cdj04,"'",
                " ORDER BY 1,2,3,5,6"   
    PREPARE t322_pb FROM g_sql
    DECLARE cdj_curs CURSOR FOR t322_pb
 
    CALL g_cdj.clear()
    LET g_cnt = 1
    FOREACH cdj_curs INTO g_cdj[g_cnt].*   #單身 ARRAY 填充
       IF STATUS THEN CALL cl_err('foreach.',STATUS,1) EXIT FOREACH END IF 
       SELECT gem02 INTO g_cdj[g_cnt].gem02 FROM gem_file WHERE gem01 = g_cdj[g_cnt].cdj15 #FUN-BB0038
       SELECT ima02 INTO g_cdj[g_cnt].ima02 FROM ima_file WHERE ima01 = g_cdj[g_cnt].cdj06
       SELECT azf03 INTO g_cdj[g_cnt].azf03 FROM azf_file WHERE azf01 = g_cdj[g_cnt].cdj07 AND azf02='2'  #FUN-BB0038
       SELECT aag02 INTO g_cdj[g_cnt].aag02 FROM aag_file WHERE aag01 = g_cdj[g_cnt].cdj08 AND aag00 = g_cdj_h.cdj01
       SELECT aag02 INTO g_cdj[g_cnt].aag021 FROM aag_file WHERE aag01 = g_cdj[g_cnt].cdj09 AND aag00 = g_cdj_h.cdj01

       LET g_cnt = g_cnt + 1
       IF g_cnt > g_max_rec THEN
          CALL cl_err( '', 9035, 0 )
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_cdj.deleteElement(g_cnt)
    LET g_rec_b = g_cnt-1
    DISPLAY g_rec_b TO FORMONLY.cn2
END FUNCTION

FUNCTION t322_bp(p_ud)
   DEFINE   p_ud   LIKE type_file.chr1    #No.FUN-690028 VARCHAR(1)
 
 
   IF p_ud <> "G" OR g_action_choice = "detail" THEN
      RETURN
   END IF
 
   LET g_action_choice = " "
   CALL cl_set_act_visible("accept,cancel", FALSE)   
   CALL cl_show_fld_cont()

   DISPLAY ARRAY g_cdj TO s_cdj.*  ATTRIBUTE(COUNT=g_rec_b,UNBUFFERED)         
      BEFORE DISPLAY
            CALL cl_show_fld_cont()
            CALL cl_navigator_setting( g_curs_index, g_row_count )
                        
         BEFORE ROW
         LET l_ac = ARR_CURR() 
         LET l_ac1 = l_ac
         CALL cl_show_fld_cont()    
         
      
      ON ACTION query
         LET g_action_choice="query"
         EXIT DISPLAY
 
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DISPLAY
 
      ON ACTION first
         CALL t322_fetch('F')
         ACCEPT DISPLAY
 
      ON ACTION previous
         CALL t322_fetch('P')
         ACCEPT DISPLAY
 
      ON ACTION jump
         CALL t322_fetch('/')
         ACCEPT DISPLAY
 
      ON ACTION next
         CALL t322_fetch('N')
         ACCEPT DISPLAY
 
      ON ACTION last
         CALL t322_fetch('L')
         ACCEPT DISPLAY

      ON ACTION help
         LET g_action_choice="help"
         EXIT DISPLAY
 
      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   #No.FUN-550037 hmf
         EXIT DISPLAY
 
      ON ACTION exit
         LET g_action_choice="exit"
         EXIT DISPLAY

      ON ACTION detail
         LET g_action_choice="detail"
         LET l_ac = 1
         EXIT DISPLAY
                  
      ON ACTION gen_entry 
         LET g_action_choice="gen_entry"
         EXIT DISPLAY
 
      ON ACTION entry_sheet  #分錄底稿
         LET g_action_choice="entry_sheet"
         EXIT DISPLAY
 
      ON ACTION accept
         LET g_action_choice="detail"        #No.FUN-A60024
         LET l_ac = ARR_CURR()
         EXIT DISPLAY
 
      ON ACTION cancel
             LET INT_FLAG=FALSE   #MOD-570244 mars
         LET g_action_choice="exit"
         EXIT DISPLAY
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
 
      ON ACTION about         #MOD-4C0121
         CALL cl_about()      #MOD-4C0121
 
      ON ACTION controls                       #No.FUN-6B0033                                                                       
         CALL cl_set_head_visible("","AUTO")   #No.FUN-6B0033

      ON ACTION CONTROLG
         CALL cl_cmdask()        # Command execution
                                                         
      #FUN-D60081--add--str--
      ON ACTION exporttoexcel                       #匯出Excel      
         LET g_action_choice = 'exporttoexcel'
         EXIT DISPLAY
      #FUN-D60081--add--end--
 
      ON ACTION drill_down1                                                      
         LET g_action_choice="drill_down1"                                       
         EXIT DISPLAY                                                          

      ON ACTION confirm #確認
         LET g_action_choice="confirm"
         EXIT DISPLAY
                   
      ON ACTION undo_confirm #取消確認
         LET g_action_choice="undo_confirm"
         EXIT DISPLAY 

      ON action process_qry 
         LET g_action_choice="process_qry"
         EXIT DISPLAY  


      ON action carry_voucher
         LET g_action_choice="carry_voucher"
         EXIT DISPLAY

      ON action undo_carry_voucher
         LET g_action_choice="undo_carry_voucher"
         EXIT DISPLAY

#No.FUN-CC0001 --begin
      ON action voucher_qry
         LET g_action_choice="voucher_qry"
         EXIT DISPLAY 
#No.FUN-CC0001 --end
                  
      AFTER DISPLAY
         CONTINUE DISPLAY

      #carrier 20130618
      &include "qry_string.4gl"

      END DISPLAY

   CALL cl_set_act_visible("accept,cancel", TRUE)
END FUNCTION

 
FUNCTION t322_v()
DEFINE  l_wc        STRING
   IF g_cdj_h.cdjconf ='Y' THEN RETURN END IF
  # LET l_wc = "cdj01 ='",g_cdj_h.cdj01,"' AND cdj02 ='",g_cdj_h.cdj02,"' AND cdj03 ='",g_cdj_h.cdj03,"' AND cdj04 = '",g_cdj_h.cdj04,"'"  #FUN-BB0038
   LET g_success ='Y'
   CALL p322_gl(g_cdj_h.cdj04,g_cdj_h.cdj02,g_cdj_h.cdj03,g_cdj_h.cdj01,g_cdj00)  #FUN-BB0038#FUN-C80094 add g_cdj00
   IF g_success ='N' THEN 
      RETURN  
   END IF 
   MESSAGE " "
END FUNCTION

                                                         
FUNCTION t322_drill_down()                                                      
DEFINE l_type LIKE type_file.chr1
   IF cl_null(l_ac1) THEN RETURN END IF                                                                              
   IF cl_null(g_cdj[l_ac1].cdj06) THEN RETURN END IF                                   
   #FUN-BB0038 --begin
  #LET g_msg = "axcq760 '",g_cdj[l_ac1].cdj06,"' '",g_cdj_h.cdj02,"' '",g_cdj_h.cdj03,"'" 
   IF g_cdj[l_ac1].cdj12>=0 THEN LET l_type='1' #销货
                            ELSE LET l_type='2' #销退
   END IF
   LET g_msg = "axcq760 '",g_cdj[l_ac1].cdj06,"' '",g_cdj_h.cdj02,"' '",g_cdj_h.cdj03,"' '",g_cdj[l_ac1].cdj14,"' '",g_cdj[l_ac1].cdj15,"' '",
              # g_cdj[l_ac1].cdj142,"' '",l_type,"'" #FUN-BB0038   #FUN-C80009
                g_cdj[l_ac1].cdj142,"' '",l_type,"' '",g_cdj[l_ac1].cdj07,"'" #FUN-BB0038 #FUN-C80009
   #FUN-BB0038 --end
   CALL cl_cmdrun(g_msg)                                                        
END FUNCTION                                                                    

FUNCTION t322_count()
 
   DEFINE l_cdj   DYNAMIC ARRAY of RECORD        # 程式變數
          cdj01          LIKE cdj_file.cdj01, 
          cdj02          LIKE cdj_file.cdj02,          
          cdj03          LIKE cdj_file.cdj03,
          cdj04          LIKE cdj_file.cdj04                  
                     END RECORD
   DEFINE li_cnt         LIKE type_file.num10   #FUN-680135 INTEGER
   DEFINE li_rec_b       LIKE type_file.num10   #FUN-680135 INTEGER

   LET g_sql= "SELECT UNIQUE cdj01,cdj02,cdj03,cdj04 FROM cdj_file ",  #No.FUN-710055
              " WHERE ",g_wc CLIPPED,
              "   AND ",g_wc1 CLIPPED,    #FUN-D60095 add
              "   AND cdj00 = '",g_cdj00,"'"     #FUN-C80094
   PREPARE t322_precount FROM g_sql
   DECLARE t322_count CURSOR FOR t322_precount
   LET li_cnt=1
   LET li_rec_b=0
   FOREACH t322_count INTO l_cdj[li_cnt].*  
       LET li_rec_b = li_rec_b + 1
       IF SQLCA.sqlcode THEN
          CALL cl_err('FOREACH:',SQLCA.sqlcode,1)
          LET li_rec_b = li_rec_b - 1
          EXIT FOREACH
       END IF
       LET li_cnt = li_cnt + 1
    END FOREACH
    LET g_row_count=li_rec_b 
END FUNCTION

#檢查科目名稱
FUNCTION t322_aag02(p_aag01)
DEFINE
    p_aag01         LIKE aag_file.aag01,
    l_aag02         LIKE aag_file.aag02,
    l_aag03         LIKE aag_file.aag03,
    l_aag07         LIKE aag_file.aag07,
    l_aagacti       LIKE aag_file.aagacti
 
    LET g_errno = ' '
    SELECT aag02,aag03,aag07,aagacti 
        INTO l_aag02,l_aag03,l_aag07,l_aagacti 
        FROM aag_file
        WHERE aag01 = p_aag01
          AND aag00 = g_cdj_h.cdj01             
    CASE WHEN SQLCA.SQLCODE=100   LET g_errno = 'agl-001'
         WHEN l_aagacti = 'N'     LET g_errno = '9028'
         WHEN l_aag07  = '1'      LET g_errno = 'agl-015'
         WHEN l_aag03 != '2'      LET g_errno = 'agl-201'
         OTHERWISE           LET g_errno = SQLCA.sqlcode USING '----------'
    END CASE
    RETURN l_aag02
END FUNCTION

FUNCTION t322_firm1_chk() 
DEFINE l_ccz12  LIKE ccz_file.ccz12 
DEFINE l_flg    LIKE type_file.chr1

    LET g_success ='Y'
#CHI-C30107 -------------------- add ----------------- begin
    IF g_cdj_h.cdjconf ='Y' THEN LET g_success ='N' RETURN END IF
    IF g_cdj_h.cdj01 IS NULL THEN LET g_success ='N' RETURN END IF
    IF NOT cl_confirm('aap-222') THEN
       LET g_success ='N'
       RETURN
    END IF
    SELECT * INTO g_cdj_h.* FROM cdj_file
     WHERE cdj01 = g_cdj_h.cdj01
       AND cdj02 = g_cdj_h.cdj02
       AND cdj03 = g_cdj_h.cdj03
       AND cdj04 = g_cdj_h.cdj04
       AND cdj05 = g_cdj_h.cdj05
       AND cdj06 = g_cdj_h.cdj06
#CHI-C30107 -------------------- add ----------------- end
    IF g_cdj_h.cdjconf ='Y' THEN LET g_success ='N' RETURN END IF 
    IF g_cdj_h.cdj01 IS NULL THEN LET g_success ='N' RETURN END IF  
    SELECT ccz12 INTO l_ccz12 FROM ccz_file 
    IF g_cdj_h.cdj01 = l_ccz12 THEN 
       LET l_flg =0
    ELSE
       LET l_flg =1
    END IF  
    CALL s_chknpq(g_cdj_h.cdj13,'CA',1,l_flg,g_cdj_h.cdj01)    
END FUNCTION 

FUNCTION t322_firm1_upd()
#CHI-C30107 ------------- mark -------------- begin
#   IF NOT cl_confirm('aap-222') THEN
#      RETURN
#   END IF
#CHI-C30107 ------------- mark -------------- end

    LET g_cdj_h.cdjconf ='Y' 
    UPDATE cdj_file SET cdjconf ='Y' 
     WHERE cdj00 = g_cdj00         #FUN-C80094
       AND cdj01 = g_cdj_h.cdj01
       AND cdj02 = g_cdj_h.cdj02
       AND cdj03 = g_cdj_h.cdj03
       AND cdj04 = g_cdj_h.cdj04
END FUNCTION 

FUNCTION t322_firm2()
   IF g_nppglno  IS NOT NULL THEN RETURN END IF  
   IF g_cdj_h.cdjconf ='N' THEN RETURN END IF
   IF NOT cl_confirm('aap-224') THEN
      RETURN
   END IF
    LET g_cdj_h.cdjconf ='N' 
    UPDATE cdj_file SET cdjconf ='N' 
     WHERE cdj00 = g_cdj00         #FUN-C80094
       AND cdj01 = g_cdj_h.cdj01
       AND cdj02 = g_cdj_h.cdj02
       AND cdj03 = g_cdj_h.cdj03
       AND cdj04 = g_cdj_h.cdj04
   
END FUNCTION 
