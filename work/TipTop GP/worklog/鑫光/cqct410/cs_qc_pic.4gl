# Prog. Version..: '5.30.05-13.01.08(00007)'     #

# Program name...: cs_qc_pic.4gl
# Descriptions...: 提供cqci100,aooi040,cqct410上傳圖片
# Usage..........: CALL cs_qc_pic(p_class,p_tc_imc01,p_tc_imc02,p_str)
#                    - 上傳圖片至cqci100,aooi040,cqct410,p_zo
# Date & Author..: NO.0000685690_06_M025 160505 By TSD.james
# Modify.........: #0000685690_06_M049 16/12/16 By TSD.Jay tc_imc_file新增KEY值tc_imc31[版本]

IMPORT os # add by lixwz 170911

DATABASE ds

GLOBALS "../../../tiptop/config/top.global"

DEFINE gs_wc          STRING,
       gs_tempdir     STRING,
       gs_fglasip     STRING
DEFINE g_key          RECORD
           class      LIKE type_file.chr1,         # 種類 '1':cqci100 '2':aooi040 '3':cqct410 # '4':p_zo add by zl
           tc_imc01   LIKE tc_imc_file.tc_imc01,   #KEY1
           tc_imc02   LIKE tc_imc_file.tc_imc02,   #KEY2
           tc_imc31   LIKE tc_imc_file.tc_imc31,   #KEY3 #M049 161216 By TSD.Jay
           tc_imc10   LIKE tc_imc_file.tc_imc10,   # 圖片欄位
           str        LIKE type_file.chr1          # 1:圖片1
                      END RECORD
DEFINE gs_field1      STRING
DEFINE gs_field2      STRING
DEFINE gs_mode        STRING
DEFINE gs_location    STRING
DEFINE gn_node1       om.DomNode
DEFINE gn_node2       om.DomNode
DEFINE gi_maintain    LIKE type_file.num10
DEFINE gi_picPrint    LIKE type_file.num5
DEFINE gi_printSource LIKE type_file.chr1
DEFINE gi_slient_mode LIKE type_file.num5
DEFINE g_cnt          LIKE type_file.num5
DEFINE g_class        LIKE type_file.chr1  # add by lixwz 170911

# Descriptions...: 上傳圖片至cqci100,aooi040,cqct410
# Input Parameter: p_class    : 種類 '1':cqci100
#                                    '2':aooi040
#                                    '3':cqct410
#                                    '4':p_zo     #add by zl 170405
#                  p_tc_imc01 : KEY1
#                  p_tc_imc02 : KEY2
#                  p_tc_imc31 : KEY3 #M049 161216 By TSD.Jay
#                  p_str      : 1:圖片1
# Return code....:
# Date & Author..: NO.0000685690_06_M025 160505 By TSD.james

#M049 161216 By TSD.Jay ---(S)---
#FUNCTION cs_qc_pic(p_class,p_tc_imc01,p_tc_imc02,p_str)
FUNCTION cs_qc_pic(p_class,p_tc_imc01,p_tc_imc02,p_tc_imc31,p_str)
#M049 161216 By TSD.Jay ---(E)---
   DEFINE p_class     LIKE type_file.chr1         # 種類 '1':cqci120 '2':cqci122 '3':cqct410
   DEFINE p_tc_imc01  LIKE tc_imc_file.tc_imc01   #KEY1
   DEFINE p_tc_imc02  LIKE tc_imc_file.tc_imc02   #KEY2
   DEFINE p_tc_imc31  LIKE tc_imc_file.tc_imc31   #KEY3 #M049 161216 By TSD.Jay
   DEFINE p_str       LIKE type_file.chr1         # 1:圖片1

   WHENEVER ERROR CALL cl_err_msg_log

   #M049 161216 By TSD.Jay ---(S)---
   #IF NOT cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,p_str) THEN
   IF NOT cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,p_tc_imc31,p_str) THEN
   #M049 161216 By TSD.Jay ---(E)---
      RETURN
   END IF
   LET g_class = p_class # add by lixwz 170911

   LET gi_maintain = TRUE
   IF NOT cs_getFieldDocument() THEN
      CALL cl_err(NULL, "lib-211", 1)
      RETURN
   END IF

   IF NOT cs_maintainFieldDocument() THEN
      RETURN
   END IF

   #--If user choose "delete" action, then remove record from DB
   #--Otherwise, update new record
   CASE gs_mode
      WHEN "delete"
         IF NOT cs_removeFieldDocumentRecord() THEN
            CALL cl_err3("del","","","","lib-207","","NULL",0)
         END IF
         RETURN
      OTHERWISE
         IF NOT cs_maintainFieldDocumentRecord() THEN
            CALL cl_err(NULL, "lib-209", 1)
            RETURN
         END IF
   END CASE

END FUNCTION

# Descriptions...: 顯示圖檔於畫面上
# Input Parameter: p_class    : 種類 '1':cqci100
#                                    '2':aooi040
#                                    '3':cqct410
#                  p_tc_imc01 : KEY1
#                  p_tc_imc02 : KEY2
#                  p_tc_imc31 : KEY3 #M049 161216 By TSD.Jay
# Return code....:
# Date & Author..: NO.0000685690_06_M025 160505 By TSD.james

#M049 161216 By TSD.Jay ---(S)---
#FUNCTION cs_get_fld_doc(p_class,p_tc_imc01,p_tc_imc02)
FUNCTION cs_get_fld_doc(p_class,p_tc_imc01,p_tc_imc02,p_tc_imc31)
#M049 161216 By TSD.Jay ---(E)---
   DEFINE p_class    LIKE type_file.chr1          # 種類 '1':cqci100 '2':aooi040 '3':cqct410 #'4':p_zo add by zl 170405
   DEFINE p_tc_imc01 LIKE tc_imc_file.tc_imc01    #KEY1
   DEFINE p_tc_imc02 LIKE tc_imc_file.tc_imc02    #KEY2
   DEFINE p_tc_imc31 LIKE tc_imc_file.tc_imc31    #KEY3 #M049 161216 By TSD.Jay
   DEFINE p_tc_imc10 LIKE tc_imc_file.tc_imc10    # 圖片欄位
   DEFINE ps_field1  STRING

   #M049 161216 By TSD.Jay ---(S)---
   #IF NOT cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,'1') THEN
   IF NOT cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,p_tc_imc31,'1') THEN
   #M049 161216 By TSD.Jay ---(E)---
      RETURN
   END IF

   IF NOT cs_fieldDocumentPrepare2() THEN
      RETURN
   END IF

   #畫面圖片清空
   CALL gn_node1.setAttribute("value", NULL)

   LET gi_maintain = FALSE
   IF NOT cs_getFieldDocument() THEN
      RETURN
   END IF

   IF cs_getFieldDocumentLocation() THEN
      CALL gn_node1.setAttribute("value", gs_location)
   END IF

END FUNCTION

# Descriptions...: 初始化相關變數
# Input Parameter: p_class       # 種類 '1':cqci100
#                                #      '2':aooi040
#                                #      '3':cqct410
#                  p_tc_imc01    # KEY1
#                  p_tc_imc02    # KEY2
#                  p_tc_imc31    # KEY3 #M049 161216 By TSD.Jay
#                  p_str         # 1:圖片1
# Return code....: TRUE/FALSE
# Date & Author..: NO.0000685690_06_M025 160505 By TSD.james

#M049 161216 By TSD.Jay ---(S)---
#FUNCTION cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,p_str)
FUNCTION cs_fieldDocumentPrepare(p_class,p_tc_imc01,p_tc_imc02,p_tc_imc31,p_str)
#M049 161216 By TSD.Jay ---(E)---
   DEFINE p_class     LIKE type_file.chr1         # 種類 '1':cqci100 '2':aooi040 '3':cqct410 #'4':p_zo add by zl 170405
   DEFINE p_tc_imc01  LIKE tc_imc_file.tc_imc01   # KEY1
   DEFINE p_tc_imc02  LIKE tc_imc_file.tc_imc02   # KEY2
   DEFINE p_tc_imc31  LIKE tc_imc_file.tc_imc31   # KEY3 #M049 161216 By TSD.Jay
   DEFINE p_tc_imc10  LIKE tc_imc_file.tc_imc10   # 圖片欄位
   DEFINE p_str       LIKE type_file.chr1         # 1:圖片1

   LET gs_tempdir = FGL_GETENV("TEMPDIR")
   LET gs_fglasip = FGL_GETENV("FGLASIP")
   LET gs_mode = NULL

   #--Compose KEY value
   LET g_key.class     = p_class       # 種類 '1':cqci100 '2':aooi040 '3':cqct410 #'4':p_zo add by zl170405
   LET g_key.tc_imc01  = p_tc_imc01    #KEY1
   LET g_key.tc_imc02  = p_tc_imc02    #KEY2
   LET g_key.tc_imc31  = p_tc_imc31    #KEY3 #M049 161216 By TSD.Jay
   LET g_key.str       = p_str         # 1:圖片1

   RETURN TRUE
END FUNCTION

#取得圖片物件
FUNCTION cs_fieldDocumentPrepare2()
   DEFINE lw_curr    ui.Window
   DEFINE lf_curr    ui.Form
   DEFINE ll_node    om.NodeList
   DEFINE ln_form    om.DomNode

   LET gs_field1 ="pic01"

   #--Getting Dom Node for the dedicated field
   IF ( gi_picPrint = FALSE ) OR ( gi_slient_mode = FALSE ) THEN
      LET lw_curr = ui.Window.getCurrent()
      LET lf_curr = lw_curr.getForm()
      LET ln_form = lf_curr.getNode()
      LET ll_node = ln_form.selectByPath("//FormField[@colName=\"" || gs_field1  || "\"]")
      IF ll_node.getLength() != 0 THEN
         LET gn_node1 = ll_node.item(1)
      ELSE
         RETURN FALSE
      END IF
   END IF
   #--

   RETURN TRUE
END FUNCTION

FUNCTION cs_getFieldDocument()
   DEFINE l_sql   STRING

   #--Compose WHERE condition for document selection
   CASE
      WHEN g_key.class = '1'
         LET gs_wc = "     tc_imc01 = '",g_key.tc_imc01  CLIPPED,"'",
                     " AND tc_imc02 = '",g_key.tc_imc02  CLIPPED,"'"
                     #M049 161216 By TSD.Jay ---(S)---
                    ," AND tc_imc31 = '",g_key.tc_imc31,"'"
                     #M049 161216 By TSD.Jay ---(E)---
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_imc10 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_imc_file",
                     " WHERE ",gs_wc CLIPPED

      WHEN g_key.class = '2'
         LET gs_wc = "     gen01 = '",g_key.tc_imc01  CLIPPED,"'"
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT COUNT(*) "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM gen_file",
                     " WHERE ",gs_wc CLIPPED

      WHEN g_key.class = '3'
         LET gs_wc = "     tc_qce01 = '",g_key.tc_imc01  CLIPPED,"'",
                     " AND tc_qce02 = '",g_key.tc_imc02  CLIPPED,"'"
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_qce05 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_qce_file",
                     " WHERE ",gs_wc CLIPPED
  #add by zl 170405
      WHEN g_key.class = '4'
         LET gs_wc = "     zo01 = '",g_key.tc_imc01  CLIPPED,"'"
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT COUNT(*) "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM zo_file",
                     " WHERE ",gs_wc CLIPPED
  #add by zl 170405
      OTHERWISE EXIT CASE
   END CASE

   PREPARE fld_doc_pre FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err("prepare fld_doc_cur: ", SQLCA.SQLCODE, 0)
      RETURN FALSE
   END IF

   LOCATE g_key.tc_imc10 IN MEMORY

   IF g_key.class = '2' THEN
      LET g_cnt = 0
      LET gs_wc = "     tc_sig01 = '",g_key.tc_imc01  CLIPPED,"'"
      EXECUTE fld_doc_pre INTO g_cnt
   ELSE
   	  IF g_key.class = '4' THEN
   	     LET g_cnt = 0
         LET gs_wc = "     tc_zo01 = '",g_key.tc_imc01  CLIPPED,"'"
         EXECUTE fld_doc_pre INTO g_cnt
      ELSE
         EXECUTE fld_doc_pre INTO g_key.tc_imc10
      END IF
   END IF
   IF ( SQLCA.SQLCODE ) AND ( NOT gi_maintain ) THEN
      RETURN FALSE
   END IF
   IF SQLCA.SQLCODE THEN
      CALL cl_err3("sel","tc_imc_file","","",SQLCA.sqlcode,"","",0)
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#提供選單讓user選擇
FUNCTION cs_maintainFieldDocument()
   DEFINE l_sql         STRING
   DEFINE ls_str        STRING,
          ls_file       STRING,
          ls_location   STRING

   LET gs_location = NULL

   #--"modify" mode needs "browser" and "delete" action
   LET ls_str = cl_getmsg("lib-201", g_lang)
   WHILE TRUE
      LET ls_location = gs_location
      PROMPT ls_str CLIPPED FOR gs_location
          ATTRIBUTE(WITHOUT DEFAULTS)   #wow

          ON ACTION accept
             IF NOT cl_null(gs_location) THEN
                EXIT WHILE
             END IF

          ON ACTION cancel
             LET gs_location = ls_location
             EXIT WHILE

          ON ACTION browse_document
             LET ls_file = cl_browse_file()
             IF ls_file IS NOT NULL THEN
                LET gs_location = ls_file
             END IF

          ON ACTION delete_pic
             IF cl_confirm('TSD0038') THEN    #TSD0038 是否確認刪除圖片?
                LET gs_mode = "delete"
                EXIT WHILE
             END IF

          ON IDLE g_idle_seconds
             CALL cl_on_idle()
             LET gs_location = ls_location
             RETURN FALSE

      END PROMPT
   END WHILE

   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#更新圖片
FUNCTION cs_maintainFieldDocumentRecord()
   DEFINE l_sql         STRING
   DEFINE li_status     LIKE type_file.num10,
          li_min        LIKE type_file.num10
   DEFINE ls_msg        STRING,
          ls_sql        STRING,
          ls_docNum     STRING,
          ls_time       STRING,
          ls_fname      STRING,
          ls_location   STRING
  DEFINE  l_filesize    LIKE type_file.num10  # add by lixwz 20170911

   #--If location is a URL format, then store this location directly
   #--Otherwise, store file into DB
   LET ls_location = gs_location.toLowerCase()
   IF ls_location.getIndexOf("http://", 1) THEN
   ELSE
      LET ls_fname = gs_tempdir, "/",cs_getFieldDocumentExtension()
      IF NOT cl_upload_file(gs_location, ls_fname) THEN
         CALL cl_err(NULL, "lib-212", 1)
         RETURN FALSE
      END IF
      # add by lixwz 20170911 s
      IF g_class = '3' THEN
          LET l_filesize = os.Path.size(ls_fname.trim())
          IF l_filesize > 512000 THEN
              IF os.Path.delete(ls_fname.trim()) THEN
                  CALL cl_err('大小超过限制，500KB','!',1)
              END IF
              RETURN FALSE
          END IF
      END IF
      # add by lixwz 20170911 e
      LOCATE g_key.tc_imc10 IN FILE ls_fname
   END IF
   #--

   LET li_status = TRUE
   BEGIN WORK

   CASE
      WHEN g_key.class = '1'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE tc_imc_file SET tc_imc10 = ? "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED

      WHEN g_key.class = '2'
         CASE
            WHEN g_key.str = '1'
               LET g_cnt = 0
               SELECT COUNT(*)
                 INTO g_cnt
                 FROM tc_sig_file
                WHERE tc_sig01 = g_key.tc_imc01
               IF g_cnt > 0 THEN
                  LET l_sql = "UPDATE tc_sig_file ",
                              "   SET tc_sig02 = ? ",
                              " WHERE ",gs_wc CLIPPED
               ELSE
                  LET l_sql = "INSERT INTO tc_sig_file ",
                              "VALUES('",g_key.tc_imc01,"',","?)"

               END IF
            OTHERWISE EXIT CASE
         END CASE

      WHEN g_key.class = '3'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE tc_qce_file SET tc_qce05 = ? "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED

#add by zl 170405
      WHEN g_key.class = '4'
         CASE
            WHEN g_key.str = '1'
               LET g_cnt = 0
               SELECT COUNT(*)
                 INTO g_cnt
                 FROM tc_zo_file
                WHERE tc_zo01 = g_key.tc_imc01
               IF g_cnt > 0 THEN
                  LET l_sql = "UPDATE tc_zo_file ",
                              "   SET tc_zo02 = ? ",
                              " WHERE ",gs_wc CLIPPED
               ELSE
                  LET l_sql = "INSERT INTO tc_zo_file ",
                              "VALUES('",g_key.tc_imc01,"',","?)"

               END IF
            OTHERWISE EXIT CASE
         END CASE
#add by zl 170405

      OTHERWISE EXIT CASE
   END CASE
   PREPARE cs_qc_pic_p2 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err("prepare cs_qc_pic_p2 : ", SQLCA.SQLCODE, 0)
      RETURN FALSE
   END IF

   EXECUTE cs_qc_pic_p2 USING g_key.tc_imc10
   IF SQLCA.sqlcode THEN
      CALL cl_err("upd tc_imc_file",SQLCA.sqlcode,1)
      LET li_status = FALSE
   END IF

   FREE g_key.tc_imc10
   RUN "rm -f " || ls_fname

   CASE
      #更新上傳簽名圖檔否
      WHEN g_key.class = '2'
         CASE
            WHEN g_key.str = '1'
              LET l_sql = "UPDATE gen_file ",
                          "   SET ta_gen01 = 'Y' ",
                          " WHERE gen01 = '",g_key.tc_imc01,"'"
              PREPARE cs_qc_pic_p5 FROM l_sql
              IF SQLCA.SQLCODE THEN
                 CALL cl_err("prepare cs_qc_pic_p5 : ", SQLCA.SQLCODE, 0)
                 RETURN FALSE
              END IF

              EXECUTE cs_qc_pic_p5
              IF SQLCA.sqlcode THEN
                 CALL cl_err("upd gen_file",SQLCA.sqlcode,1)
                 LET li_status = FALSE
              END IF
         END CASE

      WHEN g_key.class = '3'
         CASE
            WHEN g_key.str = '1'
              LET l_sql = "UPDATE tc_qce_file ",
                          "   SET tc_qce04 = 'Y' ",
                          " WHERE tc_qce01 = '",g_key.tc_imc01,"'",
                          "   AND tc_qce02 = '",g_key.tc_imc02,"'"
              PREPARE cs_qc_pic_p6 FROM l_sql
              IF SQLCA.SQLCODE THEN
                 CALL cl_err("prepare cs_qc_pic_p6 : ", SQLCA.SQLCODE, 0)
                 RETURN FALSE
              END IF

              EXECUTE cs_qc_pic_p6
              IF SQLCA.sqlcode THEN
                 CALL cl_err("upd tc_qce_file",SQLCA.sqlcode,1)
                 LET li_status = FALSE
              END IF
         END CASE


      OTHERWISE EXIT CASE
   END CASE

   IF NOT li_status THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF

   RETURN li_status
END FUNCTION

#刪除圖片
FUNCTION cs_removeFieldDocumentRecord()
   DEFINE l_sql       STRING
   DEFINE li_status   LIKE type_file.num10

   LET li_status = TRUE
   BEGIN WORK

   CASE
      WHEN g_key.class = '1'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE tc_imc_file SET tc_imc10 = NULL "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED

      WHEN g_key.class = '2'
         CASE
            WHEN g_key.str = '1'
                LET l_sql = "DELETE FROM tc_sig_file  "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED

      WHEN g_key.class = '3'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE tc_qce_file SET tc_qce05 = NULL "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED

#add by zl 170405 begin
       WHEN g_key.class = '4'
         CASE
            WHEN g_key.str = '1'
                LET l_sql = "DELETE FROM tc_zo_file  "

            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     " WHERE ",gs_wc CLIPPED
#add by zl 170405 end
      OTHERWISE EXIT CASE
   END CASE
   PREPARE cs_qc_pic_p1 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err("prepare cs_qc_pic_p1 : ", SQLCA.SQLCODE, 0)
      RETURN FALSE
   END IF

   EXECUTE cs_qc_pic_p1

   IF SQLCA.sqlcode THEN
      CALL cl_err("upd tc_imc_file",SQLCA.sqlcode,1)
      LET li_status = FALSE
   END IF

   CASE
      #更新上傳圖檔否
      WHEN g_key.class = '2'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE gen_file ",
                           "   SET ta_gen01 = 'N' ",
                           " WHERE gen01 = '",g_key.tc_imc01,"'"
               PREPARE cs_qc_pic_p4 FROM l_sql
               IF SQLCA.SQLCODE THEN
                  CALL cl_err("prepare cs_qc_pic_p4 : ", SQLCA.SQLCODE, 0)
                  RETURN FALSE
               END IF

               EXECUTE cs_qc_pic_p4

               IF SQLCA.sqlcode THEN
                  CALL cl_err("upd gen_file",SQLCA.sqlcode,1)
                  LET li_status = FALSE
               END IF
            OTHERWISE EXIT CASE
         END CASE

      WHEN g_key.class = '3'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "UPDATE tc_qce_file ",
                           "   SET tc_qce04 = 'N' ",
                           " WHERE tc_qce01 = '",g_key.tc_imc01,"'",
                           "   AND tc_qce02 = '",g_key.tc_imc02,"'"
               PREPARE cs_qc_pic_p7 FROM l_sql
               IF SQLCA.SQLCODE THEN
                  CALL cl_err("prepare cs_qc_pic_p7 : ", SQLCA.SQLCODE, 0)
                  RETURN FALSE
               END IF

               EXECUTE cs_qc_pic_p7

               IF SQLCA.sqlcode THEN
                  CALL cl_err("upd tc_qce_file",SQLCA.sqlcode,1)
                  LET li_status = FALSE
               END IF
            OTHERWISE EXIT CASE
         END CASE
   END CASE

   IF NOT li_status THEN
      ROLLBACK WORK
   ELSE
      COMMIT WORK
   END IF

   RETURN li_status
END FUNCTION

#取得圖片網址
FUNCTION cs_getFieldDocumentLocation()
   DEFINE ls_fname    STRING,
          ls_name     STRING
   DEFINE lch_pipe    base.Channel
   DEFINE ls_buf      STRING
   DEFINE ls_cliTemp  STRING   #client端暫存目錄名稱
   DEFINE ls_clifname STRING   #client端暫存檔名
   DEFINE ls_ext      STRING   #圖片副檔名
   DEFINE l_sql       STRING
   DEFINE l_str       STRING

   #--If the field document is refer as URL, then display it directly
   #--Otherwise, fetch binary data from DB, then compose a accessible URL
   LET ls_name = cs_getFieldDocumentExtension()
   IF cl_null(ls_name) THEN
      LET l_str = CURRENT HOUR TO FRACTION(5)
      LET l_str = g_today USING "YYMMDD",l_str.subString(1,2),l_str.subString(4,5),l_str.subString(7,8),l_str.subString(10,14)
      LET ls_name = l_str
   END IF
   #--
   LET ls_fname = gs_tempdir, "/", ls_name

   CASE
      WHEN g_key.class = '1'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_imc10 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_imc_file",
                     " WHERE ",gs_wc CLIPPED
      WHEN g_key.class = '2'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_sig02 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_sig_file",
                     " WHERE ",gs_wc CLIPPED
      WHEN g_key.class = '3'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_qce05 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_qce_file",
                     " WHERE ",gs_wc CLIPPED

#add by zl 170405 begin
      WHEN g_key.class = '4'
         CASE
            WHEN g_key.str = '1'
               LET l_sql = "SELECT tc_zo02 "
            OTHERWISE EXIT CASE
         END CASE
         LET l_sql = l_sql CLIPPED,
                     "  FROM tc_zo_file",
                     " WHERE ",gs_wc CLIPPED
#add by zl 170405 end

      OTHERWISE EXIT CASE
   END CASE

   PREPARE cs_qc_pic_p3 FROM l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err("prepare cs_qc_pic_p3 : ", SQLCA.SQLCODE, 0)
      RETURN FALSE
   END IF

   LOCATE g_key.tc_imc10 IN FILE ls_fname

   EXECUTE cs_qc_pic_p3 INTO g_key.tc_imc10
   IF SQLCA.sqlcode THEN
      RUN "rm -f " || ls_fname
      CALL cl_err("sel pic",SQLCA.sqlcode,1)
      RETURN FALSE
   ELSE
      IF gi_picPrint=TRUE AND gi_printSource="2" THEN
         LET ls_ext = cs_getFieldDocumentExtension()
         LET ls_ext = ls_ext.toUpperCase()
         LET ls_cliTemp = cl_client_env("TEMP")
         IF cl_null(ls_cliTemp) THEN
            LET ls_cliTemp = cl_client_env("TMP")
         END IF
         LET ls_clifname = ls_cliTemp,"\\", ls_name
         IF NOT cl_download_file(ls_fname,ls_clifname) THEN
            CALL cl_err(NULL, "lib-350", 1)
            RETURN FALSE
         END IF
      END IF

      LET lch_pipe = base.Channel.create()
      CALL lch_pipe.openPipe("ls -al " || ls_fname, "r")
      WHILE lch_pipe.read(ls_buf)
      END WHILE
      IF NOT ( ( ls_buf.subString(2, 3) = "rw" ) AND
               ( ls_buf.subString(5, 6) = "rw" ) AND
               ( ls_buf.subString(8, 9) = "rw" ) ) THEN
         RUN "chmod 666 " || ls_fname
      END IF
      CALL lch_pipe.close()

      IF gi_picPrint = FALSE THEN
         LET gs_location = gs_fglasip, "/tiptop/out/", ls_name
      ELSE
         IF ls_ext = "JPG"  or ls_ext = "JPE"  or ls_ext = "JPEG" or
            ls_ext = "BMP"  or ls_ext = "PCX" THEN
            IF gi_printSource = "2" THEN
              LET gs_location = ls_clifname
            ELSE
              LET gs_location = ls_fname
            END IF
         ELSE
            LET gs_location = "err"
         END IF
      END IF
   END IF

   RETURN TRUE
END FUNCTION

#取得上傳圖片檔名
FUNCTION cs_getFieldDocumentName()
   DEFINE lst_tok    base.StringTokenizer
   DEFINE ls_fname   STRING

   #--Get file name from given file location
   LET lst_tok = base.StringTokenizer.create(gs_location, '/')
   WHILE lst_tok.hasMoreTokens()
       LET ls_fname = lst_tok.nextToken()
   END WHILE
   #--

   RETURN ls_fname
END FUNCTION

#取得上傳圖片檔名
FUNCTION cs_getFieldDocumentExtension()
   DEFINE lst_tok    base.StringTokenizer
   DEFINE ls_name    STRING,
          ls_token   STRING
   DEFINE l_str      STRING

   #--Get extension name of file, for doocument openen usage
   LET ls_name = cs_getFieldDocumentName()
   LET lst_tok = base.StringTokenizer.create(ls_name, '.')
   IF lst_tok.countTokens() = 1 THEN
      RETURN NULL
   ELSE
      WHILE lst_tok.hasMoreTokens()
          LET ls_token = lst_tok.nextToken()
      END WHILE
      RETURN ls_token
   END IF
   #--
END FUNCTION
