# Prog. Version..: '5.30.18-15.05.12(00010)'     #
#
# Library name...: cl_doc.4gl
# Descriptions...: 相關文件處理函式
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 2005/05/19 MOD-550142 by Brendan : reset INT_FLAG after exit DISPLAY ARRAY
# Modify.........: No.TQC-630109 06/03/10 By saki Array最大筆數控制
# Modify.........: No.FUN-640207 06/04/19 By Alexstar 客戶需要之新功能:(高鼎)
#                                                     限制『一張單最多相關資料筆數、每筆Doc夾檔最大容量』
# Modify.........: No.TQC-680113 06/08/23 By Echo 更改傳送至EF的附件檔名
# Modify.........: No.FUN-690005 06/09/04 By cheunl  欄位型態定義，改為LIKE
# Modify.........: No.MOD-690128 06/11/10 By Echo 調整{+}分隔符號時的程式段落，修正組where的條件。
# Modify.........: NO.FUN-640161 07/01/16 BY yiting cl_err->cl_err3
# Modify.........: No.TQC-760155 07/06/20 By JackLai 修正傳送多個相關文件到 EasyFlowGP 時, 第二個附件之後檔案的副檔名不正確
# Modify.........: No.MOD-780006 07/08/06 By Smapmin XML 特殊字元處理功能
# Modify.........: No.FUN-790020 07/09/11 By Brendan 修正 GP 5X Primary Key 功能時無法新增相關文件
# Modify.........: No.FUN-890073 08/09/15 By Vicky 限制送簽中的單據，相關文件不允許新增、修改及刪除
# Modify.........: No.FUN-9B0098 09/01/22 By tommas 刪除單據時，應一併刪除相關文件 
# Modify.........: No.FUN-AB0040 10/11/10 By Kevin 調整Sybase文件存取方式
# Modify.........: No.FUN-B10061 11/01/25 BY jrg542 利用BDL file management 可以在WINDOWS及UNIX使用
# Modify.........: No.MOD-B40246 11/04/26 BY jrg542 修正所產生的permission denied
# Modify.........: No.FUN-B50108 11/05/18 By Kevin 維護function資訊(p_findfunc)
# Modify.........: No.FUN-BA0001 11/10/04 By jrg542 新增 / 刪除 / 更新 附件檔案時，均需要進行系統層級的 log
# Modify.........: No.TQC-BB0122 11/11/16 BY ka0132 修正附檔產生時客戶端附件檔案size為0
# Modify.........: No:DEV-C50001 12/05/08 By joyce 開啟附件時應依"啟用附件異動紀錄"(azz15)選項決定要記錄的動作
# Modify.........: No.FUN-C50069 13/03/04 BY laura 型式:URL超連結選項增加瀏覽按鈕,提供選擇網路芳鄰上檔案及網路磁碟上的檔案路徑
# Modify.........: No.FUN-DA0107 13/11/08 BY kevin 整合EasyFlow 新增http 取附件
# Modify.........: No.FUN-E30028 14/04/28 By ycchao 相關文件新增FILE類型,存放實體檔案

IMPORT os # No.FUN-B10061

DATABASE ds
GLOBALS "../../config/top.global"
 
DEFINE ga_gca       DYNAMIC ARRAY OF RECORD LIKE gca_file.*
DEFINE ga_gcb       DYNAMIC ARRAY OF RECORD LIKE gcb_file.*
DEFINE ga_doc       DYNAMIC ARRAY OF RECORD
                       a06   LIKE gca_file.gca06,
                       b02   LIKE gcb_file.gcb02,
                       b05   LIKE gcb_file.gcb05
                    END RECORD
DEFINE gr_gca       RECORD LIKE gca_file.*,
       gr_gcb       RECORD LIKE gcb_file.*
DEFINE gr_gca_t     RECORD LIKE gca_file.*,    #舊值
       gr_gcb_t     RECORD LIKE gcb_file.*     #舊值
DEFINE gs_location  STRING
DEFINE g_rec_b      LIKE type_file.num5,         #No.FUN-690005 SMALLINT
       l_ac         LIKE type_file.num5          #No.FUN-690005 SMALLINT
DEFINE gs_wc        STRING,
       gs_tempdir   STRING,
       gs_fglasip   STRING
DEFINE gr_key       RECORD
                       gca01 LIKE gca_file.gca01,
                       gca02 LIKE gca_file.gca02,
                       gca03 LIKE gca_file.gca03,
                       gca04 LIKE gca_file.gca04,
                       gca05 LIKE gca_file.gca05
                    END RECORD
DEFINE gr_rec_count    LIKE type_file.num5          #No.FUN-690005 SMALLINT    #FUN-640207
DEFINE g_formnum       STRING    #FUN-890073
DEFINE ls_msg_syslog   STRING                       #No.FUN-BA0001
DEFINE l_azz15         LIKE azz_file.azz15          #No:DEV-C50001
DEFINE ga_gca1       DYNAMIC ARRAY OF RECORD LIKE gca_file.*  #ycchao
DEFINE ga_gcb1       DYNAMIC ARRAY OF RECORD LIKE gcb_file.*  #ycchao
 
##########################################################################
# Descriptions...: Document Management
# Memo...........:                       
# Input parameter: none
# Return code....: void
# Usage..........: CALL cl_doc()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_doc()
  DEFINE li_i   LIKE type_file.num10     #No.FUN-690005  INTEGER
  DEFINE l_str STRING #FUN-B10061  
 
  LET g_formnum = ""    #FUN-890073
  LET l_str = "" 
  
  WHENEVER ERROR CALL cl_err_msg_log
 
  OPEN WINDOW doc_w WITH FORM "lib/42f/cl_doc"
 
  CALL cl_ui_locale("cl_doc")
  
  LET gs_tempdir = FGL_GETENV("TEMPDIR")
  LET gs_fglasip = FGL_GETENV("FGLASIP")

  SELECT * INTO g_aza.* FROM aza_file   #FUN-E30028
 
  #--Compose KEY value
  LET gr_key.gca01 = g_doc.column1 CLIPPED || "=" || g_doc.value1 CLIPPED
  LET gr_key.gca02 = g_doc.column2 CLIPPED || "=" || g_doc.value2 CLIPPED
  LET gr_key.gca03 = g_doc.column3 CLIPPED || "=" || g_doc.value3 CLIPPED
  LET gr_key.gca04 = g_doc.column4 CLIPPED || "=" || g_doc.value4 CLIPPED
  LET gr_key.gca05 = g_doc.column5 CLIPPED || "=" || g_doc.value5 CLIPPED
  #--

  # No:DEV-C50001 ---start---
  SELECT azz15 INTO l_azz15 FROM azz_file
  # No:DEV-C50001 --- end ---
 
  CALL cl_documentList()

  INITIALIZE g_doc.* TO NULL     #No.FUN-9B0098

  CLOSE WINDOW doc_w
 
  #--Garbage collection   ;)
  FOR li_i = 1 TO ga_gca.getLength()
       #RUN "rm -f " || ga_gca[li_i].gca07 CLIPPED || "*" #FUN-B10061
       LET l_str = ga_gca[li_i].gca07 CLIPPED
       IF  os.Path.exists(l_str) THEN
           IF os.Path.delete(l_str CLIPPED || "*") THEN END IF      
       END IF
         
  END FOR
  #--
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 文件列表
# Memo...........:
# Input parameter: none
# Return code....: void
# Usage..........: CALL cl_documentList()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_documentList()
  DEFINE li_i     LIKE type_file.num10,   #No.FUN-690005   INTEGER,
         li_cnt   LIKE type_file.num10,   #No.FUN-690005   INTEGER,
         li_pos   LIKE type_file.num10,   #No.FUN-690005   INTEGER
         l_cnt    LIKE type_file.num10,   #FUN-890073
         l_azg04  LIKE azg_file.azg04,    #FUN-890073
         l_sql    STRING                  #FUN-890073
 
 
  LET l_azg04 = ""                        #FUN-890073
 
  
  IF NOT cl_getDocument() THEN
     CALL cl_err(NULL, "lib-211", 1)
     RETURN
  END IF
 
  #--Compose array for document list 
  CALL ga_doc.clear()
  FOR li_i = 1 TO g_rec_b
      LET ga_doc[li_i].a06 = ga_gca[li_i].gca06
      LET ga_doc[li_i].b02 = ga_gcb[li_i].gcb02
      LET ga_doc[li_i].b05 = ga_gcb[li_i].gcb05
  END FOR
  #--
 
  #-FUN-890073--start--若為EF整合單據,抓取該單據送簽狀態值
  SELECT COUNT(*) INTO l_cnt FROM wsd_file WHERE wsd01 = g_prog
  IF l_cnt > 0 THEN
     LET g_formnum = g_doc.value1 CLIPPED     #key值
     IF NOT cl_null(gr_key.gca02) THEN
        LET g_formnum = g_formnum, "{+}", gr_key.gca02 CLIPPED
     END IF
     IF NOT cl_null(gr_key.gca03) THEN
        LET g_formnum = g_formnum, "{+}", gr_key.gca03 CLIPPED
     END IF
     IF NOT cl_null(gr_key.gca04) THEN
        LET g_formnum = g_formnum, "{+}", gr_key.gca04 CLIPPED
     END IF
     IF NOT cl_null(gr_key.gca05) THEN
        LET g_formnum = g_formnum, "{+}", gr_key.gca05 CLIPPED
     END IF
     LET l_sql = "SELECT azg04 FROM azg_file WHERE azg01 = '",
                 g_formnum, "' ORDER BY azg02 DESC, azg03 DESC"
     PREPARE doc_prepare FROM l_sql
     DECLARE doc_thelast SCROLL CURSOR WITH HOLD FOR doc_prepare
     OPEN doc_thelast
     FETCH FIRST doc_thelast INTO l_azg04
     CLOSE doc_thelast
  END IF
  #-FUN-890073--end--
 
  DISPLAY ARRAY ga_doc TO s_doc.* ATTRIBUTE(COUNT = g_rec_b, UNBUFFERED)
 
      BEFORE DISPLAY
          CALL DIALOG.setActionHidden("accept", TRUE)
          CALL DIALOG.setActionHidden("cancel", TRUE)
          CALL DIALOG.setActionActive("open_document", FALSE)
          #-FUN-890073--start--若為送簽中單據,不允許新增,刪除,修改
          IF l_azg04 = '1' THEN
             CALL DIALOG.setActionActive("insert", FALSE)
             CALL DIALOG.setActionActive("modify", FALSE)
             CALL DIALOG.setActionActive("delete", FALSE)
          END IF
          #-FUN-890073--end--
 
      BEFORE ROW
          LET l_ac = ARR_CURR()
          IF ( l_ac != 0 ) AND ( ARR_COUNT() != 0 ) THEN
             #--Show document information
             LET gr_gca.* = ga_gca[l_ac].*
             LET gr_gcb.* = ga_gcb[l_ac].*
             LET gr_gca_t.* = gr_gca.*
             LET gr_gcb_t.* = gr_gcb.*
             CALL cl_documentInformation()
 
             IF gr_gcb.gcb02 = "TXT" THEN
                CALL DIALOG.setActionActive("open_document", FALSE)
             ELSE
                CALL DIALOG.setActionActive("open_document", TRUE)
             END IF
             #--
          END IF
 
      AFTER DISPLAY
          CONTINUE DISPLAY
 
      ON ACTION insert
            #FUN-640207---start---
            CALL cl_countDocument() 
            IF gr_rec_count >= g_aza.aza54 AND g_aza.aza54 > 0 THEN 
              CALL cl_err(NULL,"lib-157",1)
              CONTINUE DISPLAY
            END IF 
            #FUN-640207---end---
          IF cl_createDocument() THEN
             CALL cl_err(NULL, "lib-203", 1)
             ACCEPT DISPLAY
          ELSE
             IF INT_FLAG THEN
                LET INT_FLAG = FALSE
             ELSE
                CALL cl_err(NULL, "lib-204", 1)
                ACCEPT DISPLAY
             END IF
          END IF
 
      ON ACTION open_document
          IF ARR_CURR() != 0 THEN
             IF NOT cl_openDocument() THEN
                CALL cl_err(NULL, "lib-205", 1)
             END IF
          END IF
 
      ON ACTION delete
          IF ARR_CURR() != 0 THEN
             IF NOT cl_checkDocumentPermission(gr_gcb.gcb12, gr_gcb.gcb13, gr_gcb.gcb14) THEN
                CALL cl_err(NULL, "lib-210", 1)
             ELSE
                IF cl_delete() THEN
                   IF cl_deleteDocument() THEN
                      CALL cl_err(NULL, "lib-206", 1)
                      ACCEPT DISPLAY
                   ELSE
                      CALL cl_err(NULL, "lib-207", 1)
                      ACCEPT DISPLAY
                   END IF
                END IF
             END IF
          END IF
 
      ON ACTION modify
          IF ARR_CURR() != 0 THEN
             IF NOT cl_checkDocumentPermission(gr_gcb.gcb12, gr_gcb.gcb13, gr_gcb.gcb14) THEN
                CALL cl_err(NULL, "lib-210", 1)
             ELSE
                IF cl_modifyDocument() THEN
                   CALL cl_err(NULL, "lib-208", 1)
                   ACCEPT DISPLAY
                ELSE
                   IF INT_FLAG THEN
                      LET INT_FLAG = FALSE
                   ELSE
                      CALL cl_err(NULL, "lib-209", 1)
                      ACCEPT DISPLAY
                   END IF
                END IF
             END IF
          END IF
 
      ON ACTION locale
          CALL cl_dynamic_locale()
 
      ON ACTION exit
          EXIT DISPLAY
 
      ON ACTION cancel
          EXIT DISPLAY
 
      ON ACTION accept
          IF ARR_CURR() != 0 THEN
             IF NOT cl_openDocument() THEN
                CALL cl_err(NULL, "lib-205", 1)
             END IF
          END IF

      #ON ACTION batch_move   #ycchao
      #   CALL cl_doc_batch_move()
 
      ON IDLE g_idle_seconds
          CALL cl_on_idle()
          EXIT DISPLAY
 
  END DISPLAY
 #--- MOD-550142
  IF INT_FLAG THEN
     LET INT_FLAG = FALSE
  END IF
#---
END FUNCTION
 
#FUN-640207---start---
##########################################################################
# Private Func...: TRUE
# Descriptions...: 文件筆數
# Memo...........:
# Input parameter: none
# Return code....: void
# Usage..........: CALL cl_countDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_countDocument()
  DEFINE g_sql STRING
 
  LET g_sql = "SELECT count(*) FROM gca_file WHERE ", gs_wc, 
              # " AND gca08 IN ('DOC', 'URL', 'TXT') AND gca11 = 'Y' "   #mark by FUN-E30028
              " AND gca08 IN ('DOC','URL','TXT','FILE') AND gca11 = 'Y' "  #FUN-E30028
 
  PREPARE p_sql_precount FROM g_sql
  EXECUTE p_sql_precount INTO gr_rec_count
END FUNCTION
#FUN-640207---end---
 
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 抓取文件資料
# Memo...........:
# Input parameter: none
# Return code....: TRUE/FALSE   正確否
# Usage..........: CALL cl_getDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_getDocument()
  DEFINE ls_sql   STRING
  DEFINE li_cnt   LIKE type_file.num10    #No.FUN-690005   INTEGER
 
 
  CALL ga_gca.clear()
  CALL ga_gcb.clear()
 
  #--Compose WHERE condition for document selection
  LET gs_wc = "gca01 = '", gr_key.gca01 CLIPPED, "'"
  #-- No.FUN-790020 BEGIN ------------------------------------------------------
  # Primary Key 不允許塞入 NULL, 故以空白替代
  #-----------------------------------------------------------------------------
  IF NOT cl_null(gr_key.gca02) THEN
     LET gs_wc = gs_wc, " AND gca02 = '", gr_key.gca02 CLIPPED, "'"
  ELSE
     LET gs_wc = gs_wc, " AND gca02 = ' '"
  END IF
  IF NOT cl_null(gr_key.gca03) THEN
     LET gs_wc = gs_wc, " AND gca03 = '", gr_key.gca03 CLIPPED, "'"
  ELSE
     LET gs_wc = gs_wc, " AND gca03 = ' '"
  END IF
  IF NOT cl_null(gr_key.gca04) THEN
     LET gs_wc = gs_wc, " AND gca04 = '", gr_key.gca04 CLIPPED, "'"
  ELSE
     LET gs_wc = gs_wc, " AND gca04 = ' '"
  END IF
  IF NOT cl_null(gr_key.gca05) THEN
     LET gs_wc = gs_wc, " AND gca05 = '", gr_key.gca05 CLIPPED, "'"
  ELSE
     LET gs_wc = gs_wc, " AND gca05 = ' '"
  END IF
  #-- No.FUN-790020 END --------------------------------------------------------
  LET ls_sql = "SELECT gca_file.* FROM gca_file WHERE ", gs_wc, 
               #" AND gca08 IN ('DOC', 'URL', 'TXT') AND gca11 = 'Y' ORDER BY gca06"   #mark by FUN-E30028
                " AND gca08 IN ('DOC','URL','TXT','FILE') AND gca11 = 'Y' ORDER BY gca06"  #FUN-E30028
  #--
 
  DECLARE doc_cur CURSOR FROM ls_sql
  IF SQLCA.SQLCODE THEN
     CALL cl_err("declare doc_cur: ", SQLCA.SQLCODE, 0)
     RETURN FALSE
  END IF
 
  LET li_cnt = 1
  FOREACH doc_cur INTO ga_gca[li_cnt].*
      IF SQLCA.SQLCODE THEN
         CALL cl_err("foreach gca_file: ", SQLCA.SQLCODE, 0)
         EXIT FOREACH
      END IF
      
      #--Select document information(detail)
      LOCATE ga_gcb[li_cnt].gcb09 IN MEMORY
#      LOCATE ga_gcb[li_cnt].gcb09 IN FILE

      IF cl_db_get_database_type() = "ASE" THEN      #FUN-AB0040
         SELECT gcb01,gcb02,gcb03,gcb04,gcb05,gcb06,gcb07,gcb08,null,
                gcb10,gcb11,gcb12,gcb13,gcb14,gcb15,gcb16,gcb17,gcb18 
           INTO ga_gcb[li_cnt].*
           FROM gcb_file 
          WHERE gcb01 = ga_gca[li_cnt].gca07 AND
                gcb02 = ga_gca[li_cnt].gca08 AND
                gcb03 = ga_gca[li_cnt].gca09 AND
                gcb04 = ga_gca[li_cnt].gca10

         SELECT gcb09 INTO ga_gcb[li_cnt].gcb09
           FROM gcb_file 
          WHERE gcb01 = ga_gca[li_cnt].gca07 AND
                gcb02 = ga_gca[li_cnt].gca08 AND
                gcb03 = ga_gca[li_cnt].gca09 AND
                gcb04 = ga_gca[li_cnt].gca10

      ELSE

        SELECT gcb_file.* INTO ga_gcb[li_cnt].* FROM gcb_file 
         WHERE gcb01 = ga_gca[li_cnt].gca07 AND
               gcb02 = ga_gca[li_cnt].gca08 AND
               gcb03 = ga_gca[li_cnt].gca09 AND
               gcb04 = ga_gca[li_cnt].gca10
      END IF

      IF SQLCA.SQLCODE THEN
         CALL cl_err3("sel","gcb_file",ga_gca[li_cnt].gca07,ga_gca[li_cnt].gca08,SQLCA.sqlcode,"","",0)   #No.FUN-640161
         #CALL cl_err("select gcb_file: ", SQLCA.SQLCODE, 0)
         CONTINUE FOREACH
      END IF
      FREE ga_gcb[li_cnt].gcb09
      IF NOT cl_checkDocumentPermission(ga_gcb[li_cnt].gcb11, ga_gcb[li_cnt].gcb13, ga_gcb[li_cnt].gcb14) THEN
         CALL ga_gcb.deleteElement(li_cnt)
         CONTINUE FOREACH
      END IF
      #--
 
      LET li_cnt = li_cnt + 1
      #No.TQC-630109 --start--
      IF li_cnt > g_max_rec THEN
         CALL cl_err( '', 9035, 0 )
         EXIT FOREACH
      END IF
      #No.TQC-630109 ---end---
  END FOREACH
  CALL ga_gca.deleteElement(li_cnt) 
  LET g_rec_b = li_cnt - 1
 
  RETURN TRUE
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 新增文件資料
# Memo...........:
# Input parameter: none
# Return code....: TRUE/FALSE   正確否
# Usage..........: CALL cl_createDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_createDocument()
  INITIALIZE gr_gcb.* TO NULL
  LET gs_location = NULL
 
  #--Initialize variable while creating a new document
  LET gr_gcb.gcb02 = "DOC"
  --LET gr_gcb.gcb03 = g_lang CLIPPED
  LET gr_gcb.gcb03 = "01"
  LET gr_gcb.gcb04 = "001"
  LET gr_gcb.gcb11 = "O"
  LET gr_gcb.gcb12 = "U"
  LET gr_gcb.gcb13 = g_user CLIPPED
  LET gr_gcb.gcb14 = g_grup CLIPPED
  LET gr_gcb.gcb15 = g_today CLIPPED
  #--
 
  #--Doing INPUT
  CALL cl_maintainDocument("insert")
  #--
 
  IF INT_FLAG THEN
     --LET INT_FLAG = FALSE
     RETURN FALSE
  END IF
 
  #--Insert the new document to DB
  IF cl_maintainDocumentRecord("insert") THEN
     RETURN TRUE
  ELSE
     RETURN FALSE
  END IF
  #--
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 開啟文件檔
# Memo...........:
# Input parameter: none
# Return code....: TRUE/FALSE   正確否
# Usage..........: CALL cl_openDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_openDocument()
  DEFINE ls_fname    STRING,
         ls_name     STRING,
         ls_url      STRING
  DEFINE li_status   LIKE type_file.num10    #No.FUN-690005   INTEGER
  DEFINE lch_pipe    base.Channel
  DEFINE ls_buf      STRING
  DEFINE ls_tempfname  STRING       #FUN-E30028
  DEFINE ls_cmd        STRING       #FUN-E30028
 
 
  LET li_status = TRUE
  CASE gr_gcb.gcb02
       WHEN "URL"
            #--When document is a hyper link, open this URL
            LET li_status = cl_open_url(gr_gcb.gcb10)
            #--
       WHEN "DOC"
            #--When document is a file reference, open it in browser
               #MOD-490262
            #LET ls_name = gr_gcb.gcb01 CLIPPED, ".", cl_getFileExtension()             #No.TQC-760155
            #LET ls_name = gr_gcb.gcb01 CLIPPED, ".", cl_getFileExtension(gr_gcb.gcb07)  #No.TQC-760155 
            LET ls_name = gr_gcb.gcb01 CLIPPED, ".", os.Path.extension(gr_gcb.gcb07)  # FUN-B10061
              #-- 
            #LET ls_fname = gs_tempdir, "/", ls_name  
            LET ls_fname = os.Path.join(gs_tempdir,ls_name) #FUN-B10061
            LOCATE gr_gcb.gcb09 IN FILE ls_fname
            SELECT gcb09 INTO gr_gcb.gcb09 FROM gcb_file 
             WHERE gcb01 = gr_gcb.gcb01 AND
                   gcb02 = gr_gcb.gcb02 AND
                   gcb03 = gr_gcb.gcb03 AND
                   gcb04 = gr_gcb.gcb04
            IF SQLCA.SQLCODE THEN
               #RUN "rm -f " || ls_fname 
                IF  os.Path.exists(ls_fname) THEN
                    IF os.Path.delete(ls_fname) THEN END IF      
                END IF
                CALL cl_err3("sel","gcb_file",gr_gcb.gcb01,gr_gcb.gcb02,SQLCA.sqlcode,"","select gcb09:",0)   #No.FUN-640161
               #CALL cl_err("select gcb09: ", SQLCA.SQLCODE, 0)
               LET li_status = FALSE
            ELSE
                #MOD-B40246 ---start---
               #--Change mode of this file
               #LET lch_pipe = base.Channel.create()
               #CALL lch_pipe.openPipe("ls -al " || ls_fname, "r") #FUN-B10061
	       #CALL lch_pipe.openPipe(ls_fname, "r")
               #WHILE lch_pipe.read(ls_buf)
               #END WHILE
                #MOD-B40246 ---end--- 
               #IF NOT ( ( ls_buf.subString(2, 3) = "rw" ) AND     #FUN-B10061
               #          ( ls_buf.subString(5, 6) = "rw" ) AND
               #         ( ls_buf.subString(8, 9) = "rw" ) ) THEN
               #   RUN "chmod 666 " || ls_fname
               #END IF
	       IF os.Path.chrwx(ls_fname,438) THEN #chmod 666 => 6*8^2 +6*8^1 +6*8^ #FUN-B10061
               END IF
               #CALL lch_pipe.close() #MOD-B40246
               #--
               LET ls_url = gs_fglasip, "/tiptop/out/", ls_name
               LET li_status = cl_open_url(ls_url)
            END IF
            #--
       #FUN-E30028 add start
       WHEN "FILE"
            LET ls_name = gr_gcb.gcb01 CLIPPED,".",os.Path.extension(gr_gcb.gcb07) 
            LET ls_fname = gr_gcb.gcb10
            LET ls_tempfname=gs_tempdir||os.path.separator()||ls_name
            LET ls_cmd= "cp " || gr_gcb.gcb10 || " " || ls_tempfname
            RUN ls_cmd

            IF os.Path.chrwx(ls_tempfname,438) THEN 
            END IF
            LET ls_url = gs_fglasip, "/tiptop/out/", ls_name
            LET li_status = cl_open_url(ls_url)
            SLEEP(5)
            LET ls_cmd= "rm -f " || ls_tempfname
            RUN ls_cmd
       #FUN-E30028 add end
  END CASE

  # No:DEV-C50001 ---start---
  IF NOT cl_null(l_azz15) AND l_azz15 = "1" THEN   # 表示所有動作都要記錄
     #進行系統紀錄
     LET ls_msg_syslog = "Open document: ",
                          g_prog CLIPPED,"--",gr_gcb.gcb01 CLIPPED,"--",
                          gr_gcb.gcb01 CLIPPED,"--",gr_gcb.gcb03 CLIPPED,"--",
                          gr_gcb.gcb04 CLIPPED,"--",gr_gcb.gcb05 CLIPPED,"--",
                          gr_gcb.gcb06 CLIPPED,"--",gr_gcb.gcb07 CLIPPED,"--",
                          gr_gcb.gcb08 CLIPPED,"--",gr_gcb.gcb09 CLIPPED,"--",
                          gr_gcb.gcb10 CLIPPED,"--",gr_gcb.gcb11 CLIPPED,"--",
                          gr_gcb.gcb12 CLIPPED,"--",gr_gcb.gcb13 CLIPPED,"--",
                          gr_gcb.gcb14 CLIPPED,"--",gr_gcb.gcb15 CLIPPED,"--",
                          gr_gcb.gcb16 CLIPPED,"--",gr_gcb.gcb17 CLIPPED,"--",
                          gr_gcb.gcb18 CLIPPED,"--"
     IF cl_syslog("A","G",ls_msg_syslog) THEN END IF
  END IF
  # No:DEV-C50001 --- end ---
  
  RETURN li_status
END FUNCTION 

##########################################################################
# Private Func...: TRUE
# Descriptions...: 文件資料
# Memo...........: 刪除單據時，刪除所有相關文件
# Input parameter: none
# Return code....: 
# Date & Author..: 2010/01/22 by tommas
# Modify.........:
##########################################################################
FUNCTION cl_del_doc()   #No.FUN-9B0098
   DEFINE l_sql  STRING
   DEFINE l_gcb01 LIKE gcb_file.gcb01
   DEFINE l_gca07 DYNAMIC ARRAY OF STRING   
   DEFINE tmp  LIKE gca_file.gca07
   DEFINE l_gcb10 LIKE gcb_file.gcb10   #FUN-E30028

   LET l_sql = l_sql, "gca01='", get_value(g_doc.column1, g_doc.value1), "' AND "
   LET l_sql = l_sql, "gca02='", get_value(g_doc.column2, g_doc.value2), "' AND "
   LET l_sql = l_sql, "gca03='", get_value(g_doc.column3, g_doc.value3), "' AND "
   LET l_sql = l_sql, "gca04='", get_value(g_doc.column4, g_doc.value4), "' AND "
   LET l_sql = l_sql, "gca05='", get_value(g_doc.column5, g_doc.value5), "' "

   DECLARE sdoc_pre CURSOR FROM "SELECT gca07 FROM gca_file WHERE " || l_sql
   IF SQLCA.SQLCODE THEN
      CALL cl_err("select gca07 : ", SQLCA.SQLCODE, 0)
      RETURN 
   END IF

   FOREACH sdoc_pre INTO tmp
      #FUN-E30028 add start
        DECLARE sdoc_pre2 CURSOR FOR SELECT gcb10 FROM gcb_file WHERE gcb01=tmp
      FOREACH sdoc_pre2 INTO l_gcb10 
         IF SQLCA.sqlcode THEN
            CALL cl_err('foreach',SQLCA.sqlcode,1)
            EXIT FOREACH
         END IF
         RUN "rm -f "||l_gcb10
      END FOREACH
      #FUN-E30028 add end

      EXECUTE IMMEDIATE "DELETE FROM gcb_file WHERE gcb01 ='" || tmp || "'"
   END FOREACH
   EXECUTE IMMEDIATE "DELETE FROM gca_file WHERE " || l_sql
   FREE sdoc_pre
   INITIALIZE g_doc.* TO NULL 
END FUNCTION

##########################################################################
# Private Func...: TRUE            #FUN-B50108
# Descriptions...: 合併資料
##########################################################################
FUNCTION get_value(p_col, p_val)      #No.FUN-9B0098
   DEFINE p_col STRING,
          p_val STRING

   IF cl_null(p_col) THEN 
      RETURN " "
   END IF
   RETURN p_col || "=" || p_val
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 刪除文件資料
# Memo...........:
# Input parameter: none
# Return code....: TRUE/FALSE   正確否
# Usage..........: CALL cl_deleteDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_deleteDocument()

  DEFINE li_status       LIKE type_file.num10   #No.FUN-690005   INTEGER
  
  LET li_status = TRUE
  BEGIN WORK
      
  EXECUTE IMMEDIATE "DELETE FROM gca_file WHERE " || gs_wc || " AND gca06 = " || gr_gca.gca06
  IF SQLCA.SQLCODE THEN
     CALL cl_err("delete gca_file: ", SQLCA.SQLCODE, 0)
     LET li_status = FALSE
  ELSE
     DELETE FROM gcb_file
      WHERE gcb01 = gr_gcb.gcb01 AND
            gcb02 = gr_gcb.gcb02 AND
            gcb03 = gr_gcb.gcb03 AND
            gcb04 = gr_gcb.gcb04
     IF SQLCA.SQLCODE THEN
        CALL cl_err("delete gcb_file: ", SQLCA.SQLCODE, 0)
        LET li_status = FALSE
     #FUN-E30028 add start
     ELSE
        RUN "rm -f "||gr_gcb.gcb10
     #FUN-E30028 add end
     END IF
  END IF
  
  IF NOT li_status THEN
     ROLLBACK WORK
     RETURN FALSE
  ELSE
     COMMIT WORK
     #No.FUN-BA0001 ---start
     #進行系統紀錄
     IF NOT cl_null(l_azz15) AND (l_azz15 = "1" OR l_azz15 = "2") THEN   # No:DEV-C50001
        LET ls_msg_syslog = "Delete document: ",
                            g_prog CLIPPED,"--",gr_gcb.gcb01 CLIPPED,"--",
                            gr_gcb.gcb01 CLIPPED,"--",gr_gcb.gcb03 CLIPPED,"--",
                            gr_gcb.gcb04 CLIPPED,"--",gr_gcb.gcb05 CLIPPED,"--",
                            gr_gcb.gcb06 CLIPPED,"--",gr_gcb.gcb07 CLIPPED,"--",
                            gr_gcb.gcb08 CLIPPED,"--",gr_gcb.gcb09 CLIPPED,"--",
                            gr_gcb.gcb10 CLIPPED,"--",gr_gcb.gcb11 CLIPPED,"--",
                            gr_gcb.gcb12 CLIPPED,"--",gr_gcb.gcb13 CLIPPED,"--",
                            gr_gcb.gcb14 CLIPPED,"--",gr_gcb.gcb15 CLIPPED,"--",
                            gr_gcb.gcb16 CLIPPED,"--",gr_gcb.gcb17 CLIPPED,"--",
                            gr_gcb.gcb18 CLIPPED,"--"
        IF cl_syslog("A","G",ls_msg_syslog) THEN END IF
     END IF
     #No.FUN-BA0001 ---end           

  END IF
 
  #--After successfully remove record from DB, also remove item from array variable
  CALL ga_gca.deleteElement(l_ac)
  CALL ga_gcb.deleteElement(l_ac)
  CALL ga_doc.deleteElement(l_ac)
  #--
 
  RETURN TRUE
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 修改文件資料
# Memo...........:
# Input parameter: none
# Return code....: TRUE/FALSE   正確否
# Usage..........: CALL cl_modifyDocument()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_modifyDocument()
  #--When in UPDATE mode, assign document location(from DB)
  IF gr_gcb.gcb02 = "URL" THEN
     LET gs_location = gr_gcb.gcb10
  ELSE
     LET gs_location = NULL
  END IF
  #--
 
  #--Initialize variable while modify a existing document
  LET gr_gcb.gcb16 = g_user CLIPPED
  LET gr_gcb.gcb17 = g_grup CLIPPED
  LET gr_gcb.gcb18 = g_today CLIPPED
  #--
 
  #--Doing INPUT
  CALL cl_maintainDocument("modify")
  #--
 
  IF INT_FLAG THEN
     --LET INT_FLAG = FALSE
     RETURN FALSE
  END IF
 
  #--Update DB record for modification
  IF cl_maintainDocumentRecord("modify") THEN
     RETURN TRUE
  ELSE
     RETURN FALSE
  END IF
  #--
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_maintainDocument(ps_mode)
  DEFINE ps_mode   STRING
 
 
  INPUT BY NAME gr_gcb.gcb02, gr_gcb.gcb03, gr_gcb.gcb04, gr_gcb.gcb05,
                gr_gcb.gcb06, gr_gcb.gcb11, gr_gcb.gcb12, gr_gcb.gcb13,
                gr_gcb.gcb14, gr_gcb.gcb15, gr_gcb.gcb16, gr_gcb.gcb17,
                gr_gcb.gcb18
               ,gr_gcb.gcb10   #FUN-E30028
      WITHOUT DEFAULTS
      ATTRIBUTE(UNBUFFERED)
 
      BEFORE INPUT
          IF ps_mode = "modify" THEN
             #--When in UPDATE mode, user can't modify KEY value field
             CALL DIALOG.setFieldActive("gcb02", FALSE)
             CALL DIALOG.setFieldActive("gcb03", FALSE)
             CALL DIALOG.setFieldActive("gcb04", FALSE)
             #--
 
             #--When in UPDATE mode, if user isn't creator, then he can't modify field for permission control
             IF g_user CLIPPED != gr_gcb.gcb13 CLIPPED THEN
                CALL DIALOG.setFieldActive("gcb11", FALSE)
                CALL DIALOG.setFieldActive("gcb12", FALSE)
             END IF
             #--
 
             IF gr_gcb.gcb02 = "TXT" THEN
                CALL DIALOG.setActionActive("document_location", FALSE)
             END IF
          END IF
          CALL cl_doc_set_entry()   #FUN-E30028
          CALL cl_doc_set_no_entry()  #FUN-E30028
 
      ON CHANGE gcb02
          #--If document type is 'DOC' or 'URL', then function for browsing document location should be enabled
          IF gr_gcb.gcb02 = "TXT" THEN
             CALL DIALOG.setActionActive("document_location", FALSE)
          ELSE
             CALL DIALOG.setActionActive("document_location", TRUE)
          END IF
          #--
          #FUN-E30028 add start
          CALL cl_doc_set_entry()
          CALL cl_doc_set_no_entry()
          IF gr_gcb.gcb02!='FILE' THEN
             LET gr_gcb.gcb10=''
             DISPLAY BY NAME gr_gcb.gcb10
          END IF
          #FUN-E30028 add end
 
      ON ACTION document_location
          CALL cl_documentLocation()
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         LET INT_FLAG = TRUE
         EXIT INPUT  
 
      AFTER INPUT
         IF INT_FLAG THEN
            CASE ps_mode
                 WHEN "insert"
                      INITIALIZE gr_gcb.* TO NULL
                 WHEN "modify"
                      LET gr_gcb.* = gr_gcb_t.*
            END CASE
            CALL cl_documentInformation()
            EXIT INPUT
         END IF
 
         IF gr_gcb.gcb02 != "TXT" AND cl_null(gs_location) THEN
            IF ( ps_mode = "insert" ) OR
               ( ps_mode = "modify" AND gr_gcb.gcb02 = "URL" ) THEN
               #--If user doesn't give document location when type is 'DOC' or 'URL', then prompt
               CALL cl_documentLocation()
               IF cl_null(gs_location) THEN
                  CONTINUE INPUT
               END IF
               #--
            END IF
         END IF
 
         #FUN-E30028 add start
         IF gr_gcb.gcb02='FILE' AND os.Path.exists(gr_gcb.gcb10) THEN
            IF NOT cl_confirm('lib-635') THEN #該路徑已存在同檔名資料，是否覆蓋?
               CONTINUE INPUT
            END IF
         END IF
         #FUN-E30028 add end

  END INPUT
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 文件位置
# Memo...........:
# Input parameter: none
# Return code....: void
# Usage..........: CALL cl_documentLocation()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_documentLocation()
  DEFINE ls_str        STRING,
         ls_file       STRING,
         ls_location   STRING
  DEFINE ls_gcb10      STRING  #FUN-E30028
 
  CASE gr_gcb.gcb02
       WHEN "DOC"
            LET ls_str = cl_getmsg("lib-201", g_lang)
            WHILE TRUE
                LET ls_location = gs_location
                PROMPT ls_str CLIPPED FOR gs_location
                    ATTRIBUTE(WITHOUT DEFAULTS)
 
                    ON ACTION accept
                        EXIT WHILE
 
                    ON ACTION cancel
                        LET gs_location = ls_location
                        EXIT WHILE
 
                    ON ACTION browse_document
                        LET ls_file = cl_browse_file()
                        IF ls_file IS NOT NULL THEN
                           LET gs_location = ls_file
                        END IF
 
                    ON IDLE g_idle_seconds
                        CALL cl_on_idle()
                        LET gs_location = ls_location
                        RETURN
 
                END PROMPT
            END WHILE
       #FUN-E30028 add start
       WHEN "FILE"
            LET ls_str = cl_getmsg("lib-201", g_lang)
            WHILE TRUE
                LET ls_location = gs_location
                PROMPT ls_str CLIPPED FOR gs_location
                    ATTRIBUTE(WITHOUT DEFAULTS)

                    ON ACTION accept
                        EXIT WHILE

                    ON ACTION cancel
                        LET gs_location = ls_location
                        EXIT WHILE
 
                    ON ACTION browse_document
                        LET ls_file = cl_browse_file()
                        LET gs_location = ls_file

                    ON IDLE g_idle_seconds
                        CALL cl_on_idle()
                        LET gs_location = ls_location
                        RETURN
                END PROMPT
            END WHILE
            LET ls_gcb10=ls_file
            WHILE ls_gcb10.getindexof(os.path.separator(),1) >0 
               LET ls_gcb10=ls_gcb10.substring(ls_gcb10.getindexof('/',1)+1,ls_gcb10.getlength())
            END WHILE
            IF g_aza.aza136[FGL_WIDTH(g_aza.aza136),FGL_WIDTH(g_aza.aza136)]=os.path.separator() THEN
               LET gr_gcb.gcb10=g_aza.aza136,ls_gcb10
            ELSE
               LET gr_gcb.gcb10=g_aza.aza136,os.path.separator(),ls_gcb10
            END IF
       #FUN-E30028 add end
       WHEN "URL" 
            LET ls_str = cl_getmsg("lib-202", g_lang)
            LET ls_location = gs_location
            PROMPT ls_str CLIPPED FOR gs_location
                ATTRIBUTE(WITHOUT DEFAULTS)
 
                #FUN-C50069 --start--
                ON ACTION browse_document
                   LET ls_file = cl_browse_file()
                   IF ls_file IS NOT NULL THEN
                      LET ls_location = cl_tran_url(ls_file)
                      LET gs_location = ls_location
                   END IF
                #FUN-C50069 --end--

                ON ACTION cancel
                    LET gs_location = ls_location
 
                ON IDLE g_idle_seconds
                    CALL cl_on_idle()
                    LET gs_location = ls_location
                    RETURN
 
            END PROMPT
  END CASE
 
  IF INT_FLAG THEN
     LET INT_FLAG = FALSE
  END IF
END FUNCTION
 
#FUN-C50069 --start--
FUNCTION cl_tran_url(ps_url)
   DEFINE ps_url       STRING
   DEFINE ls_browser   STRING
   DEFINE ls_tran_url  STRING
   DEFINE l_bufstr     base.StringBuffer

   WHENEVER ERROR CALL cl_err_msg_log
   LET l_bufstr = base.StringBuffer.create()
   CALL l_bufstr.clear()
   IF cl_null(ps_url) THEN
      RETURN FALSE
   END IF

   IF ps_url.getindexof("\/",1) THEN
      CALL l_bufstr.append(ps_url)
      CALL l_bufstr.replace("\/","\\",0)
      LET ls_tran_url = l_bufstr.tostring()
      RETURN ls_tran_url
   ELSE
      RETURN ps_url
   END IF
END FUNCTION
#FUN-C50069 --end--

##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_maintainDocumentRecord(ps_mode)
  DEFINE ps_mode     STRING
  DEFINE li_status   LIKE type_file.num10,   #No.FUN-690005    INTEGER,
         li_pos      LIKE type_file.num10,   #No.FUN-690005   INTEGER,
         li_max      LIKE type_file.num10    #No.FUN-690005   INTEGER
  DEFINE ls_msg      STRING,
         ls_sql      STRING,
         ls_docNum   STRING,
         ls_time     STRING,
         ls_fname    STRING
  DEFINE l_filesize  LIKE type_file.num10    #No.FUN-690005   INTEGER      #FUN-640207
  DEFINE lch_pipe    base.Channel #FUN-640207
  DEFINE ls_buf      STRING       #FUN-640207
  DEFINE lst_tok     base.StringTokenizer   #FUN-E30028
 
  CASE ps_mode
       WHEN "insert"
            PREPARE max_pre FROM "SELECT MAX(gca06) + 1 FROM gca_file WHERE " || gs_wc
            EXECUTE max_pre INTO li_max
            IF SQLCA.SQLCODE THEN
               CALL cl_err("select max(gca06): ", SQLCA.SQLCODE, 0)
               RETURN FALSE
            END IF
            IF cl_null(li_max) OR li_max <=0 THEN
               LET li_max = 1
            END IF
         
            #--Get a unique document number
            LET ls_time = TIME
            LET ls_docNum = gr_gcb.gcb02 CLIPPED, "-",
                            FGL_GETPID() USING "<<<<<<<<<<", "-",
                            TODAY USING "YYYYMMDD", "-",
                            ls_time.subString(1,2), ls_time.subString(4,5), ls_time.subString(7,8)
            #--
         
            LET gr_gcb.gcb01 = ls_docNum
         
            #-- No.FUN-790020 --------------------------------------------------
            # Primary Key 不允許塞入 NULL 值, 故以空白代替
            #-------------------------------------------------------------------
            IF cl_null(gr_key.gca02) THEN
               LET gr_key.gca02 = ' '
            END IF
            IF cl_null(gr_key.gca03) THEN
               LET gr_key.gca03 = ' '
            END IF
            IF cl_null(gr_key.gca04) THEN
               LET gr_key.gca04 = ' '
            END IF
            IF cl_null(gr_key.gca05) THEN
               LET gr_key.gca05 = ' '
            END IF
            #-- No.FUN-790020 END ----------------------------------------------
            LET gr_gca.gca01 = gr_key.gca01
            LET gr_gca.gca02 = gr_key.gca02
            LET gr_gca.gca03 = gr_key.gca03
            LET gr_gca.gca04 = gr_key.gca04
            LET gr_gca.gca05 = gr_key.gca05
            LET gr_gca.gca06 = li_max
            LET gr_gca.gca07 = gr_gcb.gcb01
            LET gr_gca.gca08 = gr_gcb.gcb02
            LET gr_gca.gca09 = gr_gcb.gcb03
            LET gr_gca.gca10 = gr_gcb.gcb04
            LET gr_gca.gca11 = 'Y'
            LET gr_gca.gca12 = gr_gcb.gcb13
            LET gr_gca.gca13 = gr_gcb.gcb14
            LET gr_gca.gca14 = gr_gcb.gcb15
            LET gr_gca.gca15 = gr_gcb.gcb16
            LET gr_gca.gca16 = gr_gcb.gcb17
            LET gr_gca.gca17 = gr_gcb.gcb18
 
       WHEN "modify"
            LET ls_docNum = gr_gcb.gcb01
            LET gr_gca.gca15 = gr_gcb.gcb16
            LET gr_gca.gca16 = gr_gcb.gcb17
            LET gr_gca.gca17 = gr_gcb.gcb18
  END CASE
 
  LOCATE gr_gcb.gcb09 IN MEMORY
  CASE gr_gcb.gcb02
       WHEN "DOC"
            IF NOT cl_null(gs_location) THEN
               #--If giving a file location, then upload to Server side and locate it
               LET gr_gcb.gcb07 = cl_getDocumentName()
               LET gr_gcb.gcb08 = "D"
               #LET ls_fname = gs_tempdir, "/", ls_docNum
               LET ls_fname = os.Path.join(gs_tempdir,ls_docNum) #FUN-B10061
               IF NOT cl_upload_file(gs_location, ls_fname) THEN
                  CALL cl_err(NULL, "lib-212", 1)
                  RETURN FALSE
               END IF
               
               #MOD-B40246---start---
               #FUN-640207---start---
               #LET lch_pipe = base.Channel.create()
               #CALL lch_pipe.openPipe("ls -al " || ls_fname || " | awk ' { print $5 }'", "r") 
               #CALL lch_pipe.openPipe(ls_fname || " | awk ' { print $5 }'", "r")  #FUN-B10061
               #WHILE lch_pipe.read(ls_buf)
               #END WHILE               
               #LET l_filesize = ls_buf #MOD-B40246
               #MOD-B40246---end---  
	       LET l_filesize = os.Path.size(ls_fname.trim() ) # 使用此指令即可取出檔案大小 #MOD-B40246 
               IF l_filesize > g_aza.aza55 AND g_aza.aza55 > 0 THEN
                  #CALL lch_pipe.openPipe("rm " || ls_fname , "r") 
	          IF os.Path.exists(ls_fname) THEN #FUN-B10061
		      IF os.Path.delete(ls_fname) THEN END IF      
                  END IF 
                  CALL cl_err(NULL, "lib-158", 1)
                  RETURN FALSE
               END IF
               #FUN-640207---end---
 
               FREE gr_gcb.gcb09
               LOCATE gr_gcb.gcb09 IN FILE ls_fname
               #--
            ELSE
               #--If not giving file location(UPDATE mode), then locate original one in DB
               SELECT gcb09 INTO gr_gcb.gcb09 FROM gcb_file
                WHERE gcb01 = gr_gcb.gcb01 AND
                      gcb02 = gr_gcb.gcb02 AND
                      gcb03 = gr_gcb.gcb03 AND
                      gcb04 = gr_gcb.gcb04
               IF SQLCA.SQLCODE THEN
                  CALL cl_err("select gcb09: ", SQLCA.SQLCODE, 0)
                  RETURN FALSE
               END IF
               #--
            END IF
       WHEN "URL"
            LET gr_gcb.gcb10 = gs_location
       #FUN-E30028 add start
       WHEN "FILE"
            IF NOT cl_null(gs_location) THEN
               #取檔名
               LET lst_tok = base.StringTokenizer.create(gr_gcb.gcb10, '/')
               WHILE lst_tok.hasMoreTokens()
                   LET ls_fname = lst_tok.nextToken()
               END WHILE
               LET gr_gcb.gcb07 = ls_fname

               LET gr_gcb.gcb08 = "F"
               LET ls_fname = gr_gcb.gcb10
               IF NOT cl_upload_file(gs_location,ls_fname) THEN
                  CALL cl_err(NULL, "lib-212", 1)
                  RETURN FALSE
               END IF
               LET l_filesize = os.Path.size(ls_fname.trim() ) # 使用此指令即可取出檔案大小
               IF l_filesize > g_aza.aza55 AND g_aza.aza55 > 0 THEN
                  IF os.Path.exists(ls_fname) THEN
                      IF os.Path.delete(ls_fname) THEN END IF
                  END IF 
                  CALL cl_err(NULL, "lib-158", 1)
                  RETURN FALSE
               END IF
            END IF
       #FUN-E30028 add end
  END CASE
 
  LET li_status = TRUE
  BEGIN WORK
 
  CASE ps_mode
       WHEN "insert"
            LET ls_msg = "insert gca_file: "
            INSERT INTO gca_file VALUES (gr_gca.*)
       WHEN "modify"
            LET ls_msg = "update gca_file: "
            LET ls_sql = "UPDATE gca_file",
                         "   SET gca15 = '", gr_gca.gca15 CLIPPED, "',",
                         "       gca16 = '", gr_gca.gca16 CLIPPED, "',",
                         "       gca17 = '", gr_gca.gca17 CLIPPED, "'",
                         " WHERE ", gs_wc, " AND ",
                         "       gca06 = ", gr_gca.gca06
            EXECUTE IMMEDIATE ls_sql
  END CASE
  IF SQLCA.SQLCODE THEN
     CALL cl_err(ls_msg, SQLCA.SQLCODE, 0)
     LET li_status = FALSE
  ELSE
     CASE ps_mode
          WHEN "insert"
               LET ls_msg = "insert gcb_file: "
               IF cl_db_get_database_type() = "ASE" THEN      #FUN-AB0040
                  INSERT INTO gcb_file(gcb01,gcb02,gcb03,gcb04,gcb05,gcb06,gcb07,gcb08,gcb10,
                                       gcb11,gcb12,gcb13,gcb14,gcb15,gcb16,gcb17,gcb18 )
                               VALUES (gr_gcb.gcb01,gr_gcb.gcb02,gr_gcb.gcb03,gr_gcb.gcb04,gr_gcb.gcb05,
                                       gr_gcb.gcb06,gr_gcb.gcb07,gr_gcb.gcb08,gr_gcb.gcb10,
                                       gr_gcb.gcb11,gr_gcb.gcb12,gr_gcb.gcb13,gr_gcb.gcb14,gr_gcb.gcb15,
                                       gr_gcb.gcb16,gr_gcb.gcb17,gr_gcb.gcb18 )
                  UPDATE gcb_file SET gcb09 = gr_gcb.gcb09
                   WHERE gcb01 = gr_gcb.gcb01 AND gcb02 = gr_gcb.gcb02 
                     AND gcb03 = gr_gcb.gcb03 AND gcb04 = gr_gcb.gcb04
               ELSE
                  INSERT INTO gcb_file VALUES (gr_gcb.*)
               END IF
          WHEN "modify"
               LET ls_msg = "update gcb_file: "
               UPDATE gcb_file 
                  SET gcb05 = gr_gcb.gcb05,
                      gcb06 = gr_gcb.gcb06,
                      gcb07 = gr_gcb.gcb07,
                      gcb08 = gr_gcb.gcb08,
                      gcb09 = gr_gcb.gcb09,
                      gcb10 = gr_gcb.gcb10,
                      gcb11 = gr_gcb.gcb11,
                      gcb12 = gr_gcb.gcb12,
                      gcb16 = gr_gcb.gcb16,
                      gcb17 = gr_gcb.gcb17,
                      gcb18 = gr_gcb.gcb18
                WHERE gcb01 = gr_gcb.gcb01 AND
                      gcb02 = gr_gcb.gcb02 AND
                      gcb03 = gr_gcb.gcb03 AND
                      gcb04 = gr_gcb.gcb04
     END CASE
     IF SQLCA.SQLCODE THEN
        CALL cl_err(ls_msg, SQLCA.SQLCODE, 0)
        LET li_status = FALSE
     END IF
  END IF
 
  #--Garbage collection   ;)
  FREE gr_gcb.gcb09
  IF ( gr_gcb.gcb02 = "DOC" ) AND ( NOT cl_null(gs_location) ) THEN
     #RUN "rm -f " || ls_fname #FUN-B10061
     IF os.Path.exists(ls_fname) THEN
       IF os.Path.delete(ls_fname) THEN END IF      
     END IF   
     
  END IF
  #--
 
  IF NOT li_status THEN
     ROLLBACK WORK
     RETURN FALSE
  ELSE
     COMMIT WORK
     #No.FUN-BA0001 ---start    
     #進行系統紀錄
     IF NOT cl_null(l_azz15) AND (l_azz15 = "1" OR l_azz15 = "2") THEN   # No:DEV-C50001
        CASE ps_mode
             WHEN "insert"
                LET ls_msg_syslog = "Add document:"
             WHEN "modify"
                LET ls_msg_syslog = "Update document:"
        END CASE
        IF NOT cl_null(ls_msg_syslog) THEN   # No:DEV-C50001
           LET ls_msg_syslog = ls_msg_syslog CLIPPED,
                               g_prog CLIPPED,"--",gr_gcb.gcb01 CLIPPED,"--",
                               gr_gcb.gcb01 CLIPPED,"--",gr_gcb.gcb03 CLIPPED,"--",
                               gr_gcb.gcb04 CLIPPED,"--",gr_gcb.gcb05 CLIPPED,"--",
                               gr_gcb.gcb06 CLIPPED,"--",gr_gcb.gcb07 CLIPPED,"--",
                               gr_gcb.gcb08 CLIPPED,"--",gr_gcb.gcb09 CLIPPED,"--",
                               gr_gcb.gcb10 CLIPPED,"--",gr_gcb.gcb11 CLIPPED,"--",
                               gr_gcb.gcb12 CLIPPED,"--",gr_gcb.gcb13 CLIPPED,"--",
                               gr_gcb.gcb14 CLIPPED,"--",gr_gcb.gcb15 CLIPPED,"--",
                               gr_gcb.gcb16 CLIPPED,"--",gr_gcb.gcb17 CLIPPED,"--",
                               gr_gcb.gcb18 CLIPPED,"--"
           IF cl_syslog("A","G",ls_msg_syslog) THEN END IF
        END IF
     END IF
     #No.FUN-BA0001 ---end
  END IF
 
  CASE ps_mode
       WHEN "insert"
            LET li_pos = ga_gca.getLength() + 1
       WHEN "modify"
            LET li_pos = l_ac
  END CASE
 
  #--Modify array variable refer to document record
  LET ga_gca[li_pos].* = gr_gca.*
  LET ga_gcb[li_pos].* = gr_gcb.*
  LET ga_doc[li_pos].a06 = ga_gca[li_pos].gca06
  LET ga_doc[li_pos].b02 = ga_gcb[li_pos].gcb02
  LET ga_doc[li_pos].b05 = ga_gcb[li_pos].gcb05
  #--
 
  RETURN TRUE
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 抓取文件名稱
# Memo...........:
# Input parameter: none
# Return code....: 文件名稱
# Usage..........: CALL cl_getDocumentName()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_getDocumentName()
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
 
##########################################################################
# Private Func...: TRUE
##########################################################################

#FUNCTION cl_getFileExtension(p_gcb07)      #No.TQC-760155 add parameter p_gcb07
#  DEFINE lst_tok    base.StringTokenizer
#  DEFINE ls_name    STRING,
#         ls_token   STRING
#  DEFINE p_gcb07    LIKE gcb_file.gcb07     #No.TQC-760155
#  
#  #--Get extension name of file, for doocument openen usage
#  #LET ls_name = gr_gcb.gcb07 CLIPPED       #No.TQC-760155
#  LET ls_name = p_gcb07 CLIPPED             #No.TQC-760155
#  LET lst_tok = base.StringTokenizer.create(ls_name, '.')
#  IF lst_tok.countTokens() = 1 THEN
#     RETURN NULL
#  ELSE
#     WHILE lst_tok.hasMoreTokens()
#         LET ls_token = lst_tok.nextToken()
#     END WHILE
#     RETURN ls_token
#  END IF
#  #--
#END FUNCTION
 
##########################################################################
# Private Func...: TRUE
# Descriptions...: 顯示文件資料
# Memo...........:
# Input parameter: none
# Return code....: void
# Usage..........: CALL cl_documentInformation()
# Date & Author..: 2004/04/13 by Brendan
# Modify.........: 
##########################################################################
FUNCTION cl_documentInformation()
  DISPLAY BY NAME gr_gcb.gcb02, gr_gcb.gcb03, gr_gcb.gcb04,
                  gr_gcb.gcb05, gr_gcb.gcb06, gr_gcb.gcb11,
                  gr_gcb.gcb12, gr_gcb.gcb13, gr_gcb.gcb14,
                  gr_gcb.gcb15, gr_gcb.gcb16, gr_gcb.gcb17,
                  gr_gcb.gcb18
                 ,gr_gcb.gcb10   #FUN-E30028
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_checkDocumentPermission(ps_type, ps_user, ps_group)
  DEFINE ps_type   STRING,
         ps_user   STRING,
         ps_group  STRING
 
  
  CASE ps_type
       WHEN "U"
            #--Check if user is same as creator
            IF g_user CLIPPED != ps_user CLIPPED THEN
               RETURN FALSE
            END IF
            #--
       WHEN "G"
            #--Check if user group is same as creator group
            IF g_grup CLIPPED != ps_group CLIPPED THEN
               RETURN FALSE
            END IF
            #--
  END CASE
 
  RETURN TRUE
END FUNCTION
 
## No.FUN-520008 ##
##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_doc_efGetDocument(p_key,p_XMLString)
DEFINE p_key                 STRING
DEFINE p_XMLString           STRING
DEFINE l_i                   LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_p1                  LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_p2                  LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_tag                 STRING
DEFINE l_wc                  STRING
DEFINE l_gcb02               LIKE gcb_file.gcb02    #FUN-E30028
 
      INITIALIZE gr_key.* TO NULL
 
      #若單號(g_form.SourceFormNum) 包含其他條件則擷取出來(以{+} 為區隔)
      LET l_i = 1
      LET l_tag = "{+}"
      LET l_p1 = p_key.getIndexOf(l_tag,1)
      IF l_p1 != 0 THEN
        #MOD-690128
        #LET l_wc = p_key.subString(1, l_p1-1)
        #LET gr_key.gca01 = l_wc
        #display gr_key.gca01
        #WHILE l_i <= p_key.getLength()
        # LET l_p1 = p_key.getIndexOf(l_tag,l_i)
        # LET l_p2 = p_key.getIndexOf(l_tag,l_p1+3)
        # IF l_p2 = 0 THEN
        #    LET l_wc = p_key.subString(l_p1+l_tag.getLength(),p_key.getLength())
        # ELSE
        #    LET l_wc = p_key.subString(l_p1+l_tag.getLength(),l_p2-1)
        # END IF
 
        # IF cl_null(gr_key.gca02) THEN
        #    LET gr_key.gca02 = l_wc
        # ELSE IF cl_null(gr_key.gca03) THEN
        #    LET gr_key.gca03 = l_wc
        # ELSE IF cl_null(gr_key.gca04) THEN
        #    LET gr_key.gca04 = l_wc
        # ELSE 
        #    LET gr_key.gca05 = l_wc
        # END IF
        # END IF
        # END IF
        # 
        # IF l_p2 = 0 THEN EXIT WHILE END IF
        # LET l_i = l_p2 - 1
 
        #END WHILE
        LET gr_key.gca01 = cl_doc_key(p_key,1)
        IF cl_null(gr_key.gca02) THEN
           LET gr_key.gca02 = cl_doc_key(p_key,2)
        END IF
        IF cl_null(gr_key.gca03) THEN
            LET gr_key.gca03 = cl_doc_key(p_key,3)
        END IF
        IF cl_null(gr_key.gca04) THEN
            LET gr_key.gca04 = cl_doc_key(p_key,4)
        END IF
        IF cl_null(gr_key.gca05) THEN
            LET gr_key.gca05 = cl_doc_key(p_key,5)
        END IF
        #END MOD-690128
 
      ELSE
          LET gr_key.gca01 = p_key
      END IF
 
      #-- No.FUN-790020 BEGIN --------------------------------------------------
      # Primary Key 不允許塞入 NULL 值, 故以空白代替
      #-------------------------------------------------------------------------
      IF cl_null(gr_key.gca02) THEN
         LET gr_key.gca02 = ' '
      END IF
      IF cl_null(gr_key.gca03) THEN
         LET gr_key.gca03 = ' '
      END IF
      IF cl_null(gr_key.gca04) THEN
         LET gr_key.gca04 = ' '
      END IF
      IF cl_null(gr_key.gca05) THEN
         LET gr_key.gca05 = ' '
      END IF
      #-- No.FUN-790020 END ----------------------------------------------------
 
      IF NOT cl_getDocument() THEN                  #判斷成功/失敗
         LET p_XMLString = p_XMLString CLIPPED,
             "  <ReturnInfo>", ASCII 10,
             "   <ReturnStatus>N</ReturnStatus>", ASCII 10,
             "   <ReturnDescribe>Documentation list fetched failed.</ReturnDescribe>", ASCII 10,
             "  </ReturnInfo>", ASCII 10
         RETURN p_XMLString
      END IF
 
      IF ga_gcb.getLength() = 0 THEN                 #無任何資料
         LET p_XMLString = p_XMLString CLIPPED,
             "  <ReturnInfo>", ASCII 10,
             "   <ReturnStatus>N</ReturnStatus>", ASCII 10,
             "   <ReturnDescribe>No documentation data.</ReturnDescribe>", ASCII 10,
             "  </ReturnInfo>", ASCII 10
         RETURN p_XMLString
      END IF      
 
      LET p_XMLString = p_XMLString CLIPPED,
          "  <ReturnInfo>", ASCII 10,
          "   <ReturnStatus>Y</ReturnStatus>", ASCII 10,
          "   <ReturnDescribe>No Error.</ReturnDescribe>", ASCII 10,
          "  </ReturnInfo>", ASCII 10,
          "  <ContentText>", ASCII 10,
          "    <DocumentList>", ASCII 10
 
      FOR l_i = 1 TO ga_gcb.getLength()               #文件 (DOC:檔案, URL:網址, TXT:文字)
          #FUN-E30028 add start
	  IF ga_gcb[l_i].gcb02 = 'FILE' THEN   
	     LET l_gcb02 = 'DOC'
	  ELSE
	     LET l_gcb02 = ga_gcb[l_i].gcb02
	  END IF
          #FUN0E30028 add end
          #-----MOD-780006---------
          LET ga_gcb[l_i].gcb01 = cl_xml_replaceStr(ga_gcb[l_i].gcb01)
          LET ga_gcb[l_i].gcb02 = cl_xml_replaceStr(ga_gcb[l_i].gcb02)
          LET ga_gcb[l_i].gcb03 = cl_xml_replaceStr(ga_gcb[l_i].gcb03)
          LET ga_gcb[l_i].gcb04 = cl_xml_replaceStr(ga_gcb[l_i].gcb04)
          LET ga_gcb[l_i].gcb05 = cl_xml_replaceStr(ga_gcb[l_i].gcb05)
          #-----END MOD-780006-----
          LET p_XMLString = p_XMLString CLIPPED,
          #"        <Document key=\"",ga_gcb[l_i].gcb01 CLIPPED, "|", ga_gcb[l_i].gcb02 CLIPPED, "|", ga_gcb[l_i].gcb03 CLIPPED, "|", ga_gcb[l_i].gcb04 CLIPPED,   #mark by FUN-E30028
          "        <Document key=\"",ga_gcb[l_i].gcb01 CLIPPED, "|", l_gcb02 CLIPPED, "|", ga_gcb[l_i].gcb03 CLIPPED, "|", ga_gcb[l_i].gcb04 CLIPPED,    #FUN-E30028
          "\" type=\"",ga_gcb[l_i].gcb02 CLIPPED,"\" desc=\"",ga_gcb[l_i].gcb05 CLIPPED,"\"/>", ASCII 10
      END FOR
 
      LET p_XMLString = p_XMLString CLIPPED,
          "    </DocumentList>", ASCII 10,
          "  </ContentText>", ASCII 10
 
      RETURN p_XMLString
 
END FUNCTION
 
##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_doc_efOpenDocument(p_key,p_XMLString,p_type)    #FUN-DA0107
DEFINE p_key                 STRING
DEFINE p_XMLString           STRING
DEFINE l_filename            STRING
DEFINE l_i                   LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_p1                  LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_p2                  LIKE type_file.num10    #No.FUN-690005  INTEGER       
DEFINE l_tag                 STRING
DEFINE l_wc                  STRING
DEFINE key1                  LIKE gcb_file.gcb01
DEFINE key2                  LIKE gcb_file.gcb02
DEFINE key3                  LIKE gcb_file.gcb03
DEFINE key4                  LIKE gcb_file.gcb04
DEFINE l_cmd                 STRING
DEFINE l_gcb                 RECORD like gcb_file.*  #No.TQC-BB0122 add
DEFINE p_type                STRING                  #FUN-DA0107
DEFINE l_dest                STRING                  #FUN-DA0107
 
      #以 | 為截取Document key值
      LET l_i = 1
      LET l_tag = "|"
      LET l_p1 = p_key.getIndexOf(l_tag,1)
      LET key1 = p_key.subString(1, l_p1-1)
      LET l_p2 = p_key.getIndexOf(l_tag,l_p1+1)
      LET key2 = p_key.subString(l_p1+1, l_p2-1)
      LET l_p1 = l_p2
      LET l_p2 = p_key.getIndexOf(l_tag,l_p1+1)
      LET key3 = p_key.subString(l_p1+1, l_p2-1)
      LET l_p1 = l_p2
      LET key4 = p_key.subString(l_p1+1, p_key.getLength())
              
      #--- No.TQC-BB0122 --- start ---
      #INITIALIZE gr_gcb.* TO NULL 
      LOCATE l_gcb.gcb09 IN MEMORY
      SELECT * INTO l_gcb.* FROM gcb_file WHERE gcb01 = key1 AND gcb02 = key2 AND gcb03 = key3 AND gcb04 = key4
      FREE l_gcb.gcb09
      LET gr_gcb.* = l_gcb.*
      #--- No.TQC-BB0122 ---  end  ---
 
      #-----MOD-780006---------
      LET gr_gcb.gcb01 = cl_xml_replaceStr(gr_gcb.gcb01)
      LET gr_gcb.gcb02 = cl_xml_replaceStr(gr_gcb.gcb02)
      LET gr_gcb.gcb06 = cl_xml_replaceStr(gr_gcb.gcb06)
      LET gr_gcb.gcb10 = cl_xml_replaceStr(gr_gcb.gcb10)
      #-----END MOD-780006-----
 
      LET p_XMLString = p_XMLString CLIPPED,
          "  <ReturnInfo>", ASCII 10,
          "   <ReturnStatus>Y</ReturnStatus>", ASCII 10,
          "   <ReturnDescribe>No Error.</ReturnDescribe>", ASCII 10,
          "  </ReturnInfo>", ASCII 10,
          "  <ContentText>", ASCII 10,
          "    <Document>", ASCII 10
      CASE gr_gcb.gcb02
        WHEN "DOC"
               	 LET p_XMLString = p_XMLString CLIPPED,
                 "       <Type>", gr_gcb.gcb02 ,"</Type>", ASCII 10

                 #TQC-680113
                 #LET l_filename = FGL_GETENV("TEMPDIR"),"/",gr_gcb.gcb01 CLIPPED,
                 #    FGL_GETPID() USING "<<<<<<<<<<", ".", cl_getFileExtension()
                 #LET l_filename = FGL_GETENV("TEMPDIR"),"/",gr_gcb.gcb01 CLIPPED,#FUN-B10061

                 #FUN-DA0107 start
                 #LET l_filename = FGL_GETENV("TEMPDIR"),os.Path.separator(),gr_gcb.gcb01 CLIPPED,
                 #                 ".", cl_getFileExtension()               #No.TQC-760155
                 #                 ".", cl_getFileExtension(gr_gcb.gcb07)    #No.TQC-760155
                 #                 ".", os.Path.extension(gr_gcb.gcb07)    #FUN-B10061
                 #END TQC-680113
                 
                 IF p_type = "http" THEN
                    LET l_filename = FGL_GETENV("TEMPDIR"), os.Path.separator() , "easyflow" , 
                                     os.Path.separator() , gr_gcb.gcb01 CLIPPED,
                                     ".", os.Path.extension(gr_gcb.gcb07) 
                 ELSE
                    LET l_filename = FGL_GETENV("TEMPDIR"),os.Path.separator(),gr_gcb.gcb01 CLIPPED,
                                     ".", os.Path.extension(gr_gcb.gcb07)    
                 END IF
                 #FUN-DA0107
               	 LOCATE gr_gcb.gcb09 IN FILE l_filename
               	 SELECT gcb09 INTO gr_gcb.gcb09 FROM gcb_file WHERE gcb01 = key1 AND gcb02 = key2 AND gcb03 = key3 AND gcb04 = key4
				 
                 #--- No.TQC-BB0122 --- start ---
                 display "STATUS=",STATUS   
                 display l_filename.trim()," -> file size:", os.Path.size(l_filename.trim())
                 IF os.Path.size(l_filename.trim()) = 0 THEN
                    LET p_XMLString = p_XMLString CLIPPED,
                        "  <ReturnInfo>", ASCII 10,
                        "   <ReturnStatus>N</ReturnStatus>", ASCII 10,
                        "   <ReturnDescribe> file size 0</ReturnDescribe>", ASCII 10,
                        "  </ReturnInfo>", ASCII 10
                    RETURN p_XMLString
                 END IF
                 #--- No.TQC-BB0122 ---  end  ---
				 
                 #LET l_cmd = "chmod 666 ",l_filename #FUN-10061
                 #RUN l_cmd 
                 IF os.Path.chrwx(l_filename,438) THEN #chmod 666 => 6*8^2 +6*8^1 +6*8^ #FUN-B10061
                 END IF
                       
                 #FUN-DA0107
                 #IF p_type = "http" THEN
                 #   LET p_XMLString = p_XMLString CLIPPED,
               	 #   "       <Content>",gr_gcb.gcb01 CLIPPED,"</Content>", ASCII 10  #只給檔名
                 #ELSE
                    LET p_XMLString = p_XMLString CLIPPED,
               	    "       <Content>",l_filename,"</Content>", ASCII 10
                 #END IF
                 #FUN-DA0107
        #FUN-E30028 add start
        WHEN "FILE" 
               	 LET p_XMLString = p_XMLString CLIPPED,
                 #"       <Type>", gr_gcb.gcb02 ,"</Type>", ASCII 10
                 "       <Type>", 'DOC' ,"</Type>", ASCII 10
                 LET l_filename = FGL_GETENV("TEMPDIR"),os.path.separator(),gr_gcb.gcb01 CLIPPED,
                                  ".",os.Path.extension(gr_gcb.gcb07) 
                 LET gr_gcb.gcb10=''
               	 SELECT gcb10 INTO gr_gcb.gcb10 FROM gcb_file 
                  WHERE gcb01 = key1 AND gcb02 = key2 
                    AND gcb03 = key3 AND gcb04 = key4
                 display "STATUS=",STATUS   
                 display l_filename.trim()," -> file size.", os.Path.size(l_filename.trim())
                 IF os.Path.size(l_filename.trim()) = 0 THEN
                    LET p_XMLString = p_XMLString CLIPPED,
                        "  <ReturnInfo>", ASCII 10,
                        "   <ReturnStatus>N</ReturnStatus>", ASCII 10,
                        "   <ReturnDescribe> file size 0</ReturnDescribe>", ASCII 10,
                        "  </ReturnInfo>", ASCII 10
                    RETURN p_XMLString
                 END IF
                 IF os.Path.chrwx(l_filename,438) THEN
                 END IF
               	 LET p_XMLString = p_XMLString CLIPPED,
               	 "       <Content>",l_filename,"</Content>", ASCII 10
        #FUN-E30028 add end
        WHEN "TXT"
               	 LET p_XMLString = p_XMLString CLIPPED,
                 "       <Type>", gr_gcb.gcb02 ,"</Type>", ASCII 10,
               	 "       <Content>",gr_gcb.gcb06,"</Content>", ASCII 10
        WHEN "URL"
               	 LET p_XMLString = p_XMLString CLIPPED,
                 "       <Type>", gr_gcb.gcb02 ,"</Type>", ASCII 10,
               	 "       <Content>",gr_gcb.gcb10,"</Content>", ASCII 10
			
      END CASE      
      LET p_XMLString = p_XMLString CLIPPED,
          "    </Document>", ASCII 10,
          "  </ContentText>", ASCII 10
      RETURN p_XMLString
END FUNCTION
## END No.FUN-520008 ##
 
#MOD-690128
##########################################################################
# Private Func...: TRUE
##########################################################################
FUNCTION cl_doc_key(p_str,p_key)
    DEFINE p_str       STRING
    DEFINE p_key       LIKE type_file.num10
    DEFINE l_tok       base.StringTokenizer
    DEFINE l_str       STRING
    DEFINE l_str2      STRING
    DEFINE l_cnt       LIKE type_file.num10
    DEFINE buf         base.StringBuffer
 
    LET l_str = ""
    LET buf = base.StringBuffer.create()
    CALL buf.append(p_str)
    CALL buf.replace( "{+}","|", 0)
    LET p_str = buf.toString()
 
    LET l_tok = base.StringTokenizer.createExt(p_str CLIPPED,"|","",TRUE)
    LET l_cnt = 0
    WHILE l_tok.hasMoreTokens()
         LET l_cnt = l_cnt + 1
         LET l_str = l_tok.nextToken()
         IF l_cnt = p_key THEN
             LET l_str2 = l_str
             LET l_str2 = l_str
             EXIT WHILE
         END IF
    END WHILE
    RETURN l_str2
 
END FUNCTION
#END MOD-690128

#FUN-E30028 add start
FUNCTION cl_doc_set_entry() 

   CALL cl_set_comp_entry("gcb10",TRUE)
END FUNCTION

FUNCTION cl_doc_set_no_entry()
  
   IF cl_null(gr_gcb.gcb02) OR gr_gcb.gcb02!='FILE' THEN
      CALL cl_set_comp_entry("gcb10",FALSE)
   END IF
END FUNCTION
#FUN-E30028 add end

#ycchao
{FUNCTION cl_doc_batch_move()
  DEFINE ls_sql   STRING
  DEFINE li_cnt   LIKE type_file.num10    
  DEFINE li_i   LIKE type_file.num10
  DEFINE ls_fname    STRING,
         ls_fname1   STRING,
         ls_name     STRING,
         ls_url      STRING
  DEFINE li_status   LIKE type_file.num10    
  DEFINE ls_gcb10    STRING
  DEFINE l_filesize  LIKE type_file.num10
  DEFINE ls_msg      STRING 
  DEFINE ls_cmd      STRING
 
  CALL ga_gca1.clear()
  CALL ga_gcb1.clear()

  LET ls_sql = "SELECT gca_file.* FROM gca_file WHERE ",
                "gca08 IN ('DOC') AND gca11 = 'Y' ORDER BY gca06" 
               # "gca01 like '%C1C1A01-0001-01' AND gca08 IN ('DOC') AND gca11 = 'Y' ORDER BY gca06" 

  DECLARE doc_cur1 CURSOR FROM ls_sql
  IF SQLCA.SQLCODE THEN
     CALL cl_err("declare doc_cur: ", SQLCA.SQLCODE, 0)
  END IF
 
  LET li_cnt = 1
  FOREACH doc_cur1 INTO ga_gca1[li_cnt].*
      IF SQLCA.SQLCODE THEN
         CALL cl_err("foreach gca_file: ", SQLCA.SQLCODE, 0)
         EXIT FOREACH
      END IF
      
      #--Select document information(detail)
      LOCATE ga_gcb1[li_cnt].gcb09 IN MEMORY

      IF cl_db_get_database_type() = "ASE" THEN      #FUN-AB0040
         SELECT gcb01,gcb02,gcb03,gcb04,gcb05,gcb06,gcb07,gcb08,null,
                gcb10,gcb11,gcb12,gcb13,gcb14,gcb15,gcb16,gcb17,gcb18 
           INTO ga_gcb1[li_cnt].*
           FROM gcb_file 
          WHERE gcb01 = ga_gca1[li_cnt].gca07 AND
                gcb02 = ga_gca1[li_cnt].gca08 AND
                gcb03 = ga_gca1[li_cnt].gca09 AND
                gcb04 = ga_gca1[li_cnt].gca10

         SELECT gcb09 INTO ga_gcb1[li_cnt].gcb09
           FROM gcb_file 
          WHERE gcb01 = ga_gca1[li_cnt].gca07 AND
                gcb02 = ga_gca1[li_cnt].gca08 AND
                gcb03 = ga_gca1[li_cnt].gca09 AND
                gcb04 = ga_gca1[li_cnt].gca10

      ELSE

        SELECT gcb_file.* INTO ga_gcb1[li_cnt].* FROM gcb_file 
         WHERE gcb01 = ga_gca1[li_cnt].gca07 AND
               gcb02 = ga_gca1[li_cnt].gca08 AND
               gcb03 = ga_gca1[li_cnt].gca09 AND
               gcb04 = ga_gca1[li_cnt].gca10
      END IF

      IF SQLCA.SQLCODE THEN
         CALL cl_err3("sel","gcb_file",ga_gca1[li_cnt].gca07,ga_gca1[li_cnt].gca08,SQLCA.sqlcode,"","",0)   #No.FUN-640161
         CONTINUE FOREACH
      END IF
      FREE ga_gcb1[li_cnt].gcb09
      #IF NOT cl_checkDocumentPermission(ga_gcb[li_cnt].gcb11, ga_gcb[li_cnt].gcb13, ga_gcb[li_cnt].gcb14) THEN
      #   CALL ga_gcb.deleteElement(li_cnt)
      #   CONTINUE FOREACH
      #END IF
      #--
 
      LET li_cnt = li_cnt + 1
  END FOREACH
  CALL ga_gca1.deleteElement(li_cnt) 
  LET g_rec_b = li_cnt - 1      

  FOR li_i = 1 TO g_rec_b
    LET li_status = TRUE
    LET ls_name = ga_gcb1[li_i].gcb01 CLIPPED, ".", os.Path.extension(ga_gcb1[li_i].gcb07) 
    LET ls_fname = os.Path.join(gs_tempdir,ls_name) #FUN-B10061
    LOCATE ga_gcb1[li_i].gcb09 IN FILE ls_fname
    SELECT gcb09 INTO ga_gcb1[li_i].gcb09 FROM gcb_file 
     WHERE gcb01 = ga_gcb1[li_i].gcb01 AND
           gcb02 = ga_gcb1[li_i].gcb02 AND
           gcb03 = ga_gcb1[li_i].gcb03 AND
           gcb04 = ga_gcb1[li_i].gcb04
    IF SQLCA.SQLCODE THEN 
        IF  os.Path.exists(ls_fname) THEN
            IF os.Path.delete(ls_fname) THEN END IF      
        END IF
        CALL cl_err3("sel","gcb_file",ga_gcb1[li_i].gcb01,ga_gcb1[li_i].gcb02,SQLCA.sqlcode,"","select gcb09:",0)   #No.FUN-640161
       LET li_status = FALSE
    ELSE

       IF os.Path.chrwx(ls_fname,438) THEN #chmod 666 => 6*8^2 +6*8^1 +6*8^ #FUN-B10061
       END IF
    END IF  

    LET ls_gcb10=ls_fname
    WHILE ls_gcb10.getindexof(os.path.separator(),1) >0 
       LET ls_gcb10=ls_gcb10.substring(ls_gcb10.getindexof('/',1)+1,ls_gcb10.getlength())
    END WHILE
    IF g_aza.aza136[FGL_WIDTH(g_aza.aza136),FGL_WIDTH(g_aza.aza136)]=os.path.separator() THEN
       LET ga_gcb1[li_i].gcb10=g_aza.aza136,ls_gcb10
    ELSE
       LET ga_gcb1[li_i].gcb10=g_aza.aza136,os.path.separator(),ls_gcb10
    END IF    

    LET ga_gcb1[li_i].gcb08 = "F"
    LET ls_fname1 = ga_gcb1[li_i].gcb10
    LET ls_cmd= "cp " || ls_fname || " " || ls_fname1
    RUN ls_cmd    
    #IF NOT cl_upload_file(ls_fname,ls_fname1) THEN
    #  CALL cl_err(NULL, "lib-212", 1)
    #END IF
    #LET l_filesize = os.Path.size(ls_fname.trim() ) # 使用此指令即可取出檔案大小
    #IF l_filesize > g_aza.aza55 AND g_aza.aza55 > 0 THEN
    #  IF os.Path.exists(ls_fname) THEN
    #      IF os.Path.delete(ls_fname) THEN END IF
    #  END IF 
    #  CALL cl_err(NULL, "lib-158", 1)
    #END IF    

    LET li_status = TRUE
    BEGIN WORK    

    LET ls_msg = "update gca_file: "  
    UPDATE gca_file
      SET gca08 = 'FILE'
    WHERE gca01 = ga_gca1[li_i].gca01 AND
          gca02 = ga_gca1[li_i].gca02 AND
          gca03 = ga_gca1[li_i].gca03 AND
          gca04 = ga_gca1[li_i].gca04 AND
          gca05 = ga_gca1[li_i].gca05 AND
          gca06 = ga_gca1[li_i].gca06 AND          
          gca07 = ga_gca1[li_i].gca07 AND
          gca08 = ga_gca1[li_i].gca08 AND
          gca09 = ga_gca1[li_i].gca09 AND
          gca10 = ga_gca1[li_i].gca10 

     IF SQLCA.SQLCODE THEN
        CALL cl_err(ls_msg, SQLCA.SQLCODE, 0)
        LET li_status = FALSE
     ELSE           

        LET ls_msg = "update gcb_file: "
        UPDATE gcb_file 
          SET gcb05 = ga_gcb1[li_i].gcb05,
              gcb06 = ga_gcb1[li_i].gcb06,
              gcb07 = ga_gcb1[li_i].gcb07,
              gcb08 = ga_gcb1[li_i].gcb08,
              gcb09 = '',
              gcb10 = ga_gcb1[li_i].gcb10,
              gcb11 = ga_gcb1[li_i].gcb11,
              gcb12 = ga_gcb1[li_i].gcb12,
              gcb16 = ga_gcb1[li_i].gcb16,
              gcb17 = ga_gcb1[li_i].gcb17,
              gcb18 = ga_gcb1[li_i].gcb18,
              gcb02 = 'FILE'
         WHERE gcb01 = ga_gcb1[li_i].gcb01 AND
              gcb02 = ga_gcb1[li_i].gcb02 AND
              gcb03 = ga_gcb1[li_i].gcb03 AND
              gcb04 = ga_gcb1[li_i].gcb04

         IF SQLCA.SQLCODE THEN
            CALL cl_err(ls_msg, SQLCA.SQLCODE, 0)
            LET li_status = FALSE
         END IF    
      END IF
      #--Garbage collection   ;)
     FREE ga_gcb1[li_i].gcb09
      #--
     
     IF NOT li_status THEN
         ROLLBACK WORK

     ELSE
         COMMIT WORK

     END IF     
  END FOR  

  CALL cl_err(NULL, "abm-113", 1)
END FUNCTION}
 
