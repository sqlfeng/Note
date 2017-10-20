SCHEMA ds

GLOBALS

   #執行作業
   DEFINE g_clienttype    LIKE type_t.chr1      #A:GMA/W:GWC/D:GDC
   DEFINE g_sessionkey    LIKE type_t.chr20     #TT Session Key=TIME+PID
   DEFINE g_parentsession LIKE type_t.chr20     #父層Session Key
   DEFINE g_parentprog    LIKE type_t.chr20     #父層作業編號 
   DEFINE g_prog          LIKE type_t.chr20     #作業編號 (gzzz001)
   DEFINE g_prog_industry LIKE type_t.chr10     #作業歸屬行業包
   DEFINE g_actdefault    LIKE type_t.chr20     #預設開啟動作
   DEFINE g_code          LIKE type_t.chr20     #程式編號 (gzza001)
   DEFINE g_template_type LIKE type_t.chr10     #程式類別 (gzza002)
   DEFINE g_sys           LIKE type_t.chr5      #模組別 (gzza003)
   DEFINE g_chkey         LIKE type_t.chr1      #是否允許更改KEY (gzza006)
   DEFINE g_need_err_log  LIKE type_t.chr1      #是否需要將錯誤訊息寫入log檔 (gzza010)
   DEFINE g_idle_seconds  LIKE type_t.num5      #INPUT(ARRAY)時允許Idle的秒數 (gzza012)
   DEFINE g_gui_type      LIKE type_t.num5      #GUI Type
   DEFINE g_errno         LIKE type_t.chr10     #錯誤訊息代碼
   DEFINE g_success       LIKE type_t.chr1      #sub判斷是否執行成功
   DEFINE g_sub_success   LIKE type_t.num5      #跨元件判斷是否執行成功 (不透過return回傳時使用)
   DEFINE g_errshow       LIKE type_t.num5      #錯誤訊息顯示 TRUE顯示/FALSE不顯示
   DEFINE g_t100debug     LIKE type_t.chr1      #如果=9,顯示DEBUG訊息
   DEFINE g_t100azg0d     LIKE type_t.chr1      #如果=9,顯示DEBUG訊息
   DEFINE g_bgjob         LIKE type_t.chr1      #Background job
   DEFINE g_lang          LIKE type_t.chr6      #介面語言別 (gzzy001)
   DEFINE g_dlang         LIKE type_t.chr6      #資料語言別 (gzzy003)
   DEFINE g_argv          DYNAMIC ARRAY OF STRING     #所有外部參數
   DEFINE g_company       VARCHAR(72)           #公司名稱

   DEFINE g_enterprise    LIKE type_t.num5      #體系 Enterprise 代碼
   DEFINE g_dbs           LIKE type_t.chr21     #實體資料庫名稱
   DEFINE g_site          LIKE type_t.chr10     #營運據點名稱
   DEFINE g_plant         LIKE type_t.chr10     #實體營運中心名稱
   DEFINE g_legal         LIKE type_t.chr10     #法人代碼
   DEFINE g_version       LIKE type_t.chr20     #版本
   DEFINE g_max_rec       LIKE type_t.num10 #5  #Table最大顯示/輸入筆數
   DEFINE g_max_browse    LIKE type_t.num10 #5  #瀏覽器最大顯示筆數

   #作業時間
   DEFINE g_today      LIKE type_t.dat         #系統日期
   DEFINE g_time       LIKE type_t.chr8        #Execution time
   DEFINE g_timezone   LIKE type_t.chr80       #時區
   DEFINE g_lastdat    LIKE type_t.dat         #世界末日

   #執行人員
   DEFINE g_user       LIKE type_t.chr20       #使用者工號
   DEFINE g_account    LIKE type_t.chr20       #使用者編號/帳號
   DEFINE g_roles      STRING                  #使用者角色清單 (串接報表需求)
   DEFINE g_dept       LIKE type_t.chr10       #使用者部門代號
   DEFINE g_grup       LIKE type_t.chr10

   #執行權限
   DEFINE g_data_owner LIKE type_t.chr20       #使用者資料權限
   DEFINE g_data_dept  LIKE type_t.chr10       #部門資料權限
   DEFINE g_data_site  LIKE type_t.chr10       #營運中心資料權限
   DEFINE g_data_group LIKE type_t.chr10       #(to delete)
   DEFINE g_priv_col   DYNAMIC ARRAY OF RECORD #畫面欄位授權資料
            colid      LIKE type_t.chr80,      #  欄位編號
            auth       LIKE type_t.chr1,       #  授權動作 1/不可見 2/加密 3/不可修改
            crypt      LIKE type_t.chr10,      #  加密方法
            type       LIKE type_t.chr10,      #  遮罩取用類型
            idx        LIKE type_t.chr10       #  遮罩啟用指標位置
                       END RECORD
   DEFINE g_progmasked BOOLEAN                 #作業是否已加上欄位遮罩 TRUE/FALSE

   #UI畫面設定
   DEFINE gs_config_path    STRING             #config資料夾的路徑.
   DEFINE gs_4st_path       STRING             #4st檔案預設路徑
   DEFINE gs_4ad_path       STRING             #4ad檔案預設路徑
   DEFINE gs_4sm_path       STRING             #4sm檔案預設路徑
   DEFINE gs_4tb_path       STRING             #4tb檔案預設路徑
   DEFINE gs_4tm_path       STRING             #4tm檔案預設路徑
   DEFINE g_action_choice   STRING             #ON ACTION的名稱
   DEFINE g_show_item_value LIKE type_t.num5   #是否顯現COMBOBOX,RADIOGROUP的項目儲
   DEFINE g_head_disable    LIKE type_t.num5   #單頭目前是否隱藏
   DEFINE g_hidden_4tm      BOOLEAN            #是否不載入TopMenu TRUE:不載入, FALSE:載入
   DEFINE g_hidden_4tb      BOOLEAN            #是否不載入ToolBar TRUE:不載入, FALSE:載入

   DEFINE g_pos        LIKE type_t.chr21
   DEFINE g_mind       LIKE type_t.dat
   DEFINE g_maxd       LIKE type_t.dat

   #顯示錯誤訊息
   DEFINE g_errparam   RECORD
            code      LIKE gzze_t.gzze001,         #錯誤訊息編碼
            extend    STRING,                      #出現在開頭的延伸訊息字串 (有需要再設定)
            popup     BOOLEAN,                     #開窗否（azzi920強制開窗時無作用）
            type      LIKE gzze_t.gzze007,         #訊息類型0:警告, 1:錯誤, 2:資訊（可不設, 依照azzi920預設值）
            replace   DYNAMIC ARRAY OF STRING,     #替換錯誤訊息及建議處理方式中的%變數 (有需要再設定)
            columns   DYNAMIC ARRAY OF STRING,     #欄位清單(對照欄位值清單) (有需要再設定)
            #columns   DYNAMIC ARRAY OF LIKE dzeb_t.dzeb001,  #欄位清單(對照欄位值清單) (有需要再設定)
            #columns   DYNAMIC ARRAY OF LIKE gzzd_t.gzzd003,  #欄位清單(對照欄位值清單) (有需要再設定)
            values    DYNAMIC ARRAY OF STRING,     #欄位值清單(對照欄位清單) (有需要再設定)
            coll_vals DYNAMIC ARRAY OF STRING,     #匯總訊息額外欄位 - 值 (有需要再設定)
            sqlerr    LIKE type_t.num5,            #SQLCA.SQLERRD[2] 或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            exeprog   LIKE type_t.chr20,           #建議執行作業編號 (有需要再設定)
            param     STRING                       #JSON格式的參數  (有需要再設定)
            END RECORD
   #訊息中心
   DEFINE g_msgparam   RECORD
            state      STRING,                     #執行模式                                                
            data       DYNAMIC ARRAY OF STRING,    #表單資料
            rpt_code   STRING,                     #報表驗證碼
            rpt_url    STRING,                     #報表 url
            rpt_file   STRING                      #報表 file                                                  
            END RECORD

   DEFINE g_coll_title DYNAMIC ARRAY OF STRING     #匯總訊息額外欄位 - 標題(限定最多20個欄位) (有需要再設定)
   DEFINE g_errcollect DYNAMIC ARRAY OF RECORD
          code      STRING,                        #訊息代碼
          message   STRING,                        #訊息內容
          adv_msg   STRING,                        #進階訊息
          extra     DYNAMIC ARRAY OF STRING,       #額外欄位資訊
          gzze006   STRING,                        #程式人員詳細訊息
          sqlerrd2  LIKE type_t.num5,              #SQLCA.SQLERRD[2] contains the last SERIAL or the native SQL error code.
          exeprog   LIKE type_t.chr20,             #建議執行作業編號
          param     STRING                         #JSON格式的參數  (有需要再設定)
          END RECORD

   #開窗查詢專用變數
   DEFINE g_qryparam        RECORD
          state             LIKE type_t.chr1,       #程式的狀態(i→INPUT，c→CONSTRUCT，預設為i)
          construct         LIKE type_t.chr1,       #No Use
          reqry             LIKE type_t.num5,       #是否需要先qry再顯示資料(TRUE:需要，FALSE:不需要，預設為FALSE)
          where             STRING,                 #查詢資料的條件(一@般是從gab_file.gab02來設定)
          pagecount         STRING,                 #每頁最大瀏覽筆數
          default1          STRING,                 #開窗之相關欄位一的預設值
          default2          STRING,                 #開窗之相關欄位二的預設值
          default3          STRING,                 #開窗之相關欄位三的預設值
          default4          STRING,                 #開窗之相關欄位四的預設值
          default5          STRING,                 #開窗之相關欄位五的預設值
          default6          STRING,                 #開窗之相關欄位六的預設值
          default7          STRING,                 #開窗之相關欄位七的預設值
          default8          STRING,                 #開窗之相關欄位八的預設值
          default9          STRING,                 #開窗之相關欄位九的預設值
          default10         STRING,                 #開窗之相關欄位十的預設值
          arg1              STRING,                 #查詢資料的條件替換值一@
          arg2              STRING,                 #查詢資料的條件替換值二
          arg3              STRING,                 #查詢資料的條件替換值三
          arg4              STRING,                 #查詢資料的條件替換值四
          arg5              STRING,                 #查詢資料的條件替換值五
          arg6              STRING,                 #查詢資料的條件替換值六
          arg7              STRING,                 #查詢資料的條件替換值七
          arg8              STRING,                 #查詢資料的條件替換值八
          arg9              STRING,                 #查詢資料的條件替換值九
          return1           STRING,                 #回傳資料一
          return2           STRING,                 #回傳資料二
          return3           STRING,                 #回傳資料三
          return4           STRING,                 #回傳資料四
          return5           STRING,                 #回傳資料五
          return6           STRING,                 #回傳資料六
          return7           STRING,                 #回傳資料七
          return8           STRING,                 #回傳資料八
          return9           STRING,                 #回傳資料九
          return10           STRING,                #回傳資料十
          multiret_index    LIKE type_t.num5,       #No Use
          multiret          STRING,                 #No Use
          ordercons         STRING,                 #No Use
          str_array         DYNAMIC ARRAY OF STRING #因應開窗狀態m,接收多組字串資料的多個欄位
                              END RECORD

   #cl_chk_validate.4gl專用變數
   DEFINE g_chkparam        RECORD
          where             STRING,                 #外部額外設定的WHERE條件
          default1          STRING,                 #相關欄位一的預設值
          default2          STRING,                 #相關欄位二的預設值
          default3          STRING,                 #相關欄位三的預設值
          default4          STRING,                 #相關欄位四的預設值
          default5          STRING,                 #相關欄位五的預設值
          default6          STRING,                 #相關欄位六的預設值
          default7          STRING,                 #相關欄位七的預設值
          default8          STRING,                 #相關欄位八的預設值
          default9          STRING,                 #相關欄位九的預設值
          arg1              STRING,                 #外部參數一
          arg2              STRING,                 #外部參數二
          arg3              STRING,                 #外部參數三
          arg4              STRING,                 #外部參數四
          arg5              STRING,                 #外部參數五
          arg6              STRING,                 #外部參數六
          arg7              STRING,                 #外部參數七
          arg8              STRING,                 #外部參數八
          arg9              STRING,                 #外部參數九
          return1           STRING,                 #回傳資料一
          return2           STRING,                 #回傳資料二
          return3           STRING,                 #回傳資料三
          return4           STRING,                 #回傳資料四
          return5           STRING,                 #回傳資料五
          return6           STRING,                 #回傳資料六
          return7           STRING,                 #回傳資料七
          return8           STRING,                 #回傳資料八
          return9           STRING,                 #回傳資料九
          ls_title          STRING,                 #統一顯示在錯誤訊息多語言前面的字串
          err_str           DYNAMIC ARRAY OF STRING #替換錯誤訊息代號和錯誤訊息上的%變數
                            END RECORD
   #cl_jmail.4gl專用變數
   DEFINE g_xml       RECORD
          file        LIKE type_t.chr50,     #XML檔名(不含路徑,檔案產生在$TEMPDIR底下)
          mailserver  LIKE type_t.chr30,     #MAIL SERVER IP
          serverport  LIKE type_t.chr5,      #MAIL SERVER Port
          user        LIKE type_t.chr30,     #MAIL SERVER User
          #passwd      LIKE type_t.chr10,     #MAIL SERVER User Password   #170109-00040#1 mark
          passwd      STRING,                 #MAIL SERVER User Password    #170109-00040#1 add
          subject     VARCHAR(300),          #信件主旨
          body        VARCHAR(100),          #信件本文內容
          attach      LIKE type_t.chr1000,   #信件附件檔路徑
          recipient   LIKE type_t.chr1000,   #收件者
          cc          VARCHAR(500),          #副本
          bcc         VARCHAR(500),          #密件副本
          sender      LIKE type_t.chr50,     #寄件者
          replyto     LIKE type_t.chr1000,   #指定回信人
          htmlbody    LIKE type_t.chr1000,   #Html body
          htmlpath    LIKE type_t.chr100,    #Html path
          priority    LIKE type_t.chr1       #mail 重要等級
                      END RECORD
   DEFINE g_header_idx          LIKE type_t.num10 #5
   DEFINE g_header_cnt          LIKE type_t.num10 #5
   DEFINE g_main_hidden         LIKE type_t.num5   #主頁摺疊
   DEFINE g_worksheet_hidden    LIKE type_t.num5   #瀏覽頁折疊
   DEFINE g_header_hidden       LIKE type_t.num5   #單頭折疊
   DEFINE g_parameters DYNAMIC ARRAY OF RECORD
         para_id    STRING,
         value      STRING
         END RECORD

   DEFINE g_work       DYNAMIC ARRAY OF LIKE type_t.dat #DATE #s_wdays,s_wdays2有需要.
   DEFINE g_intrans    LIKE type_t.chr1       #是否事务中标识 应用元件组设计
   DEFINE g_no_entry   STRING               #修改時不可編輯欄位(azzi850設定)

   #cl_batch_proc.4gl專用變數
   DEFINE ga_batch        DYNAMIC ARRAY OF RECORD
            c_check       LIKE type_t.chr1,   #VARCHAR(1),
            c_item01      VARCHAR(100),
            c_item02      VARCHAR(100),
            c_item03      VARCHAR(100),
            c_item04      VARCHAR(100),
            c_item05      VARCHAR(100),
            c_item06      VARCHAR(100),
            c_item07      VARCHAR(100),
            c_item08      VARCHAR(100),
            c_item09      VARCHAR(100),
            c_item10      VARCHAR(100)
                          END RECORD
   #cl_doc 變數
   DEFINE g_pk_array      DYNAMIC ARRAY OF RECORD
            column        STRING,
            values        STRING
                          END RECORD
   DEFINE g_doc           RECORD
            column1       LIKE type_t.chr10,
            column2       LIKE type_t.chr10,
            column3       LIKE type_t.chr10,
            column4       LIKE type_t.chr10,
            column5       LIKE type_t.chr10,
            value1        LIKE type_t.chr50,     #MOD-960236 modify
            value2        LIKE type_t.chr50,     #MOD-960236 modify
            value3        LIKE type_t.chr50,     #MOD-960236 modify
            value4        LIKE type_t.chr50,     #MOD-960236 modify
            value5        LIKE type_t.chr50      #MOD-960236 modify
                          END RECORD
   #cl_set_focus_form
   DEFINE g_fld_name      LIKE type_t.chr20
   DEFINE g_frm_name      LIKE type_t.chr20

   #單據編號
   DEFINE g_doc_len       LIKE type_t.num5   #單據編號中單別的長度
   DEFINE g_no_sp         LIKE type_t.num5   #單據編號中單號的起始位置
                          #Ex.AAA-12345678, 1的位置"5"就是起始位置
   DEFINE g_no_ep         LIKE type_t.num5   #單據編號的結束位置
                          #Ex.AAA-12345678, 8的位置"12"就是結束位置
   DEFINE g_sn_sp         LIKE type_t.num5   #單據編號流水號起始位置 FUN-A30020
                          #Ex.AAA-PPPPP12345678, 1的位置"10"就是流水號起始位置
                          #無PlantCode編入, 則g_no_sp = g_sn_sp
   #多語轉換系統參數
   #DEFINE g_zx14          LIKE zx_file.zx14     #此使用者是否使用多語自動開窗功能
    DEFINE g_dyloc2sfld    LIKE type_t.chr1   #確認是否為動態切換語言別所觸發 FUN-560086
    DEFINE g_cuelang       LIKE type_t.num5   #FUN-580026
    DEFINE g_bgjob_msgfile STRING                #批次作@業背景執行 FUN-610104
   #DEFINE g_ui_setting    LIKE gav_file.gav11   #自定義欄位功能FUN-710055

   #統整錯誤訊息
   DEFINE g_showmsg       STRING                #統整錯誤訊息
   DEFINE g_bgerr         LIKE type_t.num5   #是否啟用統整錯誤訊息的旗標
   DEFINE g_totsuccess    LIKE type_t.chr1   #統整錯誤訊息用來記錄g_success的旗標
   DEFINE g_err_msg       DYNAMIC ARRAY OF RECORD
            fld1           STRING,
            fld2           STRING,
            fld3           STRING,
            fld4           STRING,
            fld5           STRING
                           END RECORD
   #修改歷程
   DEFINE g_logc     DYNAMIC ARRAY OF RECORD
             logc001  LIKE logc_t.logc001,
             logc002  LIKE logc_t.logc002,
             logc003  DATETIME YEAR TO SECOND,
             logc004  LIKE logc_t.logc004,
             logc006  LIKE logc_t.logc006
       END RECORD

   #報表列印參數設定.
   DEFINE g_rlang         LIKE gzzy_t.gzzy001      #報表列印參數設定.Language
   DEFINE g_pdate         LIKE type_t.dat          #報表列印參數設定.Print date
   DEFINE g_ptime         LIKE type_t.chr8         #報表列印參數設定.Print time
   DEFINE g_prtway        LIKE type_t.chr1         #報表列印參數設定.Print way
   DEFINE g_copies        LIKE type_t.chr1         #報表列印參數設定.Report copies you want

   #報表背景作業功能
   DEFINE g_reportid      LIKE gzgf_t.gzgf000      #報表背景執行需選擇樣板

   #報表變數
   DEFINE g_rep_wcchp     STRING                   #報表列印條件中文化 #150904-00005#2 add
   DEFINE g_rs_printer    STRING                   #Server直接送印,報表主機印表機名稱 #150921-00060#1 add

   &include "erp/top_global_expand.inc"

   #匯出Excel功能
   DEFINE g_export_node   DYNAMIC ARRAY OF om.DomNode
   DEFINE g_export_id     DYNAMIC ARRAY OF STRING

   #單據程式設定作業的where condition
   DEFINE g_rep_wc        STRING
   DEFINE g_rep_type      STRING  #回傳報表元件的序號
   
   #ETL Job 參數設定
   DEFINE g_etlparam DYNAMIC ARRAY OF RECORD
         para_id    STRING,
         type       STRING,
         value      STRING
         END RECORD

   #POI 參數設定
   DEFINE g_xls_type  STRING    #1:xlsx,2:xls
END GLOBALS

