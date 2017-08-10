# Prog. Version..: '5.30.18-15.05.12(00009)'     #
#{
# Program name  : cq_tc_cra02.4gl
# Program ver.  : 
# Description   : 查詢 條件代碼
# Date & Author : No.0000685690_06_M001 20151016 By TSD.HuiJu FOR cimi002
# Modify........: No.0000685690_06_M057 16/12/28 By TSD.Jay 增加傳入參數

DATABASE ds 

GLOBALS "../../../tiptop/config/top.global"

DEFINE   ma_qry       DYNAMIC ARRAY OF RECORD
         check        LIKE type_file.chr1,  	
         tc_cra01     LIKE tc_cra_file.tc_cra01,   #條件代碼	
         tc_cra02     LIKE tc_cra_file.tc_cra02,   #條件說明
         tc_cra03     LIKE tc_cra_file.tc_cra03,   #爐型代碼
         tc_cra03a    LIKE azf_file.azf03,         #爐型說明
         tc_cra04     LIKE tc_cra_file.tc_cra04,   #硬度性質代碼
         tc_cra04a    LIKE azf_file.azf03,         #硬度性質代碼說明
         tc_cra05     LIKE tc_cra_file.tc_cra05,   #表面硬度起
         tc_cra06     LIKE tc_cra_file.tc_cra06,   #表面硬度迄
         tc_cra07     LIKE tc_cra_file.tc_cra07,   #表面硬度備註
         tc_cra08     LIKE tc_cra_file.tc_cra08,   #心部硬度性質代碼
         tc_cra08a    LIKE azf_file.azf03,         #心部硬度性質代碼說明
         tc_cra09     LIKE tc_cra_file.tc_cra09,   #心部硬度起
         tc_cra10     LIKE tc_cra_file.tc_cra10,   #心部硬度迄
         tc_cra11     LIKE tc_cra_file.tc_cra11,   #心部硬度備註
         tc_cra12     LIKE tc_cra_file.tc_cra12,   #深度性質代碼
         tc_cra12a    LIKE azf_file.azf03,         #深度性質代碼說明
         tc_cra13     LIKE tc_cra_file.tc_cra13,   #深度起
         tc_cra14     LIKE tc_cra_file.tc_cra14,   #深度迄
         tc_cra15     LIKE tc_cra_file.tc_cra15,   #深度單位
         tc_cra16     LIKE tc_cra_file.tc_cra16,   #深度備註
         tc_cra17     LIKE tc_cra_file.tc_cra17,   #金相組織
         tc_cra18     LIKE tc_cra_file.tc_cra18,   #檢測部位要求
         tc_cra19     LIKE tc_cra_file.tc_cra19    #備註
                      END RECORD
DEFINE   ma_qry_tmp   DYNAMIC ARRAY OF RECORD
         check        LIKE type_file.chr1,  	
         tc_cra01     LIKE tc_cra_file.tc_cra01,   #條件代碼	
         tc_cra02     LIKE tc_cra_file.tc_cra02,   #條件說明
         tc_cra03     LIKE tc_cra_file.tc_cra03,   #爐型代碼
         tc_cra03a    LIKE azf_file.azf03,         #爐型說明
         tc_cra04     LIKE tc_cra_file.tc_cra04,   #硬度性質代碼
         tc_cra04a    LIKE azf_file.azf03,         #硬度性質代碼說明
         tc_cra05     LIKE tc_cra_file.tc_cra05,   #表面硬度起
         tc_cra06     LIKE tc_cra_file.tc_cra06,   #表面硬度迄
         tc_cra07     LIKE tc_cra_file.tc_cra07,   #表面硬度備註
         tc_cra08     LIKE tc_cra_file.tc_cra08,   #心部硬度性質代碼
         tc_cra08a    LIKE azf_file.azf03,         #心部硬度性質代碼說明
         tc_cra09     LIKE tc_cra_file.tc_cra09,   #心部硬度起
         tc_cra10     LIKE tc_cra_file.tc_cra10,   #心部硬度迄
         tc_cra11     LIKE tc_cra_file.tc_cra11,   #心部硬度備註
         tc_cra12     LIKE tc_cra_file.tc_cra12,   #深度性質代碼
         tc_cra12a    LIKE azf_file.azf03,         #深度性質代碼說明
         tc_cra13     LIKE tc_cra_file.tc_cra13,   #深度起
         tc_cra14     LIKE tc_cra_file.tc_cra14,   #深度迄
         tc_cra15     LIKE tc_cra_file.tc_cra15,   #深度單位
         tc_cra16     LIKE tc_cra_file.tc_cra16,   #深度備註
         tc_cra17     LIKE tc_cra_file.tc_cra17,   #金相組織
         tc_cra18     LIKE tc_cra_file.tc_cra18,   #檢測部位要求
         tc_cra19     LIKE tc_cra_file.tc_cra19    #備註
                      END RECORD

DEFINE   mi_multi_sel     LIKE type_file.num5     #是否需要複選資料(TRUE/FALSE).	
DEFINE   mi_need_cons     LIKE type_file.num5     #是否需要CONSTRUCT(TRUE/FALSE).	
DEFINE   ms_cons_where    STRING                  #暫存CONSTRUCT區塊的WHERE條件.
DEFINE   mi_page_count    LIKE type_file.num10    #每頁顯現資料筆數.	
DEFINE   ms_default1      STRING     
DEFINE   ms_ret1          STRING    
DEFINE   ms_wc            STRING  #M057 161228 By TSD.Jay

#M057 161228 By TSD.Jay ---(S)---
#FUNCTION cq_tc_cra02(pi_multi_sel,pi_need_cons,ps_default1)
FUNCTION cq_tc_cra02(pi_multi_sel,pi_need_cons,ps_default1,p_wc)
#M057 161228 By TSD.Jay ---(E)---
   DEFINE   pi_multi_sel   LIKE type_file.num5,
            pi_need_cons   LIKE type_file.num5,
            ps_default1    STRING  
   DEFINE   p_wc           STRING #M057 161228 By TSD.Jay
 
   LET ms_default1 = ps_default1
   LET ms_wc = p_wc #M057 161228 By TSD.Jay
 
   WHENEVER ERROR CALL cl_err_msg_log
 
   OPEN WINDOW w_qry WITH FORM "cqry/42f/cq_tc_cra02" ATTRIBUTE(STYLE="create_qry") 

   CALL cl_ui_locale("cq_tc_cra02")

   LET mi_multi_sel = pi_multi_sel
   LET mi_need_cons = pi_need_cons

   # 2004/02/09 by saki : 不複選的狀態下要將CheckBox隱藏
   IF NOT (mi_multi_sel) THEN
      CALL cl_set_comp_visible("check",FALSE)
   END IF
 
   # 2003/09/16 by Hiko : 在複選狀態時,要將回傳欄位的字型顏色設為紅色,以作為標示.
   IF (mi_multi_sel) THEN
      CALL cl_set_comp_font_color("tc_cra01", "red")
   END IF

   CALL cq_tc_cra02_qry_sel()
 
   CLOSE WINDOW w_qry
 
   IF (mi_multi_sel) THEN
      RETURN ms_ret1 
   ELSE
      RETURN ms_ret1 
   END IF
END FUNCTION

##################################################
# Description  	: 畫面顯現與資料的選擇.
# Date & Author : 2013/01/31 by yangtt
# Parameter   	: none
# Return   	: void
# Memo        	:
# Modify   	:
##################################################
FUNCTION cq_tc_cra02_qry_sel()
   DEFINE   ls_hide_act      STRING
   DEFINE   li_hide_page     LIKE type_file.num5,     #是否隱藏'上下頁'的按鈕.	
            li_reconstruct   LIKE type_file.num5,     #是否重新CONSTRUCT.預設為TRUE. 	
            li_continue      LIKE type_file.num5      #是否繼續.	
   DEFINE   li_start_index   LIKE type_file.num10, 	
            li_end_index     LIKE type_file.num10 	
   DEFINE   li_curr_page     LIKE type_file.num5  	
   DEFINE   li_count         LIKE ze_file.ze03,
            li_page          LIKE ze_file.ze03
 

   LET mi_page_count = 100 
   LET li_reconstruct = TRUE
 
   WHILE TRUE
      CLEAR FORM
     
      LET INT_FLAG = FALSE
      LET ls_hide_act = ""

      IF (li_reconstruct) THEN
         MESSAGE ""
     
         IF (mi_need_cons) THEN
             CALL cl_opmsg('q')  
             CONSTRUCT ms_cons_where ON tc_cra01,tc_cra02,tc_cra03,tc_cra04,tc_cra05,tc_cra06,tc_cra07,
                                        tc_cra08,tc_cra09,tc_cra10,tc_cra11,tc_cra12,tc_cra13,tc_cra14,
                                        tc_cra15,tc_cra16,tc_cra17,tc_cra18,tc_cra19
                                   FROM s_tc_cra[1].tc_cra01,s_tc_cra[1].tc_cra02,s_tc_cra[1].tc_cra03,
                                        s_tc_cra[1].tc_cra04,s_tc_cra[1].tc_cra05,s_tc_cra[1].tc_cra06,
                                        s_tc_cra[1].tc_cra07,s_tc_cra[1].tc_cra08,s_tc_cra[1].tc_cra09,
                                        s_tc_cra[1].tc_cra10,s_tc_cra[1].tc_cra11,s_tc_cra[1].tc_cra12,
                                        s_tc_cra[1].tc_cra13,s_tc_cra[1].tc_cra14,s_tc_cra[1].tc_cra15,
                                        s_tc_cra[1].tc_cra16,s_tc_cra[1].tc_cra17,s_tc_cra[1].tc_cra18,
                                        s_tc_cra[1].tc_cra19

                ON IDLE g_idle_seconds
                   CALL cl_on_idle()
                   CONTINUE CONSTRUCT
             
             END CONSTRUCT
             IF (INT_FLAG) THEN
                LET INT_FLAG = FALSE
                EXIT WHILE
             END IF
         ELSE
             LET ms_cons_where = '1=1'
         END IF
     
         CALL cq_tc_cra02_qry_prep_result_set() 
         #如果沒有設定'每頁顯現資料筆數',則預設為所有資料一起顯現.
         IF (mi_page_count = 0) THEN
            LET mi_page_count = ma_qry.getLength()
         END IF
         #如果所設定的'每頁顯現資料筆數'超過/等於所有資料,則要隱藏'上下頁'的按鈕.
         IF (mi_page_count >= ma_qry.getLength()) THEN
            LET ls_hide_act = "prevpage,nextpage"
         END IF
     
         IF (NOT mi_need_cons) THEN
            IF (ls_hide_act IS NULL) THEN
               LET ls_hide_act = "reconstruct"
            ELSE
               LET ls_hide_act = "prevpage,nextpage,reconstruct"
            END IF 
         END IF
     
         LET li_start_index = 1
     
         LET li_reconstruct = FALSE
      END IF
     
      LET li_end_index = li_start_index + mi_page_count - 1
     
      IF (li_end_index > ma_qry.getLength()) THEN
         LET li_end_index = ma_qry.getLength()
      END IF
     
      CALL cq_tc_cra02_qry_set_display_data(li_start_index, li_end_index)
     
      LET li_curr_page = li_end_index / mi_page_count

      IF (li_end_index MOD mi_page_count) > 0 THEN
         LET li_curr_page = li_curr_page + 1
      END IF

      SELECT ze03 INTO li_count FROM ze_file WHERE ze01 = 'qry-001' AND ze02 = g_lang
      SELECT ze03 INTO li_page  FROM ze_file WHERE ze01 = 'qry-002' AND ze02 = g_lang

      MESSAGE li_count CLIPPED || " : " || ma_qry.getLength() || "  " || li_page CLIPPED || " : " || li_curr_page
     
      IF (mi_multi_sel) THEN
         CALL cq_tc_cra02_qry_input_array(ls_hide_act, li_start_index, li_end_index) RETURNING li_continue,li_reconstruct,li_start_index
      ELSE
         CALL cq_tc_cra02_qry_display_array(ls_hide_act, li_start_index, li_end_index) RETURNING li_continue,li_reconstruct,li_start_index
      END IF
     
      IF (NOT li_continue) THEN
         EXIT WHILE
      END IF
   END WHILE
END FUNCTION

##################################################
# Description  	: 準備查詢畫面的資料集.
# Date & Author : 2013/01/31 by yangtt
# Parameter   	: none
# Return        : void
# Memo        	:
# Modify        :
##################################################
FUNCTION cq_tc_cra02_qry_prep_result_set()
   DEFINE   ls_sql       STRING,
            ls_where     STRING
   DEFINE   l_sql,l_buf  STRING            
   DEFINE   ls_where1    LIKE type_file.chr1000
   DEFINE   li_i         LIKE type_file.num10 	
   DEFINE   l_i           LIKE type_file.num5
   DEFINE   l_j          LIKE type_file.num5
   DEFINE   lr_qry       RECORD
            check        LIKE type_file.chr1,   	
            tc_cra01     LIKE tc_cra_file.tc_cra01,   #條件代碼	
            tc_cra02     LIKE tc_cra_file.tc_cra02,   #條件說明
            tc_cra03     LIKE tc_cra_file.tc_cra03,   #爐型代碼
            tc_cra03a    LIKE azf_file.azf03,         #爐型說明
            tc_cra04     LIKE tc_cra_file.tc_cra04,   #硬度性質代碼
            tc_cra04a    LIKE azf_file.azf03,         #硬度性質代碼說明
            tc_cra05     LIKE tc_cra_file.tc_cra05,   #表面硬度起
            tc_cra06     LIKE tc_cra_file.tc_cra06,   #表面硬度迄
            tc_cra07     LIKE tc_cra_file.tc_cra07,   #表面硬度備註
            tc_cra08     LIKE tc_cra_file.tc_cra08,   #心部硬度性質代碼
            tc_cra08a    LIKE azf_file.azf03,         #心部硬度性質代碼說明
            tc_cra09     LIKE tc_cra_file.tc_cra09,   #心部硬度起
            tc_cra10     LIKE tc_cra_file.tc_cra10,   #心部硬度迄
            tc_cra11     LIKE tc_cra_file.tc_cra11,   #心部硬度備註
            tc_cra12     LIKE tc_cra_file.tc_cra12,   #深度性質代碼
            tc_cra12a    LIKE azf_file.azf03,         #深度性質代碼說明
            tc_cra13     LIKE tc_cra_file.tc_cra13,   #深度起
            tc_cra14     LIKE tc_cra_file.tc_cra14,   #深度迄
            tc_cra15     LIKE tc_cra_file.tc_cra15,   #深度單位
            tc_cra16     LIKE tc_cra_file.tc_cra16,   #深度備註
            tc_cra17     LIKE tc_cra_file.tc_cra17,   #金相組織
            tc_cra18     LIKE tc_cra_file.tc_cra18,   #檢測部位要求
            tc_cra19     LIKE tc_cra_file.tc_cra19    #備註            
                         END RECORD
 
   LET ls_sql = "SELECT 'N',tc_cra01,tc_cra02,tc_cra03,'',tc_cra04,'',   ",
                "       tc_cra05,tc_cra06,tc_cra07,tc_cra08,'',tc_cra09, ",
                "       tc_cra10,tc_cra11,tc_cra12,'',tc_cra13,tc_cra14, ",
                "       tc_cra15,tc_cra16,tc_cra17,tc_cra18,tc_cra19 ",
                " FROM tc_cra_file ", 
                " WHERE ",ms_cons_where
               ,"   AND ",ms_wc CLIPPED #M057 161228 By TSD.Jay
                          
   DECLARE lcurs_qry CURSOR FROM ls_sql
 
   FOR li_i = ma_qry.getLength() TO 1 STEP -1
      CALL ma_qry.deleteElement(li_i)
   END FOR
 
   LET li_i = 1
   
   LET l_sql=''
   LET l_sql = "SELECT azf03 ",
               "  FROM azf_file  ",
               " WHERE azf01 = ? ",
               "   AND azf02 = '2' "
   PREPARE azf_cs FROM l_sql
 
   FOREACH lcurs_qry INTO lr_qry.*
      IF (SQLCA.SQLCODE) THEN
         CALL cl_err(ls_sql, SQLCA.SQLCODE, 1)
         EXIT FOREACH
      END IF
      EXECUTE azf_cs INTO lr_qry.tc_cra03a USING lr_qry.tc_cra03
      EXECUTE azf_cs INTO lr_qry.tc_cra04a USING lr_qry.tc_cra04
      EXECUTE azf_cs INTO lr_qry.tc_cra08a USING lr_qry.tc_cra08
      EXECUTE azf_cs INTO lr_qry.tc_cra12a USING lr_qry.tc_cra12

      #判斷是否已達選取上限  
      IF li_i-1 >= g_aza.aza38 THEN
         CALL cl_err_msg(NULL,"lib-217",g_aza.aza38,10)
         EXIT FOREACH
      END IF

      LET ma_qry[li_i].* = lr_qry.*
      LET li_i = li_i + 1
   END FOREACH
END FUNCTION

##################################################
# Description  	: 設定查詢畫面的顯現資料.
# Date & Author : 2013/01/31 by yangtt
# Parameter   	: pi_start_index   LIKE type_file.num10    所要顯現的查詢資料起始位置	
#               : pi_end_index     LIKE type_file.num10    所要顯現的查詢資料結束位置	
# Return        : void
# Memo        	:
# Modify        :
##################################################
FUNCTION cq_tc_cra02_qry_set_display_data(pi_start_index, pi_end_index)
   DEFINE   pi_start_index   LIKE type_file.num10, 	
            pi_end_index     LIKE type_file.num10 	
   DEFINE   li_i             LIKE type_file.num10, 	
            li_j             LIKE type_file.num10 	
 

   FOR li_i = ma_qry_tmp.getLength() TO 1 STEP -1
      CALL ma_qry_tmp.deleteElement(li_i)
   END FOR
 
   FOR li_i = pi_start_index TO pi_end_index
      LET ma_qry_tmp[li_j+1].* = ma_qry[li_i].*
      LET li_j = li_j + 1
   END FOR
 
   CALL SET_COUNT(ma_qry_tmp.getLength())
END FUNCTION

##################################################
# Description  	: 採用INPUT ARRAY的方式來顯現查詢過後的資料.
# Date & Author : 2013/01/31 by yangtt
# Parameter   	: ps_hide_act      STRING    所要隱藏的Action Button
#               : pi_start_index   LIKE type_file.num10    所要顯現的查詢資料起始位置	
#               : pi_end_index     LIKE type_file.num10    所要顯現的查詢資料結束位置	
# Return   	: SMALLINT   是否繼續
#               : SMALLINT   是否重新查詢
#               : INTEGER    改變後的起始位置
# Memo        	:
# Modify   	:
##################################################
FUNCTION cq_tc_cra02_qry_input_array(ps_hide_act, pi_start_index, pi_end_index)
   DEFINE   ps_hide_act      STRING,
            pi_start_index   LIKE type_file.num10, 	
            pi_end_index     LIKE type_file.num10 	
   DEFINE   li_continue      LIKE type_file.num5,  	
            li_reconstruct   LIKE type_file.num5  	
   DEFINE   li_i             LIKE type_file.num5        
 
 
   INPUT ARRAY ma_qry_tmp WITHOUT DEFAULTS FROM s_tc_cra.* ATTRIBUTE(INSERT ROW=FALSE, DELETE ROW=FALSE,APPEND ROW=FALSE, UNBUFFERED) 
      BEFORE INPUT
         CALL cl_set_act_visible("prevpage,nextpage,reconstruct",TRUE)
         IF (ps_hide_act IS NOT NULL) THEN   
            CALL cl_set_act_visible(ps_hide_act, FALSE)
         END IF
      ON ACTION prevpage
         CALL GET_FLDBUF(s_tc_cra.check) RETURNING ma_qry_tmp[ARR_CURR()].check
         CALL cq_tc_cra02_qry_reset_multi_sel(pi_start_index, pi_end_index)
     
         IF ((pi_start_index - mi_page_count) >= 1) THEN
            LET pi_start_index = pi_start_index - mi_page_count
         END IF
     
         LET li_continue = TRUE
     
         EXIT INPUT
      ON ACTION nextpage
         CALL GET_FLDBUF(s_tc_cra.check) RETURNING ma_qry_tmp[ARR_CURR()].check
         CALL cq_tc_cra02_qry_reset_multi_sel(pi_start_index, pi_end_index)
     
         IF ((pi_start_index + mi_page_count) <= ma_qry.getLength()) THEN
            LET pi_start_index = pi_start_index + mi_page_count
         END IF
     
         LET li_continue = TRUE
     
         EXIT INPUT
      ON ACTION refresh
         CALL cq_tc_cra02_qry_refresh()
     
         LET pi_start_index = 1
         LET li_continue = TRUE
     
         EXIT INPUT
      ON ACTION reconstruct
         LET li_reconstruct = TRUE
         LET li_continue = TRUE
     
         EXIT INPUT
      ON ACTION accept
         IF ARR_CURR()>0 THEN       
            CALL GET_FLDBUF(s_tc_cra.check) RETURNING ma_qry_tmp[ARR_CURR()].check
            CALL cq_tc_cra02_qry_reset_multi_sel(pi_start_index, pi_end_index)
            CALL cq_tc_cra02_qry_accept(pi_start_index+ARR_CURR()-1)
         ELSE                       
            LET ms_ret1 = NULL      
         END IF                     
         LET li_continue = FALSE
     
         EXIT INPUT
      ON ACTION cancel
         LET INT_FLAG = 0 
         IF (NOT mi_multi_sel) THEN
            LET ms_ret1 = ms_default1
         END IF

         LET li_continue = FALSE
     
         EXIT INPUT
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT

      
      ON ACTION exporttoexcel
         CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(ma_qry),'','')
      
   
      
      ON ACTION qry_string
         CALL cl_qry_string("detail")
       
      ON ACTION selectall
         FOR li_i = 1 TO ma_qry_tmp.getLength()
             LET ma_qry_tmp[li_i].check = "Y"
         END FOR

      ON ACTION select_none
         FOR li_i = 1 TO ma_qry_tmp.getLength()
             LET ma_qry_tmp[li_i].check = "N"
         END FOR

   END INPUT
 
   RETURN li_continue,li_reconstruct,pi_start_index
END FUNCTION

##################################################
# Description  	: 重設查詢資料關於'check'欄位的值.
# Date & Author : 2013/01/31 by yangtt
# Parameter   	: pi_start_index   LIKE type_file.num10    所要顯現的查詢資料起始位置	
#               : pi_end_index     LIKE type_file.num10    所要顯現的查詢資料結束位置	
# Return   	: void
# Memo        	:
# Modify   	:
##################################################
FUNCTION cq_tc_cra02_qry_reset_multi_sel(pi_start_index, pi_end_index)
   DEFINE   pi_start_index   LIKE type_file.num10, 	
            pi_end_index     LIKE type_file.num10 	
   DEFINE   li_i             LIKE type_file.num10, 	
            li_j             LIKE type_file.num10 	
 
 
   FOR li_i = pi_start_index TO pi_end_index
      LET ma_qry[li_i].check = ma_qry_tmp[li_j+1].check
      LET li_j = li_j + 1
   END FOR
END FUNCTION

##################################################
# Description  	: 採用DISPLAY ARRAY的方式來顯現查詢過後的資料.
# Date & Author : 2003/09/22 by jack
# Parameter   	: ps_hide_act      STRING    所要隱藏的Action Button
#               : pi_start_index   LIKE type_file.num10    所要顯現的查詢資料起始位置	
#               : pi_end_index     LIKE type_file.num10    所要顯現的查詢資料結束位置	
# Return   	: SMALLINT   是否繼續
#               : SMALLINT   是否重新查詢
#               : INTEGER    改變後的起始位置
# Memo        	:
# Modify   	:
##################################################
FUNCTION cq_tc_cra02_qry_display_array(ps_hide_act, pi_start_index, pi_end_index)
   DEFINE   ps_hide_act      STRING,
            pi_start_index   LIKE type_file.num10, 	
            pi_end_index     LIKE type_file.num10 	
   DEFINE   li_continue      LIKE type_file.num5,  	
            li_reconstruct   LIKE type_file.num5  	
 
 
   DISPLAY ARRAY ma_qry_tmp TO s_tc_cra.*
      BEFORE DISPLAY
         CALL cl_set_act_visible("prevpage,nextpage,reconstruct",TRUE)
         IF (ps_hide_act IS NOT NULL) THEN   
            CALL cl_set_act_visible(ps_hide_act, FALSE)
         END IF
      ON ACTION prevpage
         IF ((pi_start_index - mi_page_count) >= 1) THEN
            LET pi_start_index = pi_start_index - mi_page_count
         END IF
      
         LET li_continue = TRUE
      
         EXIT DISPLAY
      ON ACTION nextpage
         IF ((pi_start_index + mi_page_count) <= ma_qry.getLength()) THEN
            LET pi_start_index = pi_start_index + mi_page_count
         END IF
      
         LET li_continue = TRUE
      
         EXIT DISPLAY
      ON ACTION refresh
         LET pi_start_index = 1
         LET li_continue = TRUE
      
         EXIT DISPLAY
      ON ACTION reconstruct
         LET li_reconstruct = TRUE
         LET li_continue = TRUE
      
         EXIT DISPLAY
      ON ACTION accept
         CALL cq_tc_cra02_qry_accept(pi_start_index+ARR_CURR()-1)
         LET li_continue = FALSE
      
         EXIT DISPLAY
      ON ACTION cancel
         LET INT_FLAG = 0 
         IF (NOT mi_multi_sel) THEN
            LET ms_ret1 = ms_default1
         END IF

         LET li_continue = FALSE
      
         EXIT DISPLAY
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DISPLAY
   
      
      ON ACTION exporttoexcel
         CALL cl_export_to_excel(ui.Interface.getRootNode(),base.TypeInfo.create(ma_qry),'','')
      

      
      ON ACTION qry_string
         CALL cl_qry_string("detail")
      

   END DISPLAY
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
   RETURN li_continue,li_reconstruct,pi_start_index
END FUNCTION

##################################################
# Description   : 重設查詢資料.
# Date & Author : 2013/01/31 by yangtt
# Parameter     : none
# Return        : void
# Memo          :
# Modify        :
##################################################
FUNCTION cq_tc_cra02_qry_refresh()
   DEFINE   li_i   LIKE type_file.num10 	


   FOR li_i = 1 TO ma_qry.getLength()
      LET ma_qry[li_i].check = 'N'
   END FOR
END FUNCTION

##################################################
# Description  	: 選擇並確認資料.
# Date & Author : 2003/09/22 by jack
# Parameter   	: pi_sel_index   LIKE type_file.num10    所選擇的資料索引	
# Return   	: void
# Memo        	:
# Modify   	:
##################################################
FUNCTION cq_tc_cra02_qry_accept(pi_sel_index)
   DEFINE   pi_sel_index    LIKE type_file.num10 	
   DEFINE   lsb_multi_sel   base.StringBuffer,
            li_i            LIKE type_file.num10  	
 

   #GDC 1.3版本後，若沒有資料，ARR_CURR()會是0
   IF pi_sel_index = 0 THEN
      RETURN
   END IF

   IF (mi_multi_sel) THEN
      LET lsb_multi_sel = base.StringBuffer.create()
 
      FOR li_i = 1 TO ma_qry.getLength()
         IF (ma_qry[li_i].check = 'Y') THEN
            IF (lsb_multi_sel.getLength() = 0) THEN
               CALL lsb_multi_sel.append(ma_qry[li_i].tc_cra01 CLIPPED)
            ELSE
               CALL lsb_multi_sel.append("|" || ma_qry[li_i].tc_cra01 CLIPPED)
            END IF
         END IF    
      END FOR
      #複選狀態只會有一組字串回傳值. 
      LET ms_ret1 = lsb_multi_sel.toString()
   ELSE
      LET ms_ret1 = ma_qry[pi_sel_index].tc_cra01 CLIPPED
   END IF
END FUNCTION
#FUN-D10142
